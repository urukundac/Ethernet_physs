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

// COPIED FROM USER-PROVIDED TEMPLATE//------------------------------------------------------------------------------
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

// Top-level func_logic module for the Port4 APR

`include "hlp_mac4_mem.def"
`include "hlp_sia_mem.def"

module hlp_port4_apr_func_logic #(
  parameter MACS = 1
  )
  (
  // Power enables/acks
  input  logic fet_en_b,
  output logic fet_ack_b,
  input  logic isol_en_b,
  output logic isol_ack_b,

  // Standarized VISA and SCAN for HLP
  // VISA_CFG
  input  logic fvisa_serstb,
  input  logic fvisa_frame,
  input  logic fvisa_serdata,
  input  logic fvisa_rddata_port4,
  input  logic fvisa_rddata_msec,
  output logic avisa_serstb,
  output logic avisa_frame,
  output logic avisa_serdata,
  output logic avisa_rddata,

  // VISA_SEC
  input  logic fvisa_customer_dis,
  input  logic fvisa_all_dis,
  output logic avisa_customer_dis,
  output logic avisa_all_dis,

  // VISA_DBG_BUS
  input  logic [hlp_dfx_pkg::VISA_DBG_LANE_WIDTH-1:0] fvisa_dbg_lane_port4,
  input  logic [hlp_dfx_pkg::NUM_VISA_LANES-1:0] fvisa_clk_port4,
  input  logic [hlp_dfx_pkg::VISA_DBG_LANE_WIDTH-1:0] fvisa_dbg_lane_msec,
  input  logic [hlp_dfx_pkg::NUM_VISA_LANES-1:0] fvisa_clk_msec,

  output logic [hlp_dfx_pkg::VISA_DBG_LANE_WIDTH-1:0] avisa_dbg_lane,
  output logic [hlp_dfx_pkg::NUM_VISA_LANES-1:0] avisa_clk,

  // VISA RESET
  input logic fvisa_resetb,

  // VISA UNIT ID
  input  logic [8:0] fvisa_unit_id,

  // SCAN async controls
  input  logic fscan_ret_ctrl,
  input  logic fscan_shiften,
  input  logic fscan_latchopen,
  input  logic fscan_latchclosed_b,
  input  logic fscan_clkungate,
  input  logic fscan_clkungate_syn,

  // SCAN static controls
  input  logic fscan_mode,
  input  logic fscan_mode_atspeed,
  input  logic [hlp_dfx_pkg::PORT4_NUM_CLKGENCTRL-1:0] fscan_clkgenctrl,
  input  logic [hlp_dfx_pkg::PORT4_NUM_CLKGENCTRLEN-1:0] fscan_clkgenctrlen,


  // SCAN I/O and clocks
  input  logic [hlp_dfx_pkg::PORT4_NUM_SDI-1:0] fscan_sdi,
  // these would be scan clocks used in place of
  // functional clocks during scan. One input needs
  // created for every functional clock in the APR
  // these  would be the names of the functional
  // clocks used in the APR. One output needs to be
  // created for every functional clock in the APR
  output logic [hlp_dfx_pkg::PORT4_NUM_SDO-1:0] ascan_sdo,

  // Clock gate output
  output logic o_gclk,

  input  logic [1:0] i_mac_id, //used along with i_id (quad_id) for tap port matching
  input  logic[4:0] i_port1_id,     //used in register decoding only
  input  logic[$bits(hlp_pkg::quad_id_t)-1:0] i_id,     //used in register decoding only
  input  logic i_port4_disable,
  input  logic i_msec_disable,
  input  logic [1:0] i_mac_limit,
  
  /*AUTOINPUT*/
  // Beginning of automatic inputs (from unused autoinst inputs)
  input logic           clk,                    // To u_port4_rpl_junc of hlp_port4_rpl_junc.v
  input logic           fscan_byprst_b,         // To u_mac4 of hlp_mac4.v
  input logic           fscan_rstbypen,         // To u_mac4 of hlp_mac4.v
  input logic           i_force_clk_en,         // To u_port4_rpl_junc of hlp_port4_rpl_junc.v
  input logic [`HLP_MAC4_MAC4_STATS_FULL_RX_FROM_MEM_WIDTH-1:0] i_frm_mac4_mac4_stats_full_rx,// To u_mac4 of hlp_mac4.v
  input logic [`HLP_MAC4_MAC4_STATS_FULL_TX_FROM_MEM_WIDTH-1:0] i_frm_mac4_mac4_stats_full_tx,// To u_mac4 of hlp_mac4.v
  input logic [`HLP_MAC4_MAC4_STATS_SNAP_RX_FROM_MEM_WIDTH-1:0] i_frm_mac4_mac4_stats_snap_rx,// To u_mac4 of hlp_mac4.v
  input logic [`HLP_MAC4_MAC4_STATS_SNAP_TX_FROM_MEM_WIDTH-1:0] i_frm_mac4_mac4_stats_snap_tx,// To u_mac4 of hlp_mac4.v
  input logic [`HLP_MAC4_SMAC_TX_FIFO_FROM_MEM_WIDTH-1:0] i_frm_mac4_smac_tx_fifo,// To u_mac4 of hlp_mac4.v
  input logic [`HLP_MAC4_SMAC_TX_PRE_FROM_MEM_WIDTH-1:0] i_frm_mac4_smac_tx_pre,// To u_mac4 of hlp_mac4.v
  input logic [`HLP_MAC4_TSU_MEM_FROM_MEM_WIDTH-1:0] i_frm_mac4_tsu_mem,// To u_mac4 of hlp_mac4.v
  input logic [`HLP_SIA_SIA_QRAM_FROM_MEM_WIDTH-1:0] i_frm_sia_sia_qram,// To u_sia of hlp_sia.v
  input logic [`HLP_SIA_SIA_RXRAM_FROM_MEM_WIDTH-1:0] i_frm_sia_sia_rxram,// To u_sia of hlp_sia.v
  input logic [`HLP_SIA_SIA_TXMETARAM_FROM_MEM_WIDTH-1:0] i_frm_sia_sia_txmetaram,// To u_sia of hlp_sia.v
  input logic [9:0] [`HLP_SIA_SIA_TXRAM_FROM_MEM_WIDTH-1:0] i_frm_sia_sia_txram,// To u_sia of hlp_sia.v
  input logic [hlp_sia_pkg::PORTS_PER_SIA-1:0] i_jitter_cred_tgl,// To u_sia of hlp_sia.v
  input logic [MACS-1:0] i_msec_mac_rx_e,       // To u_mac4 of hlp_mac4.v
  input hlp_pkg::msec_mac_tx_t [MACS-1:0] i_msec_mac_tx,// To u_mac4 of hlp_mac4.v
  input logic [MACS-1:0] i_msec_mac_tx_v,       // To u_mac4 of hlp_mac4.v
  input hlp_pkg::msec_switch_rx_t [MACS-1:0] i_msec_switch_rx,// To u_mac4 of hlp_mac4.v
  input logic [MACS-1:0] i_msec_switch_rx_v,    // To u_mac4 of hlp_mac4.v
  input logic [MACS-1:0] i_msec_switch_tx_e,    // To u_mac4 of hlp_mac4.v
  input logic [$bits(hlp_mac_pkg::cfg_ports_common_t)-1:0] i_ports_cfg,// To u_mac4 of hlp_mac4.v
  input hlp_pkg::imn_rpl_bkwd_t i_rpl_bkwd,     // To u_port4_rpl_junc of hlp_port4_rpl_junc.v
  input hlp_pkg::imn_rpl_frwd_t i_rpl_frwd,     // To u_port4_rpl_junc of hlp_port4_rpl_junc.v
  input logic           i_rx_grant_fifo_push,   // To u_sia of hlp_sia.v
  input logic [hlp_sia_pkg::RX_GRANT_FIFO_CONTENTS_WIDTH-1:0] i_rx_grant_fifo_push_data,// To u_sia of hlp_sia.v
  input hlp_pkg::smp_vec_t [0:hlp_sia_pkg::PORTS_PER_SIA-1] [hlp_pkg::N_TC-1:0] i_rx_pause_gen_pfc_smp_xoff,// To u_sia of hlp_sia.v
  input hlp_pkg::smp_vec_t [0:hlp_sia_pkg::PORTS_PER_SIA-1] i_rx_pause_gen_smp_xoff,// To u_sia of hlp_sia.v
  input hlp_sia_pkg::sia_tx_tap_int_t i_sia_tx_tap_int,// To u_sia of hlp_sia.v
  input logic           i_switch_ready,         // To u_sia of hlp_sia.v
  input hlp_pkg::time_scale_pulse_t i_time_scale_pulse,// To u_port4_rpl_junc of hlp_port4_rpl_junc.v
  input logic [1:0]     i_tsu_sync_val,         // To u_mac4 of hlp_mac4.v
  input logic [MACS-1:0] i_tx_stop,             // To u_mac4 of hlp_mac4.v
  input logic           i_tx_switch_ready,      // To u_sia of hlp_sia.v
  input hlp_sia_pkg::txmetaram_win_t i_txmetaram_win,// To u_sia of hlp_sia.v
  input hlp_sia_pkg::txram_win_t i_txram_win,   // To u_sia of hlp_sia.v
  input logic [hlp_sia_pkg::PORTS_PER_SIA-1:0] i_txram_wr_tgl,// To u_sia of hlp_sia.v
 // input logic           mem_rst_n,              // To u_mac4 of hlp_mac4.v, ...
  input hlp_pkg::mii_rx_t [MACS-1:0] mii_rx,    // To u_mac4 of hlp_mac4.v
  input hlp_pkg::smac_tsu_in_t [MACS-1:0] mii_tsu_in,// To u_mac4 of hlp_mac4.v
  //input logic           powergood_rst_n,        // To u_port4_rpl_junc of hlp_port4_rpl_junc.v, ...
  //input logic           rst_n,                  // To u_port4_rpl_junc of hlp_port4_rpl_junc.v, ...
  //input logic           swclk_mem_rst_n,        // To u_sia of hlp_sia.v
  input logic           switch_clk,             // To u_sia of hlp_sia.v
  //input logic           switch_rst_n,           // To u_sia of hlp_sia.v
  input logic           tsu_en,                 // To u_mac4 of hlp_mac4.v
  // End of automatics
  /*AUTOOUTPUT*/
  // Beginning of automatic outputs (from unused autoinst outputs)
  output hlp_pkg::mii_tx_t [MACS-1:0] mii_tx,   // From u_mac4 of hlp_mac4.v
  output hlp_c_sia_tx_pkg::c_sia_tx_port_jitter_t [hlp_sia_pkg::PORTS_PER_SIA-1:0] o_cfg_tx_jitter,// From u_sia of hlp_sia.v
  output hlp_sia_pkg::txram_port_bound_t o_cfg_txram_port_bound,// From u_sia of hlp_sia.v
  output logic [hlp_sia_pkg::IARB_TOKENS_CNT_INHIBIT_CNT_WIDTH-1:0] o_iarb_token_rate,// From u_sia of hlp_sia.v
  output hlp_pkg::msec_mac_rx_t [MACS-1:0] o_msec_mac_rx,// From u_mac4 of hlp_mac4.v
  output logic [MACS-1:0] o_msec_mac_rx_v,      // From u_mac4 of hlp_mac4.v
  output logic [MACS-1:0] o_msec_mac_tx_e,      // From u_mac4 of hlp_mac4.v
  output logic [MACS-1:0] o_msec_switch_rx_e,   // From u_mac4 of hlp_mac4.v
  output hlp_pkg::msec_switch_tx_t [MACS-1:0] o_msec_switch_tx,// From u_mac4 of hlp_mac4.v
  output logic [MACS-1:0] o_msec_switch_tx_v,   // From u_mac4 of hlp_mac4.v
  output hlp_pkg::rx_sia_ripple_t o_obuf_data,  // From u_sia of hlp_sia.v
  output logic          o_p0_mode,              // From u_sia of hlp_sia.v
  output logic [hlp_sia_pkg::PORTS_PER_SIA-1:0] o_port_en,// From u_sia of hlp_sia.v
  output logic [$bits(hlp_mac_pkg::info_ports_common_t)-1:0] o_ports_info,// From u_mac4 of hlp_mac4.v
  output hlp_pkg::imn_rpl_bkwd_t o_rpl_bkwd,    // From u_port4_rpl_junc of hlp_port4_rpl_junc.v
  output hlp_pkg::imn_rpl_frwd_t o_rpl_frwd,    // From u_port4_rpl_junc of hlp_port4_rpl_junc.v
  output logic          o_rx_grant_fifo_afull,  // From u_sia of hlp_sia.v
  output logic [0:hlp_sia_pkg::PORTS_PER_SIA-1] [hlp_sia_pkg::RX_QUEUES_PER_SIA_PORT-1:0] o_rx_q_xoff,// From u_sia of hlp_sia.v
  output hlp_sia_pkg::c_rx_tap_port_cfg_t [0:hlp_sia_pkg::PORTS_PER_SIA-1] o_rx_tap_port_cfg,// From u_sia of hlp_sia.v
  output logic [MACS-1:0] o_rx_throttle,        // From u_mac4 of hlp_mac4.v
  output logic [hlp_sia_pkg::PORTS_PER_SIA-1:0] [hlp_sia_pkg::RX_IARB_TOKEN_REQ_CNT_WIDTH-1:0] o_seg_valid,// From u_sia of hlp_sia.v
  output hlp_pkg::pc_vec_t [0:hlp_sia_pkg::PORTS_PER_SIA-1] o_switch_rx_pc_xoff,// From u_sia of hlp_sia.v
  output hlp_pkg::time_scale_pulse_t o_time_scale_pulse,// From u_port4_rpl_junc of hlp_port4_rpl_junc.v
  output logic [`HLP_MAC4_MAC4_STATS_FULL_RX_TO_MEM_WIDTH-1:0] o_tom_mac4_mac4_stats_full_rx,// From u_mac4 of hlp_mac4.v
  output logic [`HLP_MAC4_MAC4_STATS_FULL_TX_TO_MEM_WIDTH-1:0] o_tom_mac4_mac4_stats_full_tx,// From u_mac4 of hlp_mac4.v
  output logic [`HLP_MAC4_MAC4_STATS_SNAP_RX_TO_MEM_WIDTH-1:0] o_tom_mac4_mac4_stats_snap_rx,// From u_mac4 of hlp_mac4.v
  output logic [`HLP_MAC4_MAC4_STATS_SNAP_TX_TO_MEM_WIDTH-1:0] o_tom_mac4_mac4_stats_snap_tx,// From u_mac4 of hlp_mac4.v
  output logic [`HLP_MAC4_SMAC_TX_FIFO_TO_MEM_WIDTH-1:0] o_tom_mac4_smac_tx_fifo,// From u_mac4 of hlp_mac4.v
  output logic [`HLP_MAC4_SMAC_TX_PRE_TO_MEM_WIDTH-1:0] o_tom_mac4_smac_tx_pre,// From u_mac4 of hlp_mac4.v
  output logic [`HLP_MAC4_TSU_MEM_TO_MEM_WIDTH-1:0] o_tom_mac4_tsu_mem,// From u_mac4 of hlp_mac4.v
  output logic [`HLP_SIA_SIA_QRAM_TO_MEM_WIDTH-1:0] o_tom_sia_sia_qram,// From u_sia of hlp_sia.v
  output logic [`HLP_SIA_SIA_RXRAM_TO_MEM_WIDTH-1:0] o_tom_sia_sia_rxram,// From u_sia of hlp_sia.v
  output logic [`HLP_SIA_SIA_TXMETARAM_TO_MEM_WIDTH-1:0] o_tom_sia_sia_txmetaram,// From u_sia of hlp_sia.v
  output logic [9:0] [`HLP_SIA_SIA_TXRAM_TO_MEM_WIDTH-1:0] o_tom_sia_sia_txram,// From u_sia of hlp_sia.v
  output hlp_pkg::tx_credit_t [hlp_sia_pkg::PORTS_PER_SIA-1:0] o_txram_credit
  `include "hlp_port4_apr_func_logic.VISA_IT.hlp_port4_apr_func_logic.port_defs.sv" // Auto Included by VISA IT - *** Do not modify this line ***
                  // From u_sia of hlp_sia.v
  // End of automatics
  );

  // Connect power acks to enables.
logic   mem_rst_n;
logic   powergood_rst_n;
logic   rst_n;
logic   swclk_mem_rst_n;
logic   switch_rst_n;
  `include "hlp_port4_apr_func_logic.VISA_IT.hlp_port4_apr_func_logic.wires.sv" // Auto Included by VISA IT - *** Do not modify this line ***
  assign fet_ack_b  = fet_en_b;
  assign isol_ack_b = isol_en_b;

  // Connect VISA CFG & SEC Outputs
  assign avisa_all_dis = fvisa_all_dis;
  assign avisa_customer_dis = fvisa_customer_dis;

  // Tie off placeholder scan chain outputs.
  assign ascan_sdo = '0;

  // Connect o_gclk
  logic        gclk;
  assign o_gclk = gclk;

  // Construct mac4 mgmt id strap
  logic [hlp_pkg::W_MGMT_ADDR-1:0]          mac4_strap_mgmt_addr_id;
  always_comb begin: mac4_mgmt_id
    mac4_strap_mgmt_addr_id = hlp_register_constants_pkg::MAC_BASE;
    mac4_strap_mgmt_addr_id[19:18] = '0;  // 00 for PORT4, 01 for MSEC
    mac4_strap_mgmt_addr_id[17] = 1'b0;
    mac4_strap_mgmt_addr_id[16:12] = i_port1_id;
  end

  // Construct SIA quad id strap
 hlp_pkg::quad_id_t                        sia_quad_id;
 always_comb begin: c_sia_quad_id
   sia_quad_id = i_id[$bits(sia_quad_id)-1:0];
 end


  logic [MACS-1:0]           mac_rx_e;              
  hlp_pkg::mac_port_t [MACS-1:0] mac_tx_d;          
  hlp_pkg::pc_vec_t [MACS-1:0] mac_tx_pc_xoff;      
  hlp_pkg::mac_tx_pkt_t [MACS-1:0] mac_tx_pkt;
  logic [MACS-1:0]           mac_tx_v;
  //tie off not used ports to mac4
  //assign mac_rx_e[3:1] = 3'b111;
  //assign mac_tx_d[3:1] = '0;
  //assign mac_tx_pc_xoff[3:1] = '0;
  //assign mac_tx_pkt[3:1] = '0;
  //assign mac_tx_v[3:1] = '0;


  /*AUTOLOGIC*/
  // Beginning of automatic wires (for undeclared instantiated-module outputs)
  hlp_pkg::ptot_t       curr_ptot;              // From u_port4_rpl_junc of hlp_port4_rpl_junc.v
  hlp_pkg::mac4_intr_t  int_mac4;               // From u_mac4 of hlp_mac4.v
  hlp_pkg::sia_intr_t   int_sia;                // From u_sia of hlp_sia.v
  logic                 int_tsu;                // From u_mac4 of hlp_mac4.v
  logic                 mac4_func_init_done;    // From u_mac4 of hlp_mac4.v
  logic                 mac4_mem_init_done;     // From u_mac4 of hlp_mac4.v
  hlp_pkg::mgmt64_t     mac4_mgmt_out;          // From u_mac4 of hlp_mac4.v
  logic                 mac4_mgmt_out_v;        // From u_mac4 of hlp_mac4.v
  hlp_pkg::mac_port_t [MACS-1:0] mac_rx_d;      // From u_mac4 of hlp_mac4.v
  hlp_pkg::pc_vec_t [MACS-1:0] mac_rx_pc_xoff;  // From u_mac4 of hlp_mac4.v
  hlp_pkg::mac_rx_pkt_t [MACS-1:0] mac_rx_pkt;  // From u_mac4 of hlp_mac4.v
  logic [MACS-1:0]      mac_rx_v;               // From u_mac4 of hlp_mac4.v
  logic [MACS-1:0]      mac_tx_e;               // From u_mac4 of hlp_mac4.v
  logic                 sia_func_init_done;     // From u_sia of hlp_sia.v
  logic                 sia_mem_init_done;      // From u_sia of hlp_sia.v
  hlp_pkg::mgmt64_t     sia_mgmt_in;            // From u_port4_rpl_junc of hlp_port4_rpl_junc.v
  logic                 sia_mgmt_in_v;          // From u_port4_rpl_junc of hlp_port4_rpl_junc.v
  hlp_pkg::mgmt64_t     sia_mgmt_out;           // From u_sia of hlp_sia.v
  logic                 sia_mgmt_out_v;         // From u_sia of hlp_sia.v
  hlp_pkg::time_scale_pulse_t time_scale_pulse; // From u_port4_rpl_junc of hlp_port4_rpl_junc.v
  hlp_pkg::mgmt64_t     tsu_mgmt_in;            // From u_port4_rpl_junc of hlp_port4_rpl_junc.v
  logic                 tsu_mgmt_in_v;          // From u_port4_rpl_junc of hlp_port4_rpl_junc.v
  hlp_pkg::mgmt64_t     tsu_mgmt_out;           // From u_mac4 of hlp_mac4.v
  logic                 tsu_mgmt_out_v;         // From u_mac4 of hlp_mac4.v
  logic clock;
  // End of automatics

  /* hlp_port4_rpl_junc AUTO_TEMPLATE (
    .o_gclk                            (gclk[]),
    .i_disable                         (i_port4_disable),
    .o_curr_ptot_to_ip                 (curr_ptot[]),
    .o_time_scale_pulse_to_ip          (time_scale_pulse[]),
    .o_mgmt_to_ip                      (sia_mgmt_in[]),
    .o_mgmt_to_ip_v                    (sia_mgmt_in_v[]),
    .i_mgmt_frm_ip                     (mac4_mgmt_out[]),
    .i_mgmt_frm_ip_v                   (mac4_mgmt_out_v[]),
    .o_mgmt_to_tsu_mem                 (tsu_mgmt_in),
    .o_mgmt_to_tsu_mem_v               (tsu_mgmt_in_v),
    .i_mgmt_frm_tsu_mem                (tsu_mgmt_out),
    .i_mgmt_frm_tsu_mem_v              (tsu_mgmt_out_v),
    .i_sia_mem_init_done               (sia_mem_init_done),
    .i_sia_func_init_done              (sia_func_init_done),
    .i_mac4_mem_init_done              (mac4_mem_init_done),
    .i_mac4_func_init_done             (mac4_func_init_done),
    .i_int_sia                         (int_sia[]),
    .i_int_mac4                        (int_mac4[]),
    .i_int_tsu                         (int_tsu),
    .i_id                              (i_port1_id),
  ); */

  hlp_port4_rpl_junc u_port4_rpl_junc
    (/*AUTOINST*/
     // Outputs
     .o_gclk                            (gclk),                  // Templated
     .o_rpl_bkwd                        (o_rpl_bkwd),
     .o_rpl_frwd                        (o_rpl_frwd),
     .o_time_scale_pulse                (o_time_scale_pulse),
     .o_curr_ptot_to_ip                 (curr_ptot),             // Templated
     .o_time_scale_pulse_to_ip          (time_scale_pulse),      // Templated
     .o_mgmt_to_tsu_mem                 (tsu_mgmt_in),           // Templated
     .o_mgmt_to_tsu_mem_v               (tsu_mgmt_in_v),         // Templated
     .o_mgmt_to_ip                      (sia_mgmt_in),           // Templated
     .o_mgmt_to_ip_v                    (sia_mgmt_in_v),         // Templated
     // Inputs
     .clk                               (clock),
     .rst_n                             (rst_n),
     .fscan_clkungate                   (fscan_clkungate),
     .i_force_clk_en                    (i_force_clk_en),
     .powergood_rst_n                   (powergood_rst_n),
     .i_disable                         (i_port4_disable),       // Templated
     .i_rpl_frwd                        (i_rpl_frwd),
     .i_time_scale_pulse                (i_time_scale_pulse),
     .i_rpl_bkwd                        (i_rpl_bkwd),
     .i_sia_mem_init_done               (sia_mem_init_done),     // Templated
     .i_sia_func_init_done              (sia_func_init_done),    // Templated
     .i_mac4_mem_init_done              (mac4_mem_init_done),    // Templated
     .i_mac4_func_init_done             (mac4_func_init_done),   // Templated
     .i_int_sia                         (int_sia),               // Templated
     .i_int_mac4                        (int_mac4),              // Templated
     .i_int_tsu                         (int_tsu),               // Templated
     .i_id                              (i_port1_id),            // Templated
     .i_mgmt_frm_tsu_mem                (tsu_mgmt_out),          // Templated
     .i_mgmt_frm_tsu_mem_v              (tsu_mgmt_out_v),        // Templated
     .i_mgmt_frm_ip                     (mac4_mgmt_out),         // Templated
     .i_mgmt_frm_ip_v                   (mac4_mgmt_out_v));       // Templated

  /* hlp_mac4 AUTO_TEMPLATE (
    .clk                               (gclk[]),
    .mem_rst_b                         (mem_rst_n),
    .fuse_rst_b                        (powergood_rst_n),
    .i_mac_limit                       (i_mac_limit[]),
    .i_mac\(.*\)                       (mac\1[]),
    .o_mac\(.*\)                       (mac\1[]),
    .i_mac_linkup                      (1'h1),
    .i_curr_ptot                       (curr_ptot[]),
    .i_time_scale_pulse                (time_scale_pulse[]),
    .i_strap_mgmt_addr_id              (mac4_strap_mgmt_addr_id),
    .o_mem_init_done                   (mac4_mem_init_done),
    .o_func_init_done                  (mac4_func_init_done),
    .i_mgmt_tsu                        (tsu_mgmt_in),
    .i_mgmt_tsu_v                      (tsu_mgmt_in_v),
    .o_mgmt_tsu                        (tsu_mgmt_out),
    .o_mgmt_tsu_v                      (tsu_mgmt_out_v),
    .o_ts_int                          (int_tsu),
    .i_mgmt                            (sia_mgmt_out[]),
    .i_mgmt_v                          (sia_mgmt_out_v[]),
    .o_mgmt                            (mac4_mgmt_out[]),
    .o_mgmt_v                          (mac4_mgmt_out_v[]),
    .o_int                             (int_mac4[]),
    .i_mac_id                          (i_mac_id),
  ); */

  hlp_mac4 #(
    .MACS                              (MACS),
    .INCLUDE_MSEC                      (1)
  ) u_mac4
    (
    `include "hlp_port4_apr_func_logic.VISA_IT.hlp_port4_apr_func_logic.inst.u_mac4.sv" // Auto Included by VISA IT - *** Do not modify this line ***
                                    /*AUTOINST*/
     // Outputs
     .o_mac_tx_e                        (mac_tx_e[MACS-1:0]),    // Templated
     .o_mac_rx_d                        (mac_rx_d[MACS-1:0]),    // Templated
     .o_mac_rx_pkt                      (mac_rx_pkt[MACS-1:0]),  // Templated
     .o_mac_rx_v                        (mac_rx_v[MACS-1:0]),    // Templated
     .o_mac_rx_pc_xoff                  (mac_rx_pc_xoff[MACS-1:0]), // Templated
     .mii_tx                            (mii_tx[MACS-1:0]),
     .o_rx_throttle                     (o_rx_throttle[MACS-1:0]),
     .o_ports_info                      (o_ports_info[$bits(hlp_mac_pkg::info_ports_common_t)-1:0]),
     .o_msec_mac_tx_e                   (o_msec_mac_tx_e[MACS-1:0]),
     .o_msec_switch_tx                  (o_msec_switch_tx[MACS-1:0]),
     .o_msec_switch_tx_v                (o_msec_switch_tx_v[MACS-1:0]),
     .o_msec_mac_rx                     (o_msec_mac_rx[MACS-1:0]),
     .o_msec_mac_rx_v                   (o_msec_mac_rx_v[MACS-1:0]),
     .o_msec_switch_rx_e                (o_msec_switch_rx_e[MACS-1:0]),
     .o_tom_mac4_mac4_stats_full_rx     (o_tom_mac4_mac4_stats_full_rx[`HLP_MAC4_MAC4_STATS_FULL_RX_TO_MEM_WIDTH-1:0]),
     .o_tom_mac4_mac4_stats_full_tx     (o_tom_mac4_mac4_stats_full_tx[`HLP_MAC4_MAC4_STATS_FULL_TX_TO_MEM_WIDTH-1:0]),
     .o_tom_mac4_mac4_stats_snap_rx     (o_tom_mac4_mac4_stats_snap_rx[`HLP_MAC4_MAC4_STATS_SNAP_RX_TO_MEM_WIDTH-1:0]),
     .o_tom_mac4_mac4_stats_snap_tx     (o_tom_mac4_mac4_stats_snap_tx[`HLP_MAC4_MAC4_STATS_SNAP_TX_TO_MEM_WIDTH-1:0]),
     .o_tom_mac4_smac_tx_fifo           (o_tom_mac4_smac_tx_fifo[`HLP_MAC4_SMAC_TX_FIFO_TO_MEM_WIDTH-1:0]),
     .o_tom_mac4_smac_tx_pre            (o_tom_mac4_smac_tx_pre[`HLP_MAC4_SMAC_TX_PRE_TO_MEM_WIDTH-1:0]),
     .o_tom_mac4_tsu_mem                (o_tom_mac4_tsu_mem[`HLP_MAC4_TSU_MEM_TO_MEM_WIDTH-1:0]),
     .o_mem_init_done                   (mac4_mem_init_done),    // Templated
     .o_func_init_done                  (mac4_func_init_done),   // Templated
     .o_mgmt_tsu                        (tsu_mgmt_out),          // Templated
     .o_mgmt_tsu_v                      (tsu_mgmt_out_v),        // Templated
     .o_ts_int                          (int_tsu),               // Templated
     .o_mgmt                            (mac4_mgmt_out),         // Templated
     .o_mgmt_v                          (mac4_mgmt_out_v),       // Templated
     .o_int                             (int_mac4),              // Templated
     // Inputs
     .clk                               (gclk),                  // Templated
     .rst_n                             (rst_n),
     .mem_rst_b                         (mem_rst_n),             // Templated
     .fuse_rst_b                        (powergood_rst_n),       // Templated
     .i_tsu_sync_val                    (i_tsu_sync_val[1:0]),
     .i_msec_disable                    (i_msec_disable),
     .i_mac_limit                       (i_mac_limit[1:0]),      // Templated
     .i_mac_id                          (i_mac_id),              // Templated
     .fscan_rstbypen                    (fscan_rstbypen),
     .fscan_byprst_b                    (fscan_byprst_b),
     .i_mac_tx_d                        (mac_tx_d[MACS-1:0]),    // Templated
     .i_mac_tx_pkt                      (mac_tx_pkt[MACS-1:0]),  // Templated
     .i_mac_tx_v                        (mac_tx_v[MACS-1:0]),    // Templated
     .i_mac_tx_pc_xoff                  (mac_tx_pc_xoff[MACS-1:0]), // Templated
     .i_mac_rx_e                        (mac_rx_e[MACS-1:0]),    // Templated
     .mii_rx                            (mii_rx[MACS-1:0]),
     .i_tx_stop                         (i_tx_stop[MACS-1:0]),
     .tsu_en                            (tsu_en),
     .mii_tsu_in                        (mii_tsu_in[MACS-1:0]),
     .i_ports_cfg                       (i_ports_cfg[$bits(hlp_mac_pkg::cfg_ports_common_t)-1:0]),
     .i_msec_mac_tx                     (i_msec_mac_tx[MACS-1:0]),
     .i_msec_mac_tx_v                   (i_msec_mac_tx_v[MACS-1:0]),
     .i_msec_switch_tx_e                (i_msec_switch_tx_e[MACS-1:0]),
     .i_msec_mac_rx_e                   (i_msec_mac_rx_e[MACS-1:0]),
     .i_msec_switch_rx                  (i_msec_switch_rx[MACS-1:0]),
     .i_msec_switch_rx_v                (i_msec_switch_rx_v[MACS-1:0]),
     .i_frm_mac4_mac4_stats_full_rx     (i_frm_mac4_mac4_stats_full_rx[`HLP_MAC4_MAC4_STATS_FULL_RX_FROM_MEM_WIDTH-1:0]),
     .i_frm_mac4_mac4_stats_full_tx     (i_frm_mac4_mac4_stats_full_tx[`HLP_MAC4_MAC4_STATS_FULL_TX_FROM_MEM_WIDTH-1:0]),
     .i_frm_mac4_mac4_stats_snap_rx     (i_frm_mac4_mac4_stats_snap_rx[`HLP_MAC4_MAC4_STATS_SNAP_RX_FROM_MEM_WIDTH-1:0]),
     .i_frm_mac4_mac4_stats_snap_tx     (i_frm_mac4_mac4_stats_snap_tx[`HLP_MAC4_MAC4_STATS_SNAP_TX_FROM_MEM_WIDTH-1:0]),
     .i_frm_mac4_smac_tx_fifo           (i_frm_mac4_smac_tx_fifo[`HLP_MAC4_SMAC_TX_FIFO_FROM_MEM_WIDTH-1:0]),
     .i_frm_mac4_smac_tx_pre            (i_frm_mac4_smac_tx_pre[`HLP_MAC4_SMAC_TX_PRE_FROM_MEM_WIDTH-1:0]),
     .i_frm_mac4_tsu_mem                (i_frm_mac4_tsu_mem[`HLP_MAC4_TSU_MEM_FROM_MEM_WIDTH-1:0]),
     .i_mac_linkup                      (1'h1),                  // Templated
     .i_curr_ptot                       (curr_ptot),             // Templated
     .i_time_scale_pulse                (time_scale_pulse),      // Templated
     .i_strap_mgmt_addr_id              (mac4_strap_mgmt_addr_id), // Templated
     .i_mgmt_tsu                        (tsu_mgmt_in),           // Templated
     .i_mgmt_tsu_v                      (tsu_mgmt_in_v),         // Templated
     .i_mgmt                            (sia_mgmt_out),          // Templated
     .i_mgmt_v                          (sia_mgmt_out_v));        // Templated

  /* hlp_sia AUTO_TEMPLATE (
    .clk                               (gclk),
    .ports_mem_rst_b                   (mem_rst_n),
    .fuse_rst_b                        (powergood_rst_n),
    .switch_mem_rst_b                  (swclk_mem_rst_n),
    .i_curr_ptot                       (curr_ptot[]),
    .i_mac\(.*\)                       (mac\1[]),
    .o_mac\(.*\)                       (mac\1[]),
    .o_mem_init_done                   (sia_mem_init_done),
    .o_func_init_done                  (sia_func_init_done),
    .i_mgmt                            (sia_mgmt_in[]),
    .i_mgmt_v                          (sia_mgmt_in_v[]),
    .o_mgmt                            (sia_mgmt_out[]),
    .o_mgmt_v                          (sia_mgmt_out_v[]),
    .o_int                             (int_sia[]),
    .i_quad_id                         (sia_quad_id),
    .i_port1_id                        (i_port1_id[4:0]),
    .i_sia_index                    (i_mac_id),
  ); */

  hlp_sia u_sia
    (
    `include "hlp_port4_apr_func_logic.VISA_IT.hlp_port4_apr_func_logic.inst.u_sia.sv" // Auto Included by VISA IT - *** Do not modify this line ***
                                    /*AUTOINST*/
     // Outputs
     .o_mac_rx_e                        (mac_rx_e[hlp_sia_pkg::PORTS_PER_SIA-1:0]), // Templated
     .o_mac_tx_d                        (mac_tx_d[hlp_sia_pkg::PORTS_PER_SIA-1:0]), // Templated
     .o_mac_tx_pkt                      (mac_tx_pkt[hlp_sia_pkg::PORTS_PER_SIA-1:0]), // Templated
     .o_mac_tx_v                        (mac_tx_v[hlp_sia_pkg::PORTS_PER_SIA-1:0]), // Templated
     .o_mac_tx_pc_xoff                  (mac_tx_pc_xoff[hlp_sia_pkg::PORTS_PER_SIA-1:0]), // Templated
     .o_obuf_data                       (o_obuf_data),
     .o_seg_valid                       (o_seg_valid/*[hlp_sia_pkg::PORTS_PER_SIA-1:0][hlp_sia_pkg::RX_IARB_TOKEN_REQ_CNT_WIDTH-1:0]*/),
     .o_switch_rx_pc_xoff               (o_switch_rx_pc_xoff[0:hlp_sia_pkg::PORTS_PER_SIA-1]),
     .o_rx_q_xoff                       (o_rx_q_xoff/*[0:hlp_sia_pkg::PORTS_PER_SIA-1][hlp_sia_pkg::RX_QUEUES_PER_SIA_PORT-1:0]*/),
     .o_rx_tap_port_cfg                 (o_rx_tap_port_cfg[0:hlp_sia_pkg::PORTS_PER_SIA-1]),
     .o_p0_mode                         (o_p0_mode),
     .o_iarb_token_rate                 (o_iarb_token_rate[hlp_sia_pkg::IARB_TOKENS_CNT_INHIBIT_CNT_WIDTH-1:0]),
     .o_rx_grant_fifo_afull             (o_rx_grant_fifo_afull),
     .o_txram_credit                    (o_txram_credit[hlp_sia_pkg::PORTS_PER_SIA-1:0]),
     .o_port_en                         (o_port_en[hlp_sia_pkg::PORTS_PER_SIA-1:0]),
     .o_cfg_txram_port_bound            (o_cfg_txram_port_bound),
     .o_cfg_tx_jitter                   (o_cfg_tx_jitter[hlp_sia_pkg::PORTS_PER_SIA-1:0]),
     .o_tom_sia_sia_txram               (o_tom_sia_sia_txram/*[9:0][`HLP_SIA_SIA_TXRAM_TO_MEM_WIDTH-1:0]*/),
     .o_tom_sia_sia_txmetaram           (o_tom_sia_sia_txmetaram[`HLP_SIA_SIA_TXMETARAM_TO_MEM_WIDTH-1:0]),
     .o_tom_sia_sia_qram                (o_tom_sia_sia_qram[`HLP_SIA_SIA_QRAM_TO_MEM_WIDTH-1:0]),
     .o_tom_sia_sia_rxram               (o_tom_sia_sia_rxram[`HLP_SIA_SIA_RXRAM_TO_MEM_WIDTH-1:0]),
     .o_mem_init_done                   (sia_mem_init_done),     // Templated
     .o_func_init_done                  (sia_func_init_done),    // Templated
     .o_mgmt_v                          (sia_mgmt_out_v),        // Templated
     .o_mgmt                            (sia_mgmt_out),          // Templated
     .o_int                             (int_sia),               // Templated
     // Inputs
     .clk                               (gclk),                  // Templated
     .rst_n                             (rst_n),
     .ports_mem_rst_b                   (mem_rst_n),             // Templated
     .switch_clk                        (switch_clk),
     .switch_rst_n                      (switch_rst_n),
     .switch_mem_rst_b                  (swclk_mem_rst_n),       // Templated
     .fuse_rst_b                        (powergood_rst_n),       // Templated
     .i_switch_ready                    (i_switch_ready),
     .i_mac_rx_d                        (mac_rx_d[hlp_sia_pkg::PORTS_PER_SIA-1:0]), // Templated
     .i_mac_rx_pkt                      (mac_rx_pkt[hlp_sia_pkg::PORTS_PER_SIA-1:0]), // Templated
     .i_mac_rx_v                        (mac_rx_v[hlp_sia_pkg::PORTS_PER_SIA-1:0]), // Templated
     .i_mac_rx_pc_xoff                  (mac_rx_pc_xoff[hlp_sia_pkg::PORTS_PER_SIA-1:0]), // Templated
     .i_mac_tx_e                        (mac_tx_e[hlp_sia_pkg::PORTS_PER_SIA-1:0]), // Templated
     .i_rx_pause_gen_smp_xoff           (i_rx_pause_gen_smp_xoff[0:hlp_sia_pkg::PORTS_PER_SIA-1]),
     .i_rx_pause_gen_pfc_smp_xoff       (i_rx_pause_gen_pfc_smp_xoff/*[0:hlp_sia_pkg::PORTS_PER_SIA-1][hlp_pkg::N_TC-1:0]*/),
     .i_rx_grant_fifo_push              (i_rx_grant_fifo_push),
     .i_rx_grant_fifo_push_data         (i_rx_grant_fifo_push_data[hlp_sia_pkg::RX_GRANT_FIFO_CONTENTS_WIDTH-1:0]),
     .i_curr_ptot                       (curr_ptot),             // Templated
     .i_sia_tx_tap_int                  (i_sia_tx_tap_int),
     .i_txram_win                       (i_txram_win),
     .i_txmetaram_win                   (i_txmetaram_win),
     .i_tx_switch_ready                 (i_tx_switch_ready),
     .i_jitter_cred_tgl                 (i_jitter_cred_tgl[hlp_sia_pkg::PORTS_PER_SIA-1:0]),
     .i_txram_wr_tgl                    (i_txram_wr_tgl[hlp_sia_pkg::PORTS_PER_SIA-1:0]),
     .i_frm_sia_sia_txram               (i_frm_sia_sia_txram/*[9:0][`HLP_SIA_SIA_TXRAM_FROM_MEM_WIDTH-1:0]*/),
     .i_frm_sia_sia_txmetaram           (i_frm_sia_sia_txmetaram[`HLP_SIA_SIA_TXMETARAM_FROM_MEM_WIDTH-1:0]),
     .i_frm_sia_sia_qram                (i_frm_sia_sia_qram[`HLP_SIA_SIA_QRAM_FROM_MEM_WIDTH-1:0]),
     .i_frm_sia_sia_rxram               (i_frm_sia_sia_rxram[`HLP_SIA_SIA_RXRAM_FROM_MEM_WIDTH-1:0]),
     .i_quad_id                         (sia_quad_id),           // Templated
     .i_port1_id                        (i_port1_id[4:0]),       // Templated
     .i_sia_index                       (i_mac_id),              // Templated
     .i_mgmt_v                          (sia_mgmt_in_v),         // Templated
     .i_mgmt                            (sia_mgmt_in));           // Templated


`include "hlp_port4_apr_func_logic.VISA_IT.hlp_port4_apr_func_logic.logic.sv" // Auto Included by VISA IT - *** Do not modify this line ***
endmodule
// Local Variables:
// End:
//------------------------------------------------------------------------------
//
