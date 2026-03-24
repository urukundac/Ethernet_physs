	component s10_phy_xcvr_fpll_gen is
		port (
			pll_refclk0       : in  std_logic                    := 'X'; -- clk
			tx_serial_clk     : out std_logic;                           -- clk
			pll_locked        : out std_logic;                           -- pll_locked
			pll_pcie_clk      : out std_logic;                           -- pll_pcie_clk
			pll_cal_busy      : out std_logic;                           -- pll_cal_busy
			tx_bonding_clocks : out std_logic_vector(5 downto 0)         -- clk
		);
	end component s10_phy_xcvr_fpll_gen;

	u0 : component s10_phy_xcvr_fpll_gen
		port map (
			pll_refclk0       => CONNECTED_TO_pll_refclk0,       --       pll_refclk0.clk
			tx_serial_clk     => CONNECTED_TO_tx_serial_clk,     --     tx_serial_clk.clk
			pll_locked        => CONNECTED_TO_pll_locked,        --        pll_locked.pll_locked
			pll_pcie_clk      => CONNECTED_TO_pll_pcie_clk,      --      pll_pcie_clk.pll_pcie_clk
			pll_cal_busy      => CONNECTED_TO_pll_cal_busy,      --      pll_cal_busy.pll_cal_busy
			tx_bonding_clocks => CONNECTED_TO_tx_bonding_clocks  -- tx_bonding_clocks.clk
		);

