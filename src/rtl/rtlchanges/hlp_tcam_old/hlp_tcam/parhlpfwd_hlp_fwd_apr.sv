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
module parhlpfwd_hlp_fwd_apr
(

input fary_ijtag_tck,
input fary_ijtag_rst_b,
input fary_ijtag_select,
input fary_ijtag_shift,
input fary_ijtag_capture,
input fary_ijtag_update,
input fary_ijtag_si,
output aary_ijtag_so,
input bisr_clk_pd_vinf,
input bisr_shift_en_pd_vinf,
input bisr_reset_pd_vinf,
input bisr_si_pd_vinf,
output bisr_so_pd_vinf,



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
input clk_rscclk,
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
output logic            o_tail_info_v          // From u_fwd_apr_func_logic of hlp_fwd_apr_func_logic.v
// End of automatics
, input wire pd_vinf_bisr_si, output wire bisr_so_pd_vinf_ts2, 
input wire pd_vinf_bisr_clk, input wire pd_vinf_bisr_reset, 
input wire pd_vinf_bisr_shift_en, output wire mbist_diag_done_ts1, 
output wire mbist_diag_done_ts2, output wire mbist_diag_done_ts3, 
output wire u_fwd_apr_tcam_mems_so, output wire u_fwd_apr_sram_mems_so, 
output wire u_fwd_apr_rf_mems_so, input wire sib_fwd_apr_sram_so, 
input wire sib_fwd_apr_rf_to_select, input wire sib_fwd_apr_tcam_so, 
input wire sib_fwd_apr_sram_to_select, input wire JT_IN_mbist_ijtag_si, 
input wire sib_fwd_apr_tcam_to_select, input wire JT_IN_mbist_ijtag_tck, 
input wire JT_IN_mbist_ijtag_shift, input wire JT_IN_mbist_ijtag_update, 
input wire JT_IN_mbist_ijtag_reset_b, input wire JT_IN_mbist_ijtag_capture, 
input wire clkout);

logic latch_mem_fuses;

  /* Added by UltiBuild Nets Start */
  wire bisr_so_pd_vinf_ts1, bisr_so_pd_vinf_ts3;
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
  (.clk(clk), .rstb(local_broadcast.mem_rst_b), .d(fary_trigger_post), .o(fary_trigger_post_fwd_sram));
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
 .clk                                   (clk),
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
 .pwr_mgmt_in_sram                      (pwr_mgmt_in_sram[6-1:0]), .bisr_clk_pd_vinf(pd_vinf_bisr_clk), 
 .bisr_shift_en_pd_vinf(pd_vinf_bisr_shift_en), .bisr_reset_pd_vinf(pd_vinf_bisr_reset), 
 .bisr_si_pd_vinf(bisr_so_pd_vinf_ts3), .bisr_so_pd_vinf(bisr_so_pd_vinf_ts1), .fary_ijtag_tck(JT_IN_mbist_ijtag_tck), 
 .fary_ijtag_rst_b(JT_IN_mbist_ijtag_reset_b), .mbist_diag_done(mbist_diag_done_ts2), 
 .fary_ijtag_select(sib_fwd_apr_sram_to_select), .fary_ijtag_shift(JT_IN_mbist_ijtag_shift), 
 .fary_ijtag_capture(JT_IN_mbist_ijtag_capture), .fary_ijtag_update(JT_IN_mbist_ijtag_update), 
 .fary_ijtag_si(sib_fwd_apr_tcam_so), .aary_ijtag_so(u_fwd_apr_sram_mems_so), 
 .fscan_byprst_b(fscan_byprst_b), .fscan_clkgenctrl(fscan_clkgenctrl_ts1), 
 .fscan_clkgenctrlen(fscan_clkgenctrlen_ts1), .fscan_clkungate_syn(fscan_clkungate_syn), 
 .fscan_latchclosed_b(fscan_latchclosed_b), .fscan_latchopen(fscan_latchopen), 
 .fscan_mode(fscan_mode), .fscan_mode_atspeed(fscan_mode_atspeed), 
 .fscan_ram_bypsel_rf(fscan_ram_bypsel_rf), .fscan_ram_bypsel_tcam(fscan_ram_bypsel_tcam), 
 .fscan_ret_ctrl(fscan_ret_ctrl), .fscan_rstbypen(fscan_rstbypen), 
 .fscan_shiften(fscan_shiften), .clk_rscclk(clkout));

