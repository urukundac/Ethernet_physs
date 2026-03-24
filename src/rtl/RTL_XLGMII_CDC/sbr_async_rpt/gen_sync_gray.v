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
 This module takes a binary number from source clock domain and sends it to destination clock domain.
 The clock domain transition is done thurogh gray code and 2 synchronization FF's, in order to prevent unexpected values.
 There is no assumption on the clock frequencies.
 
 ==============================================================================*/

module  gen_sync_gray 
  #(parameter 
	DW  = 7,
	SYNC  = 1'b0)
	(
   	 input 	         src_clk,
	 input 	         src_rst_n,
	 input [DW-1:0]  src_num,
	 input 	         dst_clk,
	 input 	         dst_rst_n,
	 output [DW-1:0] dst_num 
	 );
   
   reg [DW-1:0] 	 src_gray;
   wire [DW-1:0] 	 dst_gray ; 

   //MUST SAMPLE the gray number otherwise dst_clk will sample gliches 
   //since bin2gray(src_num) can get invalid values before gray computation ends
   //REMEMBER: 1 bit change is only between two valid gray values.
   always @(posedge src_clk or negedge src_rst_n)
     if (~src_rst_n)
       src_gray <= {DW{1'h0}};
     else
       src_gray <= bin2gray(src_num); 

/* -----\/----- EXCLUDED -----\/-----
 sync_bus #(.DW (DW))
	sync_bus
	  (
	 // Outputs
	 .out								(dst_gray),
	 // Inputs
	 .clk								(dst_clk),
	 .rstn								(dst_rst_n),
	 .in								(src_gray));
 -----/\----- EXCLUDED -----/\----- */

  
   gen_sync_ta2tb #(
					.BUS_WIDTH    (DW),
					.SYN_MS_DELAY (2))
	 gen_sync_ta2tb
	   (
		// Outputs
		.toggle_out						(dst_gray),
		// Inputs
		.toggle_in						(src_gray),
		.clkb							(dst_clk),
		.rst_n_b						(dst_rst_n));

     
   assign 			 dst_num = SYNC ? src_num : gray2bin(dst_gray);
   
   //-------------------Gray <-> Bin functions--------------------------------------
   function automatic [DW-1:0]  bin2gray ;
	  input[DW-1:0] bin;
	  bin2gray = bin ^ {1'b0, bin[DW-1:1]};
   endfunction
   
   function automatic [DW-1:0]  gray2bin ;//(max latency ceil(Log2(DW))*Xor)
	  input [DW-1:0] gray ;
	  integer i ;
	  for(i=0; i<=DW-1; i=i+1)
        gray2bin[i] = ^(gray >> i);
   endfunction
   //------------------------------------------------------------------------------ 
endmodule
