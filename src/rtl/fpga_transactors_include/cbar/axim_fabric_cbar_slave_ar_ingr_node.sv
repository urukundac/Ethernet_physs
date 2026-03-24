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
 -- Module Name       : axim_fabric_cbar_slave_ar_ingr_node
 -- Author            : Gregory James
 -- Associated modules: 
 -- Function          : This block arbitrates among multiple AXI4 Master
                        AR nodes & interfaces with Slave.
 --------------------------------------------------------------------------
*/

`timescale 1ns / 10ps

`include  "axim_fabric_common_defines.svh"

module axim_fabric_cbar_slave_ar_ingr_node #(
//----------------------- Global parameters Declarations ------------------
  `include  "axim_fabric_ar_params_decl.svh"

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

  ,input  core_ar_valid
  ,output core_ar_ready
  ,input  core_ar_data

//----------------------- Slave Egress R Interface -----------------------------
  ,output ingr2egr_r_valid
  ,output ingr2egr_r_data
  ,input  ingr2egr_r_ready

//----------------------- Slave Side AR Interface ------------------------
  ,input  s_clk
  ,input  s_rst_n

  ,output s_arvalid
  ,input  s_arready
  ,output s_arid
  ,output s_araddr
  ,output s_arlen
  ,output s_arsize
  ,output s_arburst
  ,output s_arlock
  ,output s_arcache
  ,output s_arprot
  ,output s_arqos
  ,output s_arregion
  ,output s_aruser

);

//----------------------- Global Data Types -------------------------------
  `_create_axi4_ar_struct_t(axi4_ar_struct_t,ARID_W,ARADDR_W,ARLEN_W,ARSIZE_W,ARBURST_W,ARLOCK_W,ARCACHE_W,ARPROT_W,ARQOS_W,ARREGION_W,ARUSER_W)
  `_create_axi4_ingr2egr_r_struct_t(axi4_ingr2egr_r_struct_t,MASTER_ID_W,ARID_W)


//----------------------- Port Types -------------------------------------
  logic                     core_clk;
  logic                     core_rst_n;

  logic                     ff_wr_full;
  logic                     arb_gnt_valid;
  logic [MASTER_ID_W-1:0]   arb_gnt_agent_id;
  logic [NUM_MASTERS-1:0]   arb_gnt_agents_sel;

  logic [NUM_MASTERS-1:0]   core_ar_valid;
  logic [NUM_MASTERS-1:0]   core_ar_ready;
  axi4_ar_struct_t          core_ar_data  [NUM_MASTERS-1:0];

  logic                     ingr2egr_r_valid;
  axi4_ingr2egr_r_struct_t  ingr2egr_r_data;
  logic                     ingr2egr_r_ready;

  logic                     s_clk;
  logic                     s_rst_n;

  logic                     s_arvalid;
  logic                     s_arready;
  logic [ARID_W-1:0]        s_arid;
  logic [ARADDR_W-1:0]      s_araddr;
  logic [ARLEN_W-1:0]       s_arlen;
  logic [ARSIZE_W-1:0]      s_arsize;
  logic [ARBURST_W-1:0]     s_arburst;
  logic [ARLOCK_W-1:0]      s_arlock;
  logic [ARCACHE_W-1:0]     s_arcache;
  logic [ARPROT_W-1:0]      s_arprot;
  logic [ARQOS_W-1:0]       s_arqos;
  logic [ARREGION_W-1:0]    s_arregion;
  logic [ARUSER_W-1:0]      s_aruser;


//----------------------- Internal Parameters -----------------------------
  localparam  AXI4_AR_STRUCT_W  = $bits(axi4_ar_struct_t);
  localparam  FIFO_W            = AXI4_AR_STRUCT_W + MASTER_ID_W;


//----------------------- Internal Register Declarations ------------------


//----------------------- Internal Wire Declarations ----------------------
  wire                              ff_wr_en;
  wire  [FIFO_W-1:0]                ff_wr_data;
  //wire                              ff_wr_full;
  wire  [FIFO_W-1:0]                ff_rd_data;
  wire                              ff_rd_en;
  wire                              ff_rd_empty;

  axi4_ar_struct_t                  core_ar_data_sync;
  wire  [MASTER_ID_W-1:0]           arb_gnt_agent_id_sync;

//----------------------- Start of Code -----------------------------------

  assign  core_ar_ready = arb_gnt_valid ? arb_gnt_agents_sel              : {NUM_MASTERS{1'b0}};
  assign  ff_wr_en      = arb_gnt_valid ? core_ar_valid[arb_gnt_agent_id] : 1'b0;


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

  assign  ff_wr_data  = {arb_gnt_agent_id,core_ar_data[arb_gnt_agent_id]};

  assign  {arb_gnt_agent_id_sync,core_ar_data_sync} = ff_rd_data;

  /*  Unpack Struct Signals */
  assign  s_arid      = core_ar_data_sync.arid;
  assign  s_araddr    = core_ar_data_sync.araddr;
  assign  s_arlen     = core_ar_data_sync.arlen;
  assign  s_arsize    = core_ar_data_sync.arsize;
  assign  s_arburst   = core_ar_data_sync.arburst;
  assign  s_arlock    = core_ar_data_sync.arlock;
  assign  s_arcache   = core_ar_data_sync.arcache;
  assign  s_arprot    = core_ar_data_sync.arprot;
  assign  s_arqos     = core_ar_data_sync.arqos;
  assign  s_arregion  = core_ar_data_sync.arregion;
  assign  s_aruser    = core_ar_data_sync.aruser;

  assign  s_arvalid   = ~ff_rd_empty & ingr2egr_r_ready;
  assign  ff_rd_en    = s_arvalid & s_arready;


  assign  ingr2egr_r_valid          = ff_rd_en;
  assign  ingr2egr_r_data.axi_id    = core_ar_data_sync.arid;
  assign  ingr2egr_r_data.master_id = arb_gnt_agent_id_sync;


endmodule // axim_fabric_cbar_slave_ar_ingr_node
