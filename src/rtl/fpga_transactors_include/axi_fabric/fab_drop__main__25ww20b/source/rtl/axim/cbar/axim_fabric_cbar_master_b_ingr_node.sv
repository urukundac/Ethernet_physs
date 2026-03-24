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
 -- Module Name       : axim_fabric_cbar_master_b_ingr_node
 -- Author            : Gregory James
 -- Associated modules: 
 -- Function          : This block arbitrates beween different slave B nodes
                        interfaces with the Master B interface
 --------------------------------------------------------------------------
*/

`timescale 1ns / 10ps

`include  "axim_fabric_common_defines.svh"

module axim_fabric_cbar_master_b_ingr_node #(
//----------------------- Global parameters Declarations ------------------
  `include  "axim_fabric_b_params_decl.svh"

  ,parameter  NUM_SLAVES      = 4
  ,parameter  SLAVE_ID_W      = (NUM_SLAVES > 1) ? $clog2(NUM_SLAVES) : 1

  ,parameter          FIFO_DEPTH      = 128
  ,parameter  string  FIFO_MEM_TYPE   = "BRAM"


) (
//----------------------- Slave Side Interface -----------------------------
   input  core_clk
  ,input  core_rst_n

  ,input  core_b_valid
  ,output core_b_ready
  ,input  core_b_data

//----------------------- Master Side B Interface ------------------------
  ,input  m_clk
  ,input  m_rst_n

  ,output m_bvalid
  ,input  m_bready
  ,output m_bid
  ,output m_bresp
  ,output m_buser

);

//----------------------- Import Packages ---------------------------------
  `_create_axi4_b_struct_t(axi4_b_struct_t,BID_W,BRESP_W,BUSER_W)


//----------------------- Port Types -------------------------------------
  logic                     core_clk;
  logic                     core_rst_n;

  logic [NUM_SLAVES-1:0]    core_b_valid;
  logic [NUM_SLAVES-1:0]    core_b_ready;
  axi4_b_struct_t           core_b_data [NUM_SLAVES-1:0];


  logic                     m_clk;
  logic                     m_rst_n;

  logic                     m_bvalid;
  logic                     m_bready;
  logic [BID_W-1:0]         m_bid;
  logic [BRESP_W-1:0]       m_bresp;
  logic [BUSER_W-1:0]       m_buser;



//----------------------- Internal Parameters -----------------------------
  localparam  AXI4_B_STRUCT_W           = $bits(axi4_b_struct_t);


//----------------------- Internal Register Declarations ------------------


//----------------------- Internal Wire Declarations ----------------------
  wire  [NUM_SLAVES-1:0]            agent_req;
  wire                              gnt_valid;
  wire  [SLAVE_ID_W-1:0]            gnt_agent_id;
  wire  [NUM_SLAVES-1:0]            gnt_agents_sel;

  axi4_b_struct_t                   ff_wr_data;
  wire                              ff_wr_full;
  axi4_b_struct_t                   ff_rd_data;
  wire                              ff_rd_en;
  wire                              ff_rd_empty;




//----------------------- Start of Code -----------------------------------

  /*  Instantiate Arbiter */
  axi_fabric_arb #(
     .NUM_AGENTS    (NUM_SLAVES)
    ,.AGENT_ID_W    (SLAVE_ID_W)
    ,.PRIORITY_W    (2)
    ,.MODE          ("NORMAL")

  ) u_axi_fabric_arb  (

    /*  input  logic                          */   .clk             (core_clk)
    /*  input  logic                          */  ,.rst_n           (core_rst_n)

    /*  input  logic [NUM_AGENTS-1:0]         */  ,.agent_req       (agent_req)

    /*  output logic                          */  ,.gnt_valid       (gnt_valid)
    /*  output logic [AGENT_ID_W-1:0]         */  ,.gnt_agent_id    (gnt_agent_id)
    /*  output logic [NUM_AGENTS-1:0]         */  ,.gnt_agent_sel   (gnt_agents_sel)

  );

  assign  agent_req     = ff_wr_full  ? {NUM_SLAVES{1'b0}} : core_b_valid;


  /*  Instantiate FIFO  */
  generic_async_fifo #(
     .WRITE_WIDTH       (AXI4_B_STRUCT_W)
    ,.READ_WIDTH        (AXI4_B_STRUCT_W)
    ,.NUM_BITS          (AXI4_B_STRUCT_W*FIFO_DEPTH)
    ,.MEM_TYPE          (FIFO_MEM_TYPE)
    ,.NUM_SYNC_STAGES   (3)

  ) u_async_fifo  (

    /*  input  logic                    */   .wr_clk          (core_clk)
    /*  input  logic                    */  ,.wr_rst_n        (core_rst_n)
    /*  input  logic                    */  ,.wr_en           (gnt_valid)
    /*  input  logic [WIDTH-1:0]        */  ,.wr_data         (ff_wr_data)
    /*  output logic                    */  ,.wr_full         (ff_wr_full)
    /*  output logic [$clog2(DEPTH):0]  */  ,.wr_occupancy    ()
    /*  output logic                    */  ,.wr_overflow     ()

    /*  input  logic                    */  ,.rd_clk          (m_clk)
    /*  input  logic                    */  ,.rd_rst_n        (m_rst_n)
    /*  input  logic                    */  ,.rd_en           (ff_rd_en)
    /*  output logic [WIDTH-1:0]        */  ,.rd_data         (ff_rd_data)
    /*  output logic                    */  ,.rd_empty        (ff_rd_empty)
    /*  output logic [$clog2(DEPTH):0]  */  ,.rd_occupancy    ()
    /*  output logic                    */  ,.rd_underflow    ()

  );

  assign  core_b_ready  = gnt_agents_sel;

  assign  ff_wr_data  = core_b_data[gnt_agent_id];

  /*  Unpack Struct Signals */
  assign  m_bid   = ff_rd_data.bid;
  assign  m_bresp = ff_rd_data.bresp;
  assign  m_buser = ff_rd_data.buser;

  assign  m_bvalid  = ~ff_rd_empty;
  assign  ff_rd_en  = m_bvalid  & m_bready;


endmodule // axim_fabric_cbar_master_b_ingr_node
