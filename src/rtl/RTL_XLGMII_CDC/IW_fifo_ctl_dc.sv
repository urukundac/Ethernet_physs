//----------------------------------------------------------------------------------------------------------------
//                               INTEL CONFIDENTIAL
//           Copyright 2013-2014 Intel Corporation All Rights Reserved. 
// 
// The source code contained or described herein and all documents related to the source code ("Material")
// are owned by Intel Corporation or its suppliers or licensors. Title to the Material remains with Intel
// Corporation or its suppliers and licensors. The Material contains trade secrets and proprietary and confidential
// information of Intel or its suppliers and licensors. The Material is protected by worldwide copyright and trade
// secret laws and treaty provisions. No part of the Material may be used, copied, reproduced, modified, published,
// uploaded, posted, transmitted, distributed, or disclosed in any way without Intel's prior express written
// permission.
// 
// No license under any patent, copyright, trade secret or other intellectual property right is granted to or
// conferred upon you by disclosure or delivery of the Materials, either expressly, by implication, inducement,
// estoppel or otherwise. Any license under such intellectual property rights must be express and approved by
// Intel in writing.
//----------------------------------------------------------------------------------------------------------------
// Version and Release Control Information:
//
// File Name:     IW_fifo_ctl_dc.sv
// File Revision: $Revision: 1.11 $
// Created by:    Steve Pollock
// Updated by:    $Author: jpirog $ $Date: Fri Feb 20 16:26:58 2015 $
//-----------------------------------------------------------------------------------------------------
// IW_fifo_ctl_dc
//
// This is a parametized FIFO controller for a DEPTH deep by DWIDTH wide FIFO memory with separate read
// and write clocks.
//
// The following parameters are supported:
//
//	DEPTH		Depth of the FIFO.
//	DWIDTH		Width of the FIFO datapath.
//	NUM_STAGES_PUSH	Number of synchronizer stages used for clk_push.
//	NUM_STAGES_POP	Number of synchronizer stages used for clk_pop.
//
//	SYNC_POP	Controls what clock is used to sync the fifo_status bits.
//			This should be set to 0 if clk_push is used as the configuration clock that is
//			capturing the fifo_status information, and set to 1 if clk_pop is used.
//
//			The fifo_status[AWIDTH+6:0] output is defined as:
//
//				[DEPTHWIDTH+5:6]:	FIFO depth
//				[5]:			FIFO full         (FIFO depth == DEPTH)
//				[4]:			FIFO almost full  (FIFO depth >= high watermark)
//				[3]:			FIFO almost empty (FIFO depth <= low  watermark)
//				[2]:			FIFO empty        (FIFO depth == 0)
//				[1]:			FIFO overflow     (push while FIFO full)
//				[0]:			FIFO underflow    (pop  while FIFO empty)
//
// It is recommended that the entire set of fifo_status information be accessible through the
// configuration interface as read-only status.  It is required that at least the full, empty,
// overflow, and underflow bits be made available.  The overflow and underflow bits from all
// FIFO controllers must also be "OR"ed together into a single fifo_error sticky interrupt
// status bit to indicate that any FIFO error occurred.
//
//-----------------------------------------------------------------------------------------------------
//
// Push and pop are the basic FIFO operations.
// The memory interface is designed to interface to a dual clock 2-port memory, be it a register
// file (1 write port and 1 read port) or a full 2-port SRAM (2 R/W ports).
// The mem_enable output is provided for memories with a seperate chip enable.
// The FIFO data is valid whenever the fifo_pop_empty signal is not asserted.
// Simultaneous push and pop are not supported on an empty or a full FIFO.
// The current FIFO depth as well as the full or empty status are provided as outputs.
// High and low watermark inputs are provided and the corresponding fifo_push_afull and
// fifo_pop_aempty outputs are set whenever fifo_push_depth >= high or fifo_pop_depth <= low.
// Push while full and pop while empty conditions are flagged by the fifo_overflow and
// fifo_underflow flags that are part of the fifo_status field (bits 1..0).
// A System Verilog checker is instantiated with the ASSERT_ON define to provide automatic
// simulation checking if assertions are enabled.
//
//--------------------------------------------------------------------------------------------
//
// push operation timing
//			      _____       _____       __
// clk_push		_____|     |_____|     |_____|  
//			         ___________
// push			________|           |___________
//			         ___________
// push_data		--------X___________X-----------
//			_________________ ______________
// fifo_push_depth	_________________X______________
//			                  ______________
// fifo_push_full	_________________|
// fifo_push_afull
//
//--------------------------------------------------------------------------------------------
//
// pop operation timing
//			      _____       _____       __
// clk_pop		_____|     |_____|     |_____|     
//			         ___________
// pop 			________|           |______________
//			_________________ _________________
// fifo_data		___valid_data____X___next_data_____
//			_________________ ______________
// fifo_pop_depth	_________________X______________
//			_________________
// fifo_pop_empty	                 |_________________
// fifo_pop_aempty
//
//-----------------------------------------------------------------------------------------------------

