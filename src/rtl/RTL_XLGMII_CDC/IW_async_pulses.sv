//-----------------------------------------------------------------------------------------------------
//                              Copyright (c) LSI CORPORATION, 2009.
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
// File Name:     IW_async_pulses.sv
// File Revision: $Revision: 1.5 $
// Created by:    Steve Pollock
// Updated by:    $Author: spollock $ $Date: Fri Mar 22 16:26:59 2013 $
//-----------------------------------------------------------------------------------------------------
// IW_async_pulses
//
// This module is responsible for ensuring that a series of pulses is seen across a clock domain crossing.
// It is limited in the number of pulses it will handle based on the clock ratio and the width of the
// counter that counts the number of input pulses.
//
//-----------------------------------------------------------------------------------------------------

`timescale 1ns/1ps

module IW_async_pulses #(

	parameter WIDTH = 2
) (
	input	wire	clk_src,
	input	wire	rst_src_n,
	input	wire	data,

	input	wire	clk_dst,
	input	wire	rst_dst_n,
	output	wire	data_sync
);

//-----------------------------------------------------------------------------------------------------

wire			rst_n;
wire			rst_src_int_n;
wire			rst_dst_int_n;
wire			rst_src_cnt_n;
wire			rst_dst_cnt_n;
wire	[WIDTH-1:0]	bin_cnt;
wire	[WIDTH-1:0]	bin_cnt_next;
wire	[WIDTH-1:0]	gray_cnt_next;
reg	[WIDTH-1:0]	gray_cnt_q;
wire	[WIDTH-1:0]	gray_cnt_sync_q;
wire	[WIDTH-1:0]	rcv_cnt;
wire	[WIDTH-1:0]	sent_cnt_next;
reg	[WIDTH-1:0]	sent_cnt_q;
wire			cnt_ne;

//-----------------------------------------------------------------------------------------------------
// Flop and hold source.  Reset only after seen by the destination.

IW_gray2bin #(.WIDTH(WIDTH)) u_bin_cnt (.gray(gray_cnt_q), .binary(bin_cnt));

assign bin_cnt_next = bin_cnt + data;		// spyglass disable W164a W484 -- Don't need carry

IW_bin2gray #(.WIDTH(WIDTH)) u_gray_cnt_next (.binary(bin_cnt_next), .gray(gray_cnt_next));

assign rst_n = rst_src_n | rst_dst_n;

//IW_sync_reset u_rst_src_int_n (
//
//	.clk		(clk_src),
//	.rst_n		(rst_n),
//	.scan_mode	(1'b0),
//
//	.rst_n_sync	(rst_src_int_n)
//);
      IW_fpga_double_sync #(.WIDTH(1),.NUM_STAGES(2)) u_rst_src_int_n  (
         .clk           (clk_src)
        ,.sig_in        (rst_n)
        ,.sig_out       (rst_src_int_n)
      );


assign rst_src_cnt_n = rst_src_n | rst_src_int_n;

always @(posedge clk_src or negedge rst_src_cnt_n) begin
 if (~rst_src_cnt_n) begin
  gray_cnt_q <= {WIDTH{1'b0}};
 end else begin
  gray_cnt_q <= gray_cnt_next;
 end
end

// Sync source to destination

// to fix removal viol
//IW_sync_reset u_rst_dst_int_n (
//
//	.clk		(clk_dst),
//	.rst_n		(rst_n),
//	.scan_mode	(1'b0),
//
//	.rst_n_sync	(rst_dst_int_n)
//);
      IW_fpga_double_sync #(.WIDTH(1),.NUM_STAGES(2)) u_rst_dst_int_n  (
         .clk           (clk_dst)
        ,.sig_in        (rst_n)
        ,.sig_out       (rst_dst_int_n)
      );


assign rst_dst_cnt_n = rst_dst_n | rst_dst_int_n;

IW_sync_posedge #(.WIDTH(WIDTH)) u_gray_cnt_sync_q (
	.clk		(clk_dst),
	.rst_n		(rst_dst_cnt_n),
	.data		(gray_cnt_q),
	.data_sync	(gray_cnt_sync_q)
);

// Generate single pulse in destination domain

IW_gray2bin #(.WIDTH(WIDTH)) u_rcv_cnt (.gray(gray_cnt_sync_q), .binary(rcv_cnt));

assign sent_cnt_next = sent_cnt_q + cnt_ne;	// spyglass disable W164a W484 -- Don't need carry

always @(posedge clk_dst or negedge rst_dst_cnt_n) begin
 if (~rst_dst_cnt_n) begin
  sent_cnt_q <= {WIDTH{1'b0}};
 end else begin
  sent_cnt_q <= sent_cnt_next;
 end
end

assign cnt_ne = (sent_cnt_q != rcv_cnt);

assign data_sync = cnt_ne;

// synopsys translate_off

`ifdef ASSERT_ON

 int	sendcnt;
 int	rcvcnt;
 int	rcvcnt_s1;
 int	rcvcnt_s2;

 always @(negedge clk_src or negedge rst_src_cnt_n or negedge rst_dst_cnt_n) begin
  if (~rst_src_cnt_n | ~rst_dst_cnt_n) begin
   rcvcnt <= 0;
  end else begin
   rcvcnt <= rcvcnt + data;
  end
 end

 always @(negedge clk_dst or negedge rst_dst_cnt_n or negedge rst_src_cnt_n) begin
  if (~rst_dst_cnt_n | ~rst_src_cnt_n) begin
   sendcnt <= 0;
   rcvcnt_s1 <= 0;
   rcvcnt_s2 <= 0;
  end else begin
   sendcnt <= sendcnt + cnt_ne;
   rcvcnt_s1 <= rcvcnt;
   rcvcnt_s2 <= rcvcnt_s1;
  end
 end

 check_overflow: assert property
 (@(posedge clk_dst) disable iff ((rst_dst_cnt_n !== 1'b1) || (rst_src_cnt_n !== 1'b1)) !((rcvcnt_s2-sendcnt)>((1<<WIDTH)-1))) else begin
