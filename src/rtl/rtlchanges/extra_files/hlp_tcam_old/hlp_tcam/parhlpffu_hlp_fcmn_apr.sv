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

`include "hlp_fcmn_mem.def"
module parhlpffu_hlp_fcmn_apr
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
output mbist_diag_done,
input fsta_afd_en,
// Beginning of automatic inputs (from unused autoinst inputs)
input logic             DFTMASK,                // To u_fcmn_apr_sram_mems of hlp_fcmn_apr_sram_mems.v, ...
input logic             DFTSHIFTEN,             // To u_fcmn_apr_sram_mems of hlp_fcmn_apr_sram_mems.v, ...
input logic             DFT_AFD_RESET_B,        // To u_fcmn_apr_sram_mems of hlp_fcmn_apr_sram_mems.v, ...
input logic             DFT_ARRAY_FREEZE,       // To u_fcmn_apr_sram_mems of hlp_fcmn_apr_sram_mems.v, ...
input logic             clk,                    // To u_fcmn_apr_sram_mems of hlp_fcmn_apr_sram_mems.v, ...
input logic [6:0]       fary_ffuse_hd2prf_trim, // To u_fcmn_apr_rf_mems of hlp_fcmn_apr_rf_mems.v
input logic [16:0]      fary_ffuse_hdusplr_trim,// To u_fcmn_apr_sram_mems of hlp_fcmn_apr_sram_mems.v
input logic [16:0]      fary_ffuse_hduspsr_trim,// To u_fcmn_apr_sram_mems of hlp_fcmn_apr_sram_mems.v
input logic [1:0]       fary_ffuse_rf_sleep,    // To u_fcmn_apr_rf_mems of hlp_fcmn_apr_rf_mems.v
input logic [1:0]       fary_ffuse_sram_sleep,  // To u_fcmn_apr_sram_mems of hlp_fcmn_apr_sram_mems.v
input logic             fary_ffuse_tcam_sleep,  // To u_fcmn_apr_tcam_mems of hlp_fcmn_apr_tcam_mems.v
input logic [15:0]      fary_ffuse_tune_tcam,   // To u_fcmn_apr_tcam_mems of hlp_fcmn_apr_tcam_mems.v
input logic             fary_output_reset,      // To u_fcmn_apr_sram_mems of hlp_fcmn_apr_sram_mems.v, ...
input logic             fscan_byprst_b,         // To u_fcmn_apr_func_logic of hlp_fcmn_apr_func_logic.v
input logic [hlp_dfx_pkg::FCMN_NUM_CLKGENCTRL-1:0] fscan_clkgenctrl,// To u_fcmn_apr_func_logic of hlp_fcmn_apr_func_logic.v
input logic [hlp_dfx_pkg::FCMN_NUM_CLKGENCTRLEN-1:0] fscan_clkgenctrlen,// To u_fcmn_apr_func_logic of hlp_fcmn_apr_func_logic.v
input logic             fscan_clkungate,        // To u_fcmn_apr_sram_mems of hlp_fcmn_apr_sram_mems.v, ...
input logic             fscan_clkungate_syn,    // To u_fcmn_apr_func_logic of hlp_fcmn_apr_func_logic.v
input logic             fscan_latchclosed_b,    // To u_fcmn_apr_func_logic of hlp_fcmn_apr_func_logic.v
input logic             fscan_latchopen,        // To u_fcmn_apr_func_logic of hlp_fcmn_apr_func_logic.v
input logic             fscan_mode,             // To u_fcmn_apr_tcam_mems of hlp_fcmn_apr_tcam_mems.v, ...
input logic             fscan_mode_atspeed,     // To u_fcmn_apr_func_logic of hlp_fcmn_apr_func_logic.v
input logic             fscan_ram_bypsel_rf,    // To u_fcmn_apr_rf_mems of hlp_fcmn_apr_rf_mems.v
input logic             fscan_ram_bypsel_sram,  // To u_fcmn_apr_sram_mems of hlp_fcmn_apr_sram_mems.v
input logic             fscan_ram_bypsel_tcam,  // To u_fcmn_apr_tcam_mems of hlp_fcmn_apr_tcam_mems.v
input logic             fscan_ram_init_en,      // To u_fcmn_apr_sram_mems of hlp_fcmn_apr_sram_mems.v, ...
input logic             fscan_ram_init_val,     // To u_fcmn_apr_sram_mems of hlp_fcmn_apr_sram_mems.v, ...
input logic             fscan_ram_rdis_b,       // To u_fcmn_apr_sram_mems of hlp_fcmn_apr_sram_mems.v, ...
input logic             fscan_ram_wdis_b,       // To u_fcmn_apr_sram_mems of hlp_fcmn_apr_sram_mems.v, ...
input logic             fscan_ret_ctrl,         // To u_fcmn_apr_func_logic of hlp_fcmn_apr_func_logic.v
input logic             fscan_rstbypen,         // To u_fcmn_apr_func_logic of hlp_fcmn_apr_func_logic.v
input logic [hlp_dfx_pkg::FCMN_NUM_SDI-1:0] fscan_sdi,// To u_fcmn_apr_func_logic of hlp_fcmn_apr_func_logic.v
input logic             fscan_shiften,          // To u_fcmn_apr_tcam_mems of hlp_fcmn_apr_tcam_mems.v, ...
input logic             fsta_dfxact_afd,        // To u_fcmn_apr_sram_mems of hlp_fcmn_apr_sram_mems.v, ...
input logic             fvisa_all_dis,          // To u_fcmn_apr_func_logic of hlp_fcmn_apr_func_logic.v
input logic [hlp_dfx_pkg::NUM_VISA_LANES-1:0] fvisa_clk,// To u_fcmn_apr_func_logic of hlp_fcmn_apr_func_logic.v
input logic             fvisa_customer_dis,     // To u_fcmn_apr_func_logic of hlp_fcmn_apr_func_logic.v
input logic [hlp_dfx_pkg::VISA_DBG_LANE_WIDTH-1:0] fvisa_dbg_lane,// To u_fcmn_apr_func_logic of hlp_fcmn_apr_func_logic.v
input logic             fvisa_frame,            // To u_fcmn_apr_func_logic of hlp_fcmn_apr_func_logic.v
input logic             fvisa_rddata,           // To u_fcmn_apr_func_logic of hlp_fcmn_apr_func_logic.v
input logic             fvisa_resetb,           // To u_fcmn_apr_func_logic of hlp_fcmn_apr_func_logic.v
input logic             fvisa_serdata,          // To u_fcmn_apr_func_logic of hlp_fcmn_apr_func_logic.v
input logic             fvisa_serstb,           // To u_fcmn_apr_func_logic of hlp_fcmn_apr_func_logic.v
input logic [8:0]       fvisa_unit_id,          // To u_fcmn_apr_func_logic of hlp_fcmn_apr_func_logic.v
input logic [2:0]       i_fghash_ecc_int,       // To u_fcmn_apr_func_logic of hlp_fcmn_apr_func_logic.v
input logic [2:0]       i_fgrp_ecc_int,         // To u_fcmn_apr_func_logic of hlp_fcmn_apr_func_logic.v
input logic [2:0]       i_fgrp_mem_init_done,   // To u_fcmn_apr_func_logic of hlp_fcmn_apr_func_logic.v
input logic [$bits(hlp_pkg::mgmt64_t)-1:0] i_frf_mgmt,             // To u_fcmn_apr_func_logic of hlp_fcmn_apr_func_logic.v
input logic             i_frf_mgmt_v,           // To u_fcmn_apr_func_logic of hlp_fcmn_apr_func_logic.v
input logic [$bits(hlp_pkg::mgmt64_t)-1:0] i_frn_mgmt,             // To u_fcmn_apr_func_logic of hlp_fcmn_apr_func_logic.v
input logic             i_frn_mgmt_v,           // To u_fcmn_apr_func_logic of hlp_fcmn_apr_func_logic.v
input logic [$bits(hlp_ipp_pkg::group_data_t)-1:0] i_grp,          // To u_fcmn_apr_func_logic of hlp_fcmn_apr_func_logic.v
input logic             i_grp_v,                // To u_fcmn_apr_func_logic of hlp_fcmn_apr_func_logic.v
input logic             i_hlp_dts_diode0_anode, // To u_fcmn_apr_func_logic of hlp_fcmn_apr_func_logic.v
inout tri               i_hlp_dts_diode0_cathode,// To u_fcmn_apr_func_logic of hlp_fcmn_apr_func_logic.v
input logic [$bits(hlp_ipp_pkg::parser_out_t)-1:0] i_parser_out,   // To u_fcmn_apr_func_logic of hlp_fcmn_apr_func_logic.v
input logic             i_parser_out_v,         // To u_fcmn_apr_func_logic of hlp_fcmn_apr_func_logic.v
input logic [3:0] [$bits(hlp_ipp_pkg::ffu_row_ptr_t)-1:0] i_ptr,   // To u_fcmn_apr_func_logic of hlp_fcmn_apr_func_logic.v
input logic [3:0]       i_ptr_v,                // To u_fcmn_apr_func_logic of hlp_fcmn_apr_func_logic.v
input logic [$bits(hlp_pkg::imn_rpl_bkwd_t)-1:0] i_rpl_bkwd,       // To u_fcmn_apr_func_logic of hlp_fcmn_apr_func_logic.v
input logic [$bits(hlp_pkg::imn_rpl_frwd_t)-1:0] i_rpl_frwd,       // To u_fcmn_apr_func_logic of hlp_fcmn_apr_func_logic.v
input logic             isol_en_b,              // To u_fcmn_apr_sram_mems of hlp_fcmn_apr_sram_mems.v, ...
input logic [4:0]       pwr_mgmt_in_rf,         // To u_fcmn_apr_rf_mems of hlp_fcmn_apr_rf_mems.v
input logic [5:0]       pwr_mgmt_in_sram,       // To u_fcmn_apr_sram_mems of hlp_fcmn_apr_sram_mems.v
input logic             rst_n,                  // To u_fcmn_apr_func_logic of hlp_fcmn_apr_func_logic.v
// End of automatics
/*AUTOOUTPUT*/
// Beginning of automatic outputs (from unused autoinst outputs)
output logic [hlp_dfx_pkg::FCMN_NUM_SDO-1:0] ascan_sdo,// From u_fcmn_apr_func_logic of hlp_fcmn_apr_func_logic.v
output logic            avisa_all_dis,          // From u_fcmn_apr_func_logic of hlp_fcmn_apr_func_logic.v
output logic [hlp_dfx_pkg::NUM_VISA_LANES-1:0] avisa_clk,// From u_fcmn_apr_func_logic of hlp_fcmn_apr_func_logic.v
output logic            avisa_customer_dis,     // From u_fcmn_apr_func_logic of hlp_fcmn_apr_func_logic.v
output logic [hlp_dfx_pkg::VISA_DBG_LANE_WIDTH-1:0] avisa_dbg_lane,// From u_fcmn_apr_func_logic of hlp_fcmn_apr_func_logic.v
output logic            avisa_frame,            // From u_fcmn_apr_func_logic of hlp_fcmn_apr_func_logic.v
output logic            avisa_rddata,           // From u_fcmn_apr_func_logic of hlp_fcmn_apr_func_logic.v
output logic            avisa_serdata,          // From u_fcmn_apr_func_logic of hlp_fcmn_apr_func_logic.v
output logic            avisa_serstb,           // From u_fcmn_apr_func_logic of hlp_fcmn_apr_func_logic.v
output logic            isol_ack_b,             // From u_fcmn_apr_func_logic of hlp_fcmn_apr_func_logic.v
output logic [3:0] [$bits(hlp_ipp_pkg::ffu_row_data_t)-1:0] o_data,// From u_fcmn_apr_func_logic of hlp_fcmn_apr_func_logic.v
output logic [3:0]      o_data_v,               // From u_fcmn_apr_func_logic of hlp_fcmn_apr_func_logic.v
output logic [$bits(hlp_ipp_pkg::ffu_to_fwd_t)-1:0] o_ffu_to_fwd,  // From u_fcmn_apr_func_logic of hlp_fcmn_apr_func_logic.v
output logic            o_ffu_to_fwd_v,         // From u_fcmn_apr_func_logic of hlp_fcmn_apr_func_logic.v
output logic [$bits(hlp_ipp_pkg::group_data_t)-1:0] o_grp,         // From u_fcmn_apr_func_logic of hlp_fcmn_apr_func_logic.v
output logic [2:0] [$bits(hlp_ffu_pkg::group_nr_t)-1:0] o_grp_nr,  // From u_fcmn_apr_func_logic of hlp_fcmn_apr_func_logic.v
output logic            o_grp_v,                // From u_fcmn_apr_func_logic of hlp_fcmn_apr_func_logic.v
output logic            o_hlp_dts_diode0_anode, // From u_fcmn_apr_func_logic of hlp_fcmn_apr_func_logic.v
output logic            o_hlp_dts_diode0_cathode,// From u_fcmn_apr_func_logic of hlp_fcmn_apr_func_logic.v
output logic [$bits(hlp_pkg::imn_rpl_bkwd_t)-1:0] o_rpl_bkwd,      // From u_fcmn_apr_func_logic of hlp_fcmn_apr_func_logic.v
output logic [$bits(hlp_pkg::imn_rpl_frwd_t)-1:0] o_rpl_frwd,      // From u_fcmn_apr_func_logic of hlp_fcmn_apr_func_logic.v
output logic [$bits(hlp_pkg::mgmt64_t)-1:0] o_tof_mgmt,            // From u_fcmn_apr_func_logic of hlp_fcmn_apr_func_logic.v
output logic            o_tof_mgmt_v,           // From u_fcmn_apr_func_logic of hlp_fcmn_apr_func_logic.v
output logic [$bits(hlp_pkg::mgmt64_t)-1:0] o_ton_mgmt,            // From u_fcmn_apr_func_logic of hlp_fcmn_apr_func_logic.v
output logic            o_ton_mgmt_v           // From u_fcmn_apr_func_logic of hlp_fcmn_apr_func_logic.v
// End of automatics
, input wire pd_vinf_bisr_si, output wire bisr_so_pd_vinf_ts1, 
input wire pd_vinf_bisr_clk, input wire pd_vinf_bisr_reset, 
input wire pd_vinf_bisr_shift_en, output wire mbist_diag_done_ts1, 
output wire mbist_diag_done_ts2, output wire mbist_diag_done_ts3, 
output wire u_fcmn_apr_tcam_mems_so, output wire u_fcmn_apr_sram_mems_so, 
output wire u_fcmn_apr_rf_mems_so, input wire sib_fcmn_apr_sram_so, 
input wire sib_fcmn_apr_rf_to_select, input wire sib_fcmn_apr_tcam_so, 
input wire sib_fcmn_apr_sram_to_select, input wire sib_mbist_fgrp_0_so, 
input wire sib_fcmn_apr_tcam_to_select, input wire JT_IN_mbist_ijtag_update, 
input wire JT_IN_mbist_ijtag_tck, input wire JT_IN_mbist_ijtag_capture, 
input wire JT_IN_mbist_ijtag_reset_b, input wire JT_IN_mbist_ijtag_shift, 
input wire clkout);

logic latch_mem_fuses;

  /* Added by UltiBuild Nets Start */
  wire bisr_so_pd_vinf, bisr_so_pd_vinf_ts2;
  /* Added by UltiBuild Nets End */

  /* Added by UltiBuild Nets Start */
  wire fscan_clkgenctrl_ts1, fscan_clkgenctrlen_ts1;
  /* Added by UltiBuild Nets End */
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
logic [`HLP_FCMN_DOMAIN_ACTION0_FROM_MEM_WIDTH-1:0] frm_domain_action0;// From u_fcmn_apr_sram_mems of hlp_fcmn_apr_sram_mems.v
logic [`HLP_FCMN_DOMAIN_ACTION1_FROM_MEM_WIDTH-1:0] frm_domain_action1;// From u_fcmn_apr_sram_mems of hlp_fcmn_apr_sram_mems.v
logic [`HLP_FCMN_FFU_TCAM_SWP_FROM_MEM_WIDTH-1:0] frm_ffu_tcam_swp;// From u_fcmn_apr_sram_mems of hlp_fcmn_apr_sram_mems.v
logic [`HLP_FCMN_DOMAIN_ACTION0_TO_MEM_WIDTH-1:0] tom_domain_action0;// From u_fcmn_apr_func_logic of hlp_fcmn_apr_func_logic.v
logic [`HLP_FCMN_DOMAIN_ACTION1_TO_MEM_WIDTH-1:0] tom_domain_action1;// From u_fcmn_apr_func_logic of hlp_fcmn_apr_func_logic.v
logic [`HLP_FCMN_FFU_TCAM_SWP_TO_MEM_WIDTH-1:0] tom_ffu_tcam_swp;// From u_fcmn_apr_func_logic of hlp_fcmn_apr_func_logic.v
logic [63:0] [`HLP_FCMN_HASH_ENTRY_TO_MEM_WIDTH-1:0]   tom_hash_entry;// From u_fcmn_apr_func_logic of hlp_fcmn_apr_func_logic.v
logic [63:0] [`HLP_FCMN_HASH_ENTRY_FROM_MEM_WIDTH-1:0] frm_hash_entry; // fixed by mem_gen script
logic [8-1:0] [`HLP_FCMN_MAP_DOMAIN_TO_TCAM_WIDTH-1:0]   tom_map_domain;// From u_fcmn_apr_func_logic of hlp_fcmn_apr_func_logic.v
logic [8-1:0] [`HLP_FCMN_MAP_DOMAIN_FROM_TCAM_WIDTH-1:0] frm_map_domain; // fixed by mem_gen script
logic [2-1:0] [`HLP_FCMN_MAP_DSCP_TC_TO_MEM_WIDTH-1:0]   tom_map_dscp_tc;// From u_fcmn_apr_func_logic of hlp_fcmn_apr_func_logic.v
logic [2-1:0] [`HLP_FCMN_MAP_DSCP_TC_FROM_MEM_WIDTH-1:0] frm_map_dscp_tc; // fixed by mem_gen script
// End of automatics

/*
  hlp_fcmn_apr_sram_mems AUTO_TEMPLATE
  hlp_fcmn_apr_rf_mems AUTO_TEMPLATE
  hlp_fcmn_apr_tcam_mems AUTO_TEMPLATE
 (
  .fcmn_\(.*\)_\([0-9]+\)_from_mem (frm_\1[\2][]),
  .fcmn_\(.*\)_\([0-9]+\)_to_mem   (tom_\1[\2][]),
  .fcmn_\(.*\)_from_mem              (frm_\1[]),
  .fcmn_\(.*\)_to_mem                (tom_\1[]),
  .fcmn_\(.*\)_\([0-9]+\)_from_tcam (frm_\1[\2][]),
  .fcmn_\(.*\)_\([0-9]+\)_to_tcam   (tom_\1[\2][]),
  .fcmn_\(.*\)_from_tcam              (frm_\1[]),
  .fcmn_\(.*\)_to_tcam                (tom_\1[]),
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
logic fary_trigger_post_fcmn_sram, aary_post_complete_fcmn_sram, aary_post_pass_fcmn_sram;
ctech_lib_doublesync_rstb  #(.WIDTH(1))  u_trigger_post
  (.clk(clk), .rstb(local_broadcast.mem_rst_b), .d(fary_trigger_post), .o(fary_trigger_post_fcmn_sram));
hlp_fcmn_apr_sram_mems u_fcmn_apr_sram_mems
(// Manual connections
.fary_trigger_post_fcmn_sram,
.aary_post_complete_fcmn_sram,
.aary_post_pass_fcmn_sram,
 .aary_pwren_b_sram(aary_pwren_b_sram),
 /*AUTOINST*/
 // Outputs
 .aary_post_complete_sram               (),                      // Templated
 .aary_post_pass_sram                   (),                      // Templated
 .fcmn_domain_action0_from_mem          (frm_domain_action0[`HLP_FCMN_DOMAIN_ACTION0_FROM_MEM_WIDTH-1:0]), // Templated
 .fcmn_domain_action1_from_mem          (frm_domain_action1[`HLP_FCMN_DOMAIN_ACTION1_FROM_MEM_WIDTH-1:0]), // Templated
 .fcmn_ffu_tcam_swp_from_mem            (frm_ffu_tcam_swp[`HLP_FCMN_FFU_TCAM_SWP_FROM_MEM_WIDTH-1:0]), // Templated
 .fcmn_hash_entry_0_from_mem            (frm_hash_entry[0][`HLP_FCMN_HASH_ENTRY_FROM_MEM_WIDTH-1:0]), // Templated
 .fcmn_hash_entry_10_from_mem           (frm_hash_entry[10][`HLP_FCMN_HASH_ENTRY_FROM_MEM_WIDTH-1:0]), // Templated
 .fcmn_hash_entry_11_from_mem           (frm_hash_entry[11][`HLP_FCMN_HASH_ENTRY_FROM_MEM_WIDTH-1:0]), // Templated
 .fcmn_hash_entry_12_from_mem           (frm_hash_entry[12][`HLP_FCMN_HASH_ENTRY_FROM_MEM_WIDTH-1:0]), // Templated
 .fcmn_hash_entry_13_from_mem           (frm_hash_entry[13][`HLP_FCMN_HASH_ENTRY_FROM_MEM_WIDTH-1:0]), // Templated
 .fcmn_hash_entry_14_from_mem           (frm_hash_entry[14][`HLP_FCMN_HASH_ENTRY_FROM_MEM_WIDTH-1:0]), // Templated
 .fcmn_hash_entry_15_from_mem           (frm_hash_entry[15][`HLP_FCMN_HASH_ENTRY_FROM_MEM_WIDTH-1:0]), // Templated
 .fcmn_hash_entry_16_from_mem           (frm_hash_entry[16][`HLP_FCMN_HASH_ENTRY_FROM_MEM_WIDTH-1:0]), // Templated
 .fcmn_hash_entry_17_from_mem           (frm_hash_entry[17][`HLP_FCMN_HASH_ENTRY_FROM_MEM_WIDTH-1:0]), // Templated
 .fcmn_hash_entry_18_from_mem           (frm_hash_entry[18][`HLP_FCMN_HASH_ENTRY_FROM_MEM_WIDTH-1:0]), // Templated
 .fcmn_hash_entry_19_from_mem           (frm_hash_entry[19][`HLP_FCMN_HASH_ENTRY_FROM_MEM_WIDTH-1:0]), // Templated
 .fcmn_hash_entry_1_from_mem            (frm_hash_entry[1][`HLP_FCMN_HASH_ENTRY_FROM_MEM_WIDTH-1:0]), // Templated
 .fcmn_hash_entry_20_from_mem           (frm_hash_entry[20][`HLP_FCMN_HASH_ENTRY_FROM_MEM_WIDTH-1:0]), // Templated
 .fcmn_hash_entry_21_from_mem           (frm_hash_entry[21][`HLP_FCMN_HASH_ENTRY_FROM_MEM_WIDTH-1:0]), // Templated
 .fcmn_hash_entry_22_from_mem           (frm_hash_entry[22][`HLP_FCMN_HASH_ENTRY_FROM_MEM_WIDTH-1:0]), // Templated
 .fcmn_hash_entry_23_from_mem           (frm_hash_entry[23][`HLP_FCMN_HASH_ENTRY_FROM_MEM_WIDTH-1:0]), // Templated
 .fcmn_hash_entry_24_from_mem           (frm_hash_entry[24][`HLP_FCMN_HASH_ENTRY_FROM_MEM_WIDTH-1:0]), // Templated
 .fcmn_hash_entry_25_from_mem           (frm_hash_entry[25][`HLP_FCMN_HASH_ENTRY_FROM_MEM_WIDTH-1:0]), // Templated
 .fcmn_hash_entry_26_from_mem           (frm_hash_entry[26][`HLP_FCMN_HASH_ENTRY_FROM_MEM_WIDTH-1:0]), // Templated
 .fcmn_hash_entry_27_from_mem           (frm_hash_entry[27][`HLP_FCMN_HASH_ENTRY_FROM_MEM_WIDTH-1:0]), // Templated
 .fcmn_hash_entry_28_from_mem           (frm_hash_entry[28][`HLP_FCMN_HASH_ENTRY_FROM_MEM_WIDTH-1:0]), // Templated
 .fcmn_hash_entry_29_from_mem           (frm_hash_entry[29][`HLP_FCMN_HASH_ENTRY_FROM_MEM_WIDTH-1:0]), // Templated
 .fcmn_hash_entry_2_from_mem            (frm_hash_entry[2][`HLP_FCMN_HASH_ENTRY_FROM_MEM_WIDTH-1:0]), // Templated
 .fcmn_hash_entry_30_from_mem           (frm_hash_entry[30][`HLP_FCMN_HASH_ENTRY_FROM_MEM_WIDTH-1:0]), // Templated
 .fcmn_hash_entry_31_from_mem           (frm_hash_entry[31][`HLP_FCMN_HASH_ENTRY_FROM_MEM_WIDTH-1:0]), // Templated
 .fcmn_hash_entry_32_from_mem           (frm_hash_entry[32][`HLP_FCMN_HASH_ENTRY_FROM_MEM_WIDTH-1:0]), // Templated
 .fcmn_hash_entry_33_from_mem           (frm_hash_entry[33][`HLP_FCMN_HASH_ENTRY_FROM_MEM_WIDTH-1:0]), // Templated
 .fcmn_hash_entry_34_from_mem           (frm_hash_entry[34][`HLP_FCMN_HASH_ENTRY_FROM_MEM_WIDTH-1:0]), // Templated
 .fcmn_hash_entry_35_from_mem           (frm_hash_entry[35][`HLP_FCMN_HASH_ENTRY_FROM_MEM_WIDTH-1:0]), // Templated
 .fcmn_hash_entry_36_from_mem           (frm_hash_entry[36][`HLP_FCMN_HASH_ENTRY_FROM_MEM_WIDTH-1:0]), // Templated
 .fcmn_hash_entry_37_from_mem           (frm_hash_entry[37][`HLP_FCMN_HASH_ENTRY_FROM_MEM_WIDTH-1:0]), // Templated
 .fcmn_hash_entry_38_from_mem           (frm_hash_entry[38][`HLP_FCMN_HASH_ENTRY_FROM_MEM_WIDTH-1:0]), // Templated
 .fcmn_hash_entry_39_from_mem           (frm_hash_entry[39][`HLP_FCMN_HASH_ENTRY_FROM_MEM_WIDTH-1:0]), // Templated
 .fcmn_hash_entry_3_from_mem            (frm_hash_entry[3][`HLP_FCMN_HASH_ENTRY_FROM_MEM_WIDTH-1:0]), // Templated
 .fcmn_hash_entry_40_from_mem           (frm_hash_entry[40][`HLP_FCMN_HASH_ENTRY_FROM_MEM_WIDTH-1:0]), // Templated
 .fcmn_hash_entry_41_from_mem           (frm_hash_entry[41][`HLP_FCMN_HASH_ENTRY_FROM_MEM_WIDTH-1:0]), // Templated
 .fcmn_hash_entry_42_from_mem           (frm_hash_entry[42][`HLP_FCMN_HASH_ENTRY_FROM_MEM_WIDTH-1:0]), // Templated
 .fcmn_hash_entry_43_from_mem           (frm_hash_entry[43][`HLP_FCMN_HASH_ENTRY_FROM_MEM_WIDTH-1:0]), // Templated
 .fcmn_hash_entry_44_from_mem           (frm_hash_entry[44][`HLP_FCMN_HASH_ENTRY_FROM_MEM_WIDTH-1:0]), // Templated
 .fcmn_hash_entry_45_from_mem           (frm_hash_entry[45][`HLP_FCMN_HASH_ENTRY_FROM_MEM_WIDTH-1:0]), // Templated
 .fcmn_hash_entry_46_from_mem           (frm_hash_entry[46][`HLP_FCMN_HASH_ENTRY_FROM_MEM_WIDTH-1:0]), // Templated
 .fcmn_hash_entry_47_from_mem           (frm_hash_entry[47][`HLP_FCMN_HASH_ENTRY_FROM_MEM_WIDTH-1:0]), // Templated
 .fcmn_hash_entry_48_from_mem           (frm_hash_entry[48][`HLP_FCMN_HASH_ENTRY_FROM_MEM_WIDTH-1:0]), // Templated
 .fcmn_hash_entry_49_from_mem           (frm_hash_entry[49][`HLP_FCMN_HASH_ENTRY_FROM_MEM_WIDTH-1:0]), // Templated
 .fcmn_hash_entry_4_from_mem            (frm_hash_entry[4][`HLP_FCMN_HASH_ENTRY_FROM_MEM_WIDTH-1:0]), // Templated
 .fcmn_hash_entry_50_from_mem           (frm_hash_entry[50][`HLP_FCMN_HASH_ENTRY_FROM_MEM_WIDTH-1:0]), // Templated
 .fcmn_hash_entry_51_from_mem           (frm_hash_entry[51][`HLP_FCMN_HASH_ENTRY_FROM_MEM_WIDTH-1:0]), // Templated
 .fcmn_hash_entry_52_from_mem           (frm_hash_entry[52][`HLP_FCMN_HASH_ENTRY_FROM_MEM_WIDTH-1:0]), // Templated
 .fcmn_hash_entry_53_from_mem           (frm_hash_entry[53][`HLP_FCMN_HASH_ENTRY_FROM_MEM_WIDTH-1:0]), // Templated
 .fcmn_hash_entry_54_from_mem           (frm_hash_entry[54][`HLP_FCMN_HASH_ENTRY_FROM_MEM_WIDTH-1:0]), // Templated
 .fcmn_hash_entry_55_from_mem           (frm_hash_entry[55][`HLP_FCMN_HASH_ENTRY_FROM_MEM_WIDTH-1:0]), // Templated
 .fcmn_hash_entry_56_from_mem           (frm_hash_entry[56][`HLP_FCMN_HASH_ENTRY_FROM_MEM_WIDTH-1:0]), // Templated
 .fcmn_hash_entry_57_from_mem           (frm_hash_entry[57][`HLP_FCMN_HASH_ENTRY_FROM_MEM_WIDTH-1:0]), // Templated
 .fcmn_hash_entry_58_from_mem           (frm_hash_entry[58][`HLP_FCMN_HASH_ENTRY_FROM_MEM_WIDTH-1:0]), // Templated
 .fcmn_hash_entry_59_from_mem           (frm_hash_entry[59][`HLP_FCMN_HASH_ENTRY_FROM_MEM_WIDTH-1:0]), // Templated
 .fcmn_hash_entry_5_from_mem            (frm_hash_entry[5][`HLP_FCMN_HASH_ENTRY_FROM_MEM_WIDTH-1:0]), // Templated
 .fcmn_hash_entry_60_from_mem           (frm_hash_entry[60][`HLP_FCMN_HASH_ENTRY_FROM_MEM_WIDTH-1:0]), // Templated
 .fcmn_hash_entry_61_from_mem           (frm_hash_entry[61][`HLP_FCMN_HASH_ENTRY_FROM_MEM_WIDTH-1:0]), // Templated
 .fcmn_hash_entry_62_from_mem           (frm_hash_entry[62][`HLP_FCMN_HASH_ENTRY_FROM_MEM_WIDTH-1:0]), // Templated
 .fcmn_hash_entry_63_from_mem           (frm_hash_entry[63][`HLP_FCMN_HASH_ENTRY_FROM_MEM_WIDTH-1:0]), // Templated
 .fcmn_hash_entry_6_from_mem            (frm_hash_entry[6][`HLP_FCMN_HASH_ENTRY_FROM_MEM_WIDTH-1:0]), // Templated
 .fcmn_hash_entry_7_from_mem            (frm_hash_entry[7][`HLP_FCMN_HASH_ENTRY_FROM_MEM_WIDTH-1:0]), // Templated
 .fcmn_hash_entry_8_from_mem            (frm_hash_entry[8][`HLP_FCMN_HASH_ENTRY_FROM_MEM_WIDTH-1:0]), // Templated
 .fcmn_hash_entry_9_from_mem            (frm_hash_entry[9][`HLP_FCMN_HASH_ENTRY_FROM_MEM_WIDTH-1:0]), // Templated
 // Inputs
 .DFTMASK                               (DFTMASK),
 .DFTSHIFTEN                            (DFTSHIFTEN),
 .DFT_AFD_RESET_B                       (DFT_AFD_RESET_B),
 .DFT_ARRAY_FREEZE                      (DFT_ARRAY_FREEZE),
 .clk                                   (clk),
 .fary_ffuse_hdusplr_trim               (fary_ffuse_hdusplr_trim[17-1:0]),
 .fary_ffuse_hduspsr_trim               (fary_ffuse_hduspsr_trim[17-1:0]),
 .fary_ffuse_sram_sleep                 (fary_ffuse_sram_sleep[1:0]),
 .fary_isolation_control_in             (isol_en_b),             // Templated
 .fary_output_reset                     (fary_output_reset),
 .fary_pwren_b_sram                     (fet_ack_b_from_fl),     // Templated
 .fary_trigger_post_sram                ('0),                    // Templated
 .fcmn_domain_action0_to_mem            (tom_domain_action0[`HLP_FCMN_DOMAIN_ACTION0_TO_MEM_WIDTH-1:0]), // Templated
 .fcmn_domain_action1_to_mem            (tom_domain_action1[`HLP_FCMN_DOMAIN_ACTION1_TO_MEM_WIDTH-1:0]), // Templated
 .fcmn_ffu_tcam_swp_to_mem              (tom_ffu_tcam_swp[`HLP_FCMN_FFU_TCAM_SWP_TO_MEM_WIDTH-1:0]), // Templated
 .fcmn_hash_entry_0_to_mem              (tom_hash_entry[0][`HLP_FCMN_HASH_ENTRY_TO_MEM_WIDTH-1:0]), // Templated
 .fcmn_hash_entry_10_to_mem             (tom_hash_entry[10][`HLP_FCMN_HASH_ENTRY_TO_MEM_WIDTH-1:0]), // Templated
 .fcmn_hash_entry_11_to_mem             (tom_hash_entry[11][`HLP_FCMN_HASH_ENTRY_TO_MEM_WIDTH-1:0]), // Templated
 .fcmn_hash_entry_12_to_mem             (tom_hash_entry[12][`HLP_FCMN_HASH_ENTRY_TO_MEM_WIDTH-1:0]), // Templated
 .fcmn_hash_entry_13_to_mem             (tom_hash_entry[13][`HLP_FCMN_HASH_ENTRY_TO_MEM_WIDTH-1:0]), // Templated
 .fcmn_hash_entry_14_to_mem             (tom_hash_entry[14][`HLP_FCMN_HASH_ENTRY_TO_MEM_WIDTH-1:0]), // Templated
 .fcmn_hash_entry_15_to_mem             (tom_hash_entry[15][`HLP_FCMN_HASH_ENTRY_TO_MEM_WIDTH-1:0]), // Templated
 .fcmn_hash_entry_16_to_mem             (tom_hash_entry[16][`HLP_FCMN_HASH_ENTRY_TO_MEM_WIDTH-1:0]), // Templated
 .fcmn_hash_entry_17_to_mem             (tom_hash_entry[17][`HLP_FCMN_HASH_ENTRY_TO_MEM_WIDTH-1:0]), // Templated
 .fcmn_hash_entry_18_to_mem             (tom_hash_entry[18][`HLP_FCMN_HASH_ENTRY_TO_MEM_WIDTH-1:0]), // Templated
 .fcmn_hash_entry_19_to_mem             (tom_hash_entry[19][`HLP_FCMN_HASH_ENTRY_TO_MEM_WIDTH-1:0]), // Templated
 .fcmn_hash_entry_1_to_mem              (tom_hash_entry[1][`HLP_FCMN_HASH_ENTRY_TO_MEM_WIDTH-1:0]), // Templated
 .fcmn_hash_entry_20_to_mem             (tom_hash_entry[20][`HLP_FCMN_HASH_ENTRY_TO_MEM_WIDTH-1:0]), // Templated
 .fcmn_hash_entry_21_to_mem             (tom_hash_entry[21][`HLP_FCMN_HASH_ENTRY_TO_MEM_WIDTH-1:0]), // Templated
 .fcmn_hash_entry_22_to_mem             (tom_hash_entry[22][`HLP_FCMN_HASH_ENTRY_TO_MEM_WIDTH-1:0]), // Templated
 .fcmn_hash_entry_23_to_mem             (tom_hash_entry[23][`HLP_FCMN_HASH_ENTRY_TO_MEM_WIDTH-1:0]), // Templated
 .fcmn_hash_entry_24_to_mem             (tom_hash_entry[24][`HLP_FCMN_HASH_ENTRY_TO_MEM_WIDTH-1:0]), // Templated
 .fcmn_hash_entry_25_to_mem             (tom_hash_entry[25][`HLP_FCMN_HASH_ENTRY_TO_MEM_WIDTH-1:0]), // Templated
 .fcmn_hash_entry_26_to_mem             (tom_hash_entry[26][`HLP_FCMN_HASH_ENTRY_TO_MEM_WIDTH-1:0]), // Templated
 .fcmn_hash_entry_27_to_mem             (tom_hash_entry[27][`HLP_FCMN_HASH_ENTRY_TO_MEM_WIDTH-1:0]), // Templated
 .fcmn_hash_entry_28_to_mem             (tom_hash_entry[28][`HLP_FCMN_HASH_ENTRY_TO_MEM_WIDTH-1:0]), // Templated
 .fcmn_hash_entry_29_to_mem             (tom_hash_entry[29][`HLP_FCMN_HASH_ENTRY_TO_MEM_WIDTH-1:0]), // Templated
 .fcmn_hash_entry_2_to_mem              (tom_hash_entry[2][`HLP_FCMN_HASH_ENTRY_TO_MEM_WIDTH-1:0]), // Templated
 .fcmn_hash_entry_30_to_mem             (tom_hash_entry[30][`HLP_FCMN_HASH_ENTRY_TO_MEM_WIDTH-1:0]), // Templated
 .fcmn_hash_entry_31_to_mem             (tom_hash_entry[31][`HLP_FCMN_HASH_ENTRY_TO_MEM_WIDTH-1:0]), // Templated
 .fcmn_hash_entry_32_to_mem             (tom_hash_entry[32][`HLP_FCMN_HASH_ENTRY_TO_MEM_WIDTH-1:0]), // Templated
 .fcmn_hash_entry_33_to_mem             (tom_hash_entry[33][`HLP_FCMN_HASH_ENTRY_TO_MEM_WIDTH-1:0]), // Templated
 .fcmn_hash_entry_34_to_mem             (tom_hash_entry[34][`HLP_FCMN_HASH_ENTRY_TO_MEM_WIDTH-1:0]), // Templated
 .fcmn_hash_entry_35_to_mem             (tom_hash_entry[35][`HLP_FCMN_HASH_ENTRY_TO_MEM_WIDTH-1:0]), // Templated
 .fcmn_hash_entry_36_to_mem             (tom_hash_entry[36][`HLP_FCMN_HASH_ENTRY_TO_MEM_WIDTH-1:0]), // Templated
 .fcmn_hash_entry_37_to_mem             (tom_hash_entry[37][`HLP_FCMN_HASH_ENTRY_TO_MEM_WIDTH-1:0]), // Templated
 .fcmn_hash_entry_38_to_mem             (tom_hash_entry[38][`HLP_FCMN_HASH_ENTRY_TO_MEM_WIDTH-1:0]), // Templated
 .fcmn_hash_entry_39_to_mem             (tom_hash_entry[39][`HLP_FCMN_HASH_ENTRY_TO_MEM_WIDTH-1:0]), // Templated
 .fcmn_hash_entry_3_to_mem              (tom_hash_entry[3][`HLP_FCMN_HASH_ENTRY_TO_MEM_WIDTH-1:0]), // Templated
 .fcmn_hash_entry_40_to_mem             (tom_hash_entry[40][`HLP_FCMN_HASH_ENTRY_TO_MEM_WIDTH-1:0]), // Templated
 .fcmn_hash_entry_41_to_mem             (tom_hash_entry[41][`HLP_FCMN_HASH_ENTRY_TO_MEM_WIDTH-1:0]), // Templated
 .fcmn_hash_entry_42_to_mem             (tom_hash_entry[42][`HLP_FCMN_HASH_ENTRY_TO_MEM_WIDTH-1:0]), // Templated
 .fcmn_hash_entry_43_to_mem             (tom_hash_entry[43][`HLP_FCMN_HASH_ENTRY_TO_MEM_WIDTH-1:0]), // Templated
 .fcmn_hash_entry_44_to_mem             (tom_hash_entry[44][`HLP_FCMN_HASH_ENTRY_TO_MEM_WIDTH-1:0]), // Templated
 .fcmn_hash_entry_45_to_mem             (tom_hash_entry[45][`HLP_FCMN_HASH_ENTRY_TO_MEM_WIDTH-1:0]), // Templated
 .fcmn_hash_entry_46_to_mem             (tom_hash_entry[46][`HLP_FCMN_HASH_ENTRY_TO_MEM_WIDTH-1:0]), // Templated
 .fcmn_hash_entry_47_to_mem             (tom_hash_entry[47][`HLP_FCMN_HASH_ENTRY_TO_MEM_WIDTH-1:0]), // Templated
 .fcmn_hash_entry_48_to_mem             (tom_hash_entry[48][`HLP_FCMN_HASH_ENTRY_TO_MEM_WIDTH-1:0]), // Templated
 .fcmn_hash_entry_49_to_mem             (tom_hash_entry[49][`HLP_FCMN_HASH_ENTRY_TO_MEM_WIDTH-1:0]), // Templated
 .fcmn_hash_entry_4_to_mem              (tom_hash_entry[4][`HLP_FCMN_HASH_ENTRY_TO_MEM_WIDTH-1:0]), // Templated
 .fcmn_hash_entry_50_to_mem             (tom_hash_entry[50][`HLP_FCMN_HASH_ENTRY_TO_MEM_WIDTH-1:0]), // Templated
 .fcmn_hash_entry_51_to_mem             (tom_hash_entry[51][`HLP_FCMN_HASH_ENTRY_TO_MEM_WIDTH-1:0]), // Templated
 .fcmn_hash_entry_52_to_mem             (tom_hash_entry[52][`HLP_FCMN_HASH_ENTRY_TO_MEM_WIDTH-1:0]), // Templated
 .fcmn_hash_entry_53_to_mem             (tom_hash_entry[53][`HLP_FCMN_HASH_ENTRY_TO_MEM_WIDTH-1:0]), // Templated
 .fcmn_hash_entry_54_to_mem             (tom_hash_entry[54][`HLP_FCMN_HASH_ENTRY_TO_MEM_WIDTH-1:0]), // Templated
 .fcmn_hash_entry_55_to_mem             (tom_hash_entry[55][`HLP_FCMN_HASH_ENTRY_TO_MEM_WIDTH-1:0]), // Templated
 .fcmn_hash_entry_56_to_mem             (tom_hash_entry[56][`HLP_FCMN_HASH_ENTRY_TO_MEM_WIDTH-1:0]), // Templated
 .fcmn_hash_entry_57_to_mem             (tom_hash_entry[57][`HLP_FCMN_HASH_ENTRY_TO_MEM_WIDTH-1:0]), // Templated
 .fcmn_hash_entry_58_to_mem             (tom_hash_entry[58][`HLP_FCMN_HASH_ENTRY_TO_MEM_WIDTH-1:0]), // Templated
 .fcmn_hash_entry_59_to_mem             (tom_hash_entry[59][`HLP_FCMN_HASH_ENTRY_TO_MEM_WIDTH-1:0]), // Templated
 .fcmn_hash_entry_5_to_mem              (tom_hash_entry[5][`HLP_FCMN_HASH_ENTRY_TO_MEM_WIDTH-1:0]), // Templated
 .fcmn_hash_entry_60_to_mem             (tom_hash_entry[60][`HLP_FCMN_HASH_ENTRY_TO_MEM_WIDTH-1:0]), // Templated
 .fcmn_hash_entry_61_to_mem             (tom_hash_entry[61][`HLP_FCMN_HASH_ENTRY_TO_MEM_WIDTH-1:0]), // Templated
 .fcmn_hash_entry_62_to_mem             (tom_hash_entry[62][`HLP_FCMN_HASH_ENTRY_TO_MEM_WIDTH-1:0]), // Templated
 .fcmn_hash_entry_63_to_mem             (tom_hash_entry[63][`HLP_FCMN_HASH_ENTRY_TO_MEM_WIDTH-1:0]), // Templated
 .fcmn_hash_entry_6_to_mem              (tom_hash_entry[6][`HLP_FCMN_HASH_ENTRY_TO_MEM_WIDTH-1:0]), // Templated
 .fcmn_hash_entry_7_to_mem              (tom_hash_entry[7][`HLP_FCMN_HASH_ENTRY_TO_MEM_WIDTH-1:0]), // Templated
 .fcmn_hash_entry_8_to_mem              (tom_hash_entry[8][`HLP_FCMN_HASH_ENTRY_TO_MEM_WIDTH-1:0]), // Templated
 .fcmn_hash_entry_9_to_mem              (tom_hash_entry[9][`HLP_FCMN_HASH_ENTRY_TO_MEM_WIDTH-1:0]), // Templated
 .fscan_clkungate                       (fscan_clkungate),
 .fscan_ram_bypsel_sram                 (fscan_ram_bypsel_sram),
 .fscan_ram_init_en                     (fscan_ram_init_en),
 .fscan_ram_init_val                    (fscan_ram_init_val),
 .fscan_ram_rdis_b                      (fscan_ram_rdis_b),
 .fscan_ram_wdis_b                      (fscan_ram_wdis_b),
 .fsta_dfxact_afd                       (fsta_dfxact_afd),
 .ip_reset_b                            (local_broadcast.mem_rst_b), // Templated
 .post_mux_ctrl                         ('0),                    // Templated
 .pwr_mgmt_in_sram                      (pwr_mgmt_in_sram[6-1:0]), .bisr_clk_pd_vinf(pd_vinf_bisr_clk), 
 .bisr_shift_en_pd_vinf(pd_vinf_bisr_shift_en), .bisr_reset_pd_vinf(pd_vinf_bisr_reset), 
 .bisr_si_pd_vinf(bisr_so_pd_vinf_ts2), .bisr_so_pd_vinf(bisr_so_pd_vinf), .fary_ijtag_tck(JT_IN_mbist_ijtag_tck), 
 .fary_ijtag_rst_b(JT_IN_mbist_ijtag_reset_b), .mbist_diag_done(mbist_diag_done_ts2), 
 .fary_ijtag_select(sib_fcmn_apr_sram_to_select), .fary_ijtag_shift(JT_IN_mbist_ijtag_shift), 
 .fary_ijtag_capture(JT_IN_mbist_ijtag_capture), .fary_ijtag_update(JT_IN_mbist_ijtag_update), 
 .fary_ijtag_si(sib_fcmn_apr_tcam_so), .aary_ijtag_so(u_fcmn_apr_sram_mems_so), 
 .fscan_byprst_b(fscan_byprst_b), .fscan_clkgenctrl(fscan_clkgenctrl_ts1), 
 .fscan_clkgenctrlen(fscan_clkgenctrlen_ts1), .fscan_clkungate_syn(fscan_clkungate_syn), 
 .fscan_latchclosed_b(fscan_latchclosed_b), .fscan_latchopen(fscan_latchopen), 
 .fscan_mode(fscan_mode), .fscan_mode_atspeed(fscan_mode_atspeed), 
 .fscan_ram_bypsel_rf(fscan_ram_bypsel_rf), .fscan_ram_bypsel_tcam(fscan_ram_bypsel_tcam), 
 .fscan_ret_ctrl(fscan_ret_ctrl), .fscan_rstbypen(fscan_rstbypen), 
 .fscan_shiften(fscan_shiften), .clk_rscclk(clkout));

logic aary_pwren_b_rf;
logic fary_trigger_post_fcmn_rf, aary_post_complete_fcmn_rf, aary_post_pass_fcmn_rf;
assign fary_trigger_post_fcmn_rf = aary_post_complete_fcmn_sram;
assign aary_post_complete = aary_post_complete_fcmn_rf;
assign aary_post_pass = aary_post_pass_fcmn_sram & aary_post_pass_fcmn_rf;
hlp_fcmn_apr_rf_mems u_fcmn_apr_rf_mems
(// Manual connections
.fary_trigger_post_fcmn_rf,
.aary_post_complete_fcmn_rf,
.aary_post_pass_fcmn_rf,
 .fary_pwren_b_rf(aary_pwren_b_sram),
 .aary_pwren_b_rf(aary_pwren_b_rf),
 /*AUTOINST*/
 // Outputs
 .aary_post_complete_rf                 (),                      // Templated
 .aary_post_pass_rf                     (),                      // Templated
 .fcmn_map_dscp_tc_0_from_mem           (frm_map_dscp_tc[0][`HLP_FCMN_MAP_DSCP_TC_FROM_MEM_WIDTH-1:0]), // Templated
 .fcmn_map_dscp_tc_1_from_mem           (frm_map_dscp_tc[1][`HLP_FCMN_MAP_DSCP_TC_FROM_MEM_WIDTH-1:0]), // Templated
 // Inputs
 .DFTMASK                               (DFTMASK),
 .DFTSHIFTEN                            (DFTSHIFTEN),
 .DFT_AFD_RESET_B                       (DFT_AFD_RESET_B),
 .DFT_ARRAY_FREEZE                      (DFT_ARRAY_FREEZE),
 .clk                                   (clk),
 .fary_ffuse_hd2prf_trim                (fary_ffuse_hd2prf_trim[7-1:0]),
 .fary_ffuse_rf_sleep                   (fary_ffuse_rf_sleep[1:0]),
 .fary_isolation_control_in             (isol_en_b),             // Templated
 .fary_output_reset                     (fary_output_reset),
 .fary_trigger_post_rf                  ('0),                    // Templated
 .fcmn_map_dscp_tc_0_to_mem             (tom_map_dscp_tc[0][`HLP_FCMN_MAP_DSCP_TC_TO_MEM_WIDTH-1:0]), // Templated
 .fcmn_map_dscp_tc_1_to_mem             (tom_map_dscp_tc[1][`HLP_FCMN_MAP_DSCP_TC_TO_MEM_WIDTH-1:0]), // Templated
 .fscan_clkungate                       (fscan_clkungate),
 .fscan_ram_bypsel_rf                   (fscan_ram_bypsel_rf),
 .fscan_ram_init_en                     (fscan_ram_init_en),
 .fscan_ram_init_val                    (fscan_ram_init_val),
 .fscan_ram_rdis_b                      (fscan_ram_rdis_b),
 .fscan_ram_wdis_b                      (fscan_ram_wdis_b),
 .fsta_dfxact_afd                       (fsta_dfxact_afd),
 .ip_reset_b                            (local_broadcast.mem_rst_b), // Templated
 .post_mux_ctrl                         ('0),                    // Templated
 .pwr_mgmt_in_rf                        (pwr_mgmt_in_rf[5-1:0]), .bisr_clk_pd_vinf(pd_vinf_bisr_clk), 
 .bisr_shift_en_pd_vinf(pd_vinf_bisr_shift_en), .bisr_reset_pd_vinf(pd_vinf_bisr_reset), 
 .bisr_si_pd_vinf(bisr_so_pd_vinf), .bisr_so_pd_vinf(bisr_so_pd_vinf_ts1), .fary_ijtag_tck(JT_IN_mbist_ijtag_tck), 
 .fary_ijtag_rst_b(JT_IN_mbist_ijtag_reset_b), .mbist_diag_done(mbist_diag_done_ts1), 
 .fary_ijtag_select(sib_fcmn_apr_rf_to_select), .fary_ijtag_shift(JT_IN_mbist_ijtag_shift), 
 .fary_ijtag_capture(JT_IN_mbist_ijtag_capture), .fary_ijtag_update(JT_IN_mbist_ijtag_update), 
 .fary_ijtag_si(sib_fcmn_apr_sram_so), .aary_ijtag_so(u_fcmn_apr_rf_mems_so), 
 .fscan_byprst_b(fscan_byprst_b), .fscan_clkgenctrl(fscan_clkgenctrl_ts1), 
 .fscan_clkgenctrlen(fscan_clkgenctrlen_ts1), .fscan_clkungate_syn(fscan_clkungate_syn), 
 .fscan_latchclosed_b(fscan_latchclosed_b), .fscan_latchopen(fscan_latchopen), 
 .fscan_mode(fscan_mode), .fscan_mode_atspeed(fscan_mode_atspeed), 
 .fscan_ram_bypsel_sram(fscan_ram_bypsel_sram), .fscan_ram_bypsel_tcam(fscan_ram_bypsel_tcam), 
 .fscan_ret_ctrl(fscan_ret_ctrl), .fscan_rstbypen(fscan_rstbypen), 
 .fscan_shiften(fscan_shiften), .clk_rscclk(clkout));

logic aary_pwren_b_tcam;
hlp_fcmn_apr_tcam_mems u_fcmn_apr_tcam_mems
(// Manual connections
`ifdef HLP_FPGA_TCAM_MEMS
 .fpga_fast_clk(),
`endif
.fary_pwren_b_tcam(aary_pwren_b_rf),
 .aary_pwren_b_tcam(aary_pwren_b_tcam),
 /*AUTOINST*/
 // Outputs
 .fcmn_map_domain_0_from_tcam           (frm_map_domain[0][`HLP_FCMN_MAP_DOMAIN_FROM_TCAM_WIDTH-1:0]), // Templated
 .fcmn_map_domain_1_from_tcam           (frm_map_domain[1][`HLP_FCMN_MAP_DOMAIN_FROM_TCAM_WIDTH-1:0]), // Templated
 .fcmn_map_domain_2_from_tcam           (frm_map_domain[2][`HLP_FCMN_MAP_DOMAIN_FROM_TCAM_WIDTH-1:0]), // Templated
 .fcmn_map_domain_3_from_tcam           (frm_map_domain[3][`HLP_FCMN_MAP_DOMAIN_FROM_TCAM_WIDTH-1:0]), // Templated
 .fcmn_map_domain_4_from_tcam           (frm_map_domain[4][`HLP_FCMN_MAP_DOMAIN_FROM_TCAM_WIDTH-1:0]), // Templated
 .fcmn_map_domain_5_from_tcam           (frm_map_domain[5][`HLP_FCMN_MAP_DOMAIN_FROM_TCAM_WIDTH-1:0]), // Templated
 .fcmn_map_domain_6_from_tcam           (frm_map_domain[6][`HLP_FCMN_MAP_DOMAIN_FROM_TCAM_WIDTH-1:0]), // Templated
 .fcmn_map_domain_7_from_tcam           (frm_map_domain[7][`HLP_FCMN_MAP_DOMAIN_FROM_TCAM_WIDTH-1:0]), // Templated
 // Inputs
 .DFTMASK                               (DFTMASK),
 .DFTSHIFTEN                            (DFTSHIFTEN),
 .DFT_AFD_RESET_B                       (DFT_AFD_RESET_B),
 .DFT_ARRAY_FREEZE                      (DFT_ARRAY_FREEZE),
 .clk                                   (clk),
 .fary_ffuse_tcam_sleep                 (fary_ffuse_tcam_sleep),
 .fary_ffuse_tune_tcam                  (fary_ffuse_tune_tcam[15:0]),
 .fary_isolation_control_in             (isol_en_b),             // Templated
 .fary_output_reset                     (fary_output_reset),
 .fcmn_map_domain_0_to_tcam             (tom_map_domain[0][`HLP_FCMN_MAP_DOMAIN_TO_TCAM_WIDTH-1:0]), // Templated
 .fcmn_map_domain_1_to_tcam             (tom_map_domain[1][`HLP_FCMN_MAP_DOMAIN_TO_TCAM_WIDTH-1:0]), // Templated
 .fcmn_map_domain_2_to_tcam             (tom_map_domain[2][`HLP_FCMN_MAP_DOMAIN_TO_TCAM_WIDTH-1:0]), // Templated
 .fcmn_map_domain_3_to_tcam             (tom_map_domain[3][`HLP_FCMN_MAP_DOMAIN_TO_TCAM_WIDTH-1:0]), // Templated
 .fcmn_map_domain_4_to_tcam             (tom_map_domain[4][`HLP_FCMN_MAP_DOMAIN_TO_TCAM_WIDTH-1:0]), // Templated
 .fcmn_map_domain_5_to_tcam             (tom_map_domain[5][`HLP_FCMN_MAP_DOMAIN_TO_TCAM_WIDTH-1:0]), // Templated
 .fcmn_map_domain_6_to_tcam             (tom_map_domain[6][`HLP_FCMN_MAP_DOMAIN_TO_TCAM_WIDTH-1:0]), // Templated
 .fcmn_map_domain_7_to_tcam             (tom_map_domain[7][`HLP_FCMN_MAP_DOMAIN_TO_TCAM_WIDTH-1:0]), // Templated
 .fscan_clkungate                       (fscan_clkungate),
 .fscan_mode                            (fscan_mode),
 .fscan_ram_bypsel_tcam                 (fscan_ram_bypsel_tcam),
 .fscan_ram_init_en                     (fscan_ram_init_en),
 .fscan_ram_init_val                    (fscan_ram_init_val),
 .fscan_ram_rdis_b                      (fscan_ram_rdis_b),
 .fscan_ram_wdis_b                      (fscan_ram_wdis_b),
 .fscan_shiften                         (fscan_shiften),
 .fsta_dfxact_afd                       (fsta_dfxact_afd),
 .ip_reset_b                            (local_broadcast.mem_rst_b), .bisr_clk_pd_vinf(pd_vinf_bisr_clk), 
 .bisr_shift_en_pd_vinf(pd_vinf_bisr_shift_en), .bisr_reset_pd_vinf(pd_vinf_bisr_reset), 
 .bisr_si_pd_vinf(pd_vinf_bisr_si), .bisr_so_pd_vinf(bisr_so_pd_vinf_ts2), .fary_ijtag_tck(JT_IN_mbist_ijtag_tck), 
 .fary_ijtag_rst_b(JT_IN_mbist_ijtag_reset_b), .mbist_diag_done(mbist_diag_done_ts3), 
 .fary_ijtag_select(sib_fcmn_apr_tcam_to_select), .fary_ijtag_shift(JT_IN_mbist_ijtag_shift), 
 .fary_ijtag_capture(JT_IN_mbist_ijtag_capture), .fary_ijtag_update(JT_IN_mbist_ijtag_update), 
 .fary_ijtag_si(sib_mbist_fgrp_0_so), .aary_ijtag_so(u_fcmn_apr_tcam_mems_so), 
 .fscan_byprst_b(fscan_byprst_b), .fscan_clkgenctrl(fscan_clkgenctrl_ts1), 
 .fscan_clkgenctrlen(fscan_clkgenctrlen_ts1), .fscan_clkungate_syn(fscan_clkungate_syn), 
 .fscan_latchclosed_b(fscan_latchclosed_b), .fscan_latchopen(fscan_latchopen), 
 .fscan_mode_atspeed(fscan_mode_atspeed), .fscan_ram_bypsel_rf(fscan_ram_bypsel_rf), 
 .fscan_ram_bypsel_sram(fscan_ram_bypsel_sram), .fscan_ret_ctrl(fscan_ret_ctrl), 
 .fscan_rstbypen(fscan_rstbypen), .clk_rscclk(clkout)); // Templated

assign fet_ack_b = aary_pwren_b_tcam;
/*
 hlp_fcmn_apr_func_logic AUTO_TEMPLATE
 ( .o_tom_\(.*\) (tom_\1[][]),
   .i_frm_\(.*\) (frm_\1[][]),
   .mem_rst_n (local_broadcast.mem_rst_b),
   .o_post_cntrlr_select_sram (post_cntrlr_select_sram_from_apr),
   .i_trigger_post_sram  (trigger_post_to_apr),
   .i_post_complete_sram (post_complete_to_apr),
   .i_post_pass_sram     (post_pass_to_apr),
   .i_broadcast  (local_broadcast) );
*/
hlp_fcmn_apr_func_logic u_fcmn_apr_func_logic
( .fet_ack_b(fet_ack_b_from_fl),
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
 .ascan_sdo                             (ascan_sdo[hlp_dfx_pkg::FCMN_NUM_SDO-1:0]),
 .o_data                                (o_data[3:0]),
 .o_data_v                              (o_data_v[3:0]),
 .o_ffu_to_fwd                          (o_ffu_to_fwd),
 .o_ffu_to_fwd_v                        (o_ffu_to_fwd_v),
 .o_grp                                 (o_grp),
 .o_grp_nr                              (o_grp_nr[2:0]),
 .o_grp_v                               (o_grp_v),
 .o_hlp_dts_diode0_anode                (o_hlp_dts_diode0_anode),
 .o_hlp_dts_diode0_cathode              (o_hlp_dts_diode0_cathode),
 .o_rpl_bkwd                            (o_rpl_bkwd),
 .o_rpl_frwd                            (o_rpl_frwd),
 .o_tof_mgmt                            (o_tof_mgmt),
 .o_tof_mgmt_v                          (o_tof_mgmt_v),
 .o_tom_domain_action0                  (tom_domain_action0[`HLP_FCMN_DOMAIN_ACTION0_TO_MEM_WIDTH-1:0]), // Templated
 .o_tom_domain_action1                  (tom_domain_action1[`HLP_FCMN_DOMAIN_ACTION1_TO_MEM_WIDTH-1:0]), // Templated
 .o_tom_ffu_tcam_swp                    (tom_ffu_tcam_swp[`HLP_FCMN_FFU_TCAM_SWP_TO_MEM_WIDTH-1:0]), // Templated
 .o_tom_hash_entry                      (tom_hash_entry/*[63:0][`HLP_FCMN_HASH_ENTRY_TO_MEM_WIDTH-1:0]*/), // Templated
 .o_tom_map_domain                      (tom_map_domain/*[8-1:0][`HLP_FCMN_MAP_DOMAIN_TO_TCAM_WIDTH-1:0]*/), // Templated
 .o_tom_map_dscp_tc                     (tom_map_dscp_tc/*[2-1:0][`HLP_FCMN_MAP_DSCP_TC_TO_MEM_WIDTH-1:0]*/), // Templated
 .o_ton_mgmt                            (o_ton_mgmt),
 .o_ton_mgmt_v                          (o_ton_mgmt_v),
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
 .fscan_clkgenctrl                      (fscan_clkgenctrl[hlp_dfx_pkg::FCMN_NUM_CLKGENCTRL-1:0]),
 .fscan_clkgenctrlen                    (fscan_clkgenctrlen[hlp_dfx_pkg::FCMN_NUM_CLKGENCTRLEN-1:0]),
 .fscan_sdi                             (fscan_sdi[hlp_dfx_pkg::FCMN_NUM_SDI-1:0]),
 .clk                                   (clk),
 .fscan_byprst_b                        (fscan_byprst_b),
 .fscan_rstbypen                        (fscan_rstbypen),
 .i_broadcast                           (local_broadcast),       // Templated
 .i_fghash_ecc_int                      (i_fghash_ecc_int[2:0]),
 .i_fgrp_ecc_int                        (i_fgrp_ecc_int[2:0]),
 .i_fgrp_mem_init_done                  (i_fgrp_mem_init_done[2:0]),
 .i_frf_mgmt                            (i_frf_mgmt),
 .i_frf_mgmt_v                          (i_frf_mgmt_v),
 .i_frm_domain_action0                  (frm_domain_action0[`HLP_FCMN_DOMAIN_ACTION0_FROM_MEM_WIDTH-1:0]), // Templated
 .i_frm_domain_action1                  (frm_domain_action1[`HLP_FCMN_DOMAIN_ACTION1_FROM_MEM_WIDTH-1:0]), // Templated
 .i_frm_ffu_tcam_swp                    (frm_ffu_tcam_swp[`HLP_FCMN_FFU_TCAM_SWP_FROM_MEM_WIDTH-1:0]), // Templated
 .i_frm_hash_entry                      (frm_hash_entry/*[63:0][`HLP_FCMN_HASH_ENTRY_FROM_MEM_WIDTH-1:0]*/), // Templated
 .i_frm_map_domain                      (frm_map_domain/*[8-1:0][`HLP_FCMN_MAP_DOMAIN_FROM_TCAM_WIDTH-1:0]*/), // Templated
 .i_frm_map_dscp_tc                     (frm_map_dscp_tc/*[2-1:0][`HLP_FCMN_MAP_DSCP_TC_FROM_MEM_WIDTH-1:0]*/), // Templated
 .i_frn_mgmt                            (i_frn_mgmt),
 .i_frn_mgmt_v                          (i_frn_mgmt_v),
 .i_grp                                 (i_grp),
 .i_grp_v                               (i_grp_v),
 .i_hlp_dts_diode0_anode                (i_hlp_dts_diode0_anode),
 .i_hlp_dts_diode0_cathode              (i_hlp_dts_diode0_cathode),
 .i_parser_out                          (i_parser_out),
 .i_parser_out_v                        (i_parser_out_v),
 .i_ptr                                 (i_ptr[3:0]),
 .i_ptr_v                               (i_ptr_v[3:0]),
 .i_rpl_bkwd                            (i_rpl_bkwd),
 .i_rpl_frwd                            (i_rpl_frwd),
 .rst_n                                 (local_rst_n));


  /* Added by UltiBuild Instances Start */
  buf mgc_hdle_prim(fscan_clkgenctrl_ts1, fscan_clkgenctrl[0]);

  buf mgc_hdle_prim_1(fscan_clkgenctrlen_ts1, fscan_clkgenctrlen[0]);
  /* Added by UltiBuild Instances End */
endmodule
