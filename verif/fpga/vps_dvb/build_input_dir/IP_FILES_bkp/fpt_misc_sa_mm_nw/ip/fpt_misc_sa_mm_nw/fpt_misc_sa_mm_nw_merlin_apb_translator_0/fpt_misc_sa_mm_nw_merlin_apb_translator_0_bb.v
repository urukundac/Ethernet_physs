module fpt_misc_sa_mm_nw_merlin_apb_translator_0 #(
		parameter ADDR_WIDTH     = 13,
		parameter DATA_WIDTH     = 32,
		parameter USE_S0_PADDR31 = 0,
		parameter USE_M0_PADDR31 = 0,
		parameter USE_M0_PSLVERR = 0
	) (
		input  wire [12:0] s0_paddr,   //        s0.paddr
		input  wire        s0_psel,    //          .psel
		input  wire        s0_penable, //          .penable
		input  wire        s0_pwrite,  //          .pwrite
		input  wire [31:0] s0_pwdata,  //          .pwdata
		output wire [31:0] s0_prdata,  //          .prdata
		output wire        s0_pslverr, //          .pslverr
		output wire        s0_pready,  //          .pready
		input  wire        clk,        //       clk.clk
		input  wire        reset,      // clk_reset.reset
		output wire [12:0] m0_paddr,   //        m0.paddr
		output wire        m0_psel,    //          .psel
		output wire        m0_penable, //          .penable
		output wire        m0_pwrite,  //          .pwrite
		output wire [31:0] m0_pwdata,  //          .pwdata
		input  wire [31:0] m0_prdata,  //          .prdata
		input  wire        m0_pready   //          .pready
	);
endmodule

