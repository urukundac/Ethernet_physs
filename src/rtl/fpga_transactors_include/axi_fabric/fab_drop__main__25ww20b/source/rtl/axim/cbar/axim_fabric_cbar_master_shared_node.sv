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
 -- Module Name       : axim_fabric_cbar_master_shared_node
 -- Author            : Gregory James
 -- Associated modules: 
 -- Function          : A wrapper containing all the AW,W,AR,B & R sub-nodes
                        for a Master in shared FIFO mode.
 --------------------------------------------------------------------------
*/

`timescale 1ns / 10ps

`include  "axim_fabric_common_defines.svh"

module axim_fabric_cbar_master_shared_node #(
//----------------------- Global parameters Declarations ------------------
  `include  "axim_fabric_aw_params_decl.svh"
  ,
  `include  "axim_fabric_w_params_decl.svh"
  ,
  `include  "axim_fabric_ar_params_decl.svh"
  ,
  `include  "axim_fabric_b_params_decl.svh"
  ,
  `include  "axim_fabric_r_params_decl.svh"

  ,parameter  NUM_SLAVES      = 4
  ,parameter  SLAVE_ID_W      = (NUM_SLAVES > 1) ? $clog2(NUM_SLAVES) : 1

  ,parameter  M2S_SHARED_CORE_DATA_W  = 32
  ,parameter  S2M_SHARED_CORE_DATA_W  = 32

  ,parameter          FIFO_DEPTH      = 128
  ,parameter  string  FIFO_MEM_TYPE   = "BRAM"

) (
//----------------------- Master Side AXI4 Interface ------------------------
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


//----------------------- Slave Side Interface -----------------------------
  ,input  core_clk
  ,input  core_rst_n

  ,output core_egr_valid
  ,input  core_egr_ready
  ,output core_egr_data

  ,input  core_ingr_valid
  ,output core_ingr_ready
  ,input  core_ingr_data

);

//----------------------- Global Data Types -------------------------------
  `_create_axi4_aw_struct_t(axi4_aw_struct_t,AWID_W,AWADDR_W,AWLEN_W,AWSIZE_W,AWBURST_W,AWLOCK_W,AWCACHE_W,AWPROT_W,AWQOS_W,AWREGION_W,AWUSER_W)
  `_create_axi4_w_struct_t(axi4_w_struct_t,WID_W,WDATA_W,WSTRB_W,WLAST_W,WUSER_W)
  `_create_axi4_ar_struct_t(axi4_ar_struct_t,ARID_W,ARADDR_W,ARLEN_W,ARSIZE_W,ARBURST_W,ARLOCK_W,ARCACHE_W,ARPROT_W,ARQOS_W,ARREGION_W,ARUSER_W)
  `_create_axi4_b_struct_t(axi4_b_struct_t,BID_W,BRESP_W,BUSER_W)
  `_create_axi4_r_struct_t(axi4_r_struct_t,RID_W,RDATA_W,RRESP_W,RLAST_W,RUSER_W)
  `_create_axi4_xtn_enum_t(axi4_xtn_t)
  `_create_axi4_shared_core_struct_t(axi4_shared_core_egr_stuct_t,axi4_xtn_t,M2S_SHARED_CORE_DATA_W)
  `_create_axi4_shared_core_struct_t(axi4_shared_core_ingr_stuct_t,axi4_xtn_t,S2M_SHARED_CORE_DATA_W)


//----------------------- Port Types -------------------------------------
  logic                         m_clk;
  logic                         m_rst_n;

  logic [AWADDR_W-1:0]          addr_map [0:NUM_SLAVES-1][0:1];

  logic                         m_awvalid;
  logic                         m_awready;
  logic [AWID_W-1:0]            m_awid;
  logic [AWADDR_W-1:0]          m_awaddr;
  logic [AWLEN_W-1:0]           m_awlen;
  logic [AWSIZE_W-1:0]          m_awsize;
  logic [AWBURST_W-1:0]         m_awburst;
  logic [AWLOCK_W-1:0]          m_awlock;
  logic [AWCACHE_W-1:0]         m_awcache;
  logic [AWPROT_W-1:0]          m_awprot;
  logic [AWQOS_W-1:0]           m_awqos;
  logic [AWREGION_W-1:0]        m_awregion;
  logic [AWUSER_W-1:0]          m_awuser;

  logic                         m_wvalid;
  logic                         m_wready;
  logic [WID_W-1:0]             m_wid;
  logic [WDATA_W-1:0]           m_wdata;
  logic [WSTRB_W-1:0]           m_wstrb;
  logic [WLAST_W-1:0]           m_wlast;
  logic [WUSER_W-1:0]           m_wuser;

  logic                         m_arvalid;
  logic                         m_arready;
  logic [ARID_W-1:0]            m_arid;
  logic [ARADDR_W-1:0]          m_araddr;
  logic [ARLEN_W-1:0]           m_arlen;
  logic [ARSIZE_W-1:0]          m_arsize;
  logic [ARBURST_W-1:0]         m_arburst;
  logic [ARLOCK_W-1:0]          m_arlock;
  logic [ARCACHE_W-1:0]         m_arcache;
  logic [ARPROT_W-1:0]          m_arprot;
  logic [ARQOS_W-1:0]           m_arqos;
  logic [ARREGION_W-1:0]        m_arregion;
  logic [ARUSER_W-1:0]          m_aruser;


  logic                         m_bvalid;
  logic                         m_bready;
  logic [BID_W-1:0]             m_bid;
  logic [BRESP_W-1:0]           m_bresp;
  logic [BUSER_W-1:0]           m_buser;

  logic                         m_rvalid;
  logic                         m_rready;
  logic [RID_W-1:0]             m_rid;
  logic [RDATA_W-1:0]           m_rdata;
  logic [RRESP_W-1:0]           m_rresp;
  logic [RLAST_W-1:0]           m_rlast;
  logic [RUSER_W-1:0]           m_ruser;


  logic                         core_clk;
  logic                         core_rst_n;

  logic [NUM_SLAVES-1:0]        core_egr_valid;
  logic [NUM_SLAVES-1:0]        core_egr_ready;
  axi4_shared_core_egr_stuct_t  core_egr_data;

  logic [NUM_SLAVES-1:0]        core_ingr_valid;
  logic [NUM_SLAVES-1:0]        core_ingr_ready;
  axi4_shared_core_ingr_stuct_t core_ingr_data [NUM_SLAVES-1:0];


//----------------------- Internal Parameters -----------------------------


//----------------------- Internal Register Declarations ------------------


//----------------------- Internal Wire Declarations ----------------------



//----------------------- Start of Code -----------------------------------

  /*  Instantiate Egress Node */
  axim_fabric_cbar_master_shared_egr_node #(
    `include  "axim_fabric_aw_params_inst.svh"
    ,
    `include  "axim_fabric_w_params_inst.svh"
    ,
    `include  "axim_fabric_ar_params_inst.svh"

    ,.NUM_SLAVES          (NUM_SLAVES   )
    ,.SLAVE_ID_W          (SLAVE_ID_W   )

    ,.FIFO_DEPTH          (FIFO_DEPTH   )
    ,.FIFO_MEM_TYPE       (FIFO_MEM_TYPE)

    ,.SHARED_CORE_DATA_W  (M2S_SHARED_CORE_DATA_W)

  ) u_egr_node  (

     .m_clk               (m_clk           )
    ,.m_rst_n             (m_rst_n         )

    ,.addr_map            (addr_map        )

    ,.m_awvalid           (m_awvalid       )
    ,.m_awready           (m_awready       )
    ,.m_awid              (m_awid          )
    ,.m_awaddr            (m_awaddr        )
    ,.m_awlen             (m_awlen         )
    ,.m_awsize            (m_awsize        )
    ,.m_awburst           (m_awburst       )
    ,.m_awlock            (m_awlock        )
    ,.m_awcache           (m_awcache       )
    ,.m_awprot            (m_awprot        )
    ,.m_awqos             (m_awqos         )
    ,.m_awregion          (m_awregion      )
    ,.m_awuser            (m_awuser        )

    ,.m_wvalid            (m_wvalid        )
    ,.m_wready            (m_wready        )
    ,.m_wid               (m_wid           )
    ,.m_wdata             (m_wdata         )
    ,.m_wstrb             (m_wstrb         )
    ,.m_wlast             (m_wlast         )
    ,.m_wuser             (m_wuser         )

    ,.m_arvalid           (m_arvalid       )
    ,.m_arready           (m_arready       )
    ,.m_arid              (m_arid          )
    ,.m_araddr            (m_araddr        )
    ,.m_arlen             (m_arlen         )
    ,.m_arsize            (m_arsize        )
    ,.m_arburst           (m_arburst       )
    ,.m_arlock            (m_arlock        )
    ,.m_arcache           (m_arcache       )
    ,.m_arprot            (m_arprot        )
    ,.m_arqos             (m_arqos         )
    ,.m_arregion          (m_arregion      )
    ,.m_aruser            (m_aruser        )


    ,.core_clk            (core_clk        )
    ,.core_rst_n          (core_rst_n      )

    ,.core_egr_valid      (core_egr_valid  )
    ,.core_egr_ready      (core_egr_ready  )
    ,.core_egr_data       (core_egr_data   )

  );


  /*  Instantiate Ingress Node */
  axim_fabric_cbar_master_shared_ingr_node #(
    `include  "axim_fabric_b_params_inst.svh"
    ,
    `include  "axim_fabric_r_params_inst.svh"

    ,.NUM_SLAVES          (NUM_SLAVES   )
    ,.SLAVE_ID_W          (SLAVE_ID_W   )

    ,.FIFO_DEPTH          (FIFO_DEPTH   )
    ,.FIFO_MEM_TYPE       (FIFO_MEM_TYPE)

    ,.SHARED_CORE_DATA_W  (S2M_SHARED_CORE_DATA_W)

  ) u_ingr_node (

     .core_clk        (core_clk        )
    ,.core_rst_n      (core_rst_n      )

    ,.core_ingr_valid (core_ingr_valid )
    ,.core_ingr_ready (core_ingr_ready )
    ,.core_ingr_data  (core_ingr_data  )


    ,.m_clk           (m_clk           )
    ,.m_rst_n         (m_rst_n         )

    ,.m_bvalid        (m_bvalid        )
    ,.m_bready        (m_bready        )
    ,.m_bid           (m_bid           )
    ,.m_bresp         (m_bresp         )
    ,.m_buser         (m_buser         )

    ,.m_rvalid        (m_rvalid        )
    ,.m_rready        (m_rready        )
    ,.m_rid           (m_rid           )
    ,.m_rdata         (m_rdata         )
    ,.m_rresp         (m_rresp         )
    ,.m_rlast         (m_rlast         )
    ,.m_ruser         (m_ruser         )

  );



endmodule // axim_fabric_cbar_master_shared_node
