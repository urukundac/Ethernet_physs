//-----------------------------------------------------------------------------------------------------
//                              Copyright (c) LSI CORPORATION, 2008.
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
// File Name:     IW_sacram_1r_1w_32x13.sv
// File Revision: $Revision: 1.1.1.7 $
// Created by:    KC-based script ported by DB
// Updated by:    $Author: fhf $ $Date: Fri Apr  3 17:49:45 2015 $
//-----------------------------------------------------------------------------------------------------
// IW_sacram_1r_1w -  Register File: 1 Port Read , 1 Port Write
//                    Sync: Address, Write Enable, Read Enable, Write Data.
//                    Non-pipelined Read Data.
//
// This module is responsible for wrapping a memory structure with repeatable logic
//             Repeatable interface connections (technology independent)
//             LOGIC VISION tie off support
//             Correct clocking
//             Error checking
//
// The following parameters are supported:
//
//      ADDR_COLLISION_ASSERT   Control if the assertion for address collision is run (0-off 1-run)
//      ADD_BP_REG              Control if bypass logic is inserted for the memory, error checking is off
//                              (0-no bypass 1-bypass)
//-----------------------------------------------------------------------------------------------------
// Change History:
//
// $Log: IW_sacram_1r_1w_32x13.sv.rca $
// 
//  Revision: 1.1.1.7 Fri Apr  3 17:49:45 2015 fhf
//  update AW fpga sram inventory - using updated rtl code generators
//
//-----------------------------------------------------------------------------------------------------

`timescale 1ns/1ps


// spyglass disable_block W175 --ADDR_COLLISION_ASSERT only used during assertions

module IW_sacram_1r_1w_32x13 #(
parameter    ADDR_COLLISION_ASSERT=1
,
parameter ADD_BP_REG = 0
,
parameter RAM_TYPE="RF"
,
parameter MRF_THRESH="SVT"
) (

// spyglass enable_block W175

     CLK,        // Single clock for read and write
     WADDR,      // Write Address
     RADDR,      // Read  Address
     WDATA,      // Write Data
     RDATA,      // Read  Data
     WE,         // Write Enable : active high signal : !(RE && WE) = deselect memory
     RE,         // Read  Enable : active high signal
     RSTB        // Reset Used to disable Assertions

);


input			CLK;
input			RSTB;
input			WE;
input			RE;
input	[5-1:0]  	WADDR;
input	[5-1:0]  	RADDR;
input	[13-1:0]  	WDATA;

output	[13-1:0]  	RDATA;

reg	[13-1:0]  	RDATA;

wire			wclk;
wire			rclk;
wire	[13-1:0]  	din;
wire	[13-1:0]  	b_dout;
wire			WEB;
wire			REB;
wire	[13-1:0]  	BWEB_TIE;

//*******************************************************************
// Check parameters for valid state

// synopsys translate_off
`ifdef ASSERT_ON
initial begin

 check_addr_collision_param:
 assert (  (ADDR_COLLISION_ASSERT==0) || (ADDR_COLLISION_ASSERT==1)) else begin
  $display ("\nERROR: %m: Parameter ADDR_COLLISION_ASSERT had an illegal value (%d), can only be (0 or 1) !!!\n",ADDR_COLLISION_ASSERT);
  if (!$test$plusargs("IW_CONTINUE_ON_ERROR")) $stop;
 end

 check_add_bp_reg_param:
 assert (  (ADD_BP_REG==0) || (ADD_BP_REG==1)) else begin
  $display ("\nERROR: %m: Parameter ADD_BP_REG had an illegal value (%d), can only be (0 or 1) !!!\n",ADD_BP_REG);
  if (!$test$plusargs("IW_CONTINUE_ON_ERROR")) $stop;
 end


