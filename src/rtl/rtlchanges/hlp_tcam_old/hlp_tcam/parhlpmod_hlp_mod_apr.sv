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

`include "hlp_mod_mem.def"
module parhlpmod_hlp_mod_apr
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
input clk_rscclk,
output mbist_diag_done,
input fsta_afd_en,
// Beginning of automatic inputs (from unused autoinst inputs)
input logic             DFTMASK,                // To u_mod_apr_sram_mems of hlp_mod_apr_sram_mems.v, ...
input logic             DFTSHIFTEN,             // To u_mod_apr_sram_mems of hlp_mod_apr_sram_mems.v, ...
input logic             DFT_AFD_RESET_B,        // To u_mod_apr_sram_mems of hlp_mod_apr_sram_mems.v, ...
input logic             DFT_ARRAY_FREEZE,       // To u_mod_apr_sram_mems of hlp_mod_apr_sram_mems.v, ...
input logic             clk,                    // To u_mod_apr_sram_mems of hlp_mod_apr_sram_mems.v, ...
input logic [6:0]       fary_ffuse_hd2prf_trim, // To u_mod_apr_rf_mems of hlp_mod_apr_rf_mems.v
input logic [16:0]      fary_ffuse_hdusplr_trim,// To u_mod_apr_sram_mems of hlp_mod_apr_sram_mems.v
input logic [16:0]      fary_ffuse_hduspsr_trim,// To u_mod_apr_sram_mems of hlp_mod_apr_sram_mems.v
input logic [1:0]       fary_ffuse_rf_sleep,    // To u_mod_apr_rf_mems of hlp_mod_apr_rf_mems.v
input logic [1:0]       fary_ffuse_sram_sleep,  // To u_mod_apr_sram_mems of hlp_mod_apr_sram_mems.v
input logic             fary_ffuse_tcam_sleep,  // To u_mod_apr_tcam_mems of hlp_mod_apr_tcam_mems.v
input logic [15:0]      fary_ffuse_tune_tcam,   // To u_mod_apr_tcam_mems of hlp_mod_apr_tcam_mems.v
input logic             fary_output_reset,      // To u_mod_apr_sram_mems of hlp_mod_apr_sram_mems.v, ...
input logic             fscan_byprst_b,         // To u_mod_apr_func_logic of hlp_mod_apr_func_logic.v
input logic [hlp_dfx_pkg::MOD_NUM_CLKGENCTRL-1:0] fscan_clkgenctrl,// To u_mod_apr_func_logic of hlp_mod_apr_func_logic.v
input logic [hlp_dfx_pkg::MOD_NUM_CLKGENCTRLEN-1:0] fscan_clkgenctrlen,// To u_mod_apr_func_logic of hlp_mod_apr_func_logic.v
input logic             fscan_clkungate,        // To u_mod_apr_sram_mems of hlp_mod_apr_sram_mems.v, ...
input logic             fscan_clkungate_syn,    // To u_mod_apr_func_logic of hlp_mod_apr_func_logic.v
input logic             fscan_latchclosed_b,    // To u_mod_apr_func_logic of hlp_mod_apr_func_logic.v
input logic             fscan_latchopen,        // To u_mod_apr_func_logic of hlp_mod_apr_func_logic.v
input logic             fscan_mode,             // To u_mod_apr_tcam_mems of hlp_mod_apr_tcam_mems.v, ...
input logic             fscan_mode_atspeed,     // To u_mod_apr_func_logic of hlp_mod_apr_func_logic.v
input logic             fscan_ram_bypsel_rf,    // To u_mod_apr_rf_mems of hlp_mod_apr_rf_mems.v
input logic             fscan_ram_bypsel_sram,  // To u_mod_apr_sram_mems of hlp_mod_apr_sram_mems.v
input logic             fscan_ram_bypsel_tcam,  // To u_mod_apr_tcam_mems of hlp_mod_apr_tcam_mems.v
input logic             fscan_ram_init_en,      // To u_mod_apr_sram_mems of hlp_mod_apr_sram_mems.v, ...
input logic             fscan_ram_init_val,     // To u_mod_apr_sram_mems of hlp_mod_apr_sram_mems.v, ...
input logic             fscan_ram_rdis_b,       // To u_mod_apr_sram_mems of hlp_mod_apr_sram_mems.v, ...
input logic             fscan_ram_wdis_b,       // To u_mod_apr_sram_mems of hlp_mod_apr_sram_mems.v, ...
input logic             fscan_ret_ctrl,         // To u_mod_apr_func_logic of hlp_mod_apr_func_logic.v
input logic             fscan_rstbypen,         // To u_mod_apr_func_logic of hlp_mod_apr_func_logic.v
input logic [hlp_dfx_pkg::MOD_NUM_SDI-1:0] fscan_sdi,// To u_mod_apr_func_logic of hlp_mod_apr_func_logic.v
input logic             fscan_shiften,          // To u_mod_apr_tcam_mems of hlp_mod_apr_tcam_mems.v, ...
input logic             fsta_dfxact_afd,        // To u_mod_apr_sram_mems of hlp_mod_apr_sram_mems.v, ...
input logic             fvisa_all_dis,          // To u_mod_apr_func_logic of hlp_mod_apr_func_logic.v
input logic [hlp_dfx_pkg::NUM_VISA_LANES-1:0] fvisa_clk,// To u_mod_apr_func_logic of hlp_mod_apr_func_logic.v
input logic             fvisa_customer_dis,     // To u_mod_apr_func_logic of hlp_mod_apr_func_logic.v
input logic [hlp_dfx_pkg::VISA_DBG_LANE_WIDTH-1:0] fvisa_dbg_lane,// To u_mod_apr_func_logic of hlp_mod_apr_func_logic.v
input logic             fvisa_frame,            // To u_mod_apr_func_logic of hlp_mod_apr_func_logic.v
input logic             fvisa_rddata,           // To u_mod_apr_func_logic of hlp_mod_apr_func_logic.v
input logic             fvisa_resetb,           // To u_mod_apr_func_logic of hlp_mod_apr_func_logic.v
input logic             fvisa_serdata,          // To u_mod_apr_func_logic of hlp_mod_apr_func_logic.v
input logic             fvisa_serstb,           // To u_mod_apr_func_logic of hlp_mod_apr_func_logic.v
input logic [8:0]       fvisa_unit_id,          // To u_mod_apr_func_logic of hlp_mod_apr_func_logic.v
input logic [$bits(hlp_pkg::modify_ecn_t)-1:0] i_cm,               // To u_mod_apr_func_logic of hlp_mod_apr_func_logic.v
input logic             i_cm_v,                 // To u_mod_apr_func_logic of hlp_mod_apr_func_logic.v
input logic [$bits(hlp_pkg::imn_rpl_bkwd_t)-1:0] i_feedthru_rpl_bkwd,// To u_mod_apr_func_logic of hlp_mod_apr_func_logic.v
input logic [$bits(hlp_pkg::imn_rpl_frwd_t)-1:0] i_feedthru_rpl_frwd,// To u_mod_apr_func_logic of hlp_mod_apr_func_logic.v
input logic [$bits(hlp_pkg::fixed_sched_t)-1:0] i_fixed_sched,     // To u_mod_apr_func_logic of hlp_mod_apr_func_logic.v
input logic             i_fixed_sched_v,        // To u_mod_apr_func_logic of hlp_mod_apr_func_logic.v
input logic             i_hlp_dts_diode2_anode, // To u_mod_apr_func_logic of hlp_mod_apr_func_logic.v
inout tri               i_hlp_dts_diode2_cathode,// To u_mod_apr_func_logic of hlp_mod_apr_func_logic.v
input logic [$bits(hlp_pkg::modify_ctrl_t)-1:0] i_modify_ctrl,     // To u_mod_apr_func_logic of hlp_mod_apr_func_logic.v
input logic             i_modify_ctrl_v,        // To u_mod_apr_func_logic of hlp_mod_apr_func_logic.v
input logic [$bits(hlp_pkg::port_pause_ripple_t)-1:0] i_pause_ripple,// To u_mod_apr_func_logic of hlp_mod_apr_func_logic.v
input logic [$bits(hlp_pkg::port_pause_ripple_t)-1:0] i_pause_ripple_ret,// To u_mod_apr_func_logic of hlp_mod_apr_func_logic.v
input logic             i_pause_ripple_ret_v,   // To u_mod_apr_func_logic of hlp_mod_apr_func_logic.v
input logic             i_pause_ripple_v,       // To u_mod_apr_func_logic of hlp_mod_apr_func_logic.v
input logic [$bits(hlp_pkg::pm_read_t)-1:0] i_pm_read,             // To u_mod_apr_func_logic of hlp_mod_apr_func_logic.v
input logic [$bits(hlp_pkg::imn_rpl_bkwd_t)-1:0] i_rpl_bkwd,       // To u_mod_apr_func_logic of hlp_mod_apr_func_logic.v
input logic [$bits(hlp_pkg::imn_rpl_frwd_t)-1:0] i_rpl_frwd,       // To u_mod_apr_func_logic of hlp_mod_apr_func_logic.v
input logic [$bits(hlp_pkg::tx_credits_t)-1:0] i_tx_credits,       // To u_mod_apr_func_logic of hlp_mod_apr_func_logic.v
input logic             isol_en_b,              // To u_mod_apr_sram_mems of hlp_mod_apr_sram_mems.v, ...
input logic [4:0]       pwr_mgmt_in_rf,         // To u_mod_apr_rf_mems of hlp_mod_apr_rf_mems.v
input logic [5:0]       pwr_mgmt_in_sram,       // To u_mod_apr_sram_mems of hlp_mod_apr_sram_mems.v
input logic             rst_n,                  // To u_mod_apr_func_logic of hlp_mod_apr_func_logic.v
// End of automatics
/*AUTOOUTPUT*/
// Beginning of automatic outputs (from unused autoinst outputs)
output logic [hlp_dfx_pkg::MOD_NUM_SDO-1:0] ascan_sdo,// From u_mod_apr_func_logic of hlp_mod_apr_func_logic.v
output logic            avisa_all_dis,          // From u_mod_apr_func_logic of hlp_mod_apr_func_logic.v
output logic [hlp_dfx_pkg::NUM_VISA_LANES-1:0] avisa_clk,// From u_mod_apr_func_logic of hlp_mod_apr_func_logic.v
output logic            avisa_customer_dis,     // From u_mod_apr_func_logic of hlp_mod_apr_func_logic.v
output logic [hlp_dfx_pkg::VISA_DBG_LANE_WIDTH-1:0] avisa_dbg_lane,// From u_mod_apr_func_logic of hlp_mod_apr_func_logic.v
output logic            avisa_frame,            // From u_mod_apr_func_logic of hlp_mod_apr_func_logic.v
output logic            avisa_rddata,           // From u_mod_apr_func_logic of hlp_mod_apr_func_logic.v
output logic            avisa_serdata,          // From u_mod_apr_func_logic of hlp_mod_apr_func_logic.v
output logic            avisa_serstb,           // From u_mod_apr_func_logic of hlp_mod_apr_func_logic.v
output logic            isol_ack_b,             // From u_mod_apr_func_logic of hlp_mod_apr_func_logic.v
output logic [$bits(hlp_pkg::tx_sia_ripple_t)-1:0] o_exbar_segment,// From u_mod_apr_func_logic of hlp_mod_apr_func_logic.v
output logic            o_exbar_segment_v,      // From u_mod_apr_func_logic of hlp_mod_apr_func_logic.v
output logic [$bits(hlp_pkg::imn_rpl_bkwd_t)-1:0] o_feedthru_rpl_bkwd,// From u_mod_apr_func_logic of hlp_mod_apr_func_logic.v
output logic [$bits(hlp_pkg::imn_rpl_frwd_t)-1:0] o_feedthru_rpl_frwd,// From u_mod_apr_func_logic of hlp_mod_apr_func_logic.v
output logic [$bits(hlp_pkg::fixed_sched_t)-1:0] o_fixed_sched,    // From u_mod_apr_func_logic of hlp_mod_apr_func_logic.v
output logic            o_fixed_sched_v,        // From u_mod_apr_func_logic of hlp_mod_apr_func_logic.v
output logic            o_hlp_dts_diode2_anode, // From u_mod_apr_func_logic of hlp_mod_apr_func_logic.v
output logic            o_hlp_dts_diode2_cathode,// From u_mod_apr_func_logic of hlp_mod_apr_func_logic.v
output logic [$bits(hlp_pkg::port_pause_ripple_t)-1:0] o_pause_ripple,// From u_mod_apr_func_logic of hlp_mod_apr_func_logic.v
output logic [$bits(hlp_pkg::port_pause_ripple_t)-1:0] o_pause_ripple_ret,// From u_mod_apr_func_logic of hlp_mod_apr_func_logic.v
output logic            o_pause_ripple_ret_v,   // From u_mod_apr_func_logic of hlp_mod_apr_func_logic.v
output logic            o_pause_ripple_v,       // From u_mod_apr_func_logic of hlp_mod_apr_func_logic.v
output logic [$bits(hlp_pkg::refcnt_tx_info_t)-1:0] o_refcnt_tx_info,// From u_mod_apr_func_logic of hlp_mod_apr_func_logic.v
output logic            o_refcnt_tx_info_v,     // From u_mod_apr_func_logic of hlp_mod_apr_func_logic.v
output logic [$bits(hlp_pkg::imn_rpl_bkwd_t)-1:0] o_rpl_bkwd,      // From u_mod_apr_func_logic of hlp_mod_apr_func_logic.v
output logic [$bits(hlp_pkg::imn_rpl_frwd_t)-1:0] o_rpl_frwd,      // From u_mod_apr_func_logic of hlp_mod_apr_func_logic.v
output logic [$bits(hlp_pkg::tx_credits_t)-1:0] o_tx_credits      // From u_mod_apr_func_logic of hlp_mod_apr_func_logic.v
// End of automatics
, input wire pd_vinf_bisr_si, output wire bisr_so_pd_vinf_ts2, 
input wire pd_vinf_bisr_clk, input wire pd_vinf_bisr_reset, 
input wire pd_vinf_bisr_shift_en, output wire mbist_diag_done_ts1, 
output wire mbist_diag_done_ts2, output wire mbist_diag_done_ts3, 
output wire u_mod_apr_rf_mems_so, output wire u_mod_apr_sram_mems_so, 
output wire u_mod_apr_tcam_mems_so, input wire sib_mod_apr_sram_so, 
input wire sib_mod_apr_tcam_1_to_select, input wire sib_mod_apr_tcam_so, 
input wire sib_mod_apr_sram_to_select, input wire JT_IN_mbist_ijtag_si, 
input wire sib_mod_apr_tcam_to_select, input wire JT_IN_mbist_ijtag_update, 
input wire JT_IN_mbist_ijtag_tck, input wire JT_IN_mbist_ijtag_capture, 
input wire JT_IN_mbist_ijtag_reset_b, input wire JT_IN_mbist_ijtag_shift, 
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
logic [`HLP_MOD_MOD_AQM_PROFILE_FROM_MEM_WIDTH-1:0] frm_mod_aqm_profile;// From u_mod_apr_rf_mems of hlp_mod_apr_rf_mems.v
logic [`HLP_MOD_MOD_DESC_MANAGER_FROM_MEM_WIDTH-1:0] frm_mod_desc_manager;// From u_mod_apr_sram_mems of hlp_mod_apr_sram_mems.v
logic [`HLP_MOD_MOD_DS_EXP_FROM_MEM_WIDTH-1:0] frm_mod_ds_exp;// From u_mod_apr_sram_mems of hlp_mod_apr_sram_mems.v
logic [`HLP_MOD_MOD_DSCP_MAP_FROM_MEM_WIDTH-1:0] frm_mod_dscp_map;// From u_mod_apr_rf_mems of hlp_mod_apr_rf_mems.v
logic [`HLP_MOD_MOD_EGRESS_MST_TABLE_FROM_MEM_WIDTH-1:0] frm_mod_egress_mst_table;// From u_mod_apr_sram_mems of hlp_mod_apr_sram_mems.v
logic [`HLP_MOD_MOD_EGRESS_STATS_BANK_IP_BYTE_CACHE_FROM_MEM_WIDTH-1:0] frm_mod_egress_stats_bank_ip_byte_cache;// From u_mod_apr_rf_mems of hlp_mod_apr_rf_mems.v
logic [`HLP_MOD_MOD_EGRESS_STATS_BANK_IP_FRAME_CACHE_FROM_MEM_WIDTH-1:0] frm_mod_egress_stats_bank_ip_frame_cache;// From u_mod_apr_rf_mems of hlp_mod_apr_rf_mems.v
logic [`HLP_MOD_MOD_EGRESS_STATS_BANK_VLAN_BYTE_CACHE_FROM_MEM_WIDTH-1:0] frm_mod_egress_stats_bank_vlan_byte_cache;// From u_mod_apr_rf_mems of hlp_mod_apr_rf_mems.v
logic [`HLP_MOD_MOD_EGRESS_STATS_BANK_VLAN_FRAME_CACHE_FROM_MEM_WIDTH-1:0] frm_mod_egress_stats_bank_vlan_frame_cache;// From u_mod_apr_rf_mems of hlp_mod_apr_rf_mems.v
logic [`HLP_MOD_MOD_EGRESS_VID_TABLE_FROM_MEM_WIDTH-1:0] frm_mod_egress_vid_table;// From u_mod_apr_sram_mems of hlp_mod_apr_sram_mems.v
logic [`HLP_MOD_MOD_MCAST_VLAN_TABLE_FROM_MEM_WIDTH-1:0] frm_mod_mcast_vlan_table;// From u_mod_apr_sram_mems of hlp_mod_apr_sram_mems.v
logic [`HLP_MOD_MOD_MIRROR_PROFILE_TABLE2_FROM_MEM_WIDTH-1:0] frm_mod_mirror_profile_table2;// From u_mod_apr_ff_mems of hlp_mod_apr_ff_mems.v
logic [`HLP_MOD_MOD_PER_PORT_CFG1_FROM_MEM_WIDTH-1:0] frm_mod_per_port_cfg1;// From u_mod_apr_ff_mems of hlp_mod_apr_ff_mems.v
logic [`HLP_MOD_MOD_PER_PORT_CFG2_FROM_MEM_WIDTH-1:0] frm_mod_per_port_cfg2;// From u_mod_apr_ff_mems of hlp_mod_apr_ff_mems.v
logic [`HLP_MOD_MOD_SMAC_IDX_MAP_FROM_MEM_WIDTH-1:0] frm_mod_smac_idx_map;// From u_mod_apr_ff_mems of hlp_mod_apr_ff_mems.v
logic [`HLP_MOD_MOD_STATS_BANK_BYTE_FROM_MEM_WIDTH-1:0] frm_mod_stats_bank_byte;// From u_mod_apr_rf_mems of hlp_mod_apr_rf_mems.v
logic [`HLP_MOD_MOD_STATS_BANK_FRAME_FROM_MEM_WIDTH-1:0] frm_mod_stats_bank_frame;// From u_mod_apr_rf_mems of hlp_mod_apr_rf_mems.v
logic [`HLP_MOD_MOD_TX_STATS_VLAN_CNT_IDX_MAP_ACTION_FROM_MEM_WIDTH-1:0] frm_mod_tx_stats_vlan_cnt_idx_map_action;// From u_mod_apr_sram_mems of hlp_mod_apr_sram_mems.v
logic [`HLP_MOD_MOD_VID1_MAP_FROM_MEM_WIDTH-1:0] frm_mod_vid1_map;// From u_mod_apr_sram_mems of hlp_mod_apr_sram_mems.v
logic [`HLP_MOD_MOD_VID2_MAP_FROM_MEM_WIDTH-1:0] frm_mod_vid2_map;// From u_mod_apr_sram_mems of hlp_mod_apr_sram_mems.v
logic [`HLP_MOD_MOD_VLAN_TAG_FROM_MEM_WIDTH-1:0] frm_mod_vlan_tag;// From u_mod_apr_sram_mems of hlp_mod_apr_sram_mems.v
logic [`HLP_MOD_MOD_VPRI1_MAP_FROM_MEM_WIDTH-1:0] frm_mod_vpri1_map;// From u_mod_apr_ff_mems of hlp_mod_apr_ff_mems.v
logic [`HLP_MOD_MOD_VPRI2_MAP_FROM_MEM_WIDTH-1:0] frm_mod_vpri2_map;// From u_mod_apr_ff_mems of hlp_mod_apr_ff_mems.v
logic [`HLP_MOD_MOD_AQM_PROFILE_TO_MEM_WIDTH-1:0] tom_mod_aqm_profile;// From u_mod_apr_func_logic of hlp_mod_apr_func_logic.v
logic [hlp_mod_pkg::N_DESC_MEMS-1:0] [`HLP_MOD_MOD_DESC_TO_MEM_WIDTH-1:0]   tom_mod_desc;// From u_mod_apr_func_logic of hlp_mod_apr_func_logic.v
logic [hlp_mod_pkg::N_DESC_MEMS-1:0] [`HLP_MOD_MOD_DESC_FROM_MEM_WIDTH-1:0] frm_mod_desc; // fixed by mem_gen script
logic [`HLP_MOD_MOD_DESC_MANAGER_TO_MEM_WIDTH-1:0] tom_mod_desc_manager;// From u_mod_apr_func_logic of hlp_mod_apr_func_logic.v
logic [`HLP_MOD_MOD_DS_EXP_TO_MEM_WIDTH-1:0] tom_mod_ds_exp;// From u_mod_apr_func_logic of hlp_mod_apr_func_logic.v
logic [`HLP_MOD_MOD_DSCP_MAP_TO_MEM_WIDTH-1:0] tom_mod_dscp_map;// From u_mod_apr_func_logic of hlp_mod_apr_func_logic.v
logic [`HLP_MOD_MOD_EGRESS_MST_TABLE_TO_MEM_WIDTH-1:0] tom_mod_egress_mst_table;// From u_mod_apr_func_logic of hlp_mod_apr_func_logic.v
logic [hlp_mod_pkg::N_IP_BANKS-1:0] [`HLP_MOD_MOD_EGRESS_STATS_BANK_IP_BYTE_TO_MEM_WIDTH-1:0]   tom_mod_egress_stats_bank_ip_byte;// From u_mod_apr_func_logic of hlp_mod_apr_func_logic.v
logic [hlp_mod_pkg::N_IP_BANKS-1:0] [`HLP_MOD_MOD_EGRESS_STATS_BANK_IP_BYTE_FROM_MEM_WIDTH-1:0] frm_mod_egress_stats_bank_ip_byte; // fixed by mem_gen script
logic [`HLP_MOD_MOD_EGRESS_STATS_BANK_IP_BYTE_CACHE_TO_MEM_WIDTH-1:0] tom_mod_egress_stats_bank_ip_byte_cache;// From u_mod_apr_func_logic of hlp_mod_apr_func_logic.v
logic [hlp_mod_pkg::N_IP_BANKS-1:0] [`HLP_MOD_MOD_EGRESS_STATS_BANK_IP_FRAME_TO_MEM_WIDTH-1:0]   tom_mod_egress_stats_bank_ip_frame;// From u_mod_apr_func_logic of hlp_mod_apr_func_logic.v
logic [hlp_mod_pkg::N_IP_BANKS-1:0] [`HLP_MOD_MOD_EGRESS_STATS_BANK_IP_FRAME_FROM_MEM_WIDTH-1:0] frm_mod_egress_stats_bank_ip_frame; // fixed by mem_gen script
logic [`HLP_MOD_MOD_EGRESS_STATS_BANK_IP_FRAME_CACHE_TO_MEM_WIDTH-1:0] tom_mod_egress_stats_bank_ip_frame_cache;// From u_mod_apr_func_logic of hlp_mod_apr_func_logic.v
logic [hlp_mod_pkg::N_VLAN_BANKS-1:0] [`HLP_MOD_MOD_EGRESS_STATS_BANK_VLAN_BYTE_TO_MEM_WIDTH-1:0]   tom_mod_egress_stats_bank_vlan_byte;// From u_mod_apr_func_logic of hlp_mod_apr_func_logic.v
logic [hlp_mod_pkg::N_VLAN_BANKS-1:0] [`HLP_MOD_MOD_EGRESS_STATS_BANK_VLAN_BYTE_FROM_MEM_WIDTH-1:0] frm_mod_egress_stats_bank_vlan_byte; // fixed by mem_gen script
logic [`HLP_MOD_MOD_EGRESS_STATS_BANK_VLAN_BYTE_CACHE_TO_MEM_WIDTH-1:0] tom_mod_egress_stats_bank_vlan_byte_cache;// From u_mod_apr_func_logic of hlp_mod_apr_func_logic.v
logic [hlp_mod_pkg::N_VLAN_BANKS-1:0] [`HLP_MOD_MOD_EGRESS_STATS_BANK_VLAN_FRAME_TO_MEM_WIDTH-1:0]   tom_mod_egress_stats_bank_vlan_frame;// From u_mod_apr_func_logic of hlp_mod_apr_func_logic.v
logic [hlp_mod_pkg::N_VLAN_BANKS-1:0] [`HLP_MOD_MOD_EGRESS_STATS_BANK_VLAN_FRAME_FROM_MEM_WIDTH-1:0] frm_mod_egress_stats_bank_vlan_frame; // fixed by mem_gen script
logic [`HLP_MOD_MOD_EGRESS_STATS_BANK_VLAN_FRAME_CACHE_TO_MEM_WIDTH-1:0] tom_mod_egress_stats_bank_vlan_frame_cache;// From u_mod_apr_func_logic of hlp_mod_apr_func_logic.v
logic [`HLP_MOD_MOD_EGRESS_VID_TABLE_TO_MEM_WIDTH-1:0] tom_mod_egress_vid_table;// From u_mod_apr_func_logic of hlp_mod_apr_func_logic.v
logic [`HLP_MOD_MOD_MCAST_VLAN_TABLE_TO_MEM_WIDTH-1:0] tom_mod_mcast_vlan_table;// From u_mod_apr_func_logic of hlp_mod_apr_func_logic.v
logic [`HLP_MOD_MOD_MIRROR_PROFILE_TABLE2_TO_MEM_WIDTH-1:0] tom_mod_mirror_profile_table2;// From u_mod_apr_func_logic of hlp_mod_apr_func_logic.v
logic [2-1:0] [`HLP_MOD_MOD_MS_SCI_TABLE_TCAM_TO_TCAM_WIDTH-1:0]   tom_mod_ms_sci_table_tcam;// From u_mod_apr_func_logic of hlp_mod_apr_func_logic.v
logic [2-1:0] [`HLP_MOD_MOD_MS_SCI_TABLE_TCAM_FROM_TCAM_WIDTH-1:0] frm_mod_ms_sci_table_tcam; // fixed by mem_gen script
logic [1:0] [`HLP_MOD_MOD_PER_L2D_CFG_TO_MEM_WIDTH-1:0]   tom_mod_per_l2d_cfg;// From u_mod_apr_func_logic of hlp_mod_apr_func_logic.v
logic [1:0] [`HLP_MOD_MOD_PER_L2D_CFG_FROM_MEM_WIDTH-1:0] frm_mod_per_l2d_cfg; // fixed by mem_gen script
logic [`HLP_MOD_MOD_PER_PORT_CFG1_TO_MEM_WIDTH-1:0] tom_mod_per_port_cfg1;// From u_mod_apr_func_logic of hlp_mod_apr_func_logic.v
logic [`HLP_MOD_MOD_PER_PORT_CFG2_TO_MEM_WIDTH-1:0] tom_mod_per_port_cfg2;// From u_mod_apr_func_logic of hlp_mod_apr_func_logic.v
logic [`HLP_MOD_MOD_SMAC_IDX_MAP_TO_MEM_WIDTH-1:0] tom_mod_smac_idx_map;// From u_mod_apr_func_logic of hlp_mod_apr_func_logic.v
logic [`HLP_MOD_MOD_STATS_BANK_BYTE_TO_MEM_WIDTH-1:0] tom_mod_stats_bank_byte;// From u_mod_apr_func_logic of hlp_mod_apr_func_logic.v
logic [`HLP_MOD_MOD_STATS_BANK_FRAME_TO_MEM_WIDTH-1:0] tom_mod_stats_bank_frame;// From u_mod_apr_func_logic of hlp_mod_apr_func_logic.v
logic [`HLP_MOD_MOD_TX_STATS_VLAN_CNT_IDX_MAP_ACTION_TO_MEM_WIDTH-1:0] tom_mod_tx_stats_vlan_cnt_idx_map_action;// From u_mod_apr_func_logic of hlp_mod_apr_func_logic.v
logic [8-1:0] [`HLP_MOD_MOD_TX_STATS_VLAN_CNT_IDX_MAP_TCAM_TO_TCAM_WIDTH-1:0]   tom_mod_tx_stats_vlan_cnt_idx_map_tcam;// From u_mod_apr_func_logic of hlp_mod_apr_func_logic.v
logic [8-1:0] [`HLP_MOD_MOD_TX_STATS_VLAN_CNT_IDX_MAP_TCAM_FROM_TCAM_WIDTH-1:0] frm_mod_tx_stats_vlan_cnt_idx_map_tcam; // fixed by mem_gen script
logic [`HLP_MOD_MOD_VID1_MAP_TO_MEM_WIDTH-1:0] tom_mod_vid1_map;// From u_mod_apr_func_logic of hlp_mod_apr_func_logic.v
logic [`HLP_MOD_MOD_VID2_MAP_TO_MEM_WIDTH-1:0] tom_mod_vid2_map;// From u_mod_apr_func_logic of hlp_mod_apr_func_logic.v
logic [`HLP_MOD_MOD_VLAN_TAG_TO_MEM_WIDTH-1:0] tom_mod_vlan_tag;// From u_mod_apr_func_logic of hlp_mod_apr_func_logic.v
logic [`HLP_MOD_MOD_VPRI1_MAP_TO_MEM_WIDTH-1:0] tom_mod_vpri1_map;// From u_mod_apr_func_logic of hlp_mod_apr_func_logic.v
logic [`HLP_MOD_MOD_VPRI2_MAP_TO_MEM_WIDTH-1:0] tom_mod_vpri2_map;// From u_mod_apr_func_logic of hlp_mod_apr_func_logic.v
// End of automatics

/*
  hlp_mod_apr_sram_mems AUTO_TEMPLATE
  hlp_mod_apr_ff_mems AUTO_TEMPLATE
  hlp_mod_apr_rf_mems AUTO_TEMPLATE
  hlp_mod_apr_tcam_mems AUTO_TEMPLATE
 (
  .mod_\(.*\)_\([0-9]+\)_from_mem (frm_\1[\2][]),
  .mod_\(.*\)_\([0-9]+\)_to_mem   (tom_\1[\2][]),
  .mod_\(.*\)_from_mem              (frm_\1[]),
  .mod_\(.*\)_to_mem                (tom_\1[]),
  .mod_\(.*\)_\([0-9]+\)_from_tcam (frm_\1[\2][]),
  .mod_\(.*\)_\([0-9]+\)_to_tcam   (tom_\1[\2][]),
  .mod_\(.*\)_from_tcam              (frm_\1[]),
  .mod_\(.*\)_to_tcam                (tom_\1[]),
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
logic fary_trigger_post_mod_sram, aary_post_complete_mod_sram, aary_post_pass_mod_sram;
ctech_lib_doublesync_rstb  #(.WIDTH(1))  u_trigger_post
  (.clk(clk), .rstb(local_broadcast.mem_rst_b), .d(fary_trigger_post), .o(fary_trigger_post_mod_sram));
hlp_mod_apr_sram_mems u_mod_apr_sram_mems
(// Manual connections
.fary_trigger_post_mod_sram,
.aary_post_complete_mod_sram,
.aary_post_pass_mod_sram,
 .aary_pwren_b_sram(aary_pwren_b_sram),
 /*AUTOINST*/
 // Outputs
 .aary_post_complete_sram               (),                      // Templated
 .aary_post_pass_sram                   (),                      // Templated
 .mod_mod_desc_0_from_mem               (frm_mod_desc[0][`HLP_MOD_MOD_DESC_FROM_MEM_WIDTH-1:0]), // Templated
 .mod_mod_desc_10_from_mem              (frm_mod_desc[10][`HLP_MOD_MOD_DESC_FROM_MEM_WIDTH-1:0]), // Templated
 .mod_mod_desc_11_from_mem              (frm_mod_desc[11][`HLP_MOD_MOD_DESC_FROM_MEM_WIDTH-1:0]), // Templated
 .mod_mod_desc_12_from_mem              (frm_mod_desc[12][`HLP_MOD_MOD_DESC_FROM_MEM_WIDTH-1:0]), // Templated
 .mod_mod_desc_13_from_mem              (frm_mod_desc[13][`HLP_MOD_MOD_DESC_FROM_MEM_WIDTH-1:0]), // Templated
 .mod_mod_desc_14_from_mem              (frm_mod_desc[14][`HLP_MOD_MOD_DESC_FROM_MEM_WIDTH-1:0]), // Templated
 .mod_mod_desc_15_from_mem              (frm_mod_desc[15][`HLP_MOD_MOD_DESC_FROM_MEM_WIDTH-1:0]), // Templated
 .mod_mod_desc_1_from_mem               (frm_mod_desc[1][`HLP_MOD_MOD_DESC_FROM_MEM_WIDTH-1:0]), // Templated
 .mod_mod_desc_2_from_mem               (frm_mod_desc[2][`HLP_MOD_MOD_DESC_FROM_MEM_WIDTH-1:0]), // Templated
 .mod_mod_desc_3_from_mem               (frm_mod_desc[3][`HLP_MOD_MOD_DESC_FROM_MEM_WIDTH-1:0]), // Templated
 .mod_mod_desc_4_from_mem               (frm_mod_desc[4][`HLP_MOD_MOD_DESC_FROM_MEM_WIDTH-1:0]), // Templated
 .mod_mod_desc_5_from_mem               (frm_mod_desc[5][`HLP_MOD_MOD_DESC_FROM_MEM_WIDTH-1:0]), // Templated
 .mod_mod_desc_6_from_mem               (frm_mod_desc[6][`HLP_MOD_MOD_DESC_FROM_MEM_WIDTH-1:0]), // Templated
 .mod_mod_desc_7_from_mem               (frm_mod_desc[7][`HLP_MOD_MOD_DESC_FROM_MEM_WIDTH-1:0]), // Templated
 .mod_mod_desc_8_from_mem               (frm_mod_desc[8][`HLP_MOD_MOD_DESC_FROM_MEM_WIDTH-1:0]), // Templated
 .mod_mod_desc_9_from_mem               (frm_mod_desc[9][`HLP_MOD_MOD_DESC_FROM_MEM_WIDTH-1:0]), // Templated
 .mod_mod_desc_manager_from_mem         (frm_mod_desc_manager[`HLP_MOD_MOD_DESC_MANAGER_FROM_MEM_WIDTH-1:0]), // Templated
 .mod_mod_ds_exp_from_mem               (frm_mod_ds_exp[`HLP_MOD_MOD_DS_EXP_FROM_MEM_WIDTH-1:0]), // Templated
 .mod_mod_egress_mst_table_from_mem     (frm_mod_egress_mst_table[`HLP_MOD_MOD_EGRESS_MST_TABLE_FROM_MEM_WIDTH-1:0]), // Templated
 .mod_mod_egress_stats_bank_ip_byte_0_from_mem(frm_mod_egress_stats_bank_ip_byte[0][`HLP_MOD_MOD_EGRESS_STATS_BANK_IP_BYTE_FROM_MEM_WIDTH-1:0]), // Templated
 .mod_mod_egress_stats_bank_ip_byte_1_from_mem(frm_mod_egress_stats_bank_ip_byte[1][`HLP_MOD_MOD_EGRESS_STATS_BANK_IP_BYTE_FROM_MEM_WIDTH-1:0]), // Templated
 .mod_mod_egress_stats_bank_ip_byte_2_from_mem(frm_mod_egress_stats_bank_ip_byte[2][`HLP_MOD_MOD_EGRESS_STATS_BANK_IP_BYTE_FROM_MEM_WIDTH-1:0]), // Templated
 .mod_mod_egress_stats_bank_ip_byte_3_from_mem(frm_mod_egress_stats_bank_ip_byte[3][`HLP_MOD_MOD_EGRESS_STATS_BANK_IP_BYTE_FROM_MEM_WIDTH-1:0]), // Templated
 .mod_mod_egress_stats_bank_ip_frame_0_from_mem(frm_mod_egress_stats_bank_ip_frame[0][`HLP_MOD_MOD_EGRESS_STATS_BANK_IP_FRAME_FROM_MEM_WIDTH-1:0]), // Templated
 .mod_mod_egress_stats_bank_ip_frame_1_from_mem(frm_mod_egress_stats_bank_ip_frame[1][`HLP_MOD_MOD_EGRESS_STATS_BANK_IP_FRAME_FROM_MEM_WIDTH-1:0]), // Templated
 .mod_mod_egress_stats_bank_ip_frame_2_from_mem(frm_mod_egress_stats_bank_ip_frame[2][`HLP_MOD_MOD_EGRESS_STATS_BANK_IP_FRAME_FROM_MEM_WIDTH-1:0]), // Templated
 .mod_mod_egress_stats_bank_ip_frame_3_from_mem(frm_mod_egress_stats_bank_ip_frame[3][`HLP_MOD_MOD_EGRESS_STATS_BANK_IP_FRAME_FROM_MEM_WIDTH-1:0]), // Templated
 .mod_mod_egress_stats_bank_vlan_byte_0_from_mem(frm_mod_egress_stats_bank_vlan_byte[0][`HLP_MOD_MOD_EGRESS_STATS_BANK_VLAN_BYTE_FROM_MEM_WIDTH-1:0]), // Templated
 .mod_mod_egress_stats_bank_vlan_byte_1_from_mem(frm_mod_egress_stats_bank_vlan_byte[1][`HLP_MOD_MOD_EGRESS_STATS_BANK_VLAN_BYTE_FROM_MEM_WIDTH-1:0]), // Templated
 .mod_mod_egress_stats_bank_vlan_byte_2_from_mem(frm_mod_egress_stats_bank_vlan_byte[2][`HLP_MOD_MOD_EGRESS_STATS_BANK_VLAN_BYTE_FROM_MEM_WIDTH-1:0]), // Templated
 .mod_mod_egress_stats_bank_vlan_byte_3_from_mem(frm_mod_egress_stats_bank_vlan_byte[3][`HLP_MOD_MOD_EGRESS_STATS_BANK_VLAN_BYTE_FROM_MEM_WIDTH-1:0]), // Templated
 .mod_mod_egress_stats_bank_vlan_byte_4_from_mem(frm_mod_egress_stats_bank_vlan_byte[4][`HLP_MOD_MOD_EGRESS_STATS_BANK_VLAN_BYTE_FROM_MEM_WIDTH-1:0]), // Templated
 .mod_mod_egress_stats_bank_vlan_byte_5_from_mem(frm_mod_egress_stats_bank_vlan_byte[5][`HLP_MOD_MOD_EGRESS_STATS_BANK_VLAN_BYTE_FROM_MEM_WIDTH-1:0]), // Templated
 .mod_mod_egress_stats_bank_vlan_frame_0_from_mem(frm_mod_egress_stats_bank_vlan_frame[0][`HLP_MOD_MOD_EGRESS_STATS_BANK_VLAN_FRAME_FROM_MEM_WIDTH-1:0]), // Templated
 .mod_mod_egress_stats_bank_vlan_frame_1_from_mem(frm_mod_egress_stats_bank_vlan_frame[1][`HLP_MOD_MOD_EGRESS_STATS_BANK_VLAN_FRAME_FROM_MEM_WIDTH-1:0]), // Templated
 .mod_mod_egress_stats_bank_vlan_frame_2_from_mem(frm_mod_egress_stats_bank_vlan_frame[2][`HLP_MOD_MOD_EGRESS_STATS_BANK_VLAN_FRAME_FROM_MEM_WIDTH-1:0]), // Templated
 .mod_mod_egress_stats_bank_vlan_frame_3_from_mem(frm_mod_egress_stats_bank_vlan_frame[3][`HLP_MOD_MOD_EGRESS_STATS_BANK_VLAN_FRAME_FROM_MEM_WIDTH-1:0]), // Templated
 .mod_mod_egress_stats_bank_vlan_frame_4_from_mem(frm_mod_egress_stats_bank_vlan_frame[4][`HLP_MOD_MOD_EGRESS_STATS_BANK_VLAN_FRAME_FROM_MEM_WIDTH-1:0]), // Templated
 .mod_mod_egress_stats_bank_vlan_frame_5_from_mem(frm_mod_egress_stats_bank_vlan_frame[5][`HLP_MOD_MOD_EGRESS_STATS_BANK_VLAN_FRAME_FROM_MEM_WIDTH-1:0]), // Templated
 .mod_mod_egress_vid_table_from_mem     (frm_mod_egress_vid_table[`HLP_MOD_MOD_EGRESS_VID_TABLE_FROM_MEM_WIDTH-1:0]), // Templated
 .mod_mod_mcast_vlan_table_from_mem     (frm_mod_mcast_vlan_table[`HLP_MOD_MOD_MCAST_VLAN_TABLE_FROM_MEM_WIDTH-1:0]), // Templated
 .mod_mod_per_l2d_cfg_0_from_mem        (frm_mod_per_l2d_cfg[0][`HLP_MOD_MOD_PER_L2D_CFG_FROM_MEM_WIDTH-1:0]), // Templated
 .mod_mod_per_l2d_cfg_1_from_mem        (frm_mod_per_l2d_cfg[1][`HLP_MOD_MOD_PER_L2D_CFG_FROM_MEM_WIDTH-1:0]), // Templated
 .mod_mod_tx_stats_vlan_cnt_idx_map_action_from_mem(frm_mod_tx_stats_vlan_cnt_idx_map_action[`HLP_MOD_MOD_TX_STATS_VLAN_CNT_IDX_MAP_ACTION_FROM_MEM_WIDTH-1:0]), // Templated
 .mod_mod_vid1_map_from_mem             (frm_mod_vid1_map[`HLP_MOD_MOD_VID1_MAP_FROM_MEM_WIDTH-1:0]), // Templated
 .mod_mod_vid2_map_from_mem             (frm_mod_vid2_map[`HLP_MOD_MOD_VID2_MAP_FROM_MEM_WIDTH-1:0]), // Templated
 .mod_mod_vlan_tag_from_mem             (frm_mod_vlan_tag[`HLP_MOD_MOD_VLAN_TAG_FROM_MEM_WIDTH-1:0]), // Templated
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
 .fscan_clkungate                       (fscan_clkungate),
 .fscan_ram_bypsel_sram                 (fscan_ram_bypsel_sram),
 .fscan_ram_init_en                     (fscan_ram_init_en),
 .fscan_ram_init_val                    (fscan_ram_init_val),
 .fscan_ram_rdis_b                      (fscan_ram_rdis_b),
 .fscan_ram_wdis_b                      (fscan_ram_wdis_b),
 .fsta_dfxact_afd                       (fsta_dfxact_afd),
 .ip_reset_b                            (local_broadcast.mem_rst_b), // Templated
 .mod_mod_desc_0_to_mem                 (tom_mod_desc[0][`HLP_MOD_MOD_DESC_TO_MEM_WIDTH-1:0]), // Templated
 .mod_mod_desc_10_to_mem                (tom_mod_desc[10][`HLP_MOD_MOD_DESC_TO_MEM_WIDTH-1:0]), // Templated
 .mod_mod_desc_11_to_mem                (tom_mod_desc[11][`HLP_MOD_MOD_DESC_TO_MEM_WIDTH-1:0]), // Templated
 .mod_mod_desc_12_to_mem                (tom_mod_desc[12][`HLP_MOD_MOD_DESC_TO_MEM_WIDTH-1:0]), // Templated
 .mod_mod_desc_13_to_mem                (tom_mod_desc[13][`HLP_MOD_MOD_DESC_TO_MEM_WIDTH-1:0]), // Templated
 .mod_mod_desc_14_to_mem                (tom_mod_desc[14][`HLP_MOD_MOD_DESC_TO_MEM_WIDTH-1:0]), // Templated
 .mod_mod_desc_15_to_mem                (tom_mod_desc[15][`HLP_MOD_MOD_DESC_TO_MEM_WIDTH-1:0]), // Templated
 .mod_mod_desc_1_to_mem                 (tom_mod_desc[1][`HLP_MOD_MOD_DESC_TO_MEM_WIDTH-1:0]), // Templated
 .mod_mod_desc_2_to_mem                 (tom_mod_desc[2][`HLP_MOD_MOD_DESC_TO_MEM_WIDTH-1:0]), // Templated
 .mod_mod_desc_3_to_mem                 (tom_mod_desc[3][`HLP_MOD_MOD_DESC_TO_MEM_WIDTH-1:0]), // Templated
 .mod_mod_desc_4_to_mem                 (tom_mod_desc[4][`HLP_MOD_MOD_DESC_TO_MEM_WIDTH-1:0]), // Templated
 .mod_mod_desc_5_to_mem                 (tom_mod_desc[5][`HLP_MOD_MOD_DESC_TO_MEM_WIDTH-1:0]), // Templated
 .mod_mod_desc_6_to_mem                 (tom_mod_desc[6][`HLP_MOD_MOD_DESC_TO_MEM_WIDTH-1:0]), // Templated
 .mod_mod_desc_7_to_mem                 (tom_mod_desc[7][`HLP_MOD_MOD_DESC_TO_MEM_WIDTH-1:0]), // Templated
 .mod_mod_desc_8_to_mem                 (tom_mod_desc[8][`HLP_MOD_MOD_DESC_TO_MEM_WIDTH-1:0]), // Templated
 .mod_mod_desc_9_to_mem                 (tom_mod_desc[9][`HLP_MOD_MOD_DESC_TO_MEM_WIDTH-1:0]), // Templated
 .mod_mod_desc_manager_to_mem           (tom_mod_desc_manager[`HLP_MOD_MOD_DESC_MANAGER_TO_MEM_WIDTH-1:0]), // Templated
 .mod_mod_ds_exp_to_mem                 (tom_mod_ds_exp[`HLP_MOD_MOD_DS_EXP_TO_MEM_WIDTH-1:0]), // Templated
 .mod_mod_egress_mst_table_to_mem       (tom_mod_egress_mst_table[`HLP_MOD_MOD_EGRESS_MST_TABLE_TO_MEM_WIDTH-1:0]), // Templated
 .mod_mod_egress_stats_bank_ip_byte_0_to_mem(tom_mod_egress_stats_bank_ip_byte[0][`HLP_MOD_MOD_EGRESS_STATS_BANK_IP_BYTE_TO_MEM_WIDTH-1:0]), // Templated
 .mod_mod_egress_stats_bank_ip_byte_1_to_mem(tom_mod_egress_stats_bank_ip_byte[1][`HLP_MOD_MOD_EGRESS_STATS_BANK_IP_BYTE_TO_MEM_WIDTH-1:0]), // Templated
 .mod_mod_egress_stats_bank_ip_byte_2_to_mem(tom_mod_egress_stats_bank_ip_byte[2][`HLP_MOD_MOD_EGRESS_STATS_BANK_IP_BYTE_TO_MEM_WIDTH-1:0]), // Templated
 .mod_mod_egress_stats_bank_ip_byte_3_to_mem(tom_mod_egress_stats_bank_ip_byte[3][`HLP_MOD_MOD_EGRESS_STATS_BANK_IP_BYTE_TO_MEM_WIDTH-1:0]), // Templated
 .mod_mod_egress_stats_bank_ip_frame_0_to_mem(tom_mod_egress_stats_bank_ip_frame[0][`HLP_MOD_MOD_EGRESS_STATS_BANK_IP_FRAME_TO_MEM_WIDTH-1:0]), // Templated
 .mod_mod_egress_stats_bank_ip_frame_1_to_mem(tom_mod_egress_stats_bank_ip_frame[1][`HLP_MOD_MOD_EGRESS_STATS_BANK_IP_FRAME_TO_MEM_WIDTH-1:0]), // Templated
 .mod_mod_egress_stats_bank_ip_frame_2_to_mem(tom_mod_egress_stats_bank_ip_frame[2][`HLP_MOD_MOD_EGRESS_STATS_BANK_IP_FRAME_TO_MEM_WIDTH-1:0]), // Templated
 .mod_mod_egress_stats_bank_ip_frame_3_to_mem(tom_mod_egress_stats_bank_ip_frame[3][`HLP_MOD_MOD_EGRESS_STATS_BANK_IP_FRAME_TO_MEM_WIDTH-1:0]), // Templated
 .mod_mod_egress_stats_bank_vlan_byte_0_to_mem(tom_mod_egress_stats_bank_vlan_byte[0][`HLP_MOD_MOD_EGRESS_STATS_BANK_VLAN_BYTE_TO_MEM_WIDTH-1:0]), // Templated
 .mod_mod_egress_stats_bank_vlan_byte_1_to_mem(tom_mod_egress_stats_bank_vlan_byte[1][`HLP_MOD_MOD_EGRESS_STATS_BANK_VLAN_BYTE_TO_MEM_WIDTH-1:0]), // Templated
 .mod_mod_egress_stats_bank_vlan_byte_2_to_mem(tom_mod_egress_stats_bank_vlan_byte[2][`HLP_MOD_MOD_EGRESS_STATS_BANK_VLAN_BYTE_TO_MEM_WIDTH-1:0]), // Templated
 .mod_mod_egress_stats_bank_vlan_byte_3_to_mem(tom_mod_egress_stats_bank_vlan_byte[3][`HLP_MOD_MOD_EGRESS_STATS_BANK_VLAN_BYTE_TO_MEM_WIDTH-1:0]), // Templated
 .mod_mod_egress_stats_bank_vlan_byte_4_to_mem(tom_mod_egress_stats_bank_vlan_byte[4][`HLP_MOD_MOD_EGRESS_STATS_BANK_VLAN_BYTE_TO_MEM_WIDTH-1:0]), // Templated
 .mod_mod_egress_stats_bank_vlan_byte_5_to_mem(tom_mod_egress_stats_bank_vlan_byte[5][`HLP_MOD_MOD_EGRESS_STATS_BANK_VLAN_BYTE_TO_MEM_WIDTH-1:0]), // Templated
 .mod_mod_egress_stats_bank_vlan_frame_0_to_mem(tom_mod_egress_stats_bank_vlan_frame[0][`HLP_MOD_MOD_EGRESS_STATS_BANK_VLAN_FRAME_TO_MEM_WIDTH-1:0]), // Templated
 .mod_mod_egress_stats_bank_vlan_frame_1_to_mem(tom_mod_egress_stats_bank_vlan_frame[1][`HLP_MOD_MOD_EGRESS_STATS_BANK_VLAN_FRAME_TO_MEM_WIDTH-1:0]), // Templated
 .mod_mod_egress_stats_bank_vlan_frame_2_to_mem(tom_mod_egress_stats_bank_vlan_frame[2][`HLP_MOD_MOD_EGRESS_STATS_BANK_VLAN_FRAME_TO_MEM_WIDTH-1:0]), // Templated
 .mod_mod_egress_stats_bank_vlan_frame_3_to_mem(tom_mod_egress_stats_bank_vlan_frame[3][`HLP_MOD_MOD_EGRESS_STATS_BANK_VLAN_FRAME_TO_MEM_WIDTH-1:0]), // Templated
 .mod_mod_egress_stats_bank_vlan_frame_4_to_mem(tom_mod_egress_stats_bank_vlan_frame[4][`HLP_MOD_MOD_EGRESS_STATS_BANK_VLAN_FRAME_TO_MEM_WIDTH-1:0]), // Templated
 .mod_mod_egress_stats_bank_vlan_frame_5_to_mem(tom_mod_egress_stats_bank_vlan_frame[5][`HLP_MOD_MOD_EGRESS_STATS_BANK_VLAN_FRAME_TO_MEM_WIDTH-1:0]), // Templated
 .mod_mod_egress_vid_table_to_mem       (tom_mod_egress_vid_table[`HLP_MOD_MOD_EGRESS_VID_TABLE_TO_MEM_WIDTH-1:0]), // Templated
 .mod_mod_mcast_vlan_table_to_mem       (tom_mod_mcast_vlan_table[`HLP_MOD_MOD_MCAST_VLAN_TABLE_TO_MEM_WIDTH-1:0]), // Templated
 .mod_mod_per_l2d_cfg_0_to_mem          (tom_mod_per_l2d_cfg[0][`HLP_MOD_MOD_PER_L2D_CFG_TO_MEM_WIDTH-1:0]), // Templated
 .mod_mod_per_l2d_cfg_1_to_mem          (tom_mod_per_l2d_cfg[1][`HLP_MOD_MOD_PER_L2D_CFG_TO_MEM_WIDTH-1:0]), // Templated
 .mod_mod_tx_stats_vlan_cnt_idx_map_action_to_mem(tom_mod_tx_stats_vlan_cnt_idx_map_action[`HLP_MOD_MOD_TX_STATS_VLAN_CNT_IDX_MAP_ACTION_TO_MEM_WIDTH-1:0]), // Templated
 .mod_mod_vid1_map_to_mem               (tom_mod_vid1_map[`HLP_MOD_MOD_VID1_MAP_TO_MEM_WIDTH-1:0]), // Templated
 .mod_mod_vid2_map_to_mem               (tom_mod_vid2_map[`HLP_MOD_MOD_VID2_MAP_TO_MEM_WIDTH-1:0]), // Templated
 .mod_mod_vlan_tag_to_mem               (tom_mod_vlan_tag[`HLP_MOD_MOD_VLAN_TAG_TO_MEM_WIDTH-1:0]), // Templated
 .post_mux_ctrl                         ('0),                    // Templated
 .pwr_mgmt_in_sram                      (pwr_mgmt_in_sram[6-1:0]), .bisr_clk_pd_vinf(pd_vinf_bisr_clk), 
 .bisr_shift_en_pd_vinf(pd_vinf_bisr_shift_en), .bisr_reset_pd_vinf(pd_vinf_bisr_reset), 
 .bisr_si_pd_vinf(bisr_so_pd_vinf_ts3), .bisr_so_pd_vinf(bisr_so_pd_vinf_ts1), .fary_ijtag_tck(JT_IN_mbist_ijtag_tck), 
 .fary_ijtag_rst_b(JT_IN_mbist_ijtag_reset_b), .mbist_diag_done(mbist_diag_done_ts2), 
 .fary_ijtag_select(sib_mod_apr_sram_to_select), .fary_ijtag_shift(JT_IN_mbist_ijtag_shift), 
 .fary_ijtag_capture(JT_IN_mbist_ijtag_capture), .fary_ijtag_update(JT_IN_mbist_ijtag_update), 
 .fary_ijtag_si(sib_mod_apr_tcam_so), .aary_ijtag_so(u_mod_apr_sram_mems_so), 
 .fscan_byprst_b(fscan_byprst_b), .fscan_clkgenctrl(fscan_clkgenctrl_ts1), 
 .fscan_clkgenctrlen(fscan_clkgenctrlen_ts1), .fscan_clkungate_syn(fscan_clkungate_syn), 
 .fscan_latchclosed_b(fscan_latchclosed_b), .fscan_latchopen(fscan_latchopen), 
 .fscan_mode(fscan_mode), .fscan_mode_atspeed(fscan_mode_atspeed), 
 .fscan_ram_bypsel_rf(fscan_ram_bypsel_rf), .fscan_ram_bypsel_tcam(fscan_ram_bypsel_tcam), 
 .fscan_ret_ctrl(fscan_ret_ctrl), .fscan_rstbypen(fscan_rstbypen), 
 .fscan_shiften(fscan_shiften), .clk_rscclk(clkout));

hlp_mod_apr_ff_mems u_mod_apr_ff_mems
( // no manual connections
 /*AUTOINST*/
 // Outputs
 .mod_mod_mirror_profile_table2_from_mem(frm_mod_mirror_profile_table2[`HLP_MOD_MOD_MIRROR_PROFILE_TABLE2_FROM_MEM_WIDTH-1:0]), // Templated
 .mod_mod_per_port_cfg1_from_mem        (frm_mod_per_port_cfg1[`HLP_MOD_MOD_PER_PORT_CFG1_FROM_MEM_WIDTH-1:0]), // Templated
 .mod_mod_per_port_cfg2_from_mem        (frm_mod_per_port_cfg2[`HLP_MOD_MOD_PER_PORT_CFG2_FROM_MEM_WIDTH-1:0]), // Templated
 .mod_mod_smac_idx_map_from_mem         (frm_mod_smac_idx_map[`HLP_MOD_MOD_SMAC_IDX_MAP_FROM_MEM_WIDTH-1:0]), // Templated
 .mod_mod_vpri1_map_from_mem            (frm_mod_vpri1_map[`HLP_MOD_MOD_VPRI1_MAP_FROM_MEM_WIDTH-1:0]), // Templated
 .mod_mod_vpri2_map_from_mem            (frm_mod_vpri2_map[`HLP_MOD_MOD_VPRI2_MAP_FROM_MEM_WIDTH-1:0]), // Templated
 // Inputs
 .clk                                   (clk),
 .mod_mod_mirror_profile_table2_to_mem  (tom_mod_mirror_profile_table2[`HLP_MOD_MOD_MIRROR_PROFILE_TABLE2_TO_MEM_WIDTH-1:0]), // Templated
 .mod_mod_per_port_cfg1_to_mem          (tom_mod_per_port_cfg1[`HLP_MOD_MOD_PER_PORT_CFG1_TO_MEM_WIDTH-1:0]), // Templated
 .mod_mod_per_port_cfg2_to_mem          (tom_mod_per_port_cfg2[`HLP_MOD_MOD_PER_PORT_CFG2_TO_MEM_WIDTH-1:0]), // Templated
 .mod_mod_smac_idx_map_to_mem           (tom_mod_smac_idx_map[`HLP_MOD_MOD_SMAC_IDX_MAP_TO_MEM_WIDTH-1:0]), // Templated
 .mod_mod_vpri1_map_to_mem              (tom_mod_vpri1_map[`HLP_MOD_MOD_VPRI1_MAP_TO_MEM_WIDTH-1:0]), // Templated
 .mod_mod_vpri2_map_to_mem              (tom_mod_vpri2_map[`HLP_MOD_MOD_VPRI2_MAP_TO_MEM_WIDTH-1:0])); // Templated

logic aary_pwren_b_rf;
logic fary_trigger_post_mod_rf, aary_post_complete_mod_rf, aary_post_pass_mod_rf;
assign fary_trigger_post_mod_rf = aary_post_complete_mod_sram;
assign aary_post_complete = aary_post_complete_mod_rf;
assign aary_post_pass = aary_post_pass_mod_sram & aary_post_pass_mod_rf;
hlp_mod_apr_rf_mems u_mod_apr_rf_mems
(// Manual connections
.fary_trigger_post_mod_rf,
.aary_post_complete_mod_rf,
.aary_post_pass_mod_rf,
 .fary_pwren_b_rf(aary_pwren_b_sram),
 .aary_pwren_b_rf(aary_pwren_b_rf),
 /*AUTOINST*/
 // Outputs
 .aary_post_complete_rf                 (),                      // Templated
 .aary_post_pass_rf                     (),                      // Templated
 .mod_mod_aqm_profile_from_mem          (frm_mod_aqm_profile[`HLP_MOD_MOD_AQM_PROFILE_FROM_MEM_WIDTH-1:0]), // Templated
 .mod_mod_dscp_map_from_mem             (frm_mod_dscp_map[`HLP_MOD_MOD_DSCP_MAP_FROM_MEM_WIDTH-1:0]), // Templated
 .mod_mod_egress_stats_bank_ip_byte_cache_from_mem(frm_mod_egress_stats_bank_ip_byte_cache[`HLP_MOD_MOD_EGRESS_STATS_BANK_IP_BYTE_CACHE_FROM_MEM_WIDTH-1:0]), // Templated
 .mod_mod_egress_stats_bank_ip_frame_cache_from_mem(frm_mod_egress_stats_bank_ip_frame_cache[`HLP_MOD_MOD_EGRESS_STATS_BANK_IP_FRAME_CACHE_FROM_MEM_WIDTH-1:0]), // Templated
 .mod_mod_egress_stats_bank_vlan_byte_cache_from_mem(frm_mod_egress_stats_bank_vlan_byte_cache[`HLP_MOD_MOD_EGRESS_STATS_BANK_VLAN_BYTE_CACHE_FROM_MEM_WIDTH-1:0]), // Templated
 .mod_mod_egress_stats_bank_vlan_frame_cache_from_mem(frm_mod_egress_stats_bank_vlan_frame_cache[`HLP_MOD_MOD_EGRESS_STATS_BANK_VLAN_FRAME_CACHE_FROM_MEM_WIDTH-1:0]), // Templated
 .mod_mod_stats_bank_byte_from_mem      (frm_mod_stats_bank_byte[`HLP_MOD_MOD_STATS_BANK_BYTE_FROM_MEM_WIDTH-1:0]), // Templated
 .mod_mod_stats_bank_frame_from_mem     (frm_mod_stats_bank_frame[`HLP_MOD_MOD_STATS_BANK_FRAME_FROM_MEM_WIDTH-1:0]), // Templated
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
 .ip_reset_b                            (local_broadcast.mem_rst_b), // Templated
 .mod_mod_aqm_profile_to_mem            (tom_mod_aqm_profile[`HLP_MOD_MOD_AQM_PROFILE_TO_MEM_WIDTH-1:0]), // Templated
 .mod_mod_dscp_map_to_mem               (tom_mod_dscp_map[`HLP_MOD_MOD_DSCP_MAP_TO_MEM_WIDTH-1:0]), // Templated
 .mod_mod_egress_stats_bank_ip_byte_cache_to_mem(tom_mod_egress_stats_bank_ip_byte_cache[`HLP_MOD_MOD_EGRESS_STATS_BANK_IP_BYTE_CACHE_TO_MEM_WIDTH-1:0]), // Templated
 .mod_mod_egress_stats_bank_ip_frame_cache_to_mem(tom_mod_egress_stats_bank_ip_frame_cache[`HLP_MOD_MOD_EGRESS_STATS_BANK_IP_FRAME_CACHE_TO_MEM_WIDTH-1:0]), // Templated
 .mod_mod_egress_stats_bank_vlan_byte_cache_to_mem(tom_mod_egress_stats_bank_vlan_byte_cache[`HLP_MOD_MOD_EGRESS_STATS_BANK_VLAN_BYTE_CACHE_TO_MEM_WIDTH-1:0]), // Templated
 .mod_mod_egress_stats_bank_vlan_frame_cache_to_mem(tom_mod_egress_stats_bank_vlan_frame_cache[`HLP_MOD_MOD_EGRESS_STATS_BANK_VLAN_FRAME_CACHE_TO_MEM_WIDTH-1:0]), // Templated
 .mod_mod_stats_bank_byte_to_mem        (tom_mod_stats_bank_byte[`HLP_MOD_MOD_STATS_BANK_BYTE_TO_MEM_WIDTH-1:0]), // Templated
 .mod_mod_stats_bank_frame_to_mem       (tom_mod_stats_bank_frame[`HLP_MOD_MOD_STATS_BANK_FRAME_TO_MEM_WIDTH-1:0]), // Templated
 .post_mux_ctrl                         ('0),                    // Templated
 .pwr_mgmt_in_rf                        (pwr_mgmt_in_rf[5-1:0]), .bisr_clk_pd_vinf(pd_vinf_bisr_clk), 
 .bisr_shift_en_pd_vinf(pd_vinf_bisr_shift_en), .bisr_reset_pd_vinf(pd_vinf_bisr_reset), 
 .bisr_si_pd_vinf(bisr_so_pd_vinf_ts1), .bisr_so_pd_vinf(bisr_so_pd_vinf_ts2), .fary_ijtag_tck(JT_IN_mbist_ijtag_tck), 
 .fary_ijtag_rst_b(JT_IN_mbist_ijtag_reset_b), .mbist_diag_done(mbist_diag_done_ts1), 
 .fary_ijtag_select(sib_mod_apr_tcam_to_select), .fary_ijtag_shift(JT_IN_mbist_ijtag_shift), 
 .fary_ijtag_capture(JT_IN_mbist_ijtag_capture), .fary_ijtag_update(JT_IN_mbist_ijtag_update), 
 .fary_ijtag_si(JT_IN_mbist_ijtag_si), .aary_ijtag_so(u_mod_apr_rf_mems_so), 
 .fscan_byprst_b(fscan_byprst_b), .fscan_clkgenctrl(fscan_clkgenctrl_ts1), 
 .fscan_clkgenctrlen(fscan_clkgenctrlen_ts1), .fscan_clkungate_syn(fscan_clkungate_syn), 
 .fscan_latchclosed_b(fscan_latchclosed_b), .fscan_latchopen(fscan_latchopen), 
 .fscan_mode(fscan_mode), .fscan_mode_atspeed(fscan_mode_atspeed), 
 .fscan_ram_bypsel_sram(fscan_ram_bypsel_sram), .fscan_ram_bypsel_tcam(fscan_ram_bypsel_tcam), 
 .fscan_ret_ctrl(fscan_ret_ctrl), .fscan_rstbypen(fscan_rstbypen), 
 .fscan_shiften(fscan_shiften), .clk_rscclk(clkout));

logic aary_pwren_b_tcam;
hlp_mod_apr_tcam_mems u_mod_apr_tcam_mems
(// Manual connections
`ifdef HLP_FPGA_TCAM_MEMS
 .fpga_fast_clk(),
`endif
.fary_pwren_b_tcam(aary_pwren_b_rf),
 .aary_pwren_b_tcam(aary_pwren_b_tcam),
 /*AUTOINST*/
 // Outputs
 .mod_mod_ms_sci_table_tcam_0_from_tcam (frm_mod_ms_sci_table_tcam[0][`HLP_MOD_MOD_MS_SCI_TABLE_TCAM_FROM_TCAM_WIDTH-1:0]), // Templated
 .mod_mod_ms_sci_table_tcam_1_from_tcam (frm_mod_ms_sci_table_tcam[1][`HLP_MOD_MOD_MS_SCI_TABLE_TCAM_FROM_TCAM_WIDTH-1:0]), // Templated
 .mod_mod_tx_stats_vlan_cnt_idx_map_tcam_0_from_tcam(frm_mod_tx_stats_vlan_cnt_idx_map_tcam[0][`HLP_MOD_MOD_TX_STATS_VLAN_CNT_IDX_MAP_TCAM_FROM_TCAM_WIDTH-1:0]), // Templated
 .mod_mod_tx_stats_vlan_cnt_idx_map_tcam_1_from_tcam(frm_mod_tx_stats_vlan_cnt_idx_map_tcam[1][`HLP_MOD_MOD_TX_STATS_VLAN_CNT_IDX_MAP_TCAM_FROM_TCAM_WIDTH-1:0]), // Templated
 .mod_mod_tx_stats_vlan_cnt_idx_map_tcam_2_from_tcam(frm_mod_tx_stats_vlan_cnt_idx_map_tcam[2][`HLP_MOD_MOD_TX_STATS_VLAN_CNT_IDX_MAP_TCAM_FROM_TCAM_WIDTH-1:0]), // Templated
 .mod_mod_tx_stats_vlan_cnt_idx_map_tcam_3_from_tcam(frm_mod_tx_stats_vlan_cnt_idx_map_tcam[3][`HLP_MOD_MOD_TX_STATS_VLAN_CNT_IDX_MAP_TCAM_FROM_TCAM_WIDTH-1:0]), // Templated
 .mod_mod_tx_stats_vlan_cnt_idx_map_tcam_4_from_tcam(frm_mod_tx_stats_vlan_cnt_idx_map_tcam[4][`HLP_MOD_MOD_TX_STATS_VLAN_CNT_IDX_MAP_TCAM_FROM_TCAM_WIDTH-1:0]), // Templated
 .mod_mod_tx_stats_vlan_cnt_idx_map_tcam_5_from_tcam(frm_mod_tx_stats_vlan_cnt_idx_map_tcam[5][`HLP_MOD_MOD_TX_STATS_VLAN_CNT_IDX_MAP_TCAM_FROM_TCAM_WIDTH-1:0]), // Templated
 .mod_mod_tx_stats_vlan_cnt_idx_map_tcam_6_from_tcam(frm_mod_tx_stats_vlan_cnt_idx_map_tcam[6][`HLP_MOD_MOD_TX_STATS_VLAN_CNT_IDX_MAP_TCAM_FROM_TCAM_WIDTH-1:0]), // Templated
 .mod_mod_tx_stats_vlan_cnt_idx_map_tcam_7_from_tcam(frm_mod_tx_stats_vlan_cnt_idx_map_tcam[7][`HLP_MOD_MOD_TX_STATS_VLAN_CNT_IDX_MAP_TCAM_FROM_TCAM_WIDTH-1:0]), // Templated
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
 .ip_reset_b                            (local_broadcast.mem_rst_b), // Templated
 .mod_mod_ms_sci_table_tcam_0_to_tcam   (tom_mod_ms_sci_table_tcam[0][`HLP_MOD_MOD_MS_SCI_TABLE_TCAM_TO_TCAM_WIDTH-1:0]), // Templated
 .mod_mod_ms_sci_table_tcam_1_to_tcam   (tom_mod_ms_sci_table_tcam[1][`HLP_MOD_MOD_MS_SCI_TABLE_TCAM_TO_TCAM_WIDTH-1:0]), // Templated
 .mod_mod_tx_stats_vlan_cnt_idx_map_tcam_0_to_tcam(tom_mod_tx_stats_vlan_cnt_idx_map_tcam[0][`HLP_MOD_MOD_TX_STATS_VLAN_CNT_IDX_MAP_TCAM_TO_TCAM_WIDTH-1:0]), // Templated
 .mod_mod_tx_stats_vlan_cnt_idx_map_tcam_1_to_tcam(tom_mod_tx_stats_vlan_cnt_idx_map_tcam[1][`HLP_MOD_MOD_TX_STATS_VLAN_CNT_IDX_MAP_TCAM_TO_TCAM_WIDTH-1:0]), // Templated
 .mod_mod_tx_stats_vlan_cnt_idx_map_tcam_2_to_tcam(tom_mod_tx_stats_vlan_cnt_idx_map_tcam[2][`HLP_MOD_MOD_TX_STATS_VLAN_CNT_IDX_MAP_TCAM_TO_TCAM_WIDTH-1:0]), // Templated
 .mod_mod_tx_stats_vlan_cnt_idx_map_tcam_3_to_tcam(tom_mod_tx_stats_vlan_cnt_idx_map_tcam[3][`HLP_MOD_MOD_TX_STATS_VLAN_CNT_IDX_MAP_TCAM_TO_TCAM_WIDTH-1:0]), // Templated
 .mod_mod_tx_stats_vlan_cnt_idx_map_tcam_4_to_tcam(tom_mod_tx_stats_vlan_cnt_idx_map_tcam[4][`HLP_MOD_MOD_TX_STATS_VLAN_CNT_IDX_MAP_TCAM_TO_TCAM_WIDTH-1:0]), // Templated
 .mod_mod_tx_stats_vlan_cnt_idx_map_tcam_5_to_tcam(tom_mod_tx_stats_vlan_cnt_idx_map_tcam[5][`HLP_MOD_MOD_TX_STATS_VLAN_CNT_IDX_MAP_TCAM_TO_TCAM_WIDTH-1:0]), // Templated
 .mod_mod_tx_stats_vlan_cnt_idx_map_tcam_6_to_tcam(tom_mod_tx_stats_vlan_cnt_idx_map_tcam[6][`HLP_MOD_MOD_TX_STATS_VLAN_CNT_IDX_MAP_TCAM_TO_TCAM_WIDTH-1:0]), // Templated
 .mod_mod_tx_stats_vlan_cnt_idx_map_tcam_7_to_tcam(tom_mod_tx_stats_vlan_cnt_idx_map_tcam[7][`HLP_MOD_MOD_TX_STATS_VLAN_CNT_IDX_MAP_TCAM_TO_TCAM_WIDTH-1:0]), 
 .bisr_clk_pd_vinf(pd_vinf_bisr_clk), .bisr_shift_en_pd_vinf(pd_vinf_bisr_shift_en), 
 .bisr_reset_pd_vinf(pd_vinf_bisr_reset), .bisr_si_pd_vinf(pd_vinf_bisr_si), 
 .bisr_so_pd_vinf(bisr_so_pd_vinf_ts3), .fary_ijtag_tck(JT_IN_mbist_ijtag_tck), .fary_ijtag_rst_b(JT_IN_mbist_ijtag_reset_b), 
 .mbist_diag_done(mbist_diag_done_ts3), .fary_ijtag_select(sib_mod_apr_tcam_1_to_select), 
 .fary_ijtag_shift(JT_IN_mbist_ijtag_shift), .fary_ijtag_capture(JT_IN_mbist_ijtag_capture), 
 .fary_ijtag_update(JT_IN_mbist_ijtag_update), .fary_ijtag_si(sib_mod_apr_sram_so), 
 .aary_ijtag_so(u_mod_apr_tcam_mems_so), .fscan_byprst_b(fscan_byprst_b), 
 .fscan_clkgenctrl(fscan_clkgenctrl_ts1), .fscan_clkgenctrlen(fscan_clkgenctrlen_ts1), 
 .fscan_clkungate_syn(fscan_clkungate_syn), .fscan_latchclosed_b(fscan_latchclosed_b), 
 .fscan_latchopen(fscan_latchopen), .fscan_mode_atspeed(fscan_mode_atspeed), 
 .fscan_ram_bypsel_rf(fscan_ram_bypsel_rf), .fscan_ram_bypsel_sram(fscan_ram_bypsel_sram), 
 .fscan_ret_ctrl(fscan_ret_ctrl), .fscan_rstbypen(fscan_rstbypen), 
 .clk_rscclk(clkout)); // Templated

assign fet_ack_b = aary_pwren_b_tcam;
/*
 hlp_mod_apr_func_logic AUTO_TEMPLATE
 ( .o_tom_\(.*\) (tom_\1[][]),
   .i_frm_\(.*\) (frm_\1[][]),
   .mem_rst_n (local_broadcast.mem_rst_b),
   .o_post_cntrlr_select_sram (post_cntrlr_select_sram_from_apr),
   .i_trigger_post_sram  (trigger_post_to_apr),
   .i_post_complete_sram (post_complete_to_apr),
   .i_post_pass_sram     (post_pass_to_apr),
   .i_broadcast  (local_broadcast) );
*/
hlp_mod_apr_func_logic u_mod_apr_func_logic
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
 .ascan_sdo                             (ascan_sdo[hlp_dfx_pkg::MOD_NUM_SDO-1:0]),
 .o_exbar_segment                       (o_exbar_segment),
 .o_exbar_segment_v                     (o_exbar_segment_v),
 .o_feedthru_rpl_bkwd                   (o_feedthru_rpl_bkwd),
 .o_feedthru_rpl_frwd                   (o_feedthru_rpl_frwd),
 .o_fixed_sched                         (o_fixed_sched),
 .o_fixed_sched_v                       (o_fixed_sched_v),
 .o_hlp_dts_diode2_anode                (o_hlp_dts_diode2_anode),
 .o_hlp_dts_diode2_cathode              (o_hlp_dts_diode2_cathode),
 .o_pause_ripple                        (o_pause_ripple),
 .o_pause_ripple_ret                    (o_pause_ripple_ret),
 .o_pause_ripple_ret_v                  (o_pause_ripple_ret_v),
 .o_pause_ripple_v                      (o_pause_ripple_v),
 .o_refcnt_tx_info                      (o_refcnt_tx_info),
 .o_refcnt_tx_info_v                    (o_refcnt_tx_info_v),
 .o_rpl_bkwd                            (o_rpl_bkwd),
 .o_rpl_frwd                            (o_rpl_frwd),
 .o_tom_mod_aqm_profile                 (tom_mod_aqm_profile[`HLP_MOD_MOD_AQM_PROFILE_TO_MEM_WIDTH-1:0]), // Templated
 .o_tom_mod_desc                        (tom_mod_desc/*[hlp_mod_pkg::N_DESC_MEMS-1:0][`HLP_MOD_MOD_DESC_TO_MEM_WIDTH-1:0]*/), // Templated
 .o_tom_mod_desc_manager                (tom_mod_desc_manager[`HLP_MOD_MOD_DESC_MANAGER_TO_MEM_WIDTH-1:0]), // Templated
 .o_tom_mod_ds_exp                      (tom_mod_ds_exp[`HLP_MOD_MOD_DS_EXP_TO_MEM_WIDTH-1:0]), // Templated
 .o_tom_mod_dscp_map                    (tom_mod_dscp_map[`HLP_MOD_MOD_DSCP_MAP_TO_MEM_WIDTH-1:0]), // Templated
 .o_tom_mod_egress_mst_table            (tom_mod_egress_mst_table[`HLP_MOD_MOD_EGRESS_MST_TABLE_TO_MEM_WIDTH-1:0]), // Templated
 .o_tom_mod_egress_stats_bank_ip_byte   (tom_mod_egress_stats_bank_ip_byte/*[hlp_mod_pkg::N_IP_BANKS-1:0][`HLP_MOD_MOD_EGRESS_STATS_BANK_IP_BYTE_TO_MEM_WIDTH-1:0]*/), // Templated
 .o_tom_mod_egress_stats_bank_ip_byte_cache(tom_mod_egress_stats_bank_ip_byte_cache[`HLP_MOD_MOD_EGRESS_STATS_BANK_IP_BYTE_CACHE_TO_MEM_WIDTH-1:0]), // Templated
 .o_tom_mod_egress_stats_bank_ip_frame  (tom_mod_egress_stats_bank_ip_frame/*[hlp_mod_pkg::N_IP_BANKS-1:0][`HLP_MOD_MOD_EGRESS_STATS_BANK_IP_FRAME_TO_MEM_WIDTH-1:0]*/), // Templated
 .o_tom_mod_egress_stats_bank_ip_frame_cache(tom_mod_egress_stats_bank_ip_frame_cache[`HLP_MOD_MOD_EGRESS_STATS_BANK_IP_FRAME_CACHE_TO_MEM_WIDTH-1:0]), // Templated
 .o_tom_mod_egress_stats_bank_vlan_byte (tom_mod_egress_stats_bank_vlan_byte/*[hlp_mod_pkg::N_VLAN_BANKS-1:0][`HLP_MOD_MOD_EGRESS_STATS_BANK_VLAN_BYTE_TO_MEM_WIDTH-1:0]*/), // Templated
 .o_tom_mod_egress_stats_bank_vlan_byte_cache(tom_mod_egress_stats_bank_vlan_byte_cache[`HLP_MOD_MOD_EGRESS_STATS_BANK_VLAN_BYTE_CACHE_TO_MEM_WIDTH-1:0]), // Templated
 .o_tom_mod_egress_stats_bank_vlan_frame(tom_mod_egress_stats_bank_vlan_frame/*[hlp_mod_pkg::N_VLAN_BANKS-1:0][`HLP_MOD_MOD_EGRESS_STATS_BANK_VLAN_FRAME_TO_MEM_WIDTH-1:0]*/), // Templated
 .o_tom_mod_egress_stats_bank_vlan_frame_cache(tom_mod_egress_stats_bank_vlan_frame_cache[`HLP_MOD_MOD_EGRESS_STATS_BANK_VLAN_FRAME_CACHE_TO_MEM_WIDTH-1:0]), // Templated
 .o_tom_mod_egress_vid_table            (tom_mod_egress_vid_table[`HLP_MOD_MOD_EGRESS_VID_TABLE_TO_MEM_WIDTH-1:0]), // Templated
 .o_tom_mod_mcast_vlan_table            (tom_mod_mcast_vlan_table[`HLP_MOD_MOD_MCAST_VLAN_TABLE_TO_MEM_WIDTH-1:0]), // Templated
 .o_tom_mod_mirror_profile_table2       (tom_mod_mirror_profile_table2[`HLP_MOD_MOD_MIRROR_PROFILE_TABLE2_TO_MEM_WIDTH-1:0]), // Templated
 .o_tom_mod_ms_sci_table_tcam           (tom_mod_ms_sci_table_tcam/*[2-1:0][`HLP_MOD_MOD_MS_SCI_TABLE_TCAM_TO_TCAM_WIDTH-1:0]*/), // Templated
 .o_tom_mod_per_l2d_cfg                 (tom_mod_per_l2d_cfg/*[1:0][`HLP_MOD_MOD_PER_L2D_CFG_TO_MEM_WIDTH-1:0]*/), // Templated
 .o_tom_mod_per_port_cfg1               (tom_mod_per_port_cfg1[`HLP_MOD_MOD_PER_PORT_CFG1_TO_MEM_WIDTH-1:0]), // Templated
 .o_tom_mod_per_port_cfg2               (tom_mod_per_port_cfg2[`HLP_MOD_MOD_PER_PORT_CFG2_TO_MEM_WIDTH-1:0]), // Templated
 .o_tom_mod_smac_idx_map                (tom_mod_smac_idx_map[`HLP_MOD_MOD_SMAC_IDX_MAP_TO_MEM_WIDTH-1:0]), // Templated
 .o_tom_mod_stats_bank_byte             (tom_mod_stats_bank_byte[`HLP_MOD_MOD_STATS_BANK_BYTE_TO_MEM_WIDTH-1:0]), // Templated
 .o_tom_mod_stats_bank_frame            (tom_mod_stats_bank_frame[`HLP_MOD_MOD_STATS_BANK_FRAME_TO_MEM_WIDTH-1:0]), // Templated
 .o_tom_mod_tx_stats_vlan_cnt_idx_map_action(tom_mod_tx_stats_vlan_cnt_idx_map_action[`HLP_MOD_MOD_TX_STATS_VLAN_CNT_IDX_MAP_ACTION_TO_MEM_WIDTH-1:0]), // Templated
 .o_tom_mod_tx_stats_vlan_cnt_idx_map_tcam(tom_mod_tx_stats_vlan_cnt_idx_map_tcam/*[8-1:0][`HLP_MOD_MOD_TX_STATS_VLAN_CNT_IDX_MAP_TCAM_TO_TCAM_WIDTH-1:0]*/), // Templated
 .o_tom_mod_vid1_map                    (tom_mod_vid1_map[`HLP_MOD_MOD_VID1_MAP_TO_MEM_WIDTH-1:0]), // Templated
 .o_tom_mod_vid2_map                    (tom_mod_vid2_map[`HLP_MOD_MOD_VID2_MAP_TO_MEM_WIDTH-1:0]), // Templated
 .o_tom_mod_vlan_tag                    (tom_mod_vlan_tag[`HLP_MOD_MOD_VLAN_TAG_TO_MEM_WIDTH-1:0]), // Templated
 .o_tom_mod_vpri1_map                   (tom_mod_vpri1_map[`HLP_MOD_MOD_VPRI1_MAP_TO_MEM_WIDTH-1:0]), // Templated
 .o_tom_mod_vpri2_map                   (tom_mod_vpri2_map[`HLP_MOD_MOD_VPRI2_MAP_TO_MEM_WIDTH-1:0]), // Templated
 .o_tx_credits                          (o_tx_credits),
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
 .fscan_clkgenctrl                      (fscan_clkgenctrl[hlp_dfx_pkg::MOD_NUM_CLKGENCTRL-1:0]),
 .fscan_clkgenctrlen                    (fscan_clkgenctrlen[hlp_dfx_pkg::MOD_NUM_CLKGENCTRLEN-1:0]),
 .fscan_sdi                             (fscan_sdi[hlp_dfx_pkg::MOD_NUM_SDI-1:0]),
 .clk                                   (clk),
 .fscan_byprst_b                        (fscan_byprst_b),
 .fscan_rstbypen                        (fscan_rstbypen),
 .i_broadcast                           (local_broadcast),       // Templated
 .i_cm                                  (i_cm),
 .i_cm_v                                (i_cm_v),
 .i_feedthru_rpl_bkwd                   (i_feedthru_rpl_bkwd),
 .i_feedthru_rpl_frwd                   (i_feedthru_rpl_frwd),
 .i_fixed_sched                         (i_fixed_sched),
 .i_fixed_sched_v                       (i_fixed_sched_v),
 .i_frm_mod_aqm_profile                 (frm_mod_aqm_profile[`HLP_MOD_MOD_AQM_PROFILE_FROM_MEM_WIDTH-1:0]), // Templated
 .i_frm_mod_desc                        (frm_mod_desc/*[hlp_mod_pkg::N_DESC_MEMS-1:0][`HLP_MOD_MOD_DESC_FROM_MEM_WIDTH-1:0]*/), // Templated
 .i_frm_mod_desc_manager                (frm_mod_desc_manager[`HLP_MOD_MOD_DESC_MANAGER_FROM_MEM_WIDTH-1:0]), // Templated
 .i_frm_mod_ds_exp                      (frm_mod_ds_exp[`HLP_MOD_MOD_DS_EXP_FROM_MEM_WIDTH-1:0]), // Templated
 .i_frm_mod_dscp_map                    (frm_mod_dscp_map[`HLP_MOD_MOD_DSCP_MAP_FROM_MEM_WIDTH-1:0]), // Templated
 .i_frm_mod_egress_mst_table            (frm_mod_egress_mst_table[`HLP_MOD_MOD_EGRESS_MST_TABLE_FROM_MEM_WIDTH-1:0]), // Templated
 .i_frm_mod_egress_stats_bank_ip_byte   (frm_mod_egress_stats_bank_ip_byte/*[hlp_mod_pkg::N_IP_BANKS-1:0][`HLP_MOD_MOD_EGRESS_STATS_BANK_IP_BYTE_FROM_MEM_WIDTH-1:0]*/), // Templated
 .i_frm_mod_egress_stats_bank_ip_byte_cache(frm_mod_egress_stats_bank_ip_byte_cache[`HLP_MOD_MOD_EGRESS_STATS_BANK_IP_BYTE_CACHE_FROM_MEM_WIDTH-1:0]), // Templated
 .i_frm_mod_egress_stats_bank_ip_frame  (frm_mod_egress_stats_bank_ip_frame/*[hlp_mod_pkg::N_IP_BANKS-1:0][`HLP_MOD_MOD_EGRESS_STATS_BANK_IP_FRAME_FROM_MEM_WIDTH-1:0]*/), // Templated
 .i_frm_mod_egress_stats_bank_ip_frame_cache(frm_mod_egress_stats_bank_ip_frame_cache[`HLP_MOD_MOD_EGRESS_STATS_BANK_IP_FRAME_CACHE_FROM_MEM_WIDTH-1:0]), // Templated
 .i_frm_mod_egress_stats_bank_vlan_byte (frm_mod_egress_stats_bank_vlan_byte/*[hlp_mod_pkg::N_VLAN_BANKS-1:0][`HLP_MOD_MOD_EGRESS_STATS_BANK_VLAN_BYTE_FROM_MEM_WIDTH-1:0]*/), // Templated
 .i_frm_mod_egress_stats_bank_vlan_byte_cache(frm_mod_egress_stats_bank_vlan_byte_cache[`HLP_MOD_MOD_EGRESS_STATS_BANK_VLAN_BYTE_CACHE_FROM_MEM_WIDTH-1:0]), // Templated
 .i_frm_mod_egress_stats_bank_vlan_frame(frm_mod_egress_stats_bank_vlan_frame/*[hlp_mod_pkg::N_VLAN_BANKS-1:0][`HLP_MOD_MOD_EGRESS_STATS_BANK_VLAN_FRAME_FROM_MEM_WIDTH-1:0]*/), // Templated
 .i_frm_mod_egress_stats_bank_vlan_frame_cache(frm_mod_egress_stats_bank_vlan_frame_cache[`HLP_MOD_MOD_EGRESS_STATS_BANK_VLAN_FRAME_CACHE_FROM_MEM_WIDTH-1:0]), // Templated
 .i_frm_mod_egress_vid_table            (frm_mod_egress_vid_table[`HLP_MOD_MOD_EGRESS_VID_TABLE_FROM_MEM_WIDTH-1:0]), // Templated
 .i_frm_mod_mcast_vlan_table            (frm_mod_mcast_vlan_table[`HLP_MOD_MOD_MCAST_VLAN_TABLE_FROM_MEM_WIDTH-1:0]), // Templated
 .i_frm_mod_mirror_profile_table2       (frm_mod_mirror_profile_table2[`HLP_MOD_MOD_MIRROR_PROFILE_TABLE2_FROM_MEM_WIDTH-1:0]), // Templated
 .i_frm_mod_ms_sci_table_tcam           (frm_mod_ms_sci_table_tcam/*[2-1:0][`HLP_MOD_MOD_MS_SCI_TABLE_TCAM_FROM_TCAM_WIDTH-1:0]*/), // Templated
 .i_frm_mod_per_l2d_cfg                 (frm_mod_per_l2d_cfg/*[1:0][`HLP_MOD_MOD_PER_L2D_CFG_FROM_MEM_WIDTH-1:0]*/), // Templated
 .i_frm_mod_per_port_cfg1               (frm_mod_per_port_cfg1[`HLP_MOD_MOD_PER_PORT_CFG1_FROM_MEM_WIDTH-1:0]), // Templated
 .i_frm_mod_per_port_cfg2               (frm_mod_per_port_cfg2[`HLP_MOD_MOD_PER_PORT_CFG2_FROM_MEM_WIDTH-1:0]), // Templated
 .i_frm_mod_smac_idx_map                (frm_mod_smac_idx_map[`HLP_MOD_MOD_SMAC_IDX_MAP_FROM_MEM_WIDTH-1:0]), // Templated
 .i_frm_mod_stats_bank_byte             (frm_mod_stats_bank_byte[`HLP_MOD_MOD_STATS_BANK_BYTE_FROM_MEM_WIDTH-1:0]), // Templated
 .i_frm_mod_stats_bank_frame            (frm_mod_stats_bank_frame[`HLP_MOD_MOD_STATS_BANK_FRAME_FROM_MEM_WIDTH-1:0]), // Templated
 .i_frm_mod_tx_stats_vlan_cnt_idx_map_action(frm_mod_tx_stats_vlan_cnt_idx_map_action[`HLP_MOD_MOD_TX_STATS_VLAN_CNT_IDX_MAP_ACTION_FROM_MEM_WIDTH-1:0]), // Templated
 .i_frm_mod_tx_stats_vlan_cnt_idx_map_tcam(frm_mod_tx_stats_vlan_cnt_idx_map_tcam/*[8-1:0][`HLP_MOD_MOD_TX_STATS_VLAN_CNT_IDX_MAP_TCAM_FROM_TCAM_WIDTH-1:0]*/), // Templated
 .i_frm_mod_vid1_map                    (frm_mod_vid1_map[`HLP_MOD_MOD_VID1_MAP_FROM_MEM_WIDTH-1:0]), // Templated
 .i_frm_mod_vid2_map                    (frm_mod_vid2_map[`HLP_MOD_MOD_VID2_MAP_FROM_MEM_WIDTH-1:0]), // Templated
 .i_frm_mod_vlan_tag                    (frm_mod_vlan_tag[`HLP_MOD_MOD_VLAN_TAG_FROM_MEM_WIDTH-1:0]), // Templated
 .i_frm_mod_vpri1_map                   (frm_mod_vpri1_map[`HLP_MOD_MOD_VPRI1_MAP_FROM_MEM_WIDTH-1:0]), // Templated
 .i_frm_mod_vpri2_map                   (frm_mod_vpri2_map[`HLP_MOD_MOD_VPRI2_MAP_FROM_MEM_WIDTH-1:0]), // Templated
 .i_hlp_dts_diode2_anode                (i_hlp_dts_diode2_anode),
 .i_hlp_dts_diode2_cathode              (i_hlp_dts_diode2_cathode),
 .i_modify_ctrl                         (i_modify_ctrl),
 .i_modify_ctrl_v                       (i_modify_ctrl_v),
 .i_pause_ripple                        (i_pause_ripple),
 .i_pause_ripple_ret                    (i_pause_ripple_ret),
 .i_pause_ripple_ret_v                  (i_pause_ripple_ret_v),
 .i_pause_ripple_v                      (i_pause_ripple_v),
 .i_pm_read                             (i_pm_read),
 .i_rpl_bkwd                            (i_rpl_bkwd),
 .i_rpl_frwd                            (i_rpl_frwd),
 .i_tx_credits                          (i_tx_credits),
 .rst_n                                 (local_rst_n));


  /* Added by UltiBuild Instances Start */
  buf mgc_hdle_prim(fscan_clkgenctrl_ts1, fscan_clkgenctrl[0]);

  buf mgc_hdle_prim_1(fscan_clkgenctrlen_ts1, fscan_clkgenctrlen[0]);
  /* Added by UltiBuild Instances End */
endmodule
