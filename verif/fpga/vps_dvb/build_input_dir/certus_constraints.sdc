set_data_delay  -override  10  -from wrapper|U_PHY_INFRA_MACRO_PD_RED_MACRO_RCM_MMI64|PHY_INFRA_MACRO_PD_inst|U_PROFPGA_CTRL|CLK0_PLL|iopll_0_outclk3     -to    part|uhfi|uhfi_pcie_ctrl|i_pcie_bridge_top|u_phy_top|genblk1.pcie_phy_wrapper|pipe_gen1_x4|u0|tx_clkout|ch0
set_false_path  -hold                  -from wrapper|U_PHY_INFRA_MACRO_PD_RED_MACRO_RCM_MMI64|PHY_INFRA_MACRO_PD_inst|U_PROFPGA_CTRL|CLK0_PLL|iopll_0_outclk3     -to    part|uhfi|uhfi_pcie_ctrl|i_pcie_bridge_top|u_phy_top|genblk1.pcie_phy_wrapper|pipe_gen1_x4|u0|tx_clkout|ch0

