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
 -- Module Name       : axim_fabric_cbar_shared_fifo_top
 -- Author            : Gregory James
 -- Associated modules: 
 -- Function          : The top level module for AXI4 Fabric Crossbar using
                        shared FIFOs.
 --------------------------------------------------------------------------
*/

`timescale 1ns / 10ps

`include  "axim_fabric_common_defines.svh"

module axim_fabric_cbar_shared_fifo_top #(
//----------------------- Global parameters Declarations ------------------
  `include  "axim_fabric_top_params_decl.svh"

  ,parameter  NUM_MASTERS     = 2
  ,parameter  NUM_SLAVES      = 4

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
  `_create_axi4_aw_struct_t(axi4_aw_struct_t,AXI4_ID_W,AXI4_ADDR_W,AXI4_LEN_W,AXI4_SIZE_W,AXI4_BURST_W,AXI4_LOCK_W,AXI4_CACHE_W,AXI4_PROT_W,AXI4_QOS_W,AXI4_REGION_W,AXI4_USER_W)
  `_create_axi4_w_struct_t(axi4_w_struct_t,AXI4_ID_W,AXI4_DATA_W,AXI4_WSTRB_W,AXI4_WLAST_W,AXI4_USER_W)
  `_create_axi4_ar_struct_t(axi4_ar_struct_t,AXI4_ID_W,AXI4_ADDR_W,AXI4_LEN_W,AXI4_SIZE_W,AXI4_BURST_W,AXI4_LOCK_W,AXI4_CACHE_W,AXI4_PROT_W,AXI4_QOS_W,AXI4_REGION_W,AXI4_USER_W)
  `_create_axi4_b_struct_t(axi4_b_struct_t,AXI4_ID_W,AXI4_BRESP_W,AXI4_USER_W)
  `_create_axi4_r_struct_t(axi4_r_struct_t,AXI4_ID_W,AXI4_DATA_W,AXI4_RRESP_W,AXI4_RLAST_W,AXI4_USER_W)


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
  localparam  SLAVE_ID_W              = (NUM_SLAVES  > 1) ? $clog2(NUM_SLAVES)  : 1;
  localparam  MASTER_ID_W             = (NUM_MASTERS > 1) ? $clog2(NUM_MASTERS) : 1;

  localparam  AXI4_AW_STRUCT_W        = $bits(axi4_aw_struct_t);
  localparam  AXI4_AR_STRUCT_W        = $bits(axi4_ar_struct_t);
  localparam  AXI4_W_STRUCT_W         = $bits(axi4_w_struct_t);
  localparam  AXI4_B_STRUCT_W         = $bits(axi4_b_struct_t);
  localparam  AXI4_R_STRUCT_W         = $bits(axi4_r_struct_t);

  localparam  M2S_SHARED_CORE_DATA_W  = (AXI4_AW_STRUCT_W > AXI4_AR_STRUCT_W) ?
                                          ((AXI4_AW_STRUCT_W > AXI4_W_STRUCT_W) ? AXI4_AW_STRUCT_W  : AXI4_W_STRUCT_W)  :
                                          ((AXI4_AR_STRUCT_W > AXI4_W_STRUCT_W) ? AXI4_AR_STRUCT_W  : AXI4_W_STRUCT_W);

  localparam  S2M_SHARED_CORE_DATA_W  = (AXI4_B_STRUCT_W  > AXI4_R_STRUCT_W)  ? AXI4_B_STRUCT_W : AXI4_R_STRUCT_W;


