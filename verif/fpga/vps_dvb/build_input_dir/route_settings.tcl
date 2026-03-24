create_pinmux_config -name my_pinmux_config -type RED_DIB_BYPASS
create_pinmux_config -name {RED_DAFM_config} -type RED_DAFM -data_rate 1000 -transmission_error true -bitslip_correction true -pipeline true -sync_reg 3
assign_pinmux_config -name my_pinmux_config
assign_pinmux_config -name RED_DAFM_config
#half cycle, asyn_rst and data paths will be muxable
set_muxable_signal_types -async_data true -async_reset true -half_cycle_path true -routing_path true
# command to fix  wrap error
set_false_path_mux_ratio 1
# # #commands to relax max delay constraints
# jmoctezu (13-May) increase max_delay from 20 to 22
#set_max_delay 23 -from [get_clocks * -type  DUT]  -to [get_wiresets * -type  unmuxed]
#set_max_delay 23 -from [get_wiresets * -type unmuxed]  -to  [get_clocks *  -type DUT]
#set_max_delay 24 -from [get_wiresets * -type unmuxed]  -to  [get_wiresets * -type unmuxed]
#set_max_delay 24 -from [get_wiresets * -type muxed]  -to  [get_wiresets * -type muxed]
#set_max_delay 20 -from [get_clocks * -type  DUT]  -to [get_wiresets * -type  muxed]
#set_max_delay 20 -from [get_wiresets * -type muxed] -to [get_wiresets * -type muxed]
dont_route_aggregator
dont_use_empty_fpgas_for_routing_hops
redmem_auto_perf_model_selection true
#To disable the cable optimization in route stage 
#set_cable_optimization


#added for setup violation
set_redmem_fast_clock_period 10

#set_max_delay 3 -from [get_clocks refclk125_p1_p -type DUT] -to [get_wiresets * ]
#set_max_delay 3 -from [get_wiresets * ] -to [get_clocks refclk125_p1_p -type DUT] 
#set_max_mux_ratio 1 -to refclk125_p1_p
#set_max_mux_ratio 1 -from refclk125_p1_p

set_max_delay 3 -from [get_clocks soc_per_clk -type DUT] -to [get_wiresets * ]
set_max_delay 3 -from [get_wiresets * ] -to [get_clocks soc_per_clk -type DUT] 
set_max_mux_ratio 1 -to soc_per_clk
set_max_mux_ratio 1 -from soc_per_clk

set_max_delay 3 -from [get_clocks physs_func_clk -type DUT] -to [get_wiresets * ]
set_max_delay 3 -from [get_wiresets * ] -to [get_clocks physs_func_clk -type DUT] 
set_max_mux_ratio 1 -to physs_func_clk
set_max_mux_ratio 1 -from physs_func_clk

set_max_delay 3 -from [get_clocks timeref_clk -type DUT] -to [get_wiresets * ]
set_max_delay 3 -from [get_wiresets * ] -to [get_clocks timeref_clk -type DUT] 
set_max_mux_ratio 1 -to timeref_clk
set_max_mux_ratio 1 -from timeref_clk

set_max_delay 3 -from [get_clocks physs_intf0_clk -type DUT] -to [get_wiresets * ]
set_max_delay 3 -from [get_wiresets * ] -to [get_clocks physs_intf0_clk -type DUT] 
set_max_mux_ratio 1 -to physs_intf0_clk
set_max_mux_ratio 1 -from physs_intf0_clk

set_max_delay 3 -from [get_clocks physs_funcx2_clk -type DUT] -to [get_wiresets * ]
set_max_delay 3 -from [get_wiresets * ] -to [get_clocks physs_funcx2_clk -type DUT] 
set_max_mux_ratio 1 -to physs_funcx2_clk
set_max_mux_ratio 1 -from physs_funcx2_clk



