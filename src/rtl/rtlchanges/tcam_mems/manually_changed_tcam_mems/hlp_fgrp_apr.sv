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

// GENERATED CODE -- DO NOT EDIT


`include "hlp_fgrp_mem.def"
`include "hlp_fghash_mem.def"


module hlp_fgrp_apr
(
output logic fet_ack_b,
input logic [$bits(hlp_pkg::imn_broadcast_t)-1:0] i_broadcast,
input logic fet_en_b,
output logic [8:0] avisa_unit_id_p1,
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
input hlp_post_mux_ctrl,
input hlp_post_clkungate,
// Beginning of automatic inputs (from unused autoinst inputs)
input logic             DFTMASK,                // To u_fgrp_apr_sram_mems of hlp_fgrp_apr_sram_mems.v, ...
input logic             DFTSHIFTEN,             // To u_fgrp_apr_sram_mems of hlp_fgrp_apr_sram_mems.v, ...
input logic             DFT_AFD_RESET_B,        // To u_fgrp_apr_sram_mems of hlp_fgrp_apr_sram_mems.v, ...
input logic             DFT_ARRAY_FREEZE,       // To u_fgrp_apr_sram_mems of hlp_fgrp_apr_sram_mems.v, ...
input logic             clk,                    // To u_fgrp_apr_sram_mems of hlp_fgrp_apr_sram_mems.v, ...
input logic [6:0]       fary_ffuse_hd2prf_trim, // To u_fgrp_apr_rf_mems of hlp_fgrp_apr_rf_mems.v
input logic [16:0]      fary_ffuse_hdusplr_trim,// To u_fgrp_apr_sram_mems of hlp_fgrp_apr_sram_mems.v
input logic [16:0]      fary_ffuse_hduspsr_trim,// To u_fgrp_apr_sram_mems of hlp_fgrp_apr_sram_mems.v
input logic [1:0]       fary_ffuse_rf_sleep,    // To u_fgrp_apr_rf_mems of hlp_fgrp_apr_rf_mems.v
input logic [1:0]       fary_ffuse_sram_sleep,  // To u_fgrp_apr_sram_mems of hlp_fgrp_apr_sram_mems.v
input logic             fary_ffuse_tcam_sleep,  // To u_fgrp_apr_tcam_mems of hlp_fgrp_apr_tcam_mems.v
input logic [15:0]      fary_ffuse_tune_tcam,   // To u_fgrp_apr_tcam_mems of hlp_fgrp_apr_tcam_mems.v
input logic             fary_output_reset,      // To u_fgrp_apr_sram_mems of hlp_fgrp_apr_sram_mems.v, ...
input logic             fscan_byprst_b,         // To u_fgrp_apr_func_logic of hlp_fgrp_apr_func_logic.v
input logic [hlp_dfx_pkg::FGRP_NUM_CLKGENCTRL-1:0] fscan_clkgenctrl,// To u_fgrp_apr_func_logic of hlp_fgrp_apr_func_logic.v
input logic [hlp_dfx_pkg::FGRP_NUM_CLKGENCTRLEN-1:0] fscan_clkgenctrlen,// To u_fgrp_apr_func_logic of hlp_fgrp_apr_func_logic.v
input logic             fscan_clkungate,        // To u_fgrp_apr_sram_mems of hlp_fgrp_apr_sram_mems.v, ...
input logic             fscan_clkungate_syn,    // To u_fgrp_apr_func_logic of hlp_fgrp_apr_func_logic.v
input logic             fscan_latchclosed_b,    // To u_fgrp_apr_func_logic of hlp_fgrp_apr_func_logic.v
input logic             fscan_latchopen,        // To u_fgrp_apr_func_logic of hlp_fgrp_apr_func_logic.v
input logic             fscan_mode,             // To u_fgrp_apr_tcam_mems of hlp_fgrp_apr_tcam_mems.v, ...
input logic             fscan_mode_atspeed,     // To u_fgrp_apr_func_logic of hlp_fgrp_apr_func_logic.v
input logic             fscan_ram_bypsel_rf,    // To u_fgrp_apr_rf_mems of hlp_fgrp_apr_rf_mems.v
input logic             fscan_ram_bypsel_sram,  // To u_fgrp_apr_sram_mems of hlp_fgrp_apr_sram_mems.v
input logic             fscan_ram_bypsel_tcam,  // To u_fgrp_apr_tcam_mems of hlp_fgrp_apr_tcam_mems.v
input logic             fscan_ram_init_en,      // To u_fgrp_apr_sram_mems of hlp_fgrp_apr_sram_mems.v, ...
input logic             fscan_ram_init_val,     // To u_fgrp_apr_sram_mems of hlp_fgrp_apr_sram_mems.v, ...
input logic             fscan_ram_rdis_b,       // To u_fgrp_apr_sram_mems of hlp_fgrp_apr_sram_mems.v, ...
input logic             fscan_ram_wdis_b,       // To u_fgrp_apr_sram_mems of hlp_fgrp_apr_sram_mems.v, ...
input logic             fscan_ret_ctrl,         // To u_fgrp_apr_func_logic of hlp_fgrp_apr_func_logic.v
input logic             fscan_rstbypen,         // To u_fgrp_apr_func_logic of hlp_fgrp_apr_func_logic.v
input logic [hlp_dfx_pkg::FGRP_NUM_SDI-1:0] fscan_sdi,// To u_fgrp_apr_func_logic of hlp_fgrp_apr_func_logic.v
input logic             fscan_shiften,          // To u_fgrp_apr_tcam_mems of hlp_fgrp_apr_tcam_mems.v, ...
input logic             fsta_dfxact_afd,        // To u_fgrp_apr_sram_mems of hlp_fgrp_apr_sram_mems.v, ...
input logic             fvisa_all_dis,          // To u_fgrp_apr_func_logic of hlp_fgrp_apr_func_logic.v
input logic [hlp_dfx_pkg::NUM_VISA_LANES-1:0] fvisa_clk,// To u_fgrp_apr_func_logic of hlp_fgrp_apr_func_logic.v
input logic             fvisa_customer_dis,     // To u_fgrp_apr_func_logic of hlp_fgrp_apr_func_logic.v
input logic [hlp_dfx_pkg::VISA_DBG_LANE_WIDTH-1:0] fvisa_dbg_lane,// To u_fgrp_apr_func_logic of hlp_fgrp_apr_func_logic.v
input logic             fvisa_frame,            // To u_fgrp_apr_func_logic of hlp_fgrp_apr_func_logic.v
input logic             fvisa_rddata,           // To u_fgrp_apr_func_logic of hlp_fgrp_apr_func_logic.v
input logic             fvisa_resetb,           // To u_fgrp_apr_func_logic of hlp_fgrp_apr_func_logic.v
input logic             fvisa_serdata,          // To u_fgrp_apr_func_logic of hlp_fgrp_apr_func_logic.v
input logic             fvisa_serstb,           // To u_fgrp_apr_func_logic of hlp_fgrp_apr_func_logic.v
input logic [8:0]       fvisa_unit_id,          // To u_fgrp_apr_func_logic of hlp_fgrp_apr_func_logic.v
input logic [1:0] [$bits(hlp_ipp_pkg::ffu_row_data_t)-1:0] i_data, // To u_fgrp_apr_func_logic of hlp_fgrp_apr_func_logic.v
input logic [1:0]       i_data_v,               // To u_fgrp_apr_func_logic of hlp_fgrp_apr_func_logic.v
input logic             i_fgrp_visa_enable,     // To u_fgrp_apr_func_logic of hlp_fgrp_apr_func_logic.v
input logic [$bits(hlp_ipp_pkg::group_data_t)-1:0] i_grp,          // To u_fgrp_apr_func_logic of hlp_fgrp_apr_func_logic.v
input logic [$bits(hlp_ffu_pkg::group_nr_t)-1:0] i_grp_nr,         // To u_fgrp_apr_func_logic of hlp_fgrp_apr_func_logic.v
input logic             i_grp_v,                // To u_fgrp_apr_func_logic of hlp_fgrp_apr_func_logic.v
input logic [$bits(hlp_pkg::mgmt64_t)-1:0] i_mgmt,                 // To u_fgrp_apr_func_logic of hlp_fgrp_apr_func_logic.v
input logic             i_mgmt_v,               // To u_fgrp_apr_func_logic of hlp_fgrp_apr_func_logic.v
input logic             isol_en_b,              // To u_fgrp_apr_sram_mems of hlp_fgrp_apr_sram_mems.v, ...
input logic [4:0]       pwr_mgmt_in_rf,         // To u_fgrp_apr_rf_mems of hlp_fgrp_apr_rf_mems.v
input logic [5:0]       pwr_mgmt_in_sram,       // To u_fgrp_apr_sram_mems of hlp_fgrp_apr_sram_mems.v
input logic             rst_n,                  // To u_fgrp_apr_func_logic of hlp_fgrp_apr_func_logic.v
// End of automatics
/*AUTOOUTPUT*/
// Beginning of automatic outputs (from unused autoinst outputs)
output logic [hlp_dfx_pkg::FGRP_NUM_SDO-1:0] ascan_sdo,// From u_fgrp_apr_func_logic of hlp_fgrp_apr_func_logic.v
output logic            avisa_all_dis,          // From u_fgrp_apr_func_logic of hlp_fgrp_apr_func_logic.v
output logic [hlp_dfx_pkg::NUM_VISA_LANES-1:0] avisa_clk,// From u_fgrp_apr_func_logic of hlp_fgrp_apr_func_logic.v
output logic            avisa_customer_dis,     // From u_fgrp_apr_func_logic of hlp_fgrp_apr_func_logic.v
output logic [hlp_dfx_pkg::VISA_DBG_LANE_WIDTH-1:0] avisa_dbg_lane,// From u_fgrp_apr_func_logic of hlp_fgrp_apr_func_logic.v
output logic            avisa_frame,            // From u_fgrp_apr_func_logic of hlp_fgrp_apr_func_logic.v
output logic            avisa_rddata,           // From u_fgrp_apr_func_logic of hlp_fgrp_apr_func_logic.v
output logic            avisa_serdata,          // From u_fgrp_apr_func_logic of hlp_fgrp_apr_func_logic.v
output logic            avisa_serstb,           // From u_fgrp_apr_func_logic of hlp_fgrp_apr_func_logic.v
output logic            isol_ack_b,             // From u_fgrp_apr_func_logic of hlp_fgrp_apr_func_logic.v
output logic            o_fghash_ecc_int,       // From u_fgrp_apr_func_logic of hlp_fgrp_apr_func_logic.v
output logic            o_fgrp_ecc_int,         // From u_fgrp_apr_func_logic of hlp_fgrp_apr_func_logic.v
output logic [$bits(hlp_ipp_pkg::group_data_t)-1:0] o_grp,         // From u_fgrp_apr_func_logic of hlp_fgrp_apr_func_logic.v
output logic            o_grp_v,                // From u_fgrp_apr_func_logic of hlp_fgrp_apr_func_logic.v
output logic            o_mem_init_done,        // From u_fgrp_apr_func_logic of hlp_fgrp_apr_func_logic.v
output logic [$bits(hlp_pkg::mgmt64_t)-1:0] o_mgmt,                // From u_fgrp_apr_func_logic of hlp_fgrp_apr_func_logic.v
output logic            o_mgmt_v,               // From u_fgrp_apr_func_logic of hlp_fgrp_apr_func_logic.v
output logic [1:0] [$bits(hlp_ipp_pkg::ffu_row_ptr_new_t)-1:0] o_ptr,// From u_fgrp_apr_func_logic of hlp_fgrp_apr_func_logic.v
output logic [1:0]      o_ptr_v
`include "hlp_fgrp_apr.VISA_IT.hlp_fgrp_apr.port_defs.sv" // Auto Included by VISA IT - *** Do not modify this line ***
                // From u_fgrp_apr_func_logic of hlp_fgrp_apr_func_logic.v
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

//localparam N_INST_SRAM_MEMS = ; // fscan workaround
//localparam N_INST_RF_MEMS   = ; // fscan workaround



  wire [2:0] BIST_SETUP;
  wire [1:1] BIST_OPSET_SEL_ts1;
  wire [3:0] toBist, bistEn;
  wire [1:0] BIST_COL_ADD_ts1, BIST_COL_ADD_ts2;
  wire [4:0] BIST_ROW_ADD;
  wire [6:0] BIST_ROW_ADD_ts1;
  wire [7:0] BIST_ROW_ADD_ts2;
  wire [5:0] BIST_ROW_ADD_ts3;
  wire [7:0] BIST_WRITE_DATA;
  wire [31:0] BIST_WRITE_DATA_ts1, BIST_WRITE_DATA_ts2, BIST_WRITE_DATA_ts3;
  wire [7:0] BIST_EXPECT_DATA;
  wire [31:0] BIST_EXPECT_DATA_ts1, BIST_EXPECT_DATA_ts2, BIST_EXPECT_DATA_ts3;
  wire [1:0] BIST_COLLAR_OPSET_SELECT_ts3, BIST_BANK_ADD;
  wire [2:0] BIST_BANK_ADD_ts1;
  logic clk_ts1;
  wire hlp_fgrp_apr_rtl_tessent_sib_mbist_inst_so, 
       hlp_fgrp_apr_rtl_tessent_sib_sti_inst_so, 
       hlp_fgrp_apr_rtl_tessent_sib_sri_ctrl_inst_so, 
       hlp_fgrp_apr_rtl_tessent_tdr_sri_ctrl_inst_so, 
       hlp_fgrp_apr_rtl_tessent_sib_sri_inst_to_select, 
       hlp_fgrp_apr_rtl_tessent_sib_sti_inst_so_ts1, 
       hlp_fgrp_apr_rtl_tessent_tdr_RF_c1_algo_select_tdr_inst_so, 
       hlp_fgrp_apr_rtl_tessent_sib_sti_inst_to_select, 
       hlp_fgrp_apr_rtl_tessent_sib_algo_select_sib_inst_so, 
       hlp_fgrp_apr_rtl_tessent_sib_sri_ctrl_inst_to_select, 
       hlp_fgrp_apr_rtl_tessent_sib_algo_select_sib_inst_to_select, 
       hlp_fgrp_apr_rtl_tessent_tdr_TCAM_c4_algo_select_tdr_inst_so, 
       hlp_fgrp_apr_rtl_tessent_tdr_SRAM_c3_algo_select_tdr_inst_so, 
       hlp_fgrp_apr_rtl_tessent_tdr_SRAM_c2_algo_select_tdr_inst_so, 
       ijtag_to_tck, ijtag_to_ue, ijtag_to_reset, ijtag_to_se, ijtag_to_ce, 
       ijtag_to_sel, ltest_to_en, ltest_to_mem_bypass_en, ltest_to_scan_en, 
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
       GO_ID_REG_SEL_ts2, GO_ID_REG_SEL_ts3, 
       BIST_DATA_INV_COL_ADD_BIT_SELECT_EN, BIST_ALGO_MODE0, BIST_ALGO_MODE1, 
       ENABLE_MEM_RESET, REDUCED_ADDRESS_COUNT, BIST_CLEAR_BIRA, 
       BIST_COLLAR_DIAG_EN, BIST_COLLAR_BIRA_EN, PriorityColumn, 
       BIST_SHIFT_BIRA_COLLAR, BIST_CLEAR_BIRA_ts1, BIST_COLLAR_DIAG_EN_ts1, 
       BIST_COLLAR_BIRA_EN_ts1, PriorityColumn_ts1, BIST_SHIFT_BIRA_COLLAR_ts1, 
       BIST_CLEAR_BIRA_ts2, BIST_COLLAR_DIAG_EN_ts2, BIST_COLLAR_BIRA_EN_ts2, 
       PriorityColumn_ts2, BIST_SHIFT_BIRA_COLLAR_ts2, BIST_CLEAR_BIRA_ts3, 
       BIST_COLLAR_DIAG_EN_ts3, BIST_COLLAR_BIRA_EN_ts3, 
       BIST_SHIFT_BIRA_COLLAR_ts3, MEM_ARRAY_DUMP_MODE, BIST_DIAG_EN, 
       BIST_ASYNC_RESET, MEM0_BIST_COLLAR_SI, MEM1_BIST_COLLAR_SI, 
       MEM2_BIST_COLLAR_SI, MEM3_BIST_COLLAR_SI, MEM4_BIST_COLLAR_SI, 
       MEM5_BIST_COLLAR_SI, MEM6_BIST_COLLAR_SI, MEM7_BIST_COLLAR_SI, 
       MEM8_BIST_COLLAR_SI, MEM9_BIST_COLLAR_SI, MEM10_BIST_COLLAR_SI, 
       MEM11_BIST_COLLAR_SI, MEM12_BIST_COLLAR_SI, MEM13_BIST_COLLAR_SI, 
       MEM14_BIST_COLLAR_SI, MEM15_BIST_COLLAR_SI, MEM0_BIST_COLLAR_SI_ts1, 
       MEM1_BIST_COLLAR_SI_ts1, MEM2_BIST_COLLAR_SI_ts1, 
       MEM3_BIST_COLLAR_SI_ts1, MEM0_BIST_COLLAR_SI_ts2, 
       MEM1_BIST_COLLAR_SI_ts2, MEM2_BIST_COLLAR_SI_ts2, 
       MEM3_BIST_COLLAR_SI_ts2, MEM4_BIST_COLLAR_SI_ts1, 
       MEM5_BIST_COLLAR_SI_ts1, MEM6_BIST_COLLAR_SI_ts1, 
       MEM7_BIST_COLLAR_SI_ts1, MEM8_BIST_COLLAR_SI_ts1, 
       MEM9_BIST_COLLAR_SI_ts1, MEM10_BIST_COLLAR_SI_ts1, 
       MEM11_BIST_COLLAR_SI_ts1, MEM12_BIST_COLLAR_SI_ts1, 
       MEM13_BIST_COLLAR_SI_ts1, MEM14_BIST_COLLAR_SI_ts1, 
       MEM15_BIST_COLLAR_SI_ts1, MEM16_BIST_COLLAR_SI, MEM17_BIST_COLLAR_SI, 
       MEM18_BIST_COLLAR_SI, MEM19_BIST_COLLAR_SI, MEM0_BIST_COLLAR_SI_ts3, 
       MEM1_BIST_COLLAR_SI_ts3, MEM2_BIST_COLLAR_SI_ts3, 
       MEM3_BIST_COLLAR_SI_ts3, MEM4_BIST_COLLAR_SI_ts2, 
       MEM5_BIST_COLLAR_SI_ts2, MEM6_BIST_COLLAR_SI_ts2, 
       MEM7_BIST_COLLAR_SI_ts2, MEM8_BIST_COLLAR_SI_ts2, 
       MEM9_BIST_COLLAR_SI_ts2, MEM10_BIST_COLLAR_SI_ts2, 
       MEM11_BIST_COLLAR_SI_ts2, MEM12_BIST_COLLAR_SI_ts2, 
       MEM13_BIST_COLLAR_SI_ts2, MEM14_BIST_COLLAR_SI_ts2, 
       MEM15_BIST_COLLAR_SI_ts2, MEM16_BIST_COLLAR_SI_ts1, 
       MEM17_BIST_COLLAR_SI_ts1, MEM18_BIST_COLLAR_SI_ts1, 
       MEM19_BIST_COLLAR_SI_ts1, MEM20_BIST_COLLAR_SI, MEM21_BIST_COLLAR_SI, 
       MEM22_BIST_COLLAR_SI, MEM23_BIST_COLLAR_SI, MEM24_BIST_COLLAR_SI, 
       MEM25_BIST_COLLAR_SI, MEM26_BIST_COLLAR_SI, MEM27_BIST_COLLAR_SI, 
       MEM28_BIST_COLLAR_SI, MEM29_BIST_COLLAR_SI, MEM30_BIST_COLLAR_SI, 
       MEM31_BIST_COLLAR_SI, MBISTPG_SO, MBISTPG_SO_ts1, MBISTPG_SO_ts2, 
       MBISTPG_SO_ts3, BIST_SO, BIST_SO_ts1, BIST_SO_ts2, BIST_SO_ts3, 
       BIST_SO_ts4, BIST_SO_ts5, BIST_SO_ts6, BIST_SO_ts7, BIST_SO_ts8, 
       BIST_SO_ts9, BIST_SO_ts10, BIST_SO_ts11, BIST_SO_ts12, BIST_SO_ts13, 
       BIST_SO_ts14, BIST_SO_ts15, BIST_SO_ts16, BIST_SO_ts17, BIST_SO_ts18, 
       BIST_SO_ts19, BIST_SO_ts20, BIST_SO_ts21, BIST_SO_ts22, BIST_SO_ts23, 
       BIST_SO_ts24, BIST_SO_ts25, BIST_SO_ts26, BIST_SO_ts27, BIST_SO_ts28, 
       BIST_SO_ts29, BIST_SO_ts30, BIST_SO_ts31, BIST_SO_ts32, BIST_SO_ts33, 
       BIST_SO_ts34, BIST_SO_ts35, BIST_SO_ts36, BIST_SO_ts37, BIST_SO_ts38, 
       BIST_SO_ts39, BIST_SO_ts40, BIST_SO_ts41, BIST_SO_ts42, BIST_SO_ts43, 
       BIST_SO_ts44, BIST_SO_ts45, BIST_SO_ts46, BIST_SO_ts47, BIST_SO_ts48, 
       BIST_SO_ts49, BIST_SO_ts50, BIST_SO_ts51, BIST_SO_ts52, BIST_SO_ts53, 
       BIST_SO_ts54, BIST_SO_ts55, BIST_SO_ts56, BIST_SO_ts57, BIST_SO_ts58, 
       BIST_SO_ts59, BIST_SO_ts60, BIST_SO_ts61, BIST_SO_ts62, BIST_SO_ts63, 
       BIST_SO_ts64, BIST_SO_ts65, BIST_SO_ts66, BIST_SO_ts67, BIST_SO_ts68, 
       BIST_SO_ts69, BIST_SO_ts70, BIST_SO_ts71, MBISTPG_DONE, MBISTPG_DONE_ts1, 
       MBISTPG_DONE_ts2, MBISTPG_DONE_ts3, MBISTPG_GO, MBISTPG_GO_ts1, 
       MBISTPG_GO_ts2, MBISTPG_GO_ts3, BIST_GO, BIST_GO_ts1, BIST_GO_ts2, 
       BIST_GO_ts3, BIST_GO_ts4, BIST_GO_ts5, BIST_GO_ts6, BIST_GO_ts7, 
       BIST_GO_ts8, BIST_GO_ts9, BIST_GO_ts10, BIST_GO_ts11, BIST_GO_ts12, 
       BIST_GO_ts13, BIST_GO_ts14, BIST_GO_ts15, BIST_GO_ts16, BIST_GO_ts17, 
       BIST_GO_ts18, BIST_GO_ts19, BIST_GO_ts20, BIST_GO_ts21, BIST_GO_ts22, 
       BIST_GO_ts23, BIST_GO_ts24, BIST_GO_ts25, BIST_GO_ts26, BIST_GO_ts27, 
       BIST_GO_ts28, BIST_GO_ts29, BIST_GO_ts30, BIST_GO_ts31, BIST_GO_ts32, 
       BIST_GO_ts33, BIST_GO_ts34, BIST_GO_ts35, BIST_GO_ts36, BIST_GO_ts37, 
       BIST_GO_ts38, BIST_GO_ts39, BIST_GO_ts40, BIST_GO_ts41, BIST_GO_ts42, 
       BIST_GO_ts43, BIST_GO_ts44, BIST_GO_ts45, BIST_GO_ts46, BIST_GO_ts47, 
       BIST_GO_ts48, BIST_GO_ts49, BIST_GO_ts50, BIST_GO_ts51, BIST_GO_ts52, 
       BIST_GO_ts53, BIST_GO_ts54, BIST_GO_ts55, BIST_GO_ts56, BIST_GO_ts57, 
       BIST_GO_ts58, BIST_GO_ts59, BIST_GO_ts60, BIST_GO_ts61, BIST_GO_ts62, 
       BIST_GO_ts63, BIST_GO_ts64, BIST_GO_ts65, BIST_GO_ts66, BIST_GO_ts67, 
       BIST_GO_ts68, BIST_GO_ts69, BIST_GO_ts70, BIST_GO_ts71, FL_CNT_MODE0, 
       FL_CNT_MODE1, BIST_READENABLE, BIST_WRITEENABLE, BIST_WRITEENABLE_ts1, 
       BIST_SELECT, BIST_WRITEENABLE_ts2, BIST_SELECT_ts1, BIST_USER9, 
       BIST_USER10, BIST_USER11, BIST_USER0, BIST_USER1, BIST_USER2, BIST_USER3, 
       BIST_USER4, BIST_USER5, BIST_USER6, BIST_USER7, BIST_USER8, 
       BIST_EVEN_GROUPWRITEENABLE, BIST_ODD_GROUPWRITEENABLE, 
       BIST_WRITEENABLE_ts3, BIST_READENABLE_ts1, BIST_SELECT_ts2, BIST_CMP, 
       BIST_CMP_ts1, BIST_CMP_ts2, BIST_CMP_ts3, INCLUDE_MEM_RESULTS_REG, 
       BIST_COL_ADD, BIST_COL_ADD_ts3, BIST_COLLAR_EN0, BIST_COLLAR_EN1, 
       BIST_COLLAR_EN2, BIST_COLLAR_EN3, BIST_COLLAR_EN4, BIST_COLLAR_EN5, 
       BIST_COLLAR_EN6, BIST_COLLAR_EN7, BIST_COLLAR_EN8, BIST_COLLAR_EN9, 
       BIST_COLLAR_EN10, BIST_COLLAR_EN11, BIST_COLLAR_EN12, BIST_COLLAR_EN13, 
       BIST_COLLAR_EN14, BIST_COLLAR_EN15, BIST_COLLAR_EN0_ts1, 
       BIST_COLLAR_EN1_ts1, BIST_COLLAR_EN2_ts1, BIST_COLLAR_EN3_ts1, 
       BIST_COLLAR_EN0_ts2, BIST_COLLAR_EN1_ts2, BIST_COLLAR_EN2_ts2, 
       BIST_COLLAR_EN3_ts2, BIST_COLLAR_EN4_ts1, BIST_COLLAR_EN5_ts1, 
       BIST_COLLAR_EN6_ts1, BIST_COLLAR_EN7_ts1, BIST_COLLAR_EN8_ts1, 
       BIST_COLLAR_EN9_ts1, BIST_COLLAR_EN10_ts1, BIST_COLLAR_EN11_ts1, 
       BIST_COLLAR_EN12_ts1, BIST_COLLAR_EN13_ts1, BIST_COLLAR_EN14_ts1, 
       BIST_COLLAR_EN15_ts1, BIST_COLLAR_EN16, BIST_COLLAR_EN17, 
       BIST_COLLAR_EN18, BIST_COLLAR_EN19, BIST_COLLAR_EN0_ts3, 
       BIST_COLLAR_EN1_ts3, BIST_COLLAR_EN2_ts3, BIST_COLLAR_EN3_ts3, 
       BIST_COLLAR_EN4_ts2, BIST_COLLAR_EN5_ts2, BIST_COLLAR_EN6_ts2, 
       BIST_COLLAR_EN7_ts2, BIST_COLLAR_EN8_ts2, BIST_COLLAR_EN9_ts2, 
       BIST_COLLAR_EN10_ts2, BIST_COLLAR_EN11_ts2, BIST_COLLAR_EN12_ts2, 
       BIST_COLLAR_EN13_ts2, BIST_COLLAR_EN14_ts2, BIST_COLLAR_EN15_ts2, 
       BIST_COLLAR_EN16_ts1, BIST_COLLAR_EN17_ts1, BIST_COLLAR_EN18_ts1, 
       BIST_COLLAR_EN19_ts1, BIST_COLLAR_EN20, BIST_COLLAR_EN21, 
       BIST_COLLAR_EN22, BIST_COLLAR_EN23, BIST_COLLAR_EN24, BIST_COLLAR_EN25, 
       BIST_COLLAR_EN26, BIST_COLLAR_EN27, BIST_COLLAR_EN28, BIST_COLLAR_EN29, 
       BIST_COLLAR_EN30, BIST_COLLAR_EN31, BIST_RUN_TO_COLLAR0, 
       BIST_RUN_TO_COLLAR1, BIST_RUN_TO_COLLAR2, BIST_RUN_TO_COLLAR3, 
       BIST_RUN_TO_COLLAR4, BIST_RUN_TO_COLLAR5, BIST_RUN_TO_COLLAR6, 
       BIST_RUN_TO_COLLAR7, BIST_RUN_TO_COLLAR8, BIST_RUN_TO_COLLAR9, 
       BIST_RUN_TO_COLLAR10, BIST_RUN_TO_COLLAR11, BIST_RUN_TO_COLLAR12, 
       BIST_RUN_TO_COLLAR13, BIST_RUN_TO_COLLAR14, BIST_RUN_TO_COLLAR15, 
       BIST_RUN_TO_COLLAR0_ts1, BIST_RUN_TO_COLLAR1_ts1, 
       BIST_RUN_TO_COLLAR2_ts1, BIST_RUN_TO_COLLAR3_ts1, 
       BIST_RUN_TO_COLLAR0_ts2, BIST_RUN_TO_COLLAR1_ts2, 
       BIST_RUN_TO_COLLAR2_ts2, BIST_RUN_TO_COLLAR3_ts2, 
       BIST_RUN_TO_COLLAR4_ts1, BIST_RUN_TO_COLLAR5_ts1, 
       BIST_RUN_TO_COLLAR6_ts1, BIST_RUN_TO_COLLAR7_ts1, 
       BIST_RUN_TO_COLLAR8_ts1, BIST_RUN_TO_COLLAR9_ts1, 
       BIST_RUN_TO_COLLAR10_ts1, BIST_RUN_TO_COLLAR11_ts1, 
       BIST_RUN_TO_COLLAR12_ts1, BIST_RUN_TO_COLLAR13_ts1, 
       BIST_RUN_TO_COLLAR14_ts1, BIST_RUN_TO_COLLAR15_ts1, BIST_RUN_TO_COLLAR16, 
       BIST_RUN_TO_COLLAR17, BIST_RUN_TO_COLLAR18, BIST_RUN_TO_COLLAR19, 
       BIST_RUN_TO_COLLAR0_ts3, BIST_RUN_TO_COLLAR1_ts3, 
       BIST_RUN_TO_COLLAR2_ts3, BIST_RUN_TO_COLLAR3_ts3, 
       BIST_RUN_TO_COLLAR4_ts2, BIST_RUN_TO_COLLAR5_ts2, 
       BIST_RUN_TO_COLLAR6_ts2, BIST_RUN_TO_COLLAR7_ts2, 
       BIST_RUN_TO_COLLAR8_ts2, BIST_RUN_TO_COLLAR9_ts2, 
       BIST_RUN_TO_COLLAR10_ts2, BIST_RUN_TO_COLLAR11_ts2, 
       BIST_RUN_TO_COLLAR12_ts2, BIST_RUN_TO_COLLAR13_ts2, 
       BIST_RUN_TO_COLLAR14_ts2, BIST_RUN_TO_COLLAR15_ts2, 
       BIST_RUN_TO_COLLAR16_ts1, BIST_RUN_TO_COLLAR17_ts1, 
       BIST_RUN_TO_COLLAR18_ts1, BIST_RUN_TO_COLLAR19_ts1, BIST_RUN_TO_COLLAR20, 
       BIST_RUN_TO_COLLAR21, BIST_RUN_TO_COLLAR22, BIST_RUN_TO_COLLAR23, 
       BIST_RUN_TO_COLLAR24, BIST_RUN_TO_COLLAR25, BIST_RUN_TO_COLLAR26, 
       BIST_RUN_TO_COLLAR27, BIST_RUN_TO_COLLAR28, BIST_RUN_TO_COLLAR29, 
       BIST_RUN_TO_COLLAR30, BIST_RUN_TO_COLLAR31, BIST_SHADOW_READENABLE, 
       BIST_SHADOW_READADDRESS, BIST_CONWRITE_ROWADDRESS, BIST_CONWRITE_ENABLE, 
       BIST_CONREAD_ROWADDRESS, BIST_CONREAD_COLUMNADDRESS, BIST_CONREAD_ENABLE, 
       BIST_TESTDATA_SELECT_TO_COLLAR, BIST_TESTDATA_SELECT_TO_COLLAR_ts1, 
       BIST_TESTDATA_SELECT_TO_COLLAR_ts2, BIST_TESTDATA_SELECT_TO_COLLAR_ts3, 
       BIST_ON_TO_COLLAR, BIST_ON_TO_COLLAR_ts1, BIST_ON_TO_COLLAR_ts2, 
       BIST_ON_TO_COLLAR_ts3, BIST_SHIFT_COLLAR, BIST_SHIFT_COLLAR_ts1, 
       BIST_SHIFT_COLLAR_ts2, BIST_SHIFT_COLLAR_ts3, BIST_COLLAR_SETUP, 
       BIST_COLLAR_SETUP_ts1, BIST_COLLAR_SETUP_ts2, BIST_COLLAR_SETUP_ts3, 
       BIST_CLEAR_DEFAULT, BIST_CLEAR_DEFAULT_ts1, BIST_CLEAR_DEFAULT_ts2, 
       BIST_CLEAR_DEFAULT_ts3, BIST_CLEAR, BIST_CLEAR_ts1, BIST_CLEAR_ts2, 
       BIST_CLEAR_ts3, BIST_COLLAR_OPSET_SELECT, BIST_COLLAR_OPSET_SELECT_ts1, 
       BIST_COLLAR_OPSET_SELECT_ts2, BIST_COLLAR_HOLD, FREEZE_STOP_ERROR, 
       ERROR_CNT_ZERO, BIST_COLLAR_HOLD_ts1, FREEZE_STOP_ERROR_ts1, 
       ERROR_CNT_ZERO_ts1, BIST_COLLAR_HOLD_ts2, FREEZE_STOP_ERROR_ts2, 
       ERROR_CNT_ZERO_ts2, BIST_COLLAR_HOLD_ts3, FREEZE_STOP_ERROR_ts3, 
       ERROR_CNT_ZERO_ts3, MBISTPG_RESET_REG_SETUP2, 
       MBISTPG_RESET_REG_SETUP2_ts1, MBISTPG_RESET_REG_SETUP2_ts2, 
       MBISTPG_RESET_REG_SETUP2_ts3, hlp_fgrp_apr_rtl_tessent_mbist_bap_inst_so, 
       tck_select, MBISTPG_STABLE, MBISTPG_STABLE_ts1, MBISTPG_STABLE_ts2, 
       MBISTPG_STABLE_ts3, ijtag_so, bisr_so_pd_vinf_ts1, 
       ram_row_0_col_0_bisr_inst_SO, ram_row_0_col_0_bisr_inst_SO_ts1, 
       trigger_post, trigger_array, mbistpg_select_common_algo_o, select_rf, 
       select_sram, pass, sys_test_done_clk, sys_test_pass_clk, complete, busy, 
       sync_reset_clk_reset_bypass_mux_o, 
       Intel_reset_sync_polarity_clk_inverter_o1, sync_reset_clk_o, 
       sync_reset_clk_o_ts1;
  wire [6:0] mbistpg_algo_sel_o, ALGO_SEL_REG, ALGO_SEL_REG_ts1, 
             ALGO_SEL_REG_ts2, ALGO_SEL_REG_ts3;
`include "hlp_fgrp_apr.VISA_IT.hlp_fgrp_apr.wires.sv" // Auto Included by VISA IT - *** Do not modify this line ***
logic [hlp_pkg::N_FFU_GROUP_SLICES-1:0][hlp_pkg::N_FFU_GROUP_TPS-1:0][`HLP_FGRP_FFU_TCAM_FROM_TCAM_WIDTH-1:0] nm_frm_ffu_tcam;
logic [hlp_pkg::N_FFU_GROUP_SLICES-1:0][hlp_pkg::N_FFU_GROUP_TPS-1:0][`HLP_FGRP_FFU_TCAM_TO_TCAM_WIDTH-1:0] nm_tom_ffu_tcam;

hlp_pkg::imn_broadcast_t broadcast_struct;
assign broadcast_struct = i_broadcast;

hlp_pkg::imn_broadcast_t local_broadcast;
logic local_rst_n;
logic sram_isol_en;


assign avisa_unit_id_p1 = fvisa_unit_id + 9'd1;

logic latch_mem_fuses;
assign latch_mem_fuses = fdfx_jta_force_latch_mem_fuses | fscan_clkgenctrlen[0];


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



logic fet_ack_b_to_sram;
logic fet_ack_b_to_rf;
logic fet_ack_b_to_tcam;
//logic fet_ack_b_from_fl;

/*AUTOLOGIC*/
// Beginning of automatic wires (for undeclared instantiated-module outputs)
logic [`HLP_FGHASH_FFU_HASH_CFG_FROM_MEM_WIDTH-1:0] frm_ffu_hash_cfg;// From u_fgrp_apr_ff_mems of hlp_fgrp_apr_ff_mems.v
logic [hlp_pkg::N_FFU_GROUP_ARAMS-1:0] [`HLP_FGRP_FFU_ACTION_TO_MEM_WIDTH-1:0]   tom_ffu_action;// From u_fgrp_apr_func_logic of hlp_fgrp_apr_func_logic.v
logic [hlp_pkg::N_FFU_GROUP_ARAMS-1:0] [`HLP_FGRP_FFU_ACTION_FROM_MEM_WIDTH-1:0] frm_ffu_action; // fixed by mem_gen script
logic [`HLP_FGHASH_FFU_HASH_CFG_TO_MEM_WIDTH-1:0] tom_ffu_hash_cfg;// From u_fgrp_apr_func_logic of hlp_fgrp_apr_func_logic.v
logic [1:0] [`HLP_FGHASH_FFU_HASH_LOOKUP_TO_MEM_WIDTH-1:0]   tom_ffu_hash_lookup;// From u_fgrp_apr_func_logic of hlp_fgrp_apr_func_logic.v
logic [1:0] [`HLP_FGHASH_FFU_HASH_LOOKUP_FROM_MEM_WIDTH-1:0] frm_ffu_hash_lookup; // fixed by mem_gen script
logic [1:0] [`HLP_FGHASH_FFU_HASH_MISS_TO_MEM_WIDTH-1:0]   tom_ffu_hash_miss;// From u_fgrp_apr_func_logic of hlp_fgrp_apr_func_logic.v
logic [1:0] [`HLP_FGHASH_FFU_HASH_MISS_FROM_MEM_WIDTH-1:0] frm_ffu_hash_miss; // fixed by mem_gen script
logic [1:0] [`HLP_FGHASH_FFU_KEY_MASK0_TO_MEM_WIDTH-1:0]   tom_ffu_key_mask0;// From u_fgrp_apr_func_logic of hlp_fgrp_apr_func_logic.v
logic [1:0] [`HLP_FGHASH_FFU_KEY_MASK0_FROM_MEM_WIDTH-1:0] frm_ffu_key_mask0; // fixed by mem_gen script
logic [1:0] [`HLP_FGHASH_FFU_KEY_MASK1_TO_MEM_WIDTH-1:0]   tom_ffu_key_mask1;// From u_fgrp_apr_func_logic of hlp_fgrp_apr_func_logic.v
logic [1:0] [`HLP_FGHASH_FFU_KEY_MASK1_FROM_MEM_WIDTH-1:0] frm_ffu_key_mask1; // fixed by mem_gen script
logic [1:0] [`HLP_FGHASH_FFU_KEY_MASK2_TO_MEM_WIDTH-1:0]   tom_ffu_key_mask2;// From u_fgrp_apr_func_logic of hlp_fgrp_apr_func_logic.v
logic [1:0] [`HLP_FGHASH_FFU_KEY_MASK2_FROM_MEM_WIDTH-1:0] frm_ffu_key_mask2; // fixed by mem_gen script
logic [1:0] [`HLP_FGHASH_FFU_KEY_MASK3_TO_MEM_WIDTH-1:0]   tom_ffu_key_mask3;// From u_fgrp_apr_func_logic of hlp_fgrp_apr_func_logic.v
logic [1:0] [`HLP_FGHASH_FFU_KEY_MASK3_FROM_MEM_WIDTH-1:0] frm_ffu_key_mask3; // fixed by mem_gen script
logic [1:0] [`HLP_FGHASH_FFU_KEY_MASK4_TO_MEM_WIDTH-1:0]   tom_ffu_key_mask4;// From u_fgrp_apr_func_logic of hlp_fgrp_apr_func_logic.v
logic [1:0] [`HLP_FGHASH_FFU_KEY_MASK4_FROM_MEM_WIDTH-1:0] frm_ffu_key_mask4; // fixed by mem_gen script
logic [hlp_pkg::N_FFU_GROUP_SLICES-1:0] [`HLP_FGRP_FFU_TCAM_CFG_TO_MEM_WIDTH-1:0]   tom_ffu_tcam_cfg;// From u_fgrp_apr_func_logic of hlp_fgrp_apr_func_logic.v
logic [hlp_pkg::N_FFU_GROUP_SLICES-1:0] [`HLP_FGRP_FFU_TCAM_CFG_FROM_MEM_WIDTH-1:0] frm_ffu_tcam_cfg; // fixed by mem_gen script
// End of automatics


/*
  hlp_fgrp_apr_sram_mems AUTO_TEMPLATE
 (
  .fgrp_\(.*\)_\([0-9]+\)_from_mem (frm_\1[\2][]),
  .fgrp_\(.*\)_\([0-9]+\)_to_mem   (tom_\1[\2][]),
  .fgrp_\(.*\)_from_mem              (frm_\1[]),
  .fgrp_\(.*\)_to_mem                (tom_\1[]),
  .fghash_\(.*\)_\([0-9]+\)_from_mem (frm_\1[\2][]),
  .fghash_\(.*\)_\([0-9]+\)_to_mem   (tom_\1[\2][]),
  .fghash_\(.*\)_from_mem              (frm_\1[]),
  .fghash_\(.*\)_to_mem                (tom_\1[]),
  .fary_ffuse_rfhs2r2w_trim ('0),
  .post_mux_ctrl ('0),
  .fary_trigger_post_sram ('0),
  .aary_post_complete_sram (),
  .aary_post_pass_sram (),
  .fary_isolation_control_in  (isol_en_b),
  .fscan_clkgenctrl   (fscan_clkgenctrl[0]),
  .fscan_clkgenctrlen (latch_mem_fuses),
  .ip_reset_b (local_broadcast.mem_rst_b),
  .car_raw_lan_power_good_with_byprst (local_broadcast.fuse_rst_b) );*/

logic aary_post_complete_fghash_sram, aary_post_complete_fgrp_sram;
logic aary_post_pass_fghash_sram, aary_post_pass_fgrp_sram;
logic fary_trigger_post_sram_sync;
ctech_lib_doublesync_rstb  #(.WIDTH(1))  u_trigger_post_sram
  (.clk(clk_ts1), .rstb(local_broadcast.mem_rst_b), .d(fary_trigger_post_sram), .o(fary_trigger_post_sram_sync) );
assign aary_post_complete_sram = aary_post_complete_fghash_sram & aary_post_complete_fgrp_sram;
always_ff
    @(posedge clk_ts1)
        begin 
            aary_post_pass_sram <= ((fary_post_pass_sram & aary_post_pass_fghash_sram) & aary_post_pass_fgrp_sram);
        end


hlp_fgrp_apr_sram_mems u_fgrp_apr_sram_mems
(// Manual connections
 .fary_trigger_post_fghash_sram (fary_trigger_post_sram_sync),
 .fary_trigger_post_fgrp_sram (fary_trigger_post_sram_sync),
 .aary_post_complete_fghash_sram,
 .aary_post_complete_fgrp_sram,
 .aary_post_pass_fghash_sram,
 .aary_post_pass_fgrp_sram,
 .fary_pwren_b_sram   (fet_ack_b_to_sram), 
// .fary_wakeup_sram    (sram_isol_en),
 .aary_pwren_b_sram   (fet_ack_b_to_rf),
 /*AUTOINST*/
 // Outputs
 .aary_post_complete_sram               (),                      // Templated
 .aary_post_pass_sram                   (),                      // Templated
 .fghash_ffu_hash_lookup_0_from_mem     (frm_ffu_hash_lookup[0][`HLP_FGHASH_FFU_HASH_LOOKUP_FROM_MEM_WIDTH-1:0]), // Templated
 .fghash_ffu_hash_lookup_1_from_mem     (frm_ffu_hash_lookup[1][`HLP_FGHASH_FFU_HASH_LOOKUP_FROM_MEM_WIDTH-1:0]), // Templated
 .fgrp_ffu_action_0_from_mem            (frm_ffu_action[0][`HLP_FGRP_FFU_ACTION_FROM_MEM_WIDTH-1:0]), // Templated
 .fgrp_ffu_action_10_from_mem           (frm_ffu_action[10][`HLP_FGRP_FFU_ACTION_FROM_MEM_WIDTH-1:0]), // Templated
 .fgrp_ffu_action_11_from_mem           (frm_ffu_action[11][`HLP_FGRP_FFU_ACTION_FROM_MEM_WIDTH-1:0]), // Templated
 .fgrp_ffu_action_12_from_mem           (frm_ffu_action[12][`HLP_FGRP_FFU_ACTION_FROM_MEM_WIDTH-1:0]), // Templated
 .fgrp_ffu_action_13_from_mem           (frm_ffu_action[13][`HLP_FGRP_FFU_ACTION_FROM_MEM_WIDTH-1:0]), // Templated
 .fgrp_ffu_action_14_from_mem           (frm_ffu_action[14][`HLP_FGRP_FFU_ACTION_FROM_MEM_WIDTH-1:0]), // Templated
 .fgrp_ffu_action_15_from_mem           (frm_ffu_action[15][`HLP_FGRP_FFU_ACTION_FROM_MEM_WIDTH-1:0]), // Templated
 .fgrp_ffu_action_16_from_mem           (frm_ffu_action[16][`HLP_FGRP_FFU_ACTION_FROM_MEM_WIDTH-1:0]), // Templated
 .fgrp_ffu_action_17_from_mem           (frm_ffu_action[17][`HLP_FGRP_FFU_ACTION_FROM_MEM_WIDTH-1:0]), // Templated
 .fgrp_ffu_action_18_from_mem           (frm_ffu_action[18][`HLP_FGRP_FFU_ACTION_FROM_MEM_WIDTH-1:0]), // Templated
 .fgrp_ffu_action_19_from_mem           (frm_ffu_action[19][`HLP_FGRP_FFU_ACTION_FROM_MEM_WIDTH-1:0]), // Templated
 .fgrp_ffu_action_1_from_mem            (frm_ffu_action[1][`HLP_FGRP_FFU_ACTION_FROM_MEM_WIDTH-1:0]), // Templated
 .fgrp_ffu_action_2_from_mem            (frm_ffu_action[2][`HLP_FGRP_FFU_ACTION_FROM_MEM_WIDTH-1:0]), // Templated
 .fgrp_ffu_action_3_from_mem            (frm_ffu_action[3][`HLP_FGRP_FFU_ACTION_FROM_MEM_WIDTH-1:0]), // Templated
 .fgrp_ffu_action_4_from_mem            (frm_ffu_action[4][`HLP_FGRP_FFU_ACTION_FROM_MEM_WIDTH-1:0]), // Templated
 .fgrp_ffu_action_5_from_mem            (frm_ffu_action[5][`HLP_FGRP_FFU_ACTION_FROM_MEM_WIDTH-1:0]), // Templated
 .fgrp_ffu_action_6_from_mem            (frm_ffu_action[6][`HLP_FGRP_FFU_ACTION_FROM_MEM_WIDTH-1:0]), // Templated
 .fgrp_ffu_action_7_from_mem            (frm_ffu_action[7][`HLP_FGRP_FFU_ACTION_FROM_MEM_WIDTH-1:0]), // Templated
 .fgrp_ffu_action_8_from_mem            (frm_ffu_action[8][`HLP_FGRP_FFU_ACTION_FROM_MEM_WIDTH-1:0]), // Templated
 .fgrp_ffu_action_9_from_mem            (frm_ffu_action[9][`HLP_FGRP_FFU_ACTION_FROM_MEM_WIDTH-1:0]), // Templated
 // Inputs
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
 .fary_trigger_post_sram                ('0),                    // Templated
 .fghash_ffu_hash_lookup_0_to_mem       (tom_ffu_hash_lookup[0][`HLP_FGHASH_FFU_HASH_LOOKUP_TO_MEM_WIDTH-1:0]), // Templated
 .fghash_ffu_hash_lookup_1_to_mem       (tom_ffu_hash_lookup[1][`HLP_FGHASH_FFU_HASH_LOOKUP_TO_MEM_WIDTH-1:0]), // Templated
 .fgrp_ffu_action_0_to_mem              (tom_ffu_action[0][`HLP_FGRP_FFU_ACTION_TO_MEM_WIDTH-1:0]), // Templated
 .fgrp_ffu_action_10_to_mem             (tom_ffu_action[10][`HLP_FGRP_FFU_ACTION_TO_MEM_WIDTH-1:0]), // Templated
 .fgrp_ffu_action_11_to_mem             (tom_ffu_action[11][`HLP_FGRP_FFU_ACTION_TO_MEM_WIDTH-1:0]), // Templated
 .fgrp_ffu_action_12_to_mem             (tom_ffu_action[12][`HLP_FGRP_FFU_ACTION_TO_MEM_WIDTH-1:0]), // Templated
 .fgrp_ffu_action_13_to_mem             (tom_ffu_action[13][`HLP_FGRP_FFU_ACTION_TO_MEM_WIDTH-1:0]), // Templated
 .fgrp_ffu_action_14_to_mem             (tom_ffu_action[14][`HLP_FGRP_FFU_ACTION_TO_MEM_WIDTH-1:0]), // Templated
 .fgrp_ffu_action_15_to_mem             (tom_ffu_action[15][`HLP_FGRP_FFU_ACTION_TO_MEM_WIDTH-1:0]), // Templated
 .fgrp_ffu_action_16_to_mem             (tom_ffu_action[16][`HLP_FGRP_FFU_ACTION_TO_MEM_WIDTH-1:0]), // Templated
 .fgrp_ffu_action_17_to_mem             (tom_ffu_action[17][`HLP_FGRP_FFU_ACTION_TO_MEM_WIDTH-1:0]), // Templated
 .fgrp_ffu_action_18_to_mem             (tom_ffu_action[18][`HLP_FGRP_FFU_ACTION_TO_MEM_WIDTH-1:0]), // Templated
 .fgrp_ffu_action_19_to_mem             (tom_ffu_action[19][`HLP_FGRP_FFU_ACTION_TO_MEM_WIDTH-1:0]), // Templated
 .fgrp_ffu_action_1_to_mem              (tom_ffu_action[1][`HLP_FGRP_FFU_ACTION_TO_MEM_WIDTH-1:0]), // Templated
 .fgrp_ffu_action_2_to_mem              (tom_ffu_action[2][`HLP_FGRP_FFU_ACTION_TO_MEM_WIDTH-1:0]), // Templated
 .fgrp_ffu_action_3_to_mem              (tom_ffu_action[3][`HLP_FGRP_FFU_ACTION_TO_MEM_WIDTH-1:0]), // Templated
 .fgrp_ffu_action_4_to_mem              (tom_ffu_action[4][`HLP_FGRP_FFU_ACTION_TO_MEM_WIDTH-1:0]), // Templated
 .fgrp_ffu_action_5_to_mem              (tom_ffu_action[5][`HLP_FGRP_FFU_ACTION_TO_MEM_WIDTH-1:0]), // Templated
 .fgrp_ffu_action_6_to_mem              (tom_ffu_action[6][`HLP_FGRP_FFU_ACTION_TO_MEM_WIDTH-1:0]), // Templated
 .fgrp_ffu_action_7_to_mem              (tom_ffu_action[7][`HLP_FGRP_FFU_ACTION_TO_MEM_WIDTH-1:0]), // Templated
 .fgrp_ffu_action_8_to_mem              (tom_ffu_action[8][`HLP_FGRP_FFU_ACTION_TO_MEM_WIDTH-1:0]), // Templated
 .fgrp_ffu_action_9_to_mem              (tom_ffu_action[9][`HLP_FGRP_FFU_ACTION_TO_MEM_WIDTH-1:0]), // Templated
 .fscan_clkungate                       (fscan_clkungate),
 .fscan_ram_bypsel_sram                 (fscan_ram_bypsel_sram),
 .fscan_ram_init_en                     (fscan_ram_init_en),
 .fscan_ram_init_val                    (fscan_ram_init_val),
 .fscan_ram_rdis_b                      (fscan_ram_rdis_b),
 .fscan_ram_wdis_b                      (fscan_ram_wdis_b),
 .fsta_dfxact_afd                       (fsta_dfxact_afd),
 .ip_reset_b                            (local_broadcast.mem_rst_b), // Templated
 .post_mux_ctrl                         ('0),                    // Templated
 .pwr_mgmt_in_sram                      (pwr_mgmt_in_sram[6-1:0]), .BIST_SETUP(BIST_SETUP[0]), .BIST_SETUP_ts1(BIST_SETUP[1]), 
 .BIST_SETUP_ts2(BIST_SETUP[2]), .to_interfaces_tck(to_interfaces_tck), 
 .mcp_bounding_to_en(mcp_bounding_to_en), .scan_to_en(scan_to_en), 
 .memory_bypass_to_en(memory_bypass_to_en), .GO_ID_REG_SEL(GO_ID_REG_SEL_ts1), 
 .GO_ID_REG_SEL_ts1(GO_ID_REG_SEL_ts2), .BIST_CLEAR_BIRA(BIST_CLEAR_BIRA_ts1), 
 .BIST_COLLAR_DIAG_EN(BIST_COLLAR_DIAG_EN_ts1), .BIST_COLLAR_BIRA_EN(BIST_COLLAR_BIRA_EN_ts1), 
 .PriorityColumn(PriorityColumn_ts1), .BIST_SHIFT_BIRA_COLLAR(BIST_SHIFT_BIRA_COLLAR_ts1), 
 .BIST_CLEAR_BIRA_ts1(BIST_CLEAR_BIRA_ts2), .BIST_COLLAR_DIAG_EN_ts1(BIST_COLLAR_DIAG_EN_ts2), 
 .BIST_COLLAR_BIRA_EN_ts1(BIST_COLLAR_BIRA_EN_ts2), .PriorityColumn_ts1(PriorityColumn_ts2), 
 .BIST_SHIFT_BIRA_COLLAR_ts1(BIST_SHIFT_BIRA_COLLAR_ts2), 
 .CHECK_REPAIR_NEEDED(CHECK_REPAIR_NEEDED), .MEM0_BIST_COLLAR_SI(MEM0_BIST_COLLAR_SI_ts1), 
 .MEM1_BIST_COLLAR_SI(MEM1_BIST_COLLAR_SI_ts1), .MEM2_BIST_COLLAR_SI(MEM2_BIST_COLLAR_SI_ts1), 
 .MEM3_BIST_COLLAR_SI(MEM3_BIST_COLLAR_SI_ts1), .MEM0_BIST_COLLAR_SI_ts1(MEM0_BIST_COLLAR_SI_ts2), 
 .MEM1_BIST_COLLAR_SI_ts1(MEM1_BIST_COLLAR_SI_ts2), .MEM2_BIST_COLLAR_SI_ts1(MEM2_BIST_COLLAR_SI_ts2), 
 .MEM3_BIST_COLLAR_SI_ts1(MEM3_BIST_COLLAR_SI_ts2), .MEM4_BIST_COLLAR_SI(MEM4_BIST_COLLAR_SI_ts1), 
 .MEM5_BIST_COLLAR_SI(MEM5_BIST_COLLAR_SI_ts1), .MEM6_BIST_COLLAR_SI(MEM6_BIST_COLLAR_SI_ts1), 
 .MEM7_BIST_COLLAR_SI(MEM7_BIST_COLLAR_SI_ts1), .MEM8_BIST_COLLAR_SI(MEM8_BIST_COLLAR_SI_ts1), 
 .MEM9_BIST_COLLAR_SI(MEM9_BIST_COLLAR_SI_ts1), .MEM10_BIST_COLLAR_SI(MEM10_BIST_COLLAR_SI_ts1), 
 .MEM11_BIST_COLLAR_SI(MEM11_BIST_COLLAR_SI_ts1), .MEM12_BIST_COLLAR_SI(MEM12_BIST_COLLAR_SI_ts1), 
 .MEM13_BIST_COLLAR_SI(MEM13_BIST_COLLAR_SI_ts1), .MEM14_BIST_COLLAR_SI(MEM14_BIST_COLLAR_SI_ts1), 
 .MEM15_BIST_COLLAR_SI(MEM15_BIST_COLLAR_SI_ts1), .MEM16_BIST_COLLAR_SI(MEM16_BIST_COLLAR_SI), 
 .MEM17_BIST_COLLAR_SI(MEM17_BIST_COLLAR_SI), .MEM18_BIST_COLLAR_SI(MEM18_BIST_COLLAR_SI), 
 .MEM19_BIST_COLLAR_SI(MEM19_BIST_COLLAR_SI), .BIST_SO(BIST_SO), .BIST_SO_ts1(BIST_SO_ts1), 
 .BIST_SO_ts2(BIST_SO_ts2), .BIST_SO_ts3(BIST_SO_ts3), .BIST_SO_ts4(BIST_SO_ts4), 
 .BIST_SO_ts5(BIST_SO_ts5), .BIST_SO_ts6(BIST_SO_ts6), .BIST_SO_ts7(BIST_SO_ts7), 
 .BIST_SO_ts8(BIST_SO_ts8), .BIST_SO_ts9(BIST_SO_ts9), .BIST_SO_ts10(BIST_SO_ts10), 
 .BIST_SO_ts11(BIST_SO_ts11), .BIST_SO_ts12(BIST_SO_ts12), .BIST_SO_ts13(BIST_SO_ts13), 
 .BIST_SO_ts14(BIST_SO_ts14), .BIST_SO_ts15(BIST_SO_ts15), .BIST_SO_ts16(BIST_SO_ts16), 
 .BIST_SO_ts17(BIST_SO_ts17), .BIST_SO_ts18(BIST_SO_ts18), .BIST_SO_ts19(BIST_SO_ts19), 
 .BIST_SO_ts20(BIST_SO_ts20), .BIST_SO_ts21(BIST_SO_ts21), .BIST_SO_ts22(BIST_SO_ts38), 
 .BIST_SO_ts23(BIST_SO_ts39), .BIST_GO(BIST_GO), .BIST_GO_ts1(BIST_GO_ts1), 
 .BIST_GO_ts2(BIST_GO_ts2), .BIST_GO_ts3(BIST_GO_ts3), .BIST_GO_ts4(BIST_GO_ts4), 
 .BIST_GO_ts5(BIST_GO_ts5), .BIST_GO_ts6(BIST_GO_ts6), .BIST_GO_ts7(BIST_GO_ts7), 
 .BIST_GO_ts8(BIST_GO_ts8), .BIST_GO_ts9(BIST_GO_ts9), .BIST_GO_ts10(BIST_GO_ts10), 
 .BIST_GO_ts11(BIST_GO_ts11), .BIST_GO_ts12(BIST_GO_ts12), .BIST_GO_ts13(BIST_GO_ts13), 
 .BIST_GO_ts14(BIST_GO_ts14), .BIST_GO_ts15(BIST_GO_ts15), .BIST_GO_ts16(BIST_GO_ts16), 
 .BIST_GO_ts17(BIST_GO_ts17), .BIST_GO_ts18(BIST_GO_ts18), .BIST_GO_ts19(BIST_GO_ts19), 
 .BIST_GO_ts20(BIST_GO_ts20), .BIST_GO_ts21(BIST_GO_ts21), .BIST_GO_ts22(BIST_GO_ts38), 
 .BIST_GO_ts23(BIST_GO_ts39), .ltest_to_en(ltest_to_en_ts1), 
 .BIST_WRITEENABLE(BIST_WRITEENABLE_ts1), .BIST_SELECT(BIST_SELECT), 
 .BIST_WRITEENABLE_ts1(BIST_WRITEENABLE_ts2), .BIST_SELECT_ts1(BIST_SELECT_ts1), 
 .BIST_CMP(BIST_CMP_ts1), .BIST_CMP_ts1(BIST_CMP_ts2), 
 .INCLUDE_MEM_RESULTS_REG(INCLUDE_MEM_RESULTS_REG), .BIST_COL_ADD(BIST_COL_ADD_ts1[0]), 
 .BIST_COL_ADD_ts1(BIST_COL_ADD_ts1[1]), .BIST_COL_ADD_ts2(BIST_COL_ADD_ts2[0]), 
 .BIST_COL_ADD_ts3(BIST_COL_ADD_ts2[1]), .BIST_ROW_ADD(BIST_ROW_ADD_ts1[0]), 
 .BIST_ROW_ADD_ts1(BIST_ROW_ADD_ts1[1]), .BIST_ROW_ADD_ts2(BIST_ROW_ADD_ts1[2]), 
 .BIST_ROW_ADD_ts3(BIST_ROW_ADD_ts1[3]), .BIST_ROW_ADD_ts4(BIST_ROW_ADD_ts1[4]), 
 .BIST_ROW_ADD_ts5(BIST_ROW_ADD_ts1[5]), .BIST_ROW_ADD_ts6(BIST_ROW_ADD_ts1[6]), 
 .BIST_ROW_ADD_ts7(BIST_ROW_ADD_ts2[0]), .BIST_ROW_ADD_ts8(BIST_ROW_ADD_ts2[1]), 
 .BIST_ROW_ADD_ts9(BIST_ROW_ADD_ts2[2]), .BIST_ROW_ADD_ts10(BIST_ROW_ADD_ts2[3]), 
 .BIST_ROW_ADD_ts11(BIST_ROW_ADD_ts2[4]), .BIST_ROW_ADD_ts12(BIST_ROW_ADD_ts2[5]), 
 .BIST_ROW_ADD_ts13(BIST_ROW_ADD_ts2[6]), .BIST_ROW_ADD_ts14(BIST_ROW_ADD_ts2[7]), 
 .BIST_COLLAR_EN0(BIST_COLLAR_EN0_ts1), .BIST_COLLAR_EN1(BIST_COLLAR_EN1_ts1), 
 .BIST_COLLAR_EN2(BIST_COLLAR_EN2_ts1), .BIST_COLLAR_EN3(BIST_COLLAR_EN3_ts1), 
 .BIST_COLLAR_EN0_ts1(BIST_COLLAR_EN0_ts2), .BIST_COLLAR_EN1_ts1(BIST_COLLAR_EN1_ts2), 
 .BIST_COLLAR_EN2_ts1(BIST_COLLAR_EN2_ts2), .BIST_COLLAR_EN3_ts1(BIST_COLLAR_EN3_ts2), 
 .BIST_COLLAR_EN4(BIST_COLLAR_EN4_ts1), .BIST_COLLAR_EN5(BIST_COLLAR_EN5_ts1), 
 .BIST_COLLAR_EN6(BIST_COLLAR_EN6_ts1), .BIST_COLLAR_EN7(BIST_COLLAR_EN7_ts1), 
 .BIST_COLLAR_EN8(BIST_COLLAR_EN8_ts1), .BIST_COLLAR_EN9(BIST_COLLAR_EN9_ts1), 
 .BIST_COLLAR_EN10(BIST_COLLAR_EN10_ts1), .BIST_COLLAR_EN11(BIST_COLLAR_EN11_ts1), 
 .BIST_COLLAR_EN12(BIST_COLLAR_EN12_ts1), .BIST_COLLAR_EN13(BIST_COLLAR_EN13_ts1), 
 .BIST_COLLAR_EN14(BIST_COLLAR_EN14_ts1), .BIST_COLLAR_EN15(BIST_COLLAR_EN15_ts1), 
 .BIST_COLLAR_EN16(BIST_COLLAR_EN16), .BIST_COLLAR_EN17(BIST_COLLAR_EN17), 
 .BIST_COLLAR_EN18(BIST_COLLAR_EN18), .BIST_COLLAR_EN19(BIST_COLLAR_EN19), 
 .BIST_RUN_TO_COLLAR0(BIST_RUN_TO_COLLAR0_ts1), .BIST_RUN_TO_COLLAR1(BIST_RUN_TO_COLLAR1_ts1), 
 .BIST_RUN_TO_COLLAR2(BIST_RUN_TO_COLLAR2_ts1), .BIST_RUN_TO_COLLAR3(BIST_RUN_TO_COLLAR3_ts1), 
 .BIST_RUN_TO_COLLAR0_ts1(BIST_RUN_TO_COLLAR0_ts2), .BIST_RUN_TO_COLLAR1_ts1(BIST_RUN_TO_COLLAR1_ts2), 
 .BIST_RUN_TO_COLLAR2_ts1(BIST_RUN_TO_COLLAR2_ts2), .BIST_RUN_TO_COLLAR3_ts1(BIST_RUN_TO_COLLAR3_ts2), 
 .BIST_RUN_TO_COLLAR4(BIST_RUN_TO_COLLAR4_ts1), .BIST_RUN_TO_COLLAR5(BIST_RUN_TO_COLLAR5_ts1), 
 .BIST_RUN_TO_COLLAR6(BIST_RUN_TO_COLLAR6_ts1), .BIST_RUN_TO_COLLAR7(BIST_RUN_TO_COLLAR7_ts1), 
 .BIST_RUN_TO_COLLAR8(BIST_RUN_TO_COLLAR8_ts1), .BIST_RUN_TO_COLLAR9(BIST_RUN_TO_COLLAR9_ts1), 
 .BIST_RUN_TO_COLLAR10(BIST_RUN_TO_COLLAR10_ts1), .BIST_RUN_TO_COLLAR11(BIST_RUN_TO_COLLAR11_ts1), 
 .BIST_RUN_TO_COLLAR12(BIST_RUN_TO_COLLAR12_ts1), .BIST_RUN_TO_COLLAR13(BIST_RUN_TO_COLLAR13_ts1), 
 .BIST_RUN_TO_COLLAR14(BIST_RUN_TO_COLLAR14_ts1), .BIST_RUN_TO_COLLAR15(BIST_RUN_TO_COLLAR15_ts1), 
 .BIST_RUN_TO_COLLAR16(BIST_RUN_TO_COLLAR16), .BIST_RUN_TO_COLLAR17(BIST_RUN_TO_COLLAR17), 
 .BIST_RUN_TO_COLLAR18(BIST_RUN_TO_COLLAR18), .BIST_RUN_TO_COLLAR19(BIST_RUN_TO_COLLAR19), 
 .BIST_ASYNC_RESET(BIST_ASYNC_RESET), .BIST_TESTDATA_SELECT_TO_COLLAR(BIST_TESTDATA_SELECT_TO_COLLAR_ts1), 
 .BIST_TESTDATA_SELECT_TO_COLLAR_ts1(BIST_TESTDATA_SELECT_TO_COLLAR_ts2), 
 .BIST_ON_TO_COLLAR(BIST_ON_TO_COLLAR_ts1), .BIST_ON_TO_COLLAR_ts1(BIST_ON_TO_COLLAR_ts2), 
 .BIST_WRITE_DATA(BIST_WRITE_DATA_ts1[0]), .BIST_WRITE_DATA_ts1(BIST_WRITE_DATA_ts1[1]), 
 .BIST_WRITE_DATA_ts2(BIST_WRITE_DATA_ts1[2]), .BIST_WRITE_DATA_ts3(BIST_WRITE_DATA_ts1[3]), 
 .BIST_WRITE_DATA_ts4(BIST_WRITE_DATA_ts1[4]), .BIST_WRITE_DATA_ts5(BIST_WRITE_DATA_ts1[5]), 
 .BIST_WRITE_DATA_ts6(BIST_WRITE_DATA_ts1[6]), .BIST_WRITE_DATA_ts7(BIST_WRITE_DATA_ts1[7]), 
 .BIST_WRITE_DATA_ts8(BIST_WRITE_DATA_ts1[8]), .BIST_WRITE_DATA_ts9(BIST_WRITE_DATA_ts1[9]), 
 .BIST_WRITE_DATA_ts10(BIST_WRITE_DATA_ts1[10]), .BIST_WRITE_DATA_ts11(BIST_WRITE_DATA_ts1[11]), 
 .BIST_WRITE_DATA_ts12(BIST_WRITE_DATA_ts1[12]), .BIST_WRITE_DATA_ts13(BIST_WRITE_DATA_ts1[13]), 
 .BIST_WRITE_DATA_ts14(BIST_WRITE_DATA_ts1[14]), .BIST_WRITE_DATA_ts15(BIST_WRITE_DATA_ts1[15]), 
 .BIST_WRITE_DATA_ts16(BIST_WRITE_DATA_ts1[16]), .BIST_WRITE_DATA_ts17(BIST_WRITE_DATA_ts1[17]), 
 .BIST_WRITE_DATA_ts18(BIST_WRITE_DATA_ts1[18]), .BIST_WRITE_DATA_ts19(BIST_WRITE_DATA_ts1[19]), 
 .BIST_WRITE_DATA_ts20(BIST_WRITE_DATA_ts1[20]), .BIST_WRITE_DATA_ts21(BIST_WRITE_DATA_ts1[21]), 
 .BIST_WRITE_DATA_ts22(BIST_WRITE_DATA_ts1[22]), .BIST_WRITE_DATA_ts23(BIST_WRITE_DATA_ts1[23]), 
 .BIST_WRITE_DATA_ts24(BIST_WRITE_DATA_ts1[24]), .BIST_WRITE_DATA_ts25(BIST_WRITE_DATA_ts1[25]), 
 .BIST_WRITE_DATA_ts26(BIST_WRITE_DATA_ts1[26]), .BIST_WRITE_DATA_ts27(BIST_WRITE_DATA_ts1[27]), 
 .BIST_WRITE_DATA_ts28(BIST_WRITE_DATA_ts1[28]), .BIST_WRITE_DATA_ts29(BIST_WRITE_DATA_ts1[29]), 
 .BIST_WRITE_DATA_ts30(BIST_WRITE_DATA_ts1[30]), .BIST_WRITE_DATA_ts31(BIST_WRITE_DATA_ts1[31]), 
 .BIST_WRITE_DATA_ts32(BIST_WRITE_DATA_ts2[0]), .BIST_WRITE_DATA_ts33(BIST_WRITE_DATA_ts2[1]), 
 .BIST_WRITE_DATA_ts34(BIST_WRITE_DATA_ts2[2]), .BIST_WRITE_DATA_ts35(BIST_WRITE_DATA_ts2[3]), 
 .BIST_WRITE_DATA_ts36(BIST_WRITE_DATA_ts2[4]), .BIST_WRITE_DATA_ts37(BIST_WRITE_DATA_ts2[5]), 
 .BIST_WRITE_DATA_ts38(BIST_WRITE_DATA_ts2[6]), .BIST_WRITE_DATA_ts39(BIST_WRITE_DATA_ts2[7]), 
 .BIST_WRITE_DATA_ts40(BIST_WRITE_DATA_ts2[8]), .BIST_WRITE_DATA_ts41(BIST_WRITE_DATA_ts2[9]), 
 .BIST_WRITE_DATA_ts42(BIST_WRITE_DATA_ts2[10]), .BIST_WRITE_DATA_ts43(BIST_WRITE_DATA_ts2[11]), 
 .BIST_WRITE_DATA_ts44(BIST_WRITE_DATA_ts2[12]), .BIST_WRITE_DATA_ts45(BIST_WRITE_DATA_ts2[13]), 
 .BIST_WRITE_DATA_ts46(BIST_WRITE_DATA_ts2[14]), .BIST_WRITE_DATA_ts47(BIST_WRITE_DATA_ts2[15]), 
 .BIST_WRITE_DATA_ts48(BIST_WRITE_DATA_ts2[16]), .BIST_WRITE_DATA_ts49(BIST_WRITE_DATA_ts2[17]), 
 .BIST_WRITE_DATA_ts50(BIST_WRITE_DATA_ts2[18]), .BIST_WRITE_DATA_ts51(BIST_WRITE_DATA_ts2[19]), 
 .BIST_WRITE_DATA_ts52(BIST_WRITE_DATA_ts2[20]), .BIST_WRITE_DATA_ts53(BIST_WRITE_DATA_ts2[21]), 
 .BIST_WRITE_DATA_ts54(BIST_WRITE_DATA_ts2[22]), .BIST_WRITE_DATA_ts55(BIST_WRITE_DATA_ts2[23]), 
 .BIST_WRITE_DATA_ts56(BIST_WRITE_DATA_ts2[24]), .BIST_WRITE_DATA_ts57(BIST_WRITE_DATA_ts2[25]), 
 .BIST_WRITE_DATA_ts58(BIST_WRITE_DATA_ts2[26]), .BIST_WRITE_DATA_ts59(BIST_WRITE_DATA_ts2[27]), 
 .BIST_WRITE_DATA_ts60(BIST_WRITE_DATA_ts2[28]), .BIST_WRITE_DATA_ts61(BIST_WRITE_DATA_ts2[29]), 
 .BIST_WRITE_DATA_ts62(BIST_WRITE_DATA_ts2[30]), .BIST_WRITE_DATA_ts63(BIST_WRITE_DATA_ts2[31]), 
 .BIST_EXPECT_DATA(BIST_EXPECT_DATA_ts1[0]), .BIST_EXPECT_DATA_ts1(BIST_EXPECT_DATA_ts1[1]), 
 .BIST_EXPECT_DATA_ts2(BIST_EXPECT_DATA_ts1[2]), .BIST_EXPECT_DATA_ts3(BIST_EXPECT_DATA_ts1[3]), 
 .BIST_EXPECT_DATA_ts4(BIST_EXPECT_DATA_ts1[4]), .BIST_EXPECT_DATA_ts5(BIST_EXPECT_DATA_ts1[5]), 
 .BIST_EXPECT_DATA_ts6(BIST_EXPECT_DATA_ts1[6]), .BIST_EXPECT_DATA_ts7(BIST_EXPECT_DATA_ts1[7]), 
 .BIST_EXPECT_DATA_ts8(BIST_EXPECT_DATA_ts1[8]), .BIST_EXPECT_DATA_ts9(BIST_EXPECT_DATA_ts1[9]), 
 .BIST_EXPECT_DATA_ts10(BIST_EXPECT_DATA_ts1[10]), .BIST_EXPECT_DATA_ts11(BIST_EXPECT_DATA_ts1[11]), 
 .BIST_EXPECT_DATA_ts12(BIST_EXPECT_DATA_ts1[12]), .BIST_EXPECT_DATA_ts13(BIST_EXPECT_DATA_ts1[13]), 
 .BIST_EXPECT_DATA_ts14(BIST_EXPECT_DATA_ts1[14]), .BIST_EXPECT_DATA_ts15(BIST_EXPECT_DATA_ts1[15]), 
 .BIST_EXPECT_DATA_ts16(BIST_EXPECT_DATA_ts1[16]), .BIST_EXPECT_DATA_ts17(BIST_EXPECT_DATA_ts1[17]), 
 .BIST_EXPECT_DATA_ts18(BIST_EXPECT_DATA_ts1[18]), .BIST_EXPECT_DATA_ts19(BIST_EXPECT_DATA_ts1[19]), 
 .BIST_EXPECT_DATA_ts20(BIST_EXPECT_DATA_ts1[20]), .BIST_EXPECT_DATA_ts21(BIST_EXPECT_DATA_ts1[21]), 
 .BIST_EXPECT_DATA_ts22(BIST_EXPECT_DATA_ts1[22]), .BIST_EXPECT_DATA_ts23(BIST_EXPECT_DATA_ts1[23]), 
 .BIST_EXPECT_DATA_ts24(BIST_EXPECT_DATA_ts1[24]), .BIST_EXPECT_DATA_ts25(BIST_EXPECT_DATA_ts1[25]), 
 .BIST_EXPECT_DATA_ts26(BIST_EXPECT_DATA_ts1[26]), .BIST_EXPECT_DATA_ts27(BIST_EXPECT_DATA_ts1[27]), 
 .BIST_EXPECT_DATA_ts28(BIST_EXPECT_DATA_ts1[28]), .BIST_EXPECT_DATA_ts29(BIST_EXPECT_DATA_ts1[29]), 
 .BIST_EXPECT_DATA_ts30(BIST_EXPECT_DATA_ts1[30]), .BIST_EXPECT_DATA_ts31(BIST_EXPECT_DATA_ts1[31]), 
 .BIST_EXPECT_DATA_ts32(BIST_EXPECT_DATA_ts2[0]), .BIST_EXPECT_DATA_ts33(BIST_EXPECT_DATA_ts2[1]), 
 .BIST_EXPECT_DATA_ts34(BIST_EXPECT_DATA_ts2[2]), .BIST_EXPECT_DATA_ts35(BIST_EXPECT_DATA_ts2[3]), 
 .BIST_EXPECT_DATA_ts36(BIST_EXPECT_DATA_ts2[4]), .BIST_EXPECT_DATA_ts37(BIST_EXPECT_DATA_ts2[5]), 
 .BIST_EXPECT_DATA_ts38(BIST_EXPECT_DATA_ts2[6]), .BIST_EXPECT_DATA_ts39(BIST_EXPECT_DATA_ts2[7]), 
 .BIST_EXPECT_DATA_ts40(BIST_EXPECT_DATA_ts2[8]), .BIST_EXPECT_DATA_ts41(BIST_EXPECT_DATA_ts2[9]), 
 .BIST_EXPECT_DATA_ts42(BIST_EXPECT_DATA_ts2[10]), .BIST_EXPECT_DATA_ts43(BIST_EXPECT_DATA_ts2[11]), 
 .BIST_EXPECT_DATA_ts44(BIST_EXPECT_DATA_ts2[12]), .BIST_EXPECT_DATA_ts45(BIST_EXPECT_DATA_ts2[13]), 
 .BIST_EXPECT_DATA_ts46(BIST_EXPECT_DATA_ts2[14]), .BIST_EXPECT_DATA_ts47(BIST_EXPECT_DATA_ts2[15]), 
 .BIST_EXPECT_DATA_ts48(BIST_EXPECT_DATA_ts2[16]), .BIST_EXPECT_DATA_ts49(BIST_EXPECT_DATA_ts2[17]), 
 .BIST_EXPECT_DATA_ts50(BIST_EXPECT_DATA_ts2[18]), .BIST_EXPECT_DATA_ts51(BIST_EXPECT_DATA_ts2[19]), 
 .BIST_EXPECT_DATA_ts52(BIST_EXPECT_DATA_ts2[20]), .BIST_EXPECT_DATA_ts53(BIST_EXPECT_DATA_ts2[21]), 
 .BIST_EXPECT_DATA_ts54(BIST_EXPECT_DATA_ts2[22]), .BIST_EXPECT_DATA_ts55(BIST_EXPECT_DATA_ts2[23]), 
 .BIST_EXPECT_DATA_ts56(BIST_EXPECT_DATA_ts2[24]), .BIST_EXPECT_DATA_ts57(BIST_EXPECT_DATA_ts2[25]), 
 .BIST_EXPECT_DATA_ts58(BIST_EXPECT_DATA_ts2[26]), .BIST_EXPECT_DATA_ts59(BIST_EXPECT_DATA_ts2[27]), 
 .BIST_EXPECT_DATA_ts60(BIST_EXPECT_DATA_ts2[28]), .BIST_EXPECT_DATA_ts61(BIST_EXPECT_DATA_ts2[29]), 
 .BIST_EXPECT_DATA_ts62(BIST_EXPECT_DATA_ts2[30]), .BIST_EXPECT_DATA_ts63(BIST_EXPECT_DATA_ts2[31]), 
 .BIST_SHIFT_COLLAR(BIST_SHIFT_COLLAR_ts1), .BIST_SHIFT_COLLAR_ts1(BIST_SHIFT_COLLAR_ts2), 
 .BIST_COLLAR_SETUP(BIST_COLLAR_SETUP_ts1), .BIST_COLLAR_SETUP_ts1(BIST_COLLAR_SETUP_ts2), 
 .BIST_CLEAR_DEFAULT(BIST_CLEAR_DEFAULT_ts1), .BIST_CLEAR_DEFAULT_ts1(BIST_CLEAR_DEFAULT_ts2), 
 .BIST_CLEAR(BIST_CLEAR_ts1), .BIST_CLEAR_ts1(BIST_CLEAR_ts2), 
 .BIST_COLLAR_OPSET_SELECT(BIST_COLLAR_OPSET_SELECT_ts1), 
 .BIST_COLLAR_OPSET_SELECT_ts1(BIST_COLLAR_OPSET_SELECT_ts2), 
 .BIST_COLLAR_HOLD(BIST_COLLAR_HOLD_ts1), .FREEZE_STOP_ERROR(FREEZE_STOP_ERROR_ts1), 
 .ERROR_CNT_ZERO(ERROR_CNT_ZERO_ts1), .BIST_COLLAR_HOLD_ts1(BIST_COLLAR_HOLD_ts2), 
 .FREEZE_STOP_ERROR_ts1(FREEZE_STOP_ERROR_ts2), .ERROR_CNT_ZERO_ts1(ERROR_CNT_ZERO_ts2), 
 .MBISTPG_RESET_REG_SETUP2(MBISTPG_RESET_REG_SETUP2_ts1), 
 .MBISTPG_RESET_REG_SETUP2_ts1(MBISTPG_RESET_REG_SETUP2_ts2), .BIST_BANK_ADD(BIST_BANK_ADD[0]), 
 .BIST_BANK_ADD_ts1(BIST_BANK_ADD[1]), .bisr_shift_en_pd_vinf(bisr_shift_en_pd_vinf), 
 .bisr_clk_pd_vinf(bisr_clk_pd_vinf), .bisr_reset_pd_vinf(bisr_reset_pd_vinf), 
 .ram_row_0_col_0_bisr_inst_SO(ram_row_0_col_0_bisr_inst_SO), 
 .ram_row_0_col_0_bisr_inst_SO_ts1(ram_row_0_col_0_bisr_inst_SO_ts1));

/*
  hlp_fgrp_apr_rf_mems AUTO_TEMPLATE
 (
  .fgrp_\(.*\)_\([0-9]+\)_from_mem (frm_\1[\2][]),
  .fgrp_\(.*\)_\([0-9]+\)_to_mem   (tom_\1[\2][]),
  .fgrp_\(.*\)_from_mem              (frm_\1[]),
  .fgrp_\(.*\)_to_mem                (tom_\1[]),
  .fghash_\(.*\)_\([0-9]+\)_from_mem (frm_\1[\2][]),
  .fghash_\(.*\)_\([0-9]+\)_to_mem   (tom_\1[\2][]),
  .fghash_\(.*\)_from_mem              (frm_\1[]),
  .fghash_\(.*\)_to_mem                (tom_\1[]),
  .fary_ffuse_rfhs2r2w_trim ('0),
  .post_mux_ctrl ('0),
  .fary_trigger_post_rf ('0),
  .aary_post_complete_rf (),
  .aary_post_pass_rf (),
  .fary_isolation_control_in  (isol_en_b),
  .fscan_clkgenctrl   (fscan_clkgenctrl[0]),
  .fscan_clkgenctrlen (latch_mem_fuses),
  .ip_reset_b (local_broadcast.mem_rst_b),
  .car_raw_lan_power_good_with_byprst (local_broadcast.fuse_rst_b) );*/


logic fary_trigger_post_fgrp_rf, aary_post_complete_fgrp_rf, aary_post_pass_fgrp_rf;
ctech_lib_doublesync_rstb  #(.WIDTH(1))  u_trigger_post_rf
  (.clk(clk_ts1), .rstb(local_broadcast.mem_rst_b), .d(fary_trigger_post_rf), .o(fary_trigger_post_fgrp_rf) );
assign aary_post_complete_rf = aary_post_complete_fgrp_rf;
always_ff
    @(posedge clk_ts1)
        begin 
            aary_post_pass_rf <= (fary_post_pass_rf & aary_post_pass_fgrp_rf);
        end

hlp_fgrp_apr_rf_mems u_fgrp_apr_rf_mems
(// Manual connections
 .fary_trigger_post_fgrp_rf,
 .aary_post_complete_fgrp_rf,
 .aary_post_pass_fgrp_rf,
 .fary_pwren_b_rf     (fet_ack_b_to_rf),
 .aary_pwren_b_rf     (fet_ack_b_to_tcam),
 /*AUTOINST*/
 // Outputs
 .aary_post_complete_rf                 (),                      // Templated
 .aary_post_pass_rf                     (),                      // Templated
 .fgrp_ffu_tcam_cfg_0_from_mem          (frm_ffu_tcam_cfg[0][`HLP_FGRP_FFU_TCAM_CFG_FROM_MEM_WIDTH-1:0]), // Templated
 .fgrp_ffu_tcam_cfg_10_from_mem         (frm_ffu_tcam_cfg[10][`HLP_FGRP_FFU_TCAM_CFG_FROM_MEM_WIDTH-1:0]), // Templated
 .fgrp_ffu_tcam_cfg_11_from_mem         (frm_ffu_tcam_cfg[11][`HLP_FGRP_FFU_TCAM_CFG_FROM_MEM_WIDTH-1:0]), // Templated
 .fgrp_ffu_tcam_cfg_12_from_mem         (frm_ffu_tcam_cfg[12][`HLP_FGRP_FFU_TCAM_CFG_FROM_MEM_WIDTH-1:0]), // Templated
 .fgrp_ffu_tcam_cfg_13_from_mem         (frm_ffu_tcam_cfg[13][`HLP_FGRP_FFU_TCAM_CFG_FROM_MEM_WIDTH-1:0]), // Templated
 .fgrp_ffu_tcam_cfg_14_from_mem         (frm_ffu_tcam_cfg[14][`HLP_FGRP_FFU_TCAM_CFG_FROM_MEM_WIDTH-1:0]), // Templated
 .fgrp_ffu_tcam_cfg_15_from_mem         (frm_ffu_tcam_cfg[15][`HLP_FGRP_FFU_TCAM_CFG_FROM_MEM_WIDTH-1:0]), // Templated
 .fgrp_ffu_tcam_cfg_1_from_mem          (frm_ffu_tcam_cfg[1][`HLP_FGRP_FFU_TCAM_CFG_FROM_MEM_WIDTH-1:0]), // Templated
 .fgrp_ffu_tcam_cfg_2_from_mem          (frm_ffu_tcam_cfg[2][`HLP_FGRP_FFU_TCAM_CFG_FROM_MEM_WIDTH-1:0]), // Templated
 .fgrp_ffu_tcam_cfg_3_from_mem          (frm_ffu_tcam_cfg[3][`HLP_FGRP_FFU_TCAM_CFG_FROM_MEM_WIDTH-1:0]), // Templated
 .fgrp_ffu_tcam_cfg_4_from_mem          (frm_ffu_tcam_cfg[4][`HLP_FGRP_FFU_TCAM_CFG_FROM_MEM_WIDTH-1:0]), // Templated
 .fgrp_ffu_tcam_cfg_5_from_mem          (frm_ffu_tcam_cfg[5][`HLP_FGRP_FFU_TCAM_CFG_FROM_MEM_WIDTH-1:0]), // Templated
 .fgrp_ffu_tcam_cfg_6_from_mem          (frm_ffu_tcam_cfg[6][`HLP_FGRP_FFU_TCAM_CFG_FROM_MEM_WIDTH-1:0]), // Templated
 .fgrp_ffu_tcam_cfg_7_from_mem          (frm_ffu_tcam_cfg[7][`HLP_FGRP_FFU_TCAM_CFG_FROM_MEM_WIDTH-1:0]), // Templated
 .fgrp_ffu_tcam_cfg_8_from_mem          (frm_ffu_tcam_cfg[8][`HLP_FGRP_FFU_TCAM_CFG_FROM_MEM_WIDTH-1:0]), // Templated
 .fgrp_ffu_tcam_cfg_9_from_mem          (frm_ffu_tcam_cfg[9][`HLP_FGRP_FFU_TCAM_CFG_FROM_MEM_WIDTH-1:0]), // Templated
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
 .fgrp_ffu_tcam_cfg_0_to_mem            (tom_ffu_tcam_cfg[0][`HLP_FGRP_FFU_TCAM_CFG_TO_MEM_WIDTH-1:0]), // Templated
 .fgrp_ffu_tcam_cfg_10_to_mem           (tom_ffu_tcam_cfg[10][`HLP_FGRP_FFU_TCAM_CFG_TO_MEM_WIDTH-1:0]), // Templated
 .fgrp_ffu_tcam_cfg_11_to_mem           (tom_ffu_tcam_cfg[11][`HLP_FGRP_FFU_TCAM_CFG_TO_MEM_WIDTH-1:0]), // Templated
 .fgrp_ffu_tcam_cfg_12_to_mem           (tom_ffu_tcam_cfg[12][`HLP_FGRP_FFU_TCAM_CFG_TO_MEM_WIDTH-1:0]), // Templated
 .fgrp_ffu_tcam_cfg_13_to_mem           (tom_ffu_tcam_cfg[13][`HLP_FGRP_FFU_TCAM_CFG_TO_MEM_WIDTH-1:0]), // Templated
 .fgrp_ffu_tcam_cfg_14_to_mem           (tom_ffu_tcam_cfg[14][`HLP_FGRP_FFU_TCAM_CFG_TO_MEM_WIDTH-1:0]), // Templated
 .fgrp_ffu_tcam_cfg_15_to_mem           (tom_ffu_tcam_cfg[15][`HLP_FGRP_FFU_TCAM_CFG_TO_MEM_WIDTH-1:0]), // Templated
 .fgrp_ffu_tcam_cfg_1_to_mem            (tom_ffu_tcam_cfg[1][`HLP_FGRP_FFU_TCAM_CFG_TO_MEM_WIDTH-1:0]), // Templated
 .fgrp_ffu_tcam_cfg_2_to_mem            (tom_ffu_tcam_cfg[2][`HLP_FGRP_FFU_TCAM_CFG_TO_MEM_WIDTH-1:0]), // Templated
 .fgrp_ffu_tcam_cfg_3_to_mem            (tom_ffu_tcam_cfg[3][`HLP_FGRP_FFU_TCAM_CFG_TO_MEM_WIDTH-1:0]), // Templated
 .fgrp_ffu_tcam_cfg_4_to_mem            (tom_ffu_tcam_cfg[4][`HLP_FGRP_FFU_TCAM_CFG_TO_MEM_WIDTH-1:0]), // Templated
 .fgrp_ffu_tcam_cfg_5_to_mem            (tom_ffu_tcam_cfg[5][`HLP_FGRP_FFU_TCAM_CFG_TO_MEM_WIDTH-1:0]), // Templated
 .fgrp_ffu_tcam_cfg_6_to_mem            (tom_ffu_tcam_cfg[6][`HLP_FGRP_FFU_TCAM_CFG_TO_MEM_WIDTH-1:0]), // Templated
 .fgrp_ffu_tcam_cfg_7_to_mem            (tom_ffu_tcam_cfg[7][`HLP_FGRP_FFU_TCAM_CFG_TO_MEM_WIDTH-1:0]), // Templated
 .fgrp_ffu_tcam_cfg_8_to_mem            (tom_ffu_tcam_cfg[8][`HLP_FGRP_FFU_TCAM_CFG_TO_MEM_WIDTH-1:0]), // Templated
 .fgrp_ffu_tcam_cfg_9_to_mem            (tom_ffu_tcam_cfg[9][`HLP_FGRP_FFU_TCAM_CFG_TO_MEM_WIDTH-1:0]), // Templated
 .fscan_clkungate                       (fscan_clkungate),
 .fscan_ram_bypsel_rf                   (fscan_ram_bypsel_rf),
 .fscan_ram_init_en                     (fscan_ram_init_en),
 .fscan_ram_init_val                    (fscan_ram_init_val),
 .fscan_ram_rdis_b                      (fscan_ram_rdis_b),
 .fscan_ram_wdis_b                      (fscan_ram_wdis_b),
 .fsta_dfxact_afd                       (fsta_dfxact_afd),
 .ip_reset_b                            (local_broadcast.mem_rst_b), // Templated
 .post_mux_ctrl                         ('0),                    // Templated
 .pwr_mgmt_in_rf                        (pwr_mgmt_in_rf[5-1:0]), .BIST_SETUP(BIST_SETUP[0]), .BIST_SETUP_ts1(BIST_SETUP[1]), 
 .BIST_SETUP_ts2(BIST_SETUP[2]), .to_interfaces_tck(to_interfaces_tck), 
 .mcp_bounding_to_en(mcp_bounding_to_en), .scan_to_en(scan_to_en), 
 .memory_bypass_to_en(memory_bypass_to_en), .GO_ID_REG_SEL(GO_ID_REG_SEL), 
 .BIST_CLEAR_BIRA(BIST_CLEAR_BIRA), .BIST_COLLAR_DIAG_EN(BIST_COLLAR_DIAG_EN), 
 .BIST_COLLAR_BIRA_EN(BIST_COLLAR_BIRA_EN), .PriorityColumn(PriorityColumn), 
 .BIST_SHIFT_BIRA_COLLAR(BIST_SHIFT_BIRA_COLLAR), .CHECK_REPAIR_NEEDED(CHECK_REPAIR_NEEDED), 
 .MEM0_BIST_COLLAR_SI(MEM0_BIST_COLLAR_SI), .MEM1_BIST_COLLAR_SI(MEM1_BIST_COLLAR_SI), 
 .MEM2_BIST_COLLAR_SI(MEM2_BIST_COLLAR_SI), .MEM3_BIST_COLLAR_SI(MEM3_BIST_COLLAR_SI), 
 .MEM4_BIST_COLLAR_SI(MEM4_BIST_COLLAR_SI), .MEM5_BIST_COLLAR_SI(MEM5_BIST_COLLAR_SI), 
 .MEM6_BIST_COLLAR_SI(MEM6_BIST_COLLAR_SI), .MEM7_BIST_COLLAR_SI(MEM7_BIST_COLLAR_SI), 
 .MEM8_BIST_COLLAR_SI(MEM8_BIST_COLLAR_SI), .MEM9_BIST_COLLAR_SI(MEM9_BIST_COLLAR_SI), 
 .MEM10_BIST_COLLAR_SI(MEM10_BIST_COLLAR_SI), .MEM11_BIST_COLLAR_SI(MEM11_BIST_COLLAR_SI), 
 .MEM12_BIST_COLLAR_SI(MEM12_BIST_COLLAR_SI), .MEM13_BIST_COLLAR_SI(MEM13_BIST_COLLAR_SI), 
 .MEM14_BIST_COLLAR_SI(MEM14_BIST_COLLAR_SI), .MEM15_BIST_COLLAR_SI(MEM15_BIST_COLLAR_SI), 
 .BIST_SO(BIST_SO_ts22), .BIST_SO_ts1(BIST_SO_ts23), .BIST_SO_ts2(BIST_SO_ts24), 
 .BIST_SO_ts3(BIST_SO_ts25), .BIST_SO_ts4(BIST_SO_ts26), .BIST_SO_ts5(BIST_SO_ts27), 
 .BIST_SO_ts6(BIST_SO_ts28), .BIST_SO_ts7(BIST_SO_ts29), .BIST_SO_ts8(BIST_SO_ts30), 
 .BIST_SO_ts9(BIST_SO_ts31), .BIST_SO_ts10(BIST_SO_ts32), .BIST_SO_ts11(BIST_SO_ts33), 
 .BIST_SO_ts12(BIST_SO_ts34), .BIST_SO_ts13(BIST_SO_ts35), .BIST_SO_ts14(BIST_SO_ts36), 
 .BIST_SO_ts15(BIST_SO_ts37), .BIST_GO(BIST_GO_ts22), .BIST_GO_ts1(BIST_GO_ts23), 
 .BIST_GO_ts2(BIST_GO_ts24), .BIST_GO_ts3(BIST_GO_ts25), .BIST_GO_ts4(BIST_GO_ts26), 
 .BIST_GO_ts5(BIST_GO_ts27), .BIST_GO_ts6(BIST_GO_ts28), .BIST_GO_ts7(BIST_GO_ts29), 
 .BIST_GO_ts8(BIST_GO_ts30), .BIST_GO_ts9(BIST_GO_ts31), .BIST_GO_ts10(BIST_GO_ts32), 
 .BIST_GO_ts11(BIST_GO_ts33), .BIST_GO_ts12(BIST_GO_ts34), .BIST_GO_ts13(BIST_GO_ts35), 
 .BIST_GO_ts14(BIST_GO_ts36), .BIST_GO_ts15(BIST_GO_ts37), .ltest_to_en(ltest_to_en_ts1), 
 .BIST_READENABLE(BIST_READENABLE), .BIST_WRITEENABLE(BIST_WRITEENABLE), 
 .BIST_CMP(BIST_CMP), .INCLUDE_MEM_RESULTS_REG(INCLUDE_MEM_RESULTS_REG), 
 .BIST_COL_ADD(BIST_COL_ADD), .BIST_ROW_ADD(BIST_ROW_ADD[0]), 
 .BIST_ROW_ADD_ts1(BIST_ROW_ADD[1]), .BIST_ROW_ADD_ts2(BIST_ROW_ADD[2]), 
 .BIST_ROW_ADD_ts3(BIST_ROW_ADD[3]), .BIST_ROW_ADD_ts4(BIST_ROW_ADD[4]), 
 .BIST_COLLAR_EN0(BIST_COLLAR_EN0), .BIST_COLLAR_EN1(BIST_COLLAR_EN1), 
 .BIST_COLLAR_EN2(BIST_COLLAR_EN2), .BIST_COLLAR_EN3(BIST_COLLAR_EN3), 
 .BIST_COLLAR_EN4(BIST_COLLAR_EN4), .BIST_COLLAR_EN5(BIST_COLLAR_EN5), 
 .BIST_COLLAR_EN6(BIST_COLLAR_EN6), .BIST_COLLAR_EN7(BIST_COLLAR_EN7), 
 .BIST_COLLAR_EN8(BIST_COLLAR_EN8), .BIST_COLLAR_EN9(BIST_COLLAR_EN9), 
 .BIST_COLLAR_EN10(BIST_COLLAR_EN10), .BIST_COLLAR_EN11(BIST_COLLAR_EN11), 
 .BIST_COLLAR_EN12(BIST_COLLAR_EN12), .BIST_COLLAR_EN13(BIST_COLLAR_EN13), 
 .BIST_COLLAR_EN14(BIST_COLLAR_EN14), .BIST_COLLAR_EN15(BIST_COLLAR_EN15), 
 .BIST_RUN_TO_COLLAR0(BIST_RUN_TO_COLLAR0), .BIST_RUN_TO_COLLAR1(BIST_RUN_TO_COLLAR1), 
 .BIST_RUN_TO_COLLAR2(BIST_RUN_TO_COLLAR2), .BIST_RUN_TO_COLLAR3(BIST_RUN_TO_COLLAR3), 
 .BIST_RUN_TO_COLLAR4(BIST_RUN_TO_COLLAR4), .BIST_RUN_TO_COLLAR5(BIST_RUN_TO_COLLAR5), 
 .BIST_RUN_TO_COLLAR6(BIST_RUN_TO_COLLAR6), .BIST_RUN_TO_COLLAR7(BIST_RUN_TO_COLLAR7), 
 .BIST_RUN_TO_COLLAR8(BIST_RUN_TO_COLLAR8), .BIST_RUN_TO_COLLAR9(BIST_RUN_TO_COLLAR9), 
 .BIST_RUN_TO_COLLAR10(BIST_RUN_TO_COLLAR10), .BIST_RUN_TO_COLLAR11(BIST_RUN_TO_COLLAR11), 
 .BIST_RUN_TO_COLLAR12(BIST_RUN_TO_COLLAR12), .BIST_RUN_TO_COLLAR13(BIST_RUN_TO_COLLAR13), 
 .BIST_RUN_TO_COLLAR14(BIST_RUN_TO_COLLAR14), .BIST_RUN_TO_COLLAR15(BIST_RUN_TO_COLLAR15), 
 .BIST_ASYNC_RESET(BIST_ASYNC_RESET), .BIST_SHADOW_READENABLE(BIST_SHADOW_READENABLE), 
 .BIST_SHADOW_READADDRESS(BIST_SHADOW_READADDRESS), .BIST_CONWRITE_ROWADDRESS(BIST_CONWRITE_ROWADDRESS), 
 .BIST_CONWRITE_ENABLE(BIST_CONWRITE_ENABLE), .BIST_CONREAD_ROWADDRESS(BIST_CONREAD_ROWADDRESS), 
 .BIST_CONREAD_COLUMNADDRESS(BIST_CONREAD_COLUMNADDRESS), 
 .BIST_CONREAD_ENABLE(BIST_CONREAD_ENABLE), .BIST_TESTDATA_SELECT_TO_COLLAR(BIST_TESTDATA_SELECT_TO_COLLAR), 
 .BIST_ON_TO_COLLAR(BIST_ON_TO_COLLAR), .BIST_WRITE_DATA(BIST_WRITE_DATA[0]), 
 .BIST_WRITE_DATA_ts1(BIST_WRITE_DATA[1]), .BIST_WRITE_DATA_ts2(BIST_WRITE_DATA[2]), 
 .BIST_WRITE_DATA_ts3(BIST_WRITE_DATA[3]), .BIST_WRITE_DATA_ts4(BIST_WRITE_DATA[4]), 
 .BIST_WRITE_DATA_ts5(BIST_WRITE_DATA[5]), .BIST_WRITE_DATA_ts6(BIST_WRITE_DATA[6]), 
 .BIST_WRITE_DATA_ts7(BIST_WRITE_DATA[7]), .BIST_EXPECT_DATA(BIST_EXPECT_DATA[0]), 
 .BIST_EXPECT_DATA_ts1(BIST_EXPECT_DATA[1]), .BIST_EXPECT_DATA_ts2(BIST_EXPECT_DATA[2]), 
 .BIST_EXPECT_DATA_ts3(BIST_EXPECT_DATA[3]), .BIST_EXPECT_DATA_ts4(BIST_EXPECT_DATA[4]), 
 .BIST_EXPECT_DATA_ts5(BIST_EXPECT_DATA[5]), .BIST_EXPECT_DATA_ts6(BIST_EXPECT_DATA[6]), 
 .BIST_EXPECT_DATA_ts7(BIST_EXPECT_DATA[7]), .BIST_SHIFT_COLLAR(BIST_SHIFT_COLLAR), 
 .BIST_COLLAR_SETUP(BIST_COLLAR_SETUP), .BIST_CLEAR_DEFAULT(BIST_CLEAR_DEFAULT), 
 .BIST_CLEAR(BIST_CLEAR), .BIST_COLLAR_OPSET_SELECT(BIST_COLLAR_OPSET_SELECT), 
 .BIST_COLLAR_HOLD(BIST_COLLAR_HOLD), .FREEZE_STOP_ERROR(FREEZE_STOP_ERROR), 
 .ERROR_CNT_ZERO(ERROR_CNT_ZERO), .MBISTPG_RESET_REG_SETUP2(MBISTPG_RESET_REG_SETUP2), 
 .bisr_shift_en_pd_vinf(bisr_shift_en_pd_vinf), .bisr_clk_pd_vinf(bisr_clk_pd_vinf), 
 .bisr_reset_pd_vinf(bisr_reset_pd_vinf), .bisr_si_pd_vinf(bisr_si_pd_vinf), 
 .ram_row_0_col_0_bisr_inst_SO(ram_row_0_col_0_bisr_inst_SO_ts1));

/*
  hlp_fgrp_apr_ff_mems AUTO_TEMPLATE
 (
  .fgrp_\(.*\)_\([0-9]+\)_from_mem (frm_\1[\2][]),
  .fgrp_\(.*\)_\([0-9]+\)_to_mem   (tom_\1[\2][]),
  .fgrp_\(.*\)_from_mem              (frm_\1[]),
  .fgrp_\(.*\)_to_mem                (tom_\1[]),
  .fghash_\(.*\)_\([0-9]+\)_from_mem (frm_\1[\2][]),
  .fghash_\(.*\)_\([0-9]+\)_to_mem   (tom_\1[\2][]),
  .fghash_\(.*\)_from_mem              (frm_\1[]),
  .fghash_\(.*\)_to_mem                (tom_\1[]),
  .fary_ffuse.* ('0),
  .car_raw_lan_power_good_with_byprst (local_broadcast.fuse_rst_b) );*/


hlp_fgrp_apr_ff_mems u_fgrp_apr_ff_mems
(// Manual connections
 /*AUTOINST*/
 // Outputs
 .fghash_ffu_hash_cfg_from_mem          (frm_ffu_hash_cfg[`HLP_FGHASH_FFU_HASH_CFG_FROM_MEM_WIDTH-1:0]), // Templated
 .fghash_ffu_hash_miss_0_from_mem       (frm_ffu_hash_miss[0][`HLP_FGHASH_FFU_HASH_MISS_FROM_MEM_WIDTH-1:0]), // Templated
 .fghash_ffu_hash_miss_1_from_mem       (frm_ffu_hash_miss[1][`HLP_FGHASH_FFU_HASH_MISS_FROM_MEM_WIDTH-1:0]), // Templated
 .fghash_ffu_key_mask0_0_from_mem       (frm_ffu_key_mask0[0][`HLP_FGHASH_FFU_KEY_MASK0_FROM_MEM_WIDTH-1:0]), // Templated
 .fghash_ffu_key_mask0_1_from_mem       (frm_ffu_key_mask0[1][`HLP_FGHASH_FFU_KEY_MASK0_FROM_MEM_WIDTH-1:0]), // Templated
 .fghash_ffu_key_mask1_0_from_mem       (frm_ffu_key_mask1[0][`HLP_FGHASH_FFU_KEY_MASK1_FROM_MEM_WIDTH-1:0]), // Templated
 .fghash_ffu_key_mask1_1_from_mem       (frm_ffu_key_mask1[1][`HLP_FGHASH_FFU_KEY_MASK1_FROM_MEM_WIDTH-1:0]), // Templated
 .fghash_ffu_key_mask2_0_from_mem       (frm_ffu_key_mask2[0][`HLP_FGHASH_FFU_KEY_MASK2_FROM_MEM_WIDTH-1:0]), // Templated
 .fghash_ffu_key_mask2_1_from_mem       (frm_ffu_key_mask2[1][`HLP_FGHASH_FFU_KEY_MASK2_FROM_MEM_WIDTH-1:0]), // Templated
 .fghash_ffu_key_mask3_0_from_mem       (frm_ffu_key_mask3[0][`HLP_FGHASH_FFU_KEY_MASK3_FROM_MEM_WIDTH-1:0]), // Templated
 .fghash_ffu_key_mask3_1_from_mem       (frm_ffu_key_mask3[1][`HLP_FGHASH_FFU_KEY_MASK3_FROM_MEM_WIDTH-1:0]), // Templated
 .fghash_ffu_key_mask4_0_from_mem       (frm_ffu_key_mask4[0][`HLP_FGHASH_FFU_KEY_MASK4_FROM_MEM_WIDTH-1:0]), // Templated
 .fghash_ffu_key_mask4_1_from_mem       (frm_ffu_key_mask4[1][`HLP_FGHASH_FFU_KEY_MASK4_FROM_MEM_WIDTH-1:0]), // Templated
 // Inputs
 .clk                                   (clk_ts1),
 .fghash_ffu_hash_cfg_to_mem            (tom_ffu_hash_cfg[`HLP_FGHASH_FFU_HASH_CFG_TO_MEM_WIDTH-1:0]), // Templated
 .fghash_ffu_hash_miss_0_to_mem         (tom_ffu_hash_miss[0][`HLP_FGHASH_FFU_HASH_MISS_TO_MEM_WIDTH-1:0]), // Templated
 .fghash_ffu_hash_miss_1_to_mem         (tom_ffu_hash_miss[1][`HLP_FGHASH_FFU_HASH_MISS_TO_MEM_WIDTH-1:0]), // Templated
 .fghash_ffu_key_mask0_0_to_mem         (tom_ffu_key_mask0[0][`HLP_FGHASH_FFU_KEY_MASK0_TO_MEM_WIDTH-1:0]), // Templated
 .fghash_ffu_key_mask0_1_to_mem         (tom_ffu_key_mask0[1][`HLP_FGHASH_FFU_KEY_MASK0_TO_MEM_WIDTH-1:0]), // Templated
 .fghash_ffu_key_mask1_0_to_mem         (tom_ffu_key_mask1[0][`HLP_FGHASH_FFU_KEY_MASK1_TO_MEM_WIDTH-1:0]), // Templated
 .fghash_ffu_key_mask1_1_to_mem         (tom_ffu_key_mask1[1][`HLP_FGHASH_FFU_KEY_MASK1_TO_MEM_WIDTH-1:0]), // Templated
 .fghash_ffu_key_mask2_0_to_mem         (tom_ffu_key_mask2[0][`HLP_FGHASH_FFU_KEY_MASK2_TO_MEM_WIDTH-1:0]), // Templated
 .fghash_ffu_key_mask2_1_to_mem         (tom_ffu_key_mask2[1][`HLP_FGHASH_FFU_KEY_MASK2_TO_MEM_WIDTH-1:0]), // Templated
 .fghash_ffu_key_mask3_0_to_mem         (tom_ffu_key_mask3[0][`HLP_FGHASH_FFU_KEY_MASK3_TO_MEM_WIDTH-1:0]), // Templated
 .fghash_ffu_key_mask3_1_to_mem         (tom_ffu_key_mask3[1][`HLP_FGHASH_FFU_KEY_MASK3_TO_MEM_WIDTH-1:0]), // Templated
 .fghash_ffu_key_mask4_0_to_mem         (tom_ffu_key_mask4[0][`HLP_FGHASH_FFU_KEY_MASK4_TO_MEM_WIDTH-1:0]), // Templated
 .fghash_ffu_key_mask4_1_to_mem         (tom_ffu_key_mask4[1][`HLP_FGHASH_FFU_KEY_MASK4_TO_MEM_WIDTH-1:0])); // Templated
/*
  hlp_fgrp_apr_tcam_mems AUTO_TEMPLATE
 (
  .fgrp_\(.*\)_\([0-9]+\)_from_tcam (nm_frm_\1[\2 / hlp_pkg::N_FFU_GROUP_TPS][\2 % hlp_pkg::N_FFU_GROUP_TPS][]),
  .fgrp_\(.*\)_\([0-9]+\)_to_tcam   (nm_tom_\1[\2 / hlp_pkg::N_FFU_GROUP_TPS][\2 % hlp_pkg::N_FFU_GROUP_TPS][]),
  .fgrp_\(.*\)_from_tcam              (frm_\1[]),
  .fgrp_\(.*\)_to_tcam                (tom_\1[]),
  .fary_isolation_control_in  (isol_en_b),
  .ip_reset_b (local_broadcast.mem_rst_b),
  .car_raw_lan_power_good_with_byprst (local_broadcast.fuse_rst_b) );*/


hlp_fgrp_apr_tcam_mems u_fgrp_apr_tcam_mems
(// Manual connections
`ifdef HLP_FPGA_TCAM_MEMS
 .fpga_fast_clk(),
`endif
 .fary_pwren_b_tcam (fet_ack_b_to_tcam),
 .aary_pwren_b_tcam (fet_ack_b),
 /*AUTOINST*/
 // Outputs
 .fgrp_ffu_tcam_0_from_tcam             (nm_frm_ffu_tcam[0 / hlp_pkg::N_FFU_GROUP_TPS][0 % hlp_pkg::N_FFU_GROUP_TPS][`HLP_FGRP_FFU_TCAM_FROM_TCAM_WIDTH-1:0]), // Templated
 .fgrp_ffu_tcam_10_from_tcam            (nm_frm_ffu_tcam[10 / hlp_pkg::N_FFU_GROUP_TPS][10 % hlp_pkg::N_FFU_GROUP_TPS][`HLP_FGRP_FFU_TCAM_FROM_TCAM_WIDTH-1:0]), // Templated
 .fgrp_ffu_tcam_11_from_tcam            (nm_frm_ffu_tcam[11 / hlp_pkg::N_FFU_GROUP_TPS][11 % hlp_pkg::N_FFU_GROUP_TPS][`HLP_FGRP_FFU_TCAM_FROM_TCAM_WIDTH-1:0]), // Templated
 .fgrp_ffu_tcam_12_from_tcam            (nm_frm_ffu_tcam[12 / hlp_pkg::N_FFU_GROUP_TPS][12 % hlp_pkg::N_FFU_GROUP_TPS][`HLP_FGRP_FFU_TCAM_FROM_TCAM_WIDTH-1:0]), // Templated
 .fgrp_ffu_tcam_13_from_tcam            (nm_frm_ffu_tcam[13 / hlp_pkg::N_FFU_GROUP_TPS][13 % hlp_pkg::N_FFU_GROUP_TPS][`HLP_FGRP_FFU_TCAM_FROM_TCAM_WIDTH-1:0]), // Templated
 .fgrp_ffu_tcam_14_from_tcam            (nm_frm_ffu_tcam[14 / hlp_pkg::N_FFU_GROUP_TPS][14 % hlp_pkg::N_FFU_GROUP_TPS][`HLP_FGRP_FFU_TCAM_FROM_TCAM_WIDTH-1:0]), // Templated
 .fgrp_ffu_tcam_15_from_tcam            (nm_frm_ffu_tcam[15 / hlp_pkg::N_FFU_GROUP_TPS][15 % hlp_pkg::N_FFU_GROUP_TPS][`HLP_FGRP_FFU_TCAM_FROM_TCAM_WIDTH-1:0]), // Templated
 .fgrp_ffu_tcam_16_from_tcam            (nm_frm_ffu_tcam[16 / hlp_pkg::N_FFU_GROUP_TPS][16 % hlp_pkg::N_FFU_GROUP_TPS][`HLP_FGRP_FFU_TCAM_FROM_TCAM_WIDTH-1:0]), // Templated
 .fgrp_ffu_tcam_17_from_tcam            (nm_frm_ffu_tcam[17 / hlp_pkg::N_FFU_GROUP_TPS][17 % hlp_pkg::N_FFU_GROUP_TPS][`HLP_FGRP_FFU_TCAM_FROM_TCAM_WIDTH-1:0]), // Templated
 .fgrp_ffu_tcam_18_from_tcam            (nm_frm_ffu_tcam[18 / hlp_pkg::N_FFU_GROUP_TPS][18 % hlp_pkg::N_FFU_GROUP_TPS][`HLP_FGRP_FFU_TCAM_FROM_TCAM_WIDTH-1:0]), // Templated
 .fgrp_ffu_tcam_19_from_tcam            (nm_frm_ffu_tcam[19 / hlp_pkg::N_FFU_GROUP_TPS][19 % hlp_pkg::N_FFU_GROUP_TPS][`HLP_FGRP_FFU_TCAM_FROM_TCAM_WIDTH-1:0]), // Templated
 .fgrp_ffu_tcam_1_from_tcam             (nm_frm_ffu_tcam[1 / hlp_pkg::N_FFU_GROUP_TPS][1 % hlp_pkg::N_FFU_GROUP_TPS][`HLP_FGRP_FFU_TCAM_FROM_TCAM_WIDTH-1:0]), // Templated
 .fgrp_ffu_tcam_20_from_tcam            (nm_frm_ffu_tcam[20 / hlp_pkg::N_FFU_GROUP_TPS][20 % hlp_pkg::N_FFU_GROUP_TPS][`HLP_FGRP_FFU_TCAM_FROM_TCAM_WIDTH-1:0]), // Templated
 .fgrp_ffu_tcam_21_from_tcam            (nm_frm_ffu_tcam[21 / hlp_pkg::N_FFU_GROUP_TPS][21 % hlp_pkg::N_FFU_GROUP_TPS][`HLP_FGRP_FFU_TCAM_FROM_TCAM_WIDTH-1:0]), // Templated
 .fgrp_ffu_tcam_22_from_tcam            (nm_frm_ffu_tcam[22 / hlp_pkg::N_FFU_GROUP_TPS][22 % hlp_pkg::N_FFU_GROUP_TPS][`HLP_FGRP_FFU_TCAM_FROM_TCAM_WIDTH-1:0]), // Templated
 .fgrp_ffu_tcam_23_from_tcam            (nm_frm_ffu_tcam[23 / hlp_pkg::N_FFU_GROUP_TPS][23 % hlp_pkg::N_FFU_GROUP_TPS][`HLP_FGRP_FFU_TCAM_FROM_TCAM_WIDTH-1:0]), // Templated
 .fgrp_ffu_tcam_24_from_tcam            (nm_frm_ffu_tcam[24 / hlp_pkg::N_FFU_GROUP_TPS][24 % hlp_pkg::N_FFU_GROUP_TPS][`HLP_FGRP_FFU_TCAM_FROM_TCAM_WIDTH-1:0]), // Templated
 .fgrp_ffu_tcam_25_from_tcam            (nm_frm_ffu_tcam[25 / hlp_pkg::N_FFU_GROUP_TPS][25 % hlp_pkg::N_FFU_GROUP_TPS][`HLP_FGRP_FFU_TCAM_FROM_TCAM_WIDTH-1:0]), // Templated
 .fgrp_ffu_tcam_26_from_tcam            (nm_frm_ffu_tcam[26 / hlp_pkg::N_FFU_GROUP_TPS][26 % hlp_pkg::N_FFU_GROUP_TPS][`HLP_FGRP_FFU_TCAM_FROM_TCAM_WIDTH-1:0]), // Templated
 .fgrp_ffu_tcam_27_from_tcam            (nm_frm_ffu_tcam[27 / hlp_pkg::N_FFU_GROUP_TPS][27 % hlp_pkg::N_FFU_GROUP_TPS][`HLP_FGRP_FFU_TCAM_FROM_TCAM_WIDTH-1:0]), // Templated
 .fgrp_ffu_tcam_28_from_tcam            (nm_frm_ffu_tcam[28 / hlp_pkg::N_FFU_GROUP_TPS][28 % hlp_pkg::N_FFU_GROUP_TPS][`HLP_FGRP_FFU_TCAM_FROM_TCAM_WIDTH-1:0]), // Templated
 .fgrp_ffu_tcam_29_from_tcam            (nm_frm_ffu_tcam[29 / hlp_pkg::N_FFU_GROUP_TPS][29 % hlp_pkg::N_FFU_GROUP_TPS][`HLP_FGRP_FFU_TCAM_FROM_TCAM_WIDTH-1:0]), // Templated
 .fgrp_ffu_tcam_2_from_tcam             (nm_frm_ffu_tcam[2 / hlp_pkg::N_FFU_GROUP_TPS][2 % hlp_pkg::N_FFU_GROUP_TPS][`HLP_FGRP_FFU_TCAM_FROM_TCAM_WIDTH-1:0]), // Templated
 .fgrp_ffu_tcam_30_from_tcam            (nm_frm_ffu_tcam[30 / hlp_pkg::N_FFU_GROUP_TPS][30 % hlp_pkg::N_FFU_GROUP_TPS][`HLP_FGRP_FFU_TCAM_FROM_TCAM_WIDTH-1:0]), // Templated
 .fgrp_ffu_tcam_31_from_tcam            (nm_frm_ffu_tcam[31 / hlp_pkg::N_FFU_GROUP_TPS][31 % hlp_pkg::N_FFU_GROUP_TPS][`HLP_FGRP_FFU_TCAM_FROM_TCAM_WIDTH-1:0]), // Templated
 .fgrp_ffu_tcam_3_from_tcam             (nm_frm_ffu_tcam[3 / hlp_pkg::N_FFU_GROUP_TPS][3 % hlp_pkg::N_FFU_GROUP_TPS][`HLP_FGRP_FFU_TCAM_FROM_TCAM_WIDTH-1:0]), // Templated
 .fgrp_ffu_tcam_4_from_tcam             (nm_frm_ffu_tcam[4 / hlp_pkg::N_FFU_GROUP_TPS][4 % hlp_pkg::N_FFU_GROUP_TPS][`HLP_FGRP_FFU_TCAM_FROM_TCAM_WIDTH-1:0]), // Templated
 .fgrp_ffu_tcam_5_from_tcam             (nm_frm_ffu_tcam[5 / hlp_pkg::N_FFU_GROUP_TPS][5 % hlp_pkg::N_FFU_GROUP_TPS][`HLP_FGRP_FFU_TCAM_FROM_TCAM_WIDTH-1:0]), // Templated
 .fgrp_ffu_tcam_6_from_tcam             (nm_frm_ffu_tcam[6 / hlp_pkg::N_FFU_GROUP_TPS][6 % hlp_pkg::N_FFU_GROUP_TPS][`HLP_FGRP_FFU_TCAM_FROM_TCAM_WIDTH-1:0]), // Templated
 .fgrp_ffu_tcam_7_from_tcam             (nm_frm_ffu_tcam[7 / hlp_pkg::N_FFU_GROUP_TPS][7 % hlp_pkg::N_FFU_GROUP_TPS][`HLP_FGRP_FFU_TCAM_FROM_TCAM_WIDTH-1:0]), // Templated
 .fgrp_ffu_tcam_8_from_tcam             (nm_frm_ffu_tcam[8 / hlp_pkg::N_FFU_GROUP_TPS][8 % hlp_pkg::N_FFU_GROUP_TPS][`HLP_FGRP_FFU_TCAM_FROM_TCAM_WIDTH-1:0]), // Templated
 .fgrp_ffu_tcam_9_from_tcam             (nm_frm_ffu_tcam[9 / hlp_pkg::N_FFU_GROUP_TPS][9 % hlp_pkg::N_FFU_GROUP_TPS][`HLP_FGRP_FFU_TCAM_FROM_TCAM_WIDTH-1:0]), // Templated
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
 .fgrp_ffu_tcam_0_to_tcam               (nm_tom_ffu_tcam[0 / hlp_pkg::N_FFU_GROUP_TPS][0 % hlp_pkg::N_FFU_GROUP_TPS][`HLP_FGRP_FFU_TCAM_TO_TCAM_WIDTH-1:0]), // Templated
 .fgrp_ffu_tcam_10_to_tcam              (nm_tom_ffu_tcam[10 / hlp_pkg::N_FFU_GROUP_TPS][10 % hlp_pkg::N_FFU_GROUP_TPS][`HLP_FGRP_FFU_TCAM_TO_TCAM_WIDTH-1:0]), // Templated
 .fgrp_ffu_tcam_11_to_tcam              (nm_tom_ffu_tcam[11 / hlp_pkg::N_FFU_GROUP_TPS][11 % hlp_pkg::N_FFU_GROUP_TPS][`HLP_FGRP_FFU_TCAM_TO_TCAM_WIDTH-1:0]), // Templated
 .fgrp_ffu_tcam_12_to_tcam              (nm_tom_ffu_tcam[12 / hlp_pkg::N_FFU_GROUP_TPS][12 % hlp_pkg::N_FFU_GROUP_TPS][`HLP_FGRP_FFU_TCAM_TO_TCAM_WIDTH-1:0]), // Templated
 .fgrp_ffu_tcam_13_to_tcam              (nm_tom_ffu_tcam[13 / hlp_pkg::N_FFU_GROUP_TPS][13 % hlp_pkg::N_FFU_GROUP_TPS][`HLP_FGRP_FFU_TCAM_TO_TCAM_WIDTH-1:0]), // Templated
 .fgrp_ffu_tcam_14_to_tcam              (nm_tom_ffu_tcam[14 / hlp_pkg::N_FFU_GROUP_TPS][14 % hlp_pkg::N_FFU_GROUP_TPS][`HLP_FGRP_FFU_TCAM_TO_TCAM_WIDTH-1:0]), // Templated
 .fgrp_ffu_tcam_15_to_tcam              (nm_tom_ffu_tcam[15 / hlp_pkg::N_FFU_GROUP_TPS][15 % hlp_pkg::N_FFU_GROUP_TPS][`HLP_FGRP_FFU_TCAM_TO_TCAM_WIDTH-1:0]), // Templated
 .fgrp_ffu_tcam_16_to_tcam              (nm_tom_ffu_tcam[16 / hlp_pkg::N_FFU_GROUP_TPS][16 % hlp_pkg::N_FFU_GROUP_TPS][`HLP_FGRP_FFU_TCAM_TO_TCAM_WIDTH-1:0]), // Templated
 .fgrp_ffu_tcam_17_to_tcam              (nm_tom_ffu_tcam[17 / hlp_pkg::N_FFU_GROUP_TPS][17 % hlp_pkg::N_FFU_GROUP_TPS][`HLP_FGRP_FFU_TCAM_TO_TCAM_WIDTH-1:0]), // Templated
 .fgrp_ffu_tcam_18_to_tcam              (nm_tom_ffu_tcam[18 / hlp_pkg::N_FFU_GROUP_TPS][18 % hlp_pkg::N_FFU_GROUP_TPS][`HLP_FGRP_FFU_TCAM_TO_TCAM_WIDTH-1:0]), // Templated
 .fgrp_ffu_tcam_19_to_tcam              (nm_tom_ffu_tcam[19 / hlp_pkg::N_FFU_GROUP_TPS][19 % hlp_pkg::N_FFU_GROUP_TPS][`HLP_FGRP_FFU_TCAM_TO_TCAM_WIDTH-1:0]), // Templated
 .fgrp_ffu_tcam_1_to_tcam               (nm_tom_ffu_tcam[1 / hlp_pkg::N_FFU_GROUP_TPS][1 % hlp_pkg::N_FFU_GROUP_TPS][`HLP_FGRP_FFU_TCAM_TO_TCAM_WIDTH-1:0]), // Templated
 .fgrp_ffu_tcam_20_to_tcam              (nm_tom_ffu_tcam[20 / hlp_pkg::N_FFU_GROUP_TPS][20 % hlp_pkg::N_FFU_GROUP_TPS][`HLP_FGRP_FFU_TCAM_TO_TCAM_WIDTH-1:0]), // Templated
 .fgrp_ffu_tcam_21_to_tcam              (nm_tom_ffu_tcam[21 / hlp_pkg::N_FFU_GROUP_TPS][21 % hlp_pkg::N_FFU_GROUP_TPS][`HLP_FGRP_FFU_TCAM_TO_TCAM_WIDTH-1:0]), // Templated
 .fgrp_ffu_tcam_22_to_tcam              (nm_tom_ffu_tcam[22 / hlp_pkg::N_FFU_GROUP_TPS][22 % hlp_pkg::N_FFU_GROUP_TPS][`HLP_FGRP_FFU_TCAM_TO_TCAM_WIDTH-1:0]), // Templated
 .fgrp_ffu_tcam_23_to_tcam              (nm_tom_ffu_tcam[23 / hlp_pkg::N_FFU_GROUP_TPS][23 % hlp_pkg::N_FFU_GROUP_TPS][`HLP_FGRP_FFU_TCAM_TO_TCAM_WIDTH-1:0]), // Templated
 .fgrp_ffu_tcam_24_to_tcam              (nm_tom_ffu_tcam[24 / hlp_pkg::N_FFU_GROUP_TPS][24 % hlp_pkg::N_FFU_GROUP_TPS][`HLP_FGRP_FFU_TCAM_TO_TCAM_WIDTH-1:0]), // Templated
 .fgrp_ffu_tcam_25_to_tcam              (nm_tom_ffu_tcam[25 / hlp_pkg::N_FFU_GROUP_TPS][25 % hlp_pkg::N_FFU_GROUP_TPS][`HLP_FGRP_FFU_TCAM_TO_TCAM_WIDTH-1:0]), // Templated
 .fgrp_ffu_tcam_26_to_tcam              (nm_tom_ffu_tcam[26 / hlp_pkg::N_FFU_GROUP_TPS][26 % hlp_pkg::N_FFU_GROUP_TPS][`HLP_FGRP_FFU_TCAM_TO_TCAM_WIDTH-1:0]), // Templated
 .fgrp_ffu_tcam_27_to_tcam              (nm_tom_ffu_tcam[27 / hlp_pkg::N_FFU_GROUP_TPS][27 % hlp_pkg::N_FFU_GROUP_TPS][`HLP_FGRP_FFU_TCAM_TO_TCAM_WIDTH-1:0]), // Templated
 .fgrp_ffu_tcam_28_to_tcam              (nm_tom_ffu_tcam[28 / hlp_pkg::N_FFU_GROUP_TPS][28 % hlp_pkg::N_FFU_GROUP_TPS][`HLP_FGRP_FFU_TCAM_TO_TCAM_WIDTH-1:0]), // Templated
 .fgrp_ffu_tcam_29_to_tcam              (nm_tom_ffu_tcam[29 / hlp_pkg::N_FFU_GROUP_TPS][29 % hlp_pkg::N_FFU_GROUP_TPS][`HLP_FGRP_FFU_TCAM_TO_TCAM_WIDTH-1:0]), // Templated
 .fgrp_ffu_tcam_2_to_tcam               (nm_tom_ffu_tcam[2 / hlp_pkg::N_FFU_GROUP_TPS][2 % hlp_pkg::N_FFU_GROUP_TPS][`HLP_FGRP_FFU_TCAM_TO_TCAM_WIDTH-1:0]), // Templated
 .fgrp_ffu_tcam_30_to_tcam              (nm_tom_ffu_tcam[30 / hlp_pkg::N_FFU_GROUP_TPS][30 % hlp_pkg::N_FFU_GROUP_TPS][`HLP_FGRP_FFU_TCAM_TO_TCAM_WIDTH-1:0]), // Templated
 .fgrp_ffu_tcam_31_to_tcam              (nm_tom_ffu_tcam[31 / hlp_pkg::N_FFU_GROUP_TPS][31 % hlp_pkg::N_FFU_GROUP_TPS][`HLP_FGRP_FFU_TCAM_TO_TCAM_WIDTH-1:0]), // Templated
 .fgrp_ffu_tcam_3_to_tcam               (nm_tom_ffu_tcam[3 / hlp_pkg::N_FFU_GROUP_TPS][3 % hlp_pkg::N_FFU_GROUP_TPS][`HLP_FGRP_FFU_TCAM_TO_TCAM_WIDTH-1:0]), // Templated
 .fgrp_ffu_tcam_4_to_tcam               (nm_tom_ffu_tcam[4 / hlp_pkg::N_FFU_GROUP_TPS][4 % hlp_pkg::N_FFU_GROUP_TPS][`HLP_FGRP_FFU_TCAM_TO_TCAM_WIDTH-1:0]), // Templated
 .fgrp_ffu_tcam_5_to_tcam               (nm_tom_ffu_tcam[5 / hlp_pkg::N_FFU_GROUP_TPS][5 % hlp_pkg::N_FFU_GROUP_TPS][`HLP_FGRP_FFU_TCAM_TO_TCAM_WIDTH-1:0]), // Templated
 .fgrp_ffu_tcam_6_to_tcam               (nm_tom_ffu_tcam[6 / hlp_pkg::N_FFU_GROUP_TPS][6 % hlp_pkg::N_FFU_GROUP_TPS][`HLP_FGRP_FFU_TCAM_TO_TCAM_WIDTH-1:0]), // Templated
 .fgrp_ffu_tcam_7_to_tcam               (nm_tom_ffu_tcam[7 / hlp_pkg::N_FFU_GROUP_TPS][7 % hlp_pkg::N_FFU_GROUP_TPS][`HLP_FGRP_FFU_TCAM_TO_TCAM_WIDTH-1:0]), // Templated
 .fgrp_ffu_tcam_8_to_tcam               (nm_tom_ffu_tcam[8 / hlp_pkg::N_FFU_GROUP_TPS][8 % hlp_pkg::N_FFU_GROUP_TPS][`HLP_FGRP_FFU_TCAM_TO_TCAM_WIDTH-1:0]), // Templated
 .fgrp_ffu_tcam_9_to_tcam               (nm_tom_ffu_tcam[9 / hlp_pkg::N_FFU_GROUP_TPS][9 % hlp_pkg::N_FFU_GROUP_TPS][`HLP_FGRP_FFU_TCAM_TO_TCAM_WIDTH-1:0]), // Templated
 .fscan_clkungate                       (fscan_clkungate),
 .fscan_mode                            (fscan_mode),
 .fscan_ram_bypsel_tcam                 (fscan_ram_bypsel_tcam),
 .fscan_ram_init_en                     (fscan_ram_init_en),
 .fscan_ram_init_val                    (fscan_ram_init_val),
 .fscan_ram_rdis_b                      (fscan_ram_rdis_b),
 .fscan_ram_wdis_b                      (fscan_ram_wdis_b),
 .fscan_shiften                         (fscan_shiften),
 .fsta_dfxact_afd                       (fsta_dfxact_afd),
 .ip_reset_b                            (local_broadcast.mem_rst_b), .BIST_SETUP(BIST_SETUP[0]), .BIST_SETUP_ts1(BIST_SETUP[1]), 
 .BIST_SETUP_ts2(BIST_SETUP[2]), .to_interfaces_tck(to_interfaces_tck), 
 .mcp_bounding_to_en(mcp_bounding_to_en), .scan_to_en(scan_to_en), 
 .memory_bypass_to_en(memory_bypass_to_en), .GO_ID_REG_SEL(GO_ID_REG_SEL_ts3), 
 .BIST_CLEAR_BIRA(BIST_CLEAR_BIRA_ts3), .BIST_COLLAR_DIAG_EN(BIST_COLLAR_DIAG_EN_ts3), 
 .BIST_COLLAR_BIRA_EN(BIST_COLLAR_BIRA_EN_ts3), .BIST_SHIFT_BIRA_COLLAR(BIST_SHIFT_BIRA_COLLAR_ts3), 
 .CHECK_REPAIR_NEEDED(CHECK_REPAIR_NEEDED), .MEM0_BIST_COLLAR_SI(MEM0_BIST_COLLAR_SI_ts3), 
 .MEM1_BIST_COLLAR_SI(MEM1_BIST_COLLAR_SI_ts3), .MEM2_BIST_COLLAR_SI(MEM2_BIST_COLLAR_SI_ts3), 
 .MEM3_BIST_COLLAR_SI(MEM3_BIST_COLLAR_SI_ts3), .MEM4_BIST_COLLAR_SI(MEM4_BIST_COLLAR_SI_ts2), 
 .MEM5_BIST_COLLAR_SI(MEM5_BIST_COLLAR_SI_ts2), .MEM6_BIST_COLLAR_SI(MEM6_BIST_COLLAR_SI_ts2), 
 .MEM7_BIST_COLLAR_SI(MEM7_BIST_COLLAR_SI_ts2), .MEM8_BIST_COLLAR_SI(MEM8_BIST_COLLAR_SI_ts2), 
 .MEM9_BIST_COLLAR_SI(MEM9_BIST_COLLAR_SI_ts2), .MEM10_BIST_COLLAR_SI(MEM10_BIST_COLLAR_SI_ts2), 
 .MEM11_BIST_COLLAR_SI(MEM11_BIST_COLLAR_SI_ts2), .MEM12_BIST_COLLAR_SI(MEM12_BIST_COLLAR_SI_ts2), 
 .MEM13_BIST_COLLAR_SI(MEM13_BIST_COLLAR_SI_ts2), .MEM14_BIST_COLLAR_SI(MEM14_BIST_COLLAR_SI_ts2), 
 .MEM15_BIST_COLLAR_SI(MEM15_BIST_COLLAR_SI_ts2), .MEM16_BIST_COLLAR_SI(MEM16_BIST_COLLAR_SI_ts1), 
 .MEM17_BIST_COLLAR_SI(MEM17_BIST_COLLAR_SI_ts1), .MEM18_BIST_COLLAR_SI(MEM18_BIST_COLLAR_SI_ts1), 
 .MEM19_BIST_COLLAR_SI(MEM19_BIST_COLLAR_SI_ts1), .MEM20_BIST_COLLAR_SI(MEM20_BIST_COLLAR_SI), 
 .MEM21_BIST_COLLAR_SI(MEM21_BIST_COLLAR_SI), .MEM22_BIST_COLLAR_SI(MEM22_BIST_COLLAR_SI), 
 .MEM23_BIST_COLLAR_SI(MEM23_BIST_COLLAR_SI), .MEM24_BIST_COLLAR_SI(MEM24_BIST_COLLAR_SI), 
 .MEM25_BIST_COLLAR_SI(MEM25_BIST_COLLAR_SI), .MEM26_BIST_COLLAR_SI(MEM26_BIST_COLLAR_SI), 
 .MEM27_BIST_COLLAR_SI(MEM27_BIST_COLLAR_SI), .MEM28_BIST_COLLAR_SI(MEM28_BIST_COLLAR_SI), 
 .MEM29_BIST_COLLAR_SI(MEM29_BIST_COLLAR_SI), .MEM30_BIST_COLLAR_SI(MEM30_BIST_COLLAR_SI), 
 .MEM31_BIST_COLLAR_SI(MEM31_BIST_COLLAR_SI), .BIST_SO(BIST_SO_ts40), 
 .BIST_SO_ts1(BIST_SO_ts41), .BIST_SO_ts2(BIST_SO_ts42), .BIST_SO_ts3(BIST_SO_ts43), 
 .BIST_SO_ts4(BIST_SO_ts44), .BIST_SO_ts5(BIST_SO_ts45), .BIST_SO_ts6(BIST_SO_ts46), 
 .BIST_SO_ts7(BIST_SO_ts47), .BIST_SO_ts8(BIST_SO_ts48), .BIST_SO_ts9(BIST_SO_ts49), 
 .BIST_SO_ts10(BIST_SO_ts50), .BIST_SO_ts11(BIST_SO_ts51), .BIST_SO_ts12(BIST_SO_ts52), 
 .BIST_SO_ts13(BIST_SO_ts53), .BIST_SO_ts14(BIST_SO_ts54), .BIST_SO_ts15(BIST_SO_ts55), 
 .BIST_SO_ts16(BIST_SO_ts56), .BIST_SO_ts17(BIST_SO_ts57), .BIST_SO_ts18(BIST_SO_ts58), 
 .BIST_SO_ts19(BIST_SO_ts59), .BIST_SO_ts20(BIST_SO_ts60), .BIST_SO_ts21(BIST_SO_ts61), 
 .BIST_SO_ts22(BIST_SO_ts62), .BIST_SO_ts23(BIST_SO_ts63), .BIST_SO_ts24(BIST_SO_ts64), 
 .BIST_SO_ts25(BIST_SO_ts65), .BIST_SO_ts26(BIST_SO_ts66), .BIST_SO_ts27(BIST_SO_ts67), 
 .BIST_SO_ts28(BIST_SO_ts68), .BIST_SO_ts29(BIST_SO_ts69), .BIST_SO_ts30(BIST_SO_ts70), 
 .BIST_SO_ts31(BIST_SO_ts71), .BIST_GO(BIST_GO_ts40), .BIST_GO_ts1(BIST_GO_ts41), 
 .BIST_GO_ts2(BIST_GO_ts42), .BIST_GO_ts3(BIST_GO_ts43), .BIST_GO_ts4(BIST_GO_ts44), 
 .BIST_GO_ts5(BIST_GO_ts45), .BIST_GO_ts6(BIST_GO_ts46), .BIST_GO_ts7(BIST_GO_ts47), 
 .BIST_GO_ts8(BIST_GO_ts48), .BIST_GO_ts9(BIST_GO_ts49), .BIST_GO_ts10(BIST_GO_ts50), 
 .BIST_GO_ts11(BIST_GO_ts51), .BIST_GO_ts12(BIST_GO_ts52), .BIST_GO_ts13(BIST_GO_ts53), 
 .BIST_GO_ts14(BIST_GO_ts54), .BIST_GO_ts15(BIST_GO_ts55), .BIST_GO_ts16(BIST_GO_ts56), 
 .BIST_GO_ts17(BIST_GO_ts57), .BIST_GO_ts18(BIST_GO_ts58), .BIST_GO_ts19(BIST_GO_ts59), 
 .BIST_GO_ts20(BIST_GO_ts60), .BIST_GO_ts21(BIST_GO_ts61), .BIST_GO_ts22(BIST_GO_ts62), 
 .BIST_GO_ts23(BIST_GO_ts63), .BIST_GO_ts24(BIST_GO_ts64), .BIST_GO_ts25(BIST_GO_ts65), 
 .BIST_GO_ts26(BIST_GO_ts66), .BIST_GO_ts27(BIST_GO_ts67), .BIST_GO_ts28(BIST_GO_ts68), 
 .BIST_GO_ts29(BIST_GO_ts69), .BIST_GO_ts30(BIST_GO_ts70), .BIST_GO_ts31(BIST_GO_ts71), 
 .ltest_to_en(ltest_to_en_ts1), .BIST_USER9(BIST_USER9), .BIST_USER10(BIST_USER10), 
 .BIST_USER11(BIST_USER11), .BIST_USER0(BIST_USER0), .BIST_USER1(BIST_USER1), 
 .BIST_USER2(BIST_USER2), .BIST_USER3(BIST_USER3), .BIST_USER4(BIST_USER4), 
 .BIST_USER5(BIST_USER5), .BIST_USER6(BIST_USER6), .BIST_USER7(BIST_USER7), 
 .BIST_USER8(BIST_USER8), .BIST_EVEN_GROUPWRITEENABLE(BIST_EVEN_GROUPWRITEENABLE), 
 .BIST_ODD_GROUPWRITEENABLE(BIST_ODD_GROUPWRITEENABLE), .BIST_WRITEENABLE(BIST_WRITEENABLE_ts3), 
 .BIST_READENABLE(BIST_READENABLE_ts1), .BIST_SELECT(BIST_SELECT_ts2), 
 .BIST_CMP(BIST_CMP_ts3), .INCLUDE_MEM_RESULTS_REG(INCLUDE_MEM_RESULTS_REG), 
 .BIST_COL_ADD(BIST_COL_ADD_ts3), .BIST_ROW_ADD(BIST_ROW_ADD_ts3[0]), 
 .BIST_ROW_ADD_ts1(BIST_ROW_ADD_ts3[1]), .BIST_ROW_ADD_ts2(BIST_ROW_ADD_ts3[2]), 
 .BIST_ROW_ADD_ts3(BIST_ROW_ADD_ts3[3]), .BIST_ROW_ADD_ts4(BIST_ROW_ADD_ts3[4]), 
 .BIST_ROW_ADD_ts5(BIST_ROW_ADD_ts3[5]), .BIST_COLLAR_EN0(BIST_COLLAR_EN0_ts3), 
 .BIST_COLLAR_EN1(BIST_COLLAR_EN1_ts3), .BIST_COLLAR_EN2(BIST_COLLAR_EN2_ts3), 
 .BIST_COLLAR_EN3(BIST_COLLAR_EN3_ts3), .BIST_COLLAR_EN4(BIST_COLLAR_EN4_ts2), 
 .BIST_COLLAR_EN5(BIST_COLLAR_EN5_ts2), .BIST_COLLAR_EN6(BIST_COLLAR_EN6_ts2), 
 .BIST_COLLAR_EN7(BIST_COLLAR_EN7_ts2), .BIST_COLLAR_EN8(BIST_COLLAR_EN8_ts2), 
 .BIST_COLLAR_EN9(BIST_COLLAR_EN9_ts2), .BIST_COLLAR_EN10(BIST_COLLAR_EN10_ts2), 
 .BIST_COLLAR_EN11(BIST_COLLAR_EN11_ts2), .BIST_COLLAR_EN12(BIST_COLLAR_EN12_ts2), 
 .BIST_COLLAR_EN13(BIST_COLLAR_EN13_ts2), .BIST_COLLAR_EN14(BIST_COLLAR_EN14_ts2), 
 .BIST_COLLAR_EN15(BIST_COLLAR_EN15_ts2), .BIST_COLLAR_EN16(BIST_COLLAR_EN16_ts1), 
 .BIST_COLLAR_EN17(BIST_COLLAR_EN17_ts1), .BIST_COLLAR_EN18(BIST_COLLAR_EN18_ts1), 
 .BIST_COLLAR_EN19(BIST_COLLAR_EN19_ts1), .BIST_COLLAR_EN20(BIST_COLLAR_EN20), 
 .BIST_COLLAR_EN21(BIST_COLLAR_EN21), .BIST_COLLAR_EN22(BIST_COLLAR_EN22), 
 .BIST_COLLAR_EN23(BIST_COLLAR_EN23), .BIST_COLLAR_EN24(BIST_COLLAR_EN24), 
 .BIST_COLLAR_EN25(BIST_COLLAR_EN25), .BIST_COLLAR_EN26(BIST_COLLAR_EN26), 
 .BIST_COLLAR_EN27(BIST_COLLAR_EN27), .BIST_COLLAR_EN28(BIST_COLLAR_EN28), 
 .BIST_COLLAR_EN29(BIST_COLLAR_EN29), .BIST_COLLAR_EN30(BIST_COLLAR_EN30), 
 .BIST_COLLAR_EN31(BIST_COLLAR_EN31), .BIST_RUN_TO_COLLAR0(BIST_RUN_TO_COLLAR0_ts3), 
 .BIST_RUN_TO_COLLAR1(BIST_RUN_TO_COLLAR1_ts3), .BIST_RUN_TO_COLLAR2(BIST_RUN_TO_COLLAR2_ts3), 
 .BIST_RUN_TO_COLLAR3(BIST_RUN_TO_COLLAR3_ts3), .BIST_RUN_TO_COLLAR4(BIST_RUN_TO_COLLAR4_ts2), 
 .BIST_RUN_TO_COLLAR5(BIST_RUN_TO_COLLAR5_ts2), .BIST_RUN_TO_COLLAR6(BIST_RUN_TO_COLLAR6_ts2), 
 .BIST_RUN_TO_COLLAR7(BIST_RUN_TO_COLLAR7_ts2), .BIST_RUN_TO_COLLAR8(BIST_RUN_TO_COLLAR8_ts2), 
 .BIST_RUN_TO_COLLAR9(BIST_RUN_TO_COLLAR9_ts2), .BIST_RUN_TO_COLLAR10(BIST_RUN_TO_COLLAR10_ts2), 
 .BIST_RUN_TO_COLLAR11(BIST_RUN_TO_COLLAR11_ts2), .BIST_RUN_TO_COLLAR12(BIST_RUN_TO_COLLAR12_ts2), 
 .BIST_RUN_TO_COLLAR13(BIST_RUN_TO_COLLAR13_ts2), .BIST_RUN_TO_COLLAR14(BIST_RUN_TO_COLLAR14_ts2), 
 .BIST_RUN_TO_COLLAR15(BIST_RUN_TO_COLLAR15_ts2), .BIST_RUN_TO_COLLAR16(BIST_RUN_TO_COLLAR16_ts1), 
 .BIST_RUN_TO_COLLAR17(BIST_RUN_TO_COLLAR17_ts1), .BIST_RUN_TO_COLLAR18(BIST_RUN_TO_COLLAR18_ts1), 
 .BIST_RUN_TO_COLLAR19(BIST_RUN_TO_COLLAR19_ts1), .BIST_RUN_TO_COLLAR20(BIST_RUN_TO_COLLAR20), 
 .BIST_RUN_TO_COLLAR21(BIST_RUN_TO_COLLAR21), .BIST_RUN_TO_COLLAR22(BIST_RUN_TO_COLLAR22), 
 .BIST_RUN_TO_COLLAR23(BIST_RUN_TO_COLLAR23), .BIST_RUN_TO_COLLAR24(BIST_RUN_TO_COLLAR24), 
 .BIST_RUN_TO_COLLAR25(BIST_RUN_TO_COLLAR25), .BIST_RUN_TO_COLLAR26(BIST_RUN_TO_COLLAR26), 
 .BIST_RUN_TO_COLLAR27(BIST_RUN_TO_COLLAR27), .BIST_RUN_TO_COLLAR28(BIST_RUN_TO_COLLAR28), 
 .BIST_RUN_TO_COLLAR29(BIST_RUN_TO_COLLAR29), .BIST_RUN_TO_COLLAR30(BIST_RUN_TO_COLLAR30), 
 .BIST_RUN_TO_COLLAR31(BIST_RUN_TO_COLLAR31), .BIST_ASYNC_RESET(BIST_ASYNC_RESET), 
 .BIST_TESTDATA_SELECT_TO_COLLAR(BIST_TESTDATA_SELECT_TO_COLLAR_ts3), 
 .BIST_ON_TO_COLLAR(BIST_ON_TO_COLLAR_ts3), .BIST_WRITE_DATA(BIST_WRITE_DATA_ts3[0]), 
 .BIST_WRITE_DATA_ts1(BIST_WRITE_DATA_ts3[1]), .BIST_WRITE_DATA_ts2(BIST_WRITE_DATA_ts3[2]), 
 .BIST_WRITE_DATA_ts3(BIST_WRITE_DATA_ts3[3]), .BIST_WRITE_DATA_ts4(BIST_WRITE_DATA_ts3[4]), 
 .BIST_WRITE_DATA_ts5(BIST_WRITE_DATA_ts3[5]), .BIST_WRITE_DATA_ts6(BIST_WRITE_DATA_ts3[6]), 
 .BIST_WRITE_DATA_ts7(BIST_WRITE_DATA_ts3[7]), .BIST_WRITE_DATA_ts8(BIST_WRITE_DATA_ts3[8]), 
 .BIST_WRITE_DATA_ts9(BIST_WRITE_DATA_ts3[9]), .BIST_WRITE_DATA_ts10(BIST_WRITE_DATA_ts3[10]), 
 .BIST_WRITE_DATA_ts11(BIST_WRITE_DATA_ts3[11]), .BIST_WRITE_DATA_ts12(BIST_WRITE_DATA_ts3[12]), 
 .BIST_WRITE_DATA_ts13(BIST_WRITE_DATA_ts3[13]), .BIST_WRITE_DATA_ts14(BIST_WRITE_DATA_ts3[14]), 
 .BIST_WRITE_DATA_ts15(BIST_WRITE_DATA_ts3[15]), .BIST_WRITE_DATA_ts16(BIST_WRITE_DATA_ts3[16]), 
 .BIST_WRITE_DATA_ts17(BIST_WRITE_DATA_ts3[17]), .BIST_WRITE_DATA_ts18(BIST_WRITE_DATA_ts3[18]), 
 .BIST_WRITE_DATA_ts19(BIST_WRITE_DATA_ts3[19]), .BIST_WRITE_DATA_ts20(BIST_WRITE_DATA_ts3[20]), 
 .BIST_WRITE_DATA_ts21(BIST_WRITE_DATA_ts3[21]), .BIST_WRITE_DATA_ts22(BIST_WRITE_DATA_ts3[22]), 
 .BIST_WRITE_DATA_ts23(BIST_WRITE_DATA_ts3[23]), .BIST_WRITE_DATA_ts24(BIST_WRITE_DATA_ts3[24]), 
 .BIST_WRITE_DATA_ts25(BIST_WRITE_DATA_ts3[25]), .BIST_WRITE_DATA_ts26(BIST_WRITE_DATA_ts3[26]), 
 .BIST_WRITE_DATA_ts27(BIST_WRITE_DATA_ts3[27]), .BIST_WRITE_DATA_ts28(BIST_WRITE_DATA_ts3[28]), 
 .BIST_WRITE_DATA_ts29(BIST_WRITE_DATA_ts3[29]), .BIST_WRITE_DATA_ts30(BIST_WRITE_DATA_ts3[30]), 
 .BIST_WRITE_DATA_ts31(BIST_WRITE_DATA_ts3[31]), .BIST_EXPECT_DATA(BIST_EXPECT_DATA_ts3[0]), 
 .BIST_EXPECT_DATA_ts1(BIST_EXPECT_DATA_ts3[1]), .BIST_EXPECT_DATA_ts2(BIST_EXPECT_DATA_ts3[2]), 
 .BIST_EXPECT_DATA_ts3(BIST_EXPECT_DATA_ts3[3]), .BIST_EXPECT_DATA_ts4(BIST_EXPECT_DATA_ts3[4]), 
 .BIST_EXPECT_DATA_ts5(BIST_EXPECT_DATA_ts3[5]), .BIST_EXPECT_DATA_ts6(BIST_EXPECT_DATA_ts3[6]), 
 .BIST_EXPECT_DATA_ts7(BIST_EXPECT_DATA_ts3[7]), .BIST_EXPECT_DATA_ts8(BIST_EXPECT_DATA_ts3[8]), 
 .BIST_EXPECT_DATA_ts9(BIST_EXPECT_DATA_ts3[9]), .BIST_EXPECT_DATA_ts10(BIST_EXPECT_DATA_ts3[10]), 
 .BIST_EXPECT_DATA_ts11(BIST_EXPECT_DATA_ts3[11]), .BIST_EXPECT_DATA_ts12(BIST_EXPECT_DATA_ts3[12]), 
 .BIST_EXPECT_DATA_ts13(BIST_EXPECT_DATA_ts3[13]), .BIST_EXPECT_DATA_ts14(BIST_EXPECT_DATA_ts3[14]), 
 .BIST_EXPECT_DATA_ts15(BIST_EXPECT_DATA_ts3[15]), .BIST_EXPECT_DATA_ts16(BIST_EXPECT_DATA_ts3[16]), 
 .BIST_EXPECT_DATA_ts17(BIST_EXPECT_DATA_ts3[17]), .BIST_EXPECT_DATA_ts18(BIST_EXPECT_DATA_ts3[18]), 
 .BIST_EXPECT_DATA_ts19(BIST_EXPECT_DATA_ts3[19]), .BIST_EXPECT_DATA_ts20(BIST_EXPECT_DATA_ts3[20]), 
 .BIST_EXPECT_DATA_ts21(BIST_EXPECT_DATA_ts3[21]), .BIST_EXPECT_DATA_ts22(BIST_EXPECT_DATA_ts3[22]), 
 .BIST_EXPECT_DATA_ts23(BIST_EXPECT_DATA_ts3[23]), .BIST_EXPECT_DATA_ts24(BIST_EXPECT_DATA_ts3[24]), 
 .BIST_EXPECT_DATA_ts25(BIST_EXPECT_DATA_ts3[25]), .BIST_EXPECT_DATA_ts26(BIST_EXPECT_DATA_ts3[26]), 
 .BIST_EXPECT_DATA_ts27(BIST_EXPECT_DATA_ts3[27]), .BIST_EXPECT_DATA_ts28(BIST_EXPECT_DATA_ts3[28]), 
 .BIST_EXPECT_DATA_ts29(BIST_EXPECT_DATA_ts3[29]), .BIST_EXPECT_DATA_ts30(BIST_EXPECT_DATA_ts3[30]), 
 .BIST_EXPECT_DATA_ts31(BIST_EXPECT_DATA_ts3[31]), .BIST_SHIFT_COLLAR(BIST_SHIFT_COLLAR_ts3), 
 .BIST_COLLAR_SETUP(BIST_COLLAR_SETUP_ts3), .BIST_CLEAR_DEFAULT(BIST_CLEAR_DEFAULT_ts3), 
 .BIST_CLEAR(BIST_CLEAR_ts3), .BIST_COLLAR_OPSET_SELECT(BIST_COLLAR_OPSET_SELECT_ts3[0]), 
 .BIST_COLLAR_OPSET_SELECT_ts1(BIST_COLLAR_OPSET_SELECT_ts3[1]), 
 .BIST_COLLAR_HOLD(BIST_COLLAR_HOLD_ts3), .FREEZE_STOP_ERROR(FREEZE_STOP_ERROR_ts3), 
 .ERROR_CNT_ZERO(ERROR_CNT_ZERO_ts3), .MBISTPG_RESET_REG_SETUP2(MBISTPG_RESET_REG_SETUP2_ts3), 
 .BIST_BANK_ADD(BIST_BANK_ADD_ts1[0]), .BIST_BANK_ADD_ts1(BIST_BANK_ADD_ts1[1]), 
 .BIST_BANK_ADD_ts2(BIST_BANK_ADD_ts1[2]), .bisr_shift_en_pd_vinf(bisr_shift_en_pd_vinf), 
 .bisr_clk_pd_vinf(bisr_clk_pd_vinf), .bisr_reset_pd_vinf(bisr_reset_pd_vinf), 
 .ram_row_0_col_0_bisr_inst_SO(ram_row_0_col_0_bisr_inst_SO), 
 .tcam_row_0_col_0_bisr_inst_SO(bisr_so_pd_vinf)); // Templated

/*
 hlp_fgrp_apr_func_logic AUTO_TEMPLATE
 ( .i_frm_ffu_tcam (nm_frm_ffu_tcam[][]),
   .o_tom_ffu_tcam (nm_tom_ffu_tcam[][]),
   .o_tom_\(.*\) (tom_\1[][]),
   .i_frm_\(.*\) (frm_\1[][]),
   .i_broadcast  (local_broadcast) );
*/
hlp_fgrp_apr_func_logic u_fgrp_apr_func_logic
(
`ifndef __VISA_IT__
`ifndef INTEL_GLOBAL_VISA_DISABLE

(* inserted_by="VISA IT" *) .visaRt_cfg_rd_bus_out_from_u_fgrp_apr_func_logic_visa_unit_mux_regout_0({visaSerCfgRd_fgrp_ngvisa_top_junc[0][1:0]}),
(* inserted_by="VISA IT" *) .visaRt_cfg_rd_bus_out_from_u_fgrp_apr_func_logic_visa_unit_mux_regout_1({visaSerCfgRd_fgrp_ngvisa_top_junc[1][1:0]}),
(* inserted_by="VISA IT" *) .visaRt_cfg_wr_bus_in_to_parhlpfgrp_1_fgrp_apr_fgrp_ngvisa_top_junc(visaRt_cfg_wr_bus_in_from_parhlpfgrp_0_fgrp_apr_fgrp_ngvisa_top_junc),
(* inserted_by="VISA IT" *) .visaRt_clk_from_u_fgrp_apr_func_logic(visaRt_clk_from_u_fgrp_apr_func_logic),
(* inserted_by="VISA IT" *) .visaRt_enable_from_u_fgrp_apr_func_logic(visaRt_enable_from_u_fgrp_apr_func_logic),
(* inserted_by="VISA IT" *) .visaRt_fscan_byprst_b_to_fgrp_ngvisa_top_junc(fscan_byprst_b),
(* inserted_by="VISA IT" *) .visaRt_fscan_clkungate_to_fgrp_ngvisa_top_junc(fscan_clkungate),
(* inserted_by="VISA IT" *) .visaRt_fscan_rstbypen_to_fgrp_ngvisa_top_junc(fscan_rstbypen),
(* inserted_by="VISA IT" *) .visaRt_lane_out_from_u_fgrp_apr_func_logic_visa_unit_mux_regout_0({visaLaneIn_fgrp_ngvisa_top_junc[1:0]}),
(* inserted_by="VISA IT" *) .visaRt_lane_out_from_u_fgrp_apr_func_logic_visa_unit_mux_regout_1({visaLaneIn_fgrp_ngvisa_top_junc[3:2]}),
(* inserted_by="VISA IT" *) .visaRt_lane_valid_out_from_u_fgrp_apr_func_logic_visa_unit_mux_regout_0(visaLaneValidIn_fgrp_ngvisa_top_junc_2[1:0]),
(* inserted_by="VISA IT" *) .visaRt_lane_valid_out_from_u_fgrp_apr_func_logic_visa_unit_mux_regout_1(visaLaneValidIn_fgrp_ngvisa_top_junc_2[3:2]),
(* inserted_by="VISA IT" *) .visaRt_resetb_from_u_fgrp_apr_func_logic(visaRt_resetb_from_u_fgrp_apr_func_logic),
(* inserted_by="VISA IT" *) .visaRt_unit_id_to_parhlpffu_parhlpfgrp_0_fgrp_apr_u_fgrp_apr_func_logic_visa_unit_mux_regout_0(visaRt_unit_id_to_parhlpffu_parhlpfgrp_0_fgrp_apr_u_fgrp_apr_func_logic_visa_unit_mux_regout_0),
(* inserted_by="VISA IT" *) .visaRt_unit_id_to_parhlpffu_parhlpfgrp_0_fgrp_apr_u_fgrp_apr_func_logic_visa_unit_mux_regout_1(visaRt_unit_id_to_parhlpffu_parhlpfgrp_0_fgrp_apr_u_fgrp_apr_func_logic_visa_unit_mux_regout_1),


`endif // INTEL_GLOBAL_VISA_DISABLE
`endif // __VISA_IT__
 // Auto Included by VISA IT - *** Do not modify this line ***
 .fet_ack_b (fet_ack_b_to_sram),
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
 .ascan_sdo                             (ascan_sdo[hlp_dfx_pkg::FGRP_NUM_SDO-1:0]),
 .o_fghash_ecc_int                      (o_fghash_ecc_int),
 .o_fgrp_ecc_int                        (o_fgrp_ecc_int),
 .o_grp                                 (o_grp),
 .o_grp_v                               (o_grp_v),
 .o_mem_init_done                       (o_mem_init_done),
 .o_mgmt                                (o_mgmt),
 .o_mgmt_v                              (o_mgmt_v),
 .o_ptr                                 (o_ptr[1:0]),
 .o_ptr_v                               (o_ptr_v[1:0]),
 .o_tom_ffu_action                      (tom_ffu_action/*[hlp_pkg::N_FFU_GROUP_ARAMS-1:0][`HLP_FGRP_FFU_ACTION_TO_MEM_WIDTH-1:0]*/), // Templated
 .o_tom_ffu_hash_cfg                    (tom_ffu_hash_cfg[`HLP_FGHASH_FFU_HASH_CFG_TO_MEM_WIDTH-1:0]), // Templated
 .o_tom_ffu_hash_lookup                 (tom_ffu_hash_lookup/*[1:0][`HLP_FGHASH_FFU_HASH_LOOKUP_TO_MEM_WIDTH-1:0]*/), // Templated
 .o_tom_ffu_hash_miss                   (tom_ffu_hash_miss/*[1:0][`HLP_FGHASH_FFU_HASH_MISS_TO_MEM_WIDTH-1:0]*/), // Templated
 .o_tom_ffu_key_mask0                   (tom_ffu_key_mask0/*[1:0][`HLP_FGHASH_FFU_KEY_MASK0_TO_MEM_WIDTH-1:0]*/), // Templated
 .o_tom_ffu_key_mask1                   (tom_ffu_key_mask1/*[1:0][`HLP_FGHASH_FFU_KEY_MASK1_TO_MEM_WIDTH-1:0]*/), // Templated
 .o_tom_ffu_key_mask2                   (tom_ffu_key_mask2/*[1:0][`HLP_FGHASH_FFU_KEY_MASK2_TO_MEM_WIDTH-1:0]*/), // Templated
 .o_tom_ffu_key_mask3                   (tom_ffu_key_mask3/*[1:0][`HLP_FGHASH_FFU_KEY_MASK3_TO_MEM_WIDTH-1:0]*/), // Templated
 .o_tom_ffu_key_mask4                   (tom_ffu_key_mask4/*[1:0][`HLP_FGHASH_FFU_KEY_MASK4_TO_MEM_WIDTH-1:0]*/), // Templated
 .o_tom_ffu_tcam                        (nm_tom_ffu_tcam/*[hlp_pkg::N_FFU_GROUP_SLICES-1:0][hlp_pkg::N_FFU_GROUP_TPS-1:0][`HLP_FGRP_FFU_TCAM_TO_TCAM_WIDTH-1:0]*/), // Templated
 .o_tom_ffu_tcam_cfg                    (tom_ffu_tcam_cfg/*[hlp_pkg::N_FFU_GROUP_SLICES-1:0][`HLP_FGRP_FFU_TCAM_CFG_TO_MEM_WIDTH-1:0]*/), // Templated
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
 .fscan_clkgenctrl                      (fscan_clkgenctrl[hlp_dfx_pkg::FGRP_NUM_CLKGENCTRL-1:0]),
 .fscan_clkgenctrlen                    (fscan_clkgenctrlen[hlp_dfx_pkg::FGRP_NUM_CLKGENCTRLEN-1:0]),
 .fscan_sdi                             (fscan_sdi[hlp_dfx_pkg::FGRP_NUM_SDI-1:0]),
 .clk                                   (clk_ts1),
 .fscan_byprst_b                        (fscan_byprst_b),
 .fscan_rstbypen                        (fscan_rstbypen),
 .i_broadcast                           (local_broadcast),       // Templated
 .i_data                                (i_data[1:0]),
 .i_data_v                              (i_data_v[1:0]),
 .i_fgrp_visa_enable                    (i_fgrp_visa_enable),
 .i_frm_ffu_action                      (frm_ffu_action/*[hlp_pkg::N_FFU_GROUP_ARAMS-1:0][`HLP_FGRP_FFU_ACTION_FROM_MEM_WIDTH-1:0]*/), // Templated
 .i_frm_ffu_hash_cfg                    (frm_ffu_hash_cfg[`HLP_FGHASH_FFU_HASH_CFG_FROM_MEM_WIDTH-1:0]), // Templated
 .i_frm_ffu_hash_lookup                 (frm_ffu_hash_lookup/*[1:0][`HLP_FGHASH_FFU_HASH_LOOKUP_FROM_MEM_WIDTH-1:0]*/), // Templated
 .i_frm_ffu_hash_miss                   (frm_ffu_hash_miss/*[1:0][`HLP_FGHASH_FFU_HASH_MISS_FROM_MEM_WIDTH-1:0]*/), // Templated
 .i_frm_ffu_key_mask0                   (frm_ffu_key_mask0/*[1:0][`HLP_FGHASH_FFU_KEY_MASK0_FROM_MEM_WIDTH-1:0]*/), // Templated
 .i_frm_ffu_key_mask1                   (frm_ffu_key_mask1/*[1:0][`HLP_FGHASH_FFU_KEY_MASK1_FROM_MEM_WIDTH-1:0]*/), // Templated
 .i_frm_ffu_key_mask2                   (frm_ffu_key_mask2/*[1:0][`HLP_FGHASH_FFU_KEY_MASK2_FROM_MEM_WIDTH-1:0]*/), // Templated
 .i_frm_ffu_key_mask3                   (frm_ffu_key_mask3/*[1:0][`HLP_FGHASH_FFU_KEY_MASK3_FROM_MEM_WIDTH-1:0]*/), // Templated
 .i_frm_ffu_key_mask4                   (frm_ffu_key_mask4/*[1:0][`HLP_FGHASH_FFU_KEY_MASK4_FROM_MEM_WIDTH-1:0]*/), // Templated
 .i_frm_ffu_tcam                        (nm_frm_ffu_tcam/*[hlp_pkg::N_FFU_GROUP_SLICES-1:0][hlp_pkg::N_FFU_GROUP_TPS-1:0][`HLP_FGRP_FFU_TCAM_FROM_TCAM_WIDTH-1:0]*/), // Templated
 .i_frm_ffu_tcam_cfg                    (frm_ffu_tcam_cfg/*[hlp_pkg::N_FFU_GROUP_SLICES-1:0][`HLP_FGRP_FFU_TCAM_CFG_FROM_MEM_WIDTH-1:0]*/), // Templated
 .i_grp                                 (i_grp),
 .i_grp_nr                              (i_grp_nr),
 .i_grp_v                               (i_grp_v),
 .i_mgmt                                (i_mgmt),
 .i_mgmt_v                              (i_mgmt_v),
 .rst_n                                 (local_rst_n));



`include "hlp_fgrp_apr.VISA_IT.hlp_fgrp_apr.logic.sv" // Auto Included by VISA IT - *** Do not modify this line ***

  hlp_fgrp_apr_rtl_tessent_sib_1 hlp_fgrp_apr_rtl_tessent_sib_sti_inst(
      .ijtag_reset(fary_ijtag_rst_b), .ijtag_sel(fary_ijtag_select), .ijtag_si(fary_ijtag_si), 
      .ijtag_ce(fary_ijtag_capture), .ijtag_se(fary_ijtag_shift), .ijtag_ue(fary_ijtag_update), 
      .ijtag_tck(fary_ijtag_tck), .ijtag_so(hlp_fgrp_apr_rtl_tessent_sib_sti_inst_so), 
      .ijtag_from_so(hlp_fgrp_apr_rtl_tessent_sib_mbist_inst_so), .ltest_si(1'b0), 
      .ltest_scan_en(DFTSHIFTEN), .ltest_en(fscan_mode), .ltest_clk(clk_rscclk), 
      .ltest_mem_bypass_en(DFTMASK), .ltest_mcp_bounding_en(fscan_ram_init_en), 
      .ltest_async_set_reset_static_disable(fscan_byprst_b), .ijtag_to_tck(ijtag_to_tck), 
      .ijtag_to_reset(ijtag_to_reset), .ijtag_to_si(hlp_fgrp_apr_rtl_tessent_sib_sti_inst_so_ts1), 
      .ijtag_to_ce(ijtag_to_ce), .ijtag_to_se(ijtag_to_se), .ijtag_to_ue(ijtag_to_ue), 
      .ltest_so(), .ltest_to_en(ltest_to_en), .ltest_to_mem_bypass_en(ltest_to_mem_bypass_en), 
      .ltest_to_mcp_bounding_en(ltest_to_mcp_bounding_en), .ltest_to_scan_en(ltest_to_scan_en), 
      .ijtag_to_sel(hlp_fgrp_apr_rtl_tessent_sib_sti_inst_to_select)
  );

  hlp_fgrp_apr_rtl_tessent_sib_2 hlp_fgrp_apr_rtl_tessent_sib_sri_inst(
      .ijtag_reset(fary_ijtag_rst_b), .ijtag_sel(fary_ijtag_select), .ijtag_si(hlp_fgrp_apr_rtl_tessent_sib_sti_inst_so), 
      .ijtag_ce(fary_ijtag_capture), .ijtag_se(fary_ijtag_shift), .ijtag_ue(fary_ijtag_update), 
      .ijtag_tck(fary_ijtag_tck), .ijtag_so(aary_ijtag_so), .ijtag_from_so(hlp_fgrp_apr_rtl_tessent_sib_sri_ctrl_inst_so), 
      .ijtag_to_sel(hlp_fgrp_apr_rtl_tessent_sib_sri_inst_to_select)
  );

  hlp_fgrp_apr_rtl_tessent_sib_3 hlp_fgrp_apr_rtl_tessent_sib_sri_ctrl_inst(
      .ijtag_reset(fary_ijtag_rst_b), .ijtag_sel(hlp_fgrp_apr_rtl_tessent_sib_sri_inst_to_select), 
      .ijtag_si(hlp_fgrp_apr_rtl_tessent_sib_sti_inst_so), .ijtag_ce(fary_ijtag_capture), 
      .ijtag_se(fary_ijtag_shift), .ijtag_ue(fary_ijtag_update), .ijtag_tck(fary_ijtag_tck), 
      .ijtag_so(hlp_fgrp_apr_rtl_tessent_sib_sri_ctrl_inst_so), .ijtag_from_so(hlp_fgrp_apr_rtl_tessent_tdr_sri_ctrl_inst_so), 
      .ijtag_to_sel(hlp_fgrp_apr_rtl_tessent_sib_sri_ctrl_inst_to_select)
  );

  hlp_fgrp_apr_rtl_tessent_tdr_sri_ctrl hlp_fgrp_apr_rtl_tessent_tdr_sri_ctrl_inst(
      .ijtag_reset(fary_ijtag_rst_b), .ijtag_sel(hlp_fgrp_apr_rtl_tessent_sib_sri_ctrl_inst_to_select), 
      .ijtag_si(hlp_fgrp_apr_rtl_tessent_sib_sti_inst_so), .ijtag_ce(fary_ijtag_capture), 
      .ijtag_se(fary_ijtag_shift), .ijtag_ue(fary_ijtag_update), .ijtag_tck(fary_ijtag_tck), 
      .tck_select(tck_select), .all_test(), .ijtag_so(hlp_fgrp_apr_rtl_tessent_tdr_sri_ctrl_inst_so)
  );

  hlp_fgrp_apr_rtl_tessent_sib_4 hlp_fgrp_apr_rtl_tessent_sib_algo_select_sib_inst(
      .ijtag_reset(ijtag_to_reset), .ijtag_sel(hlp_fgrp_apr_rtl_tessent_sib_sti_inst_to_select), 
      .ijtag_si(hlp_fgrp_apr_rtl_tessent_sib_sti_inst_so_ts1), .ijtag_ce(ijtag_to_ce), 
      .ijtag_se(ijtag_to_se), .ijtag_ue(ijtag_to_ue), .ijtag_tck(ijtag_to_tck), 
      .ijtag_so(hlp_fgrp_apr_rtl_tessent_sib_algo_select_sib_inst_so), .ijtag_from_so(hlp_fgrp_apr_rtl_tessent_tdr_RF_c1_algo_select_tdr_inst_so), 
      .ijtag_to_sel(hlp_fgrp_apr_rtl_tessent_sib_algo_select_sib_inst_to_select)
  );

  hlp_fgrp_apr_rtl_tessent_sib_4 hlp_fgrp_apr_rtl_tessent_sib_mbist_inst(
      .ijtag_reset(ijtag_to_reset), .ijtag_sel(hlp_fgrp_apr_rtl_tessent_sib_sti_inst_to_select), 
      .ijtag_si(hlp_fgrp_apr_rtl_tessent_sib_algo_select_sib_inst_so), .ijtag_ce(ijtag_to_ce), 
      .ijtag_se(ijtag_to_se), .ijtag_ue(ijtag_to_ue), .ijtag_tck(ijtag_to_tck), 
      .ijtag_so(hlp_fgrp_apr_rtl_tessent_sib_mbist_inst_so), .ijtag_from_so(ijtag_so), 
      .ijtag_to_sel(ijtag_to_sel)
  );

  hlp_fgrp_apr_rtl_tessent_tdr_TCAM_c4_algo_select_tdr hlp_fgrp_apr_rtl_tessent_tdr_TCAM_c4_algo_select_tdr_inst(
      .ijtag_reset(ijtag_to_reset), .ijtag_sel(hlp_fgrp_apr_rtl_tessent_sib_algo_select_sib_inst_to_select), 
      .ijtag_si(hlp_fgrp_apr_rtl_tessent_sib_sti_inst_so_ts1), .ijtag_ce(ijtag_to_ce), 
      .ijtag_se(ijtag_to_se), .ijtag_ue(ijtag_to_ue), .ijtag_tck(ijtag_to_tck), 
      .ALGO_SEL_REG(ALGO_SEL_REG_ts3), .ijtag_so(hlp_fgrp_apr_rtl_tessent_tdr_TCAM_c4_algo_select_tdr_inst_so)
  );

  hlp_fgrp_apr_rtl_tessent_tdr_SRAM_c3_algo_select_tdr hlp_fgrp_apr_rtl_tessent_tdr_SRAM_c3_algo_select_tdr_inst(
      .ijtag_reset(ijtag_to_reset), .ijtag_sel(hlp_fgrp_apr_rtl_tessent_sib_algo_select_sib_inst_to_select), 
      .ijtag_si(hlp_fgrp_apr_rtl_tessent_tdr_TCAM_c4_algo_select_tdr_inst_so), 
      .ijtag_ce(ijtag_to_ce), .ijtag_se(ijtag_to_se), .ijtag_ue(ijtag_to_ue), .ijtag_tck(ijtag_to_tck), 
      .ALGO_SEL_REG(ALGO_SEL_REG_ts2), .ijtag_so(hlp_fgrp_apr_rtl_tessent_tdr_SRAM_c3_algo_select_tdr_inst_so)
  );

  hlp_fgrp_apr_rtl_tessent_tdr_SRAM_c2_algo_select_tdr hlp_fgrp_apr_rtl_tessent_tdr_SRAM_c2_algo_select_tdr_inst(
      .ijtag_reset(ijtag_to_reset), .ijtag_sel(hlp_fgrp_apr_rtl_tessent_sib_algo_select_sib_inst_to_select), 
      .ijtag_si(hlp_fgrp_apr_rtl_tessent_tdr_SRAM_c3_algo_select_tdr_inst_so), 
      .ijtag_ce(ijtag_to_ce), .ijtag_se(ijtag_to_se), .ijtag_ue(ijtag_to_ue), .ijtag_tck(ijtag_to_tck), 
      .ALGO_SEL_REG(ALGO_SEL_REG_ts1), .ijtag_so(hlp_fgrp_apr_rtl_tessent_tdr_SRAM_c2_algo_select_tdr_inst_so)
  );

  hlp_fgrp_apr_rtl_tessent_tdr_RF_c1_algo_select_tdr hlp_fgrp_apr_rtl_tessent_tdr_RF_c1_algo_select_tdr_inst(
      .ijtag_reset(ijtag_to_reset), .ijtag_sel(hlp_fgrp_apr_rtl_tessent_sib_algo_select_sib_inst_to_select), 
      .ijtag_si(hlp_fgrp_apr_rtl_tessent_tdr_SRAM_c2_algo_select_tdr_inst_so), 
      .ijtag_ce(ijtag_to_ce), .ijtag_se(ijtag_to_se), .ijtag_ue(ijtag_to_ue), .ijtag_tck(ijtag_to_tck), 
      .ALGO_SEL_REG(ALGO_SEL_REG), .ijtag_so(hlp_fgrp_apr_rtl_tessent_tdr_RF_c1_algo_select_tdr_inst_so)
  );

  hlp_fgrp_apr_rtl_tessent_mbist_bap hlp_fgrp_apr_rtl_tessent_mbist_bap_inst(
      .reset(ijtag_to_reset), .ijtag_select(ijtag_to_sel), .si(hlp_fgrp_apr_rtl_tessent_sib_algo_select_sib_inst_so), 
      .capture_en(ijtag_to_ce), .shift_en(ijtag_to_se), .shift_en_R(), .update_en(ijtag_to_ue), 
      .tck(ijtag_to_tck), .to_interfaces_tck(to_interfaces_tck), .to_controllers_tck_retime(to_controllers_tck_retime), 
      .to_controllers_tck(to_controllers_tck), .mcp_bounding_en(ltest_to_mcp_bounding_en), 
      .mcp_bounding_to_en(mcp_bounding_to_en), .scan_en(ltest_to_scan_en), .scan_to_en(scan_to_en), 
      .memory_bypass_en(ltest_to_mem_bypass_en), .memory_bypass_to_en(memory_bypass_to_en), 
      .ltest_en(ltest_to_en), .ltest_to_en(ltest_to_en_ts1), .BIST_HOLD(BIST_HOLD), 
      .sys_ctrl_select({select_sram, select_sram, select_sram, select_rf}), .sys_algo_select(mbistpg_algo_sel_o[6:0]), 
      .sys_select_common_algo(mbistpg_select_common_algo_o), .sys_test_start_clk(trigger_post), 
      .sys_test_init_clk(1'b0), .sys_reset_clk(sync_reset_clk_o), .sys_clock_clk(clk_ts1), 
      .sys_test_pass_clk(sys_test_pass_clk), .sys_test_done_clk(sys_test_done_clk), 
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
      .MBISTPG_GO({MBISTPG_GO_ts3, MBISTPG_GO_ts2, MBISTPG_GO_ts1, 
      MBISTPG_GO}), .MBISTPG_DONE({MBISTPG_DONE_ts3, MBISTPG_DONE_ts2, 
      MBISTPG_DONE_ts1, MBISTPG_DONE}), .bistEn(bistEn[3:0]), .toBist(toBist[3:0]), 
      .fromBist({MBISTPG_SO_ts3, MBISTPG_SO_ts2, MBISTPG_SO_ts1, MBISTPG_SO}), 
      .so(hlp_fgrp_apr_rtl_tessent_mbist_bap_inst_so), .fscan_clkungate(fscan_clkungate)
  );

  hlp_fgrp_apr_rtl_tessent_mbist_RF_c1_controller hlp_fgrp_apr_rtl_tessent_mbist_RF_c1_controller_inst(
      .MBIST_RA_PRSRV_FUSE_VAL(PRESERVE_FUSE_REGISTER), .MBISTPG_ALGO_SEL({
      BIST_ALGO_SEL_ts6, BIST_ALGO_SEL_ts5, BIST_ALGO_SEL_ts4, 
      BIST_ALGO_SEL_ts3, BIST_ALGO_SEL_ts2, BIST_ALGO_SEL_ts1, BIST_ALGO_SEL}), .MBISTPG_SELECT_COMMON_ALGO(BIST_SELECT_COMMON_ALGO), 
      .MBISTPG_OPSET_SELECT(BIST_OPSET_SEL), .MBISTPG_SELECT_COMMON_OPSET(BIST_SELECT_COMMON_OPSET), 
      .MBISTPG_DATA_INV_ROW_ADD_BIT_SELECT_EN(BIST_DATA_INV_ROW_ADD_BIT_SELECT_EN), 
      .MBISTPG_DATA_INV_ROW_ADD_BIT_SELECT(BIST_DATA_INV_ROW_ADD_BIT_SEL), .MBISTPG_DATA_INV_COL_ADD_BIT_SELECT_EN(BIST_DATA_INV_COL_ADD_BIT_SELECT_EN), 
      .MBISTPG_DATA_INV_COL_ADD_BIT_SELECT(BIST_DATA_INV_COL_ADD_BIT_SEL), .MBISTPG_ALGO_MODE({
      BIST_ALGO_MODE1, BIST_ALGO_MODE0}), .MBISTPG_MEM_RST(ENABLE_MEM_RESET), .MBISTPG_REDUCED_ADDR_CNT_EN(REDUCED_ADDRESS_COUNT), 
      .MEM_BYPASS_EN(memory_bypass_to_en), .MCP_BOUNDING_EN(mcp_bounding_to_en), 
      .MEM0_BIST_COLLAR_SO(BIST_SO_ts22), .MEM1_BIST_COLLAR_SO(BIST_SO_ts23), .MEM2_BIST_COLLAR_SO(BIST_SO_ts24), 
      .MEM3_BIST_COLLAR_SO(BIST_SO_ts25), .MEM4_BIST_COLLAR_SO(BIST_SO_ts26), .MEM5_BIST_COLLAR_SO(BIST_SO_ts27), 
      .MEM6_BIST_COLLAR_SO(BIST_SO_ts28), .MEM7_BIST_COLLAR_SO(BIST_SO_ts29), .MEM8_BIST_COLLAR_SO(BIST_SO_ts30), 
      .MEM9_BIST_COLLAR_SO(BIST_SO_ts31), .MEM10_BIST_COLLAR_SO(BIST_SO_ts32), 
      .MEM11_BIST_COLLAR_SO(BIST_SO_ts33), .MEM12_BIST_COLLAR_SO(BIST_SO_ts34), 
      .MEM13_BIST_COLLAR_SO(BIST_SO_ts35), .MEM14_BIST_COLLAR_SO(BIST_SO_ts36), 
      .MEM15_BIST_COLLAR_SO(BIST_SO_ts37), .FL_CNT_MODE({FL_CNT_MODE1, 
      FL_CNT_MODE0}), .MBISTPG_BIRA_EN(BIRA_EN), .CHECK_REPAIR_NEEDED(CHECK_REPAIR_NEEDED), 
      .BIST_COLLAR_GO({BIST_GO_ts37, BIST_GO_ts36, BIST_GO_ts35, 
      BIST_GO_ts34, BIST_GO_ts33, BIST_GO_ts32, BIST_GO_ts31, BIST_GO_ts30, 
      BIST_GO_ts29, BIST_GO_ts28, BIST_GO_ts27, BIST_GO_ts26, BIST_GO_ts25, 
      BIST_GO_ts24, BIST_GO_ts23, BIST_GO_ts22}), .MBISTPG_DIAG_EN(BIST_DIAG_EN), 
      .BIST_CLK(clk_ts1), .BIST_SI(toBist[0]), .BIST_HOLD(BIST_HOLD), .BIST_SETUP2(BIST_SETUP_ts3), 
      .BIST_SETUP({BIST_SETUP_ts2, BIST_SETUP_ts1}), .MBISTPG_TESTDATA_SELECT(BIST_SELECT_TEST_DATA), 
      .TCK(to_controllers_tck), .TCK_RETIME(to_controllers_tck_retime), .MBISTPG_EN(bistEn[0]), 
      .MBISTPG_ASYNC_RESETN(BIST_ASYNC_RESET), .LV_TM(ltest_to_en_ts1), .MBISTPG_MEM_ARRAY_DUMP_MODE(MEM_ARRAY_DUMP_MODE), 
      .BIST_CLEAR_BIRA(BIST_CLEAR_BIRA), .MBISTPG_RESET_REG_SETUP2(MBISTPG_RESET_REG_SETUP2), 
      .BIST_COL_ADD(BIST_COL_ADD), .BIST_ROW_ADD(BIST_ROW_ADD[4:0]), .BIST_WRITE_DATA(BIST_WRITE_DATA[7:0]), 
      .BIST_EXPECT_DATA(BIST_EXPECT_DATA[7:0]), .BIST_SHIFT_COLLAR(BIST_SHIFT_COLLAR), 
      .BIST_TESTDATA_SELECT_TO_COLLAR(BIST_TESTDATA_SELECT_TO_COLLAR), .MEM0_BIST_COLLAR_SI(MEM0_BIST_COLLAR_SI), 
      .MEM1_BIST_COLLAR_SI(MEM1_BIST_COLLAR_SI), .MEM2_BIST_COLLAR_SI(MEM2_BIST_COLLAR_SI), 
      .MEM3_BIST_COLLAR_SI(MEM3_BIST_COLLAR_SI), .MEM4_BIST_COLLAR_SI(MEM4_BIST_COLLAR_SI), 
      .MEM5_BIST_COLLAR_SI(MEM5_BIST_COLLAR_SI), .MEM6_BIST_COLLAR_SI(MEM6_BIST_COLLAR_SI), 
      .MEM7_BIST_COLLAR_SI(MEM7_BIST_COLLAR_SI), .MEM8_BIST_COLLAR_SI(MEM8_BIST_COLLAR_SI), 
      .MEM9_BIST_COLLAR_SI(MEM9_BIST_COLLAR_SI), .MEM10_BIST_COLLAR_SI(MEM10_BIST_COLLAR_SI), 
      .MEM11_BIST_COLLAR_SI(MEM11_BIST_COLLAR_SI), .MEM12_BIST_COLLAR_SI(MEM12_BIST_COLLAR_SI), 
      .MEM13_BIST_COLLAR_SI(MEM13_BIST_COLLAR_SI), .MEM14_BIST_COLLAR_SI(MEM14_BIST_COLLAR_SI), 
      .MEM15_BIST_COLLAR_SI(MEM15_BIST_COLLAR_SI), .BIST_COLLAR_SETUP(BIST_COLLAR_SETUP), 
      .BIST_COLLAR_OPSET_SELECT(BIST_COLLAR_OPSET_SELECT), .BIST_COLLAR_HOLD(BIST_COLLAR_HOLD), 
      .FREEZE_STOP_ERROR(FREEZE_STOP_ERROR), .ERROR_CNT_ZERO(ERROR_CNT_ZERO), .BIST_COLLAR_DIAG_EN(BIST_COLLAR_DIAG_EN), 
      .BIST_COLLAR_BIRA_EN(BIST_COLLAR_BIRA_EN), .BIST_CLEAR_DEFAULT(BIST_CLEAR_DEFAULT), 
      .BIST_CLEAR(BIST_CLEAR), .MBISTPG_SO(MBISTPG_SO), .PriorityColumn(PriorityColumn), 
      .BIST_CONREAD_ROWADDRESS(BIST_CONREAD_ROWADDRESS), .BIST_CONREAD_COLUMNADDRESS(BIST_CONREAD_COLUMNADDRESS), 
      .BIST_CONREAD_ENABLE(BIST_CONREAD_ENABLE), .BIST_CONWRITE_ROWADDRESS(BIST_CONWRITE_ROWADDRESS), 
      .BIST_CONWRITE_ENABLE(BIST_CONWRITE_ENABLE), .BIST_READENABLE(BIST_READENABLE), 
      .BIST_WRITEENABLE(BIST_WRITEENABLE), .BIST_SHADOW_READENABLE(BIST_SHADOW_READENABLE), 
      .BIST_SHADOW_READADDRESS(BIST_SHADOW_READADDRESS), .BIST_CMP(BIST_CMP), .BIST_COLLAR_EN0(BIST_COLLAR_EN0), 
      .BIST_RUN_TO_COLLAR0(BIST_RUN_TO_COLLAR0), .BIST_COLLAR_EN1(BIST_COLLAR_EN1), 
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
      .BIST_RUN_TO_COLLAR15(BIST_RUN_TO_COLLAR15), .MBISTPG_GO(MBISTPG_GO), .MBISTPG_STABLE(MBISTPG_STABLE), 
      .MBISTPG_DONE(MBISTPG_DONE), .BIST_ON_TO_COLLAR(BIST_ON_TO_COLLAR), .BIST_SHIFT_BIRA_COLLAR(BIST_SHIFT_BIRA_COLLAR), 
      .GO_ID_REG_SEL(GO_ID_REG_SEL), .ALGO_SEL_REG(ALGO_SEL_REG), .fscan_clkungate(fscan_clkungate)
  );

  hlp_fgrp_apr_rtl_tessent_mbist_SRAM_c2_controller hlp_fgrp_apr_rtl_tessent_mbist_SRAM_c2_controller_inst(
      .MBIST_RA_PRSRV_FUSE_VAL(PRESERVE_FUSE_REGISTER), .MBISTPG_ALGO_SEL({
      BIST_ALGO_SEL_ts6, BIST_ALGO_SEL_ts5, BIST_ALGO_SEL_ts4, 
      BIST_ALGO_SEL_ts3, BIST_ALGO_SEL_ts2, BIST_ALGO_SEL_ts1, BIST_ALGO_SEL}), .MBISTPG_SELECT_COMMON_ALGO(BIST_SELECT_COMMON_ALGO), 
      .MBISTPG_OPSET_SELECT(BIST_OPSET_SEL), .MBISTPG_SELECT_COMMON_OPSET(BIST_SELECT_COMMON_OPSET), 
      .MBISTPG_DATA_INV_ROW_ADD_BIT_SELECT_EN(BIST_DATA_INV_ROW_ADD_BIT_SELECT_EN), 
      .MBISTPG_DATA_INV_ROW_ADD_BIT_SELECT(BIST_DATA_INV_ROW_ADD_BIT_SEL), .MBISTPG_DATA_INV_COL_ADD_BIT_SELECT_EN(BIST_DATA_INV_COL_ADD_BIT_SELECT_EN), 
      .MBISTPG_DATA_INV_COL_ADD_BIT_SELECT(BIST_DATA_INV_COL_ADD_BIT_SEL), .MBISTPG_ALGO_MODE({
      BIST_ALGO_MODE1, BIST_ALGO_MODE0}), .MBISTPG_MEM_RST(ENABLE_MEM_RESET), .MBISTPG_REDUCED_ADDR_CNT_EN(REDUCED_ADDRESS_COUNT), 
      .MEM_BYPASS_EN(memory_bypass_to_en), .MCP_BOUNDING_EN(mcp_bounding_to_en), 
      .MEM0_BIST_COLLAR_SO(BIST_SO), .MEM1_BIST_COLLAR_SO(BIST_SO_ts38), .MEM2_BIST_COLLAR_SO(BIST_SO_ts1), 
      .MEM3_BIST_COLLAR_SO(BIST_SO_ts39), .FL_CNT_MODE({FL_CNT_MODE1, 
      FL_CNT_MODE0}), .MBISTPG_BIRA_EN(BIRA_EN), .CHECK_REPAIR_NEEDED(CHECK_REPAIR_NEEDED), 
      .BIST_COLLAR_GO({BIST_GO_ts39, BIST_GO_ts1, BIST_GO_ts38, BIST_GO}), .MBISTPG_DIAG_EN(BIST_DIAG_EN), 
      .BIST_CLK(clk_ts1), .BIST_SI(toBist[1]), .BIST_HOLD(BIST_HOLD), .BIST_SETUP2(BIST_SETUP_ts3), 
      .BIST_SETUP({BIST_SETUP_ts2, BIST_SETUP_ts1}), .MBISTPG_TESTDATA_SELECT(BIST_SELECT_TEST_DATA), 
      .TCK(to_controllers_tck), .TCK_RETIME(to_controllers_tck_retime), .MBISTPG_EN(bistEn[1]), 
      .MBISTPG_ASYNC_RESETN(BIST_ASYNC_RESET), .LV_TM(ltest_to_en_ts1), .MBISTPG_MEM_ARRAY_DUMP_MODE(MEM_ARRAY_DUMP_MODE), 
      .BIST_CLEAR_BIRA(BIST_CLEAR_BIRA_ts1), .MBISTPG_RESET_REG_SETUP2(MBISTPG_RESET_REG_SETUP2_ts1), 
      .BIST_COL_ADD(BIST_COL_ADD_ts1[1:0]), .BIST_ROW_ADD(BIST_ROW_ADD_ts1[6:0]), 
      .BIST_BANK_ADD(BIST_BANK_ADD[1:0]), .BIST_WRITE_DATA(BIST_WRITE_DATA_ts1[31:0]), 
      .BIST_EXPECT_DATA(BIST_EXPECT_DATA_ts1[31:0]), .BIST_SHIFT_COLLAR(BIST_SHIFT_COLLAR_ts1), 
      .BIST_TESTDATA_SELECT_TO_COLLAR(BIST_TESTDATA_SELECT_TO_COLLAR_ts1), .MEM0_BIST_COLLAR_SI(MEM0_BIST_COLLAR_SI_ts1), 
      .MEM1_BIST_COLLAR_SI(MEM1_BIST_COLLAR_SI_ts1), .MEM2_BIST_COLLAR_SI(MEM2_BIST_COLLAR_SI_ts1), 
      .MEM3_BIST_COLLAR_SI(MEM3_BIST_COLLAR_SI_ts1), .BIST_COLLAR_SETUP(BIST_COLLAR_SETUP_ts1), 
      .BIST_COLLAR_OPSET_SELECT(BIST_COLLAR_OPSET_SELECT_ts1), .BIST_COLLAR_HOLD(BIST_COLLAR_HOLD_ts1), 
      .FREEZE_STOP_ERROR(FREEZE_STOP_ERROR_ts1), .ERROR_CNT_ZERO(ERROR_CNT_ZERO_ts1), 
      .BIST_COLLAR_DIAG_EN(BIST_COLLAR_DIAG_EN_ts1), .BIST_COLLAR_BIRA_EN(BIST_COLLAR_BIRA_EN_ts1), 
      .BIST_CLEAR_DEFAULT(BIST_CLEAR_DEFAULT_ts1), .BIST_CLEAR(BIST_CLEAR_ts1), 
      .MBISTPG_SO(MBISTPG_SO_ts1), .PriorityColumn(PriorityColumn_ts1), .BIST_WRITEENABLE(BIST_WRITEENABLE_ts1), 
      .BIST_SELECT(BIST_SELECT), .BIST_CMP(BIST_CMP_ts1), .BIST_COLLAR_EN0(BIST_COLLAR_EN0_ts1), 
      .BIST_RUN_TO_COLLAR0(BIST_RUN_TO_COLLAR0_ts1), .BIST_COLLAR_EN1(BIST_COLLAR_EN1_ts1), 
      .BIST_RUN_TO_COLLAR1(BIST_RUN_TO_COLLAR1_ts1), .BIST_COLLAR_EN2(BIST_COLLAR_EN2_ts1), 
      .BIST_RUN_TO_COLLAR2(BIST_RUN_TO_COLLAR2_ts1), .BIST_COLLAR_EN3(BIST_COLLAR_EN3_ts1), 
      .BIST_RUN_TO_COLLAR3(BIST_RUN_TO_COLLAR3_ts1), .MBISTPG_GO(MBISTPG_GO_ts1), 
      .MBISTPG_STABLE(MBISTPG_STABLE_ts1), .MBISTPG_DONE(MBISTPG_DONE_ts1), .BIST_ON_TO_COLLAR(BIST_ON_TO_COLLAR_ts1), 
      .BIST_SHIFT_BIRA_COLLAR(BIST_SHIFT_BIRA_COLLAR_ts1), .GO_ID_REG_SEL(GO_ID_REG_SEL_ts1), 
      .ALGO_SEL_REG(ALGO_SEL_REG_ts1), .fscan_clkungate(fscan_clkungate)
  );

  hlp_fgrp_apr_rtl_tessent_mbist_SRAM_c3_controller hlp_fgrp_apr_rtl_tessent_mbist_SRAM_c3_controller_inst(
      .MBIST_RA_PRSRV_FUSE_VAL(PRESERVE_FUSE_REGISTER), .MBISTPG_ALGO_SEL({
      BIST_ALGO_SEL_ts6, BIST_ALGO_SEL_ts5, BIST_ALGO_SEL_ts4, 
      BIST_ALGO_SEL_ts3, BIST_ALGO_SEL_ts2, BIST_ALGO_SEL_ts1, BIST_ALGO_SEL}), .MBISTPG_SELECT_COMMON_ALGO(BIST_SELECT_COMMON_ALGO), 
      .MBISTPG_OPSET_SELECT(BIST_OPSET_SEL), .MBISTPG_SELECT_COMMON_OPSET(BIST_SELECT_COMMON_OPSET), 
      .MBISTPG_DATA_INV_ROW_ADD_BIT_SELECT_EN(BIST_DATA_INV_ROW_ADD_BIT_SELECT_EN), 
      .MBISTPG_DATA_INV_ROW_ADD_BIT_SELECT(BIST_DATA_INV_ROW_ADD_BIT_SEL), .MBISTPG_DATA_INV_COL_ADD_BIT_SELECT_EN(BIST_DATA_INV_COL_ADD_BIT_SELECT_EN), 
      .MBISTPG_DATA_INV_COL_ADD_BIT_SELECT(BIST_DATA_INV_COL_ADD_BIT_SEL), .MBISTPG_ALGO_MODE({
      BIST_ALGO_MODE1, BIST_ALGO_MODE0}), .MBISTPG_MEM_RST(ENABLE_MEM_RESET), .MBISTPG_REDUCED_ADDR_CNT_EN(REDUCED_ADDRESS_COUNT), 
      .MEM_BYPASS_EN(memory_bypass_to_en), .MCP_BOUNDING_EN(mcp_bounding_to_en), 
      .MEM0_BIST_COLLAR_SO(BIST_SO_ts2), .MEM1_BIST_COLLAR_SO(BIST_SO_ts3), .MEM2_BIST_COLLAR_SO(BIST_SO_ts4), 
      .MEM3_BIST_COLLAR_SO(BIST_SO_ts5), .MEM4_BIST_COLLAR_SO(BIST_SO_ts6), .MEM5_BIST_COLLAR_SO(BIST_SO_ts7), 
      .MEM6_BIST_COLLAR_SO(BIST_SO_ts8), .MEM7_BIST_COLLAR_SO(BIST_SO_ts9), .MEM8_BIST_COLLAR_SO(BIST_SO_ts10), 
      .MEM9_BIST_COLLAR_SO(BIST_SO_ts11), .MEM10_BIST_COLLAR_SO(BIST_SO_ts12), 
      .MEM11_BIST_COLLAR_SO(BIST_SO_ts13), .MEM12_BIST_COLLAR_SO(BIST_SO_ts14), 
      .MEM13_BIST_COLLAR_SO(BIST_SO_ts15), .MEM14_BIST_COLLAR_SO(BIST_SO_ts16), 
      .MEM15_BIST_COLLAR_SO(BIST_SO_ts17), .MEM16_BIST_COLLAR_SO(BIST_SO_ts18), 
      .MEM17_BIST_COLLAR_SO(BIST_SO_ts19), .MEM18_BIST_COLLAR_SO(BIST_SO_ts20), 
      .MEM19_BIST_COLLAR_SO(BIST_SO_ts21), .FL_CNT_MODE({FL_CNT_MODE1, 
      FL_CNT_MODE0}), .MBISTPG_BIRA_EN(BIRA_EN), .CHECK_REPAIR_NEEDED(CHECK_REPAIR_NEEDED), 
      .BIST_COLLAR_GO({BIST_GO_ts21, BIST_GO_ts20, BIST_GO_ts19, 
      BIST_GO_ts18, BIST_GO_ts17, BIST_GO_ts16, BIST_GO_ts15, BIST_GO_ts14, 
      BIST_GO_ts13, BIST_GO_ts12, BIST_GO_ts11, BIST_GO_ts10, BIST_GO_ts9, 
      BIST_GO_ts8, BIST_GO_ts7, BIST_GO_ts6, BIST_GO_ts5, BIST_GO_ts4, 
      BIST_GO_ts3, BIST_GO_ts2}), .MBISTPG_DIAG_EN(BIST_DIAG_EN), .BIST_CLK(clk_ts1), 
      .BIST_SI(toBist[2]), .BIST_HOLD(BIST_HOLD), .BIST_SETUP2(BIST_SETUP_ts3), 
      .BIST_SETUP({BIST_SETUP_ts2, BIST_SETUP_ts1}), .MBISTPG_TESTDATA_SELECT(BIST_SELECT_TEST_DATA), 
      .TCK(to_controllers_tck), .TCK_RETIME(to_controllers_tck_retime), .MBISTPG_EN(bistEn[2]), 
      .MBISTPG_ASYNC_RESETN(BIST_ASYNC_RESET), .LV_TM(ltest_to_en_ts1), .MBISTPG_MEM_ARRAY_DUMP_MODE(MEM_ARRAY_DUMP_MODE), 
      .BIST_CLEAR_BIRA(BIST_CLEAR_BIRA_ts2), .MBISTPG_RESET_REG_SETUP2(MBISTPG_RESET_REG_SETUP2_ts2), 
      .BIST_COL_ADD(BIST_COL_ADD_ts2[1:0]), .BIST_ROW_ADD(BIST_ROW_ADD_ts2[7:0]), 
      .BIST_WRITE_DATA(BIST_WRITE_DATA_ts2[31:0]), .BIST_EXPECT_DATA(BIST_EXPECT_DATA_ts2[31:0]), 
      .BIST_SHIFT_COLLAR(BIST_SHIFT_COLLAR_ts2), .BIST_TESTDATA_SELECT_TO_COLLAR(BIST_TESTDATA_SELECT_TO_COLLAR_ts2), 
      .MEM0_BIST_COLLAR_SI(MEM0_BIST_COLLAR_SI_ts2), .MEM1_BIST_COLLAR_SI(MEM1_BIST_COLLAR_SI_ts2), 
      .MEM2_BIST_COLLAR_SI(MEM2_BIST_COLLAR_SI_ts2), .MEM3_BIST_COLLAR_SI(MEM3_BIST_COLLAR_SI_ts2), 
      .MEM4_BIST_COLLAR_SI(MEM4_BIST_COLLAR_SI_ts1), .MEM5_BIST_COLLAR_SI(MEM5_BIST_COLLAR_SI_ts1), 
      .MEM6_BIST_COLLAR_SI(MEM6_BIST_COLLAR_SI_ts1), .MEM7_BIST_COLLAR_SI(MEM7_BIST_COLLAR_SI_ts1), 
      .MEM8_BIST_COLLAR_SI(MEM8_BIST_COLLAR_SI_ts1), .MEM9_BIST_COLLAR_SI(MEM9_BIST_COLLAR_SI_ts1), 
      .MEM10_BIST_COLLAR_SI(MEM10_BIST_COLLAR_SI_ts1), .MEM11_BIST_COLLAR_SI(MEM11_BIST_COLLAR_SI_ts1), 
      .MEM12_BIST_COLLAR_SI(MEM12_BIST_COLLAR_SI_ts1), .MEM13_BIST_COLLAR_SI(MEM13_BIST_COLLAR_SI_ts1), 
      .MEM14_BIST_COLLAR_SI(MEM14_BIST_COLLAR_SI_ts1), .MEM15_BIST_COLLAR_SI(MEM15_BIST_COLLAR_SI_ts1), 
      .MEM16_BIST_COLLAR_SI(MEM16_BIST_COLLAR_SI), .MEM17_BIST_COLLAR_SI(MEM17_BIST_COLLAR_SI), 
      .MEM18_BIST_COLLAR_SI(MEM18_BIST_COLLAR_SI), .MEM19_BIST_COLLAR_SI(MEM19_BIST_COLLAR_SI), 
      .BIST_COLLAR_SETUP(BIST_COLLAR_SETUP_ts2), .BIST_COLLAR_OPSET_SELECT(BIST_COLLAR_OPSET_SELECT_ts2), 
      .BIST_COLLAR_HOLD(BIST_COLLAR_HOLD_ts2), .FREEZE_STOP_ERROR(FREEZE_STOP_ERROR_ts2), 
      .ERROR_CNT_ZERO(ERROR_CNT_ZERO_ts2), .BIST_COLLAR_DIAG_EN(BIST_COLLAR_DIAG_EN_ts2), 
      .BIST_COLLAR_BIRA_EN(BIST_COLLAR_BIRA_EN_ts2), .BIST_CLEAR_DEFAULT(BIST_CLEAR_DEFAULT_ts2), 
      .BIST_CLEAR(BIST_CLEAR_ts2), .MBISTPG_SO(MBISTPG_SO_ts2), .PriorityColumn(PriorityColumn_ts2), 
      .BIST_WRITEENABLE(BIST_WRITEENABLE_ts2), .BIST_SELECT(BIST_SELECT_ts1), .BIST_CMP(BIST_CMP_ts2), 
      .BIST_COLLAR_EN0(BIST_COLLAR_EN0_ts2), .BIST_RUN_TO_COLLAR0(BIST_RUN_TO_COLLAR0_ts2), 
      .BIST_COLLAR_EN1(BIST_COLLAR_EN1_ts2), .BIST_RUN_TO_COLLAR1(BIST_RUN_TO_COLLAR1_ts2), 
      .BIST_COLLAR_EN2(BIST_COLLAR_EN2_ts2), .BIST_RUN_TO_COLLAR2(BIST_RUN_TO_COLLAR2_ts2), 
      .BIST_COLLAR_EN3(BIST_COLLAR_EN3_ts2), .BIST_RUN_TO_COLLAR3(BIST_RUN_TO_COLLAR3_ts2), 
      .BIST_COLLAR_EN4(BIST_COLLAR_EN4_ts1), .BIST_RUN_TO_COLLAR4(BIST_RUN_TO_COLLAR4_ts1), 
      .BIST_COLLAR_EN5(BIST_COLLAR_EN5_ts1), .BIST_RUN_TO_COLLAR5(BIST_RUN_TO_COLLAR5_ts1), 
      .BIST_COLLAR_EN6(BIST_COLLAR_EN6_ts1), .BIST_RUN_TO_COLLAR6(BIST_RUN_TO_COLLAR6_ts1), 
      .BIST_COLLAR_EN7(BIST_COLLAR_EN7_ts1), .BIST_RUN_TO_COLLAR7(BIST_RUN_TO_COLLAR7_ts1), 
      .BIST_COLLAR_EN8(BIST_COLLAR_EN8_ts1), .BIST_RUN_TO_COLLAR8(BIST_RUN_TO_COLLAR8_ts1), 
      .BIST_COLLAR_EN9(BIST_COLLAR_EN9_ts1), .BIST_RUN_TO_COLLAR9(BIST_RUN_TO_COLLAR9_ts1), 
      .BIST_COLLAR_EN10(BIST_COLLAR_EN10_ts1), .BIST_RUN_TO_COLLAR10(BIST_RUN_TO_COLLAR10_ts1), 
      .BIST_COLLAR_EN11(BIST_COLLAR_EN11_ts1), .BIST_RUN_TO_COLLAR11(BIST_RUN_TO_COLLAR11_ts1), 
      .BIST_COLLAR_EN12(BIST_COLLAR_EN12_ts1), .BIST_RUN_TO_COLLAR12(BIST_RUN_TO_COLLAR12_ts1), 
      .BIST_COLLAR_EN13(BIST_COLLAR_EN13_ts1), .BIST_RUN_TO_COLLAR13(BIST_RUN_TO_COLLAR13_ts1), 
      .BIST_COLLAR_EN14(BIST_COLLAR_EN14_ts1), .BIST_RUN_TO_COLLAR14(BIST_RUN_TO_COLLAR14_ts1), 
      .BIST_COLLAR_EN15(BIST_COLLAR_EN15_ts1), .BIST_RUN_TO_COLLAR15(BIST_RUN_TO_COLLAR15_ts1), 
      .BIST_COLLAR_EN16(BIST_COLLAR_EN16), .BIST_RUN_TO_COLLAR16(BIST_RUN_TO_COLLAR16), 
      .BIST_COLLAR_EN17(BIST_COLLAR_EN17), .BIST_RUN_TO_COLLAR17(BIST_RUN_TO_COLLAR17), 
      .BIST_COLLAR_EN18(BIST_COLLAR_EN18), .BIST_RUN_TO_COLLAR18(BIST_RUN_TO_COLLAR18), 
      .BIST_COLLAR_EN19(BIST_COLLAR_EN19), .BIST_RUN_TO_COLLAR19(BIST_RUN_TO_COLLAR19), 
      .MBISTPG_GO(MBISTPG_GO_ts2), .MBISTPG_STABLE(MBISTPG_STABLE_ts2), .MBISTPG_DONE(MBISTPG_DONE_ts2), 
      .BIST_ON_TO_COLLAR(BIST_ON_TO_COLLAR_ts2), .BIST_SHIFT_BIRA_COLLAR(BIST_SHIFT_BIRA_COLLAR_ts2), 
      .GO_ID_REG_SEL(GO_ID_REG_SEL_ts2), .ALGO_SEL_REG(ALGO_SEL_REG_ts2), .fscan_clkungate(fscan_clkungate)
  );

  hlp_fgrp_apr_rtl_tessent_mbist_TCAM_c4_controller hlp_fgrp_apr_rtl_tessent_mbist_TCAM_c4_controller_inst(
      .MBIST_RA_PRSRV_FUSE_VAL(PRESERVE_FUSE_REGISTER), .MBISTPG_ALGO_SEL({
      BIST_ALGO_SEL_ts6, BIST_ALGO_SEL_ts5, BIST_ALGO_SEL_ts4, 
      BIST_ALGO_SEL_ts3, BIST_ALGO_SEL_ts2, BIST_ALGO_SEL_ts1, BIST_ALGO_SEL}), .MBISTPG_SELECT_COMMON_ALGO(BIST_SELECT_COMMON_ALGO), 
      .MBISTPG_OPSET_SELECT({BIST_OPSET_SEL_ts1, BIST_OPSET_SEL}), .MBISTPG_SELECT_COMMON_OPSET(BIST_SELECT_COMMON_OPSET), 
      .MBISTPG_DATA_INV_ROW_ADD_BIT_SELECT_EN(BIST_DATA_INV_ROW_ADD_BIT_SELECT_EN), 
      .MBISTPG_DATA_INV_ROW_ADD_BIT_SELECT(BIST_DATA_INV_ROW_ADD_BIT_SEL), .MBISTPG_DATA_INV_COL_ADD_BIT_SELECT_EN(BIST_DATA_INV_COL_ADD_BIT_SELECT_EN), 
      .MBISTPG_DATA_INV_COL_ADD_BIT_SELECT(BIST_DATA_INV_COL_ADD_BIT_SEL), .MBISTPG_ALGO_MODE({
      BIST_ALGO_MODE1, BIST_ALGO_MODE0}), .MBISTPG_MEM_RST(ENABLE_MEM_RESET), .MBISTPG_REDUCED_ADDR_CNT_EN(REDUCED_ADDRESS_COUNT), 
      .MEM_BYPASS_EN(memory_bypass_to_en), .MCP_BOUNDING_EN(mcp_bounding_to_en), 
      .MEM0_BIST_COLLAR_SO(BIST_SO_ts40), .MEM1_BIST_COLLAR_SO(BIST_SO_ts41), .MEM2_BIST_COLLAR_SO(BIST_SO_ts42), 
      .MEM3_BIST_COLLAR_SO(BIST_SO_ts43), .MEM4_BIST_COLLAR_SO(BIST_SO_ts44), .MEM5_BIST_COLLAR_SO(BIST_SO_ts45), 
      .MEM6_BIST_COLLAR_SO(BIST_SO_ts46), .MEM7_BIST_COLLAR_SO(BIST_SO_ts47), .MEM8_BIST_COLLAR_SO(BIST_SO_ts48), 
      .MEM9_BIST_COLLAR_SO(BIST_SO_ts49), .MEM10_BIST_COLLAR_SO(BIST_SO_ts50), 
      .MEM11_BIST_COLLAR_SO(BIST_SO_ts51), .MEM12_BIST_COLLAR_SO(BIST_SO_ts52), 
      .MEM13_BIST_COLLAR_SO(BIST_SO_ts53), .MEM14_BIST_COLLAR_SO(BIST_SO_ts54), 
      .MEM15_BIST_COLLAR_SO(BIST_SO_ts55), .MEM16_BIST_COLLAR_SO(BIST_SO_ts56), 
      .MEM17_BIST_COLLAR_SO(BIST_SO_ts57), .MEM18_BIST_COLLAR_SO(BIST_SO_ts58), 
      .MEM19_BIST_COLLAR_SO(BIST_SO_ts59), .MEM20_BIST_COLLAR_SO(BIST_SO_ts60), 
      .MEM21_BIST_COLLAR_SO(BIST_SO_ts61), .MEM22_BIST_COLLAR_SO(BIST_SO_ts62), 
      .MEM23_BIST_COLLAR_SO(BIST_SO_ts63), .MEM24_BIST_COLLAR_SO(BIST_SO_ts64), 
      .MEM25_BIST_COLLAR_SO(BIST_SO_ts65), .MEM26_BIST_COLLAR_SO(BIST_SO_ts66), 
      .MEM27_BIST_COLLAR_SO(BIST_SO_ts67), .MEM28_BIST_COLLAR_SO(BIST_SO_ts68), 
      .MEM29_BIST_COLLAR_SO(BIST_SO_ts69), .MEM30_BIST_COLLAR_SO(BIST_SO_ts70), 
      .MEM31_BIST_COLLAR_SO(BIST_SO_ts71), .FL_CNT_MODE({FL_CNT_MODE1, 
      FL_CNT_MODE0}), .MBISTPG_BIRA_EN(BIRA_EN), .CHECK_REPAIR_NEEDED(CHECK_REPAIR_NEEDED), 
      .BIST_COLLAR_GO({BIST_GO_ts71, BIST_GO_ts70, BIST_GO_ts69, 
      BIST_GO_ts68, BIST_GO_ts67, BIST_GO_ts66, BIST_GO_ts65, BIST_GO_ts64, 
      BIST_GO_ts63, BIST_GO_ts62, BIST_GO_ts61, BIST_GO_ts60, BIST_GO_ts59, 
      BIST_GO_ts58, BIST_GO_ts57, BIST_GO_ts56, BIST_GO_ts55, BIST_GO_ts54, 
      BIST_GO_ts53, BIST_GO_ts52, BIST_GO_ts51, BIST_GO_ts50, BIST_GO_ts49, 
      BIST_GO_ts48, BIST_GO_ts47, BIST_GO_ts46, BIST_GO_ts45, BIST_GO_ts44, 
      BIST_GO_ts43, BIST_GO_ts42, BIST_GO_ts41, BIST_GO_ts40}), .MBISTPG_DIAG_EN(BIST_DIAG_EN), 
      .BIST_CLK(clk_ts1), .BIST_SI(toBist[3]), .BIST_HOLD(BIST_HOLD), .BIST_SETUP2(BIST_SETUP_ts3), 
      .BIST_SETUP({BIST_SETUP_ts2, BIST_SETUP_ts1}), .MBISTPG_TESTDATA_SELECT(BIST_SELECT_TEST_DATA), 
      .TCK(to_controllers_tck), .TCK_RETIME(to_controllers_tck_retime), .MBISTPG_EN(bistEn[3]), 
      .MBISTPG_ASYNC_RESETN(BIST_ASYNC_RESET), .LV_TM(ltest_to_en_ts1), .MBISTPG_MEM_ARRAY_DUMP_MODE(MEM_ARRAY_DUMP_MODE), 
      .BIST_CLEAR_BIRA(BIST_CLEAR_BIRA_ts3), .MBISTPG_RESET_REG_SETUP2(MBISTPG_RESET_REG_SETUP2_ts3), 
      .BIST_COL_ADD(BIST_COL_ADD_ts3), .BIST_ROW_ADD(BIST_ROW_ADD_ts3[5:0]), .BIST_BANK_ADD(BIST_BANK_ADD_ts1[2:0]), 
      .BIST_WRITE_DATA(BIST_WRITE_DATA_ts3[31:0]), .BIST_EXPECT_DATA(BIST_EXPECT_DATA_ts3[31:0]), 
      .BIST_SHIFT_COLLAR(BIST_SHIFT_COLLAR_ts3), .BIST_TESTDATA_SELECT_TO_COLLAR(BIST_TESTDATA_SELECT_TO_COLLAR_ts3), 
      .MEM0_BIST_COLLAR_SI(MEM0_BIST_COLLAR_SI_ts3), .MEM1_BIST_COLLAR_SI(MEM1_BIST_COLLAR_SI_ts3), 
      .MEM2_BIST_COLLAR_SI(MEM2_BIST_COLLAR_SI_ts3), .MEM3_BIST_COLLAR_SI(MEM3_BIST_COLLAR_SI_ts3), 
      .MEM4_BIST_COLLAR_SI(MEM4_BIST_COLLAR_SI_ts2), .MEM5_BIST_COLLAR_SI(MEM5_BIST_COLLAR_SI_ts2), 
      .MEM6_BIST_COLLAR_SI(MEM6_BIST_COLLAR_SI_ts2), .MEM7_BIST_COLLAR_SI(MEM7_BIST_COLLAR_SI_ts2), 
      .MEM8_BIST_COLLAR_SI(MEM8_BIST_COLLAR_SI_ts2), .MEM9_BIST_COLLAR_SI(MEM9_BIST_COLLAR_SI_ts2), 
      .MEM10_BIST_COLLAR_SI(MEM10_BIST_COLLAR_SI_ts2), .MEM11_BIST_COLLAR_SI(MEM11_BIST_COLLAR_SI_ts2), 
      .MEM12_BIST_COLLAR_SI(MEM12_BIST_COLLAR_SI_ts2), .MEM13_BIST_COLLAR_SI(MEM13_BIST_COLLAR_SI_ts2), 
      .MEM14_BIST_COLLAR_SI(MEM14_BIST_COLLAR_SI_ts2), .MEM15_BIST_COLLAR_SI(MEM15_BIST_COLLAR_SI_ts2), 
      .MEM16_BIST_COLLAR_SI(MEM16_BIST_COLLAR_SI_ts1), .MEM17_BIST_COLLAR_SI(MEM17_BIST_COLLAR_SI_ts1), 
      .MEM18_BIST_COLLAR_SI(MEM18_BIST_COLLAR_SI_ts1), .MEM19_BIST_COLLAR_SI(MEM19_BIST_COLLAR_SI_ts1), 
      .MEM20_BIST_COLLAR_SI(MEM20_BIST_COLLAR_SI), .MEM21_BIST_COLLAR_SI(MEM21_BIST_COLLAR_SI), 
      .MEM22_BIST_COLLAR_SI(MEM22_BIST_COLLAR_SI), .MEM23_BIST_COLLAR_SI(MEM23_BIST_COLLAR_SI), 
      .MEM24_BIST_COLLAR_SI(MEM24_BIST_COLLAR_SI), .MEM25_BIST_COLLAR_SI(MEM25_BIST_COLLAR_SI), 
      .MEM26_BIST_COLLAR_SI(MEM26_BIST_COLLAR_SI), .MEM27_BIST_COLLAR_SI(MEM27_BIST_COLLAR_SI), 
      .MEM28_BIST_COLLAR_SI(MEM28_BIST_COLLAR_SI), .MEM29_BIST_COLLAR_SI(MEM29_BIST_COLLAR_SI), 
      .MEM30_BIST_COLLAR_SI(MEM30_BIST_COLLAR_SI), .MEM31_BIST_COLLAR_SI(MEM31_BIST_COLLAR_SI), 
      .BIST_COLLAR_SETUP(BIST_COLLAR_SETUP_ts3), .BIST_COLLAR_OPSET_SELECT(BIST_COLLAR_OPSET_SELECT_ts3[1:0]), 
      .BIST_COLLAR_HOLD(BIST_COLLAR_HOLD_ts3), .FREEZE_STOP_ERROR(FREEZE_STOP_ERROR_ts3), 
      .ERROR_CNT_ZERO(ERROR_CNT_ZERO_ts3), .BIST_COLLAR_DIAG_EN(BIST_COLLAR_DIAG_EN_ts3), 
      .BIST_COLLAR_BIRA_EN(BIST_COLLAR_BIRA_EN_ts3), .BIST_CLEAR_DEFAULT(BIST_CLEAR_DEFAULT_ts3), 
      .BIST_CLEAR(BIST_CLEAR_ts3), .MBISTPG_SO(MBISTPG_SO_ts3), .BIST_USER9(BIST_USER9), 
      .BIST_USER10(BIST_USER10), .BIST_USER11(BIST_USER11), .BIST_USER0(BIST_USER0), 
      .BIST_USER1(BIST_USER1), .BIST_USER2(BIST_USER2), .BIST_USER3(BIST_USER3), 
      .BIST_USER4(BIST_USER4), .BIST_USER5(BIST_USER5), .BIST_USER6(BIST_USER6), 
      .BIST_USER7(BIST_USER7), .BIST_USER8(BIST_USER8), .BIST_EVEN_GROUPWRITEENABLE(BIST_EVEN_GROUPWRITEENABLE), 
      .BIST_ODD_GROUPWRITEENABLE(BIST_ODD_GROUPWRITEENABLE), .BIST_WRITEENABLE(BIST_WRITEENABLE_ts3), 
      .BIST_READENABLE(BIST_READENABLE_ts1), .BIST_SELECT(BIST_SELECT_ts2), .BIST_CMP(BIST_CMP_ts3), 
      .BIST_COLLAR_EN0(BIST_COLLAR_EN0_ts3), .BIST_RUN_TO_COLLAR0(BIST_RUN_TO_COLLAR0_ts3), 
      .BIST_COLLAR_EN1(BIST_COLLAR_EN1_ts3), .BIST_RUN_TO_COLLAR1(BIST_RUN_TO_COLLAR1_ts3), 
      .BIST_COLLAR_EN2(BIST_COLLAR_EN2_ts3), .BIST_RUN_TO_COLLAR2(BIST_RUN_TO_COLLAR2_ts3), 
      .BIST_COLLAR_EN3(BIST_COLLAR_EN3_ts3), .BIST_RUN_TO_COLLAR3(BIST_RUN_TO_COLLAR3_ts3), 
      .BIST_COLLAR_EN4(BIST_COLLAR_EN4_ts2), .BIST_RUN_TO_COLLAR4(BIST_RUN_TO_COLLAR4_ts2), 
      .BIST_COLLAR_EN5(BIST_COLLAR_EN5_ts2), .BIST_RUN_TO_COLLAR5(BIST_RUN_TO_COLLAR5_ts2), 
      .BIST_COLLAR_EN6(BIST_COLLAR_EN6_ts2), .BIST_RUN_TO_COLLAR6(BIST_RUN_TO_COLLAR6_ts2), 
      .BIST_COLLAR_EN7(BIST_COLLAR_EN7_ts2), .BIST_RUN_TO_COLLAR7(BIST_RUN_TO_COLLAR7_ts2), 
      .BIST_COLLAR_EN8(BIST_COLLAR_EN8_ts2), .BIST_RUN_TO_COLLAR8(BIST_RUN_TO_COLLAR8_ts2), 
      .BIST_COLLAR_EN9(BIST_COLLAR_EN9_ts2), .BIST_RUN_TO_COLLAR9(BIST_RUN_TO_COLLAR9_ts2), 
      .BIST_COLLAR_EN10(BIST_COLLAR_EN10_ts2), .BIST_RUN_TO_COLLAR10(BIST_RUN_TO_COLLAR10_ts2), 
      .BIST_COLLAR_EN11(BIST_COLLAR_EN11_ts2), .BIST_RUN_TO_COLLAR11(BIST_RUN_TO_COLLAR11_ts2), 
      .BIST_COLLAR_EN12(BIST_COLLAR_EN12_ts2), .BIST_RUN_TO_COLLAR12(BIST_RUN_TO_COLLAR12_ts2), 
      .BIST_COLLAR_EN13(BIST_COLLAR_EN13_ts2), .BIST_RUN_TO_COLLAR13(BIST_RUN_TO_COLLAR13_ts2), 
      .BIST_COLLAR_EN14(BIST_COLLAR_EN14_ts2), .BIST_RUN_TO_COLLAR14(BIST_RUN_TO_COLLAR14_ts2), 
      .BIST_COLLAR_EN15(BIST_COLLAR_EN15_ts2), .BIST_RUN_TO_COLLAR15(BIST_RUN_TO_COLLAR15_ts2), 
      .BIST_COLLAR_EN16(BIST_COLLAR_EN16_ts1), .BIST_RUN_TO_COLLAR16(BIST_RUN_TO_COLLAR16_ts1), 
      .BIST_COLLAR_EN17(BIST_COLLAR_EN17_ts1), .BIST_RUN_TO_COLLAR17(BIST_RUN_TO_COLLAR17_ts1), 
      .BIST_COLLAR_EN18(BIST_COLLAR_EN18_ts1), .BIST_RUN_TO_COLLAR18(BIST_RUN_TO_COLLAR18_ts1), 
      .BIST_COLLAR_EN19(BIST_COLLAR_EN19_ts1), .BIST_RUN_TO_COLLAR19(BIST_RUN_TO_COLLAR19_ts1), 
      .BIST_COLLAR_EN20(BIST_COLLAR_EN20), .BIST_RUN_TO_COLLAR20(BIST_RUN_TO_COLLAR20), 
      .BIST_COLLAR_EN21(BIST_COLLAR_EN21), .BIST_RUN_TO_COLLAR21(BIST_RUN_TO_COLLAR21), 
      .BIST_COLLAR_EN22(BIST_COLLAR_EN22), .BIST_RUN_TO_COLLAR22(BIST_RUN_TO_COLLAR22), 
      .BIST_COLLAR_EN23(BIST_COLLAR_EN23), .BIST_RUN_TO_COLLAR23(BIST_RUN_TO_COLLAR23), 
      .BIST_COLLAR_EN24(BIST_COLLAR_EN24), .BIST_RUN_TO_COLLAR24(BIST_RUN_TO_COLLAR24), 
      .BIST_COLLAR_EN25(BIST_COLLAR_EN25), .BIST_RUN_TO_COLLAR25(BIST_RUN_TO_COLLAR25), 
      .BIST_COLLAR_EN26(BIST_COLLAR_EN26), .BIST_RUN_TO_COLLAR26(BIST_RUN_TO_COLLAR26), 
      .BIST_COLLAR_EN27(BIST_COLLAR_EN27), .BIST_RUN_TO_COLLAR27(BIST_RUN_TO_COLLAR27), 
      .BIST_COLLAR_EN28(BIST_COLLAR_EN28), .BIST_RUN_TO_COLLAR28(BIST_RUN_TO_COLLAR28), 
      .BIST_COLLAR_EN29(BIST_COLLAR_EN29), .BIST_RUN_TO_COLLAR29(BIST_RUN_TO_COLLAR29), 
      .BIST_COLLAR_EN30(BIST_COLLAR_EN30), .BIST_RUN_TO_COLLAR30(BIST_RUN_TO_COLLAR30), 
      .BIST_COLLAR_EN31(BIST_COLLAR_EN31), .BIST_RUN_TO_COLLAR31(BIST_RUN_TO_COLLAR31), 
      .MBISTPG_GO(MBISTPG_GO_ts3), .MBISTPG_STABLE(MBISTPG_STABLE_ts3), .MBISTPG_DONE(MBISTPG_DONE_ts3), 
      .BIST_ON_TO_COLLAR(BIST_ON_TO_COLLAR_ts3), .BIST_SHIFT_BIRA_COLLAR(BIST_SHIFT_BIRA_COLLAR_ts3), 
      .GO_ID_REG_SEL(GO_ID_REG_SEL_ts3), .ALGO_SEL_REG(ALGO_SEL_REG_ts3), .fscan_clkungate(fscan_clkungate)
  );

  assign BIST_SETUP_ts1 = BIST_SETUP[0];

  assign BIST_SETUP_ts2 = BIST_SETUP[1];

  assign BIST_SETUP_ts3 = BIST_SETUP[2];

  TS_CLK_MUX tessent_persistent_cell_tck_mux_hlp_fgrp_apr_rtl_clk_inst(
      .ck0(clk), .ck1(ijtag_to_tck), .s(tck_select), .o(clk_ts1)
  );

  hlp_fgrp_apr_rtl_tessent_mbist_diagnosis_ready hlp_fgrp_apr_rtl_tessent_mbist_diagnosis_ready_inst(
      .ijtag_reset(ijtag_to_reset), .ijtag_sel(ijtag_to_sel), .ijtag_si(hlp_fgrp_apr_rtl_tessent_mbist_bap_inst_so), 
      .ijtag_ce(ijtag_to_ce), .ijtag_se(ijtag_to_se), .ijtag_ue(ijtag_to_ue), .ijtag_tck(ijtag_to_tck), 
      .ijtag_so(ijtag_so), .DiagnosisReady_ctl_in({MBISTPG_STABLE_ts3, 
      MBISTPG_STABLE_ts2, MBISTPG_STABLE_ts1, MBISTPG_STABLE}), .DiagnosisReady_aux_in(1'b1), 
      .StableBlock(mbist_diag_done)
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