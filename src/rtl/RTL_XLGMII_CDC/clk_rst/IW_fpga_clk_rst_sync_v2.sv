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
// File Name:     $RCSfile: IW_fpga_clk_rst_sync_v2.sv.rca $
// File Revision: $Revision: 1.3 $
// Created by:    Gregory James
// Updated by:    $Author: gjames $ $Date: Wed Feb 24 00:05:54 2016 $
//------------------------------------------------------------------------------

`timescale  1ns/1ps

module  IW_fpga_clk_rst_sync_v2 #(
    parameter MODULE_NAME             = "IW_fpga_clk_rst_sync_v2"
  , parameter ENABLE_CLK_SYNC         = 1     //Set this parameter to 1 to enable clock sync logic
  , parameter NUM_PLL_CLOCKS          = 1     //Number of clocks generated from PLL
  , parameter NUM_DERIVATIVE_CLOCKS   = 1     //Number of clocks derived from clk_logic
  , parameter integer DERIVATIVE_CLOCK_RATIOS [NUM_DERIVATIVE_CLOCKS-1:0] = '{2} 
                                              //List of ratios of derivative clocks wrt clk_logic
                                              //Order must match that of clk_logic_derivatives
  , parameter CLK_SYN_MASTER         = 1
  , parameter PARAM_WIDTH            = 32
  , parameter START_OFFSET_POSITION  = 0
  , parameter END_OFFSET_POSITION    = 8
  , parameter NUM_ITERATIONS         = 1
  , parameter MIN_PULSE_WIDTH        = 1
  , parameter MAX_PULSE_WIDTH        = 1
  , parameter VCO_SHIFT_PER_PULSE    = 6*8 //6 clocks for 1200 MHz / 200 MHz : 2.5 MHz
                                           //6 clocks for 1200 MHz / 200 MHz : 4 MHz
  , parameter CLOCK_RATIO            = 80    // 80, 200/2.5
                                           // 50, 200/4
  , parameter UPSTREAM_WIDTH         = 1
  , parameter SERDES_ENABLE_ALIGN_CNT = 2**17 //Number of clk_logic cyles after sync_lock before enabling align
  //parameters for usync module
  , parameter CLK_LOGIC_DIV_VALUE = 1 
  , parameter GAL_FREQ_DIV        = 1 
  , parameter GAL_CNTR_W          = 1 
  , parameter GAL_EDGE_DET_CNTR_W = 1 
  , parameter GAL_LOGIC_TAP       = 0 
  , parameter USYNC_GAL_OFFSET    = 3 //Number of cycles before GAL point to generate usync pulse  
  , parameter GAL_NUM_CLOCKS      = 3   
  , parameter GAL_CNT_OUT_BUFFER  = 0
  , parameter MC_FAST_CLK_SHIFT   = 0 //0->Shift by 1 (supported by gal sync)
                                      //1->Shift by 4 to make simulation fast (supported by MC clk sync)
  
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


  , inout   wire  o_downstream_tx
  , inout   wire  i_downstream_rx

  , inout   wire [UPSTREAM_WIDTH-1:0] i_upstream_rx
  , inout   wire [UPSTREAM_WIDTH-1:0] o_upstream_tx
  
  /*  Clock Sync Mux/Demux */
  , input   wire  i_clk_fast

  /* List of PLL outputs to shift in order */
  , input   wire  [4:0]   pll_clk_tap [NUM_PLL_CLOCKS-1:0]
  
  /* gal signals */
  , input   wire                          gal_sync_lock
  , input  logic  [GAL_NUM_CLOCKS-1:0]    clk_logic_vec 
  , output  wire                          o_cal_success
  , input  logic                          pin_rst_n 
  , input  logic                          all_clk_sync_lock 

  /*  PLL Interface */
  , output  wire                          pll_reset
  , input   wire                          locked_logic_pll
  , output  wire                          pll_phase_en
  , output  wire                          pll_updn
  , output  wire  [4:0]                   pll_cntsel
  , input   wire                          pll_phase_done
  , output  wire  [2:0]                   pll_out_shift

  /*  PLL Sync Lock Status  */
  , output  wire                          clk_logic_sync_lock

  /*  Clock & its derivatives */
  , input   wire                              clk_logic
  , input   wire  [NUM_DERIVATIVE_CLOCKS-1:0] clk_logic_derivatives
  , output  wire  [NUM_DERIVATIVE_CLOCKS-1:0] rst_logic_derivatives_n


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

  /*  Internal  Variables */
  genvar i;
  localparam  SERDES_ENABLE_ALIGN_CNTR_W  = $clog2(SERDES_ENABLE_ALIGN_CNT) + 1;
  reg   [15:0]                            pll_pow_reset;

  wire                                    rst_logic_trigger_n;
  wire                                    pll_dps_rst_clk_sync_n;
  reg   [3:0]                             rst_logic_sync_pipe;
  wire                                    rst_logic_sync_n;
  wire                                    rst_logic_n;
  reg   [1:0]                             rst_logic_mon_sync_pipe;
  wire                                    rst_logic_mon_n;
  wire                                    dps_locked;

  reg   [1:0]                             serdes_clk_sync_done_sync;
  reg   [SERDES_ENABLE_ALIGN_CNTR_W-1:0]  serdes_enable_align_cntr;
  reg                                     serdes_enable_align;
  wire                                    serdes_clk_sync_done;

  logic [9:0]                             s_master_calibrate_fsm;
  logic [4:0]                             s_tx_calibrate_fsm;
  logic [PARAM_WIDTH-1:0]                 s_hit_tx_offset;
  logic [PARAM_WIDTH-1:0]                 s_hit_rx_offset;
  logic [PARAM_WIDTH-1:0]                 s_hit_iterations;
  logic [PARAM_WIDTH-1:0]                 s_hit_pulse_width;
  logic                                   s_cal_success;
  logic                                   s_failure_detected;
  logic [PARAM_WIDTH-1:0]                 s_dps_f0f1_point_diff;
  logic [PARAM_WIDTH-1:0]                 s_failure_detected_cntr;
  logic [GAL_NUM_CLOCKS-1:0]              rst_logic_vec_n; 
  logic                                   o_rst_clk_sync_n; 

  /*  Create  Power on reset for pll  */
  always@(posedge clk_mon,  negedge rst_mon_n)
  begin
    if(~rst_mon_n)
      pll_pow_reset       <=  {16{1'b1}};
    else
      pll_pow_reset       <=  {pll_pow_reset[14:0],1'b0};
  end
  assign  pll_reset       = pll_pow_reset[15];

  /*  Reset PLL based on sync scheme  */
  generate
    if(ENABLE_CLK_SYNC  ==  1)
      assign  rst_logic_trigger_n = o_rst_clk_sync_n & locked_logic_pll;
      IW_fpga_double_sync #(
         .WIDTH(1)
        ,.NUM_STAGES(2)
      ) u_IW_sync_reset_rst_fast_n (
         .clk(i_clk_fast)
        ,.sig_in(rst_logic_trigger_n)
        ,.sig_out(rst_fast_n)
      ); 
  endgenerate

  generate
    for(i=0;i<GAL_NUM_CLOCKS;i++)
    begin : gen_rst_logic_vec_n
      IW_sync_reset #(
        .NUM_STAGES(2)
      ) u_IW_sync_reset_rst_logic_vec_n (
        .clk(clk_logic_vec[i])
       ,.rst_n(rst_fast_n)
       ,.rst_n_sync(rst_logic_vec_n[i])
      );
    end
  endgenerate

  /*  Synchronize Logic Reset  */
  always@(posedge clk_logic,  negedge rst_logic_trigger_n)
  begin
    if(~rst_logic_trigger_n)
      rst_logic_sync_pipe     <=  0;
    else
      rst_logic_sync_pipe     <=  {rst_logic_sync_pipe[2:0],1'b1};
  end

  assign  rst_logic_sync_n    =   rst_logic_sync_pipe[1];
  assign  rst_logic_n         =   rst_logic_sync_pipe[3];


  /*  Keep Internal MON clock reset active until PLL is locked*/
  always@(posedge clk_mon,  negedge locked_logic_pll)
  begin
    if(~locked_logic_pll)
      rst_logic_mon_sync_pipe <=  0;
    else
      rst_logic_mon_sync_pipe <=  {rst_logic_mon_sync_pipe[0],1'b1};
  end
  assign  rst_logic_mon_n     =   rst_logic_mon_sync_pipe[1];


  /*  Synchronize Derivative Resets  */
  IW_fpga_clk_rst_derivatives_gen #(
     .NUM_DERIVATIVE_CLOCKS     (NUM_DERIVATIVE_CLOCKS)
    ,.DERIVATIVE_CLOCK_RATIOS   (DERIVATIVE_CLOCK_RATIOS)
  ) u_IW_fpga_clk_rst_derivatives_gen (
     .clk_logic                 (clk_logic)
    ,.rst_logic_n               (rst_logic_sync_n)
    ,.clk_logic_derivatives     (clk_logic_derivatives)
    ,.rst_logic_derivatives_n   (rst_logic_derivatives_n)
  );

  generate
    if(ENABLE_CLK_SYNC  ==  1)
    begin
      IW_fpga_clk_sync_v2 #(
         .MASTER_MODULE         ( CLK_SYN_MASTER         )
        ,.PARAM_WIDTH           ( PARAM_WIDTH            )
        ,.START_OFFSET_POSITION ( START_OFFSET_POSITION  )
        ,.END_OFFSET_POSITION   ( END_OFFSET_POSITION    )
        ,.NUM_ITERATIONS        ( NUM_ITERATIONS         )
        ,.MIN_PULSE_WIDTH       ( MIN_PULSE_WIDTH        )
        ,.MAX_PULSE_WIDTH       ( MAX_PULSE_WIDTH        )
        ,.NUM_PLL_CLOCKS        ( 1                      )
        ,.VCO_SHIFT_PER_PULSE   ( VCO_SHIFT_PER_PULSE    )
        ,.CLOCK_RATIO           ( CLOCK_RATIO            )
        ,.UPSTREAM_WIDTH        ( UPSTREAM_WIDTH         )
        ,.CLK_LOGIC_DIV_VALUE   ( CLK_LOGIC_DIV_VALUE    )
        ,.GAL_FREQ_DIV          ( GAL_FREQ_DIV           )
        ,.GAL_CNTR_W            ( GAL_CNTR_W             )
        ,.EDGE_DET_CNTR_W       ( GAL_EDGE_DET_CNTR_W    )
        ,.GAL_LOGIC_TAP         ( GAL_LOGIC_TAP          )
        ,.USYNC_GAL_OFFSET      ( USYNC_GAL_OFFSET       )
        ,.NUM_CLOCKS            ( GAL_NUM_CLOCKS         )
        ,.GAL_CNT_OUT_BUFFER    ( GAL_CNT_OUT_BUFFER     )
        ,.MC_FAST_CLK_SHIFT     ( MC_FAST_CLK_SHIFT      ) 
      ) IW_fpga_clk_sync_v2 (
         .i_clk_mon               ( clk_mon                )
        ,.i_rst_mon_n             ( rst_mon_n              )
        ,.i_clk_slow              ( clk_logic              )
        ,.i_clk_fast              ( i_clk_fast             )
        ,.i_rst_n                 ( rst_fast_n             )
        ,.o_downstream_tx         ( o_downstream_tx        )
        ,.i_downstream_rx         ( i_downstream_rx        )
        ,.all_clk_sync_lock       ( all_clk_sync_lock      )
        ,.pin_rst_n               ( pin_rst_n              )
        ,.i_upstream_rx           ( i_upstream_rx          )
        ,.gal_sync_lock           ( gal_sync_lock          )
        ,.o_upstream_tx           ( o_upstream_tx          )
        ,.clk_logic_vec           ( clk_logic_vec          )
        ,.i_rst_logic_vec_n        ( rst_logic_vec_n        )
        ,.i_dps_clk_tap           ( '{5'b01111}            )
        ,.o_pll_phase_en          ( pll_phase_en           )
        ,.o_pll_updn              ( pll_updn               )
        ,.o_pll_cnt_sel           ( pll_cntsel             )
        ,.i_pll_phase_done        ( pll_phase_done         )
        ,.o_master_calibrate_fsm  ( s_master_calibrate_fsm )
        ,.o_tx_calibrate_fsm      ( s_tx_calibrate_fsm     )
        ,.o_hit_tx_offset         ( s_hit_tx_offset        )
        ,.o_hit_rx_offset         ( s_hit_rx_offset        )
        ,.o_hit_iterations        ( s_hit_iterations       )
        ,.o_hit_pulse_width       ( s_hit_pulse_width      )
        ,.o_cal_success           ( s_cal_success          )
        ,.o_failure_detected      ( s_failure_detected     )
        ,.o_dps_f0f1_point_diff   ( s_dps_f0f1_point_diff  )
        ,.o_failure_detected_cntr ( s_failure_detected_cntr)
        ,.o_rst_clk_sync_n        ( o_rst_clk_sync_n       )
        ,.pll_out_shift           ( pll_out_shift          )
      );
      assign o_cal_success = s_cal_success;
    end
    else  //~ENABLE_CLK_SYNC
    begin
      assign  pll_updn                = 1'b0;
      assign  pll_cntsel              = 5'd0;
      assign  pll_phase_en            = 1'b0;
      assign  dps_locked              = 1'b0;
      assign  pll_dps_rst_clk_sync_n  = 1'b1;
      assign  s_hit_tx_offset         = '0;
      assign  s_hit_rx_offset         = '0;
      assign  s_hit_iterations        = '0;
      assign  s_hit_pulse_width       = '0;
      assign  s_cal_success           = 1'b1;
      assign  o_downstream_tx         = '0;
      assign  o_upstream_tx           = '0;
      assign  s_failure_detected      = 1'b0;
    end
  endgenerate

  /*  PLL Clock Sync */
  generate
    if(ENABLE_CLK_SYNC  ==  1)
      assign  clk_logic_sync_lock = locked_logic_pll;
  endgenerate

  /*  Synchronize signals for debug */
  `define gen_dbg_sync(signal_name) \
    wire  signal_name``_dbg_sync; \
    IW_fpga_double_sync #(.WIDTH(1),.NUM_STAGES(2)) u_``signal_name (.clk(clk_mon),.sig_in(signal_name),.sig_out(signal_name``_dbg_sync));

  `gen_dbg_sync(clk_logic_sync_lock)
  `gen_dbg_sync(rst_logic_n)
  `gen_dbg_sync(rst_logic_mon_n)
  `gen_dbg_sync(locked_logic_pll)
  `gen_dbg_sync(pll_reset)
  `gen_dbg_sync(s_cal_success)

  /*  Address Map */
  IW_fpga_clk_rst_sync_v2_addr_map_avmm_wrapper #(
    .INSTANCE_NAME           ( MODULE_NAME             )
  , .ENABLE_CLK_SYNC         ( ENABLE_CLK_SYNC         )
  , .NUM_PLL_CLOCKS          ( NUM_PLL_CLOCKS          )
  , .NUM_DERIVATIVE_CLOCKS   ( NUM_DERIVATIVE_CLOCKS   )
  , .CLK_SYN_MASTER          ( CLK_SYN_MASTER          )
  , .PARAM_WIDTH             ( PARAM_WIDTH             )
  , .START_OFFSET_POSITION   ( START_OFFSET_POSITION   )
  , .END_OFFSET_POSITION     ( END_OFFSET_POSITION     )
  , .NUM_ITERATIONS          ( NUM_ITERATIONS          )
  , .MIN_PULSE_WIDTH         ( MIN_PULSE_WIDTH         )
  , .MAX_PULSE_WIDTH         ( MAX_PULSE_WIDTH         )
  , .VCO_SHIFT_PER_PULSE     ( VCO_SHIFT_PER_PULSE     )
  , .CLOCK_RATIO             ( CLOCK_RATIO             )
  , .UPSTREAM_WIDTH          ( UPSTREAM_WIDTH          )
  , .AV_MM_ADDR_W            ( AV_MM_ADDR_W            )
  , .AV_MM_DATA_W            ( AV_MM_DATA_W            )
  , .READ_MISS_VAL           ( AV_MM_READ_MISS_VAL     )

  ) u_addr_map  (

     .csi_clk                  (clk_mon)
    ,.rsi_reset_n              (rst_mon_n)

    ,.avs_s0_address           (avs_s0_address)
    ,.avs_s0_readdata          (avs_s0_readdata)
    ,.avs_s0_read              (avs_s0_read)
    ,.avs_s0_readdatavalid     (avs_s0_readdatavalid)
    ,.avs_s0_write             (avs_s0_write)
    ,.avs_s0_writedata         (avs_s0_writedata)
    ,.avs_s0_byteenable        (avs_s0_byteenable)
    ,.avs_s0_waitrequest       (avs_s0_waitrequest)

    ,.i_master_calibrate_fsm   (s_master_calibrate_fsm)
    ,.i_tx_calibrate_fsm       (s_tx_calibrate_fsm)
    ,.i_hit_tx_offset          (s_hit_tx_offset)
    ,.i_hit_rx_offset          (s_hit_rx_offset)
    ,.i_hit_iterations         (s_hit_iterations)
    ,.i_hit_pulse_width        (s_hit_pulse_width)
    ,.i_cal_success            (s_cal_success_dbg_sync)
    ,.i_valid_window           (s_dps_f0f1_point_diff)
    ,.i_failure_det_cnt        (s_failure_detected_cntr)
  );

  `undef  gen_dbg_sync

endmodule //IW_fpga_clk_rst_sync_v2

