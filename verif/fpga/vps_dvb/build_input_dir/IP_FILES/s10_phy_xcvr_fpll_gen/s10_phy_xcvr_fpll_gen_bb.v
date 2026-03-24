module s10_phy_xcvr_fpll_gen (
		input  wire       pll_refclk0,       //       pll_refclk0.clk
		output wire       tx_serial_clk,     //     tx_serial_clk.clk
		output wire       pll_locked,        //        pll_locked.pll_locked
		output wire       pll_pcie_clk,      //      pll_pcie_clk.pll_pcie_clk
		output wire       pll_cal_busy,      //      pll_cal_busy.pll_cal_busy
		output wire [5:0] tx_bonding_clocks  // tx_bonding_clocks.clk
	);
endmodule