`timescale 1ns/1ps


module IW_fifo_ctl_dc #(

	parameter	DEPTH		= 2,
	parameter	DWIDTH		= 2,
	parameter	NUM_STAGES_PUSH	= 2,
	parameter	NUM_STAGES_POP	= 2,
	parameter	SYNC_POP	= 0		// Status synced to clk_push
) (

	clk_push,
	rst_push_n,

	clk_pop,
	rst_pop_n,

	cfg_high_wm,
	cfg_low_wm,

	push,
	push_data,

	pop,
	pop_data,

	mem_enable,

	mem_wr_v,
	mem_wr_addr,
	mem_wr_data,

	mem_rd_v,
	mem_rd_addr,
	mem_rd_data,

	fifo_push_depth,
	fifo_push_full,
	fifo_push_afull,

	fifo_pop_depth,
	fifo_pop_aempty,
	fifo_pop_empty,

	fifo_status

);

`include "IW_logb2.svh"

localparam	AWIDTH = IW_logb2(DEPTH-1)+1;

// spyglass disable_block W116 -- widths are okay
localparam	DEPTHWIDTH = (((2**AWIDTH)==DEPTH) ? (AWIDTH+1) : AWIDTH);
// spyglass enable_block W116

input				clk_push;
input				rst_push_n;

input				clk_pop;
input				rst_pop_n;

input	[DEPTHWIDTH-1:0]	cfg_high_wm;
input	[DEPTHWIDTH-1:0]	cfg_low_wm;

input				push;
input	[DWIDTH-1:0]		push_data;

input				pop;
output	[DWIDTH-1:0]		pop_data;

output				mem_enable;

output				mem_wr_v;
output	[AWIDTH-1:0]		mem_wr_addr;
output	[DWIDTH-1:0]		mem_wr_data;

output				mem_rd_v;
output	[AWIDTH-1:0]		mem_rd_addr;
input	[DWIDTH-1:0]		mem_rd_data;

output	[DEPTHWIDTH-1:0]	fifo_push_depth;
output				fifo_push_full;
output				fifo_push_afull;

output	[DEPTHWIDTH-1:0]	fifo_pop_depth;
output				fifo_pop_aempty;
output				fifo_pop_empty;

output	[DEPTHWIDTH+5:0]	fifo_status;

//--------------------------------------------------------------------------------------------

wire				fifo_push;		// clk_push

reg	[AWIDTH-1:0]		fifo_wadd_q;		// clk_push
wire	[AWIDTH-1:0]		fifo_wadd_p1;		// clk_push
wire	[AWIDTH-1:0]		fifo_wadd_next;		// clk_push
reg	[AWIDTH:0]		fifo_wptr_q;		// clk_push
wire	[AWIDTH:0]		fifo_wptr_p1;		// clk_push
wire	[AWIDTH:0]		fifo_wptr_next;		// clk_push
reg	[AWIDTH:0]		fifo_wptr_gray_q;	// clk_push
wire	[AWIDTH:0]		fifo_wptr_gray_next;	// clk_push
wire	[AWIDTH:0]		fifo_wptr_gray_sync_q;	// clk_pop
wire	[AWIDTH:0]		fifo_wptr_sync;		// clk_pop

reg	[DEPTHWIDTH-1:0]	fifo_push_depth_q;	// clk_push
wire	[DEPTHWIDTH-1:0]	fifo_push_depth_next;	// clk_push
reg				fifo_push_full_q;	// clk_push
wire				fifo_push_full_next;	// clk_push
reg				fifo_push_afull_q;	// clk_push
wire				fifo_push_afull_next;	// clk_push
reg				fifo_overflow_q;	// clk_push
wire				fifo_overflow_next;	// clk_push

