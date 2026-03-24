############## Redcomp Settings ##############
#set_message_severity warning -ids 30060
#set_message_severity warning -ids route-92058
#set_message_severity warning -ids tbuild-40091
#set_message_severity warning -ids route-50071
set_message_severity warning -ids condition-90081
set_message_severity warning -ids condition-67081
set_message_severity warning -ids condition-31049
set_message_severity warning -ids condition-31011
set_message_severity warning -ids condition-31031
set_message_severity warning -ids wrap-46213
set_message_severity warning -ids condition-31133
#set_message_severity warning -ids qualify-31214 
#set_message_severity warning -ids wrap-46399
#set_message_severity warning -ids wrap-94520
#To suppress the memory error in qualify stage
#review later
#set_message_severity warning -ids qualify-31252
#set_message_severity warning -ids qualify-31125
################################################
#set_message_severity warning -ids qualify-31112
#set_message_severity warning -ids qualify-31291
#set_module_empty ipfluxtop
#set_module_empty nac_cgu_dig_obs
#set_module_blackbox nac_cgu_dig_obs
#set_module_blackbox cpm_top
#set_module_blackbox hlp
#set_module_blackbox paruxquad
#set_module_blackbox clkrx4_ns_fc_apma_refck_buffer
#add_debug_file $env(WORKAREA)/verif/fpga/vps/build_input_dir/enm_2.tcl
#add_debug_file $env(WORKAREA)/verif/fpga/vps_dvb/build_input_dir/debug.tcl
#
#
allow_probe_on_clock_pin i2c_apb_clk 
set_rcm_group_master_clock_frequency -freq 250
set_preserve_unused_sdc_clock physs_funcx2_clk
set_preserve_unused_sdc_clock physs_intf0_clk
set_preserve_unused_sdc_clock reference_clk
set_preserve_unused_sdc_clock rclk_diff_n
set_preserve_unused_sdc_clock rclk_diff_p
set_preserve_unused_sdc_clock timeref_clk
set_preserve_unused_sdc_clock soc_per_clk
add_debug_file $env(WORKAREA)/verif/fpga/vps_dvb/cnic_debug_1.tcl
#
#enable_probeless_debug
#enable_reconstruction

#create_spnr_tags redfpga_strategies -strategy_profile $env(WORKAREA)/verif/fpga/vps_dvb/build_input_dir/strategies.tcl
#configure_fpgas MB1_FB1_F1 -spnr_tags redfpga_strategies
#configure_fpgas MB1_FB1_F2 -spnr_tags redfpga_strategies
#configure_fpgas [get_fpgas MB1_FB1_F1] -spnr_tags redfpga_strategies
#configure_fpgas [get_fpgas MB1_FB1_F2] -spnr_tags redfpga_strategies
#allow_probe_on_clock_pin physs_eth.physs0.parmquad0.pcs100_wrap_0.quadpcs100_0.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_0.u0_ethernet_altera_phy.u_ethernet_1g_altera_phy.pcs_ref_clk_125mhz
#allow_probe_on_clock_pin "physs0.parmquad0.pcs100_wrap_0.quadpcs100_0.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_0.u0_ethernet_altera_phy.u_ethernet_1g_altera_phy.xcvr_rx_clk_o"
#allow_probe_on_clock_pin "physs0.parmquad0.pcs100_wrap_0.quadpcs100_0.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_0.U_PCS.U_PCSMMD.U_GPCS.U_RX.rx_clk"
allow_probe_on_clock_pin "physs0.parmquad0.pcs100_wrap_0.quadpcs100_0.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_0.U_PCS.U_PCSMMD.U_GPCS.U_RX.U_FRM.clk"
set_module_blackbox io_pll_125mhz_eth_clks
set_module_blackbox s10_fpll_ref125Mhz_625Mhz 
set_module_blackbox s10_serdes_Ltile_with8b10b_tbi_eth
set_module_blackbox s10_xcvr_phy_reset_controller
set_module_blackbox serdes_tbi_loopback_fifo
#set_top_module gnrd_nac_lib.par_nac
set_top_module physs_lib_10m.physs_eth
#add_force_file $env(WORKAREA)/verif/fpga/vps_dvb/build_input_dir/force.nets
set_optimization_mode performance
#enable_autoconnect
add_veloce_settings $env(WORKAREA)/verif/fpga/vps_dvb/build_input_dir/rtlc_settings.config
#set_rtlc_options {-drive_force_file /nfs/site/disks/zsc14.xne_cnic.emu-fpga.001/pragyaro/physs_8_ports/verif/fpga/vps_dvb/build_input_dir/clock_cross_file }
#add_veloce_settings user_inputs/red.veloce.config
############PROBELESS DEBUG###############################
#disable_probeless_shadow
#enable_probeless_debug
#enable_reconstruction
############## Partition Settings ##############
#source /nfs/site/disks/xne_tip_0003/urukunda/pragya_barak_phy/pragay_phy_intg/verif/fpga/vps_dvb/build_input_dir/part_pragya.tcl
source $env(WORKAREA)/verif/fpga/vps_dvb/build_input_dir/part_settings.tcl
#source $env(WORKAREA)/verif/fpga/vps_dvb/build_input_dir/part_settings_7_quad.tcl
#CBB CABLE
#set_phd_file $env(WORKAREA)/verif/fpga/vps_dvb/build_input_dir/cbb_hardware_files/new/test/cbb_modified/out/outputs/hardware.phd
#2MB-INDIRECT
#set_phd_file $env(WORKAREA)/verif/fpga/vps_dvb/build_input_dir/4_pcie_card/mki_4_pcie_card_port0.phd
#7MB
#set_phd_file $env(WORKAREA)/verif/fpga/vps_dvb/build_input_dir/7_quad/7_QUAD/boardgen/outputs/hardware.phd
#set_phd_file $env(WORKAREA)/verif/fpga/hardware_8ports.phd
set_phd_file /nfs/site/disks/zsc14.xne_cnic.emu-fpga.001/pragyaro/fm_16_ports_qsfp/hardware.phd
source $env(WORKAREA)/verif/fpga/vps_dvb/build_input_dir/wrap_settings.tcl

