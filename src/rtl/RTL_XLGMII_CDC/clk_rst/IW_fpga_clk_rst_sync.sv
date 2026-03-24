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
// File Name:     $RCSfile: IW_fpga_clk_rst_sync.sv.rca $
// File Revision: $Revision: 1.3 $
// Created by:    Gregory James
// Updated by:    $Author: gjames $ $Date: Wed Feb 24 00:05:54 2016 $
//------------------------------------------------------------------------------

`timescale  1ns/1ps

module  IW_fpga_clk_rst_sync #(
    parameter MODULE_NAME             = "IW_fpga_clk_rst_sync"
  , parameter ENABLE_CLK_SYNC         = 1     //Set this parameter to 1 to enable clock sync logic
  , parameter USE_RANDOM_RESET_N_DPS  = 1     //1->Randomly reset pll until clock sync, 0->Use dynamic phase shift for clock sync
  , parameter NUM_PLL_CLOCKS          = 1     //Number of clocks generated from PLL
  , parameter NUM_DERIVATIVE_CLOCKS   = 1     //Number of clocks derived from clk_logic
  , parameter integer DERIVATIVE_CLOCK_RATIOS [NUM_DERIVATIVE_CLOCKS-1:0] = '{2}  //List of ratios of derivative clocks wrt clk_logic
                                              //Order must match that of clk_logic_derivatives
  , parameter CLK_SYN_MASTER          = 1
  , parameter CLK_CNT_IN_BUFFER       = 0     //1->Use demux on line CLK_SYNC_CNT_IN_IO,  0->No demux on line SYNC_COUNT_IN_IO
  , parameter CLK_CNT_OUT_BUFFER      = 0     //1->Use mux on line CLK_SYNC_CNT_OUT_IO,  0->No mux on line SYNC_COUNT_OUT_IO
  , parameter CLK_CNT_OUT_WIDTH       = 1     //Width of SYNC_COUNT_OUT_IO. Clock count sync out will be replicated on each pin
  , parameter CLK_CNT_IN_MUX_RATIO    = 20
  , parameter CLK_CNT_IN_CLK_RATIO    = 12
  , parameter CLK_CNT_OUT_MUX_RATIO   = 20
  , parameter CLK_CNT_OUT_CLK_RATIO   = 12
  , parameter NUM_SERDES              = 0
  , parameter SERDES_ENABLE_ALIGN_CNT = 2**17 //Number of clk_logic cyles after sync_lock before enabling align
  , parameter LOCK_DPS_TAP            = 0     //0(default)-> Lock to 50% of pass window
                                              //1->Lock to 25% of pass window
                                              //2->Lock to 75% of pass window

  , parameter WAIT_FOR_PHASE_DONE_EDGE_N_LEVEL  = 0 //1->The FSM will wait for 0->1 transition/edge on pll_phase_done
                                                    //0->The FSM Will wait until pll_phase_done level is high

  /*  Use these prameters to control the DPS sync sensitivity */
  , parameter DPS_NUM_SHIFTS_PER_CYCLE      = 1
  , parameter DPS_MIN_CLK_SYNC_FAIL_CYCLES  = 2
  , parameter DPS_MIN_CLK_SYNC_PASS_CYCLES  = 2

  /*  AV-MM Parameters  */
  , parameter AV_MM_ADDR_W            = 11
  , parameter AV_MM_DATA_W            = 32
  , parameter AV_MM_READ_MISS_VAL     = 32'hdeadbabe

  /*  Do not modify */
  , parameter SERDES_CTRL_STATUS_W    = 32
  , parameter FPGA_FAMILY             = "S5"

) (

    input   wire  clk_mon
  , input   wire  rst_mon_n

  , input   wire  serdes_reconfig_clk

  , inout   wire                            SYNC_COUNT_IN_IO
  , inout   wire  [CLK_CNT_OUT_WIDTH-1:0]   SYNC_COUNT_OUT_IO

  /*  Clock Sync Mux/Demux */
  , input   wire  clk_in_mux_demux
  , input   wire  rst_in_mux_demux_n

  , input   wire  clk_out_mux_demux
  , input   wire  rst_out_mux_demux_n

  , input   wire  clk_logic_serdes_mux_demux

  /* List of PLL outputs to shift in order */
  , input   wire  [4:0]   pll_clk_tap [NUM_PLL_CLOCKS-1:0]

  /*  PLL Interface */
  , output  wire        pll_reset
  , input   wire        locked_logic_pll
  , output  wire        pll_phase_en
  , output  wire        pll_updn
  , output  wire  [4:0] pll_cntsel
  , input   wire        pll_phase_done

  /*  PLL Sync Lock Status  */
  , output  wire  clk_logic_sync_lock

  /*  Clock & its derivatives */
  , input   wire                              clk_logic
  , input   wire  [NUM_DERIVATIVE_CLOCKS-1:0] clk_logic_derivatives
  , output  wire  [NUM_DERIVATIVE_CLOCKS-1:0] rst_logic_derivatives_n


  /*  Serdes  Control/Status  */
  , output  wire  [SERDES_CTRL_STATUS_W-1:0]  serdes_control

  /*  AV-MM Interface */
  , input  wire   [AV_MM_ADDR_W-1:0]     avs_s0_address
  , output wire   [AV_MM_DATA_W-1:0]     avs_s0_readdata
  , input  wire                          avs_s0_read
  , output wire                          avs_s0_readdatavalid
  , input  wire                          avs_s0_write
  , input  wire   [AV_MM_DATA_W-1:0]     avs_s0_writedata
  , input  wire   [(AV_MM_DATA_W/8)-1:0] avs_s0_byteenable
  , output wire                          avs_s0_waitrequest

  /*  Logic Analyzer Debug  */
  , input   wire                         SYNC_COUNT_IN_IO_DUP0
  , input   wire                         SYNC_COUNT_IN_IO_DUP1
  , output  wire  [16:0]                 la_debug

);

  /*  Internal Parameters  */
  localparam  SERDES_ENABLE_ALIGN_CNTR_W      = $clog2(SERDES_ENABLE_ALIGN_CNT) + 1;
  localparam  CNTR_W                          = 32;

  `ifdef  FPGA_SIM
    localparam  NUM_RESET_HOLD_CYCLES = 8;
    localparam  PLL_RESET_STEP_MAX    = 15;
    localparam  PLL_STABLE_CNT0       = 10;
    localparam  PLL_STABLE_CNT1       = 16;
    // To increase the time-out
    localparam  CLK_SYNC_START_TIMEOUT= 8;
    //localparam  CLK_SYNC_START_TIMEOUT= 64;
  `else
    localparam  NUM_RESET_HOLD_CYCLES = USE_RANDOM_RESET_N_DPS  ? 2**16 : 16;
    localparam  PLL_RESET_STEP_MAX    = 5;
    localparam  PLL_STABLE_CNT0       = 2**10;
    localparam  PLL_STABLE_CNT1       = 2**15;
    localparam  CLK_SYNC_START_TIMEOUT= 128;
  `endif

  localparam  CLK_SYNC_STEP_INC_EN    = USE_RANDOM_RESET_N_DPS  ? 1 : 0;

  localparam  NUM_LA_DEBUG_SLICES     = 11;
  localparam  CLK_SYNC_CNT_IN_DEBUG_SLICE_RESIDUE   = CLK_CNT_IN_MUX_RATIO   % 16;
  localparam  CLK_SYNC_CNT_OUT_DEBUG_SLICE_RESIDUE  = CLK_CNT_OUT_MUX_RATIO  % 16;
  localparam  NUM_CLK_SYNC_CNT_IN_DEBUG_SLICES      = (CLK_SYNC_CNT_IN_DEBUG_SLICE_RESIDUE  > 0) ? (CLK_CNT_IN_MUX_RATIO/16)   + 1 : (CLK_CNT_IN_MUX_RATIO/16);
  localparam  NUM_CLK_SYNC_CNT_OUT_DEBUG_SLICES     = (CLK_SYNC_CNT_OUT_DEBUG_SLICE_RESIDUE > 0) ? (CLK_CNT_OUT_MUX_RATIO/16)  + 1 : (CLK_CNT_OUT_MUX_RATIO/16);


  /*  Internal  Variables */
  genvar  i;
  reg   [15:0]                            pll_pow_reset;
  wire                                    rst_logic_trigger_n;
  wire                                    clk_sync_mismatch;
  wire                                    clk_sync_stable;
  wire                                    clk_sync_start_timeout;
  wire                                    pll_dps_rst_clk_sync_n;
  reg   [3:0]                             rst_logic_sync_pipe;
  wire                                    rst_logic_sync_n;
  wire                                    rst_logic_n;
  reg   [1:0]                             rst_logic_mon_sync_pipe;
  wire                                    rst_logic_mon_n;
  wire                                    dps_locked;
  wire                                    clk_sync_locked;
  wire  [2:0]                             dps_cntrl_fsm_pstate;
  wire  [2:0]                             dps_sync_fsm_pstate;
  wire  [CNTR_W-1:0]                      dps_pass_win_len;
  wire  [CNTR_W-1:0]                      dps_find_fail0_shift_cnt;
  wire  [CNTR_W-1:0]                      dps_find_pass0_shift_cnt;
  wire  [CNTR_W-1:0]                      dps_find_fail1_shift_cnt;
  wire  [CNTR_W-1:0]                      dps_lock_dps_shift_cnt;
  wire  [CNTR_W-1:0]                      dps_consec_sync_pass_cnt;
  wire  [CNTR_W-1:0]                      dps_consec_sync_fail_cnt;
  wire  [CNTR_W-1:0]                      dps_lock_target_cnt;
  wire  [CNTR_W-1:0]                      dps_lock_slip_cnt;
  reg   [1:0]                             serdes_clk_sync_done_sync;
  reg   [SERDES_ENABLE_ALIGN_CNTR_W-1:0]  serdes_enable_align_cntr;
  reg                                     serdes_enable_align;
  wire                                    serdes_clk_sync_done;

  wire  [3:0]                             dps_mode;
  wire                                    dps_step_forward_p;
  wire  [31:0]                            dps_step_count;
  wire  [31:0]                            dps_step_counter;
  wire                                    dps_pause;
  wire  [7:0]                             dps_la_dbg_win_sel;

  wire  [15:0]                            la_debug_slices [NUM_LA_DEBUG_SLICES-1:0];

  wire  [CLK_CNT_IN_MUX_RATIO-1:0]        dbg_clk_sync_cnt_in_demux;
  wire  [CLK_CNT_OUT_MUX_RATIO-1:0]       dbg_clk_sync_out_cntr;
  reg   [63:0]                            dbg_clk_sync_cnt_in_demux_big_bus;
  reg   [63:0]                            dbg_clk_sync_out_cntr_big_bus;

  reg                                     SYNC_COUNT_IN_IO_DUP1_1D;

  /*  Create  Power on reset for pll  */
  always@(posedge clk_mon,  negedge rst_mon_n)
  begin
    if(~rst_mon_n)
    begin
      pll_pow_reset       <=  {16{1'b1}};
    end
    else
    begin
      pll_pow_reset       <=  {pll_pow_reset[14:0],1'b0};
    end
  end

  /*  Reset PLL based on sync scheme  */
  generate
    if(ENABLE_CLK_SYNC  ==  1)
    begin
      if(CLK_SYN_MASTER==0)
      begin
        if(USE_RANDOM_RESET_N_DPS==1)
        begin
          assign  pll_reset           = clk_sync_mismatch | pll_pow_reset[15];
          assign  rst_logic_trigger_n = locked_logic_pll;
        end
        else  //Use Dynamic Phase Shift
        begin
          assign  pll_reset           = pll_pow_reset[15];
          assign  rst_logic_trigger_n = pll_dps_rst_clk_sync_n  & locked_logic_pll;
        end
      end
      else
      begin
        assign  pll_reset             = pll_pow_reset[15];
        assign  rst_logic_trigger_n   = locked_logic_pll;
      end
    end
    else
    begin
      assign  pll_reset             = pll_pow_reset[15];
      assign  rst_logic_trigger_n   = locked_logic_pll;
    end
  endgenerate


  /*  Synchronize Logic Reset  */
  always@(posedge clk_logic,  negedge rst_logic_trigger_n)
  begin
    if(~rst_logic_trigger_n)
    begin
      rst_logic_sync_pipe     <=  0;
    end
    else
    begin
      rst_logic_sync_pipe     <=  {rst_logic_sync_pipe[2:0],1'b1};
    end
  end

  assign  rst_logic_sync_n    =   rst_logic_sync_pipe[1];
  assign  rst_logic_n         =   rst_logic_sync_pipe[3];


  /*  Keep Internal MON clock reset active until PLL is locked*/
  always@(posedge clk_mon,  negedge locked_logic_pll)
  begin
    if(~locked_logic_pll)
    begin
      rst_logic_mon_sync_pipe <=  0;
    end
    else
    begin
      rst_logic_mon_sync_pipe <=  {rst_logic_mon_sync_pipe[0],1'b1};
    end
  end

  assign  rst_logic_mon_n     =   rst_logic_mon_sync_pipe[1];


  /*  Synchronize Derivative Resets  */
  IW_fpga_clk_rst_derivatives_gen #(
     .NUM_DERIVATIVE_CLOCKS     (NUM_DERIVATIVE_CLOCKS)
    ,.DERIVATIVE_CLOCK_RATIOS   (DERIVATIVE_CLOCK_RATIOS)
   
  ) u_IW_fpga_clk_rst_derivatives_gen (

     .clk_logic                 (clk_logic)
    ,.rst_logic_n               (rst_logic_sync_n)
    ,.clk_en                    (1'b1 )  

    ,.clk_logic_derivatives     (clk_logic_derivatives)
    ,.rst_logic_derivatives_n   (rst_logic_derivatives_n)

  );

  generate
    if(ENABLE_CLK_SYNC  ==  1)
    begin
      parameter LFSR_WIDTH_IN   = ((CLK_CNT_IN_MUX_RATIO-1) < 8)  ? 4     : 8;
      parameter LFSR_POLY_IN    = ((CLK_CNT_IN_MUX_RATIO-1) < 8)  ? 4'hc  : 8'hb8;

      parameter LFSR_WIDTH_OUT  = ((CLK_CNT_OUT_MUX_RATIO-1) < 8) ? 4     : 8;
      parameter LFSR_POLY_OUT   = ((CLK_CNT_OUT_MUX_RATIO-1) < 8) ? 4'hc  : 8'hb8;

      wire                    pll_stable_cnt_sel;

      /*  Instantiate Clock Sync Module */
      IW_fpga_clk_sync  #(
         .CLK_SYN_MASTER            (CLK_SYN_MASTER)
        ,.CLK_CNT_IN_BUFFER         (CLK_CNT_IN_BUFFER)
        ,.CLK_CNT_OUT_BUFFER        (CLK_CNT_OUT_BUFFER)
        ,.CLK_CNT_OUT_WIDTH         (CLK_CNT_OUT_WIDTH)
        ,.CLK_CNT_IN_MUX_RATIO      (CLK_CNT_IN_MUX_RATIO)
        ,.CLK_CNT_IN_CLK_RATIO      (CLK_CNT_IN_CLK_RATIO)
        ,.CLK_CNT_OUT_MUX_RATIO     (CLK_CNT_OUT_MUX_RATIO)
        ,.CLK_CNT_OUT_CLK_RATIO     (CLK_CNT_OUT_CLK_RATIO)
        ,.LFSR_WIDTH_IN             (LFSR_WIDTH_IN)
        ,.LFSR_POLY_IN              (LFSR_POLY_IN)
        ,.LFSR_WIDTH_OUT            (LFSR_WIDTH_OUT)
        ,.LFSR_POLY_OUT             (LFSR_POLY_OUT)

        ,.NUM_RESET_HOLD_CYCLES     (NUM_RESET_HOLD_CYCLES)
        ,.STEP_INC_ENABLE           (CLK_SYNC_STEP_INC_EN)
        ,.PLL_RESET_STEP_MAX        (PLL_RESET_STEP_MAX)

        ,.PLL_STABLE_CNT0           (PLL_STABLE_CNT0)
        ,.PLL_STABLE_CNT1           (PLL_STABLE_CNT1)
        ,.CLK_SYNC_START_TIMEOUT    (CLK_SYNC_START_TIMEOUT)
        ,.FPGA_FAMILY               (FPGA_FAMILY)

      ) u_IW_fpga_clk_sync_logic  (

         .clk_mon                       (clk_mon)
        ,.rst_mon_n                     (rst_logic_mon_n)

        ,.clk_ref                       (clk_logic)
        ,.rst_ref_n                     (rst_logic_n)

        ,.pll_stable_cnt_sel            (pll_stable_cnt_sel)

        ,.clk_in_mux_demux              (clk_in_mux_demux)
        ,.rst_in_mux_demux_n            (rst_in_mux_demux_n)

        ,.clk_out_mux_demux             (clk_out_mux_demux)
        ,.rst_out_mux_demux_n           (rst_out_mux_demux_n)

        ,.CLK_SYNC_CNT_IN_IO            (SYNC_COUNT_IN_IO)
        ,.CLK_SYNC_CNT_OUT_IO           (SYNC_COUNT_OUT_IO)

        ,.clk_sync_cnt_in               ({CLK_CNT_IN_MUX_RATIO{1'b0}})
        ,.clk_sync_cnt_out              ()

        ,.ref_clk_sync_mismatch         (clk_sync_mismatch)
        ,.ref_clk_sync_stable           (clk_sync_stable)
        ,.ref_clk_locked                (clk_sync_locked)
        ,.ref_clk_sync_start_timeout    (clk_sync_start_timeout)

        ,.dbg_clk_sync_cnt_in_demux     (dbg_clk_sync_cnt_in_demux)
        ,.dbg_clk_sync_out_cntr         (dbg_clk_sync_out_cntr)

      );

      /*  Instantiate Dynamic Phase Shift Controller  */
      if((CLK_SYN_MASTER  ==  0)  &&  (USE_RANDOM_RESET_N_DPS ==  0))
      begin
        IW_fpga_pll_dps_sync  #(
           .MODULE_NAME                       ({MODULE_NAME,".u_IW_fpga_pll_dps_sync"})
          ,.PHASE_EN_PULSE_W                  (2)
//          ,.NUM_PLL_CLOCKS                    (NUM_PLL_CLOCKS)
// global shift for all clocks
          ,.NUM_PLL_CLOCKS                    (1)
          ,.LOCK_DPS_TAP                      (LOCK_DPS_TAP)
          ,.WAIT_FOR_PHASE_DONE_EDGE_N_LEVEL  (WAIT_FOR_PHASE_DONE_EDGE_N_LEVEL)

          ,.NUM_SHIFTS_PER_CYCLE              (DPS_NUM_SHIFTS_PER_CYCLE)
          ,.MIN_CLK_SYNC_FAIL_CYCLES          (DPS_MIN_CLK_SYNC_FAIL_CYCLES)
          ,.MIN_CLK_SYNC_PASS_CYCLES          (DPS_MIN_CLK_SYNC_PASS_CYCLES)

        ) u_IW_fpga_pll_dps_sync (

           .clk                       (clk_mon)
          ,.rst_n                     (rst_logic_mon_n)

          ,.clk_sync_mismatch         (clk_sync_mismatch)
          ,.clk_sync_stable           (clk_sync_stable)
          ,.clk_sync_start_timeout    (clk_sync_start_timeout)
          ,.pll_stable_cnt_sel        (pll_stable_cnt_sel)

//          ,.pll_clk_tap               (pll_clk_tap)
// global shift for all clocks
          ,.pll_clk_tap               ('{5'b01111})

          ,.pll_updn                  (pll_updn)
          ,.pll_cnt_sel               (pll_cntsel)
          ,.pll_phase_en              (pll_phase_en)
          ,.pll_phase_done            (pll_phase_done)

          ,.dps_locked                (dps_locked)
          ,.rst_clk_sync_n            (pll_dps_rst_clk_sync_n)
          ,.dps_cntrl_fsm_pstate      (dps_cntrl_fsm_pstate)
          ,.dps_sync_fsm_pstate       (dps_sync_fsm_pstate)
          ,.dps_pass_win_len          (dps_pass_win_len)

          ,.dps_find_fail0_shift_cnt  (dps_find_fail0_shift_cnt)
          ,.dps_find_pass0_shift_cnt  (dps_find_pass0_shift_cnt)
          ,.dps_find_fail1_shift_cnt  (dps_find_fail1_shift_cnt)
          ,.dps_lock_dps_shift_cnt    (dps_lock_dps_shift_cnt)
          ,.dps_consec_sync_pass_cnt  (dps_consec_sync_pass_cnt)
          ,.dps_consec_sync_fail_cnt  (dps_consec_sync_fail_cnt)
          ,.dps_lock_target_cnt       (dps_lock_target_cnt)
          ,.dps_lock_slip_cnt         (dps_lock_slip_cnt)

          ,.dps_mode                  (dps_mode)
          ,.dps_step_forward_p        (dps_step_forward_p)
          ,.dps_step_count            (dps_step_count)
          ,.dps_step_counter          (dps_step_counter)
          ,.dps_pause                 (dps_pause)

        );

        assign  clk_sync_locked = dps_locked;
      end
      else
      begin
        assign  pll_updn      = 1'b0;
        assign  pll_cntsel    = 5'd0;
        assign  pll_phase_en  = 1'b0;
        assign  dps_locked    = 1'b0;
        assign  clk_sync_locked         = 1'b1; //Need to take care of this when DPS not used
        assign  pll_dps_rst_clk_sync_n  = 1'b1;
        assign  dps_cntrl_fsm_pstate    = 3'd0;
        assign  dps_sync_fsm_pstate     = 3'd0;
        assign  dps_pass_win_len        = {CNTR_W{1'b0}};
        assign  pll_stable_cnt_sel      = 1'b1;
        assign  dps_pause               = 1'b0;
      end
    end
    else  //~ENABLE_CLK_SYNC
    begin
      assign  clk_sync_mismatch       = 1'b0;
      assign  clk_sync_stable         = 1'b1;
      assign  clk_sync_start_timeout  = 1'b0;

      assign  pll_updn      = 1'b0;
      assign  pll_cntsel    = 5'd0;
      assign  pll_phase_en  = 1'b0;
      assign  dps_locked    = 1'b0;
      assign  pll_dps_rst_clk_sync_n  = 1'b1;
      assign  dps_cntrl_fsm_pstate    = 3'd0;
      assign  dps_sync_fsm_pstate     = 3'd0;
      assign  dps_pass_win_len        = {CNTR_W{1'b0}};
    end
  endgenerate

  /*  PLL Clock Sync */
  generate
    if(ENABLE_CLK_SYNC  ==  1)
    begin
      if(CLK_SYN_MASTER)
      begin
        assign  clk_logic_sync_lock = locked_logic_pll;
      end
      else
      begin
        if(USE_RANDOM_RESET_N_DPS)
        begin
          assign  clk_logic_sync_lock = clk_sync_stable;
        end
        else
        begin
          assign  clk_logic_sync_lock = dps_locked;
        end
      end
    end
    else
    begin
      assign  clk_logic_sync_lock = locked_logic_pll;
    end
  endgenerate


  /*  Serdes  Control/Status  Logic */
  always@(posedge clk_logic,  negedge rst_logic_n)
  begin
    if(~rst_logic_n)
    begin
      serdes_clk_sync_done_sync   <=  0;
      serdes_enable_align_cntr    <=  0;
      serdes_enable_align         <=  0;
    end
    else
    begin
      serdes_clk_sync_done_sync   <=  {serdes_clk_sync_done_sync[0],  clk_logic_sync_lock};

      if(serdes_clk_sync_done)
      begin
        serdes_enable_align_cntr  <=  (serdes_enable_align_cntr ==  SERDES_ENABLE_ALIGN_CNT-1)  ? serdes_enable_align_cntr
                                                                                                : serdes_enable_align_cntr  + 1'b1;
      end
      else
      begin
        serdes_enable_align_cntr  <=  0;
      end

      serdes_enable_align         <=  (serdes_enable_align_cntr ==  SERDES_ENABLE_ALIGN_CNT-1)  ? 1'b1  : 1'b0;
    end
  end

  assign  serdes_clk_sync_done  =   serdes_clk_sync_done_sync[1];


  assign  serdes_control[SERDES_CTRL_STATUS_W-8 +:  8]  = 8'h0;
  assign  serdes_control[SERDES_CTRL_STATUS_W-8-1:7]    = {(SERDES_CTRL_STATUS_W-8-7){1'b0}};
  assign  serdes_control[6]                             = serdes_enable_align;
  assign  serdes_control[5]                             = 1'b1;
  assign  serdes_control[4]                             = serdes_clk_sync_done;
  assign  serdes_control[3]                             = serdes_reconfig_clk;
  assign  serdes_control[2]                             = serdes_reconfig_clk;
  assign  serdes_control[1]                             = clk_logic_serdes_mux_demux;
  assign  serdes_control[0]                             = clk_logic;


  /*  Debug Logic */
  reg [CNTR_W-1:0]        clk_sync_loss_cntr;
  reg                     clk_logic_sync_lock_1d;

  always@(posedge clk_mon,  negedge rst_logic_mon_n)
  begin
    if(~rst_logic_mon_n)
    begin
      clk_logic_sync_lock_1d  <=  0;
      clk_sync_loss_cntr      <=  0;
    end
    else
    begin
      clk_logic_sync_lock_1d  <=  clk_logic_sync_lock;

      //Increment counter each time clock sync is lost
      clk_sync_loss_cntr      <=  clk_sync_loss_cntr  + (~clk_logic_sync_lock & clk_logic_sync_lock_1d);
    end
  end


  /*  Synchronize signals for debug */
  `define gen_dbg_sync(signal_name) \
    wire  signal_name``_dbg_sync; \
    IW_fpga_double_sync #(.WIDTH(1),.NUM_STAGES(2)) u_``signal_name (.clk(clk_mon),.sig_in(signal_name),.sig_out(signal_name``_dbg_sync));

  `gen_dbg_sync(clk_sync_start_timeout)
  `gen_dbg_sync(serdes_enable_align)
  `gen_dbg_sync(serdes_clk_sync_done)
  `gen_dbg_sync(clk_logic_sync_lock)
  `gen_dbg_sync(rst_logic_n)
  `gen_dbg_sync(rst_logic_mon_n)
  `gen_dbg_sync(clk_sync_stable)
  `gen_dbg_sync(clk_sync_mismatch)
  `gen_dbg_sync(locked_logic_pll)
  `gen_dbg_sync(pll_reset)


  /*  Address Map */
  IW_fpga_clk_rst_sync_addr_map_avmm_wrapper #(
     .AV_MM_ADDR_W      (AV_MM_ADDR_W)
    ,.AV_MM_DATA_W      (AV_MM_DATA_W)
    ,.READ_MISS_VAL     (AV_MM_READ_MISS_VAL)

  ) u_addr_map  (

     .csi_clk                                       (clk_mon)
    ,.rsi_reset_n                                   (rst_mon_n)

    ,.avs_s0_address                                (avs_s0_address)
    ,.avs_s0_readdata                               (avs_s0_readdata)
    ,.avs_s0_read                                   (avs_s0_read)
    ,.avs_s0_readdatavalid                          (avs_s0_readdatavalid)
    ,.avs_s0_write                                  (avs_s0_write)
    ,.avs_s0_writedata                              (avs_s0_writedata)
    ,.avs_s0_byteenable                             (avs_s0_byteenable)
    ,.avs_s0_waitrequest                            (avs_s0_waitrequest)

    ,.coe_clk_param_0_pll_num_clks                  (NUM_PLL_CLOCKS)
    ,.coe_clk_param_0_num_derivative_clocks         (NUM_DERIVATIVE_CLOCKS)
    ,.coe_clk_param_0_clk_sync_start_timeout        (CLK_SYNC_START_TIMEOUT)
    ,.coe_clk_param_0_enable_clk_sync               (ENABLE_CLK_SYNC)
    ,.coe_clk_param_0_clk_cnt_out_bffr              (CLK_CNT_OUT_BUFFER)
    ,.coe_clk_param_0_clk_cnt_in_bffr               (CLK_CNT_IN_BUFFER)
    ,.coe_clk_param_0_clk_syn_master                (CLK_SYN_MASTER)
    ,.coe_clk_param_0_use_random_reset_n_dps        (USE_RANDOM_RESET_N_DPS)
    ,.coe_clk_param_1_clk_cnt_in_mux_ratio          (CLK_CNT_IN_MUX_RATIO)
    ,.coe_clk_param_1_clk_cnt_in_clk_ratio          (CLK_CNT_IN_CLK_RATIO)
    ,.coe_clk_param_2_clk_cnt_out_mux_ratio         (CLK_CNT_OUT_MUX_RATIO)
    ,.coe_clk_param_2_clk_cnt_out_clk_ratio         (CLK_CNT_OUT_CLK_RATIO)
    ,.coe_clk_param_3_num_reset_hold_cycles         (NUM_RESET_HOLD_CYCLES)
    ,.coe_clk_param_4_pll_reset_step_max            (PLL_RESET_STEP_MAX)
    ,.coe_clk_param_5_pll_stable_cnt0               (PLL_STABLE_CNT0)
    ,.coe_clk_param_5_pll_stable_cnt1               (PLL_STABLE_CNT1)
    ,.coe_clk_param_6_dps_num_shifts_per_cycle      (DPS_NUM_SHIFTS_PER_CYCLE)
    ,.coe_clk_param_7_dps_min_clk_sync_fail_cycles  (DPS_MIN_CLK_SYNC_FAIL_CYCLES)
    ,.coe_clk_param_8_dps_min_clk_sync_pass_cycles  (DPS_MIN_CLK_SYNC_PASS_CYCLES)
    ,.coe_clk_param_9_num_serdes                    (NUM_SERDES)
    ,.coe_clk_param_10_serdes_enable_align_cnt      (SERDES_ENABLE_ALIGN_CNT)
    ,.coe_clk_sync_stat_clk_sync_start_timeout      (clk_sync_start_timeout_dbg_sync)
    ,.coe_clk_sync_stat_serdes_enable_align         (serdes_enable_align_dbg_sync)
    ,.coe_clk_sync_stat_serdes_clk_sync_done        (serdes_clk_sync_done_dbg_sync)
    ,.coe_clk_sync_stat_clk_logic_sync_lock         (clk_logic_sync_lock_dbg_sync)
    ,.coe_clk_sync_stat_rst_logic_n                 (rst_logic_n_dbg_sync)
    ,.coe_clk_sync_stat_rst_logic_mon_n             (rst_logic_mon_n_dbg_sync)
    ,.coe_clk_sync_stat_dps_locked                  (dps_locked)
    ,.coe_clk_sync_stat_pll_dps_rst_clk_sync_n      (pll_dps_rst_clk_sync_n)
    ,.coe_clk_sync_stat_clk_sync_stable             (clk_sync_stable_dbg_sync)
    ,.coe_clk_sync_stat_clk_sync_mismatch           (clk_sync_mismatch_dbg_sync)
    ,.coe_clk_sync_stat_locked_logic_pll            (locked_logic_pll_dbg_sync)
    ,.coe_clk_sync_stat_pll_reset                   (pll_reset_dbg_sync)
    ,.coe_clk_dps_sync_fsm_pstate                   (dps_sync_fsm_pstate)
    ,.coe_clk_dps_cntrl_fsm_pstate                  (dps_cntrl_fsm_pstate)
    ,.coe_clk_dps_pass_win_len                      (dps_pass_win_len)
    ,.coe_clk_sync_loss_cnt                         (clk_sync_loss_cntr)
    ,.coe_clk_dps_find_fail0_shift_cnt              (dps_find_fail0_shift_cnt)
    ,.coe_clk_dps_find_pass0_shift_cnt              (dps_find_pass0_shift_cnt)
    ,.coe_clk_dps_find_fail1_shift_cnt              (dps_find_fail1_shift_cnt)
    ,.coe_clk_dps_lock_dps_shift_cnt                (dps_lock_dps_shift_cnt)
    ,.coe_clk_dps_consec_sync_pass_cnt              (dps_consec_sync_pass_cnt)
    ,.coe_clk_dps_consec_fail_cnt                   (dps_consec_sync_fail_cnt)
    ,.coe_clk_dps_lock_target_cnt                   (dps_lock_target_cnt)
    ,.coe_clk_dps_lock_slip_cnt                     (dps_lock_slip_cnt)

    ,.dps_mode                                      (dps_mode)
    ,.dps_step_forward_p                            (dps_step_forward_p)
    ,.dps_step_count                                (dps_step_count)
    ,.dps_la_dbg_win_sel                            (dps_la_dbg_win_sel)
    ,.dps_pause                                     (dps_pause)

  );

  /*  Signals For LA Debug  */
  assign  la_debug[15:0]  = la_debug_slices[dps_la_dbg_win_sel];
  assign  la_debug[16]    = clk_in_mux_demux;

  always@(posedge clk_in_mux_demux)
  begin
    SYNC_COUNT_IN_IO_DUP1_1D  <=  SYNC_COUNT_IN_IO_DUP1;
  end

  generate
  if(CLK_CNT_IN_MUX_RATIO <= 64) begin
    always@(*)
    begin
      dbg_clk_sync_cnt_in_demux_big_bus = 64'h0;
      dbg_clk_sync_cnt_in_demux_big_bus[CLK_CNT_IN_MUX_RATIO-1:0] = dbg_clk_sync_cnt_in_demux;
    end
  end else begin
    always@(*)
    begin
      dbg_clk_sync_cnt_in_demux_big_bus = 64'h0;
      dbg_clk_sync_cnt_in_demux_big_bus = dbg_clk_sync_cnt_in_demux[63:0];
    end
  end

  if(CLK_CNT_OUT_MUX_RATIO <= 64) begin
    always@(*)
    begin
      dbg_clk_sync_out_cntr_big_bus     = 64'h0;
      dbg_clk_sync_out_cntr_big_bus[CLK_CNT_OUT_MUX_RATIO-1:0]    = dbg_clk_sync_out_cntr;
    end
  end else begin
    always@(*)
    begin
      dbg_clk_sync_out_cntr_big_bus     = 64'h0;
      dbg_clk_sync_out_cntr_big_bus     = dbg_clk_sync_out_cntr[63:0];
    end
  end
  endgenerate

  assign  la_debug_slices[0]  = { 
                                  pll_reset
                                 ,locked_logic_pll
                                 ,pll_phase_en
                                 ,pll_updn
                                 ,pll_cntsel[3:0]
                                 ,pll_phase_done
                                 ,clk_in_mux_demux
                                 ,rst_in_mux_demux_n
                                 ,SYNC_COUNT_IN_IO_DUP1_1D
                                 ,SYNC_COUNT_IN_IO_DUP0
                                 ,clk_out_mux_demux
                                 ,rst_out_mux_demux_n
                                 ,SYNC_COUNT_OUT_IO[0]
                                };

  assign  la_debug_slices[1]  = dbg_clk_sync_cnt_in_demux_big_bus[15:0];
  assign  la_debug_slices[2]  = dbg_clk_sync_cnt_in_demux_big_bus[31:16];
  assign  la_debug_slices[3]  = dbg_clk_sync_cnt_in_demux_big_bus[47:32];
  assign  la_debug_slices[4]  = dbg_clk_sync_cnt_in_demux_big_bus[63:48];

  assign  la_debug_slices[5]  = dbg_clk_sync_out_cntr_big_bus[15:0];
  assign  la_debug_slices[6]  = dbg_clk_sync_out_cntr_big_bus[31:16];
  assign  la_debug_slices[7]  = dbg_clk_sync_out_cntr_big_bus[47:32];
  assign  la_debug_slices[8]  = dbg_clk_sync_out_cntr_big_bus[63:48];

  assign  la_debug_slices[9]  = dps_step_counter[15:0];
  assign  la_debug_slices[10] = dps_step_counter[31:0];

  `undef  gen_dbg_sync

endmodule //IW_fpga_clk_rst_sync

//------------------------------------------------------------------------------
// Change History:
//
// $Log: IW_fpga_clk_rst.sv.rca $
// 
// 
// 
//------------------------------------------------------------------------------

