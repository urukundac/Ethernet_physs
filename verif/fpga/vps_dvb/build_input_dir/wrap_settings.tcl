
# Add required Vivado constraints for MIG IO and clock relationships
#add_backend_constraint_files   -task pnr -fpga U_CHAS01_U_SLOT01_U_A -file ./$env(SETTINGS_DIRNAME)/ddr4.xdc
#add_vivado_command_files       -task pnr -fpga U_CHAS01_U_SLOT01_U_B -file ./$env(SETTINGS_DIRNAME)/ddr4_mig.tcl
#add_backend_constraint_files   -task pnr -file $env(WORKAREA)/verif/fpga/vps_dvb/build_input_dir/design.xdc
#add_backend_constraint_files -synth quartus -task synthesis -type sdc -file "$env(WORKAREA)/verif/fpga/vps_dvb/build_input_dir/certus_constraints.sdc"

#jmoctezu (18-May), to add SystemVerilog files:
#add_backend_filelist_files -task synthesis -file "settings/sv_backend_files.f"
#pin mux error
#add_backend_defines -define "LIMIT_SERDES_TRAINING_TO_FIRST_DPA_LOCK=1"
#jmoctezu: from Jayaram
enable_pinmux_logic_lock true

#add_backend_qsys_ip_files -filetype "ip"   -file "$env(WORKAREA)/verif/fpga/vps_dvb/build_input_dir/IP_FILES/serdes_tbi_loopback_fifo/serdes_tbi_loopback_fifo.ip"
add_backend_qsys_ip_files -filetype "ip"   -file "$env(WORKAREA)/verif/fpga/vps_dvb/build_input_dir/IP_FILES/io_pll_125mhz_eth_clks/io_pll_125mhz_eth_clks.ip"
add_backend_qsys_ip_files -filetype "ip"   -file "$env(WORKAREA)/verif/fpga/vps_dvb/build_input_dir/IP_FILES/s10_iopll_125mhz_125mhz/s10_iopll_125mhz_125mhz.ip"
add_backend_qsys_ip_files -filetype "ip"   -file "$env(WORKAREA)/verif/fpga/vps_dvb/build_input_dir/IP_FILES/s10_fpll_ref125Mhz_625Mhz/s10_fpll_ref125Mhz_625Mhz.ip"
add_backend_qsys_ip_files -filetype "ip"   -file "$env(WORKAREA)/verif/fpga/vps_dvb/build_input_dir/IP_FILES/s10_serdes_Ltile_with8b10b_tbi_eth/s10_serdes_Ltile_with8b10b_tbi_eth.ip"
add_backend_qsys_ip_files -filetype "ip"   -file "$env(WORKAREA)/verif/fpga/vps_dvb/build_input_dir/IP_FILES/s10_xcvr_phy_reset_controller/s10_xcvr_phy_reset_controller.ip"
add_backend_constraint_files -type sdc -synth quartus -task synthesis -file "$env(WORKAREA)/verif/fpga/vps_dvb/vamshi.sdc"
create_spnr_tags redfpga_strategies -strategy_profile $env(WORKAREA)/verif/fpga/vps_dvb/build_input_dir/strategies.tcl
configure_fpgas MB1_FB1_F1 -spnr_tags redfpga_strategies
configure_fpgas MB1_FB1_F2 -spnr_tags redfpga_strategies

#To set RCM master clock to 125MHz, default is 200Mhz
#set_rcm_cd_master_clock_frequency 125

