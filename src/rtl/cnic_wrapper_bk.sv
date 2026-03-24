module cnic_wrapper #(
)
(	input clk_tcam_fast,
	input xtalclk,
	input infra_clk,
	input time_ref_clk_cmos,
        input XX_SYS_REFCLK,
        input CLK_EREF0_P,	
        input CLK_EREF0_N,
        input CLKREF_SYNCE_P,	
        input CLKREF_SYNCE_N,
        input ephy_refclk,
        input spi_debug_clk,
        input uart_ref_clk,
	input pcie_ref_clk_p,
        input pcie_ref_clk_n,
        input sfi_clk_1g_in,
        input sn2sfi_rst_n,
         input i2c_apb_clk,

`ifndef HLP_PHYSS_STUB
`ifndef NAC_STUB
`ifndef NMC_ONLY
        input clk_125mhz,
        input i_reset,
        input reference_clk,
        inout I2C_SDA,
        inout I2C_SCL,
        output I2C_MODSELL,
        input I2C_MODPRSL,
        input I2C_INTL,
        output I2C_RESETL,
        output I2C_LPMODE,
        input rx_serial_data,
        output tx_serial_data,

`endif
`endif
`endif
	
  
`ifndef HLP_PHYSS_ONLY
  output           led_green,
  output           led_red,
  input   [3:0]    pci_exp_rxn,
  input   [3:0]    pci_exp_rxp,
  output  [3:0]    pci_exp_txn,
  output  [3:0]    pci_exp_txp,
  input            pdeb_pcie_perst_n,
  output           tosw_pcie_perst_n,
  input            frsw_pcie_perst_n,
  input            pwron_n,
  output           wake_n,
  output           prsnt_n,
  
	`ifdef SPI_HW
        inout  XX_SPI_IO_0,		
        inout  XX_SPI_IO_1,
        inout  XX_SPI_IO_2,
        inout  XX_SPI_IO_3,
        output XX_SPI_CLK_O,
        output XX_SPI_CS0_N_O,
        output XX_SPI_FPGA_SEL_DPN,
        `endif	
    `endif
	input sys_rst_n);

parameter integer SB_MAXPLD_WIDTH_1 = 7;

logic DQS;
wire [3:0] SIO;

