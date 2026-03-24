
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
add_probe -station iosf_signal {"gtcore_wrapper.sg.sgiptop1.sgciunit1.cdie_iosfp_agent.agent_ism.iosfp_agt_ism.int_pok"}
add_probe -station iosf_signal {"gtcore_wrapper.sg.sgiptop1.sgciunit1.cdie_iosfp_agent.agent_ism.iosfp_agt_ism.side_ism_lock_b"}
add_probe -station iosf_signal {"gtcore_wrapper.sg.sgiptop1.sgciunit1.cdie_iosfp_agent.agent_ism.iosfp_agt_ism.ism_out"}
add_probe -station iosf_signal {"gtcore_wrapper.sg.sgiptop1.sgciunit1.cdie_iosfp_agent.agent_ism.iosfp_agt_ism.port_disable"}
add_probe -station iosf_signal {"gtcore_wrapper.sg.sgiptop1.sgciunit1.cdie_iosfp_agent.agent_ism.iosfp_agt_ism.cg_cntr_loaded"}
add_probe -station iosf_signal {"gtcore_wrapper.sg.sgiptop1.sgciunit1.cdie_iosfp_agent.agent_ism.iosfp_agt_ism.cg_en_cntr"}
add_probe -station iosf_signal {"gtcore_wrapper.sg.sgiptop1.sgciunit1.cdie_iosfp_agent.agent_ism.iosfp_agt_ism.CG_CNTR_EN"}
add_probe -station iosf_signal {"gtcore_wrapper.sg.sgiptop1.sgciunit1.cdie_iosfp_agent.agent_ism.iosfp_agt_ism.force_creditreq"}
add_probe -station iosf_signal {"gtcore_wrapper.sg.sgiptop1.sgciunit1.cdie_iosfp_agent.agent_ism.iosfp_agt_ism.credit_reinit"}
add_probe -station iosf_signal {"gtcore_wrapper.sg.sgiptop1.sgciunit1.cdie_iosfp_agent.agent_ism.iosfp_agt_ism.side_clk_valid"}
add_probe -station iosf_signal {"gtcore_wrapper.sg.sgiptop1.sgciunit1.cdie_iosfp_agent.agent_ism.iosfp_agt_ism.cg_cntr_rdy"}
add_probe -station iosf_signal {"gtcore_wrapper.sg.sgiptop1.sgciunit1.cdie_iosfp_agent.agent_ism.iosfp_agt_ism.agent_ism_state"}
add_probe -station iosf_signal {"gtcore_wrapper.sg.sgiptop1.sgciunit1.cdie_iosfp_agent.agent_ism.iosfp_agt_ism.fabric_ism_state"}
add_probe -station iosf_signal {"gtcore_wrapper.sg.sgiptop1.sgciunit1.cdie_iosfp_agent.agent_ism.iosfp_agt_ism.prev_agent_ism_state"}
add_probe -station iosf_signal {"gtcore_wrapper.sg.sgiptop1.sgciunit1.cdie_iosfp_agent.agent_ism.iosfp_agt_ism.ism_in"}
add_probe -station iosf_signal {"gtcore_wrapper.sg.sgiptop1.sgciunit1.cdie_iosfp_agent.agent_ism.iosfp_agt_ism.cg_delay_width_int"}
add_probe -station iosf_signal {"gtcore_wrapper.sg.sgiptop1.sgciunit1.cdie_iosfp_agent.agent_ism.iosfp_agt_ism.init_done"}
add_probe -station iosf_signal {"gtcore_wrapper.sg.sgiptop1.sgciunit1.cdie_iosfp_agent.agent_ism.iosfp_agt_ism.rst_b"}
add_probe -station iosf_signal {"gtcore_wrapper.sg.sgiptop1.sgciunit1.cdie_iosfp_agent.agent_ism.prim_pok"}
add_probe -station iosf_signal {"gtcore_wrapper.sg.sgiptop1.sgciunit1.cdie_iosfp_agent.agent_ism.prim_pok_d"}
add_probe -station iosf_signal {"gtcore_wrapper.sg.sgiptop1.sgciunit1.cdie_iosfp_agent.agent_ism.primclk"}
add_probe -station iosf_signal {"gtcore_wrapper.sg.sgiptop1.sgciunit1.cdie_iosfp_agent.agent_ism.powergoodrst_b"}
add_probe -station iosf_signal {"gtcore_wrapper.sg.sgiptop1.sgciunit1.cxlclk"}
add_probe -station iosf_signal {"gtcore_wrapper.sg.sgiptop1.sgciunit1.iosf_pwrgoodrst_b"}
add_probe -station iosf_signal {"gtcore_wrapper.sg.sgiptop1.sgciunit1.cxl_pwrgoodrst_b"}
add_probe -station iosf_signal {"gtcore_wrapper.sg.sgiptop1.sgciunit1.cxlrst_b"}
add_probe -station iosf_signal {"gtcore_wrapper.sg.sgiptop1.sgciunit1.iosfrst_b"}
add_probe -station iosf_signal {"gtcore_wrapper.sg.sgiptop1.sgciunit1.agntclk"}
add_probe -station iosf_signal {"gtcore_wrapper.sg.sgiptop1.sgciunit1.sideclk"}
add_probe -station iosf_signal {"gtcore_wrapper.sg.sgiptop1.sgciunit1.siderst_b"}
add_probe -station iosf_signal {"gtcore_wrapper.sg.sgiptop1.sgciunit1.agntrst_b"}
add_probe -station iosf_signal {"gtcore_wrapper.sg.sgiptop1.sgciunit1.iosfp_agent_agntrst_b"}
add_probe -station iosf_signal {"gtcore_wrapper.sg.sgiptop1.sgciunit1.sgsi_side_clk_valid"}
add_probe -station iosf_signal {"gtcore_wrapper.sg.sgiptop1.sgciunit1.agnt_clk_valid"}
add_probe -station iosf_signal {"gtcore_wrapper.sg.sgiptop1.sgciunit1.cdie_iosfp_agent.agent_ism.prim_pok_clr"}
add_probe -station iosf_signal {"gtcore_wrapper.sg.sgiptop1.sgciunit1.cdie_iosfp_agent.agent_ism.prim_pok_set"}
add_probe -station iosf_signal {"gtcore_wrapper.sg.sgiptop1.sgciunit1.cdie_iosfp_agent.agent_ism.prim_siderst_exit"}
add_probe -station iosf_signal {"gtcore_wrapper.sg.sgiptop1.sgciunit1.cdie_iosfp_agent.agent_ism.prim_siderst_exit_f"}
add_probe -station iosf_signal {"gtcore_wrapper.sg.sgiptop1.sgciunit1.cdie_iosfp_agent.agent_ism.agent_ism_idle"}
add_probe -station iosf_signal {"gtcore_wrapper.sg.sgiptop1.sgciunit1.cdie_iosfp_agent.agent_ism.prim_ip_iosf_mcmp_pend"}
add_probe -station iosf_signal {"gtcore_wrapper.sg.sgiptop1.sgciunit1.cdie_iosfp_agent.agent_ism.agent_tqueue_tcred_empty"}
add_probe -station iosf_signal {"gtcore_wrapper.sg.sgiptop1.sgciunit1.cdie_iosfp_agent.agent_ism.agent_tcred_empty"}
add_probe -station iosf_signal {"gtcore_wrapper.sg.sgiptop1.sgciunit1.cdie_iosfp_agent.agent_ism.prim_ip_iosf_tcmp_pend"}
add_probe -station iosf_signal {"gtcore_wrapper.sg.sgiptop1.sgciunit1.cdie_iosfp_agent.agent_ism.agent_mqueue_empty"}
add_probe -station iosf_signal {"gtcore_wrapper.sg.sgiptop1.sgciunit1.cdie_iosfp_agent.agent_ism.forcepwrgatepok_rcvd"}
add_probe -station iosf_signal {"gtcore_wrapper.sg.sgiptop1.sgciunit1.cdie_iosfp_agent.agent_ism.pwrgate_ok_d"}




############################################################################
add_station -name "ltssm_signal" -clock {"prim_clk"} -width 512 -depth  1024
add_probe -station ltssm_signal {"gtcore_wrapper.uhfi.uhfi_pcie_ctrl.i_pcie_bridge_top.ltssm[5:0]"}
