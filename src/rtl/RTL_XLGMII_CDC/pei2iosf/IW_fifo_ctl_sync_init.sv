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
// File Name:     $RCSfile: IW_fifo_ctl_sync_init.sv.rca $
// File Revision: $Revision: 1.9 $
// Created by:    Steve Pollock
// Updated by:    $Author: spollock $ $Date: Thu Feb 19 09:56:14 2015 $
//-----------------------------------------------------------------------------------------------------
// IW_fifo_ctl
//
// This is a parametized FIFO controller for a DEPTH+1 deep by DWIDTH wide FIFO memory.
// The actual FIFO depth, due to the addition of the bypass register, is DEPTH+1, but the controller is
// designed to be hooked up to a memory that is DEPTH deep.  The bypass register holds the last read
// data so the memory does not have to be accessed unless we are doing a pop and it is not empty.
// This is done for power saving reasons.
// The fifo_depth field must be wide enough to hold the value of DEPTH+1.
// The cfg_high_wm and cfg_low_wm fields must be wide enough to the value of DEPTH+2.
// Note that the fifo_rptr and fifo_wptr outputs refer to the memory and do not include the bypass reg.
//
// The following parameters are supported:
//
//	DEPTH			Depth of the external memory (actual FIFO depth is DEPTH+1).
//	DWIDTH			Width of the FIFO and datapath.
//
//	COV_FULL_PUSHPOP	Set this to 1 if the external memory supports simultaneous R/W to the
//				same address location.  This parameter controls the assertion check
//				for the simultaneous PUSH/POP while full and whether or not that
//				particular coverpoint is ignored or enabled for coverage.  It has no
//				effect on the functional logic.
//	COV_NEVER_FULL		Set this to 1 if the full condition of the FIFO can never be reached.
//				This enables an assertion that the condition doesn't occur and also
//				excludes any coverpoints related to the FULL condition.
//				If this parameter is set to 1, it changes the COV_FULL_PUSHPOP param
//				definition changes to replace FULL with DEPTH.
//	CHECK_PUSH_XZ		If this parameter is set to 1, an assertion will check that the
//				push data does not contain an 'x' or 'z'.
//
// The fifo_status[DEPTHWIDTH+5:0] output is defined as:
//
//	[DEPTHWIDTH+5:6]:	FIFO depth
//	[5]:			FIFO full         (FIFO depth == FIFO size)
//	[4]:			FIFO almost full  (FIFO depth >= high watermark)
//	[3]:			FIFO almost empty (FIFO depth <= low  watermark)
//	[2]:			FIFO empty        (FIFO depth == 0)
//	[1]:			FIFO overflow     (push while FIFO full)
//	[0]:			FIFO underflow    (pop  while FIFO empty)
//
// It is recommended that the entire set of fifo_status information be accessible through the
// configuration interface, with the lower 2 bits (overflow/underflow) hooked up to sticky registers
// so they can be remembered, read and cleared, and the remaining bits should be read-only.
//
//-----------------------------------------------------------------------------------------------------
//
// Push and pop are the basic FIFO operations.
// The memory interface is designed to interface to a 2-port memory, be it a register file (1
// write port and 1 read port) or a full 2-port SRAM (2 R/W ports).
// The mem_enable output is provided for memories with a seperate chip enable.
// The push_data input must be valid at the same time as the push input.
// The pop_data output is valid whenever the fifo_empty signal is not asserted.
// FIFO data that is the result of a push to an empty FIFO is bypassed and doesn't write the memory.
// Simultaneous push and pop are supported, but if the FIFO is full the external memory must support
// simultaneous read/write to the same address.
// The current FIFO depth as well as the full or empty status are provided as outputs.
// High and low watermark inputs are provided and the corresponding fifo_afull and fifo_aempty
// outputs are set whenever fifo_depth >= high or <= low.
// Push while full without pop and pop while empty conditions are flagged by the fifo_overflow
// and fifo_underflow fields of the fifo_status output.
// Assertions and a covergroup are inlined.
//
//--------------------------------------------------------------------------------------------
//
// push operation timing
//		      _____       _____       _____ 
// clk		_____|     |_____|     |_____|     
//		         ___________
// push		________|           |______________
//		         ___________
// push_data	--------X___________X--------------
//		                  _________________
// pop_data	-----------------X___valid_data____
//		_________________ _________________
// fifo_depth	_________________X_________________
//		_________________
// fifo_empty	                 |_________________
// fifo_aempty
//		                  _________________
// fifo_full	_________________|
// fifo_afull
// fifo_overflow
//
//--------------------------------------------------------------------------------------------
//
// pop operation timing
//		      _____       _____       _____ 
// clk		_____|     |_____|     |_____|     
//		_________________ _________________
// pop_data	___valid_data____X___next_data_____
//		         ___________
// pop 		________|           |______________
//		_________________ _________________
// fifo_depth	_________________X_________________
//		_________________
// fifo_full 	                 |_________________
// fifo_afull 
//		                  _________________
// fifo_empty	_________________|
// fifo_aempty
// fifo_underflow
//
//-----------------------------------------------------------------------------------------------------
//
// Added the functionality to synchronously put the fifo controller back to an initial state. It will
// used for logic that may be terminated at any arbitrary point (e.g. continous test mode), but must
// then be able to get back to an init state without hard reset being activated. this also applies to
// the "sticky" status.
//
//-----------------------------------------------------------------------------------------------------