#add_backend_qsys_ip_files -filetype "ip"   -file "$env(WORKAREA)/verif/fpga/vps_dvb/build_input_dir/IP_FILES/phy_xcvr_rst_ctrl_gen.ip"
#add_backend_qsys_ip_files -filetype "ip"   -file "$env(WORKAREA)/verif/fpga/vps_dvb/build_input_dir/IP_FILES/s10_phy_xcvr_fpll_gen.ip"
#add_backend_qsys_ip_files -filetype "ip"   -file "$env(WORKAREA)/verif/fpga/vps_dvb/build_input_dir/IP_FILES/s10_pipe_gen1_x4_native_gen.ip"
#add_backend_qsys_ip_files -filetype "ip"   -file "$env(WORKAREA)/verif/fpga/vps_dvb/build_input_dir/IP_FILES/uhfi_iopll_s10_gen.ip"
#add_backend_verilog_files -task synthesis  -file $env(WORKAREA)/verif/fpga/vps_dvb/build_input_dir/IP_FILES/phy_xcvr_rst_ctrl_ip.v
#add_backend_verilog_files -task synthesis  -file $env(WORKAREA)/verif/fpga/vps_dvb/build_input_dir/IP_FILES/s10_phy_xcvr_fpll_ip.v
#add_backend_verilog_files -task synthesis  -file $env(WORKAREA)/verif/fpga/vps_dvb/build_input_dir/IP_FILES/s10_pipe_gen1_x4_native_ip.v
#add_backend_verilog_files -task synthesis  -file $env(WORKAREA)/verif/fpga/vps_dvb/build_input_dir/IP_FILES/uhfi_iopll_s10.v
#add_backend_verilog_files -task synthesis  -file $env(WORKAREA)/src/fzrosc_powerokdet_rosc.v
#add_backend_design_files -task pnr -language verilog -file $env(WORKAREA)/src/fzrosc_powerokdet_rosc.v
#add_backend_design_files -task <synthesis|pnr> -language <verilog|systemverilog|vhdl> -file {<file1> ... <fileN>} [-lib <library>] [-fpga {<fpga_name1> ... <fpga_nameN>}]
#add_backend_design_files -task synthesis -language systemverilog -file $env(WORKAREA)/src/fzrosc_powerokdet_rosc.sv
#add_backend_verilog_files -task synthesis  -file $env(WORKAREA)/src/fzrosc_core.v

#add_backend_constraint_files -synth quartus -task synthesis -type sdc -file "$env(WORKAREA)/verif/fpga/vps_dvb/build_input_dir/latch_mcp.sdc"
#add_backend_constraint_files -synth quartus -task synthesis -type sdc -file "$env(WORKAREA)/verif/fpga/vps_dvb/build_input_dir/async_groups.sdc"

#set_profpga_config_file $env(WORKAREA)/verif/fpga/vps_dvb/build_input_dir/mki_2_quad.cfg
#set_profpga_config_file $env(WORKAREA)/verif/fpga/vps_dvb/build_input_dir/mki_2mb_cabling_new.phd
#set_profpga_config_file $env(WORKAREA)/verif/fpga/vps_dvb/build_input_dir/cbb_hardware_files/temp/test/cbb_modified/out/outputs/hardware.phd
#set_profpga_config_file $env(WORKAREA)/verif/fpga/vps_dvb/build_input_dir/cbb_hardware_files/temp/test/cbb_modified/cbb_modified.cfg
set_profpga_config_file $env(WORKAREA)/verif/fpga/vps_dvb/build_input_dir/7_quad/7_QUAD/boardgen/outputs/hardware.phd
#set_profpga_config_file $env(WORKAREA)/verif/fpga/vps_dvb/build_input_dir/4_pcie_card/mki_4_pcie_card_port0.phd


