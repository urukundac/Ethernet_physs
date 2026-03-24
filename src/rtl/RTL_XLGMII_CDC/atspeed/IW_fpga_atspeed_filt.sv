//------------------------------------------------------------------------------
//                               INTEL CONFIDENTIAL
//           Copyright 2013-2014 Intel Corporation All Rights Reserved. 
// 
// The source code contained or described herein and all documents related
// to the source code ("Material") are owned by Intel Corporation or its 
// suppliers or licensors. Title to the Material remains with Intel
// Corporation or its suppliers and licensors. The Material contains trade
// secrets and proprietary and confidential information of Intel or its 
// suppliers and licensors. The Material is protected by worldwide copyright
// and trade secret laws and treaty provisions. No part of the Material 
// may be used, copied, reproduced, modified, published, uploaded, posted,
// transmitted, distributed, or disclosed in any way without Intel's prior
// express written permission.
// 
// No license under any patent, copyright, trade secret or other intellectual
// property right is granted to or conferred upon you by disclosure or delivery
// of the Materials, either expressly, by implication, inducement, estoppel or
// otherwise. Any license under such intellectual property rights must be
// express and approved by Intel in writing.
//------------------------------------------------------------------------------

`timescale 1ns/10ps

module IW_fpga_atspeed_filt #(
   parameter INSTANCE_NAME            = "IW_fpga_atspeed_filt"
  ,parameter DATA_WIDTH               = 256
  ,parameter USE_FLOP                 = 0
  ,parameter NUM_FILT                 = 1

) (
    /* clk reset and enable  */
    input  logic                                 clk,
    input  logic                                 rst_n,

    /* match parameters */
    input  logic    [NUM_FILT-1:0]  [31:0]       match_mask,
    input  logic    [NUM_FILT-1:0]  [31:0]       match_value,
    input  logic    [NUM_FILT-1:0]  [31:0]       mask_shift,
    input  logic    [NUM_FILT-1:0]               filter_enable,

    /*  Data input  */    
    input logic     [DATA_WIDTH-1:0]             data_in,
    input logic                                  data_valid,

    /* match output */ 
    output logic                                 match_out,
    output logic    [DATA_WIDTH-1:0]             data_out

);

logic [NUM_FILT-1:0]                  match;
 
// Masked Data should match filter value. Currently, to avoid lengthy
// data and automation aspects, shift register is implemented and
// part of data is only compared
genvar filt;
for (filt=0; filt<NUM_FILT; filt++) begin:gen_match
  always_comb
    if(filter_enable[filt]) begin
      if(((data_in >> mask_shift[filt]) & match_mask[filt]) == 
         (match_value[filt] & match_mask[filt]))
        match[filt] = 1'b1;
      else
        match[filt] = 1'b0;
    end else begin
        match[filt] = 1'b0;
    end
end //gen_match

// Based on the USE_FLOP parameter, registered/cominatorial
// output match_out is generated
if(USE_FLOP ==0)
  always_comb begin
    match_out <= (|match) & data_valid;
    data_out  <= data_in;
  end
else
  always_ff @(posedge clk) begin
    match_out <= (|match) & data_valid;
    data_out  <= data_in;
  end
endmodule
