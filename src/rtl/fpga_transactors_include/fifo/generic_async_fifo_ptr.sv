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
 -- Project Code      : axi_fabric
 -- Module Name       : generic_async_fifo_ptr
 -- Author            : Gregory James
 -- Associated modules: 
 -- Function          : This module implements a parameterizable Binaray+Gray
                        code counters which can be used as memory pointers
                        in an asynchronous FIFO.
 --------------------------------------------------------------------------
*/

`timescale 1ns / 10ps


module generic_async_fifo_ptr #(
//----------------------- Global parameters Declarations ------------------
   parameter  WIDTH       = 8 //Must be a power of 2
  ,parameter  INC_VAL     = 1 
  ,parameter  WIDTH_RATIO = 1

) (

   input  logic              clk
  ,input  logic              rst_n

  ,input  logic              inc

  ,output logic [WIDTH-1:0]  bin_ptr
  ,output logic [WIDTH-1:0]  bin_ptr_next
  ,output logic [WIDTH-1:0]  bin_ptr_wadj
  ,output logic [WIDTH-1:0]  bin_ptr_wadj_next

  ,output logic [WIDTH-1:0]  gry_ptr
  ,output logic [WIDTH-1:0]  gry_ptr_next
  ,output logic [WIDTH-1:0]  gry_ptr_wadj
  ,output logic [WIDTH-1:0]  gry_ptr_wadj_next

);

//----------------------- Import Packages ---------------------------------


//----------------------- Internal Parameters -----------------------------


//----------------------- Internal Register Declarations ------------------


//----------------------- Internal Wire Declarations ----------------------



//----------------------- Start of Code -----------------------------------

  always@(posedge clk,  negedge rst_n)
  begin
    if(~rst_n)
    begin
      bin_ptr       <=  {WIDTH{1'b0}};
      bin_ptr_wadj  <=  {WIDTH{1'b0}};
      gry_ptr       <=  {WIDTH{1'b0}};
      gry_ptr_wadj  <=  {WIDTH{1'b0}};
    end
    else
    begin
      bin_ptr       <=  bin_ptr_next;
      bin_ptr_wadj  <=  bin_ptr_wadj_next;
      gry_ptr       <=  gry_ptr_next;
      gry_ptr_wadj  <=  gry_ptr_wadj_next;
    end
  end

  assign  bin_ptr_next  = inc ? bin_ptr + INC_VAL : bin_ptr;

  //assign  gry_ptr_next  = (bin_ptr_next>>1) ^ bin_ptr_next;
  assign  gry_ptr_next  = {bin_ptr_next[WIDTH-1],(bin_ptr_next[WIDTH-1:1] ^ bin_ptr_next[WIDTH-2:0])};

  assign  gry_ptr_wadj_next = {bin_ptr_wadj_next[WIDTH-1],(bin_ptr_wadj_next[WIDTH-1:1] ^ bin_ptr_wadj_next[WIDTH-2:0])};

  generate
    if(WIDTH_RATIO  > 1)
    begin
      assign  bin_ptr_wadj_next = {bin_ptr_next[WIDTH-1:$clog2(WIDTH_RATIO)],{$clog2(WIDTH_RATIO){1'b0}}};
    end
    else
    begin
      assign  bin_ptr_wadj_next = bin_ptr_next;
    end
  endgenerate

endmodule // generic_async_fifo_ptr
