module pcie_gen2_fPLL (
		input  wire  pll_refclk0,   //   pll_refclk0.clk
		output wire  tx_serial_clk, // tx_serial_clk.clk
		output wire  pll_locked,    //    pll_locked.pll_locked
		output wire  pll_pcie_clk,  //  pll_pcie_clk.pll_pcie_clk
		output wire  pll_cal_busy   //  pll_cal_busy.pll_cal_busy
	);
endmodule