logic [49:0] nac_ss_spare_in;
logic [49:0] nac_ss_spare_out;
logic xtalclk;
logic rstbus_clk;
logic infra_clk;
logic croclk;
logic time_ref_clk_cmos;
logic XX_SYS_REFCLK;
logic CLK_EREF0_P;
logic CLK_EREF0_N;
logic CLKREF_SYNCE_P;
logic CLKREF_SYNCE_N;
logic bclk1;
logic cmlclkout_p_ana;
logic cmlclkout_n_ana;
logic cmlbuf_valid_dig;
logic dfd_dop_enable;
logic [7:0] fdfx_security_policy;
logic fdfx_policy_update;
logic fdfx_earlyboot_debug_exit;
logic [7:0] fdfx_debug_capabilities_enabling;
logic fdfx_debug_capabilities_enabling_valid;
logic pll_oa_fusa_comb_error;
logic nac_vccana_vccs5_iso_ctrl_b;
logic BOOT_MODE_STRAP;
logic [4:0] BID;
logic PLL_REF_SEL0_STRAP;
logic PLL_REF_SEL1_STRAP;
logic TIME_REF_SEL_STRAP;
logic XX_BIST_ENABLE;
logic [7:0] axi2sb_strap_sai_secure;
logic [7:0] axi2sb_strap_sai_nonsec;
logic [63:0] axi2sb_strap_policy1_cp_default;
logic [63:0] axi2sb_strap_policy1_rac_default;
logic [63:0] axi2sb_strap_policy1_wac_default;
logic [63:0] axi2sb_strap_policy2_cp_default;
logic [63:0] axi2sb_strap_policy2_rac_default;
logic [63:0] axi2sb_strap_policy2_wac_default;
logic [63:0] axi2sb_strap_policy3_cp_default;
logic [63:0] axi2sb_strap_policy3_rac_default;
logic [63:0] axi2sb_strap_policy3_wac_default;
logic [63:0] axi2sb_strap_secure_sai_lut_default;
logic [63:0] axi2sb_strap_cgid_sai_lut_default;
logic [7:0] axi2sb_strap_dfd_cgid_default;
logic [7:0] axi2sb_strap_infra_cgid_default;
logic [2:0] clockss_boot_pll_iosf_sb_ism_fabric;
logic [2:0] clockss_boot_pll_iosf_sb_ism_agent;
logic clockss_boot_pll_iosf_sb_side_pok;
logic clockss_boot_pll_iosf_sb_mnpput;
logic clockss_boot_pll_iosf_sb_mpcput;
logic clockss_boot_pll_iosf_sb_mnpcup;
logic clockss_boot_pll_iosf_sb_mpccup;
logic clockss_boot_pll_iosf_sb_meom;
logic [SB_MAXPLD_WIDTH_1:0] clockss_boot_pll_iosf_sb_mpayload;
logic clockss_boot_pll_iosf_sb_tnpput;
logic clockss_boot_pll_iosf_sb_tpcput;
logic clockss_boot_pll_iosf_sb_tnpcup;
logic clockss_boot_pll_iosf_sb_tpccup;
logic clockss_boot_pll_iosf_sb_teom;
logic [SB_MAXPLD_WIDTH_1:0] clockss_boot_pll_iosf_sb_tpayload;
logic sfi_clk_1g;
logic sfi_clk_1g_in;
logic XX_NCSI_CLK_OUT;
logic XX_RGMII_CLK_OUT;
logic nac_ss_apb_112p5_clk;
logic nac_ss_apb_112p5_physs_clk;
logic hvm_clk_sel_cnic;
logic [5:0] cltap_hvm_ctrl_reg;
logic [2:0] clockss_nss_pll_iosf_sb_ism_fabric;
logic [2:0] clockss_nss_pll_iosf_sb_ism_agent;
logic clockss_nss_pll_iosf_sb_side_pok;
logic clockss_nss_pll_iosf_sb_mnpput;
logic clockss_nss_pll_iosf_sb_mpcput;
logic clockss_nss_pll_iosf_sb_mnpcup;
logic clockss_nss_pll_iosf_sb_mpccup;
logic clockss_nss_pll_iosf_sb_meom;
logic [SB_MAXPLD_WIDTH_1:0] clockss_nss_pll_iosf_sb_mpayload;
logic clockss_nss_pll_iosf_sb_tnpput;
logic clockss_nss_pll_iosf_sb_tpcput;
logic clockss_nss_pll_iosf_sb_tnpcup;
logic clockss_nss_pll_iosf_sb_tpccup;
logic clockss_nss_pll_iosf_sb_teom;
logic [SB_MAXPLD_WIDTH_1:0] clockss_nss_pll_iosf_sb_tpayload;
logic [2:0] clockss_ts_pll_iosf_sb_ism_fabric;
logic [2:0] clockss_ts_pll_iosf_sb_ism_agent;
logic clockss_ts_pll_iosf_sb_side_pok;
logic clockss_ts_pll_iosf_sb_mnpput;
logic clockss_ts_pll_iosf_sb_mpcput;
logic clockss_ts_pll_iosf_sb_mnpcup;
logic clockss_ts_pll_iosf_sb_mpccup;
logic clockss_ts_pll_iosf_sb_meom;
logic [SB_MAXPLD_WIDTH_1:0] clockss_ts_pll_iosf_sb_mpayload;
logic clockss_ts_pll_iosf_sb_tnpput;
logic clockss_ts_pll_iosf_sb_tpcput;
logic clockss_ts_pll_iosf_sb_tnpcup;
logic clockss_ts_pll_iosf_sb_tpccup;
logic clockss_ts_pll_iosf_sb_teom;
logic [SB_MAXPLD_WIDTH_1:0] clockss_ts_pll_iosf_sb_tpayload;
logic mt_clk_800;
logic time_sync_loop_back_pps_sel;
logic time_sync_input_mode_sel;
logic clkss_cmlbuf_iosf_sb_intf_MNPCUP;
logic clkss_cmlbuf_iosf_sb_intf_MPCCUP;
logic [2:0] clkss_cmlbuf_iosf_sb_intf_SIDE_ISM_FABRIC;
logic clkss_cmlbuf_iosf_sb_intf_TEOM;
logic clkss_cmlbuf_iosf_sb_intf_TNPPUT;
logic [31:0] clkss_cmlbuf_iosf_sb_intf_TPAYLOAD;
logic clkss_cmlbuf_iosf_sb_intf_TPCPUT;
logic clkss_cmlbuf_iosf_sb_intf_MEOM;
logic clkss_cmlbuf_iosf_sb_intf_MNPPUT;
logic [31:0] clkss_cmlbuf_iosf_sb_intf_MPAYLOAD;
logic clkss_cmlbuf_iosf_sb_intf_MPCPUT;
logic [2:0] clkss_cmlbuf_iosf_sb_intf_SIDE_ISM_AGENT;
logic clkss_cmlbuf_iosf_sb_intf_TNPCUP;
logic clkss_cmlbuf_iosf_sb_intf_TPCCUP;
logic clkss_cmlbuf_sideband_pok;
logic clkss_cmlbuf_phy_ss_iosf_sb_intf_MNPCUP;
logic clkss_cmlbuf_phy_ss_iosf_sb_intf_MPCCUP;
logic [2:0] clkss_cmlbuf_phy_ss_iosf_sb_intf_SIDE_ISM_FABRIC;
logic clkss_cmlbuf_phy_ss_iosf_sb_intf_TEOM;
logic clkss_cmlbuf_phy_ss_iosf_sb_intf_TNPPUT;
logic [31:0] clkss_cmlbuf_phy_ss_iosf_sb_intf_TPAYLOAD;
logic clkss_cmlbuf_phy_ss_iosf_sb_intf_TPCPUT;
logic clkss_cmlbuf_phy_ss_iosf_sb_intf_MEOM;
logic clkss_cmlbuf_phy_ss_iosf_sb_intf_MNPPUT;
logic [31:0] clkss_cmlbuf_phy_ss_iosf_sb_intf_MPAYLOAD;
logic clkss_cmlbuf_phy_ss_iosf_sb_intf_MPCPUT;
logic [2:0] clkss_cmlbuf_phy_ss_iosf_sb_intf_SIDE_ISM_AGENT;
logic clkss_cmlbuf_phy_ss_iosf_sb_intf_TNPCUP;
logic clkss_cmlbuf_phy_ss_iosf_sb_intf_TPCCUP;
logic clkss_cmlbuf_phy_ss_sideband_pok;
logic cmlclkout_p_ana_phy_ss;
logic cmlclkout_n_ana_phy_ss;
logic nac_ss_dtf_upstream_credit;
logic nac_ss_dtf_upstream_active;
logic nac_ss_dtf_upstream_sync;
logic nac_ss_dtfb_upstream_rst_b;
logic nac_ss_debug_safemode_isa_oob;
logic [15:0] nac_ss_debug_snib_apb_addr;
logic nac_ss_debug_snib_apb_en;
logic nac_ss_debug_apb_rst_n;
logic nac_ss_debug_snib_apb_sel;
logic [31:0] nac_ss_debug_snib_apb_wdata;
logic nac_ss_debug_snib_apb_wr;
logic [2:0] nac_ss_debug_snib_apb_prot;
logic [3:0] nac_ss_debug_snib_apb_strb;
logic [15:0] nac_ss_debug_iosf2sfi_apb_addr;
logic nac_ss_debug_iosf2sfi_apb_en;
logic nac_ss_debug_iosf2sfi_apb_sel;
logic [31:0] nac_ss_debug_iosf2sfi_apb_wdata;
logic nac_ss_debug_iosf2sfi_apb_wr;
logic [2:0] nac_ss_debug_iosf2sfi_apb_prot;
logic [3:0] nac_ss_debug_iosf2sfi_apb_strb;
logic [24:0] nac_ss_dtf_dnstream_header;
logic [63:0] nac_ss_dtf_dnstream_data;
logic nac_ss_dtf_dnstream_valid;
logic [1:0] nac_ss_debug_dig_view_out;
logic [2:0] nac_ss_debug_dts_dig_view_in;
logic [2:0] nac_ss_debug_dts_dig_view_out;
logic [1:0] nac_ss_debug_ana_view_inout;
logic [7:0] nac_ss_tpiu_data;
logic nac_ss_tpiu_clk;
logic [31:0] nac_ss_debug_css600_dp_targetid;
logic nac_ss_debug_timestamp;
logic [31:0] nac_ss_debug_snib_apb_rdata;
logic nac_ss_debug_snib_apb_rdy;
logic nac_ss_debug_snib_apb_slverr;
logic [31:0] nac_ss_debug_iosf2sfi_apb_rdata;
logic nac_ss_debug_iosf2sfi_apb_rdy;
logic nac_ss_debug_iosf2sfi_apb_slverr;
logic [1:0] nac_ss_debug_serializer_misc_chain_out_to_nac;
logic [1:0] nac_ss_debug_serializer_hlp_eth_chain_out_to_nac;
logic [1:0] nac_ss_debug_serializer_hif_eusb2_chain_out_to_nac;
logic [1:0] nac_ss_debug_serializer_hlp_eth_chain_in_from_nac;
logic [1:0] nac_ss_debug_serializer_misc_chain_in_from_nac;
logic [1:0] nac_ss_debug_serializer_hif_eusb2_chain_in_from_nac;
logic [3:0] nac_ss_debug_req_in_next;
logic [3:0] nac_ss_debug_req_out_next;
logic [3:0] nac_ss_debug_ack_in_next;
logic [3:0] nac_ss_debug_ack_out_next;
logic [3:0] nac_ss_debug_par_gpio_ne_req_in_next;
logic [3:0] nac_ss_debug_par_gpio_ne_req_out_next;
logic [3:0] nac_ss_debug_par_gpio_ne_ack_in_next;
logic [3:0] nac_ss_debug_par_gpio_ne_ack_out_next;
logic nac_ss_debug_css600_swclk_in;
logic nac_ss_debug_css600_swdio_in;
logic nac_ss_debug_css600_swd_sel_in;
logic nac_ss_debug_css600_swdo_out;
logic nac_ss_debug_css600_swd0_en_out;
logic nac_ss_tpiu_reset;
logic [2:0] nac_post_iosf_sb_ism_fabric;
logic [2:0] nac_post_iosf_sb_ism_agent;
logic nac_post_iosf_sb_mnpput;
logic nac_post_iosf_sb_mpcput;
logic nac_post_iosf_sb_mnpcup;
logic nac_post_iosf_sb_mpccup;
logic nac_post_iosf_sb_meom;
logic [SB_MAXPLD_WIDTH_1:0] nac_post_iosf_sb_mpayload;
logic nac_post_iosf_sb_tnpput;
logic nac_post_iosf_sb_tpcput;
logic nac_post_iosf_sb_tnpcup;
logic nac_post_iosf_sb_tpccup;
logic nac_post_iosf_sb_teom;
logic [SB_MAXPLD_WIDTH_1:0] nac_post_iosf_sb_tpayload;
logic [7:0] nac_post_status_to_cltap;
logic YY_WOL_N;
logic XX_TIME_SYNC;
logic dts_lvrref_a;
logic nac_ra_err;
logic nac_thermtrip_in;
logic nac_thermtrip_out;
logic nac_pllthermtrip_err;
//logic s5_bgr_lvrrefpwrgood;
logic iosf2sfi_isa_clk_req;
logic isa_iosf2sfi_isa_clk_ack;
logic sn2iosf_isa_clk_req;
logic isa_sn2iosf_isa_clk_ack;
logic gpio_ne_i_anode;
logic gpio_ne_v_anode;
logic gpio_ne_v_cathode;
logic fabric_s5_i_anode;
logic fabric_s5_v_anode;
logic fabric_s5_v_cathode;
logic nac_dts2_i_cathode;
logic NAC_XX_THERMDASOC0;
logic NAC_XX_THERMDCSOC0;
logic svidalert_n_rxen_b;
logic svidalert_n_rxen_b_rpt_sync;
logic svidclk_rxen_b;
logic svidclk_rxen_b_rpt_sync;
logic svidclk_txen_b;
logic svidclk_txen_b_rpt_sync;
logic sviddata_rxdata;
logic sviddata_rxdata_rpt_sync;
logic sviddata_rxen_b;
logic sviddata_rxen_b_rpt_sync;
logic sviddata_txen_b;
logic sviddata_txen_b_rpt_sync;
logic gpio_ne_nacss_xxsvidclk_rxdata;
logic nacss_punit_feedthrough_xxsvidclk_rxdata;
logic gpio_ne_nacss_xxsvidalert_n_rxdata;
logic nacss_punit_feedthrough_xxsvidalert_n_rxdata;
logic [2:0] rsrc_adapt_dts_nac0_iosf_sb_ism_fabric;
logic [2:0] rsrc_adapt_dts_nac0_iosf_sb_ism_agent;
logic rsrc_adapt_dts_nac0_iosf_sb_side_pok;
logic rsrc_adapt_dts_nac0_iosf_sb_mnpput;
logic rsrc_adapt_dts_nac0_iosf_sb_mpcput;
logic rsrc_adapt_dts_nac0_iosf_sb_mnpcup;
logic rsrc_adapt_dts_nac0_iosf_sb_mpccup;
logic rsrc_adapt_dts_nac0_iosf_sb_meom;
logic [7:0] rsrc_adapt_dts_nac0_iosf_sb_mpayload;
logic rsrc_adapt_dts_nac0_iosf_sb_tnpput;
logic rsrc_adapt_dts_nac0_iosf_sb_tpcput;
logic rsrc_adapt_dts_nac0_iosf_sb_tnpcup;
logic rsrc_adapt_dts_nac0_iosf_sb_tpccup;
logic rsrc_adapt_dts_nac0_iosf_sb_teom;
logic [7:0] rsrc_adapt_dts_nac0_iosf_sb_tpayload;
logic [2:0] rsrc_adapt_dts_nac1_iosf_sb_ism_fabric;
logic [2:0] rsrc_adapt_dts_nac1_iosf_sb_ism_agent;
logic rsrc_adapt_dts_nac1_iosf_sb_side_pok;
logic rsrc_adapt_dts_nac1_iosf_sb_mnpput;
logic rsrc_adapt_dts_nac1_iosf_sb_mpcput;
logic rsrc_adapt_dts_nac1_iosf_sb_mnpcup;
logic rsrc_adapt_dts_nac1_iosf_sb_mpccup;
logic rsrc_adapt_dts_nac1_iosf_sb_meom;
logic [7:0] rsrc_adapt_dts_nac1_iosf_sb_mpayload;
logic rsrc_adapt_dts_nac1_iosf_sb_tnpput;
logic rsrc_adapt_dts_nac1_iosf_sb_tpcput;
logic rsrc_adapt_dts_nac1_iosf_sb_tnpcup;
logic rsrc_adapt_dts_nac1_iosf_sb_tpccup;
logic rsrc_adapt_dts_nac1_iosf_sb_teom;
logic [7:0] rsrc_adapt_dts_nac1_iosf_sb_tpayload;
logic [2:0] rsrc_adapt_dts_nac2_iosf_sb_ism_fabric;
logic [2:0] rsrc_adapt_dts_nac2_iosf_sb_ism_agent;
logic rsrc_adapt_dts_nac2_iosf_sb_side_pok;
logic rsrc_adapt_dts_nac2_iosf_sb_mnpput;
logic rsrc_adapt_dts_nac2_iosf_sb_mpcput;
logic rsrc_adapt_dts_nac2_iosf_sb_mnpcup;
logic rsrc_adapt_dts_nac2_iosf_sb_mpccup;
logic rsrc_adapt_dts_nac2_iosf_sb_meom;
logic [7:0] rsrc_adapt_dts_nac2_iosf_sb_mpayload;
logic rsrc_adapt_dts_nac2_iosf_sb_tnpput;
logic rsrc_adapt_dts_nac2_iosf_sb_tpcput;
logic rsrc_adapt_dts_nac2_iosf_sb_tnpcup;
logic rsrc_adapt_dts_nac2_iosf_sb_tpccup;
logic rsrc_adapt_dts_nac2_iosf_sb_teom;
logic [7:0] rsrc_adapt_dts_nac2_iosf_sb_tpayload;
logic sn2sfi_rst_n;
logic hif_pcie0_PERST_n0;
logic nac_pwrgood_rst_b;
logic inf_rstbus_rst_b;
logic early_boot_rst_b;
logic inf_iosfsb_rst_b;
logic nac_sys_rst_n;
logic ecm_boot_err;
logic nac_a0_debug_strap;
logic [4:0] hwrs_nac_spare_in;
logic [4:0] nac_hwrs_spare_out;
logic sn2sfi_powergood;
logic cnic_fnic_mode_strap;
//logic nsc_gpio_wake_on_lan; 
logic nsc_qchagg_hif_sn2sfi_busy; 
logic fdfx_pwrgood_rst_b;
logic [31:0] reset_cmd_data;
logic reset_cmd_valid;
logic reset_cmd_parity;
logic imcr_hwrs_qacceptn;
logic imcr_hwrs_qdeny;
logic imcr_hwrs_qactive;
logic imcr_hwrs_qreqn;
logic [2:0] clockss_eth_physs_pll_iosf_sb_ism_fabric;
logic [2:0] clockss_eth_physs_pll_iosf_sb_ism_agent;
logic clockss_eth_physs_pll_iosf_sb_side_pok;
logic clockss_eth_physs_pll_iosf_sb_mnpput;
logic clockss_eth_physs_pll_iosf_sb_mpcput;
logic clockss_eth_physs_pll_iosf_sb_mnpcup;
logic clockss_eth_physs_pll_iosf_sb_mpccup;
logic clockss_eth_physs_pll_iosf_sb_meom;
logic [SB_MAXPLD_WIDTH_1:0] clockss_eth_physs_pll_iosf_sb_mpayload;
logic clockss_eth_physs_pll_iosf_sb_tnpput;
logic clockss_eth_physs_pll_iosf_sb_tpcput;
logic clockss_eth_physs_pll_iosf_sb_tnpcup;
logic clockss_eth_physs_pll_iosf_sb_tpccup;
logic clockss_eth_physs_pll_iosf_sb_teom;
logic [SB_MAXPLD_WIDTH_1:0] clockss_eth_physs_pll_iosf_sb_tpayload;
logic infraclk_div4_pdop_par_fabric_s5;
logic apb2iosfsb_pipe_rst_n;
logic gpio_ne1p8_sb_pipe_rst_n;
logic BSCAN_bypass_avephy_x4_phy0;
logic BSCAN_bypass_avephy_x4_phy1;
logic BSCAN_bypass_avephy_x4_phy2;
logic BSCAN_bypass_avephy_x4_phy3;
logic BSCAN_wake_avephy_x4_phy0;
logic BSCAN_wake_avephy_x4_phy1;
logic BSCAN_wake_avephy_x4_phy2;
logic BSCAN_wake_avephy_x4_phy3;
logic [19:0] PHYSS_BSCAN_BYPASS;
logic GPIO_NE_BSCAN_PIPE_OUT_TO_USBMUX_force_disable;
logic GPIO_NE_BSCAN_PIPE_OUT_TO_USBMUX_select_jtag_input;
logic GPIO_NE_BSCAN_PIPE_OUT_TO_USBMUX_select_jtag_output;
logic GPIO_NE_BSCAN_PIPE_OUT_TO_USBMUX_ac_init_clock0;
logic GPIO_NE_BSCAN_PIPE_OUT_TO_USBMUX_ac_init_clock1;
logic GPIO_NE_BSCAN_PIPE_OUT_TO_USBMUX_ac_signal;
logic GPIO_NE_BSCAN_PIPE_OUT_TO_USBMUX_ac_mode_en;
logic GPIO_NE_BSCAN_PIPE_OUT_TO_USBMUX_intel_update_clk;
logic GPIO_NE_BSCAN_PIPE_OUT_TO_USBMUX_intel_clamp_en;
logic GPIO_NE_BSCAN_PIPE_OUT_TO_USBMUX_intel_bscan_mode;
logic GPIO_NE_BSCAN_PIPE_OUT_TO_USBMUX_select;
logic GPIO_NE_BSCAN_PIPE_OUT_TO_USBMUX_bscan_clock;
logic GPIO_NE_BSCAN_PIPE_OUT_TO_USBMUX_capture_en;
logic GPIO_NE_BSCAN_PIPE_OUT_TO_USBMUX_shift_en;
logic GPIO_NE_BSCAN_PIPE_OUT_TO_USBMUX_update_en;
logic GPIO_NE_BSCAN_PIPE_OUT_TO_USBMUX_scan_in;
logic BSCAN_PIPE_IN_FROM_GPIO_NE_scan_out;
logic GPIO_SW_BSCAN_PIPE_OUT_TO_GPIO_SW_force_disable;
logic GPIO_SW_BSCAN_PIPE_OUT_TO_GPIO_SW_select_jtag_input;
logic GPIO_SW_BSCAN_PIPE_OUT_TO_GPIO_SW_select_jtag_output;
logic GPIO_SW_BSCAN_PIPE_OUT_TO_GPIO_SW_ac_init_clock0;
logic GPIO_SW_BSCAN_PIPE_OUT_TO_GPIO_SW_ac_init_clock1;
logic GPIO_SW_BSCAN_PIPE_OUT_TO_GPIO_SW_ac_signal;
logic GPIO_SW_BSCAN_PIPE_OUT_TO_GPIO_SW_ac_mode_en;
logic GPIO_SW_BSCAN_PIPE_OUT_TO_GPIO_SW_intel_update_clk;
logic GPIO_SW_BSCAN_PIPE_OUT_TO_GPIO_SW_intel_clamp_en;
logic GPIO_SW_BSCAN_PIPE_OUT_TO_GPIO_SW_intel_bscan_mode;
logic GPIO_SW_BSCAN_PIPE_OUT_TO_GPIO_SW_select;
logic GPIO_SW_BSCAN_PIPE_OUT_TO_GPIO_SW_bscan_clock;
logic GPIO_SW_BSCAN_PIPE_OUT_TO_GPIO_SW_capture_en;
logic GPIO_SW_BSCAN_PIPE_OUT_TO_GPIO_SW_shift_en;
logic GPIO_SW_BSCAN_PIPE_OUT_TO_GPIO_SW_update_en;
logic GPIO_SW_BSCAN_PIPE_OUT_TO_GPIO_SW_scan_in;
logic BSCAN_PIPE_IN_FROM_GPIO_SW_scan_out;
logic BSCAN_PIPE_IN_bscan_clock;
logic BSCAN_PIPE_IN_select;
logic BSCAN_PIPE_IN_capture_en;
logic BSCAN_PIPE_IN_shift_en;
logic BSCAN_PIPE_IN_update_en;
logic BSCAN_PIPE_IN_scan_in;
logic BSCAN_PIPE_IN_ac_signal;
logic BSCAN_PIPE_IN_ac_init_clock0;
logic BSCAN_PIPE_IN_ac_init_clock1;
logic BSCAN_PIPE_IN_ac_mode_en;
logic BSCAN_PIPE_IN_force_disable;
logic BSCAN_PIPE_IN_select_jtag_input;
logic BSCAN_PIPE_IN_select_jtag_output;
logic BSCAN_PIPE_IN_intel_update_clk;
logic BSCAN_PIPE_IN_intel_clamp_en;
logic BSCAN_PIPE_IN_intel_bscan_mode;
logic BSCAN_PIPE_OUT_scan_out;
logic tms;
logic tck;
logic tdi;
logic trst_b;
logic shift_ir_dr;
logic tms_park_value;
logic nw_mode;
logic ijtag_reset_b;
logic ijtag_shift;
logic ijtag_capture;
logic ijtag_update;
logic ijtag_select;
logic ijtag_si;
logic tdo;
logic tdo_en;
logic ijtag_so;
logic tap_sel_out;
logic tap_sel_in;
logic DIAG_AGGR_0_mbist_diag_done;
logic NW_OUT_par_gpio_sw_to_trst;
logic NW_OUT_par_gpio_sw_to_tck;
logic NW_OUT_par_gpio_sw_to_tms;
logic NW_OUT_par_gpio_sw_to_tdi;
logic NW_OUT_par_gpio_sw_from_tdo;
logic NW_OUT_par_gpio_sw_from_tdo_en;
logic NW_OUT_par_gpio_sw_tap_sel_in;
logic NW_OUT_par_gpio_sw_ijtag_to_reset;
logic NW_OUT_par_gpio_sw_ijtag_to_tck;
logic NW_OUT_par_gpio_sw_ijtag_to_ce;
logic NW_OUT_par_gpio_sw_ijtag_to_se;
logic NW_OUT_par_gpio_sw_ijtag_to_ue;
logic NW_OUT_par_gpio_sw_ijtag_to_sel;
logic NW_OUT_par_gpio_sw_ijtag_to_si;
logic NW_OUT_par_gpio_sw_ijtag_from_so;
logic NW_OUT_par_gpio_ne_to_trst;
logic NW_OUT_par_gpio_ne_to_tck;
logic NW_OUT_par_gpio_ne_to_tms;
logic NW_OUT_par_gpio_ne_to_tdi;
logic NW_OUT_par_gpio_ne_from_tdo;
logic NW_OUT_par_gpio_ne_from_tdo_en;
logic NW_OUT_par_gpio_ne_tap_sel_in;
logic NW_OUT_par_gpio_ne_ijtag_to_reset;
logic NW_OUT_par_gpio_ne_ijtag_to_tck;
logic NW_OUT_par_gpio_ne_ijtag_to_ce;
logic NW_OUT_par_gpio_ne_ijtag_to_se;
logic NW_OUT_par_gpio_ne_ijtag_to_ue;
logic NW_OUT_par_gpio_ne_ijtag_to_sel;
logic NW_OUT_par_gpio_ne_ijtag_to_si;
logic NW_OUT_par_gpio_ne_ijtag_from_so;
logic [31:0] ssn_bus_data_in;
logic ssn_bus_clock_in;
logic [31:0] ssn_bus_data_out;
logic [31:0] par_nac_fabric3_par_gpio_sw_mux_start_bus_data_in;
logic [31:0] par_nac_fabric3_par_gpio_sw_mux_end_bus_data_out;
logic [31:0] par_nac_fabric0_mux_par_gpio_ne_in_start_bus_data_in;
logic [31:0] par_nac_fabric0_par_gpio_ne_out_end_bus_data_out;
logic BscanMux_gpio_sw_force_ip_bypass;
logic BscanMux_physs_force_ip_bypass;
logic BscanMux_GPIO_NE_force_ip_bypass;
logic BscanMux_USB_force_ip_bypass;
logic BscanMux_fabric1_force_ip_bypass;
logic BscanMux_fabric2_force_ip_bypass;
logic PCIE_PHY0_APROBE;
logic PCIE_PHY0_APROBE2;
logic PCIE_RX0_N;
logic PCIE_RX0_P;
logic PCIE_TX0_N;
logic PCIE_TX0_P;
logic PCIE_RX1_N;
logic PCIE_RX1_P;
logic PCIE_TX1_N;
logic PCIE_TX1_P;
logic PCIE_RX2_N;
logic PCIE_RX2_P;
logic PCIE_TX2_N;
logic PCIE_TX2_P;
logic PCIE_RX3_N;
logic PCIE_RX3_P;
logic PCIE_TX3_N;
logic PCIE_TX3_P;
logic  PCIE_REF_PAD_CLK0_N;
logic  PCIE_REF_PAD_CLK0_P;
logic PCIE_PHY0_GRCOMP;
logic PCIE_PHY0_GRCOMPV;
logic PCIE_PHY1_APROBE;
logic PCIE_PHY1_APROBE2;
logic PCIE_RX4_N;
logic PCIE_RX4_P;
logic PCIE_TX4_N;
logic PCIE_TX4_P;
logic PCIE_RX5_N;
logic PCIE_RX5_P;
logic PCIE_TX5_N;
logic PCIE_TX5_P;
logic PCIE_RX6_N;
logic PCIE_RX6_P;
logic PCIE_TX6_N;
logic PCIE_TX6_P;
logic PCIE_RX7_N;
logic PCIE_RX7_P;
logic PCIE_TX7_N;
logic PCIE_TX7_P;
logic  PCIE_REF_PAD_CLK1_N;
logic  PCIE_REF_PAD_CLK1_P;
logic PCIE_PHY1_GRCOMP;
logic PCIE_PHY1_GRCOMPV;
logic PCIE_PHY2_APROBE;
logic PCIE_PHY2_APROBE2;
logic PCIE_RX8_N;
logic PCIE_RX8_P;
logic PCIE_TX8_N;
logic PCIE_TX8_P;
logic PCIE_RX9_N;
logic PCIE_RX9_P;
logic PCIE_TX9_N;
logic PCIE_TX9_P;
logic PCIE_RX10_N;
logic PCIE_RX10_P;
logic PCIE_TX10_N;
logic PCIE_TX10_P;
logic PCIE_RX11_N;
logic PCIE_RX11_P;
logic PCIE_TX11_N;
logic PCIE_TX11_P;
logic  PCIE_REF_PAD_CLK2_N;
logic  PCIE_REF_PAD_CLK2_P;
logic PCIE_PHY2_GRCOMP;
logic PCIE_PHY2_GRCOMPV;
logic PCIE_PHY3_APROBE;
logic PCIE_PHY3_APROBE2;
logic PCIE_RX12_N;
logic PCIE_RX12_P;
logic PCIE_TX12_N;
logic PCIE_TX12_P;
logic PCIE_RX13_N;
logic PCIE_RX13_P;
logic PCIE_TX13_N;
logic PCIE_TX13_P;
logic PCIE_RX14_N;
logic PCIE_RX14_P;
logic PCIE_TX14_N;
logic PCIE_TX14_P;
logic PCIE_RX15_N;
logic PCIE_RX15_P;
logic PCIE_TX15_N;
logic PCIE_TX15_P;
logic  PCIE_REF_PAD_CLK3_N;
logic  PCIE_REF_PAD_CLK3_P;
logic PCIE_PHY3_GRCOMP;
logic PCIE_PHY3_GRCOMPV;
logic [31:0] cfio_paddr;
logic cfio_penable;
logic cfio_pwrite;
logic [31:0] cfio_pwdata;
logic [2:0] cfio_pprot;
logic [3:0] cfio_pstrb;
logic cfio_psel;
logic [31:0] cfio_prdata;
logic cfio_pready;
logic cfio_pslverr;
logic [31:0] i_nmf_t_cnic_physs_gpio_paddr;
logic i_nmf_t_cnic_physs_gpio_penable;
logic i_nmf_t_cnic_physs_gpio_pwrite;
logic [31:0] i_nmf_t_cnic_physs_gpio_pwdata;
logic [2:0] i_nmf_t_cnic_physs_gpio_pprot;
logic [3:0] i_nmf_t_cnic_physs_gpio_pstrb;
logic i_nmf_t_cnic_physs_gpio_psel_0;
logic [31:0] i_nmf_t_cnic_physs_gpio_prdata_0;
logic i_nmf_t_cnic_physs_gpio_pready_0;
logic i_nmf_t_cnic_physs_gpio_pslverr_0;
logic XX_SPI_CLK;
logic [3:0] XX_SPI_OE_N;
logic [3:0] XX_SPI_TXD;
logic [3:0] XX_SPI_RXD;
logic XX_SPI_CS0_N;
logic XX_SPI_CS1_N;
logic XX_I2C_SCL0;
logic XX_I2C_SCL1;
logic XX_I2C_SCL2;
logic XX_I2C_SCL4;
logic XX_I2C_SCL5;
logic XX_I2C_SCL6;
logic XX_I2C_SCL7;
logic [7:0] nss_i2c_clk_oe_n;
logic XX_I2C_SDA0;
logic XX_I2C_SDA1;
logic XX_I2C_SDA2;
logic XX_I2C_SDA4;
logic XX_I2C_SDA5;
logic XX_I2C_SDA6;
logic XX_I2C_SDA7;
logic [7:0] nss_i2c_data_oe_n;
logic i2c_smbalert_in_n;
logic FNIC_SVID_CLK;
logic FNIC_SVID_DATA;
logic nsc_ready_for_enum;
logic i2c_smbalert_oe_n;
logic  EUSB2_EDM;
logic  EUSB2_EDP;
logic  EUSB2_RESREF;
logic  EUSB2_ANALOGTEST;
//logic  EUSB2_VBUS_VALID_EXT;
logic ETH_TXP0;
logic ETH_TXN0;
logic ETH_TXP1;
logic ETH_TXN1;
logic ETH_TXP2;
logic ETH_TXN2;
logic ETH_TXP3;
logic ETH_TXN3;
logic ETH_TXP4;
logic ETH_TXN4;
logic ETH_TXP5;
logic ETH_TXN5;
logic ETH_TXP6;
logic ETH_TXN6;
logic ETH_TXP7;
logic ETH_TXN7;
logic ETH_RXP0;
logic ETH_RXN0;
logic ETH_RXP1;
logic ETH_RXN1;
logic ETH_RXP2;
logic ETH_RXN2;
logic ETH_RXP3;
logic ETH_RXN3;
logic ETH_RXP4;
logic ETH_RXN4;
logic ETH_RXP5;
logic ETH_RXN5;
logic ETH_RXP6;
logic ETH_RXN6;
logic ETH_RXP7;
logic ETH_RXN7;
logic ETH_TXP8;
logic ETH_TXN8;
logic ETH_TXP9;
logic ETH_TXN9;
logic ETH_TXP10;
logic ETH_TXN10;
logic ETH_TXP11;
logic ETH_TXN11;
logic ETH_TXP12;
logic ETH_TXN12;
logic ETH_TXP13;
logic ETH_TXN13;
logic ETH_TXP14;
logic ETH_TXN14;
logic ETH_TXP15;
logic ETH_TXN15;
logic ETH_RXP8;
logic ETH_RXN8;
logic ETH_RXP9;
logic ETH_RXN9;
logic ETH_RXP10;
logic ETH_RXN10;
logic ETH_RXP11;
logic ETH_RXN11;
logic ETH_RXP12;
logic ETH_RXN12;
logic ETH_RXP13;
logic ETH_RXN13;
logic ETH_RXP14;
logic ETH_RXN14;
logic ETH_RXP15;
logic ETH_RXN15;
logic [15:0] xioa_ck_pma_ref0_n;
logic [15:0] xioa_ck_pma_ref0_p;
logic [13:0] xioa_ck_pma_ref1_n;
logic [13:0] xioa_ck_pma_ref1_p;
logic [15:0] xoa_pma_dcmon1;
logic [15:0] xoa_pma_dcmon2;
//logic nac_a0_debug_strap_0;
logic SPARE_B1;
logic SPARE_B2;
logic SPARE_B3;
logic [2:0] axi2sb_gpsb_side_ism_fabric;
logic [2:0] axi2sb_gpsb_side_ism_agent;
logic axi2sb_gpsb_side_pok;
logic axi2sb_gpsb_mnpput;
logic axi2sb_gpsb_mpcput;
logic axi2sb_gpsb_mnpcup;
logic axi2sb_gpsb_mpccup;
logic axi2sb_gpsb_meom;
logic [31:0] axi2sb_gpsb_mpayload;
logic axi2sb_gpsb_mparity;
logic axi2sb_gpsb_tnpput;
logic axi2sb_gpsb_tpcput;
/*
logic axi2sb_gpsb_tnpcup;
logic axi2sb_gpsb_tpccup;
logic axi2sb_gpsb_teom;
logic [31:0] axi2sb_gpsb_tpayload;
logic axi2sb_gpsb_tparity;
logic [15:0] axi2sb_gpsb_strap_sourceid;
logic axi2sb_gpsb_strap_bridge_disable;
logic [2:0] axi2sb_pmsb_side_ism_fabric;
logic [2:0] axi2sb_pmsb_side_ism_agent;
logic axi2sb_pmsb_side_pok;
logic axi2sb_pmsb_mnpput;
logic axi2sb_pmsb_mpcput;
logic axi2sb_pmsb_mnpcup;
logic axi2sb_pmsb_mpccup;
logic axi2sb_pmsb_meom;
logic [31:0] axi2sb_pmsb_mpayload;
logic axi2sb_pmsb_mparity;
logic axi2sb_gpsb_tnpput;
logic axi2sb_gpsb_tpcput;
*/

