
set_default_station_parameters -width 1024 -depth 4096 -pipeline 4
#add_station -name "iosf_signal" -clock {"side_clk"} -width 256
add_station -name "iosf_signal" -clock {"prim_clk"} -width 4096
add_probe -station iosf_signal {"gtcore_wrapper.sg_taddress"}
add_probe -station iosf_signal {"gtcore_wrapper.sg_tdata"}
add_probe -station iosf_signal {"gtcore_wrapper.sg_tfbe"}
add_probe -station iosf_signal {"gtcore_wrapper.sg_tfmt"}
add_probe -station iosf_signal {"gtcore_wrapper.sg_tlbe"}
add_probe -station iosf_signal {"gtcore_wrapper.sg_tlength"}
add_probe -station iosf_signal {"gtcore_wrapper.sg_ttag"}
add_probe -station iosf_signal {"gtcore_wrapper.sg_ttype"}
add_probe -station iosf_signal {"gtcore_wrapper.sg_maddress"}
add_probe -station iosf_signal {"gtcore_wrapper.sg_mdata"}
add_probe -station iosf_signal {"gtcore_wrapper.sg_mfbe"}
add_probe -station iosf_signal {"gtcore_wrapper.sg_mfmt"}
add_probe -station iosf_signal {"gtcore_wrapper.sg_mlbe"}
add_probe -station iosf_signal {"gtcore_wrapper.sg_mlength"}
add_probe -station iosf_signal {"gtcore_wrapper.sg_mtag"}
add_probe -station iosf_signal {"gtcore_wrapper.sg_mtype"}
add_probe -station iosf_signal {"gtcore_wrapper.perst_uhfi"}
add_probe -station iosf_signal {"gtcore_wrapper.pdeb_pcie_perst_n_uhfi"}
add_probe -station iosf_signal {"gtcore_wrapper.tosw_pcie_perst_n_uhfi"}
add_probe -station iosf_signal {"gtcore_wrapper.frsw_pcie_perst_n_uhfi"}
add_probe -station iosf_signal {"gtcore_wrapper.sys_rst_n"}
add_probe -station iosf_signal {"gtcore_wrapper.sg.free_pwrgoodrst_b"}
add_probe -station iosf_signal {"gtcore_wrapper.sg.side_pwrgoodrst_b"}
add_probe -station iosf_signal {"gtcore_wrapper.sg.cxl_pwrgoodrst_b"}
add_probe -station iosf_signal {"gtcore_wrapper.sg.sg_cxl_rst_b"}
add_probe -station iosf_signal {"gtcore_wrapper.sg.sg_cxlbus_rst_b"}
add_probe -station iosf_signal {"gtcore_wrapper.sg.cp_te_siderst_ugt[1:0]"}
add_probe -station iosf_signal {"gtcore_wrapper.sg.cp_te_cxlrst_ugt[1:0]"}
add_probe -station iosf_signal {"gtcore_wrapper.sg.cp_te_cxlbusrst_ugt[1:0]"}
add_probe -station iosf_signal {"gtcore_wrapper.sg.sg_side_rst_b"}
add_probe -station iosf_signal {"gtcore_wrapper.sg.sg_cdie_prim_ism_agent"}
add_probe -station iosf_signal {"gtcore_wrapper.sg.cdie_sg_prim_ism_fabric"}
add_probe -station iosf_signal {"gtcore_wrapper.sg.cdie_sg_gnt"}
add_probe -station iosf_signal {"gtcore_wrapper.sg.cdie_sg_gnt_rtype"}
add_probe -station iosf_signal {"gtcore_wrapper.sg.cdie_sg_gnt_type"}
add_probe -station iosf_signal {"gtcore_wrapper.sg.cdie_sg_cmd_put"}
add_probe -station iosf_signal {"gtcore_wrapper.sg.cdie_sg_cmd_rtype"}
add_probe -station iosf_signal {"gtcore_wrapper.sg.sg_cdie_req_put"}
add_probe -station iosf_signal {"gtcore_wrapper.sg.sg_cdie_req_rtype"}
add_probe -station iosf_signal {"gtcore_wrapper.sg.sg_cdie_credit_put"}
add_probe -station iosf_signal {"gtcore_wrapper.sg.sg_cdie_credit_rtype"}
add_probe -station iosf_signal {"gtcore_wrapper.sg.sg_cdie_credit_cmd"}
add_probe -station iosf_signal {"gtcore_wrapper.sg.sg_cdie_credit_data"}
add_probe -station iosf_signal {"gtcore_wrapper.uhfi.uhfi_agent_prim_ism_agent"}
add_probe -station iosf_signal {"gtcore_wrapper.uhfi.uhfi_fabric_prim_ism_fabric"}
add_probe -station iosf_signal {"gtcore_wrapper.uhfi.uhfi_fabric_prim_ism_agent"}
add_probe -station iosf_signal {"uhfi_agent_prim_ism_fabric"}




############################################################################
add_station -name "ltssm_signal" -clock {"prim_clk"} -width 512 -depth  1024
add_probe -station ltssm_signal {"gtcore_wrapper.uhfi.uhfi_pcie_ctrl.i_pcie_bridge_top.ltssm[5:0]"}