#enable_redmem_read_first_mode -redmem_instance {i_fuse_top.i_fuse_ram_wrapper.rf_data[0].dssr_pm_exist.i_ip743rfshpm1r1w128x32m5_dfx_wrapper_data_sprw_soft.ip743rfshpm1r1w128x32m5.i_fuse_dpram_ip743rfshpm1r1w128x32m5_0.dpram}
#enable_redmem_read_first_mode -redmem_instance {i_fuse_top.i_fuse_ram_wrapper.rf_data[10].dssr_pm_exist.i_ip743rfshpm1r1w128x32m5_dfx_wrapper_data_sprw_soft.ip743rfshpm1r1w128x32m5.i_fuse_dpram_ip743rfshpm1r1w128x32m5_0.dpram}
#enable_redmem_read_first_mode -redmem_instance {i_fuse_top.i_fuse_ram_wrapper.rf_data[11].dssr_pm_exist.i_ip743rfshpm1r1w128x32m5_dfx_wrapper_data_sprw_soft.ip743rfshpm1r1w128x32m5.i_fuse_dpram_ip743rfshpm1r1w128x32m5_0.dpram}
#enable_redmem_read_first_mode -redmem_instance {i_fuse_top.i_fuse_ram_wrapper.rf_data[12].dssr_pm_exist.i_ip743rfshpm1r1w128x32m5_dfx_wrapper_data_sprw_soft.ip743rfshpm1r1w128x32m5.i_fuse_dpram_ip743rfshpm1r1w128x32m5_0.dpram}
#enable_redmem_read_first_mode -redmem_instance {i_fuse_top.i_fuse_ram_wrapper.rf_data[13].dssr_pm_exist.i_ip743rfshpm1r1w128x32m5_dfx_wrapper_data_sprw_soft.ip743rfshpm1r1w128x32m5.i_fuse_dpram_ip743rfshpm1r1w128x32m5_0.dpram}
#enable_redmem_read_first_mode -redmem_instance {i_fuse_top.i_fuse_ram_wrapper.rf_data[14].dssr_pm_exist.i_ip743rfshpm1r1w128x32m5_dfx_wrapper_data_sprw_soft.ip743rfshpm1r1w128x32m5.i_fuse_dpram_ip743rfshpm1r1w128x32m5_0.dpram}
#enable_redmem_read_first_mode -redmem_instance {i_fuse_top.i_fuse_ram_wrapper.rf_data[15].dssr_pm_exist.i_ip743rfshpm1r1w128x32m5_dfx_wrapper_data_sprw_soft.ip743rfshpm1r1w128x32m5.i_fuse_dpram_ip743rfshpm1r1w128x32m5_0.dpram}
#enable_redmem_read_first_mode -redmem_instance {i_fuse_top.i_fuse_ram_wrapper.rf_data[16].dssr_pm_exist.i_ip743rfshpm1r1w128x32m5_dfx_wrapper_data_sprw_soft.ip743rfshpm1r1w128x32m5.i_fuse_dpram_ip743rfshpm1r1w128x32m5_0.dpram}
#enable_redmem_read_first_mode -redmem_instance {i_fuse_top.i_fuse_ram_wrapper.rf_data[17].dssr_pm_exist.i_ip743rfshpm1r1w128x32m5_dfx_wrapper_data_sprw_soft.ip743rfshpm1r1w128x32m5.i_fuse_dpram_ip743rfshpm1r1w128x32m5_0.dpram}
#enable_redmem_read_first_mode -redmem_instance {i_fuse_top.i_fuse_ram_wrapper.rf_data[18].dssr_pm_exist.i_ip743rfshpm1r1w128x32m5_dfx_wrapper_data_sprw_soft.ip743rfshpm1r1w128x32m5.i_fuse_dpram_ip743rfshpm1r1w128x32m5_0.dpram}
#enable_redmem_read_first_mode -redmem_instance {i_fuse_top.i_fuse_ram_wrapper.rf_data[19].dssr_pm_exist.i_ip743rfshpm1r1w128x32m5_dfx_wrapper_data_sprw_soft.ip743rfshpm1r1w128x32m5.i_fuse_dpram_ip743rfshpm1r1w128x32m5_0.dpram}
#enable_redmem_read_first_mode -redmem_instance {i_fuse_top.i_fuse_ram_wrapper.rf_data[1].dssr_pm_exist.i_ip743rfshpm1r1w128x32m5_dfx_wrapper_data_sprw_soft.ip743rfshpm1r1w128x32m5.i_fuse_dpram_ip743rfshpm1r1w128x32m5_0.dpram}
#enable_redmem_read_first_mode -redmem_instance {i_fuse_top.i_fuse_ram_wrapper.rf_data[2].dssr_pm_exist.i_ip743rfshpm1r1w128x32m5_dfx_wrapper_data_sprw_soft.ip743rfshpm1r1w128x32m5.i_fuse_dpram_ip743rfshpm1r1w128x32m5_0.dpram}
#enable_redmem_read_first_mode -redmem_instance {i_fuse_top.i_fuse_ram_wrapper.rf_data[3].dssr_pm_exist.i_ip743rfshpm1r1w128x32m5_dfx_wrapper_data_sprw_soft.ip743rfshpm1r1w128x32m5.i_fuse_dpram_ip743rfshpm1r1w128x32m5_0.dpram}
#enable_redmem_read_first_mode -redmem_instance {i_fuse_top.i_fuse_ram_wrapper.rf_data[4].dssr_pm_exist.i_ip743rfshpm1r1w128x32m5_dfx_wrapper_data_sprw_soft.ip743rfshpm1r1w128x32m5.i_fuse_dpram_ip743rfshpm1r1w128x32m5_0.dpram}
#enable_redmem_read_first_mode -redmem_instance {i_fuse_top.i_fuse_ram_wrapper.rf_data[5].dssr_pm_exist.i_ip743rfshpm1r1w128x32m5_dfx_wrapper_data_sprw_soft.ip743rfshpm1r1w128x32m5.i_fuse_dpram_ip743rfshpm1r1w128x32m5_0.dpram}
#enable_redmem_read_first_mode -redmem_instance {i_fuse_top.i_fuse_ram_wrapper.rf_data[6].dssr_pm_exist.i_ip743rfshpm1r1w128x32m5_dfx_wrapper_data_sprw_soft.ip743rfshpm1r1w128x32m5.i_fuse_dpram_ip743rfshpm1r1w128x32m5_0.dpram}
#enable_redmem_read_first_mode -redmem_instance {i_fuse_top.i_fuse_ram_wrapper.rf_data[7].dssr_pm_exist.i_ip743rfshpm1r1w128x32m5_dfx_wrapper_data_sprw_soft.ip743rfshpm1r1w128x32m5.i_fuse_dpram_ip743rfshpm1r1w128x32m5_0.dpram}
#enable_redmem_read_first_mode -redmem_instance {i_fuse_top.i_fuse_ram_wrapper.rf_data[8].dssr_pm_exist.i_ip743rfshpm1r1w128x32m5_dfx_wrapper_data_sprw_soft.ip743rfshpm1r1w128x32m5.i_fuse_dpram_ip743rfshpm1r1w128x32m5_0.dpram}
#enable_redmem_read_first_mode -redmem_instance {i_fuse_top.i_fuse_ram_wrapper.rf_data[9].dssr_pm_exist.i_ip743rfshpm1r1w128x32m5_dfx_wrapper_data_sprw_soft.ip743rfshpm1r1w128x32m5.i_fuse_dpram_ip743rfshpm1r1w128x32m5_0.dpram}
#enable_redmem_read_first_mode -redmem_instance {i_fuse_top.i_fuse_ram_wrapper.rf_sai_sav_res[0].ssr_pm_exist.i_ip743rfshpm1r1w128x32m5_dfx_wrapper_sai_sav_res.ip743rfshpm1r1w128x32m5.i_fuse_dpram_ip743rfshpm1r1w128x32m5_0.dpram}


