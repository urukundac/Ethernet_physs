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
 -- Module Name       : axim_fabric_cbar_master_ar_egr_node
 -- Author            : Gregory James
 -- Associated modules: 
 -- Function          : This is the Master->Slave Egress node for AR channel
 --------------------------------------------------------------------------
*/

`timescale 1ns / 10ps

`include  "axim_fabric_common_defines.svh"

module axim_fabric_cbar_master_ar_egr_node #(
//----------------------- Global parameters Declarations ------------------
  `include  "axim_fabric_ar_params_decl.svh"

  ,parameter  NUM_SLAVES      = 4
  ,parameter  SLAVE_ID_W      = (NUM_SLAVES > 1) ? $clog2(NUM_SLAVES) : 1

  ,parameter          FIFO_DEPTH      = 128
  ,parameter  string  FIFO_MEM_TYPE   = "BRAM"

) (
//----------------------- Master Side AR Interface ------------------------
   input  m_clk
  ,input  m_rst_n

  ,input  addr_map

  ,input  m_arvalid
  ,output m_arready
  ,input  m_arid
  ,input  m_araddr
  ,input  m_arlen
  ,input  m_arsize
  ,input  m_arburst
  ,input  m_arlock
  ,input  m_arcache
  ,input  m_arprot
  ,input  m_arqos
  ,input  m_arregion
  ,input  m_aruser


//----------------------- Slave Side Interface -----------------------------
  ,input  core_clk
  ,input  core_rst_n

  ,output core_ar_valid
  ,input  core_ar_ready
  ,output core_ar_data

);

//----------------------- Global Data Types -------------------------------
  `_create_axi4_ar_struct_t(axi4_ar_struct_t,ARID_W,ARADDR_W,ARLEN_W,ARSIZE_W,ARBURST_W,ARLOCK_W,ARCACHE_W,ARPROT_W,ARQOS_W,ARREGION_W,ARUSER_W)


//----------------------- Port Types -------------------------------------
  logic                   m_clk;
  logic                   m_rst_n;

  logic [ARADDR_W-1:0]    addr_map [0:NUM_SLAVES-1][0:1];

  logic                   m_arvalid;
  logic                   m_arready;
  logic [ARID_W-1:0]      m_arid;
  logic [ARADDR_W-1:0]    m_araddr;
  logic [ARLEN_W-1:0]     m_arlen;
  logic [ARSIZE_W-1:0]    m_arsize;
  logic [ARBURST_W-1:0]   m_arburst;
  logic [ARLOCK_W-1:0]    m_arlock;
  logic [ARCACHE_W-1:0]   m_arcache;
  logic [ARPROT_W-1:0]    m_arprot;
  logic [ARQOS_W-1:0]     m_arqos;
  logic [ARREGION_W-1:0]  m_arregion;
  logic [ARUSER_W-1:0]    m_aruser;


  logic                   core_clk;
  logic                   core_rst_n;

  logic [NUM_SLAVES-1:0]  core_ar_valid;
  logic [NUM_SLAVES-1:0]  core_ar_ready;
  axi4_ar_struct_t        core_ar_data;



//----------------------- Internal Parameters -----------------------------
  localparam  AXI4_AR_STRUCT_W  = $bits(axi4_ar_struct_t);
  localparam  ADDR_DECODE_FF_W  = NUM_SLAVES + SLAVE_ID_W + 1;


//----------------------- Internal Register Declarations ------------------
  logic                       addr_valid_1d;
  logic                       addr_decode_valid_1d;


//----------------------- Internal Wire Declarations ----------------------
  axi4_ar_struct_t              m_axi4_ar_data;
  axi4_ar_struct_t              core_axi4_ar_data;

  wire                          ar_ff_full;
  wire                          ar_ff_empty;
  logic                         ar_ff_rd_en;

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
  wire                          addr_decode_no_match_sync;
  wire  [NUM_SLAVES-1:0]        slave_sel_sync;
  wire  [SLAVE_ID_W-1:0]        slave_id_sync;
  logic [SLAVE_ID_W-1:0]        current_slave_id;

  wire                          core_slave_ready;

//----------------------- FSM Register Declarations ------------------


