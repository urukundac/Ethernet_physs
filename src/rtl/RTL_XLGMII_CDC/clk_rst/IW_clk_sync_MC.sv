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
 -- Module Name       : IW_clk_sync_MC
 -- Author            : Aniket Phapale
 -- Associated modules: 
 -- Function          : 
 --------------------------------------------------------------------------
*/
`timescale 1ns / 10ps

module IW_clk_sync_MC #(
    parameter MODULE_NAME                  = "IW_clk_sync_MC" 
   ,parameter MC_SYNC_US_WIDTH             = 1
   ,parameter USYNC_GAL_OFFSET             = 1
   ,parameter GAL_EDGE_DET_CNTR_W          = 1
   ,parameter GAL_FREQ_DIV                 = 1
   ,parameter CLK_LOGIC_DIV_VALUE          = 1
   ,parameter ENABLE_CLK_SYNC              = 1
   ,parameter NUM_CLOCKS                   = 1
   ,parameter FPGA_FAMILY                  = 1
   ,parameter NUM_ITERATIONS               = 1
   ,parameter MIN_PULSE_WIDTH              = 1
   ,parameter MAX_PULSE_WIDTH              = 1
   ,parameter VCO_SHIFT_PER_PULSE          = 1
   ,parameter PARAM_WIDTH                  = 1
   ,parameter UPSTREAM_WIDTH               = 1
   ,parameter CLK_SYN_MASTER               = 1
   ,parameter GAL_CNTR_W                   = 16
   ,parameter GAL_NUM_CLOCKS               = 1
   ,parameter GAL_LOGIC_TAP                = 1
   ,parameter NUM_PLL_CLOCKS               = 1     //Number of clocks generated from PLL
   ,parameter START_OFFSET_POSITION        = 1     
   ,parameter CLOCK_RATIO                  = 1     
   ,parameter END_OFFSET_POSITION          = 1     
   ,parameter MC_SYNC_US_EN                = 1     
   ,parameter MC_SYNC_DS_EN                = 1     
   ,parameter MC_FAST_CLK_SHIFT            = 1     
   ,parameter SERDES_ENABLE_ALIGN_CNT      = 1     
   ,parameter SYS_PLL_CLK_TAP              = 1     
   ,parameter AV_MM_ADDR_W                 = 8     
   ,parameter AV_MM_DATA_W                 = 32     
   ,parameter SERDES_CTRL_STATUS_W         = 32     
   ,parameter NUM_DERIVATIVE_CLOCKS        = 3     
) (
//----------------------- Input Declarations ------------------------------  
   input  logic                                         i_clk_fast
  ,input  logic                                         i_rst_n
  ,input  logic                                         i_gal_sync_lock
  ,input  logic                                         i_gal_usync_vec_align_point

//---------------------- Input/Output Declaration for downstream module----
  ,input  wire                                          clk_mon
  ,input  wire                                          rst_mon_n
//  ,input  wire                                          serdes_reconfig_clk

  ,inout  wire                                          o_downstream_tx
  ,inout  wire                                          i_downstream_rx

  ,inout  wire [UPSTREAM_WIDTH-1:0]                     i_upstream_rx
  ,inout  wire [UPSTREAM_WIDTH-1:0]                     o_upstream_tx
  

  /* List of PLL outputs to shift in order */
  ,input   wire  [4:0]                                 pll_clk_tap [NUM_PLL_CLOCKS-1:0]
  
  /* gal signals */
  ,input  logic  [GAL_NUM_CLOCKS-1:0]                  clk_logic_vec 
  ,output  wire                                        o_cal_success
  ,input  logic                                        pin_rst_n 
  ,input  logic                                        all_clk_sync_lock 

  /*  PLL Interface */
  ,output  wire                                        pll_reset
  ,input   wire                                        locked_logic_pll
  ,output  wire                                        pll_phase_en
  ,output  wire                                        pll_updn
  ,output  wire  [4:0]                                 pll_cntsel
  ,input   wire                                        pll_phase_done
  ,output  wire  [2:0]                                 pll_out_shift

  /*  PLL Sync Lock Status  */
  ,output  wire                                        clk_logic_sync_lock

  /*  Clock & its derivatives */
  ,input   wire                                        clk_logic
  ,input   wire  [NUM_DERIVATIVE_CLOCKS-1:0]           clk_logic_derivatives
  ,output  wire  [NUM_DERIVATIVE_CLOCKS-1:0]           rst_logic_derivatives_n


  /*  AV-MM Interface */
  ,input  wire   [AV_MM_ADDR_W-1:0]                    avs_s0_address
  ,output wire   [AV_MM_DATA_W-1:0]                    avs_s0_readdata
  ,input  wire                                         avs_s0_read
  ,output wire                                         avs_s0_readdatavalid
  ,input  wire                                         avs_s0_write
  ,input  wire   [AV_MM_DATA_W-1:0]                    avs_s0_writedata
  ,input  wire   [(AV_MM_DATA_W/8)-1:0]                avs_s0_byteenable
  ,output wire                                         avs_s0_waitrequest

  /*  Logic Analyzer Debug  */
  ,input   wire                                        SYNC_COUNT_IN_IO_DUP0
  ,input   wire                                        SYNC_COUNT_IN_IO_DUP1
  ,output  wire  [16:0]                                la_debug

);
  generate
    if (MC_SYNC_US_EN) begin
      IW_fpga_clk_sync_v2_MC_SYNC_US#(
         .MODULE_NAME                 ({"gnr_misc_sa.u_IW_fpga_clk_sync_v2_MC_SYNC_US"})
        ,.MC_SYNC_US_WIDTH            (MC_SYNC_US_WIDTH)
        //,.NUM_CLOCKS                  (GAL_NUM_CLOCKS)
        ,.GAL_CNTR_W                  (GAL_CNTR_W)
        ,.AV_MM_ADDR_W                (AV_MM_ADDR_W)
        ,.AV_MM_DATA_W                (AV_MM_DATA_W)
      ) u_IW_fpga_clk_sync_v2_MC_SYNC_US (
         .clk_mon                      (clk_mon)
        ,.rst_mon_n                    (rst_mon_n )
        ,.i_clk_fast                   (i_clk_fast)
        ,.i_clk_slow                   (clk_logic_vec[GAL_LOGIC_TAP])
        ,.i_rst_n                      (i_rst_n)
        ,.i_gal_sync_lock              (i_gal_sync_lock)
        ,.i_gal_usync_vec_align_point  (i_gal_usync_vec_align_point)

        ,.i_upstream_rx                (i_upstream_rx)
        ,.o_upstream_tx                (o_upstream_tx)

        ,.avs_s0_address               (avs_s0_address)
        ,.avs_s0_readdata              (avs_s0_readdata)
        ,.avs_s0_read                  (avs_s0_read )
        ,.avs_s0_readdatavalid         (avs_s0_readdatavalid)
        ,.avs_s0_write                 (avs_s0_write)
        ,.avs_s0_writedata             (avs_s0_writedata )
        ,.avs_s0_byteenable            (avs_s0_byteenable)
        ,.avs_s0_waitrequest           (avs_s0_waitrequest)
      );
    end 
    else if (MC_SYNC_DS_EN) begin
      IW_fpga_clk_rst_sync_v2 #(
         .MODULE_NAME                 ({"gnr_misc_sa.u_IW_fpga_clk_rst_sync_v2_sys"})
        ,.GAL_NUM_CLOCKS              (GAL_NUM_CLOCKS)
        ,.USYNC_GAL_OFFSET            (USYNC_GAL_OFFSET)
        ,.GAL_EDGE_DET_CNTR_W         (GAL_EDGE_DET_CNTR_W)
        ,.GAL_CNTR_W                  (GAL_CNTR_W)
        ,.GAL_FREQ_DIV                (GAL_FREQ_DIV)
        ,.GAL_LOGIC_TAP               (GAL_LOGIC_TAP)
        ,.CLK_LOGIC_DIV_VALUE         (CLK_LOGIC_DIV_VALUE)    // using uclk/3 as a derived clock where the GAL is aligned too
        ,.ENABLE_CLK_SYNC             (ENABLE_CLK_SYNC)
        ,.NUM_PLL_CLOCKS              (NUM_PLL_CLOCKS)
        ,.NUM_DERIVATIVE_CLOCKS       (NUM_DERIVATIVE_CLOCKS)
        ,.DERIVATIVE_CLOCK_RATIOS     ('{54,66,198})

        ,.CLK_SYN_MASTER              (CLK_SYN_MASTER)
        ,.PARAM_WIDTH                 (PARAM_WIDTH)
        ,.START_OFFSET_POSITION       (START_OFFSET_POSITION)
        ,.END_OFFSET_POSITION         (END_OFFSET_POSITION) // 2.5 MHz / 150 MHz, 60 clocks in one cycle
        ,.NUM_ITERATIONS              (NUM_ITERATIONS)
        ,.MIN_PULSE_WIDTH             (MIN_PULSE_WIDTH)
        ,.MAX_PULSE_WIDTH             (MAX_PULSE_WIDTH)
        ,.VCO_SHIFT_PER_PULSE         (VCO_SHIFT_PER_PULSE) // 200 MHz over 1200 MHz
        ,.CLOCK_RATIO                 (CLOCK_RATIO)
        ,.UPSTREAM_WIDTH              (UPSTREAM_WIDTH)
        ,.MC_FAST_CLK_SHIFT           (MC_FAST_CLK_SHIFT)
        ,.SERDES_ENABLE_ALIGN_CNT     (SERDES_ENABLE_ALIGN_CNT)
        ,.SERDES_CTRL_STATUS_W        (SERDES_CTRL_STATUS_W)
        ,.FPGA_FAMILY                 (FPGA_FAMILY )
        ,.AV_MM_ADDR_W                (AV_MM_ADDR_W)
        ,.AV_MM_DATA_W                (AV_MM_DATA_W)
      ) u_IW_fpga_clk_rst_sync_v2_sys (

         .clk_mon                     (clk_mon)
        ,.rst_mon_n                   (rst_mon_n )
        ,.o_downstream_tx             (o_downstream_tx)
        ,.i_downstream_rx             (i_downstream_rx)
        ,.i_upstream_rx               (i_upstream_rx)
        ,.o_upstream_tx               (o_upstream_tx)
        ,.o_cal_success               (o_cal_success)

        ,.i_clk_fast                  (i_clk_fast)
        ,.clk_logic_vec              (clk_logic_vec)

        ,.pll_clk_tap                 (pll_clk_tap)

        ,.pll_reset                   (pll_reset)
        ,.locked_logic_pll            (locked_logic_pll)
        ,.pll_phase_en                (pll_phase_en)
        ,.pll_updn                    (pll_updn)
        ,.pll_cntsel                  (pll_cntsel)
        ,.pll_phase_done              (pll_phase_done)
        ,.pll_out_shift               (pll_out_shift)
        ,.clk_logic_sync_lock         (clk_logic_sync_lock)
        ,.all_clk_sync_lock           (all_clk_sync_lock)
        ,.pin_rst_n                   (pin_rst_n)
        ,.clk_logic                   (clk_logic)
        ,.clk_logic_derivatives       ()  
                                        
        ,.rst_logic_derivatives_n     () 
        ,.avs_s0_address              (avs_s0_address)
        ,.avs_s0_readdata             (avs_s0_readdata)
        ,.avs_s0_read                 (avs_s0_read )
        ,.avs_s0_readdatavalid        (avs_s0_readdatavalid)
        ,.avs_s0_write                (avs_s0_write)
        ,.avs_s0_writedata            (avs_s0_writedata )
        ,.avs_s0_byteenable           (avs_s0_byteenable)
        ,.avs_s0_waitrequest          (avs_s0_waitrequest)

        );
    end
  endgenerate
endmodule
