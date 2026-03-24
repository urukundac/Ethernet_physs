bypass_refiner_cutoff_check true
set_filling_rate -resources lut 0.65
#set_filling_rate -resources lutram  0.30
#set_filling_rate -resources lut 0.85
set_partition_iterations 100
set_auto_replication_timing -effort high -record -timestamp -timeout 1h
set_muxable_signal_types -half_cycle_path true
set_muxable_signal_types -async_reset true

#set_assignment [list {mki_wrapper} {mki} {mki_uncore_misc} {mci_cmn} {parcgu}] -targets [list MB2_FA1_F1] ;#fgt_fpga_transactors_top_RTLC_LONGMOD1
#set_assignment [list {mki_wrapper} {mki} {mki_uncore_misc} {mci_cmn} {parfuse}] -targets [list MB2_FA1_F2] ;#fgt_fpga_transactors_top_RTLC_LONGMOD1
#set_assignment [list {mki_wrapper} {mki} {mki_uncore_misc} {mci_cmn} {pargpio}] -targets [list MB2_FA2_F1] ;#fgt_fpga_transactors_top_RTLC_LONGMOD1
#set_assignment [list {mki_wrapper} {mki} {mki_uncore_misc} {mci_cmn} {parrst}] -targets [list MB2_FA2_F2] ;#fgt_fpga_transactors_top_RTLC_LONGMOD1
set_assignment {physs_eth physs0 parmquad0 pcs100_wrap_0 quadpcs100_0 U_PCS_TOP U_SGMII4x_USXGMII4x_INST U_SGMII_10B_0} -targets MB5_FA1_F2
set_assignment {physs_eth physs0 parmquad0 pcs100_wrap_0 quadpcs100_0 U_PCS_TOP U_SGMII4x_USXGMII4x_INST U_SGMII_10B_1} -targets MB5_FB1_F2
set_assignment {physs_eth physs0 parmquad0 pcs100_wrap_0 quadpcs100_0 U_PCS_TOP U_SGMII4x_USXGMII4x_INST U_SGMII_10B_2} -targets MB5_FA2_F2
set_assignment {physs_eth physs0 parmquad0 pcs100_wrap_0 quadpcs100_0 U_PCS_TOP U_SGMII4x_USXGMII4x_INST U_SGMII_10B_3} -targets MB5_FB2_F2
set_assignment {physs_eth physs0 parmquad1 pcs100_wrap_1 quadpcs100_1 U_PCS_TOP U_SGMII4x_USXGMII4x_INST U_SGMII_10B_0} -targets MB6_FA1_F2
set_assignment {physs_eth physs0 parmquad1 pcs100_wrap_1 quadpcs100_1 U_PCS_TOP U_SGMII4x_USXGMII4x_INST U_SGMII_10B_1} -targets MB6_FB1_F2
set_assignment {physs_eth physs0 parmquad1 pcs100_wrap_1 quadpcs100_1 U_PCS_TOP U_SGMII4x_USXGMII4x_INST U_SGMII_10B_2} -targets MB6_FA2_F2
set_assignment {physs_eth physs0 parmquad1 pcs100_wrap_1 quadpcs100_1 U_PCS_TOP U_SGMII4x_USXGMII4x_INST U_SGMII_10B_3} -targets MB6_FB2_F2


set_assignment [list physs_eth {GEN_PORT[0].A00_i2c}] -targets [list MB5_FA1_F2]; #imc_i2c_lib_Imc_DW_apb_i2c
set_assignment [list physs_eth {GEN_PORT[0].IW_sync_reset}] -targets [list MB5_FA1_F2]; #cnic_lib_10m_IW_sync_reset
set_assignment [list physs_eth {GEN_PORT[0].io_pll_125mhz_eth_clks}] -targets [list MB5_FA1_F2]; #io_pll_125mhz_eth_clks
set_assignment [list physs_eth {GEN_PORT[0].phy_i2c_vapb_master}] -targets [list MB5_FA1_F2]; #cnic_lib_10m_RED_VAPB_APB_ADDRESS_WIDTH_12_APB_DATA_WIDTH_32_DUT_CLK_PROVIDED_1_33744078aeb3775222139608063c1a5d_redUniq_2
set_assignment [list physs_eth {GEN_PORT[0].phy_regbank}] -targets [list MB5_FA1_F2]; #cnic_lib_10m_RED_VAPB_APB_ADDRESS_WIDTH_12_APB_DATA_WIDTH_32_DUT_CLK_PROVIDED_1_33744078aeb3775222139608063c1a5d_redUniq_1_2
set_assignment [list physs_eth {GEN_PORT[0].u0_ethernet_altera_phy}] -targets [list MB5_FA1_F2]; #rtlc__ethernet_altera_phy__ca__cp__625
set_assignment [list physs_eth {GEN_PORT[0].u_phy_regbank}] -targets [list MB5_FA1_F2]; #rtlc__phy_regbank__ca__cp__17_b0c5beaebce0748a44d1395b08a1703c
set_assignment [list physs_eth {GEN_PORT[0].u_s10_fpll_ref125Mhz_625Mhz}] -targets [list MB5_FA1_F2]; #s10_fpll_ref125Mhz_625Mhz