logic axi2sb_gpsb_tnpcup;
logic axi2sb_gpsb_tpccup;
logic axi2sb_gpsb_teom;
logic [31:0] axi2sb_gpsb_tpayload;
logic axi2sb_gpsb_tparity;
logic [15:0] axi2sb_gpsb_strap_sourceid;
//logic axi2sb_gpsb_strap_bridge_disable;
logic [2:0] axi2sb_pmsb_side_ism_fabric;
logic [2:0] axi2sb_pmsb_side_ism_agent;
logic axi2sb_pmsb_side_pok;
logic axi2sb_pmsb_mnpput;
logic axi2sb_pmsb_mpcput;
logic axi2sb_pmsb_mnpcup;
logic axi2sb_pmsb_mpccup;
logic axi2sb_pmsb_meom;
logic [31:0] axi2sb_pmsb_mpayload;
logic axi2sb_pmsb_mparity;
logic axi2sb_pmsb_tnpput;
logic axi2sb_pmsb_tpcput;
logic axi2sb_pmsb_tnpcup;
logic axi2sb_pmsb_tpccup;
logic axi2sb_pmsb_teom;
logic [31:0] axi2sb_pmsb_tpayload;
logic axi2sb_pmsb_tparity;
logic [15:0] axi2sb_pmsb_strap_sourceid;
logic [7:0] axi2sb_pmsb_strap_sai_pmsb_default;
//logic axi2sb_pmsb_strap_bridge_disable;
logic XX_SYNCE_CLKOUT0;
logic XX_SYNCE_CLKOUT1;
logic boot_pll_adapt_rstw_resource_ready;
logic nac_ss_debug_ecm_monout_cp_ana [1:0];
logic XX_OPAD_SENSE_0p9;
logic [63:0] s3m_time;
logic XX_UART_HMP_TXD;
logic XX_UART_HMP_RXD;
logic XX_UART_HIF_TXD;
logic XX_UART_HIF_RXD;
logic XX_UART_USB_TXD;
logic XX_UART_USB_RXD;
logic XX_DEBUG_ACT_N;
logic ecm_boot_done;
logic [31:0] nss_gpio_in;
//logic nss_gpio_nichot_b;
logic [31:0] nss_gpio_oe_n;
logic [31:0] nss_gpio_out;
logic XX_PCIE0_PERST_N0;
logic XX_PCIE0_PERST_N1;
logic XX_PCIE0_PERST_N2;
logic XX_PCIE0_PERST_N3;
logic XX_MDIO_CLK;
logic XX_MDIO_IN;
logic XX_MDIO_OEN;
logic XX_MDIO_OUT;
logic [0:0] XX_ONE_PPS_OUT;
logic XX_UART_PHYSS_RXD;
logic XX_UART_PHYSS_TXD;
logic XX_NCSI_CLK;
logic XX_NCSI_CRS_DV;
logic XX_NCSI_RX_ENB;
logic XX_NCSI_RX_EN_B;
logic XX_NCSI_TX_EN;
logic XX_NCSI_RXD0;
logic XX_NCSI_RXD1;
logic XX_NCSI_TXD0;
logic XX_NCSI_TXD1;
logic XX_NCSI_ARB_IN;
logic XX_NCSI_ARB_OUT;
logic XX_SDP_TIMESYNC_3;
logic sn2sfi_rst_pre_ind_n;
logic reset_cmd_ack;
logic reset_error;
logic warm_rst_qactive;
logic warm_rst_qdeny;
logic warm_rst_qacceptn;
logic warm_rst_qreqn;
logic rsrc_adapt_nac_dts0_fsa_rst_b;
logic rsrc_adapt_nac_dts1_fsa_rst_b;
logic rsrc_adapt_nac_dts2_fsa_rst_b;
logic rsrc_adapt_bootpll_fsa_rst_b;
logic rsrc_adapt_tspll_fsa_rst_b;
logic rsrc_adapt_nsspll_fsa_rst_b;
logic rsrc_adapt_ethphysspll_fsa_rst_b;
logic cmulbuf_buttr_fsa_rst_b;
logic cmulbuf_phy_ss_buttr_fsa_rst_b;
logic apb2iosfsb_in_mnpput;
logic apb2iosfsb_in_mpcput;
logic apb2iosfsb_in_meom;
logic [7:0] apb2iosfsb_in_mpayload;
logic apb2iosfsb_in_mparity;
logic apb2iosfsb_in_tnpcup;
logic apb2iosfsb_in_tpccup;
logic [2:0] apb2iosfsb_in_side_ism_agent;
logic apb2iosfsb_in_pok;
logic apb2iosfsb_in_mnpcup;
logic apb2iosfsb_in_mpccup;
logic apb2iosfsb_in_tnpput;
logic apb2iosfsb_in_tpcput;
logic apb2iosfsb_in_teom;
logic [7:0] apb2iosfsb_in_tpayload;
logic apb2iosfsb_in_tparity;
logic [2:0] apb2iosfsb_in_side_ism_fabric;
logic apb2iosfsb_out_mnpcup;
logic apb2iosfsb_out_mpccup;
logic apb2iosfsb_out_tnpput;
logic apb2iosfsb_out_tpcput;
logic apb2iosfsb_out_teom;
logic [7:0] apb2iosfsb_out_tpayload;
logic apb2iosfsb_out_tparity;
logic [2:0] apb2iosfsb_out_side_ism_fabric;
logic apb2iosfsb_out_mnpput;
logic apb2iosfsb_out_mpcput;
logic apb2iosfsb_out_meom;
logic [7:0] apb2iosfsb_out_mpayload;
logic apb2iosfsb_out_mparity;
logic apb2iosfsb_out_tnpcup;
logic apb2iosfsb_out_tpccup;
logic [2:0] apb2iosfsb_out_side_ism_agent;
logic apb2iosfsb_out_pok;
logic gpio_ne_1p8_in_mnpput;
logic gpio_ne_1p8_in_mpcput;
logic gpio_ne_1p8_in_meom;
logic [7:0] gpio_ne_1p8_in_mpayload;
logic gpio_ne_1p8_in_mparity;
logic gpio_ne_1p8_in_tnpcup;
logic gpio_ne_1p8_in_tpccup;
logic [2:0] gpio_ne_1p8_in_side_ism_agent;
logic gpio_ne_1p8_in_pok;
logic gpio_ne_1p8_in_mnpcup;
logic gpio_ne_1p8_in_mpccup;
logic gpio_ne_1p8_in_tnpput;
logic gpio_ne_1p8_in_tpcput;
logic gpio_ne_1p8_in_teom;
logic [7:0] gpio_ne_1p8_in_tpayload;
logic gpio_ne_1p8_in_tparity;
logic [2:0] gpio_ne_1p8_in_side_ism_fabric;
logic gpio_ne_1p8_out_mnpcup;
logic gpio_ne_1p8_out_mpccup;
logic gpio_ne_1p8_out_tnpput;
logic gpio_ne_1p8_out_tpcput;
logic gpio_ne_1p8_out_teom;
logic [7:0] gpio_ne_1p8_out_tpayload;
logic gpio_ne_1p8_out_tparity;
logic [2:0] gpio_ne_1p8_out_side_ism_fabric;
logic gpio_ne_1p8_out_mnpput;
logic gpio_ne_1p8_out_mpcput;
logic gpio_ne_1p8_out_meom;
logic [7:0] gpio_ne_1p8_out_mpayload;
logic gpio_ne_1p8_out_mparity;
logic gpio_ne_1p8_out_tnpcup;
logic gpio_ne_1p8_out_tpccup;
logic [2:0] gpio_ne_1p8_out_side_ism_agent;
logic gpio_ne_1p8_out_pok;
logic sfi_tx_link_txcon_req;
logic sfi_tx_link_rxcon_ack;
logic sfi_tx_link_rxdiscon_nack;
logic sfi_tx_link_rx_empty;
logic sfi_rx_link_txcon_req;
logic sfi_rx_link_rxcon_ack;
logic sfi_rx_link_rxdiscon_nack;
logic sfi_rx_link_rx_empty;
logic [0:0] sfi_tx_hdr_valid;
logic sfi_tx_hdr_early_valid;
logic sfi_tx_hdr_block;
logic [255:0] sfi_tx_hdr_header;
logic [15:0] sfi_tx_hdr_info_bytes;
logic sfi_tx_hdr_crd_rtn_valid;
logic sfi_tx_hdr_crd_rtn_ded;
logic [1:0] sfi_tx_hdr_crd_rtn_fc_id;
logic [4:0] sfi_tx_hdr_crd_rtn_vc_id;
logic [3:0] sfi_tx_hdr_crd_rtn_value;
logic sfi_tx_hdr_crd_rtn_block;
logic [0:0] sfi_rx_hdr_valid;
logic sfi_rx_hdr_early_valid;
logic sfi_rx_hdr_block;
logic [255:0] sfi_rx_header;
logic [15:0] sfi_rx_hdr_info_bytes;
logic sfi_rx_hdr_crd_rtn_valid;
logic sfi_rx_hdr_crd_rtn_ded;
logic [1:0] sfi_rx_hdr_crd_rtn_fc_id;
logic [4:0] sfi_rx_hdr_crd_rtn_vc_id;
logic [3:0] sfi_rx_hdr_crd_rtn_value;
logic sfi_rx_hdr_crd_rtn_block;
logic sfi_tx_data_valid;
logic sfi_tx_data_early_valid;
logic sfi_tx_data_block;
logic [1023:0] sfi_tx_data;
logic [15:0] sfi_tx_data_parity;
logic [0:0] sfi_tx_data_start;
logic [7:0] sfi_tx_data_info_byte;
logic [31:0] sfi_tx_data_end;
logic [31:0] sfi_tx_data_poison;
logic [31:0] sfi_tx_data_edb;
logic sfi_tx_data_aux_parity;
logic sfi_tx_data_crd_rtn_valid;
logic sfi_tx_data_crd_rtn_ded;
logic [1:0] sfi_tx_data_crd_rtn_fc_id;
logic [4:0] sfi_tx_data_crd_rtn_vc_id;
logic [3:0] sfi_tx_data_crd_rtn_value;
logic sfi_tx_data_crd_rtn_block;
logic sfi_rx_data_valid;
logic sfi_rx_data_early_valid;
logic sfi_rx_data_block;
logic [1023:0] sfi_rx_data;
logic [15:0] sfi_rx_data_parity;
logic [0:0] sfi_rx_data_start;
logic [7:0] sfi_rx_data_info_byte;
logic [31:0] sfi_rx_data_end;
logic [31:0] sfi_rx_data_poison;
logic [31:0] sfi_rx_data_edb;
logic sfi_rx_data_aux_parity;
logic sfi_rx_data_crd_rtn_valid;
logic sfi_rx_data_crd_rtn_ded;
logic [1:0] sfi_rx_data_crd_rtn_fc_id;
logic [4:0] sfi_rx_data_crd_rtn_vc_id;
logic [3:0] sfi_rx_data_crd_rtn_value;
logic sfi_rx_data_crd_rtn_block;
logic iosf2sfi_iosf_side_pok;
logic [2:0] iosf2sfi_sb_side_ism_fabric;
logic [2:0] iosf2sfi_sb_side_ism_agent;
logic iosf2sfi_sb_mnpput;
logic iosf2sfi_sb_mpcput;
logic iosf2sfi_sb_mnpcup;
logic iosf2sfi_sb_mpccup;
logic iosf2sfi_sb_meom;
logic [7:0] iosf2sfi_sb_mpayload;
logic iosf2sfi_sb_tnpput;
logic iosf2sfi_sb_tpcput;
logic iosf2sfi_sb_tnpcup;
logic iosf2sfi_sb_tpccup;
logic iosf2sfi_sb_teom;
logic [7:0] iosf2sfi_sb_tpayload;
logic sn2iosf_side_pok;
logic [2:0] sn2iosf_sb_side_ism_fabric;
logic [2:0] sn2iosf_sb_side_ism_agent;
logic sn2iosf_sb_mpccup;
logic sn2iosf_sb_mnpcup;
logic sn2iosf_sb_mpcput;
logic sn2iosf_sb_mnpput;
logic sn2iosf_sb_meom;
logic [7:0] sn2iosf_sb_mpayload;
logic sn2iosf_sb_tpccup;
logic sn2iosf_sb_tnpcup;
logic sn2iosf_sb_tpcput;
logic sn2iosf_sb_tnpput;
logic sn2iosf_sb_teom;
logic [7:0] sn2iosf_sb_tpayload;




logic 	        prim_clk;
logic 	        side_clk;
logic 	        perst;
logic 	        pdeb_pcie_perst_n;
logic 	        tosw_pcie_perst_n;
logic 	        frsw_pcie_perst_n;





