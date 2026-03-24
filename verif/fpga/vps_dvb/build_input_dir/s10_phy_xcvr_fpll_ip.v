module s10_phy_xcvr_fpll_ip (
		input  wire       pll_refclk0,       
		output wire       tx_serial_clk,     
		output wire       pll_locked,        
		output wire       pll_pcie_clk,      
		output wire       pll_cal_busy,      
		output wire [5:0] tx_bonding_clocks  
	);

	s10_phy_xcvr_fpll_gen u0 (
		.pll_refclk0       (pll_refclk0),       
		.tx_serial_clk     (tx_serial_clk),     
		.pll_locked        (pll_locked),        
		.pll_pcie_clk      (pll_pcie_clk),      
		.pll_cal_busy      (pll_cal_busy),      
		.tx_bonding_clocks (tx_bonding_clocks)  
	);

endmodule

