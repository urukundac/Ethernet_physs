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
 -- Module Name       : IW_fpga_onehot2bin
 -- Author            : Gregory Matthew James
 -- Associated modules: 
 -- Function          : This module converts a onehot encoded signal to its
                        binary equivalent.
 --------------------------------------------------------------------------
*/

`timescale 1ns / 10ps


module IW_fpga_onehot2bin #(
   parameter  ONEHOT_WIDTH    = 8
  ,parameter  BIN_WIDTH       = $clog2(ONEHOT_WIDTH)

) (

   input  logic [ONEHOT_WIDTH-1:0]  onehot_i
  ,output logic [BIN_WIDTH-1:0]     bin_o

);

//----------------------- Internal Parameters -----------------------------


//----------------------- Internal Register Declarations ------------------
  genvar  i,j;


//----------------------- Start of Code -----------------------------------

  generate
  for (j=0; j<BIN_WIDTH; j=j+1)
    begin : jloop
      wire [ONEHOT_WIDTH-1:0] tmp_mask;

      for (i=0; i<ONEHOT_WIDTH; i=i+1)
      begin : iloop
        assign tmp_mask[i] = i[j];
      end 

      assign bin_o[j] = |(tmp_mask & onehot_i);
    end
  endgenerate

endmodule // IW_fpga_onehot2bin
