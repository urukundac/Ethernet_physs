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
// File Name:     IW_gray2bin.sv
// File Revision: $Revision: 1.4 $
// Created by:    Steve Pollock
// Updated by:    $Author: spollock $ $Date: Fri Mar 22 16:27:02 2013 $
//-----------------------------------------------------------------------------------------------------
// IW_gray2bin
//
// This module is responsible for converting a gray code value to a binary value.
//
// The following parameters are supported:
//
//	WIDTH		Width of the value to be converted.
//
//-----------------------------------------------------------------------------------------------------

`timescale 1ns/1ps

module IW_gray2bin #(

	parameter	WIDTH=2
) (
	input	wire	[WIDTH-1:0]	gray,

	output	wire	[WIDTH-1:0]	binary
);

`ifdef ASSERT_ON

// synopsys translate_off
initial begin

 check_width_param:
 assert (WIDTH>1) else begin
`ifdef SV_ASSERTION_ERROR_MACRO
  `SV_ASSERTION_ERROR_MACRO("AW", 
                            "gray2bin_check_width_param", 
                            $psprintf("\nERROR: %m: Parameter WIDTH had an illegal value (%d).  Valid values are (>1) !!!\n",WIDTH) 
                           )
`else
  $display ("\nERROR: %m: Parameter WIDTH had an illegal value (%d).  Valid values are (>1) !!!\n",WIDTH);
  if (!$test$plusargs("IW_CONTINUE_ON_ERROR")) $stop;
`endif
 end

end
// synopsys translate_on

`endif

reg	[WIDTH-1:0]	binary_int;

integer			i;

// spyglass disable_block W116 -- Because spyglass is braindead

always @(*) for (i=0;i<WIDTH;i=i+1) binary_int[i] = ^(gray[WIDTH-1:0] & ({WIDTH{1'b1}} << i));

// spyglass  enable_block W116

assign binary = binary_int;

endmodule // IW_gray2bin

//-----------------------------------------------------------------------------------------------------
// Change History:
//
// $Log: IW_gray2bin.sv.rca $
// 
//  Revision: 1.4 Fri Mar 22 16:27:02 2013 spollock
//  Moved change log to the end of the file. -sjp
// 
//  Revision: 1.3 Tue Jan 22 18:04:08 2013 mpp
//  Initial axxia version. -sjp
// 
//  Revision: 1.2.13.3 Mon Mar  7 14:10:27 2011 mrb
//  *** empty comment string ***
// 
//  Revision: 1.2 Wed Oct  8 13:36:54 2008 spollock
//  Just changed lint pragma. -sjp
// 
//  Revision: 1.1 Fri Feb 15 17:13:37 2008 mpp
//  Initial version for Nuevo. -sjp
//
//-----------------------------------------------------------------------------------------------------
