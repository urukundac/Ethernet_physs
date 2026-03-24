//----------------------------------------------------------------------------------------------------------------
//                               INTEL CONFIDENTIAL
//           Copyright 2013-2014 Intel Corporation All Rights Reserved. 
// 
// The source code contained or described herein and all documents related to the source code ("Material")
// are owned by Intel Corporation or its suppliers or licensors. Title to the Material remains with Intel
// Corporation or its suppliers and licensors. The Material contains trade secrets and proprietary and confidential
// information of Intel or its suppliers and licensors. The Material is protected by worldwide copyright and trade
// secret laws and treaty provisions. No part of the Material may be used, copied, reproduced, modified, published,
// uploaded, posted, transmitted, distributed, or disclosed in any way without Intel's prior express written
// permission.
// 
// No license under any patent, copyright, trade secret or other intellectual property right is granted to or
// conferred upon you by disclosure or delivery of the Materials, either expressly, by implication, inducement,
// estoppel or otherwise. Any license under such intellectual property rights must be express and approved by
// Intel in writing.
//----------------------------------------------------------------------------------------------------------------
// Version and Release Control Information:
//
// File Name:     $RCSfile: IW_fpga_pll_dps_sync.sv.rca $
// File Revision: $Revision: 1.1 $
// Created by:    Gregory James
// Updated by:    $Author: gjames $ $Date: Mon Oct 26 01:28:50 2015 $
//------------------------------------------------------------------------------

