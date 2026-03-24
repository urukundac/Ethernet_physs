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
// Created by:    Balaji G
// Updated by:    $Author: mrb $ $Date: Mon Jun 29 11:26:53 2015 $
//-----------------------------------------------------------------------------------------------------
// IW_fpga_double_buffer_ram
//
// This module implements a 1w fifo with registered output for timing. Same interface timing as double buffer
// but more space to store and registered output of design. 
// also implement the read/valid protocol with internal shadow reg to meet the valid/ready timing in 1 clock 
//
//-----------------------------------------------------------------------------------------------------

`timescale 1ns/1ps

module IW_fpga_double_buffer_1w #(

  parameter WIDTH = 32

) (

 input   clk,
 input   rst_n,


 //------------------------------------------------------------------------------------------
 // Input side

 output   in_ready,

 input   in_valid,
 input [WIDTH-1:0] in_data,

 //------------------------------------------------------------------------------------------
 // Output side

 input   out_ready,

 output logic   out_valid,
 output logic [WIDTH-1:0] out_data
  
);

//--------------------------------------------------------------------------------------------------

 logic                       wr;
 logic                       rd;

 logic [WIDTH-1:0]           buf_1w;
 logic [WIDTH-1:0]           buf_1w_shw;
 logic                       fulln_buf;
 logic                       fulln_shw;
 

//--------------------------------------------------------------------------------------------------
 assign wr = in_valid & in_ready;
 assign rd = out_valid & out_ready;
 assign in_ready = fulln_shw;
 assign out_data = buf_1w;

 always @(posedge clk or negedge rst_n) begin
   if ( ~rst_n ) begin
     buf_1w      <= {WIDTH{1'b0}};
     buf_1w_shw  <= {WIDTH{1'b0}};
     fulln_shw   <= 1'b1;
     fulln_buf   <= 1'b1;
     out_valid   <= 1'b0;
   end
   else begin
     // Write from input when buf is fulln (that means shadow is also fulln)
     // Check for sim. read also
     if ( wr  & ( ( rd & out_valid & fulln_shw ) | 
                               ( fulln_buf  ) ) ) begin
       buf_1w     <= in_data;
       fulln_buf  <= 1'b0;
       out_valid  <= 1'b1;
     end

     // Shift from shadow when shadow not fulln during a read
     else if ( rd & out_valid & ~fulln_shw )  begin
       buf_1w     <= buf_1w_shw;
       fulln_buf  <= 1'b0;
       out_valid  <= 1'b1;
     end

     // Clear flags when both shadow and buf fulln
     else if ( rd & out_valid ) begin
       fulln_buf  <= 1'b1;
       out_valid  <= 1'b0;
     end

     // Always write shadow
     if ( wr )  begin
       buf_1w_shw   <= in_data;
       // set flag only when buf is not fulln
       if ( ~fulln_buf & ~( rd & out_valid ) ) begin
         fulln_shw  <= 1'b0;
       end
     end
     // clear shadow when its shifted to buf
     else if (  rd & out_valid ) begin 
       fulln_shw  <= 1'b1;
     end
   end
 end

endmodule // IW_fpga_double_buffer_1w
