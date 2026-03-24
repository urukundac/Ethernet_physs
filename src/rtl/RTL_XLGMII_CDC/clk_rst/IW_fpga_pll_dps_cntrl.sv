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
// File Name:     $RCSfile: IW_fpga_pll_dps_cntrl.sv.rca $
// File Revision: $Revision: 1.1 $
// Created by:    Gregory James
// Updated by:    $Author: gjames $ $Date: Mon Oct 26 01:28:50 2015 $
//------------------------------------------------------------------------------

`timescale  1ns/1ps


module  IW_fpga_pll_dps_cntrl  #(
    parameter PHASE_EN_PULSE_W                  = 2 //Number of clocks to assert pll_phase_en. Should be at least 2 clocks.
  , parameter NUM_PLL_CLOCKS                    = 1
  , parameter WAIT_FOR_PHASE_DONE_EDGE_N_LEVEL  = 0 //1->The FSM will wait for 0->1 transition/edge on pll_phase_done
                                                    //0->The FSM Will wait until pll_phase_done level is high
  , parameter MC_FAST_CLK_SHIFT                 = 0 //0->Shift by 1 (supported by gal sync)
                                                    //1->Shift by 4 to make simulation fast (supported by MC clk sync)
 
) (

    input   wire  clk
  , input   wire  rst_n

  //Control
  , input   wire          dps_trig
  , input   wire          dps_updn
  , input   wire  [31:0]  dps_num_shifts
  , input   wire  [4:0]   dps_clk_tap [NUM_PLL_CLOCKS-1:0]

  //PLL Dynamic Phase Shift Control/Status signals
  , output  reg           dps_in_prog
  , output  wire  [2:0]   dps_fsm_pstate

  , output  reg           pll_updn
  , output  wire  [4:0]   pll_cnt_sel
  , output  reg           pll_phase_en
  , input   wire          pll_phase_done
  , output  wire  [2:0]   pll_out_shift

);

  /*  Internal Parameters */
  localparam  PHASE_EN_CNTR_W = $clog2(PHASE_EN_PULSE_W)  + 1;
  localparam  CLK_TAP_IDX_W   = $clog2(NUM_PLL_CLOCKS)    + 1;

  /*  Internal  Variables */
  reg [2:0]   pll_phase_done_dd_sync;
  wire        pll_phase_done_sync;
  reg [PHASE_EN_CNTR_W-1:0] phase_en_cntr;
  wire        phase_en;
  reg [31:0]  shift_num_cntr;
  logic       last_shift_num;
  reg [CLK_TAP_IDX_W-1:0] dps_clk_tap_idx;
  wire        last_dps_clk_tap_idx;


  /*  FSM State */
  parameter [2:0] IDLE_S                = 0,
                  WAIT_FOR_TRIGGER_S    = 1,
                  SETUP_PARAMS_S        = 2,
                  SHIFT_PHASE_S         = 3,
                  WAIT_FOR_PHASE_DONE_S = 4;

  reg [2:0] fsm_pstate, next_state;

  assign  dps_fsm_pstate  = fsm_pstate;

  //synthesis translate_off
  reg [8*24:0]    state_name;
  
  always @ (fsm_pstate)
  begin
    case (fsm_pstate)
      IDLE_S                : state_name  = "IDLE_S";
      WAIT_FOR_TRIGGER_S    : state_name  = "WAIT_FOR_TRIGGER_S";
      SETUP_PARAMS_S        : state_name  = "SETUP_PARAMS_S";
      SHIFT_PHASE_S         : state_name  = "SHIFT_PHASE_S";
      WAIT_FOR_PHASE_DONE_S : state_name  = "WAIT_FOR_PHASE_DONE_S";
      default               : state_name  = "INVALID!";
    endcase
  end
  //synthesis translate_on



  /*  FSM Sequential  Logic */
  always@(posedge clk,  negedge rst_n)
  begin
    if(~rst_n)
    begin
      fsm_pstate              <=  IDLE_S;
      pll_phase_done_dd_sync  <=  0;
      phase_en_cntr           <=  0;
      pll_phase_en            <=  0;
      pll_updn                <=  0;
      dps_clk_tap_idx         <=  0;
      dps_in_prog             <=  0;
      if (MC_FAST_CLK_SHIFT== 1)
        shift_num_cntr          <=  4;
      else
        shift_num_cntr          <=  1;
    end
    else
    begin
      fsm_pstate              <=  next_state;

      pll_phase_done_dd_sync  <=  {pll_phase_done_dd_sync[1:0],pll_phase_done};

      case(fsm_pstate)

        IDLE_S  :
        begin
          phase_en_cntr       <=  0;
          pll_phase_en        <=  0;
          dps_clk_tap_idx     <=  0;
          dps_in_prog         <=  0;
          if (MC_FAST_CLK_SHIFT== 1)
            shift_num_cntr          <=  4;
          else
            shift_num_cntr          <=  1;
        end

        WAIT_FOR_TRIGGER_S  :
        begin
          dps_clk_tap_idx     <=  0;
          dps_in_prog         <=  dps_trig;
          pll_updn            <=  dps_trig  ? dps_updn  : pll_updn;
        end

        SETUP_PARAMS_S  :
        begin
          phase_en_cntr       <=  phase_en_cntr + 1'b1;
          pll_phase_en        <=  1'b1;
        end

        SHIFT_PHASE_S :
        begin
          //Increment phase_en_cntr  for PHASE_EN_PULSE_W cycles, then freeze.
          phase_en_cntr       <=  phase_en  ? phase_en_cntr : phase_en_cntr + 1'b1;

          pll_phase_en        <=  ~phase_en;
        end

        WAIT_FOR_PHASE_DONE_S :
        begin
          phase_en_cntr       <=  0;

          if(pll_phase_done_sync)
          begin
            if (MC_FAST_CLK_SHIFT== 1) begin
              if(last_dps_clk_tap_idx)
                shift_num_cntr    <=  shift_num_cntr  + 4;
              else
                shift_num_cntr <= shift_num_cntr + 4;
            end else begin
              shift_num_cntr    <=  shift_num_cntr  + last_dps_clk_tap_idx;
            end
            dps_clk_tap_idx   <=  last_dps_clk_tap_idx  ? 0   : dps_clk_tap_idx + 1'b1;
            dps_in_prog       <=  (last_shift_num & last_dps_clk_tap_idx) ? 1'b0  : dps_in_prog;
          end
        end

      endcase
    end
  end

  generate
    if(WAIT_FOR_PHASE_DONE_EDGE_N_LEVEL)
    begin
      assign  pll_phase_done_sync   = ~pll_phase_done_dd_sync[2]  & pll_phase_done_dd_sync[1];
    end
    else
    begin
      assign  pll_phase_done_sync   = pll_phase_done_dd_sync[2];
    end
  endgenerate

  generate
  if (MC_FAST_CLK_SHIFT == 1)
    always@(*)
    begin
      if(dps_num_shifts[1:0] == 0)
        last_shift_num        = ((shift_num_cntr >>2) ==  (dps_num_shifts >>2))   ? 1'b1  : 1'b0;
      else
        last_shift_num        = ((shift_num_cntr >>2) ==  (dps_num_shifts >>2)+1)   ? 1'b1  : 1'b0;
    end
  else
    always@(*)
      last_shift_num        = (shift_num_cntr ==  dps_num_shifts)   ? 1'b1  : 1'b0;
  endgenerate

  assign  phase_en              = (phase_en_cntr  ==  PHASE_EN_PULSE_W) ? 1'b1  : 1'b0;
  assign  last_dps_clk_tap_idx  = (dps_clk_tap_idx  ==  NUM_PLL_CLOCKS-1)   ? 1'b1  : 1'b0;

  assign  pll_cnt_sel           = dps_clk_tap[dps_clk_tap_idx];

  /*  FSM Combinational Logic */
  always@(*)
  begin
    next_state                =   fsm_pstate;

    case(fsm_pstate)

      IDLE_S  :
      begin
        next_state            =   WAIT_FOR_TRIGGER_S;
      end

      WAIT_FOR_TRIGGER_S  :
      begin
        next_state            = dps_trig  ? SETUP_PARAMS_S  : WAIT_FOR_TRIGGER_S;
      end

      SETUP_PARAMS_S  :
      begin
        next_state            = SHIFT_PHASE_S;
      end

      SHIFT_PHASE_S :
      begin
        //next_state            = phase_en  & ~pll_phase_done_sync  ? WAIT_FOR_PHASE_DONE_S : SHIFT_PHASE_S;
        next_state            = phase_en  ? WAIT_FOR_PHASE_DONE_S : SHIFT_PHASE_S;
      end

      WAIT_FOR_PHASE_DONE_S :
      begin
        if(pll_phase_done_sync)
        begin
          next_state          = last_shift_num  & last_dps_clk_tap_idx  ? IDLE_S  : SETUP_PARAMS_S;
        end
      end

    endcase
  end
  
  generate
  if (MC_FAST_CLK_SHIFT==1) begin
    assign pll_out_shift = 3'b100;
  end
  else begin
    assign pll_out_shift = 3'b001;
  end
  endgenerate

endmodule //IW_fpga_pll_dps_cntrl

//------------------------------------------------------------------------------
// Change History:
//
// $Log: IW_fpga_pll_dps_cntrl.sv.rca $
// 
//  Revision: 1.1 Mon Oct 26 01:28:50 2015 gjames
//  Initial Commit
// 
// 
//------------------------------------------------------------------------------