logic aary_pwren_b_rf;
logic fary_trigger_post_fwd_rf, aary_post_complete_fwd_rf, aary_post_pass_fwd_rf;
assign fary_trigger_post_fwd_rf = aary_post_complete_fwd_sram;
assign aary_post_complete = aary_post_complete_fwd_rf;
assign aary_post_pass = aary_post_pass_fwd_sram & aary_post_pass_fwd_rf;
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
 .clk                                   (clk),
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
 .pwr_mgmt_in_rf                        (pwr_mgmt_in_rf[5-1:0]), .bisr_clk_pd_vinf(pd_vinf_bisr_clk), 
 .bisr_shift_en_pd_vinf(pd_vinf_bisr_shift_en), .bisr_reset_pd_vinf(pd_vinf_bisr_reset), 
 .bisr_si_pd_vinf(bisr_so_pd_vinf_ts1), .bisr_so_pd_vinf(bisr_so_pd_vinf_ts2), .fary_ijtag_tck(JT_IN_mbist_ijtag_tck), 
 .fary_ijtag_rst_b(JT_IN_mbist_ijtag_reset_b), .mbist_diag_done(mbist_diag_done_ts1), 
 .fary_ijtag_select(sib_fwd_apr_rf_to_select), .fary_ijtag_shift(JT_IN_mbist_ijtag_shift), 
 .fary_ijtag_capture(JT_IN_mbist_ijtag_capture), .fary_ijtag_update(JT_IN_mbist_ijtag_update), 
 .fary_ijtag_si(sib_fwd_apr_sram_so), .aary_ijtag_so(u_fwd_apr_rf_mems_so), 
 .fscan_byprst_b(fscan_byprst_b), .fscan_clkgenctrl(fscan_clkgenctrl_ts1), 
 .fscan_clkgenctrlen(fscan_clkgenctrlen_ts1), .fscan_clkungate_syn(fscan_clkungate_syn), 
 .fscan_latchclosed_b(fscan_latchclosed_b), .fscan_latchopen(fscan_latchopen), 
 .fscan_mode(fscan_mode), .fscan_mode_atspeed(fscan_mode_atspeed), 
 .fscan_ram_bypsel_sram(fscan_ram_bypsel_sram), .fscan_ram_bypsel_tcam(fscan_ram_bypsel_tcam), 
 .fscan_ret_ctrl(fscan_ret_ctrl), .fscan_rstbypen(fscan_rstbypen), 
 .fscan_shiften(fscan_shiften), .clk_rscclk(clkout));

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
 .clk                                   (clk),
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
 .ip_reset_b                            (local_broadcast.mem_rst_b), .bisr_clk_pd_vinf(pd_vinf_bisr_clk), 
 .bisr_shift_en_pd_vinf(pd_vinf_bisr_shift_en), .bisr_reset_pd_vinf(pd_vinf_bisr_reset), 
 .bisr_si_pd_vinf(pd_vinf_bisr_si), .bisr_so_pd_vinf(bisr_so_pd_vinf_ts3), .fary_ijtag_tck(JT_IN_mbist_ijtag_tck), 
 .fary_ijtag_rst_b(JT_IN_mbist_ijtag_reset_b), .mbist_diag_done(mbist_diag_done_ts3), 
 .fary_ijtag_select(sib_fwd_apr_tcam_to_select), .fary_ijtag_shift(JT_IN_mbist_ijtag_shift), 
 .fary_ijtag_capture(JT_IN_mbist_ijtag_capture), .fary_ijtag_update(JT_IN_mbist_ijtag_update), 
 .fary_ijtag_si(JT_IN_mbist_ijtag_si), .aary_ijtag_so(u_fwd_apr_tcam_mems_so), 
 .fscan_byprst_b(fscan_byprst_b), .fscan_clkgenctrl(fscan_clkgenctrl_ts1), 
 .fscan_clkgenctrlen(fscan_clkgenctrlen_ts1), .fscan_clkungate_syn(fscan_clkungate_syn), 
 .fscan_latchclosed_b(fscan_latchclosed_b), .fscan_latchopen(fscan_latchopen), 
 .fscan_mode_atspeed(fscan_mode_atspeed), .fscan_ram_bypsel_rf(fscan_ram_bypsel_rf), 
 .fscan_ram_bypsel_sram(fscan_ram_bypsel_sram), .fscan_ret_ctrl(fscan_ret_ctrl), 
 .fscan_rstbypen(fscan_rstbypen), .clk_rscclk(clkout)); // Templated

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
( .fet_ack_b(fet_ack_b_from_fl),
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
 .clk                                   (clk),
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


  /* Added by UltiBuild Instances Start */
  buf mgc_hdle_prim(fscan_clkgenctrl_ts1, fscan_clkgenctrl[0]);

  buf mgc_hdle_prim_1(fscan_clkgenctrlen_ts1, fscan_clkgenctrlen[0]);
  /* Added by UltiBuild Instances End */
endmodule