//prim clk from design
`ifndef HLP_PHYSS_ONLY
assign prim_clk = nac_ss.par_sn2sfi.sn2sfi.i_sn2iosf_wrapper.iosf_prim_clk;
assign side_clk = nac_ss.par_sn2sfi.sn2sfi.i_sn2iosf_wrapper.iosf_side_clk;


//loop back perst
assign tosw_pcie_perst_n = pdeb_pcie_perst_n;
assign perst             = ~frsw_pcie_perst_n;

`include "fpga_generic_transactor_inst.sv"
`endif


 // Emulation clocks:
   wire                core_clk;
   wire                div_2_clk;
   wire                div_4_clk;
   wire                div_8_clk;
   wire                div_16_clk;
   wire                div_32_clk;
   wire                div8_div5_clk;//div40





 // boot pll
fpga_chs_car0  nsc_veloce_pll_inst(

.global_clock     (ephy_refclk),//20MHz
.global_reset_n   (sys_rst_n),
.gclk1_div2       (core_clk), //900MHz 10MHz imc_core_clk, nss_fxp_clk, nss_lan_clk(750MHz), sn2sfi(1000MHz)
.gclk1_div4       (div_2_clk), //450MHz 5MHz  imc_sys_clk ,imc_dfd_clk, nac_dap_clk, nss_psm_clk(529.41)
.gclk1_div8       (div_4_clk), //250MHz 4MHz  soc_tsgen_clk , ssi_clk(200MHz)
.gclk1_div16      (div_8_clk), //112.5 2.5MHz soc_per_clk, pclk, nac_tpiu_clk,core_clk(250MHz)
.gclk1_div32      (div_16_clk), //50MHz 1.25MHz 
.gclk1_div64      (div_32_clk), //50MHz 1.25MHz 
.gclk1_div40      (div8_div5_clk) //20MHz uart_ref_clk
);
//Lokesh: Veloce forces and assign
`include "nsc_assign.sv"
`include "nsc_force_dynamic.sv"
`include "nsc_force_static.sv"
//Apeksha : Added to move all tcam parameter and clock forces to single file
`include "tcam_def_forces.sv"

//CNIC/NAC level
//clock and assignment
initial
begin
//Reset assignment	
//Lokesh:This drives all NSS IPs powergood and cause optimization so driving
//from top
//force nac_ss.nss.nmc_top.aon_powergood = sys_rst_n;
//force nac_ss.nss.cnic_early_boot_reset_n = sys_rst_n;
//These are unconnected at NSS level and need to be forced from NAC level
//R13 force nac_ss.nss.nmc_top.imc_dbg_rst_n = sys_rst_n;
//R13 force nac_ss.nss.nmc_top.imc_zeroize_cpu_rst_n = sys_rst_n;
//R13 force nac_ss.nss.nmc_top.sys_cntr_count_in = nac_ss.nss.nmc_top.sys_cntr_count_out;
//clock assignment
//NSS CLOCK assignment
force nac_ss.nss.aonclk1x = div8_div5_clk; //This drives UART clk
force nac_ss.nss.aonclk5x = div_8_clk;

//force nac_ss.nss.i2c_clk_in[7:0] //required in op5 and op8 but not used, check apeksha
//apeksha added below for op8

force nac_ss.nss.nss_cosq_clk = core_clk;
//force nac_ss.nss.nsc_bisr_clk = core_clk; //check if required apeksha
force nac_ss.nss.nss_cosq_fnic_clk = core_clk;
force nac_ss.nss.nlf_scpd_clk = core_clk;

// =======================================

force nac_ss.nss.imc_core_clk = core_clk; 
force nac_ss.nss.imc_sys_clk = div_2_clk; //this is spi_clk. SPI soft modules need to be more than 2x spi DUT Clock. Connecting 
force nac_ss.nss.mt_clk = core_clk; //apeksha check mt_clk_800
force nac_ss.nss.mt_dist_clk = div_2_clk;
force nac_ss.nss.ncsi_clk = div_4_clk;
force nac_ss.nss.nss_core_clk = core_clk;
force nac_ss.nss.nss_fxp_clk = core_clk;
force nac_ss.nss.nss_hif_clk = core_clk;
// apeksha force nac_ss.nss.nss_hlp_clk = core_clk;
force nac_ss.nss.nss_lan_clk = core_clk;
force nac_ss.nss.nss_psm_clk = div_2_clk;
force nac_ss.nss.nss_sep_clk = div_2_clk;
// apeksha force nac_ss.nss.physs_func_clk = core_clk;
force nac_ss.nss.physs_intf0_clk = core_clk;
force nac_ss.nss.s3m_cnt_clk = div_8_clk;
force nac_ss.nss.soc_nlf_clk = core_clk;
force nac_ss.nss.soc_per_clk = core_clk;
force nac_ss.nss.soc_tsgen_clk = core_clk;
//force nac_ss.nss.ssn_clk = div_2_clk; removed in R18
//force nac_ss.nss.uart_ref_clk = core_clk;
force nac_ss.nss.utmi_clk = div_2_clk;
//DFX clock
//force nac_ss.nss.soc_dfd_clk = div_32_clk;
//force nac_ss.nss.imc_dfd_atclk = div_32_clk;
//force nac_ss.nss.nlf_atb_clk = core_clk;
//force nac_ss.nss.nss_dtf_clk = div_32_clk;
force nac_ss.nss.ecm_clk = core_clk;
//apeksha force nac_ss.nss.physs_func_x2_clk = core_clk;
// apeksha force nac_ss.nss.nss_hlp_sw_clk = core_clk;
//force nac_ss.nss.nss_sn2sfi_clk = core_clk;
force nac_ss.nss.nss_sn2sfi_clk =sfi_clk_1g_in ;
////force nac_ss.par_sn2sfi.sn2sfi.sn2sfi_clk = sfi_clk_1g_in;
////force nac_ss.par_sn2sfi.sfi_clk_1g_in = sfi_clk_1g_in;
////force nac_ss.par_sn2sfi.sn2sfi.i_sn2iosf_wrapper.sfi_clk = sfi_clk_1g_in;
`ifndef HLP_PHYSS_STUB
`ifndef NAC_STUB
`ifndef NMC_ONLY
//HLP CLOCK assignment
//HLP physs clocks and reset in nac
force nac_ss.hlp.pgcb_clk = core_clk; //apeksha check
force nac_ss.hlp.aclk_s = core_clk;//xtalclk ;
force nac_ss.hlp.dtf_clk = core_clk;//xtalclk ;
force nac_ss.hlp.ports_clk = core_clk;//xtalclk ;
force nac_ss.hlp.switch_clk = core_clk;//xtalclk ;
//force nac_ss.hlp.tsu_clk = core_clk;//xtalclk ;
force nac_ss.hlp.hlp_rst_b = sys_rst_n;
//force nac_ss.hlp.powergood_rst_b = sys_rst_n; //apeksha check if required,
//physs clks from par_nac_misc
// removed in r15 force nac_ss.physs.physs_func_clk = core_clk;//CLK_EREF0_P;
force nac_ss.physs.rclk_diff_p = core_clk;//xtalclk ; 
force nac_ss.physs.rclk_diff_n = core_clk;//xtalclk ;
force nac_ss.physs.soc_per_clk = core_clk;//CLK_EREF0_P  ;
force nac_ss.physs.physs_intf0_clk = core_clk;//CLK_EREF0_P  ;
force nac_ss.physs.physs_funcx2_clk = core_clk;//CLK_EREF0_P  ; 
//removed in r15 force nac_ss.physs.physs_func_clk = core_clk;//CLK_EREF0_P  ;
//removed in r15 fforce nac_ss.physs.timeref_clk = core_clk;//CLK_EREF0_P   ;
//newly added in r15
force nac_ss.physs.tsu_clk = core_clk ;//todo
force nac_ss.physs.nss_cosq_clk0 = core_clk;
force nac_ss.physs.nss_cosq_clk1 = core_clk;
force nac_ss.physs.clk_1588_freq = core_clk;//1588_freq_out generated from NSS.MTS module from CPK. Muxed with recovered serdes clks to output on synce_rxclk[1:0]
`endif
`endif
`endif
end //end of initial block


nac_ss #( .SB_MAXPLD_WIDTH_1  (7))
nac_ss
(
.nac_ss_spare_in (nac_ss_spare_in),
.nac_ss_spare_out (nac_ss_spare_out),
.xtalclk (xtalclk),
.rstbus_clk (xtalclk),
.infra_clk (xtalclk),
.croclk (xtalclk),
.time_ref_clk_cmos (time_ref_clk_cmos),
.XX_SYS_REFCLK (XX_SYS_REFCLK),
.CLK_EREF0_P (CLK_EREF0_P),
.CLK_EREF0_N (CLK_EREF0_N),
.CLKREF_SYNCE_P (CLKREF_SYNCE_P),
.CLKREF_SYNCE_N (CLKREF_SYNCE_N),
.bclk1 (xtalclk),
.cmlclkout_p_ana (xtalclk),
.cmlclkout_n_ana (xtalclk),
.cmlbuf_valid_dig (cmlbuf_valid_dig),
.dfd_dop_enable (1'b0),
.fdfx_security_policy (fdfx_security_policy),
.fdfx_policy_update (fdfx_policy_update),
.fdfx_earlyboot_debug_exit (fdfx_earlyboot_debug_exit),
.fdfx_debug_capabilities_enabling (fdfx_debug_capabilities_enabling),
.fdfx_debug_capabilities_enabling_valid (fdfx_debug_capabilities_enabling_valid),
.pll_oa_fusa_comb_error (pll_oa_fusa_comb_error),
.nac_vccana_vccs5_iso_ctrl_b (nac_vccana_vccs5_iso_ctrl_b),
.BOOT_MODE_STRAP (BOOT_MODE_STRAP),
.BID (BID),
.PLL_REF_SEL0_STRAP (PLL_REF_SEL0_STRAP),
.PLL_REF_SEL1_STRAP (PLL_REF_SEL1_STRAP),
.TIME_REF_SEL_STRAP (TIME_REF_SEL_STRAP),
.XX_BIST_ENABLE (1'b0),
.axi2sb_strap_sai_secure (axi2sb_strap_sai_secure),
.axi2sb_strap_sai_nonsec (axi2sb_strap_sai_nonsec),
.axi2sb_strap_policy1_cp_default (axi2sb_strap_policy1_cp_default),
.axi2sb_strap_policy1_rac_default (axi2sb_strap_policy1_rac_default),
.axi2sb_strap_policy1_wac_default (axi2sb_strap_policy1_wac_default),
.axi2sb_strap_policy2_cp_default (axi2sb_strap_policy2_cp_default),
.axi2sb_strap_policy2_rac_default (axi2sb_strap_policy2_rac_default),
.axi2sb_strap_policy2_wac_default (axi2sb_strap_policy2_wac_default),
.axi2sb_strap_policy3_cp_default (axi2sb_strap_policy3_cp_default),
.axi2sb_strap_policy3_rac_default (axi2sb_strap_policy3_rac_default),
.axi2sb_strap_policy3_wac_default (axi2sb_strap_policy3_wac_default),
.axi2sb_strap_secure_sai_lut_default (axi2sb_strap_secure_sai_lut_default),
.axi2sb_strap_cgid_sai_lut_default (axi2sb_strap_cgid_sai_lut_default),
.axi2sb_strap_dfd_cgid_default (axi2sb_strap_dfd_cgid_default),
.axi2sb_strap_infra_cgid_default (axi2sb_strap_infra_cgid_default),
.clockss_boot_pll_iosf_sb_ism_fabric (clockss_boot_pll_iosf_sb_ism_fabric),
.clockss_boot_pll_iosf_sb_ism_agent (clockss_boot_pll_iosf_sb_ism_agent),
.clockss_boot_pll_iosf_sb_side_pok (clockss_boot_pll_iosf_sb_side_pok),
.clockss_boot_pll_iosf_sb_mnpput (clockss_boot_pll_iosf_sb_mnpput),
.clockss_boot_pll_iosf_sb_mpcput (clockss_boot_pll_iosf_sb_mpcput),
.clockss_boot_pll_iosf_sb_mnpcup (clockss_boot_pll_iosf_sb_mnpcup),
.clockss_boot_pll_iosf_sb_mpccup (clockss_boot_pll_iosf_sb_mpccup),
.clockss_boot_pll_iosf_sb_meom (clockss_boot_pll_iosf_sb_meom),
.clockss_boot_pll_iosf_sb_mpayload (clockss_boot_pll_iosf_sb_mpayload),
.clockss_boot_pll_iosf_sb_tnpput (clockss_boot_pll_iosf_sb_tnpput),
.clockss_boot_pll_iosf_sb_tpcput (clockss_boot_pll_iosf_sb_tpcput),
.clockss_boot_pll_iosf_sb_tnpcup (clockss_boot_pll_iosf_sb_tnpcup),
.clockss_boot_pll_iosf_sb_tpccup (clockss_boot_pll_iosf_sb_tpccup),
.clockss_boot_pll_iosf_sb_teom (clockss_boot_pll_iosf_sb_teom),
.clockss_boot_pll_iosf_sb_tpayload (clockss_boot_pll_iosf_sb_tpayload),
.sfi_clk_1g (sfi_clk_1g),
.sfi_clk_1g_in (sfi_clk_1g_in),
.XX_NCSI_CLK_OUT (XX_NCSI_CLK_OUT),
.XX_RGMII_CLK_OUT (XX_RGMII_CLK_OUT),
.nac_ss_apb_112p5_clk (nac_ss_apb_112p5_clk),
.nac_ss_apb_112p5_physs_clk (nac_ss_apb_112p5_physs_clk),
.hvm_clk_sel_cnic (1'b0),
.cltap_hvm_ctrl_reg (6'b0),
.clockss_nss_pll_iosf_sb_ism_fabric (clockss_nss_pll_iosf_sb_ism_fabric),
.clockss_nss_pll_iosf_sb_ism_agent (clockss_nss_pll_iosf_sb_ism_agent),
.clockss_nss_pll_iosf_sb_side_pok (clockss_nss_pll_iosf_sb_side_pok),
.clockss_nss_pll_iosf_sb_mnpput (clockss_nss_pll_iosf_sb_mnpput),
.clockss_nss_pll_iosf_sb_mpcput (clockss_nss_pll_iosf_sb_mpcput),
.clockss_nss_pll_iosf_sb_mnpcup (clockss_nss_pll_iosf_sb_mnpcup),
.clockss_nss_pll_iosf_sb_mpccup (clockss_nss_pll_iosf_sb_mpccup),
.clockss_nss_pll_iosf_sb_meom (clockss_nss_pll_iosf_sb_meom),
.clockss_nss_pll_iosf_sb_mpayload (clockss_nss_pll_iosf_sb_mpayload),
.clockss_nss_pll_iosf_sb_tnpput (clockss_nss_pll_iosf_sb_tnpput),
.clockss_nss_pll_iosf_sb_tpcput (clockss_nss_pll_iosf_sb_tpcput),
.clockss_nss_pll_iosf_sb_tnpcup (clockss_nss_pll_iosf_sb_tnpcup),
.clockss_nss_pll_iosf_sb_tpccup (clockss_nss_pll_iosf_sb_tpccup),
.clockss_nss_pll_iosf_sb_teom (clockss_nss_pll_iosf_sb_teom),
.clockss_nss_pll_iosf_sb_tpayload (clockss_nss_pll_iosf_sb_tpayload),
.clockss_ts_pll_iosf_sb_ism_fabric (clockss_ts_pll_iosf_sb_ism_fabric),
.clockss_ts_pll_iosf_sb_ism_agent (clockss_ts_pll_iosf_sb_ism_agent),
.clockss_ts_pll_iosf_sb_side_pok (clockss_ts_pll_iosf_sb_side_pok),
.clockss_ts_pll_iosf_sb_mnpput (clockss_ts_pll_iosf_sb_mnpput),
.clockss_ts_pll_iosf_sb_mpcput (clockss_ts_pll_iosf_sb_mpcput),
.clockss_ts_pll_iosf_sb_mnpcup (clockss_ts_pll_iosf_sb_mnpcup),
.clockss_ts_pll_iosf_sb_mpccup (clockss_ts_pll_iosf_sb_mpccup),
.clockss_ts_pll_iosf_sb_meom (clockss_ts_pll_iosf_sb_meom),
.clockss_ts_pll_iosf_sb_mpayload (clockss_ts_pll_iosf_sb_mpayload),
.clockss_ts_pll_iosf_sb_tnpput (clockss_ts_pll_iosf_sb_tnpput),
.clockss_ts_pll_iosf_sb_tpcput (clockss_ts_pll_iosf_sb_tpcput),
.clockss_ts_pll_iosf_sb_tnpcup (clockss_ts_pll_iosf_sb_tnpcup),
.clockss_ts_pll_iosf_sb_tpccup (clockss_ts_pll_iosf_sb_tpccup),
.clockss_ts_pll_iosf_sb_teom (clockss_ts_pll_iosf_sb_teom),
.clockss_ts_pll_iosf_sb_tpayload (clockss_ts_pll_iosf_sb_tpayload),
.mt_clk_800 (mt_clk_800),
.time_sync_loop_back_pps_sel (time_sync_loop_back_pps_sel),
.time_sync_input_mode_sel (time_sync_input_mode_sel),
.clkss_cmlbuf_iosf_sb_intf_MNPCUP (clkss_cmlbuf_iosf_sb_intf_MNPCUP),
.clkss_cmlbuf_iosf_sb_intf_MPCCUP (clkss_cmlbuf_iosf_sb_intf_MPCCUP),
.clkss_cmlbuf_iosf_sb_intf_SIDE_ISM_FABRIC (clkss_cmlbuf_iosf_sb_intf_SIDE_ISM_FABRIC),
.clkss_cmlbuf_iosf_sb_intf_TEOM (clkss_cmlbuf_iosf_sb_intf_TEOM),
.clkss_cmlbuf_iosf_sb_intf_TNPPUT (clkss_cmlbuf_iosf_sb_intf_TNPPUT),
.clkss_cmlbuf_iosf_sb_intf_TPAYLOAD (clkss_cmlbuf_iosf_sb_intf_TPAYLOAD),
.clkss_cmlbuf_iosf_sb_intf_TPCPUT (clkss_cmlbuf_iosf_sb_intf_TPCPUT),
.clkss_cmlbuf_iosf_sb_intf_MEOM (clkss_cmlbuf_iosf_sb_intf_MEOM),
.clkss_cmlbuf_iosf_sb_intf_MNPPUT (clkss_cmlbuf_iosf_sb_intf_MNPPUT),
.clkss_cmlbuf_iosf_sb_intf_MPAYLOAD (clkss_cmlbuf_iosf_sb_intf_MPAYLOAD),
.clkss_cmlbuf_iosf_sb_intf_MPCPUT (clkss_cmlbuf_iosf_sb_intf_MPCPUT),
.clkss_cmlbuf_iosf_sb_intf_SIDE_ISM_AGENT (clkss_cmlbuf_iosf_sb_intf_SIDE_ISM_AGENT),
.clkss_cmlbuf_iosf_sb_intf_TNPCUP (clkss_cmlbuf_iosf_sb_intf_TNPCUP),
.clkss_cmlbuf_iosf_sb_intf_TPCCUP (clkss_cmlbuf_iosf_sb_intf_TPCCUP),
.clkss_cmlbuf_sideband_pok (clkss_cmlbuf_sideband_pok),
.clkss_cmlbuf_phy_ss_iosf_sb_intf_MNPCUP (clkss_cmlbuf_phy_ss_iosf_sb_intf_MNPCUP),
.clkss_cmlbuf_phy_ss_iosf_sb_intf_MPCCUP (clkss_cmlbuf_phy_ss_iosf_sb_intf_MNPCUP),
.clkss_cmlbuf_phy_ss_iosf_sb_intf_SIDE_ISM_FABRIC (clkss_cmlbuf_phy_ss_iosf_sb_intf_MNPCUP),
.clkss_cmlbuf_phy_ss_iosf_sb_intf_TEOM (clkss_cmlbuf_phy_ss_iosf_sb_intf_TEOM),
.clkss_cmlbuf_phy_ss_iosf_sb_intf_TNPPUT (clkss_cmlbuf_phy_ss_iosf_sb_intf_TNPPUT),
.clkss_cmlbuf_phy_ss_iosf_sb_intf_TPAYLOAD (clkss_cmlbuf_phy_ss_iosf_sb_intf_TPAYLOAD),
.clkss_cmlbuf_phy_ss_iosf_sb_intf_TPCPUT (clkss_cmlbuf_phy_ss_iosf_sb_intf_TPCPUT),
.clkss_cmlbuf_phy_ss_iosf_sb_intf_MEOM (clkss_cmlbuf_phy_ss_iosf_sb_intf_MEOM),
.clkss_cmlbuf_phy_ss_iosf_sb_intf_MNPPUT (clkss_cmlbuf_phy_ss_iosf_sb_intf_MNPPUT),
.clkss_cmlbuf_phy_ss_iosf_sb_intf_MPAYLOAD (clkss_cmlbuf_phy_ss_iosf_sb_intf_MPAYLOAD),
.clkss_cmlbuf_phy_ss_iosf_sb_intf_MPCPUT (clkss_cmlbuf_phy_ss_iosf_sb_intf_MPCPUT),
.clkss_cmlbuf_phy_ss_iosf_sb_intf_SIDE_ISM_AGENT (clkss_cmlbuf_phy_ss_iosf_sb_intf_SIDE_ISM_AGENT),
.clkss_cmlbuf_phy_ss_iosf_sb_intf_TNPCUP (clkss_cmlbuf_phy_ss_iosf_sb_intf_TNPCUP),
.clkss_cmlbuf_phy_ss_iosf_sb_intf_TPCCUP (clkss_cmlbuf_phy_ss_iosf_sb_intf_TPCCUP),
.clkss_cmlbuf_phy_ss_sideband_pok (clkss_cmlbuf_phy_ss_sideband_pok),
.cmlclkout_p_ana_phy_ss (cmlclkout_p_ana_phy_ss),
.cmlclkout_n_ana_phy_ss (cmlclkout_n_ana_phy_ss),
.nac_ss_dtf_upstream_credit (1'b0),
.nac_ss_dtf_upstream_active (1'b0),
.nac_ss_dtf_upstream_sync (1'b0),
.nac_ss_dtfb_upstream_rst_b (sys_rst_n),
.nac_ss_debug_safemode_isa_oob (1'b0),
.nac_ss_debug_snib_apb_addr (16'b0),
.nac_ss_debug_snib_apb_en (1'b0),
.nac_ss_debug_apb_rst_n (1'b0),
.nac_ss_debug_snib_apb_sel (1'b0),
.nac_ss_debug_snib_apb_wdata (32'b0),
.nac_ss_debug_snib_apb_wr (1'b0),
.nac_ss_debug_snib_apb_prot (3'b0),
.nac_ss_debug_snib_apb_strb (4'b0),
.nac_ss_debug_iosf2sfi_apb_addr (16'b0),
.nac_ss_debug_iosf2sfi_apb_en (1'b0),
.nac_ss_debug_iosf2sfi_apb_sel (1'b0),
.nac_ss_debug_iosf2sfi_apb_wdata (32'b0),
.nac_ss_debug_iosf2sfi_apb_wr (1'b0),
.nac_ss_debug_iosf2sfi_apb_prot (3'b0),
.nac_ss_debug_iosf2sfi_apb_strb (4'b0),
.nac_ss_dtf_dnstream_header (),
.nac_ss_dtf_dnstream_data (),
.nac_ss_dtf_dnstream_valid (),
.nac_ss_debug_dig_view_out (),
.nac_ss_debug_dts_dig_view_in (3'b0),
.nac_ss_debug_dts_dig_view_out (),
.nac_ss_debug_ana_view_inout (nac_ss_debug_ana_view_inout),
.nac_ss_tpiu_data (nac_ss_tpiu_data),
.nac_ss_tpiu_clk (nac_ss_tpiu_clk),
.nac_ss_debug_css600_dp_targetid (32'b0),
.nac_ss_debug_timestamp (1'b0),
.nac_ss_debug_snib_apb_rdata (),
.nac_ss_debug_snib_apb_rdy (),
.nac_ss_debug_snib_apb_slverr (),
.nac_ss_debug_iosf2sfi_apb_rdata (),
.nac_ss_debug_iosf2sfi_apb_rdy (),
.nac_ss_debug_iosf2sfi_apb_slverr (),
.nac_ss_debug_serializer_misc_chain_out_to_nac (2'b0),
.nac_ss_debug_serializer_hlp_eth_chain_out_to_nac (2'b0),
.nac_ss_debug_serializer_hif_eusb2_chain_out_to_nac (2'b0),
.nac_ss_debug_serializer_hlp_eth_chain_in_from_nac (),
.nac_ss_debug_serializer_misc_chain_in_from_nac (),
.nac_ss_debug_serializer_hif_eusb2_chain_in_from_nac (),
.nac_ss_debug_req_in_next (4'b0),
.nac_ss_debug_req_out_next (),
.nac_ss_debug_ack_in_next (4'b0),
.nac_ss_debug_ack_out_next (),
.nac_ss_debug_par_gpio_ne_req_in_next (4'b0),
.nac_ss_debug_par_gpio_ne_req_out_next (),
.nac_ss_debug_par_gpio_ne_ack_in_next (4'b0),
.nac_ss_debug_par_gpio_ne_ack_out_next (),
.nac_ss_debug_css600_swclk_in (1'b0),
.nac_ss_debug_css600_swdio_in (1'b0),
.nac_ss_debug_css600_swd_sel_in (1'b0),
.nac_ss_debug_css600_swdo_out (),
.nac_ss_debug_css600_swd0_en_out (),
.nac_ss_tpiu_reset (nac_ss_tpiu_reset),
.nac_post_iosf_sb_ism_fabric (nac_post_iosf_sb_ism_fabric),
.nac_post_iosf_sb_ism_agent (nac_post_iosf_sb_ism_agent),
.nac_post_iosf_sb_mnpput (nac_post_iosf_sb_mnpput),
.nac_post_iosf_sb_mpcput (nac_post_iosf_sb_mpcput),
.nac_post_iosf_sb_mnpcup (nac_post_iosf_sb_mnpcup),
.nac_post_iosf_sb_mpccup (nac_post_iosf_sb_mpccup),
.nac_post_iosf_sb_meom (nac_post_iosf_sb_meom),
.nac_post_iosf_sb_mpayload (nac_post_iosf_sb_mpayload),
.nac_post_iosf_sb_tnpput (nac_post_iosf_sb_tnpput),
.nac_post_iosf_sb_tpcput (nac_post_iosf_sb_tpcput),
.nac_post_iosf_sb_tnpcup (nac_post_iosf_sb_tnpcup),
.nac_post_iosf_sb_tpccup (nac_post_iosf_sb_tpccup),
.nac_post_iosf_sb_teom (nac_post_iosf_sb_teom),
.nac_post_iosf_sb_tpayload (nac_post_iosf_sb_tpayload),
.nac_post_status_to_cltap (nac_post_status_to_cltap),
.YY_WOL_N (YY_WOL_N),
.XX_TIME_SYNC (XX_TIME_SYNC),
.dts_lvrref_a (dts_lvrref_a),
.nac_ra_err (nac_ra_err),
.nac_thermtrip_in (nac_thermtrip_in),
.nac_thermtrip_out (nac_thermtrip_out),
.nac_pllthermtrip_err (nac_pllthermtrip_err),
//.s5_bgr_lvrrefpwrgood (s5_bgr_lvrrefpwrgood),
.iosf2sfi_isa_clk_req (iosf2sfi_isa_clk_req),
.isa_iosf2sfi_isa_clk_ack (iosf2sfi_isa_clk_req),
.sn2iosf_isa_clk_req (sn2iosf_isa_clk_req),
.isa_sn2iosf_isa_clk_ack (sn2iosf_isa_clk_req),
.gpio_ne_i_anode (gpio_ne_i_anode),
.gpio_ne_v_anode (gpio_ne_v_anode),
.gpio_ne_v_cathode (gpio_ne_v_cathode),
.fabric_s5_i_anode (fabric_s5_i_anode),
.fabric_s5_v_anode (fabric_s5_v_anode),
.fabric_s5_v_cathode (fabric_s5_v_cathode),
.nac_dts2_i_cathode (nac_dts2_i_cathode),
.NAC_XX_THERMDASOC0 (NAC_XX_THERMDASOC0),
.NAC_XX_THERMDCSOC0 (NAC_XX_THERMDCSOC0),
.svidalert_n_rxen_b (svidalert_n_rxen_b),
.svidalert_n_rxen_b_rpt_sync (svidalert_n_rxen_b_rpt_sync),
.svidclk_rxen_b (svidclk_rxen_b),
.svidclk_rxen_b_rpt_sync (svidclk_rxen_b_rpt_sync),
.svidclk_txen_b (svidclk_txen_b),
.svidclk_txen_b_rpt_sync (svidclk_txen_b_rpt_sync),
.sviddata_rxdata (sviddata_rxdata),
.sviddata_rxdata_rpt_sync (sviddata_rxdata_rpt_sync),
.sviddata_rxen_b (sviddata_rxen_b),
.sviddata_rxen_b_rpt_sync (sviddata_rxen_b_rpt_sync),
.sviddata_txen_b (sviddata_txen_b),
.sviddata_txen_b_rpt_sync (sviddata_txen_b_rpt_sync),
.gpio_ne_nacss_xxsvidclk_rxdata (gpio_ne_nacss_xxsvidclk_rxdata),
.nacss_punit_feedthrough_xxsvidclk_rxdata (nacss_punit_feedthrough_xxsvidclk_rxdata),
.gpio_ne_nacss_xxsvidalert_n_rxdata (gpio_ne_nacss_xxsvidalert_n_rxdata),
.nacss_punit_feedthrough_xxsvidalert_n_rxdata (nacss_punit_feedthrough_xxsvidalert_n_rxdata),
.rsrc_adapt_dts_nac0_iosf_sb_ism_fabric (rsrc_adapt_dts_nac0_iosf_sb_ism_fabric),
.rsrc_adapt_dts_nac0_iosf_sb_ism_agent (rsrc_adapt_dts_nac0_iosf_sb_ism_agent),
.rsrc_adapt_dts_nac0_iosf_sb_side_pok (rsrc_adapt_dts_nac0_iosf_sb_side_pok),
.rsrc_adapt_dts_nac0_iosf_sb_mnpput (rsrc_adapt_dts_nac0_iosf_sb_mnpput),
.rsrc_adapt_dts_nac0_iosf_sb_mpcput (rsrc_adapt_dts_nac0_iosf_sb_mpcput),
.rsrc_adapt_dts_nac0_iosf_sb_mnpcup (rsrc_adapt_dts_nac0_iosf_sb_mnpcup),
.rsrc_adapt_dts_nac0_iosf_sb_mpccup (rsrc_adapt_dts_nac0_iosf_sb_mpccup),
.rsrc_adapt_dts_nac0_iosf_sb_meom (rsrc_adapt_dts_nac0_iosf_sb_meom),
.rsrc_adapt_dts_nac0_iosf_sb_mpayload (rsrc_adapt_dts_nac0_iosf_sb_mpayload),
.rsrc_adapt_dts_nac0_iosf_sb_tnpput (rsrc_adapt_dts_nac0_iosf_sb_tnpput),
.rsrc_adapt_dts_nac0_iosf_sb_tpcput (rsrc_adapt_dts_nac0_iosf_sb_tpcput),
.rsrc_adapt_dts_nac0_iosf_sb_tnpcup (rsrc_adapt_dts_nac0_iosf_sb_tnpcup),
.rsrc_adapt_dts_nac0_iosf_sb_tpccup (rsrc_adapt_dts_nac0_iosf_sb_tpccup),
.rsrc_adapt_dts_nac0_iosf_sb_teom (rsrc_adapt_dts_nac0_iosf_sb_teom),
.rsrc_adapt_dts_nac0_iosf_sb_tpayload (rsrc_adapt_dts_nac0_iosf_sb_tpayload),
.rsrc_adapt_dts_nac1_iosf_sb_ism_fabric (rsrc_adapt_dts_nac1_iosf_sb_ism_fabric),
.rsrc_adapt_dts_nac1_iosf_sb_ism_agent (rsrc_adapt_dts_nac1_iosf_sb_ism_agent),
.rsrc_adapt_dts_nac1_iosf_sb_side_pok (rsrc_adapt_dts_nac1_iosf_sb_side_pok),
.rsrc_adapt_dts_nac1_iosf_sb_mnpput (rsrc_adapt_dts_nac1_iosf_sb_mnpput),
.rsrc_adapt_dts_nac1_iosf_sb_mpcput (rsrc_adapt_dts_nac1_iosf_sb_mpcput),
.rsrc_adapt_dts_nac1_iosf_sb_mnpcup (rsrc_adapt_dts_nac1_iosf_sb_mnpcup),
.rsrc_adapt_dts_nac1_iosf_sb_mpccup (rsrc_adapt_dts_nac1_iosf_sb_mpccup),
.rsrc_adapt_dts_nac1_iosf_sb_meom (rsrc_adapt_dts_nac1_iosf_sb_meom),
.rsrc_adapt_dts_nac1_iosf_sb_mpayload (rsrc_adapt_dts_nac1_iosf_sb_mpayload),
.rsrc_adapt_dts_nac1_iosf_sb_tnpput (rsrc_adapt_dts_nac1_iosf_sb_tnpput),
.rsrc_adapt_dts_nac1_iosf_sb_tpcput (rsrc_adapt_dts_nac1_iosf_sb_tpcput),
.rsrc_adapt_dts_nac1_iosf_sb_tnpcup (rsrc_adapt_dts_nac1_iosf_sb_tnpcup),
.rsrc_adapt_dts_nac1_iosf_sb_tpccup (rsrc_adapt_dts_nac1_iosf_sb_tpccup),
.rsrc_adapt_dts_nac1_iosf_sb_teom (rsrc_adapt_dts_nac1_iosf_sb_teom),
.rsrc_adapt_dts_nac1_iosf_sb_tpayload (rsrc_adapt_dts_nac1_iosf_sb_tpayload),
.rsrc_adapt_dts_nac2_iosf_sb_ism_fabric (rsrc_adapt_dts_nac2_iosf_sb_ism_fabric),
.rsrc_adapt_dts_nac2_iosf_sb_ism_agent (rsrc_adapt_dts_nac2_iosf_sb_ism_agent),
.rsrc_adapt_dts_nac2_iosf_sb_side_pok (rsrc_adapt_dts_nac2_iosf_sb_side_pok),
.rsrc_adapt_dts_nac2_iosf_sb_mnpput (rsrc_adapt_dts_nac2_iosf_sb_mnpput),
.rsrc_adapt_dts_nac2_iosf_sb_mpcput (rsrc_adapt_dts_nac2_iosf_sb_mpcput),
.rsrc_adapt_dts_nac2_iosf_sb_mnpcup (rsrc_adapt_dts_nac2_iosf_sb_mnpcup),
.rsrc_adapt_dts_nac2_iosf_sb_mpccup (rsrc_adapt_dts_nac2_iosf_sb_mpccup),
.rsrc_adapt_dts_nac2_iosf_sb_meom (rsrc_adapt_dts_nac2_iosf_sb_meom),
.rsrc_adapt_dts_nac2_iosf_sb_mpayload (rsrc_adapt_dts_nac2_iosf_sb_mpayload),
.rsrc_adapt_dts_nac2_iosf_sb_tnpput (rsrc_adapt_dts_nac2_iosf_sb_tnpput),
.rsrc_adapt_dts_nac2_iosf_sb_tpcput (rsrc_adapt_dts_nac2_iosf_sb_tpcput),
.rsrc_adapt_dts_nac2_iosf_sb_tnpcup (rsrc_adapt_dts_nac2_iosf_sb_tnpcup),
.rsrc_adapt_dts_nac2_iosf_sb_tpccup (rsrc_adapt_dts_nac2_iosf_sb_tpccup),
.rsrc_adapt_dts_nac2_iosf_sb_teom (rsrc_adapt_dts_nac2_iosf_sb_teom),
.rsrc_adapt_dts_nac2_iosf_sb_tpayload (rsrc_adapt_dts_nac2_iosf_sb_tpayload),
.sn2sfi_rst_n (sn2sfi_rst_n),
.hif_pcie0_PERST_n0 (hif_pcie0_PERST_n0),
//.hif_pcie0_PERST_n0 (sys_rst_n),//(hif_pcie0_PERST_n0),
.nac_pwrgood_rst_b (sys_rst_n),//(nac_pwrgood_rst_b),
.inf_rstbus_rst_b (sys_rst_n),//(inf_rstbus_rst_b),
.early_boot_rst_b (sys_rst_n),//(early_boot_rst_b),
.inf_iosfsb_rst_b (sys_rst_n),//(inf_iosfsb_rst_b),
.nac_sys_rst_n (sys_rst_n),//(nac_sys_rst_n),
.ecm_boot_err (ecm_boot_err),
.nac_a0_debug_strap (nac_a0_debug_strap),
.hwrs_nac_spare_in (hwrs_nac_spare_in),
.nac_hwrs_spare_out (nac_hwrs_spare_out),
.sn2sfi_powergood (sys_rst_n),//(sn2sfi_powergood),
.cnic_fnic_mode_strap (cnic_fnic_mode_strap),
//.nsc_gpio_wake_on_lan (nsc_gpio_wake_on_lan),
.nsc_qchagg_hif_sn2sfi_busy (nsc_qchagg_hif_sn2sfi_busy),
.fdfx_pwrgood_rst_b (sys_rst_n),//(fdfx_pwrgood_rst_b),
.reset_cmd_data (reset_cmd_data),
.reset_cmd_valid (reset_cmd_valid),
.reset_cmd_parity (reset_cmd_parity),
.imcr_hwrs_qacceptn (imcr_hwrs_qacceptn),
.imcr_hwrs_qdeny (imcr_hwrs_qdeny),
.imcr_hwrs_qactive (imcr_hwrs_qactive),
.imcr_hwrs_qreqn (imcr_hwrs_qreqn),
.clockss_eth_physs_pll_iosf_sb_ism_fabric (clockss_eth_physs_pll_iosf_sb_ism_fabric),
.clockss_eth_physs_pll_iosf_sb_ism_agent (clockss_eth_physs_pll_iosf_sb_ism_agent),
.clockss_eth_physs_pll_iosf_sb_side_pok (clockss_eth_physs_pll_iosf_sb_side_pok),
.clockss_eth_physs_pll_iosf_sb_mnpput (clockss_eth_physs_pll_iosf_sb_mnpput),
.clockss_eth_physs_pll_iosf_sb_mpcput (clockss_eth_physs_pll_iosf_sb_mpcput),
.clockss_eth_physs_pll_iosf_sb_mnpcup (clockss_eth_physs_pll_iosf_sb_mnpcup),
.clockss_eth_physs_pll_iosf_sb_mpccup (clockss_eth_physs_pll_iosf_sb_mpccup),
.clockss_eth_physs_pll_iosf_sb_meom (clockss_eth_physs_pll_iosf_sb_meom),
.clockss_eth_physs_pll_iosf_sb_mpayload (clockss_eth_physs_pll_iosf_sb_mpayload),
.clockss_eth_physs_pll_iosf_sb_tnpput (clockss_eth_physs_pll_iosf_sb_tnpput),
.clockss_eth_physs_pll_iosf_sb_tpcput (clockss_eth_physs_pll_iosf_sb_tpcput),
.clockss_eth_physs_pll_iosf_sb_tnpcup (clockss_eth_physs_pll_iosf_sb_tnpcup),
.clockss_eth_physs_pll_iosf_sb_tpccup (clockss_eth_physs_pll_iosf_sb_tpccup),
.clockss_eth_physs_pll_iosf_sb_teom (clockss_eth_physs_pll_iosf_sb_teom),
.clockss_eth_physs_pll_iosf_sb_tpayload (clockss_eth_physs_pll_iosf_sb_tpayload),
.infraclk_div4_pdop_par_fabric_s5 (infra_clk), //TBD Lokesh: this is infra_clk/4
.apb2iosfsb_pipe_rst_n (apb2iosfsb_pipe_rst_n),
.gpio_ne1p8_sb_pipe_rst_n (gpio_ne1p8_sb_pipe_rst_n),
.BSCAN_bypass_avephy_x4_phy0 (BSCAN_bypass_avephy_x4_phy0),
.BSCAN_bypass_avephy_x4_phy1 (BSCAN_bypass_avephy_x4_phy1),
.BSCAN_bypass_avephy_x4_phy2 (BSCAN_bypass_avephy_x4_phy2), 
.BSCAN_bypass_avephy_x4_phy3 (BSCAN_bypass_avephy_x4_phy3),
.BSCAN_wake_avephy_x4_phy0 (BSCAN_wake_avephy_x4_phy0),
.BSCAN_wake_avephy_x4_phy1 (BSCAN_wake_avephy_x4_phy1),
.BSCAN_wake_avephy_x4_phy2 (BSCAN_wake_avephy_x4_phy2),
.BSCAN_wake_avephy_x4_phy3 (BSCAN_wake_avephy_x4_phy3),
.PHYSS_BSCAN_BYPASS (PHYSS_BSCAN_BYPASS),
.GPIO_NE_BSCAN_PIPE_OUT_TO_USBMUX_force_disable(GPIO_NE_BSCAN_PIPE_OUT_TO_USBMUX_force_disable),
.GPIO_NE_BSCAN_PIPE_OUT_TO_USBMUX_select_jtag_input(GPIO_NE_BSCAN_PIPE_OUT_TO_USBMUX_select_jtag_input),
.GPIO_NE_BSCAN_PIPE_OUT_TO_USBMUX_select_jtag_output(GPIO_NE_BSCAN_PIPE_OUT_TO_USBMUX_select_jtag_output),
.GPIO_NE_BSCAN_PIPE_OUT_TO_USBMUX_ac_init_clock0(GPIO_NE_BSCAN_PIPE_OUT_TO_USBMUX_ac_init_clock0),
.GPIO_NE_BSCAN_PIPE_OUT_TO_USBMUX_ac_init_clock1(GPIO_NE_BSCAN_PIPE_OUT_TO_USBMUX_ac_init_clock1),
.GPIO_NE_BSCAN_PIPE_OUT_TO_USBMUX_ac_signal(GPIO_NE_BSCAN_PIPE_OUT_TO_USBMUX_ac_signal),
.GPIO_NE_BSCAN_PIPE_OUT_TO_USBMUX_ac_mode_en(GPIO_NE_BSCAN_PIPE_OUT_TO_USBMUX_ac_mode_en),
.GPIO_NE_BSCAN_PIPE_OUT_TO_USBMUX_intel_update_clk(GPIO_NE_BSCAN_PIPE_OUT_TO_USBMUX_intel_update_clk),
.GPIO_NE_BSCAN_PIPE_OUT_TO_USBMUX_intel_clamp_en(GPIO_NE_BSCAN_PIPE_OUT_TO_USBMUX_intel_clamp_en),
.GPIO_NE_BSCAN_PIPE_OUT_TO_USBMUX_intel_bscan_mode(GPIO_NE_BSCAN_PIPE_OUT_TO_USBMUX_intel_bscan_mode),
.GPIO_NE_BSCAN_PIPE_OUT_TO_USBMUX_select(GPIO_NE_BSCAN_PIPE_OUT_TO_USBMUX_select),
.GPIO_NE_BSCAN_PIPE_OUT_TO_USBMUX_bscan_clock(GPIO_NE_BSCAN_PIPE_OUT_TO_USBMUX_bscan_clock),
.GPIO_NE_BSCAN_PIPE_OUT_TO_USBMUX_capture_en(GPIO_NE_BSCAN_PIPE_OUT_TO_USBMUX_capture_en),
.GPIO_NE_BSCAN_PIPE_OUT_TO_USBMUX_shift_en(GPIO_NE_BSCAN_PIPE_OUT_TO_USBMUX_shift_en),
.GPIO_NE_BSCAN_PIPE_OUT_TO_USBMUX_update_en(GPIO_NE_BSCAN_PIPE_OUT_TO_USBMUX_update_en),
.GPIO_NE_BSCAN_PIPE_OUT_TO_USBMUX_scan_in(GPIO_NE_BSCAN_PIPE_OUT_TO_USBMUX_scan_in),
.BSCAN_PIPE_IN_FROM_GPIO_NE_scan_out(BSCAN_PIPE_IN_FROM_GPIO_NE_scan_out),
.GPIO_SW_BSCAN_PIPE_OUT_TO_GPIO_SW_force_disable(GPIO_SW_BSCAN_PIPE_OUT_TO_GPIO_SW_force_disable),
.GPIO_SW_BSCAN_PIPE_OUT_TO_GPIO_SW_select_jtag_input(GPIO_SW_BSCAN_PIPE_OUT_TO_GPIO_SW_select_jtag_input),
.GPIO_SW_BSCAN_PIPE_OUT_TO_GPIO_SW_select_jtag_output(GPIO_SW_BSCAN_PIPE_OUT_TO_GPIO_SW_select_jtag_output),
.GPIO_SW_BSCAN_PIPE_OUT_TO_GPIO_SW_ac_init_clock0(GPIO_SW_BSCAN_PIPE_OUT_TO_GPIO_SW_ac_init_clock0),
.GPIO_SW_BSCAN_PIPE_OUT_TO_GPIO_SW_ac_init_clock1(GPIO_SW_BSCAN_PIPE_OUT_TO_GPIO_SW_ac_init_clock1),
.GPIO_SW_BSCAN_PIPE_OUT_TO_GPIO_SW_ac_signal(GPIO_SW_BSCAN_PIPE_OUT_TO_GPIO_SW_ac_signal),
.GPIO_SW_BSCAN_PIPE_OUT_TO_GPIO_SW_ac_mode_en(GPIO_SW_BSCAN_PIPE_OUT_TO_GPIO_SW_ac_mode_en),
.GPIO_SW_BSCAN_PIPE_OUT_TO_GPIO_SW_intel_update_clk(GPIO_SW_BSCAN_PIPE_OUT_TO_GPIO_SW_intel_update_clk),
.GPIO_SW_BSCAN_PIPE_OUT_TO_GPIO_SW_intel_clamp_en(GPIO_SW_BSCAN_PIPE_OUT_TO_GPIO_SW_intel_clamp_en),
.GPIO_SW_BSCAN_PIPE_OUT_TO_GPIO_SW_intel_bscan_mode(GPIO_SW_BSCAN_PIPE_OUT_TO_GPIO_SW_intel_bscan_mode),
.GPIO_SW_BSCAN_PIPE_OUT_TO_GPIO_SW_select(GPIO_SW_BSCAN_PIPE_OUT_TO_GPIO_SW_select),
.GPIO_SW_BSCAN_PIPE_OUT_TO_GPIO_SW_bscan_clock(GPIO_SW_BSCAN_PIPE_OUT_TO_GPIO_SW_bscan_clock),
.GPIO_SW_BSCAN_PIPE_OUT_TO_GPIO_SW_capture_en(GPIO_SW_BSCAN_PIPE_OUT_TO_GPIO_SW_capture_en),
.GPIO_SW_BSCAN_PIPE_OUT_TO_GPIO_SW_shift_en(GPIO_SW_BSCAN_PIPE_OUT_TO_GPIO_SW_shift_en),
.GPIO_SW_BSCAN_PIPE_OUT_TO_GPIO_SW_update_en(GPIO_SW_BSCAN_PIPE_OUT_TO_GPIO_SW_update_en),
.GPIO_SW_BSCAN_PIPE_OUT_TO_GPIO_SW_scan_in(GPIO_SW_BSCAN_PIPE_OUT_TO_GPIO_SW_scan_in),
.BSCAN_PIPE_IN_FROM_GPIO_SW_scan_out(BSCAN_PIPE_IN_FROM_GPIO_SW_scan_out),
.BSCAN_PIPE_IN_bscan_clock(BSCAN_PIPE_IN_bscan_clock),
.BSCAN_PIPE_IN_select(BSCAN_PIPE_IN_select),
.BSCAN_PIPE_IN_capture_en(BSCAN_PIPE_IN_capture_en),
.BSCAN_PIPE_IN_shift_en(BSCAN_PIPE_IN_shift_en),
.BSCAN_PIPE_IN_update_en(BSCAN_PIPE_IN_update_en),
.BSCAN_PIPE_IN_scan_in(BSCAN_PIPE_IN_scan_in),
.BSCAN_PIPE_IN_ac_signal(BSCAN_PIPE_IN_ac_signal),
.BSCAN_PIPE_IN_ac_init_clock0(BSCAN_PIPE_IN_ac_init_clock0),
.BSCAN_PIPE_IN_ac_init_clock1(BSCAN_PIPE_IN_ac_init_clock1),
.BSCAN_PIPE_IN_ac_mode_en(BSCAN_PIPE_IN_ac_mode_en),
.BSCAN_PIPE_IN_force_disable(BSCAN_PIPE_IN_force_disable),
.BSCAN_PIPE_IN_select_jtag_input(BSCAN_PIPE_IN_select_jtag_input),
.BSCAN_PIPE_IN_select_jtag_output(BSCAN_PIPE_IN_select_jtag_output),
.BSCAN_PIPE_IN_intel_update_clk(BSCAN_PIPE_IN_intel_update_clk),
.BSCAN_PIPE_IN_intel_clamp_en(BSCAN_PIPE_IN_intel_clamp_en),
.BSCAN_PIPE_IN_intel_bscan_mode(BSCAN_PIPE_IN_intel_bscan_mode),
.BSCAN_PIPE_OUT_scan_out(BSCAN_PIPE_OUT_scan_out),
.tms (1'b0),
.tck (1'b0),
.tdi (tdi),
.trst_b (sys_rst_n),
.shift_ir_dr (1'b0),
.tms_park_value (1'b0),
.nw_mode (nw_mode),
.ijtag_reset_b (1'b0),
.ijtag_shift (1'b0),
.ijtag_capture (1'b0),
.ijtag_update (1'b0),
.ijtag_select (1'b0),
.ijtag_si (1'b0),
.tdo (tdo),
.tdo_en (tdo_en),
.ijtag_so (ijtag_so),
.tap_sel_out (tap_sel_out),
.tap_sel_in (1'b0),
.DIAG_AGGR_0_mbist_diag_done (DIAG_AGGR_0_mbist_diag_done),
.NW_OUT_par_gpio_sw_to_trst (NW_OUT_par_gpio_sw_to_trst),
.NW_OUT_par_gpio_sw_to_tck (NW_OUT_par_gpio_sw_to_tck),
.NW_OUT_par_gpio_sw_to_tms (NW_OUT_par_gpio_sw_to_tms),
.NW_OUT_par_gpio_sw_to_tdi (NW_OUT_par_gpio_sw_to_tdi),
.NW_OUT_par_gpio_sw_from_tdo (NW_OUT_par_gpio_sw_from_tdo),
.NW_OUT_par_gpio_sw_from_tdo_en (NW_OUT_par_gpio_sw_from_tdo_en),
.NW_OUT_par_gpio_sw_tap_sel_in (NW_OUT_par_gpio_sw_tap_sel_in),
.NW_OUT_par_gpio_sw_ijtag_to_reset (NW_OUT_par_gpio_sw_ijtag_to_reset),
.NW_OUT_par_gpio_sw_ijtag_to_tck (NW_OUT_par_gpio_sw_ijtag_to_tck),
.NW_OUT_par_gpio_sw_ijtag_to_ce (NW_OUT_par_gpio_sw_ijtag_to_ce),
.NW_OUT_par_gpio_sw_ijtag_to_se (NW_OUT_par_gpio_sw_ijtag_to_se),
.NW_OUT_par_gpio_sw_ijtag_to_ue (NW_OUT_par_gpio_sw_ijtag_to_ue),
.NW_OUT_par_gpio_sw_ijtag_to_sel (NW_OUT_par_gpio_sw_ijtag_to_sel),
.NW_OUT_par_gpio_sw_ijtag_to_si (NW_OUT_par_gpio_sw_ijtag_to_si),
.NW_OUT_par_gpio_sw_ijtag_from_so (NW_OUT_par_gpio_sw_ijtag_from_so),
.NW_OUT_par_gpio_ne_to_trst (NW_OUT_par_gpio_ne_to_trst),
.NW_OUT_par_gpio_ne_to_tck (NW_OUT_par_gpio_ne_to_tck),
.NW_OUT_par_gpio_ne_to_tms (NW_OUT_par_gpio_ne_to_tms),
.NW_OUT_par_gpio_ne_to_tdi (NW_OUT_par_gpio_ne_to_tdi),
.NW_OUT_par_gpio_ne_from_tdo (NW_OUT_par_gpio_ne_from_tdo),
.NW_OUT_par_gpio_ne_from_tdo_en (NW_OUT_par_gpio_ne_from_tdo_en),
.NW_OUT_par_gpio_ne_tap_sel_in (NW_OUT_par_gpio_ne_tap_sel_in),
.NW_OUT_par_gpio_ne_ijtag_to_reset (NW_OUT_par_gpio_ne_ijtag_to_reset),
.NW_OUT_par_gpio_ne_ijtag_to_tck (NW_OUT_par_gpio_ne_ijtag_to_tck),
.NW_OUT_par_gpio_ne_ijtag_to_ce (NW_OUT_par_gpio_ne_ijtag_to_ce),
.NW_OUT_par_gpio_ne_ijtag_to_se (NW_OUT_par_gpio_ne_ijtag_to_se),
.NW_OUT_par_gpio_ne_ijtag_to_ue (NW_OUT_par_gpio_ne_ijtag_to_ue),
.NW_OUT_par_gpio_ne_ijtag_to_sel (NW_OUT_par_gpio_ne_ijtag_to_sel),
.NW_OUT_par_gpio_ne_ijtag_to_si (NW_OUT_par_gpio_ne_ijtag_to_si),
.NW_OUT_par_gpio_ne_ijtag_from_so (NW_OUT_par_gpio_ne_ijtag_from_so),
.ssn_bus_data_in (ssn_bus_data_in),
.ssn_bus_clock_in (1'b0),
.ssn_bus_data_out (ssn_bus_data_out),
.par_nac_fabric3_par_gpio_sw_mux_start_bus_data_in (par_nac_fabric3_par_gpio_sw_mux_start_bus_data_in),
.par_nac_fabric3_par_gpio_sw_mux_end_bus_data_out (par_nac_fabric3_par_gpio_sw_mux_end_bus_data_out),
.par_nac_fabric0_mux_par_gpio_ne_in_start_bus_data_in (par_nac_fabric0_mux_par_gpio_ne_in_start_bus_data_in),
.par_nac_fabric0_par_gpio_ne_out_end_bus_data_out (par_nac_fabric0_par_gpio_ne_out_end_bus_data_out),
.BscanMux_gpio_sw_force_ip_bypass(BscanMux_gpio_sw_force_ip_bypass),
.BscanMux_physs_force_ip_bypass(BscanMux_physs_force_ip_bypass),
.BscanMux_GPIO_NE_force_ip_bypass(BscanMux_GPIO_NE_force_ip_bypass),
.BscanMux_USB_force_ip_bypass(BscanMux_USB_force_ip_bypass),
.BscanMux_fabric1_force_ip_bypass(BscanMux_fabric1_force_ip_bypass),
.BscanMux_fabric2_force_ip_bypass(BscanMux_fabric2_force_ip_bypass),
.PCIE_PHY0_APROBE (PCIE_PHY0_APROBE),
.PCIE_PHY0_APROBE2 (PCIE_PHY0_APROBE2),
.PCIE_RX0_N (PCIE_RX0_N),
.PCIE_RX0_P (PCIE_RX0_P),
.PCIE_TX0_N (PCIE_TX0_N),
.PCIE_TX0_P (PCIE_TX0_P),
.PCIE_RX1_N (PCIE_RX1_N),
.PCIE_RX1_P (PCIE_RX1_P),
.PCIE_TX1_N (PCIE_TX1_N),
.PCIE_TX1_P (PCIE_TX1_P),
.PCIE_RX2_N (PCIE_RX2_N),
.PCIE_RX2_P (PCIE_RX2_P),
.PCIE_TX2_N (PCIE_TX2_N),
.PCIE_TX2_P (PCIE_TX2_P),
.PCIE_RX3_N (PCIE_RX3_N),
.PCIE_RX3_P (PCIE_RX3_P),
.PCIE_TX3_N (PCIE_TX3_N),
.PCIE_TX3_P (PCIE_TX3_P),
.PCIE_REF_PAD_CLK0_N (PCIE_REF_PAD_CLK0_N),
.PCIE_REF_PAD_CLK0_P (PCIE_REF_PAD_CLK0_P),
.PCIE_PHY0_GRCOMP (PCIE_PHY0_GRCOMP),
.PCIE_PHY0_GRCOMPV (PCIE_PHY0_GRCOMPV),
.PCIE_PHY1_APROBE (PCIE_PHY1_APROBE),
.PCIE_PHY1_APROBE2 (PCIE_PHY1_APROBE2),
.PCIE_RX4_N (PCIE_RX4_N),
.PCIE_RX4_P (PCIE_RX4_P),
.PCIE_TX4_N (PCIE_TX4_N),
.PCIE_TX4_P (PCIE_TX4_P),
.PCIE_RX5_N (PCIE_RX5_N),
.PCIE_RX5_P (PCIE_RX5_P),
.PCIE_TX5_N (PCIE_TX5_N),
.PCIE_TX5_P (PCIE_TX5_P),
.PCIE_RX6_N (PCIE_RX6_N),
.PCIE_RX6_P (PCIE_RX6_P),
.PCIE_TX6_N (PCIE_TX6_N),
.PCIE_TX6_P (PCIE_TX6_P),
.PCIE_RX7_N (PCIE_RX7_N),
.PCIE_RX7_P (PCIE_RX7_P),
.PCIE_TX7_N (PCIE_TX7_N),
.PCIE_TX7_P (PCIE_TX7_P),
.PCIE_REF_PAD_CLK1_N (PCIE_REF_PAD_CLK1_N),
.PCIE_REF_PAD_CLK1_P (PCIE_REF_PAD_CLK1_P),
.PCIE_PHY1_GRCOMP (PCIE_PHY1_GRCOMP),
.PCIE_PHY1_GRCOMPV (PCIE_PHY1_GRCOMPV),
.PCIE_PHY2_APROBE (PCIE_PHY2_APROBE),
.PCIE_PHY2_APROBE2 (PCIE_PHY2_APROBE2),
.PCIE_RX8_N (PCIE_RX8_N),
.PCIE_RX8_P (PCIE_RX8_P),
.PCIE_TX8_N (PCIE_TX8_N),
.PCIE_TX8_P (PCIE_TX8_P),
.PCIE_RX9_N (PCIE_RX9_N),
.PCIE_RX9_P (PCIE_RX9_P),
.PCIE_TX9_N (PCIE_TX9_N),
.PCIE_TX9_P (PCIE_TX9_P),
.PCIE_RX10_N (PCIE_RX10_N),
.PCIE_RX10_P (PCIE_RX10_P),
.PCIE_TX10_N (PCIE_TX10_N),
.PCIE_TX10_P (PCIE_TX10_P),
.PCIE_RX11_N (PCIE_RX11_N),
.PCIE_RX11_P (PCIE_RX11_P),
.PCIE_TX11_N (PCIE_TX11_N),
.PCIE_TX11_P (PCIE_TX11_P),
.PCIE_REF_PAD_CLK2_N (PCIE_REF_PAD_CLK2_N),
.PCIE_REF_PAD_CLK2_P (PCIE_REF_PAD_CLK2_P),
.PCIE_PHY2_GRCOMP (PCIE_PHY2_GRCOMP),
.PCIE_PHY2_GRCOMPV (PCIE_PHY2_GRCOMPV),
.PCIE_PHY3_APROBE (PCIE_PHY3_APROBE),
.PCIE_PHY3_APROBE2 (PCIE_PHY3_APROBE2),
.PCIE_RX12_N (PCIE_RX12_N),
.PCIE_RX12_P (PCIE_RX12_P),
.PCIE_TX12_N (PCIE_TX12_N),
.PCIE_TX12_P (PCIE_TX12_P),
.PCIE_RX13_N (PCIE_RX13_N),
.PCIE_RX13_P (PCIE_RX13_P),
.PCIE_TX13_N (PCIE_TX13_N),
.PCIE_TX13_P (PCIE_TX13_P),
.PCIE_RX14_N (PCIE_RX14_N),
.PCIE_RX14_P (PCIE_RX14_P),
.PCIE_TX14_N (PCIE_TX14_N),
.PCIE_TX14_P (PCIE_TX14_P),
.PCIE_RX15_N (PCIE_RX15_N),
.PCIE_RX15_P (PCIE_RX15_P),
.PCIE_TX15_N (PCIE_TX15_N),
.PCIE_TX15_P (PCIE_TX15_P),
.PCIE_REF_PAD_CLK3_N (PCIE_REF_PAD_CLK3_N),
.PCIE_REF_PAD_CLK3_P (PCIE_REF_PAD_CLK3_P),
.PCIE_PHY3_GRCOMP (PCIE_PHY3_GRCOMP),
.PCIE_PHY3_GRCOMPV (PCIE_PHY3_GRCOMPV),
.cfio_paddr (cfio_paddr),
.cfio_penable (cfio_penable),
.cfio_pwrite (cfio_pwrite),
.cfio_pwdata (cfio_pwdata),
.cfio_pprot (cfio_pprot),
.cfio_pstrb (cfio_pstrb),
.cfio_psel (cfio_psel),
.cfio_prdata (cfio_prdata),
.cfio_pready (cfio_pready),
.cfio_pslverr (cfio_pslverr),
.i_nmf_t_cnic_physs_gpio_paddr (i_nmf_t_cnic_physs_gpio_paddr),
.i_nmf_t_cnic_physs_gpio_penable (i_nmf_t_cnic_physs_gpio_penable),
.i_nmf_t_cnic_physs_gpio_pwrite (i_nmf_t_cnic_physs_gpio_pwrite),
.i_nmf_t_cnic_physs_gpio_pwdata (i_nmf_t_cnic_physs_gpio_pwdata),
.i_nmf_t_cnic_physs_gpio_pprot (i_nmf_t_cnic_physs_gpio_pprot),
.i_nmf_t_cnic_physs_gpio_pstrb (i_nmf_t_cnic_physs_gpio_pstrb),
.i_nmf_t_cnic_physs_gpio_psel_0 (i_nmf_t_cnic_physs_gpio_psel_0),
.i_nmf_t_cnic_physs_gpio_prdata_0 (i_nmf_t_cnic_physs_gpio_prdata_0),
.i_nmf_t_cnic_physs_gpio_pready_0 (i_nmf_t_cnic_physs_gpio_pready_0),
.i_nmf_t_cnic_physs_gpio_pslverr_0 (i_nmf_t_cnic_physs_gpio_pslverr_0),
.XX_SPI_CLK (XX_SPI_CLK),
.XX_SPI_OE_N (XX_SPI_OE_N),
.XX_SPI_TXD (XX_SPI_TXD),
.XX_SPI_RXD (XX_SPI_RXD),
.XX_SPI_CS0_N (XX_SPI_CS0_N),
.XX_SPI_CS1_N (XX_SPI_CS1_N),
.XX_I2C_SCL0 (XX_I2C_SCL0),
.XX_I2C_SCL1 (XX_I2C_SCL1),
.XX_I2C_SCL2 (XX_I2C_SCL2),
.XX_I2C_SCL4 (XX_I2C_SCL4),
.XX_I2C_SCL5 (XX_I2C_SCL5),
.XX_I2C_SCL6 (XX_I2C_SCL6),
.XX_I2C_SCL7 (XX_I2C_SCL7),
.nss_i2c_clk_oe_n (nss_i2c_clk_oe_n),
.XX_I2C_SDA0 (XX_I2C_SDA0),
.XX_I2C_SDA1 (XX_I2C_SDA1),
.XX_I2C_SDA2 (XX_I2C_SDA2),
.XX_I2C_SDA4 (XX_I2C_SDA4),
.XX_I2C_SDA5 (XX_I2C_SDA5),
.XX_I2C_SDA6 (XX_I2C_SDA6),
.XX_I2C_SDA7 (XX_I2C_SDA7),
.nss_i2c_data_oe_n (nss_i2c_data_oe_n),
//.svidalert (svidalert),
.i2c_smbalert_in_n (i2c_smbalert_in_n),
.FNIC_SVID_CLK (FNIC_SVID_CLK),
.FNIC_SVID_DATA (FNIC_SVID_DATA),
.nsc_ready_for_enum (nsc_ready_for_enum),
.i2c_smbalert_oe_n (i2c_smbalert_oe_n),
.EUSB2_EDM (EUSB2_EDM),
.EUSB2_EDP (EUSB2_EDP),
.EUSB2_RESREF (EUSB2_RESREF),
.EUSB2_ANALOGTEST (EUSB2_ANALOGTEST),
//.EUSB2_VBUS_VALID_EXT (EUSB2_VBUS_VALID_EXT),
.ETH_TXP0 (ETH_TXP0),
.ETH_TXN0 (ETH_TXN0),
.ETH_TXP1 (ETH_TXP1),
.ETH_TXN1 (ETH_TXN1),
.ETH_TXP2 (ETH_TXP2),
.ETH_TXN2 (ETH_TXN2),
.ETH_TXP3 (ETH_TXP3),
.ETH_TXN3 (ETH_TXN3),
.ETH_TXP4 (ETH_TXP4),
.ETH_TXN4 (ETH_TXN4),
.ETH_TXP5 (ETH_TXP5),
.ETH_TXN5 (ETH_TXN5),
.ETH_TXP6 (ETH_TXP6),
.ETH_TXN6 (ETH_TXN6),
.ETH_TXP7 (ETH_TXP7),
.ETH_TXN7 (ETH_TXN7),
.ETH_RXP0 (ETH_RXP0),
.ETH_RXN0 (ETH_RXN0),
.ETH_RXP1 (ETH_RXP1),
.ETH_RXN1 (ETH_RXN1),
.ETH_RXP2 (ETH_RXP2),
.ETH_RXN2 (ETH_RXN2),
.ETH_RXP3 (ETH_RXP3),
.ETH_RXN3 (ETH_RXN3),
.ETH_RXP4 (ETH_RXP4),
.ETH_RXN4 (ETH_RXN4),
.ETH_RXP5 (ETH_RXP5),
.ETH_RXN5 (ETH_RXN5),
.ETH_RXP6 (ETH_RXP6),
.ETH_RXN6 (ETH_RXN6),
.ETH_RXP7 (ETH_RXP7),
.ETH_RXN7 (ETH_RXN7),
.ETH_TXP8 (ETH_TXP8),
.ETH_TXN8 (ETH_TXN8),
.ETH_TXP9 (ETH_TXP9),
.ETH_TXN9 (ETH_TXN9),
.ETH_TXP10 (ETH_TXP10),
.ETH_TXN10 (ETH_TXN10),
.ETH_TXP11 (ETH_TXP11),
.ETH_TXN11 (ETH_TXN11),
.ETH_TXP12 (ETH_TXP12),
.ETH_TXN12 (ETH_TXN12),
.ETH_TXP13 (ETH_TXP13),
.ETH_TXN13 (ETH_TXN13),
.ETH_TXP14 (ETH_TXP14),
.ETH_TXN14 (ETH_TXN14),
.ETH_TXP15 (ETH_TXP15),
.ETH_TXN15 (ETH_TXN15),
.ETH_RXP8 (ETH_RXP8),
.ETH_RXN8 (ETH_RXN8),
.ETH_RXP9 (ETH_RXP9),
.ETH_RXN9 (ETH_RXN9),
.ETH_RXP10 (ETH_RXP10),
.ETH_RXN10 (ETH_RXN10),
.ETH_RXP11 (ETH_RXP11),
.ETH_RXN11 (ETH_RXN11),
.ETH_RXP12 (ETH_RXP12),
.ETH_RXN12 (ETH_RXN12),
.ETH_RXP13 (ETH_RXP13),
.ETH_RXN13 (ETH_RXN13),
.ETH_RXP14 (ETH_RXP14),
.ETH_RXN14 (ETH_RXN14),
.ETH_RXP15 (ETH_RXP15),
.ETH_RXN15 (ETH_RXN15),
.xioa_ck_pma_ref0_n (xioa_ck_pma_ref0_n),
.xioa_ck_pma_ref0_p (xioa_ck_pma_ref0_p),
.xioa_ck_pma_ref1_n (xioa_ck_pma_ref1_n),
.xioa_ck_pma_ref1_p (xioa_ck_pma_ref1_p),
.xoa_pma_dcmon1 (xoa_pma_dcmon1),
.xoa_pma_dcmon2 (xoa_pma_dcmon2),
//.nac_a0_debug_strap_0 (nac_a0_debug_strap_0),
.SPARE_B1 (SPARE_B1),
.SPARE_B2 (SPARE_B2),
.SPARE_B3 (SPARE_B3),
.axi2sb_gpsb_side_ism_fabric (axi2sb_gpsb_side_ism_fabric),
.axi2sb_gpsb_side_ism_agent (axi2sb_gpsb_side_ism_agent),
.axi2sb_gpsb_side_pok (axi2sb_gpsb_side_pok),
.axi2sb_gpsb_mnpput (axi2sb_gpsb_mnpput),
.axi2sb_gpsb_mpcput (axi2sb_gpsb_mpcput),
.axi2sb_gpsb_mnpcup (axi2sb_gpsb_mnpcup),
.axi2sb_gpsb_mpccup (axi2sb_gpsb_mpccup),
.axi2sb_gpsb_meom (axi2sb_gpsb_meom),
.axi2sb_gpsb_mpayload (axi2sb_gpsb_mpayload),
.axi2sb_gpsb_mparity (axi2sb_gpsb_mparity),
.axi2sb_gpsb_tnpput (axi2sb_gpsb_tnpput),
.axi2sb_gpsb_tpcput (axi2sb_gpsb_tpcput),
/*
.axi2sb_gpsb_tnpcup (axi2sb_gpsb_tnpcup),
.axi2sb_gpsb_tpccup (axi2sb_gpsb_tpccup),
.axi2sb_gpsb_teom (axi2sb_gpsb_teom),
.axi2sb_gpsb_tpayload (axi2sb_gpsb_tpayload),
.axi2sb_gpsb_tparity (axi2sb_gpsb_tparity),
.axi2sb_gpsb_strap_sourceid (axi2sb_gpsb_strap_sourceid),
.axi2sb_gpsb_strap_bridge_disable (axi2sb_gpsb_strap_bridge_disable),
.axi2sb_pmsb_side_ism_fabric (axi2sb_pmsb_side_ism_fabric),
.axi2sb_pmsb_side_ism_agent (axi2sb_pmsb_side_ism_agent),
.axi2sb_pmsb_side_pok (axi2sb_pmsb_side_pok),
.axi2sb_pmsb_mnpput (axi2sb_pmsb_mnpput),
.axi2sb_pmsb_mpcput (axi2sb_pmsb_mpcput),
.axi2sb_pmsb_mnpcup (axi2sb_pmsb_mnpcup),
.axi2sb_pmsb_mpccup (axi2sb_pmsb_mpccup),
.axi2sb_pmsb_meom (axi2sb_pmsb_meom),
.axi2sb_pmsb_mpayload (axi2sb_pmsb_mpayload),
.axi2sb_pmsb_mparity (axi2sb_pmsb_mparity),
.axi2sb_gpsb_tnpput(axi2sb_gpsb_tnpput),
.axi2sb_gpsb_tpcput(axi2sb_gpsb_tpcput),
*/
.axi2sb_gpsb_tnpcup(axi2sb_gpsb_tnpcup),
.axi2sb_gpsb_tpccup(axi2sb_gpsb_tpccup),
.axi2sb_gpsb_teom(axi2sb_gpsb_teom),
.axi2sb_gpsb_tpayload(axi2sb_gpsb_tpayload),
.axi2sb_gpsb_tparity(axi2sb_gpsb_tparity),
.axi2sb_gpsb_strap_sourceid(axi2sb_gpsb_strap_sourceid),
//.axi2sb_gpsb_strap_bridge_disable(axi2sb_gpsb_strap_bridge_disable),
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
//.axi2sb_pmsb_strap_bridge_disable(axi2sb_pmsb_strap_bridge_disable),
.XX_SYNCE_CLKOUT0(XX_SYNCE_CLKOUT0),
.XX_SYNCE_CLKOUT1(XX_SYNCE_CLKOUT1),
.boot_pll_adapt_rstw_resource_ready(boot_pll_adapt_rstw_resource_ready),
.nac_ss_debug_ecm_monout_cp_ana(nac_ss_debug_ecm_monout_cp_ana),
.XX_OPAD_SENSE_0p9(XX_OPAD_SENSE_0p9),
.s3m_time(s3m_time),
.XX_UART_HMP_TXD(XX_UART_HMP_TXD),
.XX_UART_HMP_RXD(XX_UART_HMP_RXD),
.XX_UART_HIF_TXD(XX_UART_HIF_TXD),
.XX_UART_HIF_RXD(XX_UART_HIF_RXD),
.XX_UART_USB_TXD(XX_UART_USB_TXD),
.XX_UART_USB_RXD(XX_UART_USB_RXD),
.XX_DEBUG_ACT_N(XX_DEBUG_ACT_N),
.ecm_boot_done(ecm_boot_done),
.nss_gpio_in(nss_gpio_in),
//.nss_gpio_nichot_b(nss_gpio_nichot_b),
.nss_gpio_oe_n(nss_gpio_oe_n),
.nss_gpio_out(nss_gpio_out),
.XX_PCIE0_PERST_N0(XX_PCIE0_PERST_N0),
.XX_PCIE0_PERST_N1(XX_PCIE0_PERST_N1),
.XX_PCIE0_PERST_N2(XX_PCIE0_PERST_N2),
.XX_PCIE0_PERST_N3(XX_PCIE0_PERST_N3),
.XX_MDIO_CLK(XX_MDIO_CLK),
.XX_MDIO_IN(XX_MDIO_IN),
.XX_MDIO_OEN(XX_MDIO_OEN),
.XX_MDIO_OUT(XX_MDIO_OUT),
.XX_ONE_PPS_OUT(XX_ONE_PPS_OUT),
.XX_UART_PHYSS_RXD(XX_UART_PHYSS_RXD),
.XX_UART_PHYSS_TXD(XX_UART_PHYSS_TXD),
.XX_NCSI_CLK(XX_NCSI_CLK),
.XX_NCSI_CRS_DV(XX_NCSI_CRS_DV),
.XX_NCSI_RX_ENB (XX_NCSI_RX_ENB),
.XX_NCSI_RX_EN_B(XX_NCSI_RX_EN_B),
.XX_NCSI_TX_EN(XX_NCSI_TX_EN),
.XX_NCSI_RXD0(XX_NCSI_RXD0),
.XX_NCSI_RXD1(XX_NCSI_RXD1),
.XX_NCSI_TXD0(XX_NCSI_TXD0),
.XX_NCSI_TXD1(XX_NCSI_TXD1),
.XX_NCSI_ARB_IN(XX_NCSI_ARB_IN),
.XX_NCSI_ARB_OUT(XX_NCSI_ARB_OUT),
.XX_SDP_TIMESYNC_3 (XX_SDP_TIMESYNC_3),
.sn2sfi_rst_pre_ind_n(sys_rst_n),
.reset_cmd_ack(reset_cmd_ack),
.reset_error(reset_error),
.warm_rst_qactive(warm_rst_qactive),
.warm_rst_qdeny(warm_rst_qdeny),
.warm_rst_qacceptn(warm_rst_qacceptn),
.warm_rst_qreqn(warm_rst_qreqn),
.rsrc_adapt_nac_dts0_fsa_rst_b(rsrc_adapt_nac_dts0_fsa_rst_b),
.rsrc_adapt_nac_dts1_fsa_rst_b(rsrc_adapt_nac_dts1_fsa_rst_b),
.rsrc_adapt_nac_dts2_fsa_rst_b(rsrc_adapt_nac_dts2_fsa_rst_b),
.rsrc_adapt_bootpll_fsa_rst_b(rsrc_adapt_bootpll_fsa_rst_b),
.rsrc_adapt_tspll_fsa_rst_b(rsrc_adapt_tspll_fsa_rst_b),
.rsrc_adapt_nsspll_fsa_rst_b(rsrc_adapt_nsspll_fsa_rst_b),
.rsrc_adapt_ethphysspll_fsa_rst_b(rsrc_adapt_ethphysspll_fsa_rst_b),
.cmulbuf_buttr_fsa_rst_b(cmulbuf_buttr_fsa_rst_b),
.cmulbuf_phy_ss_buttr_fsa_rst_b (cmulbuf_phy_ss_buttr_fsa_rst_b),
.XX_PCIE0_PERST_N0 (XX_PCIE0_PERST_N0),
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
.sn2iosf_sb_tpayload(sn2iosf_sb_tpayload)
);

`ifndef HLP_PHYSS_ONLY
`ifdef SPI_HW
assign XX_SPI_FPGA_SEL_DPN = 'b1;
assign XX_SPI_CS0_N_O      = XX_SPI_CS0_N ;
assign XX_SPI_CLK_O        = XX_SPI_CLK;
tristate_buf tristate_inst0(.in (XX_SPI_TXD[0]),.oe (~XX_SPI_OE_N[0]),.out(XX_SPI_RXD[0]),.pad(XX_SPI_IO_0));
tristate_buf tristate_inst1(.in (XX_SPI_TXD[1]),.oe (~XX_SPI_OE_N[1]),.out(XX_SPI_RXD[1]),.pad(XX_SPI_IO_1));
tristate_buf tristate_inst2(.in (XX_SPI_TXD[2]),.oe (~XX_SPI_OE_N[2]),.out(XX_SPI_RXD[2]),.pad(XX_SPI_IO_2));
tristate_buf tristate_inst3(.in (XX_SPI_TXD[3]),.oe (~XX_SPI_OE_N[3]),.out(XX_SPI_RXD[3]),.pad(XX_SPI_IO_3));

`else
tristate_buf tristate_inst0(.in (XX_SPI_TXD[0]),.oe (~XX_SPI_OE_N[0]),.out(XX_SPI_RXD[0]),.pad(SIO[0]));
tristate_buf tristate_inst1(.in (XX_SPI_TXD[1]),.oe (~XX_SPI_OE_N[1]),.out(XX_SPI_RXD[1]),.pad(SIO[1]));
tristate_buf tristate_inst2(.in (XX_SPI_TXD[2]),.oe (~XX_SPI_OE_N[2]),.out(XX_SPI_RXD[2]),.pad(SIO[2]));
tristate_buf tristate_inst3(.in (XX_SPI_TXD[3]),.oe (~XX_SPI_OE_N[3]),.out(XX_SPI_RXD[3]),.pad(SIO[3]));

