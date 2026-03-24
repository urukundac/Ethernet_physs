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


set_assignment {physs_eth A00_i2c} -targets MB5_FA1_F2
set_assignment {physs_eth IW_sync_reset} -targets MB5_FA1_F2
set_assignment {physs_eth io_pll_125mhz_eth_clks} -targets MB5_FA1_F2
set_assignment {physs_eth phy_i2c_vapb_master} -targets MB5_FA1_F2
set_assignment {physs_eth phy_regbank} -targets MB5_FA1_F2
set_assignment {physs_eth u0_ethernet_altera_phy} -targets MB5_FA1_F2
set_assignment {physs_eth u_phy_regbank} -targets MB5_FA1_F2
set_assignment {physs_eth u_s10_fpll_ref125Mhz_625Mhz} -targets MB5_FA1_F2



