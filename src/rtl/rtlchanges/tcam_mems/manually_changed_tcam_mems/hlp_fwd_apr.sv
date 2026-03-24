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

// GENERATED CODE -- DO NOT EDIT

`include "hlp_fwd_mem.def"
module hlp_fwd_apr
(
input logic [$bits(hlp_pkg::imn_broadcast_t)-1:0] i_broadcast,
output logic fet_ack_b,
input logic fet_en_b,
output logic [8:0] avisa_unit_id_p1,
input  logic fdfx_jta_force_latch_mem_fuses,
input  logic fary_trigger_post,
output logic aary_post_complete,
output logic aary_post_pass,
/*AUTOINPUT*/
input clk_rscclk,
output mbist_diag_done,
input hlp_post_mux_ctrl,
input hlp_post_clkungate,
// Beginning of automatic inputs (from unused autoinst inputs)
input logic             DFTMASK,                // To u_fwd_apr_sram_mems of hlp_fwd_apr_sram_mems.v, ...
input logic             DFTSHIFTEN,             // To u_fwd_apr_sram_mems of hlp_fwd_apr_sram_mems.v, ...
input logic             DFT_AFD_RESET_B,        // To u_fwd_apr_sram_mems of hlp_fwd_apr_sram_mems.v, ...
input logic             DFT_ARRAY_FREEZE,       // To u_fwd_apr_sram_mems of hlp_fwd_apr_sram_mems.v, ...
input logic             clk,                    // To u_fwd_apr_sram_mems of hlp_fwd_apr_sram_mems.v, ...
input logic [6:0]       fary_ffuse_hd2prf_trim, // To u_fwd_apr_rf_mems of hlp_fwd_apr_rf_mems.v
input logic [16:0]      fary_ffuse_hdusplr_trim,// To u_fwd_apr_sram_mems of hlp_fwd_apr_sram_mems.v
input logic [16:0]      fary_ffuse_hduspsr_trim,// To u_fwd_apr_sram_mems of hlp_fwd_apr_sram_mems.v
input logic [1:0]       fary_ffuse_rf_sleep,    // To u_fwd_apr_rf_mems of hlp_fwd_apr_rf_mems.v
input logic [1:0]       fary_ffuse_sram_sleep,  // To u_fwd_apr_sram_mems of hlp_fwd_apr_sram_mems.v
input logic             fary_ffuse_tcam_sleep,  // To u_fwd_apr_tcam_mems of hlp_fwd_apr_tcam_mems.v
input logic [15:0]      fary_ffuse_tune_tcam,   // To u_fwd_apr_tcam_mems of hlp_fwd_apr_tcam_mems.v
input logic             fary_output_reset,      // To u_fwd_apr_sram_mems of hlp_fwd_apr_sram_mems.v, ...
input logic             fscan_byprst_b,         // To u_fwd_apr_func_logic of hlp_fwd_apr_func_logic.v
input logic [hlp_dfx_pkg::FWD_NUM_CLKGENCTRL-1:0] fscan_clkgenctrl,// To u_fwd_apr_func_logic of hlp_fwd_apr_func_logic.v
input logic [hlp_dfx_pkg::FWD_NUM_CLKGENCTRLEN-1:0] fscan_clkgenctrlen,// To u_fwd_apr_func_logic of hlp_fwd_apr_func_logic.v
input logic             fscan_clkungate,        // To u_fwd_apr_sram_mems of hlp_fwd_apr_sram_mems.v, ...
input logic             fscan_clkungate_syn,    // To u_fwd_apr_func_logic of hlp_fwd_apr_func_logic.v
input logic             fscan_latchclosed_b,    // To u_fwd_apr_func_logic of hlp_fwd_apr_func_logic.v
input logic             fscan_latchopen,        // To u_fwd_apr_func_logic of hlp_fwd_apr_func_logic.v
input logic             fscan_mode,             // To u_fwd_apr_tcam_mems of hlp_fwd_apr_tcam_mems.v, ...
input logic             fscan_mode_atspeed,     // To u_fwd_apr_func_logic of hlp_fwd_apr_func_logic.v
input logic             fscan_ram_bypsel_rf,    // To u_fwd_apr_rf_mems of hlp_fwd_apr_rf_mems.v
input logic             fscan_ram_bypsel_sram,  // To u_fwd_apr_sram_mems of hlp_fwd_apr_sram_mems.v
input logic             fscan_ram_bypsel_tcam,  // To u_fwd_apr_tcam_mems of hlp_fwd_apr_tcam_mems.v
input logic             fscan_ram_init_en,      // To u_fwd_apr_sram_mems of hlp_fwd_apr_sram_mems.v, ...
input logic             fscan_ram_init_val,     // To u_fwd_apr_sram_mems of hlp_fwd_apr_sram_mems.v, ...
input logic             fscan_ram_rdis_b,       // To u_fwd_apr_sram_mems of hlp_fwd_apr_sram_mems.v, ...
input logic             fscan_ram_wdis_b,       // To u_fwd_apr_sram_mems of hlp_fwd_apr_sram_mems.v, ...
input logic             fscan_ret_ctrl,         // To u_fwd_apr_func_logic of hlp_fwd_apr_func_logic.v
input logic             fscan_rstbypen,         // To u_fwd_apr_func_logic of hlp_fwd_apr_func_logic.v
input logic [hlp_dfx_pkg::FWD_NUM_SDI-1:0] fscan_sdi,// To u_fwd_apr_func_logic of hlp_fwd_apr_func_logic.v
input logic             fscan_shiften,          // To u_fwd_apr_tcam_mems of hlp_fwd_apr_tcam_mems.v, ...
input logic             fsta_dfxact_afd,        // To u_fwd_apr_sram_mems of hlp_fwd_apr_sram_mems.v, ...
input logic             fvisa_all_dis,          // To u_fwd_apr_func_logic of hlp_fwd_apr_func_logic.v
input logic [hlp_dfx_pkg::NUM_VISA_LANES-1:0] fvisa_clk,// To u_fwd_apr_func_logic of hlp_fwd_apr_func_logic.v
input logic             fvisa_customer_dis,     // To u_fwd_apr_func_logic of hlp_fwd_apr_func_logic.v
input logic [hlp_dfx_pkg::VISA_DBG_LANE_WIDTH-1:0] fvisa_dbg_lane,// To u_fwd_apr_func_logic of hlp_fwd_apr_func_logic.v
input logic             fvisa_frame,            // To u_fwd_apr_func_logic of hlp_fwd_apr_func_logic.v
input logic             fvisa_rddata,           // To u_fwd_apr_func_logic of hlp_fwd_apr_func_logic.v
input logic             fvisa_resetb,           // To u_fwd_apr_func_logic of hlp_fwd_apr_func_logic.v
input logic             fvisa_serdata,          // To u_fwd_apr_func_logic of hlp_fwd_apr_func_logic.v
input logic             fvisa_serstb,           // To u_fwd_apr_func_logic of hlp_fwd_apr_func_logic.v
input logic [8:0]       fvisa_unit_id,          // To u_fwd_apr_func_logic of hlp_fwd_apr_func_logic.v
input logic [$bits(hlp_pkg::cm_apply_t)-1:0] i_cm_apply,           // To u_fwd_apr_func_logic of hlp_fwd_apr_func_logic.v
input logic             i_cm_apply_v,           // To u_fwd_apr_func_logic of hlp_fwd_apr_func_logic.v
input logic [$bits(hlp_ipp_pkg::ffu_to_fwd_t)-1:0] i_ffu_to_fwd,   // To u_fwd_apr_func_logic of hlp_fwd_apr_func_logic.v
input logic             i_head_v,               // To u_fwd_apr_func_logic of hlp_fwd_apr_func_logic.v
input logic [$bits(hlp_ipp_pkg::l2l_info_t)-1:0] i_l2l_info,       // To u_fwd_apr_func_logic of hlp_fwd_apr_func_logic.v
input logic [$bits(hlp_pkg::mgmt64_t)-1:0] i_mgmt_frm_fcmn,        // To u_fwd_apr_func_logic of hlp_fwd_apr_func_logic.v
input logic             i_mgmt_frm_fcmn_v,      // To u_fwd_apr_func_logic of hlp_fwd_apr_func_logic.v
input logic [$bits(hlp_pkt_meta_pkg::pkt_meta_t)-1:0] i_pkt_meta,  // To u_fwd_apr_func_logic of hlp_fwd_apr_func_logic.v
input logic             i_pkt_meta_v,           // To u_fwd_apr_func_logic of hlp_fwd_apr_func_logic.v
input logic [$bits(hlp_pkg::imn_rpl_bkwd_t)-1:0] i_rpl_bkwd,       // To u_fwd_apr_func_logic of hlp_fwd_apr_func_logic.v
input logic [$bits(hlp_pkg::imn_rpl_frwd_t)-1:0] i_rpl_frwd,       // To u_fwd_apr_func_logic of hlp_fwd_apr_func_logic.v
input logic [$bits(hlp_ipp_pkg::sop_info_t)-1:0] i_sop_info,       // To u_fwd_apr_func_logic of hlp_fwd_apr_func_logic.v
input logic             i_sop_info_v,           // To u_fwd_apr_func_logic of hlp_fwd_apr_func_logic.v
input logic [$bits(hlp_ipp_pkg::tail_info_t)-1:0] i_tail_info,     // To u_fwd_apr_func_logic of hlp_fwd_apr_func_logic.v
input logic             i_tail_info_v,          // To u_fwd_apr_func_logic of hlp_fwd_apr_func_logic.v
input logic [$bits(hlp_ipp_pkg::tail_to_l2l_t)-1:0] i_tail_to_l2l, // To u_fwd_apr_func_logic of hlp_fwd_apr_func_logic.v
input logic             i_tail_to_l2l_v,        // To u_fwd_apr_func_logic of hlp_fwd_apr_func_logic.v
input logic [$bits(hlp_ipp_pkg::tail_to_lag_t)-1:0] i_tail_to_lag, // To u_fwd_apr_func_logic of hlp_fwd_apr_func_logic.v
input logic [$bits(hlp_ipp_pkg::tail_to_trig_t)-1:0] i_tail_to_trig,// To u_fwd_apr_func_logic of hlp_fwd_apr_func_logic.v
input logic             isol_en_b,              // To u_fwd_apr_sram_mems of hlp_fwd_apr_sram_mems.v, ...
input logic [4:0]       pwr_mgmt_in_rf,         // To u_fwd_apr_rf_mems of hlp_fwd_apr_rf_mems.v
input logic [5:0]       pwr_mgmt_in_sram,       // To u_fwd_apr_sram_mems of hlp_fwd_apr_sram_mems.v
input logic             rst_n,                  // To u_fwd_apr_func_logic of hlp_fwd_apr_func_logic.v
// End of automatics
/*AUTOOUTPUT*/
// Beginning of automatic outputs (from unused autoinst outputs)
output logic [hlp_dfx_pkg::FWD_NUM_SDO-1:0] ascan_sdo,// From u_fwd_apr_func_logic of hlp_fwd_apr_func_logic.v
output logic            avisa_all_dis,          // From u_fwd_apr_func_logic of hlp_fwd_apr_func_logic.v
output logic [hlp_dfx_pkg::NUM_VISA_LANES-1:0] avisa_clk,// From u_fwd_apr_func_logic of hlp_fwd_apr_func_logic.v
output logic            avisa_customer_dis,     // From u_fwd_apr_func_logic of hlp_fwd_apr_func_logic.v
output logic [hlp_dfx_pkg::VISA_DBG_LANE_WIDTH-1:0] avisa_dbg_lane,// From u_fwd_apr_func_logic of hlp_fwd_apr_func_logic.v
output logic            avisa_frame,            // From u_fwd_apr_func_logic of hlp_fwd_apr_func_logic.v
output logic            avisa_rddata,           // From u_fwd_apr_func_logic of hlp_fwd_apr_func_logic.v
output logic            avisa_serdata,          // From u_fwd_apr_func_logic of hlp_fwd_apr_func_logic.v
output logic            avisa_serstb,           // From u_fwd_apr_func_logic of hlp_fwd_apr_func_logic.v
output logic            isol_ack_b,             // From u_fwd_apr_func_logic of hlp_fwd_apr_func_logic.v
output logic            o_eop,                  // From u_fwd_apr_func_logic of hlp_fwd_apr_func_logic.v
output logic [$bits(hlp_ipp_pkg::fwd_to_tail_t)-1:0] o_fwd_to_tail,// From u_fwd_apr_func_logic of hlp_fwd_apr_func_logic.v
output logic            o_fwd_to_tail_v,        // From u_fwd_apr_func_logic of hlp_fwd_apr_func_logic.v
output logic [$bits(hlp_pkg::mgmt64_t)-1:0] o_mgmt_to_fcmn,        // From u_fwd_apr_func_logic of hlp_fwd_apr_func_logic.v
output logic            o_mgmt_to_fcmn_v,       // From u_fwd_apr_func_logic of hlp_fwd_apr_func_logic.v
output logic [37:0]     o_pm_head_padding,      // From u_fwd_apr_func_logic of hlp_fwd_apr_func_logic.v
output logic [$bits(hlp_ipp_pkg::pol_in_early_t)-1:0] o_pol_in_early,// From u_fwd_apr_func_logic of hlp_fwd_apr_func_logic.v
output logic            o_pol_in_early_v,       // From u_fwd_apr_func_logic of hlp_fwd_apr_func_logic.v
output logic [$bits(hlp_pkg::imn_rpl_bkwd_t)-1:0] o_rpl_bkwd,      // From u_fwd_apr_func_logic of hlp_fwd_apr_func_logic.v
output logic [$bits(hlp_pkg::imn_rpl_frwd_t)-1:0] o_rpl_frwd,      // From u_fwd_apr_func_logic of hlp_fwd_apr_func_logic.v
output logic [$bits(hlp_ipp_pkg::sop_info_t)-1:0] o_sop_info,      // From u_fwd_apr_func_logic of hlp_fwd_apr_func_logic.v
output logic            o_sop_info_v,           // From u_fwd_apr_func_logic of hlp_fwd_apr_func_logic.v
output logic [$bits(hlp_ipp_pkg::tail_info_t)-1:0] o_tail_info,    // From u_fwd_apr_func_logic of hlp_fwd_apr_func_logic.v
output logic            o_tail_info_v
`include "hlp_fwd_apr.VISA_IT.hlp_fwd_apr.port_defs.sv" // Auto Included by VISA IT - *** Do not modify this line ***
          // From u_fwd_apr_func_logic of hlp_fwd_apr_func_logic.v
// End of automatics
, input wire fary_ijtag_tck, input wire fary_ijtag_rst_b, 
                  input wire fary_ijtag_capture, input wire fary_ijtag_shift, 
                  input wire fary_ijtag_update, input wire fary_ijtag_select, 
                  input wire fary_ijtag_si, output wire aary_ijtag_so, 
                  output wire bisr_so_pd_vinf, input wire bisr_si_pd_vinf, 
                  input wire bisr_shift_en_pd_vinf, 
                  input wire bisr_clk_pd_vinf, input wire bisr_reset_pd_vinf, 
                  output wire aary_post_busy, input wire fary_post_force_fail, 
                  input logic [5:0] fary_post_algo_select, 
                  input wire core_rst_b);



  wire [2:0] BIST_SETUP;
  wire [1:1] BIST_OPSET_SEL_ts1;
  wire [10:0] toBist, bistEn;
  wire [1:0] BIST_COL_ADD_ts1, BIST_COL_ADD_ts2;
  wire [2:0] BIST_COL_ADD_ts3;
  wire [1:0] BIST_COL_ADD_ts4, BIST_COL_ADD_ts5;
  wire [2:0] BIST_COL_ADD_ts6;
  wire [1:0] BIST_COL_ADD_ts7, BIST_COL_ADD_ts8, BIST_COL_ADD_ts9;
  wire [4:0] BIST_ROW_ADD;
  wire [7:0] BIST_ROW_ADD_ts1, BIST_ROW_ADD_ts2, BIST_ROW_ADD_ts3;
  wire [6:0] BIST_ROW_ADD_ts4;
  wire [7:0] BIST_ROW_ADD_ts5, BIST_ROW_ADD_ts6, BIST_ROW_ADD_ts7, 
             BIST_ROW_ADD_ts8, BIST_ROW_ADD_ts9;
  wire [5:0] BIST_ROW_ADD_ts10;
  wire [1:0] BIST_BANK_ADD, BIST_BANK_ADD_ts2, BIST_BANK_ADD_ts5;
  wire [2:0] BIST_BANK_ADD_ts7;
  wire [7:0] BIST_WRITE_DATA;
  wire [31:0] BIST_WRITE_DATA_ts1, BIST_WRITE_DATA_ts2;
  wire [29:0] BIST_WRITE_DATA_ts3;
  wire [31:0] BIST_WRITE_DATA_ts4, BIST_WRITE_DATA_ts5, BIST_WRITE_DATA_ts6;
  wire [22:0] BIST_WRITE_DATA_ts7;
  wire [31:0] BIST_WRITE_DATA_ts8, BIST_WRITE_DATA_ts9, BIST_WRITE_DATA_ts10;
  wire [7:0] BIST_EXPECT_DATA;
  wire [31:0] BIST_EXPECT_DATA_ts1, BIST_EXPECT_DATA_ts2;
  wire [29:0] BIST_EXPECT_DATA_ts3;
  wire [31:0] BIST_EXPECT_DATA_ts4, BIST_EXPECT_DATA_ts5, BIST_EXPECT_DATA_ts6;
  wire [22:0] BIST_EXPECT_DATA_ts7;
  wire [31:0] BIST_EXPECT_DATA_ts8, BIST_EXPECT_DATA_ts9, BIST_EXPECT_DATA_ts10;
  wire [1:0] BIST_COLLAR_OPSET_SELECT_ts10;
  logic clk_ts1;
  wire hlp_fwd_apr_rtl_tessent_sib_mbist_inst_so, 
       hlp_fwd_apr_rtl_tessent_sib_sti_inst_so, 
       hlp_fwd_apr_rtl_tessent_sib_sri_ctrl_inst_so, 
       hlp_fwd_apr_rtl_tessent_tdr_sri_ctrl_inst_so, 
       hlp_fwd_apr_rtl_tessent_sib_sri_inst_to_select, 
       hlp_fwd_apr_rtl_tessent_sib_sti_inst_so_ts1, 
       hlp_fwd_apr_rtl_tessent_tdr_RF_c1_algo_select_tdr_inst_so, 
       hlp_fwd_apr_rtl_tessent_sib_sti_inst_to_select, 
       hlp_fwd_apr_rtl_tessent_sib_algo_select_sib_inst_so, 
       hlp_fwd_apr_rtl_tessent_sib_sri_ctrl_inst_to_select, 
       hlp_fwd_apr_rtl_tessent_sib_algo_select_sib_inst_to_select, 
       hlp_fwd_apr_rtl_tessent_tdr_TCAM_c11_algo_select_tdr_inst_so, 
       hlp_fwd_apr_rtl_tessent_tdr_SRAM_c10_algo_select_tdr_inst_so, 
       hlp_fwd_apr_rtl_tessent_tdr_SRAM_c9_algo_select_tdr_inst_so, 
       hlp_fwd_apr_rtl_tessent_tdr_SRAM_c8_algo_select_tdr_inst_so, 
       hlp_fwd_apr_rtl_tessent_tdr_SRAM_c7_algo_select_tdr_inst_so, 
       hlp_fwd_apr_rtl_tessent_tdr_SRAM_c6_algo_select_tdr_inst_so, 
       hlp_fwd_apr_rtl_tessent_tdr_SRAM_c5_algo_select_tdr_inst_so, 
       hlp_fwd_apr_rtl_tessent_tdr_SRAM_c4_algo_select_tdr_inst_so, 
       hlp_fwd_apr_rtl_tessent_tdr_SRAM_c3_algo_select_tdr_inst_so, 
       hlp_fwd_apr_rtl_tessent_tdr_SRAM_c2_algo_select_tdr_inst_so, ijtag_to_se, 
       ijtag_to_ce, ijtag_to_tck, ijtag_to_ue, ijtag_to_reset, ijtag_to_sel, 
       ltest_to_en, ltest_to_mem_bypass_en, ltest_to_scan_en, 
       ltest_to_mcp_bounding_en, BIRA_EN, PRESERVE_FUSE_REGISTER, 
       CHECK_REPAIR_NEEDED, BIST_HOLD, BIST_SETUP_ts1, BIST_SETUP_ts2, 
       BIST_SETUP_ts3, BIST_SELECT_TEST_DATA, to_controllers_tck, 
       to_interfaces_tck, to_controllers_tck_retime, mcp_bounding_to_en, 
       scan_to_en, memory_bypass_to_en, ltest_to_en_ts1, BIST_ALGO_SEL, 
       BIST_ALGO_SEL_ts1, BIST_ALGO_SEL_ts2, BIST_ALGO_SEL_ts3, 
       BIST_ALGO_SEL_ts4, BIST_ALGO_SEL_ts5, BIST_ALGO_SEL_ts6, 
       BIST_SELECT_COMMON_ALGO, BIST_SELECT_COMMON_OPSET, BIST_OPSET_SEL, 
       BIST_DATA_INV_ROW_ADD_BIT_SELECT_EN, BIST_DATA_INV_ROW_ADD_BIT_SEL, 
       BIST_DATA_INV_COL_ADD_BIT_SEL, GO_ID_REG_SEL, GO_ID_REG_SEL_ts1, 
       GO_ID_REG_SEL_ts2, GO_ID_REG_SEL_ts3, GO_ID_REG_SEL_ts4, 
       GO_ID_REG_SEL_ts5, GO_ID_REG_SEL_ts6, GO_ID_REG_SEL_ts7, 
       GO_ID_REG_SEL_ts8, GO_ID_REG_SEL_ts9, GO_ID_REG_SEL_ts10, 
       BIST_DATA_INV_COL_ADD_BIT_SELECT_EN, BIST_ALGO_MODE0, BIST_ALGO_MODE1, 
       ENABLE_MEM_RESET, REDUCED_ADDRESS_COUNT, BIST_CLEAR_BIRA, 
       BIST_COLLAR_DIAG_EN, BIST_COLLAR_BIRA_EN, PriorityColumn, 
       BIST_SHIFT_BIRA_COLLAR, BIST_CLEAR_BIRA_ts1, BIST_COLLAR_DIAG_EN_ts1, 
       BIST_COLLAR_BIRA_EN_ts1, PriorityColumn_ts1, BIST_SHIFT_BIRA_COLLAR_ts1, 
       BIST_CLEAR_BIRA_ts2, BIST_COLLAR_DIAG_EN_ts2, BIST_COLLAR_BIRA_EN_ts2, 
       PriorityColumn_ts2, BIST_SHIFT_BIRA_COLLAR_ts2, BIST_CLEAR_BIRA_ts3, 
       BIST_COLLAR_DIAG_EN_ts3, BIST_COLLAR_BIRA_EN_ts3, PriorityColumn_ts3, 
       BIST_SHIFT_BIRA_COLLAR_ts3, BIST_CLEAR_BIRA_ts4, BIST_COLLAR_DIAG_EN_ts4, 
       BIST_COLLAR_BIRA_EN_ts4, PriorityColumn_ts4, BIST_SHIFT_BIRA_COLLAR_ts4, 
       BIST_CLEAR_BIRA_ts5, BIST_COLLAR_DIAG_EN_ts5, BIST_COLLAR_BIRA_EN_ts5, 
       PriorityColumn_ts5, BIST_SHIFT_BIRA_COLLAR_ts5, BIST_CLEAR_BIRA_ts6, 
       BIST_COLLAR_DIAG_EN_ts6, BIST_COLLAR_BIRA_EN_ts6, PriorityColumn_ts6, 
       BIST_SHIFT_BIRA_COLLAR_ts6, BIST_CLEAR_BIRA_ts7, BIST_COLLAR_DIAG_EN_ts7, 
       BIST_COLLAR_BIRA_EN_ts7, PriorityColumn_ts7, BIST_SHIFT_BIRA_COLLAR_ts7, 
       BIST_CLEAR_BIRA_ts8, BIST_COLLAR_DIAG_EN_ts8, BIST_COLLAR_BIRA_EN_ts8, 
       PriorityColumn_ts8, BIST_SHIFT_BIRA_COLLAR_ts8, BIST_CLEAR_BIRA_ts9, 
       BIST_COLLAR_DIAG_EN_ts9, BIST_COLLAR_BIRA_EN_ts9, PriorityColumn_ts9, 
       BIST_SHIFT_BIRA_COLLAR_ts9, BIST_CLEAR_BIRA_ts10, 
       BIST_COLLAR_DIAG_EN_ts10, BIST_COLLAR_BIRA_EN_ts10, 
       BIST_SHIFT_BIRA_COLLAR_ts10, MEM_ARRAY_DUMP_MODE, BIST_DIAG_EN, 
       BIST_ASYNC_RESET, MEM0_BIST_COLLAR_SI, MEM0_BIST_COLLAR_SI_ts1, 
       MEM1_BIST_COLLAR_SI, MEM2_BIST_COLLAR_SI, MEM3_BIST_COLLAR_SI, 
       MEM4_BIST_COLLAR_SI, MEM5_BIST_COLLAR_SI, MEM6_BIST_COLLAR_SI, 
       MEM7_BIST_COLLAR_SI, MEM8_BIST_COLLAR_SI, MEM9_BIST_COLLAR_SI, 
       MEM10_BIST_COLLAR_SI, MEM11_BIST_COLLAR_SI, MEM12_BIST_COLLAR_SI, 
       MEM13_BIST_COLLAR_SI, MEM14_BIST_COLLAR_SI, MEM15_BIST_COLLAR_SI, 
       MEM16_BIST_COLLAR_SI, MEM17_BIST_COLLAR_SI, MEM18_BIST_COLLAR_SI, 
       MEM19_BIST_COLLAR_SI, MEM0_BIST_COLLAR_SI_ts2, MEM1_BIST_COLLAR_SI_ts1, 
       MEM2_BIST_COLLAR_SI_ts1, MEM3_BIST_COLLAR_SI_ts1, 
       MEM4_BIST_COLLAR_SI_ts1, MEM5_BIST_COLLAR_SI_ts1, 
       MEM6_BIST_COLLAR_SI_ts1, MEM7_BIST_COLLAR_SI_ts1, 
       MEM8_BIST_COLLAR_SI_ts1, MEM9_BIST_COLLAR_SI_ts1, 
       MEM10_BIST_COLLAR_SI_ts1, MEM11_BIST_COLLAR_SI_ts1, 
       MEM12_BIST_COLLAR_SI_ts1, MEM13_BIST_COLLAR_SI_ts1, 
       MEM14_BIST_COLLAR_SI_ts1, MEM15_BIST_COLLAR_SI_ts1, 
       MEM16_BIST_COLLAR_SI_ts1, MEM17_BIST_COLLAR_SI_ts1, 
       MEM18_BIST_COLLAR_SI_ts1, MEM19_BIST_COLLAR_SI_ts1, MEM20_BIST_COLLAR_SI, 
       MEM21_BIST_COLLAR_SI, MEM22_BIST_COLLAR_SI, MEM23_BIST_COLLAR_SI, 
       MEM24_BIST_COLLAR_SI, MEM25_BIST_COLLAR_SI, MEM26_BIST_COLLAR_SI, 
       MEM27_BIST_COLLAR_SI, MEM28_BIST_COLLAR_SI, MEM29_BIST_COLLAR_SI, 
       MEM30_BIST_COLLAR_SI, MEM31_BIST_COLLAR_SI, MEM0_BIST_COLLAR_SI_ts3, 
       MEM0_BIST_COLLAR_SI_ts4, MEM1_BIST_COLLAR_SI_ts2, 
       MEM0_BIST_COLLAR_SI_ts5, MEM1_BIST_COLLAR_SI_ts3, 
       MEM2_BIST_COLLAR_SI_ts2, MEM3_BIST_COLLAR_SI_ts2, 
       MEM4_BIST_COLLAR_SI_ts2, MEM5_BIST_COLLAR_SI_ts2, 
       MEM6_BIST_COLLAR_SI_ts2, MEM7_BIST_COLLAR_SI_ts2, 
       MEM8_BIST_COLLAR_SI_ts2, MEM9_BIST_COLLAR_SI_ts2, 
       MEM10_BIST_COLLAR_SI_ts2, MEM11_BIST_COLLAR_SI_ts2, 
       MEM12_BIST_COLLAR_SI_ts2, MEM13_BIST_COLLAR_SI_ts2, 
       MEM14_BIST_COLLAR_SI_ts2, MEM15_BIST_COLLAR_SI_ts2, 
       MEM16_BIST_COLLAR_SI_ts2, MEM17_BIST_COLLAR_SI_ts2, 
       MEM18_BIST_COLLAR_SI_ts2, MEM19_BIST_COLLAR_SI_ts2, 
       MEM20_BIST_COLLAR_SI_ts1, MEM21_BIST_COLLAR_SI_ts1, 
       MEM22_BIST_COLLAR_SI_ts1, MEM23_BIST_COLLAR_SI_ts1, 
       MEM24_BIST_COLLAR_SI_ts1, MEM25_BIST_COLLAR_SI_ts1, 
       MEM26_BIST_COLLAR_SI_ts1, MEM27_BIST_COLLAR_SI_ts1, 
       MEM28_BIST_COLLAR_SI_ts1, MEM29_BIST_COLLAR_SI_ts1, 
       MEM30_BIST_COLLAR_SI_ts1, MEM31_BIST_COLLAR_SI_ts1, 
       MEM0_BIST_COLLAR_SI_ts6, MEM1_BIST_COLLAR_SI_ts4, 
       MEM0_BIST_COLLAR_SI_ts7, MEM1_BIST_COLLAR_SI_ts5, 
       MEM2_BIST_COLLAR_SI_ts3, MEM3_BIST_COLLAR_SI_ts3, 
       MEM4_BIST_COLLAR_SI_ts3, MEM5_BIST_COLLAR_SI_ts3, 
       MEM6_BIST_COLLAR_SI_ts3, MEM7_BIST_COLLAR_SI_ts3, 
       MEM0_BIST_COLLAR_SI_ts8, MEM1_BIST_COLLAR_SI_ts6, 
       MEM2_BIST_COLLAR_SI_ts4, MEM0_BIST_COLLAR_SI_ts9, 
       MEM1_BIST_COLLAR_SI_ts7, MEM2_BIST_COLLAR_SI_ts5, 
       MEM3_BIST_COLLAR_SI_ts4, MEM4_BIST_COLLAR_SI_ts4, 
       MEM5_BIST_COLLAR_SI_ts4, MEM6_BIST_COLLAR_SI_ts4, 
       MEM7_BIST_COLLAR_SI_ts4, MEM8_BIST_COLLAR_SI_ts3, 
       MEM9_BIST_COLLAR_SI_ts3, MEM10_BIST_COLLAR_SI_ts3, 
       MEM11_BIST_COLLAR_SI_ts3, MEM12_BIST_COLLAR_SI_ts3, 
       MEM13_BIST_COLLAR_SI_ts3, MEM14_BIST_COLLAR_SI_ts3, 
       MEM15_BIST_COLLAR_SI_ts3, MEM16_BIST_COLLAR_SI_ts3, 
       MEM17_BIST_COLLAR_SI_ts3, MEM18_BIST_COLLAR_SI_ts3, 
       MEM19_BIST_COLLAR_SI_ts3, MEM20_BIST_COLLAR_SI_ts2, 
       MEM21_BIST_COLLAR_SI_ts2, MEM22_BIST_COLLAR_SI_ts2, 
       MEM23_BIST_COLLAR_SI_ts2, MEM24_BIST_COLLAR_SI_ts2, 
       MEM25_BIST_COLLAR_SI_ts2, MEM26_BIST_COLLAR_SI_ts2, 
       MEM27_BIST_COLLAR_SI_ts2, MEM28_BIST_COLLAR_SI_ts2, 
       MEM29_BIST_COLLAR_SI_ts2, MEM30_BIST_COLLAR_SI_ts2, 
       MEM31_BIST_COLLAR_SI_ts2, MEM0_BIST_COLLAR_SI_ts10, 
       MEM1_BIST_COLLAR_SI_ts8, MEM2_BIST_COLLAR_SI_ts6, 
       MEM3_BIST_COLLAR_SI_ts5, MEM4_BIST_COLLAR_SI_ts5, 
       MEM5_BIST_COLLAR_SI_ts5, MEM6_BIST_COLLAR_SI_ts5, 
       MEM7_BIST_COLLAR_SI_ts5, MBISTPG_SO, MBISTPG_SO_ts1, MBISTPG_SO_ts2, 
       MBISTPG_SO_ts3, MBISTPG_SO_ts4, MBISTPG_SO_ts5, MBISTPG_SO_ts6, 
       MBISTPG_SO_ts7, MBISTPG_SO_ts8, MBISTPG_SO_ts9, MBISTPG_SO_ts10, BIST_SO, 
       BIST_SO_ts1, BIST_SO_ts2, BIST_SO_ts3, BIST_SO_ts4, BIST_SO_ts5, 
       BIST_SO_ts6, BIST_SO_ts7, BIST_SO_ts8, BIST_SO_ts9, BIST_SO_ts10, 
       BIST_SO_ts11, BIST_SO_ts12, BIST_SO_ts13, BIST_SO_ts14, BIST_SO_ts15, 
       BIST_SO_ts16, BIST_SO_ts17, BIST_SO_ts18, BIST_SO_ts19, BIST_SO_ts20, 
       BIST_SO_ts21, BIST_SO_ts22, BIST_SO_ts23, BIST_SO_ts24, BIST_SO_ts25, 
       BIST_SO_ts26, BIST_SO_ts27, BIST_SO_ts28, BIST_SO_ts29, BIST_SO_ts30, 
       BIST_SO_ts31, BIST_SO_ts32, BIST_SO_ts33, BIST_SO_ts34, BIST_SO_ts35, 
       BIST_SO_ts36, BIST_SO_ts37, BIST_SO_ts38, BIST_SO_ts39, BIST_SO_ts40, 
       BIST_SO_ts41, BIST_SO_ts42, BIST_SO_ts43, BIST_SO_ts44, BIST_SO_ts45, 
       BIST_SO_ts46, BIST_SO_ts47, BIST_SO_ts48, BIST_SO_ts49, BIST_SO_ts50, 
       BIST_SO_ts51, BIST_SO_ts52, BIST_SO_ts53, BIST_SO_ts54, BIST_SO_ts55, 
       BIST_SO_ts56, BIST_SO_ts57, BIST_SO_ts58, BIST_SO_ts59, BIST_SO_ts60, 
       BIST_SO_ts61, BIST_SO_ts62, BIST_SO_ts63, BIST_SO_ts64, BIST_SO_ts65, 
       BIST_SO_ts66, BIST_SO_ts67, BIST_SO_ts68, BIST_SO_ts69, BIST_SO_ts70, 
       BIST_SO_ts71, BIST_SO_ts72, BIST_SO_ts73, BIST_SO_ts74, BIST_SO_ts75, 
       BIST_SO_ts76, BIST_SO_ts77, BIST_SO_ts78, BIST_SO_ts79, BIST_SO_ts80, 
       BIST_SO_ts81, BIST_SO_ts82, BIST_SO_ts83, BIST_SO_ts84, BIST_SO_ts85, 
       BIST_SO_ts86, BIST_SO_ts87, BIST_SO_ts88, BIST_SO_ts89, BIST_SO_ts90, 
       BIST_SO_ts91, BIST_SO_ts92, BIST_SO_ts93, BIST_SO_ts94, BIST_SO_ts95, 
       BIST_SO_ts96, BIST_SO_ts97, BIST_SO_ts98, BIST_SO_ts99, BIST_SO_ts100, 
       BIST_SO_ts101, BIST_SO_ts102, BIST_SO_ts103, BIST_SO_ts104, 
       BIST_SO_ts105, BIST_SO_ts106, BIST_SO_ts107, BIST_SO_ts108, 
       BIST_SO_ts109, BIST_SO_ts110, BIST_SO_ts111, BIST_SO_ts112, 
       BIST_SO_ts113, BIST_SO_ts114, BIST_SO_ts115, BIST_SO_ts116, 
       BIST_SO_ts117, BIST_SO_ts118, BIST_SO_ts119, BIST_SO_ts120, 
       BIST_SO_ts121, BIST_SO_ts122, BIST_SO_ts123, BIST_SO_ts124, 
       BIST_SO_ts125, BIST_SO_ts126, BIST_SO_ts127, BIST_SO_ts128, 
       BIST_SO_ts129, BIST_SO_ts130, BIST_SO_ts131, BIST_SO_ts132, 
       BIST_SO_ts133, BIST_SO_ts134, BIST_SO_ts135, BIST_SO_ts136, 
       BIST_SO_ts137, BIST_SO_ts138, BIST_SO_ts139, BIST_SO_ts140, MBISTPG_DONE, 
       MBISTPG_DONE_ts1, MBISTPG_DONE_ts2, MBISTPG_DONE_ts3, MBISTPG_DONE_ts4, 
       MBISTPG_DONE_ts5, MBISTPG_DONE_ts6, MBISTPG_DONE_ts7, MBISTPG_DONE_ts8, 
       MBISTPG_DONE_ts9, MBISTPG_DONE_ts10, MBISTPG_GO, MBISTPG_GO_ts1, 
       MBISTPG_GO_ts2, MBISTPG_GO_ts3, MBISTPG_GO_ts4, MBISTPG_GO_ts5, 
       MBISTPG_GO_ts6, MBISTPG_GO_ts7, MBISTPG_GO_ts8, MBISTPG_GO_ts9, 
       MBISTPG_GO_ts10, BIST_GO, BIST_GO_ts1, BIST_GO_ts2, BIST_GO_ts3, 
       BIST_GO_ts4, BIST_GO_ts5, BIST_GO_ts6, BIST_GO_ts7, BIST_GO_ts8, 
       BIST_GO_ts9, BIST_GO_ts10, BIST_GO_ts11, BIST_GO_ts12, BIST_GO_ts13, 
       BIST_GO_ts14, BIST_GO_ts15, BIST_GO_ts16, BIST_GO_ts17, BIST_GO_ts18, 
       BIST_GO_ts19, BIST_GO_ts20, BIST_GO_ts21, BIST_GO_ts22, BIST_GO_ts23, 
       BIST_GO_ts24, BIST_GO_ts25, BIST_GO_ts26, BIST_GO_ts27, BIST_GO_ts28, 
       BIST_GO_ts29, BIST_GO_ts30, BIST_GO_ts31, BIST_GO_ts32, BIST_GO_ts33, 
       BIST_GO_ts34, BIST_GO_ts35, BIST_GO_ts36, BIST_GO_ts37, BIST_GO_ts38, 
       BIST_GO_ts39, BIST_GO_ts40, BIST_GO_ts41, BIST_GO_ts42, BIST_GO_ts43, 
       BIST_GO_ts44, BIST_GO_ts45, BIST_GO_ts46, BIST_GO_ts47, BIST_GO_ts48, 
       BIST_GO_ts49, BIST_GO_ts50, BIST_GO_ts51, BIST_GO_ts52, BIST_GO_ts53, 
       BIST_GO_ts54, BIST_GO_ts55, BIST_GO_ts56, BIST_GO_ts57, BIST_GO_ts58, 
       BIST_GO_ts59, BIST_GO_ts60, BIST_GO_ts61, BIST_GO_ts62, BIST_GO_ts63, 
       BIST_GO_ts64, BIST_GO_ts65, BIST_GO_ts66, BIST_GO_ts67, BIST_GO_ts68, 
       BIST_GO_ts69, BIST_GO_ts70, BIST_GO_ts71, BIST_GO_ts72, BIST_GO_ts73, 
       BIST_GO_ts74, BIST_GO_ts75, BIST_GO_ts76, BIST_GO_ts77, BIST_GO_ts78, 
       BIST_GO_ts79, BIST_GO_ts80, BIST_GO_ts81, BIST_GO_ts82, BIST_GO_ts83, 
       BIST_GO_ts84, BIST_GO_ts85, BIST_GO_ts86, BIST_GO_ts87, BIST_GO_ts88, 
       BIST_GO_ts89, BIST_GO_ts90, BIST_GO_ts91, BIST_GO_ts92, BIST_GO_ts93, 
       BIST_GO_ts94, BIST_GO_ts95, BIST_GO_ts96, BIST_GO_ts97, BIST_GO_ts98, 
       BIST_GO_ts99, BIST_GO_ts100, BIST_GO_ts101, BIST_GO_ts102, BIST_GO_ts103, 
       BIST_GO_ts104, BIST_GO_ts105, BIST_GO_ts106, BIST_GO_ts107, 
       BIST_GO_ts108, BIST_GO_ts109, BIST_GO_ts110, BIST_GO_ts111, 
       BIST_GO_ts112, BIST_GO_ts113, BIST_GO_ts114, BIST_GO_ts115, 
       BIST_GO_ts116, BIST_GO_ts117, BIST_GO_ts118, BIST_GO_ts119, 
       BIST_GO_ts120, BIST_GO_ts121, BIST_GO_ts122, BIST_GO_ts123, 
       BIST_GO_ts124, BIST_GO_ts125, BIST_GO_ts126, BIST_GO_ts127, 
       BIST_GO_ts128, BIST_GO_ts129, BIST_GO_ts130, BIST_GO_ts131, 
       BIST_GO_ts132, BIST_GO_ts133, BIST_GO_ts134, BIST_GO_ts135, 
       BIST_GO_ts136, BIST_GO_ts137, BIST_GO_ts138, BIST_GO_ts139, 
       BIST_GO_ts140, FL_CNT_MODE0, FL_CNT_MODE1, BIST_READENABLE, 
       BIST_WRITEENABLE, BIST_WRITEENABLE_ts1, BIST_SELECT, 
       BIST_WRITEENABLE_ts2, BIST_SELECT_ts1, BIST_WRITEENABLE_ts3, 
       BIST_SELECT_ts2, BIST_WRITEENABLE_ts4, BIST_SELECT_ts3, 
       BIST_WRITEENABLE_ts5, BIST_SELECT_ts4, BIST_WRITEENABLE_ts6, 
       BIST_SELECT_ts5, BIST_WRITEENABLE_ts7, BIST_SELECT_ts6, 
       BIST_WRITEENABLE_ts8, BIST_SELECT_ts7, BIST_WRITEENABLE_ts9, 
       BIST_SELECT_ts8, BIST_USER9, BIST_USER10, BIST_USER11, BIST_USER0, 
       BIST_USER1, BIST_USER2, BIST_USER3, BIST_USER4, BIST_USER5, BIST_USER6, 
       BIST_USER7, BIST_USER8, BIST_EVEN_GROUPWRITEENABLE, 
       BIST_ODD_GROUPWRITEENABLE, BIST_WRITEENABLE_ts10, BIST_READENABLE_ts1, 
       BIST_SELECT_ts9, BIST_CMP, BIST_CMP_ts1, BIST_CMP_ts2, BIST_CMP_ts3, 
       BIST_CMP_ts4, BIST_CMP_ts5, BIST_CMP_ts6, BIST_CMP_ts7, BIST_CMP_ts8, 
       BIST_CMP_ts9, BIST_CMP_ts10, INCLUDE_MEM_RESULTS_REG, BIST_COL_ADD, 
       BIST_COL_ADD_ts10, BIST_BANK_ADD_ts1, BIST_BANK_ADD_ts3, 
       BIST_BANK_ADD_ts4, BIST_BANK_ADD_ts6, BIST_COLLAR_EN0, 
       BIST_COLLAR_EN0_ts1, BIST_COLLAR_EN1, BIST_COLLAR_EN2, BIST_COLLAR_EN3, 
       BIST_COLLAR_EN4, BIST_COLLAR_EN5, BIST_COLLAR_EN6, BIST_COLLAR_EN7, 
       BIST_COLLAR_EN8, BIST_COLLAR_EN9, BIST_COLLAR_EN10, BIST_COLLAR_EN11, 
       BIST_COLLAR_EN12, BIST_COLLAR_EN13, BIST_COLLAR_EN14, BIST_COLLAR_EN15, 
       BIST_COLLAR_EN16, BIST_COLLAR_EN17, BIST_COLLAR_EN18, BIST_COLLAR_EN19, 
       BIST_COLLAR_EN0_ts2, BIST_COLLAR_EN1_ts1, BIST_COLLAR_EN2_ts1, 
       BIST_COLLAR_EN3_ts1, BIST_COLLAR_EN4_ts1, BIST_COLLAR_EN5_ts1, 
       BIST_COLLAR_EN6_ts1, BIST_COLLAR_EN7_ts1, BIST_COLLAR_EN8_ts1, 
       BIST_COLLAR_EN9_ts1, BIST_COLLAR_EN10_ts1, BIST_COLLAR_EN11_ts1, 
       BIST_COLLAR_EN12_ts1, BIST_COLLAR_EN13_ts1, BIST_COLLAR_EN14_ts1, 
       BIST_COLLAR_EN15_ts1, BIST_COLLAR_EN16_ts1, BIST_COLLAR_EN17_ts1, 
       BIST_COLLAR_EN18_ts1, BIST_COLLAR_EN19_ts1, BIST_COLLAR_EN20, 
       BIST_COLLAR_EN21, BIST_COLLAR_EN22, BIST_COLLAR_EN23, BIST_COLLAR_EN24, 
       BIST_COLLAR_EN25, BIST_COLLAR_EN26, BIST_COLLAR_EN27, BIST_COLLAR_EN28, 
       BIST_COLLAR_EN29, BIST_COLLAR_EN30, BIST_COLLAR_EN31, 
       BIST_COLLAR_EN0_ts3, BIST_COLLAR_EN0_ts4, BIST_COLLAR_EN1_ts2, 
       BIST_COLLAR_EN0_ts5, BIST_COLLAR_EN1_ts3, BIST_COLLAR_EN2_ts2, 
       BIST_COLLAR_EN3_ts2, BIST_COLLAR_EN4_ts2, BIST_COLLAR_EN5_ts2, 
       BIST_COLLAR_EN6_ts2, BIST_COLLAR_EN7_ts2, BIST_COLLAR_EN8_ts2, 
       BIST_COLLAR_EN9_ts2, BIST_COLLAR_EN10_ts2, BIST_COLLAR_EN11_ts2, 
       BIST_COLLAR_EN12_ts2, BIST_COLLAR_EN13_ts2, BIST_COLLAR_EN14_ts2, 
       BIST_COLLAR_EN15_ts2, BIST_COLLAR_EN16_ts2, BIST_COLLAR_EN17_ts2, 
       BIST_COLLAR_EN18_ts2, BIST_COLLAR_EN19_ts2, BIST_COLLAR_EN20_ts1, 
       BIST_COLLAR_EN21_ts1, BIST_COLLAR_EN22_ts1, BIST_COLLAR_EN23_ts1, 
       BIST_COLLAR_EN24_ts1, BIST_COLLAR_EN25_ts1, BIST_COLLAR_EN26_ts1, 
       BIST_COLLAR_EN27_ts1, BIST_COLLAR_EN28_ts1, BIST_COLLAR_EN29_ts1, 
       BIST_COLLAR_EN30_ts1, BIST_COLLAR_EN31_ts1, BIST_COLLAR_EN0_ts6, 
       BIST_COLLAR_EN1_ts4, BIST_COLLAR_EN0_ts7, BIST_COLLAR_EN1_ts5, 
       BIST_COLLAR_EN2_ts3, BIST_COLLAR_EN3_ts3, BIST_COLLAR_EN4_ts3, 
       BIST_COLLAR_EN5_ts3, BIST_COLLAR_EN6_ts3, BIST_COLLAR_EN7_ts3, 
       BIST_COLLAR_EN0_ts8, BIST_COLLAR_EN1_ts6, BIST_COLLAR_EN2_ts4, 
       BIST_COLLAR_EN0_ts9, BIST_COLLAR_EN1_ts7, BIST_COLLAR_EN2_ts5, 
       BIST_COLLAR_EN3_ts4, BIST_COLLAR_EN4_ts4, BIST_COLLAR_EN5_ts4, 
       BIST_COLLAR_EN6_ts4, BIST_COLLAR_EN7_ts4, BIST_COLLAR_EN8_ts3, 
       BIST_COLLAR_EN9_ts3, BIST_COLLAR_EN10_ts3, BIST_COLLAR_EN11_ts3, 
       BIST_COLLAR_EN12_ts3, BIST_COLLAR_EN13_ts3, BIST_COLLAR_EN14_ts3, 
       BIST_COLLAR_EN15_ts3, BIST_COLLAR_EN16_ts3, BIST_COLLAR_EN17_ts3, 
       BIST_COLLAR_EN18_ts3, BIST_COLLAR_EN19_ts3, BIST_COLLAR_EN20_ts2, 
       BIST_COLLAR_EN21_ts2, BIST_COLLAR_EN22_ts2, BIST_COLLAR_EN23_ts2, 
       BIST_COLLAR_EN24_ts2, BIST_COLLAR_EN25_ts2, BIST_COLLAR_EN26_ts2, 
       BIST_COLLAR_EN27_ts2, BIST_COLLAR_EN28_ts2, BIST_COLLAR_EN29_ts2, 
       BIST_COLLAR_EN30_ts2, BIST_COLLAR_EN31_ts2, BIST_COLLAR_EN0_ts10, 
       BIST_COLLAR_EN1_ts8, BIST_COLLAR_EN2_ts6, BIST_COLLAR_EN3_ts5, 
       BIST_COLLAR_EN4_ts5, BIST_COLLAR_EN5_ts5, BIST_COLLAR_EN6_ts5, 
       BIST_COLLAR_EN7_ts5, BIST_RUN_TO_COLLAR0, BIST_RUN_TO_COLLAR0_ts1, 
       BIST_RUN_TO_COLLAR1, BIST_RUN_TO_COLLAR2, BIST_RUN_TO_COLLAR3, 
       BIST_RUN_TO_COLLAR4, BIST_RUN_TO_COLLAR5, BIST_RUN_TO_COLLAR6, 
       BIST_RUN_TO_COLLAR7, BIST_RUN_TO_COLLAR8, BIST_RUN_TO_COLLAR9, 
       BIST_RUN_TO_COLLAR10, BIST_RUN_TO_COLLAR11, BIST_RUN_TO_COLLAR12, 
       BIST_RUN_TO_COLLAR13, BIST_RUN_TO_COLLAR14, BIST_RUN_TO_COLLAR15, 
       BIST_RUN_TO_COLLAR16, BIST_RUN_TO_COLLAR17, BIST_RUN_TO_COLLAR18, 
       BIST_RUN_TO_COLLAR19, BIST_RUN_TO_COLLAR0_ts2, BIST_RUN_TO_COLLAR1_ts1, 
       BIST_RUN_TO_COLLAR2_ts1, BIST_RUN_TO_COLLAR3_ts1, 
       BIST_RUN_TO_COLLAR4_ts1, BIST_RUN_TO_COLLAR5_ts1, 
       BIST_RUN_TO_COLLAR6_ts1, BIST_RUN_TO_COLLAR7_ts1, 
       BIST_RUN_TO_COLLAR8_ts1, BIST_RUN_TO_COLLAR9_ts1, 
       BIST_RUN_TO_COLLAR10_ts1, BIST_RUN_TO_COLLAR11_ts1, 
       BIST_RUN_TO_COLLAR12_ts1, BIST_RUN_TO_COLLAR13_ts1, 
       BIST_RUN_TO_COLLAR14_ts1, BIST_RUN_TO_COLLAR15_ts1, 
       BIST_RUN_TO_COLLAR16_ts1, BIST_RUN_TO_COLLAR17_ts1, 
       BIST_RUN_TO_COLLAR18_ts1, BIST_RUN_TO_COLLAR19_ts1, BIST_RUN_TO_COLLAR20, 
       BIST_RUN_TO_COLLAR21, BIST_RUN_TO_COLLAR22, BIST_RUN_TO_COLLAR23, 
       BIST_RUN_TO_COLLAR24, BIST_RUN_TO_COLLAR25, BIST_RUN_TO_COLLAR26, 
       BIST_RUN_TO_COLLAR27, BIST_RUN_TO_COLLAR28, BIST_RUN_TO_COLLAR29, 
       BIST_RUN_TO_COLLAR30, BIST_RUN_TO_COLLAR31, BIST_RUN_TO_COLLAR0_ts3, 
       BIST_RUN_TO_COLLAR0_ts4, BIST_RUN_TO_COLLAR1_ts2, 
       BIST_RUN_TO_COLLAR0_ts5, BIST_RUN_TO_COLLAR1_ts3, 
       BIST_RUN_TO_COLLAR2_ts2, BIST_RUN_TO_COLLAR3_ts2, 
       BIST_RUN_TO_COLLAR4_ts2, BIST_RUN_TO_COLLAR5_ts2, 
       BIST_RUN_TO_COLLAR6_ts2, BIST_RUN_TO_COLLAR7_ts2, 
       BIST_RUN_TO_COLLAR8_ts2, BIST_RUN_TO_COLLAR9_ts2, 
       BIST_RUN_TO_COLLAR10_ts2, BIST_RUN_TO_COLLAR11_ts2, 
       BIST_RUN_TO_COLLAR12_ts2, BIST_RUN_TO_COLLAR13_ts2, 
       BIST_RUN_TO_COLLAR14_ts2, BIST_RUN_TO_COLLAR15_ts2, 
       BIST_RUN_TO_COLLAR16_ts2, BIST_RUN_TO_COLLAR17_ts2, 
       BIST_RUN_TO_COLLAR18_ts2, BIST_RUN_TO_COLLAR19_ts2, 
       BIST_RUN_TO_COLLAR20_ts1, BIST_RUN_TO_COLLAR21_ts1, 
       BIST_RUN_TO_COLLAR22_ts1, BIST_RUN_TO_COLLAR23_ts1, 
       BIST_RUN_TO_COLLAR24_ts1, BIST_RUN_TO_COLLAR25_ts1, 
       BIST_RUN_TO_COLLAR26_ts1, BIST_RUN_TO_COLLAR27_ts1, 
       BIST_RUN_TO_COLLAR28_ts1, BIST_RUN_TO_COLLAR29_ts1, 
       BIST_RUN_TO_COLLAR30_ts1, BIST_RUN_TO_COLLAR31_ts1, 
       BIST_RUN_TO_COLLAR0_ts6, BIST_RUN_TO_COLLAR1_ts4, 
       BIST_RUN_TO_COLLAR0_ts7, BIST_RUN_TO_COLLAR1_ts5, 
       BIST_RUN_TO_COLLAR2_ts3, BIST_RUN_TO_COLLAR3_ts3, 
       BIST_RUN_TO_COLLAR4_ts3, BIST_RUN_TO_COLLAR5_ts3, 
       BIST_RUN_TO_COLLAR6_ts3, BIST_RUN_TO_COLLAR7_ts3, 
       BIST_RUN_TO_COLLAR0_ts8, BIST_RUN_TO_COLLAR1_ts6, 
       BIST_RUN_TO_COLLAR2_ts4, BIST_RUN_TO_COLLAR0_ts9, 
       BIST_RUN_TO_COLLAR1_ts7, BIST_RUN_TO_COLLAR2_ts5, 
       BIST_RUN_TO_COLLAR3_ts4, BIST_RUN_TO_COLLAR4_ts4, 
       BIST_RUN_TO_COLLAR5_ts4, BIST_RUN_TO_COLLAR6_ts4, 
       BIST_RUN_TO_COLLAR7_ts4, BIST_RUN_TO_COLLAR8_ts3, 
       BIST_RUN_TO_COLLAR9_ts3, BIST_RUN_TO_COLLAR10_ts3, 
       BIST_RUN_TO_COLLAR11_ts3, BIST_RUN_TO_COLLAR12_ts3, 
       BIST_RUN_TO_COLLAR13_ts3, BIST_RUN_TO_COLLAR14_ts3, 
       BIST_RUN_TO_COLLAR15_ts3, BIST_RUN_TO_COLLAR16_ts3, 
       BIST_RUN_TO_COLLAR17_ts3, BIST_RUN_TO_COLLAR18_ts3, 
       BIST_RUN_TO_COLLAR19_ts3, BIST_RUN_TO_COLLAR20_ts2, 
       BIST_RUN_TO_COLLAR21_ts2, BIST_RUN_TO_COLLAR22_ts2, 
       BIST_RUN_TO_COLLAR23_ts2, BIST_RUN_TO_COLLAR24_ts2, 
       BIST_RUN_TO_COLLAR25_ts2, BIST_RUN_TO_COLLAR26_ts2, 
       BIST_RUN_TO_COLLAR27_ts2, BIST_RUN_TO_COLLAR28_ts2, 
       BIST_RUN_TO_COLLAR29_ts2, BIST_RUN_TO_COLLAR30_ts2, 
       BIST_RUN_TO_COLLAR31_ts2, BIST_RUN_TO_COLLAR0_ts10, 
       BIST_RUN_TO_COLLAR1_ts8, BIST_RUN_TO_COLLAR2_ts6, 
       BIST_RUN_TO_COLLAR3_ts5, BIST_RUN_TO_COLLAR4_ts5, 
       BIST_RUN_TO_COLLAR5_ts5, BIST_RUN_TO_COLLAR6_ts5, 
       BIST_RUN_TO_COLLAR7_ts5, BIST_SHADOW_READENABLE, BIST_SHADOW_READADDRESS, 
       BIST_CONWRITE_ROWADDRESS, BIST_CONWRITE_ENABLE, BIST_CONREAD_ROWADDRESS, 
       BIST_CONREAD_COLUMNADDRESS, BIST_CONREAD_ENABLE, 
       BIST_TESTDATA_SELECT_TO_COLLAR, BIST_TESTDATA_SELECT_TO_COLLAR_ts1, 
       BIST_TESTDATA_SELECT_TO_COLLAR_ts2, BIST_TESTDATA_SELECT_TO_COLLAR_ts3, 
       BIST_TESTDATA_SELECT_TO_COLLAR_ts4, BIST_TESTDATA_SELECT_TO_COLLAR_ts5, 
       BIST_TESTDATA_SELECT_TO_COLLAR_ts6, BIST_TESTDATA_SELECT_TO_COLLAR_ts7, 
       BIST_TESTDATA_SELECT_TO_COLLAR_ts8, BIST_TESTDATA_SELECT_TO_COLLAR_ts9, 
       BIST_TESTDATA_SELECT_TO_COLLAR_ts10, BIST_ON_TO_COLLAR, 
       BIST_ON_TO_COLLAR_ts1, BIST_ON_TO_COLLAR_ts2, BIST_ON_TO_COLLAR_ts3, 
       BIST_ON_TO_COLLAR_ts4, BIST_ON_TO_COLLAR_ts5, BIST_ON_TO_COLLAR_ts6, 
       BIST_ON_TO_COLLAR_ts7, BIST_ON_TO_COLLAR_ts8, BIST_ON_TO_COLLAR_ts9, 
       BIST_ON_TO_COLLAR_ts10, BIST_SHIFT_COLLAR, BIST_SHIFT_COLLAR_ts1, 
       BIST_SHIFT_COLLAR_ts2, BIST_SHIFT_COLLAR_ts3, BIST_SHIFT_COLLAR_ts4, 
       BIST_SHIFT_COLLAR_ts5, BIST_SHIFT_COLLAR_ts6, BIST_SHIFT_COLLAR_ts7, 
       BIST_SHIFT_COLLAR_ts8, BIST_SHIFT_COLLAR_ts9, BIST_SHIFT_COLLAR_ts10, 
       BIST_COLLAR_SETUP, BIST_COLLAR_SETUP_ts1, BIST_COLLAR_SETUP_ts2, 
       BIST_COLLAR_SETUP_ts3, BIST_COLLAR_SETUP_ts4, BIST_COLLAR_SETUP_ts5, 
       BIST_COLLAR_SETUP_ts6, BIST_COLLAR_SETUP_ts7, BIST_COLLAR_SETUP_ts8, 
       BIST_COLLAR_SETUP_ts9, BIST_COLLAR_SETUP_ts10, BIST_CLEAR_DEFAULT, 
       BIST_CLEAR_DEFAULT_ts1, BIST_CLEAR_DEFAULT_ts2, BIST_CLEAR_DEFAULT_ts3, 
       BIST_CLEAR_DEFAULT_ts4, BIST_CLEAR_DEFAULT_ts5, BIST_CLEAR_DEFAULT_ts6, 
       BIST_CLEAR_DEFAULT_ts7, BIST_CLEAR_DEFAULT_ts8, BIST_CLEAR_DEFAULT_ts9, 
       BIST_CLEAR_DEFAULT_ts10, BIST_CLEAR, BIST_CLEAR_ts1, BIST_CLEAR_ts2, 
       BIST_CLEAR_ts3, BIST_CLEAR_ts4, BIST_CLEAR_ts5, BIST_CLEAR_ts6, 
       BIST_CLEAR_ts7, BIST_CLEAR_ts8, BIST_CLEAR_ts9, BIST_CLEAR_ts10, 
       BIST_COLLAR_OPSET_SELECT, BIST_COLLAR_OPSET_SELECT_ts1, 
       BIST_COLLAR_OPSET_SELECT_ts2, BIST_COLLAR_OPSET_SELECT_ts3, 
       BIST_COLLAR_OPSET_SELECT_ts4, BIST_COLLAR_OPSET_SELECT_ts5, 
       BIST_COLLAR_OPSET_SELECT_ts6, BIST_COLLAR_OPSET_SELECT_ts7, 
       BIST_COLLAR_OPSET_SELECT_ts8, BIST_COLLAR_OPSET_SELECT_ts9, 
       BIST_COLLAR_HOLD, FREEZE_STOP_ERROR, ERROR_CNT_ZERO, 
       BIST_COLLAR_HOLD_ts1, FREEZE_STOP_ERROR_ts1, ERROR_CNT_ZERO_ts1, 
       BIST_COLLAR_HOLD_ts2, FREEZE_STOP_ERROR_ts2, ERROR_CNT_ZERO_ts2, 
       BIST_COLLAR_HOLD_ts3, FREEZE_STOP_ERROR_ts3, ERROR_CNT_ZERO_ts3, 
       BIST_COLLAR_HOLD_ts4, FREEZE_STOP_ERROR_ts4, ERROR_CNT_ZERO_ts4, 
       BIST_COLLAR_HOLD_ts5, FREEZE_STOP_ERROR_ts5, ERROR_CNT_ZERO_ts5, 
       BIST_COLLAR_HOLD_ts6, FREEZE_STOP_ERROR_ts6, ERROR_CNT_ZERO_ts6, 
       BIST_COLLAR_HOLD_ts7, FREEZE_STOP_ERROR_ts7, ERROR_CNT_ZERO_ts7, 
       BIST_COLLAR_HOLD_ts8, FREEZE_STOP_ERROR_ts8, ERROR_CNT_ZERO_ts8, 
       BIST_COLLAR_HOLD_ts9, FREEZE_STOP_ERROR_ts9, ERROR_CNT_ZERO_ts9, 
       BIST_COLLAR_HOLD_ts10, FREEZE_STOP_ERROR_ts10, ERROR_CNT_ZERO_ts10, 
       MBISTPG_RESET_REG_SETUP2, MBISTPG_RESET_REG_SETUP2_ts1, 
       MBISTPG_RESET_REG_SETUP2_ts2, MBISTPG_RESET_REG_SETUP2_ts3, 
       MBISTPG_RESET_REG_SETUP2_ts4, MBISTPG_RESET_REG_SETUP2_ts5, 
       MBISTPG_RESET_REG_SETUP2_ts6, MBISTPG_RESET_REG_SETUP2_ts7, 
       MBISTPG_RESET_REG_SETUP2_ts8, MBISTPG_RESET_REG_SETUP2_ts9, 
       MBISTPG_RESET_REG_SETUP2_ts10, hlp_fwd_apr_rtl_tessent_mbist_bap_inst_so, 
       tck_select, MBISTPG_STABLE, MBISTPG_STABLE_ts1, MBISTPG_STABLE_ts2, 
       MBISTPG_STABLE_ts3, MBISTPG_STABLE_ts4, MBISTPG_STABLE_ts5, 
       MBISTPG_STABLE_ts6, MBISTPG_STABLE_ts7, MBISTPG_STABLE_ts8, 
       MBISTPG_STABLE_ts9, MBISTPG_STABLE_ts10, ijtag_so, bisr_so_pd_vinf_ts1, 
       ram_row_0_col_0_bisr_inst_SO, ram_row_0_col_0_bisr_inst_SO_ts1, 
       trigger_post, trigger_array, mbistpg_select_common_algo_o, select_rf, 
       select_sram, pass, sys_test_done_clk, sys_test_pass_clk, complete, busy, 
       sync_reset_clk_reset_bypass_mux_o, 
       Intel_reset_sync_polarity_clk_inverter_o1, sync_reset_clk_o, 
       sync_reset_clk_o_ts1;
  wire [6:0] mbistpg_algo_sel_o, ALGO_SEL_REG, ALGO_SEL_REG_ts1, 
             ALGO_SEL_REG_ts2, ALGO_SEL_REG_ts3, ALGO_SEL_REG_ts4, 
             ALGO_SEL_REG_ts5, ALGO_SEL_REG_ts6, ALGO_SEL_REG_ts7, 
             ALGO_SEL_REG_ts8, ALGO_SEL_REG_ts9, ALGO_SEL_REG_ts10;
`include "hlp_fwd_apr.VISA_IT.hlp_fwd_apr.wires.sv" // Auto Included by VISA IT - *** Do not modify this line ***
logic latch_mem_fuses;
assign latch_mem_fuses = fdfx_jta_force_latch_mem_fuses | fscan_clkgenctrlen[0];

hlp_pkg::imn_broadcast_t broadcast_struct;
hlp_pkg::imn_broadcast_t local_broadcast;
logic local_rst_n;
logic sram_isol_en;

assign broadcast_struct = i_broadcast;
assign avisa_unit_id_p1 = fvisa_unit_id + 9'd1;

ctech_lib_mux_2to1 reset_scan_mux_mem_rst
  (.d2 (broadcast_struct.mem_rst_b),
   .d1 (fscan_byprst_b),
   .s (fscan_rstbypen),
   .o (local_broadcast.mem_rst_b));

ctech_lib_mux_2to1 reset_scan_mux_fuse_rst
  (.d2 (broadcast_struct.fuse_rst_b),
   .d1 (fscan_byprst_b),
   .s (fscan_rstbypen),
   .o (local_broadcast.fuse_rst_b));

ctech_lib_mux_2to1 reset_scan_mux_rst
  (.d2 (rst_n),
   .d1 (fscan_byprst_b),
   .s (fscan_rstbypen),
   .o (local_rst_n));

hlp_tieoff_0 sram_isol_en_b_tieoff_0
   (.out (sram_isol_en));

logic fet_ack_b_from_fl;
/*AUTOLOGIC*/
// Beginning of automatic wires (for undeclared instantiated-module outputs)
logic [`HLP_FWD_ARP_USED_FROM_MEM_WIDTH-1:0] frm_arp_used;// From u_fwd_apr_rf_mems of hlp_fwd_apr_rf_mems.v
logic [`HLP_FWD_EGRESS_MST_TABLE_FROM_MEM_WIDTH-1:0] frm_egress_mst_table;// From u_fwd_apr_sram_mems of hlp_fwd_apr_sram_mems.v
logic [`HLP_FWD_EGRESS_VID_TABLE_FROM_MEM_WIDTH-1:0] frm_egress_vid_table;// From u_fwd_apr_sram_mems of hlp_fwd_apr_sram_mems.v
logic [`HLP_FWD_FLOOD_GLORT_FROM_MEM_WIDTH-1:0] frm_flood_glort;// From u_fwd_apr_sram_mems of hlp_fwd_apr_sram_mems.v
logic [`HLP_FWD_FWDPORT_CFG2_FROM_MEM_WIDTH-1:0] frm_fwdport_cfg2;// From u_fwd_apr_sram_mems of hlp_fwd_apr_sram_mems.v
logic [`HLP_FWD_GLORT_DEST_TABLE_FROM_MEM_WIDTH-1:0] frm_glort_dest_table;// From u_fwd_apr_sram_mems of hlp_fwd_apr_sram_mems.v
logic [`HLP_FWD_INGRESS_MST_TABLE_FROM_MEM_WIDTH-1:0] frm_ingress_mst_table;// From u_fwd_apr_sram_mems of hlp_fwd_apr_sram_mems.v
logic [`HLP_FWD_INGRESS_VID_TABLE_FROM_MEM_WIDTH-1:0] frm_ingress_vid_table;// From u_fwd_apr_sram_mems of hlp_fwd_apr_sram_mems.v
logic [`HLP_FWD_MA_AGING_TABLE_FROM_MEM_WIDTH-1:0] frm_ma_aging_table;// From u_fwd_apr_sram_mems of hlp_fwd_apr_sram_mems.v
logic [`HLP_FWD_MA_DIRTY_TABLE_FROM_MEM_WIDTH-1:0] frm_ma_dirty_table;// From u_fwd_apr_sram_mems of hlp_fwd_apr_sram_mems.v
logic [1:0] [`HLP_FWD_ARP_TABLE_TO_MEM_WIDTH-1:0]   tom_arp_table;// From u_fwd_apr_func_logic of hlp_fwd_apr_func_logic.v
logic [1:0] [`HLP_FWD_ARP_TABLE_FROM_MEM_WIDTH-1:0] frm_arp_table; // fixed by mem_gen script
logic [`HLP_FWD_ARP_USED_TO_MEM_WIDTH-1:0] tom_arp_used;// From u_fwd_apr_func_logic of hlp_fwd_apr_func_logic.v
logic [`HLP_FWD_EGRESS_MST_TABLE_TO_MEM_WIDTH-1:0] tom_egress_mst_table;// From u_fwd_apr_func_logic of hlp_fwd_apr_func_logic.v
logic [`HLP_FWD_EGRESS_VID_TABLE_TO_MEM_WIDTH-1:0] tom_egress_vid_table;// From u_fwd_apr_func_logic of hlp_fwd_apr_func_logic.v
logic [`HLP_FWD_FLOOD_GLORT_TO_MEM_WIDTH-1:0] tom_flood_glort;// From u_fwd_apr_func_logic of hlp_fwd_apr_func_logic.v
logic [`HLP_FWD_FWDPORT_CFG2_TO_MEM_WIDTH-1:0] tom_fwdport_cfg2;// From u_fwd_apr_func_logic of hlp_fwd_apr_func_logic.v
logic [`HLP_FWD_GLORT_DEST_TABLE_TO_MEM_WIDTH-1:0] tom_glort_dest_table;// From u_fwd_apr_func_logic of hlp_fwd_apr_func_logic.v
logic [`HLP_FWD_INGRESS_MST_TABLE_TO_MEM_WIDTH-1:0] tom_ingress_mst_table;// From u_fwd_apr_func_logic of hlp_fwd_apr_func_logic.v
logic [`HLP_FWD_INGRESS_VID_TABLE_TO_MEM_WIDTH-1:0] tom_ingress_vid_table;// From u_fwd_apr_func_logic of hlp_fwd_apr_func_logic.v
logic [`HLP_FWD_MA_AGING_TABLE_TO_MEM_WIDTH-1:0] tom_ma_aging_table;// From u_fwd_apr_func_logic of hlp_fwd_apr_func_logic.v
logic [`HLP_FWD_MA_DIRTY_TABLE_TO_MEM_WIDTH-1:0] tom_ma_dirty_table;// From u_fwd_apr_func_logic of hlp_fwd_apr_func_logic.v
logic [9:0] [`HLP_FWD_MA_TABLE_HASH_TO_MEM_WIDTH-1:0]   tom_ma_table_hash;// From u_fwd_apr_func_logic of hlp_fwd_apr_func_logic.v
logic [9:0] [`HLP_FWD_MA_TABLE_HASH_FROM_MEM_WIDTH-1:0] frm_ma_table_hash; // fixed by mem_gen script
logic [1:0] [`HLP_FWD_MA_TABLE_RAM_TO_MEM_WIDTH-1:0]   tom_ma_table_ram;// From u_fwd_apr_func_logic of hlp_fwd_apr_func_logic.v
logic [1:0] [`HLP_FWD_MA_TABLE_RAM_FROM_MEM_WIDTH-1:0] frm_ma_table_ram; // fixed by mem_gen script
logic [3:0] [`HLP_FWD_MA_TABLE_TCAM_TO_TCAM_WIDTH-1:0]   tom_ma_table_tcam;// From u_fwd_apr_func_logic of hlp_fwd_apr_func_logic.v
logic [3:0] [`HLP_FWD_MA_TABLE_TCAM_FROM_TCAM_WIDTH-1:0] frm_ma_table_tcam; // fixed by mem_gen script
// End of automatics

/*
  hlp_fwd_apr_sram_mems AUTO_TEMPLATE
  hlp_fwd_apr_rf_mems AUTO_TEMPLATE
  hlp_fwd_apr_tcam_mems AUTO_TEMPLATE
 (
  .fwd_\(.*\)_\([0-9]+\)_from_mem (frm_\1[\2][]),
  .fwd_\(.*\)_\([0-9]+\)_to_mem   (tom_\1[\2][]),
  .fwd_\(.*\)_from_mem              (frm_\1[]),
  .fwd_\(.*\)_to_mem                (tom_\1[]),
  .fwd_\(.*\)_\([0-9]+\)_from_tcam (frm_\1[\2][]),
  .fwd_\(.*\)_\([0-9]+\)_to_tcam   (tom_\1[\2][]),
  .fwd_\(.*\)_from_tcam              (frm_\1[]),
  .fwd_\(.*\)_to_tcam                (tom_\1[]),
  .fary_post_cntrlr_select_.*_sram('1),
  .fary_post_cntrlr_select_pm_sram(post_cntrlr_select_sram_from_apr),
  .fary_post_cntrlr_select_fwd_sram(post_cntrlr_select_sram_from_apr),
  .fary_post_cntrlr_select_sched_sram(post_cntrlr_select_sram_from_apr),
  .fary_trigger_post_pm_sram (trigger_post_from_apr),
  .post_mux_ctrl ('0),
  .fary_trigger_post_sram ('0),
  .fary_trigger_post_rf ('0),
  .aary_post_complete_sram (),
  .aary_post_pass_sram (),
  .aary_post_complete_rf (),
  .aary_post_pass_rf (),
  .fary_isolation_control_in (isol_en_b),
  .fary_pwren_b_sram  (fet_ack_b_from_fl),
  .fscan_clkgenctrl   (fscan_clkgenctrl[0]),
  .fscan_clkgenctrlen (latch_mem_fuses),
  .ip_reset_b (local_broadcast.mem_rst_b),
  .car_raw_lan_power_good_with_byprst (local_broadcast.fuse_rst_b) );
*/
logic aary_pwren_b_sram;
logic trigger_post_to_apr, post_complete_to_apr, post_pass_to_apr;
logic post_complete_from_apr, post_pass_from_apr, trigger_post_from_apr;
logic [2:0] post_cntrlr_select_sram_from_apr;
logic fary_trigger_post_fwd_sram, aary_post_complete_fwd_sram, aary_post_pass_fwd_sram;
ctech_lib_doublesync_rstb  #(.WIDTH(1))  u_trigger_post
  (.clk(clk_ts1), .rstb(local_broadcast.mem_rst_b), .d(fary_trigger_post), .o(fary_trigger_post_fwd_sram));
assign trigger_post_to_apr          = fary_trigger_post_fwd_sram;
assign aary_post_complete_fwd_sram  = post_complete_from_apr;
assign aary_post_pass_fwd_sram      = post_pass_from_apr;
hlp_fwd_apr_sram_mems u_fwd_apr_sram_mems
(// Manual connections
.fary_trigger_post_fwd_sram(trigger_post_from_apr),
.aary_post_complete_fwd_sram(post_complete_to_apr),
.aary_post_pass_fwd_sram(post_pass_to_apr),
 .aary_pwren_b_sram(aary_pwren_b_sram),
 /*AUTOINST*/
 // Outputs
 .aary_post_complete_sram               (),                      // Templated
 .aary_post_pass_sram                   (),                      // Templated
 .fwd_arp_table_0_from_mem              (frm_arp_table[0][`HLP_FWD_ARP_TABLE_FROM_MEM_WIDTH-1:0]), // Templated
 .fwd_arp_table_1_from_mem              (frm_arp_table[1][`HLP_FWD_ARP_TABLE_FROM_MEM_WIDTH-1:0]), // Templated
 .fwd_egress_mst_table_from_mem         (frm_egress_mst_table[`HLP_FWD_EGRESS_MST_TABLE_FROM_MEM_WIDTH-1:0]), // Templated
 .fwd_egress_vid_table_from_mem         (frm_egress_vid_table[`HLP_FWD_EGRESS_VID_TABLE_FROM_MEM_WIDTH-1:0]), // Templated
 .fwd_flood_glort_from_mem              (frm_flood_glort[`HLP_FWD_FLOOD_GLORT_FROM_MEM_WIDTH-1:0]), // Templated
 .fwd_fwdport_cfg2_from_mem             (frm_fwdport_cfg2[`HLP_FWD_FWDPORT_CFG2_FROM_MEM_WIDTH-1:0]), // Templated
 .fwd_glort_dest_table_from_mem         (frm_glort_dest_table[`HLP_FWD_GLORT_DEST_TABLE_FROM_MEM_WIDTH-1:0]), // Templated
 .fwd_ingress_mst_table_from_mem        (frm_ingress_mst_table[`HLP_FWD_INGRESS_MST_TABLE_FROM_MEM_WIDTH-1:0]), // Templated
 .fwd_ingress_vid_table_from_mem        (frm_ingress_vid_table[`HLP_FWD_INGRESS_VID_TABLE_FROM_MEM_WIDTH-1:0]), // Templated
 .fwd_ma_aging_table_from_mem           (frm_ma_aging_table[`HLP_FWD_MA_AGING_TABLE_FROM_MEM_WIDTH-1:0]), // Templated
 .fwd_ma_dirty_table_from_mem           (frm_ma_dirty_table[`HLP_FWD_MA_DIRTY_TABLE_FROM_MEM_WIDTH-1:0]), // Templated
 .fwd_ma_table_hash_0_from_mem          (frm_ma_table_hash[0][`HLP_FWD_MA_TABLE_HASH_FROM_MEM_WIDTH-1:0]), // Templated
 .fwd_ma_table_hash_1_from_mem          (frm_ma_table_hash[1][`HLP_FWD_MA_TABLE_HASH_FROM_MEM_WIDTH-1:0]), // Templated
 .fwd_ma_table_hash_2_from_mem          (frm_ma_table_hash[2][`HLP_FWD_MA_TABLE_HASH_FROM_MEM_WIDTH-1:0]), // Templated
 .fwd_ma_table_hash_3_from_mem          (frm_ma_table_hash[3][`HLP_FWD_MA_TABLE_HASH_FROM_MEM_WIDTH-1:0]), // Templated
 .fwd_ma_table_hash_4_from_mem          (frm_ma_table_hash[4][`HLP_FWD_MA_TABLE_HASH_FROM_MEM_WIDTH-1:0]), // Templated
 .fwd_ma_table_hash_5_from_mem          (frm_ma_table_hash[5][`HLP_FWD_MA_TABLE_HASH_FROM_MEM_WIDTH-1:0]), // Templated
 .fwd_ma_table_hash_6_from_mem          (frm_ma_table_hash[6][`HLP_FWD_MA_TABLE_HASH_FROM_MEM_WIDTH-1:0]), // Templated
 .fwd_ma_table_hash_7_from_mem          (frm_ma_table_hash[7][`HLP_FWD_MA_TABLE_HASH_FROM_MEM_WIDTH-1:0]), // Templated
 .fwd_ma_table_hash_8_from_mem          (frm_ma_table_hash[8][`HLP_FWD_MA_TABLE_HASH_FROM_MEM_WIDTH-1:0]), // Templated
 .fwd_ma_table_hash_9_from_mem          (frm_ma_table_hash[9][`HLP_FWD_MA_TABLE_HASH_FROM_MEM_WIDTH-1:0]), // Templated
 .fwd_ma_table_ram_0_from_mem           (frm_ma_table_ram[0][`HLP_FWD_MA_TABLE_RAM_FROM_MEM_WIDTH-1:0]), // Templated
 .fwd_ma_table_ram_1_from_mem           (frm_ma_table_ram[1][`HLP_FWD_MA_TABLE_RAM_FROM_MEM_WIDTH-1:0]), // Templated
 // Inputs
 .fary_post_cntrlr_select_fwd_sram      (post_cntrlr_select_sram_from_apr), // Templated
 .DFTMASK                               (DFTMASK),
 .DFTSHIFTEN                            (DFTSHIFTEN),
 .DFT_AFD_RESET_B                       (DFT_AFD_RESET_B),
 .DFT_ARRAY_FREEZE                      (DFT_ARRAY_FREEZE),
 .clk                                   (clk_ts1),
 .fary_ffuse_hdusplr_trim               (fary_ffuse_hdusplr_trim[17-1:0]),
 .fary_ffuse_hduspsr_trim               (fary_ffuse_hduspsr_trim[17-1:0]),
 .fary_ffuse_sram_sleep                 (fary_ffuse_sram_sleep[1:0]),
 .fary_isolation_control_in             (isol_en_b),             // Templated
 .fary_output_reset                     (fary_output_reset),
 .fary_pwren_b_sram                     (fet_ack_b_from_fl),     // Templated
 .fary_trigger_post_sram                ('0),                    // Templated
 .fscan_clkungate                       (fscan_clkungate),
 .fscan_ram_bypsel_sram                 (fscan_ram_bypsel_sram),
 .fscan_ram_init_en                     (fscan_ram_init_en),
 .fscan_ram_init_val                    (fscan_ram_init_val),
 .fscan_ram_rdis_b                      (fscan_ram_rdis_b),
 .fscan_ram_wdis_b                      (fscan_ram_wdis_b),
 .fsta_dfxact_afd                       (fsta_dfxact_afd),
 .fwd_arp_table_0_to_mem                (tom_arp_table[0][`HLP_FWD_ARP_TABLE_TO_MEM_WIDTH-1:0]), // Templated
 .fwd_arp_table_1_to_mem                (tom_arp_table[1][`HLP_FWD_ARP_TABLE_TO_MEM_WIDTH-1:0]), // Templated
 .fwd_egress_mst_table_to_mem           (tom_egress_mst_table[`HLP_FWD_EGRESS_MST_TABLE_TO_MEM_WIDTH-1:0]), // Templated
 .fwd_egress_vid_table_to_mem           (tom_egress_vid_table[`HLP_FWD_EGRESS_VID_TABLE_TO_MEM_WIDTH-1:0]), // Templated
 .fwd_flood_glort_to_mem                (tom_flood_glort[`HLP_FWD_FLOOD_GLORT_TO_MEM_WIDTH-1:0]), // Templated
 .fwd_fwdport_cfg2_to_mem               (tom_fwdport_cfg2[`HLP_FWD_FWDPORT_CFG2_TO_MEM_WIDTH-1:0]), // Templated
 .fwd_glort_dest_table_to_mem           (tom_glort_dest_table[`HLP_FWD_GLORT_DEST_TABLE_TO_MEM_WIDTH-1:0]), // Templated
 .fwd_ingress_mst_table_to_mem          (tom_ingress_mst_table[`HLP_FWD_INGRESS_MST_TABLE_TO_MEM_WIDTH-1:0]), // Templated
 .fwd_ingress_vid_table_to_mem          (tom_ingress_vid_table[`HLP_FWD_INGRESS_VID_TABLE_TO_MEM_WIDTH-1:0]), // Templated
 .fwd_ma_aging_table_to_mem             (tom_ma_aging_table[`HLP_FWD_MA_AGING_TABLE_TO_MEM_WIDTH-1:0]), // Templated
 .fwd_ma_dirty_table_to_mem             (tom_ma_dirty_table[`HLP_FWD_MA_DIRTY_TABLE_TO_MEM_WIDTH-1:0]), // Templated
 .fwd_ma_table_hash_0_to_mem            (tom_ma_table_hash[0][`HLP_FWD_MA_TABLE_HASH_TO_MEM_WIDTH-1:0]), // Templated
 .fwd_ma_table_hash_1_to_mem            (tom_ma_table_hash[1][`HLP_FWD_MA_TABLE_HASH_TO_MEM_WIDTH-1:0]), // Templated
 .fwd_ma_table_hash_2_to_mem            (tom_ma_table_hash[2][`HLP_FWD_MA_TABLE_HASH_TO_MEM_WIDTH-1:0]), // Templated
 .fwd_ma_table_hash_3_to_mem            (tom_ma_table_hash[3][`HLP_FWD_MA_TABLE_HASH_TO_MEM_WIDTH-1:0]), // Templated
 .fwd_ma_table_hash_4_to_mem            (tom_ma_table_hash[4][`HLP_FWD_MA_TABLE_HASH_TO_MEM_WIDTH-1:0]), // Templated
 .fwd_ma_table_hash_5_to_mem            (tom_ma_table_hash[5][`HLP_FWD_MA_TABLE_HASH_TO_MEM_WIDTH-1:0]), // Templated
 .fwd_ma_table_hash_6_to_mem            (tom_ma_table_hash[6][`HLP_FWD_MA_TABLE_HASH_TO_MEM_WIDTH-1:0]), // Templated
 .fwd_ma_table_hash_7_to_mem            (tom_ma_table_hash[7][`HLP_FWD_MA_TABLE_HASH_TO_MEM_WIDTH-1:0]), // Templated
 .fwd_ma_table_hash_8_to_mem            (tom_ma_table_hash[8][`HLP_FWD_MA_TABLE_HASH_TO_MEM_WIDTH-1:0]), // Templated
 .fwd_ma_table_hash_9_to_mem            (tom_ma_table_hash[9][`HLP_FWD_MA_TABLE_HASH_TO_MEM_WIDTH-1:0]), // Templated
 .fwd_ma_table_ram_0_to_mem             (tom_ma_table_ram[0][`HLP_FWD_MA_TABLE_RAM_TO_MEM_WIDTH-1:0]), // Templated
 .fwd_ma_table_ram_1_to_mem             (tom_ma_table_ram[1][`HLP_FWD_MA_TABLE_RAM_TO_MEM_WIDTH-1:0]), // Templated
 .ip_reset_b                            (local_broadcast.mem_rst_b), // Templated
 .post_mux_ctrl                         ('0),                    // Templated
 .pwr_mgmt_in_sram                      (pwr_mgmt_in_sram[6-1:0]), .BIST_SETUP(BIST_SETUP[0]), .BIST_SETUP_ts1(BIST_SETUP[1]), 
 .BIST_SETUP_ts2(BIST_SETUP[2]), .to_interfaces_tck(to_interfaces_tck), 
 .mcp_bounding_to_en(mcp_bounding_to_en), .scan_to_en(scan_to_en), 
 .memory_bypass_to_en(memory_bypass_to_en), .GO_ID_REG_SEL(GO_ID_REG_SEL_ts1), 
 .GO_ID_REG_SEL_ts1(GO_ID_REG_SEL_ts2), .GO_ID_REG_SEL_ts2(GO_ID_REG_SEL_ts3), 
 .GO_ID_REG_SEL_ts3(GO_ID_REG_SEL_ts4), .GO_ID_REG_SEL_ts4(GO_ID_REG_SEL_ts5), 
 .GO_ID_REG_SEL_ts5(GO_ID_REG_SEL_ts6), .GO_ID_REG_SEL_ts6(GO_ID_REG_SEL_ts7), 
 .GO_ID_REG_SEL_ts7(GO_ID_REG_SEL_ts8), .GO_ID_REG_SEL_ts8(GO_ID_REG_SEL_ts9), 
 .BIST_CLEAR_BIRA(BIST_CLEAR_BIRA_ts1), .BIST_COLLAR_DIAG_EN(BIST_COLLAR_DIAG_EN_ts1), 
 .BIST_COLLAR_BIRA_EN(BIST_COLLAR_BIRA_EN_ts1), .PriorityColumn(PriorityColumn_ts1), 
 .BIST_SHIFT_BIRA_COLLAR(BIST_SHIFT_BIRA_COLLAR_ts1), .BIST_CLEAR_BIRA_ts1(BIST_CLEAR_BIRA_ts2), 
 .BIST_COLLAR_DIAG_EN_ts1(BIST_COLLAR_DIAG_EN_ts2), .BIST_COLLAR_BIRA_EN_ts1(BIST_COLLAR_BIRA_EN_ts2), 
 .PriorityColumn_ts1(PriorityColumn_ts2), .BIST_SHIFT_BIRA_COLLAR_ts1(BIST_SHIFT_BIRA_COLLAR_ts2), 
 .BIST_CLEAR_BIRA_ts2(BIST_CLEAR_BIRA_ts3), .BIST_COLLAR_DIAG_EN_ts2(BIST_COLLAR_DIAG_EN_ts3), 
 .BIST_COLLAR_BIRA_EN_ts2(BIST_COLLAR_BIRA_EN_ts3), .PriorityColumn_ts2(PriorityColumn_ts3), 
 .BIST_SHIFT_BIRA_COLLAR_ts2(BIST_SHIFT_BIRA_COLLAR_ts3), 
 .BIST_CLEAR_BIRA_ts3(BIST_CLEAR_BIRA_ts4), .BIST_COLLAR_DIAG_EN_ts3(BIST_COLLAR_DIAG_EN_ts4), 
 .BIST_COLLAR_BIRA_EN_ts3(BIST_COLLAR_BIRA_EN_ts4), .PriorityColumn_ts3(PriorityColumn_ts4), 
 .BIST_SHIFT_BIRA_COLLAR_ts3(BIST_SHIFT_BIRA_COLLAR_ts4), 
 .BIST_CLEAR_BIRA_ts4(BIST_CLEAR_BIRA_ts5), .BIST_COLLAR_DIAG_EN_ts4(BIST_COLLAR_DIAG_EN_ts5), 
 .BIST_COLLAR_BIRA_EN_ts4(BIST_COLLAR_BIRA_EN_ts5), .PriorityColumn_ts4(PriorityColumn_ts5), 
 .BIST_SHIFT_BIRA_COLLAR_ts4(BIST_SHIFT_BIRA_COLLAR_ts5), 
 .BIST_CLEAR_BIRA_ts5(BIST_CLEAR_BIRA_ts6), .BIST_COLLAR_DIAG_EN_ts5(BIST_COLLAR_DIAG_EN_ts6), 
 .BIST_COLLAR_BIRA_EN_ts5(BIST_COLLAR_BIRA_EN_ts6), .PriorityColumn_ts5(PriorityColumn_ts6), 
 .BIST_SHIFT_BIRA_COLLAR_ts5(BIST_SHIFT_BIRA_COLLAR_ts6), 
 .BIST_CLEAR_BIRA_ts6(BIST_CLEAR_BIRA_ts7), .BIST_COLLAR_DIAG_EN_ts6(BIST_COLLAR_DIAG_EN_ts7), 
 .BIST_COLLAR_BIRA_EN_ts6(BIST_COLLAR_BIRA_EN_ts7), .PriorityColumn_ts6(PriorityColumn_ts7), 
 .BIST_SHIFT_BIRA_COLLAR_ts6(BIST_SHIFT_BIRA_COLLAR_ts7), 
 .BIST_CLEAR_BIRA_ts7(BIST_CLEAR_BIRA_ts8), .BIST_COLLAR_DIAG_EN_ts7(BIST_COLLAR_DIAG_EN_ts8), 
 .BIST_COLLAR_BIRA_EN_ts7(BIST_COLLAR_BIRA_EN_ts8), .PriorityColumn_ts7(PriorityColumn_ts8), 
 .BIST_SHIFT_BIRA_COLLAR_ts7(BIST_SHIFT_BIRA_COLLAR_ts8), 
 .BIST_CLEAR_BIRA_ts8(BIST_CLEAR_BIRA_ts9), .BIST_COLLAR_DIAG_EN_ts8(BIST_COLLAR_DIAG_EN_ts9), 
 .BIST_COLLAR_BIRA_EN_ts8(BIST_COLLAR_BIRA_EN_ts9), .PriorityColumn_ts8(PriorityColumn_ts9), 
 .BIST_SHIFT_BIRA_COLLAR_ts8(BIST_SHIFT_BIRA_COLLAR_ts9), 
 .CHECK_REPAIR_NEEDED(CHECK_REPAIR_NEEDED), .MEM0_BIST_COLLAR_SI(MEM0_BIST_COLLAR_SI_ts1), 
 .MEM1_BIST_COLLAR_SI(MEM1_BIST_COLLAR_SI), .MEM2_BIST_COLLAR_SI(MEM2_BIST_COLLAR_SI), 
 .MEM3_BIST_COLLAR_SI(MEM3_BIST_COLLAR_SI), .MEM4_BIST_COLLAR_SI(MEM4_BIST_COLLAR_SI), 
 .MEM5_BIST_COLLAR_SI(MEM5_BIST_COLLAR_SI), .MEM6_BIST_COLLAR_SI(MEM6_BIST_COLLAR_SI), 
 .MEM7_BIST_COLLAR_SI(MEM7_BIST_COLLAR_SI), .MEM8_BIST_COLLAR_SI(MEM8_BIST_COLLAR_SI), 
 .MEM9_BIST_COLLAR_SI(MEM9_BIST_COLLAR_SI), .MEM10_BIST_COLLAR_SI(MEM10_BIST_COLLAR_SI), 
 .MEM11_BIST_COLLAR_SI(MEM11_BIST_COLLAR_SI), .MEM12_BIST_COLLAR_SI(MEM12_BIST_COLLAR_SI), 
 .MEM13_BIST_COLLAR_SI(MEM13_BIST_COLLAR_SI), .MEM14_BIST_COLLAR_SI(MEM14_BIST_COLLAR_SI), 
 .MEM15_BIST_COLLAR_SI(MEM15_BIST_COLLAR_SI), .MEM16_BIST_COLLAR_SI(MEM16_BIST_COLLAR_SI), 
 .MEM17_BIST_COLLAR_SI(MEM17_BIST_COLLAR_SI), .MEM18_BIST_COLLAR_SI(MEM18_BIST_COLLAR_SI), 
 .MEM19_BIST_COLLAR_SI(MEM19_BIST_COLLAR_SI), .MEM0_BIST_COLLAR_SI_ts1(MEM0_BIST_COLLAR_SI_ts2), 
 .MEM1_BIST_COLLAR_SI_ts1(MEM1_BIST_COLLAR_SI_ts1), .MEM2_BIST_COLLAR_SI_ts1(MEM2_BIST_COLLAR_SI_ts1), 
 .MEM3_BIST_COLLAR_SI_ts1(MEM3_BIST_COLLAR_SI_ts1), .MEM4_BIST_COLLAR_SI_ts1(MEM4_BIST_COLLAR_SI_ts1), 
 .MEM5_BIST_COLLAR_SI_ts1(MEM5_BIST_COLLAR_SI_ts1), .MEM6_BIST_COLLAR_SI_ts1(MEM6_BIST_COLLAR_SI_ts1), 
 .MEM7_BIST_COLLAR_SI_ts1(MEM7_BIST_COLLAR_SI_ts1), .MEM8_BIST_COLLAR_SI_ts1(MEM8_BIST_COLLAR_SI_ts1), 
 .MEM9_BIST_COLLAR_SI_ts1(MEM9_BIST_COLLAR_SI_ts1), .MEM10_BIST_COLLAR_SI_ts1(MEM10_BIST_COLLAR_SI_ts1), 
 .MEM11_BIST_COLLAR_SI_ts1(MEM11_BIST_COLLAR_SI_ts1), 
 .MEM12_BIST_COLLAR_SI_ts1(MEM12_BIST_COLLAR_SI_ts1), 
 .MEM13_BIST_COLLAR_SI_ts1(MEM13_BIST_COLLAR_SI_ts1), 
 .MEM14_BIST_COLLAR_SI_ts1(MEM14_BIST_COLLAR_SI_ts1), 
 .MEM15_BIST_COLLAR_SI_ts1(MEM15_BIST_COLLAR_SI_ts1), 
 .MEM16_BIST_COLLAR_SI_ts1(MEM16_BIST_COLLAR_SI_ts1), 
 .MEM17_BIST_COLLAR_SI_ts1(MEM17_BIST_COLLAR_SI_ts1), 
 .MEM18_BIST_COLLAR_SI_ts1(MEM18_BIST_COLLAR_SI_ts1), 
 .MEM19_BIST_COLLAR_SI_ts1(MEM19_BIST_COLLAR_SI_ts1), .MEM20_BIST_COLLAR_SI(MEM20_BIST_COLLAR_SI), 
 .MEM21_BIST_COLLAR_SI(MEM21_BIST_COLLAR_SI), .MEM22_BIST_COLLAR_SI(MEM22_BIST_COLLAR_SI), 
 .MEM23_BIST_COLLAR_SI(MEM23_BIST_COLLAR_SI), .MEM24_BIST_COLLAR_SI(MEM24_BIST_COLLAR_SI), 
 .MEM25_BIST_COLLAR_SI(MEM25_BIST_COLLAR_SI), .MEM26_BIST_COLLAR_SI(MEM26_BIST_COLLAR_SI), 
 .MEM27_BIST_COLLAR_SI(MEM27_BIST_COLLAR_SI), .MEM28_BIST_COLLAR_SI(MEM28_BIST_COLLAR_SI), 
 .MEM29_BIST_COLLAR_SI(MEM29_BIST_COLLAR_SI), .MEM30_BIST_COLLAR_SI(MEM30_BIST_COLLAR_SI), 
 .MEM31_BIST_COLLAR_SI(MEM31_BIST_COLLAR_SI), .MEM0_BIST_COLLAR_SI_ts2(MEM0_BIST_COLLAR_SI_ts3), 
 .MEM0_BIST_COLLAR_SI_ts3(MEM0_BIST_COLLAR_SI_ts4), .MEM1_BIST_COLLAR_SI_ts2(MEM1_BIST_COLLAR_SI_ts2), 
 .MEM0_BIST_COLLAR_SI_ts4(MEM0_BIST_COLLAR_SI_ts5), .MEM1_BIST_COLLAR_SI_ts3(MEM1_BIST_COLLAR_SI_ts3), 
 .MEM2_BIST_COLLAR_SI_ts2(MEM2_BIST_COLLAR_SI_ts2), .MEM3_BIST_COLLAR_SI_ts2(MEM3_BIST_COLLAR_SI_ts2), 
 .MEM4_BIST_COLLAR_SI_ts2(MEM4_BIST_COLLAR_SI_ts2), .MEM5_BIST_COLLAR_SI_ts2(MEM5_BIST_COLLAR_SI_ts2), 
 .MEM6_BIST_COLLAR_SI_ts2(MEM6_BIST_COLLAR_SI_ts2), .MEM7_BIST_COLLAR_SI_ts2(MEM7_BIST_COLLAR_SI_ts2), 
 .MEM8_BIST_COLLAR_SI_ts2(MEM8_BIST_COLLAR_SI_ts2), .MEM9_BIST_COLLAR_SI_ts2(MEM9_BIST_COLLAR_SI_ts2), 
 .MEM10_BIST_COLLAR_SI_ts2(MEM10_BIST_COLLAR_SI_ts2), 
 .MEM11_BIST_COLLAR_SI_ts2(MEM11_BIST_COLLAR_SI_ts2), 
 .MEM12_BIST_COLLAR_SI_ts2(MEM12_BIST_COLLAR_SI_ts2), 
 .MEM13_BIST_COLLAR_SI_ts2(MEM13_BIST_COLLAR_SI_ts2), 
 .MEM14_BIST_COLLAR_SI_ts2(MEM14_BIST_COLLAR_SI_ts2), 
 .MEM15_BIST_COLLAR_SI_ts2(MEM15_BIST_COLLAR_SI_ts2), 
 .MEM16_BIST_COLLAR_SI_ts2(MEM16_BIST_COLLAR_SI_ts2), 
 .MEM17_BIST_COLLAR_SI_ts2(MEM17_BIST_COLLAR_SI_ts2), 
 .MEM18_BIST_COLLAR_SI_ts2(MEM18_BIST_COLLAR_SI_ts2), 
 .MEM19_BIST_COLLAR_SI_ts2(MEM19_BIST_COLLAR_SI_ts2), 
 .MEM20_BIST_COLLAR_SI_ts1(MEM20_BIST_COLLAR_SI_ts1), 
 .MEM21_BIST_COLLAR_SI_ts1(MEM21_BIST_COLLAR_SI_ts1), 
 .MEM22_BIST_COLLAR_SI_ts1(MEM22_BIST_COLLAR_SI_ts1), 
 .MEM23_BIST_COLLAR_SI_ts1(MEM23_BIST_COLLAR_SI_ts1), 
 .MEM24_BIST_COLLAR_SI_ts1(MEM24_BIST_COLLAR_SI_ts1), 
 .MEM25_BIST_COLLAR_SI_ts1(MEM25_BIST_COLLAR_SI_ts1), 
 .MEM26_BIST_COLLAR_SI_ts1(MEM26_BIST_COLLAR_SI_ts1), 
 .MEM27_BIST_COLLAR_SI_ts1(MEM27_BIST_COLLAR_SI_ts1), 
 .MEM28_BIST_COLLAR_SI_ts1(MEM28_BIST_COLLAR_SI_ts1), 
 .MEM29_BIST_COLLAR_SI_ts1(MEM29_BIST_COLLAR_SI_ts1), 
 .MEM30_BIST_COLLAR_SI_ts1(MEM30_BIST_COLLAR_SI_ts1), 
 .MEM31_BIST_COLLAR_SI_ts1(MEM31_BIST_COLLAR_SI_ts1), 
 .MEM0_BIST_COLLAR_SI_ts5(MEM0_BIST_COLLAR_SI_ts6), .MEM1_BIST_COLLAR_SI_ts4(MEM1_BIST_COLLAR_SI_ts4), 
 .MEM0_BIST_COLLAR_SI_ts6(MEM0_BIST_COLLAR_SI_ts7), .MEM1_BIST_COLLAR_SI_ts5(MEM1_BIST_COLLAR_SI_ts5), 
 .MEM2_BIST_COLLAR_SI_ts3(MEM2_BIST_COLLAR_SI_ts3), .MEM3_BIST_COLLAR_SI_ts3(MEM3_BIST_COLLAR_SI_ts3), 
 .MEM4_BIST_COLLAR_SI_ts3(MEM4_BIST_COLLAR_SI_ts3), .MEM5_BIST_COLLAR_SI_ts3(MEM5_BIST_COLLAR_SI_ts3), 
 .MEM6_BIST_COLLAR_SI_ts3(MEM6_BIST_COLLAR_SI_ts3), .MEM7_BIST_COLLAR_SI_ts3(MEM7_BIST_COLLAR_SI_ts3), 
 .MEM0_BIST_COLLAR_SI_ts7(MEM0_BIST_COLLAR_SI_ts8), .MEM1_BIST_COLLAR_SI_ts6(MEM1_BIST_COLLAR_SI_ts6), 
 .MEM2_BIST_COLLAR_SI_ts4(MEM2_BIST_COLLAR_SI_ts4), .MEM0_BIST_COLLAR_SI_ts8(MEM0_BIST_COLLAR_SI_ts9), 
 .MEM1_BIST_COLLAR_SI_ts7(MEM1_BIST_COLLAR_SI_ts7), .MEM2_BIST_COLLAR_SI_ts5(MEM2_BIST_COLLAR_SI_ts5), 
 .MEM3_BIST_COLLAR_SI_ts4(MEM3_BIST_COLLAR_SI_ts4), .MEM4_BIST_COLLAR_SI_ts4(MEM4_BIST_COLLAR_SI_ts4), 
 .MEM5_BIST_COLLAR_SI_ts4(MEM5_BIST_COLLAR_SI_ts4), .MEM6_BIST_COLLAR_SI_ts4(MEM6_BIST_COLLAR_SI_ts4), 
 .MEM7_BIST_COLLAR_SI_ts4(MEM7_BIST_COLLAR_SI_ts4), .MEM8_BIST_COLLAR_SI_ts3(MEM8_BIST_COLLAR_SI_ts3), 
 .MEM9_BIST_COLLAR_SI_ts3(MEM9_BIST_COLLAR_SI_ts3), .MEM10_BIST_COLLAR_SI_ts3(MEM10_BIST_COLLAR_SI_ts3), 
 .MEM11_BIST_COLLAR_SI_ts3(MEM11_BIST_COLLAR_SI_ts3), 
 .MEM12_BIST_COLLAR_SI_ts3(MEM12_BIST_COLLAR_SI_ts3), 
 .MEM13_BIST_COLLAR_SI_ts3(MEM13_BIST_COLLAR_SI_ts3), 
 .MEM14_BIST_COLLAR_SI_ts3(MEM14_BIST_COLLAR_SI_ts3), 
 .MEM15_BIST_COLLAR_SI_ts3(MEM15_BIST_COLLAR_SI_ts3), 
 .MEM16_BIST_COLLAR_SI_ts3(MEM16_BIST_COLLAR_SI_ts3), 
 .MEM17_BIST_COLLAR_SI_ts3(MEM17_BIST_COLLAR_SI_ts3), 
 .MEM18_BIST_COLLAR_SI_ts3(MEM18_BIST_COLLAR_SI_ts3), 
 .MEM19_BIST_COLLAR_SI_ts3(MEM19_BIST_COLLAR_SI_ts3), 
 .MEM20_BIST_COLLAR_SI_ts2(MEM20_BIST_COLLAR_SI_ts2), 
 .MEM21_BIST_COLLAR_SI_ts2(MEM21_BIST_COLLAR_SI_ts2), 
 .MEM22_BIST_COLLAR_SI_ts2(MEM22_BIST_COLLAR_SI_ts2), 
 .MEM23_BIST_COLLAR_SI_ts2(MEM23_BIST_COLLAR_SI_ts2), 
 .MEM24_BIST_COLLAR_SI_ts2(MEM24_BIST_COLLAR_SI_ts2), 
 .MEM25_BIST_COLLAR_SI_ts2(MEM25_BIST_COLLAR_SI_ts2), 
 .MEM26_BIST_COLLAR_SI_ts2(MEM26_BIST_COLLAR_SI_ts2), 
 .MEM27_BIST_COLLAR_SI_ts2(MEM27_BIST_COLLAR_SI_ts2), 
 .MEM28_BIST_COLLAR_SI_ts2(MEM28_BIST_COLLAR_SI_ts2), 
 .MEM29_BIST_COLLAR_SI_ts2(MEM29_BIST_COLLAR_SI_ts2), 
 .MEM30_BIST_COLLAR_SI_ts2(MEM30_BIST_COLLAR_SI_ts2), 
 .MEM31_BIST_COLLAR_SI_ts2(MEM31_BIST_COLLAR_SI_ts2), .BIST_SO(BIST_SO), 
 .BIST_SO_ts1(BIST_SO_ts1), .BIST_SO_ts2(BIST_SO_ts3), .BIST_SO_ts3(BIST_SO_ts4), 
 .BIST_SO_ts4(BIST_SO_ts5), .BIST_SO_ts5(BIST_SO_ts6), .BIST_SO_ts6(BIST_SO_ts7), 
 .BIST_SO_ts7(BIST_SO_ts8), .BIST_SO_ts8(BIST_SO_ts9), .BIST_SO_ts9(BIST_SO_ts10), 
 .BIST_SO_ts10(BIST_SO_ts11), .BIST_SO_ts11(BIST_SO_ts12), .BIST_SO_ts12(BIST_SO_ts13), 
 .BIST_SO_ts13(BIST_SO_ts14), .BIST_SO_ts14(BIST_SO_ts15), .BIST_SO_ts15(BIST_SO_ts16), 
 .BIST_SO_ts16(BIST_SO_ts17), .BIST_SO_ts17(BIST_SO_ts18), .BIST_SO_ts18(BIST_SO_ts19), 
 .BIST_SO_ts19(BIST_SO_ts20), .BIST_SO_ts20(BIST_SO_ts21), .BIST_SO_ts21(BIST_SO_ts22), 
 .BIST_SO_ts22(BIST_SO_ts23), .BIST_SO_ts23(BIST_SO_ts24), .BIST_SO_ts24(BIST_SO_ts25), 
 .BIST_SO_ts25(BIST_SO_ts26), .BIST_SO_ts26(BIST_SO_ts27), .BIST_SO_ts27(BIST_SO_ts28), 
 .BIST_SO_ts28(BIST_SO_ts29), .BIST_SO_ts29(BIST_SO_ts30), .BIST_SO_ts30(BIST_SO_ts31), 
 .BIST_SO_ts31(BIST_SO_ts32), .BIST_SO_ts32(BIST_SO_ts33), .BIST_SO_ts33(BIST_SO_ts34), 
 .BIST_SO_ts34(BIST_SO_ts35), .BIST_SO_ts35(BIST_SO_ts36), .BIST_SO_ts36(BIST_SO_ts37), 
 .BIST_SO_ts37(BIST_SO_ts38), .BIST_SO_ts38(BIST_SO_ts39), .BIST_SO_ts39(BIST_SO_ts40), 
 .BIST_SO_ts40(BIST_SO_ts41), .BIST_SO_ts41(BIST_SO_ts42), .BIST_SO_ts42(BIST_SO_ts43), 
 .BIST_SO_ts43(BIST_SO_ts44), .BIST_SO_ts44(BIST_SO_ts45), .BIST_SO_ts45(BIST_SO_ts46), 
 .BIST_SO_ts46(BIST_SO_ts47), .BIST_SO_ts47(BIST_SO_ts48), .BIST_SO_ts48(BIST_SO_ts49), 
 .BIST_SO_ts49(BIST_SO_ts50), .BIST_SO_ts50(BIST_SO_ts51), .BIST_SO_ts51(BIST_SO_ts52), 
 .BIST_SO_ts52(BIST_SO_ts53), .BIST_SO_ts53(BIST_SO_ts54), .BIST_SO_ts54(BIST_SO_ts55), 
 .BIST_SO_ts55(BIST_SO_ts56), .BIST_SO_ts56(BIST_SO_ts57), .BIST_SO_ts57(BIST_SO_ts58), 
 .BIST_SO_ts58(BIST_SO_ts59), .BIST_SO_ts59(BIST_SO_ts60), .BIST_SO_ts60(BIST_SO_ts61), 
 .BIST_SO_ts61(BIST_SO_ts62), .BIST_SO_ts62(BIST_SO_ts63), .BIST_SO_ts63(BIST_SO_ts64), 
 .BIST_SO_ts64(BIST_SO_ts65), .BIST_SO_ts65(BIST_SO_ts66), .BIST_SO_ts66(BIST_SO_ts67), 
 .BIST_SO_ts67(BIST_SO_ts68), .BIST_SO_ts68(BIST_SO_ts69), .BIST_SO_ts69(BIST_SO_ts70), 
 .BIST_SO_ts70(BIST_SO_ts71), .BIST_SO_ts71(BIST_SO_ts72), .BIST_SO_ts72(BIST_SO_ts73), 
 .BIST_SO_ts73(BIST_SO_ts74), .BIST_SO_ts74(BIST_SO_ts75), .BIST_SO_ts75(BIST_SO_ts76), 
 .BIST_SO_ts76(BIST_SO_ts77), .BIST_SO_ts77(BIST_SO_ts78), .BIST_SO_ts78(BIST_SO_ts79), 
 .BIST_SO_ts79(BIST_SO_ts80), .BIST_SO_ts80(BIST_SO_ts81), .BIST_SO_ts81(BIST_SO_ts82), 
 .BIST_SO_ts82(BIST_SO_ts83), .BIST_SO_ts83(BIST_SO_ts84), .BIST_SO_ts84(BIST_SO_ts85), 
 .BIST_SO_ts85(BIST_SO_ts86), .BIST_SO_ts86(BIST_SO_ts87), .BIST_SO_ts87(BIST_SO_ts88), 
 .BIST_SO_ts88(BIST_SO_ts89), .BIST_SO_ts89(BIST_SO_ts90), .BIST_SO_ts90(BIST_SO_ts91), 
 .BIST_SO_ts91(BIST_SO_ts92), .BIST_SO_ts92(BIST_SO_ts93), .BIST_SO_ts93(BIST_SO_ts94), 
 .BIST_SO_ts94(BIST_SO_ts95), .BIST_SO_ts95(BIST_SO_ts96), .BIST_SO_ts96(BIST_SO_ts97), 
 .BIST_SO_ts97(BIST_SO_ts98), .BIST_SO_ts98(BIST_SO_ts99), .BIST_SO_ts99(BIST_SO_ts100), 
 .BIST_SO_ts100(BIST_SO_ts101), .BIST_SO_ts101(BIST_SO_ts102), .BIST_SO_ts102(BIST_SO_ts103), 
 .BIST_SO_ts103(BIST_SO_ts104), .BIST_SO_ts104(BIST_SO_ts105), .BIST_SO_ts105(BIST_SO_ts106), 
 .BIST_SO_ts106(BIST_SO_ts107), .BIST_SO_ts107(BIST_SO_ts108), .BIST_SO_ts108(BIST_SO_ts109), 
 .BIST_SO_ts109(BIST_SO_ts110), .BIST_SO_ts110(BIST_SO_ts111), .BIST_SO_ts111(BIST_SO_ts112), 
 .BIST_SO_ts112(BIST_SO_ts113), .BIST_SO_ts113(BIST_SO_ts114), .BIST_SO_ts114(BIST_SO_ts115), 
 .BIST_SO_ts115(BIST_SO_ts116), .BIST_SO_ts116(BIST_SO_ts117), .BIST_SO_ts117(BIST_SO_ts118), 
 .BIST_SO_ts118(BIST_SO_ts119), .BIST_SO_ts119(BIST_SO_ts120), .BIST_SO_ts120(BIST_SO_ts121), 
 .BIST_SO_ts121(BIST_SO_ts122), .BIST_SO_ts122(BIST_SO_ts123), .BIST_SO_ts123(BIST_SO_ts124), 
 .BIST_SO_ts124(BIST_SO_ts125), .BIST_SO_ts125(BIST_SO_ts126), .BIST_SO_ts126(BIST_SO_ts127), 
 .BIST_SO_ts127(BIST_SO_ts128), .BIST_SO_ts128(BIST_SO_ts129), .BIST_SO_ts129(BIST_SO_ts130), 
 .BIST_SO_ts130(BIST_SO_ts131), .BIST_SO_ts131(BIST_SO_ts132), .BIST_GO(BIST_GO), 
 .BIST_GO_ts1(BIST_GO_ts1), .BIST_GO_ts2(BIST_GO_ts3), .BIST_GO_ts3(BIST_GO_ts4), 
 .BIST_GO_ts4(BIST_GO_ts5), .BIST_GO_ts5(BIST_GO_ts6), .BIST_GO_ts6(BIST_GO_ts7), 
 .BIST_GO_ts7(BIST_GO_ts8), .BIST_GO_ts8(BIST_GO_ts9), .BIST_GO_ts9(BIST_GO_ts10), 
 .BIST_GO_ts10(BIST_GO_ts11), .BIST_GO_ts11(BIST_GO_ts12), .BIST_GO_ts12(BIST_GO_ts13), 
 .BIST_GO_ts13(BIST_GO_ts14), .BIST_GO_ts14(BIST_GO_ts15), .BIST_GO_ts15(BIST_GO_ts16), 
 .BIST_GO_ts16(BIST_GO_ts17), .BIST_GO_ts17(BIST_GO_ts18), .BIST_GO_ts18(BIST_GO_ts19), 
 .BIST_GO_ts19(BIST_GO_ts20), .BIST_GO_ts20(BIST_GO_ts21), .BIST_GO_ts21(BIST_GO_ts22), 
 .BIST_GO_ts22(BIST_GO_ts23), .BIST_GO_ts23(BIST_GO_ts24), .BIST_GO_ts24(BIST_GO_ts25), 
 .BIST_GO_ts25(BIST_GO_ts26), .BIST_GO_ts26(BIST_GO_ts27), .BIST_GO_ts27(BIST_GO_ts28), 
 .BIST_GO_ts28(BIST_GO_ts29), .BIST_GO_ts29(BIST_GO_ts30), .BIST_GO_ts30(BIST_GO_ts31), 
 .BIST_GO_ts31(BIST_GO_ts32), .BIST_GO_ts32(BIST_GO_ts33), .BIST_GO_ts33(BIST_GO_ts34), 
 .BIST_GO_ts34(BIST_GO_ts35), .BIST_GO_ts35(BIST_GO_ts36), .BIST_GO_ts36(BIST_GO_ts37), 
 .BIST_GO_ts37(BIST_GO_ts38), .BIST_GO_ts38(BIST_GO_ts39), .BIST_GO_ts39(BIST_GO_ts40), 
 .BIST_GO_ts40(BIST_GO_ts41), .BIST_GO_ts41(BIST_GO_ts42), .BIST_GO_ts42(BIST_GO_ts43), 
 .BIST_GO_ts43(BIST_GO_ts44), .BIST_GO_ts44(BIST_GO_ts45), .BIST_GO_ts45(BIST_GO_ts46), 
 .BIST_GO_ts46(BIST_GO_ts47), .BIST_GO_ts47(BIST_GO_ts48), .BIST_GO_ts48(BIST_GO_ts49), 
 .BIST_GO_ts49(BIST_GO_ts50), .BIST_GO_ts50(BIST_GO_ts51), .BIST_GO_ts51(BIST_GO_ts52), 
 .BIST_GO_ts52(BIST_GO_ts53), .BIST_GO_ts53(BIST_GO_ts54), .BIST_GO_ts54(BIST_GO_ts55), 
 .BIST_GO_ts55(BIST_GO_ts56), .BIST_GO_ts56(BIST_GO_ts57), .BIST_GO_ts57(BIST_GO_ts58), 
 .BIST_GO_ts58(BIST_GO_ts59), .BIST_GO_ts59(BIST_GO_ts60), .BIST_GO_ts60(BIST_GO_ts61), 
 .BIST_GO_ts61(BIST_GO_ts62), .BIST_GO_ts62(BIST_GO_ts63), .BIST_GO_ts63(BIST_GO_ts64), 
 .BIST_GO_ts64(BIST_GO_ts65), .BIST_GO_ts65(BIST_GO_ts66), .BIST_GO_ts66(BIST_GO_ts67), 
 .BIST_GO_ts67(BIST_GO_ts68), .BIST_GO_ts68(BIST_GO_ts69), .BIST_GO_ts69(BIST_GO_ts70), 
 .BIST_GO_ts70(BIST_GO_ts71), .BIST_GO_ts71(BIST_GO_ts72), .BIST_GO_ts72(BIST_GO_ts73), 
 .BIST_GO_ts73(BIST_GO_ts74), .BIST_GO_ts74(BIST_GO_ts75), .BIST_GO_ts75(BIST_GO_ts76), 
 .BIST_GO_ts76(BIST_GO_ts77), .BIST_GO_ts77(BIST_GO_ts78), .BIST_GO_ts78(BIST_GO_ts79), 
 .BIST_GO_ts79(BIST_GO_ts80), .BIST_GO_ts80(BIST_GO_ts81), .BIST_GO_ts81(BIST_GO_ts82), 
 .BIST_GO_ts82(BIST_GO_ts83), .BIST_GO_ts83(BIST_GO_ts84), .BIST_GO_ts84(BIST_GO_ts85), 
 .BIST_GO_ts85(BIST_GO_ts86), .BIST_GO_ts86(BIST_GO_ts87), .BIST_GO_ts87(BIST_GO_ts88), 
 .BIST_GO_ts88(BIST_GO_ts89), .BIST_GO_ts89(BIST_GO_ts90), .BIST_GO_ts90(BIST_GO_ts91), 
 .BIST_GO_ts91(BIST_GO_ts92), .BIST_GO_ts92(BIST_GO_ts93), .BIST_GO_ts93(BIST_GO_ts94), 
 .BIST_GO_ts94(BIST_GO_ts95), .BIST_GO_ts95(BIST_GO_ts96), .BIST_GO_ts96(BIST_GO_ts97), 
 .BIST_GO_ts97(BIST_GO_ts98), .BIST_GO_ts98(BIST_GO_ts99), .BIST_GO_ts99(BIST_GO_ts100), 
 .BIST_GO_ts100(BIST_GO_ts101), .BIST_GO_ts101(BIST_GO_ts102), .BIST_GO_ts102(BIST_GO_ts103), 
 .BIST_GO_ts103(BIST_GO_ts104), .BIST_GO_ts104(BIST_GO_ts105), .BIST_GO_ts105(BIST_GO_ts106), 
 .BIST_GO_ts106(BIST_GO_ts107), .BIST_GO_ts107(BIST_GO_ts108), .BIST_GO_ts108(BIST_GO_ts109), 
 .BIST_GO_ts109(BIST_GO_ts110), .BIST_GO_ts110(BIST_GO_ts111), .BIST_GO_ts111(BIST_GO_ts112), 
 .BIST_GO_ts112(BIST_GO_ts113), .BIST_GO_ts113(BIST_GO_ts114), .BIST_GO_ts114(BIST_GO_ts115), 
 .BIST_GO_ts115(BIST_GO_ts116), .BIST_GO_ts116(BIST_GO_ts117), .BIST_GO_ts117(BIST_GO_ts118), 
 .BIST_GO_ts118(BIST_GO_ts119), .BIST_GO_ts119(BIST_GO_ts120), .BIST_GO_ts120(BIST_GO_ts121), 
 .BIST_GO_ts121(BIST_GO_ts122), .BIST_GO_ts122(BIST_GO_ts123), .BIST_GO_ts123(BIST_GO_ts124), 
 .BIST_GO_ts124(BIST_GO_ts125), .BIST_GO_ts125(BIST_GO_ts126), .BIST_GO_ts126(BIST_GO_ts127), 
 .BIST_GO_ts127(BIST_GO_ts128), .BIST_GO_ts128(BIST_GO_ts129), .BIST_GO_ts129(BIST_GO_ts130), 
 .BIST_GO_ts130(BIST_GO_ts131), .BIST_GO_ts131(BIST_GO_ts132), .ltest_to_en(ltest_to_en_ts1), 
 .BIST_WRITEENABLE(BIST_WRITEENABLE_ts1), .BIST_SELECT(BIST_SELECT), 
 .BIST_WRITEENABLE_ts1(BIST_WRITEENABLE_ts2), .BIST_SELECT_ts1(BIST_SELECT_ts1), 
 .BIST_WRITEENABLE_ts2(BIST_WRITEENABLE_ts3), .BIST_SELECT_ts2(BIST_SELECT_ts2), 
 .BIST_WRITEENABLE_ts3(BIST_WRITEENABLE_ts4), .BIST_SELECT_ts3(BIST_SELECT_ts3), 
 .BIST_WRITEENABLE_ts4(BIST_WRITEENABLE_ts5), .BIST_SELECT_ts4(BIST_SELECT_ts4), 
 .BIST_WRITEENABLE_ts5(BIST_WRITEENABLE_ts6), .BIST_SELECT_ts5(BIST_SELECT_ts5), 
 .BIST_WRITEENABLE_ts6(BIST_WRITEENABLE_ts7), .BIST_SELECT_ts6(BIST_SELECT_ts6), 
 .BIST_WRITEENABLE_ts7(BIST_WRITEENABLE_ts8), .BIST_SELECT_ts7(BIST_SELECT_ts7), 
 .BIST_WRITEENABLE_ts8(BIST_WRITEENABLE_ts9), .BIST_SELECT_ts8(BIST_SELECT_ts8), 
 .BIST_CMP(BIST_CMP_ts1), .BIST_CMP_ts1(BIST_CMP_ts2), .BIST_CMP_ts2(BIST_CMP_ts3), 
 .BIST_CMP_ts3(BIST_CMP_ts4), .BIST_CMP_ts4(BIST_CMP_ts5), .BIST_CMP_ts5(BIST_CMP_ts6), 
 .BIST_CMP_ts6(BIST_CMP_ts7), .BIST_CMP_ts7(BIST_CMP_ts8), .BIST_CMP_ts8(BIST_CMP_ts9), 
 .INCLUDE_MEM_RESULTS_REG(INCLUDE_MEM_RESULTS_REG), .BIST_COL_ADD(BIST_COL_ADD_ts1[0]), 
 .BIST_COL_ADD_ts1(BIST_COL_ADD_ts1[1]), .BIST_COL_ADD_ts2(BIST_COL_ADD_ts2[0]), 
 .BIST_COL_ADD_ts3(BIST_COL_ADD_ts2[1]), .BIST_COL_ADD_ts4(BIST_COL_ADD_ts3), 
 .BIST_COL_ADD_ts5(BIST_COL_ADD_ts4[1:0]), .BIST_COL_ADD_ts6(BIST_COL_ADD_ts5[0]), 
 .BIST_COL_ADD_ts7(BIST_COL_ADD_ts5[1]), .BIST_COL_ADD_ts8(BIST_COL_ADD_ts6[0]), 
 .BIST_COL_ADD_ts9(BIST_COL_ADD_ts6[1]), .BIST_COL_ADD_ts10(BIST_COL_ADD_ts6[2]), 
 .BIST_COL_ADD_ts11(BIST_COL_ADD_ts7[0]), .BIST_COL_ADD_ts12(BIST_COL_ADD_ts7[1]), 
 .BIST_COL_ADD_ts13(BIST_COL_ADD_ts8[1:0]), .BIST_COL_ADD_ts14(BIST_COL_ADD_ts9[0]), 
 .BIST_COL_ADD_ts15(BIST_COL_ADD_ts9[1]), .BIST_ROW_ADD(BIST_ROW_ADD_ts1[0]), 
 .BIST_ROW_ADD_ts1(BIST_ROW_ADD_ts1[1]), .BIST_ROW_ADD_ts2(BIST_ROW_ADD_ts1[2]), 
 .BIST_ROW_ADD_ts3(BIST_ROW_ADD_ts1[3]), .BIST_ROW_ADD_ts4(BIST_ROW_ADD_ts1[4]), 
 .BIST_ROW_ADD_ts5(BIST_ROW_ADD_ts1[5]), .BIST_ROW_ADD_ts6(BIST_ROW_ADD_ts1[6]), 
 .BIST_ROW_ADD_ts7(BIST_ROW_ADD_ts1[7]), .BIST_ROW_ADD_ts8(BIST_ROW_ADD_ts2[0]), 
 .BIST_ROW_ADD_ts9(BIST_ROW_ADD_ts2[1]), .BIST_ROW_ADD_ts10(BIST_ROW_ADD_ts2[2]), 
 .BIST_ROW_ADD_ts11(BIST_ROW_ADD_ts2[3]), .BIST_ROW_ADD_ts12(BIST_ROW_ADD_ts2[4]), 
 .BIST_ROW_ADD_ts13(BIST_ROW_ADD_ts2[5]), .BIST_ROW_ADD_ts14(BIST_ROW_ADD_ts2[6]), 
 .BIST_ROW_ADD_ts15(BIST_ROW_ADD_ts2[7]), .BIST_ROW_ADD_ts16(BIST_ROW_ADD_ts3), 
 .BIST_ROW_ADD_ts17(BIST_ROW_ADD_ts4[6:0]), .BIST_ROW_ADD_ts18(BIST_ROW_ADD_ts5[0]), 
 .BIST_ROW_ADD_ts19(BIST_ROW_ADD_ts5[1]), .BIST_ROW_ADD_ts20(BIST_ROW_ADD_ts5[2]), 
 .BIST_ROW_ADD_ts21(BIST_ROW_ADD_ts5[3]), .BIST_ROW_ADD_ts22(BIST_ROW_ADD_ts5[4]), 
 .BIST_ROW_ADD_ts23(BIST_ROW_ADD_ts5[5]), .BIST_ROW_ADD_ts24(BIST_ROW_ADD_ts5[6]), 
 .BIST_ROW_ADD_ts25(BIST_ROW_ADD_ts5[7]), .BIST_ROW_ADD_ts26(BIST_ROW_ADD_ts6[0]), 
 .BIST_ROW_ADD_ts27(BIST_ROW_ADD_ts6[1]), .BIST_ROW_ADD_ts28(BIST_ROW_ADD_ts6[2]), 
 .BIST_ROW_ADD_ts29(BIST_ROW_ADD_ts6[3]), .BIST_ROW_ADD_ts30(BIST_ROW_ADD_ts6[4]), 
 .BIST_ROW_ADD_ts31(BIST_ROW_ADD_ts6[5]), .BIST_ROW_ADD_ts32(BIST_ROW_ADD_ts6[6]), 
 .BIST_ROW_ADD_ts33(BIST_ROW_ADD_ts6[7]), .BIST_ROW_ADD_ts34(BIST_ROW_ADD_ts7[0]), 
 .BIST_ROW_ADD_ts35(BIST_ROW_ADD_ts7[1]), .BIST_ROW_ADD_ts36(BIST_ROW_ADD_ts7[2]), 
 .BIST_ROW_ADD_ts37(BIST_ROW_ADD_ts7[3]), .BIST_ROW_ADD_ts38(BIST_ROW_ADD_ts7[4]), 
 .BIST_ROW_ADD_ts39(BIST_ROW_ADD_ts7[5]), .BIST_ROW_ADD_ts40(BIST_ROW_ADD_ts7[6]), 
 .BIST_ROW_ADD_ts41(BIST_ROW_ADD_ts7[7]), .BIST_ROW_ADD_ts42(BIST_ROW_ADD_ts8[7:0]), 
 .BIST_ROW_ADD_ts43(BIST_ROW_ADD_ts9[0]), .BIST_ROW_ADD_ts44(BIST_ROW_ADD_ts9[1]), 
 .BIST_ROW_ADD_ts45(BIST_ROW_ADD_ts9[2]), .BIST_ROW_ADD_ts46(BIST_ROW_ADD_ts9[3]), 
 .BIST_ROW_ADD_ts47(BIST_ROW_ADD_ts9[4]), .BIST_ROW_ADD_ts48(BIST_ROW_ADD_ts9[5]), 
 .BIST_ROW_ADD_ts49(BIST_ROW_ADD_ts9[6]), .BIST_ROW_ADD_ts50(BIST_ROW_ADD_ts9[7]), 
 .BIST_BANK_ADD(BIST_BANK_ADD_ts1), .BIST_BANK_ADD_ts1(BIST_BANK_ADD_ts2[0]), 
 .BIST_BANK_ADD_ts2(BIST_BANK_ADD_ts2[1]), .BIST_BANK_ADD_ts3(BIST_BANK_ADD_ts3), 
 .BIST_BANK_ADD_ts4(BIST_BANK_ADD_ts4), .BIST_BANK_ADD_ts5(BIST_BANK_ADD_ts5[0]), 
 .BIST_BANK_ADD_ts6(BIST_BANK_ADD_ts5[1]), .BIST_BANK_ADD_ts7(BIST_BANK_ADD_ts6), 
 .BIST_COLLAR_EN0(BIST_COLLAR_EN0_ts1), .BIST_COLLAR_EN1(BIST_COLLAR_EN1), 
 .BIST_COLLAR_EN2(BIST_COLLAR_EN2), .BIST_COLLAR_EN3(BIST_COLLAR_EN3), 
 .BIST_COLLAR_EN4(BIST_COLLAR_EN4), .BIST_COLLAR_EN5(BIST_COLLAR_EN5), 
 .BIST_COLLAR_EN6(BIST_COLLAR_EN6), .BIST_COLLAR_EN7(BIST_COLLAR_EN7), 
 .BIST_COLLAR_EN8(BIST_COLLAR_EN8), .BIST_COLLAR_EN9(BIST_COLLAR_EN9), 
 .BIST_COLLAR_EN10(BIST_COLLAR_EN10), .BIST_COLLAR_EN11(BIST_COLLAR_EN11), 
 .BIST_COLLAR_EN12(BIST_COLLAR_EN12), .BIST_COLLAR_EN13(BIST_COLLAR_EN13), 
 .BIST_COLLAR_EN14(BIST_COLLAR_EN14), .BIST_COLLAR_EN15(BIST_COLLAR_EN15), 
 .BIST_COLLAR_EN16(BIST_COLLAR_EN16), .BIST_COLLAR_EN17(BIST_COLLAR_EN17), 
 .BIST_COLLAR_EN18(BIST_COLLAR_EN18), .BIST_COLLAR_EN19(BIST_COLLAR_EN19), 
 .BIST_COLLAR_EN0_ts1(BIST_COLLAR_EN0_ts2), .BIST_COLLAR_EN1_ts1(BIST_COLLAR_EN1_ts1), 
 .BIST_COLLAR_EN2_ts1(BIST_COLLAR_EN2_ts1), .BIST_COLLAR_EN3_ts1(BIST_COLLAR_EN3_ts1), 
 .BIST_COLLAR_EN4_ts1(BIST_COLLAR_EN4_ts1), .BIST_COLLAR_EN5_ts1(BIST_COLLAR_EN5_ts1), 
 .BIST_COLLAR_EN6_ts1(BIST_COLLAR_EN6_ts1), .BIST_COLLAR_EN7_ts1(BIST_COLLAR_EN7_ts1), 
 .BIST_COLLAR_EN8_ts1(BIST_COLLAR_EN8_ts1), .BIST_COLLAR_EN9_ts1(BIST_COLLAR_EN9_ts1), 
 .BIST_COLLAR_EN10_ts1(BIST_COLLAR_EN10_ts1), .BIST_COLLAR_EN11_ts1(BIST_COLLAR_EN11_ts1), 
 .BIST_COLLAR_EN12_ts1(BIST_COLLAR_EN12_ts1), .BIST_COLLAR_EN13_ts1(BIST_COLLAR_EN13_ts1), 
 .BIST_COLLAR_EN14_ts1(BIST_COLLAR_EN14_ts1), .BIST_COLLAR_EN15_ts1(BIST_COLLAR_EN15_ts1), 
 .BIST_COLLAR_EN16_ts1(BIST_COLLAR_EN16_ts1), .BIST_COLLAR_EN17_ts1(BIST_COLLAR_EN17_ts1), 
 .BIST_COLLAR_EN18_ts1(BIST_COLLAR_EN18_ts1), .BIST_COLLAR_EN19_ts1(BIST_COLLAR_EN19_ts1), 
 .BIST_COLLAR_EN20(BIST_COLLAR_EN20), .BIST_COLLAR_EN21(BIST_COLLAR_EN21), 
 .BIST_COLLAR_EN22(BIST_COLLAR_EN22), .BIST_COLLAR_EN23(BIST_COLLAR_EN23), 
 .BIST_COLLAR_EN24(BIST_COLLAR_EN24), .BIST_COLLAR_EN25(BIST_COLLAR_EN25), 
 .BIST_COLLAR_EN26(BIST_COLLAR_EN26), .BIST_COLLAR_EN27(BIST_COLLAR_EN27), 
 .BIST_COLLAR_EN28(BIST_COLLAR_EN28), .BIST_COLLAR_EN29(BIST_COLLAR_EN29), 
 .BIST_COLLAR_EN30(BIST_COLLAR_EN30), .BIST_COLLAR_EN31(BIST_COLLAR_EN31), 
 .BIST_COLLAR_EN0_ts2(BIST_COLLAR_EN0_ts3), .BIST_COLLAR_EN0_ts3(BIST_COLLAR_EN0_ts4), 
 .BIST_COLLAR_EN1_ts2(BIST_COLLAR_EN1_ts2), .BIST_COLLAR_EN0_ts4(BIST_COLLAR_EN0_ts5), 
 .BIST_COLLAR_EN1_ts3(BIST_COLLAR_EN1_ts3), .BIST_COLLAR_EN2_ts2(BIST_COLLAR_EN2_ts2), 
 .BIST_COLLAR_EN3_ts2(BIST_COLLAR_EN3_ts2), .BIST_COLLAR_EN4_ts2(BIST_COLLAR_EN4_ts2), 
 .BIST_COLLAR_EN5_ts2(BIST_COLLAR_EN5_ts2), .BIST_COLLAR_EN6_ts2(BIST_COLLAR_EN6_ts2), 
 .BIST_COLLAR_EN7_ts2(BIST_COLLAR_EN7_ts2), .BIST_COLLAR_EN8_ts2(BIST_COLLAR_EN8_ts2), 
 .BIST_COLLAR_EN9_ts2(BIST_COLLAR_EN9_ts2), .BIST_COLLAR_EN10_ts2(BIST_COLLAR_EN10_ts2), 
 .BIST_COLLAR_EN11_ts2(BIST_COLLAR_EN11_ts2), .BIST_COLLAR_EN12_ts2(BIST_COLLAR_EN12_ts2), 
 .BIST_COLLAR_EN13_ts2(BIST_COLLAR_EN13_ts2), .BIST_COLLAR_EN14_ts2(BIST_COLLAR_EN14_ts2), 
 .BIST_COLLAR_EN15_ts2(BIST_COLLAR_EN15_ts2), .BIST_COLLAR_EN16_ts2(BIST_COLLAR_EN16_ts2), 
 .BIST_COLLAR_EN17_ts2(BIST_COLLAR_EN17_ts2), .BIST_COLLAR_EN18_ts2(BIST_COLLAR_EN18_ts2), 
 .BIST_COLLAR_EN19_ts2(BIST_COLLAR_EN19_ts2), .BIST_COLLAR_EN20_ts1(BIST_COLLAR_EN20_ts1), 
 .BIST_COLLAR_EN21_ts1(BIST_COLLAR_EN21_ts1), .BIST_COLLAR_EN22_ts1(BIST_COLLAR_EN22_ts1), 
 .BIST_COLLAR_EN23_ts1(BIST_COLLAR_EN23_ts1), .BIST_COLLAR_EN24_ts1(BIST_COLLAR_EN24_ts1), 
 .BIST_COLLAR_EN25_ts1(BIST_COLLAR_EN25_ts1), .BIST_COLLAR_EN26_ts1(BIST_COLLAR_EN26_ts1), 
 .BIST_COLLAR_EN27_ts1(BIST_COLLAR_EN27_ts1), .BIST_COLLAR_EN28_ts1(BIST_COLLAR_EN28_ts1), 
 .BIST_COLLAR_EN29_ts1(BIST_COLLAR_EN29_ts1), .BIST_COLLAR_EN30_ts1(BIST_COLLAR_EN30_ts1), 
 .BIST_COLLAR_EN31_ts1(BIST_COLLAR_EN31_ts1), .BIST_COLLAR_EN0_ts5(BIST_COLLAR_EN0_ts6), 
 .BIST_COLLAR_EN1_ts4(BIST_COLLAR_EN1_ts4), .BIST_COLLAR_EN0_ts6(BIST_COLLAR_EN0_ts7), 
 .BIST_COLLAR_EN1_ts5(BIST_COLLAR_EN1_ts5), .BIST_COLLAR_EN2_ts3(BIST_COLLAR_EN2_ts3), 
 .BIST_COLLAR_EN3_ts3(BIST_COLLAR_EN3_ts3), .BIST_COLLAR_EN4_ts3(BIST_COLLAR_EN4_ts3), 
 .BIST_COLLAR_EN5_ts3(BIST_COLLAR_EN5_ts3), .BIST_COLLAR_EN6_ts3(BIST_COLLAR_EN6_ts3), 
 .BIST_COLLAR_EN7_ts3(BIST_COLLAR_EN7_ts3), .BIST_COLLAR_EN0_ts7(BIST_COLLAR_EN0_ts8), 
 .BIST_COLLAR_EN1_ts6(BIST_COLLAR_EN1_ts6), .BIST_COLLAR_EN2_ts4(BIST_COLLAR_EN2_ts4), 
 .BIST_COLLAR_EN0_ts8(BIST_COLLAR_EN0_ts9), .BIST_COLLAR_EN1_ts7(BIST_COLLAR_EN1_ts7), 
 .BIST_COLLAR_EN2_ts5(BIST_COLLAR_EN2_ts5), .BIST_COLLAR_EN3_ts4(BIST_COLLAR_EN3_ts4), 
 .BIST_COLLAR_EN4_ts4(BIST_COLLAR_EN4_ts4), .BIST_COLLAR_EN5_ts4(BIST_COLLAR_EN5_ts4), 
 .BIST_COLLAR_EN6_ts4(BIST_COLLAR_EN6_ts4), .BIST_COLLAR_EN7_ts4(BIST_COLLAR_EN7_ts4), 
 .BIST_COLLAR_EN8_ts3(BIST_COLLAR_EN8_ts3), .BIST_COLLAR_EN9_ts3(BIST_COLLAR_EN9_ts3), 
 .BIST_COLLAR_EN10_ts3(BIST_COLLAR_EN10_ts3), .BIST_COLLAR_EN11_ts3(BIST_COLLAR_EN11_ts3), 
 .BIST_COLLAR_EN12_ts3(BIST_COLLAR_EN12_ts3), .BIST_COLLAR_EN13_ts3(BIST_COLLAR_EN13_ts3), 
 .BIST_COLLAR_EN14_ts3(BIST_COLLAR_EN14_ts3), .BIST_COLLAR_EN15_ts3(BIST_COLLAR_EN15_ts3), 
 .BIST_COLLAR_EN16_ts3(BIST_COLLAR_EN16_ts3), .BIST_COLLAR_EN17_ts3(BIST_COLLAR_EN17_ts3), 
 .BIST_COLLAR_EN18_ts3(BIST_COLLAR_EN18_ts3), .BIST_COLLAR_EN19_ts3(BIST_COLLAR_EN19_ts3), 
 .BIST_COLLAR_EN20_ts2(BIST_COLLAR_EN20_ts2), .BIST_COLLAR_EN21_ts2(BIST_COLLAR_EN21_ts2), 
 .BIST_COLLAR_EN22_ts2(BIST_COLLAR_EN22_ts2), .BIST_COLLAR_EN23_ts2(BIST_COLLAR_EN23_ts2), 
 .BIST_COLLAR_EN24_ts2(BIST_COLLAR_EN24_ts2), .BIST_COLLAR_EN25_ts2(BIST_COLLAR_EN25_ts2), 
 .BIST_COLLAR_EN26_ts2(BIST_COLLAR_EN26_ts2), .BIST_COLLAR_EN27_ts2(BIST_COLLAR_EN27_ts2), 
 .BIST_COLLAR_EN28_ts2(BIST_COLLAR_EN28_ts2), .BIST_COLLAR_EN29_ts2(BIST_COLLAR_EN29_ts2), 
 .BIST_COLLAR_EN30_ts2(BIST_COLLAR_EN30_ts2), .BIST_COLLAR_EN31_ts2(BIST_COLLAR_EN31_ts2), 
 .BIST_RUN_TO_COLLAR0(BIST_RUN_TO_COLLAR0_ts1), .BIST_RUN_TO_COLLAR1(BIST_RUN_TO_COLLAR1), 
 .BIST_RUN_TO_COLLAR2(BIST_RUN_TO_COLLAR2), .BIST_RUN_TO_COLLAR3(BIST_RUN_TO_COLLAR3), 
 .BIST_RUN_TO_COLLAR4(BIST_RUN_TO_COLLAR4), .BIST_RUN_TO_COLLAR5(BIST_RUN_TO_COLLAR5), 
 .BIST_RUN_TO_COLLAR6(BIST_RUN_TO_COLLAR6), .BIST_RUN_TO_COLLAR7(BIST_RUN_TO_COLLAR7), 
 .BIST_RUN_TO_COLLAR8(BIST_RUN_TO_COLLAR8), .BIST_RUN_TO_COLLAR9(BIST_RUN_TO_COLLAR9), 
 .BIST_RUN_TO_COLLAR10(BIST_RUN_TO_COLLAR10), .BIST_RUN_TO_COLLAR11(BIST_RUN_TO_COLLAR11), 
 .BIST_RUN_TO_COLLAR12(BIST_RUN_TO_COLLAR12), .BIST_RUN_TO_COLLAR13(BIST_RUN_TO_COLLAR13), 
 .BIST_RUN_TO_COLLAR14(BIST_RUN_TO_COLLAR14), .BIST_RUN_TO_COLLAR15(BIST_RUN_TO_COLLAR15), 
 .BIST_RUN_TO_COLLAR16(BIST_RUN_TO_COLLAR16), .BIST_RUN_TO_COLLAR17(BIST_RUN_TO_COLLAR17), 
 .BIST_RUN_TO_COLLAR18(BIST_RUN_TO_COLLAR18), .BIST_RUN_TO_COLLAR19(BIST_RUN_TO_COLLAR19), 
 .BIST_RUN_TO_COLLAR0_ts1(BIST_RUN_TO_COLLAR0_ts2), .BIST_RUN_TO_COLLAR1_ts1(BIST_RUN_TO_COLLAR1_ts1), 
 .BIST_RUN_TO_COLLAR2_ts1(BIST_RUN_TO_COLLAR2_ts1), .BIST_RUN_TO_COLLAR3_ts1(BIST_RUN_TO_COLLAR3_ts1), 
 .BIST_RUN_TO_COLLAR4_ts1(BIST_RUN_TO_COLLAR4_ts1), .BIST_RUN_TO_COLLAR5_ts1(BIST_RUN_TO_COLLAR5_ts1), 
 .BIST_RUN_TO_COLLAR6_ts1(BIST_RUN_TO_COLLAR6_ts1), .BIST_RUN_TO_COLLAR7_ts1(BIST_RUN_TO_COLLAR7_ts1), 
 .BIST_RUN_TO_COLLAR8_ts1(BIST_RUN_TO_COLLAR8_ts1), .BIST_RUN_TO_COLLAR9_ts1(BIST_RUN_TO_COLLAR9_ts1), 
 .BIST_RUN_TO_COLLAR10_ts1(BIST_RUN_TO_COLLAR10_ts1), 
 .BIST_RUN_TO_COLLAR11_ts1(BIST_RUN_TO_COLLAR11_ts1), 
 .BIST_RUN_TO_COLLAR12_ts1(BIST_RUN_TO_COLLAR12_ts1), 
 .BIST_RUN_TO_COLLAR13_ts1(BIST_RUN_TO_COLLAR13_ts1), 
 .BIST_RUN_TO_COLLAR14_ts1(BIST_RUN_TO_COLLAR14_ts1), 
 .BIST_RUN_TO_COLLAR15_ts1(BIST_RUN_TO_COLLAR15_ts1), 
 .BIST_RUN_TO_COLLAR16_ts1(BIST_RUN_TO_COLLAR16_ts1), 
 .BIST_RUN_TO_COLLAR17_ts1(BIST_RUN_TO_COLLAR17_ts1), 
 .BIST_RUN_TO_COLLAR18_ts1(BIST_RUN_TO_COLLAR18_ts1), 
 .BIST_RUN_TO_COLLAR19_ts1(BIST_RUN_TO_COLLAR19_ts1), .BIST_RUN_TO_COLLAR20(BIST_RUN_TO_COLLAR20), 
 .BIST_RUN_TO_COLLAR21(BIST_RUN_TO_COLLAR21), .BIST_RUN_TO_COLLAR22(BIST_RUN_TO_COLLAR22), 
 .BIST_RUN_TO_COLLAR23(BIST_RUN_TO_COLLAR23), .BIST_RUN_TO_COLLAR24(BIST_RUN_TO_COLLAR24), 
 .BIST_RUN_TO_COLLAR25(BIST_RUN_TO_COLLAR25), .BIST_RUN_TO_COLLAR26(BIST_RUN_TO_COLLAR26), 
 .BIST_RUN_TO_COLLAR27(BIST_RUN_TO_COLLAR27), .BIST_RUN_TO_COLLAR28(BIST_RUN_TO_COLLAR28), 
 .BIST_RUN_TO_COLLAR29(BIST_RUN_TO_COLLAR29), .BIST_RUN_TO_COLLAR30(BIST_RUN_TO_COLLAR30), 
 .BIST_RUN_TO_COLLAR31(BIST_RUN_TO_COLLAR31), .BIST_RUN_TO_COLLAR0_ts2(BIST_RUN_TO_COLLAR0_ts3), 
 .BIST_RUN_TO_COLLAR0_ts3(BIST_RUN_TO_COLLAR0_ts4), .BIST_RUN_TO_COLLAR1_ts2(BIST_RUN_TO_COLLAR1_ts2), 
 .BIST_RUN_TO_COLLAR0_ts4(BIST_RUN_TO_COLLAR0_ts5), .BIST_RUN_TO_COLLAR1_ts3(BIST_RUN_TO_COLLAR1_ts3), 
 .BIST_RUN_TO_COLLAR2_ts2(BIST_RUN_TO_COLLAR2_ts2), .BIST_RUN_TO_COLLAR3_ts2(BIST_RUN_TO_COLLAR3_ts2), 
 .BIST_RUN_TO_COLLAR4_ts2(BIST_RUN_TO_COLLAR4_ts2), .BIST_RUN_TO_COLLAR5_ts2(BIST_RUN_TO_COLLAR5_ts2), 
 .BIST_RUN_TO_COLLAR6_ts2(BIST_RUN_TO_COLLAR6_ts2), .BIST_RUN_TO_COLLAR7_ts2(BIST_RUN_TO_COLLAR7_ts2), 
 .BIST_RUN_TO_COLLAR8_ts2(BIST_RUN_TO_COLLAR8_ts2), .BIST_RUN_TO_COLLAR9_ts2(BIST_RUN_TO_COLLAR9_ts2), 
 .BIST_RUN_TO_COLLAR10_ts2(BIST_RUN_TO_COLLAR10_ts2), 
 .BIST_RUN_TO_COLLAR11_ts2(BIST_RUN_TO_COLLAR11_ts2), 
 .BIST_RUN_TO_COLLAR12_ts2(BIST_RUN_TO_COLLAR12_ts2), 
 .BIST_RUN_TO_COLLAR13_ts2(BIST_RUN_TO_COLLAR13_ts2), 
 .BIST_RUN_TO_COLLAR14_ts2(BIST_RUN_TO_COLLAR14_ts2), 
 .BIST_RUN_TO_COLLAR15_ts2(BIST_RUN_TO_COLLAR15_ts2), 
 .BIST_RUN_TO_COLLAR16_ts2(BIST_RUN_TO_COLLAR16_ts2), 
 .BIST_RUN_TO_COLLAR17_ts2(BIST_RUN_TO_COLLAR17_ts2), 
 .BIST_RUN_TO_COLLAR18_ts2(BIST_RUN_TO_COLLAR18_ts2), 
 .BIST_RUN_TO_COLLAR19_ts2(BIST_RUN_TO_COLLAR19_ts2), 
 .BIST_RUN_TO_COLLAR20_ts1(BIST_RUN_TO_COLLAR20_ts1), 
 .BIST_RUN_TO_COLLAR21_ts1(BIST_RUN_TO_COLLAR21_ts1), 
 .BIST_RUN_TO_COLLAR22_ts1(BIST_RUN_TO_COLLAR22_ts1), 
 .BIST_RUN_TO_COLLAR23_ts1(BIST_RUN_TO_COLLAR23_ts1), 
 .BIST_RUN_TO_COLLAR24_ts1(BIST_RUN_TO_COLLAR24_ts1), 
 .BIST_RUN_TO_COLLAR25_ts1(BIST_RUN_TO_COLLAR25_ts1), 
 .BIST_RUN_TO_COLLAR26_ts1(BIST_RUN_TO_COLLAR26_ts1), 
 .BIST_RUN_TO_COLLAR27_ts1(BIST_RUN_TO_COLLAR27_ts1), 
 .BIST_RUN_TO_COLLAR28_ts1(BIST_RUN_TO_COLLAR28_ts1), 
 .BIST_RUN_TO_COLLAR29_ts1(BIST_RUN_TO_COLLAR29_ts1), 
 .BIST_RUN_TO_COLLAR30_ts1(BIST_RUN_TO_COLLAR30_ts1), 
 .BIST_RUN_TO_COLLAR31_ts1(BIST_RUN_TO_COLLAR31_ts1), 
 .BIST_RUN_TO_COLLAR0_ts5(BIST_RUN_TO_COLLAR0_ts6), .BIST_RUN_TO_COLLAR1_ts4(BIST_RUN_TO_COLLAR1_ts4), 
 .BIST_RUN_TO_COLLAR0_ts6(BIST_RUN_TO_COLLAR0_ts7), .BIST_RUN_TO_COLLAR1_ts5(BIST_RUN_TO_COLLAR1_ts5), 
 .BIST_RUN_TO_COLLAR2_ts3(BIST_RUN_TO_COLLAR2_ts3), .BIST_RUN_TO_COLLAR3_ts3(BIST_RUN_TO_COLLAR3_ts3), 
 .BIST_RUN_TO_COLLAR4_ts3(BIST_RUN_TO_COLLAR4_ts3), .BIST_RUN_TO_COLLAR5_ts3(BIST_RUN_TO_COLLAR5_ts3), 
 .BIST_RUN_TO_COLLAR6_ts3(BIST_RUN_TO_COLLAR6_ts3), .BIST_RUN_TO_COLLAR7_ts3(BIST_RUN_TO_COLLAR7_ts3), 
 .BIST_RUN_TO_COLLAR0_ts7(BIST_RUN_TO_COLLAR0_ts8), .BIST_RUN_TO_COLLAR1_ts6(BIST_RUN_TO_COLLAR1_ts6), 
 .BIST_RUN_TO_COLLAR2_ts4(BIST_RUN_TO_COLLAR2_ts4), .BIST_RUN_TO_COLLAR0_ts8(BIST_RUN_TO_COLLAR0_ts9), 
 .BIST_RUN_TO_COLLAR1_ts7(BIST_RUN_TO_COLLAR1_ts7), .BIST_RUN_TO_COLLAR2_ts5(BIST_RUN_TO_COLLAR2_ts5), 
 .BIST_RUN_TO_COLLAR3_ts4(BIST_RUN_TO_COLLAR3_ts4), .BIST_RUN_TO_COLLAR4_ts4(BIST_RUN_TO_COLLAR4_ts4), 
 .BIST_RUN_TO_COLLAR5_ts4(BIST_RUN_TO_COLLAR5_ts4), .BIST_RUN_TO_COLLAR6_ts4(BIST_RUN_TO_COLLAR6_ts4), 
 .BIST_RUN_TO_COLLAR7_ts4(BIST_RUN_TO_COLLAR7_ts4), .BIST_RUN_TO_COLLAR8_ts3(BIST_RUN_TO_COLLAR8_ts3), 
 .BIST_RUN_TO_COLLAR9_ts3(BIST_RUN_TO_COLLAR9_ts3), .BIST_RUN_TO_COLLAR10_ts3(BIST_RUN_TO_COLLAR10_ts3), 
 .BIST_RUN_TO_COLLAR11_ts3(BIST_RUN_TO_COLLAR11_ts3), 
 .BIST_RUN_TO_COLLAR12_ts3(BIST_RUN_TO_COLLAR12_ts3), 
 .BIST_RUN_TO_COLLAR13_ts3(BIST_RUN_TO_COLLAR13_ts3), 
 .BIST_RUN_TO_COLLAR14_ts3(BIST_RUN_TO_COLLAR14_ts3), 
 .BIST_RUN_TO_COLLAR15_ts3(BIST_RUN_TO_COLLAR15_ts3), 
 .BIST_RUN_TO_COLLAR16_ts3(BIST_RUN_TO_COLLAR16_ts3), 
 .BIST_RUN_TO_COLLAR17_ts3(BIST_RUN_TO_COLLAR17_ts3), 
 .BIST_RUN_TO_COLLAR18_ts3(BIST_RUN_TO_COLLAR18_ts3), 
 .BIST_RUN_TO_COLLAR19_ts3(BIST_RUN_TO_COLLAR19_ts3), 
 .BIST_RUN_TO_COLLAR20_ts2(BIST_RUN_TO_COLLAR20_ts2), 
 .BIST_RUN_TO_COLLAR21_ts2(BIST_RUN_TO_COLLAR21_ts2), 
 .BIST_RUN_TO_COLLAR22_ts2(BIST_RUN_TO_COLLAR22_ts2), 
 .BIST_RUN_TO_COLLAR23_ts2(BIST_RUN_TO_COLLAR23_ts2), 
 .BIST_RUN_TO_COLLAR24_ts2(BIST_RUN_TO_COLLAR24_ts2), 
 .BIST_RUN_TO_COLLAR25_ts2(BIST_RUN_TO_COLLAR25_ts2), 
 .BIST_RUN_TO_COLLAR26_ts2(BIST_RUN_TO_COLLAR26_ts2), 
 .BIST_RUN_TO_COLLAR27_ts2(BIST_RUN_TO_COLLAR27_ts2), 
 .BIST_RUN_TO_COLLAR28_ts2(BIST_RUN_TO_COLLAR28_ts2), 
 .BIST_RUN_TO_COLLAR29_ts2(BIST_RUN_TO_COLLAR29_ts2), 
 .BIST_RUN_TO_COLLAR30_ts2(BIST_RUN_TO_COLLAR30_ts2), 
 .BIST_RUN_TO_COLLAR31_ts2(BIST_RUN_TO_COLLAR31_ts2), .BIST_ASYNC_RESET(BIST_ASYNC_RESET), 
 .BIST_TESTDATA_SELECT_TO_COLLAR(BIST_TESTDATA_SELECT_TO_COLLAR_ts1), 
 .BIST_TESTDATA_SELECT_TO_COLLAR_ts1(BIST_TESTDATA_SELECT_TO_COLLAR_ts2), 
 .BIST_TESTDATA_SELECT_TO_COLLAR_ts2(BIST_TESTDATA_SELECT_TO_COLLAR_ts3), 
 .BIST_TESTDATA_SELECT_TO_COLLAR_ts3(BIST_TESTDATA_SELECT_TO_COLLAR_ts4), 
 .BIST_TESTDATA_SELECT_TO_COLLAR_ts4(BIST_TESTDATA_SELECT_TO_COLLAR_ts5), 
 .BIST_TESTDATA_SELECT_TO_COLLAR_ts5(BIST_TESTDATA_SELECT_TO_COLLAR_ts6), 
 .BIST_TESTDATA_SELECT_TO_COLLAR_ts6(BIST_TESTDATA_SELECT_TO_COLLAR_ts7), 
 .BIST_TESTDATA_SELECT_TO_COLLAR_ts7(BIST_TESTDATA_SELECT_TO_COLLAR_ts8), 
 .BIST_TESTDATA_SELECT_TO_COLLAR_ts8(BIST_TESTDATA_SELECT_TO_COLLAR_ts9), 
 .BIST_ON_TO_COLLAR(BIST_ON_TO_COLLAR_ts1), .BIST_ON_TO_COLLAR_ts1(BIST_ON_TO_COLLAR_ts2), 
 .BIST_ON_TO_COLLAR_ts2(BIST_ON_TO_COLLAR_ts3), .BIST_ON_TO_COLLAR_ts3(BIST_ON_TO_COLLAR_ts4), 
 .BIST_ON_TO_COLLAR_ts4(BIST_ON_TO_COLLAR_ts5), .BIST_ON_TO_COLLAR_ts5(BIST_ON_TO_COLLAR_ts6), 
 .BIST_ON_TO_COLLAR_ts6(BIST_ON_TO_COLLAR_ts7), .BIST_ON_TO_COLLAR_ts7(BIST_ON_TO_COLLAR_ts8), 
 .BIST_ON_TO_COLLAR_ts8(BIST_ON_TO_COLLAR_ts9), .BIST_WRITE_DATA(BIST_WRITE_DATA_ts1[0]), 
 .BIST_WRITE_DATA_ts1(BIST_WRITE_DATA_ts1[1]), .BIST_WRITE_DATA_ts2(BIST_WRITE_DATA_ts1[2]), 
 .BIST_WRITE_DATA_ts3(BIST_WRITE_DATA_ts1[3]), .BIST_WRITE_DATA_ts4(BIST_WRITE_DATA_ts1[4]), 
 .BIST_WRITE_DATA_ts5(BIST_WRITE_DATA_ts1[5]), .BIST_WRITE_DATA_ts6(BIST_WRITE_DATA_ts1[6]), 
 .BIST_WRITE_DATA_ts7(BIST_WRITE_DATA_ts1[7]), .BIST_WRITE_DATA_ts8(BIST_WRITE_DATA_ts1[8]), 
 .BIST_WRITE_DATA_ts9(BIST_WRITE_DATA_ts1[9]), .BIST_WRITE_DATA_ts10(BIST_WRITE_DATA_ts1[10]), 
 .BIST_WRITE_DATA_ts11(BIST_WRITE_DATA_ts1[11]), .BIST_WRITE_DATA_ts12(BIST_WRITE_DATA_ts1[12]), 
 .BIST_WRITE_DATA_ts13(BIST_WRITE_DATA_ts1[13]), .BIST_WRITE_DATA_ts14(BIST_WRITE_DATA_ts1[14]), 
 .BIST_WRITE_DATA_ts15(BIST_WRITE_DATA_ts1[15]), .BIST_WRITE_DATA_ts16(BIST_WRITE_DATA_ts1[16]), 
 .BIST_WRITE_DATA_ts17(BIST_WRITE_DATA_ts1[17]), .BIST_WRITE_DATA_ts18(BIST_WRITE_DATA_ts1[18]), 
 .BIST_WRITE_DATA_ts19(BIST_WRITE_DATA_ts1[19]), .BIST_WRITE_DATA_ts20(BIST_WRITE_DATA_ts1[20]), 
 .BIST_WRITE_DATA_ts21(BIST_WRITE_DATA_ts1[21]), .BIST_WRITE_DATA_ts22(BIST_WRITE_DATA_ts1[22]), 
 .BIST_WRITE_DATA_ts23(BIST_WRITE_DATA_ts1[23]), .BIST_WRITE_DATA_ts24(BIST_WRITE_DATA_ts1[24]), 
 .BIST_WRITE_DATA_ts25(BIST_WRITE_DATA_ts1[25]), .BIST_WRITE_DATA_ts26(BIST_WRITE_DATA_ts1[26]), 
 .BIST_WRITE_DATA_ts27(BIST_WRITE_DATA_ts1[27]), .BIST_WRITE_DATA_ts28(BIST_WRITE_DATA_ts1[28]), 
 .BIST_WRITE_DATA_ts29(BIST_WRITE_DATA_ts1[29]), .BIST_WRITE_DATA_ts30(BIST_WRITE_DATA_ts1[30]), 
 .BIST_WRITE_DATA_ts31(BIST_WRITE_DATA_ts1[31]), .BIST_WRITE_DATA_ts32(BIST_WRITE_DATA_ts2[0]), 
 .BIST_WRITE_DATA_ts33(BIST_WRITE_DATA_ts2[1]), .BIST_WRITE_DATA_ts34(BIST_WRITE_DATA_ts2[2]), 
 .BIST_WRITE_DATA_ts35(BIST_WRITE_DATA_ts2[3]), .BIST_WRITE_DATA_ts36(BIST_WRITE_DATA_ts2[4]), 
 .BIST_WRITE_DATA_ts37(BIST_WRITE_DATA_ts2[5]), .BIST_WRITE_DATA_ts38(BIST_WRITE_DATA_ts2[6]), 
 .BIST_WRITE_DATA_ts39(BIST_WRITE_DATA_ts2[7]), .BIST_WRITE_DATA_ts40(BIST_WRITE_DATA_ts2[8]), 
 .BIST_WRITE_DATA_ts41(BIST_WRITE_DATA_ts2[9]), .BIST_WRITE_DATA_ts42(BIST_WRITE_DATA_ts2[10]), 
 .BIST_WRITE_DATA_ts43(BIST_WRITE_DATA_ts2[11]), .BIST_WRITE_DATA_ts44(BIST_WRITE_DATA_ts2[12]), 
 .BIST_WRITE_DATA_ts45(BIST_WRITE_DATA_ts2[13]), .BIST_WRITE_DATA_ts46(BIST_WRITE_DATA_ts2[14]), 
 .BIST_WRITE_DATA_ts47(BIST_WRITE_DATA_ts2[15]), .BIST_WRITE_DATA_ts48(BIST_WRITE_DATA_ts2[16]), 
 .BIST_WRITE_DATA_ts49(BIST_WRITE_DATA_ts2[17]), .BIST_WRITE_DATA_ts50(BIST_WRITE_DATA_ts2[18]), 
 .BIST_WRITE_DATA_ts51(BIST_WRITE_DATA_ts2[19]), .BIST_WRITE_DATA_ts52(BIST_WRITE_DATA_ts2[20]), 
 .BIST_WRITE_DATA_ts53(BIST_WRITE_DATA_ts2[21]), .BIST_WRITE_DATA_ts54(BIST_WRITE_DATA_ts2[22]), 
 .BIST_WRITE_DATA_ts55(BIST_WRITE_DATA_ts2[23]), .BIST_WRITE_DATA_ts56(BIST_WRITE_DATA_ts2[24]), 
 .BIST_WRITE_DATA_ts57(BIST_WRITE_DATA_ts2[25]), .BIST_WRITE_DATA_ts58(BIST_WRITE_DATA_ts2[26]), 
 .BIST_WRITE_DATA_ts59(BIST_WRITE_DATA_ts2[27]), .BIST_WRITE_DATA_ts60(BIST_WRITE_DATA_ts2[28]), 
 .BIST_WRITE_DATA_ts61(BIST_WRITE_DATA_ts2[29]), .BIST_WRITE_DATA_ts62(BIST_WRITE_DATA_ts2[30]), 
 .BIST_WRITE_DATA_ts63(BIST_WRITE_DATA_ts2[31]), .BIST_WRITE_DATA_ts64(BIST_WRITE_DATA_ts3), 
 .BIST_WRITE_DATA_ts65(BIST_WRITE_DATA_ts4[31:0]), .BIST_WRITE_DATA_ts66(BIST_WRITE_DATA_ts5[0]), 
 .BIST_WRITE_DATA_ts67(BIST_WRITE_DATA_ts5[1]), .BIST_WRITE_DATA_ts68(BIST_WRITE_DATA_ts5[2]), 
 .BIST_WRITE_DATA_ts69(BIST_WRITE_DATA_ts5[3]), .BIST_WRITE_DATA_ts70(BIST_WRITE_DATA_ts5[4]), 
 .BIST_WRITE_DATA_ts71(BIST_WRITE_DATA_ts5[5]), .BIST_WRITE_DATA_ts72(BIST_WRITE_DATA_ts5[6]), 
 .BIST_WRITE_DATA_ts73(BIST_WRITE_DATA_ts5[7]), .BIST_WRITE_DATA_ts74(BIST_WRITE_DATA_ts5[8]), 
 .BIST_WRITE_DATA_ts75(BIST_WRITE_DATA_ts5[9]), .BIST_WRITE_DATA_ts76(BIST_WRITE_DATA_ts5[10]), 
 .BIST_WRITE_DATA_ts77(BIST_WRITE_DATA_ts5[11]), .BIST_WRITE_DATA_ts78(BIST_WRITE_DATA_ts5[12]), 
 .BIST_WRITE_DATA_ts79(BIST_WRITE_DATA_ts5[13]), .BIST_WRITE_DATA_ts80(BIST_WRITE_DATA_ts5[14]), 
 .BIST_WRITE_DATA_ts81(BIST_WRITE_DATA_ts5[15]), .BIST_WRITE_DATA_ts82(BIST_WRITE_DATA_ts5[16]), 
 .BIST_WRITE_DATA_ts83(BIST_WRITE_DATA_ts5[17]), .BIST_WRITE_DATA_ts84(BIST_WRITE_DATA_ts5[18]), 
 .BIST_WRITE_DATA_ts85(BIST_WRITE_DATA_ts5[19]), .BIST_WRITE_DATA_ts86(BIST_WRITE_DATA_ts5[20]), 
 .BIST_WRITE_DATA_ts87(BIST_WRITE_DATA_ts5[21]), .BIST_WRITE_DATA_ts88(BIST_WRITE_DATA_ts5[22]), 
 .BIST_WRITE_DATA_ts89(BIST_WRITE_DATA_ts5[23]), .BIST_WRITE_DATA_ts90(BIST_WRITE_DATA_ts5[24]), 
 .BIST_WRITE_DATA_ts91(BIST_WRITE_DATA_ts5[25]), .BIST_WRITE_DATA_ts92(BIST_WRITE_DATA_ts5[26]), 
 .BIST_WRITE_DATA_ts93(BIST_WRITE_DATA_ts5[27]), .BIST_WRITE_DATA_ts94(BIST_WRITE_DATA_ts5[28]), 
 .BIST_WRITE_DATA_ts95(BIST_WRITE_DATA_ts5[29]), .BIST_WRITE_DATA_ts96(BIST_WRITE_DATA_ts5[30]), 
 .BIST_WRITE_DATA_ts97(BIST_WRITE_DATA_ts5[31]), .BIST_WRITE_DATA_ts98(BIST_WRITE_DATA_ts6[0]), 
 .BIST_WRITE_DATA_ts99(BIST_WRITE_DATA_ts6[1]), .BIST_WRITE_DATA_ts100(BIST_WRITE_DATA_ts6[2]), 
 .BIST_WRITE_DATA_ts101(BIST_WRITE_DATA_ts6[3]), .BIST_WRITE_DATA_ts102(BIST_WRITE_DATA_ts6[4]), 
 .BIST_WRITE_DATA_ts103(BIST_WRITE_DATA_ts6[5]), .BIST_WRITE_DATA_ts104(BIST_WRITE_DATA_ts6[6]), 
 .BIST_WRITE_DATA_ts105(BIST_WRITE_DATA_ts6[7]), .BIST_WRITE_DATA_ts106(BIST_WRITE_DATA_ts6[8]), 
 .BIST_WRITE_DATA_ts107(BIST_WRITE_DATA_ts6[9]), .BIST_WRITE_DATA_ts108(BIST_WRITE_DATA_ts6[10]), 
 .BIST_WRITE_DATA_ts109(BIST_WRITE_DATA_ts6[11]), .BIST_WRITE_DATA_ts110(BIST_WRITE_DATA_ts6[12]), 
 .BIST_WRITE_DATA_ts111(BIST_WRITE_DATA_ts6[13]), .BIST_WRITE_DATA_ts112(BIST_WRITE_DATA_ts6[14]), 
 .BIST_WRITE_DATA_ts113(BIST_WRITE_DATA_ts6[15]), .BIST_WRITE_DATA_ts114(BIST_WRITE_DATA_ts6[16]), 
 .BIST_WRITE_DATA_ts115(BIST_WRITE_DATA_ts6[17]), .BIST_WRITE_DATA_ts116(BIST_WRITE_DATA_ts6[18]), 
 .BIST_WRITE_DATA_ts117(BIST_WRITE_DATA_ts6[19]), .BIST_WRITE_DATA_ts118(BIST_WRITE_DATA_ts6[20]), 
 .BIST_WRITE_DATA_ts119(BIST_WRITE_DATA_ts6[21]), .BIST_WRITE_DATA_ts120(BIST_WRITE_DATA_ts6[22]), 
 .BIST_WRITE_DATA_ts121(BIST_WRITE_DATA_ts6[23]), .BIST_WRITE_DATA_ts122(BIST_WRITE_DATA_ts6[24]), 
 .BIST_WRITE_DATA_ts123(BIST_WRITE_DATA_ts6[25]), .BIST_WRITE_DATA_ts124(BIST_WRITE_DATA_ts6[26]), 
 .BIST_WRITE_DATA_ts125(BIST_WRITE_DATA_ts6[27]), .BIST_WRITE_DATA_ts126(BIST_WRITE_DATA_ts6[28]), 
 .BIST_WRITE_DATA_ts127(BIST_WRITE_DATA_ts6[29]), .BIST_WRITE_DATA_ts128(BIST_WRITE_DATA_ts6[30]), 
 .BIST_WRITE_DATA_ts129(BIST_WRITE_DATA_ts6[31]), .BIST_WRITE_DATA_ts130(BIST_WRITE_DATA_ts7[0]), 
 .BIST_WRITE_DATA_ts131(BIST_WRITE_DATA_ts7[1]), .BIST_WRITE_DATA_ts132(BIST_WRITE_DATA_ts7[2]), 
 .BIST_WRITE_DATA_ts133(BIST_WRITE_DATA_ts7[3]), .BIST_WRITE_DATA_ts134(BIST_WRITE_DATA_ts7[4]), 
 .BIST_WRITE_DATA_ts135(BIST_WRITE_DATA_ts7[5]), .BIST_WRITE_DATA_ts136(BIST_WRITE_DATA_ts7[6]), 
 .BIST_WRITE_DATA_ts137(BIST_WRITE_DATA_ts7[7]), .BIST_WRITE_DATA_ts138(BIST_WRITE_DATA_ts7[8]), 
 .BIST_WRITE_DATA_ts139(BIST_WRITE_DATA_ts7[9]), .BIST_WRITE_DATA_ts140(BIST_WRITE_DATA_ts7[10]), 
 .BIST_WRITE_DATA_ts141(BIST_WRITE_DATA_ts7[11]), .BIST_WRITE_DATA_ts142(BIST_WRITE_DATA_ts7[12]), 
 .BIST_WRITE_DATA_ts143(BIST_WRITE_DATA_ts7[13]), .BIST_WRITE_DATA_ts144(BIST_WRITE_DATA_ts7[14]), 
 .BIST_WRITE_DATA_ts145(BIST_WRITE_DATA_ts7[15]), .BIST_WRITE_DATA_ts146(BIST_WRITE_DATA_ts7[16]), 
 .BIST_WRITE_DATA_ts147(BIST_WRITE_DATA_ts7[17]), .BIST_WRITE_DATA_ts148(BIST_WRITE_DATA_ts7[18]), 
 .BIST_WRITE_DATA_ts149(BIST_WRITE_DATA_ts7[19]), .BIST_WRITE_DATA_ts150(BIST_WRITE_DATA_ts7[20]), 
 .BIST_WRITE_DATA_ts151(BIST_WRITE_DATA_ts7[21]), .BIST_WRITE_DATA_ts152(BIST_WRITE_DATA_ts7[22]), 
 .BIST_WRITE_DATA_ts153(BIST_WRITE_DATA_ts8[31:0]), .BIST_WRITE_DATA_ts154(BIST_WRITE_DATA_ts9[0]), 
 .BIST_WRITE_DATA_ts155(BIST_WRITE_DATA_ts9[1]), .BIST_WRITE_DATA_ts156(BIST_WRITE_DATA_ts9[2]), 
 .BIST_WRITE_DATA_ts157(BIST_WRITE_DATA_ts9[3]), .BIST_WRITE_DATA_ts158(BIST_WRITE_DATA_ts9[4]), 
 .BIST_WRITE_DATA_ts159(BIST_WRITE_DATA_ts9[5]), .BIST_WRITE_DATA_ts160(BIST_WRITE_DATA_ts9[6]), 
 .BIST_WRITE_DATA_ts161(BIST_WRITE_DATA_ts9[7]), .BIST_WRITE_DATA_ts162(BIST_WRITE_DATA_ts9[8]), 
 .BIST_WRITE_DATA_ts163(BIST_WRITE_DATA_ts9[9]), .BIST_WRITE_DATA_ts164(BIST_WRITE_DATA_ts9[10]), 
 .BIST_WRITE_DATA_ts165(BIST_WRITE_DATA_ts9[11]), .BIST_WRITE_DATA_ts166(BIST_WRITE_DATA_ts9[12]), 
 .BIST_WRITE_DATA_ts167(BIST_WRITE_DATA_ts9[13]), .BIST_WRITE_DATA_ts168(BIST_WRITE_DATA_ts9[14]), 
 .BIST_WRITE_DATA_ts169(BIST_WRITE_DATA_ts9[15]), .BIST_WRITE_DATA_ts170(BIST_WRITE_DATA_ts9[16]), 
 .BIST_WRITE_DATA_ts171(BIST_WRITE_DATA_ts9[17]), .BIST_WRITE_DATA_ts172(BIST_WRITE_DATA_ts9[18]), 
 .BIST_WRITE_DATA_ts173(BIST_WRITE_DATA_ts9[19]), .BIST_WRITE_DATA_ts174(BIST_WRITE_DATA_ts9[20]), 
 .BIST_WRITE_DATA_ts175(BIST_WRITE_DATA_ts9[21]), .BIST_WRITE_DATA_ts176(BIST_WRITE_DATA_ts9[22]), 
 .BIST_WRITE_DATA_ts177(BIST_WRITE_DATA_ts9[23]), .BIST_WRITE_DATA_ts178(BIST_WRITE_DATA_ts9[24]), 
 .BIST_WRITE_DATA_ts179(BIST_WRITE_DATA_ts9[25]), .BIST_WRITE_DATA_ts180(BIST_WRITE_DATA_ts9[26]), 
 .BIST_WRITE_DATA_ts181(BIST_WRITE_DATA_ts9[27]), .BIST_WRITE_DATA_ts182(BIST_WRITE_DATA_ts9[28]), 
 .BIST_WRITE_DATA_ts183(BIST_WRITE_DATA_ts9[29]), .BIST_WRITE_DATA_ts184(BIST_WRITE_DATA_ts9[30]), 
 .BIST_WRITE_DATA_ts185(BIST_WRITE_DATA_ts9[31]), .BIST_EXPECT_DATA(BIST_EXPECT_DATA_ts1[0]), 
 .BIST_EXPECT_DATA_ts1(BIST_EXPECT_DATA_ts1[1]), .BIST_EXPECT_DATA_ts2(BIST_EXPECT_DATA_ts1[2]), 
 .BIST_EXPECT_DATA_ts3(BIST_EXPECT_DATA_ts1[3]), .BIST_EXPECT_DATA_ts4(BIST_EXPECT_DATA_ts1[4]), 
 .BIST_EXPECT_DATA_ts5(BIST_EXPECT_DATA_ts1[5]), .BIST_EXPECT_DATA_ts6(BIST_EXPECT_DATA_ts1[6]), 
 .BIST_EXPECT_DATA_ts7(BIST_EXPECT_DATA_ts1[7]), .BIST_EXPECT_DATA_ts8(BIST_EXPECT_DATA_ts1[8]), 
 .BIST_EXPECT_DATA_ts9(BIST_EXPECT_DATA_ts1[9]), .BIST_EXPECT_DATA_ts10(BIST_EXPECT_DATA_ts1[10]), 
 .BIST_EXPECT_DATA_ts11(BIST_EXPECT_DATA_ts1[11]), .BIST_EXPECT_DATA_ts12(BIST_EXPECT_DATA_ts1[12]), 
 .BIST_EXPECT_DATA_ts13(BIST_EXPECT_DATA_ts1[13]), .BIST_EXPECT_DATA_ts14(BIST_EXPECT_DATA_ts1[14]), 
 .BIST_EXPECT_DATA_ts15(BIST_EXPECT_DATA_ts1[15]), .BIST_EXPECT_DATA_ts16(BIST_EXPECT_DATA_ts1[16]), 
 .BIST_EXPECT_DATA_ts17(BIST_EXPECT_DATA_ts1[17]), .BIST_EXPECT_DATA_ts18(BIST_EXPECT_DATA_ts1[18]), 
 .BIST_EXPECT_DATA_ts19(BIST_EXPECT_DATA_ts1[19]), .BIST_EXPECT_DATA_ts20(BIST_EXPECT_DATA_ts1[20]), 
 .BIST_EXPECT_DATA_ts21(BIST_EXPECT_DATA_ts1[21]), .BIST_EXPECT_DATA_ts22(BIST_EXPECT_DATA_ts1[22]), 
 .BIST_EXPECT_DATA_ts23(BIST_EXPECT_DATA_ts1[23]), .BIST_EXPECT_DATA_ts24(BIST_EXPECT_DATA_ts1[24]), 
 .BIST_EXPECT_DATA_ts25(BIST_EXPECT_DATA_ts1[25]), .BIST_EXPECT_DATA_ts26(BIST_EXPECT_DATA_ts1[26]), 
 .BIST_EXPECT_DATA_ts27(BIST_EXPECT_DATA_ts1[27]), .BIST_EXPECT_DATA_ts28(BIST_EXPECT_DATA_ts1[28]), 
 .BIST_EXPECT_DATA_ts29(BIST_EXPECT_DATA_ts1[29]), .BIST_EXPECT_DATA_ts30(BIST_EXPECT_DATA_ts1[30]), 
 .BIST_EXPECT_DATA_ts31(BIST_EXPECT_DATA_ts1[31]), .BIST_EXPECT_DATA_ts32(BIST_EXPECT_DATA_ts2[0]), 
 .BIST_EXPECT_DATA_ts33(BIST_EXPECT_DATA_ts2[1]), .BIST_EXPECT_DATA_ts34(BIST_EXPECT_DATA_ts2[2]), 
 .BIST_EXPECT_DATA_ts35(BIST_EXPECT_DATA_ts2[3]), .BIST_EXPECT_DATA_ts36(BIST_EXPECT_DATA_ts2[4]), 
 .BIST_EXPECT_DATA_ts37(BIST_EXPECT_DATA_ts2[5]), .BIST_EXPECT_DATA_ts38(BIST_EXPECT_DATA_ts2[6]), 
 .BIST_EXPECT_DATA_ts39(BIST_EXPECT_DATA_ts2[7]), .BIST_EXPECT_DATA_ts40(BIST_EXPECT_DATA_ts2[8]), 
 .BIST_EXPECT_DATA_ts41(BIST_EXPECT_DATA_ts2[9]), .BIST_EXPECT_DATA_ts42(BIST_EXPECT_DATA_ts2[10]), 
 .BIST_EXPECT_DATA_ts43(BIST_EXPECT_DATA_ts2[11]), .BIST_EXPECT_DATA_ts44(BIST_EXPECT_DATA_ts2[12]), 
 .BIST_EXPECT_DATA_ts45(BIST_EXPECT_DATA_ts2[13]), .BIST_EXPECT_DATA_ts46(BIST_EXPECT_DATA_ts2[14]), 
 .BIST_EXPECT_DATA_ts47(BIST_EXPECT_DATA_ts2[15]), .BIST_EXPECT_DATA_ts48(BIST_EXPECT_DATA_ts2[16]), 
 .BIST_EXPECT_DATA_ts49(BIST_EXPECT_DATA_ts2[17]), .BIST_EXPECT_DATA_ts50(BIST_EXPECT_DATA_ts2[18]), 
 .BIST_EXPECT_DATA_ts51(BIST_EXPECT_DATA_ts2[19]), .BIST_EXPECT_DATA_ts52(BIST_EXPECT_DATA_ts2[20]), 
 .BIST_EXPECT_DATA_ts53(BIST_EXPECT_DATA_ts2[21]), .BIST_EXPECT_DATA_ts54(BIST_EXPECT_DATA_ts2[22]), 
 .BIST_EXPECT_DATA_ts55(BIST_EXPECT_DATA_ts2[23]), .BIST_EXPECT_DATA_ts56(BIST_EXPECT_DATA_ts2[24]), 
 .BIST_EXPECT_DATA_ts57(BIST_EXPECT_DATA_ts2[25]), .BIST_EXPECT_DATA_ts58(BIST_EXPECT_DATA_ts2[26]), 
 .BIST_EXPECT_DATA_ts59(BIST_EXPECT_DATA_ts2[27]), .BIST_EXPECT_DATA_ts60(BIST_EXPECT_DATA_ts2[28]), 
 .BIST_EXPECT_DATA_ts61(BIST_EXPECT_DATA_ts2[29]), .BIST_EXPECT_DATA_ts62(BIST_EXPECT_DATA_ts2[30]), 
 .BIST_EXPECT_DATA_ts63(BIST_EXPECT_DATA_ts2[31]), .BIST_EXPECT_DATA_ts64(BIST_EXPECT_DATA_ts3), 
 .BIST_EXPECT_DATA_ts65(BIST_EXPECT_DATA_ts4[31:0]), .BIST_EXPECT_DATA_ts66(BIST_EXPECT_DATA_ts5[0]), 
 .BIST_EXPECT_DATA_ts67(BIST_EXPECT_DATA_ts5[1]), .BIST_EXPECT_DATA_ts68(BIST_EXPECT_DATA_ts5[2]), 
 .BIST_EXPECT_DATA_ts69(BIST_EXPECT_DATA_ts5[3]), .BIST_EXPECT_DATA_ts70(BIST_EXPECT_DATA_ts5[4]), 
 .BIST_EXPECT_DATA_ts71(BIST_EXPECT_DATA_ts5[5]), .BIST_EXPECT_DATA_ts72(BIST_EXPECT_DATA_ts5[6]), 
 .BIST_EXPECT_DATA_ts73(BIST_EXPECT_DATA_ts5[7]), .BIST_EXPECT_DATA_ts74(BIST_EXPECT_DATA_ts5[8]), 
 .BIST_EXPECT_DATA_ts75(BIST_EXPECT_DATA_ts5[9]), .BIST_EXPECT_DATA_ts76(BIST_EXPECT_DATA_ts5[10]), 
 .BIST_EXPECT_DATA_ts77(BIST_EXPECT_DATA_ts5[11]), .BIST_EXPECT_DATA_ts78(BIST_EXPECT_DATA_ts5[12]), 
 .BIST_EXPECT_DATA_ts79(BIST_EXPECT_DATA_ts5[13]), .BIST_EXPECT_DATA_ts80(BIST_EXPECT_DATA_ts5[14]), 
 .BIST_EXPECT_DATA_ts81(BIST_EXPECT_DATA_ts5[15]), .BIST_EXPECT_DATA_ts82(BIST_EXPECT_DATA_ts5[16]), 
 .BIST_EXPECT_DATA_ts83(BIST_EXPECT_DATA_ts5[17]), .BIST_EXPECT_DATA_ts84(BIST_EXPECT_DATA_ts5[18]), 
 .BIST_EXPECT_DATA_ts85(BIST_EXPECT_DATA_ts5[19]), .BIST_EXPECT_DATA_ts86(BIST_EXPECT_DATA_ts5[20]), 
 .BIST_EXPECT_DATA_ts87(BIST_EXPECT_DATA_ts5[21]), .BIST_EXPECT_DATA_ts88(BIST_EXPECT_DATA_ts5[22]), 
 .BIST_EXPECT_DATA_ts89(BIST_EXPECT_DATA_ts5[23]), .BIST_EXPECT_DATA_ts90(BIST_EXPECT_DATA_ts5[24]), 
 .BIST_EXPECT_DATA_ts91(BIST_EXPECT_DATA_ts5[25]), .BIST_EXPECT_DATA_ts92(BIST_EXPECT_DATA_ts5[26]), 
 .BIST_EXPECT_DATA_ts93(BIST_EXPECT_DATA_ts5[27]), .BIST_EXPECT_DATA_ts94(BIST_EXPECT_DATA_ts5[28]), 
 .BIST_EXPECT_DATA_ts95(BIST_EXPECT_DATA_ts5[29]), .BIST_EXPECT_DATA_ts96(BIST_EXPECT_DATA_ts5[30]), 
 .BIST_EXPECT_DATA_ts97(BIST_EXPECT_DATA_ts5[31]), .BIST_EXPECT_DATA_ts98(BIST_EXPECT_DATA_ts6[0]), 
 .BIST_EXPECT_DATA_ts99(BIST_EXPECT_DATA_ts6[1]), .BIST_EXPECT_DATA_ts100(BIST_EXPECT_DATA_ts6[2]), 
 .BIST_EXPECT_DATA_ts101(BIST_EXPECT_DATA_ts6[3]), .BIST_EXPECT_DATA_ts102(BIST_EXPECT_DATA_ts6[4]), 
 .BIST_EXPECT_DATA_ts103(BIST_EXPECT_DATA_ts6[5]), .BIST_EXPECT_DATA_ts104(BIST_EXPECT_DATA_ts6[6]), 
 .BIST_EXPECT_DATA_ts105(BIST_EXPECT_DATA_ts6[7]), .BIST_EXPECT_DATA_ts106(BIST_EXPECT_DATA_ts6[8]), 
 .BIST_EXPECT_DATA_ts107(BIST_EXPECT_DATA_ts6[9]), .BIST_EXPECT_DATA_ts108(BIST_EXPECT_DATA_ts6[10]), 
 .BIST_EXPECT_DATA_ts109(BIST_EXPECT_DATA_ts6[11]), .BIST_EXPECT_DATA_ts110(BIST_EXPECT_DATA_ts6[12]), 
 .BIST_EXPECT_DATA_ts111(BIST_EXPECT_DATA_ts6[13]), .BIST_EXPECT_DATA_ts112(BIST_EXPECT_DATA_ts6[14]), 
 .BIST_EXPECT_DATA_ts113(BIST_EXPECT_DATA_ts6[15]), .BIST_EXPECT_DATA_ts114(BIST_EXPECT_DATA_ts6[16]), 
 .BIST_EXPECT_DATA_ts115(BIST_EXPECT_DATA_ts6[17]), .BIST_EXPECT_DATA_ts116(BIST_EXPECT_DATA_ts6[18]), 
 .BIST_EXPECT_DATA_ts117(BIST_EXPECT_DATA_ts6[19]), .BIST_EXPECT_DATA_ts118(BIST_EXPECT_DATA_ts6[20]), 
 .BIST_EXPECT_DATA_ts119(BIST_EXPECT_DATA_ts6[21]), .BIST_EXPECT_DATA_ts120(BIST_EXPECT_DATA_ts6[22]), 
 .BIST_EXPECT_DATA_ts121(BIST_EXPECT_DATA_ts6[23]), .BIST_EXPECT_DATA_ts122(BIST_EXPECT_DATA_ts6[24]), 
 .BIST_EXPECT_DATA_ts123(BIST_EXPECT_DATA_ts6[25]), .BIST_EXPECT_DATA_ts124(BIST_EXPECT_DATA_ts6[26]), 
 .BIST_EXPECT_DATA_ts125(BIST_EXPECT_DATA_ts6[27]), .BIST_EXPECT_DATA_ts126(BIST_EXPECT_DATA_ts6[28]), 
 .BIST_EXPECT_DATA_ts127(BIST_EXPECT_DATA_ts6[29]), .BIST_EXPECT_DATA_ts128(BIST_EXPECT_DATA_ts6[30]), 
 .BIST_EXPECT_DATA_ts129(BIST_EXPECT_DATA_ts6[31]), .BIST_EXPECT_DATA_ts130(BIST_EXPECT_DATA_ts7[0]), 
 .BIST_EXPECT_DATA_ts131(BIST_EXPECT_DATA_ts7[1]), .BIST_EXPECT_DATA_ts132(BIST_EXPECT_DATA_ts7[2]), 
 .BIST_EXPECT_DATA_ts133(BIST_EXPECT_DATA_ts7[3]), .BIST_EXPECT_DATA_ts134(BIST_EXPECT_DATA_ts7[4]), 
 .BIST_EXPECT_DATA_ts135(BIST_EXPECT_DATA_ts7[5]), .BIST_EXPECT_DATA_ts136(BIST_EXPECT_DATA_ts7[6]), 
 .BIST_EXPECT_DATA_ts137(BIST_EXPECT_DATA_ts7[7]), .BIST_EXPECT_DATA_ts138(BIST_EXPECT_DATA_ts7[8]), 
 .BIST_EXPECT_DATA_ts139(BIST_EXPECT_DATA_ts7[9]), .BIST_EXPECT_DATA_ts140(BIST_EXPECT_DATA_ts7[10]), 
 .BIST_EXPECT_DATA_ts141(BIST_EXPECT_DATA_ts7[11]), .BIST_EXPECT_DATA_ts142(BIST_EXPECT_DATA_ts7[12]), 
 .BIST_EXPECT_DATA_ts143(BIST_EXPECT_DATA_ts7[13]), .BIST_EXPECT_DATA_ts144(BIST_EXPECT_DATA_ts7[14]), 
 .BIST_EXPECT_DATA_ts145(BIST_EXPECT_DATA_ts7[15]), .BIST_EXPECT_DATA_ts146(BIST_EXPECT_DATA_ts7[16]), 
 .BIST_EXPECT_DATA_ts147(BIST_EXPECT_DATA_ts7[17]), .BIST_EXPECT_DATA_ts148(BIST_EXPECT_DATA_ts7[18]), 
 .BIST_EXPECT_DATA_ts149(BIST_EXPECT_DATA_ts7[19]), .BIST_EXPECT_DATA_ts150(BIST_EXPECT_DATA_ts7[20]), 
 .BIST_EXPECT_DATA_ts151(BIST_EXPECT_DATA_ts7[21]), .BIST_EXPECT_DATA_ts152(BIST_EXPECT_DATA_ts7[22]), 
 .BIST_EXPECT_DATA_ts153(BIST_EXPECT_DATA_ts8[31:0]), .BIST_EXPECT_DATA_ts154(BIST_EXPECT_DATA_ts9[0]), 
 .BIST_EXPECT_DATA_ts155(BIST_EXPECT_DATA_ts9[1]), .BIST_EXPECT_DATA_ts156(BIST_EXPECT_DATA_ts9[2]), 
 .BIST_EXPECT_DATA_ts157(BIST_EXPECT_DATA_ts9[3]), .BIST_EXPECT_DATA_ts158(BIST_EXPECT_DATA_ts9[4]), 
 .BIST_EXPECT_DATA_ts159(BIST_EXPECT_DATA_ts9[5]), .BIST_EXPECT_DATA_ts160(BIST_EXPECT_DATA_ts9[6]), 
 .BIST_EXPECT_DATA_ts161(BIST_EXPECT_DATA_ts9[7]), .BIST_EXPECT_DATA_ts162(BIST_EXPECT_DATA_ts9[8]), 
 .BIST_EXPECT_DATA_ts163(BIST_EXPECT_DATA_ts9[9]), .BIST_EXPECT_DATA_ts164(BIST_EXPECT_DATA_ts9[10]), 
 .BIST_EXPECT_DATA_ts165(BIST_EXPECT_DATA_ts9[11]), .BIST_EXPECT_DATA_ts166(BIST_EXPECT_DATA_ts9[12]), 
 .BIST_EXPECT_DATA_ts167(BIST_EXPECT_DATA_ts9[13]), .BIST_EXPECT_DATA_ts168(BIST_EXPECT_DATA_ts9[14]), 
 .BIST_EXPECT_DATA_ts169(BIST_EXPECT_DATA_ts9[15]), .BIST_EXPECT_DATA_ts170(BIST_EXPECT_DATA_ts9[16]), 
 .BIST_EXPECT_DATA_ts171(BIST_EXPECT_DATA_ts9[17]), .BIST_EXPECT_DATA_ts172(BIST_EXPECT_DATA_ts9[18]), 
 .BIST_EXPECT_DATA_ts173(BIST_EXPECT_DATA_ts9[19]), .BIST_EXPECT_DATA_ts174(BIST_EXPECT_DATA_ts9[20]), 
 .BIST_EXPECT_DATA_ts175(BIST_EXPECT_DATA_ts9[21]), .BIST_EXPECT_DATA_ts176(BIST_EXPECT_DATA_ts9[22]), 
 .BIST_EXPECT_DATA_ts177(BIST_EXPECT_DATA_ts9[23]), .BIST_EXPECT_DATA_ts178(BIST_EXPECT_DATA_ts9[24]), 
 .BIST_EXPECT_DATA_ts179(BIST_EXPECT_DATA_ts9[25]), .BIST_EXPECT_DATA_ts180(BIST_EXPECT_DATA_ts9[26]), 
 .BIST_EXPECT_DATA_ts181(BIST_EXPECT_DATA_ts9[27]), .BIST_EXPECT_DATA_ts182(BIST_EXPECT_DATA_ts9[28]), 
 .BIST_EXPECT_DATA_ts183(BIST_EXPECT_DATA_ts9[29]), .BIST_EXPECT_DATA_ts184(BIST_EXPECT_DATA_ts9[30]), 
 .BIST_EXPECT_DATA_ts185(BIST_EXPECT_DATA_ts9[31]), .BIST_SHIFT_COLLAR(BIST_SHIFT_COLLAR_ts1), 
 .BIST_SHIFT_COLLAR_ts1(BIST_SHIFT_COLLAR_ts2), .BIST_SHIFT_COLLAR_ts2(BIST_SHIFT_COLLAR_ts3), 
 .BIST_SHIFT_COLLAR_ts3(BIST_SHIFT_COLLAR_ts4), .BIST_SHIFT_COLLAR_ts4(BIST_SHIFT_COLLAR_ts5), 
 .BIST_SHIFT_COLLAR_ts5(BIST_SHIFT_COLLAR_ts6), .BIST_SHIFT_COLLAR_ts6(BIST_SHIFT_COLLAR_ts7), 
 .BIST_SHIFT_COLLAR_ts7(BIST_SHIFT_COLLAR_ts8), .BIST_SHIFT_COLLAR_ts8(BIST_SHIFT_COLLAR_ts9), 
 .BIST_COLLAR_SETUP(BIST_COLLAR_SETUP_ts1), .BIST_COLLAR_SETUP_ts1(BIST_COLLAR_SETUP_ts2), 
 .BIST_COLLAR_SETUP_ts2(BIST_COLLAR_SETUP_ts3), .BIST_COLLAR_SETUP_ts3(BIST_COLLAR_SETUP_ts4), 
 .BIST_COLLAR_SETUP_ts4(BIST_COLLAR_SETUP_ts5), .BIST_COLLAR_SETUP_ts5(BIST_COLLAR_SETUP_ts6), 
 .BIST_COLLAR_SETUP_ts6(BIST_COLLAR_SETUP_ts7), .BIST_COLLAR_SETUP_ts7(BIST_COLLAR_SETUP_ts8), 
 .BIST_COLLAR_SETUP_ts8(BIST_COLLAR_SETUP_ts9), .BIST_CLEAR_DEFAULT(BIST_CLEAR_DEFAULT_ts1), 
 .BIST_CLEAR_DEFAULT_ts1(BIST_CLEAR_DEFAULT_ts2), .BIST_CLEAR_DEFAULT_ts2(BIST_CLEAR_DEFAULT_ts3), 
 .BIST_CLEAR_DEFAULT_ts3(BIST_CLEAR_DEFAULT_ts4), .BIST_CLEAR_DEFAULT_ts4(BIST_CLEAR_DEFAULT_ts5), 
 .BIST_CLEAR_DEFAULT_ts5(BIST_CLEAR_DEFAULT_ts6), .BIST_CLEAR_DEFAULT_ts6(BIST_CLEAR_DEFAULT_ts7), 
 .BIST_CLEAR_DEFAULT_ts7(BIST_CLEAR_DEFAULT_ts8), .BIST_CLEAR_DEFAULT_ts8(BIST_CLEAR_DEFAULT_ts9), 
 .BIST_CLEAR(BIST_CLEAR_ts1), .BIST_CLEAR_ts1(BIST_CLEAR_ts2), 
 .BIST_CLEAR_ts2(BIST_CLEAR_ts3), .BIST_CLEAR_ts3(BIST_CLEAR_ts4), 
 .BIST_CLEAR_ts4(BIST_CLEAR_ts5), .BIST_CLEAR_ts5(BIST_CLEAR_ts6), 
 .BIST_CLEAR_ts6(BIST_CLEAR_ts7), .BIST_CLEAR_ts7(BIST_CLEAR_ts8), 
 .BIST_CLEAR_ts8(BIST_CLEAR_ts9), .BIST_COLLAR_OPSET_SELECT(BIST_COLLAR_OPSET_SELECT_ts1), 
 .BIST_COLLAR_OPSET_SELECT_ts1(BIST_COLLAR_OPSET_SELECT_ts2), 
 .BIST_COLLAR_OPSET_SELECT_ts2(BIST_COLLAR_OPSET_SELECT_ts3), 
 .BIST_COLLAR_OPSET_SELECT_ts3(BIST_COLLAR_OPSET_SELECT_ts4), 
 .BIST_COLLAR_OPSET_SELECT_ts4(BIST_COLLAR_OPSET_SELECT_ts5), 
 .BIST_COLLAR_OPSET_SELECT_ts5(BIST_COLLAR_OPSET_SELECT_ts6), 
 .BIST_COLLAR_OPSET_SELECT_ts6(BIST_COLLAR_OPSET_SELECT_ts7), 
 .BIST_COLLAR_OPSET_SELECT_ts7(BIST_COLLAR_OPSET_SELECT_ts8), 
 .BIST_COLLAR_OPSET_SELECT_ts8(BIST_COLLAR_OPSET_SELECT_ts9), 
 .BIST_COLLAR_HOLD(BIST_COLLAR_HOLD_ts1), .FREEZE_STOP_ERROR(FREEZE_STOP_ERROR_ts1), 
 .ERROR_CNT_ZERO(ERROR_CNT_ZERO_ts1), .BIST_COLLAR_HOLD_ts1(BIST_COLLAR_HOLD_ts2), 
 .FREEZE_STOP_ERROR_ts1(FREEZE_STOP_ERROR_ts2), .ERROR_CNT_ZERO_ts1(ERROR_CNT_ZERO_ts2), 
 .BIST_COLLAR_HOLD_ts2(BIST_COLLAR_HOLD_ts3), .FREEZE_STOP_ERROR_ts2(FREEZE_STOP_ERROR_ts3), 
 .ERROR_CNT_ZERO_ts2(ERROR_CNT_ZERO_ts3), .BIST_COLLAR_HOLD_ts3(BIST_COLLAR_HOLD_ts4), 
 .FREEZE_STOP_ERROR_ts3(FREEZE_STOP_ERROR_ts4), .ERROR_CNT_ZERO_ts3(ERROR_CNT_ZERO_ts4), 
 .BIST_COLLAR_HOLD_ts4(BIST_COLLAR_HOLD_ts5), .FREEZE_STOP_ERROR_ts4(FREEZE_STOP_ERROR_ts5), 
 .ERROR_CNT_ZERO_ts4(ERROR_CNT_ZERO_ts5), .BIST_COLLAR_HOLD_ts5(BIST_COLLAR_HOLD_ts6), 
 .FREEZE_STOP_ERROR_ts5(FREEZE_STOP_ERROR_ts6), .ERROR_CNT_ZERO_ts5(ERROR_CNT_ZERO_ts6), 
 .BIST_COLLAR_HOLD_ts6(BIST_COLLAR_HOLD_ts7), .FREEZE_STOP_ERROR_ts6(FREEZE_STOP_ERROR_ts7), 
 .ERROR_CNT_ZERO_ts6(ERROR_CNT_ZERO_ts7), .BIST_COLLAR_HOLD_ts7(BIST_COLLAR_HOLD_ts8), 
 .FREEZE_STOP_ERROR_ts7(FREEZE_STOP_ERROR_ts8), .ERROR_CNT_ZERO_ts7(ERROR_CNT_ZERO_ts8), 
 .BIST_COLLAR_HOLD_ts8(BIST_COLLAR_HOLD_ts9), .FREEZE_STOP_ERROR_ts8(FREEZE_STOP_ERROR_ts9), 
 .ERROR_CNT_ZERO_ts8(ERROR_CNT_ZERO_ts9), .MBISTPG_RESET_REG_SETUP2(MBISTPG_RESET_REG_SETUP2_ts1), 
 .MBISTPG_RESET_REG_SETUP2_ts1(MBISTPG_RESET_REG_SETUP2_ts2), 
 .MBISTPG_RESET_REG_SETUP2_ts2(MBISTPG_RESET_REG_SETUP2_ts3), 
 .MBISTPG_RESET_REG_SETUP2_ts3(MBISTPG_RESET_REG_SETUP2_ts4), 
 .MBISTPG_RESET_REG_SETUP2_ts4(MBISTPG_RESET_REG_SETUP2_ts5), 
 .MBISTPG_RESET_REG_SETUP2_ts5(MBISTPG_RESET_REG_SETUP2_ts6), 
 .MBISTPG_RESET_REG_SETUP2_ts6(MBISTPG_RESET_REG_SETUP2_ts7), 
 .MBISTPG_RESET_REG_SETUP2_ts7(MBISTPG_RESET_REG_SETUP2_ts8), 
 .MBISTPG_RESET_REG_SETUP2_ts8(MBISTPG_RESET_REG_SETUP2_ts9), 
 .bisr_shift_en_pd_vinf(bisr_shift_en_pd_vinf), .bisr_clk_pd_vinf(bisr_clk_pd_vinf), 
 .bisr_reset_pd_vinf(bisr_reset_pd_vinf), .ram_row_0_col_0_bisr_inst_SO(ram_row_0_col_0_bisr_inst_SO), 
 .ram_row_0_col_0_bisr_inst_SO_ts1(ram_row_0_col_0_bisr_inst_SO_ts1));

logic aary_pwren_b_rf;
logic fary_trigger_post_fwd_rf, aary_post_complete_fwd_rf, aary_post_pass_fwd_rf;
assign fary_trigger_post_fwd_rf = aary_post_complete_fwd_sram;
// assign aary_post_complete = aary_post_complete_fwd_rf;
// assign aary_post_pass = aary_post_pass_fwd_sram & aary_post_pass_fwd_rf;
hlp_fwd_apr_rf_mems u_fwd_apr_rf_mems
(// Manual connections
.fary_trigger_post_fwd_rf,
.aary_post_complete_fwd_rf,
.aary_post_pass_fwd_rf,
 .fary_pwren_b_rf(aary_pwren_b_sram),
 .aary_pwren_b_rf(aary_pwren_b_rf),
 /*AUTOINST*/
 // Outputs
 .aary_post_complete_rf                 (),                      // Templated
 .aary_post_pass_rf                     (),                      // Templated
 .fwd_arp_used_from_mem                 (frm_arp_used[`HLP_FWD_ARP_USED_FROM_MEM_WIDTH-1:0]), // Templated
 // Inputs
 .DFTMASK                               (DFTMASK),
 .DFTSHIFTEN                            (DFTSHIFTEN),
 .DFT_AFD_RESET_B                       (DFT_AFD_RESET_B),
 .DFT_ARRAY_FREEZE                      (DFT_ARRAY_FREEZE),
 .clk                                   (clk_ts1),
 .fary_ffuse_hd2prf_trim                (fary_ffuse_hd2prf_trim[7-1:0]),
 .fary_ffuse_rf_sleep                   (fary_ffuse_rf_sleep[1:0]),
 .fary_isolation_control_in             (isol_en_b),             // Templated
 .fary_output_reset                     (fary_output_reset),
 .fary_trigger_post_rf                  ('0),                    // Templated
 .fscan_clkungate                       (fscan_clkungate),
 .fscan_ram_bypsel_rf                   (fscan_ram_bypsel_rf),
 .fscan_ram_init_en                     (fscan_ram_init_en),
 .fscan_ram_init_val                    (fscan_ram_init_val),
 .fscan_ram_rdis_b                      (fscan_ram_rdis_b),
 .fscan_ram_wdis_b                      (fscan_ram_wdis_b),
 .fsta_dfxact_afd                       (fsta_dfxact_afd),
 .fwd_arp_used_to_mem                   (tom_arp_used[`HLP_FWD_ARP_USED_TO_MEM_WIDTH-1:0]), // Templated
 .ip_reset_b                            (local_broadcast.mem_rst_b), // Templated
 .post_mux_ctrl                         ('0),                    // Templated
 .pwr_mgmt_in_rf                        (pwr_mgmt_in_rf[5-1:0]), .BIST_SETUP(BIST_SETUP[0]), .BIST_SETUP_ts1(BIST_SETUP[1]), 
 .BIST_SETUP_ts2(BIST_SETUP[2]), .to_interfaces_tck(to_interfaces_tck), 
 .mcp_bounding_to_en(mcp_bounding_to_en), .scan_to_en(scan_to_en), 
 .memory_bypass_to_en(memory_bypass_to_en), .GO_ID_REG_SEL(GO_ID_REG_SEL), 
 .BIST_CLEAR_BIRA(BIST_CLEAR_BIRA), .BIST_COLLAR_DIAG_EN(BIST_COLLAR_DIAG_EN), 
 .BIST_COLLAR_BIRA_EN(BIST_COLLAR_BIRA_EN), .PriorityColumn(PriorityColumn), 
 .BIST_SHIFT_BIRA_COLLAR(BIST_SHIFT_BIRA_COLLAR), .CHECK_REPAIR_NEEDED(CHECK_REPAIR_NEEDED), 
 .MEM0_BIST_COLLAR_SI(MEM0_BIST_COLLAR_SI), .BIST_SO(BIST_SO_ts2), .BIST_GO(BIST_GO_ts2), 
 .ltest_to_en(ltest_to_en_ts1), .BIST_READENABLE(BIST_READENABLE), 
 .BIST_WRITEENABLE(BIST_WRITEENABLE), .BIST_CMP(BIST_CMP), 
 .INCLUDE_MEM_RESULTS_REG(INCLUDE_MEM_RESULTS_REG), .BIST_COL_ADD(BIST_COL_ADD), 
 .BIST_ROW_ADD(BIST_ROW_ADD), .BIST_BANK_ADD(BIST_BANK_ADD), .BIST_COLLAR_EN0(BIST_COLLAR_EN0), 
 .BIST_RUN_TO_COLLAR0(BIST_RUN_TO_COLLAR0), .BIST_ASYNC_RESET(BIST_ASYNC_RESET), 
 .BIST_SHADOW_READENABLE(BIST_SHADOW_READENABLE), .BIST_SHADOW_READADDRESS(BIST_SHADOW_READADDRESS), 
 .BIST_CONWRITE_ROWADDRESS(BIST_CONWRITE_ROWADDRESS), .BIST_CONWRITE_ENABLE(BIST_CONWRITE_ENABLE), 
 .BIST_CONREAD_ROWADDRESS(BIST_CONREAD_ROWADDRESS), 
 .BIST_CONREAD_COLUMNADDRESS(BIST_CONREAD_COLUMNADDRESS), 
 .BIST_CONREAD_ENABLE(BIST_CONREAD_ENABLE), .BIST_TESTDATA_SELECT_TO_COLLAR(BIST_TESTDATA_SELECT_TO_COLLAR), 
 .BIST_ON_TO_COLLAR(BIST_ON_TO_COLLAR), .BIST_WRITE_DATA(BIST_WRITE_DATA), 
 .BIST_EXPECT_DATA(BIST_EXPECT_DATA), .BIST_SHIFT_COLLAR(BIST_SHIFT_COLLAR), 
 .BIST_COLLAR_SETUP(BIST_COLLAR_SETUP), .BIST_CLEAR_DEFAULT(BIST_CLEAR_DEFAULT), 
 .BIST_CLEAR(BIST_CLEAR), .BIST_COLLAR_OPSET_SELECT(BIST_COLLAR_OPSET_SELECT), 
 .BIST_COLLAR_HOLD(BIST_COLLAR_HOLD), .FREEZE_STOP_ERROR(FREEZE_STOP_ERROR), 
 .ERROR_CNT_ZERO(ERROR_CNT_ZERO), .MBISTPG_RESET_REG_SETUP2(MBISTPG_RESET_REG_SETUP2), 
 .bisr_shift_en_pd_vinf(bisr_shift_en_pd_vinf), .bisr_clk_pd_vinf(bisr_clk_pd_vinf), 
 .bisr_reset_pd_vinf(bisr_reset_pd_vinf), .bisr_si_pd_vinf(bisr_si_pd_vinf), 
 .ram_row_0_col_0_bisr_inst_SO(ram_row_0_col_0_bisr_inst_SO));

logic aary_pwren_b_tcam;
hlp_fwd_apr_tcam_mems u_fwd_apr_tcam_mems
(// Manual connections
`ifdef HLP_FPGA_TCAM_MEMS
 .fpga_fast_clk(),
`endif
.fary_pwren_b_tcam(aary_pwren_b_rf),
 .aary_pwren_b_tcam(aary_pwren_b_tcam),
 /*AUTOINST*/
 // Outputs
 .fwd_ma_table_tcam_0_from_tcam         (frm_ma_table_tcam[0][`HLP_FWD_MA_TABLE_TCAM_FROM_TCAM_WIDTH-1:0]), // Templated
 .fwd_ma_table_tcam_1_from_tcam         (frm_ma_table_tcam[1][`HLP_FWD_MA_TABLE_TCAM_FROM_TCAM_WIDTH-1:0]), // Templated
 .fwd_ma_table_tcam_2_from_tcam         (frm_ma_table_tcam[2][`HLP_FWD_MA_TABLE_TCAM_FROM_TCAM_WIDTH-1:0]), // Templated
 .fwd_ma_table_tcam_3_from_tcam         (frm_ma_table_tcam[3][`HLP_FWD_MA_TABLE_TCAM_FROM_TCAM_WIDTH-1:0]), // Templated
 // Inputs
 .DFTMASK                               (DFTMASK),
 .DFTSHIFTEN                            (DFTSHIFTEN),
 .DFT_AFD_RESET_B                       (DFT_AFD_RESET_B),
 .DFT_ARRAY_FREEZE                      (DFT_ARRAY_FREEZE),
 .clk                                   (clk_ts1),
 .fary_ffuse_tcam_sleep                 (fary_ffuse_tcam_sleep),
 .fary_ffuse_tune_tcam                  (fary_ffuse_tune_tcam[15:0]),
 .fary_isolation_control_in             (isol_en_b),             // Templated
 .fary_output_reset                     (fary_output_reset),
 .fscan_clkungate                       (fscan_clkungate),
 .fscan_mode                            (fscan_mode),
 .fscan_ram_bypsel_tcam                 (fscan_ram_bypsel_tcam),
 .fscan_ram_init_en                     (fscan_ram_init_en),
 .fscan_ram_init_val                    (fscan_ram_init_val),
 .fscan_ram_rdis_b                      (fscan_ram_rdis_b),
 .fscan_ram_wdis_b                      (fscan_ram_wdis_b),
 .fscan_shiften                         (fscan_shiften),
 .fsta_dfxact_afd                       (fsta_dfxact_afd),
 .fwd_ma_table_tcam_0_to_tcam           (tom_ma_table_tcam[0][`HLP_FWD_MA_TABLE_TCAM_TO_TCAM_WIDTH-1:0]), // Templated
 .fwd_ma_table_tcam_1_to_tcam           (tom_ma_table_tcam[1][`HLP_FWD_MA_TABLE_TCAM_TO_TCAM_WIDTH-1:0]), // Templated
 .fwd_ma_table_tcam_2_to_tcam           (tom_ma_table_tcam[2][`HLP_FWD_MA_TABLE_TCAM_TO_TCAM_WIDTH-1:0]), // Templated
 .fwd_ma_table_tcam_3_to_tcam           (tom_ma_table_tcam[3][`HLP_FWD_MA_TABLE_TCAM_TO_TCAM_WIDTH-1:0]), // Templated
 .ip_reset_b                            (local_broadcast.mem_rst_b), .BIST_SETUP(BIST_SETUP[0]), .BIST_SETUP_ts1(BIST_SETUP[1]), 
 .BIST_SETUP_ts2(BIST_SETUP[2]), .to_interfaces_tck(to_interfaces_tck), 
 .mcp_bounding_to_en(mcp_bounding_to_en), .scan_to_en(scan_to_en), 
 .memory_bypass_to_en(memory_bypass_to_en), .GO_ID_REG_SEL(GO_ID_REG_SEL_ts10), 
 .BIST_CLEAR_BIRA(BIST_CLEAR_BIRA_ts10), .BIST_COLLAR_DIAG_EN(BIST_COLLAR_DIAG_EN_ts10), 
 .BIST_COLLAR_BIRA_EN(BIST_COLLAR_BIRA_EN_ts10), .BIST_SHIFT_BIRA_COLLAR(BIST_SHIFT_BIRA_COLLAR_ts10), 
 .CHECK_REPAIR_NEEDED(CHECK_REPAIR_NEEDED), .MEM0_BIST_COLLAR_SI(MEM0_BIST_COLLAR_SI_ts10), 
 .MEM1_BIST_COLLAR_SI(MEM1_BIST_COLLAR_SI_ts8), .MEM2_BIST_COLLAR_SI(MEM2_BIST_COLLAR_SI_ts6), 
 .MEM3_BIST_COLLAR_SI(MEM3_BIST_COLLAR_SI_ts5), .MEM4_BIST_COLLAR_SI(MEM4_BIST_COLLAR_SI_ts5), 
 .MEM5_BIST_COLLAR_SI(MEM5_BIST_COLLAR_SI_ts5), .MEM6_BIST_COLLAR_SI(MEM6_BIST_COLLAR_SI_ts5), 
 .MEM7_BIST_COLLAR_SI(MEM7_BIST_COLLAR_SI_ts5), .BIST_SO(BIST_SO_ts133), 
 .BIST_SO_ts1(BIST_SO_ts134), .BIST_SO_ts2(BIST_SO_ts135), .BIST_SO_ts3(BIST_SO_ts136), 
 .BIST_SO_ts4(BIST_SO_ts137), .BIST_SO_ts5(BIST_SO_ts138), .BIST_SO_ts6(BIST_SO_ts139), 
 .BIST_SO_ts7(BIST_SO_ts140), .BIST_GO(BIST_GO_ts133), .BIST_GO_ts1(BIST_GO_ts134), 
 .BIST_GO_ts2(BIST_GO_ts135), .BIST_GO_ts3(BIST_GO_ts136), .BIST_GO_ts4(BIST_GO_ts137), 
 .BIST_GO_ts5(BIST_GO_ts138), .BIST_GO_ts6(BIST_GO_ts139), .BIST_GO_ts7(BIST_GO_ts140), 
 .ltest_to_en(ltest_to_en_ts1), .BIST_USER9(BIST_USER9), .BIST_USER10(BIST_USER10), 
 .BIST_USER11(BIST_USER11), .BIST_USER0(BIST_USER0), .BIST_USER1(BIST_USER1), 
 .BIST_USER2(BIST_USER2), .BIST_USER3(BIST_USER3), .BIST_USER4(BIST_USER4), 
 .BIST_USER5(BIST_USER5), .BIST_USER6(BIST_USER6), .BIST_USER7(BIST_USER7), 
 .BIST_USER8(BIST_USER8), .BIST_EVEN_GROUPWRITEENABLE(BIST_EVEN_GROUPWRITEENABLE), 
 .BIST_ODD_GROUPWRITEENABLE(BIST_ODD_GROUPWRITEENABLE), .BIST_WRITEENABLE(BIST_WRITEENABLE_ts10), 
 .BIST_READENABLE(BIST_READENABLE_ts1), .BIST_SELECT(BIST_SELECT_ts9), 
 .BIST_CMP(BIST_CMP_ts10), .INCLUDE_MEM_RESULTS_REG(INCLUDE_MEM_RESULTS_REG), 
 .BIST_COL_ADD(BIST_COL_ADD_ts10), .BIST_ROW_ADD(BIST_ROW_ADD_ts10[0]), 
 .BIST_ROW_ADD_ts1(BIST_ROW_ADD_ts10[1]), .BIST_ROW_ADD_ts2(BIST_ROW_ADD_ts10[2]), 
 .BIST_ROW_ADD_ts3(BIST_ROW_ADD_ts10[3]), .BIST_ROW_ADD_ts4(BIST_ROW_ADD_ts10[4]), 
 .BIST_ROW_ADD_ts5(BIST_ROW_ADD_ts10[5]), .BIST_BANK_ADD(BIST_BANK_ADD_ts7[0]), 
 .BIST_BANK_ADD_ts1(BIST_BANK_ADD_ts7[1]), .BIST_BANK_ADD_ts2(BIST_BANK_ADD_ts7[2]), 
 .BIST_COLLAR_EN0(BIST_COLLAR_EN0_ts10), .BIST_COLLAR_EN1(BIST_COLLAR_EN1_ts8), 
 .BIST_COLLAR_EN2(BIST_COLLAR_EN2_ts6), .BIST_COLLAR_EN3(BIST_COLLAR_EN3_ts5), 
 .BIST_COLLAR_EN4(BIST_COLLAR_EN4_ts5), .BIST_COLLAR_EN5(BIST_COLLAR_EN5_ts5), 
 .BIST_COLLAR_EN6(BIST_COLLAR_EN6_ts5), .BIST_COLLAR_EN7(BIST_COLLAR_EN7_ts5), 
 .BIST_RUN_TO_COLLAR0(BIST_RUN_TO_COLLAR0_ts10), .BIST_RUN_TO_COLLAR1(BIST_RUN_TO_COLLAR1_ts8), 
 .BIST_RUN_TO_COLLAR2(BIST_RUN_TO_COLLAR2_ts6), .BIST_RUN_TO_COLLAR3(BIST_RUN_TO_COLLAR3_ts5), 
 .BIST_RUN_TO_COLLAR4(BIST_RUN_TO_COLLAR4_ts5), .BIST_RUN_TO_COLLAR5(BIST_RUN_TO_COLLAR5_ts5), 
 .BIST_RUN_TO_COLLAR6(BIST_RUN_TO_COLLAR6_ts5), .BIST_RUN_TO_COLLAR7(BIST_RUN_TO_COLLAR7_ts5), 
 .BIST_ASYNC_RESET(BIST_ASYNC_RESET), .BIST_TESTDATA_SELECT_TO_COLLAR(BIST_TESTDATA_SELECT_TO_COLLAR_ts10), 
 .BIST_ON_TO_COLLAR(BIST_ON_TO_COLLAR_ts10), .BIST_WRITE_DATA(BIST_WRITE_DATA_ts10[0]), 
 .BIST_WRITE_DATA_ts1(BIST_WRITE_DATA_ts10[1]), .BIST_WRITE_DATA_ts2(BIST_WRITE_DATA_ts10[2]), 
 .BIST_WRITE_DATA_ts3(BIST_WRITE_DATA_ts10[3]), .BIST_WRITE_DATA_ts4(BIST_WRITE_DATA_ts10[4]), 
 .BIST_WRITE_DATA_ts5(BIST_WRITE_DATA_ts10[5]), .BIST_WRITE_DATA_ts6(BIST_WRITE_DATA_ts10[6]), 
 .BIST_WRITE_DATA_ts7(BIST_WRITE_DATA_ts10[7]), .BIST_WRITE_DATA_ts8(BIST_WRITE_DATA_ts10[8]), 
 .BIST_WRITE_DATA_ts9(BIST_WRITE_DATA_ts10[9]), .BIST_WRITE_DATA_ts10(BIST_WRITE_DATA_ts10[10]), 
 .BIST_WRITE_DATA_ts11(BIST_WRITE_DATA_ts10[11]), .BIST_WRITE_DATA_ts12(BIST_WRITE_DATA_ts10[12]), 
 .BIST_WRITE_DATA_ts13(BIST_WRITE_DATA_ts10[13]), .BIST_WRITE_DATA_ts14(BIST_WRITE_DATA_ts10[14]), 
 .BIST_WRITE_DATA_ts15(BIST_WRITE_DATA_ts10[15]), .BIST_WRITE_DATA_ts16(BIST_WRITE_DATA_ts10[16]), 
 .BIST_WRITE_DATA_ts17(BIST_WRITE_DATA_ts10[17]), .BIST_WRITE_DATA_ts18(BIST_WRITE_DATA_ts10[18]), 
 .BIST_WRITE_DATA_ts19(BIST_WRITE_DATA_ts10[19]), .BIST_WRITE_DATA_ts20(BIST_WRITE_DATA_ts10[20]), 
 .BIST_WRITE_DATA_ts21(BIST_WRITE_DATA_ts10[21]), .BIST_WRITE_DATA_ts22(BIST_WRITE_DATA_ts10[22]), 
 .BIST_WRITE_DATA_ts23(BIST_WRITE_DATA_ts10[23]), .BIST_WRITE_DATA_ts24(BIST_WRITE_DATA_ts10[24]), 
 .BIST_WRITE_DATA_ts25(BIST_WRITE_DATA_ts10[25]), .BIST_WRITE_DATA_ts26(BIST_WRITE_DATA_ts10[26]), 
 .BIST_WRITE_DATA_ts27(BIST_WRITE_DATA_ts10[27]), .BIST_WRITE_DATA_ts28(BIST_WRITE_DATA_ts10[28]), 
 .BIST_WRITE_DATA_ts29(BIST_WRITE_DATA_ts10[29]), .BIST_WRITE_DATA_ts30(BIST_WRITE_DATA_ts10[30]), 
 .BIST_WRITE_DATA_ts31(BIST_WRITE_DATA_ts10[31]), .BIST_EXPECT_DATA(BIST_EXPECT_DATA_ts10[0]), 
 .BIST_EXPECT_DATA_ts1(BIST_EXPECT_DATA_ts10[1]), .BIST_EXPECT_DATA_ts2(BIST_EXPECT_DATA_ts10[2]), 
 .BIST_EXPECT_DATA_ts3(BIST_EXPECT_DATA_ts10[3]), .BIST_EXPECT_DATA_ts4(BIST_EXPECT_DATA_ts10[4]), 
 .BIST_EXPECT_DATA_ts5(BIST_EXPECT_DATA_ts10[5]), .BIST_EXPECT_DATA_ts6(BIST_EXPECT_DATA_ts10[6]), 
 .BIST_EXPECT_DATA_ts7(BIST_EXPECT_DATA_ts10[7]), .BIST_EXPECT_DATA_ts8(BIST_EXPECT_DATA_ts10[8]), 
 .BIST_EXPECT_DATA_ts9(BIST_EXPECT_DATA_ts10[9]), .BIST_EXPECT_DATA_ts10(BIST_EXPECT_DATA_ts10[10]), 
 .BIST_EXPECT_DATA_ts11(BIST_EXPECT_DATA_ts10[11]), .BIST_EXPECT_DATA_ts12(BIST_EXPECT_DATA_ts10[12]), 
 .BIST_EXPECT_DATA_ts13(BIST_EXPECT_DATA_ts10[13]), .BIST_EXPECT_DATA_ts14(BIST_EXPECT_DATA_ts10[14]), 
 .BIST_EXPECT_DATA_ts15(BIST_EXPECT_DATA_ts10[15]), .BIST_EXPECT_DATA_ts16(BIST_EXPECT_DATA_ts10[16]), 
 .BIST_EXPECT_DATA_ts17(BIST_EXPECT_DATA_ts10[17]), .BIST_EXPECT_DATA_ts18(BIST_EXPECT_DATA_ts10[18]), 
 .BIST_EXPECT_DATA_ts19(BIST_EXPECT_DATA_ts10[19]), .BIST_EXPECT_DATA_ts20(BIST_EXPECT_DATA_ts10[20]), 
 .BIST_EXPECT_DATA_ts21(BIST_EXPECT_DATA_ts10[21]), .BIST_EXPECT_DATA_ts22(BIST_EXPECT_DATA_ts10[22]), 
 .BIST_EXPECT_DATA_ts23(BIST_EXPECT_DATA_ts10[23]), .BIST_EXPECT_DATA_ts24(BIST_EXPECT_DATA_ts10[24]), 
 .BIST_EXPECT_DATA_ts25(BIST_EXPECT_DATA_ts10[25]), .BIST_EXPECT_DATA_ts26(BIST_EXPECT_DATA_ts10[26]), 
 .BIST_EXPECT_DATA_ts27(BIST_EXPECT_DATA_ts10[27]), .BIST_EXPECT_DATA_ts28(BIST_EXPECT_DATA_ts10[28]), 
 .BIST_EXPECT_DATA_ts29(BIST_EXPECT_DATA_ts10[29]), .BIST_EXPECT_DATA_ts30(BIST_EXPECT_DATA_ts10[30]), 
 .BIST_EXPECT_DATA_ts31(BIST_EXPECT_DATA_ts10[31]), .BIST_SHIFT_COLLAR(BIST_SHIFT_COLLAR_ts10), 
 .BIST_COLLAR_SETUP(BIST_COLLAR_SETUP_ts10), .BIST_CLEAR_DEFAULT(BIST_CLEAR_DEFAULT_ts10), 
 .BIST_CLEAR(BIST_CLEAR_ts10), .BIST_COLLAR_OPSET_SELECT(BIST_COLLAR_OPSET_SELECT_ts10[0]), 
 .BIST_COLLAR_OPSET_SELECT_ts1(BIST_COLLAR_OPSET_SELECT_ts10[1]), 
 .BIST_COLLAR_HOLD(BIST_COLLAR_HOLD_ts10), .FREEZE_STOP_ERROR(FREEZE_STOP_ERROR_ts10), 
 .ERROR_CNT_ZERO(ERROR_CNT_ZERO_ts10), .MBISTPG_RESET_REG_SETUP2(MBISTPG_RESET_REG_SETUP2_ts10), 
 .bisr_shift_en_pd_vinf(bisr_shift_en_pd_vinf), .bisr_clk_pd_vinf(bisr_clk_pd_vinf), 
 .bisr_reset_pd_vinf(bisr_reset_pd_vinf), .ram_row_0_col_0_bisr_inst_SO(ram_row_0_col_0_bisr_inst_SO_ts1), 
 .tcam_row_1_col_0_bisr_inst_SO(bisr_so_pd_vinf)); // Templated

assign fet_ack_b = aary_pwren_b_tcam;
/*
 hlp_fwd_apr_func_logic AUTO_TEMPLATE
 ( .o_tom_\(.*\) (tom_\1[][]),
   .i_frm_\(.*\) (frm_\1[][]),
   .mem_rst_n (local_broadcast.mem_rst_b),
   .o_post_cntrlr_select_sram (post_cntrlr_select_sram_from_apr),
   .i_trigger_post_sram  (trigger_post_to_apr),
   .i_post_complete_sram (post_complete_to_apr),
   .i_post_pass_sram     (post_pass_to_apr),
   .i_broadcast  (local_broadcast) );
*/
hlp_fwd_apr_func_logic u_fwd_apr_func_logic
(
`ifndef __VISA_IT__
`ifndef INTEL_GLOBAL_VISA_DISABLE

(* inserted_by="VISA IT" *) .visaRt_cfg_rd_bus_out_from_u_fwd_apr_func_logic_visa_unit_mux_regout_0({visaSerCfgRd_fwd_ngvisa_top_junc[0][1:0]}),
(* inserted_by="VISA IT" *) .visaRt_cfg_rd_bus_out_from_u_fwd_apr_func_logic_visa_unit_mux_regout_1({visaSerCfgRd_fwd_ngvisa_top_junc[1][1:0]}),
(* inserted_by="VISA IT" *) .visaRt_cfg_rd_bus_out_from_u_fwd_apr_func_logic_visa_unit_mux_regout_2({visaSerCfgRd_fwd_ngvisa_top_junc[2][1:0]}),
(* inserted_by="VISA IT" *) .visaRt_cfg_wr_bus_in_to_parhlpparser_parser_apr_parser_ngvisa_top_junc(visaRt_cfg_wr_bus_in_from_parhlpfwd_fwd_apr_fwd_ngvisa_top_junc),
(* inserted_by="VISA IT" *) .visaRt_clk_from_u_fwd_apr_func_logic(visaRt_clk_from_u_fwd_apr_func_logic),
(* inserted_by="VISA IT" *) .visaRt_enable_from_u_fwd_apr_func_logic(visaRt_enable_from_u_fwd_apr_func_logic),
(* inserted_by="VISA IT" *) .visaRt_fscan_byprst_b_to_fwd_ngvisa_top_junc(fscan_byprst_b),
(* inserted_by="VISA IT" *) .visaRt_fscan_clkungate_to_fwd_ngvisa_top_junc(fscan_clkungate),
(* inserted_by="VISA IT" *) .visaRt_fscan_rstbypen_to_fwd_ngvisa_top_junc(fscan_rstbypen),
(* inserted_by="VISA IT" *) .visaRt_lane_out_from_u_fwd_apr_func_logic_visa_unit_mux_regout_0({visaLaneIn_fwd_ngvisa_top_junc[1:0]}),
(* inserted_by="VISA IT" *) .visaRt_lane_out_from_u_fwd_apr_func_logic_visa_unit_mux_regout_1({visaLaneIn_fwd_ngvisa_top_junc[3:2]}),
(* inserted_by="VISA IT" *) .visaRt_lane_out_from_u_fwd_apr_func_logic_visa_unit_mux_regout_2({visaLaneIn_fwd_ngvisa_top_junc[5:4]}),
(* inserted_by="VISA IT" *) .visaRt_lane_valid_out_from_u_fwd_apr_func_logic_visa_unit_mux_regout_0(visaLaneValidIn_fwd_ngvisa_top_junc[1:0]),
(* inserted_by="VISA IT" *) .visaRt_lane_valid_out_from_u_fwd_apr_func_logic_visa_unit_mux_regout_1(visaLaneValidIn_fwd_ngvisa_top_junc[3:2]),
(* inserted_by="VISA IT" *) .visaRt_lane_valid_out_from_u_fwd_apr_func_logic_visa_unit_mux_regout_2(visaLaneValidIn_fwd_ngvisa_top_junc[5:4]),
(* inserted_by="VISA IT" *) .visaRt_resetb_from_u_fwd_apr_func_logic(visaRt_resetb_from_u_fwd_apr_func_logic),
(* inserted_by="VISA IT" *) .visaRt_unit_id_to_parhlpfwd_fwd_apr_u_fwd_apr_func_logic_visa_unit_mux_regout_0(visaRt_unit_id_to_parhlpfwd_fwd_apr_u_fwd_apr_func_logic_visa_unit_mux_regout_0),
(* inserted_by="VISA IT" *) .visaRt_unit_id_to_parhlpfwd_fwd_apr_u_fwd_apr_func_logic_visa_unit_mux_regout_1(visaRt_unit_id_to_parhlpfwd_fwd_apr_u_fwd_apr_func_logic_visa_unit_mux_regout_1),
(* inserted_by="VISA IT" *) .visaRt_unit_id_to_parhlpfwd_fwd_apr_u_fwd_apr_func_logic_visa_unit_mux_regout_2(visaRt_unit_id_to_parhlpfwd_fwd_apr_u_fwd_apr_func_logic_visa_unit_mux_regout_2),


`endif // INTEL_GLOBAL_VISA_DISABLE
`endif // __VISA_IT__
 // Auto Included by VISA IT - *** Do not modify this line ***
 .fet_ack_b(fet_ack_b_from_fl),
.fet_en_b (fet_en_b),
.o_post_complete_sram (post_complete_from_apr),
.o_post_pass_sram     (post_pass_from_apr),
.o_trigger_post_sram  (trigger_post_from_apr),
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
 .ascan_sdo                             (ascan_sdo[hlp_dfx_pkg::FWD_NUM_SDO-1:0]),
 .o_eop                                 (o_eop),
 .o_fwd_to_tail                         (o_fwd_to_tail),
 .o_fwd_to_tail_v                       (o_fwd_to_tail_v),
 .o_mgmt_to_fcmn                        (o_mgmt_to_fcmn),
 .o_mgmt_to_fcmn_v                      (o_mgmt_to_fcmn_v),
 .o_pm_head_padding                     (o_pm_head_padding[37:0]),
 .o_pol_in_early                        (o_pol_in_early),
 .o_pol_in_early_v                      (o_pol_in_early_v),
 .o_post_cntrlr_select_sram             (post_cntrlr_select_sram_from_apr), // Templated
 .o_rpl_bkwd                            (o_rpl_bkwd),
 .o_rpl_frwd                            (o_rpl_frwd),
 .o_sop_info                            (o_sop_info),
 .o_sop_info_v                          (o_sop_info_v),
 .o_tail_info                           (o_tail_info),
 .o_tail_info_v                         (o_tail_info_v),
 .o_tom_arp_table                       (tom_arp_table/*[1:0][`HLP_FWD_ARP_TABLE_TO_MEM_WIDTH-1:0]*/), // Templated
 .o_tom_arp_used                        (tom_arp_used[`HLP_FWD_ARP_USED_TO_MEM_WIDTH-1:0]), // Templated
 .o_tom_egress_mst_table                (tom_egress_mst_table[`HLP_FWD_EGRESS_MST_TABLE_TO_MEM_WIDTH-1:0]), // Templated
 .o_tom_egress_vid_table                (tom_egress_vid_table[`HLP_FWD_EGRESS_VID_TABLE_TO_MEM_WIDTH-1:0]), // Templated
 .o_tom_flood_glort                     (tom_flood_glort[`HLP_FWD_FLOOD_GLORT_TO_MEM_WIDTH-1:0]), // Templated
 .o_tom_fwdport_cfg2                    (tom_fwdport_cfg2[`HLP_FWD_FWDPORT_CFG2_TO_MEM_WIDTH-1:0]), // Templated
 .o_tom_glort_dest_table                (tom_glort_dest_table[`HLP_FWD_GLORT_DEST_TABLE_TO_MEM_WIDTH-1:0]), // Templated
 .o_tom_ingress_mst_table               (tom_ingress_mst_table[`HLP_FWD_INGRESS_MST_TABLE_TO_MEM_WIDTH-1:0]), // Templated
 .o_tom_ingress_vid_table               (tom_ingress_vid_table[`HLP_FWD_INGRESS_VID_TABLE_TO_MEM_WIDTH-1:0]), // Templated
 .o_tom_ma_aging_table                  (tom_ma_aging_table[`HLP_FWD_MA_AGING_TABLE_TO_MEM_WIDTH-1:0]), // Templated
 .o_tom_ma_dirty_table                  (tom_ma_dirty_table[`HLP_FWD_MA_DIRTY_TABLE_TO_MEM_WIDTH-1:0]), // Templated
 .o_tom_ma_table_hash                   (tom_ma_table_hash/*[9:0][`HLP_FWD_MA_TABLE_HASH_TO_MEM_WIDTH-1:0]*/), // Templated
 .o_tom_ma_table_ram                    (tom_ma_table_ram/*[1:0][`HLP_FWD_MA_TABLE_RAM_TO_MEM_WIDTH-1:0]*/), // Templated
 .o_tom_ma_table_tcam                   (tom_ma_table_tcam/*[3:0][`HLP_FWD_MA_TABLE_TCAM_TO_TCAM_WIDTH-1:0]*/), // Templated
 // Inputs
 .isol_en_b                             (isol_en_b),
 .fvisa_serstb                          (fvisa_serstb),
 .fvisa_frame                           (fvisa_frame),
 .fvisa_serdata                         (fvisa_serdata),
 .fvisa_rddata                          (fvisa_rddata),
 .fvisa_customer_dis                    (fvisa_customer_dis),
 .fvisa_all_dis                         (fvisa_all_dis),
 .fvisa_dbg_lane                        (fvisa_dbg_lane[hlp_dfx_pkg::VISA_DBG_LANE_WIDTH-1:0]),
 .fvisa_clk                             (fvisa_clk[hlp_dfx_pkg::NUM_VISA_LANES-1:0]),
 .fvisa_unit_id                         (fvisa_unit_id[8:0]),
 .fvisa_resetb                          (fvisa_resetb),
 .fscan_ret_ctrl                        (fscan_ret_ctrl),
 .fscan_shiften                         (fscan_shiften),
 .fscan_latchopen                       (fscan_latchopen),
 .fscan_latchclosed_b                   (fscan_latchclosed_b),
 .fscan_clkungate                       (fscan_clkungate),
 .fscan_clkungate_syn                   (fscan_clkungate_syn),
 .fscan_mode                            (fscan_mode),
 .fscan_mode_atspeed                    (fscan_mode_atspeed),
 .fscan_clkgenctrl                      (fscan_clkgenctrl[hlp_dfx_pkg::FWD_NUM_CLKGENCTRL-1:0]),
 .fscan_clkgenctrlen                    (fscan_clkgenctrlen[hlp_dfx_pkg::FWD_NUM_CLKGENCTRLEN-1:0]),
 .fscan_sdi                             (fscan_sdi[hlp_dfx_pkg::FWD_NUM_SDI-1:0]),
 .clk                                   (clk_ts1),
 .fscan_byprst_b                        (fscan_byprst_b),
 .fscan_rstbypen                        (fscan_rstbypen),
 .i_broadcast                           (local_broadcast),       // Templated
 .i_cm_apply                            (i_cm_apply),
 .i_cm_apply_v                          (i_cm_apply_v),
 .i_ffu_to_fwd                          (i_ffu_to_fwd),
 .i_frm_arp_table                       (frm_arp_table/*[1:0][`HLP_FWD_ARP_TABLE_FROM_MEM_WIDTH-1:0]*/), // Templated
 .i_frm_arp_used                        (frm_arp_used[`HLP_FWD_ARP_USED_FROM_MEM_WIDTH-1:0]), // Templated
 .i_frm_egress_mst_table                (frm_egress_mst_table[`HLP_FWD_EGRESS_MST_TABLE_FROM_MEM_WIDTH-1:0]), // Templated
 .i_frm_egress_vid_table                (frm_egress_vid_table[`HLP_FWD_EGRESS_VID_TABLE_FROM_MEM_WIDTH-1:0]), // Templated
 .i_frm_flood_glort                     (frm_flood_glort[`HLP_FWD_FLOOD_GLORT_FROM_MEM_WIDTH-1:0]), // Templated
 .i_frm_fwdport_cfg2                    (frm_fwdport_cfg2[`HLP_FWD_FWDPORT_CFG2_FROM_MEM_WIDTH-1:0]), // Templated
 .i_frm_glort_dest_table                (frm_glort_dest_table[`HLP_FWD_GLORT_DEST_TABLE_FROM_MEM_WIDTH-1:0]), // Templated
 .i_frm_ingress_mst_table               (frm_ingress_mst_table[`HLP_FWD_INGRESS_MST_TABLE_FROM_MEM_WIDTH-1:0]), // Templated
 .i_frm_ingress_vid_table               (frm_ingress_vid_table[`HLP_FWD_INGRESS_VID_TABLE_FROM_MEM_WIDTH-1:0]), // Templated
 .i_frm_ma_aging_table                  (frm_ma_aging_table[`HLP_FWD_MA_AGING_TABLE_FROM_MEM_WIDTH-1:0]), // Templated
 .i_frm_ma_dirty_table                  (frm_ma_dirty_table[`HLP_FWD_MA_DIRTY_TABLE_FROM_MEM_WIDTH-1:0]), // Templated
 .i_frm_ma_table_hash                   (frm_ma_table_hash/*[9:0][`HLP_FWD_MA_TABLE_HASH_FROM_MEM_WIDTH-1:0]*/), // Templated
 .i_frm_ma_table_ram                    (frm_ma_table_ram/*[1:0][`HLP_FWD_MA_TABLE_RAM_FROM_MEM_WIDTH-1:0]*/), // Templated
 .i_frm_ma_table_tcam                   (frm_ma_table_tcam/*[3:0][`HLP_FWD_MA_TABLE_TCAM_FROM_TCAM_WIDTH-1:0]*/), // Templated
 .i_head_v                              (i_head_v),
 .i_l2l_info                            (i_l2l_info),
 .i_mgmt_frm_fcmn                       (i_mgmt_frm_fcmn),
 .i_mgmt_frm_fcmn_v                     (i_mgmt_frm_fcmn_v),
 .i_pkt_meta                            (i_pkt_meta),
 .i_pkt_meta_v                          (i_pkt_meta_v),
 .i_post_complete_sram                  (post_complete_to_apr),  // Templated
 .i_post_pass_sram                      (post_pass_to_apr),      // Templated
 .i_rpl_bkwd                            (i_rpl_bkwd),
 .i_rpl_frwd                            (i_rpl_frwd),
 .i_sop_info                            (i_sop_info),
 .i_sop_info_v                          (i_sop_info_v),
 .i_tail_info                           (i_tail_info),
 .i_tail_info_v                         (i_tail_info_v),
 .i_tail_to_l2l                         (i_tail_to_l2l),
 .i_tail_to_l2l_v                       (i_tail_to_l2l_v),
 .i_tail_to_lag                         (i_tail_to_lag),
 .i_tail_to_trig                        (i_tail_to_trig),
 .i_trigger_post_sram                   (trigger_post_to_apr),   // Templated
 .rst_n                                 (local_rst_n));



`include "hlp_fwd_apr.VISA_IT.hlp_fwd_apr.logic.sv" // Auto Included by VISA IT - *** Do not modify this line ***

  hlp_fwd_apr_rtl_tessent_sib_1 hlp_fwd_apr_rtl_tessent_sib_sti_inst(
      .ijtag_reset(fary_ijtag_rst_b), .ijtag_sel(fary_ijtag_select), .ijtag_si(fary_ijtag_si), 
      .ijtag_ce(fary_ijtag_capture), .ijtag_se(fary_ijtag_shift), .ijtag_ue(fary_ijtag_update), 
      .ijtag_tck(fary_ijtag_tck), .ijtag_so(hlp_fwd_apr_rtl_tessent_sib_sti_inst_so), 
      .ijtag_from_so(hlp_fwd_apr_rtl_tessent_sib_mbist_inst_so), .ltest_si(1'b0), 
      .ltest_scan_en(DFTSHIFTEN), .ltest_en(fscan_mode), .ltest_clk(clk_rscclk), 
      .ltest_mem_bypass_en(DFTMASK), .ltest_mcp_bounding_en(fscan_ram_init_en), 
      .ltest_async_set_reset_static_disable(fscan_byprst_b), .ijtag_to_tck(ijtag_to_tck), 
      .ijtag_to_reset(ijtag_to_reset), .ijtag_to_si(hlp_fwd_apr_rtl_tessent_sib_sti_inst_so_ts1), 
      .ijtag_to_ce(ijtag_to_ce), .ijtag_to_se(ijtag_to_se), .ijtag_to_ue(ijtag_to_ue), 
      .ltest_so(), .ltest_to_en(ltest_to_en), .ltest_to_mem_bypass_en(ltest_to_mem_bypass_en), 
      .ltest_to_mcp_bounding_en(ltest_to_mcp_bounding_en), .ltest_to_scan_en(ltest_to_scan_en), 
      .ijtag_to_sel(hlp_fwd_apr_rtl_tessent_sib_sti_inst_to_select)
  );

  hlp_fwd_apr_rtl_tessent_sib_2 hlp_fwd_apr_rtl_tessent_sib_sri_inst(
      .ijtag_reset(fary_ijtag_rst_b), .ijtag_sel(fary_ijtag_select), .ijtag_si(hlp_fwd_apr_rtl_tessent_sib_sti_inst_so), 
      .ijtag_ce(fary_ijtag_capture), .ijtag_se(fary_ijtag_shift), .ijtag_ue(fary_ijtag_update), 
      .ijtag_tck(fary_ijtag_tck), .ijtag_so(aary_ijtag_so), .ijtag_from_so(hlp_fwd_apr_rtl_tessent_sib_sri_ctrl_inst_so), 
      .ijtag_to_sel(hlp_fwd_apr_rtl_tessent_sib_sri_inst_to_select)
  );

  hlp_fwd_apr_rtl_tessent_sib_3 hlp_fwd_apr_rtl_tessent_sib_sri_ctrl_inst(
      .ijtag_reset(fary_ijtag_rst_b), .ijtag_sel(hlp_fwd_apr_rtl_tessent_sib_sri_inst_to_select), 
      .ijtag_si(hlp_fwd_apr_rtl_tessent_sib_sti_inst_so), .ijtag_ce(fary_ijtag_capture), 
      .ijtag_se(fary_ijtag_shift), .ijtag_ue(fary_ijtag_update), .ijtag_tck(fary_ijtag_tck), 
      .ijtag_so(hlp_fwd_apr_rtl_tessent_sib_sri_ctrl_inst_so), .ijtag_from_so(hlp_fwd_apr_rtl_tessent_tdr_sri_ctrl_inst_so), 
      .ijtag_to_sel(hlp_fwd_apr_rtl_tessent_sib_sri_ctrl_inst_to_select)
  );

  hlp_fwd_apr_rtl_tessent_tdr_sri_ctrl hlp_fwd_apr_rtl_tessent_tdr_sri_ctrl_inst(
      .ijtag_reset(fary_ijtag_rst_b), .ijtag_sel(hlp_fwd_apr_rtl_tessent_sib_sri_ctrl_inst_to_select), 
      .ijtag_si(hlp_fwd_apr_rtl_tessent_sib_sti_inst_so), .ijtag_ce(fary_ijtag_capture), 
      .ijtag_se(fary_ijtag_shift), .ijtag_ue(fary_ijtag_update), .ijtag_tck(fary_ijtag_tck), 
      .tck_select(tck_select), .all_test(), .ijtag_so(hlp_fwd_apr_rtl_tessent_tdr_sri_ctrl_inst_so)
  );

  hlp_fwd_apr_rtl_tessent_sib_4 hlp_fwd_apr_rtl_tessent_sib_algo_select_sib_inst(
      .ijtag_reset(ijtag_to_reset), .ijtag_sel(hlp_fwd_apr_rtl_tessent_sib_sti_inst_to_select), 
      .ijtag_si(hlp_fwd_apr_rtl_tessent_sib_sti_inst_so_ts1), .ijtag_ce(ijtag_to_ce), 
      .ijtag_se(ijtag_to_se), .ijtag_ue(ijtag_to_ue), .ijtag_tck(ijtag_to_tck), 
      .ijtag_so(hlp_fwd_apr_rtl_tessent_sib_algo_select_sib_inst_so), .ijtag_from_so(hlp_fwd_apr_rtl_tessent_tdr_RF_c1_algo_select_tdr_inst_so), 
      .ijtag_to_sel(hlp_fwd_apr_rtl_tessent_sib_algo_select_sib_inst_to_select)
  );

  hlp_fwd_apr_rtl_tessent_sib_4 hlp_fwd_apr_rtl_tessent_sib_mbist_inst(
      .ijtag_reset(ijtag_to_reset), .ijtag_sel(hlp_fwd_apr_rtl_tessent_sib_sti_inst_to_select), 
      .ijtag_si(hlp_fwd_apr_rtl_tessent_sib_algo_select_sib_inst_so), .ijtag_ce(ijtag_to_ce), 
      .ijtag_se(ijtag_to_se), .ijtag_ue(ijtag_to_ue), .ijtag_tck(ijtag_to_tck), 
      .ijtag_so(hlp_fwd_apr_rtl_tessent_sib_mbist_inst_so), .ijtag_from_so(ijtag_so), 
      .ijtag_to_sel(ijtag_to_sel)
  );

  hlp_fwd_apr_rtl_tessent_tdr_TCAM_c11_algo_select_tdr hlp_fwd_apr_rtl_tessent_tdr_TCAM_c11_algo_select_tdr_inst(
      .ijtag_reset(ijtag_to_reset), .ijtag_sel(hlp_fwd_apr_rtl_tessent_sib_algo_select_sib_inst_to_select), 
      .ijtag_si(hlp_fwd_apr_rtl_tessent_sib_sti_inst_so_ts1), .ijtag_ce(ijtag_to_ce), 
      .ijtag_se(ijtag_to_se), .ijtag_ue(ijtag_to_ue), .ijtag_tck(ijtag_to_tck), 
      .ALGO_SEL_REG(ALGO_SEL_REG_ts10), .ijtag_so(hlp_fwd_apr_rtl_tessent_tdr_TCAM_c11_algo_select_tdr_inst_so)
  );

  hlp_fwd_apr_rtl_tessent_tdr_SRAM_c10_algo_select_tdr hlp_fwd_apr_rtl_tessent_tdr_SRAM_c10_algo_select_tdr_inst(
      .ijtag_reset(ijtag_to_reset), .ijtag_sel(hlp_fwd_apr_rtl_tessent_sib_algo_select_sib_inst_to_select), 
      .ijtag_si(hlp_fwd_apr_rtl_tessent_tdr_TCAM_c11_algo_select_tdr_inst_so), 
      .ijtag_ce(ijtag_to_ce), .ijtag_se(ijtag_to_se), .ijtag_ue(ijtag_to_ue), .ijtag_tck(ijtag_to_tck), 
      .ALGO_SEL_REG(ALGO_SEL_REG_ts1), .ijtag_so(hlp_fwd_apr_rtl_tessent_tdr_SRAM_c10_algo_select_tdr_inst_so)
  );

  hlp_fwd_apr_rtl_tessent_tdr_SRAM_c9_algo_select_tdr hlp_fwd_apr_rtl_tessent_tdr_SRAM_c9_algo_select_tdr_inst(
      .ijtag_reset(ijtag_to_reset), .ijtag_sel(hlp_fwd_apr_rtl_tessent_sib_algo_select_sib_inst_to_select), 
      .ijtag_si(hlp_fwd_apr_rtl_tessent_tdr_SRAM_c10_algo_select_tdr_inst_so), 
      .ijtag_ce(ijtag_to_ce), .ijtag_se(ijtag_to_se), .ijtag_ue(ijtag_to_ue), .ijtag_tck(ijtag_to_tck), 
      .ALGO_SEL_REG(ALGO_SEL_REG_ts9), .ijtag_so(hlp_fwd_apr_rtl_tessent_tdr_SRAM_c9_algo_select_tdr_inst_so)
  );

  hlp_fwd_apr_rtl_tessent_tdr_SRAM_c8_algo_select_tdr hlp_fwd_apr_rtl_tessent_tdr_SRAM_c8_algo_select_tdr_inst(
      .ijtag_reset(ijtag_to_reset), .ijtag_sel(hlp_fwd_apr_rtl_tessent_sib_algo_select_sib_inst_to_select), 
      .ijtag_si(hlp_fwd_apr_rtl_tessent_tdr_SRAM_c9_algo_select_tdr_inst_so), .ijtag_ce(ijtag_to_ce), 
      .ijtag_se(ijtag_to_se), .ijtag_ue(ijtag_to_ue), .ijtag_tck(ijtag_to_tck), 
      .ALGO_SEL_REG(ALGO_SEL_REG_ts8), .ijtag_so(hlp_fwd_apr_rtl_tessent_tdr_SRAM_c8_algo_select_tdr_inst_so)
  );

  hlp_fwd_apr_rtl_tessent_tdr_SRAM_c7_algo_select_tdr hlp_fwd_apr_rtl_tessent_tdr_SRAM_c7_algo_select_tdr_inst(
      .ijtag_reset(ijtag_to_reset), .ijtag_sel(hlp_fwd_apr_rtl_tessent_sib_algo_select_sib_inst_to_select), 
      .ijtag_si(hlp_fwd_apr_rtl_tessent_tdr_SRAM_c8_algo_select_tdr_inst_so), .ijtag_ce(ijtag_to_ce), 
      .ijtag_se(ijtag_to_se), .ijtag_ue(ijtag_to_ue), .ijtag_tck(ijtag_to_tck), 
      .ALGO_SEL_REG(ALGO_SEL_REG_ts7), .ijtag_so(hlp_fwd_apr_rtl_tessent_tdr_SRAM_c7_algo_select_tdr_inst_so)
  );

  hlp_fwd_apr_rtl_tessent_tdr_SRAM_c6_algo_select_tdr hlp_fwd_apr_rtl_tessent_tdr_SRAM_c6_algo_select_tdr_inst(
      .ijtag_reset(ijtag_to_reset), .ijtag_sel(hlp_fwd_apr_rtl_tessent_sib_algo_select_sib_inst_to_select), 
      .ijtag_si(hlp_fwd_apr_rtl_tessent_tdr_SRAM_c7_algo_select_tdr_inst_so), .ijtag_ce(ijtag_to_ce), 
      .ijtag_se(ijtag_to_se), .ijtag_ue(ijtag_to_ue), .ijtag_tck(ijtag_to_tck), 
      .ALGO_SEL_REG(ALGO_SEL_REG_ts6), .ijtag_so(hlp_fwd_apr_rtl_tessent_tdr_SRAM_c6_algo_select_tdr_inst_so)
  );

  hlp_fwd_apr_rtl_tessent_tdr_SRAM_c5_algo_select_tdr hlp_fwd_apr_rtl_tessent_tdr_SRAM_c5_algo_select_tdr_inst(
      .ijtag_reset(ijtag_to_reset), .ijtag_sel(hlp_fwd_apr_rtl_tessent_sib_algo_select_sib_inst_to_select), 
      .ijtag_si(hlp_fwd_apr_rtl_tessent_tdr_SRAM_c6_algo_select_tdr_inst_so), .ijtag_ce(ijtag_to_ce), 
      .ijtag_se(ijtag_to_se), .ijtag_ue(ijtag_to_ue), .ijtag_tck(ijtag_to_tck), 
      .ALGO_SEL_REG(ALGO_SEL_REG_ts5), .ijtag_so(hlp_fwd_apr_rtl_tessent_tdr_SRAM_c5_algo_select_tdr_inst_so)
  );

  hlp_fwd_apr_rtl_tessent_tdr_SRAM_c4_algo_select_tdr hlp_fwd_apr_rtl_tessent_tdr_SRAM_c4_algo_select_tdr_inst(
      .ijtag_reset(ijtag_to_reset), .ijtag_sel(hlp_fwd_apr_rtl_tessent_sib_algo_select_sib_inst_to_select), 
      .ijtag_si(hlp_fwd_apr_rtl_tessent_tdr_SRAM_c5_algo_select_tdr_inst_so), .ijtag_ce(ijtag_to_ce), 
      .ijtag_se(ijtag_to_se), .ijtag_ue(ijtag_to_ue), .ijtag_tck(ijtag_to_tck), 
      .ALGO_SEL_REG(ALGO_SEL_REG_ts4), .ijtag_so(hlp_fwd_apr_rtl_tessent_tdr_SRAM_c4_algo_select_tdr_inst_so)
  );

  hlp_fwd_apr_rtl_tessent_tdr_SRAM_c3_algo_select_tdr hlp_fwd_apr_rtl_tessent_tdr_SRAM_c3_algo_select_tdr_inst(
      .ijtag_reset(ijtag_to_reset), .ijtag_sel(hlp_fwd_apr_rtl_tessent_sib_algo_select_sib_inst_to_select), 
      .ijtag_si(hlp_fwd_apr_rtl_tessent_tdr_SRAM_c4_algo_select_tdr_inst_so), .ijtag_ce(ijtag_to_ce), 
      .ijtag_se(ijtag_to_se), .ijtag_ue(ijtag_to_ue), .ijtag_tck(ijtag_to_tck), 
      .ALGO_SEL_REG(ALGO_SEL_REG_ts3), .ijtag_so(hlp_fwd_apr_rtl_tessent_tdr_SRAM_c3_algo_select_tdr_inst_so)
  );

  hlp_fwd_apr_rtl_tessent_tdr_SRAM_c2_algo_select_tdr hlp_fwd_apr_rtl_tessent_tdr_SRAM_c2_algo_select_tdr_inst(
      .ijtag_reset(ijtag_to_reset), .ijtag_sel(hlp_fwd_apr_rtl_tessent_sib_algo_select_sib_inst_to_select), 
      .ijtag_si(hlp_fwd_apr_rtl_tessent_tdr_SRAM_c3_algo_select_tdr_inst_so), .ijtag_ce(ijtag_to_ce), 
      .ijtag_se(ijtag_to_se), .ijtag_ue(ijtag_to_ue), .ijtag_tck(ijtag_to_tck), 
      .ALGO_SEL_REG(ALGO_SEL_REG_ts2), .ijtag_so(hlp_fwd_apr_rtl_tessent_tdr_SRAM_c2_algo_select_tdr_inst_so)
  );

  hlp_fwd_apr_rtl_tessent_tdr_RF_c1_algo_select_tdr hlp_fwd_apr_rtl_tessent_tdr_RF_c1_algo_select_tdr_inst(
      .ijtag_reset(ijtag_to_reset), .ijtag_sel(hlp_fwd_apr_rtl_tessent_sib_algo_select_sib_inst_to_select), 
      .ijtag_si(hlp_fwd_apr_rtl_tessent_tdr_SRAM_c2_algo_select_tdr_inst_so), .ijtag_ce(ijtag_to_ce), 
      .ijtag_se(ijtag_to_se), .ijtag_ue(ijtag_to_ue), .ijtag_tck(ijtag_to_tck), 
      .ALGO_SEL_REG(ALGO_SEL_REG), .ijtag_so(hlp_fwd_apr_rtl_tessent_tdr_RF_c1_algo_select_tdr_inst_so)
  );

  hlp_fwd_apr_rtl_tessent_mbist_bap hlp_fwd_apr_rtl_tessent_mbist_bap_inst(
      .reset(ijtag_to_reset), .ijtag_select(ijtag_to_sel), .si(hlp_fwd_apr_rtl_tessent_sib_algo_select_sib_inst_so), 
      .capture_en(ijtag_to_ce), .shift_en(ijtag_to_se), .shift_en_R(), .update_en(ijtag_to_ue), 
      .tck(ijtag_to_tck), .to_interfaces_tck(to_interfaces_tck), .to_controllers_tck_retime(to_controllers_tck_retime), 
      .to_controllers_tck(to_controllers_tck), .mcp_bounding_en(ltest_to_mcp_bounding_en), 
      .mcp_bounding_to_en(mcp_bounding_to_en), .scan_en(ltest_to_scan_en), .scan_to_en(scan_to_en), 
      .memory_bypass_en(ltest_to_mem_bypass_en), .memory_bypass_to_en(memory_bypass_to_en), 
      .ltest_en(ltest_to_en), .ltest_to_en(ltest_to_en_ts1), .BIST_HOLD(BIST_HOLD), 
      .sys_ctrl_select({select_sram, select_sram, select_sram, select_sram, 
      select_sram, select_sram, select_sram, select_sram, select_sram, 
      select_sram, select_rf}), .sys_algo_select(mbistpg_algo_sel_o[6:0]), .sys_select_common_algo(mbistpg_select_common_algo_o), 
      .sys_test_start_clk(trigger_post), .sys_test_init_clk(1'b0), .sys_reset_clk(sync_reset_clk_o), 
      .sys_clock_clk(clk_ts1), .sys_test_pass_clk(sys_test_pass_clk), .sys_test_done_clk(sys_test_done_clk), 
      .sys_ctrl_pass(), .sys_ctrl_done(), .ENABLE_MEM_RESET(ENABLE_MEM_RESET), 
      .REDUCED_ADDRESS_COUNT(REDUCED_ADDRESS_COUNT), .BIST_SELECT_TEST_DATA(BIST_SELECT_TEST_DATA), 
      .BIST_ALGO_MODE0(BIST_ALGO_MODE0), .BIST_ALGO_MODE1(BIST_ALGO_MODE1), .sys_incremental_test_mode(1'b0), 
      .MEM_ARRAY_DUMP_MODE(MEM_ARRAY_DUMP_MODE), .BIRA_EN(BIRA_EN), .BIST_DIAG_EN(BIST_DIAG_EN), 
      .PRESERVE_FUSE_REGISTER(PRESERVE_FUSE_REGISTER), .CHECK_REPAIR_NEEDED(CHECK_REPAIR_NEEDED), 
      .BIST_ASYNC_RESET(BIST_ASYNC_RESET), .FL_CNT_MODE0(FL_CNT_MODE0), .FL_CNT_MODE1(FL_CNT_MODE1), 
      .INCLUDE_MEM_RESULTS_REG(INCLUDE_MEM_RESULTS_REG), .BIST_SETUP(BIST_SETUP[2:0]), 
      .BIST_ALGO_SEL({BIST_ALGO_SEL_ts6, BIST_ALGO_SEL_ts5, 
      BIST_ALGO_SEL_ts4, BIST_ALGO_SEL_ts3, BIST_ALGO_SEL_ts2, 
      BIST_ALGO_SEL_ts1, BIST_ALGO_SEL}), .BIST_SELECT_COMMON_ALGO(BIST_SELECT_COMMON_ALGO), 
      .BIST_OPSET_SEL({BIST_OPSET_SEL_ts1, BIST_OPSET_SEL}), .BIST_SELECT_COMMON_OPSET(BIST_SELECT_COMMON_OPSET), 
      .BIST_DATA_INV_COL_ADD_BIT_SEL(BIST_DATA_INV_COL_ADD_BIT_SEL), .BIST_DATA_INV_COL_ADD_BIT_SELECT_EN(BIST_DATA_INV_COL_ADD_BIT_SELECT_EN), 
      .BIST_DATA_INV_ROW_ADD_BIT_SEL(BIST_DATA_INV_ROW_ADD_BIT_SEL), .BIST_DATA_INV_ROW_ADD_BIT_SELECT_EN(BIST_DATA_INV_ROW_ADD_BIT_SELECT_EN), 
      .MBISTPG_GO({MBISTPG_GO_ts10, MBISTPG_GO_ts1, MBISTPG_GO_ts9, 
      MBISTPG_GO_ts8, MBISTPG_GO_ts7, MBISTPG_GO_ts6, MBISTPG_GO_ts5, 
      MBISTPG_GO_ts4, MBISTPG_GO_ts3, MBISTPG_GO_ts2, MBISTPG_GO}), .MBISTPG_DONE({
      MBISTPG_DONE_ts10, MBISTPG_DONE_ts1, MBISTPG_DONE_ts9, MBISTPG_DONE_ts8, 
      MBISTPG_DONE_ts7, MBISTPG_DONE_ts6, MBISTPG_DONE_ts5, MBISTPG_DONE_ts4, 
      MBISTPG_DONE_ts3, MBISTPG_DONE_ts2, MBISTPG_DONE}), .bistEn(bistEn[10:0]), 
      .toBist(toBist[10:0]), .fromBist({MBISTPG_SO_ts10, MBISTPG_SO_ts1, 
      MBISTPG_SO_ts9, MBISTPG_SO_ts8, MBISTPG_SO_ts7, MBISTPG_SO_ts6, 
      MBISTPG_SO_ts5, MBISTPG_SO_ts4, MBISTPG_SO_ts3, MBISTPG_SO_ts2, 
      MBISTPG_SO}), .so(hlp_fwd_apr_rtl_tessent_mbist_bap_inst_so), .fscan_clkungate(fscan_clkungate)
  );

  hlp_fwd_apr_rtl_tessent_mbist_RF_c1_controller hlp_fwd_apr_rtl_tessent_mbist_RF_c1_controller_inst(
      .MBIST_RA_PRSRV_FUSE_VAL(PRESERVE_FUSE_REGISTER), .MBISTPG_ALGO_SEL({
      BIST_ALGO_SEL_ts6, BIST_ALGO_SEL_ts5, BIST_ALGO_SEL_ts4, 
      BIST_ALGO_SEL_ts3, BIST_ALGO_SEL_ts2, BIST_ALGO_SEL_ts1, BIST_ALGO_SEL}), .MBISTPG_SELECT_COMMON_ALGO(BIST_SELECT_COMMON_ALGO), 
      .MBISTPG_OPSET_SELECT(BIST_OPSET_SEL), .MBISTPG_SELECT_COMMON_OPSET(BIST_SELECT_COMMON_OPSET), 
      .MBISTPG_DATA_INV_ROW_ADD_BIT_SELECT_EN(BIST_DATA_INV_ROW_ADD_BIT_SELECT_EN), 
      .MBISTPG_DATA_INV_ROW_ADD_BIT_SELECT(BIST_DATA_INV_ROW_ADD_BIT_SEL), .MBISTPG_DATA_INV_COL_ADD_BIT_SELECT_EN(BIST_DATA_INV_COL_ADD_BIT_SELECT_EN), 
      .MBISTPG_DATA_INV_COL_ADD_BIT_SELECT(BIST_DATA_INV_COL_ADD_BIT_SEL), .MBISTPG_ALGO_MODE({
      BIST_ALGO_MODE1, BIST_ALGO_MODE0}), .MBISTPG_MEM_RST(ENABLE_MEM_RESET), .MBISTPG_REDUCED_ADDR_CNT_EN(REDUCED_ADDRESS_COUNT), 
      .MEM_BYPASS_EN(memory_bypass_to_en), .MCP_BOUNDING_EN(mcp_bounding_to_en), 
      .MEM0_BIST_COLLAR_SO(BIST_SO_ts2), .FL_CNT_MODE({FL_CNT_MODE1, 
      FL_CNT_MODE0}), .MBISTPG_BIRA_EN(BIRA_EN), .CHECK_REPAIR_NEEDED(CHECK_REPAIR_NEEDED), 
      .BIST_COLLAR_GO(BIST_GO_ts2), .MBISTPG_DIAG_EN(BIST_DIAG_EN), .BIST_CLK(clk_ts1), 
      .BIST_SI(toBist[0]), .BIST_HOLD(BIST_HOLD), .BIST_SETUP2(BIST_SETUP_ts3), 
      .BIST_SETUP({BIST_SETUP_ts2, BIST_SETUP_ts1}), .MBISTPG_TESTDATA_SELECT(BIST_SELECT_TEST_DATA), 
      .TCK(to_controllers_tck), .TCK_RETIME(to_controllers_tck_retime), .MBISTPG_EN(bistEn[0]), 
      .MBISTPG_ASYNC_RESETN(BIST_ASYNC_RESET), .LV_TM(ltest_to_en_ts1), .MBISTPG_MEM_ARRAY_DUMP_MODE(MEM_ARRAY_DUMP_MODE), 
      .BIST_CLEAR_BIRA(BIST_CLEAR_BIRA), .MBISTPG_RESET_REG_SETUP2(MBISTPG_RESET_REG_SETUP2), 
      .BIST_COL_ADD(BIST_COL_ADD), .BIST_ROW_ADD(BIST_ROW_ADD), .BIST_BANK_ADD(BIST_BANK_ADD), 
      .BIST_WRITE_DATA(BIST_WRITE_DATA), .BIST_EXPECT_DATA(BIST_EXPECT_DATA), .BIST_SHIFT_COLLAR(BIST_SHIFT_COLLAR), 
      .BIST_TESTDATA_SELECT_TO_COLLAR(BIST_TESTDATA_SELECT_TO_COLLAR), .MEM0_BIST_COLLAR_SI(MEM0_BIST_COLLAR_SI), 
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
      .BIST_RUN_TO_COLLAR0(BIST_RUN_TO_COLLAR0), .MBISTPG_GO(MBISTPG_GO), .MBISTPG_STABLE(MBISTPG_STABLE), 
      .MBISTPG_DONE(MBISTPG_DONE), .BIST_ON_TO_COLLAR(BIST_ON_TO_COLLAR), .BIST_SHIFT_BIRA_COLLAR(BIST_SHIFT_BIRA_COLLAR), 
      .GO_ID_REG_SEL(GO_ID_REG_SEL), .ALGO_SEL_REG(ALGO_SEL_REG), .fscan_clkungate(fscan_clkungate)
  );

  hlp_fwd_apr_rtl_tessent_mbist_SRAM_c2_controller hlp_fwd_apr_rtl_tessent_mbist_SRAM_c2_controller_inst(
      .MBIST_RA_PRSRV_FUSE_VAL(PRESERVE_FUSE_REGISTER), .MBISTPG_ALGO_SEL({
      BIST_ALGO_SEL_ts6, BIST_ALGO_SEL_ts5, BIST_ALGO_SEL_ts4, 
      BIST_ALGO_SEL_ts3, BIST_ALGO_SEL_ts2, BIST_ALGO_SEL_ts1, BIST_ALGO_SEL}), .MBISTPG_SELECT_COMMON_ALGO(BIST_SELECT_COMMON_ALGO), 
      .MBISTPG_OPSET_SELECT(BIST_OPSET_SEL), .MBISTPG_SELECT_COMMON_OPSET(BIST_SELECT_COMMON_OPSET), 
      .MBISTPG_DATA_INV_ROW_ADD_BIT_SELECT_EN(BIST_DATA_INV_ROW_ADD_BIT_SELECT_EN), 
      .MBISTPG_DATA_INV_ROW_ADD_BIT_SELECT(BIST_DATA_INV_ROW_ADD_BIT_SEL), .MBISTPG_DATA_INV_COL_ADD_BIT_SELECT_EN(BIST_DATA_INV_COL_ADD_BIT_SELECT_EN), 
      .MBISTPG_DATA_INV_COL_ADD_BIT_SELECT(BIST_DATA_INV_COL_ADD_BIT_SEL), .MBISTPG_ALGO_MODE({
      BIST_ALGO_MODE1, BIST_ALGO_MODE0}), .MBISTPG_MEM_RST(ENABLE_MEM_RESET), .MBISTPG_REDUCED_ADDR_CNT_EN(REDUCED_ADDRESS_COUNT), 
      .MEM_BYPASS_EN(memory_bypass_to_en), .MCP_BOUNDING_EN(mcp_bounding_to_en), 
      .MEM0_BIST_COLLAR_SO(BIST_SO), .MEM1_BIST_COLLAR_SO(BIST_SO_ts24), .MEM2_BIST_COLLAR_SO(BIST_SO_ts40), 
      .MEM3_BIST_COLLAR_SO(BIST_SO_ts56), .MEM4_BIST_COLLAR_SO(BIST_SO_ts69), .MEM5_BIST_COLLAR_SO(BIST_SO_ts82), 
      .MEM6_BIST_COLLAR_SO(BIST_SO_ts95), .MEM7_BIST_COLLAR_SO(BIST_SO_ts108), 
      .MEM8_BIST_COLLAR_SO(BIST_SO_ts1), .MEM9_BIST_COLLAR_SO(BIST_SO_ts25), .MEM10_BIST_COLLAR_SO(BIST_SO_ts41), 
      .MEM11_BIST_COLLAR_SO(BIST_SO_ts57), .MEM12_BIST_COLLAR_SO(BIST_SO_ts70), 
      .MEM13_BIST_COLLAR_SO(BIST_SO_ts83), .MEM14_BIST_COLLAR_SO(BIST_SO_ts96), 
      .MEM15_BIST_COLLAR_SO(BIST_SO_ts109), .MEM16_BIST_COLLAR_SO(BIST_SO_ts4), 
      .MEM17_BIST_COLLAR_SO(BIST_SO_ts26), .MEM18_BIST_COLLAR_SO(BIST_SO_ts10), 
      .MEM19_BIST_COLLAR_SO(BIST_SO_ts27), .MEM20_BIST_COLLAR_SO(BIST_SO_ts38), 
      .MEM21_BIST_COLLAR_SO(BIST_SO_ts39), .MEM22_BIST_COLLAR_SO(BIST_SO_ts45), 
      .MEM23_BIST_COLLAR_SO(BIST_SO_ts58), .MEM24_BIST_COLLAR_SO(BIST_SO_ts71), 
      .MEM25_BIST_COLLAR_SO(BIST_SO_ts84), .MEM26_BIST_COLLAR_SO(BIST_SO_ts97), 
      .MEM27_BIST_COLLAR_SO(BIST_SO_ts110), .MEM28_BIST_COLLAR_SO(BIST_SO_ts121), 
      .MEM29_BIST_COLLAR_SO(BIST_SO_ts122), .MEM30_BIST_COLLAR_SO(BIST_SO_ts123), 
      .MEM31_BIST_COLLAR_SO(BIST_SO_ts124), .FL_CNT_MODE({FL_CNT_MODE1, 
      FL_CNT_MODE0}), .MBISTPG_BIRA_EN(BIRA_EN), .CHECK_REPAIR_NEEDED(CHECK_REPAIR_NEEDED), 
      .BIST_COLLAR_GO({BIST_GO_ts124, BIST_GO_ts123, BIST_GO_ts122, 
      BIST_GO_ts121, BIST_GO_ts110, BIST_GO_ts97, BIST_GO_ts84, BIST_GO_ts71, 
      BIST_GO_ts58, BIST_GO_ts45, BIST_GO_ts39, BIST_GO_ts38, BIST_GO_ts27, 
      BIST_GO_ts10, BIST_GO_ts26, BIST_GO_ts4, BIST_GO_ts109, BIST_GO_ts96, 
      BIST_GO_ts83, BIST_GO_ts70, BIST_GO_ts57, BIST_GO_ts41, BIST_GO_ts25, 
      BIST_GO_ts1, BIST_GO_ts108, BIST_GO_ts95, BIST_GO_ts82, BIST_GO_ts69, 
      BIST_GO_ts56, BIST_GO_ts40, BIST_GO_ts24, BIST_GO}), .MBISTPG_DIAG_EN(BIST_DIAG_EN), 
      .BIST_CLK(clk_ts1), .BIST_SI(toBist[1]), .BIST_HOLD(BIST_HOLD), .BIST_SETUP2(BIST_SETUP_ts3), 
      .BIST_SETUP({BIST_SETUP_ts2, BIST_SETUP_ts1}), .MBISTPG_TESTDATA_SELECT(BIST_SELECT_TEST_DATA), 
      .TCK(to_controllers_tck), .TCK_RETIME(to_controllers_tck_retime), .MBISTPG_EN(bistEn[1]), 
      .MBISTPG_ASYNC_RESETN(BIST_ASYNC_RESET), .LV_TM(ltest_to_en_ts1), .MBISTPG_MEM_ARRAY_DUMP_MODE(MEM_ARRAY_DUMP_MODE), 
      .BIST_CLEAR_BIRA(BIST_CLEAR_BIRA_ts2), .MBISTPG_RESET_REG_SETUP2(MBISTPG_RESET_REG_SETUP2_ts2), 
      .BIST_COL_ADD(BIST_COL_ADD_ts2[1:0]), .BIST_ROW_ADD(BIST_ROW_ADD_ts2[7:0]), 
      .BIST_BANK_ADD(BIST_BANK_ADD_ts2[1:0]), .BIST_WRITE_DATA(BIST_WRITE_DATA_ts2[31:0]), 
      .BIST_EXPECT_DATA(BIST_EXPECT_DATA_ts2[31:0]), .BIST_SHIFT_COLLAR(BIST_SHIFT_COLLAR_ts2), 
      .BIST_TESTDATA_SELECT_TO_COLLAR(BIST_TESTDATA_SELECT_TO_COLLAR_ts2), .MEM0_BIST_COLLAR_SI(MEM0_BIST_COLLAR_SI_ts2), 
      .MEM1_BIST_COLLAR_SI(MEM1_BIST_COLLAR_SI_ts1), .MEM2_BIST_COLLAR_SI(MEM2_BIST_COLLAR_SI_ts1), 
      .MEM3_BIST_COLLAR_SI(MEM3_BIST_COLLAR_SI_ts1), .MEM4_BIST_COLLAR_SI(MEM4_BIST_COLLAR_SI_ts1), 
      .MEM5_BIST_COLLAR_SI(MEM5_BIST_COLLAR_SI_ts1), .MEM6_BIST_COLLAR_SI(MEM6_BIST_COLLAR_SI_ts1), 
      .MEM7_BIST_COLLAR_SI(MEM7_BIST_COLLAR_SI_ts1), .MEM8_BIST_COLLAR_SI(MEM8_BIST_COLLAR_SI_ts1), 
      .MEM9_BIST_COLLAR_SI(MEM9_BIST_COLLAR_SI_ts1), .MEM10_BIST_COLLAR_SI(MEM10_BIST_COLLAR_SI_ts1), 
      .MEM11_BIST_COLLAR_SI(MEM11_BIST_COLLAR_SI_ts1), .MEM12_BIST_COLLAR_SI(MEM12_BIST_COLLAR_SI_ts1), 
      .MEM13_BIST_COLLAR_SI(MEM13_BIST_COLLAR_SI_ts1), .MEM14_BIST_COLLAR_SI(MEM14_BIST_COLLAR_SI_ts1), 
      .MEM15_BIST_COLLAR_SI(MEM15_BIST_COLLAR_SI_ts1), .MEM16_BIST_COLLAR_SI(MEM16_BIST_COLLAR_SI_ts1), 
      .MEM17_BIST_COLLAR_SI(MEM17_BIST_COLLAR_SI_ts1), .MEM18_BIST_COLLAR_SI(MEM18_BIST_COLLAR_SI_ts1), 
      .MEM19_BIST_COLLAR_SI(MEM19_BIST_COLLAR_SI_ts1), .MEM20_BIST_COLLAR_SI(MEM20_BIST_COLLAR_SI), 
      .MEM21_BIST_COLLAR_SI(MEM21_BIST_COLLAR_SI), .MEM22_BIST_COLLAR_SI(MEM22_BIST_COLLAR_SI), 
      .MEM23_BIST_COLLAR_SI(MEM23_BIST_COLLAR_SI), .MEM24_BIST_COLLAR_SI(MEM24_BIST_COLLAR_SI), 
      .MEM25_BIST_COLLAR_SI(MEM25_BIST_COLLAR_SI), .MEM26_BIST_COLLAR_SI(MEM26_BIST_COLLAR_SI), 
      .MEM27_BIST_COLLAR_SI(MEM27_BIST_COLLAR_SI), .MEM28_BIST_COLLAR_SI(MEM28_BIST_COLLAR_SI), 
      .MEM29_BIST_COLLAR_SI(MEM29_BIST_COLLAR_SI), .MEM30_BIST_COLLAR_SI(MEM30_BIST_COLLAR_SI), 
      .MEM31_BIST_COLLAR_SI(MEM31_BIST_COLLAR_SI), .BIST_COLLAR_SETUP(BIST_COLLAR_SETUP_ts2), 
      .BIST_COLLAR_OPSET_SELECT(BIST_COLLAR_OPSET_SELECT_ts2), .BIST_COLLAR_HOLD(BIST_COLLAR_HOLD_ts2), 
      .FREEZE_STOP_ERROR(FREEZE_STOP_ERROR_ts2), .ERROR_CNT_ZERO(ERROR_CNT_ZERO_ts2), 
      .BIST_COLLAR_DIAG_EN(BIST_COLLAR_DIAG_EN_ts2), .BIST_COLLAR_BIRA_EN(BIST_COLLAR_BIRA_EN_ts2), 
      .BIST_CLEAR_DEFAULT(BIST_CLEAR_DEFAULT_ts2), .BIST_CLEAR(BIST_CLEAR_ts2), 
      .MBISTPG_SO(MBISTPG_SO_ts2), .PriorityColumn(PriorityColumn_ts2), .BIST_WRITEENABLE(BIST_WRITEENABLE_ts2), 
      .BIST_SELECT(BIST_SELECT_ts1), .BIST_CMP(BIST_CMP_ts2), .BIST_COLLAR_EN0(BIST_COLLAR_EN0_ts2), 
      .BIST_RUN_TO_COLLAR0(BIST_RUN_TO_COLLAR0_ts2), .BIST_COLLAR_EN1(BIST_COLLAR_EN1_ts1), 
      .BIST_RUN_TO_COLLAR1(BIST_RUN_TO_COLLAR1_ts1), .BIST_COLLAR_EN2(BIST_COLLAR_EN2_ts1), 
      .BIST_RUN_TO_COLLAR2(BIST_RUN_TO_COLLAR2_ts1), .BIST_COLLAR_EN3(BIST_COLLAR_EN3_ts1), 
      .BIST_RUN_TO_COLLAR3(BIST_RUN_TO_COLLAR3_ts1), .BIST_COLLAR_EN4(BIST_COLLAR_EN4_ts1), 
      .BIST_RUN_TO_COLLAR4(BIST_RUN_TO_COLLAR4_ts1), .BIST_COLLAR_EN5(BIST_COLLAR_EN5_ts1), 
      .BIST_RUN_TO_COLLAR5(BIST_RUN_TO_COLLAR5_ts1), .BIST_COLLAR_EN6(BIST_COLLAR_EN6_ts1), 
      .BIST_RUN_TO_COLLAR6(BIST_RUN_TO_COLLAR6_ts1), .BIST_COLLAR_EN7(BIST_COLLAR_EN7_ts1), 
      .BIST_RUN_TO_COLLAR7(BIST_RUN_TO_COLLAR7_ts1), .BIST_COLLAR_EN8(BIST_COLLAR_EN8_ts1), 
      .BIST_RUN_TO_COLLAR8(BIST_RUN_TO_COLLAR8_ts1), .BIST_COLLAR_EN9(BIST_COLLAR_EN9_ts1), 
      .BIST_RUN_TO_COLLAR9(BIST_RUN_TO_COLLAR9_ts1), .BIST_COLLAR_EN10(BIST_COLLAR_EN10_ts1), 
      .BIST_RUN_TO_COLLAR10(BIST_RUN_TO_COLLAR10_ts1), .BIST_COLLAR_EN11(BIST_COLLAR_EN11_ts1), 
      .BIST_RUN_TO_COLLAR11(BIST_RUN_TO_COLLAR11_ts1), .BIST_COLLAR_EN12(BIST_COLLAR_EN12_ts1), 
      .BIST_RUN_TO_COLLAR12(BIST_RUN_TO_COLLAR12_ts1), .BIST_COLLAR_EN13(BIST_COLLAR_EN13_ts1), 
      .BIST_RUN_TO_COLLAR13(BIST_RUN_TO_COLLAR13_ts1), .BIST_COLLAR_EN14(BIST_COLLAR_EN14_ts1), 
      .BIST_RUN_TO_COLLAR14(BIST_RUN_TO_COLLAR14_ts1), .BIST_COLLAR_EN15(BIST_COLLAR_EN15_ts1), 
      .BIST_RUN_TO_COLLAR15(BIST_RUN_TO_COLLAR15_ts1), .BIST_COLLAR_EN16(BIST_COLLAR_EN16_ts1), 
      .BIST_RUN_TO_COLLAR16(BIST_RUN_TO_COLLAR16_ts1), .BIST_COLLAR_EN17(BIST_COLLAR_EN17_ts1), 
      .BIST_RUN_TO_COLLAR17(BIST_RUN_TO_COLLAR17_ts1), .BIST_COLLAR_EN18(BIST_COLLAR_EN18_ts1), 
      .BIST_RUN_TO_COLLAR18(BIST_RUN_TO_COLLAR18_ts1), .BIST_COLLAR_EN19(BIST_COLLAR_EN19_ts1), 
      .BIST_RUN_TO_COLLAR19(BIST_RUN_TO_COLLAR19_ts1), .BIST_COLLAR_EN20(BIST_COLLAR_EN20), 
      .BIST_RUN_TO_COLLAR20(BIST_RUN_TO_COLLAR20), .BIST_COLLAR_EN21(BIST_COLLAR_EN21), 
      .BIST_RUN_TO_COLLAR21(BIST_RUN_TO_COLLAR21), .BIST_COLLAR_EN22(BIST_COLLAR_EN22), 
      .BIST_RUN_TO_COLLAR22(BIST_RUN_TO_COLLAR22), .BIST_COLLAR_EN23(BIST_COLLAR_EN23), 
      .BIST_RUN_TO_COLLAR23(BIST_RUN_TO_COLLAR23), .BIST_COLLAR_EN24(BIST_COLLAR_EN24), 
      .BIST_RUN_TO_COLLAR24(BIST_RUN_TO_COLLAR24), .BIST_COLLAR_EN25(BIST_COLLAR_EN25), 
      .BIST_RUN_TO_COLLAR25(BIST_RUN_TO_COLLAR25), .BIST_COLLAR_EN26(BIST_COLLAR_EN26), 
      .BIST_RUN_TO_COLLAR26(BIST_RUN_TO_COLLAR26), .BIST_COLLAR_EN27(BIST_COLLAR_EN27), 
      .BIST_RUN_TO_COLLAR27(BIST_RUN_TO_COLLAR27), .BIST_COLLAR_EN28(BIST_COLLAR_EN28), 
      .BIST_RUN_TO_COLLAR28(BIST_RUN_TO_COLLAR28), .BIST_COLLAR_EN29(BIST_COLLAR_EN29), 
      .BIST_RUN_TO_COLLAR29(BIST_RUN_TO_COLLAR29), .BIST_COLLAR_EN30(BIST_COLLAR_EN30), 
      .BIST_RUN_TO_COLLAR30(BIST_RUN_TO_COLLAR30), .BIST_COLLAR_EN31(BIST_COLLAR_EN31), 
      .BIST_RUN_TO_COLLAR31(BIST_RUN_TO_COLLAR31), .MBISTPG_GO(MBISTPG_GO_ts2), 
      .MBISTPG_STABLE(MBISTPG_STABLE_ts1), .MBISTPG_DONE(MBISTPG_DONE_ts2), .BIST_ON_TO_COLLAR(BIST_ON_TO_COLLAR_ts2), 
      .BIST_SHIFT_BIRA_COLLAR(BIST_SHIFT_BIRA_COLLAR_ts2), .GO_ID_REG_SEL(GO_ID_REG_SEL_ts1), 
      .ALGO_SEL_REG(ALGO_SEL_REG_ts2), .fscan_clkungate(fscan_clkungate)
  );

  hlp_fwd_apr_rtl_tessent_mbist_SRAM_c3_controller hlp_fwd_apr_rtl_tessent_mbist_SRAM_c3_controller_inst(
      .MBIST_RA_PRSRV_FUSE_VAL(PRESERVE_FUSE_REGISTER), .MBISTPG_ALGO_SEL({
      BIST_ALGO_SEL_ts6, BIST_ALGO_SEL_ts5, BIST_ALGO_SEL_ts4, 
      BIST_ALGO_SEL_ts3, BIST_ALGO_SEL_ts2, BIST_ALGO_SEL_ts1, BIST_ALGO_SEL}), .MBISTPG_SELECT_COMMON_ALGO(BIST_SELECT_COMMON_ALGO), 
      .MBISTPG_OPSET_SELECT(BIST_OPSET_SEL), .MBISTPG_SELECT_COMMON_OPSET(BIST_SELECT_COMMON_OPSET), 
      .MBISTPG_DATA_INV_ROW_ADD_BIT_SELECT_EN(BIST_DATA_INV_ROW_ADD_BIT_SELECT_EN), 
      .MBISTPG_DATA_INV_ROW_ADD_BIT_SELECT(BIST_DATA_INV_ROW_ADD_BIT_SEL), .MBISTPG_DATA_INV_COL_ADD_BIT_SELECT_EN(BIST_DATA_INV_COL_ADD_BIT_SELECT_EN), 
      .MBISTPG_DATA_INV_COL_ADD_BIT_SELECT(BIST_DATA_INV_COL_ADD_BIT_SEL), .MBISTPG_ALGO_MODE({
      BIST_ALGO_MODE1, BIST_ALGO_MODE0}), .MBISTPG_MEM_RST(ENABLE_MEM_RESET), .MBISTPG_REDUCED_ADDR_CNT_EN(REDUCED_ADDRESS_COUNT), 
      .MEM_BYPASS_EN(memory_bypass_to_en), .MCP_BOUNDING_EN(mcp_bounding_to_en), 
      .MEM0_BIST_COLLAR_SO(BIST_SO_ts3), .FL_CNT_MODE({FL_CNT_MODE1, 
      FL_CNT_MODE0}), .MBISTPG_BIRA_EN(BIRA_EN), .CHECK_REPAIR_NEEDED(CHECK_REPAIR_NEEDED), 
      .BIST_COLLAR_GO(BIST_GO_ts3), .MBISTPG_DIAG_EN(BIST_DIAG_EN), .BIST_CLK(clk_ts1), 
      .BIST_SI(toBist[2]), .BIST_HOLD(BIST_HOLD), .BIST_SETUP2(BIST_SETUP_ts3), 
      .BIST_SETUP({BIST_SETUP_ts2, BIST_SETUP_ts1}), .MBISTPG_TESTDATA_SELECT(BIST_SELECT_TEST_DATA), 
      .TCK(to_controllers_tck), .TCK_RETIME(to_controllers_tck_retime), .MBISTPG_EN(bistEn[2]), 
      .MBISTPG_ASYNC_RESETN(BIST_ASYNC_RESET), .LV_TM(ltest_to_en_ts1), .MBISTPG_MEM_ARRAY_DUMP_MODE(MEM_ARRAY_DUMP_MODE), 
      .BIST_CLEAR_BIRA(BIST_CLEAR_BIRA_ts3), .MBISTPG_RESET_REG_SETUP2(MBISTPG_RESET_REG_SETUP2_ts3), 
      .BIST_COL_ADD(BIST_COL_ADD_ts3), .BIST_ROW_ADD(BIST_ROW_ADD_ts3), .BIST_BANK_ADD(BIST_BANK_ADD_ts3), 
      .BIST_WRITE_DATA(BIST_WRITE_DATA_ts3), .BIST_EXPECT_DATA(BIST_EXPECT_DATA_ts3), 
      .BIST_SHIFT_COLLAR(BIST_SHIFT_COLLAR_ts3), .BIST_TESTDATA_SELECT_TO_COLLAR(BIST_TESTDATA_SELECT_TO_COLLAR_ts3), 
      .MEM0_BIST_COLLAR_SI(MEM0_BIST_COLLAR_SI_ts3), .BIST_COLLAR_SETUP(BIST_COLLAR_SETUP_ts3), 
      .BIST_COLLAR_OPSET_SELECT(BIST_COLLAR_OPSET_SELECT_ts3), .BIST_COLLAR_HOLD(BIST_COLLAR_HOLD_ts3), 
      .FREEZE_STOP_ERROR(FREEZE_STOP_ERROR_ts3), .ERROR_CNT_ZERO(ERROR_CNT_ZERO_ts3), 
      .BIST_COLLAR_DIAG_EN(BIST_COLLAR_DIAG_EN_ts3), .BIST_COLLAR_BIRA_EN(BIST_COLLAR_BIRA_EN_ts3), 
      .BIST_CLEAR_DEFAULT(BIST_CLEAR_DEFAULT_ts3), .BIST_CLEAR(BIST_CLEAR_ts3), 
      .MBISTPG_SO(MBISTPG_SO_ts3), .PriorityColumn(PriorityColumn_ts3), .BIST_WRITEENABLE(BIST_WRITEENABLE_ts3), 
      .BIST_SELECT(BIST_SELECT_ts2), .BIST_CMP(BIST_CMP_ts3), .BIST_COLLAR_EN0(BIST_COLLAR_EN0_ts3), 
      .BIST_RUN_TO_COLLAR0(BIST_RUN_TO_COLLAR0_ts3), .MBISTPG_GO(MBISTPG_GO_ts3), 
      .MBISTPG_STABLE(MBISTPG_STABLE_ts2), .MBISTPG_DONE(MBISTPG_DONE_ts3), .BIST_ON_TO_COLLAR(BIST_ON_TO_COLLAR_ts3), 
      .BIST_SHIFT_BIRA_COLLAR(BIST_SHIFT_BIRA_COLLAR_ts3), .GO_ID_REG_SEL(GO_ID_REG_SEL_ts2), 
      .ALGO_SEL_REG(ALGO_SEL_REG_ts3), .fscan_clkungate(fscan_clkungate)
  );

  hlp_fwd_apr_rtl_tessent_mbist_SRAM_c4_controller hlp_fwd_apr_rtl_tessent_mbist_SRAM_c4_controller_inst(
      .MBIST_RA_PRSRV_FUSE_VAL(PRESERVE_FUSE_REGISTER), .MBISTPG_ALGO_SEL({
      BIST_ALGO_SEL_ts6, BIST_ALGO_SEL_ts5, BIST_ALGO_SEL_ts4, 
      BIST_ALGO_SEL_ts3, BIST_ALGO_SEL_ts2, BIST_ALGO_SEL_ts1, BIST_ALGO_SEL}), .MBISTPG_SELECT_COMMON_ALGO(BIST_SELECT_COMMON_ALGO), 
      .MBISTPG_OPSET_SELECT(BIST_OPSET_SEL), .MBISTPG_SELECT_COMMON_OPSET(BIST_SELECT_COMMON_OPSET), 
      .MBISTPG_DATA_INV_ROW_ADD_BIT_SELECT_EN(BIST_DATA_INV_ROW_ADD_BIT_SELECT_EN), 
      .MBISTPG_DATA_INV_ROW_ADD_BIT_SELECT(BIST_DATA_INV_ROW_ADD_BIT_SEL), .MBISTPG_DATA_INV_COL_ADD_BIT_SELECT_EN(BIST_DATA_INV_COL_ADD_BIT_SELECT_EN), 
      .MBISTPG_DATA_INV_COL_ADD_BIT_SELECT(BIST_DATA_INV_COL_ADD_BIT_SEL), .MBISTPG_ALGO_MODE({
      BIST_ALGO_MODE1, BIST_ALGO_MODE0}), .MBISTPG_MEM_RST(ENABLE_MEM_RESET), .MBISTPG_REDUCED_ADDR_CNT_EN(REDUCED_ADDRESS_COUNT), 
      .MEM_BYPASS_EN(memory_bypass_to_en), .MCP_BOUNDING_EN(mcp_bounding_to_en), 
      .MEM0_BIST_COLLAR_SO(BIST_SO_ts5), .MEM1_BIST_COLLAR_SO(BIST_SO_ts6), .FL_CNT_MODE({
      FL_CNT_MODE1, FL_CNT_MODE0}), .MBISTPG_BIRA_EN(BIRA_EN), .CHECK_REPAIR_NEEDED(CHECK_REPAIR_NEEDED), 
      .BIST_COLLAR_GO({BIST_GO_ts6, BIST_GO_ts5}), .MBISTPG_DIAG_EN(BIST_DIAG_EN), 
      .BIST_CLK(clk_ts1), .BIST_SI(toBist[3]), .BIST_HOLD(BIST_HOLD), .BIST_SETUP2(BIST_SETUP_ts3), 
      .BIST_SETUP({BIST_SETUP_ts2, BIST_SETUP_ts1}), .MBISTPG_TESTDATA_SELECT(BIST_SELECT_TEST_DATA), 
      .TCK(to_controllers_tck), .TCK_RETIME(to_controllers_tck_retime), .MBISTPG_EN(bistEn[3]), 
      .MBISTPG_ASYNC_RESETN(BIST_ASYNC_RESET), .LV_TM(ltest_to_en_ts1), .MBISTPG_MEM_ARRAY_DUMP_MODE(MEM_ARRAY_DUMP_MODE), 
      .BIST_CLEAR_BIRA(BIST_CLEAR_BIRA_ts4), .MBISTPG_RESET_REG_SETUP2(MBISTPG_RESET_REG_SETUP2_ts4), 
      .BIST_COL_ADD(BIST_COL_ADD_ts4[1:0]), .BIST_ROW_ADD(BIST_ROW_ADD_ts4[6:0]), 
      .BIST_WRITE_DATA(BIST_WRITE_DATA_ts4[31:0]), .BIST_EXPECT_DATA(BIST_EXPECT_DATA_ts4[31:0]), 
      .BIST_SHIFT_COLLAR(BIST_SHIFT_COLLAR_ts4), .BIST_TESTDATA_SELECT_TO_COLLAR(BIST_TESTDATA_SELECT_TO_COLLAR_ts4), 
      .MEM0_BIST_COLLAR_SI(MEM0_BIST_COLLAR_SI_ts4), .MEM1_BIST_COLLAR_SI(MEM1_BIST_COLLAR_SI_ts2), 
      .BIST_COLLAR_SETUP(BIST_COLLAR_SETUP_ts4), .BIST_COLLAR_OPSET_SELECT(BIST_COLLAR_OPSET_SELECT_ts4), 
      .BIST_COLLAR_HOLD(BIST_COLLAR_HOLD_ts4), .FREEZE_STOP_ERROR(FREEZE_STOP_ERROR_ts4), 
      .ERROR_CNT_ZERO(ERROR_CNT_ZERO_ts4), .BIST_COLLAR_DIAG_EN(BIST_COLLAR_DIAG_EN_ts4), 
      .BIST_COLLAR_BIRA_EN(BIST_COLLAR_BIRA_EN_ts4), .BIST_CLEAR_DEFAULT(BIST_CLEAR_DEFAULT_ts4), 
      .BIST_CLEAR(BIST_CLEAR_ts4), .MBISTPG_SO(MBISTPG_SO_ts4), .PriorityColumn(PriorityColumn_ts4), 
      .BIST_WRITEENABLE(BIST_WRITEENABLE_ts4), .BIST_SELECT(BIST_SELECT_ts3), .BIST_CMP(BIST_CMP_ts4), 
      .BIST_COLLAR_EN0(BIST_COLLAR_EN0_ts4), .BIST_RUN_TO_COLLAR0(BIST_RUN_TO_COLLAR0_ts4), 
      .BIST_COLLAR_EN1(BIST_COLLAR_EN1_ts2), .BIST_RUN_TO_COLLAR1(BIST_RUN_TO_COLLAR1_ts2), 
      .MBISTPG_GO(MBISTPG_GO_ts4), .MBISTPG_STABLE(MBISTPG_STABLE_ts3), .MBISTPG_DONE(MBISTPG_DONE_ts4), 
      .BIST_ON_TO_COLLAR(BIST_ON_TO_COLLAR_ts4), .BIST_SHIFT_BIRA_COLLAR(BIST_SHIFT_BIRA_COLLAR_ts4), 
      .GO_ID_REG_SEL(GO_ID_REG_SEL_ts3), .ALGO_SEL_REG(ALGO_SEL_REG_ts4), .fscan_clkungate(fscan_clkungate)
  );

  hlp_fwd_apr_rtl_tessent_mbist_SRAM_c5_controller hlp_fwd_apr_rtl_tessent_mbist_SRAM_c5_controller_inst(
      .MBIST_RA_PRSRV_FUSE_VAL(PRESERVE_FUSE_REGISTER), .MBISTPG_ALGO_SEL({
      BIST_ALGO_SEL_ts6, BIST_ALGO_SEL_ts5, BIST_ALGO_SEL_ts4, 
      BIST_ALGO_SEL_ts3, BIST_ALGO_SEL_ts2, BIST_ALGO_SEL_ts1, BIST_ALGO_SEL}), .MBISTPG_SELECT_COMMON_ALGO(BIST_SELECT_COMMON_ALGO), 
      .MBISTPG_OPSET_SELECT(BIST_OPSET_SEL), .MBISTPG_SELECT_COMMON_OPSET(BIST_SELECT_COMMON_OPSET), 
      .MBISTPG_DATA_INV_ROW_ADD_BIT_SELECT_EN(BIST_DATA_INV_ROW_ADD_BIT_SELECT_EN), 
      .MBISTPG_DATA_INV_ROW_ADD_BIT_SELECT(BIST_DATA_INV_ROW_ADD_BIT_SEL), .MBISTPG_DATA_INV_COL_ADD_BIT_SELECT_EN(BIST_DATA_INV_COL_ADD_BIT_SELECT_EN), 
      .MBISTPG_DATA_INV_COL_ADD_BIT_SELECT(BIST_DATA_INV_COL_ADD_BIT_SEL), .MBISTPG_ALGO_MODE({
      BIST_ALGO_MODE1, BIST_ALGO_MODE0}), .MBISTPG_MEM_RST(ENABLE_MEM_RESET), .MBISTPG_REDUCED_ADDR_CNT_EN(REDUCED_ADDRESS_COUNT), 
      .MEM_BYPASS_EN(memory_bypass_to_en), .MCP_BOUNDING_EN(mcp_bounding_to_en), 
      .MEM0_BIST_COLLAR_SO(BIST_SO_ts7), .MEM1_BIST_COLLAR_SO(BIST_SO_ts42), .MEM2_BIST_COLLAR_SO(BIST_SO_ts8), 
      .MEM3_BIST_COLLAR_SO(BIST_SO_ts43), .MEM4_BIST_COLLAR_SO(BIST_SO_ts72), .MEM5_BIST_COLLAR_SO(BIST_SO_ts73), 
      .MEM6_BIST_COLLAR_SO(BIST_SO_ts74), .MEM7_BIST_COLLAR_SO(BIST_SO_ts85), .MEM8_BIST_COLLAR_SO(BIST_SO_ts86), 
      .MEM9_BIST_COLLAR_SO(BIST_SO_ts87), .MEM10_BIST_COLLAR_SO(BIST_SO_ts98), 
      .MEM11_BIST_COLLAR_SO(BIST_SO_ts99), .MEM12_BIST_COLLAR_SO(BIST_SO_ts100), 
      .MEM13_BIST_COLLAR_SO(BIST_SO_ts111), .MEM14_BIST_COLLAR_SO(BIST_SO_ts112), 
      .MEM15_BIST_COLLAR_SO(BIST_SO_ts113), .MEM16_BIST_COLLAR_SO(BIST_SO_ts12), 
      .MEM17_BIST_COLLAR_SO(BIST_SO_ts13), .MEM18_BIST_COLLAR_SO(BIST_SO_ts14), 
      .MEM19_BIST_COLLAR_SO(BIST_SO_ts15), .MEM20_BIST_COLLAR_SO(BIST_SO_ts28), 
      .MEM21_BIST_COLLAR_SO(BIST_SO_ts29), .MEM22_BIST_COLLAR_SO(BIST_SO_ts30), 
      .MEM23_BIST_COLLAR_SO(BIST_SO_ts31), .MEM24_BIST_COLLAR_SO(BIST_SO_ts46), 
      .MEM25_BIST_COLLAR_SO(BIST_SO_ts47), .MEM26_BIST_COLLAR_SO(BIST_SO_ts48), 
      .MEM27_BIST_COLLAR_SO(BIST_SO_ts49), .MEM28_BIST_COLLAR_SO(BIST_SO_ts59), 
      .MEM29_BIST_COLLAR_SO(BIST_SO_ts60), .MEM30_BIST_COLLAR_SO(BIST_SO_ts61), 
      .MEM31_BIST_COLLAR_SO(BIST_SO_ts62), .FL_CNT_MODE({FL_CNT_MODE1, 
      FL_CNT_MODE0}), .MBISTPG_BIRA_EN(BIRA_EN), .CHECK_REPAIR_NEEDED(CHECK_REPAIR_NEEDED), 
      .BIST_COLLAR_GO({BIST_GO_ts62, BIST_GO_ts49, BIST_GO_ts31, 
      BIST_GO_ts15, BIST_GO_ts113, BIST_GO_ts100, BIST_GO_ts87, BIST_GO_ts74, 
      BIST_GO_ts61, BIST_GO_ts48, BIST_GO_ts30, BIST_GO_ts14, BIST_GO_ts112, 
      BIST_GO_ts99, BIST_GO_ts86, BIST_GO_ts73, BIST_GO_ts60, BIST_GO_ts47, 
      BIST_GO_ts29, BIST_GO_ts13, BIST_GO_ts111, BIST_GO_ts98, BIST_GO_ts85, 
      BIST_GO_ts72, BIST_GO_ts59, BIST_GO_ts46, BIST_GO_ts28, BIST_GO_ts12, 
      BIST_GO_ts43, BIST_GO_ts8, BIST_GO_ts42, BIST_GO_ts7}), .MBISTPG_DIAG_EN(BIST_DIAG_EN), 
      .BIST_CLK(clk_ts1), .BIST_SI(toBist[4]), .BIST_HOLD(BIST_HOLD), .BIST_SETUP2(BIST_SETUP_ts3), 
      .BIST_SETUP({BIST_SETUP_ts2, BIST_SETUP_ts1}), .MBISTPG_TESTDATA_SELECT(BIST_SELECT_TEST_DATA), 
      .TCK(to_controllers_tck), .TCK_RETIME(to_controllers_tck_retime), .MBISTPG_EN(bistEn[4]), 
      .MBISTPG_ASYNC_RESETN(BIST_ASYNC_RESET), .LV_TM(ltest_to_en_ts1), .MBISTPG_MEM_ARRAY_DUMP_MODE(MEM_ARRAY_DUMP_MODE), 
      .BIST_CLEAR_BIRA(BIST_CLEAR_BIRA_ts5), .MBISTPG_RESET_REG_SETUP2(MBISTPG_RESET_REG_SETUP2_ts5), 
      .BIST_COL_ADD(BIST_COL_ADD_ts5[1:0]), .BIST_ROW_ADD(BIST_ROW_ADD_ts5[7:0]), 
      .BIST_BANK_ADD(BIST_BANK_ADD_ts4), .BIST_WRITE_DATA(BIST_WRITE_DATA_ts5[31:0]), 
      .BIST_EXPECT_DATA(BIST_EXPECT_DATA_ts5[31:0]), .BIST_SHIFT_COLLAR(BIST_SHIFT_COLLAR_ts5), 
      .BIST_TESTDATA_SELECT_TO_COLLAR(BIST_TESTDATA_SELECT_TO_COLLAR_ts5), .MEM0_BIST_COLLAR_SI(MEM0_BIST_COLLAR_SI_ts5), 
      .MEM1_BIST_COLLAR_SI(MEM1_BIST_COLLAR_SI_ts3), .MEM2_BIST_COLLAR_SI(MEM2_BIST_COLLAR_SI_ts2), 
      .MEM3_BIST_COLLAR_SI(MEM3_BIST_COLLAR_SI_ts2), .MEM4_BIST_COLLAR_SI(MEM4_BIST_COLLAR_SI_ts2), 
      .MEM5_BIST_COLLAR_SI(MEM5_BIST_COLLAR_SI_ts2), .MEM6_BIST_COLLAR_SI(MEM6_BIST_COLLAR_SI_ts2), 
      .MEM7_BIST_COLLAR_SI(MEM7_BIST_COLLAR_SI_ts2), .MEM8_BIST_COLLAR_SI(MEM8_BIST_COLLAR_SI_ts2), 
      .MEM9_BIST_COLLAR_SI(MEM9_BIST_COLLAR_SI_ts2), .MEM10_BIST_COLLAR_SI(MEM10_BIST_COLLAR_SI_ts2), 
      .MEM11_BIST_COLLAR_SI(MEM11_BIST_COLLAR_SI_ts2), .MEM12_BIST_COLLAR_SI(MEM12_BIST_COLLAR_SI_ts2), 
      .MEM13_BIST_COLLAR_SI(MEM13_BIST_COLLAR_SI_ts2), .MEM14_BIST_COLLAR_SI(MEM14_BIST_COLLAR_SI_ts2), 
      .MEM15_BIST_COLLAR_SI(MEM15_BIST_COLLAR_SI_ts2), .MEM16_BIST_COLLAR_SI(MEM16_BIST_COLLAR_SI_ts2), 
      .MEM17_BIST_COLLAR_SI(MEM17_BIST_COLLAR_SI_ts2), .MEM18_BIST_COLLAR_SI(MEM18_BIST_COLLAR_SI_ts2), 
      .MEM19_BIST_COLLAR_SI(MEM19_BIST_COLLAR_SI_ts2), .MEM20_BIST_COLLAR_SI(MEM20_BIST_COLLAR_SI_ts1), 
      .MEM21_BIST_COLLAR_SI(MEM21_BIST_COLLAR_SI_ts1), .MEM22_BIST_COLLAR_SI(MEM22_BIST_COLLAR_SI_ts1), 
      .MEM23_BIST_COLLAR_SI(MEM23_BIST_COLLAR_SI_ts1), .MEM24_BIST_COLLAR_SI(MEM24_BIST_COLLAR_SI_ts1), 
      .MEM25_BIST_COLLAR_SI(MEM25_BIST_COLLAR_SI_ts1), .MEM26_BIST_COLLAR_SI(MEM26_BIST_COLLAR_SI_ts1), 
      .MEM27_BIST_COLLAR_SI(MEM27_BIST_COLLAR_SI_ts1), .MEM28_BIST_COLLAR_SI(MEM28_BIST_COLLAR_SI_ts1), 
      .MEM29_BIST_COLLAR_SI(MEM29_BIST_COLLAR_SI_ts1), .MEM30_BIST_COLLAR_SI(MEM30_BIST_COLLAR_SI_ts1), 
      .MEM31_BIST_COLLAR_SI(MEM31_BIST_COLLAR_SI_ts1), .BIST_COLLAR_SETUP(BIST_COLLAR_SETUP_ts5), 
      .BIST_COLLAR_OPSET_SELECT(BIST_COLLAR_OPSET_SELECT_ts5), .BIST_COLLAR_HOLD(BIST_COLLAR_HOLD_ts5), 
      .FREEZE_STOP_ERROR(FREEZE_STOP_ERROR_ts5), .ERROR_CNT_ZERO(ERROR_CNT_ZERO_ts5), 
      .BIST_COLLAR_DIAG_EN(BIST_COLLAR_DIAG_EN_ts5), .BIST_COLLAR_BIRA_EN(BIST_COLLAR_BIRA_EN_ts5), 
      .BIST_CLEAR_DEFAULT(BIST_CLEAR_DEFAULT_ts5), .BIST_CLEAR(BIST_CLEAR_ts5), 
      .MBISTPG_SO(MBISTPG_SO_ts5), .PriorityColumn(PriorityColumn_ts5), .BIST_WRITEENABLE(BIST_WRITEENABLE_ts5), 
      .BIST_SELECT(BIST_SELECT_ts4), .BIST_CMP(BIST_CMP_ts5), .BIST_COLLAR_EN0(BIST_COLLAR_EN0_ts5), 
      .BIST_RUN_TO_COLLAR0(BIST_RUN_TO_COLLAR0_ts5), .BIST_COLLAR_EN1(BIST_COLLAR_EN1_ts3), 
      .BIST_RUN_TO_COLLAR1(BIST_RUN_TO_COLLAR1_ts3), .BIST_COLLAR_EN2(BIST_COLLAR_EN2_ts2), 
      .BIST_RUN_TO_COLLAR2(BIST_RUN_TO_COLLAR2_ts2), .BIST_COLLAR_EN3(BIST_COLLAR_EN3_ts2), 
      .BIST_RUN_TO_COLLAR3(BIST_RUN_TO_COLLAR3_ts2), .BIST_COLLAR_EN4(BIST_COLLAR_EN4_ts2), 
      .BIST_RUN_TO_COLLAR4(BIST_RUN_TO_COLLAR4_ts2), .BIST_COLLAR_EN5(BIST_COLLAR_EN5_ts2), 
      .BIST_RUN_TO_COLLAR5(BIST_RUN_TO_COLLAR5_ts2), .BIST_COLLAR_EN6(BIST_COLLAR_EN6_ts2), 
      .BIST_RUN_TO_COLLAR6(BIST_RUN_TO_COLLAR6_ts2), .BIST_COLLAR_EN7(BIST_COLLAR_EN7_ts2), 
      .BIST_RUN_TO_COLLAR7(BIST_RUN_TO_COLLAR7_ts2), .BIST_COLLAR_EN8(BIST_COLLAR_EN8_ts2), 
      .BIST_RUN_TO_COLLAR8(BIST_RUN_TO_COLLAR8_ts2), .BIST_COLLAR_EN9(BIST_COLLAR_EN9_ts2), 
      .BIST_RUN_TO_COLLAR9(BIST_RUN_TO_COLLAR9_ts2), .BIST_COLLAR_EN10(BIST_COLLAR_EN10_ts2), 
      .BIST_RUN_TO_COLLAR10(BIST_RUN_TO_COLLAR10_ts2), .BIST_COLLAR_EN11(BIST_COLLAR_EN11_ts2), 
      .BIST_RUN_TO_COLLAR11(BIST_RUN_TO_COLLAR11_ts2), .BIST_COLLAR_EN12(BIST_COLLAR_EN12_ts2), 
      .BIST_RUN_TO_COLLAR12(BIST_RUN_TO_COLLAR12_ts2), .BIST_COLLAR_EN13(BIST_COLLAR_EN13_ts2), 
      .BIST_RUN_TO_COLLAR13(BIST_RUN_TO_COLLAR13_ts2), .BIST_COLLAR_EN14(BIST_COLLAR_EN14_ts2), 
      .BIST_RUN_TO_COLLAR14(BIST_RUN_TO_COLLAR14_ts2), .BIST_COLLAR_EN15(BIST_COLLAR_EN15_ts2), 
      .BIST_RUN_TO_COLLAR15(BIST_RUN_TO_COLLAR15_ts2), .BIST_COLLAR_EN16(BIST_COLLAR_EN16_ts2), 
      .BIST_RUN_TO_COLLAR16(BIST_RUN_TO_COLLAR16_ts2), .BIST_COLLAR_EN17(BIST_COLLAR_EN17_ts2), 
      .BIST_RUN_TO_COLLAR17(BIST_RUN_TO_COLLAR17_ts2), .BIST_COLLAR_EN18(BIST_COLLAR_EN18_ts2), 
      .BIST_RUN_TO_COLLAR18(BIST_RUN_TO_COLLAR18_ts2), .BIST_COLLAR_EN19(BIST_COLLAR_EN19_ts2), 
      .BIST_RUN_TO_COLLAR19(BIST_RUN_TO_COLLAR19_ts2), .BIST_COLLAR_EN20(BIST_COLLAR_EN20_ts1), 
      .BIST_RUN_TO_COLLAR20(BIST_RUN_TO_COLLAR20_ts1), .BIST_COLLAR_EN21(BIST_COLLAR_EN21_ts1), 
      .BIST_RUN_TO_COLLAR21(BIST_RUN_TO_COLLAR21_ts1), .BIST_COLLAR_EN22(BIST_COLLAR_EN22_ts1), 
      .BIST_RUN_TO_COLLAR22(BIST_RUN_TO_COLLAR22_ts1), .BIST_COLLAR_EN23(BIST_COLLAR_EN23_ts1), 
      .BIST_RUN_TO_COLLAR23(BIST_RUN_TO_COLLAR23_ts1), .BIST_COLLAR_EN24(BIST_COLLAR_EN24_ts1), 
      .BIST_RUN_TO_COLLAR24(BIST_RUN_TO_COLLAR24_ts1), .BIST_COLLAR_EN25(BIST_COLLAR_EN25_ts1), 
      .BIST_RUN_TO_COLLAR25(BIST_RUN_TO_COLLAR25_ts1), .BIST_COLLAR_EN26(BIST_COLLAR_EN26_ts1), 
      .BIST_RUN_TO_COLLAR26(BIST_RUN_TO_COLLAR26_ts1), .BIST_COLLAR_EN27(BIST_COLLAR_EN27_ts1), 
      .BIST_RUN_TO_COLLAR27(BIST_RUN_TO_COLLAR27_ts1), .BIST_COLLAR_EN28(BIST_COLLAR_EN28_ts1), 
      .BIST_RUN_TO_COLLAR28(BIST_RUN_TO_COLLAR28_ts1), .BIST_COLLAR_EN29(BIST_COLLAR_EN29_ts1), 
      .BIST_RUN_TO_COLLAR29(BIST_RUN_TO_COLLAR29_ts1), .BIST_COLLAR_EN30(BIST_COLLAR_EN30_ts1), 
      .BIST_RUN_TO_COLLAR30(BIST_RUN_TO_COLLAR30_ts1), .BIST_COLLAR_EN31(BIST_COLLAR_EN31_ts1), 
      .BIST_RUN_TO_COLLAR31(BIST_RUN_TO_COLLAR31_ts1), .MBISTPG_GO(MBISTPG_GO_ts5), 
      .MBISTPG_STABLE(MBISTPG_STABLE_ts4), .MBISTPG_DONE(MBISTPG_DONE_ts5), .BIST_ON_TO_COLLAR(BIST_ON_TO_COLLAR_ts5), 
      .BIST_SHIFT_BIRA_COLLAR(BIST_SHIFT_BIRA_COLLAR_ts5), .GO_ID_REG_SEL(GO_ID_REG_SEL_ts4), 
      .ALGO_SEL_REG(ALGO_SEL_REG_ts5), .fscan_clkungate(fscan_clkungate)
  );

  hlp_fwd_apr_rtl_tessent_mbist_SRAM_c6_controller hlp_fwd_apr_rtl_tessent_mbist_SRAM_c6_controller_inst(
      .MBIST_RA_PRSRV_FUSE_VAL(PRESERVE_FUSE_REGISTER), .MBISTPG_ALGO_SEL({
      BIST_ALGO_SEL_ts6, BIST_ALGO_SEL_ts5, BIST_ALGO_SEL_ts4, 
      BIST_ALGO_SEL_ts3, BIST_ALGO_SEL_ts2, BIST_ALGO_SEL_ts1, BIST_ALGO_SEL}), .MBISTPG_SELECT_COMMON_ALGO(BIST_SELECT_COMMON_ALGO), 
      .MBISTPG_OPSET_SELECT(BIST_OPSET_SEL), .MBISTPG_SELECT_COMMON_OPSET(BIST_SELECT_COMMON_OPSET), 
      .MBISTPG_DATA_INV_ROW_ADD_BIT_SELECT_EN(BIST_DATA_INV_ROW_ADD_BIT_SELECT_EN), 
      .MBISTPG_DATA_INV_ROW_ADD_BIT_SELECT(BIST_DATA_INV_ROW_ADD_BIT_SEL), .MBISTPG_DATA_INV_COL_ADD_BIT_SELECT_EN(BIST_DATA_INV_COL_ADD_BIT_SELECT_EN), 
      .MBISTPG_DATA_INV_COL_ADD_BIT_SELECT(BIST_DATA_INV_COL_ADD_BIT_SEL), .MBISTPG_ALGO_MODE({
      BIST_ALGO_MODE1, BIST_ALGO_MODE0}), .MBISTPG_MEM_RST(ENABLE_MEM_RESET), .MBISTPG_REDUCED_ADDR_CNT_EN(REDUCED_ADDRESS_COUNT), 
      .MEM_BYPASS_EN(memory_bypass_to_en), .MCP_BOUNDING_EN(mcp_bounding_to_en), 
      .MEM0_BIST_COLLAR_SO(BIST_SO_ts9), .MEM1_BIST_COLLAR_SO(BIST_SO_ts44), .FL_CNT_MODE({
      FL_CNT_MODE1, FL_CNT_MODE0}), .MBISTPG_BIRA_EN(BIRA_EN), .CHECK_REPAIR_NEEDED(CHECK_REPAIR_NEEDED), 
      .BIST_COLLAR_GO({BIST_GO_ts44, BIST_GO_ts9}), .MBISTPG_DIAG_EN(BIST_DIAG_EN), 
      .BIST_CLK(clk_ts1), .BIST_SI(toBist[5]), .BIST_HOLD(BIST_HOLD), .BIST_SETUP2(BIST_SETUP_ts3), 
      .BIST_SETUP({BIST_SETUP_ts2, BIST_SETUP_ts1}), .MBISTPG_TESTDATA_SELECT(BIST_SELECT_TEST_DATA), 
      .TCK(to_controllers_tck), .TCK_RETIME(to_controllers_tck_retime), .MBISTPG_EN(bistEn[5]), 
      .MBISTPG_ASYNC_RESETN(BIST_ASYNC_RESET), .LV_TM(ltest_to_en_ts1), .MBISTPG_MEM_ARRAY_DUMP_MODE(MEM_ARRAY_DUMP_MODE), 
      .BIST_CLEAR_BIRA(BIST_CLEAR_BIRA_ts6), .MBISTPG_RESET_REG_SETUP2(MBISTPG_RESET_REG_SETUP2_ts6), 
      .BIST_COL_ADD(BIST_COL_ADD_ts6[2:0]), .BIST_ROW_ADD(BIST_ROW_ADD_ts6[7:0]), 
      .BIST_WRITE_DATA(BIST_WRITE_DATA_ts6[31:0]), .BIST_EXPECT_DATA(BIST_EXPECT_DATA_ts6[31:0]), 
      .BIST_SHIFT_COLLAR(BIST_SHIFT_COLLAR_ts6), .BIST_TESTDATA_SELECT_TO_COLLAR(BIST_TESTDATA_SELECT_TO_COLLAR_ts6), 
      .MEM0_BIST_COLLAR_SI(MEM0_BIST_COLLAR_SI_ts6), .MEM1_BIST_COLLAR_SI(MEM1_BIST_COLLAR_SI_ts4), 
      .BIST_COLLAR_SETUP(BIST_COLLAR_SETUP_ts6), .BIST_COLLAR_OPSET_SELECT(BIST_COLLAR_OPSET_SELECT_ts6), 
      .BIST_COLLAR_HOLD(BIST_COLLAR_HOLD_ts6), .FREEZE_STOP_ERROR(FREEZE_STOP_ERROR_ts6), 
      .ERROR_CNT_ZERO(ERROR_CNT_ZERO_ts6), .BIST_COLLAR_DIAG_EN(BIST_COLLAR_DIAG_EN_ts6), 
      .BIST_COLLAR_BIRA_EN(BIST_COLLAR_BIRA_EN_ts6), .BIST_CLEAR_DEFAULT(BIST_CLEAR_DEFAULT_ts6), 
      .BIST_CLEAR(BIST_CLEAR_ts6), .MBISTPG_SO(MBISTPG_SO_ts6), .PriorityColumn(PriorityColumn_ts6), 
      .BIST_WRITEENABLE(BIST_WRITEENABLE_ts6), .BIST_SELECT(BIST_SELECT_ts5), .BIST_CMP(BIST_CMP_ts6), 
      .BIST_COLLAR_EN0(BIST_COLLAR_EN0_ts6), .BIST_RUN_TO_COLLAR0(BIST_RUN_TO_COLLAR0_ts6), 
      .BIST_COLLAR_EN1(BIST_COLLAR_EN1_ts4), .BIST_RUN_TO_COLLAR1(BIST_RUN_TO_COLLAR1_ts4), 
      .MBISTPG_GO(MBISTPG_GO_ts6), .MBISTPG_STABLE(MBISTPG_STABLE_ts5), .MBISTPG_DONE(MBISTPG_DONE_ts6), 
      .BIST_ON_TO_COLLAR(BIST_ON_TO_COLLAR_ts6), .BIST_SHIFT_BIRA_COLLAR(BIST_SHIFT_BIRA_COLLAR_ts6), 
      .GO_ID_REG_SEL(GO_ID_REG_SEL_ts5), .ALGO_SEL_REG(ALGO_SEL_REG_ts6), .fscan_clkungate(fscan_clkungate)
  );

  hlp_fwd_apr_rtl_tessent_mbist_SRAM_c7_controller hlp_fwd_apr_rtl_tessent_mbist_SRAM_c7_controller_inst(
      .MBIST_RA_PRSRV_FUSE_VAL(PRESERVE_FUSE_REGISTER), .MBISTPG_ALGO_SEL({
      BIST_ALGO_SEL_ts6, BIST_ALGO_SEL_ts5, BIST_ALGO_SEL_ts4, 
      BIST_ALGO_SEL_ts3, BIST_ALGO_SEL_ts2, BIST_ALGO_SEL_ts1, BIST_ALGO_SEL}), .MBISTPG_SELECT_COMMON_ALGO(BIST_SELECT_COMMON_ALGO), 
      .MBISTPG_OPSET_SELECT(BIST_OPSET_SEL), .MBISTPG_SELECT_COMMON_OPSET(BIST_SELECT_COMMON_OPSET), 
      .MBISTPG_DATA_INV_ROW_ADD_BIT_SELECT_EN(BIST_DATA_INV_ROW_ADD_BIT_SELECT_EN), 
      .MBISTPG_DATA_INV_ROW_ADD_BIT_SELECT(BIST_DATA_INV_ROW_ADD_BIT_SEL), .MBISTPG_DATA_INV_COL_ADD_BIT_SELECT_EN(BIST_DATA_INV_COL_ADD_BIT_SELECT_EN), 
      .MBISTPG_DATA_INV_COL_ADD_BIT_SELECT(BIST_DATA_INV_COL_ADD_BIT_SEL), .MBISTPG_ALGO_MODE({
      BIST_ALGO_MODE1, BIST_ALGO_MODE0}), .MBISTPG_MEM_RST(ENABLE_MEM_RESET), .MBISTPG_REDUCED_ADDR_CNT_EN(REDUCED_ADDRESS_COUNT), 
      .MEM_BYPASS_EN(memory_bypass_to_en), .MCP_BOUNDING_EN(mcp_bounding_to_en), 
      .MEM0_BIST_COLLAR_SO(BIST_SO_ts125), .MEM1_BIST_COLLAR_SO(BIST_SO_ts126), 
      .MEM2_BIST_COLLAR_SO(BIST_SO_ts127), .MEM3_BIST_COLLAR_SO(BIST_SO_ts128), 
      .MEM4_BIST_COLLAR_SO(BIST_SO_ts129), .MEM5_BIST_COLLAR_SO(BIST_SO_ts130), 
      .MEM6_BIST_COLLAR_SO(BIST_SO_ts131), .MEM7_BIST_COLLAR_SO(BIST_SO_ts132), 
      .FL_CNT_MODE({FL_CNT_MODE1, FL_CNT_MODE0}), .MBISTPG_BIRA_EN(BIRA_EN), .CHECK_REPAIR_NEEDED(CHECK_REPAIR_NEEDED), 
      .BIST_COLLAR_GO({BIST_GO_ts132, BIST_GO_ts131, BIST_GO_ts130, 
      BIST_GO_ts129, BIST_GO_ts128, BIST_GO_ts127, BIST_GO_ts126, 
      BIST_GO_ts125}), .MBISTPG_DIAG_EN(BIST_DIAG_EN), .BIST_CLK(clk_ts1), .BIST_SI(toBist[6]), 
      .BIST_HOLD(BIST_HOLD), .BIST_SETUP2(BIST_SETUP_ts3), .BIST_SETUP({
      BIST_SETUP_ts2, BIST_SETUP_ts1}), .MBISTPG_TESTDATA_SELECT(BIST_SELECT_TEST_DATA), 
      .TCK(to_controllers_tck), .TCK_RETIME(to_controllers_tck_retime), .MBISTPG_EN(bistEn[6]), 
      .MBISTPG_ASYNC_RESETN(BIST_ASYNC_RESET), .LV_TM(ltest_to_en_ts1), .MBISTPG_MEM_ARRAY_DUMP_MODE(MEM_ARRAY_DUMP_MODE), 
      .BIST_CLEAR_BIRA(BIST_CLEAR_BIRA_ts7), .MBISTPG_RESET_REG_SETUP2(MBISTPG_RESET_REG_SETUP2_ts7), 
      .BIST_COL_ADD(BIST_COL_ADD_ts7[1:0]), .BIST_ROW_ADD(BIST_ROW_ADD_ts7[7:0]), 
      .BIST_BANK_ADD(BIST_BANK_ADD_ts5[1:0]), .BIST_WRITE_DATA(BIST_WRITE_DATA_ts7[22:0]), 
      .BIST_EXPECT_DATA(BIST_EXPECT_DATA_ts7[22:0]), .BIST_SHIFT_COLLAR(BIST_SHIFT_COLLAR_ts7), 
      .BIST_TESTDATA_SELECT_TO_COLLAR(BIST_TESTDATA_SELECT_TO_COLLAR_ts7), .MEM0_BIST_COLLAR_SI(MEM0_BIST_COLLAR_SI_ts7), 
      .MEM1_BIST_COLLAR_SI(MEM1_BIST_COLLAR_SI_ts5), .MEM2_BIST_COLLAR_SI(MEM2_BIST_COLLAR_SI_ts3), 
      .MEM3_BIST_COLLAR_SI(MEM3_BIST_COLLAR_SI_ts3), .MEM4_BIST_COLLAR_SI(MEM4_BIST_COLLAR_SI_ts3), 
      .MEM5_BIST_COLLAR_SI(MEM5_BIST_COLLAR_SI_ts3), .MEM6_BIST_COLLAR_SI(MEM6_BIST_COLLAR_SI_ts3), 
      .MEM7_BIST_COLLAR_SI(MEM7_BIST_COLLAR_SI_ts3), .BIST_COLLAR_SETUP(BIST_COLLAR_SETUP_ts7), 
      .BIST_COLLAR_OPSET_SELECT(BIST_COLLAR_OPSET_SELECT_ts7), .BIST_COLLAR_HOLD(BIST_COLLAR_HOLD_ts7), 
      .FREEZE_STOP_ERROR(FREEZE_STOP_ERROR_ts7), .ERROR_CNT_ZERO(ERROR_CNT_ZERO_ts7), 
      .BIST_COLLAR_DIAG_EN(BIST_COLLAR_DIAG_EN_ts7), .BIST_COLLAR_BIRA_EN(BIST_COLLAR_BIRA_EN_ts7), 
      .BIST_CLEAR_DEFAULT(BIST_CLEAR_DEFAULT_ts7), .BIST_CLEAR(BIST_CLEAR_ts7), 
      .MBISTPG_SO(MBISTPG_SO_ts7), .PriorityColumn(PriorityColumn_ts7), .BIST_WRITEENABLE(BIST_WRITEENABLE_ts7), 
      .BIST_SELECT(BIST_SELECT_ts6), .BIST_CMP(BIST_CMP_ts7), .BIST_COLLAR_EN0(BIST_COLLAR_EN0_ts7), 
      .BIST_RUN_TO_COLLAR0(BIST_RUN_TO_COLLAR0_ts7), .BIST_COLLAR_EN1(BIST_COLLAR_EN1_ts5), 
      .BIST_RUN_TO_COLLAR1(BIST_RUN_TO_COLLAR1_ts5), .BIST_COLLAR_EN2(BIST_COLLAR_EN2_ts3), 
      .BIST_RUN_TO_COLLAR2(BIST_RUN_TO_COLLAR2_ts3), .BIST_COLLAR_EN3(BIST_COLLAR_EN3_ts3), 
      .BIST_RUN_TO_COLLAR3(BIST_RUN_TO_COLLAR3_ts3), .BIST_COLLAR_EN4(BIST_COLLAR_EN4_ts3), 
      .BIST_RUN_TO_COLLAR4(BIST_RUN_TO_COLLAR4_ts3), .BIST_COLLAR_EN5(BIST_COLLAR_EN5_ts3), 
      .BIST_RUN_TO_COLLAR5(BIST_RUN_TO_COLLAR5_ts3), .BIST_COLLAR_EN6(BIST_COLLAR_EN6_ts3), 
      .BIST_RUN_TO_COLLAR6(BIST_RUN_TO_COLLAR6_ts3), .BIST_COLLAR_EN7(BIST_COLLAR_EN7_ts3), 
      .BIST_RUN_TO_COLLAR7(BIST_RUN_TO_COLLAR7_ts3), .MBISTPG_GO(MBISTPG_GO_ts7), 
      .MBISTPG_STABLE(MBISTPG_STABLE_ts6), .MBISTPG_DONE(MBISTPG_DONE_ts7), .BIST_ON_TO_COLLAR(BIST_ON_TO_COLLAR_ts7), 
      .BIST_SHIFT_BIRA_COLLAR(BIST_SHIFT_BIRA_COLLAR_ts7), .GO_ID_REG_SEL(GO_ID_REG_SEL_ts6), 
      .ALGO_SEL_REG(ALGO_SEL_REG_ts7), .fscan_clkungate(fscan_clkungate)
  );

  hlp_fwd_apr_rtl_tessent_mbist_SRAM_c8_controller hlp_fwd_apr_rtl_tessent_mbist_SRAM_c8_controller_inst(
      .MBIST_RA_PRSRV_FUSE_VAL(PRESERVE_FUSE_REGISTER), .MBISTPG_ALGO_SEL({
      BIST_ALGO_SEL_ts6, BIST_ALGO_SEL_ts5, BIST_ALGO_SEL_ts4, 
      BIST_ALGO_SEL_ts3, BIST_ALGO_SEL_ts2, BIST_ALGO_SEL_ts1, BIST_ALGO_SEL}), .MBISTPG_SELECT_COMMON_ALGO(BIST_SELECT_COMMON_ALGO), 
      .MBISTPG_OPSET_SELECT(BIST_OPSET_SEL), .MBISTPG_SELECT_COMMON_OPSET(BIST_SELECT_COMMON_OPSET), 
      .MBISTPG_DATA_INV_ROW_ADD_BIT_SELECT_EN(BIST_DATA_INV_ROW_ADD_BIT_SELECT_EN), 
      .MBISTPG_DATA_INV_ROW_ADD_BIT_SELECT(BIST_DATA_INV_ROW_ADD_BIT_SEL), .MBISTPG_DATA_INV_COL_ADD_BIT_SELECT_EN(BIST_DATA_INV_COL_ADD_BIT_SELECT_EN), 
      .MBISTPG_DATA_INV_COL_ADD_BIT_SELECT(BIST_DATA_INV_COL_ADD_BIT_SEL), .MBISTPG_ALGO_MODE({
      BIST_ALGO_MODE1, BIST_ALGO_MODE0}), .MBISTPG_MEM_RST(ENABLE_MEM_RESET), .MBISTPG_REDUCED_ADDR_CNT_EN(REDUCED_ADDRESS_COUNT), 
      .MEM_BYPASS_EN(memory_bypass_to_en), .MCP_BOUNDING_EN(mcp_bounding_to_en), 
      .MEM0_BIST_COLLAR_SO(BIST_SO_ts11), .MEM1_BIST_COLLAR_SO(BIST_SO_ts22), .MEM2_BIST_COLLAR_SO(BIST_SO_ts23), 
      .FL_CNT_MODE({FL_CNT_MODE1, FL_CNT_MODE0}), .MBISTPG_BIRA_EN(BIRA_EN), .CHECK_REPAIR_NEEDED(CHECK_REPAIR_NEEDED), 
      .BIST_COLLAR_GO({BIST_GO_ts23, BIST_GO_ts22, BIST_GO_ts11}), .MBISTPG_DIAG_EN(BIST_DIAG_EN), 
      .BIST_CLK(clk_ts1), .BIST_SI(toBist[7]), .BIST_HOLD(BIST_HOLD), .BIST_SETUP2(BIST_SETUP_ts3), 
      .BIST_SETUP({BIST_SETUP_ts2, BIST_SETUP_ts1}), .MBISTPG_TESTDATA_SELECT(BIST_SELECT_TEST_DATA), 
      .TCK(to_controllers_tck), .TCK_RETIME(to_controllers_tck_retime), .MBISTPG_EN(bistEn[7]), 
      .MBISTPG_ASYNC_RESETN(BIST_ASYNC_RESET), .LV_TM(ltest_to_en_ts1), .MBISTPG_MEM_ARRAY_DUMP_MODE(MEM_ARRAY_DUMP_MODE), 
      .BIST_CLEAR_BIRA(BIST_CLEAR_BIRA_ts8), .MBISTPG_RESET_REG_SETUP2(MBISTPG_RESET_REG_SETUP2_ts8), 
      .BIST_COL_ADD(BIST_COL_ADD_ts8[1:0]), .BIST_ROW_ADD(BIST_ROW_ADD_ts8[7:0]), 
      .BIST_WRITE_DATA(BIST_WRITE_DATA_ts8[31:0]), .BIST_EXPECT_DATA(BIST_EXPECT_DATA_ts8[31:0]), 
      .BIST_SHIFT_COLLAR(BIST_SHIFT_COLLAR_ts8), .BIST_TESTDATA_SELECT_TO_COLLAR(BIST_TESTDATA_SELECT_TO_COLLAR_ts8), 
      .MEM0_BIST_COLLAR_SI(MEM0_BIST_COLLAR_SI_ts8), .MEM1_BIST_COLLAR_SI(MEM1_BIST_COLLAR_SI_ts6), 
      .MEM2_BIST_COLLAR_SI(MEM2_BIST_COLLAR_SI_ts4), .BIST_COLLAR_SETUP(BIST_COLLAR_SETUP_ts8), 
      .BIST_COLLAR_OPSET_SELECT(BIST_COLLAR_OPSET_SELECT_ts8), .BIST_COLLAR_HOLD(BIST_COLLAR_HOLD_ts8), 
      .FREEZE_STOP_ERROR(FREEZE_STOP_ERROR_ts8), .ERROR_CNT_ZERO(ERROR_CNT_ZERO_ts8), 
      .BIST_COLLAR_DIAG_EN(BIST_COLLAR_DIAG_EN_ts8), .BIST_COLLAR_BIRA_EN(BIST_COLLAR_BIRA_EN_ts8), 
      .BIST_CLEAR_DEFAULT(BIST_CLEAR_DEFAULT_ts8), .BIST_CLEAR(BIST_CLEAR_ts8), 
      .MBISTPG_SO(MBISTPG_SO_ts8), .PriorityColumn(PriorityColumn_ts8), .BIST_WRITEENABLE(BIST_WRITEENABLE_ts8), 
      .BIST_SELECT(BIST_SELECT_ts7), .BIST_CMP(BIST_CMP_ts8), .BIST_COLLAR_EN0(BIST_COLLAR_EN0_ts8), 
      .BIST_RUN_TO_COLLAR0(BIST_RUN_TO_COLLAR0_ts8), .BIST_COLLAR_EN1(BIST_COLLAR_EN1_ts6), 
      .BIST_RUN_TO_COLLAR1(BIST_RUN_TO_COLLAR1_ts6), .BIST_COLLAR_EN2(BIST_COLLAR_EN2_ts4), 
      .BIST_RUN_TO_COLLAR2(BIST_RUN_TO_COLLAR2_ts4), .MBISTPG_GO(MBISTPG_GO_ts8), 
      .MBISTPG_STABLE(MBISTPG_STABLE_ts7), .MBISTPG_DONE(MBISTPG_DONE_ts8), .BIST_ON_TO_COLLAR(BIST_ON_TO_COLLAR_ts8), 
      .BIST_SHIFT_BIRA_COLLAR(BIST_SHIFT_BIRA_COLLAR_ts8), .GO_ID_REG_SEL(GO_ID_REG_SEL_ts7), 
      .ALGO_SEL_REG(ALGO_SEL_REG_ts8), .fscan_clkungate(fscan_clkungate)
  );

  hlp_fwd_apr_rtl_tessent_mbist_SRAM_c9_controller hlp_fwd_apr_rtl_tessent_mbist_SRAM_c9_controller_inst(
      .MBIST_RA_PRSRV_FUSE_VAL(PRESERVE_FUSE_REGISTER), .MBISTPG_ALGO_SEL({
      BIST_ALGO_SEL_ts6, BIST_ALGO_SEL_ts5, BIST_ALGO_SEL_ts4, 
      BIST_ALGO_SEL_ts3, BIST_ALGO_SEL_ts2, BIST_ALGO_SEL_ts1, BIST_ALGO_SEL}), .MBISTPG_SELECT_COMMON_ALGO(BIST_SELECT_COMMON_ALGO), 
      .MBISTPG_OPSET_SELECT(BIST_OPSET_SEL), .MBISTPG_SELECT_COMMON_OPSET(BIST_SELECT_COMMON_OPSET), 
      .MBISTPG_DATA_INV_ROW_ADD_BIT_SELECT_EN(BIST_DATA_INV_ROW_ADD_BIT_SELECT_EN), 
      .MBISTPG_DATA_INV_ROW_ADD_BIT_SELECT(BIST_DATA_INV_ROW_ADD_BIT_SEL), .MBISTPG_DATA_INV_COL_ADD_BIT_SELECT_EN(BIST_DATA_INV_COL_ADD_BIT_SELECT_EN), 
      .MBISTPG_DATA_INV_COL_ADD_BIT_SELECT(BIST_DATA_INV_COL_ADD_BIT_SEL), .MBISTPG_ALGO_MODE({
      BIST_ALGO_MODE1, BIST_ALGO_MODE0}), .MBISTPG_MEM_RST(ENABLE_MEM_RESET), .MBISTPG_REDUCED_ADDR_CNT_EN(REDUCED_ADDRESS_COUNT), 
      .MEM_BYPASS_EN(memory_bypass_to_en), .MCP_BOUNDING_EN(mcp_bounding_to_en), 
      .MEM0_BIST_COLLAR_SO(BIST_SO_ts75), .MEM1_BIST_COLLAR_SO(BIST_SO_ts76), .MEM2_BIST_COLLAR_SO(BIST_SO_ts77), 
      .MEM3_BIST_COLLAR_SO(BIST_SO_ts78), .MEM4_BIST_COLLAR_SO(BIST_SO_ts88), .MEM5_BIST_COLLAR_SO(BIST_SO_ts89), 
      .MEM6_BIST_COLLAR_SO(BIST_SO_ts90), .MEM7_BIST_COLLAR_SO(BIST_SO_ts91), .MEM8_BIST_COLLAR_SO(BIST_SO_ts101), 
      .MEM9_BIST_COLLAR_SO(BIST_SO_ts102), .MEM10_BIST_COLLAR_SO(BIST_SO_ts103), 
      .MEM11_BIST_COLLAR_SO(BIST_SO_ts104), .MEM12_BIST_COLLAR_SO(BIST_SO_ts114), 
      .MEM13_BIST_COLLAR_SO(BIST_SO_ts115), .MEM14_BIST_COLLAR_SO(BIST_SO_ts116), 
      .MEM15_BIST_COLLAR_SO(BIST_SO_ts117), .MEM16_BIST_COLLAR_SO(BIST_SO_ts16), 
      .MEM17_BIST_COLLAR_SO(BIST_SO_ts17), .MEM18_BIST_COLLAR_SO(BIST_SO_ts18), 
      .MEM19_BIST_COLLAR_SO(BIST_SO_ts19), .MEM20_BIST_COLLAR_SO(BIST_SO_ts32), 
      .MEM21_BIST_COLLAR_SO(BIST_SO_ts33), .MEM22_BIST_COLLAR_SO(BIST_SO_ts34), 
      .MEM23_BIST_COLLAR_SO(BIST_SO_ts35), .MEM24_BIST_COLLAR_SO(BIST_SO_ts50), 
      .MEM25_BIST_COLLAR_SO(BIST_SO_ts51), .MEM26_BIST_COLLAR_SO(BIST_SO_ts52), 
      .MEM27_BIST_COLLAR_SO(BIST_SO_ts53), .MEM28_BIST_COLLAR_SO(BIST_SO_ts63), 
      .MEM29_BIST_COLLAR_SO(BIST_SO_ts64), .MEM30_BIST_COLLAR_SO(BIST_SO_ts65), 
      .MEM31_BIST_COLLAR_SO(BIST_SO_ts66), .FL_CNT_MODE({FL_CNT_MODE1, 
      FL_CNT_MODE0}), .MBISTPG_BIRA_EN(BIRA_EN), .CHECK_REPAIR_NEEDED(CHECK_REPAIR_NEEDED), 
      .BIST_COLLAR_GO({BIST_GO_ts66, BIST_GO_ts53, BIST_GO_ts35, 
      BIST_GO_ts19, BIST_GO_ts117, BIST_GO_ts104, BIST_GO_ts91, BIST_GO_ts78, 
      BIST_GO_ts65, BIST_GO_ts52, BIST_GO_ts34, BIST_GO_ts18, BIST_GO_ts116, 
      BIST_GO_ts103, BIST_GO_ts90, BIST_GO_ts77, BIST_GO_ts64, BIST_GO_ts51, 
      BIST_GO_ts33, BIST_GO_ts17, BIST_GO_ts115, BIST_GO_ts102, BIST_GO_ts89, 
      BIST_GO_ts76, BIST_GO_ts63, BIST_GO_ts50, BIST_GO_ts32, BIST_GO_ts16, 
      BIST_GO_ts114, BIST_GO_ts101, BIST_GO_ts88, BIST_GO_ts75}), .MBISTPG_DIAG_EN(BIST_DIAG_EN), 
      .BIST_CLK(clk_ts1), .BIST_SI(toBist[8]), .BIST_HOLD(BIST_HOLD), .BIST_SETUP2(BIST_SETUP_ts3), 
      .BIST_SETUP({BIST_SETUP_ts2, BIST_SETUP_ts1}), .MBISTPG_TESTDATA_SELECT(BIST_SELECT_TEST_DATA), 
      .TCK(to_controllers_tck), .TCK_RETIME(to_controllers_tck_retime), .MBISTPG_EN(bistEn[8]), 
      .MBISTPG_ASYNC_RESETN(BIST_ASYNC_RESET), .LV_TM(ltest_to_en_ts1), .MBISTPG_MEM_ARRAY_DUMP_MODE(MEM_ARRAY_DUMP_MODE), 
      .BIST_CLEAR_BIRA(BIST_CLEAR_BIRA_ts9), .MBISTPG_RESET_REG_SETUP2(MBISTPG_RESET_REG_SETUP2_ts9), 
      .BIST_COL_ADD(BIST_COL_ADD_ts9[1:0]), .BIST_ROW_ADD(BIST_ROW_ADD_ts9[7:0]), 
      .BIST_BANK_ADD(BIST_BANK_ADD_ts6), .BIST_WRITE_DATA(BIST_WRITE_DATA_ts9[31:0]), 
      .BIST_EXPECT_DATA(BIST_EXPECT_DATA_ts9[31:0]), .BIST_SHIFT_COLLAR(BIST_SHIFT_COLLAR_ts9), 
      .BIST_TESTDATA_SELECT_TO_COLLAR(BIST_TESTDATA_SELECT_TO_COLLAR_ts9), .MEM0_BIST_COLLAR_SI(MEM0_BIST_COLLAR_SI_ts9), 
      .MEM1_BIST_COLLAR_SI(MEM1_BIST_COLLAR_SI_ts7), .MEM2_BIST_COLLAR_SI(MEM2_BIST_COLLAR_SI_ts5), 
      .MEM3_BIST_COLLAR_SI(MEM3_BIST_COLLAR_SI_ts4), .MEM4_BIST_COLLAR_SI(MEM4_BIST_COLLAR_SI_ts4), 
      .MEM5_BIST_COLLAR_SI(MEM5_BIST_COLLAR_SI_ts4), .MEM6_BIST_COLLAR_SI(MEM6_BIST_COLLAR_SI_ts4), 
      .MEM7_BIST_COLLAR_SI(MEM7_BIST_COLLAR_SI_ts4), .MEM8_BIST_COLLAR_SI(MEM8_BIST_COLLAR_SI_ts3), 
      .MEM9_BIST_COLLAR_SI(MEM9_BIST_COLLAR_SI_ts3), .MEM10_BIST_COLLAR_SI(MEM10_BIST_COLLAR_SI_ts3), 
      .MEM11_BIST_COLLAR_SI(MEM11_BIST_COLLAR_SI_ts3), .MEM12_BIST_COLLAR_SI(MEM12_BIST_COLLAR_SI_ts3), 
      .MEM13_BIST_COLLAR_SI(MEM13_BIST_COLLAR_SI_ts3), .MEM14_BIST_COLLAR_SI(MEM14_BIST_COLLAR_SI_ts3), 
      .MEM15_BIST_COLLAR_SI(MEM15_BIST_COLLAR_SI_ts3), .MEM16_BIST_COLLAR_SI(MEM16_BIST_COLLAR_SI_ts3), 
      .MEM17_BIST_COLLAR_SI(MEM17_BIST_COLLAR_SI_ts3), .MEM18_BIST_COLLAR_SI(MEM18_BIST_COLLAR_SI_ts3), 
      .MEM19_BIST_COLLAR_SI(MEM19_BIST_COLLAR_SI_ts3), .MEM20_BIST_COLLAR_SI(MEM20_BIST_COLLAR_SI_ts2), 
      .MEM21_BIST_COLLAR_SI(MEM21_BIST_COLLAR_SI_ts2), .MEM22_BIST_COLLAR_SI(MEM22_BIST_COLLAR_SI_ts2), 
      .MEM23_BIST_COLLAR_SI(MEM23_BIST_COLLAR_SI_ts2), .MEM24_BIST_COLLAR_SI(MEM24_BIST_COLLAR_SI_ts2), 
      .MEM25_BIST_COLLAR_SI(MEM25_BIST_COLLAR_SI_ts2), .MEM26_BIST_COLLAR_SI(MEM26_BIST_COLLAR_SI_ts2), 
      .MEM27_BIST_COLLAR_SI(MEM27_BIST_COLLAR_SI_ts2), .MEM28_BIST_COLLAR_SI(MEM28_BIST_COLLAR_SI_ts2), 
      .MEM29_BIST_COLLAR_SI(MEM29_BIST_COLLAR_SI_ts2), .MEM30_BIST_COLLAR_SI(MEM30_BIST_COLLAR_SI_ts2), 
      .MEM31_BIST_COLLAR_SI(MEM31_BIST_COLLAR_SI_ts2), .BIST_COLLAR_SETUP(BIST_COLLAR_SETUP_ts9), 
      .BIST_COLLAR_OPSET_SELECT(BIST_COLLAR_OPSET_SELECT_ts9), .BIST_COLLAR_HOLD(BIST_COLLAR_HOLD_ts9), 
      .FREEZE_STOP_ERROR(FREEZE_STOP_ERROR_ts9), .ERROR_CNT_ZERO(ERROR_CNT_ZERO_ts9), 
      .BIST_COLLAR_DIAG_EN(BIST_COLLAR_DIAG_EN_ts9), .BIST_COLLAR_BIRA_EN(BIST_COLLAR_BIRA_EN_ts9), 
      .BIST_CLEAR_DEFAULT(BIST_CLEAR_DEFAULT_ts9), .BIST_CLEAR(BIST_CLEAR_ts9), 
      .MBISTPG_SO(MBISTPG_SO_ts9), .PriorityColumn(PriorityColumn_ts9), .BIST_WRITEENABLE(BIST_WRITEENABLE_ts9), 
      .BIST_SELECT(BIST_SELECT_ts8), .BIST_CMP(BIST_CMP_ts9), .BIST_COLLAR_EN0(BIST_COLLAR_EN0_ts9), 
      .BIST_RUN_TO_COLLAR0(BIST_RUN_TO_COLLAR0_ts9), .BIST_COLLAR_EN1(BIST_COLLAR_EN1_ts7), 
      .BIST_RUN_TO_COLLAR1(BIST_RUN_TO_COLLAR1_ts7), .BIST_COLLAR_EN2(BIST_COLLAR_EN2_ts5), 
      .BIST_RUN_TO_COLLAR2(BIST_RUN_TO_COLLAR2_ts5), .BIST_COLLAR_EN3(BIST_COLLAR_EN3_ts4), 
      .BIST_RUN_TO_COLLAR3(BIST_RUN_TO_COLLAR3_ts4), .BIST_COLLAR_EN4(BIST_COLLAR_EN4_ts4), 
      .BIST_RUN_TO_COLLAR4(BIST_RUN_TO_COLLAR4_ts4), .BIST_COLLAR_EN5(BIST_COLLAR_EN5_ts4), 
      .BIST_RUN_TO_COLLAR5(BIST_RUN_TO_COLLAR5_ts4), .BIST_COLLAR_EN6(BIST_COLLAR_EN6_ts4), 
      .BIST_RUN_TO_COLLAR6(BIST_RUN_TO_COLLAR6_ts4), .BIST_COLLAR_EN7(BIST_COLLAR_EN7_ts4), 
      .BIST_RUN_TO_COLLAR7(BIST_RUN_TO_COLLAR7_ts4), .BIST_COLLAR_EN8(BIST_COLLAR_EN8_ts3), 
      .BIST_RUN_TO_COLLAR8(BIST_RUN_TO_COLLAR8_ts3), .BIST_COLLAR_EN9(BIST_COLLAR_EN9_ts3), 
      .BIST_RUN_TO_COLLAR9(BIST_RUN_TO_COLLAR9_ts3), .BIST_COLLAR_EN10(BIST_COLLAR_EN10_ts3), 
      .BIST_RUN_TO_COLLAR10(BIST_RUN_TO_COLLAR10_ts3), .BIST_COLLAR_EN11(BIST_COLLAR_EN11_ts3), 
      .BIST_RUN_TO_COLLAR11(BIST_RUN_TO_COLLAR11_ts3), .BIST_COLLAR_EN12(BIST_COLLAR_EN12_ts3), 
      .BIST_RUN_TO_COLLAR12(BIST_RUN_TO_COLLAR12_ts3), .BIST_COLLAR_EN13(BIST_COLLAR_EN13_ts3), 
      .BIST_RUN_TO_COLLAR13(BIST_RUN_TO_COLLAR13_ts3), .BIST_COLLAR_EN14(BIST_COLLAR_EN14_ts3), 
      .BIST_RUN_TO_COLLAR14(BIST_RUN_TO_COLLAR14_ts3), .BIST_COLLAR_EN15(BIST_COLLAR_EN15_ts3), 
      .BIST_RUN_TO_COLLAR15(BIST_RUN_TO_COLLAR15_ts3), .BIST_COLLAR_EN16(BIST_COLLAR_EN16_ts3), 
      .BIST_RUN_TO_COLLAR16(BIST_RUN_TO_COLLAR16_ts3), .BIST_COLLAR_EN17(BIST_COLLAR_EN17_ts3), 
      .BIST_RUN_TO_COLLAR17(BIST_RUN_TO_COLLAR17_ts3), .BIST_COLLAR_EN18(BIST_COLLAR_EN18_ts3), 
      .BIST_RUN_TO_COLLAR18(BIST_RUN_TO_COLLAR18_ts3), .BIST_COLLAR_EN19(BIST_COLLAR_EN19_ts3), 
      .BIST_RUN_TO_COLLAR19(BIST_RUN_TO_COLLAR19_ts3), .BIST_COLLAR_EN20(BIST_COLLAR_EN20_ts2), 
      .BIST_RUN_TO_COLLAR20(BIST_RUN_TO_COLLAR20_ts2), .BIST_COLLAR_EN21(BIST_COLLAR_EN21_ts2), 
      .BIST_RUN_TO_COLLAR21(BIST_RUN_TO_COLLAR21_ts2), .BIST_COLLAR_EN22(BIST_COLLAR_EN22_ts2), 
      .BIST_RUN_TO_COLLAR22(BIST_RUN_TO_COLLAR22_ts2), .BIST_COLLAR_EN23(BIST_COLLAR_EN23_ts2), 
      .BIST_RUN_TO_COLLAR23(BIST_RUN_TO_COLLAR23_ts2), .BIST_COLLAR_EN24(BIST_COLLAR_EN24_ts2), 
      .BIST_RUN_TO_COLLAR24(BIST_RUN_TO_COLLAR24_ts2), .BIST_COLLAR_EN25(BIST_COLLAR_EN25_ts2), 
      .BIST_RUN_TO_COLLAR25(BIST_RUN_TO_COLLAR25_ts2), .BIST_COLLAR_EN26(BIST_COLLAR_EN26_ts2), 
      .BIST_RUN_TO_COLLAR26(BIST_RUN_TO_COLLAR26_ts2), .BIST_COLLAR_EN27(BIST_COLLAR_EN27_ts2), 
      .BIST_RUN_TO_COLLAR27(BIST_RUN_TO_COLLAR27_ts2), .BIST_COLLAR_EN28(BIST_COLLAR_EN28_ts2), 
      .BIST_RUN_TO_COLLAR28(BIST_RUN_TO_COLLAR28_ts2), .BIST_COLLAR_EN29(BIST_COLLAR_EN29_ts2), 
      .BIST_RUN_TO_COLLAR29(BIST_RUN_TO_COLLAR29_ts2), .BIST_COLLAR_EN30(BIST_COLLAR_EN30_ts2), 
      .BIST_RUN_TO_COLLAR30(BIST_RUN_TO_COLLAR30_ts2), .BIST_COLLAR_EN31(BIST_COLLAR_EN31_ts2), 
      .BIST_RUN_TO_COLLAR31(BIST_RUN_TO_COLLAR31_ts2), .MBISTPG_GO(MBISTPG_GO_ts9), 
      .MBISTPG_STABLE(MBISTPG_STABLE_ts8), .MBISTPG_DONE(MBISTPG_DONE_ts9), .BIST_ON_TO_COLLAR(BIST_ON_TO_COLLAR_ts9), 
      .BIST_SHIFT_BIRA_COLLAR(BIST_SHIFT_BIRA_COLLAR_ts9), .GO_ID_REG_SEL(GO_ID_REG_SEL_ts8), 
      .ALGO_SEL_REG(ALGO_SEL_REG_ts9), .fscan_clkungate(fscan_clkungate)
  );

  hlp_fwd_apr_rtl_tessent_mbist_SRAM_c10_controller hlp_fwd_apr_rtl_tessent_mbist_SRAM_c10_controller_inst(
      .MBIST_RA_PRSRV_FUSE_VAL(PRESERVE_FUSE_REGISTER), .MBISTPG_ALGO_SEL({
      BIST_ALGO_SEL_ts6, BIST_ALGO_SEL_ts5, BIST_ALGO_SEL_ts4, 
      BIST_ALGO_SEL_ts3, BIST_ALGO_SEL_ts2, BIST_ALGO_SEL_ts1, BIST_ALGO_SEL}), .MBISTPG_SELECT_COMMON_ALGO(BIST_SELECT_COMMON_ALGO), 
      .MBISTPG_OPSET_SELECT(BIST_OPSET_SEL), .MBISTPG_SELECT_COMMON_OPSET(BIST_SELECT_COMMON_OPSET), 
      .MBISTPG_DATA_INV_ROW_ADD_BIT_SELECT_EN(BIST_DATA_INV_ROW_ADD_BIT_SELECT_EN), 
      .MBISTPG_DATA_INV_ROW_ADD_BIT_SELECT(BIST_DATA_INV_ROW_ADD_BIT_SEL), .MBISTPG_DATA_INV_COL_ADD_BIT_SELECT_EN(BIST_DATA_INV_COL_ADD_BIT_SELECT_EN), 
      .MBISTPG_DATA_INV_COL_ADD_BIT_SELECT(BIST_DATA_INV_COL_ADD_BIT_SEL), .MBISTPG_ALGO_MODE({
      BIST_ALGO_MODE1, BIST_ALGO_MODE0}), .MBISTPG_MEM_RST(ENABLE_MEM_RESET), .MBISTPG_REDUCED_ADDR_CNT_EN(REDUCED_ADDRESS_COUNT), 
      .MEM_BYPASS_EN(memory_bypass_to_en), .MCP_BOUNDING_EN(mcp_bounding_to_en), 
      .MEM0_BIST_COLLAR_SO(BIST_SO_ts20), .MEM1_BIST_COLLAR_SO(BIST_SO_ts21), .MEM2_BIST_COLLAR_SO(BIST_SO_ts36), 
      .MEM3_BIST_COLLAR_SO(BIST_SO_ts37), .MEM4_BIST_COLLAR_SO(BIST_SO_ts54), .MEM5_BIST_COLLAR_SO(BIST_SO_ts55), 
      .MEM6_BIST_COLLAR_SO(BIST_SO_ts67), .MEM7_BIST_COLLAR_SO(BIST_SO_ts68), .MEM8_BIST_COLLAR_SO(BIST_SO_ts79), 
      .MEM9_BIST_COLLAR_SO(BIST_SO_ts80), .MEM10_BIST_COLLAR_SO(BIST_SO_ts81), 
      .MEM11_BIST_COLLAR_SO(BIST_SO_ts92), .MEM12_BIST_COLLAR_SO(BIST_SO_ts93), 
      .MEM13_BIST_COLLAR_SO(BIST_SO_ts94), .MEM14_BIST_COLLAR_SO(BIST_SO_ts105), 
      .MEM15_BIST_COLLAR_SO(BIST_SO_ts106), .MEM16_BIST_COLLAR_SO(BIST_SO_ts107), 
      .MEM17_BIST_COLLAR_SO(BIST_SO_ts118), .MEM18_BIST_COLLAR_SO(BIST_SO_ts119), 
      .MEM19_BIST_COLLAR_SO(BIST_SO_ts120), .FL_CNT_MODE({FL_CNT_MODE1, 
      FL_CNT_MODE0}), .MBISTPG_BIRA_EN(BIRA_EN), .CHECK_REPAIR_NEEDED(CHECK_REPAIR_NEEDED), 
      .BIST_COLLAR_GO({BIST_GO_ts120, BIST_GO_ts107, BIST_GO_ts94, 
      BIST_GO_ts81, BIST_GO_ts68, BIST_GO_ts55, BIST_GO_ts37, BIST_GO_ts21, 
      BIST_GO_ts119, BIST_GO_ts106, BIST_GO_ts93, BIST_GO_ts80, BIST_GO_ts67, 
      BIST_GO_ts54, BIST_GO_ts36, BIST_GO_ts20, BIST_GO_ts118, BIST_GO_ts105, 
      BIST_GO_ts92, BIST_GO_ts79}), .MBISTPG_DIAG_EN(BIST_DIAG_EN), .BIST_CLK(clk_ts1), 
      .BIST_SI(toBist[9]), .BIST_HOLD(BIST_HOLD), .BIST_SETUP2(BIST_SETUP_ts3), 
      .BIST_SETUP({BIST_SETUP_ts2, BIST_SETUP_ts1}), .MBISTPG_TESTDATA_SELECT(BIST_SELECT_TEST_DATA), 
      .TCK(to_controllers_tck), .TCK_RETIME(to_controllers_tck_retime), .MBISTPG_EN(bistEn[9]), 
      .MBISTPG_ASYNC_RESETN(BIST_ASYNC_RESET), .LV_TM(ltest_to_en_ts1), .MBISTPG_MEM_ARRAY_DUMP_MODE(MEM_ARRAY_DUMP_MODE), 
      .BIST_CLEAR_BIRA(BIST_CLEAR_BIRA_ts1), .MBISTPG_RESET_REG_SETUP2(MBISTPG_RESET_REG_SETUP2_ts1), 
      .BIST_COL_ADD(BIST_COL_ADD_ts1[1:0]), .BIST_ROW_ADD(BIST_ROW_ADD_ts1[7:0]), 
      .BIST_BANK_ADD(BIST_BANK_ADD_ts1), .BIST_WRITE_DATA(BIST_WRITE_DATA_ts1[31:0]), 
      .BIST_EXPECT_DATA(BIST_EXPECT_DATA_ts1[31:0]), .BIST_SHIFT_COLLAR(BIST_SHIFT_COLLAR_ts1), 
      .BIST_TESTDATA_SELECT_TO_COLLAR(BIST_TESTDATA_SELECT_TO_COLLAR_ts1), .MEM0_BIST_COLLAR_SI(MEM0_BIST_COLLAR_SI_ts1), 
      .MEM1_BIST_COLLAR_SI(MEM1_BIST_COLLAR_SI), .MEM2_BIST_COLLAR_SI(MEM2_BIST_COLLAR_SI), 
      .MEM3_BIST_COLLAR_SI(MEM3_BIST_COLLAR_SI), .MEM4_BIST_COLLAR_SI(MEM4_BIST_COLLAR_SI), 
      .MEM5_BIST_COLLAR_SI(MEM5_BIST_COLLAR_SI), .MEM6_BIST_COLLAR_SI(MEM6_BIST_COLLAR_SI), 
      .MEM7_BIST_COLLAR_SI(MEM7_BIST_COLLAR_SI), .MEM8_BIST_COLLAR_SI(MEM8_BIST_COLLAR_SI), 
      .MEM9_BIST_COLLAR_SI(MEM9_BIST_COLLAR_SI), .MEM10_BIST_COLLAR_SI(MEM10_BIST_COLLAR_SI), 
      .MEM11_BIST_COLLAR_SI(MEM11_BIST_COLLAR_SI), .MEM12_BIST_COLLAR_SI(MEM12_BIST_COLLAR_SI), 
      .MEM13_BIST_COLLAR_SI(MEM13_BIST_COLLAR_SI), .MEM14_BIST_COLLAR_SI(MEM14_BIST_COLLAR_SI), 
      .MEM15_BIST_COLLAR_SI(MEM15_BIST_COLLAR_SI), .MEM16_BIST_COLLAR_SI(MEM16_BIST_COLLAR_SI), 
      .MEM17_BIST_COLLAR_SI(MEM17_BIST_COLLAR_SI), .MEM18_BIST_COLLAR_SI(MEM18_BIST_COLLAR_SI), 
      .MEM19_BIST_COLLAR_SI(MEM19_BIST_COLLAR_SI), .BIST_COLLAR_SETUP(BIST_COLLAR_SETUP_ts1), 
      .BIST_COLLAR_OPSET_SELECT(BIST_COLLAR_OPSET_SELECT_ts1), .BIST_COLLAR_HOLD(BIST_COLLAR_HOLD_ts1), 
      .FREEZE_STOP_ERROR(FREEZE_STOP_ERROR_ts1), .ERROR_CNT_ZERO(ERROR_CNT_ZERO_ts1), 
      .BIST_COLLAR_DIAG_EN(BIST_COLLAR_DIAG_EN_ts1), .BIST_COLLAR_BIRA_EN(BIST_COLLAR_BIRA_EN_ts1), 
      .BIST_CLEAR_DEFAULT(BIST_CLEAR_DEFAULT_ts1), .BIST_CLEAR(BIST_CLEAR_ts1), 
      .MBISTPG_SO(MBISTPG_SO_ts1), .PriorityColumn(PriorityColumn_ts1), .BIST_WRITEENABLE(BIST_WRITEENABLE_ts1), 
      .BIST_SELECT(BIST_SELECT), .BIST_CMP(BIST_CMP_ts1), .BIST_COLLAR_EN0(BIST_COLLAR_EN0_ts1), 
      .BIST_RUN_TO_COLLAR0(BIST_RUN_TO_COLLAR0_ts1), .BIST_COLLAR_EN1(BIST_COLLAR_EN1), 
      .BIST_RUN_TO_COLLAR1(BIST_RUN_TO_COLLAR1), .BIST_COLLAR_EN2(BIST_COLLAR_EN2), 
      .BIST_RUN_TO_COLLAR2(BIST_RUN_TO_COLLAR2), .BIST_COLLAR_EN3(BIST_COLLAR_EN3), 
      .BIST_RUN_TO_COLLAR3(BIST_RUN_TO_COLLAR3), .BIST_COLLAR_EN4(BIST_COLLAR_EN4), 
      .BIST_RUN_TO_COLLAR4(BIST_RUN_TO_COLLAR4), .BIST_COLLAR_EN5(BIST_COLLAR_EN5), 
      .BIST_RUN_TO_COLLAR5(BIST_RUN_TO_COLLAR5), .BIST_COLLAR_EN6(BIST_COLLAR_EN6), 
      .BIST_RUN_TO_COLLAR6(BIST_RUN_TO_COLLAR6), .BIST_COLLAR_EN7(BIST_COLLAR_EN7), 
      .BIST_RUN_TO_COLLAR7(BIST_RUN_TO_COLLAR7), .BIST_COLLAR_EN8(BIST_COLLAR_EN8), 
      .BIST_RUN_TO_COLLAR8(BIST_RUN_TO_COLLAR8), .BIST_COLLAR_EN9(BIST_COLLAR_EN9), 
      .BIST_RUN_TO_COLLAR9(BIST_RUN_TO_COLLAR9), .BIST_COLLAR_EN10(BIST_COLLAR_EN10), 
      .BIST_RUN_TO_COLLAR10(BIST_RUN_TO_COLLAR10), .BIST_COLLAR_EN11(BIST_COLLAR_EN11), 
      .BIST_RUN_TO_COLLAR11(BIST_RUN_TO_COLLAR11), .BIST_COLLAR_EN12(BIST_COLLAR_EN12), 
      .BIST_RUN_TO_COLLAR12(BIST_RUN_TO_COLLAR12), .BIST_COLLAR_EN13(BIST_COLLAR_EN13), 
      .BIST_RUN_TO_COLLAR13(BIST_RUN_TO_COLLAR13), .BIST_COLLAR_EN14(BIST_COLLAR_EN14), 
      .BIST_RUN_TO_COLLAR14(BIST_RUN_TO_COLLAR14), .BIST_COLLAR_EN15(BIST_COLLAR_EN15), 
      .BIST_RUN_TO_COLLAR15(BIST_RUN_TO_COLLAR15), .BIST_COLLAR_EN16(BIST_COLLAR_EN16), 
      .BIST_RUN_TO_COLLAR16(BIST_RUN_TO_COLLAR16), .BIST_COLLAR_EN17(BIST_COLLAR_EN17), 
      .BIST_RUN_TO_COLLAR17(BIST_RUN_TO_COLLAR17), .BIST_COLLAR_EN18(BIST_COLLAR_EN18), 
      .BIST_RUN_TO_COLLAR18(BIST_RUN_TO_COLLAR18), .BIST_COLLAR_EN19(BIST_COLLAR_EN19), 
      .BIST_RUN_TO_COLLAR19(BIST_RUN_TO_COLLAR19), .MBISTPG_GO(MBISTPG_GO_ts1), 
      .MBISTPG_STABLE(MBISTPG_STABLE_ts9), .MBISTPG_DONE(MBISTPG_DONE_ts1), .BIST_ON_TO_COLLAR(BIST_ON_TO_COLLAR_ts1), 
      .BIST_SHIFT_BIRA_COLLAR(BIST_SHIFT_BIRA_COLLAR_ts1), .GO_ID_REG_SEL(GO_ID_REG_SEL_ts9), 
      .ALGO_SEL_REG(ALGO_SEL_REG_ts1), .fscan_clkungate(fscan_clkungate)
  );

  hlp_fwd_apr_rtl_tessent_mbist_TCAM_c11_controller hlp_fwd_apr_rtl_tessent_mbist_TCAM_c11_controller_inst(
      .MBIST_RA_PRSRV_FUSE_VAL(PRESERVE_FUSE_REGISTER), .MBISTPG_ALGO_SEL({
      BIST_ALGO_SEL_ts6, BIST_ALGO_SEL_ts5, BIST_ALGO_SEL_ts4, 
      BIST_ALGO_SEL_ts3, BIST_ALGO_SEL_ts2, BIST_ALGO_SEL_ts1, BIST_ALGO_SEL}), .MBISTPG_SELECT_COMMON_ALGO(BIST_SELECT_COMMON_ALGO), 
      .MBISTPG_OPSET_SELECT({BIST_OPSET_SEL_ts1, BIST_OPSET_SEL}), .MBISTPG_SELECT_COMMON_OPSET(BIST_SELECT_COMMON_OPSET), 
      .MBISTPG_DATA_INV_ROW_ADD_BIT_SELECT_EN(BIST_DATA_INV_ROW_ADD_BIT_SELECT_EN), 
      .MBISTPG_DATA_INV_ROW_ADD_BIT_SELECT(BIST_DATA_INV_ROW_ADD_BIT_SEL), .MBISTPG_DATA_INV_COL_ADD_BIT_SELECT_EN(BIST_DATA_INV_COL_ADD_BIT_SELECT_EN), 
      .MBISTPG_DATA_INV_COL_ADD_BIT_SELECT(BIST_DATA_INV_COL_ADD_BIT_SEL), .MBISTPG_ALGO_MODE({
      BIST_ALGO_MODE1, BIST_ALGO_MODE0}), .MBISTPG_MEM_RST(ENABLE_MEM_RESET), .MBISTPG_REDUCED_ADDR_CNT_EN(REDUCED_ADDRESS_COUNT), 
      .MEM_BYPASS_EN(memory_bypass_to_en), .MCP_BOUNDING_EN(mcp_bounding_to_en), 
      .MEM0_BIST_COLLAR_SO(BIST_SO_ts133), .MEM1_BIST_COLLAR_SO(BIST_SO_ts134), 
      .MEM2_BIST_COLLAR_SO(BIST_SO_ts135), .MEM3_BIST_COLLAR_SO(BIST_SO_ts136), 
      .MEM4_BIST_COLLAR_SO(BIST_SO_ts137), .MEM5_BIST_COLLAR_SO(BIST_SO_ts138), 
      .MEM6_BIST_COLLAR_SO(BIST_SO_ts139), .MEM7_BIST_COLLAR_SO(BIST_SO_ts140), 
      .FL_CNT_MODE({FL_CNT_MODE1, FL_CNT_MODE0}), .MBISTPG_BIRA_EN(BIRA_EN), .CHECK_REPAIR_NEEDED(CHECK_REPAIR_NEEDED), 
      .BIST_COLLAR_GO({BIST_GO_ts140, BIST_GO_ts136, BIST_GO_ts139, 
      BIST_GO_ts135, BIST_GO_ts138, BIST_GO_ts134, BIST_GO_ts137, 
      BIST_GO_ts133}), .MBISTPG_DIAG_EN(BIST_DIAG_EN), .BIST_CLK(clk_ts1), .BIST_SI(toBist[10]), 
      .BIST_HOLD(BIST_HOLD), .BIST_SETUP2(BIST_SETUP_ts3), .BIST_SETUP({
      BIST_SETUP_ts2, BIST_SETUP_ts1}), .MBISTPG_TESTDATA_SELECT(BIST_SELECT_TEST_DATA), 
      .TCK(to_controllers_tck), .TCK_RETIME(to_controllers_tck_retime), .MBISTPG_EN(bistEn[10]), 
      .MBISTPG_ASYNC_RESETN(BIST_ASYNC_RESET), .LV_TM(ltest_to_en_ts1), .MBISTPG_MEM_ARRAY_DUMP_MODE(MEM_ARRAY_DUMP_MODE), 
      .BIST_CLEAR_BIRA(BIST_CLEAR_BIRA_ts10), .MBISTPG_RESET_REG_SETUP2(MBISTPG_RESET_REG_SETUP2_ts10), 
      .BIST_COL_ADD(BIST_COL_ADD_ts10), .BIST_ROW_ADD(BIST_ROW_ADD_ts10[5:0]), 
      .BIST_BANK_ADD(BIST_BANK_ADD_ts7[2:0]), .BIST_WRITE_DATA(BIST_WRITE_DATA_ts10[31:0]), 
      .BIST_EXPECT_DATA(BIST_EXPECT_DATA_ts10[31:0]), .BIST_SHIFT_COLLAR(BIST_SHIFT_COLLAR_ts10), 
      .BIST_TESTDATA_SELECT_TO_COLLAR(BIST_TESTDATA_SELECT_TO_COLLAR_ts10), .MEM0_BIST_COLLAR_SI(MEM0_BIST_COLLAR_SI_ts10), 
      .MEM1_BIST_COLLAR_SI(MEM1_BIST_COLLAR_SI_ts8), .MEM2_BIST_COLLAR_SI(MEM2_BIST_COLLAR_SI_ts6), 
      .MEM3_BIST_COLLAR_SI(MEM3_BIST_COLLAR_SI_ts5), .MEM4_BIST_COLLAR_SI(MEM4_BIST_COLLAR_SI_ts5), 
      .MEM5_BIST_COLLAR_SI(MEM5_BIST_COLLAR_SI_ts5), .MEM6_BIST_COLLAR_SI(MEM6_BIST_COLLAR_SI_ts5), 
      .MEM7_BIST_COLLAR_SI(MEM7_BIST_COLLAR_SI_ts5), .BIST_COLLAR_SETUP(BIST_COLLAR_SETUP_ts10), 
      .BIST_COLLAR_OPSET_SELECT(BIST_COLLAR_OPSET_SELECT_ts10[1:0]), .BIST_COLLAR_HOLD(BIST_COLLAR_HOLD_ts10), 
      .FREEZE_STOP_ERROR(FREEZE_STOP_ERROR_ts10), .ERROR_CNT_ZERO(ERROR_CNT_ZERO_ts10), 
      .BIST_COLLAR_DIAG_EN(BIST_COLLAR_DIAG_EN_ts10), .BIST_COLLAR_BIRA_EN(BIST_COLLAR_BIRA_EN_ts10), 
      .BIST_CLEAR_DEFAULT(BIST_CLEAR_DEFAULT_ts10), .BIST_CLEAR(BIST_CLEAR_ts10), 
      .MBISTPG_SO(MBISTPG_SO_ts10), .BIST_USER9(BIST_USER9), .BIST_USER10(BIST_USER10), 
      .BIST_USER11(BIST_USER11), .BIST_USER0(BIST_USER0), .BIST_USER1(BIST_USER1), 
      .BIST_USER2(BIST_USER2), .BIST_USER3(BIST_USER3), .BIST_USER4(BIST_USER4), 
      .BIST_USER5(BIST_USER5), .BIST_USER6(BIST_USER6), .BIST_USER7(BIST_USER7), 
      .BIST_USER8(BIST_USER8), .BIST_EVEN_GROUPWRITEENABLE(BIST_EVEN_GROUPWRITEENABLE), 
      .BIST_ODD_GROUPWRITEENABLE(BIST_ODD_GROUPWRITEENABLE), .BIST_WRITEENABLE(BIST_WRITEENABLE_ts10), 
      .BIST_READENABLE(BIST_READENABLE_ts1), .BIST_SELECT(BIST_SELECT_ts9), .BIST_CMP(BIST_CMP_ts10), 
      .BIST_COLLAR_EN0(BIST_COLLAR_EN0_ts10), .BIST_RUN_TO_COLLAR0(BIST_RUN_TO_COLLAR0_ts10), 
      .BIST_COLLAR_EN1(BIST_COLLAR_EN1_ts8), .BIST_RUN_TO_COLLAR1(BIST_RUN_TO_COLLAR1_ts8), 
      .BIST_COLLAR_EN2(BIST_COLLAR_EN2_ts6), .BIST_RUN_TO_COLLAR2(BIST_RUN_TO_COLLAR2_ts6), 
      .BIST_COLLAR_EN3(BIST_COLLAR_EN3_ts5), .BIST_RUN_TO_COLLAR3(BIST_RUN_TO_COLLAR3_ts5), 
      .BIST_COLLAR_EN4(BIST_COLLAR_EN4_ts5), .BIST_RUN_TO_COLLAR4(BIST_RUN_TO_COLLAR4_ts5), 
      .BIST_COLLAR_EN5(BIST_COLLAR_EN5_ts5), .BIST_RUN_TO_COLLAR5(BIST_RUN_TO_COLLAR5_ts5), 
      .BIST_COLLAR_EN6(BIST_COLLAR_EN6_ts5), .BIST_RUN_TO_COLLAR6(BIST_RUN_TO_COLLAR6_ts5), 
      .BIST_COLLAR_EN7(BIST_COLLAR_EN7_ts5), .BIST_RUN_TO_COLLAR7(BIST_RUN_TO_COLLAR7_ts5), 
      .MBISTPG_GO(MBISTPG_GO_ts10), .MBISTPG_STABLE(MBISTPG_STABLE_ts10), .MBISTPG_DONE(MBISTPG_DONE_ts10), 
      .BIST_ON_TO_COLLAR(BIST_ON_TO_COLLAR_ts10), .BIST_SHIFT_BIRA_COLLAR(BIST_SHIFT_BIRA_COLLAR_ts10), 
      .GO_ID_REG_SEL(GO_ID_REG_SEL_ts10), .ALGO_SEL_REG(ALGO_SEL_REG_ts10), .fscan_clkungate(fscan_clkungate)
  );

  assign BIST_SETUP_ts1 = BIST_SETUP[0];

  assign BIST_SETUP_ts2 = BIST_SETUP[1];

  assign BIST_SETUP_ts3 = BIST_SETUP[2];

  TS_CLK_MUX tessent_persistent_cell_tck_mux_hlp_fwd_apr_rtl_clk_inst(
      .ck0(clk), .ck1(ijtag_to_tck), .s(tck_select), .o(clk_ts1)
  );

  hlp_fwd_apr_rtl_tessent_mbist_diagnosis_ready hlp_fwd_apr_rtl_tessent_mbist_diagnosis_ready_inst(
      .ijtag_reset(ijtag_to_reset), .ijtag_sel(ijtag_to_sel), .ijtag_si(hlp_fwd_apr_rtl_tessent_mbist_bap_inst_so), 
      .ijtag_ce(ijtag_to_ce), .ijtag_se(ijtag_to_se), .ijtag_ue(ijtag_to_ue), .ijtag_tck(ijtag_to_tck), 
      .ijtag_so(ijtag_so), .DiagnosisReady_ctl_in({MBISTPG_STABLE_ts10, 
      MBISTPG_STABLE_ts9, MBISTPG_STABLE_ts8, MBISTPG_STABLE_ts7, 
      MBISTPG_STABLE_ts6, MBISTPG_STABLE_ts5, MBISTPG_STABLE_ts4, 
      MBISTPG_STABLE_ts3, MBISTPG_STABLE_ts2, MBISTPG_STABLE_ts1, 
      MBISTPG_STABLE}), .DiagnosisReady_aux_in(1'b1), .StableBlock(mbist_diag_done)
  );

  assign bisr_so_pd_vinf_ts1 = bisr_si_pd_vinf;

  mbist_post_agg #(.NUM_OF_CNTRL(1)) post_aggregator(
      .post_complete(complete), .post_pass(pass), .post_busy(busy), .post_complete_agg(aary_post_complete), 
      .post_pass_agg(aary_post_pass), .post_busy_agg(aary_post_busy)
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
endmodule