//----------------------- Internal Data Types -----------------------------
  `_create_axi4_xtn_enum_t(axi4_xtn_t)
  `_create_axi4_shared_core_struct_t(axi4_shared_core_m2s_stuct_t,axi4_xtn_t,M2S_SHARED_CORE_DATA_W)
  `_create_axi4_shared_core_struct_t(axi4_shared_core_s2m_stuct_t,axi4_xtn_t,S2M_SHARED_CORE_DATA_W)


//----------------------- Internal Register Declarations ------------------


//----------------------- Internal Wire Declarations ----------------------
  logic [NUM_SLAVES-1:0]          master_core_egr_valid [NUM_MASTERS-1:0];
  logic [NUM_SLAVES-1:0]          master_core_egr_ready [NUM_MASTERS-1:0];
  axi4_shared_core_m2s_stuct_t    master_core_egr_data [NUM_MASTERS-1:0];

  logic [NUM_SLAVES-1:0]          master_core_ingr_valid [NUM_MASTERS-1:0];
  logic [NUM_SLAVES-1:0]          master_core_ingr_ready [NUM_MASTERS-1:0];
  axi4_shared_core_s2m_stuct_t    master_core_ingr_data [NUM_MASTERS-1:0] [NUM_SLAVES-1:0];



  logic [NUM_MASTERS-1:0]         slave_core_ingr_valid [NUM_SLAVES-1:0];
  logic [NUM_MASTERS-1:0]         slave_core_ingr_ready [NUM_SLAVES-1:0];
  axi4_shared_core_m2s_stuct_t    slave_core_ingr_data  [NUM_SLAVES-1:0]  [NUM_MASTERS-1:0];

  logic [NUM_MASTERS-1:0]         slave_core_egr_valid [NUM_SLAVES-1:0];
  logic [NUM_MASTERS-1:0]         slave_core_egr_ready [NUM_SLAVES-1:0];
  axi4_shared_core_s2m_stuct_t    slave_core_egr_data [NUM_SLAVES-1:0];


  genvar  i,j;

//----------------------- Start of Code -----------------------------------

  generate
    for(i=0;i<NUM_MASTERS;i++)
    begin : gen_masters
      axim_fabric_cbar_master_shared_node  #(
         .AWID_W                  (AXI4_ID_W    )
        ,.AWADDR_W                (AXI4_ADDR_W  )
        ,.AWLEN_W                 (AXI4_LEN_W   )
        ,.AWSIZE_W                (AXI4_SIZE_W  )
        ,.AWBURST_W               (AXI4_BURST_W )
        ,.AWLOCK_W                (AXI4_LOCK_W  )
        ,.AWCACHE_W               (AXI4_CACHE_W )
        ,.AWPROT_W                (AXI4_PROT_W  )
        ,.AWQOS_W                 (AXI4_QOS_W   )
        ,.AWREGION_W              (AXI4_REGION_W)
        ,.AWUSER_W                (AXI4_USER_W  )

        ,.WID_W                   (AXI4_ID_W  )
        ,.WDATA_W                 (AXI4_DATA_W)
        ,.WSTRB_W                 (AXI4_WSTRB_W)
        ,.WLAST_W                 (AXI4_WLAST_W)
        ,.WUSER_W                 (AXI4_USER_W)

        ,.WID_USED                (AXI4_WID_USED)

        ,.ARID_W                  (AXI4_ID_W    )
        ,.ARADDR_W                (AXI4_ADDR_W  )
        ,.ARLEN_W                 (AXI4_LEN_W   )
        ,.ARSIZE_W                (AXI4_SIZE_W  )
        ,.ARBURST_W               (AXI4_BURST_W )
        ,.ARLOCK_W                (AXI4_LOCK_W  )
        ,.ARCACHE_W               (AXI4_CACHE_W )
        ,.ARPROT_W                (AXI4_PROT_W  )
        ,.ARQOS_W                 (AXI4_QOS_W   )
        ,.ARREGION_W              (AXI4_REGION_W)
        ,.ARUSER_W                (AXI4_USER_W  )

        ,.BID_W                   (AXI4_ID_W  )
        ,.BRESP_W                 (AXI4_BRESP_W)
        ,.BUSER_W                 (AXI4_USER_W)

        ,.RID_W                   (AXI4_ID_W  )
        ,.RDATA_W                 (AXI4_DATA_W)
        ,.RRESP_W                 (AXI4_RRESP_W)
        ,.RLAST_W                 (AXI4_RLAST_W)
        ,.RUSER_W                 (AXI4_USER_W)

        ,.NUM_SLAVES              (NUM_SLAVES)
        ,.SLAVE_ID_W              (SLAVE_ID_W)

        ,.M2S_SHARED_CORE_DATA_W  (M2S_SHARED_CORE_DATA_W)
        ,.S2M_SHARED_CORE_DATA_W  (S2M_SHARED_CORE_DATA_W)

        ,.FIFO_DEPTH              (FIFO_DEPTH)
        ,.FIFO_MEM_TYPE           (FIFO_MEM_TYPE)


      ) u_master_node (

         .m_clk             (m_clk[i]             )
        ,.m_rst_n           (m_rst_n[i]           )

        ,.addr_map          (addr_map[i]          )

        ,.m_awvalid         (m_awvalid[i]         )
        ,.m_awready         (m_awready[i]         )
        ,.m_awid            (m_awid[i]            )
        ,.m_awaddr          (m_awaddr[i]          )
        ,.m_awlen           (m_awlen[i]           )
        ,.m_awsize          (m_awsize[i]          )
        ,.m_awburst         (m_awburst[i]         )
        ,.m_awlock          (m_awlock[i]          )
        ,.m_awcache         (m_awcache[i]         )
        ,.m_awprot          (m_awprot[i]          )
        ,.m_awqos           (m_awqos[i]           )
        ,.m_awregion        (m_awregion[i]        )
        ,.m_awuser          (m_awuser[i]          )

        ,.m_wvalid          (m_wvalid[i]          )
        ,.m_wready          (m_wready[i]          )
        ,.m_wid             (m_wid[i]             )
        ,.m_wdata           (m_wdata[i]           )
        ,.m_wstrb           (m_wstrb[i]           )
        ,.m_wlast           (m_wlast[i]           )
        ,.m_wuser           (m_wuser[i]           )

        ,.m_arvalid         (m_arvalid[i]         )
        ,.m_arready         (m_arready[i]         )
        ,.m_arid            (m_arid[i]            )
        ,.m_araddr          (m_araddr[i]          )
        ,.m_arlen           (m_arlen[i]           )
        ,.m_arsize          (m_arsize[i]          )
        ,.m_arburst         (m_arburst[i]         )
        ,.m_arlock          (m_arlock[i]          )
        ,.m_arcache         (m_arcache[i]         )
        ,.m_arprot          (m_arprot[i]          )
        ,.m_arqos           (m_arqos[i]           )
        ,.m_arregion        (m_arregion[i]        )
        ,.m_aruser          (m_aruser[i]          )


        ,.m_bvalid          (m_bvalid[i]          )
        ,.m_bready          (m_bready[i]          )
        ,.m_bid             (m_bid[i]             )
        ,.m_bresp           (m_bresp[i]           )
        ,.m_buser           (m_buser[i]           )

        ,.m_rvalid          (m_rvalid[i]          )
        ,.m_rready          (m_rready[i]          )
        ,.m_rid             (m_rid[i]             )
        ,.m_rdata           (m_rdata[i]           )
        ,.m_rresp           (m_rresp[i]           )
        ,.m_rlast           (m_rlast[i]           )
        ,.m_ruser           (m_ruser[i]           )


        ,.core_clk          (core_clk          )
        ,.core_rst_n        (core_rst_n        )

        ,.core_egr_valid    (master_core_egr_valid[i]   )
        ,.core_egr_ready    (master_core_egr_ready[i]   )
        ,.core_egr_data     (master_core_egr_data[i]    )

        ,.core_ingr_valid   (master_core_ingr_valid[i]  )
        ,.core_ingr_ready   (master_core_ingr_ready[i]  )
        ,.core_ingr_data    (master_core_ingr_data[i]   )

      );

    end //gen_masters

    for(i=0;i<NUM_SLAVES;i++)
    begin : gen_slaves
      axim_fabric_cbar_slave_shared_node #(
         .AWID_W                  (AXI4_ID_W    )
        ,.AWADDR_W                (AXI4_ADDR_W  )
        ,.AWLEN_W                 (AXI4_LEN_W   )
        ,.AWSIZE_W                (AXI4_SIZE_W  )
        ,.AWBURST_W               (AXI4_BURST_W )
        ,.AWLOCK_W                (AXI4_LOCK_W  )
        ,.AWCACHE_W               (AXI4_CACHE_W )
        ,.AWPROT_W                (AXI4_PROT_W  )
        ,.AWQOS_W                 (AXI4_QOS_W   )
        ,.AWREGION_W              (AXI4_REGION_W)
        ,.AWUSER_W                (AXI4_USER_W  )

        ,.WID_W                   (AXI4_ID_W  )
        ,.WDATA_W                 (AXI4_DATA_W)
        ,.WSTRB_W                 (AXI4_WSTRB_W)
        ,.WLAST_W                 (AXI4_WLAST_W)
        ,.WUSER_W                 (AXI4_USER_W)

        ,.ARID_W                  (AXI4_ID_W    )
        ,.ARADDR_W                (AXI4_ADDR_W  )
        ,.ARLEN_W                 (AXI4_LEN_W   )
        ,.ARSIZE_W                (AXI4_SIZE_W  )
        ,.ARBURST_W               (AXI4_BURST_W )
        ,.ARLOCK_W                (AXI4_LOCK_W  )
        ,.ARCACHE_W               (AXI4_CACHE_W )
        ,.ARPROT_W                (AXI4_PROT_W  )
        ,.ARQOS_W                 (AXI4_QOS_W   )
        ,.ARREGION_W              (AXI4_REGION_W)
        ,.ARUSER_W                (AXI4_USER_W  )

        ,.BID_W                   (AXI4_ID_W  )
        ,.BRESP_W                 (AXI4_BRESP_W)
        ,.BUSER_W                 (AXI4_USER_W)

        ,.RID_W                   (AXI4_ID_W  )
        ,.RDATA_W                 (AXI4_DATA_W)
        ,.RRESP_W                 (AXI4_RRESP_W)
        ,.RLAST_W                 (AXI4_RLAST_W)
        ,.RUSER_W                 (AXI4_USER_W)

        ,.NUM_MASTERS             (NUM_MASTERS       )
        ,.MASTER_ID_W             (MASTER_ID_W       )

        ,.M2S_SHARED_CORE_DATA_W  (M2S_SHARED_CORE_DATA_W)
        ,.S2M_SHARED_CORE_DATA_W  (S2M_SHARED_CORE_DATA_W)

        ,.FIFO_DEPTH              (FIFO_DEPTH        )
        ,.FIFO_MEM_TYPE           (FIFO_MEM_TYPE     )

      ) u_slave_node  (

         .core_clk          (core_clk          )
        ,.core_rst_n        (core_rst_n        )

        ,.core_ingr_valid   (slave_core_ingr_valid[i]     )
        ,.core_ingr_ready   (slave_core_ingr_ready[i]     )
        ,.core_ingr_data    (slave_core_ingr_data[i]      )

        ,.core_egr_valid    (slave_core_egr_valid[i]      )
        ,.core_egr_ready    (slave_core_egr_ready[i]      )
        ,.core_egr_data     (slave_core_egr_data[i]       )


        ,.s_clk             (s_clk[i]             )
        ,.s_rst_n           (s_rst_n[i]           )
                                               
        ,.s_awvalid         (s_awvalid[i]         )
        ,.s_awready         (s_awready[i]         )
        ,.s_awid            (s_awid[i]            )
        ,.s_awaddr          (s_awaddr[i]          )
        ,.s_awlen           (s_awlen[i]           )
        ,.s_awsize          (s_awsize[i]          )
        ,.s_awburst         (s_awburst[i]         )
        ,.s_awlock          (s_awlock[i]          )
        ,.s_awcache         (s_awcache[i]         )
        ,.s_awprot          (s_awprot[i]          )
        ,.s_awqos           (s_awqos[i]           )
        ,.s_awregion        (s_awregion[i]        )
        ,.s_awuser          (s_awuser[i]          )
                                               
        ,.s_wvalid          (s_wvalid[i]          )
        ,.s_wready          (s_wready[i]          )
        ,.s_wid             (s_wid[i]             )
        ,.s_wdata           (s_wdata[i]           )
        ,.s_wstrb           (s_wstrb[i]           )
        ,.s_wlast           (s_wlast[i]           )
        ,.s_wuser           (s_wuser[i]           )
                                               
        ,.s_arvalid         (s_arvalid[i]         )
        ,.s_arready         (s_arready[i]         )
        ,.s_arid            (s_arid[i]            )
        ,.s_araddr          (s_araddr[i]          )
        ,.s_arlen           (s_arlen[i]           )
        ,.s_arsize          (s_arsize[i]          )
        ,.s_arburst         (s_arburst[i]         )
        ,.s_arlock          (s_arlock[i]          )
        ,.s_arcache         (s_arcache[i]         )
        ,.s_arprot          (s_arprot[i]          )
        ,.s_arqos           (s_arqos[i]           )
        ,.s_arregion        (s_arregion[i]        )
        ,.s_aruser          (s_aruser[i]          )
                                               
        ,.s_bvalid          (s_bvalid[i]          )
        ,.s_bready          (s_bready[i]          )
        ,.s_bid             (s_bid[i]             )
        ,.s_bresp           (s_bresp[i]           )
        ,.s_buser           (s_buser[i]           )
                                               
        ,.s_rvalid          (s_rvalid[i]          )
        ,.s_rready          (s_rready[i]          )
        ,.s_rid             (s_rid[i]             )
        ,.s_rdata           (s_rdata[i]           )
        ,.s_rresp           (s_rresp[i]           )
        ,.s_rlast           (s_rlast[i]           )
        ,.s_ruser           (s_ruser[i]           )

      );

    end //gen_slaves

    for(i=0;i<NUM_MASTERS;i++)
    begin : gen_masters_interconnect
      for(j=0;j<NUM_SLAVES;j++)
      begin : gen_slaves_interconnect
        assign  slave_core_ingr_valid[j][i]   = master_core_egr_valid[i][j];
        assign  slave_core_ingr_data[j][i]    = master_core_egr_data[i];
        assign  master_core_egr_ready[i][j]   = slave_core_ingr_ready[j][i];

        assign  master_core_ingr_valid[i][j]  = slave_core_egr_valid[j][i];
        assign  master_core_ingr_data[i][j]   = slave_core_egr_data[j];
        assign  slave_core_egr_ready[j][i]    = master_core_ingr_ready[i][j];
      end //gen_slaves_interconnect
    end //gen_masters_interconnect

  endgenerate

endmodule // axim_fabric_cbar_shared_fifo_top
