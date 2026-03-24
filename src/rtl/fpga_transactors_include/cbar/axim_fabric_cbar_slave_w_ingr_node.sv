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
 -- Module Name       : axim_fabric_cbar_slave_w_ingr_node
 -- Author            : Gregory James
 -- Associated modules: 
 -- Function          : This block arbitrates among multiple AXI4 Master
                        W nodes & interfaces with Slave.
 --------------------------------------------------------------------------
*/

`timescale 1ns / 10ps

`include  "axim_fabric_common_defines.svh"

module axim_fabric_cbar_slave_w_ingr_node #(
//----------------------- Global parameters Declarations ------------------
  `include  "axim_fabric_w_params_decl.svh"

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

  ,input  core_w_valid
  ,output core_w_ready
  ,input  core_w_data


//----------------------- Slave Side W Interface ------------------------
  ,input  s_clk
  ,input  s_rst_n

  ,output s_wvalid
  ,input  s_wready
  ,output s_wid
  ,output s_wdata
  ,output s_wstrb
  ,output s_wlast
  ,output s_wuser

);

//----------------------- Global Data Types -------------------------------
  `_create_axi4_w_struct_t(axi4_w_struct_t,WID_W,WDATA_W,WSTRB_W,WLAST_W,WUSER_W)


//----------------------- Port Types -------------------------------------
  logic                     core_clk;
  logic                     core_rst_n;

  logic                     ff_wr_full;
  logic                     arb_gnt_valid;
  logic [MASTER_ID_W-1:0]   arb_gnt_agent_id;
  logic [NUM_MASTERS-1:0]   arb_gnt_agents_sel;

  logic [NUM_MASTERS-1:0]   core_w_valid;
  logic [NUM_MASTERS-1:0]   core_w_ready;
  axi4_w_struct_t           core_w_data  [NUM_MASTERS-1:0];


  logic                     s_clk;
  logic                     s_rst_n;

  logic                     s_wvalid;
  logic                     s_wready;
  logic [WID_W-1:0]         s_wid;
  logic [WDATA_W-1:0]       s_wdata;
  logic [WSTRB_W-1:0]       s_wstrb;
  logic [WLAST_W-1:0]       s_wlast;
  logic [WUSER_W-1:0]       s_wuser;


//----------------------- Internal Parameters -----------------------------
  localparam  AXI4_W_STRUCT_W  = $bits(axi4_w_struct_t);


//----------------------- Internal Register Declarations ------------------


//----------------------- Internal Wire Declarations ----------------------
  wire                              ff_wr_en;
  axi4_w_struct_t                   ff_wr_data;
  //wire                              ff_wr_full;
  axi4_w_struct_t                   ff_rd_data;
  wire                              ff_rd_en;
  wire                              ff_rd_empty;


//----------------------- Start of Code -----------------------------------

  assign  core_w_ready  = arb_gnt_valid ? arb_gnt_agents_sel              : {NUM_MASTERS{1'b0}};
  assign  ff_wr_en      = arb_gnt_valid ? core_w_valid[arb_gnt_agent_id]  : 1'b0;


  /*  Instantiate FIFO  */
  generic_async_fifo #(
     .WRITE_WIDTH       (AXI4_W_STRUCT_W)
    ,.READ_WIDTH        (AXI4_W_STRUCT_W)
    ,.NUM_BITS          (AXI4_W_STRUCT_W*FIFO_DEPTH)
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

  assign  ff_wr_data  = core_w_data[arb_gnt_agent_id];

  /*  Unpack Struct Signals */
  assign  s_wid      = ff_rd_data.wid;
  assign  s_wdata    = ff_rd_data.wdata;
  assign  s_wstrb    = ff_rd_data.wstrb;
  assign  s_wlast    = ff_rd_data.wlast;
  assign  s_wuser    = ff_rd_data.wuser;

  assign  s_wvalid   = ~ff_rd_empty;
  assign  ff_rd_en    = s_wvalid & s_wready;




endmodule // axim_fabric_cbar_slave_w_ingr_node
