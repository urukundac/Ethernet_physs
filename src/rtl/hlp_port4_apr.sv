//------------------------------------------------------------------------------
//
//  INTEL CONFIDENTIAL
//
//  Copyright 2006 - 2017 Intel Corporation All Rights Reserved.
//
//  The source code contained or described herein and all documents related
//  to the source code ("Material") are owned by Intel Corporation or its
//  suppliers or licensors. Title to the Material remains with Intel
//  Corporation or its suppliers and licensors. The Material contains trade
//  secrets and proprietary and confidential information of Intel or its
//  suppliers and licensors. The Material is protected by worldwide copyright
//  and trade secret laws and treaty provisions. No part of the Material may
//  be used, copied, reproduced, modified, published, uploaded, posted,
//  transmitted, distributed, or disclosed in any way without Intel's prior
//  express written permission.
//
//  No license under any patent, copyright, trade secret or other intellectual
//  property right is granted to or conferred upon you by disclosure or
//  delivery of the Materials, either expressly, by implication, inducement,
//  estoppel or otherwise. Any license under such intellectual property rights
//  must be express and approved by Intel in writing.
//
//------------------------------------------------------------------------------

// COPIED FROM USER-PROVIDED TEMPLATE

//------------------------------------------------------------------------------
//
//  INTEL CONFIDENTIAL
//
//  Copyright 2006 - 2017 Intel Corporation All Rights Reserved.
//
//  The source code contained or described herein and all documents related
//  to the source code ("Material") are owned by Intel Corporation or its
//  suppliers or licensors. Title to the Material remains with Intel
//  Corporation or its suppliers and licensors. The Material contains trade
//  secrets and proprietary and confidential information of Intel or its
//  suppliers and licensors. The Material is protected by worldwide copyright
//  and trade secret laws and treaty provisions. No part of the Material may
//  be used, copied, reproduced, modified, published, uploaded, posted,
//  transmitted, distributed, or disclosed in any way without Intel's prior
//  express written permission.
//
//  No license under any patent, copyright, trade secret or other intellectual
//  property right is granted to or conferred upon you by disclosure or
//  delivery of the Materials, either expressly, by implication, inducement,
//  estoppel or otherwise. Any license under such intellectual property rights
//  must be express and approved by Intel in writing.
//
//------------------------------------------------------------------------------

`include "hlp_mac4_mem.def"
`include "hlp_sia_mem.def"

module hlp_port4_apr #(
 parameter MACS = 1
)
(
 output logic fet_ack_b,
 input logic fet_en_b,
 output logic [8:0] avisa_unit_id_p1,
 output logic [8:0] avisa_unit_id_p2,
 output logic [8:0] avisa_unit_id_p3,
 input logic rst_n,
 input logic powergood_rst_n,
 input logic mem_rst_n,
 input logic swclk_mem_rst_n,
 input logic switch_rst_n,
 input logic fary_trigger_post_rf,
 input logic fary_post_pass_rf,
 output logic aary_post_complete_rf,
 output logic aary_post_pass_rf,
 input logic fary_trigger_post_sram,
 input logic fary_post_pass_sram,
 output logic aary_post_complete_sram,
 output logic aary_post_pass_sram,

 // TAP Overrides
 input  logic fdfx_jta_force_latch_mem_fuses,
/*AUTOINPUT*/
input clk_rscclk,
output mbist_diag_done,
input mbist_mode,
input hlp_post_mux_ctrl,
input hlp_post_clkungate,
// Beginning of automatic inputs (from unused autoinst inputs)
input logic             DFTMASK,                // To u_port4_apr_sram_mems of hlp_port4_apr_sram_mems.v, ...
input logic             DFTSHIFTEN,             // To u_port4_apr_sram_mems of hlp_port4_apr_sram_mems.v, ...
input logic             DFT_AFD_RESET_B,        // To u_port4_apr_sram_mems of hlp_port4_apr_sram_mems.v, ...
input logic             DFT_ARRAY_FREEZE,       // To u_port4_apr_sram_mems of hlp_port4_apr_sram_mems.v, ...
input logic             clk,                    // To u_port4_apr_func_logic of hlp_port4_apr_func_logic.v
input logic [6:0]       fary_ffuse_hd2prf_trim, // To u_port4_apr_rf_mems of hlp_port4_apr_rf_mems.v
input logic [16:0]      fary_ffuse_hdusplr_trim,// To u_port4_apr_sram_mems of hlp_port4_apr_sram_mems.v
input logic [16:0]      fary_ffuse_hduspsr_trim,// To u_port4_apr_sram_mems of hlp_port4_apr_sram_mems.v
input logic [1:0]       fary_ffuse_rf_sleep,    // To u_port4_apr_rf_mems of hlp_port4_apr_rf_mems.v
input logic [9:0]       fary_ffuse_rfhs2r2w_trim,// To u_port4_apr_rf_mems of hlp_port4_apr_rf_mems.v
input logic [1:0]       fary_ffuse_sram_sleep,  // To u_port4_apr_sram_mems of hlp_port4_apr_sram_mems.v
input logic             fary_output_reset,      // To u_port4_apr_sram_mems of hlp_port4_apr_sram_mems.v, ...
input logic             fscan_byprst_b,         // To u_port4_apr_func_logic of hlp_port4_apr_func_logic.v
input logic [hlp_dfx_pkg::PORT4_NUM_CLKGENCTRL-1:0] fscan_clkgenctrl,// To u_port4_apr_func_logic of hlp_port4_apr_func_logic.v
input logic [hlp_dfx_pkg::PORT4_NUM_CLKGENCTRLEN-1:0] fscan_clkgenctrlen,// To u_port4_apr_func_logic of hlp_port4_apr_func_logic.v
input logic             fscan_clkungate,        // To u_port4_apr_sram_mems of hlp_port4_apr_sram_mems.v, ...
input logic             fscan_clkungate_syn,    // To u_port4_apr_func_logic of hlp_port4_apr_func_logic.v
input logic             fscan_latchclosed_b,    // To u_port4_apr_func_logic of hlp_port4_apr_func_logic.v
input logic             fscan_latchopen,        // To u_port4_apr_func_logic of hlp_port4_apr_func_logic.v
input logic             fscan_mode,             // To u_port4_apr_func_logic of hlp_port4_apr_func_logic.v
input logic             fscan_mode_atspeed,     // To u_port4_apr_func_logic of hlp_port4_apr_func_logic.v
input logic             fscan_ram_bypsel_rf,    // To u_port4_apr_rf_mems of hlp_port4_apr_rf_mems.v
input logic             fscan_ram_bypsel_sram,  // To u_port4_apr_sram_mems of hlp_port4_apr_sram_mems.v
input logic             fscan_ram_init_en,      // To u_port4_apr_sram_mems of hlp_port4_apr_sram_mems.v, ...
input logic             fscan_ram_init_val,     // To u_port4_apr_sram_mems of hlp_port4_apr_sram_mems.v, ...
input logic             fscan_ram_rdis_b,       // To u_port4_apr_sram_mems of hlp_port4_apr_sram_mems.v, ...
input logic             fscan_ram_wdis_b,       // To u_port4_apr_sram_mems of hlp_port4_apr_sram_mems.v, ...
input logic             fscan_ret_ctrl,         // To u_port4_apr_func_logic of hlp_port4_apr_func_logic.v
input logic             fscan_rstbypen,         // To u_port4_apr_func_logic of hlp_port4_apr_func_logic.v
input logic [hlp_dfx_pkg::PORT4_NUM_SDI-1:0] fscan_sdi,// To u_port4_apr_func_logic of hlp_port4_apr_func_logic.v
input logic             fscan_shiften,          // To u_port4_apr_func_logic of hlp_port4_apr_func_logic.v
input logic             fsta_dfxact_afd,        // To u_port4_apr_sram_mems of hlp_port4_apr_sram_mems.v, ...
input logic             fvisa_all_dis,          // To u_port4_apr_func_logic of hlp_port4_apr_func_logic.v
input logic [hlp_dfx_pkg::NUM_VISA_LANES-1:0] fvisa_clk_msec,// To u_port4_apr_func_logic of hlp_port4_apr_func_logic.v
input logic [hlp_dfx_pkg::NUM_VISA_LANES-1:0] fvisa_clk_port4,// To u_port4_apr_func_logic of hlp_port4_apr_func_logic.v
input logic             fvisa_customer_dis,     // To u_port4_apr_func_logic of hlp_port4_apr_func_logic.v
input logic [hlp_dfx_pkg::VISA_DBG_LANE_WIDTH-1:0] fvisa_dbg_lane_msec,// To u_port4_apr_func_logic of hlp_port4_apr_func_logic.v
input logic [hlp_dfx_pkg::VISA_DBG_LANE_WIDTH-1:0] fvisa_dbg_lane_port4,// To u_port4_apr_func_logic of hlp_port4_apr_func_logic.v
input logic             fvisa_frame,            // To u_port4_apr_func_logic of hlp_port4_apr_func_logic.v
input logic             fvisa_rddata_msec,      // To u_port4_apr_func_logic of hlp_port4_apr_func_logic.v
input logic             fvisa_rddata_port4,     // To u_port4_apr_func_logic of hlp_port4_apr_func_logic.v
input logic             fvisa_resetb,           // To u_port4_apr_func_logic of hlp_port4_apr_func_logic.v
input logic             fvisa_serdata,          // To u_port4_apr_func_logic of hlp_port4_apr_func_logic.v
input logic             fvisa_serstb,           // To u_port4_apr_func_logic of hlp_port4_apr_func_logic.v
input logic [8:0]       fvisa_unit_id,          // To u_port4_apr_func_logic of hlp_port4_apr_func_logic.v
input logic             i_force_clk_en,         // To u_port4_apr_func_logic of hlp_port4_apr_func_logic.v
input logic [$bits(hlp_pkg::quad_id_t)-1:0] i_id,// To u_port4_apr_func_logic of hlp_port4_apr_func_logic.v
input logic [hlp_sia_pkg::PORTS_PER_SIA-1:0] i_jitter_cred_tgl,// To u_port4_apr_func_logic of hlp_port4_apr_func_logic.v
input logic [1:0]       i_mac_id,               // To u_port4_apr_func_logic of hlp_port4_apr_func_logic.v
input logic [1:0]       i_mac_limit,            // To u_port4_apr_func_logic of hlp_port4_apr_func_logic.v
input logic             i_msec_disable,         // To u_port4_apr_func_logic of hlp_port4_apr_func_logic.v
input logic [MACS-1:0]  i_msec_mac_rx_e,        // To u_port4_apr_func_logic of hlp_port4_apr_func_logic.v
input logic [MACS-1:0] [$bits(hlp_pkg::msec_mac_tx_t)-1:0] i_msec_mac_tx,// To u_port4_apr_func_logic of hlp_port4_apr_func_logic.v
input logic [MACS-1:0]  i_msec_mac_tx_v,        // To u_port4_apr_func_logic of hlp_port4_apr_func_logic.v
input logic [MACS-1:0] [$bits(hlp_pkg::msec_switch_rx_t)-1:0] i_msec_switch_rx,// To u_port4_apr_func_logic of hlp_port4_apr_func_logic.v
input logic [MACS-1:0]  i_msec_switch_rx_v,     // To u_port4_apr_func_logic of hlp_port4_apr_func_logic.v
input logic [MACS-1:0]  i_msec_switch_tx_e,     // To u_port4_apr_func_logic of hlp_port4_apr_func_logic.v
input logic [4:0]       i_port1_id,             // To u_port4_apr_func_logic of hlp_port4_apr_func_logic.v
input logic             i_port4_disable,        // To u_port4_apr_func_logic of hlp_port4_apr_func_logic.v
input logic [$bits(hlp_mac_pkg::cfg_ports_common_t)-1:0] i_ports_cfg,// To u_port4_apr_func_logic of hlp_port4_apr_func_logic.v
input logic [$bits(hlp_pkg::imn_rpl_bkwd_t)-1:0] i_rpl_bkwd,       // To u_port4_apr_func_logic of hlp_port4_apr_func_logic.v
input logic [$bits(hlp_pkg::imn_rpl_frwd_t)-1:0] i_rpl_frwd,       // To u_port4_apr_func_logic of hlp_port4_apr_func_logic.v
input logic             i_rx_grant_fifo_push,   // To u_port4_apr_func_logic of hlp_port4_apr_func_logic.v
input logic [hlp_sia_pkg::RX_GRANT_FIFO_CONTENTS_WIDTH-1:0] i_rx_grant_fifo_push_data,// To u_port4_apr_func_logic of hlp_port4_apr_func_logic.v
input logic [0:hlp_sia_pkg::PORTS_PER_SIA-1] [hlp_pkg::N_TC-1:0] [$bits(hlp_pkg::smp_vec_t)-1:0] i_rx_pause_gen_pfc_smp_xoff,// To u_port4_apr_func_logic of hlp_port4_apr_func_logic.v
input logic [0:hlp_sia_pkg::PORTS_PER_SIA-1] [$bits(hlp_pkg::smp_vec_t)-1:0] i_rx_pause_gen_smp_xoff,// To u_port4_apr_func_logic of hlp_port4_apr_func_logic.v
input logic [$bits(hlp_sia_pkg::sia_tx_tap_int_t)-1:0] i_sia_tx_tap_int,// To u_port4_apr_func_logic of hlp_port4_apr_func_logic.v
input logic             i_switch_ready,         // To u_port4_apr_func_logic of hlp_port4_apr_func_logic.v
input logic [$bits(hlp_pkg::time_scale_pulse_t)-1:0] i_time_scale_pulse,// To u_port4_apr_func_logic of hlp_port4_apr_func_logic.v
input logic [1:0]       i_tsu_sync_val,         // To u_port4_apr_func_logic of hlp_port4_apr_func_logic.v
input logic [MACS-1:0]  i_tx_stop,              // To u_port4_apr_func_logic of hlp_port4_apr_func_logic.v
input logic             i_tx_switch_ready,      // To u_port4_apr_func_logic of hlp_port4_apr_func_logic.v
input logic [$bits(hlp_sia_pkg::txmetaram_win_t)-1:0] i_txmetaram_win,// To u_port4_apr_func_logic of hlp_port4_apr_func_logic.v
input logic [$bits(hlp_sia_pkg::txram_win_t)-1:0] i_txram_win,     // To u_port4_apr_func_logic of hlp_port4_apr_func_logic.v
input logic [hlp_sia_pkg::PORTS_PER_SIA-1:0] i_txram_wr_tgl,// To u_port4_apr_func_logic of hlp_port4_apr_func_logic.v
input logic             isol_en_b,              // To u_port4_apr_sram_mems of hlp_port4_apr_sram_mems.v, ...
input logic [MACS-1:0] [$bits(hlp_pkg::mii_rx_t)-1:0] mii_rx,      // To u_port4_apr_func_logic of hlp_port4_apr_func_logic.v
input logic [MACS-1:0] [$bits(hlp_pkg::smac_tsu_in_t)-1:0] mii_tsu_in,// To u_port4_apr_func_logic of hlp_port4_apr_func_logic.v
input logic [4:0]       pwr_mgmt_in_rf,         // To u_port4_apr_rf_mems of hlp_port4_apr_rf_mems.v
input logic [5:0]       pwr_mgmt_in_sram,       // To u_port4_apr_sram_mems of hlp_port4_apr_sram_mems.v
input logic             switch_clk,             // To u_port4_apr_rf_mems of hlp_port4_apr_rf_mems.v, ...
input logic             tsu_en,                 // To u_port4_apr_func_logic of hlp_port4_apr_func_logic.v
// End of automatics
/*AUTOOUTPUT*/
// Beginning of automatic outputs (from unused autoinst outputs)
output logic [hlp_dfx_pkg::PORT4_NUM_SDO-1:0] ascan_sdo,// From u_port4_apr_func_logic of hlp_port4_apr_func_logic.v
output logic            avisa_all_dis,          // From u_port4_apr_func_logic of hlp_port4_apr_func_logic.v
output logic [hlp_dfx_pkg::NUM_VISA_LANES-1:0] avisa_clk,// From u_port4_apr_func_logic of hlp_port4_apr_func_logic.v
output logic            avisa_customer_dis,     // From u_port4_apr_func_logic of hlp_port4_apr_func_logic.v
output logic [hlp_dfx_pkg::VISA_DBG_LANE_WIDTH-1:0] avisa_dbg_lane,// From u_port4_apr_func_logic of hlp_port4_apr_func_logic.v
output logic            avisa_frame,            // From u_port4_apr_func_logic of hlp_port4_apr_func_logic.v
output logic            avisa_rddata,           // From u_port4_apr_func_logic of hlp_port4_apr_func_logic.v
output logic            avisa_serdata,          // From u_port4_apr_func_logic of hlp_port4_apr_func_logic.v
output logic            avisa_serstb,           // From u_port4_apr_func_logic of hlp_port4_apr_func_logic.v
output logic            isol_ack_b,             // From u_port4_apr_func_logic of hlp_port4_apr_func_logic.v
output logic [MACS-1:0] [$bits(hlp_pkg::mii_tx_t)-1:0] mii_tx,     // From u_port4_apr_func_logic of hlp_port4_apr_func_logic.v
output logic [hlp_sia_pkg::PORTS_PER_SIA-1:0] [$bits(hlp_c_sia_tx_pkg::c_sia_tx_port_jitter_t)-1:0] o_cfg_tx_jitter,// From u_port4_apr_func_logic of hlp_port4_apr_func_logic.v
output logic [$bits(hlp_sia_pkg::txram_port_bound_t)-1:0] o_cfg_txram_port_bound,// From u_port4_apr_func_logic of hlp_port4_apr_func_logic.v
output logic [hlp_sia_pkg::IARB_TOKENS_CNT_INHIBIT_CNT_WIDTH-1:0] o_iarb_token_rate,// From u_port4_apr_func_logic of hlp_port4_apr_func_logic.v
output logic [MACS-1:0] [$bits(hlp_pkg::msec_mac_rx_t)-1:0] o_msec_mac_rx,// From u_port4_apr_func_logic of hlp_port4_apr_func_logic.v
output logic [MACS-1:0] o_msec_mac_rx_v,        // From u_port4_apr_func_logic of hlp_port4_apr_func_logic.v
output logic [MACS-1:0] o_msec_mac_tx_e,        // From u_port4_apr_func_logic of hlp_port4_apr_func_logic.v
output logic [MACS-1:0] o_msec_switch_rx_e,     // From u_port4_apr_func_logic of hlp_port4_apr_func_logic.v
output logic [MACS-1:0] [$bits(hlp_pkg::msec_switch_tx_t)-1:0] o_msec_switch_tx,// From u_port4_apr_func_logic of hlp_port4_apr_func_logic.v
output logic [MACS-1:0] o_msec_switch_tx_v,     // From u_port4_apr_func_logic of hlp_port4_apr_func_logic.v
output logic [$bits(hlp_pkg::rx_sia_ripple_t)-1:0] o_obuf_data,    // From u_port4_apr_func_logic of hlp_port4_apr_func_logic.v
output logic            o_p0_mode,              // From u_port4_apr_func_logic of hlp_port4_apr_func_logic.v
output logic [hlp_sia_pkg::PORTS_PER_SIA-1:0] o_port_en,// From u_port4_apr_func_logic of hlp_port4_apr_func_logic.v
output logic [$bits(hlp_mac_pkg::info_ports_common_t)-1:0] o_ports_info,// From u_port4_apr_func_logic of hlp_port4_apr_func_logic.v
output logic [$bits(hlp_pkg::imn_rpl_bkwd_t)-1:0] o_rpl_bkwd,      // From u_port4_apr_func_logic of hlp_port4_apr_func_logic.v
output logic [$bits(hlp_pkg::imn_rpl_frwd_t)-1:0] o_rpl_frwd,      // From u_port4_apr_func_logic of hlp_port4_apr_func_logic.v
output logic            o_rx_grant_fifo_afull,  // From u_port4_apr_func_logic of hlp_port4_apr_func_logic.v
output logic [0:hlp_sia_pkg::PORTS_PER_SIA-1] [hlp_sia_pkg::RX_QUEUES_PER_SIA_PORT-1:0] o_rx_q_xoff,// From u_port4_apr_func_logic of hlp_port4_apr_func_logic.v
output logic [0:hlp_sia_pkg::PORTS_PER_SIA-1] [$bits(hlp_sia_pkg::c_rx_tap_port_cfg_t)-1:0] o_rx_tap_port_cfg,// From u_port4_apr_func_logic of hlp_port4_apr_func_logic.v
output logic [MACS-1:0] o_rx_throttle,          // From u_port4_apr_func_logic of hlp_port4_apr_func_logic.v
output logic [hlp_sia_pkg::PORTS_PER_SIA-1:0] [hlp_sia_pkg::RX_IARB_TOKEN_REQ_CNT_WIDTH-1:0] o_seg_valid,// From u_port4_apr_func_logic of hlp_port4_apr_func_logic.v
output logic [0:hlp_sia_pkg::PORTS_PER_SIA-1] [$bits(hlp_pkg::pc_vec_t)-1:0] o_switch_rx_pc_xoff,// From u_port4_apr_func_logic of hlp_port4_apr_func_logic.v
output logic [$bits(hlp_pkg::time_scale_pulse_t)-1:0] o_time_scale_pulse,// From u_port4_apr_func_logic of hlp_port4_apr_func_logic.v
output logic [hlp_sia_pkg::PORTS_PER_SIA-1:0] [$bits(hlp_pkg::tx_credit_t)-1:0] o_txram_credit
`include "hlp_port4_apr.VISA_IT.hlp_port4_apr.port_defs.sv" // Auto Included by VISA IT - *** Do not modify this line ***

//`include "hlp_port4_apr.VISA_IT.hlp_port4_apr.port_defs.sv" // Auto Included by VISA IT - *** Do not modify this line ***
// From u_port4_apr_func_logic of hlp_port4_apr_func_logic.v
// End of automatics
, input wire fary_ijtag_tck, input wire fary_ijtag_rst_b, 
                    input wire fary_ijtag_capture, input wire fary_ijtag_shift, 
                    input wire fary_ijtag_update, input wire fary_ijtag_select, 
                    input wire fary_ijtag_si, output wire aary_ijtag_so, 
                    output wire bisr_so_pd_vinf, input wire bisr_si_pd_vinf, 
                    input wire bisr_shift_en_pd_vinf, 
                    input wire bisr_clk_pd_vinf, input wire bisr_reset_pd_vinf, 
                    input wire fary_trigger_post, output wire aary_post_pass, 
                    output wire aary_post_busy, output wire aary_post_complete, 
                    input wire fary_post_force_fail, 
                    input logic [5:0] fary_post_algo_select, 
                    input wire core_rst_b);