`timescale 1ns/1ps

`include "IW_cover_on_ctrl.sv"

`IW_COVER_ON_CTRL(AW)

module IW_fifo_ctl_sync_init #(

	parameter	DEPTH		 = 4,
	parameter	DWIDTH		 = 4,

	// spyglass disable_block W175 -- Not used unless ASSERT_ON is defined

 	parameter	COV_FULL_PUSHPOP = 0,
 	parameter	COV_NEVER_FULL   = 0,
 	parameter	CHECK_PUSH_XZ    = 1

) (	// spyglass enable_block W175

	clk,
	rst_n,

        init,

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

	fifo_rptr,
	fifo_wptr,
	fifo_depth,
	fifo_full,
	fifo_afull,
	fifo_aempty,
	fifo_empty,

	fifo_status
);

`include "IW_logb2.svh"

localparam	AWIDTH     = IW_logb2(DEPTH-1)+1;
localparam	DEPTHWIDTH = IW_logb2(DEPTH+1)+1;
localparam	WMWIDTH    = IW_logb2(DEPTH+2)+1;

input				clk;
input				rst_n;

input                           init;

input	[WMWIDTH-1:0]		cfg_high_wm;
input	[WMWIDTH-1:0]		cfg_low_wm;

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

output	[AWIDTH-1:0]		fifo_rptr;
output	[AWIDTH-1:0]		fifo_wptr;
output	[DEPTHWIDTH-1:0]	fifo_depth;
output				fifo_full;
output				fifo_afull;
output				fifo_aempty;
output				fifo_empty;

output	[DEPTHWIDTH+5:0]	fifo_status;

//-----------------------------------------------------------------------------------------

`ifdef ASSERT_ON

// synopsys translate_off
initial begin

 check_cov_full_pushpop_param:
 assert ((COV_FULL_PUSHPOP == 0) || (COV_FULL_PUSHPOP == 1)) else begin
`ifdef SV_ASSERTION_ERROR_MACRO
  `SV_ASSERTION_ERROR_MACRO("AW", 
                            "fifo_ctl_sync_init_check_cov_full_pushpop_param", 
                            $psprintf("\nERROR: %m: Parameter COV_FULL_PUSHPOP had an illegal value (%0d).  Valid values are (0-1) !!!\n",COV_FULL_PUSHPOP) 
                           )
`else
  $display ("\nERROR: %m: Parameter COV_FULL_PUSHPOP had an illegal value (%0d).  Valid values are (0-1) !!!\n",COV_FULL_PUSHPOP);
  if (!$test$plusargs("IW_CONTINUE_ON_ERROR")) $stop;
