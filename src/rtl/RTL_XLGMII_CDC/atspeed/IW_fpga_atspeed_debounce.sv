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

module IW_fpga_atspeed_debounce #(
   parameter WIDTH                   = 32
  ,parameter NUM_STAGE               = 4
) (
   input  logic                                  i_clock
  ,input  logic     [WIDTH-1:0]                  i_data_in
  ,output logic     [WIDTH-1:0]                  o_data_out
  ,output logic                                  o_valid_pulse
  ,output logic                                  o_valid
);

  logic [NUM_STAGE-1 + 3:0] [WIDTH-1:0] sync_pipe_r;
  logic [NUM_STAGE-1:0]     [WIDTH-1:0] sync_pipe;
  logic [NUM_STAGE-1:0]     [WIDTH-1:0] bit_comp;
  logic                     [WIDTH-1:0] flags_compare;
  logic                     [WIDTH-1:0] flags_compare_r;
  logic                                 compare_flag;

genvar itr;
// Input data is registered to create pipeline
// registers, that act as historic data memory
for (itr=0; itr<NUM_STAGE+3; itr++) begin :gen_sync_pipe_r
  always_ff @(posedge i_clock) begin
    if (itr == 0)
      sync_pipe_r[itr] <= i_data_in;
    else
      sync_pipe_r[itr] <= sync_pipe_r[itr-1];
   end
end //gen_sync_pipe_r

// combinational version of the pipeline to enable
// circuit with better timing closure
for (itr=0; itr<NUM_STAGE; itr++) begin :gen_sync_pipe 
  always @(*) begin
    if (itr == 0)
      sync_pipe[itr] <= i_data_in;
    else
      sync_pipe[itr] <= sync_pipe_r[itr-1];
   end
end //gen_sync_pipe

//    Adjacent bit Comparision block
//    Note that whole of data is compared with data received
//    on previous i_clock. EXNOR operator is used
for(itr=0;  itr<NUM_STAGE; itr++) begin : bit_compare
  always @(posedge i_clock) begin
    if(itr==0)
      bit_comp[itr] <= sync_pipe[itr] ~^ sync_pipe[itr];
    else
      bit_comp[itr] <= sync_pipe[itr] ~^ sync_pipe[itr-1];
  end 
end //bit_compare

//  Set of flags generated that correspond to data being
//  same across the samples. 1 indicates, no change in the 
//  corresponding bit position across the data
//  Further, all the data flags are ANDed across the data width
always_comb begin
  flags_compare = '{default: 1'b1};
  for(int idx=0;  idx <NUM_STAGE; idx++) begin : flags_compare_proc
  	  flags_compare = bit_comp[idx] & flags_compare;
  end //flags_compare_proc
end

always_ff @(posedge i_clock) flags_compare_r <= flags_compare;
always_ff @(posedge i_clock) compare_flag <= &flags_compare_r;

// debounced data flag and data. A pulse indicates
// same data observed for NUM_STAGES & there is a change
always@(posedge i_clock) begin
  if(sync_pipe_r[2] != sync_pipe_r[NUM_STAGE+2] && compare_flag == 1'b1)
    o_valid_pulse <= 1'b1;
  else
    o_valid_pulse <= 1'b0;
end

always @(posedge i_clock) o_valid <= compare_flag;

assign  o_data_out = sync_pipe_r[NUM_STAGE+2];

endmodule
