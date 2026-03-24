//  INTEL TOP SECRET 
// 
//  Copyright 2018 Intel Corporation All Rights Reserved. 
// 
//  The source code contained or described herein and all documents related 
//  to the source code (Material) are owned by Intel Corporation or its 
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
//  Inserted by Intel DSD. 

///  INTEL TOP SECRET
///
///  Copyright 2018 Intel Corporation All Rights Reserved.
///
///  The source code contained or described herein and all documents related
///  to the source code ("Material") are owned by Intel Corporation or its
///  suppliers or licensors. Title to the Material remains with Intel
///  Corporation or its suppliers and licensors. The Material contains trade
///  secrets and proprietary and confidential information of Intel or its
///  suppliers and licensors. The Material is protected by worldwide copyright
///  and trade secret laws and treaty provisions. No part of the Material may
///  be used, copied, reproduced, modified, published, uploaded, posted,
///  transmitted, distributed, or disclosed in any way without Intel's prior
///  express written permission.
///
///  No license under any patent, copyright, trade secret or other intellectual
///  property right is granted to or conferred upon you by disclosure or
///  delivery of the Materials, either expressly, by implication, inducement,
///  estoppel or otherwise. Any license under such intellectual property rights
///  must be express and approved by Intel in writing.


/************************************************************************/
//  Copyright (c) Intel Corporation All Rights Reserved
//  Networking Division
//  Intel Proprietary
//
//  FILE information :
//  ------------------
//  File name      : lanpe_rps_cntx_access.sv
//  Creator        : Gidi Getter
//
//  Description :
//  -------------
//      <High-level Description of the modules functionality/purpose>
//
//  Assumptions :
//  -------------
//      <Design assumptions related to this module>
//
//  Notes :
//  -------
//
/************************************************************************/

module lanpe_rps_cntx_access
import lanpe_rps_package::*;
(
    input  logic                                                      clk,
    input  logic                                                      rst_n,

    // RLAN read request interface
    lanpe_vld_rdy_intf.target_sc_cmd                                  io_rlan_evq_cntx_req_intf,

    // RLAN read data interface
    lanpe_vld_rdy_intf.master_sc_data                                 io_rlan_evq_cntx_rslt_intf,

    // Q ctrl queue enable interface
    lanpe_reg_intf.master_array                                       io_q_ctrl_q_en_intf,

    // CSR request to cntx_mem_ctrl & read data
    lanpe_rps_mem_intf.master_1rw                                     io_mem_ctrl_csr_q_cntx_early_static_intf,
    lanpe_rps_mem_intf.master_1rw                                     io_mem_ctrl_csr_q_cntx_static_intf,
    lanpe_rps_mem_intf.master_1rw                                     io_mem_ctrl_csr_q_cntx_buffer_static_intf,
    lanpe_rps_mem_intf.master_1r1w                                    io_mem_ctrl_csr_q_cntx_first_pkt_intf,
    lanpe_rps_mem_intf.master_1r1w                                    io_mem_ctrl_csr_q_cntx_buffer_first_pkt_intf,
    lanpe_rps_mem_intf.master_1r1w                                    io_mem_ctrl_csr_q_cntx_ring_head_intf,
    lanpe_rps_mem_intf.master_1r1w                                    io_mem_ctrl_csr_q_cntx_ring_empty_intf,
    lanpe_rps_mem_intf.master_1r                                      io_mem_ctrl_rlan_q_cntx_static_intf,

    // CSR interface
    input  csr_cntx_access_ctrl_t                                     i_csr_cntx_access_ctrl,
    lanpe_reg_intf.target_array                                       io_csr_context_data_intf,
    lanpe_reg_intf.target_single                                      io_csr_context_ctl_intf,
    lanpe_reg_intf.target_single                                      io_csr_context_stat_intf,
    lanpe_reg_intf.target_array                                       io_csr_cqbal_intf,
    lanpe_reg_intf.target_array                                       io_csr_cqbah_intf,
    lanpe_reg_intf.target_array                                       io_csr_cqlen_intf,
    lanpe_reg_intf.target_array                                       io_csr_q_en_intf,
    lanpe_reg_intf.target_array                                       io_csr_q_head_intf,
    lanpe_reg_intf.target_array                                       io_csr_buffq_head_intf,
    lanpe_reg_intf.target_array                                       io_csr_ring_empty_intf,

    // DFD updates
    input  dfd_global_controls_t                                      i_dfd_global_controls,
    output dfd_cntx_access_updates_t                                  o_dfd_cntx_access_updates
);


    ////////////////////////
    // PARAMETERS & TYPES //
    ////////////////////////

    localparam CNTX_MEM_NUM = 3;
    typedef enum logic [2-1:0] {
        IDLE  = 0,
        CQBAL = 1,
        CQBAH = 2,
        CQLEN = 3
    } qrx_cq_reg_t;


    /////////////////////////
    // SIGNALS DECLARATION //
    /////////////////////////

    // QRX_CONTEXT indirect access
    reg                                                               csr_context_data_wr_req_s_ff;
    reg_data_t                                                        csr_context_data_wr_data_s_ff;
    reg                                                               csr_context_data_rd_req_s_ff;
    csr_cntx_data_idx_t                                               csr_context_data_idx_s_ff;
    logic                                                             csr_context_data_ack_nxt;
    reg                                                               csr_context_data_ack_ff;
    reg_data_t                                                        csr_context_data_rd_data_nxt;
    reg_data_t                                                        csr_context_data_rd_data_ff;
    reg                                                               csr_context_ctl_wr_req_s_ff;
    csr_cntx_ctl_data_t                                               csr_context_ctl_wr_data_s_ff;
    reg                                                               csr_context_ctl_rd_req_s_ff;
    csr_cntx_ctl_data_t                                               csr_context_ctl_l_nxt;
    csr_cntx_ctl_data_t                                               csr_context_ctl_l_ff;
    logic                                                             csr_context_ctl_ack_nxt;
    reg                                                               csr_context_ctl_ack_ff;
    reg                                                               csr_context_ctl_rd_vld_ff;
    reg                                                               csr_context_stat_wr_req_s_ff;
    reg                                                               csr_context_stat_rd_req_s_ff;
    logic                                                             csr_context_stat_ack_nxt;
    reg                                                               csr_context_stat_ack_ff;
    logic                                                             csr_context_stat_rd_data_nxt;
    reg                                                               csr_context_stat_rd_data_ff;
    logic                                                             csr_context_wr_req_wr_cmd_start;
    logic                                                             csr_context_wr_req_rd_cmd_start;
    logic                                                             csr_context_wr_req_wr_cmd_done;
    logic                                                             csr_context_wr_req_rd_cmd_done;
    logic                                                             csr_context_wr_req_init_en;
    logic                                                             csr_context_wr_req_init_vm_mig;
    logic                                        [CNTX_MEM_NUM-1:0]   csr_context_wr_req_waiting_wr_rdy_nxt;
    reg                                          [CNTX_MEM_NUM-1:0]   csr_context_wr_req_waiting_wr_rdy_ff;
    logic                                        [CNTX_MEM_NUM-1:0]   csr_context_wr_req_waiting_rd_vld_nxt;
    reg                                          [CNTX_MEM_NUM-1:0]   csr_context_wr_req_waiting_rd_vld_ff;
    logic                                                             csr_context_wr_req_wr_cmd_active_nxt;
    reg                                                               csr_context_wr_req_wr_cmd_active_ff;
    logic                                                             csr_context_wr_req_rd_cmd_active_nxt;
    reg                                                               csr_context_wr_req_rd_cmd_active_ff;
    logic                                                             csr_context_wr_req_init_active_nxt;
    reg                                                               csr_context_wr_req_init_active_ff;
    logic                                                             csr_context_wr_req_init_stage_sel;
    reg                                                               csr_context_wr_req_init_stage_ff;
    logic                                                             csr_context_wr_req_init_vm_mig_nxt;
    reg                                                               csr_context_wr_req_init_vm_mig_ff;
    logic                                                             csr_context_wr_req_nl_cmd_done;
    q_cntx_static_table_data_t                                        csr_context_table_nxt;
    q_cntx_static_table_data_t                                        csr_context_table_ff;
    q_cntx_static_table_data_t                                        csr_context_table_from_static_mem;
    q_cntx_static_table_data_t                                        csr_context_table_from_buffer_static_mem;
    q_cntx_early_mem_data_t                                           csr_context_table_to_early_static_mem;
    q_cntx_mem_data_t                                                 csr_context_table_to_static_mem;
    buffq_cntx_mem_data_t                                             csr_context_table_to_buffer_static_mem;
    // QRX_INT_RD_HEAD
    reg                                                               csr_q_head_wr_req_s_ff;
    ring_desc_offset_t                                                csr_q_head_wr_data_s_ff;
    reg                                                               csr_q_head_rd_req_s_ff;
    target_q_idx_t                                                    csr_q_head_idx_s_ff;
    logic                                                             csr_q_head_vld_l_nxt;
    reg                                                               csr_q_head_vld_l_ff;
    ring_desc_offset_t                                                csr_q_head_wr_data_l_nxt;
    ring_desc_offset_t                                                csr_q_head_wr_data_l_ff;
    target_q_idx_t                                                    csr_q_head_idx_l_nxt;
    target_q_idx_t                                                    csr_q_head_idx_l_ff;
    logic                                                             csr_q_head_ack_nxt;
    reg                                                               csr_q_head_ack_ff;
    ring_desc_offset_t                                                csr_q_head_rd_data_nxt;
    ring_desc_offset_t                                                csr_q_head_rd_data_ff;
    reg                                                               csr_buffq_head_wr_req_s_ff;
    ring_desc_offset_t                                                csr_buffq_head_wr_data_s_ff;
    reg                                                               csr_buffq_head_rd_req_s_ff;
    buffer_q_idx_t                                                    csr_buffq_head_idx_s_ff;
    logic                                                             csr_buffq_head_vld_l_nxt;
    reg                                                               csr_buffq_head_vld_l_ff;
    ring_desc_offset_t                                                csr_buffq_head_wr_data_l_nxt;
    ring_desc_offset_t                                                csr_buffq_head_wr_data_l_ff;
    buffer_q_idx_t                                                    csr_buffq_head_idx_l_nxt;
    buffer_q_idx_t                                                    csr_buffq_head_idx_l_ff;
    logic                                                             csr_buffq_head_ack_nxt;
    reg                                                               csr_buffq_head_ack_ff;
    ring_desc_offset_t                                                csr_buffq_head_rd_data_nxt;
    ring_desc_offset_t                                                csr_buffq_head_rd_data_ff;
    logic                                                             mem_ctrl_csr_q_cntx_ring_head_wr_en_nxt;
    reg                                                               mem_ctrl_csr_q_cntx_ring_head_wr_en_ff;
    logic                                                             mem_ctrl_csr_q_cntx_ring_head_rd_en_nxt;
    reg                                                               mem_ctrl_csr_q_cntx_ring_head_rd_en_ff;
    q_ring_ptr_mem_addr_t                                             mem_ctrl_csr_q_cntx_ring_head_addr;
    q_ring_ptr_mem_data_t                                             mem_ctrl_csr_q_cntx_ring_head_wr_data;
    // QRX_CQBAL, QRX_CQBAH, QRX_CQLEN direct access
    reg                                                               csr_cqbal_wr_req_s_ff;
    base_addr_low_t                                                   csr_cqbal_wr_data_s_ff;
    reg                                                               csr_cqbal_rd_req_s_ff;
    target_q_idx_t                                                    csr_cqbal_idx_s_ff;
    base_addr_low_t                                                   csr_cqbal_wr_data_l_nxt;
    base_addr_low_t                                                   csr_cqbal_wr_data_l_ff;
    logic                                                             csr_cqbal_ack_nxt;
    reg                                                               csr_cqbal_ack_ff;
    base_addr_low_t                                                   csr_cqbal_rd_data_nxt;
    base_addr_low_t                                                   csr_cqbal_rd_data_ff;
    reg                                                               csr_cqbah_wr_req_s_ff;
    base_addr_high_t                                                  csr_cqbah_wr_data_s_ff;
    reg                                                               csr_cqbah_rd_req_s_ff;
    target_q_idx_t                                                    csr_cqbah_idx_s_ff;
    base_addr_high_t                                                  csr_cqbah_wr_data_l_nxt;
    base_addr_high_t                                                  csr_cqbah_wr_data_l_ff;
    logic                                                             csr_cqbah_ack_nxt;
    reg                                                               csr_cqbah_ack_ff;
    base_addr_high_t                                                  csr_cqbah_rd_data_nxt;
    base_addr_high_t                                                  csr_cqbah_rd_data_ff;
    reg                                                               csr_cqlen_wr_req_s_ff;
    csr_cqlen_data_t                                                  csr_cqlen_wr_data_s_ff;
    reg                                                               csr_cqlen_rd_req_s_ff;
    target_q_idx_t                                                    csr_cqlen_idx_s_ff;
    csr_cqlen_data_t                                                  csr_cqlen_wr_data_l_nxt;
    csr_cqlen_data_t                                                  csr_cqlen_wr_data_l_ff;
    logic                                                             csr_cqlen_ack_nxt;
    reg                                                               csr_cqlen_ack_ff;