//----------------------- Start of Code -----------------------------------

  /*  Pack signals to structure */
  assign  m_axi4_ar_data.arid         = m_arid;
  assign  m_axi4_ar_data.araddr       = m_araddr;
  assign  m_axi4_ar_data.arlen        = m_arlen;
  assign  m_axi4_ar_data.arsize       = m_arsize;
  assign  m_axi4_ar_data.arburst      = m_arburst;
  assign  m_axi4_ar_data.arlock       = m_arlock;
  assign  m_axi4_ar_data.arcache      = m_arcache;
  assign  m_axi4_ar_data.arprot       = m_arprot;
  assign  m_axi4_ar_data.arqos        = m_arqos;
  assign  m_axi4_ar_data.arregion     = m_arregion;
  assign  m_axi4_ar_data.aruser       = m_aruser;

  assign  m_arready = ~ar_ff_full & ~addr_dec_ff_full;

  /*  Instantiate FIFO  */
  generic_async_fifo #(
     .WRITE_WIDTH       (AXI4_AR_STRUCT_W)
    ,.READ_WIDTH        (AXI4_AR_STRUCT_W)
    ,.NUM_BITS          (AXI4_AR_STRUCT_W*FIFO_DEPTH)
    ,.MEM_TYPE          (FIFO_MEM_TYPE)
    ,.NUM_SYNC_STAGES   (3)

  ) u_async_fifo  (

    /*  input  logic                    */   .wr_clk          (m_clk)
    /*  input  logic                    */  ,.wr_rst_n        (m_rst_n)
    /*  input  logic                    */  ,.wr_en           (m_arvalid)
    /*  input  logic [WIDTH-1:0]        */  ,.wr_data         (m_axi4_ar_data)
    /*  output logic                    */  ,.wr_full         (ar_ff_full)
    /*  output logic [$clog2(DEPTH):0]  */  ,.wr_occupancy    ()
    /*  output logic                    */  ,.wr_overflow     ()

    /*  input  logic                    */  ,.rd_clk          (core_clk)
    /*  input  logic                    */  ,.rd_rst_n        (core_rst_n)
    /*  input  logic                    */  ,.rd_en           (ar_ff_rd_en)
    /*  output logic [WIDTH-1:0]        */  ,.rd_data         (core_axi4_ar_data)
    /*  output logic                    */  ,.rd_empty        (ar_ff_empty)
    /*  output logic [$clog2(DEPTH):0]  */  ,.rd_occupancy    ()
    /*  output logic                    */  ,.rd_underflow    ()

  );

  /*  Instantitate Address Decoder  */
  axi_fabric_addr_decode #(
     .NUM_SLAVES    (NUM_SLAVES)
    ,.SLAVE_ID_W    (SLAVE_ID_W)
    ,.ADDR_W        (ARADDR_W)
    ,.CARGO_W       (1)

  ) u_addr_decode (
    /*  input  logic                  */   .clk                   (m_clk)
    /*  input  logic                  */  ,.rst_n                 (m_rst_n)

    /*  input  logic <addr-map-dim>   */  ,.addr_map              (addr_map)
    /*  input  logic                  */  ,.addr_valid            (addr_valid)
    /*  input  logic [ADDR_W-1:0]     */  ,.addr                  (m_axi4_ar_data.araddr)
    /*  input  logic [CARGO_W-1:0]    */  ,.cargo_in              (1'b0)

    /*  output logic                  */  ,.addr_decode_valid     (addr_decode_valid)
    /*  output logic                  */  ,.addr_decode_no_match  (addr_decode_no_match)
    /*  output logic [NUM_SLAVES-1:0] */  ,.slave_sel             (slave_sel)
    /*  output logic [SLAVE_ID_W-1:0] */  ,.slave_id              (slave_id)
    /*  output logic [CARGO_W-1:0]    */  ,.cargo_out             ()

  );

  assign  addr_valid  = m_arvalid & m_arready;

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
      core_ar_valid             <=  {NUM_SLAVES{1'b0}};
      core_ar_data              <=  {AXI4_AR_STRUCT_W{1'b0}};

      current_slave_id          <=  {SLAVE_ID_W{1'b0}};
    end
    else
    begin
      if(core_ar_valid) //Request is valid this cycle
      begin
        if(core_slave_ready)  //Got grant
        begin
          core_ar_valid         <=  ff_ready_w_addr_decode_match  ? slave_sel_sync    : {NUM_SLAVES{1'b0}};
          core_ar_data          <=  ff_ready_w_addr_decode_match  ? core_axi4_ar_data : core_ar_data;
          current_slave_id      <=  ff_ready_w_addr_decode_match  ? slave_id_sync     : current_slave_id;
        end
      end
      else
      begin
        core_ar_valid           <=  ff_ready_w_addr_decode_match  ? slave_sel_sync    : core_ar_valid;
        core_ar_data            <=  ff_ready_w_addr_decode_match  ? core_axi4_ar_data : core_ar_data;
        current_slave_id        <=  ff_ready_w_addr_decode_match  ? slave_id_sync     : current_slave_id;
      end
    end
  end

  assign  ff_ready  = (ar_ff_empty | addr_dec_ff_empty) ? 1'b0  : 1'b1;

  assign  flush_addr_decode_no_match    = ff_ready  ? addr_decode_no_match_sync   : 1'b0;
  assign  ff_ready_w_addr_decode_match  = ff_ready  ? ~addr_decode_no_match_sync  : 1'b0;

  always_comb
  begin
    if(core_ar_valid)
    begin
      ar_ff_rd_en = core_slave_ready & ff_ready;
    end
    else
    begin
      ar_ff_rd_en = ff_ready;
    end
  end

  assign  addr_dec_ff_rd_en = ar_ff_rd_en;

  assign  core_slave_ready  = core_ar_ready[current_slave_id];


endmodule // axim_fabric_cbar_master_ar_egr_node
