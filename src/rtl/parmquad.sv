/*------------------------------------------------------------------------------
  INTEL CONFIDENTIAL
  Copyright 2022 Intel Corporation All Rights Reserved.
  -----------------------------------------------------------------------------*/

module parmquad
// EDIT_PORT BEGIN
 ( 
input ETH_RXN0,
input ETH_RXP0,
input ETH_RXN1,
input ETH_RXP1,
input ETH_RXN2,
input ETH_RXP2,
input ETH_RXN3,
input ETH_RXP3,
output versa_xmp_0_xoa_pma0_tx_n_l0,
output versa_xmp_0_xoa_pma0_tx_p_l0,
output versa_xmp_0_xoa_pma1_tx_n_l0,
output versa_xmp_0_xoa_pma1_tx_p_l0,
output versa_xmp_0_xoa_pma2_tx_n_l0,
output versa_xmp_0_xoa_pma2_tx_p_l0,
output versa_xmp_0_xoa_pma3_tx_n_l0,
output versa_xmp_0_xoa_pma3_tx_p_l0,
inout wire ioa_pma_remote_diode_i_anode,
inout wire ioa_pma_remote_diode_i_anode_0,
inout wire ioa_pma_remote_diode_i_anode_1,
inout wire ioa_pma_remote_diode_i_anode_2,
inout wire ioa_pma_remote_diode_v_anode,
inout wire ioa_pma_remote_diode_v_anode_0,
inout wire ioa_pma_remote_diode_v_anode_1,
inout wire ioa_pma_remote_diode_v_anode_2,
inout wire ioa_pma_remote_diode_i_cathode,
inout wire ioa_pma_remote_diode_i_cathode_0,
inout wire ioa_pma_remote_diode_i_cathode_1,
inout wire ioa_pma_remote_diode_i_cathode_2,
inout wire ioa_pma_remote_diode_v_cathode,
inout wire ioa_pma_remote_diode_v_cathode_0,
inout wire ioa_pma_remote_diode_v_cathode_1,
inout wire ioa_pma_remote_diode_v_cathode_2,
output [3:0] quadpcs100_0_pcs_link_status,
output versa_xmp_0_o_ck_pma0_rx_postdiv_l0,
output versa_xmp_0_o_ck_pma1_rx_postdiv_l0,
output versa_xmp_0_o_ck_pma2_rx_postdiv_l0,
output versa_xmp_0_o_ck_pma3_rx_postdiv_l0,
input physs_func_rst_raw_n,
input soc_per_clk_adop_parmisc_physs0_clkout,
input physs_func_clk_adop_parmisc_physs0_clkout_0,
input timeref_clk_adop_parmisc_physs0_clkout_0,
output physs_clock_sync_0_physs_func_clk_gated_100_0,
output physs_clock_sync_0_func_rstn_fabric_sync_0,
output hlp_mac_rx_throttle_0_stop,
output hlp_mac_rx_throttle_1_stop,
output hlp_mac_rx_throttle_2_stop,
output hlp_mac_rx_throttle_3_stop,
input tx_stop_0_in,
input tx_stop_1_in,
input tx_stop_2_in,
input tx_stop_3_in,
input [7:0] physs_rfhs_trim_fuse_in,
input [15:0] physs_hdspsr_trim_fuse_in,
input [5:0] physs_hdp2prf_trim_fuse_in,
input [5:0] physs_hd2prf_trim_fuse_in,
output mac100_0_pfc_mode,
output mac100_1_pfc_mode,
output mac100_2_pfc_mode,
output mac100_3_pfc_mode,
output mac100_0_magic_ind_0,
output mac100_1_magic_ind_0,
output mac100_2_magic_ind_0,
output mac100_3_magic_ind_0,
input [7:0] icq_physs_net_xoff,
input [7:0] icq_physs_net_xoff_0,
input [7:0] icq_physs_net_xoff_1,
input [7:0] icq_physs_net_xoff_2,
output [7:0] mac100_0_pause_on_0,
output [7:0] mac100_1_pause_on_0,
output [7:0] mac100_2_pause_on_0,
output [7:0] mac100_3_pause_on_0,
output [7:0] quadpcs100_0_pcs_tsu_rx_sd_0,
output [1:0] quadpcs100_0_mii_rx_tsu_mux0_0,
output [1:0] quadpcs100_0_mii_rx_tsu_mux1_0,
output [1:0] quadpcs100_0_mii_rx_tsu_mux2_0,
output [1:0] quadpcs100_0_mii_rx_tsu_mux3_0,
output [7:0] quadpcs100_0_mii_tx_tsu_0,
output [27:0] quadpcs100_0_pcs_desk_buf_rlevel_3,
output [31:0] quadpcs100_0_pcs_sd_bit_slip_0,
output [3:0] quadpcs100_0_pcs_link_status_tsu_0,
inout wire versa_xmp_0_xioa_ck_pma0_ref0_n,
inout wire versa_xmp_0_xioa_ck_pma0_ref0_p,
inout wire versa_xmp_0_xioa_ck_pma0_ref1_n,
inout wire versa_xmp_0_xioa_ck_pma0_ref1_p,
inout wire versa_xmp_0_xioa_ck_pma1_ref0_n,
inout wire versa_xmp_0_xioa_ck_pma1_ref0_p,
inout wire versa_xmp_0_xioa_ck_pma1_ref1_n,
inout wire versa_xmp_0_xioa_ck_pma1_ref1_p,
inout wire versa_xmp_0_xioa_ck_pma2_ref0_n,
inout wire versa_xmp_0_xioa_ck_pma2_ref0_p,
inout wire versa_xmp_0_xioa_ck_pma2_ref1_n,
inout wire versa_xmp_0_xioa_ck_pma2_ref1_p,
inout wire versa_xmp_0_xioa_ck_pma3_ref0_n,
inout wire versa_xmp_0_xioa_ck_pma3_ref0_p,
inout wire versa_xmp_0_xioa_ck_pma3_ref1_n,
inout wire versa_xmp_0_xioa_ck_pma3_ref1_p,
input rclk_diff_p,
input rclk_diff_n,
output versa_xmp_0_xoa_pma0_dcmon1,
output versa_xmp_0_xoa_pma0_dcmon2,
output versa_xmp_0_xoa_pma1_dcmon1,
output versa_xmp_0_xoa_pma1_dcmon2,
output versa_xmp_0_xoa_pma2_dcmon1,
output versa_xmp_0_xoa_pma2_dcmon2,
output versa_xmp_0_xoa_pma3_dcmon1,
output versa_xmp_0_xoa_pma3_dcmon2,
output quad_interrupts_0_physs_fatal_int,
output quad_interrupts_0_physs_imc_int,
output quad_interrupts_0_mac800_int,
output versa_xmp_0_o_ucss_irq_cpi_0_a,
output versa_xmp_0_o_ucss_irq_cpi_1_a,
output versa_xmp_0_o_ucss_irq_cpi_2_a,
output versa_xmp_0_o_ucss_irq_cpi_3_a,
output versa_xmp_0_o_ucss_irq_cpi_4_a,
output versa_xmp_0_o_ucss_irq_status_a,
output nic_switch_mux_0_hlp_xlgmii0_txclk_ena,
output nic_switch_mux_0_hlp_xlgmii0_rxclk_ena,
output [7:0] nic_switch_mux_0_hlp_xlgmii0_rxc,
output [63:0] nic_switch_mux_0_hlp_xlgmii0_rxd,
output nic_switch_mux_0_hlp_xlgmii0_rxt0_next,
input [7:0] hlp_xlgmii0_txc_0,
input [63:0] hlp_xlgmii0_txd_0,
output nic_switch_mux_0_hlp_xlgmii1_txclk_ena,
output nic_switch_mux_0_hlp_xlgmii1_rxclk_ena,
output [7:0] nic_switch_mux_0_hlp_xlgmii1_rxc,
output [63:0] nic_switch_mux_0_hlp_xlgmii1_rxd,
output nic_switch_mux_0_hlp_xlgmii1_rxt0_next,
input [7:0] hlp_xlgmii1_txc_0,
input [63:0] hlp_xlgmii1_txd_0,
output nic_switch_mux_0_hlp_xlgmii2_txclk_ena,
output nic_switch_mux_0_hlp_xlgmii2_rxclk_ena,
output [7:0] nic_switch_mux_0_hlp_xlgmii2_rxc,
output [63:0] nic_switch_mux_0_hlp_xlgmii2_rxd,
output nic_switch_mux_0_hlp_xlgmii2_rxt0_next,
input [7:0] hlp_xlgmii2_txc_0,
input [63:0] hlp_xlgmii2_txd_0,
output nic_switch_mux_0_hlp_xlgmii3_txclk_ena,
output nic_switch_mux_0_hlp_xlgmii3_rxclk_ena,
output [7:0] nic_switch_mux_0_hlp_xlgmii3_rxc,
output [63:0] nic_switch_mux_0_hlp_xlgmii3_rxd,
output nic_switch_mux_0_hlp_xlgmii3_rxt0_next,
input [7:0] hlp_xlgmii3_txc_0,
input [63:0] hlp_xlgmii3_txd_0,
output [127:0] nic_switch_mux_0_hlp_cgmii0_rxd,
output [15:0] nic_switch_mux_0_hlp_cgmii0_rxc,
output nic_switch_mux_0_hlp_cgmii0_rxclk_ena,
input [127:0] hlp_cgmii0_txd_0,
input [15:0] hlp_cgmii0_txc_0,
output nic_switch_mux_0_hlp_cgmii0_txclk_ena,
output [127:0] nic_switch_mux_0_hlp_cgmii1_rxd,
output [15:0] nic_switch_mux_0_hlp_cgmii1_rxc,
output nic_switch_mux_0_hlp_cgmii1_rxclk_ena,
input [127:0] hlp_cgmii1_txd_0,
input [15:0] hlp_cgmii1_txc_0,
output nic_switch_mux_0_hlp_cgmii1_txclk_ena,
output [127:0] nic_switch_mux_0_hlp_cgmii2_rxd,
output [15:0] nic_switch_mux_0_hlp_cgmii2_rxc,
output nic_switch_mux_0_hlp_cgmii2_rxclk_ena,
input [127:0] hlp_cgmii2_txd_0,
input [15:0] hlp_cgmii2_txc_0,
output nic_switch_mux_0_hlp_cgmii2_txclk_ena,
output [127:0] nic_switch_mux_0_hlp_cgmii3_rxd,
output [15:0] nic_switch_mux_0_hlp_cgmii3_rxc,
output nic_switch_mux_0_hlp_cgmii3_rxclk_ena,
input [127:0] hlp_cgmii3_txd_0,
input [15:0] hlp_cgmii3_txc_0,
output nic_switch_mux_0_hlp_cgmii3_txclk_ena,
input hlp_xlgmii0_txclk_ena_nss_0,
input hlp_xlgmii0_rxclk_ena_nss_0,
input [7:0] hlp_xlgmii0_rxc_nss_0,
input [63:0] hlp_xlgmii0_rxd_nss_0,
input hlp_xlgmii0_rxt0_next_nss_0,
output [7:0] nic_switch_mux_0_hlp_xlgmii0_txc_nss,
output [63:0] nic_switch_mux_0_hlp_xlgmii0_txd_nss,
input hlp_xlgmii1_txclk_ena_nss_0,
input hlp_xlgmii1_rxclk_ena_nss_0,
input [7:0] hlp_xlgmii1_rxc_nss_0,
input [63:0] hlp_xlgmii1_rxd_nss_0,
input hlp_xlgmii1_rxt0_next_nss_0,
output [7:0] nic_switch_mux_0_hlp_xlgmii1_txc_nss,
output [63:0] nic_switch_mux_0_hlp_xlgmii1_txd_nss,
input hlp_xlgmii2_txclk_ena_nss_0,
input hlp_xlgmii2_rxclk_ena_nss_0,
input [7:0] hlp_xlgmii2_rxc_nss_0,
input [63:0] hlp_xlgmii2_rxd_nss_0,
input hlp_xlgmii2_rxt0_next_nss_0,
output [7:0] nic_switch_mux_0_hlp_xlgmii2_txc_nss,
output [63:0] nic_switch_mux_0_hlp_xlgmii2_txd_nss,
input hlp_xlgmii3_txclk_ena_nss_0,
input hlp_xlgmii3_rxclk_ena_nss_0,
input [7:0] hlp_xlgmii3_rxc_nss_0,
input [63:0] hlp_xlgmii3_rxd_nss_0,
input hlp_xlgmii3_rxt0_next_nss_0,
output [7:0] nic_switch_mux_0_hlp_xlgmii3_txc_nss,
output [63:0] nic_switch_mux_0_hlp_xlgmii3_txd_nss,
input [127:0] hlp_cgmii0_rxd_nss_0,
input [15:0] hlp_cgmii0_rxc_nss_0,
input hlp_cgmii0_rxclk_ena_nss_0,
output [127:0] nic_switch_mux_0_hlp_cgmii0_txd_nss,
output [15:0] nic_switch_mux_0_hlp_cgmii0_txc_nss,
input hlp_cgmii0_txclk_ena_nss_0,
input [127:0] hlp_cgmii1_rxd_nss_0,
input [15:0] hlp_cgmii1_rxc_nss_0,
input hlp_cgmii1_rxclk_ena_nss_0,
output [127:0] nic_switch_mux_0_hlp_cgmii1_txd_nss,
output [15:0] nic_switch_mux_0_hlp_cgmii1_txc_nss,
input hlp_cgmii1_txclk_ena_nss_0,
input [127:0] hlp_cgmii2_rxd_nss_0,
input [15:0] hlp_cgmii2_rxc_nss_0,
input hlp_cgmii2_rxclk_ena_nss_0,
output [127:0] nic_switch_mux_0_hlp_cgmii2_txd_nss,
output [15:0] nic_switch_mux_0_hlp_cgmii2_txc_nss,
input hlp_cgmii2_txclk_ena_nss_0,
input [127:0] hlp_cgmii3_rxd_nss_0,
input [15:0] hlp_cgmii3_rxc_nss_0,
input hlp_cgmii3_rxclk_ena_nss_0,
output [127:0] nic_switch_mux_0_hlp_cgmii3_txd_nss,
output [15:0] nic_switch_mux_0_hlp_cgmii3_txc_nss,
input hlp_cgmii3_txclk_ena_nss_0,
input mse_physs_port_0_ts_capture_vld,
input [6:0] mse_physs_port_0_ts_capture_idx,
input mse_physs_port_1_ts_capture_vld,
input [6:0] mse_physs_port_1_ts_capture_idx,
input mse_physs_port_2_ts_capture_vld,
input [6:0] mse_physs_port_2_ts_capture_idx,
input mse_physs_port_3_ts_capture_vld,
input [6:0] mse_physs_port_3_ts_capture_idx,
output fifo_mux_0_physs_icq_port_0_link_stat,
output [3:0] fifo_mux_0_physs_mse_port_0_link_speed,
output fifo_mux_0_physs_mse_port_0_rx_dval,
output [1023:0] fifo_mux_0_physs_mse_port_0_rx_data,
output fifo_mux_0_physs_mse_port_0_rx_sop,
output fifo_mux_0_physs_mse_port_0_rx_eop,
output [6:0] fifo_mux_0_physs_mse_port_0_rx_mod,
output fifo_mux_0_physs_mse_port_0_rx_err,
output fifo_mux_0_physs_mse_port_0_rx_ecc_err,
input fifo_top_mux_0_mse_physs_port_0_rx_rdy,
output [38:0] fifo_mux_0_physs_mse_port_0_rx_ts,
input fifo_top_mux_0_mse_physs_port_0_tx_wren,
input [1023:0] fifo_top_mux_0_mse_physs_port_0_tx_data,
input fifo_top_mux_0_mse_physs_port_0_tx_sop,
input fifo_top_mux_0_mse_physs_port_0_tx_eop,
input [6:0] fifo_top_mux_0_mse_physs_port_0_tx_mod,
input fifo_top_mux_0_mse_physs_port_0_tx_err,
input fifo_top_mux_0_mse_physs_port_0_tx_crc,
output fifo_mux_0_physs_mse_port_0_tx_rdy,
output fifo_mux_0_physs_icq_port_1_link_stat,
output [3:0] fifo_mux_0_physs_mse_port_1_link_speed,
output fifo_mux_0_physs_mse_port_1_rx_dval,
output [1023:0] fifo_mux_0_physs_mse_port_1_rx_data,
output fifo_mux_0_physs_mse_port_1_rx_sop,
output fifo_mux_0_physs_mse_port_1_rx_eop,
output [6:0] fifo_mux_0_physs_mse_port_1_rx_mod,
output fifo_mux_0_physs_mse_port_1_rx_err,
output fifo_mux_0_physs_mse_port_1_rx_ecc_err,
input fifo_top_mux_0_mse_physs_port_1_rx_rdy,
output [38:0] fifo_mux_0_physs_mse_port_1_rx_ts,
input fifo_top_mux_0_mse_physs_port_1_tx_wren,
input [1023:0] fifo_top_mux_0_mse_physs_port_1_tx_data,
input fifo_top_mux_0_mse_physs_port_1_tx_sop,
input fifo_top_mux_0_mse_physs_port_1_tx_eop,
input [6:0] fifo_top_mux_0_mse_physs_port_1_tx_mod,
input fifo_top_mux_0_mse_physs_port_1_tx_err,
input fifo_top_mux_0_mse_physs_port_1_tx_crc,
output fifo_mux_0_physs_mse_port_1_tx_rdy,
output fifo_mux_0_physs_icq_port_2_link_stat,
output [3:0] fifo_mux_0_physs_mse_port_2_link_speed,
output fifo_mux_0_physs_mse_port_2_rx_dval,
output [1023:0] fifo_mux_0_physs_mse_port_2_rx_data,
output fifo_mux_0_physs_mse_port_2_rx_sop,
output fifo_mux_0_physs_mse_port_2_rx_eop,
output [6:0] fifo_mux_0_physs_mse_port_2_rx_mod,
output fifo_mux_0_physs_mse_port_2_rx_err,
output fifo_mux_0_physs_mse_port_2_rx_ecc_err,
input fifo_top_mux_0_mse_physs_port_2_rx_rdy,
output [38:0] fifo_mux_0_physs_mse_port_2_rx_ts,
input fifo_top_mux_0_mse_physs_port_2_tx_wren,
input [1023:0] fifo_top_mux_0_mse_physs_port_2_tx_data,
input fifo_top_mux_0_mse_physs_port_2_tx_sop,
input fifo_top_mux_0_mse_physs_port_2_tx_eop,
input [6:0] fifo_top_mux_0_mse_physs_port_2_tx_mod,
input fifo_top_mux_0_mse_physs_port_2_tx_err,
input fifo_top_mux_0_mse_physs_port_2_tx_crc,
output fifo_mux_0_physs_mse_port_2_tx_rdy,
output fifo_mux_0_physs_icq_port_3_link_stat,
output [3:0] fifo_mux_0_physs_mse_port_3_link_speed,
output fifo_mux_0_physs_mse_port_3_rx_dval,
output [1023:0] fifo_mux_0_physs_mse_port_3_rx_data,
output fifo_mux_0_physs_mse_port_3_rx_sop,
output fifo_mux_0_physs_mse_port_3_rx_eop,
output [6:0] fifo_mux_0_physs_mse_port_3_rx_mod,
output fifo_mux_0_physs_mse_port_3_rx_err,
output fifo_mux_0_physs_mse_port_3_rx_ecc_err,
input fifo_top_mux_0_mse_physs_port_3_rx_rdy,
output [38:0] fifo_mux_0_physs_mse_port_3_rx_ts,
input fifo_top_mux_0_mse_physs_port_3_tx_wren,
input [1023:0] fifo_top_mux_0_mse_physs_port_3_tx_data,
input fifo_top_mux_0_mse_physs_port_3_tx_sop,
input fifo_top_mux_0_mse_physs_port_3_tx_eop,
input [6:0] fifo_top_mux_0_mse_physs_port_3_tx_mod,
input fifo_top_mux_0_mse_physs_port_3_tx_err,
input fifo_top_mux_0_mse_physs_port_3_tx_crc,
output fifo_mux_0_physs_mse_port_3_tx_rdy,
input [31:0] nic400_physs_0_awaddr_master_quad0_out,
input [7:0] nic400_physs_0_awlen_master_quad0,
input [2:0] nic400_physs_0_awsize_master_quad0,
input [1:0] nic400_physs_0_awburst_master_quad0,
input nic400_physs_0_awlock_master_quad0,
input [3:0] nic400_physs_0_awcache_master_quad0,
input [2:0] nic400_physs_0_awprot_master_quad0,
input nic400_physs_0_awvalid_master_quad0,
output nic400_quad_0_awready_slave_quad_if0,
input [31:0] nic400_physs_0_wdata_master_quad0,
input [3:0] nic400_physs_0_wstrb_master_quad0,
input nic400_physs_0_wlast_master_quad0,
input nic400_physs_0_wvalid_master_quad0,
output nic400_quad_0_wready_slave_quad_if0,
output [1:0] nic400_quad_0_bresp_slave_quad_if0,
output nic400_quad_0_bvalid_slave_quad_if0,
input nic400_physs_0_bready_master_quad0,
input [31:0] nic400_physs_0_araddr_master_quad0_out,
input [7:0] nic400_physs_0_arlen_master_quad0,
input [2:0] nic400_physs_0_arsize_master_quad0,
input [1:0] nic400_physs_0_arburst_master_quad0,
input nic400_physs_0_arlock_master_quad0,
input [3:0] nic400_physs_0_arcache_master_quad0,
input [2:0] nic400_physs_0_arprot_master_quad0,
input nic400_physs_0_arvalid_master_quad0,
output nic400_quad_0_arready_slave_quad_if0,
output [31:0] nic400_quad_0_rdata_slave_quad_if0,
output [1:0] nic400_quad_0_rresp_slave_quad_if0,
output nic400_quad_0_rlast_slave_quad_if0,
output nic400_quad_0_rvalid_slave_quad_if0,
input nic400_physs_0_rready_master_quad0,
input mdio_in,
output mac100_0_mdc,
output mac100_0_mdio_out,
output mac100_0_mdio_oen_0,
inout wire [3:0] physs0_ioa_ck_pma0_ref_left_mquad0_physs0,
inout wire [3:0] physs0_ioa_ck_pma3_ref_right_mquad0_physs0,
output [1:0] quad_interrupts_0_mac400_int,
output [3:0] quad_interrupts_0_mac100_int,
input [1:0] physs_timesync_sync_val,
output physs_timestamp_0_ts_int,
output [3:0] physs_timestamp_0_o_int,
output [6:0] quadpcs100_0_pcs_desk_buf_rlevel_4,
output [6:0] quadpcs100_0_pcs_desk_buf_rlevel_5,
output [6:0] quadpcs100_0_pcs_desk_buf_rlevel_6,
output [6:0] quadpcs100_0_pcs_desk_buf_rlevel_7 );
// EDIT_PORT END


// EDIT_NET BEGIN
logic physs_funcby2rst_inv_parmquad0_o1 ; 
logic physs_funcby2_clk_pdop_parmquad0_clkout ; 
logic physs_clock_sync_0_func_rstn_fabric_sync ; 
logic soc_per_clk_pdop_parmquad0_clkout ; 
logic nic400_quad_0_hselx_mac100_0 ; 
logic [17:0] nic400_quad_0_haddr_mac100_0_out ; 
logic [1:0] nic400_quad_0_htrans_mac100_0 ; 
logic nic400_quad_0_hwrite_mac100_0 ; 
logic [2:0] nic400_quad_0_hsize_mac100_0 ; 
logic [31:0] nic400_quad_0_hwdata_mac100_0 ; 
logic nic400_quad_0_hready_mac100_0 ; 
logic [31:0] mac100_ahb_bridge_0_hrdata ; 
wire mac100_ahb_bridge_0_hresp ; 
wire mac100_ahb_bridge_0_hreadyout ; 
logic nic400_quad_0_hselx_mac100_1 ; 
logic [17:0] nic400_quad_0_haddr_mac100_1_out ; 
logic [1:0] nic400_quad_0_htrans_mac100_1 ; 
logic nic400_quad_0_hwrite_mac100_1 ; 
logic [2:0] nic400_quad_0_hsize_mac100_1 ; 
logic [31:0] nic400_quad_0_hwdata_mac100_1 ; 
logic nic400_quad_0_hready_mac100_1 ; 
logic [31:0] mac100_ahb_bridge_1_hrdata ; 
wire mac100_ahb_bridge_1_hresp ; 
wire mac100_ahb_bridge_1_hreadyout ; 
logic nic400_quad_0_hselx_mac100_2 ; 
logic [17:0] nic400_quad_0_haddr_mac100_2_out ; 
logic [1:0] nic400_quad_0_htrans_mac100_2 ; 
logic nic400_quad_0_hwrite_mac100_2 ; 
logic [2:0] nic400_quad_0_hsize_mac100_2 ; 
logic [31:0] nic400_quad_0_hwdata_mac100_2 ; 
logic nic400_quad_0_hready_mac100_2 ; 
logic [31:0] mac100_ahb_bridge_2_hrdata ; 
wire mac100_ahb_bridge_2_hresp ; 
wire mac100_ahb_bridge_2_hreadyout ; 
logic nic400_quad_0_hselx_mac100_3 ; 
logic [17:0] nic400_quad_0_haddr_mac100_3_out ; 
logic [1:0] nic400_quad_0_htrans_mac100_3 ; 
logic nic400_quad_0_hwrite_mac100_3 ; 
logic [2:0] nic400_quad_0_hsize_mac100_3 ; 
logic [31:0] nic400_quad_0_hwdata_mac100_3 ; 
logic nic400_quad_0_hready_mac100_3 ; 
logic [31:0] mac100_ahb_bridge_3_hrdata ; 
wire mac100_ahb_bridge_3_hresp ; 
wire mac100_ahb_bridge_3_hreadyout ; 
logic nic400_quad_0_hselx_mac100_stats_0 ; 
logic [17:0] nic400_quad_0_haddr_mac100_stats_0_out ; 
logic [1:0] nic400_quad_0_htrans_mac100_stats_0 ; 
logic nic400_quad_0_hwrite_mac100_stats_0 ; 
logic [2:0] nic400_quad_0_hsize_mac100_stats_0 ; 
logic [31:0] nic400_quad_0_hwdata_mac100_stats_0 ; 
logic nic400_quad_0_hready_mac100_stats_0 ; 
logic [31:0] macstats_ahb_bridge_0_hrdata ; 
wire macstats_ahb_bridge_0_hresp ; 
wire macstats_ahb_bridge_0_hreadyout ; 
logic nic400_quad_0_hselx_mac100_stats_1 ; 
logic [17:0] nic400_quad_0_haddr_mac100_stats_1_out ; 
logic [1:0] nic400_quad_0_htrans_mac100_stats_1 ; 
logic nic400_quad_0_hwrite_mac100_stats_1 ; 
logic [2:0] nic400_quad_0_hsize_mac100_stats_1 ; 
logic [31:0] nic400_quad_0_hwdata_mac100_stats_1 ; 
logic nic400_quad_0_hready_mac100_stats_1 ; 
logic [31:0] macstats_ahb_bridge_1_hrdata ; 
wire macstats_ahb_bridge_1_hresp ; 
wire macstats_ahb_bridge_1_hreadyout ; 
logic nic400_quad_0_hselx_mac100_stats_2 ; 
logic [17:0] nic400_quad_0_haddr_mac100_stats_2_out ; 
logic [1:0] nic400_quad_0_htrans_mac100_stats_2 ; 
logic nic400_quad_0_hwrite_mac100_stats_2 ; 
logic [2:0] nic400_quad_0_hsize_mac100_stats_2 ; 
logic [31:0] nic400_quad_0_hwdata_mac100_stats_2 ; 
logic nic400_quad_0_hready_mac100_stats_2 ; 
logic [31:0] macstats_ahb_bridge_2_hrdata ; 
wire macstats_ahb_bridge_2_hresp ; 
wire macstats_ahb_bridge_2_hreadyout ; 
logic nic400_quad_0_hselx_mac100_stats_3 ; 
logic [17:0] nic400_quad_0_haddr_mac100_stats_3_out ; 
logic [1:0] nic400_quad_0_htrans_mac100_stats_3 ; 
logic nic400_quad_0_hwrite_mac100_stats_3 ; 
logic [2:0] nic400_quad_0_hsize_mac100_stats_3 ; 
logic [31:0] nic400_quad_0_hwdata_mac100_stats_3 ; 
logic nic400_quad_0_hready_mac100_stats_3 ; 
logic [31:0] macstats_ahb_bridge_3_hrdata ; 
wire macstats_ahb_bridge_3_hresp ; 
wire macstats_ahb_bridge_3_hreadyout ; 
logic nic400_quad_0_hselx_mac400_stats_0 ; 
logic [17:0] nic400_quad_0_haddr_mac400_stats_0_out ; 
logic [1:0] nic400_quad_0_htrans_mac400_stats_0 ; 
logic nic400_quad_0_hwrite_mac400_stats_0 ; 
logic [2:0] nic400_quad_0_hsize_mac400_stats_0 ; 
logic [31:0] nic400_quad_0_hwdata_mac400_stats_0 ; 
logic nic400_quad_0_hready_mac400_stats_0 ; 
logic [31:0] macstats_ahb_bridge_8_hrdata ; 
wire macstats_ahb_bridge_8_hresp ; 
wire macstats_ahb_bridge_8_hreadyout ; 
logic nic400_quad_0_hselx_mac400_stats_1 ; 
logic [17:0] nic400_quad_0_haddr_mac400_stats_1_out ; 
logic [1:0] nic400_quad_0_htrans_mac400_stats_1 ; 
logic nic400_quad_0_hwrite_mac400_stats_1 ; 
logic [2:0] nic400_quad_0_hsize_mac400_stats_1 ; 
logic [31:0] nic400_quad_0_hwdata_mac400_stats_1 ; 
logic nic400_quad_0_hready_mac400_stats_1 ; 
logic [31:0] macstats_ahb_bridge_9_hrdata ; 
wire macstats_ahb_bridge_9_hresp ; 
wire macstats_ahb_bridge_9_hreadyout ; 
logic nic400_quad_0_hselx_mac400_0 ; 
logic [17:0] nic400_quad_0_haddr_mac400_0_out ; 
logic [1:0] nic400_quad_0_htrans_mac400_0 ; 
logic nic400_quad_0_hwrite_mac400_0 ; 
logic [2:0] nic400_quad_0_hsize_mac400_0 ; 
logic [31:0] nic400_quad_0_hwdata_mac400_0 ; 
logic nic400_quad_0_hready_mac400_0 ; 
logic [31:0] mac200_ahb_bridge_0_hrdata ; 
wire mac200_ahb_bridge_0_hresp ; 
wire mac200_ahb_bridge_0_hreadyout ; 
logic nic400_quad_0_hselx_mac400_1 ; 
logic [17:0] nic400_quad_0_haddr_mac400_1_out ; 
logic [1:0] nic400_quad_0_htrans_mac400_1 ; 
logic nic400_quad_0_hwrite_mac400_1 ; 
logic [2:0] nic400_quad_0_hsize_mac400_1 ; 
logic [31:0] nic400_quad_0_hwdata_mac400_1 ; 
logic nic400_quad_0_hready_mac400_1 ; 
logic [31:0] mac400_ahb_bridge_0_hrdata ; 
wire mac400_ahb_bridge_0_hresp ; 
wire mac400_ahb_bridge_0_hreadyout ; 
logic nic400_quad_0_hselx_pcs400_0 ; 
logic [17:0] nic400_quad_0_haddr_pcs400_0_out ; 
logic [1:0] nic400_quad_0_htrans_pcs400_0 ; 
logic nic400_quad_0_hwrite_pcs400_0 ; 
logic [2:0] nic400_quad_0_hsize_pcs400_0 ; 
logic [31:0] nic400_quad_0_hwdata_pcs400_0 ; 
logic nic400_quad_0_hready_pcs400_0 ; 
logic [31:0] pcs200_ahb_bridge_0_hrdata ; 
wire pcs200_ahb_bridge_0_hresp ; 
wire pcs200_ahb_bridge_0_hreadyout ; 
logic nic400_quad_0_hselx_rsfec400_0 ; 
logic [17:0] nic400_quad_0_haddr_rsfec400_0_out ; 
logic [1:0] nic400_quad_0_htrans_rsfec400_0 ; 
logic nic400_quad_0_hwrite_rsfec400_0 ; 
logic [2:0] nic400_quad_0_hsize_rsfec400_0 ; 
logic [31:0] nic400_quad_0_hwdata_rsfec400_0 ; 
logic nic400_quad_0_hready_rsfec400_0 ; 
logic [31:0] pcs200_ahb_bridge_1_hrdata ; 
wire pcs200_ahb_bridge_1_hresp ; 
wire pcs200_ahb_bridge_1_hreadyout ; 
logic nic400_quad_0_hselx_pcs400_1 ; 
logic [17:0] nic400_quad_0_haddr_pcs400_1_out ; 
logic [1:0] nic400_quad_0_htrans_pcs400_1 ; 
logic nic400_quad_0_hwrite_pcs400_1 ; 
logic [2:0] nic400_quad_0_hsize_pcs400_1 ; 
logic [31:0] nic400_quad_0_hwdata_pcs400_1 ; 
logic nic400_quad_0_hready_pcs400_1 ; 
logic [31:0] pcs400_ahb_bridge_0_hrdata ; 
wire pcs400_ahb_bridge_0_hresp ; 
wire pcs400_ahb_bridge_0_hreadyout ; 
logic nic400_quad_0_hselx_rsfec400_1 ; 
logic [17:0] nic400_quad_0_haddr_rsfec400_1_out ; 
logic [1:0] nic400_quad_0_htrans_rsfec400_1 ; 
logic nic400_quad_0_hwrite_rsfec400_1 ; 
logic [2:0] nic400_quad_0_hsize_rsfec400_1 ; 
logic [31:0] nic400_quad_0_hwdata_rsfec400_1 ; 
logic nic400_quad_0_hready_rsfec400_1 ; 
logic [31:0] pcs400_ahb_bridge_1_hrdata ; 
wire pcs400_ahb_bridge_1_hresp ; 
wire pcs400_ahb_bridge_1_hreadyout ; 
wire [31:0] nic400_quad_0_haddr_pcs_quad_out ; 
wire [1:0] nic400_quad_0_htrans_pcs_quad ; 
wire [2:0] nic400_quad_0_hburst_pcs_quad ; 
wire [3:0] nic400_quad_0_hprot_pcs_quad ; 
wire nic400_quad_0_hwrite_pcs_quad ; 
wire [2:0] nic400_quad_0_hsize_pcs_quad ; 
wire [31:0] nic400_quad_0_hwdata_pcs_quad ; 
wire [31:0] DW_ahb_0_hrdata ; 
wire DW_ahb_0_hresp ; 
wire DW_ahb_0_hready ; 
logic [23:0] nic400_quad_0_paddr_xmp_out ; 
logic [31:0] nic400_quad_0_pwdata_xmp ; 
logic nic400_quad_0_pwrite_xmp ; 
logic [2:0] nic400_quad_0_pprot_xmp ; 
logic [3:0] nic400_quad_0_pstrb_xmp ; 
logic nic400_quad_0_penable_xmp ; 
logic nic400_quad_0_pselx_xmp ; 
logic versa_xmp_0_o_apb_pready ; 
logic [31:0] versa_xmp_0_o_apb_prdata ; 
logic versa_xmp_0_o_apb_pslverr ; 
logic [11:0] nic400_quad_0_paddr_common_cfg_out ; 
logic [31:0] nic400_quad_0_pwdata_common_cfg ; 
logic nic400_quad_0_pwrite_common_cfg ; 
logic nic400_quad_0_penable_common_cfg ; 
logic nic400_quad_0_pselx_common_cfg ; 
logic physs_registers_wrapper_0_o_pready ; 
logic [31:0] physs_registers_wrapper_0_o_prdata ; 
logic physs_registers_wrapper_0_o_pslverr ; 
logic [3:0] physs_registers_wrapper_0_reset_sd_tx_clk_ovveride ; 
logic [3:0] physs_registers_wrapper_0_reset_sd_rx_clk_ovveride ; 
logic physs_registers_wrapper_0_reset_ref_clk_ovveride ; 
logic [1:0] physs_registers_wrapper_0_reset_xpcs_ref_clk_ovveride ; 
logic [1:0] physs_registers_wrapper_0_reset_f91_ref_clk_ovveride ; 
logic physs_registers_wrapper_0_reset_gpcs0_ref_clk_ovveride ; 
logic physs_registers_wrapper_0_reset_gpcs1_ref_clk_ovveride ; 
logic physs_registers_wrapper_0_reset_gpcs2_ref_clk_ovveride ; 
logic physs_registers_wrapper_0_reset_gpcs3_ref_clk_ovveride ; 
logic physs_registers_wrapper_0_reset_reg_clk_ovveride ; 
logic physs_registers_wrapper_0_reset_reg_ref_clk_ovveride ; 
logic physs_registers_wrapper_0_reset_cdmii_rxclk_ovveride_200G ; 
logic physs_registers_wrapper_0_reset_cdmii_txclk_ovveride_200G ; 
logic physs_registers_wrapper_0_reset_sd_tx_clk_ovveride_200G ; 
logic physs_registers_wrapper_0_reset_sd_rx_clk_ovveride_200G ; 
logic physs_registers_wrapper_0_reset_reg_clk_ovveride_200G ; 
logic physs_registers_wrapper_0_reset_reg_ref_clk_ovveride_200G ; 
logic physs_registers_wrapper_0_reset_cdmii_rxclk_ovveride_400G ; 
logic physs_registers_wrapper_0_reset_cdmii_txclk_ovveride_400G ; 
logic physs_registers_wrapper_0_reset_sd_tx_clk_ovveride_400G ; 
logic physs_registers_wrapper_0_reset_sd_rx_clk_ovveride_400G ; 
logic physs_registers_wrapper_0_reset_reg_clk_ovveride_400G ; 
logic physs_registers_wrapper_0_reset_reg_ref_clk_ovveride_400G ; 
logic [5:0] physs_registers_wrapper_0_reset_reg_clk_ovveride_mac ; 
logic [5:0] physs_registers_wrapper_0_reset_ff_tx_clk_ovveride ; 
logic [5:0] physs_registers_wrapper_0_reset_ff_rx_clk_ovveride ; 
logic [5:0] physs_registers_wrapper_0_reset_txclk_ovveride ; 
logic [5:0] physs_registers_wrapper_0_reset_rxclk_ovveride ; 
logic physs_registers_wrapper_0_i_rst_apb_b_a_ovveride ; 
logic physs_registers_wrapper_0_i_rst_ucss_por_b_a_ovveride ; 
logic physs_registers_wrapper_0_i_rst_pma0_por_b_a_ovveride ; 
logic physs_registers_wrapper_0_i_rst_pma1_por_b_a_ovveride ; 
logic physs_registers_wrapper_0_i_rst_pma2_por_b_a_ovveride ; 
logic physs_registers_wrapper_0_i_rst_pma3_por_b_a_ovveride ; 
logic physs_registers_wrapper_0_clk_gate_en_100G_mac_pcs ; 
logic physs_registers_wrapper_0_clk_gate_en_200G_mac_pcs ; 
logic physs_registers_wrapper_0_clk_gate_en_400G_mac_pcs ; 
logic physs_registers_wrapper_0_mac100_config_0_cfg_mode128 ; 
logic physs_registers_wrapper_0_mac100_config_1_cfg_mode128 ; 
logic physs_registers_wrapper_0_mac100_config_2_cfg_mode128 ; 
logic physs_registers_wrapper_0_mac100_config_3_cfg_mode128 ; 
logic physs_registers_wrapper_0_pcs100_sgmii0_reg_sg0_sgpcs_ena ; 
logic physs_registers_wrapper_0_pcs100_sgmii1_reg_sg0_sgpcs_ena ; 
logic physs_registers_wrapper_0_pcs100_sgmii2_reg_sg0_sgpcs_ena ; 
logic physs_registers_wrapper_0_pcs100_sgmii3_reg_sg0_sgpcs_ena ; 
logic [6:0] quadpcs100_0_pcs_desk_buf_rlevel ; 
logic [6:0] quadpcs100_0_pcs_desk_buf_rlevel_0 ; 
logic [6:0] quadpcs100_0_pcs_desk_buf_rlevel_1 ; 
logic [6:0] quadpcs100_0_pcs_desk_buf_rlevel_2 ; 
logic [24:0] mac100_0_ff_rx_err_stat ; 
logic [24:0] mac100_1_ff_rx_err_stat ; 
logic [24:0] mac100_2_ff_rx_err_stat ; 
logic [24:0] mac100_3_ff_rx_err_stat ; 
logic mac100_0_ff_rx_err ; 
logic mac100_1_ff_rx_err ; 
logic mac100_2_ff_rx_err ; 
logic mac100_3_ff_rx_err ; 
logic mac100_0_mdio_oen ; 
logic mac100_1_mdio_oen ; 
logic mac100_2_mdio_oen ; 
logic mac100_3_mdio_oen ; 
logic [7:0] mac100_0_pause_on ; 
logic [7:0] mac100_1_pause_on ; 
logic [7:0] mac100_2_pause_on ; 
logic [7:0] mac100_3_pause_on ; 
logic mac100_0_li_fault ; 
logic mac100_1_li_fault ; 
logic mac100_2_li_fault ; 
logic mac100_3_li_fault ; 
logic mac100_0_rem_fault ; 
logic mac100_1_rem_fault ; 
logic mac100_2_rem_fault ; 
logic mac100_3_rem_fault ; 
logic mac100_0_loc_fault ; 
logic mac100_1_loc_fault ; 
logic mac100_2_loc_fault ; 
logic mac100_3_loc_fault ; 
logic mac100_0_tx_empty ; 
logic mac100_1_tx_empty ; 
logic mac100_2_tx_empty ; 
logic mac100_3_tx_empty ; 
logic mac100_0_ff_rx_empty ; 
logic mac100_1_ff_rx_empty ; 
logic mac100_2_ff_rx_empty ; 
logic mac100_3_ff_rx_empty ; 
logic mac100_0_tx_isidle ; 
logic mac100_1_tx_isidle ; 
logic mac100_2_tx_isidle ; 
logic mac100_3_tx_isidle ; 
logic mac100_0_ff_tx_septy ; 
logic mac100_1_ff_tx_septy ; 
logic mac100_2_ff_tx_septy ; 
logic mac100_3_ff_tx_septy ; 
logic mac100_0_tx_underflow ; 
logic mac100_1_tx_underflow ; 
logic mac100_2_tx_underflow ; 
logic mac100_3_tx_underflow ; 
logic mac100_0_ff_tx_ovr ; 
logic mac100_1_ff_tx_ovr ; 
logic mac100_2_ff_tx_ovr ; 
logic mac100_3_ff_tx_ovr ; 
logic mac100_0_magic_ind ; 
logic mac100_1_magic_ind ; 
logic mac100_2_magic_ind ; 
logic mac100_3_magic_ind ; 
wire [7:0] mac200_0_pause_on ; 
wire [7:0] mac400_0_pause_on ; 
wire mac200_0_li_fault ; 
wire mac400_0_li_fault ; 
wire mac200_0_rem_fault ; 
wire mac400_0_rem_fault ; 
wire mac200_0_loc_fault ; 
wire mac400_0_loc_fault ; 
wire mac200_0_tx_empty ; 
wire mac400_0_tx_empty ; 
wire mac200_0_ff_rx_empty ; 
wire mac400_0_ff_rx_empty ; 
wire mac200_0_tx_isidle ; 
wire mac400_0_tx_isidle ; 
wire mac200_0_ff_tx_septy ; 
wire mac400_0_ff_tx_septy ; 
wire mac200_0_tx_underflow ; 
wire mac400_0_tx_underflow ; 
wire mac200_0_tx_ovr_err ; 
wire mac400_0_tx_ovr_err ; 
logic [3:0] quadpcs100_0_pcs0_fec_locked ; 
logic [3:0] quadpcs100_0_pcs0_fec_ncerr ; 
logic [3:0] quadpcs100_0_pcs0_fec_cerr ; 
logic [3:0] quadpcs100_0_pcs1_fec_locked ; 
logic [3:0] quadpcs100_0_pcs1_fec_ncerr ; 
logic [3:0] quadpcs100_0_pcs1_fec_cerr ; 
logic quadpcs100_0_sg0_hd ; 
logic [1:0] quadpcs100_0_sg0_speed ; 
logic quadpcs100_0_sg0_page_rx ; 
logic quadpcs100_0_sg0_an_done ; 
logic quadpcs100_0_sg0_rx_sync ; 
logic quadpcs100_0_sg1_hd ; 
logic [1:0] quadpcs100_0_sg1_speed ; 
logic quadpcs100_0_sg1_page_rx ; 
logic quadpcs100_0_sg1_an_done ; 
logic quadpcs100_0_sg1_rx_sync ; 
logic quadpcs100_0_sg2_hd ; 
logic [1:0] quadpcs100_0_sg2_speed ; 
logic quadpcs100_0_sg2_page_rx ; 
logic quadpcs100_0_sg2_an_done ; 
logic quadpcs100_0_sg2_rx_sync ; 
logic quadpcs100_0_sg3_hd ; 
logic [1:0] quadpcs100_0_sg3_speed ; 
logic quadpcs100_0_sg3_page_rx ; 
logic quadpcs100_0_sg3_an_done ; 
logic quadpcs100_0_sg3_rx_sync ; 
logic [7:0] quadpcs100_0_pcs_mac0_res_speed ; 
logic [7:0] quadpcs100_0_pcs_mac1_res_speed ; 
logic [7:0] quadpcs100_0_pcs_mac2_res_speed ; 
logic [7:0] quadpcs100_0_pcs_mac3_res_speed ; 
logic [3:0] quadpcs100_0_pcs_rsfec_aligned ; 
logic [7:0] quadpcs100_0_pcs_amps_lock ; 
logic [3:0] quadpcs100_0_pcs_align_done ; 
logic [3:0] quadpcs100_0_pcs_hi_ber ; 
logic [15:0] quadpcs100_0_usxgmii0_an_pability ; 
logic quadpcs100_0_usxgmii0_an_pability_done ; 
logic quadpcs100_0_usxgmii0_an_busy ; 
logic [15:0] quadpcs100_0_usxgmii1_an_pability ; 
logic quadpcs100_0_usxgmii1_an_pability_done ; 
logic quadpcs100_0_usxgmii1_an_busy ; 
logic [15:0] quadpcs100_0_usxgmii2_an_pability ; 
logic quadpcs100_0_usxgmii2_an_pability_done ; 
logic quadpcs100_0_usxgmii2_an_busy ; 
logic [15:0] quadpcs100_0_usxgmii3_an_pability ; 
logic quadpcs100_0_usxgmii3_an_pability_done ; 
logic quadpcs100_0_usxgmii3_an_busy ; 
logic [2:0] pcs200_0_rx_am_sf ; 
logic pcs200_0_degrade_ser ; 
logic pcs200_0_hi_ser ; 
logic pcs200_0_link_status ; 
logic [15:0] pcs200_0_amps_lock ; 
logic pcs200_0_align_lock ; 
logic [2:0] pcs400_0_rx_am_sf ; 
logic pcs400_0_degrade_ser ; 
logic pcs400_0_hi_ser ; 
logic pcs400_0_link_status ; 
logic [15:0] pcs400_0_amps_lock ; 
logic pcs400_0_align_lock ; 
logic physs_registers_wrapper_0_mac100_config_0_cfg_write64 ; 
logic physs_registers_wrapper_0_mac100_config_1_cfg_write64 ; 
logic physs_registers_wrapper_0_mac100_config_2_cfg_write64 ; 
logic physs_registers_wrapper_0_mac100_config_3_cfg_write64 ; 
logic [3:0] physs_registers_wrapper_0_pcs100_sgmii0_reg_sg0_tx_lane_thresh ; 
logic [2:0] physs_registers_wrapper_0_pcs100_sgmii0_reg_sg0_sg_tx_lane_ckmult ; 
logic physs_registers_wrapper_0_pcs100_sgmii0_reg_sg0_mode_br_dis ; 
logic physs_registers_wrapper_0_pcs100_sgmii0_reg_sg0_seq_ena ; 
logic physs_registers_wrapper_0_pcs100_sgmii0_reg_sg0_mode_sync ; 
logic [3:0] physs_registers_wrapper_0_pcs100_sgmii1_reg_sg0_tx_lane_thresh ; 
logic [2:0] physs_registers_wrapper_0_pcs100_sgmii1_reg_sg0_sg_tx_lane_ckmult ; 
logic physs_registers_wrapper_0_pcs100_sgmii1_reg_sg0_mode_br_dis ; 
logic physs_registers_wrapper_0_pcs100_sgmii1_reg_sg0_seq_ena ; 
logic physs_registers_wrapper_0_pcs100_sgmii1_reg_sg0_mode_sync ; 
logic [3:0] physs_registers_wrapper_0_pcs100_sgmii2_reg_sg0_tx_lane_thresh ; 
logic [2:0] physs_registers_wrapper_0_pcs100_sgmii2_reg_sg0_sg_tx_lane_ckmult ; 
logic physs_registers_wrapper_0_pcs100_sgmii2_reg_sg0_mode_br_dis ; 
logic physs_registers_wrapper_0_pcs100_sgmii2_reg_sg0_seq_ena ; 
logic physs_registers_wrapper_0_pcs100_sgmii2_reg_sg0_mode_sync ; 
logic [3:0] physs_registers_wrapper_0_pcs100_sgmii3_reg_sg0_tx_lane_thresh ; 
logic [2:0] physs_registers_wrapper_0_pcs100_sgmii3_reg_sg0_sg_tx_lane_ckmult ; 
logic physs_registers_wrapper_0_pcs100_sgmii3_reg_sg0_mode_br_dis ; 
logic physs_registers_wrapper_0_pcs100_sgmii3_reg_sg0_seq_ena ; 
logic physs_registers_wrapper_0_pcs100_sgmii3_reg_sg0_mode_sync ; 
logic [19:0] quadpcs100_0_pcs_block_lock ; 
logic physs_registers_wrapper_0_pcs100_usxgmii0_config_usxgmii0_conf_speed_tx_2_5 ; 
logic physs_registers_wrapper_0_pcs100_usxgmii0_config_usxgmii0_conf_speed_rx_2_5 ; 
logic [9:0] physs_registers_wrapper_0_pcs100_usxgmii0_config_usxgmii0_conf_speed_tx ; 
logic [9:0] physs_registers_wrapper_0_pcs100_usxgmii0_config_usxgmii0_conf_speed_rx ; 
logic physs_registers_wrapper_0_pcs100_usxgmii1_config_usxgmii1_conf_speed_tx_2_5 ; 
logic physs_registers_wrapper_0_pcs100_usxgmii1_config_usxgmii1_conf_speed_rx_2_5 ; 
logic [9:0] physs_registers_wrapper_0_pcs100_usxgmii1_config_usxgmii1_conf_speed_tx ; 
logic [9:0] physs_registers_wrapper_0_pcs100_usxgmii1_config_usxgmii1_conf_speed_rx ; 
logic physs_registers_wrapper_0_pcs100_usxgmii2_config_usxgmii2_conf_speed_tx_2_5 ; 
logic physs_registers_wrapper_0_pcs100_usxgmii2_config_usxgmii2_conf_speed_rx_2_5 ; 
logic [9:0] physs_registers_wrapper_0_pcs100_usxgmii2_config_usxgmii2_conf_speed_tx ; 
logic [9:0] physs_registers_wrapper_0_pcs100_usxgmii2_config_usxgmii2_conf_speed_rx ; 
logic physs_registers_wrapper_0_pcs100_usxgmii3_config_usxgmii3_conf_speed_tx_2_5 ; 
logic physs_registers_wrapper_0_pcs100_usxgmii3_config_usxgmii3_conf_speed_rx_2_5 ; 
logic [9:0] physs_registers_wrapper_0_pcs100_usxgmii3_config_usxgmii3_conf_speed_tx ; 
logic [9:0] physs_registers_wrapper_0_pcs100_usxgmii3_config_usxgmii3_conf_speed_rx ; 
logic [2:0] physs_registers_wrapper_0_pcs200_reg_tx_am_sf ; 
logic physs_registers_wrapper_0_pcs200_reg_rsfec_mode_ll ; 
logic physs_registers_wrapper_0_pcs200_reg_sd_4x_en ; 
logic physs_registers_wrapper_0_pcs200_reg_sd_8x_en ; 
logic [2:0] physs_registers_wrapper_0_pcs400_reg_tx_am_sf ; 
logic physs_registers_wrapper_0_pcs400_reg_rsfec_mode_ll ; 
logic physs_registers_wrapper_0_pcs400_reg_sd_4x_en ; 
logic physs_registers_wrapper_0_pcs400_reg_sd_8x_en ; 
logic [3:0] physs_registers_wrapper_0_pcs100_config0_pcs_sd_n2 ; 
logic [3:0] physs_registers_wrapper_0_pcs100_config0_pcs_sd_n2_0 ; 
logic [3:0] physs_registers_wrapper_0_pcs100_config0_pcs_sd_8x ; 
logic [3:0] physs_registers_wrapper_0_pcs100_config0_pcs_sd_8x_0 ; 
logic [3:0] physs_registers_wrapper_0_pcs100_config0_pcs_kp_mode_in ; 
logic [3:0] physs_registers_wrapper_0_pcs100_config0_pcs_kp_mode_in_0 ; 
logic [1:0] physs_registers_wrapper_0_pcs100_config0_pcs_fec91_100g_ck_ena_in ; 
logic [1:0] physs_registers_wrapper_0_pcs100_config0_pcs_fec91_100g_ck_ena_in_0 ; 
logic [1:0] physs_registers_wrapper_0_pcs100_config0_pcs_sd_100g ; 
logic [1:0] physs_registers_wrapper_0_pcs100_config0_pcs_sd_100g_0 ; 
logic physs_registers_wrapper_0_pcs100_config1_pcs_fec91_1lane_in ; 
logic physs_registers_wrapper_0_pcs100_config1_pcs_fec91_1lane_in_0 ; 
logic physs_registers_wrapper_0_pcs100_config1_pcs_fec91_1lane_in_1 ; 
logic physs_registers_wrapper_0_pcs100_config1_pcs_fec91_1lane_in_2 ; 
logic [3:0] physs_registers_wrapper_0_pcs100_config1_pcs_fec91_ll_mode_in ; 
logic [3:0] physs_registers_wrapper_0_pcs100_config1_pcs_fec91_ll_mode_in_0 ; 
logic physs_registers_wrapper_0_pcs100_config1_pcs_rxlaui_ena_in ; 
logic physs_registers_wrapper_0_pcs100_config1_pcs_rxlaui_ena_in_0 ; 
logic physs_registers_wrapper_0_pcs100_config1_pcs_rxlaui_ena_in_1 ; 
logic physs_registers_wrapper_0_pcs100_config1_pcs_rxlaui_ena_in_2 ; 
logic physs_registers_wrapper_0_pcs100_config1_pcs_pcs100_ena_in ; 
logic physs_registers_wrapper_0_pcs100_config1_pcs_pcs100_ena_in_0 ; 
logic physs_registers_wrapper_0_pcs100_config1_pcs_pcs100_ena_in_1 ; 
logic physs_registers_wrapper_0_pcs100_config1_pcs_pcs100_ena_in_2 ; 
logic [3:0] physs_registers_wrapper_0_pcs100_config1_pcs_f91_ena_in ; 
logic [3:0] physs_registers_wrapper_0_pcs100_config1_pcs_f91_ena_in_0 ; 
logic physs_registers_wrapper_0_pcs100_config2_pcs_mode40_ena_in ; 
logic physs_registers_wrapper_0_pcs100_config2_pcs_mode40_ena_in_0 ; 
logic [3:0] physs_registers_wrapper_0_pcs100_config2_pcs_pacer_10g ; 
logic [3:0] physs_registers_wrapper_0_pcs100_config2_pcs_pacer_10g_0 ; 
logic [1:0] physs_registers_wrapper_0_pcs100_config2_pcs_fec_ena ; 
logic [1:0] physs_registers_wrapper_0_pcs100_config2_pcs_fec_ena_0 ; 
logic [1:0] physs_registers_wrapper_0_pcs100_config2_pcs_fec_err_ena ; 
logic [1:0] physs_registers_wrapper_0_pcs100_config2_pcs_fec_err_ena_0 ; 
logic [3:0] physs_registers_wrapper_0_pcs_mode_config_pcs_external_loopback_en_lane ; 
logic physs_registers_wrapper_0_pcs_mode_config_nic_mode ; 
logic [1:0] physs_registers_wrapper_0_pcs_mode_config_pcs_mode_sel ; 
logic [1:0] physs_registers_wrapper_0_pcs_mode_config_fifo_mode_sel ; 
logic [1:0] physs_registers_wrapper_0_pcs_mode_config_lane_revsersal_mux_quad ; 
logic physs_registers_wrapper_0_ts_int_config_0_interrupt_enable ; 
logic [6:0] physs_registers_wrapper_0_ts_int_config_0_int_threshold ; 
logic physs_registers_wrapper_0_tx_offset_ready_0_tx_ready ; 
logic [127:0] physs_timestamp_0_timestamp_csr_reg [3:0] ; 
logic physs_registers_wrapper_0_Global1_0_soft_reset ; 
logic physs_registers_wrapper_0_Global1_1_soft_reset ; 
logic physs_registers_wrapper_0_Global1_2_soft_reset ; 
logic physs_registers_wrapper_0_Global1_3_soft_reset ; 
logic [19:0] physs_registers_wrapper_0_time_M_0_time_clk_cyc_M ; 
logic [19:0] physs_registers_wrapper_0_time_M_1_time_clk_cyc_M ; 
logic [19:0] physs_registers_wrapper_0_time_M_2_time_clk_cyc_M ; 
logic [19:0] physs_registers_wrapper_0_time_M_3_time_clk_cyc_M ; 
logic [19:0] physs_registers_wrapper_0_time_N_0_time_clk_cyc_N ; 
logic [19:0] physs_registers_wrapper_0_time_N_1_time_clk_cyc_N ; 
logic [19:0] physs_registers_wrapper_0_time_N_2_time_clk_cyc_N ; 
logic [19:0] physs_registers_wrapper_0_time_N_3_time_clk_cyc_N ; 
logic [7:0] physs_registers_wrapper_0_time_TUs_L_0_time_clk_cyc_l ; 
logic [31:0] physs_registers_wrapper_0_time_TUs_U_0_time_clk_cyc_u ; 
logic [7:0] physs_registers_wrapper_0_time_TUs_L_1_time_clk_cyc_l ; 
logic [31:0] physs_registers_wrapper_0_time_TUs_U_1_time_clk_cyc_u ; 
logic [7:0] physs_registers_wrapper_0_time_TUs_L_2_time_clk_cyc_l ; 
logic [31:0] physs_registers_wrapper_0_time_TUs_U_2_time_clk_cyc_u ; 
logic [7:0] physs_registers_wrapper_0_time_TUs_L_3_time_clk_cyc_l ; 
logic [31:0] physs_registers_wrapper_0_time_TUs_U_3_time_clk_cyc_u ; 
logic [2:0] physs_registers_wrapper_0_tx_timer_cmd_0_tx_timer_cmd ; 
logic [2:0] physs_registers_wrapper_0_tx_timer_cmd_1_tx_timer_cmd ; 
logic [2:0] physs_registers_wrapper_0_tx_timer_cmd_2_tx_timer_cmd ; 
logic [2:0] physs_registers_wrapper_0_tx_timer_cmd_3_tx_timer_cmd ; 
logic [2:0] physs_registers_wrapper_0_rx_timer_cmd_0_rx_timer_cmd ; 
logic [2:0] physs_registers_wrapper_0_rx_timer_cmd_1_rx_timer_cmd ; 
logic [2:0] physs_registers_wrapper_0_rx_timer_cmd_2_rx_timer_cmd ; 
logic [2:0] physs_registers_wrapper_0_rx_timer_cmd_3_rx_timer_cmd ; 
logic [31:0] physs_registers_wrapper_0_rx_timer_inc_pre_L_0_rx_timer_inc_pre_l ; 
logic [31:0] physs_registers_wrapper_0_rx_timer_inc_pre_U_0_rx_timer_inc_pre_u ; 
logic [31:0] physs_registers_wrapper_0_rx_timer_inc_pre_L_1_rx_timer_inc_pre_l ; 
logic [31:0] physs_registers_wrapper_0_rx_timer_inc_pre_U_1_rx_timer_inc_pre_u ; 
logic [31:0] physs_registers_wrapper_0_rx_timer_inc_pre_L_2_rx_timer_inc_pre_l ; 
logic [31:0] physs_registers_wrapper_0_rx_timer_inc_pre_U_2_rx_timer_inc_pre_u ; 
logic [31:0] physs_registers_wrapper_0_rx_timer_inc_pre_L_3_rx_timer_inc_pre_l ; 
logic [31:0] physs_registers_wrapper_0_rx_timer_inc_pre_U_3_rx_timer_inc_pre_u ; 
logic [31:0] physs_registers_wrapper_0_tx_timer_inc_pre_L_0_tx_timer_inc_pre_l ; 
logic [31:0] physs_registers_wrapper_0_tx_timer_inc_pre_U_0_tx_timer_inc_pre_u ; 
logic [31:0] physs_registers_wrapper_0_tx_timer_inc_pre_L_1_tx_timer_inc_pre_l ; 
logic [31:0] physs_registers_wrapper_0_tx_timer_inc_pre_U_1_tx_timer_inc_pre_u ; 
logic [31:0] physs_registers_wrapper_0_tx_timer_inc_pre_L_2_tx_timer_inc_pre_l ; 
logic [31:0] physs_registers_wrapper_0_tx_timer_inc_pre_U_2_tx_timer_inc_pre_u ; 
logic [31:0] physs_registers_wrapper_0_tx_timer_inc_pre_L_3_tx_timer_inc_pre_l ; 
logic [31:0] physs_registers_wrapper_0_tx_timer_inc_pre_U_3_tx_timer_inc_pre_u ; 
logic physs_registers_wrapper_0_tx_timer_cmd_0_tx_master_timer ; 
logic physs_registers_wrapper_0_tx_timer_cmd_1_tx_master_timer ; 
logic physs_registers_wrapper_0_tx_timer_cmd_2_tx_master_timer ; 
logic physs_registers_wrapper_0_tx_timer_cmd_3_tx_master_timer ; 
logic physs_registers_wrapper_0_rx_timer_cmd_0_rx_master_timer ; 
logic physs_registers_wrapper_0_rx_timer_cmd_1_rx_master_timer ; 
logic physs_registers_wrapper_0_rx_timer_cmd_2_rx_master_timer ; 
logic physs_registers_wrapper_0_rx_timer_cmd_3_rx_master_timer ; 
logic [31:0] physs_registers_wrapper_0_tx_timer_cnt_adj_L_0_tx_timer_cnt_adj_l ; 
logic [31:0] physs_registers_wrapper_0_tx_timer_cnt_adj_U_0_tx_timer_cnt_adj_u ; 
logic [31:0] physs_registers_wrapper_0_tx_timer_cnt_adj_L_1_tx_timer_cnt_adj_l ; 
logic [31:0] physs_registers_wrapper_0_tx_timer_cnt_adj_U_1_tx_timer_cnt_adj_u ; 
logic [31:0] physs_registers_wrapper_0_tx_timer_cnt_adj_L_2_tx_timer_cnt_adj_l ; 
logic [31:0] physs_registers_wrapper_0_tx_timer_cnt_adj_U_2_tx_timer_cnt_adj_u ; 
logic [31:0] physs_registers_wrapper_0_tx_timer_cnt_adj_L_3_tx_timer_cnt_adj_l ; 
logic [31:0] physs_registers_wrapper_0_tx_timer_cnt_adj_U_3_tx_timer_cnt_adj_u ; 
logic [31:0] physs_registers_wrapper_0_rx_timer_cnt_adj_L_0_rx_timer_cnt_adj_l ; 
logic [31:0] physs_registers_wrapper_0_rx_timer_cnt_adj_U_0_rx_timer_cnt_adj_u ; 
logic [31:0] physs_registers_wrapper_0_rx_timer_cnt_adj_L_1_rx_timer_cnt_adj_l ; 
logic [31:0] physs_registers_wrapper_0_rx_timer_cnt_adj_U_1_rx_timer_cnt_adj_u ; 
logic [31:0] physs_registers_wrapper_0_rx_timer_cnt_adj_L_2_rx_timer_cnt_adj_l ; 
logic [31:0] physs_registers_wrapper_0_rx_timer_cnt_adj_U_2_rx_timer_cnt_adj_u ; 
logic [31:0] physs_registers_wrapper_0_rx_timer_cnt_adj_L_3_rx_timer_cnt_adj_l ; 
logic [31:0] physs_registers_wrapper_0_rx_timer_cnt_adj_U_3_rx_timer_cnt_adj_u ; 
logic [7:0] physs_registers_wrapper_0_pcs_ref_inc_L_0_pcs_ref_inc_l ; 
logic [31:0] physs_registers_wrapper_0_pcs_ref_inc_U_0_pcs_ref_inc_u ; 
logic [7:0] physs_registers_wrapper_0_pcs_ref_inc_L_1_pcs_ref_inc_l ; 
logic [31:0] physs_registers_wrapper_0_pcs_ref_inc_U_1_pcs_ref_inc_u ; 
logic [7:0] physs_registers_wrapper_0_pcs_ref_inc_L_2_pcs_ref_inc_l ; 
logic [31:0] physs_registers_wrapper_0_pcs_ref_inc_U_2_pcs_ref_inc_u ; 
logic [7:0] physs_registers_wrapper_0_pcs_ref_inc_L_3_pcs_ref_inc_l ; 
logic [31:0] physs_registers_wrapper_0_pcs_ref_inc_U_3_pcs_ref_inc_u ; 
logic [7:0] physs_registers_wrapper_0_pcs_ref_TUs_L_0_pcs_ref_clk_cyc_l ; 
logic [31:0] physs_registers_wrapper_0_pcs_ref_TUs_U_0_pcs_ref_clk_cyc_u ; 
logic [7:0] physs_registers_wrapper_0_pcs_ref_TUs_L_1_pcs_ref_clk_cyc_l ; 
logic [31:0] physs_registers_wrapper_0_pcs_ref_TUs_U_1_pcs_ref_clk_cyc_u ; 
logic [7:0] physs_registers_wrapper_0_pcs_ref_TUs_L_2_pcs_ref_clk_cyc_l ; 
logic [31:0] physs_registers_wrapper_0_pcs_ref_TUs_U_2_pcs_ref_clk_cyc_u ; 
logic [7:0] physs_registers_wrapper_0_pcs_ref_TUs_L_3_pcs_ref_clk_cyc_l ; 
logic [31:0] physs_registers_wrapper_0_pcs_ref_TUs_U_3_pcs_ref_clk_cyc_u ; 
logic physs_registers_wrapper_0_pcs_ref_inc_L_0_enable_load ; 
logic physs_registers_wrapper_0_pcs_ref_inc_L_1_enable_load ; 
logic physs_registers_wrapper_0_pcs_ref_inc_L_2_enable_load ; 
logic physs_registers_wrapper_0_pcs_ref_inc_L_3_enable_load ; 
logic physs_registers_wrapper_0_ts_int_config_1_interrupt_enable ; 
logic [6:0] physs_registers_wrapper_0_ts_int_config_1_int_threshold ; 
logic physs_registers_wrapper_0_tx_offset_ready_1_tx_ready ; 
logic physs_registers_wrapper_0_ts_int_config_2_interrupt_enable ; 
logic [6:0] physs_registers_wrapper_0_ts_int_config_2_int_threshold ; 
logic physs_registers_wrapper_0_tx_offset_ready_2_tx_ready ; 
logic physs_registers_wrapper_0_ts_int_config_3_interrupt_enable ; 
logic [6:0] physs_registers_wrapper_0_ts_int_config_3_int_threshold ; 
logic physs_registers_wrapper_0_tx_offset_ready_3_tx_ready ; 
logic [31:0] physs_registers_wrapper_0_physs_int_ovveride_reg0_icu ; 
logic [31:0] physs_registers_wrapper_0_physs_int_ovveride_reg1_icu ; 
logic [31:0] physs_registers_wrapper_0_physs_int_ovveride_reg2_icu ; 
logic [31:0] physs_registers_wrapper_0_physs_int_ovveride_reg3_icu ; 
logic [31:0] physs_registers_wrapper_0_physs_int_ovveride_reg4_icu ; 
logic [31:0] physs_registers_wrapper_0_physs_int_ovveride_reg5_icu ; 
logic [31:0] physs_registers_wrapper_0_physs_irq_mask_reg0_icu ; 
logic [31:0] physs_registers_wrapper_0_physs_irq_mask_reg1_icu ; 
logic [31:0] physs_registers_wrapper_0_physs_irq_mask_reg2_icu ; 
logic [31:0] physs_registers_wrapper_0_physs_irq_mask_reg3_icu ; 
logic [31:0] physs_registers_wrapper_0_physs_irq_mask_reg4_icu ; 
logic [31:0] physs_registers_wrapper_0_physs_irq_mask_reg5_icu ; 
logic [31:0] quad_interrupts_0_physs_irq_raw_status_reg0_icu ; 
logic [31:0] quad_interrupts_0_physs_irq_raw_status_reg1_icu ; 
logic [31:0] quad_interrupts_0_physs_irq_raw_status_reg2_icu ; 
logic [31:0] quad_interrupts_0_physs_irq_raw_status_reg3_icu ; 
logic [31:0] quad_interrupts_0_physs_irq_raw_status_reg4_icu ; 
logic [31:0] quad_interrupts_0_physs_irq_raw_status_reg5_icu ; 
logic [31:0] physs_registers_wrapper_0_physs_irq_reset_reg0_icu ; 
logic [31:0] physs_registers_wrapper_0_physs_irq_reset_reg1_icu ; 
logic [31:0] physs_registers_wrapper_0_physs_irq_reset_reg2_icu ; 
logic [31:0] physs_registers_wrapper_0_physs_irq_reset_reg3_icu ; 
logic [31:0] physs_registers_wrapper_0_physs_irq_reset_reg4_icu ; 
logic [31:0] physs_registers_wrapper_0_physs_irq_reset_reg5_icu ; 
logic [31:0] quad_interrupts_0_physs_irq_status_reg0_icu ; 
logic [31:0] quad_interrupts_0_physs_irq_status_reg1_icu ; 
logic [31:0] quad_interrupts_0_physs_irq_status_reg2_icu ; 
logic [31:0] quad_interrupts_0_physs_irq_status_reg3_icu ; 
logic [31:0] quad_interrupts_0_physs_irq_status_reg4_icu ; 
logic [31:0] quad_interrupts_0_physs_irq_status_reg5_icu ; 
logic physs_clock_sync_0_physs_func_clk_gated_100 ; 
logic [3:0] physs_lane_reversal_mux_0_serdes_tx_clk ; 
logic [3:0] physs_lane_reversal_mux_0_serdes_rx_clk ; 
logic [3:0] physs_timestamp_0_ptp_mem_wr ; 
logic [6:0] physs_timestamp_0_ptp_mem_waddr [3:0] ; 
logic [44:0] physs_timestamp_0_ptp_mem_data [3:0] ; 
logic [44:0] ptpx_mem_wrapper_0_ptptx_rdata0 ; 
logic [44:0] ptpx_mem_wrapper_0_ptptx_rdata0_0 ; 
logic [44:0] ptpx_mem_wrapper_0_ptptx_rdata0_1 ; 
logic [44:0] ptpx_mem_wrapper_0_ptptx_rdata0_2 ; 
logic [3:0] ptp_mem_bridge_0_reg_rden ; 
logic [6:0] ptp_mem_bridge_0_reg_addr ; 
logic [3:0] physs_timestamp_0_ptp_mem_clr ; 
logic [6:0] physs_timestamp_0_ptp_mem_raddr [3:0] ; 
logic [44:0] physs_timestamp_0_ptp_mem_clr_data [3:0] ; 
logic physs_clock_sync_0_physs_ptpmem_wr_clk0 ; 
logic physs_clock_sync_0_physs_ptpmem_wr_clk2 ; 
logic physs_clock_sync_0_physs_ptpmem_rd_clk0 ; 
logic physs_clock_sync_0_physs_ptpmem_rd_clk2 ; 
logic physs_clock_sync_0_soc_per_clk_gated_100 ; 
logic physs_clock_sync_0_reset_reg_clk_mac ; 
logic physs_clock_sync_0_reset_reg_clk_mac_0 ; 
logic physs_clock_sync_0_reset_reg_clk_mac_1 ; 
logic physs_clock_sync_0_reset_reg_clk_mac_2 ; 
logic physs_clock_sync_0_reset_rxclk ; 
logic physs_clock_sync_0_reset_rxclk_0 ; 
logic physs_clock_sync_0_reset_rxclk_1 ; 
logic physs_clock_sync_0_reset_rxclk_2 ; 
logic physs_clock_sync_0_soc_per_clk_gated_200 ; 
logic physs_clock_sync_0_soc_per_clk_gated_400 ; 
logic physs_clock_sync_0_physs_func_clk_gated_200 ; 
logic physs_clock_sync_0_physs_func_clk_gated_400 ; 
logic physs_clock_sync_0_reset_reg_clk_mac_3 ; 
logic physs_clock_sync_0_reset_reg_clk_mac_4 ; 
logic physs_clock_sync_0_reset_rxclk_3 ; 
logic physs_clock_sync_0_reset_rxclk_4 ; 
logic physs_clock_sync_0_clk_rst_gate_en_100G ; 
logic physs_clock_sync_0_rst_apb_b_a ; 
logic physs_clock_sync_0_rst_ucss_por_b_a ; 
logic physs_clock_sync_0_rst_pma0_por_b_a ; 
logic physs_func_clk_pdop_parmquad0_clkout ; 
logic timeref_clk_pdop_parmquad0_clkout ; 
logic physs_clock_sync_0_reset_ref_clk ; 
logic physs_clock_sync_0_reset_txclk ; 
logic physs_clock_sync_0_reset_ff_tx_clk ; 
logic physs_clock_sync_0_reset_ff_rx_clk ; 
logic physs_clock_sync_0_reset_cdmii_rxclk_400G ; 
logic physs_clock_sync_0_reset_cdmii_txclk_400G ; 
logic physs_clock_sync_0_reset_sd_tx_clk_400G ; 
logic physs_clock_sync_0_reset_sd_rx_clk_400G ; 
logic physs_clock_sync_0_reset_reg_ref_clk_400G ; 
logic physs_clock_sync_0_reset_reg_clk_400G ; 
logic physs_clock_sync_0_reset_txclk_0 ; 
logic physs_clock_sync_0_reset_ff_tx_clk_0 ; 
logic physs_clock_sync_0_reset_ff_rx_clk_0 ; 
logic physs_clock_sync_0_reset_cdmii_rxclk_200G ; 
logic physs_clock_sync_0_reset_cdmii_txclk_200G ; 
logic physs_clock_sync_0_reset_sd_tx_clk_200G ; 
logic physs_clock_sync_0_reset_sd_rx_clk_200G ; 
logic physs_clock_sync_0_reset_reg_ref_clk_200G ; 
logic physs_clock_sync_0_reset_reg_clk_200G ; 
logic [3:0] physs_clock_sync_0_reset_sd_tx_clk ; 
logic [3:0] physs_clock_sync_0_reset_sd_rx_clk ; 
logic [1:0] physs_clock_sync_0_reset_xpcs_ref_clk ; 
logic [1:0] physs_clock_sync_0_reset_f91_ref_clk ; 
logic physs_clock_sync_0_reset_gpcs0_ref_clk ; 
logic physs_clock_sync_0_reset_gpcs1_ref_clk ; 
logic physs_clock_sync_0_reset_gpcs2_ref_clk ; 
logic physs_clock_sync_0_reset_gpcs3_ref_clk ; 
logic physs_clock_sync_0_reset_reg_ref_clk ; 
logic physs_clock_sync_0_reset_reg_clk ; 
wire [7:0] mtiptsu_top_0_mac0_frc_tx_out_dec ; 
wire [31:0] mtiptsu_top_0_mac0_frc_tx_out_ns ; 
wire [31:0] mtiptsu_top_0_mac0_frc_tx_out_s ; 
wire [7:0] mtiptsu_top_0_mac0_frc_rx_out_dec ; 
wire [31:0] mtiptsu_top_0_mac0_frc_rx_out_ns ; 
wire [31:0] mtiptsu_top_0_mac0_frc_rx_out_s ; 
wire [7:0] mtiptsu_top_0_mac1_frc_tx_out_dec ; 
wire [31:0] mtiptsu_top_0_mac1_frc_tx_out_ns ; 
wire [31:0] mtiptsu_top_0_mac1_frc_tx_out_s ; 
wire [7:0] mtiptsu_top_0_mac1_frc_rx_out_dec ; 
wire [31:0] mtiptsu_top_0_mac1_frc_rx_out_ns ; 
wire [31:0] mtiptsu_top_0_mac1_frc_rx_out_s ; 
wire [7:0] mtiptsu_top_0_mac2_frc_tx_out_dec ; 
wire [31:0] mtiptsu_top_0_mac2_frc_tx_out_ns ; 
wire [31:0] mtiptsu_top_0_mac2_frc_tx_out_s ; 
wire [7:0] mtiptsu_top_0_mac2_frc_rx_out_dec ; 
wire [31:0] mtiptsu_top_0_mac2_frc_rx_out_ns ; 
wire [31:0] mtiptsu_top_0_mac2_frc_rx_out_s ; 
wire [7:0] mtiptsu_top_0_mac3_frc_tx_out_dec ; 
wire [31:0] mtiptsu_top_0_mac3_frc_tx_out_ns ; 
wire [31:0] mtiptsu_top_0_mac3_frc_tx_out_s ; 
wire [7:0] mtiptsu_top_0_mac3_frc_rx_out_dec ; 
wire [31:0] mtiptsu_top_0_mac3_frc_rx_out_ns ; 
wire [31:0] mtiptsu_top_0_mac3_frc_rx_out_s ; 
logic [63:0] physs_timestamp_0_time_cnt_tx [3:0] ; 
logic [63:0] physs_timestamp_0_time_cnt_rx [3:0] ; 
logic physs_clock_sync_0_time_clk_gated_100 ; 
logic [3:0] physs_clock_sync_0_reset_time_clk_n ; 
logic physs_clock_sync_0_reset_reg_clk_inv ; 
logic physs_clock_sync_0_reset_ref_clk_inv ; 
logic versa_xmp_0_o_ucss_srds_rx_ready_pma0_l0_a ; 
logic versa_xmp_0_o_ucss_srds_rx_ready_pma1_l0_a ; 
logic versa_xmp_0_o_ucss_srds_rx_ready_pma2_l0_a ; 
logic versa_xmp_0_o_ucss_srds_rx_ready_pma3_l0_a ; 
wire mac200_0_ff_rx_err_stat ; 
wire mac400_0_ff_rx_err_stat ; 
logic nic_switch_mux_0_mac_xlgmii0_txclk_ena ; 
logic nic_switch_mux_0_mac_xlgmii0_rxclk_ena ; 
logic [7:0] nic_switch_mux_0_mac_xlgmii0_rxc ; 
logic [63:0] nic_switch_mux_0_mac_xlgmii0_rxd ; 
logic nic_switch_mux_0_mac_xlgmii0_rxt0_next ; 
logic [7:0] mac100_0_xlgmii_txc ; 
logic [63:0] mac100_0_xlgmii_txd ; 
logic nic_switch_mux_0_mac_xlgmii1_txclk_ena ; 
logic nic_switch_mux_0_mac_xlgmii1_rxclk_ena ; 
logic [7:0] nic_switch_mux_0_mac_xlgmii1_rxc ; 
logic [63:0] nic_switch_mux_0_mac_xlgmii1_rxd ; 
logic nic_switch_mux_0_mac_xlgmii1_rxt0_next ; 
logic [7:0] mac100_1_xlgmii_txc ; 
logic [63:0] mac100_1_xlgmii_txd ; 
logic nic_switch_mux_0_mac_xlgmii2_txclk_ena ; 
logic nic_switch_mux_0_mac_xlgmii2_rxclk_ena ; 
logic [7:0] nic_switch_mux_0_mac_xlgmii2_rxc ; 
logic [63:0] nic_switch_mux_0_mac_xlgmii2_rxd ; 
logic nic_switch_mux_0_mac_xlgmii2_rxt0_next ; 
logic [7:0] mac100_2_xlgmii_txc ; 
logic [63:0] mac100_2_xlgmii_txd ; 
logic nic_switch_mux_0_mac_xlgmii3_txclk_ena ; 
logic nic_switch_mux_0_mac_xlgmii3_rxclk_ena ; 
logic [7:0] nic_switch_mux_0_mac_xlgmii3_rxc ; 
logic [63:0] nic_switch_mux_0_mac_xlgmii3_rxd ; 
logic nic_switch_mux_0_mac_xlgmii3_rxt0_next ; 
logic [7:0] mac100_3_xlgmii_txc ; 
logic [63:0] mac100_3_xlgmii_txd ; 
logic [127:0] nic_switch_mux_0_mac_cgmii0_rxd ; 
logic [15:0] nic_switch_mux_0_mac_cgmii0_rxc ; 
logic nic_switch_mux_0_mac_cgmii0_rxclk_ena ; 
logic [127:0] mac100_0_cgmii_txd ; 
logic [15:0] mac100_0_cgmii_txc ; 
logic nic_switch_mux_0_mac_cgmii0_txclk_ena ; 
logic [127:0] nic_switch_mux_0_mac_cgmii1_rxd ; 
logic [15:0] nic_switch_mux_0_mac_cgmii1_rxc ; 
logic nic_switch_mux_0_mac_cgmii1_rxclk_ena ; 
logic [127:0] mac100_1_cgmii_txd ; 
logic [15:0] mac100_1_cgmii_txc ; 
logic nic_switch_mux_0_mac_cgmii1_txclk_ena ; 
logic [127:0] nic_switch_mux_0_mac_cgmii2_rxd ; 
logic [15:0] nic_switch_mux_0_mac_cgmii2_rxc ; 
logic nic_switch_mux_0_mac_cgmii2_rxclk_ena ; 
logic [127:0] mac100_2_cgmii_txd ; 
logic [15:0] mac100_2_cgmii_txc ; 
logic nic_switch_mux_0_mac_cgmii2_txclk_ena ; 
logic [127:0] nic_switch_mux_0_mac_cgmii3_rxd ; 
logic [15:0] nic_switch_mux_0_mac_cgmii3_rxc ; 
logic nic_switch_mux_0_mac_cgmii3_rxclk_ena ; 
logic [127:0] mac100_3_cgmii_txd ; 
logic [15:0] mac100_3_cgmii_txc ; 
logic nic_switch_mux_0_mac_cgmii3_txclk_ena ; 
logic quadpcs100_0_xlgmii0_txclk_ena_0 ; 
logic quadpcs100_0_xlgmii0_rxclk_ena_0 ; 
logic [7:0] quadpcs100_0_xlgmii0_rxc ; 
logic [63:0] quadpcs100_0_xlgmii0_rxd ; 
logic quadpcs100_0_xlgmii0_rxt0_next ; 
logic [7:0] nic_switch_mux_0_pcs_xlgmii0_txc ; 
logic [63:0] nic_switch_mux_0_pcs_xlgmii0_txd ; 
logic quadpcs100_0_xlgmii1_txclk_ena_0 ; 
logic quadpcs100_0_xlgmii1_rxclk_ena_0 ; 
logic [7:0] quadpcs100_0_xlgmii1_rxc ; 
logic [63:0] quadpcs100_0_xlgmii1_rxd ; 
logic quadpcs100_0_xlgmii1_rxt0_next ; 
logic [7:0] nic_switch_mux_0_pcs_xlgmii1_txc ; 
logic [63:0] nic_switch_mux_0_pcs_xlgmii1_txd ; 
logic quadpcs100_0_xlgmii2_txclk_ena_0 ; 
logic quadpcs100_0_xlgmii2_rxclk_ena_0 ; 
logic [7:0] quadpcs100_0_xlgmii2_rxc ; 
logic [63:0] quadpcs100_0_xlgmii2_rxd ; 
logic quadpcs100_0_xlgmii2_rxt0_next ; 
logic [7:0] nic_switch_mux_0_pcs_xlgmii2_txc ; 
logic [63:0] nic_switch_mux_0_pcs_xlgmii2_txd ; 
logic quadpcs100_0_xlgmii3_txclk_ena_0 ; 
logic quadpcs100_0_xlgmii3_rxclk_ena_0 ; 
logic [7:0] quadpcs100_0_xlgmii3_rxc ; 
logic [63:0] quadpcs100_0_xlgmii3_rxd ; 
logic quadpcs100_0_xlgmii3_rxt0_next ; 
logic [7:0] nic_switch_mux_0_pcs_xlgmii3_txc ; 
logic [63:0] nic_switch_mux_0_pcs_xlgmii3_txd ; 
logic [127:0] quadpcs100_0_cgmii0_rxd ; 
logic [15:0] quadpcs100_0_cgmii0_rxc ; 
logic quadpcs100_0_cgmii0_rxclk_ena_0 ; 
logic [127:0] nic_switch_mux_0_pcs_cgmii0_txd ; 
logic [15:0] nic_switch_mux_0_pcs_cgmii0_txc ; 
logic quadpcs100_0_cgmii0_txclk_ena_0 ; 
logic [127:0] quadpcs100_0_cgmii1_rxd ; 
logic [15:0] quadpcs100_0_cgmii1_rxc ; 
logic quadpcs100_0_cgmii1_rxclk_ena_0 ; 
logic [127:0] nic_switch_mux_0_pcs_cgmii1_txd ; 
logic [15:0] nic_switch_mux_0_pcs_cgmii1_txc ; 
logic quadpcs100_0_cgmii1_txclk_ena_0 ; 
logic [127:0] quadpcs100_0_cgmii2_rxd ; 
logic [15:0] quadpcs100_0_cgmii2_rxc ; 
logic quadpcs100_0_cgmii2_rxclk_ena_0 ; 
logic [127:0] nic_switch_mux_0_pcs_cgmii2_txd ; 
logic [15:0] nic_switch_mux_0_pcs_cgmii2_txc ; 
logic quadpcs100_0_cgmii2_txclk_ena_0 ; 
logic [127:0] quadpcs100_0_cgmii3_rxd ; 
logic [15:0] quadpcs100_0_cgmii3_rxc ; 
logic quadpcs100_0_cgmii3_rxclk_ena_0 ; 
logic [127:0] nic_switch_mux_0_pcs_cgmii3_txd ; 
logic [15:0] nic_switch_mux_0_pcs_cgmii3_txc ; 
logic quadpcs100_0_cgmii3_txclk_ena_0 ; 
wire mac100_0_tx_sfd_o ; 
wire mac100_0_tx_sfd_shift_o ; 
logic mac100_0_rx_sfd_o ; 
logic mac100_0_rx_sfd_shift_o ; 
logic mac100_0_tx_ts_val ; 
logic [6:0] mac100_0_tx_ts_id ; 
logic [71:0] mac100_0_tx_ts ; 
wire mac100_1_tx_sfd_o ; 
wire mac100_1_tx_sfd_shift_o ; 
logic mac100_1_rx_sfd_o ; 
logic mac100_1_rx_sfd_shift_o ; 
logic mac100_1_tx_ts_val ; 
logic [6:0] mac100_1_tx_ts_id ; 
logic [71:0] mac100_1_tx_ts ; 
wire mac100_2_tx_sfd_o ; 
wire mac100_2_tx_sfd_shift_o ; 
logic mac100_2_rx_sfd_o ; 
logic mac100_2_rx_sfd_shift_o ; 
logic mac100_2_tx_ts_val ; 
logic [6:0] mac100_2_tx_ts_id ; 
logic [71:0] mac100_2_tx_ts ; 
wire mac100_3_tx_sfd_o ; 
wire mac100_3_tx_sfd_shift_o ; 
logic mac100_3_rx_sfd_o ; 
logic mac100_3_rx_sfd_shift_o ; 
logic mac100_3_tx_ts_val ; 
logic [6:0] mac100_3_tx_ts_id ; 
logic [71:0] mac100_3_tx_ts ; 
logic physs_pcs_mux_0_tx_ts_val ; 
logic [6:0] physs_pcs_mux_0_tx_ts_id_0 ; 
logic [31:0] physs_pcs_mux_0_tx_ts_0 ; 
logic [6:0] physs_pcs_mux_0_tx_ts_0_0 ; 
wire mac200_0_tx_ts_val ; 
wire [3:0] mac200_0_tx_ts_id ; 
wire [63:0] mac200_0_tx_ts ; 
wire mac400_0_tx_ts_val ; 
wire [3:0] mac400_0_tx_ts_id ; 
wire [63:0] mac400_0_tx_ts ; 
logic physs_pcs_mux_0_tx_ts_val_0 ; 
logic [6:0] physs_pcs_mux_0_tx_ts_id_1 ; 
logic [31:0] physs_pcs_mux_0_tx_ts_1 ; 
logic [6:0] physs_pcs_mux_0_tx_ts_1_0 ; 
logic physs_pcs_mux_0_tx_ts_val_1 ; 
logic [6:0] physs_pcs_mux_0_tx_ts_id_2 ; 
logic [31:0] physs_pcs_mux_0_tx_ts_2 ; 
logic [6:0] physs_pcs_mux_0_tx_ts_2_0 ; 
logic physs_pcs_mux_0_tx_ts_val_2 ; 
logic [6:0] physs_pcs_mux_0_tx_ts_id_3 ; 
logic [31:0] physs_pcs_mux_0_tx_ts_3 ; 
logic [6:0] physs_pcs_mux_0_tx_ts_3_0 ; 
logic nic_switch_mux_0_mac_ff_tx_ts_frm_0 ; 
logic [55:0] nic_switch_mux_0_mac_ff_tx_preamble_0 ; 
logic [6:0] nic_switch_mux_0_mac_ff_tx_id_0 ; 
logic nic_switch_mux_0_mac_ff_tx_ts_frm_1 ; 
logic [55:0] nic_switch_mux_0_mac_ff_tx_preamble_1 ; 
logic [6:0] nic_switch_mux_0_mac_ff_tx_id_1 ; 
logic nic_switch_mux_0_mac_ff_tx_ts_frm_2 ; 
logic [55:0] nic_switch_mux_0_mac_ff_tx_preamble_2 ; 
logic [6:0] nic_switch_mux_0_mac_ff_tx_id_2 ; 
logic nic_switch_mux_0_mac_ff_tx_ts_frm_3 ; 
logic [55:0] nic_switch_mux_0_mac_ff_tx_preamble_3 ; 
logic [6:0] nic_switch_mux_0_mac_ff_tx_id_3 ; 
logic [31:0] pcs400_0_sd0_tx ; 
logic [31:0] pcs400_0_sd1_tx ; 
logic [31:0] pcs400_0_sd2_tx ; 
logic [31:0] pcs400_0_sd3_tx ; 
logic [31:0] pcs400_0_sd4_tx ; 
logic [31:0] pcs400_0_sd5_tx ; 
logic [31:0] pcs400_0_sd6_tx ; 
logic [31:0] pcs400_0_sd7_tx ; 
logic [31:0] pcs400_0_sd8_tx ; 
logic [31:0] pcs400_0_sd9_tx ; 
logic [31:0] pcs400_0_sd10_tx ; 
logic [31:0] pcs400_0_sd11_tx ; 
logic [31:0] pcs400_0_sd12_tx ; 
logic [31:0] pcs400_0_sd13_tx ; 
logic [31:0] pcs400_0_sd14_tx ; 
logic [31:0] pcs400_0_sd15_tx ; 
logic [31:0] physs_pcs_mux_0_sd0_rx_data_400G_o ; 
logic [31:0] physs_pcs_mux_0_sd1_rx_data_400G_o ; 
logic [31:0] physs_pcs_mux_0_sd2_rx_data_400G_o ; 
logic [31:0] physs_pcs_mux_0_sd3_rx_data_400G_o ; 
logic [31:0] physs_pcs_mux_0_sd4_rx_data_400G_o ; 
logic [31:0] physs_pcs_mux_0_sd5_rx_data_400G_o ; 
logic [31:0] physs_pcs_mux_0_sd6_rx_data_400G_o ; 
logic [31:0] physs_pcs_mux_0_sd7_rx_data_400G_o ; 
logic [31:0] physs_pcs_mux_0_sd8_rx_data_400G_o ; 
logic [31:0] physs_pcs_mux_0_sd9_rx_data_400G_o ; 
logic [31:0] physs_pcs_mux_0_sd10_rx_data_400G_o ; 
logic [31:0] physs_pcs_mux_0_sd11_rx_data_400G_o ; 
logic [31:0] physs_pcs_mux_0_sd12_rx_data_400G_o ; 
logic [31:0] physs_pcs_mux_0_sd13_rx_data_400G_o ; 
logic [31:0] physs_pcs_mux_0_sd14_rx_data_400G_o ; 
logic [31:0] physs_pcs_mux_0_sd15_rx_data_400G_o ; 
logic [31:0] pcs200_0_sd0_tx ; 
logic [31:0] pcs200_0_sd1_tx ; 
logic [31:0] pcs200_0_sd2_tx ; 
logic [31:0] pcs200_0_sd3_tx ; 
logic [31:0] pcs200_0_sd4_tx ; 
logic [31:0] pcs200_0_sd5_tx ; 
logic [31:0] pcs200_0_sd6_tx ; 
logic [31:0] pcs200_0_sd7_tx ; 
logic [31:0] physs_pcs_mux_0_sd0_rx_data_o ; 
logic [31:0] physs_pcs_mux_0_sd1_rx_data_o ; 
logic [31:0] physs_pcs_mux_0_sd2_rx_data_o ; 
logic [31:0] physs_pcs_mux_0_sd3_rx_data_o ; 
logic [31:0] physs_pcs_mux_0_sd4_rx_data_o ; 
logic [31:0] physs_pcs_mux_0_sd5_rx_data_o ; 
logic [31:0] physs_pcs_mux_0_sd6_rx_data_o ; 
logic [31:0] physs_pcs_mux_0_sd7_rx_data_o ; 
logic [127:0] quadpcs100_0_sd0_tx ; 
logic [127:0] quadpcs100_0_sd1_tx ; 
logic [127:0] quadpcs100_0_sd2_tx ; 
logic [127:0] quadpcs100_0_sd3_tx ; 
logic [127:0] physs_pcs_mux_0_sd0_rx_data_o_0 ; 
logic [127:0] physs_pcs_mux_0_sd1_rx_data_o_0 ; 
logic [127:0] physs_pcs_mux_0_sd2_rx_data_o_0 ; 
logic [127:0] physs_pcs_mux_0_sd3_rx_data_o_0 ; 
logic [127:0] physs_pcs_mux_0_sd0_tx_data_o ; 
logic [127:0] physs_pcs_mux_0_sd1_tx_data_o ; 
logic [127:0] physs_pcs_mux_0_sd2_tx_data_o ; 
logic [127:0] physs_pcs_mux_0_sd3_tx_data_o ; 
logic [127:0] physs_lane_reversal_mux_0_sd0_rx_data_o ; 
logic [127:0] physs_lane_reversal_mux_0_sd1_rx_data_o ; 
logic [127:0] physs_lane_reversal_mux_0_sd2_rx_data_o ; 
logic [127:0] physs_lane_reversal_mux_0_sd3_rx_data_o ; 
logic [3:0] physs_pcs_mux_0_link_status_out ; 
logic [3:0] physs_lane_reversal_mux_0_oflux_srds_rdy_out ; 
logic [3:0] physs_pcs_mux_0_srds_rdy_out_100G ; 
logic physs_pcs_mux_0_srds_rdy_out_200G ; 
logic physs_pcs_mux_0_srds_rdy_out_400G ; 
logic [3:0] physs_pcs_mux_0_sd_tx_clk_100G ; 
logic [3:0] physs_pcs_mux_0_sd_rx_clk_100G ; 
logic physs_pcs_mux_0_sd0_tx_clk_200G ; 
logic physs_pcs_mux_0_sd2_tx_clk_200G ; 
logic physs_pcs_mux_0_sd4_tx_clk_200G ; 
logic physs_pcs_mux_0_sd6_tx_clk_200G ; 
logic physs_pcs_mux_0_sd8_tx_clk_200G ; 
logic physs_pcs_mux_0_sd10_tx_clk_200G ; 
logic physs_pcs_mux_0_sd12_tx_clk_200G ; 
logic physs_pcs_mux_0_sd14_tx_clk_200G ; 
logic physs_pcs_mux_0_sd0_rx_clk_200G ; 
logic physs_pcs_mux_0_sd1_rx_clk_200G ; 
logic physs_pcs_mux_0_sd2_rx_clk_200G ; 
logic physs_pcs_mux_0_sd3_rx_clk_200G ; 
logic physs_pcs_mux_0_sd4_rx_clk_200G ; 
logic physs_pcs_mux_0_sd5_rx_clk_200G ; 
logic physs_pcs_mux_0_sd6_rx_clk_200G ; 
logic physs_pcs_mux_0_sd7_rx_clk_200G ; 
logic physs_pcs_mux_0_sd8_rx_clk_200G ; 
logic physs_pcs_mux_0_sd9_rx_clk_200G ; 
logic physs_pcs_mux_0_sd10_rx_clk_200G ; 
logic physs_pcs_mux_0_sd11_rx_clk_200G ; 
logic physs_pcs_mux_0_sd12_rx_clk_200G ; 
logic physs_pcs_mux_0_sd13_rx_clk_200G ; 
logic physs_pcs_mux_0_sd14_rx_clk_200G ; 
logic physs_pcs_mux_0_sd15_rx_clk_200G ; 
logic physs_pcs_mux_0_sd0_tx_clk_400G ; 
logic physs_pcs_mux_0_sd2_tx_clk_400G ; 
logic physs_pcs_mux_0_sd4_tx_clk_400G ; 
logic physs_pcs_mux_0_sd6_tx_clk_400G ; 
logic physs_pcs_mux_0_sd8_tx_clk_400G ; 
logic physs_pcs_mux_0_sd10_tx_clk_400G ; 
logic physs_pcs_mux_0_sd12_tx_clk_400G ; 
logic physs_pcs_mux_0_sd14_tx_clk_400G ; 
logic physs_pcs_mux_0_sd0_rx_clk_400G ; 
logic physs_pcs_mux_0_sd1_rx_clk_400G ; 
logic physs_pcs_mux_0_sd2_rx_clk_400G ; 
logic physs_pcs_mux_0_sd3_rx_clk_400G ; 
logic physs_pcs_mux_0_sd4_rx_clk_400G ; 
logic physs_pcs_mux_0_sd5_rx_clk_400G ; 
logic physs_pcs_mux_0_sd6_rx_clk_400G ; 
logic physs_pcs_mux_0_sd7_rx_clk_400G ; 
logic physs_pcs_mux_0_sd8_rx_clk_400G ; 
logic physs_pcs_mux_0_sd9_rx_clk_400G ; 
logic physs_pcs_mux_0_sd10_rx_clk_400G ; 
logic physs_pcs_mux_0_sd11_rx_clk_400G ; 
logic physs_pcs_mux_0_sd12_rx_clk_400G ; 
logic physs_pcs_mux_0_sd13_rx_clk_400G ; 
logic physs_pcs_mux_0_sd14_rx_clk_400G ; 
logic physs_pcs_mux_0_sd15_rx_clk_400G ; 
logic [127:0] physs_lane_reversal_mux_0_sd0_tx_data_o ; 
logic [127:0] physs_lane_reversal_mux_0_sd1_tx_data_o ; 
logic [127:0] physs_lane_reversal_mux_0_sd2_tx_data_o ; 
logic [127:0] physs_lane_reversal_mux_0_sd3_tx_data_o ; 
logic [127:0] versa_xmp_0_o_pma0_rxdat_word_l0 ; 
logic [127:0] versa_xmp_0_o_pma1_rxdat_word_l0 ; 
logic [127:0] versa_xmp_0_o_pma2_rxdat_word_l0 ; 
logic [127:0] versa_xmp_0_o_pma3_rxdat_word_l0 ; 
logic versa_xmp_0_o_ck_pma0_rxdat_word_l0 ; 
logic versa_xmp_0_o_ck_pma1_rxdat_word_l0 ; 
logic versa_xmp_0_o_ck_pma2_rxdat_word_l0 ; 
logic versa_xmp_0_o_ck_pma3_rxdat_word_l0 ; 
logic versa_xmp_0_o_ck_pma0_txdat_word_l0_0 ; 
logic versa_xmp_0_o_ck_pma1_txdat_word_l0_0 ; 
logic versa_xmp_0_o_ck_pma2_txdat_word_l0_0 ; 
logic versa_xmp_0_o_ck_pma3_txdat_word_l0_0 ; 
logic rxwordclk_0_pdop_parmquad0_clkout ; 
logic rxwordclk_1_pdop_parmquad0_clkout ; 
logic rxwordclk_2_pdop_parmquad0_clkout ; 
logic rxwordclk_3_pdop_parmquad0_clkout ; 
logic txwordclk_0_pdop_parmquad0_clkout ; 
logic txwordclk_1_pdop_parmquad0_clkout ; 
logic txwordclk_2_pdop_parmquad0_clkout ; 
logic txwordclk_3_pdop_parmquad0_clkout ; 
logic mac100_0_ff_rx_dval_0 ; 
logic [255:0] mac100_0_ff_rx_data ; 
logic mac100_0_ff_rx_sop ; 
logic mac100_0_ff_rx_eop_0 ; 
logic [4:0] mac100_0_ff_rx_mod_0 ; 
logic fifo_mux_0_mac100g_0_rx_rdy ; 
logic [6:0] mac100_0_ff_rx_ts ; 
logic [31:0] mac100_0_ff_rx_ts_0 ; 
logic fifo_mux_0_mac100g_0_tx_wren ; 
logic [255:0] fifo_mux_0_mac100g_0_tx_data ; 
logic fifo_mux_0_mac100g_0_tx_sop ; 
logic fifo_mux_0_mac100g_0_tx_eop ; 
logic [4:0] fifo_mux_0_mac100g_0_tx_mod ; 
logic fifo_mux_0_mac100g_0_tx_err ; 
logic fifo_mux_0_mac100g_0_tx_crc ; 
logic mac100_0_ff_tx_rdy_0 ; 
logic mac100_1_ff_rx_dval_0 ; 
logic [255:0] mac100_1_ff_rx_data ; 
logic mac100_1_ff_rx_sop ; 
logic mac100_1_ff_rx_eop_0 ; 
logic [4:0] mac100_1_ff_rx_mod_0 ; 
logic fifo_mux_0_mac100g_1_rx_rdy ; 
logic [6:0] mac100_1_ff_rx_ts ; 
logic [31:0] mac100_1_ff_rx_ts_0 ; 
logic fifo_mux_0_mac100g_1_tx_wren ; 
logic [255:0] fifo_mux_0_mac100g_1_tx_data ; 
logic fifo_mux_0_mac100g_1_tx_sop ; 
logic fifo_mux_0_mac100g_1_tx_eop ; 
logic [4:0] fifo_mux_0_mac100g_1_tx_mod ; 
logic fifo_mux_0_mac100g_1_tx_err ; 
logic fifo_mux_0_mac100g_1_tx_crc ; 
logic mac100_1_ff_tx_rdy_0 ; 
logic mac100_2_ff_rx_dval_0 ; 
logic [255:0] mac100_2_ff_rx_data ; 
logic mac100_2_ff_rx_sop ; 
logic mac100_2_ff_rx_eop_0 ; 
logic [4:0] mac100_2_ff_rx_mod_0 ; 
logic fifo_mux_0_mac100g_2_rx_rdy ; 
logic [6:0] mac100_2_ff_rx_ts ; 
logic [31:0] mac100_2_ff_rx_ts_0 ; 
logic fifo_mux_0_mac100g_2_tx_wren ; 
logic [255:0] fifo_mux_0_mac100g_2_tx_data ; 
logic fifo_mux_0_mac100g_2_tx_sop ; 
logic fifo_mux_0_mac100g_2_tx_eop ; 
logic [4:0] fifo_mux_0_mac100g_2_tx_mod ; 
logic fifo_mux_0_mac100g_2_tx_err ; 
logic fifo_mux_0_mac100g_2_tx_crc ; 
logic mac100_2_ff_tx_rdy_0 ; 
logic mac100_3_ff_rx_dval_0 ; 
logic [255:0] mac100_3_ff_rx_data ; 
logic mac100_3_ff_rx_sop ; 
logic mac100_3_ff_rx_eop_0 ; 
logic [4:0] mac100_3_ff_rx_mod_0 ; 
logic fifo_mux_0_mac100g_3_rx_rdy ; 
logic [6:0] mac100_3_ff_rx_ts ; 
logic [31:0] mac100_3_ff_rx_ts_0 ; 
logic fifo_mux_0_mac100g_3_tx_wren ; 
logic [255:0] fifo_mux_0_mac100g_3_tx_data ; 
logic fifo_mux_0_mac100g_3_tx_sop ; 
logic fifo_mux_0_mac100g_3_tx_eop ; 
logic [4:0] fifo_mux_0_mac100g_3_tx_mod ; 
logic fifo_mux_0_mac100g_3_tx_err ; 
logic fifo_mux_0_mac100g_3_tx_crc ; 
logic mac100_3_ff_tx_rdy_0 ; 
wire mac400_0_ff_rx_dval ; 
wire [1023:0] mac400_0_ff_rx_data ; 
wire mac400_0_ff_rx_sop ; 
wire mac400_0_ff_rx_eop ; 
wire [6:0] mac400_0_ff_rx_mod ; 
wire mac400_0_ff_rx_err ; 
logic fifo_mux_0_mac400g_0_rx_rdy ; 
logic [38:0] mac400_0_ff_rx_ts ; 
logic fifo_mux_0_mac400g_0_tx_wren ; 
logic [1023:0] fifo_mux_0_mac400g_0_tx_data ; 
logic fifo_mux_0_mac400g_0_tx_sop ; 
logic fifo_mux_0_mac400g_0_tx_eop ; 
logic [6:0] fifo_mux_0_mac400g_0_tx_mod ; 
logic fifo_mux_0_mac400g_0_tx_err ; 
logic fifo_mux_0_mac400g_0_tx_crc ; 
wire mac400_0_ff_tx_rdy ; 
wire mac200_0_ff_rx_dval ; 
wire [1023:0] mac200_0_ff_rx_data ; 
wire mac200_0_ff_rx_sop ; 
wire mac200_0_ff_rx_eop ; 
wire [6:0] mac200_0_ff_rx_mod ; 
wire mac200_0_ff_rx_err ; 
logic fifo_mux_0_mac400g_1_rx_rdy ; 
logic [38:0] mac200_0_ff_rx_ts ; 
logic fifo_mux_0_mac400g_1_tx_wren ; 
logic [1023:0] fifo_mux_0_mac400g_1_tx_data ; 
logic fifo_mux_0_mac400g_1_tx_sop ; 
logic fifo_mux_0_mac400g_1_tx_eop ; 
logic [6:0] fifo_mux_0_mac400g_1_tx_mod ; 
logic fifo_mux_0_mac400g_1_tx_err ; 
logic fifo_mux_0_mac400g_1_tx_crc ; 
wire mac200_0_ff_tx_rdy ; 
logic mac100_0_mac_enable ; 
logic mac100_0_mac_pause_en ; 
logic mac100_1_mac_enable ; 
logic mac100_1_mac_pause_en ; 
logic mac100_2_mac_enable ; 
logic mac100_2_mac_pause_en ; 
logic mac100_3_mac_enable ; 
logic mac100_3_mac_pause_en ; 
logic physs_registers_wrapper_0_mac100_config_0_magic_ena ; 
logic physs_registers_wrapper_0_mac100_config_1_magic_ena ; 
logic physs_registers_wrapper_0_mac100_config_2_magic_ena ; 
logic physs_registers_wrapper_0_mac100_config_3_magic_ena ; 
logic physs_registers_wrapper_0_mac100_config_0_tx_loc_fault ; 
logic physs_registers_wrapper_0_mac100_config_1_tx_loc_fault ; 
logic physs_registers_wrapper_0_mac100_config_2_tx_loc_fault ; 
logic physs_registers_wrapper_0_mac100_config_3_tx_loc_fault ; 
logic physs_registers_wrapper_0_mac100_config_0_tx_rem_fault ; 
logic physs_registers_wrapper_0_mac100_config_1_tx_rem_fault ; 
logic physs_registers_wrapper_0_mac100_config_2_tx_rem_fault ; 
logic physs_registers_wrapper_0_mac100_config_3_tx_rem_fault ; 
logic physs_registers_wrapper_0_mac100_config_0_tx_li_fault ; 
logic physs_registers_wrapper_0_mac100_config_1_tx_li_fault ; 
logic physs_registers_wrapper_0_mac100_config_2_tx_li_fault ; 
logic physs_registers_wrapper_0_mac100_config_3_tx_li_fault ; 
logic physs_registers_wrapper_0_oflux_srds_rdy_ovr0 ; 
logic physs_registers_wrapper_0_oflux_srds_rdy_ovr1 ; 
logic physs_registers_wrapper_0_oflux_srds_rdy_ovr2 ; 
logic physs_registers_wrapper_0_oflux_srds_rdy_ovr3 ; 
logic physs_registers_wrapper_0_oflux_srds_rdy_ovr_en0 ; 
logic physs_registers_wrapper_0_oflux_srds_rdy_ovr_en1 ; 
logic physs_registers_wrapper_0_oflux_srds_rdy_ovr_en2 ; 
logic physs_registers_wrapper_0_oflux_srds_rdy_ovr_en3 ; 
logic physs_registers_wrapper_0_reset_xmp_ovveride_en ; 
logic physs_registers_wrapper_0_reset_pcs100_ovveride_en ; 
logic physs_registers_wrapper_0_reset_pcs200_ovveride_en ; 
logic physs_registers_wrapper_0_reset_pcs400_ovveride_en ; 
logic physs_registers_wrapper_0_reset_mac400_ovveride_en ; 
logic physs_registers_wrapper_0_reset_mac200_ovveride_en ; 
logic physs_registers_wrapper_0_reset_mac100_ovveride_en ; 
logic physs_registers_wrapper_0_power_fsm_clk_gate_en ; 
logic physs_registers_wrapper_0_power_fsm_reset_gate_en ; 
logic ptp_mem_bridge_0_timestamp_valid ; 
logic [44:0] ptp_mem_bridge_0_ptp_mem_clr_data ; 
logic [3:0] ptp_mem_bridge_0_clear_ts_reg ; 
logic [23:0] versa_xmp_0_o_slv_pcs1_apb_paddr ; 
logic [2:0] versa_xmp_0_o_slv_pcs1_apb_pprot ; 
logic versa_xmp_0_o_slv_pcs1_apb_psel ; 
logic versa_xmp_0_o_slv_pcs1_apb_penable ; 
logic versa_xmp_0_o_slv_pcs1_apb_pwrite ; 
logic [31:0] versa_xmp_0_o_slv_pcs1_apb_pwdata ; 
logic [3:0] versa_xmp_0_o_slv_pcs1_apb_pstrb ; 
logic nic400_quad_0_hreadyout_slave_xmp_if1 ; 
logic nic400_quad_0_hresp_slave_xmp_if1 ; 
logic [31:0] nic400_quad_0_hrdata_slave_xmp_if1 ; 
logic apb_to_ahb_sync_0_pready ; 
logic [31:0] apb_to_ahb_sync_0_prdata ; 
logic apb_to_ahb_sync_0_pslverr ; 
logic apb_to_ahb_sync_0_hsel ; 
logic [31:0] apb_to_ahb_sync_0_haddr ; 
logic apb_to_ahb_sync_0_hwrite ; 
logic [1:0] apb_to_ahb_sync_0_htrans ; 
logic [2:0] apb_to_ahb_sync_0_hsize ; 
logic [2:0] apb_to_ahb_sync_0_hburst ; 
logic [3:0] apb_to_ahb_sync_0_hprot ; 
logic apb_to_ahb_sync_0_hreadyin ; 
logic [31:0] apb_to_ahb_sync_0_hwdata ; 
wire [14:0] DW_ahb_0_haddr_s17 ; 
wire [2:0] DW_ahb_0_hsize_0 ; 
wire [1:0] DW_ahb_0_htrans_0 ; 
wire [31:0] DW_ahb_0_hwdata_0 ; 
wire DW_ahb_0_hwrite_0 ; 
wire ptp_mem_bridge_0_hreadyout ; 
wire [1:0] ptp_mem_bridge_0_hresp ; 
wire [31:0] ptp_mem_bridge_0_hrdata ; 
wire DW_ahb_0_hsel_s17 ; 
logic [12:0] ptp_mem_bridge_0_clear_ts_reg_addr ; 
logic physs_clock_sync_0_reset_txclk_1 ; 
logic physs_clock_sync_0_reset_txclk_2 ; 
logic physs_clock_sync_0_reset_txclk_3 ; 
logic physs_clock_sync_0_reset_txclk_4 ; 
logic physs_clock_sync_0_reset_ff_tx_clk_1 ; 
logic physs_clock_sync_0_reset_ff_tx_clk_2 ; 
logic physs_clock_sync_0_reset_ff_tx_clk_3 ; 
logic physs_clock_sync_0_reset_ff_tx_clk_4 ; 
logic physs_clock_sync_0_reset_ff_rx_clk_1 ; 
logic physs_clock_sync_0_reset_ff_rx_clk_2 ; 
logic physs_clock_sync_0_reset_ff_rx_clk_3 ; 
logic physs_clock_sync_0_reset_ff_rx_clk_4 ; 
logic physs_clock_sync_0_rst_pma1_por_b_a ; 
logic physs_clock_sync_0_rst_pma2_por_b_a ; 
logic physs_clock_sync_0_rst_pma3_por_b_a ; 
logic physs_lane_reversal_mux_0_link_status_out ; 
logic physs_lane_reversal_mux_0_link_status_out_0 ; 
logic physs_lane_reversal_mux_0_link_status_out_1 ; 
logic physs_lane_reversal_mux_0_link_status_out_2 ; 
logic versa_xmp_0_o_ck_pma0_main ; 
logic versa_xmp_0_o_ck_pma1_main ; 
logic versa_xmp_0_o_ck_pma2_main ; 
logic versa_xmp_0_o_ck_pma3_main ; 
logic versa_xmp_0_o_ck_pma0_ref0_pad2cmos ; 
logic versa_xmp_0_o_ck_pma1_ref0_pad2cmos ; 
logic versa_xmp_0_o_ck_pma2_ref0_pad2cmos ; 
logic versa_xmp_0_o_ck_pma3_ref0_pad2cmos ; 
logic versa_xmp_0_o_ck_pma0_ref1_pad2cmos ; 
logic versa_xmp_0_o_ck_pma1_ref1_pad2cmos ; 
logic versa_xmp_0_o_ck_pma2_ref1_pad2cmos ; 
logic versa_xmp_0_o_ck_pma3_ref1_pad2cmos ; 
logic versa_xmp_0_o_ck_pma0_tx_postdiv_l0 ; 
logic versa_xmp_0_o_ck_pma1_tx_postdiv_l0 ; 
logic versa_xmp_0_o_ck_pma2_tx_postdiv_l0 ; 
logic versa_xmp_0_o_ck_pma3_tx_postdiv_l0 ; 
logic versa_xmp_0_o_ck_pma0_cmnplla_postdiv ; 
logic versa_xmp_0_o_ck_pma0_cmnpllb_postdiv ; 
logic versa_xmp_0_o_ck_pma1_cmnplla_postdiv ; 
logic versa_xmp_0_o_ck_pma1_cmnpllb_postdiv ; 
logic versa_xmp_0_o_ck_pma2_cmnplla_postdiv ; 
logic versa_xmp_0_o_ck_pma2_cmnpllb_postdiv ; 
logic versa_xmp_0_o_ck_pma3_cmnplla_postdiv ; 
logic versa_xmp_0_o_ck_pma3_cmnpllb_postdiv ; 
logic versa_xmp_0_o_ck_pma0_txfifolatency_measlatrndtripbit_l0 ; 
logic versa_xmp_0_o_ck_pma1_txfifolatency_measlatrndtripbit_l0 ; 
logic versa_xmp_0_o_ck_pma2_txfifolatency_measlatrndtripbit_l0 ; 
logic versa_xmp_0_o_ck_pma3_txfifolatency_measlatrndtripbit_l0 ; 
wire [13:0] hidft_open_0 ; 
wire [13:0] hidft_open_1 ; 
wire [13:0] hidft_open_2 ; 
wire [13:0] hidft_open_3 ; 
wire [13:0] hidft_open_4 ; 
wire [13:0] hidft_open_5 ; 
wire [13:0] hidft_open_6 ; 
wire [13:0] hidft_open_7 ; 
wire [13:0] hidft_open_8 ; 
wire [13:0] hidft_open_9 ; 
wire [13:0] hidft_open_10 ; 
wire [13:0] hidft_open_11 ; 
wire [13:0] hidft_open_12 ; 
wire [13:0] hidft_open_13 ; 
wire [13:0] hidft_open_14 ; 
wire [13:0] hidft_open_15 ; 
wire [7:0] hidft_open_16 ; 
wire [19:0] hidft_open_17 ; 
wire [32:0] hidft_open_18 ; 
wire [32:0] hidft_open_19 ; 
wire [32:0] hidft_open_20 ; 
wire [32:0] hidft_open_21 ; 
wire [1:0] hidft_open_22 ; 
wire [5:0] hidft_open_23 ; 
wire hidft_open_24 ; 
wire hidft_open_25 ; 
wire hidft_open_26 ; 
wire hidft_open_27 ; 
wire hidft_open_28 ; 
// EDIT_NET END

// EDIT_INSTANCE BEGIN
pcs100_wrap_0 pcs100_wrap_0 (
    .quadpcs100_0_pcs_link_status(quadpcs100_0_pcs_link_status), 
    .nic400_quad_0_haddr_pcs_quad_out(nic400_quad_0_haddr_pcs_quad_out), 
    .nic400_quad_0_htrans_pcs_quad(nic400_quad_0_htrans_pcs_quad), 
    .nic400_quad_0_hburst_pcs_quad(nic400_quad_0_hburst_pcs_quad), 
    .nic400_quad_0_hprot_pcs_quad(nic400_quad_0_hprot_pcs_quad), 
    .nic400_quad_0_hwrite_pcs_quad(nic400_quad_0_hwrite_pcs_quad), 
    .nic400_quad_0_hsize_pcs_quad(nic400_quad_0_hsize_pcs_quad), 
    .nic400_quad_0_hwdata_pcs_quad(nic400_quad_0_hwdata_pcs_quad), 
    .DW_ahb_0_hrdata(DW_ahb_0_hrdata), 
    .DW_ahb_0_hresp(DW_ahb_0_hresp), 
    .DW_ahb_0_hready(DW_ahb_0_hready), 
    .physs_registers_wrapper_0_mac100_config_0_cfg_mode128(physs_registers_wrapper_0_mac100_config_0_cfg_mode128), 
    .physs_registers_wrapper_0_mac100_config_1_cfg_mode128(physs_registers_wrapper_0_mac100_config_1_cfg_mode128), 
    .physs_registers_wrapper_0_mac100_config_2_cfg_mode128(physs_registers_wrapper_0_mac100_config_2_cfg_mode128), 
    .physs_registers_wrapper_0_mac100_config_3_cfg_mode128(physs_registers_wrapper_0_mac100_config_3_cfg_mode128), 
    .physs_registers_wrapper_0_pcs100_sgmii0_reg_sg0_sgpcs_ena(physs_registers_wrapper_0_pcs100_sgmii0_reg_sg0_sgpcs_ena), 
    .physs_registers_wrapper_0_pcs100_sgmii1_reg_sg0_sgpcs_ena(physs_registers_wrapper_0_pcs100_sgmii1_reg_sg0_sgpcs_ena), 
    .physs_registers_wrapper_0_pcs100_sgmii2_reg_sg0_sgpcs_ena(physs_registers_wrapper_0_pcs100_sgmii2_reg_sg0_sgpcs_ena), 
    .physs_registers_wrapper_0_pcs100_sgmii3_reg_sg0_sgpcs_ena(physs_registers_wrapper_0_pcs100_sgmii3_reg_sg0_sgpcs_ena), 
    .quadpcs100_0_pcs_desk_buf_rlevel(quadpcs100_0_pcs_desk_buf_rlevel), 
    .quadpcs100_0_pcs_desk_buf_rlevel_0(quadpcs100_0_pcs_desk_buf_rlevel_0), 
    .quadpcs100_0_pcs_desk_buf_rlevel_1(quadpcs100_0_pcs_desk_buf_rlevel_1), 
    .quadpcs100_0_pcs_desk_buf_rlevel_2(quadpcs100_0_pcs_desk_buf_rlevel_2), 
    .quadpcs100_0_pcs0_fec_locked(quadpcs100_0_pcs0_fec_locked), 
    .quadpcs100_0_pcs0_fec_ncerr(quadpcs100_0_pcs0_fec_ncerr), 
    .quadpcs100_0_pcs0_fec_cerr(quadpcs100_0_pcs0_fec_cerr), 
    .quadpcs100_0_pcs1_fec_locked(quadpcs100_0_pcs1_fec_locked), 
    .quadpcs100_0_pcs1_fec_ncerr(quadpcs100_0_pcs1_fec_ncerr), 
    .quadpcs100_0_pcs1_fec_cerr(quadpcs100_0_pcs1_fec_cerr), 
    .quadpcs100_0_sg0_hd(quadpcs100_0_sg0_hd), 
    .quadpcs100_0_sg0_speed(quadpcs100_0_sg0_speed), 
    .quadpcs100_0_sg0_page_rx(quadpcs100_0_sg0_page_rx), 
    .quadpcs100_0_sg0_an_done(quadpcs100_0_sg0_an_done), 
    .quadpcs100_0_sg0_rx_sync(quadpcs100_0_sg0_rx_sync), 
    .quadpcs100_0_sg1_hd(quadpcs100_0_sg1_hd), 
    .quadpcs100_0_sg1_speed(quadpcs100_0_sg1_speed), 
    .quadpcs100_0_sg1_page_rx(quadpcs100_0_sg1_page_rx), 
    .quadpcs100_0_sg1_an_done(quadpcs100_0_sg1_an_done), 
    .quadpcs100_0_sg1_rx_sync(quadpcs100_0_sg1_rx_sync), 
    .quadpcs100_0_sg2_hd(quadpcs100_0_sg2_hd), 
    .quadpcs100_0_sg2_speed(quadpcs100_0_sg2_speed), 
    .quadpcs100_0_sg2_page_rx(quadpcs100_0_sg2_page_rx), 
    .quadpcs100_0_sg2_an_done(quadpcs100_0_sg2_an_done), 
    .quadpcs100_0_sg2_rx_sync(quadpcs100_0_sg2_rx_sync), 
    .quadpcs100_0_sg3_hd(quadpcs100_0_sg3_hd), 
    .quadpcs100_0_sg3_speed(quadpcs100_0_sg3_speed), 
    .quadpcs100_0_sg3_page_rx(quadpcs100_0_sg3_page_rx), 
    .quadpcs100_0_sg3_an_done(quadpcs100_0_sg3_an_done), 
    .quadpcs100_0_sg3_rx_sync(quadpcs100_0_sg3_rx_sync), 
    .quadpcs100_0_pcs_mac0_res_speed(quadpcs100_0_pcs_mac0_res_speed), 
    .quadpcs100_0_pcs_mac1_res_speed(quadpcs100_0_pcs_mac1_res_speed), 
    .quadpcs100_0_pcs_mac2_res_speed(quadpcs100_0_pcs_mac2_res_speed), 
    .quadpcs100_0_pcs_mac3_res_speed(quadpcs100_0_pcs_mac3_res_speed), 
    .quadpcs100_0_pcs_rsfec_aligned(quadpcs100_0_pcs_rsfec_aligned), 
    .quadpcs100_0_pcs_amps_lock(quadpcs100_0_pcs_amps_lock), 
    .quadpcs100_0_pcs_align_done(quadpcs100_0_pcs_align_done), 
    .quadpcs100_0_pcs_hi_ber(quadpcs100_0_pcs_hi_ber), 
    .quadpcs100_0_usxgmii0_an_pability(quadpcs100_0_usxgmii0_an_pability), 
    .quadpcs100_0_usxgmii0_an_pability_done(quadpcs100_0_usxgmii0_an_pability_done), 
    .quadpcs100_0_usxgmii0_an_busy(quadpcs100_0_usxgmii0_an_busy), 
    .quadpcs100_0_usxgmii1_an_pability(quadpcs100_0_usxgmii1_an_pability), 
    .quadpcs100_0_usxgmii1_an_pability_done(quadpcs100_0_usxgmii1_an_pability_done), 
    .quadpcs100_0_usxgmii1_an_busy(quadpcs100_0_usxgmii1_an_busy), 
    .quadpcs100_0_usxgmii2_an_pability(quadpcs100_0_usxgmii2_an_pability), 
    .quadpcs100_0_usxgmii2_an_pability_done(quadpcs100_0_usxgmii2_an_pability_done), 
    .quadpcs100_0_usxgmii2_an_busy(quadpcs100_0_usxgmii2_an_busy), 
    .quadpcs100_0_usxgmii3_an_pability(quadpcs100_0_usxgmii3_an_pability), 
    .quadpcs100_0_usxgmii3_an_pability_done(quadpcs100_0_usxgmii3_an_pability_done), 
    .quadpcs100_0_usxgmii3_an_busy(quadpcs100_0_usxgmii3_an_busy), 
    .physs_registers_wrapper_0_pcs100_sgmii0_reg_sg0_tx_lane_thresh(physs_registers_wrapper_0_pcs100_sgmii0_reg_sg0_tx_lane_thresh), 
    .physs_registers_wrapper_0_pcs100_sgmii0_reg_sg0_sg_tx_lane_ckmult(physs_registers_wrapper_0_pcs100_sgmii0_reg_sg0_sg_tx_lane_ckmult), 
    .physs_registers_wrapper_0_pcs100_sgmii0_reg_sg0_mode_br_dis(physs_registers_wrapper_0_pcs100_sgmii0_reg_sg0_mode_br_dis), 
    .physs_registers_wrapper_0_pcs100_sgmii0_reg_sg0_seq_ena(physs_registers_wrapper_0_pcs100_sgmii0_reg_sg0_seq_ena), 
    .physs_registers_wrapper_0_pcs100_sgmii0_reg_sg0_mode_sync(physs_registers_wrapper_0_pcs100_sgmii0_reg_sg0_mode_sync), 
    .physs_registers_wrapper_0_pcs100_sgmii1_reg_sg0_tx_lane_thresh(physs_registers_wrapper_0_pcs100_sgmii1_reg_sg0_tx_lane_thresh), 
    .physs_registers_wrapper_0_pcs100_sgmii1_reg_sg0_sg_tx_lane_ckmult(physs_registers_wrapper_0_pcs100_sgmii1_reg_sg0_sg_tx_lane_ckmult), 
    .physs_registers_wrapper_0_pcs100_sgmii1_reg_sg0_mode_br_dis(physs_registers_wrapper_0_pcs100_sgmii1_reg_sg0_mode_br_dis), 
    .physs_registers_wrapper_0_pcs100_sgmii1_reg_sg0_seq_ena(physs_registers_wrapper_0_pcs100_sgmii1_reg_sg0_seq_ena), 
    .physs_registers_wrapper_0_pcs100_sgmii1_reg_sg0_mode_sync(physs_registers_wrapper_0_pcs100_sgmii1_reg_sg0_mode_sync), 
    .physs_registers_wrapper_0_pcs100_sgmii2_reg_sg0_tx_lane_thresh(physs_registers_wrapper_0_pcs100_sgmii2_reg_sg0_tx_lane_thresh), 
    .physs_registers_wrapper_0_pcs100_sgmii2_reg_sg0_sg_tx_lane_ckmult(physs_registers_wrapper_0_pcs100_sgmii2_reg_sg0_sg_tx_lane_ckmult), 
    .physs_registers_wrapper_0_pcs100_sgmii2_reg_sg0_mode_br_dis(physs_registers_wrapper_0_pcs100_sgmii2_reg_sg0_mode_br_dis), 
    .physs_registers_wrapper_0_pcs100_sgmii2_reg_sg0_seq_ena(physs_registers_wrapper_0_pcs100_sgmii2_reg_sg0_seq_ena), 
    .physs_registers_wrapper_0_pcs100_sgmii2_reg_sg0_mode_sync(physs_registers_wrapper_0_pcs100_sgmii2_reg_sg0_mode_sync), 
    .physs_registers_wrapper_0_pcs100_sgmii3_reg_sg0_tx_lane_thresh(physs_registers_wrapper_0_pcs100_sgmii3_reg_sg0_tx_lane_thresh), 
    .physs_registers_wrapper_0_pcs100_sgmii3_reg_sg0_sg_tx_lane_ckmult(physs_registers_wrapper_0_pcs100_sgmii3_reg_sg0_sg_tx_lane_ckmult), 
    .physs_registers_wrapper_0_pcs100_sgmii3_reg_sg0_mode_br_dis(physs_registers_wrapper_0_pcs100_sgmii3_reg_sg0_mode_br_dis), 
    .physs_registers_wrapper_0_pcs100_sgmii3_reg_sg0_seq_ena(physs_registers_wrapper_0_pcs100_sgmii3_reg_sg0_seq_ena), 
    .physs_registers_wrapper_0_pcs100_sgmii3_reg_sg0_mode_sync(physs_registers_wrapper_0_pcs100_sgmii3_reg_sg0_mode_sync), 
    .quadpcs100_0_pcs_block_lock(quadpcs100_0_pcs_block_lock), 
    .physs_registers_wrapper_0_pcs100_usxgmii0_config_usxgmii0_conf_speed_tx_2_5(physs_registers_wrapper_0_pcs100_usxgmii0_config_usxgmii0_conf_speed_tx_2_5), 
    .physs_registers_wrapper_0_pcs100_usxgmii0_config_usxgmii0_conf_speed_rx_2_5(physs_registers_wrapper_0_pcs100_usxgmii0_config_usxgmii0_conf_speed_rx_2_5), 
    .physs_registers_wrapper_0_pcs100_usxgmii0_config_usxgmii0_conf_speed_tx(physs_registers_wrapper_0_pcs100_usxgmii0_config_usxgmii0_conf_speed_tx), 
    .physs_registers_wrapper_0_pcs100_usxgmii0_config_usxgmii0_conf_speed_rx(physs_registers_wrapper_0_pcs100_usxgmii0_config_usxgmii0_conf_speed_rx), 
    .physs_registers_wrapper_0_pcs100_usxgmii1_config_usxgmii1_conf_speed_tx_2_5(physs_registers_wrapper_0_pcs100_usxgmii1_config_usxgmii1_conf_speed_tx_2_5), 
    .physs_registers_wrapper_0_pcs100_usxgmii1_config_usxgmii1_conf_speed_rx_2_5(physs_registers_wrapper_0_pcs100_usxgmii1_config_usxgmii1_conf_speed_rx_2_5), 
    .physs_registers_wrapper_0_pcs100_usxgmii1_config_usxgmii1_conf_speed_tx(physs_registers_wrapper_0_pcs100_usxgmii1_config_usxgmii1_conf_speed_tx), 
    .physs_registers_wrapper_0_pcs100_usxgmii1_config_usxgmii1_conf_speed_rx(physs_registers_wrapper_0_pcs100_usxgmii1_config_usxgmii1_conf_speed_rx), 
    .physs_registers_wrapper_0_pcs100_usxgmii2_config_usxgmii2_conf_speed_tx_2_5(physs_registers_wrapper_0_pcs100_usxgmii2_config_usxgmii2_conf_speed_tx_2_5), 
    .physs_registers_wrapper_0_pcs100_usxgmii2_config_usxgmii2_conf_speed_rx_2_5(physs_registers_wrapper_0_pcs100_usxgmii2_config_usxgmii2_conf_speed_rx_2_5), 
    .physs_registers_wrapper_0_pcs100_usxgmii2_config_usxgmii2_conf_speed_tx(physs_registers_wrapper_0_pcs100_usxgmii2_config_usxgmii2_conf_speed_tx), 
    .physs_registers_wrapper_0_pcs100_usxgmii2_config_usxgmii2_conf_speed_rx(physs_registers_wrapper_0_pcs100_usxgmii2_config_usxgmii2_conf_speed_rx), 
    .physs_registers_wrapper_0_pcs100_usxgmii3_config_usxgmii3_conf_speed_tx_2_5(physs_registers_wrapper_0_pcs100_usxgmii3_config_usxgmii3_conf_speed_tx_2_5), 
    .physs_registers_wrapper_0_pcs100_usxgmii3_config_usxgmii3_conf_speed_rx_2_5(physs_registers_wrapper_0_pcs100_usxgmii3_config_usxgmii3_conf_speed_rx_2_5), 
    .physs_registers_wrapper_0_pcs100_usxgmii3_config_usxgmii3_conf_speed_tx(physs_registers_wrapper_0_pcs100_usxgmii3_config_usxgmii3_conf_speed_tx), 
    .physs_registers_wrapper_0_pcs100_usxgmii3_config_usxgmii3_conf_speed_rx(physs_registers_wrapper_0_pcs100_usxgmii3_config_usxgmii3_conf_speed_rx), 
    .physs_registers_wrapper_0_pcs100_config0_pcs_sd_n2(physs_registers_wrapper_0_pcs100_config0_pcs_sd_n2), 
    .physs_registers_wrapper_0_pcs100_config0_pcs_sd_n2_0(physs_registers_wrapper_0_pcs100_config0_pcs_sd_n2_0), 
    .physs_registers_wrapper_0_pcs100_config0_pcs_sd_8x(physs_registers_wrapper_0_pcs100_config0_pcs_sd_8x), 
    .physs_registers_wrapper_0_pcs100_config0_pcs_sd_8x_0(physs_registers_wrapper_0_pcs100_config0_pcs_sd_8x_0), 
    .physs_registers_wrapper_0_pcs100_config0_pcs_kp_mode_in(physs_registers_wrapper_0_pcs100_config0_pcs_kp_mode_in), 
    .physs_registers_wrapper_0_pcs100_config0_pcs_kp_mode_in_0(physs_registers_wrapper_0_pcs100_config0_pcs_kp_mode_in_0), 
    .physs_registers_wrapper_0_pcs100_config0_pcs_fec91_100g_ck_ena_in(physs_registers_wrapper_0_pcs100_config0_pcs_fec91_100g_ck_ena_in), 
    .physs_registers_wrapper_0_pcs100_config0_pcs_fec91_100g_ck_ena_in_0(physs_registers_wrapper_0_pcs100_config0_pcs_fec91_100g_ck_ena_in_0), 
    .physs_registers_wrapper_0_pcs100_config0_pcs_sd_100g(physs_registers_wrapper_0_pcs100_config0_pcs_sd_100g), 
    .physs_registers_wrapper_0_pcs100_config0_pcs_sd_100g_0(physs_registers_wrapper_0_pcs100_config0_pcs_sd_100g_0), 
    .physs_registers_wrapper_0_pcs100_config1_pcs_fec91_1lane_in(physs_registers_wrapper_0_pcs100_config1_pcs_fec91_1lane_in), 
    .physs_registers_wrapper_0_pcs100_config1_pcs_fec91_1lane_in_0(physs_registers_wrapper_0_pcs100_config1_pcs_fec91_1lane_in_0), 
    .physs_registers_wrapper_0_pcs100_config1_pcs_fec91_1lane_in_1(physs_registers_wrapper_0_pcs100_config1_pcs_fec91_1lane_in_1), 
    .physs_registers_wrapper_0_pcs100_config1_pcs_fec91_1lane_in_2(physs_registers_wrapper_0_pcs100_config1_pcs_fec91_1lane_in_2), 
    .physs_registers_wrapper_0_pcs100_config1_pcs_fec91_ll_mode_in(physs_registers_wrapper_0_pcs100_config1_pcs_fec91_ll_mode_in), 
    .physs_registers_wrapper_0_pcs100_config1_pcs_fec91_ll_mode_in_0(physs_registers_wrapper_0_pcs100_config1_pcs_fec91_ll_mode_in_0), 
    .physs_registers_wrapper_0_pcs100_config1_pcs_rxlaui_ena_in(physs_registers_wrapper_0_pcs100_config1_pcs_rxlaui_ena_in), 
    .physs_registers_wrapper_0_pcs100_config1_pcs_rxlaui_ena_in_0(physs_registers_wrapper_0_pcs100_config1_pcs_rxlaui_ena_in_0), 
    .physs_registers_wrapper_0_pcs100_config1_pcs_rxlaui_ena_in_1(physs_registers_wrapper_0_pcs100_config1_pcs_rxlaui_ena_in_1), 
    .physs_registers_wrapper_0_pcs100_config1_pcs_rxlaui_ena_in_2(physs_registers_wrapper_0_pcs100_config1_pcs_rxlaui_ena_in_2), 
    .physs_registers_wrapper_0_pcs100_config1_pcs_pcs100_ena_in(physs_registers_wrapper_0_pcs100_config1_pcs_pcs100_ena_in), 
    .physs_registers_wrapper_0_pcs100_config1_pcs_pcs100_ena_in_0(physs_registers_wrapper_0_pcs100_config1_pcs_pcs100_ena_in_0), 
    .physs_registers_wrapper_0_pcs100_config1_pcs_pcs100_ena_in_1(physs_registers_wrapper_0_pcs100_config1_pcs_pcs100_ena_in_1), 
    .physs_registers_wrapper_0_pcs100_config1_pcs_pcs100_ena_in_2(physs_registers_wrapper_0_pcs100_config1_pcs_pcs100_ena_in_2), 
    .physs_registers_wrapper_0_pcs100_config1_pcs_f91_ena_in(physs_registers_wrapper_0_pcs100_config1_pcs_f91_ena_in), 
    .physs_registers_wrapper_0_pcs100_config1_pcs_f91_ena_in_0(physs_registers_wrapper_0_pcs100_config1_pcs_f91_ena_in_0), 
    .physs_registers_wrapper_0_pcs100_config2_pcs_mode40_ena_in(physs_registers_wrapper_0_pcs100_config2_pcs_mode40_ena_in), 
    .physs_registers_wrapper_0_pcs100_config2_pcs_mode40_ena_in_0(physs_registers_wrapper_0_pcs100_config2_pcs_mode40_ena_in_0), 
    .physs_registers_wrapper_0_pcs100_config2_pcs_pacer_10g(physs_registers_wrapper_0_pcs100_config2_pcs_pacer_10g), 
    .physs_registers_wrapper_0_pcs100_config2_pcs_pacer_10g_0(physs_registers_wrapper_0_pcs100_config2_pcs_pacer_10g_0), 
    .physs_registers_wrapper_0_pcs100_config2_pcs_fec_ena(physs_registers_wrapper_0_pcs100_config2_pcs_fec_ena), 
    .physs_registers_wrapper_0_pcs100_config2_pcs_fec_ena_0(physs_registers_wrapper_0_pcs100_config2_pcs_fec_ena_0), 
    .physs_registers_wrapper_0_pcs100_config2_pcs_fec_err_ena(physs_registers_wrapper_0_pcs100_config2_pcs_fec_err_ena), 
    .physs_registers_wrapper_0_pcs100_config2_pcs_fec_err_ena_0(physs_registers_wrapper_0_pcs100_config2_pcs_fec_err_ena_0), 
    .physs_clock_sync_0_physs_func_clk_gated_100(physs_clock_sync_0_physs_func_clk_gated_100), 
    .physs_lane_reversal_mux_0_serdes_tx_clk(physs_lane_reversal_mux_0_serdes_tx_clk), 
    .physs_lane_reversal_mux_0_serdes_rx_clk(physs_lane_reversal_mux_0_serdes_rx_clk), 
    .physs_clock_sync_0_func_rstn_fabric_sync(physs_clock_sync_0_func_rstn_fabric_sync), 
    .soc_per_clk_pdop_parmquad0_clkout(soc_per_clk_pdop_parmquad0_clkout), 
    .physs_clock_sync_0_reset_ref_clk(physs_clock_sync_0_reset_ref_clk), 
    .physs_hd2prf_trim_fuse_in(physs_hd2prf_trim_fuse_in), 
    .physs_hdp2prf_trim_fuse_in(physs_hdp2prf_trim_fuse_in), 
    .physs_func_rst_raw_n(physs_func_rst_raw_n), 
    .physs_clock_sync_0_reset_sd_tx_clk(physs_clock_sync_0_reset_sd_tx_clk), 
    .physs_clock_sync_0_reset_sd_rx_clk(physs_clock_sync_0_reset_sd_rx_clk), 
    .physs_clock_sync_0_reset_xpcs_ref_clk(physs_clock_sync_0_reset_xpcs_ref_clk), 
    .physs_clock_sync_0_reset_f91_ref_clk(physs_clock_sync_0_reset_f91_ref_clk), 
    .physs_clock_sync_0_reset_gpcs0_ref_clk(physs_clock_sync_0_reset_gpcs0_ref_clk), 
    .physs_clock_sync_0_reset_gpcs1_ref_clk(physs_clock_sync_0_reset_gpcs1_ref_clk), 
    .physs_clock_sync_0_reset_gpcs2_ref_clk(physs_clock_sync_0_reset_gpcs2_ref_clk), 
    .physs_clock_sync_0_reset_gpcs3_ref_clk(physs_clock_sync_0_reset_gpcs3_ref_clk), 
    .physs_clock_sync_0_reset_reg_ref_clk(physs_clock_sync_0_reset_reg_ref_clk), 
    .physs_clock_sync_0_reset_reg_clk(physs_clock_sync_0_reset_reg_clk), 
    .physs_clock_sync_0_soc_per_clk_gated_100(physs_clock_sync_0_soc_per_clk_gated_100), 
    .quadpcs100_0_pcs_tsu_rx_sd_3(quadpcs100_0_pcs_tsu_rx_sd_0), 
    .quadpcs100_0_mii_rx_tsu_mux0_0(quadpcs100_0_mii_rx_tsu_mux0_0), 
    .quadpcs100_0_mii_rx_tsu_mux1_0(quadpcs100_0_mii_rx_tsu_mux1_0), 
    .quadpcs100_0_mii_rx_tsu_mux2_0(quadpcs100_0_mii_rx_tsu_mux2_0), 
    .quadpcs100_0_mii_rx_tsu_mux3_0(quadpcs100_0_mii_rx_tsu_mux3_0), 
    .quadpcs100_0_mii_tx_tsu_3(quadpcs100_0_mii_tx_tsu_0), 
    .quadpcs100_0_pcs_desk_buf_rlevel_3(quadpcs100_0_pcs_desk_buf_rlevel_3), 
    .quadpcs100_0_pcs_sd_bit_slip_3(quadpcs100_0_pcs_sd_bit_slip_0), 
    .quadpcs100_0_pcs_link_status_tsu_3(quadpcs100_0_pcs_link_status_tsu_0), 
    .mtiptsu_top_0_mac0_frc_tx_out_dec(mtiptsu_top_0_mac0_frc_tx_out_dec), 
    .mtiptsu_top_0_mac0_frc_tx_out_ns(mtiptsu_top_0_mac0_frc_tx_out_ns), 
    .mtiptsu_top_0_mac0_frc_tx_out_s(mtiptsu_top_0_mac0_frc_tx_out_s), 
    .mtiptsu_top_0_mac0_frc_rx_out_dec(mtiptsu_top_0_mac0_frc_rx_out_dec), 
    .mtiptsu_top_0_mac0_frc_rx_out_ns(mtiptsu_top_0_mac0_frc_rx_out_ns), 
    .mtiptsu_top_0_mac0_frc_rx_out_s(mtiptsu_top_0_mac0_frc_rx_out_s), 
    .mtiptsu_top_0_mac1_frc_tx_out_dec(mtiptsu_top_0_mac1_frc_tx_out_dec), 
    .mtiptsu_top_0_mac1_frc_tx_out_ns(mtiptsu_top_0_mac1_frc_tx_out_ns), 
    .mtiptsu_top_0_mac1_frc_tx_out_s(mtiptsu_top_0_mac1_frc_tx_out_s), 
    .mtiptsu_top_0_mac1_frc_rx_out_dec(mtiptsu_top_0_mac1_frc_rx_out_dec), 
    .mtiptsu_top_0_mac1_frc_rx_out_ns(mtiptsu_top_0_mac1_frc_rx_out_ns), 
    .mtiptsu_top_0_mac1_frc_rx_out_s(mtiptsu_top_0_mac1_frc_rx_out_s), 
    .mtiptsu_top_0_mac2_frc_tx_out_dec(mtiptsu_top_0_mac2_frc_tx_out_dec), 
    .mtiptsu_top_0_mac2_frc_tx_out_ns(mtiptsu_top_0_mac2_frc_tx_out_ns), 
    .mtiptsu_top_0_mac2_frc_tx_out_s(mtiptsu_top_0_mac2_frc_tx_out_s), 
    .mtiptsu_top_0_mac2_frc_rx_out_dec(mtiptsu_top_0_mac2_frc_rx_out_dec), 
    .mtiptsu_top_0_mac2_frc_rx_out_ns(mtiptsu_top_0_mac2_frc_rx_out_ns), 
    .mtiptsu_top_0_mac2_frc_rx_out_s(mtiptsu_top_0_mac2_frc_rx_out_s), 
    .mtiptsu_top_0_mac3_frc_tx_out_dec(mtiptsu_top_0_mac3_frc_tx_out_dec), 
    .mtiptsu_top_0_mac3_frc_tx_out_ns(mtiptsu_top_0_mac3_frc_tx_out_ns), 
    .mtiptsu_top_0_mac3_frc_tx_out_s(mtiptsu_top_0_mac3_frc_tx_out_s), 
    .mtiptsu_top_0_mac3_frc_rx_out_dec(mtiptsu_top_0_mac3_frc_rx_out_dec), 
    .mtiptsu_top_0_mac3_frc_rx_out_ns(mtiptsu_top_0_mac3_frc_rx_out_ns), 
    .mtiptsu_top_0_mac3_frc_rx_out_s(mtiptsu_top_0_mac3_frc_rx_out_s), 
    .physs_timestamp_0_time_cnt_tx(physs_timestamp_0_time_cnt_tx[0][31:25]), 
    .physs_timestamp_0_time_cnt_rx(physs_timestamp_0_time_cnt_rx[0][31:25]), 
    .physs_timestamp_0_time_cnt_tx_0(physs_timestamp_0_time_cnt_tx[1][31:25]), 
    .physs_timestamp_0_time_cnt_rx_0(physs_timestamp_0_time_cnt_rx[1][31:25]), 
    .physs_timestamp_0_time_cnt_tx_1(physs_timestamp_0_time_cnt_tx[2][31:25]), 
    .physs_timestamp_0_time_cnt_rx_1(physs_timestamp_0_time_cnt_rx[2][31:25]), 
    .physs_timestamp_0_time_cnt_tx_2(physs_timestamp_0_time_cnt_tx[3][31:25]), 
    .physs_timestamp_0_time_cnt_rx_2(physs_timestamp_0_time_cnt_rx[3][31:25]), 
    .physs_timestamp_0_time_cnt_tx_3(physs_timestamp_0_time_cnt_tx[0][63:32]), 
    .physs_timestamp_0_time_cnt_rx_3(physs_timestamp_0_time_cnt_rx[0][63:32]), 
    .physs_timestamp_0_time_cnt_tx_4(physs_timestamp_0_time_cnt_tx[1][63:32]), 
    .physs_timestamp_0_time_cnt_rx_4(physs_timestamp_0_time_cnt_rx[1][63:32]), 
    .physs_timestamp_0_time_cnt_tx_5(physs_timestamp_0_time_cnt_tx[2][63:32]), 
    .physs_timestamp_0_time_cnt_rx_5(physs_timestamp_0_time_cnt_rx[2][63:32]), 
    .physs_timestamp_0_time_cnt_tx_6(physs_timestamp_0_time_cnt_tx[3][63:32]), 
    .physs_timestamp_0_time_cnt_rx_6(physs_timestamp_0_time_cnt_rx[3][63:32]), 
    .quadpcs100_0_xlgmii0_txclk_ena_0(quadpcs100_0_xlgmii0_txclk_ena_0), 
    .quadpcs100_0_xlgmii0_rxclk_ena_0(quadpcs100_0_xlgmii0_rxclk_ena_0), 
    .quadpcs100_0_xlgmii0_rxc(quadpcs100_0_xlgmii0_rxc), 
    .quadpcs100_0_xlgmii0_rxd(quadpcs100_0_xlgmii0_rxd), 
    .quadpcs100_0_xlgmii0_rxt0_next(quadpcs100_0_xlgmii0_rxt0_next), 
    .nic_switch_mux_0_pcs_xlgmii0_txc(nic_switch_mux_0_pcs_xlgmii0_txc), 
    .nic_switch_mux_0_pcs_xlgmii0_txd(nic_switch_mux_0_pcs_xlgmii0_txd), 
    .quadpcs100_0_xlgmii1_txclk_ena_0(quadpcs100_0_xlgmii1_txclk_ena_0), 
    .quadpcs100_0_xlgmii1_rxclk_ena_0(quadpcs100_0_xlgmii1_rxclk_ena_0), 
    .quadpcs100_0_xlgmii1_rxc(quadpcs100_0_xlgmii1_rxc), 
    .quadpcs100_0_xlgmii1_rxd(quadpcs100_0_xlgmii1_rxd), 
    .quadpcs100_0_xlgmii1_rxt0_next(quadpcs100_0_xlgmii1_rxt0_next), 
    .nic_switch_mux_0_pcs_xlgmii1_txc(nic_switch_mux_0_pcs_xlgmii1_txc), 
    .nic_switch_mux_0_pcs_xlgmii1_txd(nic_switch_mux_0_pcs_xlgmii1_txd), 
    .quadpcs100_0_xlgmii2_txclk_ena_0(quadpcs100_0_xlgmii2_txclk_ena_0), 
    .quadpcs100_0_xlgmii2_rxclk_ena_0(quadpcs100_0_xlgmii2_rxclk_ena_0), 
    .quadpcs100_0_xlgmii2_rxc(quadpcs100_0_xlgmii2_rxc), 
    .quadpcs100_0_xlgmii2_rxd(quadpcs100_0_xlgmii2_rxd), 
    .quadpcs100_0_xlgmii2_rxt0_next(quadpcs100_0_xlgmii2_rxt0_next), 
    .nic_switch_mux_0_pcs_xlgmii2_txc(nic_switch_mux_0_pcs_xlgmii2_txc), 
    .nic_switch_mux_0_pcs_xlgmii2_txd(nic_switch_mux_0_pcs_xlgmii2_txd), 
    .quadpcs100_0_xlgmii3_txclk_ena_0(quadpcs100_0_xlgmii3_txclk_ena_0), 
    .quadpcs100_0_xlgmii3_rxclk_ena_0(quadpcs100_0_xlgmii3_rxclk_ena_0), 
    .quadpcs100_0_xlgmii3_rxc(quadpcs100_0_xlgmii3_rxc), 
    .quadpcs100_0_xlgmii3_rxd(quadpcs100_0_xlgmii3_rxd), 
    .quadpcs100_0_xlgmii3_rxt0_next(quadpcs100_0_xlgmii3_rxt0_next), 
    .nic_switch_mux_0_pcs_xlgmii3_txc(nic_switch_mux_0_pcs_xlgmii3_txc), 
    .nic_switch_mux_0_pcs_xlgmii3_txd(nic_switch_mux_0_pcs_xlgmii3_txd), 
    .quadpcs100_0_cgmii0_rxd(quadpcs100_0_cgmii0_rxd), 
    .quadpcs100_0_cgmii0_rxc(quadpcs100_0_cgmii0_rxc), 
    .quadpcs100_0_cgmii0_rxclk_ena_0(quadpcs100_0_cgmii0_rxclk_ena_0), 
    .nic_switch_mux_0_pcs_cgmii0_txd(nic_switch_mux_0_pcs_cgmii0_txd), 
    .nic_switch_mux_0_pcs_cgmii0_txc(nic_switch_mux_0_pcs_cgmii0_txc), 
    .quadpcs100_0_cgmii0_txclk_ena_0(quadpcs100_0_cgmii0_txclk_ena_0), 
    .quadpcs100_0_cgmii1_rxd(quadpcs100_0_cgmii1_rxd), 
    .quadpcs100_0_cgmii1_rxc(quadpcs100_0_cgmii1_rxc), 
    .quadpcs100_0_cgmii1_rxclk_ena_0(quadpcs100_0_cgmii1_rxclk_ena_0), 
    .nic_switch_mux_0_pcs_cgmii1_txd(nic_switch_mux_0_pcs_cgmii1_txd), 
    .nic_switch_mux_0_pcs_cgmii1_txc(nic_switch_mux_0_pcs_cgmii1_txc), 
    .quadpcs100_0_cgmii1_txclk_ena_0(quadpcs100_0_cgmii1_txclk_ena_0), 
    .quadpcs100_0_cgmii2_rxd(quadpcs100_0_cgmii2_rxd), 
    .quadpcs100_0_cgmii2_rxc(quadpcs100_0_cgmii2_rxc), 
    .quadpcs100_0_cgmii2_rxclk_ena_0(quadpcs100_0_cgmii2_rxclk_ena_0), 
    .nic_switch_mux_0_pcs_cgmii2_txd(nic_switch_mux_0_pcs_cgmii2_txd), 
    .nic_switch_mux_0_pcs_cgmii2_txc(nic_switch_mux_0_pcs_cgmii2_txc), 
    .quadpcs100_0_cgmii2_txclk_ena_0(quadpcs100_0_cgmii2_txclk_ena_0), 
    .quadpcs100_0_cgmii3_rxd(quadpcs100_0_cgmii3_rxd), 
    .quadpcs100_0_cgmii3_rxc(quadpcs100_0_cgmii3_rxc), 
    .quadpcs100_0_cgmii3_rxclk_ena_0(quadpcs100_0_cgmii3_rxclk_ena_0), 
    .nic_switch_mux_0_pcs_cgmii3_txd(nic_switch_mux_0_pcs_cgmii3_txd), 
    .nic_switch_mux_0_pcs_cgmii3_txc(nic_switch_mux_0_pcs_cgmii3_txc), 
    .quadpcs100_0_cgmii3_txclk_ena_0(quadpcs100_0_cgmii3_txclk_ena_0), 
    .mac100_0_tx_sfd_o(mac100_0_tx_sfd_o), 
    .mac100_0_tx_sfd_shift_o(mac100_0_tx_sfd_shift_o), 
    .mac100_0_rx_sfd_o(mac100_0_rx_sfd_o), 
    .mac100_0_rx_sfd_shift_o(mac100_0_rx_sfd_shift_o), 
    .mac100_1_tx_sfd_o(mac100_1_tx_sfd_o), 
    .mac100_1_tx_sfd_shift_o(mac100_1_tx_sfd_shift_o), 
    .mac100_1_rx_sfd_o(mac100_1_rx_sfd_o), 
    .mac100_1_rx_sfd_shift_o(mac100_1_rx_sfd_shift_o), 
    .mac100_2_tx_sfd_o(mac100_2_tx_sfd_o), 
    .mac100_2_tx_sfd_shift_o(mac100_2_tx_sfd_shift_o), 
    .mac100_2_rx_sfd_o(mac100_2_rx_sfd_o), 
    .mac100_2_rx_sfd_shift_o(mac100_2_rx_sfd_shift_o), 
    .mac100_3_tx_sfd_o(mac100_3_tx_sfd_o), 
    .mac100_3_tx_sfd_shift_o(mac100_3_tx_sfd_shift_o), 
    .mac100_3_rx_sfd_o(mac100_3_rx_sfd_o), 
    .mac100_3_rx_sfd_shift_o(mac100_3_rx_sfd_shift_o), 
    .quadpcs100_0_sd0_tx(quadpcs100_0_sd0_tx), 
    .quadpcs100_0_sd1_tx(quadpcs100_0_sd1_tx), 
    .quadpcs100_0_sd2_tx(quadpcs100_0_sd2_tx), 
    .quadpcs100_0_sd3_tx(quadpcs100_0_sd3_tx), 
    .physs_pcs_mux_0_sd0_rx_data_o({physs_pcs_mux_0_sd0_rx_data_o_0[127:32],physs_pcs_mux_0_sd0_rx_data_o}), 
    .physs_pcs_mux_0_sd1_rx_data_o({physs_pcs_mux_0_sd1_rx_data_o_0[127:32],physs_pcs_mux_0_sd1_rx_data_o}), 
    .physs_pcs_mux_0_sd2_rx_data_o({physs_pcs_mux_0_sd2_rx_data_o_0[127:32],physs_pcs_mux_0_sd2_rx_data_o}), 
    .physs_pcs_mux_0_sd3_rx_data_o({physs_pcs_mux_0_sd3_rx_data_o_0[127:32],physs_pcs_mux_0_sd3_rx_data_o}), 
    .physs_pcs_mux_0_srds_rdy_out_100G(physs_pcs_mux_0_srds_rdy_out_100G), 
    .physs_pcs_mux_0_sd_tx_clk_100G(physs_pcs_mux_0_sd_tx_clk_100G), 
    .physs_pcs_mux_0_sd_rx_clk_100G(physs_pcs_mux_0_sd_rx_clk_100G), 
    .DW_ahb_0_haddr_s17(DW_ahb_0_haddr_s17), 
    .DW_ahb_0_hsize_0(DW_ahb_0_hsize_0), 
    .DW_ahb_0_htrans_0(DW_ahb_0_htrans_0), 
    .DW_ahb_0_hwdata_0(DW_ahb_0_hwdata_0), 
    .DW_ahb_0_hwrite_0(DW_ahb_0_hwrite_0), 
    .ptp_mem_bridge_0_hreadyout(ptp_mem_bridge_0_hreadyout), 
    .ptp_mem_bridge_0_hresp(ptp_mem_bridge_0_hresp), 
    .ptp_mem_bridge_0_hrdata(ptp_mem_bridge_0_hrdata), 
    .DW_ahb_0_hsel_s17(DW_ahb_0_hsel_s17)
) ; 
mac100_wrap mac100_wrap (
    .nic400_quad_0_hselx_mac100_0(nic400_quad_0_hselx_mac100_0), 
    .nic400_quad_0_haddr_mac100_0_out(nic400_quad_0_haddr_mac100_0_out), 
    .nic400_quad_0_htrans_mac100_0(nic400_quad_0_htrans_mac100_0), 
    .nic400_quad_0_hwrite_mac100_0(nic400_quad_0_hwrite_mac100_0), 
    .nic400_quad_0_hsize_mac100_0(nic400_quad_0_hsize_mac100_0), 
    .nic400_quad_0_hwdata_mac100_0(nic400_quad_0_hwdata_mac100_0), 
    .nic400_quad_0_hready_mac100_0(nic400_quad_0_hready_mac100_0), 
    .mac100_ahb_bridge_0_hrdata(mac100_ahb_bridge_0_hrdata), 
    .mac100_ahb_bridge_0_hresp(mac100_ahb_bridge_0_hresp), 
    .mac100_ahb_bridge_0_hreadyout(mac100_ahb_bridge_0_hreadyout), 
    .nic400_quad_0_hselx_mac100_1(nic400_quad_0_hselx_mac100_1), 
    .nic400_quad_0_haddr_mac100_1_out(nic400_quad_0_haddr_mac100_1_out), 
    .nic400_quad_0_htrans_mac100_1(nic400_quad_0_htrans_mac100_1), 
    .nic400_quad_0_hwrite_mac100_1(nic400_quad_0_hwrite_mac100_1), 
    .nic400_quad_0_hsize_mac100_1(nic400_quad_0_hsize_mac100_1), 
    .nic400_quad_0_hwdata_mac100_1(nic400_quad_0_hwdata_mac100_1), 
    .nic400_quad_0_hready_mac100_1(nic400_quad_0_hready_mac100_1), 
    .mac100_ahb_bridge_1_hrdata(mac100_ahb_bridge_1_hrdata), 
    .mac100_ahb_bridge_1_hresp(mac100_ahb_bridge_1_hresp), 
    .mac100_ahb_bridge_1_hreadyout(mac100_ahb_bridge_1_hreadyout), 
    .nic400_quad_0_hselx_mac100_2(nic400_quad_0_hselx_mac100_2), 
    .nic400_quad_0_haddr_mac100_2_out(nic400_quad_0_haddr_mac100_2_out), 
    .nic400_quad_0_htrans_mac100_2(nic400_quad_0_htrans_mac100_2), 
    .nic400_quad_0_hwrite_mac100_2(nic400_quad_0_hwrite_mac100_2), 
    .nic400_quad_0_hsize_mac100_2(nic400_quad_0_hsize_mac100_2), 
    .nic400_quad_0_hwdata_mac100_2(nic400_quad_0_hwdata_mac100_2), 
    .nic400_quad_0_hready_mac100_2(nic400_quad_0_hready_mac100_2), 
    .mac100_ahb_bridge_2_hrdata(mac100_ahb_bridge_2_hrdata), 
    .mac100_ahb_bridge_2_hresp(mac100_ahb_bridge_2_hresp), 
    .mac100_ahb_bridge_2_hreadyout(mac100_ahb_bridge_2_hreadyout), 
    .nic400_quad_0_hselx_mac100_3(nic400_quad_0_hselx_mac100_3), 
    .nic400_quad_0_haddr_mac100_3_out(nic400_quad_0_haddr_mac100_3_out), 
    .nic400_quad_0_htrans_mac100_3(nic400_quad_0_htrans_mac100_3), 
    .nic400_quad_0_hwrite_mac100_3(nic400_quad_0_hwrite_mac100_3), 
    .nic400_quad_0_hsize_mac100_3(nic400_quad_0_hsize_mac100_3), 
    .nic400_quad_0_hwdata_mac100_3(nic400_quad_0_hwdata_mac100_3), 
    .nic400_quad_0_hready_mac100_3(nic400_quad_0_hready_mac100_3), 
    .mac100_ahb_bridge_3_hrdata(mac100_ahb_bridge_3_hrdata), 
    .mac100_ahb_bridge_3_hresp(mac100_ahb_bridge_3_hresp), 
    .mac100_ahb_bridge_3_hreadyout(mac100_ahb_bridge_3_hreadyout), 
    .nic400_quad_0_hselx_mac100_stats_0(nic400_quad_0_hselx_mac100_stats_0), 
    .nic400_quad_0_haddr_mac100_stats_0_out(nic400_quad_0_haddr_mac100_stats_0_out), 
    .nic400_quad_0_htrans_mac100_stats_0(nic400_quad_0_htrans_mac100_stats_0), 
    .nic400_quad_0_hwrite_mac100_stats_0(nic400_quad_0_hwrite_mac100_stats_0), 
    .nic400_quad_0_hsize_mac100_stats_0(nic400_quad_0_hsize_mac100_stats_0), 
    .nic400_quad_0_hwdata_mac100_stats_0(nic400_quad_0_hwdata_mac100_stats_0), 
    .nic400_quad_0_hready_mac100_stats_0(nic400_quad_0_hready_mac100_stats_0), 
    .macstats_ahb_bridge_0_hrdata(macstats_ahb_bridge_0_hrdata), 
    .macstats_ahb_bridge_0_hresp(macstats_ahb_bridge_0_hresp), 
    .macstats_ahb_bridge_0_hreadyout(macstats_ahb_bridge_0_hreadyout), 
    .nic400_quad_0_hselx_mac100_stats_1(nic400_quad_0_hselx_mac100_stats_1), 
    .nic400_quad_0_haddr_mac100_stats_1_out(nic400_quad_0_haddr_mac100_stats_1_out), 
    .nic400_quad_0_htrans_mac100_stats_1(nic400_quad_0_htrans_mac100_stats_1), 
    .nic400_quad_0_hwrite_mac100_stats_1(nic400_quad_0_hwrite_mac100_stats_1), 
    .nic400_quad_0_hsize_mac100_stats_1(nic400_quad_0_hsize_mac100_stats_1), 
    .nic400_quad_0_hwdata_mac100_stats_1(nic400_quad_0_hwdata_mac100_stats_1), 
    .nic400_quad_0_hready_mac100_stats_1(nic400_quad_0_hready_mac100_stats_1), 
    .macstats_ahb_bridge_1_hrdata(macstats_ahb_bridge_1_hrdata), 
    .macstats_ahb_bridge_1_hresp(macstats_ahb_bridge_1_hresp), 
    .macstats_ahb_bridge_1_hreadyout(macstats_ahb_bridge_1_hreadyout), 
    .nic400_quad_0_hselx_mac100_stats_2(nic400_quad_0_hselx_mac100_stats_2), 
    .nic400_quad_0_haddr_mac100_stats_2_out(nic400_quad_0_haddr_mac100_stats_2_out), 
    .nic400_quad_0_htrans_mac100_stats_2(nic400_quad_0_htrans_mac100_stats_2), 
    .nic400_quad_0_hwrite_mac100_stats_2(nic400_quad_0_hwrite_mac100_stats_2), 
    .nic400_quad_0_hsize_mac100_stats_2(nic400_quad_0_hsize_mac100_stats_2), 
    .nic400_quad_0_hwdata_mac100_stats_2(nic400_quad_0_hwdata_mac100_stats_2), 
    .nic400_quad_0_hready_mac100_stats_2(nic400_quad_0_hready_mac100_stats_2), 
    .macstats_ahb_bridge_2_hrdata(macstats_ahb_bridge_2_hrdata), 
    .macstats_ahb_bridge_2_hresp(macstats_ahb_bridge_2_hresp), 
    .macstats_ahb_bridge_2_hreadyout(macstats_ahb_bridge_2_hreadyout), 
    .nic400_quad_0_hselx_mac100_stats_3(nic400_quad_0_hselx_mac100_stats_3), 
    .nic400_quad_0_haddr_mac100_stats_3_out(nic400_quad_0_haddr_mac100_stats_3_out), 
    .nic400_quad_0_htrans_mac100_stats_3(nic400_quad_0_htrans_mac100_stats_3), 
    .nic400_quad_0_hwrite_mac100_stats_3(nic400_quad_0_hwrite_mac100_stats_3), 
    .nic400_quad_0_hsize_mac100_stats_3(nic400_quad_0_hsize_mac100_stats_3), 
    .nic400_quad_0_hwdata_mac100_stats_3(nic400_quad_0_hwdata_mac100_stats_3), 
    .nic400_quad_0_hready_mac100_stats_3(nic400_quad_0_hready_mac100_stats_3), 
    .macstats_ahb_bridge_3_hrdata(macstats_ahb_bridge_3_hrdata), 
    .macstats_ahb_bridge_3_hresp(macstats_ahb_bridge_3_hresp), 
    .macstats_ahb_bridge_3_hreadyout(macstats_ahb_bridge_3_hreadyout), 
    .mac100_0_ff_rx_err_stat(mac100_0_ff_rx_err_stat), 
    .mac100_1_ff_rx_err_stat(mac100_1_ff_rx_err_stat), 
    .mac100_2_ff_rx_err_stat(mac100_2_ff_rx_err_stat), 
    .mac100_3_ff_rx_err_stat(mac100_3_ff_rx_err_stat), 
    .mac100_0_ff_rx_err(mac100_0_ff_rx_err), 
    .mac100_1_ff_rx_err(mac100_1_ff_rx_err), 
    .mac100_2_ff_rx_err(mac100_2_ff_rx_err), 
    .mac100_3_ff_rx_err(mac100_3_ff_rx_err), 
    .mac100_0_mdio_oen(mac100_0_mdio_oen), 
    .mac100_1_mdio_oen(mac100_1_mdio_oen), 
    .mac100_2_mdio_oen(mac100_2_mdio_oen), 
    .mac100_3_mdio_oen(mac100_3_mdio_oen), 
    .mac100_0_pause_on(mac100_0_pause_on), 
    .mac100_1_pause_on(mac100_1_pause_on), 
    .mac100_2_pause_on(mac100_2_pause_on), 
    .mac100_3_pause_on(mac100_3_pause_on), 
    .mac100_0_li_fault(mac100_0_li_fault), 
    .mac100_1_li_fault(mac100_1_li_fault), 
    .mac100_2_li_fault(mac100_2_li_fault), 
    .mac100_3_li_fault(mac100_3_li_fault), 
    .mac100_0_rem_fault(mac100_0_rem_fault), 
    .mac100_1_rem_fault(mac100_1_rem_fault), 
    .mac100_2_rem_fault(mac100_2_rem_fault), 
    .mac100_3_rem_fault(mac100_3_rem_fault), 
    .mac100_0_loc_fault(mac100_0_loc_fault), 
    .mac100_1_loc_fault(mac100_1_loc_fault), 
    .mac100_2_loc_fault(mac100_2_loc_fault), 
    .mac100_3_loc_fault(mac100_3_loc_fault), 
    .mac100_0_tx_empty(mac100_0_tx_empty), 
    .mac100_1_tx_empty(mac100_1_tx_empty), 
    .mac100_2_tx_empty(mac100_2_tx_empty), 
    .mac100_3_tx_empty(mac100_3_tx_empty), 
    .mac100_0_ff_rx_empty(mac100_0_ff_rx_empty), 
    .mac100_1_ff_rx_empty(mac100_1_ff_rx_empty), 
    .mac100_2_ff_rx_empty(mac100_2_ff_rx_empty), 
    .mac100_3_ff_rx_empty(mac100_3_ff_rx_empty), 
    .mac100_0_tx_isidle(mac100_0_tx_isidle), 
    .mac100_1_tx_isidle(mac100_1_tx_isidle), 
    .mac100_2_tx_isidle(mac100_2_tx_isidle), 
    .mac100_3_tx_isidle(mac100_3_tx_isidle), 
    .mac100_0_ff_tx_septy(mac100_0_ff_tx_septy), 
    .mac100_1_ff_tx_septy(mac100_1_ff_tx_septy), 
    .mac100_2_ff_tx_septy(mac100_2_ff_tx_septy), 
    .mac100_3_ff_tx_septy(mac100_3_ff_tx_septy), 
    .mac100_0_tx_underflow(mac100_0_tx_underflow), 
    .mac100_1_tx_underflow(mac100_1_tx_underflow), 
    .mac100_2_tx_underflow(mac100_2_tx_underflow), 
    .mac100_3_tx_underflow(mac100_3_tx_underflow), 
    .mac100_0_ff_tx_ovr(mac100_0_ff_tx_ovr), 
    .mac100_1_ff_tx_ovr(mac100_1_ff_tx_ovr), 
    .mac100_2_ff_tx_ovr(mac100_2_ff_tx_ovr), 
    .mac100_3_ff_tx_ovr(mac100_3_ff_tx_ovr), 
    .mac100_0_magic_ind(mac100_0_magic_ind), 
    .mac100_1_magic_ind(mac100_1_magic_ind), 
    .mac100_2_magic_ind(mac100_2_magic_ind), 
    .mac100_3_magic_ind(mac100_3_magic_ind), 
    .physs_registers_wrapper_0_mac100_config_0_cfg_write64(physs_registers_wrapper_0_mac100_config_0_cfg_write64), 
    .physs_registers_wrapper_0_mac100_config_0_cfg_mode128(physs_registers_wrapper_0_mac100_config_0_cfg_mode128), 
    .physs_registers_wrapper_0_mac100_config_1_cfg_write64(physs_registers_wrapper_0_mac100_config_1_cfg_write64), 
    .physs_registers_wrapper_0_mac100_config_1_cfg_mode128(physs_registers_wrapper_0_mac100_config_1_cfg_mode128), 
    .physs_registers_wrapper_0_mac100_config_2_cfg_write64(physs_registers_wrapper_0_mac100_config_2_cfg_write64), 
    .physs_registers_wrapper_0_mac100_config_2_cfg_mode128(physs_registers_wrapper_0_mac100_config_2_cfg_mode128), 
    .physs_registers_wrapper_0_mac100_config_3_cfg_write64(physs_registers_wrapper_0_mac100_config_3_cfg_write64), 
    .physs_registers_wrapper_0_mac100_config_3_cfg_mode128(physs_registers_wrapper_0_mac100_config_3_cfg_mode128), 
    .physs_clock_sync_0_physs_func_clk_gated_100(physs_clock_sync_0_physs_func_clk_gated_100), 
    .physs_clock_sync_0_soc_per_clk_gated_100(physs_clock_sync_0_soc_per_clk_gated_100), 
    .physs_clock_sync_0_reset_reg_clk_mac(physs_clock_sync_0_reset_reg_clk_mac), 
    .physs_clock_sync_0_reset_reg_clk_mac_0(physs_clock_sync_0_reset_reg_clk_mac_0), 
    .physs_clock_sync_0_reset_reg_clk_mac_1(physs_clock_sync_0_reset_reg_clk_mac_1), 
    .physs_clock_sync_0_reset_reg_clk_mac_2(physs_clock_sync_0_reset_reg_clk_mac_2), 
    .physs_clock_sync_0_reset_rxclk(physs_clock_sync_0_reset_rxclk), 
    .physs_clock_sync_0_reset_rxclk_0(physs_clock_sync_0_reset_rxclk_0), 
    .physs_clock_sync_0_reset_rxclk_1(physs_clock_sync_0_reset_rxclk_1), 
    .physs_clock_sync_0_reset_rxclk_2(physs_clock_sync_0_reset_rxclk_2), 
    .soc_per_clk_pdop_parmquad0_clkout(soc_per_clk_pdop_parmquad0_clkout), 
    .physs_clock_sync_0_func_rstn_fabric_sync(physs_clock_sync_0_func_rstn_fabric_sync), 
    .hlp_mac_rx_throttle_0_stop(hlp_mac_rx_throttle_0_stop), 
    .hlp_mac_rx_throttle_1_stop(hlp_mac_rx_throttle_1_stop), 
    .hlp_mac_rx_throttle_2_stop(hlp_mac_rx_throttle_2_stop), 
    .hlp_mac_rx_throttle_3_stop(hlp_mac_rx_throttle_3_stop), 
    .tx_stop_0_in(tx_stop_0_in), 
    .tx_stop_1_in(tx_stop_1_in), 
    .tx_stop_2_in(tx_stop_2_in), 
    .tx_stop_3_in(tx_stop_3_in), 
    .physs_hd2prf_trim_fuse_in(physs_hd2prf_trim_fuse_in), 
    .physs_hdp2prf_trim_fuse_in(physs_hdp2prf_trim_fuse_in), 
    .physs_func_rst_raw_n(physs_func_rst_raw_n), 
    .mac100_0_pfc_mode(mac100_0_pfc_mode), 
    .mac100_1_pfc_mode(mac100_1_pfc_mode), 
    .mac100_2_pfc_mode(mac100_2_pfc_mode), 
    .mac100_3_pfc_mode(mac100_3_pfc_mode), 
    .icq_physs_net_xoff(icq_physs_net_xoff), 
    .icq_physs_net_xoff_0(icq_physs_net_xoff_0), 
    .icq_physs_net_xoff_1(icq_physs_net_xoff_1), 
    .icq_physs_net_xoff_2(icq_physs_net_xoff_2), 
    .mtiptsu_top_0_mac0_frc_tx_out_dec(mtiptsu_top_0_mac0_frc_tx_out_dec), 
    .mtiptsu_top_0_mac0_frc_tx_out_ns(mtiptsu_top_0_mac0_frc_tx_out_ns), 
    .mtiptsu_top_0_mac0_frc_tx_out_s(mtiptsu_top_0_mac0_frc_tx_out_s), 
    .mtiptsu_top_0_mac0_frc_rx_out_dec(mtiptsu_top_0_mac0_frc_rx_out_dec), 
    .mtiptsu_top_0_mac0_frc_rx_out_ns(mtiptsu_top_0_mac0_frc_rx_out_ns), 
    .mtiptsu_top_0_mac0_frc_rx_out_s(mtiptsu_top_0_mac0_frc_rx_out_s), 
    .mtiptsu_top_0_mac1_frc_tx_out_dec(mtiptsu_top_0_mac1_frc_tx_out_dec), 
    .mtiptsu_top_0_mac1_frc_tx_out_ns(mtiptsu_top_0_mac1_frc_tx_out_ns), 
    .mtiptsu_top_0_mac1_frc_tx_out_s(mtiptsu_top_0_mac1_frc_tx_out_s), 
    .mtiptsu_top_0_mac1_frc_rx_out_dec(mtiptsu_top_0_mac1_frc_rx_out_dec), 
    .mtiptsu_top_0_mac1_frc_rx_out_ns(mtiptsu_top_0_mac1_frc_rx_out_ns), 
    .mtiptsu_top_0_mac1_frc_rx_out_s(mtiptsu_top_0_mac1_frc_rx_out_s), 
    .mtiptsu_top_0_mac2_frc_tx_out_dec(mtiptsu_top_0_mac2_frc_tx_out_dec), 
    .mtiptsu_top_0_mac2_frc_tx_out_ns(mtiptsu_top_0_mac2_frc_tx_out_ns), 
    .mtiptsu_top_0_mac2_frc_tx_out_s(mtiptsu_top_0_mac2_frc_tx_out_s), 
    .mtiptsu_top_0_mac2_frc_rx_out_dec(mtiptsu_top_0_mac2_frc_rx_out_dec), 
    .mtiptsu_top_0_mac2_frc_rx_out_ns(mtiptsu_top_0_mac2_frc_rx_out_ns), 
    .mtiptsu_top_0_mac2_frc_rx_out_s(mtiptsu_top_0_mac2_frc_rx_out_s), 
    .mtiptsu_top_0_mac3_frc_tx_out_dec(mtiptsu_top_0_mac3_frc_tx_out_dec), 
    .mtiptsu_top_0_mac3_frc_tx_out_ns(mtiptsu_top_0_mac3_frc_tx_out_ns), 
    .mtiptsu_top_0_mac3_frc_tx_out_s(mtiptsu_top_0_mac3_frc_tx_out_s), 
    .mtiptsu_top_0_mac3_frc_rx_out_dec(mtiptsu_top_0_mac3_frc_rx_out_dec), 
    .mtiptsu_top_0_mac3_frc_rx_out_ns(mtiptsu_top_0_mac3_frc_rx_out_ns), 
    .mtiptsu_top_0_mac3_frc_rx_out_s(mtiptsu_top_0_mac3_frc_rx_out_s), 
    .nic_switch_mux_0_mac_xlgmii0_txclk_ena(nic_switch_mux_0_mac_xlgmii0_txclk_ena), 
    .nic_switch_mux_0_mac_xlgmii0_rxclk_ena(nic_switch_mux_0_mac_xlgmii0_rxclk_ena), 
    .nic_switch_mux_0_mac_xlgmii0_rxc(nic_switch_mux_0_mac_xlgmii0_rxc), 
    .nic_switch_mux_0_mac_xlgmii0_rxd(nic_switch_mux_0_mac_xlgmii0_rxd), 
    .nic_switch_mux_0_mac_xlgmii0_rxt0_next(nic_switch_mux_0_mac_xlgmii0_rxt0_next), 
    .mac100_0_xlgmii_txc(mac100_0_xlgmii_txc), 
    .mac100_0_xlgmii_txd(mac100_0_xlgmii_txd), 
    .nic_switch_mux_0_mac_xlgmii1_txclk_ena(nic_switch_mux_0_mac_xlgmii1_txclk_ena), 
    .nic_switch_mux_0_mac_xlgmii1_rxclk_ena(nic_switch_mux_0_mac_xlgmii1_rxclk_ena), 
    .nic_switch_mux_0_mac_xlgmii1_rxc(nic_switch_mux_0_mac_xlgmii1_rxc), 
    .nic_switch_mux_0_mac_xlgmii1_rxd(nic_switch_mux_0_mac_xlgmii1_rxd), 
    .nic_switch_mux_0_mac_xlgmii1_rxt0_next(nic_switch_mux_0_mac_xlgmii1_rxt0_next), 
    .mac100_1_xlgmii_txc(mac100_1_xlgmii_txc), 
    .mac100_1_xlgmii_txd(mac100_1_xlgmii_txd), 
    .nic_switch_mux_0_mac_xlgmii2_txclk_ena(nic_switch_mux_0_mac_xlgmii2_txclk_ena), 
    .nic_switch_mux_0_mac_xlgmii2_rxclk_ena(nic_switch_mux_0_mac_xlgmii2_rxclk_ena), 
    .nic_switch_mux_0_mac_xlgmii2_rxc(nic_switch_mux_0_mac_xlgmii2_rxc), 
    .nic_switch_mux_0_mac_xlgmii2_rxd(nic_switch_mux_0_mac_xlgmii2_rxd), 
    .nic_switch_mux_0_mac_xlgmii2_rxt0_next(nic_switch_mux_0_mac_xlgmii2_rxt0_next), 
    .mac100_2_xlgmii_txc(mac100_2_xlgmii_txc), 
    .mac100_2_xlgmii_txd(mac100_2_xlgmii_txd), 
    .nic_switch_mux_0_mac_xlgmii3_txclk_ena(nic_switch_mux_0_mac_xlgmii3_txclk_ena), 
    .nic_switch_mux_0_mac_xlgmii3_rxclk_ena(nic_switch_mux_0_mac_xlgmii3_rxclk_ena), 
    .nic_switch_mux_0_mac_xlgmii3_rxc(nic_switch_mux_0_mac_xlgmii3_rxc), 
    .nic_switch_mux_0_mac_xlgmii3_rxd(nic_switch_mux_0_mac_xlgmii3_rxd), 
    .nic_switch_mux_0_mac_xlgmii3_rxt0_next(nic_switch_mux_0_mac_xlgmii3_rxt0_next), 
    .mac100_3_xlgmii_txc(mac100_3_xlgmii_txc), 
    .mac100_3_xlgmii_txd(mac100_3_xlgmii_txd), 
    .nic_switch_mux_0_mac_cgmii0_rxd(nic_switch_mux_0_mac_cgmii0_rxd), 
    .nic_switch_mux_0_mac_cgmii0_rxc(nic_switch_mux_0_mac_cgmii0_rxc), 
    .nic_switch_mux_0_mac_cgmii0_rxclk_ena(nic_switch_mux_0_mac_cgmii0_rxclk_ena), 
    .mac100_0_cgmii_txd(mac100_0_cgmii_txd), 
    .mac100_0_cgmii_txc(mac100_0_cgmii_txc), 
    .nic_switch_mux_0_mac_cgmii0_txclk_ena(nic_switch_mux_0_mac_cgmii0_txclk_ena), 
    .nic_switch_mux_0_mac_cgmii1_rxd(nic_switch_mux_0_mac_cgmii1_rxd), 
    .nic_switch_mux_0_mac_cgmii1_rxc(nic_switch_mux_0_mac_cgmii1_rxc), 
    .nic_switch_mux_0_mac_cgmii1_rxclk_ena(nic_switch_mux_0_mac_cgmii1_rxclk_ena), 
    .mac100_1_cgmii_txd(mac100_1_cgmii_txd), 
    .mac100_1_cgmii_txc(mac100_1_cgmii_txc), 
    .nic_switch_mux_0_mac_cgmii1_txclk_ena(nic_switch_mux_0_mac_cgmii1_txclk_ena), 
    .nic_switch_mux_0_mac_cgmii2_rxd(nic_switch_mux_0_mac_cgmii2_rxd), 
    .nic_switch_mux_0_mac_cgmii2_rxc(nic_switch_mux_0_mac_cgmii2_rxc), 
    .nic_switch_mux_0_mac_cgmii2_rxclk_ena(nic_switch_mux_0_mac_cgmii2_rxclk_ena), 
    .mac100_2_cgmii_txd(mac100_2_cgmii_txd), 
    .mac100_2_cgmii_txc(mac100_2_cgmii_txc), 
    .nic_switch_mux_0_mac_cgmii2_txclk_ena(nic_switch_mux_0_mac_cgmii2_txclk_ena), 
    .nic_switch_mux_0_mac_cgmii3_rxd(nic_switch_mux_0_mac_cgmii3_rxd), 
    .nic_switch_mux_0_mac_cgmii3_rxc(nic_switch_mux_0_mac_cgmii3_rxc), 
    .nic_switch_mux_0_mac_cgmii3_rxclk_ena(nic_switch_mux_0_mac_cgmii3_rxclk_ena), 
    .mac100_3_cgmii_txd(mac100_3_cgmii_txd), 
    .mac100_3_cgmii_txc(mac100_3_cgmii_txc), 
    .nic_switch_mux_0_mac_cgmii3_txclk_ena(nic_switch_mux_0_mac_cgmii3_txclk_ena), 
    .mac100_0_tx_sfd_o(mac100_0_tx_sfd_o), 
    .mac100_0_tx_sfd_shift_o(mac100_0_tx_sfd_shift_o), 
    .mac100_0_rx_sfd_o(mac100_0_rx_sfd_o), 
    .mac100_0_rx_sfd_shift_o(mac100_0_rx_sfd_shift_o), 
    .mac100_0_tx_ts_val(mac100_0_tx_ts_val), 
    .mac100_0_tx_ts_id(mac100_0_tx_ts_id), 
    .mac100_0_tx_ts(mac100_0_tx_ts), 
    .mac100_1_tx_sfd_o(mac100_1_tx_sfd_o), 
    .mac100_1_tx_sfd_shift_o(mac100_1_tx_sfd_shift_o), 
    .mac100_1_rx_sfd_o(mac100_1_rx_sfd_o), 
    .mac100_1_rx_sfd_shift_o(mac100_1_rx_sfd_shift_o), 
    .mac100_1_tx_ts_val(mac100_1_tx_ts_val), 
    .mac100_1_tx_ts_id(mac100_1_tx_ts_id), 
    .mac100_1_tx_ts(mac100_1_tx_ts), 
    .mac100_2_tx_sfd_o(mac100_2_tx_sfd_o), 
    .mac100_2_tx_sfd_shift_o(mac100_2_tx_sfd_shift_o), 
    .mac100_2_rx_sfd_o(mac100_2_rx_sfd_o), 
    .mac100_2_rx_sfd_shift_o(mac100_2_rx_sfd_shift_o), 
    .mac100_2_tx_ts_val(mac100_2_tx_ts_val), 
    .mac100_2_tx_ts_id(mac100_2_tx_ts_id), 
    .mac100_2_tx_ts(mac100_2_tx_ts), 
    .mac100_3_tx_sfd_o(mac100_3_tx_sfd_o), 
    .mac100_3_tx_sfd_shift_o(mac100_3_tx_sfd_shift_o), 
    .mac100_3_rx_sfd_o(mac100_3_rx_sfd_o), 
    .mac100_3_rx_sfd_shift_o(mac100_3_rx_sfd_shift_o), 
    .mac100_3_tx_ts_val(mac100_3_tx_ts_val), 
    .mac100_3_tx_ts_id(mac100_3_tx_ts_id), 
    .mac100_3_tx_ts(mac100_3_tx_ts), 
    .nic_switch_mux_0_mac_ff_tx_ts_frm_0(nic_switch_mux_0_mac_ff_tx_ts_frm_0), 
    .nic_switch_mux_0_mac_ff_tx_preamble_0(nic_switch_mux_0_mac_ff_tx_preamble_0), 
    .nic_switch_mux_0_mac_ff_tx_id_0(nic_switch_mux_0_mac_ff_tx_id_0), 
    .nic_switch_mux_0_mac_ff_tx_ts_frm_1(nic_switch_mux_0_mac_ff_tx_ts_frm_1), 
    .nic_switch_mux_0_mac_ff_tx_preamble_1(nic_switch_mux_0_mac_ff_tx_preamble_1), 
    .nic_switch_mux_0_mac_ff_tx_id_1(nic_switch_mux_0_mac_ff_tx_id_1), 
    .nic_switch_mux_0_mac_ff_tx_ts_frm_2(nic_switch_mux_0_mac_ff_tx_ts_frm_2), 
    .nic_switch_mux_0_mac_ff_tx_preamble_2(nic_switch_mux_0_mac_ff_tx_preamble_2), 
    .nic_switch_mux_0_mac_ff_tx_id_2(nic_switch_mux_0_mac_ff_tx_id_2), 
    .nic_switch_mux_0_mac_ff_tx_ts_frm_3(nic_switch_mux_0_mac_ff_tx_ts_frm_3), 
    .nic_switch_mux_0_mac_ff_tx_preamble_3(nic_switch_mux_0_mac_ff_tx_preamble_3), 
    .nic_switch_mux_0_mac_ff_tx_id_3(nic_switch_mux_0_mac_ff_tx_id_3), 
    .mac100_0_ff_rx_dval_0(mac100_0_ff_rx_dval_0), 
    .mac100_0_ff_rx_data(mac100_0_ff_rx_data), 
    .mac100_0_ff_rx_sop(mac100_0_ff_rx_sop), 
    .mac100_0_ff_rx_eop_0(mac100_0_ff_rx_eop_0), 
    .mac100_0_ff_rx_mod_0(mac100_0_ff_rx_mod_0), 
    .fifo_mux_0_mac100g_0_rx_rdy(fifo_mux_0_mac100g_0_rx_rdy), 
    .mac100_0_ff_rx_ts(mac100_0_ff_rx_ts), 
    .mac100_0_ff_rx_ts_0(mac100_0_ff_rx_ts_0), 
    .fifo_mux_0_mac100g_0_tx_wren(fifo_mux_0_mac100g_0_tx_wren), 
    .fifo_mux_0_mac100g_0_tx_data(fifo_mux_0_mac100g_0_tx_data), 
    .fifo_mux_0_mac100g_0_tx_sop(fifo_mux_0_mac100g_0_tx_sop), 
    .fifo_mux_0_mac100g_0_tx_eop(fifo_mux_0_mac100g_0_tx_eop), 
    .fifo_mux_0_mac100g_0_tx_mod(fifo_mux_0_mac100g_0_tx_mod), 
    .fifo_mux_0_mac100g_0_tx_err(fifo_mux_0_mac100g_0_tx_err), 
    .fifo_mux_0_mac100g_0_tx_crc(fifo_mux_0_mac100g_0_tx_crc), 
    .mac100_0_ff_tx_rdy_0(mac100_0_ff_tx_rdy_0), 
    .mac100_1_ff_rx_dval_0(mac100_1_ff_rx_dval_0), 
    .mac100_1_ff_rx_data(mac100_1_ff_rx_data), 
    .mac100_1_ff_rx_sop(mac100_1_ff_rx_sop), 
    .mac100_1_ff_rx_eop_0(mac100_1_ff_rx_eop_0), 
    .mac100_1_ff_rx_mod_0(mac100_1_ff_rx_mod_0), 
    .fifo_mux_0_mac100g_1_rx_rdy(fifo_mux_0_mac100g_1_rx_rdy), 
    .mac100_1_ff_rx_ts(mac100_1_ff_rx_ts), 
    .mac100_1_ff_rx_ts_0(mac100_1_ff_rx_ts_0), 
    .fifo_mux_0_mac100g_1_tx_wren(fifo_mux_0_mac100g_1_tx_wren), 
    .fifo_mux_0_mac100g_1_tx_data(fifo_mux_0_mac100g_1_tx_data), 
    .fifo_mux_0_mac100g_1_tx_sop(fifo_mux_0_mac100g_1_tx_sop), 
    .fifo_mux_0_mac100g_1_tx_eop(fifo_mux_0_mac100g_1_tx_eop), 
    .fifo_mux_0_mac100g_1_tx_mod(fifo_mux_0_mac100g_1_tx_mod), 
    .fifo_mux_0_mac100g_1_tx_err(fifo_mux_0_mac100g_1_tx_err), 
    .fifo_mux_0_mac100g_1_tx_crc(fifo_mux_0_mac100g_1_tx_crc), 
    .mac100_1_ff_tx_rdy_0(mac100_1_ff_tx_rdy_0), 
    .mac100_2_ff_rx_dval_0(mac100_2_ff_rx_dval_0), 
    .mac100_2_ff_rx_data(mac100_2_ff_rx_data), 
    .mac100_2_ff_rx_sop(mac100_2_ff_rx_sop), 
    .mac100_2_ff_rx_eop_0(mac100_2_ff_rx_eop_0), 
    .mac100_2_ff_rx_mod_0(mac100_2_ff_rx_mod_0), 
    .fifo_mux_0_mac100g_2_rx_rdy(fifo_mux_0_mac100g_2_rx_rdy), 
    .mac100_2_ff_rx_ts(mac100_2_ff_rx_ts), 
    .mac100_2_ff_rx_ts_0(mac100_2_ff_rx_ts_0), 
    .fifo_mux_0_mac100g_2_tx_wren(fifo_mux_0_mac100g_2_tx_wren), 
    .fifo_mux_0_mac100g_2_tx_data(fifo_mux_0_mac100g_2_tx_data), 
    .fifo_mux_0_mac100g_2_tx_sop(fifo_mux_0_mac100g_2_tx_sop), 
    .fifo_mux_0_mac100g_2_tx_eop(fifo_mux_0_mac100g_2_tx_eop), 
    .fifo_mux_0_mac100g_2_tx_mod(fifo_mux_0_mac100g_2_tx_mod), 
    .fifo_mux_0_mac100g_2_tx_err(fifo_mux_0_mac100g_2_tx_err), 
    .fifo_mux_0_mac100g_2_tx_crc(fifo_mux_0_mac100g_2_tx_crc), 
    .mac100_2_ff_tx_rdy_0(mac100_2_ff_tx_rdy_0), 
    .mac100_3_ff_rx_dval_0(mac100_3_ff_rx_dval_0), 
    .mac100_3_ff_rx_data(mac100_3_ff_rx_data), 
    .mac100_3_ff_rx_sop(mac100_3_ff_rx_sop), 
    .mac100_3_ff_rx_eop_0(mac100_3_ff_rx_eop_0), 
    .mac100_3_ff_rx_mod_0(mac100_3_ff_rx_mod_0), 
    .fifo_mux_0_mac100g_3_rx_rdy(fifo_mux_0_mac100g_3_rx_rdy), 
    .mac100_3_ff_rx_ts(mac100_3_ff_rx_ts), 
    .mac100_3_ff_rx_ts_0(mac100_3_ff_rx_ts_0), 
    .fifo_mux_0_mac100g_3_tx_wren(fifo_mux_0_mac100g_3_tx_wren), 
    .fifo_mux_0_mac100g_3_tx_data(fifo_mux_0_mac100g_3_tx_data), 
    .fifo_mux_0_mac100g_3_tx_sop(fifo_mux_0_mac100g_3_tx_sop), 
    .fifo_mux_0_mac100g_3_tx_eop(fifo_mux_0_mac100g_3_tx_eop), 
    .fifo_mux_0_mac100g_3_tx_mod(fifo_mux_0_mac100g_3_tx_mod), 
    .fifo_mux_0_mac100g_3_tx_err(fifo_mux_0_mac100g_3_tx_err), 
    .fifo_mux_0_mac100g_3_tx_crc(fifo_mux_0_mac100g_3_tx_crc), 
    .mac100_3_ff_tx_rdy_0(mac100_3_ff_tx_rdy_0), 
    .mdio_in(mdio_in), 
    .mac100_0_mdc(mac100_0_mdc), 
    .mac100_0_mdio_out(mac100_0_mdio_out), 
    .mac100_0_mac_enable(mac100_0_mac_enable), 
    .mac100_0_mac_pause_en(mac100_0_mac_pause_en), 
    .mac100_1_mac_enable(mac100_1_mac_enable), 
    .mac100_1_mac_pause_en(mac100_1_mac_pause_en), 
    .mac100_2_mac_enable(mac100_2_mac_enable), 
    .mac100_2_mac_pause_en(mac100_2_mac_pause_en), 
    .mac100_3_mac_enable(mac100_3_mac_enable), 
    .mac100_3_mac_pause_en(mac100_3_mac_pause_en), 
    .physs_registers_wrapper_0_mac100_config_0_magic_ena(physs_registers_wrapper_0_mac100_config_0_magic_ena), 
    .physs_registers_wrapper_0_mac100_config_1_magic_ena(physs_registers_wrapper_0_mac100_config_1_magic_ena), 
    .physs_registers_wrapper_0_mac100_config_2_magic_ena(physs_registers_wrapper_0_mac100_config_2_magic_ena), 
    .physs_registers_wrapper_0_mac100_config_3_magic_ena(physs_registers_wrapper_0_mac100_config_3_magic_ena), 
    .physs_registers_wrapper_0_mac100_config_0_tx_loc_fault(physs_registers_wrapper_0_mac100_config_0_tx_loc_fault), 
    .physs_registers_wrapper_0_mac100_config_1_tx_loc_fault(physs_registers_wrapper_0_mac100_config_1_tx_loc_fault), 
    .physs_registers_wrapper_0_mac100_config_2_tx_loc_fault(physs_registers_wrapper_0_mac100_config_2_tx_loc_fault), 
    .physs_registers_wrapper_0_mac100_config_3_tx_loc_fault(physs_registers_wrapper_0_mac100_config_3_tx_loc_fault), 
    .physs_registers_wrapper_0_mac100_config_0_tx_rem_fault(physs_registers_wrapper_0_mac100_config_0_tx_rem_fault), 
    .physs_registers_wrapper_0_mac100_config_1_tx_rem_fault(physs_registers_wrapper_0_mac100_config_1_tx_rem_fault), 
    .physs_registers_wrapper_0_mac100_config_2_tx_rem_fault(physs_registers_wrapper_0_mac100_config_2_tx_rem_fault), 
    .physs_registers_wrapper_0_mac100_config_3_tx_rem_fault(physs_registers_wrapper_0_mac100_config_3_tx_rem_fault), 
    .physs_registers_wrapper_0_mac100_config_0_tx_li_fault(physs_registers_wrapper_0_mac100_config_0_tx_li_fault), 
    .physs_registers_wrapper_0_mac100_config_1_tx_li_fault(physs_registers_wrapper_0_mac100_config_1_tx_li_fault), 
    .physs_registers_wrapper_0_mac100_config_2_tx_li_fault(physs_registers_wrapper_0_mac100_config_2_tx_li_fault), 
    .physs_registers_wrapper_0_mac100_config_3_tx_li_fault(physs_registers_wrapper_0_mac100_config_3_tx_li_fault), 
    .physs_clock_sync_0_reset_txclk(physs_clock_sync_0_reset_txclk_1), 
    .physs_clock_sync_0_reset_txclk_0(physs_clock_sync_0_reset_txclk_2), 
    .physs_clock_sync_0_reset_txclk_1(physs_clock_sync_0_reset_txclk_3), 
    .physs_clock_sync_0_reset_txclk_2(physs_clock_sync_0_reset_txclk_4), 
    .physs_clock_sync_0_reset_ff_tx_clk(physs_clock_sync_0_reset_ff_tx_clk_1), 
    .physs_clock_sync_0_reset_ff_tx_clk_0(physs_clock_sync_0_reset_ff_tx_clk_2), 
    .physs_clock_sync_0_reset_ff_tx_clk_1(physs_clock_sync_0_reset_ff_tx_clk_3), 
    .physs_clock_sync_0_reset_ff_tx_clk_2(physs_clock_sync_0_reset_ff_tx_clk_4), 
    .physs_clock_sync_0_reset_ff_rx_clk(physs_clock_sync_0_reset_ff_rx_clk_1), 
    .physs_clock_sync_0_reset_ff_rx_clk_0(physs_clock_sync_0_reset_ff_rx_clk_2), 
    .physs_clock_sync_0_reset_ff_rx_clk_1(physs_clock_sync_0_reset_ff_rx_clk_3), 
    .physs_clock_sync_0_reset_ff_rx_clk_2(physs_clock_sync_0_reset_ff_rx_clk_4)
) ; 
macpcs400_wrap_0 macpcs400_wrap_0 (
    .nic400_quad_0_hselx_mac400_stats_0(nic400_quad_0_hselx_mac400_stats_0), 
    .nic400_quad_0_haddr_mac400_stats_0_out(nic400_quad_0_haddr_mac400_stats_0_out), 
    .nic400_quad_0_htrans_mac400_stats_0(nic400_quad_0_htrans_mac400_stats_0), 
    .nic400_quad_0_hwrite_mac400_stats_0(nic400_quad_0_hwrite_mac400_stats_0), 
    .nic400_quad_0_hsize_mac400_stats_0(nic400_quad_0_hsize_mac400_stats_0), 
    .nic400_quad_0_hwdata_mac400_stats_0(nic400_quad_0_hwdata_mac400_stats_0), 
    .nic400_quad_0_hready_mac400_stats_0(nic400_quad_0_hready_mac400_stats_0), 
    .macstats_ahb_bridge_8_hrdata(macstats_ahb_bridge_8_hrdata), 
    .macstats_ahb_bridge_8_hresp(macstats_ahb_bridge_8_hresp), 
    .macstats_ahb_bridge_8_hreadyout(macstats_ahb_bridge_8_hreadyout), 
    .nic400_quad_0_hselx_mac400_stats_1(nic400_quad_0_hselx_mac400_stats_1), 
    .nic400_quad_0_haddr_mac400_stats_1_out(nic400_quad_0_haddr_mac400_stats_1_out), 
    .nic400_quad_0_htrans_mac400_stats_1(nic400_quad_0_htrans_mac400_stats_1), 
    .nic400_quad_0_hwrite_mac400_stats_1(nic400_quad_0_hwrite_mac400_stats_1), 
    .nic400_quad_0_hsize_mac400_stats_1(nic400_quad_0_hsize_mac400_stats_1), 
    .nic400_quad_0_hwdata_mac400_stats_1(nic400_quad_0_hwdata_mac400_stats_1), 
    .nic400_quad_0_hready_mac400_stats_1(nic400_quad_0_hready_mac400_stats_1), 
    .macstats_ahb_bridge_9_hrdata(macstats_ahb_bridge_9_hrdata), 
    .macstats_ahb_bridge_9_hresp(macstats_ahb_bridge_9_hresp), 
    .macstats_ahb_bridge_9_hreadyout(macstats_ahb_bridge_9_hreadyout), 
    .nic400_quad_0_hselx_mac400_0(nic400_quad_0_hselx_mac400_0), 
    .nic400_quad_0_haddr_mac400_0_out(nic400_quad_0_haddr_mac400_0_out), 
    .nic400_quad_0_htrans_mac400_0(nic400_quad_0_htrans_mac400_0), 
    .nic400_quad_0_hwrite_mac400_0(nic400_quad_0_hwrite_mac400_0), 
    .nic400_quad_0_hsize_mac400_0(nic400_quad_0_hsize_mac400_0), 
    .nic400_quad_0_hwdata_mac400_0(nic400_quad_0_hwdata_mac400_0), 
    .nic400_quad_0_hready_mac400_0(nic400_quad_0_hready_mac400_0), 
    .mac200_ahb_bridge_0_hrdata(mac200_ahb_bridge_0_hrdata), 
    .mac200_ahb_bridge_0_hresp(mac200_ahb_bridge_0_hresp), 
    .mac200_ahb_bridge_0_hreadyout(mac200_ahb_bridge_0_hreadyout), 
    .nic400_quad_0_hselx_mac400_1(nic400_quad_0_hselx_mac400_1), 
    .nic400_quad_0_haddr_mac400_1_out(nic400_quad_0_haddr_mac400_1_out), 
    .nic400_quad_0_htrans_mac400_1(nic400_quad_0_htrans_mac400_1), 
    .nic400_quad_0_hwrite_mac400_1(nic400_quad_0_hwrite_mac400_1), 
    .nic400_quad_0_hsize_mac400_1(nic400_quad_0_hsize_mac400_1), 
    .nic400_quad_0_hwdata_mac400_1(nic400_quad_0_hwdata_mac400_1), 
    .nic400_quad_0_hready_mac400_1(nic400_quad_0_hready_mac400_1), 
    .mac400_ahb_bridge_0_hrdata(mac400_ahb_bridge_0_hrdata), 
    .mac400_ahb_bridge_0_hresp(mac400_ahb_bridge_0_hresp), 
    .mac400_ahb_bridge_0_hreadyout(mac400_ahb_bridge_0_hreadyout), 
    .nic400_quad_0_hselx_pcs400_0(nic400_quad_0_hselx_pcs400_0), 
    .nic400_quad_0_haddr_pcs400_0_out(nic400_quad_0_haddr_pcs400_0_out), 
    .nic400_quad_0_htrans_pcs400_0(nic400_quad_0_htrans_pcs400_0), 
    .nic400_quad_0_hwrite_pcs400_0(nic400_quad_0_hwrite_pcs400_0), 
    .nic400_quad_0_hsize_pcs400_0(nic400_quad_0_hsize_pcs400_0), 
    .nic400_quad_0_hwdata_pcs400_0(nic400_quad_0_hwdata_pcs400_0), 
    .nic400_quad_0_hready_pcs400_0(nic400_quad_0_hready_pcs400_0), 
    .pcs200_ahb_bridge_0_hrdata(pcs200_ahb_bridge_0_hrdata), 
    .pcs200_ahb_bridge_0_hresp(pcs200_ahb_bridge_0_hresp), 
    .pcs200_ahb_bridge_0_hreadyout(pcs200_ahb_bridge_0_hreadyout), 
    .nic400_quad_0_hselx_rsfec400_0(nic400_quad_0_hselx_rsfec400_0), 
    .nic400_quad_0_haddr_rsfec400_0_out(nic400_quad_0_haddr_rsfec400_0_out), 
    .nic400_quad_0_htrans_rsfec400_0(nic400_quad_0_htrans_rsfec400_0), 
    .nic400_quad_0_hwrite_rsfec400_0(nic400_quad_0_hwrite_rsfec400_0), 
    .nic400_quad_0_hsize_rsfec400_0(nic400_quad_0_hsize_rsfec400_0), 
    .nic400_quad_0_hwdata_rsfec400_0(nic400_quad_0_hwdata_rsfec400_0), 
    .nic400_quad_0_hready_rsfec400_0(nic400_quad_0_hready_rsfec400_0), 
    .pcs200_ahb_bridge_1_hrdata(pcs200_ahb_bridge_1_hrdata), 
    .pcs200_ahb_bridge_1_hresp(pcs200_ahb_bridge_1_hresp), 
    .pcs200_ahb_bridge_1_hreadyout(pcs200_ahb_bridge_1_hreadyout), 
    .nic400_quad_0_hselx_pcs400_1(nic400_quad_0_hselx_pcs400_1), 
    .nic400_quad_0_haddr_pcs400_1_out(nic400_quad_0_haddr_pcs400_1_out), 
    .nic400_quad_0_htrans_pcs400_1(nic400_quad_0_htrans_pcs400_1), 
    .nic400_quad_0_hwrite_pcs400_1(nic400_quad_0_hwrite_pcs400_1), 
    .nic400_quad_0_hsize_pcs400_1(nic400_quad_0_hsize_pcs400_1), 
    .nic400_quad_0_hwdata_pcs400_1(nic400_quad_0_hwdata_pcs400_1), 
    .nic400_quad_0_hready_pcs400_1(nic400_quad_0_hready_pcs400_1), 
    .pcs400_ahb_bridge_0_hrdata(pcs400_ahb_bridge_0_hrdata), 
    .pcs400_ahb_bridge_0_hresp(pcs400_ahb_bridge_0_hresp), 
    .pcs400_ahb_bridge_0_hreadyout(pcs400_ahb_bridge_0_hreadyout), 
    .nic400_quad_0_hselx_rsfec400_1(nic400_quad_0_hselx_rsfec400_1), 
    .nic400_quad_0_haddr_rsfec400_1_out(nic400_quad_0_haddr_rsfec400_1_out), 
    .nic400_quad_0_htrans_rsfec400_1(nic400_quad_0_htrans_rsfec400_1), 
    .nic400_quad_0_hwrite_rsfec400_1(nic400_quad_0_hwrite_rsfec400_1), 
    .nic400_quad_0_hsize_rsfec400_1(nic400_quad_0_hsize_rsfec400_1), 
    .nic400_quad_0_hwdata_rsfec400_1(nic400_quad_0_hwdata_rsfec400_1), 
    .nic400_quad_0_hready_rsfec400_1(nic400_quad_0_hready_rsfec400_1), 
    .pcs400_ahb_bridge_1_hrdata(pcs400_ahb_bridge_1_hrdata), 
    .pcs400_ahb_bridge_1_hresp(pcs400_ahb_bridge_1_hresp), 
    .pcs400_ahb_bridge_1_hreadyout(pcs400_ahb_bridge_1_hreadyout), 
    .mac200_0_pause_on(mac200_0_pause_on), 
    .mac400_0_pause_on(mac400_0_pause_on), 
    .mac200_0_li_fault(mac200_0_li_fault), 
    .mac400_0_li_fault(mac400_0_li_fault), 
    .mac200_0_rem_fault(mac200_0_rem_fault), 
    .mac400_0_rem_fault(mac400_0_rem_fault), 
    .mac200_0_loc_fault(mac200_0_loc_fault), 
    .mac400_0_loc_fault(mac400_0_loc_fault), 
    .mac200_0_tx_empty(mac200_0_tx_empty), 
    .mac400_0_tx_empty(mac400_0_tx_empty), 
    .mac200_0_ff_rx_empty(mac200_0_ff_rx_empty), 
    .mac400_0_ff_rx_empty(mac400_0_ff_rx_empty), 
    .mac200_0_tx_isidle(mac200_0_tx_isidle), 
    .mac400_0_tx_isidle(mac400_0_tx_isidle), 
    .mac200_0_ff_tx_septy(mac200_0_ff_tx_septy), 
    .mac400_0_ff_tx_septy(mac400_0_ff_tx_septy), 
    .mac200_0_tx_underflow(mac200_0_tx_underflow), 
    .mac400_0_tx_underflow(mac400_0_tx_underflow), 
    .mac200_0_tx_ovr_err(mac200_0_tx_ovr_err), 
    .mac400_0_tx_ovr_err(mac400_0_tx_ovr_err), 
    .pcs200_0_rx_am_sf(pcs200_0_rx_am_sf), 
    .pcs200_0_degrade_ser(pcs200_0_degrade_ser), 
    .pcs200_0_hi_ser(pcs200_0_hi_ser), 
    .pcs200_0_link_status(pcs200_0_link_status), 
    .pcs200_0_amps_lock(pcs200_0_amps_lock), 
    .pcs200_0_align_lock(pcs200_0_align_lock), 
    .pcs400_0_rx_am_sf(pcs400_0_rx_am_sf), 
    .pcs400_0_degrade_ser(pcs400_0_degrade_ser), 
    .pcs400_0_hi_ser(pcs400_0_hi_ser), 
    .pcs400_0_link_status(pcs400_0_link_status), 
    .pcs400_0_amps_lock(pcs400_0_amps_lock), 
    .pcs400_0_align_lock(pcs400_0_align_lock), 
    .physs_registers_wrapper_0_pcs200_reg_tx_am_sf(physs_registers_wrapper_0_pcs200_reg_tx_am_sf), 
    .physs_registers_wrapper_0_pcs200_reg_rsfec_mode_ll(physs_registers_wrapper_0_pcs200_reg_rsfec_mode_ll), 
    .physs_registers_wrapper_0_pcs200_reg_sd_4x_en(physs_registers_wrapper_0_pcs200_reg_sd_4x_en), 
    .physs_registers_wrapper_0_pcs200_reg_sd_8x_en(physs_registers_wrapper_0_pcs200_reg_sd_8x_en), 
    .physs_registers_wrapper_0_pcs400_reg_tx_am_sf(physs_registers_wrapper_0_pcs400_reg_tx_am_sf), 
    .physs_registers_wrapper_0_pcs400_reg_rsfec_mode_ll(physs_registers_wrapper_0_pcs400_reg_rsfec_mode_ll), 
    .physs_registers_wrapper_0_pcs400_reg_sd_4x_en(physs_registers_wrapper_0_pcs400_reg_sd_4x_en), 
    .physs_registers_wrapper_0_pcs400_reg_sd_8x_en(physs_registers_wrapper_0_pcs400_reg_sd_8x_en), 
    .physs_clock_sync_0_physs_func_clk_gated_100(physs_clock_sync_0_physs_func_clk_gated_100), 
    .physs_lane_reversal_mux_0_serdes_rx_clk(physs_lane_reversal_mux_0_serdes_rx_clk), 
    .physs_lane_reversal_mux_0_serdes_tx_clk(physs_lane_reversal_mux_0_serdes_tx_clk), 
    .physs_clock_sync_0_soc_per_clk_gated_200(physs_clock_sync_0_soc_per_clk_gated_200), 
    .physs_clock_sync_0_soc_per_clk_gated_400(physs_clock_sync_0_soc_per_clk_gated_400), 
    .physs_clock_sync_0_physs_func_clk_gated_200(physs_clock_sync_0_physs_func_clk_gated_200), 
    .physs_clock_sync_0_physs_func_clk_gated_400(physs_clock_sync_0_physs_func_clk_gated_400), 
    .physs_clock_sync_0_reset_reg_clk_mac(physs_clock_sync_0_reset_reg_clk_mac_3), 
    .physs_clock_sync_0_reset_reg_clk_mac_0(physs_clock_sync_0_reset_reg_clk_mac_4), 
    .physs_clock_sync_0_reset_rxclk(physs_clock_sync_0_reset_rxclk_3), 
    .physs_clock_sync_0_reset_rxclk_0(physs_clock_sync_0_reset_rxclk_4), 
    .soc_per_clk_pdop_parmquad0_clkout(soc_per_clk_pdop_parmquad0_clkout), 
    .physs_clock_sync_0_func_rstn_fabric_sync(physs_clock_sync_0_func_rstn_fabric_sync), 
    .physs_hd2prf_trim_fuse_in(physs_hd2prf_trim_fuse_in), 
    .physs_hdp2prf_trim_fuse_in(physs_hdp2prf_trim_fuse_in), 
    .physs_func_rst_raw_n(physs_func_rst_raw_n), 
    .physs_clock_sync_0_reset_txclk(physs_clock_sync_0_reset_txclk), 
    .physs_clock_sync_0_reset_ff_tx_clk(physs_clock_sync_0_reset_ff_tx_clk), 
    .physs_clock_sync_0_reset_ff_rx_clk(physs_clock_sync_0_reset_ff_rx_clk), 
    .physs_clock_sync_0_reset_cdmii_rxclk_400G(physs_clock_sync_0_reset_cdmii_rxclk_400G), 
    .physs_clock_sync_0_reset_cdmii_txclk_400G(physs_clock_sync_0_reset_cdmii_txclk_400G), 
    .physs_clock_sync_0_reset_sd_tx_clk_400G(physs_clock_sync_0_reset_sd_tx_clk_400G), 
    .physs_clock_sync_0_reset_sd_rx_clk_400G(physs_clock_sync_0_reset_sd_rx_clk_400G), 
    .physs_clock_sync_0_reset_reg_ref_clk_400G(physs_clock_sync_0_reset_reg_ref_clk_400G), 
    .physs_clock_sync_0_reset_reg_clk_400G(physs_clock_sync_0_reset_reg_clk_400G), 
    .physs_clock_sync_0_reset_txclk_0(physs_clock_sync_0_reset_txclk_0), 
    .physs_clock_sync_0_reset_ff_tx_clk_0(physs_clock_sync_0_reset_ff_tx_clk_0), 
    .physs_clock_sync_0_reset_ff_rx_clk_0(physs_clock_sync_0_reset_ff_rx_clk_0), 
    .physs_clock_sync_0_reset_cdmii_rxclk_200G(physs_clock_sync_0_reset_cdmii_rxclk_200G), 
    .physs_clock_sync_0_reset_cdmii_txclk_200G(physs_clock_sync_0_reset_cdmii_txclk_200G), 
    .physs_clock_sync_0_reset_sd_tx_clk_200G(physs_clock_sync_0_reset_sd_tx_clk_200G), 
    .physs_clock_sync_0_reset_sd_rx_clk_200G(physs_clock_sync_0_reset_sd_rx_clk_200G), 
    .physs_clock_sync_0_reset_reg_ref_clk_200G(physs_clock_sync_0_reset_reg_ref_clk_200G), 
    .physs_clock_sync_0_reset_reg_clk_200G(physs_clock_sync_0_reset_reg_clk_200G), 
    .mac200_0_ff_rx_err_stat(mac200_0_ff_rx_err_stat), 
    .mac400_0_ff_rx_err_stat(mac400_0_ff_rx_err_stat), 
    .mac200_0_tx_ts_val(mac200_0_tx_ts_val), 
    .mac200_0_tx_ts_id(mac200_0_tx_ts_id), 
    .mac200_0_tx_ts(mac200_0_tx_ts), 
    .mac400_0_tx_ts_val(mac400_0_tx_ts_val), 
    .mac400_0_tx_ts_id(mac400_0_tx_ts_id), 
    .mac400_0_tx_ts(mac400_0_tx_ts), 
    .pcs400_0_sd0_tx(pcs400_0_sd0_tx), 
    .pcs400_0_sd1_tx(pcs400_0_sd1_tx), 
    .pcs400_0_sd2_tx(pcs400_0_sd2_tx), 
    .pcs400_0_sd3_tx(pcs400_0_sd3_tx), 
    .pcs400_0_sd4_tx(pcs400_0_sd4_tx), 
    .pcs400_0_sd5_tx(pcs400_0_sd5_tx), 
    .pcs400_0_sd6_tx(pcs400_0_sd6_tx), 
    .pcs400_0_sd7_tx(pcs400_0_sd7_tx), 
    .pcs400_0_sd8_tx(pcs400_0_sd8_tx), 
    .pcs400_0_sd9_tx(pcs400_0_sd9_tx), 
    .pcs400_0_sd10_tx(pcs400_0_sd10_tx), 
    .pcs400_0_sd11_tx(pcs400_0_sd11_tx), 
    .pcs400_0_sd12_tx(pcs400_0_sd12_tx), 
    .pcs400_0_sd13_tx(pcs400_0_sd13_tx), 
    .pcs400_0_sd14_tx(pcs400_0_sd14_tx), 
    .pcs400_0_sd15_tx(pcs400_0_sd15_tx), 
    .physs_pcs_mux_0_sd0_rx_data_400G_o(physs_pcs_mux_0_sd0_rx_data_400G_o), 
    .physs_pcs_mux_0_sd1_rx_data_400G_o(physs_pcs_mux_0_sd1_rx_data_400G_o), 
    .physs_pcs_mux_0_sd2_rx_data_400G_o(physs_pcs_mux_0_sd2_rx_data_400G_o), 
    .physs_pcs_mux_0_sd3_rx_data_400G_o(physs_pcs_mux_0_sd3_rx_data_400G_o), 
    .physs_pcs_mux_0_sd4_rx_data_400G_o(physs_pcs_mux_0_sd4_rx_data_400G_o), 
    .physs_pcs_mux_0_sd5_rx_data_400G_o(physs_pcs_mux_0_sd5_rx_data_400G_o), 
    .physs_pcs_mux_0_sd6_rx_data_400G_o(physs_pcs_mux_0_sd6_rx_data_400G_o), 
    .physs_pcs_mux_0_sd7_rx_data_400G_o(physs_pcs_mux_0_sd7_rx_data_400G_o), 
    .physs_pcs_mux_0_sd8_rx_data_400G_o(physs_pcs_mux_0_sd8_rx_data_400G_o), 
    .physs_pcs_mux_0_sd9_rx_data_400G_o(physs_pcs_mux_0_sd9_rx_data_400G_o), 
    .physs_pcs_mux_0_sd10_rx_data_400G_o(physs_pcs_mux_0_sd10_rx_data_400G_o), 
    .physs_pcs_mux_0_sd11_rx_data_400G_o(physs_pcs_mux_0_sd11_rx_data_400G_o), 
    .physs_pcs_mux_0_sd12_rx_data_400G_o(physs_pcs_mux_0_sd12_rx_data_400G_o), 
    .physs_pcs_mux_0_sd13_rx_data_400G_o(physs_pcs_mux_0_sd13_rx_data_400G_o), 
    .physs_pcs_mux_0_sd14_rx_data_400G_o(physs_pcs_mux_0_sd14_rx_data_400G_o), 
    .physs_pcs_mux_0_sd15_rx_data_400G_o(physs_pcs_mux_0_sd15_rx_data_400G_o), 
    .pcs200_0_sd0_tx(pcs200_0_sd0_tx), 
    .pcs200_0_sd1_tx(pcs200_0_sd1_tx), 
    .pcs200_0_sd2_tx(pcs200_0_sd2_tx), 
    .pcs200_0_sd3_tx(pcs200_0_sd3_tx), 
    .pcs200_0_sd4_tx(pcs200_0_sd4_tx), 
    .pcs200_0_sd5_tx(pcs200_0_sd5_tx), 
    .pcs200_0_sd6_tx(pcs200_0_sd6_tx), 
    .pcs200_0_sd7_tx(pcs200_0_sd7_tx), 
    .physs_pcs_mux_0_sd0_rx_data_o(physs_pcs_mux_0_sd0_rx_data_o), 
    .physs_pcs_mux_0_sd1_rx_data_o(physs_pcs_mux_0_sd1_rx_data_o), 
    .physs_pcs_mux_0_sd2_rx_data_o(physs_pcs_mux_0_sd2_rx_data_o), 
    .physs_pcs_mux_0_sd3_rx_data_o(physs_pcs_mux_0_sd3_rx_data_o), 
    .physs_pcs_mux_0_sd4_rx_data_o(physs_pcs_mux_0_sd4_rx_data_o), 
    .physs_pcs_mux_0_sd5_rx_data_o(physs_pcs_mux_0_sd5_rx_data_o), 
    .physs_pcs_mux_0_sd6_rx_data_o(physs_pcs_mux_0_sd6_rx_data_o), 
    .physs_pcs_mux_0_sd7_rx_data_o(physs_pcs_mux_0_sd7_rx_data_o), 
    .physs_pcs_mux_0_srds_rdy_out_200G(physs_pcs_mux_0_srds_rdy_out_200G), 
    .physs_pcs_mux_0_srds_rdy_out_400G(physs_pcs_mux_0_srds_rdy_out_400G), 
    .physs_pcs_mux_0_sd0_tx_clk_200G(physs_pcs_mux_0_sd0_tx_clk_200G), 
    .physs_pcs_mux_0_sd2_tx_clk_200G(physs_pcs_mux_0_sd2_tx_clk_200G), 
    .physs_pcs_mux_0_sd4_tx_clk_200G(physs_pcs_mux_0_sd4_tx_clk_200G), 
    .physs_pcs_mux_0_sd6_tx_clk_200G(physs_pcs_mux_0_sd6_tx_clk_200G), 
    .physs_pcs_mux_0_sd8_tx_clk_200G(physs_pcs_mux_0_sd8_tx_clk_200G), 
    .physs_pcs_mux_0_sd10_tx_clk_200G(physs_pcs_mux_0_sd10_tx_clk_200G), 
    .physs_pcs_mux_0_sd12_tx_clk_200G(physs_pcs_mux_0_sd12_tx_clk_200G), 
    .physs_pcs_mux_0_sd14_tx_clk_200G(physs_pcs_mux_0_sd14_tx_clk_200G), 
    .physs_pcs_mux_0_sd0_rx_clk_200G(physs_pcs_mux_0_sd0_rx_clk_200G), 
    .physs_pcs_mux_0_sd1_rx_clk_200G(physs_pcs_mux_0_sd1_rx_clk_200G), 
    .physs_pcs_mux_0_sd2_rx_clk_200G(physs_pcs_mux_0_sd2_rx_clk_200G), 
    .physs_pcs_mux_0_sd3_rx_clk_200G(physs_pcs_mux_0_sd3_rx_clk_200G), 
    .physs_pcs_mux_0_sd4_rx_clk_200G(physs_pcs_mux_0_sd4_rx_clk_200G), 
    .physs_pcs_mux_0_sd5_rx_clk_200G(physs_pcs_mux_0_sd5_rx_clk_200G), 
    .physs_pcs_mux_0_sd6_rx_clk_200G(physs_pcs_mux_0_sd6_rx_clk_200G), 
    .physs_pcs_mux_0_sd7_rx_clk_200G(physs_pcs_mux_0_sd7_rx_clk_200G), 
    .physs_pcs_mux_0_sd8_rx_clk_200G(physs_pcs_mux_0_sd8_rx_clk_200G), 
    .physs_pcs_mux_0_sd9_rx_clk_200G(physs_pcs_mux_0_sd9_rx_clk_200G), 
    .physs_pcs_mux_0_sd10_rx_clk_200G(physs_pcs_mux_0_sd10_rx_clk_200G), 
    .physs_pcs_mux_0_sd11_rx_clk_200G(physs_pcs_mux_0_sd11_rx_clk_200G), 
    .physs_pcs_mux_0_sd12_rx_clk_200G(physs_pcs_mux_0_sd12_rx_clk_200G), 
    .physs_pcs_mux_0_sd13_rx_clk_200G(physs_pcs_mux_0_sd13_rx_clk_200G), 
    .physs_pcs_mux_0_sd14_rx_clk_200G(physs_pcs_mux_0_sd14_rx_clk_200G), 
    .physs_pcs_mux_0_sd15_rx_clk_200G(physs_pcs_mux_0_sd15_rx_clk_200G), 
    .physs_pcs_mux_0_sd0_tx_clk_400G(physs_pcs_mux_0_sd0_tx_clk_400G), 
    .physs_pcs_mux_0_sd2_tx_clk_400G(physs_pcs_mux_0_sd2_tx_clk_400G), 
    .physs_pcs_mux_0_sd4_tx_clk_400G(physs_pcs_mux_0_sd4_tx_clk_400G), 
    .physs_pcs_mux_0_sd6_tx_clk_400G(physs_pcs_mux_0_sd6_tx_clk_400G), 
    .physs_pcs_mux_0_sd8_tx_clk_400G(physs_pcs_mux_0_sd8_tx_clk_400G), 
    .physs_pcs_mux_0_sd10_tx_clk_400G(physs_pcs_mux_0_sd10_tx_clk_400G), 
    .physs_pcs_mux_0_sd12_tx_clk_400G(physs_pcs_mux_0_sd12_tx_clk_400G), 
    .physs_pcs_mux_0_sd14_tx_clk_400G(physs_pcs_mux_0_sd14_tx_clk_400G), 
    .physs_pcs_mux_0_sd0_rx_clk_400G(physs_pcs_mux_0_sd0_rx_clk_400G), 
    .physs_pcs_mux_0_sd1_rx_clk_400G(physs_pcs_mux_0_sd1_rx_clk_400G), 
    .physs_pcs_mux_0_sd2_rx_clk_400G(physs_pcs_mux_0_sd2_rx_clk_400G), 
    .physs_pcs_mux_0_sd3_rx_clk_400G(physs_pcs_mux_0_sd3_rx_clk_400G), 
    .physs_pcs_mux_0_sd4_rx_clk_400G(physs_pcs_mux_0_sd4_rx_clk_400G), 
    .physs_pcs_mux_0_sd5_rx_clk_400G(physs_pcs_mux_0_sd5_rx_clk_400G), 
    .physs_pcs_mux_0_sd6_rx_clk_400G(physs_pcs_mux_0_sd6_rx_clk_400G), 
    .physs_pcs_mux_0_sd7_rx_clk_400G(physs_pcs_mux_0_sd7_rx_clk_400G), 
    .physs_pcs_mux_0_sd8_rx_clk_400G(physs_pcs_mux_0_sd8_rx_clk_400G), 
    .physs_pcs_mux_0_sd9_rx_clk_400G(physs_pcs_mux_0_sd9_rx_clk_400G), 
    .physs_pcs_mux_0_sd10_rx_clk_400G(physs_pcs_mux_0_sd10_rx_clk_400G), 
    .physs_pcs_mux_0_sd11_rx_clk_400G(physs_pcs_mux_0_sd11_rx_clk_400G), 
    .physs_pcs_mux_0_sd12_rx_clk_400G(physs_pcs_mux_0_sd12_rx_clk_400G), 
    .physs_pcs_mux_0_sd13_rx_clk_400G(physs_pcs_mux_0_sd13_rx_clk_400G), 
    .physs_pcs_mux_0_sd14_rx_clk_400G(physs_pcs_mux_0_sd14_rx_clk_400G), 
    .physs_pcs_mux_0_sd15_rx_clk_400G(physs_pcs_mux_0_sd15_rx_clk_400G), 
    .mac400_0_ff_rx_dval(mac400_0_ff_rx_dval), 
    .mac400_0_ff_rx_data(mac400_0_ff_rx_data), 
    .mac400_0_ff_rx_sop(mac400_0_ff_rx_sop), 
    .mac400_0_ff_rx_eop(mac400_0_ff_rx_eop), 
    .mac400_0_ff_rx_mod(mac400_0_ff_rx_mod), 
    .mac400_0_ff_rx_err(mac400_0_ff_rx_err), 
    .fifo_mux_0_mac400g_0_rx_rdy(fifo_mux_0_mac400g_0_rx_rdy), 
    .mac400_0_ff_rx_ts(mac400_0_ff_rx_ts), 
    .fifo_mux_0_mac400g_0_tx_wren(fifo_mux_0_mac400g_0_tx_wren), 
    .fifo_mux_0_mac400g_0_tx_data(fifo_mux_0_mac400g_0_tx_data), 
    .fifo_mux_0_mac400g_0_tx_sop(fifo_mux_0_mac400g_0_tx_sop), 
    .fifo_mux_0_mac400g_0_tx_eop(fifo_mux_0_mac400g_0_tx_eop), 
    .fifo_mux_0_mac400g_0_tx_mod(fifo_mux_0_mac400g_0_tx_mod), 
    .fifo_mux_0_mac400g_0_tx_err(fifo_mux_0_mac400g_0_tx_err), 
    .fifo_mux_0_mac400g_0_tx_crc(fifo_mux_0_mac400g_0_tx_crc), 
    .mac400_0_ff_tx_rdy(mac400_0_ff_tx_rdy), 
    .mac200_0_ff_rx_dval(mac200_0_ff_rx_dval), 
    .mac200_0_ff_rx_data(mac200_0_ff_rx_data), 
    .mac200_0_ff_rx_sop(mac200_0_ff_rx_sop), 
    .mac200_0_ff_rx_eop(mac200_0_ff_rx_eop), 
    .mac200_0_ff_rx_mod(mac200_0_ff_rx_mod), 
    .mac200_0_ff_rx_err(mac200_0_ff_rx_err), 
    .fifo_mux_0_mac400g_1_rx_rdy(fifo_mux_0_mac400g_1_rx_rdy), 
    .mac200_0_ff_rx_ts(mac200_0_ff_rx_ts), 
    .fifo_mux_0_mac400g_1_tx_wren(fifo_mux_0_mac400g_1_tx_wren), 
    .fifo_mux_0_mac400g_1_tx_data(fifo_mux_0_mac400g_1_tx_data), 
    .fifo_mux_0_mac400g_1_tx_sop(fifo_mux_0_mac400g_1_tx_sop), 
    .fifo_mux_0_mac400g_1_tx_eop(fifo_mux_0_mac400g_1_tx_eop), 
    .fifo_mux_0_mac400g_1_tx_mod(fifo_mux_0_mac400g_1_tx_mod), 
    .fifo_mux_0_mac400g_1_tx_err(fifo_mux_0_mac400g_1_tx_err), 
    .fifo_mux_0_mac400g_1_tx_crc(fifo_mux_0_mac400g_1_tx_crc), 
    .mac200_0_ff_tx_rdy(mac200_0_ff_tx_rdy)
) ; 
xmp_phy_ss_0 xmp_phy_ss_0 (
    .ETH_RXN0(ETH_RXN0), 
    .ETH_RXP0(ETH_RXP0), 
    .ETH_RXN1(ETH_RXN1), 
    .ETH_RXP1(ETH_RXP1), 
    .ETH_RXN2(ETH_RXN2), 
    .ETH_RXP2(ETH_RXP2), 
    .ETH_RXN3(ETH_RXN3), 
    .ETH_RXP3(ETH_RXP3), 
    .versa_xmp_0_xoa_pma0_tx_n_l0(versa_xmp_0_xoa_pma0_tx_n_l0), 
    .versa_xmp_0_xoa_pma0_tx_p_l0(versa_xmp_0_xoa_pma0_tx_p_l0), 
    .versa_xmp_0_xoa_pma1_tx_n_l0(versa_xmp_0_xoa_pma1_tx_n_l0), 
    .versa_xmp_0_xoa_pma1_tx_p_l0(versa_xmp_0_xoa_pma1_tx_p_l0), 
    .versa_xmp_0_xoa_pma2_tx_n_l0(versa_xmp_0_xoa_pma2_tx_n_l0), 
    .versa_xmp_0_xoa_pma2_tx_p_l0(versa_xmp_0_xoa_pma2_tx_p_l0), 
    .versa_xmp_0_xoa_pma3_tx_n_l0(versa_xmp_0_xoa_pma3_tx_n_l0), 
    .versa_xmp_0_xoa_pma3_tx_p_l0(versa_xmp_0_xoa_pma3_tx_p_l0), 
    .ioa_pma_remote_diode_i_anode(ioa_pma_remote_diode_i_anode), 
    .ioa_pma_remote_diode_i_anode_0(ioa_pma_remote_diode_i_anode_0), 
    .ioa_pma_remote_diode_i_anode_1(ioa_pma_remote_diode_i_anode_1), 
    .ioa_pma_remote_diode_i_anode_2(ioa_pma_remote_diode_i_anode_2), 
    .ioa_pma_remote_diode_v_anode(ioa_pma_remote_diode_v_anode), 
    .ioa_pma_remote_diode_v_anode_0(ioa_pma_remote_diode_v_anode_0), 
    .ioa_pma_remote_diode_v_anode_1(ioa_pma_remote_diode_v_anode_1), 
    .ioa_pma_remote_diode_v_anode_2(ioa_pma_remote_diode_v_anode_2), 
    .ioa_pma_remote_diode_i_cathode(ioa_pma_remote_diode_i_cathode), 
    .ioa_pma_remote_diode_i_cathode_0(ioa_pma_remote_diode_i_cathode_0), 
    .ioa_pma_remote_diode_i_cathode_1(ioa_pma_remote_diode_i_cathode_1), 
    .ioa_pma_remote_diode_i_cathode_2(ioa_pma_remote_diode_i_cathode_2), 
    .ioa_pma_remote_diode_v_cathode(ioa_pma_remote_diode_v_cathode), 
    .ioa_pma_remote_diode_v_cathode_0(ioa_pma_remote_diode_v_cathode_0), 
    .ioa_pma_remote_diode_v_cathode_1(ioa_pma_remote_diode_v_cathode_1), 
    .ioa_pma_remote_diode_v_cathode_2(ioa_pma_remote_diode_v_cathode_2), 
    .versa_xmp_0_o_ck_pma0_rx_postdiv_l0(versa_xmp_0_o_ck_pma0_rx_postdiv_l0), 
    .versa_xmp_0_o_ck_pma1_rx_postdiv_l0(versa_xmp_0_o_ck_pma1_rx_postdiv_l0), 
    .versa_xmp_0_o_ck_pma2_rx_postdiv_l0(versa_xmp_0_o_ck_pma2_rx_postdiv_l0), 
    .versa_xmp_0_o_ck_pma3_rx_postdiv_l0(versa_xmp_0_o_ck_pma3_rx_postdiv_l0), 
    .nic400_quad_0_paddr_xmp_out(nic400_quad_0_paddr_xmp_out), 
    .nic400_quad_0_pwdata_xmp(nic400_quad_0_pwdata_xmp), 
    .nic400_quad_0_pwrite_xmp(nic400_quad_0_pwrite_xmp), 
    .nic400_quad_0_pprot_xmp(nic400_quad_0_pprot_xmp), 
    .nic400_quad_0_pstrb_xmp(nic400_quad_0_pstrb_xmp), 
    .nic400_quad_0_penable_xmp(nic400_quad_0_penable_xmp), 
    .nic400_quad_0_pselx_xmp(nic400_quad_0_pselx_xmp), 
    .versa_xmp_0_o_apb_pready(versa_xmp_0_o_apb_pready), 
    .versa_xmp_0_o_apb_prdata(versa_xmp_0_o_apb_prdata), 
    .versa_xmp_0_o_apb_pslverr(versa_xmp_0_o_apb_pslverr), 
    .soc_per_clk_pdop_parmquad0_clkout(soc_per_clk_pdop_parmquad0_clkout), 
    .physs_clock_sync_0_rst_apb_b_a(physs_clock_sync_0_rst_apb_b_a), 
    .physs_clock_sync_0_rst_ucss_por_b_a(physs_clock_sync_0_rst_ucss_por_b_a), 
    .physs_clock_sync_0_rst_pma0_por_b_a(physs_clock_sync_0_rst_pma0_por_b_a), 
    .physs_hdspsr_trim_fuse_in(physs_hdspsr_trim_fuse_in), 
    .physs_hdp2prf_trim_fuse_in(physs_hdp2prf_trim_fuse_in), 
    .versa_xmp_0_xioa_ck_pma0_ref0_n(versa_xmp_0_xioa_ck_pma0_ref0_n), 
    .versa_xmp_0_xioa_ck_pma0_ref0_p(versa_xmp_0_xioa_ck_pma0_ref0_p), 
    .versa_xmp_0_xioa_ck_pma0_ref1_n(versa_xmp_0_xioa_ck_pma0_ref1_n), 
    .versa_xmp_0_xioa_ck_pma0_ref1_p(versa_xmp_0_xioa_ck_pma0_ref1_p), 
    .versa_xmp_0_xioa_ck_pma1_ref0_n(versa_xmp_0_xioa_ck_pma1_ref0_n), 
    .versa_xmp_0_xioa_ck_pma1_ref0_p(versa_xmp_0_xioa_ck_pma1_ref0_p), 
    .versa_xmp_0_xioa_ck_pma1_ref1_n(versa_xmp_0_xioa_ck_pma1_ref1_n), 
    .versa_xmp_0_xioa_ck_pma1_ref1_p(versa_xmp_0_xioa_ck_pma1_ref1_p), 
    .versa_xmp_0_xioa_ck_pma2_ref0_n(versa_xmp_0_xioa_ck_pma2_ref0_n), 
    .versa_xmp_0_xioa_ck_pma2_ref0_p(versa_xmp_0_xioa_ck_pma2_ref0_p), 
    .versa_xmp_0_xioa_ck_pma2_ref1_n(versa_xmp_0_xioa_ck_pma2_ref1_n), 
    .versa_xmp_0_xioa_ck_pma2_ref1_p(versa_xmp_0_xioa_ck_pma2_ref1_p), 
    .versa_xmp_0_xioa_ck_pma3_ref0_n(versa_xmp_0_xioa_ck_pma3_ref0_n), 
    .versa_xmp_0_xioa_ck_pma3_ref0_p(versa_xmp_0_xioa_ck_pma3_ref0_p), 
    .versa_xmp_0_xioa_ck_pma3_ref1_n(versa_xmp_0_xioa_ck_pma3_ref1_n), 
    .versa_xmp_0_xioa_ck_pma3_ref1_p(versa_xmp_0_xioa_ck_pma3_ref1_p), 
    .rclk_diff_p(rclk_diff_p), 
    .rclk_diff_n(rclk_diff_n), 
    .versa_xmp_0_xoa_pma0_dcmon1(versa_xmp_0_xoa_pma0_dcmon1), 
    .versa_xmp_0_xoa_pma0_dcmon2(versa_xmp_0_xoa_pma0_dcmon2), 
    .versa_xmp_0_xoa_pma1_dcmon1(versa_xmp_0_xoa_pma1_dcmon1), 
    .versa_xmp_0_xoa_pma1_dcmon2(versa_xmp_0_xoa_pma1_dcmon2), 
    .versa_xmp_0_xoa_pma2_dcmon1(versa_xmp_0_xoa_pma2_dcmon1), 
    .versa_xmp_0_xoa_pma2_dcmon2(versa_xmp_0_xoa_pma2_dcmon2), 
    .versa_xmp_0_xoa_pma3_dcmon1(versa_xmp_0_xoa_pma3_dcmon1), 
    .versa_xmp_0_xoa_pma3_dcmon2(versa_xmp_0_xoa_pma3_dcmon2), 
    .versa_xmp_0_o_ucss_srds_rx_ready_pma0_l0_a(versa_xmp_0_o_ucss_srds_rx_ready_pma0_l0_a), 
    .versa_xmp_0_o_ucss_srds_rx_ready_pma1_l0_a(versa_xmp_0_o_ucss_srds_rx_ready_pma1_l0_a), 
    .versa_xmp_0_o_ucss_srds_rx_ready_pma2_l0_a(versa_xmp_0_o_ucss_srds_rx_ready_pma2_l0_a), 
    .versa_xmp_0_o_ucss_srds_rx_ready_pma3_l0_a(versa_xmp_0_o_ucss_srds_rx_ready_pma3_l0_a), 
    .versa_xmp_0_o_ucss_irq_cpi_0_a(versa_xmp_0_o_ucss_irq_cpi_0_a), 
    .versa_xmp_0_o_ucss_irq_cpi_1_a(versa_xmp_0_o_ucss_irq_cpi_1_a), 
    .versa_xmp_0_o_ucss_irq_cpi_2_a(versa_xmp_0_o_ucss_irq_cpi_2_a), 
    .versa_xmp_0_o_ucss_irq_cpi_3_a(versa_xmp_0_o_ucss_irq_cpi_3_a), 
    .versa_xmp_0_o_ucss_irq_cpi_4_a(versa_xmp_0_o_ucss_irq_cpi_4_a), 
    .versa_xmp_0_o_ucss_irq_status_a(versa_xmp_0_o_ucss_irq_status_a), 
    .physs_lane_reversal_mux_0_sd0_tx_data_o(physs_lane_reversal_mux_0_sd0_tx_data_o), 
    .physs_lane_reversal_mux_0_sd1_tx_data_o(physs_lane_reversal_mux_0_sd1_tx_data_o), 
    .physs_lane_reversal_mux_0_sd2_tx_data_o(physs_lane_reversal_mux_0_sd2_tx_data_o), 
    .physs_lane_reversal_mux_0_sd3_tx_data_o(physs_lane_reversal_mux_0_sd3_tx_data_o), 
    .versa_xmp_0_o_pma0_rxdat_word_l0(versa_xmp_0_o_pma0_rxdat_word_l0), 
    .versa_xmp_0_o_pma1_rxdat_word_l0(versa_xmp_0_o_pma1_rxdat_word_l0), 
    .versa_xmp_0_o_pma2_rxdat_word_l0(versa_xmp_0_o_pma2_rxdat_word_l0), 
    .versa_xmp_0_o_pma3_rxdat_word_l0(versa_xmp_0_o_pma3_rxdat_word_l0), 
    .versa_xmp_0_o_ck_pma0_rxdat_word_l0(versa_xmp_0_o_ck_pma0_rxdat_word_l0), 
    .versa_xmp_0_o_ck_pma1_rxdat_word_l0(versa_xmp_0_o_ck_pma1_rxdat_word_l0), 
    .versa_xmp_0_o_ck_pma2_rxdat_word_l0(versa_xmp_0_o_ck_pma2_rxdat_word_l0), 
    .versa_xmp_0_o_ck_pma3_rxdat_word_l0(versa_xmp_0_o_ck_pma3_rxdat_word_l0), 
    .versa_xmp_0_o_ck_pma0_txdat_word_l0_0(versa_xmp_0_o_ck_pma0_txdat_word_l0_0), 
    .versa_xmp_0_o_ck_pma1_txdat_word_l0_0(versa_xmp_0_o_ck_pma1_txdat_word_l0_0), 
    .versa_xmp_0_o_ck_pma2_txdat_word_l0_0(versa_xmp_0_o_ck_pma2_txdat_word_l0_0), 
    .versa_xmp_0_o_ck_pma3_txdat_word_l0_0(versa_xmp_0_o_ck_pma3_txdat_word_l0_0), 
    .physs0_ioa_ck_pma0_ref_left_mquad0_physs0(physs0_ioa_ck_pma0_ref_left_mquad0_physs0), 
    .physs0_ioa_ck_pma3_ref_right_mquad0_physs0(physs0_ioa_ck_pma3_ref_right_mquad0_physs0), 
    .versa_xmp_0_o_slv_pcs1_apb_paddr(versa_xmp_0_o_slv_pcs1_apb_paddr), 
    .versa_xmp_0_o_slv_pcs1_apb_pprot(versa_xmp_0_o_slv_pcs1_apb_pprot), 
    .versa_xmp_0_o_slv_pcs1_apb_psel(versa_xmp_0_o_slv_pcs1_apb_psel), 
    .versa_xmp_0_o_slv_pcs1_apb_penable(versa_xmp_0_o_slv_pcs1_apb_penable), 
    .versa_xmp_0_o_slv_pcs1_apb_pwrite(versa_xmp_0_o_slv_pcs1_apb_pwrite), 
    .versa_xmp_0_o_slv_pcs1_apb_pwdata(versa_xmp_0_o_slv_pcs1_apb_pwdata), 
    .versa_xmp_0_o_slv_pcs1_apb_pstrb(versa_xmp_0_o_slv_pcs1_apb_pstrb), 
    .apb_to_ahb_sync_0_pready(apb_to_ahb_sync_0_pready), 
    .apb_to_ahb_sync_0_prdata(apb_to_ahb_sync_0_prdata), 
    .apb_to_ahb_sync_0_pslverr(apb_to_ahb_sync_0_pslverr), 
    .physs_clock_sync_0_rst_pma1_por_b_a(physs_clock_sync_0_rst_pma1_por_b_a), 
    .physs_clock_sync_0_rst_pma2_por_b_a(physs_clock_sync_0_rst_pma2_por_b_a), 
    .physs_clock_sync_0_rst_pma3_por_b_a(physs_clock_sync_0_rst_pma3_por_b_a), 
    .physs_lane_reversal_mux_0_link_status_out(physs_lane_reversal_mux_0_link_status_out), 
    .physs_lane_reversal_mux_0_link_status_out_0(physs_lane_reversal_mux_0_link_status_out_0), 
    .physs_lane_reversal_mux_0_link_status_out_1(physs_lane_reversal_mux_0_link_status_out_1), 
    .physs_lane_reversal_mux_0_link_status_out_2(physs_lane_reversal_mux_0_link_status_out_2), 
    .versa_xmp_0_o_ck_pma0_main(versa_xmp_0_o_ck_pma0_main), 
    .versa_xmp_0_o_ck_pma1_main(versa_xmp_0_o_ck_pma1_main), 
    .versa_xmp_0_o_ck_pma2_main(versa_xmp_0_o_ck_pma2_main), 
    .versa_xmp_0_o_ck_pma3_main(versa_xmp_0_o_ck_pma3_main), 
    .versa_xmp_0_o_ck_pma0_ref0_pad2cmos(versa_xmp_0_o_ck_pma0_ref0_pad2cmos), 
    .versa_xmp_0_o_ck_pma1_ref0_pad2cmos(versa_xmp_0_o_ck_pma1_ref0_pad2cmos), 
    .versa_xmp_0_o_ck_pma2_ref0_pad2cmos(versa_xmp_0_o_ck_pma2_ref0_pad2cmos), 
    .versa_xmp_0_o_ck_pma3_ref0_pad2cmos(versa_xmp_0_o_ck_pma3_ref0_pad2cmos), 
    .versa_xmp_0_o_ck_pma0_ref1_pad2cmos(versa_xmp_0_o_ck_pma0_ref1_pad2cmos), 
    .versa_xmp_0_o_ck_pma1_ref1_pad2cmos(versa_xmp_0_o_ck_pma1_ref1_pad2cmos), 
    .versa_xmp_0_o_ck_pma2_ref1_pad2cmos(versa_xmp_0_o_ck_pma2_ref1_pad2cmos), 
    .versa_xmp_0_o_ck_pma3_ref1_pad2cmos(versa_xmp_0_o_ck_pma3_ref1_pad2cmos), 
    .versa_xmp_0_o_ck_pma0_tx_postdiv_l0(versa_xmp_0_o_ck_pma0_tx_postdiv_l0), 
    .versa_xmp_0_o_ck_pma1_tx_postdiv_l0(versa_xmp_0_o_ck_pma1_tx_postdiv_l0), 
    .versa_xmp_0_o_ck_pma2_tx_postdiv_l0(versa_xmp_0_o_ck_pma2_tx_postdiv_l0), 
    .versa_xmp_0_o_ck_pma3_tx_postdiv_l0(versa_xmp_0_o_ck_pma3_tx_postdiv_l0), 
    .versa_xmp_0_o_ck_pma0_cmnplla_postdiv(versa_xmp_0_o_ck_pma0_cmnplla_postdiv), 
    .versa_xmp_0_o_ck_pma0_cmnpllb_postdiv(versa_xmp_0_o_ck_pma0_cmnpllb_postdiv), 
    .versa_xmp_0_o_ck_pma1_cmnplla_postdiv(versa_xmp_0_o_ck_pma1_cmnplla_postdiv), 
    .versa_xmp_0_o_ck_pma1_cmnpllb_postdiv(versa_xmp_0_o_ck_pma1_cmnpllb_postdiv), 
    .versa_xmp_0_o_ck_pma2_cmnplla_postdiv(versa_xmp_0_o_ck_pma2_cmnplla_postdiv), 
    .versa_xmp_0_o_ck_pma2_cmnpllb_postdiv(versa_xmp_0_o_ck_pma2_cmnpllb_postdiv), 
    .versa_xmp_0_o_ck_pma3_cmnplla_postdiv(versa_xmp_0_o_ck_pma3_cmnplla_postdiv), 
    .versa_xmp_0_o_ck_pma3_cmnpllb_postdiv(versa_xmp_0_o_ck_pma3_cmnpllb_postdiv), 
    .versa_xmp_0_o_ck_pma0_txfifolatency_measlatrndtripbit_l0(versa_xmp_0_o_ck_pma0_txfifolatency_measlatrndtripbit_l0), 
    .versa_xmp_0_o_ck_pma1_txfifolatency_measlatrndtripbit_l0(versa_xmp_0_o_ck_pma1_txfifolatency_measlatrndtripbit_l0), 
    .versa_xmp_0_o_ck_pma2_txfifolatency_measlatrndtripbit_l0(versa_xmp_0_o_ck_pma2_txfifolatency_measlatrndtripbit_l0), 
    .versa_xmp_0_o_ck_pma3_txfifolatency_measlatrndtripbit_l0(versa_xmp_0_o_ck_pma3_txfifolatency_measlatrndtripbit_l0)
) ; 
viewpin_wrap_top viewpin_wrap_top (
    .versa_xmp_0_o_ck_pma0_main(versa_xmp_0_o_ck_pma0_main), 
    .versa_xmp_0_o_ck_pma1_main(versa_xmp_0_o_ck_pma1_main), 
    .versa_xmp_0_o_ck_pma2_main(versa_xmp_0_o_ck_pma2_main), 
    .versa_xmp_0_o_ck_pma3_main(versa_xmp_0_o_ck_pma3_main), 
    .versa_xmp_0_o_ck_pma0_ref0_pad2cmos(versa_xmp_0_o_ck_pma0_ref0_pad2cmos), 
    .versa_xmp_0_o_ck_pma1_ref0_pad2cmos(versa_xmp_0_o_ck_pma1_ref0_pad2cmos), 
    .versa_xmp_0_o_ck_pma2_ref0_pad2cmos(versa_xmp_0_o_ck_pma2_ref0_pad2cmos), 
    .versa_xmp_0_o_ck_pma3_ref0_pad2cmos(versa_xmp_0_o_ck_pma3_ref0_pad2cmos), 
    .versa_xmp_0_o_ck_pma0_ref1_pad2cmos(versa_xmp_0_o_ck_pma0_ref1_pad2cmos), 
    .versa_xmp_0_o_ck_pma1_ref1_pad2cmos(versa_xmp_0_o_ck_pma1_ref1_pad2cmos), 
    .versa_xmp_0_o_ck_pma2_ref1_pad2cmos(versa_xmp_0_o_ck_pma2_ref1_pad2cmos), 
    .versa_xmp_0_o_ck_pma3_ref1_pad2cmos(versa_xmp_0_o_ck_pma3_ref1_pad2cmos), 
    .versa_xmp_0_o_ck_pma0_txdat_word_l0(versa_xmp_0_o_ck_pma0_txdat_word_l0_0), 
    .versa_xmp_0_o_ck_pma1_txdat_word_l0(versa_xmp_0_o_ck_pma1_txdat_word_l0_0), 
    .versa_xmp_0_o_ck_pma2_txdat_word_l0(versa_xmp_0_o_ck_pma2_txdat_word_l0_0), 
    .versa_xmp_0_o_ck_pma3_txdat_word_l0(versa_xmp_0_o_ck_pma3_txdat_word_l0_0), 
    .versa_xmp_0_o_ck_pma0_rxdat_word_l0(versa_xmp_0_o_ck_pma0_rxdat_word_l0), 
    .versa_xmp_0_o_ck_pma1_rxdat_word_l0(versa_xmp_0_o_ck_pma1_rxdat_word_l0), 
    .versa_xmp_0_o_ck_pma2_rxdat_word_l0(versa_xmp_0_o_ck_pma2_rxdat_word_l0), 
    .versa_xmp_0_o_ck_pma3_rxdat_word_l0(versa_xmp_0_o_ck_pma3_rxdat_word_l0), 
    .versa_xmp_0_o_ck_pma0_tx_postdiv_l0(versa_xmp_0_o_ck_pma0_tx_postdiv_l0), 
    .versa_xmp_0_o_ck_pma1_tx_postdiv_l0(versa_xmp_0_o_ck_pma1_tx_postdiv_l0), 
    .versa_xmp_0_o_ck_pma2_tx_postdiv_l0(versa_xmp_0_o_ck_pma2_tx_postdiv_l0), 
    .versa_xmp_0_o_ck_pma3_tx_postdiv_l0(versa_xmp_0_o_ck_pma3_tx_postdiv_l0), 
    .versa_xmp_0_o_ck_pma0_rx_postdiv_l0(versa_xmp_0_o_ck_pma0_rx_postdiv_l0), 
    .versa_xmp_0_o_ck_pma1_rx_postdiv_l0(versa_xmp_0_o_ck_pma1_rx_postdiv_l0), 
    .versa_xmp_0_o_ck_pma2_rx_postdiv_l0(versa_xmp_0_o_ck_pma2_rx_postdiv_l0), 
    .versa_xmp_0_o_ck_pma3_rx_postdiv_l0(versa_xmp_0_o_ck_pma3_rx_postdiv_l0), 
    .versa_xmp_0_o_ck_pma0_cmnplla_postdiv(versa_xmp_0_o_ck_pma0_cmnplla_postdiv), 
    .versa_xmp_0_o_ck_pma0_cmnpllb_postdiv(versa_xmp_0_o_ck_pma0_cmnpllb_postdiv), 
    .versa_xmp_0_o_ck_pma1_cmnplla_postdiv(versa_xmp_0_o_ck_pma1_cmnplla_postdiv), 
    .versa_xmp_0_o_ck_pma1_cmnpllb_postdiv(versa_xmp_0_o_ck_pma1_cmnpllb_postdiv), 
    .versa_xmp_0_o_ck_pma2_cmnplla_postdiv(versa_xmp_0_o_ck_pma2_cmnplla_postdiv), 
    .versa_xmp_0_o_ck_pma2_cmnpllb_postdiv(versa_xmp_0_o_ck_pma2_cmnpllb_postdiv), 
    .versa_xmp_0_o_ck_pma3_cmnplla_postdiv(versa_xmp_0_o_ck_pma3_cmnplla_postdiv), 
    .versa_xmp_0_o_ck_pma3_cmnpllb_postdiv(versa_xmp_0_o_ck_pma3_cmnpllb_postdiv), 
    .versa_xmp_0_o_ck_pma0_txfifolatency_measlatrndtripbit_l0(versa_xmp_0_o_ck_pma0_txfifolatency_measlatrndtripbit_l0), 
    .versa_xmp_0_o_ck_pma1_txfifolatency_measlatrndtripbit_l0(versa_xmp_0_o_ck_pma1_txfifolatency_measlatrndtripbit_l0), 
    .versa_xmp_0_o_ck_pma2_txfifolatency_measlatrndtripbit_l0(versa_xmp_0_o_ck_pma2_txfifolatency_measlatrndtripbit_l0), 
    .versa_xmp_0_o_ck_pma3_txfifolatency_measlatrndtripbit_l0(versa_xmp_0_o_ck_pma3_txfifolatency_measlatrndtripbit_l0)
) ; 
apb_v4_to_ahb_bridge apb_to_ahb_sync_0 (
    .clk(soc_per_clk_pdop_parmquad0_clkout), 
    .reset_n(physs_clock_sync_0_func_rstn_fabric_sync), 
    .paddr({8'b0,versa_xmp_0_o_slv_pcs1_apb_paddr}), 
    .pprot(versa_xmp_0_o_slv_pcs1_apb_pprot), 
    .psel(versa_xmp_0_o_slv_pcs1_apb_psel), 
    .penable(versa_xmp_0_o_slv_pcs1_apb_penable), 
    .pwrite(versa_xmp_0_o_slv_pcs1_apb_pwrite), 
    .pwdata(versa_xmp_0_o_slv_pcs1_apb_pwdata), 
    .pstrb(versa_xmp_0_o_slv_pcs1_apb_pstrb), 
    .hreadyout(nic400_quad_0_hreadyout_slave_xmp_if1), 
    .hresp(nic400_quad_0_hresp_slave_xmp_if1), 
    .hrdata(nic400_quad_0_hrdata_slave_xmp_if1), 
    .pready(apb_to_ahb_sync_0_pready), 
    .prdata(apb_to_ahb_sync_0_prdata), 
    .pslverr(apb_to_ahb_sync_0_pslverr), 
    .hsel(apb_to_ahb_sync_0_hsel), 
    .haddr(apb_to_ahb_sync_0_haddr), 
    .hwrite(apb_to_ahb_sync_0_hwrite), 
    .htrans(apb_to_ahb_sync_0_htrans), 
    .hsize(apb_to_ahb_sync_0_hsize), 
    .hburst(apb_to_ahb_sync_0_hburst), 
    .hprot(apb_to_ahb_sync_0_hprot), 
    .hreadyin(apb_to_ahb_sync_0_hreadyin), 
    .hwdata(apb_to_ahb_sync_0_hwdata), 
    .enable_security_check(1'b0), 
    .hmastlock()
) ; 
fifo_mux fifo_mux_0 (
    .mode_select(physs_registers_wrapper_0_pcs_mode_config_fifo_mode_sel), 
    .mac100g_0_rx_ecc_err(mac100_0_ff_rx_err_stat[1]), 
    .mac100g_1_rx_ecc_err(mac100_1_ff_rx_err_stat[1]), 
    .mac100g_2_rx_ecc_err(mac100_2_ff_rx_err_stat[1]), 
    .mac100g_3_rx_ecc_err(mac100_3_ff_rx_err_stat[1]), 
    .mac400g_0_rx_ecc_err(mac200_0_ff_rx_err_stat), 
    .mac400g_1_rx_ecc_err(mac400_0_ff_rx_err_stat), 
    .physs_icq_port_0_link_stat(fifo_mux_0_physs_icq_port_0_link_stat), 
    .physs_mse_port_0_link_speed(fifo_mux_0_physs_mse_port_0_link_speed), 
    .physs_mse_port_0_rx_dval(fifo_mux_0_physs_mse_port_0_rx_dval), 
    .physs_mse_port_0_rx_data(fifo_mux_0_physs_mse_port_0_rx_data), 
    .physs_mse_port_0_rx_sop(fifo_mux_0_physs_mse_port_0_rx_sop), 
    .physs_mse_port_0_rx_eop(fifo_mux_0_physs_mse_port_0_rx_eop), 
    .physs_mse_port_0_rx_mod(fifo_mux_0_physs_mse_port_0_rx_mod), 
    .physs_mse_port_0_rx_err(fifo_mux_0_physs_mse_port_0_rx_err), 
    .physs_mse_port_0_rx_ecc_err(fifo_mux_0_physs_mse_port_0_rx_ecc_err), 
    .mse_physs_port_0_rx_rdy(fifo_top_mux_0_mse_physs_port_0_rx_rdy), 
    .physs_mse_port_0_rx_ts(fifo_mux_0_physs_mse_port_0_rx_ts), 
    .mse_physs_port_0_tx_wren(fifo_top_mux_0_mse_physs_port_0_tx_wren), 
    .mse_physs_port_0_tx_data(fifo_top_mux_0_mse_physs_port_0_tx_data), 
    .mse_physs_port_0_tx_sop(fifo_top_mux_0_mse_physs_port_0_tx_sop), 
    .mse_physs_port_0_tx_eop(fifo_top_mux_0_mse_physs_port_0_tx_eop), 
    .mse_physs_port_0_tx_mod(fifo_top_mux_0_mse_physs_port_0_tx_mod), 
    .mse_physs_port_0_tx_err(fifo_top_mux_0_mse_physs_port_0_tx_err), 
    .mse_physs_port_0_tx_crc(fifo_top_mux_0_mse_physs_port_0_tx_crc), 
    .physs_mse_port_0_tx_rdy(fifo_mux_0_physs_mse_port_0_tx_rdy), 
    .physs_icq_port_1_link_stat(fifo_mux_0_physs_icq_port_1_link_stat), 
    .physs_mse_port_1_link_speed(fifo_mux_0_physs_mse_port_1_link_speed), 
    .physs_mse_port_1_rx_dval(fifo_mux_0_physs_mse_port_1_rx_dval), 
    .physs_mse_port_1_rx_data(fifo_mux_0_physs_mse_port_1_rx_data), 
    .physs_mse_port_1_rx_sop(fifo_mux_0_physs_mse_port_1_rx_sop), 
    .physs_mse_port_1_rx_eop(fifo_mux_0_physs_mse_port_1_rx_eop), 
    .physs_mse_port_1_rx_mod(fifo_mux_0_physs_mse_port_1_rx_mod), 
    .physs_mse_port_1_rx_err(fifo_mux_0_physs_mse_port_1_rx_err), 
    .physs_mse_port_1_rx_ecc_err(fifo_mux_0_physs_mse_port_1_rx_ecc_err), 
    .mse_physs_port_1_rx_rdy(fifo_top_mux_0_mse_physs_port_1_rx_rdy), 
    .physs_mse_port_1_rx_ts(fifo_mux_0_physs_mse_port_1_rx_ts), 
    .mse_physs_port_1_tx_wren(fifo_top_mux_0_mse_physs_port_1_tx_wren), 
    .mse_physs_port_1_tx_data(fifo_top_mux_0_mse_physs_port_1_tx_data), 
    .mse_physs_port_1_tx_sop(fifo_top_mux_0_mse_physs_port_1_tx_sop), 
    .mse_physs_port_1_tx_eop(fifo_top_mux_0_mse_physs_port_1_tx_eop), 
    .mse_physs_port_1_tx_mod(fifo_top_mux_0_mse_physs_port_1_tx_mod), 
    .mse_physs_port_1_tx_err(fifo_top_mux_0_mse_physs_port_1_tx_err), 
    .mse_physs_port_1_tx_crc(fifo_top_mux_0_mse_physs_port_1_tx_crc), 
    .physs_mse_port_1_tx_rdy(fifo_mux_0_physs_mse_port_1_tx_rdy), 
    .physs_icq_port_2_link_stat(fifo_mux_0_physs_icq_port_2_link_stat), 
    .physs_mse_port_2_link_speed(fifo_mux_0_physs_mse_port_2_link_speed), 
    .physs_mse_port_2_rx_dval(fifo_mux_0_physs_mse_port_2_rx_dval), 
    .physs_mse_port_2_rx_data(fifo_mux_0_physs_mse_port_2_rx_data), 
    .physs_mse_port_2_rx_sop(fifo_mux_0_physs_mse_port_2_rx_sop), 
    .physs_mse_port_2_rx_eop(fifo_mux_0_physs_mse_port_2_rx_eop), 
    .physs_mse_port_2_rx_mod(fifo_mux_0_physs_mse_port_2_rx_mod), 
    .physs_mse_port_2_rx_err(fifo_mux_0_physs_mse_port_2_rx_err), 
    .physs_mse_port_2_rx_ecc_err(fifo_mux_0_physs_mse_port_2_rx_ecc_err), 
    .mse_physs_port_2_rx_rdy(fifo_top_mux_0_mse_physs_port_2_rx_rdy), 
    .physs_mse_port_2_rx_ts(fifo_mux_0_physs_mse_port_2_rx_ts), 
    .mse_physs_port_2_tx_wren(fifo_top_mux_0_mse_physs_port_2_tx_wren), 
    .mse_physs_port_2_tx_data(fifo_top_mux_0_mse_physs_port_2_tx_data), 
    .mse_physs_port_2_tx_sop(fifo_top_mux_0_mse_physs_port_2_tx_sop), 
    .mse_physs_port_2_tx_eop(fifo_top_mux_0_mse_physs_port_2_tx_eop), 
    .mse_physs_port_2_tx_mod(fifo_top_mux_0_mse_physs_port_2_tx_mod), 
    .mse_physs_port_2_tx_err(fifo_top_mux_0_mse_physs_port_2_tx_err), 
    .mse_physs_port_2_tx_crc(fifo_top_mux_0_mse_physs_port_2_tx_crc), 
    .physs_mse_port_2_tx_rdy(fifo_mux_0_physs_mse_port_2_tx_rdy), 
    .physs_icq_port_3_link_stat(fifo_mux_0_physs_icq_port_3_link_stat), 
    .physs_mse_port_3_link_speed(fifo_mux_0_physs_mse_port_3_link_speed), 
    .physs_mse_port_3_rx_dval(fifo_mux_0_physs_mse_port_3_rx_dval), 
    .physs_mse_port_3_rx_data(fifo_mux_0_physs_mse_port_3_rx_data), 
    .physs_mse_port_3_rx_sop(fifo_mux_0_physs_mse_port_3_rx_sop), 
    .physs_mse_port_3_rx_eop(fifo_mux_0_physs_mse_port_3_rx_eop), 
    .physs_mse_port_3_rx_mod(fifo_mux_0_physs_mse_port_3_rx_mod), 
    .physs_mse_port_3_rx_err(fifo_mux_0_physs_mse_port_3_rx_err), 
    .physs_mse_port_3_rx_ecc_err(fifo_mux_0_physs_mse_port_3_rx_ecc_err), 
    .mse_physs_port_3_rx_rdy(fifo_top_mux_0_mse_physs_port_3_rx_rdy), 
    .physs_mse_port_3_rx_ts(fifo_mux_0_physs_mse_port_3_rx_ts), 
    .mse_physs_port_3_tx_wren(fifo_top_mux_0_mse_physs_port_3_tx_wren), 
    .mse_physs_port_3_tx_data(fifo_top_mux_0_mse_physs_port_3_tx_data), 
    .mse_physs_port_3_tx_sop(fifo_top_mux_0_mse_physs_port_3_tx_sop), 
    .mse_physs_port_3_tx_eop(fifo_top_mux_0_mse_physs_port_3_tx_eop), 
    .mse_physs_port_3_tx_mod(fifo_top_mux_0_mse_physs_port_3_tx_mod), 
    .mse_physs_port_3_tx_err(fifo_top_mux_0_mse_physs_port_3_tx_err), 
    .mse_physs_port_3_tx_crc(fifo_top_mux_0_mse_physs_port_3_tx_crc), 
    .physs_mse_port_3_tx_rdy(fifo_mux_0_physs_mse_port_3_tx_rdy), 
    .mac100g_0_rx_dval(mac100_0_ff_rx_dval_0), 
    .mac100g_0_rx_data(mac100_0_ff_rx_data), 
    .mac100g_0_rx_sop(mac100_0_ff_rx_sop), 
    .mac100g_0_rx_eop(mac100_0_ff_rx_eop_0), 
    .mac100g_0_rx_mod(mac100_0_ff_rx_mod_0), 
    .mac100g_0_rx_err(mac100_0_ff_rx_err), 
    .mac100g_0_rx_rdy(fifo_mux_0_mac100g_0_rx_rdy), 
    .mac100g_0_rx_ts({mac100_0_ff_rx_ts_0,mac100_0_ff_rx_ts}), 
    .mac100g_0_tx_wren(fifo_mux_0_mac100g_0_tx_wren), 
    .mac100g_0_tx_data(fifo_mux_0_mac100g_0_tx_data), 
    .mac100g_0_tx_sop(fifo_mux_0_mac100g_0_tx_sop), 
    .mac100g_0_tx_eop(fifo_mux_0_mac100g_0_tx_eop), 
    .mac100g_0_tx_mod(fifo_mux_0_mac100g_0_tx_mod), 
    .mac100g_0_tx_err(fifo_mux_0_mac100g_0_tx_err), 
    .mac100g_0_tx_crc(fifo_mux_0_mac100g_0_tx_crc), 
    .mac100g_0_tx_rdy(mac100_0_ff_tx_rdy_0), 
    .mac100g_1_rx_dval(mac100_1_ff_rx_dval_0), 
    .mac100g_1_rx_data(mac100_1_ff_rx_data), 
    .mac100g_1_rx_sop(mac100_1_ff_rx_sop), 
    .mac100g_1_rx_eop(mac100_1_ff_rx_eop_0), 
    .mac100g_1_rx_mod(mac100_1_ff_rx_mod_0), 
    .mac100g_1_rx_err(mac100_1_ff_rx_err), 
    .mac100g_1_rx_rdy(fifo_mux_0_mac100g_1_rx_rdy), 
    .mac100g_1_rx_ts({mac100_1_ff_rx_ts_0,mac100_1_ff_rx_ts}), 
    .mac100g_1_tx_wren(fifo_mux_0_mac100g_1_tx_wren), 
    .mac100g_1_tx_data(fifo_mux_0_mac100g_1_tx_data), 
    .mac100g_1_tx_sop(fifo_mux_0_mac100g_1_tx_sop), 
    .mac100g_1_tx_eop(fifo_mux_0_mac100g_1_tx_eop), 
    .mac100g_1_tx_mod(fifo_mux_0_mac100g_1_tx_mod), 
    .mac100g_1_tx_err(fifo_mux_0_mac100g_1_tx_err), 
    .mac100g_1_tx_crc(fifo_mux_0_mac100g_1_tx_crc), 
    .mac100g_1_tx_rdy(mac100_1_ff_tx_rdy_0), 
    .mac100g_2_rx_dval(mac100_2_ff_rx_dval_0), 
    .mac100g_2_rx_data(mac100_2_ff_rx_data), 
    .mac100g_2_rx_sop(mac100_2_ff_rx_sop), 
    .mac100g_2_rx_eop(mac100_2_ff_rx_eop_0), 
    .mac100g_2_rx_mod(mac100_2_ff_rx_mod_0), 
    .mac100g_2_rx_err(mac100_2_ff_rx_err), 
    .mac100g_2_rx_rdy(fifo_mux_0_mac100g_2_rx_rdy), 
    .mac100g_2_rx_ts({mac100_2_ff_rx_ts_0,mac100_2_ff_rx_ts}), 
    .mac100g_2_tx_wren(fifo_mux_0_mac100g_2_tx_wren), 
    .mac100g_2_tx_data(fifo_mux_0_mac100g_2_tx_data), 
    .mac100g_2_tx_sop(fifo_mux_0_mac100g_2_tx_sop), 
    .mac100g_2_tx_eop(fifo_mux_0_mac100g_2_tx_eop), 
    .mac100g_2_tx_mod(fifo_mux_0_mac100g_2_tx_mod), 
    .mac100g_2_tx_err(fifo_mux_0_mac100g_2_tx_err), 
    .mac100g_2_tx_crc(fifo_mux_0_mac100g_2_tx_crc), 
    .mac100g_2_tx_rdy(mac100_2_ff_tx_rdy_0), 
    .mac100g_3_rx_dval(mac100_3_ff_rx_dval_0), 
    .mac100g_3_rx_data(mac100_3_ff_rx_data), 
    .mac100g_3_rx_sop(mac100_3_ff_rx_sop), 
    .mac100g_3_rx_eop(mac100_3_ff_rx_eop_0), 
    .mac100g_3_rx_mod(mac100_3_ff_rx_mod_0), 
    .mac100g_3_rx_err(mac100_3_ff_rx_err), 
    .mac100g_3_rx_rdy(fifo_mux_0_mac100g_3_rx_rdy), 
    .mac100g_3_rx_ts({mac100_3_ff_rx_ts_0,mac100_3_ff_rx_ts}), 
    .mac100g_3_tx_wren(fifo_mux_0_mac100g_3_tx_wren), 
    .mac100g_3_tx_data(fifo_mux_0_mac100g_3_tx_data), 
    .mac100g_3_tx_sop(fifo_mux_0_mac100g_3_tx_sop), 
    .mac100g_3_tx_eop(fifo_mux_0_mac100g_3_tx_eop), 
    .mac100g_3_tx_mod(fifo_mux_0_mac100g_3_tx_mod), 
    .mac100g_3_tx_err(fifo_mux_0_mac100g_3_tx_err), 
    .mac100g_3_tx_crc(fifo_mux_0_mac100g_3_tx_crc), 
    .mac100g_3_tx_rdy(mac100_3_ff_tx_rdy_0), 
    .mac400g_0_rx_dval(mac400_0_ff_rx_dval), 
    .mac400g_0_rx_data(mac400_0_ff_rx_data), 
    .mac400g_0_rx_sop(mac400_0_ff_rx_sop), 
    .mac400g_0_rx_eop(mac400_0_ff_rx_eop), 
    .mac400g_0_rx_mod(mac400_0_ff_rx_mod), 
    .mac400g_0_rx_err(mac400_0_ff_rx_err), 
    .mac400g_0_rx_rdy(fifo_mux_0_mac400g_0_rx_rdy), 
    .mac400g_0_rx_ts(mac400_0_ff_rx_ts), 
    .mac400g_0_tx_wren(fifo_mux_0_mac400g_0_tx_wren), 
    .mac400g_0_tx_data(fifo_mux_0_mac400g_0_tx_data), 
    .mac400g_0_tx_sop(fifo_mux_0_mac400g_0_tx_sop), 
    .mac400g_0_tx_eop(fifo_mux_0_mac400g_0_tx_eop), 
    .mac400g_0_tx_mod(fifo_mux_0_mac400g_0_tx_mod), 
    .mac400g_0_tx_err(fifo_mux_0_mac400g_0_tx_err), 
    .mac400g_0_tx_crc(fifo_mux_0_mac400g_0_tx_crc), 
    .mac400g_0_tx_rdy(mac400_0_ff_tx_rdy), 
    .mac400g_1_rx_dval(mac200_0_ff_rx_dval), 
    .mac400g_1_rx_data(mac200_0_ff_rx_data), 
    .mac400g_1_rx_sop(mac200_0_ff_rx_sop), 
    .mac400g_1_rx_eop(mac200_0_ff_rx_eop), 
    .mac400g_1_rx_mod(mac200_0_ff_rx_mod), 
    .mac400g_1_rx_err(mac200_0_ff_rx_err), 
    .mac400g_1_rx_rdy(fifo_mux_0_mac400g_1_rx_rdy), 
    .mac400g_1_rx_ts(mac200_0_ff_rx_ts), 
    .mac400g_1_tx_wren(fifo_mux_0_mac400g_1_tx_wren), 
    .mac400g_1_tx_data(fifo_mux_0_mac400g_1_tx_data), 
    .mac400g_1_tx_sop(fifo_mux_0_mac400g_1_tx_sop), 
    .mac400g_1_tx_eop(fifo_mux_0_mac400g_1_tx_eop), 
    .mac400g_1_tx_mod(fifo_mux_0_mac400g_1_tx_mod), 
    .mac400g_1_tx_err(fifo_mux_0_mac400g_1_tx_err), 
    .mac400g_1_tx_crc(fifo_mux_0_mac400g_1_tx_crc), 
    .mac400g_1_tx_rdy(mac200_0_ff_tx_rdy)
) ; 
nic400_quad_top nic400_quad_0 (
    .hclkresetn(physs_clock_sync_0_func_rstn_fabric_sync), 
    .hclkclk(soc_per_clk_pdop_parmquad0_clkout), 
    .hclkclken(1'b1), 
    .hselx_mac100_0(nic400_quad_0_hselx_mac100_0), 
    .haddr_mac100_0_out({hidft_open_0,nic400_quad_0_haddr_mac100_0_out}), 
    .htrans_mac100_0(nic400_quad_0_htrans_mac100_0), 
    .hwrite_mac100_0(nic400_quad_0_hwrite_mac100_0), 
    .hsize_mac100_0(nic400_quad_0_hsize_mac100_0), 
    .hwdata_mac100_0(nic400_quad_0_hwdata_mac100_0), 
    .hready_mac100_0(nic400_quad_0_hready_mac100_0), 
    .hrdata_mac100_0(mac100_ahb_bridge_0_hrdata), 
    .hresp_mac100_0(mac100_ahb_bridge_0_hresp), 
    .hreadyout_mac100_0(mac100_ahb_bridge_0_hreadyout), 
    .hselx_mac100_1(nic400_quad_0_hselx_mac100_1), 
    .haddr_mac100_1_out({hidft_open_1,nic400_quad_0_haddr_mac100_1_out}), 
    .htrans_mac100_1(nic400_quad_0_htrans_mac100_1), 
    .hwrite_mac100_1(nic400_quad_0_hwrite_mac100_1), 
    .hsize_mac100_1(nic400_quad_0_hsize_mac100_1), 
    .hwdata_mac100_1(nic400_quad_0_hwdata_mac100_1), 
    .hready_mac100_1(nic400_quad_0_hready_mac100_1), 
    .hrdata_mac100_1(mac100_ahb_bridge_1_hrdata), 
    .hresp_mac100_1(mac100_ahb_bridge_1_hresp), 
    .hreadyout_mac100_1(mac100_ahb_bridge_1_hreadyout), 
    .hselx_mac100_2(nic400_quad_0_hselx_mac100_2), 
    .haddr_mac100_2_out({hidft_open_2,nic400_quad_0_haddr_mac100_2_out}), 
    .htrans_mac100_2(nic400_quad_0_htrans_mac100_2), 
    .hwrite_mac100_2(nic400_quad_0_hwrite_mac100_2), 
    .hsize_mac100_2(nic400_quad_0_hsize_mac100_2), 
    .hwdata_mac100_2(nic400_quad_0_hwdata_mac100_2), 
    .hready_mac100_2(nic400_quad_0_hready_mac100_2), 
    .hrdata_mac100_2(mac100_ahb_bridge_2_hrdata), 
    .hresp_mac100_2(mac100_ahb_bridge_2_hresp), 
    .hreadyout_mac100_2(mac100_ahb_bridge_2_hreadyout), 
    .hselx_mac100_3(nic400_quad_0_hselx_mac100_3), 
    .haddr_mac100_3_out({hidft_open_3,nic400_quad_0_haddr_mac100_3_out}), 
    .htrans_mac100_3(nic400_quad_0_htrans_mac100_3), 
    .hwrite_mac100_3(nic400_quad_0_hwrite_mac100_3), 
    .hsize_mac100_3(nic400_quad_0_hsize_mac100_3), 
    .hwdata_mac100_3(nic400_quad_0_hwdata_mac100_3), 
    .hready_mac100_3(nic400_quad_0_hready_mac100_3), 
    .hrdata_mac100_3(mac100_ahb_bridge_3_hrdata), 
    .hresp_mac100_3(mac100_ahb_bridge_3_hresp), 
    .hreadyout_mac100_3(mac100_ahb_bridge_3_hreadyout), 
    .hselx_mac100_stats_0(nic400_quad_0_hselx_mac100_stats_0), 
    .haddr_mac100_stats_0_out({hidft_open_4,nic400_quad_0_haddr_mac100_stats_0_out}), 
    .htrans_mac100_stats_0(nic400_quad_0_htrans_mac100_stats_0), 
    .hwrite_mac100_stats_0(nic400_quad_0_hwrite_mac100_stats_0), 
    .hsize_mac100_stats_0(nic400_quad_0_hsize_mac100_stats_0), 
    .hwdata_mac100_stats_0(nic400_quad_0_hwdata_mac100_stats_0), 
    .hready_mac100_stats_0(nic400_quad_0_hready_mac100_stats_0), 
    .hrdata_mac100_stats_0(macstats_ahb_bridge_0_hrdata), 
    .hresp_mac100_stats_0(macstats_ahb_bridge_0_hresp), 
    .hreadyout_mac100_stats_0(macstats_ahb_bridge_0_hreadyout), 
    .hselx_mac100_stats_1(nic400_quad_0_hselx_mac100_stats_1), 
    .haddr_mac100_stats_1_out({hidft_open_5,nic400_quad_0_haddr_mac100_stats_1_out}), 
    .htrans_mac100_stats_1(nic400_quad_0_htrans_mac100_stats_1), 
    .hwrite_mac100_stats_1(nic400_quad_0_hwrite_mac100_stats_1), 
    .hsize_mac100_stats_1(nic400_quad_0_hsize_mac100_stats_1), 
    .hwdata_mac100_stats_1(nic400_quad_0_hwdata_mac100_stats_1), 
    .hready_mac100_stats_1(nic400_quad_0_hready_mac100_stats_1), 
    .hrdata_mac100_stats_1(macstats_ahb_bridge_1_hrdata), 
    .hresp_mac100_stats_1(macstats_ahb_bridge_1_hresp), 
    .hreadyout_mac100_stats_1(macstats_ahb_bridge_1_hreadyout), 
    .hselx_mac100_stats_2(nic400_quad_0_hselx_mac100_stats_2), 
    .haddr_mac100_stats_2_out({hidft_open_6,nic400_quad_0_haddr_mac100_stats_2_out}), 
    .htrans_mac100_stats_2(nic400_quad_0_htrans_mac100_stats_2), 
    .hwrite_mac100_stats_2(nic400_quad_0_hwrite_mac100_stats_2), 
    .hsize_mac100_stats_2(nic400_quad_0_hsize_mac100_stats_2), 
    .hwdata_mac100_stats_2(nic400_quad_0_hwdata_mac100_stats_2), 
    .hready_mac100_stats_2(nic400_quad_0_hready_mac100_stats_2), 
    .hrdata_mac100_stats_2(macstats_ahb_bridge_2_hrdata), 
    .hresp_mac100_stats_2(macstats_ahb_bridge_2_hresp), 
    .hreadyout_mac100_stats_2(macstats_ahb_bridge_2_hreadyout), 
    .hselx_mac100_stats_3(nic400_quad_0_hselx_mac100_stats_3), 
    .haddr_mac100_stats_3_out({hidft_open_7,nic400_quad_0_haddr_mac100_stats_3_out}), 
    .htrans_mac100_stats_3(nic400_quad_0_htrans_mac100_stats_3), 
    .hwrite_mac100_stats_3(nic400_quad_0_hwrite_mac100_stats_3), 
    .hsize_mac100_stats_3(nic400_quad_0_hsize_mac100_stats_3), 
    .hwdata_mac100_stats_3(nic400_quad_0_hwdata_mac100_stats_3), 
    .hready_mac100_stats_3(nic400_quad_0_hready_mac100_stats_3), 
    .hrdata_mac100_stats_3(macstats_ahb_bridge_3_hrdata), 
    .hresp_mac100_stats_3(macstats_ahb_bridge_3_hresp), 
    .hreadyout_mac100_stats_3(macstats_ahb_bridge_3_hreadyout), 
    .hselx_mac400_stats_0(nic400_quad_0_hselx_mac400_stats_0), 
    .haddr_mac400_stats_0_out({hidft_open_8,nic400_quad_0_haddr_mac400_stats_0_out}), 
    .htrans_mac400_stats_0(nic400_quad_0_htrans_mac400_stats_0), 
    .hwrite_mac400_stats_0(nic400_quad_0_hwrite_mac400_stats_0), 
    .hsize_mac400_stats_0(nic400_quad_0_hsize_mac400_stats_0), 
    .hwdata_mac400_stats_0(nic400_quad_0_hwdata_mac400_stats_0), 
    .hready_mac400_stats_0(nic400_quad_0_hready_mac400_stats_0), 
    .hrdata_mac400_stats_0(macstats_ahb_bridge_8_hrdata), 
    .hresp_mac400_stats_0(macstats_ahb_bridge_8_hresp), 
    .hreadyout_mac400_stats_0(macstats_ahb_bridge_8_hreadyout), 
    .hselx_mac400_stats_1(nic400_quad_0_hselx_mac400_stats_1), 
    .haddr_mac400_stats_1_out({hidft_open_9,nic400_quad_0_haddr_mac400_stats_1_out}), 
    .htrans_mac400_stats_1(nic400_quad_0_htrans_mac400_stats_1), 
    .hwrite_mac400_stats_1(nic400_quad_0_hwrite_mac400_stats_1), 
    .hsize_mac400_stats_1(nic400_quad_0_hsize_mac400_stats_1), 
    .hwdata_mac400_stats_1(nic400_quad_0_hwdata_mac400_stats_1), 
    .hready_mac400_stats_1(nic400_quad_0_hready_mac400_stats_1), 
    .hrdata_mac400_stats_1(macstats_ahb_bridge_9_hrdata), 
    .hresp_mac400_stats_1(macstats_ahb_bridge_9_hresp), 
    .hreadyout_mac400_stats_1(macstats_ahb_bridge_9_hreadyout), 
    .hselx_mac400_0(nic400_quad_0_hselx_mac400_0), 
    .haddr_mac400_0_out({hidft_open_10,nic400_quad_0_haddr_mac400_0_out}), 
    .htrans_mac400_0(nic400_quad_0_htrans_mac400_0), 
    .hwrite_mac400_0(nic400_quad_0_hwrite_mac400_0), 
    .hsize_mac400_0(nic400_quad_0_hsize_mac400_0), 
    .hwdata_mac400_0(nic400_quad_0_hwdata_mac400_0), 
    .hready_mac400_0(nic400_quad_0_hready_mac400_0), 
    .hrdata_mac400_0(mac200_ahb_bridge_0_hrdata), 
    .hresp_mac400_0(mac200_ahb_bridge_0_hresp), 
    .hreadyout_mac400_0(mac200_ahb_bridge_0_hreadyout), 
    .hselx_mac400_1(nic400_quad_0_hselx_mac400_1), 
    .haddr_mac400_1_out({hidft_open_11,nic400_quad_0_haddr_mac400_1_out}), 
    .htrans_mac400_1(nic400_quad_0_htrans_mac400_1), 
    .hwrite_mac400_1(nic400_quad_0_hwrite_mac400_1), 
    .hsize_mac400_1(nic400_quad_0_hsize_mac400_1), 
    .hwdata_mac400_1(nic400_quad_0_hwdata_mac400_1), 
    .hready_mac400_1(nic400_quad_0_hready_mac400_1), 
    .hrdata_mac400_1(mac400_ahb_bridge_0_hrdata), 
    .hresp_mac400_1(mac400_ahb_bridge_0_hresp), 
    .hreadyout_mac400_1(mac400_ahb_bridge_0_hreadyout), 
    .hselx_pcs400_0(nic400_quad_0_hselx_pcs400_0), 
    .haddr_pcs400_0_out({hidft_open_12,nic400_quad_0_haddr_pcs400_0_out}), 
    .htrans_pcs400_0(nic400_quad_0_htrans_pcs400_0), 
    .hwrite_pcs400_0(nic400_quad_0_hwrite_pcs400_0), 
    .hsize_pcs400_0(nic400_quad_0_hsize_pcs400_0), 
    .hwdata_pcs400_0(nic400_quad_0_hwdata_pcs400_0), 
    .hready_pcs400_0(nic400_quad_0_hready_pcs400_0), 
    .hrdata_pcs400_0(pcs200_ahb_bridge_0_hrdata), 
    .hresp_pcs400_0(pcs200_ahb_bridge_0_hresp), 
    .hreadyout_pcs400_0(pcs200_ahb_bridge_0_hreadyout), 
    .hselx_rsfec400_0(nic400_quad_0_hselx_rsfec400_0), 
    .haddr_rsfec400_0_out({hidft_open_13,nic400_quad_0_haddr_rsfec400_0_out}), 
    .htrans_rsfec400_0(nic400_quad_0_htrans_rsfec400_0), 
    .hwrite_rsfec400_0(nic400_quad_0_hwrite_rsfec400_0), 
    .hsize_rsfec400_0(nic400_quad_0_hsize_rsfec400_0), 
    .hwdata_rsfec400_0(nic400_quad_0_hwdata_rsfec400_0), 
    .hready_rsfec400_0(nic400_quad_0_hready_rsfec400_0), 
    .hrdata_rsfec400_0(pcs200_ahb_bridge_1_hrdata), 
    .hresp_rsfec400_0(pcs200_ahb_bridge_1_hresp), 
    .hreadyout_rsfec400_0(pcs200_ahb_bridge_1_hreadyout), 
    .hselx_pcs400_1(nic400_quad_0_hselx_pcs400_1), 
    .haddr_pcs400_1_out({hidft_open_14,nic400_quad_0_haddr_pcs400_1_out}), 
    .htrans_pcs400_1(nic400_quad_0_htrans_pcs400_1), 
    .hwrite_pcs400_1(nic400_quad_0_hwrite_pcs400_1), 
    .hsize_pcs400_1(nic400_quad_0_hsize_pcs400_1), 
    .hwdata_pcs400_1(nic400_quad_0_hwdata_pcs400_1), 
    .hready_pcs400_1(nic400_quad_0_hready_pcs400_1), 
    .hrdata_pcs400_1(pcs400_ahb_bridge_0_hrdata), 
    .hresp_pcs400_1(pcs400_ahb_bridge_0_hresp), 
    .hreadyout_pcs400_1(pcs400_ahb_bridge_0_hreadyout), 
    .hselx_rsfec400_1(nic400_quad_0_hselx_rsfec400_1), 
    .haddr_rsfec400_1_out({hidft_open_15,nic400_quad_0_haddr_rsfec400_1_out}), 
    .htrans_rsfec400_1(nic400_quad_0_htrans_rsfec400_1), 
    .hwrite_rsfec400_1(nic400_quad_0_hwrite_rsfec400_1), 
    .hsize_rsfec400_1(nic400_quad_0_hsize_rsfec400_1), 
    .hwdata_rsfec400_1(nic400_quad_0_hwdata_rsfec400_1), 
    .hready_rsfec400_1(nic400_quad_0_hready_rsfec400_1), 
    .hrdata_rsfec400_1(pcs400_ahb_bridge_1_hrdata), 
    .hresp_rsfec400_1(pcs400_ahb_bridge_1_hresp), 
    .hreadyout_rsfec400_1(pcs400_ahb_bridge_1_hreadyout), 
    .haddr_pcs_quad_out(nic400_quad_0_haddr_pcs_quad_out), 
    .htrans_pcs_quad(nic400_quad_0_htrans_pcs_quad), 
    .hburst_pcs_quad(nic400_quad_0_hburst_pcs_quad), 
    .hprot_pcs_quad(nic400_quad_0_hprot_pcs_quad), 
    .hwrite_pcs_quad(nic400_quad_0_hwrite_pcs_quad), 
    .hsize_pcs_quad(nic400_quad_0_hsize_pcs_quad), 
    .hwdata_pcs_quad(nic400_quad_0_hwdata_pcs_quad), 
    .hrdata_pcs_quad(DW_ahb_0_hrdata), 
    .hresp_pcs_quad(DW_ahb_0_hresp), 
    .hreadyout_pcs_quad(DW_ahb_0_hready), 
    .paddr_xmp_out({hidft_open_16,nic400_quad_0_paddr_xmp_out}), 
    .pwdata_xmp(nic400_quad_0_pwdata_xmp), 
    .pwrite_xmp(nic400_quad_0_pwrite_xmp), 
    .pprot_xmp(nic400_quad_0_pprot_xmp), 
    .pstrb_xmp(nic400_quad_0_pstrb_xmp), 
    .penable_xmp(nic400_quad_0_penable_xmp), 
    .pselx_xmp(nic400_quad_0_pselx_xmp), 
    .pready_xmp(versa_xmp_0_o_apb_pready), 
    .prdata_xmp(versa_xmp_0_o_apb_prdata), 
    .pslverr_xmp(versa_xmp_0_o_apb_pslverr), 
    .paddr_common_cfg_out({hidft_open_17,nic400_quad_0_paddr_common_cfg_out}), 
    .pwdata_common_cfg(nic400_quad_0_pwdata_common_cfg), 
    .pwrite_common_cfg(nic400_quad_0_pwrite_common_cfg), 
    .penable_common_cfg(nic400_quad_0_penable_common_cfg), 
    .pselx_common_cfg(nic400_quad_0_pselx_common_cfg), 
    .pready_common_cfg(physs_registers_wrapper_0_o_pready), 
    .prdata_common_cfg(physs_registers_wrapper_0_o_prdata), 
    .pslverr_common_cfg(physs_registers_wrapper_0_o_pslverr), 
    .sip_disable_sel(physs_clock_sync_0_clk_rst_gate_en_100G), 
    .sip_resetn(physs_clock_sync_0_func_rstn_fabric_sync), 
    .awaddr_slave_quad_if0(nic400_physs_0_awaddr_master_quad0_out), 
    .awlen_slave_quad_if0(nic400_physs_0_awlen_master_quad0), 
    .awsize_slave_quad_if0(nic400_physs_0_awsize_master_quad0), 
    .awburst_slave_quad_if0(nic400_physs_0_awburst_master_quad0), 
    .awlock_slave_quad_if0(nic400_physs_0_awlock_master_quad0), 
    .awcache_slave_quad_if0(nic400_physs_0_awcache_master_quad0), 
    .awprot_slave_quad_if0(nic400_physs_0_awprot_master_quad0), 
    .awvalid_slave_quad_if0(nic400_physs_0_awvalid_master_quad0), 
    .awready_slave_quad_if0(nic400_quad_0_awready_slave_quad_if0), 
    .wdata_slave_quad_if0(nic400_physs_0_wdata_master_quad0), 
    .wstrb_slave_quad_if0(nic400_physs_0_wstrb_master_quad0), 
    .wlast_slave_quad_if0(nic400_physs_0_wlast_master_quad0), 
    .wvalid_slave_quad_if0(nic400_physs_0_wvalid_master_quad0), 
    .wready_slave_quad_if0(nic400_quad_0_wready_slave_quad_if0), 
    .bresp_slave_quad_if0(nic400_quad_0_bresp_slave_quad_if0), 
    .bvalid_slave_quad_if0(nic400_quad_0_bvalid_slave_quad_if0), 
    .bready_slave_quad_if0(nic400_physs_0_bready_master_quad0), 
    .araddr_slave_quad_if0(nic400_physs_0_araddr_master_quad0_out), 
    .arlen_slave_quad_if0(nic400_physs_0_arlen_master_quad0), 
    .arsize_slave_quad_if0(nic400_physs_0_arsize_master_quad0), 
    .arburst_slave_quad_if0(nic400_physs_0_arburst_master_quad0), 
    .arlock_slave_quad_if0(nic400_physs_0_arlock_master_quad0), 
    .arcache_slave_quad_if0(nic400_physs_0_arcache_master_quad0), 
    .arprot_slave_quad_if0(nic400_physs_0_arprot_master_quad0), 
    .arvalid_slave_quad_if0(nic400_physs_0_arvalid_master_quad0), 
    .arready_slave_quad_if0(nic400_quad_0_arready_slave_quad_if0), 
    .rdata_slave_quad_if0(nic400_quad_0_rdata_slave_quad_if0), 
    .rresp_slave_quad_if0(nic400_quad_0_rresp_slave_quad_if0), 
    .rlast_slave_quad_if0(nic400_quad_0_rlast_slave_quad_if0), 
    .rvalid_slave_quad_if0(nic400_quad_0_rvalid_slave_quad_if0), 
    .rready_slave_quad_if0(nic400_physs_0_rready_master_quad0), 
    .awid_slave_quad_if0(15'b0), 
    .arid_slave_quad_if0(15'b0), 
    .hreadyout_slave_xmp_if1(nic400_quad_0_hreadyout_slave_xmp_if1), 
    .hresp_slave_xmp_if1(nic400_quad_0_hresp_slave_xmp_if1), 
    .hrdata_slave_xmp_if1(nic400_quad_0_hrdata_slave_xmp_if1), 
    .hselx_slave_xmp_if1(apb_to_ahb_sync_0_hsel), 
    .haddr_slave_xmp_if1(apb_to_ahb_sync_0_haddr), 
    .hwrite_slave_xmp_if1(apb_to_ahb_sync_0_hwrite), 
    .htrans_slave_xmp_if1(apb_to_ahb_sync_0_htrans), 
    .hsize_slave_xmp_if1(apb_to_ahb_sync_0_hsize), 
    .hburst_slave_xmp_if1(apb_to_ahb_sync_0_hburst), 
    .hprot_slave_xmp_if1(apb_to_ahb_sync_0_hprot), 
    .hready_slave_xmp_if1(apb_to_ahb_sync_0_hreadyin), 
    .hwdata_slave_xmp_if1(apb_to_ahb_sync_0_hwdata), 
    .pprot_common_cfg(), 
    .pstrb_common_cfg(), 
    .hburst_mac100_0(), 
    .hprot_mac100_0(), 
    .hburst_mac100_1(), 
    .hprot_mac100_1(), 
    .hburst_mac100_2(), 
    .hprot_mac100_2(), 
    .hburst_mac100_3(), 
    .hprot_mac100_3(), 
    .hburst_mac100_stats_0(), 
    .hprot_mac100_stats_0(), 
    .hburst_mac100_stats_1(), 
    .hprot_mac100_stats_1(), 
    .hburst_mac100_stats_2(), 
    .hprot_mac100_stats_2(), 
    .hburst_mac100_stats_3(), 
    .hprot_mac100_stats_3(), 
    .hburst_mac400_0(), 
    .hprot_mac400_0(), 
    .hburst_mac400_1(), 
    .hprot_mac400_1(), 
    .hburst_mac400_stats_0(), 
    .hprot_mac400_stats_0(), 
    .hburst_mac400_stats_1(), 
    .hprot_mac400_stats_1(), 
    .hburst_pcs400_0(), 
    .hprot_pcs400_0(), 
    .hburst_pcs400_1(), 
    .hprot_pcs400_1(), 
    .hselx_pcs_quad(), 
    .hready_pcs_quad(), 
    .hburst_rsfec400_0(), 
    .hprot_rsfec400_0(), 
    .hburst_rsfec400_1(), 
    .hprot_rsfec400_1(), 
    .hselx_tsu_400_0(), 
    .haddr_tsu_400_0_out(), 
    .htrans_tsu_400_0(), 
    .hwrite_tsu_400_0(), 
    .hsize_tsu_400_0(), 
    .hburst_tsu_400_0(), 
    .hprot_tsu_400_0(), 
    .hwdata_tsu_400_0(), 
    .hrdata_tsu_400_0(32'b0), 
    .hreadyout_tsu_400_0(1'b0), 
    .hready_tsu_400_0(), 
    .hresp_tsu_400_0(1'b0), 
    .hselx_tsu_400_1(), 
    .haddr_tsu_400_1_out(), 
    .htrans_tsu_400_1(), 
    .hwrite_tsu_400_1(), 
    .hsize_tsu_400_1(), 
    .hburst_tsu_400_1(), 
    .hprot_tsu_400_1(), 
    .hwdata_tsu_400_1(), 
    .hrdata_tsu_400_1(32'b0), 
    .hreadyout_tsu_400_1(1'b0), 
    .hready_tsu_400_1(), 
    .hresp_tsu_400_1(1'b0), 
    .bid_slave_quad_if0(), 
    .rid_slave_quad_if0()
) ; 
nic_switch_mux nic_switch_mux_0 (
    .nic_mode(physs_registers_wrapper_0_pcs_mode_config_nic_mode), 
    .hlp_xlgmii0_txclk_ena(nic_switch_mux_0_hlp_xlgmii0_txclk_ena), 
    .hlp_xlgmii0_rxclk_ena(nic_switch_mux_0_hlp_xlgmii0_rxclk_ena), 
    .hlp_xlgmii0_rxc(nic_switch_mux_0_hlp_xlgmii0_rxc), 
    .hlp_xlgmii0_rxd(nic_switch_mux_0_hlp_xlgmii0_rxd), 
    .hlp_xlgmii0_rxt0_next(nic_switch_mux_0_hlp_xlgmii0_rxt0_next), 
    .hlp_xlgmii0_txc(hlp_xlgmii0_txc_0), 
    .hlp_xlgmii0_txd(hlp_xlgmii0_txd_0), 
    .hlp_xlgmii1_txclk_ena(nic_switch_mux_0_hlp_xlgmii1_txclk_ena), 
    .hlp_xlgmii1_rxclk_ena(nic_switch_mux_0_hlp_xlgmii1_rxclk_ena), 
    .hlp_xlgmii1_rxc(nic_switch_mux_0_hlp_xlgmii1_rxc), 
    .hlp_xlgmii1_rxd(nic_switch_mux_0_hlp_xlgmii1_rxd), 
    .hlp_xlgmii1_rxt0_next(nic_switch_mux_0_hlp_xlgmii1_rxt0_next), 
    .hlp_xlgmii1_txc(hlp_xlgmii1_txc_0), 
    .hlp_xlgmii1_txd(hlp_xlgmii1_txd_0), 
    .hlp_xlgmii2_txclk_ena(nic_switch_mux_0_hlp_xlgmii2_txclk_ena), 
    .hlp_xlgmii2_rxclk_ena(nic_switch_mux_0_hlp_xlgmii2_rxclk_ena), 
    .hlp_xlgmii2_rxc(nic_switch_mux_0_hlp_xlgmii2_rxc), 
    .hlp_xlgmii2_rxd(nic_switch_mux_0_hlp_xlgmii2_rxd), 
    .hlp_xlgmii2_rxt0_next(nic_switch_mux_0_hlp_xlgmii2_rxt0_next), 
    .hlp_xlgmii2_txc(hlp_xlgmii2_txc_0), 
    .hlp_xlgmii2_txd(hlp_xlgmii2_txd_0), 
    .hlp_xlgmii3_txclk_ena(nic_switch_mux_0_hlp_xlgmii3_txclk_ena), 
    .hlp_xlgmii3_rxclk_ena(nic_switch_mux_0_hlp_xlgmii3_rxclk_ena), 
    .hlp_xlgmii3_rxc(nic_switch_mux_0_hlp_xlgmii3_rxc), 
    .hlp_xlgmii3_rxd(nic_switch_mux_0_hlp_xlgmii3_rxd), 
    .hlp_xlgmii3_rxt0_next(nic_switch_mux_0_hlp_xlgmii3_rxt0_next), 
    .hlp_xlgmii3_txc(hlp_xlgmii3_txc_0), 
    .hlp_xlgmii3_txd(hlp_xlgmii3_txd_0), 
    .hlp_cgmii0_rxd(nic_switch_mux_0_hlp_cgmii0_rxd), 
    .hlp_cgmii0_rxc(nic_switch_mux_0_hlp_cgmii0_rxc), 
    .hlp_cgmii0_rxclk_ena(nic_switch_mux_0_hlp_cgmii0_rxclk_ena), 
    .hlp_cgmii0_txd(hlp_cgmii0_txd_0), 
    .hlp_cgmii0_txc(hlp_cgmii0_txc_0), 
    .hlp_cgmii0_txclk_ena(nic_switch_mux_0_hlp_cgmii0_txclk_ena), 
    .hlp_cgmii1_rxd(nic_switch_mux_0_hlp_cgmii1_rxd), 
    .hlp_cgmii1_rxc(nic_switch_mux_0_hlp_cgmii1_rxc), 
    .hlp_cgmii1_rxclk_ena(nic_switch_mux_0_hlp_cgmii1_rxclk_ena), 
    .hlp_cgmii1_txd(hlp_cgmii1_txd_0), 
    .hlp_cgmii1_txc(hlp_cgmii1_txc_0), 
    .hlp_cgmii1_txclk_ena(nic_switch_mux_0_hlp_cgmii1_txclk_ena), 
    .hlp_cgmii2_rxd(nic_switch_mux_0_hlp_cgmii2_rxd), 
    .hlp_cgmii2_rxc(nic_switch_mux_0_hlp_cgmii2_rxc), 
    .hlp_cgmii2_rxclk_ena(nic_switch_mux_0_hlp_cgmii2_rxclk_ena), 
    .hlp_cgmii2_txd(hlp_cgmii2_txd_0), 
    .hlp_cgmii2_txc(hlp_cgmii2_txc_0), 
    .hlp_cgmii2_txclk_ena(nic_switch_mux_0_hlp_cgmii2_txclk_ena), 
    .hlp_cgmii3_rxd(nic_switch_mux_0_hlp_cgmii3_rxd), 
    .hlp_cgmii3_rxc(nic_switch_mux_0_hlp_cgmii3_rxc), 
    .hlp_cgmii3_rxclk_ena(nic_switch_mux_0_hlp_cgmii3_rxclk_ena), 
    .hlp_cgmii3_txd(hlp_cgmii3_txd_0), 
    .hlp_cgmii3_txc(hlp_cgmii3_txc_0), 
    .hlp_cgmii3_txclk_ena(nic_switch_mux_0_hlp_cgmii3_txclk_ena), 
    .hlp_xlgmii0_txclk_ena_nss(hlp_xlgmii0_txclk_ena_nss_0), 
    .hlp_xlgmii0_rxclk_ena_nss(hlp_xlgmii0_rxclk_ena_nss_0), 
    .hlp_xlgmii0_rxc_nss(hlp_xlgmii0_rxc_nss_0), 
    .hlp_xlgmii0_rxd_nss(hlp_xlgmii0_rxd_nss_0), 
    .hlp_xlgmii0_rxt0_next_nss(hlp_xlgmii0_rxt0_next_nss_0), 
    .hlp_xlgmii0_txc_nss(nic_switch_mux_0_hlp_xlgmii0_txc_nss), 
    .hlp_xlgmii0_txd_nss(nic_switch_mux_0_hlp_xlgmii0_txd_nss), 
    .hlp_xlgmii1_txclk_ena_nss(hlp_xlgmii1_txclk_ena_nss_0), 
    .hlp_xlgmii1_rxclk_ena_nss(hlp_xlgmii1_rxclk_ena_nss_0), 
    .hlp_xlgmii1_rxc_nss(hlp_xlgmii1_rxc_nss_0), 
    .hlp_xlgmii1_rxd_nss(hlp_xlgmii1_rxd_nss_0), 
    .hlp_xlgmii1_rxt0_next_nss(hlp_xlgmii1_rxt0_next_nss_0), 
    .hlp_xlgmii1_txc_nss(nic_switch_mux_0_hlp_xlgmii1_txc_nss), 
    .hlp_xlgmii1_txd_nss(nic_switch_mux_0_hlp_xlgmii1_txd_nss), 
    .hlp_xlgmii2_txclk_ena_nss(hlp_xlgmii2_txclk_ena_nss_0), 
    .hlp_xlgmii2_rxclk_ena_nss(hlp_xlgmii2_rxclk_ena_nss_0), 
    .hlp_xlgmii2_rxc_nss(hlp_xlgmii2_rxc_nss_0), 
    .hlp_xlgmii2_rxd_nss(hlp_xlgmii2_rxd_nss_0), 
    .hlp_xlgmii2_rxt0_next_nss(hlp_xlgmii2_rxt0_next_nss_0), 
    .hlp_xlgmii2_txc_nss(nic_switch_mux_0_hlp_xlgmii2_txc_nss), 
    .hlp_xlgmii2_txd_nss(nic_switch_mux_0_hlp_xlgmii2_txd_nss), 
    .hlp_xlgmii3_txclk_ena_nss(hlp_xlgmii3_txclk_ena_nss_0), 
    .hlp_xlgmii3_rxclk_ena_nss(hlp_xlgmii3_rxclk_ena_nss_0), 
    .hlp_xlgmii3_rxc_nss(hlp_xlgmii3_rxc_nss_0), 
    .hlp_xlgmii3_rxd_nss(hlp_xlgmii3_rxd_nss_0), 
    .hlp_xlgmii3_rxt0_next_nss(hlp_xlgmii3_rxt0_next_nss_0), 
    .hlp_xlgmii3_txc_nss(nic_switch_mux_0_hlp_xlgmii3_txc_nss), 
    .hlp_xlgmii3_txd_nss(nic_switch_mux_0_hlp_xlgmii3_txd_nss), 
    .hlp_cgmii0_rxd_nss(hlp_cgmii0_rxd_nss_0), 
    .hlp_cgmii0_rxc_nss(hlp_cgmii0_rxc_nss_0), 
    .hlp_cgmii0_rxclk_ena_nss(hlp_cgmii0_rxclk_ena_nss_0), 
    .hlp_cgmii0_txd_nss(nic_switch_mux_0_hlp_cgmii0_txd_nss), 
    .hlp_cgmii0_txc_nss(nic_switch_mux_0_hlp_cgmii0_txc_nss), 
    .hlp_cgmii0_txclk_ena_nss(hlp_cgmii0_txclk_ena_nss_0), 
    .hlp_cgmii1_rxd_nss(hlp_cgmii1_rxd_nss_0), 
    .hlp_cgmii1_rxc_nss(hlp_cgmii1_rxc_nss_0), 
    .hlp_cgmii1_rxclk_ena_nss(hlp_cgmii1_rxclk_ena_nss_0), 
    .hlp_cgmii1_txd_nss(nic_switch_mux_0_hlp_cgmii1_txd_nss), 
    .hlp_cgmii1_txc_nss(nic_switch_mux_0_hlp_cgmii1_txc_nss), 
    .hlp_cgmii1_txclk_ena_nss(hlp_cgmii1_txclk_ena_nss_0), 
    .hlp_cgmii2_rxd_nss(hlp_cgmii2_rxd_nss_0), 
    .hlp_cgmii2_rxc_nss(hlp_cgmii2_rxc_nss_0), 
    .hlp_cgmii2_rxclk_ena_nss(hlp_cgmii2_rxclk_ena_nss_0), 
    .hlp_cgmii2_txd_nss(nic_switch_mux_0_hlp_cgmii2_txd_nss), 
    .hlp_cgmii2_txc_nss(nic_switch_mux_0_hlp_cgmii2_txc_nss), 
    .hlp_cgmii2_txclk_ena_nss(hlp_cgmii2_txclk_ena_nss_0), 
    .hlp_cgmii3_rxd_nss(hlp_cgmii3_rxd_nss_0), 
    .hlp_cgmii3_rxc_nss(hlp_cgmii3_rxc_nss_0), 
    .hlp_cgmii3_rxclk_ena_nss(hlp_cgmii3_rxclk_ena_nss_0), 
    .hlp_cgmii3_txd_nss(nic_switch_mux_0_hlp_cgmii3_txd_nss), 
    .hlp_cgmii3_txc_nss(nic_switch_mux_0_hlp_cgmii3_txc_nss), 
    .hlp_cgmii3_txclk_ena_nss(hlp_cgmii3_txclk_ena_nss_0), 
    .mac_xlgmii0_txclk_ena(nic_switch_mux_0_mac_xlgmii0_txclk_ena), 
    .mac_xlgmii0_rxclk_ena(nic_switch_mux_0_mac_xlgmii0_rxclk_ena), 
    .mac_xlgmii0_rxc(nic_switch_mux_0_mac_xlgmii0_rxc), 
    .mac_xlgmii0_rxd(nic_switch_mux_0_mac_xlgmii0_rxd), 
    .mac_xlgmii0_rxt0_next(nic_switch_mux_0_mac_xlgmii0_rxt0_next), 
    .mac_xlgmii0_txc(mac100_0_xlgmii_txc), 
    .mac_xlgmii0_txd(mac100_0_xlgmii_txd), 
    .mac_xlgmii1_txclk_ena(nic_switch_mux_0_mac_xlgmii1_txclk_ena), 
    .mac_xlgmii1_rxclk_ena(nic_switch_mux_0_mac_xlgmii1_rxclk_ena), 
    .mac_xlgmii1_rxc(nic_switch_mux_0_mac_xlgmii1_rxc), 
    .mac_xlgmii1_rxd(nic_switch_mux_0_mac_xlgmii1_rxd), 
    .mac_xlgmii1_rxt0_next(nic_switch_mux_0_mac_xlgmii1_rxt0_next), 
    .mac_xlgmii1_txc(mac100_1_xlgmii_txc), 
    .mac_xlgmii1_txd(mac100_1_xlgmii_txd), 
    .mac_xlgmii2_txclk_ena(nic_switch_mux_0_mac_xlgmii2_txclk_ena), 
    .mac_xlgmii2_rxclk_ena(nic_switch_mux_0_mac_xlgmii2_rxclk_ena), 
    .mac_xlgmii2_rxc(nic_switch_mux_0_mac_xlgmii2_rxc), 
    .mac_xlgmii2_rxd(nic_switch_mux_0_mac_xlgmii2_rxd), 
    .mac_xlgmii2_rxt0_next(nic_switch_mux_0_mac_xlgmii2_rxt0_next), 
    .mac_xlgmii2_txc(mac100_2_xlgmii_txc), 
    .mac_xlgmii2_txd(mac100_2_xlgmii_txd), 
    .mac_xlgmii3_txclk_ena(nic_switch_mux_0_mac_xlgmii3_txclk_ena), 
    .mac_xlgmii3_rxclk_ena(nic_switch_mux_0_mac_xlgmii3_rxclk_ena), 
    .mac_xlgmii3_rxc(nic_switch_mux_0_mac_xlgmii3_rxc), 
    .mac_xlgmii3_rxd(nic_switch_mux_0_mac_xlgmii3_rxd), 
    .mac_xlgmii3_rxt0_next(nic_switch_mux_0_mac_xlgmii3_rxt0_next), 
    .mac_xlgmii3_txc(mac100_3_xlgmii_txc), 
    .mac_xlgmii3_txd(mac100_3_xlgmii_txd), 
    .mac_cgmii0_rxd(nic_switch_mux_0_mac_cgmii0_rxd), 
    .mac_cgmii0_rxc(nic_switch_mux_0_mac_cgmii0_rxc), 
    .mac_cgmii0_rxclk_ena(nic_switch_mux_0_mac_cgmii0_rxclk_ena), 
    .mac_cgmii0_txd(mac100_0_cgmii_txd), 
    .mac_cgmii0_txc(mac100_0_cgmii_txc), 
    .mac_cgmii0_txclk_ena(nic_switch_mux_0_mac_cgmii0_txclk_ena), 
    .mac_cgmii1_rxd(nic_switch_mux_0_mac_cgmii1_rxd), 
    .mac_cgmii1_rxc(nic_switch_mux_0_mac_cgmii1_rxc), 
    .mac_cgmii1_rxclk_ena(nic_switch_mux_0_mac_cgmii1_rxclk_ena), 
    .mac_cgmii1_txd(mac100_1_cgmii_txd), 
    .mac_cgmii1_txc(mac100_1_cgmii_txc), 
    .mac_cgmii1_txclk_ena(nic_switch_mux_0_mac_cgmii1_txclk_ena), 
    .mac_cgmii2_rxd(nic_switch_mux_0_mac_cgmii2_rxd), 
    .mac_cgmii2_rxc(nic_switch_mux_0_mac_cgmii2_rxc), 
    .mac_cgmii2_rxclk_ena(nic_switch_mux_0_mac_cgmii2_rxclk_ena), 
    .mac_cgmii2_txd(mac100_2_cgmii_txd), 
    .mac_cgmii2_txc(mac100_2_cgmii_txc), 
    .mac_cgmii2_txclk_ena(nic_switch_mux_0_mac_cgmii2_txclk_ena), 
    .mac_cgmii3_rxd(nic_switch_mux_0_mac_cgmii3_rxd), 
    .mac_cgmii3_rxc(nic_switch_mux_0_mac_cgmii3_rxc), 
    .mac_cgmii3_rxclk_ena(nic_switch_mux_0_mac_cgmii3_rxclk_ena), 
    .mac_cgmii3_txd(mac100_3_cgmii_txd), 
    .mac_cgmii3_txc(mac100_3_cgmii_txc), 
    .mac_cgmii3_txclk_ena(nic_switch_mux_0_mac_cgmii3_txclk_ena), 
    .pcs_xlgmii0_txclk_ena(quadpcs100_0_xlgmii0_txclk_ena_0), 
    .pcs_xlgmii0_rxclk_ena(quadpcs100_0_xlgmii0_rxclk_ena_0), 
    .pcs_xlgmii0_rxc(quadpcs100_0_xlgmii0_rxc), 
    .pcs_xlgmii0_rxd(quadpcs100_0_xlgmii0_rxd), 
    .pcs_xlgmii0_rxt0_next(quadpcs100_0_xlgmii0_rxt0_next), 
    .pcs_xlgmii0_txc(nic_switch_mux_0_pcs_xlgmii0_txc), 
    .pcs_xlgmii0_txd(nic_switch_mux_0_pcs_xlgmii0_txd), 
    .pcs_xlgmii1_txclk_ena(quadpcs100_0_xlgmii1_txclk_ena_0), 
    .pcs_xlgmii1_rxclk_ena(quadpcs100_0_xlgmii1_rxclk_ena_0), 
    .pcs_xlgmii1_rxc(quadpcs100_0_xlgmii1_rxc), 
    .pcs_xlgmii1_rxd(quadpcs100_0_xlgmii1_rxd), 
    .pcs_xlgmii1_rxt0_next(quadpcs100_0_xlgmii1_rxt0_next), 
    .pcs_xlgmii1_txc(nic_switch_mux_0_pcs_xlgmii1_txc), 
    .pcs_xlgmii1_txd(nic_switch_mux_0_pcs_xlgmii1_txd), 
    .pcs_xlgmii2_txclk_ena(quadpcs100_0_xlgmii2_txclk_ena_0), 
    .pcs_xlgmii2_rxclk_ena(quadpcs100_0_xlgmii2_rxclk_ena_0), 
    .pcs_xlgmii2_rxc(quadpcs100_0_xlgmii2_rxc), 
    .pcs_xlgmii2_rxd(quadpcs100_0_xlgmii2_rxd), 
    .pcs_xlgmii2_rxt0_next(quadpcs100_0_xlgmii2_rxt0_next), 
    .pcs_xlgmii2_txc(nic_switch_mux_0_pcs_xlgmii2_txc), 
    .pcs_xlgmii2_txd(nic_switch_mux_0_pcs_xlgmii2_txd), 
    .pcs_xlgmii3_txclk_ena(quadpcs100_0_xlgmii3_txclk_ena_0), 
    .pcs_xlgmii3_rxclk_ena(quadpcs100_0_xlgmii3_rxclk_ena_0), 
    .pcs_xlgmii3_rxc(quadpcs100_0_xlgmii3_rxc), 
    .pcs_xlgmii3_rxd(quadpcs100_0_xlgmii3_rxd), 
    .pcs_xlgmii3_rxt0_next(quadpcs100_0_xlgmii3_rxt0_next), 
    .pcs_xlgmii3_txc(nic_switch_mux_0_pcs_xlgmii3_txc), 
    .pcs_xlgmii3_txd(nic_switch_mux_0_pcs_xlgmii3_txd), 
    .pcs_cgmii0_rxd(quadpcs100_0_cgmii0_rxd), 
    .pcs_cgmii0_rxc(quadpcs100_0_cgmii0_rxc), 
    .pcs_cgmii0_rxclk_ena(quadpcs100_0_cgmii0_rxclk_ena_0), 
    .pcs_cgmii0_txd(nic_switch_mux_0_pcs_cgmii0_txd), 
    .pcs_cgmii0_txc(nic_switch_mux_0_pcs_cgmii0_txc), 
    .pcs_cgmii0_txclk_ena(quadpcs100_0_cgmii0_txclk_ena_0), 
    .pcs_cgmii1_rxd(quadpcs100_0_cgmii1_rxd), 
    .pcs_cgmii1_rxc(quadpcs100_0_cgmii1_rxc), 
    .pcs_cgmii1_rxclk_ena(quadpcs100_0_cgmii1_rxclk_ena_0), 
    .pcs_cgmii1_txd(nic_switch_mux_0_pcs_cgmii1_txd), 
    .pcs_cgmii1_txc(nic_switch_mux_0_pcs_cgmii1_txc), 
    .pcs_cgmii1_txclk_ena(quadpcs100_0_cgmii1_txclk_ena_0), 
    .pcs_cgmii2_rxd(quadpcs100_0_cgmii2_rxd), 
    .pcs_cgmii2_rxc(quadpcs100_0_cgmii2_rxc), 
    .pcs_cgmii2_rxclk_ena(quadpcs100_0_cgmii2_rxclk_ena_0), 
    .pcs_cgmii2_txd(nic_switch_mux_0_pcs_cgmii2_txd), 
    .pcs_cgmii2_txc(nic_switch_mux_0_pcs_cgmii2_txc), 
    .pcs_cgmii2_txclk_ena(quadpcs100_0_cgmii2_txclk_ena_0), 
    .pcs_cgmii3_rxd(quadpcs100_0_cgmii3_rxd), 
    .pcs_cgmii3_rxc(quadpcs100_0_cgmii3_rxc), 
    .pcs_cgmii3_rxclk_ena(quadpcs100_0_cgmii3_rxclk_ena_0), 
    .pcs_cgmii3_txd(nic_switch_mux_0_pcs_cgmii3_txd), 
    .pcs_cgmii3_txc(nic_switch_mux_0_pcs_cgmii3_txc), 
    .pcs_cgmii3_txclk_ena(quadpcs100_0_cgmii3_txclk_ena_0), 
    .ts_capture_vld_0(mse_physs_port_0_ts_capture_vld), 
    .ts_capture_id_0(mse_physs_port_0_ts_capture_idx), 
    .mac_ff_tx_ts_frm_0(nic_switch_mux_0_mac_ff_tx_ts_frm_0), 
    .mac_ff_tx_preamble_0(nic_switch_mux_0_mac_ff_tx_preamble_0), 
    .mac_ff_tx_id_0(nic_switch_mux_0_mac_ff_tx_id_0), 
    .ts_capture_vld_1(mse_physs_port_1_ts_capture_vld), 
    .ts_capture_id_1(mse_physs_port_1_ts_capture_idx), 
    .mac_ff_tx_ts_frm_1(nic_switch_mux_0_mac_ff_tx_ts_frm_1), 
    .mac_ff_tx_preamble_1(nic_switch_mux_0_mac_ff_tx_preamble_1), 
    .mac_ff_tx_id_1(nic_switch_mux_0_mac_ff_tx_id_1), 
    .ts_capture_vld_2(mse_physs_port_2_ts_capture_vld), 
    .ts_capture_id_2(mse_physs_port_2_ts_capture_idx), 
    .mac_ff_tx_ts_frm_2(nic_switch_mux_0_mac_ff_tx_ts_frm_2), 
    .mac_ff_tx_preamble_2(nic_switch_mux_0_mac_ff_tx_preamble_2), 
    .mac_ff_tx_id_2(nic_switch_mux_0_mac_ff_tx_id_2), 
    .ts_capture_vld_3(mse_physs_port_3_ts_capture_vld), 
    .ts_capture_id_3(mse_physs_port_3_ts_capture_idx), 
    .mac_ff_tx_ts_frm_3(nic_switch_mux_0_mac_ff_tx_ts_frm_3), 
    .mac_ff_tx_preamble_3(nic_switch_mux_0_mac_ff_tx_preamble_3), 
    .mac_ff_tx_id_3(nic_switch_mux_0_mac_ff_tx_id_3)
) ; 
physs_clock_sync physs_clock_sync_0 (
    .soc_per_clk_divby2(physs_funcby2_clk_pdop_parmquad0_clkout), 
    .func_rstn_fabric_sync(physs_clock_sync_0_func_rstn_fabric_sync), 
    .reset_time_clk_ovveride(4'b0), 
    .xmp_reset_sd_tx_clk(4'b1111), 
    .xmp_reset_sd_rx_clk(4'b1111), 
    .xmp_reset_sd_tx_clk_400G(1'b1), 
    .xmp_reset_sd_rx_clk_400G(1'b1), 
    .xmp_reset_sd_tx_clk_200G(1'b1), 
    .xmp_reset_sd_rx_clk_200G(1'b1), 
    .reset_sd_tx_clk_ovveride(physs_registers_wrapper_0_reset_sd_tx_clk_ovveride), 
    .reset_sd_rx_clk_ovveride(physs_registers_wrapper_0_reset_sd_rx_clk_ovveride), 
    .reset_ref_clk_ovveride(physs_registers_wrapper_0_reset_ref_clk_ovveride), 
    .reset_xpcs_ref_clk_ovveride(physs_registers_wrapper_0_reset_xpcs_ref_clk_ovveride), 
    .reset_f91_ref_clk_ovveride(physs_registers_wrapper_0_reset_f91_ref_clk_ovveride), 
    .reset_gpcs0_ref_clk_ovveride(physs_registers_wrapper_0_reset_gpcs0_ref_clk_ovveride), 
    .reset_gpcs1_ref_clk_ovveride(physs_registers_wrapper_0_reset_gpcs1_ref_clk_ovveride), 
    .reset_gpcs2_ref_clk_ovveride(physs_registers_wrapper_0_reset_gpcs2_ref_clk_ovveride), 
    .reset_gpcs3_ref_clk_ovveride(physs_registers_wrapper_0_reset_gpcs3_ref_clk_ovveride), 
    .reset_reg_clk_ovveride(physs_registers_wrapper_0_reset_reg_clk_ovveride), 
    .reset_reg_ref_clk_ovveride(physs_registers_wrapper_0_reset_reg_ref_clk_ovveride), 
    .reset_cdmii_rxclk_ovveride_200G(physs_registers_wrapper_0_reset_cdmii_rxclk_ovveride_200G), 
    .reset_cdmii_txclk_ovveride_200G(physs_registers_wrapper_0_reset_cdmii_txclk_ovveride_200G), 
    .reset_sd_tx_clk_ovveride_200G(physs_registers_wrapper_0_reset_sd_tx_clk_ovveride_200G), 
    .reset_sd_rx_clk_ovveride_200G(physs_registers_wrapper_0_reset_sd_rx_clk_ovveride_200G), 
    .reset_reg_clk_ovveride_200G(physs_registers_wrapper_0_reset_reg_clk_ovveride_200G), 
    .reset_reg_ref_clk_ovveride_200G(physs_registers_wrapper_0_reset_reg_ref_clk_ovveride_200G), 
    .reset_cdmii_rxclk_ovveride_400G(physs_registers_wrapper_0_reset_cdmii_rxclk_ovveride_400G), 
    .reset_cdmii_txclk_ovveride_400G(physs_registers_wrapper_0_reset_cdmii_txclk_ovveride_400G), 
    .reset_sd_tx_clk_ovveride_400G(physs_registers_wrapper_0_reset_sd_tx_clk_ovveride_400G), 
    .reset_sd_rx_clk_ovveride_400G(physs_registers_wrapper_0_reset_sd_rx_clk_ovveride_400G), 
    .reset_reg_clk_ovveride_400G(physs_registers_wrapper_0_reset_reg_clk_ovveride_400G), 
    .reset_reg_ref_clk_ovveride_400G(physs_registers_wrapper_0_reset_reg_ref_clk_ovveride_400G), 
    .reset_reg_clk_ovveride_mac(physs_registers_wrapper_0_reset_reg_clk_ovveride_mac), 
    .reset_ff_tx_clk_ovveride(physs_registers_wrapper_0_reset_ff_tx_clk_ovveride), 
    .reset_ff_rx_clk_ovveride(physs_registers_wrapper_0_reset_ff_rx_clk_ovveride), 
    .reset_txclk_ovveride(physs_registers_wrapper_0_reset_txclk_ovveride), 
    .reset_rxclk_ovveride(physs_registers_wrapper_0_reset_rxclk_ovveride), 
    .i_rst_apb_b_a_ovveride(physs_registers_wrapper_0_i_rst_apb_b_a_ovveride), 
    .i_rst_ucss_por_b_a_ovveride(physs_registers_wrapper_0_i_rst_ucss_por_b_a_ovveride), 
    .i_rst_pma0_por_b_a_ovveride(physs_registers_wrapper_0_i_rst_pma0_por_b_a_ovveride), 
    .i_rst_pma1_por_b_a_ovveride(physs_registers_wrapper_0_i_rst_pma1_por_b_a_ovveride), 
    .i_rst_pma2_por_b_a_ovveride(physs_registers_wrapper_0_i_rst_pma2_por_b_a_ovveride), 
    .i_rst_pma3_por_b_a_ovveride(physs_registers_wrapper_0_i_rst_pma3_por_b_a_ovveride), 
    .clk_gate_en_100G_mac_pcs(physs_registers_wrapper_0_clk_gate_en_100G_mac_pcs), 
    .clk_gate_en_200G_mac_pcs(physs_registers_wrapper_0_clk_gate_en_200G_mac_pcs), 
    .clk_gate_en_400G_mac_pcs(physs_registers_wrapper_0_clk_gate_en_400G_mac_pcs), 
    .pcs_external_loopback_en(physs_registers_wrapper_0_pcs_mode_config_pcs_external_loopback_en_lane), 
    .pcs_lane_sel(physs_registers_wrapper_0_pcs_mode_config_pcs_mode_sel), 
    .physs_func_clk_gated_100(physs_clock_sync_0_physs_func_clk_gated_100), 
    .physs_ptpmem_wr_clk0(physs_clock_sync_0_physs_ptpmem_wr_clk0), 
    .physs_ptpmem_wr_clk2(physs_clock_sync_0_physs_ptpmem_wr_clk2), 
    .physs_ptpmem_rd_clk0(physs_clock_sync_0_physs_ptpmem_rd_clk0), 
    .physs_ptpmem_rd_clk2(physs_clock_sync_0_physs_ptpmem_rd_clk2), 
    .soc_per_clk_gated_100(physs_clock_sync_0_soc_per_clk_gated_100), 
    .reset_reg_clk_mac({physs_clock_sync_0_reset_reg_clk_mac_4,physs_clock_sync_0_reset_reg_clk_mac_3,physs_clock_sync_0_reset_reg_clk_mac_2,physs_clock_sync_0_reset_reg_clk_mac_1,physs_clock_sync_0_reset_reg_clk_mac_0,physs_clock_sync_0_reset_reg_clk_mac}), 
    .reset_rxclk({physs_clock_sync_0_reset_rxclk_4,physs_clock_sync_0_reset_rxclk_3,physs_clock_sync_0_reset_rxclk_2,physs_clock_sync_0_reset_rxclk_1,physs_clock_sync_0_reset_rxclk_0,physs_clock_sync_0_reset_rxclk}), 
    .soc_per_clk_gated_200(physs_clock_sync_0_soc_per_clk_gated_200), 
    .soc_per_clk_gated_400(physs_clock_sync_0_soc_per_clk_gated_400), 
    .physs_func_clk_gated_200(physs_clock_sync_0_physs_func_clk_gated_200), 
    .physs_func_clk_gated_400(physs_clock_sync_0_physs_func_clk_gated_400), 
    .clk_rst_gate_en_100G(physs_clock_sync_0_clk_rst_gate_en_100G), 
    .rst_apb_b_a(physs_clock_sync_0_rst_apb_b_a), 
    .rst_ucss_por_b_a(physs_clock_sync_0_rst_ucss_por_b_a), 
    .rst_pma0_por_b_a(physs_clock_sync_0_rst_pma0_por_b_a), 
    .soc_per_clk(soc_per_clk_pdop_parmquad0_clkout), 
    .physs_func_clk(physs_func_clk_pdop_parmquad0_clkout), 
    .time_clk(timeref_clk_pdop_parmquad0_clkout), 
    .physs_func_rst_raw_n(physs_func_rst_raw_n), 
    .hip_rst_n(physs_func_rst_raw_n), 
    .reset_ref_clk(physs_clock_sync_0_reset_ref_clk), 
    .reset_txclk({physs_clock_sync_0_reset_txclk,physs_clock_sync_0_reset_txclk_0,physs_clock_sync_0_reset_txclk_4,physs_clock_sync_0_reset_txclk_3,physs_clock_sync_0_reset_txclk_2,physs_clock_sync_0_reset_txclk_1}), 
    .reset_ff_tx_clk({physs_clock_sync_0_reset_ff_tx_clk,physs_clock_sync_0_reset_ff_tx_clk_0,physs_clock_sync_0_reset_ff_tx_clk_4,physs_clock_sync_0_reset_ff_tx_clk_3,physs_clock_sync_0_reset_ff_tx_clk_2,physs_clock_sync_0_reset_ff_tx_clk_1}), 
    .reset_ff_rx_clk({physs_clock_sync_0_reset_ff_rx_clk,physs_clock_sync_0_reset_ff_rx_clk_0,physs_clock_sync_0_reset_ff_rx_clk_4,physs_clock_sync_0_reset_ff_rx_clk_3,physs_clock_sync_0_reset_ff_rx_clk_2,physs_clock_sync_0_reset_ff_rx_clk_1}), 
    .reset_cdmii_rxclk_400G(physs_clock_sync_0_reset_cdmii_rxclk_400G), 
    .reset_cdmii_txclk_400G(physs_clock_sync_0_reset_cdmii_txclk_400G), 
    .reset_sd_tx_clk_400G(physs_clock_sync_0_reset_sd_tx_clk_400G), 
    .reset_sd_rx_clk_400G(physs_clock_sync_0_reset_sd_rx_clk_400G), 
    .reset_reg_ref_clk_400G(physs_clock_sync_0_reset_reg_ref_clk_400G), 
    .reset_reg_clk_400G(physs_clock_sync_0_reset_reg_clk_400G), 
    .reset_cdmii_rxclk_200G(physs_clock_sync_0_reset_cdmii_rxclk_200G), 
    .reset_cdmii_txclk_200G(physs_clock_sync_0_reset_cdmii_txclk_200G), 
    .reset_sd_tx_clk_200G(physs_clock_sync_0_reset_sd_tx_clk_200G), 
    .reset_sd_rx_clk_200G(physs_clock_sync_0_reset_sd_rx_clk_200G), 
    .reset_reg_ref_clk_200G(physs_clock_sync_0_reset_reg_ref_clk_200G), 
    .reset_reg_clk_200G(physs_clock_sync_0_reset_reg_clk_200G), 
    .reset_sd_tx_clk(physs_clock_sync_0_reset_sd_tx_clk), 
    .reset_sd_rx_clk(physs_clock_sync_0_reset_sd_rx_clk), 
    .reset_xpcs_ref_clk(physs_clock_sync_0_reset_xpcs_ref_clk), 
    .reset_f91_ref_clk(physs_clock_sync_0_reset_f91_ref_clk), 
    .reset_gpcs0_ref_clk(physs_clock_sync_0_reset_gpcs0_ref_clk), 
    .reset_gpcs1_ref_clk(physs_clock_sync_0_reset_gpcs1_ref_clk), 
    .reset_gpcs2_ref_clk(physs_clock_sync_0_reset_gpcs2_ref_clk), 
    .reset_gpcs3_ref_clk(physs_clock_sync_0_reset_gpcs3_ref_clk), 
    .reset_reg_ref_clk(physs_clock_sync_0_reset_reg_ref_clk), 
    .reset_reg_clk(physs_clock_sync_0_reset_reg_clk), 
    .time_clk_gated_100(physs_clock_sync_0_time_clk_gated_100), 
    .reset_time_clk_n(physs_clock_sync_0_reset_time_clk_n), 
    .reset_reg_clk_inv(physs_clock_sync_0_reset_reg_clk_inv), 
    .reset_ref_clk_inv(physs_clock_sync_0_reset_ref_clk_inv), 
    .serdes_tx_clk(physs_pcs_mux_0_sd_tx_clk_100G), 
    .serdes_rx_clk(physs_pcs_mux_0_sd_rx_clk_100G), 
    .physs_dfx_fscan_clkungate(1'b0), 
    .fscan_rstbypen(1'b0), 
    .fscan_byprst_b(1'b0), 
    .reset_xmp_ovveride_en(physs_registers_wrapper_0_reset_xmp_ovveride_en), 
    .reset_pcs100_ovveride_en(physs_registers_wrapper_0_reset_pcs100_ovveride_en), 
    .reset_pcs200_ovveride_en(physs_registers_wrapper_0_reset_pcs200_ovveride_en), 
    .reset_pcs400_ovveride_en(physs_registers_wrapper_0_reset_pcs400_ovveride_en), 
    .reset_mac400_ovveride_en(physs_registers_wrapper_0_reset_mac400_ovveride_en), 
    .reset_mac200_ovveride_en(physs_registers_wrapper_0_reset_mac200_ovveride_en), 
    .reset_mac100_ovveride_en(physs_registers_wrapper_0_reset_mac100_ovveride_en), 
    .power_fsm_clk_gate_en(physs_registers_wrapper_0_power_fsm_clk_gate_en), 
    .power_fsm_reset_gate_en(physs_registers_wrapper_0_power_fsm_reset_gate_en), 
    .rst_pma1_por_b_a(physs_clock_sync_0_rst_pma1_por_b_a), 
    .rst_pma2_por_b_a(physs_clock_sync_0_rst_pma2_por_b_a), 
    .rst_pma3_por_b_a(physs_clock_sync_0_rst_pma3_por_b_a), 
    .time_clk_gated_200(), 
    .time_clk_gated_400(), 
    .hip_rstn_fabric_sync()
) ; 
ctech_lib_clk_pdop physs_func_clk_pdop_parmquad0 (
    .clken(1'b1), 
    .clkenfree(1'b1), 
    .scanclk(1'b0), 
    .clkin(physs_func_clk_adop_parmisc_physs0_clkout_0), 
    .clkout(physs_func_clk_pdop_parmquad0_clkout), 
    .clkfree(), 
    .soft_high_out()
) ; 
ctech_lib_clk_pdop rxwordclk_0_pdop_parmquad0 (
    .clken(1'b1), 
    .clkenfree(1'b1), 
    .scanclk(1'b0), 
    .clkin(versa_xmp_0_o_ck_pma0_rxdat_word_l0), 
    .clkout(rxwordclk_0_pdop_parmquad0_clkout), 
    .clkfree(), 
    .soft_high_out()
) ; 
ctech_lib_clk_pdop rxwordclk_1_pdop_parmquad0 (
    .clken(1'b1), 
    .clkenfree(1'b1), 
    .scanclk(1'b0), 
    .clkin(versa_xmp_0_o_ck_pma1_rxdat_word_l0), 
    .clkout(rxwordclk_1_pdop_parmquad0_clkout), 
    .clkfree(), 
    .soft_high_out()
) ; 
ctech_lib_clk_pdop rxwordclk_2_pdop_parmquad0 (
    .clken(1'b1), 
    .clkenfree(1'b1), 
    .scanclk(1'b0), 
    .clkin(versa_xmp_0_o_ck_pma2_rxdat_word_l0), 
    .clkout(rxwordclk_2_pdop_parmquad0_clkout), 
    .clkfree(), 
    .soft_high_out()
) ; 
ctech_lib_clk_pdop rxwordclk_3_pdop_parmquad0 (
    .clken(1'b1), 
    .clkenfree(1'b1), 
    .scanclk(1'b0), 
    .clkin(versa_xmp_0_o_ck_pma3_rxdat_word_l0), 
    .clkout(rxwordclk_3_pdop_parmquad0_clkout), 
    .clkfree(), 
    .soft_high_out()
) ; 
ctech_lib_clk_pdop soc_per_clk_pdop_parmquad0 (
    .clken(1'b1), 
    .clkenfree(1'b1), 
    .scanclk(1'b0), 
    .clkin(soc_per_clk_adop_parmisc_physs0_clkout), 
    .clkout(soc_per_clk_pdop_parmquad0_clkout), 
    .clkfree(), 
    .soft_high_out()
) ; 
ctech_lib_clk_pdop timeref_clk_pdop_parmquad0 (
    .clken(1'b1), 
    .clkenfree(1'b1), 
    .scanclk(1'b0), 
    .clkin(timeref_clk_adop_parmisc_physs0_clkout_0), 
    .clkout(timeref_clk_pdop_parmquad0_clkout), 
    .clkfree(), 
    .soft_high_out()
) ; 
ctech_lib_clk_pdop txwordclk_0_pdop_parmquad0 (
    .clken(1'b1), 
    .clkenfree(1'b1), 
    .scanclk(1'b0), 
    .clkin(versa_xmp_0_o_ck_pma0_txdat_word_l0_0), 
    .clkout(txwordclk_0_pdop_parmquad0_clkout), 
    .clkfree(), 
    .soft_high_out()
) ; 
ctech_lib_clk_pdop txwordclk_1_pdop_parmquad0 (
    .clken(1'b1), 
    .clkenfree(1'b1), 
    .scanclk(1'b0), 
    .clkin(versa_xmp_0_o_ck_pma1_txdat_word_l0_0), 
    .clkout(txwordclk_1_pdop_parmquad0_clkout), 
    .clkfree(), 
    .soft_high_out()
) ; 
ctech_lib_clk_pdop txwordclk_2_pdop_parmquad0 (
    .clken(1'b1), 
    .clkenfree(1'b1), 
    .scanclk(1'b0), 
    .clkin(versa_xmp_0_o_ck_pma2_txdat_word_l0_0), 
    .clkout(txwordclk_2_pdop_parmquad0_clkout), 
    .clkfree(), 
    .soft_high_out()
) ; 
ctech_lib_clk_pdop txwordclk_3_pdop_parmquad0 (
    .clken(1'b1), 
    .clkenfree(1'b1), 
    .scanclk(1'b0), 
    .clkin(versa_xmp_0_o_ck_pma3_txdat_word_l0_0), 
    .clkout(txwordclk_3_pdop_parmquad0_clkout), 
    .clkfree(), 
    .soft_high_out()
) ; 
ctech_lib_clk_pdop_div_by_2 physs_funcby2_clk_pdop_parmquad0 (
    .clken(1'b1), 
    .clkenfree(1'b1), 
    .scanclk(1'b0), 
    .clkdivrst(physs_funcby2rst_inv_parmquad0_o1), 
    .clkin(physs_func_clk_adop_parmisc_physs0_clkout_0), 
    .clkout(physs_funcby2_clk_pdop_parmquad0_clkout), 
    .clkfree(), 
    .soft_high_out()
) ; 
ctech_lib_inv physs_funcby2rst_inv_parmquad0 (
    .o1(physs_funcby2rst_inv_parmquad0_o1), 
    .a(physs_func_rst_raw_n)
) ; 
physs_lane_reversal_mux physs_lane_reversal_mux_0 (
    .pcs_external_loopback_en(physs_registers_wrapper_0_pcs_mode_config_pcs_external_loopback_en_lane), 
    .lane_reversal_mux_sel(physs_registers_wrapper_0_pcs_mode_config_lane_revsersal_mux_quad), 
    .serdes_tx_clk(physs_lane_reversal_mux_0_serdes_tx_clk), 
    .serdes_rx_clk(physs_lane_reversal_mux_0_serdes_rx_clk), 
    .oflux_srds_rdy({versa_xmp_0_o_ucss_srds_rx_ready_pma3_l0_a,versa_xmp_0_o_ucss_srds_rx_ready_pma2_l0_a,versa_xmp_0_o_ucss_srds_rx_ready_pma1_l0_a,versa_xmp_0_o_ucss_srds_rx_ready_pma0_l0_a}), 
    .sd0_tx_data_i(physs_pcs_mux_0_sd0_tx_data_o), 
    .sd1_tx_data_i(physs_pcs_mux_0_sd1_tx_data_o), 
    .sd2_tx_data_i(physs_pcs_mux_0_sd2_tx_data_o), 
    .sd3_tx_data_i(physs_pcs_mux_0_sd3_tx_data_o), 
    .sd0_rx_data_o(physs_lane_reversal_mux_0_sd0_rx_data_o), 
    .sd1_rx_data_o(physs_lane_reversal_mux_0_sd1_rx_data_o), 
    .sd2_rx_data_o(physs_lane_reversal_mux_0_sd2_rx_data_o), 
    .sd3_rx_data_o(physs_lane_reversal_mux_0_sd3_rx_data_o), 
    .link_status_in(physs_pcs_mux_0_link_status_out), 
    .oflux_srds_rdy_out(physs_lane_reversal_mux_0_oflux_srds_rdy_out), 
    .sd0_tx_data_o(physs_lane_reversal_mux_0_sd0_tx_data_o), 
    .sd1_tx_data_o(physs_lane_reversal_mux_0_sd1_tx_data_o), 
    .sd2_tx_data_o(physs_lane_reversal_mux_0_sd2_tx_data_o), 
    .sd3_tx_data_o(physs_lane_reversal_mux_0_sd3_tx_data_o), 
    .sd0_rx_in_serdes(versa_xmp_0_o_pma0_rxdat_word_l0), 
    .sd1_rx_in_serdes(versa_xmp_0_o_pma1_rxdat_word_l0), 
    .sd2_rx_in_serdes(versa_xmp_0_o_pma2_rxdat_word_l0), 
    .sd3_rx_in_serdes(versa_xmp_0_o_pma3_rxdat_word_l0), 
    .serdes_rx_clk_in({rxwordclk_3_pdop_parmquad0_clkout,rxwordclk_2_pdop_parmquad0_clkout,rxwordclk_1_pdop_parmquad0_clkout,rxwordclk_0_pdop_parmquad0_clkout}), 
    .serdes_tx_clk_in({txwordclk_3_pdop_parmquad0_clkout,txwordclk_2_pdop_parmquad0_clkout,txwordclk_1_pdop_parmquad0_clkout,txwordclk_0_pdop_parmquad0_clkout}), 
    .sg_link_status(4'b0), 
    .fscan_mode(1'b0), 
    .oflux_srds_rdy_ovr0(physs_registers_wrapper_0_oflux_srds_rdy_ovr0), 
    .oflux_srds_rdy_ovr1(physs_registers_wrapper_0_oflux_srds_rdy_ovr1), 
    .oflux_srds_rdy_ovr2(physs_registers_wrapper_0_oflux_srds_rdy_ovr2), 
    .oflux_srds_rdy_ovr3(physs_registers_wrapper_0_oflux_srds_rdy_ovr3), 
    .oflux_srds_rdy_ovr_en0(physs_registers_wrapper_0_oflux_srds_rdy_ovr_en0), 
    .oflux_srds_rdy_ovr_en1(physs_registers_wrapper_0_oflux_srds_rdy_ovr_en1), 
    .oflux_srds_rdy_ovr_en2(physs_registers_wrapper_0_oflux_srds_rdy_ovr_en2), 
    .oflux_srds_rdy_ovr_en3(physs_registers_wrapper_0_oflux_srds_rdy_ovr_en3), 
    .link_status_out({physs_lane_reversal_mux_0_link_status_out_2,physs_lane_reversal_mux_0_link_status_out_1,physs_lane_reversal_mux_0_link_status_out_0,physs_lane_reversal_mux_0_link_status_out})
) ; 
physs_pcs_mux physs_pcs_mux_0 (
    .clk_gate_en_100G_mac_pcs(physs_registers_wrapper_0_clk_gate_en_100G_mac_pcs), 
    .clk_gate_en_200G_mac_pcs(physs_registers_wrapper_0_clk_gate_en_200G_mac_pcs), 
    .clk_gate_en_400G_mac_pcs(physs_registers_wrapper_0_clk_gate_en_400G_mac_pcs), 
    .pcs_external_loopback_en(physs_registers_wrapper_0_pcs_mode_config_pcs_external_loopback_en_lane), 
    .pcs_lane_sel(physs_registers_wrapper_0_pcs_mode_config_pcs_mode_sel), 
    .cpri_sel(4'b0), 
    .mac100_tx_ts_val({mac100_3_tx_ts_val,mac100_2_tx_ts_val,mac100_1_tx_ts_val,mac100_0_tx_ts_val}), 
    .mac100_tx_ts_id_0(mac100_0_tx_ts_id), 
    .mac100_tx_ts_0(mac100_0_tx_ts), 
    .mac100_tx_ts_id_1(mac100_1_tx_ts_id), 
    .mac100_tx_ts_1(mac100_1_tx_ts), 
    .mac100_tx_ts_id_2(mac100_2_tx_ts_id), 
    .mac100_tx_ts_2(mac100_2_tx_ts), 
    .mac100_tx_ts_id_3(mac100_3_tx_ts_id), 
    .mac100_tx_ts_3(mac100_3_tx_ts), 
    .tx_ts_val({physs_pcs_mux_0_tx_ts_val_2,physs_pcs_mux_0_tx_ts_val_1,physs_pcs_mux_0_tx_ts_val_0,physs_pcs_mux_0_tx_ts_val}), 
    .tx_ts_id_0(physs_pcs_mux_0_tx_ts_id_0), 
    .tx_ts_0({physs_pcs_mux_0_tx_ts_0_0,hidft_open_18,physs_pcs_mux_0_tx_ts_0}), 
    .mac200_tx_ts_val(mac200_0_tx_ts_val), 
    .mac200_tx_ts_id({3'b0,mac200_0_tx_ts_id}), 
    .mac200_tx_ts({8'b0,mac200_0_tx_ts}), 
    .mac400_tx_ts_val(mac400_0_tx_ts_val), 
    .mac400_tx_ts_id({3'b0,mac400_0_tx_ts_id}), 
    .mac400_tx_ts({8'b0,mac400_0_tx_ts}), 
    .tx_ts_id_1(physs_pcs_mux_0_tx_ts_id_1), 
    .tx_ts_1({physs_pcs_mux_0_tx_ts_1_0,hidft_open_19,physs_pcs_mux_0_tx_ts_1}), 
    .tx_ts_id_2(physs_pcs_mux_0_tx_ts_id_2), 
    .tx_ts_2({physs_pcs_mux_0_tx_ts_2_0,hidft_open_20,physs_pcs_mux_0_tx_ts_2}), 
    .tx_ts_id_3(physs_pcs_mux_0_tx_ts_id_3), 
    .tx_ts_3({physs_pcs_mux_0_tx_ts_3_0,hidft_open_21,physs_pcs_mux_0_tx_ts_3}), 
    .sd0_tx_in_400G(pcs400_0_sd0_tx), 
    .sd1_tx_in_400G(pcs400_0_sd1_tx), 
    .sd2_tx_in_400G(pcs400_0_sd2_tx), 
    .sd3_tx_in_400G(pcs400_0_sd3_tx), 
    .sd4_tx_in_400G(pcs400_0_sd4_tx), 
    .sd5_tx_in_400G(pcs400_0_sd5_tx), 
    .sd6_tx_in_400G(pcs400_0_sd6_tx), 
    .sd7_tx_in_400G(pcs400_0_sd7_tx), 
    .sd8_tx_in_400G(pcs400_0_sd8_tx), 
    .sd9_tx_in_400G(pcs400_0_sd9_tx), 
    .sd10_tx_in_400G(pcs400_0_sd10_tx), 
    .sd11_tx_in_400G(pcs400_0_sd11_tx), 
    .sd12_tx_in_400G(pcs400_0_sd12_tx), 
    .sd13_tx_in_400G(pcs400_0_sd13_tx), 
    .sd14_tx_in_400G(pcs400_0_sd14_tx), 
    .sd15_tx_in_400G(pcs400_0_sd15_tx), 
    .sd0_rx_data_400G_o(physs_pcs_mux_0_sd0_rx_data_400G_o), 
    .sd1_rx_data_400G_o(physs_pcs_mux_0_sd1_rx_data_400G_o), 
    .sd2_rx_data_400G_o(physs_pcs_mux_0_sd2_rx_data_400G_o), 
    .sd3_rx_data_400G_o(physs_pcs_mux_0_sd3_rx_data_400G_o), 
    .sd4_rx_data_400G_o(physs_pcs_mux_0_sd4_rx_data_400G_o), 
    .sd5_rx_data_400G_o(physs_pcs_mux_0_sd5_rx_data_400G_o), 
    .sd6_rx_data_400G_o(physs_pcs_mux_0_sd6_rx_data_400G_o), 
    .sd7_rx_data_400G_o(physs_pcs_mux_0_sd7_rx_data_400G_o), 
    .sd8_rx_data_400G_o(physs_pcs_mux_0_sd8_rx_data_400G_o), 
    .sd9_rx_data_400G_o(physs_pcs_mux_0_sd9_rx_data_400G_o), 
    .sd10_rx_data_400G_o(physs_pcs_mux_0_sd10_rx_data_400G_o), 
    .sd11_rx_data_400G_o(physs_pcs_mux_0_sd11_rx_data_400G_o), 
    .sd12_rx_data_400G_o(physs_pcs_mux_0_sd12_rx_data_400G_o), 
    .sd13_rx_data_400G_o(physs_pcs_mux_0_sd13_rx_data_400G_o), 
    .sd14_rx_data_400G_o(physs_pcs_mux_0_sd14_rx_data_400G_o), 
    .sd15_rx_data_400G_o(physs_pcs_mux_0_sd15_rx_data_400G_o), 
    .sd0_tx_in_200G(pcs200_0_sd0_tx), 
    .sd1_tx_in_200G(pcs200_0_sd1_tx), 
    .sd2_tx_in_200G(pcs200_0_sd2_tx), 
    .sd3_tx_in_200G(pcs200_0_sd3_tx), 
    .sd4_tx_in_200G(pcs200_0_sd4_tx), 
    .sd5_tx_in_200G(pcs200_0_sd5_tx), 
    .sd6_tx_in_200G(pcs200_0_sd6_tx), 
    .sd7_tx_in_200G(pcs200_0_sd7_tx), 
    .sd0_rx_data_o({physs_pcs_mux_0_sd0_rx_data_o_0[127:32],physs_pcs_mux_0_sd0_rx_data_o}), 
    .sd1_rx_data_o({physs_pcs_mux_0_sd1_rx_data_o_0[127:32],physs_pcs_mux_0_sd1_rx_data_o}), 
    .sd2_rx_data_o({physs_pcs_mux_0_sd2_rx_data_o_0[127:32],physs_pcs_mux_0_sd2_rx_data_o}), 
    .sd3_rx_data_o({physs_pcs_mux_0_sd3_rx_data_o_0[127:32],physs_pcs_mux_0_sd3_rx_data_o}), 
    .sd4_rx_data_o(physs_pcs_mux_0_sd4_rx_data_o), 
    .sd5_rx_data_o(physs_pcs_mux_0_sd5_rx_data_o), 
    .sd6_rx_data_o(physs_pcs_mux_0_sd6_rx_data_o), 
    .sd7_rx_data_o(physs_pcs_mux_0_sd7_rx_data_o), 
    .sd0_tx_in_100G(quadpcs100_0_sd0_tx), 
    .sd1_tx_in_100G(quadpcs100_0_sd1_tx), 
    .sd2_tx_in_100G(quadpcs100_0_sd2_tx), 
    .sd3_tx_in_100G(quadpcs100_0_sd3_tx), 
    .sd0_tx_data_o(physs_pcs_mux_0_sd0_tx_data_o), 
    .sd1_tx_data_o(physs_pcs_mux_0_sd1_tx_data_o), 
    .sd2_tx_data_o(physs_pcs_mux_0_sd2_tx_data_o), 
    .sd3_tx_data_o(physs_pcs_mux_0_sd3_tx_data_o), 
    .sd0_rx_in_serdes(physs_lane_reversal_mux_0_sd0_rx_data_o), 
    .sd1_rx_in_serdes(physs_lane_reversal_mux_0_sd1_rx_data_o), 
    .sd2_rx_in_serdes(physs_lane_reversal_mux_0_sd2_rx_data_o), 
    .sd3_rx_in_serdes(physs_lane_reversal_mux_0_sd3_rx_data_o), 
    .serdes_rx_clk(physs_lane_reversal_mux_0_serdes_rx_clk), 
    .serdes_tx_clk(physs_lane_reversal_mux_0_serdes_tx_clk), 
    .link_status_out(physs_pcs_mux_0_link_status_out), 
    .serdes_rdy_in(physs_lane_reversal_mux_0_oflux_srds_rdy_out), 
    .link_status_100G(quadpcs100_0_pcs_link_status), 
    .link_status_200G(pcs200_0_link_status), 
    .link_status_400G(pcs400_0_link_status), 
    .srds_rdy_out_100G(physs_pcs_mux_0_srds_rdy_out_100G), 
    .srds_rdy_out_200G(physs_pcs_mux_0_srds_rdy_out_200G), 
    .srds_rdy_out_400G(physs_pcs_mux_0_srds_rdy_out_400G), 
    .sd_tx_clk_100G(physs_pcs_mux_0_sd_tx_clk_100G), 
    .sd_rx_clk_100G(physs_pcs_mux_0_sd_rx_clk_100G), 
    .sd0_tx_clk_200G(physs_pcs_mux_0_sd0_tx_clk_200G), 
    .sd2_tx_clk_200G(physs_pcs_mux_0_sd2_tx_clk_200G), 
    .sd4_tx_clk_200G(physs_pcs_mux_0_sd4_tx_clk_200G), 
    .sd6_tx_clk_200G(physs_pcs_mux_0_sd6_tx_clk_200G), 
    .sd8_tx_clk_200G(physs_pcs_mux_0_sd8_tx_clk_200G), 
    .sd10_tx_clk_200G(physs_pcs_mux_0_sd10_tx_clk_200G), 
    .sd12_tx_clk_200G(physs_pcs_mux_0_sd12_tx_clk_200G), 
    .sd14_tx_clk_200G(physs_pcs_mux_0_sd14_tx_clk_200G), 
    .sd0_rx_clk_200G(physs_pcs_mux_0_sd0_rx_clk_200G), 
    .sd1_rx_clk_200G(physs_pcs_mux_0_sd1_rx_clk_200G), 
    .sd2_rx_clk_200G(physs_pcs_mux_0_sd2_rx_clk_200G), 
    .sd3_rx_clk_200G(physs_pcs_mux_0_sd3_rx_clk_200G), 
    .sd4_rx_clk_200G(physs_pcs_mux_0_sd4_rx_clk_200G), 
    .sd5_rx_clk_200G(physs_pcs_mux_0_sd5_rx_clk_200G), 
    .sd6_rx_clk_200G(physs_pcs_mux_0_sd6_rx_clk_200G), 
    .sd7_rx_clk_200G(physs_pcs_mux_0_sd7_rx_clk_200G), 
    .sd8_rx_clk_200G(physs_pcs_mux_0_sd8_rx_clk_200G), 
    .sd9_rx_clk_200G(physs_pcs_mux_0_sd9_rx_clk_200G), 
    .sd10_rx_clk_200G(physs_pcs_mux_0_sd10_rx_clk_200G), 
    .sd11_rx_clk_200G(physs_pcs_mux_0_sd11_rx_clk_200G), 
    .sd12_rx_clk_200G(physs_pcs_mux_0_sd12_rx_clk_200G), 
    .sd13_rx_clk_200G(physs_pcs_mux_0_sd13_rx_clk_200G), 
    .sd14_rx_clk_200G(physs_pcs_mux_0_sd14_rx_clk_200G), 
    .sd15_rx_clk_200G(physs_pcs_mux_0_sd15_rx_clk_200G), 
    .sd0_tx_clk_400G(physs_pcs_mux_0_sd0_tx_clk_400G), 
    .sd2_tx_clk_400G(physs_pcs_mux_0_sd2_tx_clk_400G), 
    .sd4_tx_clk_400G(physs_pcs_mux_0_sd4_tx_clk_400G), 
    .sd6_tx_clk_400G(physs_pcs_mux_0_sd6_tx_clk_400G), 
    .sd8_tx_clk_400G(physs_pcs_mux_0_sd8_tx_clk_400G), 
    .sd10_tx_clk_400G(physs_pcs_mux_0_sd10_tx_clk_400G), 
    .sd12_tx_clk_400G(physs_pcs_mux_0_sd12_tx_clk_400G), 
    .sd14_tx_clk_400G(physs_pcs_mux_0_sd14_tx_clk_400G), 
    .sd0_rx_clk_400G(physs_pcs_mux_0_sd0_rx_clk_400G), 
    .sd1_rx_clk_400G(physs_pcs_mux_0_sd1_rx_clk_400G), 
    .sd2_rx_clk_400G(physs_pcs_mux_0_sd2_rx_clk_400G), 
    .sd3_rx_clk_400G(physs_pcs_mux_0_sd3_rx_clk_400G), 
    .sd4_rx_clk_400G(physs_pcs_mux_0_sd4_rx_clk_400G), 
    .sd5_rx_clk_400G(physs_pcs_mux_0_sd5_rx_clk_400G), 
    .sd6_rx_clk_400G(physs_pcs_mux_0_sd6_rx_clk_400G), 
    .sd7_rx_clk_400G(physs_pcs_mux_0_sd7_rx_clk_400G), 
    .sd8_rx_clk_400G(physs_pcs_mux_0_sd8_rx_clk_400G), 
    .sd9_rx_clk_400G(physs_pcs_mux_0_sd9_rx_clk_400G), 
    .sd10_rx_clk_400G(physs_pcs_mux_0_sd10_rx_clk_400G), 
    .sd11_rx_clk_400G(physs_pcs_mux_0_sd11_rx_clk_400G), 
    .sd12_rx_clk_400G(physs_pcs_mux_0_sd12_rx_clk_400G), 
    .sd13_rx_clk_400G(physs_pcs_mux_0_sd13_rx_clk_400G), 
    .sd14_rx_clk_400G(physs_pcs_mux_0_sd14_rx_clk_400G), 
    .sd15_rx_clk_400G(physs_pcs_mux_0_sd15_rx_clk_400G), 
    .fscan_mode(1'b0), 
    .physs_dfx_fscan_clkungate(1'b0), 
    .power_fsm_clk_gate_en(physs_registers_wrapper_0_power_fsm_clk_gate_en), 
    .sd_tx_clk_cpri(), 
    .sd_rx_clk_cpri()
) ; 
physs_registers_wrapper physs_registers_wrapper_0 (
    .i_paddr(nic400_quad_0_paddr_common_cfg_out), 
    .i_pwdata(nic400_quad_0_pwdata_common_cfg), 
    .i_pwrite(nic400_quad_0_pwrite_common_cfg), 
    .i_penable(nic400_quad_0_penable_common_cfg), 
    .i_psel(nic400_quad_0_pselx_common_cfg), 
    .o_pready(physs_registers_wrapper_0_o_pready), 
    .o_prdata(physs_registers_wrapper_0_o_prdata), 
    .o_pslverr(physs_registers_wrapper_0_o_pslverr), 
    .i_reg_clk(soc_per_clk_pdop_parmquad0_clkout), 
    .i_reg_reset_n(physs_func_rst_raw_n), 
    .reset_sd_tx_clk_ovveride(physs_registers_wrapper_0_reset_sd_tx_clk_ovveride), 
    .reset_sd_rx_clk_ovveride(physs_registers_wrapper_0_reset_sd_rx_clk_ovveride), 
    .reset_ref_clk_ovveride(physs_registers_wrapper_0_reset_ref_clk_ovveride), 
    .reset_xpcs_ref_clk_ovveride(physs_registers_wrapper_0_reset_xpcs_ref_clk_ovveride), 
    .reset_f91_ref_clk_ovveride(physs_registers_wrapper_0_reset_f91_ref_clk_ovveride), 
    .reset_gpcs0_ref_clk_ovveride(physs_registers_wrapper_0_reset_gpcs0_ref_clk_ovveride), 
    .reset_gpcs1_ref_clk_ovveride(physs_registers_wrapper_0_reset_gpcs1_ref_clk_ovveride), 
    .reset_gpcs2_ref_clk_ovveride(physs_registers_wrapper_0_reset_gpcs2_ref_clk_ovveride), 
    .reset_gpcs3_ref_clk_ovveride(physs_registers_wrapper_0_reset_gpcs3_ref_clk_ovveride), 
    .reset_reg_clk_ovveride(physs_registers_wrapper_0_reset_reg_clk_ovveride), 
    .reset_reg_ref_clk_ovveride(physs_registers_wrapper_0_reset_reg_ref_clk_ovveride), 
    .reset_cdmii_rxclk_ovveride_200G(physs_registers_wrapper_0_reset_cdmii_rxclk_ovveride_200G), 
    .reset_cdmii_txclk_ovveride_200G(physs_registers_wrapper_0_reset_cdmii_txclk_ovveride_200G), 
    .reset_sd_tx_clk_ovveride_200G(physs_registers_wrapper_0_reset_sd_tx_clk_ovveride_200G), 
    .reset_sd_rx_clk_ovveride_200G(physs_registers_wrapper_0_reset_sd_rx_clk_ovveride_200G), 
    .reset_reg_clk_ovveride_200G(physs_registers_wrapper_0_reset_reg_clk_ovveride_200G), 
    .reset_reg_ref_clk_ovveride_200G(physs_registers_wrapper_0_reset_reg_ref_clk_ovveride_200G), 
    .reset_cdmii_rxclk_ovveride_400G(physs_registers_wrapper_0_reset_cdmii_rxclk_ovveride_400G), 
    .reset_cdmii_txclk_ovveride_400G(physs_registers_wrapper_0_reset_cdmii_txclk_ovveride_400G), 
    .reset_sd_tx_clk_ovveride_400G(physs_registers_wrapper_0_reset_sd_tx_clk_ovveride_400G), 
    .reset_sd_rx_clk_ovveride_400G(physs_registers_wrapper_0_reset_sd_rx_clk_ovveride_400G), 
    .reset_reg_clk_ovveride_400G(physs_registers_wrapper_0_reset_reg_clk_ovveride_400G), 
    .reset_reg_ref_clk_ovveride_400G(physs_registers_wrapper_0_reset_reg_ref_clk_ovveride_400G), 
    .reset_reg_clk_ovveride_mac(physs_registers_wrapper_0_reset_reg_clk_ovveride_mac), 
    .reset_ff_tx_clk_ovveride(physs_registers_wrapper_0_reset_ff_tx_clk_ovveride), 
    .reset_ff_rx_clk_ovveride(physs_registers_wrapper_0_reset_ff_rx_clk_ovveride), 
    .reset_txclk_ovveride(physs_registers_wrapper_0_reset_txclk_ovveride), 
    .reset_rxclk_ovveride(physs_registers_wrapper_0_reset_rxclk_ovveride), 
    .i_rst_apb_b_a_ovveride(physs_registers_wrapper_0_i_rst_apb_b_a_ovveride), 
    .i_rst_ucss_por_b_a_ovveride(physs_registers_wrapper_0_i_rst_ucss_por_b_a_ovveride), 
    .i_rst_pma0_por_b_a_ovveride(physs_registers_wrapper_0_i_rst_pma0_por_b_a_ovveride), 
    .i_rst_pma1_por_b_a_ovveride(physs_registers_wrapper_0_i_rst_pma1_por_b_a_ovveride), 
    .i_rst_pma2_por_b_a_ovveride(physs_registers_wrapper_0_i_rst_pma2_por_b_a_ovveride), 
    .i_rst_pma3_por_b_a_ovveride(physs_registers_wrapper_0_i_rst_pma3_por_b_a_ovveride), 
    .clk_gate_en_100G_mac_pcs(physs_registers_wrapper_0_clk_gate_en_100G_mac_pcs), 
    .clk_gate_en_200G_mac_pcs(physs_registers_wrapper_0_clk_gate_en_200G_mac_pcs), 
    .clk_gate_en_400G_mac_pcs(physs_registers_wrapper_0_clk_gate_en_400G_mac_pcs), 
    .mac100_config_0_cfg_mode128(physs_registers_wrapper_0_mac100_config_0_cfg_mode128), 
    .mac100_config_1_cfg_mode128(physs_registers_wrapper_0_mac100_config_1_cfg_mode128), 
    .mac100_config_2_cfg_mode128(physs_registers_wrapper_0_mac100_config_2_cfg_mode128), 
    .mac100_config_3_cfg_mode128(physs_registers_wrapper_0_mac100_config_3_cfg_mode128), 
    .pcs100_sgmii0_reg_sg0_sgpcs_ena(physs_registers_wrapper_0_pcs100_sgmii0_reg_sg0_sgpcs_ena), 
    .pcs100_sgmii1_reg_sg0_sgpcs_ena(physs_registers_wrapper_0_pcs100_sgmii1_reg_sg0_sgpcs_ena), 
    .pcs100_sgmii2_reg_sg0_sgpcs_ena(physs_registers_wrapper_0_pcs100_sgmii2_reg_sg0_sgpcs_ena), 
    .pcs100_sgmii3_reg_sg0_sgpcs_ena(physs_registers_wrapper_0_pcs100_sgmii3_reg_sg0_sgpcs_ena), 
    .deskew_rlevel_0(quadpcs100_0_pcs_desk_buf_rlevel), 
    .deskew_rlevel_1(quadpcs100_0_pcs_desk_buf_rlevel_0), 
    .deskew_rlevel_2(quadpcs100_0_pcs_desk_buf_rlevel_1), 
    .deskew_rlevel_3(quadpcs100_0_pcs_desk_buf_rlevel_2), 
    .mac100_0_ff_rx_err_stat(mac100_0_ff_rx_err_stat), 
    .mac100_1_ff_rx_err_stat(mac100_1_ff_rx_err_stat), 
    .mac100_2_ff_rx_err_stat(mac100_2_ff_rx_err_stat), 
    .mac100_3_ff_rx_err_stat(mac100_3_ff_rx_err_stat), 
    .mac100_0_ff_rx_err(mac100_0_ff_rx_err), 
    .mac100_1_ff_rx_err(mac100_1_ff_rx_err), 
    .mac100_2_ff_rx_err(mac100_2_ff_rx_err), 
    .mac100_3_ff_rx_err(mac100_3_ff_rx_err), 
    .mac0_mdio_oen(mac100_0_mdio_oen), 
    .mac1_mdio_oen(mac100_1_mdio_oen), 
    .mac2_mdio_oen(mac100_2_mdio_oen), 
    .mac3_mdio_oen(mac100_3_mdio_oen), 
    .mac0_pause_on(mac100_0_pause_on), 
    .mac1_pause_on(mac100_1_pause_on), 
    .mac2_pause_on(mac100_2_pause_on), 
    .mac3_pause_on(mac100_3_pause_on), 
    .mac0_li_fault(mac100_0_li_fault), 
    .mac1_li_fault(mac100_1_li_fault), 
    .mac2_li_fault(mac100_2_li_fault), 
    .mac3_li_fault(mac100_3_li_fault), 
    .mac0_rem_fault(mac100_0_rem_fault), 
    .mac1_rem_fault(mac100_1_rem_fault), 
    .mac2_rem_fault(mac100_2_rem_fault), 
    .mac3_rem_fault(mac100_3_rem_fault), 
    .mac0_loc_fault(mac100_0_loc_fault), 
    .mac1_loc_fault(mac100_1_loc_fault), 
    .mac2_loc_fault(mac100_2_loc_fault), 
    .mac3_loc_fault(mac100_3_loc_fault), 
    .mac0_ff_tx_empty(mac100_0_tx_empty), 
    .mac1_ff_tx_empty(mac100_1_tx_empty), 
    .mac2_ff_tx_empty(mac100_2_tx_empty), 
    .mac3_ff_tx_empty(mac100_3_tx_empty), 
    .mac0_ff_rx_empty(mac100_0_ff_rx_empty), 
    .mac1_ff_rx_empty(mac100_1_ff_rx_empty), 
    .mac2_ff_rx_empty(mac100_2_ff_rx_empty), 
    .mac3_ff_rx_empty(mac100_3_ff_rx_empty), 
    .mac0_tx_isidle(mac100_0_tx_isidle), 
    .mac1_tx_isidle(mac100_1_tx_isidle), 
    .mac2_tx_isidle(mac100_2_tx_isidle), 
    .mac3_tx_isidle(mac100_3_tx_isidle), 
    .mac0_ff_tx_septy(mac100_0_ff_tx_septy), 
    .mac1_ff_tx_septy(mac100_1_ff_tx_septy), 
    .mac2_ff_tx_septy(mac100_2_ff_tx_septy), 
    .mac3_ff_tx_septy(mac100_3_ff_tx_septy), 
    .mac0_tx_underflow(mac100_0_tx_underflow), 
    .mac1_tx_underflow(mac100_1_tx_underflow), 
    .mac2_tx_underflow(mac100_2_tx_underflow), 
    .mac3_tx_underflow(mac100_3_tx_underflow), 
    .mac0_ff_tx_ovr(mac100_0_ff_tx_ovr), 
    .mac1_ff_tx_ovr(mac100_1_ff_tx_ovr), 
    .mac2_ff_tx_ovr(mac100_2_ff_tx_ovr), 
    .mac3_ff_tx_ovr(mac100_3_ff_tx_ovr), 
    .mac0_magic_ind(mac100_0_magic_ind), 
    .mac1_magic_ind(mac100_1_magic_ind), 
    .mac2_magic_ind(mac100_2_magic_ind), 
    .mac3_magic_ind(mac100_3_magic_ind), 
    .mac200_pause_on(mac200_0_pause_on), 
    .mac400_pause_on(mac400_0_pause_on), 
    .mac200_li_fault(mac200_0_li_fault), 
    .mac400_li_fault(mac400_0_li_fault), 
    .mac200_rem_fault(mac200_0_rem_fault), 
    .mac400_rem_fault(mac400_0_rem_fault), 
    .mac200_loc_fault(mac200_0_loc_fault), 
    .mac400_loc_fault(mac400_0_loc_fault), 
    .mac200_ff_tx_empty(mac200_0_tx_empty), 
    .mac400_ff_tx_empty(mac400_0_tx_empty), 
    .mac200_ff_rx_empty(mac200_0_ff_rx_empty), 
    .mac400_ff_rx_empty(mac400_0_ff_rx_empty), 
    .mac200_tx_isidle(mac200_0_tx_isidle), 
    .mac400_tx_isidle(mac400_0_tx_isidle), 
    .mac200_ff_tx_septy(mac200_0_ff_tx_septy), 
    .mac400_ff_tx_septy(mac400_0_ff_tx_septy), 
    .mac200_tx_underflow(mac200_0_tx_underflow), 
    .mac400_tx_underflow(mac400_0_tx_underflow), 
    .mac200_tx_ovr_err(mac200_0_tx_ovr_err), 
    .mac400_tx_ovr_err(mac400_0_tx_ovr_err), 
    .pcs_fec_locked({quadpcs100_0_pcs1_fec_locked,quadpcs100_0_pcs0_fec_locked}), 
    .pcs_fec_ncerr({quadpcs100_0_pcs1_fec_ncerr,quadpcs100_0_pcs0_fec_ncerr}), 
    .pcs_fec_cerr({quadpcs100_0_pcs1_fec_cerr,quadpcs100_0_pcs0_fec_cerr}), 
    .sg0_hd(quadpcs100_0_sg0_hd), 
    .sg0_speed(quadpcs100_0_sg0_speed), 
    .sg0_page_rx(quadpcs100_0_sg0_page_rx), 
    .sg0_an_done(quadpcs100_0_sg0_an_done), 
    .sg0_rx_sync(quadpcs100_0_sg0_rx_sync), 
    .sg1_hd(quadpcs100_0_sg1_hd), 
    .sg1_speed(quadpcs100_0_sg1_speed), 
    .sg1_page_rx(quadpcs100_0_sg1_page_rx), 
    .sg1_an_done(quadpcs100_0_sg1_an_done), 
    .sg1_rx_sync(quadpcs100_0_sg1_rx_sync), 
    .sg2_hd(quadpcs100_0_sg2_hd), 
    .sg2_speed(quadpcs100_0_sg2_speed), 
    .sg2_page_rx(quadpcs100_0_sg2_page_rx), 
    .sg2_an_done(quadpcs100_0_sg2_an_done), 
    .sg2_rx_sync(quadpcs100_0_sg2_rx_sync), 
    .sg3_hd(quadpcs100_0_sg3_hd), 
    .sg3_speed(quadpcs100_0_sg3_speed), 
    .sg3_page_rx(quadpcs100_0_sg3_page_rx), 
    .sg3_an_done(quadpcs100_0_sg3_an_done), 
    .sg3_rx_sync(quadpcs100_0_sg3_rx_sync), 
    .pcs_mac0_res_speed(quadpcs100_0_pcs_mac0_res_speed), 
    .pcs_mac1_res_speed(quadpcs100_0_pcs_mac1_res_speed), 
    .pcs_mac2_res_speed(quadpcs100_0_pcs_mac2_res_speed), 
    .pcs_mac3_res_speed(quadpcs100_0_pcs_mac3_res_speed), 
    .pcs0_rsfec_aligned(quadpcs100_0_pcs_rsfec_aligned), 
    .pcs0_amps_lock(quadpcs100_0_pcs_amps_lock), 
    .pcs0_align_done(quadpcs100_0_pcs_align_done), 
    .pcs_link_status(quadpcs100_0_pcs_link_status), 
    .pcs_hi_ber(quadpcs100_0_pcs_hi_ber), 
    .usxgmii0_an_pability(quadpcs100_0_usxgmii0_an_pability), 
    .usxgmii0_an_pability_done(quadpcs100_0_usxgmii0_an_pability_done), 
    .usxgmii0_an_busy(quadpcs100_0_usxgmii0_an_busy), 
    .usxgmii1_an_pability(quadpcs100_0_usxgmii1_an_pability), 
    .usxgmii1_an_pability_done(quadpcs100_0_usxgmii1_an_pability_done), 
    .usxgmii1_an_busy(quadpcs100_0_usxgmii1_an_busy), 
    .usxgmii2_an_pability(quadpcs100_0_usxgmii2_an_pability), 
    .usxgmii2_an_pability_done(quadpcs100_0_usxgmii2_an_pability_done), 
    .usxgmii2_an_busy(quadpcs100_0_usxgmii2_an_busy), 
    .usxgmii3_an_pability(quadpcs100_0_usxgmii3_an_pability), 
    .usxgmii3_an_pability_done(quadpcs100_0_usxgmii3_an_pability_done), 
    .usxgmii3_an_busy(quadpcs100_0_usxgmii3_an_busy), 
    .pcs200_rx_am_sf(pcs200_0_rx_am_sf), 
    .pcs200_degrade_ser(pcs200_0_degrade_ser), 
    .pcs200_hi_ser(pcs200_0_hi_ser), 
    .pcs200_link_status(pcs200_0_link_status), 
    .pcs200_amps_lock(pcs200_0_amps_lock), 
    .pcs200_align_lock(pcs200_0_align_lock), 
    .pcs400_rx_am_sf(pcs400_0_rx_am_sf), 
    .pcs400_degrade_ser(pcs400_0_degrade_ser), 
    .pcs400_hi_ser(pcs400_0_hi_ser), 
    .pcs400_link_status(pcs400_0_link_status), 
    .pcs400_amps_lock(pcs400_0_amps_lock), 
    .pcs400_align_lock(pcs400_0_align_lock), 
    .mac100_config_0_cfg_write64(physs_registers_wrapper_0_mac100_config_0_cfg_write64), 
    .mac100_config_1_cfg_write64(physs_registers_wrapper_0_mac100_config_1_cfg_write64), 
    .mac100_config_2_cfg_write64(physs_registers_wrapper_0_mac100_config_2_cfg_write64), 
    .mac100_config_3_cfg_write64(physs_registers_wrapper_0_mac100_config_3_cfg_write64), 
    .pcs100_sgmii0_reg_sg0_tx_lane_thresh(physs_registers_wrapper_0_pcs100_sgmii0_reg_sg0_tx_lane_thresh), 
    .pcs100_sgmii0_reg_sg0_sg_tx_lane_ckmult(physs_registers_wrapper_0_pcs100_sgmii0_reg_sg0_sg_tx_lane_ckmult), 
    .pcs100_sgmii0_reg_sg0_mode_br_dis(physs_registers_wrapper_0_pcs100_sgmii0_reg_sg0_mode_br_dis), 
    .pcs100_sgmii0_reg_sg0_seq_ena(physs_registers_wrapper_0_pcs100_sgmii0_reg_sg0_seq_ena), 
    .pcs100_sgmii0_reg_sg0_mode_sync(physs_registers_wrapper_0_pcs100_sgmii0_reg_sg0_mode_sync), 
    .pcs100_sgmii1_reg_sg0_tx_lane_thresh(physs_registers_wrapper_0_pcs100_sgmii1_reg_sg0_tx_lane_thresh), 
    .pcs100_sgmii1_reg_sg0_sg_tx_lane_ckmult(physs_registers_wrapper_0_pcs100_sgmii1_reg_sg0_sg_tx_lane_ckmult), 
    .pcs100_sgmii1_reg_sg0_mode_br_dis(physs_registers_wrapper_0_pcs100_sgmii1_reg_sg0_mode_br_dis), 
    .pcs100_sgmii1_reg_sg0_seq_ena(physs_registers_wrapper_0_pcs100_sgmii1_reg_sg0_seq_ena), 
    .pcs100_sgmii1_reg_sg0_mode_sync(physs_registers_wrapper_0_pcs100_sgmii1_reg_sg0_mode_sync), 
    .pcs100_sgmii2_reg_sg0_tx_lane_thresh(physs_registers_wrapper_0_pcs100_sgmii2_reg_sg0_tx_lane_thresh), 
    .pcs100_sgmii2_reg_sg0_sg_tx_lane_ckmult(physs_registers_wrapper_0_pcs100_sgmii2_reg_sg0_sg_tx_lane_ckmult), 
    .pcs100_sgmii2_reg_sg0_mode_br_dis(physs_registers_wrapper_0_pcs100_sgmii2_reg_sg0_mode_br_dis), 
    .pcs100_sgmii2_reg_sg0_seq_ena(physs_registers_wrapper_0_pcs100_sgmii2_reg_sg0_seq_ena), 
    .pcs100_sgmii2_reg_sg0_mode_sync(physs_registers_wrapper_0_pcs100_sgmii2_reg_sg0_mode_sync), 
    .pcs100_sgmii3_reg_sg0_tx_lane_thresh(physs_registers_wrapper_0_pcs100_sgmii3_reg_sg0_tx_lane_thresh), 
    .pcs100_sgmii3_reg_sg0_sg_tx_lane_ckmult(physs_registers_wrapper_0_pcs100_sgmii3_reg_sg0_sg_tx_lane_ckmult), 
    .pcs100_sgmii3_reg_sg0_mode_br_dis(physs_registers_wrapper_0_pcs100_sgmii3_reg_sg0_mode_br_dis), 
    .pcs100_sgmii3_reg_sg0_seq_ena(physs_registers_wrapper_0_pcs100_sgmii3_reg_sg0_seq_ena), 
    .pcs100_sgmii3_reg_sg0_mode_sync(physs_registers_wrapper_0_pcs100_sgmii3_reg_sg0_mode_sync), 
    .pcs100_status_1_pcs_block_lock(quadpcs100_0_pcs_block_lock), 
    .pcs100_usxgmii0_config_usxgmii0_link_status(quadpcs100_0_pcs_link_status[0]), 
    .pcs100_usxgmii0_config_usxgmii0_conf_speed_tx_2_5(physs_registers_wrapper_0_pcs100_usxgmii0_config_usxgmii0_conf_speed_tx_2_5), 
    .pcs100_usxgmii0_config_usxgmii0_conf_speed_rx_2_5(physs_registers_wrapper_0_pcs100_usxgmii0_config_usxgmii0_conf_speed_rx_2_5), 
    .pcs100_usxgmii0_config_usxgmii0_conf_speed_tx(physs_registers_wrapper_0_pcs100_usxgmii0_config_usxgmii0_conf_speed_tx), 
    .pcs100_usxgmii0_config_usxgmii0_conf_speed_rx(physs_registers_wrapper_0_pcs100_usxgmii0_config_usxgmii0_conf_speed_rx), 
    .pcs100_usxgmii1_config_usxgmii1_link_status(quadpcs100_0_pcs_link_status[1]), 
    .pcs100_usxgmii1_config_usxgmii1_conf_speed_tx_2_5(physs_registers_wrapper_0_pcs100_usxgmii1_config_usxgmii1_conf_speed_tx_2_5), 
    .pcs100_usxgmii1_config_usxgmii1_conf_speed_rx_2_5(physs_registers_wrapper_0_pcs100_usxgmii1_config_usxgmii1_conf_speed_rx_2_5), 
    .pcs100_usxgmii1_config_usxgmii1_conf_speed_tx(physs_registers_wrapper_0_pcs100_usxgmii1_config_usxgmii1_conf_speed_tx), 
    .pcs100_usxgmii1_config_usxgmii1_conf_speed_rx(physs_registers_wrapper_0_pcs100_usxgmii1_config_usxgmii1_conf_speed_rx), 
    .pcs100_usxgmii2_config_usxgmii2_link_status(quadpcs100_0_pcs_link_status[2]), 
    .pcs100_usxgmii2_config_usxgmii2_conf_speed_tx_2_5(physs_registers_wrapper_0_pcs100_usxgmii2_config_usxgmii2_conf_speed_tx_2_5), 
    .pcs100_usxgmii2_config_usxgmii2_conf_speed_rx_2_5(physs_registers_wrapper_0_pcs100_usxgmii2_config_usxgmii2_conf_speed_rx_2_5), 
    .pcs100_usxgmii2_config_usxgmii2_conf_speed_tx(physs_registers_wrapper_0_pcs100_usxgmii2_config_usxgmii2_conf_speed_tx), 
    .pcs100_usxgmii2_config_usxgmii2_conf_speed_rx(physs_registers_wrapper_0_pcs100_usxgmii2_config_usxgmii2_conf_speed_rx), 
    .pcs100_usxgmii3_config_usxgmii3_link_status(quadpcs100_0_pcs_link_status[3]), 
    .pcs100_usxgmii3_config_usxgmii3_conf_speed_tx_2_5(physs_registers_wrapper_0_pcs100_usxgmii3_config_usxgmii3_conf_speed_tx_2_5), 
    .pcs100_usxgmii3_config_usxgmii3_conf_speed_rx_2_5(physs_registers_wrapper_0_pcs100_usxgmii3_config_usxgmii3_conf_speed_rx_2_5), 
    .pcs100_usxgmii3_config_usxgmii3_conf_speed_tx(physs_registers_wrapper_0_pcs100_usxgmii3_config_usxgmii3_conf_speed_tx), 
    .pcs100_usxgmii3_config_usxgmii3_conf_speed_rx(physs_registers_wrapper_0_pcs100_usxgmii3_config_usxgmii3_conf_speed_rx), 
    .pcs200_reg_tx_am_sf(physs_registers_wrapper_0_pcs200_reg_tx_am_sf), 
    .pcs200_reg_rsfec_mode_ll(physs_registers_wrapper_0_pcs200_reg_rsfec_mode_ll), 
    .pcs200_reg_sd_4x_en(physs_registers_wrapper_0_pcs200_reg_sd_4x_en), 
    .pcs200_reg_sd_8x_en(physs_registers_wrapper_0_pcs200_reg_sd_8x_en), 
    .pcs400_reg_tx_am_sf(physs_registers_wrapper_0_pcs400_reg_tx_am_sf), 
    .pcs400_reg_rsfec_mode_ll(physs_registers_wrapper_0_pcs400_reg_rsfec_mode_ll), 
    .pcs400_reg_sd_4x_en(physs_registers_wrapper_0_pcs400_reg_sd_4x_en), 
    .pcs400_reg_sd_8x_en(physs_registers_wrapper_0_pcs400_reg_sd_8x_en), 
    .pcs100_config0_pcs_sd_n2({physs_registers_wrapper_0_pcs100_config0_pcs_sd_n2_0,physs_registers_wrapper_0_pcs100_config0_pcs_sd_n2}), 
    .pcs100_config0_pcs_sd_8x({physs_registers_wrapper_0_pcs100_config0_pcs_sd_8x_0,physs_registers_wrapper_0_pcs100_config0_pcs_sd_8x}), 
    .pcs100_config0_pcs_kp_mode_in({physs_registers_wrapper_0_pcs100_config0_pcs_kp_mode_in_0,physs_registers_wrapper_0_pcs100_config0_pcs_kp_mode_in}), 
    .pcs100_config0_pcs_fec91_100g_ck_ena_in({physs_registers_wrapper_0_pcs100_config0_pcs_fec91_100g_ck_ena_in_0,physs_registers_wrapper_0_pcs100_config0_pcs_fec91_100g_ck_ena_in}), 
    .pcs100_config0_pcs_sd_100g({physs_registers_wrapper_0_pcs100_config0_pcs_sd_100g_0,physs_registers_wrapper_0_pcs100_config0_pcs_sd_100g}), 
    .pcs100_config1_pcs_fec91_1lane_in({physs_registers_wrapper_0_pcs100_config1_pcs_fec91_1lane_in_2,physs_registers_wrapper_0_pcs100_config1_pcs_fec91_1lane_in_1,physs_registers_wrapper_0_pcs100_config1_pcs_fec91_1lane_in_0,physs_registers_wrapper_0_pcs100_config1_pcs_fec91_1lane_in}), 
    .pcs100_config1_pcs_fec91_ll_mode_in({physs_registers_wrapper_0_pcs100_config1_pcs_fec91_ll_mode_in_0,physs_registers_wrapper_0_pcs100_config1_pcs_fec91_ll_mode_in}), 
    .pcs100_config1_pcs_rxlaui_ena_in({physs_registers_wrapper_0_pcs100_config1_pcs_rxlaui_ena_in_2,physs_registers_wrapper_0_pcs100_config1_pcs_rxlaui_ena_in_1,physs_registers_wrapper_0_pcs100_config1_pcs_rxlaui_ena_in_0,physs_registers_wrapper_0_pcs100_config1_pcs_rxlaui_ena_in}), 
    .pcs100_config1_pcs_pcs100_ena_in({physs_registers_wrapper_0_pcs100_config1_pcs_pcs100_ena_in_2,physs_registers_wrapper_0_pcs100_config1_pcs_pcs100_ena_in_1,physs_registers_wrapper_0_pcs100_config1_pcs_pcs100_ena_in_0,physs_registers_wrapper_0_pcs100_config1_pcs_pcs100_ena_in}), 
    .pcs100_config1_pcs_f91_ena_in({physs_registers_wrapper_0_pcs100_config1_pcs_f91_ena_in_0,physs_registers_wrapper_0_pcs100_config1_pcs_f91_ena_in}), 
    .pcs100_config2_pcs_mode40_ena_in({physs_registers_wrapper_0_pcs100_config2_pcs_mode40_ena_in_0,physs_registers_wrapper_0_pcs100_config2_pcs_mode40_ena_in}), 
    .pcs100_config2_pcs_pacer_10g({physs_registers_wrapper_0_pcs100_config2_pcs_pacer_10g_0,physs_registers_wrapper_0_pcs100_config2_pcs_pacer_10g}), 
    .pcs100_config2_pcs_fec_ena({physs_registers_wrapper_0_pcs100_config2_pcs_fec_ena_0,physs_registers_wrapper_0_pcs100_config2_pcs_fec_ena}), 
    .pcs100_config2_pcs_fec_err_ena({physs_registers_wrapper_0_pcs100_config2_pcs_fec_err_ena_0,physs_registers_wrapper_0_pcs100_config2_pcs_fec_err_ena}), 
    .pcs_mode_config_pcs_external_loopback_en_lane({hidft_open_22,physs_registers_wrapper_0_pcs_mode_config_pcs_external_loopback_en_lane}), 
    .pcs_mode_config_nic_mode(physs_registers_wrapper_0_pcs_mode_config_nic_mode), 
    .pcs_mode_config_pcs_mode_sel(physs_registers_wrapper_0_pcs_mode_config_pcs_mode_sel), 
    .pcs_mode_config_fifo_mode_sel(physs_registers_wrapper_0_pcs_mode_config_fifo_mode_sel), 
    .pcs_mode_config_lane_revsersal_mux_quad(physs_registers_wrapper_0_pcs_mode_config_lane_revsersal_mux_quad), 
    .ts_int_config_0_interrupt_enable(physs_registers_wrapper_0_ts_int_config_0_interrupt_enable), 
    .ts_int_config_0_int_threshold(physs_registers_wrapper_0_ts_int_config_0_int_threshold), 
    .tx_offset_ready_0_tx_ready(physs_registers_wrapper_0_tx_offset_ready_0_tx_ready), 
    .ts_memory_status_0_0(physs_timestamp_0_timestamp_csr_reg[0][31:0]), 
    .ts_memory_status_0_1(physs_timestamp_0_timestamp_csr_reg[0][63:32]), 
    .ts_memory_status_0_2(physs_timestamp_0_timestamp_csr_reg[0][95:64]), 
    .ts_memory_status_0_3(physs_timestamp_0_timestamp_csr_reg[0][127:96]), 
    .Global1_0_soft_reset(physs_registers_wrapper_0_Global1_0_soft_reset), 
    .Global1_1_soft_reset(physs_registers_wrapper_0_Global1_1_soft_reset), 
    .Global1_2_soft_reset(physs_registers_wrapper_0_Global1_2_soft_reset), 
    .Global1_3_soft_reset(physs_registers_wrapper_0_Global1_3_soft_reset), 
    .time_M_0_time_clk_cyc_M(physs_registers_wrapper_0_time_M_0_time_clk_cyc_M), 
    .time_M_1_time_clk_cyc_M(physs_registers_wrapper_0_time_M_1_time_clk_cyc_M), 
    .time_M_2_time_clk_cyc_M(physs_registers_wrapper_0_time_M_2_time_clk_cyc_M), 
    .time_M_3_time_clk_cyc_M(physs_registers_wrapper_0_time_M_3_time_clk_cyc_M), 
    .time_N_0_time_clk_cyc_N(physs_registers_wrapper_0_time_N_0_time_clk_cyc_N), 
    .time_N_1_time_clk_cyc_N(physs_registers_wrapper_0_time_N_1_time_clk_cyc_N), 
    .time_N_2_time_clk_cyc_N(physs_registers_wrapper_0_time_N_2_time_clk_cyc_N), 
    .time_N_3_time_clk_cyc_N(physs_registers_wrapper_0_time_N_3_time_clk_cyc_N), 
    .time_TUs_L_0_time_clk_cyc_l(physs_registers_wrapper_0_time_TUs_L_0_time_clk_cyc_l), 
    .time_TUs_U_0_time_clk_cyc_u(physs_registers_wrapper_0_time_TUs_U_0_time_clk_cyc_u), 
    .time_TUs_L_1_time_clk_cyc_l(physs_registers_wrapper_0_time_TUs_L_1_time_clk_cyc_l), 
    .time_TUs_U_1_time_clk_cyc_u(physs_registers_wrapper_0_time_TUs_U_1_time_clk_cyc_u), 
    .time_TUs_L_2_time_clk_cyc_l(physs_registers_wrapper_0_time_TUs_L_2_time_clk_cyc_l), 
    .time_TUs_U_2_time_clk_cyc_u(physs_registers_wrapper_0_time_TUs_U_2_time_clk_cyc_u), 
    .time_TUs_L_3_time_clk_cyc_l(physs_registers_wrapper_0_time_TUs_L_3_time_clk_cyc_l), 
    .time_TUs_U_3_time_clk_cyc_u(physs_registers_wrapper_0_time_TUs_U_3_time_clk_cyc_u), 
    .tx_timer_cmd_0_tx_timer_cmd(physs_registers_wrapper_0_tx_timer_cmd_0_tx_timer_cmd), 
    .tx_timer_cmd_1_tx_timer_cmd(physs_registers_wrapper_0_tx_timer_cmd_1_tx_timer_cmd), 
    .tx_timer_cmd_2_tx_timer_cmd(physs_registers_wrapper_0_tx_timer_cmd_2_tx_timer_cmd), 
    .tx_timer_cmd_3_tx_timer_cmd(physs_registers_wrapper_0_tx_timer_cmd_3_tx_timer_cmd), 
    .rx_timer_cmd_0_rx_timer_cmd(physs_registers_wrapper_0_rx_timer_cmd_0_rx_timer_cmd), 
    .rx_timer_cmd_1_rx_timer_cmd(physs_registers_wrapper_0_rx_timer_cmd_1_rx_timer_cmd), 
    .rx_timer_cmd_2_rx_timer_cmd(physs_registers_wrapper_0_rx_timer_cmd_2_rx_timer_cmd), 
    .rx_timer_cmd_3_rx_timer_cmd(physs_registers_wrapper_0_rx_timer_cmd_3_rx_timer_cmd), 
    .rx_timer_inc_pre_L_0_rx_timer_inc_pre_l(physs_registers_wrapper_0_rx_timer_inc_pre_L_0_rx_timer_inc_pre_l), 
    .rx_timer_inc_pre_U_0_rx_timer_inc_pre_u(physs_registers_wrapper_0_rx_timer_inc_pre_U_0_rx_timer_inc_pre_u), 
    .rx_timer_inc_pre_L_1_rx_timer_inc_pre_l(physs_registers_wrapper_0_rx_timer_inc_pre_L_1_rx_timer_inc_pre_l), 
    .rx_timer_inc_pre_U_1_rx_timer_inc_pre_u(physs_registers_wrapper_0_rx_timer_inc_pre_U_1_rx_timer_inc_pre_u), 
    .rx_timer_inc_pre_L_2_rx_timer_inc_pre_l(physs_registers_wrapper_0_rx_timer_inc_pre_L_2_rx_timer_inc_pre_l), 
    .rx_timer_inc_pre_U_2_rx_timer_inc_pre_u(physs_registers_wrapper_0_rx_timer_inc_pre_U_2_rx_timer_inc_pre_u), 
    .rx_timer_inc_pre_L_3_rx_timer_inc_pre_l(physs_registers_wrapper_0_rx_timer_inc_pre_L_3_rx_timer_inc_pre_l), 
    .rx_timer_inc_pre_U_3_rx_timer_inc_pre_u(physs_registers_wrapper_0_rx_timer_inc_pre_U_3_rx_timer_inc_pre_u), 
    .tx_timer_inc_pre_L_0_tx_timer_inc_pre_l(physs_registers_wrapper_0_tx_timer_inc_pre_L_0_tx_timer_inc_pre_l), 
    .tx_timer_inc_pre_U_0_tx_timer_inc_pre_u(physs_registers_wrapper_0_tx_timer_inc_pre_U_0_tx_timer_inc_pre_u), 
    .tx_timer_inc_pre_L_1_tx_timer_inc_pre_l(physs_registers_wrapper_0_tx_timer_inc_pre_L_1_tx_timer_inc_pre_l), 
    .tx_timer_inc_pre_U_1_tx_timer_inc_pre_u(physs_registers_wrapper_0_tx_timer_inc_pre_U_1_tx_timer_inc_pre_u), 
    .tx_timer_inc_pre_L_2_tx_timer_inc_pre_l(physs_registers_wrapper_0_tx_timer_inc_pre_L_2_tx_timer_inc_pre_l), 
    .tx_timer_inc_pre_U_2_tx_timer_inc_pre_u(physs_registers_wrapper_0_tx_timer_inc_pre_U_2_tx_timer_inc_pre_u), 
    .tx_timer_inc_pre_L_3_tx_timer_inc_pre_l(physs_registers_wrapper_0_tx_timer_inc_pre_L_3_tx_timer_inc_pre_l), 
    .tx_timer_inc_pre_U_3_tx_timer_inc_pre_u(physs_registers_wrapper_0_tx_timer_inc_pre_U_3_tx_timer_inc_pre_u), 
    .tx_timer_cmd_0_tx_master_timer(physs_registers_wrapper_0_tx_timer_cmd_0_tx_master_timer), 
    .tx_timer_cmd_1_tx_master_timer(physs_registers_wrapper_0_tx_timer_cmd_1_tx_master_timer), 
    .tx_timer_cmd_2_tx_master_timer(physs_registers_wrapper_0_tx_timer_cmd_2_tx_master_timer), 
    .tx_timer_cmd_3_tx_master_timer(physs_registers_wrapper_0_tx_timer_cmd_3_tx_master_timer), 
    .rx_timer_cmd_0_rx_master_timer(physs_registers_wrapper_0_rx_timer_cmd_0_rx_master_timer), 
    .rx_timer_cmd_1_rx_master_timer(physs_registers_wrapper_0_rx_timer_cmd_1_rx_master_timer), 
    .rx_timer_cmd_2_rx_master_timer(physs_registers_wrapper_0_rx_timer_cmd_2_rx_master_timer), 
    .rx_timer_cmd_3_rx_master_timer(physs_registers_wrapper_0_rx_timer_cmd_3_rx_master_timer), 
    .tx_timer_cnt_adj_L_0_tx_timer_cnt_adj_l(physs_registers_wrapper_0_tx_timer_cnt_adj_L_0_tx_timer_cnt_adj_l), 
    .tx_timer_cnt_adj_U_0_tx_timer_cnt_adj_u(physs_registers_wrapper_0_tx_timer_cnt_adj_U_0_tx_timer_cnt_adj_u), 
    .tx_timer_cnt_adj_L_1_tx_timer_cnt_adj_l(physs_registers_wrapper_0_tx_timer_cnt_adj_L_1_tx_timer_cnt_adj_l), 
    .tx_timer_cnt_adj_U_1_tx_timer_cnt_adj_u(physs_registers_wrapper_0_tx_timer_cnt_adj_U_1_tx_timer_cnt_adj_u), 
    .tx_timer_cnt_adj_L_2_tx_timer_cnt_adj_l(physs_registers_wrapper_0_tx_timer_cnt_adj_L_2_tx_timer_cnt_adj_l), 
    .tx_timer_cnt_adj_U_2_tx_timer_cnt_adj_u(physs_registers_wrapper_0_tx_timer_cnt_adj_U_2_tx_timer_cnt_adj_u), 
    .tx_timer_cnt_adj_L_3_tx_timer_cnt_adj_l(physs_registers_wrapper_0_tx_timer_cnt_adj_L_3_tx_timer_cnt_adj_l), 
    .tx_timer_cnt_adj_U_3_tx_timer_cnt_adj_u(physs_registers_wrapper_0_tx_timer_cnt_adj_U_3_tx_timer_cnt_adj_u), 
    .rx_timer_cnt_adj_L_0_rx_timer_cnt_adj_l(physs_registers_wrapper_0_rx_timer_cnt_adj_L_0_rx_timer_cnt_adj_l), 
    .rx_timer_cnt_adj_U_0_rx_timer_cnt_adj_u(physs_registers_wrapper_0_rx_timer_cnt_adj_U_0_rx_timer_cnt_adj_u), 
    .rx_timer_cnt_adj_L_1_rx_timer_cnt_adj_l(physs_registers_wrapper_0_rx_timer_cnt_adj_L_1_rx_timer_cnt_adj_l), 
    .rx_timer_cnt_adj_U_1_rx_timer_cnt_adj_u(physs_registers_wrapper_0_rx_timer_cnt_adj_U_1_rx_timer_cnt_adj_u), 
    .rx_timer_cnt_adj_L_2_rx_timer_cnt_adj_l(physs_registers_wrapper_0_rx_timer_cnt_adj_L_2_rx_timer_cnt_adj_l), 
    .rx_timer_cnt_adj_U_2_rx_timer_cnt_adj_u(physs_registers_wrapper_0_rx_timer_cnt_adj_U_2_rx_timer_cnt_adj_u), 
    .rx_timer_cnt_adj_L_3_rx_timer_cnt_adj_l(physs_registers_wrapper_0_rx_timer_cnt_adj_L_3_rx_timer_cnt_adj_l), 
    .rx_timer_cnt_adj_U_3_rx_timer_cnt_adj_u(physs_registers_wrapper_0_rx_timer_cnt_adj_U_3_rx_timer_cnt_adj_u), 
    .pcs_ref_inc_L_0_pcs_ref_inc_l(physs_registers_wrapper_0_pcs_ref_inc_L_0_pcs_ref_inc_l), 
    .pcs_ref_inc_U_0_pcs_ref_inc_u(physs_registers_wrapper_0_pcs_ref_inc_U_0_pcs_ref_inc_u), 
    .pcs_ref_inc_L_1_pcs_ref_inc_l(physs_registers_wrapper_0_pcs_ref_inc_L_1_pcs_ref_inc_l), 
    .pcs_ref_inc_U_1_pcs_ref_inc_u(physs_registers_wrapper_0_pcs_ref_inc_U_1_pcs_ref_inc_u), 
    .pcs_ref_inc_L_2_pcs_ref_inc_l(physs_registers_wrapper_0_pcs_ref_inc_L_2_pcs_ref_inc_l), 
    .pcs_ref_inc_U_2_pcs_ref_inc_u(physs_registers_wrapper_0_pcs_ref_inc_U_2_pcs_ref_inc_u), 
    .pcs_ref_inc_L_3_pcs_ref_inc_l(physs_registers_wrapper_0_pcs_ref_inc_L_3_pcs_ref_inc_l), 
    .pcs_ref_inc_U_3_pcs_ref_inc_u(physs_registers_wrapper_0_pcs_ref_inc_U_3_pcs_ref_inc_u), 
    .pcs_ref_TUs_L_0_pcs_ref_clk_cyc_l(physs_registers_wrapper_0_pcs_ref_TUs_L_0_pcs_ref_clk_cyc_l), 
    .pcs_ref_TUs_U_0_pcs_ref_clk_cyc_u(physs_registers_wrapper_0_pcs_ref_TUs_U_0_pcs_ref_clk_cyc_u), 
    .pcs_ref_TUs_L_1_pcs_ref_clk_cyc_l(physs_registers_wrapper_0_pcs_ref_TUs_L_1_pcs_ref_clk_cyc_l), 
    .pcs_ref_TUs_U_1_pcs_ref_clk_cyc_u(physs_registers_wrapper_0_pcs_ref_TUs_U_1_pcs_ref_clk_cyc_u), 
    .pcs_ref_TUs_L_2_pcs_ref_clk_cyc_l(physs_registers_wrapper_0_pcs_ref_TUs_L_2_pcs_ref_clk_cyc_l), 
    .pcs_ref_TUs_U_2_pcs_ref_clk_cyc_u(physs_registers_wrapper_0_pcs_ref_TUs_U_2_pcs_ref_clk_cyc_u), 
    .pcs_ref_TUs_L_3_pcs_ref_clk_cyc_l(physs_registers_wrapper_0_pcs_ref_TUs_L_3_pcs_ref_clk_cyc_l), 
    .pcs_ref_TUs_U_3_pcs_ref_clk_cyc_u(physs_registers_wrapper_0_pcs_ref_TUs_U_3_pcs_ref_clk_cyc_u), 
    .pcs_ref_inc_L_0_enable_load(physs_registers_wrapper_0_pcs_ref_inc_L_0_enable_load), 
    .pcs_ref_inc_L_1_enable_load(physs_registers_wrapper_0_pcs_ref_inc_L_1_enable_load), 
    .pcs_ref_inc_L_2_enable_load(physs_registers_wrapper_0_pcs_ref_inc_L_2_enable_load), 
    .pcs_ref_inc_L_3_enable_load(physs_registers_wrapper_0_pcs_ref_inc_L_3_enable_load), 
    .ts_int_config_1_interrupt_enable(physs_registers_wrapper_0_ts_int_config_1_interrupt_enable), 
    .ts_int_config_1_int_threshold(physs_registers_wrapper_0_ts_int_config_1_int_threshold), 
    .tx_offset_ready_1_tx_ready(physs_registers_wrapper_0_tx_offset_ready_1_tx_ready), 
    .ts_memory_status_1_0(physs_timestamp_0_timestamp_csr_reg[1][31:0]), 
    .ts_memory_status_1_1(physs_timestamp_0_timestamp_csr_reg[1][63:32]), 
    .ts_memory_status_1_2(physs_timestamp_0_timestamp_csr_reg[1][95:64]), 
    .ts_memory_status_1_3(physs_timestamp_0_timestamp_csr_reg[1][127:96]), 
    .ts_int_config_2_interrupt_enable(physs_registers_wrapper_0_ts_int_config_2_interrupt_enable), 
    .ts_int_config_2_int_threshold(physs_registers_wrapper_0_ts_int_config_2_int_threshold), 
    .tx_offset_ready_2_tx_ready(physs_registers_wrapper_0_tx_offset_ready_2_tx_ready), 
    .ts_memory_status_2_0(physs_timestamp_0_timestamp_csr_reg[2][31:0]), 
    .ts_memory_status_2_1(physs_timestamp_0_timestamp_csr_reg[2][63:32]), 
    .ts_memory_status_2_2(physs_timestamp_0_timestamp_csr_reg[2][95:64]), 
    .ts_memory_status_2_3(physs_timestamp_0_timestamp_csr_reg[2][127:96]), 
    .ts_int_config_3_interrupt_enable(physs_registers_wrapper_0_ts_int_config_3_interrupt_enable), 
    .ts_int_config_3_int_threshold(physs_registers_wrapper_0_ts_int_config_3_int_threshold), 
    .tx_offset_ready_3_tx_ready(physs_registers_wrapper_0_tx_offset_ready_3_tx_ready), 
    .ts_memory_status_3_0(physs_timestamp_0_timestamp_csr_reg[3][31:0]), 
    .ts_memory_status_3_1(physs_timestamp_0_timestamp_csr_reg[3][63:32]), 
    .ts_memory_status_3_2(physs_timestamp_0_timestamp_csr_reg[3][95:64]), 
    .ts_memory_status_3_3(physs_timestamp_0_timestamp_csr_reg[3][127:96]), 
    .physs_int_ovveride_reg0_icu(physs_registers_wrapper_0_physs_int_ovveride_reg0_icu), 
    .physs_int_ovveride_reg1_icu(physs_registers_wrapper_0_physs_int_ovveride_reg1_icu), 
    .physs_int_ovveride_reg2_icu(physs_registers_wrapper_0_physs_int_ovveride_reg2_icu), 
    .physs_int_ovveride_reg3_icu(physs_registers_wrapper_0_physs_int_ovveride_reg3_icu), 
    .physs_int_ovveride_reg4_icu(physs_registers_wrapper_0_physs_int_ovveride_reg4_icu), 
    .physs_int_ovveride_reg5_icu(physs_registers_wrapper_0_physs_int_ovveride_reg5_icu), 
    .physs_irq_mask_reg0_icu(physs_registers_wrapper_0_physs_irq_mask_reg0_icu), 
    .physs_irq_mask_reg1_icu(physs_registers_wrapper_0_physs_irq_mask_reg1_icu), 
    .physs_irq_mask_reg2_icu(physs_registers_wrapper_0_physs_irq_mask_reg2_icu), 
    .physs_irq_mask_reg3_icu(physs_registers_wrapper_0_physs_irq_mask_reg3_icu), 
    .physs_irq_mask_reg4_icu(physs_registers_wrapper_0_physs_irq_mask_reg4_icu), 
    .physs_irq_mask_reg5_icu(physs_registers_wrapper_0_physs_irq_mask_reg5_icu), 
    .physs_irq_raw_status_reg0_icu(quad_interrupts_0_physs_irq_raw_status_reg0_icu), 
    .physs_irq_raw_status_reg1_icu(quad_interrupts_0_physs_irq_raw_status_reg1_icu), 
    .physs_irq_raw_status_reg2_icu(quad_interrupts_0_physs_irq_raw_status_reg2_icu), 
    .physs_irq_raw_status_reg3_icu(quad_interrupts_0_physs_irq_raw_status_reg3_icu), 
    .physs_irq_raw_status_reg4_icu(quad_interrupts_0_physs_irq_raw_status_reg4_icu), 
    .physs_irq_raw_status_reg5_icu(quad_interrupts_0_physs_irq_raw_status_reg5_icu), 
    .physs_irq_reset_reg0_icu(physs_registers_wrapper_0_physs_irq_reset_reg0_icu), 
    .physs_irq_reset_reg1_icu(physs_registers_wrapper_0_physs_irq_reset_reg1_icu), 
    .physs_irq_reset_reg2_icu(physs_registers_wrapper_0_physs_irq_reset_reg2_icu), 
    .physs_irq_reset_reg3_icu(physs_registers_wrapper_0_physs_irq_reset_reg3_icu), 
    .physs_irq_reset_reg4_icu(physs_registers_wrapper_0_physs_irq_reset_reg4_icu), 
    .physs_irq_reset_reg5_icu(physs_registers_wrapper_0_physs_irq_reset_reg5_icu), 
    .physs_irq_status_reg0_icu(quad_interrupts_0_physs_irq_status_reg0_icu), 
    .physs_irq_status_reg1_icu(quad_interrupts_0_physs_irq_status_reg1_icu), 
    .physs_irq_status_reg2_icu(quad_interrupts_0_physs_irq_status_reg2_icu), 
    .physs_irq_status_reg3_icu(quad_interrupts_0_physs_irq_status_reg3_icu), 
    .physs_irq_status_reg4_icu(quad_interrupts_0_physs_irq_status_reg4_icu), 
    .physs_irq_status_reg5_icu(quad_interrupts_0_physs_irq_status_reg5_icu), 
    .deskew_valid_0(1'b0), 
    .pcs200_tx_am_sf(3'b0), 
    .pcs400_tx_am_sf(3'b0), 
    .tch0_rx_timer_capture_h(32'b0), 
    .tch1_rx_timer_capture_h(32'b0), 
    .tch2_rx_timer_capture_h(32'b0), 
    .tch3_rx_timer_capture_h(32'b0), 
    .tcl0_rx_timer_capture_l(32'b0), 
    .tcl1_rx_timer_capture_l(32'b0), 
    .tcl2_rx_timer_capture_l(32'b0), 
    .tcl3_rx_timer_capture_l(32'b0), 
    .sl0_sd_bit_slip(8'b0), 
    .sl1_sd_bit_slip(8'b0), 
    .sl2_sd_bit_slip(8'b0), 
    .sl3_sd_bit_slip(8'b0), 
    .tx0_timer_capture_h(32'b0), 
    .tx1_timer_capture_h(32'b0), 
    .tx2_timer_capture_h(32'b0), 
    .tx3_timer_capture_h(32'b0), 
    .tx0_timer_capture_l(32'b0), 
    .tx1_timer_capture_l(32'b0), 
    .tx2_timer_capture_l(32'b0), 
    .tx3_timer_capture_l(32'b0), 
    .physs_irq_raw_status_reg6_icu(32'b0), 
    .physs_irq_raw_status_reg7_icu(32'b0), 
    .physs_irq_status_reg6_icu(32'b0), 
    .physs_irq_status_reg7_icu(32'b0), 
    .tx_fifo_latency_messure_lane0(32'b0), 
    .tx_fifo_latency_messure_lane1(32'b0), 
    .tx_fifo_latency_messure_lane2(32'b0), 
    .tx_fifo_latency_messure_lane3(32'b0), 
    .tx_fifo_latency_messure_dec_lane0(32'b0), 
    .tx_fifo_latency_messure_dec_lane1(32'b0), 
    .tx_fifo_latency_messure_dec_lane2(32'b0), 
    .tx_fifo_latency_messure_dec_lane3(32'b0), 
    .rx_fifo_latency_messure_lane0(32'b0), 
    .rx_fifo_latency_messure_lane1(32'b0), 
    .rx_fifo_latency_messure_lane2(32'b0), 
    .rx_fifo_latency_messure_lane3(32'b0), 
    .rx_fifo_latency_messure_dec_lane0(32'b0), 
    .rx_fifo_latency_messure_dec_lane1(32'b0), 
    .rx_fifo_latency_messure_dec_lane2(32'b0), 
    .rx_fifo_latency_messure_dec_lane3(32'b0), 
    .fet_ack_in(1'b0), 
    .mac0_pfc_mode(mac100_0_pfc_mode), 
    .mac0_mac_enable(mac100_0_mac_enable), 
    .mac0_mac_pause_en(mac100_0_mac_pause_en), 
    .mac1_pfc_mode(mac100_1_pfc_mode), 
    .mac1_mac_enable(mac100_1_mac_enable), 
    .mac1_mac_pause_en(mac100_1_mac_pause_en), 
    .mac2_pfc_mode(mac100_2_pfc_mode), 
    .mac2_mac_enable(mac100_2_mac_enable), 
    .mac2_mac_pause_en(mac100_2_mac_pause_en), 
    .mac3_pfc_mode(mac100_3_pfc_mode), 
    .mac3_mac_enable(mac100_3_mac_enable), 
    .mac3_mac_pause_en(mac100_3_mac_pause_en), 
    .quad_pcs_desk_buf_rlevel({quadpcs100_0_pcs_desk_buf_rlevel_2,quadpcs100_0_pcs_desk_buf_rlevel_1,quadpcs100_0_pcs_desk_buf_rlevel_0,quadpcs100_0_pcs_desk_buf_rlevel}), 
    .mac100_config_0_magic_ena(physs_registers_wrapper_0_mac100_config_0_magic_ena), 
    .mac100_config_1_magic_ena(physs_registers_wrapper_0_mac100_config_1_magic_ena), 
    .mac100_config_2_magic_ena(physs_registers_wrapper_0_mac100_config_2_magic_ena), 
    .mac100_config_3_magic_ena(physs_registers_wrapper_0_mac100_config_3_magic_ena), 
    .mac100_config_0_tx_loc_fault(physs_registers_wrapper_0_mac100_config_0_tx_loc_fault), 
    .mac100_config_1_tx_loc_fault(physs_registers_wrapper_0_mac100_config_1_tx_loc_fault), 
    .mac100_config_2_tx_loc_fault(physs_registers_wrapper_0_mac100_config_2_tx_loc_fault), 
    .mac100_config_3_tx_loc_fault(physs_registers_wrapper_0_mac100_config_3_tx_loc_fault), 
    .mac100_config_0_tx_rem_fault(physs_registers_wrapper_0_mac100_config_0_tx_rem_fault), 
    .mac100_config_1_tx_rem_fault(physs_registers_wrapper_0_mac100_config_1_tx_rem_fault), 
    .mac100_config_2_tx_rem_fault(physs_registers_wrapper_0_mac100_config_2_tx_rem_fault), 
    .mac100_config_3_tx_rem_fault(physs_registers_wrapper_0_mac100_config_3_tx_rem_fault), 
    .mac100_config_0_tx_li_fault(physs_registers_wrapper_0_mac100_config_0_tx_li_fault), 
    .mac100_config_1_tx_li_fault(physs_registers_wrapper_0_mac100_config_1_tx_li_fault), 
    .mac100_config_2_tx_li_fault(physs_registers_wrapper_0_mac100_config_2_tx_li_fault), 
    .mac100_config_3_tx_li_fault(physs_registers_wrapper_0_mac100_config_3_tx_li_fault), 
    .oflux_srds_rdy_ovr0(physs_registers_wrapper_0_oflux_srds_rdy_ovr0), 
    .oflux_srds_rdy_ovr1(physs_registers_wrapper_0_oflux_srds_rdy_ovr1), 
    .oflux_srds_rdy_ovr2(physs_registers_wrapper_0_oflux_srds_rdy_ovr2), 
    .oflux_srds_rdy_ovr3(physs_registers_wrapper_0_oflux_srds_rdy_ovr3), 
    .oflux_srds_rdy_ovr_en0(physs_registers_wrapper_0_oflux_srds_rdy_ovr_en0), 
    .oflux_srds_rdy_ovr_en1(physs_registers_wrapper_0_oflux_srds_rdy_ovr_en1), 
    .oflux_srds_rdy_ovr_en2(physs_registers_wrapper_0_oflux_srds_rdy_ovr_en2), 
    .oflux_srds_rdy_ovr_en3(physs_registers_wrapper_0_oflux_srds_rdy_ovr_en3), 
    .reset_xmp_ovveride_en(physs_registers_wrapper_0_reset_xmp_ovveride_en), 
    .reset_pcs100_ovveride_en(physs_registers_wrapper_0_reset_pcs100_ovveride_en), 
    .reset_pcs200_ovveride_en(physs_registers_wrapper_0_reset_pcs200_ovveride_en), 
    .reset_pcs400_ovveride_en(physs_registers_wrapper_0_reset_pcs400_ovveride_en), 
    .reset_mac400_ovveride_en(physs_registers_wrapper_0_reset_mac400_ovveride_en), 
    .reset_mac200_ovveride_en(physs_registers_wrapper_0_reset_mac200_ovveride_en), 
    .reset_mac100_ovveride_en(physs_registers_wrapper_0_reset_mac100_ovveride_en), 
    .power_fsm_clk_gate_en(physs_registers_wrapper_0_power_fsm_clk_gate_en), 
    .power_fsm_reset_gate_en(physs_registers_wrapper_0_power_fsm_reset_gate_en), 
    .viewpin_mux_select_0(), 
    .viewpin_mux_select_1(), 
    .viewpin_mux_en_0(), 
    .viewpin_mux_en_1(), 
    .cpri_sel(), 
    .Global1_0_set_adj_half(), 
    .Global1_0_set_adj_dir(), 
    .Global1_0_multi_lane_mon_sel(), 
    .Global1_0_ts_shift(), 
    .Global1_0_sel_offset2(), 
    .Global1_1_set_adj_half(), 
    .Global1_1_set_adj_dir(), 
    .Global1_1_multi_lane_mon_sel(), 
    .Global1_1_ts_shift(), 
    .Global1_1_sel_offset2(), 
    .Global1_2_set_adj_half(), 
    .Global1_2_set_adj_dir(), 
    .Global1_2_multi_lane_mon_sel(), 
    .Global1_2_ts_shift(), 
    .Global1_2_sel_offset2(), 
    .Global1_3_set_adj_half(), 
    .Global1_3_set_adj_dir(), 
    .Global1_3_multi_lane_mon_sel(), 
    .Global1_3_ts_shift(), 
    .Global1_3_sel_offset2(), 
    .Global2_0_window_len(), 
    .Global2_1_window_len(), 
    .Global2_2_window_len(), 
    .Global2_3_window_len(), 
    .physs_common_check_error_indicator(), 
    .physs_common_pttrn_gen_config_check_cnt_over(), 
    .physs_common_pttrn_gen_config_check_err_valid(), 
    .physs_common_pttrn_gen_config_check_err_flag(), 
    .physs_common_pttrn_gen_config_check_err_type(), 
    .physs_common_pttrn_gen_config_pttrn_data_width(), 
    .physs_common_pttrn_gen_config_pttrn_modesel(), 
    .physs_common_pttrn_seed(), 
    .gpcs_config_reg0_tx_lane_threshold(), 
    .gpcs_config_reg0_usxgmii1_speed(), 
    .gpcs_config_reg0_uxg1_speed_2d5(), 
    .gpcs_config_reg0_sg_ena1(), 
    .gpcs_config_reg0_usxgmii0_speed(), 
    .gpcs_config_reg0_uxg0_speed_2d5(), 
    .gpcs_config_reg0_sg_ena0(), 
    .gpcs_config_reg1_usxgmii1_speed(), 
    .gpcs_config_reg1_uxg1_speed_2d5(), 
    .gpcs_config_reg1_sg_ena1(), 
    .gpcs_config_reg1_usxgmii0_speed(), 
    .gpcs_config_reg1_uxg0_speed_2d5(), 
    .gpcs_config_reg1_sg_ena0(), 
    .mac100_config_0_xoff_gen(), 
    .mac100_config_0_tx_stop(), 
    .mac100_config_1_xoff_gen(), 
    .mac100_config_1_tx_stop(), 
    .mac100_config_2_xoff_gen(), 
    .mac100_config_2_tx_stop(), 
    .mac100_config_3_xoff_gen(), 
    .mac100_config_3_tx_stop(), 
    .pcs_mode_config_syncE_mux_sel(), 
    .pcs_mode_config_mac_external_loopback_en_lane(), 
    .pcs_rx_TUs_L_0_pcs_clk_cyc_rx_l(), 
    .pcs_rx_TUs_L_1_pcs_clk_cyc_rx_l(), 
    .pcs_rx_TUs_L_2_pcs_clk_cyc_rx_l(), 
    .pcs_rx_TUs_L_3_pcs_clk_cyc_rx_l(), 
    .pcs_rx_TUs_U_0_pcs_clk_cyc_rx_u(), 
    .pcs_rx_TUs_U_1_pcs_clk_cyc_rx_u(), 
    .pcs_rx_TUs_U_2_pcs_clk_cyc_rx_u(), 
    .pcs_rx_TUs_U_3_pcs_clk_cyc_rx_u(), 
    .pcs_tx_TUs_L_0_pcs_clk_cyc_tx_l(), 
    .pcs_tx_TUs_L_1_pcs_clk_cyc_tx_l(), 
    .pcs_tx_TUs_L_2_pcs_clk_cyc_tx_l(), 
    .pcs_tx_TUs_L_3_pcs_clk_cyc_tx_l(), 
    .pcs_tx_TUs_U_0_pcs_clk_cyc_tx_u(), 
    .pcs_tx_TUs_U_1_pcs_clk_cyc_tx_u(), 
    .pcs_tx_TUs_U_2_pcs_clk_cyc_tx_u(), 
    .pcs_tx_TUs_U_3_pcs_clk_cyc_tx_u(), 
    .physs_int_ovveride_reg6_icu(), 
    .physs_int_ovveride_reg7_icu(), 
    .physs_irq_mask_reg6_icu(), 
    .physs_irq_mask_reg7_icu(), 
    .physs_irq_reset_reg6_icu(), 
    .physs_irq_reset_reg7_icu(), 
    .ptp_1step_config_t1s_delta(), 
    .ptp_1step_config_t1s_update64(), 
    .ptp_1step_config_mode1s_ena(), 
    .ptp_1step_peer_delay0_peer_delay_val(), 
    .ptp_1step_peer_delay0_peer_delay(), 
    .ptp_1step_peer_delay0_t1s_add_peer_delay(), 
    .ptp_1step_peer_delay1_peer_delay_val(), 
    .ptp_1step_peer_delay1_peer_delay(), 
    .ptp_1step_peer_delay1_t1s_add_peer_delay(), 
    .ptp_1step_peer_delay2_peer_delay_val(), 
    .ptp_1step_peer_delay2_peer_delay(), 
    .ptp_1step_peer_delay2_t1s_add_peer_delay(), 
    .ptp_1step_peer_delay3_peer_delay_val(), 
    .ptp_1step_peer_delay3_peer_delay(), 
    .ptp_1step_peer_delay3_t1s_add_peer_delay(), 
    .rx_offset_ready_0_rx_ready(), 
    .rx_offset_ready_1_rx_ready(), 
    .rx_offset_ready_2_rx_ready(), 
    .rx_offset_ready_3_rx_ready(), 
    .rx_timer_cmd_0_rx_type(), 
    .rx_timer_cmd_1_rx_type(), 
    .rx_timer_cmd_2_rx_type(), 
    .rx_timer_cmd_3_rx_type(), 
    .rx_total_offset_L_0_rx_total_offset_l(), 
    .rx_total_offset_L_1_rx_total_offset_l(), 
    .rx_total_offset_L_2_rx_total_offset_l(), 
    .rx_total_offset_L_3_rx_total_offset_l(), 
    .rx_total_offset_U_0_rx_total_offset_u(), 
    .rx_total_offset_U_1_rx_total_offset_u(), 
    .rx_total_offset_U_2_rx_total_offset_u(), 
    .rx_total_offset_U_3_rx_total_offset_u(), 
    .tx_total_offset_L_0_tx_total_offset_l(), 
    .tx_total_offset_L_1_tx_total_offset_l(), 
    .tx_total_offset_L_2_tx_total_offset_l(), 
    .tx_total_offset_L_3_tx_total_offset_l(), 
    .tx_total_offset_U_0_tx_total_offset_u(), 
    .tx_total_offset_U_1_tx_total_offset_u(), 
    .tx_total_offset_U_2_tx_total_offset_u(), 
    .tx_total_offset_U_3_tx_total_offset_u(), 
    .isol_en_b(), 
    .isol_mem_en_b(), 
    .fet_ack_cmo(), 
    .fet_en_muxout()
) ; 
physs_timestamp physs_timestamp_0 (
    .interrupt_enable({physs_registers_wrapper_0_ts_int_config_3_interrupt_enable,physs_registers_wrapper_0_ts_int_config_2_interrupt_enable,physs_registers_wrapper_0_ts_int_config_1_interrupt_enable,physs_registers_wrapper_0_ts_int_config_0_interrupt_enable}), 
    .int_threshold_0(physs_registers_wrapper_0_ts_int_config_0_int_threshold), 
    .tx_ready({physs_registers_wrapper_0_tx_offset_ready_3_tx_ready,physs_registers_wrapper_0_tx_offset_ready_2_tx_ready,physs_registers_wrapper_0_tx_offset_ready_1_tx_ready,physs_registers_wrapper_0_tx_offset_ready_0_tx_ready}), 
    .timestamp_csr_reg(physs_timestamp_0_timestamp_csr_reg), 
    .i_soft_reset({physs_registers_wrapper_0_Global1_3_soft_reset,physs_registers_wrapper_0_Global1_2_soft_reset,physs_registers_wrapper_0_Global1_1_soft_reset,physs_registers_wrapper_0_Global1_0_soft_reset}), 
    .i_time_clk_cyc_M_0(physs_registers_wrapper_0_time_M_0_time_clk_cyc_M), 
    .i_time_clk_cyc_M_1(physs_registers_wrapper_0_time_M_1_time_clk_cyc_M), 
    .i_time_clk_cyc_M_2(physs_registers_wrapper_0_time_M_2_time_clk_cyc_M), 
    .i_time_clk_cyc_M_3(physs_registers_wrapper_0_time_M_3_time_clk_cyc_M), 
    .i_time_clk_cyc_N_0(physs_registers_wrapper_0_time_N_0_time_clk_cyc_N), 
    .i_time_clk_cyc_N_1(physs_registers_wrapper_0_time_N_1_time_clk_cyc_N), 
    .i_time_clk_cyc_N_2(physs_registers_wrapper_0_time_N_2_time_clk_cyc_N), 
    .i_time_clk_cyc_N_3(physs_registers_wrapper_0_time_N_3_time_clk_cyc_N), 
    .i_time_clk_cyc_0({physs_registers_wrapper_0_time_TUs_U_0_time_clk_cyc_u,physs_registers_wrapper_0_time_TUs_L_0_time_clk_cyc_l}), 
    .i_time_clk_cyc_1({physs_registers_wrapper_0_time_TUs_U_1_time_clk_cyc_u,physs_registers_wrapper_0_time_TUs_L_1_time_clk_cyc_l}), 
    .i_time_clk_cyc_2({physs_registers_wrapper_0_time_TUs_U_2_time_clk_cyc_u,physs_registers_wrapper_0_time_TUs_L_2_time_clk_cyc_l}), 
    .i_time_clk_cyc_3({physs_registers_wrapper_0_time_TUs_U_3_time_clk_cyc_u,physs_registers_wrapper_0_time_TUs_L_3_time_clk_cyc_l}), 
    .i_timer_cmd_tx_0(physs_registers_wrapper_0_tx_timer_cmd_0_tx_timer_cmd), 
    .i_timer_cmd_tx_1(physs_registers_wrapper_0_tx_timer_cmd_1_tx_timer_cmd), 
    .i_timer_cmd_tx_2(physs_registers_wrapper_0_tx_timer_cmd_2_tx_timer_cmd), 
    .i_timer_cmd_tx_3(physs_registers_wrapper_0_tx_timer_cmd_3_tx_timer_cmd), 
    .i_timer_cmd_rx_0(physs_registers_wrapper_0_rx_timer_cmd_0_rx_timer_cmd), 
    .i_timer_cmd_rx_1(physs_registers_wrapper_0_rx_timer_cmd_1_rx_timer_cmd), 
    .i_timer_cmd_rx_2(physs_registers_wrapper_0_rx_timer_cmd_2_rx_timer_cmd), 
    .i_timer_cmd_rx_3(physs_registers_wrapper_0_rx_timer_cmd_3_rx_timer_cmd), 
    .i_timer_inc_pre_rx_0({physs_registers_wrapper_0_rx_timer_inc_pre_U_0_rx_timer_inc_pre_u,physs_registers_wrapper_0_rx_timer_inc_pre_L_0_rx_timer_inc_pre_l}), 
    .i_timer_inc_pre_rx_1({physs_registers_wrapper_0_rx_timer_inc_pre_U_1_rx_timer_inc_pre_u,physs_registers_wrapper_0_rx_timer_inc_pre_L_1_rx_timer_inc_pre_l}), 
    .i_timer_inc_pre_rx_2({physs_registers_wrapper_0_rx_timer_inc_pre_U_2_rx_timer_inc_pre_u,physs_registers_wrapper_0_rx_timer_inc_pre_L_2_rx_timer_inc_pre_l}), 
    .i_timer_inc_pre_rx_3({physs_registers_wrapper_0_rx_timer_inc_pre_U_3_rx_timer_inc_pre_u,physs_registers_wrapper_0_rx_timer_inc_pre_L_3_rx_timer_inc_pre_l}), 
    .i_timer_inc_pre_tx_0({physs_registers_wrapper_0_tx_timer_inc_pre_U_0_tx_timer_inc_pre_u,physs_registers_wrapper_0_tx_timer_inc_pre_L_0_tx_timer_inc_pre_l}), 
    .i_timer_inc_pre_tx_1({physs_registers_wrapper_0_tx_timer_inc_pre_U_1_tx_timer_inc_pre_u,physs_registers_wrapper_0_tx_timer_inc_pre_L_1_tx_timer_inc_pre_l}), 
    .i_timer_inc_pre_tx_2({physs_registers_wrapper_0_tx_timer_inc_pre_U_2_tx_timer_inc_pre_u,physs_registers_wrapper_0_tx_timer_inc_pre_L_2_tx_timer_inc_pre_l}), 
    .i_timer_inc_pre_tx_3({physs_registers_wrapper_0_tx_timer_inc_pre_U_3_tx_timer_inc_pre_u,physs_registers_wrapper_0_tx_timer_inc_pre_L_3_tx_timer_inc_pre_l}), 
    .i_master_timer_tx_0(physs_registers_wrapper_0_tx_timer_cmd_0_tx_master_timer), 
    .i_master_timer_tx_1(physs_registers_wrapper_0_tx_timer_cmd_1_tx_master_timer), 
    .i_master_timer_tx_2(physs_registers_wrapper_0_tx_timer_cmd_2_tx_master_timer), 
    .i_master_timer_tx_3(physs_registers_wrapper_0_tx_timer_cmd_3_tx_master_timer), 
    .i_master_timer_rx_0(physs_registers_wrapper_0_rx_timer_cmd_0_rx_master_timer), 
    .i_master_timer_rx_1(physs_registers_wrapper_0_rx_timer_cmd_1_rx_master_timer), 
    .i_master_timer_rx_2(physs_registers_wrapper_0_rx_timer_cmd_2_rx_master_timer), 
    .i_master_timer_rx_3(physs_registers_wrapper_0_rx_timer_cmd_3_rx_master_timer), 
    .i_timer_cnt_adj_tx_0({physs_registers_wrapper_0_tx_timer_cnt_adj_U_0_tx_timer_cnt_adj_u,physs_registers_wrapper_0_tx_timer_cnt_adj_L_0_tx_timer_cnt_adj_l}), 
    .i_timer_cnt_adj_tx_1({physs_registers_wrapper_0_tx_timer_cnt_adj_U_1_tx_timer_cnt_adj_u,physs_registers_wrapper_0_tx_timer_cnt_adj_L_1_tx_timer_cnt_adj_l}), 
    .i_timer_cnt_adj_tx_2({physs_registers_wrapper_0_tx_timer_cnt_adj_U_2_tx_timer_cnt_adj_u,physs_registers_wrapper_0_tx_timer_cnt_adj_L_2_tx_timer_cnt_adj_l}), 
    .i_timer_cnt_adj_tx_3({physs_registers_wrapper_0_tx_timer_cnt_adj_U_3_tx_timer_cnt_adj_u,physs_registers_wrapper_0_tx_timer_cnt_adj_L_3_tx_timer_cnt_adj_l}), 
    .i_timer_cnt_adj_rx_0({physs_registers_wrapper_0_rx_timer_cnt_adj_U_0_rx_timer_cnt_adj_u,physs_registers_wrapper_0_rx_timer_cnt_adj_L_0_rx_timer_cnt_adj_l}), 
    .i_timer_cnt_adj_rx_1({physs_registers_wrapper_0_rx_timer_cnt_adj_U_1_rx_timer_cnt_adj_u,physs_registers_wrapper_0_rx_timer_cnt_adj_L_1_rx_timer_cnt_adj_l}), 
    .i_timer_cnt_adj_rx_2({physs_registers_wrapper_0_rx_timer_cnt_adj_U_2_rx_timer_cnt_adj_u,physs_registers_wrapper_0_rx_timer_cnt_adj_L_2_rx_timer_cnt_adj_l}), 
    .i_timer_cnt_adj_rx_3({physs_registers_wrapper_0_rx_timer_cnt_adj_U_3_rx_timer_cnt_adj_u,physs_registers_wrapper_0_rx_timer_cnt_adj_L_3_rx_timer_cnt_adj_l}), 
    .i_pcs_clk_inc_0({physs_registers_wrapper_0_pcs_ref_inc_U_0_pcs_ref_inc_u,physs_registers_wrapper_0_pcs_ref_inc_L_0_pcs_ref_inc_l}), 
    .i_pcs_clk_inc_1({physs_registers_wrapper_0_pcs_ref_inc_U_1_pcs_ref_inc_u,physs_registers_wrapper_0_pcs_ref_inc_L_1_pcs_ref_inc_l}), 
    .i_pcs_clk_inc_2({physs_registers_wrapper_0_pcs_ref_inc_U_2_pcs_ref_inc_u,physs_registers_wrapper_0_pcs_ref_inc_L_2_pcs_ref_inc_l}), 
    .i_pcs_clk_inc_3({physs_registers_wrapper_0_pcs_ref_inc_U_3_pcs_ref_inc_u,physs_registers_wrapper_0_pcs_ref_inc_L_3_pcs_ref_inc_l}), 
    .i_pcs_clk_cyc_0({physs_registers_wrapper_0_pcs_ref_TUs_U_0_pcs_ref_clk_cyc_u,physs_registers_wrapper_0_pcs_ref_TUs_L_0_pcs_ref_clk_cyc_l}), 
    .i_pcs_clk_cyc_1({physs_registers_wrapper_0_pcs_ref_TUs_U_1_pcs_ref_clk_cyc_u,physs_registers_wrapper_0_pcs_ref_TUs_L_1_pcs_ref_clk_cyc_l}), 
    .i_pcs_clk_cyc_2({physs_registers_wrapper_0_pcs_ref_TUs_U_2_pcs_ref_clk_cyc_u,physs_registers_wrapper_0_pcs_ref_TUs_L_2_pcs_ref_clk_cyc_l}), 
    .i_pcs_clk_cyc_3({physs_registers_wrapper_0_pcs_ref_TUs_U_3_pcs_ref_clk_cyc_u,physs_registers_wrapper_0_pcs_ref_TUs_L_3_pcs_ref_clk_cyc_l}), 
    .pcs_enable_load({physs_registers_wrapper_0_pcs_ref_inc_L_3_enable_load,physs_registers_wrapper_0_pcs_ref_inc_L_2_enable_load,physs_registers_wrapper_0_pcs_ref_inc_L_1_enable_load,physs_registers_wrapper_0_pcs_ref_inc_L_0_enable_load}), 
    .int_threshold_1(physs_registers_wrapper_0_ts_int_config_1_int_threshold), 
    .int_threshold_2(physs_registers_wrapper_0_ts_int_config_2_int_threshold), 
    .int_threshold_3(physs_registers_wrapper_0_ts_int_config_3_int_threshold), 
    .ptp_mem_wr(physs_timestamp_0_ptp_mem_wr), 
    .ptp_mem_waddr(physs_timestamp_0_ptp_mem_waddr), 
    .ptp_mem_data(physs_timestamp_0_ptp_mem_data), 
    .ptp_mem_clr(physs_timestamp_0_ptp_mem_clr), 
    .ptp_mem_raddr(physs_timestamp_0_ptp_mem_raddr), 
    .ptp_mem_clr_data(physs_timestamp_0_ptp_mem_clr_data), 
    .i_master_sel(1'b0), 
    .time_cnt_tx(physs_timestamp_0_time_cnt_tx), 
    .time_cnt_rx(physs_timestamp_0_time_cnt_rx), 
    .time_clk(physs_clock_sync_0_time_clk_gated_100), 
    .ref_clk(physs_clock_sync_0_physs_func_clk_gated_100), 
    .csr_clk(physs_clock_sync_0_soc_per_clk_gated_100), 
    .time_rst_n(physs_clock_sync_0_reset_time_clk_n), 
    .csr_rst_n(physs_clock_sync_0_reset_reg_clk_inv), 
    .ref_rst_n(physs_clock_sync_0_reset_ref_clk_inv), 
    .i_tx_ts_wr({physs_pcs_mux_0_tx_ts_val_2,physs_pcs_mux_0_tx_ts_val_1,physs_pcs_mux_0_tx_ts_val_0,physs_pcs_mux_0_tx_ts_val}), 
    .i_tx_ts_id_0(physs_pcs_mux_0_tx_ts_id_0), 
    .i_tx_ts_data_0({5'b0,physs_pcs_mux_0_tx_ts_0,physs_pcs_mux_0_tx_ts_0_0}), 
    .i_tx_ts_id_1(physs_pcs_mux_0_tx_ts_id_1), 
    .i_tx_ts_data_1({5'b0,physs_pcs_mux_0_tx_ts_1,physs_pcs_mux_0_tx_ts_1_0}), 
    .i_tx_ts_id_2(physs_pcs_mux_0_tx_ts_id_2), 
    .i_tx_ts_data_2({5'b0,physs_pcs_mux_0_tx_ts_2,physs_pcs_mux_0_tx_ts_2_0}), 
    .i_tx_ts_id_3(physs_pcs_mux_0_tx_ts_id_3), 
    .i_tx_ts_data_3({5'b0,physs_pcs_mux_0_tx_ts_3,physs_pcs_mux_0_tx_ts_3_0}), 
    .fscan_rstbypen(1'b0), 
    .fscan_byprst_b(1'b0), 
    .i_ecsr_quad_ts_valid(ptp_mem_bridge_0_timestamp_valid), 
    .i_ecsr_quad_mem_data(ptp_mem_bridge_0_ptp_mem_clr_data), 
    .i_ecsr_quad_ts_storage_rd_en(ptp_mem_bridge_0_clear_ts_reg), 
    .i_sync(physs_timesync_sync_val), 
    .ts_int(physs_timestamp_0_ts_int), 
    .o_int(physs_timestamp_0_o_int), 
    .i_ecsr_addr(ptp_mem_bridge_0_clear_ts_reg_addr), 
    .o_timer_capture_tx(), 
    .o_timer_capture_rx(), 
    .ts_time_cnt_tx_0(), 
    .ts_ts_o_int(), 
    .ts_time_cnt_0(), 
    .ts_time_cnt_1(), 
    .ts_time_cnt_2(), 
    .ts_time_cnt_3(), 
    .ts_timestamp_valid_cnt_0(), 
    .ts_timestamp_valid_cnt_1(), 
    .ts_timestamp_valid_cnt_2(), 
    .ts_timestamp_valid_cnt_3(), 
    .ts_timestamp_status_reg_0(), 
    .ts_timestamp_status_reg_1(), 
    .ts_timestamp_status_reg_2(), 
    .ts_timestamp_status_reg_3(), 
    .ts_i_ecsr_addr_0(), 
    .ts_i_ecsr_addr_1(), 
    .ts_i_ecsr_addr_2(), 
    .ts_i_ecsr_addr_3(), 
    .ts_i_ecsr_quad_ts_storage_rd_en_0(), 
    .ts_i_ecsr_quad_ts_storage_rd_en_1(), 
    .ts_i_ecsr_quad_ts_storage_rd_en_2(), 
    .ts_i_ecsr_quad_ts_storage_rd_en_3()
) ; 
ahb2mem_slave ptp_mem_bridge_0 (
    .reg_dout({ptpx_mem_wrapper_0_ptptx_rdata0_2,ptpx_mem_wrapper_0_ptptx_rdata0_1,ptpx_mem_wrapper_0_ptptx_rdata0_0,ptpx_mem_wrapper_0_ptptx_rdata0}), 
    .reg_rden(ptp_mem_bridge_0_reg_rden), 
    .reg_addr({hidft_open_23,ptp_mem_bridge_0_reg_addr,hidft_open_24}), 
    .hresetn(physs_clock_sync_0_func_rstn_fabric_sync), 
    .hclk(soc_per_clk_pdop_parmquad0_clkout), 
    .reg_busy(1'b0), 
    .timestamp_valid(ptp_mem_bridge_0_timestamp_valid), 
    .ptp_mem_clr_data(ptp_mem_bridge_0_ptp_mem_clr_data), 
    .clear_ts_reg(ptp_mem_bridge_0_clear_ts_reg), 
    .hready(DW_ahb_0_hready), 
    .haddr(DW_ahb_0_haddr_s17), 
    .hsize(DW_ahb_0_hsize_0), 
    .htrans(DW_ahb_0_htrans_0), 
    .hwdata(DW_ahb_0_hwdata_0), 
    .hwrite(DW_ahb_0_hwrite_0), 
    .hreadyout(ptp_mem_bridge_0_hreadyout), 
    .hresp(ptp_mem_bridge_0_hresp), 
    .hrdata(ptp_mem_bridge_0_hrdata), 
    .hsel(DW_ahb_0_hsel_s17), 
    .clear_ts_reg_addr(ptp_mem_bridge_0_clear_ts_reg_addr), 
    .reg_wren(), 
    .reg_din()
) ; 
ptpx_mem_wrapper_2r2w ptpx_mem_wrapper_0 (
    .ptptx_wren0(physs_timestamp_0_ptp_mem_wr), 
    .ptptx_waddr0({physs_timestamp_0_ptp_mem_waddr[3],physs_timestamp_0_ptp_mem_waddr[2],physs_timestamp_0_ptp_mem_waddr[1],physs_timestamp_0_ptp_mem_waddr[0]}), 
    .ptptx_wdata0({1'b0,physs_timestamp_0_ptp_mem_data[3],1'b0,physs_timestamp_0_ptp_mem_data[2],1'b0,physs_timestamp_0_ptp_mem_data[1],1'b0,physs_timestamp_0_ptp_mem_data[0]}), 
    .ptptx_rdata0({hidft_open_25,ptpx_mem_wrapper_0_ptptx_rdata0_2,hidft_open_26,ptpx_mem_wrapper_0_ptptx_rdata0_1,hidft_open_27,ptpx_mem_wrapper_0_ptptx_rdata0_0,hidft_open_28,ptpx_mem_wrapper_0_ptptx_rdata0}), 
    .ptptx_rden0(ptp_mem_bridge_0_reg_rden), 
    .ptptx_raddr0({ptp_mem_bridge_0_reg_addr,ptp_mem_bridge_0_reg_addr,ptp_mem_bridge_0_reg_addr,ptp_mem_bridge_0_reg_addr}), 
    .ptptx_wren1(physs_timestamp_0_ptp_mem_clr), 
    .ptptx_waddr1({physs_timestamp_0_ptp_mem_raddr[3],physs_timestamp_0_ptp_mem_raddr[2],physs_timestamp_0_ptp_mem_raddr[1],physs_timestamp_0_ptp_mem_raddr[0]}), 
    .ptptx_wdata1({1'b0,physs_timestamp_0_ptp_mem_clr_data[3],1'b0,physs_timestamp_0_ptp_mem_clr_data[2],1'b0,physs_timestamp_0_ptp_mem_clr_data[1],1'b0,physs_timestamp_0_ptp_mem_clr_data[0]}), 
    .physs_func_clk0(physs_clock_sync_0_physs_ptpmem_wr_clk0), 
    .physs_func_clk2(physs_clock_sync_0_physs_ptpmem_wr_clk2), 
    .soc_per_clk0(physs_clock_sync_0_physs_ptpmem_rd_clk0), 
    .soc_per_clk2(physs_clock_sync_0_physs_ptpmem_rd_clk2), 
    .ptptx_rden1(4'b0), 
    .ptptx_raddr1(28'b0), 
    .hs2r2w_trim_fuse_in(physs_rfhs_trim_fuse_in), 
    .pwrgood_rst_b(physs_func_rst_raw_n), 
    .ptptx_rdata1(), 
    .DFT_ARRAY_FREEZE(1'b0), 
    .DFT_AFD_RESET_B(1'b0), 
    .DFTMASK(1'b0), 
    .DFTSHIFTEN(1'b0)
) ; 
quad_interrupts quad_interrupts_0 (
    .physs_int_ovveride_reg0(physs_registers_wrapper_0_physs_int_ovveride_reg0_icu), 
    .physs_int_ovveride_reg1(physs_registers_wrapper_0_physs_int_ovveride_reg1_icu), 
    .physs_int_ovveride_reg2(physs_registers_wrapper_0_physs_int_ovveride_reg2_icu), 
    .physs_int_ovveride_reg3(physs_registers_wrapper_0_physs_int_ovveride_reg3_icu), 
    .physs_int_ovveride_reg4(physs_registers_wrapper_0_physs_int_ovveride_reg4_icu), 
    .physs_int_ovveride_reg5(physs_registers_wrapper_0_physs_int_ovveride_reg5_icu), 
    .physs_irq_mask_reg0_icu(physs_registers_wrapper_0_physs_irq_mask_reg0_icu), 
    .physs_irq_mask_reg1_icu(physs_registers_wrapper_0_physs_irq_mask_reg1_icu), 
    .physs_irq_mask_reg2_icu(physs_registers_wrapper_0_physs_irq_mask_reg2_icu), 
    .physs_irq_mask_reg3_icu(physs_registers_wrapper_0_physs_irq_mask_reg3_icu), 
    .physs_irq_mask_reg4_icu(physs_registers_wrapper_0_physs_irq_mask_reg4_icu), 
    .physs_irq_mask_reg5_icu(physs_registers_wrapper_0_physs_irq_mask_reg5_icu), 
    .physs_irq_raw_status_reg0_icu(quad_interrupts_0_physs_irq_raw_status_reg0_icu), 
    .physs_irq_raw_status_reg1_icu(quad_interrupts_0_physs_irq_raw_status_reg1_icu), 
    .physs_irq_raw_status_reg2_icu(quad_interrupts_0_physs_irq_raw_status_reg2_icu), 
    .physs_irq_raw_status_reg3_icu(quad_interrupts_0_physs_irq_raw_status_reg3_icu), 
    .physs_irq_raw_status_reg4_icu(quad_interrupts_0_physs_irq_raw_status_reg4_icu), 
    .physs_irq_raw_status_reg5_icu(quad_interrupts_0_physs_irq_raw_status_reg5_icu), 
    .physs_irq_reset_reg0_icu(physs_registers_wrapper_0_physs_irq_reset_reg0_icu), 
    .physs_irq_reset_reg1_icu(physs_registers_wrapper_0_physs_irq_reset_reg1_icu), 
    .physs_irq_reset_reg2_icu(physs_registers_wrapper_0_physs_irq_reset_reg2_icu), 
    .physs_irq_reset_reg3_icu(physs_registers_wrapper_0_physs_irq_reset_reg3_icu), 
    .physs_irq_reset_reg4_icu(physs_registers_wrapper_0_physs_irq_reset_reg4_icu), 
    .physs_irq_reset_reg5_icu(physs_registers_wrapper_0_physs_irq_reset_reg5_icu), 
    .physs_irq_status_reg0_icu(quad_interrupts_0_physs_irq_status_reg0_icu), 
    .physs_irq_status_reg1_icu(quad_interrupts_0_physs_irq_status_reg1_icu), 
    .physs_irq_status_reg2_icu(quad_interrupts_0_physs_irq_status_reg2_icu), 
    .physs_irq_status_reg3_icu(quad_interrupts_0_physs_irq_status_reg3_icu), 
    .physs_irq_status_reg4_icu(quad_interrupts_0_physs_irq_status_reg4_icu), 
    .physs_irq_status_reg5_icu(quad_interrupts_0_physs_irq_status_reg5_icu), 
    .physs_fatal_int(quad_interrupts_0_physs_fatal_int), 
    .physs_imc_int(quad_interrupts_0_physs_imc_int), 
    .mac800_int(quad_interrupts_0_mac800_int), 
    .reg_clk(physs_clock_sync_0_physs_func_clk_gated_100), 
    .reg_reset_n(physs_func_rst_raw_n), 
    .ff_rx_err_q0m0_si(mac100_0_ff_rx_err), 
    .ff_rx_err_ecc_stat_q0m0_si(mac100_0_ff_rx_err_stat), 
    .tx_underflow_q0m0_si(mac100_0_tx_underflow), 
    .tx_ovr_err_q0m0_si(mac100_0_ff_tx_ovr), 
    .rx_empty_q0m0_si(mac100_0_ff_rx_empty), 
    .loc_fault_q0m0_si(mac100_0_loc_fault), 
    .rem_fault_q0m0_si(mac100_0_rem_fault), 
    .li_fault_q0m0_si(mac100_0_li_fault), 
    .ff_rx_err_q0m1_si(mac100_1_ff_rx_err), 
    .ff_rx_err_ecc_stat_q0m1_si(mac100_1_ff_rx_err_stat), 
    .tx_underflow_q0m1_si(mac100_1_tx_underflow), 
    .tx_ovr_err_q0m1_si(mac100_1_ff_tx_ovr), 
    .rx_empty_q0m1_si(mac100_1_ff_rx_empty), 
    .loc_fault_q0m1_si(mac100_1_loc_fault), 
    .rem_fault_q0m1_si(mac100_1_rem_fault), 
    .li_fault_q0m1_si(mac100_1_li_fault), 
    .ff_rx_err_q0m2_si(mac100_2_ff_rx_err), 
    .ff_rx_err_ecc_stat_q0m2_si(mac100_2_ff_rx_err_stat), 
    .tx_underflow_q0m2_si(mac100_2_tx_underflow), 
    .tx_ovr_err_q0m2_si(mac100_2_ff_tx_ovr), 
    .rx_empty_q0m2_si(mac100_2_ff_rx_empty), 
    .loc_fault_q0m2_si(mac100_2_loc_fault), 
    .rem_fault_q0m2_si(mac100_2_rem_fault), 
    .li_fault_q0m2_si(mac100_2_li_fault), 
    .ff_rx_err_q0m3_si(mac100_3_ff_rx_err), 
    .ff_rx_err_ecc_stat_q0m3_si(mac100_3_ff_rx_err_stat), 
    .tx_underflow_q0m3_si(mac100_3_tx_underflow), 
    .tx_ovr_err_q0m3_si(mac100_3_ff_tx_ovr), 
    .rx_empty_q0m3_si(mac100_3_ff_rx_empty), 
    .loc_fault_q0m3_si(mac100_3_loc_fault), 
    .rem_fault_q0m3_si(mac100_3_rem_fault), 
    .li_fault_q0m3_si(mac100_3_li_fault), 
    .ff_rx_err_m400_q0m0_si(mac400_0_ff_rx_err), 
    .ff_tx_ovr_err_m400_q0m0_si(1'b0), 
    .tx_underflow_m400_q0m0_si(mac400_0_tx_underflow), 
    .tx_ovr_err_m400_q0m0_si(mac400_0_tx_ovr_err), 
    .loc_fault_m400_q0m0_si(mac400_0_loc_fault), 
    .rem_fault_m400_q0m0_si(mac400_0_rem_fault), 
    .li_fault_m400_q0m0_si(mac400_0_li_fault), 
    .ff_rx_err_m400_q0m1_si(mac200_0_ff_rx_err), 
    .ff_tx_ovr_err_m400_q0m1_si(1'b0), 
    .tx_underflow_m400_q0m1_si(mac200_0_tx_underflow), 
    .tx_ovr_err_m400_q0m1_si(mac200_0_tx_ovr_err), 
    .loc_fault_m400_q0m1_si(mac200_0_loc_fault), 
    .rem_fault_m400_q0m1_si(mac200_0_rem_fault), 
    .li_fault_m400_q0m1_si(mac200_0_li_fault), 
    .link_status_p400_q0p0_si(pcs400_0_link_status), 
    .hi_ser_p400_q0p0_si(4'b0), 
    .align_done_p400_q0p0_si(pcs400_0_align_lock), 
    .amps_lock_p400_q0p0_si(pcs400_0_amps_lock), 
    .degrade_ser_p400_q0p0_si(pcs400_0_degrade_ser), 
    .rx_am_sf_p400_q0p0_si(pcs400_0_rx_am_sf), 
    .link_status_p400_q0p1_si(pcs200_0_link_status), 
    .hi_ser_p400_q0p1_si(4'b0), 
    .align_done_p400_q0p1_si(pcs200_0_align_lock), 
    .amps_lock_p400_q0p1_si(pcs200_0_amps_lock), 
    .degrade_ser_p400_q0p1_si(pcs200_0_degrade_ser), 
    .rx_am_sf_p400_q0p1_si(pcs200_0_rx_am_sf), 
    .signal_det_q0_si(4'b0), 
    .pcs_link_status_q0_si(quadpcs100_0_pcs_link_status), 
    .pcs_hi_ber_q0_si(quadpcs100_0_pcs_hi_ber), 
    .pcs_align_done_q0_si(quadpcs100_0_pcs_align_done), 
    .pcs_desk_buf_rlevel_q0_si(4'b0), 
    .pcs_amps_lock_q0_si(quadpcs100_0_pcs_amps_lock), 
    .pcs_rsfec_aligned_q0_si(quadpcs100_0_pcs_rsfec_aligned), 
    .bresp_slave_physs_q0_si(1'b0), 
    .rresp_slave_physs_q0_si(1'b0), 
    .mac400_int(quad_interrupts_0_mac400_int), 
    .mac100_int(quad_interrupts_0_mac100_int), 
    .nic400_int(), 
    .pcs400_int(), 
    .pcs100_int(), 
    .quad_interrupt_out()
) ; 
visa_wrap visa_wrap_0 () ; 
// EDIT_INSTANCE END

// EDIT_CONTINUOUS_ASSIGN BEGIN
assign quadpcs100_0_pcs_desk_buf_rlevel_7 = quadpcs100_0_pcs_desk_buf_rlevel_2 ; 
assign quadpcs100_0_pcs_desk_buf_rlevel_6 = quadpcs100_0_pcs_desk_buf_rlevel_1 ; 
assign quadpcs100_0_pcs_desk_buf_rlevel_5 = quadpcs100_0_pcs_desk_buf_rlevel_0 ; 
assign quadpcs100_0_pcs_desk_buf_rlevel_4 = quadpcs100_0_pcs_desk_buf_rlevel ; 
assign mac100_0_mdio_oen_0 = mac100_0_mdio_oen ; 
assign mac100_3_pause_on_0 = mac100_3_pause_on ; 
assign mac100_2_pause_on_0 = mac100_2_pause_on ; 
assign mac100_1_pause_on_0 = mac100_1_pause_on ; 
assign mac100_0_pause_on_0 = mac100_0_pause_on ; 
assign mac100_3_magic_ind_0 = mac100_3_magic_ind ; 
assign mac100_2_magic_ind_0 = mac100_2_magic_ind ; 
assign mac100_1_magic_ind_0 = mac100_1_magic_ind ; 
assign mac100_0_magic_ind_0 = mac100_0_magic_ind ; 
assign physs_clock_sync_0_func_rstn_fabric_sync_0 = physs_clock_sync_0_func_rstn_fabric_sync ; 
assign physs_clock_sync_0_physs_func_clk_gated_100_0 = physs_clock_sync_0_physs_func_clk_gated_100 ; 
// EDIT_CONTINUOUS_ASSIGN END
endmodule
