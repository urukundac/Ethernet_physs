	mdio_ethernet_ip #(
		.MDC_DIVISOR (INTEGER_VALUE_FOR_MDC_DIVISOR)
	) u0 (
		.clk             (_connected_to_clk_),             //   input,   width = 1,       clock.clk
		.reset           (_connected_to_reset_),           //   input,   width = 1, clock_reset.reset
		.csr_write       (_connected_to_csr_write_),       //   input,   width = 1,         csr.write
		.csr_read        (_connected_to_csr_read_),        //   input,   width = 1,            .read
		.csr_address     (_connected_to_csr_address_),     //   input,   width = 6,            .address
		.csr_writedata   (_connected_to_csr_writedata_),   //   input,  width = 32,            .writedata
		.csr_readdata    (_connected_to_csr_readdata_),    //  output,  width = 32,            .readdata
		.csr_waitrequest (_connected_to_csr_waitrequest_), //  output,   width = 1,            .waitrequest
		.mdc             (_connected_to_mdc_),             //  output,   width = 1,        mdio.mdc
		.mdio_in         (_connected_to_mdio_in_),         //   input,   width = 1,            .mdio_in
		.mdio_out        (_connected_to_mdio_out_),        //  output,   width = 1,            .mdio_out
		.mdio_oen        (_connected_to_mdio_oen_)         //  output,   width = 1,            .mdio_oen
	);

