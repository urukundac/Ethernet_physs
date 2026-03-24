set_default_station_parameters -width 2048 -depth 1024 -pipeline 4
############################################################################
#add_station -name "mki" -clock {"gtcore_wrapper.uhfi.clk_uhfi_100mhz_out"} -width 2048
add_station -name "mki" -clock {"uhfi_100mhz_clk"} -width 2048
add_probe -station mki {"gtcore_wrapper.pdeb_pcie_perst_n"}
add_probe -station mki {"gtcore_wrapper.tosw_pcie_perst_n"}
add_probe -station mki {"gtcore_wrapper.frsw_pcie_perst_n"}
add_probe -station mki {"gtcore_wrapper.pdeb_pcie_perst_n_uhfi"}
add_probe -station mki {"gtcore_wrapper.tosw_pcie_perst_n_uhfi"}
add_probe -station mki {"gtcore_wrapper.frsw_pcie_perst_n_uhfi"}
add_probe -station mki {"gtcore_wrapper.sys_rst_n"}
add_probe -station mki {"gtcore_wrapper.pwron_n"}
add_probe -station mki {"gtcore_wrapper.wake_n"}
add_probe -station mki {"gtcore_wrapper.prsnt_n"}
add_probe -station mki {"gtcore_wrapper.prsnt_n"}
add_probe -station mki {"gtcore_wrapper.pwron_n_uhfi"}
add_probe -station mki {"gtcore_wrapper.wake_n_uhfi"}
add_probe -station mki {"gtcore_wrapper.prsnt_n_uhfi"}
add_probe -station mki {"gtcore_wrapper.fpga_transactors_top_inst.generic_chassis_top_inst.dut.pcie_s10_hip_ast_hip_status_ltssmstate"}
add_probe -station mki {"gtcore_wrapper.fpga_transactors_top_inst.generic_chassis_top_inst.dut.pcie_s10_hip_ast_hip_status_link_up"}
#add_probe -station mki {"gtcore_wrapper.fpga_transactors_top_inst.generic_chassis_top_inst.dut.app_clock_out_clk_clk"}
add_probe -station mki {"gtcore_wrapper.fpga_transactors_top_inst.generic_chassis_top_inst.dut.app_reset_in_reset_reset_n"}
#add_probe -station mki {"gtcore_wrapper.fpga_transactors_top_inst.generic_chassis_top_inst.dut.pcie_s10_hip_ast_refclk_clk"}
add_probe -station mki {"gtcore_wrapper.fpga_transactors_top_inst.generic_chassis_top_inst.dut.pcie_s10_hip_ast_npor_npor"}
add_probe -station mki {"gtcore_wrapper.fpga_transactors_top_inst.generic_chassis_top_inst.dut.pcie_s10_hip_ast_npor_pin_perst"}
add_probe -station mki {"gtcore_wrapper.fpga_transactors_top_inst.generic_chassis_top_inst.dut.pcie_s10_hip_ast_hip_rst_reset_status"}
add_probe -station mki {"gtcore_wrapper.fpga_transactors_top_inst.generic_chassis_top_inst.dut.pcie_s10_hip_ast_hip_rst_serdes_pll_locked"}
add_probe -station mki {"gtcore_wrapper.fpga_transactors_top_inst.generic_chassis_top_inst.dut.pcie_s10_hip_ast_hip_rst_pld_core_ready"}
add_probe -station mki {"gtcore_wrapper.fpga_transactors_top_inst.generic_chassis_top_inst.dut.pcie_s10_hip_ast_hip_rst_pld_clk_inuse"}
add_probe -station mki {"gtcore_wrapper.fpga_transactors_top_inst.generic_chassis_top_inst.dut.pcie_s10_hip_ast_hip_rst_testin_zero"}
add_probe -station mki {"gtcore_wrapper.fpga_transactors_top_inst.generic_chassis_top_inst.dut.pcie_s10_hip_ast_clr_st_reset"}
add_probe -station mki {"gtcore_wrapper.fpga_transactors_top_inst.generic_chassis_top_inst.dut.pcie_s10_hip_ast_ninit_done_ninit_done"}
add_probe -station mki {"gtcore_wrapper.uhfi.uhfi_pcie_ctrl.i_pcie_bridge_top.ltssm"}
add_probe -station mki {"gtcore_wrapper.uhfi.uhfi_pcie_ctrl.i_pcie_bridge_top.perstn"}
add_probe -station mki {"gtcore_wrapper.uhfi.uhfi_pcie_ctrl.i_pcie_bridge_top.waken"}
add_probe -station mki {"gtcore_wrapper.uhfi.uhfi_pcie_ctrl.i_pcie_bridge_top.pwron_n"}
add_probe -station mki {"gtcore_wrapper.uhfi.uhfi_pcie_ctrl.i_pcie_bridge_top.wake_n"}
add_probe -station mki {"gtcore_wrapper.uhfi.uhfi_pcie_ctrl.i_pcie_bridge_top.perst_n"}
add_probe -station mki {"gtcore_wrapper.uhfi.uhfi_pcie_ctrl.i_pcie_bridge_top.prsnt_n"}
add_probe -station mki {"gtcore_wrapper.uhfi.uhfi_pcie_ctrl.i_pcie_bridge_top.clk_user"}
add_probe -station mki {"gtcore_wrapper.uhfi.uhfi_pcie_ctrl.i_pcie_bridge_top.rst_user"}