end
`endif
// synopsys translate_on
assign wclk = CLK;
assign rclk = CLK;


//*******************************************************************
// Invert active high WE and RE to match the WEB and REB regfile ports
// Tie off Bit Write due to the fact that we cannot support this in FPGA


assign WEB = !WE;
assign REB = !RE;
assign BWEB_TIE = 0;

//*******************************************************************
// Assign in place: in case we need to use two register files for width.

assign din[13-1:0] = WDATA[13-1:0];

//*******************************************************************
// MBIST wires and TIEOFFS. Will be hooked up by Logicvision

wire	[5-1:0]  	tadra_tieoff;
wire	[5-1:0]  	tadrb_tieoff;
wire	[13-1:0]  	tda_tieoff;
wire	[13-1:0]  	tbweb_tieoff;
wire			tweb_tieoff;
wire			treb_tieoff;
wire			bistea_tieoff;
assign tadra_tieoff = 0;
assign tda_tieoff = 0;
assign tweb_tieoff = 0;
assign tbweb_tieoff = 0;
assign treb_tieoff = 0;
assign bistea_tieoff = 0;
assign tadrb_tieoff = 0;


  //*******************************************************************
  // Hook up Artsian Register File
  fpgamem #(.ADDR_WD ( 5 ),
            .DATA_WD ( 13 ) ) fpgamem(
      .ckwr     ( CLK ),
      .ckrd     ( CLK ),
      .wr       ( WE ),
      .wrptr    ( WADDR ) ,
      .datain   ( WDATA ),
      .rd       ( RE ),
      .rdptr    ( RADDR ),
      .dataout  ( b_dout ) 
  );




//        altsyncram      altsyncram_component (
//                                .address_a (WADDR),
//                                .clock0 (CLK),
//                                .data_a (WDATA),
//                                .rden_b (RE),
//                                .wren_a (WE),
//                                .address_b (RADDR),
//                                .clock1 (CLK),
//                                .q_b (b_dout),
//                                .aclr0 (1'b0),
//                                .aclr1 (1'b0),
//                                .addressstall_a (1'b0),
//                                .addressstall_b (1'b0),
//                                .byteena_a (1'b1),
//                                .byteena_b (1'b1),
//                                .clocken0 (1'b1),
//                                .clocken1 (1'b1),
//                                .clocken2 (1'b1),
//                                .clocken3 (1'b1),
//                                .eccstatus (),
//                                .q_a (),
//                                .rden_a (1'b1),
//                                .wren_b (1'b0));
//        defparam
//                altsyncram_component.address_aclr_b = "NONE",
//                altsyncram_component.address_reg_b = "CLOCK1",
//                altsyncram_component.clock_enable_input_a = "BYPASS",
//                altsyncram_component.clock_enable_input_b = "BYPASS",
//                altsyncram_component.clock_enable_output_b = "BYPASS",
//                altsyncram_component.intended_device_family = "Stratix V",
//                altsyncram_component.lpm_type = "altsyncram", 
//                altsyncram_component.numwords_a = 32,
//                altsyncram_component.numwords_b = 32,
//                altsyncram_component.operation_mode = "DUAL_PORT",
//                altsyncram_component.outdata_aclr_b = "NONE",
//                altsyncram_component.outdata_reg_b = "UNREGISTERED",
//                altsyncram_component.power_up_uninitialized = "FALSE",
//                altsyncram_component.rdcontrol_reg_b = "CLOCK1",
//                altsyncram_component.widthad_a = 5,
//                altsyncram_component.widthad_b = 5,
//                altsyncram_component.width_a = 13,
//                altsyncram_component.enable_ecc = "FALSE",
//                altsyncram_component.width_b = 13,
//                altsyncram_component.width_byteena_a = 1;


generate
 if (ADD_BP_REG) begin

wire FEEDTHROUGHV_NEXT;
reg  FEEDTHROUGHV_Q;
wire [13-1:0] FEEDTHROUGHD_NEXT;
reg  [13-1:0] FEEDTHROUGHD_Q;

assign FEEDTHROUGHV_NEXT = ( WE & RE & (RADDR[5-1:0] == WADDR[5-1:0]) );
assign FEEDTHROUGHD_NEXT[13-1:0] = FEEDTHROUGHV_NEXT ? WDATA[13-1:0] : FEEDTHROUGHD_Q[13-1:0];


always @ (posedge CLK or negedge RSTB) begin
    if (!RSTB) begin
        FEEDTHROUGHV_Q         <= 0;
    end
    else begin
        if (RE) FEEDTHROUGHV_Q         <= FEEDTHROUGHV_NEXT;
    end
end


always @ (posedge CLK) begin
        FEEDTHROUGHD_Q[13-1:0] <= FEEDTHROUGHD_NEXT[13-1:0];
end

 always @ (*) begin
    if (FEEDTHROUGHV_Q) begin
       RDATA = FEEDTHROUGHD_Q[13-1:0];
    end
    else begin
       RDATA = b_dout;
    end
 end
end else begin
 always @ (*)
   RDATA = b_dout;
 end
endgenerate


// ***********************************************
// Force output data to X whenever an attempt is made to read
// the same address that is being written.

// synopsys translate_off

`ifndef MBIST_MODE

