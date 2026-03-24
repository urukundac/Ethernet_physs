//----------------------------------------------------------------------------------------------------------------
//                               INTEL CONFIDENTIAL
//           Copyright 2013-2014 Intel Corporation All Rights Reserved. 
// 
// The source code contained or described herein and all documents related to the source code ("Material")
// are owned by Intel Corporation or its suppliers or licensors. Title to the Material remains with Intel
// Corporation or its suppliers and licensors. The Material contains trade secrets and proprietary and confidential
// information of Intel or its suppliers and licensors. The Material is protected by worldwide copyright and trade
// secret laws and treaty provisions. No part of the Material may be used, copied, reproduced, modified, published,
// uploaded, posted, transmitted, distributed, or disclosed in any way without Intel's prior express written
// permission.
// 
// No license under any patent, copyright, trade secret or other intellectual property right is granted to or
// conferred upon you by disclosure or delivery of the Materials, either expressly, by implication, inducement,
// estoppel or otherwise. Any license under such intellectual property rights must be express and approved by
// Intel in writing.
//----------------------------------------------------------------------------------------------------------------

/*
 --------------------------------------------------------------------------
 -- Project Code      : axim_fabric
 -- Module Name       : axim_fabric_cbar_slave_b_egr_node
 -- Author            : Gregory James
 -- Associated modules: 
 -- Function          : This block is the egress node which interfaces with
                        AXI4 Slave B channel
 --------------------------------------------------------------------------
*/

`timescale 1ns / 10ps

`include  "axim_fabric_common_defines.svh"

