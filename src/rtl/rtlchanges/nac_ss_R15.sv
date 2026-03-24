/*------------------------------------------------------------------------------
  INTEL CONFIDENTIAL
  Copyright 2022 Intel Corporation All Rights Reserved.
  -----------------------------------------------------------------------------*/
module nac_ss
 #(
parameter integer SB_MAXPLD_WIDTH_1 = 7)
 ( 
input [49:0] nac_ss_spare_in,
output [49:0] nac_ss_spare_out,
input xtalclk,
input rstbus_clk,
input infra_clk,
input croclk,
input time_ref_clk_cmos,
input XX_SYS_REFCLK,
inout CLK_EREF0_P,
inout CLK_EREF0_N,
inout CLKREF_SYNCE_P,
inout CLKREF_SYNCE_N,
input bclk1,
input cmlclkout_p_ana,
input cmlclkout_n_ana,
input cmlbuf_valid_dig,
input dfd_dop_enable,
input [7:0] fdfx_security_policy,
input fdfx_policy_update,
input fdfx_earlyboot_debug_exit,
input [7:0] fdfx_debug_capabilities_enabling,
input fdfx_debug_capabilities_enabling_valid,
output pll_oa_fusa_comb_error,
input nac_vccana_vccs5_iso_ctrl_b,
input BOOT_MODE_STRAP,
input [4:0] BID,
input PLL_REF_SEL0_STRAP,
input PLL_REF_SEL1_STRAP,
input TIME_REF_SEL_STRAP,
input XX_BIST_ENABLE,
input [7:0] axi2sb_strap_sai_secure,
input [7:0] axi2sb_strap_sai_nonsec,
input [63:0] axi2sb_strap_policy1_cp_default,
input [63:0] axi2sb_strap_policy1_rac_default,
input [63:0] axi2sb_strap_policy1_wac_default,
input [63:0] axi2sb_strap_policy2_cp_default,
input [63:0] axi2sb_strap_policy2_rac_default,
input [63:0] axi2sb_strap_policy2_wac_default,
input [63:0] axi2sb_strap_policy3_cp_default,
input [63:0] axi2sb_strap_policy3_rac_default,
input [63:0] axi2sb_strap_policy3_wac_default,
input [63:0] axi2sb_strap_secure_sai_lut_default,
input [63:0] axi2sb_strap_cgid_sai_lut_default,
input [7:0] axi2sb_strap_dfd_cgid_default,
input [7:0] axi2sb_strap_infra_cgid_default,
input [2:0] clockss_boot_pll_iosf_sb_ism_fabric,
output [2:0] clockss_boot_pll_iosf_sb_ism_agent,
output clockss_boot_pll_iosf_sb_side_pok,
output clockss_boot_pll_iosf_sb_mnpput,
output clockss_boot_pll_iosf_sb_mpcput,
input clockss_boot_pll_iosf_sb_mnpcup,
input clockss_boot_pll_iosf_sb_mpccup,
output clockss_boot_pll_iosf_sb_meom,
output [SB_MAXPLD_WIDTH_1:0] clockss_boot_pll_iosf_sb_mpayload,
input clockss_boot_pll_iosf_sb_tnpput,
input clockss_boot_pll_iosf_sb_tpcput,
output clockss_boot_pll_iosf_sb_tnpcup,
output clockss_boot_pll_iosf_sb_tpccup,
input clockss_boot_pll_iosf_sb_teom,
input [SB_MAXPLD_WIDTH_1:0] clockss_boot_pll_iosf_sb_tpayload,
output sfi_clk_1g,
input sfi_clk_1g_in,
output XX_NCSI_CLK_OUT,
output XX_RGMII_CLK_OUT,
output nac_ss_apb_112p5_clk,
output nac_ss_apb_112p5_physs_clk,
input hvm_clk_sel_cnic,
input [5:0] cltap_hvm_ctrl_reg,
input [2:0] clockss_nss_pll_iosf_sb_ism_fabric,
output [2:0] clockss_nss_pll_iosf_sb_ism_agent,
output clockss_nss_pll_iosf_sb_side_pok,
output clockss_nss_pll_iosf_sb_mnpput,
output clockss_nss_pll_iosf_sb_mpcput,
input clockss_nss_pll_iosf_sb_mnpcup,
input clockss_nss_pll_iosf_sb_mpccup,
output clockss_nss_pll_iosf_sb_meom,
output [SB_MAXPLD_WIDTH_1:0] clockss_nss_pll_iosf_sb_mpayload,
input clockss_nss_pll_iosf_sb_tnpput,
input clockss_nss_pll_iosf_sb_tpcput,
output clockss_nss_pll_iosf_sb_tnpcup,
output clockss_nss_pll_iosf_sb_tpccup,
input clockss_nss_pll_iosf_sb_teom,
input [SB_MAXPLD_WIDTH_1:0] clockss_nss_pll_iosf_sb_tpayload,
input [2:0] clockss_ts_pll_iosf_sb_ism_fabric,
output [2:0] clockss_ts_pll_iosf_sb_ism_agent,
output clockss_ts_pll_iosf_sb_side_pok,
output clockss_ts_pll_iosf_sb_mnpput,
output clockss_ts_pll_iosf_sb_mpcput,
input clockss_ts_pll_iosf_sb_mnpcup,
input clockss_ts_pll_iosf_sb_mpccup,
output clockss_ts_pll_iosf_sb_meom,
output [SB_MAXPLD_WIDTH_1:0] clockss_ts_pll_iosf_sb_mpayload,
input clockss_ts_pll_iosf_sb_tnpput,
input clockss_ts_pll_iosf_sb_tpcput,
output clockss_ts_pll_iosf_sb_tnpcup,
output clockss_ts_pll_iosf_sb_tpccup,
input clockss_ts_pll_iosf_sb_teom,
input [SB_MAXPLD_WIDTH_1:0] clockss_ts_pll_iosf_sb_tpayload,
input clkss_cmlbuf_iosf_sb_intf_MNPCUP,
input clkss_cmlbuf_iosf_sb_intf_MPCCUP,
input [2:0] clkss_cmlbuf_iosf_sb_intf_SIDE_ISM_FABRIC,
input clkss_cmlbuf_iosf_sb_intf_TEOM,
input clkss_cmlbuf_iosf_sb_intf_TNPPUT,
input [31:0] clkss_cmlbuf_iosf_sb_intf_TPAYLOAD,
input clkss_cmlbuf_iosf_sb_intf_TPCPUT,
output clkss_cmlbuf_iosf_sb_intf_MEOM,
output clkss_cmlbuf_iosf_sb_intf_MNPPUT,
output [31:0] clkss_cmlbuf_iosf_sb_intf_MPAYLOAD,
output clkss_cmlbuf_iosf_sb_intf_MPCPUT,
output [2:0] clkss_cmlbuf_iosf_sb_intf_SIDE_ISM_AGENT,
output clkss_cmlbuf_iosf_sb_intf_TNPCUP,
output clkss_cmlbuf_iosf_sb_intf_TPCCUP,
output clkss_cmlbuf_sideband_pok,
input nac_ss_dtf_upstream_credit,
input nac_ss_dtf_upstream_active,
input nac_ss_dtf_upstream_sync,
input nac_ss_dtfb_upstream_rst_b,
input nac_ss_debug_safemode_isa_oob,
input [15:0] nac_ss_debug_snib_apb_addr,
input nac_ss_debug_snib_apb_en,
input nac_ss_debug_apb_rst_n,
input nac_ss_debug_snib_apb_sel,
input [31:0] nac_ss_debug_snib_apb_wdata,
input nac_ss_debug_snib_apb_wr,
input [2:0] nac_ss_debug_snib_apb_prot,
input [3:0] nac_ss_debug_snib_apb_strb,
input [15:0] nac_ss_debug_iosf2sfi_apb_addr,
input nac_ss_debug_iosf2sfi_apb_en,
input nac_ss_debug_iosf2sfi_apb_sel,
input [31:0] nac_ss_debug_iosf2sfi_apb_wdata,
input nac_ss_debug_iosf2sfi_apb_wr,
input [2:0] nac_ss_debug_iosf2sfi_apb_prot,
input [3:0] nac_ss_debug_iosf2sfi_apb_strb,
output [24:0] nac_ss_dtf_dnstream_header,
output [63:0] nac_ss_dtf_dnstream_data,
output nac_ss_dtf_dnstream_valid,
output [1:0] nac_ss_debug_dig_view_out,
input [2:0] nac_ss_debug_dts_dig_view_in,
output [2:0] nac_ss_debug_dts_dig_view_out,
inout [1:0] nac_ss_debug_ana_view_inout,
output [7:0] nac_ss_tpiu_data,
output nac_ss_tpiu_clk,
input [31:0] nac_ss_debug_css600_dp_targetid,
input nac_ss_debug_timestamp,
output [31:0] nac_ss_debug_snib_apb_rdata,
output nac_ss_debug_snib_apb_rdy,
output nac_ss_debug_snib_apb_slverr,
output [31:0] nac_ss_debug_iosf2sfi_apb_rdata,
output nac_ss_debug_iosf2sfi_apb_rdy,
output nac_ss_debug_iosf2sfi_apb_slverr,
input [1:0] nac_ss_debug_serializer_hlp_misc_chain_out_to_nac,
input [1:0] nac_ss_debug_serializer_hif_eusb2_chain_out_to_nac,
output [1:0] nac_ss_debug_serializer_hlp_misc_chain_in_from_nac,
output [1:0] nac_ss_debug_serializer_hif_eusb2_chain_in_from_nac,
input [3:0] nac_ss_debug_req_in_next,
output [3:0] nac_ss_debug_req_out_next,
input [3:0] nac_ss_debug_ack_in_next,
output [3:0] nac_ss_debug_ack_out_next,
input [3:0] nac_ss_debug_par_gpio_ne_req_in_next,
output [3:0] nac_ss_debug_par_gpio_ne_req_out_next,
input [3:0] nac_ss_debug_par_gpio_ne_ack_in_next,
output [3:0] nac_ss_debug_par_gpio_ne_ack_out_next,
input nac_ss_debug_css600_swclk_in,
input nac_ss_debug_css600_swdio_in,
input nac_ss_debug_css600_swd_sel_in,
output nac_ss_debug_css600_swdo_out,
output nac_ss_debug_css600_swd0_en_out,
output nac_ss_tpiu_reset,
input [2:0] nac_post_iosf_sb_ism_fabric,
output [2:0] nac_post_iosf_sb_ism_agent,
output nac_post_iosf_sb_mnpput,
output nac_post_iosf_sb_mpcput,
input nac_post_iosf_sb_mnpcup,
input nac_post_iosf_sb_mpccup,
output nac_post_iosf_sb_meom,
output [SB_MAXPLD_WIDTH_1:0] nac_post_iosf_sb_mpayload,
input nac_post_iosf_sb_tnpput,
input nac_post_iosf_sb_tpcput,
output nac_post_iosf_sb_tnpcup,
output nac_post_iosf_sb_tpccup,
input nac_post_iosf_sb_teom,
input [SB_MAXPLD_WIDTH_1:0] nac_post_iosf_sb_tpayload,
output [7:0] nac_post_status_to_cltap,
output YY_WOL,
input XX_TIME_SYNC,
input dts_lvrref_a,
output nac_ra_err,
input nac_thermtrip_in,
output nac_thermtrip_out,
input nac_pllthermtrip_err,
input s5_bgr_lvrrefpwrgood,
output iosf2sfi_isa_clk_req,
input isa_iosf2sfi_isa_clk_ack,
output sn2iosf_isa_clk_req,
input isa_sn2iosf_isa_clk_ack,
output gpio_ne_i_anode,
inout gpio_ne_v_anode,
inout gpio_ne_v_cathode,
output fabric_s5_i_anode,
inout fabric_s5_v_anode,
inout fabric_s5_v_cathode,
inout nac_dts2_i_cathode,
inout NAC_XX_THERMDASOC0,
inout NAC_XX_THERMDCSOC0,
input svidalert_n_rxen_b,
output svidalert_n_rxen_b_rpt_sync,
input svidclk_rxen_b,
output svidclk_rxen_b_rpt_sync,
input svidclk_txen_b,
output svidclk_txen_b_rpt_sync,
input sviddata_rxdata,
output sviddata_rxdata_rpt_sync,
input sviddata_rxen_b,
output sviddata_rxen_b_rpt_sync,
input sviddata_txen_b,
output sviddata_txen_b_rpt_sync,
input gpio_ne_nacss_xxsvidclk_rxdata,
output nacss_punit_feedthrough_xxsvidclk_rxdata,
input gpio_ne_nacss_xxsvidalert_n_rxdata,
output nacss_punit_feedthrough_xxsvidalert_n_rxdata,
input [2:0] rsrc_adapt_dts_nac0_iosf_sb_ism_fabric,
output [2:0] rsrc_adapt_dts_nac0_iosf_sb_ism_agent,
output rsrc_adapt_dts_nac0_iosf_sb_side_pok,
output rsrc_adapt_dts_nac0_iosf_sb_mnpput,
output rsrc_adapt_dts_nac0_iosf_sb_mpcput,
input rsrc_adapt_dts_nac0_iosf_sb_mnpcup,
input rsrc_adapt_dts_nac0_iosf_sb_mpccup,
output rsrc_adapt_dts_nac0_iosf_sb_meom,
output [7:0] rsrc_adapt_dts_nac0_iosf_sb_mpayload,
input rsrc_adapt_dts_nac0_iosf_sb_tnpput,
input rsrc_adapt_dts_nac0_iosf_sb_tpcput,
output rsrc_adapt_dts_nac0_iosf_sb_tnpcup,
output rsrc_adapt_dts_nac0_iosf_sb_tpccup,
input rsrc_adapt_dts_nac0_iosf_sb_teom,
input [7:0] rsrc_adapt_dts_nac0_iosf_sb_tpayload,
input [2:0] rsrc_adapt_dts_nac1_iosf_sb_ism_fabric,
output [2:0] rsrc_adapt_dts_nac1_iosf_sb_ism_agent,
output rsrc_adapt_dts_nac1_iosf_sb_side_pok,
output rsrc_adapt_dts_nac1_iosf_sb_mnpput,
output rsrc_adapt_dts_nac1_iosf_sb_mpcput,
input rsrc_adapt_dts_nac1_iosf_sb_mnpcup,
input rsrc_adapt_dts_nac1_iosf_sb_mpccup,
output rsrc_adapt_dts_nac1_iosf_sb_meom,
output [7:0] rsrc_adapt_dts_nac1_iosf_sb_mpayload,
input rsrc_adapt_dts_nac1_iosf_sb_tnpput,
input rsrc_adapt_dts_nac1_iosf_sb_tpcput,
output rsrc_adapt_dts_nac1_iosf_sb_tnpcup,
output rsrc_adapt_dts_nac1_iosf_sb_tpccup,
input rsrc_adapt_dts_nac1_iosf_sb_teom,
input [7:0] rsrc_adapt_dts_nac1_iosf_sb_tpayload,
input [2:0] rsrc_adapt_dts_nac2_iosf_sb_ism_fabric,
output [2:0] rsrc_adapt_dts_nac2_iosf_sb_ism_agent,
output rsrc_adapt_dts_nac2_iosf_sb_side_pok,
output rsrc_adapt_dts_nac2_iosf_sb_mnpput,
output rsrc_adapt_dts_nac2_iosf_sb_mpcput,
input rsrc_adapt_dts_nac2_iosf_sb_mnpcup,
input rsrc_adapt_dts_nac2_iosf_sb_mpccup,
output rsrc_adapt_dts_nac2_iosf_sb_meom,
output [7:0] rsrc_adapt_dts_nac2_iosf_sb_mpayload,
input rsrc_adapt_dts_nac2_iosf_sb_tnpput,
input rsrc_adapt_dts_nac2_iosf_sb_tpcput,
output rsrc_adapt_dts_nac2_iosf_sb_tnpcup,
output rsrc_adapt_dts_nac2_iosf_sb_tpccup,
input rsrc_adapt_dts_nac2_iosf_sb_teom,
input [7:0] rsrc_adapt_dts_nac2_iosf_sb_tpayload,
input sn2sfi_rst_n,
input hif_pcie0_PERST_n0,
input nac_pwrgood_rst_b,
input inf_rstbus_rst_b,
input early_boot_rst_b,
input inf_iosfsb_rst_b,
input nac_sys_rst_n,
output ecm_boot_err,
input nac_a0_debug_strap,
input [4:0] hwrs_nac_spare_in,
output [4:0] nac_hwrs_spare_out,
input sn2sfi_powergood,
input cnic_fnic_mode_strap,
output nsc_gpio_wake_on_lan, 
output nsc_qchagg_hif_sn2sfi_busy, 
input fdfx_pwrgood_rst_b,
input [31:0] reset_cmd_data,
input reset_cmd_valid,
input reset_cmd_parity,
input imcr_hwrs_qacceptn,
input imcr_hwrs_qdeny,
input imcr_hwrs_qactive,
output imcr_hwrs_qreqn,
input [2:0] clockss_eth_physs_pll_iosf_sb_ism_fabric,
output [2:0] clockss_eth_physs_pll_iosf_sb_ism_agent,
output clockss_eth_physs_pll_iosf_sb_side_pok,
output clockss_eth_physs_pll_iosf_sb_mnpput,
output clockss_eth_physs_pll_iosf_sb_mpcput,
input clockss_eth_physs_pll_iosf_sb_mnpcup,
input clockss_eth_physs_pll_iosf_sb_mpccup,
output clockss_eth_physs_pll_iosf_sb_meom,
output [SB_MAXPLD_WIDTH_1:0] clockss_eth_physs_pll_iosf_sb_mpayload,
input clockss_eth_physs_pll_iosf_sb_tnpput,
input clockss_eth_physs_pll_iosf_sb_tpcput,
output clockss_eth_physs_pll_iosf_sb_tnpcup,
output clockss_eth_physs_pll_iosf_sb_tpccup,
input clockss_eth_physs_pll_iosf_sb_teom,
input [SB_MAXPLD_WIDTH_1:0] clockss_eth_physs_pll_iosf_sb_tpayload,
input infraclk_div4_pdop_par_fabric_s5,
input apb2iosfsb_pipe_rst_n,
input gpio_ne1p8_sb_pipe_rst_n,
input tms,
input tck,
input tdi,
input trst_b,
input shift_ir_dr,
input tms_park_value,
input nw_mode,
input ijtag_reset_b,
input ijtag_shift,
input ijtag_capture,
input ijtag_update,
input ijtag_select,
input ijtag_si,
output tdo,
output tdo_en,
output ijtag_so,
output tap_sel_out,
input tap_sel_in,
output NW_OUT_par_gpio_sw_to_trst,
output NW_OUT_par_gpio_sw_to_tck,
output NW_OUT_par_gpio_sw_to_tms,
output NW_OUT_par_gpio_sw_to_tdi,
input NW_OUT_par_gpio_sw_from_tdo,
input NW_OUT_par_gpio_sw_from_tdo_en,
input NW_OUT_par_gpio_sw_tap_sel_in,
output NW_OUT_par_gpio_sw_ijtag_to_reset,
output NW_OUT_par_gpio_sw_ijtag_to_tck,
output NW_OUT_par_gpio_sw_ijtag_to_ce,
output NW_OUT_par_gpio_sw_ijtag_to_se,
output NW_OUT_par_gpio_sw_ijtag_to_ue,
output NW_OUT_par_gpio_sw_ijtag_to_sel,
output NW_OUT_par_gpio_sw_ijtag_to_si,
input NW_OUT_par_gpio_sw_ijtag_from_so,
output NW_OUT_par_gpio_ne_to_trst,
output NW_OUT_par_gpio_ne_to_tck,
output NW_OUT_par_gpio_ne_to_tms,
output NW_OUT_par_gpio_ne_to_tdi,
input NW_OUT_par_gpio_ne_from_tdo,
input NW_OUT_par_gpio_ne_from_tdo_en,
input NW_OUT_par_gpio_ne_tap_sel_in,
output NW_OUT_par_gpio_ne_ijtag_to_reset,
output NW_OUT_par_gpio_ne_ijtag_to_tck,
output NW_OUT_par_gpio_ne_ijtag_to_ce,
output NW_OUT_par_gpio_ne_ijtag_to_se,
output NW_OUT_par_gpio_ne_ijtag_to_ue,
output NW_OUT_par_gpio_ne_ijtag_to_sel,
output NW_OUT_par_gpio_ne_ijtag_to_si,
input NW_OUT_par_gpio_ne_ijtag_from_so,
input [31:0] ssn_bus_data_in,
input ssn_bus_clock_in,
output [31:0] ssn_bus_data_out,
input [31:0] par_nac_fabric3_par_gpio_sw_mux_start_bus_data_in,
output [31:0] par_nac_fabric3_par_gpio_sw_mux_end_bus_data_out,
input [31:0] par_nac_fabric0_mux_par_gpio_ne_in_start_bus_data_in,
output [31:0] par_nac_fabric0_par_gpio_ne_out_end_bus_data_out,
inout PCIE_PHY0_APROBE,
inout PCIE_PHY0_APROBE2,
input PCIE_RX0_N,
input PCIE_RX0_P,
output PCIE_TX0_N,
output PCIE_TX0_P,
input PCIE_RX1_N,
input PCIE_RX1_P,
output PCIE_TX1_N,
output PCIE_TX1_P,
input PCIE_RX2_N,
input PCIE_RX2_P,
output PCIE_TX2_N,
output PCIE_TX2_P,
input PCIE_RX3_N,
input PCIE_RX3_P,
output PCIE_TX3_N,
output PCIE_TX3_P,
inout wire PCIE_REF_PAD_CLK0_N,
inout wire PCIE_REF_PAD_CLK0_P,
input PCIE_PHY0_GRCOMP,
input PCIE_PHY0_GRCOMPV,
inout PCIE_PHY1_APROBE,
inout PCIE_PHY1_APROBE2,
input PCIE_RX4_N,
input PCIE_RX4_P,
output PCIE_TX4_N,
output PCIE_TX4_P,
input PCIE_RX5_N,
input PCIE_RX5_P,
output PCIE_TX5_N,
output PCIE_TX5_P,
input PCIE_RX6_N,
input PCIE_RX6_P,
output PCIE_TX6_N,
output PCIE_TX6_P,
input PCIE_RX7_N,
input PCIE_RX7_P,
output PCIE_TX7_N,
output PCIE_TX7_P,
inout wire PCIE_REF_PAD_CLK1_N,
inout wire PCIE_REF_PAD_CLK1_P,
input PCIE_PHY1_GRCOMP,
input PCIE_PHY1_GRCOMPV,
inout PCIE_PHY2_APROBE,
inout PCIE_PHY2_APROBE2,
input PCIE_RX8_N,
input PCIE_RX8_P,
output PCIE_TX8_N,
output PCIE_TX8_P,
input PCIE_RX9_N,
input PCIE_RX9_P,
output PCIE_TX9_N,
output PCIE_TX9_P,
input PCIE_RX10_N,
input PCIE_RX10_P,
output PCIE_TX10_N,
output PCIE_TX10_P,
input PCIE_RX11_N,
input PCIE_RX11_P,
output PCIE_TX11_N,
output PCIE_TX11_P,
inout wire PCIE_REF_PAD_CLK2_N,
inout wire PCIE_REF_PAD_CLK2_P,
input PCIE_PHY2_GRCOMP,
input PCIE_PHY2_GRCOMPV,
inout PCIE_PHY3_APROBE,
inout PCIE_PHY3_APROBE2,
input PCIE_RX12_N,
input PCIE_RX12_P,
output PCIE_TX12_N,
output PCIE_TX12_P,
input PCIE_RX13_N,
input PCIE_RX13_P,
output PCIE_TX13_N,
output PCIE_TX13_P,
input PCIE_RX14_N,
input PCIE_RX14_P,
output PCIE_TX14_N,
output PCIE_TX14_P,
input PCIE_RX15_N,
input PCIE_RX15_P,
output PCIE_TX15_N,
output PCIE_TX15_P,
inout wire PCIE_REF_PAD_CLK3_N,
inout wire PCIE_REF_PAD_CLK3_P,
input PCIE_PHY3_GRCOMP,
input PCIE_PHY3_GRCOMPV,
output [31:0] cfio_paddr,
output cfio_penable,
output cfio_pwrite,
output [31:0] cfio_pwdata,
output [2:0] cfio_pprot,
output [3:0] cfio_pstrb,
output cfio_psel,
input [31:0] cfio_prdata,
input cfio_pready,
input cfio_pslverr,
output [31:0] i_nmf_t_cnic_physs_gpio_paddr,
output i_nmf_t_cnic_physs_gpio_penable,
output i_nmf_t_cnic_physs_gpio_pwrite,
output [31:0] i_nmf_t_cnic_physs_gpio_pwdata,
output [2:0] i_nmf_t_cnic_physs_gpio_pprot,
output [3:0] i_nmf_t_cnic_physs_gpio_pstrb,
output i_nmf_t_cnic_physs_gpio_psel_0,
input [31:0] i_nmf_t_cnic_physs_gpio_prdata_0,
input i_nmf_t_cnic_physs_gpio_pready_0,
input i_nmf_t_cnic_physs_gpio_pslverr_0,
output XX_SPI_CLK,
output [3:0] XX_SPI_OE_N,
output [3:0] XX_SPI_TXD,
input [3:0] XX_SPI_RXD,
output XX_SPI_CS0_N,
output XX_SPI_CS1_N,
input XX_I2C_SCL0,
input XX_I2C_SCL1,
input XX_I2C_SCL2,
input XX_I2C_SCL4,
input XX_I2C_SCL5,
input XX_I2C_SCL6,
input XX_I2C_SCL7,
output [7:0] nss_i2c_clk_oe_n,
input XX_I2C_SDA0,
input XX_I2C_SDA1,
input XX_I2C_SDA2,
input XX_I2C_SDA4,
input XX_I2C_SDA5,
input XX_I2C_SDA6,
input XX_I2C_SDA7,
output [7:0] nss_i2c_data_oe_n,
output svidalert,
input FNIC_SVID_CLK,
input FNIC_SVID_DATA,
output nsc_ready_for_enum,
inout wire EUSB2_EDM,
inout wire EUSB2_EDP,
inout wire EUSB2_RESREF,
inout wire EUSB2_ANALOGTEST,
input wire EUSB2_VBUS_VALID_EXT,
output ETH_TXP0,
output ETH_TXN0,
output ETH_TXP1,
output ETH_TXN1,
output ETH_TXP2,
output ETH_TXN2,
output ETH_TXP3,
output ETH_TXN3,
output ETH_TXP4,
output ETH_TXN4,
output ETH_TXP5,
output ETH_TXN5,
output ETH_TXP6,
output ETH_TXN6,
output ETH_TXP7,
output ETH_TXN7,
input ETH_RXP0,
input ETH_RXN0,
input ETH_RXP1,
input ETH_RXN1,
input ETH_RXP2,
input ETH_RXN2,
input ETH_RXP3,
input ETH_RXN3,
input ETH_RXP4,
input ETH_RXN4,
input ETH_RXP5,
input ETH_RXN5,
input ETH_RXP6,
input ETH_RXN6,
input ETH_RXP7,
input ETH_RXN7,
output ETH_TXP8,
output ETH_TXN8,
output ETH_TXP9,
output ETH_TXN9,
output ETH_TXP10,
output ETH_TXN10,
output ETH_TXP11,
output ETH_TXN11,
output ETH_TXP12,
output ETH_TXN12,
output ETH_TXP13,
output ETH_TXN13,
output ETH_TXP14,
output ETH_TXN14,
output ETH_TXP15,
output ETH_TXN15,
input ETH_RXP8,
input ETH_RXN8,
input ETH_RXP9,
input ETH_RXN9,
input ETH_RXP10,
input ETH_RXN10,
input ETH_RXP11,
input ETH_RXN11,
input ETH_RXP12,
input ETH_RXN12,
input ETH_RXP13,
input ETH_RXN13,
input ETH_RXP14,
input ETH_RXN14,
input ETH_RXP15,
input ETH_RXN15,
inout [15:0] xioa_ck_pma_ref0_n,
inout [15:0] xioa_ck_pma_ref0_p,
inout [13:0] xioa_ck_pma_ref1_n,
inout [13:0] xioa_ck_pma_ref1_p,
output [15:0] xoa_pma_dcmon1,
output [15:0] xoa_pma_dcmon2,
input nac_a0_debug_strap_0,
input SPARE_B1,
input SPARE_B2,
input SPARE_B3,
input [2:0] axi2sb_gpsb_side_ism_fabric,
output [2:0] axi2sb_gpsb_side_ism_agent,
output axi2sb_gpsb_side_pok,
output axi2sb_gpsb_mnpput,
output axi2sb_gpsb_mpcput,
input axi2sb_gpsb_mnpcup,
input axi2sb_gpsb_mpccup,
output axi2sb_gpsb_meom,
output [31:0] axi2sb_gpsb_mpayload,
output axi2sb_gpsb_mparity,
input axi2sb_gpsb_tnpput,
input axi2sb_gpsb_tpcput,
output axi2sb_gpsb_tnpcup,
output axi2sb_gpsb_tpccup,
input axi2sb_gpsb_teom,
input [31:0] axi2sb_gpsb_tpayload,
input axi2sb_gpsb_tparity,
input [15:0] axi2sb_gpsb_strap_sourceid,
input axi2sb_gpsb_strap_bridge_disable,
input [2:0] axi2sb_pmsb_side_ism_fabric,
output [2:0] axi2sb_pmsb_side_ism_agent,
output axi2sb_pmsb_side_pok,
output axi2sb_pmsb_mnpput,
output axi2sb_pmsb_mpcput,
input axi2sb_pmsb_mnpcup,
input axi2sb_pmsb_mpccup,
output axi2sb_pmsb_meom,
output [31:0] axi2sb_pmsb_mpayload,
output axi2sb_pmsb_mparity,
input axi2sb_pmsb_tnpput,
input axi2sb_pmsb_tpcput,
output axi2sb_pmsb_tnpcup,
output axi2sb_pmsb_tpccup,
input axi2sb_pmsb_teom,
input [31:0] axi2sb_pmsb_tpayload,
input axi2sb_pmsb_tparity,
input [15:0] axi2sb_pmsb_strap_sourceid,
input [7:0] axi2sb_pmsb_strap_sai_pmsb_default,
input axi2sb_pmsb_strap_bridge_disable,
output XX_SYNCE_CLKOUT0,
output XX_SYNCE_CLKOUT1,
output boot_pll_adapt_rstw_resource_ready,
output nac_ss_debug_ecm_monout_cp_ana [1:0],
inout XX_OPAD_SENSE_0p9,
input [63:0] s3m_time,
output XX_UART_HMP_TXD,
input XX_UART_HMP_RXD,
output XX_UART_HIF_TXD,
input XX_UART_HIF_RXD,
output XX_UART_USB_TXD,
input XX_UART_USB_RXD,
output XX_DEBUG_ACT_N,
output ecm_boot_done,
input [31:0] nss_gpio_in,
output nss_gpio_nichot_b,
output [31:0] nss_gpio_oe_n,
output [31:0] nss_gpio_out,
input XX_PCIE0_PERST_N0,
input XX_PCIE0_PERST_N1,
input XX_PCIE0_PERST_N2,
input XX_PCIE0_PERST_N3,
output XX_MDIO_CLK,
input XX_MDIO_IN,
output XX_MDIO_OEN,
output XX_MDIO_OUT,
output [0:0] XX_ONE_PPS_OUT,
input XX_UART_PHYSS_RXD,
output XX_UART_PHYSS_TXD,
input XX_NCSI_CLK,
output XX_NCSI_CRS_DV,
input XX_NCSI_RX_EN_B,
input XX_NCSI_TX_EN,
input XX_NCSI_RXD0,
input XX_NCSI_RXD1,
output XX_NCSI_TXD0,
output XX_NCSI_TXD1,
input XX_NCSI_ARB_IN,
output XX_NCSI_ARB_OUT,
input sn2sfi_rst_pre_ind_n,
output reset_cmd_ack,
output reset_error,
output warm_rst_qactive,
output warm_rst_qdeny,
output warm_rst_qacceptn,
input warm_rst_qreqn,
output rsrc_adapt_nac_dts0_fsa_rst_b,
output rsrc_adapt_nac_dts1_fsa_rst_b,
output rsrc_adapt_nac_dts2_fsa_rst_b,
output rsrc_adapt_bootpll_fsa_rst_b,
output rsrc_adapt_tspll_fsa_rst_b,
output rsrc_adapt_nsspll_fsa_rst_b,
output rsrc_adapt_ethphysspll_fsa_rst_b,
output cmulbuf_buttr_fsa_rst_b,
input apb2iosfsb_in_mnpput,
input apb2iosfsb_in_mpcput,
input apb2iosfsb_in_meom,
input [7:0] apb2iosfsb_in_mpayload,
input apb2iosfsb_in_mparity,
input apb2iosfsb_in_tnpcup,
input apb2iosfsb_in_tpccup,
input [2:0] apb2iosfsb_in_side_ism_agent,
input apb2iosfsb_in_pok,
output apb2iosfsb_in_mnpcup,
output apb2iosfsb_in_mpccup,
output apb2iosfsb_in_tnpput,
output apb2iosfsb_in_tpcput,
output apb2iosfsb_in_teom,
output [7:0] apb2iosfsb_in_tpayload,
output apb2iosfsb_in_tparity,
output [2:0] apb2iosfsb_in_side_ism_fabric,
input apb2iosfsb_out_mnpcup,
input apb2iosfsb_out_mpccup,
input apb2iosfsb_out_tnpput,
input apb2iosfsb_out_tpcput,
input apb2iosfsb_out_teom,
input [7:0] apb2iosfsb_out_tpayload,
input apb2iosfsb_out_tparity,
input [2:0] apb2iosfsb_out_side_ism_fabric,
output apb2iosfsb_out_mnpput,
output apb2iosfsb_out_mpcput,
output apb2iosfsb_out_meom,
output [7:0] apb2iosfsb_out_mpayload,
output apb2iosfsb_out_mparity,
output apb2iosfsb_out_tnpcup,
output apb2iosfsb_out_tpccup,
output [2:0] apb2iosfsb_out_side_ism_agent,
output apb2iosfsb_out_pok,
input gpio_ne_1p8_in_mnpput,
input gpio_ne_1p8_in_mpcput,
input gpio_ne_1p8_in_meom,
input [7:0] gpio_ne_1p8_in_mpayload,
input gpio_ne_1p8_in_mparity,
input gpio_ne_1p8_in_tnpcup,
input gpio_ne_1p8_in_tpccup,
input [2:0] gpio_ne_1p8_in_side_ism_agent,
input gpio_ne_1p8_in_pok,
output gpio_ne_1p8_in_mnpcup,
output gpio_ne_1p8_in_mpccup,
output gpio_ne_1p8_in_tnpput,
output gpio_ne_1p8_in_tpcput,
output gpio_ne_1p8_in_teom,
output [7:0] gpio_ne_1p8_in_tpayload,
output gpio_ne_1p8_in_tparity,
output [2:0] gpio_ne_1p8_in_side_ism_fabric,
input gpio_ne_1p8_out_mnpcup,
input gpio_ne_1p8_out_mpccup,
input gpio_ne_1p8_out_tnpput,
input gpio_ne_1p8_out_tpcput,
input gpio_ne_1p8_out_teom,
input [7:0] gpio_ne_1p8_out_tpayload,
input gpio_ne_1p8_out_tparity,
input [2:0] gpio_ne_1p8_out_side_ism_fabric,
output gpio_ne_1p8_out_mnpput,
output gpio_ne_1p8_out_mpcput,
output gpio_ne_1p8_out_meom,
output [7:0] gpio_ne_1p8_out_mpayload,
output gpio_ne_1p8_out_mparity,
output gpio_ne_1p8_out_tnpcup,
output gpio_ne_1p8_out_tpccup,
output [2:0] gpio_ne_1p8_out_side_ism_agent,
output gpio_ne_1p8_out_pok,
output sfi_tx_link_txcon_req,
input sfi_tx_link_rxcon_ack,
input sfi_tx_link_rxdiscon_nack,
input sfi_tx_link_rx_empty,
input sfi_rx_link_txcon_req,
output sfi_rx_link_rxcon_ack,
output sfi_rx_link_rxdiscon_nack,
output sfi_rx_link_rx_empty,
output [0:0] sfi_tx_hdr_valid,
output sfi_tx_hdr_early_valid,
input sfi_tx_hdr_block,
output [255:0] sfi_tx_hdr_header,
output [15:0] sfi_tx_hdr_info_bytes,
input sfi_tx_hdr_crd_rtn_valid,
input sfi_tx_hdr_crd_rtn_ded,
input [1:0] sfi_tx_hdr_crd_rtn_fc_id,
input [4:0] sfi_tx_hdr_crd_rtn_vc_id,
input [3:0] sfi_tx_hdr_crd_rtn_value,
output sfi_tx_hdr_crd_rtn_block,
input [0:0] sfi_rx_hdr_valid,
input sfi_rx_hdr_early_valid,
output sfi_rx_hdr_block,
input [255:0] sfi_rx_header,
input [15:0] sfi_rx_hdr_info_bytes,
output sfi_rx_hdr_crd_rtn_valid,
output sfi_rx_hdr_crd_rtn_ded,
output [1:0] sfi_rx_hdr_crd_rtn_fc_id,
output [4:0] sfi_rx_hdr_crd_rtn_vc_id,
output [3:0] sfi_rx_hdr_crd_rtn_value,
input sfi_rx_hdr_crd_rtn_block,
output sfi_tx_data_valid,
output sfi_tx_data_early_valid,
input sfi_tx_data_block,
output [1023:0] sfi_tx_data,
output [15:0] sfi_tx_data_parity,
output [0:0] sfi_tx_data_start,
output [7:0] sfi_tx_data_info_byte,
output [31:0] sfi_tx_data_end,
output [31:0] sfi_tx_data_poison,
output [31:0] sfi_tx_data_edb,
output sfi_tx_data_aux_parity,
input sfi_tx_data_crd_rtn_valid,
input sfi_tx_data_crd_rtn_ded,
input [1:0] sfi_tx_data_crd_rtn_fc_id,
input [4:0] sfi_tx_data_crd_rtn_vc_id,
input [3:0] sfi_tx_data_crd_rtn_value,
output sfi_tx_data_crd_rtn_block,
input sfi_rx_data_valid,
input sfi_rx_data_early_valid,
output sfi_rx_data_block,
input [1023:0] sfi_rx_data,
input [15:0] sfi_rx_data_parity,
input [0:0] sfi_rx_data_start,
input [7:0] sfi_rx_data_info_byte,
input [31:0] sfi_rx_data_end,
input [31:0] sfi_rx_data_poison,
input [31:0] sfi_rx_data_edb,
input sfi_rx_data_aux_parity,
output sfi_rx_data_crd_rtn_valid,
output sfi_rx_data_crd_rtn_ded,
output [1:0] sfi_rx_data_crd_rtn_fc_id,
output [4:0] sfi_rx_data_crd_rtn_vc_id,
output [3:0] sfi_rx_data_crd_rtn_value,
input sfi_rx_data_crd_rtn_block,
output iosf2sfi_iosf_side_pok,
input [2:0] iosf2sfi_sb_side_ism_fabric,
output [2:0] iosf2sfi_sb_side_ism_agent,
output iosf2sfi_sb_mnpput,
output iosf2sfi_sb_mpcput,
input iosf2sfi_sb_mnpcup,
input iosf2sfi_sb_mpccup,
output iosf2sfi_sb_meom,
output [7:0] iosf2sfi_sb_mpayload,
input iosf2sfi_sb_tnpput,
input iosf2sfi_sb_tpcput,
output iosf2sfi_sb_tnpcup,
output iosf2sfi_sb_tpccup,
input iosf2sfi_sb_teom,
input [7:0] iosf2sfi_sb_tpayload,
output sn2iosf_side_pok,
input [2:0] sn2iosf_sb_side_ism_fabric,
output [2:0] sn2iosf_sb_side_ism_agent,
input sn2iosf_sb_mpccup,
input sn2iosf_sb_mnpcup,
output sn2iosf_sb_mpcput,
output sn2iosf_sb_mnpput,
output sn2iosf_sb_meom,
output [7:0] sn2iosf_sb_mpayload,
output sn2iosf_sb_tpccup,
output sn2iosf_sb_tnpcup,
input sn2iosf_sb_tpcput,
input sn2iosf_sb_tnpput,
input sn2iosf_sb_teom,
input [7:0] sn2iosf_sb_tpayload );
logic dtf_rep_fab1_misc_arb0_rep1_arbiter2dst_arbiter_0_DTFA_ACTIVE ; 
logic dtf_rep_fab1_misc_arb0_rep1_arbiter2dst_arbiter_0_DTFA_CREDIT ; 
logic dtf_rep_fab1_misc_arb0_rep1_arbiter2dst_arbiter_0_DTFA_SYNC ; 
logic [63:0] dtf_rep_fab1_misc_arb0_rep1_arbiter2dst_arbiter_0_DTFA_DATA ; 
logic [24:0] dtf_rep_fab1_misc_arb0_rep1_arbiter2dst_arbiter_0_DTFA_HEADER ; 
logic dtf_rep_fab1_misc_arb0_rep1_arbiter2dst_arbiter_0_DTFA_VALID ; 
logic dtf_rep_hlp_arb_fab3_fab2_rep0_arbiter2dst_arbiter_0_DTFA_ACTIVE ; 
logic dtf_rep_hlp_arb_fab3_fab2_rep0_arbiter2dst_arbiter_0_DTFA_CREDIT ; 
logic dtf_rep_hlp_arb_fab3_fab2_rep0_arbiter2dst_arbiter_0_DTFA_SYNC ; 
logic [63:0] dtf_rep_hlp_arb_fab3_fab2_rep0_arbiter2dst_arbiter_0_DTFA_DATA ; 
logic [24:0] dtf_rep_hlp_arb_fab3_fab2_rep0_arbiter2dst_arbiter_0_DTFA_HEADER ; 
logic dtf_rep_hlp_arb_fab3_fab2_rep0_arbiter2dst_arbiter_0_DTFA_VALID ; 
logic dtf_rep_fab2_misc_arb0_rep7_arbiter2dst_arbiter_0_DTFA_ACTIVE ; 
logic dtf_rep_fab2_misc_arb0_rep7_arbiter2dst_arbiter_0_DTFA_CREDIT ; 
logic dtf_rep_fab2_misc_arb0_rep7_arbiter2dst_arbiter_0_DTFA_SYNC ; 
logic [63:0] dtf_rep_fab2_misc_arb0_rep7_arbiter2dst_arbiter_0_DTFA_DATA ; 
logic [24:0] dtf_rep_fab2_misc_arb0_rep7_arbiter2dst_arbiter_0_DTFA_HEADER ; 
logic dtf_rep_fab2_misc_arb0_rep7_arbiter2dst_arbiter_0_DTFA_VALID ; 
logic dtf_rep_fab0_fab1_arb0_rep2_arbiter2dst_arbiter_0_DTFA_ACTIVE ; 
logic dtf_rep_fab0_fab1_arb0_rep2_arbiter2dst_arbiter_0_DTFA_CREDIT ; 
logic dtf_rep_fab0_fab1_arb0_rep2_arbiter2dst_arbiter_0_DTFA_SYNC ; 
logic [63:0] dtf_rep_fab0_fab1_arb0_rep2_arbiter2dst_arbiter_0_DTFA_DATA ; 
logic [24:0] dtf_rep_fab0_fab1_arb0_rep2_arbiter2dst_arbiter_0_DTFA_HEADER ; 
logic dtf_rep_fab0_fab1_arb0_rep2_arbiter2dst_arbiter_0_DTFA_VALID ; 
logic nss_scon_hifcar_rst_n ; 
logic par_nac_fabric0_bclk1_out_pcie ; 
logic [31:0] hif_pcie_gen6_phy_18a_pcie_phy_hif_spare ; 
logic [31:0] nss_hif_pcie_phy0_spare_out ; 
logic hif_pcie_gen6_phy_18a_pciephyss_hif_intr_fatal_out ; 
logic hif_pcie_gen6_phy_18a_hif_t_pcie_phycrif_pslverr ; 
logic [31:0] hif_pcie_gen6_phy_18a_hif_t_pcie_phycrif_prdata ; 
logic hif_pcie_gen6_phy_18a_hif_t_pcie_phycrif_pready ; 
logic [31:0] nss_hif_t_pcie_phycrif0_paddr ; 
logic nss_hif_t_pcie_phycrif0_penable ; 
logic [2:0] nss_hif_t_pcie_phycrif0_pprot ; 
logic nss_hif_t_pcie_phycrif0_psel ; 
logic [3:0] nss_hif_t_pcie_phycrif0_pstrb ; 
logic [31:0] nss_hif_t_pcie_phycrif0_pwdata ; 
logic nss_hif_t_pcie_phycrif0_pwrite ; 
logic hif_pcie_gen6_phy_18a_hif_t_pcie_phyctrl_pslverr ; 
logic [31:0] hif_pcie_gen6_phy_18a_hif_t_pcie_phyctrl_prdata ; 
logic hif_pcie_gen6_phy_18a_hif_t_pcie_phyctrl_pready ; 
logic [31:0] nss_hif_t_pcie_phyctrl0_paddr ; 
logic nss_hif_t_pcie_phyctrl0_penable ; 
logic [2:0] nss_hif_t_pcie_phyctrl0_pprot ; 
logic nss_hif_t_pcie_phyctrl0_psel ; 
logic [3:0] nss_hif_t_pcie_phyctrl0_pstrb ; 
logic [31:0] nss_hif_t_pcie_phyctrl0_pwdata ; 
logic nss_hif_t_pcie_phyctrl0_pwrite ; 
logic [15:0] nss_phy_pcie0_pipe_clk ; 
logic [1279:0] nss_hif_pcie0_mac_phy_txdata ; 
logic [15:0] nss_hif_pcie0_mac_phy_txdatavalid ; 
logic [1:0] nss_hif_pcie0_mac_phy_rxwidth ; 
logic [15:0] nss_hif_pcie0_mac_phy_txdetectrx_loopback ; 
logic [63:0] nss_hif_pcie0_mac_phy_txelecidle ; 
logic [3:0] nss_hif_pcie0_mac_phy_powerdown ; 
logic nss_hif_pcie0_mac_phy_rxelecidle_disable ; 
logic nss_hif_pcie0_mac_phy_txcommonmode_disable ; 
logic [2:0] nss_hif_pcie0_mac_phy_rate ; 
logic [1:0] nss_hif_pcie0_mac_phy_width ; 
logic [2:0] nss_hif_pcie0_mac_phy_pclk_rate ; 
logic [15:0] nss_hif_pcie0_mac_phy_rxstandby ; 
logic [127:0] nss_hif_pcie0_mac_phy_messagebus ; 
logic nss_hif_pcie0_mac_phy_serdes_arch ; 
logic [15:0] nss_hif_pcie0_serdes_pipe_rxready ; 
logic nss_hif_pcie0_mac_phy_commonclock_enable ; 
logic nss_hif_pcie0_mac_phy_asyncpowerchangeack ; 
logic nss_hif_pcie0_mac_phy_sris_enable ; 
logic [15:0] nss_hif_pcie0_mac_phy_pclkchangeack ; 
logic [15:0] hif_pcie_gen6_phy_18a_hif_pcie0_phy_mac_pclkchangeok ; 
logic hif_pcie_gen6_phy_18a_phy_pcie0_max_pclk ; 
logic [1279:0] hif_pcie_gen6_phy_18a_hif_pcie0_phy_mac_rxdata ; 
logic [15:0] hif_pcie_gen6_phy_18a_phy_pcie0_pipe_rx_clk ; 
logic [15:0] hif_pcie_gen6_phy_18a_hif_pcie0_phy_mac_rxstandbystatus ; 
logic [15:0] hif_pcie_gen6_phy_18a_hif_pcie0_phy_mac_rxvalid ; 
logic [15:0] hif_pcie_gen6_phy_18a_hif_pcie0_phy_mac_phystatus ; 
logic [15:0] hif_pcie_gen6_phy_18a_hif_pcie0_phy_mac_rxelecidle ; 
logic [47:0] hif_pcie_gen6_phy_18a_hif_pcie0_phy_mac_rxstatus ; 
logic [127:0] hif_pcie_gen6_phy_18a_hif_pcie0_phy_mac_messagebus ; 
logic [3:0] nss_phy_pcie2_pipe_clk ; 
logic [319:0] nss_hif_pcie2_mac_phy_txdata ; 
logic [3:0] nss_hif_pcie2_mac_phy_txdatavalid ; 
logic [1:0] nss_hif_pcie2_mac_phy_rxwidth ; 
logic [3:0] nss_hif_pcie2_mac_phy_txdetectrx_loopback ; 
logic [15:0] nss_hif_pcie2_mac_phy_txelecidle ; 
logic [3:0] nss_hif_pcie2_mac_phy_powerdown ; 
logic nss_hif_pcie2_mac_phy_rxelecidle_disable ; 
logic nss_hif_pcie2_mac_phy_txcommonmode_disable ; 
logic [2:0] nss_hif_pcie2_mac_phy_rate ; 
logic [1:0] nss_hif_pcie2_mac_phy_width ; 
logic [2:0] nss_hif_pcie2_mac_phy_pclk_rate ; 
logic [3:0] nss_hif_pcie2_mac_phy_rxstandby ; 
logic [31:0] nss_hif_pcie2_mac_phy_messagebus ; 
logic nss_hif_pcie2_mac_phy_serdes_arch ; 
logic [3:0] nss_hif_pcie2_serdes_pipe_rxready ; 
logic nss_hif_pcie2_mac_phy_commonclock_enable ; 
logic nss_hif_pcie2_mac_phy_asyncpowerchangeack ; 
logic nss_hif_pcie2_mac_phy_sris_enable ; 
logic [3:0] nss_hif_pcie2_mac_phy_pclkchangeack ; 
logic [3:0] hif_pcie_gen6_phy_18a_hif_pcie2_phy_mac_pclkchangeok ; 
logic hif_pcie_gen6_phy_18a_phy_pcie2_max_pclk ; 
logic [319:0] hif_pcie_gen6_phy_18a_hif_pcie2_phy_mac_rxdata ; 
logic [3:0] hif_pcie_gen6_phy_18a_phy_pcie2_pipe_rx_clk ; 
logic [3:0] hif_pcie_gen6_phy_18a_hif_pcie2_phy_mac_rxstandbystatus ; 
logic [3:0] hif_pcie_gen6_phy_18a_hif_pcie2_phy_mac_rxvalid ; 
logic [3:0] hif_pcie_gen6_phy_18a_hif_pcie2_phy_mac_phystatus ; 
logic [3:0] hif_pcie_gen6_phy_18a_hif_pcie2_phy_mac_rxelecidle ; 
logic [11:0] hif_pcie_gen6_phy_18a_hif_pcie2_phy_mac_rxstatus ; 
logic [31:0] hif_pcie_gen6_phy_18a_hif_pcie2_phy_mac_messagebus ; 
logic [7:0] nss_phy_pcie4_pipe_clk ; 
logic [639:0] nss_hif_pcie4_mac_phy_txdata ; 
logic [7:0] nss_hif_pcie4_mac_phy_txdatavalid ; 
logic [1:0] nss_hif_pcie4_mac_phy_rxwidth ; 
logic [7:0] nss_hif_pcie4_mac_phy_txdetectrx_loopback ; 
logic [31:0] nss_hif_pcie4_mac_phy_txelecidle ; 
logic [3:0] nss_hif_pcie4_mac_phy_powerdown ; 
logic nss_hif_pcie4_mac_phy_rxelecidle_disable ; 
logic nss_hif_pcie4_mac_phy_txcommonmode_disable ; 
logic [2:0] nss_hif_pcie4_mac_phy_rate ; 
logic [1:0] nss_hif_pcie4_mac_phy_width ; 
logic [2:0] nss_hif_pcie4_mac_phy_pclk_rate ; 
logic [7:0] nss_hif_pcie4_mac_phy_rxstandby ; 
logic [63:0] nss_hif_pcie4_mac_phy_messagebus ; 
logic nss_hif_pcie4_mac_phy_serdes_arch ; 
logic [7:0] nss_hif_pcie4_serdes_pipe_rxready ; 
logic nss_hif_pcie4_mac_phy_commonclock_enable ; 
logic nss_hif_pcie4_mac_phy_asyncpowerchangeack ; 
logic nss_hif_pcie4_mac_phy_sris_enable ; 
logic [7:0] nss_hif_pcie4_mac_phy_pclkchangeack ; 
logic [7:0] hif_pcie_gen6_phy_18a_hif_pcie4_phy_mac_pclkchangeok ; 
logic hif_pcie_gen6_phy_18a_phy_pcie4_max_pclk ; 
logic [639:0] hif_pcie_gen6_phy_18a_hif_pcie4_phy_mac_rxdata ; 
logic [7:0] hif_pcie_gen6_phy_18a_phy_pcie4_pipe_rx_clk ; 
logic [7:0] hif_pcie_gen6_phy_18a_hif_pcie4_phy_mac_rxstandbystatus ; 
logic [7:0] hif_pcie_gen6_phy_18a_hif_pcie4_phy_mac_rxvalid ; 
logic [7:0] hif_pcie_gen6_phy_18a_hif_pcie4_phy_mac_phystatus ; 
logic [7:0] hif_pcie_gen6_phy_18a_hif_pcie4_phy_mac_rxelecidle ; 
logic [23:0] hif_pcie_gen6_phy_18a_hif_pcie4_phy_mac_rxstatus ; 
logic [63:0] hif_pcie_gen6_phy_18a_hif_pcie4_phy_mac_messagebus ; 
logic [3:0] nss_phy_pcie6_pipe_clk ; 
logic [319:0] nss_hif_pcie6_mac_phy_txdata ; 
logic [3:0] nss_hif_pcie6_mac_phy_txdatavalid ; 
logic [1:0] nss_hif_pcie6_mac_phy_rxwidth ; 
logic [3:0] nss_hif_pcie6_mac_phy_txdetectrx_loopback ; 
logic [15:0] nss_hif_pcie6_mac_phy_txelecidle ; 
logic [3:0] nss_hif_pcie6_mac_phy_powerdown ; 
logic nss_hif_pcie6_mac_phy_rxelecidle_disable ; 
logic nss_hif_pcie6_mac_phy_txcommonmode_disable ; 
logic [2:0] nss_hif_pcie6_mac_phy_rate ; 
logic [1:0] nss_hif_pcie6_mac_phy_width ; 
logic [2:0] nss_hif_pcie6_mac_phy_pclk_rate ; 
logic [3:0] nss_hif_pcie6_mac_phy_rxstandby ; 
logic [31:0] nss_hif_pcie6_mac_phy_messagebus ; 
logic nss_hif_pcie6_mac_phy_serdes_arch ; 
logic [3:0] nss_hif_pcie6_serdes_pipe_rxready ; 
logic nss_hif_pcie6_mac_phy_commonclock_enable ; 
logic nss_hif_pcie6_mac_phy_asyncpowerchangeack ; 
logic nss_hif_pcie6_mac_phy_sris_enable ; 
logic [3:0] nss_hif_pcie6_mac_phy_pclkchangeack ; 
logic [3:0] hif_pcie_gen6_phy_18a_hif_pcie6_phy_mac_pclkchangeok ; 
logic hif_pcie_gen6_phy_18a_phy_pcie6_max_pclk ; 
logic [319:0] hif_pcie_gen6_phy_18a_hif_pcie6_phy_mac_rxdata ; 
logic [3:0] hif_pcie_gen6_phy_18a_phy_pcie6_pipe_rx_clk ; 
logic [3:0] hif_pcie_gen6_phy_18a_hif_pcie6_phy_mac_rxstandbystatus ; 
logic [3:0] hif_pcie_gen6_phy_18a_hif_pcie6_phy_mac_rxvalid ; 
logic [3:0] hif_pcie_gen6_phy_18a_hif_pcie6_phy_mac_phystatus ; 
logic [3:0] hif_pcie_gen6_phy_18a_hif_pcie6_phy_mac_rxelecidle ; 
logic [11:0] hif_pcie_gen6_phy_18a_hif_pcie6_phy_mac_rxstatus ; 
logic [31:0] hif_pcie_gen6_phy_18a_hif_pcie6_phy_mac_messagebus ; 
logic par_nac_fabric0_par_nac_misc_adop_infra_clk_clkout_out ; 
logic par_nac_fabric0_par_nac_misc_adop_xtalclk_clkout_out ; 
logic [31:0] par_nac_fabric0_pcie_gen6_out_end_bus_data_out ; 
logic [31:0] par_nac_fabric0_mux_pcie_gen6_in_start_bus_data_in ; 
logic hif_pcie_gen6_phy_18a_NW_IN_tdo ; 
logic par_nac_fabric0_NW_OUT_hif_pcie_gen6_phy_18a_ijtag_to_reset ; 
logic par_nac_fabric0_NW_OUT_hif_pcie_gen6_phy_18a_ijtag_to_sel ; 
logic par_nac_fabric0_NW_OUT_hif_pcie_gen6_phy_18a_ijtag_to_si ; 
logic hif_pcie_gen6_phy_18a_NW_IN_ijtag_so ; 
logic hif_pcie_gen6_phy_18a_NW_IN_tap_sel_out ; 
logic [31:0] par_nac_fabric3_physs_mux_end_bus_data_out ; 
logic [31:0] par_nac_fabric3_physs_mux_start_bus_data_in ; 
logic physs_tdo ; 
logic physs_tdo_en ; 
logic par_nac_fabric3_NW_OUT_physs_ijtag_to_reset ; 
logic par_nac_fabric3_NW_OUT_physs_ijtag_to_sel ; 
logic par_nac_fabric3_NW_OUT_physs_ijtag_to_si ; 
logic physs_ijtag_so ; 
logic physs_tap_sel_in ; 
logic ETHPHY_PD0_bisr_chain_si ; 
logic ETHPHY_PD0_bisr_chain_clk ; 
logic ETHPHY_PD0_bisr_chain_rst ; 
logic ETHPHY_PD0_bisr_chain_se ; 
logic ETHPHY_PD0_bisr_chain_so ; 
logic [31:0] par_nac_fabric3_hlp_mux_end_bus_data_out ; 
logic [31:0] par_nac_fabric3_hlp_mux_start_bus_data_in ; 
logic hlp_tdo ; 
logic hlp_tdo_en ; 
logic par_nac_fabric3_NW_OUT_hlp_ijtag_to_reset ; 
logic par_nac_fabric3_NW_OUT_hlp_ijtag_to_sel ; 
logic par_nac_fabric3_NW_OUT_hlp_ijtag_to_si ; 
logic hlp_ijtag_so ; 
logic hlp_tap_sel_in ; 
logic HLP_PD0_bisr_chain_si ; 
logic HLP_PD0_bisr_chain_clk ; 
logic HLP_PD0_bisr_chain_rst ; 
logic HLP_PD0_bisr_chain_se ; 
logic HLP_PD0_bisr_chain_so ; 
logic [31:0] par_nac_misc_pipe_2_nss_out_bus_data_out ; 
logic [31:0] par_nac_misc_mux_2__nss_in_start_bus_data_in ; 
logic NW_OUT_nss_from_tdo ; 
logic par_nac_misc_NW_OUT_nss_ijtag_to_reset ; 
logic par_nac_misc_NW_OUT_nss_ijtag_to_sel ; 
logic par_nac_misc_NW_OUT_nss_ijtag_to_si ; 
logic nss_nsc_ijtag_nw_so ; 
logic nss_nsc_tap_sel_in ; 
logic [7:0] nss_t_usb_phy_c_paddr ; 
logic nss_t_usb_phy_c_penable ; 
wire [15:0] dwc_eusb2_phy_1p_ns_apb_rdata ; 
wire dwc_eusb2_phy_1p_ns_apb_rdy ; 
logic nss_eusb2_phy_presetn ; 
logic nss_t_usb_phy_c_psel ; 
wire dwc_eusb2_phy_1p_ns_apb_slverr ; 
logic [15:0] nss_t_usb_phy_c_pwdata ; 
logic nss_t_usb_phy_c_pwrite ; 
wire par_eusb_phy_ocla_clk ; 
wire [63:0] par_eusb_phy_ocla_data ; 
wire par_eusb_phy_ocla_data_vld ; 
logic nss_eusb2_phy_reset ; 
wire dwc_eusb2_phy_1p_ns_utmi_hostdisconnect ; 
wire [1:0] dwc_eusb2_phy_1p_ns_utmi_linestate ; 
logic [1:0] nss_utmi_opmode ; 
logic nss_utmi_port_reset ; 
wire [7:0] dwc_eusb2_phy_1p_ns_utmi_rx_data ; 
wire dwc_eusb2_phy_1p_ns_utmi_rxactive ; 
wire dwc_eusb2_phy_1p_ns_utmi_rxerror ; 
wire dwc_eusb2_phy_1p_ns_utmi_rxvalid ; 
logic nss_utmi_termselect ; 
logic [7:0] nss_utmi_tx_data ; 
wire dwc_eusb2_phy_1p_ns_utmi_txready ; 
logic nss_utmi_txvalid ; 
logic [1:0] nss_utmi_xcvrselect ; 
logic nss_phy_cfg_jtag_apb_sel ; 
logic nss_phy_cfg_cr_clk_sel ; 
logic nss_phy_enable ; 
logic nss_utmi_suspend_n ; 
logic par_nac_fabric0_bclk1_out_usb ; 
wire utmi_clk_rdop_par_eusb_phy_clkout ; 
logic clkss_eth_physs_fusa_pll_err_eth_physs ; 
logic axi2sb_gpsb_s_awready ; 
logic [31:0] nss_i_nmf_t_cnic_gpsb_br_AWADDR ; 
logic [1:0] nss_i_nmf_t_cnic_gpsb_br_AWBURST ; 
logic [14:0] nss_i_nmf_t_cnic_gpsb_br_AWID ; 
logic [7:0] nss_i_nmf_t_cnic_gpsb_br_AWLEN ; 
logic [2:0] nss_i_nmf_t_cnic_gpsb_br_AWPROT ; 
logic [2:0] nss_i_nmf_t_cnic_gpsb_br_AWSIZE ; 
logic nss_i_nmf_t_cnic_gpsb_br_AWVALID ; 
logic axi2sb_gpsb_s_wready ; 
logic [31:0] nss_i_nmf_t_cnic_gpsb_br_WDATA ; 
logic nss_i_nmf_t_cnic_gpsb_br_WLAST ; 
logic [3:0] nss_i_nmf_t_cnic_gpsb_br_WSTRB ; 
logic nss_i_nmf_t_cnic_gpsb_br_WVALID ; 
logic [14:0] axi2sb_gpsb_s_bid ; 
logic [1:0] axi2sb_gpsb_s_bresp ; 
logic axi2sb_gpsb_s_bvalid ; 
logic nss_i_nmf_t_cnic_gpsb_br_BREADY ; 
logic axi2sb_gpsb_s_arready ; 
logic [31:0] nss_i_nmf_t_cnic_gpsb_br_ARADDR ; 
logic [1:0] nss_i_nmf_t_cnic_gpsb_br_ARBURST ; 
logic [14:0] nss_i_nmf_t_cnic_gpsb_br_ARID ; 
logic [7:0] nss_i_nmf_t_cnic_gpsb_br_ARLEN ; 
logic [2:0] nss_i_nmf_t_cnic_gpsb_br_ARPROT ; 
logic [2:0] nss_i_nmf_t_cnic_gpsb_br_ARSIZE ; 
logic nss_i_nmf_t_cnic_gpsb_br_ARVALID ; 
logic [14:0] axi2sb_gpsb_s_rid ; 
logic [31:0] axi2sb_gpsb_s_rdata ; 
logic [1:0] axi2sb_gpsb_s_rresp ; 
logic axi2sb_gpsb_s_rlast ; 
logic axi2sb_gpsb_s_rvalid ; 
logic nss_i_nmf_t_cnic_gpsb_br_RREADY ; 
logic [2:0] axi2sb_gpsb_m_awid ; 
logic [39:0] axi2sb_gpsb_m_awaddr ; 
logic [7:0] axi2sb_gpsb_m_awlen ; 
logic [4:0] axi2sb_gpsb_m_awuser ; 
logic [2:0] axi2sb_gpsb_m_awsize ; 
logic [1:0] axi2sb_gpsb_m_awburst ; 
logic [2:0] axi2sb_gpsb_m_awprot ; 
logic axi2sb_gpsb_m_awvalid ; 
logic nss_t_nmf_i_cnic_gpsb_AWREADY ; 
logic [31:0] axi2sb_gpsb_m_wdata ; 
logic [3:0] axi2sb_gpsb_m_wstrb ; 
logic axi2sb_gpsb_m_wlast ; 
logic axi2sb_gpsb_m_wvalid ; 
logic nss_t_nmf_i_cnic_gpsb_WREADY ; 
logic axi2sb_gpsb_m_bready ; 
logic [2:0] nss_t_nmf_i_cnic_gpsb_BID ; 
logic [1:0] nss_t_nmf_i_cnic_gpsb_BRESP ; 
logic nss_t_nmf_i_cnic_gpsb_BVALID ; 
logic [2:0] axi2sb_gpsb_m_arid ; 
logic [39:0] axi2sb_gpsb_m_araddr ; 
logic [7:0] axi2sb_gpsb_m_arlen ; 
logic [4:0] axi2sb_gpsb_m_aruser ; 
logic [2:0] axi2sb_gpsb_m_arsize ; 
logic [1:0] axi2sb_gpsb_m_arburst ; 
logic [2:0] axi2sb_gpsb_m_arprot ; 
logic axi2sb_gpsb_m_arvalid ; 
logic nss_t_nmf_i_cnic_gpsb_ARREADY ; 
logic axi2sb_gpsb_m_rready ; 
logic [31:0] nss_t_nmf_i_cnic_gpsb_RDATA ; 
logic [2:0] nss_t_nmf_i_cnic_gpsb_RID ; 
logic nss_t_nmf_i_cnic_gpsb_RLAST ; 
logic [1:0] nss_t_nmf_i_cnic_gpsb_RRESP ; 
logic nss_t_nmf_i_cnic_gpsb_RVALID ; 
logic nss_reset_fabric_n ; 
logic nss_nsc_soc_imcr_qreqn ; 
logic axi2sb_pmsb_s_awready ; 
logic [31:0] nss_i_nmf_t_cnic_pmsb_br_AWADDR ; 
logic [1:0] nss_i_nmf_t_cnic_pmsb_br_AWBURST ; 
logic [14:0] nss_i_nmf_t_cnic_pmsb_br_AWID ; 
logic [7:0] nss_i_nmf_t_cnic_pmsb_br_AWLEN ; 
logic [2:0] nss_i_nmf_t_cnic_pmsb_br_AWPROT ; 
logic [2:0] nss_i_nmf_t_cnic_pmsb_br_AWSIZE ; 
logic nss_i_nmf_t_cnic_pmsb_br_AWVALID ; 
logic axi2sb_pmsb_s_wready ; 
logic [31:0] nss_i_nmf_t_cnic_pmsb_br_WDATA ; 
logic nss_i_nmf_t_cnic_pmsb_br_WLAST ; 
logic [3:0] nss_i_nmf_t_cnic_pmsb_br_WSTRB ; 
logic nss_i_nmf_t_cnic_pmsb_br_WVALID ; 
logic [14:0] axi2sb_pmsb_s_bid ; 
logic [1:0] axi2sb_pmsb_s_bresp ; 
logic axi2sb_pmsb_s_bvalid ; 
logic nss_i_nmf_t_cnic_pmsb_br_BREADY ; 
logic axi2sb_pmsb_s_arready ; 
logic [31:0] nss_i_nmf_t_cnic_pmsb_br_ARADDR ; 
logic [1:0] nss_i_nmf_t_cnic_pmsb_br_ARBURST ; 
logic [14:0] nss_i_nmf_t_cnic_pmsb_br_ARID ; 
logic [7:0] nss_i_nmf_t_cnic_pmsb_br_ARLEN ; 
logic [2:0] nss_i_nmf_t_cnic_pmsb_br_ARPROT ; 
logic [2:0] nss_i_nmf_t_cnic_pmsb_br_ARSIZE ; 
logic nss_i_nmf_t_cnic_pmsb_br_ARVALID ; 
logic [14:0] axi2sb_pmsb_s_rid ; 
logic [31:0] axi2sb_pmsb_s_rdata ; 
logic [1:0] axi2sb_pmsb_s_rresp ; 
logic axi2sb_pmsb_s_rlast ; 
logic axi2sb_pmsb_s_rvalid ; 
logic nss_i_nmf_t_cnic_pmsb_br_RREADY ; 
logic [2:0] axi2sb_pmsb_m_awid ; 
logic [39:0] axi2sb_pmsb_m_awaddr ; 
logic [7:0] axi2sb_pmsb_m_awlen ; 
logic [4:0] axi2sb_pmsb_m_awuser ; 
logic [2:0] axi2sb_pmsb_m_awsize ; 
logic [1:0] axi2sb_pmsb_m_awburst ; 
logic [2:0] axi2sb_pmsb_m_awprot ; 
logic axi2sb_pmsb_m_awvalid ; 
logic nss_t_nmf_i_cnic_pmsb_AWREADY ; 
logic [31:0] axi2sb_pmsb_m_wdata ; 
logic [3:0] axi2sb_pmsb_m_wstrb ; 
logic axi2sb_pmsb_m_wlast ; 
logic axi2sb_pmsb_m_wvalid ; 
logic nss_t_nmf_i_cnic_pmsb_WREADY ; 
logic axi2sb_pmsb_m_bready ; 
logic [2:0] nss_t_nmf_i_cnic_pmsb_BID ; 
logic [1:0] nss_t_nmf_i_cnic_pmsb_BRESP ; 
logic nss_t_nmf_i_cnic_pmsb_BVALID ; 
logic [2:0] axi2sb_pmsb_m_arid ; 
logic [39:0] axi2sb_pmsb_m_araddr ; 
logic [7:0] axi2sb_pmsb_m_arlen ; 
logic [4:0] axi2sb_pmsb_m_aruser ; 
logic [2:0] axi2sb_pmsb_m_arsize ; 
logic [1:0] axi2sb_pmsb_m_arburst ; 
logic [2:0] axi2sb_pmsb_m_arprot ; 
logic axi2sb_pmsb_m_arvalid ; 
logic nss_t_nmf_i_cnic_pmsb_ARREADY ; 
logic axi2sb_pmsb_m_rready ; 
logic [31:0] nss_t_nmf_i_cnic_pmsb_RDATA ; 
logic [2:0] nss_t_nmf_i_cnic_pmsb_RID ; 
logic nss_t_nmf_i_cnic_pmsb_RLAST ; 
logic [1:0] nss_t_nmf_i_cnic_pmsb_RRESP ; 
logic nss_t_nmf_i_cnic_pmsb_RVALID ; 
wire divmux_aonclk1x_0 ; 
wire divmux_rdop_aonclk1x_clkout ; 
wire divmux_rdop_aonclk5x_clkout ; 
logic par_nac_fabric3_boot_112p5_rdop_fout2_clkout_out ; 
logic par_nac_misc_par_nac_misc_adop_xtalclk_clkout ; 
logic par_nac_fabric1_par_nac_misc_adop_xtalclk_clkout_out ; 
logic par_nac_fabric1_par_nac_misc_adop_xtalclk_clkout_out_sn2sfi ; 
logic par_nac_misc_par_nac_misc_adop_xtalclk_clkout_fabric2 ; 
logic par_nac_fabric2_par_nac_misc_adop_xtalclk_clkout_out ; 
logic par_nac_misc_div2_ecm_clk_clkout ; 
logic par_nac_fabric1_div2_ecm_clk_clkout_out ; 
logic par_nac_fabric0_div2_ecm_clk_clkout_out ; 
logic par_nac_fabric1_sfi_clk_1g_in_out ; 
logic par_sn2sfi_sfi_clk_1g_in_out ; 
logic par_nac_misc_par_nac_misc_adop_infra_clk_clkout ; 
logic par_nac_misc_par_nac_misc_adop_infra_clk_clkout_fabric2 ; 
logic par_nac_fabric2_par_nac_misc_adop_infra_clk_clkout_out ; 
logic par_nac_fabric1_par_nac_misc_adop_infra_clk_clkout_out ; 
logic par_nac_fabric1_par_nac_misc_adop_infra_clk_clkout_out_sn2sfi ; 
logic par_nac_misc_par_nac_misc_adop_bclk_clkout_0 ; 
logic par_nac_fabric1_par_nac_misc_adop_bclk_clkout_out ; 
logic par_nac_fabric1_bclk1_out ; 
logic par_nac_misc_par_nac_misc_adop_bclk_clkout_0_fabric2 ; 
logic par_nac_fabric2_par_nac_misc_adop_bclk_clkout_out ; 
logic cmlbuf51_o_clk_cmlclkout_p_ana ; 
logic par_nac_fabric2_o_clk_cmlclkout_p_ana_out ; 
logic par_nac_fabric3_o_clk_cmlclkout_p_ana_out ; 
logic cmlbuf51_o_clk_cmlclkout_n_ana ; 
logic par_nac_fabric2_o_clk_cmlclkout_n_ana_out ; 
logic par_nac_fabric3_o_clk_cmlclkout_n_ana_out ; 
wire boot_450_rdop_fout1_clkout ; 
wire boot_900_rdop_fout0_clkout ; 
logic par_nac_misc_boot_112p5_rdop_fout2_clkout ; 
logic par_nac_misc_boot_112p5_rdop_fout2_clkout_fabric2 ; 
logic par_nac_fabric1_boot_112p5_rdop_fout2_clkout_out ; 
logic par_nac_fabric2_boot_112p5_rdop_fout2_clkout_out ; 
wire nss_eusb2_phy_pclk ; 
wire boot_250_rdop_fout3_clkout ; 
logic par_nac_misc_boot_20_rdop_fout5_clkout ; 
logic par_nac_fabric1_boot_20_rdop_fout5_clkout_out ; 
logic par_nac_fabric0_boot_20_rdop_fout5_clkout_out ; 
wire boot_750_rdop_fout4_clkout ; 
wire boot_529p41_rdop_fout6_clkout ; 
logic par_nac_fabric0_boot_112p5_rdop_fout2_clkout ; 
logic par_nac_fabric0_par_nac_misc_adop_bclk_clkout_0_out ; 
logic par_nac_misc_par_nac_misc_adop_rstbus_clk_clkout_0 ; 
logic par_nac_fabric1_par_nac_misc_adop_rstbus_clk_clkout_out ; 
logic par_nac_fabric0_par_nac_misc_adop_rstbus_clk_clkout_out ; 
logic par_nac_misc_par_nac_misc_adop_rstbus_clk_clkout_0_fabric2 ; 
logic par_nac_fabric2_par_nac_misc_adop_rstbus_clk_clkout_out ; 
wire eth_physs_rdop_fout3_clkout_0 ; 
wire dfd_dop_enable_sync_o ; 
logic [31:0] pll_top_boot_prdata ; 
logic pll_top_boot_pready ; 
logic pll_top_boot_pslverr ; 
logic [31:0] nss_i_nmf_t_clk_boot_paddr ; 
logic nss_i_nmf_t_clk_boot_penable ; 
logic nss_i_nmf_t_clk_boot_pwrite ; 
logic [31:0] nss_i_nmf_t_clk_boot_pwdata ; 
logic nss_i_nmf_t_clk_boot_psel_0 ; 
wire eth_physs_rdop_fout0_clkout ; 
logic physs_physs_intf0_clk_out ; 
wire eth_physs_rdop_fout1_clkout ; 
wire eth_physs_rdop_fout2_clkout ; 
logic par_nac_fabric3_eth_physs_rdop_fout3_clkout ; 
logic par_nac_fabric2_eth_physs_rdop_fout3_clkout_nac_misc ; 
logic par_nac_fabric2_eth_physs_rdop_fout3_clkout_fabric1 ; 
logic par_nac_fabric1_eth_physs_rdop_fout3_clkout_sn2sfi ; 
logic par_nac_fabric1_eth_physs_rdop_fout3_clkout_fabric0 ; 
logic par_nac_fabric0_eth_physs_rdop_fout3_clkout_out ; 
logic rstw_pll_top_eth_physs_reset_error ; 
logic rstw_pll_top_eth_physs_reset_cmd_ack ; 
logic rsrc_pll_top_eth_physs_uc_ierr ; 
wire divmux_socpll_refclk_0 ; 
logic [31:0] pll_top_eth_physs_prdata ; 
logic pll_top_eth_physs_pready ; 
logic pll_top_eth_physs_pslverr ; 
logic [31:0] nss_i_nmf_t_cnic_pll_hlp_paddr ; 
logic nss_i_nmf_t_cnic_pll_hlp_penable ; 
logic nss_i_nmf_t_cnic_pll_hlp_pwrite ; 
logic [31:0] nss_i_nmf_t_cnic_pll_hlp_pwdata ; 
logic nss_i_nmf_t_cnic_pll_hlp_psel_0 ; 
wire eth_physs_rdop_fout5_clkout ; 
wire nss_962p5_rdop_fout0_clkout ; 
wire nss_1375_rdop_fout7_clkout ; 
wire nss_1069p44_rdop_fout5_clkout ; 
wire nss_641p67_rdop_fout6_clkout ; 
wire nss_1069p44_rdop_fout8_clkout ; 
wire nss_1604p17_rdop_fout1_clkout ; 
wire nss_1604p17_rdop_fout4_clkout ; 
logic [31:0] pll_top_nss_prdata ; 
logic pll_top_nss_pready ; 
logic pll_top_nss_pslverr ; 
logic [31:0] nss_i_nmf_t_clk_nss0_paddr ; 
logic nss_i_nmf_t_clk_nss0_penable ; 
logic nss_i_nmf_t_clk_nss0_pwrite ; 
logic [31:0] nss_i_nmf_t_clk_nss0_pwdata ; 
logic nss_i_nmf_t_clk_nss0_psel_0 ; 
logic par_nac_misc_ts_800_rdop_fout0_clkout ; 
logic par_nac_fabric1_ts_800_rdop_fout0_clkout_out ; 
logic par_nac_misc_ts_800_rdop_fout0_clkout_fabric2 ; 
logic par_nac_fabric2_ts_800_rdop_fout0_clkout_out ; 
logic par_nac_fabric0_ts_800_rdop_fout0_clkout_out ; 
logic par_nac_fabric3_ts_800_rdop_fout0_clkout_hlp ; 
logic par_nac_fabric3_ts_800_rdop_fout0_clkout_physs ; 
wire ts_100_rdop_fout1_clkout ; 
logic [127:0] clk_misc_fusebox_fuse_bus_2 ; 
logic [31:0] pll_top_ts_prdata ; 
logic pll_top_ts_pready ; 
logic pll_top_ts_pslverr ; 
logic [31:0] nss_i_nmf_t_clk_ts_paddr ; 
logic nss_i_nmf_t_clk_ts_penable ; 
logic nss_i_nmf_t_clk_ts_pwrite ; 
logic [31:0] nss_i_nmf_t_clk_ts_pwdata ; 
logic nss_i_nmf_t_clk_ts_psel_0 ; 
logic dtf_rep_hlp_fab3_arb0_rep0_dtfr_upstream_d0_credit_out ; 
logic dtf_rep_hlp_fab3_arb0_rep0_dtfr_upstream_d0_active_out ; 
logic dtf_rep_hlp_fab3_arb0_rep0_dtfr_upstream_d0_sync_out ; 
logic [63:0] hlp_dtf_dnstream_data_out ; 
logic hlp_dtf_dnstream_valid_out ; 
logic [24:0] hlp_dtf_dnstream_header_out ; 
logic dtf_arb0_nac_fabric0_dtfa_upstream1_active_out ; 
logic dtf_arb0_nac_fabric0_dtfa_upstream1_credit_out ; 
logic dtf_arb0_nac_fabric0_dtfa_upstream1_sync_out ; 
logic [63:0] hif_pcie_gen6_phy_18a_pciephyss_nac_dtf_dnstream_data ; 
logic [24:0] hif_pcie_gen6_phy_18a_pciephyss_nac_dtf_dnstream_header ; 
logic hif_pcie_gen6_phy_18a_pciephyss_nac_dtf_dnstream_valid ; 
logic dtf_rep_fab1_iosf2sfi_arb1_rep0_dtfr_upstream_d0_active_out ; 
logic dtf_rep_fab1_iosf2sfi_arb1_rep0_dtfr_upstream_d0_credit_out ; 
logic dtf_rep_fab1_iosf2sfi_arb1_rep0_dtfr_upstream_d0_sync_out ; 
logic [63:0] par_sn2sfi_iosf2sfi_dtfa_dnstream_data_out ; 
logic [24:0] par_sn2sfi_iosf2sfi_dtfa_dnstream_header_out ; 
logic par_sn2sfi_iosf2sfi_dtfa_dnstream_valid_out ; 
logic dtf_rep_fab1_sn2iosf_arb1_rep0_dtfr_upstream_d0_active_out ; 
logic dtf_rep_fab1_sn2iosf_arb1_rep0_dtfr_upstream_d0_credit_out ; 
logic dtf_rep_fab1_sn2iosf_arb1_rep0_dtfr_upstream_d0_sync_out ; 
logic [63:0] par_sn2sfi_sn2iosf_dtfa_dnstream_data_out ; 
logic [24:0] par_sn2sfi_sn2iosf_dtfa_dnstream_header_out ; 
logic par_sn2sfi_sn2iosf_dtfa_dnstream_valid_out ; 
logic dtf_rep_misc_nsc_clkarb1_rep0_dtfr_upstream_d0_credit_out ; 
logic dtf_rep_misc_nsc_clkarb1_rep0_dtfr_upstream_d0_active_out ; 
logic dtf_rep_misc_nsc_clkarb1_rep0_dtfr_upstream_d0_sync_out ; 
logic [24:0] nss_nsc_dlw_next_arb2arb_DTFA_HEADER ; 
logic [63:0] nss_nsc_dlw_next_arb2arb_DTFA_DATA ; 
logic nss_nsc_dlw_next_arb2arb_DTFA_VALID ; 
wire par_nac_fabric1_pdop_dtf_clk_clkout ; 
wire par_nac_fabric2_pdop_dtf_clk_clkout ; 
logic hif_pcie_gen6_phy_18a_pciephyss_nac_debug_dtf_clkout ; 
wire par_nac_fabric0_pdop_dtf_clk_clkout_0 ; 
logic socviewpin_32to1digimux_fabric0_0_outmux ; 
logic socviewpin_32to1digimux_fabric0_1_outmux ; 
logic socviewpin_32to1digimux_fabric3_0_outmux ; 
logic socviewpin_32to1digimux_fabric3_1_outmux ; 
logic hif_pcie_gen6_phy_18a_pcie_phy0_adpllg6_og_dig_obs ; 
logic hif_pcie_gen6_phy_18a_pcie_phy0_adpllg6_og_dig_obs_0 ; 
logic hif_pcie_gen6_phy_18a_pcie_phy0_adpllg6_og_dig_obs_1 ; 
logic hif_pcie_gen6_phy_18a_pcie_phy0_adpllg6_og_dig_obs_2 ; 
logic hif_pcie_gen6_phy_18a_pcie_phy1_adpllg6_og_dig_obs ; 
logic hif_pcie_gen6_phy_18a_pcie_phy1_adpllg6_og_dig_obs_0 ; 
logic hif_pcie_gen6_phy_18a_pcie_phy1_adpllg6_og_dig_obs_1 ; 
logic hif_pcie_gen6_phy_18a_pcie_phy1_adpllg6_og_dig_obs_2 ; 
logic hif_pcie_gen6_phy_18a_pcie_phy2_adpllg6_og_dig_obs ; 
logic hif_pcie_gen6_phy_18a_pcie_phy2_adpllg6_og_dig_obs_0 ; 
logic hif_pcie_gen6_phy_18a_pcie_phy2_adpllg6_og_dig_obs_1 ; 
logic hif_pcie_gen6_phy_18a_pcie_phy2_adpllg6_og_dig_obs_2 ; 
logic hif_pcie_gen6_phy_18a_pcie_phy3_adpllg6_og_dig_obs ; 
logic hif_pcie_gen6_phy_18a_pcie_phy3_adpllg6_og_dig_obs_0 ; 
logic hif_pcie_gen6_phy_18a_pcie_phy3_adpllg6_og_dig_obs_1 ; 
logic hif_pcie_gen6_phy_18a_pcie_phy3_adpllg6_og_dig_obs_2 ; 
logic hif_pcie_gen6_phy_18a_pciephyss_nac_dig_viewpin_rdop_dft ; 
logic hif_pcie_gen6_phy_18a_pciephyss_nac_dig_viewpin_rdop_dft_0 ; 
logic utmi_clk_rdop_par_eusb_phy_clkbuf_clkout ; 
logic hlp_dig_view_out_0 ; 
logic hlp_dig_view_out_1 ; 
logic physs_physs_clkobs_out_clk ; 
logic physs_physs_clkobs_out_clk_0 ; 
logic nss_reset_debug_apb_n ; 
logic nss_reset_debug_soc_n ; 
logic nss_arm_debug_en ; 
logic nss_reset_debug_dap_n ; 
wire css600_dpreceiver_nac_ss_cdbgrstreq ; 
logic nss_cdbgrstack_cdbgrst ; 
logic nss_cnic_apbic_pready ; 
logic nss_cnic_apbic_pslverr ; 
logic [31:0] nss_cnic_apbic_prdata ; 
wire css600_apbic_ioexp_apbic0_nac_ss_pwakeup_r2 ; 
wire css600_apbic_ioexp_apbic0_nac_ss_psel_r2 ; 
wire css600_apbic_ioexp_apbic0_nac_ss_penable_r2 ; 
wire css600_apbic_ioexp_apbic0_nac_ss_pwrite_r2 ; 
wire [2:0] css600_apbic_ioexp_apbic0_nac_ss_pprot_r2 ; 
wire css600_apbic_ioexp_apbic0_nac_ss_pnse_r2 ; 
wire [23:0] css600_apbic_ioexp_apbic0_nac_ss_paddr_r2 ; 
wire [31:0] css600_apbic_ioexp_apbic0_nac_ss_pwdata_r2 ; 
wire css600_apbasyncbridgecompleter_nsc_nmf_nac_ss_pready_c ; 
wire css600_apbasyncbridgecompleter_nsc_nmf_nac_ss_pslverr_c ; 
wire [31:0] css600_apbasyncbridgecompleter_nsc_nmf_nac_ss_prdata_c ; 
logic nss_i_nmf_t_cnic_apbic_psel_0 ; 
logic nss_i_nmf_t_cnic_apbic_penable ; 
logic nss_i_nmf_t_cnic_apbic_pwrite ; 
logic [2:0] nss_i_nmf_t_cnic_apbic_pprot ; 
logic [18:0] nss_i_nmf_t_cnic_apbic_paddr ; 
logic [31:0] nss_i_nmf_t_cnic_apbic_pwdata ; 
logic nss_nmc_atb_atwakeup ; 
logic [6:0] nss_nmc_atb_atid ; 
logic [2:0] nss_nmc_atb_atbytes ; 
logic [63:0] nss_nmc_atb_atdata ; 
logic nss_nmc_atb_atvalid ; 
logic nss_nmc_atb_afready ; 
wire css600_tmc_etf_nac_ss_atready_rx ; 
wire css600_tmc_etf_nac_ss_afvalid_rx ; 
wire css600_tmc_etf_nac_ss_syncreq_rx ; 
logic [3:0] nss_nac_cti_channel_in ; 
wire [3:0] css600_cti_nac_ss_channel_out ; 
logic [255:0] par_ecm_ifp_fuse_VisaDebug ; 
wire par_ecm_ifp_fuse_fuse_shim_visa_sig_clk ; 
logic dfxsecure_plugin_dpt2_par_nac_fabric0_adfx_tap_grpA_enable ; 
logic dfxsecure_plugin_dpt2_par_nac_fabric0_adfx_tap_grpB_enable ; 
logic dfxsecure_plugin_dpt2_par_nac_fabric0_adfx_tap_grpC_enable ; 
logic dfxsecure_plugin_dpt2_par_nac_fabric0_adfx_tap_grpD_enable ; 
logic dfxsecure_plugin_dpt2_par_nac_fabric0_adfx_tap_grpE_enable ; 
logic dfxsecure_plugin_dpt2_par_nac_fabric0_adfx_tap_grpF_enable ; 
logic dfxsecure_plugin_dpt2_par_nac_fabric0_adfx_tap_grpG_enable ; 
logic dfxsecure_plugin_dpt2_par_nac_fabric0_adfx_tap_grpH_enable ; 
logic dfxsecure_plugin_dpt2_par_nac_fabric0_adfx_tap_grpZ_enable ; 
wire [6:0] hlp_efbisr_reg_Q_0 ; 
wire [9:0] hlp_efbisr_reg_Q_1 ; 
wire [16:0] hlp_efbisr_reg_Q_2 ; 
wire [16:0] hlp_efbisr_reg_Q_3 ; 
wire [15:0] hlp_efbisr_reg_Q_4 ; 
logic par_nac_fabric0_phy_cfg_jtag_apb_sel_ovr ; 
logic par_nac_fabric0_phy_cfg_jtag_apb_sel_val ; 
logic par_nac_fabric0_test_burnin ; 
logic par_nac_fabric0_test_iddq ; 
logic par_nac_fabric0_test_loopback_en ; 
logic par_nac_fabric0_test_stop_clk_en ; 
logic par_nac_fabric0_scan_occ_clkgen_chain_bypass ; 
logic par_nac_fabric0_phy_cfg_cr_clk_sel_ovr ; 
logic par_nac_fabric0_phy_cfg_cr_clk_sel_val ; 
logic par_nac_fabric0_phy_cfg_por_in_lx_ovr ; 
logic par_nac_fabric0_phy_cfg_por_in_lx_val ; 
logic par_nac_fabric0_phy_cfg_tx_fsls_vreg_bypass_ovr ; 
logic par_nac_fabric0_phy_cfg_tx_fsls_vreg_bypass_val ; 
logic par_nac_fabric0_ref_freq_sel_2_0_ovr ; 
logic par_nac_fabric0_ref_freq_sel_2_0_val ; 
logic par_nac_fabric0_ref_freq_sel_2_0_val_0 ; 
logic par_nac_fabric0_ref_freq_sel_2_0_val_1 ; 
logic par_nac_fabric0_utmi_suspend_n_ovr ; 
logic par_nac_fabric0_utmi_suspend_n_val ; 
logic par_nac_fabric0_phy_enable_ovr ; 
logic par_nac_fabric0_phy_enable_val ; 
logic par_nac_fabric0_phy_tx_dig_bypass_sel_ovr ; 
logic par_nac_fabric0_phy_tx_dig_bypass_sel_val ; 
logic [9:0] par_nac_fabric0_eusb_si_bgn ; 
logic par_nac_fabric0_eusb_si_bgn_0 ; 
logic [2:0] par_nac_fabric0_eusb_si_bgn_1 ; 
logic [28:0] par_nac_fabric0_eusb_si_bgn_2 ; 
logic par_nac_fabric0_eusb_si_bgn_3 ; 
logic par_nac_fabric0_eusb_si_bgn_4 ; 
logic [1:0] par_nac_fabric0_eusb_si_bgn_5 ; 
logic [1:0] par_nac_fabric0_eusb_si_bgn_6 ; 
logic [9:0] par_eusb_phy_scan_sclk_out ; 
logic par_eusb_phy_scan_ref_out ; 
logic [2:0] par_eusb_phy_scan_pll_out ; 
logic [28:0] par_eusb_phy_scan_pclk_out ; 
logic par_eusb_phy_scan_ocla_out ; 
logic par_eusb_phy_scan_occ_clkgen_out ; 
logic [1:0] par_eusb_phy_scan_jtag_out ; 
logic [1:0] par_eusb_phy_scan_apb_out ; 
logic par_nac_fabric0_scan_sclk_clk ; 
logic par_nac_fabric0_scan_ref_clk ; 
logic par_nac_fabric0_scan_pll_clk ; 
logic par_nac_fabric0_scan_pclk_clk ; 
logic par_nac_fabric0_scan_ocla_clk ; 
logic par_nac_fabric0_eusb_jtag_trst_n ; 
logic par_nac_fabric0_eusb_jtag_tms ; 
logic par_nac_fabric0_eusb_jtag_tdi ; 
logic par_nac_fabric0_eusb_jtag_tck ; 
logic par_eusb_phy_jtag_tdo_en ; 
logic par_eusb_phy_jtag_tdo ; 
logic par_nac_fabric0_scan_set_rst ; 
logic par_nac_fabric0_scan_shift ; 
logic par_nac_fabric0_scan_shift_cg ; 
logic par_nac_fabric0_scan_mode ; 
logic par_nac_fabric0_scan_asst_mode_en ; 
logic par_nac_fabric0_utmi_clk_bypass ; 
logic par_eusb_phy_ldo_power_ready ; 
logic [5:0] nss_ecm_fuse_margin ; 
logic [15:0] nss_ecm_fuse_paddr ; 
logic nss_ecm_fuse_penable ; 
logic nss_ecm_fuse_pwrite ; 
logic [31:0] nss_ecm_fuse_pwdata ; 
logic nss_ecm_fuse_psel ; 
logic [31:0] ifs_shim_ecm_shim_prdata ; 
logic ifs_shim_ecm_shim_pready ; 
logic ifs_shim_ecm_shim_pslverr ; 
logic [7:0] ifs_shim_ecm_fuse_attack_bus ; 
logic nss_ecm_fuse_burst_sense ; 
logic [2:0] nss_ecm_fuse_isense_tune ; 
logic [2:0] nss_ecm_fuse_opcode ; 
logic nss_ecm_fuse_burst_pgm ; 
logic ifs_shim_ecm_fuse_cp_on ; 
logic [7:0] hlp_hlp_intr_0 ; 
logic [7:0] hlp_hlp_intr_1 ; 
logic physs_mac100_0_int ; 
logic physs_mac100_0_int_0 ; 
logic physs_mac100_0_int_1 ; 
logic physs_mac100_0_int_2 ; 
logic physs_mac100_1_int ; 
logic physs_mac100_1_int_0 ; 
logic physs_mac100_1_int_1 ; 
logic physs_mac100_1_int_2 ; 
logic physs_mac400_0_int ; 
logic physs_mac400_0_int_0 ; 
logic physs_mac400_1_int ; 
logic physs_mac400_1_int_0 ; 
logic physs_mac800_0_int ; 
logic physs_physs_ts_int ; 
logic physs_physs_ts_int_0 ; 
logic physs_physs_ts_int_1 ; 
logic physs_physs_ts_int_2 ; 
logic physs_physs_ts_int_3 ; 
logic physs_physs_ts_int_4 ; 
logic physs_physs_ts_int_5 ; 
logic physs_physs_ts_int_6 ; 
logic physs_o_ucss_irq_status_a ; 
logic physs_o_ucss_irq_status_a_0 ; 
logic physs_o_ucss_irq_status_a_1 ; 
logic physs_o_ucss_irq_status_a_2 ; 
logic physs_o_ucss_irq_status_a_3 ; 
logic physs_o_ucss_irq_status_a_4 ; 
logic physs_o_ucss_irq_status_a_5 ; 
logic physs_o_ucss_irq_status_a_6 ; 
logic physs_o_ucss_irq_cpi_0_a ; 
logic physs_o_ucss_irq_cpi_0_a_0 ; 
logic physs_o_ucss_irq_cpi_0_a_1 ; 
logic physs_o_ucss_irq_cpi_0_a_2 ; 
logic physs_o_ucss_irq_cpi_1_a ; 
logic physs_o_ucss_irq_cpi_1_a_0 ; 
logic physs_o_ucss_irq_cpi_1_a_1 ; 
logic physs_o_ucss_irq_cpi_1_a_2 ; 
logic physs_o_ucss_irq_cpi_2_a ; 
logic physs_o_ucss_irq_cpi_2_a_0 ; 
logic physs_o_ucss_irq_status_a_7 ; 
logic physs_o_ucss_irq_status_a_8 ; 
logic physs_o_ucss_irq_status_a_9 ; 
logic physs_o_ucss_irq_status_a_10 ; 
logic physs_o_ucss_irq_status_a_11 ; 
logic physs_o_ucss_irq_status_a_12 ; 
logic physs_o_ucss_irq_status_a_13 ; 
logic physs_o_ucss_irq_status_a_14 ; 
logic physs_o_ucss_irq_cpi_2_a_1 ; 
logic physs_o_ucss_irq_cpi_2_a_2 ; 
logic physs_o_ucss_irq_cpi_3_a ; 
logic physs_o_ucss_irq_cpi_3_a_0 ; 
logic physs_o_ucss_irq_cpi_3_a_1 ; 
logic physs_o_ucss_irq_cpi_3_a_2 ; 
logic physs_o_ucss_irq_cpi_4_a ; 
logic physs_o_ucss_irq_cpi_4_a_0 ; 
logic physs_o_ucss_irq_cpi_4_a_1 ; 
logic physs_o_ucss_irq_cpi_4_a_2 ; 
logic nss_intr_i2c ; 
logic nss_intr_i2c_0 ; 
logic nss_intr_i2c_1 ; 
logic nss_intr_i2c_2 ; 
logic nss_intr_i2c_3 ; 
logic [31:0] nss_i_nmf_t_cnic_intr_hndlr_paddr ; 
logic nss_i_nmf_t_cnic_intr_hndlr_penable ; 
logic nss_i_nmf_t_cnic_intr_hndlr_pwrite ; 
logic [31:0] nss_i_nmf_t_cnic_intr_hndlr_pwdata ; 
logic [2:0] nss_i_nmf_t_cnic_intr_hndlr_pprot ; 
logic [3:0] nss_i_nmf_t_cnic_intr_hndlr_pstrb ; 
logic nss_i_nmf_t_cnic_intr_hndlr_psel_0 ; 
logic [31:0] hic_top_wrap_prdata ; 
logic hic_top_wrap_pready ; 
logic hic_top_wrap_pslverr ; 
logic hic_top_wrap_m_axi_awid ; 
logic [39:0] hic_top_wrap_m_axi_awaddr ; 
logic [7:0] hic_top_wrap_m_axi_awlen ; 
logic [2:0] hic_top_wrap_m_axi_awsize ; 
logic [1:0] hic_top_wrap_m_axi_awburst ; 
logic hic_top_wrap_m_axi_awlock ; 
logic [3:0] hic_top_wrap_m_axi_awcache ; 
logic [2:0] hic_top_wrap_m_axi_awprot ; 
logic [3:0] hic_top_wrap_m_axi_awqos ; 
logic hic_top_wrap_m_axi_awvalid ; 
logic nss_t_nmf_i_cnic_intr_hndlr_AWREADY ; 
logic [31:0] hic_top_wrap_m_axi_wdata ; 
logic [3:0] hic_top_wrap_m_axi_wstrb ; 
logic hic_top_wrap_m_axi_wlast ; 
logic hic_top_wrap_m_axi_wvalid ; 
logic nss_t_nmf_i_cnic_intr_hndlr_WREADY ; 
logic nss_t_nmf_i_cnic_intr_hndlr_BID ; 
logic [1:0] nss_t_nmf_i_cnic_intr_hndlr_BRESP ; 
logic hic_top_wrap_m_axi_bready ; 
logic nss_t_nmf_i_cnic_intr_hndlr_BVALID ; 
logic physs_physs_fatal_int_0 ; 
logic physs_physs_fatal_int_1 ; 
logic physs_physs_imc_int_0 ; 
logic physs_physs_imc_int_1 ; 
logic hlp_hlp_fatal_intr ; 
logic hlp_hlp_nonfatal_intr ; 
logic axi2sb_gpsb_irq ; 
logic axi2sb_pmsb_irq ; 
logic clkss_boot_fusa_pll_err_boot_0 ; 
logic clkss_ts_fusa_pll_err_ts_0 ; 
logic clkss_nss_fusa_pll_err_nss_0 ; 
logic hic_top_wrap_axi_irq_out ; 
logic nac_otp_pready ; 
logic nac_otp_pslverr ; 
logic [31:0] nac_otp_prdata ; 
logic nss_cnic_i_nmf_t_cnic_nsc_pfb_pwrite ; 
logic [31:0] nss_cnic_i_nmf_t_cnic_nsc_pfb_pwdata ; 
logic nss_cnic_i_nmf_t_cnic_nsc_pfb_psel_0 ; 
logic nss_cnic_i_nmf_t_cnic_nsc_pfb_penable ; 
logic [11:0] nss_cnic_i_nmf_t_cnic_nsc_pfb_paddr ; 
logic [15:0] nss_nss_wol_pins ; 
logic [15:0] physs_hlp_repeater_hlp_port0_cgmii_rx_c ; 
logic [127:0] physs_hlp_repeater_hlp_port0_cgmii_rx_data ; 
logic physs_hlp_repeater_hlp_port0_cgmii_rxclk_ena ; 
logic physs_hlp_repeater_hlp_port0_cgmii_rxt0_next ; 
logic [15:0] hlp_hlp_port0_cgmii_tx_c ; 
logic [127:0] hlp_hlp_port0_cgmii_tx_data ; 
logic physs_hlp_repeater_hlp_port0_cgmii_txclk_ena ; 
logic [7:0] physs_hlp_repeater_hlp_port0_xlgmii_rx_c ; 
logic [63:0] physs_hlp_repeater_hlp_port0_xlgmii_rx_data ; 
logic physs_hlp_repeater_hlp_port0_xlgmii_rxclk_ena ; 
logic physs_hlp_repeater_hlp_port0_xlgmii_rxt0_next ; 
logic [7:0] hlp_hlp_port0_xlgmii_tx_c ; 
logic [63:0] hlp_hlp_port0_xlgmii_tx_data ; 
logic physs_hlp_repeater_hlp_port0_xlgmii_txclk_ena ; 
logic [15:0] physs_hlp_repeater_hlp_port10_cgmii_rx_c ; 
logic [127:0] physs_hlp_repeater_hlp_port10_cgmii_rx_data ; 
logic physs_hlp_repeater_hlp_port10_cgmii_rxclk_ena ; 
logic physs_hlp_repeater_hlp_port10_cgmii_rxt0_next ; 
logic [15:0] hlp_hlp_port10_cgmii_tx_c ; 
logic [127:0] hlp_hlp_port10_cgmii_tx_data ; 
logic physs_hlp_repeater_hlp_port10_cgmii_txclk_ena ; 
logic [6:0] physs_hlp_repeater_hlp_port10_desk_rlevel ; 
logic physs_hlp_repeater_hlp_port10_link_status ; 
logic [1:0] physs_hlp_repeater_hlp_port10_mii_rx_tsu ; 
logic [1:0] physs_hlp_repeater_hlp_port10_mii_tx_tsu ; 
logic [7:0] physs_hlp_repeater_hlp_port10_sd_bit_slip ; 
logic [1:0] physs_hlp_repeater_hlp_port10_tsu_rx_sd ; 
logic [7:0] physs_hlp_repeater_hlp_port10_xlgmii_rx_c ; 
logic [63:0] physs_hlp_repeater_hlp_port10_xlgmii_rx_data ; 
logic physs_hlp_repeater_hlp_port10_xlgmii_rxclk_ena ; 
logic physs_hlp_repeater_hlp_port10_xlgmii_rxt0_next ; 
logic [7:0] hlp_hlp_port10_xlgmii_tx_c ; 
logic [63:0] hlp_hlp_port10_xlgmii_tx_data ; 
logic physs_hlp_repeater_hlp_port10_xlgmii_txclk_ena ; 
logic [15:0] physs_hlp_repeater_hlp_port11_cgmii_rx_c ; 
logic [127:0] physs_hlp_repeater_hlp_port11_cgmii_rx_data ; 
logic physs_hlp_repeater_hlp_port11_cgmii_rxclk_ena ; 
logic physs_hlp_repeater_hlp_port11_cgmii_rxt0_next ; 
logic [15:0] hlp_hlp_port11_cgmii_tx_c ; 
logic [127:0] hlp_hlp_port11_cgmii_tx_data ; 
logic physs_hlp_repeater_hlp_port11_cgmii_txclk_ena ; 
logic [6:0] physs_hlp_repeater_hlp_port11_desk_rlevel ; 
logic physs_hlp_repeater_hlp_port11_link_status ; 
logic [1:0] physs_hlp_repeater_hlp_port11_mii_rx_tsu ; 
logic [1:0] physs_hlp_repeater_hlp_port11_mii_tx_tsu ; 
logic [7:0] physs_hlp_repeater_hlp_port11_sd_bit_slip ; 
logic [1:0] physs_hlp_repeater_hlp_port11_tsu_rx_sd ; 
logic [7:0] physs_hlp_repeater_hlp_port11_xlgmii_rx_c ; 
logic [63:0] physs_hlp_repeater_hlp_port11_xlgmii_rx_data ; 
logic physs_hlp_repeater_hlp_port11_xlgmii_rxclk_ena ; 
logic physs_hlp_repeater_hlp_port11_xlgmii_rxt0_next ; 
logic [7:0] hlp_hlp_port11_xlgmii_tx_c ; 
logic [63:0] hlp_hlp_port11_xlgmii_tx_data ; 
logic physs_hlp_repeater_hlp_port11_xlgmii_txclk_ena ; 
logic [15:0] physs_hlp_repeater_hlp_port12_cgmii_rx_c ; 
logic [127:0] physs_hlp_repeater_hlp_port12_cgmii_rx_data ; 
logic physs_hlp_repeater_hlp_port12_cgmii_rxclk_ena ; 
logic physs_hlp_repeater_hlp_port12_cgmii_rxt0_next ; 
logic [15:0] hlp_hlp_port12_cgmii_tx_c ; 
logic [127:0] hlp_hlp_port12_cgmii_tx_data ; 
logic physs_hlp_repeater_hlp_port12_cgmii_txclk_ena ; 
logic [6:0] physs_hlp_repeater_hlp_port12_desk_rlevel ; 
logic physs_hlp_repeater_hlp_port12_link_status ; 
logic [1:0] physs_hlp_repeater_hlp_port12_mii_rx_tsu ; 
logic [1:0] physs_hlp_repeater_hlp_port12_mii_tx_tsu ; 
logic [7:0] physs_hlp_repeater_hlp_port12_sd_bit_slip ; 
logic [1:0] physs_hlp_repeater_hlp_port12_tsu_rx_sd ; 
logic [7:0] physs_hlp_repeater_hlp_port12_xlgmii_rx_c ; 
logic [63:0] physs_hlp_repeater_hlp_port12_xlgmii_rx_data ; 
logic physs_hlp_repeater_hlp_port12_xlgmii_rxclk_ena ; 
logic physs_hlp_repeater_hlp_port12_xlgmii_rxt0_next ; 
logic [7:0] hlp_hlp_port12_xlgmii_tx_c ; 
logic [63:0] hlp_hlp_port12_xlgmii_tx_data ; 
logic physs_hlp_repeater_hlp_port12_xlgmii_txclk_ena ; 
logic [15:0] physs_hlp_repeater_hlp_port13_cgmii_rx_c ; 
logic [127:0] physs_hlp_repeater_hlp_port13_cgmii_rx_data ; 
logic physs_hlp_repeater_hlp_port13_cgmii_rxclk_ena ; 
logic physs_hlp_repeater_hlp_port13_cgmii_rxt0_next ; 
logic [15:0] hlp_hlp_port13_cgmii_tx_c ; 
logic [127:0] hlp_hlp_port13_cgmii_tx_data ; 
logic physs_hlp_repeater_hlp_port13_cgmii_txclk_ena ; 
logic [6:0] physs_hlp_repeater_hlp_port13_desk_rlevel ; 
logic physs_hlp_repeater_hlp_port13_link_status ; 
logic [1:0] physs_hlp_repeater_hlp_port13_mii_rx_tsu ; 
logic [1:0] physs_hlp_repeater_hlp_port13_mii_tx_tsu ; 
logic [7:0] physs_hlp_repeater_hlp_port13_sd_bit_slip ; 
logic [1:0] physs_hlp_repeater_hlp_port13_tsu_rx_sd ; 
logic [7:0] physs_hlp_repeater_hlp_port13_xlgmii_rx_c ; 
logic [63:0] physs_hlp_repeater_hlp_port13_xlgmii_rx_data ; 
logic physs_hlp_repeater_hlp_port13_xlgmii_rxclk_ena ; 
logic physs_hlp_repeater_hlp_port13_xlgmii_rxt0_next ; 
logic [7:0] hlp_hlp_port13_xlgmii_tx_c ; 
logic [63:0] hlp_hlp_port13_xlgmii_tx_data ; 
logic physs_hlp_repeater_hlp_port13_xlgmii_txclk_ena ; 
logic [15:0] physs_hlp_repeater_hlp_port14_cgmii_rx_c ; 
logic [127:0] physs_hlp_repeater_hlp_port14_cgmii_rx_data ; 
logic physs_hlp_repeater_hlp_port14_cgmii_rxclk_ena ; 
logic physs_hlp_repeater_hlp_port14_cgmii_rxt0_next ; 
logic [15:0] hlp_hlp_port14_cgmii_tx_c ; 
logic [127:0] hlp_hlp_port14_cgmii_tx_data ; 
logic physs_hlp_repeater_hlp_port14_cgmii_txclk_ena ; 
logic [6:0] physs_hlp_repeater_hlp_port14_desk_rlevel ; 
logic physs_hlp_repeater_hlp_port14_link_status ; 
logic [1:0] physs_hlp_repeater_hlp_port14_mii_rx_tsu ; 
logic [1:0] physs_hlp_repeater_hlp_port14_mii_tx_tsu ; 
logic [7:0] physs_hlp_repeater_hlp_port14_sd_bit_slip ; 
logic [1:0] physs_hlp_repeater_hlp_port14_tsu_rx_sd ; 
logic [7:0] physs_hlp_repeater_hlp_port14_xlgmii_rx_c ; 
logic [63:0] physs_hlp_repeater_hlp_port14_xlgmii_rx_data ; 
logic physs_hlp_repeater_hlp_port14_xlgmii_rxclk_ena ; 
logic physs_hlp_repeater_hlp_port14_xlgmii_rxt0_next ; 
logic [7:0] hlp_hlp_port14_xlgmii_tx_c ; 
logic [63:0] hlp_hlp_port14_xlgmii_tx_data ; 
logic physs_hlp_repeater_hlp_port14_xlgmii_txclk_ena ; 
logic [15:0] physs_hlp_repeater_hlp_port15_cgmii_rx_c ; 
logic [127:0] physs_hlp_repeater_hlp_port15_cgmii_rx_data ; 
logic physs_hlp_repeater_hlp_port15_cgmii_rxclk_ena ; 
logic physs_hlp_repeater_hlp_port15_cgmii_rxt0_next ; 
logic [15:0] hlp_hlp_port15_cgmii_tx_c ; 
logic [127:0] hlp_hlp_port15_cgmii_tx_data ; 
logic physs_hlp_repeater_hlp_port15_cgmii_txclk_ena ; 
logic [6:0] physs_hlp_repeater_hlp_port15_desk_rlevel ; 
logic physs_hlp_repeater_hlp_port15_link_status ; 
logic [1:0] physs_hlp_repeater_hlp_port15_mii_rx_tsu ; 
logic [1:0] physs_hlp_repeater_hlp_port15_mii_tx_tsu ; 
logic [7:0] physs_hlp_repeater_hlp_port15_sd_bit_slip ; 
logic [1:0] physs_hlp_repeater_hlp_port15_tsu_rx_sd ; 
logic [7:0] physs_hlp_repeater_hlp_port15_xlgmii_rx_c ; 
logic [63:0] physs_hlp_repeater_hlp_port15_xlgmii_rx_data ; 
logic physs_hlp_repeater_hlp_port15_xlgmii_rxclk_ena ; 
logic physs_hlp_repeater_hlp_port15_xlgmii_rxt0_next ; 
logic [7:0] hlp_hlp_port15_xlgmii_tx_c ; 
logic [63:0] hlp_hlp_port15_xlgmii_tx_data ; 
logic physs_hlp_repeater_hlp_port15_xlgmii_txclk_ena ; 
logic [15:0] physs_hlp_repeater_hlp_port16_cgmii_rx_c ; 
logic [127:0] physs_hlp_repeater_hlp_port16_cgmii_rx_data ; 
logic physs_hlp_repeater_hlp_port16_cgmii_rxclk_ena ; 
logic physs_hlp_repeater_hlp_port16_cgmii_rxt0_next ; 
logic [15:0] hlp_hlp_port16_cgmii_tx_c ; 
logic [127:0] hlp_hlp_port16_cgmii_tx_data ; 
logic physs_hlp_repeater_hlp_port16_cgmii_txclk_ena ; 
logic [6:0] physs_hlp_repeater_hlp_port16_desk_rlevel ; 
logic physs_hlp_repeater_hlp_port16_link_status ; 
logic [1:0] physs_hlp_repeater_hlp_port16_mii_rx_tsu ; 
logic [1:0] physs_hlp_repeater_hlp_port16_mii_tx_tsu ; 
logic [7:0] physs_hlp_repeater_hlp_port16_sd_bit_slip ; 
logic [1:0] physs_hlp_repeater_hlp_port16_tsu_rx_sd ; 
logic [7:0] physs_hlp_repeater_hlp_port16_xlgmii_rx_c ; 
logic [63:0] physs_hlp_repeater_hlp_port16_xlgmii_rx_data ; 
logic physs_hlp_repeater_hlp_port16_xlgmii_rxclk_ena ; 
logic physs_hlp_repeater_hlp_port16_xlgmii_rxt0_next ; 
logic [7:0] hlp_hlp_port16_xlgmii_tx_c ; 
logic [63:0] hlp_hlp_port16_xlgmii_tx_data ; 
logic physs_hlp_repeater_hlp_port16_xlgmii_txclk_ena ; 
logic [15:0] physs_hlp_repeater_hlp_port17_cgmii_rx_c ; 
logic [127:0] physs_hlp_repeater_hlp_port17_cgmii_rx_data ; 
logic physs_hlp_repeater_hlp_port17_cgmii_rxclk_ena ; 
logic physs_hlp_repeater_hlp_port17_cgmii_rxt0_next ; 
logic [15:0] hlp_hlp_port17_cgmii_tx_c ; 
logic [127:0] hlp_hlp_port17_cgmii_tx_data ; 
logic physs_hlp_repeater_hlp_port17_cgmii_txclk_ena ; 
logic [6:0] physs_hlp_repeater_hlp_port17_desk_rlevel ; 
logic physs_hlp_repeater_hlp_port17_link_status ; 
logic [1:0] physs_hlp_repeater_hlp_port17_mii_rx_tsu ; 
logic [1:0] physs_hlp_repeater_hlp_port17_mii_tx_tsu ; 
logic [7:0] physs_hlp_repeater_hlp_port17_sd_bit_slip ; 
logic [1:0] physs_hlp_repeater_hlp_port17_tsu_rx_sd ; 
logic [7:0] physs_hlp_repeater_hlp_port17_xlgmii_rx_c ; 
logic [63:0] physs_hlp_repeater_hlp_port17_xlgmii_rx_data ; 
logic physs_hlp_repeater_hlp_port17_xlgmii_rxclk_ena ; 
logic physs_hlp_repeater_hlp_port17_xlgmii_rxt0_next ; 
logic [7:0] hlp_hlp_port17_xlgmii_tx_c ; 
logic [63:0] hlp_hlp_port17_xlgmii_tx_data ; 
logic physs_hlp_repeater_hlp_port17_xlgmii_txclk_ena ; 
logic [15:0] physs_hlp_repeater_hlp_port18_cgmii_rx_c ; 
logic [127:0] physs_hlp_repeater_hlp_port18_cgmii_rx_data ; 
logic physs_hlp_repeater_hlp_port18_cgmii_rxclk_ena ; 
logic physs_hlp_repeater_hlp_port18_cgmii_rxt0_next ; 
logic [15:0] hlp_hlp_port18_cgmii_tx_c ; 
logic [127:0] hlp_hlp_port18_cgmii_tx_data ; 
logic physs_hlp_repeater_hlp_port18_cgmii_txclk_ena ; 
logic [6:0] physs_hlp_repeater_hlp_port18_desk_rlevel ; 
logic physs_hlp_repeater_hlp_port18_link_status ; 
logic [1:0] physs_hlp_repeater_hlp_port18_mii_rx_tsu ; 
logic [1:0] physs_hlp_repeater_hlp_port18_mii_tx_tsu ; 
logic [7:0] physs_hlp_repeater_hlp_port18_sd_bit_slip ; 
logic [1:0] physs_hlp_repeater_hlp_port18_tsu_rx_sd ; 
logic [7:0] physs_hlp_repeater_hlp_port18_xlgmii_rx_c ; 
logic [63:0] physs_hlp_repeater_hlp_port18_xlgmii_rx_data ; 
logic physs_hlp_repeater_hlp_port18_xlgmii_rxclk_ena ; 
logic physs_hlp_repeater_hlp_port18_xlgmii_rxt0_next ; 
logic [7:0] hlp_hlp_port18_xlgmii_tx_c ; 
logic [63:0] hlp_hlp_port18_xlgmii_tx_data ; 
logic physs_hlp_repeater_hlp_port18_xlgmii_txclk_ena ; 
logic [15:0] physs_hlp_repeater_hlp_port19_cgmii_rx_c ; 
logic [127:0] physs_hlp_repeater_hlp_port19_cgmii_rx_data ; 
logic physs_hlp_repeater_hlp_port19_cgmii_rxclk_ena ; 
logic physs_hlp_repeater_hlp_port19_cgmii_rxt0_next ; 
logic [15:0] hlp_hlp_port19_cgmii_tx_c ; 
logic [127:0] hlp_hlp_port19_cgmii_tx_data ; 
logic physs_hlp_repeater_hlp_port19_cgmii_txclk_ena ; 
logic [6:0] physs_hlp_repeater_hlp_port19_desk_rlevel ; 
logic physs_hlp_repeater_hlp_port19_link_status ; 
logic [1:0] physs_hlp_repeater_hlp_port19_mii_rx_tsu ; 
logic [1:0] physs_hlp_repeater_hlp_port19_mii_tx_tsu ; 
logic [7:0] physs_hlp_repeater_hlp_port19_sd_bit_slip ; 
logic [1:0] physs_hlp_repeater_hlp_port19_tsu_rx_sd ; 
logic [7:0] physs_hlp_repeater_hlp_port19_xlgmii_rx_c ; 
logic [63:0] physs_hlp_repeater_hlp_port19_xlgmii_rx_data ; 
logic physs_hlp_repeater_hlp_port19_xlgmii_rxclk_ena ; 
logic physs_hlp_repeater_hlp_port19_xlgmii_rxt0_next ; 
logic [7:0] hlp_hlp_port19_xlgmii_tx_c ; 
logic [63:0] hlp_hlp_port19_xlgmii_tx_data ; 
logic physs_hlp_repeater_hlp_port19_xlgmii_txclk_ena ; 
logic [15:0] physs_hlp_repeater_hlp_port1_cgmii_rx_c ; 
logic [127:0] physs_hlp_repeater_hlp_port1_cgmii_rx_data ; 
logic physs_hlp_repeater_hlp_port1_cgmii_rxclk_ena ; 
logic physs_hlp_repeater_hlp_port1_cgmii_rxt0_next ; 
logic [15:0] hlp_hlp_port1_cgmii_tx_c ; 
logic [127:0] hlp_hlp_port1_cgmii_tx_data ; 
logic physs_hlp_repeater_hlp_port1_cgmii_txclk_ena ; 
logic [7:0] physs_hlp_repeater_hlp_port1_xlgmii_rx_c ; 
logic [63:0] physs_hlp_repeater_hlp_port1_xlgmii_rx_data ; 
logic physs_hlp_repeater_hlp_port1_xlgmii_rxclk_ena ; 
logic physs_hlp_repeater_hlp_port1_xlgmii_rxt0_next ; 
logic [7:0] hlp_hlp_port1_xlgmii_tx_c ; 
logic [63:0] hlp_hlp_port1_xlgmii_tx_data ; 
logic physs_hlp_repeater_hlp_port1_xlgmii_txclk_ena ; 
logic [15:0] physs_hlp_repeater_hlp_port2_cgmii_rx_c ; 
logic [127:0] physs_hlp_repeater_hlp_port2_cgmii_rx_data ; 
logic physs_hlp_repeater_hlp_port2_cgmii_rxclk_ena ; 
logic physs_hlp_repeater_hlp_port2_cgmii_rxt0_next ; 
logic [15:0] hlp_hlp_port2_cgmii_tx_c ; 
logic [127:0] hlp_hlp_port2_cgmii_tx_data ; 
logic physs_hlp_repeater_hlp_port2_cgmii_txclk_ena ; 
logic [7:0] physs_hlp_repeater_hlp_port2_xlgmii_rx_c ; 
logic [63:0] physs_hlp_repeater_hlp_port2_xlgmii_rx_data ; 
logic physs_hlp_repeater_hlp_port2_xlgmii_rxclk_ena ; 
logic physs_hlp_repeater_hlp_port2_xlgmii_rxt0_next ; 
logic [7:0] hlp_hlp_port2_xlgmii_tx_c ; 
logic [63:0] hlp_hlp_port2_xlgmii_tx_data ; 
logic physs_hlp_repeater_hlp_port2_xlgmii_txclk_ena ; 
logic [15:0] physs_hlp_repeater_hlp_port3_cgmii_rx_c ; 
logic [127:0] physs_hlp_repeater_hlp_port3_cgmii_rx_data ; 
logic physs_hlp_repeater_hlp_port3_cgmii_rxclk_ena ; 
logic physs_hlp_repeater_hlp_port3_cgmii_rxt0_next ; 
logic [15:0] hlp_hlp_port3_cgmii_tx_c ; 
logic [127:0] hlp_hlp_port3_cgmii_tx_data ; 
logic physs_hlp_repeater_hlp_port3_cgmii_txclk_ena ; 
logic [7:0] physs_hlp_repeater_hlp_port3_xlgmii_rx_c ; 
logic [63:0] physs_hlp_repeater_hlp_port3_xlgmii_rx_data ; 
logic physs_hlp_repeater_hlp_port3_xlgmii_rxclk_ena ; 
logic physs_hlp_repeater_hlp_port3_xlgmii_rxt0_next ; 
logic [7:0] hlp_hlp_port3_xlgmii_tx_c ; 
logic [63:0] hlp_hlp_port3_xlgmii_tx_data ; 
logic physs_hlp_repeater_hlp_port3_xlgmii_txclk_ena ; 
logic [15:0] physs_hlp_repeater_hlp_port4_cgmii_rx_c ; 
logic [127:0] physs_hlp_repeater_hlp_port4_cgmii_rx_data ; 
logic physs_hlp_repeater_hlp_port4_cgmii_rxclk_ena ; 
logic physs_hlp_repeater_hlp_port4_cgmii_rxt0_next ; 
logic [15:0] hlp_hlp_port4_cgmii_tx_c ; 
logic [127:0] hlp_hlp_port4_cgmii_tx_data ; 
logic physs_hlp_repeater_hlp_port4_cgmii_txclk_ena ; 
logic [6:0] physs_hlp_repeater_hlp_port4_desk_rlevel ; 
logic physs_hlp_repeater_hlp_port4_link_status ; 
logic [1:0] physs_hlp_repeater_hlp_port4_mii_rx_tsu ; 
logic [1:0] physs_hlp_repeater_hlp_port4_mii_tx_tsu ; 
logic [7:0] physs_hlp_repeater_hlp_port4_sd_bit_slip ; 
logic [1:0] physs_hlp_repeater_hlp_port4_tsu_rx_sd ; 
logic [7:0] physs_hlp_repeater_hlp_port4_xlgmii_rx_c ; 
logic [63:0] physs_hlp_repeater_hlp_port4_xlgmii_rx_data ; 
logic physs_hlp_repeater_hlp_port4_xlgmii_rxclk_ena ; 
logic physs_hlp_repeater_hlp_port4_xlgmii_rxt0_next ; 
logic [7:0] hlp_hlp_port4_xlgmii_tx_c ; 
logic [63:0] hlp_hlp_port4_xlgmii_tx_data ; 
logic physs_hlp_repeater_hlp_port4_xlgmii_txclk_ena ; 
logic [15:0] physs_hlp_repeater_hlp_port5_cgmii_rx_c ; 
logic [127:0] physs_hlp_repeater_hlp_port5_cgmii_rx_data ; 
logic physs_hlp_repeater_hlp_port5_cgmii_rxclk_ena ; 
logic physs_hlp_repeater_hlp_port5_cgmii_rxt0_next ; 
logic [15:0] hlp_hlp_port5_cgmii_tx_c ; 
logic [127:0] hlp_hlp_port5_cgmii_tx_data ; 
logic physs_hlp_repeater_hlp_port5_cgmii_txclk_ena ; 
logic [6:0] physs_hlp_repeater_hlp_port5_desk_rlevel ; 
logic physs_hlp_repeater_hlp_port5_link_status ; 
logic [1:0] physs_hlp_repeater_hlp_port5_mii_rx_tsu ; 
logic [1:0] physs_hlp_repeater_hlp_port5_mii_tx_tsu ; 
logic [7:0] physs_hlp_repeater_hlp_port5_sd_bit_slip ; 
logic [1:0] physs_hlp_repeater_hlp_port5_tsu_rx_sd ; 
logic [7:0] physs_hlp_repeater_hlp_port5_xlgmii_rx_c ; 
logic [63:0] physs_hlp_repeater_hlp_port5_xlgmii_rx_data ; 
logic physs_hlp_repeater_hlp_port5_xlgmii_rxclk_ena ; 
logic physs_hlp_repeater_hlp_port5_xlgmii_rxt0_next ; 
logic [7:0] hlp_hlp_port5_xlgmii_tx_c ; 
logic [63:0] hlp_hlp_port5_xlgmii_tx_data ; 
logic physs_hlp_repeater_hlp_port5_xlgmii_txclk_ena ; 
logic [15:0] physs_hlp_repeater_hlp_port6_cgmii_rx_c ; 
logic [127:0] physs_hlp_repeater_hlp_port6_cgmii_rx_data ; 
logic physs_hlp_repeater_hlp_port6_cgmii_rxclk_ena ; 
logic physs_hlp_repeater_hlp_port6_cgmii_rxt0_next ; 
logic [15:0] hlp_hlp_port6_cgmii_tx_c ; 
logic [127:0] hlp_hlp_port6_cgmii_tx_data ; 
logic physs_hlp_repeater_hlp_port6_cgmii_txclk_ena ; 
logic [6:0] physs_hlp_repeater_hlp_port6_desk_rlevel ; 
logic physs_hlp_repeater_hlp_port6_link_status ; 
logic [1:0] physs_hlp_repeater_hlp_port6_mii_rx_tsu ; 
logic [1:0] physs_hlp_repeater_hlp_port6_mii_tx_tsu ; 
logic [7:0] physs_hlp_repeater_hlp_port6_sd_bit_slip ; 
logic [1:0] physs_hlp_repeater_hlp_port6_tsu_rx_sd ; 
logic [7:0] physs_hlp_repeater_hlp_port6_xlgmii_rx_c ; 
logic [63:0] physs_hlp_repeater_hlp_port6_xlgmii_rx_data ; 
logic physs_hlp_repeater_hlp_port6_xlgmii_rxclk_ena ; 
logic physs_hlp_repeater_hlp_port6_xlgmii_rxt0_next ; 
logic [7:0] hlp_hlp_port6_xlgmii_tx_c ; 
logic [63:0] hlp_hlp_port6_xlgmii_tx_data ; 
logic physs_hlp_repeater_hlp_port6_xlgmii_txclk_ena ; 
logic [15:0] physs_hlp_repeater_hlp_port7_cgmii_rx_c ; 
logic [127:0] physs_hlp_repeater_hlp_port7_cgmii_rx_data ; 
logic physs_hlp_repeater_hlp_port7_cgmii_rxclk_ena ; 
logic physs_hlp_repeater_hlp_port7_cgmii_rxt0_next ; 
logic [15:0] hlp_hlp_port7_cgmii_tx_c ; 
logic [127:0] hlp_hlp_port7_cgmii_tx_data ; 
logic physs_hlp_repeater_hlp_port7_cgmii_txclk_ena ; 
logic [6:0] physs_hlp_repeater_hlp_port7_desk_rlevel ; 
logic physs_hlp_repeater_hlp_port7_link_status ; 
logic [1:0] physs_hlp_repeater_hlp_port7_mii_rx_tsu ; 
logic [1:0] physs_hlp_repeater_hlp_port7_mii_tx_tsu ; 
logic [7:0] physs_hlp_repeater_hlp_port7_sd_bit_slip ; 
logic [1:0] physs_hlp_repeater_hlp_port7_tsu_rx_sd ; 
logic [7:0] physs_hlp_repeater_hlp_port7_xlgmii_rx_c ; 
logic [63:0] physs_hlp_repeater_hlp_port7_xlgmii_rx_data ; 
logic physs_hlp_repeater_hlp_port7_xlgmii_rxclk_ena ; 
logic physs_hlp_repeater_hlp_port7_xlgmii_rxt0_next ; 
logic [7:0] hlp_hlp_port7_xlgmii_tx_c ; 
logic [63:0] hlp_hlp_port7_xlgmii_tx_data ; 
logic physs_hlp_repeater_hlp_port7_xlgmii_txclk_ena ; 
logic [15:0] physs_hlp_repeater_hlp_port8_cgmii_rx_c ; 
logic [127:0] physs_hlp_repeater_hlp_port8_cgmii_rx_data ; 
logic physs_hlp_repeater_hlp_port8_cgmii_rxclk_ena ; 
logic physs_hlp_repeater_hlp_port8_cgmii_rxt0_next ; 
logic [15:0] hlp_hlp_port8_cgmii_tx_c ; 
logic [127:0] hlp_hlp_port8_cgmii_tx_data ; 
logic physs_hlp_repeater_hlp_port8_cgmii_txclk_ena ; 
logic [6:0] physs_hlp_repeater_hlp_port8_desk_rlevel ; 
logic physs_hlp_repeater_hlp_port8_link_status ; 
logic [1:0] physs_hlp_repeater_hlp_port8_mii_rx_tsu ; 
logic [1:0] physs_hlp_repeater_hlp_port8_mii_tx_tsu ; 
logic [7:0] physs_hlp_repeater_hlp_port8_sd_bit_slip ; 
logic [1:0] physs_hlp_repeater_hlp_port8_tsu_rx_sd ; 
logic [7:0] physs_hlp_repeater_hlp_port8_xlgmii_rx_c ; 
logic [63:0] physs_hlp_repeater_hlp_port8_xlgmii_rx_data ; 
logic physs_hlp_repeater_hlp_port8_xlgmii_rxclk_ena ; 
logic physs_hlp_repeater_hlp_port8_xlgmii_rxt0_next ; 
logic [7:0] hlp_hlp_port8_xlgmii_tx_c ; 
logic [63:0] hlp_hlp_port8_xlgmii_tx_data ; 
logic physs_hlp_repeater_hlp_port8_xlgmii_txclk_ena ; 
logic [15:0] physs_hlp_repeater_hlp_port9_cgmii_rx_c ; 
logic [127:0] physs_hlp_repeater_hlp_port9_cgmii_rx_data ; 
logic physs_hlp_repeater_hlp_port9_cgmii_rxclk_ena ; 
logic physs_hlp_repeater_hlp_port9_cgmii_rxt0_next ; 
logic [15:0] hlp_hlp_port9_cgmii_tx_c ; 
logic [127:0] hlp_hlp_port9_cgmii_tx_data ; 
logic physs_hlp_repeater_hlp_port9_cgmii_txclk_ena ; 
logic [6:0] physs_hlp_repeater_hlp_port9_desk_rlevel ; 
logic physs_hlp_repeater_hlp_port9_link_status ; 
logic [1:0] physs_hlp_repeater_hlp_port9_mii_rx_tsu ; 
logic [1:0] physs_hlp_repeater_hlp_port9_mii_tx_tsu ; 
logic [7:0] physs_hlp_repeater_hlp_port9_sd_bit_slip ; 
logic [1:0] physs_hlp_repeater_hlp_port9_tsu_rx_sd ; 
logic [7:0] physs_hlp_repeater_hlp_port9_xlgmii_rx_c ; 
logic [63:0] physs_hlp_repeater_hlp_port9_xlgmii_rx_data ; 
logic physs_hlp_repeater_hlp_port9_xlgmii_rxclk_ena ; 
logic physs_hlp_repeater_hlp_port9_xlgmii_rxt0_next ; 
logic [7:0] hlp_hlp_port9_xlgmii_tx_c ; 
logic [63:0] hlp_hlp_port9_xlgmii_tx_data ; 
logic physs_hlp_repeater_hlp_port9_xlgmii_txclk_ena ; 
logic [15:0] physs_hlp_cgmii0_rxc_0 ; 
logic [15:0] physs_hlp_cgmii0_rxc_1 ; 
logic [15:0] physs_hlp_cgmii0_rxc_2 ; 
logic [15:0] physs_hlp_cgmii0_rxc_3 ; 
logic [15:0] physs_hlp_repeater_hlp_cgmii0_rxc_nss_0 ; 
logic physs_hlp_cgmii0_rxclk_ena_0 ; 
logic physs_hlp_cgmii0_rxclk_ena_1 ; 
logic physs_hlp_cgmii0_rxclk_ena_2 ; 
logic physs_hlp_cgmii0_rxclk_ena_3 ; 
logic [127:0] physs_hlp_cgmii0_rxd_0 ; 
logic [127:0] physs_hlp_cgmii0_rxd_1 ; 
logic [127:0] physs_hlp_cgmii0_rxd_2 ; 
logic [127:0] physs_hlp_cgmii0_rxd_3 ; 
logic [127:0] physs_hlp_repeater_hlp_cgmii0_rxd_nss_0 ; 
logic [15:0] physs_hlp_repeater_hlp_cgmii0_txc_0 ; 
logic [15:0] physs_hlp_repeater_hlp_cgmii0_txc_1 ; 
logic [15:0] physs_hlp_repeater_hlp_cgmii0_txc_2 ; 
logic [15:0] physs_hlp_repeater_hlp_cgmii0_txc_3 ; 
logic [15:0] physs_hlp_cgmii0_txc_nss_0 ; 
logic physs_hlp_cgmii0_txclk_ena_0 ; 
logic physs_hlp_cgmii0_txclk_ena_1 ; 
logic physs_hlp_cgmii0_txclk_ena_2 ; 
logic physs_hlp_cgmii0_txclk_ena_3 ; 
logic [127:0] physs_hlp_repeater_hlp_cgmii0_txd_0 ; 
logic [127:0] physs_hlp_repeater_hlp_cgmii0_txd_1 ; 
logic [127:0] physs_hlp_repeater_hlp_cgmii0_txd_2 ; 
logic [127:0] physs_hlp_repeater_hlp_cgmii0_txd_3 ; 
logic [127:0] physs_hlp_cgmii0_txd_nss_0 ; 
logic [15:0] physs_hlp_cgmii1_rxc_0 ; 
logic [15:0] physs_hlp_cgmii1_rxc_1 ; 
logic [15:0] physs_hlp_cgmii1_rxc_2 ; 
logic [15:0] physs_hlp_cgmii1_rxc_3 ; 
logic [15:0] physs_hlp_repeater_hlp_cgmii1_rxc_nss_0 ; 
logic physs_hlp_cgmii1_rxclk_ena_0 ; 
logic physs_hlp_cgmii1_rxclk_ena_1 ; 
logic physs_hlp_cgmii1_rxclk_ena_2 ; 
logic physs_hlp_cgmii1_rxclk_ena_3 ; 
logic [127:0] physs_hlp_cgmii1_rxd_0 ; 
logic [127:0] physs_hlp_cgmii1_rxd_1 ; 
logic [127:0] physs_hlp_cgmii1_rxd_2 ; 
logic [127:0] physs_hlp_cgmii1_rxd_3 ; 
logic [127:0] physs_hlp_repeater_hlp_cgmii1_rxd_nss_0 ; 
logic [15:0] physs_hlp_repeater_hlp_cgmii1_txc_0 ; 
logic [15:0] physs_hlp_repeater_hlp_cgmii1_txc_1 ; 
logic [15:0] physs_hlp_repeater_hlp_cgmii1_txc_2 ; 
logic [15:0] physs_hlp_repeater_hlp_cgmii1_txc_3 ; 
logic [15:0] physs_hlp_cgmii1_txc_nss_0 ; 
logic physs_hlp_cgmii1_txclk_ena_0 ; 
logic physs_hlp_cgmii1_txclk_ena_1 ; 
logic physs_hlp_cgmii1_txclk_ena_2 ; 
logic physs_hlp_cgmii1_txclk_ena_3 ; 
logic [127:0] physs_hlp_repeater_hlp_cgmii1_txd_0 ; 
logic [127:0] physs_hlp_repeater_hlp_cgmii1_txd_1 ; 
logic [127:0] physs_hlp_repeater_hlp_cgmii1_txd_2 ; 
logic [127:0] physs_hlp_repeater_hlp_cgmii1_txd_3 ; 
logic [127:0] physs_hlp_cgmii1_txd_nss_0 ; 
logic [15:0] physs_hlp_cgmii2_rxc_0 ; 
logic [15:0] physs_hlp_cgmii2_rxc_1 ; 
logic [15:0] physs_hlp_cgmii2_rxc_2 ; 
logic [15:0] physs_hlp_cgmii2_rxc_3 ; 
logic [15:0] physs_hlp_repeater_hlp_cgmii2_rxc_nss_0 ; 
logic physs_hlp_cgmii2_rxclk_ena_0 ; 
logic physs_hlp_cgmii2_rxclk_ena_1 ; 
logic physs_hlp_cgmii2_rxclk_ena_2 ; 
logic physs_hlp_cgmii2_rxclk_ena_3 ; 
logic [127:0] physs_hlp_cgmii2_rxd_0 ; 
logic [127:0] physs_hlp_cgmii2_rxd_1 ; 
logic [127:0] physs_hlp_cgmii2_rxd_2 ; 
logic [127:0] physs_hlp_cgmii2_rxd_3 ; 
logic [127:0] physs_hlp_repeater_hlp_cgmii2_rxd_nss_0 ; 
logic [15:0] physs_hlp_repeater_hlp_cgmii2_txc_0 ; 
logic [15:0] physs_hlp_repeater_hlp_cgmii2_txc_1 ; 
logic [15:0] physs_hlp_repeater_hlp_cgmii2_txc_2 ; 
logic [15:0] physs_hlp_repeater_hlp_cgmii2_txc_3 ; 
logic [15:0] physs_hlp_cgmii2_txc_nss_0 ; 
logic physs_hlp_cgmii2_txclk_ena_0 ; 
logic physs_hlp_cgmii2_txclk_ena_1 ; 
logic physs_hlp_cgmii2_txclk_ena_2 ; 
logic physs_hlp_cgmii2_txclk_ena_3 ; 
logic [127:0] physs_hlp_repeater_hlp_cgmii2_txd_0 ; 
logic [127:0] physs_hlp_repeater_hlp_cgmii2_txd_1 ; 
logic [127:0] physs_hlp_repeater_hlp_cgmii2_txd_2 ; 
logic [127:0] physs_hlp_repeater_hlp_cgmii2_txd_3 ; 
logic [127:0] physs_hlp_cgmii2_txd_nss_0 ; 
logic [15:0] physs_hlp_cgmii3_rxc_0 ; 
logic [15:0] physs_hlp_cgmii3_rxc_1 ; 
logic [15:0] physs_hlp_cgmii3_rxc_2 ; 
logic [15:0] physs_hlp_cgmii3_rxc_3 ; 
logic [15:0] physs_hlp_repeater_hlp_cgmii3_rxc_nss_0 ; 
logic physs_hlp_cgmii3_rxclk_ena_0 ; 
logic physs_hlp_cgmii3_rxclk_ena_1 ; 
logic physs_hlp_cgmii3_rxclk_ena_2 ; 
logic physs_hlp_cgmii3_rxclk_ena_3 ; 
logic [127:0] physs_hlp_cgmii3_rxd_0 ; 
logic [127:0] physs_hlp_cgmii3_rxd_1 ; 
logic [127:0] physs_hlp_cgmii3_rxd_2 ; 
logic [127:0] physs_hlp_cgmii3_rxd_3 ; 
logic [127:0] physs_hlp_repeater_hlp_cgmii3_rxd_nss_0 ; 
logic [15:0] physs_hlp_repeater_hlp_cgmii3_txc_0 ; 
logic [15:0] physs_hlp_repeater_hlp_cgmii3_txc_1 ; 
logic [15:0] physs_hlp_repeater_hlp_cgmii3_txc_2 ; 
logic [15:0] physs_hlp_repeater_hlp_cgmii3_txc_3 ; 
logic [15:0] physs_hlp_cgmii3_txc_nss_0 ; 
logic physs_hlp_cgmii3_txclk_ena_0 ; 
logic physs_hlp_cgmii3_txclk_ena_1 ; 
logic physs_hlp_cgmii3_txclk_ena_2 ; 
logic physs_hlp_cgmii3_txclk_ena_3 ; 
logic [127:0] physs_hlp_repeater_hlp_cgmii3_txd_0 ; 
logic [127:0] physs_hlp_repeater_hlp_cgmii3_txd_1 ; 
logic [127:0] physs_hlp_repeater_hlp_cgmii3_txd_2 ; 
logic [127:0] physs_hlp_repeater_hlp_cgmii3_txd_3 ; 
logic [127:0] physs_hlp_cgmii3_txd_nss_0 ; 
logic [7:0] physs_hlp_xlgmii0_rxc_0 ; 
logic [7:0] physs_hlp_xlgmii0_rxc_1 ; 
logic [7:0] physs_hlp_xlgmii0_rxc_2 ; 
logic [7:0] physs_hlp_xlgmii0_rxc_3 ; 
logic [7:0] physs_hlp_repeater_hlp_xlgmii0_rxc_nss_0 ; 
logic physs_hlp_xlgmii0_rxclk_ena_0 ; 
logic physs_hlp_xlgmii0_rxclk_ena_1 ; 
logic physs_hlp_xlgmii0_rxclk_ena_2 ; 
logic physs_hlp_xlgmii0_rxclk_ena_3 ; 
logic [63:0] physs_hlp_xlgmii0_rxd_0 ; 
logic [63:0] physs_hlp_xlgmii0_rxd_1 ; 
logic [63:0] physs_hlp_xlgmii0_rxd_2 ; 
logic [63:0] physs_hlp_xlgmii0_rxd_3 ; 
logic [63:0] physs_hlp_repeater_hlp_xlgmii0_rxd_nss_0 ; 
logic physs_hlp_xlgmii0_rxt0_next_0 ; 
logic physs_hlp_xlgmii0_rxt0_next_1 ; 
logic physs_hlp_xlgmii0_rxt0_next_2 ; 
logic physs_hlp_xlgmii0_rxt0_next_3 ; 
logic [7:0] physs_hlp_repeater_hlp_xlgmii0_txc_0 ; 
logic [7:0] physs_hlp_repeater_hlp_xlgmii0_txc_1 ; 
logic [7:0] physs_hlp_repeater_hlp_xlgmii0_txc_2 ; 
logic [7:0] physs_hlp_repeater_hlp_xlgmii0_txc_3 ; 
logic [7:0] physs_hlp_xlgmii0_txc_nss_0 ; 
logic physs_hlp_xlgmii0_txclk_ena_0 ; 
logic physs_hlp_xlgmii0_txclk_ena_1 ; 
logic physs_hlp_xlgmii0_txclk_ena_2 ; 
logic physs_hlp_xlgmii0_txclk_ena_3 ; 
logic [63:0] physs_hlp_repeater_hlp_xlgmii0_txd_0 ; 
logic [63:0] physs_hlp_repeater_hlp_xlgmii0_txd_1 ; 
logic [63:0] physs_hlp_repeater_hlp_xlgmii0_txd_2 ; 
logic [63:0] physs_hlp_repeater_hlp_xlgmii0_txd_3 ; 
logic [63:0] physs_hlp_xlgmii0_txd_nss_0 ; 
logic [7:0] physs_hlp_xlgmii1_rxc_0 ; 
logic [7:0] physs_hlp_xlgmii1_rxc_1 ; 
logic [7:0] physs_hlp_xlgmii1_rxc_2 ; 
logic [7:0] physs_hlp_xlgmii1_rxc_3 ; 
logic [7:0] physs_hlp_repeater_hlp_xlgmii1_rxc_nss_0 ; 
logic physs_hlp_xlgmii1_rxclk_ena_0 ; 
logic physs_hlp_xlgmii1_rxclk_ena_1 ; 
logic physs_hlp_xlgmii1_rxclk_ena_2 ; 
logic physs_hlp_xlgmii1_rxclk_ena_3 ; 
logic [63:0] physs_hlp_xlgmii1_rxd_0 ; 
logic [63:0] physs_hlp_xlgmii1_rxd_1 ; 
logic [63:0] physs_hlp_xlgmii1_rxd_2 ; 
logic [63:0] physs_hlp_xlgmii1_rxd_3 ; 
logic [63:0] physs_hlp_repeater_hlp_xlgmii1_rxd_nss_0 ; 
logic physs_hlp_xlgmii1_rxt0_next_0 ; 
logic physs_hlp_xlgmii1_rxt0_next_1 ; 
logic physs_hlp_xlgmii1_rxt0_next_2 ; 
logic physs_hlp_xlgmii1_rxt0_next_3 ; 
logic [7:0] physs_hlp_repeater_hlp_xlgmii1_txc_0 ; 
logic [7:0] physs_hlp_repeater_hlp_xlgmii1_txc_1 ; 
logic [7:0] physs_hlp_repeater_hlp_xlgmii1_txc_2 ; 
logic [7:0] physs_hlp_repeater_hlp_xlgmii1_txc_3 ; 
logic [7:0] physs_hlp_xlgmii1_txc_nss_0 ; 
logic physs_hlp_xlgmii1_txclk_ena_0 ; 
logic physs_hlp_xlgmii1_txclk_ena_1 ; 
logic physs_hlp_xlgmii1_txclk_ena_2 ; 
logic physs_hlp_xlgmii1_txclk_ena_3 ; 
logic [63:0] physs_hlp_repeater_hlp_xlgmii1_txd_0 ; 
logic [63:0] physs_hlp_repeater_hlp_xlgmii1_txd_1 ; 
logic [63:0] physs_hlp_repeater_hlp_xlgmii1_txd_2 ; 
logic [63:0] physs_hlp_repeater_hlp_xlgmii1_txd_3 ; 
logic [63:0] physs_hlp_xlgmii1_txd_nss_0 ; 
logic [7:0] physs_hlp_xlgmii2_rxc_0 ; 
logic [7:0] physs_hlp_xlgmii2_rxc_1 ; 
logic [7:0] physs_hlp_xlgmii2_rxc_2 ; 
logic [7:0] physs_hlp_xlgmii2_rxc_3 ; 
logic [7:0] physs_hlp_repeater_hlp_xlgmii2_rxc_nss_0 ; 
logic physs_hlp_xlgmii2_rxclk_ena_0 ; 
logic physs_hlp_xlgmii2_rxclk_ena_1 ; 
logic physs_hlp_xlgmii2_rxclk_ena_2 ; 
logic physs_hlp_xlgmii2_rxclk_ena_3 ; 
logic [63:0] physs_hlp_xlgmii2_rxd_0 ; 
logic [63:0] physs_hlp_xlgmii2_rxd_1 ; 
logic [63:0] physs_hlp_xlgmii2_rxd_2 ; 
logic [63:0] physs_hlp_xlgmii2_rxd_3 ; 
logic [63:0] physs_hlp_repeater_hlp_xlgmii2_rxd_nss_0 ; 
logic physs_hlp_xlgmii2_rxt0_next_0 ; 
logic physs_hlp_xlgmii2_rxt0_next_1 ; 
logic physs_hlp_xlgmii2_rxt0_next_2 ; 
logic physs_hlp_xlgmii2_rxt0_next_3 ; 
logic [7:0] physs_hlp_repeater_hlp_xlgmii2_txc_0 ; 
logic [7:0] physs_hlp_repeater_hlp_xlgmii2_txc_1 ; 
logic [7:0] physs_hlp_repeater_hlp_xlgmii2_txc_2 ; 
logic [7:0] physs_hlp_repeater_hlp_xlgmii2_txc_3 ; 
logic [7:0] physs_hlp_xlgmii2_txc_nss_0 ; 
logic physs_hlp_xlgmii2_txclk_ena_0 ; 
logic physs_hlp_xlgmii2_txclk_ena_1 ; 
logic physs_hlp_xlgmii2_txclk_ena_2 ; 
logic physs_hlp_xlgmii2_txclk_ena_3 ; 
logic [63:0] physs_hlp_repeater_hlp_xlgmii2_txd_0 ; 
logic [63:0] physs_hlp_repeater_hlp_xlgmii2_txd_1 ; 
logic [63:0] physs_hlp_repeater_hlp_xlgmii2_txd_2 ; 
logic [63:0] physs_hlp_repeater_hlp_xlgmii2_txd_3 ; 
logic [63:0] physs_hlp_xlgmii2_txd_nss_0 ; 
logic [7:0] physs_hlp_xlgmii3_rxc_0 ; 
logic [7:0] physs_hlp_xlgmii3_rxc_1 ; 
logic [7:0] physs_hlp_xlgmii3_rxc_2 ; 
logic [7:0] physs_hlp_xlgmii3_rxc_3 ; 
logic [7:0] physs_hlp_repeater_hlp_xlgmii3_rxc_nss_0 ; 
logic physs_hlp_xlgmii3_rxclk_ena_0 ; 
logic physs_hlp_xlgmii3_rxclk_ena_1 ; 
logic physs_hlp_xlgmii3_rxclk_ena_2 ; 
logic physs_hlp_xlgmii3_rxclk_ena_3 ; 
logic [63:0] physs_hlp_xlgmii3_rxd_0 ; 
logic [63:0] physs_hlp_xlgmii3_rxd_1 ; 
logic [63:0] physs_hlp_xlgmii3_rxd_2 ; 
logic [63:0] physs_hlp_xlgmii3_rxd_3 ; 
logic [63:0] physs_hlp_repeater_hlp_xlgmii3_rxd_nss_0 ; 
logic physs_hlp_xlgmii3_rxt0_next_0 ; 
logic physs_hlp_xlgmii3_rxt0_next_1 ; 
logic physs_hlp_xlgmii3_rxt0_next_2 ; 
logic physs_hlp_xlgmii3_rxt0_next_3 ; 
logic [7:0] physs_hlp_repeater_hlp_xlgmii3_txc_0 ; 
logic [7:0] physs_hlp_repeater_hlp_xlgmii3_txc_1 ; 
logic [7:0] physs_hlp_repeater_hlp_xlgmii3_txc_2 ; 
logic [7:0] physs_hlp_repeater_hlp_xlgmii3_txc_3 ; 
logic [7:0] physs_hlp_xlgmii3_txc_nss_0 ; 
logic physs_hlp_xlgmii3_txclk_ena_0 ; 
logic physs_hlp_xlgmii3_txclk_ena_1 ; 
logic physs_hlp_xlgmii3_txclk_ena_2 ; 
logic physs_hlp_xlgmii3_txclk_ena_3 ; 
logic [63:0] physs_hlp_repeater_hlp_xlgmii3_txd_0 ; 
logic [63:0] physs_hlp_repeater_hlp_xlgmii3_txd_1 ; 
logic [63:0] physs_hlp_repeater_hlp_xlgmii3_txd_2 ; 
logic [63:0] physs_hlp_repeater_hlp_xlgmii3_txd_3 ; 
logic [63:0] physs_hlp_xlgmii3_txd_nss_0 ; 
logic [31:0] physs_mii_rx_tsu_mux ; 
logic [31:0] physs_mii_tx_tsu ; 
logic [111:0] physs_pcs_desk_buf_rlevel ; 
logic [15:0] physs_pcs_link_status_tsu ; 
logic [127:0] physs_pcs_sd_bit_slip ; 
logic [31:0] physs_pcs_tsu_rx_sd ; 
logic hlp_arready_s ; 
logic hlp_awready_s ; 
logic [14:0] hlp_bid_s ; 
logic [1:0] hlp_bresp_s ; 
logic hlp_bvalid_s ; 
logic [63:0] hlp_rdata_s ; 
logic [14:0] hlp_rid_s ; 
logic hlp_rlast_s ; 
logic [1:0] hlp_rresp_s ; 
logic hlp_rvalid_s ; 
logic hlp_wready_s ; 
logic nac_post_nac_sys_rst_n_out ; 
logic [31:0] nss_i_nmf_t_cnic_hlp_ARADDR ; 
logic [1:0] nss_i_nmf_t_cnic_hlp_ARBURST ; 
logic [14:0] nss_i_nmf_t_cnic_hlp_ARID ; 
logic [7:0] nss_i_nmf_t_cnic_hlp_ARLEN ; 
logic [2:0] nss_i_nmf_t_cnic_hlp_ARSIZE ; 
logic nss_i_nmf_t_cnic_hlp_ARVALID ; 
logic [31:0] nss_i_nmf_t_cnic_hlp_AWADDR ; 
logic [1:0] nss_i_nmf_t_cnic_hlp_AWBURST ; 
logic [14:0] nss_i_nmf_t_cnic_hlp_AWID ; 
logic [7:0] nss_i_nmf_t_cnic_hlp_AWLEN ; 
logic [2:0] nss_i_nmf_t_cnic_hlp_AWSIZE ; 
logic nss_i_nmf_t_cnic_hlp_AWVALID ; 
logic nss_i_nmf_t_cnic_hlp_BREADY ; 
logic nss_i_nmf_t_cnic_hlp_RREADY ; 
logic [63:0] nss_i_nmf_t_cnic_hlp_WDATA ; 
logic nss_i_nmf_t_cnic_hlp_WLAST ; 
logic [7:0] nss_i_nmf_t_cnic_hlp_WSTRB ; 
logic nss_i_nmf_t_cnic_hlp_WVALID ; 
logic [31:0] nss_physs_t_cnic_noc_physs0_emb_ARADDR ; 
logic [1:0] nss_physs_t_cnic_noc_physs0_emb_ARBURST ; 
logic [3:0] nss_physs_t_cnic_noc_physs0_emb_ARCACHE ; 
logic [3:0] nss_physs_t_cnic_noc_physs0_emb_ARID ; 
logic [7:0] nss_physs_t_cnic_noc_physs0_emb_ARLEN ; 
logic nss_physs_t_cnic_noc_physs0_emb_ARLOCK ; 
logic [2:0] nss_physs_t_cnic_noc_physs0_emb_ARPROT ; 
logic [2:0] nss_physs_t_cnic_noc_physs0_emb_ARSIZE ; 
logic nss_physs_t_cnic_noc_physs0_emb_ARVALID ; 
logic [31:0] nss_physs_t_cnic_noc_physs0_emb_AWADDR ; 
logic [1:0] nss_physs_t_cnic_noc_physs0_emb_AWBURST ; 
logic [3:0] nss_physs_t_cnic_noc_physs0_emb_AWCACHE ; 
logic [3:0] nss_physs_t_cnic_noc_physs0_emb_AWID ; 
logic [7:0] nss_physs_t_cnic_noc_physs0_emb_AWLEN ; 
logic nss_physs_t_cnic_noc_physs0_emb_AWLOCK ; 
logic [2:0] nss_physs_t_cnic_noc_physs0_emb_AWPROT ; 
logic [2:0] nss_physs_t_cnic_noc_physs0_emb_AWSIZE ; 
logic nss_physs_t_cnic_noc_physs0_emb_AWVALID ; 
logic nss_physs_t_cnic_noc_physs0_emb_BREADY ; 
logic nss_physs_t_cnic_noc_physs0_emb_RREADY ; 
logic [31:0] nss_physs_t_cnic_noc_physs0_emb_WDATA ; 
logic nss_physs_t_cnic_noc_physs0_emb_WLAST ; 
logic [3:0] nss_physs_t_cnic_noc_physs0_emb_WSTRB ; 
logic nss_physs_t_cnic_noc_physs0_emb_WVALID ; 
logic [31:0] nss_physs_t_cnic_noc_physs1_emb_ARADDR ; 
logic [1:0] nss_physs_t_cnic_noc_physs1_emb_ARBURST ; 
logic [3:0] nss_physs_t_cnic_noc_physs1_emb_ARCACHE ; 
logic [3:0] nss_physs_t_cnic_noc_physs1_emb_ARID ; 
logic [7:0] nss_physs_t_cnic_noc_physs1_emb_ARLEN ; 
logic nss_physs_t_cnic_noc_physs1_emb_ARLOCK ; 
logic [2:0] nss_physs_t_cnic_noc_physs1_emb_ARPROT ; 
logic [2:0] nss_physs_t_cnic_noc_physs1_emb_ARSIZE ; 
logic nss_physs_t_cnic_noc_physs1_emb_ARVALID ; 
logic [31:0] nss_physs_t_cnic_noc_physs1_emb_AWADDR ; 
logic [1:0] nss_physs_t_cnic_noc_physs1_emb_AWBURST ; 
logic [3:0] nss_physs_t_cnic_noc_physs1_emb_AWCACHE ; 
logic [3:0] nss_physs_t_cnic_noc_physs1_emb_AWID ; 
logic [7:0] nss_physs_t_cnic_noc_physs1_emb_AWLEN ; 
logic nss_physs_t_cnic_noc_physs1_emb_AWLOCK ; 
logic [2:0] nss_physs_t_cnic_noc_physs1_emb_AWPROT ; 
logic [2:0] nss_physs_t_cnic_noc_physs1_emb_AWSIZE ; 
logic nss_physs_t_cnic_noc_physs1_emb_AWVALID ; 
logic nss_physs_t_cnic_noc_physs1_emb_BREADY ; 
logic nss_physs_t_cnic_noc_physs1_emb_RREADY ; 
logic [31:0] nss_physs_t_cnic_noc_physs1_emb_WDATA ; 
logic nss_physs_t_cnic_noc_physs1_emb_WLAST ; 
logic [3:0] nss_physs_t_cnic_noc_physs1_emb_WSTRB ; 
logic nss_physs_t_cnic_noc_physs1_emb_WVALID ; 
logic nss_bts_hic_rst_n ; 
logic nss_hlp_reset_func_n ; 
logic [63:0] nss_icq_physs_net_xoff ; 
logic nss_mse_physs_port0_rx_rdy ; 
logic [6:0] nss_mse_physs_port0_ts_capture_idx ; 
logic nss_mse_physs_port0_ts_capture_vld ; 
logic nss_mse_physs_port0_tx_crc ; 
logic [1023:0] nss_mse_physs_port0_tx_data ; 
logic nss_mse_physs_port0_tx_eop ; 
logic nss_mse_physs_port0_tx_err ; 
logic [6:0] nss_mse_physs_port0_tx_mod ; 
logic nss_mse_physs_port0_tx_sop ; 
logic nss_mse_physs_port0_tx_wren ; 
logic nss_mse_physs_port1_rx_rdy ; 
logic [6:0] nss_mse_physs_port1_ts_capture_idx ; 
logic nss_mse_physs_port1_ts_capture_vld ; 
logic nss_mse_physs_port1_tx_crc ; 
logic [255:0] nss_mse_physs_port1_tx_data ; 
logic nss_mse_physs_port1_tx_eop ; 
logic nss_mse_physs_port1_tx_err ; 
logic [4:0] nss_mse_physs_port1_tx_mod ; 
logic nss_mse_physs_port1_tx_sop ; 
logic nss_mse_physs_port1_tx_wren ; 
logic nss_mse_physs_port2_rx_rdy ; 
logic [6:0] nss_mse_physs_port2_ts_capture_idx ; 
logic nss_mse_physs_port2_ts_capture_vld ; 
logic nss_mse_physs_port2_tx_crc ; 
logic [511:0] nss_mse_physs_port2_tx_data ; 
logic nss_mse_physs_port2_tx_eop ; 
logic nss_mse_physs_port2_tx_err ; 
logic [5:0] nss_mse_physs_port2_tx_mod ; 
logic nss_mse_physs_port2_tx_sop ; 
logic nss_mse_physs_port2_tx_wren ; 
logic nss_mse_physs_port3_rx_rdy ; 
logic [6:0] nss_mse_physs_port3_ts_capture_idx ; 
logic nss_mse_physs_port3_ts_capture_vld ; 
logic nss_mse_physs_port3_tx_crc ; 
logic [255:0] nss_mse_physs_port3_tx_data ; 
logic nss_mse_physs_port3_tx_eop ; 
logic nss_mse_physs_port3_tx_err ; 
logic [4:0] nss_mse_physs_port3_tx_mod ; 
logic nss_mse_physs_port3_tx_sop ; 
logic nss_mse_physs_port3_tx_wren ; 
logic nss_mse_physs_port4_rx_rdy ; 
logic [6:0] nss_mse_physs_port4_ts_capture_idx ; 
logic nss_mse_physs_port4_ts_capture_vld ; 
logic nss_mse_physs_port4_tx_crc ; 
logic [1023:0] nss_mse_physs_port4_tx_data ; 
logic nss_mse_physs_port4_tx_eop ; 
logic nss_mse_physs_port4_tx_err ; 
logic [6:0] nss_mse_physs_port4_tx_mod ; 
logic nss_mse_physs_port4_tx_sop ; 
logic nss_mse_physs_port4_tx_wren ; 
logic nss_mse_physs_port5_rx_rdy ; 
logic [6:0] nss_mse_physs_port5_ts_capture_idx ; 
logic nss_mse_physs_port5_ts_capture_vld ; 
logic nss_mse_physs_port5_tx_crc ; 
logic [255:0] nss_mse_physs_port5_tx_data ; 
logic nss_mse_physs_port5_tx_eop ; 
logic nss_mse_physs_port5_tx_err ; 
logic [4:0] nss_mse_physs_port5_tx_mod ; 
logic nss_mse_physs_port5_tx_sop ; 
logic nss_mse_physs_port5_tx_wren ; 
logic nss_mse_physs_port6_rx_rdy ; 
logic [6:0] nss_mse_physs_port6_ts_capture_idx ; 
logic nss_mse_physs_port6_ts_capture_vld ; 
logic nss_mse_physs_port6_tx_crc ; 
logic [511:0] nss_mse_physs_port6_tx_data ; 
logic nss_mse_physs_port6_tx_eop ; 
logic nss_mse_physs_port6_tx_err ; 
logic [5:0] nss_mse_physs_port6_tx_mod ; 
logic nss_mse_physs_port6_tx_sop ; 
logic nss_mse_physs_port6_tx_wren ; 
logic nss_mse_physs_port7_rx_rdy ; 
logic [6:0] nss_mse_physs_port7_ts_capture_idx ; 
logic nss_mse_physs_port7_ts_capture_vld ; 
logic nss_mse_physs_port7_tx_crc ; 
logic [255:0] nss_mse_physs_port7_tx_data ; 
logic nss_mse_physs_port7_tx_eop ; 
logic nss_mse_physs_port7_tx_err ; 
logic [4:0] nss_mse_physs_port7_tx_mod ; 
logic nss_mse_physs_port7_tx_sop ; 
logic nss_mse_physs_port7_tx_wren ; 
logic nss_phy_pcie0_pcs_rst_n ; 
logic nss_phy_pcie0_pma_rst_n ; 
logic nss_phy_pcie2_pcs_rst_n ; 
logic nss_phy_pcie2_pma_rst_n ; 
logic nss_phy_pcie4_pcs_rst_n ; 
logic nss_phy_pcie4_pma_rst_n ; 
logic nss_phy_pcie6_pcs_rst_n ; 
logic nss_phy_pcie6_pma_rst_n ; 
logic nss_physs0_reset_func_n ; 
logic nss_physs1_reset_func_n ; 
logic physs_physs_0_ARREADY ; 
logic physs_physs_0_AWREADY ; 
logic [3:0] physs_physs_0_BID ; 
logic [1:0] physs_physs_0_BRESP ; 
logic physs_physs_0_BVALID ; 
logic [31:0] physs_physs_0_RDATA ; 
logic [3:0] physs_physs_0_RID ; 
logic physs_physs_0_RLAST ; 
logic [1:0] physs_physs_0_RRESP ; 
logic physs_physs_0_RVALID ; 
logic physs_physs_0_WREADY ; 
logic physs_physs_0_ts_int ; 
logic physs_physs_1_ARREADY ; 
logic physs_physs_1_AWREADY ; 
logic [3:0] physs_physs_1_BID ; 
logic [1:0] physs_physs_1_BRESP ; 
logic physs_physs_1_BVALID ; 
logic [31:0] physs_physs_1_RDATA ; 
logic [3:0] physs_physs_1_RID ; 
logic physs_physs_1_RLAST ; 
logic [1:0] physs_physs_1_RRESP ; 
logic physs_physs_1_RVALID ; 
logic physs_physs_1_WREADY ; 
logic physs_physs_hif_port_0_magic_pkt_ind_tgl ; 
logic physs_physs_hif_port_1_magic_pkt_ind_tgl ; 
logic physs_physs_hif_port_2_magic_pkt_ind_tgl ; 
logic physs_physs_hif_port_3_magic_pkt_ind_tgl ; 
logic physs_physs_hif_port_4_magic_pkt_ind_tgl ; 
logic physs_physs_hif_port_5_magic_pkt_ind_tgl ; 
logic physs_physs_hif_port_6_magic_pkt_ind_tgl ; 
logic physs_physs_hif_port_7_magic_pkt_ind_tgl ; 
logic [63:0] physs_physs_icq_net_xoff ; 
logic physs_physs_icq_port_0_link_stat ; 
logic physs_physs_icq_port_0_pfc_mode ; 
logic physs_physs_icq_port_1_link_stat ; 
logic physs_physs_icq_port_1_pfc_mode ; 
logic physs_physs_icq_port_2_link_stat ; 
logic physs_physs_icq_port_2_pfc_mode ; 
logic physs_physs_icq_port_3_link_stat ; 
logic physs_physs_icq_port_3_pfc_mode ; 
logic physs_physs_icq_port_4_link_stat ; 
logic physs_physs_icq_port_4_pfc_mode ; 
logic physs_physs_icq_port_5_link_stat ; 
logic physs_physs_icq_port_5_pfc_mode ; 
logic physs_physs_icq_port_6_link_stat ; 
logic physs_physs_icq_port_6_pfc_mode ; 
logic physs_physs_icq_port_7_link_stat ; 
logic physs_physs_icq_port_7_pfc_mode ; 
logic [3:0] physs_physs_mse_port_0_link_speed ; 
logic [1023:0] physs_physs_mse_port_0_rx_data ; 
logic physs_physs_mse_port_0_rx_dval ; 
logic physs_physs_mse_port_0_rx_ecc_err ; 
logic physs_physs_mse_port_0_rx_eop ; 
logic physs_physs_mse_port_0_rx_err ; 
logic [6:0] physs_physs_mse_port_0_rx_mod ; 
logic physs_physs_mse_port_0_rx_sop ; 
logic [38:0] physs_physs_mse_port_0_rx_ts ; 
logic physs_physs_mse_port_0_tx_rdy ; 
logic [3:0] physs_physs_mse_port_1_link_speed ; 
logic [255:0] physs_physs_mse_port_1_rx_data ; 
logic physs_physs_mse_port_1_rx_dval ; 
logic physs_physs_mse_port_1_rx_ecc_err ; 
logic physs_physs_mse_port_1_rx_eop ; 
logic physs_physs_mse_port_1_rx_err ; 
logic [4:0] physs_physs_mse_port_1_rx_mod ; 
logic physs_physs_mse_port_1_rx_sop ; 
logic [38:0] physs_physs_mse_port_1_rx_ts ; 
logic physs_physs_mse_port_1_tx_rdy ; 
logic [3:0] physs_physs_mse_port_2_link_speed ; 
logic [511:0] physs_physs_mse_port_2_rx_data ; 
logic physs_physs_mse_port_2_rx_dval ; 
logic physs_physs_mse_port_2_rx_ecc_err ; 
logic physs_physs_mse_port_2_rx_eop ; 
logic physs_physs_mse_port_2_rx_err ; 
logic [5:0] physs_physs_mse_port_2_rx_mod ; 
logic physs_physs_mse_port_2_rx_sop ; 
logic [38:0] physs_physs_mse_port_2_rx_ts ; 
logic physs_physs_mse_port_2_tx_rdy ; 
logic [3:0] physs_physs_mse_port_3_link_speed ; 
logic [255:0] physs_physs_mse_port_3_rx_data ; 
logic physs_physs_mse_port_3_rx_dval ; 
logic physs_physs_mse_port_3_rx_ecc_err ; 
logic physs_physs_mse_port_3_rx_eop ; 
logic physs_physs_mse_port_3_rx_err ; 
logic [4:0] physs_physs_mse_port_3_rx_mod ; 
logic physs_physs_mse_port_3_rx_sop ; 
logic [38:0] physs_physs_mse_port_3_rx_ts ; 
logic physs_physs_mse_port_3_tx_rdy ; 
logic [3:0] physs_physs_mse_port_4_link_speed ; 
logic [1023:0] physs_physs_mse_port_4_rx_data ; 
logic physs_physs_mse_port_4_rx_dval ; 
logic physs_physs_mse_port_4_rx_ecc_err ; 
logic physs_physs_mse_port_4_rx_eop ; 
logic physs_physs_mse_port_4_rx_err ; 
logic [6:0] physs_physs_mse_port_4_rx_mod ; 
logic physs_physs_mse_port_4_rx_sop ; 
logic [38:0] physs_physs_mse_port_4_rx_ts ; 
logic physs_physs_mse_port_4_tx_rdy ; 
logic [3:0] physs_physs_mse_port_5_link_speed ; 
logic [255:0] physs_physs_mse_port_5_rx_data ; 
logic physs_physs_mse_port_5_rx_dval ; 
logic physs_physs_mse_port_5_rx_ecc_err ; 
logic physs_physs_mse_port_5_rx_eop ; 
logic physs_physs_mse_port_5_rx_err ; 
logic [4:0] physs_physs_mse_port_5_rx_mod ; 
logic physs_physs_mse_port_5_rx_sop ; 
logic [38:0] physs_physs_mse_port_5_rx_ts ; 
logic physs_physs_mse_port_5_tx_rdy ; 
logic [3:0] physs_physs_mse_port_6_link_speed ; 
logic [511:0] physs_physs_mse_port_6_rx_data ; 
logic physs_physs_mse_port_6_rx_dval ; 
logic physs_physs_mse_port_6_rx_ecc_err ; 
logic physs_physs_mse_port_6_rx_eop ; 
logic physs_physs_mse_port_6_rx_err ; 
logic [5:0] physs_physs_mse_port_6_rx_mod ; 
logic physs_physs_mse_port_6_rx_sop ; 
logic [38:0] physs_physs_mse_port_6_rx_ts ; 
logic physs_physs_mse_port_6_tx_rdy ; 
logic [3:0] physs_physs_mse_port_7_link_speed ; 
logic [255:0] physs_physs_mse_port_7_rx_data ; 
logic physs_physs_mse_port_7_rx_dval ; 
logic physs_physs_mse_port_7_rx_ecc_err ; 
logic physs_physs_mse_port_7_rx_eop ; 
logic physs_physs_mse_port_7_rx_err ; 
logic [4:0] physs_physs_mse_port_7_rx_mod ; 
logic physs_physs_mse_port_7_rx_sop ; 
logic [38:0] physs_physs_mse_port_7_rx_ts ; 
logic physs_physs_mse_port_7_tx_rdy ; 
logic [127:0] hlp_oob_pfc_xoff ; 
logic [15:0] hlp_oob_lfc_xoff ; 
logic nss_gbe_o_1588_one_pps_out ; 
logic time_sync_repeater_out ; 
logic [1:0] nss_gbe_o_1588_hlp3_sync_val ; 
logic [1:0] hlp_fabric0_out ; 
logic [1:0] hlp_fabric1_out ; 
logic [1:0] hlp_fabric2_out ; 
logic [1:0] hlp_fabric3_out ; 
logic [1:0] nss_gbe_o_1588_physs_sync_val ; 
logic [1:0] physs_fabric0_out ; 
logic [1:0] physs_fabric1_out ; 
logic [1:0] physs_fabric2_out ; 
logic [1:0] physs_fabric3_out ; 
logic [31:0] nss_nsc_post_done ; 
logic [31:0] nss_nsc_post_pass ; 
logic [31:0] nac_post_post_trig_nsc ; 
logic nac_post_post_mux_ctrl_nsc ; 
logic nac_post_post_clkungate_nsc ; 
logic physs_tx_stop_0_out ; 
logic physs_tx_stop_1_out ; 
logic physs_tx_stop_2_out ; 
logic physs_tx_stop_3_out ; 
logic [11:0] nac_post_post_trig_hlp ; 
logic [11:0] hlp_hlp_post_done ; 
logic [11:0] hlp_hlp_post_pass ; 
logic hlp_hlp_port0_rx_throttle ; 
logic hlp_hlp_port1_rx_throttle ; 
logic hlp_hlp_port2_rx_throttle ; 
logic hlp_hlp_port3_rx_throttle ; 
logic nac_post_post_mux_ctrl_hlp ; 
logic nac_post_post_clkungate_hlp ; 
logic nac_glue_logic_inst_resolved_hlp_disabled_0 ; 
logic physs_physs_reset_prep_ack ; 
logic nss_physs0_rst_prep ; 
logic svid_svidclk_rxdata_buf_fabric0_o ; 
logic svid_svidalert_rxdata_buf_fabric0_o ; 
tri dts_nac2_i_anode_1 ; 
wire nac_tsrdhoriz_v_anode ; 
wire nac_tsrdhoriz_v_cathode ; 
tri dts_nac1_i_anode ; 
wire hlp_o_hlp_dts_diode0_anode ; 
tri dts_nac1_i_cathode ; 
wire hlp_o_hlp_dts_diode0_cathode ; 
tri dts_nac1_i_anode_0 ; 
wire hlp_o_hlp_dts_diode1_anode ; 
wire hlp_o_hlp_dts_diode1_cathode ; 
tri dts_nac1_i_anode_1 ; 
wire hlp_o_hlp_dts_diode2_anode ; 
wire hlp_o_hlp_dts_diode2_cathode ; 
tri dts_nac0_i_anode ; 
wire physs_ioa_pma_remote_diode_v_anode ; 
tri dts_nac0_i_cathode ; 
wire physs_ioa_pma_remote_diode_v_cathode ; 
tri dts_nac0_i_anode_0 ; 
wire physs_ioa_pma_remote_diode_v_anode_0 ; 
wire physs_ioa_pma_remote_diode_v_cathode_0 ; 
tri dts_nac0_i_anode_1 ; 
wire physs_ioa_pma_remote_diode_v_anode_1 ; 
wire physs_ioa_pma_remote_diode_v_cathode_1 ; 
tri dts_nac0_i_anode_2 ; 
wire physs_ioa_pma_remote_diode_v_anode_2 ; 
wire physs_ioa_pma_remote_diode_v_cathode_2 ; 
tri dts_nac0_i_anode_3 ; 
wire physs_ioa_pma_remote_diode_v_anode_3 ; 
wire physs_ioa_pma_remote_diode_v_cathode_3 ; 
tri dts_nac0_i_anode_4 ; 
wire physs_ioa_pma_remote_diode_v_anode_4 ; 
wire physs_ioa_pma_remote_diode_v_cathode_4 ; 
tri dts_nac0_i_anode_5 ; 
wire physs_ioa_pma_remote_diode_v_anode_5 ; 
wire physs_ioa_pma_remote_diode_v_cathode_5 ; 
tri dts_nac0_i_anode_6 ; 
wire physs_ioa_pma_remote_diode_v_anode_6 ; 
wire physs_ioa_pma_remote_diode_v_cathode_6 ; 
wire hif_pcie_gen6_phy_18a_pciephyss_nac_tsrdhoriz0_v_anode ; 
wire hif_pcie_gen6_phy_18a_pciephyss_nac_tsrdhoriz0_v_cathode ; 
tri dts_nac2_i_anode_2 ; 
wire hif_pcie_gen6_phy_18a_pciephyss_nac_tsrdhoriz1_v_anode ; 
wire hif_pcie_gen6_phy_18a_pciephyss_nac_tsrdhoriz1_v_cathode ; 
tri dts_nac2_i_anode_3 ; 
logic svid_rpt1_svid_alert_rxen_fabric1_q ; 
logic svid_rpt1_svidclk_rxen_fabric1_q ; 
logic svid_rpt1_svidclk_txen_fabric1_q ; 
logic svid_rpt1_svid_rxdata_fabric0_q ; 
logic svid_rpt1_sviddata_rxen_fabric1_q ; 
logic svid_rpt1_sviddata_txen_fabric1_q ; 
logic hif_pcie_gen6_phy_18a_reset_error ; 
logic hif_pcie_gen6_phy_18a_reset_cmd_ack ; 
logic hif_pcie_gen6_phy_18a_pciephyss_nac_rstw_o_cmp ; 
logic [15:0] hif_pcie_gen6_phy_18a_pciephyss_nac_rstw_o_rdata ; 
logic hif_pcie_gen6_phy_18a_pciephyss_nac_rstw_o_error ; 
logic nac_soft_strap_rstw_o_valid ; 
logic nac_soft_strap_rstw_o_write ; 
logic [15:0] nac_soft_strap_rstw_o_wdata ; 
logic [15:0] nac_soft_strap_rstw_o_addr ; 
logic [5:0] eth_fusebox_fuse_bus_7 ; 
logic [5:0] eth_fusebox_fuse_bus_8 ; 
logic [7:0] eth_fusebox_fuse_bus_9 ; 
logic [7:0] eth_fusebox_fuse_bus_10 ; 
logic [7:0] eth_fusebox_fuse_bus_11 ; 
logic nac_glue_logic_inst_final_eth_bbl_fuse_disable_0 ; 
logic nac_glue_logic_inst_final_eth_bbl_fuse_disable_1 ; 
logic nac_glue_logic_inst_final_eth_bbl_fuse_disable_2 ; 
logic nac_glue_logic_inst_final_eth_bbl_fuse_disable_3 ; 
logic [3:0] nac_glue_logic_inst_final_eth_bbl_fuse_disable_4 ; 
logic nac_glue_logic_inst_final_eth_bbl_fuse_disable_5 ; 
logic nac_glue_logic_inst_final_eth_bbl_fuse_disable_6 ; 
logic nac_glue_logic_inst_final_eth_bbl_fuse_disable_7 ; 
logic [3:0] nac_glue_logic_inst_final_eth_bbl_fuse_disable_8 ; 
logic nac_glue_logic_inst_final_eth_bbl_fuse_disable_9 ; 
logic [3:0] nac_glue_logic_inst_final_eth_bbl_fuse_disable_10 ; 
logic nac_glue_logic_inst_final_eth_bbl_fuse_disable_11 ; 
logic [3:0] nac_glue_logic_inst_final_eth_bbl_fuse_disable_12 ; 
logic nac_glue_logic_inst_final_eth_bbl_fuse_disable_13 ; 
logic nac_glue_logic_inst_final_eth_bbl_fuse_disable_14 ; 
logic nac_glue_logic_inst_final_eth_bbl_fuse_disable_15 ; 
logic nac_glue_logic_inst_final_eth_bbl_fuse_disable_16 ; 
logic [15:0] otp_fusebox_fuse_bus_270 ; 
logic otp_fusebox_fuse_bus_271 ; 
logic otp_fusebox_fuse_bus_272 ; 
logic otp_fusebox_fuse_bus_273 ; 
logic otp_fusebox_fuse_bus_274 ; 
logic [2:0] otp_fusebox_fuse_bus_275 ; 
logic otp_fusebox_fuse_bus_276 ; 
logic otp_fusebox_fuse_bus_277 ; 
logic otp_fusebox_fuse_bus_278 ; 
logic [4:0] otp_fusebox_fuse_bus_279 ; 
logic [7:0] otp_fusebox_fuse_bus_280 ; 
logic otp_fusebox_fuse_bus_281 ; 
logic [6:0] otp_fusebox_fuse_bus_282 ; 
logic otp_fusebox_fuse_bus_283 ; 
logic otp_fusebox_fuse_bus_284 ; 
logic otp_fusebox_fuse_bus_285 ; 
logic otp_fusebox_fuse_bus_286 ; 
logic otp_fusebox_fuse_bus_287 ; 
logic otp_fusebox_fuse_bus_288 ; 
logic otp_fusebox_fuse_bus_289 ; 
logic otp_fusebox_fuse_bus_290 ; 
logic [3:0] otp_fusebox_fuse_bus_291 ; 
logic [3:0] otp_fusebox_fuse_bus_292 ; 
logic otp_fusebox_fuse_bus_293 ; 
logic otp_fusebox_fuse_bus_294 ; 
logic [6:0] otp_fusebox_fuse_bus_295 ; 
logic otp_fusebox_fuse_bus_296 ; 
logic [6:0] otp_fusebox_fuse_bus_297 ; 
logic [7:0] otp_fusebox_fuse_bus_298 ; 
logic [7:0] otp_fusebox_fuse_bus_299 ; 
logic [63:0] otp_fusebox_fuse_bus_300 ; 
logic [1:0] otp_fusebox_fuse_bus_301 ; 
logic [1:0] otp_fusebox_fuse_bus_302 ; 
logic [1:0] otp_fusebox_fuse_bus_303 ; 
logic [1:0] otp_fusebox_fuse_bus_304 ; 
logic [3:0] otp_fusebox_fuse_bus_305 ; 
logic [3:0] otp_fusebox_fuse_bus_306 ; 
logic [7:0] otp_fusebox_fuse_bus_307 ; 
logic [2:0] otp_fusebox_fuse_bus_308 ; 
logic [4:0] otp_fusebox_fuse_bus_309 ; 
logic [7:0] otp_fusebox_fuse_bus_310 ; 
logic [7:0] otp_fusebox_fuse_bus_311 ; 
logic otp_fusebox_fuse_bus_312 ; 
logic otp_fusebox_fuse_bus_313 ; 
logic [2:0] otp_fusebox_fuse_bus_314 ; 
logic [3:0] otp_fusebox_fuse_bus_315 ; 
logic [6:0] otp_fusebox_fuse_bus_316 ; 
logic [7:0] otp_fusebox_fuse_bus_317 ; 
logic [15:0] otp_fusebox_fuse_bus_318 ; 
logic otp_fusebox_fuse_bus_319 ; 
logic [15:0] otp_fusebox_fuse_bus_320 ; 
logic otp_fusebox_fuse_bus_321 ; 
logic [4:0] otp_fusebox_fuse_bus_322 ; 
logic [15:0] otp_fusebox_fuse_bus_323 ; 
logic [6:0] otp_fusebox_fuse_bus_324 ; 
logic [6:0] otp_fusebox_fuse_bus_325 ; 
logic otp_fusebox_fuse_bus_326 ; 
logic [15:0] otp_fusebox_fuse_bus_327 ; 
logic [7:0] otp_fusebox_fuse_bus_328 ; 
logic nss_physs1_rst_prep ; 
logic nss_hlp_rst_prep ; 
logic nac_glue_logic_inst_imcr_qacceptn_nsc ; 
logic sb_repeater_eth_pll_mnpcup_agt ; 
logic sb_repeater_eth_pll_mpccup_agt ; 
logic sb_repeater_eth_pll_tnpput_agt ; 
logic sb_repeater_eth_pll_tpcput_agt ; 
logic sb_repeater_eth_pll_teom_agt ; 
logic [7:0] sb_repeater_eth_pll_tpayload_agt ; 
logic [2:0] sb_repeater_eth_pll_side_ism_fabric_agt ; 
logic rsrc_pll_top_eth_physs_mnpput ; 
logic rsrc_pll_top_eth_physs_mpcput ; 
logic rsrc_pll_top_eth_physs_meom ; 
logic [7:0] rsrc_pll_top_eth_physs_mpayload ; 
logic rsrc_pll_top_eth_physs_tnpcup ; 
logic rsrc_pll_top_eth_physs_tpccup ; 
logic [2:0] rsrc_pll_top_eth_physs_side_ism_agent ; 
logic rsrc_pll_top_eth_physs_side_pok ; 
logic apb2iosfsb_fabric1_rep1_mnpcup_agt ; 
logic apb2iosfsb_fabric1_rep1_mpccup_agt ; 
logic apb2iosfsb_fabric1_rep1_tnpput_agt ; 
logic apb2iosfsb_fabric1_rep1_tpcput_agt ; 
logic apb2iosfsb_fabric1_rep1_teom_agt ; 
logic [7:0] apb2iosfsb_fabric1_rep1_tpayload_agt ; 
logic apb2iosfsb_fabric1_rep1_tparity_agt ; 
logic [2:0] apb2iosfsb_fabric1_rep1_side_ism_fabric_agt ; 
logic apb2iosfsb_fabric0_rep2_mnpput_fsa ; 
logic apb2iosfsb_fabric0_rep2_mpcput_fsa ; 
logic apb2iosfsb_fabric0_rep2_meom_fsa ; 
logic [7:0] apb2iosfsb_fabric0_rep2_mpayload_fsa ; 
logic apb2iosfsb_fabric0_rep2_mparity_fsa ; 
logic apb2iosfsb_fabric0_rep2_tnpcup_fsa ; 
logic apb2iosfsb_fabric0_rep2_tpccup_fsa ; 
logic [2:0] apb2iosfsb_fabric0_rep2_side_ism_agent_fsa ; 
logic apb2iosfsb_fabric0_rep2_pok_fsa ; 
logic gpio_ne_1p8_fabric1_rep1_mnpcup_agt ; 
logic gpio_ne_1p8_fabric1_rep1_mpccup_agt ; 
logic gpio_ne_1p8_fabric1_rep1_tnpput_agt ; 
logic gpio_ne_1p8_fabric1_rep1_tpcput_agt ; 
logic gpio_ne_1p8_fabric1_rep1_teom_agt ; 
logic [7:0] gpio_ne_1p8_fabric1_rep1_tpayload_agt ; 
logic gpio_ne_1p8_fabric1_rep1_tparity_agt ; 
logic [2:0] gpio_ne_1p8_fabric1_rep1_side_ism_fabric_agt ; 
logic gpio_ne_1p8_fabric0_rep2_mnpput_fsa ; 
logic gpio_ne_1p8_fabric0_rep2_mpcput_fsa ; 
logic gpio_ne_1p8_fabric0_rep2_meom_fsa ; 
logic [7:0] gpio_ne_1p8_fabric0_rep2_mpayload_fsa ; 
logic gpio_ne_1p8_fabric0_rep2_mparity_fsa ; 
logic gpio_ne_1p8_fabric0_rep2_tnpcup_fsa ; 
logic gpio_ne_1p8_fabric0_rep2_tpccup_fsa ; 
logic [2:0] gpio_ne_1p8_fabric0_rep2_side_ism_agent_fsa ; 
logic gpio_ne_1p8_fabric0_rep2_pok_fsa ; 
wire sb_repeater_adop_infraclk_div4_pdop_par_fabric_s5_clk_clkout ; 
logic rstw_pll_top_eth_physs_rstw_ip_side_rst_b_0 ; 
logic nss_hif_sfib_cpl_rtrgt1_tlp_halt ; 
logic [1023:0] nss_hif_sfib_cpl_xali_tlp_data ; 
logic nss_hif_sfib_cpl_xali_tlp_dv ; 
logic [31:0] nss_hif_sfib_cpl_xali_tlp_dwen ; 
logic nss_hif_sfib_cpl_xali_tlp_eot ; 
logic nss_hif_sfib_cpl_xali_tlp_fm_format ; 
logic nss_hif_sfib_cpl_xali_tlp_grant ; 
logic [255:0] nss_hif_sfib_cpl_xali_tlp_hdr ; 
logic nss_hif_sfib_cpl_xali_tlp_hv ; 
logic [7:0] nss_hif_sfib_cpl_xali_tlp_hwen ; 
logic nss_hif_sfib_cpl_xali_tlp_nullified ; 
logic nss_hif_sfib_cpl_xali_tlp_poisoned ; 
logic [4:0] nss_hif_sfib_cpl_xali_tlp_soh ; 
logic nss_hif_sfib_np_rtrgt1_tlp_halt ; 
logic [1023:0] nss_hif_sfib_np_xali_tlp_data ; 
logic nss_hif_sfib_np_xali_tlp_dv ; 
logic [31:0] nss_hif_sfib_np_xali_tlp_dwen ; 
logic nss_hif_sfib_np_xali_tlp_eot ; 
logic nss_hif_sfib_np_xali_tlp_fm_format ; 
logic nss_hif_sfib_np_xali_tlp_grant ; 
logic [255:0] nss_hif_sfib_np_xali_tlp_hdr ; 
logic nss_hif_sfib_np_xali_tlp_hv ; 
logic [7:0] nss_hif_sfib_np_xali_tlp_hwen ; 
logic nss_hif_sfib_np_xali_tlp_nullified ; 
logic nss_hif_sfib_np_xali_tlp_poisoned ; 
logic [4:0] nss_hif_sfib_np_xali_tlp_soh ; 
logic nss_hif_sfib_p_rtrgt1_tlp_halt ; 
logic [1023:0] nss_hif_sfib_p_xali_tlp_data ; 
logic nss_hif_sfib_p_xali_tlp_dv ; 
logic [31:0] nss_hif_sfib_p_xali_tlp_dwen ; 
logic nss_hif_sfib_p_xali_tlp_eot ; 
logic nss_hif_sfib_p_xali_tlp_fm_format ; 
logic nss_hif_sfib_p_xali_tlp_grant ; 
logic [255:0] nss_hif_sfib_p_xali_tlp_hdr ; 
logic nss_hif_sfib_p_xali_tlp_hv ; 
logic [7:0] nss_hif_sfib_p_xali_tlp_hwen ; 
logic nss_hif_sfib_p_xali_tlp_nullified ; 
logic nss_hif_sfib_p_xali_tlp_poisoned ; 
logic [4:0] nss_hif_sfib_p_xali_tlp_soh ; 
logic par_sn2sfi_cpl_rtrgt1_tlp_abort ; 
logic [1023:0] par_sn2sfi_cpl_rtrgt1_tlp_data ; 
logic par_sn2sfi_cpl_rtrgt1_tlp_dv ; 
logic [31:0] par_sn2sfi_cpl_rtrgt1_tlp_dwen ; 
logic par_sn2sfi_cpl_rtrgt1_tlp_eot ; 
logic par_sn2sfi_cpl_rtrgt1_tlp_fm_format ; 
logic [255:0] par_sn2sfi_cpl_rtrgt1_tlp_hdr ; 
logic par_sn2sfi_cpl_rtrgt1_tlp_hv ; 
logic [7:0] par_sn2sfi_cpl_rtrgt1_tlp_hwen ; 
logic par_sn2sfi_cpl_rtrgt1_tlp_nullified ; 
logic par_sn2sfi_cpl_rtrgt1_tlp_poisoned ; 
logic [15:0] par_sn2sfi_cpl_rtrgt1_tlp_porder ; 
logic [4:0] par_sn2sfi_cpl_rtrgt1_tlp_soh ; 
logic par_sn2sfi_cpl_xali_tlp_halt ; 
logic par_sn2sfi_np_rtrgt1_tlp_abort ; 
logic [1023:0] par_sn2sfi_np_rtrgt1_tlp_data ; 
logic par_sn2sfi_np_rtrgt1_tlp_dv ; 
logic [31:0] par_sn2sfi_np_rtrgt1_tlp_dwen ; 
logic par_sn2sfi_np_rtrgt1_tlp_eot ; 
logic par_sn2sfi_np_rtrgt1_tlp_fm_format ; 
logic [255:0] par_sn2sfi_np_rtrgt1_tlp_hdr ; 
logic par_sn2sfi_np_rtrgt1_tlp_hv ; 
logic [7:0] par_sn2sfi_np_rtrgt1_tlp_hwen ; 
logic par_sn2sfi_np_rtrgt1_tlp_nullified ; 
logic par_sn2sfi_np_rtrgt1_tlp_poisoned ; 
logic [15:0] par_sn2sfi_np_rtrgt1_tlp_porder ; 
logic [4:0] par_sn2sfi_np_rtrgt1_tlp_soh ; 
logic par_sn2sfi_np_xali_tlp_halt ; 
logic par_sn2sfi_p_rtrgt1_tlp_abort ; 
logic [1023:0] par_sn2sfi_p_rtrgt1_tlp_data ; 
logic par_sn2sfi_p_rtrgt1_tlp_dv ; 
logic [31:0] par_sn2sfi_p_rtrgt1_tlp_dwen ; 
logic par_sn2sfi_p_rtrgt1_tlp_eot ; 
logic par_sn2sfi_p_rtrgt1_tlp_fm_format ; 
logic [255:0] par_sn2sfi_p_rtrgt1_tlp_hdr ; 
logic par_sn2sfi_p_rtrgt1_tlp_hv ; 
logic [7:0] par_sn2sfi_p_rtrgt1_tlp_hwen ; 
logic par_sn2sfi_p_rtrgt1_tlp_nullified ; 
logic par_sn2sfi_p_rtrgt1_tlp_poisoned ; 
logic [15:0] par_sn2sfi_p_rtrgt1_tlp_porder ; 
logic [4:0] par_sn2sfi_p_rtrgt1_tlp_soh ; 
logic par_sn2sfi_p_xali_tlp_halt ; 
logic par_sn2sfi_p_rtrgt1_tlp_p0_pending ; 
logic [3:0] hif_pcie_gen6_phy_18a_pciephyss_nac_req_out_next ; 
logic [3:0] hif_pcie_gen6_phy_18a_pciephyss_nac_ack_out_next ; 
logic [3:0] hif_pcie_gen6_phy_18a_tfb_req_out_agent ; 
logic [3:0] hif_pcie_gen6_phy_18a_tfb_ack_out_agent ; 
logic [3:0] sn2sfi_sn2iosf_dvp_trig_fabric_out ; 
logic [3:0] sn2sfi_sn2iosf_dvp_trig_fabric_in_ack ; 
logic [3:0] sn2iosf_tfb_req_out_agent ; 
logic [3:0] sn2iosf_tfb_ack_out_agent ; 
logic [3:0] sn2sfi_iosf2sfi_dvp_trig_fabric_out ; 
logic [3:0] sn2sfi_iosf2sfi_dvp_trig_fabric_in_ack ; 
logic [3:0] iosf2sfi_tfb_req_out_agent ; 
logic [3:0] iosf2sfi_tfb_ack_out_agent ; 
logic [3:0] hlp_dvp_trig_fabric_out ; 
logic [3:0] hlp_dvp_trig_fabric_in_ack ; 
logic [3:0] hlp_tfb_req_out_agent ; 
logic [3:0] hlp_tfb_ack_out_agent ; 
logic [3:0] nss_nsc_dlw_tfb_trig_next_req_out ; 
logic [3:0] nss_nsc_dlw_tfb_trig_next_ack_out ; 
logic [3:0] nsc_tfb_req_out_agent ; 
logic [3:0] nsc_tfb_ack_out_agent ; 
logic [3:0] hif_pcie_gen6_phy_18a_tfb_req_out_next ; 
logic [3:0] hif_pcie_gen6_phy_18a_tfb_ack_out_next ; 
logic [3:0] sn2iosf_tfb_req_out_prev ; 
logic [3:0] sn2iosf_tfb_ack_out_prev ; 
logic [3:0] iosf2sfi_tfb_req_out_next ; 
logic [3:0] iosf2sfi_tfb_ack_out_next ; 
logic [3:0] dts3_tfb_req_out_prev ; 
logic [3:0] dts3_tfb_ack_out_prev ; 
logic [3:0] tfb_ubpc_par_nac_misc_adop_xtalclk_req_out_next ; 
logic [3:0] tfb_ubpc_par_nac_misc_adop_xtalclk_ack_out_next ; 
logic [3:0] tfb_ubpc_eth_physs_rdop_fout0_req_out_prev ; 
logic [3:0] tfb_ubpc_eth_physs_rdop_fout0_ack_out_prev ; 
logic [2:0] apb_dser_avephy_dvp0_pprot ; 
logic apb_dser_avephy_dvp0_psel ; 
logic apb_dser_avephy_dvp0_penable ; 
logic apb_dser_avephy_dvp0_pwrite ; 
logic [31:0] apb_dser_avephy_dvp0_pwdata ; 
logic [3:0] apb_dser_avephy_dvp0_pstrb ; 
logic [15:0] apb_dser_avephy_dvp0_paddr ; 
logic hif_pcie_gen6_phy_18a_avephy_dvp0_dvp_pready ; 
logic [31:0] hif_pcie_gen6_phy_18a_avephy_dvp0_dvp_prdata ; 
logic hif_pcie_gen6_phy_18a_avephy_dvp0_dvp_pslverr ; 
logic [2:0] apb_dser_avephy_dvp1_pprot ; 
logic apb_dser_avephy_dvp1_psel ; 
logic apb_dser_avephy_dvp1_penable ; 
logic apb_dser_avephy_dvp1_pwrite ; 
logic [31:0] apb_dser_avephy_dvp1_pwdata ; 
logic [3:0] apb_dser_avephy_dvp1_pstrb ; 
logic [15:0] apb_dser_avephy_dvp1_paddr ; 
logic hif_pcie_gen6_phy_18a_avephy_dvp1_dvp_pready ; 
logic [31:0] hif_pcie_gen6_phy_18a_avephy_dvp1_dvp_prdata ; 
logic hif_pcie_gen6_phy_18a_avephy_dvp1_dvp_pslverr ; 
logic [2:0] apb_dser_avephy_dvp2_pprot ; 
logic apb_dser_avephy_dvp2_psel ; 
logic apb_dser_avephy_dvp2_penable ; 
logic apb_dser_avephy_dvp2_pwrite ; 
logic [31:0] apb_dser_avephy_dvp2_pwdata ; 
logic [3:0] apb_dser_avephy_dvp2_pstrb ; 
logic [15:0] apb_dser_avephy_dvp2_paddr ; 
logic hif_pcie_gen6_phy_18a_avephy_dvp2_dvp_pready ; 
logic [31:0] hif_pcie_gen6_phy_18a_avephy_dvp2_dvp_prdata ; 
logic hif_pcie_gen6_phy_18a_avephy_dvp2_dvp_pslverr ; 
logic [2:0] apb_dser_avephy_dvp3_pprot ; 
logic apb_dser_avephy_dvp3_psel ; 
logic apb_dser_avephy_dvp3_penable ; 
logic apb_dser_avephy_dvp3_pwrite ; 
logic [31:0] apb_dser_avephy_dvp3_pwdata ; 
logic [3:0] apb_dser_avephy_dvp3_pstrb ; 
logic [15:0] apb_dser_avephy_dvp3_paddr ; 
logic hif_pcie_gen6_phy_18a_avephy_dvp3_dvp_pready ; 
logic [31:0] hif_pcie_gen6_phy_18a_avephy_dvp3_dvp_prdata ; 
logic hif_pcie_gen6_phy_18a_avephy_dvp3_dvp_pslverr ; 
logic [2:0] apb_dser_adpll_dvp0_pprot ; 
logic apb_dser_adpll_dvp0_psel ; 
logic apb_dser_adpll_dvp0_penable ; 
logic apb_dser_adpll_dvp0_pwrite ; 
logic [31:0] apb_dser_adpll_dvp0_pwdata ; 
logic [3:0] apb_dser_adpll_dvp0_pstrb ; 
logic [15:0] apb_dser_adpll_dvp0_paddr ; 
logic hif_pcie_gen6_phy_18a_adpll_dvp0_dvp_pready ; 
logic [31:0] hif_pcie_gen6_phy_18a_adpll_dvp0_dvp_prdata ; 
logic hif_pcie_gen6_phy_18a_adpll_dvp0_dvp_pslverr ; 
logic [2:0] apb_dser_adpll_dvp1_pprot ; 
logic apb_dser_adpll_dvp1_psel ; 
logic apb_dser_adpll_dvp1_penable ; 
logic apb_dser_adpll_dvp1_pwrite ; 
logic [31:0] apb_dser_adpll_dvp1_pwdata ; 
logic [3:0] apb_dser_adpll_dvp1_pstrb ; 
logic [15:0] apb_dser_adpll_dvp1_paddr ; 
logic hif_pcie_gen6_phy_18a_adpll_dvp1_dvp_pready ; 
logic [31:0] hif_pcie_gen6_phy_18a_adpll_dvp1_dvp_prdata ; 
logic hif_pcie_gen6_phy_18a_adpll_dvp1_dvp_pslverr ; 
logic [2:0] apb_dser_adpll_dvp2_pprot ; 
logic apb_dser_adpll_dvp2_psel ; 
logic apb_dser_adpll_dvp2_penable ; 
logic apb_dser_adpll_dvp2_pwrite ; 
logic [31:0] apb_dser_adpll_dvp2_pwdata ; 
logic [3:0] apb_dser_adpll_dvp2_pstrb ; 
logic [15:0] apb_dser_adpll_dvp2_paddr ; 
logic hif_pcie_gen6_phy_18a_adpll_dvp2_dvp_pready ; 
logic [31:0] hif_pcie_gen6_phy_18a_adpll_dvp2_dvp_prdata ; 
logic hif_pcie_gen6_phy_18a_adpll_dvp2_dvp_pslverr ; 
logic [2:0] apb_dser_adpll_dvp3_pprot ; 
logic apb_dser_adpll_dvp3_psel ; 
logic apb_dser_adpll_dvp3_penable ; 
logic apb_dser_adpll_dvp3_pwrite ; 
logic [31:0] apb_dser_adpll_dvp3_pwdata ; 
logic [3:0] apb_dser_adpll_dvp3_pstrb ; 
logic [15:0] apb_dser_adpll_dvp3_paddr ; 
logic hif_pcie_gen6_phy_18a_adpll_dvp3_dvp_pready ; 
logic [31:0] hif_pcie_gen6_phy_18a_adpll_dvp3_dvp_prdata ; 
logic hif_pcie_gen6_phy_18a_adpll_dvp3_dvp_pslverr ; 
logic [2:0] apb_dser_phy_ss_csr_dvp_pprot ; 
logic apb_dser_phy_ss_csr_dvp_psel ; 
logic apb_dser_phy_ss_csr_dvp_penable ; 
logic apb_dser_phy_ss_csr_dvp_pwrite ; 
logic [31:0] apb_dser_phy_ss_csr_dvp_pwdata ; 
logic [3:0] apb_dser_phy_ss_csr_dvp_pstrb ; 
logic [15:0] apb_dser_phy_ss_csr_dvp_paddr ; 
logic hif_pcie_gen6_phy_18a_phy_ss_csr_dvp_dvp_pready ; 
logic [31:0] hif_pcie_gen6_phy_18a_phy_ss_csr_dvp_dvp_prdata ; 
logic hif_pcie_gen6_phy_18a_phy_ss_csr_dvp_dvp_pslverr ; 
logic [2:0] apb_dser_hlp_dvp_pprot ; 
logic apb_dser_hlp_dvp_psel ; 
logic apb_dser_hlp_dvp_penable ; 
logic apb_dser_hlp_dvp_pwrite ; 
logic [31:0] apb_dser_hlp_dvp_pwdata ; 
logic [3:0] apb_dser_hlp_dvp_pstrb ; 
logic [15:0] apb_dser_hlp_dvp_paddr ; 
logic hlp_dvp_pready ; 
logic [31:0] hlp_dvp_prdata ; 
logic hlp_dvp_pslverr ; 
logic [1:0] apb_dser_cmlbuf_btrs_dvp_serial_chain_out ; 
logic par_nac_fabric1_NW_IN_tdo ; 
logic par_nac_fabric1_NW_IN_tdo_en ; 
logic par_nac_misc_NW_OUT_par_nac_fabric1_ijtag_to_reset ; 
logic par_nac_misc_NW_OUT_par_nac_fabric1_ijtag_to_ce ; 
logic par_nac_misc_NW_OUT_par_nac_fabric1_ijtag_to_se ; 
logic par_nac_misc_NW_OUT_par_nac_fabric1_ijtag_to_ue ; 
logic par_nac_misc_NW_OUT_par_nac_fabric1_ijtag_to_sel ; 
logic par_nac_misc_NW_OUT_par_nac_fabric1_ijtag_to_si ; 
logic par_nac_fabric1_NW_IN_ijtag_so ; 
logic par_nac_fabric1_NW_IN_tap_sel_out ; 
logic par_nac_fabric2_NW_IN_tdo ; 
logic par_nac_fabric2_NW_IN_tdo_en ; 
logic par_nac_misc_NW_OUT_par_nac_fabric2_ijtag_to_reset ; 
logic par_nac_misc_NW_OUT_par_nac_fabric2_ijtag_to_ce ; 
logic par_nac_misc_NW_OUT_par_nac_fabric2_ijtag_to_se ; 
logic par_nac_misc_NW_OUT_par_nac_fabric2_ijtag_to_ue ; 
logic par_nac_misc_NW_OUT_par_nac_fabric2_ijtag_to_sel ; 
logic par_nac_misc_NW_OUT_par_nac_fabric2_ijtag_to_si ; 
logic par_nac_fabric2_NW_IN_ijtag_so ; 
logic par_nac_fabric2_NW_IN_tap_sel_out ; 
logic par_nac_fabric3_NW_IN_tdo ; 
logic par_nac_fabric3_NW_IN_tdo_en ; 
logic par_nac_fabric2_NW_OUT_par_nac_fabric3_ijtag_to_reset ; 
logic par_nac_fabric2_NW_OUT_par_nac_fabric3_ijtag_to_ce ; 
logic par_nac_fabric2_NW_OUT_par_nac_fabric3_ijtag_to_se ; 
logic par_nac_fabric2_NW_OUT_par_nac_fabric3_ijtag_to_ue ; 
logic par_nac_fabric2_NW_OUT_par_nac_fabric3_ijtag_to_sel ; 
logic par_nac_fabric2_NW_OUT_par_nac_fabric3_ijtag_to_si ; 
logic par_nac_fabric3_NW_IN_ijtag_so ; 
logic par_nac_fabric3_NW_IN_tap_sel_out ; 
logic par_nac_fabric0_NW_IN_tdo ; 
logic par_nac_fabric0_NW_IN_tdo_en ; 
logic par_nac_fabric1_NW_OUT_par_nac_fabric0_ijtag_to_reset ; 
logic par_nac_fabric1_NW_OUT_par_nac_fabric0_ijtag_to_ce ; 
logic par_nac_fabric1_NW_OUT_par_nac_fabric0_ijtag_to_se ; 
logic par_nac_fabric1_NW_OUT_par_nac_fabric0_ijtag_to_ue ; 
logic par_nac_fabric1_NW_OUT_par_nac_fabric0_ijtag_to_sel ; 
logic par_nac_fabric1_NW_OUT_par_nac_fabric0_ijtag_to_si ; 
logic par_nac_fabric0_NW_IN_ijtag_so ; 
logic par_nac_fabric0_NW_IN_tap_sel_out ; 
logic par_sn2sfi_NW_IN_tdo ; 
logic par_sn2sfi_NW_IN_tdo_en ; 
logic par_nac_fabric1_NW_OUT_par_sn2sfi_ijtag_to_reset ; 
logic par_nac_fabric1_NW_OUT_par_sn2sfi_ijtag_to_ce ; 
logic par_nac_fabric1_NW_OUT_par_sn2sfi_ijtag_to_se ; 
logic par_nac_fabric1_NW_OUT_par_sn2sfi_ijtag_to_ue ; 
logic par_nac_fabric1_NW_OUT_par_sn2sfi_ijtag_to_sel ; 
logic par_nac_fabric1_NW_OUT_par_sn2sfi_ijtag_to_si ; 
logic par_sn2sfi_NW_IN_ijtag_so ; 
logic par_sn2sfi_NW_IN_tap_sel_out ; 
logic par_ecm_ifp_fuse_NW_IN_tdo ; 
logic par_ecm_ifp_fuse_NW_IN_tdo_en ; 
logic par_nac_fabric0_NW_OUT_par_ecm_ifp_fuse_ijtag_to_reset ; 
logic par_nac_fabric0_NW_OUT_par_ecm_ifp_fuse_ijtag_to_ce ; 
logic par_nac_fabric0_NW_OUT_par_ecm_ifp_fuse_ijtag_to_se ; 
logic par_nac_fabric0_NW_OUT_par_ecm_ifp_fuse_ijtag_to_ue ; 
logic par_nac_fabric0_NW_OUT_par_ecm_ifp_fuse_ijtag_to_sel ; 
logic par_nac_fabric0_NW_OUT_par_ecm_ifp_fuse_ijtag_to_si ; 
logic par_ecm_ifp_fuse_NW_IN_ijtag_so ; 
logic par_ecm_ifp_fuse_NW_IN_tap_sel_out ; 
logic [31:0] par_nac_fabric0_par_nac_fabric0_par_ecm_ifp_fuse_out_end_bus_data_out ; 
logic [31:0] par_nac_fabric1_SSN_END_1_bus_data_out ; 
logic [31:0] par_ecm_ifp_fuse_SSN_END_0_bus_data_out ; 
logic [31:0] par_nac_misc_SSN_END_0_bus_data_out ; 
logic [31:0] par_sn2sfi_SSN_END_0_bus_data_out ; 
logic [31:0] par_nac_fabric0_SSN_END_0_bus_data_out ; 
logic [31:0] par_nac_misc_par_nac_misc_par_nac_fabric2_out_end_bus_data_out ; 
logic [31:0] par_nac_fabric3_SSN_END_0_bus_data_out ; 
logic [31:0] par_nac_fabric2_SSN_END_0_bus_data_out ; 
logic [31:0] par_nac_fabric1_SSN_END_2_bus_data_out ; 
logic [31:0] par_nac_fabric2_SSN_END_1_bus_data_out ; 
logic [31:0] par_nac_fabric1_SSN_END_0_bus_data_out ; 
wire [4:0] hidft_open_0 ; 
wire [1:0] hidft_open_1 ; 
wire [21:0] hidft_open_2 ; 
wire [1:0] hidft_open_3 ; 
wire [15:0] hidft_open_4 ; 
wire [12:0] hidft_open_5 ; 
wire hidft_open_6 ; 
wire [1:0] hidft_open_7 ; 
wire [19:0] hidft_open_8 ; 
wire hidft_open_9 ; 
wire hidft_open_10 ; 
wire hidft_open_11 ; 
wire hidft_open_12 ; 
wire hidft_open_13 ; 
wire hidft_open_14 ; 
wire hidft_open_15 ; 
wire hidft_open_16 ; 
wire hidft_open_17 ; 
wire hidft_open_18 ; 
wire hidft_open_19 ; 
wire hidft_open_20 ; 
wire hidft_open_21 ; 
wire hidft_open_22 ; 
wire hidft_open_23 ; 
wire hidft_open_24 ; 
wire hidft_open_25 ; 
wire hidft_open_26 ; 
wire hidft_open_27 ; 
wire hidft_open_28 ; 
wire hidft_open_29 ; 
wire hidft_open_30 ; 
wire hidft_open_31 ; 
wire hidft_open_32 ; 
wire hidft_open_33 ; 
wire hidft_open_34 ; 
wire hidft_open_35 ; 
wire hidft_open_36 ; 
wire hidft_open_37 ; 
wire hidft_open_38 ; 
wire hidft_open_39 ; 
wire hidft_open_40 ;
`include "nac_ss.VISA_IT.nac_ss.module_header.sv" // Auto Included by VISA IT - *** Do not modify this line ***
 
par_ecm_ifp_fuse par_ecm_ifp_fuse (
    .div2_ecm_clk_clkout(par_nac_fabric0_div2_ecm_clk_clkout_out), 
    .nac_ss_debug_ecm_monout_cp_ana(nac_ss_debug_ecm_monout_cp_ana), 
    .VisaDebug(par_ecm_ifp_fuse_VisaDebug), 
    .fuse_shim_visa_sig_clk(par_ecm_ifp_fuse_fuse_shim_visa_sig_clk), 
    .fdfx_pwrgood_rst_b(fdfx_pwrgood_rst_b), 
    .dfxagg_security_policy(fdfx_security_policy), 
    .dfxagg_policy_update(fdfx_policy_update), 
    .dfxagg_early_boot_debug_exit(fdfx_earlyboot_debug_exit), 
    .dfxagg_debug_capabilities_enabling(fdfx_debug_capabilities_enabling), 
    .dfxagg_debug_capabilities_enabling_valid(fdfx_debug_capabilities_enabling_valid), 
    .nac_vccana_vccs5_iso_ctrl_b(nac_vccana_vccs5_iso_ctrl_b), 
    .nss_ecm_fuse_margin(nss_ecm_fuse_margin), 
    .nss_ecm_fuse_paddr(nss_ecm_fuse_paddr), 
    .nss_ecm_fuse_penable(nss_ecm_fuse_penable), 
    .nss_ecm_fuse_pwrite(nss_ecm_fuse_pwrite), 
    .nss_ecm_fuse_pwdata(nss_ecm_fuse_pwdata), 
    .nss_ecm_fuse_psel(nss_ecm_fuse_psel), 
    .ifs_shim_ecm_shim_prdata(ifs_shim_ecm_shim_prdata), 
    .ifs_shim_ecm_shim_pready(ifs_shim_ecm_shim_pready), 
    .ifs_shim_ecm_shim_pslverr(ifs_shim_ecm_shim_pslverr), 
    .early_boot_rst_b(early_boot_rst_b), 
    .ifs_shim_ecm_fuse_attack_bus(ifs_shim_ecm_fuse_attack_bus), 
    .nss_ecm_fuse_burst_sense(nss_ecm_fuse_burst_sense), 
    .nss_ecm_fuse_isense_tune(nss_ecm_fuse_isense_tune), 
    .nss_ecm_fuse_opcode(nss_ecm_fuse_opcode), 
    .nss_ecm_fuse_burst_pgm(nss_ecm_fuse_burst_pgm), 
    .ifs_shim_ecm_fuse_cp_on(ifs_shim_ecm_fuse_cp_on), 
    .dts_nac2_i_anode_0(dts_nac2_i_anode_1), 
    .nac_tsrdhoriz_v_anode(nac_tsrdhoriz_v_anode), 
    .dts_nac2_i_cathode(nac_dts2_i_cathode), 
    .nac_tsrdhoriz_v_cathode(nac_tsrdhoriz_v_cathode), 
    .NW_IN_tdo(par_ecm_ifp_fuse_NW_IN_tdo), 
    .NW_IN_tdo_en(par_ecm_ifp_fuse_NW_IN_tdo_en), 
    .NW_IN_ijtag_reset_b(par_nac_fabric0_NW_OUT_par_ecm_ifp_fuse_ijtag_to_reset), 
    .NW_IN_ijtag_capture(par_nac_fabric0_NW_OUT_par_ecm_ifp_fuse_ijtag_to_ce), 
    .NW_IN_ijtag_shift(par_nac_fabric0_NW_OUT_par_ecm_ifp_fuse_ijtag_to_se), 
    .NW_IN_ijtag_update(par_nac_fabric0_NW_OUT_par_ecm_ifp_fuse_ijtag_to_ue), 
    .NW_IN_ijtag_select(par_nac_fabric0_NW_OUT_par_ecm_ifp_fuse_ijtag_to_sel), 
    .NW_IN_ijtag_si(par_nac_fabric0_NW_OUT_par_ecm_ifp_fuse_ijtag_to_si), 
    .NW_IN_ijtag_so(par_ecm_ifp_fuse_NW_IN_ijtag_so), 
    .NW_IN_tap_sel_out(par_ecm_ifp_fuse_NW_IN_tap_sel_out), 
    .NW_IN_tms(tms), 
    .NW_IN_tck(tck), 
    .NW_IN_tdi(tdi), 
    .NW_IN_trst_b(trst_b), 
    .NW_IN_shift_ir_dr(shift_ir_dr), 
    .NW_IN_tms_park_value(tms_park_value), 
    .NW_IN_nw_mode(nw_mode), 
    .SSN_START_0_bus_data_in(par_nac_fabric0_par_nac_fabric0_par_ecm_ifp_fuse_out_end_bus_data_out), 
    .SSN_START_0_bus_clock_in(ssn_bus_clock_in), 
    .SSN_END_0_bus_data_out(par_ecm_ifp_fuse_SSN_END_0_bus_data_out)
) ; 
par_nac_fabric0 par_nac_fabric0 (
    .dtf_rep_fab0_fab1_arb0_rep2_arbiter2dst_arbiter_0arbiter2dst_arbiter_DTFA_ACTIVE(dtf_rep_fab0_fab1_arb0_rep2_arbiter2dst_arbiter_0_DTFA_ACTIVE), 
    .dtf_rep_fab0_fab1_arb0_rep2_arbiter2dst_arbiter_0arbiter2dst_arbiter_DTFA_CREDIT(dtf_rep_fab0_fab1_arb0_rep2_arbiter2dst_arbiter_0_DTFA_CREDIT), 
    .dtf_rep_fab0_fab1_arb0_rep2_arbiter2dst_arbiter_0arbiter2dst_arbiter_DTFA_SYNC(dtf_rep_fab0_fab1_arb0_rep2_arbiter2dst_arbiter_0_DTFA_SYNC), 
    .dtf_rep_fab0_fab1_arb0_rep2_arbiter2dst_arbiter_0arbiter2dst_arbiter_DTFA_DATA(dtf_rep_fab0_fab1_arb0_rep2_arbiter2dst_arbiter_0_DTFA_DATA), 
    .dtf_rep_fab0_fab1_arb0_rep2_arbiter2dst_arbiter_0arbiter2dst_arbiter_DTFA_HEADER(dtf_rep_fab0_fab1_arb0_rep2_arbiter2dst_arbiter_0_DTFA_HEADER), 
    .dtf_rep_fab0_fab1_arb0_rep2_arbiter2dst_arbiter_0arbiter2dst_arbiter_DTFA_VALID(dtf_rep_fab0_fab1_arb0_rep2_arbiter2dst_arbiter_0_DTFA_VALID), 
    .bclk1_out_pcie(par_nac_fabric0_bclk1_out_pcie), 
    .par_nac_misc_adop_infra_clk_clkout_out(par_nac_fabric0_par_nac_misc_adop_infra_clk_clkout_out), 
    .par_nac_misc_adop_xtalclk_clkout_out(par_nac_fabric0_par_nac_misc_adop_xtalclk_clkout_out), 
    .par_nac_fabric0_pcie_gen6_out_end_bus_data_out(par_nac_fabric0_pcie_gen6_out_end_bus_data_out), 
    .par_nac_fabric0_mux_pcie_gen6_in_start_bus_data_in(par_nac_fabric0_mux_pcie_gen6_in_start_bus_data_in), 
    .NW_OUT_hif_pcie_gen6_phy_18a_from_tdo(hif_pcie_gen6_phy_18a_NW_IN_tdo), 
    .NW_OUT_hif_pcie_gen6_phy_18a_ijtag_to_reset(par_nac_fabric0_NW_OUT_hif_pcie_gen6_phy_18a_ijtag_to_reset), 
    .NW_OUT_hif_pcie_gen6_phy_18a_ijtag_to_sel(par_nac_fabric0_NW_OUT_hif_pcie_gen6_phy_18a_ijtag_to_sel), 
    .NW_OUT_hif_pcie_gen6_phy_18a_ijtag_to_si(par_nac_fabric0_NW_OUT_hif_pcie_gen6_phy_18a_ijtag_to_si), 
    .NW_OUT_hif_pcie_gen6_phy_18a_ijtag_from_so(hif_pcie_gen6_phy_18a_NW_IN_ijtag_so), 
    .NW_OUT_hif_pcie_gen6_phy_18a_tap_sel_in(hif_pcie_gen6_phy_18a_NW_IN_tap_sel_out), 
    .par_eusb_phy_ocla_clk(par_eusb_phy_ocla_clk), 
    .par_eusb_phy_ocla_data(par_eusb_phy_ocla_data), 
    .par_eusb_phy_ocla_data_vld(par_eusb_phy_ocla_data_vld), 
    .bclk1_out_usb(par_nac_fabric0_bclk1_out_usb), 
    .par_nac_misc_adop_xtalclk_clkout(par_nac_fabric1_par_nac_misc_adop_xtalclk_clkout_out), 
    .div2_ecm_clk_clkout(par_nac_fabric1_div2_ecm_clk_clkout_out), 
    .div2_ecm_clk_clkout_out(par_nac_fabric0_div2_ecm_clk_clkout_out), 
    .par_nac_misc_adop_infra_clk_clkout(par_nac_fabric1_par_nac_misc_adop_infra_clk_clkout_out), 
    .par_nac_misc_adop_bclk_clkout_0(par_nac_fabric1_par_nac_misc_adop_bclk_clkout_out), 
    .bclk1(par_nac_fabric1_bclk1_out), 
    .boot_112p5_rdop_fout2_clkout(par_nac_fabric1_boot_112p5_rdop_fout2_clkout_out), 
    .boot_20_rdop_fout5_clkout(par_nac_fabric1_boot_20_rdop_fout5_clkout_out), 
    .boot_20_rdop_fout5_clkout_out(par_nac_fabric0_boot_20_rdop_fout5_clkout_out), 
    .boot_112p5_rdop_fout2_clkout_out(par_nac_fabric0_boot_112p5_rdop_fout2_clkout), 
    .par_nac_misc_adop_bclk_clkout_0_out(par_nac_fabric0_par_nac_misc_adop_bclk_clkout_0_out), 
    .par_nac_misc_adop_rstbus_clk_clkout(par_nac_fabric1_par_nac_misc_adop_rstbus_clk_clkout_out), 
    .par_nac_misc_adop_rstbus_clk_clkout_out(par_nac_fabric0_par_nac_misc_adop_rstbus_clk_clkout_out), 
    .dfd_dop_enable_sync_o(dfd_dop_enable_sync_o), 
    .eth_physs_rdop_fout3_clkout(par_nac_fabric1_eth_physs_rdop_fout3_clkout_fabric0), 
    .eth_physs_rdop_fout3_clkout_out(par_nac_fabric0_eth_physs_rdop_fout3_clkout_out), 
    .ts_800_rdop_fout0_clkout(par_nac_fabric1_ts_800_rdop_fout0_clkout_out), 
    .ts_800_rdop_fout0_clkout_out(par_nac_fabric0_ts_800_rdop_fout0_clkout_out), 
    .nac_ss_dtfb_upstream_rst_b(nac_ss_dtfb_upstream_rst_b), 
    .nac_pwrgood_rst_b(nac_pwrgood_rst_b), 
    .dtf_arb0_nac_fabric0_dtfa_upstream1_active_out(dtf_arb0_nac_fabric0_dtfa_upstream1_active_out), 
    .dtf_arb0_nac_fabric0_dtfa_upstream1_credit_out(dtf_arb0_nac_fabric0_dtfa_upstream1_credit_out), 
    .dtf_arb0_nac_fabric0_dtfa_upstream1_sync_out(dtf_arb0_nac_fabric0_dtfa_upstream1_sync_out), 
    .hif_pcie_gen6_phy_18a_pciephyss_nac_dtf_dnstream_data(hif_pcie_gen6_phy_18a_pciephyss_nac_dtf_dnstream_data), 
    .hif_pcie_gen6_phy_18a_pciephyss_nac_dtf_dnstream_header(hif_pcie_gen6_phy_18a_pciephyss_nac_dtf_dnstream_header), 
    .hif_pcie_gen6_phy_18a_pciephyss_nac_dtf_dnstream_valid(hif_pcie_gen6_phy_18a_pciephyss_nac_dtf_dnstream_valid), 
    .hif_pcie_gen6_phy_18a_pciephyss_nac_debug_dtf_clkout(hif_pcie_gen6_phy_18a_pciephyss_nac_debug_dtf_clkout), 
    .par_nac_fabric0_pdop_dtf_clk_clkout_0(par_nac_fabric0_pdop_dtf_clk_clkout_0), 
    .fdfx_pwrgood_rst_b_0(fdfx_pwrgood_rst_b), 
    .socviewpin_32to1digimux_fabric0_0_outmux(socviewpin_32to1digimux_fabric0_0_outmux), 
    .socviewpin_32to1digimux_fabric0_1_outmux(socviewpin_32to1digimux_fabric0_1_outmux), 
    .hif_pcie_gen6_phy_18a_pcie_phy0_adpllg6_og_dig_obs(hif_pcie_gen6_phy_18a_pcie_phy0_adpllg6_og_dig_obs), 
    .hif_pcie_gen6_phy_18a_pcie_phy0_adpllg6_og_dig_obs_0(hif_pcie_gen6_phy_18a_pcie_phy0_adpllg6_og_dig_obs_0), 
    .hif_pcie_gen6_phy_18a_pcie_phy0_adpllg6_og_dig_obs_1(hif_pcie_gen6_phy_18a_pcie_phy0_adpllg6_og_dig_obs_1), 
    .hif_pcie_gen6_phy_18a_pcie_phy0_adpllg6_og_dig_obs_2(hif_pcie_gen6_phy_18a_pcie_phy0_adpllg6_og_dig_obs_2), 
    .hif_pcie_gen6_phy_18a_pcie_phy1_adpllg6_og_dig_obs(hif_pcie_gen6_phy_18a_pcie_phy1_adpllg6_og_dig_obs), 
    .hif_pcie_gen6_phy_18a_pcie_phy1_adpllg6_og_dig_obs_0(hif_pcie_gen6_phy_18a_pcie_phy1_adpllg6_og_dig_obs_0), 
    .hif_pcie_gen6_phy_18a_pcie_phy1_adpllg6_og_dig_obs_1(hif_pcie_gen6_phy_18a_pcie_phy1_adpllg6_og_dig_obs_1), 
    .hif_pcie_gen6_phy_18a_pcie_phy1_adpllg6_og_dig_obs_2(hif_pcie_gen6_phy_18a_pcie_phy1_adpllg6_og_dig_obs_2), 
    .hif_pcie_gen6_phy_18a_pcie_phy2_adpllg6_og_dig_obs(hif_pcie_gen6_phy_18a_pcie_phy2_adpllg6_og_dig_obs), 
    .hif_pcie_gen6_phy_18a_pcie_phy2_adpllg6_og_dig_obs_0(hif_pcie_gen6_phy_18a_pcie_phy2_adpllg6_og_dig_obs_0), 
    .hif_pcie_gen6_phy_18a_pcie_phy2_adpllg6_og_dig_obs_1(hif_pcie_gen6_phy_18a_pcie_phy2_adpllg6_og_dig_obs_1), 
    .hif_pcie_gen6_phy_18a_pcie_phy2_adpllg6_og_dig_obs_2(hif_pcie_gen6_phy_18a_pcie_phy2_adpllg6_og_dig_obs_2), 
    .hif_pcie_gen6_phy_18a_pcie_phy3_adpllg6_og_dig_obs(hif_pcie_gen6_phy_18a_pcie_phy3_adpllg6_og_dig_obs), 
    .hif_pcie_gen6_phy_18a_pcie_phy3_adpllg6_og_dig_obs_0(hif_pcie_gen6_phy_18a_pcie_phy3_adpllg6_og_dig_obs_0), 
    .hif_pcie_gen6_phy_18a_pcie_phy3_adpllg6_og_dig_obs_1(hif_pcie_gen6_phy_18a_pcie_phy3_adpllg6_og_dig_obs_1), 
    .hif_pcie_gen6_phy_18a_pcie_phy3_adpllg6_og_dig_obs_2(hif_pcie_gen6_phy_18a_pcie_phy3_adpllg6_og_dig_obs_2), 
    .hif_pcie_gen6_phy_18a_pciephyss_nac_dig_viewpin_rdop_dft(hif_pcie_gen6_phy_18a_pciephyss_nac_dig_viewpin_rdop_dft), 
    .hif_pcie_gen6_phy_18a_pciephyss_nac_dig_viewpin_rdop_dft_0(hif_pcie_gen6_phy_18a_pciephyss_nac_dig_viewpin_rdop_dft_0), 
    .utmi_clk_rdop_par_eusb_phy_clkbuf_clkout(utmi_clk_rdop_par_eusb_phy_clkbuf_clkout), 
    .par_ecm_ifp_fuse_VisaDebug(par_ecm_ifp_fuse_VisaDebug), 
    .par_ecm_ifp_fuse_fuse_shim_visa_sig_clk(par_ecm_ifp_fuse_fuse_shim_visa_sig_clk), 
    .nac_ss_debug_safemode_isa_oob(nac_ss_debug_safemode_isa_oob), 
    .fdfx_pwrgood_rst_b(fdfx_pwrgood_rst_b), 
    .dfxagg_security_policy(fdfx_security_policy), 
    .dfxagg_policy_update(fdfx_policy_update), 
    .dfxagg_early_boot_debug_exit(fdfx_earlyboot_debug_exit), 
    .dfxagg_debug_capabilities_enabling(fdfx_debug_capabilities_enabling), 
    .dfxagg_debug_capabilities_enabling_valid(fdfx_debug_capabilities_enabling_valid), 
    .dfxsecure_plugin_dpt2_par_nac_fabric0_adfx_tap_grpA_enable(dfxsecure_plugin_dpt2_par_nac_fabric0_adfx_tap_grpA_enable), 
    .dfxsecure_plugin_dpt2_par_nac_fabric0_adfx_tap_grpB_enable(dfxsecure_plugin_dpt2_par_nac_fabric0_adfx_tap_grpB_enable), 
    .dfxsecure_plugin_dpt2_par_nac_fabric0_adfx_tap_grpC_enable(dfxsecure_plugin_dpt2_par_nac_fabric0_adfx_tap_grpC_enable), 
    .dfxsecure_plugin_dpt2_par_nac_fabric0_adfx_tap_grpD_enable(dfxsecure_plugin_dpt2_par_nac_fabric0_adfx_tap_grpD_enable), 
    .dfxsecure_plugin_dpt2_par_nac_fabric0_adfx_tap_grpE_enable(dfxsecure_plugin_dpt2_par_nac_fabric0_adfx_tap_grpE_enable), 
    .dfxsecure_plugin_dpt2_par_nac_fabric0_adfx_tap_grpF_enable(dfxsecure_plugin_dpt2_par_nac_fabric0_adfx_tap_grpF_enable), 
    .dfxsecure_plugin_dpt2_par_nac_fabric0_adfx_tap_grpG_enable(dfxsecure_plugin_dpt2_par_nac_fabric0_adfx_tap_grpG_enable), 
    .dfxsecure_plugin_dpt2_par_nac_fabric0_adfx_tap_grpH_enable(dfxsecure_plugin_dpt2_par_nac_fabric0_adfx_tap_grpH_enable), 
    .dfxsecure_plugin_dpt2_par_nac_fabric0_adfx_tap_grpZ_enable(dfxsecure_plugin_dpt2_par_nac_fabric0_adfx_tap_grpZ_enable), 
    .phy_cfg_jtag_apb_sel_ovr(par_nac_fabric0_phy_cfg_jtag_apb_sel_ovr), 
    .phy_cfg_jtag_apb_sel_val(par_nac_fabric0_phy_cfg_jtag_apb_sel_val), 
    .test_burnin(par_nac_fabric0_test_burnin), 
    .test_iddq(par_nac_fabric0_test_iddq), 
    .test_loopback_en(par_nac_fabric0_test_loopback_en), 
    .test_stop_clk_en(par_nac_fabric0_test_stop_clk_en), 
    .scan_occ_clkgen_chain_bypass(par_nac_fabric0_scan_occ_clkgen_chain_bypass), 
    .phy_cfg_cr_clk_sel_ovr(par_nac_fabric0_phy_cfg_cr_clk_sel_ovr), 
    .phy_cfg_cr_clk_sel_val(par_nac_fabric0_phy_cfg_cr_clk_sel_val), 
    .phy_cfg_por_in_lx_ovr(par_nac_fabric0_phy_cfg_por_in_lx_ovr), 
    .phy_cfg_por_in_lx_val(par_nac_fabric0_phy_cfg_por_in_lx_val), 
    .phy_cfg_tx_fsls_vreg_bypass_ovr(par_nac_fabric0_phy_cfg_tx_fsls_vreg_bypass_ovr), 
    .phy_cfg_tx_fsls_vreg_bypass_val(par_nac_fabric0_phy_cfg_tx_fsls_vreg_bypass_val), 
    .ref_freq_sel_2_0_ovr(par_nac_fabric0_ref_freq_sel_2_0_ovr), 
    .ref_freq_sel_2_0_val({par_nac_fabric0_ref_freq_sel_2_0_val_1,par_nac_fabric0_ref_freq_sel_2_0_val_0,par_nac_fabric0_ref_freq_sel_2_0_val}), 
    .utmi_suspend_n_ovr(par_nac_fabric0_utmi_suspend_n_ovr), 
    .utmi_suspend_n_val(par_nac_fabric0_utmi_suspend_n_val), 
    .phy_enable_ovr(par_nac_fabric0_phy_enable_ovr), 
    .phy_enable_val(par_nac_fabric0_phy_enable_val), 
    .phy_tx_dig_bypass_sel_ovr(par_nac_fabric0_phy_tx_dig_bypass_sel_ovr), 
    .phy_tx_dig_bypass_sel_val(par_nac_fabric0_phy_tx_dig_bypass_sel_val), 
    .eusb_si_bgn({par_nac_fabric0_eusb_si_bgn_6,par_nac_fabric0_eusb_si_bgn_5,par_nac_fabric0_eusb_si_bgn_4,par_nac_fabric0_eusb_si_bgn_3,par_nac_fabric0_eusb_si_bgn_2,par_nac_fabric0_eusb_si_bgn_1,par_nac_fabric0_eusb_si_bgn_0,par_nac_fabric0_eusb_si_bgn}), 
    .eusb_so_end({par_eusb_phy_scan_apb_out,par_eusb_phy_scan_jtag_out,par_eusb_phy_scan_occ_clkgen_out,par_eusb_phy_scan_ocla_out,par_eusb_phy_scan_pclk_out,par_eusb_phy_scan_pll_out,par_eusb_phy_scan_ref_out,par_eusb_phy_scan_sclk_out}), 
    .scan_sclk_clk(par_nac_fabric0_scan_sclk_clk), 
    .scan_ref_clk(par_nac_fabric0_scan_ref_clk), 
    .scan_pll_clk(par_nac_fabric0_scan_pll_clk), 
    .scan_pclk_clk(par_nac_fabric0_scan_pclk_clk), 
    .scan_ocla_clk(par_nac_fabric0_scan_ocla_clk), 
    .eusb_jtag_trst_n(par_nac_fabric0_eusb_jtag_trst_n), 
    .eusb_jtag_tms(par_nac_fabric0_eusb_jtag_tms), 
    .eusb_jtag_tdi(par_nac_fabric0_eusb_jtag_tdi), 
    .eusb_jtag_tck(par_nac_fabric0_eusb_jtag_tck), 
    .eusb_jtag_tdo_en(par_eusb_phy_jtag_tdo_en), 
    .eusb_jtag_tdo(par_eusb_phy_jtag_tdo), 
    .scan_set_rst(par_nac_fabric0_scan_set_rst), 
    .scan_shift(par_nac_fabric0_scan_shift), 
    .scan_shift_cg(par_nac_fabric0_scan_shift_cg), 
    .scan_mode(par_nac_fabric0_scan_mode), 
    .scan_asst_mode_en(par_nac_fabric0_scan_asst_mode_en), 
    .utmi_clk_bypass(par_nac_fabric0_utmi_clk_bypass), 
    .ldo_power_ready(par_eusb_phy_ldo_power_ready), 
    .nss_gbe_o_1588_one_pps_out(nss_gbe_o_1588_one_pps_out), 
    .XX_ONE_PPS_OUT(XX_ONE_PPS_OUT), 
    .XX_TIME_SYNC(XX_TIME_SYNC), 
    .time_sync_repeater_out(time_sync_repeater_out), 
    .nss_gbe_o_1588_hlp3_sync_val(nss_gbe_o_1588_hlp3_sync_val), 
    .hlp_fabric0_out(hlp_fabric0_out), 
    .nss_gbe_o_1588_physs_sync_val(nss_gbe_o_1588_physs_sync_val), 
    .physs_fabric0_out(physs_fabric0_out), 
    .nac_td_x_btda(NAC_XX_THERMDASOC0), 
    .nac_td_x_btdc(NAC_XX_THERMDCSOC0), 
    .gpio_ne_nacss_xxsvidclk_rxdata(gpio_ne_nacss_xxsvidclk_rxdata), 
    .svid_svidclk_rxdata_buf_fabric0_o(svid_svidclk_rxdata_buf_fabric0_o), 
    .gpio_ne_nacss_xxsvidalert_n_rxdata(gpio_ne_nacss_xxsvidalert_n_rxdata), 
    .svid_svidalert_rxdata_buf_fabric0_o(svid_svidalert_rxdata_buf_fabric0_o), 
    .svid_rpt1_svid_alert_rxen_fabric1_q(svid_rpt1_svid_alert_rxen_fabric1_q), 
    .svid_rpt1_svid_alert_rxen_fabric0_q(svidalert_n_rxen_b_rpt_sync), 
    .svid_rpt1_svidclk_rxen_fabric1_q(svid_rpt1_svidclk_rxen_fabric1_q), 
    .svid_rpt1_svidclk_rxen_fabric0_q(svidclk_rxen_b_rpt_sync), 
    .svid_rpt1_svidclk_txen_fabric1_q(svid_rpt1_svidclk_txen_fabric1_q), 
    .svid_rpt1_svidclk_txen_fabric0_q(svidclk_txen_b_rpt_sync), 
    .sviddata_rxdata(sviddata_rxdata), 
    .svid_rpt1_svid_rxdata_fabric0_q(svid_rpt1_svid_rxdata_fabric0_q), 
    .svid_rpt1_sviddata_rxen_fabric1_q(svid_rpt1_sviddata_rxen_fabric1_q), 
    .svid_rpt1_sviddata_rxen_fabric0_q(sviddata_rxen_b_rpt_sync), 
    .svid_rpt1_sviddata_txen_fabric1_q(svid_rpt1_sviddata_txen_fabric1_q), 
    .svid_rpt1_sviddata_txen_fabric0_q(sviddata_txen_b_rpt_sync), 
    .apb2iosfsb_pipe_rst_n(apb2iosfsb_pipe_rst_n), 
    .gpio_ne1p8_sb_pipe_rst_n(gpio_ne1p8_sb_pipe_rst_n), 
    .apb2iosfsb_in_mnpput(apb2iosfsb_in_mnpput), 
    .apb2iosfsb_in_mpcput(apb2iosfsb_in_mpcput), 
    .apb2iosfsb_in_meom(apb2iosfsb_in_meom), 
    .apb2iosfsb_in_mpayload(apb2iosfsb_in_mpayload), 
    .apb2iosfsb_in_mparity(apb2iosfsb_in_mparity), 
    .apb2iosfsb_in_tnpcup(apb2iosfsb_in_tnpcup), 
    .apb2iosfsb_in_tpccup(apb2iosfsb_in_tpccup), 
    .apb2iosfsb_in_side_ism_agent(apb2iosfsb_in_side_ism_agent), 
    .apb2iosfsb_in_pok(apb2iosfsb_in_pok), 
    .apb2iosfsb_in_mnpcup(apb2iosfsb_in_mnpcup), 
    .apb2iosfsb_in_mpccup(apb2iosfsb_in_mpccup), 
    .apb2iosfsb_in_tnpput(apb2iosfsb_in_tnpput), 
    .apb2iosfsb_in_tpcput(apb2iosfsb_in_tpcput), 
    .apb2iosfsb_in_teom(apb2iosfsb_in_teom), 
    .apb2iosfsb_in_tpayload(apb2iosfsb_in_tpayload), 
    .apb2iosfsb_in_tparity(apb2iosfsb_in_tparity), 
    .apb2iosfsb_in_side_ism_fabric(apb2iosfsb_in_side_ism_fabric), 
    .apb2iosfsb_fabric1_rep1_mnpcup_agt(apb2iosfsb_fabric1_rep1_mnpcup_agt), 
    .apb2iosfsb_fabric1_rep1_mpccup_agt(apb2iosfsb_fabric1_rep1_mpccup_agt), 
    .apb2iosfsb_fabric1_rep1_tnpput_agt(apb2iosfsb_fabric1_rep1_tnpput_agt), 
    .apb2iosfsb_fabric1_rep1_tpcput_agt(apb2iosfsb_fabric1_rep1_tpcput_agt), 
    .apb2iosfsb_fabric1_rep1_teom_agt(apb2iosfsb_fabric1_rep1_teom_agt), 
    .apb2iosfsb_fabric1_rep1_tpayload_agt(apb2iosfsb_fabric1_rep1_tpayload_agt), 
    .apb2iosfsb_fabric1_rep1_tparity_agt(apb2iosfsb_fabric1_rep1_tparity_agt), 
    .apb2iosfsb_fabric1_rep1_side_ism_fabric_agt(apb2iosfsb_fabric1_rep1_side_ism_fabric_agt), 
    .apb2iosfsb_fabric0_rep2_mnpput_fsa(apb2iosfsb_fabric0_rep2_mnpput_fsa), 
    .apb2iosfsb_fabric0_rep2_mpcput_fsa(apb2iosfsb_fabric0_rep2_mpcput_fsa), 
    .apb2iosfsb_fabric0_rep2_meom_fsa(apb2iosfsb_fabric0_rep2_meom_fsa), 
    .apb2iosfsb_fabric0_rep2_mpayload_fsa(apb2iosfsb_fabric0_rep2_mpayload_fsa), 
    .apb2iosfsb_fabric0_rep2_mparity_fsa(apb2iosfsb_fabric0_rep2_mparity_fsa), 
    .apb2iosfsb_fabric0_rep2_tnpcup_fsa(apb2iosfsb_fabric0_rep2_tnpcup_fsa), 
    .apb2iosfsb_fabric0_rep2_tpccup_fsa(apb2iosfsb_fabric0_rep2_tpccup_fsa), 
    .apb2iosfsb_fabric0_rep2_side_ism_agent_fsa(apb2iosfsb_fabric0_rep2_side_ism_agent_fsa), 
    .apb2iosfsb_fabric0_rep2_pok_fsa(apb2iosfsb_fabric0_rep2_pok_fsa), 
    .gpio_ne_1p8_in_mnpput(gpio_ne_1p8_in_mnpput), 
    .gpio_ne_1p8_in_mpcput(gpio_ne_1p8_in_mpcput), 
    .gpio_ne_1p8_in_meom(gpio_ne_1p8_in_meom), 
    .gpio_ne_1p8_in_mpayload(gpio_ne_1p8_in_mpayload), 
    .gpio_ne_1p8_in_mparity(gpio_ne_1p8_in_mparity), 
    .gpio_ne_1p8_in_tnpcup(gpio_ne_1p8_in_tnpcup), 
    .gpio_ne_1p8_in_tpccup(gpio_ne_1p8_in_tpccup), 
    .gpio_ne_1p8_in_side_ism_agent(gpio_ne_1p8_in_side_ism_agent), 
    .gpio_ne_1p8_in_pok(gpio_ne_1p8_in_pok), 
    .gpio_ne_1p8_in_mnpcup(gpio_ne_1p8_in_mnpcup), 
    .gpio_ne_1p8_in_mpccup(gpio_ne_1p8_in_mpccup), 
    .gpio_ne_1p8_in_tnpput(gpio_ne_1p8_in_tnpput), 
    .gpio_ne_1p8_in_tpcput(gpio_ne_1p8_in_tpcput), 
    .gpio_ne_1p8_in_teom(gpio_ne_1p8_in_teom), 
    .gpio_ne_1p8_in_tpayload(gpio_ne_1p8_in_tpayload), 
    .gpio_ne_1p8_in_tparity(gpio_ne_1p8_in_tparity), 
    .gpio_ne_1p8_in_side_ism_fabric(gpio_ne_1p8_in_side_ism_fabric), 
    .gpio_ne_1p8_fabric1_rep1_mnpcup_agt(gpio_ne_1p8_fabric1_rep1_mnpcup_agt), 
    .gpio_ne_1p8_fabric1_rep1_mpccup_agt(gpio_ne_1p8_fabric1_rep1_mpccup_agt), 
    .gpio_ne_1p8_fabric1_rep1_tnpput_agt(gpio_ne_1p8_fabric1_rep1_tnpput_agt), 
    .gpio_ne_1p8_fabric1_rep1_tpcput_agt(gpio_ne_1p8_fabric1_rep1_tpcput_agt), 
    .gpio_ne_1p8_fabric1_rep1_teom_agt(gpio_ne_1p8_fabric1_rep1_teom_agt), 
    .gpio_ne_1p8_fabric1_rep1_tpayload_agt(gpio_ne_1p8_fabric1_rep1_tpayload_agt), 
    .gpio_ne_1p8_fabric1_rep1_tparity_agt(gpio_ne_1p8_fabric1_rep1_tparity_agt), 
    .gpio_ne_1p8_fabric1_rep1_side_ism_fabric_agt(gpio_ne_1p8_fabric1_rep1_side_ism_fabric_agt), 
    .gpio_ne_1p8_fabric0_rep2_mnpput_fsa(gpio_ne_1p8_fabric0_rep2_mnpput_fsa), 
    .gpio_ne_1p8_fabric0_rep2_mpcput_fsa(gpio_ne_1p8_fabric0_rep2_mpcput_fsa), 
    .gpio_ne_1p8_fabric0_rep2_meom_fsa(gpio_ne_1p8_fabric0_rep2_meom_fsa), 
    .gpio_ne_1p8_fabric0_rep2_mpayload_fsa(gpio_ne_1p8_fabric0_rep2_mpayload_fsa), 
    .gpio_ne_1p8_fabric0_rep2_mparity_fsa(gpio_ne_1p8_fabric0_rep2_mparity_fsa), 
    .gpio_ne_1p8_fabric0_rep2_tnpcup_fsa(gpio_ne_1p8_fabric0_rep2_tnpcup_fsa), 
    .gpio_ne_1p8_fabric0_rep2_tpccup_fsa(gpio_ne_1p8_fabric0_rep2_tpccup_fsa), 
    .gpio_ne_1p8_fabric0_rep2_side_ism_agent_fsa(gpio_ne_1p8_fabric0_rep2_side_ism_agent_fsa), 
    .gpio_ne_1p8_fabric0_rep2_pok_fsa(gpio_ne_1p8_fabric0_rep2_pok_fsa), 
    .sb_repeater_adop_infraclk_div4_pdop_par_fabric_s5_clk_clkout(sb_repeater_adop_infraclk_div4_pdop_par_fabric_s5_clk_clkout), 
    .hif_pcie_gen6_phy_18a_pciephyss_nac_req_out_next(hif_pcie_gen6_phy_18a_pciephyss_nac_req_out_next), 
    .hif_pcie_gen6_phy_18a_pciephyss_nac_ack_out_next(hif_pcie_gen6_phy_18a_pciephyss_nac_ack_out_next), 
    .hif_pcie_gen6_phy_18a_tfb_req_out_agent(hif_pcie_gen6_phy_18a_tfb_req_out_agent), 
    .hif_pcie_gen6_phy_18a_tfb_ack_out_agent(hif_pcie_gen6_phy_18a_tfb_ack_out_agent), 
    .nac_ss_debug_par_gpio_ne_req_in_next(nac_ss_debug_par_gpio_ne_req_in_next), 
    .nac_ss_debug_par_gpio_ne_ack_in_next(nac_ss_debug_par_gpio_ne_ack_in_next), 
    .tfg_par_gpio_ne_req_out_prev(nac_ss_debug_par_gpio_ne_req_out_next), 
    .tfg_par_gpio_ne_ack_out_prev(nac_ss_debug_par_gpio_ne_ack_out_next), 
    .hif_pcie_gen6_phy_18a_tfb_req_out_next(hif_pcie_gen6_phy_18a_tfb_req_out_next), 
    .hif_pcie_gen6_phy_18a_tfb_ack_out_next(hif_pcie_gen6_phy_18a_tfb_ack_out_next), 
    .sn2iosf_tfb_req_out_prev(sn2iosf_tfb_req_out_prev), 
    .sn2iosf_tfb_ack_out_prev(sn2iosf_tfb_ack_out_prev), 
    .apb_dser_avephy_dvp0_pprot(apb_dser_avephy_dvp0_pprot), 
    .apb_dser_avephy_dvp0_psel(apb_dser_avephy_dvp0_psel), 
    .apb_dser_avephy_dvp0_penable(apb_dser_avephy_dvp0_penable), 
    .apb_dser_avephy_dvp0_pwrite(apb_dser_avephy_dvp0_pwrite), 
    .apb_dser_avephy_dvp0_pwdata(apb_dser_avephy_dvp0_pwdata), 
    .apb_dser_avephy_dvp0_pstrb(apb_dser_avephy_dvp0_pstrb), 
    .apb_dser_avephy_dvp0_paddr(apb_dser_avephy_dvp0_paddr), 
    .hif_pcie_gen6_phy_18a_avephy_dvp0_dvp_pready(hif_pcie_gen6_phy_18a_avephy_dvp0_dvp_pready), 
    .hif_pcie_gen6_phy_18a_avephy_dvp0_dvp_prdata(hif_pcie_gen6_phy_18a_avephy_dvp0_dvp_prdata), 
    .hif_pcie_gen6_phy_18a_avephy_dvp0_dvp_pslverr(hif_pcie_gen6_phy_18a_avephy_dvp0_dvp_pslverr), 
    .apb_dser_avephy_dvp1_pprot(apb_dser_avephy_dvp1_pprot), 
    .apb_dser_avephy_dvp1_psel(apb_dser_avephy_dvp1_psel), 
    .apb_dser_avephy_dvp1_penable(apb_dser_avephy_dvp1_penable), 
    .apb_dser_avephy_dvp1_pwrite(apb_dser_avephy_dvp1_pwrite), 
    .apb_dser_avephy_dvp1_pwdata(apb_dser_avephy_dvp1_pwdata), 
    .apb_dser_avephy_dvp1_pstrb(apb_dser_avephy_dvp1_pstrb), 
    .apb_dser_avephy_dvp1_paddr(apb_dser_avephy_dvp1_paddr), 
    .hif_pcie_gen6_phy_18a_avephy_dvp1_dvp_pready(hif_pcie_gen6_phy_18a_avephy_dvp1_dvp_pready), 
    .hif_pcie_gen6_phy_18a_avephy_dvp1_dvp_prdata(hif_pcie_gen6_phy_18a_avephy_dvp1_dvp_prdata), 
    .hif_pcie_gen6_phy_18a_avephy_dvp1_dvp_pslverr(hif_pcie_gen6_phy_18a_avephy_dvp1_dvp_pslverr), 
    .apb_dser_avephy_dvp2_pprot(apb_dser_avephy_dvp2_pprot), 
    .apb_dser_avephy_dvp2_psel(apb_dser_avephy_dvp2_psel), 
    .apb_dser_avephy_dvp2_penable(apb_dser_avephy_dvp2_penable), 
    .apb_dser_avephy_dvp2_pwrite(apb_dser_avephy_dvp2_pwrite), 
    .apb_dser_avephy_dvp2_pwdata(apb_dser_avephy_dvp2_pwdata), 
    .apb_dser_avephy_dvp2_pstrb(apb_dser_avephy_dvp2_pstrb), 
    .apb_dser_avephy_dvp2_paddr(apb_dser_avephy_dvp2_paddr), 
    .hif_pcie_gen6_phy_18a_avephy_dvp2_dvp_pready(hif_pcie_gen6_phy_18a_avephy_dvp2_dvp_pready), 
    .hif_pcie_gen6_phy_18a_avephy_dvp2_dvp_prdata(hif_pcie_gen6_phy_18a_avephy_dvp2_dvp_prdata), 
    .hif_pcie_gen6_phy_18a_avephy_dvp2_dvp_pslverr(hif_pcie_gen6_phy_18a_avephy_dvp2_dvp_pslverr), 
    .apb_dser_avephy_dvp3_pprot(apb_dser_avephy_dvp3_pprot), 
    .apb_dser_avephy_dvp3_psel(apb_dser_avephy_dvp3_psel), 
    .apb_dser_avephy_dvp3_penable(apb_dser_avephy_dvp3_penable), 
    .apb_dser_avephy_dvp3_pwrite(apb_dser_avephy_dvp3_pwrite), 
    .apb_dser_avephy_dvp3_pwdata(apb_dser_avephy_dvp3_pwdata), 
    .apb_dser_avephy_dvp3_pstrb(apb_dser_avephy_dvp3_pstrb), 
    .apb_dser_avephy_dvp3_paddr(apb_dser_avephy_dvp3_paddr), 
    .hif_pcie_gen6_phy_18a_avephy_dvp3_dvp_pready(hif_pcie_gen6_phy_18a_avephy_dvp3_dvp_pready), 
    .hif_pcie_gen6_phy_18a_avephy_dvp3_dvp_prdata(hif_pcie_gen6_phy_18a_avephy_dvp3_dvp_prdata), 
    .hif_pcie_gen6_phy_18a_avephy_dvp3_dvp_pslverr(hif_pcie_gen6_phy_18a_avephy_dvp3_dvp_pslverr), 
    .apb_dser_adpll_dvp0_pprot(apb_dser_adpll_dvp0_pprot), 
    .apb_dser_adpll_dvp0_psel(apb_dser_adpll_dvp0_psel), 
    .apb_dser_adpll_dvp0_penable(apb_dser_adpll_dvp0_penable), 
    .apb_dser_adpll_dvp0_pwrite(apb_dser_adpll_dvp0_pwrite), 
    .apb_dser_adpll_dvp0_pwdata(apb_dser_adpll_dvp0_pwdata), 
    .apb_dser_adpll_dvp0_pstrb(apb_dser_adpll_dvp0_pstrb), 
    .apb_dser_adpll_dvp0_paddr(apb_dser_adpll_dvp0_paddr), 
    .hif_pcie_gen6_phy_18a_adpll_dvp0_dvp_pready(hif_pcie_gen6_phy_18a_adpll_dvp0_dvp_pready), 
    .hif_pcie_gen6_phy_18a_adpll_dvp0_dvp_prdata(hif_pcie_gen6_phy_18a_adpll_dvp0_dvp_prdata), 
    .hif_pcie_gen6_phy_18a_adpll_dvp0_dvp_pslverr(hif_pcie_gen6_phy_18a_adpll_dvp0_dvp_pslverr), 
    .apb_dser_adpll_dvp1_pprot(apb_dser_adpll_dvp1_pprot), 
    .apb_dser_adpll_dvp1_psel(apb_dser_adpll_dvp1_psel), 
    .apb_dser_adpll_dvp1_penable(apb_dser_adpll_dvp1_penable), 
    .apb_dser_adpll_dvp1_pwrite(apb_dser_adpll_dvp1_pwrite), 
    .apb_dser_adpll_dvp1_pwdata(apb_dser_adpll_dvp1_pwdata), 
    .apb_dser_adpll_dvp1_pstrb(apb_dser_adpll_dvp1_pstrb), 
    .apb_dser_adpll_dvp1_paddr(apb_dser_adpll_dvp1_paddr), 
    .hif_pcie_gen6_phy_18a_adpll_dvp1_dvp_pready(hif_pcie_gen6_phy_18a_adpll_dvp1_dvp_pready), 
    .hif_pcie_gen6_phy_18a_adpll_dvp1_dvp_prdata(hif_pcie_gen6_phy_18a_adpll_dvp1_dvp_prdata), 
    .hif_pcie_gen6_phy_18a_adpll_dvp1_dvp_pslverr(hif_pcie_gen6_phy_18a_adpll_dvp1_dvp_pslverr), 
    .apb_dser_adpll_dvp2_pprot(apb_dser_adpll_dvp2_pprot), 
    .apb_dser_adpll_dvp2_psel(apb_dser_adpll_dvp2_psel), 
    .apb_dser_adpll_dvp2_penable(apb_dser_adpll_dvp2_penable), 
    .apb_dser_adpll_dvp2_pwrite(apb_dser_adpll_dvp2_pwrite), 
    .apb_dser_adpll_dvp2_pwdata(apb_dser_adpll_dvp2_pwdata), 
    .apb_dser_adpll_dvp2_pstrb(apb_dser_adpll_dvp2_pstrb), 
    .apb_dser_adpll_dvp2_paddr(apb_dser_adpll_dvp2_paddr), 
    .hif_pcie_gen6_phy_18a_adpll_dvp2_dvp_pready(hif_pcie_gen6_phy_18a_adpll_dvp2_dvp_pready), 
    .hif_pcie_gen6_phy_18a_adpll_dvp2_dvp_prdata(hif_pcie_gen6_phy_18a_adpll_dvp2_dvp_prdata), 
    .hif_pcie_gen6_phy_18a_adpll_dvp2_dvp_pslverr(hif_pcie_gen6_phy_18a_adpll_dvp2_dvp_pslverr), 
    .apb_dser_adpll_dvp3_pprot(apb_dser_adpll_dvp3_pprot), 
    .apb_dser_adpll_dvp3_psel(apb_dser_adpll_dvp3_psel), 
    .apb_dser_adpll_dvp3_penable(apb_dser_adpll_dvp3_penable), 
    .apb_dser_adpll_dvp3_pwrite(apb_dser_adpll_dvp3_pwrite), 
    .apb_dser_adpll_dvp3_pwdata(apb_dser_adpll_dvp3_pwdata), 
    .apb_dser_adpll_dvp3_pstrb(apb_dser_adpll_dvp3_pstrb), 
    .apb_dser_adpll_dvp3_paddr(apb_dser_adpll_dvp3_paddr), 
    .hif_pcie_gen6_phy_18a_adpll_dvp3_dvp_pready(hif_pcie_gen6_phy_18a_adpll_dvp3_dvp_pready), 
    .hif_pcie_gen6_phy_18a_adpll_dvp3_dvp_prdata(hif_pcie_gen6_phy_18a_adpll_dvp3_dvp_prdata), 
    .hif_pcie_gen6_phy_18a_adpll_dvp3_dvp_pslverr(hif_pcie_gen6_phy_18a_adpll_dvp3_dvp_pslverr), 
    .apb_dser_phy_ss_csr_dvp_pprot(apb_dser_phy_ss_csr_dvp_pprot), 
    .apb_dser_phy_ss_csr_dvp_psel(apb_dser_phy_ss_csr_dvp_psel), 
    .apb_dser_phy_ss_csr_dvp_penable(apb_dser_phy_ss_csr_dvp_penable), 
    .apb_dser_phy_ss_csr_dvp_pwrite(apb_dser_phy_ss_csr_dvp_pwrite), 
    .apb_dser_phy_ss_csr_dvp_pwdata(apb_dser_phy_ss_csr_dvp_pwdata), 
    .apb_dser_phy_ss_csr_dvp_pstrb(apb_dser_phy_ss_csr_dvp_pstrb), 
    .apb_dser_phy_ss_csr_dvp_paddr(apb_dser_phy_ss_csr_dvp_paddr), 
    .hif_pcie_gen6_phy_18a_phy_ss_csr_dvp_dvp_pready(hif_pcie_gen6_phy_18a_phy_ss_csr_dvp_dvp_pready), 
    .hif_pcie_gen6_phy_18a_phy_ss_csr_dvp_dvp_prdata(hif_pcie_gen6_phy_18a_phy_ss_csr_dvp_dvp_prdata), 
    .hif_pcie_gen6_phy_18a_phy_ss_csr_dvp_dvp_pslverr(hif_pcie_gen6_phy_18a_phy_ss_csr_dvp_dvp_pslverr), 
    .nac_ss_debug_apb_rst_n(nac_ss_debug_apb_rst_n), 
    .nac_ss_debug_serializer_hif_eusb2_chain_out_to_nac(nac_ss_debug_serializer_hif_eusb2_chain_out_to_nac), 
    .apb_dser_eusb_dvp_serial_chain_out(nac_ss_debug_serializer_hif_eusb2_chain_in_from_nac), 
    .NW_IN_tdo(par_nac_fabric0_NW_IN_tdo), 
    .NW_IN_tdo_en(par_nac_fabric0_NW_IN_tdo_en), 
    .NW_IN_ijtag_reset_b(par_nac_fabric1_NW_OUT_par_nac_fabric0_ijtag_to_reset), 
    .NW_IN_ijtag_capture(par_nac_fabric1_NW_OUT_par_nac_fabric0_ijtag_to_ce), 
    .NW_IN_ijtag_shift(par_nac_fabric1_NW_OUT_par_nac_fabric0_ijtag_to_se), 
    .NW_IN_ijtag_update(par_nac_fabric1_NW_OUT_par_nac_fabric0_ijtag_to_ue), 
    .NW_IN_ijtag_select(par_nac_fabric1_NW_OUT_par_nac_fabric0_ijtag_to_sel), 
    .NW_IN_ijtag_si(par_nac_fabric1_NW_OUT_par_nac_fabric0_ijtag_to_si), 
    .NW_IN_ijtag_so(par_nac_fabric0_NW_IN_ijtag_so), 
    .NW_IN_tap_sel_out(par_nac_fabric0_NW_IN_tap_sel_out), 
    .NW_OUT_par_gpio_ne_to_trst(NW_OUT_par_gpio_ne_to_trst), 
    .NW_OUT_par_gpio_ne_to_tck(NW_OUT_par_gpio_ne_to_tck), 
    .NW_OUT_par_gpio_ne_to_tms(NW_OUT_par_gpio_ne_to_tms), 
    .NW_OUT_par_gpio_ne_to_tdi(NW_OUT_par_gpio_ne_to_tdi), 
    .NW_OUT_par_gpio_ne_from_tdo(NW_OUT_par_gpio_ne_from_tdo), 
    .NW_OUT_par_gpio_ne_from_tdo_en(NW_OUT_par_gpio_ne_from_tdo_en), 
    .NW_OUT_par_gpio_ne_tap_sel_in(NW_OUT_par_gpio_ne_tap_sel_in), 
    .NW_OUT_par_gpio_ne_ijtag_to_reset(NW_OUT_par_gpio_ne_ijtag_to_reset), 
    .NW_OUT_par_gpio_ne_ijtag_to_tck(NW_OUT_par_gpio_ne_ijtag_to_tck), 
    .NW_OUT_par_gpio_ne_ijtag_to_ce(NW_OUT_par_gpio_ne_ijtag_to_ce), 
    .NW_OUT_par_gpio_ne_ijtag_to_se(NW_OUT_par_gpio_ne_ijtag_to_se), 
    .NW_OUT_par_gpio_ne_ijtag_to_ue(NW_OUT_par_gpio_ne_ijtag_to_ue), 
    .NW_OUT_par_gpio_ne_ijtag_to_sel(NW_OUT_par_gpio_ne_ijtag_to_sel), 
    .NW_OUT_par_gpio_ne_ijtag_to_si(NW_OUT_par_gpio_ne_ijtag_to_si), 
    .NW_OUT_par_gpio_ne_ijtag_from_so(NW_OUT_par_gpio_ne_ijtag_from_so), 
    .NW_OUT_par_ecm_ifp_fuse_from_tdo(par_ecm_ifp_fuse_NW_IN_tdo), 
    .NW_OUT_par_ecm_ifp_fuse_from_tdo_en(par_ecm_ifp_fuse_NW_IN_tdo_en), 
    .NW_OUT_par_ecm_ifp_fuse_ijtag_to_reset(par_nac_fabric0_NW_OUT_par_ecm_ifp_fuse_ijtag_to_reset), 
    .NW_OUT_par_ecm_ifp_fuse_ijtag_to_ce(par_nac_fabric0_NW_OUT_par_ecm_ifp_fuse_ijtag_to_ce), 
    .NW_OUT_par_ecm_ifp_fuse_ijtag_to_se(par_nac_fabric0_NW_OUT_par_ecm_ifp_fuse_ijtag_to_se), 
    .NW_OUT_par_ecm_ifp_fuse_ijtag_to_ue(par_nac_fabric0_NW_OUT_par_ecm_ifp_fuse_ijtag_to_ue), 
    .NW_OUT_par_ecm_ifp_fuse_ijtag_to_sel(par_nac_fabric0_NW_OUT_par_ecm_ifp_fuse_ijtag_to_sel), 
    .NW_OUT_par_ecm_ifp_fuse_ijtag_to_si(par_nac_fabric0_NW_OUT_par_ecm_ifp_fuse_ijtag_to_si), 
    .NW_OUT_par_ecm_ifp_fuse_ijtag_from_so(par_ecm_ifp_fuse_NW_IN_ijtag_so), 
    .NW_OUT_par_ecm_ifp_fuse_tap_sel_in(par_ecm_ifp_fuse_NW_IN_tap_sel_out), 
    .NW_IN_tms(tms), 
    .NW_IN_tck(tck), 
    .NW_IN_tdi(tdi), 
    .NW_IN_trst_b(trst_b), 
    .NW_IN_shift_ir_dr(shift_ir_dr), 
    .NW_IN_tms_park_value(tms_park_value), 
    .NW_IN_nw_mode(nw_mode), 
    .par_nac_fabric0_mux_par_gpio_ne_in_start_bus_data_in(par_nac_fabric0_mux_par_gpio_ne_in_start_bus_data_in), 
    .par_nac_fabric0_mux_par_gpio_ne_in_start_bus_clock_in(ssn_bus_clock_in), 
    .par_nac_fabric0_par_gpio_ne_out_end_bus_data_out(par_nac_fabric0_par_gpio_ne_out_end_bus_data_out), 
    .par_nac_fabric0_par_ecm_ifp_fuse_out_end_bus_data_out(par_nac_fabric0_par_nac_fabric0_par_ecm_ifp_fuse_out_end_bus_data_out), 
    .SSN_START_0_bus_data_in(par_nac_fabric1_SSN_END_1_bus_data_out), 
    .SSN_START_0_bus_clock_in(ssn_bus_clock_in), 
    .par_nac_fabric0_mux_par_ecm_ifp_fuse_in_start_bus_data_in(par_ecm_ifp_fuse_SSN_END_0_bus_data_out), 
    .par_nac_fabric0_mux_par_ecm_ifp_fuse_in_start_bus_clock_in(ssn_bus_clock_in), 
    .SSN_END_0_bus_data_out(par_nac_fabric0_SSN_END_0_bus_data_out), 
    .nac_ss_debug_timestamp(nac_ss_debug_timestamp), 
    .NW_OUT_hif_pcie_gen6_phy_18a_from_tdo_en(1'b0), 
    .par_nac_fabric0_mux_pcie_gen6_in_start_bus_clock_in(1'b0), 
    .NW_OUT_hif_pcie_gen6_phy_18a_to_trst(), 
    .NW_OUT_hif_pcie_gen6_phy_18a_to_tck(), 
    .NW_OUT_hif_pcie_gen6_phy_18a_to_tms(), 
    .NW_OUT_hif_pcie_gen6_phy_18a_to_tdi(), 
    .NW_OUT_par_ecm_ifp_fuse_to_trst(), 
    .NW_OUT_par_ecm_ifp_fuse_to_tck(), 
    .NW_OUT_par_ecm_ifp_fuse_to_tms(), 
    .NW_OUT_par_ecm_ifp_fuse_to_tdi(), 
    .NW_OUT_hif_pcie_gen6_phy_18a_ijtag_to_tck(), 
    .NW_OUT_hif_pcie_gen6_phy_18a_ijtag_to_ce(), 
    .NW_OUT_hif_pcie_gen6_phy_18a_ijtag_to_se(), 
    .NW_OUT_hif_pcie_gen6_phy_18a_ijtag_to_ue(), 
    .NW_OUT_par_ecm_ifp_fuse_ijtag_to_tck()
) ; 
par_nac_fabric1 par_nac_fabric1 (
    .dtf_rep_fab1_misc_arb0_rep1_arbiter2dst_arbiter_0arbiter2dst_arbiter_DTFA_ACTIVE(dtf_rep_fab1_misc_arb0_rep1_arbiter2dst_arbiter_0_DTFA_ACTIVE), 
    .dtf_rep_fab1_misc_arb0_rep1_arbiter2dst_arbiter_0arbiter2dst_arbiter_DTFA_CREDIT(dtf_rep_fab1_misc_arb0_rep1_arbiter2dst_arbiter_0_DTFA_CREDIT), 
    .dtf_rep_fab1_misc_arb0_rep1_arbiter2dst_arbiter_0arbiter2dst_arbiter_DTFA_SYNC(dtf_rep_fab1_misc_arb0_rep1_arbiter2dst_arbiter_0_DTFA_SYNC), 
    .dtf_rep_fab1_misc_arb0_rep1_arbiter2dst_arbiter_0arbiter2dst_arbiter_DTFA_DATA(dtf_rep_fab1_misc_arb0_rep1_arbiter2dst_arbiter_0_DTFA_DATA), 
    .dtf_rep_fab1_misc_arb0_rep1_arbiter2dst_arbiter_0arbiter2dst_arbiter_DTFA_HEADER(dtf_rep_fab1_misc_arb0_rep1_arbiter2dst_arbiter_0_DTFA_HEADER), 
    .dtf_rep_fab1_misc_arb0_rep1_arbiter2dst_arbiter_0arbiter2dst_arbiter_DTFA_VALID(dtf_rep_fab1_misc_arb0_rep1_arbiter2dst_arbiter_0_DTFA_VALID), 
    .dtf_rep_fab0_fab1_arb0_rep2_arbiter2dst_arbiter_0arbiter2arbibert_in_DTFA_ACTIVE(dtf_rep_fab0_fab1_arb0_rep2_arbiter2dst_arbiter_0_DTFA_ACTIVE), 
    .dtf_rep_fab0_fab1_arb0_rep2_arbiter2dst_arbiter_0arbiter2arbibert_in_DTFA_CREDIT(dtf_rep_fab0_fab1_arb0_rep2_arbiter2dst_arbiter_0_DTFA_CREDIT), 
    .dtf_rep_fab0_fab1_arb0_rep2_arbiter2dst_arbiter_0arbiter2arbibert_in_DTFA_SYNC(dtf_rep_fab0_fab1_arb0_rep2_arbiter2dst_arbiter_0_DTFA_SYNC), 
    .dtf_rep_fab0_fab1_arb0_rep2_arbiter2dst_arbiter_0arbiter2arbibert_in_DTFA_DATA(dtf_rep_fab0_fab1_arb0_rep2_arbiter2dst_arbiter_0_DTFA_DATA), 
    .dtf_rep_fab0_fab1_arb0_rep2_arbiter2dst_arbiter_0arbiter2arbibert_in_DTFA_HEADER(dtf_rep_fab0_fab1_arb0_rep2_arbiter2dst_arbiter_0_DTFA_HEADER), 
    .dtf_rep_fab0_fab1_arb0_rep2_arbiter2dst_arbiter_0arbiter2arbibert_in_DTFA_VALID(dtf_rep_fab0_fab1_arb0_rep2_arbiter2dst_arbiter_0_DTFA_VALID), 
    .par_nac_misc_adop_xtalclk_clkout(par_nac_misc_par_nac_misc_adop_xtalclk_clkout), 
    .par_nac_misc_adop_xtalclk_clkout_out(par_nac_fabric1_par_nac_misc_adop_xtalclk_clkout_out), 
    .par_nac_misc_adop_xtalclk_clkout_out_sn2sfi(par_nac_fabric1_par_nac_misc_adop_xtalclk_clkout_out_sn2sfi), 
    .div2_ecm_clk_clkout(par_nac_misc_div2_ecm_clk_clkout), 
    .div2_ecm_clk_clkout_out(par_nac_fabric1_div2_ecm_clk_clkout_out), 
    .sfi_clk_1g_in(sfi_clk_1g_in), 
    .sfi_clk_1g_in_out(par_nac_fabric1_sfi_clk_1g_in_out), 
    .par_nac_misc_adop_infra_clk_clkout(par_nac_misc_par_nac_misc_adop_infra_clk_clkout), 
    .par_nac_misc_adop_infra_clk_clkout_out(par_nac_fabric1_par_nac_misc_adop_infra_clk_clkout_out), 
    .par_nac_misc_adop_infra_clk_clkout_out_sn2sfi(par_nac_fabric1_par_nac_misc_adop_infra_clk_clkout_out_sn2sfi), 
    .par_nac_misc_adop_bclk_clkout(par_nac_misc_par_nac_misc_adop_bclk_clkout_0), 
    .par_nac_misc_adop_bclk_clkout_out(par_nac_fabric1_par_nac_misc_adop_bclk_clkout_out), 
    .bclk1(bclk1), 
    .bclk1_out(par_nac_fabric1_bclk1_out), 
    .boot_112p5_rdop_fout2_clkout(par_nac_misc_boot_112p5_rdop_fout2_clkout), 
    .boot_112p5_rdop_fout2_clkout_out(par_nac_fabric1_boot_112p5_rdop_fout2_clkout_out), 
    .boot_20_rdop_fout5_clkout(par_nac_misc_boot_20_rdop_fout5_clkout), 
    .boot_20_rdop_fout5_clkout_out(par_nac_fabric1_boot_20_rdop_fout5_clkout_out), 
    .par_nac_misc_adop_rstbus_clk_clkout(par_nac_misc_par_nac_misc_adop_rstbus_clk_clkout_0), 
    .par_nac_misc_adop_rstbus_clk_clkout_out(par_nac_fabric1_par_nac_misc_adop_rstbus_clk_clkout_out), 
    .dfd_dop_enable_sync_o(dfd_dop_enable_sync_o), 
    .eth_physs_rdop_fout3_clkout(par_nac_fabric2_eth_physs_rdop_fout3_clkout_fabric1), 
    .eth_physs_rdop_fout3_clkout_sn2sfi(par_nac_fabric1_eth_physs_rdop_fout3_clkout_sn2sfi), 
    .eth_physs_rdop_fout3_clkout_fabric0(par_nac_fabric1_eth_physs_rdop_fout3_clkout_fabric0), 
    .ts_800_rdop_fout0_clkout(par_nac_misc_ts_800_rdop_fout0_clkout), 
    .ts_800_rdop_fout0_clkout_out(par_nac_fabric1_ts_800_rdop_fout0_clkout_out), 
    .nac_ss_dtfb_upstream_rst_b(nac_ss_dtfb_upstream_rst_b), 
    .nac_pwrgood_rst_b(nac_pwrgood_rst_b), 
    .dtf_rep_fab1_iosf2sfi_arb1_rep0_dtfr_upstream_d0_active_out(dtf_rep_fab1_iosf2sfi_arb1_rep0_dtfr_upstream_d0_active_out), 
    .dtf_rep_fab1_iosf2sfi_arb1_rep0_dtfr_upstream_d0_credit_out(dtf_rep_fab1_iosf2sfi_arb1_rep0_dtfr_upstream_d0_credit_out), 
    .dtf_rep_fab1_iosf2sfi_arb1_rep0_dtfr_upstream_d0_sync_out(dtf_rep_fab1_iosf2sfi_arb1_rep0_dtfr_upstream_d0_sync_out), 
    .par_sn2sfi_iosf2sfi_dtfa_dnstream_data_out(par_sn2sfi_iosf2sfi_dtfa_dnstream_data_out), 
    .par_sn2sfi_iosf2sfi_dtfa_dnstream_header_out(par_sn2sfi_iosf2sfi_dtfa_dnstream_header_out), 
    .par_sn2sfi_iosf2sfi_dtfa_dnstream_valid_out(par_sn2sfi_iosf2sfi_dtfa_dnstream_valid_out), 
    .dtf_rep_fab1_sn2iosf_arb1_rep0_dtfr_upstream_d0_active_out(dtf_rep_fab1_sn2iosf_arb1_rep0_dtfr_upstream_d0_active_out), 
    .dtf_rep_fab1_sn2iosf_arb1_rep0_dtfr_upstream_d0_credit_out(dtf_rep_fab1_sn2iosf_arb1_rep0_dtfr_upstream_d0_credit_out), 
    .dtf_rep_fab1_sn2iosf_arb1_rep0_dtfr_upstream_d0_sync_out(dtf_rep_fab1_sn2iosf_arb1_rep0_dtfr_upstream_d0_sync_out), 
    .par_sn2sfi_sn2iosf_dtfa_dnstream_data_out(par_sn2sfi_sn2iosf_dtfa_dnstream_data_out), 
    .par_sn2sfi_sn2iosf_dtfa_dnstream_header_out(par_sn2sfi_sn2iosf_dtfa_dnstream_header_out), 
    .par_sn2sfi_sn2iosf_dtfa_dnstream_valid_out(par_sn2sfi_sn2iosf_dtfa_dnstream_valid_out), 
    .par_nac_fabric1_pdop_dtf_clk_clkout(par_nac_fabric1_pdop_dtf_clk_clkout), 
    .par_nac_fabric0_pdop_dtf_clk_clkout_0(par_nac_fabric0_pdop_dtf_clk_clkout_0), 
    .fdfx_pwrgood_rst_b_0(fdfx_pwrgood_rst_b), 
    .fdfx_pwrgood_rst_b(fdfx_pwrgood_rst_b), 
    .dfxagg_security_policy(fdfx_security_policy), 
    .dfxagg_policy_update(fdfx_policy_update), 
    .dfxagg_early_boot_debug_exit(fdfx_earlyboot_debug_exit), 
    .dfxagg_debug_capabilities_enabling(fdfx_debug_capabilities_enabling), 
    .dfxagg_debug_capabilities_enabling_valid(fdfx_debug_capabilities_enabling_valid), 
    .hlp_fabric0_out(hlp_fabric0_out), 
    .hlp_fabric1_out(hlp_fabric1_out), 
    .physs_fabric0_out(physs_fabric0_out), 
    .physs_fabric1_out(physs_fabric1_out), 
    .svid_svidclk_rxdata_buf_fabric0_o(svid_svidclk_rxdata_buf_fabric0_o), 
    .svid_svidclk_rxdata_buf_fabric1_o(nacss_punit_feedthrough_xxsvidclk_rxdata), 
    .svid_svidalert_rxdata_buf_fabric0_o(svid_svidalert_rxdata_buf_fabric0_o), 
    .svid_svidalert_rxdata_buf_fabric1_o(nacss_punit_feedthrough_xxsvidalert_n_rxdata), 
    .svidalert_n_rxen_b(svidalert_n_rxen_b), 
    .svid_rpt1_svid_alert_rxen_fabric1_q(svid_rpt1_svid_alert_rxen_fabric1_q), 
    .svidclk_rxen_b(svidclk_rxen_b), 
    .svid_rpt1_svidclk_rxen_fabric1_q(svid_rpt1_svidclk_rxen_fabric1_q), 
    .svidclk_txen_b(svidclk_txen_b), 
    .svid_rpt1_svidclk_txen_fabric1_q(svid_rpt1_svidclk_txen_fabric1_q), 
    .svid_rpt1_svid_rxdata_fabric0_q(svid_rpt1_svid_rxdata_fabric0_q), 
    .svid_rpt1_svid_rxdata_fabric1_q(sviddata_rxdata_rpt_sync), 
    .sviddata_rxen_b(sviddata_rxen_b), 
    .svid_rpt1_sviddata_rxen_fabric1_q(svid_rpt1_sviddata_rxen_fabric1_q), 
    .sviddata_txen_b(sviddata_txen_b), 
    .svid_rpt1_sviddata_txen_fabric1_q(svid_rpt1_sviddata_txen_fabric1_q), 
    .apb2iosfsb_pipe_rst_n(apb2iosfsb_pipe_rst_n), 
    .gpio_ne1p8_sb_pipe_rst_n(gpio_ne1p8_sb_pipe_rst_n), 
    .apb2iosfsb_fabric1_rep1_mnpcup_agt(apb2iosfsb_fabric1_rep1_mnpcup_agt), 
    .apb2iosfsb_fabric1_rep1_mpccup_agt(apb2iosfsb_fabric1_rep1_mpccup_agt), 
    .apb2iosfsb_fabric1_rep1_tnpput_agt(apb2iosfsb_fabric1_rep1_tnpput_agt), 
    .apb2iosfsb_fabric1_rep1_tpcput_agt(apb2iosfsb_fabric1_rep1_tpcput_agt), 
    .apb2iosfsb_fabric1_rep1_teom_agt(apb2iosfsb_fabric1_rep1_teom_agt), 
    .apb2iosfsb_fabric1_rep1_tpayload_agt(apb2iosfsb_fabric1_rep1_tpayload_agt), 
    .apb2iosfsb_fabric1_rep1_tparity_agt(apb2iosfsb_fabric1_rep1_tparity_agt), 
    .apb2iosfsb_fabric1_rep1_side_ism_fabric_agt(apb2iosfsb_fabric1_rep1_side_ism_fabric_agt), 
    .apb2iosfsb_fabric0_rep2_mnpput_fsa(apb2iosfsb_fabric0_rep2_mnpput_fsa), 
    .apb2iosfsb_fabric0_rep2_mpcput_fsa(apb2iosfsb_fabric0_rep2_mpcput_fsa), 
    .apb2iosfsb_fabric0_rep2_meom_fsa(apb2iosfsb_fabric0_rep2_meom_fsa), 
    .apb2iosfsb_fabric0_rep2_mpayload_fsa(apb2iosfsb_fabric0_rep2_mpayload_fsa), 
    .apb2iosfsb_fabric0_rep2_mparity_fsa(apb2iosfsb_fabric0_rep2_mparity_fsa), 
    .apb2iosfsb_fabric0_rep2_tnpcup_fsa(apb2iosfsb_fabric0_rep2_tnpcup_fsa), 
    .apb2iosfsb_fabric0_rep2_tpccup_fsa(apb2iosfsb_fabric0_rep2_tpccup_fsa), 
    .apb2iosfsb_fabric0_rep2_side_ism_agent_fsa(apb2iosfsb_fabric0_rep2_side_ism_agent_fsa), 
    .apb2iosfsb_fabric0_rep2_pok_fsa(apb2iosfsb_fabric0_rep2_pok_fsa), 
    .apb2iosfsb_out_mnpcup(apb2iosfsb_out_mnpcup), 
    .apb2iosfsb_out_mpccup(apb2iosfsb_out_mpccup), 
    .apb2iosfsb_out_tnpput(apb2iosfsb_out_tnpput), 
    .apb2iosfsb_out_tpcput(apb2iosfsb_out_tpcput), 
    .apb2iosfsb_out_teom(apb2iosfsb_out_teom), 
    .apb2iosfsb_out_tpayload(apb2iosfsb_out_tpayload), 
    .apb2iosfsb_out_tparity(apb2iosfsb_out_tparity), 
    .apb2iosfsb_out_side_ism_fabric(apb2iosfsb_out_side_ism_fabric), 
    .apb2iosfsb_out_mnpput(apb2iosfsb_out_mnpput), 
    .apb2iosfsb_out_mpcput(apb2iosfsb_out_mpcput), 
    .apb2iosfsb_out_meom(apb2iosfsb_out_meom), 
    .apb2iosfsb_out_mpayload(apb2iosfsb_out_mpayload), 
    .apb2iosfsb_out_mparity(apb2iosfsb_out_mparity), 
    .apb2iosfsb_out_tnpcup(apb2iosfsb_out_tnpcup), 
    .apb2iosfsb_out_tpccup(apb2iosfsb_out_tpccup), 
    .apb2iosfsb_out_side_ism_agent(apb2iosfsb_out_side_ism_agent), 
    .apb2iosfsb_out_pok(apb2iosfsb_out_pok), 
    .gpio_ne_1p8_fabric1_rep1_mnpcup_agt(gpio_ne_1p8_fabric1_rep1_mnpcup_agt), 
    .gpio_ne_1p8_fabric1_rep1_mpccup_agt(gpio_ne_1p8_fabric1_rep1_mpccup_agt), 
    .gpio_ne_1p8_fabric1_rep1_tnpput_agt(gpio_ne_1p8_fabric1_rep1_tnpput_agt), 
    .gpio_ne_1p8_fabric1_rep1_tpcput_agt(gpio_ne_1p8_fabric1_rep1_tpcput_agt), 
    .gpio_ne_1p8_fabric1_rep1_teom_agt(gpio_ne_1p8_fabric1_rep1_teom_agt), 
    .gpio_ne_1p8_fabric1_rep1_tpayload_agt(gpio_ne_1p8_fabric1_rep1_tpayload_agt), 
    .gpio_ne_1p8_fabric1_rep1_tparity_agt(gpio_ne_1p8_fabric1_rep1_tparity_agt), 
    .gpio_ne_1p8_fabric1_rep1_side_ism_fabric_agt(gpio_ne_1p8_fabric1_rep1_side_ism_fabric_agt), 
    .gpio_ne_1p8_fabric0_rep2_mnpput_fsa(gpio_ne_1p8_fabric0_rep2_mnpput_fsa), 
    .gpio_ne_1p8_fabric0_rep2_mpcput_fsa(gpio_ne_1p8_fabric0_rep2_mpcput_fsa), 
    .gpio_ne_1p8_fabric0_rep2_meom_fsa(gpio_ne_1p8_fabric0_rep2_meom_fsa), 
    .gpio_ne_1p8_fabric0_rep2_mpayload_fsa(gpio_ne_1p8_fabric0_rep2_mpayload_fsa), 
    .gpio_ne_1p8_fabric0_rep2_mparity_fsa(gpio_ne_1p8_fabric0_rep2_mparity_fsa), 
    .gpio_ne_1p8_fabric0_rep2_tnpcup_fsa(gpio_ne_1p8_fabric0_rep2_tnpcup_fsa), 
    .gpio_ne_1p8_fabric0_rep2_tpccup_fsa(gpio_ne_1p8_fabric0_rep2_tpccup_fsa), 
    .gpio_ne_1p8_fabric0_rep2_side_ism_agent_fsa(gpio_ne_1p8_fabric0_rep2_side_ism_agent_fsa), 
    .gpio_ne_1p8_fabric0_rep2_pok_fsa(gpio_ne_1p8_fabric0_rep2_pok_fsa), 
    .gpio_ne_1p8_out_mnpcup(gpio_ne_1p8_out_mnpcup), 
    .gpio_ne_1p8_out_mpccup(gpio_ne_1p8_out_mpccup), 
    .gpio_ne_1p8_out_tnpput(gpio_ne_1p8_out_tnpput), 
    .gpio_ne_1p8_out_tpcput(gpio_ne_1p8_out_tpcput), 
    .gpio_ne_1p8_out_teom(gpio_ne_1p8_out_teom), 
    .gpio_ne_1p8_out_tpayload(gpio_ne_1p8_out_tpayload), 
    .gpio_ne_1p8_out_tparity(gpio_ne_1p8_out_tparity), 
    .gpio_ne_1p8_out_side_ism_fabric(gpio_ne_1p8_out_side_ism_fabric), 
    .gpio_ne_1p8_out_mnpput(gpio_ne_1p8_out_mnpput), 
    .gpio_ne_1p8_out_mpcput(gpio_ne_1p8_out_mpcput), 
    .gpio_ne_1p8_out_meom(gpio_ne_1p8_out_meom), 
    .gpio_ne_1p8_out_mpayload(gpio_ne_1p8_out_mpayload), 
    .gpio_ne_1p8_out_mparity(gpio_ne_1p8_out_mparity), 
    .gpio_ne_1p8_out_tnpcup(gpio_ne_1p8_out_tnpcup), 
    .gpio_ne_1p8_out_tpccup(gpio_ne_1p8_out_tpccup), 
    .gpio_ne_1p8_out_side_ism_agent(gpio_ne_1p8_out_side_ism_agent), 
    .gpio_ne_1p8_out_pok(gpio_ne_1p8_out_pok), 
    .sb_repeater_adop_infraclk_div4_pdop_par_fabric_s5_clk_clkout(sb_repeater_adop_infraclk_div4_pdop_par_fabric_s5_clk_clkout), 
    .sn2sfi_sn2iosf_dvp_trig_fabric_out(sn2sfi_sn2iosf_dvp_trig_fabric_out), 
    .sn2sfi_sn2iosf_dvp_trig_fabric_in_ack(sn2sfi_sn2iosf_dvp_trig_fabric_in_ack), 
    .sn2iosf_tfb_req_out_agent(sn2iosf_tfb_req_out_agent), 
    .sn2iosf_tfb_ack_out_agent(sn2iosf_tfb_ack_out_agent), 
    .sn2sfi_iosf2sfi_dvp_trig_fabric_out(sn2sfi_iosf2sfi_dvp_trig_fabric_out), 
    .sn2sfi_iosf2sfi_dvp_trig_fabric_in_ack(sn2sfi_iosf2sfi_dvp_trig_fabric_in_ack), 
    .iosf2sfi_tfb_req_out_agent(iosf2sfi_tfb_req_out_agent), 
    .iosf2sfi_tfb_ack_out_agent(iosf2sfi_tfb_ack_out_agent), 
    .hif_pcie_gen6_phy_18a_tfb_req_out_next(hif_pcie_gen6_phy_18a_tfb_req_out_next), 
    .hif_pcie_gen6_phy_18a_tfb_ack_out_next(hif_pcie_gen6_phy_18a_tfb_ack_out_next), 
    .sn2iosf_tfb_req_out_prev(sn2iosf_tfb_req_out_prev), 
    .sn2iosf_tfb_ack_out_prev(sn2iosf_tfb_ack_out_prev), 
    .iosf2sfi_tfb_req_out_next(iosf2sfi_tfb_req_out_next), 
    .iosf2sfi_tfb_ack_out_next(iosf2sfi_tfb_ack_out_next), 
    .dts3_tfb_req_out_prev(dts3_tfb_req_out_prev), 
    .dts3_tfb_ack_out_prev(dts3_tfb_ack_out_prev), 
    .NW_IN_tdo(par_nac_fabric1_NW_IN_tdo), 
    .NW_IN_tdo_en(par_nac_fabric1_NW_IN_tdo_en), 
    .NW_IN_ijtag_reset_b(par_nac_misc_NW_OUT_par_nac_fabric1_ijtag_to_reset), 
    .NW_IN_ijtag_capture(par_nac_misc_NW_OUT_par_nac_fabric1_ijtag_to_ce), 
    .NW_IN_ijtag_shift(par_nac_misc_NW_OUT_par_nac_fabric1_ijtag_to_se), 
    .NW_IN_ijtag_update(par_nac_misc_NW_OUT_par_nac_fabric1_ijtag_to_ue), 
    .NW_IN_ijtag_select(par_nac_misc_NW_OUT_par_nac_fabric1_ijtag_to_sel), 
    .NW_IN_ijtag_si(par_nac_misc_NW_OUT_par_nac_fabric1_ijtag_to_si), 
    .NW_IN_ijtag_so(par_nac_fabric1_NW_IN_ijtag_so), 
    .NW_IN_tap_sel_out(par_nac_fabric1_NW_IN_tap_sel_out), 
    .NW_OUT_par_nac_fabric0_from_tdo(par_nac_fabric0_NW_IN_tdo), 
    .NW_OUT_par_nac_fabric0_from_tdo_en(par_nac_fabric0_NW_IN_tdo_en), 
    .NW_OUT_par_nac_fabric0_ijtag_to_reset(par_nac_fabric1_NW_OUT_par_nac_fabric0_ijtag_to_reset), 
    .NW_OUT_par_nac_fabric0_ijtag_to_ce(par_nac_fabric1_NW_OUT_par_nac_fabric0_ijtag_to_ce), 
    .NW_OUT_par_nac_fabric0_ijtag_to_se(par_nac_fabric1_NW_OUT_par_nac_fabric0_ijtag_to_se), 
    .NW_OUT_par_nac_fabric0_ijtag_to_ue(par_nac_fabric1_NW_OUT_par_nac_fabric0_ijtag_to_ue), 
    .NW_OUT_par_nac_fabric0_ijtag_to_sel(par_nac_fabric1_NW_OUT_par_nac_fabric0_ijtag_to_sel), 
    .NW_OUT_par_nac_fabric0_ijtag_to_si(par_nac_fabric1_NW_OUT_par_nac_fabric0_ijtag_to_si), 
    .NW_OUT_par_nac_fabric0_ijtag_from_so(par_nac_fabric0_NW_IN_ijtag_so), 
    .NW_OUT_par_nac_fabric0_tap_sel_in(par_nac_fabric0_NW_IN_tap_sel_out), 
    .NW_OUT_par_sn2sfi_from_tdo(par_sn2sfi_NW_IN_tdo), 
    .NW_OUT_par_sn2sfi_from_tdo_en(par_sn2sfi_NW_IN_tdo_en), 
    .NW_OUT_par_sn2sfi_ijtag_to_reset(par_nac_fabric1_NW_OUT_par_sn2sfi_ijtag_to_reset), 
    .NW_OUT_par_sn2sfi_ijtag_to_ce(par_nac_fabric1_NW_OUT_par_sn2sfi_ijtag_to_ce), 
    .NW_OUT_par_sn2sfi_ijtag_to_se(par_nac_fabric1_NW_OUT_par_sn2sfi_ijtag_to_se), 
    .NW_OUT_par_sn2sfi_ijtag_to_ue(par_nac_fabric1_NW_OUT_par_sn2sfi_ijtag_to_ue), 
    .NW_OUT_par_sn2sfi_ijtag_to_sel(par_nac_fabric1_NW_OUT_par_sn2sfi_ijtag_to_sel), 
    .NW_OUT_par_sn2sfi_ijtag_to_si(par_nac_fabric1_NW_OUT_par_sn2sfi_ijtag_to_si), 
    .NW_OUT_par_sn2sfi_ijtag_from_so(par_sn2sfi_NW_IN_ijtag_so), 
    .NW_OUT_par_sn2sfi_tap_sel_in(par_sn2sfi_NW_IN_tap_sel_out), 
    .NW_IN_tms(tms), 
    .NW_IN_tck(tck), 
    .NW_IN_tdi(tdi), 
    .NW_IN_trst_b(trst_b), 
    .NW_IN_shift_ir_dr(shift_ir_dr), 
    .NW_IN_tms_park_value(tms_park_value), 
    .NW_IN_nw_mode(nw_mode), 
    .SSN_END_1_bus_data_out(par_nac_fabric1_SSN_END_1_bus_data_out), 
    .SSN_START_0_bus_data_in(par_nac_misc_SSN_END_0_bus_data_out), 
    .SSN_START_0_bus_clock_in(ssn_bus_clock_in), 
    .SSN_START_1_bus_data_in(par_sn2sfi_SSN_END_0_bus_data_out), 
    .SSN_START_1_bus_clock_in(ssn_bus_clock_in), 
    .SSN_START_2_bus_data_in(par_nac_fabric0_SSN_END_0_bus_data_out), 
    .SSN_START_2_bus_clock_in(ssn_bus_clock_in), 
    .SSN_END_2_bus_data_out(par_nac_fabric1_SSN_END_2_bus_data_out), 
    .SSN_END_0_bus_data_out(par_nac_fabric1_SSN_END_0_bus_data_out), 
    .NW_OUT_par_nac_fabric0_to_trst(), 
    .NW_OUT_par_nac_fabric0_to_tck(), 
    .NW_OUT_par_nac_fabric0_to_tms(), 
    .NW_OUT_par_nac_fabric0_to_tdi(), 
    .NW_OUT_par_nac_fabric0_ijtag_to_tck(), 
    .NW_OUT_par_sn2sfi_ijtag_to_tck(), 
    .NW_OUT_par_sn2sfi_to_trst(), 
    .NW_OUT_par_sn2sfi_to_tck(), 
    .NW_OUT_par_sn2sfi_to_tms(), 
    .NW_OUT_par_sn2sfi_to_tdi()
) ; 
par_nac_fabric2 par_nac_fabric2 (
    .dtf_rep_hlp_arb_fab3_fab2_rep0_arbiter2dst_arbiter_0arbiter2arbibert_in_DTFA_ACTIVE(dtf_rep_hlp_arb_fab3_fab2_rep0_arbiter2dst_arbiter_0_DTFA_ACTIVE), 
    .dtf_rep_hlp_arb_fab3_fab2_rep0_arbiter2dst_arbiter_0arbiter2arbibert_in_DTFA_CREDIT(dtf_rep_hlp_arb_fab3_fab2_rep0_arbiter2dst_arbiter_0_DTFA_CREDIT), 
    .dtf_rep_hlp_arb_fab3_fab2_rep0_arbiter2dst_arbiter_0arbiter2arbibert_in_DTFA_SYNC(dtf_rep_hlp_arb_fab3_fab2_rep0_arbiter2dst_arbiter_0_DTFA_SYNC), 
    .dtf_rep_hlp_arb_fab3_fab2_rep0_arbiter2dst_arbiter_0arbiter2arbibert_in_DTFA_DATA(dtf_rep_hlp_arb_fab3_fab2_rep0_arbiter2dst_arbiter_0_DTFA_DATA), 
    .dtf_rep_hlp_arb_fab3_fab2_rep0_arbiter2dst_arbiter_0arbiter2arbibert_in_DTFA_HEADER(dtf_rep_hlp_arb_fab3_fab2_rep0_arbiter2dst_arbiter_0_DTFA_HEADER), 
    .dtf_rep_hlp_arb_fab3_fab2_rep0_arbiter2dst_arbiter_0arbiter2arbibert_in_DTFA_VALID(dtf_rep_hlp_arb_fab3_fab2_rep0_arbiter2dst_arbiter_0_DTFA_VALID), 
    .dtf_rep_fab2_misc_arb0_rep7_arbiter2dst_arbiter_0arbiter2dst_arbiter_DTFA_ACTIVE(dtf_rep_fab2_misc_arb0_rep7_arbiter2dst_arbiter_0_DTFA_ACTIVE), 
    .dtf_rep_fab2_misc_arb0_rep7_arbiter2dst_arbiter_0arbiter2dst_arbiter_DTFA_CREDIT(dtf_rep_fab2_misc_arb0_rep7_arbiter2dst_arbiter_0_DTFA_CREDIT), 
    .dtf_rep_fab2_misc_arb0_rep7_arbiter2dst_arbiter_0arbiter2dst_arbiter_DTFA_SYNC(dtf_rep_fab2_misc_arb0_rep7_arbiter2dst_arbiter_0_DTFA_SYNC), 
    .dtf_rep_fab2_misc_arb0_rep7_arbiter2dst_arbiter_0arbiter2dst_arbiter_DTFA_DATA(dtf_rep_fab2_misc_arb0_rep7_arbiter2dst_arbiter_0_DTFA_DATA), 
    .dtf_rep_fab2_misc_arb0_rep7_arbiter2dst_arbiter_0arbiter2dst_arbiter_DTFA_HEADER(dtf_rep_fab2_misc_arb0_rep7_arbiter2dst_arbiter_0_DTFA_HEADER), 
    .dtf_rep_fab2_misc_arb0_rep7_arbiter2dst_arbiter_0arbiter2dst_arbiter_DTFA_VALID(dtf_rep_fab2_misc_arb0_rep7_arbiter2dst_arbiter_0_DTFA_VALID), 
    .par_nac_misc_adop_xtalclk_clkout(par_nac_misc_par_nac_misc_adop_xtalclk_clkout_fabric2), 
    .par_nac_misc_adop_xtalclk_clkout_out(par_nac_fabric2_par_nac_misc_adop_xtalclk_clkout_out), 
    .par_nac_misc_adop_infra_clk_clkout(par_nac_misc_par_nac_misc_adop_infra_clk_clkout_fabric2), 
    .par_nac_misc_adop_infra_clk_clkout_out(par_nac_fabric2_par_nac_misc_adop_infra_clk_clkout_out), 
    .par_nac_misc_adop_bclk_clkout(par_nac_misc_par_nac_misc_adop_bclk_clkout_0_fabric2), 
    .par_nac_misc_adop_bclk_clkout_out(par_nac_fabric2_par_nac_misc_adop_bclk_clkout_out), 
    .o_clk_cmlclkout_p_ana(cmlbuf51_o_clk_cmlclkout_p_ana), 
    .o_clk_cmlclkout_p_ana_out(par_nac_fabric2_o_clk_cmlclkout_p_ana_out), 
    .o_clk_cmlclkout_n_ana(cmlbuf51_o_clk_cmlclkout_n_ana), 
    .o_clk_cmlclkout_n_ana_out(par_nac_fabric2_o_clk_cmlclkout_n_ana_out), 
    .boot_112p5_rdop_fout2_clkout(par_nac_misc_boot_112p5_rdop_fout2_clkout_fabric2), 
    .boot_112p5_rdop_fout2_clkout_out(par_nac_fabric2_boot_112p5_rdop_fout2_clkout_out), 
    .par_nac_misc_adop_rstbus_clk_clkout(par_nac_misc_par_nac_misc_adop_rstbus_clk_clkout_0_fabric2), 
    .par_nac_misc_adop_rstbus_clk_clkout_out(par_nac_fabric2_par_nac_misc_adop_rstbus_clk_clkout_out), 
    .dfd_dop_enable_sync_o(dfd_dop_enable_sync_o), 
    .eth_physs_rdop_fout3_clkout(par_nac_fabric3_eth_physs_rdop_fout3_clkout), 
    .eth_physs_rdop_fout3_clkout_nac_misc(par_nac_fabric2_eth_physs_rdop_fout3_clkout_nac_misc), 
    .eth_physs_rdop_fout3_clkout_fabric1(par_nac_fabric2_eth_physs_rdop_fout3_clkout_fabric1), 
    .ts_800_rdop_fout0_clkout(par_nac_misc_ts_800_rdop_fout0_clkout_fabric2), 
    .ts_800_rdop_fout0_clkout_out(par_nac_fabric2_ts_800_rdop_fout0_clkout_out), 
    .nac_ss_dtfb_upstream_rst_b(nac_ss_dtfb_upstream_rst_b), 
    .par_nac_fabric2_pdop_dtf_clk_clkout(par_nac_fabric2_pdop_dtf_clk_clkout), 
    .fdfx_pwrgood_rst_b_0(fdfx_pwrgood_rst_b), 
    .fdfx_pwrgood_rst_b(fdfx_pwrgood_rst_b), 
    .dfxagg_security_policy(fdfx_security_policy), 
    .dfxagg_policy_update(fdfx_policy_update), 
    .dfxagg_early_boot_debug_exit(fdfx_earlyboot_debug_exit), 
    .dfxagg_debug_capabilities_enabling(fdfx_debug_capabilities_enabling), 
    .dfxagg_debug_capabilities_enabling_valid(fdfx_debug_capabilities_enabling_valid), 
    .hlp_fabric1_out(hlp_fabric1_out), 
    .hlp_fabric2_out(hlp_fabric2_out), 
    .physs_fabric1_out(physs_fabric1_out), 
    .physs_fabric2_out(physs_fabric2_out), 
    .sb_repeater_eth_pll_mnpcup_agt(sb_repeater_eth_pll_mnpcup_agt), 
    .sb_repeater_eth_pll_mpccup_agt(sb_repeater_eth_pll_mpccup_agt), 
    .sb_repeater_eth_pll_tnpput_agt(sb_repeater_eth_pll_tnpput_agt), 
    .sb_repeater_eth_pll_tpcput_agt(sb_repeater_eth_pll_tpcput_agt), 
    .sb_repeater_eth_pll_teom_agt(sb_repeater_eth_pll_teom_agt), 
    .sb_repeater_eth_pll_tpayload_agt(sb_repeater_eth_pll_tpayload_agt), 
    .sb_repeater_eth_pll_side_ism_fabric_agt(sb_repeater_eth_pll_side_ism_fabric_agt), 
    .rsrc_pll_top_eth_physs_mnpput(rsrc_pll_top_eth_physs_mnpput), 
    .rsrc_pll_top_eth_physs_mpcput(rsrc_pll_top_eth_physs_mpcput), 
    .rsrc_pll_top_eth_physs_meom(rsrc_pll_top_eth_physs_meom), 
    .rsrc_pll_top_eth_physs_mpayload(rsrc_pll_top_eth_physs_mpayload), 
    .rsrc_pll_top_eth_physs_tnpcup(rsrc_pll_top_eth_physs_tnpcup), 
    .rsrc_pll_top_eth_physs_tpccup(rsrc_pll_top_eth_physs_tpccup), 
    .rsrc_pll_top_eth_physs_side_ism_agent(rsrc_pll_top_eth_physs_side_ism_agent), 
    .rsrc_pll_top_eth_physs_side_pok(rsrc_pll_top_eth_physs_side_pok), 
    .sb_repeater_eth_pll_mnpput_fsa(clockss_eth_physs_pll_iosf_sb_mnpput), 
    .sb_repeater_eth_pll_mpcput_fsa(clockss_eth_physs_pll_iosf_sb_mpcput), 
    .sb_repeater_eth_pll_meom_fsa(clockss_eth_physs_pll_iosf_sb_meom), 
    .sb_repeater_eth_pll_mpayload_fsa(clockss_eth_physs_pll_iosf_sb_mpayload), 
    .sb_repeater_eth_pll_tnpcup_fsa(clockss_eth_physs_pll_iosf_sb_tnpcup), 
    .sb_repeater_eth_pll_tpccup_fsa(clockss_eth_physs_pll_iosf_sb_tpccup), 
    .sb_repeater_eth_pll_side_ism_agent_fsa(clockss_eth_physs_pll_iosf_sb_ism_agent), 
    .sb_repeater_eth_pll_pok_fsa(clockss_eth_physs_pll_iosf_sb_side_pok), 
    .clockss_eth_physs_pll_iosf_sb_mnpcup(clockss_eth_physs_pll_iosf_sb_mnpcup), 
    .clockss_eth_physs_pll_iosf_sb_mpccup(clockss_eth_physs_pll_iosf_sb_mpccup), 
    .clockss_eth_physs_pll_iosf_sb_tnpput(clockss_eth_physs_pll_iosf_sb_tnpput), 
    .clockss_eth_physs_pll_iosf_sb_tpcput(clockss_eth_physs_pll_iosf_sb_tpcput), 
    .clockss_eth_physs_pll_iosf_sb_teom(clockss_eth_physs_pll_iosf_sb_teom), 
    .clockss_eth_physs_pll_iosf_sb_tpayload(clockss_eth_physs_pll_iosf_sb_tpayload), 
    .clockss_eth_physs_pll_iosf_sb_ism_fabric(clockss_eth_physs_pll_iosf_sb_ism_fabric), 
    .rstw_pll_top_eth_physs_rstw_ip_side_rst_b_0(rstw_pll_top_eth_physs_rstw_ip_side_rst_b_0), 
    .NW_IN_tdo(par_nac_fabric2_NW_IN_tdo), 
    .NW_IN_tdo_en(par_nac_fabric2_NW_IN_tdo_en), 
    .NW_IN_ijtag_reset_b(par_nac_misc_NW_OUT_par_nac_fabric2_ijtag_to_reset), 
    .NW_IN_ijtag_capture(par_nac_misc_NW_OUT_par_nac_fabric2_ijtag_to_ce), 
    .NW_IN_ijtag_shift(par_nac_misc_NW_OUT_par_nac_fabric2_ijtag_to_se), 
    .NW_IN_ijtag_update(par_nac_misc_NW_OUT_par_nac_fabric2_ijtag_to_ue), 
    .NW_IN_ijtag_select(par_nac_misc_NW_OUT_par_nac_fabric2_ijtag_to_sel), 
    .NW_IN_ijtag_si(par_nac_misc_NW_OUT_par_nac_fabric2_ijtag_to_si), 
    .NW_IN_ijtag_so(par_nac_fabric2_NW_IN_ijtag_so), 
    .NW_IN_tap_sel_out(par_nac_fabric2_NW_IN_tap_sel_out), 
    .NW_IN_tms(tms), 
    .NW_IN_tck(tck), 
    .NW_IN_tdi(tdi), 
    .NW_IN_trst_b(trst_b), 
    .NW_IN_shift_ir_dr(shift_ir_dr), 
    .NW_IN_tms_park_value(tms_park_value), 
    .NW_IN_nw_mode(nw_mode), 
    .NW_OUT_par_nac_fabric3_from_tdo(par_nac_fabric3_NW_IN_tdo), 
    .NW_OUT_par_nac_fabric3_from_tdo_en(par_nac_fabric3_NW_IN_tdo_en), 
    .NW_OUT_par_nac_fabric3_ijtag_to_reset(par_nac_fabric2_NW_OUT_par_nac_fabric3_ijtag_to_reset), 
    .NW_OUT_par_nac_fabric3_ijtag_to_ce(par_nac_fabric2_NW_OUT_par_nac_fabric3_ijtag_to_ce), 
    .NW_OUT_par_nac_fabric3_ijtag_to_se(par_nac_fabric2_NW_OUT_par_nac_fabric3_ijtag_to_se), 
    .NW_OUT_par_nac_fabric3_ijtag_to_ue(par_nac_fabric2_NW_OUT_par_nac_fabric3_ijtag_to_ue), 
    .NW_OUT_par_nac_fabric3_ijtag_to_sel(par_nac_fabric2_NW_OUT_par_nac_fabric3_ijtag_to_sel), 
    .NW_OUT_par_nac_fabric3_ijtag_to_si(par_nac_fabric2_NW_OUT_par_nac_fabric3_ijtag_to_si), 
    .NW_OUT_par_nac_fabric3_ijtag_from_so(par_nac_fabric3_NW_IN_ijtag_so), 
    .NW_OUT_par_nac_fabric3_tap_sel_in(par_nac_fabric3_NW_IN_tap_sel_out), 
    .SSN_START_0_bus_data_in(par_nac_misc_par_nac_misc_par_nac_fabric2_out_end_bus_data_out), 
    .SSN_START_0_bus_clock_in(ssn_bus_clock_in), 
    .SSN_START_1_bus_data_in(par_nac_fabric3_SSN_END_0_bus_data_out), 
    .SSN_START_1_bus_clock_in(ssn_bus_clock_in), 
    .SSN_END_0_bus_data_out(par_nac_fabric2_SSN_END_0_bus_data_out), 
    .SSN_END_1_bus_data_out(par_nac_fabric2_SSN_END_1_bus_data_out), 
    .NW_OUT_par_nac_fabric3_ijtag_to_tck(), 
    .NW_OUT_par_nac_fabric3_to_trst(), 
    .NW_OUT_par_nac_fabric3_to_tck(), 
    .NW_OUT_par_nac_fabric3_to_tms(), 
    .NW_OUT_par_nac_fabric3_to_tdi()
) ; 
par_nac_fabric3 par_nac_fabric3 (
    .dtf_rep_hlp_arb_fab3_fab2_rep0_arbiter2dst_arbiter_0arbiter2dst_arbiter_DTFA_ACTIVE(dtf_rep_hlp_arb_fab3_fab2_rep0_arbiter2dst_arbiter_0_DTFA_ACTIVE), 
    .dtf_rep_hlp_arb_fab3_fab2_rep0_arbiter2dst_arbiter_0arbiter2dst_arbiter_DTFA_CREDIT(dtf_rep_hlp_arb_fab3_fab2_rep0_arbiter2dst_arbiter_0_DTFA_CREDIT), 
    .dtf_rep_hlp_arb_fab3_fab2_rep0_arbiter2dst_arbiter_0arbiter2dst_arbiter_DTFA_SYNC(dtf_rep_hlp_arb_fab3_fab2_rep0_arbiter2dst_arbiter_0_DTFA_SYNC), 
    .dtf_rep_hlp_arb_fab3_fab2_rep0_arbiter2dst_arbiter_0arbiter2dst_arbiter_DTFA_DATA(dtf_rep_hlp_arb_fab3_fab2_rep0_arbiter2dst_arbiter_0_DTFA_DATA), 
    .dtf_rep_hlp_arb_fab3_fab2_rep0_arbiter2dst_arbiter_0arbiter2dst_arbiter_DTFA_HEADER(dtf_rep_hlp_arb_fab3_fab2_rep0_arbiter2dst_arbiter_0_DTFA_HEADER), 
    .dtf_rep_hlp_arb_fab3_fab2_rep0_arbiter2dst_arbiter_0arbiter2dst_arbiter_DTFA_VALID(dtf_rep_hlp_arb_fab3_fab2_rep0_arbiter2dst_arbiter_0_DTFA_VALID), 
    .par_nac_fabric3_physs_mux_end_bus_data_out(par_nac_fabric3_physs_mux_end_bus_data_out), 
    .par_nac_fabric3_physs_mux_start_bus_data_in(par_nac_fabric3_physs_mux_start_bus_data_in), 
    .NW_OUT_physs_from_tdo(physs_tdo), 
    .NW_OUT_physs_from_tdo_en(physs_tdo_en), 
    .NW_OUT_physs_ijtag_to_reset(par_nac_fabric3_NW_OUT_physs_ijtag_to_reset), 
    .NW_OUT_physs_ijtag_to_sel(par_nac_fabric3_NW_OUT_physs_ijtag_to_sel), 
    .NW_OUT_physs_ijtag_to_si(par_nac_fabric3_NW_OUT_physs_ijtag_to_si), 
    .NW_OUT_physs_ijtag_from_so(physs_ijtag_so), 
    .NW_OUT_physs_tap_sel_in(physs_tap_sel_in), 
    .par_nac_fabric3_hlp_mux_end_bus_data_out(par_nac_fabric3_hlp_mux_end_bus_data_out), 
    .par_nac_fabric3_hlp_mux_start_bus_data_in(par_nac_fabric3_hlp_mux_start_bus_data_in), 
    .NW_OUT_hlp_from_tdo(hlp_tdo), 
    .NW_OUT_hlp_from_tdo_en(hlp_tdo_en), 
    .NW_OUT_hlp_ijtag_to_reset(par_nac_fabric3_NW_OUT_hlp_ijtag_to_reset), 
    .NW_OUT_hlp_ijtag_to_sel(par_nac_fabric3_NW_OUT_hlp_ijtag_to_sel), 
    .NW_OUT_hlp_ijtag_to_si(par_nac_fabric3_NW_OUT_hlp_ijtag_to_si), 
    .NW_OUT_hlp_ijtag_from_so(hlp_ijtag_so), 
    .NW_OUT_hlp_tap_sel_in(hlp_tap_sel_in), 
    .clkss_eth_physs_fusa_pll_err_eth_physs(clkss_eth_physs_fusa_pll_err_eth_physs), 
    .boot_112p5_rdop_fout2_clkout_out(par_nac_fabric3_boot_112p5_rdop_fout2_clkout_out), 
    .par_nac_misc_adop_xtalclk_clkout(par_nac_fabric2_par_nac_misc_adop_xtalclk_clkout_out), 
    .par_nac_misc_adop_infra_clk_clkout(par_nac_fabric2_par_nac_misc_adop_infra_clk_clkout_out), 
    .par_nac_misc_adop_bclk_clkout(par_nac_fabric2_par_nac_misc_adop_bclk_clkout_out), 
    .o_clk_cmlclkout_p_ana(par_nac_fabric2_o_clk_cmlclkout_p_ana_out), 
    .o_clk_cmlclkout_p_ana_out(par_nac_fabric3_o_clk_cmlclkout_p_ana_out), 
    .o_clk_cmlclkout_n_ana(par_nac_fabric2_o_clk_cmlclkout_n_ana_out), 
    .o_clk_cmlclkout_n_ana_out(par_nac_fabric3_o_clk_cmlclkout_n_ana_out), 
    .boot_112p5_rdop_fout2_clkout(par_nac_fabric2_boot_112p5_rdop_fout2_clkout_out), 
    .par_nac_misc_adop_rstbus_clk_clkout(par_nac_fabric2_par_nac_misc_adop_rstbus_clk_clkout_out), 
    .eth_physs_rdop_fout3_clkout_0(eth_physs_rdop_fout3_clkout_0), 
    .dfd_dop_enable_sync_o(dfd_dop_enable_sync_o), 
    .nac_pwrgood_rst_b(nac_pwrgood_rst_b), 
    .eth_physs_rdop_fout0_clkout(eth_physs_rdop_fout0_clkout), 
    .eth_physs_rdop_fout1_clkout(eth_physs_rdop_fout1_clkout), 
    .eth_physs_rdop_fout2_clkout(eth_physs_rdop_fout2_clkout), 
    .eth_physs_rdop_fout3_clkout(par_nac_fabric3_eth_physs_rdop_fout3_clkout), 
    .inf_rstbus_rst_b(inf_rstbus_rst_b), 
    .fdfx_pwrgood_rst_b_0(fdfx_pwrgood_rst_b), 
    .reset_cmd_data(reset_cmd_data), 
    .reset_cmd_valid(reset_cmd_valid), 
    .reset_cmd_parity(reset_cmd_parity), 
    .rstw_pll_top_eth_physs_reset_error(rstw_pll_top_eth_physs_reset_error), 
    .rstw_pll_top_eth_physs_reset_cmd_ack(rstw_pll_top_eth_physs_reset_cmd_ack), 
    .rsrc_pll_top_eth_physs_uc_ierr(rsrc_pll_top_eth_physs_uc_ierr), 
    .nac_pllthermtrip_err(nac_pllthermtrip_err), 
    .divmux_socpll_refclk_0(divmux_socpll_refclk_0), 
    .pll_top_eth_physs_prdata(pll_top_eth_physs_prdata), 
    .pll_top_eth_physs_pready(pll_top_eth_physs_pready), 
    .pll_top_eth_physs_pslverr(pll_top_eth_physs_pslverr), 
    .nss_i_nmf_t_cnic_pll_hlp_paddr(nss_i_nmf_t_cnic_pll_hlp_paddr), 
    .nss_i_nmf_t_cnic_pll_hlp_penable(nss_i_nmf_t_cnic_pll_hlp_penable), 
    .nss_i_nmf_t_cnic_pll_hlp_pwrite(nss_i_nmf_t_cnic_pll_hlp_pwrite), 
    .nss_i_nmf_t_cnic_pll_hlp_pwdata(nss_i_nmf_t_cnic_pll_hlp_pwdata), 
    .nss_i_nmf_t_cnic_pll_hlp_psel_0(nss_i_nmf_t_cnic_pll_hlp_psel_0), 
    .eth_physs_rdop_fout5_clkout(eth_physs_rdop_fout5_clkout), 
    .ts_800_rdop_fout0_clkout(par_nac_fabric2_ts_800_rdop_fout0_clkout_out), 
    .ts_800_rdop_fout0_clkout_hlp(par_nac_fabric3_ts_800_rdop_fout0_clkout_hlp), 
    .ts_800_rdop_fout0_clkout_physs(par_nac_fabric3_ts_800_rdop_fout0_clkout_physs), 
    .clk_misc_fusebox_fuse_bus_0(clk_misc_fusebox_fuse_bus_2), 
    .nac_ss_dtfb_upstream_rst_b(nac_ss_dtfb_upstream_rst_b), 
    .dtf_rep_hlp_fab3_arb0_rep0_dtfr_upstream_d0_credit_out(dtf_rep_hlp_fab3_arb0_rep0_dtfr_upstream_d0_credit_out), 
    .dtf_rep_hlp_fab3_arb0_rep0_dtfr_upstream_d0_active_out(dtf_rep_hlp_fab3_arb0_rep0_dtfr_upstream_d0_active_out), 
    .dtf_rep_hlp_fab3_arb0_rep0_dtfr_upstream_d0_sync_out(dtf_rep_hlp_fab3_arb0_rep0_dtfr_upstream_d0_sync_out), 
    .hlp_dtf_dnstream_data_out(hlp_dtf_dnstream_data_out), 
    .hlp_dtf_dnstream_valid_out(hlp_dtf_dnstream_valid_out), 
    .hlp_dtf_dnstream_header_out(hlp_dtf_dnstream_header_out), 
    .socviewpin_32to1digimux_fabric3_0_outmux(socviewpin_32to1digimux_fabric3_0_outmux), 
    .socviewpin_32to1digimux_fabric3_1_outmux(socviewpin_32to1digimux_fabric3_1_outmux), 
    .hlp_dig_view_out_0(hlp_dig_view_out_0), 
    .hlp_dig_view_out_1(hlp_dig_view_out_1), 
    .physs_physs_clkobs_out_clk(physs_physs_clkobs_out_clk), 
    .physs_physs_clkobs_out_clk_0(physs_physs_clkobs_out_clk_0), 
    .nac_ss_debug_safemode_isa_oob(nac_ss_debug_safemode_isa_oob), 
    .fdfx_pwrgood_rst_b(fdfx_pwrgood_rst_b), 
    .dfxagg_security_policy(fdfx_security_policy), 
    .dfxagg_policy_update(fdfx_policy_update), 
    .dfxagg_early_boot_debug_exit(fdfx_earlyboot_debug_exit), 
    .dfxagg_debug_capabilities_enabling(fdfx_debug_capabilities_enabling), 
    .dfxagg_debug_capabilities_enabling_valid(fdfx_debug_capabilities_enabling_valid), 
    .physs_hlp_repeater_hlp_port0_cgmii_rx_c(physs_hlp_repeater_hlp_port0_cgmii_rx_c), 
    .physs_hlp_repeater_hlp_port0_cgmii_rx_data(physs_hlp_repeater_hlp_port0_cgmii_rx_data), 
    .physs_hlp_repeater_hlp_port0_cgmii_rxclk_ena(physs_hlp_repeater_hlp_port0_cgmii_rxclk_ena), 
    .physs_hlp_repeater_hlp_port0_cgmii_rxt0_next(physs_hlp_repeater_hlp_port0_cgmii_rxt0_next), 
    .hlp_hlp_port0_cgmii_tx_c(hlp_hlp_port0_cgmii_tx_c), 
    .hlp_hlp_port0_cgmii_tx_data(hlp_hlp_port0_cgmii_tx_data), 
    .physs_hlp_repeater_hlp_port0_cgmii_txclk_ena(physs_hlp_repeater_hlp_port0_cgmii_txclk_ena), 
    .physs_hlp_repeater_hlp_port0_xlgmii_rx_c(physs_hlp_repeater_hlp_port0_xlgmii_rx_c), 
    .physs_hlp_repeater_hlp_port0_xlgmii_rx_data(physs_hlp_repeater_hlp_port0_xlgmii_rx_data), 
    .physs_hlp_repeater_hlp_port0_xlgmii_rxclk_ena(physs_hlp_repeater_hlp_port0_xlgmii_rxclk_ena), 
    .physs_hlp_repeater_hlp_port0_xlgmii_rxt0_next(physs_hlp_repeater_hlp_port0_xlgmii_rxt0_next), 
    .hlp_hlp_port0_xlgmii_tx_c(hlp_hlp_port0_xlgmii_tx_c), 
    .hlp_hlp_port0_xlgmii_tx_data(hlp_hlp_port0_xlgmii_tx_data), 
    .physs_hlp_repeater_hlp_port0_xlgmii_txclk_ena(physs_hlp_repeater_hlp_port0_xlgmii_txclk_ena), 
    .physs_hlp_repeater_hlp_port10_cgmii_rx_c(physs_hlp_repeater_hlp_port10_cgmii_rx_c), 
    .physs_hlp_repeater_hlp_port10_cgmii_rx_data(physs_hlp_repeater_hlp_port10_cgmii_rx_data), 
    .physs_hlp_repeater_hlp_port10_cgmii_rxclk_ena(physs_hlp_repeater_hlp_port10_cgmii_rxclk_ena), 
    .physs_hlp_repeater_hlp_port10_cgmii_rxt0_next(physs_hlp_repeater_hlp_port10_cgmii_rxt0_next), 
    .hlp_hlp_port10_cgmii_tx_c(hlp_hlp_port10_cgmii_tx_c), 
    .hlp_hlp_port10_cgmii_tx_data(hlp_hlp_port10_cgmii_tx_data), 
    .physs_hlp_repeater_hlp_port10_cgmii_txclk_ena(physs_hlp_repeater_hlp_port10_cgmii_txclk_ena), 
    .physs_hlp_repeater_hlp_port10_desk_rlevel(physs_hlp_repeater_hlp_port10_desk_rlevel), 
    .physs_hlp_repeater_hlp_port10_link_status(physs_hlp_repeater_hlp_port10_link_status), 
    .physs_hlp_repeater_hlp_port10_mii_rx_tsu(physs_hlp_repeater_hlp_port10_mii_rx_tsu), 
    .physs_hlp_repeater_hlp_port10_mii_tx_tsu(physs_hlp_repeater_hlp_port10_mii_tx_tsu), 
    .physs_hlp_repeater_hlp_port10_sd_bit_slip(physs_hlp_repeater_hlp_port10_sd_bit_slip), 
    .physs_hlp_repeater_hlp_port10_tsu_rx_sd(physs_hlp_repeater_hlp_port10_tsu_rx_sd), 
    .physs_hlp_repeater_hlp_port10_xlgmii_rx_c(physs_hlp_repeater_hlp_port10_xlgmii_rx_c), 
    .physs_hlp_repeater_hlp_port10_xlgmii_rx_data(physs_hlp_repeater_hlp_port10_xlgmii_rx_data), 
    .physs_hlp_repeater_hlp_port10_xlgmii_rxclk_ena(physs_hlp_repeater_hlp_port10_xlgmii_rxclk_ena), 
    .physs_hlp_repeater_hlp_port10_xlgmii_rxt0_next(physs_hlp_repeater_hlp_port10_xlgmii_rxt0_next), 
    .hlp_hlp_port10_xlgmii_tx_c(hlp_hlp_port10_xlgmii_tx_c), 
    .hlp_hlp_port10_xlgmii_tx_data(hlp_hlp_port10_xlgmii_tx_data), 
    .physs_hlp_repeater_hlp_port10_xlgmii_txclk_ena(physs_hlp_repeater_hlp_port10_xlgmii_txclk_ena), 
    .physs_hlp_repeater_hlp_port11_cgmii_rx_c(physs_hlp_repeater_hlp_port11_cgmii_rx_c), 
    .physs_hlp_repeater_hlp_port11_cgmii_rx_data(physs_hlp_repeater_hlp_port11_cgmii_rx_data), 
    .physs_hlp_repeater_hlp_port11_cgmii_rxclk_ena(physs_hlp_repeater_hlp_port11_cgmii_rxclk_ena), 
    .physs_hlp_repeater_hlp_port11_cgmii_rxt0_next(physs_hlp_repeater_hlp_port11_cgmii_rxt0_next), 
    .hlp_hlp_port11_cgmii_tx_c(hlp_hlp_port11_cgmii_tx_c), 
    .hlp_hlp_port11_cgmii_tx_data(hlp_hlp_port11_cgmii_tx_data), 
    .physs_hlp_repeater_hlp_port11_cgmii_txclk_ena(physs_hlp_repeater_hlp_port11_cgmii_txclk_ena), 
    .physs_hlp_repeater_hlp_port11_desk_rlevel(physs_hlp_repeater_hlp_port11_desk_rlevel), 
    .physs_hlp_repeater_hlp_port11_link_status(physs_hlp_repeater_hlp_port11_link_status), 
    .physs_hlp_repeater_hlp_port11_mii_rx_tsu(physs_hlp_repeater_hlp_port11_mii_rx_tsu), 
    .physs_hlp_repeater_hlp_port11_mii_tx_tsu(physs_hlp_repeater_hlp_port11_mii_tx_tsu), 
    .physs_hlp_repeater_hlp_port11_sd_bit_slip(physs_hlp_repeater_hlp_port11_sd_bit_slip), 
    .physs_hlp_repeater_hlp_port11_tsu_rx_sd(physs_hlp_repeater_hlp_port11_tsu_rx_sd), 
    .physs_hlp_repeater_hlp_port11_xlgmii_rx_c(physs_hlp_repeater_hlp_port11_xlgmii_rx_c), 
    .physs_hlp_repeater_hlp_port11_xlgmii_rx_data(physs_hlp_repeater_hlp_port11_xlgmii_rx_data), 
    .physs_hlp_repeater_hlp_port11_xlgmii_rxclk_ena(physs_hlp_repeater_hlp_port11_xlgmii_rxclk_ena), 
    .physs_hlp_repeater_hlp_port11_xlgmii_rxt0_next(physs_hlp_repeater_hlp_port11_xlgmii_rxt0_next), 
    .hlp_hlp_port11_xlgmii_tx_c(hlp_hlp_port11_xlgmii_tx_c), 
    .hlp_hlp_port11_xlgmii_tx_data(hlp_hlp_port11_xlgmii_tx_data), 
    .physs_hlp_repeater_hlp_port11_xlgmii_txclk_ena(physs_hlp_repeater_hlp_port11_xlgmii_txclk_ena), 
    .physs_hlp_repeater_hlp_port12_cgmii_rx_c(physs_hlp_repeater_hlp_port12_cgmii_rx_c), 
    .physs_hlp_repeater_hlp_port12_cgmii_rx_data(physs_hlp_repeater_hlp_port12_cgmii_rx_data), 
    .physs_hlp_repeater_hlp_port12_cgmii_rxclk_ena(physs_hlp_repeater_hlp_port12_cgmii_rxclk_ena), 
    .physs_hlp_repeater_hlp_port12_cgmii_rxt0_next(physs_hlp_repeater_hlp_port12_cgmii_rxt0_next), 
    .hlp_hlp_port12_cgmii_tx_c(hlp_hlp_port12_cgmii_tx_c), 
    .hlp_hlp_port12_cgmii_tx_data(hlp_hlp_port12_cgmii_tx_data), 
    .physs_hlp_repeater_hlp_port12_cgmii_txclk_ena(physs_hlp_repeater_hlp_port12_cgmii_txclk_ena), 
    .physs_hlp_repeater_hlp_port12_desk_rlevel(physs_hlp_repeater_hlp_port12_desk_rlevel), 
    .physs_hlp_repeater_hlp_port12_link_status(physs_hlp_repeater_hlp_port12_link_status), 
    .physs_hlp_repeater_hlp_port12_mii_rx_tsu(physs_hlp_repeater_hlp_port12_mii_rx_tsu), 
    .physs_hlp_repeater_hlp_port12_mii_tx_tsu(physs_hlp_repeater_hlp_port12_mii_tx_tsu), 
    .physs_hlp_repeater_hlp_port12_sd_bit_slip(physs_hlp_repeater_hlp_port12_sd_bit_slip), 
    .physs_hlp_repeater_hlp_port12_tsu_rx_sd(physs_hlp_repeater_hlp_port12_tsu_rx_sd), 
    .physs_hlp_repeater_hlp_port12_xlgmii_rx_c(physs_hlp_repeater_hlp_port12_xlgmii_rx_c), 
    .physs_hlp_repeater_hlp_port12_xlgmii_rx_data(physs_hlp_repeater_hlp_port12_xlgmii_rx_data), 
    .physs_hlp_repeater_hlp_port12_xlgmii_rxclk_ena(physs_hlp_repeater_hlp_port12_xlgmii_rxclk_ena), 
    .physs_hlp_repeater_hlp_port12_xlgmii_rxt0_next(physs_hlp_repeater_hlp_port12_xlgmii_rxt0_next), 
    .hlp_hlp_port12_xlgmii_tx_c(hlp_hlp_port12_xlgmii_tx_c), 
    .hlp_hlp_port12_xlgmii_tx_data(hlp_hlp_port12_xlgmii_tx_data), 
    .physs_hlp_repeater_hlp_port12_xlgmii_txclk_ena(physs_hlp_repeater_hlp_port12_xlgmii_txclk_ena), 
    .physs_hlp_repeater_hlp_port13_cgmii_rx_c(physs_hlp_repeater_hlp_port13_cgmii_rx_c), 
    .physs_hlp_repeater_hlp_port13_cgmii_rx_data(physs_hlp_repeater_hlp_port13_cgmii_rx_data), 
    .physs_hlp_repeater_hlp_port13_cgmii_rxclk_ena(physs_hlp_repeater_hlp_port13_cgmii_rxclk_ena), 
    .physs_hlp_repeater_hlp_port13_cgmii_rxt0_next(physs_hlp_repeater_hlp_port13_cgmii_rxt0_next), 
    .hlp_hlp_port13_cgmii_tx_c(hlp_hlp_port13_cgmii_tx_c), 
    .hlp_hlp_port13_cgmii_tx_data(hlp_hlp_port13_cgmii_tx_data), 
    .physs_hlp_repeater_hlp_port13_cgmii_txclk_ena(physs_hlp_repeater_hlp_port13_cgmii_txclk_ena), 
    .physs_hlp_repeater_hlp_port13_desk_rlevel(physs_hlp_repeater_hlp_port13_desk_rlevel), 
    .physs_hlp_repeater_hlp_port13_link_status(physs_hlp_repeater_hlp_port13_link_status), 
    .physs_hlp_repeater_hlp_port13_mii_rx_tsu(physs_hlp_repeater_hlp_port13_mii_rx_tsu), 
    .physs_hlp_repeater_hlp_port13_mii_tx_tsu(physs_hlp_repeater_hlp_port13_mii_tx_tsu), 
    .physs_hlp_repeater_hlp_port13_sd_bit_slip(physs_hlp_repeater_hlp_port13_sd_bit_slip), 
    .physs_hlp_repeater_hlp_port13_tsu_rx_sd(physs_hlp_repeater_hlp_port13_tsu_rx_sd), 
    .physs_hlp_repeater_hlp_port13_xlgmii_rx_c(physs_hlp_repeater_hlp_port13_xlgmii_rx_c), 
    .physs_hlp_repeater_hlp_port13_xlgmii_rx_data(physs_hlp_repeater_hlp_port13_xlgmii_rx_data), 
    .physs_hlp_repeater_hlp_port13_xlgmii_rxclk_ena(physs_hlp_repeater_hlp_port13_xlgmii_rxclk_ena), 
    .physs_hlp_repeater_hlp_port13_xlgmii_rxt0_next(physs_hlp_repeater_hlp_port13_xlgmii_rxt0_next), 
    .hlp_hlp_port13_xlgmii_tx_c(hlp_hlp_port13_xlgmii_tx_c), 
    .hlp_hlp_port13_xlgmii_tx_data(hlp_hlp_port13_xlgmii_tx_data), 
    .physs_hlp_repeater_hlp_port13_xlgmii_txclk_ena(physs_hlp_repeater_hlp_port13_xlgmii_txclk_ena), 
    .physs_hlp_repeater_hlp_port14_cgmii_rx_c(physs_hlp_repeater_hlp_port14_cgmii_rx_c), 
    .physs_hlp_repeater_hlp_port14_cgmii_rx_data(physs_hlp_repeater_hlp_port14_cgmii_rx_data), 
    .physs_hlp_repeater_hlp_port14_cgmii_rxclk_ena(physs_hlp_repeater_hlp_port14_cgmii_rxclk_ena), 
    .physs_hlp_repeater_hlp_port14_cgmii_rxt0_next(physs_hlp_repeater_hlp_port14_cgmii_rxt0_next), 
    .hlp_hlp_port14_cgmii_tx_c(hlp_hlp_port14_cgmii_tx_c), 
    .hlp_hlp_port14_cgmii_tx_data(hlp_hlp_port14_cgmii_tx_data), 
    .physs_hlp_repeater_hlp_port14_cgmii_txclk_ena(physs_hlp_repeater_hlp_port14_cgmii_txclk_ena), 
    .physs_hlp_repeater_hlp_port14_desk_rlevel(physs_hlp_repeater_hlp_port14_desk_rlevel), 
    .physs_hlp_repeater_hlp_port14_link_status(physs_hlp_repeater_hlp_port14_link_status), 
    .physs_hlp_repeater_hlp_port14_mii_rx_tsu(physs_hlp_repeater_hlp_port14_mii_rx_tsu), 
    .physs_hlp_repeater_hlp_port14_mii_tx_tsu(physs_hlp_repeater_hlp_port14_mii_tx_tsu), 
    .physs_hlp_repeater_hlp_port14_sd_bit_slip(physs_hlp_repeater_hlp_port14_sd_bit_slip), 
    .physs_hlp_repeater_hlp_port14_tsu_rx_sd(physs_hlp_repeater_hlp_port14_tsu_rx_sd), 
    .physs_hlp_repeater_hlp_port14_xlgmii_rx_c(physs_hlp_repeater_hlp_port14_xlgmii_rx_c), 
    .physs_hlp_repeater_hlp_port14_xlgmii_rx_data(physs_hlp_repeater_hlp_port14_xlgmii_rx_data), 
    .physs_hlp_repeater_hlp_port14_xlgmii_rxclk_ena(physs_hlp_repeater_hlp_port14_xlgmii_rxclk_ena), 
    .physs_hlp_repeater_hlp_port14_xlgmii_rxt0_next(physs_hlp_repeater_hlp_port14_xlgmii_rxt0_next), 
    .hlp_hlp_port14_xlgmii_tx_c(hlp_hlp_port14_xlgmii_tx_c), 
    .hlp_hlp_port14_xlgmii_tx_data(hlp_hlp_port14_xlgmii_tx_data), 
    .physs_hlp_repeater_hlp_port14_xlgmii_txclk_ena(physs_hlp_repeater_hlp_port14_xlgmii_txclk_ena), 
    .physs_hlp_repeater_hlp_port15_cgmii_rx_c(physs_hlp_repeater_hlp_port15_cgmii_rx_c), 
    .physs_hlp_repeater_hlp_port15_cgmii_rx_data(physs_hlp_repeater_hlp_port15_cgmii_rx_data), 
    .physs_hlp_repeater_hlp_port15_cgmii_rxclk_ena(physs_hlp_repeater_hlp_port15_cgmii_rxclk_ena), 
    .physs_hlp_repeater_hlp_port15_cgmii_rxt0_next(physs_hlp_repeater_hlp_port15_cgmii_rxt0_next), 
    .hlp_hlp_port15_cgmii_tx_c(hlp_hlp_port15_cgmii_tx_c), 
    .hlp_hlp_port15_cgmii_tx_data(hlp_hlp_port15_cgmii_tx_data), 
    .physs_hlp_repeater_hlp_port15_cgmii_txclk_ena(physs_hlp_repeater_hlp_port15_cgmii_txclk_ena), 
    .physs_hlp_repeater_hlp_port15_desk_rlevel(physs_hlp_repeater_hlp_port15_desk_rlevel), 
    .physs_hlp_repeater_hlp_port15_link_status(physs_hlp_repeater_hlp_port15_link_status), 
    .physs_hlp_repeater_hlp_port15_mii_rx_tsu(physs_hlp_repeater_hlp_port15_mii_rx_tsu), 
    .physs_hlp_repeater_hlp_port15_mii_tx_tsu(physs_hlp_repeater_hlp_port15_mii_tx_tsu), 
    .physs_hlp_repeater_hlp_port15_sd_bit_slip(physs_hlp_repeater_hlp_port15_sd_bit_slip), 
    .physs_hlp_repeater_hlp_port15_tsu_rx_sd(physs_hlp_repeater_hlp_port15_tsu_rx_sd), 
    .physs_hlp_repeater_hlp_port15_xlgmii_rx_c(physs_hlp_repeater_hlp_port15_xlgmii_rx_c), 
    .physs_hlp_repeater_hlp_port15_xlgmii_rx_data(physs_hlp_repeater_hlp_port15_xlgmii_rx_data), 
    .physs_hlp_repeater_hlp_port15_xlgmii_rxclk_ena(physs_hlp_repeater_hlp_port15_xlgmii_rxclk_ena), 
    .physs_hlp_repeater_hlp_port15_xlgmii_rxt0_next(physs_hlp_repeater_hlp_port15_xlgmii_rxt0_next), 
    .hlp_hlp_port15_xlgmii_tx_c(hlp_hlp_port15_xlgmii_tx_c), 
    .hlp_hlp_port15_xlgmii_tx_data(hlp_hlp_port15_xlgmii_tx_data), 
    .physs_hlp_repeater_hlp_port15_xlgmii_txclk_ena(physs_hlp_repeater_hlp_port15_xlgmii_txclk_ena), 
    .physs_hlp_repeater_hlp_port16_cgmii_rx_c(physs_hlp_repeater_hlp_port16_cgmii_rx_c), 
    .physs_hlp_repeater_hlp_port16_cgmii_rx_data(physs_hlp_repeater_hlp_port16_cgmii_rx_data), 
    .physs_hlp_repeater_hlp_port16_cgmii_rxclk_ena(physs_hlp_repeater_hlp_port16_cgmii_rxclk_ena), 
    .physs_hlp_repeater_hlp_port16_cgmii_rxt0_next(physs_hlp_repeater_hlp_port16_cgmii_rxt0_next), 
    .hlp_hlp_port16_cgmii_tx_c(hlp_hlp_port16_cgmii_tx_c), 
    .hlp_hlp_port16_cgmii_tx_data(hlp_hlp_port16_cgmii_tx_data), 
    .physs_hlp_repeater_hlp_port16_cgmii_txclk_ena(physs_hlp_repeater_hlp_port16_cgmii_txclk_ena), 
    .physs_hlp_repeater_hlp_port16_desk_rlevel(physs_hlp_repeater_hlp_port16_desk_rlevel), 
    .physs_hlp_repeater_hlp_port16_link_status(physs_hlp_repeater_hlp_port16_link_status), 
    .physs_hlp_repeater_hlp_port16_mii_rx_tsu(physs_hlp_repeater_hlp_port16_mii_rx_tsu), 
    .physs_hlp_repeater_hlp_port16_mii_tx_tsu(physs_hlp_repeater_hlp_port16_mii_tx_tsu), 
    .physs_hlp_repeater_hlp_port16_sd_bit_slip(physs_hlp_repeater_hlp_port16_sd_bit_slip), 
    .physs_hlp_repeater_hlp_port16_tsu_rx_sd(physs_hlp_repeater_hlp_port16_tsu_rx_sd), 
    .physs_hlp_repeater_hlp_port16_xlgmii_rx_c(physs_hlp_repeater_hlp_port16_xlgmii_rx_c), 
    .physs_hlp_repeater_hlp_port16_xlgmii_rx_data(physs_hlp_repeater_hlp_port16_xlgmii_rx_data), 
    .physs_hlp_repeater_hlp_port16_xlgmii_rxclk_ena(physs_hlp_repeater_hlp_port16_xlgmii_rxclk_ena), 
    .physs_hlp_repeater_hlp_port16_xlgmii_rxt0_next(physs_hlp_repeater_hlp_port16_xlgmii_rxt0_next), 
    .hlp_hlp_port16_xlgmii_tx_c(hlp_hlp_port16_xlgmii_tx_c), 
    .hlp_hlp_port16_xlgmii_tx_data(hlp_hlp_port16_xlgmii_tx_data), 
    .physs_hlp_repeater_hlp_port16_xlgmii_txclk_ena(physs_hlp_repeater_hlp_port16_xlgmii_txclk_ena), 
    .physs_hlp_repeater_hlp_port17_cgmii_rx_c(physs_hlp_repeater_hlp_port17_cgmii_rx_c), 
    .physs_hlp_repeater_hlp_port17_cgmii_rx_data(physs_hlp_repeater_hlp_port17_cgmii_rx_data), 
    .physs_hlp_repeater_hlp_port17_cgmii_rxclk_ena(physs_hlp_repeater_hlp_port17_cgmii_rxclk_ena), 
    .physs_hlp_repeater_hlp_port17_cgmii_rxt0_next(physs_hlp_repeater_hlp_port17_cgmii_rxt0_next), 
    .hlp_hlp_port17_cgmii_tx_c(hlp_hlp_port17_cgmii_tx_c), 
    .hlp_hlp_port17_cgmii_tx_data(hlp_hlp_port17_cgmii_tx_data), 
    .physs_hlp_repeater_hlp_port17_cgmii_txclk_ena(physs_hlp_repeater_hlp_port17_cgmii_txclk_ena), 
    .physs_hlp_repeater_hlp_port17_desk_rlevel(physs_hlp_repeater_hlp_port17_desk_rlevel), 
    .physs_hlp_repeater_hlp_port17_link_status(physs_hlp_repeater_hlp_port17_link_status), 
    .physs_hlp_repeater_hlp_port17_mii_rx_tsu(physs_hlp_repeater_hlp_port17_mii_rx_tsu), 
    .physs_hlp_repeater_hlp_port17_mii_tx_tsu(physs_hlp_repeater_hlp_port17_mii_tx_tsu), 
    .physs_hlp_repeater_hlp_port17_sd_bit_slip(physs_hlp_repeater_hlp_port17_sd_bit_slip), 
    .physs_hlp_repeater_hlp_port17_tsu_rx_sd(physs_hlp_repeater_hlp_port17_tsu_rx_sd), 
    .physs_hlp_repeater_hlp_port17_xlgmii_rx_c(physs_hlp_repeater_hlp_port17_xlgmii_rx_c), 
    .physs_hlp_repeater_hlp_port17_xlgmii_rx_data(physs_hlp_repeater_hlp_port17_xlgmii_rx_data), 
    .physs_hlp_repeater_hlp_port17_xlgmii_rxclk_ena(physs_hlp_repeater_hlp_port17_xlgmii_rxclk_ena), 
    .physs_hlp_repeater_hlp_port17_xlgmii_rxt0_next(physs_hlp_repeater_hlp_port17_xlgmii_rxt0_next), 
    .hlp_hlp_port17_xlgmii_tx_c(hlp_hlp_port17_xlgmii_tx_c), 
    .hlp_hlp_port17_xlgmii_tx_data(hlp_hlp_port17_xlgmii_tx_data), 
    .physs_hlp_repeater_hlp_port17_xlgmii_txclk_ena(physs_hlp_repeater_hlp_port17_xlgmii_txclk_ena), 
    .physs_hlp_repeater_hlp_port18_cgmii_rx_c(physs_hlp_repeater_hlp_port18_cgmii_rx_c), 
    .physs_hlp_repeater_hlp_port18_cgmii_rx_data(physs_hlp_repeater_hlp_port18_cgmii_rx_data), 
    .physs_hlp_repeater_hlp_port18_cgmii_rxclk_ena(physs_hlp_repeater_hlp_port18_cgmii_rxclk_ena), 
    .physs_hlp_repeater_hlp_port18_cgmii_rxt0_next(physs_hlp_repeater_hlp_port18_cgmii_rxt0_next), 
    .hlp_hlp_port18_cgmii_tx_c(hlp_hlp_port18_cgmii_tx_c), 
    .hlp_hlp_port18_cgmii_tx_data(hlp_hlp_port18_cgmii_tx_data), 
    .physs_hlp_repeater_hlp_port18_cgmii_txclk_ena(physs_hlp_repeater_hlp_port18_cgmii_txclk_ena), 
    .physs_hlp_repeater_hlp_port18_desk_rlevel(physs_hlp_repeater_hlp_port18_desk_rlevel), 
    .physs_hlp_repeater_hlp_port18_link_status(physs_hlp_repeater_hlp_port18_link_status), 
    .physs_hlp_repeater_hlp_port18_mii_rx_tsu(physs_hlp_repeater_hlp_port18_mii_rx_tsu), 
    .physs_hlp_repeater_hlp_port18_mii_tx_tsu(physs_hlp_repeater_hlp_port18_mii_tx_tsu), 
    .physs_hlp_repeater_hlp_port18_sd_bit_slip(physs_hlp_repeater_hlp_port18_sd_bit_slip), 
    .physs_hlp_repeater_hlp_port18_tsu_rx_sd(physs_hlp_repeater_hlp_port18_tsu_rx_sd), 
    .physs_hlp_repeater_hlp_port18_xlgmii_rx_c(physs_hlp_repeater_hlp_port18_xlgmii_rx_c), 
    .physs_hlp_repeater_hlp_port18_xlgmii_rx_data(physs_hlp_repeater_hlp_port18_xlgmii_rx_data), 
    .physs_hlp_repeater_hlp_port18_xlgmii_rxclk_ena(physs_hlp_repeater_hlp_port18_xlgmii_rxclk_ena), 
    .physs_hlp_repeater_hlp_port18_xlgmii_rxt0_next(physs_hlp_repeater_hlp_port18_xlgmii_rxt0_next), 
    .hlp_hlp_port18_xlgmii_tx_c(hlp_hlp_port18_xlgmii_tx_c), 
    .hlp_hlp_port18_xlgmii_tx_data(hlp_hlp_port18_xlgmii_tx_data), 
    .physs_hlp_repeater_hlp_port18_xlgmii_txclk_ena(physs_hlp_repeater_hlp_port18_xlgmii_txclk_ena), 
    .physs_hlp_repeater_hlp_port19_cgmii_rx_c(physs_hlp_repeater_hlp_port19_cgmii_rx_c), 
    .physs_hlp_repeater_hlp_port19_cgmii_rx_data(physs_hlp_repeater_hlp_port19_cgmii_rx_data), 
    .physs_hlp_repeater_hlp_port19_cgmii_rxclk_ena(physs_hlp_repeater_hlp_port19_cgmii_rxclk_ena), 
    .physs_hlp_repeater_hlp_port19_cgmii_rxt0_next(physs_hlp_repeater_hlp_port19_cgmii_rxt0_next), 
    .hlp_hlp_port19_cgmii_tx_c(hlp_hlp_port19_cgmii_tx_c), 
    .hlp_hlp_port19_cgmii_tx_data(hlp_hlp_port19_cgmii_tx_data), 
    .physs_hlp_repeater_hlp_port19_cgmii_txclk_ena(physs_hlp_repeater_hlp_port19_cgmii_txclk_ena), 
    .physs_hlp_repeater_hlp_port19_desk_rlevel(physs_hlp_repeater_hlp_port19_desk_rlevel), 
    .physs_hlp_repeater_hlp_port19_link_status(physs_hlp_repeater_hlp_port19_link_status), 
    .physs_hlp_repeater_hlp_port19_mii_rx_tsu(physs_hlp_repeater_hlp_port19_mii_rx_tsu), 
    .physs_hlp_repeater_hlp_port19_mii_tx_tsu(physs_hlp_repeater_hlp_port19_mii_tx_tsu), 
    .physs_hlp_repeater_hlp_port19_sd_bit_slip(physs_hlp_repeater_hlp_port19_sd_bit_slip), 
    .physs_hlp_repeater_hlp_port19_tsu_rx_sd(physs_hlp_repeater_hlp_port19_tsu_rx_sd), 
    .physs_hlp_repeater_hlp_port19_xlgmii_rx_c(physs_hlp_repeater_hlp_port19_xlgmii_rx_c), 
    .physs_hlp_repeater_hlp_port19_xlgmii_rx_data(physs_hlp_repeater_hlp_port19_xlgmii_rx_data), 
    .physs_hlp_repeater_hlp_port19_xlgmii_rxclk_ena(physs_hlp_repeater_hlp_port19_xlgmii_rxclk_ena), 
    .physs_hlp_repeater_hlp_port19_xlgmii_rxt0_next(physs_hlp_repeater_hlp_port19_xlgmii_rxt0_next), 
    .hlp_hlp_port19_xlgmii_tx_c(hlp_hlp_port19_xlgmii_tx_c), 
    .hlp_hlp_port19_xlgmii_tx_data(hlp_hlp_port19_xlgmii_tx_data), 
    .physs_hlp_repeater_hlp_port19_xlgmii_txclk_ena(physs_hlp_repeater_hlp_port19_xlgmii_txclk_ena), 
    .physs_hlp_repeater_hlp_port1_cgmii_rx_c(physs_hlp_repeater_hlp_port1_cgmii_rx_c), 
    .physs_hlp_repeater_hlp_port1_cgmii_rx_data(physs_hlp_repeater_hlp_port1_cgmii_rx_data), 
    .physs_hlp_repeater_hlp_port1_cgmii_rxclk_ena(physs_hlp_repeater_hlp_port1_cgmii_rxclk_ena), 
    .physs_hlp_repeater_hlp_port1_cgmii_rxt0_next(physs_hlp_repeater_hlp_port1_cgmii_rxt0_next), 
    .hlp_hlp_port1_cgmii_tx_c(hlp_hlp_port1_cgmii_tx_c), 
    .hlp_hlp_port1_cgmii_tx_data(hlp_hlp_port1_cgmii_tx_data), 
    .physs_hlp_repeater_hlp_port1_cgmii_txclk_ena(physs_hlp_repeater_hlp_port1_cgmii_txclk_ena), 
    .physs_hlp_repeater_hlp_port1_xlgmii_rx_c(physs_hlp_repeater_hlp_port1_xlgmii_rx_c), 
    .physs_hlp_repeater_hlp_port1_xlgmii_rx_data(physs_hlp_repeater_hlp_port1_xlgmii_rx_data), 
    .physs_hlp_repeater_hlp_port1_xlgmii_rxclk_ena(physs_hlp_repeater_hlp_port1_xlgmii_rxclk_ena), 
    .physs_hlp_repeater_hlp_port1_xlgmii_rxt0_next(physs_hlp_repeater_hlp_port1_xlgmii_rxt0_next), 
    .hlp_hlp_port1_xlgmii_tx_c(hlp_hlp_port1_xlgmii_tx_c), 
    .hlp_hlp_port1_xlgmii_tx_data(hlp_hlp_port1_xlgmii_tx_data), 
    .physs_hlp_repeater_hlp_port1_xlgmii_txclk_ena(physs_hlp_repeater_hlp_port1_xlgmii_txclk_ena), 
    .physs_hlp_repeater_hlp_port2_cgmii_rx_c(physs_hlp_repeater_hlp_port2_cgmii_rx_c), 
    .physs_hlp_repeater_hlp_port2_cgmii_rx_data(physs_hlp_repeater_hlp_port2_cgmii_rx_data), 
    .physs_hlp_repeater_hlp_port2_cgmii_rxclk_ena(physs_hlp_repeater_hlp_port2_cgmii_rxclk_ena), 
    .physs_hlp_repeater_hlp_port2_cgmii_rxt0_next(physs_hlp_repeater_hlp_port2_cgmii_rxt0_next), 
    .hlp_hlp_port2_cgmii_tx_c(hlp_hlp_port2_cgmii_tx_c), 
    .hlp_hlp_port2_cgmii_tx_data(hlp_hlp_port2_cgmii_tx_data), 
    .physs_hlp_repeater_hlp_port2_cgmii_txclk_ena(physs_hlp_repeater_hlp_port2_cgmii_txclk_ena), 
    .physs_hlp_repeater_hlp_port2_xlgmii_rx_c(physs_hlp_repeater_hlp_port2_xlgmii_rx_c), 
    .physs_hlp_repeater_hlp_port2_xlgmii_rx_data(physs_hlp_repeater_hlp_port2_xlgmii_rx_data), 
    .physs_hlp_repeater_hlp_port2_xlgmii_rxclk_ena(physs_hlp_repeater_hlp_port2_xlgmii_rxclk_ena), 
    .physs_hlp_repeater_hlp_port2_xlgmii_rxt0_next(physs_hlp_repeater_hlp_port2_xlgmii_rxt0_next), 
    .hlp_hlp_port2_xlgmii_tx_c(hlp_hlp_port2_xlgmii_tx_c), 
    .hlp_hlp_port2_xlgmii_tx_data(hlp_hlp_port2_xlgmii_tx_data), 
    .physs_hlp_repeater_hlp_port2_xlgmii_txclk_ena(physs_hlp_repeater_hlp_port2_xlgmii_txclk_ena), 
    .physs_hlp_repeater_hlp_port3_cgmii_rx_c(physs_hlp_repeater_hlp_port3_cgmii_rx_c), 
    .physs_hlp_repeater_hlp_port3_cgmii_rx_data(physs_hlp_repeater_hlp_port3_cgmii_rx_data), 
    .physs_hlp_repeater_hlp_port3_cgmii_rxclk_ena(physs_hlp_repeater_hlp_port3_cgmii_rxclk_ena), 
    .physs_hlp_repeater_hlp_port3_cgmii_rxt0_next(physs_hlp_repeater_hlp_port3_cgmii_rxt0_next), 
    .hlp_hlp_port3_cgmii_tx_c(hlp_hlp_port3_cgmii_tx_c), 
    .hlp_hlp_port3_cgmii_tx_data(hlp_hlp_port3_cgmii_tx_data), 
    .physs_hlp_repeater_hlp_port3_cgmii_txclk_ena(physs_hlp_repeater_hlp_port3_cgmii_txclk_ena), 
    .physs_hlp_repeater_hlp_port3_xlgmii_rx_c(physs_hlp_repeater_hlp_port3_xlgmii_rx_c), 
    .physs_hlp_repeater_hlp_port3_xlgmii_rx_data(physs_hlp_repeater_hlp_port3_xlgmii_rx_data), 
    .physs_hlp_repeater_hlp_port3_xlgmii_rxclk_ena(physs_hlp_repeater_hlp_port3_xlgmii_rxclk_ena), 
    .physs_hlp_repeater_hlp_port3_xlgmii_rxt0_next(physs_hlp_repeater_hlp_port3_xlgmii_rxt0_next), 
    .hlp_hlp_port3_xlgmii_tx_c(hlp_hlp_port3_xlgmii_tx_c), 
    .hlp_hlp_port3_xlgmii_tx_data(hlp_hlp_port3_xlgmii_tx_data), 
    .physs_hlp_repeater_hlp_port3_xlgmii_txclk_ena(physs_hlp_repeater_hlp_port3_xlgmii_txclk_ena), 
    .physs_hlp_repeater_hlp_port4_cgmii_rx_c(physs_hlp_repeater_hlp_port4_cgmii_rx_c), 
    .physs_hlp_repeater_hlp_port4_cgmii_rx_data(physs_hlp_repeater_hlp_port4_cgmii_rx_data), 
    .physs_hlp_repeater_hlp_port4_cgmii_rxclk_ena(physs_hlp_repeater_hlp_port4_cgmii_rxclk_ena), 
    .physs_hlp_repeater_hlp_port4_cgmii_rxt0_next(physs_hlp_repeater_hlp_port4_cgmii_rxt0_next), 
    .hlp_hlp_port4_cgmii_tx_c(hlp_hlp_port4_cgmii_tx_c), 
    .hlp_hlp_port4_cgmii_tx_data(hlp_hlp_port4_cgmii_tx_data), 
    .physs_hlp_repeater_hlp_port4_cgmii_txclk_ena(physs_hlp_repeater_hlp_port4_cgmii_txclk_ena), 
    .physs_hlp_repeater_hlp_port4_desk_rlevel(physs_hlp_repeater_hlp_port4_desk_rlevel), 
    .physs_hlp_repeater_hlp_port4_link_status(physs_hlp_repeater_hlp_port4_link_status), 
    .physs_hlp_repeater_hlp_port4_mii_rx_tsu(physs_hlp_repeater_hlp_port4_mii_rx_tsu), 
    .physs_hlp_repeater_hlp_port4_mii_tx_tsu(physs_hlp_repeater_hlp_port4_mii_tx_tsu), 
    .physs_hlp_repeater_hlp_port4_sd_bit_slip(physs_hlp_repeater_hlp_port4_sd_bit_slip), 
    .physs_hlp_repeater_hlp_port4_tsu_rx_sd(physs_hlp_repeater_hlp_port4_tsu_rx_sd), 
    .physs_hlp_repeater_hlp_port4_xlgmii_rx_c(physs_hlp_repeater_hlp_port4_xlgmii_rx_c), 
    .physs_hlp_repeater_hlp_port4_xlgmii_rx_data(physs_hlp_repeater_hlp_port4_xlgmii_rx_data), 
    .physs_hlp_repeater_hlp_port4_xlgmii_rxclk_ena(physs_hlp_repeater_hlp_port4_xlgmii_rxclk_ena), 
    .physs_hlp_repeater_hlp_port4_xlgmii_rxt0_next(physs_hlp_repeater_hlp_port4_xlgmii_rxt0_next), 
    .hlp_hlp_port4_xlgmii_tx_c(hlp_hlp_port4_xlgmii_tx_c), 
    .hlp_hlp_port4_xlgmii_tx_data(hlp_hlp_port4_xlgmii_tx_data), 
    .physs_hlp_repeater_hlp_port4_xlgmii_txclk_ena(physs_hlp_repeater_hlp_port4_xlgmii_txclk_ena), 
    .physs_hlp_repeater_hlp_port5_cgmii_rx_c(physs_hlp_repeater_hlp_port5_cgmii_rx_c), 
    .physs_hlp_repeater_hlp_port5_cgmii_rx_data(physs_hlp_repeater_hlp_port5_cgmii_rx_data), 
    .physs_hlp_repeater_hlp_port5_cgmii_rxclk_ena(physs_hlp_repeater_hlp_port5_cgmii_rxclk_ena), 
    .physs_hlp_repeater_hlp_port5_cgmii_rxt0_next(physs_hlp_repeater_hlp_port5_cgmii_rxt0_next), 
    .hlp_hlp_port5_cgmii_tx_c(hlp_hlp_port5_cgmii_tx_c), 
    .hlp_hlp_port5_cgmii_tx_data(hlp_hlp_port5_cgmii_tx_data), 
    .physs_hlp_repeater_hlp_port5_cgmii_txclk_ena(physs_hlp_repeater_hlp_port5_cgmii_txclk_ena), 
    .physs_hlp_repeater_hlp_port5_desk_rlevel(physs_hlp_repeater_hlp_port5_desk_rlevel), 
    .physs_hlp_repeater_hlp_port5_link_status(physs_hlp_repeater_hlp_port5_link_status), 
    .physs_hlp_repeater_hlp_port5_mii_rx_tsu(physs_hlp_repeater_hlp_port5_mii_rx_tsu), 
    .physs_hlp_repeater_hlp_port5_mii_tx_tsu(physs_hlp_repeater_hlp_port5_mii_tx_tsu), 
    .physs_hlp_repeater_hlp_port5_sd_bit_slip(physs_hlp_repeater_hlp_port5_sd_bit_slip), 
    .physs_hlp_repeater_hlp_port5_tsu_rx_sd(physs_hlp_repeater_hlp_port5_tsu_rx_sd), 
    .physs_hlp_repeater_hlp_port5_xlgmii_rx_c(physs_hlp_repeater_hlp_port5_xlgmii_rx_c), 
    .physs_hlp_repeater_hlp_port5_xlgmii_rx_data(physs_hlp_repeater_hlp_port5_xlgmii_rx_data), 
    .physs_hlp_repeater_hlp_port5_xlgmii_rxclk_ena(physs_hlp_repeater_hlp_port5_xlgmii_rxclk_ena), 
    .physs_hlp_repeater_hlp_port5_xlgmii_rxt0_next(physs_hlp_repeater_hlp_port5_xlgmii_rxt0_next), 
    .hlp_hlp_port5_xlgmii_tx_c(hlp_hlp_port5_xlgmii_tx_c), 
    .hlp_hlp_port5_xlgmii_tx_data(hlp_hlp_port5_xlgmii_tx_data), 
    .physs_hlp_repeater_hlp_port5_xlgmii_txclk_ena(physs_hlp_repeater_hlp_port5_xlgmii_txclk_ena), 
    .physs_hlp_repeater_hlp_port6_cgmii_rx_c(physs_hlp_repeater_hlp_port6_cgmii_rx_c), 
    .physs_hlp_repeater_hlp_port6_cgmii_rx_data(physs_hlp_repeater_hlp_port6_cgmii_rx_data), 
    .physs_hlp_repeater_hlp_port6_cgmii_rxclk_ena(physs_hlp_repeater_hlp_port6_cgmii_rxclk_ena), 
    .physs_hlp_repeater_hlp_port6_cgmii_rxt0_next(physs_hlp_repeater_hlp_port6_cgmii_rxt0_next), 
    .hlp_hlp_port6_cgmii_tx_c(hlp_hlp_port6_cgmii_tx_c), 
    .hlp_hlp_port6_cgmii_tx_data(hlp_hlp_port6_cgmii_tx_data), 
    .physs_hlp_repeater_hlp_port6_cgmii_txclk_ena(physs_hlp_repeater_hlp_port6_cgmii_txclk_ena), 
    .physs_hlp_repeater_hlp_port6_desk_rlevel(physs_hlp_repeater_hlp_port6_desk_rlevel), 
    .physs_hlp_repeater_hlp_port6_link_status(physs_hlp_repeater_hlp_port6_link_status), 
    .physs_hlp_repeater_hlp_port6_mii_rx_tsu(physs_hlp_repeater_hlp_port6_mii_rx_tsu), 
    .physs_hlp_repeater_hlp_port6_mii_tx_tsu(physs_hlp_repeater_hlp_port6_mii_tx_tsu), 
    .physs_hlp_repeater_hlp_port6_sd_bit_slip(physs_hlp_repeater_hlp_port6_sd_bit_slip), 
    .physs_hlp_repeater_hlp_port6_tsu_rx_sd(physs_hlp_repeater_hlp_port6_tsu_rx_sd), 
    .physs_hlp_repeater_hlp_port6_xlgmii_rx_c(physs_hlp_repeater_hlp_port6_xlgmii_rx_c), 
    .physs_hlp_repeater_hlp_port6_xlgmii_rx_data(physs_hlp_repeater_hlp_port6_xlgmii_rx_data), 
    .physs_hlp_repeater_hlp_port6_xlgmii_rxclk_ena(physs_hlp_repeater_hlp_port6_xlgmii_rxclk_ena), 
    .physs_hlp_repeater_hlp_port6_xlgmii_rxt0_next(physs_hlp_repeater_hlp_port6_xlgmii_rxt0_next), 
    .hlp_hlp_port6_xlgmii_tx_c(hlp_hlp_port6_xlgmii_tx_c), 
    .hlp_hlp_port6_xlgmii_tx_data(hlp_hlp_port6_xlgmii_tx_data), 
    .physs_hlp_repeater_hlp_port6_xlgmii_txclk_ena(physs_hlp_repeater_hlp_port6_xlgmii_txclk_ena), 
    .physs_hlp_repeater_hlp_port7_cgmii_rx_c(physs_hlp_repeater_hlp_port7_cgmii_rx_c), 
    .physs_hlp_repeater_hlp_port7_cgmii_rx_data(physs_hlp_repeater_hlp_port7_cgmii_rx_data), 
    .physs_hlp_repeater_hlp_port7_cgmii_rxclk_ena(physs_hlp_repeater_hlp_port7_cgmii_rxclk_ena), 
    .physs_hlp_repeater_hlp_port7_cgmii_rxt0_next(physs_hlp_repeater_hlp_port7_cgmii_rxt0_next), 
    .hlp_hlp_port7_cgmii_tx_c(hlp_hlp_port7_cgmii_tx_c), 
    .hlp_hlp_port7_cgmii_tx_data(hlp_hlp_port7_cgmii_tx_data), 
    .physs_hlp_repeater_hlp_port7_cgmii_txclk_ena(physs_hlp_repeater_hlp_port7_cgmii_txclk_ena), 
    .physs_hlp_repeater_hlp_port7_desk_rlevel(physs_hlp_repeater_hlp_port7_desk_rlevel), 
    .physs_hlp_repeater_hlp_port7_link_status(physs_hlp_repeater_hlp_port7_link_status), 
    .physs_hlp_repeater_hlp_port7_mii_rx_tsu(physs_hlp_repeater_hlp_port7_mii_rx_tsu), 
    .physs_hlp_repeater_hlp_port7_mii_tx_tsu(physs_hlp_repeater_hlp_port7_mii_tx_tsu), 
    .physs_hlp_repeater_hlp_port7_sd_bit_slip(physs_hlp_repeater_hlp_port7_sd_bit_slip), 
    .physs_hlp_repeater_hlp_port7_tsu_rx_sd(physs_hlp_repeater_hlp_port7_tsu_rx_sd), 
    .physs_hlp_repeater_hlp_port7_xlgmii_rx_c(physs_hlp_repeater_hlp_port7_xlgmii_rx_c), 
    .physs_hlp_repeater_hlp_port7_xlgmii_rx_data(physs_hlp_repeater_hlp_port7_xlgmii_rx_data), 
    .physs_hlp_repeater_hlp_port7_xlgmii_rxclk_ena(physs_hlp_repeater_hlp_port7_xlgmii_rxclk_ena), 
    .physs_hlp_repeater_hlp_port7_xlgmii_rxt0_next(physs_hlp_repeater_hlp_port7_xlgmii_rxt0_next), 
    .hlp_hlp_port7_xlgmii_tx_c(hlp_hlp_port7_xlgmii_tx_c), 
    .hlp_hlp_port7_xlgmii_tx_data(hlp_hlp_port7_xlgmii_tx_data), 
    .physs_hlp_repeater_hlp_port7_xlgmii_txclk_ena(physs_hlp_repeater_hlp_port7_xlgmii_txclk_ena), 
    .physs_hlp_repeater_hlp_port8_cgmii_rx_c(physs_hlp_repeater_hlp_port8_cgmii_rx_c), 
    .physs_hlp_repeater_hlp_port8_cgmii_rx_data(physs_hlp_repeater_hlp_port8_cgmii_rx_data), 
    .physs_hlp_repeater_hlp_port8_cgmii_rxclk_ena(physs_hlp_repeater_hlp_port8_cgmii_rxclk_ena), 
    .physs_hlp_repeater_hlp_port8_cgmii_rxt0_next(physs_hlp_repeater_hlp_port8_cgmii_rxt0_next), 
    .hlp_hlp_port8_cgmii_tx_c(hlp_hlp_port8_cgmii_tx_c), 
    .hlp_hlp_port8_cgmii_tx_data(hlp_hlp_port8_cgmii_tx_data), 
    .physs_hlp_repeater_hlp_port8_cgmii_txclk_ena(physs_hlp_repeater_hlp_port8_cgmii_txclk_ena), 
    .physs_hlp_repeater_hlp_port8_desk_rlevel(physs_hlp_repeater_hlp_port8_desk_rlevel), 
    .physs_hlp_repeater_hlp_port8_link_status(physs_hlp_repeater_hlp_port8_link_status), 
    .physs_hlp_repeater_hlp_port8_mii_rx_tsu(physs_hlp_repeater_hlp_port8_mii_rx_tsu), 
    .physs_hlp_repeater_hlp_port8_mii_tx_tsu(physs_hlp_repeater_hlp_port8_mii_tx_tsu), 
    .physs_hlp_repeater_hlp_port8_sd_bit_slip(physs_hlp_repeater_hlp_port8_sd_bit_slip), 
    .physs_hlp_repeater_hlp_port8_tsu_rx_sd(physs_hlp_repeater_hlp_port8_tsu_rx_sd), 
    .physs_hlp_repeater_hlp_port8_xlgmii_rx_c(physs_hlp_repeater_hlp_port8_xlgmii_rx_c), 
    .physs_hlp_repeater_hlp_port8_xlgmii_rx_data(physs_hlp_repeater_hlp_port8_xlgmii_rx_data), 
    .physs_hlp_repeater_hlp_port8_xlgmii_rxclk_ena(physs_hlp_repeater_hlp_port8_xlgmii_rxclk_ena), 
    .physs_hlp_repeater_hlp_port8_xlgmii_rxt0_next(physs_hlp_repeater_hlp_port8_xlgmii_rxt0_next), 
    .hlp_hlp_port8_xlgmii_tx_c(hlp_hlp_port8_xlgmii_tx_c), 
    .hlp_hlp_port8_xlgmii_tx_data(hlp_hlp_port8_xlgmii_tx_data), 
    .physs_hlp_repeater_hlp_port8_xlgmii_txclk_ena(physs_hlp_repeater_hlp_port8_xlgmii_txclk_ena), 
    .physs_hlp_repeater_hlp_port9_cgmii_rx_c(physs_hlp_repeater_hlp_port9_cgmii_rx_c), 
    .physs_hlp_repeater_hlp_port9_cgmii_rx_data(physs_hlp_repeater_hlp_port9_cgmii_rx_data), 
    .physs_hlp_repeater_hlp_port9_cgmii_rxclk_ena(physs_hlp_repeater_hlp_port9_cgmii_rxclk_ena), 
    .physs_hlp_repeater_hlp_port9_cgmii_rxt0_next(physs_hlp_repeater_hlp_port9_cgmii_rxt0_next), 
    .hlp_hlp_port9_cgmii_tx_c(hlp_hlp_port9_cgmii_tx_c), 
    .hlp_hlp_port9_cgmii_tx_data(hlp_hlp_port9_cgmii_tx_data), 
    .physs_hlp_repeater_hlp_port9_cgmii_txclk_ena(physs_hlp_repeater_hlp_port9_cgmii_txclk_ena), 
    .physs_hlp_repeater_hlp_port9_desk_rlevel(physs_hlp_repeater_hlp_port9_desk_rlevel), 
    .physs_hlp_repeater_hlp_port9_link_status(physs_hlp_repeater_hlp_port9_link_status), 
    .physs_hlp_repeater_hlp_port9_mii_rx_tsu(physs_hlp_repeater_hlp_port9_mii_rx_tsu), 
    .physs_hlp_repeater_hlp_port9_mii_tx_tsu(physs_hlp_repeater_hlp_port9_mii_tx_tsu), 
    .physs_hlp_repeater_hlp_port9_sd_bit_slip(physs_hlp_repeater_hlp_port9_sd_bit_slip), 
    .physs_hlp_repeater_hlp_port9_tsu_rx_sd(physs_hlp_repeater_hlp_port9_tsu_rx_sd), 
    .physs_hlp_repeater_hlp_port9_xlgmii_rx_c(physs_hlp_repeater_hlp_port9_xlgmii_rx_c), 
    .physs_hlp_repeater_hlp_port9_xlgmii_rx_data(physs_hlp_repeater_hlp_port9_xlgmii_rx_data), 
    .physs_hlp_repeater_hlp_port9_xlgmii_rxclk_ena(physs_hlp_repeater_hlp_port9_xlgmii_rxclk_ena), 
    .physs_hlp_repeater_hlp_port9_xlgmii_rxt0_next(physs_hlp_repeater_hlp_port9_xlgmii_rxt0_next), 
    .hlp_hlp_port9_xlgmii_tx_c(hlp_hlp_port9_xlgmii_tx_c), 
    .hlp_hlp_port9_xlgmii_tx_data(hlp_hlp_port9_xlgmii_tx_data), 
    .physs_hlp_repeater_hlp_port9_xlgmii_txclk_ena(physs_hlp_repeater_hlp_port9_xlgmii_txclk_ena), 
    .physs_hlp_cgmii0_rxc_0(physs_hlp_cgmii0_rxc_0), 
    .physs_hlp_cgmii0_rxc_1(physs_hlp_cgmii0_rxc_1), 
    .physs_hlp_cgmii0_rxc_2(physs_hlp_cgmii0_rxc_2), 
    .physs_hlp_cgmii0_rxc_3(physs_hlp_cgmii0_rxc_3), 
    .physs_hlp_repeater_hlp_cgmii0_rxc_nss_0(physs_hlp_repeater_hlp_cgmii0_rxc_nss_0), 
    .physs_hlp_cgmii0_rxclk_ena_0(physs_hlp_cgmii0_rxclk_ena_0), 
    .physs_hlp_cgmii0_rxclk_ena_1(physs_hlp_cgmii0_rxclk_ena_1), 
    .physs_hlp_cgmii0_rxclk_ena_2(physs_hlp_cgmii0_rxclk_ena_2), 
    .physs_hlp_cgmii0_rxclk_ena_3(physs_hlp_cgmii0_rxclk_ena_3), 
    .physs_hlp_cgmii0_rxd_0(physs_hlp_cgmii0_rxd_0), 
    .physs_hlp_cgmii0_rxd_1(physs_hlp_cgmii0_rxd_1), 
    .physs_hlp_cgmii0_rxd_2(physs_hlp_cgmii0_rxd_2), 
    .physs_hlp_cgmii0_rxd_3(physs_hlp_cgmii0_rxd_3), 
    .physs_hlp_repeater_hlp_cgmii0_rxd_nss_0(physs_hlp_repeater_hlp_cgmii0_rxd_nss_0), 
    .physs_hlp_repeater_hlp_cgmii0_txc_0(physs_hlp_repeater_hlp_cgmii0_txc_0), 
    .physs_hlp_repeater_hlp_cgmii0_txc_1(physs_hlp_repeater_hlp_cgmii0_txc_1), 
    .physs_hlp_repeater_hlp_cgmii0_txc_2(physs_hlp_repeater_hlp_cgmii0_txc_2), 
    .physs_hlp_repeater_hlp_cgmii0_txc_3(physs_hlp_repeater_hlp_cgmii0_txc_3), 
    .physs_hlp_cgmii0_txc_nss_0(physs_hlp_cgmii0_txc_nss_0), 
    .physs_hlp_cgmii0_txclk_ena_0(physs_hlp_cgmii0_txclk_ena_0), 
    .physs_hlp_cgmii0_txclk_ena_1(physs_hlp_cgmii0_txclk_ena_1), 
    .physs_hlp_cgmii0_txclk_ena_2(physs_hlp_cgmii0_txclk_ena_2), 
    .physs_hlp_cgmii0_txclk_ena_3(physs_hlp_cgmii0_txclk_ena_3), 
    .physs_hlp_repeater_hlp_cgmii0_txd_0(physs_hlp_repeater_hlp_cgmii0_txd_0), 
    .physs_hlp_repeater_hlp_cgmii0_txd_1(physs_hlp_repeater_hlp_cgmii0_txd_1), 
    .physs_hlp_repeater_hlp_cgmii0_txd_2(physs_hlp_repeater_hlp_cgmii0_txd_2), 
    .physs_hlp_repeater_hlp_cgmii0_txd_3(physs_hlp_repeater_hlp_cgmii0_txd_3), 
    .physs_hlp_cgmii0_txd_nss_0(physs_hlp_cgmii0_txd_nss_0), 
    .physs_hlp_cgmii1_rxc_0(physs_hlp_cgmii1_rxc_0), 
    .physs_hlp_cgmii1_rxc_1(physs_hlp_cgmii1_rxc_1), 
    .physs_hlp_cgmii1_rxc_2(physs_hlp_cgmii1_rxc_2), 
    .physs_hlp_cgmii1_rxc_3(physs_hlp_cgmii1_rxc_3), 
    .physs_hlp_repeater_hlp_cgmii1_rxc_nss_0(physs_hlp_repeater_hlp_cgmii1_rxc_nss_0), 
    .physs_hlp_cgmii1_rxclk_ena_0(physs_hlp_cgmii1_rxclk_ena_0), 
    .physs_hlp_cgmii1_rxclk_ena_1(physs_hlp_cgmii1_rxclk_ena_1), 
    .physs_hlp_cgmii1_rxclk_ena_2(physs_hlp_cgmii1_rxclk_ena_2), 
    .physs_hlp_cgmii1_rxclk_ena_3(physs_hlp_cgmii1_rxclk_ena_3), 
    .physs_hlp_cgmii1_rxd_0(physs_hlp_cgmii1_rxd_0), 
    .physs_hlp_cgmii1_rxd_1(physs_hlp_cgmii1_rxd_1), 
    .physs_hlp_cgmii1_rxd_2(physs_hlp_cgmii1_rxd_2), 
    .physs_hlp_cgmii1_rxd_3(physs_hlp_cgmii1_rxd_3), 
    .physs_hlp_repeater_hlp_cgmii1_rxd_nss_0(physs_hlp_repeater_hlp_cgmii1_rxd_nss_0), 
    .physs_hlp_repeater_hlp_cgmii1_txc_0(physs_hlp_repeater_hlp_cgmii1_txc_0), 
    .physs_hlp_repeater_hlp_cgmii1_txc_1(physs_hlp_repeater_hlp_cgmii1_txc_1), 
    .physs_hlp_repeater_hlp_cgmii1_txc_2(physs_hlp_repeater_hlp_cgmii1_txc_2), 
    .physs_hlp_repeater_hlp_cgmii1_txc_3(physs_hlp_repeater_hlp_cgmii1_txc_3), 
    .physs_hlp_cgmii1_txc_nss_0(physs_hlp_cgmii1_txc_nss_0), 
    .physs_hlp_cgmii1_txclk_ena_0(physs_hlp_cgmii1_txclk_ena_0), 
    .physs_hlp_cgmii1_txclk_ena_1(physs_hlp_cgmii1_txclk_ena_1), 
    .physs_hlp_cgmii1_txclk_ena_2(physs_hlp_cgmii1_txclk_ena_2), 
    .physs_hlp_cgmii1_txclk_ena_3(physs_hlp_cgmii1_txclk_ena_3), 
    .physs_hlp_repeater_hlp_cgmii1_txd_0(physs_hlp_repeater_hlp_cgmii1_txd_0), 
    .physs_hlp_repeater_hlp_cgmii1_txd_1(physs_hlp_repeater_hlp_cgmii1_txd_1), 
    .physs_hlp_repeater_hlp_cgmii1_txd_2(physs_hlp_repeater_hlp_cgmii1_txd_2), 
    .physs_hlp_repeater_hlp_cgmii1_txd_3(physs_hlp_repeater_hlp_cgmii1_txd_3), 
    .physs_hlp_cgmii1_txd_nss_0(physs_hlp_cgmii1_txd_nss_0), 
    .physs_hlp_cgmii2_rxc_0(physs_hlp_cgmii2_rxc_0), 
    .physs_hlp_cgmii2_rxc_1(physs_hlp_cgmii2_rxc_1), 
    .physs_hlp_cgmii2_rxc_2(physs_hlp_cgmii2_rxc_2), 
    .physs_hlp_cgmii2_rxc_3(physs_hlp_cgmii2_rxc_3), 
    .physs_hlp_repeater_hlp_cgmii2_rxc_nss_0(physs_hlp_repeater_hlp_cgmii2_rxc_nss_0), 
    .physs_hlp_cgmii2_rxclk_ena_0(physs_hlp_cgmii2_rxclk_ena_0), 
    .physs_hlp_cgmii2_rxclk_ena_1(physs_hlp_cgmii2_rxclk_ena_1), 
    .physs_hlp_cgmii2_rxclk_ena_2(physs_hlp_cgmii2_rxclk_ena_2), 
    .physs_hlp_cgmii2_rxclk_ena_3(physs_hlp_cgmii2_rxclk_ena_3), 
    .physs_hlp_cgmii2_rxd_0(physs_hlp_cgmii2_rxd_0), 
    .physs_hlp_cgmii2_rxd_1(physs_hlp_cgmii2_rxd_1), 
    .physs_hlp_cgmii2_rxd_2(physs_hlp_cgmii2_rxd_2), 
    .physs_hlp_cgmii2_rxd_3(physs_hlp_cgmii2_rxd_3), 
    .physs_hlp_repeater_hlp_cgmii2_rxd_nss_0(physs_hlp_repeater_hlp_cgmii2_rxd_nss_0), 
    .physs_hlp_repeater_hlp_cgmii2_txc_0(physs_hlp_repeater_hlp_cgmii2_txc_0), 
    .physs_hlp_repeater_hlp_cgmii2_txc_1(physs_hlp_repeater_hlp_cgmii2_txc_1), 
    .physs_hlp_repeater_hlp_cgmii2_txc_2(physs_hlp_repeater_hlp_cgmii2_txc_2), 
    .physs_hlp_repeater_hlp_cgmii2_txc_3(physs_hlp_repeater_hlp_cgmii2_txc_3), 
    .physs_hlp_cgmii2_txc_nss_0(physs_hlp_cgmii2_txc_nss_0), 
    .physs_hlp_cgmii2_txclk_ena_0(physs_hlp_cgmii2_txclk_ena_0), 
    .physs_hlp_cgmii2_txclk_ena_1(physs_hlp_cgmii2_txclk_ena_1), 
    .physs_hlp_cgmii2_txclk_ena_2(physs_hlp_cgmii2_txclk_ena_2), 
    .physs_hlp_cgmii2_txclk_ena_3(physs_hlp_cgmii2_txclk_ena_3), 
    .physs_hlp_repeater_hlp_cgmii2_txd_0(physs_hlp_repeater_hlp_cgmii2_txd_0), 
    .physs_hlp_repeater_hlp_cgmii2_txd_1(physs_hlp_repeater_hlp_cgmii2_txd_1), 
    .physs_hlp_repeater_hlp_cgmii2_txd_2(physs_hlp_repeater_hlp_cgmii2_txd_2), 
    .physs_hlp_repeater_hlp_cgmii2_txd_3(physs_hlp_repeater_hlp_cgmii2_txd_3), 
    .physs_hlp_cgmii2_txd_nss_0(physs_hlp_cgmii2_txd_nss_0), 
    .physs_hlp_cgmii3_rxc_0(physs_hlp_cgmii3_rxc_0), 
    .physs_hlp_cgmii3_rxc_1(physs_hlp_cgmii3_rxc_1), 
    .physs_hlp_cgmii3_rxc_2(physs_hlp_cgmii3_rxc_2), 
    .physs_hlp_cgmii3_rxc_3(physs_hlp_cgmii3_rxc_3), 
    .physs_hlp_repeater_hlp_cgmii3_rxc_nss_0(physs_hlp_repeater_hlp_cgmii3_rxc_nss_0), 
    .physs_hlp_cgmii3_rxclk_ena_0(physs_hlp_cgmii3_rxclk_ena_0), 
    .physs_hlp_cgmii3_rxclk_ena_1(physs_hlp_cgmii3_rxclk_ena_1), 
    .physs_hlp_cgmii3_rxclk_ena_2(physs_hlp_cgmii3_rxclk_ena_2), 
    .physs_hlp_cgmii3_rxclk_ena_3(physs_hlp_cgmii3_rxclk_ena_3), 
    .physs_hlp_cgmii3_rxd_0(physs_hlp_cgmii3_rxd_0), 
    .physs_hlp_cgmii3_rxd_1(physs_hlp_cgmii3_rxd_1), 
    .physs_hlp_cgmii3_rxd_2(physs_hlp_cgmii3_rxd_2), 
    .physs_hlp_cgmii3_rxd_3(physs_hlp_cgmii3_rxd_3), 
    .physs_hlp_repeater_hlp_cgmii3_rxd_nss_0(physs_hlp_repeater_hlp_cgmii3_rxd_nss_0), 
    .physs_hlp_repeater_hlp_cgmii3_txc_0(physs_hlp_repeater_hlp_cgmii3_txc_0), 
    .physs_hlp_repeater_hlp_cgmii3_txc_1(physs_hlp_repeater_hlp_cgmii3_txc_1), 
    .physs_hlp_repeater_hlp_cgmii3_txc_2(physs_hlp_repeater_hlp_cgmii3_txc_2), 
    .physs_hlp_repeater_hlp_cgmii3_txc_3(physs_hlp_repeater_hlp_cgmii3_txc_3), 
    .physs_hlp_cgmii3_txc_nss_0(physs_hlp_cgmii3_txc_nss_0), 
    .physs_hlp_cgmii3_txclk_ena_0(physs_hlp_cgmii3_txclk_ena_0), 
    .physs_hlp_cgmii3_txclk_ena_1(physs_hlp_cgmii3_txclk_ena_1), 
    .physs_hlp_cgmii3_txclk_ena_2(physs_hlp_cgmii3_txclk_ena_2), 
    .physs_hlp_cgmii3_txclk_ena_3(physs_hlp_cgmii3_txclk_ena_3), 
    .physs_hlp_repeater_hlp_cgmii3_txd_0(physs_hlp_repeater_hlp_cgmii3_txd_0), 
    .physs_hlp_repeater_hlp_cgmii3_txd_1(physs_hlp_repeater_hlp_cgmii3_txd_1), 
    .physs_hlp_repeater_hlp_cgmii3_txd_2(physs_hlp_repeater_hlp_cgmii3_txd_2), 
    .physs_hlp_repeater_hlp_cgmii3_txd_3(physs_hlp_repeater_hlp_cgmii3_txd_3), 
    .physs_hlp_cgmii3_txd_nss_0(physs_hlp_cgmii3_txd_nss_0), 
    .physs_hlp_xlgmii0_rxc_0(physs_hlp_xlgmii0_rxc_0), 
    .physs_hlp_xlgmii0_rxc_1(physs_hlp_xlgmii0_rxc_1), 
    .physs_hlp_xlgmii0_rxc_2(physs_hlp_xlgmii0_rxc_2), 
    .physs_hlp_xlgmii0_rxc_3(physs_hlp_xlgmii0_rxc_3), 
    .physs_hlp_repeater_hlp_xlgmii0_rxc_nss_0(physs_hlp_repeater_hlp_xlgmii0_rxc_nss_0), 
    .physs_hlp_xlgmii0_rxclk_ena_0(physs_hlp_xlgmii0_rxclk_ena_0), 
    .physs_hlp_xlgmii0_rxclk_ena_1(physs_hlp_xlgmii0_rxclk_ena_1), 
    .physs_hlp_xlgmii0_rxclk_ena_2(physs_hlp_xlgmii0_rxclk_ena_2), 
    .physs_hlp_xlgmii0_rxclk_ena_3(physs_hlp_xlgmii0_rxclk_ena_3), 
    .physs_hlp_xlgmii0_rxd_0(physs_hlp_xlgmii0_rxd_0), 
    .physs_hlp_xlgmii0_rxd_1(physs_hlp_xlgmii0_rxd_1), 
    .physs_hlp_xlgmii0_rxd_2(physs_hlp_xlgmii0_rxd_2), 
    .physs_hlp_xlgmii0_rxd_3(physs_hlp_xlgmii0_rxd_3), 
    .physs_hlp_repeater_hlp_xlgmii0_rxd_nss_0(physs_hlp_repeater_hlp_xlgmii0_rxd_nss_0), 
    .physs_hlp_xlgmii0_rxt0_next_0(physs_hlp_xlgmii0_rxt0_next_0), 
    .physs_hlp_xlgmii0_rxt0_next_1(physs_hlp_xlgmii0_rxt0_next_1), 
    .physs_hlp_xlgmii0_rxt0_next_2(physs_hlp_xlgmii0_rxt0_next_2), 
    .physs_hlp_xlgmii0_rxt0_next_3(physs_hlp_xlgmii0_rxt0_next_3), 
    .physs_hlp_repeater_hlp_xlgmii0_txc_0(physs_hlp_repeater_hlp_xlgmii0_txc_0), 
    .physs_hlp_repeater_hlp_xlgmii0_txc_1(physs_hlp_repeater_hlp_xlgmii0_txc_1), 
    .physs_hlp_repeater_hlp_xlgmii0_txc_2(physs_hlp_repeater_hlp_xlgmii0_txc_2), 
    .physs_hlp_repeater_hlp_xlgmii0_txc_3(physs_hlp_repeater_hlp_xlgmii0_txc_3), 
    .physs_hlp_xlgmii0_txc_nss_0(physs_hlp_xlgmii0_txc_nss_0), 
    .physs_hlp_xlgmii0_txclk_ena_0(physs_hlp_xlgmii0_txclk_ena_0), 
    .physs_hlp_xlgmii0_txclk_ena_1(physs_hlp_xlgmii0_txclk_ena_1), 
    .physs_hlp_xlgmii0_txclk_ena_2(physs_hlp_xlgmii0_txclk_ena_2), 
    .physs_hlp_xlgmii0_txclk_ena_3(physs_hlp_xlgmii0_txclk_ena_3), 
    .physs_hlp_repeater_hlp_xlgmii0_txd_0(physs_hlp_repeater_hlp_xlgmii0_txd_0), 
    .physs_hlp_repeater_hlp_xlgmii0_txd_1(physs_hlp_repeater_hlp_xlgmii0_txd_1), 
    .physs_hlp_repeater_hlp_xlgmii0_txd_2(physs_hlp_repeater_hlp_xlgmii0_txd_2), 
    .physs_hlp_repeater_hlp_xlgmii0_txd_3(physs_hlp_repeater_hlp_xlgmii0_txd_3), 
    .physs_hlp_xlgmii0_txd_nss_0(physs_hlp_xlgmii0_txd_nss_0), 
    .physs_hlp_xlgmii1_rxc_0(physs_hlp_xlgmii1_rxc_0), 
    .physs_hlp_xlgmii1_rxc_1(physs_hlp_xlgmii1_rxc_1), 
    .physs_hlp_xlgmii1_rxc_2(physs_hlp_xlgmii1_rxc_2), 
    .physs_hlp_xlgmii1_rxc_3(physs_hlp_xlgmii1_rxc_3), 
    .physs_hlp_repeater_hlp_xlgmii1_rxc_nss_0(physs_hlp_repeater_hlp_xlgmii1_rxc_nss_0), 
    .physs_hlp_xlgmii1_rxclk_ena_0(physs_hlp_xlgmii1_rxclk_ena_0), 
    .physs_hlp_xlgmii1_rxclk_ena_1(physs_hlp_xlgmii1_rxclk_ena_1), 
    .physs_hlp_xlgmii1_rxclk_ena_2(physs_hlp_xlgmii1_rxclk_ena_2), 
    .physs_hlp_xlgmii1_rxclk_ena_3(physs_hlp_xlgmii1_rxclk_ena_3), 
    .physs_hlp_xlgmii1_rxd_0(physs_hlp_xlgmii1_rxd_0), 
    .physs_hlp_xlgmii1_rxd_1(physs_hlp_xlgmii1_rxd_1), 
    .physs_hlp_xlgmii1_rxd_2(physs_hlp_xlgmii1_rxd_2), 
    .physs_hlp_xlgmii1_rxd_3(physs_hlp_xlgmii1_rxd_3), 
    .physs_hlp_repeater_hlp_xlgmii1_rxd_nss_0(physs_hlp_repeater_hlp_xlgmii1_rxd_nss_0), 
    .physs_hlp_xlgmii1_rxt0_next_0(physs_hlp_xlgmii1_rxt0_next_0), 
    .physs_hlp_xlgmii1_rxt0_next_1(physs_hlp_xlgmii1_rxt0_next_1), 
    .physs_hlp_xlgmii1_rxt0_next_2(physs_hlp_xlgmii1_rxt0_next_2), 
    .physs_hlp_xlgmii1_rxt0_next_3(physs_hlp_xlgmii1_rxt0_next_3), 
    .physs_hlp_repeater_hlp_xlgmii1_txc_0(physs_hlp_repeater_hlp_xlgmii1_txc_0), 
    .physs_hlp_repeater_hlp_xlgmii1_txc_1(physs_hlp_repeater_hlp_xlgmii1_txc_1), 
    .physs_hlp_repeater_hlp_xlgmii1_txc_2(physs_hlp_repeater_hlp_xlgmii1_txc_2), 
    .physs_hlp_repeater_hlp_xlgmii1_txc_3(physs_hlp_repeater_hlp_xlgmii1_txc_3), 
    .physs_hlp_xlgmii1_txc_nss_0(physs_hlp_xlgmii1_txc_nss_0), 
    .physs_hlp_xlgmii1_txclk_ena_0(physs_hlp_xlgmii1_txclk_ena_0), 
    .physs_hlp_xlgmii1_txclk_ena_1(physs_hlp_xlgmii1_txclk_ena_1), 
    .physs_hlp_xlgmii1_txclk_ena_2(physs_hlp_xlgmii1_txclk_ena_2), 
    .physs_hlp_xlgmii1_txclk_ena_3(physs_hlp_xlgmii1_txclk_ena_3), 
    .physs_hlp_repeater_hlp_xlgmii1_txd_0(physs_hlp_repeater_hlp_xlgmii1_txd_0), 
    .physs_hlp_repeater_hlp_xlgmii1_txd_1(physs_hlp_repeater_hlp_xlgmii1_txd_1), 
    .physs_hlp_repeater_hlp_xlgmii1_txd_2(physs_hlp_repeater_hlp_xlgmii1_txd_2), 
    .physs_hlp_repeater_hlp_xlgmii1_txd_3(physs_hlp_repeater_hlp_xlgmii1_txd_3), 
    .physs_hlp_xlgmii1_txd_nss_0(physs_hlp_xlgmii1_txd_nss_0), 
    .physs_hlp_xlgmii2_rxc_0(physs_hlp_xlgmii2_rxc_0), 
    .physs_hlp_xlgmii2_rxc_1(physs_hlp_xlgmii2_rxc_1), 
    .physs_hlp_xlgmii2_rxc_2(physs_hlp_xlgmii2_rxc_2), 
    .physs_hlp_xlgmii2_rxc_3(physs_hlp_xlgmii2_rxc_3), 
    .physs_hlp_repeater_hlp_xlgmii2_rxc_nss_0(physs_hlp_repeater_hlp_xlgmii2_rxc_nss_0), 
    .physs_hlp_xlgmii2_rxclk_ena_0(physs_hlp_xlgmii2_rxclk_ena_0), 
    .physs_hlp_xlgmii2_rxclk_ena_1(physs_hlp_xlgmii2_rxclk_ena_1), 
    .physs_hlp_xlgmii2_rxclk_ena_2(physs_hlp_xlgmii2_rxclk_ena_2), 
    .physs_hlp_xlgmii2_rxclk_ena_3(physs_hlp_xlgmii2_rxclk_ena_3), 
    .physs_hlp_xlgmii2_rxd_0(physs_hlp_xlgmii2_rxd_0), 
    .physs_hlp_xlgmii2_rxd_1(physs_hlp_xlgmii2_rxd_1), 
    .physs_hlp_xlgmii2_rxd_2(physs_hlp_xlgmii2_rxd_2), 
    .physs_hlp_xlgmii2_rxd_3(physs_hlp_xlgmii2_rxd_3), 
    .physs_hlp_repeater_hlp_xlgmii2_rxd_nss_0(physs_hlp_repeater_hlp_xlgmii2_rxd_nss_0), 
    .physs_hlp_xlgmii2_rxt0_next_0(physs_hlp_xlgmii2_rxt0_next_0), 
    .physs_hlp_xlgmii2_rxt0_next_1(physs_hlp_xlgmii2_rxt0_next_1), 
    .physs_hlp_xlgmii2_rxt0_next_2(physs_hlp_xlgmii2_rxt0_next_2), 
    .physs_hlp_xlgmii2_rxt0_next_3(physs_hlp_xlgmii2_rxt0_next_3), 
    .physs_hlp_repeater_hlp_xlgmii2_txc_0(physs_hlp_repeater_hlp_xlgmii2_txc_0), 
    .physs_hlp_repeater_hlp_xlgmii2_txc_1(physs_hlp_repeater_hlp_xlgmii2_txc_1), 
    .physs_hlp_repeater_hlp_xlgmii2_txc_2(physs_hlp_repeater_hlp_xlgmii2_txc_2), 
    .physs_hlp_repeater_hlp_xlgmii2_txc_3(physs_hlp_repeater_hlp_xlgmii2_txc_3), 
    .physs_hlp_xlgmii2_txc_nss_0(physs_hlp_xlgmii2_txc_nss_0), 
    .physs_hlp_xlgmii2_txclk_ena_0(physs_hlp_xlgmii2_txclk_ena_0), 
    .physs_hlp_xlgmii2_txclk_ena_1(physs_hlp_xlgmii2_txclk_ena_1), 
    .physs_hlp_xlgmii2_txclk_ena_2(physs_hlp_xlgmii2_txclk_ena_2), 
    .physs_hlp_xlgmii2_txclk_ena_3(physs_hlp_xlgmii2_txclk_ena_3), 
    .physs_hlp_repeater_hlp_xlgmii2_txd_0(physs_hlp_repeater_hlp_xlgmii2_txd_0), 
    .physs_hlp_repeater_hlp_xlgmii2_txd_1(physs_hlp_repeater_hlp_xlgmii2_txd_1), 
    .physs_hlp_repeater_hlp_xlgmii2_txd_2(physs_hlp_repeater_hlp_xlgmii2_txd_2), 
    .physs_hlp_repeater_hlp_xlgmii2_txd_3(physs_hlp_repeater_hlp_xlgmii2_txd_3), 
    .physs_hlp_xlgmii2_txd_nss_0(physs_hlp_xlgmii2_txd_nss_0), 
    .physs_hlp_xlgmii3_rxc_0(physs_hlp_xlgmii3_rxc_0), 
    .physs_hlp_xlgmii3_rxc_1(physs_hlp_xlgmii3_rxc_1), 
    .physs_hlp_xlgmii3_rxc_2(physs_hlp_xlgmii3_rxc_2), 
    .physs_hlp_xlgmii3_rxc_3(physs_hlp_xlgmii3_rxc_3), 
    .physs_hlp_repeater_hlp_xlgmii3_rxc_nss_0(physs_hlp_repeater_hlp_xlgmii3_rxc_nss_0), 
    .physs_hlp_xlgmii3_rxclk_ena_0(physs_hlp_xlgmii3_rxclk_ena_0), 
    .physs_hlp_xlgmii3_rxclk_ena_1(physs_hlp_xlgmii3_rxclk_ena_1), 
    .physs_hlp_xlgmii3_rxclk_ena_2(physs_hlp_xlgmii3_rxclk_ena_2), 
    .physs_hlp_xlgmii3_rxclk_ena_3(physs_hlp_xlgmii3_rxclk_ena_3), 
    .physs_hlp_xlgmii3_rxd_0(physs_hlp_xlgmii3_rxd_0), 
    .physs_hlp_xlgmii3_rxd_1(physs_hlp_xlgmii3_rxd_1), 
    .physs_hlp_xlgmii3_rxd_2(physs_hlp_xlgmii3_rxd_2), 
    .physs_hlp_xlgmii3_rxd_3(physs_hlp_xlgmii3_rxd_3), 
    .physs_hlp_repeater_hlp_xlgmii3_rxd_nss_0(physs_hlp_repeater_hlp_xlgmii3_rxd_nss_0), 
    .physs_hlp_xlgmii3_rxt0_next_0(physs_hlp_xlgmii3_rxt0_next_0), 
    .physs_hlp_xlgmii3_rxt0_next_1(physs_hlp_xlgmii3_rxt0_next_1), 
    .physs_hlp_xlgmii3_rxt0_next_2(physs_hlp_xlgmii3_rxt0_next_2), 
    .physs_hlp_xlgmii3_rxt0_next_3(physs_hlp_xlgmii3_rxt0_next_3), 
    .physs_hlp_repeater_hlp_xlgmii3_txc_0(physs_hlp_repeater_hlp_xlgmii3_txc_0), 
    .physs_hlp_repeater_hlp_xlgmii3_txc_1(physs_hlp_repeater_hlp_xlgmii3_txc_1), 
    .physs_hlp_repeater_hlp_xlgmii3_txc_2(physs_hlp_repeater_hlp_xlgmii3_txc_2), 
    .physs_hlp_repeater_hlp_xlgmii3_txc_3(physs_hlp_repeater_hlp_xlgmii3_txc_3), 
    .physs_hlp_xlgmii3_txc_nss_0(physs_hlp_xlgmii3_txc_nss_0), 
    .physs_hlp_xlgmii3_txclk_ena_0(physs_hlp_xlgmii3_txclk_ena_0), 
    .physs_hlp_xlgmii3_txclk_ena_1(physs_hlp_xlgmii3_txclk_ena_1), 
    .physs_hlp_xlgmii3_txclk_ena_2(physs_hlp_xlgmii3_txclk_ena_2), 
    .physs_hlp_xlgmii3_txclk_ena_3(physs_hlp_xlgmii3_txclk_ena_3), 
    .physs_hlp_repeater_hlp_xlgmii3_txd_0(physs_hlp_repeater_hlp_xlgmii3_txd_0), 
    .physs_hlp_repeater_hlp_xlgmii3_txd_1(physs_hlp_repeater_hlp_xlgmii3_txd_1), 
    .physs_hlp_repeater_hlp_xlgmii3_txd_2(physs_hlp_repeater_hlp_xlgmii3_txd_2), 
    .physs_hlp_repeater_hlp_xlgmii3_txd_3(physs_hlp_repeater_hlp_xlgmii3_txd_3), 
    .physs_hlp_xlgmii3_txd_nss_0(physs_hlp_xlgmii3_txd_nss_0), 
    .physs_mii_rx_tsu_mux(physs_mii_rx_tsu_mux), 
    .physs_mii_tx_tsu(physs_mii_tx_tsu), 
    .physs_pcs_desk_buf_rlevel(physs_pcs_desk_buf_rlevel), 
    .physs_pcs_link_status_tsu(physs_pcs_link_status_tsu), 
    .physs_pcs_sd_bit_slip(physs_pcs_sd_bit_slip), 
    .physs_pcs_tsu_rx_sd(physs_pcs_tsu_rx_sd), 
    .hlp_fabric2_out(hlp_fabric2_out), 
    .hlp_fabric3_out(hlp_fabric3_out), 
    .physs_fabric2_out(physs_fabric2_out), 
    .physs_fabric3_out(physs_fabric3_out), 
    .rsrc_adapt_ethphysspll_fsa_rst_b(rsrc_adapt_ethphysspll_fsa_rst_b), 
    .sb_repeater_eth_pll_mnpcup_agt(sb_repeater_eth_pll_mnpcup_agt), 
    .sb_repeater_eth_pll_mpccup_agt(sb_repeater_eth_pll_mpccup_agt), 
    .sb_repeater_eth_pll_tnpput_agt(sb_repeater_eth_pll_tnpput_agt), 
    .sb_repeater_eth_pll_tpcput_agt(sb_repeater_eth_pll_tpcput_agt), 
    .sb_repeater_eth_pll_teom_agt(sb_repeater_eth_pll_teom_agt), 
    .sb_repeater_eth_pll_tpayload_agt(sb_repeater_eth_pll_tpayload_agt), 
    .sb_repeater_eth_pll_side_ism_fabric_agt(sb_repeater_eth_pll_side_ism_fabric_agt), 
    .rsrc_pll_top_eth_physs_mnpput(rsrc_pll_top_eth_physs_mnpput), 
    .rsrc_pll_top_eth_physs_mpcput(rsrc_pll_top_eth_physs_mpcput), 
    .rsrc_pll_top_eth_physs_meom(rsrc_pll_top_eth_physs_meom), 
    .rsrc_pll_top_eth_physs_mpayload(rsrc_pll_top_eth_physs_mpayload), 
    .rsrc_pll_top_eth_physs_tnpcup(rsrc_pll_top_eth_physs_tnpcup), 
    .rsrc_pll_top_eth_physs_tpccup(rsrc_pll_top_eth_physs_tpccup), 
    .rsrc_pll_top_eth_physs_side_ism_agent(rsrc_pll_top_eth_physs_side_ism_agent), 
    .rsrc_pll_top_eth_physs_side_pok(rsrc_pll_top_eth_physs_side_pok), 
    .rstw_pll_top_eth_physs_rstw_ip_side_rst_b_0(rstw_pll_top_eth_physs_rstw_ip_side_rst_b_0), 
    .hlp_dvp_trig_fabric_out(hlp_dvp_trig_fabric_out), 
    .hlp_dvp_trig_fabric_in_ack(hlp_dvp_trig_fabric_in_ack), 
    .hlp_tfb_req_out_agent(hlp_tfb_req_out_agent), 
    .hlp_tfb_ack_out_agent(hlp_tfb_ack_out_agent), 
    .tfb_ubpc_par_nac_misc_adop_xtalclk_req_out_next(tfb_ubpc_par_nac_misc_adop_xtalclk_req_out_next), 
    .tfb_ubpc_par_nac_misc_adop_xtalclk_ack_out_next(tfb_ubpc_par_nac_misc_adop_xtalclk_ack_out_next), 
    .tfb_ubpc_eth_physs_rdop_fout0_req_out_prev(tfb_ubpc_eth_physs_rdop_fout0_req_out_prev), 
    .tfb_ubpc_eth_physs_rdop_fout0_ack_out_prev(tfb_ubpc_eth_physs_rdop_fout0_ack_out_prev), 
    .eth_visa_tfb_req_out_next(nac_ss_debug_req_out_next), 
    .eth_visa_tfb_ack_out_next(nac_ss_debug_ack_out_next), 
    .nac_ss_debug_req_in_next(nac_ss_debug_req_in_next), 
    .nac_ss_debug_ack_in_next(nac_ss_debug_ack_in_next), 
    .apb_dser_hlp_dvp_pprot(apb_dser_hlp_dvp_pprot), 
    .apb_dser_hlp_dvp_psel(apb_dser_hlp_dvp_psel), 
    .apb_dser_hlp_dvp_penable(apb_dser_hlp_dvp_penable), 
    .apb_dser_hlp_dvp_pwrite(apb_dser_hlp_dvp_pwrite), 
    .apb_dser_hlp_dvp_pwdata(apb_dser_hlp_dvp_pwdata), 
    .apb_dser_hlp_dvp_pstrb(apb_dser_hlp_dvp_pstrb), 
    .apb_dser_hlp_dvp_paddr(apb_dser_hlp_dvp_paddr), 
    .hlp_dvp_pready(hlp_dvp_pready), 
    .hlp_dvp_prdata(hlp_dvp_prdata), 
    .hlp_dvp_pslverr(hlp_dvp_pslverr), 
    .nac_ss_debug_apb_rst_n(nac_ss_debug_apb_rst_n), 
    .apb_dser_cmlbuf_btrs_dvp_serial_chain_out(apb_dser_cmlbuf_btrs_dvp_serial_chain_out), 
    .apb_dser_eth_visa_dvp_serial_chain_out(nac_ss_debug_serializer_hlp_misc_chain_in_from_nac), 
    .NW_IN_tdo(par_nac_fabric3_NW_IN_tdo), 
    .NW_IN_tdo_en(par_nac_fabric3_NW_IN_tdo_en), 
    .NW_IN_ijtag_reset_b(par_nac_fabric2_NW_OUT_par_nac_fabric3_ijtag_to_reset), 
    .NW_IN_ijtag_capture(par_nac_fabric2_NW_OUT_par_nac_fabric3_ijtag_to_ce), 
    .NW_IN_ijtag_shift(par_nac_fabric2_NW_OUT_par_nac_fabric3_ijtag_to_se), 
    .NW_IN_ijtag_update(par_nac_fabric2_NW_OUT_par_nac_fabric3_ijtag_to_ue), 
    .NW_IN_ijtag_select(par_nac_fabric2_NW_OUT_par_nac_fabric3_ijtag_to_sel), 
    .NW_IN_ijtag_si(par_nac_fabric2_NW_OUT_par_nac_fabric3_ijtag_to_si), 
    .NW_IN_ijtag_so(par_nac_fabric3_NW_IN_ijtag_so), 
    .NW_IN_tap_sel_out(par_nac_fabric3_NW_IN_tap_sel_out), 
    .NW_OUT_par_gpio_sw_to_trst(NW_OUT_par_gpio_sw_to_trst), 
    .NW_OUT_par_gpio_sw_to_tck(NW_OUT_par_gpio_sw_to_tck), 
    .NW_OUT_par_gpio_sw_to_tms(NW_OUT_par_gpio_sw_to_tms), 
    .NW_OUT_par_gpio_sw_to_tdi(NW_OUT_par_gpio_sw_to_tdi), 
    .NW_OUT_par_gpio_sw_from_tdo(NW_OUT_par_gpio_sw_from_tdo), 
    .NW_OUT_par_gpio_sw_from_tdo_en(NW_OUT_par_gpio_sw_from_tdo_en), 
    .NW_OUT_par_gpio_sw_tap_sel_in(NW_OUT_par_gpio_sw_tap_sel_in), 
    .NW_OUT_par_gpio_sw_ijtag_to_reset(NW_OUT_par_gpio_sw_ijtag_to_reset), 
    .NW_OUT_par_gpio_sw_ijtag_to_tck(NW_OUT_par_gpio_sw_ijtag_to_tck), 
    .NW_OUT_par_gpio_sw_ijtag_to_ce(NW_OUT_par_gpio_sw_ijtag_to_ce), 
    .NW_OUT_par_gpio_sw_ijtag_to_se(NW_OUT_par_gpio_sw_ijtag_to_se), 
    .NW_OUT_par_gpio_sw_ijtag_to_ue(NW_OUT_par_gpio_sw_ijtag_to_ue), 
    .NW_OUT_par_gpio_sw_ijtag_to_sel(NW_OUT_par_gpio_sw_ijtag_to_sel), 
    .NW_OUT_par_gpio_sw_ijtag_to_si(NW_OUT_par_gpio_sw_ijtag_to_si), 
    .NW_OUT_par_gpio_sw_ijtag_from_so(NW_OUT_par_gpio_sw_ijtag_from_so), 
    .NW_IN_tms(tms), 
    .NW_IN_tck(tck), 
    .NW_IN_tdi(tdi), 
    .NW_IN_trst_b(trst_b), 
    .NW_IN_shift_ir_dr(shift_ir_dr), 
    .NW_IN_tms_park_value(tms_park_value), 
    .NW_IN_nw_mode(nw_mode), 
    .par_nac_fabric3_par_gpio_sw_mux_start_bus_data_in(par_nac_fabric3_par_gpio_sw_mux_start_bus_data_in), 
    .par_nac_fabric3_par_gpio_sw_mux_start_bus_clock_in(ssn_bus_clock_in), 
    .par_nac_fabric3_par_gpio_sw_mux_end_bus_data_out(par_nac_fabric3_par_gpio_sw_mux_end_bus_data_out), 
    .SSN_END_0_bus_data_out(par_nac_fabric3_SSN_END_0_bus_data_out), 
    .SSN_START_0_bus_data_in(par_nac_fabric2_SSN_END_0_bus_data_out), 
    .SSN_START_0_bus_clock_in(ssn_bus_clock_in), 
    .nac_ss_debug_timestamp(nac_ss_debug_timestamp), 
    .par_nac_fabric3_hlp_mux_start_bus_clock_in(1'b0), 
    .par_nac_fabric3_physs_mux_start_bus_clock_in(1'b0), 
    .NW_OUT_hlp_to_trst(), 
    .NW_OUT_hlp_to_tck(), 
    .NW_OUT_hlp_to_tms(), 
    .NW_OUT_hlp_to_tdi(), 
    .NW_OUT_hlp_ijtag_to_tck(), 
    .NW_OUT_hlp_ijtag_to_ce(), 
    .NW_OUT_hlp_ijtag_to_se(), 
    .NW_OUT_hlp_ijtag_to_ue(), 
    .NW_OUT_physs_ijtag_to_tck(), 
    .NW_OUT_physs_ijtag_to_ce(), 
    .NW_OUT_physs_ijtag_to_se(), 
    .NW_OUT_physs_ijtag_to_ue(), 
    .NW_OUT_physs_to_trst(), 
    .NW_OUT_physs_to_tck(), 
    .NW_OUT_physs_to_tms(), 
    .NW_OUT_physs_to_tdi()
) ; 
par_nac_misc par_nac_misc (
    .dtf_rep_fab1_misc_arb0_rep1_arbiter2dst_arbiter_0arbiter2arbibert_in_DTFA_ACTIVE(dtf_rep_fab1_misc_arb0_rep1_arbiter2dst_arbiter_0_DTFA_ACTIVE), 
    .dtf_rep_fab1_misc_arb0_rep1_arbiter2dst_arbiter_0arbiter2arbibert_in_DTFA_CREDIT(dtf_rep_fab1_misc_arb0_rep1_arbiter2dst_arbiter_0_DTFA_CREDIT), 
    .dtf_rep_fab1_misc_arb0_rep1_arbiter2dst_arbiter_0arbiter2arbibert_in_DTFA_SYNC(dtf_rep_fab1_misc_arb0_rep1_arbiter2dst_arbiter_0_DTFA_SYNC), 
    .dtf_rep_fab1_misc_arb0_rep1_arbiter2dst_arbiter_0arbiter2arbibert_in_DTFA_DATA(dtf_rep_fab1_misc_arb0_rep1_arbiter2dst_arbiter_0_DTFA_DATA), 
    .dtf_rep_fab1_misc_arb0_rep1_arbiter2dst_arbiter_0arbiter2arbibert_in_DTFA_HEADER(dtf_rep_fab1_misc_arb0_rep1_arbiter2dst_arbiter_0_DTFA_HEADER), 
    .dtf_rep_fab1_misc_arb0_rep1_arbiter2dst_arbiter_0arbiter2arbibert_in_DTFA_VALID(dtf_rep_fab1_misc_arb0_rep1_arbiter2dst_arbiter_0_DTFA_VALID), 
    .dtf_rep_fab2_misc_arb0_rep7_arbiter2dst_arbiter_0arbiter2arbibert_in_DTFA_ACTIVE(dtf_rep_fab2_misc_arb0_rep7_arbiter2dst_arbiter_0_DTFA_ACTIVE), 
    .dtf_rep_fab2_misc_arb0_rep7_arbiter2dst_arbiter_0arbiter2arbibert_in_DTFA_CREDIT(dtf_rep_fab2_misc_arb0_rep7_arbiter2dst_arbiter_0_DTFA_CREDIT), 
    .dtf_rep_fab2_misc_arb0_rep7_arbiter2dst_arbiter_0arbiter2arbibert_in_DTFA_SYNC(dtf_rep_fab2_misc_arb0_rep7_arbiter2dst_arbiter_0_DTFA_SYNC), 
    .dtf_rep_fab2_misc_arb0_rep7_arbiter2dst_arbiter_0arbiter2arbibert_in_DTFA_DATA(dtf_rep_fab2_misc_arb0_rep7_arbiter2dst_arbiter_0_DTFA_DATA), 
    .dtf_rep_fab2_misc_arb0_rep7_arbiter2dst_arbiter_0arbiter2arbibert_in_DTFA_HEADER(dtf_rep_fab2_misc_arb0_rep7_arbiter2dst_arbiter_0_DTFA_HEADER), 
    .dtf_rep_fab2_misc_arb0_rep7_arbiter2dst_arbiter_0arbiter2arbibert_in_DTFA_VALID(dtf_rep_fab2_misc_arb0_rep7_arbiter2dst_arbiter_0_DTFA_VALID), 
    .ETHPHY_PD0_bisr_chain_si(ETHPHY_PD0_bisr_chain_si), 
    .ETHPHY_PD0_bisr_chain_clk(ETHPHY_PD0_bisr_chain_clk), 
    .ETHPHY_PD0_bisr_chain_rst(ETHPHY_PD0_bisr_chain_rst), 
    .ETHPHY_PD0_bisr_chain_se(ETHPHY_PD0_bisr_chain_se), 
    .ETHPHY_PD0_bisr_chain_so(ETHPHY_PD0_bisr_chain_so), 
    .HLP_PD0_bisr_chain_si(HLP_PD0_bisr_chain_si), 
    .HLP_PD0_bisr_chain_clk(HLP_PD0_bisr_chain_clk), 
    .HLP_PD0_bisr_chain_rst(HLP_PD0_bisr_chain_rst), 
    .HLP_PD0_bisr_chain_se(HLP_PD0_bisr_chain_se), 
    .HLP_PD0_bisr_chain_so(HLP_PD0_bisr_chain_so), 
    .par_nac_misc_pipe_2_nss_out_bus_data_out(par_nac_misc_pipe_2_nss_out_bus_data_out), 
    .par_nac_misc_mux_2__nss_in_start_bus_data_in(par_nac_misc_mux_2__nss_in_start_bus_data_in), 
    .NW_OUT_nss_from_tdo(NW_OUT_nss_from_tdo), 
    .NW_OUT_nss_ijtag_to_reset(par_nac_misc_NW_OUT_nss_ijtag_to_reset), 
    .NW_OUT_nss_ijtag_to_sel(par_nac_misc_NW_OUT_nss_ijtag_to_sel), 
    .NW_OUT_nss_ijtag_to_si(par_nac_misc_NW_OUT_nss_ijtag_to_si), 
    .NW_OUT_nss_ijtag_from_so(nss_nsc_ijtag_nw_so), 
    .NW_OUT_nss_tap_sel_in(nss_nsc_tap_sel_in), 
    .clkss_eth_physs_fusa_pll_err_eth_physs(clkss_eth_physs_fusa_pll_err_eth_physs), 
    .RAS_4_input_OR_out(pll_oa_fusa_comb_error), 
    .axi2sb_gpsb_side_ism_fabric(axi2sb_gpsb_side_ism_fabric), 
    .axi2sb_gpsb_side_ism_agent(axi2sb_gpsb_side_ism_agent), 
    .axi2sb_gpsb_side_pok(axi2sb_gpsb_side_pok), 
    .axi2sb_gpsb_mnpput(axi2sb_gpsb_mnpput), 
    .axi2sb_gpsb_mpcput(axi2sb_gpsb_mpcput), 
    .axi2sb_gpsb_mnpcup(axi2sb_gpsb_mnpcup), 
    .axi2sb_gpsb_mpccup(axi2sb_gpsb_mpccup), 
    .axi2sb_gpsb_meom(axi2sb_gpsb_meom), 
    .axi2sb_gpsb_mpayload(axi2sb_gpsb_mpayload), 
    .axi2sb_gpsb_mparity(axi2sb_gpsb_mparity), 
    .axi2sb_gpsb_tnpput(axi2sb_gpsb_tnpput), 
    .axi2sb_gpsb_tpcput(axi2sb_gpsb_tpcput), 
    .axi2sb_gpsb_tnpcup(axi2sb_gpsb_tnpcup), 
    .axi2sb_gpsb_tpccup(axi2sb_gpsb_tpccup), 
    .axi2sb_gpsb_teom(axi2sb_gpsb_teom), 
    .axi2sb_gpsb_tpayload(axi2sb_gpsb_tpayload), 
    .axi2sb_gpsb_tparity(axi2sb_gpsb_tparity), 
    .axi2sb_gpsb_strap_sourceid(axi2sb_gpsb_strap_sourceid), 
    .axi2sb_strap_sai_secure(axi2sb_strap_sai_secure), 
    .axi2sb_strap_sai_nonsec(axi2sb_strap_sai_nonsec), 
    .axi2sb_gpsb_strap_bridge_disable(axi2sb_gpsb_strap_bridge_disable), 
    .axi2sb_strap_policy1_cp_default(axi2sb_strap_policy1_cp_default), 
    .axi2sb_strap_policy1_rac_default(axi2sb_strap_policy1_rac_default), 
    .axi2sb_strap_policy1_wac_default(axi2sb_strap_policy1_wac_default), 
    .axi2sb_strap_policy2_cp_default(axi2sb_strap_policy2_cp_default), 
    .axi2sb_strap_policy2_rac_default(axi2sb_strap_policy2_rac_default), 
    .axi2sb_strap_policy2_wac_default(axi2sb_strap_policy2_wac_default), 
    .axi2sb_strap_policy3_cp_default(axi2sb_strap_policy3_cp_default), 
    .axi2sb_strap_policy3_rac_default(axi2sb_strap_policy3_rac_default), 
    .axi2sb_strap_policy3_wac_default(axi2sb_strap_policy3_wac_default), 
    .axi2sb_strap_secure_sai_lut_default(axi2sb_strap_secure_sai_lut_default), 
    .axi2sb_strap_cgid_sai_lut_default(axi2sb_strap_cgid_sai_lut_default), 
    .axi2sb_strap_dfd_cgid_default(axi2sb_strap_dfd_cgid_default), 
    .axi2sb_strap_infra_cgid_default(axi2sb_strap_infra_cgid_default), 
    .axi2sb_gpsb_s_awready(axi2sb_gpsb_s_awready), 
    .nss_i_nmf_t_cnic_gpsb_br_AWADDR(nss_i_nmf_t_cnic_gpsb_br_AWADDR), 
    .nss_i_nmf_t_cnic_gpsb_br_AWBURST(nss_i_nmf_t_cnic_gpsb_br_AWBURST), 
    .nss_i_nmf_t_cnic_gpsb_br_AWID(nss_i_nmf_t_cnic_gpsb_br_AWID), 
    .nss_i_nmf_t_cnic_gpsb_br_AWLEN(nss_i_nmf_t_cnic_gpsb_br_AWLEN), 
    .nss_i_nmf_t_cnic_gpsb_br_AWPROT(nss_i_nmf_t_cnic_gpsb_br_AWPROT), 
    .nss_i_nmf_t_cnic_gpsb_br_AWSIZE(nss_i_nmf_t_cnic_gpsb_br_AWSIZE), 
    .nss_i_nmf_t_cnic_gpsb_br_AWVALID(nss_i_nmf_t_cnic_gpsb_br_AWVALID), 
    .axi2sb_gpsb_s_wready(axi2sb_gpsb_s_wready), 
    .nss_i_nmf_t_cnic_gpsb_br_WDATA(nss_i_nmf_t_cnic_gpsb_br_WDATA), 
    .nss_i_nmf_t_cnic_gpsb_br_WLAST(nss_i_nmf_t_cnic_gpsb_br_WLAST), 
    .nss_i_nmf_t_cnic_gpsb_br_WSTRB(nss_i_nmf_t_cnic_gpsb_br_WSTRB), 
    .nss_i_nmf_t_cnic_gpsb_br_WVALID(nss_i_nmf_t_cnic_gpsb_br_WVALID), 
    .axi2sb_gpsb_s_bid(axi2sb_gpsb_s_bid), 
    .axi2sb_gpsb_s_bresp(axi2sb_gpsb_s_bresp), 
    .axi2sb_gpsb_s_bvalid(axi2sb_gpsb_s_bvalid), 
    .nss_i_nmf_t_cnic_gpsb_br_BREADY(nss_i_nmf_t_cnic_gpsb_br_BREADY), 
    .axi2sb_gpsb_s_arready(axi2sb_gpsb_s_arready), 
    .nss_i_nmf_t_cnic_gpsb_br_ARADDR(nss_i_nmf_t_cnic_gpsb_br_ARADDR), 
    .nss_i_nmf_t_cnic_gpsb_br_ARBURST(nss_i_nmf_t_cnic_gpsb_br_ARBURST), 
    .nss_i_nmf_t_cnic_gpsb_br_ARID(nss_i_nmf_t_cnic_gpsb_br_ARID), 
    .nss_i_nmf_t_cnic_gpsb_br_ARLEN(nss_i_nmf_t_cnic_gpsb_br_ARLEN), 
    .nss_i_nmf_t_cnic_gpsb_br_ARPROT(nss_i_nmf_t_cnic_gpsb_br_ARPROT), 
    .nss_i_nmf_t_cnic_gpsb_br_ARSIZE(nss_i_nmf_t_cnic_gpsb_br_ARSIZE), 
    .nss_i_nmf_t_cnic_gpsb_br_ARVALID(nss_i_nmf_t_cnic_gpsb_br_ARVALID), 
    .axi2sb_gpsb_s_rid(axi2sb_gpsb_s_rid), 
    .axi2sb_gpsb_s_rdata(axi2sb_gpsb_s_rdata), 
    .axi2sb_gpsb_s_rresp(axi2sb_gpsb_s_rresp), 
    .axi2sb_gpsb_s_rlast(axi2sb_gpsb_s_rlast), 
    .axi2sb_gpsb_s_rvalid(axi2sb_gpsb_s_rvalid), 
    .nss_i_nmf_t_cnic_gpsb_br_RREADY(nss_i_nmf_t_cnic_gpsb_br_RREADY), 
    .axi2sb_gpsb_m_awid(axi2sb_gpsb_m_awid), 
    .axi2sb_gpsb_m_awaddr(axi2sb_gpsb_m_awaddr), 
    .axi2sb_gpsb_m_awlen(axi2sb_gpsb_m_awlen), 
    .axi2sb_gpsb_m_awuser(axi2sb_gpsb_m_awuser), 
    .axi2sb_gpsb_m_awsize(axi2sb_gpsb_m_awsize), 
    .axi2sb_gpsb_m_awburst(axi2sb_gpsb_m_awburst), 
    .axi2sb_gpsb_m_awprot(axi2sb_gpsb_m_awprot), 
    .axi2sb_gpsb_m_awvalid(axi2sb_gpsb_m_awvalid), 
    .nss_t_nmf_i_cnic_gpsb_AWREADY(nss_t_nmf_i_cnic_gpsb_AWREADY), 
    .axi2sb_gpsb_m_wdata(axi2sb_gpsb_m_wdata), 
    .axi2sb_gpsb_m_wstrb(axi2sb_gpsb_m_wstrb), 
    .axi2sb_gpsb_m_wlast(axi2sb_gpsb_m_wlast), 
    .axi2sb_gpsb_m_wvalid(axi2sb_gpsb_m_wvalid), 
    .nss_t_nmf_i_cnic_gpsb_WREADY(nss_t_nmf_i_cnic_gpsb_WREADY), 
    .axi2sb_gpsb_m_bready(axi2sb_gpsb_m_bready), 
    .nss_t_nmf_i_cnic_gpsb_BID(nss_t_nmf_i_cnic_gpsb_BID), 
    .nss_t_nmf_i_cnic_gpsb_BRESP(nss_t_nmf_i_cnic_gpsb_BRESP), 
    .nss_t_nmf_i_cnic_gpsb_BVALID(nss_t_nmf_i_cnic_gpsb_BVALID), 
    .axi2sb_gpsb_m_arid(axi2sb_gpsb_m_arid), 
    .axi2sb_gpsb_m_araddr(axi2sb_gpsb_m_araddr), 
    .axi2sb_gpsb_m_arlen(axi2sb_gpsb_m_arlen), 
    .axi2sb_gpsb_m_aruser(axi2sb_gpsb_m_aruser), 
    .axi2sb_gpsb_m_arsize(axi2sb_gpsb_m_arsize), 
    .axi2sb_gpsb_m_arburst(axi2sb_gpsb_m_arburst), 
    .axi2sb_gpsb_m_arprot(axi2sb_gpsb_m_arprot), 
    .axi2sb_gpsb_m_arvalid(axi2sb_gpsb_m_arvalid), 
    .nss_t_nmf_i_cnic_gpsb_ARREADY(nss_t_nmf_i_cnic_gpsb_ARREADY), 
    .axi2sb_gpsb_m_rready(axi2sb_gpsb_m_rready), 
    .nss_t_nmf_i_cnic_gpsb_RDATA(nss_t_nmf_i_cnic_gpsb_RDATA), 
    .nss_t_nmf_i_cnic_gpsb_RID(nss_t_nmf_i_cnic_gpsb_RID), 
    .nss_t_nmf_i_cnic_gpsb_RLAST(nss_t_nmf_i_cnic_gpsb_RLAST), 
    .nss_t_nmf_i_cnic_gpsb_RRESP(nss_t_nmf_i_cnic_gpsb_RRESP), 
    .nss_t_nmf_i_cnic_gpsb_RVALID(nss_t_nmf_i_cnic_gpsb_RVALID), 
    .nss_reset_fabric_n(nss_reset_fabric_n), 
    .nss_nsc_soc_imcr_qreqn(nss_nsc_soc_imcr_qreqn), 
    .axi2sb_pmsb_side_ism_fabric(axi2sb_pmsb_side_ism_fabric), 
    .axi2sb_pmsb_side_ism_agent(axi2sb_pmsb_side_ism_agent), 
    .axi2sb_pmsb_side_pok(axi2sb_pmsb_side_pok), 
    .axi2sb_pmsb_mnpput(axi2sb_pmsb_mnpput), 
    .axi2sb_pmsb_mpcput(axi2sb_pmsb_mpcput), 
    .axi2sb_pmsb_mnpcup(axi2sb_pmsb_mnpcup), 
    .axi2sb_pmsb_mpccup(axi2sb_pmsb_mpccup), 
    .axi2sb_pmsb_meom(axi2sb_pmsb_meom), 
    .axi2sb_pmsb_mpayload(axi2sb_pmsb_mpayload), 
    .axi2sb_pmsb_mparity(axi2sb_pmsb_mparity), 
    .axi2sb_pmsb_tnpput(axi2sb_pmsb_tnpput), 
    .axi2sb_pmsb_tpcput(axi2sb_pmsb_tpcput), 
    .axi2sb_pmsb_tnpcup(axi2sb_pmsb_tnpcup), 
    .axi2sb_pmsb_tpccup(axi2sb_pmsb_tpccup), 
    .axi2sb_pmsb_teom(axi2sb_pmsb_teom), 
    .axi2sb_pmsb_tpayload(axi2sb_pmsb_tpayload), 
    .axi2sb_pmsb_tparity(axi2sb_pmsb_tparity), 
    .axi2sb_pmsb_strap_sourceid(axi2sb_pmsb_strap_sourceid), 
    .axi2sb_pmsb_strap_sai_pmsb_default(axi2sb_pmsb_strap_sai_pmsb_default), 
    .axi2sb_pmsb_strap_bridge_disable(axi2sb_pmsb_strap_bridge_disable), 
    .axi2sb_pmsb_s_awready(axi2sb_pmsb_s_awready), 
    .nss_i_nmf_t_cnic_pmsb_br_AWADDR(nss_i_nmf_t_cnic_pmsb_br_AWADDR), 
    .nss_i_nmf_t_cnic_pmsb_br_AWBURST(nss_i_nmf_t_cnic_pmsb_br_AWBURST), 
    .nss_i_nmf_t_cnic_pmsb_br_AWID(nss_i_nmf_t_cnic_pmsb_br_AWID), 
    .nss_i_nmf_t_cnic_pmsb_br_AWLEN(nss_i_nmf_t_cnic_pmsb_br_AWLEN), 
    .nss_i_nmf_t_cnic_pmsb_br_AWPROT(nss_i_nmf_t_cnic_pmsb_br_AWPROT), 
    .nss_i_nmf_t_cnic_pmsb_br_AWSIZE(nss_i_nmf_t_cnic_pmsb_br_AWSIZE), 
    .nss_i_nmf_t_cnic_pmsb_br_AWVALID(nss_i_nmf_t_cnic_pmsb_br_AWVALID), 
    .axi2sb_pmsb_s_wready(axi2sb_pmsb_s_wready), 
    .nss_i_nmf_t_cnic_pmsb_br_WDATA(nss_i_nmf_t_cnic_pmsb_br_WDATA), 
    .nss_i_nmf_t_cnic_pmsb_br_WLAST(nss_i_nmf_t_cnic_pmsb_br_WLAST), 
    .nss_i_nmf_t_cnic_pmsb_br_WSTRB(nss_i_nmf_t_cnic_pmsb_br_WSTRB), 
    .nss_i_nmf_t_cnic_pmsb_br_WVALID(nss_i_nmf_t_cnic_pmsb_br_WVALID), 
    .axi2sb_pmsb_s_bid(axi2sb_pmsb_s_bid), 
    .axi2sb_pmsb_s_bresp(axi2sb_pmsb_s_bresp), 
    .axi2sb_pmsb_s_bvalid(axi2sb_pmsb_s_bvalid), 
    .nss_i_nmf_t_cnic_pmsb_br_BREADY(nss_i_nmf_t_cnic_pmsb_br_BREADY), 
    .axi2sb_pmsb_s_arready(axi2sb_pmsb_s_arready), 
    .nss_i_nmf_t_cnic_pmsb_br_ARADDR(nss_i_nmf_t_cnic_pmsb_br_ARADDR), 
    .nss_i_nmf_t_cnic_pmsb_br_ARBURST(nss_i_nmf_t_cnic_pmsb_br_ARBURST), 
    .nss_i_nmf_t_cnic_pmsb_br_ARID(nss_i_nmf_t_cnic_pmsb_br_ARID), 
    .nss_i_nmf_t_cnic_pmsb_br_ARLEN(nss_i_nmf_t_cnic_pmsb_br_ARLEN), 
    .nss_i_nmf_t_cnic_pmsb_br_ARPROT(nss_i_nmf_t_cnic_pmsb_br_ARPROT), 
    .nss_i_nmf_t_cnic_pmsb_br_ARSIZE(nss_i_nmf_t_cnic_pmsb_br_ARSIZE), 
    .nss_i_nmf_t_cnic_pmsb_br_ARVALID(nss_i_nmf_t_cnic_pmsb_br_ARVALID), 
    .axi2sb_pmsb_s_rid(axi2sb_pmsb_s_rid), 
    .axi2sb_pmsb_s_rdata(axi2sb_pmsb_s_rdata), 
    .axi2sb_pmsb_s_rresp(axi2sb_pmsb_s_rresp), 
    .axi2sb_pmsb_s_rlast(axi2sb_pmsb_s_rlast), 
    .axi2sb_pmsb_s_rvalid(axi2sb_pmsb_s_rvalid), 
    .nss_i_nmf_t_cnic_pmsb_br_RREADY(nss_i_nmf_t_cnic_pmsb_br_RREADY), 
    .axi2sb_pmsb_m_awid(axi2sb_pmsb_m_awid), 
    .axi2sb_pmsb_m_awaddr(axi2sb_pmsb_m_awaddr), 
    .axi2sb_pmsb_m_awlen(axi2sb_pmsb_m_awlen), 
    .axi2sb_pmsb_m_awuser(axi2sb_pmsb_m_awuser), 
    .axi2sb_pmsb_m_awsize(axi2sb_pmsb_m_awsize), 
    .axi2sb_pmsb_m_awburst(axi2sb_pmsb_m_awburst), 
    .axi2sb_pmsb_m_awprot(axi2sb_pmsb_m_awprot), 
    .axi2sb_pmsb_m_awvalid(axi2sb_pmsb_m_awvalid), 
    .nss_t_nmf_i_cnic_pmsb_AWREADY(nss_t_nmf_i_cnic_pmsb_AWREADY), 
    .axi2sb_pmsb_m_wdata(axi2sb_pmsb_m_wdata), 
    .axi2sb_pmsb_m_wstrb(axi2sb_pmsb_m_wstrb), 
    .axi2sb_pmsb_m_wlast(axi2sb_pmsb_m_wlast), 
    .axi2sb_pmsb_m_wvalid(axi2sb_pmsb_m_wvalid), 
    .nss_t_nmf_i_cnic_pmsb_WREADY(nss_t_nmf_i_cnic_pmsb_WREADY), 
    .axi2sb_pmsb_m_bready(axi2sb_pmsb_m_bready), 
    .nss_t_nmf_i_cnic_pmsb_BID(nss_t_nmf_i_cnic_pmsb_BID), 
    .nss_t_nmf_i_cnic_pmsb_BRESP(nss_t_nmf_i_cnic_pmsb_BRESP), 
    .nss_t_nmf_i_cnic_pmsb_BVALID(nss_t_nmf_i_cnic_pmsb_BVALID), 
    .axi2sb_pmsb_m_arid(axi2sb_pmsb_m_arid), 
    .axi2sb_pmsb_m_araddr(axi2sb_pmsb_m_araddr), 
    .axi2sb_pmsb_m_arlen(axi2sb_pmsb_m_arlen), 
    .axi2sb_pmsb_m_aruser(axi2sb_pmsb_m_aruser), 
    .axi2sb_pmsb_m_arsize(axi2sb_pmsb_m_arsize), 
    .axi2sb_pmsb_m_arburst(axi2sb_pmsb_m_arburst), 
    .axi2sb_pmsb_m_arprot(axi2sb_pmsb_m_arprot), 
    .axi2sb_pmsb_m_arvalid(axi2sb_pmsb_m_arvalid), 
    .nss_t_nmf_i_cnic_pmsb_ARREADY(nss_t_nmf_i_cnic_pmsb_ARREADY), 
    .axi2sb_pmsb_m_rready(axi2sb_pmsb_m_rready), 
    .nss_t_nmf_i_cnic_pmsb_RDATA(nss_t_nmf_i_cnic_pmsb_RDATA), 
    .nss_t_nmf_i_cnic_pmsb_RID(nss_t_nmf_i_cnic_pmsb_RID), 
    .nss_t_nmf_i_cnic_pmsb_RLAST(nss_t_nmf_i_cnic_pmsb_RLAST), 
    .nss_t_nmf_i_cnic_pmsb_RRESP(nss_t_nmf_i_cnic_pmsb_RRESP), 
    .nss_t_nmf_i_cnic_pmsb_RVALID(nss_t_nmf_i_cnic_pmsb_RVALID), 
    .nac_pwrgood_rst_b(nac_pwrgood_rst_b), 
    .TIME_REF_SEL_STRAP(TIME_REF_SEL_STRAP), 
    .hvm_clk_sel_cnic(hvm_clk_sel_cnic), 
    .cltap_hvm_ctrl_reg(cltap_hvm_ctrl_reg[5]), 
    .cltap_hvm_ctrl_reg_0(cltap_hvm_ctrl_reg[4]), 
    .PLL_REF_SEL0_STRAP(PLL_REF_SEL0_STRAP), 
    .cltap_hvm_ctrl_reg_1(cltap_hvm_ctrl_reg[3]), 
    .cltap_hvm_ctrl_reg_2(cltap_hvm_ctrl_reg[2]), 
    .PLL_REF_SEL1_STRAP(PLL_REF_SEL1_STRAP), 
    .cltap_hvm_ctrl_reg_3(cltap_hvm_ctrl_reg[1]), 
    .cltap_hvm_ctrl_reg_4(cltap_hvm_ctrl_reg[0]), 
    .time_ref_clk_cmos(time_ref_clk_cmos), 
    .XX_SYS_REFCLK(XX_SYS_REFCLK), 
    .divmux_aonclk1x_0(divmux_aonclk1x_0), 
    .divmux_rdop_aonclk1x_clkout(divmux_rdop_aonclk1x_clkout), 
    .divmux_rdop_aonclk5x_clkout(divmux_rdop_aonclk5x_clkout), 
    .rstbus_clk(rstbus_clk), 
    .xtalclk(xtalclk), 
    .par_nac_misc_adop_xtalclk_clkout(par_nac_misc_par_nac_misc_adop_xtalclk_clkout), 
    .par_nac_misc_adop_xtalclk_clkout_fabric2(par_nac_misc_par_nac_misc_adop_xtalclk_clkout_fabric2), 
    .div2_ecm_clk_clkout(par_nac_misc_div2_ecm_clk_clkout), 
    .boot_1000_rdop_fout7_clkout(sfi_clk_1g), 
    .infra_clk(infra_clk), 
    .par_nac_misc_adop_infra_clk_clkout(par_nac_misc_par_nac_misc_adop_infra_clk_clkout), 
    .par_nac_misc_adop_infra_clk_clkout_fabric2(par_nac_misc_par_nac_misc_adop_infra_clk_clkout_fabric2), 
    .croclk(croclk), 
    .bclk1(bclk1), 
    .par_nac_misc_adop_bclk_clkout_0(par_nac_misc_par_nac_misc_adop_bclk_clkout_0), 
    .par_nac_misc_adop_bclk_clkout_0_fabric2(par_nac_misc_par_nac_misc_adop_bclk_clkout_0_fabric2), 
    .cmlbuf51_o_clk_cmlclkout_p_ana(cmlbuf51_o_clk_cmlclkout_p_ana), 
    .cmlbuf51_o_clk_cmlclkout_n_ana(cmlbuf51_o_clk_cmlclkout_n_ana), 
    .boot_450_rdop_fout1_clkout(boot_450_rdop_fout1_clkout), 
    .boot_900_rdop_fout0_clkout(boot_900_rdop_fout0_clkout), 
    .boot_112p5_rdop_fout2_clkout(par_nac_misc_boot_112p5_rdop_fout2_clkout), 
    .boot_112p5_rdop_fout2_clkout_fabric2(par_nac_misc_boot_112p5_rdop_fout2_clkout_fabric2), 
    .boot_250_rdop_fout3_clkout(boot_250_rdop_fout3_clkout), 
    .boot_900_rdop_fout8_clkout(XX_NCSI_CLK_OUT), 
    .boot_200_rdop_fout9_clkout(XX_RGMII_CLK_OUT), 
    .boot_20_rdop_fout5_clkout(par_nac_misc_boot_20_rdop_fout5_clkout), 
    .boot_750_rdop_fout4_clkout(boot_750_rdop_fout4_clkout), 
    .boot_529p41_rdop_fout6_clkout(boot_529p41_rdop_fout6_clkout), 
    .par_nac_misc_adop_rstbus_clk_clkout_0(par_nac_misc_par_nac_misc_adop_rstbus_clk_clkout_0), 
    .par_nac_misc_adop_rstbus_clk_clkout_0_fabric2(par_nac_misc_par_nac_misc_adop_rstbus_clk_clkout_0_fabric2), 
    .early_boot_rst_b(early_boot_rst_b), 
    .inf_rstbus_rst_b(inf_rstbus_rst_b), 
    .fdfx_pwrgood_rst_b(fdfx_pwrgood_rst_b), 
    .boot_pll_adapt_rstw_resource_ready(boot_pll_adapt_rstw_resource_ready), 
    .clockss_boot_pll_iosf_sb_ism_fabric(clockss_boot_pll_iosf_sb_ism_fabric), 
    .rsrc_pll_top_boot_side_ism_agent(clockss_boot_pll_iosf_sb_ism_agent), 
    .rsrc_pll_top_boot_side_pok(clockss_boot_pll_iosf_sb_side_pok), 
    .rsrc_pll_top_boot_mnpput(clockss_boot_pll_iosf_sb_mnpput), 
    .rsrc_pll_top_boot_mpcput(clockss_boot_pll_iosf_sb_mpcput), 
    .clockss_boot_pll_iosf_sb_mnpcup(clockss_boot_pll_iosf_sb_mnpcup), 
    .clockss_boot_pll_iosf_sb_mpccup(clockss_boot_pll_iosf_sb_mpccup), 
    .rsrc_pll_top_boot_meom(clockss_boot_pll_iosf_sb_meom), 
    .rsrc_pll_top_boot_mpayload(clockss_boot_pll_iosf_sb_mpayload), 
    .clockss_boot_pll_iosf_sb_tnpput(clockss_boot_pll_iosf_sb_tnpput), 
    .clockss_boot_pll_iosf_sb_tpcput(clockss_boot_pll_iosf_sb_tpcput), 
    .rsrc_pll_top_boot_tnpcup(clockss_boot_pll_iosf_sb_tnpcup), 
    .rsrc_pll_top_boot_tpccup(clockss_boot_pll_iosf_sb_tpccup), 
    .clockss_boot_pll_iosf_sb_teom(clockss_boot_pll_iosf_sb_teom), 
    .clockss_boot_pll_iosf_sb_tpayload(clockss_boot_pll_iosf_sb_tpayload), 
    .nac_pllthermtrip_err(nac_pllthermtrip_err), 
    .dfd_dop_enable(dfd_dop_enable), 
    .eth_physs_rdop_fout3_clkout_0(eth_physs_rdop_fout3_clkout_0), 
    .dfd_dop_enable_sync_o(dfd_dop_enable_sync_o), 
    .pll_top_boot_prdata(pll_top_boot_prdata), 
    .pll_top_boot_pready(pll_top_boot_pready), 
    .pll_top_boot_pslverr(pll_top_boot_pslverr), 
    .nss_i_nmf_t_clk_boot_paddr(nss_i_nmf_t_clk_boot_paddr), 
    .nss_i_nmf_t_clk_boot_penable(nss_i_nmf_t_clk_boot_penable), 
    .nss_i_nmf_t_clk_boot_pwrite(nss_i_nmf_t_clk_boot_pwrite), 
    .nss_i_nmf_t_clk_boot_pwdata(nss_i_nmf_t_clk_boot_pwdata), 
    .nss_i_nmf_t_clk_boot_psel_0(nss_i_nmf_t_clk_boot_psel_0), 
    .eth_physs_rdop_fout3_clkout(par_nac_fabric2_eth_physs_rdop_fout3_clkout_nac_misc), 
    .rstw_pll_top_eth_physs_reset_error(rstw_pll_top_eth_physs_reset_error), 
    .rstw_pll_top_eth_physs_reset_cmd_ack(rstw_pll_top_eth_physs_reset_cmd_ack), 
    .rsrc_pll_top_eth_physs_uc_ierr(rsrc_pll_top_eth_physs_uc_ierr), 
    .divmux_socpll_refclk_0(divmux_socpll_refclk_0), 
    .nss_962p5_rdop_fout0_clkout(nss_962p5_rdop_fout0_clkout), 
    .nss_1375_rdop_fout7_clkout(nss_1375_rdop_fout7_clkout), 
    .nss_1069p44_rdop_fout5_clkout(nss_1069p44_rdop_fout5_clkout), 
    .nss_641p67_rdop_fout6_clkout(nss_641p67_rdop_fout6_clkout), 
    .nss_1069p44_rdop_fout8_clkout(nss_1069p44_rdop_fout8_clkout), 
    .nss_1604p17_rdop_fout1_clkout(nss_1604p17_rdop_fout1_clkout), 
    .nss_1604p17_rdop_fout4_clkout(nss_1604p17_rdop_fout4_clkout), 
    .clockss_nss_pll_iosf_sb_ism_fabric(clockss_nss_pll_iosf_sb_ism_fabric), 
    .rsrc_pll_top_nss_side_ism_agent(clockss_nss_pll_iosf_sb_ism_agent), 
    .rsrc_pll_top_nss_side_pok(clockss_nss_pll_iosf_sb_side_pok), 
    .rsrc_pll_top_nss_mnpput(clockss_nss_pll_iosf_sb_mnpput), 
    .rsrc_pll_top_nss_mpcput(clockss_nss_pll_iosf_sb_mpcput), 
    .clockss_nss_pll_iosf_sb_mnpcup(clockss_nss_pll_iosf_sb_mnpcup), 
    .clockss_nss_pll_iosf_sb_mpccup(clockss_nss_pll_iosf_sb_mpccup), 
    .rsrc_pll_top_nss_meom(clockss_nss_pll_iosf_sb_meom), 
    .rsrc_pll_top_nss_mpayload(clockss_nss_pll_iosf_sb_mpayload), 
    .clockss_nss_pll_iosf_sb_tnpput(clockss_nss_pll_iosf_sb_tnpput), 
    .clockss_nss_pll_iosf_sb_tpcput(clockss_nss_pll_iosf_sb_tpcput), 
    .rsrc_pll_top_nss_tnpcup(clockss_nss_pll_iosf_sb_tnpcup), 
    .rsrc_pll_top_nss_tpccup(clockss_nss_pll_iosf_sb_tpccup), 
    .clockss_nss_pll_iosf_sb_teom(clockss_nss_pll_iosf_sb_teom), 
    .clockss_nss_pll_iosf_sb_tpayload(clockss_nss_pll_iosf_sb_tpayload), 
    .pll_top_nss_prdata(pll_top_nss_prdata), 
    .pll_top_nss_pready(pll_top_nss_pready), 
    .pll_top_nss_pslverr(pll_top_nss_pslverr), 
    .nss_i_nmf_t_clk_nss0_paddr(nss_i_nmf_t_clk_nss0_paddr), 
    .nss_i_nmf_t_clk_nss0_penable(nss_i_nmf_t_clk_nss0_penable), 
    .nss_i_nmf_t_clk_nss0_pwrite(nss_i_nmf_t_clk_nss0_pwrite), 
    .nss_i_nmf_t_clk_nss0_pwdata(nss_i_nmf_t_clk_nss0_pwdata), 
    .nss_i_nmf_t_clk_nss0_psel_0(nss_i_nmf_t_clk_nss0_psel_0), 
    .ts_800_rdop_fout0_clkout(par_nac_misc_ts_800_rdop_fout0_clkout), 
    .ts_800_rdop_fout0_clkout_fabric2(par_nac_misc_ts_800_rdop_fout0_clkout_fabric2), 
    .ts_100_rdop_fout1_clkout(ts_100_rdop_fout1_clkout), 
    .clockss_ts_pll_iosf_sb_ism_fabric(clockss_ts_pll_iosf_sb_ism_fabric), 
    .rsrc_pll_top_ts_side_ism_agent(clockss_ts_pll_iosf_sb_ism_agent), 
    .rsrc_pll_top_ts_side_pok(clockss_ts_pll_iosf_sb_side_pok), 
    .rsrc_pll_top_ts_mnpput(clockss_ts_pll_iosf_sb_mnpput), 
    .rsrc_pll_top_ts_mpcput(clockss_ts_pll_iosf_sb_mpcput), 
    .clockss_ts_pll_iosf_sb_mnpcup(clockss_ts_pll_iosf_sb_mnpcup), 
    .clockss_ts_pll_iosf_sb_mpccup(clockss_ts_pll_iosf_sb_mpccup), 
    .rsrc_pll_top_ts_meom(clockss_ts_pll_iosf_sb_meom), 
    .rsrc_pll_top_ts_mpayload(clockss_ts_pll_iosf_sb_mpayload), 
    .clockss_ts_pll_iosf_sb_tnpput(clockss_ts_pll_iosf_sb_tnpput), 
    .clockss_ts_pll_iosf_sb_tpcput(clockss_ts_pll_iosf_sb_tpcput), 
    .rsrc_pll_top_ts_tnpcup(clockss_ts_pll_iosf_sb_tnpcup), 
    .rsrc_pll_top_ts_tpccup(clockss_ts_pll_iosf_sb_tpccup), 
    .clockss_ts_pll_iosf_sb_teom(clockss_ts_pll_iosf_sb_teom), 
    .clockss_ts_pll_iosf_sb_tpayload(clockss_ts_pll_iosf_sb_tpayload), 
    .clk_misc_fusebox_fuse_bus_2(clk_misc_fusebox_fuse_bus_2), 
    .pll_top_ts_prdata(pll_top_ts_prdata), 
    .pll_top_ts_pready(pll_top_ts_pready), 
    .pll_top_ts_pslverr(pll_top_ts_pslverr), 
    .nss_i_nmf_t_clk_ts_paddr(nss_i_nmf_t_clk_ts_paddr), 
    .nss_i_nmf_t_clk_ts_penable(nss_i_nmf_t_clk_ts_penable), 
    .nss_i_nmf_t_clk_ts_pwrite(nss_i_nmf_t_clk_ts_pwrite), 
    .nss_i_nmf_t_clk_ts_pwdata(nss_i_nmf_t_clk_ts_pwdata), 
    .nss_i_nmf_t_clk_ts_psel_0(nss_i_nmf_t_clk_ts_psel_0), 
    .clkss_cmlbuf_iosf_sb_intf_MNPCUP(clkss_cmlbuf_iosf_sb_intf_MNPCUP), 
    .clkss_cmlbuf_iosf_sb_intf_MPCCUP(clkss_cmlbuf_iosf_sb_intf_MPCCUP), 
    .clkss_cmlbuf_iosf_sb_intf_SIDE_ISM_FABRIC(clkss_cmlbuf_iosf_sb_intf_SIDE_ISM_FABRIC), 
    .clkss_cmlbuf_iosf_sb_intf_TEOM(clkss_cmlbuf_iosf_sb_intf_TEOM), 
    .clkss_cmlbuf_iosf_sb_intf_TNPPUT(clkss_cmlbuf_iosf_sb_intf_TNPPUT), 
    .clkss_cmlbuf_iosf_sb_intf_TPAYLOAD(clkss_cmlbuf_iosf_sb_intf_TPAYLOAD), 
    .clkss_cmlbuf_iosf_sb_intf_TPCPUT(clkss_cmlbuf_iosf_sb_intf_TPCPUT), 
    .cmlbuf51_btrs_iosf_sb_intf_MEOM(clkss_cmlbuf_iosf_sb_intf_MEOM), 
    .cmlbuf51_btrs_iosf_sb_intf_MNPPUT(clkss_cmlbuf_iosf_sb_intf_MNPPUT), 
    .cmlbuf51_btrs_iosf_sb_intf_MPAYLOAD(clkss_cmlbuf_iosf_sb_intf_MPAYLOAD), 
    .cmlbuf51_btrs_iosf_sb_intf_MPCPUT(clkss_cmlbuf_iosf_sb_intf_MPCPUT), 
    .cmlbuf51_btrs_iosf_sb_intf_SIDE_ISM_AGENT(clkss_cmlbuf_iosf_sb_intf_SIDE_ISM_AGENT), 
    .cmlbuf51_btrs_iosf_sb_intf_TNPCUP(clkss_cmlbuf_iosf_sb_intf_TNPCUP), 
    .cmlbuf51_btrs_iosf_sb_intf_TPCCUP(clkss_cmlbuf_iosf_sb_intf_TPCCUP), 
    .cmlbuf51_btrs_sideband_pok(clkss_cmlbuf_sideband_pok), 
    .reset_cmd_data(reset_cmd_data), 
    .reset_cmd_valid(reset_cmd_valid), 
    .reset_cmd_parity(reset_cmd_parity), 
    .cmlclkout_p_ana(cmlclkout_p_ana), 
    .cmlclkout_n_ana(cmlclkout_n_ana), 
    .cmlbuf_valid_dig(cmlbuf_valid_dig), 
    .nac_ss_dtfb_upstream_rst_b(nac_ss_dtfb_upstream_rst_b), 
    .dtf_nac_top_arb_dtfa_dnstream_d0_header_out(nac_ss_dtf_dnstream_header), 
    .dtf_nac_top_arb_dtfa_dnstream_d0_data_out(nac_ss_dtf_dnstream_data), 
    .dtf_nac_top_arb_dtfa_dnstream_d0_valid_out(nac_ss_dtf_dnstream_valid), 
    .nac_ss_dtf_upstream_credit(nac_ss_dtf_upstream_credit), 
    .nac_ss_dtf_upstream_active(nac_ss_dtf_upstream_active), 
    .nac_ss_dtf_upstream_sync(nac_ss_dtf_upstream_sync), 
    .dtf_rep_misc_nsc_clkarb1_rep0_dtfr_upstream_d0_credit_out(dtf_rep_misc_nsc_clkarb1_rep0_dtfr_upstream_d0_credit_out), 
    .dtf_rep_misc_nsc_clkarb1_rep0_dtfr_upstream_d0_active_out(dtf_rep_misc_nsc_clkarb1_rep0_dtfr_upstream_d0_active_out), 
    .dtf_rep_misc_nsc_clkarb1_rep0_dtfr_upstream_d0_sync_out(dtf_rep_misc_nsc_clkarb1_rep0_dtfr_upstream_d0_sync_out), 
    .nss_nsc_dlw_next_arb2arb_DTFA_HEADER(nss_nsc_dlw_next_arb2arb_DTFA_HEADER), 
    .nss_nsc_dlw_next_arb2arb_DTFA_DATA(nss_nsc_dlw_next_arb2arb_DTFA_DATA), 
    .nss_nsc_dlw_next_arb2arb_DTFA_VALID(nss_nsc_dlw_next_arb2arb_DTFA_VALID), 
    .par_nac_fabric1_pdop_dtf_clk_clkout(par_nac_fabric1_pdop_dtf_clk_clkout), 
    .par_nac_fabric2_pdop_dtf_clk_clkout(par_nac_fabric2_pdop_dtf_clk_clkout), 
    .socviewpin_32to1digimux_fabric0_0_outmux(socviewpin_32to1digimux_fabric0_0_outmux), 
    .socviewpin_32to1digimux_fabric0_1_outmux(socviewpin_32to1digimux_fabric0_1_outmux), 
    .socviewpin_32to1digimux_fabric3_0_outmux(socviewpin_32to1digimux_fabric3_0_outmux), 
    .socviewpin_32to1digimux_fabric3_1_outmux(socviewpin_32to1digimux_fabric3_1_outmux), 
    .socviewpin_32to1digimux_0_outmux(nac_ss_debug_dig_view_out[0]), 
    .socviewpin_32to1digimux_1_outmux(nac_ss_debug_dig_view_out[1]), 
    .nac_ss_debug_dts_dig_view_in(nac_ss_debug_dts_dig_view_in), 
    .dts_nac2_o_digital_view(nac_ss_debug_dts_dig_view_out), 
    .dts_nac2_o_analog_view_a(nac_ss_debug_ana_view_inout), 
    .nss_reset_debug_apb_n(nss_reset_debug_apb_n), 
    .nss_reset_debug_soc_n(nss_reset_debug_soc_n), 
    .nss_arm_debug_en(nss_arm_debug_en), 
    .nss_reset_debug_dap_n(nss_reset_debug_dap_n), 
    .nac_ss_debug_css600_dp_targetid(nac_ss_debug_css600_dp_targetid), 
    .css600_dpreceiver_nac_ss_cdbgrstreq(css600_dpreceiver_nac_ss_cdbgrstreq),  
    .nss_cdbgrstack_cdbgrst(nss_cdbgrstack_cdbgrst),  
    .nss_cnic_apbic_pready(nss_cnic_apbic_pready), 
    .nss_cnic_apbic_pslverr(nss_cnic_apbic_pslverr), 
    .nss_cnic_apbic_prdata(nss_cnic_apbic_prdata), 
    .css600_apbic_ioexp_apbic0_nac_ss_pwakeup_r2(css600_apbic_ioexp_apbic0_nac_ss_pwakeup_r2), 
    .css600_apbic_ioexp_apbic0_nac_ss_psel_r2(css600_apbic_ioexp_apbic0_nac_ss_psel_r2), 
    .css600_apbic_ioexp_apbic0_nac_ss_penable_r2(css600_apbic_ioexp_apbic0_nac_ss_penable_r2), 
    .css600_apbic_ioexp_apbic0_nac_ss_pwrite_r2(css600_apbic_ioexp_apbic0_nac_ss_pwrite_r2), 
    .css600_apbic_ioexp_apbic0_nac_ss_pprot_r2(css600_apbic_ioexp_apbic0_nac_ss_pprot_r2), 
    .css600_apbic_ioexp_apbic0_nac_ss_pnse_r2(css600_apbic_ioexp_apbic0_nac_ss_pnse_r2), 
    .css600_apbic_ioexp_apbic0_nac_ss_paddr_r2(css600_apbic_ioexp_apbic0_nac_ss_paddr_r2), 
    .css600_apbic_ioexp_apbic0_nac_ss_pwdata_r2(css600_apbic_ioexp_apbic0_nac_ss_pwdata_r2), 
    .css600_apbasyncbridgecompleter_nsc_nmf_nac_ss_pready_c(css600_apbasyncbridgecompleter_nsc_nmf_nac_ss_pready_c), 
    .css600_apbasyncbridgecompleter_nsc_nmf_nac_ss_pslverr_c(css600_apbasyncbridgecompleter_nsc_nmf_nac_ss_pslverr_c), 
    .css600_apbasyncbridgecompleter_nsc_nmf_nac_ss_prdata_c(css600_apbasyncbridgecompleter_nsc_nmf_nac_ss_prdata_c), 
    .nss_i_nmf_t_cnic_apbic_psel_0(nss_i_nmf_t_cnic_apbic_psel_0), 
    .nss_i_nmf_t_cnic_apbic_penable(nss_i_nmf_t_cnic_apbic_penable), 
    .nss_i_nmf_t_cnic_apbic_pwrite(nss_i_nmf_t_cnic_apbic_pwrite), 
    .nss_i_nmf_t_cnic_apbic_pprot(nss_i_nmf_t_cnic_apbic_pprot), 
    .nss_i_nmf_t_cnic_apbic_paddr(nss_i_nmf_t_cnic_apbic_paddr), 
    .nss_i_nmf_t_cnic_apbic_pwdata(nss_i_nmf_t_cnic_apbic_pwdata), 
    .nss_nmc_atb_atwakeup(nss_nmc_atb_atwakeup), 
    .nss_nmc_atb_atid(nss_nmc_atb_atid), 
    .nss_nmc_atb_atbytes(nss_nmc_atb_atbytes), 
    .nss_nmc_atb_atdata(nss_nmc_atb_atdata), 
    .nss_nmc_atb_atvalid(nss_nmc_atb_atvalid), 
    .nss_nmc_atb_afready(nss_nmc_atb_afready), 
    .css600_tmc_etf_nac_ss_atready_rx(css600_tmc_etf_nac_ss_atready_rx), 
    .css600_tmc_etf_nac_ss_afvalid_rx(css600_tmc_etf_nac_ss_afvalid_rx), 
    .css600_tmc_etf_nac_ss_syncreq_rx(css600_tmc_etf_nac_ss_syncreq_rx), 
    .css600_tpiu_nac_ss_tracedata(nac_ss_tpiu_data), 
    .css600_tpiu_nac_ss_traceclk(nac_ss_tpiu_clk), 
    .nss_nac_cti_channel_in(nss_nac_cti_channel_in), 
    .css600_cti_nac_ss_channel_out(css600_cti_nac_ss_channel_out), 
    .nac_ss_debug_safemode_isa_oob(nac_ss_debug_safemode_isa_oob), 
    .css600_dpreceiver_nac_ss_swdo(nac_ss_debug_css600_swdo_out), 
    .css600_dpreceiver_nac_ss_swdo_en(nac_ss_debug_css600_swd0_en_out), 
    .nac_ss_debug_css600_swclk_in(nac_ss_debug_css600_swclk_in), 
    .nac_ss_debug_css600_swd_sel_in(nac_ss_debug_css600_swd_sel_in), 
    .nac_ss_debug_css600_swdio_in(nac_ss_debug_css600_swdio_in), 
    .dfxagg_security_policy(fdfx_security_policy), 
    .dfxagg_policy_update(fdfx_policy_update), 
    .dfxagg_early_boot_debug_exit(fdfx_earlyboot_debug_exit), 
    .dfxagg_debug_capabilities_enabling(fdfx_debug_capabilities_enabling), 
    .dfxagg_debug_capabilities_enabling_valid(fdfx_debug_capabilities_enabling_valid), 
    .hlp_efbisr_reg_Q_0(hlp_efbisr_reg_Q_0), 
    .hlp_efbisr_reg_Q_1(hlp_efbisr_reg_Q_1), 
    .hlp_efbisr_reg_Q_2(hlp_efbisr_reg_Q_2), 
    .hlp_efbisr_reg_Q_3(hlp_efbisr_reg_Q_3), 
    .hlp_efbisr_reg_Q_4(hlp_efbisr_reg_Q_4), 
    .hlp_hlp_intr_0(hlp_hlp_intr_0), 
    .hlp_hlp_intr_1(hlp_hlp_intr_1), 
    .physs_mac100_0_int(physs_mac100_0_int), 
    .physs_mac100_0_int_0(physs_mac100_0_int_0), 
    .physs_mac100_0_int_1(physs_mac100_0_int_1), 
    .physs_mac100_0_int_2(physs_mac100_0_int_2), 
    .physs_mac100_1_int(physs_mac100_1_int), 
    .physs_mac100_1_int_0(physs_mac100_1_int_0), 
    .physs_mac100_1_int_1(physs_mac100_1_int_1), 
    .physs_mac100_1_int_2(physs_mac100_1_int_2), 
    .physs_mac400_0_int(physs_mac400_0_int), 
    .physs_mac400_0_int_0(physs_mac400_0_int_0), 
    .physs_mac400_1_int(physs_mac400_1_int), 
    .physs_mac400_1_int_0(physs_mac400_1_int_0), 
    .physs_mac800_0_int(physs_mac800_0_int), 
    .physs_physs_ts_int(physs_physs_ts_int), 
    .physs_physs_ts_int_0(physs_physs_ts_int_0), 
    .physs_physs_ts_int_1(physs_physs_ts_int_1), 
    .physs_physs_ts_int_2(physs_physs_ts_int_2), 
    .physs_physs_ts_int_3(physs_physs_ts_int_3), 
    .physs_physs_ts_int_4(physs_physs_ts_int_4), 
    .physs_physs_ts_int_5(physs_physs_ts_int_5), 
    .physs_physs_ts_int_6(physs_physs_ts_int_6), 
    .physs_o_ucss_irq_status_a(physs_o_ucss_irq_status_a), 
    .physs_o_ucss_irq_status_a_0(physs_o_ucss_irq_status_a_0), 
    .physs_o_ucss_irq_status_a_1(physs_o_ucss_irq_status_a_1), 
    .physs_o_ucss_irq_status_a_2(physs_o_ucss_irq_status_a_2), 
    .physs_o_ucss_irq_status_a_3(physs_o_ucss_irq_status_a_3), 
    .physs_o_ucss_irq_status_a_4(physs_o_ucss_irq_status_a_4), 
    .physs_o_ucss_irq_status_a_5(physs_o_ucss_irq_status_a_5), 
    .physs_o_ucss_irq_status_a_6(physs_o_ucss_irq_status_a_6), 
    .physs_o_ucss_irq_cpi_0_a(physs_o_ucss_irq_cpi_0_a), 
    .physs_o_ucss_irq_cpi_0_a_0(physs_o_ucss_irq_cpi_0_a_0), 
    .physs_o_ucss_irq_cpi_0_a_1(physs_o_ucss_irq_cpi_0_a_1), 
    .physs_o_ucss_irq_cpi_0_a_2(physs_o_ucss_irq_cpi_0_a_2), 
    .physs_o_ucss_irq_cpi_1_a(physs_o_ucss_irq_cpi_1_a), 
    .physs_o_ucss_irq_cpi_1_a_0(physs_o_ucss_irq_cpi_1_a_0), 
    .physs_o_ucss_irq_cpi_1_a_1(physs_o_ucss_irq_cpi_1_a_1), 
    .physs_o_ucss_irq_cpi_1_a_2(physs_o_ucss_irq_cpi_1_a_2), 
    .physs_o_ucss_irq_cpi_2_a(physs_o_ucss_irq_cpi_2_a), 
    .physs_o_ucss_irq_cpi_2_a_0(physs_o_ucss_irq_cpi_2_a_0), 
    .physs_o_ucss_irq_status_a_7(physs_o_ucss_irq_status_a_7), 
    .physs_o_ucss_irq_status_a_8(physs_o_ucss_irq_status_a_8), 
    .physs_o_ucss_irq_status_a_9(physs_o_ucss_irq_status_a_9), 
    .physs_o_ucss_irq_status_a_10(physs_o_ucss_irq_status_a_10), 
    .physs_o_ucss_irq_status_a_11(physs_o_ucss_irq_status_a_11), 
    .physs_o_ucss_irq_status_a_12(physs_o_ucss_irq_status_a_12), 
    .physs_o_ucss_irq_status_a_13(physs_o_ucss_irq_status_a_13), 
    .physs_o_ucss_irq_status_a_14(physs_o_ucss_irq_status_a_14), 
    .physs_o_ucss_irq_cpi_2_a_1(physs_o_ucss_irq_cpi_2_a_1), 
    .physs_o_ucss_irq_cpi_2_a_2(physs_o_ucss_irq_cpi_2_a_2), 
    .physs_o_ucss_irq_cpi_3_a(physs_o_ucss_irq_cpi_3_a), 
    .physs_o_ucss_irq_cpi_3_a_0(physs_o_ucss_irq_cpi_3_a_0), 
    .physs_o_ucss_irq_cpi_3_a_1(physs_o_ucss_irq_cpi_3_a_1), 
    .physs_o_ucss_irq_cpi_3_a_2(physs_o_ucss_irq_cpi_3_a_2), 
    .physs_o_ucss_irq_cpi_4_a(physs_o_ucss_irq_cpi_4_a), 
    .physs_o_ucss_irq_cpi_4_a_0(physs_o_ucss_irq_cpi_4_a_0), 
    .physs_o_ucss_irq_cpi_4_a_1(physs_o_ucss_irq_cpi_4_a_1), 
    .physs_o_ucss_irq_cpi_4_a_2(physs_o_ucss_irq_cpi_4_a_2), 
    .nss_intr_i2c(nss_intr_i2c), 
    .nss_intr_i2c_0(nss_intr_i2c_0), 
    .nss_intr_i2c_1(nss_intr_i2c_1), 
    .nss_intr_i2c_2(nss_intr_i2c_2), 
    .nss_intr_i2c_3(nss_intr_i2c_3), 
    .nss_i_nmf_t_cnic_intr_hndlr_paddr(nss_i_nmf_t_cnic_intr_hndlr_paddr), 
    .nss_i_nmf_t_cnic_intr_hndlr_penable(nss_i_nmf_t_cnic_intr_hndlr_penable), 
    .nss_i_nmf_t_cnic_intr_hndlr_pwrite(nss_i_nmf_t_cnic_intr_hndlr_pwrite), 
    .nss_i_nmf_t_cnic_intr_hndlr_pwdata(nss_i_nmf_t_cnic_intr_hndlr_pwdata), 
    .nss_i_nmf_t_cnic_intr_hndlr_pprot(nss_i_nmf_t_cnic_intr_hndlr_pprot), 
    .nss_i_nmf_t_cnic_intr_hndlr_pstrb(nss_i_nmf_t_cnic_intr_hndlr_pstrb), 
    .nss_i_nmf_t_cnic_intr_hndlr_psel_0(nss_i_nmf_t_cnic_intr_hndlr_psel_0), 
    .hic_top_wrap_prdata(hic_top_wrap_prdata), 
    .hic_top_wrap_pready(hic_top_wrap_pready), 
    .hic_top_wrap_pslverr(hic_top_wrap_pslverr), 
    .hic_top_wrap_m_axi_awid(hic_top_wrap_m_axi_awid), 
    .hic_top_wrap_m_axi_awaddr(hic_top_wrap_m_axi_awaddr), 
    .hic_top_wrap_m_axi_awlen(hic_top_wrap_m_axi_awlen), 
    .hic_top_wrap_m_axi_awsize(hic_top_wrap_m_axi_awsize), 
    .hic_top_wrap_m_axi_awburst(hic_top_wrap_m_axi_awburst), 
    .hic_top_wrap_m_axi_awlock(hic_top_wrap_m_axi_awlock), 
    .hic_top_wrap_m_axi_awcache(hic_top_wrap_m_axi_awcache), 
    .hic_top_wrap_m_axi_awprot(hic_top_wrap_m_axi_awprot), 
    .hic_top_wrap_m_axi_awqos(hic_top_wrap_m_axi_awqos), 
    .hic_top_wrap_m_axi_awvalid(hic_top_wrap_m_axi_awvalid), 
    .nss_t_nmf_i_cnic_intr_hndlr_AWREADY(nss_t_nmf_i_cnic_intr_hndlr_AWREADY), 
    .hic_top_wrap_m_axi_wdata(hic_top_wrap_m_axi_wdata), 
    .hic_top_wrap_m_axi_wstrb(hic_top_wrap_m_axi_wstrb), 
    .hic_top_wrap_m_axi_wlast(hic_top_wrap_m_axi_wlast), 
    .hic_top_wrap_m_axi_wvalid(hic_top_wrap_m_axi_wvalid), 
    .nss_t_nmf_i_cnic_intr_hndlr_WREADY(nss_t_nmf_i_cnic_intr_hndlr_WREADY), 
    .nss_t_nmf_i_cnic_intr_hndlr_BID(nss_t_nmf_i_cnic_intr_hndlr_BID), 
    .nss_t_nmf_i_cnic_intr_hndlr_BRESP(nss_t_nmf_i_cnic_intr_hndlr_BRESP), 
    .hic_top_wrap_m_axi_bready(hic_top_wrap_m_axi_bready), 
    .nss_t_nmf_i_cnic_intr_hndlr_BVALID(nss_t_nmf_i_cnic_intr_hndlr_BVALID), 
    .nac_sys_rst_n(nac_sys_rst_n), 
    .XX_BIST_ENABLE(XX_BIST_ENABLE), 
    .nac_post_iosf_sb_ism_fabric(nac_post_iosf_sb_ism_fabric), 
    .nac_post_side_ism_agent(nac_post_iosf_sb_ism_agent), 
    .nac_post_mnpput(nac_post_iosf_sb_mnpput), 
    .nac_post_mpcput(nac_post_iosf_sb_mpcput), 
    .nac_post_iosf_sb_mnpcup(nac_post_iosf_sb_mnpcup), 
    .nac_post_iosf_sb_mpccup(nac_post_iosf_sb_mpccup), 
    .nac_post_meom(nac_post_iosf_sb_meom), 
    .nac_post_mpayload(nac_post_iosf_sb_mpayload), 
    .nac_post_iosf_sb_tnpput(nac_post_iosf_sb_tnpput), 
    .nac_post_iosf_sb_tpcput(nac_post_iosf_sb_tpcput), 
    .nac_post_tnpcup(nac_post_iosf_sb_tnpcup), 
    .nac_post_tpccup(nac_post_iosf_sb_tpccup), 
    .nac_post_iosf_sb_teom(nac_post_iosf_sb_teom), 
    .nac_post_iosf_sb_tpayload(nac_post_iosf_sb_tpayload), 
    .nac_post_tdr_post_out(nac_post_status_to_cltap), 
    .nac_post_YY_WOL(YY_WOL), 
    .cnic_fnic_mode_strap(cnic_fnic_mode_strap), 
    .axi2sb_gpsb_irq(axi2sb_gpsb_irq), 
    .axi2sb_pmsb_irq(axi2sb_pmsb_irq), 
    .clkss_boot_fusa_pll_err_boot_0(clkss_boot_fusa_pll_err_boot_0), 
    .clkss_ts_fusa_pll_err_ts_0(clkss_ts_fusa_pll_err_ts_0), 
    .clkss_nss_fusa_pll_err_nss_0(clkss_nss_fusa_pll_err_nss_0), 
    .hic_top_wrap_axi_irq_out(hic_top_wrap_axi_irq_out), 
    .nac_otp_pready(nac_otp_pready), 
    .nac_otp_pslverr(nac_otp_pslverr), 
    .nac_otp_prdata(nac_otp_prdata), 
    .nss_cnic_i_nmf_t_cnic_nsc_pfb_pwrite(nss_cnic_i_nmf_t_cnic_nsc_pfb_pwrite), 
    .nss_cnic_i_nmf_t_cnic_nsc_pfb_pwdata(nss_cnic_i_nmf_t_cnic_nsc_pfb_pwdata), 
    .nss_cnic_i_nmf_t_cnic_nsc_pfb_psel_0(nss_cnic_i_nmf_t_cnic_nsc_pfb_psel_0), 
    .nss_cnic_i_nmf_t_cnic_nsc_pfb_penable(nss_cnic_i_nmf_t_cnic_nsc_pfb_penable), 
    .nss_cnic_i_nmf_t_cnic_nsc_pfb_paddr(nss_cnic_i_nmf_t_cnic_nsc_pfb_paddr), 
    .nss_nss_wol_pins(nss_nss_wol_pins), 
    .nac_post_nac_sys_rst_n_out(nac_post_nac_sys_rst_n_out), 
    .nss_bts_hic_rst_n(nss_bts_hic_rst_n), 
    .nss_nsc_post_done(nss_nsc_post_done), 
    .nss_nsc_post_pass(nss_nsc_post_pass), 
    .nac_post_post_trig_nsc(nac_post_post_trig_nsc), 
    .nac_post_post_mux_ctrl_nsc(nac_post_post_mux_ctrl_nsc), 
    .nac_post_post_clkungate_nsc(nac_post_post_clkungate_nsc), 
    .nac_post_post_trig_hlp(nac_post_post_trig_hlp), 
    .hlp_hlp_post_done(hlp_hlp_post_done), 
    .hlp_hlp_post_pass(hlp_hlp_post_pass), 
    .nac_post_post_mux_ctrl_hlp(nac_post_post_mux_ctrl_hlp), 
    .nac_post_post_clkungate_hlp(nac_post_post_clkungate_hlp), 
    .nac_glue_logic_inst_resolved_hlp_disabled_0(nac_glue_logic_inst_resolved_hlp_disabled_0), 
    .s5_bgr_lvrrefpwrgood(s5_bgr_lvrrefpwrgood), 
    .dts_lvrref_a(dts_lvrref_a), 
    .nac_thermtrip_in(nac_thermtrip_in), 
    .dts_nac0_wrap_dts0_o_thermtrip(nac_thermtrip_out), 
    .rsrc_adapt_dts_nac0_iosf_sb_ism_fabric(rsrc_adapt_dts_nac0_iosf_sb_ism_fabric), 
    .rsrc_adapt_dts_nac0_side_ism_agent(rsrc_adapt_dts_nac0_iosf_sb_ism_agent), 
    .rsrc_adapt_dts_nac0_side_pok(rsrc_adapt_dts_nac0_iosf_sb_side_pok), 
    .rsrc_adapt_dts_nac0_mnpput(rsrc_adapt_dts_nac0_iosf_sb_mnpput), 
    .rsrc_adapt_dts_nac0_mpcput(rsrc_adapt_dts_nac0_iosf_sb_mpcput), 
    .rsrc_adapt_dts_nac0_iosf_sb_mnpcup(rsrc_adapt_dts_nac0_iosf_sb_mnpcup), 
    .rsrc_adapt_dts_nac0_iosf_sb_mpccup(rsrc_adapt_dts_nac0_iosf_sb_mpccup), 
    .rsrc_adapt_dts_nac0_meom(rsrc_adapt_dts_nac0_iosf_sb_meom), 
    .rsrc_adapt_dts_nac0_mpayload(rsrc_adapt_dts_nac0_iosf_sb_mpayload), 
    .rsrc_adapt_dts_nac0_iosf_sb_tnpput(rsrc_adapt_dts_nac0_iosf_sb_tnpput), 
    .rsrc_adapt_dts_nac0_iosf_sb_tpcput(rsrc_adapt_dts_nac0_iosf_sb_tpcput), 
    .rsrc_adapt_dts_nac0_tnpcup(rsrc_adapt_dts_nac0_iosf_sb_tnpcup), 
    .rsrc_adapt_dts_nac0_tpccup(rsrc_adapt_dts_nac0_iosf_sb_tpccup), 
    .rsrc_adapt_dts_nac0_iosf_sb_teom(rsrc_adapt_dts_nac0_iosf_sb_teom), 
    .rsrc_adapt_dts_nac0_iosf_sb_tpayload(rsrc_adapt_dts_nac0_iosf_sb_tpayload), 
    .rsrc_adapt_dts_nac1_iosf_sb_ism_fabric(rsrc_adapt_dts_nac1_iosf_sb_ism_fabric), 
    .rsrc_adapt_dts_nac1_side_ism_agent(rsrc_adapt_dts_nac1_iosf_sb_ism_agent), 
    .rsrc_adapt_dts_nac1_side_pok(rsrc_adapt_dts_nac1_iosf_sb_side_pok), 
    .rsrc_adapt_dts_nac1_mnpput(rsrc_adapt_dts_nac1_iosf_sb_mnpput), 
    .rsrc_adapt_dts_nac1_mpcput(rsrc_adapt_dts_nac1_iosf_sb_mpcput), 
    .rsrc_adapt_dts_nac1_iosf_sb_mnpcup(rsrc_adapt_dts_nac1_iosf_sb_mnpcup), 
    .rsrc_adapt_dts_nac1_iosf_sb_mpccup(rsrc_adapt_dts_nac1_iosf_sb_mpccup), 
    .rsrc_adapt_dts_nac1_meom(rsrc_adapt_dts_nac1_iosf_sb_meom), 
    .rsrc_adapt_dts_nac1_mpayload(rsrc_adapt_dts_nac1_iosf_sb_mpayload), 
    .rsrc_adapt_dts_nac1_iosf_sb_tnpput(rsrc_adapt_dts_nac1_iosf_sb_tnpput), 
    .rsrc_adapt_dts_nac1_iosf_sb_tpcput(rsrc_adapt_dts_nac1_iosf_sb_tpcput), 
    .rsrc_adapt_dts_nac1_tnpcup(rsrc_adapt_dts_nac1_iosf_sb_tnpcup), 
    .rsrc_adapt_dts_nac1_tpccup(rsrc_adapt_dts_nac1_iosf_sb_tpccup), 
    .rsrc_adapt_dts_nac1_iosf_sb_teom(rsrc_adapt_dts_nac1_iosf_sb_teom), 
    .rsrc_adapt_dts_nac1_iosf_sb_tpayload(rsrc_adapt_dts_nac1_iosf_sb_tpayload), 
    .rsrc_adapt_dts_nac2_iosf_sb_ism_fabric(rsrc_adapt_dts_nac2_iosf_sb_ism_fabric), 
    .rsrc_adapt_dts_nac2_side_ism_agent(rsrc_adapt_dts_nac2_iosf_sb_ism_agent), 
    .rsrc_adapt_dts_nac2_side_pok(rsrc_adapt_dts_nac2_iosf_sb_side_pok), 
    .rsrc_adapt_dts_nac2_mnpput(rsrc_adapt_dts_nac2_iosf_sb_mnpput), 
    .rsrc_adapt_dts_nac2_mpcput(rsrc_adapt_dts_nac2_iosf_sb_mpcput), 
    .rsrc_adapt_dts_nac2_iosf_sb_mnpcup(rsrc_adapt_dts_nac2_iosf_sb_mnpcup), 
    .rsrc_adapt_dts_nac2_iosf_sb_mpccup(rsrc_adapt_dts_nac2_iosf_sb_mpccup), 
    .rsrc_adapt_dts_nac2_meom(rsrc_adapt_dts_nac2_iosf_sb_meom), 
    .rsrc_adapt_dts_nac2_mpayload(rsrc_adapt_dts_nac2_iosf_sb_mpayload), 
    .rsrc_adapt_dts_nac2_iosf_sb_tnpput(rsrc_adapt_dts_nac2_iosf_sb_tnpput), 
    .rsrc_adapt_dts_nac2_iosf_sb_tpcput(rsrc_adapt_dts_nac2_iosf_sb_tpcput), 
    .rsrc_adapt_dts_nac2_tnpcup(rsrc_adapt_dts_nac2_iosf_sb_tnpcup), 
    .rsrc_adapt_dts_nac2_tpccup(rsrc_adapt_dts_nac2_iosf_sb_tpccup), 
    .rsrc_adapt_dts_nac2_iosf_sb_teom(rsrc_adapt_dts_nac2_iosf_sb_teom), 
    .rsrc_adapt_dts_nac2_iosf_sb_tpayload(rsrc_adapt_dts_nac2_iosf_sb_tpayload), 
    .uc_ierr_agg_ra_o_uc_ierr(nac_ra_err), 
    .dts_nac2_v_anode(gpio_ne_v_anode), 
    .dts_nac2_v_cathode(gpio_ne_v_cathode), 
    .dts_nac2_i_anode(gpio_ne_i_anode), 
    .dts_nac2_v_anode_0(fabric_s5_v_anode), 
    .dts_nac2_v_cathode_0(fabric_s5_v_cathode), 
    .dts_nac2_i_cathode(nac_dts2_i_cathode), 
    .dts_nac2_i_anode_0(fabric_s5_i_anode), 
    .dts_nac2_i_anode_1(dts_nac2_i_anode_1), 
    .nac_tsrdhoriz_v_anode(nac_tsrdhoriz_v_anode), 
    .nac_tsrdhoriz_v_cathode(nac_tsrdhoriz_v_cathode), 
    .dts_nac1_i_anode(dts_nac1_i_anode), 
    .hlp_o_hlp_dts_diode0_anode(hlp_o_hlp_dts_diode0_anode), 
    .dts_nac1_i_cathode(dts_nac1_i_cathode), 
    .hlp_o_hlp_dts_diode0_cathode(hlp_o_hlp_dts_diode0_cathode), 
    .dts_nac1_i_anode_0(dts_nac1_i_anode_0), 
    .hlp_o_hlp_dts_diode1_anode(hlp_o_hlp_dts_diode1_anode), 
    .hlp_o_hlp_dts_diode1_cathode(hlp_o_hlp_dts_diode1_cathode), 
    .dts_nac1_i_anode_1(dts_nac1_i_anode_1), 
    .hlp_o_hlp_dts_diode2_anode(hlp_o_hlp_dts_diode2_anode), 
    .hlp_o_hlp_dts_diode2_cathode(hlp_o_hlp_dts_diode2_cathode), 
    .dts_nac0_i_anode(dts_nac0_i_anode), 
    .physs_ioa_pma_remote_diode_v_anode(physs_ioa_pma_remote_diode_v_anode), 
    .dts_nac0_i_cathode(dts_nac0_i_cathode), 
    .physs_ioa_pma_remote_diode_v_cathode(physs_ioa_pma_remote_diode_v_cathode), 
    .dts_nac0_i_anode_0(dts_nac0_i_anode_0), 
    .physs_ioa_pma_remote_diode_v_anode_0(physs_ioa_pma_remote_diode_v_anode_0), 
    .physs_ioa_pma_remote_diode_v_cathode_0(physs_ioa_pma_remote_diode_v_cathode_0), 
    .dts_nac0_i_anode_1(dts_nac0_i_anode_1), 
    .physs_ioa_pma_remote_diode_v_anode_1(physs_ioa_pma_remote_diode_v_anode_1), 
    .physs_ioa_pma_remote_diode_v_cathode_1(physs_ioa_pma_remote_diode_v_cathode_1), 
    .dts_nac0_i_anode_2(dts_nac0_i_anode_2), 
    .physs_ioa_pma_remote_diode_v_anode_2(physs_ioa_pma_remote_diode_v_anode_2), 
    .physs_ioa_pma_remote_diode_v_cathode_2(physs_ioa_pma_remote_diode_v_cathode_2), 
    .dts_nac0_i_anode_3(dts_nac0_i_anode_3), 
    .physs_ioa_pma_remote_diode_v_anode_3(physs_ioa_pma_remote_diode_v_anode_3), 
    .physs_ioa_pma_remote_diode_v_cathode_3(physs_ioa_pma_remote_diode_v_cathode_3), 
    .dts_nac0_i_anode_4(dts_nac0_i_anode_4), 
    .physs_ioa_pma_remote_diode_v_anode_4(physs_ioa_pma_remote_diode_v_anode_4), 
    .physs_ioa_pma_remote_diode_v_cathode_4(physs_ioa_pma_remote_diode_v_cathode_4), 
    .dts_nac0_i_anode_5(dts_nac0_i_anode_5), 
    .physs_ioa_pma_remote_diode_v_anode_5(physs_ioa_pma_remote_diode_v_anode_5), 
    .physs_ioa_pma_remote_diode_v_cathode_5(physs_ioa_pma_remote_diode_v_cathode_5), 
    .dts_nac0_i_anode_6(dts_nac0_i_anode_6), 
    .physs_ioa_pma_remote_diode_v_anode_6(physs_ioa_pma_remote_diode_v_anode_6), 
    .physs_ioa_pma_remote_diode_v_cathode_6(physs_ioa_pma_remote_diode_v_cathode_6), 
    .hif_pcie_gen6_phy_18a_pciephyss_nac_tsrdhoriz0_v_anode(hif_pcie_gen6_phy_18a_pciephyss_nac_tsrdhoriz0_v_anode), 
    .hif_pcie_gen6_phy_18a_pciephyss_nac_tsrdhoriz0_v_cathode(hif_pcie_gen6_phy_18a_pciephyss_nac_tsrdhoriz0_v_cathode), 
    .dts_nac2_i_anode_2(dts_nac2_i_anode_2), 
    .hif_pcie_gen6_phy_18a_pciephyss_nac_tsrdhoriz1_v_anode(hif_pcie_gen6_phy_18a_pciephyss_nac_tsrdhoriz1_v_anode), 
    .hif_pcie_gen6_phy_18a_pciephyss_nac_tsrdhoriz1_v_cathode(hif_pcie_gen6_phy_18a_pciephyss_nac_tsrdhoriz1_v_cathode), 
    .dts_nac2_i_anode_3(dts_nac2_i_anode_3), 
    .inf_iosfsb_rst_b(inf_iosfsb_rst_b), 
    .reset_cmd_ack(reset_cmd_ack), 
    .reset_error(reset_error), 
    .hif_pcie_gen6_phy_18a_reset_error(hif_pcie_gen6_phy_18a_reset_error), 
    .hif_pcie_gen6_phy_18a_reset_cmd_ack(hif_pcie_gen6_phy_18a_reset_cmd_ack), 
    .rsrc_adapt_nac_dts0_fsa_rst_b(rsrc_adapt_nac_dts0_fsa_rst_b), 
    .rsrc_adapt_nac_dts1_fsa_rst_b(rsrc_adapt_nac_dts1_fsa_rst_b), 
    .rsrc_adapt_nac_dts2_fsa_rst_b(rsrc_adapt_nac_dts2_fsa_rst_b), 
    .rsrc_adapt_bootpll_fsa_rst_b(rsrc_adapt_bootpll_fsa_rst_b), 
    .rsrc_adapt_tspll_fsa_rst_b(rsrc_adapt_tspll_fsa_rst_b), 
    .rsrc_adapt_nsspll_fsa_rst_b(rsrc_adapt_nsspll_fsa_rst_b), 
    .cmulbuf_buttr_fsa_rst_b(cmulbuf_buttr_fsa_rst_b), 
    .hif_pcie_gen6_phy_18a_pciephyss_nac_rstw_o_cmp(hif_pcie_gen6_phy_18a_pciephyss_nac_rstw_o_cmp), 
    .hif_pcie_gen6_phy_18a_pciephyss_nac_rstw_o_rdata(hif_pcie_gen6_phy_18a_pciephyss_nac_rstw_o_rdata), 
    .hif_pcie_gen6_phy_18a_pciephyss_nac_rstw_o_error(hif_pcie_gen6_phy_18a_pciephyss_nac_rstw_o_error), 
    .nac_soft_strap_rstw_o_valid(nac_soft_strap_rstw_o_valid), 
    .nac_soft_strap_rstw_o_write(nac_soft_strap_rstw_o_write), 
    .nac_soft_strap_rstw_o_wdata(nac_soft_strap_rstw_o_wdata), 
    .nac_soft_strap_rstw_o_addr(nac_soft_strap_rstw_o_addr), 
    .eth_fusebox_fuse_bus_7(eth_fusebox_fuse_bus_7), 
    .eth_fusebox_fuse_bus_8(eth_fusebox_fuse_bus_8), 
    .eth_fusebox_fuse_bus_9(eth_fusebox_fuse_bus_9), 
    .eth_fusebox_fuse_bus_10(eth_fusebox_fuse_bus_10), 
    .eth_fusebox_fuse_bus_11(eth_fusebox_fuse_bus_11), 
    .nac_glue_logic_inst_final_eth_bbl_fuse_disable_0(nac_glue_logic_inst_final_eth_bbl_fuse_disable_0), 
    .nac_glue_logic_inst_final_eth_bbl_fuse_disable_1(nac_glue_logic_inst_final_eth_bbl_fuse_disable_1), 
    .nac_glue_logic_inst_final_eth_bbl_fuse_disable_2(nac_glue_logic_inst_final_eth_bbl_fuse_disable_2), 
    .nac_glue_logic_inst_final_eth_bbl_fuse_disable_3(nac_glue_logic_inst_final_eth_bbl_fuse_disable_3), 
    .nac_glue_logic_inst_final_eth_bbl_fuse_disable_4(nac_glue_logic_inst_final_eth_bbl_fuse_disable_4), 
    .nac_glue_logic_inst_final_eth_bbl_fuse_disable_5(nac_glue_logic_inst_final_eth_bbl_fuse_disable_5), 
    .nac_glue_logic_inst_final_eth_bbl_fuse_disable_6(nac_glue_logic_inst_final_eth_bbl_fuse_disable_6), 
    .nac_glue_logic_inst_final_eth_bbl_fuse_disable_7(nac_glue_logic_inst_final_eth_bbl_fuse_disable_7), 
    .nac_glue_logic_inst_final_eth_bbl_fuse_disable_8(nac_glue_logic_inst_final_eth_bbl_fuse_disable_8), 
    .nac_glue_logic_inst_final_eth_bbl_fuse_disable_9(nac_glue_logic_inst_final_eth_bbl_fuse_disable_9), 
    .nac_glue_logic_inst_final_eth_bbl_fuse_disable_10(nac_glue_logic_inst_final_eth_bbl_fuse_disable_10), 
    .nac_glue_logic_inst_final_eth_bbl_fuse_disable_11(nac_glue_logic_inst_final_eth_bbl_fuse_disable_11), 
    .nac_glue_logic_inst_final_eth_bbl_fuse_disable_12(nac_glue_logic_inst_final_eth_bbl_fuse_disable_12), 
    .nac_glue_logic_inst_final_eth_bbl_fuse_disable_13(nac_glue_logic_inst_final_eth_bbl_fuse_disable_13),  
    .nac_glue_logic_inst_final_eth_bbl_fuse_disable_14(nac_glue_logic_inst_final_eth_bbl_fuse_disable_14), 
    .nac_glue_logic_inst_final_eth_bbl_fuse_disable_15(nac_glue_logic_inst_final_eth_bbl_fuse_disable_15), 
    .nac_glue_logic_inst_final_eth_bbl_fuse_disable_16(nac_glue_logic_inst_final_eth_bbl_fuse_disable_16), 
    .otp_fusebox_fuse_bus_270(otp_fusebox_fuse_bus_270), 
    .otp_fusebox_fuse_bus_271(otp_fusebox_fuse_bus_271), 
    .otp_fusebox_fuse_bus_272(otp_fusebox_fuse_bus_272), 
    .otp_fusebox_fuse_bus_273(otp_fusebox_fuse_bus_273), 
    .otp_fusebox_fuse_bus_274(otp_fusebox_fuse_bus_274), 
    .otp_fusebox_fuse_bus_275(otp_fusebox_fuse_bus_275), 
    .otp_fusebox_fuse_bus_276(otp_fusebox_fuse_bus_276), 
    .otp_fusebox_fuse_bus_277(otp_fusebox_fuse_bus_277), 
    .otp_fusebox_fuse_bus_278(otp_fusebox_fuse_bus_278), 
    .otp_fusebox_fuse_bus_279(otp_fusebox_fuse_bus_279), 
    .otp_fusebox_fuse_bus_280(otp_fusebox_fuse_bus_280), 
    .otp_fusebox_fuse_bus_281(otp_fusebox_fuse_bus_281), 
    .otp_fusebox_fuse_bus_282(otp_fusebox_fuse_bus_282), 
    .otp_fusebox_fuse_bus_283(otp_fusebox_fuse_bus_283), 
    .otp_fusebox_fuse_bus_284(otp_fusebox_fuse_bus_284), 
    .otp_fusebox_fuse_bus_285(otp_fusebox_fuse_bus_285), 
    .otp_fusebox_fuse_bus_286(otp_fusebox_fuse_bus_286), 
    .otp_fusebox_fuse_bus_287(otp_fusebox_fuse_bus_287), 
    .otp_fusebox_fuse_bus_288(otp_fusebox_fuse_bus_288), 
    .otp_fusebox_fuse_bus_289(otp_fusebox_fuse_bus_289), 
    .otp_fusebox_fuse_bus_290(otp_fusebox_fuse_bus_290), 
    .otp_fusebox_fuse_bus_291(otp_fusebox_fuse_bus_291), 
    .otp_fusebox_fuse_bus_292(otp_fusebox_fuse_bus_292), 
    .otp_fusebox_fuse_bus_293(otp_fusebox_fuse_bus_293), 
    .otp_fusebox_fuse_bus_294(otp_fusebox_fuse_bus_294), 
    .otp_fusebox_fuse_bus_295(otp_fusebox_fuse_bus_295), 
    .otp_fusebox_fuse_bus_296(otp_fusebox_fuse_bus_296), 
    .otp_fusebox_fuse_bus_297(otp_fusebox_fuse_bus_297), 
    .otp_fusebox_fuse_bus_298(otp_fusebox_fuse_bus_298), 
    .otp_fusebox_fuse_bus_299(otp_fusebox_fuse_bus_299), 
    .otp_fusebox_fuse_bus_300(otp_fusebox_fuse_bus_300), 
    .otp_fusebox_fuse_bus_301(otp_fusebox_fuse_bus_301), 
    .otp_fusebox_fuse_bus_302(otp_fusebox_fuse_bus_302), 
    .otp_fusebox_fuse_bus_303(otp_fusebox_fuse_bus_303), 
    .otp_fusebox_fuse_bus_304(otp_fusebox_fuse_bus_304), 
    .otp_fusebox_fuse_bus_305(otp_fusebox_fuse_bus_305), 
    .otp_fusebox_fuse_bus_306(otp_fusebox_fuse_bus_306), 
    .otp_fusebox_fuse_bus_307(otp_fusebox_fuse_bus_307), 
    .otp_fusebox_fuse_bus_308(otp_fusebox_fuse_bus_308), 
    .otp_fusebox_fuse_bus_309(otp_fusebox_fuse_bus_309), 
    .otp_fusebox_fuse_bus_310(otp_fusebox_fuse_bus_310), 
    .otp_fusebox_fuse_bus_311(otp_fusebox_fuse_bus_311), 
    .otp_fusebox_fuse_bus_312(otp_fusebox_fuse_bus_312), 
    .otp_fusebox_fuse_bus_313(otp_fusebox_fuse_bus_313), 
    .otp_fusebox_fuse_bus_314(otp_fusebox_fuse_bus_314), 
    .otp_fusebox_fuse_bus_315(otp_fusebox_fuse_bus_315), 
    .otp_fusebox_fuse_bus_316(otp_fusebox_fuse_bus_316), 
    .otp_fusebox_fuse_bus_317(otp_fusebox_fuse_bus_317), 
    .otp_fusebox_fuse_bus_318(otp_fusebox_fuse_bus_318), 
    .otp_fusebox_fuse_bus_319(otp_fusebox_fuse_bus_319), 
    .otp_fusebox_fuse_bus_320(otp_fusebox_fuse_bus_320), 
    .otp_fusebox_fuse_bus_321(otp_fusebox_fuse_bus_321), 
    .otp_fusebox_fuse_bus_322(otp_fusebox_fuse_bus_322), 
    .otp_fusebox_fuse_bus_323(otp_fusebox_fuse_bus_323), 
    .otp_fusebox_fuse_bus_324(otp_fusebox_fuse_bus_324), 
    .otp_fusebox_fuse_bus_325(otp_fusebox_fuse_bus_325), 
    .otp_fusebox_fuse_bus_326(otp_fusebox_fuse_bus_326), 
    .otp_fusebox_fuse_bus_327(otp_fusebox_fuse_bus_327), 
    .otp_fusebox_fuse_bus_328(otp_fusebox_fuse_bus_328), 
    .imcr_hwrs_qacceptn(imcr_hwrs_qacceptn), 
    .nac_glue_logic_inst_imcr_qacceptn_nsc(nac_glue_logic_inst_imcr_qacceptn_nsc), 
    .infraclk_div4_pdop_par_fabric_s5(infraclk_div4_pdop_par_fabric_s5), 
    .sb_repeater_adop_infraclk_div4_pdop_par_fabric_s5_clk_clkout(sb_repeater_adop_infraclk_div4_pdop_par_fabric_s5_clk_clkout), 
    .nss_nsc_dlw_tfb_trig_next_req_out(nss_nsc_dlw_tfb_trig_next_req_out), 
    .nss_nsc_dlw_tfb_trig_next_ack_out(nss_nsc_dlw_tfb_trig_next_ack_out), 
    .nsc_tfb_req_out_agent(nsc_tfb_req_out_agent), 
    .nsc_tfb_ack_out_agent(nsc_tfb_ack_out_agent), 
    .iosf2sfi_tfb_req_out_next(iosf2sfi_tfb_req_out_next), 
    .iosf2sfi_tfb_ack_out_next(iosf2sfi_tfb_ack_out_next), 
    .dts3_tfb_req_out_prev(dts3_tfb_req_out_prev), 
    .dts3_tfb_ack_out_prev(dts3_tfb_ack_out_prev), 
    .tfb_ubpc_par_nac_misc_adop_xtalclk_req_out_next(tfb_ubpc_par_nac_misc_adop_xtalclk_req_out_next), 
    .tfb_ubpc_par_nac_misc_adop_xtalclk_ack_out_next(tfb_ubpc_par_nac_misc_adop_xtalclk_ack_out_next), 
    .tfb_ubpc_eth_physs_rdop_fout0_req_out_prev(tfb_ubpc_eth_physs_rdop_fout0_req_out_prev), 
    .tfb_ubpc_eth_physs_rdop_fout0_ack_out_prev(tfb_ubpc_eth_physs_rdop_fout0_ack_out_prev), 
    .nac_ss_debug_apb_rst_n(nac_ss_debug_apb_rst_n), 
    .nac_ss_debug_serializer_hlp_misc_chain_out_to_nac(nac_ss_debug_serializer_hlp_misc_chain_out_to_nac), 
    .apb_dser_cmlbuf_btrs_dvp_serial_chain_out(apb_dser_cmlbuf_btrs_dvp_serial_chain_out), 
    .NW_OUT_par_nac_fabric1_from_tdo(par_nac_fabric1_NW_IN_tdo), 
    .NW_OUT_par_nac_fabric1_from_tdo_en(par_nac_fabric1_NW_IN_tdo_en), 
    .NW_OUT_par_nac_fabric1_ijtag_to_reset(par_nac_misc_NW_OUT_par_nac_fabric1_ijtag_to_reset), 
    .NW_OUT_par_nac_fabric1_ijtag_to_ce(par_nac_misc_NW_OUT_par_nac_fabric1_ijtag_to_ce), 
    .NW_OUT_par_nac_fabric1_ijtag_to_se(par_nac_misc_NW_OUT_par_nac_fabric1_ijtag_to_se), 
    .NW_OUT_par_nac_fabric1_ijtag_to_ue(par_nac_misc_NW_OUT_par_nac_fabric1_ijtag_to_ue), 
    .NW_OUT_par_nac_fabric1_ijtag_to_sel(par_nac_misc_NW_OUT_par_nac_fabric1_ijtag_to_sel), 
    .NW_OUT_par_nac_fabric1_ijtag_to_si(par_nac_misc_NW_OUT_par_nac_fabric1_ijtag_to_si), 
    .NW_OUT_par_nac_fabric1_ijtag_from_so(par_nac_fabric1_NW_IN_ijtag_so), 
    .NW_OUT_par_nac_fabric1_tap_sel_in(par_nac_fabric1_NW_IN_tap_sel_out), 
    .NW_OUT_par_nac_fabric2_from_tdo(par_nac_fabric2_NW_IN_tdo), 
    .NW_OUT_par_nac_fabric2_from_tdo_en(par_nac_fabric2_NW_IN_tdo_en), 
    .NW_OUT_par_nac_fabric2_ijtag_to_reset(par_nac_misc_NW_OUT_par_nac_fabric2_ijtag_to_reset), 
    .NW_OUT_par_nac_fabric2_ijtag_to_ce(par_nac_misc_NW_OUT_par_nac_fabric2_ijtag_to_ce), 
    .NW_OUT_par_nac_fabric2_ijtag_to_se(par_nac_misc_NW_OUT_par_nac_fabric2_ijtag_to_se), 
    .NW_OUT_par_nac_fabric2_ijtag_to_ue(par_nac_misc_NW_OUT_par_nac_fabric2_ijtag_to_ue), 
    .NW_OUT_par_nac_fabric2_ijtag_to_sel(par_nac_misc_NW_OUT_par_nac_fabric2_ijtag_to_sel), 
    .NW_OUT_par_nac_fabric2_ijtag_to_si(par_nac_misc_NW_OUT_par_nac_fabric2_ijtag_to_si), 
    .NW_OUT_par_nac_fabric2_ijtag_from_so(par_nac_fabric2_NW_IN_ijtag_so), 
    .NW_OUT_par_nac_fabric2_tap_sel_in(par_nac_fabric2_NW_IN_tap_sel_out), 
    .NW_IN_tms(tms), 
    .NW_IN_tck(tck), 
    .NW_IN_tdi(tdi), 
    .NW_IN_trst_b(trst_b), 
    .NW_IN_tdo(tdo), 
    .NW_IN_tdo_en(tdo_en), 
    .NW_IN_ijtag_reset_b(ijtag_reset_b), 
    .NW_IN_ijtag_capture(ijtag_capture), 
    .NW_IN_ijtag_shift(ijtag_shift), 
    .NW_IN_ijtag_update(ijtag_update), 
    .NW_IN_ijtag_select(ijtag_select), 
    .NW_IN_ijtag_si(ijtag_si), 
    .NW_IN_ijtag_so(ijtag_so), 
    .NW_IN_shift_ir_dr(shift_ir_dr), 
    .NW_IN_tms_park_value(tms_park_value), 
    .NW_IN_nw_mode(nw_mode), 
    .NW_IN_tap_sel_out(tap_sel_out), 
    .SSN_START_0_bus_data_in(ssn_bus_data_in), 
    .SSN_START_0_bus_clock_in(ssn_bus_clock_in), 
    .SSN_END_1_bus_data_out(ssn_bus_data_out), 
    .SSN_END_0_bus_data_out(par_nac_misc_SSN_END_0_bus_data_out), 
    .par_nac_misc_par_nac_fabric2_out_end_bus_data_out(par_nac_misc_par_nac_misc_par_nac_fabric2_out_end_bus_data_out), 
    .SSN_START_1_bus_data_in(par_nac_fabric1_SSN_END_2_bus_data_out), 
    .SSN_START_1_bus_clock_in(ssn_bus_clock_in), 
    .par_nac_misc_mux_par_nac_fabric_2_in_start_bus_data_in(par_nac_fabric2_SSN_END_1_bus_data_out), 
    .par_nac_misc_mux_par_nac_fabric_2_in_start_bus_clock_in(ssn_bus_clock_in), 
    .nac_ss_debug_timestamp(nac_ss_debug_timestamp), 
    .NW_OUT_nss_from_tdo_en(1'b0), 
    .par_nac_misc_mux_2__nss_in_start_bus_clock_in(1'b0), 
    .ETHPHY_PD1_bisr_chain_so(1'b0), 
    .NSC_imc_pd0_bisr_chain_so(1'b0), 
    .NSC_nmc_pd1_bisr_chain_so(1'b0), 
    .NSC_rdma_pd2_bisr_chain_so(1'b0), 
    .NSC_ate_pd3_bisr_chain_so(1'b0), 
    .NSC_hifnoc_pd4_bisr_chain_so(1'b0), 
    .NSC_fxp_pd5_bisr_chain_so(1'b0), 
    .NSC_bsr_pd6_bisr_chain_so(1'b0), 
    .NSC_hif_pd7_bisr_chain_so(1'b0), 
    .NSC_cosq_pd8_bisr_chain_so(1'b0), 
    .NSC_ipr_pd9_bisr_chain_so(1'b0), 
    .NSC_icm_pd10_bisr_chain_so(1'b0), 
    .NSC_cxp_pd11_bisr_chain_so(1'b0), 
    .NSC_pkb_pd12_bisr_chain_so(1'b0), 
    .NSC_lan_pd13_bisr_chain_so(1'b0), 
    .NSC_ts_pd14_bisr_chain_so(1'b0), 
    .NSC_sep_pd15_bisr_chain_so(1'b0), 
    .NSC_nlf_pd16_bisr_chain_so(1'b0), 
    .sense_vcc_a_1(), 
    .sense_vcc_a_2(), 
    .NW_OUT_nss_to_trst(), 
    .NW_OUT_nss_to_tck(), 
    .NW_OUT_nss_to_tms(), 
    .NW_OUT_nss_to_tdi(), 
    .NW_OUT_par_nac_fabric1_to_trst(), 
    .NW_OUT_par_nac_fabric1_to_tck(), 
    .NW_OUT_par_nac_fabric1_to_tms(), 
    .NW_OUT_par_nac_fabric1_to_tdi(), 
    .NW_OUT_par_nac_fabric2_to_trst(), 
    .NW_OUT_par_nac_fabric2_to_tck(), 
    .NW_OUT_par_nac_fabric2_to_tms(), 
    .NW_OUT_par_nac_fabric2_to_tdi(), 
    .NW_OUT_nss_ijtag_to_tck(), 
    .NW_OUT_nss_ijtag_to_ce(), 
    .NW_OUT_nss_ijtag_to_se(), 
    .NW_OUT_nss_ijtag_to_ue(), 
    .NW_OUT_par_nac_fabric1_ijtag_to_tck(), 
    .NW_OUT_par_nac_fabric2_ijtag_to_tck(), 
    .ETHPHY_PD1_bisr_chain_si(), 
    .ETHPHY_PD1_bisr_chain_clk(), 
    .ETHPHY_PD1_bisr_chain_rst(), 
    .ETHPHY_PD1_bisr_chain_se(), 
    .NSC_imc_pd0_bisr_chain_si(), 
    .NSC_imc_pd0_bisr_chain_clk(), 
    .NSC_imc_pd0_bisr_chain_rst(), 
    .NSC_imc_pd0_bisr_chain_se(), 
    .NSC_nmc_pd1_bisr_chain_si(), 
    .NSC_nmc_pd1_bisr_chain_clk(), 
    .NSC_nmc_pd1_bisr_chain_rst(), 
    .NSC_nmc_pd1_bisr_chain_se(), 
    .NSC_rdma_pd2_bisr_chain_si(), 
    .NSC_rdma_pd2_bisr_chain_clk(), 
    .NSC_rdma_pd2_bisr_chain_rst(), 
    .NSC_rdma_pd2_bisr_chain_se(), 
    .NSC_ate_pd3_bisr_chain_si(), 
    .NSC_ate_pd3_bisr_chain_clk(), 
    .NSC_ate_pd3_bisr_chain_rst(), 
    .NSC_ate_pd3_bisr_chain_se(), 
    .NSC_hifnoc_pd4_bisr_chain_si(), 
    .NSC_hifnoc_pd4_bisr_chain_clk(), 
    .NSC_hifnoc_pd4_bisr_chain_rst(), 
    .NSC_hifnoc_pd4_bisr_chain_se(), 
    .NSC_fxp_pd5_bisr_chain_si(), 
    .NSC_fxp_pd5_bisr_chain_clk(), 
    .NSC_fxp_pd5_bisr_chain_rst(), 
    .NSC_fxp_pd5_bisr_chain_se(), 
    .NSC_bsr_pd6_bisr_chain_si(), 
    .NSC_bsr_pd6_bisr_chain_clk(), 
    .NSC_bsr_pd6_bisr_chain_rst(), 
    .NSC_bsr_pd6_bisr_chain_se(), 
    .NSC_hif_pd7_bisr_chain_si(), 
    .NSC_hif_pd7_bisr_chain_clk(), 
    .NSC_hif_pd7_bisr_chain_rst(), 
    .NSC_hif_pd7_bisr_chain_se(), 
    .NSC_cosq_pd8_bisr_chain_si(), 
    .NSC_cosq_pd8_bisr_chain_clk(), 
    .NSC_cosq_pd8_bisr_chain_rst(), 
    .NSC_cosq_pd8_bisr_chain_se(), 
    .NSC_ipr_pd9_bisr_chain_si(), 
    .NSC_ipr_pd9_bisr_chain_clk(), 
    .NSC_ipr_pd9_bisr_chain_rst(), 
    .NSC_ipr_pd9_bisr_chain_se(), 
    .NSC_icm_pd10_bisr_chain_si(), 
    .NSC_icm_pd10_bisr_chain_clk(), 
    .NSC_icm_pd10_bisr_chain_rst(), 
    .NSC_icm_pd10_bisr_chain_se(), 
    .NSC_cxp_pd11_bisr_chain_si(), 
    .NSC_cxp_pd11_bisr_chain_clk(), 
    .NSC_cxp_pd11_bisr_chain_rst(), 
    .NSC_cxp_pd11_bisr_chain_se(), 
    .NSC_pkb_pd12_bisr_chain_si(), 
    .NSC_pkb_pd12_bisr_chain_clk(), 
    .NSC_pkb_pd12_bisr_chain_rst(), 
    .NSC_pkb_pd12_bisr_chain_se(), 
    .NSC_lan_pd13_bisr_chain_si(), 
    .NSC_lan_pd13_bisr_chain_clk(), 
    .NSC_lan_pd13_bisr_chain_rst(), 
    .NSC_lan_pd13_bisr_chain_se(), 
    .NSC_ts_pd14_bisr_chain_si(), 
    .NSC_ts_pd14_bisr_chain_clk(), 
    .NSC_ts_pd14_bisr_chain_rst(), 
    .NSC_ts_pd14_bisr_chain_se(), 
    .NSC_sep_pd15_bisr_chain_si(), 
    .NSC_sep_pd15_bisr_chain_clk(), 
    .NSC_sep_pd15_bisr_chain_rst(), 
    .NSC_sep_pd15_bisr_chain_se(), 
    .NSC_nlf_pd16_bisr_chain_si(), 
    .NSC_nlf_pd16_bisr_chain_clk(), 
    .NSC_nlf_pd16_bisr_chain_rst(), 
    .NSC_nlf_pd16_bisr_chain_se()
) ; 
par_sn2sfi par_sn2sfi (
    .par_nac_misc_adop_xtalclk_clkout(par_nac_fabric1_par_nac_misc_adop_xtalclk_clkout_out_sn2sfi), 
    .sfi_clk_1g_in(par_nac_fabric1_sfi_clk_1g_in_out), 
    .sfi_clk_1g_in_out(par_sn2sfi_sfi_clk_1g_in_out), 
    .par_nac_misc_adop_infra_clk_clkout(par_nac_fabric1_par_nac_misc_adop_infra_clk_clkout_out_sn2sfi), 
    .dfd_dop_enable_sync_o(dfd_dop_enable_sync_o), 
    .eth_physs_rdop_fout3_clkout(par_nac_fabric1_eth_physs_rdop_fout3_clkout_sn2sfi), 
    .nac_ss_dtfb_upstream_rst_b(nac_ss_dtfb_upstream_rst_b), 
    .iosf2sfi_dtfa_upstream_active_in(dtf_rep_fab1_iosf2sfi_arb1_rep0_dtfr_upstream_d0_active_out), 
    .iosf2sfi_dtfa_upstream_credit_in(dtf_rep_fab1_iosf2sfi_arb1_rep0_dtfr_upstream_d0_credit_out), 
    .iosf2sfi_dtfa_upstream_sync_in(dtf_rep_fab1_iosf2sfi_arb1_rep0_dtfr_upstream_d0_sync_out), 
    .iosf2sfi_dtfa_dnstream_data_out(par_sn2sfi_iosf2sfi_dtfa_dnstream_data_out), 
    .iosf2sfi_dtfa_dnstream_header_out(par_sn2sfi_iosf2sfi_dtfa_dnstream_header_out), 
    .iosf2sfi_dtfa_dnstream_valid_out(par_sn2sfi_iosf2sfi_dtfa_dnstream_valid_out), 
    .sn2iosf_dtfa_upstream_active_in(dtf_rep_fab1_sn2iosf_arb1_rep0_dtfr_upstream_d0_active_out), 
    .sn2iosf_dtfa_upstream_credit_in(dtf_rep_fab1_sn2iosf_arb1_rep0_dtfr_upstream_d0_credit_out), 
    .sn2iosf_dtfa_upstream_sync_in(dtf_rep_fab1_sn2iosf_arb1_rep0_dtfr_upstream_d0_sync_out), 
    .sn2iosf_dtfa_dnstream_data_out(par_sn2sfi_sn2iosf_dtfa_dnstream_data_out), 
    .sn2iosf_dtfa_dnstream_header_out(par_sn2sfi_sn2iosf_dtfa_dnstream_header_out), 
    .sn2iosf_dtfa_dnstream_valid_out(par_sn2sfi_sn2iosf_dtfa_dnstream_valid_out), 
    .fdfx_pwrgood_rst_b(fdfx_pwrgood_rst_b), 
    .dfxagg_security_policy(fdfx_security_policy), 
    .dfxagg_policy_update(fdfx_policy_update), 
    .dfxagg_early_boot_debug_exit(fdfx_earlyboot_debug_exit), 
    .dfxagg_debug_capabilities_enabling(fdfx_debug_capabilities_enabling), 
    .dfxagg_debug_capabilities_enabling_valid(fdfx_debug_capabilities_enabling_valid), 
    .sn2sfi_rst_n(sn2sfi_rst_n), 
    .inf_iosfsb_rst_b(inf_iosfsb_rst_b), 
    .sn2sfi_powergood(sn2sfi_powergood), 
    .isa_iosf2sfi_isa_clk_ack(isa_iosf2sfi_isa_clk_ack), 
    .isa_sn2iosf_isa_clk_ack(isa_sn2iosf_isa_clk_ack), 
    .sn2sfi_iosf2sfi_isa_clk_req(iosf2sfi_isa_clk_req), 
    .sn2sfi_sn2iosf_isa_clk_req(sn2iosf_isa_clk_req), 
    .nac_ss_debug_safemode_isa_oob(nac_ss_debug_safemode_isa_oob), 
    .sfi_tx_link_txcon_req(sfi_tx_link_txcon_req), 
    .sfi_tx_link_rxcon_ack(sfi_tx_link_rxcon_ack), 
    .sfi_tx_link_rxdiscon_nack(sfi_tx_link_rxdiscon_nack), 
    .sfi_tx_link_rx_empty(sfi_tx_link_rx_empty), 
    .sfi_rx_link_txcon_req(sfi_rx_link_txcon_req), 
    .sfi_rx_link_rxcon_ack(sfi_rx_link_rxcon_ack), 
    .sfi_rx_link_rxdiscon_nack(sfi_rx_link_rxdiscon_nack), 
    .sfi_rx_link_rx_empty(sfi_rx_link_rx_empty), 
    .sfi_tx_hdr_valid(sfi_tx_hdr_valid), 
    .sfi_tx_hdr_early_valid(sfi_tx_hdr_early_valid), 
    .sfi_tx_hdr_block(sfi_tx_hdr_block), 
    .sfi_tx_hdr_header(sfi_tx_hdr_header), 
    .sfi_tx_hdr_info_bytes(sfi_tx_hdr_info_bytes), 
    .sfi_tx_hdr_crd_rtn_valid(sfi_tx_hdr_crd_rtn_valid), 
    .sfi_tx_hdr_crd_rtn_ded(sfi_tx_hdr_crd_rtn_ded), 
    .sfi_tx_hdr_crd_rtn_fc_id(sfi_tx_hdr_crd_rtn_fc_id), 
    .sfi_tx_hdr_crd_rtn_vc_id(sfi_tx_hdr_crd_rtn_vc_id), 
    .sfi_tx_hdr_crd_rtn_value(sfi_tx_hdr_crd_rtn_value), 
    .sfi_tx_hdr_crd_rtn_block(sfi_tx_hdr_crd_rtn_block), 
    .sfi_rx_hdr_valid(sfi_rx_hdr_valid), 
    .sfi_rx_hdr_early_valid(sfi_rx_hdr_early_valid), 
    .sfi_rx_hdr_block(sfi_rx_hdr_block), 
    .sfi_rx_header(sfi_rx_header), 
    .sfi_rx_hdr_info_bytes(sfi_rx_hdr_info_bytes), 
    .sfi_rx_hdr_crd_rtn_valid(sfi_rx_hdr_crd_rtn_valid), 
    .sfi_rx_hdr_crd_rtn_ded(sfi_rx_hdr_crd_rtn_ded), 
    .sfi_rx_hdr_crd_rtn_fc_id(sfi_rx_hdr_crd_rtn_fc_id), 
    .sfi_rx_hdr_crd_rtn_vc_id(sfi_rx_hdr_crd_rtn_vc_id), 
    .sfi_rx_hdr_crd_rtn_value(sfi_rx_hdr_crd_rtn_value), 
    .sfi_rx_hdr_crd_rtn_block(sfi_rx_hdr_crd_rtn_block), 
    .sfi_tx_data_valid(sfi_tx_data_valid), 
    .sfi_tx_data_early_valid(sfi_tx_data_early_valid), 
    .sfi_tx_data_block(sfi_tx_data_block), 
    .sfi_tx_data(sfi_tx_data), 
    .sfi_tx_data_parity(sfi_tx_data_parity), 
    .sfi_tx_data_start(sfi_tx_data_start), 
    .sfi_tx_data_info_byte(sfi_tx_data_info_byte), 
    .sfi_tx_data_end(sfi_tx_data_end), 
    .sfi_tx_data_poison(sfi_tx_data_poison), 
    .sfi_tx_data_edb(sfi_tx_data_edb), 
    .sfi_tx_data_aux_parity(sfi_tx_data_aux_parity), 
    .sfi_tx_data_crd_rtn_valid(sfi_tx_data_crd_rtn_valid), 
    .sfi_tx_data_crd_rtn_ded(sfi_tx_data_crd_rtn_ded), 
    .sfi_tx_data_crd_rtn_fc_id(sfi_tx_data_crd_rtn_fc_id), 
    .sfi_tx_data_crd_rtn_vc_id(sfi_tx_data_crd_rtn_vc_id), 
    .sfi_tx_data_crd_rtn_value(sfi_tx_data_crd_rtn_value), 
    .sfi_tx_data_crd_rtn_block(sfi_tx_data_crd_rtn_block), 
    .sfi_rx_data_valid(sfi_rx_data_valid), 
    .sfi_rx_data_early_valid(sfi_rx_data_early_valid), 
    .sfi_rx_data_block(sfi_rx_data_block), 
    .sfi_rx_data(sfi_rx_data), 
    .sfi_rx_data_parity(sfi_rx_data_parity), 
    .sfi_rx_data_start(sfi_rx_data_start), 
    .sfi_rx_data_info_byte(sfi_rx_data_info_byte), 
    .sfi_rx_data_end(sfi_rx_data_end), 
    .sfi_rx_data_poison(sfi_rx_data_poison), 
    .sfi_rx_data_edb(sfi_rx_data_edb), 
    .sfi_rx_data_aux_parity(sfi_rx_data_aux_parity), 
    .sfi_rx_data_crd_rtn_valid(sfi_rx_data_crd_rtn_valid), 
    .sfi_rx_data_crd_rtn_ded(sfi_rx_data_crd_rtn_ded), 
    .sfi_rx_data_crd_rtn_fc_id(sfi_rx_data_crd_rtn_fc_id), 
    .sfi_rx_data_crd_rtn_vc_id(sfi_rx_data_crd_rtn_vc_id), 
    .sfi_rx_data_crd_rtn_value(sfi_rx_data_crd_rtn_value), 
    .sfi_rx_data_crd_rtn_block(sfi_rx_data_crd_rtn_block), 
    .iosf2sfi_iosf_side_pok(iosf2sfi_iosf_side_pok), 
    .iosf2sfi_sb_side_ism_fabric(iosf2sfi_sb_side_ism_fabric), 
    .iosf2sfi_sb_side_ism_agent(iosf2sfi_sb_side_ism_agent), 
    .iosf2sfi_sb_mnpput(iosf2sfi_sb_mnpput), 
    .iosf2sfi_sb_mpcput(iosf2sfi_sb_mpcput), 
    .iosf2sfi_sb_mnpcup(iosf2sfi_sb_mnpcup), 
    .iosf2sfi_sb_mpccup(iosf2sfi_sb_mpccup), 
    .iosf2sfi_sb_meom(iosf2sfi_sb_meom), 
    .iosf2sfi_sb_mpayload(iosf2sfi_sb_mpayload), 
    .iosf2sfi_sb_tnpput(iosf2sfi_sb_tnpput), 
    .iosf2sfi_sb_tpcput(iosf2sfi_sb_tpcput), 
    .iosf2sfi_sb_tnpcup(iosf2sfi_sb_tnpcup), 
    .iosf2sfi_sb_tpccup(iosf2sfi_sb_tpccup), 
    .iosf2sfi_sb_teom(iosf2sfi_sb_teom), 
    .iosf2sfi_sb_tpayload(iosf2sfi_sb_tpayload), 
    .sn2iosf_side_pok(sn2iosf_side_pok), 
    .sn2iosf_sb_side_ism_fabric(sn2iosf_sb_side_ism_fabric), 
    .sn2iosf_sb_side_ism_agent(sn2iosf_sb_side_ism_agent), 
    .sn2iosf_sb_mpccup(sn2iosf_sb_mpccup), 
    .sn2iosf_sb_mnpcup(sn2iosf_sb_mnpcup), 
    .sn2iosf_sb_mpcput(sn2iosf_sb_mpcput), 
    .sn2iosf_sb_mnpput(sn2iosf_sb_mnpput), 
    .sn2iosf_sb_meom(sn2iosf_sb_meom), 
    .sn2iosf_sb_mpayload(sn2iosf_sb_mpayload), 
    .sn2iosf_sb_tpccup(sn2iosf_sb_tpccup), 
    .sn2iosf_sb_tnpcup(sn2iosf_sb_tnpcup), 
    .sn2iosf_sb_tpcput(sn2iosf_sb_tpcput), 
    .sn2iosf_sb_tnpput(sn2iosf_sb_tnpput), 
    .sn2iosf_sb_teom(sn2iosf_sb_teom), 
    .sn2iosf_sb_tpayload(sn2iosf_sb_tpayload), 
    .nac_ss_debug_iosf2sfi_apb_addr(nac_ss_debug_iosf2sfi_apb_addr), 
    .nac_ss_debug_iosf2sfi_apb_sel(nac_ss_debug_iosf2sfi_apb_sel), 
    .nac_ss_debug_iosf2sfi_apb_en(nac_ss_debug_iosf2sfi_apb_en), 
    .nac_ss_debug_iosf2sfi_apb_wr(nac_ss_debug_iosf2sfi_apb_wr), 
    .nac_ss_debug_iosf2sfi_apb_wdata(nac_ss_debug_iosf2sfi_apb_wdata), 
    .nac_ss_debug_iosf2sfi_apb_strb(nac_ss_debug_iosf2sfi_apb_strb), 
    .nac_ss_debug_iosf2sfi_apb_prot(nac_ss_debug_iosf2sfi_apb_prot), 
    .sn2sfi_iosf2sfi_dvp_pready(nac_ss_debug_iosf2sfi_apb_rdy), 
    .sn2sfi_iosf2sfi_dvp_pslverr(nac_ss_debug_iosf2sfi_apb_slverr), 
    .sn2sfi_iosf2sfi_dvp_prdata(nac_ss_debug_iosf2sfi_apb_rdata), 
    .nac_ss_debug_snib_apb_addr(nac_ss_debug_snib_apb_addr), 
    .nac_ss_debug_snib_apb_sel(nac_ss_debug_snib_apb_sel), 
    .nac_ss_debug_snib_apb_en(nac_ss_debug_snib_apb_en), 
    .nac_ss_debug_snib_apb_wr(nac_ss_debug_snib_apb_wr), 
    .nac_ss_debug_snib_apb_wdata(nac_ss_debug_snib_apb_wdata), 
    .nac_ss_debug_snib_apb_strb(nac_ss_debug_snib_apb_strb), 
    .nac_ss_debug_snib_apb_prot(nac_ss_debug_snib_apb_prot), 
    .sn2sfi_sn2iosf_dvp_pready(nac_ss_debug_snib_apb_rdy), 
    .sn2sfi_sn2iosf_dvp_pslverr(nac_ss_debug_snib_apb_slverr), 
    .sn2sfi_sn2iosf_dvp_prdata(nac_ss_debug_snib_apb_rdata), 
    .nac_ss_debug_timestamp(nac_ss_debug_timestamp), 
    .iosf2sfi_dtf_mid(8'hCF), 
    .sn2iosf_dtf_mid(8'hCF), 
    .iosf2sfi_dtf_cid(8'h30), 
    .sn2iosf_dtf_cid(8'h34), 
    .nss_hif_sfib_cpl_rtrgt1_tlp_halt(nss_hif_sfib_cpl_rtrgt1_tlp_halt), 
    .nss_hif_sfib_cpl_xali_tlp_data(nss_hif_sfib_cpl_xali_tlp_data), 
    .nss_hif_sfib_cpl_xali_tlp_dv(nss_hif_sfib_cpl_xali_tlp_dv), 
    .nss_hif_sfib_cpl_xali_tlp_dwen(nss_hif_sfib_cpl_xali_tlp_dwen), 
    .nss_hif_sfib_cpl_xali_tlp_eot(nss_hif_sfib_cpl_xali_tlp_eot), 
    .nss_hif_sfib_cpl_xali_tlp_fm_format(nss_hif_sfib_cpl_xali_tlp_fm_format), 
    .nss_hif_sfib_cpl_xali_tlp_grant(nss_hif_sfib_cpl_xali_tlp_grant), 
    .nss_hif_sfib_cpl_xali_tlp_hdr(nss_hif_sfib_cpl_xali_tlp_hdr), 
    .nss_hif_sfib_cpl_xali_tlp_hv(nss_hif_sfib_cpl_xali_tlp_hv), 
    .nss_hif_sfib_cpl_xali_tlp_hwen(nss_hif_sfib_cpl_xali_tlp_hwen), 
    .nss_hif_sfib_cpl_xali_tlp_nullified(nss_hif_sfib_cpl_xali_tlp_nullified), 
    .nss_hif_sfib_cpl_xali_tlp_poisoned(nss_hif_sfib_cpl_xali_tlp_poisoned), 
    .nss_hif_sfib_cpl_xali_tlp_soh(nss_hif_sfib_cpl_xali_tlp_soh), 
    .nss_hif_sfib_np_rtrgt1_tlp_halt(nss_hif_sfib_np_rtrgt1_tlp_halt), 
    .nss_hif_sfib_np_xali_tlp_data(nss_hif_sfib_np_xali_tlp_data), 
    .nss_hif_sfib_np_xali_tlp_dv(nss_hif_sfib_np_xali_tlp_dv), 
    .nss_hif_sfib_np_xali_tlp_dwen(nss_hif_sfib_np_xali_tlp_dwen), 
    .nss_hif_sfib_np_xali_tlp_eot(nss_hif_sfib_np_xali_tlp_eot), 
    .nss_hif_sfib_np_xali_tlp_fm_format(nss_hif_sfib_np_xali_tlp_fm_format), 
    .nss_hif_sfib_np_xali_tlp_grant(nss_hif_sfib_np_xali_tlp_grant), 
    .nss_hif_sfib_np_xali_tlp_hdr(nss_hif_sfib_np_xali_tlp_hdr), 
    .nss_hif_sfib_np_xali_tlp_hv(nss_hif_sfib_np_xali_tlp_hv), 
    .nss_hif_sfib_np_xali_tlp_hwen(nss_hif_sfib_np_xali_tlp_hwen), 
    .nss_hif_sfib_np_xali_tlp_nullified(nss_hif_sfib_np_xali_tlp_nullified), 
    .nss_hif_sfib_np_xali_tlp_poisoned(nss_hif_sfib_np_xali_tlp_poisoned), 
    .nss_hif_sfib_np_xali_tlp_soh(nss_hif_sfib_np_xali_tlp_soh), 
    .nss_hif_sfib_p_rtrgt1_tlp_halt(nss_hif_sfib_p_rtrgt1_tlp_halt), 
    .nss_hif_sfib_p_xali_tlp_data(nss_hif_sfib_p_xali_tlp_data), 
    .nss_hif_sfib_p_xali_tlp_dv(nss_hif_sfib_p_xali_tlp_dv), 
    .nss_hif_sfib_p_xali_tlp_dwen(nss_hif_sfib_p_xali_tlp_dwen), 
    .nss_hif_sfib_p_xali_tlp_eot(nss_hif_sfib_p_xali_tlp_eot), 
    .nss_hif_sfib_p_xali_tlp_fm_format(nss_hif_sfib_p_xali_tlp_fm_format), 
    .nss_hif_sfib_p_xali_tlp_grant(nss_hif_sfib_p_xali_tlp_grant), 
    .nss_hif_sfib_p_xali_tlp_hdr(nss_hif_sfib_p_xali_tlp_hdr), 
    .nss_hif_sfib_p_xali_tlp_hv(nss_hif_sfib_p_xali_tlp_hv), 
    .nss_hif_sfib_p_xali_tlp_hwen(nss_hif_sfib_p_xali_tlp_hwen), 
    .nss_hif_sfib_p_xali_tlp_nullified(nss_hif_sfib_p_xali_tlp_nullified), 
    .nss_hif_sfib_p_xali_tlp_poisoned(nss_hif_sfib_p_xali_tlp_poisoned), 
    .nss_hif_sfib_p_xali_tlp_soh(nss_hif_sfib_p_xali_tlp_soh), 
    .par_sn2sfi_cpl_rtrgt1_tlp_abort(par_sn2sfi_cpl_rtrgt1_tlp_abort), 
    .par_sn2sfi_cpl_rtrgt1_tlp_data(par_sn2sfi_cpl_rtrgt1_tlp_data), 
    .par_sn2sfi_cpl_rtrgt1_tlp_dv(par_sn2sfi_cpl_rtrgt1_tlp_dv), 
    .par_sn2sfi_cpl_rtrgt1_tlp_dwen(par_sn2sfi_cpl_rtrgt1_tlp_dwen), 
    .par_sn2sfi_cpl_rtrgt1_tlp_eot(par_sn2sfi_cpl_rtrgt1_tlp_eot), 
    .par_sn2sfi_cpl_rtrgt1_tlp_fm_format(par_sn2sfi_cpl_rtrgt1_tlp_fm_format), 
    .par_sn2sfi_cpl_rtrgt1_tlp_hdr(par_sn2sfi_cpl_rtrgt1_tlp_hdr), 
    .par_sn2sfi_cpl_rtrgt1_tlp_hv(par_sn2sfi_cpl_rtrgt1_tlp_hv), 
    .par_sn2sfi_cpl_rtrgt1_tlp_hwen(par_sn2sfi_cpl_rtrgt1_tlp_hwen), 
    .par_sn2sfi_cpl_rtrgt1_tlp_nullified(par_sn2sfi_cpl_rtrgt1_tlp_nullified), 
    .par_sn2sfi_cpl_rtrgt1_tlp_poisoned(par_sn2sfi_cpl_rtrgt1_tlp_poisoned), 
    .par_sn2sfi_cpl_rtrgt1_tlp_porder(par_sn2sfi_cpl_rtrgt1_tlp_porder), 
    .par_sn2sfi_cpl_rtrgt1_tlp_soh(par_sn2sfi_cpl_rtrgt1_tlp_soh), 
    .par_sn2sfi_cpl_xali_tlp_halt(par_sn2sfi_cpl_xali_tlp_halt), 
    .par_sn2sfi_np_rtrgt1_tlp_abort(par_sn2sfi_np_rtrgt1_tlp_abort), 
    .par_sn2sfi_np_rtrgt1_tlp_data(par_sn2sfi_np_rtrgt1_tlp_data), 
    .par_sn2sfi_np_rtrgt1_tlp_dv(par_sn2sfi_np_rtrgt1_tlp_dv), 
    .par_sn2sfi_np_rtrgt1_tlp_dwen(par_sn2sfi_np_rtrgt1_tlp_dwen), 
    .par_sn2sfi_np_rtrgt1_tlp_eot(par_sn2sfi_np_rtrgt1_tlp_eot), 
    .par_sn2sfi_np_rtrgt1_tlp_fm_format(par_sn2sfi_np_rtrgt1_tlp_fm_format), 
    .par_sn2sfi_np_rtrgt1_tlp_hdr(par_sn2sfi_np_rtrgt1_tlp_hdr), 
    .par_sn2sfi_np_rtrgt1_tlp_hv(par_sn2sfi_np_rtrgt1_tlp_hv), 
    .par_sn2sfi_np_rtrgt1_tlp_hwen(par_sn2sfi_np_rtrgt1_tlp_hwen), 
    .par_sn2sfi_np_rtrgt1_tlp_nullified(par_sn2sfi_np_rtrgt1_tlp_nullified), 
    .par_sn2sfi_np_rtrgt1_tlp_poisoned(par_sn2sfi_np_rtrgt1_tlp_poisoned), 
    .par_sn2sfi_np_rtrgt1_tlp_porder(par_sn2sfi_np_rtrgt1_tlp_porder), 
    .par_sn2sfi_np_rtrgt1_tlp_soh(par_sn2sfi_np_rtrgt1_tlp_soh), 
    .par_sn2sfi_np_xali_tlp_halt(par_sn2sfi_np_xali_tlp_halt), 
    .par_sn2sfi_p_rtrgt1_tlp_abort(par_sn2sfi_p_rtrgt1_tlp_abort), 
    .par_sn2sfi_p_rtrgt1_tlp_data(par_sn2sfi_p_rtrgt1_tlp_data), 
    .par_sn2sfi_p_rtrgt1_tlp_dv(par_sn2sfi_p_rtrgt1_tlp_dv), 
    .par_sn2sfi_p_rtrgt1_tlp_dwen(par_sn2sfi_p_rtrgt1_tlp_dwen), 
    .par_sn2sfi_p_rtrgt1_tlp_eot(par_sn2sfi_p_rtrgt1_tlp_eot), 
    .par_sn2sfi_p_rtrgt1_tlp_fm_format(par_sn2sfi_p_rtrgt1_tlp_fm_format), 
    .par_sn2sfi_p_rtrgt1_tlp_hdr(par_sn2sfi_p_rtrgt1_tlp_hdr), 
    .par_sn2sfi_p_rtrgt1_tlp_hv(par_sn2sfi_p_rtrgt1_tlp_hv), 
    .par_sn2sfi_p_rtrgt1_tlp_hwen(par_sn2sfi_p_rtrgt1_tlp_hwen), 
    .par_sn2sfi_p_rtrgt1_tlp_nullified(par_sn2sfi_p_rtrgt1_tlp_nullified), 
    .par_sn2sfi_p_rtrgt1_tlp_poisoned(par_sn2sfi_p_rtrgt1_tlp_poisoned), 
    .par_sn2sfi_p_rtrgt1_tlp_porder(par_sn2sfi_p_rtrgt1_tlp_porder), 
    .par_sn2sfi_p_rtrgt1_tlp_soh(par_sn2sfi_p_rtrgt1_tlp_soh), 
    .par_sn2sfi_p_xali_tlp_halt(par_sn2sfi_p_xali_tlp_halt), 
    .par_sn2sfi_p_rtrgt1_tlp_p0_pending(par_sn2sfi_p_rtrgt1_tlp_p0_pending), 
    .sn2sfi_sn2iosf_dvp_trig_fabric_out(sn2sfi_sn2iosf_dvp_trig_fabric_out), 
    .sn2sfi_sn2iosf_dvp_trig_fabric_in_ack(sn2sfi_sn2iosf_dvp_trig_fabric_in_ack), 
    .sn2iosf_tfb_req_out_agent(sn2iosf_tfb_req_out_agent), 
    .sn2iosf_tfb_ack_out_agent(sn2iosf_tfb_ack_out_agent), 
    .sn2sfi_iosf2sfi_dvp_trig_fabric_out(sn2sfi_iosf2sfi_dvp_trig_fabric_out), 
    .sn2sfi_iosf2sfi_dvp_trig_fabric_in_ack(sn2sfi_iosf2sfi_dvp_trig_fabric_in_ack), 
    .iosf2sfi_tfb_req_out_agent(iosf2sfi_tfb_req_out_agent), 
    .iosf2sfi_tfb_ack_out_agent(iosf2sfi_tfb_ack_out_agent), 
    .NW_IN_tdo(par_sn2sfi_NW_IN_tdo), 
    .NW_IN_tdo_en(par_sn2sfi_NW_IN_tdo_en), 
    .NW_IN_ijtag_reset_b(par_nac_fabric1_NW_OUT_par_sn2sfi_ijtag_to_reset), 
    .NW_IN_ijtag_capture(par_nac_fabric1_NW_OUT_par_sn2sfi_ijtag_to_ce), 
    .NW_IN_ijtag_shift(par_nac_fabric1_NW_OUT_par_sn2sfi_ijtag_to_se), 
    .NW_IN_ijtag_update(par_nac_fabric1_NW_OUT_par_sn2sfi_ijtag_to_ue), 
    .NW_IN_ijtag_select(par_nac_fabric1_NW_OUT_par_sn2sfi_ijtag_to_sel), 
    .NW_IN_ijtag_si(par_nac_fabric1_NW_OUT_par_sn2sfi_ijtag_to_si), 
    .NW_IN_ijtag_so(par_sn2sfi_NW_IN_ijtag_so), 
    .NW_IN_tap_sel_out(par_sn2sfi_NW_IN_tap_sel_out), 
    .NW_IN_tms(tms), 
    .NW_IN_tck(tck), 
    .NW_IN_tdi(tdi), 
    .NW_IN_trst_b(trst_b), 
    .NW_IN_shift_ir_dr(shift_ir_dr), 
    .NW_IN_tms_park_value(tms_park_value), 
    .NW_IN_nw_mode(nw_mode), 
    .SSN_END_0_bus_data_out(par_sn2sfi_SSN_END_0_bus_data_out), 
    .SSN_START_0_bus_data_in(par_nac_fabric1_SSN_END_0_bus_data_out), 
    .SSN_START_0_bus_clock_in(ssn_bus_clock_in)
) ; 
/*par_eusb_phy par_eusb_phy (
    .EUSB2_EDM(EUSB2_EDM), 
    .EUSB2_EDP(EUSB2_EDP), 
    .EUSB2_RESREF(EUSB2_RESREF), 
    .EUSB2_ANALOGTEST(EUSB2_ANALOGTEST), 
    .EUSB2_VBUS_VALID_EXT(EUSB2_VBUS_VALID_EXT), 
    .nss_t_usb_phy_c_paddr(nss_t_usb_phy_c_paddr), 
    .nss_t_usb_phy_c_penable(nss_t_usb_phy_c_penable), 
    .dwc_eusb2_phy_1p_ns_apb_rdata(dwc_eusb2_phy_1p_ns_apb_rdata), 
    .dwc_eusb2_phy_1p_ns_apb_rdy(dwc_eusb2_phy_1p_ns_apb_rdy), 
    .nss_eusb2_phy_presetn(nss_eusb2_phy_presetn), 
    .nss_t_usb_phy_c_psel(nss_t_usb_phy_c_psel), 
    .dwc_eusb2_phy_1p_ns_apb_slverr(dwc_eusb2_phy_1p_ns_apb_slverr), 
    .nss_t_usb_phy_c_pwdata(nss_t_usb_phy_c_pwdata), 
    .nss_t_usb_phy_c_pwrite(nss_t_usb_phy_c_pwrite), 
    .ocla_clk(par_eusb_phy_ocla_clk), 
    .ocla_data(par_eusb_phy_ocla_data), 
    .ocla_data_vld(par_eusb_phy_ocla_data_vld), 
    .nss_eusb2_phy_reset(nss_eusb2_phy_reset), 
    .dwc_eusb2_phy_1p_ns_utmi_hostdisconnect(dwc_eusb2_phy_1p_ns_utmi_hostdisconnect), 
    .dwc_eusb2_phy_1p_ns_utmi_linestate(dwc_eusb2_phy_1p_ns_utmi_linestate), 
    .nss_utmi_opmode(nss_utmi_opmode), 
    .nss_utmi_port_reset(nss_utmi_port_reset), 
    .dwc_eusb2_phy_1p_ns_utmi_rx_data(dwc_eusb2_phy_1p_ns_utmi_rx_data), 
    .dwc_eusb2_phy_1p_ns_utmi_rxactive(dwc_eusb2_phy_1p_ns_utmi_rxactive), 
    .dwc_eusb2_phy_1p_ns_utmi_rxerror(dwc_eusb2_phy_1p_ns_utmi_rxerror), 
    .dwc_eusb2_phy_1p_ns_utmi_rxvalid(dwc_eusb2_phy_1p_ns_utmi_rxvalid), 
    .nss_utmi_termselect(nss_utmi_termselect), 
    .nss_utmi_tx_data(nss_utmi_tx_data), 
    .dwc_eusb2_phy_1p_ns_utmi_txready(dwc_eusb2_phy_1p_ns_utmi_txready), 
    .nss_utmi_txvalid(nss_utmi_txvalid), 
    .nss_utmi_xcvrselect(nss_utmi_xcvrselect), 
    .nss_phy_cfg_jtag_apb_sel(nss_phy_cfg_jtag_apb_sel), 
    .nss_phy_cfg_cr_clk_sel(nss_phy_cfg_cr_clk_sel), 
    .nss_phy_enable(nss_phy_enable), 
    .nss_utmi_suspend_n(nss_utmi_suspend_n), 
    .utmi_hvm_byp_clk(par_nac_fabric0_bclk1_out_usb), 
    .utmi_clk_rdop_par_eusb_phy_clkout(utmi_clk_rdop_par_eusb_phy_clkout), 
    .nss_eusb2_phy_pclk(nss_eusb2_phy_pclk), 
    .boot_20_rdop_fout5_clkout(par_nac_fabric0_boot_20_rdop_fout5_clkout_out), 
    .utmi_clk_rdop_par_eusb_phy_clkbuf_clkout(utmi_clk_rdop_par_eusb_phy_clkbuf_clkout), 
    .fdfx_pwrgood_rst_b(fdfx_pwrgood_rst_b), 
    .adfx_tap_grpA_enable(dfxsecure_plugin_dpt2_par_nac_fabric0_adfx_tap_grpA_enable), 
    .adfx_tap_grpB_enable(dfxsecure_plugin_dpt2_par_nac_fabric0_adfx_tap_grpB_enable), 
    .adfx_tap_grpC_enable(dfxsecure_plugin_dpt2_par_nac_fabric0_adfx_tap_grpC_enable), 
    .adfx_tap_grpD_enable(dfxsecure_plugin_dpt2_par_nac_fabric0_adfx_tap_grpD_enable), 
    .adfx_tap_grpE_enable(dfxsecure_plugin_dpt2_par_nac_fabric0_adfx_tap_grpE_enable), 
    .adfx_tap_grpF_enable(dfxsecure_plugin_dpt2_par_nac_fabric0_adfx_tap_grpF_enable), 
    .adfx_tap_grpG_enable(dfxsecure_plugin_dpt2_par_nac_fabric0_adfx_tap_grpG_enable), 
    .adfx_tap_grpH_enable(dfxsecure_plugin_dpt2_par_nac_fabric0_adfx_tap_grpH_enable), 
    .adfx_tap_grpZ_enable(dfxsecure_plugin_dpt2_par_nac_fabric0_adfx_tap_grpZ_enable), 
    .phy_cfg_jtag_apb_sel_ovr(par_nac_fabric0_phy_cfg_jtag_apb_sel_ovr), 
    .phy_cfg_jtag_apb_sel_val(par_nac_fabric0_phy_cfg_jtag_apb_sel_val), 
    .test_burnin(par_nac_fabric0_test_burnin), 
    .test_iddq(par_nac_fabric0_test_iddq), 
    .test_loopback_en(par_nac_fabric0_test_loopback_en), 
    .test_stop_clk_en(par_nac_fabric0_test_stop_clk_en), 
    .scan_occ_clkgen_chain_bypass(par_nac_fabric0_scan_occ_clkgen_chain_bypass), 
    .phy_cfg_cr_clk_sel_ovr(par_nac_fabric0_phy_cfg_cr_clk_sel_ovr), 
    .phy_cfg_cr_clk_sel_val(par_nac_fabric0_phy_cfg_cr_clk_sel_val), 
    .phy_cfg_por_in_lx_ovr(par_nac_fabric0_phy_cfg_por_in_lx_ovr), 
    .phy_cfg_por_in_lx_val(par_nac_fabric0_phy_cfg_por_in_lx_val), 
    .phy_cfg_tx_fsls_vreg_bypass_ovr(par_nac_fabric0_phy_cfg_tx_fsls_vreg_bypass_ovr), 
    .phy_cfg_tx_fsls_vreg_bypass_val(par_nac_fabric0_phy_cfg_tx_fsls_vreg_bypass_val), 
    .ref_freq_sel_2_ovr(par_nac_fabric0_ref_freq_sel_2_0_ovr), 
    .ref_freq_sel_1_ovr(par_nac_fabric0_ref_freq_sel_2_0_ovr), 
    .ref_freq_sel_0_ovr(par_nac_fabric0_ref_freq_sel_2_0_ovr), 
    .ref_freq_sel_0_val(par_nac_fabric0_ref_freq_sel_2_0_val), 
    .ref_freq_sel_1_val(par_nac_fabric0_ref_freq_sel_2_0_val_0), 
    .ref_freq_sel_2_val(par_nac_fabric0_ref_freq_sel_2_0_val_1), 
    .utmi_suspend_n_ovr(par_nac_fabric0_utmi_suspend_n_ovr), 
    .utmi_suspend_n_val(par_nac_fabric0_utmi_suspend_n_val), 
    .phy_enable_ovr(par_nac_fabric0_phy_enable_ovr), 
    .phy_enable_val(par_nac_fabric0_phy_enable_val), 
    .phy_tx_dig_bypass_sel_ovr(par_nac_fabric0_phy_tx_dig_bypass_sel_ovr), 
    .phy_tx_dig_bypass_sel_val(par_nac_fabric0_phy_tx_dig_bypass_sel_val), 
    .scan_sclk_in(par_nac_fabric0_eusb_si_bgn), 
    .scan_ref_in(par_nac_fabric0_eusb_si_bgn_0), 
    .scan_pll_in(par_nac_fabric0_eusb_si_bgn_1), 
    .scan_pclk_in(par_nac_fabric0_eusb_si_bgn_2), 
    .scan_ocla_in(par_nac_fabric0_eusb_si_bgn_3), 
    .scan_occ_clkgen_in(par_nac_fabric0_eusb_si_bgn_4), 
    .scan_jtag_in(par_nac_fabric0_eusb_si_bgn_5), 
    .scan_apb_in(par_nac_fabric0_eusb_si_bgn_6), 
    .scan_sclk_out(par_eusb_phy_scan_sclk_out), 
    .scan_ref_out(par_eusb_phy_scan_ref_out), 
    .scan_pll_out(par_eusb_phy_scan_pll_out), 
    .scan_pclk_out(par_eusb_phy_scan_pclk_out), 
    .scan_ocla_out(par_eusb_phy_scan_ocla_out), 
    .scan_occ_clkgen_out(par_eusb_phy_scan_occ_clkgen_out), 
    .scan_jtag_out(par_eusb_phy_scan_jtag_out), 
    .scan_apb_out(par_eusb_phy_scan_apb_out), 
    .scan_sclk_clk(par_nac_fabric0_scan_sclk_clk), 
    .scan_ref_clk(par_nac_fabric0_scan_ref_clk), 
    .scan_pll_clk(par_nac_fabric0_scan_pll_clk), 
    .scan_pclk_clk(par_nac_fabric0_scan_pclk_clk), 
    .scan_ocla_clk(par_nac_fabric0_scan_ocla_clk), 
    .jtag_trst_n(par_nac_fabric0_eusb_jtag_trst_n), 
    .jtag_tms(par_nac_fabric0_eusb_jtag_tms), 
    .jtag_tdi(par_nac_fabric0_eusb_jtag_tdi), 
    .jtag_tck(par_nac_fabric0_eusb_jtag_tck), 
    .jtag_tdo_en(par_eusb_phy_jtag_tdo_en), 
    .jtag_tdo(par_eusb_phy_jtag_tdo), 
    .scan_set_rst(par_nac_fabric0_scan_set_rst), 
    .scan_shift(par_nac_fabric0_scan_shift), 
    .scan_shift_cg(par_nac_fabric0_scan_shift_cg), 
    .scan_mode(par_nac_fabric0_scan_mode), 
    .scan_asst_mode_en(par_nac_fabric0_scan_asst_mode_en), 
    .utmi_clk_bypass(par_nac_fabric0_utmi_clk_bypass), 
    .ldo_power_ready(par_eusb_phy_ldo_power_ready), 
    .XX_OPAD_SENSE_0p9(XX_OPAD_SENSE_0p9), 
    .dts_lvrref_a(dts_lvrref_a), 
    .nac_pwrgood_rst_b(nac_pwrgood_rst_b), 
    .xneldoehv_wrap_ldo_misc(otp_fusebox_fuse_bus_270), 
    .dfxagg_security_policy(8'b0), 
    .dfxagg_policy_update(1'b0), 
    .dfxagg_early_boot_debug_exit(1'b0), 
    .dfxagg_debug_capabilities_enabling(8'b0), 
    .dfxagg_debug_capabilities_enabling_valid(1'b0)
) ; */
hif_pcie_gen6_phy_18a hif_pcie_gen6_phy_18a (
    .pcie_phy0_xoa_aprobe(PCIE_PHY0_APROBE), 
    .pcie_phy0_xoa_aprobe2(PCIE_PHY0_APROBE2), 
    .rxn({PCIE_RX15_N,PCIE_RX14_N,PCIE_RX13_N,PCIE_RX12_N,PCIE_RX11_N,PCIE_RX10_N,PCIE_RX9_N,PCIE_RX8_N,PCIE_RX7_N,PCIE_RX6_N,PCIE_RX5_N,PCIE_RX4_N,PCIE_RX3_N,PCIE_RX2_N,PCIE_RX1_N,
            PCIE_RX0_N}), 
    .rxp({PCIE_RX15_P,PCIE_RX14_P,PCIE_RX13_P,PCIE_RX12_P,PCIE_RX11_P,PCIE_RX10_P,PCIE_RX9_P,PCIE_RX8_P,PCIE_RX7_P,PCIE_RX6_P,PCIE_RX5_P,PCIE_RX4_P,PCIE_RX3_P,PCIE_RX2_P,PCIE_RX1_P,
            PCIE_RX0_P}), 
    .txn({PCIE_TX15_N,PCIE_TX14_N,PCIE_TX13_N,PCIE_TX12_N,PCIE_TX11_N,PCIE_TX10_N,PCIE_TX9_N,PCIE_TX8_N,PCIE_TX7_N,PCIE_TX6_N,PCIE_TX5_N,PCIE_TX4_N,PCIE_TX3_N,PCIE_TX2_N,PCIE_TX1_N,
            PCIE_TX0_N}), 
    .txp({PCIE_TX15_P,PCIE_TX14_P,PCIE_TX13_P,PCIE_TX12_P,PCIE_TX11_P,PCIE_TX10_P,PCIE_TX9_P,PCIE_TX8_P,PCIE_TX7_P,PCIE_TX6_P,PCIE_TX5_P,PCIE_TX4_P,PCIE_TX3_P,PCIE_TX2_P,PCIE_TX1_P,
            PCIE_TX0_P}), 
    .ref_pad_clk_n({PCIE_REF_PAD_CLK3_N,PCIE_REF_PAD_CLK2_N,PCIE_REF_PAD_CLK1_N,PCIE_REF_PAD_CLK0_N}), 
    .ref_pad_clk_p({PCIE_REF_PAD_CLK3_P,PCIE_REF_PAD_CLK2_P,PCIE_REF_PAD_CLK1_P,PCIE_REF_PAD_CLK0_P}), 
    .pcie_phy0_xia_grcomp(PCIE_PHY0_GRCOMP), 
    .pcie_phy0_xia_grcompv(PCIE_PHY0_GRCOMPV), 
    .pcie_phy1_xoa_aprobe(PCIE_PHY1_APROBE), 
    .pcie_phy1_xoa_aprobe2(PCIE_PHY1_APROBE2), 
    .pcie_phy1_xia_grcomp(PCIE_PHY1_GRCOMP), 
    .pcie_phy1_xia_grcompv(PCIE_PHY1_GRCOMPV), 
    .pcie_phy2_xoa_aprobe(PCIE_PHY2_APROBE), 
    .pcie_phy2_xoa_aprobe2(PCIE_PHY2_APROBE2), 
    .pcie_phy2_xia_grcomp(PCIE_PHY2_GRCOMP), 
    .pcie_phy2_xia_grcompv(PCIE_PHY2_GRCOMPV), 
    .pcie_phy3_xoa_aprobe(PCIE_PHY3_APROBE), 
    .pcie_phy3_xoa_aprobe2(PCIE_PHY3_APROBE2), 
    .pcie_phy3_xia_grcomp(PCIE_PHY3_GRCOMP), 
    .pcie_phy3_xia_grcompv(PCIE_PHY3_GRCOMPV), 
    .fdfx_pwrgood_rst_b(fdfx_pwrgood_rst_b), 
    .reset_cmd_data(reset_cmd_data), 
    .reset_cmd_valid(reset_cmd_valid), 
    .reset_cmd_parity(reset_cmd_parity), 
    .pciephyss_rstw_rst_b(inf_rstbus_rst_b), 
    .nac_pciephyss_pwrgood_rst_b(nac_pwrgood_rst_b), 
    .i_soc_thermtrip_b_a(nac_pllthermtrip_err), 
    .apb_presetn(nss_scon_hifcar_rst_n), 
    .HVM_BCLK(par_nac_fabric0_bclk1_out_pcie), 
    .HVM_CLK_SEL(hvm_clk_sel_cnic), 
    .ss_mode(5'b0), 
    .pcie_phy_hif_spare(hif_pcie_gen6_phy_18a_pcie_phy_hif_spare), 
    .hif_pcie_phy_spare(nss_hif_pcie_phy0_spare_out), 
    .pciephyss_hif_intr_fatal_out(hif_pcie_gen6_phy_18a_pciephyss_hif_intr_fatal_out), 
    .hif_t_pcie_phycrif_pslverr(hif_pcie_gen6_phy_18a_hif_t_pcie_phycrif_pslverr), 
    .hif_t_pcie_phycrif_prdata(hif_pcie_gen6_phy_18a_hif_t_pcie_phycrif_prdata), 
    .hif_t_pcie_phycrif_pready(hif_pcie_gen6_phy_18a_hif_t_pcie_phycrif_pready), 
    .hif_t_pcie_phycrif_paddr(nss_hif_t_pcie_phycrif0_paddr), 
    .hif_t_pcie_phycrif_penable(nss_hif_t_pcie_phycrif0_penable), 
    .hif_t_pcie_phycrif_pprot(nss_hif_t_pcie_phycrif0_pprot), 
    .hif_t_pcie_phycrif_psel(nss_hif_t_pcie_phycrif0_psel), 
    .hif_t_pcie_phycrif_pstrb(nss_hif_t_pcie_phycrif0_pstrb), 
    .hif_t_pcie_phycrif_pwdata(nss_hif_t_pcie_phycrif0_pwdata), 
    .hif_t_pcie_phycrif_pwrite(nss_hif_t_pcie_phycrif0_pwrite), 
    .hif_t_pcie_phyctrl_pslverr(hif_pcie_gen6_phy_18a_hif_t_pcie_phyctrl_pslverr), 
    .hif_t_pcie_phyctrl_prdata(hif_pcie_gen6_phy_18a_hif_t_pcie_phyctrl_prdata), 
    .hif_t_pcie_phyctrl_pready(hif_pcie_gen6_phy_18a_hif_t_pcie_phyctrl_pready), 
    .hif_t_pcie_phyctrl_paddr(nss_hif_t_pcie_phyctrl0_paddr), 
    .hif_t_pcie_phyctrl_penable(nss_hif_t_pcie_phyctrl0_penable), 
    .hif_t_pcie_phyctrl_pprot(nss_hif_t_pcie_phyctrl0_pprot), 
    .hif_t_pcie_phyctrl_psel(nss_hif_t_pcie_phyctrl0_psel), 
    .hif_t_pcie_phyctrl_pstrb(nss_hif_t_pcie_phyctrl0_pstrb), 
    .hif_t_pcie_phyctrl_pwdata(nss_hif_t_pcie_phyctrl0_pwdata), 
    .hif_t_pcie_phyctrl_pwrite(nss_hif_t_pcie_phyctrl0_pwrite), 
    .phy_pcie0_pipe_clk(nss_phy_pcie0_pipe_clk), 
    .hif_pcie0_mac_phy_txdata(nss_hif_pcie0_mac_phy_txdata), 
    .hif_pcie0_mac_phy_txdatavalid(nss_hif_pcie0_mac_phy_txdatavalid), 
    .hif_pcie0_mac_phy_rxwidth(nss_hif_pcie0_mac_phy_rxwidth), 
    .hif_pcie0_mac_phy_txdetectrx_loopback(nss_hif_pcie0_mac_phy_txdetectrx_loopback), 
    .hif_pcie0_mac_phy_txelecidle(nss_hif_pcie0_mac_phy_txelecidle), 
    .hif_pcie0_mac_phy_powerdown(nss_hif_pcie0_mac_phy_powerdown), 
    .hif_pcie0_mac_phy_rxelecidle_disable(nss_hif_pcie0_mac_phy_rxelecidle_disable), 
    .hif_pcie0_mac_phy_txcommonmode_disable(nss_hif_pcie0_mac_phy_txcommonmode_disable), 
    .hif_pcie0_mac_phy_rate(nss_hif_pcie0_mac_phy_rate), 
    .hif_pcie0_mac_phy_width(nss_hif_pcie0_mac_phy_width), 
    .hif_pcie0_mac_phy_pclk_rate(nss_hif_pcie0_mac_phy_pclk_rate), 
    .hif_pcie0_mac_phy_rxstandby(nss_hif_pcie0_mac_phy_rxstandby), 
    .hif_pcie0_mac_phy_messagebus(nss_hif_pcie0_mac_phy_messagebus), 
    .hif_pcie0_mac_phy_serdes_arch(nss_hif_pcie0_mac_phy_serdes_arch), 
    .hif_pcie0_serdes_pipe_rxready(nss_hif_pcie0_serdes_pipe_rxready), 
    .hif_pcie0_mac_phy_commonclock_enable(nss_hif_pcie0_mac_phy_commonclock_enable), 
    .hif_pcie0_mac_phy_asyncpowerchangeack(nss_hif_pcie0_mac_phy_asyncpowerchangeack), 
    .hif_pcie0_mac_phy_sris_enable(nss_hif_pcie0_mac_phy_sris_enable), 
    .hif_pcie0_mac_phy_pclkchangeack(nss_hif_pcie0_mac_phy_pclkchangeack), 
    .hif_pcie0_phy_mac_pclkchangeok(hif_pcie_gen6_phy_18a_hif_pcie0_phy_mac_pclkchangeok), 
    .phy_pcie0_max_pclk(hif_pcie_gen6_phy_18a_phy_pcie0_max_pclk), 
    .hif_pcie0_phy_mac_rxdata(hif_pcie_gen6_phy_18a_hif_pcie0_phy_mac_rxdata), 
    .phy_pcie0_pipe_rx_clk(hif_pcie_gen6_phy_18a_phy_pcie0_pipe_rx_clk), 
    .hif_pcie0_phy_mac_rxstandbystatus(hif_pcie_gen6_phy_18a_hif_pcie0_phy_mac_rxstandbystatus), 
    .hif_pcie0_phy_mac_rxvalid(hif_pcie_gen6_phy_18a_hif_pcie0_phy_mac_rxvalid), 
    .hif_pcie0_phy_mac_phystatus(hif_pcie_gen6_phy_18a_hif_pcie0_phy_mac_phystatus), 
    .hif_pcie0_phy_mac_rxelecidle(hif_pcie_gen6_phy_18a_hif_pcie0_phy_mac_rxelecidle), 
    .hif_pcie0_phy_mac_rxstatus(hif_pcie_gen6_phy_18a_hif_pcie0_phy_mac_rxstatus), 
    .hif_pcie0_phy_mac_messagebus(hif_pcie_gen6_phy_18a_hif_pcie0_phy_mac_messagebus), 
    .phy_pcie2_pipe_clk(nss_phy_pcie2_pipe_clk), 
    .hif_pcie2_mac_phy_txdata(nss_hif_pcie2_mac_phy_txdata), 
    .hif_pcie2_mac_phy_txdatavalid(nss_hif_pcie2_mac_phy_txdatavalid), 
    .hif_pcie2_mac_phy_rxwidth(nss_hif_pcie2_mac_phy_rxwidth), 
    .hif_pcie2_mac_phy_txdetectrx_loopback(nss_hif_pcie2_mac_phy_txdetectrx_loopback), 
    .hif_pcie2_mac_phy_txelecidle(nss_hif_pcie2_mac_phy_txelecidle), 
    .hif_pcie2_mac_phy_powerdown(nss_hif_pcie2_mac_phy_powerdown), 
    .hif_pcie2_mac_phy_rxelecidle_disable(nss_hif_pcie2_mac_phy_rxelecidle_disable), 
    .hif_pcie2_mac_phy_txcommonmode_disable(nss_hif_pcie2_mac_phy_txcommonmode_disable), 
    .hif_pcie2_mac_phy_rate(nss_hif_pcie2_mac_phy_rate), 
    .hif_pcie2_mac_phy_width(nss_hif_pcie2_mac_phy_width), 
    .hif_pcie2_mac_phy_pclk_rate(nss_hif_pcie2_mac_phy_pclk_rate), 
    .hif_pcie2_mac_phy_rxstandby(nss_hif_pcie2_mac_phy_rxstandby), 
    .hif_pcie2_mac_phy_messagebus(nss_hif_pcie2_mac_phy_messagebus), 
    .hif_pcie2_mac_phy_serdes_arch(nss_hif_pcie2_mac_phy_serdes_arch), 
    .hif_pcie2_serdes_pipe_rxready(nss_hif_pcie2_serdes_pipe_rxready), 
    .hif_pcie2_mac_phy_commonclock_enable(nss_hif_pcie2_mac_phy_commonclock_enable), 
    .hif_pcie2_mac_phy_asyncpowerchangeack(nss_hif_pcie2_mac_phy_asyncpowerchangeack), 
    .hif_pcie2_mac_phy_sris_enable(nss_hif_pcie2_mac_phy_sris_enable), 
    .hif_pcie2_mac_phy_pclkchangeack(nss_hif_pcie2_mac_phy_pclkchangeack), 
    .hif_pcie2_phy_mac_pclkchangeok(hif_pcie_gen6_phy_18a_hif_pcie2_phy_mac_pclkchangeok), 
    .phy_pcie2_max_pclk(hif_pcie_gen6_phy_18a_phy_pcie2_max_pclk), 
    .hif_pcie2_phy_mac_rxdata(hif_pcie_gen6_phy_18a_hif_pcie2_phy_mac_rxdata), 
    .phy_pcie2_pipe_rx_clk(hif_pcie_gen6_phy_18a_phy_pcie2_pipe_rx_clk), 
    .hif_pcie2_phy_mac_rxstandbystatus(hif_pcie_gen6_phy_18a_hif_pcie2_phy_mac_rxstandbystatus), 
    .hif_pcie2_phy_mac_rxvalid(hif_pcie_gen6_phy_18a_hif_pcie2_phy_mac_rxvalid), 
    .hif_pcie2_phy_mac_phystatus(hif_pcie_gen6_phy_18a_hif_pcie2_phy_mac_phystatus), 
    .hif_pcie2_phy_mac_rxelecidle(hif_pcie_gen6_phy_18a_hif_pcie2_phy_mac_rxelecidle), 
    .hif_pcie2_phy_mac_rxstatus(hif_pcie_gen6_phy_18a_hif_pcie2_phy_mac_rxstatus), 
    .hif_pcie2_phy_mac_messagebus(hif_pcie_gen6_phy_18a_hif_pcie2_phy_mac_messagebus), 
    .phy_pcie4_pipe_clk(nss_phy_pcie4_pipe_clk), 
    .hif_pcie4_mac_phy_txdata(nss_hif_pcie4_mac_phy_txdata), 
    .hif_pcie4_mac_phy_txdatavalid(nss_hif_pcie4_mac_phy_txdatavalid), 
    .hif_pcie4_mac_phy_rxwidth(nss_hif_pcie4_mac_phy_rxwidth), 
    .hif_pcie4_mac_phy_txdetectrx_loopback(nss_hif_pcie4_mac_phy_txdetectrx_loopback), 
    .hif_pcie4_mac_phy_txelecidle(nss_hif_pcie4_mac_phy_txelecidle), 
    .hif_pcie4_mac_phy_powerdown(nss_hif_pcie4_mac_phy_powerdown), 
    .hif_pcie4_mac_phy_rxelecidle_disable(nss_hif_pcie4_mac_phy_rxelecidle_disable), 
    .hif_pcie4_mac_phy_txcommonmode_disable(nss_hif_pcie4_mac_phy_txcommonmode_disable), 
    .hif_pcie4_mac_phy_rate(nss_hif_pcie4_mac_phy_rate), 
    .hif_pcie4_mac_phy_width(nss_hif_pcie4_mac_phy_width), 
    .hif_pcie4_mac_phy_pclk_rate(nss_hif_pcie4_mac_phy_pclk_rate), 
    .hif_pcie4_mac_phy_rxstandby(nss_hif_pcie4_mac_phy_rxstandby), 
    .hif_pcie4_mac_phy_messagebus(nss_hif_pcie4_mac_phy_messagebus), 
    .hif_pcie4_mac_phy_serdes_arch(nss_hif_pcie4_mac_phy_serdes_arch), 
    .hif_pcie4_serdes_pipe_rxready(nss_hif_pcie4_serdes_pipe_rxready), 
    .hif_pcie4_mac_phy_commonclock_enable(nss_hif_pcie4_mac_phy_commonclock_enable), 
    .hif_pcie4_mac_phy_asyncpowerchangeack(nss_hif_pcie4_mac_phy_asyncpowerchangeack), 
    .hif_pcie4_mac_phy_sris_enable(nss_hif_pcie4_mac_phy_sris_enable), 
    .hif_pcie4_mac_phy_pclkchangeack(nss_hif_pcie4_mac_phy_pclkchangeack), 
    .hif_pcie4_phy_mac_pclkchangeok(hif_pcie_gen6_phy_18a_hif_pcie4_phy_mac_pclkchangeok), 
    .phy_pcie4_max_pclk(hif_pcie_gen6_phy_18a_phy_pcie4_max_pclk), 
    .hif_pcie4_phy_mac_rxdata(hif_pcie_gen6_phy_18a_hif_pcie4_phy_mac_rxdata), 
    .phy_pcie4_pipe_rx_clk(hif_pcie_gen6_phy_18a_phy_pcie4_pipe_rx_clk), 
    .hif_pcie4_phy_mac_rxstandbystatus(hif_pcie_gen6_phy_18a_hif_pcie4_phy_mac_rxstandbystatus), 
    .hif_pcie4_phy_mac_rxvalid(hif_pcie_gen6_phy_18a_hif_pcie4_phy_mac_rxvalid), 
    .hif_pcie4_phy_mac_phystatus(hif_pcie_gen6_phy_18a_hif_pcie4_phy_mac_phystatus), 
    .hif_pcie4_phy_mac_rxelecidle(hif_pcie_gen6_phy_18a_hif_pcie4_phy_mac_rxelecidle), 
    .hif_pcie4_phy_mac_rxstatus(hif_pcie_gen6_phy_18a_hif_pcie4_phy_mac_rxstatus), 
    .hif_pcie4_phy_mac_messagebus(hif_pcie_gen6_phy_18a_hif_pcie4_phy_mac_messagebus), 
    .phy_pcie6_pipe_clk(nss_phy_pcie6_pipe_clk), 
    .hif_pcie6_mac_phy_txdata(nss_hif_pcie6_mac_phy_txdata), 
    .hif_pcie6_mac_phy_txdatavalid(nss_hif_pcie6_mac_phy_txdatavalid), 
    .hif_pcie6_mac_phy_rxwidth(nss_hif_pcie6_mac_phy_rxwidth), 
    .hif_pcie6_mac_phy_txdetectrx_loopback(nss_hif_pcie6_mac_phy_txdetectrx_loopback), 
    .hif_pcie6_mac_phy_txelecidle(nss_hif_pcie6_mac_phy_txelecidle), 
    .hif_pcie6_mac_phy_powerdown(nss_hif_pcie6_mac_phy_powerdown), 
    .hif_pcie6_mac_phy_rxelecidle_disable(nss_hif_pcie6_mac_phy_rxelecidle_disable), 
    .hif_pcie6_mac_phy_txcommonmode_disable(nss_hif_pcie6_mac_phy_txcommonmode_disable), 
    .hif_pcie6_mac_phy_rate(nss_hif_pcie6_mac_phy_rate), 
    .hif_pcie6_mac_phy_width(nss_hif_pcie6_mac_phy_width), 
    .hif_pcie6_mac_phy_pclk_rate(nss_hif_pcie6_mac_phy_pclk_rate), 
    .hif_pcie6_mac_phy_rxstandby(nss_hif_pcie6_mac_phy_rxstandby), 
    .hif_pcie6_mac_phy_messagebus(nss_hif_pcie6_mac_phy_messagebus), 
    .hif_pcie6_mac_phy_serdes_arch(nss_hif_pcie6_mac_phy_serdes_arch), 
    .hif_pcie6_serdes_pipe_rxready(nss_hif_pcie6_serdes_pipe_rxready), 
    .hif_pcie6_mac_phy_commonclock_enable(nss_hif_pcie6_mac_phy_commonclock_enable), 
    .hif_pcie6_mac_phy_asyncpowerchangeack(nss_hif_pcie6_mac_phy_asyncpowerchangeack), 
    .hif_pcie6_mac_phy_sris_enable(nss_hif_pcie6_mac_phy_sris_enable), 
    .hif_pcie6_mac_phy_pclkchangeack(nss_hif_pcie6_mac_phy_pclkchangeack), 
    .hif_pcie6_phy_mac_pclkchangeok(hif_pcie_gen6_phy_18a_hif_pcie6_phy_mac_pclkchangeok), 
    .phy_pcie6_max_pclk(hif_pcie_gen6_phy_18a_phy_pcie6_max_pclk), 
    .hif_pcie6_phy_mac_rxdata(hif_pcie_gen6_phy_18a_hif_pcie6_phy_mac_rxdata), 
    .phy_pcie6_pipe_rx_clk(hif_pcie_gen6_phy_18a_phy_pcie6_pipe_rx_clk), 
    .hif_pcie6_phy_mac_rxstandbystatus(hif_pcie_gen6_phy_18a_hif_pcie6_phy_mac_rxstandbystatus), 
    .hif_pcie6_phy_mac_rxvalid(hif_pcie_gen6_phy_18a_hif_pcie6_phy_mac_rxvalid), 
    .hif_pcie6_phy_mac_phystatus(hif_pcie_gen6_phy_18a_hif_pcie6_phy_mac_phystatus), 
    .hif_pcie6_phy_mac_rxelecidle(hif_pcie_gen6_phy_18a_hif_pcie6_phy_mac_rxelecidle), 
    .hif_pcie6_phy_mac_rxstatus(hif_pcie_gen6_phy_18a_hif_pcie6_phy_mac_rxstatus), 
    .hif_pcie6_phy_mac_messagebus(hif_pcie_gen6_phy_18a_hif_pcie6_phy_mac_messagebus), 
    .hif_pcie0_mac_phy_maxpclkreq_n(1'b0), 
    .hif_pcie2_mac_phy_maxpclkreq_n(1'b0), 
    .hif_pcie4_mac_phy_maxpclkreq_n(1'b0), 
    .hif_pcie6_mac_phy_maxpclkreq_n(1'b0), 
    .hif_pcie0_serdes_pipe_turnoff_lanes(16'b0),  
    .hif_pcie2_serdes_pipe_turnoff_lanes(4'b0),  
    .hif_pcie4_serdes_pipe_turnoff_lanes(8'b0),  
    .hif_pcie6_serdes_pipe_turnoff_lanes(4'b0),  
    .pciephyss_dfd_infra_clk(par_nac_fabric0_par_nac_misc_adop_infra_clk_clkout_out), 
    .pciephyss_xtalclk(par_nac_fabric0_par_nac_misc_adop_xtalclk_clkout_out), 
    .nac_pciephyss_dfd_dop_enable(dfd_dop_enable), 
    .phy_pcie1_pipe_clk(2'b0),  
    .phy_pcie3_pipe_clk(2'b0),  
    .phy_pcie5_pipe_clk(2'b0),  
    .phy_pcie7_pipe_clk(2'b0),  
    .hif_pcie1_mac_phy_powerdown(4'b0),  
    .hif_pcie3_mac_phy_powerdown(4'b0),  
    .hif_pcie5_mac_phy_powerdown(4'b0),  
    .hif_pcie7_mac_phy_powerdown(4'b0),  
    .hif_pcie1_mac_phy_txdata(160'b0),  
    .hif_pcie3_mac_phy_txdata(160'b0),  
    .hif_pcie5_mac_phy_txdata(160'b0),  
    .hif_pcie7_mac_phy_txdata(160'b0),  
    .hif_pcie1_mac_phy_txdatavalid(2'b0),  
    .hif_pcie3_mac_phy_txdatavalid(2'b0),  
    .hif_pcie5_mac_phy_txdatavalid(2'b0),  
    .hif_pcie7_mac_phy_txdatavalid(2'b0),  
    .hif_pcie1_mac_phy_txdetectrx_loopback(2'b0),  
    .hif_pcie3_mac_phy_txdetectrx_loopback(2'b0),  
    .hif_pcie5_mac_phy_txdetectrx_loopback(2'b0),  
    .hif_pcie7_mac_phy_txdetectrx_loopback(2'b0),  
    .hif_pcie1_mac_phy_txelecidle(8'b0),  
    .hif_pcie3_mac_phy_txelecidle(8'b0),  
    .hif_pcie5_mac_phy_txelecidle(8'b0),  
    .hif_pcie7_mac_phy_txelecidle(8'b0),  
    .hif_pcie1_mac_phy_width(2'b0),  
    .hif_pcie3_mac_phy_width(2'b0),  
    .hif_pcie5_mac_phy_width(2'b0),  
    .hif_pcie7_mac_phy_width(2'b0),  
    .hif_pcie1_mac_phy_serdes_arch(1'b0),  
    .hif_pcie3_mac_phy_serdes_arch(1'b0),  
    .hif_pcie5_mac_phy_serdes_arch(1'b0),  
    .hif_pcie7_mac_phy_serdes_arch(1'b0),  
    .hif_pcie1_mac_phy_rxwidth(2'b0),  
    .hif_pcie3_mac_phy_rxwidth(2'b0),  
    .hif_pcie5_mac_phy_rxwidth(2'b0),  
    .hif_pcie7_mac_phy_rxwidth(2'b0),  
    .hif_pcie1_serdes_pipe_rxready(2'b0),  
    .hif_pcie3_serdes_pipe_rxready(2'b0),  
    .hif_pcie5_serdes_pipe_rxready(2'b0),  
    .hif_pcie7_serdes_pipe_rxready(2'b0),  
    .hif_pcie1_serdes_pipe_turnoff_lanes(2'b0),  
    .hif_pcie3_serdes_pipe_turnoff_lanes(2'b0),  
    .hif_pcie5_serdes_pipe_turnoff_lanes(2'b0),  
    .hif_pcie7_serdes_pipe_turnoff_lanes(2'b0),  
    .hif_pcie1_mac_phy_sris_enable(1'b0),  
    .hif_pcie3_mac_phy_sris_enable(1'b0),  
    .hif_pcie5_mac_phy_sris_enable(1'b0),  
    .hif_pcie7_mac_phy_sris_enable(1'b0),  
    .hif_pcie1_mac_phy_commonclock_enable(1'b0),  
    .hif_pcie3_mac_phy_commonclock_enable(1'b0),  
    .hif_pcie5_mac_phy_commonclock_enable(1'b0),  
    .hif_pcie7_mac_phy_commonclock_enable(1'b0),  
    .hif_pcie1_mac_phy_pclk_rate(3'b0),  
    .hif_pcie3_mac_phy_pclk_rate(3'b0),  
    .hif_pcie5_mac_phy_pclk_rate(3'b0),  
    .hif_pcie7_mac_phy_pclk_rate(3'b0),  
    .hif_pcie1_mac_phy_rxstandby(2'b0),  
    .hif_pcie3_mac_phy_rxstandby(2'b0),  
    .hif_pcie5_mac_phy_rxstandby(2'b0),  
    .hif_pcie7_mac_phy_rxstandby(2'b0),  
    .hif_pcie1_mac_phy_rate(3'b0),  
    .hif_pcie3_mac_phy_rate(3'b0),  
    .hif_pcie5_mac_phy_rate(3'b0),  
    .hif_pcie7_mac_phy_rate(3'b0),  
    .hif_pcie1_mac_phy_pclkchangeack(2'b0),  
    .hif_pcie3_mac_phy_pclkchangeack(2'b0),  
    .hif_pcie5_mac_phy_pclkchangeack(2'b0),  
    .hif_pcie7_mac_phy_pclkchangeack(2'b0),  
    .hif_pcie1_mac_phy_maxpclkreq_n(1'b0),  
    .hif_pcie3_mac_phy_maxpclkreq_n(1'b0),  
    .hif_pcie5_mac_phy_maxpclkreq_n(1'b0),  
    .hif_pcie7_mac_phy_maxpclkreq_n(1'b0),  
    .hif_pcie1_mac_phy_messagebus(16'b0),  
    .hif_pcie3_mac_phy_messagebus(16'b0),  
    .hif_pcie5_mac_phy_messagebus(16'b0),  
    .hif_pcie7_mac_phy_messagebus(16'b0),  
    .hif_pcie1_mac_phy_rxelecidle_disable(1'b0),  
    .hif_pcie3_mac_phy_rxelecidle_disable(1'b0),  
    .hif_pcie5_mac_phy_rxelecidle_disable(1'b0),  
    .hif_pcie7_mac_phy_rxelecidle_disable(1'b0),  
    .hif_pcie1_mac_phy_txcommonmode_disable(1'b0),  
    .hif_pcie3_mac_phy_txcommonmode_disable(1'b0),  
    .hif_pcie5_mac_phy_txcommonmode_disable(1'b0),  
    .hif_pcie7_mac_phy_txcommonmode_disable(1'b0),  
    .hif_pcie1_mac_phy_asyncpowerchangeack(1'b0),  
    .hif_pcie3_mac_phy_asyncpowerchangeack(1'b0),  
    .hif_pcie5_mac_phy_asyncpowerchangeack(1'b0),  
    .hif_pcie7_mac_phy_asyncpowerchangeack(1'b0),  
    .phy_pcie1_pma_rst_n(1'b0),  
    .phy_pcie3_pma_rst_n(1'b0),  
    .phy_pcie5_pma_rst_n(1'b0),  
    .phy_pcie7_pma_rst_n(1'b0),  
    .phy_pcie1_pcs_rst_n(1'b0),  
    .phy_pcie3_pcs_rst_n(1'b0),  
    .phy_pcie5_pcs_rst_n(1'b0),  
    .phy_pcie7_pcs_rst_n(1'b0),  
    .nac_pciephyss_spare(32'b0),  
    .NW_OUT_from_tdo(1'b0), 
    .NW_OUT_ijtag_from_so(1'b0), 
    .BSCAN_PIPE_IN_1_bscan_clock(1'b0),  
    .BSCAN_PIPE_IN_1_select(1'b0),  
    .BSCAN_PIPE_IN_1_capture_en(1'b0),  
    .BSCAN_PIPE_IN_1_shift_en(1'b0),  
    .BSCAN_PIPE_IN_1_update_en(1'b0),  
    .BSCAN_PIPE_IN_1_scan_in(1'b0),  
    .BSCAN_PIPE_IN_1_ac_signal(1'b0),  
    .BSCAN_PIPE_IN_1_ac_init_clock0(1'b0),  
    .BSCAN_PIPE_IN_1_ac_init_clock1(1'b0),  
    .BSCAN_PIPE_IN_1_ac_mode_en(1'b0),  
    .BSCAN_PIPE_IN_1_force_disable(1'b0),  
    .BSCAN_PIPE_IN_1_select_jtag_input(1'b0),  
    .BSCAN_PIPE_IN_1_select_jtag_output(1'b0),  
    .BSCAN_PIPE_IN_1_intel_update_clk(1'b0),  
    .BSCAN_PIPE_IN_1_intel_clamp_en(1'b0),  
    .BSCAN_PIPE_IN_1_intel_bscan_mode(1'b0),  
    .BSCAN_PIPE_IN_1_intel_d6actestsig_b(1'b0),  
    .BSCAN_bypass_avephy_x4_phy0(1'b0),  
    .BSCAN_bypass_avephy_x4_phy1(1'b0),  
    .BSCAN_bypass_avephy_x4_phy2(1'b0),  
    .BSCAN_bypass_avephy_x4_phy3(1'b0),  
    .BSCAN_wake_avephy_x4_phy0(1'b0),  
    .BSCAN_wake_avephy_x4_phy1(1'b0),  
    .BSCAN_wake_avephy_x4_phy2(1'b0),  
    .BSCAN_wake_avephy_x4_phy3(1'b0),  
    .SSN_START_0_bus_clock_in(ssn_bus_clock_in), 
    .SSN_START_0_bus_data_in(par_nac_fabric0_pcie_gen6_out_end_bus_data_out), 
    .SSN_END_0_bus_data_out(par_nac_fabric0_mux_pcie_gen6_in_start_bus_data_in), 
    .dfxagg_security_policy(fdfx_security_policy), 
    .dfxagg_policy_update(fdfx_policy_update), 
    .dfxagg_early_boot_debug_exit(fdfx_earlyboot_debug_exit), 
    .dfxagg_debug_capabilities_enabling(fdfx_debug_capabilities_enabling), 
    .dfxagg_debug_capabilities_enabling_valid(fdfx_debug_capabilities_enabling_valid), 
    .NW_IN_tms(tms), 
    .NW_IN_tck(tck), 
    .NW_IN_tdi(tdi), 
    .NW_IN_trst_b(trst_b), 
    .NW_IN_shift_ir_dr(shift_ir_dr), 
    .NW_IN_tms_park_value(tms_park_value), 
    .NW_IN_nw_mode(nw_mode), 
    .NW_IN_ijtag_capture(ijtag_capture), 
    .NW_IN_ijtag_shift(ijtag_shift), 
    .NW_IN_ijtag_update(ijtag_update), 
    .NW_IN_tdo(hif_pcie_gen6_phy_18a_NW_IN_tdo), 
    .NW_IN_ijtag_reset_b(par_nac_fabric0_NW_OUT_hif_pcie_gen6_phy_18a_ijtag_to_reset), 
    .NW_IN_ijtag_select(par_nac_fabric0_NW_OUT_hif_pcie_gen6_phy_18a_ijtag_to_sel), 
    .NW_IN_ijtag_si(par_nac_fabric0_NW_OUT_hif_pcie_gen6_phy_18a_ijtag_to_si), 
    .NW_IN_ijtag_so(hif_pcie_gen6_phy_18a_NW_IN_ijtag_so), 
    .NW_IN_tap_sel_out(hif_pcie_gen6_phy_18a_NW_IN_tap_sel_out), 
    .apb_pclk(par_nac_fabric0_boot_112p5_rdop_fout2_clkout), 
    .i_ck_sys(par_nac_fabric0_par_nac_misc_adop_bclk_clkout_0_out), 
    .pciephyss_rstw_clk(par_nac_fabric0_par_nac_misc_adop_rstbus_clk_clkout_out), 
    .pciephyss_dtf_clk(par_nac_fabric0_eth_physs_rdop_fout3_clkout_out), 
    .nac_pciephyss_dtfb_upstream_rst_b(nac_ss_dtfb_upstream_rst_b), 
    .nac_pciephyss_dtf_upstream_active(dtf_arb0_nac_fabric0_dtfa_upstream1_active_out), 
    .nac_pciephyss_dtf_upstream_credit(dtf_arb0_nac_fabric0_dtfa_upstream1_credit_out), 
    .nac_pciephyss_dtf_upstream_sync(dtf_arb0_nac_fabric0_dtfa_upstream1_sync_out), 
    .pciephyss_nac_dtf_dnstream_data(hif_pcie_gen6_phy_18a_pciephyss_nac_dtf_dnstream_data), 
    .pciephyss_nac_dtf_dnstream_header(hif_pcie_gen6_phy_18a_pciephyss_nac_dtf_dnstream_header), 
    .pciephyss_nac_dtf_dnstream_valid(hif_pcie_gen6_phy_18a_pciephyss_nac_dtf_dnstream_valid), 
    .pciephyss_nac_debug_dtf_clkout(hif_pcie_gen6_phy_18a_pciephyss_nac_debug_dtf_clkout), 
    .pcie_phy0_adpllg6_og_dig_obs({hif_pcie_gen6_phy_18a_pcie_phy0_adpllg6_og_dig_obs_2,hif_pcie_gen6_phy_18a_pcie_phy0_adpllg6_og_dig_obs_1,hif_pcie_gen6_phy_18a_pcie_phy0_adpllg6_og_dig_obs_0,hif_pcie_gen6_phy_18a_pcie_phy0_adpllg6_og_dig_obs}), 
    .pcie_phy1_adpllg6_og_dig_obs({hif_pcie_gen6_phy_18a_pcie_phy1_adpllg6_og_dig_obs_2,hif_pcie_gen6_phy_18a_pcie_phy1_adpllg6_og_dig_obs_1,hif_pcie_gen6_phy_18a_pcie_phy1_adpllg6_og_dig_obs_0,hif_pcie_gen6_phy_18a_pcie_phy1_adpllg6_og_dig_obs}), 
    .pcie_phy2_adpllg6_og_dig_obs({hif_pcie_gen6_phy_18a_pcie_phy2_adpllg6_og_dig_obs_2,hif_pcie_gen6_phy_18a_pcie_phy2_adpllg6_og_dig_obs_1,hif_pcie_gen6_phy_18a_pcie_phy2_adpllg6_og_dig_obs_0,hif_pcie_gen6_phy_18a_pcie_phy2_adpllg6_og_dig_obs}), 
    .pcie_phy3_adpllg6_og_dig_obs({hif_pcie_gen6_phy_18a_pcie_phy3_adpllg6_og_dig_obs_2,hif_pcie_gen6_phy_18a_pcie_phy3_adpllg6_og_dig_obs_1,hif_pcie_gen6_phy_18a_pcie_phy3_adpllg6_og_dig_obs_0,hif_pcie_gen6_phy_18a_pcie_phy3_adpllg6_og_dig_obs}), 
    .pciephyss_nac_dig_viewpin_rdop_dft({hif_pcie_gen6_phy_18a_pciephyss_nac_dig_viewpin_rdop_dft_0,hif_pcie_gen6_phy_18a_pciephyss_nac_dig_viewpin_rdop_dft}), 
    .nac_pciephyss_pm_ip_cg_wake(nac_ss_debug_safemode_isa_oob), 
    .phy_pcie0_pcs_rst_n(nss_phy_pcie0_pcs_rst_n), 
    .phy_pcie0_pma_rst_n(nss_phy_pcie0_pma_rst_n), 
    .phy_pcie2_pcs_rst_n(nss_phy_pcie2_pcs_rst_n), 
    .phy_pcie2_pma_rst_n(nss_phy_pcie2_pma_rst_n), 
    .phy_pcie4_pcs_rst_n(nss_phy_pcie4_pcs_rst_n), 
    .phy_pcie4_pma_rst_n(nss_phy_pcie4_pma_rst_n), 
    .phy_pcie6_pcs_rst_n(nss_phy_pcie6_pcs_rst_n), 
    .phy_pcie6_pma_rst_n(nss_phy_pcie6_pma_rst_n), 
    .pciephyss_nac_tsrdhoriz0_v_anode(hif_pcie_gen6_phy_18a_pciephyss_nac_tsrdhoriz0_v_anode), 
    .pciephyss_nac_tsrdhoriz0_v_cathode(hif_pcie_gen6_phy_18a_pciephyss_nac_tsrdhoriz0_v_cathode), 
    .nac_pciephyss_tsrdhoriz0_i_cathode(nac_dts2_i_cathode), 
    .nac_pciephyss_tsrdhoriz0_i_anode(dts_nac2_i_anode_2), 
    .pciephyss_nac_tsrdhoriz1_v_anode(hif_pcie_gen6_phy_18a_pciephyss_nac_tsrdhoriz1_v_anode), 
    .pciephyss_nac_tsrdhoriz1_v_cathode(hif_pcie_gen6_phy_18a_pciephyss_nac_tsrdhoriz1_v_cathode), 
    .nac_pciephyss_tsrdhoriz1_i_cathode(nac_dts2_i_cathode), 
    .nac_pciephyss_tsrdhoriz1_i_anode(dts_nac2_i_anode_3), 
    .reset_error(hif_pcie_gen6_phy_18a_reset_error), 
    .reset_cmd_ack(hif_pcie_gen6_phy_18a_reset_cmd_ack), 
    .pciephyss_nac_rstw_o_cmp(hif_pcie_gen6_phy_18a_pciephyss_nac_rstw_o_cmp), 
    .pciephyss_nac_rstw_o_rdata(hif_pcie_gen6_phy_18a_pciephyss_nac_rstw_o_rdata), 
    .pciephyss_nac_rstw_o_error(hif_pcie_gen6_phy_18a_pciephyss_nac_rstw_o_error), 
    .nac_pciephyss_rstw_i_valid(nac_soft_strap_rstw_o_valid), 
    .nac_pciephyss_rstw_i_write(nac_soft_strap_rstw_o_write), 
    .nac_pciephyss_rstw_i_wdata(nac_soft_strap_rstw_o_wdata), 
    .nac_pciephyss_rstw_i_addr(nac_soft_strap_rstw_o_addr), 
    .pciephyss_nac_req_out_next(hif_pcie_gen6_phy_18a_pciephyss_nac_req_out_next), 
    .pciephyss_nac_ack_out_next(hif_pcie_gen6_phy_18a_pciephyss_nac_ack_out_next), 
    .nac_pciephyss_req_in_next(hif_pcie_gen6_phy_18a_tfb_req_out_agent), 
    .nac_pciephyss_ack_in_next(hif_pcie_gen6_phy_18a_tfb_ack_out_agent), 
    .avephy_dvp0_dvp_pprot(apb_dser_avephy_dvp0_pprot), 
    .avephy_dvp0_dvp_psel(apb_dser_avephy_dvp0_psel), 
    .avephy_dvp0_dvp_penable(apb_dser_avephy_dvp0_penable), 
    .avephy_dvp0_dvp_pwrite(apb_dser_avephy_dvp0_pwrite), 
    .avephy_dvp0_dvp_pwdata(apb_dser_avephy_dvp0_pwdata), 
    .avephy_dvp0_dvp_pstrb(apb_dser_avephy_dvp0_pstrb), 
    .avephy_dvp0_dvp_paddr(apb_dser_avephy_dvp0_paddr), 
    .avephy_dvp0_dvp_pready(hif_pcie_gen6_phy_18a_avephy_dvp0_dvp_pready), 
    .avephy_dvp0_dvp_prdata(hif_pcie_gen6_phy_18a_avephy_dvp0_dvp_prdata), 
    .avephy_dvp0_dvp_pslverr(hif_pcie_gen6_phy_18a_avephy_dvp0_dvp_pslverr), 
    .avephy_dvp1_dvp_pprot(apb_dser_avephy_dvp1_pprot), 
    .avephy_dvp1_dvp_psel(apb_dser_avephy_dvp1_psel), 
    .avephy_dvp1_dvp_penable(apb_dser_avephy_dvp1_penable), 
    .avephy_dvp1_dvp_pwrite(apb_dser_avephy_dvp1_pwrite), 
    .avephy_dvp1_dvp_pwdata(apb_dser_avephy_dvp1_pwdata), 
    .avephy_dvp1_dvp_pstrb(apb_dser_avephy_dvp1_pstrb), 
    .avephy_dvp1_dvp_paddr(apb_dser_avephy_dvp1_paddr), 
    .avephy_dvp1_dvp_pready(hif_pcie_gen6_phy_18a_avephy_dvp1_dvp_pready), 
    .avephy_dvp1_dvp_prdata(hif_pcie_gen6_phy_18a_avephy_dvp1_dvp_prdata), 
    .avephy_dvp1_dvp_pslverr(hif_pcie_gen6_phy_18a_avephy_dvp1_dvp_pslverr), 
    .avephy_dvp2_dvp_pprot(apb_dser_avephy_dvp2_pprot), 
    .avephy_dvp2_dvp_psel(apb_dser_avephy_dvp2_psel), 
    .avephy_dvp2_dvp_penable(apb_dser_avephy_dvp2_penable), 
    .avephy_dvp2_dvp_pwrite(apb_dser_avephy_dvp2_pwrite), 
    .avephy_dvp2_dvp_pwdata(apb_dser_avephy_dvp2_pwdata), 
    .avephy_dvp2_dvp_pstrb(apb_dser_avephy_dvp2_pstrb), 
    .avephy_dvp2_dvp_paddr(apb_dser_avephy_dvp2_paddr), 
    .avephy_dvp2_dvp_pready(hif_pcie_gen6_phy_18a_avephy_dvp2_dvp_pready), 
    .avephy_dvp2_dvp_prdata(hif_pcie_gen6_phy_18a_avephy_dvp2_dvp_prdata), 
    .avephy_dvp2_dvp_pslverr(hif_pcie_gen6_phy_18a_avephy_dvp2_dvp_pslverr), 
    .avephy_dvp3_dvp_pprot(apb_dser_avephy_dvp3_pprot), 
    .avephy_dvp3_dvp_psel(apb_dser_avephy_dvp3_psel), 
    .avephy_dvp3_dvp_penable(apb_dser_avephy_dvp3_penable), 
    .avephy_dvp3_dvp_pwrite(apb_dser_avephy_dvp3_pwrite), 
    .avephy_dvp3_dvp_pwdata(apb_dser_avephy_dvp3_pwdata), 
    .avephy_dvp3_dvp_pstrb(apb_dser_avephy_dvp3_pstrb), 
    .avephy_dvp3_dvp_paddr(apb_dser_avephy_dvp3_paddr), 
    .avephy_dvp3_dvp_pready(hif_pcie_gen6_phy_18a_avephy_dvp3_dvp_pready), 
    .avephy_dvp3_dvp_prdata(hif_pcie_gen6_phy_18a_avephy_dvp3_dvp_prdata), 
    .avephy_dvp3_dvp_pslverr(hif_pcie_gen6_phy_18a_avephy_dvp3_dvp_pslverr), 
    .adpll_dvp0_dvp_pprot(apb_dser_adpll_dvp0_pprot), 
    .adpll_dvp0_dvp_psel(apb_dser_adpll_dvp0_psel), 
    .adpll_dvp0_dvp_penable(apb_dser_adpll_dvp0_penable), 
    .adpll_dvp0_dvp_pwrite(apb_dser_adpll_dvp0_pwrite), 
    .adpll_dvp0_dvp_pwdata(apb_dser_adpll_dvp0_pwdata), 
    .adpll_dvp0_dvp_pstrb(apb_dser_adpll_dvp0_pstrb), 
    .adpll_dvp0_dvp_paddr(apb_dser_adpll_dvp0_paddr), 
    .adpll_dvp0_dvp_pready(hif_pcie_gen6_phy_18a_adpll_dvp0_dvp_pready), 
    .adpll_dvp0_dvp_prdata(hif_pcie_gen6_phy_18a_adpll_dvp0_dvp_prdata), 
    .adpll_dvp0_dvp_pslverr(hif_pcie_gen6_phy_18a_adpll_dvp0_dvp_pslverr), 
    .adpll_dvp1_dvp_pprot(apb_dser_adpll_dvp1_pprot), 
    .adpll_dvp1_dvp_psel(apb_dser_adpll_dvp1_psel), 
    .adpll_dvp1_dvp_penable(apb_dser_adpll_dvp1_penable), 
    .adpll_dvp1_dvp_pwrite(apb_dser_adpll_dvp1_pwrite), 
    .adpll_dvp1_dvp_pwdata(apb_dser_adpll_dvp1_pwdata), 
    .adpll_dvp1_dvp_pstrb(apb_dser_adpll_dvp1_pstrb), 
    .adpll_dvp1_dvp_paddr(apb_dser_adpll_dvp1_paddr), 
    .adpll_dvp1_dvp_pready(hif_pcie_gen6_phy_18a_adpll_dvp1_dvp_pready), 
    .adpll_dvp1_dvp_prdata(hif_pcie_gen6_phy_18a_adpll_dvp1_dvp_prdata), 
    .adpll_dvp1_dvp_pslverr(hif_pcie_gen6_phy_18a_adpll_dvp1_dvp_pslverr), 
    .adpll_dvp2_dvp_pprot(apb_dser_adpll_dvp2_pprot), 
    .adpll_dvp2_dvp_psel(apb_dser_adpll_dvp2_psel), 
    .adpll_dvp2_dvp_penable(apb_dser_adpll_dvp2_penable), 
    .adpll_dvp2_dvp_pwrite(apb_dser_adpll_dvp2_pwrite), 
    .adpll_dvp2_dvp_pwdata(apb_dser_adpll_dvp2_pwdata), 
    .adpll_dvp2_dvp_pstrb(apb_dser_adpll_dvp2_pstrb), 
    .adpll_dvp2_dvp_paddr(apb_dser_adpll_dvp2_paddr), 
    .adpll_dvp2_dvp_pready(hif_pcie_gen6_phy_18a_adpll_dvp2_dvp_pready), 
    .adpll_dvp2_dvp_prdata(hif_pcie_gen6_phy_18a_adpll_dvp2_dvp_prdata), 
    .adpll_dvp2_dvp_pslverr(hif_pcie_gen6_phy_18a_adpll_dvp2_dvp_pslverr), 
    .adpll_dvp3_dvp_pprot(apb_dser_adpll_dvp3_pprot), 
    .adpll_dvp3_dvp_psel(apb_dser_adpll_dvp3_psel), 
    .adpll_dvp3_dvp_penable(apb_dser_adpll_dvp3_penable), 
    .adpll_dvp3_dvp_pwrite(apb_dser_adpll_dvp3_pwrite), 
    .adpll_dvp3_dvp_pwdata(apb_dser_adpll_dvp3_pwdata), 
    .adpll_dvp3_dvp_pstrb(apb_dser_adpll_dvp3_pstrb), 
    .adpll_dvp3_dvp_paddr(apb_dser_adpll_dvp3_paddr), 
    .adpll_dvp3_dvp_pready(hif_pcie_gen6_phy_18a_adpll_dvp3_dvp_pready), 
    .adpll_dvp3_dvp_prdata(hif_pcie_gen6_phy_18a_adpll_dvp3_dvp_prdata), 
    .adpll_dvp3_dvp_pslverr(hif_pcie_gen6_phy_18a_adpll_dvp3_dvp_pslverr), 
    .phy_ss_csr_dvp_dvp_pprot(apb_dser_phy_ss_csr_dvp_pprot), 
    .phy_ss_csr_dvp_dvp_psel(apb_dser_phy_ss_csr_dvp_psel), 
    .phy_ss_csr_dvp_dvp_penable(apb_dser_phy_ss_csr_dvp_penable), 
    .phy_ss_csr_dvp_dvp_pwrite(apb_dser_phy_ss_csr_dvp_pwrite), 
    .phy_ss_csr_dvp_dvp_pwdata(apb_dser_phy_ss_csr_dvp_pwdata), 
    .phy_ss_csr_dvp_dvp_pstrb(apb_dser_phy_ss_csr_dvp_pstrb), 
    .phy_ss_csr_dvp_dvp_paddr(apb_dser_phy_ss_csr_dvp_paddr), 
    .phy_ss_csr_dvp_dvp_pready(hif_pcie_gen6_phy_18a_phy_ss_csr_dvp_dvp_pready), 
    .phy_ss_csr_dvp_dvp_prdata(hif_pcie_gen6_phy_18a_phy_ss_csr_dvp_dvp_prdata), 
    .phy_ss_csr_dvp_dvp_pslverr(hif_pcie_gen6_phy_18a_phy_ss_csr_dvp_dvp_pslverr), 
    .nac_pciephyss_debug_timestamp(nac_ss_debug_timestamp), 
    .pciephyss_nac_spare(), 
    .NW_OUT_ijtag_to_reset(), 
    .NW_OUT_ijtag_to_tck(), 
    .NW_OUT_ijtag_to_ce(), 
    .NW_OUT_ijtag_to_se(), 
    .NW_OUT_ijtag_to_ue(), 
    .NW_OUT_ijtag_to_sel(), 
    .NW_OUT_ijtag_to_si(), 
    .DIAG_AGGR_0_mbist_diag_done(), 
    .NW_OUT_to_trst(), 
    .NW_OUT_to_tck(), 
    .NW_OUT_to_tms(), 
    .NW_OUT_to_tdi(), 
    .BSCAN_PIPE_OUT_1_scan_out(), 
    .phy_pcie1_max_pclk(), 
    .hif_pcie1_phy_mac_rxelecidle(), 
    .hif_pcie1_phy_mac_phystatus(), 
    .hif_pcie1_phy_mac_rxdata(), 
    .hif_pcie1_phy_mac_rxvalid(), 
    .hif_pcie1_phy_mac_rxstatus(), 
    .hif_pcie1_phy_mac_rxstandbystatus(), 
    .phy_pcie1_pipe_rx_clk(), 
    .hif_pcie1_phy_mac_pclkchangeok(), 
    .hif_pcie1_phy_mac_maxpclkack_n(), 
    .hif_pcie1_phy_mac_messagebus(), 
    .phy_pcie3_max_pclk(), 
    .hif_pcie3_phy_mac_rxelecidle(), 
    .hif_pcie3_phy_mac_phystatus(), 
    .hif_pcie3_phy_mac_rxdata(), 
    .hif_pcie3_phy_mac_rxvalid(), 
    .hif_pcie3_phy_mac_rxstatus(), 
    .hif_pcie3_phy_mac_rxstandbystatus(), 
    .phy_pcie3_pipe_rx_clk(), 
    .hif_pcie3_phy_mac_pclkchangeok(), 
    .hif_pcie3_phy_mac_maxpclkack_n(), 
    .hif_pcie3_phy_mac_messagebus(), 
    .phy_pcie5_max_pclk(), 
    .hif_pcie5_phy_mac_rxelecidle(), 
    .hif_pcie5_phy_mac_phystatus(), 
    .hif_pcie5_phy_mac_rxdata(), 
    .hif_pcie5_phy_mac_rxvalid(), 
    .hif_pcie5_phy_mac_rxstatus(), 
    .hif_pcie5_phy_mac_rxstandbystatus(), 
    .phy_pcie5_pipe_rx_clk(), 
    .hif_pcie5_phy_mac_pclkchangeok(), 
    .hif_pcie5_phy_mac_maxpclkack_n(), 
    .hif_pcie5_phy_mac_messagebus(), 
    .phy_pcie7_max_pclk(), 
    .hif_pcie7_phy_mac_rxelecidle(), 
    .hif_pcie7_phy_mac_phystatus(), 
    .hif_pcie7_phy_mac_rxdata(), 
    .hif_pcie7_phy_mac_rxvalid(), 
    .hif_pcie7_phy_mac_rxstatus(), 
    .hif_pcie7_phy_mac_rxstandbystatus(), 
    .phy_pcie7_pipe_rx_clk(), 
    .hif_pcie7_phy_mac_pclkchangeok(), 
    .hif_pcie7_phy_mac_maxpclkack_n(), 
    .hif_pcie7_phy_mac_messagebus(), 
    .hif_pcie0_phy_mac_maxpclkack_n(), 
    .hif_pcie2_phy_mac_maxpclkack_n(), 
    .hif_pcie4_phy_mac_maxpclkack_n(), 
    .hif_pcie6_phy_mac_maxpclkack_n()
) ; 
hlp hlp (
    .ssn_bus_clock_in(ssn_bus_clock_in), 
    .ssn_bus_data_in(par_nac_fabric3_hlp_mux_end_bus_data_out), 
    .ssn_bus_data_out(par_nac_fabric3_hlp_mux_start_bus_data_in), 
    .dfxagg_security_policy(fdfx_security_policy), 
    .dfxagg_policy_update(fdfx_policy_update), 
    .dfxagg_early_boot_debug_exit(fdfx_earlyboot_debug_exit), 
    .dfxagg_debug_capabilities_enabling(fdfx_debug_capabilities_enabling), 
    .dfxagg_debug_capabilities_enabling_valid(fdfx_debug_capabilities_enabling_valid), 
    .tms(tms), 
    .tck(tck), 
    .tdi(tdi), 
    .trst_b(trst_b), 
    .shift_ir_dr(shift_ir_dr), 
    .tms_park_value(tms_park_value), 
    .nw_mode(nw_mode), 
    .ijtag_capture(ijtag_capture), 
    .ijtag_shift(ijtag_shift), 
    .ijtag_update(ijtag_update), 
    .tdo(hlp_tdo), 
    .tdo_en(hlp_tdo_en), 
    .ijtag_reset_b(par_nac_fabric3_NW_OUT_hlp_ijtag_to_reset), 
    .ijtag_select(par_nac_fabric3_NW_OUT_hlp_ijtag_to_sel), 
    .ijtag_si(par_nac_fabric3_NW_OUT_hlp_ijtag_to_si), 
    .ijtag_so(hlp_ijtag_so), 
    .tap_sel_in(hlp_tap_sel_in), 
    .fdfx_powergood(fdfx_pwrgood_rst_b), 
    .pd_vinf_bisr_si(1'b0), 
    .pd_vinf_bisr_clk(1'b0), 
    .pd_vinf_bisr_reset(1'b0), 
    .pd_vinf_bisr_shift_en(1'b0), 
    .pd_vinf_bisr_so(1'b0), 
    .aclk_s(par_nac_fabric3_boot_112p5_rdop_fout2_clkout_out), 
    .pgcb_clk(par_nac_misc_par_nac_misc_adop_xtalclk_clkout), 
    .dvp_crystal_clk(par_nac_misc_par_nac_misc_adop_xtalclk_clkout), 
    .switch_clk(eth_physs_rdop_fout2_clkout), 
    .dtf_clk(par_nac_fabric3_eth_physs_rdop_fout3_clkout), 
    .dvp_clk(par_nac_fabric3_eth_physs_rdop_fout3_clkout), 
    .ports_clk(par_nac_fabric3_ts_800_rdop_fout0_clkout_hlp), 
    .dtf_rst_b(nac_ss_dtfb_upstream_rst_b), 
    .dtf_upstream_credit_in(dtf_rep_hlp_fab3_arb0_rep0_dtfr_upstream_d0_credit_out), 
    .dtf_upstream_active_in(dtf_rep_hlp_fab3_arb0_rep0_dtfr_upstream_d0_active_out), 
    .dtf_upstream_sync_in(dtf_rep_hlp_fab3_arb0_rep0_dtfr_upstream_d0_sync_out), 
    .dtf_dnstream_data_out(hlp_dtf_dnstream_data_out), 
    .dtf_dnstream_valid_out(hlp_dtf_dnstream_valid_out), 
    .dtf_dnstream_header_out(hlp_dtf_dnstream_header_out), 
    .dig_view_out_0(hlp_dig_view_out_0), 
    .dig_view_out_1(hlp_dig_view_out_1), 
    .dtf_mid(8'hCF), 
    .dtf_cid_start(8'h00), 
    .pm_ip_cg_wake(nac_ss_debug_safemode_isa_oob), 
    .fary_ffuse_hd2prf_trim(hlp_efbisr_reg_Q_0), 
    .fary_ffuse_rfhs2r2w_trim(hlp_efbisr_reg_Q_1), 
    .fary_ffuse_hdusplr_trim(hlp_efbisr_reg_Q_2), 
    .fary_ffuse_hduspsr_trim(hlp_efbisr_reg_Q_3), 
    .fary_ffuse_tune_tcam(hlp_efbisr_reg_Q_4), 
    .hlp_intr_0(hlp_hlp_intr_0), 
    .hlp_intr_1(hlp_hlp_intr_1), 
    .hlp_fatal_intr(hlp_hlp_fatal_intr), 
    .hlp_nonfatal_intr(hlp_hlp_nonfatal_intr), 
    .hlp_port0_cgmii_rx_c(physs_hlp_repeater_hlp_port0_cgmii_rx_c), 
    .hlp_port0_cgmii_rx_data(physs_hlp_repeater_hlp_port0_cgmii_rx_data), 
    .hlp_port0_cgmii_rxclk_ena(physs_hlp_repeater_hlp_port0_cgmii_rxclk_ena), 
    .hlp_port0_cgmii_rxt0_next(physs_hlp_repeater_hlp_port0_cgmii_rxt0_next), 
    .hlp_port0_cgmii_tx_c(hlp_hlp_port0_cgmii_tx_c), 
    .hlp_port0_cgmii_tx_data(hlp_hlp_port0_cgmii_tx_data), 
    .hlp_port0_cgmii_txclk_ena(physs_hlp_repeater_hlp_port0_cgmii_txclk_ena), 
    .hlp_port0_xlgmii_rx_c(physs_hlp_repeater_hlp_port0_xlgmii_rx_c), 
    .hlp_port0_xlgmii_rx_data(physs_hlp_repeater_hlp_port0_xlgmii_rx_data), 
    .hlp_port0_xlgmii_rxclk_ena(physs_hlp_repeater_hlp_port0_xlgmii_rxclk_ena), 
    .hlp_port0_xlgmii_rxt0_next(physs_hlp_repeater_hlp_port0_xlgmii_rxt0_next), 
    .hlp_port0_xlgmii_tx_c(hlp_hlp_port0_xlgmii_tx_c), 
    .hlp_port0_xlgmii_tx_data(hlp_hlp_port0_xlgmii_tx_data), 
    .hlp_port0_xlgmii_txclk_ena(physs_hlp_repeater_hlp_port0_xlgmii_txclk_ena), 
    .hlp_port10_cgmii_rx_c(physs_hlp_repeater_hlp_port10_cgmii_rx_c), 
    .hlp_port10_cgmii_rx_data(physs_hlp_repeater_hlp_port10_cgmii_rx_data), 
    .hlp_port10_cgmii_rxclk_ena(physs_hlp_repeater_hlp_port10_cgmii_rxclk_ena), 
    .hlp_port10_cgmii_rxt0_next(physs_hlp_repeater_hlp_port10_cgmii_rxt0_next), 
    .hlp_port10_cgmii_tx_c(hlp_hlp_port10_cgmii_tx_c), 
    .hlp_port10_cgmii_tx_data(hlp_hlp_port10_cgmii_tx_data), 
    .hlp_port10_cgmii_txclk_ena(physs_hlp_repeater_hlp_port10_cgmii_txclk_ena), 
    .hlp_port10_desk_rlevel(physs_hlp_repeater_hlp_port10_desk_rlevel), 
    .hlp_port10_link_status(physs_hlp_repeater_hlp_port10_link_status), 
    .hlp_port10_mii_rx_tsu(physs_hlp_repeater_hlp_port10_mii_rx_tsu), 
    .hlp_port10_mii_tx_tsu(physs_hlp_repeater_hlp_port10_mii_tx_tsu), 
    .hlp_port10_sd_bit_slip(physs_hlp_repeater_hlp_port10_sd_bit_slip), 
    .hlp_port10_tsu_rx_sd(physs_hlp_repeater_hlp_port10_tsu_rx_sd), 
    .hlp_port10_xlgmii_rx_c(physs_hlp_repeater_hlp_port10_xlgmii_rx_c), 
    .hlp_port10_xlgmii_rx_data(physs_hlp_repeater_hlp_port10_xlgmii_rx_data), 
    .hlp_port10_xlgmii_rxclk_ena(physs_hlp_repeater_hlp_port10_xlgmii_rxclk_ena), 
    .hlp_port10_xlgmii_rxt0_next(physs_hlp_repeater_hlp_port10_xlgmii_rxt0_next), 
    .hlp_port10_xlgmii_tx_c(hlp_hlp_port10_xlgmii_tx_c), 
    .hlp_port10_xlgmii_tx_data(hlp_hlp_port10_xlgmii_tx_data), 
    .hlp_port10_xlgmii_txclk_ena(physs_hlp_repeater_hlp_port10_xlgmii_txclk_ena), 
    .hlp_port11_cgmii_rx_c(physs_hlp_repeater_hlp_port11_cgmii_rx_c), 
    .hlp_port11_cgmii_rx_data(physs_hlp_repeater_hlp_port11_cgmii_rx_data), 
    .hlp_port11_cgmii_rxclk_ena(physs_hlp_repeater_hlp_port11_cgmii_rxclk_ena), 
    .hlp_port11_cgmii_rxt0_next(physs_hlp_repeater_hlp_port11_cgmii_rxt0_next), 
    .hlp_port11_cgmii_tx_c(hlp_hlp_port11_cgmii_tx_c), 
    .hlp_port11_cgmii_tx_data(hlp_hlp_port11_cgmii_tx_data), 
    .hlp_port11_cgmii_txclk_ena(physs_hlp_repeater_hlp_port11_cgmii_txclk_ena), 
    .hlp_port11_desk_rlevel(physs_hlp_repeater_hlp_port11_desk_rlevel), 
    .hlp_port11_link_status(physs_hlp_repeater_hlp_port11_link_status), 
    .hlp_port11_mii_rx_tsu(physs_hlp_repeater_hlp_port11_mii_rx_tsu), 
    .hlp_port11_mii_tx_tsu(physs_hlp_repeater_hlp_port11_mii_tx_tsu), 
    .hlp_port11_sd_bit_slip(physs_hlp_repeater_hlp_port11_sd_bit_slip), 
    .hlp_port11_tsu_rx_sd(physs_hlp_repeater_hlp_port11_tsu_rx_sd), 
    .hlp_port11_xlgmii_rx_c(physs_hlp_repeater_hlp_port11_xlgmii_rx_c), 
    .hlp_port11_xlgmii_rx_data(physs_hlp_repeater_hlp_port11_xlgmii_rx_data), 
    .hlp_port11_xlgmii_rxclk_ena(physs_hlp_repeater_hlp_port11_xlgmii_rxclk_ena), 
    .hlp_port11_xlgmii_rxt0_next(physs_hlp_repeater_hlp_port11_xlgmii_rxt0_next), 
    .hlp_port11_xlgmii_tx_c(hlp_hlp_port11_xlgmii_tx_c), 
    .hlp_port11_xlgmii_tx_data(hlp_hlp_port11_xlgmii_tx_data), 
    .hlp_port11_xlgmii_txclk_ena(physs_hlp_repeater_hlp_port11_xlgmii_txclk_ena), 
    .hlp_port12_cgmii_rx_c(physs_hlp_repeater_hlp_port12_cgmii_rx_c), 
    .hlp_port12_cgmii_rx_data(physs_hlp_repeater_hlp_port12_cgmii_rx_data), 
    .hlp_port12_cgmii_rxclk_ena(physs_hlp_repeater_hlp_port12_cgmii_rxclk_ena), 
    .hlp_port12_cgmii_rxt0_next(physs_hlp_repeater_hlp_port12_cgmii_rxt0_next), 
    .hlp_port12_cgmii_tx_c(hlp_hlp_port12_cgmii_tx_c), 
    .hlp_port12_cgmii_tx_data(hlp_hlp_port12_cgmii_tx_data), 
    .hlp_port12_cgmii_txclk_ena(physs_hlp_repeater_hlp_port12_cgmii_txclk_ena), 
    .hlp_port12_desk_rlevel(physs_hlp_repeater_hlp_port12_desk_rlevel), 
    .hlp_port12_link_status(physs_hlp_repeater_hlp_port12_link_status), 
    .hlp_port12_mii_rx_tsu(physs_hlp_repeater_hlp_port12_mii_rx_tsu), 
    .hlp_port12_mii_tx_tsu(physs_hlp_repeater_hlp_port12_mii_tx_tsu), 
    .hlp_port12_sd_bit_slip(physs_hlp_repeater_hlp_port12_sd_bit_slip), 
    .hlp_port12_tsu_rx_sd(physs_hlp_repeater_hlp_port12_tsu_rx_sd), 
    .hlp_port12_xlgmii_rx_c(physs_hlp_repeater_hlp_port12_xlgmii_rx_c), 
    .hlp_port12_xlgmii_rx_data(physs_hlp_repeater_hlp_port12_xlgmii_rx_data), 
    .hlp_port12_xlgmii_rxclk_ena(physs_hlp_repeater_hlp_port12_xlgmii_rxclk_ena), 
    .hlp_port12_xlgmii_rxt0_next(physs_hlp_repeater_hlp_port12_xlgmii_rxt0_next), 
    .hlp_port12_xlgmii_tx_c(hlp_hlp_port12_xlgmii_tx_c), 
    .hlp_port12_xlgmii_tx_data(hlp_hlp_port12_xlgmii_tx_data), 
    .hlp_port12_xlgmii_txclk_ena(physs_hlp_repeater_hlp_port12_xlgmii_txclk_ena), 
    .hlp_port13_cgmii_rx_c(physs_hlp_repeater_hlp_port13_cgmii_rx_c), 
    .hlp_port13_cgmii_rx_data(physs_hlp_repeater_hlp_port13_cgmii_rx_data), 
    .hlp_port13_cgmii_rxclk_ena(physs_hlp_repeater_hlp_port13_cgmii_rxclk_ena), 
    .hlp_port13_cgmii_rxt0_next(physs_hlp_repeater_hlp_port13_cgmii_rxt0_next), 
    .hlp_port13_cgmii_tx_c(hlp_hlp_port13_cgmii_tx_c), 
    .hlp_port13_cgmii_tx_data(hlp_hlp_port13_cgmii_tx_data), 
    .hlp_port13_cgmii_txclk_ena(physs_hlp_repeater_hlp_port13_cgmii_txclk_ena), 
    .hlp_port13_desk_rlevel(physs_hlp_repeater_hlp_port13_desk_rlevel), 
    .hlp_port13_link_status(physs_hlp_repeater_hlp_port13_link_status), 
    .hlp_port13_mii_rx_tsu(physs_hlp_repeater_hlp_port13_mii_rx_tsu), 
    .hlp_port13_mii_tx_tsu(physs_hlp_repeater_hlp_port13_mii_tx_tsu), 
    .hlp_port13_sd_bit_slip(physs_hlp_repeater_hlp_port13_sd_bit_slip), 
    .hlp_port13_tsu_rx_sd(physs_hlp_repeater_hlp_port13_tsu_rx_sd), 
    .hlp_port13_xlgmii_rx_c(physs_hlp_repeater_hlp_port13_xlgmii_rx_c), 
    .hlp_port13_xlgmii_rx_data(physs_hlp_repeater_hlp_port13_xlgmii_rx_data), 
    .hlp_port13_xlgmii_rxclk_ena(physs_hlp_repeater_hlp_port13_xlgmii_rxclk_ena), 
    .hlp_port13_xlgmii_rxt0_next(physs_hlp_repeater_hlp_port13_xlgmii_rxt0_next), 
    .hlp_port13_xlgmii_tx_c(hlp_hlp_port13_xlgmii_tx_c), 
    .hlp_port13_xlgmii_tx_data(hlp_hlp_port13_xlgmii_tx_data), 
    .hlp_port13_xlgmii_txclk_ena(physs_hlp_repeater_hlp_port13_xlgmii_txclk_ena), 
    .hlp_port14_cgmii_rx_c(physs_hlp_repeater_hlp_port14_cgmii_rx_c), 
    .hlp_port14_cgmii_rx_data(physs_hlp_repeater_hlp_port14_cgmii_rx_data), 
    .hlp_port14_cgmii_rxclk_ena(physs_hlp_repeater_hlp_port14_cgmii_rxclk_ena), 
    .hlp_port14_cgmii_rxt0_next(physs_hlp_repeater_hlp_port14_cgmii_rxt0_next), 
    .hlp_port14_cgmii_tx_c(hlp_hlp_port14_cgmii_tx_c), 
    .hlp_port14_cgmii_tx_data(hlp_hlp_port14_cgmii_tx_data), 
    .hlp_port14_cgmii_txclk_ena(physs_hlp_repeater_hlp_port14_cgmii_txclk_ena), 
    .hlp_port14_desk_rlevel(physs_hlp_repeater_hlp_port14_desk_rlevel), 
    .hlp_port14_link_status(physs_hlp_repeater_hlp_port14_link_status), 
    .hlp_port14_mii_rx_tsu(physs_hlp_repeater_hlp_port14_mii_rx_tsu), 
    .hlp_port14_mii_tx_tsu(physs_hlp_repeater_hlp_port14_mii_tx_tsu), 
    .hlp_port14_sd_bit_slip(physs_hlp_repeater_hlp_port14_sd_bit_slip), 
    .hlp_port14_tsu_rx_sd(physs_hlp_repeater_hlp_port14_tsu_rx_sd), 
    .hlp_port14_xlgmii_rx_c(physs_hlp_repeater_hlp_port14_xlgmii_rx_c), 
    .hlp_port14_xlgmii_rx_data(physs_hlp_repeater_hlp_port14_xlgmii_rx_data), 
    .hlp_port14_xlgmii_rxclk_ena(physs_hlp_repeater_hlp_port14_xlgmii_rxclk_ena), 
    .hlp_port14_xlgmii_rxt0_next(physs_hlp_repeater_hlp_port14_xlgmii_rxt0_next), 
    .hlp_port14_xlgmii_tx_c(hlp_hlp_port14_xlgmii_tx_c), 
    .hlp_port14_xlgmii_tx_data(hlp_hlp_port14_xlgmii_tx_data), 
    .hlp_port14_xlgmii_txclk_ena(physs_hlp_repeater_hlp_port14_xlgmii_txclk_ena), 
    .hlp_port15_cgmii_rx_c(physs_hlp_repeater_hlp_port15_cgmii_rx_c), 
    .hlp_port15_cgmii_rx_data(physs_hlp_repeater_hlp_port15_cgmii_rx_data), 
    .hlp_port15_cgmii_rxclk_ena(physs_hlp_repeater_hlp_port15_cgmii_rxclk_ena), 
    .hlp_port15_cgmii_rxt0_next(physs_hlp_repeater_hlp_port15_cgmii_rxt0_next), 
    .hlp_port15_cgmii_tx_c(hlp_hlp_port15_cgmii_tx_c), 
    .hlp_port15_cgmii_tx_data(hlp_hlp_port15_cgmii_tx_data), 
    .hlp_port15_cgmii_txclk_ena(physs_hlp_repeater_hlp_port15_cgmii_txclk_ena), 
    .hlp_port15_desk_rlevel(physs_hlp_repeater_hlp_port15_desk_rlevel), 
    .hlp_port15_link_status(physs_hlp_repeater_hlp_port15_link_status), 
    .hlp_port15_mii_rx_tsu(physs_hlp_repeater_hlp_port15_mii_rx_tsu), 
    .hlp_port15_mii_tx_tsu(physs_hlp_repeater_hlp_port15_mii_tx_tsu), 
    .hlp_port15_sd_bit_slip(physs_hlp_repeater_hlp_port15_sd_bit_slip), 
    .hlp_port15_tsu_rx_sd(physs_hlp_repeater_hlp_port15_tsu_rx_sd), 
    .hlp_port15_xlgmii_rx_c(physs_hlp_repeater_hlp_port15_xlgmii_rx_c), 
    .hlp_port15_xlgmii_rx_data(physs_hlp_repeater_hlp_port15_xlgmii_rx_data), 
    .hlp_port15_xlgmii_rxclk_ena(physs_hlp_repeater_hlp_port15_xlgmii_rxclk_ena), 
    .hlp_port15_xlgmii_rxt0_next(physs_hlp_repeater_hlp_port15_xlgmii_rxt0_next), 
    .hlp_port15_xlgmii_tx_c(hlp_hlp_port15_xlgmii_tx_c), 
    .hlp_port15_xlgmii_tx_data(hlp_hlp_port15_xlgmii_tx_data), 
    .hlp_port15_xlgmii_txclk_ena(physs_hlp_repeater_hlp_port15_xlgmii_txclk_ena), 
    .hlp_port16_cgmii_rx_c(physs_hlp_repeater_hlp_port16_cgmii_rx_c), 
    .hlp_port16_cgmii_rx_data(physs_hlp_repeater_hlp_port16_cgmii_rx_data), 
    .hlp_port16_cgmii_rxclk_ena(physs_hlp_repeater_hlp_port16_cgmii_rxclk_ena), 
    .hlp_port16_cgmii_rxt0_next(physs_hlp_repeater_hlp_port16_cgmii_rxt0_next), 
    .hlp_port16_cgmii_tx_c(hlp_hlp_port16_cgmii_tx_c), 
    .hlp_port16_cgmii_tx_data(hlp_hlp_port16_cgmii_tx_data), 
    .hlp_port16_cgmii_txclk_ena(physs_hlp_repeater_hlp_port16_cgmii_txclk_ena), 
    .hlp_port16_desk_rlevel(physs_hlp_repeater_hlp_port16_desk_rlevel), 
    .hlp_port16_link_status(physs_hlp_repeater_hlp_port16_link_status), 
    .hlp_port16_mii_rx_tsu(physs_hlp_repeater_hlp_port16_mii_rx_tsu), 
    .hlp_port16_mii_tx_tsu(physs_hlp_repeater_hlp_port16_mii_tx_tsu), 
    .hlp_port16_sd_bit_slip(physs_hlp_repeater_hlp_port16_sd_bit_slip), 
    .hlp_port16_tsu_rx_sd(physs_hlp_repeater_hlp_port16_tsu_rx_sd), 
    .hlp_port16_xlgmii_rx_c(physs_hlp_repeater_hlp_port16_xlgmii_rx_c), 
    .hlp_port16_xlgmii_rx_data(physs_hlp_repeater_hlp_port16_xlgmii_rx_data), 
    .hlp_port16_xlgmii_rxclk_ena(physs_hlp_repeater_hlp_port16_xlgmii_rxclk_ena), 
    .hlp_port16_xlgmii_rxt0_next(physs_hlp_repeater_hlp_port16_xlgmii_rxt0_next), 
    .hlp_port16_xlgmii_tx_c(hlp_hlp_port16_xlgmii_tx_c), 
    .hlp_port16_xlgmii_tx_data(hlp_hlp_port16_xlgmii_tx_data), 
    .hlp_port16_xlgmii_txclk_ena(physs_hlp_repeater_hlp_port16_xlgmii_txclk_ena), 
    .hlp_port17_cgmii_rx_c(physs_hlp_repeater_hlp_port17_cgmii_rx_c), 
    .hlp_port17_cgmii_rx_data(physs_hlp_repeater_hlp_port17_cgmii_rx_data), 
    .hlp_port17_cgmii_rxclk_ena(physs_hlp_repeater_hlp_port17_cgmii_rxclk_ena), 
    .hlp_port17_cgmii_rxt0_next(physs_hlp_repeater_hlp_port17_cgmii_rxt0_next), 
    .hlp_port17_cgmii_tx_c(hlp_hlp_port17_cgmii_tx_c), 
    .hlp_port17_cgmii_tx_data(hlp_hlp_port17_cgmii_tx_data), 
    .hlp_port17_cgmii_txclk_ena(physs_hlp_repeater_hlp_port17_cgmii_txclk_ena), 
    .hlp_port17_desk_rlevel(physs_hlp_repeater_hlp_port17_desk_rlevel), 
    .hlp_port17_link_status(physs_hlp_repeater_hlp_port17_link_status), 
    .hlp_port17_mii_rx_tsu(physs_hlp_repeater_hlp_port17_mii_rx_tsu), 
    .hlp_port17_mii_tx_tsu(physs_hlp_repeater_hlp_port17_mii_tx_tsu), 
    .hlp_port17_sd_bit_slip(physs_hlp_repeater_hlp_port17_sd_bit_slip), 
    .hlp_port17_tsu_rx_sd(physs_hlp_repeater_hlp_port17_tsu_rx_sd), 
    .hlp_port17_xlgmii_rx_c(physs_hlp_repeater_hlp_port17_xlgmii_rx_c), 
    .hlp_port17_xlgmii_rx_data(physs_hlp_repeater_hlp_port17_xlgmii_rx_data), 
    .hlp_port17_xlgmii_rxclk_ena(physs_hlp_repeater_hlp_port17_xlgmii_rxclk_ena), 
    .hlp_port17_xlgmii_rxt0_next(physs_hlp_repeater_hlp_port17_xlgmii_rxt0_next), 
    .hlp_port17_xlgmii_tx_c(hlp_hlp_port17_xlgmii_tx_c), 
    .hlp_port17_xlgmii_tx_data(hlp_hlp_port17_xlgmii_tx_data), 
    .hlp_port17_xlgmii_txclk_ena(physs_hlp_repeater_hlp_port17_xlgmii_txclk_ena), 
    .hlp_port18_cgmii_rx_c(physs_hlp_repeater_hlp_port18_cgmii_rx_c), 
    .hlp_port18_cgmii_rx_data(physs_hlp_repeater_hlp_port18_cgmii_rx_data), 
    .hlp_port18_cgmii_rxclk_ena(physs_hlp_repeater_hlp_port18_cgmii_rxclk_ena), 
    .hlp_port18_cgmii_rxt0_next(physs_hlp_repeater_hlp_port18_cgmii_rxt0_next), 
    .hlp_port18_cgmii_tx_c(hlp_hlp_port18_cgmii_tx_c), 
    .hlp_port18_cgmii_tx_data(hlp_hlp_port18_cgmii_tx_data), 
    .hlp_port18_cgmii_txclk_ena(physs_hlp_repeater_hlp_port18_cgmii_txclk_ena), 
    .hlp_port18_desk_rlevel(physs_hlp_repeater_hlp_port18_desk_rlevel), 
    .hlp_port18_link_status(physs_hlp_repeater_hlp_port18_link_status), 
    .hlp_port18_mii_rx_tsu(physs_hlp_repeater_hlp_port18_mii_rx_tsu), 
    .hlp_port18_mii_tx_tsu(physs_hlp_repeater_hlp_port18_mii_tx_tsu), 
    .hlp_port18_sd_bit_slip(physs_hlp_repeater_hlp_port18_sd_bit_slip), 
    .hlp_port18_tsu_rx_sd(physs_hlp_repeater_hlp_port18_tsu_rx_sd), 
    .hlp_port18_xlgmii_rx_c(physs_hlp_repeater_hlp_port18_xlgmii_rx_c), 
    .hlp_port18_xlgmii_rx_data(physs_hlp_repeater_hlp_port18_xlgmii_rx_data), 
    .hlp_port18_xlgmii_rxclk_ena(physs_hlp_repeater_hlp_port18_xlgmii_rxclk_ena), 
    .hlp_port18_xlgmii_rxt0_next(physs_hlp_repeater_hlp_port18_xlgmii_rxt0_next), 
    .hlp_port18_xlgmii_tx_c(hlp_hlp_port18_xlgmii_tx_c), 
    .hlp_port18_xlgmii_tx_data(hlp_hlp_port18_xlgmii_tx_data), 
    .hlp_port18_xlgmii_txclk_ena(physs_hlp_repeater_hlp_port18_xlgmii_txclk_ena), 
    .hlp_port19_cgmii_rx_c(physs_hlp_repeater_hlp_port19_cgmii_rx_c), 
    .hlp_port19_cgmii_rx_data(physs_hlp_repeater_hlp_port19_cgmii_rx_data), 
    .hlp_port19_cgmii_rxclk_ena(physs_hlp_repeater_hlp_port19_cgmii_rxclk_ena), 
    .hlp_port19_cgmii_rxt0_next(physs_hlp_repeater_hlp_port19_cgmii_rxt0_next), 
    .hlp_port19_cgmii_tx_c(hlp_hlp_port19_cgmii_tx_c), 
    .hlp_port19_cgmii_tx_data(hlp_hlp_port19_cgmii_tx_data), 
    .hlp_port19_cgmii_txclk_ena(physs_hlp_repeater_hlp_port19_cgmii_txclk_ena), 
    .hlp_port19_desk_rlevel(physs_hlp_repeater_hlp_port19_desk_rlevel), 
    .hlp_port19_link_status(physs_hlp_repeater_hlp_port19_link_status), 
    .hlp_port19_mii_rx_tsu(physs_hlp_repeater_hlp_port19_mii_rx_tsu), 
    .hlp_port19_mii_tx_tsu(physs_hlp_repeater_hlp_port19_mii_tx_tsu), 
    .hlp_port19_sd_bit_slip(physs_hlp_repeater_hlp_port19_sd_bit_slip), 
    .hlp_port19_tsu_rx_sd(physs_hlp_repeater_hlp_port19_tsu_rx_sd), 
    .hlp_port19_xlgmii_rx_c(physs_hlp_repeater_hlp_port19_xlgmii_rx_c), 
    .hlp_port19_xlgmii_rx_data(physs_hlp_repeater_hlp_port19_xlgmii_rx_data), 
    .hlp_port19_xlgmii_rxclk_ena(physs_hlp_repeater_hlp_port19_xlgmii_rxclk_ena), 
    .hlp_port19_xlgmii_rxt0_next(physs_hlp_repeater_hlp_port19_xlgmii_rxt0_next), 
    .hlp_port19_xlgmii_tx_c(hlp_hlp_port19_xlgmii_tx_c), 
    .hlp_port19_xlgmii_tx_data(hlp_hlp_port19_xlgmii_tx_data), 
    .hlp_port19_xlgmii_txclk_ena(physs_hlp_repeater_hlp_port19_xlgmii_txclk_ena), 
    .hlp_port1_cgmii_rx_c(physs_hlp_repeater_hlp_port1_cgmii_rx_c), 
    .hlp_port1_cgmii_rx_data(physs_hlp_repeater_hlp_port1_cgmii_rx_data), 
    .hlp_port1_cgmii_rxclk_ena(physs_hlp_repeater_hlp_port1_cgmii_rxclk_ena), 
    .hlp_port1_cgmii_rxt0_next(physs_hlp_repeater_hlp_port1_cgmii_rxt0_next), 
    .hlp_port1_cgmii_tx_c(hlp_hlp_port1_cgmii_tx_c), 
    .hlp_port1_cgmii_tx_data(hlp_hlp_port1_cgmii_tx_data), 
    .hlp_port1_cgmii_txclk_ena(physs_hlp_repeater_hlp_port1_cgmii_txclk_ena), 
    .hlp_port1_xlgmii_rx_c(physs_hlp_repeater_hlp_port1_xlgmii_rx_c), 
    .hlp_port1_xlgmii_rx_data(physs_hlp_repeater_hlp_port1_xlgmii_rx_data), 
    .hlp_port1_xlgmii_rxclk_ena(physs_hlp_repeater_hlp_port1_xlgmii_rxclk_ena), 
    .hlp_port1_xlgmii_rxt0_next(physs_hlp_repeater_hlp_port1_xlgmii_rxt0_next), 
    .hlp_port1_xlgmii_tx_c(hlp_hlp_port1_xlgmii_tx_c), 
    .hlp_port1_xlgmii_tx_data(hlp_hlp_port1_xlgmii_tx_data), 
    .hlp_port1_xlgmii_txclk_ena(physs_hlp_repeater_hlp_port1_xlgmii_txclk_ena), 
    .hlp_port2_cgmii_rx_c(physs_hlp_repeater_hlp_port2_cgmii_rx_c), 
    .hlp_port2_cgmii_rx_data(physs_hlp_repeater_hlp_port2_cgmii_rx_data), 
    .hlp_port2_cgmii_rxclk_ena(physs_hlp_repeater_hlp_port2_cgmii_rxclk_ena), 
    .hlp_port2_cgmii_rxt0_next(physs_hlp_repeater_hlp_port2_cgmii_rxt0_next), 
    .hlp_port2_cgmii_tx_c(hlp_hlp_port2_cgmii_tx_c), 
    .hlp_port2_cgmii_tx_data(hlp_hlp_port2_cgmii_tx_data), 
    .hlp_port2_cgmii_txclk_ena(physs_hlp_repeater_hlp_port2_cgmii_txclk_ena), 
    .hlp_port2_xlgmii_rx_c(physs_hlp_repeater_hlp_port2_xlgmii_rx_c), 
    .hlp_port2_xlgmii_rx_data(physs_hlp_repeater_hlp_port2_xlgmii_rx_data), 
    .hlp_port2_xlgmii_rxclk_ena(physs_hlp_repeater_hlp_port2_xlgmii_rxclk_ena), 
    .hlp_port2_xlgmii_rxt0_next(physs_hlp_repeater_hlp_port2_xlgmii_rxt0_next), 
    .hlp_port2_xlgmii_tx_c(hlp_hlp_port2_xlgmii_tx_c), 
    .hlp_port2_xlgmii_tx_data(hlp_hlp_port2_xlgmii_tx_data), 
    .hlp_port2_xlgmii_txclk_ena(physs_hlp_repeater_hlp_port2_xlgmii_txclk_ena), 
    .hlp_port3_cgmii_rx_c(physs_hlp_repeater_hlp_port3_cgmii_rx_c), 
    .hlp_port3_cgmii_rx_data(physs_hlp_repeater_hlp_port3_cgmii_rx_data), 
    .hlp_port3_cgmii_rxclk_ena(physs_hlp_repeater_hlp_port3_cgmii_rxclk_ena), 
    .hlp_port3_cgmii_rxt0_next(physs_hlp_repeater_hlp_port3_cgmii_rxt0_next), 
    .hlp_port3_cgmii_tx_c(hlp_hlp_port3_cgmii_tx_c), 
    .hlp_port3_cgmii_tx_data(hlp_hlp_port3_cgmii_tx_data), 
    .hlp_port3_cgmii_txclk_ena(physs_hlp_repeater_hlp_port3_cgmii_txclk_ena), 
    .hlp_port3_xlgmii_rx_c(physs_hlp_repeater_hlp_port3_xlgmii_rx_c), 
    .hlp_port3_xlgmii_rx_data(physs_hlp_repeater_hlp_port3_xlgmii_rx_data), 
    .hlp_port3_xlgmii_rxclk_ena(physs_hlp_repeater_hlp_port3_xlgmii_rxclk_ena), 
    .hlp_port3_xlgmii_rxt0_next(physs_hlp_repeater_hlp_port3_xlgmii_rxt0_next), 
    .hlp_port3_xlgmii_tx_c(hlp_hlp_port3_xlgmii_tx_c), 
    .hlp_port3_xlgmii_tx_data(hlp_hlp_port3_xlgmii_tx_data), 
    .hlp_port3_xlgmii_txclk_ena(physs_hlp_repeater_hlp_port3_xlgmii_txclk_ena), 
    .hlp_port4_cgmii_rx_c(physs_hlp_repeater_hlp_port4_cgmii_rx_c), 
    .hlp_port4_cgmii_rx_data(physs_hlp_repeater_hlp_port4_cgmii_rx_data), 
    .hlp_port4_cgmii_rxclk_ena(physs_hlp_repeater_hlp_port4_cgmii_rxclk_ena), 
    .hlp_port4_cgmii_rxt0_next(physs_hlp_repeater_hlp_port4_cgmii_rxt0_next), 
    .hlp_port4_cgmii_tx_c(hlp_hlp_port4_cgmii_tx_c), 
    .hlp_port4_cgmii_tx_data(hlp_hlp_port4_cgmii_tx_data), 
    .hlp_port4_cgmii_txclk_ena(physs_hlp_repeater_hlp_port4_cgmii_txclk_ena), 
    .hlp_port4_desk_rlevel(physs_hlp_repeater_hlp_port4_desk_rlevel), 
    .hlp_port4_link_status(physs_hlp_repeater_hlp_port4_link_status), 
    .hlp_port4_mii_rx_tsu(physs_hlp_repeater_hlp_port4_mii_rx_tsu), 
    .hlp_port4_mii_tx_tsu(physs_hlp_repeater_hlp_port4_mii_tx_tsu), 
    .hlp_port4_sd_bit_slip(physs_hlp_repeater_hlp_port4_sd_bit_slip), 
    .hlp_port4_tsu_rx_sd(physs_hlp_repeater_hlp_port4_tsu_rx_sd), 
    .hlp_port4_xlgmii_rx_c(physs_hlp_repeater_hlp_port4_xlgmii_rx_c), 
    .hlp_port4_xlgmii_rx_data(physs_hlp_repeater_hlp_port4_xlgmii_rx_data), 
    .hlp_port4_xlgmii_rxclk_ena(physs_hlp_repeater_hlp_port4_xlgmii_rxclk_ena), 
    .hlp_port4_xlgmii_rxt0_next(physs_hlp_repeater_hlp_port4_xlgmii_rxt0_next), 
    .hlp_port4_xlgmii_tx_c(hlp_hlp_port4_xlgmii_tx_c), 
    .hlp_port4_xlgmii_tx_data(hlp_hlp_port4_xlgmii_tx_data), 
    .hlp_port4_xlgmii_txclk_ena(physs_hlp_repeater_hlp_port4_xlgmii_txclk_ena), 
    .hlp_port5_cgmii_rx_c(physs_hlp_repeater_hlp_port5_cgmii_rx_c), 
    .hlp_port5_cgmii_rx_data(physs_hlp_repeater_hlp_port5_cgmii_rx_data), 
    .hlp_port5_cgmii_rxclk_ena(physs_hlp_repeater_hlp_port5_cgmii_rxclk_ena), 
    .hlp_port5_cgmii_rxt0_next(physs_hlp_repeater_hlp_port5_cgmii_rxt0_next), 
    .hlp_port5_cgmii_tx_c(hlp_hlp_port5_cgmii_tx_c), 
    .hlp_port5_cgmii_tx_data(hlp_hlp_port5_cgmii_tx_data), 
    .hlp_port5_cgmii_txclk_ena(physs_hlp_repeater_hlp_port5_cgmii_txclk_ena), 
    .hlp_port5_desk_rlevel(physs_hlp_repeater_hlp_port5_desk_rlevel), 
    .hlp_port5_link_status(physs_hlp_repeater_hlp_port5_link_status), 
    .hlp_port5_mii_rx_tsu(physs_hlp_repeater_hlp_port5_mii_rx_tsu), 
    .hlp_port5_mii_tx_tsu(physs_hlp_repeater_hlp_port5_mii_tx_tsu), 
    .hlp_port5_sd_bit_slip(physs_hlp_repeater_hlp_port5_sd_bit_slip), 
    .hlp_port5_tsu_rx_sd(physs_hlp_repeater_hlp_port5_tsu_rx_sd), 
    .hlp_port5_xlgmii_rx_c(physs_hlp_repeater_hlp_port5_xlgmii_rx_c), 
    .hlp_port5_xlgmii_rx_data(physs_hlp_repeater_hlp_port5_xlgmii_rx_data), 
    .hlp_port5_xlgmii_rxclk_ena(physs_hlp_repeater_hlp_port5_xlgmii_rxclk_ena), 
    .hlp_port5_xlgmii_rxt0_next(physs_hlp_repeater_hlp_port5_xlgmii_rxt0_next), 
    .hlp_port5_xlgmii_tx_c(hlp_hlp_port5_xlgmii_tx_c), 
    .hlp_port5_xlgmii_tx_data(hlp_hlp_port5_xlgmii_tx_data), 
    .hlp_port5_xlgmii_txclk_ena(physs_hlp_repeater_hlp_port5_xlgmii_txclk_ena), 
    .hlp_port6_cgmii_rx_c(physs_hlp_repeater_hlp_port6_cgmii_rx_c), 
    .hlp_port6_cgmii_rx_data(physs_hlp_repeater_hlp_port6_cgmii_rx_data), 
    .hlp_port6_cgmii_rxclk_ena(physs_hlp_repeater_hlp_port6_cgmii_rxclk_ena), 
    .hlp_port6_cgmii_rxt0_next(physs_hlp_repeater_hlp_port6_cgmii_rxt0_next), 
    .hlp_port6_cgmii_tx_c(hlp_hlp_port6_cgmii_tx_c), 
    .hlp_port6_cgmii_tx_data(hlp_hlp_port6_cgmii_tx_data), 
    .hlp_port6_cgmii_txclk_ena(physs_hlp_repeater_hlp_port6_cgmii_txclk_ena), 
    .hlp_port6_desk_rlevel(physs_hlp_repeater_hlp_port6_desk_rlevel), 
    .hlp_port6_link_status(physs_hlp_repeater_hlp_port6_link_status), 
    .hlp_port6_mii_rx_tsu(physs_hlp_repeater_hlp_port6_mii_rx_tsu), 
    .hlp_port6_mii_tx_tsu(physs_hlp_repeater_hlp_port6_mii_tx_tsu), 
    .hlp_port6_sd_bit_slip(physs_hlp_repeater_hlp_port6_sd_bit_slip), 
    .hlp_port6_tsu_rx_sd(physs_hlp_repeater_hlp_port6_tsu_rx_sd), 
    .hlp_port6_xlgmii_rx_c(physs_hlp_repeater_hlp_port6_xlgmii_rx_c), 
    .hlp_port6_xlgmii_rx_data(physs_hlp_repeater_hlp_port6_xlgmii_rx_data), 
    .hlp_port6_xlgmii_rxclk_ena(physs_hlp_repeater_hlp_port6_xlgmii_rxclk_ena), 
    .hlp_port6_xlgmii_rxt0_next(physs_hlp_repeater_hlp_port6_xlgmii_rxt0_next), 
    .hlp_port6_xlgmii_tx_c(hlp_hlp_port6_xlgmii_tx_c), 
    .hlp_port6_xlgmii_tx_data(hlp_hlp_port6_xlgmii_tx_data), 
    .hlp_port6_xlgmii_txclk_ena(physs_hlp_repeater_hlp_port6_xlgmii_txclk_ena), 
    .hlp_port7_cgmii_rx_c(physs_hlp_repeater_hlp_port7_cgmii_rx_c), 
    .hlp_port7_cgmii_rx_data(physs_hlp_repeater_hlp_port7_cgmii_rx_data), 
    .hlp_port7_cgmii_rxclk_ena(physs_hlp_repeater_hlp_port7_cgmii_rxclk_ena), 
    .hlp_port7_cgmii_rxt0_next(physs_hlp_repeater_hlp_port7_cgmii_rxt0_next), 
    .hlp_port7_cgmii_tx_c(hlp_hlp_port7_cgmii_tx_c), 
    .hlp_port7_cgmii_tx_data(hlp_hlp_port7_cgmii_tx_data), 
    .hlp_port7_cgmii_txclk_ena(physs_hlp_repeater_hlp_port7_cgmii_txclk_ena), 
    .hlp_port7_desk_rlevel(physs_hlp_repeater_hlp_port7_desk_rlevel), 
    .hlp_port7_link_status(physs_hlp_repeater_hlp_port7_link_status), 
    .hlp_port7_mii_rx_tsu(physs_hlp_repeater_hlp_port7_mii_rx_tsu), 
    .hlp_port7_mii_tx_tsu(physs_hlp_repeater_hlp_port7_mii_tx_tsu), 
    .hlp_port7_sd_bit_slip(physs_hlp_repeater_hlp_port7_sd_bit_slip), 
    .hlp_port7_tsu_rx_sd(physs_hlp_repeater_hlp_port7_tsu_rx_sd), 
    .hlp_port7_xlgmii_rx_c(physs_hlp_repeater_hlp_port7_xlgmii_rx_c), 
    .hlp_port7_xlgmii_rx_data(physs_hlp_repeater_hlp_port7_xlgmii_rx_data), 
    .hlp_port7_xlgmii_rxclk_ena(physs_hlp_repeater_hlp_port7_xlgmii_rxclk_ena), 
    .hlp_port7_xlgmii_rxt0_next(physs_hlp_repeater_hlp_port7_xlgmii_rxt0_next), 
    .hlp_port7_xlgmii_tx_c(hlp_hlp_port7_xlgmii_tx_c), 
    .hlp_port7_xlgmii_tx_data(hlp_hlp_port7_xlgmii_tx_data), 
    .hlp_port7_xlgmii_txclk_ena(physs_hlp_repeater_hlp_port7_xlgmii_txclk_ena), 
    .hlp_port8_cgmii_rx_c(physs_hlp_repeater_hlp_port8_cgmii_rx_c), 
    .hlp_port8_cgmii_rx_data(physs_hlp_repeater_hlp_port8_cgmii_rx_data), 
    .hlp_port8_cgmii_rxclk_ena(physs_hlp_repeater_hlp_port8_cgmii_rxclk_ena), 
    .hlp_port8_cgmii_rxt0_next(physs_hlp_repeater_hlp_port8_cgmii_rxt0_next), 
    .hlp_port8_cgmii_tx_c(hlp_hlp_port8_cgmii_tx_c), 
    .hlp_port8_cgmii_tx_data(hlp_hlp_port8_cgmii_tx_data), 
    .hlp_port8_cgmii_txclk_ena(physs_hlp_repeater_hlp_port8_cgmii_txclk_ena), 
    .hlp_port8_desk_rlevel(physs_hlp_repeater_hlp_port8_desk_rlevel), 
    .hlp_port8_link_status(physs_hlp_repeater_hlp_port8_link_status), 
    .hlp_port8_mii_rx_tsu(physs_hlp_repeater_hlp_port8_mii_rx_tsu), 
    .hlp_port8_mii_tx_tsu(physs_hlp_repeater_hlp_port8_mii_tx_tsu), 
    .hlp_port8_sd_bit_slip(physs_hlp_repeater_hlp_port8_sd_bit_slip), 
    .hlp_port8_tsu_rx_sd(physs_hlp_repeater_hlp_port8_tsu_rx_sd), 
    .hlp_port8_xlgmii_rx_c(physs_hlp_repeater_hlp_port8_xlgmii_rx_c), 
    .hlp_port8_xlgmii_rx_data(physs_hlp_repeater_hlp_port8_xlgmii_rx_data), 
    .hlp_port8_xlgmii_rxclk_ena(physs_hlp_repeater_hlp_port8_xlgmii_rxclk_ena), 
    .hlp_port8_xlgmii_rxt0_next(physs_hlp_repeater_hlp_port8_xlgmii_rxt0_next), 
    .hlp_port8_xlgmii_tx_c(hlp_hlp_port8_xlgmii_tx_c), 
    .hlp_port8_xlgmii_tx_data(hlp_hlp_port8_xlgmii_tx_data), 
    .hlp_port8_xlgmii_txclk_ena(physs_hlp_repeater_hlp_port8_xlgmii_txclk_ena), 
    .hlp_port9_cgmii_rx_c(physs_hlp_repeater_hlp_port9_cgmii_rx_c), 
    .hlp_port9_cgmii_rx_data(physs_hlp_repeater_hlp_port9_cgmii_rx_data), 
    .hlp_port9_cgmii_rxclk_ena(physs_hlp_repeater_hlp_port9_cgmii_rxclk_ena), 
    .hlp_port9_cgmii_rxt0_next(physs_hlp_repeater_hlp_port9_cgmii_rxt0_next), 
    .hlp_port9_cgmii_tx_c(hlp_hlp_port9_cgmii_tx_c), 
    .hlp_port9_cgmii_tx_data(hlp_hlp_port9_cgmii_tx_data), 
    .hlp_port9_cgmii_txclk_ena(physs_hlp_repeater_hlp_port9_cgmii_txclk_ena), 
    .hlp_port9_desk_rlevel(physs_hlp_repeater_hlp_port9_desk_rlevel), 
    .hlp_port9_link_status(physs_hlp_repeater_hlp_port9_link_status), 
    .hlp_port9_mii_rx_tsu(physs_hlp_repeater_hlp_port9_mii_rx_tsu), 
    .hlp_port9_mii_tx_tsu(physs_hlp_repeater_hlp_port9_mii_tx_tsu), 
    .hlp_port9_sd_bit_slip(physs_hlp_repeater_hlp_port9_sd_bit_slip), 
    .hlp_port9_tsu_rx_sd(physs_hlp_repeater_hlp_port9_tsu_rx_sd), 
    .hlp_port9_xlgmii_rx_c(physs_hlp_repeater_hlp_port9_xlgmii_rx_c), 
    .hlp_port9_xlgmii_rx_data(physs_hlp_repeater_hlp_port9_xlgmii_rx_data), 
    .hlp_port9_xlgmii_rxclk_ena(physs_hlp_repeater_hlp_port9_xlgmii_rxclk_ena), 
    .hlp_port9_xlgmii_rxt0_next(physs_hlp_repeater_hlp_port9_xlgmii_rxt0_next), 
    .hlp_port9_xlgmii_tx_c(hlp_hlp_port9_xlgmii_tx_c), 
    .hlp_port9_xlgmii_tx_data(hlp_hlp_port9_xlgmii_tx_data), 
    .hlp_port9_xlgmii_txclk_ena(physs_hlp_repeater_hlp_port9_xlgmii_txclk_ena), 
    .i_hlp_func_fuse(51'b0), 
    .lsm_apr_pwr_mgmt_in_rf(5'b0), 
    .lsm_apr_pwr_mgmt_in_sram(6'b0), 
    .phy_interrupt(1'b0), 
    .powergood_rst_b(nac_pwrgood_rst_b), 
    .arready_s(hlp_arready_s), 
    .awready_s(hlp_awready_s), 
    .bid_s(hlp_bid_s), 
    .bresp_s(hlp_bresp_s), 
    .bvalid_s(hlp_bvalid_s), 
    .rdata_s(hlp_rdata_s), 
    .rid_s(hlp_rid_s), 
    .rlast_s(hlp_rlast_s), 
    .rresp_s(hlp_rresp_s), 
    .rvalid_s(hlp_rvalid_s), 
    .wready_s(hlp_wready_s), 
    .araddr_s(nss_i_nmf_t_cnic_hlp_ARADDR), 
    .arburst_s(nss_i_nmf_t_cnic_hlp_ARBURST), 
    .arid_s(nss_i_nmf_t_cnic_hlp_ARID), 
    .arlen_s(nss_i_nmf_t_cnic_hlp_ARLEN), 
    .arsize_s(nss_i_nmf_t_cnic_hlp_ARSIZE), 
    .arvalid_s(nss_i_nmf_t_cnic_hlp_ARVALID), 
    .awaddr_s(nss_i_nmf_t_cnic_hlp_AWADDR), 
    .awburst_s(nss_i_nmf_t_cnic_hlp_AWBURST), 
    .awid_s(nss_i_nmf_t_cnic_hlp_AWID), 
    .awlen_s(nss_i_nmf_t_cnic_hlp_AWLEN), 
    .awsize_s(nss_i_nmf_t_cnic_hlp_AWSIZE), 
    .awvalid_s(nss_i_nmf_t_cnic_hlp_AWVALID), 
    .bready_s(nss_i_nmf_t_cnic_hlp_BREADY), 
    .rready_s(nss_i_nmf_t_cnic_hlp_RREADY), 
    .wdata_s(nss_i_nmf_t_cnic_hlp_WDATA), 
    .wlast_s(nss_i_nmf_t_cnic_hlp_WLAST), 
    .wstrb_s(nss_i_nmf_t_cnic_hlp_WSTRB), 
    .wvalid_s(nss_i_nmf_t_cnic_hlp_WVALID), 
    .hlp_rst_b(nss_hlp_reset_func_n), 
    .oob_pfc_xoff(hlp_oob_pfc_xoff), 
    .oob_lfc_xoff(hlp_oob_lfc_xoff), 
    .hlp_physs_timesync_sync_val(hlp_fabric3_out), 
    .hlp_port0_tx_stop(physs_tx_stop_0_out), 
    .hlp_port1_tx_stop(physs_tx_stop_1_out), 
    .hlp_port2_tx_stop(physs_tx_stop_2_out), 
    .hlp_port3_tx_stop(physs_tx_stop_3_out), 
    .hlp_start_post(nac_post_post_trig_hlp), 
    .hlp_post_done(hlp_hlp_post_done), 
    .hlp_post_pass(hlp_hlp_post_pass), 
    .hlp_port0_rx_throttle(hlp_hlp_port0_rx_throttle), 
    .hlp_port1_rx_throttle(hlp_hlp_port1_rx_throttle), 
    .hlp_port2_rx_throttle(hlp_hlp_port2_rx_throttle), 
    .hlp_port3_rx_throttle(hlp_hlp_port3_rx_throttle), 
    .hlp_post_mux_ctrl(nac_post_post_mux_ctrl_hlp), 
    .hlp_post_clkungate(nac_post_post_clkungate_hlp), 
    .HLP_DISABLE(nac_glue_logic_inst_resolved_hlp_disabled_0), 
    .hlp_port0_sd_bit_slip(8'b0), 
    .hlp_port1_sd_bit_slip(8'b0), 
    .hlp_port2_sd_bit_slip(8'b0), 
    .hlp_port3_sd_bit_slip(8'b0), 
    .hlp_port0_link_status(1'b0), 
    .hlp_port1_link_status(1'b0), 
    .hlp_port2_link_status(1'b0), 
    .hlp_port3_link_status(1'b0), 
    .hlp_port0_desk_rlevel(7'b0), 
    .hlp_port1_desk_rlevel(7'b0), 
    .hlp_port2_desk_rlevel(7'b0), 
    .hlp_port3_desk_rlevel(7'b0), 
    .hlp_port0_mii_tx_tsu(2'b0), 
    .hlp_port1_mii_tx_tsu(2'b0), 
    .hlp_port2_mii_tx_tsu(2'b0), 
    .hlp_port3_mii_tx_tsu(2'b0), 
    .hlp_port0_mii_rx_tsu(2'b0), 
    .hlp_port1_mii_rx_tsu(2'b0), 
    .hlp_port2_mii_rx_tsu(2'b0), 
    .hlp_port3_mii_rx_tsu(2'b0), 
    .hlp_port0_tsu_rx_sd(2'b0), 
    .hlp_port1_tsu_rx_sd(2'b0), 
    .hlp_port2_tsu_rx_sd(2'b0), 
    .hlp_port3_tsu_rx_sd(2'b0), 
    .secure_group_a(1'b0), 
    .secure_group_b(1'b0), 
    .secure_group_c(1'b0), 
    .secure_group_d(1'b0), 
    .secure_group_e(1'b0), 
    .secure_group_g(1'b0), 
    .secure_group_h(1'b0), 
    .secure_group_f(1'b0), 
    .secure_group_z(1'b0), 
    .lsm_apr_fsta_dfxact_afd(1'b0), 
    .pgcb_tck(1'b0), 
    .dtf_survive_mode(1'b0), 
    .dvp_tsc_adjustment_strap(16'b0), 
    .dvp_fast_cnt_width(2'b0), 
    .dvp_fid_strap(8'b0), 
    .dvp_bar_strap(1'b0), 
    .dvp_addr_base_strap(48'b0), 
    .dvp_addr_mask_strap(48'b0), 
    .i_hlp_dts_diode0_anode(dts_nac1_i_anode), 
    .o_hlp_dts_diode0_anode(hlp_o_hlp_dts_diode0_anode), 
    .i_hlp_dts_diode0_cathode(dts_nac1_i_cathode), 
    .o_hlp_dts_diode0_cathode(hlp_o_hlp_dts_diode0_cathode), 
    .i_hlp_dts_diode1_anode(dts_nac1_i_anode_0), 
    .o_hlp_dts_diode1_anode(hlp_o_hlp_dts_diode1_anode), 
    .i_hlp_dts_diode1_cathode(dts_nac1_i_cathode), 
    .o_hlp_dts_diode1_cathode(hlp_o_hlp_dts_diode1_cathode), 
    .i_hlp_dts_diode2_anode(dts_nac1_i_anode_1), 
    .o_hlp_dts_diode2_anode(hlp_o_hlp_dts_diode2_anode), 
    .i_hlp_dts_diode2_cathode(dts_nac1_i_cathode), 
    .o_hlp_dts_diode2_cathode(hlp_o_hlp_dts_diode2_cathode), 
    .dvp_trig_fabric_out(hlp_dvp_trig_fabric_out), 
    .dvp_trig_fabric_in_ack(hlp_dvp_trig_fabric_in_ack), 
    .dvp_trig_fabric_in(hlp_tfb_req_out_agent), 
    .dvp_trig_fabric_out_ack(hlp_tfb_ack_out_agent), 
    .dvp_pprot(apb_dser_hlp_dvp_pprot), 
    .dvp_psel(apb_dser_hlp_dvp_psel), 
    .dvp_penable(apb_dser_hlp_dvp_penable), 
    .dvp_pwrite(apb_dser_hlp_dvp_pwrite), 
    .dvp_pwdata(apb_dser_hlp_dvp_pwdata), 
    .dvp_pstrb(apb_dser_hlp_dvp_pstrb), 
    .dvp_paddr(apb_dser_hlp_dvp_paddr), 
    .dvp_pready(hlp_dvp_pready), 
    .dvp_prdata(hlp_dvp_prdata), 
    .dvp_pslverr(hlp_dvp_pslverr), 
    .dvp_serial_download_tsc(nac_ss_debug_timestamp), 
    .dvp_sai_priv_agent_strap(64'b0), 
    .dvp_sai_secure_agent_strap(64'b0), 
    .DIAG_AGGR_mbist_diag_done(1'b0), 
    .dvp_qreqn(1'b0), 
    .dvp_tap_tck(1'b0), 
    .pd_vinf_bisr_clk_out(), 
    .pd_vinf_bisr_reset_out(), 
    .pd_vinf_bisr_shift_en_out(), 
    .tdi_tdo_rpt(), 
    .ssn_bus_clock_out(), 
    .hlp_ready(), 
    .hlp_globrst_done(), 
    .side_pok(), 
    .dvp_qacceptn(), 
    .dvp_qdeny(), 
    .dvp_qactive(), 
    .dvp_dtf_qactive(), 
    .dvp_qactive_0()
) ; 
nsc nss (
    .scon_hifcar_rst_n(nss_scon_hifcar_rst_n), 
    .pcie_phy0_hif_spare_in(hif_pcie_gen6_phy_18a_pcie_phy_hif_spare), 
    .hif_pcie_phy0_spare_out(nss_hif_pcie_phy0_spare_out), 
    .hif_pcie_phy0_sram_ecc_int(hif_pcie_gen6_phy_18a_pciephyss_hif_intr_fatal_out), 
    .hif_t_pcie_phycrif0_pslverr(hif_pcie_gen6_phy_18a_hif_t_pcie_phycrif_pslverr), 
    .hif_t_pcie_phycrif0_prdata(hif_pcie_gen6_phy_18a_hif_t_pcie_phycrif_prdata), 
    .hif_t_pcie_phycrif0_pready(hif_pcie_gen6_phy_18a_hif_t_pcie_phycrif_pready), 
    .hif_t_pcie_phycrif0_paddr(nss_hif_t_pcie_phycrif0_paddr), 
    .hif_t_pcie_phycrif0_penable(nss_hif_t_pcie_phycrif0_penable), 
    .hif_t_pcie_phycrif0_pprot(nss_hif_t_pcie_phycrif0_pprot), 
    .hif_t_pcie_phycrif0_psel(nss_hif_t_pcie_phycrif0_psel), 
    .hif_t_pcie_phycrif0_pstrb(nss_hif_t_pcie_phycrif0_pstrb), 
    .hif_t_pcie_phycrif0_pwdata(nss_hif_t_pcie_phycrif0_pwdata), 
    .hif_t_pcie_phycrif0_pwrite(nss_hif_t_pcie_phycrif0_pwrite), 
    .hif_t_pcie_phyctrl0_pslverr(hif_pcie_gen6_phy_18a_hif_t_pcie_phyctrl_pslverr), 
    .hif_t_pcie_phyctrl0_prdata(hif_pcie_gen6_phy_18a_hif_t_pcie_phyctrl_prdata), 
    .hif_t_pcie_phyctrl0_pready(hif_pcie_gen6_phy_18a_hif_t_pcie_phyctrl_pready), 
    .hif_t_pcie_phyctrl0_paddr(nss_hif_t_pcie_phyctrl0_paddr), 
    .hif_t_pcie_phyctrl0_penable(nss_hif_t_pcie_phyctrl0_penable), 
    .hif_t_pcie_phyctrl0_pprot(nss_hif_t_pcie_phyctrl0_pprot), 
    .hif_t_pcie_phyctrl0_psel(nss_hif_t_pcie_phyctrl0_psel), 
    .hif_t_pcie_phyctrl0_pstrb(nss_hif_t_pcie_phyctrl0_pstrb), 
    .hif_t_pcie_phyctrl0_pwdata(nss_hif_t_pcie_phyctrl0_pwdata), 
    .hif_t_pcie_phyctrl0_pwrite(nss_hif_t_pcie_phyctrl0_pwrite), 
    .phy_pcie0_pipe_clk(nss_phy_pcie0_pipe_clk), 
    .hif_pcie0_mac_phy_txdata(nss_hif_pcie0_mac_phy_txdata), 
    .hif_pcie0_mac_phy_txdatavalid(nss_hif_pcie0_mac_phy_txdatavalid), 
    .hif_pcie0_mac_phy_rxwidth(nss_hif_pcie0_mac_phy_rxwidth), 
    .hif_pcie0_mac_phy_txdetectrx_loopback(nss_hif_pcie0_mac_phy_txdetectrx_loopback), 
    .hif_pcie0_mac_phy_txelecidle(nss_hif_pcie0_mac_phy_txelecidle), 
    .hif_pcie0_mac_phy_powerdown(nss_hif_pcie0_mac_phy_powerdown), 
    .hif_pcie0_mac_phy_rxelecidle_disable(nss_hif_pcie0_mac_phy_rxelecidle_disable), 
    .hif_pcie0_mac_phy_txcommonmode_disable(nss_hif_pcie0_mac_phy_txcommonmode_disable), 
    .hif_pcie0_mac_phy_rate(nss_hif_pcie0_mac_phy_rate), 
    .hif_pcie0_mac_phy_width(nss_hif_pcie0_mac_phy_width), 
    .hif_pcie0_mac_phy_pclk_rate(nss_hif_pcie0_mac_phy_pclk_rate), 
    .hif_pcie0_mac_phy_rxstandby(nss_hif_pcie0_mac_phy_rxstandby), 
    .hif_pcie0_mac_phy_messagebus(nss_hif_pcie0_mac_phy_messagebus), 
    .hif_pcie0_mac_phy_serdes_arch(nss_hif_pcie0_mac_phy_serdes_arch), 
    .hif_pcie0_serdes_pipe_rxready(nss_hif_pcie0_serdes_pipe_rxready), 
    .hif_pcie0_mac_phy_commonclock_enable(nss_hif_pcie0_mac_phy_commonclock_enable), 
    .hif_pcie0_mac_phy_asyncpowerchangeack(nss_hif_pcie0_mac_phy_asyncpowerchangeack), 
    .hif_pcie0_mac_phy_sris_enable(nss_hif_pcie0_mac_phy_sris_enable), 
    .hif_pcie0_mac_phy_pclkchangeack(nss_hif_pcie0_mac_phy_pclkchangeack), 
    .hif_pcie0_phy_mac_pclkchangeok(hif_pcie_gen6_phy_18a_hif_pcie0_phy_mac_pclkchangeok), 
    .phy_pcie0_max_pclk(hif_pcie_gen6_phy_18a_phy_pcie0_max_pclk), 
    .hif_pcie0_phy_mac_rxdata(hif_pcie_gen6_phy_18a_hif_pcie0_phy_mac_rxdata), 
    .phy_pcie0_pipe_rx_clk(hif_pcie_gen6_phy_18a_phy_pcie0_pipe_rx_clk), 
    .hif_pcie0_phy_mac_rxstandbystatus(hif_pcie_gen6_phy_18a_hif_pcie0_phy_mac_rxstandbystatus), 
    .hif_pcie0_phy_mac_rxvalid(hif_pcie_gen6_phy_18a_hif_pcie0_phy_mac_rxvalid), 
    .hif_pcie0_phy_mac_phystatus(hif_pcie_gen6_phy_18a_hif_pcie0_phy_mac_phystatus), 
    .hif_pcie0_phy_mac_rxelecidle(hif_pcie_gen6_phy_18a_hif_pcie0_phy_mac_rxelecidle), 
    .hif_pcie0_phy_mac_rxstatus(hif_pcie_gen6_phy_18a_hif_pcie0_phy_mac_rxstatus), 
    .hif_pcie0_phy_mac_messagebus(hif_pcie_gen6_phy_18a_hif_pcie0_phy_mac_messagebus), 
    .phy_pcie2_pipe_clk(nss_phy_pcie2_pipe_clk), 
    .hif_pcie2_mac_phy_txdata(nss_hif_pcie2_mac_phy_txdata), 
    .hif_pcie2_mac_phy_txdatavalid(nss_hif_pcie2_mac_phy_txdatavalid), 
    .hif_pcie2_mac_phy_rxwidth(nss_hif_pcie2_mac_phy_rxwidth), 
    .hif_pcie2_mac_phy_txdetectrx_loopback(nss_hif_pcie2_mac_phy_txdetectrx_loopback), 
    .hif_pcie2_mac_phy_txelecidle(nss_hif_pcie2_mac_phy_txelecidle), 
    .hif_pcie2_mac_phy_powerdown(nss_hif_pcie2_mac_phy_powerdown), 
    .hif_pcie2_mac_phy_rxelecidle_disable(nss_hif_pcie2_mac_phy_rxelecidle_disable), 
    .hif_pcie2_mac_phy_txcommonmode_disable(nss_hif_pcie2_mac_phy_txcommonmode_disable), 
    .hif_pcie2_mac_phy_rate(nss_hif_pcie2_mac_phy_rate), 
    .hif_pcie2_mac_phy_width(nss_hif_pcie2_mac_phy_width), 
    .hif_pcie2_mac_phy_pclk_rate(nss_hif_pcie2_mac_phy_pclk_rate), 
    .hif_pcie2_mac_phy_rxstandby(nss_hif_pcie2_mac_phy_rxstandby), 
    .hif_pcie2_mac_phy_messagebus(nss_hif_pcie2_mac_phy_messagebus), 
    .hif_pcie2_mac_phy_serdes_arch(nss_hif_pcie2_mac_phy_serdes_arch), 
    .hif_pcie2_serdes_pipe_rxready(nss_hif_pcie2_serdes_pipe_rxready), 
    .hif_pcie2_mac_phy_commonclock_enable(nss_hif_pcie2_mac_phy_commonclock_enable), 
    .hif_pcie2_mac_phy_asyncpowerchangeack(nss_hif_pcie2_mac_phy_asyncpowerchangeack), 
    .hif_pcie2_mac_phy_sris_enable(nss_hif_pcie2_mac_phy_sris_enable), 
    .hif_pcie2_mac_phy_pclkchangeack(nss_hif_pcie2_mac_phy_pclkchangeack), 
    .hif_pcie2_phy_mac_pclkchangeok(hif_pcie_gen6_phy_18a_hif_pcie2_phy_mac_pclkchangeok), 
    .phy_pcie2_max_pclk(hif_pcie_gen6_phy_18a_phy_pcie2_max_pclk), 
    .hif_pcie2_phy_mac_rxdata(hif_pcie_gen6_phy_18a_hif_pcie2_phy_mac_rxdata), 
    .phy_pcie2_pipe_rx_clk(hif_pcie_gen6_phy_18a_phy_pcie2_pipe_rx_clk), 
    .hif_pcie2_phy_mac_rxstandbystatus(hif_pcie_gen6_phy_18a_hif_pcie2_phy_mac_rxstandbystatus), 
    .hif_pcie2_phy_mac_rxvalid(hif_pcie_gen6_phy_18a_hif_pcie2_phy_mac_rxvalid), 
    .hif_pcie2_phy_mac_phystatus(hif_pcie_gen6_phy_18a_hif_pcie2_phy_mac_phystatus), 
    .hif_pcie2_phy_mac_rxelecidle(hif_pcie_gen6_phy_18a_hif_pcie2_phy_mac_rxelecidle), 
    .hif_pcie2_phy_mac_rxstatus(hif_pcie_gen6_phy_18a_hif_pcie2_phy_mac_rxstatus), 
    .hif_pcie2_phy_mac_messagebus(hif_pcie_gen6_phy_18a_hif_pcie2_phy_mac_messagebus), 
    .phy_pcie4_pipe_clk(nss_phy_pcie4_pipe_clk), 
    .hif_pcie4_mac_phy_txdata(nss_hif_pcie4_mac_phy_txdata), 
    .hif_pcie4_mac_phy_txdatavalid(nss_hif_pcie4_mac_phy_txdatavalid), 
    .hif_pcie4_mac_phy_rxwidth(nss_hif_pcie4_mac_phy_rxwidth), 
    .hif_pcie4_mac_phy_txdetectrx_loopback(nss_hif_pcie4_mac_phy_txdetectrx_loopback), 
    .hif_pcie4_mac_phy_txelecidle(nss_hif_pcie4_mac_phy_txelecidle), 
    .hif_pcie4_mac_phy_powerdown(nss_hif_pcie4_mac_phy_powerdown), 
    .hif_pcie4_mac_phy_rxelecidle_disable(nss_hif_pcie4_mac_phy_rxelecidle_disable), 
    .hif_pcie4_mac_phy_txcommonmode_disable(nss_hif_pcie4_mac_phy_txcommonmode_disable), 
    .hif_pcie4_mac_phy_rate(nss_hif_pcie4_mac_phy_rate), 
    .hif_pcie4_mac_phy_width(nss_hif_pcie4_mac_phy_width), 
    .hif_pcie4_mac_phy_pclk_rate(nss_hif_pcie4_mac_phy_pclk_rate), 
    .hif_pcie4_mac_phy_rxstandby(nss_hif_pcie4_mac_phy_rxstandby), 
    .hif_pcie4_mac_phy_messagebus(nss_hif_pcie4_mac_phy_messagebus), 
    .hif_pcie4_mac_phy_serdes_arch(nss_hif_pcie4_mac_phy_serdes_arch), 
    .hif_pcie4_serdes_pipe_rxready(nss_hif_pcie4_serdes_pipe_rxready), 
    .hif_pcie4_mac_phy_commonclock_enable(nss_hif_pcie4_mac_phy_commonclock_enable), 
    .hif_pcie4_mac_phy_asyncpowerchangeack(nss_hif_pcie4_mac_phy_asyncpowerchangeack), 
    .hif_pcie4_mac_phy_sris_enable(nss_hif_pcie4_mac_phy_sris_enable), 
    .hif_pcie4_mac_phy_pclkchangeack(nss_hif_pcie4_mac_phy_pclkchangeack), 
    .hif_pcie4_phy_mac_pclkchangeok(hif_pcie_gen6_phy_18a_hif_pcie4_phy_mac_pclkchangeok), 
    .phy_pcie4_max_pclk(hif_pcie_gen6_phy_18a_phy_pcie4_max_pclk), 
    .hif_pcie4_phy_mac_rxdata(hif_pcie_gen6_phy_18a_hif_pcie4_phy_mac_rxdata), 
    .phy_pcie4_pipe_rx_clk(hif_pcie_gen6_phy_18a_phy_pcie4_pipe_rx_clk), 
    .hif_pcie4_phy_mac_rxstandbystatus(hif_pcie_gen6_phy_18a_hif_pcie4_phy_mac_rxstandbystatus), 
    .hif_pcie4_phy_mac_rxvalid(hif_pcie_gen6_phy_18a_hif_pcie4_phy_mac_rxvalid), 
    .hif_pcie4_phy_mac_phystatus(hif_pcie_gen6_phy_18a_hif_pcie4_phy_mac_phystatus), 
    .hif_pcie4_phy_mac_rxelecidle(hif_pcie_gen6_phy_18a_hif_pcie4_phy_mac_rxelecidle), 
    .hif_pcie4_phy_mac_rxstatus(hif_pcie_gen6_phy_18a_hif_pcie4_phy_mac_rxstatus), 
    .hif_pcie4_phy_mac_messagebus(hif_pcie_gen6_phy_18a_hif_pcie4_phy_mac_messagebus), 
    .phy_pcie6_pipe_clk(nss_phy_pcie6_pipe_clk), 
    .hif_pcie6_mac_phy_txdata(nss_hif_pcie6_mac_phy_txdata), 
    .hif_pcie6_mac_phy_txdatavalid(nss_hif_pcie6_mac_phy_txdatavalid), 
    .hif_pcie6_mac_phy_rxwidth(nss_hif_pcie6_mac_phy_rxwidth), 
    .hif_pcie6_mac_phy_txdetectrx_loopback(nss_hif_pcie6_mac_phy_txdetectrx_loopback), 
    .hif_pcie6_mac_phy_txelecidle(nss_hif_pcie6_mac_phy_txelecidle), 
    .hif_pcie6_mac_phy_powerdown(nss_hif_pcie6_mac_phy_powerdown), 
    .hif_pcie6_mac_phy_rxelecidle_disable(nss_hif_pcie6_mac_phy_rxelecidle_disable), 
    .hif_pcie6_mac_phy_txcommonmode_disable(nss_hif_pcie6_mac_phy_txcommonmode_disable), 
    .hif_pcie6_mac_phy_rate(nss_hif_pcie6_mac_phy_rate), 
    .hif_pcie6_mac_phy_width(nss_hif_pcie6_mac_phy_width), 
    .hif_pcie6_mac_phy_pclk_rate(nss_hif_pcie6_mac_phy_pclk_rate), 
    .hif_pcie6_mac_phy_rxstandby(nss_hif_pcie6_mac_phy_rxstandby), 
    .hif_pcie6_mac_phy_messagebus(nss_hif_pcie6_mac_phy_messagebus), 
    .hif_pcie6_mac_phy_serdes_arch(nss_hif_pcie6_mac_phy_serdes_arch), 
    .hif_pcie6_serdes_pipe_rxready(nss_hif_pcie6_serdes_pipe_rxready), 
    .hif_pcie6_mac_phy_commonclock_enable(nss_hif_pcie6_mac_phy_commonclock_enable), 
    .hif_pcie6_mac_phy_asyncpowerchangeack(nss_hif_pcie6_mac_phy_asyncpowerchangeack), 
    .hif_pcie6_mac_phy_sris_enable(nss_hif_pcie6_mac_phy_sris_enable), 
    .hif_pcie6_mac_phy_pclkchangeack(nss_hif_pcie6_mac_phy_pclkchangeack), 
    .hif_pcie6_phy_mac_pclkchangeok(hif_pcie_gen6_phy_18a_hif_pcie6_phy_mac_pclkchangeok), 
    .phy_pcie6_max_pclk(hif_pcie_gen6_phy_18a_phy_pcie6_max_pclk), 
    .hif_pcie6_phy_mac_rxdata(hif_pcie_gen6_phy_18a_hif_pcie6_phy_mac_rxdata), 
    .phy_pcie6_pipe_rx_clk(hif_pcie_gen6_phy_18a_phy_pcie6_pipe_rx_clk), 
    .hif_pcie6_phy_mac_rxstandbystatus(hif_pcie_gen6_phy_18a_hif_pcie6_phy_mac_rxstandbystatus), 
    .hif_pcie6_phy_mac_rxvalid(hif_pcie_gen6_phy_18a_hif_pcie6_phy_mac_rxvalid), 
    .hif_pcie6_phy_mac_phystatus(hif_pcie_gen6_phy_18a_hif_pcie6_phy_mac_phystatus), 
    .hif_pcie6_phy_mac_rxelecidle(hif_pcie_gen6_phy_18a_hif_pcie6_phy_mac_rxelecidle), 
    .hif_pcie6_phy_mac_rxstatus(hif_pcie_gen6_phy_18a_hif_pcie6_phy_mac_rxstatus), 
    .hif_pcie6_phy_mac_messagebus(hif_pcie_gen6_phy_18a_hif_pcie6_phy_mac_messagebus), 
    .nsc_ssn_bus_clock_in(ssn_bus_clock_in), 
    .nsc_ssn_bus_data_in(par_nac_misc_pipe_2_nss_out_bus_data_out), 
    .nsc_ssn_bus_data_out(par_nac_misc_mux_2__nss_in_start_bus_data_in), 
    .nsc_tms(tms), 
    .nsc_tck(tck), 
    .nsc_tdi(tdi), 
    .nsc_trst_b(trst_b), 
    .nsc_shift_ir_dr(shift_ir_dr), 
    .nsc_tms_park_value(tms_park_value), 
    .nsc_nw_mode(nw_mode), 
    .nsc_ijtag_nw_capture(ijtag_capture), 
    .nsc_ijtag_nw_shift(ijtag_shift), 
    .nsc_ijtag_nw_update(ijtag_update), 
    .nsc_tdo(NW_OUT_nss_from_tdo), 
    .nsc_ijtag_nw_reset_b(par_nac_misc_NW_OUT_nss_ijtag_to_reset), 
    .nsc_ijtag_nw_select(par_nac_misc_NW_OUT_nss_ijtag_to_sel), 
    .nsc_ijtag_nw_si(par_nac_misc_NW_OUT_nss_ijtag_to_si), 
    .nsc_ijtag_nw_so(nss_nsc_ijtag_nw_so), 
    .nsc_tap_sel_in(nss_nsc_tap_sel_in), 
    .imc_t_nsc_cfio0_paddr(cfio_paddr), 
    .imc_t_nsc_cfio0_penable(cfio_penable), 
    .imc_t_nsc_cfio0_pwrite(cfio_pwrite), 
    .imc_t_nsc_cfio0_pwdata(cfio_pwdata), 
    .imc_t_nsc_cfio0_pprot(cfio_pprot), 
    .imc_t_nsc_cfio0_pstrb(cfio_pstrb), 
    .imc_t_nsc_cfio0_psel_0(cfio_psel), 
    .imc_t_nsc_cfio0_prdata_0(cfio_prdata), 
    .imc_t_nsc_cfio0_pready_0(cfio_pready), 
    .imc_t_nsc_cfio0_pslverr_0(cfio_pslverr), 
    .i_nmf_t_cnic_physs_gpio_paddr(i_nmf_t_cnic_physs_gpio_paddr), 
    .i_nmf_t_cnic_physs_gpio_penable(i_nmf_t_cnic_physs_gpio_penable), 
    .i_nmf_t_cnic_physs_gpio_pwrite(i_nmf_t_cnic_physs_gpio_pwrite), 
    .i_nmf_t_cnic_physs_gpio_pwdata(i_nmf_t_cnic_physs_gpio_pwdata), 
    .i_nmf_t_cnic_physs_gpio_pprot(i_nmf_t_cnic_physs_gpio_pprot), 
    .i_nmf_t_cnic_physs_gpio_pstrb(i_nmf_t_cnic_physs_gpio_pstrb), 
    .i_nmf_t_cnic_physs_gpio_psel_0(i_nmf_t_cnic_physs_gpio_psel_0), 
    .i_nmf_t_cnic_physs_gpio_prdata_0(i_nmf_t_cnic_physs_gpio_prdata_0), 
    .i_nmf_t_cnic_physs_gpio_pready_0(i_nmf_t_cnic_physs_gpio_pready_0), 
    .i_nmf_t_cnic_physs_gpio_pslverr_0(i_nmf_t_cnic_physs_gpio_pslverr_0), 
    .spi_clk(XX_SPI_CLK), 
    .spi_oe_n(XX_SPI_OE_N), 
    .spi_txd(XX_SPI_TXD), 
    .spi_rxd(XX_SPI_RXD), 
    .spi_cs_n({XX_SPI_CS1_N,XX_SPI_CS0_N}), 
    .i2c_clk_in({XX_I2C_SCL7,XX_I2C_SCL6,XX_I2C_SCL5,XX_I2C_SCL4,XX_I2C_SCL2,FNIC_SVID_CLK,XX_I2C_SCL1,XX_I2C_SCL0}), 
    .i2c_clk_oe_n(nss_i2c_clk_oe_n), 
    .i2c_data_in({XX_I2C_SDA7,XX_I2C_SDA6,XX_I2C_SDA5,XX_I2C_SDA4,XX_I2C_SDA2,FNIC_SVID_DATA,XX_I2C_SDA1,XX_I2C_SDA0}), 
    .i2c_data_oe_n(nss_i2c_data_oe_n), 
    .i2c_smbalert_oe_n({hidft_open_0,svidalert,hidft_open_1}), 
    .nss_ready_for_host_enum(nsc_ready_for_enum), 
    .t_usb_phy_c_paddr({hidft_open_2,nss_t_usb_phy_c_paddr,hidft_open_3}), 
    .t_usb_phy_c_penable(nss_t_usb_phy_c_penable), 
    .t_usb_phy_c_prdata({16'b0,dwc_eusb2_phy_1p_ns_apb_rdata}), 
    .t_usb_phy_c_pready(dwc_eusb2_phy_1p_ns_apb_rdy), 
    .eusb2_phy_presetn(nss_eusb2_phy_presetn), 
    .t_usb_phy_c_psel(nss_t_usb_phy_c_psel), 
    .t_usb_phy_c_pslverr(dwc_eusb2_phy_1p_ns_apb_slverr), 
    .t_usb_phy_c_pwdata({hidft_open_4,nss_t_usb_phy_c_pwdata}), 
    .t_usb_phy_c_pwrite(nss_t_usb_phy_c_pwrite), 
    .eusb2_phy_reset(nss_eusb2_phy_reset), 
    .utmi_hostdisconnect(dwc_eusb2_phy_1p_ns_utmi_hostdisconnect), 
    .utmi_linestate(dwc_eusb2_phy_1p_ns_utmi_linestate), 
    .utmi_opmode(nss_utmi_opmode), 
    .utmi_port_reset(nss_utmi_port_reset), 
    .utmi_rx_data(dwc_eusb2_phy_1p_ns_utmi_rx_data), 
    .utmi_rxactive(dwc_eusb2_phy_1p_ns_utmi_rxactive), 
    .utmi_rxerror(dwc_eusb2_phy_1p_ns_utmi_rxerror), 
    .utmi_rxvalid(dwc_eusb2_phy_1p_ns_utmi_rxvalid), 
    .utmi_termselect(nss_utmi_termselect), 
    .utmi_tx_data(nss_utmi_tx_data), 
    .utmi_txready(dwc_eusb2_phy_1p_ns_utmi_txready), 
    .utmi_txvalid(nss_utmi_txvalid), 
    .utmi_xcvrselect(nss_utmi_xcvrselect), 
    .phy_cfg_jtag_apb_sel(nss_phy_cfg_jtag_apb_sel), 
    .phy_cfg_cr_clk_sel(nss_phy_cfg_cr_clk_sel), 
    .phy_enable(nss_phy_enable), 
    .utmi_suspend_n(nss_utmi_suspend_n), 
    .utmi_clk(utmi_clk_rdop_par_eusb_phy_clkout), 
    .pad_strap_in({BID,SPARE_B3,SPARE_B2,4'b0,nac_a0_debug_strap_0,1'b0,SPARE_B1,BOOT_MODE_STRAP,1'b1}), 
    .boot_mode(BOOT_MODE_STRAP), 
    .i_nmf_t_cnic_gpsb_br_AWREADY(axi2sb_gpsb_s_awready), 
    .i_nmf_t_cnic_gpsb_br_AWADDR(nss_i_nmf_t_cnic_gpsb_br_AWADDR), 
    .i_nmf_t_cnic_gpsb_br_AWBURST(nss_i_nmf_t_cnic_gpsb_br_AWBURST), 
    .i_nmf_t_cnic_gpsb_br_AWID(nss_i_nmf_t_cnic_gpsb_br_AWID), 
    .i_nmf_t_cnic_gpsb_br_AWLEN(nss_i_nmf_t_cnic_gpsb_br_AWLEN), 
    .i_nmf_t_cnic_gpsb_br_AWPROT(nss_i_nmf_t_cnic_gpsb_br_AWPROT), 
    .i_nmf_t_cnic_gpsb_br_AWSIZE(nss_i_nmf_t_cnic_gpsb_br_AWSIZE), 
    .i_nmf_t_cnic_gpsb_br_AWVALID(nss_i_nmf_t_cnic_gpsb_br_AWVALID), 
    .i_nmf_t_cnic_gpsb_br_WREADY(axi2sb_gpsb_s_wready), 
    .i_nmf_t_cnic_gpsb_br_WDATA(nss_i_nmf_t_cnic_gpsb_br_WDATA), 
    .i_nmf_t_cnic_gpsb_br_WLAST(nss_i_nmf_t_cnic_gpsb_br_WLAST), 
    .i_nmf_t_cnic_gpsb_br_WSTRB(nss_i_nmf_t_cnic_gpsb_br_WSTRB), 
    .i_nmf_t_cnic_gpsb_br_WVALID(nss_i_nmf_t_cnic_gpsb_br_WVALID), 
    .i_nmf_t_cnic_gpsb_br_BID(axi2sb_gpsb_s_bid), 
    .i_nmf_t_cnic_gpsb_br_BRESP(axi2sb_gpsb_s_bresp), 
    .i_nmf_t_cnic_gpsb_br_BVALID(axi2sb_gpsb_s_bvalid), 
    .i_nmf_t_cnic_gpsb_br_BREADY(nss_i_nmf_t_cnic_gpsb_br_BREADY), 
    .i_nmf_t_cnic_gpsb_br_ARREADY(axi2sb_gpsb_s_arready), 
    .i_nmf_t_cnic_gpsb_br_ARADDR(nss_i_nmf_t_cnic_gpsb_br_ARADDR), 
    .i_nmf_t_cnic_gpsb_br_ARBURST(nss_i_nmf_t_cnic_gpsb_br_ARBURST), 
    .i_nmf_t_cnic_gpsb_br_ARID(nss_i_nmf_t_cnic_gpsb_br_ARID), 
    .i_nmf_t_cnic_gpsb_br_ARLEN(nss_i_nmf_t_cnic_gpsb_br_ARLEN), 
    .i_nmf_t_cnic_gpsb_br_ARPROT(nss_i_nmf_t_cnic_gpsb_br_ARPROT), 
    .i_nmf_t_cnic_gpsb_br_ARSIZE(nss_i_nmf_t_cnic_gpsb_br_ARSIZE), 
    .i_nmf_t_cnic_gpsb_br_ARVALID(nss_i_nmf_t_cnic_gpsb_br_ARVALID), 
    .i_nmf_t_cnic_gpsb_br_RID(axi2sb_gpsb_s_rid), 
    .i_nmf_t_cnic_gpsb_br_RDATA(axi2sb_gpsb_s_rdata), 
    .i_nmf_t_cnic_gpsb_br_RRESP(axi2sb_gpsb_s_rresp), 
    .i_nmf_t_cnic_gpsb_br_RLAST(axi2sb_gpsb_s_rlast), 
    .i_nmf_t_cnic_gpsb_br_RVALID(axi2sb_gpsb_s_rvalid), 
    .i_nmf_t_cnic_gpsb_br_RREADY(nss_i_nmf_t_cnic_gpsb_br_RREADY), 
    .t_nmf_i_cnic_gpsb_AWID(axi2sb_gpsb_m_awid), 
    .t_nmf_i_cnic_gpsb_AWADDR(axi2sb_gpsb_m_awaddr), 
    .t_nmf_i_cnic_gpsb_AWLEN(axi2sb_gpsb_m_awlen), 
    .t_nmf_i_cnic_gpsb_AWUSER(axi2sb_gpsb_m_awuser), 
    .t_nmf_i_cnic_gpsb_AWSIZE(axi2sb_gpsb_m_awsize), 
    .t_nmf_i_cnic_gpsb_AWBURST(axi2sb_gpsb_m_awburst), 
    .t_nmf_i_cnic_gpsb_AWPROT(axi2sb_gpsb_m_awprot), 
    .t_nmf_i_cnic_gpsb_AWVALID(axi2sb_gpsb_m_awvalid), 
    .t_nmf_i_cnic_gpsb_AWREADY(nss_t_nmf_i_cnic_gpsb_AWREADY), 
    .t_nmf_i_cnic_gpsb_WDATA(axi2sb_gpsb_m_wdata), 
    .t_nmf_i_cnic_gpsb_WSTRB(axi2sb_gpsb_m_wstrb), 
    .t_nmf_i_cnic_gpsb_WLAST(axi2sb_gpsb_m_wlast), 
    .t_nmf_i_cnic_gpsb_WVALID(axi2sb_gpsb_m_wvalid), 
    .t_nmf_i_cnic_gpsb_WREADY(nss_t_nmf_i_cnic_gpsb_WREADY), 
    .t_nmf_i_cnic_gpsb_BREADY(axi2sb_gpsb_m_bready), 
    .t_nmf_i_cnic_gpsb_BID(nss_t_nmf_i_cnic_gpsb_BID), 
    .t_nmf_i_cnic_gpsb_BRESP(nss_t_nmf_i_cnic_gpsb_BRESP), 
    .t_nmf_i_cnic_gpsb_BVALID(nss_t_nmf_i_cnic_gpsb_BVALID), 
    .t_nmf_i_cnic_gpsb_ARID(axi2sb_gpsb_m_arid), 
    .t_nmf_i_cnic_gpsb_ARADDR(axi2sb_gpsb_m_araddr), 
    .t_nmf_i_cnic_gpsb_ARLEN(axi2sb_gpsb_m_arlen), 
    .t_nmf_i_cnic_gpsb_ARUSER(axi2sb_gpsb_m_aruser), 
    .t_nmf_i_cnic_gpsb_ARSIZE(axi2sb_gpsb_m_arsize), 
    .t_nmf_i_cnic_gpsb_ARBURST(axi2sb_gpsb_m_arburst), 
    .t_nmf_i_cnic_gpsb_ARPROT(axi2sb_gpsb_m_arprot), 
    .t_nmf_i_cnic_gpsb_ARVALID(axi2sb_gpsb_m_arvalid), 
    .t_nmf_i_cnic_gpsb_ARREADY(nss_t_nmf_i_cnic_gpsb_ARREADY), 
    .t_nmf_i_cnic_gpsb_RREADY(axi2sb_gpsb_m_rready), 
    .t_nmf_i_cnic_gpsb_RDATA(nss_t_nmf_i_cnic_gpsb_RDATA), 
    .t_nmf_i_cnic_gpsb_RID(nss_t_nmf_i_cnic_gpsb_RID), 
    .t_nmf_i_cnic_gpsb_RLAST(nss_t_nmf_i_cnic_gpsb_RLAST), 
    .t_nmf_i_cnic_gpsb_RRESP(nss_t_nmf_i_cnic_gpsb_RRESP), 
    .t_nmf_i_cnic_gpsb_RVALID(nss_t_nmf_i_cnic_gpsb_RVALID), 
    .reset_fabric_n(nss_reset_fabric_n), 
    .nsc_soc_imcr_qreqn(nss_nsc_soc_imcr_qreqn), 
    .i_nmf_t_cnic_pmsb_br_AWREADY(axi2sb_pmsb_s_awready), 
    .i_nmf_t_cnic_pmsb_br_AWADDR(nss_i_nmf_t_cnic_pmsb_br_AWADDR), 
    .i_nmf_t_cnic_pmsb_br_AWBURST(nss_i_nmf_t_cnic_pmsb_br_AWBURST), 
    .i_nmf_t_cnic_pmsb_br_AWID(nss_i_nmf_t_cnic_pmsb_br_AWID), 
    .i_nmf_t_cnic_pmsb_br_AWLEN(nss_i_nmf_t_cnic_pmsb_br_AWLEN), 
    .i_nmf_t_cnic_pmsb_br_AWPROT(nss_i_nmf_t_cnic_pmsb_br_AWPROT), 
    .i_nmf_t_cnic_pmsb_br_AWSIZE(nss_i_nmf_t_cnic_pmsb_br_AWSIZE), 
    .i_nmf_t_cnic_pmsb_br_AWVALID(nss_i_nmf_t_cnic_pmsb_br_AWVALID), 
    .i_nmf_t_cnic_pmsb_br_WREADY(axi2sb_pmsb_s_wready), 
    .i_nmf_t_cnic_pmsb_br_WDATA(nss_i_nmf_t_cnic_pmsb_br_WDATA), 
    .i_nmf_t_cnic_pmsb_br_WLAST(nss_i_nmf_t_cnic_pmsb_br_WLAST), 
    .i_nmf_t_cnic_pmsb_br_WSTRB(nss_i_nmf_t_cnic_pmsb_br_WSTRB), 
    .i_nmf_t_cnic_pmsb_br_WVALID(nss_i_nmf_t_cnic_pmsb_br_WVALID), 
    .i_nmf_t_cnic_pmsb_br_BID(axi2sb_pmsb_s_bid), 
    .i_nmf_t_cnic_pmsb_br_BRESP(axi2sb_pmsb_s_bresp), 
    .i_nmf_t_cnic_pmsb_br_BVALID(axi2sb_pmsb_s_bvalid), 
    .i_nmf_t_cnic_pmsb_br_BREADY(nss_i_nmf_t_cnic_pmsb_br_BREADY), 
    .i_nmf_t_cnic_pmsb_br_ARREADY(axi2sb_pmsb_s_arready), 
    .i_nmf_t_cnic_pmsb_br_ARADDR(nss_i_nmf_t_cnic_pmsb_br_ARADDR), 
    .i_nmf_t_cnic_pmsb_br_ARBURST(nss_i_nmf_t_cnic_pmsb_br_ARBURST), 
    .i_nmf_t_cnic_pmsb_br_ARID(nss_i_nmf_t_cnic_pmsb_br_ARID), 
    .i_nmf_t_cnic_pmsb_br_ARLEN(nss_i_nmf_t_cnic_pmsb_br_ARLEN), 
    .i_nmf_t_cnic_pmsb_br_ARPROT(nss_i_nmf_t_cnic_pmsb_br_ARPROT), 
    .i_nmf_t_cnic_pmsb_br_ARSIZE(nss_i_nmf_t_cnic_pmsb_br_ARSIZE), 
    .i_nmf_t_cnic_pmsb_br_ARVALID(nss_i_nmf_t_cnic_pmsb_br_ARVALID), 
    .i_nmf_t_cnic_pmsb_br_RID(axi2sb_pmsb_s_rid), 
    .i_nmf_t_cnic_pmsb_br_RDATA(axi2sb_pmsb_s_rdata), 
    .i_nmf_t_cnic_pmsb_br_RRESP(axi2sb_pmsb_s_rresp), 
    .i_nmf_t_cnic_pmsb_br_RLAST(axi2sb_pmsb_s_rlast), 
    .i_nmf_t_cnic_pmsb_br_RVALID(axi2sb_pmsb_s_rvalid), 
    .i_nmf_t_cnic_pmsb_br_RREADY(nss_i_nmf_t_cnic_pmsb_br_RREADY), 
    .t_nmf_i_cnic_pmsb_AWID(axi2sb_pmsb_m_awid), 
    .t_nmf_i_cnic_pmsb_AWADDR(axi2sb_pmsb_m_awaddr), 
    .t_nmf_i_cnic_pmsb_AWLEN(axi2sb_pmsb_m_awlen), 
    .t_nmf_i_cnic_pmsb_AWUSER(axi2sb_pmsb_m_awuser), 
    .t_nmf_i_cnic_pmsb_AWSIZE(axi2sb_pmsb_m_awsize), 
    .t_nmf_i_cnic_pmsb_AWBURST(axi2sb_pmsb_m_awburst), 
    .t_nmf_i_cnic_pmsb_AWPROT(axi2sb_pmsb_m_awprot), 
    .t_nmf_i_cnic_pmsb_AWVALID(axi2sb_pmsb_m_awvalid), 
    .t_nmf_i_cnic_pmsb_AWREADY(nss_t_nmf_i_cnic_pmsb_AWREADY), 
    .t_nmf_i_cnic_pmsb_WDATA(axi2sb_pmsb_m_wdata), 
    .t_nmf_i_cnic_pmsb_WSTRB(axi2sb_pmsb_m_wstrb), 
    .t_nmf_i_cnic_pmsb_WLAST(axi2sb_pmsb_m_wlast), 
    .t_nmf_i_cnic_pmsb_WVALID(axi2sb_pmsb_m_wvalid), 
    .t_nmf_i_cnic_pmsb_WREADY(nss_t_nmf_i_cnic_pmsb_WREADY), 
    .t_nmf_i_cnic_pmsb_BREADY(axi2sb_pmsb_m_bready), 
    .t_nmf_i_cnic_pmsb_BID(nss_t_nmf_i_cnic_pmsb_BID), 
    .t_nmf_i_cnic_pmsb_BRESP(nss_t_nmf_i_cnic_pmsb_BRESP), 
    .t_nmf_i_cnic_pmsb_BVALID(nss_t_nmf_i_cnic_pmsb_BVALID), 
    .t_nmf_i_cnic_pmsb_ARID(axi2sb_pmsb_m_arid), 
    .t_nmf_i_cnic_pmsb_ARADDR(axi2sb_pmsb_m_araddr), 
    .t_nmf_i_cnic_pmsb_ARLEN(axi2sb_pmsb_m_arlen), 
    .t_nmf_i_cnic_pmsb_ARUSER(axi2sb_pmsb_m_aruser), 
    .t_nmf_i_cnic_pmsb_ARSIZE(axi2sb_pmsb_m_arsize), 
    .t_nmf_i_cnic_pmsb_ARBURST(axi2sb_pmsb_m_arburst), 
    .t_nmf_i_cnic_pmsb_ARPROT(axi2sb_pmsb_m_arprot), 
    .t_nmf_i_cnic_pmsb_ARVALID(axi2sb_pmsb_m_arvalid), 
    .t_nmf_i_cnic_pmsb_ARREADY(nss_t_nmf_i_cnic_pmsb_ARREADY), 
    .t_nmf_i_cnic_pmsb_RREADY(axi2sb_pmsb_m_rready), 
    .t_nmf_i_cnic_pmsb_RDATA(nss_t_nmf_i_cnic_pmsb_RDATA), 
    .t_nmf_i_cnic_pmsb_RID(nss_t_nmf_i_cnic_pmsb_RID), 
    .t_nmf_i_cnic_pmsb_RLAST(nss_t_nmf_i_cnic_pmsb_RLAST), 
    .t_nmf_i_cnic_pmsb_RRESP(nss_t_nmf_i_cnic_pmsb_RRESP), 
    .t_nmf_i_cnic_pmsb_RVALID(nss_t_nmf_i_cnic_pmsb_RVALID), 
    .aonclk1x(divmux_rdop_aonclk1x_clkout), 
    .aonclk5x(divmux_rdop_aonclk5x_clkout), 
    .s3m_cnt_clk(par_nac_misc_par_nac_misc_adop_xtalclk_clkout), 
    .ecm_clk(par_nac_misc_div2_ecm_clk_clkout), 
    .nss_sn2sfi_clk(par_sn2sfi_sfi_clk_1g_in_out), 
    .ssn_clk(infra_clk), 
    .imc_sys_clk(boot_450_rdop_fout1_clkout), 
    .imc_core_clk(boot_900_rdop_fout0_clkout), 
    .soc_per_clk(par_nac_misc_boot_112p5_rdop_fout2_clkout), 
    .eusb2_phy_pclk(nss_eusb2_phy_pclk), 
    .soc_tsgen_clk(boot_250_rdop_fout3_clkout), 
    .nss_lan_clk(boot_750_rdop_fout4_clkout), 
    .nss_psm_clk(boot_529p41_rdop_fout6_clkout), 
    .i_nmf_t_clk_boot_prdata_0(pll_top_boot_prdata), 
    .i_nmf_t_clk_boot_pready_0(pll_top_boot_pready), 
    .i_nmf_t_clk_boot_pslverr_0(pll_top_boot_pslverr), 
    .i_nmf_t_clk_boot_paddr(nss_i_nmf_t_clk_boot_paddr), 
    .i_nmf_t_clk_boot_penable(nss_i_nmf_t_clk_boot_penable), 
    .i_nmf_t_clk_boot_pwrite(nss_i_nmf_t_clk_boot_pwrite), 
    .i_nmf_t_clk_boot_pwdata(nss_i_nmf_t_clk_boot_pwdata), 
    .i_nmf_t_clk_boot_psel_0(nss_i_nmf_t_clk_boot_psel_0), 
    .physs_func_x2_clk(eth_physs_rdop_fout0_clkout), 
    .physs_intf0_clk(physs_physs_intf0_clk_out), 
    .nss_hlp_clk(eth_physs_rdop_fout2_clkout), 
    .nss_hlp_sw_clk(eth_physs_rdop_fout2_clkout), 
    .i_nmf_t_cnic_pll_hlp_prdata_0(pll_top_eth_physs_prdata), 
    .i_nmf_t_cnic_pll_hlp_pready_0(pll_top_eth_physs_pready), 
    .i_nmf_t_cnic_pll_hlp_pslverr_0(pll_top_eth_physs_pslverr), 
    .i_nmf_t_cnic_pll_hlp_paddr(nss_i_nmf_t_cnic_pll_hlp_paddr), 
    .i_nmf_t_cnic_pll_hlp_penable(nss_i_nmf_t_cnic_pll_hlp_penable), 
    .i_nmf_t_cnic_pll_hlp_pwrite(nss_i_nmf_t_cnic_pll_hlp_pwrite), 
    .i_nmf_t_cnic_pll_hlp_pwdata(nss_i_nmf_t_cnic_pll_hlp_pwdata), 
    .i_nmf_t_cnic_pll_hlp_psel_0(nss_i_nmf_t_cnic_pll_hlp_psel_0), 
    .nss_cosq_clk(eth_physs_rdop_fout5_clkout), 
    .nss_core_clk(nss_962p5_rdop_fout0_clkout), 
    .nss_dtf_clk(nss_1375_rdop_fout7_clkout), 
    .nss_hif_clk(nss_1069p44_rdop_fout5_clkout), 
    .nss_sep_clk(nss_641p67_rdop_fout6_clkout), 
    .nlf_atb_clk(nss_1069p44_rdop_fout8_clkout), 
    .soc_nlf_clk(nss_1604p17_rdop_fout1_clkout), 
    .nss_fxp_clk(nss_1604p17_rdop_fout4_clkout), 
    .i_nmf_t_clk_nss0_prdata_0(pll_top_nss_prdata), 
    .i_nmf_t_clk_nss0_pready_0(pll_top_nss_pready), 
    .i_nmf_t_clk_nss0_pslverr_0(pll_top_nss_pslverr), 
    .i_nmf_t_clk_nss0_paddr(nss_i_nmf_t_clk_nss0_paddr), 
    .i_nmf_t_clk_nss0_penable(nss_i_nmf_t_clk_nss0_penable), 
    .i_nmf_t_clk_nss0_pwrite(nss_i_nmf_t_clk_nss0_pwrite), 
    .i_nmf_t_clk_nss0_pwdata(nss_i_nmf_t_clk_nss0_pwdata), 
    .i_nmf_t_clk_nss0_psel_0(nss_i_nmf_t_clk_nss0_psel_0), 
    .mt_clk(par_nac_fabric0_ts_800_rdop_fout0_clkout_out), 
    .physs_func_clk(par_nac_fabric0_ts_800_rdop_fout0_clkout_out), 
    .mt_dist_clk(ts_100_rdop_fout1_clkout), 
    .i_nmf_t_clk_ts_prdata_0(pll_top_ts_prdata), 
    .i_nmf_t_clk_ts_pready_0(pll_top_ts_pready), 
    .i_nmf_t_clk_ts_pslverr_0(pll_top_ts_pslverr), 
    .i_nmf_t_clk_ts_paddr(nss_i_nmf_t_clk_ts_paddr), 
    .i_nmf_t_clk_ts_penable(nss_i_nmf_t_clk_ts_penable), 
    .i_nmf_t_clk_ts_pwrite(nss_i_nmf_t_clk_ts_pwrite), 
    .i_nmf_t_clk_ts_pwdata(nss_i_nmf_t_clk_ts_pwdata), 
    .i_nmf_t_clk_ts_psel_0(nss_i_nmf_t_clk_ts_psel_0), 
    .nsc_dlw_next_arb2arb_DTFA_CREDIT(dtf_rep_misc_nsc_clkarb1_rep0_dtfr_upstream_d0_credit_out), 
    .nsc_dlw_next_arb2arb_DTFA_ACTIVE(dtf_rep_misc_nsc_clkarb1_rep0_dtfr_upstream_d0_active_out), 
    .nsc_dlw_next_arb2arb_DTFA_SYNC(dtf_rep_misc_nsc_clkarb1_rep0_dtfr_upstream_d0_sync_out), 
    .nsc_dlw_next_arb2arb_DTFA_HEADER(nss_nsc_dlw_next_arb2arb_DTFA_HEADER), 
    .nsc_dlw_next_arb2arb_DTFA_DATA(nss_nsc_dlw_next_arb2arb_DTFA_DATA), 
    .nsc_dlw_next_arb2arb_DTFA_VALID(nss_nsc_dlw_next_arb2arb_DTFA_VALID), 
    .nsc_dlw_serial_download_tsc(nac_ss_debug_timestamp), 
    .reset_debug_apb_n(nss_reset_debug_apb_n), 
    .reset_debug_soc_n(nss_reset_debug_soc_n), 
    .arm_debug_en(nss_arm_debug_en), 
    .reset_debug_dap_n(nss_reset_debug_dap_n), 
    .cdbgrstreq_cdbgrst(css600_dpreceiver_nac_ss_cdbgrstreq),  
    .cdbgrstack_cdbgrst(nss_cdbgrstack_cdbgrst),  
    .cnic_apbic_pready(nss_cnic_apbic_pready), 
    .cnic_apbic_pslverr(nss_cnic_apbic_pslverr), 
    .cnic_apbic_prdata(nss_cnic_apbic_prdata), 
    .cnic_apbic_pwakeup(css600_apbic_ioexp_apbic0_nac_ss_pwakeup_r2), 
    .cnic_apbic_psel(css600_apbic_ioexp_apbic0_nac_ss_psel_r2), 
    .cnic_apbic_penable(css600_apbic_ioexp_apbic0_nac_ss_penable_r2), 
    .cnic_apbic_pwrite(css600_apbic_ioexp_apbic0_nac_ss_pwrite_r2), 
    .cnic_apbic_pprot(css600_apbic_ioexp_apbic0_nac_ss_pprot_r2), 
    .cnic_apbic_pnse(css600_apbic_ioexp_apbic0_nac_ss_pnse_r2), 
    .cnic_apbic_paddr(css600_apbic_ioexp_apbic0_nac_ss_paddr_r2), 
    .cnic_apbic_pwdata(css600_apbic_ioexp_apbic0_nac_ss_pwdata_r2), 
    .i_nmf_t_cnic_apbic_pready_0(css600_apbasyncbridgecompleter_nsc_nmf_nac_ss_pready_c), 
    .i_nmf_t_cnic_apbic_pslverr_0(css600_apbasyncbridgecompleter_nsc_nmf_nac_ss_pslverr_c), 
    .i_nmf_t_cnic_apbic_prdata_0(css600_apbasyncbridgecompleter_nsc_nmf_nac_ss_prdata_c), 
    .i_nmf_t_cnic_apbic_psel_0(nss_i_nmf_t_cnic_apbic_psel_0), 
    .i_nmf_t_cnic_apbic_penable(nss_i_nmf_t_cnic_apbic_penable), 
    .i_nmf_t_cnic_apbic_pwrite(nss_i_nmf_t_cnic_apbic_pwrite), 
    .i_nmf_t_cnic_apbic_pprot(nss_i_nmf_t_cnic_apbic_pprot), 
    .i_nmf_t_cnic_apbic_paddr({hidft_open_5,nss_i_nmf_t_cnic_apbic_paddr}), 
    .i_nmf_t_cnic_apbic_pwdata(nss_i_nmf_t_cnic_apbic_pwdata), 
    .nmc_atb_atwakeup(nss_nmc_atb_atwakeup), 
    .nmc_atb_atid(nss_nmc_atb_atid), 
    .nmc_atb_atbytes(nss_nmc_atb_atbytes), 
    .nmc_atb_atdata(nss_nmc_atb_atdata), 
    .nmc_atb_atvalid(nss_nmc_atb_atvalid), 
    .nmc_atb_afready(nss_nmc_atb_afready), 
    .nmc_atb_atready(css600_tmc_etf_nac_ss_atready_rx), 
    .nmc_atb_afvalid(css600_tmc_etf_nac_ss_afvalid_rx), 
    .nmc_atb_syncreq(css600_tmc_etf_nac_ss_syncreq_rx), 
    .nac_cti_channel_in(nss_nac_cti_channel_in), 
    .nac_cti_channel_out(css600_cti_nac_ss_channel_out), 
    .ecm_fuse_margin(nss_ecm_fuse_margin), 
    .ecm_fuse_paddr(nss_ecm_fuse_paddr), 
    .ecm_fuse_penable(nss_ecm_fuse_penable), 
    .ecm_fuse_pwrite(nss_ecm_fuse_pwrite), 
    .ecm_fuse_pwdata(nss_ecm_fuse_pwdata), 
    .ecm_fuse_psel(nss_ecm_fuse_psel), 
    .ecm_fuse_prdata(ifs_shim_ecm_shim_prdata), 
    .ecm_fuse_pready(ifs_shim_ecm_shim_pready), 
    .ecm_fuse_pslverr(ifs_shim_ecm_shim_pslverr), 
    .ecm_fuse_error(ifs_shim_ecm_fuse_attack_bus), 
    .ecm_fuse_burst_sense(nss_ecm_fuse_burst_sense), 
    .ecm_fuse_isense_tune(nss_ecm_fuse_isense_tune), 
    .ecm_fuse_opcode(nss_ecm_fuse_opcode), 
    .ecm_fuse_burst_pgm(nss_ecm_fuse_burst_pgm), 
    .ecm_fuse_cp_on_ack(ifs_shim_ecm_fuse_cp_on), 
    .intr_i2c({nss_intr_i2c_2,nss_intr_i2c_1,nss_intr_i2c_0,nss_intr_i2c,hidft_open_6,nss_intr_i2c_3,hidft_open_7}), 
    .i_nmf_t_cnic_intr_hndlr_paddr(nss_i_nmf_t_cnic_intr_hndlr_paddr), 
    .i_nmf_t_cnic_intr_hndlr_penable(nss_i_nmf_t_cnic_intr_hndlr_penable), 
    .i_nmf_t_cnic_intr_hndlr_pwrite(nss_i_nmf_t_cnic_intr_hndlr_pwrite), 
    .i_nmf_t_cnic_intr_hndlr_pwdata(nss_i_nmf_t_cnic_intr_hndlr_pwdata), 
    .i_nmf_t_cnic_intr_hndlr_pprot(nss_i_nmf_t_cnic_intr_hndlr_pprot), 
    .i_nmf_t_cnic_intr_hndlr_pstrb(nss_i_nmf_t_cnic_intr_hndlr_pstrb), 
    .i_nmf_t_cnic_intr_hndlr_psel_0(nss_i_nmf_t_cnic_intr_hndlr_psel_0), 
    .i_nmf_t_cnic_intr_hndlr_prdata_0(hic_top_wrap_prdata), 
    .i_nmf_t_cnic_intr_hndlr_pready_0(hic_top_wrap_pready), 
    .i_nmf_t_cnic_intr_hndlr_pslverr_0(hic_top_wrap_pslverr), 
    .t_nmf_i_cnic_intr_hndlr_AWID(hic_top_wrap_m_axi_awid), 
    .t_nmf_i_cnic_intr_hndlr_AWADDR(hic_top_wrap_m_axi_awaddr), 
    .t_nmf_i_cnic_intr_hndlr_AWLEN(hic_top_wrap_m_axi_awlen), 
    .t_nmf_i_cnic_intr_hndlr_AWSIZE(hic_top_wrap_m_axi_awsize), 
    .t_nmf_i_cnic_intr_hndlr_AWBURST(hic_top_wrap_m_axi_awburst), 
    .t_nmf_i_cnic_intr_hndlr_AWLOCK(hic_top_wrap_m_axi_awlock), 
    .t_nmf_i_cnic_intr_hndlr_AWCACHE(hic_top_wrap_m_axi_awcache), 
    .t_nmf_i_cnic_intr_hndlr_AWPROT(hic_top_wrap_m_axi_awprot), 
    .t_nmf_i_cnic_intr_hndlr_AWQOS(hic_top_wrap_m_axi_awqos), 
    .t_nmf_i_cnic_intr_hndlr_AWVALID(hic_top_wrap_m_axi_awvalid), 
    .t_nmf_i_cnic_intr_hndlr_AWREADY(nss_t_nmf_i_cnic_intr_hndlr_AWREADY), 
    .t_nmf_i_cnic_intr_hndlr_AWUSER(5'b0), 
    .t_nmf_i_cnic_intr_hndlr_WDATA(hic_top_wrap_m_axi_wdata), 
    .t_nmf_i_cnic_intr_hndlr_WSTRB(hic_top_wrap_m_axi_wstrb), 
    .t_nmf_i_cnic_intr_hndlr_WLAST(hic_top_wrap_m_axi_wlast), 
    .t_nmf_i_cnic_intr_hndlr_WVALID(hic_top_wrap_m_axi_wvalid), 
    .t_nmf_i_cnic_intr_hndlr_WREADY(nss_t_nmf_i_cnic_intr_hndlr_WREADY), 
    .t_nmf_i_cnic_intr_hndlr_BID(nss_t_nmf_i_cnic_intr_hndlr_BID), 
    .t_nmf_i_cnic_intr_hndlr_BRESP(nss_t_nmf_i_cnic_intr_hndlr_BRESP), 
    .t_nmf_i_cnic_intr_hndlr_BREADY(hic_top_wrap_m_axi_bready), 
    .t_nmf_i_cnic_intr_hndlr_BVALID(nss_t_nmf_i_cnic_intr_hndlr_BVALID), 
    .t_nmf_i_cnic_intr_hndlr_ARBURST(2'b0), 
    .t_nmf_i_cnic_intr_hndlr_ARPROT(3'b0), 
    .t_nmf_i_cnic_intr_hndlr_ARSIZE(3'b0), 
    .t_nmf_i_cnic_intr_hndlr_ARADDR(40'b0), 
    .t_nmf_i_cnic_intr_hndlr_ARCACHE(4'b0), 
    .t_nmf_i_cnic_intr_hndlr_ARQOS(4'b0), 
    .t_nmf_i_cnic_intr_hndlr_ARUSER(5'b0), 
    .t_nmf_i_cnic_intr_hndlr_ARLEN(8'b0), 
    .t_nmf_i_cnic_intr_hndlr_ARID(1'b0), 
    .t_nmf_i_cnic_intr_hndlr_ARLOCK(1'b0), 
    .t_nmf_i_cnic_intr_hndlr_ARVALID(1'b0), 
    .t_nmf_i_cnic_intr_hndlr_RREADY(1'b0), 
    .nsc_fdfx_security_policy(fdfx_security_policy), 
    .nsc_fdfx_pwrgood(fdfx_pwrgood_rst_b), 
    .nsc_fdfx_policy_update(fdfx_policy_update), 
    .nsc_fdfx_early_boot_debug_exit(fdfx_earlyboot_debug_exit), 
    .nsc_fdfx_debug_capabilities_enabling(fdfx_debug_capabilities_enabling), 
    .nsc_fdfx_debug_capabilities_enabling_valid(fdfx_debug_capabilities_enabling_valid), 
    .phy_pcie1_max_pclk(1'b0),  
    .hif_pcie1_phy_mac_phystatus(2'b0),  
    .hif_pcie1_phy_mac_rxdata(160'b0),  
    .hif_pcie1_phy_mac_rxelecidle(2'b0),  
    .hif_pcie1_phy_mac_rxstandbystatus(2'b0),  
    .hif_pcie1_phy_mac_rxstatus(6'b0),  
    .hif_pcie1_phy_mac_rxvalid(2'b0),  
    .phy_pcie1_pipe_rx_clk(2'b0),  
    .hif_pcie1_phy_mac_messagebus(16'b0),  
    .phy_pcie3_max_pclk(1'b0),  
    .hif_pcie3_phy_mac_phystatus(2'b0),  
    .hif_pcie3_phy_mac_rxdata(160'b0),  
    .hif_pcie3_phy_mac_rxelecidle(2'b0),  
    .hif_pcie3_phy_mac_rxstandbystatus(2'b0),  
    .hif_pcie3_phy_mac_rxstatus(6'b0),  
    .hif_pcie3_phy_mac_rxvalid(2'b0),  
    .phy_pcie3_pipe_rx_clk(2'b0),  
    .hif_pcie3_phy_mac_messagebus(16'b0),  
    .phy_pcie5_max_pclk(1'b0),  
    .hif_pcie5_phy_mac_phystatus(2'b0),  
    .hif_pcie5_phy_mac_rxdata(160'b0),  
    .hif_pcie5_phy_mac_rxelecidle(2'b0),  
    .hif_pcie5_phy_mac_rxstandbystatus(2'b0),  
    .hif_pcie5_phy_mac_rxstatus(6'b0),  
    .hif_pcie5_phy_mac_rxvalid(2'b0),  
    .phy_pcie5_pipe_rx_clk(2'b0),  
    .hif_pcie5_phy_mac_messagebus(16'b0),  
    .phy_pcie7_max_pclk(1'b0),  
    .hif_pcie7_phy_mac_phystatus(2'b0),  
    .hif_pcie7_phy_mac_rxdata(160'b0),  
    .hif_pcie7_phy_mac_rxelecidle(2'b0),  
    .hif_pcie7_phy_mac_rxstandbystatus(2'b0),  
    .hif_pcie7_phy_mac_rxstatus(6'b0),  
    .hif_pcie7_phy_mac_rxvalid(2'b0),  
    .phy_pcie7_pipe_rx_clk(2'b0),  
    .hif_pcie7_phy_mac_messagebus(16'b0),  
    .physs0_fatal_int(physs_physs_fatal_int_0), 
    .physs1_fatal_int(physs_physs_fatal_int_1), 
    .physs0_imc_int(physs_physs_imc_int_0), 
    .physs1_imc_int(physs_physs_imc_int_1), 
    .imc_spi({379'b0,hlp_hlp_fatal_intr,axi2sb_pmsb_irq,axi2sb_gpsb_irq,hic_top_wrap_axi_irq_out,clkss_eth_physs_fusa_pll_err_eth_physs}), 
    .hlp_imc_int(hlp_hlp_nonfatal_intr), 
    .boot_pll_lock_int(clkss_boot_fusa_pll_err_boot_0), 
    .ts_pll_lock_int(clkss_ts_fusa_pll_err_ts_0), 
    .nss_pll_lock_int(clkss_nss_fusa_pll_err_nss_0), 
    .nss_hif_clk_en_par_noc_3(1'b1), 
    .nss_core_clk_en_par_noc_3(1'b1), 
    .nss_hif_clk_en_par_noc_5(1'b1), 
    .nss_core_clk_en_par_noc_5(1'b1), 
    .nss_core_clk_en_par_noc_8(1'b1), 
    .cnic_i_nmf_t_cnic_nsc_pfb_pready_0(nac_otp_pready), 
    .cnic_i_nmf_t_cnic_nsc_pfb_pslverr_0(nac_otp_pslverr), 
    .cnic_i_nmf_t_cnic_nsc_pfb_prdata_0(nac_otp_prdata), 
    .cnic_i_nmf_t_cnic_nsc_pfb_pwrite(nss_cnic_i_nmf_t_cnic_nsc_pfb_pwrite), 
    .cnic_i_nmf_t_cnic_nsc_pfb_pwdata(nss_cnic_i_nmf_t_cnic_nsc_pfb_pwdata), 
    .cnic_i_nmf_t_cnic_nsc_pfb_psel_0(nss_cnic_i_nmf_t_cnic_nsc_pfb_psel_0), 
    .cnic_i_nmf_t_cnic_nsc_pfb_penable(nss_cnic_i_nmf_t_cnic_nsc_pfb_penable), 
    .cnic_i_nmf_t_cnic_nsc_pfb_paddr({hidft_open_8,nss_cnic_i_nmf_t_cnic_nsc_pfb_paddr}), 
    .nss_wol_pins(nss_nss_wol_pins), 
    .s3m_time(s3m_time), 
    .uart_hmp_txd(XX_UART_HMP_TXD), 
    .uart_hmp_rxd(XX_UART_HMP_RXD), 
    .uart_hif_txd(XX_UART_HIF_TXD), 
    .uart_hif_rxd(XX_UART_HIF_RXD), 
    .uart_usb_txd(XX_UART_USB_TXD), 
    .uart_usb_rxd(XX_UART_USB_RXD), 
    .cnic_early_boot_reset_n(early_boot_rst_b), 
    .i_nmf_t_cnic_hlp_ARREADY(hlp_arready_s), 
    .i_nmf_t_cnic_hlp_AWREADY(hlp_awready_s), 
    .i_nmf_t_cnic_hlp_BID(hlp_bid_s), 
    .i_nmf_t_cnic_hlp_BRESP(hlp_bresp_s), 
    .i_nmf_t_cnic_hlp_BVALID(hlp_bvalid_s), 
    .i_nmf_t_cnic_hlp_RDATA(hlp_rdata_s), 
    .i_nmf_t_cnic_hlp_RID(hlp_rid_s), 
    .i_nmf_t_cnic_hlp_RLAST(hlp_rlast_s), 
    .i_nmf_t_cnic_hlp_RRESP(hlp_rresp_s), 
    .i_nmf_t_cnic_hlp_RVALID(hlp_rvalid_s), 
    .i_nmf_t_cnic_hlp_WREADY(hlp_wready_s), 
    .cnic_sys_rst_n(nac_post_nac_sys_rst_n_out), 
    .i_nmf_t_cnic_hlp_ARADDR(nss_i_nmf_t_cnic_hlp_ARADDR), 
    .i_nmf_t_cnic_hlp_ARBURST(nss_i_nmf_t_cnic_hlp_ARBURST), 
    .i_nmf_t_cnic_hlp_ARID(nss_i_nmf_t_cnic_hlp_ARID), 
    .i_nmf_t_cnic_hlp_ARLEN(nss_i_nmf_t_cnic_hlp_ARLEN), 
    .i_nmf_t_cnic_hlp_ARSIZE(nss_i_nmf_t_cnic_hlp_ARSIZE), 
    .i_nmf_t_cnic_hlp_ARVALID(nss_i_nmf_t_cnic_hlp_ARVALID), 
    .i_nmf_t_cnic_hlp_AWADDR(nss_i_nmf_t_cnic_hlp_AWADDR), 
    .i_nmf_t_cnic_hlp_AWBURST(nss_i_nmf_t_cnic_hlp_AWBURST), 
    .i_nmf_t_cnic_hlp_AWID(nss_i_nmf_t_cnic_hlp_AWID), 
    .i_nmf_t_cnic_hlp_AWLEN(nss_i_nmf_t_cnic_hlp_AWLEN), 
    .i_nmf_t_cnic_hlp_AWSIZE(nss_i_nmf_t_cnic_hlp_AWSIZE), 
    .i_nmf_t_cnic_hlp_AWVALID(nss_i_nmf_t_cnic_hlp_AWVALID), 
    .i_nmf_t_cnic_hlp_BREADY(nss_i_nmf_t_cnic_hlp_BREADY), 
    .i_nmf_t_cnic_hlp_RREADY(nss_i_nmf_t_cnic_hlp_RREADY), 
    .i_nmf_t_cnic_hlp_WDATA(nss_i_nmf_t_cnic_hlp_WDATA), 
    .i_nmf_t_cnic_hlp_WLAST(nss_i_nmf_t_cnic_hlp_WLAST), 
    .i_nmf_t_cnic_hlp_WSTRB(nss_i_nmf_t_cnic_hlp_WSTRB), 
    .i_nmf_t_cnic_hlp_WVALID(nss_i_nmf_t_cnic_hlp_WVALID), 
    .physs_t_cnic_noc_physs0_emb_ARADDR(nss_physs_t_cnic_noc_physs0_emb_ARADDR), 
    .physs_t_cnic_noc_physs0_emb_ARBURST(nss_physs_t_cnic_noc_physs0_emb_ARBURST), 
    .physs_t_cnic_noc_physs0_emb_ARCACHE(nss_physs_t_cnic_noc_physs0_emb_ARCACHE), 
    .physs_t_cnic_noc_physs0_emb_ARID(nss_physs_t_cnic_noc_physs0_emb_ARID), 
    .physs_t_cnic_noc_physs0_emb_ARLEN(nss_physs_t_cnic_noc_physs0_emb_ARLEN), 
    .physs_t_cnic_noc_physs0_emb_ARLOCK(nss_physs_t_cnic_noc_physs0_emb_ARLOCK), 
    .physs_t_cnic_noc_physs0_emb_ARPROT(nss_physs_t_cnic_noc_physs0_emb_ARPROT), 
    .physs_t_cnic_noc_physs0_emb_ARSIZE(nss_physs_t_cnic_noc_physs0_emb_ARSIZE), 
    .physs_t_cnic_noc_physs0_emb_ARVALID(nss_physs_t_cnic_noc_physs0_emb_ARVALID), 
    .physs_t_cnic_noc_physs0_emb_AWADDR(nss_physs_t_cnic_noc_physs0_emb_AWADDR), 
    .physs_t_cnic_noc_physs0_emb_AWBURST(nss_physs_t_cnic_noc_physs0_emb_AWBURST), 
    .physs_t_cnic_noc_physs0_emb_AWCACHE(nss_physs_t_cnic_noc_physs0_emb_AWCACHE), 
    .physs_t_cnic_noc_physs0_emb_AWID(nss_physs_t_cnic_noc_physs0_emb_AWID), 
    .physs_t_cnic_noc_physs0_emb_AWLEN(nss_physs_t_cnic_noc_physs0_emb_AWLEN), 
    .physs_t_cnic_noc_physs0_emb_AWLOCK(nss_physs_t_cnic_noc_physs0_emb_AWLOCK), 
    .physs_t_cnic_noc_physs0_emb_AWPROT(nss_physs_t_cnic_noc_physs0_emb_AWPROT), 
    .physs_t_cnic_noc_physs0_emb_AWSIZE(nss_physs_t_cnic_noc_physs0_emb_AWSIZE), 
    .physs_t_cnic_noc_physs0_emb_AWVALID(nss_physs_t_cnic_noc_physs0_emb_AWVALID), 
    .physs_t_cnic_noc_physs0_emb_BREADY(nss_physs_t_cnic_noc_physs0_emb_BREADY), 
    .physs_t_cnic_noc_physs0_emb_RREADY(nss_physs_t_cnic_noc_physs0_emb_RREADY), 
    .physs_t_cnic_noc_physs0_emb_WDATA(nss_physs_t_cnic_noc_physs0_emb_WDATA), 
    .physs_t_cnic_noc_physs0_emb_WLAST(nss_physs_t_cnic_noc_physs0_emb_WLAST), 
    .physs_t_cnic_noc_physs0_emb_WSTRB(nss_physs_t_cnic_noc_physs0_emb_WSTRB), 
    .physs_t_cnic_noc_physs0_emb_WVALID(nss_physs_t_cnic_noc_physs0_emb_WVALID), 
    .physs_t_cnic_noc_physs1_emb_ARADDR(nss_physs_t_cnic_noc_physs1_emb_ARADDR), 
    .physs_t_cnic_noc_physs1_emb_ARBURST(nss_physs_t_cnic_noc_physs1_emb_ARBURST), 
    .physs_t_cnic_noc_physs1_emb_ARCACHE(nss_physs_t_cnic_noc_physs1_emb_ARCACHE), 
    .physs_t_cnic_noc_physs1_emb_ARID(nss_physs_t_cnic_noc_physs1_emb_ARID), 
    .physs_t_cnic_noc_physs1_emb_ARLEN(nss_physs_t_cnic_noc_physs1_emb_ARLEN), 
    .physs_t_cnic_noc_physs1_emb_ARLOCK(nss_physs_t_cnic_noc_physs1_emb_ARLOCK), 
    .physs_t_cnic_noc_physs1_emb_ARPROT(nss_physs_t_cnic_noc_physs1_emb_ARPROT), 
    .physs_t_cnic_noc_physs1_emb_ARSIZE(nss_physs_t_cnic_noc_physs1_emb_ARSIZE), 
    .physs_t_cnic_noc_physs1_emb_ARVALID(nss_physs_t_cnic_noc_physs1_emb_ARVALID), 
    .physs_t_cnic_noc_physs1_emb_AWADDR(nss_physs_t_cnic_noc_physs1_emb_AWADDR), 
    .physs_t_cnic_noc_physs1_emb_AWBURST(nss_physs_t_cnic_noc_physs1_emb_AWBURST), 
    .physs_t_cnic_noc_physs1_emb_AWCACHE(nss_physs_t_cnic_noc_physs1_emb_AWCACHE), 
    .physs_t_cnic_noc_physs1_emb_AWID(nss_physs_t_cnic_noc_physs1_emb_AWID), 
    .physs_t_cnic_noc_physs1_emb_AWLEN(nss_physs_t_cnic_noc_physs1_emb_AWLEN), 
    .physs_t_cnic_noc_physs1_emb_AWLOCK(nss_physs_t_cnic_noc_physs1_emb_AWLOCK), 
    .physs_t_cnic_noc_physs1_emb_AWPROT(nss_physs_t_cnic_noc_physs1_emb_AWPROT), 
    .physs_t_cnic_noc_physs1_emb_AWSIZE(nss_physs_t_cnic_noc_physs1_emb_AWSIZE), 
    .physs_t_cnic_noc_physs1_emb_AWVALID(nss_physs_t_cnic_noc_physs1_emb_AWVALID), 
    .physs_t_cnic_noc_physs1_emb_BREADY(nss_physs_t_cnic_noc_physs1_emb_BREADY), 
    .physs_t_cnic_noc_physs1_emb_RREADY(nss_physs_t_cnic_noc_physs1_emb_RREADY), 
    .physs_t_cnic_noc_physs1_emb_WDATA(nss_physs_t_cnic_noc_physs1_emb_WDATA), 
    .physs_t_cnic_noc_physs1_emb_WLAST(nss_physs_t_cnic_noc_physs1_emb_WLAST), 
    .physs_t_cnic_noc_physs1_emb_WSTRB(nss_physs_t_cnic_noc_physs1_emb_WSTRB), 
    .physs_t_cnic_noc_physs1_emb_WVALID(nss_physs_t_cnic_noc_physs1_emb_WVALID), 
    .debug_act_n(XX_DEBUG_ACT_N), 
    .early_boot_done(ecm_boot_done), 
    .bts_hic_rst_n(nss_bts_hic_rst_n), 
    .gpio_in(nss_gpio_in), 
    .gpio_nichot_b(nss_gpio_nichot_b), 
    .gpio_oe_n(nss_gpio_oe_n), 
    .gpio_out(nss_gpio_out), 
    .hif_pcie0_PERST_n0(XX_PCIE0_PERST_N0), 
    .hif_pcie0_PERST_n1(XX_PCIE0_PERST_N1), 
    .hif_pcie0_PERST_n2(XX_PCIE0_PERST_N2), 
    .hif_pcie0_PERST_n3(XX_PCIE0_PERST_N3), 
    .hlp_reset_func_n(nss_hlp_reset_func_n), 
    .icq_physs_net_xoff(nss_icq_physs_net_xoff), 
    .mse_physs_port0_rx_rdy(nss_mse_physs_port0_rx_rdy), 
    .mse_physs_port0_ts_capture_idx(nss_mse_physs_port0_ts_capture_idx), 
    .mse_physs_port0_ts_capture_vld(nss_mse_physs_port0_ts_capture_vld), 
    .mse_physs_port0_tx_crc(nss_mse_physs_port0_tx_crc), 
    .mse_physs_port0_tx_data(nss_mse_physs_port0_tx_data), 
    .mse_physs_port0_tx_eop(nss_mse_physs_port0_tx_eop), 
    .mse_physs_port0_tx_err(nss_mse_physs_port0_tx_err), 
    .mse_physs_port0_tx_mod(nss_mse_physs_port0_tx_mod), 
    .mse_physs_port0_tx_sop(nss_mse_physs_port0_tx_sop), 
    .mse_physs_port0_tx_wren(nss_mse_physs_port0_tx_wren), 
    .mse_physs_port1_rx_rdy(nss_mse_physs_port1_rx_rdy), 
    .mse_physs_port1_ts_capture_idx(nss_mse_physs_port1_ts_capture_idx), 
    .mse_physs_port1_ts_capture_vld(nss_mse_physs_port1_ts_capture_vld), 
    .mse_physs_port1_tx_crc(nss_mse_physs_port1_tx_crc), 
    .mse_physs_port1_tx_data(nss_mse_physs_port1_tx_data), 
    .mse_physs_port1_tx_eop(nss_mse_physs_port1_tx_eop), 
    .mse_physs_port1_tx_err(nss_mse_physs_port1_tx_err), 
    .mse_physs_port1_tx_mod(nss_mse_physs_port1_tx_mod), 
    .mse_physs_port1_tx_sop(nss_mse_physs_port1_tx_sop), 
    .mse_physs_port1_tx_wren(nss_mse_physs_port1_tx_wren), 
    .mse_physs_port2_rx_rdy(nss_mse_physs_port2_rx_rdy), 
    .mse_physs_port2_ts_capture_idx(nss_mse_physs_port2_ts_capture_idx), 
    .mse_physs_port2_ts_capture_vld(nss_mse_physs_port2_ts_capture_vld), 
    .mse_physs_port2_tx_crc(nss_mse_physs_port2_tx_crc), 
    .mse_physs_port2_tx_data(nss_mse_physs_port2_tx_data), 
    .mse_physs_port2_tx_eop(nss_mse_physs_port2_tx_eop), 
    .mse_physs_port2_tx_err(nss_mse_physs_port2_tx_err), 
    .mse_physs_port2_tx_mod(nss_mse_physs_port2_tx_mod), 
    .mse_physs_port2_tx_sop(nss_mse_physs_port2_tx_sop), 
    .mse_physs_port2_tx_wren(nss_mse_physs_port2_tx_wren), 
    .mse_physs_port3_rx_rdy(nss_mse_physs_port3_rx_rdy), 
    .mse_physs_port3_ts_capture_idx(nss_mse_physs_port3_ts_capture_idx), 
    .mse_physs_port3_ts_capture_vld(nss_mse_physs_port3_ts_capture_vld), 
    .mse_physs_port3_tx_crc(nss_mse_physs_port3_tx_crc), 
    .mse_physs_port3_tx_data(nss_mse_physs_port3_tx_data), 
    .mse_physs_port3_tx_eop(nss_mse_physs_port3_tx_eop), 
    .mse_physs_port3_tx_err(nss_mse_physs_port3_tx_err), 
    .mse_physs_port3_tx_mod(nss_mse_physs_port3_tx_mod), 
    .mse_physs_port3_tx_sop(nss_mse_physs_port3_tx_sop), 
    .mse_physs_port3_tx_wren(nss_mse_physs_port3_tx_wren), 
    .mse_physs_port4_rx_rdy(nss_mse_physs_port4_rx_rdy), 
    .mse_physs_port4_ts_capture_idx(nss_mse_physs_port4_ts_capture_idx), 
    .mse_physs_port4_ts_capture_vld(nss_mse_physs_port4_ts_capture_vld), 
    .mse_physs_port4_tx_crc(nss_mse_physs_port4_tx_crc), 
    .mse_physs_port4_tx_data(nss_mse_physs_port4_tx_data), 
    .mse_physs_port4_tx_eop(nss_mse_physs_port4_tx_eop), 
    .mse_physs_port4_tx_err(nss_mse_physs_port4_tx_err), 
    .mse_physs_port4_tx_mod(nss_mse_physs_port4_tx_mod), 
    .mse_physs_port4_tx_sop(nss_mse_physs_port4_tx_sop), 
    .mse_physs_port4_tx_wren(nss_mse_physs_port4_tx_wren), 
    .mse_physs_port5_rx_rdy(nss_mse_physs_port5_rx_rdy), 
    .mse_physs_port5_ts_capture_idx(nss_mse_physs_port5_ts_capture_idx), 
    .mse_physs_port5_ts_capture_vld(nss_mse_physs_port5_ts_capture_vld), 
    .mse_physs_port5_tx_crc(nss_mse_physs_port5_tx_crc), 
    .mse_physs_port5_tx_data(nss_mse_physs_port5_tx_data), 
    .mse_physs_port5_tx_eop(nss_mse_physs_port5_tx_eop), 
    .mse_physs_port5_tx_err(nss_mse_physs_port5_tx_err), 
    .mse_physs_port5_tx_mod(nss_mse_physs_port5_tx_mod), 
    .mse_physs_port5_tx_sop(nss_mse_physs_port5_tx_sop), 
    .mse_physs_port5_tx_wren(nss_mse_physs_port5_tx_wren), 
    .mse_physs_port6_rx_rdy(nss_mse_physs_port6_rx_rdy), 
    .mse_physs_port6_ts_capture_idx(nss_mse_physs_port6_ts_capture_idx), 
    .mse_physs_port6_ts_capture_vld(nss_mse_physs_port6_ts_capture_vld), 
    .mse_physs_port6_tx_crc(nss_mse_physs_port6_tx_crc), 
    .mse_physs_port6_tx_data(nss_mse_physs_port6_tx_data), 
    .mse_physs_port6_tx_eop(nss_mse_physs_port6_tx_eop), 
    .mse_physs_port6_tx_err(nss_mse_physs_port6_tx_err), 
    .mse_physs_port6_tx_mod(nss_mse_physs_port6_tx_mod), 
    .mse_physs_port6_tx_sop(nss_mse_physs_port6_tx_sop), 
    .mse_physs_port6_tx_wren(nss_mse_physs_port6_tx_wren), 
    .mse_physs_port7_rx_rdy(nss_mse_physs_port7_rx_rdy), 
    .mse_physs_port7_ts_capture_idx(nss_mse_physs_port7_ts_capture_idx), 
    .mse_physs_port7_ts_capture_vld(nss_mse_physs_port7_ts_capture_vld), 
    .mse_physs_port7_tx_crc(nss_mse_physs_port7_tx_crc), 
    .mse_physs_port7_tx_data(nss_mse_physs_port7_tx_data), 
    .mse_physs_port7_tx_eop(nss_mse_physs_port7_tx_eop), 
    .mse_physs_port7_tx_err(nss_mse_physs_port7_tx_err), 
    .mse_physs_port7_tx_mod(nss_mse_physs_port7_tx_mod), 
    .mse_physs_port7_tx_sop(nss_mse_physs_port7_tx_sop), 
    .mse_physs_port7_tx_wren(nss_mse_physs_port7_tx_wren), 
    .phy_pcie0_pcs_rst_n(nss_phy_pcie0_pcs_rst_n), 
    .phy_pcie0_pma_rst_n(nss_phy_pcie0_pma_rst_n), 
    .phy_pcie2_pcs_rst_n(nss_phy_pcie2_pcs_rst_n), 
    .phy_pcie2_pma_rst_n(nss_phy_pcie2_pma_rst_n), 
    .phy_pcie4_pcs_rst_n(nss_phy_pcie4_pcs_rst_n), 
    .phy_pcie4_pma_rst_n(nss_phy_pcie4_pma_rst_n), 
    .phy_pcie6_pcs_rst_n(nss_phy_pcie6_pcs_rst_n), 
    .phy_pcie6_pma_rst_n(nss_phy_pcie6_pma_rst_n), 
    .physs0_reset_func_n(nss_physs0_reset_func_n), 
    .physs1_reset_func_n(nss_physs1_reset_func_n), 
    .physs_t_cnic_noc_physs0_emb_ARREADY(physs_physs_0_ARREADY), 
    .physs_t_cnic_noc_physs0_emb_AWREADY(physs_physs_0_AWREADY), 
    .physs_t_cnic_noc_physs0_emb_BID(physs_physs_0_BID), 
    .physs_t_cnic_noc_physs0_emb_BRESP(physs_physs_0_BRESP), 
    .physs_t_cnic_noc_physs0_emb_BVALID(physs_physs_0_BVALID), 
    .physs_t_cnic_noc_physs0_emb_RDATA(physs_physs_0_RDATA), 
    .physs_t_cnic_noc_physs0_emb_RID(physs_physs_0_RID), 
    .physs_t_cnic_noc_physs0_emb_RLAST(physs_physs_0_RLAST), 
    .physs_t_cnic_noc_physs0_emb_RRESP(physs_physs_0_RRESP), 
    .physs_t_cnic_noc_physs0_emb_RVALID(physs_physs_0_RVALID), 
    .physs_t_cnic_noc_physs0_emb_WREADY(physs_physs_0_WREADY), 
    .phy_ts_int(physs_physs_0_ts_int), 
    .physs_t_cnic_noc_physs1_emb_ARREADY(physs_physs_1_ARREADY), 
    .physs_t_cnic_noc_physs1_emb_AWREADY(physs_physs_1_AWREADY), 
    .physs_t_cnic_noc_physs1_emb_BID(physs_physs_1_BID), 
    .physs_t_cnic_noc_physs1_emb_BRESP(physs_physs_1_BRESP), 
    .physs_t_cnic_noc_physs1_emb_BVALID(physs_physs_1_BVALID), 
    .physs_t_cnic_noc_physs1_emb_RDATA(physs_physs_1_RDATA), 
    .physs_t_cnic_noc_physs1_emb_RID(physs_physs_1_RID), 
    .physs_t_cnic_noc_physs1_emb_RLAST(physs_physs_1_RLAST), 
    .physs_t_cnic_noc_physs1_emb_RRESP(physs_physs_1_RRESP), 
    .physs_t_cnic_noc_physs1_emb_RVALID(physs_physs_1_RVALID), 
    .physs_t_cnic_noc_physs1_emb_WREADY(physs_physs_1_WREADY), 
    .physs_hif_port0_magic_pkt_ind_tgl({4'b0,physs_physs_hif_port_0_magic_pkt_ind_tgl}), 
    .physs_hif_port1_magic_pkt_ind_tgl({4'b0,physs_physs_hif_port_1_magic_pkt_ind_tgl}), 
    .physs_hif_port2_magic_pkt_ind_tgl({4'b0,physs_physs_hif_port_2_magic_pkt_ind_tgl}), 
    .physs_hif_port3_magic_pkt_ind_tgl({4'b0,physs_physs_hif_port_3_magic_pkt_ind_tgl}), 
    .physs_hif_port4_magic_pkt_ind_tgl({4'b0,physs_physs_hif_port_4_magic_pkt_ind_tgl}), 
    .physs_hif_port5_magic_pkt_ind_tgl({4'b0,physs_physs_hif_port_5_magic_pkt_ind_tgl}), 
    .physs_hif_port6_magic_pkt_ind_tgl({4'b0,physs_physs_hif_port_6_magic_pkt_ind_tgl}), 
    .physs_hif_port7_magic_pkt_ind_tgl({4'b0,physs_physs_hif_port_7_magic_pkt_ind_tgl}), 
    .physs_icq_net_xoff(physs_physs_icq_net_xoff), 
    .physs_mse_port0_link_stat(physs_physs_icq_port_0_link_stat), 
    .physs_icq_port0_pfc_mode(physs_physs_icq_port_0_pfc_mode), 
    .physs_mse_port1_link_stat(physs_physs_icq_port_1_link_stat), 
    .physs_icq_port1_pfc_mode(physs_physs_icq_port_1_pfc_mode), 
    .physs_mse_port2_link_stat(physs_physs_icq_port_2_link_stat), 
    .physs_icq_port2_pfc_mode(physs_physs_icq_port_2_pfc_mode), 
    .physs_mse_port3_link_stat(physs_physs_icq_port_3_link_stat), 
    .physs_icq_port3_pfc_mode(physs_physs_icq_port_3_pfc_mode), 
    .physs_mse_port4_link_stat(physs_physs_icq_port_4_link_stat), 
    .physs_icq_port4_pfc_mode(physs_physs_icq_port_4_pfc_mode), 
    .physs_mse_port5_link_stat(physs_physs_icq_port_5_link_stat), 
    .physs_icq_port5_pfc_mode(physs_physs_icq_port_5_pfc_mode), 
    .physs_mse_port6_link_stat(physs_physs_icq_port_6_link_stat), 
    .physs_icq_port6_pfc_mode(physs_physs_icq_port_6_pfc_mode), 
    .physs_mse_port7_link_stat(physs_physs_icq_port_7_link_stat), 
    .physs_icq_port7_pfc_mode(physs_physs_icq_port_7_pfc_mode), 
    .physs_mse_port0_link_speed(physs_physs_mse_port_0_link_speed), 
    .physs_mse_port0_rx_data(physs_physs_mse_port_0_rx_data), 
    .physs_mse_port0_rx_dval(physs_physs_mse_port_0_rx_dval), 
    .physs_mse_port0_rx_ecc_err(physs_physs_mse_port_0_rx_ecc_err), 
    .physs_mse_port0_rx_eop(physs_physs_mse_port_0_rx_eop), 
    .physs_mse_port0_rx_err(physs_physs_mse_port_0_rx_err), 
    .physs_mse_port0_rx_mod(physs_physs_mse_port_0_rx_mod), 
    .physs_mse_port0_rx_sop(physs_physs_mse_port_0_rx_sop), 
    .physs_mse_port0_rx_ts({1'b0,physs_physs_mse_port_0_rx_ts}), 
    .physs_mse_port0_tx_rdy(physs_physs_mse_port_0_tx_rdy), 
    .physs_mse_port1_link_speed(physs_physs_mse_port_1_link_speed), 
    .physs_mse_port1_rx_data(physs_physs_mse_port_1_rx_data), 
    .physs_mse_port1_rx_dval(physs_physs_mse_port_1_rx_dval), 
    .physs_mse_port1_rx_ecc_err(physs_physs_mse_port_1_rx_ecc_err), 
    .physs_mse_port1_rx_eop(physs_physs_mse_port_1_rx_eop), 
    .physs_mse_port1_rx_err(physs_physs_mse_port_1_rx_err), 
    .physs_mse_port1_rx_mod(physs_physs_mse_port_1_rx_mod), 
    .physs_mse_port1_rx_sop(physs_physs_mse_port_1_rx_sop), 
    .physs_mse_port1_rx_ts({1'b0,physs_physs_mse_port_1_rx_ts}), 
    .physs_mse_port1_tx_rdy(physs_physs_mse_port_1_tx_rdy), 
    .physs_mse_port2_link_speed(physs_physs_mse_port_2_link_speed), 
    .physs_mse_port2_rx_data(physs_physs_mse_port_2_rx_data), 
    .physs_mse_port2_rx_dval(physs_physs_mse_port_2_rx_dval), 
    .physs_mse_port2_rx_ecc_err(physs_physs_mse_port_2_rx_ecc_err), 
    .physs_mse_port2_rx_eop(physs_physs_mse_port_2_rx_eop), 
    .physs_mse_port2_rx_err(physs_physs_mse_port_2_rx_err), 
    .physs_mse_port2_rx_mod(physs_physs_mse_port_2_rx_mod), 
    .physs_mse_port2_rx_sop(physs_physs_mse_port_2_rx_sop), 
    .physs_mse_port2_rx_ts({1'b0,physs_physs_mse_port_2_rx_ts}), 
    .physs_mse_port2_tx_rdy(physs_physs_mse_port_2_tx_rdy), 
    .physs_mse_port3_link_speed(physs_physs_mse_port_3_link_speed), 
    .physs_mse_port3_rx_data(physs_physs_mse_port_3_rx_data), 
    .physs_mse_port3_rx_dval(physs_physs_mse_port_3_rx_dval), 
    .physs_mse_port3_rx_ecc_err(physs_physs_mse_port_3_rx_ecc_err), 
    .physs_mse_port3_rx_eop(physs_physs_mse_port_3_rx_eop), 
    .physs_mse_port3_rx_err(physs_physs_mse_port_3_rx_err), 
    .physs_mse_port3_rx_mod(physs_physs_mse_port_3_rx_mod), 
    .physs_mse_port3_rx_sop(physs_physs_mse_port_3_rx_sop), 
    .physs_mse_port3_rx_ts({1'b0,physs_physs_mse_port_3_rx_ts}), 
    .physs_mse_port3_tx_rdy(physs_physs_mse_port_3_tx_rdy), 
    .physs_mse_port4_link_speed(physs_physs_mse_port_4_link_speed), 
    .physs_mse_port4_rx_data(physs_physs_mse_port_4_rx_data), 
    .physs_mse_port4_rx_dval(physs_physs_mse_port_4_rx_dval), 
    .physs_mse_port4_rx_ecc_err(physs_physs_mse_port_4_rx_ecc_err), 
    .physs_mse_port4_rx_eop(physs_physs_mse_port_4_rx_eop), 
    .physs_mse_port4_rx_err(physs_physs_mse_port_4_rx_err), 
    .physs_mse_port4_rx_mod(physs_physs_mse_port_4_rx_mod), 
    .physs_mse_port4_rx_sop(physs_physs_mse_port_4_rx_sop), 
    .physs_mse_port4_rx_ts({1'b0,physs_physs_mse_port_4_rx_ts}), 
    .physs_mse_port4_tx_rdy(physs_physs_mse_port_4_tx_rdy), 
    .physs_mse_port5_link_speed(physs_physs_mse_port_5_link_speed), 
    .physs_mse_port5_rx_data(physs_physs_mse_port_5_rx_data), 
    .physs_mse_port5_rx_dval(physs_physs_mse_port_5_rx_dval), 
    .physs_mse_port5_rx_ecc_err(physs_physs_mse_port_5_rx_ecc_err), 
    .physs_mse_port5_rx_eop(physs_physs_mse_port_5_rx_eop), 
    .physs_mse_port5_rx_err(physs_physs_mse_port_5_rx_err), 
    .physs_mse_port5_rx_mod(physs_physs_mse_port_5_rx_mod), 
    .physs_mse_port5_rx_sop(physs_physs_mse_port_5_rx_sop), 
    .physs_mse_port5_rx_ts({1'b0,physs_physs_mse_port_5_rx_ts}), 
    .physs_mse_port5_tx_rdy(physs_physs_mse_port_5_tx_rdy), 
    .physs_mse_port6_link_speed(physs_physs_mse_port_6_link_speed), 
    .physs_mse_port6_rx_data(physs_physs_mse_port_6_rx_data), 
    .physs_mse_port6_rx_dval(physs_physs_mse_port_6_rx_dval), 
    .physs_mse_port6_rx_ecc_err(physs_physs_mse_port_6_rx_ecc_err), 
    .physs_mse_port6_rx_eop(physs_physs_mse_port_6_rx_eop), 
    .physs_mse_port6_rx_err(physs_physs_mse_port_6_rx_err), 
    .physs_mse_port6_rx_mod(physs_physs_mse_port_6_rx_mod), 
    .physs_mse_port6_rx_sop(physs_physs_mse_port_6_rx_sop), 
    .physs_mse_port6_rx_ts({1'b0,physs_physs_mse_port_6_rx_ts}), 
    .physs_mse_port6_tx_rdy(physs_physs_mse_port_6_tx_rdy), 
    .physs_mse_port7_link_speed(physs_physs_mse_port_7_link_speed), 
    .physs_mse_port7_rx_data(physs_physs_mse_port_7_rx_data), 
    .physs_mse_port7_rx_dval(physs_physs_mse_port_7_rx_dval), 
    .physs_mse_port7_rx_ecc_err(physs_physs_mse_port_7_rx_ecc_err), 
    .physs_mse_port7_rx_eop(physs_physs_mse_port_7_rx_eop), 
    .physs_mse_port7_rx_err(physs_physs_mse_port_7_rx_err), 
    .physs_mse_port7_rx_mod(physs_physs_mse_port_7_rx_mod), 
    .physs_mse_port7_rx_sop(physs_physs_mse_port_7_rx_sop), 
    .physs_mse_port7_rx_ts({1'b0,physs_physs_mse_port_7_rx_ts}), 
    .physs_mse_port7_tx_rdy(physs_physs_mse_port_7_tx_rdy), 
    .ext_lan_txsched_ptc_xoff(hlp_oob_pfc_xoff), 
    .ext_lan_txsched_prt_xoff(hlp_oob_lfc_xoff), 
    .gbe_o_1588_one_pps_out(nss_gbe_o_1588_one_pps_out), 
    .gbe_i_1588_time_sync_n(time_sync_repeater_out), 
    .gbe_o_1588_hlp3_sync_val(nss_gbe_o_1588_hlp3_sync_val), 
    .gbe_o_1588_physs_sync_val(nss_gbe_o_1588_physs_sync_val), 
    .nsc_post_done(nss_nsc_post_done), 
    .nsc_post_pass(nss_nsc_post_pass), 
    .nsc_start_post(nac_post_post_trig_nsc), 
    .nsc_post_mux_ctrl(nac_post_post_mux_ctrl_nsc), 
    .nsc_post_clkungate(nac_post_post_clkungate_nsc), 
    .ncsi_clk(XX_NCSI_CLK), 
    .phy_txen_o(XX_NCSI_CRS_DV), 
    .tx_high_z_en_b(XX_NCSI_RX_EN_B), 
    .phy_rxdv_i(XX_NCSI_TX_EN), 
    .phy_rxd_i({XX_NCSI_RXD1,XX_NCSI_RXD0}), 
    .phy_txd_o({XX_NCSI_TXD1,XX_NCSI_TXD0}), 
    .rmii_arb_in(XX_NCSI_ARB_IN), 
    .rmii_arb_out(XX_NCSI_ARB_OUT), 
    .physs0_reset_prep_ack(physs_physs_reset_prep_ack), 
    .physs0_rst_prep(nss_physs0_rst_prep), 
    .nss_cosq_clk_sel(cnic_fnic_mode_strap), 
    .sn2sfi_rst_pre_ind_n(sn2sfi_rst_pre_ind_n), 
    .nsc_soc_sx_qactive(warm_rst_qactive), 
    .nsc_soc_sx_qdeny(warm_rst_qdeny), 
    .nsc_soc_sx_qacceptn(warm_rst_qacceptn), 
    .soc_nsc_sx_qreqn(warm_rst_qreqn), 
    .HIF_32to16_lanes_dis(otp_fusebox_fuse_bus_271), 
    .HIF_rp_disable(otp_fusebox_fuse_bus_272), 
    .HIF_16lanes_dis(otp_fusebox_fuse_bus_273), 
    .HIF_TDISP_disable(otp_fusebox_fuse_bus_274), 
    .HIF_RESERVED_0_7_5(otp_fusebox_fuse_bus_275), 
    .fuse_rdma_func_fuse({otp_fusebox_fuse_bus_280,otp_fusebox_fuse_bus_279,otp_fusebox_fuse_bus_278,otp_fusebox_fuse_bus_277,otp_fusebox_fuse_bus_276}), 
    .sep_fuse_in({otp_fusebox_fuse_bus_282,otp_fusebox_fuse_bus_281}), 
    .NSS_DFD_Level1_dis(otp_fusebox_fuse_bus_283), 
    .NSS_DFD_Level0_dis(otp_fusebox_fuse_bus_284), 
    .NSS_DFD_Int_only_dis(otp_fusebox_fuse_bus_285), 
    .SYSCON_disable_sec_SHARED(otp_fusebox_fuse_bus_286), 
    .ROM_ECC_ENABLE(otp_fusebox_fuse_bus_287), 
    .ROM_ECC_IMCR_ENABLE(otp_fusebox_fuse_bus_288), 
    .SYSCON_Intel_HIF_DD(otp_fusebox_fuse_bus_289), 
    .SYSCON_WDT_Enable(otp_fusebox_fuse_bus_290), 
    .SYSCON_crypto_dis_per_ip(otp_fusebox_fuse_bus_291), 
    .SYSCON_RESERVED_5_7_4(otp_fusebox_fuse_bus_292), 
    .ICE_prod(otp_fusebox_fuse_bus_293), 
    .ICE_disable_cisp_SHARED(otp_fusebox_fuse_bus_294), 
    .FXP_RESERVED_7_7_1(otp_fusebox_fuse_bus_295), 
    .fuse_ts_func_fuse({otp_fusebox_fuse_bus_297,otp_fusebox_fuse_bus_296}), 
    .SBB_Vendor_ID_7_0(otp_fusebox_fuse_bus_298), 
    .SBB_Vendor_ID_15_8(otp_fusebox_fuse_bus_299), 
    .SBB_unique_id(otp_fusebox_fuse_bus_300), 
    .PCIe_Rev_ID(otp_fusebox_fuse_bus_301), 
    .RESERVED_19_3_2(otp_fusebox_fuse_bus_302), 
    .PCIe_Stepping_ID(otp_fusebox_fuse_bus_303), 
    .RESERVED_19_7_6(otp_fusebox_fuse_bus_304), 
    .RESERVED_20_7_4(otp_fusebox_fuse_bus_305), 
    .IMC_FW_SCRATCH(otp_fusebox_fuse_bus_306), 
    .NSS_S3M_EXISTS(otp_fusebox_fuse_bus_307), 
    .SKU_TPT(otp_fusebox_fuse_bus_308), 
    .RESERVED_23_7_3(otp_fusebox_fuse_bus_309), 
    .VNN_VID_BOOT(otp_fusebox_fuse_bus_310), 
    .VNN_VID_NOMINAL(otp_fusebox_fuse_bus_311), 
    .RESERVED_33_1(otp_fusebox_fuse_bus_312), 
    .RESERVED_37_7(otp_fusebox_fuse_bus_313), 
    .sku_bts_row(otp_fusebox_fuse_bus_314), 
    .sku_select_cfg(otp_fusebox_fuse_bus_315), 
    .nsc_fuse_2prf_hd(otp_fusebox_fuse_bus_316), 
    .nsc_fuse_2prf_hs(otp_fusebox_fuse_bus_317), 
    .nsc_fuse_2prf2psram_uhd(7'b0), 
    .nsc_fuse_rfsram_lr({otp_fusebox_fuse_bus_319,otp_fusebox_fuse_bus_318}), 
    .nsc_fuse_rfsram_sr({otp_fusebox_fuse_bus_321,otp_fusebox_fuse_bus_320}), 
    .nsc_fuse_rfsram_uhd(13'b0), 
    .nsc_fuse_rom(otp_fusebox_fuse_bus_322), 
    .nsc_fuse_tcam(otp_fusebox_fuse_bus_323), 
    .nsc_fuse_hdp2prf(otp_fusebox_fuse_bus_324), 
    .nsc_fuse_hsp2prf(otp_fusebox_fuse_bus_325), 
    .fuse_fxp_func_fuse({otp_fusebox_fuse_bus_295,otp_fusebox_fuse_bus_326}), 
    .boot_mode_strap(1'b0), 
    .a0_debug_b_strap(1'b0), 
    .nsc_bid(8'b0), 
    .cnic_early_boot_rst_n(1'b0), 
    .sn2sfi_rst_n(sn2sfi_rst_n), 
    .soc_nsc_imcr_qactive(imcr_hwrs_qactive), 
    .soc_nsc_imcr_qdeny(imcr_hwrs_qdeny), 
    .fuse_hif_func_fuse(16'b0), 
    .fuse_ice_func_fuse(16'b0), 
    .fuse_ipr_func_fuse(16'b0), 
    .hif_pcie1_PERST_n0(1'b0), 
    .hif_pcie1_PERST_n2(1'b0), 
    .otp_sense_error(1'b0), 
    .nss_cnic_rst_prep_ack(1'b1), 
    .PCIE_Device_ID_15_0(otp_fusebox_fuse_bus_327), 
    .Att_Manifest_FamilyID_7_0(otp_fusebox_fuse_bus_328), 
    .OtpCtrlStateInfo(3'b0), 
    .OtpTrngIfStateInfo(2'b0), 
    .otp_done(1'b0), 
    .physs1_rst_prep(nss_physs1_rst_prep), 
    .physs1_reset_prep_ack(nss_physs1_rst_prep), 
    .hlp_rst_prep(nss_hlp_rst_prep), 
    .hlp_reset_prep_ack(nss_hlp_rst_prep), 
    .soc_nsc_imcr_qacceptn(nac_glue_logic_inst_imcr_qacceptn_nsc), 
    .hif_sfib_cpl_rtrgt1_tlp_halt(nss_hif_sfib_cpl_rtrgt1_tlp_halt), 
    .hif_sfib_cpl_xali_tlp_data(nss_hif_sfib_cpl_xali_tlp_data), 
    .hif_sfib_cpl_xali_tlp_dv(nss_hif_sfib_cpl_xali_tlp_dv), 
    .hif_sfib_cpl_xali_tlp_dwen(nss_hif_sfib_cpl_xali_tlp_dwen), 
    .hif_sfib_cpl_xali_tlp_eot(nss_hif_sfib_cpl_xali_tlp_eot), 
    .hif_sfib_cpl_xali_tlp_fm_format(nss_hif_sfib_cpl_xali_tlp_fm_format), 
    .hif_sfib_cpl_xali_tlp_grant(nss_hif_sfib_cpl_xali_tlp_grant), 
    .hif_sfib_cpl_xali_tlp_hdr(nss_hif_sfib_cpl_xali_tlp_hdr), 
    .hif_sfib_cpl_xali_tlp_hv(nss_hif_sfib_cpl_xali_tlp_hv), 
    .hif_sfib_cpl_xali_tlp_hwen(nss_hif_sfib_cpl_xali_tlp_hwen), 
    .hif_sfib_cpl_xali_tlp_nullified(nss_hif_sfib_cpl_xali_tlp_nullified), 
    .hif_sfib_cpl_xali_tlp_poisoned(nss_hif_sfib_cpl_xali_tlp_poisoned), 
    .hif_sfib_cpl_xali_tlp_soh(nss_hif_sfib_cpl_xali_tlp_soh), 
    .hif_sfib_np_rtrgt1_tlp_halt(nss_hif_sfib_np_rtrgt1_tlp_halt), 
    .hif_sfib_np_xali_tlp_data(nss_hif_sfib_np_xali_tlp_data), 
    .hif_sfib_np_xali_tlp_dv(nss_hif_sfib_np_xali_tlp_dv), 
    .hif_sfib_np_xali_tlp_dwen(nss_hif_sfib_np_xali_tlp_dwen), 
    .hif_sfib_np_xali_tlp_eot(nss_hif_sfib_np_xali_tlp_eot), 
    .hif_sfib_np_xali_tlp_fm_format(nss_hif_sfib_np_xali_tlp_fm_format), 
    .hif_sfib_np_xali_tlp_grant(nss_hif_sfib_np_xali_tlp_grant), 
    .hif_sfib_np_xali_tlp_hdr(nss_hif_sfib_np_xali_tlp_hdr), 
    .hif_sfib_np_xali_tlp_hv(nss_hif_sfib_np_xali_tlp_hv), 
    .hif_sfib_np_xali_tlp_hwen(nss_hif_sfib_np_xali_tlp_hwen), 
    .hif_sfib_np_xali_tlp_nullified(nss_hif_sfib_np_xali_tlp_nullified), 
    .hif_sfib_np_xali_tlp_poisoned(nss_hif_sfib_np_xali_tlp_poisoned), 
    .hif_sfib_np_xali_tlp_soh(nss_hif_sfib_np_xali_tlp_soh), 
    .hif_sfib_p_rtrgt1_tlp_halt(nss_hif_sfib_p_rtrgt1_tlp_halt), 
    .hif_sfib_p_xali_tlp_data(nss_hif_sfib_p_xali_tlp_data), 
    .hif_sfib_p_xali_tlp_dv(nss_hif_sfib_p_xali_tlp_dv), 
    .hif_sfib_p_xali_tlp_dwen(nss_hif_sfib_p_xali_tlp_dwen), 
    .hif_sfib_p_xali_tlp_eot(nss_hif_sfib_p_xali_tlp_eot), 
    .hif_sfib_p_xali_tlp_fm_format(nss_hif_sfib_p_xali_tlp_fm_format), 
    .hif_sfib_p_xali_tlp_grant(nss_hif_sfib_p_xali_tlp_grant), 
    .hif_sfib_p_xali_tlp_hdr(nss_hif_sfib_p_xali_tlp_hdr), 
    .hif_sfib_p_xali_tlp_hv(nss_hif_sfib_p_xali_tlp_hv), 
    .hif_sfib_p_xali_tlp_hwen(nss_hif_sfib_p_xali_tlp_hwen), 
    .hif_sfib_p_xali_tlp_nullified(nss_hif_sfib_p_xali_tlp_nullified), 
    .hif_sfib_p_xali_tlp_poisoned(nss_hif_sfib_p_xali_tlp_poisoned), 
    .hif_sfib_p_xali_tlp_soh(nss_hif_sfib_p_xali_tlp_soh), 
    .sfib_hif_cpl_rtrgt1_tlp_abort(par_sn2sfi_cpl_rtrgt1_tlp_abort), 
    .sfib_hif_cpl_rtrgt1_tlp_data(par_sn2sfi_cpl_rtrgt1_tlp_data), 
    .sfib_hif_cpl_rtrgt1_tlp_dv(par_sn2sfi_cpl_rtrgt1_tlp_dv), 
    .sfib_hif_cpl_rtrgt1_tlp_dwen(par_sn2sfi_cpl_rtrgt1_tlp_dwen), 
    .sfib_hif_cpl_rtrgt1_tlp_eot(par_sn2sfi_cpl_rtrgt1_tlp_eot), 
    .sfib_hif_cpl_rtrgt1_tlp_fm_format(par_sn2sfi_cpl_rtrgt1_tlp_fm_format), 
    .sfib_hif_cpl_rtrgt1_tlp_hdr(par_sn2sfi_cpl_rtrgt1_tlp_hdr), 
    .sfib_hif_cpl_rtrgt1_tlp_hv(par_sn2sfi_cpl_rtrgt1_tlp_hv), 
    .sfib_hif_cpl_rtrgt1_tlp_hwen(par_sn2sfi_cpl_rtrgt1_tlp_hwen), 
    .sfib_hif_cpl_rtrgt1_tlp_nullified(par_sn2sfi_cpl_rtrgt1_tlp_nullified), 
    .sfib_hif_cpl_rtrgt1_tlp_poisoned(par_sn2sfi_cpl_rtrgt1_tlp_poisoned), 
    .sfib_hif_cpl_rtrgt1_tlp_porder(par_sn2sfi_cpl_rtrgt1_tlp_porder), 
    .sfib_hif_cpl_rtrgt1_tlp_soh(par_sn2sfi_cpl_rtrgt1_tlp_soh), 
    .sfib_hif_cpl_xali_tlp_halt(par_sn2sfi_cpl_xali_tlp_halt), 
    .sfib_hif_np_rtrgt1_tlp_abort(par_sn2sfi_np_rtrgt1_tlp_abort), 
    .sfib_hif_np_rtrgt1_tlp_data(par_sn2sfi_np_rtrgt1_tlp_data), 
    .sfib_hif_np_rtrgt1_tlp_dv(par_sn2sfi_np_rtrgt1_tlp_dv), 
    .sfib_hif_np_rtrgt1_tlp_dwen(par_sn2sfi_np_rtrgt1_tlp_dwen), 
    .sfib_hif_np_rtrgt1_tlp_eot(par_sn2sfi_np_rtrgt1_tlp_eot), 
    .sfib_hif_np_rtrgt1_tlp_fm_format(par_sn2sfi_np_rtrgt1_tlp_fm_format), 
    .sfib_hif_np_rtrgt1_tlp_hdr(par_sn2sfi_np_rtrgt1_tlp_hdr), 
    .sfib_hif_np_rtrgt1_tlp_hv(par_sn2sfi_np_rtrgt1_tlp_hv), 
    .sfib_hif_np_rtrgt1_tlp_hwen(par_sn2sfi_np_rtrgt1_tlp_hwen), 
    .sfib_hif_np_rtrgt1_tlp_nullified(par_sn2sfi_np_rtrgt1_tlp_nullified), 
    .sfib_hif_np_rtrgt1_tlp_poisoned(par_sn2sfi_np_rtrgt1_tlp_poisoned), 
    .sfib_hif_np_rtrgt1_tlp_porder(par_sn2sfi_np_rtrgt1_tlp_porder), 
    .sfib_hif_np_rtrgt1_tlp_soh(par_sn2sfi_np_rtrgt1_tlp_soh), 
    .sfib_hif_np_xali_tlp_halt(par_sn2sfi_np_xali_tlp_halt), 
    .sfib_hif_p_rtrgt1_tlp_abort(par_sn2sfi_p_rtrgt1_tlp_abort), 
    .sfib_hif_p_rtrgt1_tlp_data(par_sn2sfi_p_rtrgt1_tlp_data), 
    .sfib_hif_p_rtrgt1_tlp_dv(par_sn2sfi_p_rtrgt1_tlp_dv), 
    .sfib_hif_p_rtrgt1_tlp_dwen(par_sn2sfi_p_rtrgt1_tlp_dwen), 
    .sfib_hif_p_rtrgt1_tlp_eot(par_sn2sfi_p_rtrgt1_tlp_eot), 
    .sfib_hif_p_rtrgt1_tlp_fm_format(par_sn2sfi_p_rtrgt1_tlp_fm_format), 
    .sfib_hif_p_rtrgt1_tlp_hdr(par_sn2sfi_p_rtrgt1_tlp_hdr), 
    .sfib_hif_p_rtrgt1_tlp_hv(par_sn2sfi_p_rtrgt1_tlp_hv), 
    .sfib_hif_p_rtrgt1_tlp_hwen(par_sn2sfi_p_rtrgt1_tlp_hwen), 
    .sfib_hif_p_rtrgt1_tlp_nullified(par_sn2sfi_p_rtrgt1_tlp_nullified), 
    .sfib_hif_p_rtrgt1_tlp_poisoned(par_sn2sfi_p_rtrgt1_tlp_poisoned), 
    .sfib_hif_p_rtrgt1_tlp_porder(par_sn2sfi_p_rtrgt1_tlp_porder), 
    .sfib_hif_p_rtrgt1_tlp_soh(par_sn2sfi_p_rtrgt1_tlp_soh), 
    .sfib_hif_p_xali_tlp_halt(par_sn2sfi_p_xali_tlp_halt), 
    .sfib_hif_p_rtrgt1_tlp_p0_pending(par_sn2sfi_p_rtrgt1_tlp_p0_pending), 
    .nsc_dlw_tfb_trig_next_req_out(nss_nsc_dlw_tfb_trig_next_req_out), 
    .nsc_dlw_tfb_trig_next_ack_out(nss_nsc_dlw_tfb_trig_next_ack_out), 
    .nsc_dlw_tfb_trig_next_req_in(nsc_tfb_req_out_agent), 
    .nsc_dlw_tfb_trig_next_ack_in(nsc_tfb_ack_out_agent), 
    .dfd_dtf_rst(1'b0), 
    .dvp_pm_ip_cg_wake(1'b0), 
    .soc_dtf_clk(1'b0), 
    .PCIE_Rev_ID(2'b0), 
    .PCIE_Stepping_ID(2'b0), 
    .early_boot_error(1'b0), 
    .ATE_Allow_Setting_AT_MMU_Mode(1'b0), 
    .boot_pll_dtestout(1'b0), 
    .pcie_phy1_hif_spare_in(32'b0), 
    .i2c_smbalert_in_n(8'b0), 
    .pvt_cattrip(3'b0), 
    .pvt_nichot(3'b0), 
    .uart_ref_clk(1'b0), 
    .HIF_RESERVED_0_3(1'b0), 
    .RDMA_RESERVED_1_0(1'b0), 
    .CRT_CNVME_Disable_Shared(1'b0), 
    .RDMA_SWFWLD_disable(1'b0), 
    .RDMA_TILECLK_disable(5'b0), 
    .RDMA_RESERVED_2_7_0(8'b0), 
    .SEP_Disable(1'b0), 
    .SEP_RESERVED_3_7_1(7'b0), 
    .ICE_RESERVED_6_7_2(6'b0), 
    .FXP_func_fuse_0(1'b0), 
    .TS_Timing_Wheel_Disable(1'b0), 
    .TS_RESERVED_8_7_1(7'b0), 
    .RESERVED_40_7_5(3'b0), 
    .SPARE_41_7(1'b0), 
    .post_control_survivability_fuses(32'b0), 
    .SPARE_73(32'b0), 
    .cdbg_rstreq(1'b0), 
    .dvp_tap_tck(1'b0), 
    .physs_mse_port0_800g_en(1'b0), 
    .nac_intr_imc(49'b0), 
    .hlp_fatal_intr(1'b0), 
    .hlp_non_fatal_intr(1'b0), 
    .t_nmf_i_cnic_pmsb_AWLOCK(1'b0), 
    .t_nmf_i_cnic_pmsb_AWCACHE(4'b0), 
    .t_nmf_i_cnic_pmsb_AWQOS(4'b0), 
    .t_nmf_i_cnic_pmsb_ARLOCK(1'b0), 
    .t_nmf_i_cnic_pmsb_ARCACHE(4'b0), 
    .t_nmf_i_cnic_pmsb_ARQOS(4'b0), 
    .i_nmf_t_cnic_pmsb_br_BUSER(5'b0), 
    .i_nmf_t_cnic_pmsb_br_RUSER(5'b0), 
    .t_nmf_i_cnic_gpsb_ARCACHE(4'b0), 
    .t_nmf_i_cnic_gpsb_ARLOCK(1'b0), 
    .t_nmf_i_cnic_gpsb_ARQOS(4'b0), 
    .t_nmf_i_cnic_gpsb_AWCACHE(4'b0), 
    .t_nmf_i_cnic_gpsb_AWLOCK(1'b0), 
    .t_nmf_i_cnic_gpsb_AWQOS(4'b0), 
    .i_nmf_t_cnic_bts_io_emb_AWREADY(1'b0), 
    .i_nmf_t_cnic_bts_io_emb_WREADY(1'b0), 
    .i_nmf_t_cnic_bts_io_emb_BID(15'b0), 
    .i_nmf_t_cnic_bts_io_emb_BRESP(2'b0), 
    .i_nmf_t_cnic_bts_io_emb_BVALID(1'b0), 
    .i_nmf_t_cnic_bts_io_emb_ARREADY(1'b0), 
    .i_nmf_t_cnic_bts_io_emb_RID(15'b0), 
    .i_nmf_t_cnic_bts_io_emb_RDATA(32'b0), 
    .i_nmf_t_cnic_bts_io_emb_RRESP(2'b0), 
    .i_nmf_t_cnic_bts_io_emb_RLAST(1'b0), 
    .i_nmf_t_cnic_bts_io_emb_RVALID(1'b0), 
    .i_nmf_t_cnic_gpsb_br_BUSER(5'b0), 
    .i_nmf_t_cnic_gpsb_br_RUSER(5'b0), 
    .soc2imc_qchn_req(1'b0), 
    .nsc_bisr_reset(21'b0), 
    .nsc_bisr_clk(21'b0), 
    .nsc_bisr_shift_en(21'b0), 
    .nsc_bisr_si(21'b0), 
    .nsc_dft_spare_in(32'b0), 
    .nsc_cxp_bisr_si(1'b0), 
    .nsc_fxp_bisr_si(2'b0), 
    .nsc_lan_bisr_si(1'b0), 
    .nsc_rdma_bisr_si(2'b0), 
    .nsc_hif_bisr_si(3'b0), 
    .nsc_hif_nocss_bisr_si(1'b0), 
    .nsc_cnvme_bisr_si(1'b0), 
    .nsc_crt_bisr_si(1'b0), 
    .nsc_nmc_bisr_si(1'b0), 
    .nsc_ice_bisr_si(1'b0), 
    .nsc_sep_bisr_si(1'b0), 
    .nsc_ate_bisr_si(1'b0), 
    .nsc_bsr_bisr_si(1'b0), 
    .nsc_pkb_bisr_si(1'b0), 
    .nsc_ts_bisr_si(1'b0), 
    .nsc_cosq_bisr_si(1'b0), 
    .nsc_ipr_bisr_si(1'b0), 
    .nsc_imc_bisr_si(1'b0), 
    .nsc_nlf_bisr_si(2'b0), 
    .scon_bscan_disable(), 
    .scon_cltap_tapnw_disable(), 
    .reset_nss_hlp_n(), 
    .reset_nss_physs0_n(), 
    .reset_nss_physs1_n(), 
    .misc_int_1588_event_input_0_tog(), 
    .imc_pcie1_disable(), 
    .cfio_powergood(), 
    .gbe_o_1588_freq_out(), 
    .gpio_thermtrip_b(), 
    .hif_pcie0_pm_current_data_rate(), 
    .hif_pcie1_mac_phy_asyncpowerchangeack(), 
    .hif_pcie1_mac_phy_commonclock_enable(), 
    .hif_pcie1_mac_phy_messagebus(), 
    .hif_pcie1_mac_phy_pclk_rate(), 
    .hif_pcie1_mac_phy_powerdown(), 
    .hif_pcie1_mac_phy_rate(), 
    .hif_pcie1_mac_phy_rxelecidle_disable(), 
    .hif_pcie1_mac_phy_rxstandby(), 
    .hif_pcie1_mac_phy_rxwidth(), 
    .hif_pcie1_mac_phy_serdes_arch(), 
    .hif_pcie1_mac_phy_sris_enable(), 
    .hif_pcie1_mac_phy_txcommonmode_disable(), 
    .hif_pcie1_mac_phy_txdata(), 
    .hif_pcie1_mac_phy_txdatavalid(), 
    .hif_pcie1_mac_phy_txdetectrx_loopback(), 
    .hif_pcie1_mac_phy_txelecidle(), 
    .hif_pcie1_mac_phy_width(), 
    .hif_pcie1_pm_current_data_rate(), 
    .hif_pcie1_serdes_pipe_rxready(), 
    .hif_pcie2_pm_current_data_rate(), 
    .hif_pcie3_mac_phy_asyncpowerchangeack(), 
    .hif_pcie3_mac_phy_commonclock_enable(), 
    .hif_pcie3_mac_phy_messagebus(), 
    .hif_pcie3_mac_phy_pclk_rate(), 
    .hif_pcie3_mac_phy_powerdown(), 
    .hif_pcie3_mac_phy_rate(), 
    .hif_pcie3_mac_phy_rxelecidle_disable(), 
    .hif_pcie3_mac_phy_rxstandby(), 
    .hif_pcie3_mac_phy_rxwidth(), 
    .hif_pcie3_mac_phy_serdes_arch(), 
    .hif_pcie3_mac_phy_sris_enable(), 
    .hif_pcie3_mac_phy_txcommonmode_disable(), 
    .hif_pcie3_mac_phy_txdata(), 
    .hif_pcie3_mac_phy_txdatavalid(), 
    .hif_pcie3_mac_phy_txdetectrx_loopback(), 
    .hif_pcie3_mac_phy_txelecidle(), 
    .hif_pcie3_mac_phy_width(), 
    .hif_pcie3_pm_current_data_rate(), 
    .hif_pcie3_serdes_pipe_rxready(), 
    .hif_pcie4_pm_current_data_rate(), 
    .hif_pcie5_mac_phy_asyncpowerchangeack(), 
    .hif_pcie5_mac_phy_commonclock_enable(), 
    .hif_pcie5_mac_phy_messagebus(), 
    .hif_pcie5_mac_phy_pclk_rate(), 
    .hif_pcie5_mac_phy_powerdown(), 
    .hif_pcie5_mac_phy_rate(), 
    .hif_pcie5_mac_phy_rxelecidle_disable(), 
    .hif_pcie5_mac_phy_rxstandby(), 
    .hif_pcie5_mac_phy_rxwidth(), 
    .hif_pcie5_mac_phy_serdes_arch(), 
    .hif_pcie5_mac_phy_sris_enable(), 
    .hif_pcie5_mac_phy_txcommonmode_disable(), 
    .hif_pcie5_mac_phy_txdata(), 
    .hif_pcie5_mac_phy_txdatavalid(), 
    .hif_pcie5_mac_phy_txdetectrx_loopback(), 
    .hif_pcie5_mac_phy_txelecidle(), 
    .hif_pcie5_mac_phy_width(), 
    .hif_pcie5_pm_current_data_rate(), 
    .hif_pcie5_serdes_pipe_rxready(), 
    .hif_pcie6_pm_current_data_rate(), 
    .hif_pcie7_mac_phy_asyncpowerchangeack(), 
    .hif_pcie7_mac_phy_commonclock_enable(), 
    .hif_pcie7_mac_phy_messagebus(), 
    .hif_pcie7_mac_phy_pclk_rate(), 
    .hif_pcie7_mac_phy_powerdown(), 
    .hif_pcie7_mac_phy_rate(), 
    .hif_pcie7_mac_phy_rxelecidle_disable(), 
    .hif_pcie7_mac_phy_rxstandby(), 
    .hif_pcie7_mac_phy_rxwidth(), 
    .hif_pcie7_mac_phy_serdes_arch(), 
    .hif_pcie7_mac_phy_sris_enable(), 
    .hif_pcie7_mac_phy_txcommonmode_disable(), 
    .hif_pcie7_mac_phy_txdata(), 
    .hif_pcie7_mac_phy_txdatavalid(), 
    .hif_pcie7_mac_phy_txdetectrx_loopback(), 
    .hif_pcie7_mac_phy_txelecidle(), 
    .hif_pcie7_mac_phy_width(), 
    .hif_pcie7_pm_current_data_rate(), 
    .hif_pcie7_serdes_pipe_rxready(), 
    .icq_pme_p0_ls_chg(), 
    .icq_pme_p1_ls_chg(), 
    .icq_pme_p2_ls_chg(), 
    .icq_pme_p3_ls_chg(), 
    .icq_pme_p4_ls_chg(), 
    .icq_pme_p5_ls_chg(), 
    .icq_pme_p6_ls_chg(), 
    .icq_pme_p7_ls_chg(), 
    .imc_pcie0_disable(), 
    .intr_gpio_n(), 
    .pad_strap_out(), 
    .phy_pcie1_pcs_rst_n(), 
    .phy_pcie1_pma_rst_n(), 
    .phy_pcie3_pcs_rst_n(), 
    .phy_pcie3_pma_rst_n(), 
    .phy_pcie5_pcs_rst_n(), 
    .phy_pcie5_pma_rst_n(), 
    .phy_pcie7_pcs_rst_n(), 
    .phy_pcie7_pma_rst_n(), 
    .pwr_DBGPWRDUP(), 
    .pwr_L2FLUSHREQ(), 
    .reset_boot_n(), 
    .reset_debug_accapb_n_0(), 
    .reset_debug_accsoc_n_0(), 
    .reset_debug_cmn_n(), 
    .reset_pll_n(), 
    .syscon_cattrip_int(), 
    .syscon_dfd_int_only_l2_dis(), 
    .syscon_nichot_int(), 
    .syscon_pll_bypass(), 
    .t0_debug_en_strap(), 
    .time_zero_clk(), 
    .time_zero_debug(), 
    .tx_high_z_en(), 
    .physs0_reset_pre_n(), 
    .physs0_reset_mem_n(), 
    .physs0_sticky_rst(), 
    .hif_ep_cmn_ARREADY(), 
    .hif_ep_cmn_AWREADY(), 
    .hif_ep_cmn_BID(), 
    .hif_ep_cmn_BRESP(), 
    .hif_ep_cmn_BVALID(), 
    .hif_ep_cmn_RDATA(), 
    .hif_ep_cmn_RID(), 
    .hif_ep_cmn_RLAST(), 
    .hif_ep_cmn_RRESP(), 
    .hif_ep_cmn_RVALID(), 
    .hif_ep_cmn_WREADY(), 
    .hif_hbc0_cmn_ARREADY(), 
    .hif_hbc0_cmn_AWREADY(), 
    .hif_hbc0_cmn_BID(), 
    .hif_hbc0_cmn_BRESP(), 
    .hif_hbc0_cmn_BVALID(), 
    .hif_hbc0_cmn_RDATA(), 
    .hif_hbc0_cmn_RID(), 
    .hif_hbc0_cmn_RLAST(), 
    .hif_hbc0_cmn_RRESP(), 
    .hif_hbc0_cmn_RVALID(), 
    .hif_hbc0_cmn_WREADY(), 
    .ecm_fuse_resense(), 
    .cdbg_rstack(), 
    .otp_disable_sec(), 
    .otp_nmf_imc_remap(), 
    .otp_trng_data(), 
    .otp_trng_data_ack(), 
    .hif_gpio_pcie_WAKE_n(), 
    .physs1_sticky_rst(), 
    .physs1_reset_pre_n(), 
    .physs1_reset_mem_n(), 
    .hlp_sticky_rst(), 
    .hlp_reset_pre_n(), 
    .hlp_reset_mem_n(), 
    .phy_pcie1_pipe_clk(), 
    .phy_pcie3_pipe_clk(), 
    .phy_pcie5_pipe_clk(), 
    .phy_pcie7_pipe_clk(), 
    .nss_dtf_clk_out(), 
    .hif_pcie1_phy_mac_pclkchangeok(), 
    .hif_pcie3_phy_mac_pclkchangeok(), 
    .hif_pcie5_phy_mac_pclkchangeok(), 
    .hif_pcie7_phy_mac_pclkchangeok(), 
    .hif_pcie10_mac_phy_pclkchangeack(), 
    .hif_pcie11_mac_phy_pclkchangeack(), 
    .hif_pcie12_mac_phy_pclkchangeack(), 
    .hif_pcie13_mac_phy_pclkchangeack(), 
    .hif_pcie14_mac_phy_pclkchangeack(), 
    .hif_pcie15_mac_phy_pclkchangeack(), 
    .hif_pcie1_mac_phy_pclkchangeack(), 
    .hif_pcie3_mac_phy_pclkchangeack(), 
    .hif_pcie5_mac_phy_pclkchangeack(), 
    .hif_pcie7_mac_phy_pclkchangeack(), 
    .hif_pcie8_mac_phy_pclkchangeack(), 
    .hif_pcie9_mac_phy_pclkchangeack(), 
    .nss_cosq_out_clk_macsec0(), 
    .nss_cosq_out_clk_macsec1(), 
    .intr_wdt_bark(), 
    .intr_wdt_bite(), 
    .t_nmf_i_cnic_intr_hndlr_ARREADY(), 
    .t_nmf_i_cnic_intr_hndlr_RID(), 
    .t_nmf_i_cnic_intr_hndlr_RDATA(), 
    .t_nmf_i_cnic_intr_hndlr_RRESP(), 
    .t_nmf_i_cnic_intr_hndlr_RLAST(), 
    .t_nmf_i_cnic_intr_hndlr_RVALID(), 
    .t_nmf_i_cnic_intr_hndlr_BUSER(), 
    .t_nmf_i_cnic_intr_hndlr_RUSER(), 
    .t_nmf_i_cnic_pmsb_BUSER(), 
    .t_nmf_i_cnic_pmsb_RUSER(), 
    .i_nmf_t_cnic_apbic_pstrb(), 
    .i_nmf_t_cnic_pmsb_br_ARUSER(), 
    .i_nmf_t_cnic_pmsb_br_AWUSER(), 
    .i_nmf_t_cnic_pmsb_br_AWLOCK(), 
    .i_nmf_t_cnic_pmsb_br_AWCACHE(), 
    .i_nmf_t_cnic_pmsb_br_AWQOS(), 
    .i_nmf_t_cnic_pmsb_br_ARLOCK(), 
    .i_nmf_t_cnic_pmsb_br_ARCACHE(), 
    .i_nmf_t_cnic_pmsb_br_ARQOS(), 
    .t_nmf_i_cnic_gpsb_BUSER(), 
    .t_nmf_i_cnic_gpsb_RUSER(), 
    .i_nmf_t_cnic_bts_io_emb_AWID(), 
    .i_nmf_t_cnic_bts_io_emb_AWADDR(), 
    .i_nmf_t_cnic_bts_io_emb_AWLEN(), 
    .i_nmf_t_cnic_bts_io_emb_AWSIZE(), 
    .i_nmf_t_cnic_bts_io_emb_AWBURST(), 
    .i_nmf_t_cnic_bts_io_emb_AWLOCK(), 
    .i_nmf_t_cnic_bts_io_emb_AWCACHE(), 
    .i_nmf_t_cnic_bts_io_emb_AWPROT(), 
    .i_nmf_t_cnic_bts_io_emb_AWQOS(), 
    .i_nmf_t_cnic_bts_io_emb_AWVALID(), 
    .i_nmf_t_cnic_bts_io_emb_WDATA(), 
    .i_nmf_t_cnic_bts_io_emb_WSTRB(), 
    .i_nmf_t_cnic_bts_io_emb_WLAST(), 
    .i_nmf_t_cnic_bts_io_emb_WVALID(), 
    .i_nmf_t_cnic_bts_io_emb_BREADY(), 
    .i_nmf_t_cnic_bts_io_emb_ARID(), 
    .i_nmf_t_cnic_bts_io_emb_ARADDR(), 
    .i_nmf_t_cnic_bts_io_emb_ARLEN(), 
    .i_nmf_t_cnic_bts_io_emb_ARSIZE(), 
    .i_nmf_t_cnic_bts_io_emb_ARBURST(), 
    .i_nmf_t_cnic_bts_io_emb_ARLOCK(), 
    .i_nmf_t_cnic_bts_io_emb_ARCACHE(), 
    .i_nmf_t_cnic_bts_io_emb_ARPROT(), 
    .i_nmf_t_cnic_bts_io_emb_ARQOS(), 
    .i_nmf_t_cnic_bts_io_emb_ARVALID(), 
    .i_nmf_t_cnic_bts_io_emb_RREADY(), 
    .i_nmf_t_cnic_gpsb_br_AWLOCK(), 
    .i_nmf_t_cnic_gpsb_br_AWCACHE(), 
    .i_nmf_t_cnic_gpsb_br_AWQOS(), 
    .i_nmf_t_cnic_gpsb_br_ARLOCK(), 
    .i_nmf_t_cnic_gpsb_br_ARCACHE(), 
    .i_nmf_t_cnic_gpsb_br_ARQOS(), 
    .i_nmf_t_cnic_gpsb_br_ARUSER(), 
    .i_nmf_t_cnic_gpsb_br_AWUSER(), 
    .physs_t_cnic_noc_physs1_emb_AWQOS(), 
    .physs_t_cnic_noc_physs1_emb_ARQOS(), 
    .physs_t_cnic_noc_physs0_emb_ARQOS(), 
    .physs_t_cnic_noc_physs0_emb_AWQOS(), 
    .i_nmf_t_cnic_hlp_ARCACHE(), 
    .i_nmf_t_cnic_hlp_ARLOCK(), 
    .i_nmf_t_cnic_hlp_ARPROT(), 
    .i_nmf_t_cnic_hlp_ARQOS(), 
    .i_nmf_t_cnic_hlp_AWCACHE(), 
    .i_nmf_t_cnic_hlp_AWLOCK(), 
    .i_nmf_t_cnic_hlp_AWPROT(), 
    .i_nmf_t_cnic_hlp_AWQOS(), 
    .intr_spi_axie(), 
    .intr_spi_done(), 
    .intr_spi_mst(), 
    .intr_spi_rxf(), 
    .intr_spi_rxo(), 
    .intr_spi_rxu(), 
    .intr_spi_spite(), 
    .intr_spi_txe(), 
    .intr_spi_txo(), 
    .intr_spi_txu(), 
    .soc2imc_qchn_ack(), 
    .nsc_bisr_so(), 
    .nsc_aary_mbist_diag_done(), 
    .nsc_dft_spare_out(), 
    .nsc_cxp_bisr_so(), 
    .nsc_fxp_bisr_so(), 
    .nsc_lan_bisr_so(), 
    .nsc_rdma_bisr_so(), 
    .nsc_hif_bisr_so(), 
    .nsc_hif_nocss_bisr_so(), 
    .nsc_cnvme_bisr_so(), 
    .nsc_crt_bisr_so(), 
    .nsc_nmc_bisr_so(), 
    .nsc_ice_bisr_so(), 
    .nsc_sep_bisr_so(), 
    .nsc_ate_bisr_so(), 
    .nsc_bsr_bisr_so(), 
    .nsc_pkb_bisr_so(), 
    .nsc_ts_bisr_so(), 
    .nsc_cosq_bisr_so(), 
    .nsc_ipr_bisr_so(), 
    .nsc_imc_bisr_so(), 
    .nsc_nlf_bisr_so()
) ; 
physs_bbl physs (
    .ssn_bus_clock_in(ssn_bus_clock_in), 
    .ssn_bus_data_in(par_nac_fabric3_physs_mux_end_bus_data_out), 
    .ssn_bus_data_out(par_nac_fabric3_physs_mux_start_bus_data_in), 
    .dfxagg_security_policy(fdfx_security_policy), 
    .dfxagg_policy_update(fdfx_policy_update), 
    .dfxagg_early_boot_debug_exit(fdfx_earlyboot_debug_exit), 
    .dfxagg_debug_capabilities_enabling(fdfx_debug_capabilities_enabling), 
    .dfxagg_debug_capabilities_enabling_valid(fdfx_debug_capabilities_enabling_valid), 
    .tms(tms), 
    .tck(tck), 
    .tdi(tdi), 
    .trst_b(trst_b), 
    .shift_ir_dr(shift_ir_dr), 
    .tms_park_value(tms_park_value), 
    .nw_mode(nw_mode), 
    .ijtag_capture(ijtag_capture), 
    .ijtag_shift(ijtag_shift), 
    .ijtag_update(ijtag_update), 
    .tdo(physs_tdo), 
    .tdo_en(physs_tdo_en), 
    .ijtag_reset_b(par_nac_fabric3_NW_OUT_physs_ijtag_to_reset), 
    .ijtag_select(par_nac_fabric3_NW_OUT_physs_ijtag_to_sel), 
    .ijtag_si(par_nac_fabric3_NW_OUT_physs_ijtag_to_si), 
    .ijtag_so(physs_ijtag_so), 
    .tap_sel_in(physs_tap_sel_in), 
    .fdfx_pwrgood_rst_b(fdfx_pwrgood_rst_b), 
    .pd_vinf_0_bisr_si(ETHPHY_PD0_bisr_chain_si), 
    .pd_vinf_0_bisr_clk(ETHPHY_PD0_bisr_chain_clk), 
    .pd_vinf_0_bisr_reset(ETHPHY_PD0_bisr_chain_rst), 
    .pd_vinf_0_bisr_shift_en(ETHPHY_PD0_bisr_chain_se), 
    .pd_vinf_0_bisr_so(ETHPHY_PD0_bisr_chain_so), 
    .ETH_TXP0(ETH_TXP0), 
    .ETH_TXN0(ETH_TXN0), 
    .ETH_TXP1(ETH_TXP1), 
    .ETH_TXN1(ETH_TXN1), 
    .ETH_TXP2(ETH_TXP2), 
    .ETH_TXN2(ETH_TXN2), 
    .ETH_TXP3(ETH_TXP3), 
    .ETH_TXN3(ETH_TXN3), 
    .ETH_TXP4(ETH_TXP4), 
    .ETH_TXN4(ETH_TXN4), 
    .ETH_TXP5(ETH_TXP5), 
    .ETH_TXN5(ETH_TXN5), 
    .ETH_TXP6(ETH_TXP6), 
    .ETH_TXN6(ETH_TXN6), 
    .ETH_TXP7(ETH_TXP7), 
    .ETH_TXN7(ETH_TXN7), 
    .ETH_RXP0(ETH_RXP0), 
    .ETH_RXN0(ETH_RXN0), 
    .ETH_RXP1(ETH_RXP1), 
    .ETH_RXN1(ETH_RXN1), 
    .ETH_RXP2(ETH_RXP2), 
    .ETH_RXN2(ETH_RXN2), 
    .ETH_RXP3(ETH_RXP3), 
    .ETH_RXN3(ETH_RXN3), 
    .ETH_RXP4(ETH_RXP4), 
    .ETH_RXN4(ETH_RXN4), 
    .ETH_RXP5(ETH_RXP5), 
    .ETH_RXN5(ETH_RXN5), 
    .ETH_RXP6(ETH_RXP6), 
    .ETH_RXN6(ETH_RXN6), 
    .ETH_RXP7(ETH_RXP7), 
    .ETH_RXN7(ETH_RXN7), 
    .ETH_TXP8(ETH_TXP8), 
    .ETH_TXN8(ETH_TXN8), 
    .ETH_TXP9(ETH_TXP9), 
    .ETH_TXN9(ETH_TXN9), 
    .ETH_TXP10(ETH_TXP10), 
    .ETH_TXN10(ETH_TXN10), 
    .ETH_TXP11(ETH_TXP11), 
    .ETH_TXN11(ETH_TXN11), 
    .ETH_TXP12(ETH_TXP12), 
    .ETH_TXN12(ETH_TXN12), 
    .ETH_TXP13(ETH_TXP13), 
    .ETH_TXN13(ETH_TXN13), 
    .ETH_TXP14(ETH_TXP14), 
    .ETH_TXN14(ETH_TXN14), 
    .ETH_TXP15(ETH_TXP15), 
    .ETH_TXN15(ETH_TXN15), 
    .ETH_RXP8(ETH_RXP8), 
    .ETH_RXN8(ETH_RXN8), 
    .ETH_RXP9(ETH_RXP9), 
    .ETH_RXN9(ETH_RXN9), 
    .ETH_RXP10(ETH_RXP10), 
    .ETH_RXN10(ETH_RXN10), 
    .ETH_RXP11(ETH_RXP11), 
    .ETH_RXN11(ETH_RXN11), 
    .ETH_RXP12(ETH_RXP12), 
    .ETH_RXN12(ETH_RXN12), 
    .ETH_RXP13(ETH_RXP13), 
    .ETH_RXN13(ETH_RXN13), 
    .ETH_RXP14(ETH_RXP14), 
    .ETH_RXN14(ETH_RXN14), 
    .ETH_RXP15(ETH_RXP15), 
    .ETH_RXN15(ETH_RXN15), 
    .xioa_ck_pma_ref0_n(xioa_ck_pma_ref0_n), 
    .xioa_ck_pma_ref0_p(xioa_ck_pma_ref0_p), 
    .xioa_ck_pma_ref1_n(xioa_ck_pma_ref1_n), 
    .xioa_ck_pma_ref1_p(xioa_ck_pma_ref1_p), 
    .xoa_pma_dcmon1(xoa_pma_dcmon1), 
    .xoa_pma_dcmon2(xoa_pma_dcmon2), 
    .i_ck_ucss_uart_sclk_0(divmux_aonclk1x_0), 
    .i_ck_ucss_uart_sclk_1(divmux_aonclk1x_0), 
    .i_ck_ucss_uart_sclk_2(divmux_aonclk1x_0), 
    .i_ck_ucss_uart_sclk_3(divmux_aonclk1x_0), 
    .rclk_diff_p(par_nac_fabric3_o_clk_cmlclkout_p_ana_out), 
    .rclk_diff_n(par_nac_fabric3_o_clk_cmlclkout_n_ana_out), 
    .eref0_pad_clk_p(CLK_EREF0_P), 
    .eref0_pad_clk_n(CLK_EREF0_N), 
    .syncE_pad_clk_p(CLKREF_SYNCE_P), 
    .syncE_pad_clk_n(CLKREF_SYNCE_N), 
    .physs_synce_rxclk({XX_SYNCE_CLKOUT1,XX_SYNCE_CLKOUT0}), 
    .soc_per_clk(par_nac_misc_boot_112p5_rdop_fout2_clkout), 
    .physs_funcx2_clk(eth_physs_rdop_fout0_clkout), 
    .physs_intf0_clk_out(physs_physs_intf0_clk_out), 
    .physs_intf0_clk(eth_physs_rdop_fout1_clkout), 
    .tsu_clk(par_nac_fabric3_ts_800_rdop_fout0_clkout_physs), 
    .physs_clkobs_out_clk({physs_physs_clkobs_out_clk_0,physs_physs_clkobs_out_clk}), 
    .mac100_0_int({physs_mac100_0_int_2,physs_mac100_0_int_1,physs_mac100_0_int_0,physs_mac100_0_int}), 
    .mac100_1_int({physs_mac100_1_int_2,physs_mac100_1_int_1,physs_mac100_1_int_0,physs_mac100_1_int}), 
    .mac400_0_int({physs_mac400_0_int_0,physs_mac400_0_int}), 
    .mac400_1_int({physs_mac400_1_int_0,physs_mac400_1_int}), 
    .mac800_0_int(physs_mac800_0_int), 
    .physs_ts_int({physs_physs_ts_int_6,physs_physs_ts_int_5,physs_physs_ts_int_4,physs_physs_ts_int_3,physs_physs_ts_int_2,physs_physs_ts_int_1,physs_physs_ts_int_0,physs_physs_ts_int}), 
    .o_ucss_irq_status_a({physs_o_ucss_irq_status_a_14,physs_o_ucss_irq_status_a_13,physs_o_ucss_irq_status_a_12,physs_o_ucss_irq_status_a_11,physs_o_ucss_irq_status_a_10,physs_o_ucss_irq_status_a_9,physs_o_ucss_irq_status_a_8,physs_o_ucss_irq_status_a_7,physs_o_ucss_irq_status_a_6,physs_o_ucss_irq_status_a_5,physs_o_ucss_irq_status_a_4,physs_o_ucss_irq_status_a_3,physs_o_ucss_irq_status_a_2,physs_o_ucss_irq_status_a_1,physs_o_ucss_irq_status_a_0,
            physs_o_ucss_irq_status_a}), 
    .o_ucss_irq_cpi_0_a({physs_o_ucss_irq_cpi_0_a_2,physs_o_ucss_irq_cpi_0_a_1,physs_o_ucss_irq_cpi_0_a_0,physs_o_ucss_irq_cpi_0_a}), 
    .o_ucss_irq_cpi_1_a({physs_o_ucss_irq_cpi_1_a_2,physs_o_ucss_irq_cpi_1_a_1,physs_o_ucss_irq_cpi_1_a_0,physs_o_ucss_irq_cpi_1_a}), 
    .o_ucss_irq_cpi_2_a({physs_o_ucss_irq_cpi_2_a_2,physs_o_ucss_irq_cpi_2_a_1,physs_o_ucss_irq_cpi_2_a_0,physs_o_ucss_irq_cpi_2_a}), 
    .o_ucss_irq_cpi_3_a({physs_o_ucss_irq_cpi_3_a_2,physs_o_ucss_irq_cpi_3_a_1,physs_o_ucss_irq_cpi_3_a_0,physs_o_ucss_irq_cpi_3_a}), 
    .o_ucss_irq_cpi_4_a({physs_o_ucss_irq_cpi_4_a_2,physs_o_ucss_irq_cpi_4_a_1,physs_o_ucss_irq_cpi_4_a_0,physs_o_ucss_irq_cpi_4_a}), 
    .physs_fatal_int_0(physs_physs_fatal_int_0), 
    .physs_fatal_int_1(physs_physs_fatal_int_1), 
    .physs_imc_int_0(physs_physs_imc_int_0), 
    .physs_imc_int_1(physs_physs_imc_int_1), 
    .hlp_cgmii0_rxc_0(physs_hlp_cgmii0_rxc_0), 
    .hlp_cgmii0_rxc_1(physs_hlp_cgmii0_rxc_1), 
    .hlp_cgmii0_rxc_2(physs_hlp_cgmii0_rxc_2), 
    .hlp_cgmii0_rxc_3(physs_hlp_cgmii0_rxc_3), 
    .hlp_cgmii0_rxc_nss_0(physs_hlp_repeater_hlp_cgmii0_rxc_nss_0), 
    .hlp_cgmii0_rxclk_ena_0(physs_hlp_cgmii0_rxclk_ena_0), 
    .hlp_cgmii0_rxclk_ena_1(physs_hlp_cgmii0_rxclk_ena_1), 
    .hlp_cgmii0_rxclk_ena_2(physs_hlp_cgmii0_rxclk_ena_2), 
    .hlp_cgmii0_rxclk_ena_3(physs_hlp_cgmii0_rxclk_ena_3), 
    .hlp_cgmii0_rxd_0(physs_hlp_cgmii0_rxd_0), 
    .hlp_cgmii0_rxd_1(physs_hlp_cgmii0_rxd_1), 
    .hlp_cgmii0_rxd_2(physs_hlp_cgmii0_rxd_2), 
    .hlp_cgmii0_rxd_3(physs_hlp_cgmii0_rxd_3), 
    .hlp_cgmii0_rxd_nss_0(physs_hlp_repeater_hlp_cgmii0_rxd_nss_0), 
    .hlp_cgmii0_txc_0(physs_hlp_repeater_hlp_cgmii0_txc_0), 
    .hlp_cgmii0_txc_1(physs_hlp_repeater_hlp_cgmii0_txc_1), 
    .hlp_cgmii0_txc_2(physs_hlp_repeater_hlp_cgmii0_txc_2), 
    .hlp_cgmii0_txc_3(physs_hlp_repeater_hlp_cgmii0_txc_3), 
    .hlp_cgmii0_txc_nss_0(physs_hlp_cgmii0_txc_nss_0), 
    .hlp_cgmii0_txclk_ena_0(physs_hlp_cgmii0_txclk_ena_0), 
    .hlp_cgmii0_txclk_ena_1(physs_hlp_cgmii0_txclk_ena_1), 
    .hlp_cgmii0_txclk_ena_2(physs_hlp_cgmii0_txclk_ena_2), 
    .hlp_cgmii0_txclk_ena_3(physs_hlp_cgmii0_txclk_ena_3), 
    .hlp_cgmii0_txd_0(physs_hlp_repeater_hlp_cgmii0_txd_0), 
    .hlp_cgmii0_txd_1(physs_hlp_repeater_hlp_cgmii0_txd_1), 
    .hlp_cgmii0_txd_2(physs_hlp_repeater_hlp_cgmii0_txd_2), 
    .hlp_cgmii0_txd_3(physs_hlp_repeater_hlp_cgmii0_txd_3), 
    .hlp_cgmii0_txd_nss_0(physs_hlp_cgmii0_txd_nss_0), 
    .hlp_cgmii1_rxc_0(physs_hlp_cgmii1_rxc_0), 
    .hlp_cgmii1_rxc_1(physs_hlp_cgmii1_rxc_1), 
    .hlp_cgmii1_rxc_2(physs_hlp_cgmii1_rxc_2), 
    .hlp_cgmii1_rxc_3(physs_hlp_cgmii1_rxc_3), 
    .hlp_cgmii1_rxc_nss_0(physs_hlp_repeater_hlp_cgmii1_rxc_nss_0), 
    .hlp_cgmii1_rxclk_ena_0(physs_hlp_cgmii1_rxclk_ena_0), 
    .hlp_cgmii1_rxclk_ena_1(physs_hlp_cgmii1_rxclk_ena_1), 
    .hlp_cgmii1_rxclk_ena_2(physs_hlp_cgmii1_rxclk_ena_2), 
    .hlp_cgmii1_rxclk_ena_3(physs_hlp_cgmii1_rxclk_ena_3), 
    .hlp_cgmii1_rxd_0(physs_hlp_cgmii1_rxd_0), 
    .hlp_cgmii1_rxd_1(physs_hlp_cgmii1_rxd_1), 
    .hlp_cgmii1_rxd_2(physs_hlp_cgmii1_rxd_2), 
    .hlp_cgmii1_rxd_3(physs_hlp_cgmii1_rxd_3), 
    .hlp_cgmii1_rxd_nss_0(physs_hlp_repeater_hlp_cgmii1_rxd_nss_0), 
    .hlp_cgmii1_txc_0(physs_hlp_repeater_hlp_cgmii1_txc_0), 
    .hlp_cgmii1_txc_1(physs_hlp_repeater_hlp_cgmii1_txc_1), 
    .hlp_cgmii1_txc_2(physs_hlp_repeater_hlp_cgmii1_txc_2), 
    .hlp_cgmii1_txc_3(physs_hlp_repeater_hlp_cgmii1_txc_3), 
    .hlp_cgmii1_txc_nss_0(physs_hlp_cgmii1_txc_nss_0), 
    .hlp_cgmii1_txclk_ena_0(physs_hlp_cgmii1_txclk_ena_0), 
    .hlp_cgmii1_txclk_ena_1(physs_hlp_cgmii1_txclk_ena_1), 
    .hlp_cgmii1_txclk_ena_2(physs_hlp_cgmii1_txclk_ena_2), 
    .hlp_cgmii1_txclk_ena_3(physs_hlp_cgmii1_txclk_ena_3), 
    .hlp_cgmii1_txd_0(physs_hlp_repeater_hlp_cgmii1_txd_0), 
    .hlp_cgmii1_txd_1(physs_hlp_repeater_hlp_cgmii1_txd_1), 
    .hlp_cgmii1_txd_2(physs_hlp_repeater_hlp_cgmii1_txd_2), 
    .hlp_cgmii1_txd_3(physs_hlp_repeater_hlp_cgmii1_txd_3), 
    .hlp_cgmii1_txd_nss_0(physs_hlp_cgmii1_txd_nss_0), 
    .hlp_cgmii2_rxc_0(physs_hlp_cgmii2_rxc_0), 
    .hlp_cgmii2_rxc_1(physs_hlp_cgmii2_rxc_1), 
    .hlp_cgmii2_rxc_2(physs_hlp_cgmii2_rxc_2), 
    .hlp_cgmii2_rxc_3(physs_hlp_cgmii2_rxc_3), 
    .hlp_cgmii2_rxc_nss_0(physs_hlp_repeater_hlp_cgmii2_rxc_nss_0), 
    .hlp_cgmii2_rxclk_ena_0(physs_hlp_cgmii2_rxclk_ena_0), 
    .hlp_cgmii2_rxclk_ena_1(physs_hlp_cgmii2_rxclk_ena_1), 
    .hlp_cgmii2_rxclk_ena_2(physs_hlp_cgmii2_rxclk_ena_2), 
    .hlp_cgmii2_rxclk_ena_3(physs_hlp_cgmii2_rxclk_ena_3), 
    .hlp_cgmii2_rxd_0(physs_hlp_cgmii2_rxd_0), 
    .hlp_cgmii2_rxd_1(physs_hlp_cgmii2_rxd_1), 
    .hlp_cgmii2_rxd_2(physs_hlp_cgmii2_rxd_2), 
    .hlp_cgmii2_rxd_3(physs_hlp_cgmii2_rxd_3), 
    .hlp_cgmii2_rxd_nss_0(physs_hlp_repeater_hlp_cgmii2_rxd_nss_0), 
    .hlp_cgmii2_txc_0(physs_hlp_repeater_hlp_cgmii2_txc_0), 
    .hlp_cgmii2_txc_1(physs_hlp_repeater_hlp_cgmii2_txc_1), 
    .hlp_cgmii2_txc_2(physs_hlp_repeater_hlp_cgmii2_txc_2), 
    .hlp_cgmii2_txc_3(physs_hlp_repeater_hlp_cgmii2_txc_3), 
    .hlp_cgmii2_txc_nss_0(physs_hlp_cgmii2_txc_nss_0), 
    .hlp_cgmii2_txclk_ena_0(physs_hlp_cgmii2_txclk_ena_0), 
    .hlp_cgmii2_txclk_ena_1(physs_hlp_cgmii2_txclk_ena_1), 
    .hlp_cgmii2_txclk_ena_2(physs_hlp_cgmii2_txclk_ena_2), 
    .hlp_cgmii2_txclk_ena_3(physs_hlp_cgmii2_txclk_ena_3), 
    .hlp_cgmii2_txd_0(physs_hlp_repeater_hlp_cgmii2_txd_0), 
    .hlp_cgmii2_txd_1(physs_hlp_repeater_hlp_cgmii2_txd_1), 
    .hlp_cgmii2_txd_2(physs_hlp_repeater_hlp_cgmii2_txd_2), 
    .hlp_cgmii2_txd_3(physs_hlp_repeater_hlp_cgmii2_txd_3), 
    .hlp_cgmii2_txd_nss_0(physs_hlp_cgmii2_txd_nss_0), 
    .hlp_cgmii3_rxc_0(physs_hlp_cgmii3_rxc_0), 
    .hlp_cgmii3_rxc_1(physs_hlp_cgmii3_rxc_1), 
    .hlp_cgmii3_rxc_2(physs_hlp_cgmii3_rxc_2), 
    .hlp_cgmii3_rxc_3(physs_hlp_cgmii3_rxc_3), 
    .hlp_cgmii3_rxc_nss_0(physs_hlp_repeater_hlp_cgmii3_rxc_nss_0), 
    .hlp_cgmii3_rxclk_ena_0(physs_hlp_cgmii3_rxclk_ena_0), 
    .hlp_cgmii3_rxclk_ena_1(physs_hlp_cgmii3_rxclk_ena_1), 
    .hlp_cgmii3_rxclk_ena_2(physs_hlp_cgmii3_rxclk_ena_2), 
    .hlp_cgmii3_rxclk_ena_3(physs_hlp_cgmii3_rxclk_ena_3), 
    .hlp_cgmii3_rxd_0(physs_hlp_cgmii3_rxd_0), 
    .hlp_cgmii3_rxd_1(physs_hlp_cgmii3_rxd_1), 
    .hlp_cgmii3_rxd_2(physs_hlp_cgmii3_rxd_2), 
    .hlp_cgmii3_rxd_3(physs_hlp_cgmii3_rxd_3), 
    .hlp_cgmii3_rxd_nss_0(physs_hlp_repeater_hlp_cgmii3_rxd_nss_0), 
    .hlp_cgmii3_txc_0(physs_hlp_repeater_hlp_cgmii3_txc_0), 
    .hlp_cgmii3_txc_1(physs_hlp_repeater_hlp_cgmii3_txc_1), 
    .hlp_cgmii3_txc_2(physs_hlp_repeater_hlp_cgmii3_txc_2), 
    .hlp_cgmii3_txc_3(physs_hlp_repeater_hlp_cgmii3_txc_3), 
    .hlp_cgmii3_txc_nss_0(physs_hlp_cgmii3_txc_nss_0), 
    .hlp_cgmii3_txclk_ena_0(physs_hlp_cgmii3_txclk_ena_0), 
    .hlp_cgmii3_txclk_ena_1(physs_hlp_cgmii3_txclk_ena_1), 
    .hlp_cgmii3_txclk_ena_2(physs_hlp_cgmii3_txclk_ena_2), 
    .hlp_cgmii3_txclk_ena_3(physs_hlp_cgmii3_txclk_ena_3), 
    .hlp_cgmii3_txd_0(physs_hlp_repeater_hlp_cgmii3_txd_0), 
    .hlp_cgmii3_txd_1(physs_hlp_repeater_hlp_cgmii3_txd_1), 
    .hlp_cgmii3_txd_2(physs_hlp_repeater_hlp_cgmii3_txd_2), 
    .hlp_cgmii3_txd_3(physs_hlp_repeater_hlp_cgmii3_txd_3), 
    .hlp_cgmii3_txd_nss_0(physs_hlp_cgmii3_txd_nss_0), 
    .hlp_xlgmii0_rxc_0(physs_hlp_xlgmii0_rxc_0), 
    .hlp_xlgmii0_rxc_1(physs_hlp_xlgmii0_rxc_1), 
    .hlp_xlgmii0_rxc_2(physs_hlp_xlgmii0_rxc_2), 
    .hlp_xlgmii0_rxc_3(physs_hlp_xlgmii0_rxc_3), 
    .hlp_xlgmii0_rxc_nss_0(physs_hlp_repeater_hlp_xlgmii0_rxc_nss_0), 
    .hlp_xlgmii0_rxclk_ena_0(physs_hlp_xlgmii0_rxclk_ena_0), 
    .hlp_xlgmii0_rxclk_ena_1(physs_hlp_xlgmii0_rxclk_ena_1), 
    .hlp_xlgmii0_rxclk_ena_2(physs_hlp_xlgmii0_rxclk_ena_2), 
    .hlp_xlgmii0_rxclk_ena_3(physs_hlp_xlgmii0_rxclk_ena_3), 
    .hlp_xlgmii0_rxd_0(physs_hlp_xlgmii0_rxd_0), 
    .hlp_xlgmii0_rxd_1(physs_hlp_xlgmii0_rxd_1), 
    .hlp_xlgmii0_rxd_2(physs_hlp_xlgmii0_rxd_2), 
    .hlp_xlgmii0_rxd_3(physs_hlp_xlgmii0_rxd_3), 
    .hlp_xlgmii0_rxd_nss_0(physs_hlp_repeater_hlp_xlgmii0_rxd_nss_0), 
    .hlp_xlgmii0_rxt0_next_0(physs_hlp_xlgmii0_rxt0_next_0), 
    .hlp_xlgmii0_rxt0_next_1(physs_hlp_xlgmii0_rxt0_next_1), 
    .hlp_xlgmii0_rxt0_next_2(physs_hlp_xlgmii0_rxt0_next_2), 
    .hlp_xlgmii0_rxt0_next_3(physs_hlp_xlgmii0_rxt0_next_3), 
    .hlp_xlgmii0_txc_0(physs_hlp_repeater_hlp_xlgmii0_txc_0), 
    .hlp_xlgmii0_txc_1(physs_hlp_repeater_hlp_xlgmii0_txc_1), 
    .hlp_xlgmii0_txc_2(physs_hlp_repeater_hlp_xlgmii0_txc_2), 
    .hlp_xlgmii0_txc_3(physs_hlp_repeater_hlp_xlgmii0_txc_3), 
    .hlp_xlgmii0_txc_nss_0(physs_hlp_xlgmii0_txc_nss_0), 
    .hlp_xlgmii0_txclk_ena_0(physs_hlp_xlgmii0_txclk_ena_0), 
    .hlp_xlgmii0_txclk_ena_1(physs_hlp_xlgmii0_txclk_ena_1), 
    .hlp_xlgmii0_txclk_ena_2(physs_hlp_xlgmii0_txclk_ena_2), 
    .hlp_xlgmii0_txclk_ena_3(physs_hlp_xlgmii0_txclk_ena_3), 
    .hlp_xlgmii0_txd_0(physs_hlp_repeater_hlp_xlgmii0_txd_0), 
    .hlp_xlgmii0_txd_1(physs_hlp_repeater_hlp_xlgmii0_txd_1), 
    .hlp_xlgmii0_txd_2(physs_hlp_repeater_hlp_xlgmii0_txd_2), 
    .hlp_xlgmii0_txd_3(physs_hlp_repeater_hlp_xlgmii0_txd_3), 
    .hlp_xlgmii0_txd_nss_0(physs_hlp_xlgmii0_txd_nss_0), 
    .hlp_xlgmii1_rxc_0(physs_hlp_xlgmii1_rxc_0), 
    .hlp_xlgmii1_rxc_1(physs_hlp_xlgmii1_rxc_1), 
    .hlp_xlgmii1_rxc_2(physs_hlp_xlgmii1_rxc_2), 
    .hlp_xlgmii1_rxc_3(physs_hlp_xlgmii1_rxc_3), 
    .hlp_xlgmii1_rxc_nss_0(physs_hlp_repeater_hlp_xlgmii1_rxc_nss_0), 
    .hlp_xlgmii1_rxclk_ena_0(physs_hlp_xlgmii1_rxclk_ena_0), 
    .hlp_xlgmii1_rxclk_ena_1(physs_hlp_xlgmii1_rxclk_ena_1), 
    .hlp_xlgmii1_rxclk_ena_2(physs_hlp_xlgmii1_rxclk_ena_2), 
    .hlp_xlgmii1_rxclk_ena_3(physs_hlp_xlgmii1_rxclk_ena_3), 
    .hlp_xlgmii1_rxd_0(physs_hlp_xlgmii1_rxd_0), 
    .hlp_xlgmii1_rxd_1(physs_hlp_xlgmii1_rxd_1), 
    .hlp_xlgmii1_rxd_2(physs_hlp_xlgmii1_rxd_2), 
    .hlp_xlgmii1_rxd_3(physs_hlp_xlgmii1_rxd_3), 
    .hlp_xlgmii1_rxd_nss_0(physs_hlp_repeater_hlp_xlgmii1_rxd_nss_0), 
    .hlp_xlgmii1_rxt0_next_0(physs_hlp_xlgmii1_rxt0_next_0), 
    .hlp_xlgmii1_rxt0_next_1(physs_hlp_xlgmii1_rxt0_next_1), 
    .hlp_xlgmii1_rxt0_next_2(physs_hlp_xlgmii1_rxt0_next_2), 
    .hlp_xlgmii1_rxt0_next_3(physs_hlp_xlgmii1_rxt0_next_3), 
    .hlp_xlgmii1_txc_0(physs_hlp_repeater_hlp_xlgmii1_txc_0), 
    .hlp_xlgmii1_txc_1(physs_hlp_repeater_hlp_xlgmii1_txc_1), 
    .hlp_xlgmii1_txc_2(physs_hlp_repeater_hlp_xlgmii1_txc_2), 
    .hlp_xlgmii1_txc_3(physs_hlp_repeater_hlp_xlgmii1_txc_3), 
    .hlp_xlgmii1_txc_nss_0(physs_hlp_xlgmii1_txc_nss_0), 
    .hlp_xlgmii1_txclk_ena_0(physs_hlp_xlgmii1_txclk_ena_0), 
    .hlp_xlgmii1_txclk_ena_1(physs_hlp_xlgmii1_txclk_ena_1), 
    .hlp_xlgmii1_txclk_ena_2(physs_hlp_xlgmii1_txclk_ena_2), 
    .hlp_xlgmii1_txclk_ena_3(physs_hlp_xlgmii1_txclk_ena_3), 
    .hlp_xlgmii1_txd_0(physs_hlp_repeater_hlp_xlgmii1_txd_0), 
    .hlp_xlgmii1_txd_1(physs_hlp_repeater_hlp_xlgmii1_txd_1), 
    .hlp_xlgmii1_txd_2(physs_hlp_repeater_hlp_xlgmii1_txd_2), 
    .hlp_xlgmii1_txd_3(physs_hlp_repeater_hlp_xlgmii1_txd_3), 
    .hlp_xlgmii1_txd_nss_0(physs_hlp_xlgmii1_txd_nss_0), 
    .hlp_xlgmii2_rxc_0(physs_hlp_xlgmii2_rxc_0), 
    .hlp_xlgmii2_rxc_1(physs_hlp_xlgmii2_rxc_1), 
    .hlp_xlgmii2_rxc_2(physs_hlp_xlgmii2_rxc_2), 
    .hlp_xlgmii2_rxc_3(physs_hlp_xlgmii2_rxc_3), 
    .hlp_xlgmii2_rxc_nss_0(physs_hlp_repeater_hlp_xlgmii2_rxc_nss_0), 
    .hlp_xlgmii2_rxclk_ena_0(physs_hlp_xlgmii2_rxclk_ena_0), 
    .hlp_xlgmii2_rxclk_ena_1(physs_hlp_xlgmii2_rxclk_ena_1), 
    .hlp_xlgmii2_rxclk_ena_2(physs_hlp_xlgmii2_rxclk_ena_2), 
    .hlp_xlgmii2_rxclk_ena_3(physs_hlp_xlgmii2_rxclk_ena_3), 
    .hlp_xlgmii2_rxd_0(physs_hlp_xlgmii2_rxd_0), 
    .hlp_xlgmii2_rxd_1(physs_hlp_xlgmii2_rxd_1), 
    .hlp_xlgmii2_rxd_2(physs_hlp_xlgmii2_rxd_2), 
    .hlp_xlgmii2_rxd_3(physs_hlp_xlgmii2_rxd_3), 
    .hlp_xlgmii2_rxd_nss_0(physs_hlp_repeater_hlp_xlgmii2_rxd_nss_0), 
    .hlp_xlgmii2_rxt0_next_0(physs_hlp_xlgmii2_rxt0_next_0), 
    .hlp_xlgmii2_rxt0_next_1(physs_hlp_xlgmii2_rxt0_next_1), 
    .hlp_xlgmii2_rxt0_next_2(physs_hlp_xlgmii2_rxt0_next_2), 
    .hlp_xlgmii2_rxt0_next_3(physs_hlp_xlgmii2_rxt0_next_3), 
    .hlp_xlgmii2_txc_0(physs_hlp_repeater_hlp_xlgmii2_txc_0), 
    .hlp_xlgmii2_txc_1(physs_hlp_repeater_hlp_xlgmii2_txc_1), 
    .hlp_xlgmii2_txc_2(physs_hlp_repeater_hlp_xlgmii2_txc_2), 
    .hlp_xlgmii2_txc_3(physs_hlp_repeater_hlp_xlgmii2_txc_3), 
    .hlp_xlgmii2_txc_nss_0(physs_hlp_xlgmii2_txc_nss_0), 
    .hlp_xlgmii2_txclk_ena_0(physs_hlp_xlgmii2_txclk_ena_0), 
    .hlp_xlgmii2_txclk_ena_1(physs_hlp_xlgmii2_txclk_ena_1), 
    .hlp_xlgmii2_txclk_ena_2(physs_hlp_xlgmii2_txclk_ena_2), 
    .hlp_xlgmii2_txclk_ena_3(physs_hlp_xlgmii2_txclk_ena_3), 
    .hlp_xlgmii2_txd_0(physs_hlp_repeater_hlp_xlgmii2_txd_0), 
    .hlp_xlgmii2_txd_1(physs_hlp_repeater_hlp_xlgmii2_txd_1), 
    .hlp_xlgmii2_txd_2(physs_hlp_repeater_hlp_xlgmii2_txd_2), 
    .hlp_xlgmii2_txd_3(physs_hlp_repeater_hlp_xlgmii2_txd_3), 
    .hlp_xlgmii2_txd_nss_0(physs_hlp_xlgmii2_txd_nss_0), 
    .hlp_xlgmii3_rxc_0(physs_hlp_xlgmii3_rxc_0), 
    .hlp_xlgmii3_rxc_1(physs_hlp_xlgmii3_rxc_1), 
    .hlp_xlgmii3_rxc_2(physs_hlp_xlgmii3_rxc_2), 
    .hlp_xlgmii3_rxc_3(physs_hlp_xlgmii3_rxc_3), 
    .hlp_xlgmii3_rxc_nss_0(physs_hlp_repeater_hlp_xlgmii3_rxc_nss_0), 
    .hlp_xlgmii3_rxclk_ena_0(physs_hlp_xlgmii3_rxclk_ena_0), 
    .hlp_xlgmii3_rxclk_ena_1(physs_hlp_xlgmii3_rxclk_ena_1), 
    .hlp_xlgmii3_rxclk_ena_2(physs_hlp_xlgmii3_rxclk_ena_2), 
    .hlp_xlgmii3_rxclk_ena_3(physs_hlp_xlgmii3_rxclk_ena_3), 
    .hlp_xlgmii3_rxd_0(physs_hlp_xlgmii3_rxd_0), 
    .hlp_xlgmii3_rxd_1(physs_hlp_xlgmii3_rxd_1), 
    .hlp_xlgmii3_rxd_2(physs_hlp_xlgmii3_rxd_2), 
    .hlp_xlgmii3_rxd_3(physs_hlp_xlgmii3_rxd_3), 
    .hlp_xlgmii3_rxd_nss_0(physs_hlp_repeater_hlp_xlgmii3_rxd_nss_0), 
    .hlp_xlgmii3_rxt0_next_0(physs_hlp_xlgmii3_rxt0_next_0), 
    .hlp_xlgmii3_rxt0_next_1(physs_hlp_xlgmii3_rxt0_next_1), 
    .hlp_xlgmii3_rxt0_next_2(physs_hlp_xlgmii3_rxt0_next_2), 
    .hlp_xlgmii3_rxt0_next_3(physs_hlp_xlgmii3_rxt0_next_3), 
    .hlp_xlgmii3_txc_0(physs_hlp_repeater_hlp_xlgmii3_txc_0), 
    .hlp_xlgmii3_txc_1(physs_hlp_repeater_hlp_xlgmii3_txc_1), 
    .hlp_xlgmii3_txc_2(physs_hlp_repeater_hlp_xlgmii3_txc_2), 
    .hlp_xlgmii3_txc_3(physs_hlp_repeater_hlp_xlgmii3_txc_3), 
    .hlp_xlgmii3_txc_nss_0(physs_hlp_xlgmii3_txc_nss_0), 
    .hlp_xlgmii3_txclk_ena_0(physs_hlp_xlgmii3_txclk_ena_0), 
    .hlp_xlgmii3_txclk_ena_1(physs_hlp_xlgmii3_txclk_ena_1), 
    .hlp_xlgmii3_txclk_ena_2(physs_hlp_xlgmii3_txclk_ena_2), 
    .hlp_xlgmii3_txclk_ena_3(physs_hlp_xlgmii3_txclk_ena_3), 
    .hlp_xlgmii3_txd_0(physs_hlp_repeater_hlp_xlgmii3_txd_0), 
    .hlp_xlgmii3_txd_1(physs_hlp_repeater_hlp_xlgmii3_txd_1), 
    .hlp_xlgmii3_txd_2(physs_hlp_repeater_hlp_xlgmii3_txd_2), 
    .hlp_xlgmii3_txd_3(physs_hlp_repeater_hlp_xlgmii3_txd_3), 
    .hlp_xlgmii3_txd_nss_0(physs_hlp_xlgmii3_txd_nss_0), 
    .mii_rx_tsu_mux(physs_mii_rx_tsu_mux), 
    .mii_tx_tsu(physs_mii_tx_tsu), 
    .pcs_desk_buf_rlevel(physs_pcs_desk_buf_rlevel), 
    .pcs_link_status_tsu(physs_pcs_link_status_tsu), 
    .pcs_sd_bit_slip(physs_pcs_sd_bit_slip), 
    .pcs_tsu_rx_sd(physs_pcs_tsu_rx_sd), 
    .physs_0_ARADDR(nss_physs_t_cnic_noc_physs0_emb_ARADDR), 
    .physs_0_ARBURST(nss_physs_t_cnic_noc_physs0_emb_ARBURST), 
    .physs_0_ARCACHE(nss_physs_t_cnic_noc_physs0_emb_ARCACHE), 
    .physs_0_ARID(nss_physs_t_cnic_noc_physs0_emb_ARID), 
    .physs_0_ARLEN(nss_physs_t_cnic_noc_physs0_emb_ARLEN), 
    .physs_0_ARLOCK(nss_physs_t_cnic_noc_physs0_emb_ARLOCK), 
    .physs_0_ARPROT(nss_physs_t_cnic_noc_physs0_emb_ARPROT), 
    .physs_0_ARSIZE(nss_physs_t_cnic_noc_physs0_emb_ARSIZE), 
    .physs_0_ARVALID(nss_physs_t_cnic_noc_physs0_emb_ARVALID), 
    .physs_0_AWADDR(nss_physs_t_cnic_noc_physs0_emb_AWADDR), 
    .physs_0_AWBURST(nss_physs_t_cnic_noc_physs0_emb_AWBURST), 
    .physs_0_AWCACHE(nss_physs_t_cnic_noc_physs0_emb_AWCACHE), 
    .physs_0_AWID(nss_physs_t_cnic_noc_physs0_emb_AWID), 
    .physs_0_AWLEN(nss_physs_t_cnic_noc_physs0_emb_AWLEN), 
    .physs_0_AWLOCK(nss_physs_t_cnic_noc_physs0_emb_AWLOCK), 
    .physs_0_AWPROT(nss_physs_t_cnic_noc_physs0_emb_AWPROT), 
    .physs_0_AWSIZE(nss_physs_t_cnic_noc_physs0_emb_AWSIZE), 
    .physs_0_AWVALID(nss_physs_t_cnic_noc_physs0_emb_AWVALID), 
    .physs_0_BREADY(nss_physs_t_cnic_noc_physs0_emb_BREADY), 
    .physs_0_RREADY(nss_physs_t_cnic_noc_physs0_emb_RREADY), 
    .physs_0_WDATA(nss_physs_t_cnic_noc_physs0_emb_WDATA), 
    .physs_0_WLAST(nss_physs_t_cnic_noc_physs0_emb_WLAST), 
    .physs_0_WSTRB(nss_physs_t_cnic_noc_physs0_emb_WSTRB), 
    .physs_0_WVALID(nss_physs_t_cnic_noc_physs0_emb_WVALID), 
    .physs_1_ARADDR(nss_physs_t_cnic_noc_physs1_emb_ARADDR), 
    .physs_1_ARBURST(nss_physs_t_cnic_noc_physs1_emb_ARBURST), 
    .physs_1_ARCACHE(nss_physs_t_cnic_noc_physs1_emb_ARCACHE), 
    .physs_1_ARID(nss_physs_t_cnic_noc_physs1_emb_ARID), 
    .physs_1_ARLEN(nss_physs_t_cnic_noc_physs1_emb_ARLEN), 
    .physs_1_ARLOCK(nss_physs_t_cnic_noc_physs1_emb_ARLOCK), 
    .physs_1_ARPROT(nss_physs_t_cnic_noc_physs1_emb_ARPROT), 
    .physs_1_ARSIZE(nss_physs_t_cnic_noc_physs1_emb_ARSIZE), 
    .physs_1_ARVALID(nss_physs_t_cnic_noc_physs1_emb_ARVALID), 
    .physs_1_AWADDR(nss_physs_t_cnic_noc_physs1_emb_AWADDR), 
    .physs_1_AWBURST(nss_physs_t_cnic_noc_physs1_emb_AWBURST), 
    .physs_1_AWCACHE(nss_physs_t_cnic_noc_physs1_emb_AWCACHE), 
    .physs_1_AWID(nss_physs_t_cnic_noc_physs1_emb_AWID), 
    .physs_1_AWLEN(nss_physs_t_cnic_noc_physs1_emb_AWLEN), 
    .physs_1_AWLOCK(nss_physs_t_cnic_noc_physs1_emb_AWLOCK), 
    .physs_1_AWPROT(nss_physs_t_cnic_noc_physs1_emb_AWPROT), 
    .physs_1_AWSIZE(nss_physs_t_cnic_noc_physs1_emb_AWSIZE), 
    .physs_1_AWVALID(nss_physs_t_cnic_noc_physs1_emb_AWVALID), 
    .physs_1_BREADY(nss_physs_t_cnic_noc_physs1_emb_BREADY), 
    .physs_1_RREADY(nss_physs_t_cnic_noc_physs1_emb_RREADY), 
    .physs_1_WDATA(nss_physs_t_cnic_noc_physs1_emb_WDATA), 
    .physs_1_WLAST(nss_physs_t_cnic_noc_physs1_emb_WLAST), 
    .physs_1_WSTRB(nss_physs_t_cnic_noc_physs1_emb_WSTRB), 
    .physs_1_WVALID(nss_physs_t_cnic_noc_physs1_emb_WVALID), 
    .icq_physs_net_xoff(nss_icq_physs_net_xoff), 
    .mse_physs_port_0_rx_rdy(nss_mse_physs_port0_rx_rdy), 
    .mse_physs_port_0_ts_capture_idx(nss_mse_physs_port0_ts_capture_idx), 
    .mse_physs_port_0_ts_capture_vld(nss_mse_physs_port0_ts_capture_vld), 
    .mse_physs_port_0_tx_crc(nss_mse_physs_port0_tx_crc), 
    .mse_physs_port_0_tx_data(nss_mse_physs_port0_tx_data), 
    .mse_physs_port_0_tx_eop(nss_mse_physs_port0_tx_eop), 
    .mse_physs_port_0_tx_err(nss_mse_physs_port0_tx_err), 
    .mse_physs_port_0_tx_mod(nss_mse_physs_port0_tx_mod), 
    .mse_physs_port_0_tx_sop(nss_mse_physs_port0_tx_sop), 
    .mse_physs_port_0_tx_wren(nss_mse_physs_port0_tx_wren), 
    .mse_physs_port_1_rx_rdy(nss_mse_physs_port1_rx_rdy), 
    .mse_physs_port_1_ts_capture_idx(nss_mse_physs_port1_ts_capture_idx), 
    .mse_physs_port_1_ts_capture_vld(nss_mse_physs_port1_ts_capture_vld), 
    .mse_physs_port_1_tx_crc(nss_mse_physs_port1_tx_crc), 
    .mse_physs_port_1_tx_data(nss_mse_physs_port1_tx_data), 
    .mse_physs_port_1_tx_eop(nss_mse_physs_port1_tx_eop), 
    .mse_physs_port_1_tx_err(nss_mse_physs_port1_tx_err), 
    .mse_physs_port_1_tx_mod(nss_mse_physs_port1_tx_mod), 
    .mse_physs_port_1_tx_sop(nss_mse_physs_port1_tx_sop), 
    .mse_physs_port_1_tx_wren(nss_mse_physs_port1_tx_wren), 
    .mse_physs_port_2_rx_rdy(nss_mse_physs_port2_rx_rdy), 
    .mse_physs_port_2_ts_capture_idx(nss_mse_physs_port2_ts_capture_idx), 
    .mse_physs_port_2_ts_capture_vld(nss_mse_physs_port2_ts_capture_vld), 
    .mse_physs_port_2_tx_crc(nss_mse_physs_port2_tx_crc), 
    .mse_physs_port_2_tx_data(nss_mse_physs_port2_tx_data), 
    .mse_physs_port_2_tx_eop(nss_mse_physs_port2_tx_eop), 
    .mse_physs_port_2_tx_err(nss_mse_physs_port2_tx_err), 
    .mse_physs_port_2_tx_mod(nss_mse_physs_port2_tx_mod), 
    .mse_physs_port_2_tx_sop(nss_mse_physs_port2_tx_sop), 
    .mse_physs_port_2_tx_wren(nss_mse_physs_port2_tx_wren), 
    .mse_physs_port_3_rx_rdy(nss_mse_physs_port3_rx_rdy), 
    .mse_physs_port_3_ts_capture_idx(nss_mse_physs_port3_ts_capture_idx), 
    .mse_physs_port_3_ts_capture_vld(nss_mse_physs_port3_ts_capture_vld), 
    .mse_physs_port_3_tx_crc(nss_mse_physs_port3_tx_crc), 
    .mse_physs_port_3_tx_data(nss_mse_physs_port3_tx_data), 
    .mse_physs_port_3_tx_eop(nss_mse_physs_port3_tx_eop), 
    .mse_physs_port_3_tx_err(nss_mse_physs_port3_tx_err), 
    .mse_physs_port_3_tx_mod(nss_mse_physs_port3_tx_mod), 
    .mse_physs_port_3_tx_sop(nss_mse_physs_port3_tx_sop), 
    .mse_physs_port_3_tx_wren(nss_mse_physs_port3_tx_wren), 
    .mse_physs_port_4_rx_rdy(nss_mse_physs_port4_rx_rdy), 
    .mse_physs_port_4_ts_capture_idx(nss_mse_physs_port4_ts_capture_idx), 
    .mse_physs_port_4_ts_capture_vld(nss_mse_physs_port4_ts_capture_vld), 
    .mse_physs_port_4_tx_crc(nss_mse_physs_port4_tx_crc), 
    .mse_physs_port_4_tx_data(nss_mse_physs_port4_tx_data), 
    .mse_physs_port_4_tx_eop(nss_mse_physs_port4_tx_eop), 
    .mse_physs_port_4_tx_err(nss_mse_physs_port4_tx_err), 
    .mse_physs_port_4_tx_mod(nss_mse_physs_port4_tx_mod), 
    .mse_physs_port_4_tx_sop(nss_mse_physs_port4_tx_sop), 
    .mse_physs_port_4_tx_wren(nss_mse_physs_port4_tx_wren), 
    .mse_physs_port_5_rx_rdy(nss_mse_physs_port5_rx_rdy), 
    .mse_physs_port_5_ts_capture_idx(nss_mse_physs_port5_ts_capture_idx), 
    .mse_physs_port_5_ts_capture_vld(nss_mse_physs_port5_ts_capture_vld), 
    .mse_physs_port_5_tx_crc(nss_mse_physs_port5_tx_crc), 
    .mse_physs_port_5_tx_data(nss_mse_physs_port5_tx_data), 
    .mse_physs_port_5_tx_eop(nss_mse_physs_port5_tx_eop), 
    .mse_physs_port_5_tx_err(nss_mse_physs_port5_tx_err), 
    .mse_physs_port_5_tx_mod(nss_mse_physs_port5_tx_mod), 
    .mse_physs_port_5_tx_sop(nss_mse_physs_port5_tx_sop), 
    .mse_physs_port_5_tx_wren(nss_mse_physs_port5_tx_wren), 
    .mse_physs_port_6_rx_rdy(nss_mse_physs_port6_rx_rdy), 
    .mse_physs_port_6_ts_capture_idx(nss_mse_physs_port6_ts_capture_idx), 
    .mse_physs_port_6_ts_capture_vld(nss_mse_physs_port6_ts_capture_vld), 
    .mse_physs_port_6_tx_crc(nss_mse_physs_port6_tx_crc), 
    .mse_physs_port_6_tx_data(nss_mse_physs_port6_tx_data), 
    .mse_physs_port_6_tx_eop(nss_mse_physs_port6_tx_eop), 
    .mse_physs_port_6_tx_err(nss_mse_physs_port6_tx_err), 
    .mse_physs_port_6_tx_mod(nss_mse_physs_port6_tx_mod), 
    .mse_physs_port_6_tx_sop(nss_mse_physs_port6_tx_sop), 
    .mse_physs_port_6_tx_wren(nss_mse_physs_port6_tx_wren), 
    .mse_physs_port_7_rx_rdy(nss_mse_physs_port7_rx_rdy), 
    .mse_physs_port_7_ts_capture_idx(nss_mse_physs_port7_ts_capture_idx), 
    .mse_physs_port_7_ts_capture_vld(nss_mse_physs_port7_ts_capture_vld), 
    .mse_physs_port_7_tx_crc(nss_mse_physs_port7_tx_crc), 
    .mse_physs_port_7_tx_data(nss_mse_physs_port7_tx_data), 
    .mse_physs_port_7_tx_eop(nss_mse_physs_port7_tx_eop), 
    .mse_physs_port_7_tx_err(nss_mse_physs_port7_tx_err), 
    .mse_physs_port_7_tx_mod(nss_mse_physs_port7_tx_mod), 
    .mse_physs_port_7_tx_sop(nss_mse_physs_port7_tx_sop), 
    .mse_physs_port_7_tx_wren(nss_mse_physs_port7_tx_wren), 
    .physs0_func_rst_raw_n(nss_physs0_reset_func_n), 
    .physs1_func_rst_raw_n(nss_physs1_reset_func_n), 
    .mdc(XX_MDIO_CLK), 
    .mdio_in(XX_MDIO_IN), 
    .mdio_oen(XX_MDIO_OEN), 
    .mdio_out(XX_MDIO_OUT), 
    .physs_0_ARREADY(physs_physs_0_ARREADY), 
    .physs_0_AWREADY(physs_physs_0_AWREADY), 
    .physs_0_BID(physs_physs_0_BID), 
    .physs_0_BRESP(physs_physs_0_BRESP), 
    .physs_0_BVALID(physs_physs_0_BVALID), 
    .physs_0_RDATA(physs_physs_0_RDATA), 
    .physs_0_RID(physs_physs_0_RID), 
    .physs_0_RLAST(physs_physs_0_RLAST), 
    .physs_0_RRESP(physs_physs_0_RRESP), 
    .physs_0_RVALID(physs_physs_0_RVALID), 
    .physs_0_WREADY(physs_physs_0_WREADY), 
    .physs_0_ts_int(physs_physs_0_ts_int), 
    .physs_1_ARREADY(physs_physs_1_ARREADY), 
    .physs_1_AWREADY(physs_physs_1_AWREADY), 
    .physs_1_BID(physs_physs_1_BID), 
    .physs_1_BRESP(physs_physs_1_BRESP), 
    .physs_1_BVALID(physs_physs_1_BVALID), 
    .physs_1_RDATA(physs_physs_1_RDATA), 
    .physs_1_RID(physs_physs_1_RID), 
    .physs_1_RLAST(physs_physs_1_RLAST), 
    .physs_1_RRESP(physs_physs_1_RRESP), 
    .physs_1_RVALID(physs_physs_1_RVALID), 
    .physs_1_WREADY(physs_physs_1_WREADY), 
    .physs_hif_port_0_magic_pkt_ind_tgl(physs_physs_hif_port_0_magic_pkt_ind_tgl), 
    .physs_hif_port_1_magic_pkt_ind_tgl(physs_physs_hif_port_1_magic_pkt_ind_tgl), 
    .physs_hif_port_2_magic_pkt_ind_tgl(physs_physs_hif_port_2_magic_pkt_ind_tgl), 
    .physs_hif_port_3_magic_pkt_ind_tgl(physs_physs_hif_port_3_magic_pkt_ind_tgl), 
    .physs_hif_port_4_magic_pkt_ind_tgl(physs_physs_hif_port_4_magic_pkt_ind_tgl), 
    .physs_hif_port_5_magic_pkt_ind_tgl(physs_physs_hif_port_5_magic_pkt_ind_tgl), 
    .physs_hif_port_6_magic_pkt_ind_tgl(physs_physs_hif_port_6_magic_pkt_ind_tgl), 
    .physs_hif_port_7_magic_pkt_ind_tgl(physs_physs_hif_port_7_magic_pkt_ind_tgl), 
    .physs_icq_net_xoff(physs_physs_icq_net_xoff), 
    .physs_icq_port_0_link_stat(physs_physs_icq_port_0_link_stat), 
    .physs_icq_port_0_pfc_mode(physs_physs_icq_port_0_pfc_mode), 
    .physs_icq_port_1_link_stat(physs_physs_icq_port_1_link_stat), 
    .physs_icq_port_1_pfc_mode(physs_physs_icq_port_1_pfc_mode), 
    .physs_icq_port_2_link_stat(physs_physs_icq_port_2_link_stat), 
    .physs_icq_port_2_pfc_mode(physs_physs_icq_port_2_pfc_mode), 
    .physs_icq_port_3_link_stat(physs_physs_icq_port_3_link_stat), 
    .physs_icq_port_3_pfc_mode(physs_physs_icq_port_3_pfc_mode), 
    .physs_icq_port_4_link_stat(physs_physs_icq_port_4_link_stat), 
    .physs_icq_port_4_pfc_mode(physs_physs_icq_port_4_pfc_mode), 
    .physs_icq_port_5_link_stat(physs_physs_icq_port_5_link_stat), 
    .physs_icq_port_5_pfc_mode(physs_physs_icq_port_5_pfc_mode), 
    .physs_icq_port_6_link_stat(physs_physs_icq_port_6_link_stat), 
    .physs_icq_port_6_pfc_mode(physs_physs_icq_port_6_pfc_mode), 
    .physs_icq_port_7_link_stat(physs_physs_icq_port_7_link_stat), 
    .physs_icq_port_7_pfc_mode(physs_physs_icq_port_7_pfc_mode), 
    .physs_mse_port_0_link_speed(physs_physs_mse_port_0_link_speed), 
    .physs_mse_port_0_rx_data(physs_physs_mse_port_0_rx_data), 
    .physs_mse_port_0_rx_dval(physs_physs_mse_port_0_rx_dval), 
    .physs_mse_port_0_rx_ecc_err(physs_physs_mse_port_0_rx_ecc_err), 
    .physs_mse_port_0_rx_eop(physs_physs_mse_port_0_rx_eop), 
    .physs_mse_port_0_rx_err(physs_physs_mse_port_0_rx_err), 
    .physs_mse_port_0_rx_mod(physs_physs_mse_port_0_rx_mod), 
    .physs_mse_port_0_rx_sop(physs_physs_mse_port_0_rx_sop), 
    .physs_mse_port_0_rx_ts(physs_physs_mse_port_0_rx_ts), 
    .physs_mse_port_0_tx_rdy(physs_physs_mse_port_0_tx_rdy), 
    .physs_mse_port_1_link_speed(physs_physs_mse_port_1_link_speed), 
    .physs_mse_port_1_rx_data(physs_physs_mse_port_1_rx_data), 
    .physs_mse_port_1_rx_dval(physs_physs_mse_port_1_rx_dval), 
    .physs_mse_port_1_rx_ecc_err(physs_physs_mse_port_1_rx_ecc_err), 
    .physs_mse_port_1_rx_eop(physs_physs_mse_port_1_rx_eop), 
    .physs_mse_port_1_rx_err(physs_physs_mse_port_1_rx_err), 
    .physs_mse_port_1_rx_mod(physs_physs_mse_port_1_rx_mod), 
    .physs_mse_port_1_rx_sop(physs_physs_mse_port_1_rx_sop), 
    .physs_mse_port_1_rx_ts(physs_physs_mse_port_1_rx_ts), 
    .physs_mse_port_1_tx_rdy(physs_physs_mse_port_1_tx_rdy), 
    .physs_mse_port_2_link_speed(physs_physs_mse_port_2_link_speed), 
    .physs_mse_port_2_rx_data(physs_physs_mse_port_2_rx_data), 
    .physs_mse_port_2_rx_dval(physs_physs_mse_port_2_rx_dval), 
    .physs_mse_port_2_rx_ecc_err(physs_physs_mse_port_2_rx_ecc_err), 
    .physs_mse_port_2_rx_eop(physs_physs_mse_port_2_rx_eop), 
    .physs_mse_port_2_rx_err(physs_physs_mse_port_2_rx_err), 
    .physs_mse_port_2_rx_mod(physs_physs_mse_port_2_rx_mod), 
    .physs_mse_port_2_rx_sop(physs_physs_mse_port_2_rx_sop), 
    .physs_mse_port_2_rx_ts(physs_physs_mse_port_2_rx_ts), 
    .physs_mse_port_2_tx_rdy(physs_physs_mse_port_2_tx_rdy), 
    .physs_mse_port_3_link_speed(physs_physs_mse_port_3_link_speed), 
    .physs_mse_port_3_rx_data(physs_physs_mse_port_3_rx_data), 
    .physs_mse_port_3_rx_dval(physs_physs_mse_port_3_rx_dval), 
    .physs_mse_port_3_rx_ecc_err(physs_physs_mse_port_3_rx_ecc_err), 
    .physs_mse_port_3_rx_eop(physs_physs_mse_port_3_rx_eop), 
    .physs_mse_port_3_rx_err(physs_physs_mse_port_3_rx_err), 
    .physs_mse_port_3_rx_mod(physs_physs_mse_port_3_rx_mod), 
    .physs_mse_port_3_rx_sop(physs_physs_mse_port_3_rx_sop), 
    .physs_mse_port_3_rx_ts(physs_physs_mse_port_3_rx_ts), 
    .physs_mse_port_3_tx_rdy(physs_physs_mse_port_3_tx_rdy), 
    .physs_mse_port_4_link_speed(physs_physs_mse_port_4_link_speed), 
    .physs_mse_port_4_rx_data(physs_physs_mse_port_4_rx_data), 
    .physs_mse_port_4_rx_dval(physs_physs_mse_port_4_rx_dval), 
    .physs_mse_port_4_rx_ecc_err(physs_physs_mse_port_4_rx_ecc_err), 
    .physs_mse_port_4_rx_eop(physs_physs_mse_port_4_rx_eop), 
    .physs_mse_port_4_rx_err(physs_physs_mse_port_4_rx_err), 
    .physs_mse_port_4_rx_mod(physs_physs_mse_port_4_rx_mod), 
    .physs_mse_port_4_rx_sop(physs_physs_mse_port_4_rx_sop), 
    .physs_mse_port_4_rx_ts(physs_physs_mse_port_4_rx_ts), 
    .physs_mse_port_4_tx_rdy(physs_physs_mse_port_4_tx_rdy), 
    .physs_mse_port_5_link_speed(physs_physs_mse_port_5_link_speed), 
    .physs_mse_port_5_rx_data(physs_physs_mse_port_5_rx_data), 
    .physs_mse_port_5_rx_dval(physs_physs_mse_port_5_rx_dval), 
    .physs_mse_port_5_rx_ecc_err(physs_physs_mse_port_5_rx_ecc_err), 
    .physs_mse_port_5_rx_eop(physs_physs_mse_port_5_rx_eop), 
    .physs_mse_port_5_rx_err(physs_physs_mse_port_5_rx_err), 
    .physs_mse_port_5_rx_mod(physs_physs_mse_port_5_rx_mod), 
    .physs_mse_port_5_rx_sop(physs_physs_mse_port_5_rx_sop), 
    .physs_mse_port_5_rx_ts(physs_physs_mse_port_5_rx_ts), 
    .physs_mse_port_5_tx_rdy(physs_physs_mse_port_5_tx_rdy), 
    .physs_mse_port_6_link_speed(physs_physs_mse_port_6_link_speed), 
    .physs_mse_port_6_rx_data(physs_physs_mse_port_6_rx_data), 
    .physs_mse_port_6_rx_dval(physs_physs_mse_port_6_rx_dval), 
    .physs_mse_port_6_rx_ecc_err(physs_physs_mse_port_6_rx_ecc_err), 
    .physs_mse_port_6_rx_eop(physs_physs_mse_port_6_rx_eop), 
    .physs_mse_port_6_rx_err(physs_physs_mse_port_6_rx_err), 
    .physs_mse_port_6_rx_mod(physs_physs_mse_port_6_rx_mod), 
    .physs_mse_port_6_rx_sop(physs_physs_mse_port_6_rx_sop), 
    .physs_mse_port_6_rx_ts(physs_physs_mse_port_6_rx_ts), 
    .physs_mse_port_6_tx_rdy(physs_physs_mse_port_6_tx_rdy), 
    .physs_mse_port_7_link_speed(physs_physs_mse_port_7_link_speed), 
    .physs_mse_port_7_rx_data(physs_physs_mse_port_7_rx_data), 
    .physs_mse_port_7_rx_dval(physs_physs_mse_port_7_rx_dval), 
    .physs_mse_port_7_rx_ecc_err(physs_physs_mse_port_7_rx_ecc_err), 
    .physs_mse_port_7_rx_eop(physs_physs_mse_port_7_rx_eop), 
    .physs_mse_port_7_rx_err(physs_physs_mse_port_7_rx_err), 
    .physs_mse_port_7_rx_mod(physs_physs_mse_port_7_rx_mod), 
    .physs_mse_port_7_rx_sop(physs_physs_mse_port_7_rx_sop), 
    .physs_mse_port_7_rx_ts(physs_physs_mse_port_7_rx_ts), 
    .physs_mse_port_7_tx_rdy(physs_physs_mse_port_7_tx_rdy), 
    .physs_timesync_sync_val(physs_fabric3_out), 
    .i_ucss_uart_rxd_0(XX_UART_PHYSS_RXD), 
    .o_ucss_uart_txd_0(XX_UART_PHYSS_TXD), 
    .tx_stop_0_out(physs_tx_stop_0_out), 
    .tx_stop_1_out(physs_tx_stop_1_out), 
    .tx_stop_2_out(physs_tx_stop_2_out), 
    .tx_stop_3_out(physs_tx_stop_3_out), 
    .tx_stop_0_in(hlp_hlp_port0_rx_throttle), 
    .tx_stop_1_in(hlp_hlp_port1_rx_throttle), 
    .tx_stop_2_in(hlp_hlp_port2_rx_throttle), 
    .tx_stop_3_in(hlp_hlp_port3_rx_throttle), 
    .physs_reset_prep_ack(physs_physs_reset_prep_ack), 
    .physs_reset_prep_req(nss_physs0_rst_prep), 
    .ioa_pma_remote_diode_i_anode({hidft_open_9,dts_nac0_i_anode_5,hidft_open_10,dts_nac0_i_anode_6,hidft_open_11,dts_nac0_i_anode_4,hidft_open_12,dts_nac0_i_anode_3,hidft_open_13,dts_nac0_i_anode_2,hidft_open_14,dts_nac0_i_anode_0,hidft_open_15,dts_nac0_i_anode_1,hidft_open_16,
            dts_nac0_i_anode}), 
    .ioa_pma_remote_diode_v_anode({hidft_open_17,physs_ioa_pma_remote_diode_v_anode_5,hidft_open_18,physs_ioa_pma_remote_diode_v_anode_6,hidft_open_19,physs_ioa_pma_remote_diode_v_anode_4,hidft_open_20,physs_ioa_pma_remote_diode_v_anode_3,hidft_open_21,physs_ioa_pma_remote_diode_v_anode_2,hidft_open_22,physs_ioa_pma_remote_diode_v_anode_0,hidft_open_23,physs_ioa_pma_remote_diode_v_anode_1,hidft_open_24,
            physs_ioa_pma_remote_diode_v_anode}), 
    .ioa_pma_remote_diode_i_cathode({hidft_open_25,dts_nac0_i_cathode,hidft_open_26,dts_nac0_i_cathode,hidft_open_27,dts_nac0_i_cathode,hidft_open_28,dts_nac0_i_cathode,hidft_open_29,dts_nac0_i_cathode,hidft_open_30,dts_nac0_i_cathode,hidft_open_31,dts_nac0_i_cathode,hidft_open_32,
            dts_nac0_i_cathode}), 
    .ioa_pma_remote_diode_v_cathode({hidft_open_33,physs_ioa_pma_remote_diode_v_cathode_5,hidft_open_34,physs_ioa_pma_remote_diode_v_cathode_6,hidft_open_35,physs_ioa_pma_remote_diode_v_cathode_4,hidft_open_36,physs_ioa_pma_remote_diode_v_cathode_3,hidft_open_37,physs_ioa_pma_remote_diode_v_cathode_2,hidft_open_38,physs_ioa_pma_remote_diode_v_cathode_0,hidft_open_39,physs_ioa_pma_remote_diode_v_cathode_1,hidft_open_40,
            physs_ioa_pma_remote_diode_v_cathode}), 
    .physs_hd2prf_trim_fuse_in(eth_fusebox_fuse_bus_7), 
    .physs_hdp2prf_trim_fuse_in(eth_fusebox_fuse_bus_8), 
    .physs_rfhs_trim_fuse_in(eth_fusebox_fuse_bus_9), 
    .physs_hdspsr_trim_fuse_in({eth_fusebox_fuse_bus_11,eth_fusebox_fuse_bus_10}), 
    .physs_bbl_800G_0_disable(nac_glue_logic_inst_final_eth_bbl_fuse_disable_0), 
    .physs_bbl_400G_0_disable(nac_glue_logic_inst_final_eth_bbl_fuse_disable_1), 
    .physs_bbl_200G_0_disable(nac_glue_logic_inst_final_eth_bbl_fuse_disable_2), 
    .physs_bbl_100G_0_disable(nac_glue_logic_inst_final_eth_bbl_fuse_disable_3), 
    .physs_bbl_serdes_0_disable(nac_glue_logic_inst_final_eth_bbl_fuse_disable_4), 
    .physs_bbl_400G_1_disable(nac_glue_logic_inst_final_eth_bbl_fuse_disable_5), 
    .physs_bbl_200G_1_disable(nac_glue_logic_inst_final_eth_bbl_fuse_disable_6), 
    .physs_bbl_100G_1_disable(nac_glue_logic_inst_final_eth_bbl_fuse_disable_7), 
    .physs_bbl_serdes_1_disable(nac_glue_logic_inst_final_eth_bbl_fuse_disable_8), 
    .physs_bbl_100G_2_disable(nac_glue_logic_inst_final_eth_bbl_fuse_disable_9), 
    .physs_bbl_serdes_2_disable(nac_glue_logic_inst_final_eth_bbl_fuse_disable_10), 
    .physs_bbl_100G_3_disable(nac_glue_logic_inst_final_eth_bbl_fuse_disable_11), 
    .physs_bbl_serdes_3_disable(nac_glue_logic_inst_final_eth_bbl_fuse_disable_12), 
    .physs_bbl_spare_0(nac_glue_logic_inst_final_eth_bbl_fuse_disable_13),  
    .physs_bbl_spare_1(nac_glue_logic_inst_final_eth_bbl_fuse_disable_14), 
    .physs_bbl_spare_2(nac_glue_logic_inst_final_eth_bbl_fuse_disable_15), 
    .physs_bbl_spare_3(nac_glue_logic_inst_final_eth_bbl_fuse_disable_16), 
    .tdi_tdo_rpt(1'b0), 
    .fary_0_post_force_fail(1'b0), 
    .fary_0_trigger_post(1'b0), 
    .fary_0_post_algo_select(6'b0), 
    .fary_1_post_force_fail(1'b0), 
    .fary_1_trigger_post(1'b0), 
    .fary_1_post_algo_select(6'b0), 
    .BSCAN_PIPE_IN_1_bscan_clock(1'b0), 
    .BSCAN_PIPE_IN_1_select(1'b0), 
    .BSCAN_PIPE_IN_1_capture_en(1'b0), 
    .BSCAN_PIPE_IN_1_shift_en(1'b0), 
    .BSCAN_PIPE_IN_1_update_en(1'b0), 
    .BSCAN_PIPE_IN_1_scan_in(1'b0), 
    .BSCAN_PIPE_IN_1_ac_signal(1'b0), 
    .BSCAN_PIPE_IN_1_ac_init_clock0(1'b0), 
    .BSCAN_PIPE_IN_1_ac_init_clock1(1'b0), 
    .BSCAN_PIPE_IN_1_ac_mode_en(1'b0), 
    .BSCAN_PIPE_IN_1_force_disable(1'b0), 
    .BSCAN_PIPE_IN_1_select_jtag_input(1'b0), 
    .BSCAN_PIPE_IN_1_select_jtag_output(1'b0), 
    .BSCAN_PIPE_IN_1_intel_update_clk(1'b0), 
    .BSCAN_PIPE_IN_1_intel_clamp_en(1'b0), 
    .BSCAN_PIPE_IN_1_intel_bscan_mode(1'b0), 
    .BSCAN_PIPE_IN_1_intel_d6actestsig_b(1'b0), 
    .PHYSS_BSCAN_BYPASS(20'b0), 
    .pd_vinf_1_bisr_si(1'b0), 
    .pd_vinf_1_bisr_reset(1'b0), 
    .pd_vinf_1_bisr_clk(1'b0), 
    .pd_vinf_1_bisr_shift_en(1'b0), 
    .nss_cosq_clk(1'b0), 
    .fscan_txrxword_byp_clk(1'b0), 
    .fscan_ref_clk(1'b0), 
    .fscan_rtdr_sel(1'b0), 
    .i_ucss_uart_cts_b_0(1'b0), 
    .i_ucss_uart_cts_b_1(1'b0), 
    .i_ucss_uart_rxd_1(1'b0), 
    .i_ucss_uart_cts_b_2(1'b0), 
    .i_ucss_uart_rxd_2(1'b0), 
    .i_ucss_uart_cts_b_3(1'b0), 
    .i_ucss_uart_rxd_3(1'b0), 
    .ssn_bus_clock_out(), 
    .DIAG_AGGR_parmisc0_mbist_diag_done(), 
    .DIAG_AGGR_parmisc1_mbist_diag_done(), 
    .aary_0_post_busy(), 
    .aary_0_post_pass(), 
    .aary_0_post_complete(), 
    .aary_1_post_busy(), 
    .aary_1_post_pass(), 
    .aary_1_post_complete(), 
    .BSCAN_PIPE_OUT_1_scan_out(), 
    .pd_vinf_0_bisr_clk_out(), 
    .pd_vinf_0_bisr_reset_out(), 
    .pd_vinf_0_bisr_shift_en_out(), 
    .pd_vinf_1_bisr_so(), 
    .pd_vinf_1_bisr_clk_out(), 
    .pd_vinf_1_bisr_reset_out(), 
    .pd_vinf_1_bisr_shift_en_out(), 
    .physs_mse_800g_en(), 
    .o_ck_ucss_uart_baudout_b_0(), 
    .o_ucss_uart_de_0(), 
    .o_ucss_uart_lp_req_pclk_0(), 
    .o_ucss_uart_lp_req_sclk_0(), 
    .o_ucss_uart_re_0(), 
    .o_ucss_uart_rs485_en_0(), 
    .o_ucss_uart_rts_b_0(), 
    .o_ck_ucss_uart_baudout_b_1(), 
    .o_ucss_uart_de_1(), 
    .o_ucss_uart_lp_req_pclk_1(), 
    .o_ucss_uart_lp_req_sclk_1(), 
    .o_ucss_uart_re_1(), 
    .o_ucss_uart_rs485_en_1(), 
    .o_ucss_uart_rts_b_1(), 
    .o_ucss_uart_txd_1(), 
    .o_ck_ucss_uart_baudout_b_2(), 
    .o_ucss_uart_de_2(), 
    .o_ucss_uart_lp_req_pclk_2(), 
    .o_ucss_uart_lp_req_sclk_2(), 
    .o_ucss_uart_re_2(), 
    .o_ucss_uart_rs485_en_2(), 
    .o_ucss_uart_rts_b_2(), 
    .o_ucss_uart_txd_2(), 
    .o_ck_ucss_uart_baudout_b_3(), 
    .o_ucss_uart_de_3(), 
    .o_ucss_uart_lp_req_pclk_3(), 
    .o_ucss_uart_lp_req_sclk_3(), 
    .o_ucss_uart_re_3(), 
    .o_ucss_uart_rs485_en_3(), 
    .o_ucss_uart_rts_b_3(), 
    .o_ucss_uart_txd_3()
) ; 
assign imcr_hwrs_qreqn = nss_nsc_soc_imcr_qreqn ; 
assign nac_ss_tpiu_reset = nss_reset_debug_soc_n ; 
assign nac_ss_apb_112p5_physs_clk = par_nac_misc_boot_112p5_rdop_fout2_clkout ; 
assign nac_ss_apb_112p5_clk = par_nac_misc_boot_112p5_rdop_fout2_clkout ; 
endmodule
