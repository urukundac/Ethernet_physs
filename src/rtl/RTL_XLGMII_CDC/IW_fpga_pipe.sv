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
// File Revision: $Revision: 1.5.2.4 $
// Created by:    Balaji
// Updated by:    $Author:$ $Date:$
//-----------------------------------------------------------------------------------------------------
// IW_fpga_pipe
//
// This module is responsible for pipelining a signal through a Dff.
//
// The following parameters are supported:
//
//	WIDTH		Width of the datapath that is synchronized
//	NUM_STAGES	The number of flipflop stages in the synchronizer (0-N)
//
//-----------------------------------------------------------------------------------------------------

`timescale 1ns/1ps

module IW_fpga_pipe #(
	parameter	WIDTH          = 1,
	parameter	NUM_STAGES     = 1
) (
	input	wire			    clk,
	input	wire	[WIDTH-1:0]	data,

	output	wire	[WIDTH-1:0]	data_sync
);

//-----------------------------------------------------------------------------------------------------

//-----------------------------------------------------------------------------------------------------

if (NUM_STAGES == 1) begin:gen_stage1
reg	[(NUM_STAGES*WIDTH)-1:0]	sync_q;
  always @(posedge clk) begin
   sync_q <=  data;
  end

  assign data_sync = sync_q;
end
else if (NUM_STAGES > 1) begin:gen_stageN
reg	[(NUM_STAGES*WIDTH)-1:0]	sync_q;
  always @(posedge clk) begin
    sync_q[(NUM_STAGES*WIDTH)-1:0] <= {sync_q[((NUM_STAGES*WIDTH)-1)-WIDTH:0],data};
  end

  assign data_sync = sync_q[(NUM_STAGES*WIDTH)-1:(NUM_STAGES-1)*WIDTH];

end else begin:gen_nostage
  assign data_sync = data ;
end

endmodule // IW_fpga_pipe

//-----------------------------------------------------------------------------------------------------
// Change History:
//
// $Log:$
// 
//-----------------------------------------------------------------------------------------------------
