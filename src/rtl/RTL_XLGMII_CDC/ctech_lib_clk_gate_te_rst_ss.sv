//------------------------------------------------------------------------------
//
//  INTEL CONFIDENTIAL
//
//  Copyright (2014) - (2017) Intel Corporation All Rights Reserved.
//
//  The source code contained or described herein and all documents related
//  to the source code ("Material") are owned by Intel Corporation or its
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

module ctech_lib_clk_gate_te_rst_ss (
   input logic en,     // Enable input logic signal
   input logic te,     // Test mode latch open. Port map to: Tlatch_open
   input logic rst,   // Test mode latch close. Port map to: Tlatch_closedB
   input logic clk,     // Clock input
   output logic clkout,  // Clock-gated enable output
   input logic ss
);
   `ifdef INTEL_DC
   "ERROR, do not use this file for DC"
   `else
  logic q;
  always_latch
     if (~clk)
        q <= en;
  assign clkout =  (q|te) & (~rst) & (ss|clk);
   `endif
endmodule