set_assignment [list physs_eth {GEN_PORT[1].A00_i2c}] -targets [list MB5_FB1_F2]; #imc_i2c_lib_Imc_DW_apb_i2c
set_assignment [list physs_eth {GEN_PORT[1].IW_sync_reset}] -targets [list MB5_FB1_F2]; #cnic_lib_10m_IW_sync_reset
set_assignment [list physs_eth {GEN_PORT[1].io_pll_125mhz_eth_clks}] -targets [list MB5_FB1_F2]; #io_pll_125mhz_eth_clks
set_assignment [list physs_eth {GEN_PORT[1].phy_i2c_vapb_master}] -targets [list MB5_FB1_F2]; #cnic_lib_10m_RED_VAPB_APB_ADDRESS_WIDTH_12_APB_DATA_WIDTH_32_DUT_CLK_PROVIDED_1_33744078aeb3775222139608063c1a5d_redUniq_2
set_assignment [list physs_eth {GEN_PORT[1].phy_regbank}] -targets [list MB5_FB1_F2]; #cnic_lib_10m_RED_VAPB_APB_ADDRESS_WIDTH_12_APB_DATA_WIDTH_32_DUT_CLK_PROVIDED_1_33744078aeb3775222139608063c1a5d_redUniq_1_2
set_assignment [list physs_eth {GEN_PORT[1].u0_ethernet_altera_phy}] -targets [list MB5_FB1_F2]; #rtlc__ethernet_altera_phy__ca__cp__625
set_assignment [list physs_eth {GEN_PORT[1].u_phy_regbank}] -targets [list MB5_FB1_F2]; #rtlc__phy_regbank__ca__cp__17_b0c5beaebce0748a44d1395b08a1703c
set_assignment [list physs_eth {GEN_PORT[1].u_s10_fpll_ref125Mhz_625Mhz}] -targets [list MB5_FB1_F2]; #s10_fpll_ref125Mhz_625Mhz

set_assignment [list physs_eth {GEN_PORT[2].A00_i2c}] -targets [list MB5_FA2_F2]; #imc_i2c_lib_Imc_DW_apb_i2c
set_assignment [list physs_eth {GEN_PORT[2].IW_sync_reset}] -targets [list MB5_FA2_F2]; #cnic_lib_10m_IW_sync_reset
set_assignment [list physs_eth {GEN_PORT[2].io_pll_125mhz_eth_clks}] -targets [list MB5_FA2_F2]; #io_pll_125mhz_eth_clks
set_assignment [list physs_eth {GEN_PORT[2].phy_i2c_vapb_master}] -targets [list MB5_FA2_F2]; #cnic_lib_10m_RED_VAPB_APB_ADDRESS_WIDTH_12_APB_DATA_WIDTH_32_DUT_CLK_PROVIDED_1_33744078aeb3775222139608063c1a5d_redUniq_2
set_assignment [list physs_eth {GEN_PORT[2].phy_regbank}] -targets [list MB5_FA2_F2]; #cnic_lib_10m_RED_VAPB_APB_ADDRESS_WIDTH_12_APB_DATA_WIDTH_32_DUT_CLK_PROVIDED_1_33744078aeb3775222139608063c1a5d_redUniq_1_2
set_assignment [list physs_eth {GEN_PORT[2].u0_ethernet_altera_phy}] -targets [list MB5_FA2_F2]; #rtlc__ethernet_altera_phy__ca__cp__625
set_assignment [list physs_eth {GEN_PORT[2].u_phy_regbank}] -targets [list MB5_FA2_F2]; #rtlc__phy_regbank__ca__cp__17_b0c5beaebce0748a44d1395b08a1703c
set_assignment [list physs_eth {GEN_PORT[2].u_s10_fpll_ref125Mhz_625Mhz}] -targets [list MB5_FA2_F2]; #s10_fpll_ref125Mhz_625Mhz