logic local_rst_n;
logic local_powergood_rst_n;
logic local_mem_rst_n;
logic local_swclk_mem_rst_n;
logic local_switch_rst_n;
logic sram_isol_en;


  wire [4:0] toBist, bistEn;
  wire [1:0] BIST_COL_ADD_ts2;
  wire [4:0] BIST_ROW_ADD;
  wire [3:0] BIST_ROW_ADD_ts1;
  wire [4:0] BIST_ROW_ADD_ts2, BIST_ROW_ADD_ts3;
  wire [7:0] BIST_ROW_ADD_ts4;
  wire [1:0] BIST_BANK_ADD_ts1;
  wire [7:0] BIST_WRITE_DATA, BIST_WRITE_DATA_ts1, BIST_WRITE_DATA_ts2, 
             BIST_WRITE_DATA_ts3;
  wire [31:0] BIST_WRITE_DATA_ts4;
  wire [7:0] BIST_EXPECT_DATA, BIST_EXPECT_DATA_ts1, BIST_EXPECT_DATA_ts2, 
             BIST_EXPECT_DATA_ts3;
  wire [31:0] BIST_EXPECT_DATA_ts4;
  wire [0:0] BIST_TEST_PORT;
  logic clk_ts1, switch_clk_ts1;
  wire hlp_port4_apr_rtl_tessent_sib_mbist_inst_so, 
       hlp_port4_apr_rtl_tessent_sib_sti_inst_so, 
       hlp_port4_apr_rtl_tessent_sib_sri_ctrl_inst_so, 
       hlp_port4_apr_rtl_tessent_tdr_sri_ctrl_inst_so, 
       hlp_port4_apr_rtl_tessent_sib_sri_inst_to_select, 
       hlp_port4_apr_rtl_tessent_sib_sti_inst_so_ts1, 
       hlp_port4_apr_rtl_tessent_tdr_RF_c1_algo_select_tdr_inst_so, 
       hlp_port4_apr_rtl_tessent_sib_sti_inst_to_select, 
       hlp_port4_apr_rtl_tessent_sib_algo_select_sib_inst_so, 
       hlp_port4_apr_rtl_tessent_sib_sri_ctrl_inst_to_select, 
       hlp_port4_apr_rtl_tessent_sib_algo_select_sib_inst_to_select, 
       hlp_port4_apr_rtl_tessent_tdr_SRAM_c5_algo_select_tdr_inst_so, 
       hlp_port4_apr_rtl_tessent_tdr_RF_c4_algo_select_tdr_inst_so, 
       hlp_port4_apr_rtl_tessent_tdr_RF_c3_algo_select_tdr_inst_so, 
       hlp_port4_apr_rtl_tessent_tdr_RF_c2_algo_select_tdr_inst_so, ijtag_to_se, 
       ijtag_to_ce, ijtag_to_tck, ijtag_to_ue, ijtag_to_reset, ijtag_to_sel, 
       ltest_to_en, ltest_to_mem_bypass_en, ltest_to_scan_en, 
       ltest_to_mcp_bounding_en, BIRA_EN, PRESERVE_FUSE_REGISTER, 
       CHECK_REPAIR_NEEDED, BIST_HOLD, BIST_SETUP2, BIST_SETUP1_clk, 
       BIST_SETUP1_switch_clk, BIST_SETUP0, BIST_SELECT_TEST_DATA, 
       to_controllers_tck, to_interfaces_tck, to_controllers_tck_retime, 
       mcp_bounding_to_en, scan_to_en, memory_bypass_to_en, ltest_to_en_ts1, 
       BIST_ALGO_SEL, BIST_ALGO_SEL_ts1, BIST_ALGO_SEL_ts2, BIST_ALGO_SEL_ts3, 
       BIST_ALGO_SEL_ts4, BIST_ALGO_SEL_ts5, BIST_ALGO_SEL_ts6, 
       BIST_SELECT_COMMON_ALGO, BIST_SELECT_COMMON_OPSET, BIST_OPSET_SEL, 
       BIST_DATA_INV_ROW_ADD_BIT_SELECT_EN, BIST_DATA_INV_ROW_ADD_BIT_SEL, 
       BIST_DATA_INV_COL_ADD_BIT_SEL, GO_ID_REG_SEL, GO_ID_REG_SEL_ts1, 
       GO_ID_REG_SEL_ts2, GO_ID_REG_SEL_ts3, GO_ID_REG_SEL_ts4, 
       BIST_DATA_INV_COL_ADD_BIT_SELECT_EN, BIST_ALGO_MODE0, BIST_ALGO_MODE1, 
       ENABLE_MEM_RESET, REDUCED_ADDRESS_COUNT, BIST_CLEAR_BIRA, 
       BIST_COLLAR_DIAG_EN, BIST_COLLAR_BIRA_EN, PriorityColumn, 
       BIST_SHIFT_BIRA_COLLAR, BIST_CLEAR_BIRA_ts1, BIST_COLLAR_DIAG_EN_ts1, 
       BIST_COLLAR_BIRA_EN_ts1, BIST_SHIFT_BIRA_COLLAR_ts1, BIST_CLEAR_BIRA_ts2, 
       BIST_COLLAR_DIAG_EN_ts2, BIST_COLLAR_BIRA_EN_ts2, PriorityColumn_ts1, 
       BIST_SHIFT_BIRA_COLLAR_ts2, BIST_CLEAR_BIRA_ts3, BIST_COLLAR_DIAG_EN_ts3, 
       BIST_COLLAR_BIRA_EN_ts3, PriorityColumn_ts2, BIST_SHIFT_BIRA_COLLAR_ts3, 
       BIST_CLEAR_BIRA_ts4, BIST_COLLAR_DIAG_EN_ts4, BIST_COLLAR_BIRA_EN_ts4, 
       PriorityColumn_ts3, BIST_SHIFT_BIRA_COLLAR_ts4, MEM_ARRAY_DUMP_MODE, 
       BIST_DIAG_EN, BIST_ASYNC_RESET_clk, BIST_ASYNC_RESET_switch_clk, 
       MEM0_BIST_COLLAR_SI, MEM1_BIST_COLLAR_SI, MEM0_BIST_COLLAR_SI_ts1, 
       MEM0_BIST_COLLAR_SI_ts2, MEM1_BIST_COLLAR_SI_ts1, 
       MEM0_BIST_COLLAR_SI_ts3, MEM1_BIST_COLLAR_SI_ts2, MEM2_BIST_COLLAR_SI, 
       MEM3_BIST_COLLAR_SI, MEM4_BIST_COLLAR_SI, MEM5_BIST_COLLAR_SI, 
       MEM6_BIST_COLLAR_SI, MEM7_BIST_COLLAR_SI, MEM8_BIST_COLLAR_SI, 
       MEM9_BIST_COLLAR_SI, MEM0_BIST_COLLAR_SI_ts4, MEM1_BIST_COLLAR_SI_ts3, 
       MEM2_BIST_COLLAR_SI_ts1, MEM3_BIST_COLLAR_SI_ts1, 
       MEM4_BIST_COLLAR_SI_ts1, MEM5_BIST_COLLAR_SI_ts1, 
       MEM6_BIST_COLLAR_SI_ts1, MEM7_BIST_COLLAR_SI_ts1, 
       MEM8_BIST_COLLAR_SI_ts1, MEM9_BIST_COLLAR_SI_ts1, MEM10_BIST_COLLAR_SI, 
       MEM11_BIST_COLLAR_SI, MEM12_BIST_COLLAR_SI, MEM13_BIST_COLLAR_SI, 
       MEM14_BIST_COLLAR_SI, MEM15_BIST_COLLAR_SI, MEM16_BIST_COLLAR_SI, 
       MEM17_BIST_COLLAR_SI, MBISTPG_SO, MBISTPG_SO_ts1, MBISTPG_SO_ts2, 
       MBISTPG_SO_ts3, MBISTPG_SO_ts4, BIST_SO, BIST_SO_ts1, BIST_SO_ts2, 
       BIST_SO_ts3, BIST_SO_ts4, BIST_SO_ts5, BIST_SO_ts6, BIST_SO_ts7, 
       BIST_SO_ts8, BIST_SO_ts9, BIST_SO_ts10, BIST_SO_ts11, BIST_SO_ts12, 
       BIST_SO_ts13, BIST_SO_ts14, BIST_SO_ts15, BIST_SO_ts16, BIST_SO_ts17, 
       BIST_SO_ts18, BIST_SO_ts19, BIST_SO_ts20, BIST_SO_ts21, BIST_SO_ts22, 
       BIST_SO_ts23, BIST_SO_ts24, BIST_SO_ts25, BIST_SO_ts26, BIST_SO_ts27, 
       BIST_SO_ts28, BIST_SO_ts29, BIST_SO_ts30, BIST_SO_ts31, BIST_SO_ts32, 
       MBISTPG_DONE, MBISTPG_DONE_ts1, MBISTPG_DONE_ts2, MBISTPG_DONE_ts3, 
       MBISTPG_DONE_ts4, MBISTPG_GO, MBISTPG_GO_ts1, MBISTPG_GO_ts2, 
       MBISTPG_GO_ts3, MBISTPG_GO_ts4, BIST_GO, BIST_GO_ts1, BIST_GO_ts2, 
       BIST_GO_ts3, BIST_GO_ts4, BIST_GO_ts5, BIST_GO_ts6, BIST_GO_ts7, 
       BIST_GO_ts8, BIST_GO_ts9, BIST_GO_ts10, BIST_GO_ts11, BIST_GO_ts12, 
       BIST_GO_ts13, BIST_GO_ts14, BIST_GO_ts15, BIST_GO_ts16, BIST_GO_ts17, 
       BIST_GO_ts18, BIST_GO_ts19, BIST_GO_ts20, BIST_GO_ts21, BIST_GO_ts22, 
       BIST_GO_ts23, BIST_GO_ts24, BIST_GO_ts25, BIST_GO_ts26, BIST_GO_ts27, 
       BIST_GO_ts28, BIST_GO_ts29, BIST_GO_ts30, BIST_GO_ts31, BIST_GO_ts32, 
       FL_CNT_MODE0, FL_CNT_MODE1, BIST_READENABLE, BIST_WRITEENABLE, 
       BIST_READENABLE_ts1, BIST_WRITEENABLE_ts1, BIST_READENABLE_ts2, 
       BIST_WRITEENABLE_ts2, BIST_READENABLE_ts3, BIST_WRITEENABLE_ts3, 
       BIST_WRITEENABLE_ts4, BIST_SELECT, BIST_CMP, BIST_CMP_ts1, BIST_CMP_ts2, 
       BIST_CMP_ts3, BIST_CMP_ts4, INCLUDE_MEM_RESULTS_REG, BIST_COL_ADD, 
       BIST_COL_ADD_ts1, BIST_BANK_ADD, BIST_BANK_ADD_ts2, BIST_COLLAR_EN0, 
       BIST_COLLAR_EN1, BIST_COLLAR_EN0_ts1, BIST_COLLAR_EN0_ts2, 
       BIST_COLLAR_EN1_ts1, BIST_COLLAR_EN0_ts3, BIST_COLLAR_EN1_ts2, 
       BIST_COLLAR_EN2, BIST_COLLAR_EN3, BIST_COLLAR_EN4, BIST_COLLAR_EN5, 
       BIST_COLLAR_EN6, BIST_COLLAR_EN7, BIST_COLLAR_EN8, BIST_COLLAR_EN9, 
       BIST_COLLAR_EN0_ts4, BIST_COLLAR_EN1_ts3, BIST_COLLAR_EN2_ts1, 
       BIST_COLLAR_EN3_ts1, BIST_COLLAR_EN4_ts1, BIST_COLLAR_EN5_ts1, 
       BIST_COLLAR_EN6_ts1, BIST_COLLAR_EN7_ts1, BIST_COLLAR_EN8_ts1, 
       BIST_COLLAR_EN9_ts1, BIST_COLLAR_EN10, BIST_COLLAR_EN11, 
       BIST_COLLAR_EN12, BIST_COLLAR_EN13, BIST_COLLAR_EN14, BIST_COLLAR_EN15, 
       BIST_COLLAR_EN16, BIST_COLLAR_EN17, BIST_RUN_TO_COLLAR0, 
       BIST_RUN_TO_COLLAR1, BIST_RUN_TO_COLLAR0_ts1, BIST_RUN_TO_COLLAR0_ts2, 
       BIST_RUN_TO_COLLAR1_ts1, BIST_RUN_TO_COLLAR0_ts3, 
       BIST_RUN_TO_COLLAR1_ts2, BIST_RUN_TO_COLLAR2, BIST_RUN_TO_COLLAR3, 
       BIST_RUN_TO_COLLAR4, BIST_RUN_TO_COLLAR5, BIST_RUN_TO_COLLAR6, 
       BIST_RUN_TO_COLLAR7, BIST_RUN_TO_COLLAR8, BIST_RUN_TO_COLLAR9, 
       BIST_RUN_TO_COLLAR0_ts4, BIST_RUN_TO_COLLAR1_ts3, 
       BIST_RUN_TO_COLLAR2_ts1, BIST_RUN_TO_COLLAR3_ts1, 
       BIST_RUN_TO_COLLAR4_ts1, BIST_RUN_TO_COLLAR5_ts1, 
       BIST_RUN_TO_COLLAR6_ts1, BIST_RUN_TO_COLLAR7_ts1, 
       BIST_RUN_TO_COLLAR8_ts1, BIST_RUN_TO_COLLAR9_ts1, BIST_RUN_TO_COLLAR10, 
       BIST_RUN_TO_COLLAR11, BIST_RUN_TO_COLLAR12, BIST_RUN_TO_COLLAR13, 
       BIST_RUN_TO_COLLAR14, BIST_RUN_TO_COLLAR15, BIST_RUN_TO_COLLAR16, 
       BIST_RUN_TO_COLLAR17, BIST_SHADOW_READENABLE, BIST_SHADOW_READADDRESS, 
       BIST_SHADOW_READENABLE_ts1, BIST_SHADOW_READADDRESS_ts1, 
       BIST_SHADOW_READENABLE_ts2, BIST_SHADOW_READADDRESS_ts2, 
       BIST_SHADOW_READENABLE_ts3, BIST_SHADOW_READADDRESS_ts3, 
       BIST_CONWRITE_ROWADDRESS, BIST_CONWRITE_ENABLE, 
       BIST_CONWRITE_ROWADDRESS_ts1, BIST_CONWRITE_ENABLE_ts1, 
       BIST_CONWRITE_ROWADDRESS_ts2, BIST_CONWRITE_ENABLE_ts2, 
       BIST_CONWRITE_ROWADDRESS_ts3, BIST_CONWRITE_ENABLE_ts3, 
       BIST_CONREAD_ROWADDRESS, BIST_CONREAD_COLUMNADDRESS, BIST_CONREAD_ENABLE, 
       BIST_CONREAD_ROWADDRESS_ts1, BIST_CONREAD_COLUMNADDRESS_ts1, 
       BIST_CONREAD_ENABLE_ts1, BIST_CONREAD_ROWADDRESS_ts2, 
       BIST_CONREAD_COLUMNADDRESS_ts2, BIST_CONREAD_ENABLE_ts2, 
       BIST_CONREAD_ROWADDRESS_ts3, BIST_CONREAD_COLUMNADDRESS_ts3, 
       BIST_CONREAD_ENABLE_ts3, BIST_TESTDATA_SELECT_TO_COLLAR, 
       BIST_TESTDATA_SELECT_TO_COLLAR_ts1, BIST_TESTDATA_SELECT_TO_COLLAR_ts2, 
       BIST_TESTDATA_SELECT_TO_COLLAR_ts3, BIST_TESTDATA_SELECT_TO_COLLAR_ts4, 
       BIST_ON_TO_COLLAR, BIST_ON_TO_COLLAR_ts1, BIST_ON_TO_COLLAR_ts2, 
       BIST_ON_TO_COLLAR_ts3, BIST_ON_TO_COLLAR_ts4, BIST_SHIFT_COLLAR, 
       BIST_SHIFT_COLLAR_ts1, BIST_SHIFT_COLLAR_ts2, BIST_SHIFT_COLLAR_ts3, 
       BIST_SHIFT_COLLAR_ts4, BIST_COLLAR_SETUP, BIST_COLLAR_SETUP_ts1, 
       BIST_COLLAR_SETUP_ts2, BIST_COLLAR_SETUP_ts3, BIST_COLLAR_SETUP_ts4, 
       BIST_CLEAR_DEFAULT, BIST_CLEAR_DEFAULT_ts1, BIST_CLEAR_DEFAULT_ts2, 
       BIST_CLEAR_DEFAULT_ts3, BIST_CLEAR_DEFAULT_ts4, BIST_CLEAR, 
       BIST_CLEAR_ts1, BIST_CLEAR_ts2, BIST_CLEAR_ts3, BIST_CLEAR_ts4, 
       BIST_COLLAR_OPSET_SELECT, BIST_COLLAR_OPSET_SELECT_ts1, 
       BIST_COLLAR_OPSET_SELECT_ts2, BIST_COLLAR_OPSET_SELECT_ts3, 
       BIST_COLLAR_OPSET_SELECT_ts4, BIST_COLLAR_HOLD, FREEZE_STOP_ERROR, 
       ERROR_CNT_ZERO, BIST_COLLAR_HOLD_ts1, FREEZE_STOP_ERROR_ts1, 
       ERROR_CNT_ZERO_ts1, BIST_COLLAR_HOLD_ts2, FREEZE_STOP_ERROR_ts2, 
       ERROR_CNT_ZERO_ts2, BIST_COLLAR_HOLD_ts3, FREEZE_STOP_ERROR_ts3, 
       ERROR_CNT_ZERO_ts3, BIST_COLLAR_HOLD_ts4, FREEZE_STOP_ERROR_ts4, 
       ERROR_CNT_ZERO_ts4, MBISTPG_RESET_REG_SETUP2, 
       MBISTPG_RESET_REG_SETUP2_ts1, MBISTPG_RESET_REG_SETUP2_ts2, 
       MBISTPG_RESET_REG_SETUP2_ts3, MBISTPG_RESET_REG_SETUP2_ts4, 
       hlp_port4_apr_rtl_tessent_mbist_bap_inst_so, tck_select, MBISTPG_STABLE, 
       MBISTPG_STABLE_ts1, MBISTPG_STABLE_ts2, MBISTPG_STABLE_ts3, 
       MBISTPG_STABLE_ts4, ijtag_so, bisr_so_pd_vinf_ts1, 
       ram_row_0_col_0_bisr_inst_SO, trigger_post, trigger_array, 
       mbistpg_select_common_algo_o, select_rf, select_sram, pass, 
       sys_test_done_clk, sys_test_pass_clk, complete, busy, 
       sync_reset_clk_reset_bypass_mux_o, 
       Intel_reset_sync_polarity_clk_inverter_o1, sync_reset_clk_o, 
       sync_reset_clk_o_ts1, pass_ts1, sys_test_done_switch_clk, 
       sys_test_pass_switch_clk, complete_ts1, busy_ts1, 
       sync_reset_switch_clk_reset_bypass_mux_o, 
       Intel_reset_sync_polarity_switch_clk_inverter_o1, 
       sync_reset_switch_clk_o, sync_reset_switch_clk_o_ts1;
  wire [6:0] mbistpg_algo_sel_o, ALGO_SEL_REG, ALGO_SEL_REG_ts1, 
             ALGO_SEL_REG_ts2, ALGO_SEL_REG_ts3, ALGO_SEL_REG_ts4;