//    csr_cqlen_data_t                                                  csr_cqlen_rd_data_pre_l_nxt;
//    csr_cqlen_data_t                                                  csr_cqlen_rd_data_pre_l_ff;
    ring_desc_offset_t                                                csr_cqlen_rd_data_pre_l_nxt;
    ring_desc_offset_t                                                csr_cqlen_rd_data_pre_l_ff;
    csr_cqlen_data_t                                                  csr_cqlen_rd_data_nxt;
    csr_cqlen_data_t                                                  csr_cqlen_rd_data_ff;
    qrx_cq_reg_t                                                      csr_cq_reg_l_nxt;
    qrx_cq_reg_t                                                      csr_cq_reg_l_ff;
    target_q_idx_t                                                    csr_cq_idx_l_nxt;
    target_q_idx_t                                                    csr_cq_idx_l_ff;
    q_cntx_mem_data_t                                                 csr_cq_context_table_nxt;
    q_cntx_mem_data_t                                                 csr_cq_context_table_ff;
    logic                                                             csr_cq_wr_cmd_start;
    logic                                                             csr_cq_rd_cmd_start;
    logic                                                             csr_cq_wr_cmd_done;
    logic                                                             csr_cq_rd_cmd_done;
    logic                                                             csr_cq_wr_cmd_active_nxt;
    reg                                                               csr_cq_wr_cmd_active_ff;
    logic                                                             csr_cq_rd_cmd_active_nxt;
    reg                                                               csr_cq_rd_cmd_active_ff;
    logic                                                             csr_cq_any_cmd_active;
    logic                                                             csr_cq_context_wr_access_start;
    logic                                                             csr_cq_context_rd_access_start;
    logic                                                             csr_cq_during_context_wr_access_nxt;
    reg                                                               csr_cq_during_context_wr_access_ff;
    logic                                                             csr_cq_q_ctrl_wr_mask;
    logic                                                             csr_cq_q_ctrl_wr_req;
    logic                                                             csr_cq_q_ctrl_q_en_wr_data;
    logic                                                             csr_cq_q_ctrl_rd_req;
    target_q_idx_t                                                    csr_cq_q_ctrl_idx;
    logic                                                             mem_ctrl_csr_cq_cntx_static_wr_en_nxt;
    reg                                                               mem_ctrl_csr_cq_cntx_static_wr_en_ff;
    logic                                                             mem_ctrl_csr_cq_cntx_static_rd_en_nxt;
    reg                                                               mem_ctrl_csr_cq_cntx_static_rd_en_ff;
    // QRX context memory access
    logic                                                             mem_ctrl_csr_q_cntx_early_static_wr_ev;
    logic                                                             mem_ctrl_csr_q_cntx_early_static_rd_ev;
    logic                                                             mem_ctrl_csr_q_cntx_static_wr_ev;
    logic                                                             mem_ctrl_csr_q_cntx_static_rd_ev;
    logic                                                             mem_ctrl_csr_q_cntx_buffer_static_wr_ev;
    logic                                                             mem_ctrl_csr_q_cntx_buffer_static_rd_ev;
    logic                                                             mem_ctrl_csr_q_cntx_first_pkt_wr_ev;
    logic                                                             mem_ctrl_csr_q_cntx_first_pkt_rd_ev;
    logic                                                             mem_ctrl_csr_q_cntx_buffer_first_pkt_wr_ev;
    logic                                                             mem_ctrl_csr_q_cntx_buffer_first_pkt_rd_ev;
    logic                                                             mem_ctrl_csr_q_cntx_ring_head_wr_ev;
    logic                                                             mem_ctrl_csr_q_cntx_ring_head_rd_ev;
    logic                                                             mem_ctrl_csr_q_cntx_early_static_wr_en_nxt;
    reg                                                               mem_ctrl_csr_q_cntx_early_static_wr_en_ff;
    logic                                                             mem_ctrl_csr_q_cntx_early_static_rd_en_nxt;
    reg                                                               mem_ctrl_csr_q_cntx_early_static_rd_en_ff;
    logic                                                             mem_ctrl_csr_q_cntx_static_wr_en_nxt;
    reg                                                               mem_ctrl_csr_q_cntx_static_wr_en_ff;
    logic                                                             mem_ctrl_csr_q_cntx_static_rd_en_nxt;
    reg                                                               mem_ctrl_csr_q_cntx_static_rd_en_ff;
    logic                                                             mem_ctrl_csr_q_cntx_buffer_static_wr_en_nxt;
    reg                                                               mem_ctrl_csr_q_cntx_buffer_static_wr_en_ff;
    logic                                                             mem_ctrl_csr_q_cntx_buffer_static_rd_en_nxt;
    reg                                                               mem_ctrl_csr_q_cntx_buffer_static_rd_en_ff;
    q_1st_pkt_mem_addr_t                                              mem_ctrl_csr_q_cntx_first_pkt_addr;
    q_1st_pkt_mem_bit_t                                               mem_ctrl_csr_q_cntx_first_pkt_bit;
    logic                                                             mem_ctrl_csr_q_cntx_first_pkt_wr_en;
    q_1st_pkt_mem_data_t                                              mem_ctrl_csr_q_cntx_first_pkt_wr_data;
    logic                                                             mem_ctrl_csr_q_cntx_first_pkt_rd_en_nxt;
    reg                                                               mem_ctrl_csr_q_cntx_first_pkt_rd_en_ff;
    q_1st_pkt_mem_data_t                                              mem_ctrl_csr_q_cntx_first_pkt_rd_data_sel;
    q_1st_pkt_mem_data_t                                              mem_ctrl_csr_q_cntx_first_pkt_rd_data_l_ff;
    buffq_1st_pkt_mem_addr_t                                          mem_ctrl_csr_q_cntx_buffer_first_pkt_addr;
    buffq_1st_pkt_mem_bit_t                                           mem_ctrl_csr_q_cntx_buffer_first_pkt_bit;
    logic                                                             mem_ctrl_csr_q_cntx_buffer_first_pkt_wr_en;
    buffq_1st_pkt_mem_data_t                                          mem_ctrl_csr_q_cntx_buffer_first_pkt_wr_data;
    logic                                                             mem_ctrl_csr_q_cntx_buffer_first_pkt_rd_en_nxt;
    reg                                                               mem_ctrl_csr_q_cntx_buffer_first_pkt_rd_en_ff;
    buffq_1st_pkt_mem_data_t                                          mem_ctrl_csr_q_cntx_buffer_first_pkt_rd_data_sel;
    buffq_1st_pkt_mem_data_t                                          mem_ctrl_csr_q_cntx_buffer_first_pkt_rd_data_l_ff;
    // QRX ring empty
    reg                                                               csr_ring_empty_wr_req_s_ff;
    q_ring_empty_mem_data_t                                           csr_ring_empty_wr_data_s_ff;
    reg                                                               csr_ring_empty_rd_req_s_ff;
    q_ring_empty_mem_addr_t                                           csr_ring_empty_idx_s_ff;
    logic                                                             csr_ring_empty_ack_nxt;
    reg                                                               csr_ring_empty_ack_ff;
    q_ring_empty_mem_data_t                                           csr_ring_empty_rd_data_nxt;
    q_ring_empty_mem_data_t                                           csr_ring_empty_rd_data_ff;
    reg                                                               csr_ring_empty_rd_req_sent_ff;
    logic                                                             csr_ring_empty_vld_l_nxt;
    reg                                                               csr_ring_empty_vld_l_ff;
    q_ring_empty_mem_data_t                                           csr_ring_empty_wr_data_l_nxt;
    q_ring_empty_mem_data_t                                           csr_ring_empty_wr_data_l_ff;
    q_ring_empty_mem_addr_t                                           csr_ring_empty_idx_l_nxt;
    q_ring_empty_mem_addr_t                                           csr_ring_empty_idx_l_ff;
    q_ring_empty_mem_data_t                                           csr_ring_empty_mem_wr_data;
    // CSR interface controls
    csr_cntx_access_ctrl_t                                            csr_cntx_access_ctrl_ff;
    // Event_q_cntx_req_fifo
    logic                                                             event_q_cntx_req_fifo_wr_vld;
    logic                                                             event_q_cntx_req_fifo_wr_en;
    lanpe_sl_package::lan_rx__rlan_rps_event_q_cntx_ftch_t            event_q_cntx_req_fifo_wr_data;
    logic                                                             event_q_cntx_req_fifo_wr_rdy;
    logic                                                             event_q_cntx_req_fifo_rd_en;
    lanpe_sl_package::lan_rx__rlan_rps_event_q_cntx_ftch_t            event_q_cntx_req_fifo_rd_data;
    logic                                                             event_q_cntx_req_fifo_rd_vld;
    // Event_q_cntx_rslt_fifo
    logic                                                             event_q_cntx_rslt_fifo_wr_en;
    lanpe_sl_package::lan_rps_rlan_event_q_cntxt_complt_t             event_q_cntx_rslt_fifo_wr_data;
    logic                                                             event_q_cntx_rslt_fifo_wr_rdy;
    logic                                                             event_q_cntx_rslt_fifo_rd_rdy;
    logic                                                             event_q_cntx_rslt_fifo_rd_en;
    lanpe_sl_package::lan_rps_rlan_event_q_cntxt_complt_t             event_q_cntx_rslt_fifo_rd_data;
    logic                                                             event_q_cntx_rslt_fifo_rd_vld;
    event_q_cntx_rslt_fifo_thr_t                                      event_q_cntx_rslt_fifo_used_space;
    logic                                                             event_q_cntx_rslt_fifo_below_thr;


    /////////////////////////////////
    // CSR CONTEXT INDIRECT ACCESS //
    /////////////////////////////////

    // CSR_CONTEXT_DATA

    always_ff @(posedge clk or negedge rst_n) begin
        if (~rst_n) begin
            csr_context_data_wr_req_s_ff  <= '0;
            csr_context_data_wr_data_s_ff <= '0;
            csr_context_data_rd_req_s_ff  <= '0;
            csr_context_data_idx_s_ff     <= '0;
        end
        else begin
            csr_context_data_wr_req_s_ff  <= io_csr_context_data_intf.wr_req;
            csr_context_data_wr_data_s_ff <= io_csr_context_data_intf.wr_data;
            csr_context_data_rd_req_s_ff  <= io_csr_context_data_intf.rd_req;
            csr_context_data_idx_s_ff     <= io_csr_context_data_intf.idx;
        end
    end

    assign csr_context_data_ack_nxt = csr_context_data_wr_req_s_ff | csr_context_data_rd_req_s_ff;

    always_comb begin
        csr_context_data_rd_data_nxt     = '1;
        if (csr_context_data_rd_req_s_ff & (csr_context_data_idx_s_ff < csr_cntx_data_idx_t'(Q_CNTX_STATIC_TABLE_DATA_WDT >> 5))) begin
            csr_context_data_rd_data_nxt = csr_context_table_nxt[(REG_DATA_WDT * csr_context_data_idx_s_ff) +: REG_DATA_WDT];
        end
    end

    always_ff @(posedge clk or negedge rst_n) begin
        if (~rst_n) begin
            csr_context_data_ack_ff     <= '0;
            csr_context_data_rd_data_ff <= '0;
        end
        else begin
            csr_context_data_ack_ff     <= csr_context_data_ack_nxt;
            csr_context_data_rd_data_ff <= csr_context_data_rd_data_nxt;
        end
    end

    assign io_csr_context_data_intf.ack     = csr_context_data_ack_ff;
    assign io_csr_context_data_intf.rd_data = csr_context_data_rd_data_ff;

    // CSR_CONTEXT_CTL

    always_ff @(posedge clk or negedge rst_n) begin
        if (~rst_n) begin
            csr_context_ctl_wr_req_s_ff  <= '0;
            csr_context_ctl_wr_data_s_ff <= '0;
            csr_context_ctl_rd_req_s_ff  <= '0;
        end
        else begin
            csr_context_ctl_wr_req_s_ff  <= io_csr_context_ctl_intf.wr_req;
            csr_context_ctl_wr_data_s_ff <= io_csr_context_ctl_intf.wr_data;
            csr_context_ctl_rd_req_s_ff  <= io_csr_context_ctl_intf.rd_req;
        end
    end

    assign csr_context_ctl_l_nxt = (csr_context_ctl_wr_req_s_ff) ? csr_context_ctl_wr_data_s_ff : csr_context_ctl_l_ff;

    always_ff @(posedge clk or negedge rst_n) begin
        if (~rst_n) begin
            csr_context_ctl_l_ff <= '0;
        end
        else begin
            csr_context_ctl_l_ff <= csr_context_ctl_l_nxt;
        end
    end

    assign csr_context_ctl_ack_nxt = csr_context_wr_req_wr_cmd_done | csr_context_wr_req_rd_cmd_done | csr_context_wr_req_nl_cmd_done | csr_context_ctl_rd_req_s_ff;

    always_ff @(posedge clk or negedge rst_n) begin
        if (~rst_n) begin
            csr_context_ctl_ack_ff    <= '0;
            csr_context_ctl_rd_vld_ff <= '0;
        end
        else begin
            csr_context_ctl_ack_ff    <= csr_context_ctl_ack_nxt;
            csr_context_ctl_rd_vld_ff <= csr_context_ctl_rd_req_s_ff;
        end
    end

    assign io_csr_context_ctl_intf.ack              = csr_context_ctl_ack_ff;
    assign io_csr_context_ctl_intf.rd_data.cmd_exec = '0;
    assign io_csr_context_ctl_intf.rd_data.cmd      = (csr_context_ctl_rd_vld_ff) ? csr_context_ctl_l_ff.cmd : csr_cntx_ctl_cmd_t'('0);
    assign io_csr_context_ctl_intf.rd_data.buff_q   = (csr_context_ctl_rd_vld_ff) ? csr_context_ctl_l_ff.buff_q : '0;
    assign io_csr_context_ctl_intf.rd_data.queue_id = (csr_context_ctl_rd_vld_ff) ? csr_context_ctl_l_ff.queue_id : '0;

    // CSR_CONTEXT_STAT

    always_ff @(posedge clk or negedge rst_n) begin
        if (~rst_n) begin
            csr_context_stat_wr_req_s_ff <= '0;
            csr_context_stat_rd_req_s_ff <= '0;
        end
        else begin
            csr_context_stat_wr_req_s_ff <= io_csr_context_stat_intf.wr_req;
            csr_context_stat_rd_req_s_ff <= io_csr_context_stat_intf.rd_req;
        end
    end

    assign csr_context_stat_ack_nxt     = csr_context_stat_wr_req_s_ff | csr_context_stat_rd_req_s_ff;
    assign csr_context_stat_rd_data_nxt = (csr_context_stat_rd_req_s_ff) ? csr_context_wr_req_rd_cmd_active_ff : '0;

    always_ff @(posedge clk or negedge rst_n) begin
        if (~rst_n) begin
            csr_context_stat_ack_ff     <= '0;
            csr_context_stat_rd_data_ff <= '0;
        end
        else begin
            csr_context_stat_ack_ff     <= csr_context_stat_ack_nxt;
            csr_context_stat_rd_data_ff <= csr_context_stat_rd_data_nxt;
        end
    end

    assign io_csr_context_stat_intf.ack     = csr_context_stat_ack_ff;
    assign io_csr_context_stat_intf.rd_data = csr_context_stat_rd_data_ff;

    // QRX CONTEXT TABLE

    always_comb begin
        csr_context_table_nxt = csr_context_table_ff;
        if (csr_context_data_wr_req_s_ff & (csr_context_data_idx_s_ff < csr_cntx_data_idx_t'(Q_CNTX_STATIC_TABLE_DATA_WDT >> 5))) begin
            csr_context_table_nxt[(REG_DATA_WDT * csr_context_data_idx_s_ff) +: REG_DATA_WDT]= csr_context_data_wr_data_s_ff;
        end
        else if (csr_context_wr_req_rd_cmd_active_ff & (~csr_context_ctl_l_ff.buff_q)) begin
            csr_context_table_nxt = csr_context_table_from_static_mem;
        end
        else if (csr_context_wr_req_rd_cmd_active_ff & csr_context_ctl_l_ff.buff_q) begin
            csr_context_table_nxt = csr_context_table_from_buffer_static_mem;
        end
    end

    always_ff @(posedge clk or negedge rst_n) begin
        if (~rst_n) begin
            csr_context_table_ff <= '0;
        end
        else begin
            csr_context_table_ff <= csr_context_table_nxt;
        end
    end

    // QRX CONTEXT MEMORY ACCESS

    assign csr_context_wr_req_wr_cmd_start = csr_context_ctl_wr_req_s_ff & csr_context_ctl_wr_data_s_ff.cmd_exec & (csr_context_ctl_wr_data_s_ff.cmd != CNTX_CTL_READ);
    assign csr_context_wr_req_rd_cmd_start = csr_context_ctl_wr_req_s_ff & csr_context_ctl_wr_data_s_ff.cmd_exec & (csr_context_ctl_wr_data_s_ff.cmd == CNTX_CTL_READ);
    assign csr_context_wr_req_init_en      = csr_context_ctl_wr_req_s_ff & csr_context_ctl_wr_data_s_ff.cmd_exec &
                                             ((csr_context_ctl_wr_data_s_ff.cmd == CNTX_CTL_WRITE_MIGR_INIT) | (csr_context_ctl_wr_data_s_ff.cmd == CNTX_CTL_WRITE_FULL_INIT));
    assign csr_context_wr_req_init_vm_mig  = csr_context_wr_req_init_en & (csr_context_ctl_wr_data_s_ff.cmd == CNTX_CTL_WRITE_MIGR_INIT);

    // Mem ctrl events
    assign mem_ctrl_csr_q_cntx_early_static_wr_ev     = io_mem_ctrl_csr_q_cntx_early_static_intf.wr_en & io_mem_ctrl_csr_q_cntx_early_static_intf.rdy;
    assign mem_ctrl_csr_q_cntx_early_static_rd_ev     = io_mem_ctrl_csr_q_cntx_early_static_intf.rd_en & io_mem_ctrl_csr_q_cntx_early_static_intf.rdy;
    assign mem_ctrl_csr_q_cntx_static_wr_ev           = io_mem_ctrl_csr_q_cntx_static_intf.wr_en & io_mem_ctrl_csr_q_cntx_static_intf.rdy;
    assign mem_ctrl_csr_q_cntx_static_rd_ev           = io_mem_ctrl_csr_q_cntx_static_intf.rd_en & io_mem_ctrl_csr_q_cntx_static_intf.rdy;
    assign mem_ctrl_csr_q_cntx_buffer_static_wr_ev    = io_mem_ctrl_csr_q_cntx_buffer_static_intf.wr_en & io_mem_ctrl_csr_q_cntx_buffer_static_intf.rdy;
    assign mem_ctrl_csr_q_cntx_buffer_static_rd_ev    = io_mem_ctrl_csr_q_cntx_buffer_static_intf.rd_en & io_mem_ctrl_csr_q_cntx_buffer_static_intf.rdy;
    assign mem_ctrl_csr_q_cntx_first_pkt_wr_ev        = io_mem_ctrl_csr_q_cntx_first_pkt_intf.wr_en & io_mem_ctrl_csr_q_cntx_first_pkt_intf.wr_rdy;
    assign mem_ctrl_csr_q_cntx_first_pkt_rd_ev        = io_mem_ctrl_csr_q_cntx_first_pkt_intf.rd_en & io_mem_ctrl_csr_q_cntx_first_pkt_intf.rd_rdy;
    assign mem_ctrl_csr_q_cntx_buffer_first_pkt_wr_ev = io_mem_ctrl_csr_q_cntx_buffer_first_pkt_intf.wr_en & io_mem_ctrl_csr_q_cntx_buffer_first_pkt_intf.wr_rdy;
    assign mem_ctrl_csr_q_cntx_buffer_first_pkt_rd_ev = io_mem_ctrl_csr_q_cntx_buffer_first_pkt_intf.rd_en & io_mem_ctrl_csr_q_cntx_buffer_first_pkt_intf.rd_rdy;
    assign mem_ctrl_csr_q_cntx_ring_head_wr_ev        = io_mem_ctrl_csr_q_cntx_ring_head_intf.wr_en & io_mem_ctrl_csr_q_cntx_ring_head_intf.wr_rdy;
    assign mem_ctrl_csr_q_cntx_ring_head_rd_ev        = io_mem_ctrl_csr_q_cntx_ring_head_intf.rd_en & io_mem_ctrl_csr_q_cntx_ring_head_intf.rd_rdy;

    assign mem_ctrl_csr_q_cntx_early_static_wr_en_nxt  = (csr_context_wr_req_wr_cmd_start & (~csr_context_ctl_wr_data_s_ff.buff_q)) ? '1 :
                                                         (mem_ctrl_csr_q_cntx_early_static_wr_ev) ? '0 : mem_ctrl_csr_q_cntx_early_static_wr_en_ff;
    assign mem_ctrl_csr_q_cntx_early_static_rd_en_nxt  = (csr_context_wr_req_rd_cmd_start & (~csr_context_ctl_wr_data_s_ff.buff_q)) ? '1 :
                                                         (mem_ctrl_csr_q_cntx_early_static_rd_ev) ? '0 : mem_ctrl_csr_q_cntx_early_static_rd_en_ff;
    assign mem_ctrl_csr_q_cntx_static_wr_en_nxt        = (csr_context_wr_req_wr_cmd_start & (~csr_context_ctl_wr_data_s_ff.buff_q)) ? '1 :
                                                         (mem_ctrl_csr_q_cntx_static_wr_ev) ? '0 : mem_ctrl_csr_q_cntx_static_wr_en_ff;
    assign mem_ctrl_csr_q_cntx_static_rd_en_nxt        = (csr_context_wr_req_rd_cmd_start & (~csr_context_ctl_wr_data_s_ff.buff_q)) ? '1 :
                                                         (mem_ctrl_csr_q_cntx_static_rd_ev) ? '0 : mem_ctrl_csr_q_cntx_static_rd_en_ff;
    assign mem_ctrl_csr_q_cntx_buffer_static_wr_en_nxt = (csr_context_wr_req_wr_cmd_start & csr_context_ctl_wr_data_s_ff.buff_q) ? '1 :
                                                         (mem_ctrl_csr_q_cntx_buffer_static_wr_ev) ? '0 : mem_ctrl_csr_q_cntx_buffer_static_wr_en_ff;
    assign mem_ctrl_csr_q_cntx_buffer_static_rd_en_nxt = (csr_context_wr_req_rd_cmd_start & csr_context_ctl_wr_data_s_ff.buff_q) ? '1 :
                                                         (mem_ctrl_csr_q_cntx_buffer_static_rd_ev) ? '0 : mem_ctrl_csr_q_cntx_buffer_static_rd_en_ff;

    always_ff @(posedge clk or negedge rst_n) begin
        if (~rst_n) begin
            mem_ctrl_csr_q_cntx_early_static_wr_en_ff  <= '0;
            mem_ctrl_csr_q_cntx_early_static_rd_en_ff  <= '0;
            mem_ctrl_csr_q_cntx_static_wr_en_ff        <= '0;
            mem_ctrl_csr_q_cntx_static_rd_en_ff        <= '0;
            mem_ctrl_csr_q_cntx_buffer_static_wr_en_ff <= '0;
            mem_ctrl_csr_q_cntx_buffer_static_rd_en_ff <= '0;
        end
        else begin
            mem_ctrl_csr_q_cntx_early_static_wr_en_ff  <= mem_ctrl_csr_q_cntx_early_static_wr_en_nxt;
            mem_ctrl_csr_q_cntx_early_static_rd_en_ff  <= mem_ctrl_csr_q_cntx_early_static_rd_en_nxt;
            mem_ctrl_csr_q_cntx_static_wr_en_ff        <= mem_ctrl_csr_q_cntx_static_wr_en_nxt;
            mem_ctrl_csr_q_cntx_static_rd_en_ff        <= mem_ctrl_csr_q_cntx_static_rd_en_nxt;
            mem_ctrl_csr_q_cntx_buffer_static_wr_en_ff <= mem_ctrl_csr_q_cntx_buffer_static_wr_en_nxt;
            mem_ctrl_csr_q_cntx_buffer_static_rd_en_ff <= mem_ctrl_csr_q_cntx_buffer_static_rd_en_nxt;
        end
    end

    assign csr_context_wr_req_wr_cmd_done           = (csr_context_wr_req_init_active_ff | csr_context_wr_req_wr_cmd_active_ff) & (~csr_context_wr_req_init_active_nxt) & (~csr_context_wr_req_wr_cmd_active_nxt);
    assign csr_context_wr_req_rd_cmd_done           = csr_context_wr_req_rd_cmd_active_ff & (csr_context_wr_req_waiting_rd_vld_ff == '0);
    assign csr_context_wr_req_nl_cmd_done           = csr_context_ctl_wr_req_s_ff & (~csr_context_ctl_wr_data_s_ff.cmd_exec);

    assign csr_context_wr_req_waiting_wr_rdy_nxt[0] = (mem_ctrl_csr_q_cntx_early_static_wr_ev) ? '0 : (csr_context_wr_req_wr_cmd_start & (~csr_context_ctl_wr_data_s_ff.buff_q)) ? '1 : csr_context_wr_req_waiting_wr_rdy_ff[0];
    assign csr_context_wr_req_waiting_wr_rdy_nxt[1] = (mem_ctrl_csr_q_cntx_static_wr_ev) ? '0 : (csr_context_wr_req_wr_cmd_start & (~csr_context_ctl_wr_data_s_ff.buff_q)) ? '1 : csr_context_wr_req_waiting_wr_rdy_ff[1];
    assign csr_context_wr_req_waiting_wr_rdy_nxt[2] = (mem_ctrl_csr_q_cntx_buffer_static_wr_ev) ? '0 : (csr_context_wr_req_wr_cmd_start & csr_context_ctl_wr_data_s_ff.buff_q) ? '1 : csr_context_wr_req_waiting_wr_rdy_ff[2];

    assign csr_context_wr_req_waiting_rd_vld_nxt[0] = (io_mem_ctrl_csr_q_cntx_early_static_intf.rd_vld) ? '0 : (csr_context_wr_req_rd_cmd_start & (~csr_context_ctl_wr_data_s_ff.buff_q)) ? '1 : csr_context_wr_req_waiting_rd_vld_ff[0];
    assign csr_context_wr_req_waiting_rd_vld_nxt[1] = (io_mem_ctrl_csr_q_cntx_static_intf.rd_vld) ? '0 : (csr_context_wr_req_rd_cmd_start & (~csr_context_ctl_wr_data_s_ff.buff_q)) ? '1 : csr_context_wr_req_waiting_rd_vld_ff[1];
    assign csr_context_wr_req_waiting_rd_vld_nxt[2] = (io_mem_ctrl_csr_q_cntx_buffer_static_intf.rd_vld) ? '0 : (csr_context_wr_req_rd_cmd_start & csr_context_ctl_wr_data_s_ff.buff_q) ? '1 : csr_context_wr_req_waiting_rd_vld_ff[2];

    assign csr_context_wr_req_wr_cmd_active_nxt     = (csr_context_wr_req_wr_cmd_start) ? '1 : (csr_context_wr_req_waiting_wr_rdy_ff == '0) ? '0 : csr_context_wr_req_wr_cmd_active_ff;
    assign csr_context_wr_req_rd_cmd_active_nxt     = (csr_context_wr_req_rd_cmd_start) ? '1 : (csr_context_wr_req_waiting_rd_vld_ff == '0) ? '0 : csr_context_wr_req_rd_cmd_active_ff;
    assign csr_context_wr_req_init_active_nxt       = (csr_context_wr_req_wr_cmd_start & csr_context_wr_req_init_en) ? '1 :
                                                      (csr_context_wr_req_init_stage_sel & (mem_ctrl_csr_q_cntx_first_pkt_wr_ev | mem_ctrl_csr_q_cntx_buffer_first_pkt_wr_ev)) ? '0 : csr_context_wr_req_init_active_ff;
    assign csr_context_wr_req_init_stage_sel        = (csr_context_wr_req_wr_cmd_start & csr_context_wr_req_init_en) ? '0 :
                                                      (io_mem_ctrl_csr_q_cntx_first_pkt_intf.rd_vld | io_mem_ctrl_csr_q_cntx_buffer_first_pkt_intf.rd_vld) ? '1 : csr_context_wr_req_init_stage_ff;
    assign csr_context_wr_req_init_vm_mig_nxt       = (csr_context_wr_req_wr_cmd_start & csr_context_wr_req_init_en & csr_context_wr_req_init_vm_mig) ? '1 :
                                                      (csr_context_wr_req_init_stage_sel & (mem_ctrl_csr_q_cntx_first_pkt_wr_ev | mem_ctrl_csr_q_cntx_buffer_first_pkt_wr_ev)) ? '0 : csr_context_wr_req_init_vm_mig_ff;

    always_ff @(posedge clk or negedge rst_n) begin
        if (~rst_n) begin
            csr_context_wr_req_waiting_wr_rdy_ff <= '0;
            csr_context_wr_req_waiting_rd_vld_ff <= '0;
            csr_context_wr_req_wr_cmd_active_ff  <= '0;
            csr_context_wr_req_rd_cmd_active_ff  <= '0;
            csr_context_wr_req_init_active_ff    <= '0;
            csr_context_wr_req_init_stage_ff     <= '0;
            csr_context_wr_req_init_vm_mig_ff    <= '0;
        end
        else begin
            csr_context_wr_req_waiting_wr_rdy_ff <= csr_context_wr_req_waiting_wr_rdy_nxt;
            csr_context_wr_req_waiting_rd_vld_ff <= csr_context_wr_req_waiting_rd_vld_nxt;
            csr_context_wr_req_wr_cmd_active_ff  <= csr_context_wr_req_wr_cmd_active_nxt;
            csr_context_wr_req_rd_cmd_active_ff  <= csr_context_wr_req_rd_cmd_active_nxt;
            csr_context_wr_req_init_active_ff    <= csr_context_wr_req_init_active_nxt;
            csr_context_wr_req_init_stage_ff     <= csr_context_wr_req_init_stage_sel;
            csr_context_wr_req_init_vm_mig_ff    <= csr_context_wr_req_init_vm_mig_nxt;
        end
    end

    assign io_mem_ctrl_csr_q_cntx_early_static_intf.wr_en    = mem_ctrl_csr_q_cntx_early_static_wr_en_ff;
    assign io_mem_ctrl_csr_q_cntx_early_static_intf.wr_data  = csr_context_table_to_early_static_mem;
    assign io_mem_ctrl_csr_q_cntx_early_static_intf.rd_en    = mem_ctrl_csr_q_cntx_early_static_rd_en_ff;
    assign io_mem_ctrl_csr_q_cntx_early_static_intf.addr     = (mem_ctrl_csr_q_cntx_early_static_wr_en_ff | mem_ctrl_csr_q_cntx_early_static_rd_en_ff) ? q_cntx_early_mem_addr_t'(csr_context_ctl_l_ff.queue_id) : '0;

    assign io_mem_ctrl_csr_q_cntx_static_intf.wr_en          = mem_ctrl_csr_q_cntx_static_wr_en_ff | mem_ctrl_csr_cq_cntx_static_wr_en_ff;
    assign io_mem_ctrl_csr_q_cntx_static_intf.wr_data        = (mem_ctrl_csr_q_cntx_static_wr_en_ff) ? csr_context_table_to_static_mem : (mem_ctrl_csr_cq_cntx_static_wr_en_ff) ? csr_cq_context_table_ff : '0;
    assign io_mem_ctrl_csr_q_cntx_static_intf.rd_en          = mem_ctrl_csr_q_cntx_static_rd_en_ff | mem_ctrl_csr_cq_cntx_static_rd_en_ff;
    assign io_mem_ctrl_csr_q_cntx_static_intf.addr           = (mem_ctrl_csr_q_cntx_static_wr_en_ff | mem_ctrl_csr_q_cntx_static_rd_en_ff) ? q_cntx_mem_addr_t'(csr_context_ctl_l_ff.queue_id) :
                                                               (mem_ctrl_csr_cq_cntx_static_wr_en_ff | mem_ctrl_csr_cq_cntx_static_rd_en_ff) ? csr_cq_idx_l_ff : '0;

    assign io_mem_ctrl_csr_q_cntx_buffer_static_intf.wr_en   = mem_ctrl_csr_q_cntx_buffer_static_wr_en_ff;
    assign io_mem_ctrl_csr_q_cntx_buffer_static_intf.wr_data = csr_context_table_to_buffer_static_mem;
    assign io_mem_ctrl_csr_q_cntx_buffer_static_intf.rd_en   = mem_ctrl_csr_q_cntx_buffer_static_rd_en_ff;
    assign io_mem_ctrl_csr_q_cntx_buffer_static_intf.addr    = csr_context_ctl_l_ff.queue_id;

    always_comb begin
        csr_context_table_from_static_mem                          = csr_context_table_ff;
        if (io_mem_ctrl_csr_q_cntx_static_intf.rd_vld) begin
            csr_context_table_from_static_mem.ipf_divert_report_pf = io_mem_ctrl_csr_q_cntx_static_intf.rd_data.report_pf;
            csr_context_table_from_static_mem.var_buff_size_mode   = io_mem_ctrl_csr_q_cntx_static_intf.rd_data.var_buff_size_mode;
            csr_context_table_from_static_mem.func_mal_policy      = io_mem_ctrl_csr_q_cntx_static_intf.rd_data.func_mal_policy;
            csr_context_table_from_static_mem.hostoff_func_num     = io_mem_ctrl_csr_q_cntx_static_intf.rd_data.hostoff_func_num;
            csr_context_table_from_static_mem.hostoff_func_type    = io_mem_ctrl_csr_q_cntx_static_intf.rd_data.hostoff_func_type;
            csr_context_table_from_static_mem.hostoff_pf_num       = io_mem_ctrl_csr_q_cntx_static_intf.rd_data.hostoff_pf_num;
            csr_context_table_from_static_mem.hostoff_home         = io_mem_ctrl_csr_q_cntx_static_intf.rd_data.hostoff_home;
            csr_context_table_from_static_mem.hostoff_pasid_valid  = io_mem_ctrl_csr_q_cntx_static_intf.rd_data.hostoff_pasid_valid;
            csr_context_table_from_static_mem.hostoff_pasid        = io_mem_ctrl_csr_q_cntx_static_intf.rd_data.hostoff_pasid;
            csr_context_table_from_static_mem.hsplit_pasid_select  = io_mem_ctrl_csr_q_cntx_static_intf.rd_data.hsplit_pasid_select;
            csr_context_table_from_static_mem.data_pasid           = io_mem_ctrl_csr_q_cntx_static_intf.rd_data.data_pasid;
            csr_context_table_from_static_mem.data_pasid_valid     = io_mem_ctrl_csr_q_cntx_static_intf.rd_data.data_pasid_valid;
            csr_context_table_from_static_mem.desc_pasid_valid     = io_mem_ctrl_csr_q_cntx_static_intf.rd_data.desc_pasid_valid;
            csr_context_table_from_static_mem.desc_pasid           = io_mem_ctrl_csr_q_cntx_static_intf.rd_data.desc_pasid;
            csr_context_table_from_static_mem.flex_field4_decode   = io_mem_ctrl_csr_q_cntx_static_intf.rd_data.flex_field4_decode;
            csr_context_table_from_static_mem.flex_field3_decode   = io_mem_ctrl_csr_q_cntx_static_intf.rd_data.flex_field3_decode;
            csr_context_table_from_static_mem.flex_field2_decode   = io_mem_ctrl_csr_q_cntx_static_intf.rd_data.flex_field2_decode;
            csr_context_table_from_static_mem.flex_field1_decode   = io_mem_ctrl_csr_q_cntx_static_intf.rd_data.flex_field1_decode;
            csr_context_table_from_static_mem.no_expire            = io_mem_ctrl_csr_q_cntx_static_intf.rd_data.no_expire;
            csr_context_table_from_static_mem.tph_hwb_en           = io_mem_ctrl_csr_q_cntx_static_intf.rd_data.tph_hwb_en;
            csr_context_table_from_static_mem.tph_hdr_en           = io_mem_ctrl_csr_q_cntx_static_intf.rd_data.tph_hdr_en;
            csr_context_table_from_static_mem.tph_data_en          = io_mem_ctrl_csr_q_cntx_static_intf.rd_data.tph_data_en;
            csr_context_table_from_static_mem.tph_wr_desc_en       = io_mem_ctrl_csr_q_cntx_static_intf.rd_data.tph_wr_desc_en;
            csr_context_table_from_static_mem.tph_rd_desc_en       = io_mem_ctrl_csr_q_cntx_static_intf.rd_data.tph_rd_desc_en;
            csr_context_table_from_static_mem.p2p_tx_q_idx         = io_mem_ctrl_csr_q_cntx_static_intf.rd_data.p2p_tx_q_idx;
            csr_context_table_from_static_mem.pref_en              = io_mem_ctrl_csr_q_cntx_static_intf.rd_data.pref_en;
            csr_context_table_from_static_mem.low_rx_q_thr         = io_mem_ctrl_csr_q_cntx_static_intf.rd_data.low_rx_q_thr;
            csr_context_table_from_static_mem.rx_q_len             = io_mem_ctrl_csr_q_cntx_static_intf.rd_data.rx_q_len;
            csr_context_table_from_static_mem.base_high            = io_mem_ctrl_csr_q_cntx_static_intf.rd_data.base_high;
            csr_context_table_from_static_mem.base_low             = io_mem_ctrl_csr_q_cntx_static_intf.rd_data.base_low;
            csr_context_table_from_static_mem.queue_type           = io_mem_ctrl_csr_q_cntx_static_intf.rd_data.queue_type;
            csr_context_table_from_static_mem.rd_dsize             = io_mem_ctrl_csr_q_cntx_static_intf.rd_data.rd_dsize;
            csr_context_table_from_static_mem.wr_dsize             = io_mem_ctrl_csr_q_cntx_static_intf.rd_data.wr_dsize;
        end
        if (io_mem_ctrl_csr_q_cntx_early_static_intf.rd_vld) begin
            csr_context_table_from_static_mem.gen_sep_dbl          = io_mem_ctrl_csr_q_cntx_early_static_intf.rd_data.gen_sep_dbl;
            csr_context_table_from_static_mem.send_addr_in_comp    = io_mem_ctrl_csr_q_cntx_early_static_intf.rd_data.send_addr_in_comp;
            csr_context_table_from_static_mem.wb_aggr_size         = io_mem_ctrl_csr_q_cntx_early_static_intf.rd_data.wb_aggr_size;
            csr_context_table_from_static_mem.requestor_id         = io_mem_ctrl_csr_q_cntx_early_static_intf.rd_data.requestor_id;
            csr_context_table_from_static_mem.rxdid_recipe_idx     = io_mem_ctrl_csr_q_cntx_early_static_intf.rd_data.rxdid_recipe_idx;
            csr_context_table_from_static_mem.rxdid_override       = io_mem_ctrl_csr_q_cntx_early_static_intf.rd_data.rxdid_override;
            csr_context_table_from_static_mem.shift_units_num      = io_mem_ctrl_csr_q_cntx_early_static_intf.rd_data.shift_units_num;
            csr_context_table_from_static_mem.shift_pkt_mode       = io_mem_ctrl_csr_q_cntx_early_static_intf.rd_data.shift_pkt_mode;
            csr_context_table_from_static_mem.hostoff_home         = io_mem_ctrl_csr_q_cntx_early_static_intf.rd_data.hostoff_home;
            csr_context_table_from_static_mem.rsc_q_context        = io_mem_ctrl_csr_q_cntx_early_static_intf.rd_data.rsc_q_context;
            csr_context_table_from_static_mem.buffer_q1_en         = io_mem_ctrl_csr_q_cntx_early_static_intf.rd_data.buffer_q1_en;
            csr_context_table_from_static_mem.buffer_q1_index      = io_mem_ctrl_csr_q_cntx_early_static_intf.rd_data.buffer_q1_index;
            csr_context_table_from_static_mem.buffer_q0_index      = io_mem_ctrl_csr_q_cntx_early_static_intf.rd_data.buffer_q0_index;
            csr_context_table_from_static_mem.rx_max_pkt_sz        = io_mem_ctrl_csr_q_cntx_early_static_intf.rd_data.rx_max_pkt_sz;
            csr_context_table_from_static_mem.strip_crc            = io_mem_ctrl_csr_q_cntx_early_static_intf.rd_data.strip_crc;
            csr_context_table_from_static_mem.hbuff                = io_mem_ctrl_csr_q_cntx_early_static_intf.rd_data.hbuff;
            csr_context_table_from_static_mem.buffer_q1_dbuff      = io_mem_ctrl_csr_q_cntx_early_static_intf.rd_data.buffer_q1_dbuff;
            csr_context_table_from_static_mem.dbuff                = io_mem_ctrl_csr_q_cntx_early_static_intf.rd_data.dbuff;
            csr_context_table_from_static_mem.dtype                = io_mem_ctrl_csr_q_cntx_early_static_intf.rd_data.dtype;
            csr_context_table_from_static_mem.queue_model          = io_mem_ctrl_csr_q_cntx_early_static_intf.rd_data.queue_model;
        end
    end

    always_comb begin
        csr_context_table_from_buffer_static_mem                     = csr_context_table_ff;
        if (io_mem_ctrl_csr_q_cntx_buffer_static_intf.rd_vld) begin
            csr_context_table_from_buffer_static_mem.head_wb_addr    = io_mem_ctrl_csr_q_cntx_buffer_static_intf.rd_data.head_wb_addr;
            csr_context_table_from_buffer_static_mem.buff_ntf_dis    = io_mem_ctrl_csr_q_cntx_buffer_static_intf.rd_data.buff_ntf_dis;
            csr_context_table_from_buffer_static_mem.buff_ntf_stride = io_mem_ctrl_csr_q_cntx_buffer_static_intf.rd_data.buff_ntf_stride;
            csr_context_table_from_buffer_static_mem.tph_hwb_en      = io_mem_ctrl_csr_q_cntx_buffer_static_intf.rd_data.tph_hwb_en;
            csr_context_table_from_buffer_static_mem.tph_hdr_en      = io_mem_ctrl_csr_q_cntx_buffer_static_intf.rd_data.tph_hdr_en;
            csr_context_table_from_buffer_static_mem.tph_data_en     = io_mem_ctrl_csr_q_cntx_buffer_static_intf.rd_data.tph_data_en;
            csr_context_table_from_buffer_static_mem.tph_wr_desc_en  = io_mem_ctrl_csr_q_cntx_buffer_static_intf.rd_data.tph_wr_desc_en;
            csr_context_table_from_buffer_static_mem.tph_rd_desc_en  = io_mem_ctrl_csr_q_cntx_buffer_static_intf.rd_data.tph_rd_desc_en;
            csr_context_table_from_buffer_static_mem.pref_en         = io_mem_ctrl_csr_q_cntx_buffer_static_intf.rd_data.pref_en;
            csr_context_table_from_buffer_static_mem.low_rx_q_thr    = io_mem_ctrl_csr_q_cntx_buffer_static_intf.rd_data.low_rx_q_thr;
            csr_context_table_from_buffer_static_mem.rx_q_len        = io_mem_ctrl_csr_q_cntx_buffer_static_intf.rd_data.rx_q_len;
            csr_context_table_from_buffer_static_mem.base_high       = io_mem_ctrl_csr_q_cntx_buffer_static_intf.rd_data.base_high;
            csr_context_table_from_buffer_static_mem.base_low        = io_mem_ctrl_csr_q_cntx_buffer_static_intf.rd_data.base_low;
        end
    end

    always_comb begin
        csr_context_table_to_early_static_mem.reserved               = '0;
        csr_context_table_to_early_static_mem.gen_sep_dbl            = csr_context_table_ff.gen_sep_dbl;
        csr_context_table_to_early_static_mem.send_addr_in_comp      = csr_context_table_ff.send_addr_in_comp;
        csr_context_table_to_early_static_mem.ipf_divert_mode        = csr_context_table_ff.ipf_divert_report_pf;
        csr_context_table_to_early_static_mem.wb_aggr_size           = csr_context_table_ff.wb_aggr_size;
        csr_context_table_to_early_static_mem.requestor_id           = csr_context_table_ff.requestor_id;
        csr_context_table_to_early_static_mem.rxdid_recipe_idx       = csr_context_table_ff.rxdid_recipe_idx;
        csr_context_table_to_early_static_mem.rxdid_override         = csr_context_table_ff.rxdid_override;
        csr_context_table_to_early_static_mem.shift_units_num        = csr_context_table_ff.shift_units_num;
        csr_context_table_to_early_static_mem.shift_pkt_mode         = csr_context_table_ff.shift_pkt_mode;
        csr_context_table_to_early_static_mem.hostoff_home           = csr_context_table_ff.hostoff_home;
        csr_context_table_to_early_static_mem.rsc_q_context          = csr_context_table_ff.rsc_q_context;
        csr_context_table_to_early_static_mem.buffer_q1_en           = csr_context_table_ff.buffer_q1_en;
        csr_context_table_to_early_static_mem.buffer_q1_index        = csr_context_table_ff.buffer_q1_index;
        csr_context_table_to_early_static_mem.buffer_q0_index        = csr_context_table_ff.buffer_q0_index;
        csr_context_table_to_early_static_mem.rx_max_pkt_sz          = csr_context_table_ff.rx_max_pkt_sz;
        csr_context_table_to_early_static_mem.strip_crc              = csr_context_table_ff.strip_crc;
        csr_context_table_to_early_static_mem.hbuff                  = csr_context_table_ff.hbuff;
        csr_context_table_to_early_static_mem.buffer_q1_dbuff        = csr_context_table_ff.buffer_q1_dbuff;
        csr_context_table_to_early_static_mem.dbuff                  = csr_context_table_ff.dbuff;
        csr_context_table_to_early_static_mem.dtype                  = csr_context_table_ff.dtype;
        csr_context_table_to_early_static_mem.queue_type             = csr_context_table_ff.queue_type;
        csr_context_table_to_early_static_mem.queue_model            = csr_context_table_ff.queue_model;
    end

    always_comb begin
        csr_context_table_to_static_mem.reserved                     = '0;
        csr_context_table_to_static_mem.gen_sep_dbl                  = csr_context_table_ff.gen_sep_dbl;
        csr_context_table_to_static_mem.report_pf                    = csr_context_table_ff.ipf_divert_report_pf;
        csr_context_table_to_static_mem.wb_aggr_size                 = csr_context_table_ff.wb_aggr_size;
        csr_context_table_to_static_mem.requestor_id                 = csr_context_table_ff.requestor_id;
        csr_context_table_to_static_mem.var_buff_size_mode           = csr_context_table_ff.var_buff_size_mode;
        csr_context_table_to_static_mem.func_mal_policy              = csr_context_table_ff.func_mal_policy;
        csr_context_table_to_static_mem.hostoff_func_num             = csr_context_table_ff.hostoff_func_num;
        csr_context_table_to_static_mem.hostoff_func_type            = csr_context_table_ff.hostoff_func_type;
        csr_context_table_to_static_mem.hostoff_pf_num               = csr_context_table_ff.hostoff_pf_num;
        csr_context_table_to_static_mem.hostoff_home                 = csr_context_table_ff.hostoff_home;
        csr_context_table_to_static_mem.hostoff_pasid_valid          = csr_context_table_ff.hostoff_pasid_valid;
        csr_context_table_to_static_mem.hostoff_pasid                = csr_context_table_ff.hostoff_pasid;
        csr_context_table_to_static_mem.hsplit_pasid_select          = csr_context_table_ff.hsplit_pasid_select;
        csr_context_table_to_static_mem.data_pasid                   = csr_context_table_ff.data_pasid;
        csr_context_table_to_static_mem.data_pasid_valid             = csr_context_table_ff.data_pasid_valid;
        csr_context_table_to_static_mem.desc_pasid_valid             = csr_context_table_ff.desc_pasid_valid;
        csr_context_table_to_static_mem.desc_pasid                   = csr_context_table_ff.desc_pasid;
        csr_context_table_to_static_mem.flex_field4_decode           = csr_context_table_ff.flex_field4_decode;
        csr_context_table_to_static_mem.flex_field3_decode           = csr_context_table_ff.flex_field3_decode;
        csr_context_table_to_static_mem.flex_field2_decode           = csr_context_table_ff.flex_field2_decode;
        csr_context_table_to_static_mem.flex_field1_decode           = csr_context_table_ff.flex_field1_decode;
        csr_context_table_to_static_mem.no_expire                    = csr_context_table_ff.no_expire;
        csr_context_table_to_static_mem.tph_hwb_en                   = csr_context_table_ff.tph_hwb_en;
        csr_context_table_to_static_mem.tph_hdr_en                   = csr_context_table_ff.tph_hdr_en;
        csr_context_table_to_static_mem.tph_data_en                  = csr_context_table_ff.tph_data_en;
        csr_context_table_to_static_mem.tph_wr_desc_en               = csr_context_table_ff.tph_wr_desc_en;
        csr_context_table_to_static_mem.tph_rd_desc_en               = csr_context_table_ff.tph_rd_desc_en;
        csr_context_table_to_static_mem.p2p_tx_q_idx                 = csr_context_table_ff.p2p_tx_q_idx;
        csr_context_table_to_static_mem.pref_en                      = csr_context_table_ff.pref_en;
        csr_context_table_to_static_mem.low_rx_q_thr                 = csr_context_table_ff.low_rx_q_thr;
        csr_context_table_to_static_mem.rx_q_len                     = csr_context_table_ff.rx_q_len;
        csr_context_table_to_static_mem.base_high                    = csr_context_table_ff.base_high;
        csr_context_table_to_static_mem.base_low                     = csr_context_table_ff.base_low;
        csr_context_table_to_static_mem.queue_type                   = csr_context_table_ff.queue_type;
        csr_context_table_to_static_mem.rd_dsize                     = csr_context_table_ff.rd_dsize;
        csr_context_table_to_static_mem.wr_dsize                     = csr_context_table_ff.wr_dsize;
    end

    always_comb begin
        csr_context_table_to_buffer_static_mem.reserved        = '0;
        csr_context_table_to_buffer_static_mem.head_wb_addr    = csr_context_table_ff.head_wb_addr;
        csr_context_table_to_buffer_static_mem.buff_ntf_dis    = csr_context_table_ff.buff_ntf_dis;
        csr_context_table_to_buffer_static_mem.buff_ntf_stride = csr_context_table_ff.buff_ntf_stride;
        csr_context_table_to_buffer_static_mem.tph_hwb_en      = csr_context_table_ff.tph_hwb_en;
        csr_context_table_to_buffer_static_mem.tph_hdr_en      = csr_context_table_ff.tph_hdr_en;
        csr_context_table_to_buffer_static_mem.tph_data_en     = csr_context_table_ff.tph_data_en;
        csr_context_table_to_buffer_static_mem.tph_wr_desc_en  = csr_context_table_ff.tph_wr_desc_en;
        csr_context_table_to_buffer_static_mem.tph_rd_desc_en  = csr_context_table_ff.tph_rd_desc_en;
        csr_context_table_to_buffer_static_mem.pref_en         = csr_context_table_ff.pref_en;
        csr_context_table_to_buffer_static_mem.low_rx_q_thr    = csr_context_table_ff.low_rx_q_thr;
        csr_context_table_to_buffer_static_mem.rx_q_len        = csr_context_table_ff.rx_q_len;
        csr_context_table_to_buffer_static_mem.base_high       = csr_context_table_ff.base_high;
        csr_context_table_to_buffer_static_mem.base_low        = csr_context_table_ff.base_low;
    end

    // QRX FIRST PACKET MEMORY ACCESS

    // Write must be done at cycle of rd_vld to avoid collisions with other client
    assign mem_ctrl_csr_q_cntx_first_pkt_wr_en     = io_mem_ctrl_csr_q_cntx_first_pkt_intf.rd_vld & csr_context_wr_req_init_active_ff;
    assign mem_ctrl_csr_q_cntx_first_pkt_rd_en_nxt = (csr_context_wr_req_wr_cmd_start & csr_context_wr_req_init_en & (~csr_context_ctl_wr_data_s_ff.buff_q)) ? '1 :
                                                     (mem_ctrl_csr_q_cntx_first_pkt_rd_ev) ? '0 : mem_ctrl_csr_q_cntx_first_pkt_rd_en_ff;

    always_ff @(posedge clk or negedge rst_n) begin
        if (~rst_n) begin
            mem_ctrl_csr_q_cntx_first_pkt_rd_en_ff <= '0;
        end
        else begin
            mem_ctrl_csr_q_cntx_first_pkt_rd_en_ff <= mem_ctrl_csr_q_cntx_first_pkt_rd_en_nxt;
        end
    end

    assign mem_ctrl_csr_q_cntx_first_pkt_addr = target_q_idx_t'(csr_context_ctl_l_ff.queue_id) >> Q_1ST_PKT_MEM_QUEUES_PER_LINE_WDT;
    assign mem_ctrl_csr_q_cntx_first_pkt_bit  = (csr_context_wr_req_init_vm_mig_ff) ? {csr_context_ctl_l_ff.queue_id[Q_1ST_PKT_MEM_QUEUES_PER_LINE_WDT-1:0], 1'b1}:
                                                                                      {csr_context_ctl_l_ff.queue_id[Q_1ST_PKT_MEM_QUEUES_PER_LINE_WDT-1:0], 1'b0};

    assign mem_ctrl_csr_q_cntx_first_pkt_rd_data_sel = (io_mem_ctrl_csr_q_cntx_first_pkt_intf.rd_vld) ? io_mem_ctrl_csr_q_cntx_first_pkt_intf.rd_data : mem_ctrl_csr_q_cntx_first_pkt_rd_data_l_ff;

    always_ff @(posedge clk or negedge rst_n) begin
        if (~rst_n) begin
            mem_ctrl_csr_q_cntx_first_pkt_rd_data_l_ff <= '0;
        end
        else begin
            mem_ctrl_csr_q_cntx_first_pkt_rd_data_l_ff <= mem_ctrl_csr_q_cntx_first_pkt_rd_data_sel;
        end
    end

    always_comb begin : always_q_cntx_first_pkt_wr_data
        for (int bit_i = 0; bit_i < Q_1ST_PKT_MEM_DATA_WDT; bit_i++) begin
            if (bit_i == mem_ctrl_csr_q_cntx_first_pkt_bit) begin
                mem_ctrl_csr_q_cntx_first_pkt_wr_data[bit_i] = 1'b1;
            end
            else begin
                mem_ctrl_csr_q_cntx_first_pkt_wr_data[bit_i] = mem_ctrl_csr_q_cntx_first_pkt_rd_data_sel[bit_i];
            end
        end
    end

    assign io_mem_ctrl_csr_q_cntx_first_pkt_intf.wr_en   = mem_ctrl_csr_q_cntx_first_pkt_wr_en;
    assign io_mem_ctrl_csr_q_cntx_first_pkt_intf.wr_addr = (mem_ctrl_csr_q_cntx_first_pkt_wr_en) ? mem_ctrl_csr_q_cntx_first_pkt_addr : '0;
    assign io_mem_ctrl_csr_q_cntx_first_pkt_intf.wr_data = (mem_ctrl_csr_q_cntx_first_pkt_wr_en) ? mem_ctrl_csr_q_cntx_first_pkt_wr_data : '0;
    assign io_mem_ctrl_csr_q_cntx_first_pkt_intf.rd_en   = mem_ctrl_csr_q_cntx_first_pkt_rd_en_ff;
    assign io_mem_ctrl_csr_q_cntx_first_pkt_intf.rd_addr = (mem_ctrl_csr_q_cntx_first_pkt_rd_en_ff) ? mem_ctrl_csr_q_cntx_first_pkt_addr : '0;

    // QRX BUFFER FIRST PACKET MEMORY ACCESS

    // Write must be done at cycle of rd_vld to avoid collisions with other client
    assign mem_ctrl_csr_q_cntx_buffer_first_pkt_wr_en     = io_mem_ctrl_csr_q_cntx_buffer_first_pkt_intf.rd_vld & csr_context_wr_req_init_active_ff;
    assign mem_ctrl_csr_q_cntx_buffer_first_pkt_rd_en_nxt = (csr_context_wr_req_wr_cmd_start & csr_context_wr_req_init_en & csr_context_ctl_wr_data_s_ff.buff_q) ? '1 :
                                                            (mem_ctrl_csr_q_cntx_buffer_first_pkt_rd_ev) ? '0 : mem_ctrl_csr_q_cntx_buffer_first_pkt_rd_en_ff;

    always_ff @(posedge clk or negedge rst_n) begin
        if (~rst_n) begin
            mem_ctrl_csr_q_cntx_buffer_first_pkt_rd_en_ff <= '0;
        end
        else begin
            mem_ctrl_csr_q_cntx_buffer_first_pkt_rd_en_ff <= mem_ctrl_csr_q_cntx_buffer_first_pkt_rd_en_nxt;
        end
    end

    assign mem_ctrl_csr_q_cntx_buffer_first_pkt_addr = csr_context_ctl_l_ff.queue_id >> BUFFQ_1ST_PKT_MEM_QUEUES_PER_LINE_WDT;
    assign mem_ctrl_csr_q_cntx_buffer_first_pkt_bit  = (csr_context_wr_req_init_vm_mig_ff) ? {csr_context_ctl_l_ff.queue_id[BUFFQ_1ST_PKT_MEM_QUEUES_PER_LINE_WDT-1:0], 1'b1}:
                                                                                             {csr_context_ctl_l_ff.queue_id[BUFFQ_1ST_PKT_MEM_QUEUES_PER_LINE_WDT-1:0], 1'b0};

    assign mem_ctrl_csr_q_cntx_buffer_first_pkt_rd_data_sel = (io_mem_ctrl_csr_q_cntx_buffer_first_pkt_intf.rd_vld) ? io_mem_ctrl_csr_q_cntx_buffer_first_pkt_intf.rd_data : mem_ctrl_csr_q_cntx_buffer_first_pkt_rd_data_l_ff;

    always_ff @(posedge clk or negedge rst_n) begin
        if (~rst_n) begin
            mem_ctrl_csr_q_cntx_buffer_first_pkt_rd_data_l_ff <= '0;
        end
        else begin
            mem_ctrl_csr_q_cntx_buffer_first_pkt_rd_data_l_ff <= mem_ctrl_csr_q_cntx_buffer_first_pkt_rd_data_sel;
        end
    end

    always_comb begin : always_q_cntx_buffer_first_pkt_wr_data
        for (int bit_i = 0; bit_i < BUFFQ_1ST_PKT_MEM_DATA_WDT; bit_i++) begin
            if (bit_i == mem_ctrl_csr_q_cntx_buffer_first_pkt_bit) begin
                mem_ctrl_csr_q_cntx_buffer_first_pkt_wr_data[bit_i] = 1'b1;
            end
            else begin
                mem_ctrl_csr_q_cntx_buffer_first_pkt_wr_data[bit_i] = mem_ctrl_csr_q_cntx_buffer_first_pkt_rd_data_sel[bit_i];
            end
        end
    end

    assign io_mem_ctrl_csr_q_cntx_buffer_first_pkt_intf.wr_en   = mem_ctrl_csr_q_cntx_buffer_first_pkt_wr_en;
    assign io_mem_ctrl_csr_q_cntx_buffer_first_pkt_intf.wr_addr = (mem_ctrl_csr_q_cntx_buffer_first_pkt_wr_en) ? mem_ctrl_csr_q_cntx_buffer_first_pkt_addr : '0;
    assign io_mem_ctrl_csr_q_cntx_buffer_first_pkt_intf.wr_data = (mem_ctrl_csr_q_cntx_buffer_first_pkt_wr_en) ? mem_ctrl_csr_q_cntx_buffer_first_pkt_wr_data : '0;
    assign io_mem_ctrl_csr_q_cntx_buffer_first_pkt_intf.rd_en   = mem_ctrl_csr_q_cntx_buffer_first_pkt_rd_en_ff;
    assign io_mem_ctrl_csr_q_cntx_buffer_first_pkt_intf.rd_addr = (mem_ctrl_csr_q_cntx_buffer_first_pkt_rd_en_ff) ? mem_ctrl_csr_q_cntx_buffer_first_pkt_addr : '0;


    /////////////////////
    // QRX_INT_RD_HEAD //
    /////////////////////

    // QRX_INT_RD_HEAD REGISTER

    always_ff @(posedge clk or negedge rst_n) begin
        if (~rst_n) begin
            csr_q_head_wr_req_s_ff  <= '0;
            csr_q_head_wr_data_s_ff <= '0;
            csr_q_head_rd_req_s_ff  <= '0;
            csr_q_head_idx_s_ff     <= '0;
        end
        else begin
            csr_q_head_wr_req_s_ff  <= io_csr_q_head_intf.wr_req;
            csr_q_head_wr_data_s_ff <= io_csr_q_head_intf.wr_data;
            csr_q_head_rd_req_s_ff  <= io_csr_q_head_intf.rd_req;
            csr_q_head_idx_s_ff     <= io_csr_q_head_intf.idx;
        end
    end

    assign csr_q_head_vld_l_nxt     = (csr_q_head_wr_req_s_ff | csr_q_head_rd_req_s_ff) ? '1 : csr_q_head_ack_ff ? '0 : csr_q_head_vld_l_ff;
    assign csr_q_head_wr_data_l_nxt = (csr_q_head_wr_req_s_ff) ? csr_q_head_wr_data_s_ff : csr_q_head_wr_data_l_ff;
    assign csr_q_head_idx_l_nxt     = (csr_q_head_wr_req_s_ff | csr_q_head_rd_req_s_ff) ? csr_q_head_idx_s_ff : csr_q_head_idx_l_ff;

    always_ff @(posedge clk or negedge rst_n) begin
        if (~rst_n) begin
            csr_q_head_vld_l_ff     <= '0;
            csr_q_head_wr_data_l_ff <= '0;
            csr_q_head_idx_l_ff     <= '0;
        end
        else begin
            csr_q_head_vld_l_ff     <= csr_q_head_vld_l_nxt;
            csr_q_head_wr_data_l_ff <= csr_q_head_wr_data_l_nxt;
            csr_q_head_idx_l_ff     <= csr_q_head_idx_l_nxt;
        end
    end

    assign csr_q_head_ack_nxt     = (mem_ctrl_csr_q_cntx_ring_head_wr_ev | io_mem_ctrl_csr_q_cntx_ring_head_intf.rd_vld) & csr_q_head_vld_l_ff;
    assign csr_q_head_rd_data_nxt = (io_mem_ctrl_csr_q_cntx_ring_head_intf.rd_vld & csr_q_head_vld_l_ff) ? io_mem_ctrl_csr_q_cntx_ring_head_intf.rd_data : '0;

    always_ff @(posedge clk or negedge rst_n) begin
        if (~rst_n) begin
            csr_q_head_ack_ff     <= '0;
            csr_q_head_rd_data_ff <= '0;
        end
        else begin
            csr_q_head_ack_ff     <= csr_q_head_ack_nxt;
            csr_q_head_rd_data_ff <= csr_q_head_rd_data_nxt;
        end
    end

    assign io_csr_q_head_intf.ack     = csr_q_head_ack_ff;
    assign io_csr_q_head_intf.rd_data = csr_q_head_rd_data_ff;

    // QRX_INT_BUFFQ_RD_HEAD REGISTER

    always_ff @(posedge clk or negedge rst_n) begin
        if (~rst_n) begin
            csr_buffq_head_wr_req_s_ff  <= '0;
            csr_buffq_head_wr_data_s_ff <= '0;
            csr_buffq_head_rd_req_s_ff  <= '0;
            csr_buffq_head_idx_s_ff     <= '0;
        end
        else begin
            csr_buffq_head_wr_req_s_ff  <= io_csr_buffq_head_intf.wr_req;
            csr_buffq_head_wr_data_s_ff <= io_csr_buffq_head_intf.wr_data;
            csr_buffq_head_rd_req_s_ff  <= io_csr_buffq_head_intf.rd_req;
            csr_buffq_head_idx_s_ff     <= io_csr_buffq_head_intf.idx;
        end
    end

    assign csr_buffq_head_vld_l_nxt     = (csr_buffq_head_wr_req_s_ff | csr_buffq_head_rd_req_s_ff) ? '1 : csr_buffq_head_ack_ff ? '0 : csr_buffq_head_vld_l_ff;
    assign csr_buffq_head_wr_data_l_nxt = (csr_buffq_head_wr_req_s_ff) ? csr_buffq_head_wr_data_s_ff : csr_buffq_head_wr_data_l_ff;
    assign csr_buffq_head_idx_l_nxt     = (csr_buffq_head_wr_req_s_ff | csr_buffq_head_rd_req_s_ff) ? csr_buffq_head_idx_s_ff : csr_buffq_head_idx_l_ff;

    always_ff @(posedge clk or negedge rst_n) begin
        if (~rst_n) begin
            csr_buffq_head_vld_l_ff     <= '0;
            csr_buffq_head_wr_data_l_ff <= '0;
            csr_buffq_head_idx_l_ff     <= '0;
        end
        else begin
            csr_buffq_head_vld_l_ff     <= csr_buffq_head_vld_l_nxt;
            csr_buffq_head_wr_data_l_ff <= csr_buffq_head_wr_data_l_nxt;
            csr_buffq_head_idx_l_ff     <= csr_buffq_head_idx_l_nxt;
        end
    end

    assign csr_buffq_head_ack_nxt     = (mem_ctrl_csr_q_cntx_ring_head_wr_ev | io_mem_ctrl_csr_q_cntx_ring_head_intf.rd_vld) & csr_buffq_head_vld_l_ff;
    assign csr_buffq_head_rd_data_nxt = (io_mem_ctrl_csr_q_cntx_ring_head_intf.rd_vld & csr_buffq_head_vld_l_ff) ? io_mem_ctrl_csr_q_cntx_ring_head_intf.rd_data : '0;

    always_ff @(posedge clk or negedge rst_n) begin
        if (~rst_n) begin
            csr_buffq_head_ack_ff     <= '0;
            csr_buffq_head_rd_data_ff <= '0;
        end
        else begin
            csr_buffq_head_ack_ff     <= csr_buffq_head_ack_nxt;
            csr_buffq_head_rd_data_ff <= csr_buffq_head_rd_data_nxt;
        end
    end

    assign io_csr_buffq_head_intf.ack     = csr_buffq_head_ack_ff;
    assign io_csr_buffq_head_intf.rd_data = csr_buffq_head_rd_data_ff;

    // QRX_INT_RD_HEAD, QRX_INT_BUFFQ_RD_HEAD COMMON MEMORY ACCESS

    assign mem_ctrl_csr_q_cntx_ring_head_wr_en_nxt = (csr_q_head_wr_req_s_ff | csr_buffq_head_wr_req_s_ff) ? '1 : (mem_ctrl_csr_q_cntx_ring_head_wr_ev) ? '0 : mem_ctrl_csr_q_cntx_ring_head_wr_en_ff;
    assign mem_ctrl_csr_q_cntx_ring_head_rd_en_nxt = (csr_q_head_rd_req_s_ff | csr_buffq_head_rd_req_s_ff) ? '1 : (mem_ctrl_csr_q_cntx_ring_head_rd_ev) ? '0 : mem_ctrl_csr_q_cntx_ring_head_rd_en_ff;

    always_ff @(posedge clk or negedge rst_n) begin
        if (~rst_n) begin
            mem_ctrl_csr_q_cntx_ring_head_wr_en_ff <= '0;
            mem_ctrl_csr_q_cntx_ring_head_rd_en_ff <= '0;
        end
        else begin
            mem_ctrl_csr_q_cntx_ring_head_wr_en_ff <= mem_ctrl_csr_q_cntx_ring_head_wr_en_nxt;
            mem_ctrl_csr_q_cntx_ring_head_rd_en_ff <= mem_ctrl_csr_q_cntx_ring_head_rd_en_nxt;
        end
    end

    assign mem_ctrl_csr_q_cntx_ring_head_addr      = (csr_q_head_vld_l_ff) ? q_ring_ptr_mem_addr_t'(csr_q_head_idx_l_ff) : q_ring_ptr_mem_addr_t'(TARGET_QUEUES_NUM + csr_buffq_head_idx_l_ff);
    assign mem_ctrl_csr_q_cntx_ring_head_wr_data   = (csr_q_head_vld_l_ff) ? csr_q_head_wr_data_l_ff : csr_buffq_head_wr_data_l_ff;

    assign io_mem_ctrl_csr_q_cntx_ring_head_intf.wr_en   = mem_ctrl_csr_q_cntx_ring_head_wr_en_ff;
    assign io_mem_ctrl_csr_q_cntx_ring_head_intf.wr_addr = (mem_ctrl_csr_q_cntx_ring_head_wr_en_ff | mem_ctrl_csr_q_cntx_ring_head_rd_en_ff) ? mem_ctrl_csr_q_cntx_ring_head_addr : '0;
    assign io_mem_ctrl_csr_q_cntx_ring_head_intf.wr_data = (mem_ctrl_csr_q_cntx_ring_head_wr_en_ff) ? mem_ctrl_csr_q_cntx_ring_head_wr_data : '0;
    assign io_mem_ctrl_csr_q_cntx_ring_head_intf.rd_en   = mem_ctrl_csr_q_cntx_ring_head_rd_en_ff;
    assign io_mem_ctrl_csr_q_cntx_ring_head_intf.rd_addr = (mem_ctrl_csr_q_cntx_ring_head_wr_en_ff | mem_ctrl_csr_q_cntx_ring_head_rd_en_ff) ? mem_ctrl_csr_q_cntx_ring_head_addr : '0;


    ////////////
    // Q_CTRL //
    ////////////

    assign io_q_ctrl_q_en_intf.wr_req  = (csr_cq_any_cmd_active) ? csr_cq_q_ctrl_wr_req : io_csr_q_en_intf.wr_req;
    assign io_q_ctrl_q_en_intf.wr_data = (csr_cq_any_cmd_active) ? csr_cq_q_ctrl_q_en_wr_data : io_csr_q_en_intf.wr_data;
    assign io_q_ctrl_q_en_intf.rd_req  = (csr_cq_any_cmd_active) ? csr_cq_q_ctrl_rd_req : io_csr_q_en_intf.rd_req;
    assign io_q_ctrl_q_en_intf.idx     = (csr_cq_any_cmd_active) ? csr_cq_q_ctrl_idx : io_csr_q_en_intf.idx;
    assign io_csr_q_en_intf.ack        = (csr_cq_any_cmd_active) ? '0 : io_q_ctrl_q_en_intf.ack;
    assign io_csr_q_en_intf.rd_data    = (csr_cq_any_cmd_active) ? '0 : io_q_ctrl_q_en_intf.rd_data;


    /////////////////////////////////////
    // QRX_CQBAL, QRX_CQBAH, QRX_CQLEN //
    /////////////////////////////////////

    // QRX_CQBAL REGISTER

    always_ff @(posedge clk or negedge rst_n) begin
        if (~rst_n) begin
            csr_cqbal_wr_req_s_ff  <= '0;
            csr_cqbal_wr_data_s_ff <= '0;
            csr_cqbal_rd_req_s_ff  <= '0;
            csr_cqbal_idx_s_ff     <= '0;
        end
        else begin
            csr_cqbal_wr_req_s_ff  <= io_csr_cqbal_intf.wr_req;
            csr_cqbal_wr_data_s_ff <= io_csr_cqbal_intf.wr_data;
            csr_cqbal_rd_req_s_ff  <= io_csr_cqbal_intf.rd_req;
            csr_cqbal_idx_s_ff     <= io_csr_cqbal_intf.idx;
        end
    end

    assign csr_cqbal_wr_data_l_nxt = (csr_cqbal_wr_req_s_ff) ? csr_cqbal_wr_data_s_ff : csr_cqbal_wr_data_l_ff;

    always_ff @(posedge clk or negedge rst_n) begin
        if (~rst_n) begin
            csr_cqbal_wr_data_l_ff <= '0;
        end
        else begin
            csr_cqbal_wr_data_l_ff <= csr_cqbal_wr_data_l_nxt;
        end
    end

    assign csr_cqbal_ack_nxt           = (csr_cq_wr_cmd_done | csr_cq_rd_cmd_done) & (csr_cq_reg_l_ff == CQBAL);
    assign csr_cqbal_rd_data_nxt = (csr_cq_rd_cmd_done & (csr_cq_reg_l_ff == CQBAL)) ? io_mem_ctrl_csr_q_cntx_static_intf.rd_data.base_low : '0;

    always_ff @(posedge clk or negedge rst_n) begin
        if (~rst_n) begin
            csr_cqbal_ack_ff     <= '0;
            csr_cqbal_rd_data_ff <= '0;
        end
        else begin
            csr_cqbal_ack_ff     <= csr_cqbal_ack_nxt;
            csr_cqbal_rd_data_ff <= csr_cqbal_rd_data_nxt;
        end
    end

    assign io_csr_cqbal_intf.ack     = csr_cqbal_ack_ff;
    assign io_csr_cqbal_intf.rd_data = csr_cqbal_rd_data_ff;

    // QRX_CQBAH REGISTER

    always_ff @(posedge clk or negedge rst_n) begin
        if (~rst_n) begin
            csr_cqbah_wr_req_s_ff  <= '0;
            csr_cqbah_wr_data_s_ff <= '0;
            csr_cqbah_rd_req_s_ff  <= '0;
            csr_cqbah_idx_s_ff     <= '0;
        end
        else begin
            csr_cqbah_wr_req_s_ff  <= io_csr_cqbah_intf.wr_req;
            csr_cqbah_wr_data_s_ff <= io_csr_cqbah_intf.wr_data;
            csr_cqbah_rd_req_s_ff  <= io_csr_cqbah_intf.rd_req;
            csr_cqbah_idx_s_ff     <= io_csr_cqbah_intf.idx;
        end
    end

    assign csr_cqbah_wr_data_l_nxt = (csr_cqbah_wr_req_s_ff) ? csr_cqbah_wr_data_s_ff : csr_cqbah_wr_data_l_ff;

    always_ff @(posedge clk or negedge rst_n) begin
        if (~rst_n) begin
            csr_cqbah_wr_data_l_ff <= '0;
        end
        else begin
            csr_cqbah_wr_data_l_ff <= csr_cqbah_wr_data_l_nxt;
        end
    end

    assign csr_cqbah_ack_nxt     = (csr_cq_wr_cmd_done | csr_cq_rd_cmd_done) & (csr_cq_reg_l_ff == CQBAH);
    assign csr_cqbah_rd_data_nxt = (csr_cq_rd_cmd_done & (csr_cq_reg_l_ff == CQBAH)) ? io_mem_ctrl_csr_q_cntx_static_intf.rd_data.base_high : '0;

    always_ff @(posedge clk or negedge rst_n) begin
        if (~rst_n) begin
            csr_cqbah_ack_ff     <= '0;
            csr_cqbah_rd_data_ff <= '0;
        end
        else begin
            csr_cqbah_ack_ff     <= csr_cqbah_ack_nxt;
            csr_cqbah_rd_data_ff <= csr_cqbah_rd_data_nxt;
        end
    end

    assign io_csr_cqbah_intf.ack     = csr_cqbah_ack_ff;
    assign io_csr_cqbah_intf.rd_data = csr_cqbah_rd_data_ff;

    // QRX_CQLEN REGISTER

    always_ff @(posedge clk or negedge rst_n) begin
        if (~rst_n) begin
            csr_cqlen_wr_req_s_ff  <= '0;
            csr_cqlen_wr_data_s_ff <= '0;
            csr_cqlen_rd_req_s_ff  <= '0;
            csr_cqlen_idx_s_ff     <= '0;
        end
        else begin
            csr_cqlen_wr_req_s_ff  <= io_csr_cqlen_intf.wr_req;
            csr_cqlen_wr_data_s_ff <= io_csr_cqlen_intf.wr_data;
            csr_cqlen_rd_req_s_ff  <= io_csr_cqlen_intf.rd_req;
            csr_cqlen_idx_s_ff     <= io_csr_cqlen_intf.idx;
        end
    end

    assign csr_cqlen_wr_data_l_nxt = (csr_cqlen_wr_req_s_ff) ? csr_cqlen_wr_data_s_ff : csr_cqlen_wr_data_l_ff;

    always_ff @(posedge clk or negedge rst_n) begin
        if (~rst_n) begin
            csr_cqlen_wr_data_l_ff <= '0;
        end
        else begin
            csr_cqlen_wr_data_l_ff <= csr_cqlen_wr_data_l_nxt;
        end
    end

//    assign csr_cqlen_ack_nxt                  = (csr_cq_wr_cmd_done | csr_cq_rd_cmd_done) & (csr_cq_reg_l_ff == CQLEN);
//    assign csr_cqlen_rd_data_pre_l_nxt.enable = (csr_cq_rd_cmd_done & (csr_cq_reg_l_ff == CQLEN)) ? io_q_ctrl_q_en_intf.rd_data : '0;
//    assign csr_cqlen_rd_data_pre_l_nxt.length = ((csr_cq_reg_l_ff == CQLEN) & io_mem_ctrl_csr_q_cntx_static_intf.rd_vld) ? io_mem_ctrl_csr_q_cntx_static_intf.rd_data.rx_q_len : csr_cqlen_rd_data_pre_l_ff.length;
//    assign csr_cqlen_rd_data_nxt              = (csr_cq_rd_cmd_done & (csr_cq_reg_l_ff == CQLEN)) ? csr_cqlen_rd_data_pre_l_ff : '0;
    assign csr_cqlen_ack_nxt            = (csr_cq_wr_cmd_done | csr_cq_rd_cmd_done) & (csr_cq_reg_l_ff == CQLEN);
    assign csr_cqlen_rd_data_pre_l_nxt  = ((csr_cq_reg_l_ff == CQLEN) & io_mem_ctrl_csr_q_cntx_static_intf.rd_vld) ? io_mem_ctrl_csr_q_cntx_static_intf.rd_data.rx_q_len : csr_cqlen_rd_data_pre_l_ff;   
    assign csr_cqlen_rd_data_nxt.enable = (csr_cq_rd_cmd_done & (csr_cq_reg_l_ff == CQLEN)) ? io_q_ctrl_q_en_intf.rd_data : '0;
    assign csr_cqlen_rd_data_nxt.length = (csr_cq_rd_cmd_done & (csr_cq_reg_l_ff == CQLEN)) ? csr_cqlen_rd_data_pre_l_ff : '0;

    always_ff @(posedge clk or negedge rst_n) begin
        if (~rst_n) begin
            csr_cqlen_ack_ff           <= '0;
            csr_cqlen_rd_data_pre_l_ff <= '0;
            csr_cqlen_rd_data_ff       <= '0;
        end
        else begin
            csr_cqlen_ack_ff           <= csr_cqlen_ack_nxt;
            csr_cqlen_rd_data_pre_l_ff <= csr_cqlen_rd_data_pre_l_nxt;
            csr_cqlen_rd_data_ff       <= csr_cqlen_rd_data_nxt;
        end
    end

    assign io_csr_cqlen_intf.ack     = csr_cqlen_ack_ff;
    assign io_csr_cqlen_intf.rd_data = csr_cqlen_rd_data_ff;

    // QRX_CQBAL, QRX_CQBAH, QRX_CQLEN COMMON LATCHES

    assign csr_cq_reg_l_nxt = (csr_cqbal_wr_req_s_ff | csr_cqbal_rd_req_s_ff) ? CQBAL :
                              (csr_cqbah_wr_req_s_ff | csr_cqbah_rd_req_s_ff) ? CQBAH :
                              (csr_cqlen_wr_req_s_ff | csr_cqlen_rd_req_s_ff) ? CQLEN :
                              (csr_cq_wr_cmd_done | csr_cq_rd_cmd_done) ? IDLE : csr_cq_reg_l_ff;

    assign csr_cq_idx_l_nxt = (csr_cqbal_wr_req_s_ff | csr_cqbal_rd_req_s_ff) ? csr_cqbal_idx_s_ff :
                              (csr_cqbah_wr_req_s_ff | csr_cqbah_rd_req_s_ff) ? csr_cqbah_idx_s_ff :
                              (csr_cqlen_wr_req_s_ff | csr_cqlen_rd_req_s_ff) ? csr_cqlen_idx_s_ff :
                              (csr_cq_wr_cmd_done | csr_cq_rd_cmd_done) ? '0 : csr_cq_idx_l_ff;

    always_ff @(posedge clk or negedge rst_n) begin
        if (~rst_n) begin
            csr_cq_reg_l_ff <= IDLE;
            csr_cq_idx_l_ff <= '0;
        end
        else begin
            csr_cq_reg_l_ff <= csr_cq_reg_l_nxt;
            csr_cq_idx_l_ff <= csr_cq_idx_l_nxt;
        end
    end

    always_comb begin
        csr_cq_context_table_nxt                           = csr_cq_context_table_ff;
        if (io_mem_ctrl_csr_q_cntx_static_intf.rd_vld & (csr_cq_reg_l_ff != IDLE)) begin
            csr_cq_context_table_nxt                       = io_mem_ctrl_csr_q_cntx_static_intf.rd_data;
            case (csr_cq_reg_l_ff)
                CQBAL : csr_cq_context_table_nxt.base_low  = csr_cqbal_wr_data_l_ff;
                CQBAH : csr_cq_context_table_nxt.base_high = csr_cqbah_wr_data_l_ff;
                CQLEN : csr_cq_context_table_nxt.rx_q_len  = csr_cqlen_wr_data_l_ff.length;
            endcase
        end
    end

    always_ff @(posedge clk or negedge rst_n) begin
        if (~rst_n) begin
            csr_cq_context_table_ff <= '0;
        end
        else begin
            csr_cq_context_table_ff <= csr_cq_context_table_nxt;
        end
    end

    // QRX_CQBAL, QRX_CQBAH, QRX_CQLEN COMMON MEMORY ACCESS

    assign csr_cq_wr_cmd_start = csr_cqbal_wr_req_s_ff | csr_cqbah_wr_req_s_ff | csr_cqlen_wr_req_s_ff;
    assign csr_cq_rd_cmd_start = csr_cqbal_rd_req_s_ff | csr_cqbah_rd_req_s_ff | csr_cqlen_rd_req_s_ff;

    assign csr_cq_wr_cmd_done = ((csr_cq_reg_l_ff != CQLEN) & csr_cq_during_context_wr_access_ff & mem_ctrl_csr_q_cntx_static_wr_ev) |
                                ((csr_cq_reg_l_ff == CQLEN) & csr_cq_during_context_wr_access_ff & (io_q_ctrl_q_en_intf.ack | csr_cq_q_ctrl_wr_mask));
    assign csr_cq_rd_cmd_done = ((csr_cq_reg_l_ff != CQLEN) & csr_cq_rd_cmd_active_ff & io_mem_ctrl_csr_q_cntx_static_intf.rd_vld) |
                                ((csr_cq_reg_l_ff == CQLEN) & csr_cq_rd_cmd_active_ff & io_q_ctrl_q_en_intf.ack);

    assign csr_cq_wr_cmd_active_nxt = (csr_cq_wr_cmd_start) ? '1 : csr_cq_wr_cmd_done ? '0 : csr_cq_wr_cmd_active_ff;
    assign csr_cq_rd_cmd_active_nxt = (csr_cq_rd_cmd_start) ? '1 : csr_cq_rd_cmd_done ? '0 : csr_cq_rd_cmd_active_ff;

    assign csr_cq_context_wr_access_start = (csr_cq_wr_cmd_active_ff & io_mem_ctrl_csr_q_cntx_static_intf.rd_vld);
    assign csr_cq_context_rd_access_start = (csr_cq_wr_cmd_start | csr_cq_rd_cmd_start);

    assign csr_cq_during_context_wr_access_nxt = (csr_cq_context_wr_access_start) ? '1 : csr_cq_wr_cmd_done ? '0 : csr_cq_during_context_wr_access_ff;

    always_ff @(posedge clk or negedge rst_n) begin
        if (~rst_n) begin
            csr_cq_wr_cmd_active_ff            <= '0;
            csr_cq_rd_cmd_active_ff            <= '0;
            csr_cq_during_context_wr_access_ff <= '0;
        end
        else begin
            csr_cq_wr_cmd_active_ff            <= csr_cq_wr_cmd_active_nxt;
            csr_cq_rd_cmd_active_ff            <= csr_cq_rd_cmd_active_nxt;
            csr_cq_during_context_wr_access_ff <= csr_cq_during_context_wr_access_nxt;
        end
    end

    assign csr_cq_any_cmd_active = csr_cq_wr_cmd_active_ff | csr_cq_rd_cmd_active_ff;

    assign mem_ctrl_csr_cq_cntx_static_wr_en_nxt = (csr_cq_context_wr_access_start) ? '1 : (mem_ctrl_csr_q_cntx_static_wr_ev) ? '0 : mem_ctrl_csr_cq_cntx_static_wr_en_ff;
    assign mem_ctrl_csr_cq_cntx_static_rd_en_nxt = (csr_cq_context_rd_access_start) ? '1 : (mem_ctrl_csr_q_cntx_static_rd_ev) ? '0 : mem_ctrl_csr_cq_cntx_static_rd_en_ff;

    always_ff @(posedge clk or negedge rst_n) begin
        if (~rst_n) begin
            mem_ctrl_csr_cq_cntx_static_wr_en_ff <= '0;
            mem_ctrl_csr_cq_cntx_static_rd_en_ff <= '0;
        end
        else begin
            mem_ctrl_csr_cq_cntx_static_wr_en_ff <= mem_ctrl_csr_cq_cntx_static_wr_en_nxt;
            mem_ctrl_csr_cq_cntx_static_rd_en_ff <= mem_ctrl_csr_cq_cntx_static_rd_en_nxt;
        end
    end

    assign csr_cq_q_ctrl_wr_mask      = (csr_cq_reg_l_ff == CQLEN) & csr_cq_during_context_wr_access_ff & mem_ctrl_csr_q_cntx_static_wr_ev & (~csr_cqlen_wr_data_l_ff.enable);
    assign csr_cq_q_ctrl_wr_req       = (csr_cq_reg_l_ff == CQLEN) & csr_cq_during_context_wr_access_ff & mem_ctrl_csr_q_cntx_static_wr_ev & csr_cqlen_wr_data_l_ff.enable;
    assign csr_cq_q_ctrl_q_en_wr_data = (csr_cq_q_ctrl_wr_req) ? csr_cqlen_wr_data_l_ff.enable : '0;
    assign csr_cq_q_ctrl_rd_req       = (csr_cq_reg_l_ff == CQLEN) & csr_cq_rd_cmd_active_ff & io_mem_ctrl_csr_q_cntx_static_intf.rd_vld;
    assign csr_cq_q_ctrl_idx          = csr_cq_idx_l_ff;


    ////////////////////
    // QRX RING EMPTY //
    ////////////////////

    always_ff @(posedge clk or negedge rst_n) begin
        if (~rst_n) begin
            csr_ring_empty_wr_req_s_ff  <= '0;
            csr_ring_empty_wr_data_s_ff <= '0;
            csr_ring_empty_rd_req_s_ff  <= '0;
            csr_ring_empty_idx_s_ff     <= '0;
        end
        else begin
            csr_ring_empty_wr_req_s_ff  <= io_csr_ring_empty_intf.wr_req;
            csr_ring_empty_wr_data_s_ff <= io_csr_ring_empty_intf.wr_data;
            csr_ring_empty_rd_req_s_ff  <= io_csr_ring_empty_intf.rd_req;
            csr_ring_empty_idx_s_ff     <= io_csr_ring_empty_intf.idx;
        end
    end

    assign csr_ring_empty_vld_l_nxt     = (csr_ring_empty_wr_req_s_ff | csr_ring_empty_rd_req_s_ff) ? '1 : csr_ring_empty_ack_nxt ? '0 : csr_ring_empty_vld_l_ff;
    assign csr_ring_empty_wr_data_l_nxt = (csr_ring_empty_wr_req_s_ff) ? csr_ring_empty_wr_data_s_ff : csr_ring_empty_wr_data_l_ff;
    assign csr_ring_empty_idx_l_nxt     = (csr_ring_empty_wr_req_s_ff | csr_ring_empty_rd_req_s_ff) ? csr_ring_empty_idx_s_ff : csr_ring_empty_idx_l_ff;

    always_ff @(posedge clk or negedge rst_n) begin
        if (~rst_n) begin
            csr_ring_empty_vld_l_ff     <= '0;
            csr_ring_empty_wr_data_l_ff <= '0;
            csr_ring_empty_idx_l_ff     <= '0;
        end
        else begin
            csr_ring_empty_vld_l_ff     <= csr_ring_empty_vld_l_nxt;
            csr_ring_empty_wr_data_l_ff <= csr_ring_empty_wr_data_l_nxt;
            csr_ring_empty_idx_l_ff     <= csr_ring_empty_idx_l_nxt;
        end
    end

    assign csr_ring_empty_ack_nxt     = io_mem_ctrl_csr_q_cntx_ring_empty_intf.rd_vld & csr_ring_empty_vld_l_ff;
    assign csr_ring_empty_rd_data_nxt = (io_mem_ctrl_csr_q_cntx_ring_empty_intf.rd_vld & csr_ring_empty_vld_l_ff) ? io_mem_ctrl_csr_q_cntx_ring_empty_intf.rd_data : '0;

    always_ff @(posedge clk or negedge rst_n) begin
        if (~rst_n) begin
            csr_ring_empty_ack_ff     <= '0;
            csr_ring_empty_rd_data_ff <= '0;
        end
        else begin
            csr_ring_empty_ack_ff     <= csr_ring_empty_ack_nxt;
            csr_ring_empty_rd_data_ff <= csr_ring_empty_rd_data_nxt;
        end
    end

    assign io_csr_ring_empty_intf.ack     = csr_ring_empty_ack_ff;
    assign io_csr_ring_empty_intf.rd_data = csr_ring_empty_rd_data_ff;

    // Track ring empty read request state
    assign csr_ring_empty_rd_req_sent_nxt = (io_mem_ctrl_csr_q_cntx_ring_empty_intf.rd_en & io_mem_ctrl_csr_q_cntx_ring_empty_intf.rd_rdy) ? '1 : (io_mem_ctrl_csr_q_cntx_ring_empty_intf.wr_en) ? '0 : csr_ring_empty_rd_req_sent_ff;

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            csr_ring_empty_rd_req_sent_ff <= '0;
        end
        else begin
            csr_ring_empty_rd_req_sent_ff <= csr_ring_empty_rd_req_sent_nxt;
        end
    end

    always_comb begin : always_csr_ring_empty_mem_wr_data
        csr_ring_empty_mem_wr_data = io_mem_ctrl_csr_q_cntx_ring_empty_intf.rd_data;
        for (int bit_i = 0; bit_i < Q_RING_EMPTY_MEM_DATA_WDT; bit_i++) begin
            if (csr_ring_empty_vld_l_ff & (csr_ring_empty_wr_data_l_ff[bit_i] == '1)) begin
                csr_ring_empty_mem_wr_data[bit_i] = '0;
            end
        end
    end

    // Outputs to q_cntx_ring_empty memory
    assign io_mem_ctrl_csr_q_cntx_ring_empty_intf.wr_en   = csr_ring_empty_vld_l_ff & io_mem_ctrl_csr_q_cntx_ring_empty_intf.rd_vld;
    assign io_mem_ctrl_csr_q_cntx_ring_empty_intf.wr_addr = (io_mem_ctrl_csr_q_cntx_ring_empty_intf.wr_en) ? csr_ring_empty_idx_l_ff : '0;
    assign io_mem_ctrl_csr_q_cntx_ring_empty_intf.wr_data = (io_mem_ctrl_csr_q_cntx_ring_empty_intf.wr_en) ? csr_ring_empty_mem_wr_data : '0;
    assign io_mem_ctrl_csr_q_cntx_ring_empty_intf.rd_en   = csr_ring_empty_vld_l_ff & (~csr_ring_empty_rd_req_sent_ff);
    assign io_mem_ctrl_csr_q_cntx_ring_empty_intf.rd_addr = (io_mem_ctrl_csr_q_cntx_ring_empty_intf.rd_en) ? csr_ring_empty_idx_l_ff : '0;


    ///////////////////////////
    // EVENT_Q_CNTX_REQ_FIFO //
    ///////////////////////////

    ecip_gen_rdy_val_fifo_v1
    #(
        .WIDTH      (lanpe_sl_package::RX__RLAN_RPS_EVENT_Q_CNTX_FTCH_WIDTH),
        .DEPTH      (EVENT_Q_CNTX_REQ_FIFO_THR_DPT),
        .WR_ON_FULL (0)
    )
    event_q_cntx_req_fifo_i
    (
        .clk        (clk),
        .rst_n      (rst_n),
        .clear      ('0),
        .used_space (),
        .vld_in     (event_q_cntx_req_fifo_wr_vld),
        .wr_data    (event_q_cntx_req_fifo_wr_data),
        .rdy_out    (event_q_cntx_req_fifo_wr_rdy),
        .vld_out    (event_q_cntx_req_fifo_rd_vld),
        .rd_data    (event_q_cntx_req_fifo_rd_data),
        .rdy_in     (event_q_cntx_req_fifo_rd_en)
    );

    assign event_q_cntx_req_fifo_wr_vld  = io_rlan_evq_cntx_req_intf.vld;
    assign event_q_cntx_req_fifo_wr_en   = io_rlan_evq_cntx_req_intf.vld & io_rlan_evq_cntx_req_intf.rdy;
    assign event_q_cntx_req_fifo_wr_data = io_rlan_evq_cntx_req_intf.cmd;
    assign event_q_cntx_req_fifo_rd_en   = event_q_cntx_req_fifo_rd_vld & io_mem_ctrl_rlan_q_cntx_static_intf.rd_en & io_mem_ctrl_rlan_q_cntx_static_intf.rd_rdy;
    assign io_rlan_evq_cntx_req_intf.rdy = event_q_cntx_req_fifo_wr_rdy;


    ///////////////////
    // MEMORY ACCESS //
    ///////////////////

    assign io_mem_ctrl_rlan_q_cntx_static_intf.rd_en   = event_q_cntx_req_fifo_rd_vld & event_q_cntx_rslt_fifo_wr_rdy & event_q_cntx_rslt_fifo_below_thr;
    assign io_mem_ctrl_rlan_q_cntx_static_intf.rd_addr = event_q_cntx_req_fifo_rd_data.event_queue;


    /////////////////////////////////
    // CSR INTERFACE CONFIGURATION //
    /////////////////////////////////

    always_ff @(posedge clk or negedge rst_n) begin
        if (~rst_n) begin
            csr_cntx_access_ctrl_ff <= '0;
        end
        else begin
            csr_cntx_access_ctrl_ff <= i_csr_cntx_access_ctrl;
        end
    end


    ////////////////////////////
    // EVENT_Q_CNTX_RSLT_FIFO //
    ////////////////////////////

    ecip_gen_rdy_val_fifo_v1
    #(
        .WIDTH      (lanpe_sl_package::RPS_RLAN_EVENT_Q_CNTXT_COMPLT_WIDTH),
        .DEPTH      (EVENT_Q_CNTX_RSLT_FIFO_THR_DPT),
        .WR_ON_FULL (0)
    )
    event_q_cntx_rslt_fifo_i
    (
        .clk        (clk),
        .rst_n      (rst_n),
        .clear      ('0),
        .used_space (event_q_cntx_rslt_fifo_used_space),
        .vld_in     (event_q_cntx_rslt_fifo_wr_en),
        .wr_data    (event_q_cntx_rslt_fifo_wr_data),
        .rdy_out    (event_q_cntx_rslt_fifo_wr_rdy),
        .vld_out    (event_q_cntx_rslt_fifo_rd_vld),
        .rd_data    (event_q_cntx_rslt_fifo_rd_data),
        .rdy_in     (event_q_cntx_rslt_fifo_rd_en)
    );

    assign event_q_cntx_rslt_fifo_wr_en     = io_mem_ctrl_rlan_q_cntx_static_intf.rd_vld;
    assign event_q_cntx_rslt_fifo_wr_data   = convert_to_rlan_ev_q_cntx_cmpl_func(io_mem_ctrl_rlan_q_cntx_static_intf.rd_data);
    assign event_q_cntx_rslt_fifo_rd_en     = event_q_cntx_rslt_fifo_rd_vld & io_rlan_evq_cntx_rslt_intf.rdy;
    assign event_q_cntx_rslt_fifo_below_thr = (event_q_cntx_rslt_fifo_used_space < csr_cntx_access_ctrl_ff.rslt_fifo_thr);
    assign io_rlan_evq_cntx_rslt_intf.vld   = event_q_cntx_rslt_fifo_rd_vld;
    assign io_rlan_evq_cntx_rslt_intf.data  = event_q_cntx_rslt_fifo_rd_data;


    ///////////////
    // FUNCTIONS //
    ///////////////

    // Convert command from queue context read data to rlan event queue context completion

    function automatic lanpe_sl_package::lan_rps_rlan_event_q_cntxt_complt_t convert_to_rlan_ev_q_cntx_cmpl_func;
        input  q_cntx_mem_data_t      i_q_context_data;
        convert_to_rlan_ev_q_cntx_cmpl_func.gen_sep_dbl              = i_q_context_data.gen_sep_dbl;
        convert_to_rlan_ev_q_cntx_cmpl_func.non_lanpe_func_mal_pol   = i_q_context_data.func_mal_policy;
        convert_to_rlan_ev_q_cntx_cmpl_func.wb_aggr_size             = i_q_context_data.wb_aggr_size;
        convert_to_rlan_ev_q_cntx_cmpl_func.requstor_id              = i_q_context_data.requestor_id;
        convert_to_rlan_ev_q_cntx_cmpl_func.host_offload_vf_num      = i_q_context_data.hostoff_func_num;
        convert_to_rlan_ev_q_cntx_cmpl_func.host_offload_vmvf_type   = i_q_context_data.hostoff_func_type;
        convert_to_rlan_ev_q_cntx_cmpl_func.host_offload_pf_num      = i_q_context_data.hostoff_pf_num;
        convert_to_rlan_ev_q_cntx_cmpl_func.host_offload_host        = i_q_context_data.hostoff_home;
        convert_to_rlan_ev_q_cntx_cmpl_func.descriptor_pasid_valid   = i_q_context_data.desc_pasid_valid;
        convert_to_rlan_ev_q_cntx_cmpl_func.descriptor_pasid         = i_q_context_data.desc_pasid;
        convert_to_rlan_ev_q_cntx_cmpl_func.noexpire                 = i_q_context_data.no_expire;
        convert_to_rlan_ev_q_cntx_cmpl_func.tphhwb                   = i_q_context_data.tph_hwb_en;
        convert_to_rlan_ev_q_cntx_cmpl_func.tphhead                  = i_q_context_data.tph_hdr_en;
        convert_to_rlan_ev_q_cntx_cmpl_func.tphdata                  = i_q_context_data.tph_data_en;
        convert_to_rlan_ev_q_cntx_cmpl_func.tphwdesc                 = i_q_context_data.tph_wr_desc_en;
        convert_to_rlan_ev_q_cntx_cmpl_func.tphrdesc                 = i_q_context_data.tph_rd_desc_en;
        convert_to_rlan_ev_q_cntx_cmpl_func.immediate_itr_enabled    = i_q_context_data.pref_en;
        convert_to_rlan_ev_q_cntx_cmpl_func.report_pf                = i_q_context_data.report_pf;
        convert_to_rlan_ev_q_cntx_cmpl_func.queue_length             = i_q_context_data.rx_q_len;
        convert_to_rlan_ev_q_cntx_cmpl_func.base_high                = i_q_context_data.base_high;
        convert_to_rlan_ev_q_cntx_cmpl_func.base_low                 = i_q_context_data.base_low;
        convert_to_rlan_ev_q_cntx_cmpl_func.queue_type               = i_q_context_data.queue_type;
        convert_to_rlan_ev_q_cntx_cmpl_func.descriptor_size          = (i_q_context_data.wr_dsize == 2'd0) ? '1 : '0;
    endfunction


    /////////////////
    // DFD UPDATES //
    /////////////////

    // Create counter events
    logic  dfd_cntx_access_request_ff;
    logic  dfd_cntx_access_result_ff;

    always_ff @(posedge clk or negedge rst_n) begin
        if (~rst_n) begin
            dfd_cntx_access_request_ff <= '0;
            dfd_cntx_access_result_ff  <= '0;
        end
        else begin
            dfd_cntx_access_request_ff <= event_q_cntx_req_fifo_wr_en;
            dfd_cntx_access_result_ff  <= event_q_cntx_rslt_fifo_rd_en;
        end
    end

    // Updates to dfd csrs
    assign o_dfd_cntx_access_updates.cntx_access_result_ev                          = dfd_cntx_access_result_ff;
    assign o_dfd_cntx_access_updates.cntx_access_request_ev                         = dfd_cntx_access_request_ff;
    assign o_dfd_cntx_access_updates.cntx_access_actives.cntx_result_fifo_has_data  = event_q_cntx_rslt_fifo_rd_vld;
    assign o_dfd_cntx_access_updates.cntx_access_actives.cntx_request_fifo_has_data = event_q_cntx_req_fifo_rd_vld;


    ////////////////
    // ASSERTIONS //
    ////////////////

    `ifndef INTEL_SVA_OFF

    import intel_checkers_pkg::*;

    // Check that when memory write to q_cntx_ring_empty does not have backpressure - guaranteed because read latency is fixed after the selected write request
    logic sva_cond_q_cntx_ring_empty_mem_wr_en_bp;
    assign sva_cond_q_cntx_ring_empty_mem_wr_en_bp = io_mem_ctrl_csr_q_cntx_ring_empty_intf.wr_en & (~io_mem_ctrl_csr_q_cntx_ring_empty_intf.wr_rdy);
    `ASSERTS_NEVER (assert_never_q_cntx_ring_empty_mem_wr_en_bp, sva_cond_q_cntx_ring_empty_mem_wr_en_bp, posedge clk, ~rst_n,
        `ERR_MSG ($psprintf("[RPS_ASSERTIONS] Error: cntx_access - memory write to q_cntx_ring_empty had backpressure at time %0t", $time)));

    // Check that when context data returns from memory result fifo is not full
    logic sva_cond_mem_rd_vld_when_rslt_fifo_not_rdy;
    assign sva_cond_mem_rd_vld_when_rslt_fifo_not_rdy = io_mem_ctrl_rlan_q_cntx_static_intf.rd_vld & (~event_q_cntx_rslt_fifo_wr_rdy);
    `ASSERTS_NEVER (assert_never_mem_rd_vld_when_rslt_fifo_not_rdy, sva_cond_mem_rd_vld_when_rslt_fifo_not_rdy, posedge clk, ~rst_n,
        `ERR_MSG ($psprintf("[RPS_ASSERTIONS] Error: cntx_access - read data from memory lost because result fifo is not ready at time %0t", $time)));

    // Check that q_cntx_static read data X/Z values never occur
    logic sva_cond_q_cntx_static_rd_data_unknown;
    assign sva_cond_q_cntx_static_rd_data_unknown = io_mem_ctrl_rlan_q_cntx_static_intf.rd_vld & $isunknown(io_mem_ctrl_rlan_q_cntx_static_intf.rd_data);
    `ASSERTS_NEVER (assert_never_q_cntx_static_rd_data_unknown, sva_cond_q_cntx_static_rd_data_unknown, posedge clk, ~rst_n,
        `ERR_MSG ($psprintf("[RPS_ASSERTIONS] Error: cntx_access - memory q_cntx_static returned X/Z value on read data at time %0t", $time)));

    `endif


    //////////////
    // COVERAGE //
    //////////////

    `ifdef LANPE_SVCOV_ON
    `ifdef QC_LEAF

    // Coverage of flows

    covergroup cg_mem_accesses @(posedge clk);
        cov_mem_cntx_early_static_wr_ev        : coverpoint (mem_ctrl_csr_q_cntx_early_static_wr_ev);
        cov_mem_cntx_early_static_rd_ev        : coverpoint (mem_ctrl_csr_q_cntx_early_static_rd_ev);
        cov_mem_cntx_static_wr_ev              : coverpoint (mem_ctrl_csr_q_cntx_static_wr_ev);
        cov_mem_cntx_static_rd_ev              : coverpoint (mem_ctrl_csr_q_cntx_static_rd_ev);
        cov_mem_cntx_buffer_static_wr_ev       : coverpoint (mem_ctrl_csr_q_cntx_buffer_static_wr_ev);
        cov_mem_cntx_buffer_static_rd_ev       : coverpoint (mem_ctrl_csr_q_cntx_buffer_static_rd_ev);
        cov_mem_cntx_first_pkt_wr_ev           : coverpoint (mem_ctrl_csr_q_cntx_first_pkt_wr_ev);
        cov_mem_cntx_first_pkt_rd_ev           : coverpoint (mem_ctrl_csr_q_cntx_first_pkt_rd_ev);
        cov_mem_cntx_buffer_first_pkt_wr_ev    : coverpoint (mem_ctrl_csr_q_cntx_buffer_first_pkt_wr_ev);
        cov_mem_cntx_buffer_first_pkt_rd_ev    : coverpoint (mem_ctrl_csr_q_cntx_buffer_first_pkt_rd_ev);
        cov_mem_cntx_ring_head_wr_ev           : coverpoint (mem_ctrl_csr_q_cntx_ring_head_wr_ev);
        cov_mem_cntx_ring_head_rd_ev           : coverpoint (mem_ctrl_csr_q_cntx_ring_head_rd_ev);
    endgroup
    cg_mem_accesses cg_mem_accesses_inst = new();

    // Coverage of backpressurs

    covergroup cg_backpressures @(posedge clk);
        cov_mem_cntx_early_static_wr_bp        : coverpoint (io_mem_ctrl_csr_q_cntx_early_static_intf.wr_en & (~io_mem_ctrl_csr_q_cntx_early_static_intf.rdy));
        cov_mem_cntx_early_static_rd_bp        : coverpoint (io_mem_ctrl_csr_q_cntx_early_static_intf.rd_en & (~io_mem_ctrl_csr_q_cntx_early_static_intf.rdy));
        cov_mem_cntx_static_wr_bp              : coverpoint (io_mem_ctrl_csr_q_cntx_static_intf.wr_en & (~io_mem_ctrl_csr_q_cntx_static_intf.rdy));
        cov_mem_cntx_static_rd_bp              : coverpoint (io_mem_ctrl_csr_q_cntx_static_intf.rd_en & (~io_mem_ctrl_csr_q_cntx_static_intf.rdy));
        cov_mem_cntx_buffer_static_wr_bp       : coverpoint (io_mem_ctrl_csr_q_cntx_buffer_static_intf.wr_en & (~io_mem_ctrl_csr_q_cntx_buffer_static_intf.rdy));
        cov_mem_cntx_buffer_static_rd_bp       : coverpoint (io_mem_ctrl_csr_q_cntx_buffer_static_intf.rd_en & (~io_mem_ctrl_csr_q_cntx_buffer_static_intf.rdy));
        // cov_mem_cntx_first_pkt_wr_bp will not happen because wr_en is sent only after fixed rmw latency from rd_en & rd_rdy, which is equal between mem_ctrl clients
        // cov_mem_cntx_first_pkt_wr_bp        : coverpoint (io_mem_ctrl_csr_q_cntx_first_pkt_intf.wr_en & (~io_mem_ctrl_csr_q_cntx_first_pkt_intf.wr_rdy));
        cov_mem_cntx_first_pkt_rd_bp           : coverpoint (io_mem_ctrl_csr_q_cntx_first_pkt_intf.rd_en & (~io_mem_ctrl_csr_q_cntx_first_pkt_intf.rd_rdy));
        // cov_mem_cntx_buffer_first_pkt_wr_bp will not happen because wr_en is sent only after fixed rmw latency from rd_en & rd_rdy, which is equal between mem_ctrl clients
        // cov_mem_cntx_buffer_first_pkt_wr_bp : coverpoint (io_mem_ctrl_csr_q_cntx_buffer_first_pkt_intf.wr_en & (~io_mem_ctrl_csr_q_cntx_buffer_first_pkt_intf.wr_rdy));
        cov_mem_cntx_buffer_first_pkt_rd_bp    : coverpoint (io_mem_ctrl_csr_q_cntx_buffer_first_pkt_intf.rd_en & (~io_mem_ctrl_csr_q_cntx_buffer_first_pkt_intf.rd_rdy));
        cov_mem_cntx_ring_head_wr_bp           : coverpoint (io_mem_ctrl_csr_q_cntx_ring_head_intf.wr_en & (~io_mem_ctrl_csr_q_cntx_ring_head_intf.wr_rdy));
        cov_mem_cntx_ring_head_rd_bp           : coverpoint (io_mem_ctrl_csr_q_cntx_ring_head_intf.rd_en & (~io_mem_ctrl_csr_q_cntx_ring_head_intf.rd_rdy));
        cov_rlan_event_q_cntx_req_in_bp        : coverpoint (io_rlan_evq_cntx_req_intf.vld & (~io_rlan_evq_cntx_req_intf.rdy));
        cov_rlan_event_q_cntx_rslt_out_bp      : coverpoint (io_rlan_evq_cntx_rslt_intf.vld & (~io_rlan_evq_cntx_rslt_intf.rdy));
        cov_rlan_event_q_cntx_req_rslt_bp      : coverpoint (event_q_cntx_req_fifo_rd_vld & (~event_q_cntx_rslt_fifo_below_thr));
    endgroup
    cg_backpressures cg_backpressures_inst = new();

    `endif  // QC_LEAF
    `endif  // LANPE_SVCOV_ON


endmodule