##added for fgt
#add_backend_qsys_ip_files -filetype ip -file $env(WORKAREA)/subip/sip/fgc/source/fpga_generic_chassis/rtl/ALTERA/qip/build/quartus/qip/pcie_s10_hip_ast_fgc/ip/pcie_s10_hip_ast_fgc/pcie_s10_hip_ast_fgc_clock_in.ip
#add_backend_qsys_ip_files -filetype ip -file /nfs/site/disks/xne_tip_0003/bindhus/FGC_bkup/source/fpga_generic_chassis/rtl/ALTERA/qip/build/quartus/qip/pcie_s10_hip_ast_fgc/ip/pcie_s10_hip_ast_fgc/pcie_s10_hip_ast_fgc_pcie_s10_hip_ast_0.ip
##add_backend_qsys_ip_files -filetype ip -file $env(WORKAREA)/subip/sip/fgc/source/fpga_generic_chassis/rtl/ALTERA/qip/build/quartus/qip/pcie_s10_hip_ast_fgc/ip/pcie_s10_hip_ast_fgc/pcie_s10_hip_ast_fgc_pcie_s10_hip_ast_0.ip
#add_backend_qsys_ip_files -filetype ip -file $env(WORKAREA)/subip/sip/fgc/source/fpga_generic_chassis/rtl/ALTERA/qip/build/quartus/qip/pcie_s10_hip_ast_fgc/ip/pcie_s10_hip_ast_fgc/pcie_s10_hip_ast_fgc_reset_bridge_0.ip
#add_backend_qsys_ip_files -filetype ip -file $env(WORKAREA)/subip/sip/fgc/source/fpga_generic_chassis/rtl/ALTERA/qip/build/quartus/qip/pcie_s10_hip_ast_fgc/ip/pcie_s10_hip_ast_fgc/pcie_s10_hip_ast_fgc_timing_adapter_0.ip
#add_backend_qsys_ip_files -filetype qsys -file $env(WORKAREA)/subip/sip/fgc/source/fpga_generic_chassis/rtl/ALTERA/qip/build/quartus/qip/pcie_s10_hip_ast_fgc/pcie_s10_hip_ast_fgc.qsys
#add_backend_qsys_ip_files -filetype ip -file $env(WORKAREA)/subip/sip/fgc/source/fpga_generic_chassis/rtl/ALTERA/qip/build/quartus/qip/axi_crossbar/ip/axi_crossbar/axi_bridge_10.ip
#add_backend_qsys_ip_files -filetype ip -file $env(WORKAREA)/subip/sip/fgc/source/fpga_generic_chassis/rtl/ALTERA/qip/build/quartus/qip/axi_crossbar/ip/axi_crossbar/axi_bridge_11.ip
#add_backend_qsys_ip_files -filetype ip -file $env(WORKAREA)/subip/sip/fgc/source/fpga_generic_chassis/rtl/ALTERA/qip/build/quartus/qip/axi_crossbar/ip/axi_crossbar/axi_bridge_12.ip
#add_backend_qsys_ip_files -filetype ip -file $env(WORKAREA)/subip/sip/fgc/source/fpga_generic_chassis/rtl/ALTERA/qip/build/quartus/qip/axi_crossbar/ip/axi_crossbar/axi_bridge_13.ip
#add_backend_qsys_ip_files -filetype ip -file $env(WORKAREA)/subip/sip/fgc/source/fpga_generic_chassis/rtl/ALTERA/qip/build/quartus/qip/axi_crossbar/ip/axi_crossbar/axi_bridge_14.ip
#add_backend_qsys_ip_files -filetype ip -file $env(WORKAREA)/subip/sip/fgc/source/fpga_generic_chassis/rtl/ALTERA/qip/build/quartus/qip/axi_crossbar/ip/axi_crossbar/axi_bridge_15.ip
#add_backend_qsys_ip_files -filetype ip -file $env(WORKAREA)/subip/sip/fgc/source/fpga_generic_chassis/rtl/ALTERA/qip/build/quartus/qip/axi_crossbar/ip/axi_crossbar/axi_bridge_16.ip
#add_backend_qsys_ip_files -filetype ip -file $env(WORKAREA)/subip/sip/fgc/source/fpga_generic_chassis/rtl/ALTERA/qip/build/quartus/qip/axi_crossbar/ip/axi_crossbar/axi_bridge_2.ip
#add_backend_qsys_ip_files -filetype ip -file $env(WORKAREA)/subip/sip/fgc/source/fpga_generic_chassis/rtl/ALTERA/qip/build/quartus/qip/axi_crossbar/ip/axi_crossbar/axi_bridge_3.ip
#add_backend_qsys_ip_files -filetype ip -file $env(WORKAREA)/subip/sip/fgc/source/fpga_generic_chassis/rtl/ALTERA/qip/build/quartus/qip/axi_crossbar/ip/axi_crossbar/axi_bridge_4.ip
#add_backend_qsys_ip_files -filetype ip -file $env(WORKAREA)/subip/sip/fgc/source/fpga_generic_chassis/rtl/ALTERA/qip/build/quartus/qip/axi_crossbar/ip/axi_crossbar/axi_bridge_5.ip
#add_backend_qsys_ip_files -filetype ip -file $env(WORKAREA)/subip/sip/fgc/source/fpga_generic_chassis/rtl/ALTERA/qip/build/quartus/qip/axi_crossbar/ip/axi_crossbar/axi_bridge_6.ip
#add_backend_qsys_ip_files -filetype ip -file $env(WORKAREA)/subip/sip/fgc/source/fpga_generic_chassis/rtl/ALTERA/qip/build/quartus/qip/axi_crossbar/ip/axi_crossbar/axi_bridge_7.ip
#add_backend_qsys_ip_files -filetype ip -file $env(WORKAREA)/subip/sip/fgc/source/fpga_generic_chassis/rtl/ALTERA/qip/build/quartus/qip/axi_crossbar/ip/axi_crossbar/axi_bridge_8.ip
#add_backend_qsys_ip_files -filetype ip -file $env(WORKAREA)/subip/sip/fgc/source/fpga_generic_chassis/rtl/ALTERA/qip/build/quartus/qip/axi_crossbar/ip/axi_crossbar/axi_bridge_9.ip
#add_backend_qsys_ip_files -filetype ip -file $env(WORKAREA)/subip/sip/fgc/source/fpga_generic_chassis/rtl/ALTERA/qip/build/quartus/qip/axi_crossbar/ip/axi_crossbar/axi_crossbar_axi_bridge_0.ip
#add_backend_qsys_ip_files -filetype ip -file $env(WORKAREA)/subip/sip/fgc/source/fpga_generic_chassis/rtl/ALTERA/qip/build/quartus/qip/axi_crossbar/ip/axi_crossbar/axi_crossbar_axi_bridge_1.ip
#add_backend_qsys_ip_files -filetype ip -file $env(WORKAREA)/subip/sip/fgc/source/fpga_generic_chassis/rtl/ALTERA/qip/build/quartus/qip/axi_crossbar/ip/axi_crossbar/axi_crossbar_clock_in.ip
#add_backend_qsys_ip_files -filetype ip -file $env(WORKAREA)/subip/sip/fgc/source/fpga_generic_chassis/rtl/ALTERA/qip/build/quartus/qip/axi_crossbar/ip/axi_crossbar/axi_crossbar_reset_in.ip
#add_backend_qsys_ip_files -filetype qsys -file $env(WORKAREA)/subip/sip/fgc/source/fpga_generic_chassis/rtl/ALTERA/qip/build/quartus/qip/axi_crossbar/axi_crossbar.qsys
#add_backend_qsys_ip_files -filetype ip -file $env(WORKAREA)/subip/sip/fgc/source/fpga_generic_chassis/rtl/ALTERA/qip/build/quartus/qip/axi_crossbar_1to2_addrwidth_20/ip/axi_crossbar_1to2_addrwidth_20/axi_crossbar_1to2_addrwidth_20_axi_bridge_0.ip
#add_backend_qsys_ip_files -filetype ip -file $env(WORKAREA)/subip/sip/fgc/source/fpga_generic_chassis/rtl/ALTERA/qip/build/quartus/qip/axi_crossbar_1to2_addrwidth_20/ip/axi_crossbar_1to2_addrwidth_20/axi_crossbar_1to2_addrwidth_20_axi_bridge_1.ip
#add_backend_qsys_ip_files -filetype ip -file $env(WORKAREA)/subip/sip/fgc/source/fpga_generic_chassis/rtl/ALTERA/qip/build/quartus/qip/axi_crossbar_1to2_addrwidth_20/ip/axi_crossbar_1to2_addrwidth_20/axi_crossbar_1to2_addrwidth_20_axi_bridge_2.ip
#add_backend_qsys_ip_files -filetype ip -file $env(WORKAREA)/subip/sip/fgc/source/fpga_generic_chassis/rtl/ALTERA/qip/build/quartus/qip/axi_crossbar_1to2_addrwidth_20/ip/axi_crossbar_1to2_addrwidth_20/axi_crossbar_1to2_addrwidth_20_clock_in.ip
#add_backend_qsys_ip_files -filetype ip -file $env(WORKAREA)/subip/sip/fgc/source/fpga_generic_chassis/rtl/ALTERA/qip/build/quartus/qip/axi_crossbar_1to2_addrwidth_20/ip/axi_crossbar_1to2_addrwidth_20/axi_crossbar_1to2_addrwidth_20_reset_in.ip
#add_backend_qsys_ip_files -filetype qsys -file $env(WORKAREA)/subip/sip/fgc/source/fpga_generic_chassis/rtl/ALTERA/qip/build/quartus/qip/axi_crossbar_1to2_addrwidth_20/axi_crossbar_1to2_addrwidth_20.qsys
#set_blackbox_as_primitive altsyncram
#set_blackbox_as_primitive scfifo
#set_blackbox_as_primitive dcfifo
#set_blackbox_as_primitive dcfifo_mixed_widths
#set_blackbox_as_primitive axi_crossbar
#set_blackbox_as_primitive axi_crossbar_1to2_addrwidth_20
#set_blackbox_as_primitive pcie_s10_hip_ast_fgc
#set_blackbox_as_primitive fgt_emif_s10
#set_blackbox_as_primitive fzrosc_powerokdet_rosc
#set_blackbox_as_primitive fzrosc_core
#manage_internal_clocks
add_backend_quartus_options -target qsf -option  [list { set_global_assignment -name OPTIMIZATION_MODE "HIGH PERFORMANCE EFFORT"}]


