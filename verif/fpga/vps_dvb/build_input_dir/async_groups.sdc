#jmoctezu (7-May) , from Jayaram:
#set pcie_pipe_clk_name1 {part|uhfi|uhfi_pcie_ctrl|i_pcie_bridge_top|u_phy_top|genblk1.pcie_phy_wrapper|pipe_gen1_x4|u0|tx_clkout|ch0}
#set pcie_pipe_clk_name2 {part|uhfi|uhfi_pcie_ctrl|i_pcie_bridge_top|u_phy_top|_genblk1_2epcie__phy__wrapper_.pipe_gen1_x4|u0|tx_pcs_x2_clk|ch1}
#set pcie_pipe_clk_name3 {part|uhfi|uhfi_pcie_ctrl|i_pcie_bridge_top|u_phy_top|_genblk1_2epcie__phy__wrapper_.pipe_gen1_x4|u0|tx_clkout|ch0}
#set pcie_pipe_clk_name4 {part|uhfi|uhfi_pcie_ctrl|i_pcie_bridge_top|u_phy_top|_genblk1_2epcie__phy__wrapper_.pipe_gen1_x4|u0|tx_clkout|ch0}

#set_false_path -from [get_clocks side_clk] -to   [get_clocks ${pcie_pipe_clk_name1}]
#set_false_path -to   [get_clocks side_clk] -from [get_clocks ${pcie_pipe_clk_name1}]
#set_false_path -from [get_clocks side_clk] -to   [get_clocks ${pcie_pipe_clk_name2}]
#set_false_path -to   [get_clocks side_clk] -from [get_clocks ${pcie_pipe_clk_name2}]
#set_false_path -from [get_clocks side_clk] -to   [get_clocks ${pcie_pipe_clk_name3}]
#set_false_path -to   [get_clocks side_clk] -from [get_clocks ${pcie_pipe_clk_name3}]
set_false_path -from [get_clocks side_clk] -to   [get_clocks part|uhfi|uhfi_pcie_ctrl|i_pcie_bridge_top|u_phy_top*]
set_false_path -to   [get_clocks side_clk] -from [get_clocks part|uhfi|uhfi_pcie_ctrl|i_pcie_bridge_top|u_phy_top*]

