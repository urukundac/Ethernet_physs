	i2c_ip_inst_conduit_end_bfm_ip u0 (
		.sig_conduit_data_in (_connected_to_sig_conduit_data_in_), //  output,  width = 1, conduit.conduit_data_in
		.sig_conduit_clk_in  (_connected_to_sig_conduit_clk_in_),  //  output,  width = 1,        .conduit_clk_in
		.sig_conduit_data_oe (_connected_to_sig_conduit_data_oe_), //   input,  width = 1,        .conduit_data_oe
		.sig_conduit_clk_oe  (_connected_to_sig_conduit_clk_oe_)   //   input,  width = 1,        .conduit_clk_oe
	);

