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
 -- Module Name       : axim_fabric_cbar_slave_shared_node
 -- Author            : Gregory James
 -- Associated modules: 
 -- Function          : A wrapper containing all the AW,W,AR,B & R sub-nodes
                        for a Slave in shared FIFO mode.
 --------------------------------------------------------------------------
*/

`timescale 1ns / 10ps


module axim_fabric_cbar_slave_shared_node #(
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

  ,parameter  NUM_MASTERS     = 4
  ,parameter  MASTER_ID_W     = (NUM_MASTERS > 1) ? $clog2(NUM_MASTERS) : 1

  ,parameter  M2S_SHARED_CORE_DATA_W  = 32
  ,parameter  S2M_SHARED_CORE_DATA_W  = 32

  ,parameter          FIFO_DEPTH      = 128
  ,parameter  string  FIFO_MEM_TYPE   = "BRAM"

) (
//----------------------- Master Side Interface -----------------------------
   input  core_clk
  ,input  core_rst_n

  ,input  core_ingr_valid
  ,output core_ingr_ready
  ,input  core_ingr_data

  ,output core_egr_valid
  ,input  core_egr_ready
  ,output core_egr_data

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
  `_create_axi4_aw_struct_t(axi4_aw_struct_t,AWID_W,AWADDR_W,AWLEN_W,AWSIZE_W,AWBURST_W,AWLOCK_W,AWCACHE_W,AWPROT_W,AWQOS_W,AWREGION_W,AWUSER_W)
  `_create_axi4_w_struct_t(axi4_w_struct_t,WID_W,WDATA_W,WSTRB_W,WLAST_W,WUSER_W)
  `_create_axi4_ar_struct_t(axi4_ar_struct_t,ARID_W,ARADDR_W,ARLEN_W,ARSIZE_W,ARBURST_W,ARLOCK_W,ARCACHE_W,ARPROT_W,ARQOS_W,ARREGION_W,ARUSER_W)
  `_create_axi4_b_struct_t(axi4_b_struct_t,BID_W,BRESP_W,BUSER_W)
  `_create_axi4_r_struct_t(axi4_r_struct_t,RID_W,RDATA_W,RRESP_W,RLAST_W,RUSER_W)
  `_create_axi4_ingr2egr_b_struct_t(axi4_ingr2egr_b_struct_t,MASTER_ID_W,AWID_W)
  `_create_axi4_ingr2egr_r_struct_t(axi4_ingr2egr_r_struct_t,MASTER_ID_W,RID_W)
  `_create_axi4_xtn_enum_t(axi4_xtn_t)
  `_create_axi4_shared_core_struct_t(axi4_shared_core_egr_stuct_t,axi4_xtn_t,S2M_SHARED_CORE_DATA_W)
  `_create_axi4_shared_core_struct_t(axi4_shared_core_ingr_stuct_t,axi4_xtn_t,M2S_SHARED_CORE_DATA_W)

//----------------------- Port Types -------------------------------------
  logic                           core_clk;
  logic                           core_rst_n;

  logic [NUM_MASTERS-1:0]         core_ingr_valid;
  logic [NUM_MASTERS-1:0]         core_ingr_ready;
  axi4_shared_core_ingr_stuct_t   core_ingr_data   [NUM_MASTERS-1:0];

  logic [NUM_MASTERS-1:0]         core_egr_valid;
  logic [NUM_MASTERS-1:0]         core_egr_ready;
  axi4_shared_core_egr_stuct_t    core_egr_data;


  logic                           s_clk;
  logic                           s_rst_n;

  logic                           s_awvalid;
  logic                           s_awready;
  logic [AWID_W-1:0]              s_awid;
  logic [AWADDR_W-1:0]            s_awaddr;
  logic [AWLEN_W-1:0]             s_awlen;
  logic [AWSIZE_W-1:0]            s_awsize;
  logic [AWBURST_W-1:0]           s_awburst;
  logic [AWLOCK_W-1:0]            s_awlock;
  logic [AWCACHE_W-1:0]           s_awcache;
  logic [AWPROT_W-1:0]            s_awprot;
  logic [AWQOS_W-1:0]             s_awqos;
  logic [AWREGION_W-1:0]          s_awregion;
  logic [AWUSER_W-1:0]            s_awuser;

  logic                           s_wvalid;
  logic                           s_wready;
  logic [WID_W-1:0]               s_wid;
  logic [WDATA_W-1:0]             s_wdata;
  logic [WSTRB_W-1:0]             s_wstrb;
  logic [WLAST_W-1:0]             s_wlast;
  logic [WUSER_W-1:0]             s_wuser;

  logic                           s_arvalid;
  logic                           s_arready;
  logic [ARID_W-1:0]              s_arid;
  logic [ARADDR_W-1:0]            s_araddr;
  logic [ARLEN_W-1:0]             s_arlen;
  logic [ARSIZE_W-1:0]            s_arsize;
  logic [ARBURST_W-1:0]           s_arburst;
  logic [ARLOCK_W-1:0]            s_arlock;
  logic [ARCACHE_W-1:0]           s_arcache;
  logic [ARPROT_W-1:0]            s_arprot;
  logic [ARQOS_W-1:0]             s_arqos;
  logic [ARREGION_W-1:0]          s_arregion;
  logic [ARUSER_W-1:0]            s_aruser;

  logic                           s_bvalid;
  logic                           s_bready;
  logic [BID_W-1:0]               s_bid;
  logic [BRESP_W-1:0]             s_bresp;
  logic [BUSER_W-1:0]             s_buser;

  logic                           s_rvalid;
  logic                           s_rready;
  logic [RID_W-1:0]               s_rid;
  logic [RDATA_W-1:0]             s_rdata;
  logic [RRESP_W-1:0]             s_rresp;
  logic [RLAST_W-1:0]             s_rlast;
  logic [RUSER_W-1:0]             s_ruser;


//----------------------- Internal Parameters -----------------------------


//----------------------- Internal Register Declarations ------------------


//----------------------- Internal Wire Declarations ----------------------
  logic                     ingr2egr_b_valid;
  axi4_ingr2egr_b_struct_t  ingr2egr_b_data;
  logic                     ingr2egr_b_ready;

  logic                     ingr2egr_r_valid;
  axi4_ingr2egr_r_struct_t  ingr2egr_r_data;
  logic                     ingr2egr_r_ready;


//----------------------- Start of Code -----------------------------------

  /*  Instantiate Ingress Node  */
  axim_fabric_cbar_slave_shared_ingr_node #(
    `include  "axim_fabric_aw_params_inst.svh"
    ,
    `include  "axim_fabric_w_params_inst.svh"
    ,
    `include  "axim_fabric_ar_params_inst.svh"
    ,
    `include  "axim_fabric_r_params_inst.svh"

    ,.NUM_MASTERS             (NUM_MASTERS  )
    ,.MASTER_ID_W             (MASTER_ID_W  )

    ,.SHARED_CORE_DATA_W      (M2S_SHARED_CORE_DATA_W)
    ,.EGR_SHARED_CORE_DATA_W  (S2M_SHARED_CORE_DATA_W)

    ,.FIFO_DEPTH              (FIFO_DEPTH   )
    ,.FIFO_MEM_TYPE           (FIFO_MEM_TYPE)


  ) u_ingr_node (

     .core_clk          (core_clk          )
    ,.core_rst_n        (core_rst_n        )

    ,.core_ingr_valid   (core_ingr_valid   )
    ,.core_ingr_ready   (core_ingr_ready   )
    ,.core_ingr_data    (core_ingr_data    )

    ,.core_egr_valid    (core_egr_valid    )
    ,.core_egr_ready    (core_egr_ready    )
    ,.core_egr_data     (core_egr_data     )

    ,.ingr2egr_b_valid  (ingr2egr_b_valid  )
    ,.ingr2egr_b_data   (ingr2egr_b_data   )
    ,.ingr2egr_b_ready  (ingr2egr_b_ready  )

    ,.ingr2egr_r_valid  (ingr2egr_r_valid  )
    ,.ingr2egr_r_data   (ingr2egr_r_data   )
    ,.ingr2egr_r_ready  (ingr2egr_r_ready  )


    ,.s_clk             (s_clk             )
    ,.s_rst_n           (s_rst_n           )

    ,.s_awvalid         (s_awvalid         )
    ,.s_awready         (s_awready         )
    ,.s_awid            (s_awid            )
    ,.s_awaddr          (s_awaddr          )
    ,.s_awlen           (s_awlen           )
    ,.s_awsize          (s_awsize          )
    ,.s_awburst         (s_awburst         )
    ,.s_awlock          (s_awlock          )
    ,.s_awcache         (s_awcache         )
    ,.s_awprot          (s_awprot          )
    ,.s_awqos           (s_awqos           )
    ,.s_awregion        (s_awregion        )
    ,.s_awuser          (s_awuser          )

    ,.s_wvalid          (s_wvalid        )
    ,.s_wready          (s_wready        )
    ,.s_wid             (s_wid           )
    ,.s_wdata           (s_wdata         )
    ,.s_wstrb           (s_wstrb         )
    ,.s_wlast           (s_wlast         )
    ,.s_wuser           (s_wuser         )

    ,.s_arvalid         (s_arvalid         )
    ,.s_arready         (s_arready         )
    ,.s_arid            (s_arid            )
    ,.s_araddr          (s_araddr          )
    ,.s_arlen           (s_arlen           )
    ,.s_arsize          (s_arsize          )
    ,.s_arburst         (s_arburst         )
    ,.s_arlock          (s_arlock          )
    ,.s_arcache         (s_arcache         )
    ,.s_arprot          (s_arprot          )
    ,.s_arqos           (s_arqos           )
    ,.s_arregion        (s_arregion        )
    ,.s_aruser          (s_aruser          )

  );

  /*  Instantiate Egress Node  */
  axim_fabric_cbar_slave_shared_egr_node #(
    `include  "axim_fabric_b_params_inst.svh"
    ,
    `include  "axim_fabric_r_params_inst.svh"

    ,.NUM_MASTERS           (NUM_MASTERS  )
    ,.MASTER_ID_W           (MASTER_ID_W  )

    ,.SHARED_CORE_DATA_W    (S2M_SHARED_CORE_DATA_W)

    ,.FIFO_DEPTH            (FIFO_DEPTH   )
    ,.FIFO_MEM_TYPE         (FIFO_MEM_TYPE)


  ) u_egr_node  (

     .s_clk             (s_clk             )
    ,.s_rst_n           (s_rst_n           )

    ,.s_bvalid          (s_bvalid          )
    ,.s_bready          (s_bready          )
    ,.s_bid             (s_bid             )
    ,.s_bresp           (s_bresp           )
    ,.s_buser           (s_buser           )

    ,.s_rvalid          (s_rvalid          )
    ,.s_rready          (s_rready          )
    ,.s_rid             (s_rid             )
    ,.s_rdata           (s_rdata           )
    ,.s_rresp           (s_rresp           )
    ,.s_rlast           (s_rlast           )
    ,.s_ruser           (s_ruser           )


    ,.ingr2egr_b_valid  (ingr2egr_b_valid  )
    ,.ingr2egr_b_data   (ingr2egr_b_data   )
    ,.ingr2egr_b_ready  (ingr2egr_b_ready  )

    ,.ingr2egr_r_valid  (ingr2egr_r_valid  )
    ,.ingr2egr_r_data   (ingr2egr_r_data   )
    ,.ingr2egr_r_ready  (ingr2egr_r_ready  )


    ,.core_clk          (core_clk          )
    ,.core_rst_n        (core_rst_n        )

    ,.core_egr_valid    (core_egr_valid    )
    ,.core_egr_ready    (core_egr_ready    )
    ,.core_egr_data     (core_egr_data     )


  );


endmodule // axim_fabric_cbar_slave_shared_node
