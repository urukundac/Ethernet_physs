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
 -- Module Name       : axim_fabric_cbar_master_aw_egr_node
 -- Author            : Gregory James
 -- Associated modules: 
 -- Function          : This is the Master->Slave Egress node for AW channel
 --------------------------------------------------------------------------
*/

`timescale 1ns / 10ps

`include  "axim_fabric_common_defines.svh"

module axim_fabric_cbar_master_aw_egr_node #(
//----------------------- Global parameters Declarations ------------------
  `include  "axim_fabric_aw_params_decl.svh"

  ,parameter  NUM_SLAVES      = 4
  ,parameter  SLAVE_ID_W      = (NUM_SLAVES > 1) ? $clog2(NUM_SLAVES) : 1

  ,parameter          FIFO_DEPTH      = 128
  ,parameter  string  FIFO_MEM_TYPE   = "BRAM"

) (
//----------------------- Master Side AW Interface ------------------------
   input  m_clk
  ,input  m_rst_n

  ,input  addr_map

  ,input  m_awvalid
  ,output m_awready
  ,input  m_awid
  ,input  m_awaddr
  ,input  m_awlen
  ,input  m_awsize
  ,input  m_awburst
  ,input  m_awlock
  ,input  m_awcache
  ,input  m_awprot
  ,input  m_awqos
  ,input  m_awregion
  ,input  m_awuser


//----------------------- Slave Side Interface -----------------------------
  ,input  core_clk
  ,input  core_rst_n

  ,output core_aw_valid
  ,input  core_aw_ready
  ,output core_aw_data


//----------------------- AW->W Node Interface -----------------------------
  ,output aw2w_node_valid
  ,input  aw2w_node_ready
  ,output aw2w_node_data

);

//----------------------- Global Data Types -------------------------------
  `_create_axi4_aw_struct_t(axi4_aw_struct_t,AWID_W,AWADDR_W,AWLEN_W,AWSIZE_W,AWBURST_W,AWLOCK_W,AWCACHE_W,AWPROT_W,AWQOS_W,AWREGION_W,AWUSER_W)
  `_create_axi4_aw2w_node_struct_t(axi4_aw2w_node_struct_t,SLAVE_ID_W,AWID_W)


//----------------------- Port Types -------------------------------------
  logic                   m_clk;
  logic                   m_rst_n;

  logic [AWADDR_W-1:0]    addr_map [0:NUM_SLAVES-1][0:1];

  logic                   m_awvalid;
  logic                   m_awready;
  logic [AWID_W-1:0]      m_awid;
  logic [AWADDR_W-1:0]    m_awaddr;
  logic [AWLEN_W-1:0]     m_awlen;
  logic [AWSIZE_W-1:0]    m_awsize;
  logic [AWBURST_W-1:0]   m_awburst;
  logic [AWLOCK_W-1:0]    m_awlock;
  logic [AWCACHE_W-1:0]   m_awcache;
  logic [AWPROT_W-1:0]    m_awprot;
  logic [AWQOS_W-1:0]     m_awqos;
  logic [AWREGION_W-1:0]  m_awregion;
  logic [AWUSER_W-1:0]    m_awuser;


  logic                   core_clk;
  logic                   core_rst_n;

  logic [NUM_SLAVES-1:0]  core_aw_valid;
  logic [NUM_SLAVES-1:0]  core_aw_ready;
  axi4_aw_struct_t        core_aw_data;

  logic                   aw2w_node_valid;
  logic                   aw2w_node_ready;
  axi4_aw2w_node_struct_t aw2w_node_data;


//----------------------- Internal Parameters -----------------------------
  localparam  AXI4_AW_STRUCT_W  = $bits(axi4_aw_struct_t);
  localparam  ADDR_DECODE_FF_W  = NUM_SLAVES + SLAVE_ID_W + 1;


//----------------------- Internal Register Declarations ------------------


//----------------------- Internal Wire Declarations ----------------------
  axi4_aw_struct_t              m_axi4_aw_data;
  axi4_aw_struct_t              core_axi4_aw_data;

  wire                          aw_ff_full;
  wire                          aw_ff_empty;
  logic                         aw_ff_rd_en;

  wire                          addr_dec_ff_full;
  wire                          addr_dec_ff_wr_en;
  wire  [ADDR_DECODE_FF_W-1:0]  addr_dec_ff_wr_data;
  wire                          addr_dec_ff_empty;
  wire                          addr_dec_ff_rd_en;
  wire  [ADDR_DECODE_FF_W-1:0]  addr_dec_ff_rd_data;

  wire                          ff_ready;
  wire                          ff_ready_w_addr_decode_match;
  wire                          flush_addr_decode_no_match;

  wire                          addr_valid;
  wire                          addr_decode_valid;
  wire                          addr_decode_no_match;
  wire  [NUM_SLAVES-1:0]        slave_sel;
  wire  [SLAVE_ID_W-1:0]        slave_id;
  wire  [AWID_W-1:0]            awid;
  wire                          addr_decode_no_match_sync;
  wire  [NUM_SLAVES-1:0]        slave_sel_sync;
  wire  [SLAVE_ID_W-1:0]        slave_id_sync;
  logic [SLAVE_ID_W-1:0]        current_slave_id;

  wire                          core_slave_ready;

//----------------------- FSM Register Declarations ------------------


//----------------------- Start of Code -----------------------------------

  /*  Pack signals to structure */
  assign  m_axi4_aw_data.awid         = m_awid;
  assign  m_axi4_aw_data.awaddr       = m_awaddr;
  assign  m_axi4_aw_data.awlen        = m_awlen;
  assign  m_axi4_aw_data.awsize       = m_awsize;
  assign  m_axi4_aw_data.awburst      = m_awburst;
  assign  m_axi4_aw_data.awlock       = m_awlock;
  assign  m_axi4_aw_data.awcache      = m_awcache;
  assign  m_axi4_aw_data.awprot       = m_awprot;
  assign  m_axi4_aw_data.awqos        = m_awqos;
  assign  m_axi4_aw_data.awregion     = m_awregion;
  assign  m_axi4_aw_data.awuser       = m_awuser;

  assign  m_awready = ~aw_ff_full & ~addr_dec_ff_full & aw2w_node_ready;

  /*  Instantiate AW Struct FIFO  */
  generic_async_fifo #(
     .WRITE_WIDTH       (AXI4_AW_STRUCT_W)
    ,.READ_WIDTH        (AXI4_AW_STRUCT_W)
    ,.NUM_BITS          (AXI4_AW_STRUCT_W*FIFO_DEPTH)
    ,.MEM_TYPE          (FIFO_MEM_TYPE)
    ,.NUM_SYNC_STAGES   (3)

  ) u_async_fifo_aw (

    /*  input  logic                    */   .wr_clk          (m_clk)
    /*  input  logic                    */  ,.wr_rst_n        (m_rst_n)
    /*  input  logic                    */  ,.wr_en           (m_awvalid)
    /*  input  logic [WIDTH-1:0]        */  ,.wr_data         (m_axi4_aw_data)
    /*  output logic                    */  ,.wr_full         (aw_ff_full)
    /*  output logic [$clog2(DEPTH):0]  */  ,.wr_occupancy    ()
    /*  output logic                    */  ,.wr_overflow     ()

    /*  input  logic                    */  ,.rd_clk          (core_clk)
    /*  input  logic                    */  ,.rd_rst_n        (core_rst_n)
    /*  input  logic                    */  ,.rd_en           (aw_ff_rd_en)
    /*  output logic [WIDTH-1:0]        */  ,.rd_data         (core_axi4_aw_data)
    /*  output logic                    */  ,.rd_empty        (aw_ff_empty)
    /*  output logic [$clog2(DEPTH):0]  */  ,.rd_occupancy    ()
    /*  output logic                    */  ,.rd_underflow    ()

  );

  /*  Instantitate Address Decoder  */
  axi_fabric_addr_decode #(
     .NUM_SLAVES    (NUM_SLAVES)
    ,.SLAVE_ID_W    (SLAVE_ID_W)
    ,.ADDR_W        (AWADDR_W)
    ,.CARGO_W       (AWID_W)

  ) u_addr_decode (
    /*  input  logic                  */   .clk                   (m_clk)
    /*  input  logic                  */  ,.rst_n                 (m_rst_n)

    /*  input  logic <addr-map-dim>   */  ,.addr_map              (addr_map)
    /*  input  logic                  */  ,.addr_valid            (addr_valid)
    /*  input  logic [ADDR_W-1:0]     */  ,.addr                  (m_axi4_aw_data.awaddr)
    /*  input  logic [CARGO_W-1:0]    */  ,.cargo_in              (m_axi4_aw_data.awid)

    /*  output logic                  */  ,.addr_decode_valid     (addr_decode_valid)
    /*  output logic                  */  ,.addr_decode_no_match  (addr_decode_no_match)
    /*  output logic [NUM_SLAVES-1:0] */  ,.slave_sel             (slave_sel)
    /*  output logic [SLAVE_ID_W-1:0] */  ,.slave_id              (slave_id)
    /*  output logic [CARGO_W-1:0]    */  ,.cargo_out             (awid)

  );

  assign  addr_valid  = m_awvalid & m_awready;

  /*  Send decoded slave-id & axi-id to W node  */
  assign  aw2w_node_valid         = addr_decode_valid;

  assign  aw2w_node_data.slave_id = slave_id;
  assign  aw2w_node_data.axi_id   = awid;



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

  assign  addr_dec_ff_wr_en   = addr_decode_valid | addr_decode_no_match;
  assign  addr_dec_ff_wr_data = {addr_decode_no_match,slave_sel,slave_id};

  assign  {addr_decode_no_match_sync,slave_sel_sync,slave_id_sync}  = addr_dec_ff_rd_data;


  /*  Slave Interface Pipe  */
  always@(posedge core_clk, negedge core_rst_n)
  begin
    if(~core_rst_n)
    begin
      core_aw_valid             <=  {NUM_SLAVES{1'b0}};
      core_aw_data              <=  {AXI4_AW_STRUCT_W{1'b0}};

      current_slave_id          <=  {SLAVE_ID_W{1'b0}};
    end
    else
    begin
      if(core_aw_valid) //Request is valid this cycle
      begin
        if(core_slave_ready)  //Got grant
        begin
          core_aw_valid         <=  ff_ready_w_addr_decode_match  ? slave_sel_sync    : {NUM_SLAVES{1'b0}};
          core_aw_data          <=  ff_ready_w_addr_decode_match  ? core_axi4_aw_data : core_aw_data;
          current_slave_id      <=  ff_ready_w_addr_decode_match  ? slave_id_sync     : current_slave_id;
        end
      end
      else
      begin
        core_aw_valid           <=  ff_ready_w_addr_decode_match  ? slave_sel_sync    : core_aw_valid;
        core_aw_data            <=  ff_ready_w_addr_decode_match  ? core_axi4_aw_data : core_aw_data;
        current_slave_id        <=  ff_ready_w_addr_decode_match  ? slave_id_sync     : current_slave_id;
      end
    end
  end

  assign  ff_ready  = (aw_ff_empty | addr_dec_ff_empty) ? 1'b0  : 1'b1;

  assign  flush_addr_decode_no_match    = ff_ready  ? addr_decode_no_match_sync   : 1'b0;
  assign  ff_ready_w_addr_decode_match  = ff_ready  ? ~addr_decode_no_match_sync  : 1'b0;

  always_comb
  begin
    if(core_aw_valid)
    begin
      aw_ff_rd_en = core_slave_ready & ff_ready;
    end
    else
    begin
      aw_ff_rd_en = ff_ready;
    end
  end

  assign  addr_dec_ff_rd_en = aw_ff_rd_en;

  assign  core_slave_ready  = core_aw_ready[current_slave_id];

endmodule // axim_fabric_cbar_master_aw_egr_node
