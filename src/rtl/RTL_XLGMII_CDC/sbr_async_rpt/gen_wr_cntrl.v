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
 asynchronous FIFO write control logic.
 Based on continously syncing number of reads to write domain and vice versa.
 
 
 ===========================================================================*/

module gen_wr_cntrl
  #(parameter 
 	DW  = 8,  
 	AW = 5,  
 	DEPTH  = 32,
	SYNC = 0) 
 	(
 	
	 //Write
	 input               wr_rst_n, 
	 input               wr_clk,
	 input               wr_en,
	 output reg [AW:0]   wr_used_space,
	 output reg          wr_full,

	 //MEM
	 output              mem_wr_en,
	 output reg [AW-1:0] mem_wr_addr,

	 //Gray
	 output [AW:0]       wr_num_of_writes,
	 input [AW:0]        wr_num_of_reads
	 );

  reg [AW:0]                 wr_num_of_reads_1d;
  reg [AW:0]                 wr_num_of_writes_counter;
  wire [AW:0]                wr_num_of_reads_diff;
  wire [AW:0]                next_wr_used_space;

  localparam 	             DEPTH_M1 = DEPTH - 1;
  localparam                 C1 = 1              ;
  
  assign 				   mem_wr_en  = wr_en & ~wr_full; 
  assign 				   next_wr_used_space = wr_used_space - wr_num_of_reads_diff + {{AW{1'b0}}, mem_wr_en};
  assign 				   wr_num_of_reads_diff = (wr_num_of_reads - wr_num_of_reads_1d);
  
  always @(posedge wr_clk or negedge wr_rst_n) 
    if (~wr_rst_n) begin
      wr_used_space <= {AW+1{1'h0}};
      wr_full       <= 1'h0;
    end else begin
      wr_used_space <= next_wr_used_space;
      wr_full       <= (next_wr_used_space >= DEPTH);
    end

  always @(posedge wr_clk or negedge wr_rst_n) 
    if (~wr_rst_n) 
      mem_wr_addr <= {AW{1'h0}};
    else if (mem_wr_en)
      mem_wr_addr <= (mem_wr_addr == DEPTH_M1[AW-1:0]) ? {AW{1'h0}} : mem_wr_addr + C1[0+:AW];
  
  always @(posedge wr_clk or negedge wr_rst_n)
    if (~wr_rst_n)
      wr_num_of_reads_1d <= {AW+1{1'h0}};
    else 
      wr_num_of_reads_1d <= wr_num_of_reads;
  
  wire [AW:0]  next_wr_num_of_writes = wr_num_of_writes_counter + C1[AW:0];
  
  always @ (posedge wr_clk or negedge wr_rst_n)
	if (~wr_rst_n) 
	  wr_num_of_writes_counter <= {AW+1{1'h0}};
	else if (mem_wr_en)
	  wr_num_of_writes_counter <= next_wr_num_of_writes;
  
  //in case of writing in current cycle we can improve fifo response time by sending next_wr_counter
  assign 	   wr_num_of_writes = mem_wr_en ? next_wr_num_of_writes : wr_num_of_writes_counter;
  
  //OVL Assertions
`ifdef ECIP_OVL_ON
  
  // Check : write while fifo is full 
  assert_never #(1, 0, "Attempting to write to a full FIFO")  wr_when_full(wr_clk, wr_rst_n, wr_full & wr_en);
  
  
`endif //  `ifdef OVL_ON
  
endmodule 











