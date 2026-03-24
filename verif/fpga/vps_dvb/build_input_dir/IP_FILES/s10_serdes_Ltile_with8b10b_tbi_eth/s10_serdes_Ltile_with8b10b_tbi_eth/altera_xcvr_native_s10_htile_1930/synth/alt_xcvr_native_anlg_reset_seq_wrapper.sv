// (C) 2001-2024 Intel Corporation. All rights reserved.
// Your use of Intel Corporation's design tools, logic functions and other 
// software and tools, and its AMPP partner logic functions, and any output 
// files from any of the foregoing (including device programming or simulation 
// files), and any associated documentation or information are expressly subject 
// to the terms and conditions of the Intel Program License Subscription 
// Agreement, Intel FPGA IP License Agreement, or other applicable 
// license agreement, including, without limitation, that your use is for the 
// sole purpose of programming logic devices manufactured by Intel and sold by 
// Intel or its authorized distributors.  Please refer to the applicable 
// agreement for further details.


`timescale 1ps/1ps

module alt_xcvr_native_anlg_reset_seq_wrapper
#(	
	parameter CLK_FREQ_IN_HZ = 100000000,
	parameter DEFAULT_RESET_SEPARATION_NS = 100,
	parameter TX_ANALOG_RESET_SEPARATION_NS = 100,	
	parameter RX_ANALOG_RESET_SEPARATION_NS = 100,	
	parameter ENABLE_RESET_SEQUENCER = 0,	
	parameter TX_ENABLE = 1,
	parameter RX_ENABLE = 1,	
	parameter NUM_CHANNELS = 1,
	parameter REDUCED_RESET_SIM_TIME = 0
)(    
	input wire  [NUM_CHANNELS-1:0] tx_analog_reset,
	input wire  [NUM_CHANNELS-1:0] rx_analog_reset,	
	output wire [NUM_CHANNELS-1:0] tx_analogreset_stat,
	output wire [NUM_CHANNELS-1:0] rx_analogreset_stat,	
	output wire [NUM_CHANNELS-1:0] tx_analog_reset_out,
	output wire [NUM_CHANNELS-1:0] rx_analog_reset_out	
);

wire clk;
wire reset_n;

//***************************************************************************
// Getting the clock from Master TRS
//***************************************************************************
altera_s10_xcvr_clkout_endpoint clock_endpoint (	
	.clk_out(clk)
);	

//***************************************************************************
// Need to self-generate internal reset signal
//***************************************************************************
alt_xcvr_resync_std #(
	.SYNC_CHAIN_LENGTH(3),
	.INIT_VALUE(0)
) reset_n_generator (
	.clk	 (clk),
	.reset (1'b0),
	.d		 (1'b1),
	.q		 (reset_n)
);

//***************************************************************************
//*********************** Reset sequencer************************************
genvar ig;
generate	
	if (ENABLE_RESET_SEQUENCER) begin : g_trs		
		if (TX_ENABLE) begin
			// tx_analog_reset
			alt_xcvr_native_anlg_reset_seq #(	
				.CLK_FREQ_IN_HZ					      (CLK_FREQ_IN_HZ),
				.DEFAULT_RESET_SEPARATION_NS	(DEFAULT_RESET_SEPARATION_NS),
				.RESET_SEPARATION_NS			    (TX_ANALOG_RESET_SEPARATION_NS),	
				.NUM_RESETS						        (NUM_CHANNELS),
				.REDUCED_RESET_SIM_TIME       (REDUCED_RESET_SIM_TIME)
			) tx_anlg_reset_seq (
				.clk				    (clk),		
				.reset_n			  (reset_n),
				.reset_in			  (tx_analog_reset),
				.reset_out			(tx_analog_reset_out),
				.reset_stat_out	(tx_analogreset_stat)
			);

		end else begin
		   assign tx_analog_reset_out = {NUM_CHANNELS{1'b0}};
		   assign tx_analogreset_stat = {NUM_CHANNELS{1'b0}};
		end
		
		if (RX_ENABLE) begin
			// rx_analog_reset
			alt_xcvr_native_anlg_reset_seq #(	
				.CLK_FREQ_IN_HZ					      (CLK_FREQ_IN_HZ),
				.DEFAULT_RESET_SEPARATION_NS	(DEFAULT_RESET_SEPARATION_NS),
				.RESET_SEPARATION_NS			    (RX_ANALOG_RESET_SEPARATION_NS),	
				.NUM_RESETS						        (NUM_CHANNELS),
				.REDUCED_RESET_SIM_TIME       (REDUCED_RESET_SIM_TIME)
			) rx_anlg_reset_seq (
				.clk				    (clk),		
				.reset_n			  (reset_n),
				.reset_in			  (rx_analog_reset),
				.reset_out			(rx_analog_reset_out),
				.reset_stat_out	(rx_analogreset_stat)
			);

		end else begin
		   assign rx_analog_reset_out = {NUM_CHANNELS{1'b0}};
		   assign rx_analogreset_stat = {NUM_CHANNELS{1'b0}};
		end
	end else begin : g_no_trs
		
		assign tx_analogreset_stat = tx_analog_reset;	
		assign rx_analogreset_stat = rx_analog_reset;		
		assign tx_analog_reset_out = tx_analog_reset;
		assign rx_analog_reset_out = rx_analog_reset;

	end

endgenerate

//******************* End reset sequencer ***********************************
//***************************************************************************

endmodule
`ifdef QUESTA_INTEL_OEM
`pragma questa_oem_00 "MocC+nkhFhePL/9qgEzZn0SajvBvou23SRhf0e7alxp2+Eg8cG+8O3rIsaa3uy4rlibLR7ualZ/IzvJw8+XvhZ3gE5PxCqhr+zs18tOIP9n5Rwh5U0VHqAiFBy02UJFOa67T+C+2bMwh1tKCmgl0c9Mnpd56IdQcqy+adIEsnGMrc164vYVc1inzeRy38ICnJ/ols66Cg/Ju6ZJPIcE4dq5IKR6Y1W/f2JG2OlDto/APQCU4ZXtxdvCLkkBWGQUjURjN3r29Bd/4efw1vrkgIoDUwCkgQCSMguTPeA3W8Y+6KSVvVmYe20WoFhPZoJhNA8/1rgXcJI4VXzZodtef1q+MkToEnDDoCjOer3BaH2vxae5+sAC6LODvcIGwfgx99hzkf/3TXm4Q5XMH8Ar+1vqBEWKczXLgnwqPSlOdu/4jwg5yPvMrS47weqtZHej49LU7oePczfdfCFpfqQA0xSa2BHI+QPsprT0TCElmRo72R/mEE3v5nUStc8TF2Xz7AL+sI4vOBFzw/F8f0d8uBo8tarB14VTUJ4Oewt4DgkWmakzibP4cv8f05A3JjDgQs06vgHb+qygAQt37bVEjxviEhcbYj1oz/bOS5O2elJZ6+bWKKD6XmpJS/zwkeg0NMONB0iz9FGTaipfXy7UBbJJRcBmAN0MEakFNeLeWwrQszKx9xDWJr4iUoE4VHvkyyVXIji63TQnzP61oNbUd1sa6E7jV52XHEviDBI2rGXh78Fc8RAiOHs+jGydC568v2RAwJBVr0Edg09neO2sVPuxVxygCZgecn71M8Yvz9zovSzVh7HUl9/lEd40FGJS517pOKnbVVilTy4/66dcC6MtIgRB/h1HEw68MfeLMNK5mTJbcir6C33Sh5UHeKqcycK4Anbp+k7KgltLnppBEahZJ7CbXvTAN/GZ9MLjQ5RlZtZHglKvQRbpHSuLpQPbQRNKyUF5UXxygUqPhkKbH6Q4gscF0EwHFs6IODydv1U36ipSU8xQ75G12KaV5/DrI"
`endif