#set_redmem_init_file hex0.hex -format hex -redmem_instance i_fuse_top.i_fuse_ram_wrapper.rf_data\[0\].dssr_pm_exist.i_ip743rfshpm1r1w128x32m5_dfx_wrapper_data_sprw_soft.ip743rfshpm1r1w128x32m5.i_fuse_dpram_ip743rfshpm1r1w128x32m5_0.dpram
#set_redmem_init_file hex0.hex -redmem_instance  {i_fuse_top.i_fuse_ram_wrapper.rf_data[0].dssr_pm_exist.i_ip743rfshpm1r1w128x32m5_dfx_wrapper_data_sprw_soft.ip743rfshpm1r1w128x32m5.i_fuse_dpram_ip743rfshpm1r1w128x32m5_0.dpram} -format hex
#set_redmem_init_file hex1.hex -redmem_instance  {i_fuse_top.i_fuse_ram_wrapper.rf_data[1].dssr_pm_exist.i_ip743rfshpm1r1w128x32m5_dfx_wrapper_data_sprw_soft.ip743rfshpm1r1w128x32m5.i_fuse_dpram_ip743rfshpm1r1w128x32m5_0.dpram}    -format hex
#set_redmem_init_file hex2.hex -redmem_instance  {i_fuse_top.i_fuse_ram_wrapper.rf_data[2].dssr_pm_exist.i_ip743rfshpm1r1w128x32m5_dfx_wrapper_data_sprw_soft.ip743rfshpm1r1w128x32m5.i_fuse_dpram_ip743rfshpm1r1w128x32m5_0.dpram}    -format hex
#set_redmem_init_file hex3.hex -redmem_instance  {i_fuse_top.i_fuse_ram_wrapper.rf_data[3].dssr_pm_exist.i_ip743rfshpm1r1w128x32m5_dfx_wrapper_data_sprw_soft.ip743rfshpm1r1w128x32m5.i_fuse_dpram_ip743rfshpm1r1w128x32m5_0.dpram}    -format hex
#set_redmem_init_file hex4.hex -redmem_instance  {i_fuse_top.i_fuse_ram_wrapper.rf_data[4].dssr_pm_exist.i_ip743rfshpm1r1w128x32m5_dfx_wrapper_data_sprw_soft.ip743rfshpm1r1w128x32m5.i_fuse_dpram_ip743rfshpm1r1w128x32m5_0.dpram}    -format hex
#set_redmem_init_file hex5.hex -redmem_instance  {i_fuse_top.i_fuse_ram_wrapper.rf_data[5].dssr_pm_exist.i_ip743rfshpm1r1w128x32m5_dfx_wrapper_data_sprw_soft.ip743rfshpm1r1w128x32m5.i_fuse_dpram_ip743rfshpm1r1w128x32m5_0.dpram}    -format hex
#set_redmem_init_file hex6.hex -redmem_instance  {i_fuse_top.i_fuse_ram_wrapper.rf_data[6].dssr_pm_exist.i_ip743rfshpm1r1w128x32m5_dfx_wrapper_data_sprw_soft.ip743rfshpm1r1w128x32m5.i_fuse_dpram_ip743rfshpm1r1w128x32m5_0.dpram}    -format hex
#set_redmem_init_file hex7.hex -redmem_instance  {i_fuse_top.i_fuse_ram_wrapper.rf_data[7].dssr_pm_exist.i_ip743rfshpm1r1w128x32m5_dfx_wrapper_data_sprw_soft.ip743rfshpm1r1w128x32m5.i_fuse_dpram_ip743rfshpm1r1w128x32m5_0.dpram}    -format hex
#set_redmem_init_file hex8.hex -redmem_instance  {i_fuse_top.i_fuse_ram_wrapper.rf_data[8].dssr_pm_exist.i_ip743rfshpm1r1w128x32m5_dfx_wrapper_data_sprw_soft.ip743rfshpm1r1w128x32m5.i_fuse_dpram_ip743rfshpm1r1w128x32m5_0.dpram}    -format hex
#set_redmem_init_file hex9.hex -redmem_instance  {i_fuse_top.i_fuse_ram_wrapper.rf_data[9].dssr_pm_exist.i_ip743rfshpm1r1w128x32m5_dfx_wrapper_data_sprw_soft.ip743rfshpm1r1w128x32m5.i_fuse_dpram_ip743rfshpm1r1w128x32m5_0.dpram}    -format hex
#set_redmem_init_file hex10.hex -redmem_instance {i_fuse_top.i_fuse_ram_wrapper.rf_data[10].dssr_pm_exist.i_ip743rfshpm1r1w128x32m5_dfx_wrapper_data_sprw_soft.ip743rfshpm1r1w128x32m5.i_fuse_dpram_ip743rfshpm1r1w128x32m5_0.dpram}    -format hex
#set_redmem_init_file hex11.hex -redmem_instance {i_fuse_top.i_fuse_ram_wrapper.rf_data[11].dssr_pm_exist.i_ip743rfshpm1r1w128x32m5_dfx_wrapper_data_sprw_soft.ip743rfshpm1r1w128x32m5.i_fuse_dpram_ip743rfshpm1r1w128x32m5_0.dpram}    -format hex
#set_redmem_init_file hex12.hex -redmem_instance {i_fuse_top.i_fuse_ram_wrapper.rf_data[12].dssr_pm_exist.i_ip743rfshpm1r1w128x32m5_dfx_wrapper_data_sprw_soft.ip743rfshpm1r1w128x32m5.i_fuse_dpram_ip743rfshpm1r1w128x32m5_0.dpram}    -format hex
#set_redmem_init_file hex13.hex -redmem_instance {i_fuse_top.i_fuse_ram_wrapper.rf_data[13].dssr_pm_exist.i_ip743rfshpm1r1w128x32m5_dfx_wrapper_data_sprw_soft.ip743rfshpm1r1w128x32m5.i_fuse_dpram_ip743rfshpm1r1w128x32m5_0.dpram}    -format hex
#
##################################################################
## MB6_FA1_F2 --> MB5_FB1_F2
##################################################################