set_assignment [list physs_eth {GEN_PORT[3].A00_i2c}] -targets [list MB5_FB2_F2]; #imc_i2c_lib_Imc_DW_apb_i2c
set_assignment [list physs_eth {GEN_PORT[3].IW_sync_reset}] -targets [list MB5_FB2_F2]; #cnic_lib_10m_IW_sync_reset
set_assignment [list physs_eth {GEN_PORT[3].io_pll_125mhz_eth_clks}] -targets [list MB5_FB2_F2]; #io_pll_125mhz_eth_clks
set_assignment [list physs_eth {GEN_PORT[3].phy_i2c_vapb_master}] -targets [list MB5_FB2_F2]; #cnic_lib_10m_RED_VAPB_APB_ADDRESS_WIDTH_12_APB_DATA_WIDTH_32_DUT_CLK_PROVIDED_1_33744078aeb3775222139608063c1a5d_redUniq_2
set_assignment [list physs_eth {GEN_PORT[3].phy_regbank}] -targets [list MB5_FB2_F2]; #cnic_lib_10m_RED_VAPB_APB_ADDRESS_WIDTH_12_APB_DATA_WIDTH_32_DUT_CLK_PROVIDED_1_33744078aeb3775222139608063c1a5d_redUniq_1_2
set_assignment [list physs_eth {GEN_PORT[3].u0_ethernet_altera_phy}] -targets [list MB5_FB2_F2]; #rtlc__ethernet_altera_phy__ca__cp__625
set_assignment [list physs_eth {GEN_PORT[3].u_phy_regbank}] -targets [list MB5_FB2_F2]; #rtlc__phy_regbank__ca__cp__17_b0c5beaebce0748a44d1395b08a1703c
set_assignment [list physs_eth {GEN_PORT[3].u_s10_fpll_ref125Mhz_625Mhz}] -targets [list MB5_FB2_F2]; #s10_fpll_ref125Mhz_625Mhz

set_assignment [list physs_eth {GEN_PORT[4].A00_i2c}] -targets [list MB6_FA1_F2]; #imc_i2c_lib_Imc_DW_apb_i2c
set_assignment [list physs_eth {GEN_PORT[4].IW_sync_reset}] -targets [list MB6_FA1_F2]; #cnic_lib_10m_IW_sync_reset
set_assignment [list physs_eth {GEN_PORT[4].io_pll_125mhz_eth_clks}] -targets [list MB6_FA1_F2]; #io_pll_125mhz_eth_clks
set_assignment [list physs_eth {GEN_PORT[4].phy_i2c_vapb_master}] -targets [list MB6_FA1_F2]; #cnic_lib_10m_RED_VAPB_APB_ADDRESS_WIDTH_12_APB_DATA_WIDTH_32_DUT_CLK_PROVIDED_1_33744078aeb3775222139608063c1a5d_redUniq_2
set_assignment [list physs_eth {GEN_PORT[4].phy_regbank}] -targets [list MB6_FA1_F2]; #cnic_lib_10m_RED_VAPB_APB_ADDRESS_WIDTH_12_APB_DATA_WIDTH_32_DUT_CLK_PROVIDED_1_33744078aeb3775222139608063c1a5d_redUniq_1_2
set_assignment [list physs_eth {GEN_PORT[4].u0_ethernet_altera_phy}] -targets [list MB6_FA1_F2]; #rtlc__ethernet_altera_phy__ca__cp__625
set_assignment [list physs_eth {GEN_PORT[4].u_phy_regbank}] -targets [list MB6_FA1_F2]; #rtlc__phy_regbank__ca__cp__17_b0c5beaebce0748a44d1395b08a1703c
set_assignment [list physs_eth {GEN_PORT[4].u_s10_fpll_ref125Mhz_625Mhz}] -targets [list MB6_FA1_F2]; #s10_fpll_ref125Mhz_625Mhz

set_assignment [list physs_eth {GEN_PORT[5].A00_i2c}] -targets [list MB6_FB1_F2]; #imc_i2c_lib_Imc_DW_apb_i2c
set_assignment [list physs_eth {GEN_PORT[5].IW_sync_reset}] -targets [list MB6_FB1_F2]; #cnic_lib_10m_IW_sync_reset
set_assignment [list physs_eth {GEN_PORT[5].io_pll_125mhz_eth_clks}] -targets [list MB6_FB1_F2]; #io_pll_125mhz_eth_clks
set_assignment [list physs_eth {GEN_PORT[5].phy_i2c_vapb_master}] -targets [list MB6_FB1_F2]; #cnic_lib_10m_RED_VAPB_APB_ADDRESS_WIDTH_12_APB_DATA_WIDTH_32_DUT_CLK_PROVIDED_1_33744078aeb3775222139608063c1a5d_redUniq_2
set_assignment [list physs_eth {GEN_PORT[5].phy_regbank}] -targets [list MB6_FB1_F2]; #cnic_lib_10m_RED_VAPB_APB_ADDRESS_WIDTH_12_APB_DATA_WIDTH_32_DUT_CLK_PROVIDED_1_33744078aeb3775222139608063c1a5d_redUniq_1_2
set_assignment [list physs_eth {GEN_PORT[5].u0_ethernet_altera_phy}] -targets [list MB6_FB1_F2]; #rtlc__ethernet_altera_phy__ca__cp__625
set_assignment [list physs_eth {GEN_PORT[5].u_phy_regbank}] -targets [list MB6_FB1_F2]; #rtlc__phy_regbank__ca__cp__17_b0c5beaebce0748a44d1395b08a1703c
set_assignment [list physs_eth {GEN_PORT[5].u_s10_fpll_ref125Mhz_625Mhz}] -targets [list MB6_FB1_F2]; #s10_fpll_ref125Mhz_625Mhz

