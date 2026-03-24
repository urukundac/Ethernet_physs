module DW01_sub (A, B, CI, DIFF, CO);

   parameter width=4;

   input [ width-1 : 0]  A, B; 
   input 		 CI;
   
   output [ width-1 : 0] DIFF;   
   output 		 CO;   

   
   wire [width : 0] 	 tmp_out;
   
   assign tmp_out = A-B-CI;
   assign CO = tmp_out[width];
   assign DIFF = tmp_out[width-1:0];

endmodule