`timescale  1ns/1ps

module IW_fpga_pll_dps_sync #(
    parameter MODULE_NAME                       = "IW_fpga_pll_dps_sync"
  , parameter PHASE_EN_PULSE_W                  = 2 //Number of clocks to assert pll_phase_en. Should be at least 2 clocks.
  , parameter NUM_PLL_CLOCKS                    = 1
  , parameter NUM_SHIFTS_PER_CYCLE              = 1 //Number of shifts per cycle
  , parameter MIN_CLK_SYNC_FAIL_CYCLES          = 5 //Minimum number of consecutive cycles that result in clk_sync_mismatch=1
  , parameter MIN_CLK_SYNC_PASS_CYCLES          = 5 //Minimum number of consecutive cycles that result in clk_sync_stable=1
  , parameter MAX_LOCK_FAIL_CYCLES              = 3 //Maximum number of consecutive fail cycles allowed in LOCK_DPS_S
  , parameter LOCK_DPS_TAP                      = 0 //0(default)-> Lock to 50% of pass window
                                                    //1->Lock to 25% of pass window
                                                    //2->Lock to 75% of pass window
  , parameter WAIT_FOR_PHASE_DONE_EDGE_N_LEVEL  = 0 //1->The FSM will wait for 0->1 transition/edge on pll_phase_done
                                                    //0->The FSM Will wait until pll_phase_done level is high
  , parameter CNTR_W                            = 32


) (
    input   wire  clk
  , input   wire  rst_n

  //Clock sync control/status ; these are async!
  , input   wire                          clk_sync_mismatch
  , input   wire                          clk_sync_stable
  , input   wire                          clk_sync_start_timeout
  , output  wire                          pll_stable_cnt_sel

  //List of PLL outputs to shift in order
  , input   wire  [4:0]   pll_clk_tap [NUM_PLL_CLOCKS-1:0]

  //PLL Dynamic Phase Shift Control/Status signals
  , output  wire          pll_updn
  , output  wire  [4:0]   pll_cnt_sel
  , output  wire          pll_phase_en
  , input   wire          pll_phase_done

  //DPS Status
  , output  reg                 rst_clk_sync_n
  , output  reg                 dps_locked
  , output  wire  [2:0]         dps_cntrl_fsm_pstate
  , output  wire  [2:0]         dps_sync_fsm_pstate
  , output  wire  [CNTR_W-1:0]  dps_pass_win_len

  //Debug
  , output  reg   [CNTR_W-1:0]  dps_find_fail0_shift_cnt
  , output  reg   [CNTR_W-1:0]  dps_find_pass0_shift_cnt
  , output  reg   [CNTR_W-1:0]  dps_find_fail1_shift_cnt
  , output  reg   [CNTR_W-1:0]  dps_lock_dps_shift_cnt
  , output  wire  [CNTR_W-1:0]  dps_consec_sync_pass_cnt
  , output  wire  [CNTR_W-1:0]  dps_consec_sync_fail_cnt
  , output  wire  [CNTR_W-1:0]  dps_lock_target_cnt
  , output  reg   [CNTR_W-1:0]  dps_lock_slip_cnt

  , input   wire  [3:0]         dps_mode
  , input   wire                dps_step_forward_p
  , input   wire  [CNTR_W-1:0]  dps_step_count
  , output  reg   [CNTR_W-1:0]  dps_step_counter
  , output  reg                 dps_pause
  , output  wire  [2:0]         pll_out_shift

);

  /*  Internal  Parameters  */
  localparam  DPS_UP_DIR    = 1'b1;
  localparam  DPS_DOWN_DIR  = ~DPS_UP_DIR;

  /*  Internal Variables  */
  reg                 dps_trig;
  reg                 dps_updn;
  wire                dps_cntrl_in_prog;
  reg                 dps_cntrl_in_prog_1d;
  reg                 dps_cntrl_in_prog_negedge_det;
  reg   [CNTR_W-1:0]  consec_sync_pass_cnt;
  reg   [CNTR_W-1:0]  consec_sync_fail_cnt;
  reg   [2:0]         clk_sync_mismatch_sync;
  reg   [2:0]         clk_sync_stable_sync;
  reg   [1:0]         clk_sync_start_timeout_sync;
  wire                clk_sync_mismatch_pulse;
  wire                clk_sync_stable_pulse;
  reg   [CNTR_W-1:0]  pass_win_cntr;
  wire  [CNTR_W+1:0]  pass_win_cntr_x3;
  reg   [CNTR_W-1:0]  lock_dps_target;
  reg                 clr_consec_cntrs;
  wire                consec_sync_pass_cnt_min_valid;
  wire                consec_sync_fail_cnt_min_valid;
  wire                consec_sync_pass_lock_done;
  wire                consec_sync_lock_fail_valid;
  wire                dps_lock_shift_exceeds_win;
  reg                 dps_pause_c;

  /*  DPS Modes */
  parameter [3:0] NORMAL_M              = 0,
                  STEP_M                = 1;

  /*  FSM State */
  parameter [2:0] IDLE_S                = 0,
                  WAIT_FOR_SYNC_LOSS_S  = 1,
                  FIND_FAIL_POINT_0_S   = 2,
                  FIND_PASS_POINT_0_S   = 3,
                  FIND_FAIL_POINT_1_S   = 4,
                  LOCK_DPS_S            = 5,
                  WAIT_ON_UPSTREAM_S    = 6;

  reg [2:0] fsm_pstate, next_state;

  assign  dps_sync_fsm_pstate = fsm_pstate;

  //synthesis translate_off
  reg [8*32:0]    state_name;
  
  always @ (fsm_pstate)
  begin
    case (fsm_pstate)
      IDLE_S                : state_name  = "IDLE_S";
      WAIT_FOR_SYNC_LOSS_S  : state_name  = "WAIT_FOR_SYNC_LOSS_S";
      FIND_FAIL_POINT_0_S   : state_name  = "FIND_FAIL_POINT_0_S";
      FIND_PASS_POINT_0_S   : state_name  = "FIND_PASS_POINT_0_S";
      FIND_FAIL_POINT_1_S   : state_name  = "FIND_FAIL_POINT_1_S";
      LOCK_DPS_S            : state_name  = "LOCK_DPS_S";
      WAIT_ON_UPSTREAM_S    : state_name  = "WAIT_ON_UPSTREAM_S";
      default               : state_name  = "INVALID!";
    endcase

    $display("@%t|%m|INFO| fsm_pstate = %s",$time,state_name);
  end
  //synthesis translate_on


  //Calculate 3x of pass_win_cntr = pass_win_cntr + 2*pass_win_cntr
  assign  pass_win_cntr_x3  = {1'b0,pass_win_cntr}  + {pass_win_cntr,1'b0};

  //Check if the consecutive pass/fail counters has met the min values
  assign  consec_sync_pass_cnt_min_valid  = (consec_sync_pass_cnt >=  MIN_CLK_SYNC_PASS_CYCLES) ? 1'b1  : 1'b0;
  assign  consec_sync_fail_cnt_min_valid  = (consec_sync_fail_cnt >=  MIN_CLK_SYNC_FAIL_CYCLES) ? 1'b1  : 1'b0;
  assign  consec_sync_pass_lock_done      = (consec_sync_pass_cnt >=  lock_dps_target)          ? 1'b1  : 1'b0;
  assign  consec_sync_lock_fail_valid     = (consec_sync_fail_cnt >=  MAX_LOCK_FAIL_CYCLES)     ? 1'b1  : 1'b0;

  //Check if the shift-backs in LOCK_DPS_S exceeds the window size
  assign  dps_lock_shift_exceeds_win      = (dps_lock_dps_shift_cnt > dps_pass_win_len) ? 1'b1  : 1'b0;

  /*  FSM Sequential  Logic */
  always@(posedge clk,  negedge rst_n)
  begin
    if(~rst_n)
    begin
      `ifdef  FPGA_DPS_FAST_SYNC
        fsm_pstate                  <=  WAIT_FOR_SYNC_LOSS_S;
      `else
        fsm_pstate                  <=  IDLE_S;
      `endif
      consec_sync_pass_cnt          <=  0;
      consec_sync_fail_cnt          <=  0;
      clk_sync_mismatch_sync        <=  0;
      clk_sync_stable_sync          <=  0;
      clk_sync_start_timeout_sync   <=  0;
      dps_trig                      <=  0;
      dps_updn                      <=  DPS_DOWN_DIR;
      pass_win_cntr                 <=  0;
      lock_dps_target               <=  0;
      dps_locked                    <=  0;
      rst_clk_sync_n                <=  0;
      dps_find_fail0_shift_cnt      <=  0;
      dps_find_pass0_shift_cnt      <=  0;
      dps_find_fail1_shift_cnt      <=  0;
      dps_lock_dps_shift_cnt        <=  0;
      dps_lock_slip_cnt             <=  0;
      clr_consec_cntrs              <=  1'b1;

      dps_cntrl_in_prog_1d          <=  0;
      dps_cntrl_in_prog_negedge_det <=  0;

      dps_step_counter              <=  0;
      dps_pause                     <=  0;
    end
    else
    begin
      fsm_pstate                    <=  next_state;

      clk_sync_mismatch_sync        <=  {clk_sync_mismatch_sync[1:0],clk_sync_mismatch};
      clk_sync_stable_sync          <=  {clk_sync_stable_sync[1:0],clk_sync_stable};
      clk_sync_start_timeout_sync   <=  {clk_sync_start_timeout_sync[0:0],clk_sync_start_timeout};

      if(clk_sync_mismatch_pulse  | clr_consec_cntrs)
      begin
        consec_sync_pass_cnt        <=  0;
      end
      else
      begin
        consec_sync_pass_cnt        <=  (&consec_sync_pass_cnt) ? consec_sync_pass_cnt  : consec_sync_pass_cnt  + clk_sync_stable_pulse;
      end

      if(clk_sync_stable_pulse  | clr_consec_cntrs)
      begin
        consec_sync_fail_cnt        <=  0;
      end
      else
      begin
        consec_sync_fail_cnt        <=  (&consec_sync_fail_cnt) ? consec_sync_fail_cnt  : consec_sync_fail_cnt  + clk_sync_mismatch_pulse;
      end

      /*  Lock DPS Target Logic */
      if(fsm_pstate ==  FIND_FAIL_POINT_1_S)
      begin
        lock_dps_target             <=  (LOCK_DPS_TAP ==  2)  ? {2'b0,pass_win_cntr[CNTR_W-1:2]}  : //75% of Pass Window
                                        (LOCK_DPS_TAP ==  1)  ? pass_win_cntr_x3[CNTR_W+1:2]      : //25% of Pass Window
                                                                {1'b0,pass_win_cntr[CNTR_W-1:1]}  ; //50% of Pass Window
      end

      dps_cntrl_in_prog_1d          <=  dps_cntrl_in_prog;
      dps_cntrl_in_prog_negedge_det <=  ~dps_cntrl_in_prog  & dps_cntrl_in_prog_1d;

      /*  DPS Stepping Logic  */
      if(dps_mode ==  STEP_M)
      begin
        if(dps_pause_c)
        begin
          dps_step_counter    <=  dps_step_forward_p  ? dps_step_count  : {CNTR_W{1'b0}};
        end
        else
        begin
          dps_step_counter    <=  dps_step_counter  - dps_cntrl_in_prog_negedge_det;
        end
      end
      else
      begin
        dps_step_counter      <=  {CNTR_W{1'b0}};
      end

      dps_pause               <=  dps_pause_c;

      case(fsm_pstate)

        IDLE_S  : //Assume sync loss on reset
        begin
          rst_clk_sync_n      <=  0;
          dps_locked          <=  0;
          dps_trig            <=  ~dps_pause;
          dps_updn            <=  DPS_DOWN_DIR;
          pass_win_cntr       <=  0;
          clr_consec_cntrs    <=  1'b1;

          dps_find_fail0_shift_cnt  <=  0;
          dps_find_pass0_shift_cnt  <=  0;
          dps_find_fail1_shift_cnt  <=  0;
          dps_lock_dps_shift_cnt    <=  0;
        end

        WAIT_FOR_SYNC_LOSS_S  :
        begin
          rst_clk_sync_n      <=  dps_pause ? ~dps_step_forward_p : ~clk_sync_mismatch_sync[2];
          dps_locked          <=  ~clk_sync_mismatch_sync[2];
          dps_trig            <=  dps_pause ? 1'b0  : clk_sync_mismatch_sync[2];
          dps_updn            <=  DPS_DOWN_DIR;
          pass_win_cntr       <=  clk_sync_mismatch_sync[2] ? 0 : pass_win_cntr;
          clr_consec_cntrs    <=  clk_sync_mismatch_sync[2];

          if(clk_sync_mismatch_sync[2]) //Reset debug counters
          begin
            dps_find_fail0_shift_cnt  <=  0;
            dps_find_pass0_shift_cnt  <=  0;
            dps_find_fail1_shift_cnt  <=  0;
            dps_lock_dps_shift_cnt    <=  0;
          end
        end

        FIND_FAIL_POINT_0_S :
        begin
          rst_clk_sync_n      <=  dps_pause ? ~dps_step_forward_p : ~dps_cntrl_in_prog;

          if(dps_pause)
          begin
            dps_trig          <=  1'b0;
          end
          else
          begin
            dps_trig          <=  consec_sync_fail_cnt_min_valid ? clk_sync_mismatch_pulse : clk_sync_mismatch_pulse | clk_sync_stable_pulse;
          end

          dps_updn            <=  consec_sync_fail_cnt_min_valid & clk_sync_mismatch_pulse ? DPS_UP_DIR  : DPS_DOWN_DIR;
          clr_consec_cntrs    <=  consec_sync_fail_cnt_min_valid & clk_sync_mismatch_pulse;

          dps_find_fail0_shift_cnt  <=  (dps_find_fail0_shift_cnt ==  {CNTR_W{1'b1}}) ? dps_find_fail0_shift_cnt  : dps_find_fail0_shift_cnt  + dps_trig;
        end

        FIND_PASS_POINT_0_S :
        begin
          rst_clk_sync_n      <=  dps_pause ? ~dps_step_forward_p : ~dps_cntrl_in_prog;
          dps_trig            <=  dps_pause ? 1'b0  : clk_sync_mismatch_pulse | clk_sync_stable_pulse;
          dps_updn            <=  DPS_UP_DIR;
          clr_consec_cntrs    <=  consec_sync_pass_cnt_min_valid  & clk_sync_stable_pulse;

          dps_find_pass0_shift_cnt  <=  (dps_find_pass0_shift_cnt ==  {CNTR_W{1'b1}}) ? dps_find_pass0_shift_cnt  : dps_find_pass0_shift_cnt  + dps_trig;
        end

        FIND_FAIL_POINT_1_S :
        begin
          rst_clk_sync_n      <=  dps_pause ? ~dps_step_forward_p : ~dps_cntrl_in_prog;

          if(dps_pause)
          begin
            dps_trig          <=  1'b0;
          end
          else
          begin
            dps_trig          <=  consec_sync_fail_cnt_min_valid ? clk_sync_mismatch_pulse : clk_sync_mismatch_pulse | clk_sync_stable_pulse;
          end

          dps_updn            <=  consec_sync_fail_cnt_min_valid & clk_sync_mismatch_pulse ? DPS_DOWN_DIR  : DPS_UP_DIR;
          pass_win_cntr       <=  pass_win_cntr  + clk_sync_stable_pulse;
          clr_consec_cntrs    <=  clk_sync_mismatch_pulse;

          dps_find_fail1_shift_cnt  <=  (dps_find_fail1_shift_cnt ==  {CNTR_W{1'b1}}) ? dps_find_fail1_shift_cnt  : dps_find_fail1_shift_cnt  + dps_trig;
        end

        LOCK_DPS_S  :
        begin
          rst_clk_sync_n      <=  dps_pause ? ~dps_step_forward_p : (~dps_cntrl_in_prog  | (consec_sync_lock_fail_valid  | dps_lock_shift_exceeds_win));

          if(dps_pause)
          begin
            dps_trig          <=  1'b0;
          end
          else
          begin
            dps_trig          <=  consec_sync_pass_lock_done  ? 1'b0  : clk_sync_mismatch_pulse | clk_sync_stable_pulse;
          end

          dps_updn            <=  DPS_DOWN_DIR;
          dps_locked          <=  consec_sync_pass_lock_done  ? clk_sync_stable_pulse : 1'b0;
          clr_consec_cntrs    <=  consec_sync_pass_lock_done  ? clk_sync_stable_pulse : 1'b0;

          dps_lock_dps_shift_cnt  <=  (dps_lock_dps_shift_cnt ==  {CNTR_W{1'b1}}) ? dps_lock_dps_shift_cnt  : dps_lock_dps_shift_cnt  + dps_trig;
        end

        WAIT_ON_UPSTREAM_S  : //Hold everything
        begin
          rst_clk_sync_n      <=  1'b1; //The count de-mux logic needs to work to get out of here
          dps_locked          <=  0;
          dps_trig            <=  0;
          dps_updn            <=  DPS_DOWN_DIR;
          pass_win_cntr       <=  0;
          clr_consec_cntrs    <=  1'b1;

          dps_find_fail0_shift_cnt  <=  0;
          dps_find_pass0_shift_cnt  <=  0;
          dps_find_fail1_shift_cnt  <=  0;
          dps_lock_dps_shift_cnt    <=  0;
        end

      endcase

      //Slip Counter logic
      if(clk_sync_start_timeout_sync[1])
      begin
        dps_lock_slip_cnt     <=  0;
      end
      else if(fsm_pstate  ==  LOCK_DPS_S)
      begin
        dps_lock_slip_cnt     <=  dps_lock_slip_cnt + (consec_sync_lock_fail_valid  | dps_lock_shift_exceeds_win);
      end
    end
  end

  //DPS Pause condition
  always@(*)
  begin
    if(dps_mode ==  STEP_M)
    begin
      dps_pause_c = (dps_step_counter ==  0)  ? 1'b1  : 1'b0;
    end
    else
    begin
      dps_pause_c = 1'b0;
    end
  end

  //Derive pulses
  assign  clk_sync_mismatch_pulse = ~clk_sync_mismatch_sync[2]  &   clk_sync_mismatch_sync[1];
  assign  clk_sync_stable_pulse   = ~clk_sync_stable_sync[2]    &   clk_sync_stable_sync[1];

  //Assign Debug counters
  assign  dps_consec_sync_pass_cnt  = consec_sync_pass_cnt;
  assign  dps_consec_sync_fail_cnt  = consec_sync_fail_cnt;
  assign  dps_lock_target_cnt       = lock_dps_target;


  /*  FSM Combinational Logic */
  always@(*)
  begin
    next_state                =   fsm_pstate;

    if(clk_sync_start_timeout_sync[1])  //This indicates that the upstream node has not locked &
    begin                               //is continuosly transmitting zeros; no point trying to lock
      next_state              =   WAIT_ON_UPSTREAM_S;
    end
    else
    begin
      case(fsm_pstate)

        IDLE_S  : //Find the window on power on reset
        begin
          next_state          = FIND_FAIL_POINT_0_S;
        end

        WAIT_FOR_SYNC_LOSS_S  :
        begin
          next_state          = clk_sync_mismatch_sync[2] ? FIND_FAIL_POINT_0_S : WAIT_FOR_SYNC_LOSS_S;
        end

        FIND_FAIL_POINT_0_S : //Shift the PLL until MIN_CLK_SYNC_FAIL_CYCLES consecutive fails
        begin
          next_state          = consec_sync_fail_cnt_min_valid  & clk_sync_mismatch_pulse ? FIND_PASS_POINT_0_S : FIND_FAIL_POINT_0_S;
        end

        FIND_PASS_POINT_0_S : //Reverse direction & shift the PLL until MIN_CLK_SYNC_PASS_CYCLES consecutive passes
        begin
          next_state          = consec_sync_pass_cnt_min_valid  & clk_sync_stable_pulse   ? FIND_FAIL_POINT_1_S : FIND_PASS_POINT_0_S;
        end

        FIND_FAIL_POINT_1_S : //Shift the PLL until MIN_CLK_SYNC_FAIL_CYCLES consecutive fails
        begin
          next_state          =  clk_sync_mismatch_pulse ? LOCK_DPS_S  : FIND_FAIL_POINT_1_S;
        end

        LOCK_DPS_S  : //Reverse direction & lock into pass window
        begin
          if(consec_sync_lock_fail_valid  | dps_lock_shift_exceeds_win) //Check for slip
          begin
            next_state        = IDLE_S; //Restart the whole process
          end
          else
          begin
            next_state        = consec_sync_pass_lock_done  & clk_sync_stable_pulse  ? WAIT_FOR_SYNC_LOSS_S : LOCK_DPS_S;
          end
        end

        WAIT_ON_UPSTREAM_S  :
        begin
          next_state          = IDLE_S;
        end

      endcase
    end
  end

  assign  pll_stable_cnt_sel  = (fsm_pstate ==  LOCK_DPS_S) ? 1'b1  : 1'b0;


  assign  dps_pass_win_len  = pass_win_cntr;


  /*  Instantiate PLL Dynamic Phase Shift Controller  */
  IW_fpga_pll_dps_cntrl  #(
     .PHASE_EN_PULSE_W                  (PHASE_EN_PULSE_W)
    ,.NUM_PLL_CLOCKS                    (NUM_PLL_CLOCKS)
    ,.WAIT_FOR_PHASE_DONE_EDGE_N_LEVEL  (WAIT_FOR_PHASE_DONE_EDGE_N_LEVEL)

  ) u_IW_fpga_pll_dps_cntrl (

     .clk               (clk)
    ,.rst_n             (rst_n)

    ,.dps_trig          (dps_trig)
    ,.dps_updn          (dps_updn)
    ,.dps_num_shifts    (NUM_SHIFTS_PER_CYCLE)
    ,.dps_clk_tap       (pll_clk_tap)

    ,.dps_in_prog       (dps_cntrl_in_prog)
    ,.dps_fsm_pstate    (dps_cntrl_fsm_pstate)

    ,.pll_updn          (pll_updn)
    ,.pll_cnt_sel       (pll_cnt_sel)
    ,.pll_phase_en      (pll_phase_en)
    ,.pll_phase_done    (pll_phase_done)
    ,.pll_out_shift     (pll_out_shift)

  );



endmodule //IW_fpga_pll_dps_sync

//------------------------------------------------------------------------------
// Change History:
//
// $Log: IW_fpga_pll_dps_sync.sv.rca $
// 
//  Revision: 1.1 Mon Oct 26 01:28:50 2015 gjames
//  Initial Commit
// 
// 
//------------------------------------------------------------------------------

