//-----------------------------------------------------------------------------------------------------
//                              Copyright (c) LSI CORPORATION, 2012.
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
//------------------------------------------------------------------------
// Version and Release Control Information:
//
// File Name:     $RCSfile: IW_fpga_ecc_gen.sv.rca $
// File Revision: $Revision: 1.2 $
// Created by:    Jim Clee
// Updated by:    $Author: jclee $ $Date: Mon Mar  4 15:16:15 2013 $
//--------------------------------------------------------------------------
// This module provides ECC generation, registering and scaling so that, when used in conjunction with
// an IW_fpga_ecc_check, it will provide ECC checking (no correction) for an fpga interface (e.g. mux/demux
// or serdes), with registering before and after the generation/checking logic.
//
// The ECC logic is scaled so that each group of 120 "data" bits is covered by 8 bits of ECC.  Spare bits
// are padded with 0 inside this module and assumed to be 0 in the checking module.  All error bits are
// collapsed into a single output error bit.
//
// The DATA_WIDTH_FOR_ECC parameter needs to be equal to DATA_WIDTH rounded up (if necessary) to the next
// highest multiple of 120.  The code could be updated to derive DATA_WIDTH_FOR_ECC from DATA_WIDTH.
//--------------------------------------------------------------------------

`timescale 1ns/1ps

module IW_fpga_ecc_gen #(
parameter	DATA_WIDTH=119 ,
parameter	DATA_WIDTH_FOR_ECC=120
) (
	clk ,
	rst_n ,
	in_data ,

	out_gecc_q
) ;
`include "IW_logb2.svh"
localparam NUM_ECC=(DATA_WIDTH_FOR_ECC / 120) ;
localparam ECC_WIDTH=(8*NUM_ECC) ;

input					clk ;
input					rst_n ;
input	[DATA_WIDTH-1:0]		in_data ;

output	[ECC_WIDTH-1:0]			out_gecc_q ;

reg	[ECC_WIDTH-1:0]			out_gecc_q ;

reg	[DATA_WIDTH-1:0]		in_data_q ;
wire	[ECC_WIDTH-1:0]			out_gecc ;
reg	[DATA_WIDTH_FOR_ECC-1:0]	in_data_padded ;

   always @(posedge clk or negedge rst_n ) begin
    if ( ~rst_n ) begin
	in_data_q		<= { DATA_WIDTH { 1'b0 } } ;
	out_gecc_q		<= { ECC_WIDTH { 1'b0 } } ;
    end
    else begin
	in_data_q		<= in_data ;
	out_gecc_q		<= out_gecc ;
    end
   end // always

   always @(*) begin
    in_data_padded			= { DATA_WIDTH_FOR_ECC { 1'b0 } } ;
    in_data_padded [DATA_WIDTH-1:0]	= in_data_q ;
   end // always

   IW_data_ecc_gen #(
	.DATA_WIDTH	(DATA_WIDTH_FOR_ECC),
	.ECC_DATA_WIDTH	(120),
	.ECC_WIDTH	(8)
   ) u_IW_data_ecc_gen (
	.data				( in_data_padded ) ,		// I
	.data_ecc			( out_gecc )			// O
   ) ;

endmodule // IW_fpga_ecc_gen

//--------------------------------------------------------------------------
// Change History:
//
// $Log: IW_fpga_ecc_gen.sv.rca $
// 
//  Revision: 1.2 Mon Mar  4 15:16:15 2013 jclee
//  Add comments etc
//
//--------------------------------------------------------------------------
