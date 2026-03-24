//-----------------------------------------------------------------------------------------------------
//                              Copyright (c) LSI CORPORATION, 2007.
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
// File Name:     IW_sticky_bit.sv
// File Revision: $Revision: 1.4 $
// Created by:    Steve Pollock
// Updated by:    $Author: spollock $ $Date: Fri Mar 22 16:27:04 2013 $
//-----------------------------------------------------------------------------------------------------
// IW_sticky_bit
//
// This module is responsible for implementing "sticky" bits by capturing signals once they set and
// then keeping those bits set until cleared by a write operation with the wdata value set to '1' in
// the bit positin to be cleared.
// The primary use is for remembering error conditions or interrupts that have occurred.
// The diag input puts the register into a normal R/W mode for testing.
//
// The following parameters are supported:
//
//	WIDTH		Width of the datapath that is registered
//
//-----------------------------------------------------------------------------------------------------

`timescale 1ns/1ps

module IW_sticky_bit #(

	parameter	WIDTH=1
) (
	input	wire			clk,
	input	wire			rst_n,

	input	wire			diag,

	input	wire	[WIDTH-1:0]	d,
	
	input	wire			write,
	input	wire	[WIDTH-1:0]	wdata,

	output	wire	[WIDTH-1:0]	q
);

`ifdef ASSERT_ON

// synopsys translate_off
initial begin

 check_width_param:
 assert (WIDTH>0) else begin
`ifdef SV_ASSERTION_ERROR_MACRO
  `SV_ASSERTION_ERROR_MACRO("AW", 
                            "sticky_bit_check_width_param", 
                            $psprintf("\nERROR: %m: Parameter WIDTH had an illegal value (%d).  Valid values are (>0) !!!\n",WIDTH) 
                           )
`else
  $display ("\nERROR: %m: Parameter WIDTH had an illegal value (%d).  Valid values are (>0) !!!\n",WIDTH);
  if (!$test$plusargs("IW_CONTINUE_ON_ERROR")) $stop;
`endif
 end

end
// synopsys translate_on

`endif

// diag	write	wdata[n] q_q[n]	d[n]	q_q_next[n]
//
//   x	  0	   x	   0	 0	    0		Functional Mode: No Action
//   x	  0	   x	   0	 1	    1		Functional Mode: Latch Current Error
//   x	  0	   x	   1	 x	    1		Functional Mode: Remember Previous Error
//
//   0	  1	   0	   0	 0	    0		Functional Mode: No Action
//   0	  1	   0	   0	 1	    1		Functional Mode: Latch Current Error
//   0	  1	   0	   1	 x	    1		Functional Mode: Remember Previous Error
//   0	  1	   1	   x	 x	    0		Functional Mode: Clear on Write With 1
//
//   1	  1	   0	   x	 x	    0		Diagnostic Mode: Write 0
//   1	  1	   1	   x	 x	    1		Diagnostic Mode: Write 1

reg	[WIDTH-1:0]	q_q;

always @(posedge clk or negedge rst_n) begin
 if (~rst_n) begin
  q_q <= {WIDTH{1'b0}};
 end else begin
  q_q <= (write) ? ((diag) ? wdata : (~wdata & (q_q | d))) : (q_q | d);
 end
end

assign q = q_q;

endmodule // IW_sticky_bit

//-----------------------------------------------------------------------------------------------------
// Change History:
//
// $Log: IW_sticky_bit.sv.rca $
// 
//  Revision: 1.4 Fri Mar 22 16:27:04 2013 spollock
//  Moved change log to the end of the file. -sjp
// 
//  Revision: 1.3 Tue Jan 22 18:04:08 2013 mpp
//  Initial axxia version. -sjp
// 
//  Revision: 1.2.13.3 Mon Mar  7 14:10:31 2011 mrb
//  *** empty comment string ***
// 
//  Revision: 1.2 Wed Feb 27 12:30:26 2008 mpp
//  Updated to ensure a bit clears for at least one cycle. -sjp
// 
//  Revision: 1.1 Fri Feb 15 17:13:38 2008 mpp
//  Initial version for Nuevo. -sjp
//
//-----------------------------------------------------------------------------------------------------