add_force_file $env(WORKAREA)/verif/fpga/vps_dvb/build_input_dir/force.nets

#set_rdc_file $env(WORKAREA)/verif/fpga/vps_dvb/build_input_dir/7_quad/7_QUAD/clock_port_fb4_tb2_fa2_tb1_ec.rdc
set_rdc_file $env(WORKAREA)/verif/fpga/vps_dvb/build_input_dir/ethernet_loopback.rdc
#set_rdc_file $env(WORKAREA)/verif/fpga/vps_dvb/build_input_dir/clock_port_indirect.rdc
#set_rdc_file $env(WORKAREA)/verif/fpga/vps_dvb/build_input_dir/4_pcie_card/clock_port_fb1_tb2_fa2_tb1_ec.rdc
#set_rdc_file $env(WORKAREA)/verif/fpga/vps_dvb/build_input_dir/7_quad/7_QUAD/clock_port_fb4_tb2_fa2_tb1_ec.rdc
set_muxable_signal_types -half_cycle_path true
set_muxable_signal_types -async_reset true

############## Distribution Settings ##############
create_distrib_tags vpsmemlow -distrib_flow custom -mem_req 10G
create_distrib_tags vpsmemhigh -distrib_flow custom -mem_req 512G
create_distrib_tags red -distrib_flow custom
configure_tasks route.generate -distrib_tag vpsmemhigh
configure_tasks route.analyze -distrib_tag vpsmemhigh
configure_tasks wrap.analyze -distrib_tag vpsmemlow
configure_tasks split -distrib_tag vpsmemhigh
configure_tasks route.route -distrib_tag vpsmemhigh
configure_tasks route -distrib_tag vpsmemhigh
configure_tasks wrap -distrib_tag vpsmemlow
configure_tasks wrap.annotate -distrib_tag vpsmemlow
configure_tasks wrap.debug -distrib_tag vpsmemlow
configure_tasks wrap.generate -distrib_tag vpsmemlow
configure_tasks rtlc -distrib_tag vpsmemhigh -rtl_partitions_distrib_tag vpsmemhigh
configure_tasks condition -distrib_tag vpsmemhigh
configure_tasks spnr -distrib_tag vpsmemhigh
configure_tasks condition.optimize -distrib_tag vpsmemhigh
configure_tasks qualify -distrib_tag vpsmemhigh
configure_tasks condition.parse -distrib_tag vpsmemhigh
configure_tasks part -distrib_tag vpsmemhigh

############## FPGA Configuration ##############
#create_spnr_tags tag_redfpga -strategy_profile $env(RED_HOME)/partitioner/systems/fpga/altera/common/redfpga/strategies_all__start_now.tcl

############## Veloce Settings ##############
set_velcomp_options {-rtlc_advisor_options "-disable_fpga_dl_flow"}
set_rtlc_options {-suppress RTLC-2429}
set_rtlc_options {-suppress RTLC-10108}
set_rtlc_options {-suppress RTLC-2469}


############## Redcomp Child Tools Settings ##############
source $env(WORKAREA)/verif/fpga/vps_dvb/build_input_dir/condition_settings.tcl
#allow_probe_on_clock_pin "sg.sgiptop1.sgciunit1.sideclk"
source $env(WORKAREA)/verif/fpga/vps_dvb/build_input_dir/qualify_settings.tcl
source $env(WORKAREA)/verif/fpga/vps_dvb/build_input_dir/split_settings.tcl
configure_tasks route -constraints_file $env(WORKAREA)/verif/fpga/vps_dvb/build_input_dir/route_settings.tcl

#create_spnr_tags redfpga_strategies -strategy_profile $env(WORKAREA)/verif/fpga/vps_dvb/build_input_dir/strategies.tcl
#configure_fpgas MB1_FB1_F1 -spnr_tags redfpga_strategies
#configure_fpgas MB1_FB1_F2 -spnr_tags redfpga_strategies

#add_tie_net_file $env(WORKAREA)/verif/fpga/vps_dvb/build_input_dir/tie.txt
#set_optimization_mode capacity
#
#source $env(TARGET_DIR)/vendor_distrib_src/netbatch.config

#create_spnr_tags tag_redfpga -strategy_profile  /nfs/site/disks/zsc14.xne_mki.fpga.001/pdewanga/mki_dvb/output/mki_wrapper/fpga/vps_dvb_vps/golden_1/MKI_SOC/vps/strategies_all__start_now.tcl
#configure_fpgas MB2_FA1_F2 -spnr_tags tag_redfpga