wire				fifo_pop;		// clk_pop

reg	[AWIDTH-1:0]		fifo_radd_q;		// clk_pop
wire	[AWIDTH-1:0]		fifo_radd_p1;		// clk_pop
wire	[AWIDTH-1:0]		fifo_radd_next;		// clk_pop
reg	[AWIDTH:0]		fifo_rptr_q;		// clk_pop
wire	[AWIDTH:0]		fifo_rptr_p1;		// clk_pop
wire	[AWIDTH:0]		fifo_rptr_next;		// clk_pop
reg	[AWIDTH:0]		fifo_rptr_gray_q;	// clk_pop
wire	[AWIDTH:0]		fifo_rptr_gray_next;	// clk_pop
wire	[AWIDTH:0]		fifo_rptr_gray_sync_q;	// clk_push
wire	[AWIDTH:0]		fifo_rptr_sync;		// clk_push

reg	[DEPTHWIDTH-1:0]	fifo_pop_depth_q;	// clk_pop
wire	[DEPTHWIDTH-1:0]	fifo_pop_depth_next;	// clk_pop
reg				fifo_pop_aempty_q;	// clk_pop
wire				fifo_pop_aempty_next;	// clk_pop
reg				fifo_pop_empty_q;	// clk_pop
wire				fifo_pop_empty_next;	// clk_pop
reg				fifo_underflow_q;	// clk_pop
wire				fifo_underflow_next;	// clk_pop

wire				fifo_underflow_sync_q;	// clk_push
wire				fifo_overflow_sync_q;	// clk_pop

wire	[1:0]			fifo_status_sync_q;	// Either

wire				mem_rd_v_int;
reg				mem_rd_v_q;
wire				mem_rd_data_v_next;
reg				mem_rd_data_v_q;
reg	[DWIDTH-1:0]		mem_rd_data_q;

//--------------------------------------------------------------------------------------------
// Logic on clk_push

assign fifo_push      = push & ~fifo_push_full_q;

