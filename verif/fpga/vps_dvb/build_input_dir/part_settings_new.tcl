#set_muxing_type RED_DIB_BYPASS
create_pinmux_config -name my_pinmux_config -type RED_DIB_BYPASS
assign_pinmux_config -name my_pinmux_config
set_filling_rate -resources lut 0.7
#set_filling_rate 0.7
#lock MB1_FB2_F1
#lock MB1_FB1_F1
#lock MB1_FB1_F2
#lock MB1_FB2_F2

# Aymen - 1-28-22
set_non_crossing_clock_domain pipe_clock

#add_to_group GCLK5_group [list pch_fpga_top pch parcsmeb parcsmeb_pwell_wrapper csmeb]
#add_to_group GCLK5_group [list pch_fpga_top pch parcse]
#
#SIEMENS add_hard_cable_assignment MB1/FB1_F2/TB0 MB1/FA1_F1/BB2 -cable_model IC-PDS-CABLE-R1
#SIEMENS add_hard_cable_assignment MB1/FB2_F1/TB2 MB1/FA1_F1/BA2 -cable_model IC-PDS-CABLE-R1
#SIEMENS add_hard_cable_assignment MB1/FB2_F1/BA1 MB1/FA1_F1/BB1 -cable_model IC-PDS-CABLE-R1
#SIEMENS add_hard_cable_assignment MB1/FB2_F1/BA0 MB1/FA1_F1/BA1 -cable_model IC-PDS-CABLE-R1
#SIEMENS add_hard_cable_assignment MB1/FB2_F2/TA0 MB1/FA1_F1/TA2 -cable_model IC-PDS-CABLE-R1
#SIEMENS add_hard_cable_assignment MB1/FA1_F2/BB0 MB1/FA2_F1/BA0 -cable_model IC-PDS-CABLE-R1
#SIEMENS add_hard_cable_assignment MB1/FA1_F2/TA1 MB1/FA2_F1/BA2 -cable_model IC-PDS-CABLE-R1
#SIEMENS add_hard_cable_assignment MB1/FA1_F2/TAB0 MB1/FA2_F1/BB2 -cable_model IC-PDS-CABLE-R1
#SIEMENS add_hard_cable_assignment MB1/FB2_F1/BB1 MB1/FA1_F2/TA0 -cable_model IC-PDS-CABLE-R1
#SIEMENS add_hard_cable_assignment MB1/FB2_F1/BA2 MB1/FA1_F2/BAB0 -cable_model IC-PDS-CABLE-R1
#SIEMENS add_hard_cable_assignment MB1/FB2_F2/TA1 MB1/FA1_F2/TB1 -cable_model IC-PDS-CABLE-R1
#SIEMENS add_hard_cable_assignment MB1/FB2_F1/TA2 MB1/FA2_F1/BB1 -cable_model IC-PDS-CABLE-R1
#SIEMENS add_hard_cable_assignment MB1/FB2_F1/BB2 MB1/FA2_F1/TA2 -cable_model IC-PDS-CABLE-R1
#SIEMENS add_hard_cable_assignment MB1/FB2_F2/TB1 MB1/FA2_F1/TB2 -cable_model IC-PDS-CABLE-R1
#SIEMENS add_hard_cable_assignment MB1/FB2_F2/TB0 MB1/FB1_F2/TA0 -cable_model IC-PDS-CABLE-R1
#SIEMENS add_hard_cable_assignment MB1/FB2_F2/TAB0 MB1/FB1_F2/TA1 -cable_model IC-PDS-CABLE-R1
#SIEMENS add_hard_cable_assignment MB1/FB2_F2/BB0 MB1/FB1_F2/BAB0 -cable_model IC-PDS-CABLE-R1
#SIEMENS add_hard_cable_assignment MB1/FB2_F2/BAB0 MB1/FB1_F2/TAB0 -cable_model IC-PDS-CABLE-R1
#SIEMENS set_allowed_cables_number -lvds 18 -mgt 0


