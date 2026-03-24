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
 -- Module Name       : axim_fabric_cbar_top
 -- Author            : Gregory James
 -- Associated modules: 
 -- Function          : The top level module for AXI4 Fabric Crossbar.
 --------------------------------------------------------------------------
*/

`timescale 1ns / 10ps

`include  "axim_fabric_common_defines.svh"

module axim_fabric_cbar_top #(
//----------------------- Global parameters Declarations ------------------
  `include  "axim_fabric_top_params_decl.svh"

  ,parameter  NUM_MASTERS     = 2
  ,parameter  NUM_SLAVES      = 4

  ,parameter  USE_SHARED_FIFOS  = 0

  ,parameter          FIFO_DEPTH      = 128
  ,parameter  string  FIFO_MEM_TYPE   = "BRAM"


) (
//----------------------- Fabric Core Clock & Reset  ------------------------
   input  core_clk
  ,input  core_rst_n

//----------------------- Master Side AXI4 Interface ------------------------
  ,input  m_clk
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

  ,input  m_wvalid
  ,output m_wready
  ,input  m_wid
  ,input  m_wdata
  ,input  m_wstrb
  ,input  m_wlast
  ,input  m_wuser

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


  ,output m_bvalid
  ,input  m_bready
  ,output m_bid
  ,output m_bresp
  ,output m_buser

  ,output m_rvalid
  ,input  m_rready
  ,output m_rid
  ,output m_rdata
  ,output m_rresp
  ,output m_rlast
  ,output m_ruser


//----------------------- Slave Side AXI4 Interface ------------------------
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

  ,output s_wvalid
  ,input  s_wready
  ,output s_wid
  ,output s_wdata
  ,output s_wstrb
  ,output s_wlast
  ,output s_wuser

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

  ,input  s_bvalid
  ,output s_bready
  ,input  s_bid
  ,input  s_bresp
  ,input  s_buser

  ,input  s_rvalid
  ,output s_rready
  ,input  s_rid
  ,input  s_rdata
  ,input  s_rresp
  ,input  s_rlast
  ,input  s_ruser


);

//----------------------- Global Data Types -------------------------------


//----------------------- Port Types -------------------------------------
  logic                       core_clk;
  logic                       core_rst_n;

  logic [NUM_MASTERS-1:0]     m_clk;
  logic [NUM_MASTERS-1:0]     m_rst_n;

  logic [AXI4_ADDR_W-1:0]     addr_map [0:NUM_MASTERS-1][0:NUM_SLAVES-1][0:1];

  logic [NUM_MASTERS-1:0]     m_awvalid;
  logic [NUM_MASTERS-1:0]     m_awready;
  logic [AXI4_ID_W-1:0]       m_awid [NUM_MASTERS-1:0];
  logic [AXI4_ADDR_W-1:0]     m_awaddr [NUM_MASTERS-1:0];
  logic [AXI4_LEN_W-1:0]      m_awlen [NUM_MASTERS-1:0];
  logic [AXI4_SIZE_W-1:0]     m_awsize [NUM_MASTERS-1:0];
  logic [AXI4_BURST_W-1:0]    m_awburst [NUM_MASTERS-1:0];
  logic [AXI4_LOCK_W-1:0]     m_awlock [NUM_MASTERS-1:0];
  logic [AXI4_CACHE_W-1:0]    m_awcache [NUM_MASTERS-1:0];
  logic [AXI4_PROT_W-1:0]     m_awprot [NUM_MASTERS-1:0];
  logic [AXI4_QOS_W-1:0]      m_awqos [NUM_MASTERS-1:0];
  logic [AXI4_REGION_W-1:0]   m_awregion [NUM_MASTERS-1:0];
  logic [AXI4_USER_W-1:0]     m_awuser [NUM_MASTERS-1:0];

  logic [NUM_MASTERS-1:0]     m_wvalid;
  logic [NUM_MASTERS-1:0]     m_wready;
  logic [AXI4_ID_W-1:0]       m_wid [NUM_MASTERS-1:0];
  logic [AXI4_DATA_W-1:0]     m_wdata [NUM_MASTERS-1:0];
  logic [AXI4_WSTRB_W-1:0]    m_wstrb [NUM_MASTERS-1:0];
  logic [AXI4_WLAST_W-1:0]    m_wlast [NUM_MASTERS-1:0];
  logic [AXI4_USER_W-1:0]     m_wuser [NUM_MASTERS-1:0];

  logic [NUM_MASTERS-1:0]     m_arvalid;
  logic [NUM_MASTERS-1:0]     m_arready;
  logic [AXI4_ID_W-1:0]       m_arid [NUM_MASTERS-1:0];
  logic [AXI4_ADDR_W-1:0]     m_araddr [NUM_MASTERS-1:0];
  logic [AXI4_LEN_W-1:0]      m_arlen [NUM_MASTERS-1:0];
  logic [AXI4_SIZE_W-1:0]     m_arsize [NUM_MASTERS-1:0];
  logic [AXI4_BURST_W-1:0]    m_arburst [NUM_MASTERS-1:0];
  logic [AXI4_LOCK_W-1:0]     m_arlock [NUM_MASTERS-1:0];
  logic [AXI4_CACHE_W-1:0]    m_arcache [NUM_MASTERS-1:0];
  logic [AXI4_PROT_W-1:0]     m_arprot [NUM_MASTERS-1:0];
  logic [AXI4_QOS_W-1:0]      m_arqos [NUM_MASTERS-1:0];
  logic [AXI4_REGION_W-1:0]   m_arregion [NUM_MASTERS-1:0];
  logic [AXI4_USER_W-1:0]     m_aruser [NUM_MASTERS-1:0];


  logic [NUM_MASTERS-1:0]     m_bvalid;
  logic [NUM_MASTERS-1:0]     m_bready;
  logic [AXI4_ID_W-1:0]       m_bid [NUM_MASTERS-1:0];
  logic [AXI4_BRESP_W-1:0]    m_bresp [NUM_MASTERS-1:0];
  logic [AXI4_USER_W-1:0]     m_buser [NUM_MASTERS-1:0];

  logic [NUM_MASTERS-1:0]     m_rvalid;
  logic [NUM_MASTERS-1:0]     m_rready;
  logic [AXI4_ID_W-1:0]       m_rid [NUM_MASTERS-1:0];
  logic [AXI4_DATA_W-1:0]     m_rdata [NUM_MASTERS-1:0];
  logic [AXI4_RRESP_W-1:0]    m_rresp [NUM_MASTERS-1:0];
  logic [AXI4_RLAST_W-1:0]    m_rlast [NUM_MASTERS-1:0];
  logic [AXI4_USER_W-1:0]     m_ruser [NUM_MASTERS-1:0];


  logic [NUM_SLAVES-1:0]      s_clk;
  logic [NUM_SLAVES-1:0]      s_rst_n;

  logic [NUM_SLAVES-1:0]      s_awvalid;
  logic [NUM_SLAVES-1:0]      s_awready;
  logic [AXI4_ID_W-1:0]       s_awid [NUM_SLAVES-1:0];
  logic [AXI4_ADDR_W-1:0]     s_awaddr [NUM_SLAVES-1:0];
  logic [AXI4_LEN_W-1:0]      s_awlen [NUM_SLAVES-1:0];
  logic [AXI4_SIZE_W-1:0]     s_awsize [NUM_SLAVES-1:0];
  logic [AXI4_BURST_W-1:0]    s_awburst [NUM_SLAVES-1:0];
  logic [AXI4_LOCK_W-1:0]     s_awlock [NUM_SLAVES-1:0];
  logic [AXI4_CACHE_W-1:0]    s_awcache [NUM_SLAVES-1:0];
  logic [AXI4_PROT_W-1:0]     s_awprot [NUM_SLAVES-1:0];
  logic [AXI4_QOS_W-1:0]      s_awqos [NUM_SLAVES-1:0];
  logic [AXI4_REGION_W-1:0]   s_awregion [NUM_SLAVES-1:0];
  logic [AXI4_USER_W-1:0]     s_awuser [NUM_SLAVES-1:0];

  logic [NUM_SLAVES-1:0]      s_wvalid;
  logic [NUM_SLAVES-1:0]      s_wready;
  logic [AXI4_ID_W-1:0]       s_wid [NUM_SLAVES-1:0];
  logic [AXI4_DATA_W-1:0]     s_wdata [NUM_SLAVES-1:0];
  logic [AXI4_WSTRB_W-1:0]    s_wstrb [NUM_SLAVES-1:0];
  logic [AXI4_WLAST_W-1:0]    s_wlast [NUM_SLAVES-1:0];
  logic [AXI4_USER_W-1:0]     s_wuser [NUM_SLAVES-1:0];

  logic [NUM_SLAVES-1:0]      s_arvalid;
  logic [NUM_SLAVES-1:0]      s_arready;
  logic [AXI4_ID_W-1:0]       s_arid [NUM_SLAVES-1:0];
  logic [AXI4_ADDR_W-1:0]     s_araddr [NUM_SLAVES-1:0];
  logic [AXI4_LEN_W-1:0]      s_arlen [NUM_SLAVES-1:0];
  logic [AXI4_SIZE_W-1:0]     s_arsize [NUM_SLAVES-1:0];
  logic [AXI4_BURST_W-1:0]    s_arburst [NUM_SLAVES-1:0];
  logic [AXI4_LOCK_W-1:0]     s_arlock [NUM_SLAVES-1:0];
  logic [AXI4_CACHE_W-1:0]    s_arcache [NUM_SLAVES-1:0];
  logic [AXI4_PROT_W-1:0]     s_arprot [NUM_SLAVES-1:0];
  logic [AXI4_QOS_W-1:0]      s_arqos [NUM_SLAVES-1:0];
  logic [AXI4_REGION_W-1:0]   s_arregion [NUM_SLAVES-1:0];
  logic [AXI4_USER_W-1:0]     s_aruser [NUM_SLAVES-1:0];

  logic [NUM_SLAVES-1:0]      s_bvalid;
  logic [NUM_SLAVES-1:0]      s_bready;
  logic [AXI4_ID_W-1:0]       s_bid [NUM_SLAVES-1:0];
  logic [AXI4_BRESP_W-1:0]    s_bresp [NUM_SLAVES-1:0];
  logic [AXI4_USER_W-1:0]     s_buser [NUM_SLAVES-1:0];

  logic [NUM_SLAVES-1:0]      s_rvalid;
  logic [NUM_SLAVES-1:0]      s_rready;
  logic [AXI4_ID_W-1:0]       s_rid [NUM_SLAVES-1:0];
  logic [AXI4_DATA_W-1:0]     s_rdata [NUM_SLAVES-1:0];
  logic [AXI4_RRESP_W-1:0]    s_rresp [NUM_SLAVES-1:0];
  logic [AXI4_RLAST_W-1:0]    s_rlast [NUM_SLAVES-1:0];
  logic [AXI4_USER_W-1:0]     s_ruser [NUM_SLAVES-1:0];


 
//----------------------- Import Packages ---------------------------------


//----------------------- Internal Parameters -----------------------------


//----------------------- Internal Register Declarations ------------------


//----------------------- Internal Wire Declarations ----------------------


//----------------------- Start of Code -----------------------------------

  generate
    if(USE_SHARED_FIFOS)
    begin
      axim_fabric_cbar_shared_fifo_top #(
        `include  "axim_fabric_top_params_inst.svh"

        ,.NUM_MASTERS             (NUM_MASTERS)
        ,.NUM_SLAVES              (NUM_SLAVES)

        ,.FIFO_DEPTH              (FIFO_DEPTH)
        ,.FIFO_MEM_TYPE           (FIFO_MEM_TYPE)

      ) u_axim_fabric (.*);
    end
    else  // USE_SHARED_FIFOS == 0
    begin
      axim_fabric_cbar_independent_fifo_top  #(
        `include  "axim_fabric_top_params_inst.svh"

        ,.NUM_MASTERS             (NUM_MASTERS)
        ,.NUM_SLAVES              (NUM_SLAVES)

        ,.FIFO_DEPTH              (FIFO_DEPTH)
        ,.FIFO_MEM_TYPE           (FIFO_MEM_TYPE)

      ) u_axim_fabric (.*);
    end
  endgenerate

endmodule // axim_fabric_cbar_top
