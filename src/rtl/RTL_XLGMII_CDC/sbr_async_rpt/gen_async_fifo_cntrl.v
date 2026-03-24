/*=========================================================================== 
 Copyright (c) 2006 Intel Corporation
 Intel Communication Group/ Platform Network Group / ICGh
 Intel Proprietary
 
 FILE information:
 CVS Source    : $Source:$
 CVS Revision  : $Revision:$
 CVS Tag       : $Name:$
 Written by    : Amnon Israel
 Last Update by: $Author:$
 Last Update   : $Date: $

 Module Description:
 --------------------
 asynchronous FIFO control logic.
 Based on continously syncing number of reads to write domain and vice versa.
 
  ===========================================================================*/

module gen_async_fifo_cntrl
  #(parameter 
 	DW  = 8,  
 	AW = 5,  
 	DEPTH  = 32,
	DELAY = 1,
	SYNC = 0) 
 	(
 	
	 //Write
	 input                 wr_rst_n, 
	 input                 wr_clk,
	 input                 wr_en,
	 output [AW:0]         wr_used_space,
	 output                wr_full,

	 //Read 
	 input                 rd_rst_n, 
	 input                 rd_clk,
	 input                 rd_en,
	 output [AW:0]         rd_used_space,
	 output                rd_empty,
	 output [DW-1:0]       rd_data,
	 output                rd_ecc_err,
 	
	 //Memory
	 output                mem_wr_en,
	 output [AW-1:0]       mem_wr_addr,
	 output                mem_rd_en,
	 output [AW-1:0]       mem_rd_addr,
	 input [DW-1:0]        mem_rd_data,
	 input                 mem_rd_ecc_err
	 );

   wire [AW:0] 			   wr_num_of_writes;
   wire [AW:0] 			   wr_num_of_reads;
   wire [AW:0] 			   rd_num_of_reads;
   wire [AW:0] 			   rd_num_of_writes;
   
   
   gen_wr_cntrl #(
				  .DW    (DW),
				  .AW    (AW),						  
   				  .DEPTH (DEPTH))
	 gen_wr_cntrl
	   (
	  	// Outputs
	  	.wr_used_space					(wr_used_space[AW:0]),
	  	.wr_full						(wr_full),
	  	.mem_wr_en						(mem_wr_en),
	  	.mem_wr_addr					(mem_wr_addr[AW-1:0]),
	  	.wr_num_of_writes				(wr_num_of_writes[AW:0]),
	  	// Inputs
	  	.wr_clk							(wr_clk),
		.wr_rst_n						(wr_rst_n),
	  	.wr_en							(wr_en),
	  	.wr_num_of_reads				(wr_num_of_reads[AW:0]));
   
   gen_rd_cntrl #(
				  .DW    (DW),
				  .AW    (AW),						  
   				  .DEPTH (DEPTH),
				  .DELAY (DELAY))
	 gen_rd_cntrl
	   (
	  	// Outputs
	  	.rd_used_space					(rd_used_space[AW:0]),
	  	.rd_empty						(rd_empty),
	  	.rd_data						({rd_data, rd_ecc_err}),
	  	.mem_rd_en						(mem_rd_en),
	  	.mem_rd_addr					(mem_rd_addr[AW-1:0]),
	  	.rd_num_of_reads				(rd_num_of_reads[AW:0]),
	  	// Inputs
	  	.rd_clk							(rd_clk),
		.rd_rst_n						(rd_rst_n),
	  	.rd_en							(rd_en),
	  	.mem_rd_data					({mem_rd_data, mem_rd_ecc_err}),
	  	.rd_num_of_writes				(rd_num_of_writes[AW:0]));
   
   
   gen_sync_gray #(
				   .DW (AW+1),
				   .SYNC (SYNC))
	rd_wr_sync_gray
	   (
		// Outputs
		.dst_num         				(wr_num_of_reads),
		// Inputs
		.src_clk						(rd_clk),
		.src_rst_n						(rd_rst_n),
		.src_num 						(rd_num_of_reads),
		.dst_clk						(wr_clk),
		.dst_rst_n						(wr_rst_n));

   gen_sync_gray #(
				   .DW (AW+1),
				   .SYNC (SYNC))
	 wr_rd_sync_gray
	   (
		// Outputs
		.dst_num				        (rd_num_of_writes),
		// Inputs
		.src_clk						(wr_clk),
		.src_rst_n						(wr_rst_n),
		.src_num						(wr_num_of_writes),
		.dst_clk						(rd_clk),
		.dst_rst_n						(rd_rst_n));
   
endmodule 