#set_soft_assignment [list haps_wrapper i_cpm_top cpm_vid_top parvc8000d_ss] [list MB1_FB2_F2] ;#cpm_lib_parvc8000d_ss
#
#set_soft_assignment [list haps_wrapper i_cpm_top cpm_vid_top parvc8000e_part0] [list MB1_FA2_F1] ;#cpm_lib_parvc8000e_part0
#
#set_soft_assignment [list haps_wrapper i_cpm_top cpm_vid_top parvc8000e_part1] [list MB1_FA2_F1] ;#cpm_lib_parvc8000e_part1
#
#
#set_soft_assignment [list haps_wrapper i_cpm_top cpm_vid_top parvc8000e_part3 i_cpm_vc8000e_p3_rf_mems] [list MB1_FA1_F1] ;#cpm_dfx_lib_vid_vc8000e_p3_rf_mems
#
#set_soft_assignment [list haps_wrapper i_cpm_top cpm_vid_top parvc8000e_part3 i_cpm_vc8000e_p3_sram_mems] [list MB1_FA1_F1] ;#cpm_dfx_lib_vid_vc8000e_p3_sram_mems
#
#
#
#set_soft_assignment [list haps_wrapper i_cpm_top cpm_vid_top parvc8000e_part3 i_vc8000e_p3 u_part3 u_clock_and_reset] [list MB1_FA1_F2] ;#cpm_vid_rtl_lib_vc8000e_clock_and_reset
#
#set_soft_assignment [list haps_wrapper i_cpm_top cpm_vid_top parvc8000e_part3 i_vc8000e_p3 u_part3 u_core3] [list MB1_FA1_F2] ;#cpm_vid_rtl_lib_vc8000e_core3
#
#set_soft_assignment [list haps_wrapper i_cpm_top cpm_vid_top parvc8000e_part3 i_vc8000e_p3 u_part3 u_func_mem_wrap_part3] [list MB1_FA1_F1] ;#cpm_vid_rtl_lib_func_mem_wrap_part3_NUM_CLK_1_NUM_RST_1_DFT_BUSIN_SIZE_2_DFT_BUSOUT_SIZE_1_TESTMODE_SIZE_1
#
#set_soft_assignment [list haps_wrapper i_cpm_top cpm_vid_top parvc8000e_part3 i_vc8000e_p3 u_part3 u_rams3] [list MB1_FA1_F1] ;#cpm_vid_rtl_lib_vc8000e_rams3
#
#set_soft_assignment [list haps_wrapper i_cpm_top cpm_vid_top parvc8000e_part3 i_vid_vc8000ep3_misc] [list MB1_FA1_F1] ;#cpm_vid_rtl_lib_vid_misc_vc8000e_p3_DEPTH_2_N_EP3_RST_DELAY_3
#
#set_soft_assignment [list haps_wrapper i_cpm_top cpm_vid_top parvc8000e_part3 p_clk_parvc8000e_part3_pdop] [list MB1_FA1_F1] ;#gnr_shared_lib_gnr_pdop_div_by_2_redUniq_3682
#
#set_soft_assignment [list haps_wrapper i_cpm_top cpm_vid_top parvc8000e_part3 pclk_vc8000e_part3_pdop_rst_gen] [list MB1_FA1_F1] ;#cpm_shared_lib_gnr_pdop_clkdivrst_gen_6d377fcd89062b2b725a6c72ae27d047
#
#set_soft_assignment [list haps_wrapper i_cpm_top cpm_vid_top parvc8000e_ss] [list MB1_FA1_F1] ;#cpm_lib_parvc8000e_ss
#
#set_soft_assignment [list haps_wrapper i_cpm_top parcpmaram] [list MB1_FB1_F2] ;#cpm_lib_parcpmaram_xa
#
#set_soft_assignment [list haps_wrapper i_cpm_top parcpmcast1] [list MB1_FB1_F2] ;#cpm_lib_parcpmcast1_xa
#
#set_soft_assignment [list haps_wrapper i_cpm_top parcpmhi] [list MB1_FB1_F2] ;#cpm_lib_parcpmhi
#
#set_soft_assignment [list haps_wrapper i_cpm_top parcpmssma_xa] [list MB1_FB1_F1] ;#cpm_lib_parcpmssma_xa
#
#set_soft_assignment [list haps_wrapper i_cpm_top parcpmssmb] [list MB1_FB2_F1] ;#cpm_lib_parcpmssmb
#
#set_soft_assignment [list haps_wrapper i_cpm_top parcpmssmc_xa_0] [list MB1_FB1_F2] ;#cpm_lib_parcpmssmc_xa_af81d46a06f0f39af9b1e754dfdda359
#
#set_soft_assignment [list haps_wrapper i_cpm_top parcpmssmc_xa_1] [list MB1_FB1_F1] ;#cpm_lib_parcpmssmc_xa_a8a4df61f61198de74269e0b3decd4f7
#
#set_soft_assignment [list haps_wrapper i_cpm_top parcpmssmd_xa] [list MB1_FB1_F1] ;#cpm_lib_parcpmssmd_xa
#
#set_soft_assignment [list haps_wrapper i_cpm_top parcpmssmf_0] [list MB1_FB2_F2] ;#cpm_lib_parcpmssmf_05a035305c981e06c16069a05af7d64d
#
#set_soft_assignment [list haps_wrapper i_cpm_top parcpmssmf_1] [list MB1_FB2_F1] ;#cpm_lib_parcpmssmf_7723a4943f20759da5cb148420689432
#
#set_soft_assignment [list haps_wrapper i_cpm_top parcpmssmf_2] [list MB1_FB2_F1] ;#cpm_lib_parcpmssmf_5bc843047566d34236bb1ba1a3f32e9d
#
#set_soft_assignment [list haps_wrapper i_cpm_top parcpmssmf_3] [list MB1_FB2_F1] ;#cpm_lib_parcpmssmf_ead586768ff516a91c6b78d818f564c3
#
#set_soft_assignment [list haps_wrapper i_cpm_top parcpmssmg_xa_0] [list MB1_FB1_F1] ;#cpm_lib_parcpmssmg_xa_85e8db40dd9527bec991a6cccef8d17c
#
#set_soft_assignment [list haps_wrapper i_cpm_top parcpmssmg_xa_1] [list MB1_FB1_F1] ;#cpm_lib_parcpmssmg_xa_75588996805637596a5cdc292c96ab06
#
#set_soft_assignment [list haps_wrapper i_cpm_top parcpmssmh_xa_0] [list MB1_FA2_F2] ;#cpm_lib_parcpmssmh_xa_c37a4b014492d38657af2d4a0c6a350e
#
#set_soft_assignment [list haps_wrapper i_cpm_top parcpmssmh_xa_1] [list MB1_FA2_F2] ;#cpm_lib_parcpmssmh_xa_10c90ffea12e245ddcdd81022e4ba31b
#
#set_soft_assignment [list haps_wrapper i_cpm_top parcpmssmh_xa_2] [list MB1_FA2_F2] ;#cpm_lib_parcpmssmh_xa_3e7f5ea2659fd33ddf53ac0432cd971f
#
#set_soft_assignment [list haps_wrapper i_cpm_top parcpmssmh_xa_3] [list MB1_FA2_F2] ;#cpm_lib_parcpmssmh_xa_6724f4245ff213ecdf71461e8970a808
#
#set_soft_assignment [list haps_wrapper i_emu_force_psid] [list MB1_FB1_F2] ;#cpm_vps_lib_emu_force_psid
#
#set_soft_assignment [list haps_wrapper i_fuse_top] [list MB1_FB1_F2] ;#fuse_sip_lib_fuse_top
#
#set_soft_assignment [list haps_wrapper i_pgcb_doublesync_rst] [list MB1_FB1_F2] ;#rtlc_ctech_lib_doublesync_rst_id_2_redUniq_3618
#
#set_soft_assignment [list haps_wrapper i_platform_doublesync_rst] [list MB1_FB1_F2] ;#rtlc_ctech_lib_doublesync_rst_id_2
#
#set_soft_assignment [list haps_wrapper i_powergood_doublesync_rst] [list MB1_FB1_F2] ;#rtlc_ctech_lib_doublesync_rst_id_2_redUniq_3618
#
#set_soft_assignment [list haps_wrapper i_primary_doublesync_rst] [list MB1_FB1_F2] ;#rtlc_ctech_lib_doublesync_rst_id_2
#
#set_soft_assignment [list haps_wrapper i_ru_top] [list MB1_FB1_F2] ;#reset_controller_bfm_lib_ru_top
#
#set_soft_assignment [list haps_wrapper i_sideband_doublesync_rst] [list MB1_FB1_F2] ;#rtlc_ctech_lib_doublesync_rst_id_2
#
#set_soft_assignment [list haps_wrapper i_sideband_network] [list MB1_FB1_F2] ;#sideband_router_network_lib_sideband_network
#
#set_soft_assignment [list haps_wrapper rtlcgate_n705] [list MB1_FB1_F2] ;#fourteennm_lcell_comb
#
#set_soft_assignment [list haps_wrapper rtlclut_n708] [list MB1_FB1_F2] ;#fourteennm_lcell_comb
#
#set_soft_assignment [list haps_wrapper rtlclut_n709] [list MB1_FB1_F2] ;#fourteennm_lcell_comb
#
#set_soft_assignment [list haps_wrapper rtlclut_n710] [list MB1_FB1_F2] ;#fourteennm_lcell_comb
#
#set_soft_assignment [list haps_wrapper rtlclut_n711] [list MB1_FB1_F2] ;#fourteennm_lcell_comb
#
#set_soft_assignment [list haps_wrapper rtlclut_n712] [list MB1_FB1_F2] ;#fourteennm_lcell_comb
#
#set_soft_assignment [list haps_wrapper rtlclut_n713] [list MB1_FB1_F2] ;#fourteennm_lcell_comb
#
#set_soft_assignment [list haps_wrapper rtlclut_n714] [list MB1_FB1_F2] ;#fourteennm_lcell_comb
#
#set_soft_assignment [list haps_wrapper rtlclut_n715] [list MB1_FB1_F2] ;#fourteennm_lcell_comb
#
#set_soft_assignment [list haps_wrapper rtlclut_n721] [list MB1_FB1_F2] ;#fourteennm_lcell_comb
#
#set_soft_assignment [list haps_wrapper rtlcreg_fuse_ref_clk_clkack] [list MB1_FB1_F2] ;#MED_FDE
#
#set_soft_assignment [list haps_wrapper rtlcreg_fuse_ro_clkack] [list MB1_FB1_F2] ;#MED_FDE
#
#set_soft_assignment [list haps_wrapper rtlcreg_pmc_fuse_pg_ack_b] [list MB1_FB1_F2] ;#MED_FDE
#
#set_soft_assignment [list haps_wrapper rtlcreg_uhfi_side_clkack] [list MB1_FB1_F2] ;#MED_FDE


# Pin assignment pcie_ref_clk_p
# Pin assignment frsw_pcie_perst_n
# Pin assignment pci_exp_rxp[0]
#set_assignment [list haps_wrapper uhfi] [list MB1_FB1_F2] ;#uhfi_rtl_lib_uhfi_rtl_top_RTLC_LONGMOD249
