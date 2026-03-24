//------------------------------------------------------------------------------
//
//  -- Intel Proprietary
//  -- Copyright (C) 2015 Intel Corporation
//  -- All Rights Reserved
//
//  INTEL CONFIDENTIAL
//
//  Copyright 2009-2016 Intel Corporation All Rights Reserved.
//
//  The source code contained or described herein and all documents related
//  to the source code (Material) are owned by Intel Corporation or its
//  suppliers or licensors. Title to the Material remains with Intel
//  Corporation or its suppliers and licensors. The Material contains trade
//  secrets and proprietary and confidential information of Intel or its
//  suppliers and licensors. The Material is protected by worldwide copyright
//  and trade secret laws and treaty provisions. No part of the Material may
//  be used, copied, reproduced, modified, published, uploaded, posted,
//  transmitted, distributed, or disclosed in any way without Intel's prior
//  express written permission.
//
//  No license under any patent, copyright, trade secret or other intellectual
//  property right is granted to or conferred upon you by disclosure or
//  delivery of the Materials, either expressly, by implication, inducement,
//  estoppel or otherwise. Any license under such intellectual property rights
//  must be express and approved by Intel in writing.
//
//------------------------------------------------------------------------------
//
//  Collateral Description:
//  IOSF - Sideband Channel IP
//
//  Source organization:
//  SEG / SIP / IOSF IP Engineering
//
//  Support Information:
//  WEB: http://moss.amr.ith.intel.com/sites/SoftIP/Shared%20Documents/Forms/AllItems.aspx
//  HSD: https://vthsd.fm.intel.com/hsd/seg_softip/default.aspx
//
//  Revision:
//  2016WW05
//
//  Module sbebase : The top-level for the sideband interface base endpoint
//                   This block contains no internal master/target agents, only
//                   the master/target interface to the AGENT block. It allows for
//                   a parameterized number of external master/target agents for
//                   both traffic classes (posted/completion and non-posted).
//                   This block does contain an unclaimed non-posted message
//                   target which generates completions for all target
//                   non-posted messages that are not claimed by the AGENT-block.
//------------------------------------------------------------------------------


// lintra push -60020, -60088, -80018, -80028, -80099, -68001, -68000, -60022, -60024b, -70607

module p2sb_stub #(
    parameter MAXPLDBIT                   = 8 // Maximum payload bit, should be 7, 15 or 31
) (
      clk,
      rst_n,
      side_ism_lock_b,

      side_ism_fabric,
      side_ism_agent,

      // Egress port interface to the IOSF Sideband Channel
      mpccup,
      mnpcup,
      mpcput,
      mnpput,
      meom,
      mpayload,       // lintra s-80095
      mparity,

      // Ingress port interface to the IOSF Sideband Channel
      tpccup,
      tnpcup,
      tpcput,
      tnpput,
      teom,
      tpayload,     // lintra s-80095
      tparity,

     //pcie pins
      pcie_in,               
      pcie_out,
      dbg_regs_snapshot,
      dbg_clear_counters,
      dbg_take_snapshot,
      dbg_out   
      
);

// Clock gating ISMs           
localparam [2:0]  ISM_AGENT_IDLE       = 3'b000;
localparam [2:0]  ISM_AGENT_IDLEREQ    = 3'b001;
localparam [2:0]  ISM_AGENT_ACTIVE     = 3'b011;
localparam [2:0]  ISM_AGENT_ACTIVEREQ  = 3'b010;
localparam [2:0]  ISM_AGENT_CREDITREQ  = 3'b100;
localparam [2:0]  ISM_AGENT_CREDITINIT = 3'b101;
localparam [2:0]  ISM_AGENT_CREDITDONE = 3'b110;
localparam [2:0]  ISM_AGENT_RSV7       = 3'b111;

localparam [2:0]  ISM_FABRIC_IDLE      = 3'b000;
localparam [2:0]  ISM_FABRIC_IDLENAK   = 3'b001;
localparam [2:0]  ISM_FABRIC_ACTIVE    = 3'b011;
localparam [2:0]  ISM_FABRIC_ACTIVEREQ = 3'b010;
localparam [2:0]  ISM_FABRIC_CREDITREQ = 3'b100;
localparam [2:0]  ISM_FABRIC_CREDITACK = 3'b110;
localparam [2:0]  ISM_FABRIC_CREDITINIT= 3'b101;
localparam [2:0]  ISM_FABRIC_RSV7      = 3'b111;

input  logic                        clk;
input  logic                        rst_n;

input  logic                        side_ism_lock_b;


// Clock gating ISM Signals (endpoint)
input  logic                  [2:0] side_ism_fabric;
output logic                  [2:0] side_ism_agent;

// Egress port interface to the IOSF Sideband Channel
input  logic                        mpccup;
input  logic                        mnpcup;
output logic                        mpcput;
output logic                        mnpput;
output logic                        meom;
output logic [MAXPLDBIT-1:0]          mpayload;
output logic                        mparity;

// Ingress port interface to the IOSF Sideband Channel
output logic                        tpccup;
output logic                        tnpcup;
input  logic                        tpcput;
input  logic                        tnpput;
input  logic                        teom;
input  logic [MAXPLDBIT-1:0]          tpayload;
input  logic                        tparity;

