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
// File Name:     $RCSfile: IW_fpga_ecc_check.sv.rca $
// File Revision: $Revision: 1.2 $
// Created by:    Jim Clee
// Updated by:    $Author: jclee $ $Date: Mon Mar  4 15:28:07 2013 $
//--------------------------------------------------------------------------
// This module provides ECC checking, registering and scaling so that, when used in conjunction with
// an IW_fpga_ecc_gen, it will provide ECC checking (no correction) for an fpga interface (e.g. mux/demux
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

module IW_fpga_ecc_check #(
parameter	DATA_WIDTH=119 ,
parameter	DATA_WIDTH_FOR_ECC=120
) (
	clk ,
	rst_n ,
	in_data ,
	in_ecc ,

	out_ecc_err_q
) ;
`include "IW_logb2.svh"
localparam NUM_ECC=(DATA_WIDTH_FOR_ECC / 120) ;
localparam ECC_WIDTH=(8*NUM_ECC) ;

input				clk ;
input				rst_n ;
input	[DATA_WIDTH-1:0]	in_data ;
input	[ECC_WIDTH-1:0]		in_ecc ;

output 				out_ecc_err_q ; 


reg	[DATA_WIDTH-1:0]		in_data_q ;
reg	[DATA_WIDTH-1:0]		in_data_qq ;
reg	[DATA_WIDTH-1:0]		in_data_qqq ;
wire	[ECC_WIDTH-1:0]			in_ecc ;
reg	[ECC_WIDTH-1:0]			in_ecc_q ;
wire	[NUM_ECC-1:0]			out_s_err ;
wire	[NUM_ECC-1:0]			out_m_err ;
reg					out_ecc_err_q ;
reg	[DATA_WIDTH_FOR_ECC-1:0]	in_data_padded ;

   always @(posedge clk or negedge rst_n ) begin
    if ( ~rst_n ) begin
	in_data_q		<= { DATA_WIDTH { 1'b0 } } ;
	in_data_qq		<= { DATA_WIDTH { 1'b0 } } ;
	in_data_qqq		<= { DATA_WIDTH { 1'b0 } } ;
	in_ecc_q		<= { ECC_WIDTH { 1'b0 } } ;
	out_ecc_err_q		<= 1'b0 ;
    end
    else begin
	in_data_q		<= in_data ;
	in_data_qq		<= in_data_q ;
	in_data_qqq		<= in_data_qq ;
	in_ecc_q		<= in_ecc ;
	out_ecc_err_q		<= ( | { 1'b0 , out_s_err } ) || ( | { 1'b0 , out_m_err } ) ;
    end
   end // always

   always @(*) begin
	in_data_padded			= { DATA_WIDTH_FOR_ECC { 1'b0 } } ;
	in_data_padded [DATA_WIDTH-1:0]	= in_data_qqq ;
   end // always

   IW_data_ecc_check #(
	.DATA_WIDTH	(DATA_WIDTH_FOR_ECC),
	.ECC_DATA_WIDTH	(120),
	.ECC_WIDTH	(8)
   ) u_IW_data_ecc_check (
	.data				( in_data_padded ) ,		// I
	.data_ecc			( in_ecc_q ) ,			// I

	.ecc_error_single		( out_s_err ) ,			// O
	.ecc_error_multiple		( out_m_err )			// O
   ) ;

endmodule // IW_fpga_ecc_check

//--------------------------------------------------------------------------
// Change History:
//
// $Log: IW_fpga_ecc_check.sv.rca $
// 
//  Revision: 1.2 Mon Mar  4 15:28:07 2013 jclee
//  Add comments etc
//
//--------------------------------------------------------------------------
