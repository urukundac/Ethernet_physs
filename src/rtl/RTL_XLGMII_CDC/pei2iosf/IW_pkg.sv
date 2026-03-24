//-----------------------------------------------------------------------------------------------------
//
// INTEL CONFIDENTIAL
//
// Copyright 2015 Intel Corporation All Rights Reserved.
//
// The source code contained or described herein and all documents related to the source code
// ("Material") are owned by Intel Corporation or its suppliers or licensors. Title to the Material
// remains with Intel Corporation or its suppliers and licensors. The Material contains trade
// secrets and proprietary and confidential information of Intel or its suppliers and licensors.
// The Material is protected by worldwide copyright and trade secret laws and treaty provisions.
// No part of the Material may be used, copied, reproduced, modified, published, uploaded, posted,
// transmitted, distributed, or disclosed in any way without Intel's prior express written permission.
//
// No license under any patent, copyright, trade secret or other intellectual property right is
// granted to or conferred upon you by disclosure or delivery of the Materials, either expressly, by
// implication, inducement, estoppel or otherwise. Any license under such intellectual property rights
// must be express and approved by Intel in writing.
//
//-----------------------------------------------------------------------------------------------------
// IW_pkg
//
// Package containing support functions for AW library and common functions provided by this library
//-----------------------------------------------------------------------------------------------------

package IW_pkg;

`include "IW_logb2.svh"

typedef enum logic [3:0] {
ILL15 = 4'd15 ,
ILL14 = 4'd14 ,
ILL13 = 4'd13 ,
ILL12 = 4'd12 ,
ILL11 = 4'd11 ,
DIR_POOL = 4'd10 ,
DIR_QID = 4'd9 ,
DIR_CQ = 4'd8 ,
ILL7 = 4'd7 ,
ILL6 = 4'd6 ,
ILL5 = 4'd5 ,
ILL4 = 4'd4 ,
ILL3 = 4'd3 ,
LDB_POOL = 4'd2 ,
LDB_QID = 4'd1 ,
LDB_CQ = 4'd0 
} cfg_vf_reset_type_t ;
typedef struct packed {
    logic [( 96)-1:0]   rsvd_1;
    logic [( 24)-1:0]   cfg_vf_reset_id;
    cfg_vf_reset_type_t cfg_vf_reset_type;
    logic [(  3)-1:0]   cfg_vf_reset_cmd;  //0: generic broadcast  1-7: special use
    logic               rsvd_start;
} cfg_bcast_reg_t;

typedef struct packed {
    logic               bcast;
    logic [(8)-1:0]     pp;
    logic [(11)-1:0]    user;
} cfg_user_t;

typedef struct packed {
    logic [( 2)-1:0]    mode;
    logic [( 4)-1:0]    node;
    logic [(16)-1:0]    target;
    logic [(16)-1:0]    offset;
} cfg_addr_t;

typedef struct packed {
    cfg_user_t          user;
    logic               addr_par;
    cfg_addr_t          addr;
    logic               wdata_par;
    logic [(32)-1:0]    wdata;
} cfg_req_t;

typedef struct packed {
    logic               err;
    logic               err_slv_par;
    logic               rdata_par;
    logic [(32)-1:0]    rdata;
    logic [(4)-1:0]     uid;
} cfg_rsp_t;

typedef struct packed {
    logic [(3)-1:0]     msix_map;
    logic [(2)-1:0]     rtype;
    logic [(8)-1:0]     rid;
} aw_alarm_syn_t;

typedef struct packed {
    logic [(4)-1:0]     unit;
    logic [(6)-1:0]     aid;
    logic [(2)-1:0]     cls;
    logic [(3)-1:0]     msix_map;
    logic [(2)-1:0]     rtype;
    logic [(8)-1:0]     rid;
} aw_alarm_t;

typedef enum logic [2:0] {
  HQM_IW_MF_NOOP        = 3'h0
, HQM_IW_MF_PUSH        = 3'h1
, HQM_IW_MF_POP         = 3'h2
, HQM_IW_MF_READ        = 3'h3
, HQM_IW_MF_INIT_PTRS   = 3'h4
} aw_multi_fifo_cmd_t ;

typedef struct packed {
  logic [23:0]  depth;
  logic         full;
  logic         afull;
  logic         aempty;
  logic         empty;
  logic         rsvd3;
  logic         parity_err;
  logic         overflow;
  logic         underflow;
} aw_fifo_status_t;

typedef enum logic [1:0] {
  HQM_IW_RMWPIPE_NOOP   = 2'h0
, HQM_IW_RMWPIPE_READ   = 2'h1
, HQM_IW_RMWPIPE_WRITE  = 2'h2
, HQM_IW_RMWPIPE_RMW    = 2'h3
} aw_rmwpipe_cmd_t ;

typedef enum logic [1:0] {
  HQM_IW_RWPIPE_NOOP    = 2'h0
, HQM_IW_RWPIPE_READ    = 2'h1
, HQM_IW_RWPIPE_WRITE   = 2'h2
, HQM_IW_RWPIPE_ILL     = 2'h3
} aw_rwpipe_cmd_t ;

typedef struct packed {
  logic [2:0]   eid;
  logic [1:0]   jid;
  logic [10:0]  bytes;
  logic [63:0]  addr;
} aw_caal_crr_t;
endpackage : IW_pkg
