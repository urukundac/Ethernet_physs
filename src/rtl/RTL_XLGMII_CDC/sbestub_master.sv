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

module sbestub_master #(
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
      tparity
      
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
output  logic                  [2:0] side_ism_fabric;
input logic                    [2:0] side_ism_agent;

// Egress port interface to the IOSF Sideband Channel
output  logic                        mpccup;
output  logic                        mnpcup;
input logic                          mpcput;
input logic                          mnpput;
input logic                          meom;
input logic [MAXPLDBIT-1:0]          mpayload;
input logic                          mparity;

// Ingress port interface to the IOSF Sideband Channel
input logic                          tpccup;
input logic                          tnpcup;
output  logic                        tpcput;
output  logic                        tnpput;
output  logic                        teom;
output  logic [MAXPLDBIT-1:0]        tpayload;
output  logic                        tparity;

logic                        init_done;
logic [1:0]                  init_cnt;


logic                        mpcput_reg;
logic                        mnpput_reg;

logic  [0:15] [32-1:0] capt_buf;                                                                                           

always_ff @(posedge clk or negedge rst_n)
begin
  if (~rst_n) // lintra s-70023
    for (int i=0; i<16; i++ ) begin
      capt_buf[i]       <= 0;
    end
  else
  begin
    if ( mpcput | mnpput ) capt_buf[0:15]  <= {({MAXPLDBIT{1'b0}}|mpayload),capt_buf[0:14]};
  end
end


always_ff @(posedge clk or negedge rst_n)
begin
  if (~rst_n) // lintra s-70023
    side_ism_fabric       <= ISM_FABRIC_IDLE;
  else
  begin
    casez (side_ism_fabric) // lintra s-60129
    ISM_FABRIC_IDLE:
      if( ~side_ism_lock_b )
        side_ism_fabric <= ISM_FABRIC_IDLE;
      else if (side_ism_agent == ISM_AGENT_ACTIVEREQ)
        side_ism_fabric <= ISM_FABRIC_ACTIVEREQ;
      else if (side_ism_agent == ISM_AGENT_CREDITREQ)
        side_ism_fabric <= ISM_FABRIC_CREDITREQ;

    ISM_FABRIC_ACTIVEREQ:
      if (side_ism_agent == ISM_AGENT_ACTIVE)
        side_ism_fabric <= ISM_FABRIC_ACTIVE;
      else if (side_ism_agent == ISM_AGENT_CREDITREQ)
        side_ism_fabric <= ISM_FABRIC_CREDITREQ;
      else
        side_ism_fabric <= ISM_FABRIC_ACTIVEREQ;
            
    ISM_FABRIC_ACTIVE:
      if((side_ism_agent == ISM_AGENT_IDLEREQ))
        side_ism_fabric <= ISM_FABRIC_IDLE;
      else
        side_ism_fabric <= ISM_FABRIC_ACTIVE;
            
    ISM_FABRIC_IDLENAK:
        side_ism_fabric <= ISM_FABRIC_ACTIVE;//no NAK as stub does not have anything to send
            
    ISM_FABRIC_CREDITREQ:
      if (side_ism_agent == ISM_AGENT_CREDITREQ)
        side_ism_fabric <= ISM_FABRIC_CREDITACK;
      else 
        side_ism_fabric <= ISM_FABRIC_CREDITREQ;

    ISM_FABRIC_CREDITACK:
      if (side_ism_agent == ISM_AGENT_CREDITINIT)
        side_ism_fabric <= ISM_FABRIC_CREDITINIT;
      else 
        side_ism_fabric <= ISM_FABRIC_CREDITACK;

    ISM_FABRIC_CREDITINIT:
      if ( init_done && (side_ism_agent == ISM_AGENT_CREDITDONE))
        side_ism_fabric <= ISM_FABRIC_IDLE;
      else 
        side_ism_fabric <= ISM_FABRIC_CREDITINIT;
            
    default: side_ism_fabric <= side_ism_fabric; // this should never happen!
    endcase
  end
end // block: gen_agent_ism


always_ff @(posedge clk or negedge rst_n)
begin
  if (~rst_n)
    init_cnt <= 2'b0;
  else if (side_ism_fabric == ISM_FABRIC_CREDITINIT)
    init_cnt <= init_cnt + !init_done;
  else
    init_cnt <= 2'b0;
end	  

always_ff @(posedge clk or negedge rst_n)
begin
  if (~rst_n)
  begin
    mpcput_reg <= 1'b0;
    mnpput_reg <= 1'b0;
  end	  
  else
  begin
    mpcput_reg <= mpcput;
    mnpput_reg <= mnpput;
  end	  
end	  

assign init_done = (init_cnt == 2'b11) ? 1'b1 : 1'b0;

assign tpcput   = 1'b0;
assign tnpput   = 1'b0;
assign teom     = 1'b0;
assign tparity  = 1'b0;
assign tpayload = {MAXPLDBIT{1'b0}};

assign mpccup = mpcput_reg | init_cnt[0] | init_cnt[1];
assign mnpcup = mnpput_reg | init_cnt[0] | init_cnt[1];

endmodule

// lintra pop
