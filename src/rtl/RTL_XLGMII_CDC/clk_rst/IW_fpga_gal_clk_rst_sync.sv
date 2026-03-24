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
 -- Module Name       : IW_fpga_gal_clk_rst_sync
 -- Author            : Gregory James
 -- Associated modules: 
 -- Function          : 
 --------------------------------------------------------------------------
*/

`timescale 1ns / 10ps


module IW_fpga_gal_clk_rst_sync #(
      parameter MODULE_NAME                 = "IW_fpga_gal_clk_rst_sync"
    , parameter FPGA_FAMILY                 = "S10"

    //Gal Sync parameters
    , parameter GAL_NUM_CLOCKS              = 1
    , parameter USYNC_GAL_OFFSET            = 3 //Number of cycles before GAL point to generate usync pulse
    , parameter GAL_EDGE_DET_CNTR_W         = 8
    , parameter GAL_CNTR_W                  = 16
    , parameter GAL_FREQ_DIV                = 1
    , parameter GAL_LOGIC_TAP               = 0 //Which logic clock to run GAL counter mux/demux
    , parameter GAL_USYNC_SKIP_CNT          = 3 //Number of usync pulses to skip after reset
    , parameter GAL_SYNC_START_TIMEOUT      = 128   //Maximum number of continuos zero counts received
    , parameter CLK_LOGIC_DIV_VALUE         = 1 // GAL window redefined using a subset of divider value of clock GAL_LOGIC_TAP

    , parameter GAL_SYN_MASTER              = 1
    , parameter GAL_CNT_IN_BUFFER           = 0 //1->Use demux on line GAL_SYNC_CNT_IN_IO,  0->No demux on line GAL_SYNC_CNT_IN_IO
    , parameter GAL_CNT_OUT_BUFFER          = 0 //1->Use mux on line GAL_SYNC_CNT_OUT_IO,  0->No mux on line GAL_SYNC_CNT_OUT_IO
    , parameter GAL_CNT_OUT_WIDTH           = 1 //Width of GAL_SYNC_CNT_OUT_IO. Clock count sync out will be replicated on each pin
    , parameter GAL_CNT_IN_MUX_RATIO        = 6
    , parameter GAL_CNT_IN_CLK_RATIO        = 4
    , parameter GAL_CNT_OUT_MUX_RATIO       = 6
    , parameter GAL_CNT_OUT_CLK_RATIO       = 4

    //DPS Parameters
    , parameter DPS_PHASE_EN_PULSE_W                  = 2 //Number of clocks to assert pll_phase_en. Should be at least 2 clocks.
    , parameter DPS_NUM_PLL_CLOCKS                    = 1
    , parameter DPS_NUM_SHIFTS_PER_CYCLE              = 1 //Number of shifts per cycle
    , parameter DPS_MIN_CLK_SYNC_FAIL_CYCLES          = 5 //Minimum number of consecutive cycles that result in clk_sync_mismatch=1
    , parameter DPS_MIN_CLK_SYNC_PASS_CYCLES          = 5 //Minimum number of consecutive cycles that result in clk_sync_stable=1
    , parameter DPS_MAX_LOCK_FAIL_CYCLES              = 3 //Maximum number of consecutive fail cycles allowed in LOCK_DPS_S
    , parameter DPS_LOCK_DPS_TAP                      = 0 //0(default)-> Lock to 50% of pass window
                                                          //1->Lock to 25% of pass window
                                                          //2->Lock to 75% of pass window
    , parameter DPS_WAIT_FOR_PHASE_DONE_EDGE_N_LEVEL  = 0 //1->The FSM will wait for 0->1 transition/edge on pll_phase_done
                                                          //0->The FSM Will wait until pll_phase_done level is high
    , parameter DPS_CNTR_W                            = 32

    //AV-MM Parameters
    , parameter AV_MM_ADDR_W                          = 11
    , parameter AV_MM_DATA_W                          = 32
    , parameter AV_MM_READ_MISS_VAL                   = 32'hdeadbabe


) (

  //Fast clock
    input   logic                         clk_fast

  //Logic Clocks
  , input   logic [GAL_NUM_CLOCKS-1:0]    clk_logic_vec

  //Mux-Demux clock, reset
  , input   logic                         clk_in_mux_demux
  , input   logic                         clk_out_mux_demux

  , inout   wire                          GAL_SYNC_CNT_IN_IO
  , inout   wire  [GAL_CNT_OUT_WIDTH-1:0] GAL_SYNC_CNT_OUT_IO

  , output  logic                         clk_en 
  //Usync
  , output  logic [GAL_NUM_CLOCKS-1:0]    usync_vec
  , output  logic [GAL_CNTR_W-1:0]        out_clk_logic_gal_cntr

  //DPS Clock
  , input   wire                          clk_dps
  , input   wire                          rst_dps_n

  //List of PLL outputs to shift in order
  , input   wire  [4:0]                   pll_clk_tap [DPS_NUM_PLL_CLOCKS-1:0]

  //PLL Interface
  , output  wire                          pll_reset
  , input   wire                          pll_locked
  , output  wire                          pll_updn
  , output  wire  [4:0]                   pll_cnt_sel
  , output  wire                          pll_phase_en
  , input   wire                          pll_phase_done

  /*  PLL Sync Lock Status  */
  , output  wire                          gal_sync_lock

  /*  AV-MM Interface - runs @clk_dps */
  , input   wire   [AV_MM_ADDR_W-1:0]     avs_s0_address
  , output  wire   [AV_MM_DATA_W-1:0]     avs_s0_readdata
  , input   wire                          avs_s0_read
  , output  wire                          avs_s0_readdatavalid
  , input   wire                          avs_s0_write
  , input   wire   [AV_MM_DATA_W-1:0]     avs_s0_writedata
  , input   wire   [(AV_MM_DATA_W/8)-1:0] avs_s0_byteenable
  , output  wire                          avs_s0_waitrequest
  , output  wire  [2:0]                   pll_out_shift


);

//----------------------- Import Packages ---------------------------------


//----------------------- Internal Parameters -----------------------------
  parameter NUM_GAL_DERIVATIVE_CLOCKS = 2;
  parameter integer GAL_DERIVATIVE_CLOCK_RATIOS [NUM_GAL_DERIVATIVE_CLOCKS-1:0] = '{GAL_CNT_IN_CLK_RATIO,GAL_CNT_OUT_CLK_RATIO};



//----------------------- Internal Register Declarations ------------------
  genvar  i;
  logic   [15:0]              pll_pow_reset;
  logic   [DPS_CNTR_W-1:0]    clk_sync_loss_cntr;
  logic                       gal_sync_lock_sync_1d;


//----------------------- Internal Wire Declarations ----------------------
  wire                          gal_clk_sync_mismatch;
  wire                          gal_clk_sync_stable;
  wire                          gal_clk_sync_start_timeout;
  wire                          gal_sync_lock_sync;

  wire                          rst_logic_trigger_n;
  wire                          rst_fast_n;
  wire  [GAL_NUM_CLOCKS-1:0]    rst_logic_vec_n;

  wire                          rst_dps_internal_n;
  wire                          dps_rst_clk_sync_n;
  wire                          dps_locked;
  wire  [2:0]                   dps_cntrl_fsm_pstate;
  wire  [2:0]                   dps_sync_fsm_pstate;
  wire  [DPS_CNTR_W-1:0]        dps_pass_win_len;
  wire  [DPS_CNTR_W-1:0]        dps_find_fail0_shift_cnt;
  wire  [DPS_CNTR_W-1:0]        dps_find_pass0_shift_cnt;
  wire  [DPS_CNTR_W-1:0]        dps_find_fail1_shift_cnt;
  wire  [DPS_CNTR_W-1:0]        dps_lock_dps_shift_cnt;
  wire  [DPS_CNTR_W-1:0]        dps_consec_sync_pass_cnt;
  wire  [DPS_CNTR_W-1:0]        dps_consec_sync_fail_cnt;
  wire  [DPS_CNTR_W-1:0]        dps_lock_target_cnt;
  wire  [DPS_CNTR_W-1:0]        dps_lock_slip_cnt;

  wire  [NUM_GAL_DERIVATIVE_CLOCKS-1:0] rst_gal_logic_derivatives_n;
  wire                                  rst_in_mux_demux_n;
  wire                                  rst_out_mux_demux_n;

//----------------------- Start of Code -----------------------------------

  /*  Instantiate GAL detection & sync logic  */
  IW_fpga_gal_sync #(
     .FPGA_FAMILY                   (FPGA_FAMILY                   )

    ,.NUM_CLOCKS                    (GAL_NUM_CLOCKS                )
    ,.USYNC_GAL_OFFSET              (USYNC_GAL_OFFSET              )
    ,.EDGE_DET_CNTR_W               (GAL_EDGE_DET_CNTR_W           )
    ,.GAL_CNTR_W                    (GAL_CNTR_W                    )
    ,.GAL_FREQ_DIV                  (GAL_FREQ_DIV                  )
    ,.GAL_LOGIC_TAP                 (GAL_LOGIC_TAP                 )
    ,.USYNC_SKIP_CNT                (GAL_USYNC_SKIP_CNT            )
    ,.GAL_SYNC_START_TIMEOUT        (GAL_SYNC_START_TIMEOUT        )
    ,.CLK_LOGIC_DIV_VALUE           (CLK_LOGIC_DIV_VALUE           )

    ,.GAL_SYN_MASTER                (GAL_SYN_MASTER                )
    ,.GAL_CNT_IN_BUFFER             (GAL_CNT_IN_BUFFER             )
    ,.GAL_CNT_OUT_BUFFER            (GAL_CNT_OUT_BUFFER            )
    ,.GAL_CNT_OUT_WIDTH             (GAL_CNT_OUT_WIDTH             )
    ,.GAL_CNT_IN_MUX_RATIO          (GAL_CNT_IN_MUX_RATIO          )
    ,.GAL_CNT_IN_CLK_RATIO          (GAL_CNT_IN_CLK_RATIO          )
    ,.GAL_CNT_OUT_MUX_RATIO         (GAL_CNT_OUT_MUX_RATIO         )
    ,.GAL_CNT_OUT_CLK_RATIO         (GAL_CNT_OUT_CLK_RATIO         )

  ) u_IW_fpga_gal_sync  (

     .clk_fast                      (clk_fast                      )
    ,.rst_fast_n                    (rst_fast_n                    )

    ,.clk_logic_vec                 (clk_logic_vec                 )
    ,.rst_logic_vec_n               (rst_logic_vec_n               )
    ,.clk_en                        (clk_en                        )  

    ,.clk_in_mux_demux              (clk_in_mux_demux              )
    ,.rst_in_mux_demux_n            (rst_in_mux_demux_n            )

    ,.clk_out_mux_demux             (clk_out_mux_demux             )
    ,.rst_out_mux_demux_n           (rst_out_mux_demux_n           )

    ,.GAL_SYNC_CNT_IN_IO            (GAL_SYNC_CNT_IN_IO            )
    ,.GAL_SYNC_CNT_OUT_IO           (GAL_SYNC_CNT_OUT_IO           )

    ,.gal_sync_mismatch             (gal_clk_sync_mismatch         )
    ,.gal_sync_stable               (gal_clk_sync_stable           )
    ,.gal_sync_start_timeout        (gal_clk_sync_start_timeout    )
    ,.gal_sync_complete             (gal_sync_lock                 )

    ,.usync_vec                     (usync_vec                     )
    ,.out_clk_logic_gal_cntr        (out_clk_logic_gal_cntr        )

  );


  /*  Instantiate DPS Sync  */
  generate
    if(GAL_SYN_MASTER ==  0)
    begin
      IW_fpga_pll_dps_sync #(
         .MODULE_NAME                       ({MODULE_NAME,"_IW_fpga_pll_dps_sync"} )
        ,.PHASE_EN_PULSE_W                  (DPS_PHASE_EN_PULSE_W                  )
        ,.NUM_PLL_CLOCKS                    (1                                     )
        ,.NUM_SHIFTS_PER_CYCLE              (DPS_NUM_SHIFTS_PER_CYCLE              )
        ,.MIN_CLK_SYNC_FAIL_CYCLES          (DPS_MIN_CLK_SYNC_FAIL_CYCLES          )
        ,.MIN_CLK_SYNC_PASS_CYCLES          (DPS_MIN_CLK_SYNC_PASS_CYCLES          )
        ,.MAX_LOCK_FAIL_CYCLES              (DPS_MAX_LOCK_FAIL_CYCLES              )
        ,.LOCK_DPS_TAP                      (DPS_LOCK_DPS_TAP                      )
        ,.WAIT_FOR_PHASE_DONE_EDGE_N_LEVEL  (DPS_WAIT_FOR_PHASE_DONE_EDGE_N_LEVEL  )
        ,.CNTR_W                            (DPS_CNTR_W                            )

      ) u_IW_fpga_pll_dps_sync  (

         .clk                               (clk_dps                           )
        ,.rst_n                             (rst_dps_internal_n                )

        ,.clk_sync_mismatch                 (gal_clk_sync_mismatch             )
        ,.clk_sync_stable                   (gal_clk_sync_stable               )
        ,.clk_sync_start_timeout            (gal_clk_sync_start_timeout        )
        ,.pll_stable_cnt_sel                ()

// global shift for all clocks
        ,.pll_clk_tap                       ('{5'b01111}                       )

        ,.pll_updn                          (pll_updn                          )
        ,.pll_cnt_sel                       (pll_cnt_sel                       )
        ,.pll_phase_en                      (pll_phase_en                      )
        ,.pll_phase_done                    (pll_phase_done                    )

        ,.rst_clk_sync_n                    (dps_rst_clk_sync_n                )
        ,.dps_locked                        (dps_locked                        )
        ,.dps_cntrl_fsm_pstate              (dps_cntrl_fsm_pstate              )
        ,.dps_sync_fsm_pstate               (dps_sync_fsm_pstate               )
        ,.dps_pass_win_len                  (dps_pass_win_len                  )

        ,.dps_find_fail0_shift_cnt          (dps_find_fail0_shift_cnt          )
        ,.dps_find_pass0_shift_cnt          (dps_find_pass0_shift_cnt          )
        ,.dps_find_fail1_shift_cnt          (dps_find_fail1_shift_cnt          )
        ,.dps_lock_dps_shift_cnt            (dps_lock_dps_shift_cnt            )
        ,.dps_consec_sync_pass_cnt          (dps_consec_sync_pass_cnt          )
        ,.dps_consec_sync_fail_cnt          (dps_consec_sync_fail_cnt          )
        ,.dps_lock_target_cnt               (dps_lock_target_cnt               )
        ,.dps_lock_slip_cnt                 (dps_lock_slip_cnt                 )
        ,.pll_out_shift                     (pll_out_shift                     )

      );
    end
    else  //GAL_SYN_MASTER  ==  1
    begin
      assign  pll_updn      = 1'b0;
      assign  pll_cnt_sel   = 5'd0;
      assign  pll_phase_en  = 1'b0;

      assign  dps_rst_clk_sync_n    = 1'b1;
      assign  dps_locked            = pll_locked;
      assign  dps_cntrl_fsm_pstate  = 3'd0;
      assign  dps_sync_fsm_pstate   = 3'd0;

      assign  dps_pass_win_len          = {DPS_CNTR_W{1'b0}};
      assign  dps_find_fail0_shift_cnt  = {DPS_CNTR_W{1'b0}};
      assign  dps_find_pass0_shift_cnt  = {DPS_CNTR_W{1'b0}};
      assign  dps_find_fail1_shift_cnt  = {DPS_CNTR_W{1'b0}};
      assign  dps_lock_dps_shift_cnt    = {DPS_CNTR_W{1'b0}};
      assign  dps_consec_sync_pass_cnt  = {DPS_CNTR_W{1'b0}};
      assign  dps_consec_sync_fail_cnt  = {DPS_CNTR_W{1'b0}};
      assign  dps_lock_target_cnt       = {DPS_CNTR_W{1'b0}};
      assign  dps_lock_slip_cnt         = {DPS_CNTR_W{1'b0}};
    end
  endgenerate

  assign  gal_sync_lock = dps_locked;

  assign  rst_logic_trigger_n = dps_rst_clk_sync_n  & pll_locked;

  /*  Generate synchronous resets */
  // removal slack fails due to async rst
  //IW_sync_reset#(.NUM_STAGES(2))  u_IW_sync_reset_rst_fast_n          (.clk(clk_fast),.rst_n(rst_logic_trigger_n),.rst_n_sync(rst_fast_n));
  IW_fpga_double_sync #( .WIDTH(1), .NUM_STAGES(2)) u_IW_sync_reset_rst_fast_n  (.clk(clk_fast),.sig_in(rst_logic_trigger_n),.sig_out(rst_fast_n));
//  IW_sync_reset#(.NUM_STAGES(2))  u_IW_sync_reset_rst_dps_internal_n  (.clk(clk_dps),.rst_n(rst_dps_n & pll_locked),.rst_n_sync(rst_dps_internal_n));
  IW_fpga_double_sync #( .WIDTH(1), .NUM_STAGES(2)) u_IW_sync_reset_rst_dps_internal_n  (.clk(clk_dps),.sig_in(rst_dps_n & pll_locked),.sig_out(rst_dps_internal_n));


  generate
    for(i=0;i<GAL_NUM_CLOCKS;i++)
    begin : gen_rst_logic_vec_n
      //IW_sync_reset#(.NUM_STAGES(2))  u_IW_sync_reset_rst_logic_vec_n (.clk(clk_logic_vec[i]),.rst_n(rst_logic_trigger_n),.rst_n_sync(rst_logic_vec_n[i]));
      IW_sync_reset#(.NUM_STAGES(2))  u_IW_sync_reset_rst_logic_vec_n (.clk(clk_logic_vec[i]),.rst_n(rst_fast_n),.rst_n_sync(rst_logic_vec_n[i]));
    end
  endgenerate

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


  /*  Generate gal sync mux/demux resets  */
  IW_fpga_clk_rst_derivatives_gen #(
     .NUM_DERIVATIVE_CLOCKS     (NUM_GAL_DERIVATIVE_CLOCKS)
    ,.DERIVATIVE_CLOCK_RATIOS   (GAL_DERIVATIVE_CLOCK_RATIOS)
   
  ) u_IW_fpga_clk_rst_derivatives_gen (

     .clk_logic                 (clk_logic_vec[GAL_LOGIC_TAP])
    ,.rst_logic_n               (rst_fast_n)
    ,.clk_en                    (clk_en )  

    ,.clk_logic_derivatives     ({clk_in_mux_demux,clk_out_mux_demux})
    ,.rst_logic_derivatives_n   (rst_gal_logic_derivatives_n)

  );

  assign  {rst_in_mux_demux_n,rst_out_mux_demux_n}  = rst_gal_logic_derivatives_n;


  /*  GAL Sync Loss Counter Logic */
  IW_sync_posedge#(.WIDTH(1),.NUM_STAGES(2))  u_IW_sync_posedge_gal_sync_lock (.clk(clk_dps),.rst_n(rst_dps_n),.data(gal_sync_lock),.data_sync(gal_sync_lock_sync));

  always@(posedge clk_dps, negedge rst_dps_n)
  begin
    if(~rst_dps_n)
    begin
      gal_sync_lock_sync_1d   <=  0;
      clk_sync_loss_cntr      <=  0;
    end
    else
    begin
      gal_sync_lock_sync_1d   <=  gal_sync_lock_sync;

      //Increment counter each time clock sync is lost
      clk_sync_loss_cntr      <=  clk_sync_loss_cntr  + (~gal_sync_lock_sync  & gal_sync_lock_sync_1d);
    end
  end

  /*  Synchronize signals for debug */
  `define gen_dbg_sync(signal_name,signal_width) \
    wire [signal_width-1 : 0] signal_name``_dbg_sync; \
    IW_fpga_double_sync #(.WIDTH(signal_width),.NUM_STAGES(2)) u_``signal_name (.clk(clk_dps),.sig_in(signal_name),.sig_out(signal_name``_dbg_sync));

  `gen_dbg_sync(dps_locked,1)
  `gen_dbg_sync(pll_reset,1)
  `gen_dbg_sync(pll_locked,1)
  `gen_dbg_sync(rst_logic_vec_n,GAL_NUM_CLOCKS)
  `gen_dbg_sync(rst_fast_n,1)
  `gen_dbg_sync(rst_logic_trigger_n,1)
  `gen_dbg_sync(dps_rst_clk_sync_n,1)
  `gen_dbg_sync(rst_dps_internal_n,1)
  `gen_dbg_sync(gal_clk_sync_start_timeout,1)
  `gen_dbg_sync(gal_clk_sync_stable,1)
  `gen_dbg_sync(gal_clk_sync_mismatch,1)

  `undef  gen_dbg_sync
 
  /*  CSR */
  IW_fpga_gal_clk_rst_sync_addr_map_avmm_wrapper #(
     .AV_MM_ADDR_W                  (AV_MM_ADDR_W                  )
    ,.AV_MM_DATA_W                  (AV_MM_DATA_W                  )
    ,.READ_MISS_VAL                 (AV_MM_READ_MISS_VAL           )

    ,.GAL_NUM_CLOCKS                (GAL_NUM_CLOCKS                )
    ,.GAL_SYN_MASTER                (GAL_SYN_MASTER                )
    ,.GAL_SYNC_START_TIMEOUT        (GAL_SYNC_START_TIMEOUT        )
    ,.GAL_CNT_IN_BUFFER             (GAL_CNT_IN_BUFFER             )
    ,.GAL_CNT_OUT_BUFFER            (GAL_CNT_OUT_BUFFER            )
    ,.GAL_CNT_IN_MUX_RATIO          (GAL_CNT_IN_MUX_RATIO          )
    ,.GAL_CNT_IN_CLK_RATIO          (GAL_CNT_IN_CLK_RATIO          )
    ,.GAL_CNT_OUT_MUX_RATIO         (GAL_CNT_OUT_MUX_RATIO         )
    ,.GAL_CNT_OUT_CLK_RATIO         (GAL_CNT_OUT_CLK_RATIO         )
    ,.GAL_FREQ_DIV                  (GAL_FREQ_DIV                  )
    ,.GAL_CNTR_W                    (GAL_CNTR_W                    )
    ,.GAL_EDGE_DET_CNTR_W           (GAL_EDGE_DET_CNTR_W           )
    ,.USYNC_GAL_OFFSET              (USYNC_GAL_OFFSET              )
    ,.GAL_USYNC_SKIP_CNT            (GAL_USYNC_SKIP_CNT            )
    ,.GAL_LOGIC_TAP                 (GAL_LOGIC_TAP                 )

    ,.DPS_NUM_SHIFTS_PER_CYCLE      (DPS_NUM_SHIFTS_PER_CYCLE      )
    ,.DPS_MIN_CLK_SYNC_FAIL_CYCLES  (DPS_MIN_CLK_SYNC_FAIL_CYCLES  )
    ,.DPS_MIN_CLK_SYNC_PASS_CYCLES  (DPS_MIN_CLK_SYNC_PASS_CYCLES  )

  ) u_csr (

     .csi_clk                                       (clk_dps)
    ,.rsi_reset_n                                   (rst_dps_n)
   
    ,.avs_s0_address                                (avs_s0_address      )
    ,.avs_s0_readdata                               (avs_s0_readdata     )
    ,.avs_s0_read                                   (avs_s0_read         )
    ,.avs_s0_readdatavalid                          (avs_s0_readdatavalid)
    ,.avs_s0_write                                  (avs_s0_write        )
    ,.avs_s0_writedata                              (avs_s0_writedata    )
    ,.avs_s0_byteenable                             (avs_s0_byteenable   )
    ,.avs_s0_waitrequest                            (avs_s0_waitrequest  )

    ,.clk_sync_stat_dps_locked                      (dps_locked_dbg_sync)
    ,.clk_sync_stat_pll_reset                       (pll_reset_dbg_sync)
    ,.clk_sync_stat_pll_locked                      (pll_locked_dbg_sync)
    ,.clk_sync_stat_rst_logic_vec_n                 (rst_logic_vec_n_dbg_sync)
    ,.clk_sync_stat_rst_fast_n                      (rst_fast_n_dbg_sync)
    ,.clk_sync_stat_rst_logic_trigger_n             (rst_logic_trigger_n_dbg_sync)
    ,.clk_sync_stat_dps_rst_clk_sync_n              (dps_rst_clk_sync_n_dbg_sync)
    ,.clk_sync_stat_rst_dps_internal_n              (rst_dps_internal_n_dbg_sync)
    ,.clk_sync_stat_gal_clk_sync_start_timeout      (gal_clk_sync_start_timeout_dbg_sync)
    ,.clk_sync_stat_gal_clk_sync_stable             (gal_clk_sync_stable_dbg_sync)
    ,.clk_sync_stat_gal_clk_sync_mismatch           (gal_clk_sync_mismatch_dbg_sync)

    ,.dps_sync_fsm_pstate                           ({{(16-3){1'b0}},dps_sync_fsm_pstate})
    ,.dps_cntrl_fsm_pstate                          ({{(16-3){1'b0}},dps_cntrl_fsm_pstate})
    ,.dps_pass_win_len                              (dps_pass_win_len)
    ,.clk_sync_loss_cnt                             (clk_sync_loss_cntr)
    ,.dps_find_fail0_shift_cnt                      (dps_find_fail0_shift_cnt)
    ,.dps_find_pass0_shift_cnt                      (dps_find_pass0_shift_cnt)
    ,.dps_find_fail1_shift_cnt                      (dps_find_fail1_shift_cnt)
    ,.dps_lock_dps_shift_cnt                        (dps_lock_dps_shift_cnt)
    ,.dps_consec_sync_pass_cnt                      (dps_consec_sync_pass_cnt)
    ,.dps_consec_fail_cnt                           (dps_consec_sync_fail_cnt)
    ,.dps_lock_target_cnt                           (dps_lock_target_cnt)
    ,.dps_lock_slip_cnt                             (dps_lock_slip_cnt)

  );



endmodule // IW_fpga_gal_clk_rst_sync
