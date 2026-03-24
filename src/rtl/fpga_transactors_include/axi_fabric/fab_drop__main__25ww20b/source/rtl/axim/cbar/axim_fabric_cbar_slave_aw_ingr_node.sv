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
 -- Module Name       : axim_fabric_cbar_slave_aw_ingr_node
 -- Author            : Gregory James
 -- Associated modules: 
 -- Function          : This block arbitrates among multiple AXI4 Master
                        AW nodes & interfaces with Slave.
 --------------------------------------------------------------------------
*/

`timescale 1ns / 10ps

`include  "axim_fabric_common_defines.svh"

module axim_fabric_cbar_slave_aw_ingr_node #(
//----------------------- Global parameters Declarations ------------------
  `include  "axim_fabric_aw_params_decl.svh"

  ,parameter  NUM_MASTERS     = 4
  ,parameter  MASTER_ID_W     = (NUM_MASTERS > 1) ? $clog2(NUM_MASTERS) : 1

  ,parameter          FIFO_DEPTH      = 128
  ,parameter  string  FIFO_MEM_TYPE   = "BRAM"

) (
//----------------------- Master Side Interface -----------------------------
   input  core_clk
  ,input  core_rst_n

  ,output ff_wr_full
  ,input  arb_gnt_valid
  ,input  arb_gnt_agent_id
  ,input  arb_gnt_agents_sel

  ,input  core_aw_valid
  ,output core_aw_ready
  ,input  core_aw_data

//----------------------- Slave Egress B Interface -----------------------------
  ,output ingr2egr_b_valid
  ,output ingr2egr_b_data
  ,input  ingr2egr_b_ready

//----------------------- Slave Side AW Interface ------------------------
  ,input  s_clk
  ,input  s_rst_n

  ,output s_awvalid
  ,input  s_awready
  ,output s_awid
  ,output s_awaddr
  ,output s_awlen
  ,output s_awsize
  ,output s_awburst
  ,output s_awlock
  ,output s_awcache
  ,output s_awprot
  ,output s_awqos
  ,output s_awregion
  ,output s_awuser

);

//----------------------- Global Data Types -------------------------------
  `_create_axi4_aw_struct_t(axi4_aw_struct_t,AWID_W,AWADDR_W,AWLEN_W,AWSIZE_W,AWBURST_W,AWLOCK_W,AWCACHE_W,AWPROT_W,AWQOS_W,AWREGION_W,AWUSER_W)
  `_create_axi4_ingr2egr_b_struct_t(axi4_ingr2egr_b_struct_t,MASTER_ID_W,AWID_W)


//----------------------- Port Types -------------------------------------
  logic                     core_clk;
  logic                     core_rst_n;

  logic                     ff_wr_full;
  logic                     arb_gnt_valid;
  logic [MASTER_ID_W-1:0]   arb_gnt_agent_id;
  logic [NUM_MASTERS-1:0]   arb_gnt_agents_sel;

  logic [NUM_MASTERS-1:0]   core_aw_valid;
  logic [NUM_MASTERS-1:0]   core_aw_ready;
  axi4_aw_struct_t          core_aw_data  [NUM_MASTERS-1:0];

  logic                     ingr2egr_b_valid;
  axi4_ingr2egr_b_struct_t  ingr2egr_b_data;
  logic                     ingr2egr_b_ready;

  logic                     s_clk;
  logic                     s_rst_n;

  logic                     s_awvalid;
  logic                     s_awready;
  logic [AWID_W-1:0]        s_awid;
  logic [AWADDR_W-1:0]      s_awaddr;
  logic [AWLEN_W-1:0]       s_awlen;
  logic [AWSIZE_W-1:0]      s_awsize;
  logic [AWBURST_W-1:0]     s_awburst;
  logic [AWLOCK_W-1:0]      s_awlock;
  logic [AWCACHE_W-1:0]     s_awcache;
  logic [AWPROT_W-1:0]      s_awprot;
  logic [AWQOS_W-1:0]       s_awqos;
  logic [AWREGION_W-1:0]    s_awregion;
  logic [AWUSER_W-1:0]      s_awuser;


//----------------------- Internal Parameters -----------------------------
  localparam  AXI4_AW_STRUCT_W  = $bits(axi4_aw_struct_t);
  localparam  FIFO_W            = AXI4_AW_STRUCT_W + MASTER_ID_W;


//----------------------- Internal Register Declarations ------------------


//----------------------- Internal Wire Declarations ----------------------
  wire                              ff_wr_en;
  wire  [FIFO_W-1:0]                ff_wr_data;
  //wire                              ff_wr_full;
  wire  [FIFO_W-1:0]                ff_rd_data;
  wire                              ff_rd_en;
  wire                              ff_rd_empty;

  axi4_aw_struct_t                  core_aw_data_sync;
  wire  [MASTER_ID_W-1:0]           arb_gnt_agent_id_sync;

//----------------------- Start of Code -----------------------------------

  assign  core_aw_ready = arb_gnt_valid ? arb_gnt_agents_sel              : {NUM_MASTERS{1'b0}};
  assign  ff_wr_en      = arb_gnt_valid ? core_aw_valid[arb_gnt_agent_id] : 1'b0;

  /*  Instantiate FIFO  */
  generic_async_fifo #(
     .WRITE_WIDTH       (FIFO_W)
    ,.READ_WIDTH        (FIFO_W)
    ,.NUM_BITS          (FIFO_W*FIFO_DEPTH)
    ,.MEM_TYPE          (FIFO_MEM_TYPE)
    ,.NUM_SYNC_STAGES   (3)

  ) u_async_fifo  (

    /*  input  logic                    */   .wr_clk          (core_clk)
    /*  input  logic                    */  ,.wr_rst_n        (core_rst_n)
    /*  input  logic                    */  ,.wr_en           (ff_wr_en)
    /*  input  logic [WIDTH-1:0]        */  ,.wr_data         (ff_wr_data)
    /*  output logic                    */  ,.wr_full         (ff_wr_full)
    /*  output logic [$clog2(DEPTH):0]  */  ,.wr_occupancy    ()
    /*  output logic                    */  ,.wr_overflow     ()

    /*  input  logic                    */  ,.rd_clk          (s_clk)
    /*  input  logic                    */  ,.rd_rst_n        (s_rst_n)
    /*  input  logic                    */  ,.rd_en           (ff_rd_en)
    /*  output logic [WIDTH-1:0]        */  ,.rd_data         (ff_rd_data)
    /*  output logic                    */  ,.rd_empty        (ff_rd_empty)
    /*  output logic [$clog2(DEPTH):0]  */  ,.rd_occupancy    ()
    /*  output logic                    */  ,.rd_underflow    ()

  );

  assign  ff_wr_data  = {arb_gnt_agent_id,core_aw_data[arb_gnt_agent_id]};

  assign  {arb_gnt_agent_id_sync,core_aw_data_sync} = ff_rd_data;

  /*  Unpack Struct Signals */
  assign  s_awid      = core_aw_data_sync.awid;
  assign  s_awaddr    = core_aw_data_sync.awaddr;
  assign  s_awlen     = core_aw_data_sync.awlen;
  assign  s_awsize    = core_aw_data_sync.awsize;
  assign  s_awburst   = core_aw_data_sync.awburst;
  assign  s_awlock    = core_aw_data_sync.awlock;
  assign  s_awcache   = core_aw_data_sync.awcache;
  assign  s_awprot    = core_aw_data_sync.awprot;
  assign  s_awqos     = core_aw_data_sync.awqos;
  assign  s_awregion  = core_aw_data_sync.awregion;
  assign  s_awuser    = core_aw_data_sync.awuser;

  assign  s_awvalid   = ~ff_rd_empty & ingr2egr_b_ready;
  assign  ff_rd_en    = s_awvalid & s_awready;


  assign  ingr2egr_b_valid          = ff_rd_en;
  assign  ingr2egr_b_data.axi_id    = core_aw_data_sync.awid;
  assign  ingr2egr_b_data.master_id = arb_gnt_agent_id_sync;


endmodule // axim_fabric_cbar_slave_aw_ingr_node
