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

//------------------------------------------------------------------------------
//  Description :
//  -------------
//  PKB PBN Packet Input FIFOs
//------------------------------------------------------------------------------

module pkb_pbn_if 
  import ipu_pmd_pkg::*;
  import pkb_pkg::*;
  import pkb_regs_pkg::*;
  import pkb_reg_map_pkg::*;
#(
  parameter TS_HDR_SLL_DATA_FROM_MEM_WIDTH  = 5120724,
  parameter TS_HDR_SLL_DATA_TO_MEM_WIDTH    = 5120724,
  parameter TS_PMD_SLL_DATA_FROM_MEM_WIDTH  = 5120724,
  parameter TS_PMD_SLL_DATA_TO_MEM_WIDTH    = 5120724,
  parameter TS_HDR_SLL_DATA_FROM_CTL_WIDTH  = 5120724,
  parameter TS_HDR_SLL_DATA_TO_CTL_WIDTH    = 5120724,
  parameter TS_PMD_SLL_DATA_FROM_CTL_WIDTH  = 5120724,
  parameter TS_PMD_SLL_DATA_TO_CTL_WIDTH    = 5120724
)(
  //----------------------------------------------------------------------------
  // Clock and Resets
  //----------------------------------------------------------------------------
  input  logic                      core_clk,      // Core clock
  input  logic                      core_rst_n,    // Synchronized func reset
  
  //----------------------------------------------------------------------------
  // Traffic Shaper (TS) Interface
  //----------------------------------------------------------------------------
  input  ts_pkb_pkt_req_t           ts_pb_txpktdata,
  output logic                      pb_ts_txpktdata_tready,
  input  ts_pkb_pmd_req_t           ts_pb_txpmd,
  output logic                      pb_ts_txpmd_tready,
  
  // Packet Data Header (HDR) Credit Return
  output pkb_ts_hdr_cdt_t           pb_ts_txpktdatacdt,
  input  logic                      ts_pb_txpktdatacdt_mready,
  // Packet Meta-Data (PMD) Credit Return
  output pkb_ts_pmd_cdt_t           pb_ts_txpmdcdt,
  input  logic                      ts_pb_txpmdcdt_mready,
  
  //----------------------------------------------------------------------------
  // PBM Per host flow control
  //----------------------------------------------------------------------------
  input logic [PKB_NUM_HOST-1:0]    pbm_pbn_pmd_per_host_fc,
  input logic [PKB_NUM_HOST-1:0]    pbm_pbn_pmd_per_host_jb_fc,
  
  //----------------------------------------------------------------------------
  // Error Indications
  //----------------------------------------------------------------------------
  input  logic                      stop_and_scream,
  output logic                      ts_hdr_missing_sop_err,
  output logic                      ts_hdr_missing_eop_err,
  output logic                      ts_hdr_byte_len_ovf,
  output logic                      ts_pmd_missing_sop_err,
  output logic                      ts_pmd_missing_eop_err,
  
  output logic                      ts_hdr_sll_data_ecc_uncor_err,
  output logic                      ts_pmd_sll_data_ecc_uncor_err,
  
  //----------------------------------------------------------------------------
  // BOBs Interface
  //----------------------------------------------------------------------------
  input  logic                      fscan_clkungate,
  input  logic                      bob_en,
  
  input  logic                      ts_hdr_bob_fifo_freeze_in,
  output logic                      ts_hdr_bob_fifo_freeze_out,
  input  logic                      ts_pmd_bob_fifo_freeze_in,
  output logic                      ts_pmd_bob_fifo_freeze_out,
  
  input  pkb_bob_fifo_c_t           pbn_if_ts_hdr_bob_fifo_c,     
  output pkb_bob_fifo_rd_t          pbn_if_ts_hdr_bob_fifo_rd,
  input  pkb_bob_fifo_c_t           pbn_if_ts_pmd_bob_fifo_c,     
  output pkb_bob_fifo_rd_t          pbn_if_ts_pmd_bob_fifo_rd,
  
  //----------------------------------------------------------------------------
  // CSR Configurations
  //----------------------------------------------------------------------------
  input  logic                      pkb_mem_init_done,
  input  logic                      glpkb_autoload_done,
  input  logic [1:0]                pkb_pm_mode_isol_mode,
  
  input  glpkb_ts_pd_cred_t [PKB_NUM_HOST-1:0] glpkb_ts_pd_cred,
  input  glpkb_ts_pmd_cred_t [PKB_NUM_HOST-1:0] glpkb_ts_pmd_cred,
 
  //----------------------------------------------------------------------------
  // Header/PMD To PIP
  //---------------------------------------------------------------------------- 
  output logic                      o_ts_hdr_v,
  input  logic                      i_ts_hdr_e,
  output ts_pkb_pkt_req_data_t      o_ts_hdr,
  
  output logic                      o_ts_pmd_v,
  input  logic                      i_ts_pmd_e,
  output ts_pkb_pmd_req_data_t      o_ts_pmd,  
  output pkb_pmd_req_info_t         o_ts_pmd_info,
  
  //----------------------------------------------------------------------------
  // MGM
  //----------------------------------------------------------------------------
  input  logic [TS_HDR_SLL_DATA_FROM_MEM_WIDTH-1:0]     pif_ts_hdr_sll_data_from_mem,
  output logic [TS_HDR_SLL_DATA_TO_MEM_WIDTH-1:0]       pif_ts_hdr_sll_data_to_mem,
  input  logic [TS_PMD_SLL_DATA_FROM_MEM_WIDTH-1:0]     pif_ts_pmd_sll_data_from_mem,
  output logic [TS_PMD_SLL_DATA_TO_MEM_WIDTH-1:0]       pif_ts_pmd_sll_data_to_mem, 
                                                        
  input  logic [TS_HDR_SLL_DATA_FROM_CTL_WIDTH-1:0]     pif_ts_hdr_sll_data_from_ctl,
  output logic [TS_HDR_SLL_DATA_TO_CTL_WIDTH-1:0]       pif_ts_hdr_sll_data_to_ctl,
  input  logic [TS_PMD_SLL_DATA_FROM_CTL_WIDTH-1:0]     pif_ts_pmd_sll_data_from_ctl, 
  output logic [TS_PMD_SLL_DATA_TO_CTL_WIDTH-1:0]       pif_ts_pmd_sll_data_to_ctl, 

  //----------------------------------------------------------------------------
  // VISA
  //----------------------------------------------------------------------------
  output logic[33:0]                 visa_pkb_pbn_if
  
);

  /////////////////////////////////////////////////////////////////
  // Definitions
  /////////////////////////////////////////////////////////////////
  
  localparam TS_HDR_INPUT_FIFO_DEPTH    = 2;
  localparam TS_HDR_INPUT_FIFO_NB       = $clog2(TS_HDR_INPUT_FIFO_DEPTH+1);
  localparam TS_PMD_INPUT_FIFO_DEPTH    = 2;
  localparam TS_PMD_INPUT_FIFO_NB       = $clog2(TS_PMD_INPUT_FIFO_DEPTH+1);
  
  localparam TS_HDR_BOB_FIFO_DEPTH      = 8;
  localparam TS_HDR_BOB_FIFO_NB         = $clog2(TS_HDR_BOB_FIFO_DEPTH+1);
  localparam TS_PMD_BOB_FIFO_DEPTH      = 8;
  localparam TS_PMD_BOB_FIFO_NB         = $clog2(TS_PMD_BOB_FIFO_DEPTH+1);
  
  localparam TS_HDR_SLL_DEPTH           = 160;
  localparam TS_HDR_SLL_DEPTH_NB        = $clog2(TS_HDR_SLL_DEPTH+1);
  localparam TS_HDR_SLL_DMEM_LATENCY    = 2;    // SLL Data Memory Latency  
  localparam TS_HDR_SLL_PMEM_LATENCY    = 2;    // SLL Pointer Memory Latency
  localparam TS_HDR_SLL_DMEM_DATA_W     = $bits(ts_pkb_pkt_req_data_t);
  localparam TS_HDR_SLL_DMEM_DEPTH_W    = $clog2(TS_HDR_SLL_DEPTH);
  localparam TS_HDR_SLL_PMEM_DATA_W     = $clog2(TS_HDR_SLL_DEPTH);
  localparam TS_HDR_SLL_PMEM_DEPTH      = TS_HDR_SLL_DEPTH;
  localparam TS_HDR_SLL_PMEM_DEPTH_W    = $clog2(TS_HDR_SLL_DEPTH);
  
  localparam TS_PMD_SLL_DEPTH           = 160;
  localparam TS_PMD_SLL_DEPTH_NB        = $clog2(TS_PMD_SLL_DEPTH+1);
  localparam TS_PMD_SLL_DMEM_LATENCY    = 2;    // SLL Data Memory Latency  
  localparam TS_PMD_SLL_PMEM_LATENCY    = 2;    // SLL Pointer Memory Latency  
  localparam TS_PMD_SLL_DMEM_DATA_W     = $bits(ts_pkb_pmd_req_data_t);
  localparam TS_PMD_SLL_DMEM_DEPTH_W    = $clog2(TS_PMD_SLL_DEPTH);
  localparam TS_PMD_SLL_PMEM_DATA_W     = $clog2(TS_PMD_SLL_DEPTH);
  localparam TS_PMD_SLL_PMEM_DEPTH      = TS_PMD_SLL_DEPTH;
  localparam TS_PMD_SLL_PMEM_DEPTH_W    = $clog2(TS_PMD_SLL_DEPTH);
  
  localparam TS_HDR_OUTPUT_FIFO_DEPTH   = 2;
  localparam TS_HDR_OUTPUT_FIFO_NB      = $clog2(TS_HDR_OUTPUT_FIFO_DEPTH+1);
  localparam TS_PMD_OUTPUT_FIFO_DEPTH   = 2;
  localparam TS_PMD_OUTPUT_FIFO_NB      = $clog2(TS_PMD_OUTPUT_FIFO_DEPTH+1);
    
  localparam TS_PMD_ARB_IDX_FIFO_DEPTH  = 6;
  localparam TS_PMD_ARB_IDX_FIFO_NB     = $clog2(TS_PMD_ARB_IDX_FIFO_DEPTH+1);
  
  localparam PMD_RECORD_B_W             = $bits(pmd_record_t)/8;
  
  logic                                     ts_hdr_input_fifo_in_v;
  logic                                     ts_hdr_input_fifo_in_e; 
  ts_pkb_pkt_req_data_t                     ts_hdr_input_fifo_in;
  logic                                     ts_hdr_input_fifo_out_v;
  logic                                     ts_hdr_input_fifo_out_e; 
  ts_pkb_pkt_req_data_t                     ts_hdr_input_fifo_out;
  logic [TS_HDR_INPUT_FIFO_NB-1:0]          ts_hdr_input_fifo_out_fullness;
   
  logic                                     ts_hdr_input_fifo_out_trans;
  logic [MAX_HDR_SIZE_W-1:0]                pkt_byte_len;
  logic [MAX_HDR_SIZE_W-1:0]                pkt_byte_len_new; 
                                            
  logic                                     ts_hdr_bob_fifo_in_v;
  logic                                     ts_hdr_bob_fifo_in_e; 
  ts_pkb_pkt_req_data_t                     ts_hdr_bob_fifo_in;
  logic                                     ts_hdr_bob_fifo_out_v;
  logic                                     ts_hdr_bob_fifo_out_e; 
  ts_pkb_pkt_req_data_t                     ts_hdr_bob_fifo_out;
  logic [TS_HDR_BOB_FIFO_NB-1:0]            ts_hdr_bob_fifo_out_fullness;
                                            
  logic                                     ts_hdr_sll_in_v;
  logic [PKB_TS_PKT_TDEST_W-1:0]            ts_hdr_sll_in_idx;
  logic                                     ts_hdr_sll_in_full; 
  ts_pkb_pkt_req_data_t                     ts_hdr_sll_in;
  logic                                     ts_hdr_sll_out_v;
  logic [PKB_TS_PKT_TDEST_W-1:0]            ts_hdr_sll_out_idx;
  logic                                     ts_hdr_sll_out_e; 
  ts_pkb_pkt_req_data_t [PKB_NUM_HOST-1:0]  ts_hdr_sll_out;
  logic [TS_HDR_SLL_DEPTH_NB-1:0]           ts_hdr_sll_out_fullness;
  logic [PKB_NUM_HOST-1:0]                  ts_hdr_sll_out_empty;
  logic [TS_HDR_SLL_DEPTH_NB-1:0]           ts_hdr_sll_out_free_length_nc;
  logic [PKB_NUM_HOST-1:0][TS_HDR_SLL_DEPTH_NB-1:0] ts_hdr_sll_out_lists_length_nc;
  
  logic                                     ts_hdr_sll_data_mem_wr_en;   
  logic [TS_HDR_SLL_DMEM_DEPTH_W-1:0]       ts_hdr_sll_data_mem_wr_addr;
  logic [TS_HDR_SLL_DMEM_DATA_W-1:0]        ts_hdr_sll_data_mem_wr_data;
  logic                                     ts_hdr_sll_data_mem_rd_en;  
  logic                                     ts_hdr_sll_data_mem_rd_data_valid;
  logic [TS_HDR_SLL_DMEM_DEPTH_W-1:0]       ts_hdr_sll_data_mem_rd_addr;
  logic [TS_HDR_SLL_DMEM_DATA_W-1:0]        ts_hdr_sll_data_mem_rd_data; 
  logic                                     ts_hdr_sll_data_mem_init_done_nc;
  
  logic                                     ts_hdr_sll_list_mem_wr_en;   
  logic [TS_HDR_SLL_PMEM_DEPTH_W-1:0]       ts_hdr_sll_list_mem_wr_addr;
  logic [TS_HDR_SLL_PMEM_DATA_W-1:0]        ts_hdr_sll_list_mem_wr_data;
  logic                                     ts_hdr_sll_list_mem_rd_en;  
  logic                                     ts_hdr_sll_list_mem_rd_vld_nc;
  logic [TS_HDR_SLL_PMEM_DEPTH_W-1:0]       ts_hdr_sll_list_mem_rd_addr;
  logic [TS_HDR_SLL_PMEM_DATA_W-1:0]        ts_hdr_sll_list_mem_rd_data; 
  
  logic                                     ts_hdr_output_fifo_in_v;
  logic                                     ts_hdr_output_fifo_in_e; 
  ts_pkb_pkt_req_data_t                     ts_hdr_output_fifo_in;
  logic                                     ts_hdr_output_fifo_out_v;
  logic                                     ts_hdr_output_fifo_out_e; 
  ts_pkb_pkt_req_data_t                     ts_hdr_output_fifo_out;
  logic [TS_HDR_OUTPUT_FIFO_NB-1:0]         ts_hdr_output_fifo_out_fullness;
  
  logic                                     ts_hdr_cdt_ctrl_init_done;
  logic [PKB_NUM_HOST-1:0]                  ts_hdr_csr_cdt_en;
  logic [PKB_NUM_HOST-1:0][CSR_CREDIT_W-1:0] ts_hdr_csr_cdt;
  
  logic                                     ts_hdr_cdt_ctrl_in_v;
  logic                                     ts_hdr_cdt_ctrl_in_e;
  logic [PKB_TS_PKT_CREDITS_W-1:0]          ts_hdr_cdt_ctrl_in_data;
  logic [PKB_NUM_HOST_W-1:0]                ts_hdr_cdt_ctrl_in_id;
  
  logic                                     ts_hdr_cdt_ctrl_out_v;
  logic                                     ts_hdr_cdt_ctrl_out_e;
  logic [PKB_TS_PKT_CREDITS_W-1:0]          ts_hdr_cdt_ctrl_out_data;
  logic [PKB_NUM_HOST_W-1:0]                ts_hdr_cdt_ctrl_out_id;
  
  logic                                     ts_pmd_input_fifo_in_v;
  logic                                     ts_pmd_input_fifo_in_e; 
  ts_pkb_pmd_req_data_t                     ts_pmd_input_fifo_in;
  logic                                     ts_pmd_input_fifo_out_v;
  logic                                     ts_pmd_input_fifo_out_e; 
  ts_pkb_pmd_req_data_t                     ts_pmd_input_fifo_out;
  logic [TS_PMD_INPUT_FIFO_NB-1:0]          ts_pmd_input_fifo_out_fullness;
                                            
  logic                                     ts_pmd_bob_fifo_in_v;
  logic                                     ts_pmd_bob_fifo_in_e; 
  ts_pkb_pmd_req_data_t                     ts_pmd_bob_fifo_in;
  logic                                     ts_pmd_bob_fifo_out_v;
  logic                                     ts_pmd_bob_fifo_out_e; 
  ts_pkb_pmd_req_data_t                     ts_pmd_bob_fifo_out;
  logic [TS_PMD_BOB_FIFO_NB-1:0]            ts_pmd_bob_fifo_out_fullness;
  
  logic                                     ts_pmd_sll_in_v;
  logic [PKB_TS_PMD_TDEST_W-1:0]            ts_pmd_sll_in_idx;
  logic                                     ts_pmd_sll_in_full; 
  ts_pkb_pmd_req_data_t                     ts_pmd_sll_in;
  logic                                     ts_pmd_sll_out_v_nc;
  logic [PKB_TS_PMD_TDEST_W-1:0]            ts_pmd_sll_out_idx;
  logic                                     ts_pmd_sll_out_e; 
  ts_pkb_pmd_req_data_t [PKB_NUM_HOST-1:0]  ts_pmd_sll_out;
  logic [TS_PMD_SLL_DEPTH_NB-1:0]           ts_pmd_sll_out_fullness;
  logic [PKB_NUM_HOST-1:0]                  ts_pmd_sll_out_empty;
  logic [TS_PMD_SLL_DEPTH_NB-1:0]           ts_pmd_sll_out_free_length_nc;
  logic [PKB_NUM_HOST-1:0][TS_PMD_SLL_DEPTH_NB-1:0] ts_pmd_sll_out_lists_length_nc;
                                            
  logic                                     ts_pmd_sll_data_mem_wr_en;   
  logic [TS_PMD_SLL_DMEM_DEPTH_W-1:0]       ts_pmd_sll_data_mem_wr_addr;
  logic [TS_PMD_SLL_DMEM_DATA_W-1:0]        ts_pmd_sll_data_mem_wr_data;
  logic                                     ts_pmd_sll_data_mem_rd_en;  
  logic                                     ts_pmd_sll_data_mem_rd_data_valid;
  logic [TS_PMD_SLL_DMEM_DEPTH_W-1:0]       ts_pmd_sll_data_mem_rd_addr;
  logic [TS_PMD_SLL_DMEM_DATA_W-1:0]        ts_pmd_sll_data_mem_rd_data; 
  logic                                     ts_pmd_sll_data_mem_init_done_nc;
  
  logic                                     ts_pmd_sll_list_mem_wr_en;   
  logic [TS_PMD_SLL_PMEM_DEPTH_W-1:0]       ts_pmd_sll_list_mem_wr_addr;
  logic [TS_PMD_SLL_PMEM_DATA_W-1:0]        ts_pmd_sll_list_mem_wr_data;
  logic                                     ts_pmd_sll_list_mem_rd_en;  
  logic                                     ts_pmd_sll_list_mem_rd_vld_nc;
  logic [TS_PMD_SLL_PMEM_DEPTH_W-1:0]       ts_pmd_sll_list_mem_rd_addr;
  logic [TS_PMD_SLL_PMEM_DATA_W-1:0]        ts_pmd_sll_list_mem_rd_data; 
  
  logic [PKB_NUM_HOST-1:0]                  ts_pmd_arb_v;
  logic [PKB_NUM_HOST-1:0]                  ts_pmd_arb_sop;
  logic [PKB_NUM_HOST-1:0]                  ts_pmd_arb_eop;
  ts_pkb_pmd_req_data_t [PKB_NUM_HOST-1:0]  ts_pmd_arb_data;
  logic [PKB_NUM_HOST-1:0]                  ts_pmd_arb_e;
    
  logic                                     pmd_arb_winner_v;
  logic                                     pmd_arb_winner_e;
  logic                                     pmd_arb_winner_sop;
  logic                                     pmd_arb_winner_eop_nc;
  logic [PKB_NUM_HOST_W-1:0]                pmd_arb_winner_idx;
  ts_pkb_pmd_req_data_t                     pmd_arb_winner;
  
  logic [PKB_PMD_DATA_W*8-1:0]              pmd_arb_winner_sop_data;
  pmd_record_t                              pmd_arb_winner_record;
  pmd_common_t                              pmd_arb_winner_common;
  logic [MAX_PKT_SIZE_W-1:0]                pkt_len;
  logic [MAX_PMD_SIZE_W-1:0]                pmd_len;
  logic [TOTAL_MAX_SIZE_W-1:0]              occp_len;
  logic [TOTAL_MAX_SIZE_512B_W-1:0]         occp_len_512B;
  
  logic                                     ts_pmd_arb_idx_fifo_in_v;
  logic                                     ts_pmd_arb_idx_fifo_in_e; 
  logic [PKB_NUM_HOST_W-1:0]                ts_pmd_arb_idx_fifo_in;
  logic                                     ts_pmd_arb_idx_fifo_out_v;
  logic                                     ts_pmd_arb_idx_fifo_out_e; 
  logic [PKB_NUM_HOST_W-1:0]                ts_pmd_arb_idx_fifo_out;
  logic [TS_PMD_ARB_IDX_FIFO_NB-1:0]        ts_pmd_arb_idx_fifo_out_fullness;
  
  logic                                     ts_pmd_output_fifo_in_v;
  logic                                     ts_pmd_output_fifo_in_e; 
  ts_pkb_pmd_req_data_t                     ts_pmd_output_fifo_in;
  logic                                     ts_pmd_output_fifo_out_v;
  logic                                     ts_pmd_output_fifo_out_e; 
  ts_pkb_pmd_req_data_t                     ts_pmd_output_fifo_out;
  logic [TS_PMD_OUTPUT_FIFO_NB-1:0]         ts_pmd_output_fifo_out_fullness;

  pkb_pmd_req_info_t                        ts_pmd_output_info_fifo_in;
  pkb_pmd_req_info_t                        ts_pmd_output_info_fifo_out;
  
  logic                                     autoload_mem_init_done;
  logic                                     pm_fc_mode;
  logic                                     pm_nodrop_mode;
  
  logic                                     ts_pmd_cdt_ctrl_init_done;
  logic [PKB_NUM_HOST-1:0]                  ts_pmd_csr_cdt_en;
  logic [PKB_NUM_HOST-1:0][CSR_CREDIT_W-1:0] ts_pmd_csr_cdt;
  
  logic                                     ts_pmd_cdt_ctrl_in_v;
  logic                                     ts_pmd_cdt_ctrl_in_e;
  logic [PKB_TS_PMD_CREDITS_W-1:0]          ts_pmd_cdt_ctrl_in_data;
  logic [PKB_NUM_HOST_W-1:0]                ts_pmd_cdt_ctrl_in_id;
  
  logic                                     ts_pmd_cdt_ctrl_out_v;
  logic                                     ts_pmd_cdt_ctrl_out_e;
  logic [PKB_TS_PMD_CREDITS_W-1:0]          ts_pmd_cdt_ctrl_out_data;
  logic [PKB_NUM_HOST_W-1:0]                ts_pmd_cdt_ctrl_out_id;
  
  logic                                     pmd_arb_winner_marker;
  logic                                     pmd_arb_winner_marker_saved;
  logic                                     pmd_arb_winner_marker_final;
  
  /////////////////////////////////////////////////////////////////
  // TS Header Input FIFO
  /////////////////////////////////////////////////////////////////
  
  assign ts_hdr_input_fifo_in_v     = ts_pb_txpktdata.tvalid;
    
  assign ts_hdr_input_fifo_in.tdata = ts_pb_txpktdata.tdata;
  assign ts_hdr_input_fifo_in.tuser = ts_pb_txpktdata.tuser;
  assign ts_hdr_input_fifo_in.tdest = ts_pb_txpktdata.tdest;
  assign ts_hdr_input_fifo_in.tid   = ts_pb_txpktdata.tid;
  assign ts_hdr_input_fifo_in.tlast = ts_pb_txpktdata.tlast;
    
  assign pb_ts_txpktdata_tready     = ts_hdr_input_fifo_in_e & autoload_mem_init_done & ~stop_and_scream;
  
  ecip_gen_rdy_val_fifo_v1 #(
    .DEPTH          (TS_HDR_INPUT_FIFO_DEPTH),
    .WIDTH          ($bits(ts_pkb_pkt_req_data_t)),
    .NO_DMUX        (1),
    .CNGST_DIS      (0),    // Set to 0 in order to enable the congestion feature
    .MASK_W         (5),    // Congestion Mask #clocks
    .RELEASE_W      (5)     // Congestion Release #clocks
  ) ts_hdr_input_fifo (
    .clk            (core_clk),
    .rst_n          (core_rst_n),
    .clear          (1'b0),
    // Data In
    .vld_in         (ts_hdr_input_fifo_in_v),
    .wr_data        (ts_hdr_input_fifo_in),
    .rdy_out        (ts_hdr_input_fifo_in_e),
    // Data Out
    .vld_out        (ts_hdr_input_fifo_out_v), 
    .rdy_in         (ts_hdr_input_fifo_out_e),   
    .rd_data        (ts_hdr_input_fifo_out), 
    .used_space     (ts_hdr_input_fifo_out_fullness)
  );
  
  // TS Header Missing SOP/EOP Check
  pkb_missing_sop_eop_err u_hdr_missing_sop_eop_err (
    // Clock and Reset
    .core_clk           (core_clk),   // Core clock         
    .core_rst_n         (core_rst_n), // Synchronized reset 
    // AXI IF
    .tvalid             (ts_hdr_input_fifo_out_v),
    .tready             (ts_hdr_input_fifo_out_e),
    .tuser              (ts_hdr_input_fifo_out.tuser[0]),
    .tlast              (ts_hdr_input_fifo_out.tlast),
    // SOP/EOP error
    .missing_sop_err    (ts_hdr_missing_sop_err),
    .missing_eop_err    (ts_hdr_missing_eop_err)
  );
  
  // Illegal Packet Length Check in [B] Units
  assign ts_hdr_input_fifo_out_trans = ts_hdr_input_fifo_out_v & ts_hdr_input_fifo_out_e;
  
  always_ff @(posedge core_clk or negedge core_rst_n)
    if (!core_rst_n)                     pkt_byte_len <= '0;
    else if(ts_hdr_input_fifo_out_trans) pkt_byte_len <= pkt_byte_len_new;
  
  assign pkt_byte_len_new = (ts_hdr_input_fifo_out_trans & ts_hdr_input_fifo_out.tuser[0]) ? MAX_HDR_SIZE_W'(PKB_HDR_DATA_W) : // First Flit
                            (ts_hdr_input_fifo_out_trans & ts_hdr_input_fifo_out.tlast)    ? MAX_HDR_SIZE_W'(pkt_byte_len + ts_hdr_input_fifo_out.tuser[PKB_TS_PKT_TUSER_W-1:1]) : // Last Flit
                            (ts_hdr_input_fifo_out_trans)                                  ? MAX_HDR_SIZE_W'(pkt_byte_len + PKB_HDR_DATA_W) : // Non Last Flit
                                                                                             MAX_HDR_SIZE_W'(pkt_byte_len); // No Change
  
  assign ts_hdr_byte_len_ovf = pkt_byte_len_new > MAX_HDR_SIZE;
  
  /////////////////////////////////////////////////////////////////
  // TS Header BOB FIFO
  /////////////////////////////////////////////////////////////////
  
  assign ts_hdr_bob_fifo_in_v       = ts_hdr_input_fifo_out_v;
  assign ts_hdr_bob_fifo_in         = ts_hdr_input_fifo_out;
  assign ts_hdr_input_fifo_out_e    = ts_hdr_bob_fifo_in_e;
  
  ecip_gen_bob_fifo_v4 #(
    .DBG_RD_ALL     (0),
    .DBG_WR_EN      (0),
    .DEPTH          (TS_HDR_BOB_FIFO_DEPTH),         // Number of entries
    .WIDTH          ($bits(ts_pkb_pkt_req_data_t)),// Datapath width
    .SNF_EN         (1),
    .TRIG_WIDTH     ($bits(ts_pkb_pkt_req_data_t)),
    .CSR_WIDTH      (CSR_WIDTH),
    .CNGST_DIS      (0),    // Set to 0 in order to enable the congestion feature
    .MASK_W         (5),    // Congestion Mask #clocks
    .RELEASE_W      (5)     // Congestion Release #clocks            
  ) ts_hdr_bob_fifo (
    .clk              (core_clk),
    .rst_n            (core_rst_n),
    .te               (fscan_clkungate),            // test enable, need to be exposed to the functional top, to be connected by DFT
    .bob_en           (bob_en),                     // Security
    .clear            (1'b0),                       // Clears FIFO - it will become empty
    .used_space       (ts_hdr_bob_fifo_out_fullness), // Number of used entries in the FIFO
    // FIFO Data in
    .vld_in           (ts_hdr_bob_fifo_in_v),
    .wr_data          (ts_hdr_bob_fifo_in),         // Write data
    .wr_last          (ts_hdr_bob_fifo_in.tlast),   // Used only if S&F is activated, marks last cycle of multi-cycle transaction
    .rdy_out          (ts_hdr_bob_fifo_in_e),
    // FIFO Data out
    .vld_out          (ts_hdr_bob_fifo_out_v),
    .rd_data          (ts_hdr_bob_fifo_out),        // Read data
    .rdy_in           (ts_hdr_bob_fifo_out_e),
    // BOB
    .i_freeze         (ts_hdr_bob_fifo_freeze_in),  // Freeze from other source - freeze immediately
    .o_freeze         (ts_hdr_bob_fifo_freeze_out), // Freeze indication
    // Alternative common trigger input
    .common_trig_value({($bits(ts_pkb_pkt_req_data_t)){1'b0}}), // Used only if COMMON_TRIG==1
    .common_trig_mask ({($bits(ts_pkb_pkt_req_data_t)){1'b0}}), // Used only if COMMON_TRIG==1
    .trig_data        (ts_hdr_bob_fifo_in),         // Trigger data
    // CSR interface
    .i_csr_wr_req     (pbn_if_ts_hdr_bob_fifo_c.wen),                 
    .i_csr_rd_req     (pbn_if_ts_hdr_bob_fifo_c.ren),                 
    .i_csr_idx        (pbn_if_ts_hdr_bob_fifo_c.idx),                  
    .i_csr_wr_data    (pbn_if_ts_hdr_bob_fifo_c.wr_data.bob_data),    
    .o_csr_rd_data    (pbn_if_ts_hdr_bob_fifo_rd.rd_data.bob_data),   
    .o_csr_ack        (pbn_if_ts_hdr_bob_fifo_rd.ack)                
  );
  
  /////////////////////////////////////////////////////////////////
  // TS Header Linked List
  /////////////////////////////////////////////////////////////////
  
  assign ts_hdr_sll_in_v        = ts_hdr_bob_fifo_out_v & ~ts_hdr_sll_in_full;
  assign ts_hdr_sll_in_idx      = pm_fc_mode ? ts_hdr_bob_fifo_out.tdest : '0;
  assign ts_hdr_sll_in          = ts_hdr_bob_fifo_out;
  assign ts_hdr_bob_fifo_out_e  = ~ts_hdr_sll_in_full;
  
  ecip_gen_sll_ctl_v4 #(
    .WIDTH            (TS_HDR_SLL_DMEM_DATA_W), // Data width                                                                                            
    .DEPTH            (TS_HDR_SLL_DEPTH), // Total memory depth                                                                                    
    .LISTS            (PKB_NUM_HOST),     // Number of linked lists                                                                                
    .PREF_DATA        (1),                // Enables data pre-fetch, removes memory latency at cost of FFs                                         
    .DMEM_LATENCY     (TS_HDR_SLL_DMEM_LATENCY), // Data memory latency                                                                                   
    .PMEM_LATENCY     (TS_HDR_SLL_PMEM_LATENCY), // Pointer (list/free) memory latency                                                                    
    .FULL_TYPE        (0),                // 0 - Full on DEPTH entries, 
                                          // 1 - Full on empty free list (behaves differently in case of PREF_DATA = 1) 
    .FREE_PTR_FF      (1)                 // Lower the fanout for SLL with a lot of lists , wont work with FULL_TYPE = 1                       
  ) ts_hdr_sll (
    .clk              (core_clk),
    .rst_n            (core_rst_n),
    // Write          
    .wr_en            (ts_hdr_sll_in_v),
    .wr_idx           (ts_hdr_sll_in_idx),
    .wr_data          (ts_hdr_sll_in),
    .wr_full          (ts_hdr_sll_in_full),
    // Read           
    .rd_en            (ts_hdr_sll_out_e),
    .rd_idx           (ts_hdr_sll_out_idx),
    .rd_data          (ts_hdr_sll_out),   // Read data array, in case of no pre-fetch all indexes equal memory read data
    .rd_data_vld      (ts_hdr_sll_out_v), // Read data valid, only relevant when not using pre-fetch
    .rd_empty         (ts_hdr_sll_out_empty),
    // Data memory    
    .data_mem_wr_en   (ts_hdr_sll_data_mem_wr_en),    
    .data_mem_wr_addr (ts_hdr_sll_data_mem_wr_addr),  
    .data_mem_wr_data (ts_hdr_sll_data_mem_wr_data),  
    .data_mem_rd_en   (ts_hdr_sll_data_mem_rd_en),    
    .data_mem_rd_addr (ts_hdr_sll_data_mem_rd_addr),  
    .data_mem_rd_data (ts_hdr_sll_data_mem_rd_data),
    .data_mem_rd_vld  (ts_hdr_sll_data_mem_rd_data_valid), // Not used when pre-fetch is enabled
    // List pointers  memory
    .list_mem_wr_en   (ts_hdr_sll_list_mem_wr_en),
    .list_mem_wr_addr (ts_hdr_sll_list_mem_wr_addr),
    .list_mem_wr_data (ts_hdr_sll_list_mem_wr_data),
    .list_mem_rd_en   (ts_hdr_sll_list_mem_rd_en),
    .list_mem_rd_addr (ts_hdr_sll_list_mem_rd_addr),
    .list_mem_rd_data (ts_hdr_sll_list_mem_rd_data),
    // Status         
    .used_space       (ts_hdr_sll_out_fullness),    // Number of used entries across all sub-lists
    .free_length      (ts_hdr_sll_out_free_length_nc), // Length of the free list
    .lists_length     (ts_hdr_sll_out_lists_length_nc) // Length of all sub-lists
  );
  
  /////////////////////////////////////////////////////////////////
  // TS Header Select
  /////////////////////////////////////////////////////////////////
  
  assign ts_hdr_sll_out_e = pm_fc_mode ? ~ts_hdr_sll_out_empty[ts_pmd_arb_idx_fifo_out] & ts_pmd_arb_idx_fifo_out_v & ts_hdr_output_fifo_in_e & ts_hdr_cdt_ctrl_in_e : // Flow Control Mode
                                         |(~ts_hdr_sll_out_empty) & ts_hdr_output_fifo_in_e & ts_hdr_cdt_ctrl_in_e;
    
  assign ts_hdr_sll_out_idx = pm_fc_mode ? ts_pmd_arb_idx_fifo_out : 'h0;
  
  /////////////////////////////////////////////////////////////////
  // TS HDR Output FIFO
  /////////////////////////////////////////////////////////////////
  
  assign ts_hdr_output_fifo_in_v        = pm_fc_mode ? |(~ts_hdr_sll_out_empty[ts_hdr_sll_out_idx]) & ts_pmd_arb_idx_fifo_out_v :
                                                       |(~ts_hdr_sll_out_empty) ;
  assign ts_hdr_output_fifo_in.tdata    = ts_hdr_sll_out[ts_hdr_sll_out_idx].tdata;
  assign ts_hdr_output_fifo_in.tuser    = ts_hdr_sll_out[ts_hdr_sll_out_idx].tuser;
  assign ts_hdr_output_fifo_in.tdest    = ts_hdr_sll_out[ts_hdr_sll_out_idx].tdest;
  assign ts_hdr_output_fifo_in.tid      = ts_hdr_sll_out[ts_hdr_sll_out_idx].tid;
  assign ts_hdr_output_fifo_in.tlast    = ts_hdr_sll_out[ts_hdr_sll_out_idx].tlast;          
  
  ecip_gen_rdy_val_fifo_v1 #(
    .DEPTH          (TS_HDR_OUTPUT_FIFO_DEPTH),
    .WIDTH          ($bits(ts_pkb_pkt_req_data_t)),
    .NO_DMUX        (1),
    .CNGST_DIS      (0),    // Set to 0 in order to enable the congestion feature
    .MASK_W         (5),    // Congestion Mask #clocks
    .RELEASE_W      (5)     // Congestion Release #clocks
  ) ts_hdr_output_fifo (
    .clk            (core_clk),
    .rst_n          (core_rst_n),
    .clear          (1'b0),
    // Data In
    .vld_in         (ts_hdr_output_fifo_in_v),
    .wr_data        (ts_hdr_output_fifo_in),
    .rdy_out        (ts_hdr_output_fifo_in_e),
    // Data Out
    .vld_out        (ts_hdr_output_fifo_out_v), 
    .rdy_in         (ts_hdr_output_fifo_out_e),   
    .rd_data        (ts_hdr_output_fifo_out), 
    .used_space     (ts_hdr_output_fifo_out_fullness)
  );
  
  assign o_ts_hdr_v = ts_hdr_output_fifo_out_v & (ts_hdr_output_fifo_out.tlast | ts_hdr_output_fifo_out_fullness > 'd1);
  assign o_ts_hdr   = ts_hdr_output_fifo_out;
  assign ts_hdr_output_fifo_out_e = i_ts_hdr_e;
  
  /////////////////////////////////////////////////////////////////
  // TS PMD Input FIFO
  /////////////////////////////////////////////////////////////////
  
  assign ts_pmd_input_fifo_in_v     = ts_pb_txpmd.tvalid;
    
  assign ts_pmd_input_fifo_in.tdata = ts_pb_txpmd.tdata;
  assign ts_pmd_input_fifo_in.tuser = ts_pb_txpmd.tuser;
  assign ts_pmd_input_fifo_in.tdest = ts_pb_txpmd.tdest;
  assign ts_pmd_input_fifo_in.tid   = ts_pb_txpmd.tid;
  assign ts_pmd_input_fifo_in.tlast = ts_pb_txpmd.tlast;
    
  assign pb_ts_txpmd_tready         = ts_pmd_input_fifo_in_e & autoload_mem_init_done & ~stop_and_scream;
  
  ecip_gen_rdy_val_fifo_v1 #(
    .DEPTH          (TS_PMD_INPUT_FIFO_DEPTH),
    .WIDTH          ($bits(ts_pkb_pmd_req_data_t)),
    .NO_DMUX        (1),
    .CNGST_DIS      (0),    // Set to 0 in order to enable the congestion feature
    .MASK_W         (5),    // Congestion Mask #clocks
    .RELEASE_W      (5)     // Congestion Release #clocks
  ) ts_pmd_input_fifo (
    .clk            (core_clk),
    .rst_n          (core_rst_n),
    .clear          (1'b0),
    .vld_in         (ts_pmd_input_fifo_in_v),
    .wr_data        (ts_pmd_input_fifo_in),
    .rdy_out        (ts_pmd_input_fifo_in_e),
    .vld_out        (ts_pmd_input_fifo_out_v), 
    .rdy_in         (ts_pmd_input_fifo_out_e),   
    .rd_data        (ts_pmd_input_fifo_out), 
    .used_space     (ts_pmd_input_fifo_out_fullness)
  );
  
  // TS PMD Missing SOP/EOP Check
  pkb_missing_sop_eop_err ts_pmd_missing_sop_eop_err (
    // Clock and Reset
    .core_clk           (core_clk),     // Core clock
    .core_rst_n         (core_rst_n),   // Synchronized reset
    // AXI IF
    .tvalid             (ts_pmd_input_fifo_out_v),
    .tready             (ts_pmd_input_fifo_out_e),
    .tuser              (ts_pmd_input_fifo_out.tuser[0]),
    .tlast              (ts_pmd_input_fifo_out.tlast),
    // SOP/EOP error
    .missing_sop_err    (ts_pmd_missing_sop_err),
    .missing_eop_err    (ts_pmd_missing_eop_err)
  );
  
  /////////////////////////////////////////////////////////////////
  // TS PMD BOB FIFO
  /////////////////////////////////////////////////////////////////
  
  assign ts_pmd_bob_fifo_in_v       = ts_pmd_input_fifo_out_v;
  assign ts_pmd_bob_fifo_in         = ts_pmd_input_fifo_out;
  assign ts_pmd_input_fifo_out_e    = ts_pmd_bob_fifo_in_e;
  
  ecip_gen_bob_fifo_v4 #(
    .DBG_RD_ALL     (0),
    .DBG_WR_EN      (0),
    .DEPTH          (TS_PMD_BOB_FIFO_DEPTH),        // Number of entries
    .WIDTH          ($bits(ts_pkb_pmd_req_data_t)), // Datapath width
    .SNF_EN         (1),
    .TRIG_WIDTH     ($bits(ts_pkb_pmd_req_data_t)),
    .CSR_WIDTH      (CSR_WIDTH),
    .CNGST_DIS      (0),    // Set to 0 in order to enable the congestion feature
    .MASK_W         (5),    // Congestion Mask #clocks
    .RELEASE_W      (5)     // Congestion Release #clocks            
  ) ts_pmd_bob_fifo (
    .clk              (core_clk),
    .rst_n            (core_rst_n),
    .te               (fscan_clkungate),            // test enable, need to be exposed to the functional top, to be connected by DFT
    .bob_en           (bob_en),                     // Security
    .clear            (1'b0),                       // Clears FIFO - it will become empty
    .used_space       (ts_pmd_bob_fifo_out_fullness), // Number of used entries in the FIFO
    // FIFO Data in
    .vld_in           (ts_pmd_bob_fifo_in_v),
    .wr_data          (ts_pmd_bob_fifo_in),         // Write data
    .wr_last          (ts_pmd_bob_fifo_in.tlast),   // Used only if S&F is activated, marks last cycle of multi-cycle transaction
    .rdy_out          (ts_pmd_bob_fifo_in_e),
    // FIFO Data out
    .vld_out          (ts_pmd_bob_fifo_out_v),
    .rd_data          (ts_pmd_bob_fifo_out),        // Read data
    .rdy_in           (ts_pmd_bob_fifo_out_e),
    // BOB
    .i_freeze         (ts_pmd_bob_fifo_freeze_in),  // Freeze from other source - freeze immediately
    .o_freeze         (ts_pmd_bob_fifo_freeze_out), // Freeze indication
    // Alternative common trigger input
    .common_trig_value({($bits(ts_pkb_pmd_req_data_t)){1'b0}}), // Used only if COMMON_TRIG==1
    .common_trig_mask ({($bits(ts_pkb_pmd_req_data_t)){1'b0}}), // Used only if COMMON_TRIG==1
    .trig_data        (ts_pmd_bob_fifo_in),         // Trigger data
    // CSR interface
    .i_csr_wr_req     (pbn_if_ts_pmd_bob_fifo_c.wen),                 
    .i_csr_rd_req     (pbn_if_ts_pmd_bob_fifo_c.ren),                 
    .i_csr_idx        (pbn_if_ts_pmd_bob_fifo_c.idx),                 
    .i_csr_wr_data    (pbn_if_ts_pmd_bob_fifo_c.wr_data.bob_data),    
    .o_csr_rd_data    (pbn_if_ts_pmd_bob_fifo_rd.rd_data.bob_data),   
    .o_csr_ack        (pbn_if_ts_pmd_bob_fifo_rd.ack)                
  );
  
  /////////////////////////////////////////////////////////////////
  // Autoload Done
  /////////////////////////////////////////////////////////////////
  
  always_ff @(posedge core_clk or negedge core_rst_n)
    if (!core_rst_n)    autoload_mem_init_done <= 1'b0; 
    else                autoload_mem_init_done <= glpkb_autoload_done & pkb_mem_init_done;
  
  /////////////////////////////////////////////////////////////////
  // PM Isolation Mode
  /////////////////////////////////////////////////////////////////
  
  // Flow Control Mode (Broad Market Mode)
  always_ff @(posedge core_clk or negedge core_rst_n)
    if (!core_rst_n)    pm_fc_mode <= 1'b0; 
    else                pm_fc_mode <= (pkb_pm_mode_isol_mode == 'd1);
  
  // Drop Mode (Custom Mode)
  always_ff @(posedge core_clk or negedge core_rst_n)
    if (!core_rst_n)    pm_nodrop_mode <= 1'b0; 
    else                pm_nodrop_mode <= (pkb_pm_mode_isol_mode == 'd2);
  
  /////////////////////////////////////////////////////////////////
  // TS PMD Linked List
  /////////////////////////////////////////////////////////////////
  
  assign ts_pmd_sll_in_v        = ts_pmd_bob_fifo_out_v & ~ts_pmd_sll_in_full;
  assign ts_pmd_sll_in_idx      = pm_fc_mode ? ts_pmd_bob_fifo_out.tdest : '0;
  assign ts_pmd_sll_in          = ts_pmd_bob_fifo_out;
  assign ts_pmd_bob_fifo_out_e  = ~ts_pmd_sll_in_full;
  
  ecip_gen_sll_ctl_v4 #(
    .WIDTH            (TS_PMD_SLL_DMEM_DATA_W), // Data width                                                                                            
    .DEPTH            (TS_PMD_SLL_DEPTH), // Total memory depth                                                                                    
    .LISTS            (PKB_NUM_HOST),     // Number of linked lists                                                                                
    .PREF_DATA        (1),                // Enables data pre-fetch, removes memory latency at cost of FFs                                         
    .DMEM_LATENCY     (TS_PMD_SLL_DMEM_LATENCY), // Data memory latency                                                                                   
    .PMEM_LATENCY     (TS_PMD_SLL_PMEM_LATENCY), // Pointer (list/free) memory latency                                                                    
    .FULL_TYPE        (0),                // 0 - Full on DEPTH entries, 
                                          // 1 - Full on empty free list (behaves differently in case of PREF_DATA = 1) 
    .FREE_PTR_FF      (1)                 // Lower the fanout for SLL with a lot of lists , wont work with FULL_TYPE = 1                       
  ) ts_pmd_sll (
    .clk              (core_clk),
    .rst_n            (core_rst_n),
    // Write          
    .wr_en            (ts_pmd_sll_in_v),
    .wr_idx           (ts_pmd_sll_in_idx),
    .wr_data          (ts_pmd_sll_in),
    .wr_full          (ts_pmd_sll_in_full),
    // Read           
    .rd_en            (ts_pmd_sll_out_e),
    .rd_idx           (ts_pmd_sll_out_idx),
    .rd_data          (ts_pmd_sll_out),   // Read data array, in case of no pre-fetch all indexes equal memory read data
    .rd_data_vld      (ts_pmd_sll_out_v_nc), // Read data valid, only relevant when not using pre-fetch
    .rd_empty         (ts_pmd_sll_out_empty),
    // Data memory    
    .data_mem_wr_en   (ts_pmd_sll_data_mem_wr_en),   
    .data_mem_wr_addr (ts_pmd_sll_data_mem_wr_addr), 
    .data_mem_wr_data (ts_pmd_sll_data_mem_wr_data), 
    .data_mem_rd_en   (ts_pmd_sll_data_mem_rd_en),   
    .data_mem_rd_addr (ts_pmd_sll_data_mem_rd_addr), 
    .data_mem_rd_data (ts_pmd_sll_data_mem_rd_data), 
    .data_mem_rd_vld  (ts_pmd_sll_data_mem_rd_data_valid), // Not used when pre-fetch is enabled
    // List pointers  memory
    .list_mem_wr_en   (ts_pmd_sll_list_mem_wr_en),
    .list_mem_wr_addr (ts_pmd_sll_list_mem_wr_addr),
    .list_mem_wr_data (ts_pmd_sll_list_mem_wr_data),
    .list_mem_rd_en   (ts_pmd_sll_list_mem_rd_en),
    .list_mem_rd_addr (ts_pmd_sll_list_mem_rd_addr),
    .list_mem_rd_data (ts_pmd_sll_list_mem_rd_data),
    // Status         
    .used_space       (ts_pmd_sll_out_fullness),    // Number of used entries across all sub-lists
    .free_length      (ts_pmd_sll_out_free_length_nc), // Length of the free list
    .lists_length     (ts_pmd_sll_out_lists_length_nc) // Length of all sub-lists
  );
  
  /////////////////////////////////////////////////////////////////
  // TS PMD ARB
  /////////////////////////////////////////////////////////////////
  
  assign ts_pmd_arb_v       = (pm_fc_mode | pm_nodrop_mode) ? 
                              ~ts_pmd_sll_out_empty & ~pbm_pbn_pmd_per_host_fc & ~pbm_pbn_pmd_per_host_jb_fc : // Flow Control at Broad Market Mode
                              ~ts_pmd_sll_out_empty; // No Flow Control
  assign ts_pmd_arb_data    = ts_pmd_sll_out;
  
  always_comb begin
    for (int i=0; i<PKB_NUM_HOST; i++) begin
      ts_pmd_arb_sop[i] = ts_pmd_sll_out[i].tuser[0];
      ts_pmd_arb_eop[i] = ts_pmd_sll_out[i].tlast;
    end
  end
  
  assign ts_pmd_sll_out_e   = |ts_pmd_arb_e;
  assign ts_pmd_sll_out_idx = pmd_arb_winner_idx;
  
  ecip_gen_trans_arb_v1 #(
    .CLIENT_N           (PKB_NUM_HOST),
    .DATA_W             ($bits(ts_pkb_pmd_req_data_t)),
    .SAMP_IN            (0),
    .SAMP_OUT           (0),
    .CNGST_DIS          (1),
    .MASK_W             (5),
    .RELEASE_W          (5)
  ) ts_pmd_arb (
    .clk                (core_clk),
    .rst_n              (core_rst_n),
    // Clients request
    .client_vld         (ts_pmd_arb_v),
    .client_first       (ts_pmd_arb_sop), // Not used - yet still exists for some reason
    .client_last        (ts_pmd_arb_eop),
    .client_data        (ts_pmd_arb_data),
    .client_prior       (PKB_NUM_HOST'(1'b0)),
    .client_rdy         (ts_pmd_arb_e),
    // Output winner
    .trans_vld          (pmd_arb_winner_v),
    .trans_first        (pmd_arb_winner_sop),
    .trans_last         (pmd_arb_winner_eop_nc),
    .trans_data         (pmd_arb_winner),
    .trans_src          (pmd_arb_winner_idx),
    .trans_rdy          (pmd_arb_winner_e)
  );
  
  /////////////////////////////////////////////////////////////////
  // Calculate Packet Length
  /////////////////////////////////////////////////////////////////
  
  assign pmd_arb_winner_sop_data = pmd_arb_winner_sop ? pmd_arb_winner.tdata : '0;
  assign {pmd_arb_winner_common, pmd_arb_winner_record} = pmd_arb_winner_sop_data;
  
  assign pkt_len        = (pmd_arb_winner_common.flags.drop | pmd_arb_winner_common.flags.xlr_drop) ? MAX_PKT_SIZE_W'(pmd_arb_winner.tuser[PKB_TS_PMD_TUSER_W-1:1]) : 
                                                                                                      pmd_arb_winner_common.pkt_byte_cnt.pkt_byte_cnt;
  assign pmd_len        = MAX_PMD_SIZE_W'((pmd_arb_winner_record.offset_ext[4] << 3) + PMD_RECORD_B_W); // Byte Resolution
  assign occp_len       = pkt_len + pmd_len;
  assign occp_len_512B  = TOTAL_MAX_SIZE_512B_W'(occp_len[TOTAL_MAX_SIZE_W-1:9] + |occp_len[9-1:0]); // 512B Resolution
  
  /////////////////////////////////////////////////////////////////
  // TS PMD Output FIFO
  /////////////////////////////////////////////////////////////////
  
  assign ts_pmd_output_fifo_in_v            = pmd_arb_winner_v & (ts_pmd_cdt_ctrl_in_e & ts_pmd_arb_idx_fifo_in_e); // pmd_arb_winner_v & pmd_arb_winner_e
  assign ts_pmd_output_fifo_in.tdata        = pmd_arb_winner.tdata;
  assign ts_pmd_output_fifo_in.tuser        = pmd_arb_winner.tuser;
  assign ts_pmd_output_fifo_in.tdest        = pmd_arb_winner.tdest;
  assign ts_pmd_output_fifo_in.tid          = pmd_arb_winner.tid;
  assign ts_pmd_output_fifo_in.tlast        = pmd_arb_winner.tlast;
  
  assign ts_pmd_output_info_fifo_in.pkt_len         = pkt_len;
  assign ts_pmd_output_info_fifo_in.pmd_len         = pmd_len;
  assign ts_pmd_output_info_fifo_in.occp_len_512B   = occp_len_512B;
  
  assign pmd_arb_winner_e                   = ts_pmd_output_fifo_in_e & ts_pmd_cdt_ctrl_in_e & ts_pmd_arb_idx_fifo_in_e;           
  
  ecip_gen_rdy_val_fifo_v1 #(
    .DEPTH          (TS_PMD_OUTPUT_FIFO_DEPTH),
    .WIDTH          ($bits(ts_pkb_pmd_req_data_t)+$bits(pkb_pmd_req_info_t)),
    .NO_DMUX        (1),
    .CNGST_DIS      (0),    // Set to 0 in order to enable the congestion feature
    .MASK_W         (5),    // Congestion Mask #clocks
    .RELEASE_W      (5)     // Congestion Release #clocks
  ) ts_pmd_output_fifo (
    .clk            (core_clk),
    .rst_n          (core_rst_n),
    .clear          (1'b0),
    // Data In
    .vld_in         (ts_pmd_output_fifo_in_v),
    .wr_data        ({ts_pmd_output_info_fifo_in, ts_pmd_output_fifo_in}),
    .rdy_out        (ts_pmd_output_fifo_in_e),
    // Data Out
    .vld_out        (ts_pmd_output_fifo_out_v), 
    .rd_data        ({ts_pmd_output_info_fifo_out, ts_pmd_output_fifo_out}), 
    .rdy_in         (ts_pmd_output_fifo_out_e),
    .used_space     (ts_pmd_output_fifo_out_fullness)
  );
  
  assign o_ts_pmd_v     = ts_pmd_output_fifo_out_v;
  assign o_ts_pmd       = ts_pmd_output_fifo_out;
  assign o_ts_pmd_info  = ts_pmd_output_info_fifo_out;
  assign ts_pmd_output_fifo_out_e = i_ts_pmd_e;
  
  /////////////////////////////////////////////////////////////////
  // Store TS PMD ARB Winner Index
  /////////////////////////////////////////////////////////////////
  ipu_pmd_pkg::pmd_common_t     pmd_arb_winner_pmd_common;
  logic                         pmd_arb_winner_is_marker;
  assign pmd_arb_winner_pmd_common = pmd_arb_winner.tdata[(ipu_pmd_pkg::W_PMD_TYPE_PRES*8) +: (ipu_pmd_pkg::W_PMD_COMMON*8)];
  assign pmd_arb_winner_is_marker = pmd_arb_winner_pmd_common.flags.pkt_type == pmd_common_pkt_type_t'('d3);
  assign ts_pmd_arb_idx_fifo_in_v   = pm_fc_mode & pmd_arb_winner_v & pmd_arb_winner_sop & ~pmd_arb_winner_is_marker & (ts_pmd_output_fifo_in_e & ts_pmd_cdt_ctrl_in_e); // & pmd_arb_winner_e ;
  assign ts_pmd_arb_idx_fifo_in     = pmd_arb_winner_idx;
  
  ecip_gen_rdy_val_fifo_v1 #(
    .DEPTH          (TS_PMD_ARB_IDX_FIFO_DEPTH),
    .WIDTH          (PKB_NUM_HOST_W),
    .NO_DMUX        (1),
    .CNGST_DIS      (0),    // Set to 0 in order to enable the congestion feature
    .MASK_W         (5),    // Congestion Mask #clocks
    .RELEASE_W      (5)     // Congestion Release #clocks
  ) ts_pmd_arb_idx_fifo (
    .clk            (core_clk),
    .rst_n          (core_rst_n),
    .clear          (1'b0),
    // Data In
    .vld_in         (ts_pmd_arb_idx_fifo_in_v),
    .wr_data        (ts_pmd_arb_idx_fifo_in),
    .rdy_out        (ts_pmd_arb_idx_fifo_in_e),
    // Data Out
    .vld_out        (ts_pmd_arb_idx_fifo_out_v), 
    .rd_data        (ts_pmd_arb_idx_fifo_out),   
    .rdy_in         (ts_pmd_arb_idx_fifo_out_e),
    .used_space     (ts_pmd_arb_idx_fifo_out_fullness)
  );
  
  assign ts_pmd_arb_idx_fifo_out_e = pm_fc_mode & ts_hdr_sll_out_v & ts_hdr_output_fifo_in_e & ts_pmd_arb_idx_fifo_out_v & ts_hdr_sll_out[ts_pmd_arb_idx_fifo_out].tlast & ts_hdr_sll_out_e;
  
  /////////////////////////////////////////////////////////////////
  // TS Data Credit Return Interface
  /////////////////////////////////////////////////////////////////
  
  always_comb begin
    for (int i=0; i<PKB_NUM_HOST; i++) begin
      ts_hdr_csr_cdt_en[i] = |glpkb_ts_pd_cred[i].credits;
      ts_hdr_csr_cdt[i] = glpkb_ts_pd_cred[i].credits;
    end
  end
  
  assign ts_hdr_cdt_ctrl_in_v       = ts_hdr_output_fifo_in_v & ts_hdr_output_fifo_in_e & pm_fc_mode;
  assign ts_hdr_cdt_ctrl_in_data    = 'd1;
  assign ts_hdr_cdt_ctrl_in_id      = ts_hdr_sll_out_idx;
  
  ecip_gen_master_cdt_ctrl_v1 #(
    .NUM_OF_CLIENTS     (PKB_NUM_HOST), // Number of Hosts/ODs
    .MAX_CREDITS        (PKB_TS_PKT_MAX_CREDITS),
    .CSR_CREDIT_W       (CSR_CREDIT_W),
    .INIT_DELAY         (1),            // Delay Latency for Init Phase after autoload_done        
    .READY_CREDIT_RESET (1)             // Reset Credits if ready is deasserted
  ) ts_hdr_cdt_ctrl (
    .clk                (core_clk),
    .rst_n              (core_rst_n),
    // Input interface
    .i_cdt_v            (ts_hdr_cdt_ctrl_in_v),
    .i_cdt_data         (ts_hdr_cdt_ctrl_in_data),
    .i_cdt_id           (ts_hdr_cdt_ctrl_in_id),
    .o_cdt_rdy          (ts_hdr_cdt_ctrl_in_e),
    // Output interface
    .o_cdt_v            (ts_hdr_cdt_ctrl_out_v),
    .o_cdt_data         (ts_hdr_cdt_ctrl_out_data),
    .o_cdt_id           (ts_hdr_cdt_ctrl_out_id),
    .i_cdt_rdy          (ts_hdr_cdt_ctrl_out_e),
    // Indications
    .autoload_done      (glpkb_autoload_done),
    .cdt_init_done      (ts_hdr_cdt_ctrl_init_done),
    // CSR Configurations
    .csr_cdt_en         (ts_hdr_csr_cdt_en),
    .csr_cdt            (ts_hdr_csr_cdt)
  );
  
  assign pb_ts_txpktdatacdt.tvalid  = ts_hdr_cdt_ctrl_out_v;
  assign pb_ts_txpktdatacdt.tdata   = ts_hdr_cdt_ctrl_out_data;
  assign pb_ts_txpktdatacdt.tdest   = ts_hdr_cdt_ctrl_out_id;
  assign ts_hdr_cdt_ctrl_out_e      = ts_pb_txpktdatacdt_mready;
  
  /////////////////////////////////////////////////////////////////
  // TS PMD Credit Return Interface
  /////////////////////////////////////////////////////////////////
  
  always_comb begin
    for (int i=0; i<PKB_NUM_HOST; i++) begin
      ts_pmd_csr_cdt_en[i] = |glpkb_ts_pmd_cred[i].credits;
      ts_pmd_csr_cdt[i] = glpkb_ts_pmd_cred[i].credits;
    end
  end
  
  // Marker Packet
  assign pmd_arb_winner_marker = (pmd_arb_winner_common.flags.pkt_type == PMD_COMMON_PKT_TYPE_MARKER);
  
  always_ff @(posedge core_clk)
    if (pmd_arb_winner_v & pmd_arb_winner_sop & pmd_arb_winner_e) pmd_arb_winner_marker_saved <= pmd_arb_winner_marker;
    
  assign pmd_arb_winner_marker_final = pmd_arb_winner_sop ? pmd_arb_winner_marker : pmd_arb_winner_marker_saved;
  
  assign ts_pmd_cdt_ctrl_in_v       = pmd_arb_winner_v & pm_fc_mode & ~pmd_arb_winner_marker_final & (ts_pmd_output_fifo_in_e & ts_pmd_arb_idx_fifo_in_e); // & pmd_arb_winner_e 
  assign ts_pmd_cdt_ctrl_in_data    = 'd1;
  assign ts_pmd_cdt_ctrl_in_id      = pmd_arb_winner_idx;
  
  ecip_gen_master_cdt_ctrl_v1 #(
    .NUM_OF_CLIENTS     (PKB_NUM_HOST), // Number of Hosts/ODs
    .MAX_CREDITS        (PKB_TS_PMD_MAX_CREDITS),
    .CSR_CREDIT_W       (CSR_CREDIT_W),
    .INIT_DELAY         (1),            // Delay Latency for Init Phase after autoload_done        
    .READY_CREDIT_RESET (1)             // Reset Credits if ready is deasserted
  ) ts_pmd_cdt_ctrl (
    .clk                (core_clk),
    .rst_n              (core_rst_n),
    // Input interface
    .i_cdt_v            (ts_pmd_cdt_ctrl_in_v),
    .i_cdt_data         (ts_pmd_cdt_ctrl_in_data),
    .i_cdt_id           (ts_pmd_cdt_ctrl_in_id),
    .o_cdt_rdy          (ts_pmd_cdt_ctrl_in_e),
    // Output interface
    .o_cdt_v            (ts_pmd_cdt_ctrl_out_v),
    .o_cdt_data         (ts_pmd_cdt_ctrl_out_data),
    .o_cdt_id           (ts_pmd_cdt_ctrl_out_id),
    .i_cdt_rdy          (ts_pmd_cdt_ctrl_out_e),
    // Indications
    .autoload_done      (glpkb_autoload_done),
    .cdt_init_done      (ts_pmd_cdt_ctrl_init_done),
    // CSR Configurations
    .csr_cdt_en         (ts_pmd_csr_cdt_en),
    .csr_cdt            (ts_pmd_csr_cdt)
  );
  
  assign pb_ts_txpmdcdt.tvalid  = ts_pmd_cdt_ctrl_out_v;
  assign pb_ts_txpmdcdt.tdata   = ts_pmd_cdt_ctrl_out_data;
  assign pb_ts_txpmdcdt.tdest   = ts_pmd_cdt_ctrl_out_id;
  assign ts_pmd_cdt_ctrl_out_e  = ts_pb_txpmdcdt_mready;
  
  /////////////////////////////////////////////////////////////////
  // VISA
  /////////////////////////////////////////////////////////////////
  
  logic [33:0] visa_pkb_pbn_if_pre;
    
  always_ff @(posedge core_clk or negedge core_rst_n)
    if (!core_rst_n)    visa_pkb_pbn_if <= '0;
    else                visa_pkb_pbn_if <= visa_pkb_pbn_if_pre;
    
  assign visa_pkb_pbn_if_pre[ 1: 0] = ts_hdr_input_fifo_out_fullness;
  assign visa_pkb_pbn_if_pre[ 5: 2] = ts_hdr_bob_fifo_out_fullness;
  assign visa_pkb_pbn_if_pre[13: 6] = ts_hdr_sll_out_fullness;
  assign visa_pkb_pbn_if_pre[15:14] = ts_hdr_output_fifo_out_fullness;
  
  assign visa_pkb_pbn_if_pre[17:16] = ts_pmd_input_fifo_out_fullness;
  assign visa_pkb_pbn_if_pre[21:18] = ts_pmd_bob_fifo_out_fullness;
  assign visa_pkb_pbn_if_pre[29:22] = ts_pmd_sll_out_fullness;
  assign visa_pkb_pbn_if_pre[31:30] = ts_pmd_output_fifo_out_fullness;
    
  assign visa_pkb_pbn_if_pre[32:32] = ts_hdr_cdt_ctrl_init_done;
  assign visa_pkb_pbn_if_pre[33:33] = ts_pmd_cdt_ctrl_init_done;

  /////////////////////////////////////////////////////////////////
  // Memory Shells Instances
  /////////////////////////////////////////////////////////////////
  
  // Header SLL Memories
  pkb_mem_pbn_if_ts_hdr_sll_data_shell_160x1045 u_pkb_mem_pbn_if_ts_hdr_sll_data_shell_160x1045 (
    // Clock and Reset
    .rd_clk                                         (core_clk),
    .wr_clk                                         (core_clk),
    .rd_reset_n                                     (core_rst_n),
    .wr_reset_n                                     (core_rst_n),
    // Functional Interface                         
    .wr_en                                          (ts_hdr_sll_data_mem_wr_en),         
    .wr_adr                                         (ts_hdr_sll_data_mem_wr_addr),       
    .wr_data                                        (ts_hdr_sll_data_mem_wr_data),       
    .rd_en                                          (ts_hdr_sll_data_mem_rd_en),         
    .rd_adr                                         (ts_hdr_sll_data_mem_rd_addr),       
    .rd_data                                        (ts_hdr_sll_data_mem_rd_data),       
    .rd_valid                                       (ts_hdr_sll_data_mem_rd_data_valid), 
    .init_done                                      (ts_hdr_sll_data_mem_init_done_nc),     
    // ECC Interface                                
    .ecc_uncor_err                                  (ts_hdr_sll_data_ecc_uncor_err), 
    // Memory Wrap Interface
    .pkb_pbn_top_pbn_if_ts_hdr_sll_data_from_mem    (pif_ts_hdr_sll_data_from_mem),
    .pkb_pbn_top_pbn_if_ts_hdr_sll_data_to_mem      (pif_ts_hdr_sll_data_to_mem),  
    // Gen CTR Interface                                                           
    .pkb_pbn_top_pbn_if_ts_hdr_sll_data_from_ctl    (pif_ts_hdr_sll_data_from_ctl),
    .pkb_pbn_top_pbn_if_ts_hdr_sll_data_to_ctl      (pif_ts_hdr_sll_data_to_ctl),  
    // Dyn Light Sleep
    .mem_ls_enter                                   (1'b0)
  );

  ecip_gen_dual_port_ram_v2 #(
    .DW         (TS_HDR_SLL_PMEM_DATA_W),  // Data width                                                
    .DEPTH      (TS_HDR_SLL_PMEM_DEPTH),   // Memory depth                                              
    .DELAY      (TS_HDR_SLL_PMEM_LATENCY), // Memory latency                                            
    .DO_INIT    (0)                        // Set to initialize memory upon reset - currently only 0's  
  ) ts_hdr_sll_list_mem (
    // Clocks & reset
    .wr_clk     (core_clk),
    .rd_clk     (core_clk),
    .wr_rst_n   (core_rst_n),
    .rd_rst_n   (core_rst_n),
    // Write interface
    .wr_en      (ts_hdr_sll_list_mem_wr_en),
    .wr_addr    (ts_hdr_sll_list_mem_wr_addr),
    .wr_data    (ts_hdr_sll_list_mem_wr_data),
    // Read interface
    .rd_en      (ts_hdr_sll_list_mem_rd_en),
    .rd_addr    (ts_hdr_sll_list_mem_rd_addr),
    .rd_vld     (ts_hdr_sll_list_mem_rd_vld_nc),
    .rd_data    (ts_hdr_sll_list_mem_rd_data)
  );
  
  // PMD SLL Memories
  pkb_mem_pbn_if_ts_pmd_sll_data_shell_160x535 ts_pmd_sll_data (
    // clock and reset
    .rd_clk                                         (core_clk),  
    .wr_clk                                         (core_clk),  
    .rd_reset_n                                     (core_rst_n),
    .wr_reset_n                                     (core_rst_n),
    // Functional Interface                         
    .wr_en                                          (ts_pmd_sll_data_mem_wr_en),         
    .wr_adr                                         (ts_pmd_sll_data_mem_wr_addr),       
    .wr_data                                        (ts_pmd_sll_data_mem_wr_data),       
    .rd_en                                          (ts_pmd_sll_data_mem_rd_en),         
    .rd_adr                                         (ts_pmd_sll_data_mem_rd_addr),       
    .rd_data                                        (ts_pmd_sll_data_mem_rd_data),       
    .rd_valid                                       (ts_pmd_sll_data_mem_rd_data_valid), 
    .init_done                                      (ts_pmd_sll_data_mem_init_done_nc),     
    // ECC Interface
    .ecc_uncor_err                                  (ts_pmd_sll_data_ecc_uncor_err),
    // Memory Wrap Interface
    .pkb_pbn_top_pbn_if_ts_pmd_sll_data_from_mem    (pif_ts_pmd_sll_data_from_mem),
    .pkb_pbn_top_pbn_if_ts_pmd_sll_data_to_mem      (pif_ts_pmd_sll_data_to_mem),
    // Gen CTR Interface                              
    .pkb_pbn_top_pbn_if_ts_pmd_sll_data_from_ctl    (pif_ts_pmd_sll_data_from_ctl),
    .pkb_pbn_top_pbn_if_ts_pmd_sll_data_to_ctl      (pif_ts_pmd_sll_data_to_ctl),
    // Dyn Light Sleep
    .mem_ls_enter                                   (1'b0)
  );
  
  ecip_gen_dual_port_ram_v2 #(
    .DW         (TS_PMD_SLL_PMEM_DATA_W),  // Data width                                                
    .DEPTH      (TS_PMD_SLL_PMEM_DEPTH),   // Memory depth                                              
    .DELAY      (TS_PMD_SLL_PMEM_LATENCY), // Memory latency                                            
    .DO_INIT    (0)                        // Set to initialize memory upon reset - currently only 0's  
  ) ts_pmd_sll_list_mem (
    // Clocks & reset
    .wr_clk     (core_clk),
    .rd_clk     (core_clk),
    .wr_rst_n   (core_rst_n),
    .rd_rst_n   (core_rst_n),
    // Write interface
    .wr_en      (ts_pmd_sll_list_mem_wr_en),
    .wr_addr    (ts_pmd_sll_list_mem_wr_addr),
    .wr_data    (ts_pmd_sll_list_mem_wr_data),
    // Read interface
    .rd_en      (ts_pmd_sll_list_mem_rd_en),
    .rd_addr    (ts_pmd_sll_list_mem_rd_addr),
    .rd_vld     (ts_pmd_sll_list_mem_rd_vld_nc),
    .rd_data    (ts_pmd_sll_list_mem_rd_data)
  );
  
  /////////////////////////////////////////////////////////////////
  // Assertion
  /////////////////////////////////////////////////////////////////

  `ifndef INTEL_SVA_OFF
   `ifdef INTEL_SIMONLY

    import intel_checkers_pkg::*;

    logic pbn_if_sva_en;
    
    always_comb begin
      pbn_if_sva_en = 1'b1;
      
      if ($test$plusargs("PKB_PBN_IF_SVA_DIS"))
        pbn_if_sva_en = 1'b0;
    end
    
    `ASSERTS_NEVER (    wrong_ts_hdr_tdest,
                        pbn_if_sva_en & ts_hdr_sll_in_v & ~ts_hdr_sll_in_full & ts_hdr_sll_in.tdest > PKB_TS_PKT_TDEST_W'(PKB_NUM_HOST-1),
                        posedge core_clk, ~core_rst_n,
                        `ERR_MSG ("Error: PBN Input: Illegal Header TDEST Number (Valid Values: 0-4)!")
                );
    
    `ASSERTS_NEVER (    wrong_ts_pmd_tdest,
                        pbn_if_sva_en & ts_pmd_sll_in_v & ~ts_pmd_sll_in_full & ts_pmd_sll_in.tdest > PKB_TS_PMD_TDEST_W'(PKB_NUM_HOST-1),
                        posedge core_clk, ~core_rst_n,
                        `ERR_MSG ("Error: PBN Input: Illegal PMD TDEST Number (Valid Values: 0-4)!")
                );
  
  /////////////////////////////////////////////////////////////////
  // EOT
  /////////////////////////////////////////////////////////////////
  
    `ECIP_GEN_PKB_EOT(pkb_pbn_if, 
                  TS_HDR_INPUT_FIFO_EMPTY, 
                  ~pbn_if_sva_en | (ts_hdr_input_fifo_out_fullness == '0), 
                  EOT arrived but TS_HDR_INPUT_FIFO isn't Empty!); 
    `ECIP_GEN_PKB_EOT(pkb_pbn_if, 
                  TS_HDR_BOB_FIFO_EMPTY, 
                  ~pbn_if_sva_en | (ts_hdr_bob_fifo_out_fullness == '0), 
                  EOT arrived but TS_HDR_BOB_FIFO isn't Empty!); 
    
    `ECIP_GEN_PKB_EOT(pkb_pbn_if, 
                  TS_PMD_INPUT_FIFO_EMPTY, 
                  ~pbn_if_sva_en | (ts_pmd_input_fifo_out_fullness == '0), 
                  EOT arrived but TS_PMD_INPUT_FIFO isn't Empty!); 
    `ECIP_GEN_PKB_EOT(pkb_pbn_if, 
                  TS_PMD_BOB_FIFO_EMPTY, 
                  ~pbn_if_sva_en | (ts_pmd_bob_fifo_out_fullness == '0), 
                  EOT arrived but TS_PMD_BOB_FIFO isn't Empty!); 
    
    `ECIP_GEN_PKB_EOT(pkb_pbn_if, 
                  TS_HDR_OUTPUT_FIFO_EMPTY, 
                  ~pbn_if_sva_en | (ts_hdr_output_fifo_out_fullness == '0), 
                  EOT arrived but TS_HDR_OUTPUT_FIFO isn't Empty!); 
    
    `ECIP_GEN_PKB_EOT(pkb_pbn_if, 
                  TS_PMD_OUTPUT_FIFO_EMPTY, 
                  ~pbn_if_sva_en | (ts_pmd_output_fifo_out_fullness == '0), 
                  EOT arrived but TS_PMD_OUTPUT_FIFO isn't Empty!); 
    
    `ECIP_GEN_PKB_EOT(pkb_pbn_if, 
                  TS_PMD_ARB_IDX_FIFO_EMPTY, 
                  ~pbn_if_sva_en | (ts_pmd_arb_idx_fifo_out_fullness == '0), 
                  EOT arrived but TS_PMD_ARB_IDX_FIFO isn't Empty!); 
    
   `endif //  `ifdef INTEL_SIMONLY
  `endif //  `ifndef INTEL_SVA_OFF

endmodule
