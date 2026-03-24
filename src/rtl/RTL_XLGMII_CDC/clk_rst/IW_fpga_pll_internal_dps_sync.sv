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

/*
 --------------------------------------------------------------------------
 -- Project Code      : IMPrES
 -- Module Name       : IW_fpga_pll_internal_dps_sync
 -- Author            : Gregory James
 -- Associated modules: 
 -- Function          : This module can be used to synchronize a PLL by dynamically
                        phase shifting the PLL outputs & comparing edges with a
                        reference clock.
 --------------------------------------------------------------------------
*/

`timescale 1ns / 10ps


module IW_fpga_pll_internal_dps_sync #(
    parameter MODULE_NAME                       = "IW_fpga_pll_internal_dps_sync"
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
  , parameter EDGE_DET_CNTR_W                   = 8

  , parameter AV_MM_ADDR_W                      = 8
  , parameter AV_MM_DATA_W                      = 32

) (

    input   logic           clk_edge_det
  , input   logic           rst_edge_det_n

  , input   logic           clk_dps
  , input   logic           rst_dps_n

  , input   logic           clk_ref
  , input   logic           rst_ref_n

  , input   logic           clk_pll
  , input   logic           pll_locked
  , output  logic           pll_reset
  , output  logic           dps_locked

  //List of PLL outputs to shift in order
  , input   logic  [4:0]    pll_clk_tap [NUM_PLL_CLOCKS-1:0]

  //PLL Dynamic Phase Shift Control/Status signals
  , output  logic           pll_updn
  , output  logic  [4:0]    pll_cntsel
  , output  logic           pll_phase_en
  , input   logic           pll_phase_done

  //Avalon MM Interface for debug - Runs @clk_dps
  , input   logic [AV_MM_ADDR_W-1:0]     avs_s0_address
  , output  logic [AV_MM_DATA_W-1:0]     avs_s0_readdata
  , input   logic                        avs_s0_read
  , output  logic                        avs_s0_readdatavalid
  , input   logic                        avs_s0_write
  , input   logic [AV_MM_DATA_W-1:0]     avs_s0_writedata
  , input   logic [(AV_MM_DATA_W/8)-1:0] avs_s0_byteenable
  , output  logic                        avs_s0_waitrequest
 

);

//----------------------- Import Packages ---------------------------------


//----------------------- Internal Parameters -----------------------------
  localparam  DPS_CNTR_W        = 32;



//----------------------- Internal Register Declarations ------------------


//----------------------- Internal Wire Declarations ----------------------
  logic                       clk_ref_edge_det_valid;
  logic                       rst_pll_n;
  logic  [3:0]                edge_det_wait_cntr;
  logic                       edge_det_ready;
  logic                       edge_det_ready_sync;
  logic  [15:0]               pll_pow_reset;
  logic                       rst_edge_det_int_n;
  logic                       clk_pll_edge_det_valid;
  logic                       pll_dps_rst_clk_sync_n;
  logic                       rst_logic_trigger_n;
  logic                       rst_edge_det_trigger_n;
  logic                       clk_sync_mismatch;
  logic                       clk_sync_stable;
  logic                       clk_sync_mismatch_sync;
  logic                       clk_sync_stable_sync;
  logic                       rst_dps_trigger_n;
  logic                       rst_dps_int_n;

  wire  [2:0]                 dps_cntrl_fsm_pstate;
  wire  [2:0]                 dps_sync_fsm_pstate;
  wire  [31:0]                dps_pass_win_len;
  wire  [31:0]                dps_find_fail0_shift_cnt;
  wire  [31:0]                dps_find_pass0_shift_cnt;
  wire  [31:0]                dps_find_fail1_shift_cnt;
  wire  [31:0]                dps_lock_dps_shift_cnt;
  wire  [31:0]                dps_consec_sync_pass_cnt;
  wire  [31:0]                dps_consec_sync_fail_cnt;
  wire  [31:0]                dps_lock_target_cnt;
  wire  [31:0]                dps_lock_slip_cnt;
 
//----------------------- Start of Code -----------------------------------

  /*  Detect Rising Edge of Reference Clock */
  IW_fpga_early_clk_det #(
     .CNTR_W            (EDGE_DET_CNTR_W)
    ,.NUM_CYCLES_EARLY  (0)

  ) u_IW_fpga_early_clk_det_ref (

     .clk_fast            (clk_edge_det)
    ,.rst_fast_n          (rst_edge_det_int_n)

    ,.clk_slow            (clk_ref)
    ,.rst_slow_n          (rst_ref_n)

    ,.edge_det_cntr       ()
    ,.edge_det_start_val  ()
    ,.edge_det_valid      (clk_ref_edge_det_valid)

  );

  /*  Generate synchronous reset for clk_pll  */
  assign  rst_logic_trigger_n = pll_dps_rst_clk_sync_n  & pll_locked;

  IW_sync_reset u_sync_rst_pll_n  (.clk(clk_pll),.rst_n(rst_logic_trigger_n),.rst_n_sync(rst_pll_n));


  /*  Generate internal reset for edge-det logic  */
  assign  rst_edge_det_trigger_n  = pll_dps_rst_clk_sync_n  & pll_locked  & rst_edge_det_n;

  IW_sync_reset u_sync_rst_edge_det_int_n (.clk(clk_edge_det),.rst_n(rst_edge_det_trigger_n),.rst_n_sync(rst_edge_det_int_n));


  /*  Detect Rising Edge of PLL Clock */
  IW_fpga_early_clk_det #(
     .CNTR_W            (EDGE_DET_CNTR_W)
    ,.NUM_CYCLES_EARLY  (0)

  ) u_IW_fpga_early_clk_det_pll (

     .clk_fast            (clk_edge_det)
    ,.rst_fast_n          (rst_edge_det_int_n)

    ,.clk_slow            (clk_pll)
    ,.rst_slow_n          (rst_pll_n)

    ,.edge_det_cntr       ()
    ,.edge_det_start_val  ()
    ,.edge_det_valid      (clk_pll_edge_det_valid)

  );

  /*  Generate internal reset for clk_dps  */
  assign  rst_dps_trigger_n = rst_dps_n & pll_locked;

  IW_sync_reset u_sync_rst_dps_int_n  (.clk(clk_dps),.rst_n(rst_dps_trigger_n),.rst_n_sync(rst_dps_int_n));


  /*  Instantiate DPS Engine  */
  IW_fpga_pll_dps_sync #(

     .MODULE_NAME                       ({MODULE_NAME,".u_IW_fpga_pll_dps_sync"})
    ,.PHASE_EN_PULSE_W                  (2)
    ,.NUM_PLL_CLOCKS                    (NUM_PLL_CLOCKS                    )
    ,.NUM_SHIFTS_PER_CYCLE              (NUM_SHIFTS_PER_CYCLE              )
    ,.MIN_CLK_SYNC_FAIL_CYCLES          (MIN_CLK_SYNC_FAIL_CYCLES          )
    ,.MIN_CLK_SYNC_PASS_CYCLES          (MIN_CLK_SYNC_PASS_CYCLES          )
    ,.MAX_LOCK_FAIL_CYCLES              (MAX_LOCK_FAIL_CYCLES              )
    ,.LOCK_DPS_TAP                      (LOCK_DPS_TAP                      )
    ,.WAIT_FOR_PHASE_DONE_EDGE_N_LEVEL  (WAIT_FOR_PHASE_DONE_EDGE_N_LEVEL  )
    ,.CNTR_W                            (DPS_CNTR_W)

  ) u_IW_fpga_pll_dps_sync  (

     .clk                               (clk_dps)
    ,.rst_n                             (rst_dps_int_n)

    ,.clk_sync_mismatch                 (clk_sync_mismatch_sync)
    ,.clk_sync_stable                   (clk_sync_stable_sync)
    ,.clk_sync_start_timeout            (1'b0)
    ,.pll_stable_cnt_sel                ()

    ,.pll_clk_tap                       (pll_clk_tap)

    ,.pll_updn                          (pll_updn)
    ,.pll_cnt_sel                       (pll_cntsel)
    ,.pll_phase_en                      (pll_phase_en)
    ,.pll_phase_done                    (pll_phase_done)

    ,.rst_clk_sync_n                    (pll_dps_rst_clk_sync_n)
    ,.dps_locked                        (dps_locked)
    ,.dps_cntrl_fsm_pstate              (dps_cntrl_fsm_pstate)
    ,.dps_sync_fsm_pstate               (dps_sync_fsm_pstate)
    ,.dps_pass_win_len                  (dps_pass_win_len)

    ,.dps_find_fail0_shift_cnt          (dps_find_fail0_shift_cnt)
    ,.dps_find_pass0_shift_cnt          (dps_find_pass0_shift_cnt)
    ,.dps_find_fail1_shift_cnt          (dps_find_fail1_shift_cnt)
    ,.dps_lock_dps_shift_cnt            (dps_lock_dps_shift_cnt)
    ,.dps_consec_sync_pass_cnt          (dps_consec_sync_pass_cnt)
    ,.dps_consec_sync_fail_cnt          (dps_consec_sync_fail_cnt)
    ,.dps_lock_target_cnt               (dps_lock_target_cnt)
    ,.dps_lock_slip_cnt                 (dps_lock_slip_cnt)

  );

  /*  Wait for some cycles before starting clock-alignment check  */
  always@(posedge clk_pll,  negedge rst_pll_n)
  begin
    if(~rst_pll_n)
    begin
      edge_det_wait_cntr      <=  0;
      edge_det_ready          <=  0;
    end
    else
    begin
      edge_det_wait_cntr      <=  edge_det_ready  ? edge_det_wait_cntr  : edge_det_wait_cntr  + 1'b1;
      edge_det_ready          <=  (edge_det_wait_cntr >=  5)  ? 1'b1  : 1'b0;
    end
  end

  IW_sync_posedge #(.WIDTH(1),.NUM_STAGES(2)) IW_sync_posedge_edge_det_ready  (.clk(clk_edge_det),.rst_n(rst_edge_det_int_n),.data(edge_det_ready),.data_sync(edge_det_ready_sync));

  /*  Clock Alignment Check Logic */
  always@(posedge clk_edge_det, negedge rst_edge_det_int_n)
  begin
    if(~rst_edge_det_int_n)
    begin
      clk_sync_mismatch       <=  0;
      clk_sync_stable         <=  0;
    end
    else
    begin
      if(~edge_det_ready_sync)
      begin
        clk_sync_mismatch     <=  0;
        clk_sync_stable       <=  0;
      end
      else
      begin
        clk_sync_mismatch     <=  clk_ref_edge_det_valid  ^ clk_pll_edge_det_valid;
        clk_sync_stable       <=  clk_ref_edge_det_valid  & clk_pll_edge_det_valid;
      end
    end
  end

  IW_async_pulses #(.WIDTH(2))  u_IW_async_pulses_clk_sync_mismatch
    (.clk_src(clk_edge_det),.rst_src_n(rst_edge_det_int_n),.data(clk_sync_mismatch),.clk_dst(clk_dps),.rst_dst_n(rst_dps_n),.data_sync(clk_sync_mismatch_sync));

  IW_async_pulses #(.WIDTH(2))  u_IW_async_pulses_clk_sync_stable
    (.clk_src(clk_edge_det),.rst_src_n(rst_edge_det_int_n),.data(clk_sync_stable),.clk_dst(clk_dps),.rst_dst_n(rst_dps_n),.data_sync(clk_sync_stable_sync));

  /*  Create  Power on reset for pll  */
  always@(posedge clk_dps,  negedge rst_dps_n)
  begin
    if(~rst_dps_n)
    begin
      pll_pow_reset       <=  {16{1'b1}};
    end
    else
    begin
      pll_pow_reset       <=  {pll_pow_reset[14:0],1'b0};
    end
  end

  assign  pll_reset = pll_pow_reset[15];

  /*  Synchronize signals for debug */
  `define gen_dbg_sync(signal_name,signal_width) \
    wire  signal_name``_dbg_sync; \
    IW_fpga_double_sync #(.WIDTH(signal_width),.NUM_STAGES(2)) u_``signal_name (.clk(clk_dps),.sig_in(signal_name),.sig_out(signal_name``_dbg_sync));

  `gen_dbg_sync(rst_edge_det_int_n,1)
  `gen_dbg_sync(rst_pll_n,1)
  `gen_dbg_sync(rst_dps_int_n,1)
  `gen_dbg_sync(pll_dps_rst_clk_sync_n,1)
  `gen_dbg_sync(pll_locked,1)
  `gen_dbg_sync(pll_reset,1)

  `undef  gen_dbg_sync
 
  /*  Instantiate CSR */
  IW_fpga_pll_internal_dps_sync_addr_map_avmm_wrapper #(
     .AV_MM_ADDR_W                          (AV_MM_ADDR_W)
    ,.AV_MM_DATA_W                          (AV_MM_DATA_W)
    ,.READ_MISS_VAL                         (32'hdeadbabe)

    ,.PLL_NUM_CLKS                          (NUM_PLL_CLOCKS)
    ,.EDGE_DET_CNTR_W                       (EDGE_DET_CNTR_W)
    ,.DPS_WAIT_FOR_PHASE_DONE_EDGE_N_LEVEL  (WAIT_FOR_PHASE_DONE_EDGE_N_LEVEL)
    ,.DPS_NUM_SHIFTS_PER_CYCLE              (NUM_SHIFTS_PER_CYCLE)
    ,.DPS_MIN_CLK_SYNC_FAIL_CYCLES          (MIN_CLK_SYNC_FAIL_CYCLES)
    ,.DPS_MIN_CLK_SYNC_PASS_CYCLES          (MIN_CLK_SYNC_PASS_CYCLES)

  ) u_csr (

     .avs_s0_address                            (avs_s0_address          )
    ,.avs_s0_readdata                           (avs_s0_readdata         )
    ,.avs_s0_read                               (avs_s0_read             )
    ,.avs_s0_readdatavalid                      (avs_s0_readdatavalid    )
    ,.avs_s0_write                              (avs_s0_write            )
    ,.avs_s0_writedata                          (avs_s0_writedata        )
    ,.avs_s0_byteenable                         (avs_s0_byteenable       )
    ,.avs_s0_waitrequest                        (avs_s0_waitrequest      )
    ,.csi_clk                                   (clk_dps                 )
    ,.rsi_reset_n                               (rst_dps_n               )

    ,.coe_clk_sync_stat_rst_edge_det_int_n      (rst_edge_det_int_n_dbg_sync      )
    ,.coe_clk_sync_stat_rst_pll_n               (rst_pll_n_dbg_sync               )
    ,.coe_clk_sync_stat_rst_dps_int_n           (rst_dps_int_n_dbg_sync           )
    ,.coe_clk_sync_stat_pll_dps_rst_clk_sync_n  (pll_dps_rst_clk_sync_n_dbg_sync  )
    ,.coe_clk_sync_stat_pll_locked              (pll_locked_dbg_sync              )
    ,.coe_clk_sync_stat_pll_reset               (pll_reset_dbg_sync               )
    ,.coe_clk_sync_stat_dps_locked              (dps_locked                       )

    ,.coe_clk_dps_sync_fsm_pstate               (dps_sync_fsm_pstate     )
    ,.coe_clk_dps_cntrl_fsm_pstate              (dps_cntrl_fsm_pstate    )
    ,.coe_clk_dps_pass_win_len                  (dps_pass_win_len        )
    ,.coe_clk_sync_loss_cnt                     (32'd0)
    ,.coe_clk_dps_find_fail0_shift_cnt          (dps_find_fail0_shift_cnt)
    ,.coe_clk_dps_find_pass0_shift_cnt          (dps_find_pass0_shift_cnt)
    ,.coe_clk_dps_find_fail1_shift_cnt          (dps_find_fail1_shift_cnt)
    ,.coe_clk_dps_lock_dps_shift_cnt            (dps_lock_dps_shift_cnt  )
    ,.coe_clk_dps_consec_sync_pass_cnt          (dps_consec_sync_pass_cnt)
    ,.coe_clk_dps_consec_fail_cnt               (dps_consec_sync_fail_cnt)
    ,.coe_clk_dps_lock_target_cnt               (dps_lock_target_cnt     )
    ,.coe_clk_dps_lock_slip_cnt                 (dps_lock_slip_cnt       )

  );



endmodule // IW_fpga_pll_internal_dps_sync