`endif
 end

 check_cov_never_full_param:
 assert ((COV_NEVER_FULL == 0) || (COV_NEVER_FULL == 1)) else begin
`ifdef SV_ASSERTION_ERROR_MACRO
  `SV_ASSERTION_ERROR_MACRO("AW", 
                            "fifo_ctl_sync_init_check_cov_never_full_param", 
                            $psprintf("\nERROR: %m: Parameter COV_NEVER_FULL had an illegal value (%0d).  Valid values are (0-1) !!!\n",COV_NEVER_FULL) 
                           )
`else
  $display ("\nERROR: %m: Parameter COV_NEVER_FULL had an illegal value (%0d).  Valid values are (0-1) !!!\n",COV_NEVER_FULL);
  if (!$test$plusargs("IW_CONTINUE_ON_ERROR")) $stop;
`endif
 end

end
// synopsys translate_on

`endif

//--------------------------------------------------------------------------------------------

wire				mem_push;
wire				mem_pop;
wire				mem_empty;

reg				pop_q;

reg	[AWIDTH-1:0]		fifo_wptr_q;
wire	[AWIDTH-1:0]		fifo_wptr_p1;
wire	[AWIDTH-1:0]		fifo_wptr_next;

reg	[AWIDTH-1:0]		fifo_rptr_q;
wire	[AWIDTH-1:0]		fifo_rptr_next;
wire	[AWIDTH-1:0]		fifo_rptr_p1;

reg				fifo_bp_v_q;
wire				fifo_bp_v_next;
wire	[DWIDTH-1:0]		fifo_bp_data_next;
reg	[DWIDTH-1:0]		fifo_bp_data_q;

reg	[DEPTHWIDTH-1:0]	fifo_depth_q;
reg	[DEPTHWIDTH-1:0]	fifo_depth_next;
wire	[WMWIDTH-1:0]		fifo_depth_next_scaled;
reg				fifo_full_q;
wire				fifo_full_next;
reg				fifo_afull_q;
wire				fifo_afull_next;
reg				fifo_aempty_q;
wire				fifo_aempty_next;
reg				fifo_empty_q;
wire				fifo_empty_next;

wire				fifo_depth_le1_next;
reg				fifo_depth_le1_q;

reg				fifo_overflow_q;
wire				fifo_overflow_next;
reg				fifo_underflow_q;
wire				fifo_underflow_next;

wire	[DWIDTH-1:0]		pop_data_int;

//--------------------------------------------------------------------------------------------

//assign mem_empty = fifo_empty_q | fifo_depth_le1_q;
assign mem_empty = fifo_depth_le1_q;

assign mem_push = push & (~(fifo_empty_q | pop) | ~mem_empty);
assign mem_pop  = pop  & ~mem_empty;