assign fifo_wadd_p1   = ({{(32-AWIDTH){1'b0}},fifo_wadd_q} == (DEPTH-1)) ? {AWIDTH{1'b0}} :
			(fifo_wadd_q + 1'b1);
assign fifo_wadd_next = (fifo_push) ? fifo_wadd_p1 : fifo_wadd_q;

assign fifo_wptr_p1   = fifo_wptr_q + 1'b1;
assign fifo_wptr_next = (fifo_push) ? fifo_wptr_p1 : fifo_wptr_q;

IW_bin2gray #(.WIDTH(AWIDTH+1)) u_fifo_wptr_gray_next (
	.binary	(fifo_wptr_next),
	.gray	(fifo_wptr_gray_next)
);

IW_gray2bin #(.WIDTH(AWIDTH+1)) u_fifo_rptr_sync (
	.gray	(fifo_rptr_gray_sync_q),
	.binary	(fifo_rptr_sync)
);

// spyglass disable_block W484 W164a -- Do not need upper bit
assign fifo_push_depth_next = fifo_wptr_next - fifo_rptr_sync;
// spyglass enable_block W484 W164a
assign fifo_push_afull_next = (fifo_push_depth_next >= cfg_high_wm);
assign fifo_push_full_next  = ({{(32-DEPTHWIDTH){1'b0}},fifo_push_depth_next} == DEPTH);
assign fifo_overflow_next   = fifo_overflow_q | (push & fifo_push_full_q);

//--------------------------------------------------------------------------------------------
// Flops on clk_push

always @(posedge clk_push or negedge rst_push_n) begin
 if (~rst_push_n) begin
  fifo_wadd_q       <= {AWIDTH{1'b0}};
  fifo_wptr_q       <= {(AWIDTH+1){1'b0}};
  fifo_wptr_gray_q  <= {(AWIDTH+1){1'b0}};
  fifo_push_depth_q <= {DEPTHWIDTH{1'b0}};
  fifo_push_full_q  <= 1'b0;
  fifo_push_afull_q <= 1'b0;
  fifo_overflow_q   <= 1'b0;
 end else begin
  fifo_wadd_q       <= fifo_wadd_next;
  fifo_wptr_q       <= fifo_wptr_next;
  fifo_wptr_gray_q  <= fifo_wptr_gray_next;
  fifo_push_depth_q <= fifo_push_depth_next;
  fifo_push_full_q  <= fifo_push_full_next;
  fifo_push_afull_q <= fifo_push_afull_next;
  fifo_overflow_q   <= fifo_overflow_next;
 end
end

IW_sync_posedge #(.WIDTH(AWIDTH+1), .NUM_STAGES(NUM_STAGES_PUSH)) u_fifo_rptr_gray_sync (
	.clk		(clk_push),
	.rst_n		(rst_push_n),
	.data		(fifo_rptr_gray_q),
	.data_sync	(fifo_rptr_gray_sync_q)
);

//--------------------------------------------------------------------------------------------
// Logic on clk_pop

assign fifo_pop       = pop & ~fifo_pop_empty_q;

assign fifo_radd_p1   = ({{(32-AWIDTH){1'b0}},fifo_radd_q} == (DEPTH-1)) ? {AWIDTH{1'b0}} :
			(fifo_radd_q + 1'b1);
assign fifo_radd_next = (fifo_pop) ? fifo_radd_p1 : fifo_radd_q;

assign fifo_rptr_p1   = fifo_rptr_q + 1'b1;
assign fifo_rptr_next = (fifo_pop) ? fifo_rptr_p1 : fifo_rptr_q;

IW_bin2gray #(.WIDTH(AWIDTH+1)) u_fifo_rptr_gray_next (
	.binary	(fifo_rptr_next),
	.gray	(fifo_rptr_gray_next)
);

IW_gray2bin #(.WIDTH(AWIDTH+1)) u_fifo_wptr_sync (
	.gray	(fifo_wptr_gray_sync_q),
	.binary	(fifo_wptr_sync)
);

// spyglass disable_block W484 W164a -- Do not need upper bit
assign fifo_pop_depth_next = fifo_wptr_sync - fifo_rptr_next;
// spyglass enable_block W484 W164a
assign fifo_pop_aempty_next = (fifo_pop_depth_next <= cfg_low_wm);
assign fifo_pop_empty_next  = (fifo_pop_depth_next == {DEPTHWIDTH{1'b0}});
assign fifo_underflow_next  = fifo_underflow_q | (pop & fifo_pop_empty_q);

assign mem_rd_data_v_next = (mem_rd_data_v_q) ? ~fifo_pop : (mem_rd_v_q & ~fifo_pop);

//--------------------------------------------------------------------------------------------
// Flops on clk_pop

always @(posedge clk_pop or negedge rst_pop_n) begin
 if (~rst_pop_n) begin
  fifo_radd_q       <= {AWIDTH{1'b0}};
  fifo_rptr_q       <= {(AWIDTH+1){1'b0}};
  fifo_rptr_gray_q  <= {(AWIDTH+1){1'b0}};
  fifo_pop_depth_q  <= {DEPTHWIDTH{1'b0}};
  fifo_pop_aempty_q <= 1'b1;
  fifo_pop_empty_q  <= 1'b1;
  fifo_underflow_q  <= 1'b0;
  mem_rd_v_q        <= 1'b0;
  mem_rd_data_v_q   <= 1'b0;
 end else begin
  fifo_radd_q       <= fifo_radd_next;
  fifo_rptr_q       <= fifo_rptr_next;
  fifo_rptr_gray_q  <= fifo_rptr_gray_next;
  fifo_pop_depth_q  <= fifo_pop_depth_next;
  fifo_pop_aempty_q <= fifo_pop_aempty_next;
  fifo_pop_empty_q  <= fifo_pop_empty_next;
  fifo_underflow_q  <= fifo_underflow_next;
  mem_rd_v_q        <= mem_rd_v_int;
  mem_rd_data_v_q   <= mem_rd_data_v_next;
 end
end

always @(posedge clk_pop) begin
 if (~mem_rd_data_v_q & mem_rd_data_v_next) mem_rd_data_q <= mem_rd_data;
end

IW_sync_posedge #(.WIDTH(AWIDTH+1), .NUM_STAGES(NUM_STAGES_POP)) u_fifo_wptr_gray_sync (
	.clk		(clk_pop),
	.rst_n		(rst_pop_n),
	.data		(fifo_wptr_gray_q),
	.data_sync	(fifo_wptr_gray_sync_q)
);

//--------------------------------------------------------------------------------------------
// Interface to the actual memory
//--------------------------------------------------------------------------------------------

assign mem_wr_v     = fifo_push;
assign mem_wr_addr  = fifo_wadd_q;
assign mem_wr_data  = push_data;

assign mem_rd_v_int = (fifo_pop & (|{1'b0, fifo_pop_depth_next[DEPTHWIDTH-1:0]})) |
			(fifo_pop_empty_q & ~fifo_pop_empty_next);
assign mem_rd_v     = mem_rd_v_int;
assign mem_rd_addr  = fifo_radd_next;

assign mem_enable   = fifo_push | mem_rd_v_int;

//--------------------------------------------------------------------------------------------

IW_sync_posedge #(.WIDTH(1), .NUM_STAGES(NUM_STAGES_PUSH)) u_sync_underflow (

	.clk		(clk_push),
	.rst_n		(rst_push_n),
	.data		(fifo_underflow_q),
	.data_sync	(fifo_underflow_sync_q)
);

IW_sync_posedge #(.WIDTH(1), .NUM_STAGES(NUM_STAGES_POP)) u_sync_overflow (

	.clk		(clk_pop),
	.rst_n		(rst_pop_n),
	.data		(fifo_overflow_q),
	.data_sync	(fifo_overflow_sync_q)
);

//--------------------------------------------------------------------------------------------
// Drive the outputs
//--------------------------------------------------------------------------------------------

assign pop_data = (mem_rd_data_v_q) ? mem_rd_data_q : mem_rd_data;

assign fifo_push_depth = (fifo_overflow_q | fifo_underflow_sync_q) ? {DEPTHWIDTH{1'b1}} :
				fifo_push_depth_q;
assign fifo_push_full  = fifo_push_full_q  | fifo_overflow_q | fifo_underflow_sync_q;
assign fifo_push_afull = fifo_push_afull_q | fifo_overflow_q | fifo_underflow_sync_q;

assign fifo_pop_depth  = (fifo_overflow_sync_q | fifo_underflow_q) ? {DEPTHWIDTH{1'b1}} :
				fifo_pop_depth_q;
assign fifo_pop_aempty = fifo_pop_aempty_q | fifo_overflow_sync_q | fifo_underflow_q;
assign fifo_pop_empty  = fifo_pop_empty_q  | fifo_overflow_sync_q | fifo_underflow_q;

// The full, afull and overflow indications are on clk_push.  For config access to these
// we need them synced to clk_pop if the config access is on clk_pop.
// The empty, aempty and underflow indications are on clk_pop.  For config access to these
// we need them synced to clk_push if the config access is on clk_push.
// In either case, we need to ensure that the error pulse (overflow or underflow) on the other
// clock domain is correctly seen across the clock crossing.
// The fifo_status_q[1:0] signals will contain {full,afull} synced to clk_pop or {aempty,empty}
// synced to clk_push depending on the setting of the SYNC_POP parameter.

generate

 if (SYNC_POP==0) begin: Sync_to_clk_push

  IW_sync_posedge #(.WIDTH(2), .NUM_STAGES(NUM_STAGES_PUSH)) u_fifo_status (
	.clk		(clk_push),
	.rst_n		(rst_push_n),
	.data		({fifo_pop_aempty_q,fifo_pop_empty_q}),
	.data_sync	(fifo_status_sync_q)
  );

  assign fifo_status = { fifo_push_depth		// depth
			,fifo_push_full_q		// full
			,fifo_push_afull_q		// afull
			,fifo_status_sync_q[1]		// aempty
			,fifo_status_sync_q[0]		// empty
			,fifo_overflow_q		// overflow
			,fifo_underflow_sync_q		// underflow
  };

 end else begin: Sync_to_clk_pop

  IW_sync_posedge #(.WIDTH(2), .NUM_STAGES(NUM_STAGES_POP)) u_fifo_status (
	.clk		(clk_pop),
	.rst_n		(rst_pop_n),
	.data		({fifo_push_full_q,fifo_push_afull_q}),
	.data_sync	(fifo_status_sync_q)
  );

  assign fifo_status = { fifo_pop_depth			// depth
			,fifo_status_sync_q[1]		// full
			,fifo_status_sync_q[0]		// afull
			,fifo_pop_aempty_q		// aempty
			,fifo_pop_empty_q		// empty
			,fifo_overflow_sync_q		// overflow
			,fifo_underflow_q		// underflow
  };

 end

endgenerate

endmodule // IW_fifo_ctl_dc

