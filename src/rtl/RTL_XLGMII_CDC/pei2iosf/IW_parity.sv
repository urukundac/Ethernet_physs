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
// File Name:     IW_parity.sv
// File Revision: $Revision: 1.4 $
// Created by:    Steve Pollock
// Updated by:    $Author: spollock $ $Date: Fri Mar 22 16:27:03 2013 $
//-----------------------------------------------------------------------------------------------------
// IW_parity
//
// This module is responsible for generating a parity bit.
// If the ODD input is asserted, odd parity is generated, other even parity is generated.
//
// The following parameters are supported:
//
//	WIDTH		Width of the datapath on which to generate parity.
//
//-----------------------------------------------------------------------------------------------------

`timescale 1ns/1ps

module IW_parity #(

	parameter	WIDTH=1
) (
	input	wire	[WIDTH-1:0]	D,
	input	wire			ODD,

	output	wire			P
);

`ifdef ASSERT_ON

// synopsys translate_off
initial begin

 check_width_param:
 assert (WIDTH>0) else begin
`ifdef SV_ASSERTION_ERROR_MACRO
  `SV_ASSERTION_ERROR_MACRO("AW", 
                            "parity_check_width_param", 
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

// Go through some contortions to handle Xs in the input data gracefully (for simulation only!)
// if the +NO_PAR_X_CORRECT plusarg is not specified.

reg	[WIDTH-1:0]	d_in;
wire			d_sel;

// synopsys translate_off

reg	[WIDTH-1:0]	d_x;

initial begin: i_d_x
 integer i;
 for (i=0; i<WIDTH; i=i+1) begin
`ifdef ASSERT_ON
  d_x[i] = ($isunknown(D[i])) ? i[0] : D[i];
`else
  d_x[i] = D[i];
`endif
 end
end

always @(*) begin: u_d_x
 integer i;
 for (i=0; i<WIDTH; i=i+1) begin
`ifdef ASSERT_ON
  d_x[i] = ($isunknown(D[i])) ? i[0] : D[i];
`else
  d_x[i] = D[i];
`endif
 end
end

// synopsys translate_on

assign d_sel = 1'b1
// synopsys translate_off
        & ~$test$plusargs("NO_PAR_X_CORRECT")	// spyglass disable SYNTH_5285 -- Not synthesizable
// synopsys translate_on
;

always @(*) begin
 case (d_sel)
// synopsys translate_off
  1'b1:    d_in = d_x;
// synopsys translate_on
  default: d_in = D;
 endcase
end

assign P = ^{ODD,d_in};

endmodule // IW_parity

//-----------------------------------------------------------------------------------------------------
// Change History:
//
// $Log: IW_parity.sv.rca $
// 
//  Revision: 1.4 Fri Mar 22 16:27:03 2013 spollock
//  Moved change log to the end of the file. -sjp
// 
//  Revision: 1.3 Tue Jan 22 18:04:13 2013 mpp
//  Initial axxia version. -sjp
// 
//  Revision: 1.2.7.3.1.1 Tue Feb  7 08:06:26 2012 spollock
//  Conditioned $isunknown on ASSERT_ON. -sjp
// 
//  Revision: 1.2.7.3 Mon Mar  7 14:10:29 2011 mrb
//  *** empty comment string ***
// 
//  Revision: 1.2 Mon Aug 10 11:39:14 2009 spollock
//  Added code to gracefully handle Xs in the input data. -sjp
// 
//  Revision: 1.1 Fri Feb 15 17:13:38 2008 mpp
//  Initial version for Nuevo. -sjp
//
//-----------------------------------------------------------------------------------------------------
