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
// File Name:     IW_bin2gray.sv
// File Revision: $Revision: 1.3 $
// Created by:    Steve Pollock
// Updated by:    $Author: spollock $ $Date: Fri Mar 22 16:27:00 2013 $
//-----------------------------------------------------------------------------------------------------
// IW_bin2gray
//
// This module is responsible for converting a binary value to a gray code value.
//
// The following parameters are supported:
//
//	WIDTH		Width of the value to be converted.
//
//-----------------------------------------------------------------------------------------------------

`timescale 1ns/1ps

module IW_bin2gray #(

	parameter	WIDTH=2
) (
	input	wire	[WIDTH-1:0]	binary,

	output	wire	[WIDTH-1:0]	gray
);

`ifdef ASSERT_ON

// synopsys translate_off
initial begin

 check_width_param:
 assert (WIDTH>1) else begin
`ifdef SV_ASSERTION_ERROR_MACRO
  `SV_ASSERTION_ERROR_MACRO("AW", 
                            "bin2gray_check_width_param", 
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

assign gray = {binary[WIDTH-1],(binary[WIDTH-1:1] ^ binary[WIDTH-2:0])};

endmodule // IW_bin2gray

//-----------------------------------------------------------------------------------------------------
// Change History:
//
// $Log: IW_bin2gray.sv.rca $
// 
//  Revision: 1.3 Fri Mar 22 16:27:00 2013 spollock
//  Moved change log to the end of the file. -sjp
// 
//  Revision: 1.2 Tue Jan 22 18:04:09 2013 mpp
//  Initial axxia version. -sjp
// 
//  Revision: 1.1.13.3 Mon Mar  7 14:10:23 2011 mrb
//  *** empty comment string ***
// 
//  Revision: 1.1 Fri Feb 15 17:13:37 2008 mpp
//  Initial version for Nuevo. -sjp
//
//-----------------------------------------------------------------------------------------------------
