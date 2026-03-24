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
// Version and Release Control Information:
//
// File Name:$RCSfile:$
// File Revision:$
// Created by:    Gregory James
// Updated by:    $Author:$ $Date:$
//------------------------------------------------------------------------------
// This module derives a copy of a clock using flops that can be safely used in
// cases where the clock needs to be used as a signal.
//------------------------------------------------------------------------------

`timescale  1ns/1ps

module  IW_fpga_clk_derive (

   input  logic   clk_in
  ,input  logic   rst_in_n

  ,output logic   clk_derive_out
  ,output logic   clk_derive_inv_out

);

  /*  Internal Parameters */


  /*  Internal Variables  */
  logic                       clk_in_pos_divby2=1'b0;
  logic                       clk_in_neg_divby2=1'b0;


  // generate clock without a reset
   always @(posedge clk_in ) begin
     clk_in_pos_divby2  <= ~clk_in_pos_divby2;
   end
   always @(negedge clk_in ) begin
     clk_in_neg_divby2  <= clk_in_pos_divby2;
   end
  // rebuild signals which looks like clka
  assign  clk_derive_out  = clk_in_pos_divby2  ^ clk_in_neg_divby2;
  assign  clk_derive_inv_out  = ~clk_derive_out;



endmodule //IW_fpga_clk_derive