//----------------------------------------------------------------------------------
//Dummy port for PCIE
//----------------------------------------------------------------------------------
  input   logic    [511:0]                 pcie_in;
  output  logic    [511:0]                 pcie_out;
  output  reg      [127:0][31:0]           dbg_regs_snapshot;
  input   logic                            dbg_clear_counters;
  input   logic                            dbg_take_snapshot;
  output  logic    [63:0]                  dbg_out; 
//----------------------------------------------------------------------------------

logic                        init_done;
logic [1:0]                  init_cnt;

logic                        crdt_init_done;

logic                        tpcput_reg;
logic                        tnpput_reg;


always_ff @(posedge clk or negedge rst_n)
begin
  if (~rst_n) // lintra s-70023
    side_ism_agent       <= ISM_AGENT_IDLE;
  else
  begin
    casez (side_ism_agent) // lintra s-60129
    ISM_AGENT_IDLE:
      if( ~side_ism_lock_b )
        side_ism_agent <= ISM_AGENT_IDLE;
      else if (side_ism_fabric == ISM_FABRIC_ACTIVEREQ)
        side_ism_agent <= ISM_AGENT_ACTIVEREQ;
      else if (!crdt_init_done)
        side_ism_agent <= ISM_AGENT_CREDITREQ;

    ISM_AGENT_ACTIVEREQ:
      if (side_ism_fabric == ISM_FABRIC_ACTIVEREQ) // External request/acknowledge of ACTIVE REQ
        side_ism_agent <= ISM_AGENT_ACTIVE;
      else if (side_ism_fabric == ISM_FABRIC_CREDITREQ) // External request for CREDIT REQ
        side_ism_agent <= ISM_AGENT_CREDITREQ;
      else
        side_ism_agent <= ISM_AGENT_ACTIVEREQ;
            
    ISM_AGENT_ACTIVE:
      if((side_ism_fabric != ISM_FABRIC_ACTIVE) && (side_ism_fabric == ISM_FABRIC_IDLENAK))
        side_ism_agent <= ISM_AGENT_IDLEREQ;
      else
        side_ism_agent <= ISM_AGENT_ACTIVE;
            
    ISM_AGENT_IDLEREQ:
      if (side_ism_fabric == ISM_FABRIC_IDLE)
        side_ism_agent    <= ISM_AGENT_IDLE;
      else if (side_ism_fabric == ISM_FABRIC_IDLENAK) // External ISM is Naking the IDLE REQ
        side_ism_agent <= ISM_AGENT_ACTIVE;
      else
        side_ism_agent <= ISM_AGENT_IDLEREQ;
            
    ISM_AGENT_CREDITREQ:
      if (side_ism_fabric == ISM_FABRIC_CREDITACK)
        side_ism_agent <= ISM_AGENT_CREDITINIT;
      else 
        side_ism_agent <= ISM_AGENT_CREDITREQ;
            
    ISM_AGENT_CREDITINIT:
      if ( init_done && (side_ism_fabric == ISM_FABRIC_CREDITINIT))
        side_ism_agent <= ISM_AGENT_CREDITDONE;
      else 
        side_ism_agent <= ISM_AGENT_CREDITINIT;
            
    ISM_AGENT_CREDITDONE:
      if (side_ism_fabric == ISM_FABRIC_IDLE)
        side_ism_agent    <= ISM_AGENT_IDLE;
      else 
        side_ism_agent <= ISM_AGENT_CREDITDONE;
            
    default: side_ism_agent <= side_ism_agent; // this should never happen!
    endcase
  end
end // block: gen_agent_ism


always_ff @(posedge clk or negedge rst_n)
begin
  if (~rst_n)
    init_cnt <= 2'b0;
  else if (side_ism_agent == ISM_AGENT_CREDITINIT)  
    init_cnt <= init_cnt + 1;
  else    
    init_cnt <= 2'b0;
end	  

always_ff @(posedge clk or negedge rst_n)
begin
  if (~rst_n)
  begin
    tpcput_reg <= 1'b0;
    tnpput_reg <= 1'b0;
  end	  
  else
  begin
    tpcput_reg <= tpcput;
    tnpput_reg <= tnpput;
  end	  
end	  

always_ff @(posedge clk or negedge rst_n)
begin
  if (~rst_n)
    crdt_init_done <= 1'b0;
  else if (~side_ism_lock_b)
    crdt_init_done <= 1'b0;
  else if (side_ism_agent == ISM_AGENT_CREDITDONE)
    crdt_init_done <= 1'b1;
end
assign init_done = (init_cnt == 2'b11) ? 1'b1 : 1'b0;

assign mpcput   = 1'b0;
assign mnpput   = 1'b0;
assign meom     = 1'b0;
assign mparity  = 1'b0;
assign mpayload = {MAXPLDBIT{1'b0}};

assign tpccup = tpcput_reg | init_cnt[0] | init_cnt[1];
assign tnpcup = tnpput_reg | init_cnt[0] | init_cnt[1];

endmodule

// lintra pop
