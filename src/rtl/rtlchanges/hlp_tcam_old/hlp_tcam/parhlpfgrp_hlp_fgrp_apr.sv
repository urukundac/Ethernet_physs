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


module parhlpfgrp_hlp_fgrp_apr
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
input fsta_afd_en,
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
output logic [1:0]      o_ptr_v                // From u_fgrp_apr_func_logic of hlp_fgrp_apr_func_logic.v
// End of automatics
, input wire pd_vinf_bisr_si, output wire bisr_so_pd_vinf_ts2, 
input wire pd_vinf_bisr_clk, input wire pd_vinf_bisr_reset, 
input wire pd_vinf_bisr_shift_en, output wire mbist_diag_done_ts1, 
output wire mbist_diag_done_ts2, output wire mbist_diag_done_ts3, 
output wire u_fgrp_apr_tcam_mems_so, output wire u_fgrp_apr_sram_mems_so, 
output wire u_fgrp_apr_rf_mems_so, input wire sib_fgrp_apr_sram_so, 
input wire sib_fgrp_apr_rf_to_select, input wire sib_fgrp_apr_tcam_so, 
input wire sib_fgrp_apr_sram_to_select, input wire JT_IN_mbist_ijtag_si, 
input wire sib_fgrp_apr_tcam_to_select, input wire JT_IN_mbist_ijtag_tck, 
input wire JT_IN_mbist_ijtag_shift, input wire JT_IN_mbist_ijtag_update, 
input wire JT_IN_mbist_ijtag_reset_b, input wire JT_IN_mbist_ijtag_capture, 
input wire clkout);

//localparam N_INST_SRAM_MEMS = ; // fscan workaround
//localparam N_INST_RF_MEMS   = ; // fscan workaround

logic [hlp_pkg::N_FFU_GROUP_SLICES-1:0][hlp_pkg::N_FFU_GROUP_TPS-1:0][`HLP_FGRP_FFU_TCAM_FROM_TCAM_WIDTH-1:0] nm_frm_ffu_tcam;
logic [hlp_pkg::N_FFU_GROUP_SLICES-1:0][hlp_pkg::N_FFU_GROUP_TPS-1:0][`HLP_FGRP_FFU_TCAM_TO_TCAM_WIDTH-1:0] nm_tom_ffu_tcam;

hlp_pkg::imn_broadcast_t broadcast_struct;

  /* Added by UltiBuild Nets Start */
  wire bisr_so_pd_vinf_ts1, bisr_so_pd_vinf_ts3;
  /* Added by UltiBuild Nets End */

  /* Added by UltiBuild Nets Start */
  wire fscan_clkgenctrl_ts1, fscan_clkgenctrlen_ts1;
  /* Added by UltiBuild Nets End */
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
  (.clk(clk), .rstb(local_broadcast.mem_rst_b), .d(fary_trigger_post_sram), .o(fary_trigger_post_sram_sync) );
assign aary_post_complete_sram = aary_post_complete_fghash_sram & aary_post_complete_fgrp_sram;
always_ff @(posedge clk) begin
  aary_post_pass_sram <= fary_post_pass_sram & aary_post_pass_fghash_sram & aary_post_pass_fgrp_sram;
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
 .clk                                   (clk),
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
 .pwr_mgmt_in_sram                      (pwr_mgmt_in_sram[6-1:0]), .bisr_clk_pd_vinf(pd_vinf_bisr_clk), 
 .bisr_shift_en_pd_vinf(pd_vinf_bisr_shift_en), .bisr_reset_pd_vinf(pd_vinf_bisr_reset), 
 .bisr_si_pd_vinf(bisr_so_pd_vinf_ts3), .bisr_so_pd_vinf(bisr_so_pd_vinf_ts1), .fary_ijtag_tck(JT_IN_mbist_ijtag_tck), 
 .fary_ijtag_rst_b(JT_IN_mbist_ijtag_reset_b), .mbist_diag_done(mbist_diag_done_ts2), 
 .fary_ijtag_select(sib_fgrp_apr_sram_to_select), .fary_ijtag_shift(JT_IN_mbist_ijtag_shift), 
 .fary_ijtag_capture(JT_IN_mbist_ijtag_capture), .fary_ijtag_update(JT_IN_mbist_ijtag_update), 
 .fary_ijtag_si(sib_fgrp_apr_tcam_so), .aary_ijtag_so(u_fgrp_apr_sram_mems_so), 
 .fscan_byprst_b(fscan_byprst_b), .fscan_clkgenctrl(fscan_clkgenctrl_ts1), 
 .fscan_clkgenctrlen(fscan_clkgenctrlen_ts1), .fscan_clkungate_syn(fscan_clkungate_syn), 
 .fscan_latchclosed_b(fscan_latchclosed_b), .fscan_latchopen(fscan_latchopen), 
 .fscan_mode(fscan_mode), .fscan_mode_atspeed(fscan_mode_atspeed), 
 .fscan_ram_bypsel_rf(fscan_ram_bypsel_rf), .fscan_ram_bypsel_tcam(fscan_ram_bypsel_tcam), 
 .fscan_ret_ctrl(fscan_ret_ctrl), .fscan_rstbypen(fscan_rstbypen), 
 .fscan_shiften(fscan_shiften), .clk_rscclk(clkout));

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
  (.clk(clk), .rstb(local_broadcast.mem_rst_b), .d(fary_trigger_post_rf), .o(fary_trigger_post_fgrp_rf) );