`include "define_n25q512a.sv"

vps_n25q512a_sm #( 
    .PROGRAM_ALL_BITS       (PROGRAM_ALL_BITS    ),        
    .HAS_ADDITIONAL_RST     (HAS_ADDITIONAL_RST  ),
    .tPP                    (tPP                 ),
    .tSSE                   (tSSE                ),
    .tSE                    (tSE                 ),
    .tPP_VPPH               (tPP_VPPH            ),
    .tSE_VPPH               (tSE_VPPH            ),
    .tBE                    (tBE                 ),
    .tBE_VPPH               (tBE_VPPH            ),
    .tDE                    (tDE                 ),
    .tDE_VPPH               (tDE_VPPH            ),

`ifndef ON_BOARD_MEM
    .SFDP_FILE_NAME         (SFDP_FILE_NAME      )
    `endif

) spi_sm(
    .RST_N                  (sys_rst_n),//RST_N               ),        
    .clk2x                  (ephy_refclk               ),//TBD        
    .C                      (XX_SPI_CLK),//C                   ),         
    .S_N                    (XX_SPI_CS0_N),//S_N                 ),         
    .SIO0                   (SIO[0]                ),      
    .SIO1                   (SIO[1]                ),  
    `ifdef mgc_mx25um51245g
    .SIO2                   (SIO2_WP_N),
    `else
    .SIO2_WP_N              (SIO[2]           ), 
    `endif
    
    `ifndef ON_BOARD_MEM        
    .init_calib_complete    (init_calib_complete ),
    .mmcm_locked            (mmcm_locked         ), 
    `endif

    `ifdef OPI_EN // To use this define, set it in define.sv file
    .SIO4                   (SIO4                ),
    .SIO5                   (SIO5                ),
    .SIO6                   (SIO6                ),
    .SIO7                   (SIO7                ), 
    `endif
    `ifdef mgc_s25fs256t
    .RDY_BSY_N              (RD_BY               ),
    `endif
    `ifdef DQS_EN // To use this define, set it in define.sv file
    `ifdef mgc_mt35x
     .DQS                     (DQS                 ),
    `else
     .DS                     (DQS                 ),
    `endif
    `endif
    .SIO3                    (SIO[3]                )

);

`endif
`endif

`ifndef HLP_PHYSS_ONLY
//uart inst imc 
RED_VUART uart_inst(
	.tx(XX_UART_HMP_RXD),
	.rx(XX_UART_HMP_TXD)
);
`endif

`ifndef NMC_ONLY
`ifndef HLP_PHYSS_ONLY
//uart inst for hif
//uart inst
RED_VUART uart_inst_hifmc(
	.tx(nac_ss.nss.nss.hif_nocss_top.hifmc_UARTRXD),
	.rx(nac_ss.nss.nss.hif_nocss_top.hifmc_UARTTXD)
);

`endif
`endif

`ifndef HLP_PHYSS_STUB
`ifndef NAC_STUB
`ifndef NMC_ONLY

    `include "hlp_physs_forces.sv"
//Physs I2C registers interface

wire fpll_locked_SGMII;
wire xcvr_tx_serial_clk0;
wire pcs_ref_clk_125mhz_lock;
wire pcs_ref_clk_125mhz;
wire onpi_3_125mhz_clk;
wire sync_i_reset;
wire fpll_locked_SGMII;
wire rx_clk_out;
wire [9:0] tbi_rx_phy;
wire [9:0] tbi_tx_phy;
wire [31:0] usr_cntrl_0;
wire rx_serial_data;
wire tx_serial_data;
wire [3:0] pcs_loopback_en;
wire [3:0] serdes_loopback_en;
wire i_cfg_pcs_loopback;

assign usr_cntrl_0[3:0] = i_cfg_pcs_loopback ? 4'b0010 : 4'b0000;

s10_fpll_ref125Mhz_625Mhz u_s10_fpll_ref125Mhz_625Mhz 
     (
        .pll_refclk0    (clk_125mhz)
       ,.pll_cal_busy   ()
       ,.pll_locked     (fpll_locked_SGMII)
       ,.tx_serial_clk  (xcvr_tx_serial_clk0)
     );

io_pll_125mhz_eth_clks io_pll_125mhz_eth_clks
     (
	    //.rst  (i_reset),
	    .rst  (1'b0),
      .refclk (clk_125mhz),
      .locked (pcs_ref_clk_125mhz_lock),
      .outclk_0 (pcs_ref_clk_125mhz),
      .outclk_1 (onpi_3_125mhz_clk)
     );

IW_sync_reset IW_sync_reset
  (

     .clk(pcs_ref_clk_125mhz),
     .rst_n (i_reset),
     .rst_n_sync(sync_i_reset)

  );

ethernet_altera_phy u0_ethernet_altera_phy (

    .pcs_ref_clk_125mhz (pcs_ref_clk_125mhz),
    .xcvr_125mhz_refclk (clk_125mhz),
    .xcvr_reset  (sync_i_reset),
    .xcvr_tx_serial_clk0  (xcvr_tx_serial_clk0),
    .fpll_locked_SGMII   (fpll_locked_SGMII),    
    .xcvr_rx_clk (rx_clk_out),
    .xcvr_tbi_rx_gmii(tbi_rx_phy),
    .xcvr_tbi_tx_gmii(tbi_tx_phy),
    .usr_cntrl_0   (usr_cntrl_0[3:0]),
    .fpga_pcs_loopback_ena (pcs_loopback_en[0]),
    .fpga_serdes_loopback_ena (serdes_loopback_en[0]),
    .xcvr_rx_serial_data  (rx_serial_data),          // SGMII_PHY_S10 from board    
    .xcvr_tx_serial_data  (tx_serial_data)           // SGMIIS_S10_PHY from board   
);
    //I2C Interface Signals
    logic           i2c_psel            ;   //  APB Peripheral Select Signal
    logic           i2c_penable         ;   //  Strobe Signal
    logic           i2c_pwrite          ;   //  Write Signal
    logic   [2:0]   i2c_pprot           ;   //  Protection Signal
    logic   [3:0]   i2c_pstrb           ;   //  Write Strobes
    logic   [7:0]   i2c_paddr           ;   //  Address Bus
    logic   [31:0]  i2c_pwdata          ;   //  Write Data Bus

    logic   [31:0]  i2c_prdata          ;   //  APB read data bus.
    logic           i2c_pready          ;   //  Slave ready
    logic           i2c_pslverr         ;   //  Slave error

    logic           i2c_clk_in          ;   //  Incoming I2C clock
    logic           i2c_data_in         ;   //  Incoming I2C Data

    logic           i2c_clk_oe_n        ;   //# Outgoing I2C clock: Open drain synchronous with i2c_clk
    logic           i2c_data_oe_n       ;   //# Outgoing I2C Data: Open Drain. Synchronous to i2c_clk
    
 
tristate_buf tristate_inst_scl1(.in (1'b0),.oe (i2c_clk_oe),.out(i2c_clk_in),.pad(I2C_SCL));
tristate_buf tristate_inst_scl2(.in (1'b0),.oe (i2c_data_oe),.out(i2c_data_in),.pad(I2C_SDA));

assign cnic_wrapper.nac_ss.physs.physs0.parmquad0.pcs100_wrap_0.quadpcs100_0.sg0_sgpcs_ena_s = 1'b1;
assign cnic_wrapper.nac_ss.physs.physs0.parmquad0.pcs100_wrap_0.quadpcs100_0.sg0_speed_s[1:0] = 2'b10;


//I2C Master
RED_VAPB #(
      .APB_ADDRESS_WIDTH   ( 12           ),
      .APB_DATA_WIDTH      ( 32           ),
      .DUT_CLK_PROVIDED    ( 1            )
    ) phy_i2c_vapb_master (
       // APB interface
      .u_apb_pclk          (  i2c_apb_clk     ), 
      .u_apb_presetn       (   sys_rst_n ), 
      .u_apb_psel          (  i2c_psel     ), 
      .u_apb_penable       (  i2c_penable  ), 
      .u_apb_pwrite        (  i2c_pwrite   ), 
      .u_apb_paddr         (  i2c_paddr    ), 
      .u_apb_pwdata        (  i2c_pwdata   ), 
      .u_apb_prdata        (  i2c_prdata   ), 
      .u_apb_pready        (  i2c_pready   ), 
      .u_apb_pslverr       (  i2c_pslverr  ), 
                                               
      .dut_apb_pclk        ( i2c_apb_clk ),
      .dut_apb_presetn     ( sys_rst_n )
  );

   Imc_DW_apb_i2c
        A00_i2c (
        .pclk               (   i2c_apb_clk             ),  //  APB Clock Signal
        .presetn            (   sys_rst_n  ),  //  APB Reset Signal (active low)
        .psel               (   i2c_psel            ),  //  APB Peripheral Select Signal
        .penable            (   i2c_penable         ),  //  Strobe Signal
        .pprot              (   i2c_pprot           ),  //  Protection Signal
        //.pstrb              (   i2c_pstrb           ),  //  Write Strobes
        .pstrb              (   4'b1111           ),  //  Write Strobes
        .pwrite             (   i2c_pwrite          ),  //  Write Signal
        .paddr              (   i2c_paddr           ),  //  Address Bus
        .pwdata             (   i2c_pwdata          ),  //  Write Data Bus
        .prdata             (   i2c_prdata          ),  //  APB read data bus.
        .pready             (   i2c_pready          ),  //  Slave ready
        .pslverr            (   i2c_pslverr         ),  //  Slave error
        .ic_rst_n           (   sys_rst_n  ),
        .ic_clk             (   i2c_apb_clk           ),  //  I2C clock 50Kz
        .ic_clk_in_a        (   i2c_clk_in          ),  //  Incoming I2C clock
        .ic_data_in_a       (   i2c_data_in         ),  //  Incoming I2C Data
        .ic_clk_oe          (   i2c_clk_oe          ),
        .ic_data_oe         (   i2c_data_oe         ),
        .ic_en              (                       ), // ic_en indicates whether the I2C/SMBus module is enabled. Some registers can only be programmed when the ic_en is set to 0.
        .ic_smbsus_in_n     (   1'h1                ),  //  SMBUS Suspend in
        .ic_smbalert_in_n   (   1'b0                ),  //  SMBUS alert in,
        .ic_smbsus_out_n    (                       ),  //  SMBUS Suspend out
        .ic_smbalert_oe     (       ),  //  SMBUS Alert out
        .ic_intr            (               ),  //  Combined Interrupt
        .debug_s_gen        (            ),
        .debug_p_gen        (            ),
        .debug_data         (             ),
        .debug_addr         (             ),
        .debug_rd           (               ),
        .debug_wr           (               ),
        .debug_hs           (               ),
        .debug_master_act   (       ),
        .debug_slave_act    (        ),
        .debug_addr_10bit   (       ),
        .debug_mst_cstate   (       ),
        .debug_slv_cstate   (       ),
	.debug_ic_operating_mode (			));

//###Register interface
logic [4:0] phy_config_vector;
logic [15:0] phy_status_vector;
assign phy_status_vector   ={16'hDEADBEEF};
assign phy_config_vector   ={5'h1C};
           
RED_VAPB #(
      .APB_ADDRESS_WIDTH   ( 12           ),
      .APB_DATA_WIDTH      ( 32           ),
      .DUT_CLK_PROVIDED    ( 1            )
    ) phy_regbank (
       // APB interface
      .u_apb_pclk          (  i2c_apb_clk     ), 
      .u_apb_presetn       (  sys_rst_n  ), 
      .u_apb_psel          (  apb_psel     ), 
      .u_apb_penable       (  apb_penable  ), 
      .u_apb_pwrite        (  apb_pwrite   ), 
      .u_apb_paddr         (  apb_paddr    ), 
      .u_apb_pwdata        (  apb_pwdata   ), 
      .u_apb_prdata        (  apb_prdata   ), 
      .u_apb_pready        (  apb_pready   ), 
      .u_apb_pslverr       (  apb_pslverr  ), 
                                               
      .dut_apb_pclk        ( i2c_apb_clk ),
      .dut_apb_presetn     ( sys_rst_n)
  );

    phy_regbank
 #(                                                           
    
    ) u_phy_regbank
 (   
      // Connect to APB 1
      .apb_prdata           (apb_prdata),    
      .apb_pready           (apb_pready),    
      .apb_pslverr          (apb_pslverr),   
      .apb_clk              (i2c_apb_clk),     
      .apb_reset            (~sys_rst_n),   
      .apb_psel             (apb_psel),     
      .apb_penable          (apb_penable),   
      .apb_pwrite           (apb_pwrite),    
      .apb_pwdata           (apb_pwdata),    
      .apb_paddr            (apb_paddr),     
                                          
      // Reg values
      .phy_config_vector    (phy_config_vector),  //RW                
      .phy_status_vector    (phy_status_vector),  // RO                  
      .an_config_vector     (), //an_config_vector),
      .an_restart           (), //an_restart),
      .an_status            (1'b0), //an_status),
      .misc_rd1             ({32'h12345678})  //Debug
    ); 
`endif
`endif
`endif
//`ifdef ON_BOARD_MEM
//initial begin
//  $readmemh ("./SFDP_CFI_ARRAY.hex",dut.sf_core.sf_ID_mem.SFDP_CFI_ARRAY);
//  $readmemh ("./full_memory.hex",dut.sf_core.mem_0.i_memArray);
//end
//`endif
endmodule
