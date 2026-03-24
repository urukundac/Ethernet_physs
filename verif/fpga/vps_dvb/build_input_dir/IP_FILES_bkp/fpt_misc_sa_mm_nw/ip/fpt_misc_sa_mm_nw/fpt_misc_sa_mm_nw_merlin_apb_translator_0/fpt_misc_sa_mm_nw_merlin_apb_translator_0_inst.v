	fpt_misc_sa_mm_nw_merlin_apb_translator_0 #(
		.ADDR_WIDTH     (INTEGER_VALUE_FOR_ADDR_WIDTH),
		.DATA_WIDTH     (INTEGER_VALUE_FOR_DATA_WIDTH),
		.USE_S0_PADDR31 (BOOLEAN_VALUE_FOR_USE_S0_PADDR31),
		.USE_M0_PADDR31 (BOOLEAN_VALUE_FOR_USE_M0_PADDR31),
		.USE_M0_PSLVERR (BOOLEAN_VALUE_FOR_USE_M0_PSLVERR)
	) u0 (
		.s0_paddr   (_connected_to_s0_paddr_),   //   input,  width = 13,        s0.paddr
		.s0_psel    (_connected_to_s0_psel_),    //   input,   width = 1,          .psel
		.s0_penable (_connected_to_s0_penable_), //   input,   width = 1,          .penable
		.s0_pwrite  (_connected_to_s0_pwrite_),  //   input,   width = 1,          .pwrite
		.s0_pwdata  (_connected_to_s0_pwdata_),  //   input,  width = 32,          .pwdata
		.s0_prdata  (_connected_to_s0_prdata_),  //  output,  width = 32,          .prdata
		.s0_pslverr (_connected_to_s0_pslverr_), //  output,   width = 1,          .pslverr
		.s0_pready  (_connected_to_s0_pready_),  //  output,   width = 1,          .pready
		.clk        (_connected_to_clk_),        //   input,   width = 1,       clk.clk
		.reset      (_connected_to_reset_),      //   input,   width = 1, clk_reset.reset
		.m0_paddr   (_connected_to_m0_paddr_),   //  output,  width = 13,        m0.paddr
		.m0_psel    (_connected_to_m0_psel_),    //  output,   width = 1,          .psel
		.m0_penable (_connected_to_m0_penable_), //  output,   width = 1,          .penable
		.m0_pwrite  (_connected_to_m0_pwrite_),  //  output,   width = 1,          .pwrite
		.m0_pwdata  (_connected_to_m0_pwdata_),  //  output,  width = 32,          .pwdata
		.m0_prdata  (_connected_to_m0_prdata_),  //   input,  width = 32,          .prdata
		.m0_pready  (_connected_to_m0_pready_)   //   input,   width = 1,          .pready
	);