#set_redmem_init_file {hex0.hex} -redmem_instance { i_fuse_top.i_fuse_ram_wrapper.rf_data[0].dssr_pm_exist.i_ip743rfshpm1r1w128x32m5_dfx_wrapper_data_sprw_soft.ip743rfshpm1r1w128x32m5.i_fuse_dpram_ip743rfshpm1r1w128x32m5_0.dpram}    -format hex
#set_redmem_init_file {hex1.hex} -redmem_instance { i_fuse_top.i_fuse_ram_wrapper.rf_data[1].dssr_pm_exist.i_ip743rfshpm1r1w128x32m5_dfx_wrapper_data_sprw_soft.ip743rfshpm1r1w128x32m5.i_fuse_dpram_ip743rfshpm1r1w128x32m5_0.dpram}    -format hex
#set_redmem_init_file {hex2.hex} -redmem_instance { i_fuse_top.i_fuse_ram_wrapper.rf_data[2].dssr_pm_exist.i_ip743rfshpm1r1w128x32m5_dfx_wrapper_data_sprw_soft.ip743rfshpm1r1w128x32m5.i_fuse_dpram_ip743rfshpm1r1w128x32m5_0.dpram}    -format hex
#set_redmem_init_file {hex3.hex} -redmem_instance { i_fuse_top.i_fuse_ram_wrapper.rf_data[3].dssr_pm_exist.i_ip743rfshpm1r1w128x32m5_dfx_wrapper_data_sprw_soft.ip743rfshpm1r1w128x32m5.i_fuse_dpram_ip743rfshpm1r1w128x32m5_0.dpram}    -format hex
#set_redmem_init_file {hex4.hex} -redmem_instance { i_fuse_top.i_fuse_ram_wrapper.rf_data[4].dssr_pm_exist.i_ip743rfshpm1r1w128x32m5_dfx_wrapper_data_sprw_soft.ip743rfshpm1r1w128x32m5.i_fuse_dpram_ip743rfshpm1r1w128x32m5_0.dpram}    -format hex
#set_redmem_init_file {hex5.hex} -redmem_instance { i_fuse_top.i_fuse_ram_wrapper.rf_data[5].dssr_pm_exist.i_ip743rfshpm1r1w128x32m5_dfx_wrapper_data_sprw_soft.ip743rfshpm1r1w128x32m5.i_fuse_dpram_ip743rfshpm1r1w128x32m5_0.dpram}    -format hex
#set_redmem_init_file {hex6.hex} -redmem_instance { i_fuse_top.i_fuse_ram_wrapper.rf_data[6].dssr_pm_exist.i_ip743rfshpm1r1w128x32m5_dfx_wrapper_data_sprw_soft.ip743rfshpm1r1w128x32m5.i_fuse_dpram_ip743rfshpm1r1w128x32m5_0.dpram}    -format hex
#set_redmem_init_file {hex7.hex} -redmem_instance { i_fuse_top.i_fuse_ram_wrapper.rf_data[7].dssr_pm_exist.i_ip743rfshpm1r1w128x32m5_dfx_wrapper_data_sprw_soft.ip743rfshpm1r1w128x32m5.i_fuse_dpram_ip743rfshpm1r1w128x32m5_0.dpram}    -format hex
#set_redmem_init_file {hex8.hex} -redmem_instance { i_fuse_top.i_fuse_ram_wrapper.rf_data[8].dssr_pm_exist.i_ip743rfshpm1r1w128x32m5_dfx_wrapper_data_sprw_soft.ip743rfshpm1r1w128x32m5.i_fuse_dpram_ip743rfshpm1r1w128x32m5_0.dpram}    -format hex
#set_redmem_init_file {hex9.hex} -redmem_instance { i_fuse_top.i_fuse_ram_wrapper.rf_data[9].dssr_pm_exist.i_ip743rfshpm1r1w128x32m5_dfx_wrapper_data_sprw_soft.ip743rfshpm1r1w128x32m5.i_fuse_dpram_ip743rfshpm1r1w128x32m5_0.dpram}    -format hex
#set_redmem_init_file {hex10.hex} -redmem_instance { i_fuse_top.i_fuse_ram_wrapper.rf_data[10].dssr_pm_exist.i_ip743rfshpm1r1w128x32m5_dfx_wrapper_data_sprw_soft.ip743rfshpm1r1w128x32m5.i_fuse_dpram_ip743rfshpm1r1w128x32m5_0.dpram}    -format hex
#set_redmem_init_file {hex11.hex} -redmem_instance { i_fuse_top.i_fuse_ram_wrapper.rf_data[11].dssr_pm_exist.i_ip743rfshpm1r1w128x32m5_dfx_wrapper_data_sprw_soft.ip743rfshpm1r1w128x32m5.i_fuse_dpram_ip743rfshpm1r1w128x32m5_0.dpram}    -format hex
#set_redmem_init_file {hex12.hex} -redmem_instance { i_fuse_top.i_fuse_ram_wrapper.rf_data[12].dssr_pm_exist.i_ip743rfshpm1r1w128x32m5_dfx_wrapper_data_sprw_soft.ip743rfshpm1r1w128x32m5.i_fuse_dpram_ip743rfshpm1r1w128x32m5_0.dpram}    -format hex
#set_redmem_init_file {hex13.hex} -redmem_instance { i_fuse_top.i_fuse_ram_wrapper.rf_data[13].dssr_pm_exist.i_ip743rfshpm1r1w128x32m5_dfx_wrapper_data_sprw_soft.ip743rfshpm1r1w128x32m5.i_fuse_dpram_ip743rfshpm1r1w128x32m5_0.dpram}    -format hex


