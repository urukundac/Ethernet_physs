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
 asynchronous FIFO read control logic.
 Based on continously syncing number of reads to write domain and vice versa.
 
 
 ===========================================================================*/

module gen_rd_cntrl
  #(parameter 
 	DW  = 8,  
 	AW = 5,  
 	DEPTH  = 32,
	DELAY = 1'b1,
	SYNC = 0) 
 	(
 	
	 //Read 
	 input                 rd_rst_n, 
	 input                 rd_clk,
	 input                 rd_en,
	 output [AW:0]         rd_used_space,
	 output                rd_empty,
	 output [DW:0]         rd_data,
 	
	 //Memory
	 output                mem_rd_en,
	 output reg [AW-1:0]   mem_rd_addr,
	 input [DW:0]          mem_rd_data,

	 //Gray
	 output [AW:0]	       rd_num_of_reads,
	 input [AW:0] 		   rd_num_of_writes
	 );

  localparam 			   DEPTH_M1 = DEPTH - 1;

  wire [AW:0] 			   rd_num_of_writes_diff;
  reg [AW:0] 			   rd_num_of_writes_1d;
  reg [AW:0] 			   rd_num_of_reads_counter;
  
  reg [AW:0] 			   rd_mem_used_space;
  
  wire 					   rd_vld_s0;
  wire 					   rd_en_vld;
  wire 					   rd_en_s0;

  assign 				   mem_rd_en = rd_en_s0;
  wire [DW:0]                              rd_data_w;

  generate
    if (DELAY) begin: add_sample
      
      // warious signals needed only in case DELAY = 1
      reg [DW:0]                           mem_rd_data_1d          ;
      reg [AW:0]                           rd_used_space_2d        ;
      reg [AW:0]                           rd_num_of_writes_diff_1d;
      reg                                  rd_vld_s1               ;
      reg                                  rd_vld_s2               ;      
      wire                                 rd_en_s1                ;
      wire                                 rd_en_s2                ;    
      
      assign rd_en_s0      = rd_en_s1 & rd_vld_s0                  ;
      assign rd_empty      = ~rd_vld_s2                            ;
      assign rd_en_s1      = rd_en_s2  | (rd_vld_s0 & ~rd_vld_s1)  ;
      assign rd_en_s2      = rd_en_vld | (rd_vld_s1 & ~rd_vld_s2)  ;       
      assign rd_data_w     = mem_rd_data_1d                        ;
      assign rd_used_space = rd_used_space_2d                      ;

      always @ (posedge rd_clk or negedge rd_rst_n)
	if (~rd_rst_n) 
          mem_rd_data_1d <= {DW+1{1'h0}}                           ;
	else if (rd_en_s2 & rd_vld_s1) 
          mem_rd_data_1d <= mem_rd_data                            ;
      
      always @ (posedge rd_clk or negedge rd_rst_n)
        if      (~rd_rst_n) rd_vld_s1 <= 1'h0                      ;
	else if (rd_en_s1 ) rd_vld_s1 <= rd_vld_s0                 ;
      
      always @ (posedge rd_clk or negedge rd_rst_n)
	if      (~rd_rst_n) rd_vld_s2 <= 1'h0                      ;
	else if (rd_en_s2 ) rd_vld_s2 <= rd_vld_s1                 ;

      // The perpose of this delay is to make sure that rd_empty and rd_used_space are in sync
      always @ (posedge rd_clk or negedge rd_rst_n)
        if (~rd_rst_n) begin
          rd_num_of_writes_diff_1d <= {AW+1{1'h0}};
          rd_used_space_2d         <= {AW+1{1'h0}};
        end else begin
          rd_num_of_writes_diff_1d <= rd_num_of_writes_diff;
          rd_used_space_2d         <= rd_used_space_2d - {{AW{1'b0}}, rd_en_vld} + rd_num_of_writes_diff_1d;
        end    

    end else begin: no_sample // block: add_sample
      
      assign rd_en_s0      = rd_en_vld                             ;
      assign rd_empty      = (rd_mem_used_space == 0)              ;
      assign rd_data_w     = mem_rd_data                           ;
      assign rd_used_space = rd_mem_used_space                     ;
      
    end // else: !if(DELAY)
  endgenerate
    
    
  // Read domain logic:
  // Read logic contains 3 pipe stages: s0, s1, s2, each one has valid and enable signals.
  assign 				   rd_vld_s0 = ~(rd_mem_used_space == 0);
//  assign 				   rd_en_s0 = DELAY ? (rd_en_s1 & rd_vld_s0) : rd_en_vld;
  
  always @ (posedge rd_clk or negedge rd_rst_n)
    if (~rd_rst_n) 
      rd_mem_used_space <= {AW+1{1'h0}};
    else begin
      rd_mem_used_space <= rd_mem_used_space - {{AW{1'b0}}, rd_en_s0} + rd_num_of_writes_diff;
    end
  
  always @ (posedge rd_clk or negedge rd_rst_n)
    if (~rd_rst_n)
      mem_rd_addr <=  {AW{1'h0}};
    else if (rd_en_s0)
      mem_rd_addr <=  (mem_rd_addr == DEPTH_M1[AW-1:0]) ? {AW{1'h0}} : mem_rd_addr + 1'b1;
    
//  assign 				   rd_empty  = DELAY ? ~rd_vld_s2 : (rd_mem_used_space == 0);
  assign 				   rd_en_vld = rd_en & ~rd_empty;

//  wire [DW:0] 			   rd_data_w = DELAY ? mem_rd_data_1d : mem_rd_data;
  
  ctech_lib_mux_2to1 ctech_lib_mux_2to1[DW:0] (.d1 (rd_data_w), .d2 ({DW+1{1'h0}}), .s (~rd_empty), .o (rd_data));

//  always @(*)
//	rd_used_space = DELAY ? rd_used_space_2d : rd_mem_used_space;
  
  always @(posedge rd_clk or negedge rd_rst_n)
    if (~rd_rst_n)
      rd_num_of_writes_1d <= {AW+1{1'h0}};
    else 
      rd_num_of_writes_1d <= rd_num_of_writes;
  
  assign 	  rd_num_of_writes_diff = (rd_num_of_writes - rd_num_of_writes_1d);
  
  wire [AW:0] 	  next_rd_num_of_reads = rd_num_of_reads_counter + 1'h1;
  
  always @ (posedge rd_clk or negedge rd_rst_n)
    if (~rd_rst_n)
      rd_num_of_reads_counter <= {AW+1{1'h0}};
    else if (rd_en_vld)
      rd_num_of_reads_counter <= next_rd_num_of_reads;
  
  //in case of reading in current cycle we can improve fifo response time by sending next_rd_counter
  assign 	  rd_num_of_reads = rd_en_vld ? next_rd_num_of_reads : rd_num_of_reads_counter;
  
  //OVL Assertions
`ifdef ECIP_OVL_ON
  
  // Check : write while fifo is full 
  assert_never #(1, 0, "Attempting to read from an empty FIFO")  rd_when_empty(rd_clk, rd_rst_n, rd_empty & rd_en);
  
`endif //  `ifdef OVL_ON
  
endmodule 
