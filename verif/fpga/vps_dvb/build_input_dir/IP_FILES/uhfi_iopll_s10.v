module uhfi_iopll_s10 (
		input  wire  rst,      
		input  wire  refclk,   
		output wire  locked,   
		output wire  outclk_0, 
		output wire  outclk_1, 
		output wire  outclk_2, 
		output wire  outclk_3  
	);

	uhfi_iopll_s10_gen u0 (
		.rst      (rst),      
		.refclk   (refclk),   
		.locked   (locked),   
		.outclk_0 (outclk_0), 
		.outclk_1 (outclk_1), 
		.outclk_2 (outclk_2), 
		.outclk_3 (outclk_3)  
	);

endmodule

