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
 -- Module Name       : axim_fabric_cbar_master_w_egr_node
 -- Author            : Gregory James
 -- Associated modules: 
 -- Function          : This is the Master->Slave Egress node for W channel
 --------------------------------------------------------------------------
*/

`timescale 1ns / 10ps

`include  "axim_fabric_common_defines.svh"

module axim_fabric_cbar_master_w_egr_node #(
//----------------------- Global parameters Declarations ------------------
  `include  "axim_fabric_w_params_decl.svh"

  ,parameter  NUM_SLAVES      = 4
  ,parameter  SLAVE_ID_W      = (NUM_SLAVES > 1) ? $clog2(NUM_SLAVES) : 1

  ,parameter          FIFO_DEPTH      = 128
  ,parameter  string  FIFO_MEM_TYPE   = "BRAM"


) (
//----------------------- Master Side AW Interface ------------------------
   input  m_clk
  ,input  m_rst_n

  ,input  m_wvalid
  ,output m_wready
  ,input  m_wid
  ,input  m_wdata
  ,input  m_wstrb
  ,input  m_wlast
  ,input  m_wuser

//----------------------- Slave Side Interface -----------------------------
  ,input  core_clk
  ,input  core_rst_n

  ,output core_w_valid
  ,input  core_w_ready
  ,output core_w_data

//----------------------- AW->W Node Interface -----------------------------
  ,input  aw2w_node_valid
  ,output aw2w_node_ready
  ,input  aw2w_node_data

);

//----------------------- Global Data Types -------------------------------
  `_create_axi4_w_struct_t(axi4_w_struct_t,WID_W,WDATA_W,WSTRB_W,WLAST_W,WUSER_W)
  `_create_axi4_aw2w_node_struct_t(axi4_aw2w_node_struct_t,SLAVE_ID_W,WID_W)


//----------------------- Port Types -------------------------------------
  logic                   m_clk;
  logic                   m_rst_n;

  logic                   m_wvalid;
  logic                   m_wready;
  logic [WID_W-1:0]       m_wid;
  logic [WDATA_W-1:0]     m_wdata;
  logic [WSTRB_W-1:0]     m_wstrb;
  logic [WLAST_W-1:0]     m_wlast;
  logic [WUSER_W-1:0]     m_wuser;


  logic                   core_clk;
  logic                   core_rst_n;

  logic [NUM_SLAVES-1:0]  core_w_valid;
  logic [NUM_SLAVES-1:0]  core_w_ready;
  axi4_w_struct_t         core_w_data;

  logic                   aw2w_node_valid;
  logic                   aw2w_node_ready;
  axi4_aw2w_node_struct_t aw2w_node_data;


//----------------------- Internal Parameters -----------------------------
  localparam  AXI4_W_STRUCT_W   = $bits(axi4_w_struct_t);
  localparam  AW2W_STRUCT_W     = $bits(axi4_aw2w_node_struct_t);
  localparam  ADDR_DECODE_FF_W  = NUM_SLAVES + SLAVE_ID_W + 1;


//----------------------- Internal Register Declarations ------------------
  logic                       search_result_valid;
  logic [SLAVE_ID_W-1:0]      search_result_slave_id;
  logic [SLAVE_ID_W-1:0]      search_result_slave_id_current;
  axi4_w_struct_t             search_w_data;


//----------------------- Internal Wire Declarations ----------------------
  axi4_w_struct_t               m_axi4_w_data;
  axi4_w_struct_t               core_axi4_w_data;

  wire                          w_ff_full;
  wire                          w_ff_empty;
  logic                         w_ff_rd_en;

  wire                          addr_dec_ff_full;
  wire                          addr_dec_ff_wr_en;
  wire  [ADDR_DECODE_FF_W-1:0]  addr_dec_ff_wr_data;
  wire                          addr_dec_ff_empty;
  wire                          addr_dec_ff_rd_en;
  wire  [ADDR_DECODE_FF_W-1:0]  addr_dec_ff_rd_data;

  wire                          ff_ready;
  wire                          ff_ready_w_addr_decode_match;
  wire                          flush_addr_decode_no_match;

  wire                          slave_id_search_ff_full;
  logic                         search_en;
  axi4_aw2w_node_struct_t       search_data;
  logic                         search_found;
  logic                         search_miss;
  axi4_aw2w_node_struct_t       search_result;
  logic [NUM_SLAVES-1:0]        slave_sel;
  wire                          addr_decode_no_match_sync;
  wire  [NUM_SLAVES-1:0]        slave_sel_sync;
  wire  [SLAVE_ID_W-1:0]        slave_id_sync;
  logic [SLAVE_ID_W-1:0]        current_slave_id;

  wire                          core_slave_ready;
  logic [NUM_SLAVES-1:0]        core_sel_next;


//----------------------- Start of Code -----------------------------------

  /*  Pack signals to structure */
  assign  m_axi4_w_data.wid   = m_wid;
  assign  m_axi4_w_data.wdata = m_wdata;
  assign  m_axi4_w_data.wstrb = m_wstrb;
  assign  m_axi4_w_data.wlast = m_wlast;
  assign  m_axi4_w_data.wuser = m_wuser;

  assign  m_wready  = ~w_ff_full;
 
  /*  Instantiate FIFO  */
  generic_async_fifo #(
     .WRITE_WIDTH       (AXI4_W_STRUCT_W)
    ,.READ_WIDTH        (AXI4_W_STRUCT_W)
    ,.NUM_BITS          (AXI4_W_STRUCT_W*FIFO_DEPTH)
    ,.MEM_TYPE          (FIFO_MEM_TYPE)
    ,.NUM_SYNC_STAGES   (3)

  ) u_async_fifo  (

    /*  input  logic                    */   .wr_clk          (m_clk)
    /*  input  logic                    */  ,.wr_rst_n        (m_rst_n)
    /*  input  logic                    */  ,.wr_en           (m_wvalid)
    /*  input  logic [WIDTH-1:0]        */  ,.wr_data         (m_axi4_w_data)
    /*  output logic                    */  ,.wr_full         (w_ff_full)
    /*  output logic [$clog2(DEPTH):0]  */  ,.wr_occupancy    ()
    /*  output logic                    */  ,.wr_overflow     ()

    /*  input  logic                    */  ,.rd_clk          (core_clk)
    /*  input  logic                    */  ,.rd_rst_n        (core_rst_n)
    /*  input  logic                    */  ,.rd_en           (w_ff_rd_en)
    /*  output logic [WIDTH-1:0]        */  ,.rd_data         (core_axi4_w_data)
    /*  output logic                    */  ,.rd_empty        (w_ff_empty)
    /*  output logic [$clog2(DEPTH):0]  */  ,.rd_occupancy    ()
    /*  output logic                    */  ,.rd_underflow    ()

  );

  /*  Instantiate FF/MEM to hold decoded slave ids  */
  axi_fabric_search_key #(
     .DATA_WIDTH            (SLAVE_ID_W)
    ,.KEY_WIDTH             (WID_W)

    ,.MODE                  ("MEM")

    ,.FIFO_DEPTH            (16)
    ,.FIFO_AFULL_THRESHOLD  (16-4)
    ,.FIFO_MEM_TYPE         ("REG")
    ,.DISABLE_FLUSH         (1)

  ) u_slave_id_search (

    /*  input  logic                  */   .clk             (m_clk)
    /*  input  logic                  */  ,.rst_n           (m_rst_n)

    /*  input  logic                  */  ,.wr_en           (aw2w_node_valid)
    /*  input  logic [DATA_WIDTH-1:0] */  ,.wr_data         (aw2w_node_data.slave_id)
    /*  input  logic [KEY_WIDTH-1:0]  */  ,.wr_key          (aw2w_node_data.axi_id)
    /*  output logic                  */  ,.full            ()
    /*  output logic                  */  ,.afull           (slave_id_search_ff_full)

    /*  input  logic                  */  ,.search_en       (search_en)
    /*  input  logic [KEY_WIDTH-1:0]  */  ,.search_key      (search_data.axi_id)
    /*  output logic                  */  ,.search_found    (search_found)
    /*  output logic                  */  ,.search_miss     (search_miss)
    /*  output logic [DATA_WIDTH-1:0] */  ,.search_result   (search_result.slave_id)

  );

  assign  aw2w_node_ready = ~slave_id_search_ff_full;

  assign  search_en             = m_wvalid & m_wready;
  assign  search_data.slave_id  = {SLAVE_ID_W{1'b0}};
  assign  search_data.axi_id    = m_wid;

  always_comb
  begin
    slave_sel = {NUM_SLAVES{1'b0}};

    slave_sel[search_result.slave_id] = 1'b1;
  end


  /*  Instantiate Address Decode FIFO  */
  generic_async_fifo #(
     .WRITE_WIDTH       (ADDR_DECODE_FF_W)
    ,.READ_WIDTH        (ADDR_DECODE_FF_W)
    ,.NUM_BITS          (ADDR_DECODE_FF_W*FIFO_DEPTH)
    ,.MEM_TYPE          (FIFO_MEM_TYPE)
    ,.AFULL_THRESHOLD   (FIFO_DEPTH-1)
    ,.AEMPTY_THRESHOLD  (1)
    ,.NUM_SYNC_STAGES   (3)

  ) u_async_fifo_addr_dec (

    /*  input  logic                    */   .wr_clk          (m_clk)
    /*  input  logic                    */  ,.wr_rst_n        (m_rst_n)
    /*  input  logic                    */  ,.wr_en           (addr_dec_ff_wr_en)
    /*  input  logic [WIDTH-1:0]        */  ,.wr_data         (addr_dec_ff_wr_data)
    /*  output logic                    */  ,.wr_full         ()
    /*  output logic                    */  ,.wr_afull        (addr_dec_ff_full)
    /*  output logic [$clog2(DEPTH):0]  */  ,.wr_occupancy    ()
    /*  output logic                    */  ,.wr_overflow     ()

    /*  input  logic                    */  ,.rd_clk          (core_clk)
    /*  input  logic                    */  ,.rd_rst_n        (core_rst_n)
    /*  input  logic                    */  ,.rd_en           (addr_dec_ff_rd_en)
    /*  output logic [WIDTH-1:0]        */  ,.rd_data         (addr_dec_ff_rd_data)
    /*  output logic                    */  ,.rd_empty        (addr_dec_ff_empty)
    /*  output logic                    */  ,.rd_aempty       ()
    /*  output logic [$clog2(DEPTH):0]  */  ,.rd_occupancy    ()
    /*  output logic                    */  ,.rd_underflow    ()

  );

  assign  addr_dec_ff_wr_en   = search_found | search_miss;
  assign  addr_dec_ff_wr_data = {search_miss,slave_sel,search_result.slave_id};

  assign  {addr_decode_no_match_sync,slave_sel_sync,slave_id_sync}  = addr_dec_ff_rd_data;



  /*  Slave Interface Pipe  */
  always@(posedge core_clk, negedge core_rst_n)
  begin
    if(~core_rst_n)
    begin
      core_w_valid              <=  {NUM_SLAVES{1'b0}};
      core_w_data               <=  {AXI4_W_STRUCT_W{1'b0}};

      current_slave_id          <=  {SLAVE_ID_W{1'b0}};
    end
    else
    begin
      if(core_w_valid) //Request is valid this cycle
      begin
        if(core_slave_ready)  //Got grant
        begin
          core_w_valid          <=  ff_ready_w_addr_decode_match  ? slave_sel_sync   : {NUM_SLAVES{1'b0}};
          core_w_data           <=  ff_ready_w_addr_decode_match  ? core_axi4_w_data : core_w_data;
          current_slave_id      <=  ff_ready_w_addr_decode_match  ? slave_id_sync    : current_slave_id;
        end
      end
      else
      begin
        core_w_valid            <=  ff_ready_w_addr_decode_match  ? slave_sel_sync   : core_w_valid;
        core_w_data             <=  ff_ready_w_addr_decode_match  ? core_axi4_w_data : core_w_data;
        current_slave_id        <=  ff_ready_w_addr_decode_match  ? slave_id_sync    : current_slave_id;
      end
    end
  end

  assign  ff_ready  = (w_ff_empty | addr_dec_ff_empty) ? 1'b0  : 1'b1;

  assign  flush_addr_decode_no_match    = ff_ready  ? addr_decode_no_match_sync   : 1'b0;
  assign  ff_ready_w_addr_decode_match  = ff_ready  ? ~addr_decode_no_match_sync  : 1'b0;

  always_comb
  begin
    if(core_w_valid)
    begin
      w_ff_rd_en  = core_slave_ready & ff_ready;
    end
    else
    begin
      w_ff_rd_en  = ff_ready;
    end
  end

  assign  addr_dec_ff_rd_en = w_ff_rd_en;

  assign  core_slave_ready  = core_w_ready[current_slave_id];


endmodule // axim_fabric_cbar_master_w_egr_node