module axim_fabric_cbar_slave_b_egr_node #(
//----------------------- Global parameters Declarations ------------------
  `include  "axim_fabric_b_params_decl.svh"

  ,parameter  NUM_MASTERS     = 4
  ,parameter  MASTER_ID_W     = (NUM_MASTERS > 1) ? $clog2(NUM_MASTERS) : 1

  ,parameter          FIFO_DEPTH      = 128
  ,parameter  string  FIFO_MEM_TYPE   = "BRAM"

) (
//----------------------- Slave Side B Interface ------------------------
   input  s_clk
  ,input  s_rst_n

  ,input  s_bvalid
  ,output s_bready
  ,input  s_bid
  ,input  s_bresp
  ,input  s_buser

//----------------------- Slave Egress B Interface -----------------------------
  ,input  ingr2egr_b_valid
  ,input  ingr2egr_b_data
  ,output ingr2egr_b_ready

//----------------------- Master Side Interface -----------------------------
  ,input  core_clk
  ,input  core_rst_n

  ,output core_b_valid
  ,input  core_b_ready
  ,output core_b_data


);

//----------------------- Global Data Types -------------------------------
  `_create_axi4_b_struct_t(axi4_b_struct_t,BID_W,BRESP_W,BUSER_W)
  `_create_axi4_ingr2egr_b_struct_t(axi4_ingr2egr_b_struct_t,MASTER_ID_W,BID_W)

//----------------------- Port Types -------------------------------------
  logic                     s_clk;
  logic                     s_rst_n;

  logic                     s_bvalid;
  logic                     s_bready;
  logic [BID_W-1:0]         s_bid;
  logic [BRESP_W-1:0]       s_bresp;
  logic [BUSER_W-1:0]       s_buser;


  logic                     ingr2egr_b_valid;
  axi4_ingr2egr_b_struct_t  ingr2egr_b_data;
  logic                     ingr2egr_b_ready;


  logic                     core_clk;
  logic                     core_rst_n;

  logic [NUM_MASTERS-1:0]   core_b_valid;
  logic [NUM_MASTERS-1:0]   core_b_ready;
  axi4_b_struct_t           core_b_data;


//----------------------- Internal Parameters -----------------------------
  localparam  AXI4_B_STRUCT_W           = $bits(axi4_b_struct_t);
  localparam  AXI4_INGR2EGR_B_STRUCT_W  = $bits(axi4_ingr2egr_b_struct_t);
  localparam  M_DECODE_FF_W             = NUM_MASTERS + MASTER_ID_W + 1;


//----------------------- Internal Register Declarations ------------------
  logic                       search_result_valid;
  logic [MASTER_ID_W-1:0]     search_result_master_id;
  logic [MASTER_ID_W-1:0]     search_result_master_id_current;
  axi4_b_struct_t             search_key_val;

//----------------------- Internal Wire Declarations ----------------------
  wire                      ff_wr_en;
  wire                      ff_wr_full;
  axi4_b_struct_t           ff_wr_data;
  logic                     ff_rd_en;
  wire                      ff_rd_empty;
  axi4_b_struct_t           ff_rd_data;

  wire                      m_dec_ff_full;
  wire                      m_dec_ff_wr_en;
  wire  [M_DECODE_FF_W-1:0] m_dec_ff_wr_data;
  wire                      m_dec_ff_empty;
  wire                      m_dec_ff_rd_en;
  wire  [M_DECODE_FF_W-1:0] m_dec_ff_rd_data;

  wire                      master_id_search_ff_full;
  logic                     search_en;
  axi4_ingr2egr_b_struct_t  search_data;
  logic                     search_found;
  logic                     search_miss;
  axi4_ingr2egr_b_struct_t  search_result;
  logic [NUM_MASTERS-1:0]   master_sel;
  wire                      m_decode_no_match_sync;
  wire  [NUM_MASTERS-1:0]   master_sel_sync;
  wire  [MASTER_ID_W-1:0]   master_id_sync;
  logic [MASTER_ID_W-1:0]   current_master_id;

  wire                      ff_ready;
  wire                      ff_ready_w_m_decode_match;
  wire                      flush_m_decode_no_match;

  wire                      core_master_ready;
  logic [NUM_MASTERS-1:0]   core_sel_next;


//----------------------- Start of Code -----------------------------------

  /*  Pack into struct  */
  assign  ff_wr_data.bid    = s_bid;
  assign  ff_wr_data.bresp  = s_bresp;
  assign  ff_wr_data.buser  = s_buser;

  assign  ff_wr_en  = s_bvalid  & s_bready;

  assign  s_bready  = ~ff_wr_full & ~master_id_search_ff_full;

  /*  Instantiate FIFO  */
  generic_async_fifo #(
     .WRITE_WIDTH       (AXI4_B_STRUCT_W)
    ,.READ_WIDTH        (AXI4_B_STRUCT_W)
    ,.NUM_BITS          (AXI4_B_STRUCT_W*FIFO_DEPTH)
    ,.MEM_TYPE          (FIFO_MEM_TYPE)
    ,.NUM_SYNC_STAGES   (3)

  ) u_async_fifo  (

    /*  input  logic                    */   .wr_clk          (s_clk)
    /*  input  logic                    */  ,.wr_rst_n        (s_rst_n)
    /*  input  logic                    */  ,.wr_en           (ff_wr_en)
    /*  input  logic [WIDTH-1:0]        */  ,.wr_data         (ff_wr_data)
    /*  output logic                    */  ,.wr_full         (ff_wr_full)
    /*  output logic [$clog2(DEPTH):0]  */  ,.wr_occupancy    ()
    /*  output logic                    */  ,.wr_overflow     ()

    /*  input  logic                    */  ,.rd_clk          (core_clk)
    /*  input  logic                    */  ,.rd_rst_n        (core_rst_n)
    /*  input  logic                    */  ,.rd_en           (ff_rd_en)
    /*  output logic [WIDTH-1:0]        */  ,.rd_data         (ff_rd_data)
    /*  output logic                    */  ,.rd_empty        (ff_rd_empty)
    /*  output logic [$clog2(DEPTH):0]  */  ,.rd_occupancy    ()
    /*  output logic                    */  ,.rd_underflow    ()

  );

  /*  Instantitate FIFO to search for WID->Master ID  */
  axi_fabric_search_key #(
     .DATA_WIDTH    (MASTER_ID_W)
    ,.KEY_WIDTH     (BID_W)

    ,.MODE          ("MEM")

    ,.DISABLE_FLUSH (1)

  ) u_master_id_search (

    /*  input  logic                  */   .clk             (s_clk)
    /*  input  logic                  */  ,.rst_n           (s_rst_n)

    /*  input  logic                  */  ,.wr_en           (ingr2egr_b_valid)
    /*  input  logic [DATA_WIDTH-1:0] */  ,.wr_data         (ingr2egr_b_data.master_id)
    /*  input  logic [KEY_WIDTH-1:0]  */  ,.wr_key          (ingr2egr_b_data.axi_id)
    /*  output logic                  */  ,.full            ()
    /*  output logic                  */  ,.afull           (master_id_search_ff_full)

    /*  input  logic                  */  ,.search_en       (search_en)
    /*  input  logic [KEY_WIDTH-1:0]  */  ,.search_key      (search_data.axi_id)
    /*  output logic                  */  ,.search_found    (search_found)
    /*  output logic                  */  ,.search_miss     (search_miss)
    /*  output logic [DATA_WIDTH-1:0] */  ,.search_result   (search_result.master_id)

  );

  assign  ingr2egr_b_ready  = ~master_id_search_ff_full;

  assign  search_en             = s_bvalid & s_bready;
  assign  search_data.master_id = {MASTER_ID_W{1'b0}};
  assign  search_data.axi_id    = s_bid;

  always_comb
  begin
    master_sel  = {NUM_MASTERS{1'b0}};

    master_sel[search_result.master_id] = 1'b1;
  end


  /*  Instantiate Master Decode FIFO  */
  generic_async_fifo #(
     .WRITE_WIDTH       (M_DECODE_FF_W)
    ,.READ_WIDTH        (M_DECODE_FF_W)
    ,.NUM_BITS          (M_DECODE_FF_W*FIFO_DEPTH)
    ,.MEM_TYPE          (FIFO_MEM_TYPE)
    ,.AFULL_THRESHOLD   (FIFO_DEPTH-1)
    ,.AEMPTY_THRESHOLD  (1)
    ,.NUM_SYNC_STAGES   (3)

  ) u_async_fifo_m_dec (

    /*  input  logic                    */   .wr_clk          (s_clk)
    /*  input  logic                    */  ,.wr_rst_n        (s_rst_n)
    /*  input  logic                    */  ,.wr_en           (m_dec_ff_wr_en)
    /*  input  logic [WIDTH-1:0]        */  ,.wr_data         (m_dec_ff_wr_data)
    /*  output logic                    */  ,.wr_full         ()
    /*  output logic                    */  ,.wr_afull        (m_dec_ff_full)
    /*  output logic [$clog2(DEPTH):0]  */  ,.wr_occupancy    ()
    /*  output logic                    */  ,.wr_overflow     ()

    /*  input  logic                    */  ,.rd_clk          (core_clk)
    /*  input  logic                    */  ,.rd_rst_n        (core_rst_n)
    /*  input  logic                    */  ,.rd_en           (m_dec_ff_rd_en)
    /*  output logic [WIDTH-1:0]        */  ,.rd_data         (m_dec_ff_rd_data)
    /*  output logic                    */  ,.rd_empty        (m_dec_ff_empty)
    /*  output logic                    */  ,.rd_aempty       ()
    /*  output logic [$clog2(DEPTH):0]  */  ,.rd_occupancy    ()
    /*  output logic                    */  ,.rd_underflow    ()

  );

  assign  m_dec_ff_wr_en   = search_found | search_miss;
  assign  m_dec_ff_wr_data = {search_miss,master_sel,search_result.master_id};

  assign  {m_decode_no_match_sync,master_sel_sync,master_id_sync}  = m_dec_ff_rd_data;



  /*  Master Interface Pipe  */
  always@(posedge core_clk, negedge core_rst_n)
  begin
    if(~core_rst_n)
    begin
      core_b_valid              <=  {NUM_MASTERS{1'b0}};
      core_b_data               <=  {AXI4_B_STRUCT_W{1'b0}};
      current_master_id         <=  {MASTER_ID_W{1'b0}};
    end
    else
    begin
      if(core_b_valid) //Request is valid this cycle
      begin
        if(core_master_ready)  //Got grant
        begin
          core_b_valid          <=  ff_ready_w_m_decode_match  ? master_sel_sync : {NUM_MASTERS{1'b0}};
          core_b_data           <=  ff_ready_w_m_decode_match  ? ff_rd_data      : core_b_data;
          current_master_id     <=  ff_ready_w_m_decode_match  ? master_id_sync  : current_master_id;
        end
      end
      else
      begin
        core_b_valid            <=  ff_ready_w_m_decode_match  ? master_sel_sync : core_b_valid;
        core_b_data             <=  ff_ready_w_m_decode_match  ? ff_rd_data      : core_b_data;
        current_master_id       <=  ff_ready_w_m_decode_match  ? master_id_sync  : current_master_id;
      end
    end
  end

  assign  ff_ready  = (ff_rd_empty | m_dec_ff_empty) ? 1'b0  : 1'b1;

  assign  flush_m_decode_no_match    = ff_ready  ? m_decode_no_match_sync   : 1'b0;
  assign  ff_ready_w_m_decode_match  = ff_ready  ? ~m_decode_no_match_sync  : 1'b0;

  always_comb
  begin
    if(core_b_valid)
    begin
      ff_rd_en  = core_master_ready & ff_ready;
    end
    else
    begin
      ff_rd_en  = ff_ready;
    end
  end

  assign  m_dec_ff_rd_en    = ff_rd_en;

  assign  core_master_ready = core_b_ready[current_master_id];


endmodule // axim_fabric_cbar_slave_b_egr_node
