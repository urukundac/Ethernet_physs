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
 -- Module Name       : IW_fpga_clk_rst_derivatives_gen
 -- Author            : Gregory James
 -- Associated modules: 
 -- Function          : This module generates resets which get asserted together
                        for multiple derivatives of a slow-clock.
 --------------------------------------------------------------------------
*/

`timescale 1ns / 10ps


module IW_fpga_clk_rst_derivatives_gen #(
    parameter NUM_DERIVATIVE_CLOCKS                                       = 1     //Number of clocks derived from clk_logic
  , parameter integer DERIVATIVE_CLOCK_RATIOS [NUM_DERIVATIVE_CLOCKS-1:0] = '{2}  //List of ratios of derivative clocks wrt clk_logic
 
) (

  /*  Slow Clock & Reset  */
    input   logic                             clk_logic
  , input   logic                             rst_logic_n
  , input   logic                             clk_en

  /*  Derivatives */
  , input   logic [NUM_DERIVATIVE_CLOCKS-1:0] clk_logic_derivatives
  , output  logic [NUM_DERIVATIVE_CLOCKS-1:0] rst_logic_derivatives_n

);

//----------------------- Import Packages ---------------------------------


//----------------------- Internal Parameters -----------------------------


//----------------------- Internal Register Declarations ------------------
  genvar  i;

  logic                       rst_logic_int_n;

//----------------------- Internal Wire Declarations ----------------------


//----------------------- Start of Code -----------------------------------

  /*  Generate synchronous reset  */
  always@(posedge clk_logic,  negedge rst_logic_n)
  begin
    if(~rst_logic_n)
    begin
      rst_logic_int_n   <=  0;
    end
    else
    begin
      if ( clk_en ) rst_logic_int_n   <=  1'b1;
    end
  end

  /*  Synchronize Derivative Resets  */
  generate
    for(i=0;i<NUM_DERIVATIVE_CLOCKS;i++)
    begin : gen_deriv_rst_sync
      parameter DERIVATIVE_CLOCK_RATIO  = DERIVATIVE_CLOCK_RATIOS[i];

      reg [DERIVATIVE_CLOCK_RATIO-1:0]  rst_sync_pipe;

      always@(posedge clk_logic_derivatives[i], negedge rst_logic_int_n)
      begin
        if(~rst_logic_int_n)
        begin
          rst_sync_pipe       <=  0;
        end
        else
        begin
          rst_sync_pipe       <=  {rst_sync_pipe[DERIVATIVE_CLOCK_RATIO-2:0],1'b1};
        end
      end

      assign  rst_logic_derivatives_n[i]  = rst_sync_pipe[DERIVATIVE_CLOCK_RATIO-1];
    end
  endgenerate


endmodule // IW_fpga_clk_rst_derivatives_gen
