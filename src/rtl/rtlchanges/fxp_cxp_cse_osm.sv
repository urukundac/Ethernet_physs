//------------------------------------------------------------------------------
//  INTEL TOP SECRET
//
//  Copyright 2006 - 2019 Intel Corporation All Rights Reserved.
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

module fxp_cxp_cse_osm
#(
        parameter CACHE_ID      = "DOG",
        parameter PLL_SIZE      = 256,
        parameter NO_OF_SETS    = 1024,
        parameter NO_OF_CLIENTS = 1,    // number of clients that this cache serves
        parameter CLIENTS_WR_EN = 1,    // each bit specify if this client has write operation
        parameter BANK_WIDTH    = 64,   // [B]
        parameter NO_OF_BANKS   = 4,    // number of physical cache-banks in the cache
        parameter RNM_WIDTH     = 128,  // [B]
        parameter MAX_OBJ       = 256,  // [B]
        parameter HMSID_WIDTH   = 13,
        parameter OBJ_IND_WIDTH = 28,
        parameter SW_DIRECT_DATA_W = 512,
        parameter USE_HASH      = 0
) (
  // clocks and resets
  input  logic                                                  clk,
  input  logic                                                  rst_n,
  input  logic                                                  mem_rst_n,
  input  logic                                                  fuse_rst_n,

  // eco
  output logic                                                  wr_comp,

  // csr
  input  logic                                                  cache_bypass, // if cache_bypass, OSM doesn't generate wr-requests to CBs (it does generate refill requests since now the data is going through the CB)
  input  logic                                                  skip_single_osr,
  input  logic                                                  skip_rd_after_rd_opt,

  // errors
  output logic                                                  same_obj_diff_banks_err,
  output logic                                                  pll_to_gen_ovf,
  output logic                                                  cb_rf_req_ovf,
  output logic                                                  cb_rf_req_und,
  output logic                                                  ddr_wr_err,
  output logic                                                  ddr_rd_err,
  output logic                                                  ddr_err_event,
  output fxp_cxp_cse_pkg::cse_ddr_err_info_t                        ddr_err_info,

  // direct
  input  logic                                                  sw_direct_req,
  input  logic [31:0]                                           sw_direct_addr,
  output logic                                                  sw_direct_rsp,
  output logic [SW_DIRECT_DATA_W-1:0]                           sw_direct_read_data,

  // OSM notifies CI upon wr to cb
  output logic                                                  cb_wr,
  output logic                          [NO_OF_BANKS-1:0]       cb_wr_banks,
  output logic                          [39:0]                  cb_wr_tag,

  // CIs req
  input  logic                          [NO_OF_CLIENTS-1:0]     i_osm_req_v,
  output logic                          [NO_OF_CLIENTS-1:0]     o_osm_req_e,
  input  fxp_cxp_cse_pkg::cse_osm_req_t     [NO_OF_CLIENTS-1:0]     i_osm_req,

  // CIs rsp
  output logic                          [NO_OF_CLIENTS-1:0]     o_osm_rsp_v,
  input  logic                          [NO_OF_CLIENTS-1:0]     i_osm_rsp_e,
  output fxp_cxp_cse_pkg::cse_osm_rsp_t     [NO_OF_CLIENTS-1:0]     o_osm_rsp,

  // CBs req
  output logic                          [NO_OF_BANKS-1:0]       o_cb_req_v,
  input  logic                          [NO_OF_BANKS-1:0]       i_cb_req_e,
  output fxp_cxp_cse_pkg::cse_cb_wr_req_t   [NO_OF_BANKS-1:0]       o_cb_req,

  // CBs rsp
  input  logic                          [NO_OF_BANKS-1:0]       i_cb_rsp_v,
  output logic                          [NO_OF_BANKS-1:0]       o_cb_rsp_e,
  input  fxp_cxp_cse_pkg::cse_cb_wr_rsp_t   [NO_OF_BANKS-1:0]       i_cb_rsp,

  // pmat req
  output logic                                                  o_cache_pmat_req_v,
  input  logic                                                  i_pmat_cache_req_e,
  output fxp_cxp_pkg::cse_pmat_req_t                                o_cache_pmat_req,

  // pmat rsp
  input  logic                                                  i_pmat_cache_rsp_v,
  output logic                                                  o_cache_pmat_rsp_e,
  input  fxp_cxp_pkg::cse_pmat_rsp_t                                i_pmat_cache_rsp,
  
  //fifo's DFD
  output logic                                                  pll_to_gen_new_fifo_full,
  output logic [1:0]                                            pll_to_gen_new_fifo_fullness,
  output logic                                                  pll_to_gen_fifo_full,
  output logic [8:0]                                            pll_to_gen_fifo_fullness,
  output logic                                                  cb_rf_rsp_fifo_full,
  output logic[3:0]                                             cb_rf_rsp_fifo_fullness,
  output logic                                                  cb_wr_rsp_fifo_full,
  output logic [4:0]                                            cb_wr_rsp_fifo_fullness,
  output logic                                                  cb_rf_ctrl_fifo_full,
  output logic [3:0]                                            cb_rf_ctrl_fifo_fullness,
  output logic                                                  ctrl_fifo_full,
  output logic [4:0]                                            ctrl_fifo_fullness,
  
  output logic [192:0]                                          cxp_cse_osm_visa_vec
  `include "fxp_cxp_cse_osm.VISA_IT.fxp_cxp_cse_osm.port_defs.sv" // Auto Included by VISA IT - *** Do not modify this line ***
  
  `include "cxp_macro.sv"
  
                                                 
);                           

  
  `include "fxp_cxp_cse_osm.VISA_IT.fxp_cxp_cse_osm.wires.sv" // Auto Included by VISA IT - *** Do not modify this line ***
  import fxp_cxp_pkg::*;
  import fxp_cxp_cse_pkg::*;

  localparam    NO_OF_CLIENTS_W = ($clog2(NO_OF_CLIENTS) > 0) ? $clog2(NO_OF_CLIENTS) : 1'b1;
  localparam    NO_OF_BANKS_W = ($clog2(NO_OF_BANKS) > 0) ? $clog2(NO_OF_BANKS) : 1'b1; 

  localparam    PLL_ADDR_NB = $clog2(PLL_SIZE);

  localparam [0:0] USE_2ND_BEAT = (MAX_OBJ > RNM_WIDTH) ? 1'b1 : 1'b0;

  localparam    SET_WIDTH    = $clog2(NO_OF_SETS);
  localparam    TAG_WIDTH    = HMSID_WIDTH + OBJ_IND_WIDTH;
  localparam    SAVED_TAG_WIDTH = USE_HASH ? TAG_WIDTH : TAG_WIDTH - SET_WIDTH;

  // cb_rf_rsp_fifo_t
  typedef struct packed {
    logic [ 3:0]                status;
    logic [MAX_DATA_ADDR_NB-1:0]location;
    logic [MAX_OBJ*8-1:0]       data;
  } cb_rf_rsp_fifo_t;

  // cb_wr_rsp_fifo_t
  typedef struct packed {
    logic [ 3:0]                status;
    logic [MAX_DATA_ADDR_NB-1:0]location;
  } cb_wr_rsp_fifo_t;

  // cse_pll_t
  typedef struct packed {
    logic [SAVED_TAG_WIDTH-1:0] saved_tag;
    logic [ 3:0]                trans_type;
    logic [MAX_CLIENT_ID_WIDTH-1:0] client_id;
    logic [23:0]                trans_id;
    logic [TW_WIDTH-1:0]        enter_ts; // time stamp
    fxp_cxp_pkg::pkt_label_t        pkt_label;
    fxp_cxp_pkg::pf_t               pf;
    logic                       last;
    logic                       grfne; // gen request for next entry
    logic [ 2:0]                data_ptr0;
    logic [ 2:0]                data_ptr1;
    logic [ 1:0]                obj_size;
    logic [ 7:0]                banks;
    logic [SET_WIDTH-1:0]       set;
    logic                       valid;
    logic [ 7:0]                ptr; // must be kept at lsbits
  } cse_pll_t;

// cse_pll_no_rst_t
  typedef struct packed {
    logic [SAVED_TAG_WIDTH-1:0] saved_tag;
    logic [ 3:0]                trans_type;
    logic [MAX_CLIENT_ID_WIDTH-1:0] client_id;
    logic [23:0]                trans_id;
    logic [TW_WIDTH-1:0]        enter_ts; // time stamp
    fxp_cxp_pkg::pkt_label_t        pkt_label;
    fxp_cxp_pkg::pf_t               pf;
    logic                       last;
    logic                       grfne; // gen request for next entry
    logic [ 2:0]                data_ptr0;
    logic [ 2:0]                data_ptr1;
    logic [ 1:0]                obj_size;
    logic [ 7:0]                banks;
    logic [SET_WIDTH-1:0]       set;
  } cse_pll_no_rst_t;

// cse_pll_rst_t
  typedef struct packed {
    logic                       valid;
    logic [ 7:0]                ptr; 
  } cse_pll_rst_t;

  // cse_osm_s1_req_t
  typedef struct packed {
    logic [23:0]                trans_id;
    logic [TW_WIDTH-1:0]        enter_ts; // time stamp
    logic [SAVED_TAG_WIDTH-1:0] saved_tag;
    logic [ 1:0]                obj_size;
    fxp_cxp_pkg::pkt_label_t        pkt_label;
    fxp_cxp_pkg::pf_t               pf;
    logic [ 3:0]                trans_type;
    logic [SET_WIDTH-1:0]       set;
    logic [ 7:0]                banks;
    logic [MAX_CLIENT_ID_WIDTH-1:0]                client;
    logic [ 2:0]                data_ptr0;
  } cse_osm_s1_req_t;

  // cse_osm_cb_req_ctrl_t
  typedef struct packed {
    logic [SET_WIDTH-1:0]       set;
    logic [ 7:0]                banks;
    logic [SAVED_TAG_WIDTH-1:0] saved_tag;
    fxp_cxp_pkg::pf_t               pf;
    logic [ 3:0]                trans_type;
  } cse_osm_cb_req_ctrl_t;

  /////////////////////////////////////////////////////////////////
  // definitions
  /////////////////////////////////////////////////////////////////

  logic                                 osm_rsp_v;
  fxp_cxp_cse_pkg::cse_osm_rsp_t            osm_rsp;
  logic [NO_OF_CLIENTS_W-1:0]           osm_rsp_client;
  logic                                 osm_rsp_trans;
  logic                                 ld_osm_rsp_e;
  fxp_cxp_cse_pkg::cse_osm_rsp_t            new_osm_rsp;
  logic [MAX_BANK_NB-1:0]               osm_rsp_first_bank;
  logic                                 pinned_obj;
  logic                                 pinning_reject;
  logic [LOCATION_NB-1:0]               bank_location;

  logic                                 cb_wr_req_wr;
  logic                                 cb_wr_req_wr_lb;
  logic                                 cb_wr_req_full;
  cse_osm_cb_req_ctrl_t                 cb_wr_req_ctrl;
  cse_osm_cb_req_ctrl_t                 cb_wr_req_ctrl_new;
  logic [MAX_OBJ*8-1:0]                 cb_wr_req_data;
  logic                                 cb_wr_req_rd;

  logic [PLL_ADDR_NB-1:0]               pll_peek_index;
  cse_pll_t                             pll_peek_entry;

  logic                                 cb_rf_req_wr;
  logic                                 cb_rf_req_wr_lb;
  logic                                 cb_rf_req_wr_fb;
  logic                                 cb_rf_req_wr_sb;
  logic                                 cb_rf_req_full;
  cse_osm_cb_req_ctrl_t                 cb_rf_req_ctrl;
  cse_osm_cb_req_ctrl_t                 cb_rf_req_ctrl_new;
  logic [MAX_OBJ*8-1:0]                 cb_rf_req_data;
  logic                                 cb_rf_req_rd;

  logic [ 1:0]                          cb_arb_reqs;
  logic                                 cb_arb_winner_v;
  logic                                 cb_arb_winner_e;
  logic                                 cb_arb_winner;
  logic                                 cb_req_v;
  cse_osm_cb_req_ctrl_t                 cb_req_ctrl;
  logic [MAX_OBJ*8-1:0]                 cb_req_data;

  logic [NO_OF_BANKS-1:0]               cb_rsp_banks;
  logic [NO_OF_BANKS_W-1:0]             cb_rsp_first_bank;
  logic                                 cb_rsp;
  logic                                 cb_wr_rsp;
  logic                                 cb_rf_rsp;

  logic                                 cb_rf_rsp_fifo_in_v;
  logic                                 cb_rf_rsp_fifo_in_e;
  cb_rf_rsp_fifo_t                      cb_rf_rsp_fifo_in;
  cb_rf_rsp_fifo_t                      cb_rf_rsp_fifo_out;
  logic                                 cb_rf_rsp_fifo_out_v;
  logic                                 cb_rf_rsp_fifo_pop;
 
  logic                                 cb_rf_rsp_fifo_mem_wr_en;
  logic                                 cb_rf_rsp_fifo_mem_rd_en;
  logic [ 2:0]                          cb_rf_rsp_fifo_mem_wr_addr;
  logic [ 2:0]                          cb_rf_rsp_fifo_mem_rd_addr;
  cb_rf_rsp_fifo_t                      cb_rf_rsp_fifo_mem_wr_data;
  cb_rf_rsp_fifo_t                      cb_rf_rsp_fifo_mem_rd_data;
  logic                                 cb_rf_rsp_fifo_mem_rd_vld;

  logic                                 cb_wr_rsp_fifo_in_v;
  cb_wr_rsp_fifo_t                      cb_wr_rsp_fifo_in;
  cb_wr_rsp_fifo_t                      cb_wr_rsp_fifo_out;
  logic                                 cb_wr_rsp_fifo_out_v;
  logic                                 cb_wr_rsp_fifo_pop;
  logic                                 cb_wr_rsp_fifo_in_e;


  logic                                 otf_rf_inc;
  logic                                 otf_rf_dec;
  logic [ 2:0]                          otf_rf;
  logic                                 room_in_cb_rf_rsp_fifo;

  logic                                 otf_wr_inc;
  logic                                 otf_wr_dec;
  logic [ 2:0]                          otf_wr;
  logic                                 room_in_cb_wr_rsp_fifo;

  logic [NO_OF_BANKS_W-1:0]             first_bank;
  logic [BANK_WIDTH*NO_OF_BANKS*8-1:0]  pad_data;
  logic [BANK_WIDTH*NO_OF_BANKS*8-1:0]  ext_data;

  cse_osm_s1_req_t                      s0_req;
  cse_osm_s1_req_t                      s1_req;
  logic [ 2:0]                          s1_req_data_ptr1;
  logic                                 si_full;
  logic                                 s0_full;
  logic                                 s1_full;
  logic                                 sitos0;
  logic                                 sitos0_v;
  logic                                 sitos0_e;
  logic                                 s0tos1;
  logic                                 s0tos1_v;
  logic                                 s0tos1_e;
  logic                                 s1tosp;
  logic                                 s1tosp_v;
  logic                                 s1tosp_e;
  logic                                 s0_wr;
  logic                                 s0_rd;
  logic                                 s1_wr;
  logic                                 s1_rd;

  logic [NO_OF_CLIENTS_W-1:0]           wait_for;
  logic [NO_OF_CLIENTS_W-1:0]           arb_winner;
  logic [NO_OF_CLIENTS_W-1:0]           write_data_idx;
  logic                                 got_first_beat;
  logic                                 got_second_beat;
  logic                                 hold_arb;
  logic [NO_OF_CLIENTS  -1:0]           arb_reqs;
  logic                                 arb_winner_v;
  logic                                 arb_winner_e;
  logic                                 win_req_write_beat;
  cse_osm_s1_req_t                      win_req;
  logic                                 pll_push;
  logic [PLL_SIZE-1:0]                  pmatch_vector;
  logic [PLL_SIZE-1:0]                  dmatch_vector;
  logic                                 new_pmatch;
  logic                                 new_dmatch;
  logic                                 unmatch_vec;
  logic                                 unmatch_new;
  logic                                 dmatch;
  logic                                 match;
  logic [PLL_ADDR_NB-1:0]               new_dmatch_index;
  logic [PLL_ADDR_NB-1:0]               dmatch_index;
  logic [PLL_ADDR_NB-1:0]               match_index;
  logic                                 pll_full;
  logic                                 pll_pop;
  logic                                 erl_good_wr_rsp;
  logic                                 cache_only_rsp;
  logic [PLL_ADDR_NB-1:0]               pll_pop_index;
  cse_pll_t                             pll_pop_entry;
  cse_pll_t [PLL_SIZE-1:0]              pll;
  cse_pll_t                             new_pll_entry;
  logic                                 next_grfne;
  fxp_cxp_pkg::cse_pmat_req_t               new_pmat_req;
  cse_pll_t                             pll_to_gen;
  logic                                 gen_pmat_req_new;
  logic                                 gen_pmat_req_old;
  logic                                 pll_to_gen_new_fifo_in_v;
  logic                                 pll_to_gen_new_fifo_out_v;
  logic                                 pll_to_gen_new_fifo_out_e;
  logic                                 pll_to_gen_new_fifo_in_e;
  logic [PLL_ADDR_NB-1:0]               pll_to_gen_new_fifo_in;
  logic [PLL_ADDR_NB-1:0]               pll_to_gen_new_fifo_out;
  logic                                 pll_to_gen_fifo_in_v;
  logic                                 pll_to_gen_fifo_out_v;
  logic                                 pll_to_gen_fifo_out_e;
  logic                                 pll_to_gen_fifo_in_e;
  logic [PLL_ADDR_NB-1:0]               pll_to_gen_fifo_in;
  logic [PLL_ADDR_NB-1:0]               pll_to_gen_fifo_out;
  logic                                 gen_pmat_req;
  logic                                 gen_pmat_req_beat;
  logic                                 pmat_req_trans;
  logic                                 pre_pmat_req_trans;
  logic                                 pre_pmat_req_trans_lb;
  logic                                 pre_pmat_req_trans_nlb;
  logic [ 2:0]                          data_ptr;
  logic [ 2:0]                          saved_ptr1;
  logic                                 saved_ptr1_v;
  logic [PLL_ADDR_NB-1:0]               first_free_entry;
  logic [PLL_ADDR_NB-1:0]               second_free_entry;
  logic [PLL_ADDR_NB-1:0]               pll_to_gen_idx;
  logic                                 fde_wr;
  logic                                 fde_rd;
  logic [ 2:0]                          fde_wr_ptr;
  logic [ 2:0]                          fde_wr_ptr_p1;
  logic [ 2:0]                          fde_rd_ptr;
  logic [ 2:0]                          fde_rd_ptr_p1;
  logic [ 7:0][2:0]                     fde; // free data entries
  logic                                 data_almost_full;
  logic                                 data_full;
  logic [ 7:0][RNM_WIDTH*8-1:0]         wdata;
  logic [ 2:0]                          next_fde;
  logic                                 data_rd;
  logic                                 data_wr;
  logic [RNM_WIDTH*8-1:0]               data_to_wr;
  logic                                 pmat_rsp_trans;
  logic                                 ctrl_fifo_in_v;
  fxp_cxp_cse_pkg::cse_pmat_rsp_ctrl_t      ctrl_fifo_in;
  logic                                 ctrl_fifo_out_v;
  fxp_cxp_cse_pkg::cse_pmat_rsp_ctrl_t      ctrl_fifo_out;
  logic                                 ctrl_fifo_in_e;
  logic                                 ctrl_fifo_pop;

  logic                                 cb_rsp_rdy;
  logic                                 all_rdy_for_osm_rsp;
  logic                                 pll_pop_late_wr_rsp;
  logic                                 ld_osm_rsp;
  logic                                 ld_osm_rsp_fb;
  logic                                 ld_osm_rsp_sb;
  logic                                 ld_osm_rsp_sb_flag;
  logic                                 ld_osm_rsp_lb;

  logic                                 cb_rf_ctrl_fifo_in_v;
  logic [PLL_ADDR_NB-1:0]               cb_rf_ctrl_fifo_in;
  logic                                 cb_rf_ctrl_fifo_out_v;
  logic [PLL_ADDR_NB-1:0]               cb_rf_ctrl_fifo_out;
  logic                                 cb_rf_ctrl_fifo_in_e;
  logic                                 cb_rf_ctrl_fifo_pop;
  logic                                 cb_rf_data_fifo_in_v;
  logic                                 cb_rf_data_fifo_in_e;
  logic [RNM_WIDTH*8-1:0]               cb_rf_data_fifo_in;
  logic                                 cb_rf_data_fifo_out_v;
  logic [RNM_WIDTH*8-1:0]               cb_rf_data_fifo_out;
  logic                                 cb_rf_data_fifo_full;
  logic                                 cb_rf_data_fifo_almost_full;
  logic [ 3:0]                          cb_rf_data_fifo_fullness;
  logic                                 cb_rf_data_fifo_pop;
  logic                                 cb_rf_data_fifo_mem_wr_en;
  logic [ 2:0]                          cb_rf_data_fifo_mem_wr_addr;
  logic [RNM_WIDTH*8-1:0]               cb_rf_data_fifo_mem_wr_data;
  logic                                 cb_rf_data_fifo_mem_rd_en;
  logic [ 2:0]                          cb_rf_data_fifo_mem_rd_addr;
  logic [RNM_WIDTH*8-1:0]               cb_rf_data_fifo_mem_rd_data;
  logic                                 cb_rf_data_fifo_mem_rd_vld;
  logic                                 load_new_pmat_req_e;
  logic                                 load_new_pmat_req;
  logic                                 gen_rptd_rsp;
  logic                                 rptd_rsp_v;
  logic [PLL_ADDR_NB-1:0]               rptd_rsp_index;

  logic [31:0]                          new_pll_entry_for_visa_saved_tag;
  logic [15:0]                          new_pll_entry_for_visa_set;
  logic [31:0]                          pll_pop_entry_for_visa_saved_tag;
  logic [15:0]                          pll_pop_entry_for_visa_set;

  /////////////////////////////////////////////////////////////////
  // eco: indication of write completion for pipe monitoring in cls
  /////////////////////////////////////////////////////////////////

  assign wr_comp = ctrl_fifo_pop & ~ctrl_fifo_out.trans_type & (~ctrl_fifo_out.status[3] | ctrl_fifo_out.status[2] | ctrl_fifo_out.status[0]);

  /////////////////////////////////////////////////////////////////
  // rsp to CIs
  /////////////////////////////////////////////////////////////////

  always_ff @(posedge clk or negedge rst_n)
    if (!rst_n)                 osm_rsp_v <= 1'b0;
    else if (ld_osm_rsp)        osm_rsp_v <= 1'b1;
    else if (osm_rsp_trans)     osm_rsp_v <= 1'b0;

  always_ff @(posedge clk `FXP_CXP_CSE_OR_NEGEDGE_RST_N)
    if (`FXP_CXP_CSE_NRSTN)     osm_rsp <= 'b0;
    else if (ld_osm_rsp_fb)     osm_rsp <= new_osm_rsp;
    else if (ld_osm_rsp_sb)     {osm_rsp.read_beat, osm_rsp.read_data} <= {1'b1, {((128-RNM_WIDTH)*8){1'b0}}, cb_rf_rsp_fifo_out.data[USE_2ND_BEAT*RNM_WIDTH*8 +: RNM_WIDTH*8]};

  generate
    if (NO_OF_CLIENTS > 1) begin: gen_rsp_cl

      always_ff @(posedge clk `FXP_CXP_CSE_OR_NEGEDGE_RST_N)
        if (`FXP_CXP_CSE_NRSTN) osm_rsp_client <= 'b0;
        else if (ld_osm_rsp_fb) osm_rsp_client <= pll_pop_entry.client_id[NO_OF_CLIENTS_W-1:0];

    end else begin: gen_rsp_cl_0

      assign osm_rsp_client = 1'b0;

    end
  endgenerate

  assign osm_rsp_trans = osm_rsp_v & i_osm_rsp_e[osm_rsp_client];

  assign ld_osm_rsp_e = ~osm_rsp_v | osm_rsp_trans;

  generate
    for (genvar gi=0 ; gi<NO_OF_CLIENTS ; gi++) begin : gen_rsp

      assign o_osm_rsp_v[gi] = osm_rsp_v & (osm_rsp_client == gi);

      assign o_osm_rsp[gi] = osm_rsp;

    end
  endgenerate

  assign pinning_reject = ~ctrl_fifo_out.trans_type ? // return pinning_reject for any case in which data is not written into the cache (and then the locaion is irrelevant): (*) pinned-wr which cannot be written since there is no room in both set and ovf (*) non-pinned-wr which cannot be written to cache (wr_reject) (*) rd which where brought from ddr and cannot be written (refill) to cache due to wr_reject
                                (cb_wr_rsp_fifo_out.status[1] & ~cache_bypass) :
                                (cb_rf_rsp_fifo_out.status[1] & ~|ctrl_fifo_out.status[1:0]);

  assign pinned_obj     = ~ctrl_fifo_out.trans_type ? // from cb: (pinned-wr & ~pin-reject) | (non-pinned-wr (also refill) to a pinned object (hit))
                                (cb_wr_rsp_fifo_out.status[2] & ~cache_bypass) :
                                (cb_rf_rsp_fifo_out.status[2] & ~|ctrl_fifo_out.status[1:0]);

  assign bank_location = ctrl_fifo_out.trans_type ? {osm_rsp_first_bank, (|ctrl_fifo_out.status[1:0] | cb_rf_rsp_fifo_out.status[1]) ? {(MAX_DATA_ADDR_NB){1'b1}} : cb_rf_rsp_fifo_out.location} :
                                                    {osm_rsp_first_bank, (cache_bypass               | cb_wr_rsp_fifo_out.status[1]) ? {(MAX_DATA_ADDR_NB){1'b1}} : cb_wr_rsp_fifo_out.location} ;

  assign new_osm_rsp.sw         = pll_pop_entry.client_id[MAX_CLIENT_ID_WIDTH-1]; // msbit of client_id indicates sw access
  assign new_osm_rsp.trans_id   = pll_pop_entry.trans_id;
  assign new_osm_rsp.enter_ts   = pll_pop_entry.enter_ts;
  assign new_osm_rsp.pkt_label  = pll_pop_entry.pkt_label;
  assign new_osm_rsp.obj_size   = pll_pop_entry.obj_size;
  assign new_osm_rsp.trans_type = pll_pop_entry.trans_type[2];
  assign new_osm_rsp.bank_location = bank_location;
  assign new_osm_rsp.status     = {1'b0, pinned_obj, pinning_reject, |ctrl_fifo_out.status[1:0]}; // {hit, pinned-obj, pinning-reject, pmat/ddr-error}
  assign new_osm_rsp.read_beat  = 1'b0;
  assign new_osm_rsp.read_data  = {{((128-RNM_WIDTH)*8){1'b0}}, cb_rf_rsp_fifo_out.data[0 +: RNM_WIDTH*8]};

  always_comb begin
    osm_rsp_first_bank = 'b0;
    for (int i=NO_OF_BANKS-1 ; i >= 0 ; i--) begin
      if (pll_pop_entry.banks[i])
        osm_rsp_first_bank = i;
    end
  end


  /////////////////////////////////////////////////////////////////
  // cb_wr_req
  /////////////////////////////////////////////////////////////////

  assign cb_wr_req_wr = pre_pmat_req_trans & ~pll_to_gen.trans_type[2] & ~cache_bypass;

  assign cb_wr_req_wr_lb = cb_wr_req_wr & (gen_pmat_req_beat | ~USE_2ND_BEAT | ~size_gt_ciw(pll_to_gen.obj_size, RNM_WIDTH, BANK_WIDTH));

  always_ff @(posedge clk or negedge rst_n)
    if (!rst_n)                                 cb_wr_req_full <= 1'b0;
    else if ( cb_wr_req_wr_lb & ~cb_wr_req_rd)  cb_wr_req_full <= 1'b1;
    else if (~cb_wr_req_wr_lb &  cb_wr_req_rd)  cb_wr_req_full <= 1'b0;

  always_ff @(posedge clk `FXP_CXP_CSE_OR_NEGEDGE_RST_N)
    if (`FXP_CXP_CSE_NRSTN)     cb_wr_req_ctrl <= 'b0;
    else if (cb_wr_req_wr_lb)   cb_wr_req_ctrl <= cb_wr_req_ctrl_new;

  always_ff @(posedge clk `FXP_CXP_CSE_OR_NEGEDGE_RST_N)
    if (`FXP_CXP_CSE_NRSTN)     cb_wr_req_data <= 'b0;
    else if (cb_wr_req_wr)      cb_wr_req_data[RNM_WIDTH*8*gen_pmat_req_beat +: RNM_WIDTH*8] <= wdata[data_ptr];

  assign cb_wr_req_ctrl_new.set         = pll_to_gen.set;
  assign cb_wr_req_ctrl_new.banks       = pll_to_gen.banks;
  assign cb_wr_req_ctrl_new.saved_tag   = pll_to_gen.saved_tag;
  assign cb_wr_req_ctrl_new.pf          = pll_to_gen.pf;
  assign cb_wr_req_ctrl_new.trans_type  = pll_to_gen.trans_type;

  /////////////////////////////////////////////////////////////////
  // cb_rf_req (refill)
  /////////////////////////////////////////////////////////////////

  assign pll_peek_index = cb_rf_ctrl_fifo_out;

  assign pll_peek_entry = pll[pll_peek_index];

  assign cb_rf_req_wr = cb_rf_ctrl_fifo_out_v & (~cb_rf_req_full | cb_rf_req_rd);

  assign cb_rf_req_wr_lb = cb_rf_req_wr & (cb_rf_req_wr_sb | ~USE_2ND_BEAT | ~size_gt_ciw(pll_peek_entry.obj_size, RNM_WIDTH, BANK_WIDTH));
  assign cb_rf_req_wr_fb = cb_rf_req_wr & ~cb_rf_req_wr_sb;

  assign cb_rf_data_fifo_pop = cb_rf_req_wr;
  assign cb_rf_ctrl_fifo_pop = cb_rf_req_wr_lb;

  always_ff @(posedge clk or negedge rst_n)
    if (!rst_n)                 cb_rf_req_wr_sb <= 1'b0;
    else if (cb_rf_req_wr)      cb_rf_req_wr_sb <= ~cb_rf_req_wr_lb;

  always_ff @(posedge clk or negedge rst_n)
    if (!rst_n)                 cb_rf_req_full <= 1'b0;
    else if (cb_rf_req_wr_lb)   cb_rf_req_full <= 1'b1;
    else if (cb_rf_req_rd)      cb_rf_req_full <= 1'b0;

  always_ff @(posedge clk `FXP_CXP_CSE_OR_NEGEDGE_RST_N)
    if (`FXP_CXP_CSE_NRSTN)     cb_rf_req_ctrl <= 'b0;
    else if (cb_rf_req_wr_fb)   cb_rf_req_ctrl <= cb_rf_req_ctrl_new;

  always_ff @(posedge clk `FXP_CXP_CSE_OR_NEGEDGE_RST_N)
    if (`FXP_CXP_CSE_NRSTN)     cb_rf_req_data <= 'b0;
    else if (cb_rf_req_wr)      cb_rf_req_data[RNM_WIDTH*8*cb_rf_req_wr_sb +: RNM_WIDTH*8] <= cb_rf_data_fifo_out;

  assign cb_rf_req_ctrl_new.set         = pll_peek_entry.set;
  assign cb_rf_req_ctrl_new.banks       = pll_peek_entry.banks;
  assign cb_rf_req_ctrl_new.saved_tag   = pll_peek_entry.saved_tag;
  assign cb_rf_req_ctrl_new.pf          = pll_peek_entry.pf;
  assign cb_rf_req_ctrl_new.trans_type  = pll_peek_entry.trans_type; // for now keep bit[2]=1 to indicate it is refill, later this bit will be cleared and the bank will recieve 3'b000 (i.e. regular write) instead of 3'b100 ; 3'b010 (nop) instead of 3'b110 (rd-no-refill)

  assign cb_rf_req_ovf =  cb_rf_req_full & cb_rf_req_wr_lb & ~cb_rf_req_rd;
  assign cb_rf_req_und = ~cb_rf_req_full                   &  cb_rf_req_rd;

  /////////////////////////////////////////////////////////////////
  // arbiter write/refill requests to CBs
  /////////////////////////////////////////////////////////////////

  assign cb_arb_reqs = {cb_rf_req_full & room_in_cb_rf_rsp_fifo,
                        cb_wr_req_full & room_in_cb_wr_rsp_fifo};

  ecip_gen_rr_arb_s_v1 #(
        .INP_WDTH       (2)
        )
    cb_req_arb (
        .clk            (clk),
        .rst_n          (rst_n),
        .inp_vector     (cb_arb_reqs),
        .arb            (cb_arb_winner_e),
        .prev_select    (),             // lintra s-60024b "Port deliberately unconnected"
        .next_select_vld(cb_arb_winner_v),
        .next_select    (cb_arb_winner)
  );

  // send request to all banks only when all banks are ready to accept this request
  //   (since wr is prioritized over rd in the banks, they will always be ready)
  //   this is to confirm that all parts of the object are written at the same cycle, to guarantee sync between rd and wr.
  assign cb_arb_winner_e = &i_cb_req_e;

  assign cb_req_v = cb_arb_winner_v & cb_arb_winner_e;

  assign cb_wr_req_rd = cb_req_v & ~cb_arb_winner;
  assign cb_rf_req_rd = cb_req_v &  cb_arb_winner;

  assign cb_req_ctrl = cb_arb_winner ? cb_rf_req_ctrl : cb_wr_req_ctrl;
  assign cb_req_data = cb_arb_winner ? cb_rf_req_data : cb_wr_req_data;

  /////////////////////////////////////////////////////////////////
  // cb rsp
  /////////////////////////////////////////////////////////////////

  assign o_cb_rsp_e = {NO_OF_BANKS{1'b1}}; // CB rsp must always be accepted. CB cannot accept back-presure

  assign cb_rsp_banks = i_cb_rsp_v & o_cb_rsp_e;

  always_comb begin
    cb_rsp_first_bank = 'b0;
    for (int i=NO_OF_BANKS-1 ; i >= 0 ; i--) begin
      if (cb_rsp_banks[i])
        cb_rsp_first_bank = i;
    end
  end

  assign cb_rsp = |cb_rsp_banks; // responses from all banks will be accepted at the same cycle

  assign cb_wr_rsp = cb_rsp & ~i_cb_rsp[cb_rsp_first_bank].refill;
  assign cb_rf_rsp = cb_rsp &  i_cb_rsp[cb_rsp_first_bank].refill;

  assign cb_wr_rsp_fifo_in_v = cb_wr_rsp;
  assign cb_rf_rsp_fifo_in_v = cb_rf_rsp;

  // status: collect from all relevant banks
  always_comb begin
    cb_rf_rsp_fifo_in.status = 4'b0100;
    for (int i=NO_OF_BANKS-1 ; i >= 0 ; i--) begin
      if (cb_rsp_banks[i]) begin
        cb_rf_rsp_fifo_in.status[0] = cb_rf_rsp_fifo_in.status[0] | i_cb_rsp[i].status[0]; // pmat/ddr error (always 0)
        cb_rf_rsp_fifo_in.status[1] = cb_rf_rsp_fifo_in.status[1] | i_cb_rsp[i].status[1]; // pinning-reject
        cb_rf_rsp_fifo_in.status[2] = cb_rf_rsp_fifo_in.status[2] & i_cb_rsp[i].status[2]; // pinned-object
        cb_rf_rsp_fifo_in.status[3] = cb_rf_rsp_fifo_in.status[3] | i_cb_rsp[i].status[3]; // hit (always 0)
      end
    end
  end
  assign cb_wr_rsp_fifo_in.status = cb_rf_rsp_fifo_in.status;

  // data: concatenate from all relevant banks
  generate
    for (genvar gi=0 ; gi<(MAX_OBJ/BANK_WIDTH) ; gi++) begin : gen_data
      assign cb_rf_rsp_fifo_in.data[(BANK_WIDTH*8*gi) +: (BANK_WIDTH*8)] = i_cb_rsp[cb_rsp_first_bank+gi].write_data[0 +: (BANK_WIDTH*8)];
    end
  endgenerate

  // location: take from first-bank
  assign cb_rf_rsp_fifo_in.location     = i_cb_rsp[cb_rsp_first_bank].location;
  assign cb_wr_rsp_fifo_in.location     = cb_rf_rsp_fifo_in.location;

  // cb_rf_rsp_fifo
  ecip_gen_rdy_val_fifo_mem_v3 #(
        .DEPTH          (8),
        .WIDTH          ($bits(cb_rf_rsp_fifo_t)),
        .MEM_LATENCY    (1)
    ) cb_rf_rsp_fifo (
        // general
        .clk            (clk),                  // input
        .rst_n          (rst_n),                // input
        .clear          (1'b0),                 // input
        .used_space     (cb_rf_rsp_fifo_fullness),// output [AW:0], nc
        // write IF
        .wr_data        (cb_rf_rsp_fifo_in),      // input  [WIDTH-1:0]
        .vld_in         (cb_rf_rsp_fifo_in_v),    // input
        .rdy_out        (cb_rf_rsp_fifo_in_e),    // output
        // read IF
        .rd_data        (cb_rf_rsp_fifo_out),     // output [WIDTH-1:0]
        .vld_out        (cb_rf_rsp_fifo_out_v),   // output
        .rd_ecc_err     (),                       // output 
        .rdy_in         (cb_rf_rsp_fifo_pop),     // input
        // shell IF
        .mem_wr_en      (cb_rf_rsp_fifo_mem_wr_en),   // output
        .mem_wr_addr    (cb_rf_rsp_fifo_mem_wr_addr), // output [AW-1:0]
        .mem_wr_data    (cb_rf_rsp_fifo_mem_wr_data), // output [WIDTH-1:0]
        .mem_rd_en      (cb_rf_rsp_fifo_mem_rd_en),   // output
        .mem_rd_addr    (cb_rf_rsp_fifo_mem_rd_addr), // output [AW-1:0]
        .mem_rd_data    (cb_rf_rsp_fifo_mem_rd_data), // input  [WIDTH-1:0]
        .mem_rd_vld     (cb_rf_rsp_fifo_mem_rd_vld),  // input  
        .mem_rd_ecc_err ('0)                          // input  
  );

  assign cb_rf_rsp_fifo_full = ~cb_rf_rsp_fifo_in_e;

  ecip_gen_rdy_val_fifo_v1 #(
        .DEPTH          (16),
        .WIDTH          ($bits(cb_wr_rsp_fifo_t)),
        .NO_DMUX        (1)
    ) cb_wr_rsp_fifo (
        .clk            (clk),
        .rst_n          (rst_n),
        .clear          (1'b0),
        .vld_in         (cb_wr_rsp_fifo_in_v),
        .wr_data        (cb_wr_rsp_fifo_in),
        .rdy_out        (cb_wr_rsp_fifo_in_e),
        .vld_out        (cb_wr_rsp_fifo_out_v),
        .rdy_in         (cb_wr_rsp_fifo_pop),
        .rd_data        (cb_wr_rsp_fifo_out),
        .used_space     (cb_wr_rsp_fifo_fullness)
  );

  assign cb_wr_rsp_fifo_full = ~cb_wr_rsp_fifo_in_e;

  /////////////////////////////////////////////////////////////////
  // otf (on the fly) - number of requests that are on the fly (sent request to cb, and didn't get rsp yet)
  /////////////////////////////////////////////////////////////////

  assign otf_rf_inc = cb_req_v &  cb_arb_winner;
  assign otf_wr_inc = cb_req_v & ~cb_arb_winner;

  assign otf_rf_dec = cb_rf_rsp_fifo_in_v;
  assign otf_wr_dec = cb_wr_rsp_fifo_in_v;

  always_ff @(posedge clk or negedge rst_n)
    if (!rst_n)                         otf_rf <= 3'b0;
    else if ( otf_rf_inc & ~otf_rf_dec) otf_rf <= otf_rf + 1'b1;
    else if (~otf_rf_inc &  otf_rf_dec) otf_rf <= otf_rf - 1'b1;

  always_ff @(posedge clk or negedge rst_n)
    if (!rst_n)                         otf_wr <= 3'b0;
    else if ( otf_wr_inc & ~otf_wr_dec) otf_wr <= otf_wr + 1'b1;
    else if (~otf_wr_inc &  otf_wr_dec) otf_wr <= otf_wr - 1'b1;

  assign room_in_cb_rf_rsp_fifo = ((cb_rf_rsp_fifo_fullness + {1'b0, otf_rf}) < 5'h8);
  assign room_in_cb_wr_rsp_fifo = ((cb_wr_rsp_fifo_fullness + {2'b0, otf_wr}) < 6'h10);

  /////////////////////////////////////////////////////////////////
  // cb req
  /////////////////////////////////////////////////////////////////

  assign o_cb_req_v = {NO_OF_BANKS{cb_req_v}} & cb_req_ctrl.banks[NO_OF_BANKS-1:0]; // assign o_cb_req_v = {NO_OF_BANKS{cb_req_v}} & (cb_req_ctrl.banks[NO_OF_BANKS-1:0] | {(NO_OF_BANKS){~cb_req_ctrl.trans_type[2]}}); // no need to invalidate other banks? depend if it's write or refill (according to cb_req_ctrl.trans_type[2])? according to CSR? currently can't make the change since there are lem tests that access same objects with different and overlapping banks (e.g. once with banks 4,5,6 and once with banks 3,4,5), in which case it fails when not invalidating other banks also upon refill. when lem design will be changed to have direct map from hmsid to 'banks' - this scenario won't be possible and this change can be inserted.

  generate
    for (genvar gi=0 ; gi<NO_OF_BANKS ; gi++) begin : gen_per_cb

      assign o_cb_req[gi].set           = {{(10-SET_WIDTH){1'b0}}, cb_req_ctrl.set};
      assign o_cb_req[gi].tag           = USE_HASH ? {{(40-SAVED_TAG_WIDTH){1'b0}}, cb_req_ctrl.saved_tag} : {{(40-TAG_WIDTH){1'b0}}, cb_req_ctrl.saved_tag, cb_req_ctrl.set};
      assign o_cb_req[gi].pf            = cb_req_ctrl.pf;
      assign o_cb_req[gi].trans_type    = {cb_req_ctrl.trans_type[3], 1'b0, cb_req_ctrl.trans_type[1:0]};
    //assign o_cb_req[gi].trans_type    = (cb_req_ctrl.banks[gi]                                   ) ? {1'b0, cb_req_ctrl.trans_type[1:0]} : 3'b010 /*code for invalidate*/;
    //assign o_cb_req[gi].trans_type    = (cb_req_ctrl.banks[gi] | (cb_req_ctrl.trans_type==3'b011)) ? {1'b0, cb_req_ctrl.trans_type[1:0]} : 3'b010 /*code for invalidate*/;
      assign o_cb_req[gi].refill        = cb_req_ctrl.trans_type[2];
      assign o_cb_req[gi].write_data    = {{((128-BANK_WIDTH)*8){1'b0}}, ext_data[(BANK_WIDTH*8*gi)+:(BANK_WIDTH*8)]};

    end
  endgenerate

  always_comb begin
    first_bank = 'b0;
    for (int i=NO_OF_BANKS-1 ; i >= 0 ; i--) begin
      if (cb_req_ctrl.banks[i])
        first_bank = i;
    end
  end

  assign pad_data = { {((BANK_WIDTH*8*NO_OF_BANKS)-(MAX_OBJ*8)){1'b0}}, cb_req_data};

  assign ext_data = pad_data << (BANK_WIDTH*8*first_bank);

  // OSM notifies CI upon wr to cb
  assign cb_wr       = cb_req_v;
  assign cb_wr_banks = cb_req_ctrl.banks[NO_OF_BANKS-1:0];
  assign cb_wr_tag   = o_cb_req[0].tag;

  /////////////////////////////////////////////////////////////////
  // req
  /////////////////////////////////////////////////////////////////

  generate
    if (USE_2ND_BEAT) begin: gen_use_2nd_beat

      assign got_first_beat =       sitos0                  & // arbitered
                                    ~win_req.trans_type[2]  & // it is write
                                    USE_2ND_BEAT            &
                                    size_gt_ciw(win_req.obj_size, RNM_WIDTH, BANK_WIDTH) & // size > RNM_WIDTH
                                    ~win_req_write_beat     ; // it is first beat

      assign got_second_beat =      hold_arb                        &
                                    i_osm_req_v[wait_for]           &
                                    i_osm_req[wait_for].write_beat  ;

      always_ff @(posedge clk or negedge rst_n)
        if (!rst_n)                 hold_arb <= 1'b0;
        else if (got_first_beat)    hold_arb <= 1'b1;
        else if (got_second_beat)   hold_arb <= 1'b0;

      always_ff @(posedge clk `FXP_CXP_CSE_OR_NEGEDGE_RST_N)
        if (`FXP_CXP_CSE_NRSTN)     wait_for <= 'b0;
        else if (got_first_beat)    wait_for <= arb_winner; 

      always_ff @(posedge clk or negedge rst_n)
        if (!rst_n)                         saved_ptr1_v <= 1'b0;
        else if (s0tos1)                    saved_ptr1_v <= 1'b0;
        else if (got_second_beat)           saved_ptr1_v <= 1'b1;

      always_ff @(posedge clk `FXP_CXP_CSE_OR_NEGEDGE_RST_N)
        if (`FXP_CXP_CSE_NRSTN)             saved_ptr1 <= 3'b0;
        else if (got_second_beat)           saved_ptr1 <= next_fde;

    end else begin: gen_no_use_2nd_beat

      assign got_first_beat     = 1'b0;
      assign got_second_beat    = 1'b0;
      assign hold_arb           = 1'b0;
      assign wait_for           =   '0;
      assign saved_ptr1_v       = 1'b0;
      assign saved_ptr1         =   '0;

    end
  endgenerate

  assign arb_reqs = i_osm_req_v & ~{NO_OF_CLIENTS{hold_arb}};

  ecip_gen_rr_arb_s_v1 #(
        .INP_WDTH       (NO_OF_CLIENTS)
        )
    osm_req_arb (
        .clk            (clk),
        .rst_n          (rst_n),
        .inp_vector     (arb_reqs),
        .arb            (arb_winner_e),
        .prev_select    (),             // lintra s-60024b "Port deliberately unconnected"
        .next_select_vld(arb_winner_v),
        .next_select    (arb_winner)
  );

  assign arb_winner_e = sitos0_e;

  assign win_req_write_beat     = i_osm_req[arb_winner].write_beat;     // note it is not part of win_req structure, as it is not required to be stored in s1_req
  assign win_req.trans_id       = i_osm_req[arb_winner].trans_id;
  assign win_req.enter_ts       = i_osm_req[arb_winner].enter_ts;
  assign win_req.saved_tag      = i_osm_req[arb_winner].saved_tag[SAVED_TAG_WIDTH-1:0];
  assign win_req.obj_size       = i_osm_req[arb_winner].obj_size;
  assign win_req.pkt_label      = i_osm_req[arb_winner].pkt_label;
  assign win_req.pf             = i_osm_req[arb_winner].pf;
  assign win_req.trans_type     = i_osm_req[arb_winner].trans_type;
  assign win_req.set            = i_osm_req[arb_winner].set[SET_WIDTH-1:0];
  assign win_req.banks          = i_osm_req[arb_winner].banks;
  assign win_req.client         = {i_osm_req[arb_winner].sw, {(MAX_CLIENT_ID_WIDTH-1-NO_OF_CLIENTS_W){1'b0}}, arb_winner};
  assign win_req.data_ptr0      = next_fde;

  assign si_full = arb_winner_v;

  assign s0_wr = sitos0;
  assign s1_wr = s0tos1;

  assign s0_rd = s0tos1;
  assign s1_rd = s1tosp;

  assign sitos0 = sitos0_v & sitos0_e;
  assign s0tos1 = s0tos1_v & s0tos1_e;
  assign s1tosp = s1tosp_v & s1tosp_e;

  assign sitos0_v = si_full;
  assign s0tos1_v = s0_full;
  assign s1tosp_v = s1_full;

  assign sitos0_e = (~s0_full | s0_rd) & ~data_full & ~data_almost_full;
  assign s0tos1_e = (~s1_full | s1_rd);
  assign s1tosp_e = ~pll_full & ~pll_to_gen_new_fifo_full;

  always_ff @(posedge clk or negedge rst_n)
    if (!rst_n)                 s0_full <= 1'b0;
    else if ( s0_wr & ~s0_rd)   s0_full <= 1'b1;
    else if (~s0_wr &  s0_rd)   s0_full <= 1'b0;

  always_ff @(posedge clk or negedge rst_n)
    if (!rst_n)                 s1_full <= 1'b0;
    else if ( s1_wr & ~s1_rd)   s1_full <= 1'b1;
    else if (~s1_wr &  s1_rd)   s1_full <= 1'b0;

  always_ff @(posedge clk `FXP_CXP_CSE_OR_NEGEDGE_RST_N)
    if (`FXP_CXP_CSE_NRSTN)     s0_req <= 'b0;
    else if (s0_wr)             s0_req <= win_req;

  always_ff @(posedge clk `FXP_CXP_CSE_OR_NEGEDGE_RST_N)
    if (`FXP_CXP_CSE_NRSTN)     s1_req <= 'b0;
    else if (s1_wr)             s1_req <= s0_req;

  always_ff @(posedge clk `FXP_CXP_CSE_OR_NEGEDGE_RST_N)
    if (`FXP_CXP_CSE_NRSTN)     s1_req_data_ptr1 <= 3'b0;
    else if (s1_wr)             s1_req_data_ptr1 <= saved_ptr1_v ? saved_ptr1 : next_fde;

  /////////////////////////////////////////////////////////////////
  // return 'enable' for the winning request
  /////////////////////////////////////////////////////////////////

  generate
    for (genvar gi=0 ; gi<NO_OF_CLIENTS ; gi++) begin : gen_req_e
      assign o_osm_req_e[gi] = (
                                        arb_winner_e &
                                        arb_reqs[gi] &
                                        (arb_winner == gi)
                                      ) | (
                                        i_osm_req_v[gi] &
                                       ~i_osm_req[gi].trans_type[2] &
                                        i_osm_req[gi].write_beat
                                      );
    end
  endgenerate

  /////////////////////////////////////////////////////////////////
  // match
  /////////////////////////////////////////////////////////////////
  // find the last item in the link list of that object

  generate
    for (genvar gi=0 ; gi<PLL_SIZE ; gi++) begin : gen_pll_match

      assign pmatch_vector[gi] =
                                 (pll[gi].valid                                    ) &
                                 (pll[gi].last                                     ) &
                                 (pll[gi].saved_tag == s0_req.saved_tag            ) &
                                ((pll[gi].set       == s0_req.set      ) | USE_HASH) &
                                ~(pll_pop & (gi == pll_pop_index)                  ) ;
    end
  endgenerate

  assign new_pmatch = pll_push &  (s1_req.saved_tag == s0_req.saved_tag) &
                                 ((s1_req.set       == s0_req.set      ) | USE_HASH) ;

  always_ff @(posedge clk or negedge rst_n)
    if (!rst_n)                 dmatch_vector <= {(PLL_SIZE){1'b0}};
    else if (s1_wr)             dmatch_vector <= pmatch_vector;
    else if (pll_pop)           dmatch_vector[pll_pop_index] <= 1'b0;

  always_ff @(posedge clk or negedge rst_n)
    if (!rst_n)                 new_dmatch <= 1'b0;
    else if (s1_wr)             new_dmatch <= new_pmatch;
    else if (unmatch_new)       new_dmatch <= 1'b0;

  always_ff @(posedge clk or negedge rst_n)
    if (!rst_n)                 new_dmatch_index <= {(PLL_ADDR_NB){1'b0}};
    else if (s1_wr & new_pmatch)new_dmatch_index <= first_free_entry;

  ecip_gen_ffs_v1 #(
        .INP_WDTH       (PLL_SIZE),     // = 8,
        .SRCH_DIR       (1),            // = 1,     // 1 - LSB is the first bit in vector, 0 - MSB is the first bit in vector
        .INP_WDTH_LOG   (PLL_ADDR_NB)   // = INP_WDTH < 2 ? 1 : $clog2(INP_WDTH)
    ) match_first_free_entry (
        .inp_vect       (dmatch_vector),// input  logic [INP_WDTH-1:0]
        .fs_vld         (dmatch),       // output logic
        .fs_idx         (dmatch_index)  // output logic [INP_WDTH_LOG-1:0]
  );

  assign unmatch_vec = pll_pop & (pll_pop_index ==     dmatch_index);
  assign unmatch_new = pll_pop & (pll_pop_index == new_dmatch_index);

  // skip_single_osr used for miss-rate-control for performance tests only. should not be used functionaly, since it may cause ordering issues between rd and wr requests, therefore in those performance tests there should be no cfg pkts during traffic, only in separate stage and only one-by-one.
  // skip_single_osr is used in order to output to rnm all requests immediately, without waiting for the previous request to return (per Sergio's request, email from 2019-Sep-08).
  assign match = ~skip_single_osr & (
                        (new_dmatch & ~unmatch_new) |
                        (    dmatch & ~unmatch_vec)
                 );

  assign match_index = new_dmatch ? new_dmatch_index : dmatch_index;

  /////////////////////////////////////////////////////////////////
  // pll
  /////////////////////////////////////////////////////////////////

  assign pll_push = s1tosp;

  assign pll_full = &first_free_entry;

  assign new_pll_entry.saved_tag        = s1_req.saved_tag;
  assign new_pll_entry.valid            = 1'b1;
  assign new_pll_entry.trans_type       = s1_req.trans_type;
  assign new_pll_entry.client_id        = s1_req.client;
  assign new_pll_entry.trans_id         = s1_req.trans_id;
  assign new_pll_entry.enter_ts         = s1_req.enter_ts;
  assign new_pll_entry.ptr              = {PLL_ADDR_NB{1'b0}}; // NA
  assign new_pll_entry.last             = 1'b1;
  assign new_pll_entry.grfne            = 1'b0;
  assign new_pll_entry.data_ptr0        = s1_req.data_ptr0;
  assign new_pll_entry.data_ptr1        = s1_req_data_ptr1;
  assign new_pll_entry.obj_size         = s1_req.obj_size;
  assign new_pll_entry.banks            = s1_req.banks;
  assign new_pll_entry.set              = s1_req.set;
  assign new_pll_entry.pf               = s1_req.pf;
  assign new_pll_entry.pkt_label        = s1_req.pkt_label;

  // gen-request-for-next-entry: unless rd-after-rd (to same banks (same object is always to same banks))
  // skip_rd_after_rd_opt is used to skip the rd-after-rd optimization.
  //                      it is used for miss-rate-control.
  //                      in this mode, all requests will generate rnm requests, even two consecutive reads to the same object.
  assign next_grfne = skip_rd_after_rd_opt |
                      ~( pll[match_index].trans_type[2] &
                            new_pll_entry.trans_type[2] );
                        // & (pll[match_index].banks == new_pll_entry.banks) ); // removed this condition when lem changed to match banks per hmsid (previously lem could generate request to same object with different banks)

  assign same_obj_diff_banks_err = (pll_push & match & ~(pll[match_index].banks == new_pll_entry.banks));

  generate
    for (genvar gi=0 ; gi<PLL_SIZE ; gi++) begin : gen_per_pll_entry

      localparam [PLL_ADDR_NB     -1:0] PTR_INIT = (PLL_ADDR_NB)'(gi+1);
      localparam [$bits(cse_pll_t)-1:0] PLL_INIT = ($bits(cse_pll_t))'(PTR_INIT);

      cse_pll_no_rst_t pll_no_rst;
      cse_pll_rst_t    pll_rst;

      cse_pll_t pll_was_last;
      cse_pll_t pll_popped;

      always_comb begin
        pll_was_last            = pll[gi];
        pll_was_last.last       = 1'b0;
        pll_was_last.ptr        = first_free_entry;
        pll_was_last.grfne      = next_grfne;

        pll_popped              = pll[gi];
        pll_popped.valid        = 1'b0;
        pll_popped.ptr          = pll_push ? second_free_entry : first_free_entry;
      end

      always_ff @(posedge clk or negedge rst_n)
        if (!rst_n)                                           pll_rst <= {1'b0, PTR_INIT};
        else if (pll_push & (gi == first_free_entry))         pll_rst <= new_pll_entry[PLL_ADDR_NB:0];
        else if (pll_push & (gi == match_index     ) & match) pll_rst <= pll_was_last [PLL_ADDR_NB:0];
        else if (pll_pop  & (gi == pll_pop_index   ))         pll_rst <= pll_popped   [PLL_ADDR_NB:0];

      always_ff @(posedge clk)
             if (pll_push & (gi == first_free_entry))         pll_no_rst <= new_pll_entry[$bits(cse_pll_t)-1:(PLL_ADDR_NB+1)];
        else if (pll_push & (gi == match_index     ) & match) pll_no_rst <= pll_was_last [$bits(cse_pll_t)-1:(PLL_ADDR_NB+1)];
        else if (pll_pop  & (gi == pll_pop_index   ))         pll_no_rst <= pll_popped   [$bits(cse_pll_t)-1:(PLL_ADDR_NB+1)];

      assign pll[gi] = {pll_no_rst, pll_rst};

    end
  endgenerate

  /////////////////////////////////////////////////////////////////
  // direct read pll content
  /////////////////////////////////////////////////////////////////

  always_ff @(posedge clk or negedge rst_n)
    if (!rst_n)                 sw_direct_rsp <= 1'b0;
    else                        sw_direct_rsp <= sw_direct_req;

  always_ff @(posedge clk `FXP_CXP_CSE_OR_NEGEDGE_RST_N)
    if (`FXP_CXP_CSE_NRSTN)     sw_direct_read_data <= {(SW_DIRECT_DATA_W){1'b0}};
    else if (sw_direct_req)     sw_direct_read_data <= {{(SW_DIRECT_DATA_W-$bits(cse_pll_t)){1'b0}}, pll[sw_direct_addr[PLL_ADDR_NB-1:0]]};

  /////////////////////////////////////////////////////////////////
  // pll-to-gen fifo - holds indexes of entries in the pll that need to generate pmat-requests for them
  /////////////////////////////////////////////////////////////////

  assign pll_to_gen_new_fifo_in_v = gen_pmat_req_new;

  assign pll_to_gen_new_fifo_in = first_free_entry;

  ecip_gen_rdy_val_fifo_v1 #(
        .DEPTH          (2),
        .WIDTH          (PLL_ADDR_NB),
        .NO_DMUX        (1)
    ) pll_to_gen_new_fifo (
        .clk            (clk),
        .rst_n          (rst_n),
        .clear          (1'b0),
        .wr_data        (pll_to_gen_new_fifo_in),
        .vld_in         (pll_to_gen_new_fifo_in_v),
        .rdy_out        (pll_to_gen_new_fifo_in_e),
        .rd_data        (pll_to_gen_new_fifo_out),
        .vld_out        (pll_to_gen_new_fifo_out_v),
        .rdy_in         (pll_to_gen_new_fifo_out_e),
        .used_space     (pll_to_gen_new_fifo_fullness)       
  );

  assign pll_to_gen_new_fifo_full = ~pll_to_gen_new_fifo_in_e;

  assign pll_to_gen_new_fifo_out_e = ~gen_pmat_req_old;

  assign pll_to_gen_fifo_in_v = gen_pmat_req_old | pll_to_gen_new_fifo_out_v;

  assign pll_to_gen_fifo_in = gen_pmat_req_old ? pll_pop_entry.ptr : pll_to_gen_new_fifo_out;

  ecip_gen_rdy_val_fifo_v1 #(
        .DEPTH          (PLL_SIZE),    // Number of entries
        .WIDTH          (PLL_ADDR_NB),   // Datapath width
        .NO_DMUX        (1)     // Flop fifo outputs
    ) pll_to_gen_fifo (
        .clk            (clk),
        .rst_n          (rst_n),
        .clear          (1'b0),
        .wr_data        (pll_to_gen_fifo_in),
        .vld_in         (pll_to_gen_fifo_in_v),
        .rdy_out        (pll_to_gen_fifo_in_e),
        .rd_data        (pll_to_gen_fifo_out),
        .vld_out        (pll_to_gen_fifo_out_v),
        .rdy_in         (pll_to_gen_fifo_out_e),
        .used_space     (pll_to_gen_fifo_fullness)
  );

  assign pll_to_gen_fifo_full = ~pll_to_gen_fifo_in_e;

  assign pll_to_gen_fifo_out_e = load_new_pmat_req_e;

  assign pll_to_gen_ovf = pll_to_gen_fifo_in_v & pll_to_gen_fifo_full;

  /////////////////////////////////////////////////////////////////
  // rptd_rsp
  /////////////////////////////////////////////////////////////////

  assign gen_rptd_rsp = pll_pop & ~pll_pop_entry.last & ~pll_pop_entry.grfne;

  always_ff @(posedge clk or negedge rst_n)
    if (!rst_n)                         rptd_rsp_v <= 1'b0;
    else if (gen_rptd_rsp)              rptd_rsp_v <= 1'b1;
    else if (pll_pop)                   rptd_rsp_v <= 1'b0;

  always_ff @(posedge clk `FXP_CXP_CSE_OR_NEGEDGE_RST_N)
    if (`FXP_CXP_CSE_NRSTN)             rptd_rsp_index <= {(PLL_ADDR_NB){1'b0}};
    else if (gen_rptd_rsp)              rptd_rsp_index <= pll_pop_entry.ptr;

  /////////////////////////////////////////////////////////////////
  // gen new req to pmat
  /////////////////////////////////////////////////////////////////

  assign gen_pmat_req_new = pll_push & ~match;

  assign gen_pmat_req_old = pll_pop & pll_pop_entry.grfne;

  assign load_new_pmat_req = pll_to_gen_fifo_out_v & load_new_pmat_req_e;

  always_ff @(posedge clk or negedge rst_n)
    if (!rst_n)                         gen_pmat_req <= 1'b0;
    else if (load_new_pmat_req)         gen_pmat_req <= 1'b1;
    else if (pre_pmat_req_trans_lb)     gen_pmat_req <= 1'b0;

  always_ff @(posedge clk or negedge rst_n)
    if (!rst_n)                         gen_pmat_req_beat <= 1'b0;
    else if (load_new_pmat_req)         gen_pmat_req_beat <= 1'b0;
    else if (pre_pmat_req_trans_nlb)    gen_pmat_req_beat <= 1'b1;

  assign pre_pmat_req_trans = gen_pmat_req & (~o_cache_pmat_req_v | pmat_req_trans) & (pll_to_gen.trans_type[2] | ~cb_wr_req_full | cb_wr_req_rd);

  assign pre_pmat_req_trans_nlb = pre_pmat_req_trans & ~gen_pmat_req_beat & ~pll_to_gen.trans_type[2] & USE_2ND_BEAT & size_gt_ciw(pll_to_gen.obj_size, RNM_WIDTH, BANK_WIDTH);

  assign pre_pmat_req_trans_lb = pre_pmat_req_trans & ~pre_pmat_req_trans_nlb;

  assign load_new_pmat_req_e = ~gen_pmat_req | pre_pmat_req_trans_lb;

  always_ff @(posedge clk `FXP_CXP_CSE_OR_NEGEDGE_RST_N)
    if (`FXP_CXP_CSE_NRSTN)             pll_to_gen <= 'b0;
    else if (load_new_pmat_req)         pll_to_gen <= pll[pll_to_gen_fifo_out];

  always_ff @(posedge clk `FXP_CXP_CSE_OR_NEGEDGE_RST_N)
    if (`FXP_CXP_CSE_NRSTN)             pll_to_gen_idx <= {PLL_ADDR_NB{1'b0}};
    else if (load_new_pmat_req)         pll_to_gen_idx <= pll_to_gen_fifo_out;

  assign data_ptr = gen_pmat_req_beat ? pll_to_gen.data_ptr1 : pll_to_gen.data_ptr0;

  assign new_pmat_req.trans_id    = pll_to_gen_idx;             // logic [ 7:0]
  
  generate 
      if (HMSID_WIDTH > 0) begin: hmsid_logic   assign new_pmat_req.hms_id      = {{(13-HMSID_WIDTH){1'b0}}, pll_to_gen.saved_tag[(USE_HASH ? OBJ_IND_WIDTH : (OBJ_IND_WIDTH-SET_WIDTH)) +: HMSID_WIDTH]}; end
      else                 begin: nohmsid_logic assign new_pmat_req.hms_id      = {(13){1'b0}}; end
  endgenerate
  
  generate 
      if (USE_HASH) begin: use_hash_logic    assign new_pmat_req.obj_indx    = {{(29-OBJ_IND_WIDTH){1'b0}}, pll_to_gen.saved_tag[0+: OBJ_IND_WIDTH]}; end
      else          begin: no_use_hash_logic assign new_pmat_req.obj_indx    = {{(29-OBJ_IND_WIDTH){1'b0}}, pll_to_gen.saved_tag[0+:(OBJ_IND_WIDTH-SET_WIDTH)], pll_to_gen.set}; end 
  endgenerate
  
  assign new_pmat_req.obj_size    = pll_to_gen.obj_size;        // logic [ 1:0]
  assign new_pmat_req.pkt_label   = pll_to_gen.pkt_label;       // fxp_cxp_pkg::pkt_label_t
  assign new_pmat_req.trans_type  = pll_to_gen.trans_type[3:2]; // logic
  assign new_pmat_req.write_beat  = gen_pmat_req_beat;          // logic
  assign new_pmat_req.write_data  = {{((128-RNM_WIDTH)*8){1'b0}}, wdata[data_ptr]};             // logic [128*8-1:0]

  always_ff @(posedge clk `FXP_CXP_CSE_OR_NEGEDGE_RST_N)
    if (`FXP_CXP_CSE_NRSTN)             o_cache_pmat_req <= 'b0;
    else if (pre_pmat_req_trans)        o_cache_pmat_req <= new_pmat_req;

  always_ff @(posedge clk or negedge rst_n)
    if (!rst_n)                         o_cache_pmat_req_v <= 1'b0;
    else if (pre_pmat_req_trans)        o_cache_pmat_req_v <= 1'b1;
    else if (pmat_req_trans)            o_cache_pmat_req_v <= 1'b0;

  assign pmat_req_trans = o_cache_pmat_req_v & i_pmat_cache_req_e;

  /////////////////////////////////////////////////////////////////
  // handle free entries in pll as a LIFO
  /////////////////////////////////////////////////////////////////

  always_ff @(posedge clk or negedge rst_n)
    if (!rst_n)                         first_free_entry <= {PLL_ADDR_NB{1'b0}};
    else if (pll_pop)                   first_free_entry <= pll_pop_index;
    else if (pll_push)                  first_free_entry <= second_free_entry;

  assign second_free_entry = pll[first_free_entry].ptr;

  /////////////////////////////////////////////////////////////////
  // write data
  /////////////////////////////////////////////////////////////////

  assign fde_rd = data_wr;
  assign fde_wr = data_rd;

  always_ff @(posedge clk or negedge rst_n)
    if (!rst_n)                 fde_wr_ptr <= 3'b0;
    else if (fde_wr)            fde_wr_ptr <= fde_wr_ptr_p1;

  always_ff @(posedge clk or negedge rst_n)
    if (!rst_n)                 fde_rd_ptr <= 3'b0;
    else if (fde_rd)            fde_rd_ptr <= fde_rd_ptr_p1;

  assign fde_wr_ptr_p1 = fde_wr_ptr + 1'b1;
  assign fde_rd_ptr_p1 = fde_rd_ptr + 1'b1;

  generate
    for (genvar gi=0 ; gi<8 ; gi++) begin : gen_per_fde
      always_ff @(posedge clk or negedge rst_n)
        if (!rst_n)                             fde[gi] <= gi;
        else if (fde_wr & (gi == fde_wr_ptr))   fde[gi] <= data_ptr;
    end
  endgenerate

  assign data_almost_full = (fde_rd_ptr_p1 == fde_wr_ptr);

  always_ff @(posedge clk or negedge rst_n)
    if (!rst_n)                                         data_full <= 1'b0;
    else if (data_almost_full &  fde_rd & ~fde_wr)      data_full <= 1'b1;
    else if (data_full        & ~fde_rd &  fde_wr)      data_full <= 1'b0;




  assign next_fde = fde[fde_rd_ptr];

  always_comb begin
    data_wr = 1'b0;
    for (int i=0 ; i<NO_OF_CLIENTS ; i++)
      if (i_osm_req_v[i] & o_osm_req_e[i] & ~i_osm_req[i].trans_type[2] & CLIENTS_WR_EN[i]) begin
        data_wr = 1;
      end
  end

  assign data_rd = pre_pmat_req_trans & ~new_pmat_req.trans_type[0];

  assign write_data_idx = got_second_beat ? wait_for : arb_winner;

  assign data_to_wr = i_osm_req[write_data_idx].write_data[RNM_WIDTH*8-1:0];

  generate
    for (genvar gi=0 ; gi<8 ; gi++) begin : gen_per_data
      always_ff @(posedge clk)
        if (data_wr & (gi == next_fde)) wdata[gi] <= data_to_wr;
    end
  endgenerate




  /////////////////////////////////////////////////////////////////
  // pmat rsp
  /////////////////////////////////////////////////////////////////

  assign o_cache_pmat_rsp_e = (~i_pmat_cache_rsp.trans_type)                                                  ? (~ctrl_fifo_full) : // wr
                              ( i_pmat_cache_rsp.read_beat)                                                   ? (~cb_rf_data_fifo_full) : // rd, second beat
                              (~USE_2ND_BEAT | ~size_gt_ciw(i_pmat_cache_rsp.obj_size, RNM_WIDTH, BANK_WIDTH)) ? (~ctrl_fifo_full & ~cb_rf_data_fifo_full) : // rd, first and only beat
                                                                                                                (~ctrl_fifo_full & ~cb_rf_data_fifo_full & ~cb_rf_data_fifo_almost_full) ; // rd, first beat out of two beats

  assign pmat_rsp_trans = i_pmat_cache_rsp_v & o_cache_pmat_rsp_e;

  /////////////////////////////////////////////////////////////////
  // error rsp
  /////////////////////////////////////////////////////////////////

  assign ddr_wr_err = pmat_rsp_trans & ~i_pmat_cache_rsp.trans_type & i_pmat_cache_rsp.status[0];
  assign ddr_rd_err = pmat_rsp_trans &  i_pmat_cache_rsp.trans_type & i_pmat_cache_rsp.status[0] & ~i_pmat_cache_rsp.read_beat;

  /////////////////////////////////////////////////////////////////
  // rsp ctrl fifo
  /////////////////////////////////////////////////////////////////

  assign ctrl_fifo_in_v = pmat_rsp_trans & ~i_pmat_cache_rsp.read_beat; // accept rsp which is not 2nd beat

  assign ctrl_fifo_in.trans_id   = i_pmat_cache_rsp.trans_id;
  assign ctrl_fifo_in.obj_size   = i_pmat_cache_rsp.obj_size;
  assign ctrl_fifo_in.trans_type = i_pmat_cache_rsp.trans_type;
  assign ctrl_fifo_in.status     = i_pmat_cache_rsp.status;

  ecip_gen_rdy_val_fifo_v1 #(
        .DEPTH          (16),    // Number of entries
        .WIDTH          ($bits(fxp_cxp_cse_pkg::cse_pmat_rsp_ctrl_t)),   // Datapath width
        .CNGST_DIS      (0),    // set to 0 in order to enable the congestion
        .NO_DMUX        (1)     // Flop fifo outputs
    ) rsp_ctrl_fifo (
        .clk            (clk),
        .rst_n          (rst_n),
        .clear          (1'b0),
        .wr_data        (ctrl_fifo_in),
        .vld_in         (ctrl_fifo_in_v),
        .rdy_out        (ctrl_fifo_in_e),
        .rd_data        (ctrl_fifo_out),
        .vld_out        (ctrl_fifo_out_v),
        .rdy_in         (ctrl_fifo_pop),
        .used_space     (ctrl_fifo_fullness) 
  );

  assign ctrl_fifo_full = ~ctrl_fifo_in_e;

  assign cb_rsp_rdy = ( ctrl_fifo_out.trans_type & ~|ctrl_fifo_out.status[1:0]                ) ? cb_rf_rsp_fifo_out_v : // good rd rsp --> need the refill request to the banks to be responded
                      (~ctrl_fifo_out.trans_type &   ctrl_fifo_out.status[3]   & ~cache_bypass) ? cb_wr_rsp_fifo_out_v : // early wr rsp --> need the write request to the banks to be done
                                                                                                  1'b1                 ; // other --> no need any cb rsp (bad rd rsp --> did not do refill ; posted wr rsp - only pop from pll, do not respond to client)

  assign all_rdy_for_osm_rsp = ctrl_fifo_out_v & ~(~ctrl_fifo_out.trans_type & ~ctrl_fifo_out.status[3]) & cb_rsp_rdy               ;
  assign pll_pop_late_wr_rsp = ctrl_fifo_out_v &  (~ctrl_fifo_out.trans_type & ~ctrl_fifo_out.status[3]);

  assign ld_osm_rsp = all_rdy_for_osm_rsp & ld_osm_rsp_e;

  assign ld_osm_rsp_lb = ld_osm_rsp & (ld_osm_rsp_sb_flag | ~ctrl_fifo_out.trans_type | ~USE_2ND_BEAT | ~size_gt_ciw(pll_pop_entry.obj_size, RNM_WIDTH, BANK_WIDTH));
  assign ld_osm_rsp_fb = ld_osm_rsp & ~ld_osm_rsp_sb_flag;
  assign ld_osm_rsp_sb = ld_osm_rsp &  ld_osm_rsp_sb_flag;

  always_ff @(posedge clk or negedge rst_n)
    if (!rst_n)                 ld_osm_rsp_sb_flag <= 1'b0;
    else if (ld_osm_rsp)        ld_osm_rsp_sb_flag <= ~ld_osm_rsp_lb;

  assign pll_pop                = (ld_osm_rsp_lb & (~erl_good_wr_rsp  | cache_only_rsp)) | pll_pop_late_wr_rsp;
  assign ctrl_fifo_pop          = (ld_osm_rsp_lb &  ~gen_rptd_rsp)    | pll_pop_late_wr_rsp;
  assign cb_rf_rsp_fifo_pop     = (ld_osm_rsp_lb &  ~gen_rptd_rsp &  ctrl_fifo_out.trans_type & ~|ctrl_fifo_out.status[1:0]);
  assign cb_wr_rsp_fifo_pop     = (ld_osm_rsp_lb &  ~cache_bypass & ~ctrl_fifo_out.trans_type &   ctrl_fifo_out.status[3]); // early-wr & ~cache_bypass

  assign erl_good_wr_rsp = ~ctrl_fifo_out.trans_type & ctrl_fifo_out.status[3] & ~ctrl_fifo_out.status[0];
  assign cache_only_rsp  =  ctrl_fifo_out_v          & ctrl_fifo_out.status[2];
  
  assign pll_pop_index = rptd_rsp_v ? rptd_rsp_index : ctrl_fifo_out.trans_id;

  assign pll_pop_entry = pll[pll_pop_index];

  /////////////////////////////////////////////////////////////////
  // ddr_err
  /////////////////////////////////////////////////////////////////

  assign ddr_err_event          = pll_pop & ctrl_fifo_pop & (|ctrl_fifo_out.status[1:0]) & ~cache_only_rsp;

  assign ddr_err_info.valid      = 1'b1;
  assign ddr_err_info.tag        = USE_HASH ? {{(40-SAVED_TAG_WIDTH){1'b0}}, pll_pop_entry.saved_tag} : {{(40-TAG_WIDTH){1'b0}}, pll_pop_entry.saved_tag, pll_pop_entry.set};
  assign ddr_err_info.err_type   = ~ctrl_fifo_out.status[3];    // 1 - ddr error ; 0 - pmat error
  assign ddr_err_info.trans_type = pll_pop_entry.trans_type;
  assign ddr_err_info.client_id  = pll_pop_entry.client_id;
  assign ddr_err_info.trans_id   = pll_pop_entry.trans_id;
  assign ddr_err_info.pkt_label  = pll_pop_entry.pkt_label;
  assign ddr_err_info.pf         = pll_pop_entry.pf;
  assign ddr_err_info.obj_size   = pll_pop_entry.obj_size;
  assign ddr_err_info.banks      = pll_pop_entry.banks;

  /////////////////////////////////////////////////////////////////
  // cb_rf_ctrl_fifo
  /////////////////////////////////////////////////////////////////

  assign cb_rf_ctrl_fifo_in_v = pmat_rsp_trans & i_pmat_cache_rsp.trans_type & ~|i_pmat_cache_rsp.status[1:0] & ~i_pmat_cache_rsp.read_beat; // accept good read rsp

  assign cb_rf_ctrl_fifo_in = i_pmat_cache_rsp.trans_id;

  ecip_gen_rdy_val_fifo_v1 #(
        .DEPTH          (8),    // Number of entries
        .WIDTH          (8),    // Datapath width
        .NO_DMUX        (1)     // Flop fifo outputs
    ) cb_rf_ctrl_fifo (
        .clk            (clk),
        .rst_n          (rst_n),
        .clear          (1'b0),
        .wr_data        (cb_rf_ctrl_fifo_in),
        .vld_in         (cb_rf_ctrl_fifo_in_v),
        .rdy_out        (cb_rf_ctrl_fifo_in_e),
        .rd_data        (cb_rf_ctrl_fifo_out),
        .vld_out        (cb_rf_ctrl_fifo_out_v),
        .rdy_in         (cb_rf_ctrl_fifo_pop),
        .used_space     (cb_rf_ctrl_fifo_fullness)
  );

  assign cb_rf_ctrl_fifo_full = ~cb_rf_ctrl_fifo_in_e;

  /////////////////////////////////////////////////////////////////
  // cb_rf_data_fifo
  /////////////////////////////////////////////////////////////////

  assign cb_rf_data_fifo_in_v = pmat_rsp_trans & i_pmat_cache_rsp.trans_type & ~|i_pmat_cache_rsp.status[1:0]; // accept good read rsp

  assign cb_rf_data_fifo_in = i_pmat_cache_rsp.read_data[RNM_WIDTH*8-1:0];

  ecip_gen_rdy_val_fifo_mem_v3 #(
        .WIDTH          (RNM_WIDTH*8),
        .DEPTH          (8),
        .MEM_LATENCY    (1)
    ) data_fifo (
        // general
        .clk            (clk),                  // input
        .rst_n          (rst_n),                // input
        .clear          (1'b0),                 // input
        .used_space     (cb_rf_data_fifo_fullness),   // output [AW:0]
        // write IF
        .wr_data        (cb_rf_data_fifo_in),         // input  [WIDTH-1:0]
        .vld_in         (cb_rf_data_fifo_in_v),       // input
        .rdy_out        (cb_rf_data_fifo_in_e),       // output, nc
        // read IF
        .rd_data        (cb_rf_data_fifo_out),        // output [WIDTH-1:0]
        .vld_out        (cb_rf_data_fifo_out_v),      // output
        .rd_ecc_err     (),                           // output 
        .rdy_in         (cb_rf_data_fifo_pop),        // input
        // shell IF
        .mem_wr_en      (cb_rf_data_fifo_mem_wr_en),   // output
        .mem_wr_addr    (cb_rf_data_fifo_mem_wr_addr), // output [AW-1:0]
        .mem_wr_data    (cb_rf_data_fifo_mem_wr_data), // output [WIDTH-1:0]
        .mem_rd_en      (cb_rf_data_fifo_mem_rd_en),   // output
        .mem_rd_addr    (cb_rf_data_fifo_mem_rd_addr), // output [AW-1:0]
        .mem_rd_data    (cb_rf_data_fifo_mem_rd_data), // input  [WIDTH-1:0]
        .mem_rd_vld     (cb_rf_data_fifo_mem_rd_vld),  // input  
        .mem_rd_ecc_err ('0)                           // input  
  );

  assign cb_rf_data_fifo_full = ~cb_rf_data_fifo_in_e;

  assign cb_rf_data_fifo_almost_full = (cb_rf_data_fifo_fullness == 4'h7);

  /////////////////////////////////////////////////////////////////
  // signals for visa
  /////////////////////////////////////////////////////////////////

  assign new_pll_entry_for_visa_saved_tag       = { {(32-SAVED_TAG_WIDTH){1'b0}}, new_pll_entry.saved_tag};
  assign pll_pop_entry_for_visa_saved_tag       = { {(32-SAVED_TAG_WIDTH){1'b0}}, pll_pop_entry.saved_tag};
  assign new_pll_entry_for_visa_set             = { {(16-SET_WIDTH      ){1'b0}}, new_pll_entry.set      };
  assign pll_pop_entry_for_visa_set             = { {(16-SET_WIDTH      ){1'b0}}, pll_pop_entry.set      };

  /////////////////////////////////////////////////////////////////
  // memories
  /////////////////////////////////////////////////////////////////

  ecip_gen_dual_port_ram_v2
    #(
        .DW             (RNM_WIDTH*8),
        .DEPTH          (8),
        .AW             (3),
        .DELAY          (1)
    )
    cb_rf_data_fifo_mem (
        .rd_clk                                 (clk),
        .wr_clk                                 (clk),
        .rd_rst_n                               (rst_n),
        .wr_rst_n                               (rst_n),
        .rd_addr                                (cb_rf_data_fifo_mem_rd_addr),
        .wr_addr                                (cb_rf_data_fifo_mem_wr_addr),
        .rd_en                                  (cb_rf_data_fifo_mem_rd_en),
        .wr_en                                  (cb_rf_data_fifo_mem_wr_en),
        .wr_data                                (cb_rf_data_fifo_mem_wr_data),
        .rd_data                                (cb_rf_data_fifo_mem_rd_data),
        .rd_vld                                 (cb_rf_data_fifo_mem_rd_vld)
  );

  ecip_gen_dual_port_ram_v2
    #(
        .DW             ($bits(cb_rf_rsp_fifo_t)),
        .DEPTH          (8),
        .AW             (3),
        .DELAY          (1)
    )
    cb_rf_rsp_fifo_mem (
        .rd_clk                                 (clk),
        .wr_clk                                 (clk),
        .rd_rst_n                               (rst_n),
        .wr_rst_n                               (rst_n),
        .rd_addr                                (cb_rf_rsp_fifo_mem_rd_addr),
        .wr_addr                                (cb_rf_rsp_fifo_mem_wr_addr),
        .rd_en                                  (cb_rf_rsp_fifo_mem_rd_en),
        .wr_en                                  (cb_rf_rsp_fifo_mem_wr_en),
        .wr_data                                (cb_rf_rsp_fifo_mem_wr_data),
        .rd_data                                (cb_rf_rsp_fifo_mem_rd_data),
        .rd_vld                                 (cb_rf_rsp_fifo_mem_rd_vld)
  );


    //visa
    always_comb begin
        
        cxp_cse_osm_visa_vec           = '0;
        
        cxp_cse_osm_visa_vec [0]       = pll_push;
        cxp_cse_osm_visa_vec [1]       = pll_pop;
        cxp_cse_osm_visa_vec [2]       = match;
        cxp_cse_osm_visa_vec [6:3]     = first_free_entry[3:0];
        cxp_cse_osm_visa_vec [10:7]    = first_free_entry[7:4];
        cxp_cse_osm_visa_vec [14:11]   = match_index[3:0];
        cxp_cse_osm_visa_vec [18:15]   = match_index[7:4];
        cxp_cse_osm_visa_vec [22:19]   = pll_pop_index[3:0];
        cxp_cse_osm_visa_vec [26:23]   = pll_pop_index[7:4];      
        cxp_cse_osm_visa_vec [50:27]   = new_pll_entry.trans_id[23:0];
        cxp_cse_osm_visa_vec [53:51]   = new_pll_entry.trans_type[2:0];
        cxp_cse_osm_visa_vec [56:54]   = new_pll_entry.client_id[2:0];
        cxp_cse_osm_visa_vec [58:57]   = new_pll_entry.obj_size[1:0];
        cxp_cse_osm_visa_vec [62:59]   = new_pll_entry.banks[3:0];        
        cxp_cse_osm_visa_vec [66:63]   = new_pll_entry.banks[7:4];
        cxp_cse_osm_visa_vec [77:67]   = new_pll_entry.pkt_label[10:0];       
        cxp_cse_osm_visa_vec [83:78]   = new_pll_entry.pf[5:0];
        cxp_cse_osm_visa_vec [84]      = new_pll_entry.last;
        cxp_cse_osm_visa_vec [85]      = new_pll_entry.grfne;
        cxp_cse_osm_visa_vec [89:86]   = new_pll_entry.ptr[3:0];        
        cxp_cse_osm_visa_vec [93:90]   = new_pll_entry.ptr[7:4];
        cxp_cse_osm_visa_vec [125:94]  = new_pll_entry_for_visa_saved_tag[31:0];
        cxp_cse_osm_visa_vec [141:126] = new_pll_entry_for_visa_set [15:0];

    end
    
  /////////////////////////////////////////////////////////////////
  // trace
  /////////////////////////////////////////////////////////////////

  `ifdef INTEL_SIMONLY

  // pll push
  always_ff @(posedge clk)
    if (rst_n && ($test$plusargs("CSE_TRACES")))
      if (pll_push)
        $display ($stime, " %m :: pll push :: pll_index=%h tag=%h val=%h op=%h cl=%h id=%h ts=%h ptr=%h first=%h last=%h dptr0=%h dptr1=%h size=%h",
                                                first_free_entry,
                                                USE_HASH ? new_pll_entry.saved_tag : {new_pll_entry.saved_tag, new_pll_entry.set},
                                                new_pll_entry.valid,
                                                new_pll_entry.trans_type,
                                                new_pll_entry.client_id,
                                                new_pll_entry.trans_id,
                                                new_pll_entry.enter_ts,
                                                new_pll_entry.ptr,
                                                ~match,
                                                new_pll_entry.last,
                                                new_pll_entry.data_ptr0,
                                                new_pll_entry.data_ptr1,
                                                new_pll_entry.obj_size
        );

  // pll pop
  always_ff @(posedge clk)
    if (rst_n && ($test$plusargs("CSE_TRACES")))
      if (pll_pop)
        $display ($stime, " %m :: pll pop  :: pll_index=%h tag=%h val=%h op=%h cl=%h id=%h ts=%h ptr=%h last=%h grfne=%h dptr0=%h dptr1=%h size=%h",
                                                pll_pop_index,
                                                USE_HASH ? pll_pop_entry.saved_tag : {pll_pop_entry.saved_tag, pll_pop_entry.set},
                                                pll_pop_entry.valid,
                                                pll_pop_entry.trans_type,
                                                pll_pop_entry.client_id,
                                                pll_pop_entry.trans_id,
                                                pll_pop_entry.enter_ts,
                                                pll_pop_entry.ptr,
                                                pll_pop_entry.last,
                                                pll_pop_entry.grfne,
                                                pll_pop_entry.data_ptr0,
                                                pll_pop_entry.data_ptr1,
                                                pll_pop_entry.obj_size
        );

  `endif

  /////////////////////////////////////////////////////////////////
  // assertion
  /////////////////////////////////////////////////////////////////

  `ifndef INTEL_SVA_OFF

  import intel_checkers_pkg::*;

  // wdata

  logic [7:0] wdata_valid;

  generate
    for (genvar gi=0 ; gi<8 ; gi++) begin : gen_per_data_assertion

      always_ff @(posedge clk or negedge rst_n)
        if (!rst_n)                             wdata_valid[gi] <= 1'b0;
        else if (data_wr & (gi == next_fde))    wdata_valid[gi] <= 1'b1;
        else if (data_rd & (gi == data_ptr))    wdata_valid[gi] <= 1'b0;

    end
  endgenerate

  `ASSERTS_NEVER (      wdata_rd_wr_same_entry,
                        (data_wr & data_rd & (next_fde == data_ptr)),
                        posedge clk, ~rst_n,
                        `ERR_MSG ("Error: wdata array: read and write to the same entry")
                );

  `ASSERTS_NEVER (      wdata_overflow,
                        (data_wr & wdata_valid[next_fde]),
                        posedge clk, ~rst_n,
                        `ERR_MSG ("Error: wdata overflow")
                );

  `ASSERTS_NEVER (      wdata_underflow,
                        (data_rd & ~wdata_valid[data_ptr]),
                        posedge clk, ~rst_n,
                        `ERR_MSG ("Error: wdata underflow")
                );

  // cb_rf_rsp_fifo
  `ASSERTS_NEVER (      cb_rf_rsp_fifo_overflow,
                        (cb_rf_rsp_fifo_full & cb_rf_rsp_fifo_in_v),
                        posedge clk, ~rst_n,
                        `ERR_MSG ("Error: cb_rf_rsp_fifo overflow")
                );

  `ASSERTS_NEVER (      cb_rf_rsp_fifo_underflow,
                        (cb_rf_rsp_fifo_pop & ~cb_rf_rsp_fifo_out_v),
                        posedge clk, ~rst_n,
                        `ERR_MSG ("Error: cb_rf_rsp_fifo underflow")
                );

  // cb_wr_rsp_fifo
  `ASSERTS_NEVER (      cb_wr_rsp_fifo_overflow,
                        (cb_wr_rsp_fifo_full & cb_wr_rsp_fifo_in_v),
                        posedge clk, ~rst_n,
                        `ERR_MSG ("Error: cb_wr_rsp_fifo overflow")
                );

  `ASSERTS_NEVER (      cb_wr_rsp_fifo_underflow,
                        (cb_wr_rsp_fifo_pop & ~cb_wr_rsp_fifo_out_v),
                        posedge clk, ~rst_n,
                        `ERR_MSG ("Error: cb_wr_rsp_fifo underflow")
                );

  logic ilegal_wr_on_rd_only;

  always_comb begin
    ilegal_wr_on_rd_only = 1'b0;
    for (int i=0 ; i<NO_OF_CLIENTS ; i++)
      if (i_osm_req_v[i] & ~i_osm_req[i].trans_type[2] & ~CLIENTS_WR_EN[i]) begin
        ilegal_wr_on_rd_only = 1;
      end
  end

  `ASSERTS_NEVER (      wr_req_for_rd_only_cl,
                        (ilegal_wr_on_rd_only),
                        posedge clk, ~rst_n,
                        `ERR_MSG ("Error: client req error: rd-only client generates write request")
                );

  `ASSERTS_NEVER (      pll_to_gen_overflow,
                        pll_to_gen_ovf,
                        posedge clk, ~rst_n,
                        `ERR_MSG ("Error: pll_to_gen FIFO overflow")
                );

  `ASSERTS_NEVER (      cb_rf_req_overflow,
                        cb_rf_req_ovf,
                        posedge clk, ~rst_n,
                        `ERR_MSG ("Error: cb_rf_req overflow")
                );

  `ASSERTS_NEVER (      cb_rf_req_underflow,
                        cb_rf_req_und,
                        posedge clk, ~rst_n,
                        `ERR_MSG ("Error: cb_rf_req underflow")
                );

  `ASSERTS_NEVER (      same_obj_diff_banks_assertion,
                        same_obj_diff_banks_err,
                        posedge clk, ~rst_n,
                        `ERR_MSG ("Error: same object accessed with different banks")
                );

  `ASSERTS_NEVER (      otf_rf_overflow,
                        ( otf_rf_inc & ~otf_rf_dec &  (&otf_rf)),
                        posedge clk, ~rst_n,
                        `ERR_MSG ("Error: otf_rf overflow")
                );

  `ASSERTS_NEVER (      otf_rf_underflow,
                        (~otf_rf_inc &  otf_rf_dec & ~(|otf_rf)),
                        posedge clk, ~rst_n,
                        `ERR_MSG ("Error: otf_rf underflow")
                );

  `ASSERTS_NEVER (      otf_wr_overflow,
                        ( otf_wr_inc & ~otf_wr_dec &  (&otf_wr)),
                        posedge clk, ~rst_n,
                        `ERR_MSG ("Error: otf_wr overflow")
                );

  `ASSERTS_NEVER (      otf_wr_underflow,
                        (~otf_wr_inc &  otf_wr_dec & ~(|otf_wr)),
                        posedge clk, ~rst_n,
                        `ERR_MSG ("Error: otf_wr underflow")
                );

  `COVERS (     osm_bp_pll_full,
                s1tosp_v & pll_full,
                clk, ~rst_n,
                `COVER_MSG ("OSM back-pressure due to pll_full")
        );

  `COVERS (     osm_bp_pll_to_gen_new_fifo_full,
                s1tosp_v & pll_to_gen_new_fifo_full,
                clk, ~rst_n,
                `COVER_MSG ("OSM back-pressure due to pll_to_gen_new_fifo_full")
        );

  `COVERS (     osm_pll_push,
                pll_push,
                clk, ~rst_n,
                `COVER_MSG ("OSM pll push")
        );

  `COVERS (     osm_pll_overflow,
                pll_full & pll_push,
                clk, ~rst_n,
                `COVER_MSG ("OSM pll overflow")
        );

  `endif



`include "fxp_cxp_cse_osm.VISA_IT.fxp_cxp_cse_osm.logic.sv" // Auto Included by VISA IT - *** Do not modify this line ***
endmodule