# NOTE: The following tracks are failing due to pinmux transmission error or compare fail.
set_track MB5.FB1_F2.F74.AT2 -dont_use  ;# TYPE:DIFF    CONN: motherboard_6.FA1.BAB0->motherboard_5.FB1.TAB0    BANK: 24->26    PIN: BA3->AT2
set_track MB5.FB1_F2.F74.AT1 -dont_use  ;# Dual of track : MB5.FB1_F2.F74.AT2

##################################################################
## MB6_FA2_F2 --> MB6_FB2_F2
##################################################################

# NOTE: The status of the following tracks was only deduced from DUT comparison (NO PINMUX).
set_track MB6.FA2_F2.F74.AL2 -dont_use  ;# TYPE:SINGLE_ENDED    CONN: motherboard_6.FA2.TAB0->motherboard_6.FB2.BAB0    BANK: 28->25    PIN: AL2->AV13

##################################################################
## MB6_FB2_F2 --> MB6_FA2_F2
##################################################################

# NOTE: The status of the following tracks was only deduced from DUT comparison (NO PINMUX).
set_track MB6.FA2_F2.F74.AL1 -dont_use  ;# TYPE:SINGLE_ENDED    CONN: motherboard_6.FB2.BAB0->motherboard_6.FA2.TAB0    BANK: 24->28    PIN: AY2->AL1

