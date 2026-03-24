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

`include "hlp_msec_mem.def"

module hlp_msec_apr
(
output logic fet_ack_b,
input logic fet_en_b,
input logic powergood_rst_n,
input logic mem_rst_n,
input logic i_msec_disable,
input logic fary_trigger_post_rf,
input logic fary_post_pass_rf,
output logic aary_post_complete_rf,
output logic aary_post_pass_rf,
// TAP Overrides
input  logic fdfx_jta_force_latch_mem_fuses,
/*AUTOINPUT*/
input clk_rscclk,
output mbist_diag_done,
input mbist_mode,
input hlp_post_mux_ctrl,
input hlp_post_clkungate,
// Beginning of automatic inputs (from unused autoinst inputs)
input logic             DFTMASK,                // To u_msec_apr_rf_mems of hlp_msec_apr_rf_mems.v
input logic             DFTSHIFTEN,             // To u_msec_apr_rf_mems of hlp_msec_apr_rf_mems.v
input logic             DFT_AFD_RESET_B,        // To u_msec_apr_rf_mems of hlp_msec_apr_rf_mems.v
input logic             DFT_ARRAY_FREEZE,       // To u_msec_apr_rf_mems of hlp_msec_apr_rf_mems.v
input logic             clk,                    // To u_msec_apr_func_logic of hlp_msec_apr_func_logic.v
input logic [6:0]       fary_ffuse_hd2prf_trim, // To u_msec_apr_rf_mems of hlp_msec_apr_rf_mems.v
input logic [1:0]       fary_ffuse_rf_sleep,    // To u_msec_apr_rf_mems of hlp_msec_apr_rf_mems.v
input logic             fary_output_reset,      // To u_msec_apr_rf_mems of hlp_msec_apr_rf_mems.v
input logic             fscan_byprst_b,         // To u_msec_apr_func_logic of hlp_msec_apr_func_logic.v
input logic [hlp_dfx_pkg::MSEC_NUM_CLKGENCTRL-1:0] fscan_clkgenctrl,// To u_msec_apr_func_logic of hlp_msec_apr_func_logic.v
input logic [hlp_dfx_pkg::MSEC_NUM_CLKGENCTRLEN-1:0] fscan_clkgenctrlen,// To u_msec_apr_func_logic of hlp_msec_apr_func_logic.v
input logic             fscan_clkungate,        // To u_msec_apr_rf_mems of hlp_msec_apr_rf_mems.v, ...
input logic             fscan_clkungate_syn,    // To u_msec_apr_func_logic of hlp_msec_apr_func_logic.v
input logic             fscan_latchclosed_b,    // To u_msec_apr_func_logic of hlp_msec_apr_func_logic.v
input logic             fscan_latchopen,        // To u_msec_apr_func_logic of hlp_msec_apr_func_logic.v
input logic             fscan_mode,             // To u_msec_apr_func_logic of hlp_msec_apr_func_logic.v
input logic             fscan_mode_atspeed,     // To u_msec_apr_func_logic of hlp_msec_apr_func_logic.v
input logic             fscan_postclk_div4_clk, // To u_msec_apr_func_logic of hlp_msec_apr_func_logic.v
input logic             fscan_ram_bypsel_rf,    // To u_msec_apr_rf_mems of hlp_msec_apr_rf_mems.v
input logic             fscan_ram_init_en,      // To u_msec_apr_rf_mems of hlp_msec_apr_rf_mems.v
input logic             fscan_ram_init_val,     // To u_msec_apr_rf_mems of hlp_msec_apr_rf_mems.v
input logic             fscan_ram_rdis_b,       // To u_msec_apr_rf_mems of hlp_msec_apr_rf_mems.v
input logic             fscan_ram_wdis_b,       // To u_msec_apr_rf_mems of hlp_msec_apr_rf_mems.v
input logic             fscan_ret_ctrl,         // To u_msec_apr_func_logic of hlp_msec_apr_func_logic.v
input logic             fscan_rstbypen,         // To u_msec_apr_func_logic of hlp_msec_apr_func_logic.v
input logic [hlp_dfx_pkg::MSEC_NUM_SDI-1:0] fscan_sdi,// To u_msec_apr_func_logic of hlp_msec_apr_func_logic.v
input logic             fscan_shiften,          // To u_msec_apr_func_logic of hlp_msec_apr_func_logic.v
input logic             fsta_dfxact_afd,        // To u_msec_apr_rf_mems of hlp_msec_apr_rf_mems.v
input logic             fvisa_all_dis,          // To u_msec_apr_func_logic of hlp_msec_apr_func_logic.v
input logic [hlp_dfx_pkg::NUM_VISA_LANES-1:0] fvisa_clk,// To u_msec_apr_func_logic of hlp_msec_apr_func_logic.v
input logic             fvisa_customer_dis,     // To u_msec_apr_func_logic of hlp_msec_apr_func_logic.v
input logic [hlp_dfx_pkg::VISA_DBG_LANE_WIDTH-1:0] fvisa_dbg_lane,// To u_msec_apr_func_logic of hlp_msec_apr_func_logic.v
input logic             fvisa_frame,            // To u_msec_apr_func_logic of hlp_msec_apr_func_logic.v
input logic             fvisa_rddata,           // To u_msec_apr_func_logic of hlp_msec_apr_func_logic.v
input logic             fvisa_resetb,           // To u_msec_apr_func_logic of hlp_msec_apr_func_logic.v
input logic             fvisa_serdata,          // To u_msec_apr_func_logic of hlp_msec_apr_func_logic.v
input logic             fvisa_serstb,           // To u_msec_apr_func_logic of hlp_msec_apr_func_logic.v
input logic [8:0]       fvisa_unit_id,          // To u_msec_apr_func_logic of hlp_msec_apr_func_logic.v
input logic             i_force_clk_en,         // To u_msec_apr_func_logic of hlp_msec_apr_func_logic.v
input logic [3:0]       i_id,                   // To u_msec_apr_func_logic of hlp_msec_apr_func_logic.v
input logic [$bits(hlp_pkg::msec_mac_rx_t)-1:0] i_msec_mac_rx,     // To u_msec_apr_func_logic of hlp_msec_apr_func_logic.v
input logic             i_msec_mac_rx_v,        // To u_msec_apr_func_logic of hlp_msec_apr_func_logic.v
input logic             i_msec_mac_tx_e,        // To u_msec_apr_func_logic of hlp_msec_apr_func_logic.v
input logic             i_msec_switch_rx_e,     // To u_msec_apr_func_logic of hlp_msec_apr_func_logic.v
input logic [$bits(hlp_pkg::msec_switch_tx_t)-1:0] i_msec_switch_tx,// To u_msec_apr_func_logic of hlp_msec_apr_func_logic.v
input logic             i_msec_switch_tx_v,     // To u_msec_apr_func_logic of hlp_msec_apr_func_logic.v
input logic             i_msec_zeroize,         // To u_msec_apr_func_logic of hlp_msec_apr_func_logic.v
input logic [$bits(hlp_pkg::imn_rpl_bkwd_t)-1:0] i_rpl_bkwd,       // To u_msec_apr_func_logic of hlp_msec_apr_func_logic.v
input logic [$bits(hlp_pkg::imn_rpl_frwd_t)-1:0] i_rpl_frwd,       // To u_msec_apr_func_logic of hlp_msec_apr_func_logic.v
input logic             isol_en_b,              // To u_msec_apr_rf_mems of hlp_msec_apr_rf_mems.v, ...
input logic             ports_clk_free,         // To u_msec_apr_func_logic of hlp_msec_apr_func_logic.v
input logic [4:0]       pwr_mgmt_in_rf,         // To u_msec_apr_rf_mems of hlp_msec_apr_rf_mems.v
input logic             rst_n,                  // To u_msec_apr_func_logic of hlp_msec_apr_func_logic.v
// End of automatics
/*AUTOOUTPUT*/
// Beginning of automatic outputs (from unused autoinst outputs)
output logic            ascan_preclk_div4_clk,  // From u_msec_apr_func_logic of hlp_msec_apr_func_logic.v
output logic [hlp_dfx_pkg::MSEC_NUM_SDO-1:0] ascan_sdo,// From u_msec_apr_func_logic of hlp_msec_apr_func_logic.v
output logic            avisa_all_dis,          // From u_msec_apr_func_logic of hlp_msec_apr_func_logic.v
output logic [hlp_dfx_pkg::NUM_VISA_LANES-1:0] avisa_clk,// From u_msec_apr_func_logic of hlp_msec_apr_func_logic.v
output logic            avisa_customer_dis,     // From u_msec_apr_func_logic of hlp_msec_apr_func_logic.v
output logic [hlp_dfx_pkg::VISA_DBG_LANE_WIDTH-1:0] avisa_dbg_lane,// From u_msec_apr_func_logic of hlp_msec_apr_func_logic.v
output logic            avisa_frame,            // From u_msec_apr_func_logic of hlp_msec_apr_func_logic.v
output logic            avisa_rddata,           // From u_msec_apr_func_logic of hlp_msec_apr_func_logic.v
output logic            avisa_serdata,          // From u_msec_apr_func_logic of hlp_msec_apr_func_logic.v
output logic            avisa_serstb,           // From u_msec_apr_func_logic of hlp_msec_apr_func_logic.v
output logic            isol_ack_b,             // From u_msec_apr_func_logic of hlp_msec_apr_func_logic.v
output logic            o_msec_mac_rx_e,        // From u_msec_apr_func_logic of hlp_msec_apr_func_logic.v
output logic [$bits(hlp_pkg::msec_mac_tx_t)-1:0] o_msec_mac_tx,    // From u_msec_apr_func_logic of hlp_msec_apr_func_logic.v
output logic            o_msec_mac_tx_v,        // From u_msec_apr_func_logic of hlp_msec_apr_func_logic.v
output logic [$bits(hlp_pkg::msec_switch_rx_t)-1:0] o_msec_switch_rx,// From u_msec_apr_func_logic of hlp_msec_apr_func_logic.v
output logic            o_msec_switch_rx_v,     // From u_msec_apr_func_logic of hlp_msec_apr_func_logic.v
output logic            o_msec_switch_tx_e,     // From u_msec_apr_func_logic of hlp_msec_apr_func_logic.v
output logic            o_msec_zeroize_done,    // From u_msec_apr_func_logic of hlp_msec_apr_func_logic.v
output logic [$bits(hlp_pkg::imn_rpl_bkwd_t)-1:0] o_rpl_bkwd,      // From u_msec_apr_func_logic of hlp_msec_apr_func_logic.v
output logic [$bits(hlp_pkg::imn_rpl_frwd_t)-1:0] o_rpl_frwd      // From u_msec_apr_func_logic of hlp_msec_apr_func_logic.v
// End of automatics
, input wire fary_ijtag_tck, input wire fary_ijtag_rst_b, 
input wire fary_ijtag_capture, input wire fary_ijtag_shift, 
input wire fary_ijtag_update, input wire fary_ijtag_select, 
input wire fary_ijtag_si, output wire aary_ijtag_so, 
output wire bisr_so_pd_vinf, input wire bisr_si_pd_vinf, 
input wire bisr_shift_en_pd_vinf, input wire bisr_clk_pd_vinf, 
input wire bisr_reset_pd_vinf, input wire fary_trigger_post, 
output wire aary_post_pass, output wire aary_post_busy, 
output wire aary_post_complete, input wire fary_post_force_fail, 
input logic [5:0] fary_post_algo_select, input wire core_rst_b);


logic local_rst_n;
logic local_powergood_rst_n;
logic local_mem_rst_n;


  wire [2:0] BIST_SETUP;
  wire [5:0] toBist, bistEn;
  wire [4:0] BIST_ROW_ADD;
  wire [3:0] BIST_ROW_ADD_ts1;
  wire [4:0] BIST_ROW_ADD_ts2;
  wire [2:0] BIST_ROW_ADD_ts3;
  wire [4:0] BIST_ROW_ADD_ts4, BIST_ROW_ADD_ts5;
  wire [7:0] BIST_WRITE_DATA, BIST_WRITE_DATA_ts1, BIST_WRITE_DATA_ts2, 
             BIST_WRITE_DATA_ts3, BIST_WRITE_DATA_ts4, BIST_WRITE_DATA_ts5, 
             BIST_EXPECT_DATA, BIST_EXPECT_DATA_ts1, BIST_EXPECT_DATA_ts2, 
             BIST_EXPECT_DATA_ts3, BIST_EXPECT_DATA_ts4, BIST_EXPECT_DATA_ts5;
  wire [1:0] BIST_BANK_ADD, BIST_BANK_ADD_ts1;
  logic clk_ts1;
  wire hlp_msec_apr_rtl_tessent_sib_mbist_inst_so, 
       hlp_msec_apr_rtl_tessent_sib_sti_inst_so, 
       hlp_msec_apr_rtl_tessent_sib_sri_ctrl_inst_so, 
       hlp_msec_apr_rtl_tessent_tdr_sri_ctrl_inst_so, 
       hlp_msec_apr_rtl_tessent_sib_sri_inst_to_select, 
       hlp_msec_apr_rtl_tessent_sib_sti_inst_so_ts1, 
       hlp_msec_apr_rtl_tessent_tdr_RF_c1_algo_select_tdr_inst_so, 
       hlp_msec_apr_rtl_tessent_sib_sti_inst_to_select, 
       hlp_msec_apr_rtl_tessent_sib_algo_select_sib_inst_so, 
       hlp_msec_apr_rtl_tessent_sib_sri_ctrl_inst_to_select, 
       hlp_msec_apr_rtl_tessent_sib_algo_select_sib_inst_to_select, 
       hlp_msec_apr_rtl_tessent_tdr_RF_c6_algo_select_tdr_inst_so, 
       hlp_msec_apr_rtl_tessent_tdr_RF_c5_algo_select_tdr_inst_so, 
       hlp_msec_apr_rtl_tessent_tdr_RF_c4_algo_select_tdr_inst_so, 
       hlp_msec_apr_rtl_tessent_tdr_RF_c3_algo_select_tdr_inst_so, 
       hlp_msec_apr_rtl_tessent_tdr_RF_c2_algo_select_tdr_inst_so, ijtag_to_tck, 
       ijtag_to_ue, ijtag_to_reset, ijtag_to_se, ijtag_to_ce, ijtag_to_sel, 
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
       GO_ID_REG_SEL, GO_ID_REG_SEL_ts1, BIST_DATA_INV_COL_ADD_BIT_SEL, 
       GO_ID_REG_SEL_ts2, GO_ID_REG_SEL_ts3, GO_ID_REG_SEL_ts4, 
       GO_ID_REG_SEL_ts5, BIST_ALGO_MODE0, BIST_ALGO_MODE1, ENABLE_MEM_RESET, 
       REDUCED_ADDRESS_COUNT, BIST_CLEAR_BIRA, BIST_COLLAR_DIAG_EN, 
       BIST_COLLAR_BIRA_EN, PriorityColumn, BIST_SHIFT_BIRA_COLLAR, 
       BIST_CLEAR_BIRA_ts1, BIST_COLLAR_DIAG_EN_ts1, BIST_COLLAR_BIRA_EN_ts1, 
       PriorityColumn_ts1, BIST_SHIFT_BIRA_COLLAR_ts1, BIST_CLEAR_BIRA_ts2, 
       BIST_COLLAR_DIAG_EN_ts2, BIST_COLLAR_BIRA_EN_ts2, PriorityColumn_ts2, 
       BIST_SHIFT_BIRA_COLLAR_ts2, BIST_CLEAR_BIRA_ts3, BIST_COLLAR_DIAG_EN_ts3, 
       BIST_COLLAR_BIRA_EN_ts3, PriorityColumn_ts3, BIST_SHIFT_BIRA_COLLAR_ts3, 
       BIST_CLEAR_BIRA_ts4, BIST_COLLAR_DIAG_EN_ts4, BIST_COLLAR_BIRA_EN_ts4, 
       PriorityColumn_ts4, BIST_SHIFT_BIRA_COLLAR_ts4, BIST_CLEAR_BIRA_ts5, 
       BIST_COLLAR_DIAG_EN_ts5, BIST_COLLAR_BIRA_EN_ts5, PriorityColumn_ts5, 
       BIST_SHIFT_BIRA_COLLAR_ts5, MEM_ARRAY_DUMP_MODE, BIST_DIAG_EN, 
       BIST_ASYNC_RESET, MEM0_BIST_COLLAR_SI, MEM0_BIST_COLLAR_SI_ts1, 
       MEM1_BIST_COLLAR_SI, MEM2_BIST_COLLAR_SI, MEM3_BIST_COLLAR_SI, 
       MEM4_BIST_COLLAR_SI, MEM0_BIST_COLLAR_SI_ts2, MEM1_BIST_COLLAR_SI_ts1, 
       MEM2_BIST_COLLAR_SI_ts1, MEM3_BIST_COLLAR_SI_ts1, 
       MEM4_BIST_COLLAR_SI_ts1, MEM5_BIST_COLLAR_SI, MEM6_BIST_COLLAR_SI, 
       MEM7_BIST_COLLAR_SI, MEM8_BIST_COLLAR_SI, MEM9_BIST_COLLAR_SI, 
       MEM10_BIST_COLLAR_SI, MEM11_BIST_COLLAR_SI, MEM12_BIST_COLLAR_SI, 
       MEM13_BIST_COLLAR_SI, MEM14_BIST_COLLAR_SI, MEM15_BIST_COLLAR_SI, 
       MEM16_BIST_COLLAR_SI, MEM17_BIST_COLLAR_SI, MEM18_BIST_COLLAR_SI, 
       MEM19_BIST_COLLAR_SI, MEM20_BIST_COLLAR_SI, MEM21_BIST_COLLAR_SI, 
       MEM22_BIST_COLLAR_SI, MEM23_BIST_COLLAR_SI, MEM24_BIST_COLLAR_SI, 
       MEM25_BIST_COLLAR_SI, MEM26_BIST_COLLAR_SI, MEM27_BIST_COLLAR_SI, 
       MEM0_BIST_COLLAR_SI_ts3, MEM1_BIST_COLLAR_SI_ts2, 
       MEM2_BIST_COLLAR_SI_ts2, MEM3_BIST_COLLAR_SI_ts2, 
       MEM0_BIST_COLLAR_SI_ts4, MEM1_BIST_COLLAR_SI_ts3, 
       MEM2_BIST_COLLAR_SI_ts3, MEM3_BIST_COLLAR_SI_ts3, 
       MEM0_BIST_COLLAR_SI_ts5, MEM1_BIST_COLLAR_SI_ts4, MBISTPG_SO, 
       MBISTPG_SO_ts1, MBISTPG_SO_ts2, MBISTPG_SO_ts3, MBISTPG_SO_ts4, 
       MBISTPG_SO_ts5, BIST_SO, BIST_SO_ts1, BIST_SO_ts2, BIST_SO_ts3, 
       BIST_SO_ts4, BIST_SO_ts5, BIST_SO_ts6, BIST_SO_ts7, BIST_SO_ts8, 
       BIST_SO_ts9, BIST_SO_ts10, BIST_SO_ts11, BIST_SO_ts12, BIST_SO_ts13, 
       BIST_SO_ts14, BIST_SO_ts15, BIST_SO_ts16, BIST_SO_ts17, BIST_SO_ts18, 
       BIST_SO_ts19, BIST_SO_ts20, BIST_SO_ts21, BIST_SO_ts22, BIST_SO_ts23, 
       BIST_SO_ts24, BIST_SO_ts25, BIST_SO_ts26, BIST_SO_ts27, BIST_SO_ts28, 
       BIST_SO_ts29, BIST_SO_ts30, BIST_SO_ts31, BIST_SO_ts32, BIST_SO_ts33, 
       BIST_SO_ts34, BIST_SO_ts35, BIST_SO_ts36, BIST_SO_ts37, BIST_SO_ts38, 
       BIST_SO_ts39, BIST_SO_ts40, BIST_SO_ts41, BIST_SO_ts42, BIST_SO_ts43, 
       MBISTPG_DONE, MBISTPG_DONE_ts1, MBISTPG_DONE_ts2, MBISTPG_DONE_ts3, 
       MBISTPG_DONE_ts4, MBISTPG_DONE_ts5, MBISTPG_GO, MBISTPG_GO_ts1, 
       MBISTPG_GO_ts2, MBISTPG_GO_ts3, MBISTPG_GO_ts4, MBISTPG_GO_ts5, BIST_GO, 
       BIST_GO_ts1, BIST_GO_ts2, BIST_GO_ts3, BIST_GO_ts4, BIST_GO_ts5, 
       BIST_GO_ts6, BIST_GO_ts7, BIST_GO_ts8, BIST_GO_ts9, BIST_GO_ts10, 
       BIST_GO_ts11, BIST_GO_ts12, BIST_GO_ts13, BIST_GO_ts14, BIST_GO_ts15, 
       BIST_GO_ts16, BIST_GO_ts17, BIST_GO_ts18, BIST_GO_ts19, BIST_GO_ts20, 
       BIST_GO_ts21, BIST_GO_ts22, BIST_GO_ts23, BIST_GO_ts24, BIST_GO_ts25, 
       BIST_GO_ts26, BIST_GO_ts27, BIST_GO_ts28, BIST_GO_ts29, BIST_GO_ts30, 
       BIST_GO_ts31, BIST_GO_ts32, BIST_GO_ts33, BIST_GO_ts34, BIST_GO_ts35, 
       BIST_GO_ts36, BIST_GO_ts37, BIST_GO_ts38, BIST_GO_ts39, BIST_GO_ts40, 
       BIST_GO_ts41, BIST_GO_ts42, BIST_GO_ts43, FL_CNT_MODE0, FL_CNT_MODE1, 
       BIST_READENABLE, BIST_WRITEENABLE, BIST_READENABLE_ts1, 
       BIST_WRITEENABLE_ts1, BIST_READENABLE_ts2, BIST_WRITEENABLE_ts2, 
       BIST_READENABLE_ts3, BIST_WRITEENABLE_ts3, BIST_READENABLE_ts4, 
       BIST_WRITEENABLE_ts4, BIST_READENABLE_ts5, BIST_WRITEENABLE_ts5, 
       BIST_CMP, BIST_CMP_ts1, BIST_CMP_ts2, BIST_CMP_ts3, BIST_CMP_ts4, 
       BIST_CMP_ts5, INCLUDE_MEM_RESULTS_REG, BIST_COLLAR_EN0, 
       BIST_COLLAR_EN0_ts1, BIST_COLLAR_EN1, BIST_COLLAR_EN2, BIST_COLLAR_EN3, 
       BIST_COLLAR_EN4, BIST_COLLAR_EN0_ts2, BIST_COLLAR_EN1_ts1, 
       BIST_COLLAR_EN2_ts1, BIST_COLLAR_EN3_ts1, BIST_COLLAR_EN4_ts1, 
       BIST_COLLAR_EN5, BIST_COLLAR_EN6, BIST_COLLAR_EN7, BIST_COLLAR_EN8, 
       BIST_COLLAR_EN9, BIST_COLLAR_EN10, BIST_COLLAR_EN11, BIST_COLLAR_EN12, 
       BIST_COLLAR_EN13, BIST_COLLAR_EN14, BIST_COLLAR_EN15, BIST_COLLAR_EN16, 
       BIST_COLLAR_EN17, BIST_COLLAR_EN18, BIST_COLLAR_EN19, BIST_COLLAR_EN20, 
       BIST_COLLAR_EN21, BIST_COLLAR_EN22, BIST_COLLAR_EN23, BIST_COLLAR_EN24, 
       BIST_COLLAR_EN25, BIST_COLLAR_EN26, BIST_COLLAR_EN27, 
       BIST_COLLAR_EN0_ts3, BIST_COLLAR_EN1_ts2, BIST_COLLAR_EN2_ts2, 
       BIST_COLLAR_EN3_ts2, BIST_COLLAR_EN0_ts4, BIST_COLLAR_EN1_ts3, 
       BIST_COLLAR_EN2_ts3, BIST_COLLAR_EN3_ts3, BIST_COLLAR_EN0_ts5, 
       BIST_COLLAR_EN1_ts4, BIST_RUN_TO_COLLAR0, BIST_RUN_TO_COLLAR0_ts1, 
       BIST_RUN_TO_COLLAR1, BIST_RUN_TO_COLLAR2, BIST_RUN_TO_COLLAR3, 
       BIST_RUN_TO_COLLAR4, BIST_RUN_TO_COLLAR0_ts2, BIST_RUN_TO_COLLAR1_ts1, 
       BIST_RUN_TO_COLLAR2_ts1, BIST_RUN_TO_COLLAR3_ts1, 
       BIST_RUN_TO_COLLAR4_ts1, BIST_RUN_TO_COLLAR5, BIST_RUN_TO_COLLAR6, 
       BIST_RUN_TO_COLLAR7, BIST_RUN_TO_COLLAR8, BIST_RUN_TO_COLLAR9, 
       BIST_RUN_TO_COLLAR10, BIST_RUN_TO_COLLAR11, BIST_RUN_TO_COLLAR12, 
       BIST_RUN_TO_COLLAR13, BIST_RUN_TO_COLLAR14, BIST_RUN_TO_COLLAR15, 
       BIST_RUN_TO_COLLAR16, BIST_RUN_TO_COLLAR17, BIST_RUN_TO_COLLAR18, 
       BIST_RUN_TO_COLLAR19, BIST_RUN_TO_COLLAR20, BIST_RUN_TO_COLLAR21, 
       BIST_RUN_TO_COLLAR22, BIST_RUN_TO_COLLAR23, BIST_RUN_TO_COLLAR24, 
       BIST_RUN_TO_COLLAR25, BIST_RUN_TO_COLLAR26, BIST_RUN_TO_COLLAR27, 
       BIST_RUN_TO_COLLAR0_ts3, BIST_RUN_TO_COLLAR1_ts2, 
       BIST_RUN_TO_COLLAR2_ts2, BIST_RUN_TO_COLLAR3_ts2, 
       BIST_RUN_TO_COLLAR0_ts4, BIST_RUN_TO_COLLAR1_ts3, 
       BIST_RUN_TO_COLLAR2_ts3, BIST_RUN_TO_COLLAR3_ts3, 
       BIST_RUN_TO_COLLAR0_ts5, BIST_RUN_TO_COLLAR1_ts4, BIST_SHADOW_READENABLE, 
       BIST_SHADOW_READADDRESS, BIST_SHADOW_READENABLE_ts1, 
       BIST_SHADOW_READADDRESS_ts1, BIST_SHADOW_READENABLE_ts2, 
       BIST_SHADOW_READADDRESS_ts2, BIST_SHADOW_READENABLE_ts3, 
       BIST_SHADOW_READADDRESS_ts3, BIST_SHADOW_READENABLE_ts4, 
       BIST_SHADOW_READADDRESS_ts4, BIST_SHADOW_READENABLE_ts5, 
       BIST_SHADOW_READADDRESS_ts5, BIST_CONWRITE_ROWADDRESS, 
       BIST_CONWRITE_ENABLE, BIST_CONWRITE_ROWADDRESS_ts1, 
       BIST_CONWRITE_ENABLE_ts1, BIST_CONWRITE_ROWADDRESS_ts2, 
       BIST_CONWRITE_ENABLE_ts2, BIST_CONWRITE_ROWADDRESS_ts3, 
       BIST_CONWRITE_ENABLE_ts3, BIST_CONWRITE_ROWADDRESS_ts4, 
       BIST_CONWRITE_ENABLE_ts4, BIST_CONWRITE_ROWADDRESS_ts5, 
       BIST_CONWRITE_ENABLE_ts5, BIST_CONREAD_ROWADDRESS, 
       BIST_CONREAD_COLUMNADDRESS, BIST_CONREAD_ENABLE, 
       BIST_CONREAD_ROWADDRESS_ts1, BIST_CONREAD_COLUMNADDRESS_ts1, 
       BIST_CONREAD_ENABLE_ts1, BIST_CONREAD_ROWADDRESS_ts2, 
       BIST_CONREAD_COLUMNADDRESS_ts2, BIST_CONREAD_ENABLE_ts2, 
       BIST_CONREAD_ROWADDRESS_ts3, BIST_CONREAD_COLUMNADDRESS_ts3, 
       BIST_CONREAD_ENABLE_ts3, BIST_CONREAD_ROWADDRESS_ts4, 
       BIST_CONREAD_COLUMNADDRESS_ts4, BIST_CONREAD_ENABLE_ts4, 
       BIST_CONREAD_ROWADDRESS_ts5, BIST_CONREAD_COLUMNADDRESS_ts5, 
       BIST_CONREAD_ENABLE_ts5, BIST_TESTDATA_SELECT_TO_COLLAR, 
       BIST_TESTDATA_SELECT_TO_COLLAR_ts1, BIST_TESTDATA_SELECT_TO_COLLAR_ts2, 
       BIST_TESTDATA_SELECT_TO_COLLAR_ts3, BIST_TESTDATA_SELECT_TO_COLLAR_ts4, 
       BIST_TESTDATA_SELECT_TO_COLLAR_ts5, BIST_ON_TO_COLLAR, 
       BIST_ON_TO_COLLAR_ts1, BIST_ON_TO_COLLAR_ts2, BIST_ON_TO_COLLAR_ts3, 
       BIST_ON_TO_COLLAR_ts4, BIST_ON_TO_COLLAR_ts5, BIST_SHIFT_COLLAR, 
       BIST_SHIFT_COLLAR_ts1, BIST_SHIFT_COLLAR_ts2, BIST_SHIFT_COLLAR_ts3, 
       BIST_SHIFT_COLLAR_ts4, BIST_SHIFT_COLLAR_ts5, BIST_COLLAR_SETUP, 
       BIST_COLLAR_SETUP_ts1, BIST_COLLAR_SETUP_ts2, BIST_COLLAR_SETUP_ts3, 
       BIST_COLLAR_SETUP_ts4, BIST_COLLAR_SETUP_ts5, BIST_CLEAR_DEFAULT, 
       BIST_CLEAR_DEFAULT_ts1, BIST_CLEAR_DEFAULT_ts2, BIST_CLEAR_DEFAULT_ts3, 
       BIST_CLEAR_DEFAULT_ts4, BIST_CLEAR_DEFAULT_ts5, BIST_CLEAR, 
       BIST_CLEAR_ts1, BIST_CLEAR_ts2, BIST_CLEAR_ts3, BIST_CLEAR_ts4, 
       BIST_CLEAR_ts5, BIST_COLLAR_OPSET_SELECT, BIST_COLLAR_OPSET_SELECT_ts1, 
       BIST_COLLAR_OPSET_SELECT_ts2, BIST_COLLAR_OPSET_SELECT_ts3, 
       BIST_COLLAR_OPSET_SELECT_ts4, BIST_COLLAR_OPSET_SELECT_ts5, 
       BIST_COLLAR_HOLD, FREEZE_STOP_ERROR, ERROR_CNT_ZERO, 
       BIST_COLLAR_HOLD_ts1, FREEZE_STOP_ERROR_ts1, ERROR_CNT_ZERO_ts1, 
       BIST_COLLAR_HOLD_ts2, FREEZE_STOP_ERROR_ts2, ERROR_CNT_ZERO_ts2, 
       BIST_COLLAR_HOLD_ts3, FREEZE_STOP_ERROR_ts3, ERROR_CNT_ZERO_ts3, 
       BIST_COLLAR_HOLD_ts4, FREEZE_STOP_ERROR_ts4, ERROR_CNT_ZERO_ts4, 
       BIST_COLLAR_HOLD_ts5, FREEZE_STOP_ERROR_ts5, ERROR_CNT_ZERO_ts5, 
       MBISTPG_RESET_REG_SETUP2, MBISTPG_RESET_REG_SETUP2_ts1, 
       MBISTPG_RESET_REG_SETUP2_ts2, MBISTPG_RESET_REG_SETUP2_ts3, 
       MBISTPG_RESET_REG_SETUP2_ts4, MBISTPG_RESET_REG_SETUP2_ts5, 
       BIST_DATA_INV_COL_ADD_BIT_SELECT_EN, BIST_COL_ADD, BIST_COL_ADD_ts1, 
       BIST_COL_ADD_ts2, hlp_msec_apr_rtl_tessent_mbist_bap_inst_so, tck_select, 
       MBISTPG_STABLE, MBISTPG_STABLE_ts1, MBISTPG_STABLE_ts2, 
       MBISTPG_STABLE_ts3, MBISTPG_STABLE_ts4, MBISTPG_STABLE_ts5, ijtag_so, 
       bisr_so_pd_vinf_ts1, trigger_post, trigger_array, 
       mbistpg_select_common_algo_o, select_rf, pass, sys_test_done_clk, 
       sys_test_pass_clk, complete, busy, sync_reset_clk_reset_bypass_mux_o, 
       Intel_reset_sync_polarity_clk_inverter_o1, sync_reset_clk_o, 
       sync_reset_clk_o_ts1;
  wire [6:0] mbistpg_algo_sel_o, ALGO_SEL_REG, ALGO_SEL_REG_ts1, 
             ALGO_SEL_REG_ts2, ALGO_SEL_REG_ts3, ALGO_SEL_REG_ts4, 
             ALGO_SEL_REG_ts5;
ctech_lib_mux_2to1 reset_scan_mux_mem_rst
  (.d2 (mem_rst_n),
   .d1 (fscan_byprst_b),
   .s (fscan_rstbypen),
   .o (local_mem_rst_n));

ctech_lib_mux_2to1 reset_scan_mux_powergood_rst
  (.d2 (powergood_rst_n),
   .d1 (fscan_byprst_b),
   .s (fscan_rstbypen),
   .o (local_powergood_rst_n));

ctech_lib_mux_2to1 reset_scan_mux_rst
  (.d2 (rst_n),
   .d1 (fscan_byprst_b),
   .s (fscan_rstbypen),
   .o (local_rst_n));

logic fet_ack_b_to_rf;

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


/*AUTOLOGIC*/
// Beginning of automatic wires (for undeclared instantiated-module outputs)
logic [`HLP_MSEC_MSEC_RX_EOP_CLASS_MEM_FROM_MEM_WIDTH-1:0] frm_msec_rx_eop_class_mem;// From u_msec_apr_rf_mems of hlp_msec_apr_rf_mems.v
logic [`HLP_MSEC_MSEC_RX_IBUF_MEM_FROM_MEM_WIDTH-1:0] frm_msec_rx_ibuf_mem;// From u_msec_apr_rf_mems of hlp_msec_apr_rf_mems.v
logic [`HLP_MSEC_MSEC_RX_KEY_MEM_FROM_MEM_WIDTH-1:0] frm_msec_rx_key_mem_0;// From u_msec_apr_rf_mems of hlp_msec_apr_rf_mems.v
logic [`HLP_MSEC_MSEC_RX_KEY_MEM_FROM_MEM_WIDTH-1:0] frm_msec_rx_key_mem_1;// From u_msec_apr_rf_mems of hlp_msec_apr_rf_mems.v
logic [`HLP_MSEC_MSEC_RX_KEY_PTR_MEM_FROM_MEM_WIDTH-1:0] frm_msec_rx_key_ptr_mem;// From u_msec_apr_rf_mems of hlp_msec_apr_rf_mems.v
logic [`HLP_MSEC_MSEC_RX_LOWEST_PN_MEM_FROM_MEM_WIDTH-1:0] frm_msec_rx_lowest_pn_mem_0;// From u_msec_apr_rf_mems of hlp_msec_apr_rf_mems.v
logic [`HLP_MSEC_MSEC_RX_LOWEST_PN_MEM_FROM_MEM_WIDTH-1:0] frm_msec_rx_lowest_pn_mem_1;// From u_msec_apr_rf_mems of hlp_msec_apr_rf_mems.v
logic [`HLP_MSEC_MSEC_RX_NEXT_PN_MEM_FROM_MEM_WIDTH-1:0] frm_msec_rx_next_pn_mem_0;// From u_msec_apr_rf_mems of hlp_msec_apr_rf_mems.v
logic [`HLP_MSEC_MSEC_RX_NEXT_PN_MEM_FROM_MEM_WIDTH-1:0] frm_msec_rx_next_pn_mem_1;// From u_msec_apr_rf_mems of hlp_msec_apr_rf_mems.v
logic [`HLP_MSEC_MSEC_RX_OBUF_MEM_FROM_MEM_WIDTH-1:0] frm_msec_rx_obuf_mem;// From u_msec_apr_rf_mems of hlp_msec_apr_rf_mems.v
logic [`HLP_MSEC_MSEC_RX_PKT_CNT_MEM_FROM_MEM_WIDTH-1:0] frm_msec_rx_pkt_cnt_mem_0;// From u_msec_apr_rf_mems of hlp_msec_apr_rf_mems.v
logic [`HLP_MSEC_MSEC_RX_PKT_CNT_MEM_FROM_MEM_WIDTH-1:0] frm_msec_rx_pkt_cnt_mem_1;// From u_msec_apr_rf_mems of hlp_msec_apr_rf_mems.v
logic [`HLP_MSEC_MSEC_RX_SALT_MEM_FROM_MEM_WIDTH-1:0] frm_msec_rx_salt_mem_0;// From u_msec_apr_rf_mems of hlp_msec_apr_rf_mems.v
logic [`HLP_MSEC_MSEC_RX_SALT_MEM_FROM_MEM_WIDTH-1:0] frm_msec_rx_salt_mem_1;// From u_msec_apr_rf_mems of hlp_msec_apr_rf_mems.v
logic [`HLP_MSEC_MSEC_RX_SALT_MEM_FROM_MEM_WIDTH-1:0] frm_msec_rx_salt_mem_2;// From u_msec_apr_rf_mems of hlp_msec_apr_rf_mems.v
logic [`HLP_MSEC_MSEC_RX_SC_VLAN_TAG_CTRL_FROM_MEM_WIDTH-1:0] frm_msec_rx_sc_vlan_tag_ctrl;// From u_msec_apr_rf_mems of hlp_msec_apr_rf_mems.v
logic [`HLP_MSEC_MSEC_RX_SSCI_MEM_FROM_MEM_WIDTH-1:0] frm_msec_rx_ssci_mem;// From u_msec_apr_rf_mems of hlp_msec_apr_rf_mems.v
logic [`HLP_MSEC_MSEC_TX_IBUF_MEM_FROM_MEM_WIDTH-1:0] frm_msec_tx_ibuf_mem;// From u_msec_apr_rf_mems of hlp_msec_apr_rf_mems.v
logic [`HLP_MSEC_MSEC_TX_KEY_MEM_FROM_MEM_WIDTH-1:0] frm_msec_tx_key_mem_0;// From u_msec_apr_rf_mems of hlp_msec_apr_rf_mems.v
logic [`HLP_MSEC_MSEC_TX_KEY_MEM_FROM_MEM_WIDTH-1:0] frm_msec_tx_key_mem_1;// From u_msec_apr_rf_mems of hlp_msec_apr_rf_mems.v
logic [`HLP_MSEC_MSEC_TX_KEY_PTR_MEM_FROM_MEM_WIDTH-1:0] frm_msec_tx_key_ptr_mem;// From u_msec_apr_rf_mems of hlp_msec_apr_rf_mems.v
logic [`HLP_MSEC_MSEC_TX_NEXT_PN_MEM_FROM_MEM_WIDTH-1:0] frm_msec_tx_next_pn_mem_0;// From u_msec_apr_rf_mems of hlp_msec_apr_rf_mems.v
logic [`HLP_MSEC_MSEC_TX_NEXT_PN_MEM_FROM_MEM_WIDTH-1:0] frm_msec_tx_next_pn_mem_1;// From u_msec_apr_rf_mems of hlp_msec_apr_rf_mems.v
logic [`HLP_MSEC_MSEC_TX_OBUF_MEM_FROM_MEM_WIDTH-1:0] frm_msec_tx_obuf_mem;// From u_msec_apr_rf_mems of hlp_msec_apr_rf_mems.v
logic [`HLP_MSEC_MSEC_TX_PKT_CNT_MEM_FROM_MEM_WIDTH-1:0] frm_msec_tx_pkt_cnt_mem_0;// From u_msec_apr_rf_mems of hlp_msec_apr_rf_mems.v
logic [`HLP_MSEC_MSEC_TX_PKT_CNT_MEM_FROM_MEM_WIDTH-1:0] frm_msec_tx_pkt_cnt_mem_1;// From u_msec_apr_rf_mems of hlp_msec_apr_rf_mems.v
logic [`HLP_MSEC_MSEC_TX_SALT_MEM_FROM_MEM_WIDTH-1:0] frm_msec_tx_salt_mem_0;// From u_msec_apr_rf_mems of hlp_msec_apr_rf_mems.v
logic [`HLP_MSEC_MSEC_TX_SALT_MEM_FROM_MEM_WIDTH-1:0] frm_msec_tx_salt_mem_1;// From u_msec_apr_rf_mems of hlp_msec_apr_rf_mems.v
logic [`HLP_MSEC_MSEC_TX_SALT_MEM_FROM_MEM_WIDTH-1:0] frm_msec_tx_salt_mem_2;// From u_msec_apr_rf_mems of hlp_msec_apr_rf_mems.v
logic [`HLP_MSEC_MSEC_TX_SC_VLAN_TAG_CTRL_FROM_MEM_WIDTH-1:0] frm_msec_tx_sc_vlan_tag_ctrl;// From u_msec_apr_rf_mems of hlp_msec_apr_rf_mems.v
logic [`HLP_MSEC_MSEC_TX_SCI_MEM_FROM_MEM_WIDTH-1:0] frm_msec_tx_sci_mem_0;// From u_msec_apr_rf_mems of hlp_msec_apr_rf_mems.v
logic [`HLP_MSEC_MSEC_TX_SCI_MEM_FROM_MEM_WIDTH-1:0] frm_msec_tx_sci_mem_1;// From u_msec_apr_rf_mems of hlp_msec_apr_rf_mems.v
logic [`HLP_MSEC_MSEC_TX_SSCI_MEM_FROM_MEM_WIDTH-1:0] frm_msec_tx_ssci_mem;// From u_msec_apr_rf_mems of hlp_msec_apr_rf_mems.v
logic                   gclk;                   // From u_msec_apr_func_logic of hlp_msec_apr_func_logic.v
logic [`HLP_MSEC_MSEC_RX_EOP_CLASS_MEM_TO_MEM_WIDTH-1:0] tom_msec_rx_eop_class_mem;// From u_msec_apr_func_logic of hlp_msec_apr_func_logic.v
logic [`HLP_MSEC_MSEC_RX_IBUF_MEM_TO_MEM_WIDTH-1:0] tom_msec_rx_ibuf_mem;// From u_msec_apr_func_logic of hlp_msec_apr_func_logic.v
logic [`HLP_MSEC_MSEC_RX_KEY_MEM_TO_MEM_WIDTH-1:0] tom_msec_rx_key_mem_0;// From u_msec_apr_func_logic of hlp_msec_apr_func_logic.v
logic [`HLP_MSEC_MSEC_RX_KEY_MEM_TO_MEM_WIDTH-1:0] tom_msec_rx_key_mem_1;// From u_msec_apr_func_logic of hlp_msec_apr_func_logic.v
logic [`HLP_MSEC_MSEC_RX_KEY_PTR_MEM_TO_MEM_WIDTH-1:0] tom_msec_rx_key_ptr_mem;// From u_msec_apr_func_logic of hlp_msec_apr_func_logic.v
logic [`HLP_MSEC_MSEC_RX_LOWEST_PN_MEM_TO_MEM_WIDTH-1:0] tom_msec_rx_lowest_pn_mem_0;// From u_msec_apr_func_logic of hlp_msec_apr_func_logic.v
logic [`HLP_MSEC_MSEC_RX_LOWEST_PN_MEM_TO_MEM_WIDTH-1:0] tom_msec_rx_lowest_pn_mem_1;// From u_msec_apr_func_logic of hlp_msec_apr_func_logic.v
logic [`HLP_MSEC_MSEC_RX_NEXT_PN_MEM_TO_MEM_WIDTH-1:0] tom_msec_rx_next_pn_mem_0;// From u_msec_apr_func_logic of hlp_msec_apr_func_logic.v
logic [`HLP_MSEC_MSEC_RX_NEXT_PN_MEM_TO_MEM_WIDTH-1:0] tom_msec_rx_next_pn_mem_1;// From u_msec_apr_func_logic of hlp_msec_apr_func_logic.v
logic [`HLP_MSEC_MSEC_RX_OBUF_MEM_TO_MEM_WIDTH-1:0] tom_msec_rx_obuf_mem;// From u_msec_apr_func_logic of hlp_msec_apr_func_logic.v
logic [`HLP_MSEC_MSEC_RX_PKT_CNT_MEM_TO_MEM_WIDTH-1:0] tom_msec_rx_pkt_cnt_mem_0;// From u_msec_apr_func_logic of hlp_msec_apr_func_logic.v
logic [`HLP_MSEC_MSEC_RX_PKT_CNT_MEM_TO_MEM_WIDTH-1:0] tom_msec_rx_pkt_cnt_mem_1;// From u_msec_apr_func_logic of hlp_msec_apr_func_logic.v
logic [`HLP_MSEC_MSEC_RX_SALT_MEM_TO_MEM_WIDTH-1:0] tom_msec_rx_salt_mem_0;// From u_msec_apr_func_logic of hlp_msec_apr_func_logic.v
logic [`HLP_MSEC_MSEC_RX_SALT_MEM_TO_MEM_WIDTH-1:0] tom_msec_rx_salt_mem_1;// From u_msec_apr_func_logic of hlp_msec_apr_func_logic.v
logic [`HLP_MSEC_MSEC_RX_SALT_MEM_TO_MEM_WIDTH-1:0] tom_msec_rx_salt_mem_2;// From u_msec_apr_func_logic of hlp_msec_apr_func_logic.v
logic [`HLP_MSEC_MSEC_RX_SC_VLAN_TAG_CTRL_TO_MEM_WIDTH-1:0] tom_msec_rx_sc_vlan_tag_ctrl;// From u_msec_apr_func_logic of hlp_msec_apr_func_logic.v
logic [`HLP_MSEC_MSEC_RX_SSCI_MEM_TO_MEM_WIDTH-1:0] tom_msec_rx_ssci_mem;// From u_msec_apr_func_logic of hlp_msec_apr_func_logic.v
logic [`HLP_MSEC_MSEC_TX_IBUF_MEM_TO_MEM_WIDTH-1:0] tom_msec_tx_ibuf_mem;// From u_msec_apr_func_logic of hlp_msec_apr_func_logic.v
logic [`HLP_MSEC_MSEC_TX_KEY_MEM_TO_MEM_WIDTH-1:0] tom_msec_tx_key_mem_0;// From u_msec_apr_func_logic of hlp_msec_apr_func_logic.v
logic [`HLP_MSEC_MSEC_TX_KEY_MEM_TO_MEM_WIDTH-1:0] tom_msec_tx_key_mem_1;// From u_msec_apr_func_logic of hlp_msec_apr_func_logic.v
logic [`HLP_MSEC_MSEC_TX_KEY_PTR_MEM_TO_MEM_WIDTH-1:0] tom_msec_tx_key_ptr_mem;// From u_msec_apr_func_logic of hlp_msec_apr_func_logic.v
logic [`HLP_MSEC_MSEC_TX_NEXT_PN_MEM_TO_MEM_WIDTH-1:0] tom_msec_tx_next_pn_mem_0;// From u_msec_apr_func_logic of hlp_msec_apr_func_logic.v
logic [`HLP_MSEC_MSEC_TX_NEXT_PN_MEM_TO_MEM_WIDTH-1:0] tom_msec_tx_next_pn_mem_1;// From u_msec_apr_func_logic of hlp_msec_apr_func_logic.v
logic [`HLP_MSEC_MSEC_TX_OBUF_MEM_TO_MEM_WIDTH-1:0] tom_msec_tx_obuf_mem;// From u_msec_apr_func_logic of hlp_msec_apr_func_logic.v
logic [`HLP_MSEC_MSEC_TX_PKT_CNT_MEM_TO_MEM_WIDTH-1:0] tom_msec_tx_pkt_cnt_mem_0;// From u_msec_apr_func_logic of hlp_msec_apr_func_logic.v
logic [`HLP_MSEC_MSEC_TX_PKT_CNT_MEM_TO_MEM_WIDTH-1:0] tom_msec_tx_pkt_cnt_mem_1;// From u_msec_apr_func_logic of hlp_msec_apr_func_logic.v
logic [`HLP_MSEC_MSEC_TX_SALT_MEM_TO_MEM_WIDTH-1:0] tom_msec_tx_salt_mem_0;// From u_msec_apr_func_logic of hlp_msec_apr_func_logic.v
logic [`HLP_MSEC_MSEC_TX_SALT_MEM_TO_MEM_WIDTH-1:0] tom_msec_tx_salt_mem_1;// From u_msec_apr_func_logic of hlp_msec_apr_func_logic.v
logic [`HLP_MSEC_MSEC_TX_SALT_MEM_TO_MEM_WIDTH-1:0] tom_msec_tx_salt_mem_2;// From u_msec_apr_func_logic of hlp_msec_apr_func_logic.v
logic [`HLP_MSEC_MSEC_TX_SC_VLAN_TAG_CTRL_TO_MEM_WIDTH-1:0] tom_msec_tx_sc_vlan_tag_ctrl;// From u_msec_apr_func_logic of hlp_msec_apr_func_logic.v
logic [`HLP_MSEC_MSEC_TX_SCI_MEM_TO_MEM_WIDTH-1:0] tom_msec_tx_sci_mem_0;// From u_msec_apr_func_logic of hlp_msec_apr_func_logic.v
logic [`HLP_MSEC_MSEC_TX_SCI_MEM_TO_MEM_WIDTH-1:0] tom_msec_tx_sci_mem_1;// From u_msec_apr_func_logic of hlp_msec_apr_func_logic.v
logic [`HLP_MSEC_MSEC_TX_SSCI_MEM_TO_MEM_WIDTH-1:0] tom_msec_tx_ssci_mem;// From u_msec_apr_func_logic of hlp_msec_apr_func_logic.v
// End of automatics

/*
  hlp_msec_apr_rf_mems AUTO_TEMPLATE
 (
  .clk                               (gclk[]),
  .msec_\(.*\)_from_mem              (frm_\1[]),
  .msec_\(.*\)_to_mem                (tom_\1[]),
  .fary_ffuse_rfhs2r2w_trim ('0),
  .post_mux_ctrl ('0),
  .fary_trigger_post_rf ('0),
  .aary_post_complete_rf (),
  .aary_post_pass_rf (),
  .fary_isolation_control_in  (isol_en_b),
  .fscan_clkgenctrl   (fscan_clkgenctrl[0]),
  .fscan_clkgenctrlen (latch_mem_fuses),
  .ip_reset_b (local_mem_rst_n),
  .car_raw_lan_power_good_with_byprst (local_powergood_rst_n) );*/
logic fary_trigger_post_msec_rf, aary_post_complete_msec_rf, aary_post_pass_msec_rf;
ctech_lib_doublesync_rstb  #(.WIDTH(1))  u_trigger_post_msec_rf
  (.clk(clk_ts1), .rstb(local_mem_rst_n), .d(fary_trigger_post_rf), .o(fary_trigger_post_msec_rf) );
assign aary_post_complete_rf = aary_post_complete_msec_rf;
always_ff
    @(posedge clk_ts1)
        begin 
            aary_post_pass_rf <= (fary_post_pass_rf & aary_post_pass_msec_rf);
        end

hlp_msec_apr_rf_mems u_msec_apr_rf_mems
(// Manual connections
 .fary_trigger_post_msec_rf,
 .aary_post_complete_msec_rf,
 .aary_post_pass_msec_rf,
 .fary_pwren_b_rf     (fet_ack_b_to_rf),
// .fscan_clkgenctrl   (fscan_clkgenctrl[0]),
// .fscan_clkgenctrlen (fscan_clkgenctrlen[0]),
 .aary_pwren_b_rf     (fet_ack_b),
 /*AUTOINST*/
 // Outputs
 .aary_post_complete_rf                 (),                      // Templated
 .aary_post_pass_rf                     (),                      // Templated
 .msec_msec_rx_eop_class_mem_from_mem   (frm_msec_rx_eop_class_mem[`HLP_MSEC_MSEC_RX_EOP_CLASS_MEM_FROM_MEM_WIDTH-1:0]), // Templated
 .msec_msec_rx_ibuf_mem_from_mem        (frm_msec_rx_ibuf_mem[`HLP_MSEC_MSEC_RX_IBUF_MEM_FROM_MEM_WIDTH-1:0]), // Templated
 .msec_msec_rx_key_mem_0_from_mem       (frm_msec_rx_key_mem_0[`HLP_MSEC_MSEC_RX_KEY_MEM_FROM_MEM_WIDTH-1:0]), // Templated
 .msec_msec_rx_key_mem_1_from_mem       (frm_msec_rx_key_mem_1[`HLP_MSEC_MSEC_RX_KEY_MEM_FROM_MEM_WIDTH-1:0]), // Templated
 .msec_msec_rx_key_ptr_mem_from_mem     (frm_msec_rx_key_ptr_mem[`HLP_MSEC_MSEC_RX_KEY_PTR_MEM_FROM_MEM_WIDTH-1:0]), // Templated
 .msec_msec_rx_lowest_pn_mem_0_from_mem (frm_msec_rx_lowest_pn_mem_0[`HLP_MSEC_MSEC_RX_LOWEST_PN_MEM_FROM_MEM_WIDTH-1:0]), // Templated
 .msec_msec_rx_lowest_pn_mem_1_from_mem (frm_msec_rx_lowest_pn_mem_1[`HLP_MSEC_MSEC_RX_LOWEST_PN_MEM_FROM_MEM_WIDTH-1:0]), // Templated
 .msec_msec_rx_next_pn_mem_0_from_mem   (frm_msec_rx_next_pn_mem_0[`HLP_MSEC_MSEC_RX_NEXT_PN_MEM_FROM_MEM_WIDTH-1:0]), // Templated
 .msec_msec_rx_next_pn_mem_1_from_mem   (frm_msec_rx_next_pn_mem_1[`HLP_MSEC_MSEC_RX_NEXT_PN_MEM_FROM_MEM_WIDTH-1:0]), // Templated
 .msec_msec_rx_obuf_mem_from_mem        (frm_msec_rx_obuf_mem[`HLP_MSEC_MSEC_RX_OBUF_MEM_FROM_MEM_WIDTH-1:0]), // Templated
 .msec_msec_rx_pkt_cnt_mem_0_from_mem   (frm_msec_rx_pkt_cnt_mem_0[`HLP_MSEC_MSEC_RX_PKT_CNT_MEM_FROM_MEM_WIDTH-1:0]), // Templated
 .msec_msec_rx_pkt_cnt_mem_1_from_mem   (frm_msec_rx_pkt_cnt_mem_1[`HLP_MSEC_MSEC_RX_PKT_CNT_MEM_FROM_MEM_WIDTH-1:0]), // Templated
 .msec_msec_rx_salt_mem_0_from_mem      (frm_msec_rx_salt_mem_0[`HLP_MSEC_MSEC_RX_SALT_MEM_FROM_MEM_WIDTH-1:0]), // Templated
 .msec_msec_rx_salt_mem_1_from_mem      (frm_msec_rx_salt_mem_1[`HLP_MSEC_MSEC_RX_SALT_MEM_FROM_MEM_WIDTH-1:0]), // Templated
 .msec_msec_rx_salt_mem_2_from_mem      (frm_msec_rx_salt_mem_2[`HLP_MSEC_MSEC_RX_SALT_MEM_FROM_MEM_WIDTH-1:0]), // Templated
 .msec_msec_rx_sc_vlan_tag_ctrl_from_mem(frm_msec_rx_sc_vlan_tag_ctrl[`HLP_MSEC_MSEC_RX_SC_VLAN_TAG_CTRL_FROM_MEM_WIDTH-1:0]), // Templated
 .msec_msec_rx_ssci_mem_from_mem        (frm_msec_rx_ssci_mem[`HLP_MSEC_MSEC_RX_SSCI_MEM_FROM_MEM_WIDTH-1:0]), // Templated
 .msec_msec_tx_ibuf_mem_from_mem        (frm_msec_tx_ibuf_mem[`HLP_MSEC_MSEC_TX_IBUF_MEM_FROM_MEM_WIDTH-1:0]), // Templated
 .msec_msec_tx_key_mem_0_from_mem       (frm_msec_tx_key_mem_0[`HLP_MSEC_MSEC_TX_KEY_MEM_FROM_MEM_WIDTH-1:0]), // Templated
 .msec_msec_tx_key_mem_1_from_mem       (frm_msec_tx_key_mem_1[`HLP_MSEC_MSEC_TX_KEY_MEM_FROM_MEM_WIDTH-1:0]), // Templated
 .msec_msec_tx_key_ptr_mem_from_mem     (frm_msec_tx_key_ptr_mem[`HLP_MSEC_MSEC_TX_KEY_PTR_MEM_FROM_MEM_WIDTH-1:0]), // Templated
 .msec_msec_tx_next_pn_mem_0_from_mem   (frm_msec_tx_next_pn_mem_0[`HLP_MSEC_MSEC_TX_NEXT_PN_MEM_FROM_MEM_WIDTH-1:0]), // Templated
 .msec_msec_tx_next_pn_mem_1_from_mem   (frm_msec_tx_next_pn_mem_1[`HLP_MSEC_MSEC_TX_NEXT_PN_MEM_FROM_MEM_WIDTH-1:0]), // Templated
 .msec_msec_tx_obuf_mem_from_mem        (frm_msec_tx_obuf_mem[`HLP_MSEC_MSEC_TX_OBUF_MEM_FROM_MEM_WIDTH-1:0]), // Templated
 .msec_msec_tx_pkt_cnt_mem_0_from_mem   (frm_msec_tx_pkt_cnt_mem_0[`HLP_MSEC_MSEC_TX_PKT_CNT_MEM_FROM_MEM_WIDTH-1:0]), // Templated
 .msec_msec_tx_pkt_cnt_mem_1_from_mem   (frm_msec_tx_pkt_cnt_mem_1[`HLP_MSEC_MSEC_TX_PKT_CNT_MEM_FROM_MEM_WIDTH-1:0]), // Templated
 .msec_msec_tx_salt_mem_0_from_mem      (frm_msec_tx_salt_mem_0[`HLP_MSEC_MSEC_TX_SALT_MEM_FROM_MEM_WIDTH-1:0]), // Templated
 .msec_msec_tx_salt_mem_1_from_mem      (frm_msec_tx_salt_mem_1[`HLP_MSEC_MSEC_TX_SALT_MEM_FROM_MEM_WIDTH-1:0]), // Templated
 .msec_msec_tx_salt_mem_2_from_mem      (frm_msec_tx_salt_mem_2[`HLP_MSEC_MSEC_TX_SALT_MEM_FROM_MEM_WIDTH-1:0]), // Templated
 .msec_msec_tx_sc_vlan_tag_ctrl_from_mem(frm_msec_tx_sc_vlan_tag_ctrl[`HLP_MSEC_MSEC_TX_SC_VLAN_TAG_CTRL_FROM_MEM_WIDTH-1:0]), // Templated
 .msec_msec_tx_sci_mem_0_from_mem       (frm_msec_tx_sci_mem_0[`HLP_MSEC_MSEC_TX_SCI_MEM_FROM_MEM_WIDTH-1:0]), // Templated
 .msec_msec_tx_sci_mem_1_from_mem       (frm_msec_tx_sci_mem_1[`HLP_MSEC_MSEC_TX_SCI_MEM_FROM_MEM_WIDTH-1:0]), // Templated
 .msec_msec_tx_ssci_mem_from_mem        (frm_msec_tx_ssci_mem[`HLP_MSEC_MSEC_TX_SSCI_MEM_FROM_MEM_WIDTH-1:0]), // Templated
 // Inputs
 .DFTMASK                               (DFTMASK),
 .DFTSHIFTEN                            (DFTSHIFTEN),
 .DFT_AFD_RESET_B                       (DFT_AFD_RESET_B),
 .DFT_ARRAY_FREEZE                      (DFT_ARRAY_FREEZE),
 .clk                                   (gclk),                  // Templated
 .fary_ffuse_hd2prf_trim                (fary_ffuse_hd2prf_trim[7-1:0]),
 .fary_ffuse_rf_sleep                   (fary_ffuse_rf_sleep[1:0]),
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
 .ip_reset_b                            (local_mem_rst_n),       // Templated
 .msec_msec_rx_eop_class_mem_to_mem     (tom_msec_rx_eop_class_mem[`HLP_MSEC_MSEC_RX_EOP_CLASS_MEM_TO_MEM_WIDTH-1:0]), // Templated
 .msec_msec_rx_ibuf_mem_to_mem          (tom_msec_rx_ibuf_mem[`HLP_MSEC_MSEC_RX_IBUF_MEM_TO_MEM_WIDTH-1:0]), // Templated
 .msec_msec_rx_key_mem_0_to_mem         (tom_msec_rx_key_mem_0[`HLP_MSEC_MSEC_RX_KEY_MEM_TO_MEM_WIDTH-1:0]), // Templated
 .msec_msec_rx_key_mem_1_to_mem         (tom_msec_rx_key_mem_1[`HLP_MSEC_MSEC_RX_KEY_MEM_TO_MEM_WIDTH-1:0]), // Templated
 .msec_msec_rx_key_ptr_mem_to_mem       (tom_msec_rx_key_ptr_mem[`HLP_MSEC_MSEC_RX_KEY_PTR_MEM_TO_MEM_WIDTH-1:0]), // Templated
 .msec_msec_rx_lowest_pn_mem_0_to_mem   (tom_msec_rx_lowest_pn_mem_0[`HLP_MSEC_MSEC_RX_LOWEST_PN_MEM_TO_MEM_WIDTH-1:0]), // Templated
 .msec_msec_rx_lowest_pn_mem_1_to_mem   (tom_msec_rx_lowest_pn_mem_1[`HLP_MSEC_MSEC_RX_LOWEST_PN_MEM_TO_MEM_WIDTH-1:0]), // Templated
 .msec_msec_rx_next_pn_mem_0_to_mem     (tom_msec_rx_next_pn_mem_0[`HLP_MSEC_MSEC_RX_NEXT_PN_MEM_TO_MEM_WIDTH-1:0]), // Templated
 .msec_msec_rx_next_pn_mem_1_to_mem     (tom_msec_rx_next_pn_mem_1[`HLP_MSEC_MSEC_RX_NEXT_PN_MEM_TO_MEM_WIDTH-1:0]), // Templated
 .msec_msec_rx_obuf_mem_to_mem          (tom_msec_rx_obuf_mem[`HLP_MSEC_MSEC_RX_OBUF_MEM_TO_MEM_WIDTH-1:0]), // Templated
 .msec_msec_rx_pkt_cnt_mem_0_to_mem     (tom_msec_rx_pkt_cnt_mem_0[`HLP_MSEC_MSEC_RX_PKT_CNT_MEM_TO_MEM_WIDTH-1:0]), // Templated
 .msec_msec_rx_pkt_cnt_mem_1_to_mem     (tom_msec_rx_pkt_cnt_mem_1[`HLP_MSEC_MSEC_RX_PKT_CNT_MEM_TO_MEM_WIDTH-1:0]), // Templated
 .msec_msec_rx_salt_mem_0_to_mem        (tom_msec_rx_salt_mem_0[`HLP_MSEC_MSEC_RX_SALT_MEM_TO_MEM_WIDTH-1:0]), // Templated
 .msec_msec_rx_salt_mem_1_to_mem        (tom_msec_rx_salt_mem_1[`HLP_MSEC_MSEC_RX_SALT_MEM_TO_MEM_WIDTH-1:0]), // Templated
 .msec_msec_rx_salt_mem_2_to_mem        (tom_msec_rx_salt_mem_2[`HLP_MSEC_MSEC_RX_SALT_MEM_TO_MEM_WIDTH-1:0]), // Templated
 .msec_msec_rx_sc_vlan_tag_ctrl_to_mem  (tom_msec_rx_sc_vlan_tag_ctrl[`HLP_MSEC_MSEC_RX_SC_VLAN_TAG_CTRL_TO_MEM_WIDTH-1:0]), // Templated
 .msec_msec_rx_ssci_mem_to_mem          (tom_msec_rx_ssci_mem[`HLP_MSEC_MSEC_RX_SSCI_MEM_TO_MEM_WIDTH-1:0]), // Templated
 .msec_msec_tx_ibuf_mem_to_mem          (tom_msec_tx_ibuf_mem[`HLP_MSEC_MSEC_TX_IBUF_MEM_TO_MEM_WIDTH-1:0]), // Templated
 .msec_msec_tx_key_mem_0_to_mem         (tom_msec_tx_key_mem_0[`HLP_MSEC_MSEC_TX_KEY_MEM_TO_MEM_WIDTH-1:0]), // Templated
 .msec_msec_tx_key_mem_1_to_mem         (tom_msec_tx_key_mem_1[`HLP_MSEC_MSEC_TX_KEY_MEM_TO_MEM_WIDTH-1:0]), // Templated
 .msec_msec_tx_key_ptr_mem_to_mem       (tom_msec_tx_key_ptr_mem[`HLP_MSEC_MSEC_TX_KEY_PTR_MEM_TO_MEM_WIDTH-1:0]), // Templated
 .msec_msec_tx_next_pn_mem_0_to_mem     (tom_msec_tx_next_pn_mem_0[`HLP_MSEC_MSEC_TX_NEXT_PN_MEM_TO_MEM_WIDTH-1:0]), // Templated
 .msec_msec_tx_next_pn_mem_1_to_mem     (tom_msec_tx_next_pn_mem_1[`HLP_MSEC_MSEC_TX_NEXT_PN_MEM_TO_MEM_WIDTH-1:0]), // Templated
 .msec_msec_tx_obuf_mem_to_mem          (tom_msec_tx_obuf_mem[`HLP_MSEC_MSEC_TX_OBUF_MEM_TO_MEM_WIDTH-1:0]), // Templated
 .msec_msec_tx_pkt_cnt_mem_0_to_mem     (tom_msec_tx_pkt_cnt_mem_0[`HLP_MSEC_MSEC_TX_PKT_CNT_MEM_TO_MEM_WIDTH-1:0]), // Templated
 .msec_msec_tx_pkt_cnt_mem_1_to_mem     (tom_msec_tx_pkt_cnt_mem_1[`HLP_MSEC_MSEC_TX_PKT_CNT_MEM_TO_MEM_WIDTH-1:0]), // Templated
 .msec_msec_tx_salt_mem_0_to_mem        (tom_msec_tx_salt_mem_0[`HLP_MSEC_MSEC_TX_SALT_MEM_TO_MEM_WIDTH-1:0]), // Templated
 .msec_msec_tx_salt_mem_1_to_mem        (tom_msec_tx_salt_mem_1[`HLP_MSEC_MSEC_TX_SALT_MEM_TO_MEM_WIDTH-1:0]), // Templated
 .msec_msec_tx_salt_mem_2_to_mem        (tom_msec_tx_salt_mem_2[`HLP_MSEC_MSEC_TX_SALT_MEM_TO_MEM_WIDTH-1:0]), // Templated
 .msec_msec_tx_sc_vlan_tag_ctrl_to_mem  (tom_msec_tx_sc_vlan_tag_ctrl[`HLP_MSEC_MSEC_TX_SC_VLAN_TAG_CTRL_TO_MEM_WIDTH-1:0]), // Templated
 .msec_msec_tx_sci_mem_0_to_mem         (tom_msec_tx_sci_mem_0[`HLP_MSEC_MSEC_TX_SCI_MEM_TO_MEM_WIDTH-1:0]), // Templated
 .msec_msec_tx_sci_mem_1_to_mem         (tom_msec_tx_sci_mem_1[`HLP_MSEC_MSEC_TX_SCI_MEM_TO_MEM_WIDTH-1:0]), // Templated
 .msec_msec_tx_ssci_mem_to_mem          (tom_msec_tx_ssci_mem[`HLP_MSEC_MSEC_TX_SSCI_MEM_TO_MEM_WIDTH-1:0]), // Templated
 .post_mux_ctrl                         ('0),                    // Templated
 .pwr_mgmt_in_rf                        (pwr_mgmt_in_rf[5-1:0]), .BIST_SETUP(BIST_SETUP[0]), .BIST_SETUP_ts1(BIST_SETUP[1]), 
 .BIST_SETUP_ts2(BIST_SETUP[2]), .to_interfaces_tck(to_interfaces_tck), 
 .mcp_bounding_to_en(mcp_bounding_to_en), .scan_to_en(scan_to_en), 
 .memory_bypass_to_en(memory_bypass_to_en), .GO_ID_REG_SEL(GO_ID_REG_SEL), 
 .GO_ID_REG_SEL_ts1(GO_ID_REG_SEL_ts1), .GO_ID_REG_SEL_ts2(GO_ID_REG_SEL_ts2), 
 .GO_ID_REG_SEL_ts3(GO_ID_REG_SEL_ts3), .GO_ID_REG_SEL_ts4(GO_ID_REG_SEL_ts4), 
 .GO_ID_REG_SEL_ts5(GO_ID_REG_SEL_ts5), .BIST_CLEAR_BIRA(BIST_CLEAR_BIRA), 
 .BIST_COLLAR_DIAG_EN(BIST_COLLAR_DIAG_EN), .BIST_COLLAR_BIRA_EN(BIST_COLLAR_BIRA_EN), 
 .PriorityColumn(PriorityColumn), .BIST_SHIFT_BIRA_COLLAR(BIST_SHIFT_BIRA_COLLAR), 
 .BIST_CLEAR_BIRA_ts1(BIST_CLEAR_BIRA_ts1), .BIST_COLLAR_DIAG_EN_ts1(BIST_COLLAR_DIAG_EN_ts1), 
 .BIST_COLLAR_BIRA_EN_ts1(BIST_COLLAR_BIRA_EN_ts1), .PriorityColumn_ts1(PriorityColumn_ts1), 
 .BIST_SHIFT_BIRA_COLLAR_ts1(BIST_SHIFT_BIRA_COLLAR_ts1), 
 .BIST_CLEAR_BIRA_ts2(BIST_CLEAR_BIRA_ts2), .BIST_COLLAR_DIAG_EN_ts2(BIST_COLLAR_DIAG_EN_ts2), 
 .BIST_COLLAR_BIRA_EN_ts2(BIST_COLLAR_BIRA_EN_ts2), .PriorityColumn_ts2(PriorityColumn_ts2), 
 .BIST_SHIFT_BIRA_COLLAR_ts2(BIST_SHIFT_BIRA_COLLAR_ts2), 
 .BIST_CLEAR_BIRA_ts3(BIST_CLEAR_BIRA_ts3), .BIST_COLLAR_DIAG_EN_ts3(BIST_COLLAR_DIAG_EN_ts3), 
 .BIST_COLLAR_BIRA_EN_ts3(BIST_COLLAR_BIRA_EN_ts3), .PriorityColumn_ts3(PriorityColumn_ts3), 
 .BIST_SHIFT_BIRA_COLLAR_ts3(BIST_SHIFT_BIRA_COLLAR_ts3), 
 .BIST_CLEAR_BIRA_ts4(BIST_CLEAR_BIRA_ts4), .BIST_COLLAR_DIAG_EN_ts4(BIST_COLLAR_DIAG_EN_ts4), 
 .BIST_COLLAR_BIRA_EN_ts4(BIST_COLLAR_BIRA_EN_ts4), .PriorityColumn_ts4(PriorityColumn_ts4), 
 .BIST_SHIFT_BIRA_COLLAR_ts4(BIST_SHIFT_BIRA_COLLAR_ts4), 
 .BIST_CLEAR_BIRA_ts5(BIST_CLEAR_BIRA_ts5), .BIST_COLLAR_DIAG_EN_ts5(BIST_COLLAR_DIAG_EN_ts5), 
 .BIST_COLLAR_BIRA_EN_ts5(BIST_COLLAR_BIRA_EN_ts5), .PriorityColumn_ts5(PriorityColumn_ts5), 
 .BIST_SHIFT_BIRA_COLLAR_ts5(BIST_SHIFT_BIRA_COLLAR_ts5), 
 .CHECK_REPAIR_NEEDED(CHECK_REPAIR_NEEDED), .MEM0_BIST_COLLAR_SI(MEM0_BIST_COLLAR_SI), 
 .MEM0_BIST_COLLAR_SI_ts1(MEM0_BIST_COLLAR_SI_ts1), .MEM1_BIST_COLLAR_SI(MEM1_BIST_COLLAR_SI), 
 .MEM2_BIST_COLLAR_SI(MEM2_BIST_COLLAR_SI), .MEM3_BIST_COLLAR_SI(MEM3_BIST_COLLAR_SI), 
 .MEM4_BIST_COLLAR_SI(MEM4_BIST_COLLAR_SI), .MEM0_BIST_COLLAR_SI_ts2(MEM0_BIST_COLLAR_SI_ts2), 
 .MEM1_BIST_COLLAR_SI_ts1(MEM1_BIST_COLLAR_SI_ts1), .MEM2_BIST_COLLAR_SI_ts1(MEM2_BIST_COLLAR_SI_ts1), 
 .MEM3_BIST_COLLAR_SI_ts1(MEM3_BIST_COLLAR_SI_ts1), .MEM4_BIST_COLLAR_SI_ts1(MEM4_BIST_COLLAR_SI_ts1), 
 .MEM5_BIST_COLLAR_SI(MEM5_BIST_COLLAR_SI), .MEM6_BIST_COLLAR_SI(MEM6_BIST_COLLAR_SI), 
 .MEM7_BIST_COLLAR_SI(MEM7_BIST_COLLAR_SI), .MEM8_BIST_COLLAR_SI(MEM8_BIST_COLLAR_SI), 
 .MEM9_BIST_COLLAR_SI(MEM9_BIST_COLLAR_SI), .MEM10_BIST_COLLAR_SI(MEM10_BIST_COLLAR_SI), 
 .MEM11_BIST_COLLAR_SI(MEM11_BIST_COLLAR_SI), .MEM12_BIST_COLLAR_SI(MEM12_BIST_COLLAR_SI), 
 .MEM13_BIST_COLLAR_SI(MEM13_BIST_COLLAR_SI), .MEM14_BIST_COLLAR_SI(MEM14_BIST_COLLAR_SI), 
 .MEM15_BIST_COLLAR_SI(MEM15_BIST_COLLAR_SI), .MEM16_BIST_COLLAR_SI(MEM16_BIST_COLLAR_SI), 
 .MEM17_BIST_COLLAR_SI(MEM17_BIST_COLLAR_SI), .MEM18_BIST_COLLAR_SI(MEM18_BIST_COLLAR_SI), 
 .MEM19_BIST_COLLAR_SI(MEM19_BIST_COLLAR_SI), .MEM20_BIST_COLLAR_SI(MEM20_BIST_COLLAR_SI), 
 .MEM21_BIST_COLLAR_SI(MEM21_BIST_COLLAR_SI), .MEM22_BIST_COLLAR_SI(MEM22_BIST_COLLAR_SI), 
 .MEM23_BIST_COLLAR_SI(MEM23_BIST_COLLAR_SI), .MEM24_BIST_COLLAR_SI(MEM24_BIST_COLLAR_SI), 
 .MEM25_BIST_COLLAR_SI(MEM25_BIST_COLLAR_SI), .MEM26_BIST_COLLAR_SI(MEM26_BIST_COLLAR_SI), 
 .MEM27_BIST_COLLAR_SI(MEM27_BIST_COLLAR_SI), .MEM0_BIST_COLLAR_SI_ts3(MEM0_BIST_COLLAR_SI_ts3), 
 .MEM1_BIST_COLLAR_SI_ts2(MEM1_BIST_COLLAR_SI_ts2), .MEM2_BIST_COLLAR_SI_ts2(MEM2_BIST_COLLAR_SI_ts2), 
 .MEM3_BIST_COLLAR_SI_ts2(MEM3_BIST_COLLAR_SI_ts2), .MEM0_BIST_COLLAR_SI_ts4(MEM0_BIST_COLLAR_SI_ts4), 
 .MEM1_BIST_COLLAR_SI_ts3(MEM1_BIST_COLLAR_SI_ts3), .MEM2_BIST_COLLAR_SI_ts3(MEM2_BIST_COLLAR_SI_ts3), 
 .MEM3_BIST_COLLAR_SI_ts3(MEM3_BIST_COLLAR_SI_ts3), .MEM0_BIST_COLLAR_SI_ts5(MEM0_BIST_COLLAR_SI_ts5), 
 .MEM1_BIST_COLLAR_SI_ts4(MEM1_BIST_COLLAR_SI_ts4), .BIST_SO(BIST_SO), 
 .BIST_SO_ts1(BIST_SO_ts1), .BIST_SO_ts2(BIST_SO_ts2), .BIST_SO_ts3(BIST_SO_ts3), 
 .BIST_SO_ts4(BIST_SO_ts4), .BIST_SO_ts5(BIST_SO_ts5), .BIST_SO_ts6(BIST_SO_ts6), 
 .BIST_SO_ts7(BIST_SO_ts7), .BIST_SO_ts8(BIST_SO_ts8), .BIST_SO_ts9(BIST_SO_ts9), 
 .BIST_SO_ts10(BIST_SO_ts10), .BIST_SO_ts11(BIST_SO_ts11), .BIST_SO_ts12(BIST_SO_ts12), 
 .BIST_SO_ts13(BIST_SO_ts13), .BIST_SO_ts14(BIST_SO_ts14), .BIST_SO_ts15(BIST_SO_ts15), 
 .BIST_SO_ts16(BIST_SO_ts16), .BIST_SO_ts17(BIST_SO_ts17), .BIST_SO_ts18(BIST_SO_ts18), 
 .BIST_SO_ts19(BIST_SO_ts19), .BIST_SO_ts20(BIST_SO_ts20), .BIST_SO_ts21(BIST_SO_ts21), 
 .BIST_SO_ts22(BIST_SO_ts22), .BIST_SO_ts23(BIST_SO_ts23), .BIST_SO_ts24(BIST_SO_ts24), 
 .BIST_SO_ts25(BIST_SO_ts25), .BIST_SO_ts26(BIST_SO_ts26), .BIST_SO_ts27(BIST_SO_ts27), 
 .BIST_SO_ts28(BIST_SO_ts28), .BIST_SO_ts29(BIST_SO_ts29), .BIST_SO_ts30(BIST_SO_ts30), 
 .BIST_SO_ts31(BIST_SO_ts31), .BIST_SO_ts32(BIST_SO_ts32), .BIST_SO_ts33(BIST_SO_ts33), 
 .BIST_SO_ts34(BIST_SO_ts34), .BIST_SO_ts35(BIST_SO_ts35), .BIST_SO_ts36(BIST_SO_ts36), 
 .BIST_SO_ts37(BIST_SO_ts37), .BIST_SO_ts38(BIST_SO_ts38), .BIST_SO_ts39(BIST_SO_ts39), 
 .BIST_SO_ts40(BIST_SO_ts40), .BIST_SO_ts41(BIST_SO_ts41), .BIST_SO_ts42(BIST_SO_ts42), 
 .BIST_SO_ts43(BIST_SO_ts43), .BIST_GO(BIST_GO), .BIST_GO_ts1(BIST_GO_ts1), 
 .BIST_GO_ts2(BIST_GO_ts2), .BIST_GO_ts3(BIST_GO_ts3), .BIST_GO_ts4(BIST_GO_ts4), 
 .BIST_GO_ts5(BIST_GO_ts5), .BIST_GO_ts6(BIST_GO_ts6), .BIST_GO_ts7(BIST_GO_ts7), 
 .BIST_GO_ts8(BIST_GO_ts8), .BIST_GO_ts9(BIST_GO_ts9), .BIST_GO_ts10(BIST_GO_ts10), 
 .BIST_GO_ts11(BIST_GO_ts11), .BIST_GO_ts12(BIST_GO_ts12), .BIST_GO_ts13(BIST_GO_ts13), 
 .BIST_GO_ts14(BIST_GO_ts14), .BIST_GO_ts15(BIST_GO_ts15), .BIST_GO_ts16(BIST_GO_ts16), 
 .BIST_GO_ts17(BIST_GO_ts17), .BIST_GO_ts18(BIST_GO_ts18), .BIST_GO_ts19(BIST_GO_ts19), 
 .BIST_GO_ts20(BIST_GO_ts20), .BIST_GO_ts21(BIST_GO_ts21), .BIST_GO_ts22(BIST_GO_ts22), 
 .BIST_GO_ts23(BIST_GO_ts23), .BIST_GO_ts24(BIST_GO_ts24), .BIST_GO_ts25(BIST_GO_ts25), 
 .BIST_GO_ts26(BIST_GO_ts26), .BIST_GO_ts27(BIST_GO_ts27), .BIST_GO_ts28(BIST_GO_ts28), 
 .BIST_GO_ts29(BIST_GO_ts29), .BIST_GO_ts30(BIST_GO_ts30), .BIST_GO_ts31(BIST_GO_ts31), 
 .BIST_GO_ts32(BIST_GO_ts32), .BIST_GO_ts33(BIST_GO_ts33), .BIST_GO_ts34(BIST_GO_ts34), 
 .BIST_GO_ts35(BIST_GO_ts35), .BIST_GO_ts36(BIST_GO_ts36), .BIST_GO_ts37(BIST_GO_ts37), 
 .BIST_GO_ts38(BIST_GO_ts38), .BIST_GO_ts39(BIST_GO_ts39), .BIST_GO_ts40(BIST_GO_ts40), 
 .BIST_GO_ts41(BIST_GO_ts41), .BIST_GO_ts42(BIST_GO_ts42), .BIST_GO_ts43(BIST_GO_ts43), 
 .ltest_to_en(ltest_to_en_ts1), .BIST_READENABLE(BIST_READENABLE), 
 .BIST_WRITEENABLE(BIST_WRITEENABLE), .BIST_READENABLE_ts1(BIST_READENABLE_ts1), 
 .BIST_WRITEENABLE_ts1(BIST_WRITEENABLE_ts1), .BIST_READENABLE_ts2(BIST_READENABLE_ts2), 
 .BIST_WRITEENABLE_ts2(BIST_WRITEENABLE_ts2), .BIST_READENABLE_ts3(BIST_READENABLE_ts3), 
 .BIST_WRITEENABLE_ts3(BIST_WRITEENABLE_ts3), .BIST_READENABLE_ts4(BIST_READENABLE_ts4), 
 .BIST_WRITEENABLE_ts4(BIST_WRITEENABLE_ts4), .BIST_READENABLE_ts5(BIST_READENABLE_ts5), 
 .BIST_WRITEENABLE_ts5(BIST_WRITEENABLE_ts5), .BIST_CMP(BIST_CMP), 
 .BIST_CMP_ts1(BIST_CMP_ts1), .BIST_CMP_ts2(BIST_CMP_ts2), .BIST_CMP_ts3(BIST_CMP_ts3), 
 .BIST_CMP_ts4(BIST_CMP_ts4), .BIST_CMP_ts5(BIST_CMP_ts5), 
 .INCLUDE_MEM_RESULTS_REG(INCLUDE_MEM_RESULTS_REG), .BIST_ROW_ADD(BIST_ROW_ADD), 
 .BIST_ROW_ADD_ts1(BIST_ROW_ADD_ts1[3:0]), .BIST_ROW_ADD_ts2(BIST_ROW_ADD_ts2[0]), 
 .BIST_ROW_ADD_ts3(BIST_ROW_ADD_ts2[1]), .BIST_ROW_ADD_ts4(BIST_ROW_ADD_ts2[2]), 
 .BIST_ROW_ADD_ts5(BIST_ROW_ADD_ts2[3]), .BIST_ROW_ADD_ts6(BIST_ROW_ADD_ts2[4]), 
 .BIST_ROW_ADD_ts7(BIST_ROW_ADD_ts3[0]), .BIST_ROW_ADD_ts8(BIST_ROW_ADD_ts3[1]), 
 .BIST_ROW_ADD_ts9(BIST_ROW_ADD_ts3[2]), .BIST_ROW_ADD_ts10(BIST_ROW_ADD_ts4[4:0]), 
 .BIST_ROW_ADD_ts11(BIST_ROW_ADD_ts5[4:0]), .BIST_COLLAR_EN0(BIST_COLLAR_EN0), 
 .BIST_COLLAR_EN0_ts1(BIST_COLLAR_EN0_ts1), .BIST_COLLAR_EN1(BIST_COLLAR_EN1), 
 .BIST_COLLAR_EN2(BIST_COLLAR_EN2), .BIST_COLLAR_EN3(BIST_COLLAR_EN3), 
 .BIST_COLLAR_EN4(BIST_COLLAR_EN4), .BIST_COLLAR_EN0_ts2(BIST_COLLAR_EN0_ts2), 
 .BIST_COLLAR_EN1_ts1(BIST_COLLAR_EN1_ts1), .BIST_COLLAR_EN2_ts1(BIST_COLLAR_EN2_ts1), 
 .BIST_COLLAR_EN3_ts1(BIST_COLLAR_EN3_ts1), .BIST_COLLAR_EN4_ts1(BIST_COLLAR_EN4_ts1), 
 .BIST_COLLAR_EN5(BIST_COLLAR_EN5), .BIST_COLLAR_EN6(BIST_COLLAR_EN6), 
 .BIST_COLLAR_EN7(BIST_COLLAR_EN7), .BIST_COLLAR_EN8(BIST_COLLAR_EN8), 
 .BIST_COLLAR_EN9(BIST_COLLAR_EN9), .BIST_COLLAR_EN10(BIST_COLLAR_EN10), 
 .BIST_COLLAR_EN11(BIST_COLLAR_EN11), .BIST_COLLAR_EN12(BIST_COLLAR_EN12), 
 .BIST_COLLAR_EN13(BIST_COLLAR_EN13), .BIST_COLLAR_EN14(BIST_COLLAR_EN14), 
 .BIST_COLLAR_EN15(BIST_COLLAR_EN15), .BIST_COLLAR_EN16(BIST_COLLAR_EN16), 
 .BIST_COLLAR_EN17(BIST_COLLAR_EN17), .BIST_COLLAR_EN18(BIST_COLLAR_EN18), 
 .BIST_COLLAR_EN19(BIST_COLLAR_EN19), .BIST_COLLAR_EN20(BIST_COLLAR_EN20), 
 .BIST_COLLAR_EN21(BIST_COLLAR_EN21), .BIST_COLLAR_EN22(BIST_COLLAR_EN22), 
 .BIST_COLLAR_EN23(BIST_COLLAR_EN23), .BIST_COLLAR_EN24(BIST_COLLAR_EN24), 
 .BIST_COLLAR_EN25(BIST_COLLAR_EN25), .BIST_COLLAR_EN26(BIST_COLLAR_EN26), 
 .BIST_COLLAR_EN27(BIST_COLLAR_EN27), .BIST_COLLAR_EN0_ts3(BIST_COLLAR_EN0_ts3), 
 .BIST_COLLAR_EN1_ts2(BIST_COLLAR_EN1_ts2), .BIST_COLLAR_EN2_ts2(BIST_COLLAR_EN2_ts2), 
 .BIST_COLLAR_EN3_ts2(BIST_COLLAR_EN3_ts2), .BIST_COLLAR_EN0_ts4(BIST_COLLAR_EN0_ts4), 
 .BIST_COLLAR_EN1_ts3(BIST_COLLAR_EN1_ts3), .BIST_COLLAR_EN2_ts3(BIST_COLLAR_EN2_ts3), 
 .BIST_COLLAR_EN3_ts3(BIST_COLLAR_EN3_ts3), .BIST_COLLAR_EN0_ts5(BIST_COLLAR_EN0_ts5), 
 .BIST_COLLAR_EN1_ts4(BIST_COLLAR_EN1_ts4), .BIST_RUN_TO_COLLAR0(BIST_RUN_TO_COLLAR0), 
 .BIST_RUN_TO_COLLAR0_ts1(BIST_RUN_TO_COLLAR0_ts1), .BIST_RUN_TO_COLLAR1(BIST_RUN_TO_COLLAR1), 
 .BIST_RUN_TO_COLLAR2(BIST_RUN_TO_COLLAR2), .BIST_RUN_TO_COLLAR3(BIST_RUN_TO_COLLAR3), 
 .BIST_RUN_TO_COLLAR4(BIST_RUN_TO_COLLAR4), .BIST_RUN_TO_COLLAR0_ts2(BIST_RUN_TO_COLLAR0_ts2), 
 .BIST_RUN_TO_COLLAR1_ts1(BIST_RUN_TO_COLLAR1_ts1), .BIST_RUN_TO_COLLAR2_ts1(BIST_RUN_TO_COLLAR2_ts1), 
 .BIST_RUN_TO_COLLAR3_ts1(BIST_RUN_TO_COLLAR3_ts1), .BIST_RUN_TO_COLLAR4_ts1(BIST_RUN_TO_COLLAR4_ts1), 
 .BIST_RUN_TO_COLLAR5(BIST_RUN_TO_COLLAR5), .BIST_RUN_TO_COLLAR6(BIST_RUN_TO_COLLAR6), 
 .BIST_RUN_TO_COLLAR7(BIST_RUN_TO_COLLAR7), .BIST_RUN_TO_COLLAR8(BIST_RUN_TO_COLLAR8), 
 .BIST_RUN_TO_COLLAR9(BIST_RUN_TO_COLLAR9), .BIST_RUN_TO_COLLAR10(BIST_RUN_TO_COLLAR10), 
 .BIST_RUN_TO_COLLAR11(BIST_RUN_TO_COLLAR11), .BIST_RUN_TO_COLLAR12(BIST_RUN_TO_COLLAR12), 
 .BIST_RUN_TO_COLLAR13(BIST_RUN_TO_COLLAR13), .BIST_RUN_TO_COLLAR14(BIST_RUN_TO_COLLAR14), 
 .BIST_RUN_TO_COLLAR15(BIST_RUN_TO_COLLAR15), .BIST_RUN_TO_COLLAR16(BIST_RUN_TO_COLLAR16), 
 .BIST_RUN_TO_COLLAR17(BIST_RUN_TO_COLLAR17), .BIST_RUN_TO_COLLAR18(BIST_RUN_TO_COLLAR18), 
 .BIST_RUN_TO_COLLAR19(BIST_RUN_TO_COLLAR19), .BIST_RUN_TO_COLLAR20(BIST_RUN_TO_COLLAR20), 
 .BIST_RUN_TO_COLLAR21(BIST_RUN_TO_COLLAR21), .BIST_RUN_TO_COLLAR22(BIST_RUN_TO_COLLAR22), 
 .BIST_RUN_TO_COLLAR23(BIST_RUN_TO_COLLAR23), .BIST_RUN_TO_COLLAR24(BIST_RUN_TO_COLLAR24), 
 .BIST_RUN_TO_COLLAR25(BIST_RUN_TO_COLLAR25), .BIST_RUN_TO_COLLAR26(BIST_RUN_TO_COLLAR26), 
 .BIST_RUN_TO_COLLAR27(BIST_RUN_TO_COLLAR27), .BIST_RUN_TO_COLLAR0_ts3(BIST_RUN_TO_COLLAR0_ts3), 
 .BIST_RUN_TO_COLLAR1_ts2(BIST_RUN_TO_COLLAR1_ts2), .BIST_RUN_TO_COLLAR2_ts2(BIST_RUN_TO_COLLAR2_ts2), 
 .BIST_RUN_TO_COLLAR3_ts2(BIST_RUN_TO_COLLAR3_ts2), .BIST_RUN_TO_COLLAR0_ts4(BIST_RUN_TO_COLLAR0_ts4), 
 .BIST_RUN_TO_COLLAR1_ts3(BIST_RUN_TO_COLLAR1_ts3), .BIST_RUN_TO_COLLAR2_ts3(BIST_RUN_TO_COLLAR2_ts3), 
 .BIST_RUN_TO_COLLAR3_ts3(BIST_RUN_TO_COLLAR3_ts3), .BIST_RUN_TO_COLLAR0_ts5(BIST_RUN_TO_COLLAR0_ts5), 
 .BIST_RUN_TO_COLLAR1_ts4(BIST_RUN_TO_COLLAR1_ts4), .BIST_ASYNC_RESET(BIST_ASYNC_RESET), 
 .BIST_SHADOW_READENABLE(BIST_SHADOW_READENABLE), .BIST_SHADOW_READADDRESS(BIST_SHADOW_READADDRESS), 
 .BIST_SHADOW_READENABLE_ts1(BIST_SHADOW_READENABLE_ts1), 
 .BIST_SHADOW_READADDRESS_ts1(BIST_SHADOW_READADDRESS_ts1), 
 .BIST_SHADOW_READENABLE_ts2(BIST_SHADOW_READENABLE_ts2), 
 .BIST_SHADOW_READADDRESS_ts2(BIST_SHADOW_READADDRESS_ts2), 
 .BIST_SHADOW_READENABLE_ts3(BIST_SHADOW_READENABLE_ts3), 
 .BIST_SHADOW_READADDRESS_ts3(BIST_SHADOW_READADDRESS_ts3), 
 .BIST_SHADOW_READENABLE_ts4(BIST_SHADOW_READENABLE_ts4), 
 .BIST_SHADOW_READADDRESS_ts4(BIST_SHADOW_READADDRESS_ts4), 
 .BIST_SHADOW_READENABLE_ts5(BIST_SHADOW_READENABLE_ts5), 
 .BIST_SHADOW_READADDRESS_ts5(BIST_SHADOW_READADDRESS_ts5), 
 .BIST_CONWRITE_ROWADDRESS(BIST_CONWRITE_ROWADDRESS), .BIST_CONWRITE_ENABLE(BIST_CONWRITE_ENABLE), 
 .BIST_CONWRITE_ROWADDRESS_ts1(BIST_CONWRITE_ROWADDRESS_ts1), 
 .BIST_CONWRITE_ENABLE_ts1(BIST_CONWRITE_ENABLE_ts1), 
 .BIST_CONWRITE_ROWADDRESS_ts2(BIST_CONWRITE_ROWADDRESS_ts2), 
 .BIST_CONWRITE_ENABLE_ts2(BIST_CONWRITE_ENABLE_ts2), 
 .BIST_CONWRITE_ROWADDRESS_ts3(BIST_CONWRITE_ROWADDRESS_ts3), 
 .BIST_CONWRITE_ENABLE_ts3(BIST_CONWRITE_ENABLE_ts3), 
 .BIST_CONWRITE_ROWADDRESS_ts4(BIST_CONWRITE_ROWADDRESS_ts4), 
 .BIST_CONWRITE_ENABLE_ts4(BIST_CONWRITE_ENABLE_ts4), 
 .BIST_CONWRITE_ROWADDRESS_ts5(BIST_CONWRITE_ROWADDRESS_ts5), 
 .BIST_CONWRITE_ENABLE_ts5(BIST_CONWRITE_ENABLE_ts5), 
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
 .BIST_CONREAD_ROWADDRESS_ts4(BIST_CONREAD_ROWADDRESS_ts4), 
 .BIST_CONREAD_COLUMNADDRESS_ts4(BIST_CONREAD_COLUMNADDRESS_ts4), 
 .BIST_CONREAD_ENABLE_ts4(BIST_CONREAD_ENABLE_ts4), 
 .BIST_CONREAD_ROWADDRESS_ts5(BIST_CONREAD_ROWADDRESS_ts5), 
 .BIST_CONREAD_COLUMNADDRESS_ts5(BIST_CONREAD_COLUMNADDRESS_ts5), 
 .BIST_CONREAD_ENABLE_ts5(BIST_CONREAD_ENABLE_ts5), 
 .BIST_TESTDATA_SELECT_TO_COLLAR(BIST_TESTDATA_SELECT_TO_COLLAR), 
 .BIST_TESTDATA_SELECT_TO_COLLAR_ts1(BIST_TESTDATA_SELECT_TO_COLLAR_ts1), 
 .BIST_TESTDATA_SELECT_TO_COLLAR_ts2(BIST_TESTDATA_SELECT_TO_COLLAR_ts2), 
 .BIST_TESTDATA_SELECT_TO_COLLAR_ts3(BIST_TESTDATA_SELECT_TO_COLLAR_ts3), 
 .BIST_TESTDATA_SELECT_TO_COLLAR_ts4(BIST_TESTDATA_SELECT_TO_COLLAR_ts4), 
 .BIST_TESTDATA_SELECT_TO_COLLAR_ts5(BIST_TESTDATA_SELECT_TO_COLLAR_ts5), 
 .BIST_ON_TO_COLLAR(BIST_ON_TO_COLLAR), .BIST_ON_TO_COLLAR_ts1(BIST_ON_TO_COLLAR_ts1), 
 .BIST_ON_TO_COLLAR_ts2(BIST_ON_TO_COLLAR_ts2), .BIST_ON_TO_COLLAR_ts3(BIST_ON_TO_COLLAR_ts3), 
 .BIST_ON_TO_COLLAR_ts4(BIST_ON_TO_COLLAR_ts4), .BIST_ON_TO_COLLAR_ts5(BIST_ON_TO_COLLAR_ts5), 
 .BIST_WRITE_DATA(BIST_WRITE_DATA), .BIST_WRITE_DATA_ts1(BIST_WRITE_DATA_ts1[7:0]), 
 .BIST_WRITE_DATA_ts2(BIST_WRITE_DATA_ts2[0]), .BIST_WRITE_DATA_ts3(BIST_WRITE_DATA_ts2[1]), 
 .BIST_WRITE_DATA_ts4(BIST_WRITE_DATA_ts2[2]), .BIST_WRITE_DATA_ts5(BIST_WRITE_DATA_ts2[3]), 
 .BIST_WRITE_DATA_ts6(BIST_WRITE_DATA_ts2[4]), .BIST_WRITE_DATA_ts7(BIST_WRITE_DATA_ts2[5]), 
 .BIST_WRITE_DATA_ts8(BIST_WRITE_DATA_ts2[6]), .BIST_WRITE_DATA_ts9(BIST_WRITE_DATA_ts2[7]), 
 .BIST_WRITE_DATA_ts10(BIST_WRITE_DATA_ts3[0]), .BIST_WRITE_DATA_ts11(BIST_WRITE_DATA_ts3[1]), 
 .BIST_WRITE_DATA_ts12(BIST_WRITE_DATA_ts3[2]), .BIST_WRITE_DATA_ts13(BIST_WRITE_DATA_ts3[3]), 
 .BIST_WRITE_DATA_ts14(BIST_WRITE_DATA_ts3[4]), .BIST_WRITE_DATA_ts15(BIST_WRITE_DATA_ts3[5]), 
 .BIST_WRITE_DATA_ts16(BIST_WRITE_DATA_ts3[6]), .BIST_WRITE_DATA_ts17(BIST_WRITE_DATA_ts3[7]), 
 .BIST_WRITE_DATA_ts18(BIST_WRITE_DATA_ts4[7:0]), .BIST_WRITE_DATA_ts19(BIST_WRITE_DATA_ts5[7:0]), 
 .BIST_EXPECT_DATA(BIST_EXPECT_DATA), .BIST_EXPECT_DATA_ts1(BIST_EXPECT_DATA_ts1[7:0]), 
 .BIST_EXPECT_DATA_ts2(BIST_EXPECT_DATA_ts2[0]), .BIST_EXPECT_DATA_ts3(BIST_EXPECT_DATA_ts2[1]), 
 .BIST_EXPECT_DATA_ts4(BIST_EXPECT_DATA_ts2[2]), .BIST_EXPECT_DATA_ts5(BIST_EXPECT_DATA_ts2[3]), 
 .BIST_EXPECT_DATA_ts6(BIST_EXPECT_DATA_ts2[4]), .BIST_EXPECT_DATA_ts7(BIST_EXPECT_DATA_ts2[5]), 
 .BIST_EXPECT_DATA_ts8(BIST_EXPECT_DATA_ts2[6]), .BIST_EXPECT_DATA_ts9(BIST_EXPECT_DATA_ts2[7]), 
 .BIST_EXPECT_DATA_ts10(BIST_EXPECT_DATA_ts3[0]), .BIST_EXPECT_DATA_ts11(BIST_EXPECT_DATA_ts3[1]), 
 .BIST_EXPECT_DATA_ts12(BIST_EXPECT_DATA_ts3[2]), .BIST_EXPECT_DATA_ts13(BIST_EXPECT_DATA_ts3[3]), 
 .BIST_EXPECT_DATA_ts14(BIST_EXPECT_DATA_ts3[4]), .BIST_EXPECT_DATA_ts15(BIST_EXPECT_DATA_ts3[5]), 
 .BIST_EXPECT_DATA_ts16(BIST_EXPECT_DATA_ts3[6]), .BIST_EXPECT_DATA_ts17(BIST_EXPECT_DATA_ts3[7]), 
 .BIST_EXPECT_DATA_ts18(BIST_EXPECT_DATA_ts4[7:0]), .BIST_EXPECT_DATA_ts19(BIST_EXPECT_DATA_ts5[7:0]), 
 .BIST_SHIFT_COLLAR(BIST_SHIFT_COLLAR), .BIST_SHIFT_COLLAR_ts1(BIST_SHIFT_COLLAR_ts1), 
 .BIST_SHIFT_COLLAR_ts2(BIST_SHIFT_COLLAR_ts2), .BIST_SHIFT_COLLAR_ts3(BIST_SHIFT_COLLAR_ts3), 
 .BIST_SHIFT_COLLAR_ts4(BIST_SHIFT_COLLAR_ts4), .BIST_SHIFT_COLLAR_ts5(BIST_SHIFT_COLLAR_ts5), 
 .BIST_COLLAR_SETUP(BIST_COLLAR_SETUP), .BIST_COLLAR_SETUP_ts1(BIST_COLLAR_SETUP_ts1), 
 .BIST_COLLAR_SETUP_ts2(BIST_COLLAR_SETUP_ts2), .BIST_COLLAR_SETUP_ts3(BIST_COLLAR_SETUP_ts3), 
 .BIST_COLLAR_SETUP_ts4(BIST_COLLAR_SETUP_ts4), .BIST_COLLAR_SETUP_ts5(BIST_COLLAR_SETUP_ts5), 
 .BIST_CLEAR_DEFAULT(BIST_CLEAR_DEFAULT), .BIST_CLEAR_DEFAULT_ts1(BIST_CLEAR_DEFAULT_ts1), 
 .BIST_CLEAR_DEFAULT_ts2(BIST_CLEAR_DEFAULT_ts2), .BIST_CLEAR_DEFAULT_ts3(BIST_CLEAR_DEFAULT_ts3), 
 .BIST_CLEAR_DEFAULT_ts4(BIST_CLEAR_DEFAULT_ts4), .BIST_CLEAR_DEFAULT_ts5(BIST_CLEAR_DEFAULT_ts5), 
 .BIST_CLEAR(BIST_CLEAR), .BIST_CLEAR_ts1(BIST_CLEAR_ts1), .BIST_CLEAR_ts2(BIST_CLEAR_ts2), 
 .BIST_CLEAR_ts3(BIST_CLEAR_ts3), .BIST_CLEAR_ts4(BIST_CLEAR_ts4), 
 .BIST_CLEAR_ts5(BIST_CLEAR_ts5), .BIST_COLLAR_OPSET_SELECT(BIST_COLLAR_OPSET_SELECT), 
 .BIST_COLLAR_OPSET_SELECT_ts1(BIST_COLLAR_OPSET_SELECT_ts1), 
 .BIST_COLLAR_OPSET_SELECT_ts2(BIST_COLLAR_OPSET_SELECT_ts2), 
 .BIST_COLLAR_OPSET_SELECT_ts3(BIST_COLLAR_OPSET_SELECT_ts3), 
 .BIST_COLLAR_OPSET_SELECT_ts4(BIST_COLLAR_OPSET_SELECT_ts4), 
 .BIST_COLLAR_OPSET_SELECT_ts5(BIST_COLLAR_OPSET_SELECT_ts5), 
 .BIST_COLLAR_HOLD(BIST_COLLAR_HOLD), .FREEZE_STOP_ERROR(FREEZE_STOP_ERROR), 
 .ERROR_CNT_ZERO(ERROR_CNT_ZERO), .BIST_COLLAR_HOLD_ts1(BIST_COLLAR_HOLD_ts1), 
 .FREEZE_STOP_ERROR_ts1(FREEZE_STOP_ERROR_ts1), .ERROR_CNT_ZERO_ts1(ERROR_CNT_ZERO_ts1), 
 .BIST_COLLAR_HOLD_ts2(BIST_COLLAR_HOLD_ts2), .FREEZE_STOP_ERROR_ts2(FREEZE_STOP_ERROR_ts2), 
 .ERROR_CNT_ZERO_ts2(ERROR_CNT_ZERO_ts2), .BIST_COLLAR_HOLD_ts3(BIST_COLLAR_HOLD_ts3), 
 .FREEZE_STOP_ERROR_ts3(FREEZE_STOP_ERROR_ts3), .ERROR_CNT_ZERO_ts3(ERROR_CNT_ZERO_ts3), 
 .BIST_COLLAR_HOLD_ts4(BIST_COLLAR_HOLD_ts4), .FREEZE_STOP_ERROR_ts4(FREEZE_STOP_ERROR_ts4), 
 .ERROR_CNT_ZERO_ts4(ERROR_CNT_ZERO_ts4), .BIST_COLLAR_HOLD_ts5(BIST_COLLAR_HOLD_ts5), 
 .FREEZE_STOP_ERROR_ts5(FREEZE_STOP_ERROR_ts5), .ERROR_CNT_ZERO_ts5(ERROR_CNT_ZERO_ts5), 
 .MBISTPG_RESET_REG_SETUP2(MBISTPG_RESET_REG_SETUP2), 
 .MBISTPG_RESET_REG_SETUP2_ts1(MBISTPG_RESET_REG_SETUP2_ts1), 
 .MBISTPG_RESET_REG_SETUP2_ts2(MBISTPG_RESET_REG_SETUP2_ts2), 
 .MBISTPG_RESET_REG_SETUP2_ts3(MBISTPG_RESET_REG_SETUP2_ts3), 
 .MBISTPG_RESET_REG_SETUP2_ts4(MBISTPG_RESET_REG_SETUP2_ts4), 
 .MBISTPG_RESET_REG_SETUP2_ts5(MBISTPG_RESET_REG_SETUP2_ts5), .BIST_COL_ADD(BIST_COL_ADD), 
 .BIST_COL_ADD_ts1(BIST_COL_ADD_ts1), .BIST_COL_ADD_ts2(BIST_COL_ADD_ts2), 
 .BIST_BANK_ADD(BIST_BANK_ADD[0]), .BIST_BANK_ADD_ts1(BIST_BANK_ADD[1]), 
 .BIST_BANK_ADD_ts2(BIST_BANK_ADD_ts1[1:0]), .bisr_shift_en_pd_vinf(bisr_shift_en_pd_vinf), 
 .bisr_clk_pd_vinf(bisr_clk_pd_vinf), .bisr_reset_pd_vinf(bisr_reset_pd_vinf), 
 .bisr_si_pd_vinf(bisr_si_pd_vinf), .ram_row_0_col_0_bisr_inst_SO(bisr_so_pd_vinf), 
 .fscan_clkungate_ts1(fscan_clkungate));

/*
 hlp_msec_apr_func_logic AUTO_TEMPLATE
 (
   .o_gclk       (gclk[]),
   .o_tom_\(.*\) (tom_\1[][]),
   .i_frm_\(.*\) (frm_\1[][]),
   .i_disable       (i_msec_disable),
   .powergood_rst_n (local_powergood_rst_n),
   .mem_rst_n       (local_mem_rst_n) );
*/
hlp_msec_apr_func_logic u_msec_apr_func_logic
( .fet_ack_b(fet_ack_b_to_rf),
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
 .ascan_preclk_div4_clk                 (ascan_preclk_div4_clk),
 .ascan_sdo                             (ascan_sdo[hlp_dfx_pkg::MSEC_NUM_SDO-1:0]),
 .o_gclk                                (gclk),                  // Templated
 .o_msec_mac_rx_e                       (o_msec_mac_rx_e),
 .o_msec_mac_tx                         (o_msec_mac_tx),
 .o_msec_mac_tx_v                       (o_msec_mac_tx_v),
 .o_msec_switch_rx                      (o_msec_switch_rx),
 .o_msec_switch_rx_v                    (o_msec_switch_rx_v),
 .o_msec_switch_tx_e                    (o_msec_switch_tx_e),
 .o_msec_zeroize_done                   (o_msec_zeroize_done),
 .o_rpl_bkwd                            (o_rpl_bkwd),
 .o_rpl_frwd                            (o_rpl_frwd),
 .o_tom_msec_rx_eop_class_mem           (tom_msec_rx_eop_class_mem[`HLP_MSEC_MSEC_RX_EOP_CLASS_MEM_TO_MEM_WIDTH-1:0]), // Templated
 .o_tom_msec_rx_ibuf_mem                (tom_msec_rx_ibuf_mem[`HLP_MSEC_MSEC_RX_IBUF_MEM_TO_MEM_WIDTH-1:0]), // Templated
 .o_tom_msec_rx_key_mem_0               (tom_msec_rx_key_mem_0[`HLP_MSEC_MSEC_RX_KEY_MEM_TO_MEM_WIDTH-1:0]), // Templated
 .o_tom_msec_rx_key_mem_1               (tom_msec_rx_key_mem_1[`HLP_MSEC_MSEC_RX_KEY_MEM_TO_MEM_WIDTH-1:0]), // Templated
 .o_tom_msec_rx_key_ptr_mem             (tom_msec_rx_key_ptr_mem[`HLP_MSEC_MSEC_RX_KEY_PTR_MEM_TO_MEM_WIDTH-1:0]), // Templated
 .o_tom_msec_rx_lowest_pn_mem_0         (tom_msec_rx_lowest_pn_mem_0[`HLP_MSEC_MSEC_RX_LOWEST_PN_MEM_TO_MEM_WIDTH-1:0]), // Templated
 .o_tom_msec_rx_lowest_pn_mem_1         (tom_msec_rx_lowest_pn_mem_1[`HLP_MSEC_MSEC_RX_LOWEST_PN_MEM_TO_MEM_WIDTH-1:0]), // Templated
 .o_tom_msec_rx_next_pn_mem_0           (tom_msec_rx_next_pn_mem_0[`HLP_MSEC_MSEC_RX_NEXT_PN_MEM_TO_MEM_WIDTH-1:0]), // Templated
 .o_tom_msec_rx_next_pn_mem_1           (tom_msec_rx_next_pn_mem_1[`HLP_MSEC_MSEC_RX_NEXT_PN_MEM_TO_MEM_WIDTH-1:0]), // Templated
 .o_tom_msec_rx_obuf_mem                (tom_msec_rx_obuf_mem[`HLP_MSEC_MSEC_RX_OBUF_MEM_TO_MEM_WIDTH-1:0]), // Templated
 .o_tom_msec_rx_pkt_cnt_mem_0           (tom_msec_rx_pkt_cnt_mem_0[`HLP_MSEC_MSEC_RX_PKT_CNT_MEM_TO_MEM_WIDTH-1:0]), // Templated
 .o_tom_msec_rx_pkt_cnt_mem_1           (tom_msec_rx_pkt_cnt_mem_1[`HLP_MSEC_MSEC_RX_PKT_CNT_MEM_TO_MEM_WIDTH-1:0]), // Templated
 .o_tom_msec_rx_salt_mem_0              (tom_msec_rx_salt_mem_0[`HLP_MSEC_MSEC_RX_SALT_MEM_TO_MEM_WIDTH-1:0]), // Templated
 .o_tom_msec_rx_salt_mem_1              (tom_msec_rx_salt_mem_1[`HLP_MSEC_MSEC_RX_SALT_MEM_TO_MEM_WIDTH-1:0]), // Templated
 .o_tom_msec_rx_salt_mem_2              (tom_msec_rx_salt_mem_2[`HLP_MSEC_MSEC_RX_SALT_MEM_TO_MEM_WIDTH-1:0]), // Templated
 .o_tom_msec_rx_sc_vlan_tag_ctrl        (tom_msec_rx_sc_vlan_tag_ctrl[`HLP_MSEC_MSEC_RX_SC_VLAN_TAG_CTRL_TO_MEM_WIDTH-1:0]), // Templated
 .o_tom_msec_rx_ssci_mem                (tom_msec_rx_ssci_mem[`HLP_MSEC_MSEC_RX_SSCI_MEM_TO_MEM_WIDTH-1:0]), // Templated
 .o_tom_msec_tx_ibuf_mem                (tom_msec_tx_ibuf_mem[`HLP_MSEC_MSEC_TX_IBUF_MEM_TO_MEM_WIDTH-1:0]), // Templated
 .o_tom_msec_tx_key_mem_0               (tom_msec_tx_key_mem_0[`HLP_MSEC_MSEC_TX_KEY_MEM_TO_MEM_WIDTH-1:0]), // Templated
 .o_tom_msec_tx_key_mem_1               (tom_msec_tx_key_mem_1[`HLP_MSEC_MSEC_TX_KEY_MEM_TO_MEM_WIDTH-1:0]), // Templated
 .o_tom_msec_tx_key_ptr_mem             (tom_msec_tx_key_ptr_mem[`HLP_MSEC_MSEC_TX_KEY_PTR_MEM_TO_MEM_WIDTH-1:0]), // Templated
 .o_tom_msec_tx_next_pn_mem_0           (tom_msec_tx_next_pn_mem_0[`HLP_MSEC_MSEC_TX_NEXT_PN_MEM_TO_MEM_WIDTH-1:0]), // Templated
 .o_tom_msec_tx_next_pn_mem_1           (tom_msec_tx_next_pn_mem_1[`HLP_MSEC_MSEC_TX_NEXT_PN_MEM_TO_MEM_WIDTH-1:0]), // Templated
 .o_tom_msec_tx_obuf_mem                (tom_msec_tx_obuf_mem[`HLP_MSEC_MSEC_TX_OBUF_MEM_TO_MEM_WIDTH-1:0]), // Templated
 .o_tom_msec_tx_pkt_cnt_mem_0           (tom_msec_tx_pkt_cnt_mem_0[`HLP_MSEC_MSEC_TX_PKT_CNT_MEM_TO_MEM_WIDTH-1:0]), // Templated
 .o_tom_msec_tx_pkt_cnt_mem_1           (tom_msec_tx_pkt_cnt_mem_1[`HLP_MSEC_MSEC_TX_PKT_CNT_MEM_TO_MEM_WIDTH-1:0]), // Templated
 .o_tom_msec_tx_salt_mem_0              (tom_msec_tx_salt_mem_0[`HLP_MSEC_MSEC_TX_SALT_MEM_TO_MEM_WIDTH-1:0]), // Templated
 .o_tom_msec_tx_salt_mem_1              (tom_msec_tx_salt_mem_1[`HLP_MSEC_MSEC_TX_SALT_MEM_TO_MEM_WIDTH-1:0]), // Templated
 .o_tom_msec_tx_salt_mem_2              (tom_msec_tx_salt_mem_2[`HLP_MSEC_MSEC_TX_SALT_MEM_TO_MEM_WIDTH-1:0]), // Templated
 .o_tom_msec_tx_sc_vlan_tag_ctrl        (tom_msec_tx_sc_vlan_tag_ctrl[`HLP_MSEC_MSEC_TX_SC_VLAN_TAG_CTRL_TO_MEM_WIDTH-1:0]), // Templated
 .o_tom_msec_tx_sci_mem_0               (tom_msec_tx_sci_mem_0[`HLP_MSEC_MSEC_TX_SCI_MEM_TO_MEM_WIDTH-1:0]), // Templated
 .o_tom_msec_tx_sci_mem_1               (tom_msec_tx_sci_mem_1[`HLP_MSEC_MSEC_TX_SCI_MEM_TO_MEM_WIDTH-1:0]), // Templated
 .o_tom_msec_tx_ssci_mem                (tom_msec_tx_ssci_mem[`HLP_MSEC_MSEC_TX_SSCI_MEM_TO_MEM_WIDTH-1:0]), // Templated
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
 .fscan_clkungate                       (fscan_clkungate_out),
 .fscan_clkungate_syn                   (fscan_clkungate_syn),
 .fscan_mode                            (fscan_mode),
 .fscan_mode_atspeed                    (fscan_mode_atspeed),
 .fscan_clkgenctrl                      (fscan_clkgenctrl[hlp_dfx_pkg::MSEC_NUM_CLKGENCTRL-1:0]),
 .fscan_clkgenctrlen                    (fscan_clkgenctrlen[hlp_dfx_pkg::MSEC_NUM_CLKGENCTRLEN-1:0]),
 .fscan_sdi                             (fscan_sdi[hlp_dfx_pkg::MSEC_NUM_SDI-1:0]),
 .fscan_postclk_div4_clk                (fscan_postclk_div4_clk),
 .clk                                   (clk_ts1),
 .fscan_byprst_b                        (fscan_byprst_b),
 .fscan_rstbypen                        (fscan_rstbypen),
 .i_disable                             (i_msec_disable),        // Templated
 .i_force_clk_en                        (i_force_clk_en),
 .i_frm_msec_rx_eop_class_mem           (frm_msec_rx_eop_class_mem[`HLP_MSEC_MSEC_RX_EOP_CLASS_MEM_FROM_MEM_WIDTH-1:0]), // Templated
 .i_frm_msec_rx_ibuf_mem                (frm_msec_rx_ibuf_mem[`HLP_MSEC_MSEC_RX_IBUF_MEM_FROM_MEM_WIDTH-1:0]), // Templated
 .i_frm_msec_rx_key_mem_0               (frm_msec_rx_key_mem_0[`HLP_MSEC_MSEC_RX_KEY_MEM_FROM_MEM_WIDTH-1:0]), // Templated
 .i_frm_msec_rx_key_mem_1               (frm_msec_rx_key_mem_1[`HLP_MSEC_MSEC_RX_KEY_MEM_FROM_MEM_WIDTH-1:0]), // Templated
 .i_frm_msec_rx_key_ptr_mem             (frm_msec_rx_key_ptr_mem[`HLP_MSEC_MSEC_RX_KEY_PTR_MEM_FROM_MEM_WIDTH-1:0]), // Templated
 .i_frm_msec_rx_lowest_pn_mem_0         (frm_msec_rx_lowest_pn_mem_0[`HLP_MSEC_MSEC_RX_LOWEST_PN_MEM_FROM_MEM_WIDTH-1:0]), // Templated
 .i_frm_msec_rx_lowest_pn_mem_1         (frm_msec_rx_lowest_pn_mem_1[`HLP_MSEC_MSEC_RX_LOWEST_PN_MEM_FROM_MEM_WIDTH-1:0]), // Templated
 .i_frm_msec_rx_next_pn_mem_0           (frm_msec_rx_next_pn_mem_0[`HLP_MSEC_MSEC_RX_NEXT_PN_MEM_FROM_MEM_WIDTH-1:0]), // Templated
 .i_frm_msec_rx_next_pn_mem_1           (frm_msec_rx_next_pn_mem_1[`HLP_MSEC_MSEC_RX_NEXT_PN_MEM_FROM_MEM_WIDTH-1:0]), // Templated
 .i_frm_msec_rx_obuf_mem                (frm_msec_rx_obuf_mem[`HLP_MSEC_MSEC_RX_OBUF_MEM_FROM_MEM_WIDTH-1:0]), // Templated
 .i_frm_msec_rx_pkt_cnt_mem_0           (frm_msec_rx_pkt_cnt_mem_0[`HLP_MSEC_MSEC_RX_PKT_CNT_MEM_FROM_MEM_WIDTH-1:0]), // Templated
 .i_frm_msec_rx_pkt_cnt_mem_1           (frm_msec_rx_pkt_cnt_mem_1[`HLP_MSEC_MSEC_RX_PKT_CNT_MEM_FROM_MEM_WIDTH-1:0]), // Templated
 .i_frm_msec_rx_salt_mem_0              (frm_msec_rx_salt_mem_0[`HLP_MSEC_MSEC_RX_SALT_MEM_FROM_MEM_WIDTH-1:0]), // Templated
 .i_frm_msec_rx_salt_mem_1              (frm_msec_rx_salt_mem_1[`HLP_MSEC_MSEC_RX_SALT_MEM_FROM_MEM_WIDTH-1:0]), // Templated
 .i_frm_msec_rx_salt_mem_2              (frm_msec_rx_salt_mem_2[`HLP_MSEC_MSEC_RX_SALT_MEM_FROM_MEM_WIDTH-1:0]), // Templated
 .i_frm_msec_rx_sc_vlan_tag_ctrl        (frm_msec_rx_sc_vlan_tag_ctrl[`HLP_MSEC_MSEC_RX_SC_VLAN_TAG_CTRL_FROM_MEM_WIDTH-1:0]), // Templated
 .i_frm_msec_rx_ssci_mem                (frm_msec_rx_ssci_mem[`HLP_MSEC_MSEC_RX_SSCI_MEM_FROM_MEM_WIDTH-1:0]), // Templated
 .i_frm_msec_tx_ibuf_mem                (frm_msec_tx_ibuf_mem[`HLP_MSEC_MSEC_TX_IBUF_MEM_FROM_MEM_WIDTH-1:0]), // Templated
 .i_frm_msec_tx_key_mem_0               (frm_msec_tx_key_mem_0[`HLP_MSEC_MSEC_TX_KEY_MEM_FROM_MEM_WIDTH-1:0]), // Templated
 .i_frm_msec_tx_key_mem_1               (frm_msec_tx_key_mem_1[`HLP_MSEC_MSEC_TX_KEY_MEM_FROM_MEM_WIDTH-1:0]), // Templated
 .i_frm_msec_tx_key_ptr_mem             (frm_msec_tx_key_ptr_mem[`HLP_MSEC_MSEC_TX_KEY_PTR_MEM_FROM_MEM_WIDTH-1:0]), // Templated
 .i_frm_msec_tx_next_pn_mem_0           (frm_msec_tx_next_pn_mem_0[`HLP_MSEC_MSEC_TX_NEXT_PN_MEM_FROM_MEM_WIDTH-1:0]), // Templated
 .i_frm_msec_tx_next_pn_mem_1           (frm_msec_tx_next_pn_mem_1[`HLP_MSEC_MSEC_TX_NEXT_PN_MEM_FROM_MEM_WIDTH-1:0]), // Templated
 .i_frm_msec_tx_obuf_mem                (frm_msec_tx_obuf_mem[`HLP_MSEC_MSEC_TX_OBUF_MEM_FROM_MEM_WIDTH-1:0]), // Templated
 .i_frm_msec_tx_pkt_cnt_mem_0           (frm_msec_tx_pkt_cnt_mem_0[`HLP_MSEC_MSEC_TX_PKT_CNT_MEM_FROM_MEM_WIDTH-1:0]), // Templated
 .i_frm_msec_tx_pkt_cnt_mem_1           (frm_msec_tx_pkt_cnt_mem_1[`HLP_MSEC_MSEC_TX_PKT_CNT_MEM_FROM_MEM_WIDTH-1:0]), // Templated
 .i_frm_msec_tx_salt_mem_0              (frm_msec_tx_salt_mem_0[`HLP_MSEC_MSEC_TX_SALT_MEM_FROM_MEM_WIDTH-1:0]), // Templated
 .i_frm_msec_tx_salt_mem_1              (frm_msec_tx_salt_mem_1[`HLP_MSEC_MSEC_TX_SALT_MEM_FROM_MEM_WIDTH-1:0]), // Templated
 .i_frm_msec_tx_salt_mem_2              (frm_msec_tx_salt_mem_2[`HLP_MSEC_MSEC_TX_SALT_MEM_FROM_MEM_WIDTH-1:0]), // Templated
 .i_frm_msec_tx_sc_vlan_tag_ctrl        (frm_msec_tx_sc_vlan_tag_ctrl[`HLP_MSEC_MSEC_TX_SC_VLAN_TAG_CTRL_FROM_MEM_WIDTH-1:0]), // Templated
 .i_frm_msec_tx_sci_mem_0               (frm_msec_tx_sci_mem_0[`HLP_MSEC_MSEC_TX_SCI_MEM_FROM_MEM_WIDTH-1:0]), // Templated
 .i_frm_msec_tx_sci_mem_1               (frm_msec_tx_sci_mem_1[`HLP_MSEC_MSEC_TX_SCI_MEM_FROM_MEM_WIDTH-1:0]), // Templated
 .i_frm_msec_tx_ssci_mem                (frm_msec_tx_ssci_mem[`HLP_MSEC_MSEC_TX_SSCI_MEM_FROM_MEM_WIDTH-1:0]), // Templated
 .i_id                                  (i_id[3:0]),
 .i_msec_mac_rx                         (i_msec_mac_rx),
 .i_msec_mac_rx_v                       (i_msec_mac_rx_v),
 .i_msec_mac_tx_e                       (i_msec_mac_tx_e),
 .i_msec_switch_rx_e                    (i_msec_switch_rx_e),
 .i_msec_switch_tx                      (i_msec_switch_tx),
 .i_msec_switch_tx_v                    (i_msec_switch_tx_v),
 .i_msec_zeroize                        (i_msec_zeroize),
 .i_rpl_bkwd                            (i_rpl_bkwd),
 .i_rpl_frwd                            (i_rpl_frwd),
 .mem_rst_n                             (local_mem_rst_n),       // Templated
 .ports_clk_free                        (ports_clk_free),
 .powergood_rst_n                       (local_powergood_rst_n), // Templated
 .rst_n                                 (local_rst_n));


  hlp_msec_apr_rtl_tessent_sib_1 hlp_msec_apr_rtl_tessent_sib_sti_inst(
      .ijtag_reset(fary_ijtag_rst_b), .ijtag_sel(fary_ijtag_select), .ijtag_si(fary_ijtag_si), 
      .ijtag_ce(fary_ijtag_capture), .ijtag_se(fary_ijtag_shift), .ijtag_ue(fary_ijtag_update), 
      .ijtag_tck(fary_ijtag_tck), .ijtag_so(hlp_msec_apr_rtl_tessent_sib_sti_inst_so), 
      .ijtag_from_so(hlp_msec_apr_rtl_tessent_sib_mbist_inst_so), .ltest_si(1'b0), 
      .ltest_scan_en(DFTSHIFTEN), .ltest_en(fscan_mode), .ltest_clk(clk_rscclk), 
      .ltest_mem_bypass_en(DFTMASK), .ltest_mcp_bounding_en(fscan_ram_init_en), 
      .ltest_async_set_reset_static_disable(fscan_byprst_b), .ijtag_to_tck(ijtag_to_tck), 
      .ijtag_to_reset(ijtag_to_reset), .ijtag_to_si(hlp_msec_apr_rtl_tessent_sib_sti_inst_so_ts1), 
      .ijtag_to_ce(ijtag_to_ce), .ijtag_to_se(ijtag_to_se), .ijtag_to_ue(ijtag_to_ue), 
      .ltest_so(), .ltest_to_en(ltest_to_en), .ltest_to_mem_bypass_en(ltest_to_mem_bypass_en), 
      .ltest_to_mcp_bounding_en(ltest_to_mcp_bounding_en), .ltest_to_scan_en(ltest_to_scan_en), 
      .ijtag_to_sel(hlp_msec_apr_rtl_tessent_sib_sti_inst_to_select)
  );

  hlp_msec_apr_rtl_tessent_sib_2 hlp_msec_apr_rtl_tessent_sib_sri_inst(
      .ijtag_reset(fary_ijtag_rst_b), .ijtag_sel(fary_ijtag_select), .ijtag_si(hlp_msec_apr_rtl_tessent_sib_sti_inst_so), 
      .ijtag_ce(fary_ijtag_capture), .ijtag_se(fary_ijtag_shift), .ijtag_ue(fary_ijtag_update), 
      .ijtag_tck(fary_ijtag_tck), .ijtag_so(aary_ijtag_so), .ijtag_from_so(hlp_msec_apr_rtl_tessent_sib_sri_ctrl_inst_so), 
      .ijtag_to_sel(hlp_msec_apr_rtl_tessent_sib_sri_inst_to_select)
  );

  hlp_msec_apr_rtl_tessent_sib_3 hlp_msec_apr_rtl_tessent_sib_sri_ctrl_inst(
      .ijtag_reset(fary_ijtag_rst_b), .ijtag_sel(hlp_msec_apr_rtl_tessent_sib_sri_inst_to_select), 
      .ijtag_si(hlp_msec_apr_rtl_tessent_sib_sti_inst_so), .ijtag_ce(fary_ijtag_capture), 
      .ijtag_se(fary_ijtag_shift), .ijtag_ue(fary_ijtag_update), .ijtag_tck(fary_ijtag_tck), 
      .ijtag_so(hlp_msec_apr_rtl_tessent_sib_sri_ctrl_inst_so), .ijtag_from_so(hlp_msec_apr_rtl_tessent_tdr_sri_ctrl_inst_so), 
      .ijtag_to_sel(hlp_msec_apr_rtl_tessent_sib_sri_ctrl_inst_to_select)
  );

  hlp_msec_apr_rtl_tessent_tdr_sri_ctrl hlp_msec_apr_rtl_tessent_tdr_sri_ctrl_inst(
      .ijtag_reset(fary_ijtag_rst_b), .ijtag_sel(hlp_msec_apr_rtl_tessent_sib_sri_ctrl_inst_to_select), 
      .ijtag_si(hlp_msec_apr_rtl_tessent_sib_sti_inst_so), .ijtag_ce(fary_ijtag_capture), 
      .ijtag_se(fary_ijtag_shift), .ijtag_ue(fary_ijtag_update), .ijtag_tck(fary_ijtag_tck), 
      .tck_select(tck_select), .all_test(), .ijtag_so(hlp_msec_apr_rtl_tessent_tdr_sri_ctrl_inst_so)
  );

  hlp_msec_apr_rtl_tessent_sib_4 hlp_msec_apr_rtl_tessent_sib_algo_select_sib_inst(
      .ijtag_reset(ijtag_to_reset), .ijtag_sel(hlp_msec_apr_rtl_tessent_sib_sti_inst_to_select), 
      .ijtag_si(hlp_msec_apr_rtl_tessent_sib_sti_inst_so_ts1), .ijtag_ce(ijtag_to_ce), 
      .ijtag_se(ijtag_to_se), .ijtag_ue(ijtag_to_ue), .ijtag_tck(ijtag_to_tck), 
      .ijtag_so(hlp_msec_apr_rtl_tessent_sib_algo_select_sib_inst_so), .ijtag_from_so(hlp_msec_apr_rtl_tessent_tdr_RF_c1_algo_select_tdr_inst_so), 
      .ijtag_to_sel(hlp_msec_apr_rtl_tessent_sib_algo_select_sib_inst_to_select)
  );

  hlp_msec_apr_rtl_tessent_sib_4 hlp_msec_apr_rtl_tessent_sib_mbist_inst(
      .ijtag_reset(ijtag_to_reset), .ijtag_sel(hlp_msec_apr_rtl_tessent_sib_sti_inst_to_select), 
      .ijtag_si(hlp_msec_apr_rtl_tessent_sib_algo_select_sib_inst_so), .ijtag_ce(ijtag_to_ce), 
      .ijtag_se(ijtag_to_se), .ijtag_ue(ijtag_to_ue), .ijtag_tck(ijtag_to_tck), 
      .ijtag_so(hlp_msec_apr_rtl_tessent_sib_mbist_inst_so), .ijtag_from_so(ijtag_so), 
      .ijtag_to_sel(ijtag_to_sel)
  );

  hlp_msec_apr_rtl_tessent_tdr_RF_c6_algo_select_tdr hlp_msec_apr_rtl_tessent_tdr_RF_c6_algo_select_tdr_inst(
      .ijtag_reset(ijtag_to_reset), .ijtag_sel(hlp_msec_apr_rtl_tessent_sib_algo_select_sib_inst_to_select), 
      .ijtag_si(hlp_msec_apr_rtl_tessent_sib_sti_inst_so_ts1), .ijtag_ce(ijtag_to_ce), 
      .ijtag_se(ijtag_to_se), .ijtag_ue(ijtag_to_ue), .ijtag_tck(ijtag_to_tck), 
      .ALGO_SEL_REG(ALGO_SEL_REG_ts5), .ijtag_so(hlp_msec_apr_rtl_tessent_tdr_RF_c6_algo_select_tdr_inst_so)
  );

  hlp_msec_apr_rtl_tessent_tdr_RF_c5_algo_select_tdr hlp_msec_apr_rtl_tessent_tdr_RF_c5_algo_select_tdr_inst(
      .ijtag_reset(ijtag_to_reset), .ijtag_sel(hlp_msec_apr_rtl_tessent_sib_algo_select_sib_inst_to_select), 
      .ijtag_si(hlp_msec_apr_rtl_tessent_tdr_RF_c6_algo_select_tdr_inst_so), .ijtag_ce(ijtag_to_ce), 
      .ijtag_se(ijtag_to_se), .ijtag_ue(ijtag_to_ue), .ijtag_tck(ijtag_to_tck), 
      .ALGO_SEL_REG(ALGO_SEL_REG_ts4), .ijtag_so(hlp_msec_apr_rtl_tessent_tdr_RF_c5_algo_select_tdr_inst_so)
  );

  hlp_msec_apr_rtl_tessent_tdr_RF_c4_algo_select_tdr hlp_msec_apr_rtl_tessent_tdr_RF_c4_algo_select_tdr_inst(
      .ijtag_reset(ijtag_to_reset), .ijtag_sel(hlp_msec_apr_rtl_tessent_sib_algo_select_sib_inst_to_select), 
      .ijtag_si(hlp_msec_apr_rtl_tessent_tdr_RF_c5_algo_select_tdr_inst_so), .ijtag_ce(ijtag_to_ce), 
      .ijtag_se(ijtag_to_se), .ijtag_ue(ijtag_to_ue), .ijtag_tck(ijtag_to_tck), 
      .ALGO_SEL_REG(ALGO_SEL_REG_ts3), .ijtag_so(hlp_msec_apr_rtl_tessent_tdr_RF_c4_algo_select_tdr_inst_so)
  );

  hlp_msec_apr_rtl_tessent_tdr_RF_c3_algo_select_tdr hlp_msec_apr_rtl_tessent_tdr_RF_c3_algo_select_tdr_inst(
      .ijtag_reset(ijtag_to_reset), .ijtag_sel(hlp_msec_apr_rtl_tessent_sib_algo_select_sib_inst_to_select), 
      .ijtag_si(hlp_msec_apr_rtl_tessent_tdr_RF_c4_algo_select_tdr_inst_so), .ijtag_ce(ijtag_to_ce), 
      .ijtag_se(ijtag_to_se), .ijtag_ue(ijtag_to_ue), .ijtag_tck(ijtag_to_tck), 
      .ALGO_SEL_REG(ALGO_SEL_REG_ts2), .ijtag_so(hlp_msec_apr_rtl_tessent_tdr_RF_c3_algo_select_tdr_inst_so)
  );

  hlp_msec_apr_rtl_tessent_tdr_RF_c2_algo_select_tdr hlp_msec_apr_rtl_tessent_tdr_RF_c2_algo_select_tdr_inst(
      .ijtag_reset(ijtag_to_reset), .ijtag_sel(hlp_msec_apr_rtl_tessent_sib_algo_select_sib_inst_to_select), 
      .ijtag_si(hlp_msec_apr_rtl_tessent_tdr_RF_c3_algo_select_tdr_inst_so), .ijtag_ce(ijtag_to_ce), 
      .ijtag_se(ijtag_to_se), .ijtag_ue(ijtag_to_ue), .ijtag_tck(ijtag_to_tck), 
      .ALGO_SEL_REG(ALGO_SEL_REG_ts1), .ijtag_so(hlp_msec_apr_rtl_tessent_tdr_RF_c2_algo_select_tdr_inst_so)
  );

  hlp_msec_apr_rtl_tessent_tdr_RF_c1_algo_select_tdr hlp_msec_apr_rtl_tessent_tdr_RF_c1_algo_select_tdr_inst(
      .ijtag_reset(ijtag_to_reset), .ijtag_sel(hlp_msec_apr_rtl_tessent_sib_algo_select_sib_inst_to_select), 
      .ijtag_si(hlp_msec_apr_rtl_tessent_tdr_RF_c2_algo_select_tdr_inst_so), .ijtag_ce(ijtag_to_ce), 
      .ijtag_se(ijtag_to_se), .ijtag_ue(ijtag_to_ue), .ijtag_tck(ijtag_to_tck), 
      .ALGO_SEL_REG(ALGO_SEL_REG), .ijtag_so(hlp_msec_apr_rtl_tessent_tdr_RF_c1_algo_select_tdr_inst_so)
  );

  hlp_msec_apr_rtl_tessent_mbist_bap hlp_msec_apr_rtl_tessent_mbist_bap_inst(
      .reset(ijtag_to_reset), .ijtag_select(ijtag_to_sel), .si(hlp_msec_apr_rtl_tessent_sib_algo_select_sib_inst_so), 
      .capture_en(ijtag_to_ce), .shift_en(ijtag_to_se), .shift_en_R(), .update_en(ijtag_to_ue), 
      .tck(ijtag_to_tck), .to_interfaces_tck(to_interfaces_tck), .to_controllers_tck_retime(to_controllers_tck_retime), 
      .to_controllers_tck(to_controllers_tck), .mcp_bounding_en(ltest_to_mcp_bounding_en), 
      .mcp_bounding_to_en(mcp_bounding_to_en), .scan_en(ltest_to_scan_en), .scan_to_en(scan_to_en), 
      .memory_bypass_en(ltest_to_mem_bypass_en), .memory_bypass_to_en(memory_bypass_to_en), 
      .ltest_en(ltest_to_en), .ltest_to_en(ltest_to_en_ts1), .BIST_HOLD(BIST_HOLD), 
      .sys_ctrl_select({select_rf, select_rf, select_rf, select_rf, 
      select_rf, select_rf}), .sys_algo_select(mbistpg_algo_sel_o[6:0]), .sys_select_common_algo(mbistpg_select_common_algo_o), 
      .sys_test_start_clk(trigger_post), .sys_test_init_clk(1'b0), .sys_reset_clk(sync_reset_clk_o), 
      .sys_clock_clk(gclk), .sys_test_pass_clk(sys_test_pass_clk), .sys_test_done_clk(sys_test_done_clk), 
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
      .BIST_OPSET_SEL(BIST_OPSET_SEL), .BIST_SELECT_COMMON_OPSET(BIST_SELECT_COMMON_OPSET), 
      .BIST_DATA_INV_COL_ADD_BIT_SEL(BIST_DATA_INV_COL_ADD_BIT_SEL), .BIST_DATA_INV_COL_ADD_BIT_SELECT_EN(BIST_DATA_INV_COL_ADD_BIT_SELECT_EN), 
      .BIST_DATA_INV_ROW_ADD_BIT_SEL(BIST_DATA_INV_ROW_ADD_BIT_SEL), .BIST_DATA_INV_ROW_ADD_BIT_SELECT_EN(BIST_DATA_INV_ROW_ADD_BIT_SELECT_EN), 
      .MBISTPG_GO({MBISTPG_GO_ts5, MBISTPG_GO_ts4, MBISTPG_GO_ts3, 
      MBISTPG_GO_ts2, MBISTPG_GO_ts1, MBISTPG_GO}), .MBISTPG_DONE({
      MBISTPG_DONE_ts5, MBISTPG_DONE_ts4, MBISTPG_DONE_ts3, MBISTPG_DONE_ts2, 
      MBISTPG_DONE_ts1, MBISTPG_DONE}), .bistEn(bistEn[5:0]), .toBist(toBist[5:0]), 
      .fromBist({MBISTPG_SO_ts5, MBISTPG_SO_ts4, MBISTPG_SO_ts3, 
      MBISTPG_SO_ts2, MBISTPG_SO_ts1, MBISTPG_SO}), .so(hlp_msec_apr_rtl_tessent_mbist_bap_inst_so), 
      .fscan_clkungate(fscan_clkungate)
  );

  hlp_msec_apr_rtl_tessent_mbist_RF_c1_controller hlp_msec_apr_rtl_tessent_mbist_RF_c1_controller_inst(
      .MBIST_RA_PRSRV_FUSE_VAL(PRESERVE_FUSE_REGISTER), .MBISTPG_ALGO_SEL({
      BIST_ALGO_SEL_ts6, BIST_ALGO_SEL_ts5, BIST_ALGO_SEL_ts4, 
      BIST_ALGO_SEL_ts3, BIST_ALGO_SEL_ts2, BIST_ALGO_SEL_ts1, BIST_ALGO_SEL}), .MBISTPG_SELECT_COMMON_ALGO(BIST_SELECT_COMMON_ALGO), 
      .MBISTPG_OPSET_SELECT(BIST_OPSET_SEL), .MBISTPG_SELECT_COMMON_OPSET(BIST_SELECT_COMMON_OPSET), 
      .MBISTPG_DATA_INV_ROW_ADD_BIT_SELECT_EN(BIST_DATA_INV_ROW_ADD_BIT_SELECT_EN), 
      .MBISTPG_DATA_INV_ROW_ADD_BIT_SELECT(BIST_DATA_INV_ROW_ADD_BIT_SEL), .MBISTPG_ALGO_MODE({
      BIST_ALGO_MODE1, BIST_ALGO_MODE0}), .MBISTPG_MEM_RST(ENABLE_MEM_RESET), .MBISTPG_REDUCED_ADDR_CNT_EN(REDUCED_ADDRESS_COUNT), 
      .MEM_BYPASS_EN(memory_bypass_to_en), .MCP_BOUNDING_EN(mcp_bounding_to_en), 
      .MEM0_BIST_COLLAR_SO(BIST_SO), .FL_CNT_MODE({FL_CNT_MODE1, 
      FL_CNT_MODE0}), .MBISTPG_BIRA_EN(BIRA_EN), .CHECK_REPAIR_NEEDED(CHECK_REPAIR_NEEDED), 
      .BIST_COLLAR_GO(BIST_GO), .MBISTPG_DIAG_EN(BIST_DIAG_EN), .BIST_CLK(gclk), 
      .BIST_SI(toBist[0]), .BIST_HOLD(BIST_HOLD), .BIST_SETUP2(BIST_SETUP_ts3), 
      .BIST_SETUP({BIST_SETUP_ts2, BIST_SETUP_ts1}), .MBISTPG_TESTDATA_SELECT(BIST_SELECT_TEST_DATA), 
      .TCK(to_controllers_tck), .TCK_RETIME(to_controllers_tck_retime), .MBISTPG_EN(bistEn[0]), 
      .MBISTPG_ASYNC_RESETN(BIST_ASYNC_RESET), .LV_TM(ltest_to_en_ts1), .MBISTPG_MEM_ARRAY_DUMP_MODE(MEM_ARRAY_DUMP_MODE), 
      .BIST_CLEAR_BIRA(BIST_CLEAR_BIRA), .MBISTPG_RESET_REG_SETUP2(MBISTPG_RESET_REG_SETUP2), 
      .BIST_ROW_ADD(BIST_ROW_ADD), .BIST_WRITE_DATA(BIST_WRITE_DATA), .BIST_EXPECT_DATA(BIST_EXPECT_DATA), 
      .BIST_SHIFT_COLLAR(BIST_SHIFT_COLLAR), .BIST_TESTDATA_SELECT_TO_COLLAR(BIST_TESTDATA_SELECT_TO_COLLAR), 
      .MEM0_BIST_COLLAR_SI(MEM0_BIST_COLLAR_SI), .BIST_COLLAR_SETUP(BIST_COLLAR_SETUP), 
      .BIST_COLLAR_OPSET_SELECT(BIST_COLLAR_OPSET_SELECT), .BIST_COLLAR_HOLD(BIST_COLLAR_HOLD), 
      .FREEZE_STOP_ERROR(FREEZE_STOP_ERROR), .ERROR_CNT_ZERO(ERROR_CNT_ZERO), .BIST_COLLAR_DIAG_EN(BIST_COLLAR_DIAG_EN), 
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

  hlp_msec_apr_rtl_tessent_mbist_RF_c2_controller hlp_msec_apr_rtl_tessent_mbist_RF_c2_controller_inst(
      .MBIST_RA_PRSRV_FUSE_VAL(PRESERVE_FUSE_REGISTER), .MBISTPG_ALGO_SEL({
      BIST_ALGO_SEL_ts6, BIST_ALGO_SEL_ts5, BIST_ALGO_SEL_ts4, 
      BIST_ALGO_SEL_ts3, BIST_ALGO_SEL_ts2, BIST_ALGO_SEL_ts1, BIST_ALGO_SEL}), .MBISTPG_SELECT_COMMON_ALGO(BIST_SELECT_COMMON_ALGO), 
      .MBISTPG_OPSET_SELECT(BIST_OPSET_SEL), .MBISTPG_SELECT_COMMON_OPSET(BIST_SELECT_COMMON_OPSET), 
      .MBISTPG_DATA_INV_ROW_ADD_BIT_SELECT_EN(BIST_DATA_INV_ROW_ADD_BIT_SELECT_EN), 
      .MBISTPG_DATA_INV_ROW_ADD_BIT_SELECT(BIST_DATA_INV_ROW_ADD_BIT_SEL), .MBISTPG_ALGO_MODE({
      BIST_ALGO_MODE1, BIST_ALGO_MODE0}), .MBISTPG_MEM_RST(ENABLE_MEM_RESET), .MBISTPG_REDUCED_ADDR_CNT_EN(REDUCED_ADDRESS_COUNT), 
      .MEM_BYPASS_EN(memory_bypass_to_en), .MCP_BOUNDING_EN(mcp_bounding_to_en), 
      .MEM0_BIST_COLLAR_SO(BIST_SO_ts1), .MEM1_BIST_COLLAR_SO(BIST_SO_ts17), .MEM2_BIST_COLLAR_SO(BIST_SO_ts23), 
      .MEM3_BIST_COLLAR_SO(BIST_SO_ts38), .MEM4_BIST_COLLAR_SO(BIST_SO_ts40), .FL_CNT_MODE({
      FL_CNT_MODE1, FL_CNT_MODE0}), .MBISTPG_BIRA_EN(BIRA_EN), .CHECK_REPAIR_NEEDED(CHECK_REPAIR_NEEDED), 
      .BIST_COLLAR_GO({BIST_GO_ts40, BIST_GO_ts38, BIST_GO_ts23, 
      BIST_GO_ts17, BIST_GO_ts1}), .MBISTPG_DIAG_EN(BIST_DIAG_EN), .BIST_CLK(gclk), 
      .BIST_SI(toBist[1]), .BIST_HOLD(BIST_HOLD), .BIST_SETUP2(BIST_SETUP_ts3), 
      .BIST_SETUP({BIST_SETUP_ts2, BIST_SETUP_ts1}), .MBISTPG_TESTDATA_SELECT(BIST_SELECT_TEST_DATA), 
      .TCK(to_controllers_tck), .TCK_RETIME(to_controllers_tck_retime), .MBISTPG_EN(bistEn[1]), 
      .MBISTPG_ASYNC_RESETN(BIST_ASYNC_RESET), .LV_TM(ltest_to_en_ts1), .MBISTPG_MEM_ARRAY_DUMP_MODE(MEM_ARRAY_DUMP_MODE), 
      .BIST_CLEAR_BIRA(BIST_CLEAR_BIRA_ts1), .MBISTPG_RESET_REG_SETUP2(MBISTPG_RESET_REG_SETUP2_ts1), 
      .BIST_ROW_ADD(BIST_ROW_ADD_ts1[3:0]), .BIST_WRITE_DATA(BIST_WRITE_DATA_ts1[7:0]), 
      .BIST_EXPECT_DATA(BIST_EXPECT_DATA_ts1[7:0]), .BIST_SHIFT_COLLAR(BIST_SHIFT_COLLAR_ts1), 
      .BIST_TESTDATA_SELECT_TO_COLLAR(BIST_TESTDATA_SELECT_TO_COLLAR_ts1), .MEM0_BIST_COLLAR_SI(MEM0_BIST_COLLAR_SI_ts1), 
      .MEM1_BIST_COLLAR_SI(MEM1_BIST_COLLAR_SI), .MEM2_BIST_COLLAR_SI(MEM2_BIST_COLLAR_SI), 
      .MEM3_BIST_COLLAR_SI(MEM3_BIST_COLLAR_SI), .MEM4_BIST_COLLAR_SI(MEM4_BIST_COLLAR_SI), 
      .BIST_COLLAR_SETUP(BIST_COLLAR_SETUP_ts1), .BIST_COLLAR_OPSET_SELECT(BIST_COLLAR_OPSET_SELECT_ts1), 
      .BIST_COLLAR_HOLD(BIST_COLLAR_HOLD_ts1), .FREEZE_STOP_ERROR(FREEZE_STOP_ERROR_ts1), 
      .ERROR_CNT_ZERO(ERROR_CNT_ZERO_ts1), .BIST_COLLAR_DIAG_EN(BIST_COLLAR_DIAG_EN_ts1), 
      .BIST_COLLAR_BIRA_EN(BIST_COLLAR_BIRA_EN_ts1), .BIST_CLEAR_DEFAULT(BIST_CLEAR_DEFAULT_ts1), 
      .BIST_CLEAR(BIST_CLEAR_ts1), .MBISTPG_SO(MBISTPG_SO_ts1), .PriorityColumn(PriorityColumn_ts1), 
      .BIST_CONREAD_ROWADDRESS(BIST_CONREAD_ROWADDRESS_ts1), .BIST_CONREAD_COLUMNADDRESS(BIST_CONREAD_COLUMNADDRESS_ts1), 
      .BIST_CONREAD_ENABLE(BIST_CONREAD_ENABLE_ts1), .BIST_CONWRITE_ROWADDRESS(BIST_CONWRITE_ROWADDRESS_ts1), 
      .BIST_CONWRITE_ENABLE(BIST_CONWRITE_ENABLE_ts1), .BIST_READENABLE(BIST_READENABLE_ts1), 
      .BIST_WRITEENABLE(BIST_WRITEENABLE_ts1), .BIST_SHADOW_READENABLE(BIST_SHADOW_READENABLE_ts1), 
      .BIST_SHADOW_READADDRESS(BIST_SHADOW_READADDRESS_ts1), .BIST_CMP(BIST_CMP_ts1), 
      .BIST_COLLAR_EN0(BIST_COLLAR_EN0_ts1), .BIST_RUN_TO_COLLAR0(BIST_RUN_TO_COLLAR0_ts1), 
      .BIST_COLLAR_EN1(BIST_COLLAR_EN1), .BIST_RUN_TO_COLLAR1(BIST_RUN_TO_COLLAR1), 
      .BIST_COLLAR_EN2(BIST_COLLAR_EN2), .BIST_RUN_TO_COLLAR2(BIST_RUN_TO_COLLAR2), 
      .BIST_COLLAR_EN3(BIST_COLLAR_EN3), .BIST_RUN_TO_COLLAR3(BIST_RUN_TO_COLLAR3), 
      .BIST_COLLAR_EN4(BIST_COLLAR_EN4), .BIST_RUN_TO_COLLAR4(BIST_RUN_TO_COLLAR4), 
      .MBISTPG_GO(MBISTPG_GO_ts1), .MBISTPG_STABLE(MBISTPG_STABLE_ts1), .MBISTPG_DONE(MBISTPG_DONE_ts1), 
      .BIST_ON_TO_COLLAR(BIST_ON_TO_COLLAR_ts1), .BIST_SHIFT_BIRA_COLLAR(BIST_SHIFT_BIRA_COLLAR_ts1), 
      .GO_ID_REG_SEL(GO_ID_REG_SEL_ts1), .ALGO_SEL_REG(ALGO_SEL_REG_ts1), .fscan_clkungate(fscan_clkungate)
  );

  hlp_msec_apr_rtl_tessent_mbist_RF_c3_controller hlp_msec_apr_rtl_tessent_mbist_RF_c3_controller_inst(
      .MBIST_RA_PRSRV_FUSE_VAL(PRESERVE_FUSE_REGISTER), .MBISTPG_ALGO_SEL({
      BIST_ALGO_SEL_ts6, BIST_ALGO_SEL_ts5, BIST_ALGO_SEL_ts4, 
      BIST_ALGO_SEL_ts3, BIST_ALGO_SEL_ts2, BIST_ALGO_SEL_ts1, BIST_ALGO_SEL}), .MBISTPG_SELECT_COMMON_ALGO(BIST_SELECT_COMMON_ALGO), 
      .MBISTPG_OPSET_SELECT(BIST_OPSET_SEL), .MBISTPG_SELECT_COMMON_OPSET(BIST_SELECT_COMMON_OPSET), 
      .MBISTPG_DATA_INV_ROW_ADD_BIT_SELECT_EN(BIST_DATA_INV_ROW_ADD_BIT_SELECT_EN), 
      .MBISTPG_DATA_INV_ROW_ADD_BIT_SELECT(BIST_DATA_INV_ROW_ADD_BIT_SEL), .MBISTPG_DATA_INV_COL_ADD_BIT_SELECT_EN(BIST_DATA_INV_COL_ADD_BIT_SELECT_EN), 
      .MBISTPG_DATA_INV_COL_ADD_BIT_SELECT(BIST_DATA_INV_COL_ADD_BIT_SEL), .MBISTPG_ALGO_MODE({
      BIST_ALGO_MODE1, BIST_ALGO_MODE0}), .MBISTPG_MEM_RST(ENABLE_MEM_RESET), .MBISTPG_REDUCED_ADDR_CNT_EN(REDUCED_ADDRESS_COUNT), 
      .MEM_BYPASS_EN(memory_bypass_to_en), .MCP_BOUNDING_EN(mcp_bounding_to_en), 
      .MEM0_BIST_COLLAR_SO(BIST_SO_ts2), .MEM1_BIST_COLLAR_SO(BIST_SO_ts33), .MEM2_BIST_COLLAR_SO(BIST_SO_ts3), 
      .MEM3_BIST_COLLAR_SO(BIST_SO_ts34), .MEM4_BIST_COLLAR_SO(BIST_SO_ts4), .MEM5_BIST_COLLAR_SO(BIST_SO_ts5), 
      .MEM6_BIST_COLLAR_SO(BIST_SO_ts6), .MEM7_BIST_COLLAR_SO(BIST_SO_ts7), .MEM8_BIST_COLLAR_SO(BIST_SO_ts8), 
      .MEM9_BIST_COLLAR_SO(BIST_SO_ts10), .MEM10_BIST_COLLAR_SO(BIST_SO_ts42), 
      .MEM11_BIST_COLLAR_SO(BIST_SO_ts11), .MEM12_BIST_COLLAR_SO(BIST_SO_ts43), 
      .MEM13_BIST_COLLAR_SO(BIST_SO_ts12), .MEM14_BIST_COLLAR_SO(BIST_SO_ts13), 
      .MEM15_BIST_COLLAR_SO(BIST_SO_ts14), .MEM16_BIST_COLLAR_SO(BIST_SO_ts16), 
      .MEM17_BIST_COLLAR_SO(BIST_SO_ts18), .MEM18_BIST_COLLAR_SO(BIST_SO_ts36), 
      .MEM19_BIST_COLLAR_SO(BIST_SO_ts19), .MEM20_BIST_COLLAR_SO(BIST_SO_ts37), 
      .MEM21_BIST_COLLAR_SO(BIST_SO_ts20), .MEM22_BIST_COLLAR_SO(BIST_SO_ts21), 
      .MEM23_BIST_COLLAR_SO(BIST_SO_ts22), .MEM24_BIST_COLLAR_SO(BIST_SO_ts26), 
      .MEM25_BIST_COLLAR_SO(BIST_SO_ts27), .MEM26_BIST_COLLAR_SO(BIST_SO_ts28), 
      .MEM27_BIST_COLLAR_SO(BIST_SO_ts32), .FL_CNT_MODE({FL_CNT_MODE1, 
      FL_CNT_MODE0}), .MBISTPG_BIRA_EN(BIRA_EN), .CHECK_REPAIR_NEEDED(CHECK_REPAIR_NEEDED), 
      .BIST_COLLAR_GO({BIST_GO_ts32, BIST_GO_ts28, BIST_GO_ts27, 
      BIST_GO_ts26, BIST_GO_ts22, BIST_GO_ts21, BIST_GO_ts20, BIST_GO_ts37, 
      BIST_GO_ts19, BIST_GO_ts36, BIST_GO_ts18, BIST_GO_ts16, BIST_GO_ts14, 
      BIST_GO_ts13, BIST_GO_ts12, BIST_GO_ts43, BIST_GO_ts11, BIST_GO_ts42, 
      BIST_GO_ts10, BIST_GO_ts8, BIST_GO_ts7, BIST_GO_ts6, BIST_GO_ts5, 
      BIST_GO_ts4, BIST_GO_ts34, BIST_GO_ts3, BIST_GO_ts33, BIST_GO_ts2}), .MBISTPG_DIAG_EN(BIST_DIAG_EN), 
      .BIST_CLK(gclk), .BIST_SI(toBist[2]), .BIST_HOLD(BIST_HOLD), .BIST_SETUP2(BIST_SETUP_ts3), 
      .BIST_SETUP({BIST_SETUP_ts2, BIST_SETUP_ts1}), .MBISTPG_TESTDATA_SELECT(BIST_SELECT_TEST_DATA), 
      .TCK(to_controllers_tck), .TCK_RETIME(to_controllers_tck_retime), .MBISTPG_EN(bistEn[2]), 
      .MBISTPG_ASYNC_RESETN(BIST_ASYNC_RESET), .LV_TM(ltest_to_en_ts1), .MBISTPG_MEM_ARRAY_DUMP_MODE(MEM_ARRAY_DUMP_MODE), 
      .BIST_CLEAR_BIRA(BIST_CLEAR_BIRA_ts2), .MBISTPG_RESET_REG_SETUP2(MBISTPG_RESET_REG_SETUP2_ts2), 
      .BIST_COL_ADD(BIST_COL_ADD), .BIST_ROW_ADD(BIST_ROW_ADD_ts2[4:0]), .BIST_BANK_ADD(BIST_BANK_ADD[1:0]), 
      .BIST_WRITE_DATA(BIST_WRITE_DATA_ts2[7:0]), .BIST_EXPECT_DATA(BIST_EXPECT_DATA_ts2[7:0]), 
      .BIST_SHIFT_COLLAR(BIST_SHIFT_COLLAR_ts2), .BIST_TESTDATA_SELECT_TO_COLLAR(BIST_TESTDATA_SELECT_TO_COLLAR_ts2), 
      .MEM0_BIST_COLLAR_SI(MEM0_BIST_COLLAR_SI_ts2), .MEM1_BIST_COLLAR_SI(MEM1_BIST_COLLAR_SI_ts1), 
      .MEM2_BIST_COLLAR_SI(MEM2_BIST_COLLAR_SI_ts1), .MEM3_BIST_COLLAR_SI(MEM3_BIST_COLLAR_SI_ts1), 
      .MEM4_BIST_COLLAR_SI(MEM4_BIST_COLLAR_SI_ts1), .MEM5_BIST_COLLAR_SI(MEM5_BIST_COLLAR_SI), 
      .MEM6_BIST_COLLAR_SI(MEM6_BIST_COLLAR_SI), .MEM7_BIST_COLLAR_SI(MEM7_BIST_COLLAR_SI), 
      .MEM8_BIST_COLLAR_SI(MEM8_BIST_COLLAR_SI), .MEM9_BIST_COLLAR_SI(MEM9_BIST_COLLAR_SI), 
      .MEM10_BIST_COLLAR_SI(MEM10_BIST_COLLAR_SI), .MEM11_BIST_COLLAR_SI(MEM11_BIST_COLLAR_SI), 
      .MEM12_BIST_COLLAR_SI(MEM12_BIST_COLLAR_SI), .MEM13_BIST_COLLAR_SI(MEM13_BIST_COLLAR_SI), 
      .MEM14_BIST_COLLAR_SI(MEM14_BIST_COLLAR_SI), .MEM15_BIST_COLLAR_SI(MEM15_BIST_COLLAR_SI), 
      .MEM16_BIST_COLLAR_SI(MEM16_BIST_COLLAR_SI), .MEM17_BIST_COLLAR_SI(MEM17_BIST_COLLAR_SI), 
      .MEM18_BIST_COLLAR_SI(MEM18_BIST_COLLAR_SI), .MEM19_BIST_COLLAR_SI(MEM19_BIST_COLLAR_SI), 
      .MEM20_BIST_COLLAR_SI(MEM20_BIST_COLLAR_SI), .MEM21_BIST_COLLAR_SI(MEM21_BIST_COLLAR_SI), 
      .MEM22_BIST_COLLAR_SI(MEM22_BIST_COLLAR_SI), .MEM23_BIST_COLLAR_SI(MEM23_BIST_COLLAR_SI), 
      .MEM24_BIST_COLLAR_SI(MEM24_BIST_COLLAR_SI), .MEM25_BIST_COLLAR_SI(MEM25_BIST_COLLAR_SI), 
      .MEM26_BIST_COLLAR_SI(MEM26_BIST_COLLAR_SI), .MEM27_BIST_COLLAR_SI(MEM27_BIST_COLLAR_SI), 
      .BIST_COLLAR_SETUP(BIST_COLLAR_SETUP_ts2), .BIST_COLLAR_OPSET_SELECT(BIST_COLLAR_OPSET_SELECT_ts2), 
      .BIST_COLLAR_HOLD(BIST_COLLAR_HOLD_ts2), .FREEZE_STOP_ERROR(FREEZE_STOP_ERROR_ts2), 
      .ERROR_CNT_ZERO(ERROR_CNT_ZERO_ts2), .BIST_COLLAR_DIAG_EN(BIST_COLLAR_DIAG_EN_ts2), 
      .BIST_COLLAR_BIRA_EN(BIST_COLLAR_BIRA_EN_ts2), .BIST_CLEAR_DEFAULT(BIST_CLEAR_DEFAULT_ts2), 
      .BIST_CLEAR(BIST_CLEAR_ts2), .MBISTPG_SO(MBISTPG_SO_ts2), .PriorityColumn(PriorityColumn_ts2), 
      .BIST_CONREAD_ROWADDRESS(BIST_CONREAD_ROWADDRESS_ts2), .BIST_CONREAD_COLUMNADDRESS(BIST_CONREAD_COLUMNADDRESS_ts2), 
      .BIST_CONREAD_ENABLE(BIST_CONREAD_ENABLE_ts2), .BIST_CONWRITE_ROWADDRESS(BIST_CONWRITE_ROWADDRESS_ts2), 
      .BIST_CONWRITE_ENABLE(BIST_CONWRITE_ENABLE_ts2), .BIST_READENABLE(BIST_READENABLE_ts2), 
      .BIST_WRITEENABLE(BIST_WRITEENABLE_ts2), .BIST_SHADOW_READENABLE(BIST_SHADOW_READENABLE_ts2), 
      .BIST_SHADOW_READADDRESS(BIST_SHADOW_READADDRESS_ts2), .BIST_CMP(BIST_CMP_ts2), 
      .BIST_COLLAR_EN0(BIST_COLLAR_EN0_ts2), .BIST_RUN_TO_COLLAR0(BIST_RUN_TO_COLLAR0_ts2), 
      .BIST_COLLAR_EN1(BIST_COLLAR_EN1_ts1), .BIST_RUN_TO_COLLAR1(BIST_RUN_TO_COLLAR1_ts1), 
      .BIST_COLLAR_EN2(BIST_COLLAR_EN2_ts1), .BIST_RUN_TO_COLLAR2(BIST_RUN_TO_COLLAR2_ts1), 
      .BIST_COLLAR_EN3(BIST_COLLAR_EN3_ts1), .BIST_RUN_TO_COLLAR3(BIST_RUN_TO_COLLAR3_ts1), 
      .BIST_COLLAR_EN4(BIST_COLLAR_EN4_ts1), .BIST_RUN_TO_COLLAR4(BIST_RUN_TO_COLLAR4_ts1), 
      .BIST_COLLAR_EN5(BIST_COLLAR_EN5), .BIST_RUN_TO_COLLAR5(BIST_RUN_TO_COLLAR5), 
      .BIST_COLLAR_EN6(BIST_COLLAR_EN6), .BIST_RUN_TO_COLLAR6(BIST_RUN_TO_COLLAR6), 
      .BIST_COLLAR_EN7(BIST_COLLAR_EN7), .BIST_RUN_TO_COLLAR7(BIST_RUN_TO_COLLAR7), 
      .BIST_COLLAR_EN8(BIST_COLLAR_EN8), .BIST_RUN_TO_COLLAR8(BIST_RUN_TO_COLLAR8), 
      .BIST_COLLAR_EN9(BIST_COLLAR_EN9), .BIST_RUN_TO_COLLAR9(BIST_RUN_TO_COLLAR9), 
      .BIST_COLLAR_EN10(BIST_COLLAR_EN10), .BIST_RUN_TO_COLLAR10(BIST_RUN_TO_COLLAR10), 
      .BIST_COLLAR_EN11(BIST_COLLAR_EN11), .BIST_RUN_TO_COLLAR11(BIST_RUN_TO_COLLAR11), 
      .BIST_COLLAR_EN12(BIST_COLLAR_EN12), .BIST_RUN_TO_COLLAR12(BIST_RUN_TO_COLLAR12), 
      .BIST_COLLAR_EN13(BIST_COLLAR_EN13), .BIST_RUN_TO_COLLAR13(BIST_RUN_TO_COLLAR13), 
      .BIST_COLLAR_EN14(BIST_COLLAR_EN14), .BIST_RUN_TO_COLLAR14(BIST_RUN_TO_COLLAR14), 
      .BIST_COLLAR_EN15(BIST_COLLAR_EN15), .BIST_RUN_TO_COLLAR15(BIST_RUN_TO_COLLAR15), 
      .BIST_COLLAR_EN16(BIST_COLLAR_EN16), .BIST_RUN_TO_COLLAR16(BIST_RUN_TO_COLLAR16), 
      .BIST_COLLAR_EN17(BIST_COLLAR_EN17), .BIST_RUN_TO_COLLAR17(BIST_RUN_TO_COLLAR17), 
      .BIST_COLLAR_EN18(BIST_COLLAR_EN18), .BIST_RUN_TO_COLLAR18(BIST_RUN_TO_COLLAR18), 
      .BIST_COLLAR_EN19(BIST_COLLAR_EN19), .BIST_RUN_TO_COLLAR19(BIST_RUN_TO_COLLAR19), 
      .BIST_COLLAR_EN20(BIST_COLLAR_EN20), .BIST_RUN_TO_COLLAR20(BIST_RUN_TO_COLLAR20), 
      .BIST_COLLAR_EN21(BIST_COLLAR_EN21), .BIST_RUN_TO_COLLAR21(BIST_RUN_TO_COLLAR21), 
      .BIST_COLLAR_EN22(BIST_COLLAR_EN22), .BIST_RUN_TO_COLLAR22(BIST_RUN_TO_COLLAR22), 
      .BIST_COLLAR_EN23(BIST_COLLAR_EN23), .BIST_RUN_TO_COLLAR23(BIST_RUN_TO_COLLAR23), 
      .BIST_COLLAR_EN24(BIST_COLLAR_EN24), .BIST_RUN_TO_COLLAR24(BIST_RUN_TO_COLLAR24), 
      .BIST_COLLAR_EN25(BIST_COLLAR_EN25), .BIST_RUN_TO_COLLAR25(BIST_RUN_TO_COLLAR25), 
      .BIST_COLLAR_EN26(BIST_COLLAR_EN26), .BIST_RUN_TO_COLLAR26(BIST_RUN_TO_COLLAR26), 
      .BIST_COLLAR_EN27(BIST_COLLAR_EN27), .BIST_RUN_TO_COLLAR27(BIST_RUN_TO_COLLAR27), 
      .MBISTPG_GO(MBISTPG_GO_ts2), .MBISTPG_STABLE(MBISTPG_STABLE_ts2), .MBISTPG_DONE(MBISTPG_DONE_ts2), 
      .BIST_ON_TO_COLLAR(BIST_ON_TO_COLLAR_ts2), .BIST_SHIFT_BIRA_COLLAR(BIST_SHIFT_BIRA_COLLAR_ts2), 
      .GO_ID_REG_SEL(GO_ID_REG_SEL_ts2), .ALGO_SEL_REG(ALGO_SEL_REG_ts2), .fscan_clkungate(fscan_clkungate)
  );

  hlp_msec_apr_rtl_tessent_mbist_RF_c4_controller hlp_msec_apr_rtl_tessent_mbist_RF_c4_controller_inst(
      .MBIST_RA_PRSRV_FUSE_VAL(PRESERVE_FUSE_REGISTER), .MBISTPG_ALGO_SEL({
      BIST_ALGO_SEL_ts6, BIST_ALGO_SEL_ts5, BIST_ALGO_SEL_ts4, 
      BIST_ALGO_SEL_ts3, BIST_ALGO_SEL_ts2, BIST_ALGO_SEL_ts1, BIST_ALGO_SEL}), .MBISTPG_SELECT_COMMON_ALGO(BIST_SELECT_COMMON_ALGO), 
      .MBISTPG_OPSET_SELECT(BIST_OPSET_SEL), .MBISTPG_SELECT_COMMON_OPSET(BIST_SELECT_COMMON_OPSET), 
      .MBISTPG_DATA_INV_ROW_ADD_BIT_SELECT_EN(BIST_DATA_INV_ROW_ADD_BIT_SELECT_EN), 
      .MBISTPG_DATA_INV_ROW_ADD_BIT_SELECT(BIST_DATA_INV_ROW_ADD_BIT_SEL), .MBISTPG_ALGO_MODE({
      BIST_ALGO_MODE1, BIST_ALGO_MODE0}), .MBISTPG_MEM_RST(ENABLE_MEM_RESET), .MBISTPG_REDUCED_ADDR_CNT_EN(REDUCED_ADDRESS_COUNT), 
      .MEM_BYPASS_EN(memory_bypass_to_en), .MCP_BOUNDING_EN(mcp_bounding_to_en), 
      .MEM0_BIST_COLLAR_SO(BIST_SO_ts9), .MEM1_BIST_COLLAR_SO(BIST_SO_ts35), .MEM2_BIST_COLLAR_SO(BIST_SO_ts39), 
      .MEM3_BIST_COLLAR_SO(BIST_SO_ts41), .FL_CNT_MODE({FL_CNT_MODE1, 
      FL_CNT_MODE0}), .MBISTPG_BIRA_EN(BIRA_EN), .CHECK_REPAIR_NEEDED(CHECK_REPAIR_NEEDED), 
      .BIST_COLLAR_GO({BIST_GO_ts41, BIST_GO_ts39, BIST_GO_ts35, 
      BIST_GO_ts9}), .MBISTPG_DIAG_EN(BIST_DIAG_EN), .BIST_CLK(gclk), .BIST_SI(toBist[3]), 
      .BIST_HOLD(BIST_HOLD), .BIST_SETUP2(BIST_SETUP_ts3), .BIST_SETUP({
      BIST_SETUP_ts2, BIST_SETUP_ts1}), .MBISTPG_TESTDATA_SELECT(BIST_SELECT_TEST_DATA), 
      .TCK(to_controllers_tck), .TCK_RETIME(to_controllers_tck_retime), .MBISTPG_EN(bistEn[3]), 
      .MBISTPG_ASYNC_RESETN(BIST_ASYNC_RESET), .LV_TM(ltest_to_en_ts1), .MBISTPG_MEM_ARRAY_DUMP_MODE(MEM_ARRAY_DUMP_MODE), 
      .BIST_CLEAR_BIRA(BIST_CLEAR_BIRA_ts3), .MBISTPG_RESET_REG_SETUP2(MBISTPG_RESET_REG_SETUP2_ts3), 
      .BIST_ROW_ADD(BIST_ROW_ADD_ts3[2:0]), .BIST_WRITE_DATA(BIST_WRITE_DATA_ts3[7:0]), 
      .BIST_EXPECT_DATA(BIST_EXPECT_DATA_ts3[7:0]), .BIST_SHIFT_COLLAR(BIST_SHIFT_COLLAR_ts3), 
      .BIST_TESTDATA_SELECT_TO_COLLAR(BIST_TESTDATA_SELECT_TO_COLLAR_ts3), .MEM0_BIST_COLLAR_SI(MEM0_BIST_COLLAR_SI_ts3), 
      .MEM1_BIST_COLLAR_SI(MEM1_BIST_COLLAR_SI_ts2), .MEM2_BIST_COLLAR_SI(MEM2_BIST_COLLAR_SI_ts2), 
      .MEM3_BIST_COLLAR_SI(MEM3_BIST_COLLAR_SI_ts2), .BIST_COLLAR_SETUP(BIST_COLLAR_SETUP_ts3), 
      .BIST_COLLAR_OPSET_SELECT(BIST_COLLAR_OPSET_SELECT_ts3), .BIST_COLLAR_HOLD(BIST_COLLAR_HOLD_ts3), 
      .FREEZE_STOP_ERROR(FREEZE_STOP_ERROR_ts3), .ERROR_CNT_ZERO(ERROR_CNT_ZERO_ts3), 
      .BIST_COLLAR_DIAG_EN(BIST_COLLAR_DIAG_EN_ts3), .BIST_COLLAR_BIRA_EN(BIST_COLLAR_BIRA_EN_ts3), 
      .BIST_CLEAR_DEFAULT(BIST_CLEAR_DEFAULT_ts3), .BIST_CLEAR(BIST_CLEAR_ts3), 
      .MBISTPG_SO(MBISTPG_SO_ts3), .PriorityColumn(PriorityColumn_ts3), .BIST_CONREAD_ROWADDRESS(BIST_CONREAD_ROWADDRESS_ts3), 
      .BIST_CONREAD_COLUMNADDRESS(BIST_CONREAD_COLUMNADDRESS_ts3), .BIST_CONREAD_ENABLE(BIST_CONREAD_ENABLE_ts3), 
      .BIST_CONWRITE_ROWADDRESS(BIST_CONWRITE_ROWADDRESS_ts3), .BIST_CONWRITE_ENABLE(BIST_CONWRITE_ENABLE_ts3), 
      .BIST_READENABLE(BIST_READENABLE_ts3), .BIST_WRITEENABLE(BIST_WRITEENABLE_ts3), 
      .BIST_SHADOW_READENABLE(BIST_SHADOW_READENABLE_ts3), .BIST_SHADOW_READADDRESS(BIST_SHADOW_READADDRESS_ts3), 
      .BIST_CMP(BIST_CMP_ts3), .BIST_COLLAR_EN0(BIST_COLLAR_EN0_ts3), .BIST_RUN_TO_COLLAR0(BIST_RUN_TO_COLLAR0_ts3), 
      .BIST_COLLAR_EN1(BIST_COLLAR_EN1_ts2), .BIST_RUN_TO_COLLAR1(BIST_RUN_TO_COLLAR1_ts2), 
      .BIST_COLLAR_EN2(BIST_COLLAR_EN2_ts2), .BIST_RUN_TO_COLLAR2(BIST_RUN_TO_COLLAR2_ts2), 
      .BIST_COLLAR_EN3(BIST_COLLAR_EN3_ts2), .BIST_RUN_TO_COLLAR3(BIST_RUN_TO_COLLAR3_ts2), 
      .MBISTPG_GO(MBISTPG_GO_ts3), .MBISTPG_STABLE(MBISTPG_STABLE_ts3), .MBISTPG_DONE(MBISTPG_DONE_ts3), 
      .BIST_ON_TO_COLLAR(BIST_ON_TO_COLLAR_ts3), .BIST_SHIFT_BIRA_COLLAR(BIST_SHIFT_BIRA_COLLAR_ts3), 
      .GO_ID_REG_SEL(GO_ID_REG_SEL_ts3), .ALGO_SEL_REG(ALGO_SEL_REG_ts3), .fscan_clkungate(fscan_clkungate)
  );

  hlp_msec_apr_rtl_tessent_mbist_RF_c5_controller hlp_msec_apr_rtl_tessent_mbist_RF_c5_controller_inst(
      .MBIST_RA_PRSRV_FUSE_VAL(PRESERVE_FUSE_REGISTER), .MBISTPG_ALGO_SEL({
      BIST_ALGO_SEL_ts6, BIST_ALGO_SEL_ts5, BIST_ALGO_SEL_ts4, 
      BIST_ALGO_SEL_ts3, BIST_ALGO_SEL_ts2, BIST_ALGO_SEL_ts1, BIST_ALGO_SEL}), .MBISTPG_SELECT_COMMON_ALGO(BIST_SELECT_COMMON_ALGO), 
      .MBISTPG_OPSET_SELECT(BIST_OPSET_SEL), .MBISTPG_SELECT_COMMON_OPSET(BIST_SELECT_COMMON_OPSET), 
      .MBISTPG_DATA_INV_ROW_ADD_BIT_SELECT_EN(BIST_DATA_INV_ROW_ADD_BIT_SELECT_EN), 
      .MBISTPG_DATA_INV_ROW_ADD_BIT_SELECT(BIST_DATA_INV_ROW_ADD_BIT_SEL), .MBISTPG_DATA_INV_COL_ADD_BIT_SELECT_EN(BIST_DATA_INV_COL_ADD_BIT_SELECT_EN), 
      .MBISTPG_DATA_INV_COL_ADD_BIT_SELECT(BIST_DATA_INV_COL_ADD_BIT_SEL), .MBISTPG_ALGO_MODE({
      BIST_ALGO_MODE1, BIST_ALGO_MODE0}), .MBISTPG_MEM_RST(ENABLE_MEM_RESET), .MBISTPG_REDUCED_ADDR_CNT_EN(REDUCED_ADDRESS_COUNT), 
      .MEM_BYPASS_EN(memory_bypass_to_en), .MCP_BOUNDING_EN(mcp_bounding_to_en), 
      .MEM0_BIST_COLLAR_SO(BIST_SO_ts15), .MEM1_BIST_COLLAR_SO(BIST_SO_ts29), .MEM2_BIST_COLLAR_SO(BIST_SO_ts30), 
      .MEM3_BIST_COLLAR_SO(BIST_SO_ts31), .FL_CNT_MODE({FL_CNT_MODE1, 
      FL_CNT_MODE0}), .MBISTPG_BIRA_EN(BIRA_EN), .CHECK_REPAIR_NEEDED(CHECK_REPAIR_NEEDED), 
      .BIST_COLLAR_GO({BIST_GO_ts31, BIST_GO_ts30, BIST_GO_ts29, 
      BIST_GO_ts15}), .MBISTPG_DIAG_EN(BIST_DIAG_EN), .BIST_CLK(gclk), .BIST_SI(toBist[4]), 
      .BIST_HOLD(BIST_HOLD), .BIST_SETUP2(BIST_SETUP_ts3), .BIST_SETUP({
      BIST_SETUP_ts2, BIST_SETUP_ts1}), .MBISTPG_TESTDATA_SELECT(BIST_SELECT_TEST_DATA), 
      .TCK(to_controllers_tck), .TCK_RETIME(to_controllers_tck_retime), .MBISTPG_EN(bistEn[4]), 
      .MBISTPG_ASYNC_RESETN(BIST_ASYNC_RESET), .LV_TM(ltest_to_en_ts1), .MBISTPG_MEM_ARRAY_DUMP_MODE(MEM_ARRAY_DUMP_MODE), 
      .BIST_CLEAR_BIRA(BIST_CLEAR_BIRA_ts4), .MBISTPG_RESET_REG_SETUP2(MBISTPG_RESET_REG_SETUP2_ts4), 
      .BIST_COL_ADD(BIST_COL_ADD_ts1), .BIST_ROW_ADD(BIST_ROW_ADD_ts4[4:0]), .BIST_WRITE_DATA(BIST_WRITE_DATA_ts4[7:0]), 
      .BIST_EXPECT_DATA(BIST_EXPECT_DATA_ts4[7:0]), .BIST_SHIFT_COLLAR(BIST_SHIFT_COLLAR_ts4), 
      .BIST_TESTDATA_SELECT_TO_COLLAR(BIST_TESTDATA_SELECT_TO_COLLAR_ts4), .MEM0_BIST_COLLAR_SI(MEM0_BIST_COLLAR_SI_ts4), 
      .MEM1_BIST_COLLAR_SI(MEM1_BIST_COLLAR_SI_ts3), .MEM2_BIST_COLLAR_SI(MEM2_BIST_COLLAR_SI_ts3), 
      .MEM3_BIST_COLLAR_SI(MEM3_BIST_COLLAR_SI_ts3), .BIST_COLLAR_SETUP(BIST_COLLAR_SETUP_ts4), 
      .BIST_COLLAR_OPSET_SELECT(BIST_COLLAR_OPSET_SELECT_ts4), .BIST_COLLAR_HOLD(BIST_COLLAR_HOLD_ts4), 
      .FREEZE_STOP_ERROR(FREEZE_STOP_ERROR_ts4), .ERROR_CNT_ZERO(ERROR_CNT_ZERO_ts4), 
      .BIST_COLLAR_DIAG_EN(BIST_COLLAR_DIAG_EN_ts4), .BIST_COLLAR_BIRA_EN(BIST_COLLAR_BIRA_EN_ts4), 
      .BIST_CLEAR_DEFAULT(BIST_CLEAR_DEFAULT_ts4), .BIST_CLEAR(BIST_CLEAR_ts4), 
      .MBISTPG_SO(MBISTPG_SO_ts4), .PriorityColumn(PriorityColumn_ts4), .BIST_CONREAD_ROWADDRESS(BIST_CONREAD_ROWADDRESS_ts4), 
      .BIST_CONREAD_COLUMNADDRESS(BIST_CONREAD_COLUMNADDRESS_ts4), .BIST_CONREAD_ENABLE(BIST_CONREAD_ENABLE_ts4), 
      .BIST_CONWRITE_ROWADDRESS(BIST_CONWRITE_ROWADDRESS_ts4), .BIST_CONWRITE_ENABLE(BIST_CONWRITE_ENABLE_ts4), 
      .BIST_READENABLE(BIST_READENABLE_ts4), .BIST_WRITEENABLE(BIST_WRITEENABLE_ts4), 
      .BIST_SHADOW_READENABLE(BIST_SHADOW_READENABLE_ts4), .BIST_SHADOW_READADDRESS(BIST_SHADOW_READADDRESS_ts4), 
      .BIST_CMP(BIST_CMP_ts4), .BIST_COLLAR_EN0(BIST_COLLAR_EN0_ts4), .BIST_RUN_TO_COLLAR0(BIST_RUN_TO_COLLAR0_ts4), 
      .BIST_COLLAR_EN1(BIST_COLLAR_EN1_ts3), .BIST_RUN_TO_COLLAR1(BIST_RUN_TO_COLLAR1_ts3), 
      .BIST_COLLAR_EN2(BIST_COLLAR_EN2_ts3), .BIST_RUN_TO_COLLAR2(BIST_RUN_TO_COLLAR2_ts3), 
      .BIST_COLLAR_EN3(BIST_COLLAR_EN3_ts3), .BIST_RUN_TO_COLLAR3(BIST_RUN_TO_COLLAR3_ts3), 
      .MBISTPG_GO(MBISTPG_GO_ts4), .MBISTPG_STABLE(MBISTPG_STABLE_ts4), .MBISTPG_DONE(MBISTPG_DONE_ts4), 
      .BIST_ON_TO_COLLAR(BIST_ON_TO_COLLAR_ts4), .BIST_SHIFT_BIRA_COLLAR(BIST_SHIFT_BIRA_COLLAR_ts4), 
      .GO_ID_REG_SEL(GO_ID_REG_SEL_ts4), .ALGO_SEL_REG(ALGO_SEL_REG_ts4), .fscan_clkungate(fscan_clkungate)
  );

  hlp_msec_apr_rtl_tessent_mbist_RF_c6_controller hlp_msec_apr_rtl_tessent_mbist_RF_c6_controller_inst(
      .MBIST_RA_PRSRV_FUSE_VAL(PRESERVE_FUSE_REGISTER), .MBISTPG_ALGO_SEL({
      BIST_ALGO_SEL_ts6, BIST_ALGO_SEL_ts5, BIST_ALGO_SEL_ts4, 
      BIST_ALGO_SEL_ts3, BIST_ALGO_SEL_ts2, BIST_ALGO_SEL_ts1, BIST_ALGO_SEL}), .MBISTPG_SELECT_COMMON_ALGO(BIST_SELECT_COMMON_ALGO), 
      .MBISTPG_OPSET_SELECT(BIST_OPSET_SEL), .MBISTPG_SELECT_COMMON_OPSET(BIST_SELECT_COMMON_OPSET), 
      .MBISTPG_DATA_INV_ROW_ADD_BIT_SELECT_EN(BIST_DATA_INV_ROW_ADD_BIT_SELECT_EN), 
      .MBISTPG_DATA_INV_ROW_ADD_BIT_SELECT(BIST_DATA_INV_ROW_ADD_BIT_SEL), .MBISTPG_DATA_INV_COL_ADD_BIT_SELECT_EN(BIST_DATA_INV_COL_ADD_BIT_SELECT_EN), 
      .MBISTPG_DATA_INV_COL_ADD_BIT_SELECT(BIST_DATA_INV_COL_ADD_BIT_SEL), .MBISTPG_ALGO_MODE({
      BIST_ALGO_MODE1, BIST_ALGO_MODE0}), .MBISTPG_MEM_RST(ENABLE_MEM_RESET), .MBISTPG_REDUCED_ADDR_CNT_EN(REDUCED_ADDRESS_COUNT), 
      .MEM_BYPASS_EN(memory_bypass_to_en), .MCP_BOUNDING_EN(mcp_bounding_to_en), 
      .MEM0_BIST_COLLAR_SO(BIST_SO_ts24), .MEM1_BIST_COLLAR_SO(BIST_SO_ts25), .FL_CNT_MODE({
      FL_CNT_MODE1, FL_CNT_MODE0}), .MBISTPG_BIRA_EN(BIRA_EN), .CHECK_REPAIR_NEEDED(CHECK_REPAIR_NEEDED), 
      .BIST_COLLAR_GO({BIST_GO_ts25, BIST_GO_ts24}), .MBISTPG_DIAG_EN(BIST_DIAG_EN), 
      .BIST_CLK(gclk), .BIST_SI(toBist[5]), .BIST_HOLD(BIST_HOLD), .BIST_SETUP2(BIST_SETUP_ts3), 
      .BIST_SETUP({BIST_SETUP_ts2, BIST_SETUP_ts1}), .MBISTPG_TESTDATA_SELECT(BIST_SELECT_TEST_DATA), 
      .TCK(to_controllers_tck), .TCK_RETIME(to_controllers_tck_retime), .MBISTPG_EN(bistEn[5]), 
      .MBISTPG_ASYNC_RESETN(BIST_ASYNC_RESET), .LV_TM(ltest_to_en_ts1), .MBISTPG_MEM_ARRAY_DUMP_MODE(MEM_ARRAY_DUMP_MODE), 
      .BIST_CLEAR_BIRA(BIST_CLEAR_BIRA_ts5), .MBISTPG_RESET_REG_SETUP2(MBISTPG_RESET_REG_SETUP2_ts5), 
      .BIST_COL_ADD(BIST_COL_ADD_ts2), .BIST_ROW_ADD(BIST_ROW_ADD_ts5[4:0]), .BIST_BANK_ADD(BIST_BANK_ADD_ts1[1:0]), 
      .BIST_WRITE_DATA(BIST_WRITE_DATA_ts5[7:0]), .BIST_EXPECT_DATA(BIST_EXPECT_DATA_ts5[7:0]), 
      .BIST_SHIFT_COLLAR(BIST_SHIFT_COLLAR_ts5), .BIST_TESTDATA_SELECT_TO_COLLAR(BIST_TESTDATA_SELECT_TO_COLLAR_ts5), 
      .MEM0_BIST_COLLAR_SI(MEM0_BIST_COLLAR_SI_ts5), .MEM1_BIST_COLLAR_SI(MEM1_BIST_COLLAR_SI_ts4), 
      .BIST_COLLAR_SETUP(BIST_COLLAR_SETUP_ts5), .BIST_COLLAR_OPSET_SELECT(BIST_COLLAR_OPSET_SELECT_ts5), 
      .BIST_COLLAR_HOLD(BIST_COLLAR_HOLD_ts5), .FREEZE_STOP_ERROR(FREEZE_STOP_ERROR_ts5), 
      .ERROR_CNT_ZERO(ERROR_CNT_ZERO_ts5), .BIST_COLLAR_DIAG_EN(BIST_COLLAR_DIAG_EN_ts5), 
      .BIST_COLLAR_BIRA_EN(BIST_COLLAR_BIRA_EN_ts5), .BIST_CLEAR_DEFAULT(BIST_CLEAR_DEFAULT_ts5), 
      .BIST_CLEAR(BIST_CLEAR_ts5), .MBISTPG_SO(MBISTPG_SO_ts5), .PriorityColumn(PriorityColumn_ts5), 
      .BIST_CONREAD_ROWADDRESS(BIST_CONREAD_ROWADDRESS_ts5), .BIST_CONREAD_COLUMNADDRESS(BIST_CONREAD_COLUMNADDRESS_ts5), 
      .BIST_CONREAD_ENABLE(BIST_CONREAD_ENABLE_ts5), .BIST_CONWRITE_ROWADDRESS(BIST_CONWRITE_ROWADDRESS_ts5), 
      .BIST_CONWRITE_ENABLE(BIST_CONWRITE_ENABLE_ts5), .BIST_READENABLE(BIST_READENABLE_ts5), 
      .BIST_WRITEENABLE(BIST_WRITEENABLE_ts5), .BIST_SHADOW_READENABLE(BIST_SHADOW_READENABLE_ts5), 
      .BIST_SHADOW_READADDRESS(BIST_SHADOW_READADDRESS_ts5), .BIST_CMP(BIST_CMP_ts5), 
      .BIST_COLLAR_EN0(BIST_COLLAR_EN0_ts5), .BIST_RUN_TO_COLLAR0(BIST_RUN_TO_COLLAR0_ts5), 
      .BIST_COLLAR_EN1(BIST_COLLAR_EN1_ts4), .BIST_RUN_TO_COLLAR1(BIST_RUN_TO_COLLAR1_ts4), 
      .MBISTPG_GO(MBISTPG_GO_ts5), .MBISTPG_STABLE(MBISTPG_STABLE_ts5), .MBISTPG_DONE(MBISTPG_DONE_ts5), 
      .BIST_ON_TO_COLLAR(BIST_ON_TO_COLLAR_ts5), .BIST_SHIFT_BIRA_COLLAR(BIST_SHIFT_BIRA_COLLAR_ts5), 
      .GO_ID_REG_SEL(GO_ID_REG_SEL_ts5), .ALGO_SEL_REG(ALGO_SEL_REG_ts5), .fscan_clkungate(fscan_clkungate)
  );

  assign BIST_SETUP_ts1 = BIST_SETUP[0];

  assign BIST_SETUP_ts2 = BIST_SETUP[1];

  assign BIST_SETUP_ts3 = BIST_SETUP[2];

  TS_CLK_MUX tessent_persistent_cell_tck_mux_hlp_msec_apr_rtl_clk_inst(
      .ck0(clk), .ck1(ijtag_to_tck), .s(tck_select), .o(clk_ts1)
  );

  hlp_msec_apr_rtl_tessent_mbist_diagnosis_ready hlp_msec_apr_rtl_tessent_mbist_diagnosis_ready_inst(
      .ijtag_reset(ijtag_to_reset), .ijtag_sel(ijtag_to_sel), .ijtag_si(hlp_msec_apr_rtl_tessent_mbist_bap_inst_so), 
      .ijtag_ce(ijtag_to_ce), .ijtag_se(ijtag_to_se), .ijtag_ue(ijtag_to_ue), .ijtag_tck(ijtag_to_tck), 
      .ijtag_so(ijtag_so), .DiagnosisReady_ctl_in({MBISTPG_STABLE_ts5, 
      MBISTPG_STABLE_ts4, MBISTPG_STABLE_ts3, MBISTPG_STABLE_ts2, 
      MBISTPG_STABLE_ts1, MBISTPG_STABLE}), .DiagnosisReady_aux_in(1'b1), .StableBlock(mbist_diag_done)
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
      .select_rom(), .select_sram()
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