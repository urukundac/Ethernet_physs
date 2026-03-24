module altera_16x1 (
		input  wire  data,    //  fifo_input.datain
		input  wire  wrreq,   //            .wrreq
		input  wire  rdreq,   //            .rdreq
		input  wire  wrclk,   //            .wrclk
		input  wire  rdclk,   //            .rdclk
		input  wire  aclr,    //            .aclr
		output wire  q,       // fifo_output.dataout
		output wire  rdempty, //            .rdempty
		output wire  wrfull   //            .wrfull
	);
endmodule