`include "hlp_port4_apr.VISA_IT.hlp_port4_apr.wires.sv" // Auto Included by VISA IT - *** Do not modify this line ***
logic local_rst_n;
logic local_powergood_rst_n;
logic local_mem_rst_n;
logic local_swclk_mem_rst_n;
logic local_switch_rst_n;
logic sram_isol_en;

assign avisa_unit_id_p1 = fvisa_unit_id + 9'd1;
assign avisa_unit_id_p2 = fvisa_unit_id + 9'd2;
assign avisa_unit_id_p3 = fvisa_unit_id + 9'd3;

logic latch_mem_fuses;
assign latch_mem_fuses = fdfx_jta_force_latch_mem_fuses | fscan_clkgenctrlen[0];

logic fscan_clkungate_out_or1;
ctech_lib_or2 post_or1
  (.a (hlp_post_clkungate),
   .b (mbist_mode),
   .o (fscan_clkungate_out_or1));

logic fscan_clkungate_out;
ctech_lib_or2 post_or2
  (.a (fscan_clkungate_out_or1),
   .b (fscan_clkungate),
   .o (fscan_clkungate_out));



ctech_lib_mux_2to1 reset_scan_mux_rst
  (.d2 (rst_n),
   .d1 (fscan_byprst_b),
   .s (fscan_rstbypen),
   .o (local_rst_n));

ctech_lib_mux_2to1 reset_scan_mux_powergood_rst
  (.d2 (powergood_rst_n),
   .d1 (fscan_byprst_b),
   .s (fscan_rstbypen),
   .o (local_powergood_rst_n));

ctech_lib_mux_2to1 reset_scan_mux_mem_rst
  (.d2 (mem_rst_n),
   .d1 (fscan_byprst_b),
   .s (fscan_rstbypen),
   .o (local_mem_rst_n));

ctech_lib_mux_2to1 reset_scan_mux_swclk_mem_rst
  (.d2 (swclk_mem_rst_n),
   .d1 (fscan_byprst_b),
   .s (fscan_rstbypen),
   .o (local_swclk_mem_rst_n));

ctech_lib_mux_2to1 reset_scan_mux_switch_rst
  (.d2 (switch_rst_n),
   .d1 (fscan_byprst_b),
   .s (fscan_rstbypen),
   .o (local_switch_rst_n));

hlp_tieoff_0 sram_isol_en_b_tieoff_0
     (.out (sram_isol_en));

logic fet_ack_b_to_sram;
logic aary_pwren_b_sram_to_rf;

/*AUTOLOGIC*/
// Beginning of automatic wires (for undeclared instantiated-module outputs)
logic [`HLP_MAC4_MAC4_STATS_FULL_RX_FROM_MEM_WIDTH-1:0] frm_mac4_mac4_stats_full_rx;// From u_port4_apr_rf_mems of hlp_port4_apr_rf_mems.v
logic [`HLP_MAC4_MAC4_STATS_FULL_TX_FROM_MEM_WIDTH-1:0] frm_mac4_mac4_stats_full_tx;// From u_port4_apr_rf_mems of hlp_port4_apr_rf_mems.v
logic [`HLP_MAC4_MAC4_STATS_SNAP_RX_FROM_MEM_WIDTH-1:0] frm_mac4_mac4_stats_snap_rx;// From u_port4_apr_ff_mems of hlp_port4_apr_ff_mems.v
logic [`HLP_MAC4_MAC4_STATS_SNAP_TX_FROM_MEM_WIDTH-1:0] frm_mac4_mac4_stats_snap_tx;// From u_port4_apr_ff_mems of hlp_port4_apr_ff_mems.v
logic [`HLP_MAC4_SMAC_TX_FIFO_FROM_MEM_WIDTH-1:0] frm_mac4_smac_tx_fifo;// From u_port4_apr_ff_mems of hlp_port4_apr_ff_mems.v
logic [`HLP_MAC4_SMAC_TX_PRE_FROM_MEM_WIDTH-1:0] frm_mac4_smac_tx_pre;// From u_port4_apr_ff_mems of hlp_port4_apr_ff_mems.v
logic [`HLP_MAC4_TSU_MEM_FROM_MEM_WIDTH-1:0] frm_mac4_tsu_mem;// From u_port4_apr_rf_mems of hlp_port4_apr_rf_mems.v
logic [`HLP_SIA_SIA_QRAM_FROM_MEM_WIDTH-1:0] frm_sia_sia_qram;// From u_port4_apr_sram_mems of hlp_port4_apr_sram_mems.v
logic [`HLP_SIA_SIA_RXRAM_FROM_MEM_WIDTH-1:0] frm_sia_sia_rxram;// From u_port4_apr_sram_mems of hlp_port4_apr_sram_mems.v
logic [`HLP_SIA_SIA_TXMETARAM_FROM_MEM_WIDTH-1:0] frm_sia_sia_txmetaram;// From u_port4_apr_rf_mems of hlp_port4_apr_rf_mems.v
logic                   gclk;                   // From u_port4_apr_func_logic of hlp_port4_apr_func_logic.v
logic [`HLP_MAC4_MAC4_STATS_FULL_RX_TO_MEM_WIDTH-1:0] tom_mac4_mac4_stats_full_rx;// From u_port4_apr_func_logic of hlp_port4_apr_func_logic.v
logic [`HLP_MAC4_MAC4_STATS_FULL_TX_TO_MEM_WIDTH-1:0] tom_mac4_mac4_stats_full_tx;// From u_port4_apr_func_logic of hlp_port4_apr_func_logic.v
logic [`HLP_MAC4_MAC4_STATS_SNAP_RX_TO_MEM_WIDTH-1:0] tom_mac4_mac4_stats_snap_rx;// From u_port4_apr_func_logic of hlp_port4_apr_func_logic.v
logic [`HLP_MAC4_MAC4_STATS_SNAP_TX_TO_MEM_WIDTH-1:0] tom_mac4_mac4_stats_snap_tx;// From u_port4_apr_func_logic of hlp_port4_apr_func_logic.v
logic [`HLP_MAC4_SMAC_TX_FIFO_TO_MEM_WIDTH-1:0] tom_mac4_smac_tx_fifo;// From u_port4_apr_func_logic of hlp_port4_apr_func_logic.v
logic [`HLP_MAC4_SMAC_TX_PRE_TO_MEM_WIDTH-1:0] tom_mac4_smac_tx_pre;// From u_port4_apr_func_logic of hlp_port4_apr_func_logic.v
logic [`HLP_MAC4_TSU_MEM_TO_MEM_WIDTH-1:0] tom_mac4_tsu_mem;// From u_port4_apr_func_logic of hlp_port4_apr_func_logic.v
logic [`HLP_SIA_SIA_QRAM_TO_MEM_WIDTH-1:0] tom_sia_sia_qram;// From u_port4_apr_func_logic of hlp_port4_apr_func_logic.v
logic [`HLP_SIA_SIA_RXRAM_TO_MEM_WIDTH-1:0] tom_sia_sia_rxram;// From u_port4_apr_func_logic of hlp_port4_apr_func_logic.v
logic [`HLP_SIA_SIA_TXMETARAM_TO_MEM_WIDTH-1:0] tom_sia_sia_txmetaram;// From u_port4_apr_func_logic of hlp_port4_apr_func_logic.v
logic [9:0] [`HLP_SIA_SIA_TXRAM_TO_MEM_WIDTH-1:0]   tom_sia_sia_txram;// From u_port4_apr_func_logic of hlp_port4_apr_func_logic.v
logic [9:0] [`HLP_SIA_SIA_TXRAM_FROM_MEM_WIDTH-1:0] frm_sia_sia_txram; // fixed by mem_gen script
// End of automatics

/*
  hlp_port4_apr_sram_mems AUTO_TEMPLATE
  hlp_port4_apr_rf_mems AUTO_TEMPLATE
 (
  .clk                          (gclk[]),
  .\(.*\)_\([0-9]+\)_from_mem   (frm_\1[\2][]),
  .\(.*\)_\([0-9]+\)_to_mem     (tom_\1[\2][]),
  .\(.*\)_from_mem              (frm_\1[]),
  .\(.*\)_to_mem                (tom_\1[]),
  .post_mux_ctrl ('0),
  .fary_trigger_post_sram ('0),
  .fary_trigger_post_rf ('0),
  .aary_post_complete_sram (),
  .aary_post_pass_sram (),
  .aary_post_complete_rf (),
  .aary_post_pass_rf (),  
  .fary_isolation_control_in  (isol_en_b),
  .fscan_clkgenctrl   (fscan_clkgenctrl[0]),
  .fscan_clkgenctrlen (latch_mem_fuses),
  .ip_reset_b (local_powergood_rst_n) );*/
logic fary_trigger_post_sia_sram, aary_post_complete_sia_sram, aary_post_pass_sia_sram;
ctech_lib_doublesync_rstb  #(.WIDTH(1))  u_trigger_post_sia_sram
  (.clk(gclk), .rstb(local_powergood_rst_n), .d(fary_trigger_post_sram), .o(fary_trigger_post_sia_sram) );

assign aary_post_complete_sram = aary_post_complete_sia_sram;
always_ff @(posedge gclk) begin
  aary_post_pass_sram <= fary_post_pass_sram & aary_post_pass_sia_sram;
end

hlp_port4_apr_sram_mems u_port4_apr_sram_mems
(// Manual connections
 .fary_trigger_post_sia_sram,
 .aary_post_complete_sia_sram,
 .aary_post_pass_sia_sram,
 .fary_pwren_b_sram   (fet_ack_b_to_sram),
// .fary_wakeup_sram    (sram_isol_en),
 .aary_pwren_b_sram   (aary_pwren_b_sram_to_rf),
 /*AUTOINST*/
 // Outputs
 .aary_post_complete_sram               (),                      // Templated
 .aary_post_pass_sram                   (),                      // Templated
 .sia_sia_qram_from_mem                 (frm_sia_sia_qram[`HLP_SIA_SIA_QRAM_FROM_MEM_WIDTH-1:0]), // Templated
 .sia_sia_rxram_from_mem                (frm_sia_sia_rxram[`HLP_SIA_SIA_RXRAM_FROM_MEM_WIDTH-1:0]), // Templated
 // Inputs
 .DFTMASK                               (DFTMASK),
 .DFTSHIFTEN                            (DFTSHIFTEN),
 .DFT_AFD_RESET_B                       (DFT_AFD_RESET_B),
 .DFT_ARRAY_FREEZE                      (DFT_ARRAY_FREEZE),
 .clk                                   (gclk),                  // Templated
 .fary_ffuse_hdusplr_trim               (fary_ffuse_hdusplr_trim[17-1:0]),
 .fary_ffuse_hduspsr_trim               (fary_ffuse_hduspsr_trim[17-1:0]),
 .fary_ffuse_sram_sleep                 (fary_ffuse_sram_sleep[1:0]),
 .fary_isolation_control_in             (isol_en_b),             // Templated
 .fary_output_reset                     (fary_output_reset),
 .fary_trigger_post_sram                ('0),                    // Templated
 .fscan_clkungate                       (fscan_clkungate_out),
 .fscan_ram_bypsel_sram                 (fscan_ram_bypsel_sram),
 .fscan_ram_init_en                     (fscan_ram_init_en),
 .fscan_ram_init_val                    (fscan_ram_init_val),
 .fscan_ram_rdis_b                      (fscan_ram_rdis_b),
 .fscan_ram_wdis_b                      (fscan_ram_wdis_b),
 .fsta_dfxact_afd                       (fsta_dfxact_afd),
 .ip_reset_b                            (local_powergood_rst_n), // Templated
 .post_mux_ctrl                         ('0),                    // Templated
 .pwr_mgmt_in_sram                      (pwr_mgmt_in_sram[6-1:0]),
 .sia_sia_qram_to_mem                   (tom_sia_sia_qram[`HLP_SIA_SIA_QRAM_TO_MEM_WIDTH-1:0]), // Templated
 .sia_sia_rxram_to_mem                  (tom_sia_sia_rxram[`HLP_SIA_SIA_RXRAM_TO_MEM_WIDTH-1:0]), 
 .BIST_SETUP2(BIST_SETUP2), .BIST_SETUP1_clk(BIST_SETUP1_clk), .BIST_SETUP0(BIST_SETUP0), 
 .to_interfaces_tck(to_interfaces_tck), .mcp_bounding_to_en(mcp_bounding_to_en), 
 .scan_to_en(scan_to_en), .memory_bypass_to_en(memory_bypass_to_en), 
 .GO_ID_REG_SEL(GO_ID_REG_SEL_ts4), .BIST_CLEAR_BIRA(BIST_CLEAR_BIRA_ts4), 
 .BIST_COLLAR_DIAG_EN(BIST_COLLAR_DIAG_EN_ts4), .BIST_COLLAR_BIRA_EN(BIST_COLLAR_BIRA_EN_ts4), 
 .PriorityColumn(PriorityColumn_ts3), .BIST_SHIFT_BIRA_COLLAR(BIST_SHIFT_BIRA_COLLAR_ts4), 
 .CHECK_REPAIR_NEEDED(CHECK_REPAIR_NEEDED), .MEM0_BIST_COLLAR_SI(MEM0_BIST_COLLAR_SI_ts4), 
 .MEM1_BIST_COLLAR_SI(MEM1_BIST_COLLAR_SI_ts3), .MEM2_BIST_COLLAR_SI(MEM2_BIST_COLLAR_SI_ts1), 
 .MEM3_BIST_COLLAR_SI(MEM3_BIST_COLLAR_SI_ts1), .MEM4_BIST_COLLAR_SI(MEM4_BIST_COLLAR_SI_ts1), 
 .MEM5_BIST_COLLAR_SI(MEM5_BIST_COLLAR_SI_ts1), .MEM6_BIST_COLLAR_SI(MEM6_BIST_COLLAR_SI_ts1), 
 .MEM7_BIST_COLLAR_SI(MEM7_BIST_COLLAR_SI_ts1), .MEM8_BIST_COLLAR_SI(MEM8_BIST_COLLAR_SI_ts1), 
 .MEM9_BIST_COLLAR_SI(MEM9_BIST_COLLAR_SI_ts1), .MEM10_BIST_COLLAR_SI(MEM10_BIST_COLLAR_SI), 
 .MEM11_BIST_COLLAR_SI(MEM11_BIST_COLLAR_SI), .MEM12_BIST_COLLAR_SI(MEM12_BIST_COLLAR_SI), 
 .MEM13_BIST_COLLAR_SI(MEM13_BIST_COLLAR_SI), .MEM14_BIST_COLLAR_SI(MEM14_BIST_COLLAR_SI), 
 .MEM15_BIST_COLLAR_SI(MEM15_BIST_COLLAR_SI), .MEM16_BIST_COLLAR_SI(MEM16_BIST_COLLAR_SI), 
 .MEM17_BIST_COLLAR_SI(MEM17_BIST_COLLAR_SI), .BIST_SO(BIST_SO_ts3), 
 .BIST_SO_ts1(BIST_SO_ts4), .BIST_SO_ts2(BIST_SO_ts16), .BIST_SO_ts3(BIST_SO_ts17), 
 .BIST_SO_ts4(BIST_SO_ts18), .BIST_SO_ts5(BIST_SO_ts19), .BIST_SO_ts6(BIST_SO_ts20), 
 .BIST_SO_ts7(BIST_SO_ts21), .BIST_SO_ts8(BIST_SO_ts22), .BIST_SO_ts9(BIST_SO_ts23), 
 .BIST_SO_ts10(BIST_SO_ts25), .BIST_SO_ts11(BIST_SO_ts26), .BIST_SO_ts12(BIST_SO_ts27), 
 .BIST_SO_ts13(BIST_SO_ts28), .BIST_SO_ts14(BIST_SO_ts29), .BIST_SO_ts15(BIST_SO_ts30), 
 .BIST_SO_ts16(BIST_SO_ts31), .BIST_SO_ts17(BIST_SO_ts32), .BIST_GO(BIST_GO_ts3), 
 .BIST_GO_ts1(BIST_GO_ts4), .BIST_GO_ts2(BIST_GO_ts16), .BIST_GO_ts3(BIST_GO_ts17), 
 .BIST_GO_ts4(BIST_GO_ts18), .BIST_GO_ts5(BIST_GO_ts19), .BIST_GO_ts6(BIST_GO_ts20), 
 .BIST_GO_ts7(BIST_GO_ts21), .BIST_GO_ts8(BIST_GO_ts22), .BIST_GO_ts9(BIST_GO_ts23), 
 .BIST_GO_ts10(BIST_GO_ts25), .BIST_GO_ts11(BIST_GO_ts26), .BIST_GO_ts12(BIST_GO_ts27), 
 .BIST_GO_ts13(BIST_GO_ts28), .BIST_GO_ts14(BIST_GO_ts29), .BIST_GO_ts15(BIST_GO_ts30), 
 .BIST_GO_ts16(BIST_GO_ts31), .BIST_GO_ts17(BIST_GO_ts32), .ltest_to_en(ltest_to_en_ts1), 
 .BIST_WRITEENABLE(BIST_WRITEENABLE_ts4), .BIST_SELECT(BIST_SELECT), 
 .BIST_CMP(BIST_CMP_ts4), .INCLUDE_MEM_RESULTS_REG(INCLUDE_MEM_RESULTS_REG), 
 .BIST_COL_ADD(BIST_COL_ADD_ts2[0]), .BIST_COL_ADD_ts1(BIST_COL_ADD_ts2[1]), 
 .BIST_ROW_ADD(BIST_ROW_ADD_ts4[0]), .BIST_ROW_ADD_ts1(BIST_ROW_ADD_ts4[1]), 
 .BIST_ROW_ADD_ts2(BIST_ROW_ADD_ts4[2]), .BIST_ROW_ADD_ts3(BIST_ROW_ADD_ts4[3]), 
 .BIST_ROW_ADD_ts4(BIST_ROW_ADD_ts4[4]), .BIST_ROW_ADD_ts5(BIST_ROW_ADD_ts4[5]), 
 .BIST_ROW_ADD_ts6(BIST_ROW_ADD_ts4[6]), .BIST_ROW_ADD_ts7(BIST_ROW_ADD_ts4[7]), 
 .BIST_BANK_ADD(BIST_BANK_ADD_ts2), .BIST_COLLAR_EN0(BIST_COLLAR_EN0_ts4), 
 .BIST_COLLAR_EN1(BIST_COLLAR_EN1_ts3), .BIST_COLLAR_EN2(BIST_COLLAR_EN2_ts1), 
 .BIST_COLLAR_EN3(BIST_COLLAR_EN3_ts1), .BIST_COLLAR_EN4(BIST_COLLAR_EN4_ts1), 
 .BIST_COLLAR_EN5(BIST_COLLAR_EN5_ts1), .BIST_COLLAR_EN6(BIST_COLLAR_EN6_ts1), 
 .BIST_COLLAR_EN7(BIST_COLLAR_EN7_ts1), .BIST_COLLAR_EN8(BIST_COLLAR_EN8_ts1), 
 .BIST_COLLAR_EN9(BIST_COLLAR_EN9_ts1), .BIST_COLLAR_EN10(BIST_COLLAR_EN10), 
 .BIST_COLLAR_EN11(BIST_COLLAR_EN11), .BIST_COLLAR_EN12(BIST_COLLAR_EN12), 
 .BIST_COLLAR_EN13(BIST_COLLAR_EN13), .BIST_COLLAR_EN14(BIST_COLLAR_EN14), 
 .BIST_COLLAR_EN15(BIST_COLLAR_EN15), .BIST_COLLAR_EN16(BIST_COLLAR_EN16), 
 .BIST_COLLAR_EN17(BIST_COLLAR_EN17), .BIST_RUN_TO_COLLAR0(BIST_RUN_TO_COLLAR0_ts4), 
 .BIST_RUN_TO_COLLAR1(BIST_RUN_TO_COLLAR1_ts3), .BIST_RUN_TO_COLLAR2(BIST_RUN_TO_COLLAR2_ts1), 
 .BIST_RUN_TO_COLLAR3(BIST_RUN_TO_COLLAR3_ts1), .BIST_RUN_TO_COLLAR4(BIST_RUN_TO_COLLAR4_ts1), 
 .BIST_RUN_TO_COLLAR5(BIST_RUN_TO_COLLAR5_ts1), .BIST_RUN_TO_COLLAR6(BIST_RUN_TO_COLLAR6_ts1), 
 .BIST_RUN_TO_COLLAR7(BIST_RUN_TO_COLLAR7_ts1), .BIST_RUN_TO_COLLAR8(BIST_RUN_TO_COLLAR8_ts1), 
 .BIST_RUN_TO_COLLAR9(BIST_RUN_TO_COLLAR9_ts1), .BIST_RUN_TO_COLLAR10(BIST_RUN_TO_COLLAR10), 
 .BIST_RUN_TO_COLLAR11(BIST_RUN_TO_COLLAR11), .BIST_RUN_TO_COLLAR12(BIST_RUN_TO_COLLAR12), 
 .BIST_RUN_TO_COLLAR13(BIST_RUN_TO_COLLAR13), .BIST_RUN_TO_COLLAR14(BIST_RUN_TO_COLLAR14), 
 .BIST_RUN_TO_COLLAR15(BIST_RUN_TO_COLLAR15), .BIST_RUN_TO_COLLAR16(BIST_RUN_TO_COLLAR16), 
 .BIST_RUN_TO_COLLAR17(BIST_RUN_TO_COLLAR17), .BIST_ASYNC_RESET_clk(BIST_ASYNC_RESET_clk), 
 .BIST_TESTDATA_SELECT_TO_COLLAR(BIST_TESTDATA_SELECT_TO_COLLAR_ts4), 
 .BIST_ON_TO_COLLAR(BIST_ON_TO_COLLAR_ts4), .BIST_WRITE_DATA(BIST_WRITE_DATA_ts4[0]), 
 .BIST_WRITE_DATA_ts1(BIST_WRITE_DATA_ts4[1]), .BIST_WRITE_DATA_ts2(BIST_WRITE_DATA_ts4[2]), 
 .BIST_WRITE_DATA_ts3(BIST_WRITE_DATA_ts4[3]), .BIST_WRITE_DATA_ts4(BIST_WRITE_DATA_ts4[4]), 
 .BIST_WRITE_DATA_ts5(BIST_WRITE_DATA_ts4[5]), .BIST_WRITE_DATA_ts6(BIST_WRITE_DATA_ts4[6]), 
 .BIST_WRITE_DATA_ts7(BIST_WRITE_DATA_ts4[7]), .BIST_WRITE_DATA_ts8(BIST_WRITE_DATA_ts4[8]), 
 .BIST_WRITE_DATA_ts9(BIST_WRITE_DATA_ts4[9]), .BIST_WRITE_DATA_ts10(BIST_WRITE_DATA_ts4[10]), 
 .BIST_WRITE_DATA_ts11(BIST_WRITE_DATA_ts4[11]), .BIST_WRITE_DATA_ts12(BIST_WRITE_DATA_ts4[12]), 
 .BIST_WRITE_DATA_ts13(BIST_WRITE_DATA_ts4[13]), .BIST_WRITE_DATA_ts14(BIST_WRITE_DATA_ts4[14]), 
 .BIST_WRITE_DATA_ts15(BIST_WRITE_DATA_ts4[15]), .BIST_WRITE_DATA_ts16(BIST_WRITE_DATA_ts4[16]), 
 .BIST_WRITE_DATA_ts17(BIST_WRITE_DATA_ts4[17]), .BIST_WRITE_DATA_ts18(BIST_WRITE_DATA_ts4[18]), 
 .BIST_WRITE_DATA_ts19(BIST_WRITE_DATA_ts4[19]), .BIST_WRITE_DATA_ts20(BIST_WRITE_DATA_ts4[20]), 
 .BIST_WRITE_DATA_ts21(BIST_WRITE_DATA_ts4[21]), .BIST_WRITE_DATA_ts22(BIST_WRITE_DATA_ts4[22]), 
 .BIST_WRITE_DATA_ts23(BIST_WRITE_DATA_ts4[23]), .BIST_WRITE_DATA_ts24(BIST_WRITE_DATA_ts4[24]), 
 .BIST_WRITE_DATA_ts25(BIST_WRITE_DATA_ts4[25]), .BIST_WRITE_DATA_ts26(BIST_WRITE_DATA_ts4[26]), 
 .BIST_WRITE_DATA_ts27(BIST_WRITE_DATA_ts4[27]), .BIST_WRITE_DATA_ts28(BIST_WRITE_DATA_ts4[28]), 
 .BIST_WRITE_DATA_ts29(BIST_WRITE_DATA_ts4[29]), .BIST_WRITE_DATA_ts30(BIST_WRITE_DATA_ts4[30]), 
 .BIST_WRITE_DATA_ts31(BIST_WRITE_DATA_ts4[31]), .BIST_EXPECT_DATA(BIST_EXPECT_DATA_ts4[0]), 
 .BIST_EXPECT_DATA_ts1(BIST_EXPECT_DATA_ts4[1]), .BIST_EXPECT_DATA_ts2(BIST_EXPECT_DATA_ts4[2]), 
 .BIST_EXPECT_DATA_ts3(BIST_EXPECT_DATA_ts4[3]), .BIST_EXPECT_DATA_ts4(BIST_EXPECT_DATA_ts4[4]), 
 .BIST_EXPECT_DATA_ts5(BIST_EXPECT_DATA_ts4[5]), .BIST_EXPECT_DATA_ts6(BIST_EXPECT_DATA_ts4[6]), 
 .BIST_EXPECT_DATA_ts7(BIST_EXPECT_DATA_ts4[7]), .BIST_EXPECT_DATA_ts8(BIST_EXPECT_DATA_ts4[8]), 
 .BIST_EXPECT_DATA_ts9(BIST_EXPECT_DATA_ts4[9]), .BIST_EXPECT_DATA_ts10(BIST_EXPECT_DATA_ts4[10]), 
 .BIST_EXPECT_DATA_ts11(BIST_EXPECT_DATA_ts4[11]), .BIST_EXPECT_DATA_ts12(BIST_EXPECT_DATA_ts4[12]), 
 .BIST_EXPECT_DATA_ts13(BIST_EXPECT_DATA_ts4[13]), .BIST_EXPECT_DATA_ts14(BIST_EXPECT_DATA_ts4[14]), 
 .BIST_EXPECT_DATA_ts15(BIST_EXPECT_DATA_ts4[15]), .BIST_EXPECT_DATA_ts16(BIST_EXPECT_DATA_ts4[16]), 
 .BIST_EXPECT_DATA_ts17(BIST_EXPECT_DATA_ts4[17]), .BIST_EXPECT_DATA_ts18(BIST_EXPECT_DATA_ts4[18]), 
 .BIST_EXPECT_DATA_ts19(BIST_EXPECT_DATA_ts4[19]), .BIST_EXPECT_DATA_ts20(BIST_EXPECT_DATA_ts4[20]), 
 .BIST_EXPECT_DATA_ts21(BIST_EXPECT_DATA_ts4[21]), .BIST_EXPECT_DATA_ts22(BIST_EXPECT_DATA_ts4[22]), 
 .BIST_EXPECT_DATA_ts23(BIST_EXPECT_DATA_ts4[23]), .BIST_EXPECT_DATA_ts24(BIST_EXPECT_DATA_ts4[24]), 
 .BIST_EXPECT_DATA_ts25(BIST_EXPECT_DATA_ts4[25]), .BIST_EXPECT_DATA_ts26(BIST_EXPECT_DATA_ts4[26]), 
 .BIST_EXPECT_DATA_ts27(BIST_EXPECT_DATA_ts4[27]), .BIST_EXPECT_DATA_ts28(BIST_EXPECT_DATA_ts4[28]), 
 .BIST_EXPECT_DATA_ts29(BIST_EXPECT_DATA_ts4[29]), .BIST_EXPECT_DATA_ts30(BIST_EXPECT_DATA_ts4[30]), 
 .BIST_EXPECT_DATA_ts31(BIST_EXPECT_DATA_ts4[31]), .BIST_SHIFT_COLLAR(BIST_SHIFT_COLLAR_ts4), 
 .BIST_COLLAR_SETUP(BIST_COLLAR_SETUP_ts4), .BIST_CLEAR_DEFAULT(BIST_CLEAR_DEFAULT_ts4), 
 .BIST_CLEAR(BIST_CLEAR_ts4), .BIST_COLLAR_OPSET_SELECT(BIST_COLLAR_OPSET_SELECT_ts4), 
 .BIST_COLLAR_HOLD(BIST_COLLAR_HOLD_ts4), .FREEZE_STOP_ERROR(FREEZE_STOP_ERROR_ts4), 
 .ERROR_CNT_ZERO(ERROR_CNT_ZERO_ts4), .MBISTPG_RESET_REG_SETUP2(MBISTPG_RESET_REG_SETUP2_ts4), 
 .bisr_shift_en_pd_vinf(bisr_shift_en_pd_vinf), .bisr_clk_pd_vinf(bisr_clk_pd_vinf), 
 .bisr_reset_pd_vinf(bisr_reset_pd_vinf), .ram_row_0_col_0_bisr_inst_SO(ram_row_0_col_0_bisr_inst_SO), 
 .ram_row_0_col_9_bisr_inst_SO(bisr_so_pd_vinf), .fscan_clkungate_ts1(fscan_clkungate)); // Templated

logic fary_trigger_post_sia_rf, aary_post_complete_sia_rf, aary_post_complete_mac4_rf;
logic fary_trigger_post_mac4_rf, aary_post_pass_sia_rf, aary_post_pass_mac4_rf;
ctech_lib_doublesync_rstb  #(.WIDTH(1))  u_trigger_post_mac4_rf
  (.clk(gclk), .rstb(local_powergood_rst_n), .d(fary_trigger_post_rf), .o(fary_trigger_post_mac4_rf) );
ctech_lib_doublesync_rstb  #(.WIDTH(1))  u_trigger_post_sia_rf
  (.clk(gclk), .rstb(local_powergood_rst_n), .d(aary_post_complete_mac4_rf), .o(fary_trigger_post_sia_rf) );

assign aary_post_complete_rf = aary_post_complete_sia_rf;
always_ff @(posedge gclk) begin
  aary_post_pass_rf <= fary_post_pass_rf & aary_post_pass_sia_rf & aary_post_pass_mac4_rf;
end

hlp_port4_apr_rf_mems u_port4_apr_rf_mems
(// Manual connections
 .fary_trigger_post_sia_rf,
 .fary_trigger_post_mac4_rf,
 .aary_post_complete_sia_rf,
 .aary_post_complete_mac4_rf,
 .aary_post_pass_sia_rf,
 .aary_post_pass_mac4_rf,
 .fary_pwren_b_rf     (aary_pwren_b_sram_to_rf),
 .aary_pwren_b_rf     (fet_ack_b),
 /*AUTOINST*/
 // Outputs
 .aary_post_complete_rf                 (),                      // Templated
 .aary_post_pass_rf                     (),                      // Templated
 .mac4_mac4_stats_full_rx_from_mem      (frm_mac4_mac4_stats_full_rx[`HLP_MAC4_MAC4_STATS_FULL_RX_FROM_MEM_WIDTH-1:0]), // Templated
 .mac4_mac4_stats_full_tx_from_mem      (frm_mac4_mac4_stats_full_tx[`HLP_MAC4_MAC4_STATS_FULL_TX_FROM_MEM_WIDTH-1:0]), // Templated
 .mac4_tsu_mem_from_mem                 (frm_mac4_tsu_mem[`HLP_MAC4_TSU_MEM_FROM_MEM_WIDTH-1:0]), // Templated
 .sia_sia_txmetaram_from_mem            (frm_sia_sia_txmetaram[`HLP_SIA_SIA_TXMETARAM_FROM_MEM_WIDTH-1:0]), // Templated
 .sia_sia_txram_0_from_mem              (frm_sia_sia_txram[0][`HLP_SIA_SIA_TXRAM_FROM_MEM_WIDTH-1:0]), // Templated
 .sia_sia_txram_1_from_mem              (frm_sia_sia_txram[1][`HLP_SIA_SIA_TXRAM_FROM_MEM_WIDTH-1:0]), // Templated
 .sia_sia_txram_2_from_mem              (frm_sia_sia_txram[2][`HLP_SIA_SIA_TXRAM_FROM_MEM_WIDTH-1:0]), // Templated
 .sia_sia_txram_3_from_mem              (frm_sia_sia_txram[3][`HLP_SIA_SIA_TXRAM_FROM_MEM_WIDTH-1:0]), // Templated
 .sia_sia_txram_4_from_mem              (frm_sia_sia_txram[4][`HLP_SIA_SIA_TXRAM_FROM_MEM_WIDTH-1:0]), // Templated
 .sia_sia_txram_5_from_mem              (frm_sia_sia_txram[5][`HLP_SIA_SIA_TXRAM_FROM_MEM_WIDTH-1:0]), // Templated
 .sia_sia_txram_6_from_mem              (frm_sia_sia_txram[6][`HLP_SIA_SIA_TXRAM_FROM_MEM_WIDTH-1:0]), // Templated
 .sia_sia_txram_7_from_mem              (frm_sia_sia_txram[7][`HLP_SIA_SIA_TXRAM_FROM_MEM_WIDTH-1:0]), // Templated
 .sia_sia_txram_8_from_mem              (frm_sia_sia_txram[8][`HLP_SIA_SIA_TXRAM_FROM_MEM_WIDTH-1:0]), // Templated
 .sia_sia_txram_9_from_mem              (frm_sia_sia_txram[9][`HLP_SIA_SIA_TXRAM_FROM_MEM_WIDTH-1:0]), // Templated
 // Inputs
 .DFTMASK                               (DFTMASK),
 .DFTSHIFTEN                            (DFTSHIFTEN),
 .DFT_AFD_RESET_B                       (DFT_AFD_RESET_B),
 .DFT_ARRAY_FREEZE                      (DFT_ARRAY_FREEZE),
 .clk                                   (gclk),                  // Templated
 .fary_ffuse_hd2prf_trim                (fary_ffuse_hd2prf_trim[7-1:0]),
 .fary_ffuse_rf_sleep                   (fary_ffuse_rf_sleep[1:0]),
 .fary_ffuse_rfhs2r2w_trim              (fary_ffuse_rfhs2r2w_trim[10-1:0]),
 .fary_isolation_control_in             (isol_en_b),             // Templated
 .fary_output_reset                     (fary_output_reset),
 .fary_trigger_post_rf                  ('0),                    // Templated
 .fscan_clkungate                       (fscan_clkungate_out),
 .fscan_ram_bypsel_rf                   (fscan_ram_bypsel_rf),
 .fscan_ram_init_en                     (fscan_ram_init_en),
 .fscan_ram_init_val                    (fscan_ram_init_val),
 .fscan_ram_rdis_b                      (fscan_ram_rdis_b),
 .fscan_ram_wdis_b                      (fscan_ram_wdis_b),
 .fsta_dfxact_afd                       (fsta_dfxact_afd),
 .ip_reset_b                            (local_powergood_rst_n), // Templated
 .mac4_mac4_stats_full_rx_to_mem        (tom_mac4_mac4_stats_full_rx[`HLP_MAC4_MAC4_STATS_FULL_RX_TO_MEM_WIDTH-1:0]), // Templated
 .mac4_mac4_stats_full_tx_to_mem        (tom_mac4_mac4_stats_full_tx[`HLP_MAC4_MAC4_STATS_FULL_TX_TO_MEM_WIDTH-1:0]), // Templated
 .mac4_tsu_mem_to_mem                   (tom_mac4_tsu_mem[`HLP_MAC4_TSU_MEM_TO_MEM_WIDTH-1:0]), // Templated
 .post_mux_ctrl                         ('0),                    // Templated
 .pwr_mgmt_in_rf                        (pwr_mgmt_in_rf[5-1:0]),
 .sia_sia_txmetaram_to_mem              (tom_sia_sia_txmetaram[`HLP_SIA_SIA_TXMETARAM_TO_MEM_WIDTH-1:0]), // Templated
 .sia_sia_txram_0_to_mem                (tom_sia_sia_txram[0][`HLP_SIA_SIA_TXRAM_TO_MEM_WIDTH-1:0]), // Templated
 .sia_sia_txram_1_to_mem                (tom_sia_sia_txram[1][`HLP_SIA_SIA_TXRAM_TO_MEM_WIDTH-1:0]), // Templated
 .sia_sia_txram_2_to_mem                (tom_sia_sia_txram[2][`HLP_SIA_SIA_TXRAM_TO_MEM_WIDTH-1:0]), // Templated
 .sia_sia_txram_3_to_mem                (tom_sia_sia_txram[3][`HLP_SIA_SIA_TXRAM_TO_MEM_WIDTH-1:0]), // Templated
 .sia_sia_txram_4_to_mem                (tom_sia_sia_txram[4][`HLP_SIA_SIA_TXRAM_TO_MEM_WIDTH-1:0]), // Templated
 .sia_sia_txram_5_to_mem                (tom_sia_sia_txram[5][`HLP_SIA_SIA_TXRAM_TO_MEM_WIDTH-1:0]), // Templated
 .sia_sia_txram_6_to_mem                (tom_sia_sia_txram[6][`HLP_SIA_SIA_TXRAM_TO_MEM_WIDTH-1:0]), // Templated
 .sia_sia_txram_7_to_mem                (tom_sia_sia_txram[7][`HLP_SIA_SIA_TXRAM_TO_MEM_WIDTH-1:0]), // Templated
 .sia_sia_txram_8_to_mem                (tom_sia_sia_txram[8][`HLP_SIA_SIA_TXRAM_TO_MEM_WIDTH-1:0]), // Templated
 .sia_sia_txram_9_to_mem                (tom_sia_sia_txram[9][`HLP_SIA_SIA_TXRAM_TO_MEM_WIDTH-1:0]), // Templated
 .switch_clk                            (switch_clk_ts1), .BIST_SETUP2(BIST_SETUP2), .BIST_SETUP1_clk(BIST_SETUP1_clk), 
 .BIST_SETUP1_switch_clk(BIST_SETUP1_switch_clk), .BIST_SETUP0(BIST_SETUP0), 
 .to_interfaces_tck(to_interfaces_tck), .mcp_bounding_to_en(mcp_bounding_to_en), 
 .scan_to_en(scan_to_en), .memory_bypass_to_en(memory_bypass_to_en), 
 .GO_ID_REG_SEL(GO_ID_REG_SEL), .GO_ID_REG_SEL_ts1(GO_ID_REG_SEL_ts1), 
 .GO_ID_REG_SEL_ts2(GO_ID_REG_SEL_ts2), .GO_ID_REG_SEL_ts3(GO_ID_REG_SEL_ts3), 
 .BIST_CLEAR_BIRA(BIST_CLEAR_BIRA), .BIST_COLLAR_DIAG_EN(BIST_COLLAR_DIAG_EN), 
 .BIST_COLLAR_BIRA_EN(BIST_COLLAR_BIRA_EN), .PriorityColumn(PriorityColumn), 
 .BIST_SHIFT_BIRA_COLLAR(BIST_SHIFT_BIRA_COLLAR), .BIST_CLEAR_BIRA_ts1(BIST_CLEAR_BIRA_ts1), 
 .BIST_COLLAR_DIAG_EN_ts1(BIST_COLLAR_DIAG_EN_ts1), .BIST_COLLAR_BIRA_EN_ts1(BIST_COLLAR_BIRA_EN_ts1), 
 .BIST_SHIFT_BIRA_COLLAR_ts1(BIST_SHIFT_BIRA_COLLAR_ts1), 
 .BIST_CLEAR_BIRA_ts2(BIST_CLEAR_BIRA_ts2), .BIST_COLLAR_DIAG_EN_ts2(BIST_COLLAR_DIAG_EN_ts2), 
 .BIST_COLLAR_BIRA_EN_ts2(BIST_COLLAR_BIRA_EN_ts2), .PriorityColumn_ts1(PriorityColumn_ts1), 
 .BIST_SHIFT_BIRA_COLLAR_ts2(BIST_SHIFT_BIRA_COLLAR_ts2), 
 .BIST_CLEAR_BIRA_ts3(BIST_CLEAR_BIRA_ts3), .BIST_COLLAR_DIAG_EN_ts3(BIST_COLLAR_DIAG_EN_ts3), 
 .BIST_COLLAR_BIRA_EN_ts3(BIST_COLLAR_BIRA_EN_ts3), .PriorityColumn_ts2(PriorityColumn_ts2), 
 .BIST_SHIFT_BIRA_COLLAR_ts3(BIST_SHIFT_BIRA_COLLAR_ts3), 
 .CHECK_REPAIR_NEEDED(CHECK_REPAIR_NEEDED), .MEM0_BIST_COLLAR_SI(MEM0_BIST_COLLAR_SI), 
 .MEM1_BIST_COLLAR_SI(MEM1_BIST_COLLAR_SI), .MEM0_BIST_COLLAR_SI_ts1(MEM0_BIST_COLLAR_SI_ts1), 
 .MEM0_BIST_COLLAR_SI_ts2(MEM0_BIST_COLLAR_SI_ts2), .MEM1_BIST_COLLAR_SI_ts1(MEM1_BIST_COLLAR_SI_ts1), 
 .MEM0_BIST_COLLAR_SI_ts3(MEM0_BIST_COLLAR_SI_ts3), .MEM1_BIST_COLLAR_SI_ts2(MEM1_BIST_COLLAR_SI_ts2), 
 .MEM2_BIST_COLLAR_SI(MEM2_BIST_COLLAR_SI), .MEM3_BIST_COLLAR_SI(MEM3_BIST_COLLAR_SI), 
 .MEM4_BIST_COLLAR_SI(MEM4_BIST_COLLAR_SI), .MEM5_BIST_COLLAR_SI(MEM5_BIST_COLLAR_SI), 
 .MEM6_BIST_COLLAR_SI(MEM6_BIST_COLLAR_SI), .MEM7_BIST_COLLAR_SI(MEM7_BIST_COLLAR_SI), 
 .MEM8_BIST_COLLAR_SI(MEM8_BIST_COLLAR_SI), .MEM9_BIST_COLLAR_SI(MEM9_BIST_COLLAR_SI), 
 .BIST_SO(BIST_SO), .BIST_SO_ts1(BIST_SO_ts1), .BIST_SO_ts2(BIST_SO_ts2), 
 .BIST_SO_ts3(BIST_SO_ts5), .BIST_SO_ts4(BIST_SO_ts6), .BIST_SO_ts5(BIST_SO_ts7), 
 .BIST_SO_ts6(BIST_SO_ts8), .BIST_SO_ts7(BIST_SO_ts9), .BIST_SO_ts8(BIST_SO_ts10), 
 .BIST_SO_ts9(BIST_SO_ts11), .BIST_SO_ts10(BIST_SO_ts12), .BIST_SO_ts11(BIST_SO_ts13), 
 .BIST_SO_ts12(BIST_SO_ts14), .BIST_SO_ts13(BIST_SO_ts15), .BIST_SO_ts14(BIST_SO_ts24), 
 .BIST_GO(BIST_GO), .BIST_GO_ts1(BIST_GO_ts1), .BIST_GO_ts2(BIST_GO_ts2), 
 .BIST_GO_ts3(BIST_GO_ts5), .BIST_GO_ts4(BIST_GO_ts6), .BIST_GO_ts5(BIST_GO_ts7), 
 .BIST_GO_ts6(BIST_GO_ts8), .BIST_GO_ts7(BIST_GO_ts9), .BIST_GO_ts8(BIST_GO_ts10), 
 .BIST_GO_ts9(BIST_GO_ts11), .BIST_GO_ts10(BIST_GO_ts12), .BIST_GO_ts11(BIST_GO_ts13), 
 .BIST_GO_ts12(BIST_GO_ts14), .BIST_GO_ts13(BIST_GO_ts15), .BIST_GO_ts14(BIST_GO_ts24), 
 .ltest_to_en(ltest_to_en_ts1), .BIST_READENABLE(BIST_READENABLE), 
 .BIST_WRITEENABLE(BIST_WRITEENABLE), .BIST_READENABLE_ts1(BIST_READENABLE_ts1), 
 .BIST_WRITEENABLE_ts1(BIST_WRITEENABLE_ts1), .BIST_READENABLE_ts2(BIST_READENABLE_ts2), 
 .BIST_WRITEENABLE_ts2(BIST_WRITEENABLE_ts2), .BIST_READENABLE_ts3(BIST_READENABLE_ts3), 
 .BIST_WRITEENABLE_ts3(BIST_WRITEENABLE_ts3), .BIST_CMP(BIST_CMP), 
 .BIST_CMP_ts1(BIST_CMP_ts1), .BIST_CMP_ts2(BIST_CMP_ts2), .BIST_CMP_ts3(BIST_CMP_ts3), 
 .INCLUDE_MEM_RESULTS_REG(INCLUDE_MEM_RESULTS_REG), .BIST_COL_ADD(BIST_COL_ADD), 
 .BIST_COL_ADD_ts1(BIST_COL_ADD_ts1), .BIST_ROW_ADD(BIST_ROW_ADD[4:0]), 
 .BIST_ROW_ADD_ts1(BIST_ROW_ADD_ts1), .BIST_ROW_ADD_ts2(BIST_ROW_ADD_ts2[0]), 
 .BIST_ROW_ADD_ts3(BIST_ROW_ADD_ts2[1]), .BIST_ROW_ADD_ts4(BIST_ROW_ADD_ts2[2]), 
 .BIST_ROW_ADD_ts5(BIST_ROW_ADD_ts2[3]), .BIST_ROW_ADD_ts6(BIST_ROW_ADD_ts2[4]), 
 .BIST_ROW_ADD_ts7(BIST_ROW_ADD_ts3[0]), .BIST_ROW_ADD_ts8(BIST_ROW_ADD_ts3[1]), 
 .BIST_ROW_ADD_ts9(BIST_ROW_ADD_ts3[2]), .BIST_ROW_ADD_ts10(BIST_ROW_ADD_ts3[3]), 
 .BIST_ROW_ADD_ts11(BIST_ROW_ADD_ts3[4]), .BIST_BANK_ADD(BIST_BANK_ADD), 
 .BIST_BANK_ADD_ts1(BIST_BANK_ADD_ts1), .BIST_COLLAR_EN0(BIST_COLLAR_EN0), 
 .BIST_COLLAR_EN1(BIST_COLLAR_EN1), .BIST_COLLAR_EN0_ts1(BIST_COLLAR_EN0_ts1), 
 .BIST_COLLAR_EN0_ts2(BIST_COLLAR_EN0_ts2), .BIST_COLLAR_EN1_ts1(BIST_COLLAR_EN1_ts1), 
 .BIST_COLLAR_EN0_ts3(BIST_COLLAR_EN0_ts3), .BIST_COLLAR_EN1_ts2(BIST_COLLAR_EN1_ts2), 
 .BIST_COLLAR_EN2(BIST_COLLAR_EN2), .BIST_COLLAR_EN3(BIST_COLLAR_EN3), 
 .BIST_COLLAR_EN4(BIST_COLLAR_EN4), .BIST_COLLAR_EN5(BIST_COLLAR_EN5), 
 .BIST_COLLAR_EN6(BIST_COLLAR_EN6), .BIST_COLLAR_EN7(BIST_COLLAR_EN7), 
 .BIST_COLLAR_EN8(BIST_COLLAR_EN8), .BIST_COLLAR_EN9(BIST_COLLAR_EN9), 
 .BIST_RUN_TO_COLLAR0(BIST_RUN_TO_COLLAR0), .BIST_RUN_TO_COLLAR1(BIST_RUN_TO_COLLAR1), 
 .BIST_RUN_TO_COLLAR0_ts1(BIST_RUN_TO_COLLAR0_ts1), .BIST_RUN_TO_COLLAR0_ts2(BIST_RUN_TO_COLLAR0_ts2), 
 .BIST_RUN_TO_COLLAR1_ts1(BIST_RUN_TO_COLLAR1_ts1), .BIST_RUN_TO_COLLAR0_ts3(BIST_RUN_TO_COLLAR0_ts3), 
 .BIST_RUN_TO_COLLAR1_ts2(BIST_RUN_TO_COLLAR1_ts2), .BIST_RUN_TO_COLLAR2(BIST_RUN_TO_COLLAR2), 
 .BIST_RUN_TO_COLLAR3(BIST_RUN_TO_COLLAR3), .BIST_RUN_TO_COLLAR4(BIST_RUN_TO_COLLAR4), 
 .BIST_RUN_TO_COLLAR5(BIST_RUN_TO_COLLAR5), .BIST_RUN_TO_COLLAR6(BIST_RUN_TO_COLLAR6), 
 .BIST_RUN_TO_COLLAR7(BIST_RUN_TO_COLLAR7), .BIST_RUN_TO_COLLAR8(BIST_RUN_TO_COLLAR8), 
 .BIST_RUN_TO_COLLAR9(BIST_RUN_TO_COLLAR9), .BIST_ASYNC_RESET_clk(BIST_ASYNC_RESET_clk), 
 .BIST_ASYNC_RESET_switch_clk(BIST_ASYNC_RESET_switch_clk), 
 .BIST_SHADOW_READENABLE(BIST_SHADOW_READENABLE), .BIST_SHADOW_READADDRESS(BIST_SHADOW_READADDRESS), 
 .BIST_SHADOW_READENABLE_ts1(BIST_SHADOW_READENABLE_ts1), 
 .BIST_SHADOW_READADDRESS_ts1(BIST_SHADOW_READADDRESS_ts1), 
 .BIST_SHADOW_READENABLE_ts2(BIST_SHADOW_READENABLE_ts2), 
 .BIST_SHADOW_READADDRESS_ts2(BIST_SHADOW_READADDRESS_ts2), 
 .BIST_SHADOW_READENABLE_ts3(BIST_SHADOW_READENABLE_ts3), 
 .BIST_SHADOW_READADDRESS_ts3(BIST_SHADOW_READADDRESS_ts3), 
 .BIST_CONWRITE_ROWADDRESS(BIST_CONWRITE_ROWADDRESS), .BIST_CONWRITE_ENABLE(BIST_CONWRITE_ENABLE), 
 .BIST_CONWRITE_ROWADDRESS_ts1(BIST_CONWRITE_ROWADDRESS_ts1), 
 .BIST_CONWRITE_ENABLE_ts1(BIST_CONWRITE_ENABLE_ts1), 
 .BIST_CONWRITE_ROWADDRESS_ts2(BIST_CONWRITE_ROWADDRESS_ts2), 
 .BIST_CONWRITE_ENABLE_ts2(BIST_CONWRITE_ENABLE_ts2), 
 .BIST_CONWRITE_ROWADDRESS_ts3(BIST_CONWRITE_ROWADDRESS_ts3), 
 .BIST_CONWRITE_ENABLE_ts3(BIST_CONWRITE_ENABLE_ts3), 
 .BIST_CONREAD_ROWADDRESS(BIST_CONREAD_ROWADDRESS), 
 .BIST_CONREAD_COLUMNADDRESS(BIST_CONREAD_COLUMNADDRESS), 
 .BIST_CONREAD_ENABLE(BIST_CONREAD_ENABLE), .BIST_CONREAD_ROWADDRESS_ts1(BIST_CONREAD_ROWADDRESS_ts1), 
 .BIST_CONREAD_COLUMNADDRESS_ts1(BIST_CONREAD_COLUMNADDRESS_ts1), 
 .BIST_CONREAD_ENABLE_ts1(BIST_CONREAD_ENABLE_ts1), 
 .BIST_CONREAD_ROWADDRESS_ts2(BIST_CONREAD_ROWADDRESS_ts2), 
 .BIST_CONREAD_COLUMNADDRESS_ts2(BIST_CONREAD_COLUMNADDRESS_ts2), 
 .BIST_CONREAD_ENABLE_ts2(BIST_CONREAD_ENABLE_ts2), 
 .BIST_CONREAD_ROWADDRESS_ts3(BIST_CONREAD_ROWADDRESS_ts3), 
 .BIST_CONREAD_COLUMNADDRESS_ts3(BIST_CONREAD_COLUMNADDRESS_ts3), 
 .BIST_CONREAD_ENABLE_ts3(BIST_CONREAD_ENABLE_ts3), 
 .BIST_TESTDATA_SELECT_TO_COLLAR(BIST_TESTDATA_SELECT_TO_COLLAR), 
 .BIST_TESTDATA_SELECT_TO_COLLAR_ts1(BIST_TESTDATA_SELECT_TO_COLLAR_ts1), 
 .BIST_TESTDATA_SELECT_TO_COLLAR_ts2(BIST_TESTDATA_SELECT_TO_COLLAR_ts2), 
 .BIST_TESTDATA_SELECT_TO_COLLAR_ts3(BIST_TESTDATA_SELECT_TO_COLLAR_ts3), 
 .BIST_ON_TO_COLLAR(BIST_ON_TO_COLLAR), .BIST_ON_TO_COLLAR_ts1(BIST_ON_TO_COLLAR_ts1), 
 .BIST_ON_TO_COLLAR_ts2(BIST_ON_TO_COLLAR_ts2), .BIST_ON_TO_COLLAR_ts3(BIST_ON_TO_COLLAR_ts3), 
 .BIST_WRITE_DATA(BIST_WRITE_DATA[7:0]), .BIST_WRITE_DATA_ts1(BIST_WRITE_DATA_ts1), 
 .BIST_WRITE_DATA_ts2(BIST_WRITE_DATA_ts2[0]), .BIST_WRITE_DATA_ts3(BIST_WRITE_DATA_ts2[1]), 
 .BIST_WRITE_DATA_ts4(BIST_WRITE_DATA_ts2[2]), .BIST_WRITE_DATA_ts5(BIST_WRITE_DATA_ts2[3]), 
 .BIST_WRITE_DATA_ts6(BIST_WRITE_DATA_ts2[4]), .BIST_WRITE_DATA_ts7(BIST_WRITE_DATA_ts2[5]), 
 .BIST_WRITE_DATA_ts8(BIST_WRITE_DATA_ts2[6]), .BIST_WRITE_DATA_ts9(BIST_WRITE_DATA_ts2[7]), 
 .BIST_WRITE_DATA_ts10(BIST_WRITE_DATA_ts3[0]), .BIST_WRITE_DATA_ts11(BIST_WRITE_DATA_ts3[1]), 
 .BIST_WRITE_DATA_ts12(BIST_WRITE_DATA_ts3[2]), .BIST_WRITE_DATA_ts13(BIST_WRITE_DATA_ts3[3]), 
 .BIST_WRITE_DATA_ts14(BIST_WRITE_DATA_ts3[4]), .BIST_WRITE_DATA_ts15(BIST_WRITE_DATA_ts3[5]), 
 .BIST_WRITE_DATA_ts16(BIST_WRITE_DATA_ts3[6]), .BIST_WRITE_DATA_ts17(BIST_WRITE_DATA_ts3[7]), 
 .BIST_EXPECT_DATA(BIST_EXPECT_DATA[7:0]), .BIST_EXPECT_DATA_ts1(BIST_EXPECT_DATA_ts1), 
 .BIST_EXPECT_DATA_ts2(BIST_EXPECT_DATA_ts2[0]), .BIST_EXPECT_DATA_ts3(BIST_EXPECT_DATA_ts2[1]), 
 .BIST_EXPECT_DATA_ts4(BIST_EXPECT_DATA_ts2[2]), .BIST_EXPECT_DATA_ts5(BIST_EXPECT_DATA_ts2[3]), 
 .BIST_EXPECT_DATA_ts6(BIST_EXPECT_DATA_ts2[4]), .BIST_EXPECT_DATA_ts7(BIST_EXPECT_DATA_ts2[5]), 
 .BIST_EXPECT_DATA_ts8(BIST_EXPECT_DATA_ts2[6]), .BIST_EXPECT_DATA_ts9(BIST_EXPECT_DATA_ts2[7]), 
 .BIST_EXPECT_DATA_ts10(BIST_EXPECT_DATA_ts3[0]), .BIST_EXPECT_DATA_ts11(BIST_EXPECT_DATA_ts3[1]), 
 .BIST_EXPECT_DATA_ts12(BIST_EXPECT_DATA_ts3[2]), .BIST_EXPECT_DATA_ts13(BIST_EXPECT_DATA_ts3[3]), 
 .BIST_EXPECT_DATA_ts14(BIST_EXPECT_DATA_ts3[4]), .BIST_EXPECT_DATA_ts15(BIST_EXPECT_DATA_ts3[5]), 
 .BIST_EXPECT_DATA_ts16(BIST_EXPECT_DATA_ts3[6]), .BIST_EXPECT_DATA_ts17(BIST_EXPECT_DATA_ts3[7]), 
 .BIST_SHIFT_COLLAR(BIST_SHIFT_COLLAR), .BIST_SHIFT_COLLAR_ts1(BIST_SHIFT_COLLAR_ts1), 
 .BIST_SHIFT_COLLAR_ts2(BIST_SHIFT_COLLAR_ts2), .BIST_SHIFT_COLLAR_ts3(BIST_SHIFT_COLLAR_ts3), 
 .BIST_COLLAR_SETUP(BIST_COLLAR_SETUP), .BIST_COLLAR_SETUP_ts1(BIST_COLLAR_SETUP_ts1), 
 .BIST_COLLAR_SETUP_ts2(BIST_COLLAR_SETUP_ts2), .BIST_COLLAR_SETUP_ts3(BIST_COLLAR_SETUP_ts3), 
 .BIST_CLEAR_DEFAULT(BIST_CLEAR_DEFAULT), .BIST_CLEAR_DEFAULT_ts1(BIST_CLEAR_DEFAULT_ts1), 
 .BIST_CLEAR_DEFAULT_ts2(BIST_CLEAR_DEFAULT_ts2), .BIST_CLEAR_DEFAULT_ts3(BIST_CLEAR_DEFAULT_ts3), 
 .BIST_CLEAR(BIST_CLEAR), .BIST_CLEAR_ts1(BIST_CLEAR_ts1), .BIST_CLEAR_ts2(BIST_CLEAR_ts2), 
 .BIST_CLEAR_ts3(BIST_CLEAR_ts3), .BIST_COLLAR_OPSET_SELECT(BIST_COLLAR_OPSET_SELECT), 
 .BIST_COLLAR_OPSET_SELECT_ts1(BIST_COLLAR_OPSET_SELECT_ts1), 
 .BIST_COLLAR_OPSET_SELECT_ts2(BIST_COLLAR_OPSET_SELECT_ts2), 
 .BIST_COLLAR_OPSET_SELECT_ts3(BIST_COLLAR_OPSET_SELECT_ts3), 
 .BIST_COLLAR_HOLD(BIST_COLLAR_HOLD), .FREEZE_STOP_ERROR(FREEZE_STOP_ERROR), 
 .ERROR_CNT_ZERO(ERROR_CNT_ZERO), .BIST_COLLAR_HOLD_ts1(BIST_COLLAR_HOLD_ts1), 
 .FREEZE_STOP_ERROR_ts1(FREEZE_STOP_ERROR_ts1), .ERROR_CNT_ZERO_ts1(ERROR_CNT_ZERO_ts1), 
 .BIST_COLLAR_HOLD_ts2(BIST_COLLAR_HOLD_ts2), .FREEZE_STOP_ERROR_ts2(FREEZE_STOP_ERROR_ts2), 
 .ERROR_CNT_ZERO_ts2(ERROR_CNT_ZERO_ts2), .BIST_COLLAR_HOLD_ts3(BIST_COLLAR_HOLD_ts3), 
 .FREEZE_STOP_ERROR_ts3(FREEZE_STOP_ERROR_ts3), .ERROR_CNT_ZERO_ts3(ERROR_CNT_ZERO_ts3), 
 .MBISTPG_RESET_REG_SETUP2(MBISTPG_RESET_REG_SETUP2), 
 .MBISTPG_RESET_REG_SETUP2_ts1(MBISTPG_RESET_REG_SETUP2_ts1), 
 .MBISTPG_RESET_REG_SETUP2_ts2(MBISTPG_RESET_REG_SETUP2_ts2), 
 .MBISTPG_RESET_REG_SETUP2_ts3(MBISTPG_RESET_REG_SETUP2_ts3), .BIST_TEST_PORT(BIST_TEST_PORT), 
 .bisr_shift_en_pd_vinf(bisr_shift_en_pd_vinf), .bisr_clk_pd_vinf(bisr_clk_pd_vinf), 
 .bisr_reset_pd_vinf(bisr_reset_pd_vinf), .bisr_si_pd_vinf(bisr_si_pd_vinf), 
 .ram_row_0_col_0_bisr_inst_SO_ts1(ram_row_0_col_0_bisr_inst_SO), 
 .fscan_clkungate_ts1(fscan_clkungate));

/*
  hlp_port4_apr_ff_mems AUTO_TEMPLATE
 (
  .clk                          (gclk[]),
  .\(.*\)_from_mem              (frm_\1[]),
  .\(.*\)_to_mem                (tom_\1[]) ); */
hlp_port4_apr_ff_mems u_port4_apr_ff_mems
( /*AUTOINST*/
 // Outputs
 .mac4_mac4_stats_snap_rx_from_mem      (frm_mac4_mac4_stats_snap_rx[`HLP_MAC4_MAC4_STATS_SNAP_RX_FROM_MEM_WIDTH-1:0]), // Templated
 .mac4_mac4_stats_snap_tx_from_mem      (frm_mac4_mac4_stats_snap_tx[`HLP_MAC4_MAC4_STATS_SNAP_TX_FROM_MEM_WIDTH-1:0]), // Templated
 .mac4_smac_tx_fifo_from_mem            (frm_mac4_smac_tx_fifo[`HLP_MAC4_SMAC_TX_FIFO_FROM_MEM_WIDTH-1:0]), // Templated
 .mac4_smac_tx_pre_from_mem             (frm_mac4_smac_tx_pre[`HLP_MAC4_SMAC_TX_PRE_FROM_MEM_WIDTH-1:0]), // Templated
 // Inputs
 .clk                                   (gclk),                  // Templated
 .mac4_mac4_stats_snap_rx_to_mem        (tom_mac4_mac4_stats_snap_rx[`HLP_MAC4_MAC4_STATS_SNAP_RX_TO_MEM_WIDTH-1:0]), // Templated
 .mac4_mac4_stats_snap_tx_to_mem        (tom_mac4_mac4_stats_snap_tx[`HLP_MAC4_MAC4_STATS_SNAP_TX_TO_MEM_WIDTH-1:0]), // Templated
 .mac4_smac_tx_fifo_to_mem              (tom_mac4_smac_tx_fifo[`HLP_MAC4_SMAC_TX_FIFO_TO_MEM_WIDTH-1:0]), // Templated
 .mac4_smac_tx_pre_to_mem               (tom_mac4_smac_tx_pre[`HLP_MAC4_SMAC_TX_PRE_TO_MEM_WIDTH-1:0])); // Templated

/*
 hlp_port4_apr_func_logic AUTO_TEMPLATE
 (
  .o_gclk       (gclk[]),
  .rst_n                  (local_rst_n),
  .powergood_rst_n        (local_powergood_rst_n),
  .mem_rst_n              (local_mem_rst_n),
  .swclk_mem_rst_n        (local_swclk_mem_rst_n),
  .switch_rst_n           (local_switch_rst_n),
  .o_tom_\(.*\) (tom_\1[][]),
  .i_frm_\(.*\) (frm_\1[][]) );
*/
hlp_port4_apr_func_logic #(
    .MACS (MACS)
) u_port4_apr_func_logic 
(
`ifndef __VISA_IT__
`ifndef INTEL_GLOBAL_VISA_DISABLE

(* inserted_by="VISA IT" *) .visaRt_cfg_rd_bus_out_from_u_port4_apr_func_logic_visa_unit_mux_regout_0({visaSerCfgRd_port4_apr_ngvisa_top_junc[0][1:0]}),
(* inserted_by="VISA IT" *) .visaRt_cfg_rd_bus_out_from_u_port4_apr_func_logic_visa_unit_mux_regout_2({visaSerCfgRd_port4_apr_ngvisa_top_junc[1][1:0]}),
(* inserted_by="VISA IT" *) .visaRt_cfg_wr_bus_in_to_parhlpport4_2_port4_apr_1_port4_apr_ngvisa_top_junc(visaRt_cfg_wr_bus_in_from_parhlpport4_0_port4_apr_0_port4_apr_ngvisa_top_junc),
(* inserted_by="VISA IT" *) .visaRt_clk_from_u_port4_apr_func_logic(visaRt_clk_from_u_port4_apr_func_logic),
(* inserted_by="VISA IT" *) .visaRt_enable_from_u_port4_apr_func_logic(visaRt_enable_from_u_port4_apr_func_logic),
(* inserted_by="VISA IT" *) .visaRt_fscan_byprst_b_to_port4_apr_ngvisa_top_junc(fscan_byprst_b),
(* inserted_by="VISA IT" *) .visaRt_fscan_clkungate_to_port4_apr_ngvisa_top_junc(fscan_clkungate),
(* inserted_by="VISA IT" *) .visaRt_fscan_rstbypen_to_port4_apr_ngvisa_top_junc(fscan_rstbypen),
(* inserted_by="VISA IT" *) .visaRt_lane_out_from_u_port4_apr_func_logic_visa_unit_mux_regout_0({visaLaneIn_port4_apr_ngvisa_top_junc[1:0]}),
(* inserted_by="VISA IT" *) .visaRt_lane_out_from_u_port4_apr_func_logic_visa_unit_mux_regout_2({visaLaneIn_port4_apr_ngvisa_top_junc[3:2]}),
(* inserted_by="VISA IT" *) .visaRt_lane_valid_out_from_u_port4_apr_func_logic_visa_unit_mux_regout_0(visaLaneValidIn_port4_apr_ngvisa_top_junc_7[1:0]),
(* inserted_by="VISA IT" *) .visaRt_lane_valid_out_from_u_port4_apr_func_logic_visa_unit_mux_regout_2(visaLaneValidIn_port4_apr_ngvisa_top_junc_7[3:2]),
(* inserted_by="VISA IT" *) .visaRt_resetb_from_u_port4_apr_func_logic(visaRt_resetb_from_u_port4_apr_func_logic),
(* inserted_by="VISA IT" *) .visaRt_unit_id_to_parhlpports_parhlpport4_0_port4_apr_0_u_port4_apr_func_logic_visa_unit_mux_regout_0(visaRt_unit_id_to_parhlpports_parhlpport4_0_port4_apr_0_u_port4_apr_func_logic_visa_unit_mux_regout_0),
(* inserted_by="VISA IT" *) .visaRt_unit_id_to_parhlpports_parhlpport4_0_port4_apr_0_u_port4_apr_func_logic_visa_unit_mux_regout_2(visaRt_unit_id_to_parhlpports_parhlpport4_0_port4_apr_0_u_port4_apr_func_logic_visa_unit_mux_regout_2),


`endif // INTEL_GLOBAL_VISA_DISABLE
`endif // __VISA_IT__
 // Auto Included by VISA IT - *** Do not modify this line ***

//`include "hlp_port4_apr.VISA_IT.hlp_port4_apr.inst.u_port4_apr_func_logic.sv" // Auto Included by VISA IT - *** Do not modify this line ***
 .fet_ack_b(fet_ack_b_to_sram),
  .fet_en_b (fet_en_b),
  /*AUTOINST*/
 // Outputs
 .isol_ack_b                            (isol_ack_b),
 .avisa_serstb                          (avisa_serstb),
 .avisa_frame                           (avisa_frame),
 .avisa_serdata                         (avisa_serdata),
 .avisa_rddata                          (avisa_rddata),
 .avisa_customer_dis                    (avisa_customer_dis),
 .avisa_all_dis                         (avisa_all_dis),
 .avisa_dbg_lane                        (avisa_dbg_lane[hlp_dfx_pkg::VISA_DBG_LANE_WIDTH-1:0]),
 .avisa_clk                             (avisa_clk[hlp_dfx_pkg::NUM_VISA_LANES-1:0]),
 .ascan_sdo                             (ascan_sdo[hlp_dfx_pkg::PORT4_NUM_SDO-1:0]),
 .o_gclk                                (gclk),                  // Templated
 .mii_tx                                (mii_tx[MACS-1:0]),
 .o_cfg_tx_jitter                       (o_cfg_tx_jitter[hlp_sia_pkg::PORTS_PER_SIA-1:0]),
 .o_cfg_txram_port_bound                (o_cfg_txram_port_bound),
 .o_iarb_token_rate                     (o_iarb_token_rate[hlp_sia_pkg::IARB_TOKENS_CNT_INHIBIT_CNT_WIDTH-1:0]),
 .o_msec_mac_rx                         (o_msec_mac_rx[MACS-1:0]),
 .o_msec_mac_rx_v                       (o_msec_mac_rx_v[MACS-1:0]),
 .o_msec_mac_tx_e                       (o_msec_mac_tx_e[MACS-1:0]),
 .o_msec_switch_rx_e                    (o_msec_switch_rx_e[MACS-1:0]),
 .o_msec_switch_tx                      (o_msec_switch_tx[MACS-1:0]),
 .o_msec_switch_tx_v                    (o_msec_switch_tx_v[MACS-1:0]),
 .o_obuf_data                           (o_obuf_data),
 .o_p0_mode                             (o_p0_mode),
 .o_port_en                             (o_port_en[hlp_sia_pkg::PORTS_PER_SIA-1:0]),
 .o_ports_info                          (o_ports_info[$bits(hlp_mac_pkg::info_ports_common_t)-1:0]),
 .o_rpl_bkwd                            (o_rpl_bkwd),
 .o_rpl_frwd                            (o_rpl_frwd),
 .o_rx_grant_fifo_afull                 (o_rx_grant_fifo_afull),
 .o_rx_q_xoff                           (o_rx_q_xoff/*[0:hlp_sia_pkg::PORTS_PER_SIA-1][hlp_sia_pkg::RX_QUEUES_PER_SIA_PORT-1:0]*/),
 .o_rx_tap_port_cfg                     (o_rx_tap_port_cfg[0:hlp_sia_pkg::PORTS_PER_SIA-1]),
 .o_rx_throttle                         (o_rx_throttle[MACS-1:0]),
 .o_seg_valid                           (o_seg_valid/*[hlp_sia_pkg::PORTS_PER_SIA-1:0][hlp_sia_pkg::RX_IARB_TOKEN_REQ_CNT_WIDTH-1:0]*/),
 .o_switch_rx_pc_xoff                   (o_switch_rx_pc_xoff[0:hlp_sia_pkg::PORTS_PER_SIA-1]),
 .o_time_scale_pulse                    (o_time_scale_pulse),
 .o_tom_mac4_mac4_stats_full_rx         (tom_mac4_mac4_stats_full_rx[`HLP_MAC4_MAC4_STATS_FULL_RX_TO_MEM_WIDTH-1:0]), // Templated
 .o_tom_mac4_mac4_stats_full_tx         (tom_mac4_mac4_stats_full_tx[`HLP_MAC4_MAC4_STATS_FULL_TX_TO_MEM_WIDTH-1:0]), // Templated
 .o_tom_mac4_mac4_stats_snap_rx         (tom_mac4_mac4_stats_snap_rx[`HLP_MAC4_MAC4_STATS_SNAP_RX_TO_MEM_WIDTH-1:0]), // Templated
 .o_tom_mac4_mac4_stats_snap_tx         (tom_mac4_mac4_stats_snap_tx[`HLP_MAC4_MAC4_STATS_SNAP_TX_TO_MEM_WIDTH-1:0]), // Templated
 .o_tom_mac4_smac_tx_fifo               (tom_mac4_smac_tx_fifo[`HLP_MAC4_SMAC_TX_FIFO_TO_MEM_WIDTH-1:0]), // Templated
 .o_tom_mac4_smac_tx_pre                (tom_mac4_smac_tx_pre[`HLP_MAC4_SMAC_TX_PRE_TO_MEM_WIDTH-1:0]), // Templated
 .o_tom_mac4_tsu_mem                    (tom_mac4_tsu_mem[`HLP_MAC4_TSU_MEM_TO_MEM_WIDTH-1:0]), // Templated
 .o_tom_sia_sia_qram                    (tom_sia_sia_qram[`HLP_SIA_SIA_QRAM_TO_MEM_WIDTH-1:0]), // Templated
 .o_tom_sia_sia_rxram                   (tom_sia_sia_rxram[`HLP_SIA_SIA_RXRAM_TO_MEM_WIDTH-1:0]), // Templated
 .o_tom_sia_sia_txmetaram               (tom_sia_sia_txmetaram[`HLP_SIA_SIA_TXMETARAM_TO_MEM_WIDTH-1:0]), // Templated
 .o_tom_sia_sia_txram                   (tom_sia_sia_txram/*[9:0][`HLP_SIA_SIA_TXRAM_TO_MEM_WIDTH-1:0]*/), // Templated
 .o_txram_credit                        (o_txram_credit[hlp_sia_pkg::PORTS_PER_SIA-1:0]),
 // Inputs
 .isol_en_b                             (isol_en_b),
 .fvisa_serstb                          (fvisa_serstb),
 .fvisa_frame                           (fvisa_frame),
 .fvisa_serdata                         (fvisa_serdata),
 .fvisa_rddata_port4                    (fvisa_rddata_port4),
 .fvisa_rddata_msec                     (fvisa_rddata_msec),
 .fvisa_customer_dis                    (fvisa_customer_dis),
 .fvisa_all_dis                         (fvisa_all_dis),
 .fvisa_dbg_lane_port4                  (fvisa_dbg_lane_port4[hlp_dfx_pkg::VISA_DBG_LANE_WIDTH-1:0]),
 .fvisa_clk_port4                       (fvisa_clk_port4[hlp_dfx_pkg::NUM_VISA_LANES-1:0]),
 .fvisa_dbg_lane_msec                   (fvisa_dbg_lane_msec[hlp_dfx_pkg::VISA_DBG_LANE_WIDTH-1:0]),
 .fvisa_clk_msec                        (fvisa_clk_msec[hlp_dfx_pkg::NUM_VISA_LANES-1:0]),
 .fvisa_resetb                          (fvisa_resetb),
 .fvisa_unit_id                         (fvisa_unit_id[8:0]),
 .fscan_ret_ctrl                        (fscan_ret_ctrl),
 .fscan_shiften                         (fscan_shiften),
 .fscan_latchopen                       (fscan_latchopen),
 .fscan_latchclosed_b                   (fscan_latchclosed_b),
 .fscan_clkungate                       (fscan_clkungate_out),
 .fscan_clkungate_syn                   (fscan_clkungate_syn),
 .fscan_mode                            (fscan_mode),
 .fscan_mode_atspeed                    (fscan_mode_atspeed),
 .fscan_clkgenctrl                      (fscan_clkgenctrl[hlp_dfx_pkg::PORT4_NUM_CLKGENCTRL-1:0]),
 .fscan_clkgenctrlen                    (fscan_clkgenctrlen[hlp_dfx_pkg::PORT4_NUM_CLKGENCTRLEN-1:0]),
 .fscan_sdi                             (fscan_sdi[hlp_dfx_pkg::PORT4_NUM_SDI-1:0]),
 .i_mac_id                              (i_mac_id[1:0]),
 .i_port1_id                            (i_port1_id[4:0]),
 .i_id                                  (i_id[$bits(hlp_pkg::quad_id_t)-1:0]),
 .i_port4_disable                       (i_port4_disable),
 .i_msec_disable                        (i_msec_disable),
 .i_mac_limit                           (i_mac_limit[1:0]),
// .clk                                   (clk_ts1),
 .fscan_byprst_b                        (fscan_byprst_b),
 .fscan_rstbypen                        (fscan_rstbypen),
 .i_force_clk_en                        (i_force_clk_en),
 .i_frm_mac4_mac4_stats_full_rx         (frm_mac4_mac4_stats_full_rx[`HLP_MAC4_MAC4_STATS_FULL_RX_FROM_MEM_WIDTH-1:0]), // Templated
 .i_frm_mac4_mac4_stats_full_tx         (frm_mac4_mac4_stats_full_tx[`HLP_MAC4_MAC4_STATS_FULL_TX_FROM_MEM_WIDTH-1:0]), // Templated
 .i_frm_mac4_mac4_stats_snap_rx         (frm_mac4_mac4_stats_snap_rx[`HLP_MAC4_MAC4_STATS_SNAP_RX_FROM_MEM_WIDTH-1:0]), // Templated
 .i_frm_mac4_mac4_stats_snap_tx         (frm_mac4_mac4_stats_snap_tx[`HLP_MAC4_MAC4_STATS_SNAP_TX_FROM_MEM_WIDTH-1:0]), // Templated
 .i_frm_mac4_smac_tx_fifo               (frm_mac4_smac_tx_fifo[`HLP_MAC4_SMAC_TX_FIFO_FROM_MEM_WIDTH-1:0]), // Templated
 .i_frm_mac4_smac_tx_pre                (frm_mac4_smac_tx_pre[`HLP_MAC4_SMAC_TX_PRE_FROM_MEM_WIDTH-1:0]), // Templated
 .i_frm_mac4_tsu_mem                    (frm_mac4_tsu_mem[`HLP_MAC4_TSU_MEM_FROM_MEM_WIDTH-1:0]), // Templated
 .i_frm_sia_sia_qram                    (frm_sia_sia_qram[`HLP_SIA_SIA_QRAM_FROM_MEM_WIDTH-1:0]), // Templated
 .i_frm_sia_sia_rxram                   (frm_sia_sia_rxram[`HLP_SIA_SIA_RXRAM_FROM_MEM_WIDTH-1:0]), // Templated
 .i_frm_sia_sia_txmetaram               (frm_sia_sia_txmetaram[`HLP_SIA_SIA_TXMETARAM_FROM_MEM_WIDTH-1:0]), // Templated
 .i_frm_sia_sia_txram                   (frm_sia_sia_txram/*[9:0][`HLP_SIA_SIA_TXRAM_FROM_MEM_WIDTH-1:0]*/), // Templated
 .i_jitter_cred_tgl                     (i_jitter_cred_tgl[hlp_sia_pkg::PORTS_PER_SIA-1:0]),
 .i_msec_mac_rx_e                       (i_msec_mac_rx_e[MACS-1:0]),
 .i_msec_mac_tx                         (i_msec_mac_tx[MACS-1:0]),
 .i_msec_mac_tx_v                       (i_msec_mac_tx_v[MACS-1:0]),
 .i_msec_switch_rx                      (i_msec_switch_rx[MACS-1:0]),
 .i_msec_switch_rx_v                    (i_msec_switch_rx_v[MACS-1:0]),
 .i_msec_switch_tx_e                    (i_msec_switch_tx_e[MACS-1:0]),
 .i_ports_cfg                           (i_ports_cfg[$bits(hlp_mac_pkg::cfg_ports_common_t)-1:0]),
 .i_rpl_bkwd                            (i_rpl_bkwd),
 .i_rpl_frwd                            (i_rpl_frwd),
 .i_rx_grant_fifo_push                  (i_rx_grant_fifo_push),
 .i_rx_grant_fifo_push_data             (i_rx_grant_fifo_push_data[hlp_sia_pkg::RX_GRANT_FIFO_CONTENTS_WIDTH-1:0]),
 .i_rx_pause_gen_pfc_smp_xoff           (i_rx_pause_gen_pfc_smp_xoff/*[0:hlp_sia_pkg::PORTS_PER_SIA-1][hlp_pkg::N_TC-1:0]*/),
 .i_rx_pause_gen_smp_xoff               (i_rx_pause_gen_smp_xoff[0:hlp_sia_pkg::PORTS_PER_SIA-1]),
 .i_sia_tx_tap_int                      (i_sia_tx_tap_int),
 .i_switch_ready                        (i_switch_ready),
 .i_time_scale_pulse                    (i_time_scale_pulse),
 .i_tsu_sync_val                        (i_tsu_sync_val[1:0]),
 .i_tx_stop                             (i_tx_stop[MACS-1:0]),
 .i_tx_switch_ready                     (i_tx_switch_ready),
 .i_txmetaram_win                       (i_txmetaram_win),
 .i_txram_win                           (i_txram_win),
 .i_txram_wr_tgl                        (i_txram_wr_tgl[hlp_sia_pkg::PORTS_PER_SIA-1:0]),
// .mem_rst_n                             (local_mem_rst_n),       // Templated
 .mii_rx                                (mii_rx[MACS-1:0]),
 .mii_tsu_in                            (mii_tsu_in[MACS-1:0]),
// .powergood_rst_n                       (local_powergood_rst_n), // Templated
// .rst_n                                 (local_rst_n),           // Templated
// .swclk_mem_rst_n                       (local_swclk_mem_rst_n), // Templated
 .switch_clk                            (switch_clk_ts1),
// .switch_rst_n                          (local_switch_rst_n));  // Templated
 .tsu_en                                (tsu_en));



//`include "hlp_port4_apr.VISA_IT.hlp_port4_apr.logic.sv" // Auto Included by VISA IT - *** Do not modify this line ***

`include "hlp_port4_apr.VISA_IT.hlp_port4_apr.logic.sv" // Auto Included by VISA IT - *** Do not modify this line ***

  hlp_port4_apr_rtl_tessent_sib_1 hlp_port4_apr_rtl_tessent_sib_sti_inst(
      .ijtag_reset(fary_ijtag_rst_b), .ijtag_sel(fary_ijtag_select), .ijtag_si(fary_ijtag_si), 
      .ijtag_ce(fary_ijtag_capture), .ijtag_se(fary_ijtag_shift), .ijtag_ue(fary_ijtag_update), 
      .ijtag_tck(fary_ijtag_tck), .ijtag_so(hlp_port4_apr_rtl_tessent_sib_sti_inst_so), 
      .ijtag_from_so(hlp_port4_apr_rtl_tessent_sib_mbist_inst_so), .ltest_si(1'b0), 
      .ltest_scan_en(DFTSHIFTEN), .ltest_en(fscan_mode), .ltest_clk(clk_rscclk), 
      .ltest_mem_bypass_en(DFTMASK), .ltest_mcp_bounding_en(fscan_ram_init_en), 
      .ltest_async_set_reset_static_disable(fscan_byprst_b), .ijtag_to_tck(ijtag_to_tck), 
      .ijtag_to_reset(ijtag_to_reset), .ijtag_to_si(hlp_port4_apr_rtl_tessent_sib_sti_inst_so_ts1), 
      .ijtag_to_ce(ijtag_to_ce), .ijtag_to_se(ijtag_to_se), .ijtag_to_ue(ijtag_to_ue), 
      .ltest_so(), .ltest_to_en(ltest_to_en), .ltest_to_mem_bypass_en(ltest_to_mem_bypass_en), 
      .ltest_to_mcp_bounding_en(ltest_to_mcp_bounding_en), .ltest_to_scan_en(ltest_to_scan_en), 
      .ijtag_to_sel(hlp_port4_apr_rtl_tessent_sib_sti_inst_to_select)
  );

  hlp_port4_apr_rtl_tessent_sib_2 hlp_port4_apr_rtl_tessent_sib_sri_inst(
      .ijtag_reset(fary_ijtag_rst_b), .ijtag_sel(fary_ijtag_select), .ijtag_si(hlp_port4_apr_rtl_tessent_sib_sti_inst_so), 
      .ijtag_ce(fary_ijtag_capture), .ijtag_se(fary_ijtag_shift), .ijtag_ue(fary_ijtag_update), 
      .ijtag_tck(fary_ijtag_tck), .ijtag_so(aary_ijtag_so), .ijtag_from_so(hlp_port4_apr_rtl_tessent_sib_sri_ctrl_inst_so), 
      .ijtag_to_sel(hlp_port4_apr_rtl_tessent_sib_sri_inst_to_select)
  );

  hlp_port4_apr_rtl_tessent_sib_3 hlp_port4_apr_rtl_tessent_sib_sri_ctrl_inst(
      .ijtag_reset(fary_ijtag_rst_b), .ijtag_sel(hlp_port4_apr_rtl_tessent_sib_sri_inst_to_select), 
      .ijtag_si(hlp_port4_apr_rtl_tessent_sib_sti_inst_so), .ijtag_ce(fary_ijtag_capture), 
      .ijtag_se(fary_ijtag_shift), .ijtag_ue(fary_ijtag_update), .ijtag_tck(fary_ijtag_tck), 
      .ijtag_so(hlp_port4_apr_rtl_tessent_sib_sri_ctrl_inst_so), .ijtag_from_so(hlp_port4_apr_rtl_tessent_tdr_sri_ctrl_inst_so), 
      .ijtag_to_sel(hlp_port4_apr_rtl_tessent_sib_sri_ctrl_inst_to_select)
  );

  hlp_port4_apr_rtl_tessent_tdr_sri_ctrl hlp_port4_apr_rtl_tessent_tdr_sri_ctrl_inst(
      .ijtag_reset(fary_ijtag_rst_b), .ijtag_sel(hlp_port4_apr_rtl_tessent_sib_sri_ctrl_inst_to_select), 
      .ijtag_si(hlp_port4_apr_rtl_tessent_sib_sti_inst_so), .ijtag_ce(fary_ijtag_capture), 
      .ijtag_se(fary_ijtag_shift), .ijtag_ue(fary_ijtag_update), .ijtag_tck(fary_ijtag_tck), 
      .tck_select(tck_select), .all_test(), .ijtag_so(hlp_port4_apr_rtl_tessent_tdr_sri_ctrl_inst_so)
  );

  hlp_port4_apr_rtl_tessent_sib_4 hlp_port4_apr_rtl_tessent_sib_algo_select_sib_inst(
      .ijtag_reset(ijtag_to_reset), .ijtag_sel(hlp_port4_apr_rtl_tessent_sib_sti_inst_to_select), 
      .ijtag_si(hlp_port4_apr_rtl_tessent_sib_sti_inst_so_ts1), .ijtag_ce(ijtag_to_ce), 
      .ijtag_se(ijtag_to_se), .ijtag_ue(ijtag_to_ue), .ijtag_tck(ijtag_to_tck), 
      .ijtag_so(hlp_port4_apr_rtl_tessent_sib_algo_select_sib_inst_so), .ijtag_from_so(hlp_port4_apr_rtl_tessent_tdr_RF_c1_algo_select_tdr_inst_so), 
      .ijtag_to_sel(hlp_port4_apr_rtl_tessent_sib_algo_select_sib_inst_to_select)
  );

  hlp_port4_apr_rtl_tessent_sib_4 hlp_port4_apr_rtl_tessent_sib_mbist_inst(
      .ijtag_reset(ijtag_to_reset), .ijtag_sel(hlp_port4_apr_rtl_tessent_sib_sti_inst_to_select), 
      .ijtag_si(hlp_port4_apr_rtl_tessent_sib_algo_select_sib_inst_so), .ijtag_ce(ijtag_to_ce), 
      .ijtag_se(ijtag_to_se), .ijtag_ue(ijtag_to_ue), .ijtag_tck(ijtag_to_tck), 
      .ijtag_so(hlp_port4_apr_rtl_tessent_sib_mbist_inst_so), .ijtag_from_so(ijtag_so), 
      .ijtag_to_sel(ijtag_to_sel)
  );

  hlp_port4_apr_rtl_tessent_tdr_SRAM_c5_algo_select_tdr hlp_port4_apr_rtl_tessent_tdr_SRAM_c5_algo_select_tdr_inst(
      .ijtag_reset(ijtag_to_reset), .ijtag_sel(hlp_port4_apr_rtl_tessent_sib_algo_select_sib_inst_to_select), 
      .ijtag_si(hlp_port4_apr_rtl_tessent_sib_sti_inst_so_ts1), .ijtag_ce(ijtag_to_ce), 
      .ijtag_se(ijtag_to_se), .ijtag_ue(ijtag_to_ue), .ijtag_tck(ijtag_to_tck), 
      .ALGO_SEL_REG(ALGO_SEL_REG_ts4), .ijtag_so(hlp_port4_apr_rtl_tessent_tdr_SRAM_c5_algo_select_tdr_inst_so)
  );

  hlp_port4_apr_rtl_tessent_tdr_RF_c4_algo_select_tdr hlp_port4_apr_rtl_tessent_tdr_RF_c4_algo_select_tdr_inst(
      .ijtag_reset(ijtag_to_reset), .ijtag_sel(hlp_port4_apr_rtl_tessent_sib_algo_select_sib_inst_to_select), 
      .ijtag_si(hlp_port4_apr_rtl_tessent_tdr_SRAM_c5_algo_select_tdr_inst_so), 
      .ijtag_ce(ijtag_to_ce), .ijtag_se(ijtag_to_se), .ijtag_ue(ijtag_to_ue), .ijtag_tck(ijtag_to_tck), 
      .ALGO_SEL_REG(ALGO_SEL_REG_ts3), .ijtag_so(hlp_port4_apr_rtl_tessent_tdr_RF_c4_algo_select_tdr_inst_so)
  );

  hlp_port4_apr_rtl_tessent_tdr_RF_c3_algo_select_tdr hlp_port4_apr_rtl_tessent_tdr_RF_c3_algo_select_tdr_inst(
      .ijtag_reset(ijtag_to_reset), .ijtag_sel(hlp_port4_apr_rtl_tessent_sib_algo_select_sib_inst_to_select), 
      .ijtag_si(hlp_port4_apr_rtl_tessent_tdr_RF_c4_algo_select_tdr_inst_so), .ijtag_ce(ijtag_to_ce), 
      .ijtag_se(ijtag_to_se), .ijtag_ue(ijtag_to_ue), .ijtag_tck(ijtag_to_tck), 
      .ALGO_SEL_REG(ALGO_SEL_REG_ts2), .ijtag_so(hlp_port4_apr_rtl_tessent_tdr_RF_c3_algo_select_tdr_inst_so)
  );

  hlp_port4_apr_rtl_tessent_tdr_RF_c2_algo_select_tdr hlp_port4_apr_rtl_tessent_tdr_RF_c2_algo_select_tdr_inst(
      .ijtag_reset(ijtag_to_reset), .ijtag_sel(hlp_port4_apr_rtl_tessent_sib_algo_select_sib_inst_to_select), 
      .ijtag_si(hlp_port4_apr_rtl_tessent_tdr_RF_c3_algo_select_tdr_inst_so), .ijtag_ce(ijtag_to_ce), 
      .ijtag_se(ijtag_to_se), .ijtag_ue(ijtag_to_ue), .ijtag_tck(ijtag_to_tck), 
      .ALGO_SEL_REG(ALGO_SEL_REG_ts1), .ijtag_so(hlp_port4_apr_rtl_tessent_tdr_RF_c2_algo_select_tdr_inst_so)
  );

  hlp_port4_apr_rtl_tessent_tdr_RF_c1_algo_select_tdr hlp_port4_apr_rtl_tessent_tdr_RF_c1_algo_select_tdr_inst(
      .ijtag_reset(ijtag_to_reset), .ijtag_sel(hlp_port4_apr_rtl_tessent_sib_algo_select_sib_inst_to_select), 
      .ijtag_si(hlp_port4_apr_rtl_tessent_tdr_RF_c2_algo_select_tdr_inst_so), .ijtag_ce(ijtag_to_ce), 
      .ijtag_se(ijtag_to_se), .ijtag_ue(ijtag_to_ue), .ijtag_tck(ijtag_to_tck), 
      .ALGO_SEL_REG(ALGO_SEL_REG), .ijtag_so(hlp_port4_apr_rtl_tessent_tdr_RF_c1_algo_select_tdr_inst_so)
  );

  hlp_port4_apr_rtl_tessent_mbist_bap hlp_port4_apr_rtl_tessent_mbist_bap_inst(
      .reset(ijtag_to_reset), .ijtag_select(ijtag_to_sel), .si(hlp_port4_apr_rtl_tessent_sib_algo_select_sib_inst_so), 
      .capture_en(ijtag_to_ce), .shift_en(ijtag_to_se), .shift_en_R(), .update_en(ijtag_to_ue), 
      .tck(ijtag_to_tck), .to_interfaces_tck(to_interfaces_tck), .to_controllers_tck_retime(to_controllers_tck_retime), 
      .to_controllers_tck(to_controllers_tck), .mcp_bounding_en(ltest_to_mcp_bounding_en), 
      .mcp_bounding_to_en(mcp_bounding_to_en), .scan_en(ltest_to_scan_en), .scan_to_en(scan_to_en), 
      .memory_bypass_en(ltest_to_mem_bypass_en), .memory_bypass_to_en(memory_bypass_to_en), 
      .ltest_en(ltest_to_en), .ltest_to_en(ltest_to_en_ts1), .BIST_HOLD(BIST_HOLD), 
      .sys_ctrl_select({select_sram, select_rf, select_rf, select_rf, 
      select_rf}), .sys_algo_select(mbistpg_algo_sel_o[6:0]), .sys_select_common_algo(mbistpg_select_common_algo_o), 
      .sys_test_start_clk(trigger_post), .sys_test_init_clk(1'b0), .sys_reset_clk(sync_reset_clk_o), 
      .sys_clock_clk(gclk), .sys_test_pass_clk(sys_test_pass_clk), .sys_test_done_clk(sys_test_done_clk), 
      .sys_test_start_switch_clk(trigger_post), .sys_test_init_switch_clk(1'b0), 
      .sys_reset_switch_clk(sync_reset_switch_clk_o), .sys_clock_switch_clk(switch_clk_ts1), 
      .sys_test_pass_switch_clk(sys_test_pass_switch_clk), .sys_test_done_switch_clk(sys_test_done_switch_clk), 
      .sys_ctrl_pass(), .sys_ctrl_done(), .ENABLE_MEM_RESET(ENABLE_MEM_RESET), 
      .REDUCED_ADDRESS_COUNT(REDUCED_ADDRESS_COUNT), .BIST_SELECT_TEST_DATA(BIST_SELECT_TEST_DATA), 
      .BIST_ALGO_MODE0(BIST_ALGO_MODE0), .BIST_ALGO_MODE1(BIST_ALGO_MODE1), .sys_incremental_test_mode(1'b0), 
      .MEM_ARRAY_DUMP_MODE(MEM_ARRAY_DUMP_MODE), .BIRA_EN(BIRA_EN), .BIST_DIAG_EN(BIST_DIAG_EN), 
      .PRESERVE_FUSE_REGISTER(PRESERVE_FUSE_REGISTER), .CHECK_REPAIR_NEEDED(CHECK_REPAIR_NEEDED), 
      .BIST_ASYNC_RESET_clk(BIST_ASYNC_RESET_clk), .BIST_ASYNC_RESET_switch_clk(BIST_ASYNC_RESET_switch_clk), 
      .FL_CNT_MODE0(FL_CNT_MODE0), .FL_CNT_MODE1(FL_CNT_MODE1), .INCLUDE_MEM_RESULTS_REG(INCLUDE_MEM_RESULTS_REG), 
      .BIST_SETUP2(BIST_SETUP2), .BIST_SETUP1_clk(BIST_SETUP1_clk), .BIST_SETUP1_switch_clk(BIST_SETUP1_switch_clk), 
      .BIST_SETUP0(BIST_SETUP0), .BIST_ALGO_SEL({BIST_ALGO_SEL_ts6, 
      BIST_ALGO_SEL_ts5, BIST_ALGO_SEL_ts4, BIST_ALGO_SEL_ts3, 
      BIST_ALGO_SEL_ts2, BIST_ALGO_SEL_ts1, BIST_ALGO_SEL}), .BIST_SELECT_COMMON_ALGO(BIST_SELECT_COMMON_ALGO), 
      .BIST_OPSET_SEL(BIST_OPSET_SEL), .BIST_SELECT_COMMON_OPSET(BIST_SELECT_COMMON_OPSET), 
      .BIST_DATA_INV_COL_ADD_BIT_SEL(BIST_DATA_INV_COL_ADD_BIT_SEL), .BIST_DATA_INV_COL_ADD_BIT_SELECT_EN(BIST_DATA_INV_COL_ADD_BIT_SELECT_EN), 
      .BIST_DATA_INV_ROW_ADD_BIT_SEL(BIST_DATA_INV_ROW_ADD_BIT_SEL), .BIST_DATA_INV_ROW_ADD_BIT_SELECT_EN(BIST_DATA_INV_ROW_ADD_BIT_SELECT_EN), 
      .MBISTPG_GO({MBISTPG_GO_ts4, MBISTPG_GO_ts3, MBISTPG_GO_ts2, 
      MBISTPG_GO_ts1, MBISTPG_GO}), .MBISTPG_DONE({MBISTPG_DONE_ts4, 
      MBISTPG_DONE_ts3, MBISTPG_DONE_ts2, MBISTPG_DONE_ts1, MBISTPG_DONE}), .bistEn(bistEn[4:0]), 
      .toBist(toBist[4:0]), .fromBist({MBISTPG_SO_ts4, MBISTPG_SO_ts3, 
      MBISTPG_SO_ts2, MBISTPG_SO_ts1, MBISTPG_SO}), .so(hlp_port4_apr_rtl_tessent_mbist_bap_inst_so), 
      .fscan_clkungate(fscan_clkungate)
  );

  hlp_port4_apr_rtl_tessent_mbist_RF_c1_controller hlp_port4_apr_rtl_tessent_mbist_RF_c1_controller_inst(
      .MBIST_RA_PRSRV_FUSE_VAL(PRESERVE_FUSE_REGISTER), .MBISTPG_ALGO_SEL({
      BIST_ALGO_SEL_ts6, BIST_ALGO_SEL_ts5, BIST_ALGO_SEL_ts4, 
      BIST_ALGO_SEL_ts3, BIST_ALGO_SEL_ts2, BIST_ALGO_SEL_ts1, BIST_ALGO_SEL}), .MBISTPG_SELECT_COMMON_ALGO(BIST_SELECT_COMMON_ALGO), 
      .MBISTPG_OPSET_SELECT(BIST_OPSET_SEL), .MBISTPG_SELECT_COMMON_OPSET(BIST_SELECT_COMMON_OPSET), 
      .MBISTPG_DATA_INV_ROW_ADD_BIT_SELECT_EN(BIST_DATA_INV_ROW_ADD_BIT_SELECT_EN), 
      .MBISTPG_DATA_INV_ROW_ADD_BIT_SELECT(BIST_DATA_INV_ROW_ADD_BIT_SEL), .MBISTPG_DATA_INV_COL_ADD_BIT_SELECT_EN(BIST_DATA_INV_COL_ADD_BIT_SELECT_EN), 
      .MBISTPG_DATA_INV_COL_ADD_BIT_SELECT(BIST_DATA_INV_COL_ADD_BIT_SEL), .MBISTPG_ALGO_MODE({
      BIST_ALGO_MODE1, BIST_ALGO_MODE0}), .MBISTPG_MEM_RST(ENABLE_MEM_RESET), .MBISTPG_REDUCED_ADDR_CNT_EN(REDUCED_ADDRESS_COUNT), 
      .MEM_BYPASS_EN(memory_bypass_to_en), .MCP_BOUNDING_EN(mcp_bounding_to_en), 
      .MEM0_BIST_COLLAR_SO(BIST_SO), .MEM1_BIST_COLLAR_SO(BIST_SO_ts1), .FL_CNT_MODE({
      FL_CNT_MODE1, FL_CNT_MODE0}), .MBISTPG_BIRA_EN(BIRA_EN), .CHECK_REPAIR_NEEDED(CHECK_REPAIR_NEEDED), 
      .BIST_COLLAR_GO({BIST_GO_ts1, BIST_GO}), .MBISTPG_DIAG_EN(BIST_DIAG_EN), 
      .BIST_CLK(gclk), .BIST_SI(toBist[0]), .BIST_HOLD(BIST_HOLD), .BIST_SETUP2(BIST_SETUP2), 
      .BIST_SETUP({BIST_SETUP1_clk, BIST_SETUP0}), .MBISTPG_TESTDATA_SELECT(BIST_SELECT_TEST_DATA), 
      .TCK(to_controllers_tck), .TCK_RETIME(to_controllers_tck_retime), .MBISTPG_EN(bistEn[0]), 
      .MBISTPG_ASYNC_RESETN(BIST_ASYNC_RESET_clk), .LV_TM(ltest_to_en_ts1), .MBISTPG_MEM_ARRAY_DUMP_MODE(MEM_ARRAY_DUMP_MODE), 
      .BIST_CLEAR_BIRA(BIST_CLEAR_BIRA), .MBISTPG_RESET_REG_SETUP2(MBISTPG_RESET_REG_SETUP2), 
      .BIST_COL_ADD(BIST_COL_ADD), .BIST_ROW_ADD(BIST_ROW_ADD[4:0]), .BIST_BANK_ADD(BIST_BANK_ADD), 
      .BIST_WRITE_DATA(BIST_WRITE_DATA[7:0]), .BIST_EXPECT_DATA(BIST_EXPECT_DATA[7:0]), 
      .BIST_SHIFT_COLLAR(BIST_SHIFT_COLLAR), .BIST_TESTDATA_SELECT_TO_COLLAR(BIST_TESTDATA_SELECT_TO_COLLAR), 
      .MEM0_BIST_COLLAR_SI(MEM0_BIST_COLLAR_SI), .MEM1_BIST_COLLAR_SI(MEM1_BIST_COLLAR_SI), 
      .BIST_COLLAR_SETUP(BIST_COLLAR_SETUP), .BIST_COLLAR_OPSET_SELECT(BIST_COLLAR_OPSET_SELECT), 
      .BIST_COLLAR_HOLD(BIST_COLLAR_HOLD), .FREEZE_STOP_ERROR(FREEZE_STOP_ERROR), 
      .ERROR_CNT_ZERO(ERROR_CNT_ZERO), .BIST_COLLAR_DIAG_EN(BIST_COLLAR_DIAG_EN), 
      .BIST_COLLAR_BIRA_EN(BIST_COLLAR_BIRA_EN), .BIST_CLEAR_DEFAULT(BIST_CLEAR_DEFAULT), 
      .BIST_CLEAR(BIST_CLEAR), .MBISTPG_SO(MBISTPG_SO), .PriorityColumn(PriorityColumn), 
      .BIST_CONREAD_ROWADDRESS(BIST_CONREAD_ROWADDRESS), .BIST_CONREAD_COLUMNADDRESS(BIST_CONREAD_COLUMNADDRESS), 
      .BIST_CONREAD_ENABLE(BIST_CONREAD_ENABLE), .BIST_CONWRITE_ROWADDRESS(BIST_CONWRITE_ROWADDRESS), 
      .BIST_CONWRITE_ENABLE(BIST_CONWRITE_ENABLE), .BIST_READENABLE(BIST_READENABLE), 
      .BIST_WRITEENABLE(BIST_WRITEENABLE), .BIST_SHADOW_READENABLE(BIST_SHADOW_READENABLE), 
      .BIST_SHADOW_READADDRESS(BIST_SHADOW_READADDRESS), .BIST_CMP(BIST_CMP), .BIST_COLLAR_EN0(BIST_COLLAR_EN0), 
      .BIST_RUN_TO_COLLAR0(BIST_RUN_TO_COLLAR0), .BIST_COLLAR_EN1(BIST_COLLAR_EN1), 
      .BIST_RUN_TO_COLLAR1(BIST_RUN_TO_COLLAR1), .MBISTPG_GO(MBISTPG_GO), .MBISTPG_STABLE(MBISTPG_STABLE), 
      .MBISTPG_DONE(MBISTPG_DONE), .BIST_ON_TO_COLLAR(BIST_ON_TO_COLLAR), .BIST_SHIFT_BIRA_COLLAR(BIST_SHIFT_BIRA_COLLAR), 
      .GO_ID_REG_SEL(GO_ID_REG_SEL), .ALGO_SEL_REG(ALGO_SEL_REG), .fscan_clkungate(fscan_clkungate)
  );

  hlp_port4_apr_rtl_tessent_mbist_RF_c2_controller hlp_port4_apr_rtl_tessent_mbist_RF_c2_controller_inst(
      .MBIST_RA_PRSRV_FUSE_VAL(PRESERVE_FUSE_REGISTER), .MBISTPG_ALGO_SEL({
      BIST_ALGO_SEL_ts6, BIST_ALGO_SEL_ts5, BIST_ALGO_SEL_ts4, 
      BIST_ALGO_SEL_ts3, BIST_ALGO_SEL_ts2, BIST_ALGO_SEL_ts1, BIST_ALGO_SEL}), .MBISTPG_SELECT_COMMON_ALGO(BIST_SELECT_COMMON_ALGO), 
      .MBISTPG_OPSET_SELECT(BIST_OPSET_SEL), .MBISTPG_SELECT_COMMON_OPSET(BIST_SELECT_COMMON_OPSET), 
      .MBISTPG_DATA_INV_ROW_ADD_BIT_SELECT_EN(BIST_DATA_INV_ROW_ADD_BIT_SELECT_EN), 
      .MBISTPG_DATA_INV_ROW_ADD_BIT_SELECT(BIST_DATA_INV_ROW_ADD_BIT_SEL), .MBISTPG_ALGO_MODE({
      BIST_ALGO_MODE1, BIST_ALGO_MODE0}), .MBISTPG_MEM_RST(ENABLE_MEM_RESET), .MBISTPG_REDUCED_ADDR_CNT_EN(REDUCED_ADDRESS_COUNT), 
      .MEM_BYPASS_EN(memory_bypass_to_en), .MCP_BOUNDING_EN(mcp_bounding_to_en), 
      .MEM0_BIST_COLLAR_SO(BIST_SO_ts2), .FL_CNT_MODE({FL_CNT_MODE1, 
      FL_CNT_MODE0}), .MBISTPG_BIRA_EN(BIRA_EN), .CHECK_REPAIR_NEEDED(CHECK_REPAIR_NEEDED), 
      .BIST_COLLAR_GO(BIST_GO_ts2), .MBISTPG_DIAG_EN(BIST_DIAG_EN), .BIST_CLK(gclk), 
      .BIST_SI(toBist[1]), .BIST_HOLD(BIST_HOLD), .BIST_SETUP2(BIST_SETUP2), .BIST_SETUP({
      BIST_SETUP1_clk, BIST_SETUP0}), .MBISTPG_TESTDATA_SELECT(BIST_SELECT_TEST_DATA), 
      .TCK(to_controllers_tck), .TCK_RETIME(to_controllers_tck_retime), .MBISTPG_EN(bistEn[1]), 
      .MBISTPG_ASYNC_RESETN(BIST_ASYNC_RESET_clk), .LV_TM(ltest_to_en_ts1), .MBISTPG_MEM_ARRAY_DUMP_MODE(MEM_ARRAY_DUMP_MODE), 
      .BIST_CLEAR_BIRA(BIST_CLEAR_BIRA_ts1), .MBISTPG_RESET_REG_SETUP2(MBISTPG_RESET_REG_SETUP2_ts1), 
      .BIST_ROW_ADD(BIST_ROW_ADD_ts1), .BIST_BANK_ADD(BIST_BANK_ADD_ts1), .BIST_WRITE_DATA(BIST_WRITE_DATA_ts1), 
      .BIST_EXPECT_DATA(BIST_EXPECT_DATA_ts1), .BIST_SHIFT_COLLAR(BIST_SHIFT_COLLAR_ts1), 
      .BIST_TESTDATA_SELECT_TO_COLLAR(BIST_TESTDATA_SELECT_TO_COLLAR_ts1), .MEM0_BIST_COLLAR_SI(MEM0_BIST_COLLAR_SI_ts1), 
      .BIST_COLLAR_SETUP(BIST_COLLAR_SETUP_ts1), .BIST_COLLAR_OPSET_SELECT(BIST_COLLAR_OPSET_SELECT_ts1), 
      .BIST_COLLAR_HOLD(BIST_COLLAR_HOLD_ts1), .FREEZE_STOP_ERROR(FREEZE_STOP_ERROR_ts1), 
      .ERROR_CNT_ZERO(ERROR_CNT_ZERO_ts1), .BIST_COLLAR_DIAG_EN(BIST_COLLAR_DIAG_EN_ts1), 
      .BIST_COLLAR_BIRA_EN(BIST_COLLAR_BIRA_EN_ts1), .BIST_CLEAR_DEFAULT(BIST_CLEAR_DEFAULT_ts1), 
      .BIST_CLEAR(BIST_CLEAR_ts1), .MBISTPG_SO(MBISTPG_SO_ts1), .BIST_CONREAD_ROWADDRESS(BIST_CONREAD_ROWADDRESS_ts1), 
      .BIST_CONREAD_COLUMNADDRESS(BIST_CONREAD_COLUMNADDRESS_ts1), .BIST_CONREAD_ENABLE(BIST_CONREAD_ENABLE_ts1), 
      .BIST_CONWRITE_ROWADDRESS(BIST_CONWRITE_ROWADDRESS_ts1), .BIST_CONWRITE_ENABLE(BIST_CONWRITE_ENABLE_ts1), 
      .BIST_READENABLE(BIST_READENABLE_ts1), .BIST_WRITEENABLE(BIST_WRITEENABLE_ts1), 
      .BIST_SHADOW_READENABLE(BIST_SHADOW_READENABLE_ts1), .BIST_SHADOW_READADDRESS(BIST_SHADOW_READADDRESS_ts1), 
      .BIST_CMP(BIST_CMP_ts1), .BIST_COLLAR_EN0(BIST_COLLAR_EN0_ts1), .BIST_RUN_TO_COLLAR0(BIST_RUN_TO_COLLAR0_ts1), 
      .BIST_TEST_PORT(BIST_TEST_PORT), .MBISTPG_GO(MBISTPG_GO_ts1), .MBISTPG_STABLE(MBISTPG_STABLE_ts1), 
      .MBISTPG_DONE(MBISTPG_DONE_ts1), .BIST_ON_TO_COLLAR(BIST_ON_TO_COLLAR_ts1), 
      .BIST_SHIFT_BIRA_COLLAR(BIST_SHIFT_BIRA_COLLAR_ts1), .GO_ID_REG_SEL(GO_ID_REG_SEL_ts1), 
      .ALGO_SEL_REG(ALGO_SEL_REG_ts1), .fscan_clkungate(fscan_clkungate)
  );

  hlp_port4_apr_rtl_tessent_mbist_RF_c3_controller hlp_port4_apr_rtl_tessent_mbist_RF_c3_controller_inst(
      .MBIST_RA_PRSRV_FUSE_VAL(PRESERVE_FUSE_REGISTER), .MBISTPG_ALGO_SEL({
      BIST_ALGO_SEL_ts6, BIST_ALGO_SEL_ts5, BIST_ALGO_SEL_ts4, 
      BIST_ALGO_SEL_ts3, BIST_ALGO_SEL_ts2, BIST_ALGO_SEL_ts1, BIST_ALGO_SEL}), .MBISTPG_SELECT_COMMON_ALGO(BIST_SELECT_COMMON_ALGO), 
      .MBISTPG_OPSET_SELECT(BIST_OPSET_SEL), .MBISTPG_SELECT_COMMON_OPSET(BIST_SELECT_COMMON_OPSET), 
      .MBISTPG_DATA_INV_ROW_ADD_BIT_SELECT_EN(BIST_DATA_INV_ROW_ADD_BIT_SELECT_EN), 
      .MBISTPG_DATA_INV_ROW_ADD_BIT_SELECT(BIST_DATA_INV_ROW_ADD_BIT_SEL), .MBISTPG_ALGO_MODE({
      BIST_ALGO_MODE1, BIST_ALGO_MODE0}), .MBISTPG_MEM_RST(ENABLE_MEM_RESET), .MBISTPG_REDUCED_ADDR_CNT_EN(REDUCED_ADDRESS_COUNT), 
      .MEM_BYPASS_EN(memory_bypass_to_en), .MCP_BOUNDING_EN(mcp_bounding_to_en), 
      .MEM0_BIST_COLLAR_SO(BIST_SO_ts5), .MEM1_BIST_COLLAR_SO(BIST_SO_ts24), .FL_CNT_MODE({
      FL_CNT_MODE1, FL_CNT_MODE0}), .MBISTPG_BIRA_EN(BIRA_EN), .CHECK_REPAIR_NEEDED(CHECK_REPAIR_NEEDED), 
      .BIST_COLLAR_GO({BIST_GO_ts24, BIST_GO_ts5}), .MBISTPG_DIAG_EN(BIST_DIAG_EN), 
      .BIST_CLK(switch_clk_ts1), .BIST_SI(toBist[2]), .BIST_HOLD(BIST_HOLD), .BIST_SETUP2(BIST_SETUP2), 
      .BIST_SETUP({BIST_SETUP1_switch_clk, BIST_SETUP0}), .MBISTPG_TESTDATA_SELECT(BIST_SELECT_TEST_DATA), 
      .TCK(to_controllers_tck), .TCK_RETIME(to_controllers_tck_retime), .MBISTPG_EN(bistEn[2]), 
      .MBISTPG_ASYNC_RESETN(BIST_ASYNC_RESET_switch_clk), .LV_TM(ltest_to_en_ts1), 
      .MBISTPG_MEM_ARRAY_DUMP_MODE(MEM_ARRAY_DUMP_MODE), .BIST_CLEAR_BIRA(BIST_CLEAR_BIRA_ts2), 
      .MBISTPG_RESET_REG_SETUP2(MBISTPG_RESET_REG_SETUP2_ts2), .BIST_ROW_ADD(BIST_ROW_ADD_ts2[4:0]), 
      .BIST_WRITE_DATA(BIST_WRITE_DATA_ts2[7:0]), .BIST_EXPECT_DATA(BIST_EXPECT_DATA_ts2[7:0]), 
      .BIST_SHIFT_COLLAR(BIST_SHIFT_COLLAR_ts2), .BIST_TESTDATA_SELECT_TO_COLLAR(BIST_TESTDATA_SELECT_TO_COLLAR_ts2), 
      .MEM0_BIST_COLLAR_SI(MEM0_BIST_COLLAR_SI_ts2), .MEM1_BIST_COLLAR_SI(MEM1_BIST_COLLAR_SI_ts1), 
      .BIST_COLLAR_SETUP(BIST_COLLAR_SETUP_ts2), .BIST_COLLAR_OPSET_SELECT(BIST_COLLAR_OPSET_SELECT_ts2), 
      .BIST_COLLAR_HOLD(BIST_COLLAR_HOLD_ts2), .FREEZE_STOP_ERROR(FREEZE_STOP_ERROR_ts2), 
      .ERROR_CNT_ZERO(ERROR_CNT_ZERO_ts2), .BIST_COLLAR_DIAG_EN(BIST_COLLAR_DIAG_EN_ts2), 
      .BIST_COLLAR_BIRA_EN(BIST_COLLAR_BIRA_EN_ts2), .BIST_CLEAR_DEFAULT(BIST_CLEAR_DEFAULT_ts2), 
      .BIST_CLEAR(BIST_CLEAR_ts2), .MBISTPG_SO(MBISTPG_SO_ts2), .PriorityColumn(PriorityColumn_ts1), 
      .BIST_CONREAD_ROWADDRESS(BIST_CONREAD_ROWADDRESS_ts2), .BIST_CONREAD_COLUMNADDRESS(BIST_CONREAD_COLUMNADDRESS_ts2), 
      .BIST_CONREAD_ENABLE(BIST_CONREAD_ENABLE_ts2), .BIST_CONWRITE_ROWADDRESS(BIST_CONWRITE_ROWADDRESS_ts2), 
      .BIST_CONWRITE_ENABLE(BIST_CONWRITE_ENABLE_ts2), .BIST_READENABLE(BIST_READENABLE_ts2), 
      .BIST_WRITEENABLE(BIST_WRITEENABLE_ts2), .BIST_SHADOW_READENABLE(BIST_SHADOW_READENABLE_ts2), 
      .BIST_SHADOW_READADDRESS(BIST_SHADOW_READADDRESS_ts2), .BIST_CMP(BIST_CMP_ts2), 
      .BIST_COLLAR_EN0(BIST_COLLAR_EN0_ts2), .BIST_RUN_TO_COLLAR0(BIST_RUN_TO_COLLAR0_ts2), 
      .BIST_COLLAR_EN1(BIST_COLLAR_EN1_ts1), .BIST_RUN_TO_COLLAR1(BIST_RUN_TO_COLLAR1_ts1), 
      .MBISTPG_GO(MBISTPG_GO_ts2), .MBISTPG_STABLE(MBISTPG_STABLE_ts2), .MBISTPG_DONE(MBISTPG_DONE_ts2), 
      .BIST_ON_TO_COLLAR(BIST_ON_TO_COLLAR_ts2), .BIST_SHIFT_BIRA_COLLAR(BIST_SHIFT_BIRA_COLLAR_ts2), 
      .GO_ID_REG_SEL(GO_ID_REG_SEL_ts2), .ALGO_SEL_REG(ALGO_SEL_REG_ts2), .fscan_clkungate(fscan_clkungate)
  );

  hlp_port4_apr_rtl_tessent_mbist_RF_c4_controller hlp_port4_apr_rtl_tessent_mbist_RF_c4_controller_inst(
      .MBIST_RA_PRSRV_FUSE_VAL(PRESERVE_FUSE_REGISTER), .MBISTPG_ALGO_SEL({
      BIST_ALGO_SEL_ts6, BIST_ALGO_SEL_ts5, BIST_ALGO_SEL_ts4, 
      BIST_ALGO_SEL_ts3, BIST_ALGO_SEL_ts2, BIST_ALGO_SEL_ts1, BIST_ALGO_SEL}), .MBISTPG_SELECT_COMMON_ALGO(BIST_SELECT_COMMON_ALGO), 
      .MBISTPG_OPSET_SELECT(BIST_OPSET_SEL), .MBISTPG_SELECT_COMMON_OPSET(BIST_SELECT_COMMON_OPSET), 
      .MBISTPG_DATA_INV_ROW_ADD_BIT_SELECT_EN(BIST_DATA_INV_ROW_ADD_BIT_SELECT_EN), 
      .MBISTPG_DATA_INV_ROW_ADD_BIT_SELECT(BIST_DATA_INV_ROW_ADD_BIT_SEL), .MBISTPG_DATA_INV_COL_ADD_BIT_SELECT_EN(BIST_DATA_INV_COL_ADD_BIT_SELECT_EN), 
      .MBISTPG_DATA_INV_COL_ADD_BIT_SELECT(BIST_DATA_INV_COL_ADD_BIT_SEL), .MBISTPG_ALGO_MODE({
      BIST_ALGO_MODE1, BIST_ALGO_MODE0}), .MBISTPG_MEM_RST(ENABLE_MEM_RESET), .MBISTPG_REDUCED_ADDR_CNT_EN(REDUCED_ADDRESS_COUNT), 
      .MEM_BYPASS_EN(memory_bypass_to_en), .MCP_BOUNDING_EN(mcp_bounding_to_en), 
      .MEM0_BIST_COLLAR_SO(BIST_SO_ts6), .MEM1_BIST_COLLAR_SO(BIST_SO_ts7), .MEM2_BIST_COLLAR_SO(BIST_SO_ts8), 
      .MEM3_BIST_COLLAR_SO(BIST_SO_ts9), .MEM4_BIST_COLLAR_SO(BIST_SO_ts10), .MEM5_BIST_COLLAR_SO(BIST_SO_ts11), 
      .MEM6_BIST_COLLAR_SO(BIST_SO_ts12), .MEM7_BIST_COLLAR_SO(BIST_SO_ts13), .MEM8_BIST_COLLAR_SO(BIST_SO_ts14), 
      .MEM9_BIST_COLLAR_SO(BIST_SO_ts15), .FL_CNT_MODE({FL_CNT_MODE1, 
      FL_CNT_MODE0}), .MBISTPG_BIRA_EN(BIRA_EN), .CHECK_REPAIR_NEEDED(CHECK_REPAIR_NEEDED), 
      .BIST_COLLAR_GO({BIST_GO_ts15, BIST_GO_ts14, BIST_GO_ts13, 
      BIST_GO_ts12, BIST_GO_ts11, BIST_GO_ts10, BIST_GO_ts9, BIST_GO_ts8, 
      BIST_GO_ts7, BIST_GO_ts6}), .MBISTPG_DIAG_EN(BIST_DIAG_EN), .BIST_CLK(switch_clk_ts1), 
      .BIST_SI(toBist[3]), .BIST_HOLD(BIST_HOLD), .BIST_SETUP2(BIST_SETUP2), .BIST_SETUP({
      BIST_SETUP1_switch_clk, BIST_SETUP0}), .MBISTPG_TESTDATA_SELECT(BIST_SELECT_TEST_DATA), 
      .TCK(to_controllers_tck), .TCK_RETIME(to_controllers_tck_retime), .MBISTPG_EN(bistEn[3]), 
      .MBISTPG_ASYNC_RESETN(BIST_ASYNC_RESET_switch_clk), .LV_TM(ltest_to_en_ts1), 
      .MBISTPG_MEM_ARRAY_DUMP_MODE(MEM_ARRAY_DUMP_MODE), .BIST_CLEAR_BIRA(BIST_CLEAR_BIRA_ts3), 
      .MBISTPG_RESET_REG_SETUP2(MBISTPG_RESET_REG_SETUP2_ts3), .BIST_COL_ADD(BIST_COL_ADD_ts1), 
      .BIST_ROW_ADD(BIST_ROW_ADD_ts3[4:0]), .BIST_WRITE_DATA(BIST_WRITE_DATA_ts3[7:0]), 
      .BIST_EXPECT_DATA(BIST_EXPECT_DATA_ts3[7:0]), .BIST_SHIFT_COLLAR(BIST_SHIFT_COLLAR_ts3), 
      .BIST_TESTDATA_SELECT_TO_COLLAR(BIST_TESTDATA_SELECT_TO_COLLAR_ts3), .MEM0_BIST_COLLAR_SI(MEM0_BIST_COLLAR_SI_ts3), 
      .MEM1_BIST_COLLAR_SI(MEM1_BIST_COLLAR_SI_ts2), .MEM2_BIST_COLLAR_SI(MEM2_BIST_COLLAR_SI), 
      .MEM3_BIST_COLLAR_SI(MEM3_BIST_COLLAR_SI), .MEM4_BIST_COLLAR_SI(MEM4_BIST_COLLAR_SI), 
      .MEM5_BIST_COLLAR_SI(MEM5_BIST_COLLAR_SI), .MEM6_BIST_COLLAR_SI(MEM6_BIST_COLLAR_SI), 
      .MEM7_BIST_COLLAR_SI(MEM7_BIST_COLLAR_SI), .MEM8_BIST_COLLAR_SI(MEM8_BIST_COLLAR_SI), 
      .MEM9_BIST_COLLAR_SI(MEM9_BIST_COLLAR_SI), .BIST_COLLAR_SETUP(BIST_COLLAR_SETUP_ts3), 
      .BIST_COLLAR_OPSET_SELECT(BIST_COLLAR_OPSET_SELECT_ts3), .BIST_COLLAR_HOLD(BIST_COLLAR_HOLD_ts3), 
      .FREEZE_STOP_ERROR(FREEZE_STOP_ERROR_ts3), .ERROR_CNT_ZERO(ERROR_CNT_ZERO_ts3), 
      .BIST_COLLAR_DIAG_EN(BIST_COLLAR_DIAG_EN_ts3), .BIST_COLLAR_BIRA_EN(BIST_COLLAR_BIRA_EN_ts3), 
      .BIST_CLEAR_DEFAULT(BIST_CLEAR_DEFAULT_ts3), .BIST_CLEAR(BIST_CLEAR_ts3), 
      .MBISTPG_SO(MBISTPG_SO_ts3), .PriorityColumn(PriorityColumn_ts2), .BIST_CONREAD_ROWADDRESS(BIST_CONREAD_ROWADDRESS_ts3), 
      .BIST_CONREAD_COLUMNADDRESS(BIST_CONREAD_COLUMNADDRESS_ts3), .BIST_CONREAD_ENABLE(BIST_CONREAD_ENABLE_ts3), 
      .BIST_CONWRITE_ROWADDRESS(BIST_CONWRITE_ROWADDRESS_ts3), .BIST_CONWRITE_ENABLE(BIST_CONWRITE_ENABLE_ts3), 
      .BIST_READENABLE(BIST_READENABLE_ts3), .BIST_WRITEENABLE(BIST_WRITEENABLE_ts3), 
      .BIST_SHADOW_READENABLE(BIST_SHADOW_READENABLE_ts3), .BIST_SHADOW_READADDRESS(BIST_SHADOW_READADDRESS_ts3), 
      .BIST_CMP(BIST_CMP_ts3), .BIST_COLLAR_EN0(BIST_COLLAR_EN0_ts3), .BIST_RUN_TO_COLLAR0(BIST_RUN_TO_COLLAR0_ts3), 
      .BIST_COLLAR_EN1(BIST_COLLAR_EN1_ts2), .BIST_RUN_TO_COLLAR1(BIST_RUN_TO_COLLAR1_ts2), 
      .BIST_COLLAR_EN2(BIST_COLLAR_EN2), .BIST_RUN_TO_COLLAR2(BIST_RUN_TO_COLLAR2), 
      .BIST_COLLAR_EN3(BIST_COLLAR_EN3), .BIST_RUN_TO_COLLAR3(BIST_RUN_TO_COLLAR3), 
      .BIST_COLLAR_EN4(BIST_COLLAR_EN4), .BIST_RUN_TO_COLLAR4(BIST_RUN_TO_COLLAR4), 
      .BIST_COLLAR_EN5(BIST_COLLAR_EN5), .BIST_RUN_TO_COLLAR5(BIST_RUN_TO_COLLAR5), 
      .BIST_COLLAR_EN6(BIST_COLLAR_EN6), .BIST_RUN_TO_COLLAR6(BIST_RUN_TO_COLLAR6), 
      .BIST_COLLAR_EN7(BIST_COLLAR_EN7), .BIST_RUN_TO_COLLAR7(BIST_RUN_TO_COLLAR7), 
      .BIST_COLLAR_EN8(BIST_COLLAR_EN8), .BIST_RUN_TO_COLLAR8(BIST_RUN_TO_COLLAR8), 
      .BIST_COLLAR_EN9(BIST_COLLAR_EN9), .BIST_RUN_TO_COLLAR9(BIST_RUN_TO_COLLAR9), 
      .MBISTPG_GO(MBISTPG_GO_ts3), .MBISTPG_STABLE(MBISTPG_STABLE_ts3), .MBISTPG_DONE(MBISTPG_DONE_ts3), 
      .BIST_ON_TO_COLLAR(BIST_ON_TO_COLLAR_ts3), .BIST_SHIFT_BIRA_COLLAR(BIST_SHIFT_BIRA_COLLAR_ts3), 
      .GO_ID_REG_SEL(GO_ID_REG_SEL_ts3), .ALGO_SEL_REG(ALGO_SEL_REG_ts3), .fscan_clkungate(fscan_clkungate)
  );

  hlp_port4_apr_rtl_tessent_mbist_SRAM_c5_controller hlp_port4_apr_rtl_tessent_mbist_SRAM_c5_controller_inst(
      .MBIST_RA_PRSRV_FUSE_VAL(PRESERVE_FUSE_REGISTER), .MBISTPG_ALGO_SEL({
      BIST_ALGO_SEL_ts6, BIST_ALGO_SEL_ts5, BIST_ALGO_SEL_ts4, 
      BIST_ALGO_SEL_ts3, BIST_ALGO_SEL_ts2, BIST_ALGO_SEL_ts1, BIST_ALGO_SEL}), .MBISTPG_SELECT_COMMON_ALGO(BIST_SELECT_COMMON_ALGO), 
      .MBISTPG_OPSET_SELECT(BIST_OPSET_SEL), .MBISTPG_SELECT_COMMON_OPSET(BIST_SELECT_COMMON_OPSET), 
      .MBISTPG_DATA_INV_ROW_ADD_BIT_SELECT_EN(BIST_DATA_INV_ROW_ADD_BIT_SELECT_EN), 
      .MBISTPG_DATA_INV_ROW_ADD_BIT_SELECT(BIST_DATA_INV_ROW_ADD_BIT_SEL), .MBISTPG_DATA_INV_COL_ADD_BIT_SELECT_EN(BIST_DATA_INV_COL_ADD_BIT_SELECT_EN), 
      .MBISTPG_DATA_INV_COL_ADD_BIT_SELECT(BIST_DATA_INV_COL_ADD_BIT_SEL), .MBISTPG_ALGO_MODE({
      BIST_ALGO_MODE1, BIST_ALGO_MODE0}), .MBISTPG_MEM_RST(ENABLE_MEM_RESET), .MBISTPG_REDUCED_ADDR_CNT_EN(REDUCED_ADDRESS_COUNT), 
      .MEM_BYPASS_EN(memory_bypass_to_en), .MCP_BOUNDING_EN(mcp_bounding_to_en), 
      .MEM0_BIST_COLLAR_SO(BIST_SO_ts3), .MEM1_BIST_COLLAR_SO(BIST_SO_ts22), .MEM2_BIST_COLLAR_SO(BIST_SO_ts4), 
      .MEM3_BIST_COLLAR_SO(BIST_SO_ts23), .MEM4_BIST_COLLAR_SO(BIST_SO_ts16), .MEM5_BIST_COLLAR_SO(BIST_SO_ts17), 
      .MEM6_BIST_COLLAR_SO(BIST_SO_ts18), .MEM7_BIST_COLLAR_SO(BIST_SO_ts19), .MEM8_BIST_COLLAR_SO(BIST_SO_ts20), 
      .MEM9_BIST_COLLAR_SO(BIST_SO_ts21), .MEM10_BIST_COLLAR_SO(BIST_SO_ts25), 
      .MEM11_BIST_COLLAR_SO(BIST_SO_ts26), .MEM12_BIST_COLLAR_SO(BIST_SO_ts27), 
      .MEM13_BIST_COLLAR_SO(BIST_SO_ts28), .MEM14_BIST_COLLAR_SO(BIST_SO_ts29), 
      .MEM15_BIST_COLLAR_SO(BIST_SO_ts30), .MEM16_BIST_COLLAR_SO(BIST_SO_ts31), 
      .MEM17_BIST_COLLAR_SO(BIST_SO_ts32), .FL_CNT_MODE({FL_CNT_MODE1, 
      FL_CNT_MODE0}), .MBISTPG_BIRA_EN(BIRA_EN), .CHECK_REPAIR_NEEDED(CHECK_REPAIR_NEEDED), 
      .BIST_COLLAR_GO({BIST_GO_ts32, BIST_GO_ts31, BIST_GO_ts30, 
      BIST_GO_ts29, BIST_GO_ts28, BIST_GO_ts27, BIST_GO_ts26, BIST_GO_ts25, 
      BIST_GO_ts21, BIST_GO_ts20, BIST_GO_ts19, BIST_GO_ts18, BIST_GO_ts17, 
      BIST_GO_ts16, BIST_GO_ts23, BIST_GO_ts4, BIST_GO_ts22, BIST_GO_ts3}), .MBISTPG_DIAG_EN(BIST_DIAG_EN), 
      .BIST_CLK(gclk), .BIST_SI(toBist[4]), .BIST_HOLD(BIST_HOLD), .BIST_SETUP2(BIST_SETUP2), 
      .BIST_SETUP({BIST_SETUP1_clk, BIST_SETUP0}), .MBISTPG_TESTDATA_SELECT(BIST_SELECT_TEST_DATA), 
      .TCK(to_controllers_tck), .TCK_RETIME(to_controllers_tck_retime), .MBISTPG_EN(bistEn[4]), 
      .MBISTPG_ASYNC_RESETN(BIST_ASYNC_RESET_clk), .LV_TM(ltest_to_en_ts1), .MBISTPG_MEM_ARRAY_DUMP_MODE(MEM_ARRAY_DUMP_MODE), 
      .BIST_CLEAR_BIRA(BIST_CLEAR_BIRA_ts4), .MBISTPG_RESET_REG_SETUP2(MBISTPG_RESET_REG_SETUP2_ts4), 
      .BIST_COL_ADD(BIST_COL_ADD_ts2[1:0]), .BIST_ROW_ADD(BIST_ROW_ADD_ts4[7:0]), 
      .BIST_BANK_ADD(BIST_BANK_ADD_ts2), .BIST_WRITE_DATA(BIST_WRITE_DATA_ts4[31:0]), 
      .BIST_EXPECT_DATA(BIST_EXPECT_DATA_ts4[31:0]), .BIST_SHIFT_COLLAR(BIST_SHIFT_COLLAR_ts4), 
      .BIST_TESTDATA_SELECT_TO_COLLAR(BIST_TESTDATA_SELECT_TO_COLLAR_ts4), .MEM0_BIST_COLLAR_SI(MEM0_BIST_COLLAR_SI_ts4), 
      .MEM1_BIST_COLLAR_SI(MEM1_BIST_COLLAR_SI_ts3), .MEM2_BIST_COLLAR_SI(MEM2_BIST_COLLAR_SI_ts1), 
      .MEM3_BIST_COLLAR_SI(MEM3_BIST_COLLAR_SI_ts1), .MEM4_BIST_COLLAR_SI(MEM4_BIST_COLLAR_SI_ts1), 
      .MEM5_BIST_COLLAR_SI(MEM5_BIST_COLLAR_SI_ts1), .MEM6_BIST_COLLAR_SI(MEM6_BIST_COLLAR_SI_ts1), 
      .MEM7_BIST_COLLAR_SI(MEM7_BIST_COLLAR_SI_ts1), .MEM8_BIST_COLLAR_SI(MEM8_BIST_COLLAR_SI_ts1), 
      .MEM9_BIST_COLLAR_SI(MEM9_BIST_COLLAR_SI_ts1), .MEM10_BIST_COLLAR_SI(MEM10_BIST_COLLAR_SI), 
      .MEM11_BIST_COLLAR_SI(MEM11_BIST_COLLAR_SI), .MEM12_BIST_COLLAR_SI(MEM12_BIST_COLLAR_SI), 
      .MEM13_BIST_COLLAR_SI(MEM13_BIST_COLLAR_SI), .MEM14_BIST_COLLAR_SI(MEM14_BIST_COLLAR_SI), 
      .MEM15_BIST_COLLAR_SI(MEM15_BIST_COLLAR_SI), .MEM16_BIST_COLLAR_SI(MEM16_BIST_COLLAR_SI), 
      .MEM17_BIST_COLLAR_SI(MEM17_BIST_COLLAR_SI), .BIST_COLLAR_SETUP(BIST_COLLAR_SETUP_ts4), 
      .BIST_COLLAR_OPSET_SELECT(BIST_COLLAR_OPSET_SELECT_ts4), .BIST_COLLAR_HOLD(BIST_COLLAR_HOLD_ts4), 
      .FREEZE_STOP_ERROR(FREEZE_STOP_ERROR_ts4), .ERROR_CNT_ZERO(ERROR_CNT_ZERO_ts4), 
      .BIST_COLLAR_DIAG_EN(BIST_COLLAR_DIAG_EN_ts4), .BIST_COLLAR_BIRA_EN(BIST_COLLAR_BIRA_EN_ts4), 
      .BIST_CLEAR_DEFAULT(BIST_CLEAR_DEFAULT_ts4), .BIST_CLEAR(BIST_CLEAR_ts4), 
      .MBISTPG_SO(MBISTPG_SO_ts4), .PriorityColumn(PriorityColumn_ts3), .BIST_WRITEENABLE(BIST_WRITEENABLE_ts4), 
      .BIST_SELECT(BIST_SELECT), .BIST_CMP(BIST_CMP_ts4), .BIST_COLLAR_EN0(BIST_COLLAR_EN0_ts4), 
      .BIST_RUN_TO_COLLAR0(BIST_RUN_TO_COLLAR0_ts4), .BIST_COLLAR_EN1(BIST_COLLAR_EN1_ts3), 
      .BIST_RUN_TO_COLLAR1(BIST_RUN_TO_COLLAR1_ts3), .BIST_COLLAR_EN2(BIST_COLLAR_EN2_ts1), 
      .BIST_RUN_TO_COLLAR2(BIST_RUN_TO_COLLAR2_ts1), .BIST_COLLAR_EN3(BIST_COLLAR_EN3_ts1), 
      .BIST_RUN_TO_COLLAR3(BIST_RUN_TO_COLLAR3_ts1), .BIST_COLLAR_EN4(BIST_COLLAR_EN4_ts1), 
      .BIST_RUN_TO_COLLAR4(BIST_RUN_TO_COLLAR4_ts1), .BIST_COLLAR_EN5(BIST_COLLAR_EN5_ts1), 
      .BIST_RUN_TO_COLLAR5(BIST_RUN_TO_COLLAR5_ts1), .BIST_COLLAR_EN6(BIST_COLLAR_EN6_ts1), 
      .BIST_RUN_TO_COLLAR6(BIST_RUN_TO_COLLAR6_ts1), .BIST_COLLAR_EN7(BIST_COLLAR_EN7_ts1), 
      .BIST_RUN_TO_COLLAR7(BIST_RUN_TO_COLLAR7_ts1), .BIST_COLLAR_EN8(BIST_COLLAR_EN8_ts1), 
      .BIST_RUN_TO_COLLAR8(BIST_RUN_TO_COLLAR8_ts1), .BIST_COLLAR_EN9(BIST_COLLAR_EN9_ts1), 
      .BIST_RUN_TO_COLLAR9(BIST_RUN_TO_COLLAR9_ts1), .BIST_COLLAR_EN10(BIST_COLLAR_EN10), 
      .BIST_RUN_TO_COLLAR10(BIST_RUN_TO_COLLAR10), .BIST_COLLAR_EN11(BIST_COLLAR_EN11), 
      .BIST_RUN_TO_COLLAR11(BIST_RUN_TO_COLLAR11), .BIST_COLLAR_EN12(BIST_COLLAR_EN12), 
      .BIST_RUN_TO_COLLAR12(BIST_RUN_TO_COLLAR12), .BIST_COLLAR_EN13(BIST_COLLAR_EN13), 
      .BIST_RUN_TO_COLLAR13(BIST_RUN_TO_COLLAR13), .BIST_COLLAR_EN14(BIST_COLLAR_EN14), 
      .BIST_RUN_TO_COLLAR14(BIST_RUN_TO_COLLAR14), .BIST_COLLAR_EN15(BIST_COLLAR_EN15), 
      .BIST_RUN_TO_COLLAR15(BIST_RUN_TO_COLLAR15), .BIST_COLLAR_EN16(BIST_COLLAR_EN16), 
      .BIST_RUN_TO_COLLAR16(BIST_RUN_TO_COLLAR16), .BIST_COLLAR_EN17(BIST_COLLAR_EN17), 
      .BIST_RUN_TO_COLLAR17(BIST_RUN_TO_COLLAR17), .MBISTPG_GO(MBISTPG_GO_ts4), 
      .MBISTPG_STABLE(MBISTPG_STABLE_ts4), .MBISTPG_DONE(MBISTPG_DONE_ts4), .BIST_ON_TO_COLLAR(BIST_ON_TO_COLLAR_ts4), 
      .BIST_SHIFT_BIRA_COLLAR(BIST_SHIFT_BIRA_COLLAR_ts4), .GO_ID_REG_SEL(GO_ID_REG_SEL_ts4), 
      .ALGO_SEL_REG(ALGO_SEL_REG_ts4), .fscan_clkungate(fscan_clkungate)
  );

  TS_CLK_MUX tessent_persistent_cell_tck_mux_hlp_port4_apr_rtl_clk_inst(
      .ck0(clk), .ck1(ijtag_to_tck), .s(tck_select), .o(clk_ts1)
  );

  TS_CLK_MUX tessent_persistent_cell_tck_mux_hlp_port4_apr_rtl_switch_clk_inst(
      .ck0(switch_clk), .ck1(ijtag_to_tck), .s(tck_select), .o(switch_clk_ts1)
  );

  hlp_port4_apr_rtl_tessent_mbist_diagnosis_ready hlp_port4_apr_rtl_tessent_mbist_diagnosis_ready_inst(
      .ijtag_reset(ijtag_to_reset), .ijtag_sel(ijtag_to_sel), .ijtag_si(hlp_port4_apr_rtl_tessent_mbist_bap_inst_so), 
      .ijtag_ce(ijtag_to_ce), .ijtag_se(ijtag_to_se), .ijtag_ue(ijtag_to_ue), .ijtag_tck(ijtag_to_tck), 
      .ijtag_so(ijtag_so), .DiagnosisReady_ctl_in({MBISTPG_STABLE_ts4, 
      MBISTPG_STABLE_ts3, MBISTPG_STABLE_ts2, MBISTPG_STABLE_ts1, 
      MBISTPG_STABLE}), .DiagnosisReady_aux_in(1'b1), .StableBlock(mbist_diag_done)
  );

  assign bisr_so_pd_vinf_ts1 = bisr_si_pd_vinf;

  mbist_post_agg #(.NUM_OF_CNTRL(2)) post_aggregator(
      .post_complete({complete_ts1, complete}), .post_pass({pass_ts1, pass}), .post_busy({
      busy_ts1, busy}), .post_complete_agg(aary_post_complete), .post_pass_agg(aary_post_pass), 
      .post_busy_agg(aary_post_busy)
  );

  mbist_post_arrayinit_selection postArrayInitSelection(
      .post(fary_trigger_post), .arrayinit(1'b0), .arrayinit_done(1'b1), .trigger_post(trigger_post), 
      .trigger_array(trigger_array)
  );

  mbist_post_arrayinit_algo_selection #(.NUMBER_ALGO_BITS(7), .DEFAULT_POST_ALGO(7'b0000001), .FAILINJ_ALGO(7'b0000010), .DEFAULT_ARRAYINIT_ALGO(7'b0), .ALGO_SEL_WIDTH(6), .PADDING(2), .MAX_ALGO_OPCODE(5'b11111), .MAX_RF_ALGO_OPCODE(5'b01111)) algoSelection(
      .post_trigger(trigger_post), .arrayinit(trigger_array), .post_force_fail(fary_post_force_fail), 
      .mbistpg_algo_sel_i(fary_post_algo_select), .mbistpg_algo_sel_o(mbistpg_algo_sel_o[6:0]), 
      .mbistpg_select_common_algo_o(mbistpg_select_common_algo_o), .select_rf(select_rf), 
      .select_rom(), .select_sram(select_sram)
  );

  mbist_post_arrayinit_macro_parallel_bap parallel_bap_POST_macro_0(
      .reset(sync_reset_clk_o), .trigger(trigger_post), .BIST_CLK_IN(clk), .MBISTPG_DONE(sys_test_done_clk), 
      .MBISTPG_GO(sys_test_pass_clk), .busy(busy), .pass(pass), .complete(complete)
  );

  TS_SYNCHRONIZER sync_reset_clk(
      .clk(clk), .d(1'b1), .rst(Intel_reset_sync_polarity_clk_inverter_o1), .o(sync_reset_clk_o_ts1)
  );

  TS_MX sync_reset_clk_reset_bypass_mux(
      .a(fscan_byprst_b), .b(core_rst_b), .sa(fscan_rstbypen), .o(sync_reset_clk_reset_bypass_mux_o)
  );

  TS_INV Intel_reset_sync_polarity_clk_inverter(
      .a(sync_reset_clk_reset_bypass_mux_o), .o1(Intel_reset_sync_polarity_clk_inverter_o1)
  );

  TS_MX sync_reset_clk_reset_output_bypass_mux(
      .a(fscan_byprst_b), .b(sync_reset_clk_o_ts1), .sa(fscan_rstbypen), .o(sync_reset_clk_o)
  );

  mbist_post_arrayinit_macro_parallel_bap parallel_bap_POST_macro_1(
      .reset(sync_reset_switch_clk_o), .trigger(trigger_post), .BIST_CLK_IN(switch_clk), 
      .MBISTPG_DONE(sys_test_done_switch_clk), .MBISTPG_GO(sys_test_pass_switch_clk), 
      .busy(busy_ts1), .pass(pass_ts1), .complete(complete_ts1)
  );

  TS_SYNCHRONIZER sync_reset_switch_clk(
      .clk(switch_clk), .d(1'b1), .rst(Intel_reset_sync_polarity_switch_clk_inverter_o1), 
      .o(sync_reset_switch_clk_o_ts1)
  );

  TS_MX sync_reset_switch_clk_reset_bypass_mux(
      .a(fscan_byprst_b), .b(core_rst_b), .sa(fscan_rstbypen), .o(sync_reset_switch_clk_reset_bypass_mux_o)
  );

  TS_INV Intel_reset_sync_polarity_switch_clk_inverter(
      .a(sync_reset_switch_clk_reset_bypass_mux_o), .o1(Intel_reset_sync_polarity_switch_clk_inverter_o1)
  );

  TS_MX sync_reset_switch_clk_reset_output_bypass_mux(
      .a(fscan_byprst_b), .b(sync_reset_switch_clk_o_ts1), .sa(fscan_rstbypen), 
      .o(sync_reset_switch_clk_o)
  );
endmodule
