module i2c_master_inst_reset_bfm_ip #(
		parameter ASSERT_HIGH_RESET    = 0,
		parameter INITIAL_RESET_CYCLES = 50
	) (
		output wire  reset, // reset.reset_n
		input  wire  clk    //   clk.clk
	);
endmodule