##added to fix LAB issue #AN from Herbert 20.4 change
#
#add_backend_quartus_options -target ini -option [list {apl_ble_disable_timing=off} {apl_cbe_linearize_timing_weights=200} {vpr_set_aggressive_routability_opts=off} ]
#add_backend_quartus_options -target qsf -option  [list {set_global_assignment -name FITTER_RESYNTHESIS ON}]

## Fix to resolve LAB issue 
#add_backend_quartus_options -target ini  -option [list {lsc_disable_feasibility_check=on}]  -fpga MB1_FA1_F1
#add_backend_quartus_options -target ini  -option [list {lsc_disable_feasibility_check=on}]  -fpga MB1_FA1_F2
#add_backend_quartus_options -target ini  -option [list {lsc_disable_feasibility_check=on}]  -fpga MB1_FA2_F1
#add_backend_quartus_options -target ini  -option [list {lsc_disable_feasibility_check=on}]  -fpga MB1_FA2_F2
#add_backend_quartus_options -target ini  -option [list {lsc_disable_feasibility_check=on}]  -fpga MB1_FB1_F1
#add_backend_quartus_options -target ini  -option [list {lsc_disable_feasibility_check=on}]  -fpga MB1_FB1_F2
#add_backend_quartus_options -target ini  -option [list {lsc_disable_feasibility_check=on}]  -fpga MB1_FB2_F1
#add_backend_quartus_options -target ini  -option [list {lsc_disable_feasibility_check=on}]  -fpga MB1_FB2_F2