wire async_L;
wire x_out_read_data;
reg [2-1:0]  wr_addr_Q;
reg [2-1:0]  rd_addr_Q;
reg web_Q;
reg reb_Q;

always @ (posedge rclk)
  begin
    rd_addr_Q <= RADDR;
    reb_Q <= REB;
  end

always @ (posedge wclk)
  begin
    wr_addr_Q <= WADDR;
    web_Q <= WEB;
  end


assign x_out_read_data = ((rd_addr_Q == wr_addr_Q) && !web_Q && !reb_Q);

bufif1 check_for_illegal_read_0 ( b_dout[0], 1'bx, x_out_read_data);
bufif1 check_for_illegal_read_1 ( b_dout[1], 1'bx, x_out_read_data);
bufif1 check_for_illegal_read_2 ( b_dout[2], 1'bx, x_out_read_data);
bufif1 check_for_illegal_read_3 ( b_dout[3], 1'bx, x_out_read_data);
bufif1 check_for_illegal_read_4 ( b_dout[4], 1'bx, x_out_read_data);
bufif1 check_for_illegal_read_5 ( b_dout[5], 1'bx, x_out_read_data);
bufif1 check_for_illegal_read_6 ( b_dout[6], 1'bx, x_out_read_data);
bufif1 check_for_illegal_read_7 ( b_dout[7], 1'bx, x_out_read_data);
bufif1 check_for_illegal_read_8 ( b_dout[8], 1'bx, x_out_read_data);
bufif1 check_for_illegal_read_9 ( b_dout[9], 1'bx, x_out_read_data);
bufif1 check_for_illegal_read_10 ( b_dout[10], 1'bx, x_out_read_data);
bufif1 check_for_illegal_read_11 ( b_dout[11], 1'bx, x_out_read_data);
bufif1 check_for_illegal_read_12 ( b_dout[12], 1'bx, x_out_read_data);

// ***********************************************
// System Verilog Assertions to check for invalid ADDR read and write

`ifdef ASSERT_ON

generate
if ((ADD_BP_REG == 0) && (ADDR_COLLISION_ASSERT == 1)) begin
check_simultaneous_addr:
assert property (
 @(posedge wclk)
 disable iff (!RSTB)
 (!((wr_addr_Q == rd_addr_Q) && !reb_Q && !web_Q))) else begin
 $display ("\nERROR: %m Simultaneous read and write to the same address 0x%h @%0t",wr_addr_Q,$time);
 if (!$test$plusargs("IW_CONTINUE_ON_ERROR")) $stop;
 end
end
endgenerate

`endif
`endif
// synopsys translate_on


endmodule
