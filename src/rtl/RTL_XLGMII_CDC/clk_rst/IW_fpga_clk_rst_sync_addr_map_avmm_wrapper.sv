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


`timescale 1ns/1ps

module IW_fpga_clk_rst_sync_addr_map_avmm_wrapper #(
  parameter AV_MM_ADDR_W  = 8,                     // Address width
  parameter AV_MM_DATA_W  = 32,                    // Data width
  parameter READ_MISS_VAL = 32'hDEADBABE           // Read miss value
) (
  input  wire [AV_MM_ADDR_W-1:0]     avs_s0_address,          // avs_s0.address
  output reg  [AV_MM_DATA_W-1:0]     avs_s0_readdata,         //       .readdata
  input  wire                        avs_s0_read,             //       .read
  output reg                         avs_s0_readdatavalid,    //       .readdatavalid
  input  wire                        avs_s0_write,            //       .write
  input  wire [AV_MM_DATA_W-1:0]     avs_s0_writedata,        //       .writedata
  input  wire [(AV_MM_DATA_W/8)-1:0] avs_s0_byteenable,       //       .byteenable
  output wire                        avs_s0_waitrequest,      //       .waitrequest
  input  wire                        csi_clk,                 // csi.clk
  input  wire                        rsi_reset_n,             // rsi.reset
  //Register inputs from HW
  input  wire [7:0]                  coe_clk_param_0_pll_num_clks,
  input  wire [7:0]                  coe_clk_param_0_num_derivative_clocks,
  input  wire [7:0]                  coe_clk_param_0_clk_sync_start_timeout,
  input  wire                        coe_clk_param_0_enable_clk_sync,
  input  wire                        coe_clk_param_0_clk_cnt_out_bffr,
  input  wire                        coe_clk_param_0_clk_cnt_in_bffr,
  input  wire                        coe_clk_param_0_clk_syn_master,
  input  wire                        coe_clk_param_0_use_random_reset_n_dps,
  input  wire [31:0]                 coe_clk_param_1_clk_cnt_in_mux_ratio,         
  input  wire [31:0]                 coe_clk_param_1_clk_cnt_in_clk_ratio,         
  input  wire [31:0]                 coe_clk_param_2_clk_cnt_out_mux_ratio,         
  input  wire [31:0]                 coe_clk_param_2_clk_cnt_out_clk_ratio,         
  input  wire [31:0]                 coe_clk_param_3_num_reset_hold_cycles,        
  input  wire [31:0]                 coe_clk_param_4_pll_reset_step_max,           
  input  wire [31:0]                 coe_clk_param_5_pll_stable_cnt0,              
  input  wire [31:0]                 coe_clk_param_5_pll_stable_cnt1,              
  input  wire [31:0]                 coe_clk_param_6_dps_num_shifts_per_cycle,     
  input  wire [31:0]                 coe_clk_param_7_dps_min_clk_sync_fail_cycles, 
  input  wire [31:0]                 coe_clk_param_8_dps_min_clk_sync_pass_cycles, 
  input  wire [31:0]                 coe_clk_param_9_num_serdes,
  input  wire [31:0]                 coe_clk_param_10_serdes_enable_align_cnt,
  input  wire                        coe_clk_sync_stat_clk_sync_start_timeout,
  input  wire                        coe_clk_sync_stat_serdes_enable_align,
  input  wire                        coe_clk_sync_stat_serdes_clk_sync_done,
  input  wire                        coe_clk_sync_stat_clk_logic_sync_lock,
  input  wire                        coe_clk_sync_stat_rst_logic_n,
  input  wire                        coe_clk_sync_stat_rst_logic_mon_n,
  input  wire                        coe_clk_sync_stat_dps_locked,
  input  wire                        coe_clk_sync_stat_pll_dps_rst_clk_sync_n,
  input  wire                        coe_clk_sync_stat_clk_sync_stable,
  input  wire                        coe_clk_sync_stat_clk_sync_mismatch,
  input  wire                        coe_clk_sync_stat_locked_logic_pll,
  input  wire                        coe_clk_sync_stat_pll_reset,
  input  wire [15:0]                 coe_clk_dps_sync_fsm_pstate,
  input  wire [15:0]                 coe_clk_dps_cntrl_fsm_pstate,
  input  wire [31:0]                 coe_clk_dps_pass_win_len,
  input  wire [31:0]                 coe_clk_sync_loss_cnt,
  input  wire [31:0]                 coe_clk_dps_find_fail0_shift_cnt,
  input  wire [31:0]                 coe_clk_dps_find_pass0_shift_cnt,
  input  wire [31:0]                 coe_clk_dps_find_fail1_shift_cnt,
  input  wire [31:0]                 coe_clk_dps_lock_dps_shift_cnt,
  input  wire [31:0]                 coe_clk_dps_consec_sync_pass_cnt,
  input  wire [31:0]                 coe_clk_dps_consec_fail_cnt,
  input  wire [31:0]                 coe_clk_dps_lock_target_cnt,
  input  wire [31:0]                 coe_clk_dps_lock_slip_cnt,

  output logic [3:0]                  dps_mode,
  output logic                        dps_step_forward_p,
  output logic [31:0]                 dps_step_count,
  output logic [7:0]                  dps_la_dbg_win_sel,
  input  logic                        dps_pause

);

import IW_fpga_clk_rst_sync_addr_map_pkg::*;
import rtlgen_pkg_IW_fpga_clk_rst_sync_addr_map::*;

// Internal Parameters 
//AV_MM_ADDR_W is offset address width and HIGH_ADDR_W is base address width for
//this module.
localparam HIGH_ADDR_W   = 48-AV_MM_ADDR_W;


// Internal Signals  
load_clk_dps_control_reg_cr_t              load_clk_dps_control_reg_cr;
load_clk_sync_stat_reg_cr_t                load_clk_sync_stat_reg_cr;
new_clk_dps_consec_fail_cnt_reg_cr_t       new_clk_dps_consec_fail_cnt_reg_cr;
new_clk_dps_consec_sync_pass_cnt_reg_cr_t  new_clk_dps_consec_sync_pass_cnt_reg_cr;
new_clk_dps_control_reg_cr_t               new_clk_dps_control_reg_cr;
new_clk_dps_find_fail0_shift_cnt_reg_cr_t  new_clk_dps_find_fail0_shift_cnt_reg_cr;
new_clk_dps_find_pass0_shift_cnt_reg_cr_t  new_clk_dps_find_pass0_shift_cnt_reg_cr;
new_clk_dps_find_fail1_shift_cnt_reg_cr_t  new_clk_dps_find_fail1_shift_cnt_reg_cr;
new_clk_dps_fsm_reg_cr_t                   new_clk_dps_fsm_reg_cr;
new_clk_dps_lock_dps_shift_cnt_reg_cr_t    new_clk_dps_lock_dps_shift_cnt_reg_cr;
new_clk_dps_lock_slip_cnt_reg_cr_t         new_clk_dps_lock_slip_cnt_reg_cr;
new_clk_dps_lock_target_cnt_reg_cr_t       new_clk_dps_lock_target_cnt_reg_cr;
new_clk_dps_pass_win_len_reg_cr_t          new_clk_dps_pass_win_len_reg_cr;
new_clk_param_0_reg_cr_t                   new_clk_param_0_reg_cr;
new_clk_param_10_reg_cr_t                  new_clk_param_10_reg_cr;
new_clk_param_1_reg_cr_t                   new_clk_param_1_reg_cr;
new_clk_param_2_reg_cr_t                   new_clk_param_2_reg_cr;
new_clk_param_3_reg_cr_t                   new_clk_param_3_reg_cr;
new_clk_param_4_reg_cr_t                   new_clk_param_4_reg_cr;
new_clk_param_5_reg_cr_t                   new_clk_param_5_reg_cr;
new_clk_param_6_reg_cr_t                   new_clk_param_6_reg_cr;
new_clk_param_7_reg_cr_t                   new_clk_param_7_reg_cr;
new_clk_param_8_reg_cr_t                   new_clk_param_8_reg_cr;
new_clk_param_9_reg_cr_t                   new_clk_param_9_reg_cr;
new_clk_sync_loss_cnt_reg_cr_t             new_clk_sync_loss_cnt_reg_cr;
new_clk_sync_stat_reg_cr_t                 new_clk_sync_stat_reg_cr;

clk_dps_control_reg_cr_t                   clk_dps_control_reg_cr;
clk_dps_step_count_reg_cr_t                clk_dps_step_count_reg_cr;

IW_fpga_clk_rst_sync_addr_map_cr_req_t     reg_mod_req;
IW_fpga_clk_rst_sync_addr_map_cr_ack_t     reg_mod_ack;

//Assigning HW inputs to register fields
always@(*)
begin
  //This will take care of reserved fields having unknown values
  new_clk_dps_consec_fail_cnt_reg_cr          = 'h0;
  new_clk_dps_consec_sync_pass_cnt_reg_cr     = 'h0;
  new_clk_dps_find_fail0_shift_cnt_reg_cr     = 'h0;
  new_clk_dps_find_pass0_shift_cnt_reg_cr     = 'h0;
  new_clk_dps_find_fail1_shift_cnt_reg_cr     = 'h0;
  new_clk_dps_fsm_reg_cr                      = 'h0;
  new_clk_dps_lock_dps_shift_cnt_reg_cr       = 'h0;
  new_clk_dps_lock_slip_cnt_reg_cr            = 'h0;
  new_clk_dps_lock_target_cnt_reg_cr          = 'h0;
  new_clk_dps_pass_win_len_reg_cr             = 'h0;
  new_clk_param_0_reg_cr                      = 'h0;
  new_clk_param_10_reg_cr                     = 'h0;
  new_clk_param_1_reg_cr                      = 'h0;
  new_clk_param_2_reg_cr                      = 'h0;
  new_clk_param_3_reg_cr                      = 'h0;
  new_clk_param_4_reg_cr                      = 'h0;
  new_clk_param_5_reg_cr                      = 'h0;
  new_clk_param_6_reg_cr                      = 'h0;
  new_clk_param_7_reg_cr                      = 'h0;
  new_clk_param_8_reg_cr                      = 'h0;
  new_clk_param_9_reg_cr                      = 'h0;
  new_clk_sync_loss_cnt_reg_cr                = 'h0;
  new_clk_sync_stat_reg_cr                    = 'h0;

  new_clk_param_0_reg_cr.PLL_NUM_CLKS                              = coe_clk_param_0_pll_num_clks;
  new_clk_param_0_reg_cr.NUM_DERIVATIVE_CLOCKS                     = coe_clk_param_0_num_derivative_clocks;
  new_clk_param_0_reg_cr.CLK_SYNC_START_TIMEOUT                    = coe_clk_param_0_clk_sync_start_timeout;
  new_clk_param_0_reg_cr.ENABLE_CLK_SYNC                           = coe_clk_param_0_enable_clk_sync;
  new_clk_param_0_reg_cr.CLK_CNT_OUT_BFFR                          = coe_clk_param_0_clk_cnt_out_bffr;
  new_clk_param_0_reg_cr.CLK_CNT_IN_BFFR                           = coe_clk_param_0_clk_cnt_in_bffr;
  new_clk_param_0_reg_cr.CLK_SYN_MASTER                            = coe_clk_param_0_clk_syn_master;
  new_clk_param_0_reg_cr.USE_RANDOM_RESET_N_DPS                    = coe_clk_param_0_use_random_reset_n_dps;
  new_clk_param_1_reg_cr.CLK_CNT_IN_MUX_RATIO                      = coe_clk_param_1_clk_cnt_in_mux_ratio;
  new_clk_param_1_reg_cr.CLK_CNT_IN_CLK_RATIO                      = coe_clk_param_1_clk_cnt_in_clk_ratio;
  new_clk_param_2_reg_cr.CLK_CNT_OUT_MUX_RATIO                     = coe_clk_param_2_clk_cnt_out_mux_ratio;
  new_clk_param_2_reg_cr.CLK_CNT_OUT_CLK_RATIO                     = coe_clk_param_2_clk_cnt_out_clk_ratio;
  new_clk_param_3_reg_cr.NUM_RESET_HOLD_CYCLES                     = coe_clk_param_3_num_reset_hold_cycles;
  new_clk_param_4_reg_cr.PLL_RESET_STEP_MAX                        = coe_clk_param_4_pll_reset_step_max;
  new_clk_param_5_reg_cr.PLL_STABLE_CNT0                           = coe_clk_param_5_pll_stable_cnt0;
  new_clk_param_5_reg_cr.PLL_STABLE_CNT1                           = coe_clk_param_5_pll_stable_cnt1;
  new_clk_param_6_reg_cr.DPS_NUM_SHIFTS_PER_CYCLE                  = coe_clk_param_6_dps_num_shifts_per_cycle;
  new_clk_param_7_reg_cr.DPS_MIN_CLK_SYNC_FAIL_CYCLES              = coe_clk_param_7_dps_min_clk_sync_fail_cycles;
  new_clk_param_8_reg_cr.DPS_MIN_CLK_SYNC_PASS_CYCLES              = coe_clk_param_8_dps_min_clk_sync_pass_cycles;
  new_clk_param_9_reg_cr.NUM_SERDES                                = coe_clk_param_9_num_serdes;
  new_clk_param_10_reg_cr.SERDES_ENABLE_ALIGN_CNT                  = coe_clk_param_10_serdes_enable_align_cnt;
  new_clk_sync_stat_reg_cr.clk_sync_start_timeout                  = coe_clk_sync_stat_clk_sync_start_timeout;
  new_clk_sync_stat_reg_cr.serdes_enable_align                     = coe_clk_sync_stat_serdes_enable_align;
  new_clk_sync_stat_reg_cr.serdes_clk_sync_done                    = coe_clk_sync_stat_serdes_clk_sync_done;
  new_clk_sync_stat_reg_cr.clk_logic_sync_lock                     = coe_clk_sync_stat_clk_logic_sync_lock;
  new_clk_sync_stat_reg_cr.rst_logic_n                             = coe_clk_sync_stat_rst_logic_n;
  new_clk_sync_stat_reg_cr.rst_logic_mon_n                         = coe_clk_sync_stat_rst_logic_mon_n;
  new_clk_sync_stat_reg_cr.dps_locked                              = coe_clk_sync_stat_dps_locked;
  new_clk_sync_stat_reg_cr.pll_dps_rst_clk_sync_n                  = coe_clk_sync_stat_pll_dps_rst_clk_sync_n;
  new_clk_sync_stat_reg_cr.clk_sync_stable                         = coe_clk_sync_stat_clk_sync_stable;
  new_clk_sync_stat_reg_cr.clk_sync_mismatch                       = coe_clk_sync_stat_clk_sync_mismatch;
  new_clk_sync_stat_reg_cr.loss_clk_sync_mismatch                  = coe_clk_sync_stat_clk_sync_mismatch;
  load_clk_sync_stat_reg_cr.loss_clk_sync_mismatch                 = coe_clk_sync_stat_clk_sync_mismatch; 
  new_clk_sync_stat_reg_cr.locked_logic_pll                        = coe_clk_sync_stat_locked_logic_pll;
  new_clk_sync_stat_reg_cr.loss_locked_logic_pll                   = ~coe_clk_sync_stat_locked_logic_pll;
  load_clk_sync_stat_reg_cr.loss_locked_logic_pll                  = ~coe_clk_sync_stat_locked_logic_pll; 
  new_clk_sync_stat_reg_cr.pll_reset                               = coe_clk_sync_stat_pll_reset;
  new_clk_dps_fsm_reg_cr.dps_sync_fsm_pstate                       = coe_clk_dps_sync_fsm_pstate;
  new_clk_dps_fsm_reg_cr.dps_cntrl_fsm_pstate                      = coe_clk_dps_cntrl_fsm_pstate;
  new_clk_dps_pass_win_len_reg_cr.dps_pass_win_len                 = coe_clk_dps_pass_win_len;
  new_clk_sync_loss_cnt_reg_cr.clk_sync_loss_cnt                   = coe_clk_sync_loss_cnt;
  new_clk_dps_find_fail0_shift_cnt_reg_cr.dps_find_fail0_shift_cnt = coe_clk_dps_find_fail0_shift_cnt;
  new_clk_dps_find_pass0_shift_cnt_reg_cr.dps_find_pass0_shift_cnt = coe_clk_dps_find_pass0_shift_cnt;
  new_clk_dps_find_fail1_shift_cnt_reg_cr.dps_find_fail1_shift_cnt = coe_clk_dps_find_fail1_shift_cnt;
  new_clk_dps_lock_dps_shift_cnt_reg_cr.dps_lock_dps_shift_cnt     = coe_clk_dps_lock_dps_shift_cnt;
  new_clk_dps_consec_sync_pass_cnt_reg_cr.dps_consec_sync_pass_cnt = coe_clk_dps_consec_sync_pass_cnt;
  new_clk_dps_consec_fail_cnt_reg_cr.dps_consec_fail_cnt           = coe_clk_dps_consec_fail_cnt;
  new_clk_dps_lock_target_cnt_reg_cr.dps_lock_target_cnt           = coe_clk_dps_lock_target_cnt;
  new_clk_dps_lock_slip_cnt_reg_cr.dps_lock_slip_cnt               = coe_clk_dps_lock_slip_cnt;

  load_clk_dps_control_reg_cr.dps_step_forward                     = clk_dps_control_reg_cr.dps_step_forward;
  new_clk_dps_control_reg_cr.dps_step_forward                      = 1'b0;
  new_clk_dps_control_reg_cr.dps_pause                             = dps_pause;
  dps_mode                                                         = clk_dps_control_reg_cr.dps_mode;
  dps_step_forward_p                                               = clk_dps_control_reg_cr.dps_step_forward;
  dps_step_count                                                   = clk_dps_step_count_reg_cr.dps_step_count;
  dps_la_dbg_win_sel                                               = clk_dps_control_reg_cr.dps_la_dbg_win_sel;
end
 
// clock and reset sync register module instantiation
   IW_fpga_clk_rst_sync_addr_map IW_fpga_clk_rst_sync_addr_map_inst (
   // Clocks
   .gated_clk                                     (csi_clk                                 ),
   .rtl_clk                                       (csi_clk                                 ),

   // Resets                                  
   .pwr_rst_n                                     (rsi_reset_n                             ),
   .rst_n                                         (rsi_reset_n                             ),
   // Register Inputs                         
   .load_clk_dps_control_reg_cr                   (load_clk_dps_control_reg_cr             ),
   .load_clk_sync_stat_reg_cr                     (load_clk_sync_stat_reg_cr               ),

   .new_clk_dps_consec_fail_cnt_reg_cr            (new_clk_dps_consec_fail_cnt_reg_cr      ),
   .new_clk_dps_consec_sync_pass_cnt_reg_cr       (new_clk_dps_consec_sync_pass_cnt_reg_cr ),
   .new_clk_dps_control_reg_cr                    (new_clk_dps_control_reg_cr              ),
   .new_clk_dps_find_fail0_shift_cnt_reg_cr       (new_clk_dps_find_fail0_shift_cnt_reg_cr ),
   .new_clk_dps_find_pass0_shift_cnt_reg_cr       (new_clk_dps_find_pass0_shift_cnt_reg_cr ),
   .new_clk_dps_find_fail1_shift_cnt_reg_cr       (new_clk_dps_find_fail1_shift_cnt_reg_cr ),
   .new_clk_dps_fsm_reg_cr                        (new_clk_dps_fsm_reg_cr                  ),
   .new_clk_dps_lock_dps_shift_cnt_reg_cr         (new_clk_dps_lock_dps_shift_cnt_reg_cr   ),
   .new_clk_dps_lock_slip_cnt_reg_cr              (new_clk_dps_lock_slip_cnt_reg_cr        ),
   .new_clk_dps_lock_target_cnt_reg_cr            (new_clk_dps_lock_target_cnt_reg_cr      ),
   .new_clk_dps_pass_win_len_reg_cr               (new_clk_dps_pass_win_len_reg_cr         ),
   .new_clk_param_0_reg_cr                        (new_clk_param_0_reg_cr                  ),
   .new_clk_param_10_reg_cr                       (new_clk_param_10_reg_cr                 ),
   .new_clk_param_1_reg_cr                        (new_clk_param_1_reg_cr                  ),
   .new_clk_param_2_reg_cr                        (new_clk_param_2_reg_cr                  ),
   .new_clk_param_3_reg_cr                        (new_clk_param_3_reg_cr                  ),
   .new_clk_param_4_reg_cr                        (new_clk_param_4_reg_cr                  ),
   .new_clk_param_5_reg_cr                        (new_clk_param_5_reg_cr                  ),
   .new_clk_param_6_reg_cr                        (new_clk_param_6_reg_cr                  ),
   .new_clk_param_7_reg_cr                        (new_clk_param_7_reg_cr                  ),
   .new_clk_param_8_reg_cr                        (new_clk_param_8_reg_cr                  ),
   .new_clk_param_9_reg_cr                        (new_clk_param_9_reg_cr                  ),
   .new_clk_sync_loss_cnt_reg_cr                  (new_clk_sync_loss_cnt_reg_cr            ),
   .new_clk_sync_stat_reg_cr                      (new_clk_sync_stat_reg_cr                ),  
   // Register Outputs                        
   .clk_dps_consec_fail_cnt_reg_cr                ( ),
   .clk_dps_consec_sync_pass_cnt_reg_cr           ( ),
   .clk_dps_control_reg_cr                        (clk_dps_control_reg_cr),
   .clk_dps_find_fail0_shift_cnt_reg_cr           ( ),
   .clk_dps_find_pass0_shift_cnt_reg_cr           ( ),
   .clk_dps_find_fail1_shift_cnt_reg_cr           ( ),
   .clk_dps_fsm_reg_cr                            ( ),
   .clk_dps_lock_dps_shift_cnt_reg_cr             ( ),
   .clk_dps_lock_slip_cnt_reg_cr                  ( ),
   .clk_dps_lock_target_cnt_reg_cr                ( ),
   .clk_dps_pass_win_len_reg_cr                   ( ),
   .clk_dps_step_count_reg_cr                     (clk_dps_step_count_reg_cr),
   .clk_param_0_reg_cr                            ( ),
   .clk_param_10_reg_cr                           ( ),
   .clk_param_1_reg_cr                            ( ),
   .clk_param_2_reg_cr                            ( ),
   .clk_param_3_reg_cr                            ( ),
   .clk_param_4_reg_cr                            ( ),
   .clk_param_5_reg_cr                            ( ),
   .clk_param_6_reg_cr                            ( ),
   .clk_param_7_reg_cr                            ( ),
   .clk_param_8_reg_cr                            ( ),
   .clk_param_9_reg_cr                            ( ),
   .clk_sync_loss_cnt_reg_cr                      ( ),
   .clk_sync_stat_reg_cr                          ( ),
   // Config Access                           
   .req                                           (reg_mod_req),
   .ack                                           (reg_mod_ack)
   );

//------------------------------------------------------//
//    REQ SIGNALS        :     ACK SIGNALS              //
//------------------------------------------------------//
// reg_mod_req.valid     : reg_mod_ack.read_valid       //
// reg_mod_req.opcode    : reg_mod_ack.read_miss        //
// reg_mod_req.addr      : reg_mod_ack.write_valid      //
// reg_mod_req.be        : reg_mod_ack.write_miss       //
// reg_mod_req.data      : reg_mod_ack.sai_successfull  //
// reg_mod_req.sai       : reg_mod_ack.data             //
// reg_mod_req.fid       :                              //
// reg_mod_req.bar       :                              //
//------------------------------------------------------//

//------------------------------------------------------//
// Register module config request signals logic         //
//------------------------------------------------------//
//Request is valid for any read or write transaction occurs when waitrequest
//is inactive/low 
assign reg_mod_req.valid  = (avs_s0_read||avs_s0_write) && (!avs_s0_waitrequest);
//Register CFG opcode selection
assign reg_mod_req.opcode = avs_s0_write ? CFGWR : CFGRD;
//Register CFG address excpets 48bit. Appending zeros to 
//AV MM slave address
assign reg_mod_req.addr   = {'h0,avs_s0_address};
assign reg_mod_req.be     = avs_s0_byteenable;
assign reg_mod_req.data   = avs_s0_writedata;
assign reg_mod_req.sai    = 7'h00;
assign reg_mod_req.fid    = 7'h00;
assign reg_mod_req.bar    = 3'h0;

//AV MM Slave waitrequest
assign avs_s0_waitrequest = 1'b0;
//AV MM Slave read data valid is registered CFG ack's read_valid or read_miss
always @(posedge csi_clk  or negedge  rsi_reset_n)
begin
  if(~rsi_reset_n)
    avs_s0_readdatavalid <= 1'b0;
  else
    avs_s0_readdatavalid <= reg_mod_ack.read_valid || reg_mod_ack.read_miss;
end
//AV MM Slave read data 
always @(posedge csi_clk  or negedge  rsi_reset_n)
begin
  if(~rsi_reset_n)
    avs_s0_readdata <= 'h0;
  else if(reg_mod_ack.read_miss)
    avs_s0_readdata <= READ_MISS_VAL;
  else if(reg_mod_ack.read_valid)
    avs_s0_readdata <= reg_mod_ack.data;
  else
    avs_s0_readdata <= 'h0;
end

endmodule