`ifdef SV_ASSERTION_ERROR_MACRO
  `SV_ASSERTION_ERROR_MACRO("AW", 
                            "async_pulses_check_overflow", 
                            $psprintf("\nERROR: %t: %m: Received more data pulses than the WIDTH=%0d wide counter can handle !!!\n",$time,WIDTH) 
                           )
`else
  $display ("\nERROR: %t: %m: Received more data pulses than the WIDTH=%0d wide counter can handle !!!\n",$time,WIDTH);
  if (!$test$plusargs("IW_CONTINUE_ON_ERROR")) $stop;
`endif
 end

`endif

// synopsys translate_on

endmodule // IW_async_pulses

//-----------------------------------------------------------------------------------------------------
// Change History:
//
// $Log: IW_async_pulses.sv.rca $
// 
//  Revision: 1.5 Fri Mar 22 16:26:59 2013 spollock
//  Moved change log to the end of the file. -sjp
// 
//  Revision: 1.4 Tue Jan 22 18:04:08 2013 mpp
//  Initial axxia version. -sjp
// 
//  Revision: 1.2.7.1.4.4.1.2 Wed Aug  8 13:16:39 2012 spollock
//  Replaced IW_sync with IW_sync_reset to provide async reset regardless of clk state. -sjp
// 
//  Revision: 1.2.7.1.4.4.1.1 Tue Jul  3 16:05:23 2012 spollock
//  Updated to handle individual reset assertion. -sjp
// 
//  Revision: 1.2.7.1.4.4 Mon Mar  7 14:10:22 2011 mrb
//  *** empty comment string ***
// 
//  Revision: 1.2.7.1.4.1 Wed Sep 29 17:09:33 2010 mpp
//  Changed assertion iff (!rst_n) to iff (rst_n !== 1'b1). -sjp
// 
//  Revision: 1.2.7.1 Mon Feb 22 10:37:41 2010 mpp
//  Overlayed latest changes. -sjp
// 
//  Revision: 1.3 Mon Feb 22 10:36:30 2010 spollock
//  Updated sim-only assertion code. -sjp
// 
//  Revision: 1.2 Thu Apr 30 16:53:02 2009 spollock
//  Added assertion to detect overflow condition. -sjp
// 
//  Revision: 1.1 Thu Apr 30 12:23:29 2009 spollock
//  Initial version. -sjp
// 
//-----------------------------------------------------------------------------------------------------
