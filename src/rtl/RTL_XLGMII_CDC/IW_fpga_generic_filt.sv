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

module IW_fpga_generic_filt #(
  parameter DATA_WIDTH = 256,
  parameter USE_FLOP = 0

) (
    /* clk reset and enable  */
    input  logic                                    clk,
    input  logic                                    rst_n,
    input  logic                                    enable,

    input  logic    [DATA_WIDTH-1:0]                match_mask,
    input  logic    [DATA_WIDTH-1:0]                match_data,

    /*  Data from parser  */    
    input logic     [DATA_WIDTH-1:0]                mon_data,
    input logic                                     mon_data_valid,
 
    /* output data from filter  */
    output logic    [DATA_WIDTH-1:0]                filt_data,
    output logic                                    filt_data_valid,

    input  logic                                    filt_bp

);

generate
  if (USE_FLOP)
  begin // USE_FLOP =1
    always @(posedge clk or negedge rst_n)
    begin
      if (~rst_n)
      begin
        filt_data            <= 0;
        filt_data_valid      <= 0;
      end
      else
      begin
         filt_data           <= mon_data; 

         if (mon_data_valid & enable & ~filt_bp)
         begin
           if((mon_data & match_mask) == (match_data & match_mask))
           begin
             filt_data_valid <= 1'b1;
           end
           else
           begin
             filt_data_valid <= 1'b0;
           end
         end
         else
         begin
             filt_data_valid <= 1'b0;
         end
       end
    end
  end
  else
  begin  //USE_FLOP = 0
    always_comb
    begin
      filt_data           = mon_data; 

      if (mon_data_valid & enable & ~filt_bp)
      begin
        if((mon_data & match_mask) == (match_data & match_mask))
        begin
          filt_data_valid = 1'b1;
        end
        else
        begin
          filt_data_valid = 1'b0;
        end
      end
      else
      begin
        filt_data_valid = 1'b0;
      end
    end
  end
endgenerate


endmodule