# From Herb for congestion 8/7/2021
#add_backend_quartus_options -target ini -option [list {ini_password = 3f55ddfcadc4e4609a4fb1b86132bb693dfaa90f49e7446b6cbd8ed59ec4006cddd8f0e6043a9883dc4c578a7ee90a2b3f574a85bc6e055da7ee90a5b6f52014551077576601431532135301564142312325405553313530355516320222015540662340005561522020301404077775313555162212030140407777} ]

#add_backend_quartus_options -target ini -option [list {ini_password = 3f55ddfc92be57606643a0b7005796b10bfd10838aaeea5d2dac1bbca12014551022077311611502225335654053322320043150323530005541}]

#add_backend_quartus_options -target ini -option [list {ini_password = 3f55ddfcadc7e4609a4fb1b86132bb693dfaa90f49e7446b6cbd8ed59ec4006cddd8f0e6043a9883dc4c578a7ee90a2b3f574a85bc6e055da7ee90a5b6f52014551077576601431532135301564142312325405553313530355516320222015540662340005561522020301404077775313555162212030140407777}]
#add_backend_quartus_options -target ini -option [list {ini_password1 = 3f55ddfc92be57606643a0b7005796b10bfd10838aaeea5d2dac1bbca12014551022077311611502225335654053322320043150323530005541}]
#add_backend_quartus_options -target ini -option [list {ini_password2 = 3f55ddfcadc6e441ba53398ad250f67e0e3b14a144a16e620145510775766104305212353315452532123201001566}]
#add_backend_quartus_options -target qsf -option [list { set_instance_assignment -name QII_AUTO_PACKED_REGISTERS OFF -to wrapper|RED_RBWB_AVMM_S10|RED_RBWB_AVMM_S10_inst|rbwb_inst|rbwb_avmm_qsys_s10|rdbk_wrbk_tree_logic_wrap_inst|tree_ctrl_pipe_c[0].ctrl_pipe|buf_command_out_chain[0][0] }]
#
#add_backend_quartus_options -target qsf -option [list { set_instance_assignment -name QII_AUTO_PACKED_REGISTERS OFF -to wrapper|RED_RBWB_AVMM_S10|RED_RBWB_AVMM_S10_inst|rbwb_inst|rbwb_avmm_qsys_s10|rdbk_wrbk_tree_logic_wrap_inst|tree_ctrl_pipe_c[1].ctrl_pipe|buf_command_out_chain[0][0] }]
#
#add_backend_quartus_options -target qsf -option [list { set_instance_assignment -name QII_AUTO_PACKED_REGISTERS OFF -to wrapper|RED_RBWB_AVMM_S10|RED_RBWB_AVMM_S10_inst|rbwb_inst|rbwb_avmm_qsys_s10|rdbk_wrbk_tree_logic_wrap_inst|tree_ctrl_pipe_c[2].ctrl_pipe|buf_command_out_chain[0][0] }]
#
#add_backend_quartus_options -target qsf -option [list { set_instance_assignment -name QII_AUTO_PACKED_REGISTERS OFF -to wrapper|RED_RBWB_AVMM_S10|RED_RBWB_AVMM_S10_inst|rbwb_inst|rbwb_avmm_qsys_s10|rdbk_wrbk_tree_logic_wrap_inst|tree_ctrl_pipe_c[3].ctrl_pipe|buf_command_out_chain[0][0] }]
#
#add_backend_quartus_options -target qsf -option [list { set_instance_assignment -name QII_AUTO_PACKED_REGISTERS OFF -to wrapper|RED_RBWB_AVMM_S10|RED_RBWB_AVMM_S10_inst|rbwb_inst|rbwb_avmm_qsys_s10|rdbk_wrbk_tree_logic_wrap_inst|tree_ctrl_pipe_c[4].ctrl_pipe|buf_command_out_chain[0][0] }]
#
#add_backend_quartus_options -target qsf -option [list { set_instance_assignment -name QII_AUTO_PACKED_REGISTERS OFF -to wrapper|RED_RBWB_AVMM_S10|RED_RBWB_AVMM_S10_inst|rbwb_inst|rbwb_avmm_qsys_s10|rdbk_wrbk_tree_logic_wrap_inst|tree_ctrl_pipe_c[5].ctrl_pipe|buf_command_out_chain[0][0] }]
#
#add_backend_quartus_options -target qsf -option [list { set_instance_assignment -name QII_AUTO_PACKED_REGISTERS OFF -to wrapper|RED_RBWB_AVMM_S10|RED_RBWB_AVMM_S10_inst|rbwb_inst|rbwb_avmm_qsys_s10|rdbk_wrbk_tree_logic_wrap_inst|tree_ctrl_pipe_c[6].ctrl_pipe|buf_command_out_chain[0][0] }]
#
#add_backend_quartus_options -target qsf -option [list { set_instance_assignment -name QII_AUTO_PACKED_REGISTERS OFF -to wrapper|RED_RBWB_AVMM_S10|RED_RBWB_AVMM_S10_inst|rbwb_inst|rbwb_avmm_qsys_s10|rdbk_wrbk_tree_logic_wrap_inst|tree_ctrl_pipe_c[7].ctrl_pipe|buf_command_out_chain[0][0] }]