set_assignment [list physs_eth {GEN_PORT[6].A00_i2c}] -targets [list MB6_FA2_F2]; #imc_i2c_lib_Imc_DW_apb_i2c
set_assignment [list physs_eth {GEN_PORT[6].IW_sync_reset}] -targets [list MB6_FA2_F2]; #cnic_lib_10m_IW_sync_reset
set_assignment [list physs_eth {GEN_PORT[6].io_pll_125mhz_eth_clks}] -targets [list MB6_FA2_F2]; #io_pll_125mhz_eth_clks
set_assignment [list physs_eth {GEN_PORT[6].phy_i2c_vapb_master}] -targets [list MB6_FA2_F2]; #cnic_lib_10m_RED_VAPB_APB_ADDRESS_WIDTH_12_APB_DATA_WIDTH_32_DUT_CLK_PROVIDED_1_33744078aeb3775222139608063c1a5d_redUniq_2
set_assignment [list physs_eth {GEN_PORT[6].phy_regbank}] -targets [list MB6_FA2_F2]; #cnic_lib_10m_RED_VAPB_APB_ADDRESS_WIDTH_12_APB_DATA_WIDTH_32_DUT_CLK_PROVIDED_1_33744078aeb3775222139608063c1a5d_redUniq_1_2
set_assignment [list physs_eth {GEN_PORT[6].u0_ethernet_altera_phy}] -targets [list MB6_FA2_F2]; #rtlc__ethernet_altera_phy__ca__cp__625
set_assignment [list physs_eth {GEN_PORT[6].u_phy_regbank}] -targets [list MB6_FA2_F2]; #rtlc__phy_regbank__ca__cp__17_b0c5beaebce0748a44d1395b08a1703c
set_assignment [list physs_eth {GEN_PORT[6].u_s10_fpll_ref125Mhz_625Mhz}] -targets [list MB6_FA2_F2]; #s10_fpll_ref125Mhz_625Mhz

set_assignment [list physs_eth {GEN_PORT[7].A00_i2c}] -targets [list MB6_FB2_F2]; #imc_i2c_lib_Imc_DW_apb_i2c
set_assignment [list physs_eth {GEN_PORT[7].IW_sync_reset}] -targets [list MB6_FB2_F2]; #cnic_lib_10m_IW_sync_reset
set_assignment [list physs_eth {GEN_PORT[7].io_pll_125mhz_eth_clks}] -targets [list MB6_FB2_F2]; #io_pll_125mhz_eth_clks
set_assignment [list physs_eth {GEN_PORT[7].phy_i2c_vapb_master}] -targets [list MB6_FB2_F2]; #cnic_lib_10m_RED_VAPB_APB_ADDRESS_WIDTH_12_APB_DATA_WIDTH_32_DUT_CLK_PROVIDED_1_33744078aeb3775222139608063c1a5d_redUniq_2
set_assignment [list physs_eth {GEN_PORT[7].phy_regbank}] -targets [list MB6_FB2_F2]; #cnic_lib_10m_RED_VAPB_APB_ADDRESS_WIDTH_12_APB_DATA_WIDTH_32_DUT_CLK_PROVIDED_1_33744078aeb3775222139608063c1a5d_redUniq_1_2
set_assignment [list physs_eth {GEN_PORT[7].u0_ethernet_altera_phy}] -targets [list MB6_FB2_F2]; #rtlc__ethernet_altera_phy__ca__cp__625
set_assignment [list physs_eth {GEN_PORT[7].u_phy_regbank}] -targets [list MB6_FB2_F2]; #rtlc__phy_regbank__ca__cp__17_b0c5beaebce0748a44d1395b08a1703c
set_assignment [list physs_eth {GEN_PORT[7].u_s10_fpll_ref125Mhz_625Mhz}] -targets [list MB6_FB2_F2]; #s10_fpll_ref125Mhz_625Mhz



