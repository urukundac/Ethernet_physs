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

// Top-level func_logic module for the MSEC APR

`include "hlp_msec_mem.def"

module hlp_msec_apr_func_logic (
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
  input  logic fvisa_rddata,
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
  input  logic [hlp_dfx_pkg::VISA_DBG_LANE_WIDTH-1:0] fvisa_dbg_lane,
  input  logic [hlp_dfx_pkg::NUM_VISA_LANES-1:0] fvisa_clk,
  output logic [hlp_dfx_pkg::VISA_DBG_LANE_WIDTH-1:0] avisa_dbg_lane,
  output logic [hlp_dfx_pkg::NUM_VISA_LANES-1:0] avisa_clk,

  // VISA UNIT ID
  input  logic [8:0] fvisa_unit_id,

  // VISA RESET
  input logic fvisa_resetb,

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
  input  logic [hlp_dfx_pkg::MSEC_NUM_CLKGENCTRL-1:0] fscan_clkgenctrl,
  input  logic [hlp_dfx_pkg::MSEC_NUM_CLKGENCTRLEN-1:0] fscan_clkgenctrlen,


  // SCAN I/O and clocks
  input  logic [hlp_dfx_pkg::MSEC_NUM_SDI-1:0] fscan_sdi,
  // these would be scan clocks used in place of
  // functional clocks during scan. One input needs
  // created for every functional clock in the APR
  // these  would be the names of the functional
  // clocks used in the APR. One output needs to be
  // created for every functional clock in the APR
  input  logic fscan_postclk_div4_clk,
  output logic ascan_preclk_div4_clk,
  output logic [hlp_dfx_pkg::MSEC_NUM_SDO-1:0] ascan_sdo,

  /*AUTOINPUT*/
  // Beginning of automatic inputs (from unused autoinst inputs)
  input logic           clk,                    // To u_msec of hlp_msec.v
  input logic           fscan_byprst_b,         // To u_msec of hlp_msec.v
  input logic           fscan_rstbypen,         // To u_msec of hlp_msec.v
  input logic           i_disable,              // To u_msec of hlp_msec.v
  input logic           i_force_clk_en,         // To u_msec of hlp_msec.v
  input logic [`HLP_MSEC_MSEC_RX_EOP_CLASS_MEM_FROM_MEM_WIDTH-1:0] i_frm_msec_rx_eop_class_mem,// To u_msec of hlp_msec.v
  input logic [`HLP_MSEC_MSEC_RX_IBUF_MEM_FROM_MEM_WIDTH-1:0] i_frm_msec_rx_ibuf_mem,// To u_msec of hlp_msec.v
  input logic [`HLP_MSEC_MSEC_RX_KEY_MEM_FROM_MEM_WIDTH-1:0] i_frm_msec_rx_key_mem_0,// To u_msec of hlp_msec.v
  input logic [`HLP_MSEC_MSEC_RX_KEY_MEM_FROM_MEM_WIDTH-1:0] i_frm_msec_rx_key_mem_1,// To u_msec of hlp_msec.v
  input logic [`HLP_MSEC_MSEC_RX_KEY_PTR_MEM_FROM_MEM_WIDTH-1:0] i_frm_msec_rx_key_ptr_mem,// To u_msec of hlp_msec.v
  input logic [`HLP_MSEC_MSEC_RX_LOWEST_PN_MEM_FROM_MEM_WIDTH-1:0] i_frm_msec_rx_lowest_pn_mem_0,// To u_msec of hlp_msec.v
  input logic [`HLP_MSEC_MSEC_RX_LOWEST_PN_MEM_FROM_MEM_WIDTH-1:0] i_frm_msec_rx_lowest_pn_mem_1,// To u_msec of hlp_msec.v
  input logic [`HLP_MSEC_MSEC_RX_NEXT_PN_MEM_FROM_MEM_WIDTH-1:0] i_frm_msec_rx_next_pn_mem_0,// To u_msec of hlp_msec.v
  input logic [`HLP_MSEC_MSEC_RX_NEXT_PN_MEM_FROM_MEM_WIDTH-1:0] i_frm_msec_rx_next_pn_mem_1,// To u_msec of hlp_msec.v
  input logic [`HLP_MSEC_MSEC_RX_OBUF_MEM_FROM_MEM_WIDTH-1:0] i_frm_msec_rx_obuf_mem,// To u_msec of hlp_msec.v
  input logic [`HLP_MSEC_MSEC_RX_PKT_CNT_MEM_FROM_MEM_WIDTH-1:0] i_frm_msec_rx_pkt_cnt_mem_0,// To u_msec of hlp_msec.v
  input logic [`HLP_MSEC_MSEC_RX_PKT_CNT_MEM_FROM_MEM_WIDTH-1:0] i_frm_msec_rx_pkt_cnt_mem_1,// To u_msec of hlp_msec.v
  input logic [`HLP_MSEC_MSEC_RX_SALT_MEM_FROM_MEM_WIDTH-1:0] i_frm_msec_rx_salt_mem_0,// To u_msec of hlp_msec.v
  input logic [`HLP_MSEC_MSEC_RX_SALT_MEM_FROM_MEM_WIDTH-1:0] i_frm_msec_rx_salt_mem_1,// To u_msec of hlp_msec.v
  input logic [`HLP_MSEC_MSEC_RX_SALT_MEM_FROM_MEM_WIDTH-1:0] i_frm_msec_rx_salt_mem_2,// To u_msec of hlp_msec.v
  input logic [`HLP_MSEC_MSEC_RX_SC_VLAN_TAG_CTRL_FROM_MEM_WIDTH-1:0] i_frm_msec_rx_sc_vlan_tag_ctrl,// To u_msec of hlp_msec.v
  input logic [`HLP_MSEC_MSEC_RX_SSCI_MEM_FROM_MEM_WIDTH-1:0] i_frm_msec_rx_ssci_mem,// To u_msec of hlp_msec.v
  input logic [`HLP_MSEC_MSEC_TX_IBUF_MEM_FROM_MEM_WIDTH-1:0] i_frm_msec_tx_ibuf_mem,// To u_msec of hlp_msec.v
  input logic [`HLP_MSEC_MSEC_TX_KEY_MEM_FROM_MEM_WIDTH-1:0] i_frm_msec_tx_key_mem_0,// To u_msec of hlp_msec.v
  input logic [`HLP_MSEC_MSEC_TX_KEY_MEM_FROM_MEM_WIDTH-1:0] i_frm_msec_tx_key_mem_1,// To u_msec of hlp_msec.v
  input logic [`HLP_MSEC_MSEC_TX_KEY_PTR_MEM_FROM_MEM_WIDTH-1:0] i_frm_msec_tx_key_ptr_mem,// To u_msec of hlp_msec.v
  input logic [`HLP_MSEC_MSEC_TX_NEXT_PN_MEM_FROM_MEM_WIDTH-1:0] i_frm_msec_tx_next_pn_mem_0,// To u_msec of hlp_msec.v
  input logic [`HLP_MSEC_MSEC_TX_NEXT_PN_MEM_FROM_MEM_WIDTH-1:0] i_frm_msec_tx_next_pn_mem_1,// To u_msec of hlp_msec.v
  input logic [`HLP_MSEC_MSEC_TX_OBUF_MEM_FROM_MEM_WIDTH-1:0] i_frm_msec_tx_obuf_mem,// To u_msec of hlp_msec.v
  input logic [`HLP_MSEC_MSEC_TX_PKT_CNT_MEM_FROM_MEM_WIDTH-1:0] i_frm_msec_tx_pkt_cnt_mem_0,// To u_msec of hlp_msec.v
  input logic [`HLP_MSEC_MSEC_TX_PKT_CNT_MEM_FROM_MEM_WIDTH-1:0] i_frm_msec_tx_pkt_cnt_mem_1,// To u_msec of hlp_msec.v
  input logic [`HLP_MSEC_MSEC_TX_SALT_MEM_FROM_MEM_WIDTH-1:0] i_frm_msec_tx_salt_mem_0,// To u_msec of hlp_msec.v
  input logic [`HLP_MSEC_MSEC_TX_SALT_MEM_FROM_MEM_WIDTH-1:0] i_frm_msec_tx_salt_mem_1,// To u_msec of hlp_msec.v
  input logic [`HLP_MSEC_MSEC_TX_SALT_MEM_FROM_MEM_WIDTH-1:0] i_frm_msec_tx_salt_mem_2,// To u_msec of hlp_msec.v
  input logic [`HLP_MSEC_MSEC_TX_SC_VLAN_TAG_CTRL_FROM_MEM_WIDTH-1:0] i_frm_msec_tx_sc_vlan_tag_ctrl,// To u_msec of hlp_msec.v
  input logic [`HLP_MSEC_MSEC_TX_SCI_MEM_FROM_MEM_WIDTH-1:0] i_frm_msec_tx_sci_mem_0,// To u_msec of hlp_msec.v
  input logic [`HLP_MSEC_MSEC_TX_SCI_MEM_FROM_MEM_WIDTH-1:0] i_frm_msec_tx_sci_mem_1,// To u_msec of hlp_msec.v
  input logic [`HLP_MSEC_MSEC_TX_SSCI_MEM_FROM_MEM_WIDTH-1:0] i_frm_msec_tx_ssci_mem,// To u_msec of hlp_msec.v
  input logic [3:0]     i_id,                   // To u_msec of hlp_msec.v
  input hlp_pkg::msec_mac_rx_t i_msec_mac_rx,   // To u_msec of hlp_msec.v
  input logic           i_msec_mac_rx_v,        // To u_msec of hlp_msec.v
  input logic           i_msec_mac_tx_e,        // To u_msec of hlp_msec.v
  input logic           i_msec_switch_rx_e,     // To u_msec of hlp_msec.v
  input hlp_pkg::msec_switch_tx_t i_msec_switch_tx,// To u_msec of hlp_msec.v
  input logic           i_msec_switch_tx_v,     // To u_msec of hlp_msec.v
  input logic           i_msec_zeroize,         // To u_msec of hlp_msec.v
  input hlp_pkg::imn_rpl_bkwd_t i_rpl_bkwd,     // To u_msec of hlp_msec.v
  input hlp_pkg::imn_rpl_frwd_t i_rpl_frwd,     // To u_msec of hlp_msec.v
  input logic           mem_rst_n,              // To u_msec of hlp_msec.v
  input logic           ports_clk_free,         // To u_msec of hlp_msec.v
  input logic           powergood_rst_n,        // To u_msec of hlp_msec.v
  input logic           rst_n,                  // To u_msec of hlp_msec.v
  // End of automatics
  /*AUTOOUTPUT*/
  // Beginning of automatic outputs (from unused autoinst outputs)
  output logic          o_gclk,                 // From u_msec of hlp_msec.v
  output logic          o_msec_mac_rx_e,        // From u_msec of hlp_msec.v
  output hlp_pkg::msec_mac_tx_t o_msec_mac_tx,  // From u_msec of hlp_msec.v
  output logic          o_msec_mac_tx_v,        // From u_msec of hlp_msec.v
  output hlp_pkg::msec_switch_rx_t o_msec_switch_rx,// From u_msec of hlp_msec.v
  output logic          o_msec_switch_rx_v,     // From u_msec of hlp_msec.v
  output logic          o_msec_switch_tx_e,     // From u_msec of hlp_msec.v
  output logic          o_msec_zeroize_done,    // From u_msec of hlp_msec.v
  output hlp_pkg::imn_rpl_bkwd_t o_rpl_bkwd,    // From u_msec of hlp_msec.v
  output hlp_pkg::imn_rpl_frwd_t o_rpl_frwd,    // From u_msec of hlp_msec.v
  output logic [`HLP_MSEC_MSEC_RX_EOP_CLASS_MEM_TO_MEM_WIDTH-1:0] o_tom_msec_rx_eop_class_mem,// From u_msec of hlp_msec.v
  output logic [`HLP_MSEC_MSEC_RX_IBUF_MEM_TO_MEM_WIDTH-1:0] o_tom_msec_rx_ibuf_mem,// From u_msec of hlp_msec.v
  output logic [`HLP_MSEC_MSEC_RX_KEY_MEM_TO_MEM_WIDTH-1:0] o_tom_msec_rx_key_mem_0,// From u_msec of hlp_msec.v
  output logic [`HLP_MSEC_MSEC_RX_KEY_MEM_TO_MEM_WIDTH-1:0] o_tom_msec_rx_key_mem_1,// From u_msec of hlp_msec.v
  output logic [`HLP_MSEC_MSEC_RX_KEY_PTR_MEM_TO_MEM_WIDTH-1:0] o_tom_msec_rx_key_ptr_mem,// From u_msec of hlp_msec.v
  output logic [`HLP_MSEC_MSEC_RX_LOWEST_PN_MEM_TO_MEM_WIDTH-1:0] o_tom_msec_rx_lowest_pn_mem_0,// From u_msec of hlp_msec.v
  output logic [`HLP_MSEC_MSEC_RX_LOWEST_PN_MEM_TO_MEM_WIDTH-1:0] o_tom_msec_rx_lowest_pn_mem_1,// From u_msec of hlp_msec.v
  output logic [`HLP_MSEC_MSEC_RX_NEXT_PN_MEM_TO_MEM_WIDTH-1:0] o_tom_msec_rx_next_pn_mem_0,// From u_msec of hlp_msec.v
  output logic [`HLP_MSEC_MSEC_RX_NEXT_PN_MEM_TO_MEM_WIDTH-1:0] o_tom_msec_rx_next_pn_mem_1,// From u_msec of hlp_msec.v
  output logic [`HLP_MSEC_MSEC_RX_OBUF_MEM_TO_MEM_WIDTH-1:0] o_tom_msec_rx_obuf_mem,// From u_msec of hlp_msec.v
  output logic [`HLP_MSEC_MSEC_RX_PKT_CNT_MEM_TO_MEM_WIDTH-1:0] o_tom_msec_rx_pkt_cnt_mem_0,// From u_msec of hlp_msec.v
  output logic [`HLP_MSEC_MSEC_RX_PKT_CNT_MEM_TO_MEM_WIDTH-1:0] o_tom_msec_rx_pkt_cnt_mem_1,// From u_msec of hlp_msec.v
  output logic [`HLP_MSEC_MSEC_RX_SALT_MEM_TO_MEM_WIDTH-1:0] o_tom_msec_rx_salt_mem_0,// From u_msec of hlp_msec.v
  output logic [`HLP_MSEC_MSEC_RX_SALT_MEM_TO_MEM_WIDTH-1:0] o_tom_msec_rx_salt_mem_1,// From u_msec of hlp_msec.v
  output logic [`HLP_MSEC_MSEC_RX_SALT_MEM_TO_MEM_WIDTH-1:0] o_tom_msec_rx_salt_mem_2,// From u_msec of hlp_msec.v
  output logic [`HLP_MSEC_MSEC_RX_SC_VLAN_TAG_CTRL_TO_MEM_WIDTH-1:0] o_tom_msec_rx_sc_vlan_tag_ctrl,// From u_msec of hlp_msec.v
  output logic [`HLP_MSEC_MSEC_RX_SSCI_MEM_TO_MEM_WIDTH-1:0] o_tom_msec_rx_ssci_mem,// From u_msec of hlp_msec.v
  output logic [`HLP_MSEC_MSEC_TX_IBUF_MEM_TO_MEM_WIDTH-1:0] o_tom_msec_tx_ibuf_mem,// From u_msec of hlp_msec.v
  output logic [`HLP_MSEC_MSEC_TX_KEY_MEM_TO_MEM_WIDTH-1:0] o_tom_msec_tx_key_mem_0,// From u_msec of hlp_msec.v
  output logic [`HLP_MSEC_MSEC_TX_KEY_MEM_TO_MEM_WIDTH-1:0] o_tom_msec_tx_key_mem_1,// From u_msec of hlp_msec.v
  output logic [`HLP_MSEC_MSEC_TX_KEY_PTR_MEM_TO_MEM_WIDTH-1:0] o_tom_msec_tx_key_ptr_mem,// From u_msec of hlp_msec.v
  output logic [`HLP_MSEC_MSEC_TX_NEXT_PN_MEM_TO_MEM_WIDTH-1:0] o_tom_msec_tx_next_pn_mem_0,// From u_msec of hlp_msec.v
  output logic [`HLP_MSEC_MSEC_TX_NEXT_PN_MEM_TO_MEM_WIDTH-1:0] o_tom_msec_tx_next_pn_mem_1,// From u_msec of hlp_msec.v
  output logic [`HLP_MSEC_MSEC_TX_OBUF_MEM_TO_MEM_WIDTH-1:0] o_tom_msec_tx_obuf_mem,// From u_msec of hlp_msec.v
  output logic [`HLP_MSEC_MSEC_TX_PKT_CNT_MEM_TO_MEM_WIDTH-1:0] o_tom_msec_tx_pkt_cnt_mem_0,// From u_msec of hlp_msec.v
  output logic [`HLP_MSEC_MSEC_TX_PKT_CNT_MEM_TO_MEM_WIDTH-1:0] o_tom_msec_tx_pkt_cnt_mem_1,// From u_msec of hlp_msec.v
  output logic [`HLP_MSEC_MSEC_TX_SALT_MEM_TO_MEM_WIDTH-1:0] o_tom_msec_tx_salt_mem_0,// From u_msec of hlp_msec.v
  output logic [`HLP_MSEC_MSEC_TX_SALT_MEM_TO_MEM_WIDTH-1:0] o_tom_msec_tx_salt_mem_1,// From u_msec of hlp_msec.v
  output logic [`HLP_MSEC_MSEC_TX_SALT_MEM_TO_MEM_WIDTH-1:0] o_tom_msec_tx_salt_mem_2,// From u_msec of hlp_msec.v
  output logic [`HLP_MSEC_MSEC_TX_SC_VLAN_TAG_CTRL_TO_MEM_WIDTH-1:0] o_tom_msec_tx_sc_vlan_tag_ctrl,// From u_msec of hlp_msec.v
  output logic [`HLP_MSEC_MSEC_TX_SCI_MEM_TO_MEM_WIDTH-1:0] o_tom_msec_tx_sci_mem_0,// From u_msec of hlp_msec.v
  output logic [`HLP_MSEC_MSEC_TX_SCI_MEM_TO_MEM_WIDTH-1:0] o_tom_msec_tx_sci_mem_1,// From u_msec of hlp_msec.v
  output logic [`HLP_MSEC_MSEC_TX_SSCI_MEM_TO_MEM_WIDTH-1:0] o_tom_msec_tx_ssci_mem// From u_msec of hlp_msec.v
  // End of automatics
  );

  // Connect power acks to enables.
  assign fet_ack_b  = fet_en_b;
  assign isol_ack_b = isol_en_b;

  // Connect VISA CFG & SEC Outputs
  assign avisa_all_dis = fvisa_all_dis;
  assign avisa_customer_dis = fvisa_customer_dis;

  // Tie off placeholder scan chain outputs.
  assign ascan_sdo = '0;

  /*AUTOLOGIC*/
logic clock;
  hlp_msec u_msec
    (/*AUTOINST*/
     // Outputs
     .o_gclk                            (o_gclk),
     .ascan_preclk_div4_clk             (ascan_preclk_div4_clk),
     .o_msec_mac_tx                     (o_msec_mac_tx),
     .o_msec_mac_tx_v                   (o_msec_mac_tx_v),
     .o_msec_switch_tx_e                (o_msec_switch_tx_e),
     .o_msec_mac_rx_e                   (o_msec_mac_rx_e),
     .o_msec_switch_rx                  (o_msec_switch_rx),
     .o_msec_switch_rx_v                (o_msec_switch_rx_v),
     .o_tom_msec_rx_eop_class_mem       (o_tom_msec_rx_eop_class_mem[`HLP_MSEC_MSEC_RX_EOP_CLASS_MEM_TO_MEM_WIDTH-1:0]),
     .o_tom_msec_rx_ibuf_mem            (o_tom_msec_rx_ibuf_mem[`HLP_MSEC_MSEC_RX_IBUF_MEM_TO_MEM_WIDTH-1:0]),
     .o_tom_msec_rx_key_mem_0           (o_tom_msec_rx_key_mem_0[`HLP_MSEC_MSEC_RX_KEY_MEM_TO_MEM_WIDTH-1:0]),
     .o_tom_msec_rx_key_mem_1           (o_tom_msec_rx_key_mem_1[`HLP_MSEC_MSEC_RX_KEY_MEM_TO_MEM_WIDTH-1:0]),
     .o_tom_msec_rx_key_ptr_mem         (o_tom_msec_rx_key_ptr_mem[`HLP_MSEC_MSEC_RX_KEY_PTR_MEM_TO_MEM_WIDTH-1:0]),
     .o_tom_msec_rx_lowest_pn_mem_0     (o_tom_msec_rx_lowest_pn_mem_0[`HLP_MSEC_MSEC_RX_LOWEST_PN_MEM_TO_MEM_WIDTH-1:0]),
     .o_tom_msec_rx_lowest_pn_mem_1     (o_tom_msec_rx_lowest_pn_mem_1[`HLP_MSEC_MSEC_RX_LOWEST_PN_MEM_TO_MEM_WIDTH-1:0]),
     .o_tom_msec_rx_next_pn_mem_0       (o_tom_msec_rx_next_pn_mem_0[`HLP_MSEC_MSEC_RX_NEXT_PN_MEM_TO_MEM_WIDTH-1:0]),
     .o_tom_msec_rx_next_pn_mem_1       (o_tom_msec_rx_next_pn_mem_1[`HLP_MSEC_MSEC_RX_NEXT_PN_MEM_TO_MEM_WIDTH-1:0]),
     .o_tom_msec_rx_obuf_mem            (o_tom_msec_rx_obuf_mem[`HLP_MSEC_MSEC_RX_OBUF_MEM_TO_MEM_WIDTH-1:0]),
     .o_tom_msec_rx_salt_mem_0          (o_tom_msec_rx_salt_mem_0[`HLP_MSEC_MSEC_RX_SALT_MEM_TO_MEM_WIDTH-1:0]),
     .o_tom_msec_rx_salt_mem_1          (o_tom_msec_rx_salt_mem_1[`HLP_MSEC_MSEC_RX_SALT_MEM_TO_MEM_WIDTH-1:0]),
     .o_tom_msec_rx_salt_mem_2          (o_tom_msec_rx_salt_mem_2[`HLP_MSEC_MSEC_RX_SALT_MEM_TO_MEM_WIDTH-1:0]),
     .o_tom_msec_rx_ssci_mem            (o_tom_msec_rx_ssci_mem[`HLP_MSEC_MSEC_RX_SSCI_MEM_TO_MEM_WIDTH-1:0]),
     .o_tom_msec_tx_sci_mem_0           (o_tom_msec_tx_sci_mem_0[`HLP_MSEC_MSEC_TX_SCI_MEM_TO_MEM_WIDTH-1:0]),
     .o_tom_msec_tx_sci_mem_1           (o_tom_msec_tx_sci_mem_1[`HLP_MSEC_MSEC_TX_SCI_MEM_TO_MEM_WIDTH-1:0]),
     .o_tom_msec_tx_ibuf_mem            (o_tom_msec_tx_ibuf_mem[`HLP_MSEC_MSEC_TX_IBUF_MEM_TO_MEM_WIDTH-1:0]),
     .o_tom_msec_tx_key_mem_0           (o_tom_msec_tx_key_mem_0[`HLP_MSEC_MSEC_TX_KEY_MEM_TO_MEM_WIDTH-1:0]),
     .o_tom_msec_tx_key_mem_1           (o_tom_msec_tx_key_mem_1[`HLP_MSEC_MSEC_TX_KEY_MEM_TO_MEM_WIDTH-1:0]),
     .o_tom_msec_tx_key_ptr_mem         (o_tom_msec_tx_key_ptr_mem[`HLP_MSEC_MSEC_TX_KEY_PTR_MEM_TO_MEM_WIDTH-1:0]),
     .o_tom_msec_tx_next_pn_mem_0       (o_tom_msec_tx_next_pn_mem_0[`HLP_MSEC_MSEC_TX_NEXT_PN_MEM_TO_MEM_WIDTH-1:0]),
     .o_tom_msec_tx_next_pn_mem_1       (o_tom_msec_tx_next_pn_mem_1[`HLP_MSEC_MSEC_TX_NEXT_PN_MEM_TO_MEM_WIDTH-1:0]),
     .o_tom_msec_tx_obuf_mem            (o_tom_msec_tx_obuf_mem[`HLP_MSEC_MSEC_TX_OBUF_MEM_TO_MEM_WIDTH-1:0]),
     .o_tom_msec_tx_salt_mem_0          (o_tom_msec_tx_salt_mem_0[`HLP_MSEC_MSEC_TX_SALT_MEM_TO_MEM_WIDTH-1:0]),
     .o_tom_msec_tx_salt_mem_1          (o_tom_msec_tx_salt_mem_1[`HLP_MSEC_MSEC_TX_SALT_MEM_TO_MEM_WIDTH-1:0]),
     .o_tom_msec_tx_salt_mem_2          (o_tom_msec_tx_salt_mem_2[`HLP_MSEC_MSEC_TX_SALT_MEM_TO_MEM_WIDTH-1:0]),
     .o_tom_msec_tx_ssci_mem            (o_tom_msec_tx_ssci_mem[`HLP_MSEC_MSEC_TX_SSCI_MEM_TO_MEM_WIDTH-1:0]),
     .o_tom_msec_rx_sc_vlan_tag_ctrl    (o_tom_msec_rx_sc_vlan_tag_ctrl[`HLP_MSEC_MSEC_RX_SC_VLAN_TAG_CTRL_TO_MEM_WIDTH-1:0]),
     .o_tom_msec_tx_sc_vlan_tag_ctrl    (o_tom_msec_tx_sc_vlan_tag_ctrl[`HLP_MSEC_MSEC_TX_SC_VLAN_TAG_CTRL_TO_MEM_WIDTH-1:0]),
     .o_tom_msec_rx_pkt_cnt_mem_0       (o_tom_msec_rx_pkt_cnt_mem_0[`HLP_MSEC_MSEC_RX_PKT_CNT_MEM_TO_MEM_WIDTH-1:0]),
     .o_tom_msec_tx_pkt_cnt_mem_0       (o_tom_msec_tx_pkt_cnt_mem_0[`HLP_MSEC_MSEC_TX_PKT_CNT_MEM_TO_MEM_WIDTH-1:0]),
     .o_tom_msec_rx_pkt_cnt_mem_1       (o_tom_msec_rx_pkt_cnt_mem_1[`HLP_MSEC_MSEC_RX_PKT_CNT_MEM_TO_MEM_WIDTH-1:0]),
     .o_tom_msec_tx_pkt_cnt_mem_1       (o_tom_msec_tx_pkt_cnt_mem_1[`HLP_MSEC_MSEC_TX_PKT_CNT_MEM_TO_MEM_WIDTH-1:0]),
     .o_msec_zeroize_done               (o_msec_zeroize_done),
     .o_rpl_bkwd                        (o_rpl_bkwd),
     .o_rpl_frwd                        (o_rpl_frwd),
     // Inputs
     .clk                               (clock),
     .rst_n                             (rst_n),
     .ports_clk_free                    (ports_clk_free),
     .fscan_clkungate                   (fscan_clkungate),
     .fscan_clkgenctrl                  (fscan_clkgenctrl[hlp_dfx_pkg::MSEC_NUM_CLKGENCTRL-1:0]),
     .fscan_clkgenctrlen                (fscan_clkgenctrlen[hlp_dfx_pkg::MSEC_NUM_CLKGENCTRLEN-1:0]),
     .fscan_mode                        (fscan_mode),
     .fscan_postclk_div4_clk            (fscan_postclk_div4_clk),
     .fscan_rstbypen                    (fscan_rstbypen),
     .fscan_byprst_b                    (fscan_byprst_b),
     .i_msec_mac_tx_e                   (i_msec_mac_tx_e),
     .i_msec_switch_tx                  (i_msec_switch_tx),
     .i_msec_switch_tx_v                (i_msec_switch_tx_v),
     .i_msec_mac_rx                     (i_msec_mac_rx),
     .i_msec_mac_rx_v                   (i_msec_mac_rx_v),
     .i_msec_switch_rx_e                (i_msec_switch_rx_e),
     .i_frm_msec_rx_eop_class_mem       (i_frm_msec_rx_eop_class_mem[`HLP_MSEC_MSEC_RX_EOP_CLASS_MEM_FROM_MEM_WIDTH-1:0]),
     .i_frm_msec_rx_ibuf_mem            (i_frm_msec_rx_ibuf_mem[`HLP_MSEC_MSEC_RX_IBUF_MEM_FROM_MEM_WIDTH-1:0]),
     .i_frm_msec_rx_key_mem_0           (i_frm_msec_rx_key_mem_0[`HLP_MSEC_MSEC_RX_KEY_MEM_FROM_MEM_WIDTH-1:0]),
     .i_frm_msec_rx_key_mem_1           (i_frm_msec_rx_key_mem_1[`HLP_MSEC_MSEC_RX_KEY_MEM_FROM_MEM_WIDTH-1:0]),
     .i_frm_msec_rx_key_ptr_mem         (i_frm_msec_rx_key_ptr_mem[`HLP_MSEC_MSEC_RX_KEY_PTR_MEM_FROM_MEM_WIDTH-1:0]),
     .i_frm_msec_rx_lowest_pn_mem_0     (i_frm_msec_rx_lowest_pn_mem_0[`HLP_MSEC_MSEC_RX_LOWEST_PN_MEM_FROM_MEM_WIDTH-1:0]),
     .i_frm_msec_rx_lowest_pn_mem_1     (i_frm_msec_rx_lowest_pn_mem_1[`HLP_MSEC_MSEC_RX_LOWEST_PN_MEM_FROM_MEM_WIDTH-1:0]),
     .i_frm_msec_rx_next_pn_mem_0       (i_frm_msec_rx_next_pn_mem_0[`HLP_MSEC_MSEC_RX_NEXT_PN_MEM_FROM_MEM_WIDTH-1:0]),
     .i_frm_msec_rx_next_pn_mem_1       (i_frm_msec_rx_next_pn_mem_1[`HLP_MSEC_MSEC_RX_NEXT_PN_MEM_FROM_MEM_WIDTH-1:0]),
     .i_frm_msec_rx_obuf_mem            (i_frm_msec_rx_obuf_mem[`HLP_MSEC_MSEC_RX_OBUF_MEM_FROM_MEM_WIDTH-1:0]),
     .i_frm_msec_rx_salt_mem_0          (i_frm_msec_rx_salt_mem_0[`HLP_MSEC_MSEC_RX_SALT_MEM_FROM_MEM_WIDTH-1:0]),
     .i_frm_msec_rx_salt_mem_1          (i_frm_msec_rx_salt_mem_1[`HLP_MSEC_MSEC_RX_SALT_MEM_FROM_MEM_WIDTH-1:0]),
     .i_frm_msec_rx_salt_mem_2          (i_frm_msec_rx_salt_mem_2[`HLP_MSEC_MSEC_RX_SALT_MEM_FROM_MEM_WIDTH-1:0]),
     .i_frm_msec_rx_ssci_mem            (i_frm_msec_rx_ssci_mem[`HLP_MSEC_MSEC_RX_SSCI_MEM_FROM_MEM_WIDTH-1:0]),
     .i_frm_msec_tx_sci_mem_0           (i_frm_msec_tx_sci_mem_0[`HLP_MSEC_MSEC_TX_SCI_MEM_FROM_MEM_WIDTH-1:0]),
     .i_frm_msec_tx_sci_mem_1           (i_frm_msec_tx_sci_mem_1[`HLP_MSEC_MSEC_TX_SCI_MEM_FROM_MEM_WIDTH-1:0]),
     .i_frm_msec_tx_key_mem_0           (i_frm_msec_tx_key_mem_0[`HLP_MSEC_MSEC_TX_KEY_MEM_FROM_MEM_WIDTH-1:0]),
     .i_frm_msec_tx_key_mem_1           (i_frm_msec_tx_key_mem_1[`HLP_MSEC_MSEC_TX_KEY_MEM_FROM_MEM_WIDTH-1:0]),
     .i_frm_msec_tx_key_ptr_mem         (i_frm_msec_tx_key_ptr_mem[`HLP_MSEC_MSEC_TX_KEY_PTR_MEM_FROM_MEM_WIDTH-1:0]),
     .i_frm_msec_tx_next_pn_mem_0       (i_frm_msec_tx_next_pn_mem_0[`HLP_MSEC_MSEC_TX_NEXT_PN_MEM_FROM_MEM_WIDTH-1:0]),
     .i_frm_msec_tx_next_pn_mem_1       (i_frm_msec_tx_next_pn_mem_1[`HLP_MSEC_MSEC_TX_NEXT_PN_MEM_FROM_MEM_WIDTH-1:0]),
     .i_frm_msec_tx_ibuf_mem            (i_frm_msec_tx_ibuf_mem[`HLP_MSEC_MSEC_TX_IBUF_MEM_FROM_MEM_WIDTH-1:0]),
     .i_frm_msec_tx_obuf_mem            (i_frm_msec_tx_obuf_mem[`HLP_MSEC_MSEC_TX_OBUF_MEM_FROM_MEM_WIDTH-1:0]),
     .i_frm_msec_tx_salt_mem_0          (i_frm_msec_tx_salt_mem_0[`HLP_MSEC_MSEC_TX_SALT_MEM_FROM_MEM_WIDTH-1:0]),
     .i_frm_msec_tx_salt_mem_1          (i_frm_msec_tx_salt_mem_1[`HLP_MSEC_MSEC_TX_SALT_MEM_FROM_MEM_WIDTH-1:0]),
     .i_frm_msec_tx_salt_mem_2          (i_frm_msec_tx_salt_mem_2[`HLP_MSEC_MSEC_TX_SALT_MEM_FROM_MEM_WIDTH-1:0]),
     .i_frm_msec_tx_ssci_mem            (i_frm_msec_tx_ssci_mem[`HLP_MSEC_MSEC_TX_SSCI_MEM_FROM_MEM_WIDTH-1:0]),
     .i_frm_msec_rx_sc_vlan_tag_ctrl    (i_frm_msec_rx_sc_vlan_tag_ctrl[`HLP_MSEC_MSEC_RX_SC_VLAN_TAG_CTRL_FROM_MEM_WIDTH-1:0]),
     .i_frm_msec_tx_sc_vlan_tag_ctrl    (i_frm_msec_tx_sc_vlan_tag_ctrl[`HLP_MSEC_MSEC_TX_SC_VLAN_TAG_CTRL_FROM_MEM_WIDTH-1:0]),
     .i_frm_msec_rx_pkt_cnt_mem_0       (i_frm_msec_rx_pkt_cnt_mem_0[`HLP_MSEC_MSEC_RX_PKT_CNT_MEM_FROM_MEM_WIDTH-1:0]),
     .i_frm_msec_tx_pkt_cnt_mem_0       (i_frm_msec_tx_pkt_cnt_mem_0[`HLP_MSEC_MSEC_TX_PKT_CNT_MEM_FROM_MEM_WIDTH-1:0]),
     .i_frm_msec_rx_pkt_cnt_mem_1       (i_frm_msec_rx_pkt_cnt_mem_1[`HLP_MSEC_MSEC_RX_PKT_CNT_MEM_FROM_MEM_WIDTH-1:0]),
     .i_frm_msec_tx_pkt_cnt_mem_1       (i_frm_msec_tx_pkt_cnt_mem_1[`HLP_MSEC_MSEC_TX_PKT_CNT_MEM_FROM_MEM_WIDTH-1:0]),
     .i_id                              (i_id[3:0]),
     .i_force_clk_en                    (i_force_clk_en),
     .i_disable                         (i_disable),
     .powergood_rst_n                   (powergood_rst_n),
     .mem_rst_n                         (mem_rst_n),
     .i_msec_zeroize                    (i_msec_zeroize),
     .i_rpl_frwd                        (i_rpl_frwd),
     .i_rpl_bkwd                        (i_rpl_bkwd));

endmodule
// Local Variables:
// End:
//------------------------------------------------------------------------------
//
