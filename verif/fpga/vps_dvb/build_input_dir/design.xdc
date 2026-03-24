
# #-------------------------------------------------------------------------------
# # Original method to resolve latch timing issue in Memory controller
# # - doesn't address paths from D pin
# # - superceded by method below
# #-------------------------------------------------------------------------------
# # set LD_list_inv [get_cells -quiet "part/soc/memss_top/*/*/*/*/*/*/*/*/*/*/*/*/LD_*" -filter { PRIMITIVE_SUBGROUP==LATCH && IS_G_INVERTED==1 }]
# # set LD_list     [get_cells -quiet "part/soc/memss_top/*/*/*/*/*/*/*/*/*/*/*/*/LD_*" -filter { PRIMITIVE_SUBGROUP==LATCH }]
# # 
# # if {[llength ${LD_list_inv}]} {
# #    set_disable_timing -from GE -to Q ${LD_list_inv}
# #    #set_disable_timing -from GE -to Q ${LD_list}
# # }
# 
# #-------------------------------------------------------------------------------
# # Updated method to address timing issues in Memory Controller latches
# # - applies multicycle paths between startpoint and endpoint latches
# # - addresses a time-borrowing issue in timing paths originating from the endpoint latches
# #-------------------------------------------------------------------------------
# set mcp_latch_pairs [list \
#    "part/soc/memss_top/mc*_top_wrap/mc_top/mc/mc_channel_*/mcmnts_wrap/mcmnts/mc_subch_wdb_*/mc_wdb_arr/mc_wdb_slice_*/latch_BEEntryDnnn2H/GEN_SEQ_VEC*.latch_bit/ctech_lib_latch/rtlcreg_o/LD_INS" \
#    "part/soc/memss_top/mc*_top_wrap/mc_top/mc/mc_channel_*/mcmnts_wrap/mcmnts/mc_subch_wdb_*/mc_wdb_arr/mc_wdb_slice_*/BE_and_Parity_Array_write*.latch_p_*/GEN_SEQ_VEC*.latch_p_bit/ctech_lib_latch_p/rtlcreg_o/LD_INS" \
# ]
# 
# foreach {latch_bit latch_p_bit} ${mcp_latch_pairs} {
#    set latch_bit_cells   [get_cells -quiet ${latch_bit}   -filter {PRIMITIVE_SUBGROUP==LATCH}]
#    set latch_p_bit_cells [get_cells -quiet ${latch_p_bit} -filter {PRIMITIVE_SUBGROUP==LATCH}]
#    if {${latch_bit_cells} != "" && ${latch_p_bit_cells} != ""} {
#       set_multicycle_path -from ${latch_bit_cells} -to   ${latch_p_bit_cells} -setup 2
#       set_multicycle_path -from ${latch_bit_cells} -to   ${latch_p_bit_cells} -hold 1
#       set_multicycle_path -to   ${latch_bit_cells} -from ${latch_p_bit_cells} -setup 2
#       set_multicycle_path -to   ${latch_bit_cells} -from ${latch_p_bit_cells} -hold 1
#    }
# }
# 
# 
# set mcp_latches [list \
#    "part/soc/memss_top/mc*_top_wrap/mc_top/mc/mc_channel_*/mcscheds_wrap/mcscheds/mc_subch_sched_*/mcwpa/WPQ_Array*.latch_WPAarrayD3nnH*.Address/GEN_SEQ_VEC*.latch_bit/ctech_lib_latch/rtlcreg_o/LD_INS" \
#    "part/soc/memss_top/mc*_top_wrap/mc_top/mc/mc_channel_*/mcscheds_wrap/mcscheds/mc_subch_sched_*/mcipa/RPA_Array*.latch_IPAArrayD3nnH*.*/GEN_SEQ_VEC*.latch_bit/ctech_lib_latch/rtlcreg_o/LD_INS" \
# ]
# 
# foreach {latch_bit} ${mcp_latches} {
#    set latch_bit_cells   [get_cells -quiet ${latch_bit}   -filter {PRIMITIVE_SUBGROUP==LATCH}]
#    if {${latch_bit_cells} != ""} {
#       set_multicycle_path -from ${latch_bit_cells} -to   ${latch_bit_cells} -setup 2
#       set_multicycle_path -from ${latch_bit_cells} -to   ${latch_bit_cells} -hold 1
#    }
# }
# 
# 
# #-------------------------------------------------------------------------------
# # False path for clock as data (hold violations)
# #-------------------------------------------------------------------------------
# set xtal_sync_pin "part/soc/sboidpwrapper/sboidp/ncu/idprtbs/rtb_wrapper_top/i_rtb_top/i_rtb/crys_clk_sync/behavioral.double_sync2/rtlcreg_sync_0/FD_INS/D"
# if {[llength [get_pins -quiet ${xtal_sync_pin}]]} {
#    set_false_path -to [get_pins ${xtal_sync_pin}]
# }
# 
# 
# #-------------------------------------------------------------------------------
# # DDR4 MIG constraints
# #-------------------------------------------------------------------------------
# set ddr_phy_instances [get_cells -quiet part/fpga_misc/fpga_mc_glue_mig_ddr_top_2ch_mc*/mig_0_i]
# if {[llength ${ddr_phy_instances}]} {
#    foreach phy_instance ${ddr_phy_instances} {
#       set ui_clk ""
#       set ui_clk [get_clocks -of_objects [get_pins "${phy_instance}/*ui_clk"]]
#       set ui_clk_src [get_property SOURCE_PINS [get_clocks ${ui_clk}]]
#       set tmp1 [split [lindex [split ${phy_instance} "/"] 2] "_"]
#       set mc_num [lindex ${tmp1} [expr [llength ${tmp1}] - 1]]
#       set new_ui_clk_name "ddr4_ui_clk_${mc_num}"
#       create_generated_clock -name ${new_ui_clk_name} [get_pins ${ui_clk_src}]
#       set_false_path -from [get_clocks ${new_ui_clk_name}] -to   [get_clocks glbclk*]
#       set_false_path -to   [get_clocks ${new_ui_clk_name}] -from [get_clocks glbclk*]
#    }
# }
# 
# 
# #-------------------------------------------------------------------------------
# # Constraints for SSI PCIe IP
# #-------------------------------------------------------------------------------
# set ssi_phy_instance [get_cells -quiet "part/soc/pciess_wrap/pciess/par_phy_tlpl_x4/dekel_wrapx4/sxp_pcie_phy_wrapper/pcie_phy"]
# if {[llength ${ssi_phy_instance}]} {
#    ###############################################################################
#    # Timing Constraints - SSI
#    ###############################################################################
# 
#    # TXOUTCLKSEL switches during reset. Set the tool to analyze timing with TXOUTCLKSEL set to 'b101.
#    current_instance ${ssi_phy_instance}
#    set_case_analysis 1 [get_nets -hierarchical -filter {NAME =~ *gen_cpll_cal_inst[*].gtwizard_ultrascale_v1_6_2_gthe3_cpll_cal_inst/GTHE3_TXOUTCLKSEL_OUT[2]}]
#    set_case_analysis 0 [get_nets -hierarchical -filter {NAME =~ *gen_cpll_cal_inst[*].gtwizard_ultrascale_v1_6_2_gthe3_cpll_cal_inst/GTHE3_TXOUTCLKSEL_OUT[1]}]
#    set_case_analysis 1 [get_nets -hierarchical -filter {NAME =~ *gen_cpll_cal_inst[*].gtwizard_ultrascale_v1_6_2_gthe3_cpll_cal_inst/GTHE3_TXOUTCLKSEL_OUT[0]}]
# 
#    set_case_analysis 1 [get_pins -hierarchical -filter {NAME =~ *gen_channel_container[*].*gen_gthe3_channel_inst[*].GTHE3_CHANNEL_PRIM_INST/TXRATE[0]}]
#    set_case_analysis 1 [get_pins -hierarchical -filter {NAME =~ *gen_channel_container[*].*gen_gthe3_channel_inst[*].GTHE3_CHANNEL_PRIM_INST/RXRATE[0]}]
#    set_case_analysis 0 [get_pins -hierarchical -filter {NAME =~ *gen_channel_container[*].*gen_gthe3_channel_inst[*].GTHE3_CHANNEL_PRIM_INST/TXRATE[1]}]
#    set_case_analysis 0 [get_pins -hierarchical -filter {NAME =~ *gen_channel_container[*].*gen_gthe3_channel_inst[*].GTHE3_CHANNEL_PRIM_INST/RXRATE[1]}]
# 
#    # Set Divide By 2
#    set_case_analysis 1 [get_pins {pcie_gt_top_i/phy_clk_i/bufg_gt_pclk/DIV[0]}]
#    set_case_analysis 0 [get_pins {pcie_gt_top_i/phy_clk_i/bufg_gt_pclk/DIV[1]}]
#    set_case_analysis 0 [get_pins {pcie_gt_top_i/phy_clk_i/bufg_gt_pclk/DIV[2]}]
# 
#    current_instance
#    
#    foreach ssx_chan_txoutclk [get_clocks *GTHE*] {
#       set ssx_chan_clk_src_pin [get_property SOURCE_PINS ${ssx_chan_txoutclk}]
#       set chan_inst_num [lindex [regexp -inline -- {\[([0-9]+)\]} [lindex [split [lsearch -inline [split ${ssx_chan_clk_src_pin} "/"] "*PRIM_INST"] "."] 1]] 1]
#       set new_ssx_chan_txoutclk_name "SSX_TXOUTCLK_${chan_inst_num}"
#       create_generated_clock -name ${new_ssx_chan_txoutclk_name} [get_pins ${ssx_chan_clk_src_pin}]
#       
#       set_false_path -from [get_clocks ${new_ssx_chan_txoutclk_name}] -to   [get_clocks PCIESSX4_PCIE_REFCLK_P]
#       set_false_path -to   [get_clocks ${new_ssx_chan_txoutclk_name}] -from [get_clocks PCIESSX4_PCIE_REFCLK_P]
#    }
# 
#    create_generated_clock -name {gtx_sxp_pclk_bufg} [get_pins "${ssi_phy_instance}/pcie_gt_top_i/phy_clk_i/bufg_gt_pclk/O"]
# 
#    set_false_path -from [get_clocks gtx_sxp_pclk_bufg] -to   [get_clocks [list glbclk* PCIESSX4_PCIE_REFCLK_P]]
#    set_false_path -to   [get_clocks gtx_sxp_pclk_bufg] -from [get_clocks [list glbclk* PCIESSX4_PCIE_REFCLK_P]]
# }
# 
# 
# #-------------------------------------------------------------------------------
# # Constraints for FIDIC PCIe IP
# #-------------------------------------------------------------------------------
# set fidic_phy_instance [get_cells -quiet "part/fpga_misc/fidic_top_wrap*/fpga_idi_top_i/pcie3_ultrascale_2_i/inst"]
# if {[llength ${fidic_phy_instance}]} {
#    ###############################################################################
#    # Timing Constraints - fidic
#    ###############################################################################
# 
#    # TXOUTCLKSEL switches during reset. Set the tool to analyze timing with TXOUTCLKSEL set to 'b101.
#    current_instance ${fidic_phy_instance}
#    set_case_analysis 1 [get_nets {gt_top_i/PHY_TXOUTCLKSEL[2]}]
#    set_case_analysis 0 [get_nets {gt_top_i/PHY_TXOUTCLKSEL[1]}]
#    set_case_analysis 1 [get_nets {gt_top_i/PHY_TXOUTCLKSEL[0]}]
# 
#    set_case_analysis 1 [get_pins -hierarchical -filter {NAME =~ *gen_channel_container[*].*gen_gthe3_channel_inst[*].GTHE3_CHANNEL_PRIM_INST/TXRATE[0]}]
#    set_case_analysis 1 [get_pins -hierarchical -filter {NAME =~ *gen_channel_container[*].*gen_gthe3_channel_inst[*].GTHE3_CHANNEL_PRIM_INST/RXRATE[0]}]
#    set_case_analysis 0 [get_pins -hierarchical -filter {NAME =~ *gen_channel_container[*].*gen_gthe3_channel_inst[*].GTHE3_CHANNEL_PRIM_INST/TXRATE[1]}]
#    set_case_analysis 0 [get_pins -hierarchical -filter {NAME =~ *gen_channel_container[*].*gen_gthe3_channel_inst[*].GTHE3_CHANNEL_PRIM_INST/RXRATE[1]}]
#    #
#    #
#    #
#    # Set Divide By 2
#    set_case_analysis 1 [get_pins {gt_top_i/phy_clk_i/bufg_gt_userclk/DIV[0]}]
#    set_case_analysis 0 [get_pins {gt_top_i/phy_clk_i/bufg_gt_userclk/DIV[1]}]
#    set_case_analysis 0 [get_pins {gt_top_i/phy_clk_i/bufg_gt_userclk/DIV[2]}]
#    # Set Divide By 2
#    set_case_analysis 1 [get_pins {gt_top_i/phy_clk_i/bufg_gt_pclk/DIV[0]}]
#    set_case_analysis 0 [get_pins {gt_top_i/phy_clk_i/bufg_gt_pclk/DIV[1]}]
#    set_case_analysis 0 [get_pins {gt_top_i/phy_clk_i/bufg_gt_pclk/DIV[2]}]
# 
#    # Set Divide By 2
#    set_case_analysis 1 [get_pins {gt_top_i/bufg_mcap_clk/DIV[0]}]
#    set_case_analysis 0 [get_pins {gt_top_i/bufg_mcap_clk/DIV[1]}]
#    set_case_analysis 0 [get_pins {gt_top_i/bufg_mcap_clk/DIV[2]}]
#    # Set Divide By 1
#    set_case_analysis 0 [get_pins {gt_top_i/phy_clk_i/bufg_gt_coreclk/DIV[0]}]
#    set_case_analysis 0 [get_pins {gt_top_i/phy_clk_i/bufg_gt_coreclk/DIV[1]}]
#    set_case_analysis 0 [get_pins {gt_top_i/phy_clk_i/bufg_gt_coreclk/DIV[2]}]
#    #
# 
# 
#    #
# 
#    #------------------------------------------------------------------------------
#    # CDC Registers
#    #------------------------------------------------------------------------------
#    # This path is crossing clock domains between pipe_clk and sys_clk
#    set_false_path -from [get_pins {gt_top_i/phy_rst_i/prst_n_r_reg[7]/C}] -to [get_pins {gt_top_i/phy_rst_i/sync_prst_n/sync_vec[0].sync_cell_i/sync_reg[0]/D}]
#    # These paths are crossing clock domains between sys_clk and user_clk
#    set_false_path -from [get_pins gt_top_i/phy_rst_i/idle_reg/C] -to [get_pins {pcie3_uscale_top_inst/init_ctrl_inst/reg_phy_rdy_reg[0]/D}]
#    set_false_path -from [get_pins {gt_top_i/gt_wizard.gtwizard_top_i/pcie3_ultrascale_2_gt_i/inst/gen_gtwizard_gthe3_top.pcie3_ultrascale_2_gt_gtwizard_gthe3_inst/gen_gtwizard_gthe3.gen_channel_container[*].gen_enabled_channel.gthe3_channel_wrapper_inst/channel_inst/gthe3_channel_gen.gen_gthe3_channel_inst[*].GTHE3_CHANNEL_PRIM_INST/RXUSRCLK2}] -to [get_pins {gt_top_i/phy_rst_i/sync_phystatus/sync_vec[*].sync_cell_i/sync_reg[0]/D}]
#    set_false_path -from [get_pins {gt_top_i/gt_wizard.gtwizard_top_i/pcie3_ultrascale_2_gt_i/inst/gen_gtwizard_gthe3_top.pcie3_ultrascale_2_gt_gtwizard_gthe3_inst/gen_gtwizard_gthe3.gen_channel_container[*].gen_enabled_channel.gthe3_channel_wrapper_inst/channel_inst/gthe3_channel_gen.gen_gthe3_channel_inst[*].GTHE3_CHANNEL_PRIM_INST/RXUSRCLK2}] -to [get_pins {gt_top_i/phy_rst_i/sync_rxresetdone/sync_vec[*].sync_cell_i/sync_reg[0]/D}]
#    set_false_path -from [get_pins {gt_top_i/gt_wizard.gtwizard_top_i/pcie3_ultrascale_2_gt_i/inst/gen_gtwizard_gthe3_top.pcie3_ultrascale_2_gt_gtwizard_gthe3_inst/gen_gtwizard_gthe3.gen_channel_container[*].gen_enabled_channel.gthe3_channel_wrapper_inst/channel_inst/gthe3_channel_gen.gen_gthe3_channel_inst[*].GTHE3_CHANNEL_PRIM_INST/TXUSRCLK2}] -to [get_pins {gt_top_i/phy_rst_i/sync_txresetdone/sync_vec[*].sync_cell_i/sync_reg[0]/D}]
# 
#    #
# 
#    #------------------------------------------------------------------------------
#    # Asynchronous Pins
#    #------------------------------------------------------------------------------
#    # These pins are not associated with any clock domain
#    set_false_path -through [get_pins -hierarchical -filter NAME=~*/RXELECIDLE]
#    set_false_path -through [get_pins -hierarchical -filter NAME=~*/PCIEPERST0B]
#    set_false_path -through [get_pins -hierarchical -filter NAME=~*/PCIERATEGEN3]
#    set_false_path -through [get_pins -hierarchical -filter NAME=~*/RXPRGDIVRESETDONE]
#    set_false_path -through [get_pins -hierarchical -filter NAME=~*/TXPRGDIVRESETDONE]
#    set_false_path -through [get_pins -hierarchical -filter NAME=~*/PCIESYNCTXSYNCDONE]
#    set_false_path -through [get_pins -hierarchical -filter NAME=~*/GTPOWERGOOD]
#    set_false_path -through [get_pins -hierarchical -filter NAME=~*/CPLLLOCK]
#    set_false_path -through [get_pins -hierarchical -filter NAME=~*/QPLL1LOCK]
# 
# 
# 
#    ## Set the clock root on the PCIe clocks to limit skew to the PCIe Hardblock pins.
#    #set_property USER_CLOCK_ROOT X7Y0 [get_nets -of_objects [get_pins gt_top_i/phy_clk_i/bufg_gt_pclk/O]]
#    #set_property USER_CLOCK_ROOT X7Y0 [get_nets -of_objects [get_pins gt_top_i/phy_clk_i/bufg_gt_userclk/O]]
#    #set_property USER_CLOCK_ROOT X7Y0 [get_nets -of_objects [get_pins gt_top_i/phy_clk_i/bufg_gt_coreclk/O]]
#    #
#    current_instance
# 
#    create_generated_clock -name {fidic_pipe_clk} [get_pins "${fidic_phy_instance}/gt_top_i/phy_clk_i/bufg_gt_pclk/O"]
#    create_generated_clock -name {fidic_user_clk} [get_pins "${fidic_phy_instance}/gt_top_i/phy_clk_i/bufg_gt_userclk/O"]
# 
#    set_false_path -from [get_clocks fidic_pipe_clk] -to   [get_clocks glbclk*]
#    set_false_path -to   [get_clocks fidic_pipe_clk] -from [get_clocks glbclk*]
# 
#    set_false_path -from [get_clocks fidic_user_clk] -to   [get_clocks glbclk*]
#    set_false_path -to   [get_clocks fidic_user_clk] -from [get_clocks glbclk*]
# }
# 
# 
# 
# #-------------------------------------------------------------------------------
# # Constraints for FTDI tracker PCIe IP
# #-------------------------------------------------------------------------------
# set ftdi_phy_instance [get_cells -quiet "part/fpga_misc/ftdi_tracker_top_gen2*/tracker_comm_inst/pcie3_ultrascale_2_i/inst"]
# if {[llength ${ftdi_phy_instance}]} {
#    ###############################################################################
#    # Timing Constraints - fidic
#    ###############################################################################
# 
#    # TXOUTCLKSEL switches during reset. Set the tool to analyze timing with TXOUTCLKSEL set to 'b101.
#    current_instance ${ftdi_phy_instance}
#    set_case_analysis 1 [get_nets {gt_top_i/PHY_TXOUTCLKSEL[2]}]
#    set_case_analysis 0 [get_nets {gt_top_i/PHY_TXOUTCLKSEL[1]}]
#    set_case_analysis 1 [get_nets {gt_top_i/PHY_TXOUTCLKSEL[0]}]
# 
#    set_case_analysis 1 [get_pins -hierarchical -filter {NAME =~ *gen_channel_container[*].*gen_gthe3_channel_inst[*].GTHE3_CHANNEL_PRIM_INST/TXRATE[0]}]
#    set_case_analysis 1 [get_pins -hierarchical -filter {NAME =~ *gen_channel_container[*].*gen_gthe3_channel_inst[*].GTHE3_CHANNEL_PRIM_INST/RXRATE[0]}]
#    set_case_analysis 0 [get_pins -hierarchical -filter {NAME =~ *gen_channel_container[*].*gen_gthe3_channel_inst[*].GTHE3_CHANNEL_PRIM_INST/TXRATE[1]}]
#    set_case_analysis 0 [get_pins -hierarchical -filter {NAME =~ *gen_channel_container[*].*gen_gthe3_channel_inst[*].GTHE3_CHANNEL_PRIM_INST/RXRATE[1]}]
#    #
#    #
#    #
#    # Set Divide By 2
#    set_case_analysis 1 [get_pins {gt_top_i/phy_clk_i/bufg_gt_userclk/DIV[0]}]
#    set_case_analysis 0 [get_pins {gt_top_i/phy_clk_i/bufg_gt_userclk/DIV[1]}]
#    set_case_analysis 0 [get_pins {gt_top_i/phy_clk_i/bufg_gt_userclk/DIV[2]}]
#    # Set Divide By 2
#    set_case_analysis 1 [get_pins {gt_top_i/phy_clk_i/bufg_gt_pclk/DIV[0]}]
#    set_case_analysis 0 [get_pins {gt_top_i/phy_clk_i/bufg_gt_pclk/DIV[1]}]
#    set_case_analysis 0 [get_pins {gt_top_i/phy_clk_i/bufg_gt_pclk/DIV[2]}]
# 
#    # Set Divide By 2
#    set_case_analysis 1 [get_pins {gt_top_i/bufg_mcap_clk/DIV[0]}]
#    set_case_analysis 0 [get_pins {gt_top_i/bufg_mcap_clk/DIV[1]}]
#    set_case_analysis 0 [get_pins {gt_top_i/bufg_mcap_clk/DIV[2]}]
#    # Set Divide By 1
#    set_case_analysis 0 [get_pins {gt_top_i/phy_clk_i/bufg_gt_coreclk/DIV[0]}]
#    set_case_analysis 0 [get_pins {gt_top_i/phy_clk_i/bufg_gt_coreclk/DIV[1]}]
#    set_case_analysis 0 [get_pins {gt_top_i/phy_clk_i/bufg_gt_coreclk/DIV[2]}]
#    #
# 
# 
#    #
# 
#    #------------------------------------------------------------------------------
#    # CDC Registers
#    #------------------------------------------------------------------------------
#    # This path is crossing clock domains between pipe_clk and sys_clk
#    set_false_path -from [get_pins {gt_top_i/phy_rst_i/prst_n_r_reg[7]/C}] -to [get_pins {gt_top_i/phy_rst_i/sync_prst_n/sync_vec[0].sync_cell_i/sync_reg[0]/D}]
#    # These paths are crossing clock domains between sys_clk and user_clk
#    set_false_path -from [get_pins gt_top_i/phy_rst_i/idle_reg/C] -to [get_pins {pcie3_uscale_top_inst/init_ctrl_inst/reg_phy_rdy_reg[0]/D}]
#    set_false_path -from [get_pins {gt_top_i/gt_wizard.gtwizard_top_i/pcie3_ultrascale_2_gt_i/inst/gen_gtwizard_gthe3_top.pcie3_ultrascale_2_gt_gtwizard_gthe3_inst/gen_gtwizard_gthe3.gen_channel_container[*].gen_enabled_channel.gthe3_channel_wrapper_inst/channel_inst/gthe3_channel_gen.gen_gthe3_channel_inst[*].GTHE3_CHANNEL_PRIM_INST/RXUSRCLK2}] -to [get_pins {gt_top_i/phy_rst_i/sync_phystatus/sync_vec[*].sync_cell_i/sync_reg[0]/D}]
#    set_false_path -from [get_pins {gt_top_i/gt_wizard.gtwizard_top_i/pcie3_ultrascale_2_gt_i/inst/gen_gtwizard_gthe3_top.pcie3_ultrascale_2_gt_gtwizard_gthe3_inst/gen_gtwizard_gthe3.gen_channel_container[*].gen_enabled_channel.gthe3_channel_wrapper_inst/channel_inst/gthe3_channel_gen.gen_gthe3_channel_inst[*].GTHE3_CHANNEL_PRIM_INST/RXUSRCLK2}] -to [get_pins {gt_top_i/phy_rst_i/sync_rxresetdone/sync_vec[*].sync_cell_i/sync_reg[0]/D}]
#    set_false_path -from [get_pins {gt_top_i/gt_wizard.gtwizard_top_i/pcie3_ultrascale_2_gt_i/inst/gen_gtwizard_gthe3_top.pcie3_ultrascale_2_gt_gtwizard_gthe3_inst/gen_gtwizard_gthe3.gen_channel_container[*].gen_enabled_channel.gthe3_channel_wrapper_inst/channel_inst/gthe3_channel_gen.gen_gthe3_channel_inst[*].GTHE3_CHANNEL_PRIM_INST/TXUSRCLK2}] -to [get_pins {gt_top_i/phy_rst_i/sync_txresetdone/sync_vec[*].sync_cell_i/sync_reg[0]/D}]
# 
#    #
# 
#    #------------------------------------------------------------------------------
#    # Asynchronous Pins
#    #------------------------------------------------------------------------------
#    # These pins are not associated with any clock domain
#    set_false_path -through [get_pins -hierarchical -filter NAME=~*/RXELECIDLE]
#    set_false_path -through [get_pins -hierarchical -filter NAME=~*/PCIEPERST0B]
#    set_false_path -through [get_pins -hierarchical -filter NAME=~*/PCIERATEGEN3]
#    set_false_path -through [get_pins -hierarchical -filter NAME=~*/RXPRGDIVRESETDONE]
#    set_false_path -through [get_pins -hierarchical -filter NAME=~*/TXPRGDIVRESETDONE]
#    set_false_path -through [get_pins -hierarchical -filter NAME=~*/PCIESYNCTXSYNCDONE]
#    set_false_path -through [get_pins -hierarchical -filter NAME=~*/GTPOWERGOOD]
#    set_false_path -through [get_pins -hierarchical -filter NAME=~*/CPLLLOCK]
#    set_false_path -through [get_pins -hierarchical -filter NAME=~*/QPLL1LOCK]
# 
# 
# 
#    ## Set the clock root on the PCIe clocks to limit skew to the PCIe Hardblock pins.
#    #set_property USER_CLOCK_ROOT X7Y0 [get_nets -of_objects [get_pins gt_top_i/phy_clk_i/bufg_gt_pclk/O]]
#    #set_property USER_CLOCK_ROOT X7Y0 [get_nets -of_objects [get_pins gt_top_i/phy_clk_i/bufg_gt_userclk/O]]
#    #set_property USER_CLOCK_ROOT X7Y0 [get_nets -of_objects [get_pins gt_top_i/phy_clk_i/bufg_gt_coreclk/O]]
#    #
#    current_instance
# 
#    create_generated_clock -name {pipe_clk_cmi} [get_pins "${ftdi_phy_instance}/gt_top_i/phy_clk_i/bufg_gt_pclk/O"]
#    create_generated_clock -name {user_clk_cmi} [get_pins "${ftdi_phy_instance}/gt_top_i/phy_clk_i/bufg_gt_userclk/O"]
# 
#    set_false_path -from [get_clocks pipe_clk_cmi] -to   [get_clocks glbclk*]
#    set_false_path -to   [get_clocks pipe_clk_cmi] -from [get_clocks glbclk*]
# 
#    set_false_path -from [get_clocks user_clk_cmi] -to   [get_clocks glbclk*]
#    set_false_path -to   [get_clocks user_clk_cmi] -from [get_clocks glbclk*]
# }
# 
