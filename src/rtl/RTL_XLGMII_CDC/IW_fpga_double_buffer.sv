//-----------------------------------------------------------------------------------------------------
//                              Copyright (c) LSI CORPORATION, 2010.
//                                      All rights reserved.
//
// This software and documentation constitute an unpublished work and contain valuable trade secrets
// and proprietary information belonging to LSI CORPORATION ("LSI").  None of the foregoing material
// may be copied, duplicated or disclosed without the express written permission of LSI.
//
// The use of this software, documentation, methodologies and other information associated herewith,
// is governed exclusively by the associated license agreement(s).  Any use, modification or
// publication inconsistent with such license agreement(s) is an infringement of the copyright in
// this material and a misappropriation of the intellectual property of LSI.
//
// LSI EXPRESSLY DISCLAIMS ANY AND ALL WARRANTIES CONCERNING THIS SOFTWARE AND DOCUMENTATION, INCLUDING
// ANY WARRANTIES OF MERCHANTABILITY AND/OR FITNESS FOR ANY PARTICULAR PURPOSE, AND WARRANTIES OF
// PERFORMANCE, AND ANY WARRANTY THAT MIGHT OTHERWISE ARISE FROM COURSE OF DEALING OR USAGE OF TRADE,
// NO WARRANTY IS EITHER EXPRESS OR IMPLIED WITH RESPECT TO THE USE OF THE SOFTWARE OR DOCUMENTATION.
//
// Under no circumstances shall LSI be liable for incidental, special, indirect, direct or consequential
// damages or loss of profits, interruption of business, or related expenses which may arise from use of
// this software or documentation, including but not limited to those resulting from defects in software
// and/or documentation, or loss or inaccuracy of data of any kind.
//-----------------------------------------------------------------------------------------------------
// Version and Release Control Information:
//
// File Name:     $RCSFile$
// File Revision: $Revision: 1.4.1.1.1.7 $
// Created by:    Steve Pollock
// Updated by:    $Author: mrb $ $Date: Mon Jun 29 11:26:53 2015 $
//-----------------------------------------------------------------------------------------------------
// IW_fpga_double_buffer
//
// This module implements a double buffer to decouple input/output timing.
//
// The 7-bit status output provides the following registered information:
//
// [6] Input stalled   (in_valid &  ~in_ready) : Can be used as countable input  stall    event
// [5] Input taken     (in_valid &   in_ready) : Can be used as countable input  accepted event
// [4] Output stalled (out_valid & ~out_ready) : Can be used as countable output stall    event
// [3] Output taken   (out_valid &  out_ready) : Can be used as countable output accepted event
// [2] Registered value of out_ready  : Useful as read-only backpressure status
// [1:0] Current depth value   : Useful as read-only depth status
//
// It is recommended that bits [6:3] are hooked to an SMON so they can be counted and that bits [2:0]
// are available as read-only configuration status.
//
// An inline covergroup is included to provide comprehensive code coverage information if the design
// is compile with coverage enabled.
//
//-----------------------------------------------------------------------------------------------------

`timescale 1ns/1ps

module IW_fpga_double_buffer #(

  parameter WIDTH = 32

) (

 input   clk,
 input   rst_n,

 output [6:0]  status,

 //------------------------------------------------------------------------------------------
 // Input side

 output   in_ready,

 input   in_valid,
 input [WIDTH-1:0] in_data,

 //------------------------------------------------------------------------------------------
 // Output side

 input   out_ready,

 output   out_valid,
 output [WIDTH-1:0] out_data
  
);

// Put at most 8 loads on any output mux select.

localparam RP_WIDTH = ((WIDTH+7)>>3);

//--------------------------------------------------------------------------------------------------

wire   in_taken;
wire   in_stall;
wire   out_taken;
wire   out_stall;
reg [1:0]  depth_next;
reg [1:0]  depth_q;
wire [4:0]  status_next;
reg [4:0]  status_q;
reg   wp_q;
reg [RP_WIDTH-1:0] rp_q;
reg [WIDTH-1:0] data_q[1:0];

genvar   g;

//--------------------------------------------------------------------------------------------------

assign in_ready = ~depth_q[1];

assign in_taken = in_valid & in_ready;
assign in_stall = in_valid &  ~in_ready;

assign out_taken = (|depth_q) &  out_ready;
assign out_stall = (|depth_q) & ~out_ready;

assign status_next = {in_stall, in_taken, out_stall, out_taken, out_ready};

always @(*) begin
 case ({in_taken, out_taken})
  2'b10:   depth_next = depth_q + 1'b1;
  2'b01:   depth_next = depth_q - 1'b1;
  default: depth_next = depth_q;
 endcase
end

always @(posedge clk or negedge rst_n) begin
 if (~rst_n) begin
  status_q <= 5'd0;
  depth_q  <= 2'd0;
  wp_q     <= 1'b0;
  rp_q     <= {RP_WIDTH{1'b0}};
 end else begin
  status_q <= status_next;
  depth_q  <= depth_next;
  if (in_taken)  wp_q <= ~wp_q;
  if (out_taken) rp_q <= ~rp_q;
 end
end

always @(posedge clk) if (in_taken) data_q[wp_q] <= in_data;

assign status    = {status_q, depth_q};

assign out_valid = |depth_q;

generate
 for (g=0; g<WIDTH; g=g+1) begin: g_bit

  assign out_data[g] = data_q[rp_q[g>>3]][g -: 1];

 end
endgenerate

endmodule // IW_fpga_double_buffer