assign aary_post_complete_rf = aary_post_complete_fgrp_rf;
always_ff @(posedge clk) begin
  aary_post_pass_rf <= fary_post_pass_rf & aary_post_pass_fgrp_rf;
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
 .clk                                   (clk),
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
 .pwr_mgmt_in_rf                        (pwr_mgmt_in_rf[5-1:0]), .bisr_clk_pd_vinf(pd_vinf_bisr_clk), 
 .bisr_shift_en_pd_vinf(pd_vinf_bisr_shift_en), .bisr_reset_pd_vinf(pd_vinf_bisr_reset), 
 .bisr_si_pd_vinf(bisr_so_pd_vinf_ts1), .bisr_so_pd_vinf(bisr_so_pd_vinf_ts2), .fary_ijtag_tck(JT_IN_mbist_ijtag_tck), 
 .fary_ijtag_rst_b(JT_IN_mbist_ijtag_reset_b), .mbist_diag_done(mbist_diag_done_ts1), 
 .fary_ijtag_select(sib_fgrp_apr_rf_to_select), .fary_ijtag_shift(JT_IN_mbist_ijtag_shift), 
 .fary_ijtag_capture(JT_IN_mbist_ijtag_capture), .fary_ijtag_update(JT_IN_mbist_ijtag_update), 
 .fary_ijtag_si(sib_fgrp_apr_sram_so), .aary_ijtag_so(u_fgrp_apr_rf_mems_so), 
 .fscan_byprst_b(fscan_byprst_b), .fscan_clkgenctrl(fscan_clkgenctrl_ts1), 
 .fscan_clkgenctrlen(fscan_clkgenctrlen_ts1), .fscan_clkungate_syn(fscan_clkungate_syn), 
 .fscan_latchclosed_b(fscan_latchclosed_b), .fscan_latchopen(fscan_latchopen), 
 .fscan_mode(fscan_mode), .fscan_mode_atspeed(fscan_mode_atspeed), 
 .fscan_ram_bypsel_sram(fscan_ram_bypsel_sram), .fscan_ram_bypsel_tcam(fscan_ram_bypsel_tcam), 
 .fscan_ret_ctrl(fscan_ret_ctrl), .fscan_rstbypen(fscan_rstbypen), 
 .fscan_shiften(fscan_shiften), .clk_rscclk(clkout));

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
 .clk                                   (clk),
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
 .clk                                   (clk),
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
 .ip_reset_b                            (local_broadcast.mem_rst_b), .bisr_clk_pd_vinf(pd_vinf_bisr_clk), 
 .bisr_shift_en_pd_vinf(pd_vinf_bisr_shift_en), .bisr_reset_pd_vinf(pd_vinf_bisr_reset), 
 .bisr_si_pd_vinf(pd_vinf_bisr_si), .bisr_so_pd_vinf(bisr_so_pd_vinf_ts3), .fary_ijtag_tck(JT_IN_mbist_ijtag_tck), 
 .fary_ijtag_rst_b(JT_IN_mbist_ijtag_reset_b), .mbist_diag_done(mbist_diag_done_ts3), 
 .fary_ijtag_select(sib_fgrp_apr_tcam_to_select), .fary_ijtag_shift(JT_IN_mbist_ijtag_shift), 
 .fary_ijtag_capture(JT_IN_mbist_ijtag_capture), .fary_ijtag_update(JT_IN_mbist_ijtag_update), 
 .fary_ijtag_si(JT_IN_mbist_ijtag_si), .aary_ijtag_so(u_fgrp_apr_tcam_mems_so), 
 .fscan_byprst_b(fscan_byprst_b), .fscan_clkgenctrl(fscan_clkgenctrl_ts1), 
 .fscan_clkgenctrlen(fscan_clkgenctrlen_ts1), .fscan_clkungate_syn(fscan_clkungate_syn), 
 .fscan_latchclosed_b(fscan_latchclosed_b), .fscan_latchopen(fscan_latchopen), 
 .fscan_mode_atspeed(fscan_mode_atspeed), .fscan_ram_bypsel_rf(fscan_ram_bypsel_rf), 
 .fscan_ram_bypsel_sram(fscan_ram_bypsel_sram), .fscan_ret_ctrl(fscan_ret_ctrl), 
 .fscan_rstbypen(fscan_rstbypen), .clk_rscclk(clkout)); // Templated

/*
 hlp_fgrp_apr_func_logic AUTO_TEMPLATE
 ( .i_frm_ffu_tcam (nm_frm_ffu_tcam[][]),
   .o_tom_ffu_tcam (nm_tom_ffu_tcam[][]),
   .o_tom_\(.*\) (tom_\1[][]),
   .i_frm_\(.*\) (frm_\1[][]),
   .i_broadcast  (local_broadcast) );
*/
hlp_fgrp_apr_func_logic u_fgrp_apr_func_logic
( .fet_ack_b (fet_ack_b_to_sram),
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
 .clk                                   (clk),
 .fscan_byprst_b                        (fscan_byprst_b),
 .fscan_rstbypen                        (fscan_rstbypen),
 .i_broadcast                           (local_broadcast),       // Templated
 .i_data                                (i_data[1:0]),
 .i_data_v                              (i_data_v[1:0]),
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


  /* Added by UltiBuild Instances Start */
  buf mgc_hdle_prim(fscan_clkgenctrl_ts1, fscan_clkgenctrl[0]);

  buf mgc_hdle_prim_1(fscan_clkgenctrlen_ts1, fscan_clkgenctrlen[0]);
  /* Added by UltiBuild Instances End */
endmodule
