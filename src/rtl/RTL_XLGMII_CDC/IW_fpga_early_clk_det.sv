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
 -- Project Code      : IMPrES
 -- Module Name       : IW_fpga_early_clk_det
 -- Author            : Gregory James
 -- Associated modules: 
 -- Function          : This module detects the edge of a slow-clock using
                        a fast clock as well as an early edge pulse.
 --------------------------------------------------------------------------
*/

`timescale 1ns / 10ps


module IW_fpga_early_clk_det #(
   parameter  CNTR_W            = 8
  ,parameter  NUM_CYCLES_EARLY  = 0

) (

   input  logic               clk_fast
  ,input  logic               rst_fast_n

  ,input  logic               clk_slow
  ,input  logic               rst_slow_n

  ,output logic [CNTR_W-1:0]  edge_det_cntr
  ,output logic [CNTR_W-1:0]  edge_det_start_val
  ,output logic               edge_det_valid

);

//----------------------- Import Packages ---------------------------------


//----------------------- Internal Parameters -----------------------------


//----------------------- Internal Register Declarations ------------------
  logic                       clk_slow_internal;
  logic                       clk_slow_internal_1d;
  logic                       clk_slow_internal_edge_det;

//----------------------- Internal Wire Declarations ----------------------


//----------------------- Start of Code -----------------------------------

  /*  Generate a version of clk_slow using flops  */
  IW_fpga_clk_derive  u_IW_fpga_clk_derive
  (
  
      .clk_in         (clk_slow)
     ,.rst_in_n       (rst_slow_n)
  
     ,.clk_derive_out (clk_slow_internal)
  
  );


  /*  Edge Detect Logic */
  always@(posedge clk_fast, negedge rst_fast_n)
  begin
    if(~rst_fast_n)
    begin
      clk_slow_internal_1d    <=  1'b1;
      edge_det_cntr           <=  0;
      edge_det_start_val      <=  0;
      edge_det_valid          <=  0;
    end
    else
    begin
      clk_slow_internal_1d    <=  clk_slow_internal;

      if(clk_slow_internal_edge_det)
      begin
        edge_det_start_val    <=  edge_det_cntr - (NUM_CYCLES_EARLY + 1) ;
        edge_det_cntr         <=  0;
      end
      else
      begin
        edge_det_cntr         <=  edge_det_cntr + 1'b1;
      end

      edge_det_valid          <=  (edge_det_cntr  ==  edge_det_start_val) ? 1'b1  : 1'b0;
    end
  end

  //Check for posedge of clk_slow_internal
  assign  clk_slow_internal_edge_det  = clk_slow_internal & ~clk_slow_internal_1d;

endmodule // IW_fpga_early_clk_det