assign fifo_rptr_p1 = ({{32-AWIDTH{1'b0}},fifo_rptr_q} == (DEPTH-1)) ? {AWIDTH{1'b0}} : fifo_rptr_q + 1'b1;
assign fifo_wptr_p1 = ({{32-AWIDTH{1'b0}},fifo_wptr_q} == (DEPTH-1)) ? {AWIDTH{1'b0}} : fifo_wptr_q + 1'b1;

assign fifo_rptr_next = (mem_pop)  ? fifo_rptr_p1 : fifo_rptr_q;
assign fifo_wptr_next = (mem_push) ? fifo_wptr_p1 : fifo_wptr_q;

always @(*) begin
 case ({(push & (~fifo_full_q | pop)),pop})
  2'b01:   fifo_depth_next = fifo_depth_q - 1'b1;
  2'b10:   fifo_depth_next = fifo_depth_q + 1'b1;
  default: fifo_depth_next = fifo_depth_q;
 endcase
end

IW_width_scale #(

	.A_WIDTH	(DEPTHWIDTH),
	.Z_WIDTH	(WMWIDTH)

) u_fifo_depth_next_scaled (

	.a		(fifo_depth_next),
	.z		(fifo_depth_next_scaled)
);

assign fifo_full_next   = ({{(32-DEPTHWIDTH){1'b0}},fifo_depth_next} == (DEPTH+1));
assign fifo_afull_next  = (fifo_depth_next_scaled >= cfg_high_wm);
assign fifo_aempty_next = (fifo_depth_next_scaled <= cfg_low_wm);
assign fifo_empty_next  = (fifo_depth_next == {DEPTHWIDTH{1'b0}});

//  assign fifo_overflow_next  = fifo_overflow_q | (push & ~pop & fifo_full_q);

generate
 if (COV_FULL_PUSHPOP) begin: g_full_pushpop
  assign fifo_overflow_next  = fifo_overflow_q | (push & ~pop & fifo_full_q);
 end else begin: g_no_full_pushpop
  assign fifo_overflow_next  = fifo_overflow_q | (push & fifo_full_q);
 end
endgenerate

assign fifo_underflow_next = fifo_underflow_q | (pop & fifo_empty_q);

assign fifo_depth_le1_next = ~(|{1'b0,fifo_depth_next[DEPTHWIDTH-1:1]});

assign fifo_bp_v_next = (push & (fifo_empty_q | (pop & fifo_depth_le1_q))) |
			(pop_q & ~pop & (push | ~fifo_empty_q));

assign fifo_bp_data_next = (pop_q & ~pop & ~fifo_empty_q) ? mem_rd_data : push_data;

//--------------------------------------------------------------------------------------------

always @(posedge clk or negedge rst_n) begin
 if (~rst_n) begin
  pop_q            <= 1'b0;
  fifo_rptr_q      <= {AWIDTH{1'b0}};
  fifo_wptr_q      <= {AWIDTH{1'b0}};
  fifo_bp_v_q      <= 1'b0;
  fifo_depth_q     <= {DEPTHWIDTH{1'b0}};
  fifo_depth_le1_q <= 1'b1;
  fifo_full_q      <= 1'b0;
  fifo_afull_q     <= 1'b0;
  fifo_aempty_q    <= 1'b1;
  fifo_empty_q     <= 1'b1;
  fifo_overflow_q  <= 1'b0;
  fifo_underflow_q <= 1'b0;
 end else begin
  pop_q            <= pop;
  if (init) begin // synchronous init
   fifo_rptr_q      <= {AWIDTH{1'b0}};
   fifo_wptr_q      <= {AWIDTH{1'b0}};
   fifo_bp_v_q      <= 1'b0;
   fifo_depth_q     <= {DEPTHWIDTH{1'b0}};
   fifo_depth_le1_q <= 1'b1;
   fifo_full_q      <= 1'b0;
   fifo_afull_q     <= 1'b0;
   fifo_aempty_q    <= 1'b1;
   fifo_empty_q     <= 1'b1;
   fifo_overflow_q  <= 1'b0;
   fifo_underflow_q <= 1'b0;
  end
  else begin // normal behavior
   fifo_rptr_q      <= fifo_rptr_next;
   fifo_wptr_q      <= fifo_wptr_next;
   fifo_bp_v_q      <= fifo_bp_v_next | (fifo_bp_v_q & ~pop);
   fifo_depth_q     <= fifo_depth_next;
   fifo_depth_le1_q <= fifo_depth_le1_next;
   fifo_full_q      <= fifo_full_next;
   fifo_afull_q     <= fifo_afull_next;
   fifo_aempty_q    <= fifo_aempty_next;
   fifo_empty_q     <= fifo_empty_next;
   fifo_overflow_q  <= fifo_overflow_next;
   fifo_underflow_q <= fifo_underflow_next;
  end
 end
end

always @(posedge clk ) if (~fifo_bp_v_q | (push & ~mem_push)) fifo_bp_data_q <= fifo_bp_data_next;

//--------------------------------------------------------------------------------------------
// Interface to the actual memory
//--------------------------------------------------------------------------------------------

assign mem_wr_v    = mem_push;
assign mem_wr_addr = fifo_wptr_q;
assign mem_wr_data = push_data;

assign mem_rd_v    = mem_pop;
assign mem_rd_addr = fifo_rptr_q;

assign mem_enable  = mem_push | mem_pop;

//--------------------------------------------------------------------------------------------
// Drive the outputs
//--------------------------------------------------------------------------------------------

assign pop_data_int   = (fifo_bp_v_q) ? fifo_bp_data_q : mem_rd_data;

assign pop_data       = pop_data_int;

assign fifo_rptr      = fifo_rptr_q;
assign fifo_wptr      = fifo_wptr_q;
assign fifo_depth     = (fifo_overflow_q | fifo_underflow_q) ? {DEPTHWIDTH{1'b1}} : fifo_depth_q;
assign fifo_full      = fifo_full_q   | fifo_overflow_q | fifo_underflow_q;
assign fifo_afull     = fifo_afull_q  | fifo_overflow_q | fifo_underflow_q;
assign fifo_aempty    = fifo_aempty_q | fifo_overflow_q | fifo_underflow_q;
assign fifo_empty     = fifo_empty_q  | fifo_overflow_q | fifo_underflow_q;

assign fifo_status = {	 fifo_depth_q
			,fifo_full_q
			,fifo_afull_q
			,fifo_aempty_q
			,fifo_empty_q
			,fifo_overflow_q
			,fifo_underflow_q
};

//--------------------------------------------------------------------------------------------
// Assertions

`ifdef ASSERT_ON

 // Model the FIFO with a local Queue and check the pop_data against our local copy.

 reg	[DWIDTH-1:0]	fifo_queue[$];
 reg	[DWIDTH-1:0]	exp_fifo_data;
 reg	[DWIDTH-1:0]	pop_datax;

 always @(negedge clk) begin
  exp_fifo_data = (fifo_queue.size() > 0) ? fifo_queue[0] : {DWIDTH{1'bx}};
 end

 always @(*) begin: Pop_Data_X
  integer i;
  for (i=0; i<DWIDTH; i=i+1) pop_datax[i] = ($isunknown(exp_fifo_data[i])) ? 1'bx : pop_data[i];
 end

// not true for unconventional use
// always @(posedge clk or negedge rst_n) begin
//  if (~rst_n) begin
//
//   while (fifo_queue.size() != 0) fifo_queue.pop_front();
//
//  end else begin
//
//   if (push) fifo_queue.push_back(push_data);
//
//   if (pop) begin
//
//    this needs more examination
//    check_fifo_value: assert property (
//     (pop_datax === exp_fifo_data)
//    ) else begin
//     $display ("\nERROR: %t: %m: FIFO data value error detected (expected=%0h actual=%0h) !!!\n",
//        $time,$sampled(exp_fifo_data),$sampled(pop_data));
//     if (!$test$plusargs("IW_CONTINUE_ON_ERROR")) $stop;
//    end
//
//    if (fifo_queue.size() != 0) fifo_queue.pop_front();
//
//   end
//
//  end
// end

generate
 if (COV_FULL_PUSHPOP) begin: g_cov_fpp
  check_overflow: assert property (
   @(posedge clk)
   disable iff (rst_n !== 1'b1)
   !(push && !(pop && COV_FULL_PUSHPOP) && (fifo_depth_q == (DEPTH+1)))
  ) else begin
`ifdef SV_ASSERTION_ERROR_MACRO
   `SV_ASSERTION_ERROR_MACRO("AW", 
                             "fifo_ctl_sync_init_check_overflow", 
                             $psprintf("\nERROR: %t: %m: FIFO overflow detected (push while full w/o pop) !!!\n",$time) 
                            )
`else
   $display ("\nERROR: %t: %m: FIFO overflow detected (push while full w/o pop) !!!\n",$time);
   if (!$test$plusargs("IW_CONTINUE_ON_ERROR")) $stop;
`endif
  end
 end else begin: g_cov_nofpp
   check_overflow: assert property (
    @(posedge clk)
    disable iff (rst_n !== 1'b1)
    !(push && (fifo_depth_q == (DEPTH+1)))
   ) else begin
`ifdef SV_ASSERTION_ERROR_MACRO
    `SV_ASSERTION_ERROR_MACRO("AW", 
                              "fifo_ctl_sync_init_check_overflow", 
                              $psprintf("\nERROR: %t: %m: FIFO overflow detected (push while full) !!!\n",$time) 
                             )
`else
    $display ("\nERROR: %t: %m: FIFO overflow detected (push while full) !!!\n",$time);
    if (!$test$plusargs("IW_CONTINUE_ON_ERROR")) $stop;
`endif
   end
  end

   if (CHECK_PUSH_XZ == 1) begin: g_cov_pushxz
   check_data_unknown: assert property (
    @(posedge clk)
    disable iff (rst_n !== 1'b1)
    !(push && $isunknown(push_data))
   ) else begin
`ifdef SV_ASSERTION_WARNING_MACRO
    `SV_ASSERTION_WARNING_MACRO("AW", 
                                "fifo_ctl_sync_init_check_data_unknown", 
                                $psprintf("\nWARNING: %t: %m: FIFO push data contains 'x' or 'z' values !!!\n",$time) 
                               )
`else
    $display ("\nWARNING: %t: %m: FIFO push data contains 'x' or 'z' values !!!\n",$time);
    if ($test$plusargs("IW_STOP_ON_WARNING")) $stop;
`endif
   end
  end
endgenerate

 check_underflow: assert property (
  @(posedge clk)
  disable iff (rst_n !== 1'b1)
  !(pop && !(|fifo_depth_q))
 ) else begin
`ifdef SV_ASSERTION_ERROR_MACRO
  `SV_ASSERTION_ERROR_MACRO("AW", 
                            "fifo_ctl_sync_init_check_underflow", 
                            $psprintf("\nERROR: %t: %m: FIFO underflow detected (pop while empty) !!!\n",$time) 
                           )
`else
  $display ("\nERROR: %t: %m: FIFO underflow detected (pop while empty) !!!\n",$time);
  if (!$test$plusargs("IW_CONTINUE_ON_ERROR")) $stop;
`endif
 end

 check_full: assert property (
  @(posedge clk)
  disable iff (rst_n !== 1'b1)
  !((fifo_depth_q == (DEPTH+1)) && COV_NEVER_FULL)
 ) else begin
`ifdef SV_ASSERTION_ERROR_MACRO
  `SV_ASSERTION_ERROR_MACRO("AW", 
                            "fifo_ctl_sync_init_check_full", 
                            $psprintf("\nERROR: %t: %m: FIFO went full but COV_NEVER_FULL was set to 1 !!!\n",$time) 
                           )
`else
  $display ("\nERROR: %t: %m: FIFO went full but COV_NEVER_FULL was set to 1 !!!\n",$time);
  if (!$test$plusargs("IW_CONTINUE_ON_ERROR")) $stop;
`endif
 end

 check_depth_pushpop: assert property (
  @(posedge clk)
  disable iff (rst_n !== 1'b1)
  !(push && COV_NEVER_FULL && (!COV_FULL_PUSHPOP) && (fifo_depth_q == DEPTH))
 ) else begin
`ifdef SV_ASSERTION_ERROR_MACRO
  `SV_ASSERTION_ERROR_MACRO("AW", 
                            "fifo_ctl_sync_init_check_depth_pushpop", 
                            $psprintf("\nERROR: %t: %m: FIFO was pushed when COV_NEVER_FULL==1 and COV_FULL_PUSHPOP==0 !!!\n",$time) 
                           )
`else
  $display ("\nERROR: %t: %m: FIFO was pushed when COV_NEVER_FULL==1 and COV_FULL_PUSHPOP==0 !!!\n",$time);
  if (!$test$plusargs("IW_CONTINUE_ON_ERROR")) $stop;
`endif
 end


`endif

//--------------------------------------------------------------------------------------------
// Coverage

`ifdef COVER_ON_AW

 generate
  if (COV_NEVER_FULL == 1) begin: g_cov_never_full

   covergroup IW_fifo_ctl_sync_init_CG @(posedge clk);

    IW_fifo_ctl_sync_init_CP_push: coverpoint push iff (rst_n === 1'b1) {
	bins		NO_PUSH		= {0};
	bins		PUSH		= {1};
    }

    IW_fifo_ctl_sync_init_CP_pop: coverpoint pop iff (rst_n === 1'b1) {
	bins		NO_POP		= {0};
	bins		POP		= {1};
    }

    IW_fifo_ctl_sync_init_CP_hwm: coverpoint (fifo_depth_q >= cfg_high_wm) iff (rst_n === 1'b1) {
	bins		DEPTH_LT_HWM	= {0};
	bins		DEPTH_GE_HWM	= {1};
    }

    IW_fifo_ctl_sync_init_CP_lwm: coverpoint (fifo_depth_q <= cfg_low_wm) iff (rst_n === 1'b1) {
	bins		DEPTH_GT_LWM	= {0};
	bins		DEPTH_LE_LWM	= {1};
    }

    IW_fifo_ctl_sync_init_CP_depth: coverpoint fifo_depth_q iff (rst_n === 1'b1) {
	bins		EMPTY		= {0};
	bins		DEEP[DEPTH]	= {[1:DEPTH]};    
	ignore_bins	IGNORE_FULL     = {DEPTH+1};
    }

    IW_fifo_ctl_sync_init_CX: cross IW_fifo_ctl_sync_init_CP_push, IW_fifo_ctl_sync_init_CP_pop, IW_fifo_ctl_sync_init_CP_depth {
	ignore_bins	POP_EMPTY	= binsof(IW_fifo_ctl_sync_init_CP_pop.POP) &&
					  binsof(IW_fifo_ctl_sync_init_CP_depth.EMPTY);
	ignore_bins	PUSH_DEPTH 	= binsof(IW_fifo_ctl_sync_init_CP_pop.NO_POP) &&
					  binsof(IW_fifo_ctl_sync_init_CP_push.PUSH) &&
					  binsof(IW_fifo_ctl_sync_init_CP_depth) intersect {DEPTH};
	ignore_bins	PUSH_POP_DEPTH	= binsof(IW_fifo_ctl_sync_init_CP_pop) intersect {(1-COV_FULL_PUSHPOP)} &&
					  binsof(IW_fifo_ctl_sync_init_CP_push.PUSH) &&
					  binsof(IW_fifo_ctl_sync_init_CP_depth) intersect {DEPTH};

    }

   endgroup

   IW_fifo_ctl_sync_init_CG IW_fifo_ctl_sync_init_CG_inst = new();

  end else begin: g_cov_full

   covergroup IW_fifo_ctl_sync_init_CG @(posedge clk);

    IW_fifo_ctl_sync_init_CP_push: coverpoint push iff (rst_n === 1'b1) {
	bins		NO_PUSH		= {0};
	bins		PUSH		= {1};
    }

    IW_fifo_ctl_sync_init_CP_pop: coverpoint pop iff (rst_n === 1'b1) {
	bins		NO_POP		= {0};
	bins		POP		= {1};
    }

    IW_fifo_ctl_sync_init_CP_hwm: coverpoint (fifo_depth_q >= cfg_high_wm) iff (rst_n === 1'b1) {
	bins		DEPTH_LT_HWM	= {0};
	bins		DEPTH_GE_HWM	= {1};
    }

    IW_fifo_ctl_sync_init_CP_lwm: coverpoint (fifo_depth_q <= cfg_low_wm) iff (rst_n === 1'b1) {
	bins		DEPTH_GT_LWM	= {0};
	bins		DEPTH_LE_LWM	= {1};
    }

    IW_fifo_ctl_sync_init_CP_depth: coverpoint fifo_depth_q iff (rst_n === 1'b1) {
	bins		EMPTY		= {0};
	bins		DEEP[DEPTH]	= {[1:DEPTH]};    
	bins		FULL		= {DEPTH+1};
    }

    IW_fifo_ctl_sync_init_CX: cross IW_fifo_ctl_sync_init_CP_push, IW_fifo_ctl_sync_init_CP_pop, IW_fifo_ctl_sync_init_CP_depth {
	ignore_bins	POP_EMPTY	= binsof(IW_fifo_ctl_sync_init_CP_pop.POP) &&
					  binsof(IW_fifo_ctl_sync_init_CP_depth.EMPTY);
	ignore_bins	PUSH_FULL	= binsof(IW_fifo_ctl_sync_init_CP_pop.NO_POP) &&
					  binsof(IW_fifo_ctl_sync_init_CP_push.PUSH) &&
					  binsof(IW_fifo_ctl_sync_init_CP_depth.FULL);
	ignore_bins	PUSH_POP_FULL	= binsof(IW_fifo_ctl_sync_init_CP_pop) intersect {(1-COV_FULL_PUSHPOP)} &&
					  binsof(IW_fifo_ctl_sync_init_CP_push.PUSH) &&
					  binsof(IW_fifo_ctl_sync_init_CP_depth.FULL);
    }

   endgroup

   IW_fifo_ctl_sync_init_CG IW_fifo_ctl_sync_init_CG_inst = new();

  end
 endgenerate

`endif

endmodule // IW_fifo_ctl_sync_init

//-----------------------------------------------------------------------------------------------------
// Change History:
//
// $Log: IW_fifo_ctl_sync_init.sv.rca $
// 
//  Revision: 1.9 Thu Feb 19 09:56:14 2015 spollock
//  Default for COV_FULL_PUSHPOP should be 0! -sjp
// 
//  Revision: 1.8 Fri Mar 22 16:27:01 2013 spollock
//  Moved change log to the end of the file. -sjp
// 
//  Revision: 1.7 Tue Jan 22 18:04:07 2013 mpp
//  Initial axxia version. -sjp
// 
//  Revision: 1.6.7.2.4.5.1.1 Wed Apr 18 15:16:01 2012 trlittle
//  The signal fifo_depth_le1_q which is derived from fifo_depth_q must be forced to one on asynchronous reset or synchronous init.
// 
//  Revision: 1.6.7.2.4.5 Mon Mar  7 14:10:27 2011 mrb
//  *** empty comment string ***
// 
//  Revision: 1.6.7.2.4.2 Wed Mar  2 15:55:32 2011 spollock
//  Added generate labels. -sjp
// 
//  Revision: 1.6.7.2.4.1 Wed Sep 29 17:09:34 2010 mpp
//  Changed assertion iff (!rst_n) to iff (rst_n !== 1'b1). -sjp
// 
//  Revision: 1.6.7.2 Wed Dec  9 16:54:56 2009 king
//  temporary disable of specific assertion until it can be
//  reviewed with respect to the module's use in ntemc test hw
// 
//  Revision: 1.6.7.1 Fri Dec  4 16:37:49 2009 king
//  turned off assertion that is not working in unconventional use of this
//  fifo controller.
// 
//  Revision: 1.6 Mon May  4 16:26:18 2009 spollock
//  Tweaked expected data assertion code to handle unknowns better. -sjp
// 
//  Revision: 1.5 Mon Mar 23 17:59:10 2009 king
//  added missing end within generate block for assertion testing
// 
//  Revision: 1.4 Tue Mar 17 12:05:30 2009 king
//  updated to match IW_fifo_ctl basic behavior
// 
//  Revision: 1.3 Mon Feb  2 15:46:28 2009 mrb
//  added code to control compilation of functional coverage code
// 
//  Revision: 1.2 Fri Sep 19 10:58:19 2008 spollock
//  Added CHECK_PUSH_XZ parameter to enable/disable push data 'x' or 'z' check. -sjp
// 
//  Revision: 1.1 Fri Aug 22 11:30:51 2008 king
//  initial commit of these AW building blocks originally designed to
//  be used in the tree engine memory controller. BE WARNED! these
//  modules have not yet undergone extensive verification. use at
//  your own risk. everyone is welcome to fix any issues found with
//  their functionality.
// 
//
//-----------------------------------------------------------------------------------------------------
