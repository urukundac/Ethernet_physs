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
 -- Module Name       : axim_fabric_common_defines
 -- Author            : Gregory James
 -- Associated modules: 
 -- Function          : A set of common defines & utilities used accross
                        the design.
 --------------------------------------------------------------------------
*/

`ifndef __AXIM_FABRIC_COMMON_DEFINES
`define __AXIM_FABRIC_COMMON_DEFINES

/*  AW Channel  */
`define _create_axi4_aw_struct(name,AWID_W,AWADDR_W,AWLEN_W,AWSIZE_W,AWBURST_W,AWLOCK_W,AWCACHE_W,AWPROT_W,AWQOS_W,AWREGION_W,AWUSER_W) \
  struct  packed  { \
    logic [AWID_W-1:0]      awid; \
    logic [AWADDR_W-1:0]    awaddr; \
    logic [AWLEN_W-1:0]     awlen; \
    logic [AWSIZE_W-1:0]    awsize; \
    logic [AWBURST_W-1:0]   awburst; \
    logic [AWLOCK_W-1:0]    awlock; \
    logic [AWCACHE_W-1:0]   awcache; \
    logic [AWPROT_W-1:0]    awprot; \
    logic [AWQOS_W-1:0]     awqos; \
    logic [AWREGION_W-1:0]  awregion; \
    logic [AWUSER_W-1:0]    awuser; \
  } name;

`define _create_axi4_aw_struct_t(name,AWID_W,AWADDR_W,AWLEN_W,AWSIZE_W,AWBURST_W,AWLOCK_W,AWCACHE_W,AWPROT_W,AWQOS_W,AWREGION_W,AWUSER_W) \
  typedef `_create_axi4_aw_struct(name,AWID_W,AWADDR_W,AWLEN_W,AWSIZE_W,AWBURST_W,AWLOCK_W,AWCACHE_W,AWPROT_W,AWQOS_W,AWREGION_W,AWUSER_W)


/*  W Channel */
`define _create_axi4_w_struct(name,WID_W,WDATA_W,WSTRB_W,WLAST_W,WUSER_W) \
  struct  packed  { \
    logic [WID_W-1:0]      wid; \
    logic [WDATA_W-1:0]    wdata; \
    logic [WSTRB_W-1:0]    wstrb; \
    logic [WLAST_W-1:0]    wlast; \
    logic [WUSER_W-1:0]    wuser; \
  } name;

`define _create_axi4_w_struct_t(name,WID_W,WDATA_W,WSTRB_W,WLAST_W,WUSER_W) \
  typedef `_create_axi4_w_struct(name,WID_W,WDATA_W,WSTRB_W,WLAST_W,WUSER_W)


/*  B Channel */
`define _create_axi4_b_struct(name,BID_W,BRESP_W,BUSER_W) \
  struct  packed  { \
    logic [BID_W-1:0]      bid; \
    logic [BRESP_W-1:0]    bresp; \
    logic [BUSER_W-1:0]    buser; \
  } name;

`define _create_axi4_b_struct_t(name,BID_W,BRESP_W,BUSER_W) \
  typedef `_create_axi4_b_struct(name,BID_W,BRESP_W,BUSER_W)


/*  AR Channel  */
`define _create_axi4_ar_struct(name,ARID_W,ARADDR_W,ARLEN_W,ARSIZE_W,ARBURST_W,ARLOCK_W,ARCACHE_W,ARPROT_W,ARQOS_W,ARREGION_W,ARUSER_W) \
  struct  packed  { \
    logic [ARID_W-1:0]      arid; \
    logic [ARADDR_W-1:0]    araddr; \
    logic [ARLEN_W-1:0]     arlen; \
    logic [ARSIZE_W-1:0]    arsize; \
    logic [ARBURST_W-1:0]   arburst; \
    logic [ARLOCK_W-1:0]    arlock; \
    logic [ARCACHE_W-1:0]   arcache; \
    logic [ARPROT_W-1:0]    arprot; \
    logic [ARQOS_W-1:0]     arqos; \
    logic [ARREGION_W-1:0]  arregion; \
    logic [ARUSER_W-1:0]    aruser; \
  } name;

