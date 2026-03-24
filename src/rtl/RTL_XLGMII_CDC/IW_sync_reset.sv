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
// File Name:     $RCSFile$
// File Revision: $Revision: 1.9 $
// Created by:    Steve Pollock
// Updated by:    $Author: spollock $ $Date: Mon Jan 19 10:06:05 2015 $
//-----------------------------------------------------------------------------------------------------
// IW_sync_reset
//
// This module is responsible for synchronizing the reset to the current clock domain.
// The reset output of this block is asynchronously asserted, but synchronously deasserted.
// It provides a scan_mode input to bypass the input reset to the output during scan.
//
// The following parameters are supported:
//
//	NUM_STAGES	The number of flipflop stages in the synchronizer (2-4)
//	STRENGTH	The drive strength of the gates instantiated (5=X0P5, 10=X1, 20=X2, etc.)
//      THRESH          The threshold type of the gates (R=rvt, H=hvt, S=svt, U=uvt, etc.)
//
//-----------------------------------------------------------------------------------------------------

`timescale 1ns/1ps

module IW_sync_reset #(

	parameter	NUM_STAGES=2,

	// spyglass disable_block W175 -- Disable lint warnings for unused parameters

	parameter	STRENGTH=40,
	parameter	CHWIDTH=16,
	parameter	THRESH="H"
) (
	input	wire	clk,
	input	wire	scan_mode,	// spyglass disable W240 -- Currently unused
	input	wire	rst_n,

	output	wire	rst_n_sync
);

//-----------------------------------------------------------------------------------------------------

`ifdef ASSERT_ON

// synopsys translate_off
initial begin

 check_num_stages_param:
 assert ((NUM_STAGES>=2) && (NUM_STAGES<=4)) else begin
  $display ("\nERROR: %m: Parameter NUM_STAGES had an illegal value (%d).  Valid values are (2-4) !!!\n",NUM_STAGES);
  if (!$test$plusargs("IW_CONTINUE_ON_ERROR")) $stop;
 end

end
// synopsys translate_on

`endif

//-----------------------------------------------------------------------------------------------------

reg     [1:0]     sync_q;

always @(posedge clk or negedge rst_n) begin
 if (!rst_n) begin
  sync_q <= {2{1'b0}};
 end else begin
  sync_q <= {sync_q[0], 1'b1};
 end
end

assign rst_n_sync = sync_q[1];

endmodule // IW_sync_reset

//-----------------------------------------------------------------------------------------------------
// Change History:
//
// $Log: IW_sync_reset.sv.rca $
// 
//  Revision: 1.9 Mon Jan 19 10:06:05 2015 spollock
//  Fixed these at 2 stages for 16FF and beyond. -sjp
// 
//  Revision: 1.8 Wed Dec 10 16:48:28 2014 spollock
//  Added dummy CHWIDTH params to support CPU clock tree balancing along with FPGA synthesis. -sjp
// 
//  Revision: 1.7 Fri Mar 22 16:27:05 2013 spollock
//  Moved change log to the end of the file. -sjp
// 
//  Revision: 1.6 Tue Jan 22 18:04:06 2013 mpp
//  Initial axxia version. -sjp
// 
//  Revision: 1.5.7.7 Tue Jun 21 14:49:31 2011 spollock
//  Added support for 3 and 4 stage synchronizers with NUM_STAGES param. -sjp
// 
//  Revision: 1.5.7.6 Mon Mar  7 14:10:31 2011 mrb
//  *** empty comment string ***
// 
//  Revision: 1.5.7.3 Thu Sep 23 11:24:03 2010 mpp
//  Updated params. -sjp
// 
//  Revision: 1.5.7.2 Mon Aug 30 17:26:35 2010 mpp
//  Changed THRESH params to character based format.
//  Added CHWIDTH and DENSITY parameters. -sjp
// 
//  Revision: 1.5.7.1 Thu Aug 19 10:20:54 2010 mpp
//  Cleaned up STRENGTH/THRESH comments and defaults. -sjp
// 
//  Revision: 1.5 Tue Aug 11 11:19:01 2009 spollock
//  Changed sync0/1 names to sync1/2 names for formality. -sjp
// 
//  Revision: 1.4 Wed Sep 17 16:03:37 2008 spollock
//  Added lint pragma. -sjp
// 
//  Revision: 1.3 Wed Sep 17 15:56:06 2008 spollock
//  Removed scan_mode mux functionality but left scan_mode input. -sjp
// 
//  Revision: 1.2 Thu Sep 11 11:40:33 2008 spollock
//  Added lint pragma for blocks that use both clock edges. -sjp
// 
//  Revision: 1.1 Fri Feb 15 17:13:38 2008 mpp
//  Initial version for Nuevo. -sjp
//
//-----------------------------------------------------------------------------------------------------
