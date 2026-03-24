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
 -- Module Name       : generic_dd_sync
 -- Author            : Gregory James
 -- Associated modules: 
 -- Function          : A parameterizable D-Flop based synchronizer
 --------------------------------------------------------------------------
*/

`timescale 1ns / 10ps


module generic_dd_sync #(
//----------------------- Global parameters Declarations ------------------
   parameter  WIDTH       = 1
  ,parameter  NUM_STAGES  = 2
  ,parameter  USE_RESET   = 0
  ,parameter  RESET_VAL   = 1'h0

) (

   input  logic             clk
  ,input  logic             rst_n   //Used only when USE_RESET==1
  ,input  logic [WIDTH-1:0] in
  ,output logic [WIDTH-1:0] out

);

//----------------------- Import Packages ---------------------------------


//----------------------- Internal Parameters -----------------------------


//----------------------- Internal Register Declarations ------------------
  integer i;

  logic [NUM_STAGES-1:0][WIDTH-1:0]  sync_pipe;


//----------------------- Internal Wire Declarations ----------------------


//----------------------- Start of Code -----------------------------------

  generate
    if(USE_RESET)
    begin
      always@(posedge clk,  negedge rst_n)
      begin
        if(~rst_n)
        begin
          for(i=0;i<NUM_STAGES;i++)
          begin
            sync_pipe[i]  <=  RESET_VAL;
          end
        end
        else
        begin
          sync_pipe[0]    <=  in;

          for(i=1;i<NUM_STAGES;i++)
          begin
            sync_pipe[i]  <=  sync_pipe[i-1];
          end
        end
      end
    end
    else  //USE_RESET==0
    begin
      always@(posedge clk)
      begin
        sync_pipe[0]    <=  in;

        for(i=1;i<NUM_STAGES;i++)
        begin
          sync_pipe[i]  <=  sync_pipe[i-1];
        end
      end
    end
  endgenerate

  assign  out  = sync_pipe[NUM_STAGES-1];

endmodule // generic_dd_sync