`define _create_axi4_ar_struct_t(name,ARID_W,ARADDR_W,ARLEN_W,ARSIZE_W,ARBURST_W,ARLOCK_W,ARCACHE_W,ARPROT_W,ARQOS_W,ARREGION_W,ARUSER_W) \
  typedef `_create_axi4_ar_struct(name,ARID_W,ARADDR_W,ARLEN_W,ARSIZE_W,ARBURST_W,ARLOCK_W,ARCACHE_W,ARPROT_W,ARQOS_W,ARREGION_W,ARUSER_W)


/*  R Channel */
`define _create_axi4_r_struct(name,RID_W,RDATA_W,RRESP_W,RLAST_W,RUSER_W) \
  struct  packed  { \
    logic [RID_W-1:0]      rid; \
    logic [RDATA_W-1:0]    rdata; \
    logic [RRESP_W-1:0]    rresp; \
    logic [RLAST_W-1:0]    rlast; \
    logic [RUSER_W-1:0]    ruser; \
  } name;

`define _create_axi4_r_struct_t(name,RID_W,RDATA_W,RRESP_W,RLAST_W,RUSER_W) \
  typedef `_create_axi4_r_struct(name,RID_W,RDATA_W,RRESP_W,RLAST_W,RUSER_W)


/*  AW->W Node */
`define _create_axi4_aw2w_node_struct(name,SLAVE_ID_W,AXI_ID_W)  \
  struct  packed  { \
    logic [SLAVE_ID_W-1:0]  slave_id; \
    logic [AXI_ID_W-1:0]    axi_id; \
  } name;

`define _create_axi4_aw2w_node_struct_t(name,SLAVE_ID_W,ID_W) \
  typedef `_create_axi4_aw2w_node_struct(name,SLAVE_ID_W,ID_W)


/*  Ingr2Egr B Node */
`define _create_axi4_ingr2egr_b_struct(name,MASTER_ID_W,AXI_ID_W)  \
  struct  packed  { \
    logic [MASTER_ID_W-1:0] master_id; \
    logic [AXI_ID_W-1:0]    axi_id; \
  } name;

`define _create_axi4_ingr2egr_b_struct_t(name,MASTER_ID_W,ID_W) \
  typedef `_create_axi4_ingr2egr_b_struct(name,MASTER_ID_W,ID_W)

/*  Ingr2Egr R Node */
`define _create_axi4_ingr2egr_r_struct(name,MASTER_ID_W,AXI_ID_W)  \
  struct  packed  { \
    logic [MASTER_ID_W-1:0] master_id; \
    logic [AXI_ID_W-1:0]    axi_id; \
  } name;

`define _create_axi4_ingr2egr_r_struct_t(name,MASTER_ID_W,ID_W) \
  typedef `_create_axi4_ingr2egr_r_struct(name,MASTER_ID_W,ID_W)


/* Transaction Type (Shared FF Mode)  */
`define _create_axi4_xtn_enum(name)  \
  enum  logic [2:0] { \
    AW_XTN  = 3'b000, \
    W_XTN   = 3'b001, \
    AR_XTN  = 3'b010, \
    B_XTN   = 3'b011, \
    R_XTN   = 3'b100  \
  } name;

`define _create_axi4_xtn_enum_t(name)  \
  typedef `_create_axi4_xtn_enum(name)

/* Shared core struct */
`define _create_axi4_shared_core_struct(name,XTN_TYPE,DATA_WIDTH)  \
  struct  packed  { \
    XTN_TYPE                xtn;  \
    logic [DATA_WIDTH-1:0]  data; \
  } name;

`define _create_axi4_shared_core_struct_t(name,XTN_TYPE,DATA_WIDTH)  \
  typedef `_create_axi4_shared_core_struct(name,XTN_TYPE,DATA_WIDTH)



`endif  //__AXIM_FABRIC_COMMON_DEFINES
