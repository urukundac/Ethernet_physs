/*------------------------------------------------------------------------------
  INTEL CONFIDENTIAL
  Copyright 2022 Intel Corporation All Rights Reserved.
  -----------------------------------------------------------------------------*/

module physs0
// EDIT_PORT BEGIN
 ( 
input [31:0] SSN_START_entry_from_nac_bus_data_in,
input SSN_START_entry_from_nac_bus_clock_in,
input [31:0] SSN_START_from_parmisc_physs1_bus_data_in,
output [31:0] SSN_END_entry_from_nac_bus_data_out,
output [31:0] SSN_END_exit_to_nac_bus_data_out,
output [31:0] SSN_END_towards_parmisc_physs1_bus_data_out,
inout [3:0] ioa_ck_pma3_ref_right_mquad0_physs0, //abutment signal on pam3
inout [3:0] ioa_ck_pma0_ref_left_mquad0_physs0, //abutment signal on pam0
inout [3:0] ioa_ck_pma0_ref_left_mquad1_physs0, //abutment signal on pam0
inout [3:0] ioa_ck_pma3_ref_right_mquad1_physs0, //abutment signal on pam3
output mbp_repeater_odi_parmisc_physs0_5_ubp_out,
output mbp_repeater_sfe_parmisc_physs0_2_ubp_out,
input [7:0] dfxagg_security_policy,
input dfxagg_policy_update,
input dfxagg_early_boot_debug_exit,
input [7:0] dfxagg_debug_capabilities_enabling,
input dfxagg_debug_capabilities_enabling_valid,
input fdfx_powergood,
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
input ETH_RXN4,
input ETH_RXP4,
input ETH_RXN5,
input ETH_RXP5,
input ETH_RXN6,
input ETH_RXP6,
input ETH_RXN7,
input ETH_RXP7,
output versa_xmp_1_xoa_pma0_tx_n_l0,
output versa_xmp_1_xoa_pma0_tx_p_l0,
output versa_xmp_1_xoa_pma1_tx_n_l0,
output versa_xmp_1_xoa_pma1_tx_p_l0,
output versa_xmp_1_xoa_pma2_tx_n_l0,
output versa_xmp_1_xoa_pma2_tx_p_l0,
output versa_xmp_1_xoa_pma3_tx_n_l0,
output versa_xmp_1_xoa_pma3_tx_p_l0,
inout wire ioa_pma_remote_diode_i_anode,
inout wire ioa_pma_remote_diode_i_anode_0,
inout wire ioa_pma_remote_diode_i_anode_1,
inout wire ioa_pma_remote_diode_i_anode_2,
inout wire ioa_pma_remote_diode_i_anode_3,
inout wire ioa_pma_remote_diode_i_anode_4,
inout wire ioa_pma_remote_diode_i_anode_5,
inout wire ioa_pma_remote_diode_i_anode_6,
inout wire ioa_pma_remote_diode_v_anode,
inout wire ioa_pma_remote_diode_v_anode_0,
inout wire ioa_pma_remote_diode_v_anode_1,
inout wire ioa_pma_remote_diode_v_anode_2,
inout wire ioa_pma_remote_diode_v_anode_3,
inout wire ioa_pma_remote_diode_v_anode_4,
inout wire ioa_pma_remote_diode_v_anode_5,
inout wire ioa_pma_remote_diode_v_anode_6,
inout wire ioa_pma_remote_diode_i_cathode,
inout wire ioa_pma_remote_diode_i_cathode_0,
inout wire ioa_pma_remote_diode_i_cathode_1,
inout wire ioa_pma_remote_diode_i_cathode_2,
inout wire ioa_pma_remote_diode_i_cathode_3,
inout wire ioa_pma_remote_diode_i_cathode_4,
inout wire ioa_pma_remote_diode_i_cathode_5,
inout wire ioa_pma_remote_diode_i_cathode_6,
inout wire ioa_pma_remote_diode_v_cathode,
inout wire ioa_pma_remote_diode_v_cathode_0,
inout wire ioa_pma_remote_diode_v_cathode_1,
inout wire ioa_pma_remote_diode_v_cathode_2,
inout wire ioa_pma_remote_diode_v_cathode_3,
inout wire ioa_pma_remote_diode_v_cathode_4,
inout wire ioa_pma_remote_diode_v_cathode_5,
inout wire ioa_pma_remote_diode_v_cathode_6,
input [3:0] quadpcs100_2_pcs_link_status,
input [3:0] quadpcs100_3_pcs_link_status,
input physs_mse_800g_en,
input physs_reset_prep_req,
output fifo_top_mux_0_physs_scon_reset_prep_ack,
input [5:0] physs_hd2prf_trim_fuse_in,
input [5:0] physs_hdp2prf_trim_fuse_in,
input [7:0] physs_rfhs_trim_fuse_in,
input [15:0] physs_hdspsr_trim_fuse_in,
input physs_bbl_800G_0_disable,
input physs_bbl_400G_0_disable,
input physs_bbl_200G_0_disable,
input physs_bbl_100G_0_disable,
input [3:0] physs_bbl_serdes_0_disable,
input physs_bbl_400G_1_disable,
input physs_bbl_200G_1_disable,
input physs_bbl_100G_1_disable,
input [3:0] physs_bbl_serdes_1_disable,
input physs_bbl_spare_0,
input physs_bbl_spare_1,
input [3:0] ack_from_fabric_0,
input [3:0] req_from_fabric_0,
output [3:0] dfd_rtb_trig_ctf_adapter_0_trig_req_to_fabric,
output [3:0] dfd_rtb_trig_ctf_adapter_0_ack_to_fabric,
input [3:0] ack_from_fabric_1,
input [3:0] req_from_fabric_1,
output [3:0] dfd_rtb_trig_ctf_adapter_1_trig_req_to_fabric,
output [3:0] dfd_rtb_trig_ctf_adapter_1_ack_to_fabric,
input physs_bbl_100G_2_disable,
input physs_bbl_100G_3_disable,
input ethphyss_post_clkungate,
output wire physs_intf0_clk_adop_parmisc_physs0_clkout,
output wire soc_per_clk_adop_parmisc_physs0_clkout_0,
output wire physs_func_clk_adop_parmisc_physs0_clkout,
input wire physs_intf0_clk,
input wire physs_funcx2_clk,
input wire soc_per_clk,
input wire tsu_clk,
input wire o_ck_pma0_rx_postdiv_l0_adop_parpquad0_clkout,
input wire o_ck_pma1_rx_postdiv_l0_adop_parpquad0_clkout,
input wire o_ck_pma2_rx_postdiv_l0_adop_parpquad0_clkout,
input wire o_ck_pma3_rx_postdiv_l0_adop_parpquad0_clkout,
input wire o_ck_pma0_rx_postdiv_l0_adop_parpquad1_clkout,
input wire o_ck_pma1_rx_postdiv_l0_adop_parpquad1_clkout,
input wire o_ck_pma2_rx_postdiv_l0_adop_parpquad1_clkout,
input wire o_ck_pma3_rx_postdiv_l0_adop_parpquad1_clkout,
input fscan_txrxword_byp_clk,
input wire fscan_ref_clk,
output wire fscan_ref_clk_adop_parmisc_physs0_clkout_0,
input wire nss_cosq_clk0,
input wire nss_cosq_clk1,
input wire clk_1588_freq,
output wire o_ck_pma0_cmnplla_postdiv_clk_mux_parmquad0_clkout_0,
input wire i_ck_ucss_uart_sclk,
output wire uart_clk_adop_parmisc_physs0_clkout_0,
output wire uart_sel_and2_o,
output wire uart_sel_and3_o,
output fifo_top_mux_0_physs0_icq_port_0_link_stat,
output [3:0] fifo_top_mux_0_physs0_mse_port_0_link_speed,
output fifo_top_mux_0_physs0_mse_port_0_rx_dval,
output [1023:0] fifo_top_mux_0_physs0_mse_port_0_rx_data,
output fifo_top_mux_0_physs0_mse_port_0_rx_sop,
output fifo_top_mux_0_physs0_mse_port_0_rx_eop,
output [6:0] fifo_top_mux_0_physs0_mse_port_0_rx_mod,
output fifo_top_mux_0_physs0_mse_port_0_rx_err,
output fifo_top_mux_0_physs0_mse_port_0_rx_ecc_err,
output [38:0] fifo_top_mux_0_physs0_mse_port_0_rx_ts,
output fifo_top_mux_0_physs0_mse_port_0_tx_rdy,
output fifo_top_mux_0_physs0_mse_port_0_pfc_mode,
input mse_physs_port_0_rx_rdy,
input mse_physs_port_0_tx_wren,
input [1023:0] mse_physs_port_0_tx_data,
input mse_physs_port_0_tx_sop,
input mse_physs_port_0_tx_eop,
input [6:0] mse_physs_port_0_tx_mod,
input mse_physs_port_0_tx_err,
input mse_physs_port_0_tx_crc,
input mse_physs_port_0_ts_capture_vld,
input [6:0] mse_physs_port_0_ts_capture_idx,
output fifo_top_mux_0_physs0_icq_port_1_link_stat,
output [3:0] fifo_top_mux_0_physs0_mse_port_1_link_speed,
output fifo_top_mux_0_physs0_mse_port_1_rx_dval,
output [255:0] fifo_top_mux_0_physs0_mse_port_1_rx_data,
output fifo_top_mux_0_physs0_mse_port_1_rx_sop,
output fifo_top_mux_0_physs0_mse_port_1_rx_eop,
output [4:0] fifo_top_mux_0_physs0_mse_port_1_rx_mod,
output fifo_top_mux_0_physs0_mse_port_1_rx_err,
output fifo_top_mux_0_physs0_mse_port_1_rx_ecc_err,
output [38:0] fifo_top_mux_0_physs0_mse_port_1_rx_ts,
output fifo_top_mux_0_physs0_mse_port_1_tx_rdy,
output fifo_top_mux_0_physs0_mse_port_1_pfc_mode,
input mse_physs_port_1_rx_rdy,
input mse_physs_port_1_tx_wren,
input [255:0] mse_physs_port_1_tx_data,
input mse_physs_port_1_tx_sop,
input mse_physs_port_1_tx_eop,
input [4:0] mse_physs_port_1_tx_mod,
input mse_physs_port_1_tx_err,
input mse_physs_port_1_tx_crc,
input mse_physs_port_1_ts_capture_vld,
input [6:0] mse_physs_port_1_ts_capture_idx,
output fifo_top_mux_0_physs0_icq_port_2_link_stat,
output [3:0] fifo_top_mux_0_physs0_mse_port_2_link_speed,
output fifo_top_mux_0_physs0_mse_port_2_rx_dval,
output [511:0] fifo_top_mux_0_physs0_mse_port_2_rx_data,
output fifo_top_mux_0_physs0_mse_port_2_rx_sop,
output fifo_top_mux_0_physs0_mse_port_2_rx_eop,
output [5:0] fifo_top_mux_0_physs0_mse_port_2_rx_mod,
output fifo_top_mux_0_physs0_mse_port_2_rx_err,
output fifo_top_mux_0_physs0_mse_port_2_rx_ecc_err,
output [38:0] fifo_top_mux_0_physs0_mse_port_2_rx_ts,
output fifo_top_mux_0_physs0_mse_port_2_tx_rdy,
output fifo_top_mux_0_physs0_mse_port_2_pfc_mode,
input mse_physs_port_2_rx_rdy,
input mse_physs_port_2_tx_wren,
input [511:0] mse_physs_port_2_tx_data,
input mse_physs_port_2_tx_sop,
input mse_physs_port_2_tx_eop,
input [5:0] mse_physs_port_2_tx_mod,
input mse_physs_port_2_tx_err,
input mse_physs_port_2_tx_crc,
input mse_physs_port_2_ts_capture_vld,
input [6:0] mse_physs_port_2_ts_capture_idx,
output fifo_top_mux_0_physs0_icq_port_3_link_stat,
output [3:0] fifo_top_mux_0_physs0_mse_port_3_link_speed,
output fifo_top_mux_0_physs0_mse_port_3_rx_dval,
output [255:0] fifo_top_mux_0_physs0_mse_port_3_rx_data,
output fifo_top_mux_0_physs0_mse_port_3_rx_sop,
output fifo_top_mux_0_physs0_mse_port_3_rx_eop,
output [4:0] fifo_top_mux_0_physs0_mse_port_3_rx_mod,
output fifo_top_mux_0_physs0_mse_port_3_rx_err,
output fifo_top_mux_0_physs0_mse_port_3_rx_ecc_err,
output [38:0] fifo_top_mux_0_physs0_mse_port_3_rx_ts,
output fifo_top_mux_0_physs0_mse_port_3_tx_rdy,
output fifo_top_mux_0_physs0_mse_port_3_pfc_mode,
input mse_physs_port_3_rx_rdy,
input mse_physs_port_3_tx_wren,
input [255:0] mse_physs_port_3_tx_data,
input mse_physs_port_3_tx_sop,
input mse_physs_port_3_tx_eop,
input [4:0] mse_physs_port_3_tx_mod,
input mse_physs_port_3_tx_err,
input mse_physs_port_3_tx_crc,
input mse_physs_port_3_ts_capture_vld,
input [6:0] mse_physs_port_3_ts_capture_idx,
output fifo_top_mux_0_physs1_icq_port_4_link_stat,
output [3:0] fifo_top_mux_0_physs1_mse_port_4_link_speed,
output fifo_top_mux_0_physs1_mse_port_4_rx_dval,
output [1023:0] fifo_top_mux_0_physs1_mse_port_4_rx_data,
output fifo_top_mux_0_physs1_mse_port_4_rx_sop,
output fifo_top_mux_0_physs1_mse_port_4_rx_eop,
output [6:0] fifo_top_mux_0_physs1_mse_port_4_rx_mod,
output fifo_top_mux_0_physs1_mse_port_4_rx_err,
output fifo_top_mux_0_physs1_mse_port_4_rx_ecc_err,
output [38:0] fifo_top_mux_0_physs1_mse_port_4_rx_ts,
output fifo_top_mux_0_physs1_mse_port_4_tx_rdy,
output fifo_top_mux_0_physs1_mse_port_4_pfc_mode,
input mse_physs_port_4_rx_rdy,
input mse_physs_port_4_tx_wren,
input [1023:0] mse_physs_port_4_tx_data,
input mse_physs_port_4_tx_sop,
input mse_physs_port_4_tx_eop,
input [6:0] mse_physs_port_4_tx_mod,
input mse_physs_port_4_tx_err,
input mse_physs_port_4_tx_crc,
input mse_physs_port_4_ts_capture_vld,
input [6:0] mse_physs_port_4_ts_capture_idx,
output fifo_top_mux_0_physs1_icq_port_5_link_stat,
output [3:0] fifo_top_mux_0_physs1_mse_port_5_link_speed,
output fifo_top_mux_0_physs1_mse_port_5_rx_dval,
output [255:0] fifo_top_mux_0_physs1_mse_port_5_rx_data,
output fifo_top_mux_0_physs1_mse_port_5_rx_sop,
output fifo_top_mux_0_physs1_mse_port_5_rx_eop,
output [4:0] fifo_top_mux_0_physs1_mse_port_5_rx_mod,
output fifo_top_mux_0_physs1_mse_port_5_rx_err,
output fifo_top_mux_0_physs1_mse_port_5_rx_ecc_err,
output [38:0] fifo_top_mux_0_physs1_mse_port_5_rx_ts,
output fifo_top_mux_0_physs1_mse_port_5_tx_rdy,
output fifo_top_mux_0_physs1_mse_port_5_pfc_mode,
input mse_physs_port_5_rx_rdy,
input mse_physs_port_5_tx_wren,
input [255:0] mse_physs_port_5_tx_data,
input mse_physs_port_5_tx_sop,
input mse_physs_port_5_tx_eop,
input [4:0] mse_physs_port_5_tx_mod,
input mse_physs_port_5_tx_err,
input mse_physs_port_5_tx_crc,
input mse_physs_port_5_ts_capture_vld,
input [6:0] mse_physs_port_5_ts_capture_idx,
output fifo_top_mux_0_physs1_icq_port_6_link_stat,
output [3:0] fifo_top_mux_0_physs1_mse_port_6_link_speed,
output fifo_top_mux_0_physs1_mse_port_6_rx_dval,
output [511:0] fifo_top_mux_0_physs1_mse_port_6_rx_data,
output fifo_top_mux_0_physs1_mse_port_6_rx_sop,
output fifo_top_mux_0_physs1_mse_port_6_rx_eop,
output [5:0] fifo_top_mux_0_physs1_mse_port_6_rx_mod,
output fifo_top_mux_0_physs1_mse_port_6_rx_err,
output fifo_top_mux_0_physs1_mse_port_6_rx_ecc_err,
output [38:0] fifo_top_mux_0_physs1_mse_port_6_rx_ts,
output fifo_top_mux_0_physs1_mse_port_6_tx_rdy,
output fifo_top_mux_0_physs1_mse_port_6_pfc_mode,
input mse_physs_port_6_rx_rdy,
input mse_physs_port_6_tx_wren,
input [511:0] mse_physs_port_6_tx_data,
input mse_physs_port_6_tx_sop,
input mse_physs_port_6_tx_eop,
input [5:0] mse_physs_port_6_tx_mod,
input mse_physs_port_6_tx_err,
input mse_physs_port_6_tx_crc,
input mse_physs_port_6_ts_capture_vld,
input [6:0] mse_physs_port_6_ts_capture_idx,
output fifo_top_mux_0_physs1_icq_port_7_link_stat,
output [3:0] fifo_top_mux_0_physs1_mse_port_7_link_speed,
output fifo_top_mux_0_physs1_mse_port_7_rx_dval,
output [255:0] fifo_top_mux_0_physs1_mse_port_7_rx_data,
output fifo_top_mux_0_physs1_mse_port_7_rx_sop,
output fifo_top_mux_0_physs1_mse_port_7_rx_eop,
output [4:0] fifo_top_mux_0_physs1_mse_port_7_rx_mod,
output fifo_top_mux_0_physs1_mse_port_7_rx_err,
output fifo_top_mux_0_physs1_mse_port_7_rx_ecc_err,
output [38:0] fifo_top_mux_0_physs1_mse_port_7_rx_ts,
output fifo_top_mux_0_physs1_mse_port_7_tx_rdy,
output fifo_top_mux_0_physs1_mse_port_7_pfc_mode,
input mse_physs_port_7_rx_rdy,
input mse_physs_port_7_tx_wren,
input [255:0] mse_physs_port_7_tx_data,
input mse_physs_port_7_tx_sop,
input mse_physs_port_7_tx_eop,
input [4:0] mse_physs_port_7_tx_mod,
input mse_physs_port_7_tx_err,
input mse_physs_port_7_tx_crc,
input mse_physs_port_7_ts_capture_vld,
input [6:0] mse_physs_port_7_ts_capture_idx,
output physs_registers_wrapper_0_reset_ref_clk_override,
output physs_registers_wrapper_0_reset_pcs100_override_en,
output physs_registers_wrapper_0_clk_gate_en_100G_mac_pcs,
output physs_registers_wrapper_0_power_fsm_clk_gate_en,
output physs_registers_wrapper_0_power_fsm_reset_gate_en,
output physs_registers_wrapper_1_reset_ref_clk_override,
output physs_registers_wrapper_1_reset_pcs100_override_en,
output physs_registers_wrapper_1_clk_gate_en_100G_mac_pcs,
output physs_registers_wrapper_1_power_fsm_clk_gate_en,
output physs_registers_wrapper_1_power_fsm_reset_gate_en,
input physs_registers_wrapper_2_reset_ref_clk_override_0,
input physs_registers_wrapper_2_reset_pcs100_override_en_0,
input physs_registers_wrapper_2_clk_gate_en_100G_mac_pcs_0,
input physs_registers_wrapper_2_power_fsm_clk_gate_en_0,
input physs_registers_wrapper_2_power_fsm_reset_gate_en_0,
input physs_registers_wrapper_3_reset_ref_clk_override_0,
input physs_registers_wrapper_3_reset_pcs100_override_en_0,
input physs_registers_wrapper_3_clk_gate_en_100G_mac_pcs_0,
input physs_registers_wrapper_3_power_fsm_clk_gate_en_0,
input physs_registers_wrapper_3_power_fsm_reset_gate_en_0,
input pd_vinf_0_bisr_si,
input pd_vinf_0_bisr_clk,
input pd_vinf_0_bisr_reset,
input pd_vinf_0_bisr_shift_en,
output parmisc_physs0_pd_vinf_0_2_bisr_so,
input pd_vinf_1_bisr_si,
input pd_vinf_1_bisr_clk,
input pd_vinf_1_bisr_reset,
input pd_vinf_1_bisr_shift_en,
output parmisc_physs0_pd_vinf_1_2_bisr_so,
input pd_vinf_2_bisr_si,
input pd_vinf_2_bisr_clk,
input pd_vinf_2_bisr_reset,
input pd_vinf_2_bisr_shift_en,
output parmisc_physs0_pd_vinf_2_2_bisr_so,
input pd_vinf_3_bisr_si,
input pd_vinf_3_bisr_clk,
input pd_vinf_3_bisr_reset,
input pd_vinf_3_bisr_shift_en,
output parmisc_physs0_pd_vinf_3_2_bisr_so,
input pd_vinf_4_bisr_si,
input pd_vinf_4_bisr_clk,
input pd_vinf_4_bisr_reset,
input pd_vinf_4_bisr_shift_en,
output parmisc_physs0_pd_vinf_4_2_bisr_so,
input pd_vinf_5_bisr_si,
output parmisc_physs0_pd_vinf_5_bisr_so,
input parmisc_physs1_pd_vinf_5_2_bisr_so,
output parmisc_physs0_pd_vinf_5_2_bisr_so,
input wire pd_vinf_5_bisr_reset,
input wire pd_vinf_5_bisr_shift_en,
input wire pd_vinf_5_bisr_clk,
input pd_vinf_6_bisr_si,
output parmisc_physs0_pd_vinf_6_bisr_so,
input parmisc_physs1_pd_vinf_6_2_bisr_so,
output parmisc_physs0_pd_vinf_6_2_bisr_so,
input wire pd_vinf_6_bisr_reset,
input wire pd_vinf_6_bisr_shift_en,
input wire pd_vinf_6_bisr_clk,
input physs0_func_rst_raw_n,
input ethphyss_post_clk_mux_ctrl,
output physs_synce_top_mux_0_clkout,
output physs_synce_top_mux_1_clkout,
output parmisc_physs0_DIAG_AGGR_parmisc0_mbist_diag_done,
input parpquad0_DIAG_AGGR_pquad_mbist_diag_done,
input parpquad1_DIAG_AGGR_pquad_mbist_diag_done,
output hlp_mac_rx_throttle_0_stop,
output hlp_mac_rx_throttle_1_stop,
output hlp_mac_rx_throttle_2_stop,
output hlp_mac_rx_throttle_3_stop,
input tx_stop_0_in,
input tx_stop_1_in,
input tx_stop_2_in,
input tx_stop_3_in,
output mac100_0_magic_ind_0,
output mac100_1_magic_ind_0,
output mac100_2_magic_ind_0,
output mac100_3_magic_ind_0,
output mac100_4_magic_ind_0,
output mac100_5_magic_ind_0,
output mac100_6_magic_ind_0,
output mac100_7_magic_ind_0,
input [7:0] icq_physs_net_xoff,
input [7:0] icq_physs_net_xoff_0,
input [7:0] icq_physs_net_xoff_1,
input [7:0] icq_physs_net_xoff_2,
input [7:0] icq_physs_net_xoff_3,
input [7:0] icq_physs_net_xoff_4,
input [7:0] icq_physs_net_xoff_5,
input [7:0] icq_physs_net_xoff_6,
output [7:0] mac100_0_pause_on_0,
output [7:0] mac100_1_pause_on_0,
output [7:0] mac100_2_pause_on_0,
output [7:0] mac100_3_pause_on_0,
output [7:0] mac100_4_pause_on_0,
output [7:0] mac100_5_pause_on_0,
output [7:0] mac100_6_pause_on_0,
output [7:0] mac100_7_pause_on_0,
input versa_xmp_2_o_ucss_uart_txd,
input versa_xmp_3_o_ucss_uart_txd,
output physs_uart_demux_out2,
output physs_uart_demux_out3,
output physs_uart_mux_out,
input i_ucss_uart_rxd,
input fary_0_post_force_fail,
input fary_0_trigger_post,
input [5:0] fary_0_post_algo_select,
output wire ethphyss_post_agg_mquad_0_post_pass_agg,
output wire ethphyss_post_agg_mquad_0_post_complete_agg,
input fary_1_post_force_fail,
input fary_1_trigger_post,
input [5:0] fary_1_post_algo_select,
output wire ethphyss_post_agg_mquad_1_post_pass_agg,
output wire ethphyss_post_agg_mquad_1_post_complete_agg,
input fary_2_post_force_fail,
input fary_2_trigger_post,
input [5:0] fary_2_post_algo_select,
output wire ethphyss_post_agg_mquad_2_post_pass_agg,
output wire ethphyss_post_agg_mquad_2_post_complete_agg,
input fary_3_post_force_fail,
input fary_3_trigger_post,
input [5:0] fary_3_post_algo_select,
output wire ethphyss_post_agg_mquad_3_post_pass_agg,
output wire ethphyss_post_agg_mquad_3_post_complete_agg,
input wire xmp_mem_wrapper_2_aary_post_pass,
input wire xmp_mem_wrapper_2_aary_post_complete,
input wire xmp_mem_wrapper_3_aary_post_pass,
input wire xmp_mem_wrapper_3_aary_post_complete,
output wire ethphyss_post_agg_pquad_4_post_pass_agg,
output wire ethphyss_post_agg_pquad_4_post_complete_agg,
input wire pcs100_mem_wrapper_2_aary_post_pass,
input wire pcs100_mem_wrapper_2_aary_post_complete,
input wire pcs100_mem_wrapper_3_aary_post_pass,
input wire pcs100_mem_wrapper_3_aary_post_complete,
output wire ethphyss_post_agg_pquad_5_post_pass_agg,
output wire ethphyss_post_agg_pquad_5_post_complete_agg,
input fary_6_post_force_fail,
input fary_6_trigger_post,
input [5:0] fary_6_post_algo_select,
output wire ethphyss_post_agg_par800g_6_post_pass_agg,
output wire ethphyss_post_agg_par800g_6_post_complete_agg,
input fary_7_post_force_fail,
input fary_7_trigger_post,
input [5:0] fary_7_post_algo_select,
output wire ethphyss_post_agg_par400g0_7_post_pass_agg,
output wire ethphyss_post_agg_par400g0_7_post_complete_agg,
input fary_8_post_force_fail,
input fary_8_trigger_post,
input [5:0] fary_8_post_algo_select,
output wire ethphyss_post_agg_par400g0_8_post_pass_agg,
output wire ethphyss_post_agg_par400g0_8_post_complete_agg,
input fary_9_post_force_fail,
input fary_9_trigger_post,
input [5:0] fary_9_post_algo_select,
output wire ethphyss_post_agg_par400g1_9_post_pass_agg,
output wire ethphyss_post_agg_par400g1_9_post_complete_agg,
input fary_10_post_force_fail,
input fary_10_trigger_post,
input [5:0] fary_10_post_algo_select,
output wire ethphyss_post_agg_par400g1_10_post_pass_agg,
output wire ethphyss_post_agg_par400g1_10_post_complete_agg,
output parmisc_physs0_trig_clock_stop_to_parpquad0_pma0_txdat,
output parmisc_physs0_trig_clock_stop_to_parpquad0_pma1_txdat,
output parmisc_physs0_trig_clock_stop_to_parpquad0_pma2_txdat,
output parmisc_physs0_trig_clock_stop_to_parpquad0_pma3_txdat,
output parmisc_physs0_trig_clock_stop_to_parpquad0_o_ck_pma0_rx,
output parmisc_physs0_trig_clock_stop_to_parpquad0_o_ck_pma1_rx,
output parmisc_physs0_trig_clock_stop_to_parpquad0_o_ck_pma2_rx,
output parmisc_physs0_trig_clock_stop_to_parpquad0_o_ck_pma3_rx,
output parmisc_physs0_trig_clock_stop_to_parpquad0_pma0_rxdat,
output parmisc_physs0_trig_clock_stop_to_parpquad0_pma1_rxdat,
output parmisc_physs0_trig_clock_stop_to_parpquad0_pma2_rxdat,
output parmisc_physs0_trig_clock_stop_to_parpquad0_pma3_rxdat,
output parmisc_physs0_trig_clock_stop_to_parpquad0_o_ck_pma0_cmnplla_postdiv,
output parmisc_physs0_trig_clock_stop_to_parpquad0_o_ck_pma1_cmnplla_postdiv,
output parmisc_physs0_trig_clock_stop_to_parpquad0_o_ck_pma2_cmnplla_postdiv,
output parmisc_physs0_trig_clock_stop_to_parpquad0_o_ck_pma3_cmnplla_postdiv,
output parmisc_physs0_trig_clock_stop_to_parpquad0_o_ck_slv_pcs1,
output parmisc_physs0_trig_clock_stop_to_parpquad0_o_ck_ucss_mem_dram,
output parmisc_physs0_trig_clock_stop_to_parpquad0_o_ck_ucss_mem_iram,
output parmisc_physs0_trig_clock_stop_to_parpquad0_o_ck_ucss_mem_tracemem,
output parmisc_physs0_trig_clock_stop_to_parpquad1_pma0_txdat,
output parmisc_physs0_trig_clock_stop_to_parpquad1_pma1_txdat,
output parmisc_physs0_trig_clock_stop_to_parpquad1_pma2_txdat,
output parmisc_physs0_trig_clock_stop_to_parpquad1_pma3_txdat,
output parmisc_physs0_trig_clock_stop_to_parpquad1_o_ck_pma0_rx,
output parmisc_physs0_trig_clock_stop_to_parpquad1_o_ck_pma1_rx,
output parmisc_physs0_trig_clock_stop_to_parpquad1_o_ck_pma2_rx,
output parmisc_physs0_trig_clock_stop_to_parpquad1_o_ck_pma3_rx,
output parmisc_physs0_trig_clock_stop_to_parpquad1_pma0_rxdat,
output parmisc_physs0_trig_clock_stop_to_parpquad1_pma1_rxdat,
output parmisc_physs0_trig_clock_stop_to_parpquad1_pma2_rxdat,
output parmisc_physs0_trig_clock_stop_to_parpquad1_pma3_rxdat,
output parmisc_physs0_trig_clock_stop_to_parpquad1_o_ck_pma0_cmnplla_postdiv,
output parmisc_physs0_trig_clock_stop_to_parpquad1_o_ck_pma1_cmnplla_postdiv,
output parmisc_physs0_trig_clock_stop_to_parpquad1_o_ck_pma2_cmnplla_postdiv,
output parmisc_physs0_trig_clock_stop_to_parpquad1_o_ck_pma3_cmnplla_postdiv,
output parmisc_physs0_trig_clock_stop_to_parpquad1_o_ck_slv_pcs1,
output parmisc_physs0_trig_clock_stop_to_parpquad1_o_ck_ucss_mem_dram,
output parmisc_physs0_trig_clock_stop_to_parpquad1_o_ck_ucss_mem_iram,
output parmisc_physs0_trig_clock_stop_to_parpquad1_o_ck_ucss_mem_tracemem,
output [27:0] quadpcs100_0_pcs_desk_buf_rlevel_0,
output [31:0] quadpcs100_0_pcs_sd_bit_slip_0,
output [3:0] quadpcs100_0_pcs_link_status_tsu_0,
output [27:0] quadpcs100_1_pcs_desk_buf_rlevel_0,
output [31:0] quadpcs100_1_pcs_sd_bit_slip_0,
output [3:0] quadpcs100_1_pcs_link_status_tsu_0,
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
inout wire versa_xmp_1_xioa_ck_pma0_ref0_n,
inout wire versa_xmp_1_xioa_ck_pma0_ref0_p,
inout wire versa_xmp_1_xioa_ck_pma0_ref1_n,
inout wire versa_xmp_1_xioa_ck_pma0_ref1_p,
inout wire versa_xmp_1_xioa_ck_pma1_ref0_n,
inout wire versa_xmp_1_xioa_ck_pma1_ref0_p,
inout wire versa_xmp_1_xioa_ck_pma1_ref1_n,
inout wire versa_xmp_1_xioa_ck_pma1_ref1_p,
inout wire versa_xmp_1_xioa_ck_pma2_ref0_n,
inout wire versa_xmp_1_xioa_ck_pma2_ref0_p,
inout wire versa_xmp_1_xioa_ck_pma2_ref1_n,
inout wire versa_xmp_1_xioa_ck_pma2_ref1_p,
inout wire versa_xmp_1_xioa_ck_pma3_ref0_n,
inout wire versa_xmp_1_xioa_ck_pma3_ref0_p,
inout wire versa_xmp_1_xioa_ck_pma3_ref1_n,
inout wire versa_xmp_1_xioa_ck_pma3_ref1_p,
output versa_xmp_1_xoa_pma0_dcmon1,
output versa_xmp_1_xoa_pma0_dcmon2,
output versa_xmp_1_xoa_pma1_dcmon1,
output versa_xmp_1_xoa_pma1_dcmon2,
output versa_xmp_1_xoa_pma2_dcmon1,
output versa_xmp_1_xoa_pma2_dcmon2,
output versa_xmp_1_xoa_pma3_dcmon1,
output versa_xmp_1_xoa_pma3_dcmon2,
output fatal_int_0_o,
output imc_int_0_o,
output quad_interrupts_0_mac800_int,
output versa_xmp_0_o_ucss_irq_cpi_0_a,
output versa_xmp_1_o_ucss_irq_cpi_0_a,
output versa_xmp_0_o_ucss_irq_cpi_1_a,
output versa_xmp_1_o_ucss_irq_cpi_1_a,
output versa_xmp_0_o_ucss_irq_cpi_2_a,
output versa_xmp_1_o_ucss_irq_cpi_2_a,
output versa_xmp_0_o_ucss_irq_cpi_3_a,
output versa_xmp_1_o_ucss_irq_cpi_3_a,
output versa_xmp_0_o_ucss_irq_cpi_4_a,
output versa_xmp_1_o_ucss_irq_cpi_4_a,
output versa_xmp_0_o_ucss_irq_to_soc_l0_a,
output versa_xmp_0_o_ucss_irq_to_soc_l1_a,
output versa_xmp_0_o_ucss_irq_to_soc_l2_a,
output versa_xmp_0_o_ucss_irq_to_soc_l3_a,
output versa_xmp_1_o_ucss_irq_to_soc_l0_a,
output versa_xmp_1_o_ucss_irq_to_soc_l1_a,
output versa_xmp_1_o_ucss_irq_to_soc_l2_a,
output versa_xmp_1_o_ucss_irq_to_soc_l3_a,
output wire pcs_mac_pipeline_top_wrap_mquad0_mac0_xlgmii_tx_clkena,
output wire pcs_mac_pipeline_top_wrap_mquad0_mac0_xlgmii_rx_clkena,
output wire [7:0] pcs_mac_pipeline_top_wrap_mquad0_mac0_xlgmii_rx_rxc,
output wire [63:0] pcs_mac_pipeline_top_wrap_mquad0_mac0_xlgmii_rx_rxd,
output wire pcs_mac_pipeline_top_wrap_mquad0_mac0_xlgmii_rxt0_next,
input wire [7:0] hlp_xlgmii0_txc_0,
input wire [63:0] hlp_xlgmii0_txd_0,
output wire [1:0] pcs_mac_pipeline_top_wrap_mquad0_tsu0_xlgmii_rx_sd,
output wire [1:0] pcs_mac_pipeline_top_wrap_mquad0_tsu0_xlgmii_rx_tsu,
output wire [1:0] pcs_mac_pipeline_top_wrap_mquad0_tsu0_xlgmii_tx_tsu,
output wire pcs_mac_pipeline_top_wrap_mquad0_mac1_xlgmii_tx_clkena,
output wire pcs_mac_pipeline_top_wrap_mquad0_mac1_xlgmii_rx_clkena,
output wire [7:0] pcs_mac_pipeline_top_wrap_mquad0_mac1_xlgmii_rx_rxc,
output wire [63:0] pcs_mac_pipeline_top_wrap_mquad0_mac1_xlgmii_rx_rxd,
output wire pcs_mac_pipeline_top_wrap_mquad0_mac1_xlgmii_rxt0_next,
input wire [7:0] hlp_xlgmii1_txc_0,
input wire [63:0] hlp_xlgmii1_txd_0,
output wire [1:0] pcs_mac_pipeline_top_wrap_mquad0_tsu1_xlgmii_rx_sd,
output wire [1:0] pcs_mac_pipeline_top_wrap_mquad0_tsu1_xlgmii_rx_tsu,
output wire [1:0] pcs_mac_pipeline_top_wrap_mquad0_tsu1_xlgmii_tx_tsu,
output wire pcs_mac_pipeline_top_wrap_mquad0_mac2_xlgmii_tx_clkena,
output wire pcs_mac_pipeline_top_wrap_mquad0_mac2_xlgmii_rx_clkena,
output wire [7:0] pcs_mac_pipeline_top_wrap_mquad0_mac2_xlgmii_rx_rxc,
output wire [63:0] pcs_mac_pipeline_top_wrap_mquad0_mac2_xlgmii_rx_rxd,
output wire pcs_mac_pipeline_top_wrap_mquad0_mac2_xlgmii_rxt0_next,
input wire [7:0] hlp_xlgmii2_txc_0,
input wire [63:0] hlp_xlgmii2_txd_0,
output wire [1:0] pcs_mac_pipeline_top_wrap_mquad0_tsu2_xlgmii_rx_sd,
output wire [1:0] pcs_mac_pipeline_top_wrap_mquad0_tsu2_xlgmii_rx_tsu,
output wire [1:0] pcs_mac_pipeline_top_wrap_mquad0_tsu2_xlgmii_tx_tsu,
output wire pcs_mac_pipeline_top_wrap_mquad0_mac3_xlgmii_tx_clkena,
output wire pcs_mac_pipeline_top_wrap_mquad0_mac3_xlgmii_rx_clkena,
output wire [7:0] pcs_mac_pipeline_top_wrap_mquad0_mac3_xlgmii_rx_rxc,
output wire [63:0] pcs_mac_pipeline_top_wrap_mquad0_mac3_xlgmii_rx_rxd,
output wire pcs_mac_pipeline_top_wrap_mquad0_mac3_xlgmii_rxt0_next,
input wire [7:0] hlp_xlgmii3_txc_0,
input wire [63:0] hlp_xlgmii3_txd_0,
output wire [1:0] pcs_mac_pipeline_top_wrap_mquad0_tsu3_xlgmii_rx_sd,
output wire [1:0] pcs_mac_pipeline_top_wrap_mquad0_tsu3_xlgmii_rx_tsu,
output wire [1:0] pcs_mac_pipeline_top_wrap_mquad0_tsu3_xlgmii_tx_tsu,
output wire pcs_mac_pipeline_top_wrap_mquad0_mac0_cgmii_tx_clkena,
output wire pcs_mac_pipeline_top_wrap_mquad0_mac0_cgmii_rx_clkena,
output wire [15:0] pcs_mac_pipeline_top_wrap_mquad0_mac0_cgmii_rx_rxc,
output wire [127:0] pcs_mac_pipeline_top_wrap_mquad0_mac0_cgmii_rx_rxd,
input wire [15:0] hlp_cgmii0_txc_0,
input wire [127:0] hlp_cgmii0_txd_0,
output wire pcs_mac_pipeline_top_wrap_mquad0_mac1_cgmii_tx_clkena,
output wire pcs_mac_pipeline_top_wrap_mquad0_mac1_cgmii_rx_clkena,
output wire [15:0] pcs_mac_pipeline_top_wrap_mquad0_mac1_cgmii_rx_rxc,
output wire [127:0] pcs_mac_pipeline_top_wrap_mquad0_mac1_cgmii_rx_rxd,
input wire [15:0] hlp_cgmii1_txc_0,
input wire [127:0] hlp_cgmii1_txd_0,
output wire pcs_mac_pipeline_top_wrap_mquad0_mac2_cgmii_tx_clkena,
output wire pcs_mac_pipeline_top_wrap_mquad0_mac2_cgmii_rx_clkena,
output wire [15:0] pcs_mac_pipeline_top_wrap_mquad0_mac2_cgmii_rx_rxc,
output wire [127:0] pcs_mac_pipeline_top_wrap_mquad0_mac2_cgmii_rx_rxd,
input wire [15:0] hlp_cgmii2_txc_0,
input wire [127:0] hlp_cgmii2_txd_0,
output wire pcs_mac_pipeline_top_wrap_mquad0_mac3_cgmii_tx_clkena,
output wire pcs_mac_pipeline_top_wrap_mquad0_mac3_cgmii_rx_clkena,
output wire [15:0] pcs_mac_pipeline_top_wrap_mquad0_mac3_cgmii_rx_rxc,
output wire [127:0] pcs_mac_pipeline_top_wrap_mquad0_mac3_cgmii_rx_rxd,
input wire [15:0] hlp_cgmii3_txc_0,
input wire [127:0] hlp_cgmii3_txd_0,
input wire [7:0] hlp_xlgmii0_rxc_nss_0,
input wire [63:0] hlp_xlgmii0_rxd_nss_0,
output wire [7:0] pcs_mac_pipeline_top_wrap_nss_pcs0_xlgmii_tx_txc,
output wire [63:0] pcs_mac_pipeline_top_wrap_nss_pcs0_xlgmii_tx_txd,
input wire [7:0] hlp_xlgmii1_rxc_nss_0,
input wire [63:0] hlp_xlgmii1_rxd_nss_0,
output wire [7:0] pcs_mac_pipeline_top_wrap_nss_pcs1_xlgmii_tx_txc,
output wire [63:0] pcs_mac_pipeline_top_wrap_nss_pcs1_xlgmii_tx_txd,
input wire [7:0] hlp_xlgmii2_rxc_nss_0,
input wire [63:0] hlp_xlgmii2_rxd_nss_0,
output wire [7:0] pcs_mac_pipeline_top_wrap_nss_pcs2_xlgmii_tx_txc,
output wire [63:0] pcs_mac_pipeline_top_wrap_nss_pcs2_xlgmii_tx_txd,
input wire [7:0] hlp_xlgmii3_rxc_nss_0,
input wire [63:0] hlp_xlgmii3_rxd_nss_0,
output wire [7:0] pcs_mac_pipeline_top_wrap_nss_pcs3_xlgmii_tx_txc,
output wire [63:0] pcs_mac_pipeline_top_wrap_nss_pcs3_xlgmii_tx_txd,
input wire [15:0] hlp_cgmii0_rxc_nss_0,
input wire [127:0] hlp_cgmii0_rxd_nss_0,
output wire [15:0] pcs_mac_pipeline_top_wrap_nss_pcs0_cgmii_tx_txc,
output wire [127:0] pcs_mac_pipeline_top_wrap_nss_pcs0_cgmii_tx_txd,
input wire [15:0] hlp_cgmii1_rxc_nss_0,
input wire [127:0] hlp_cgmii1_rxd_nss_0,
output wire [15:0] pcs_mac_pipeline_top_wrap_nss_pcs1_cgmii_tx_txc,
output wire [127:0] pcs_mac_pipeline_top_wrap_nss_pcs1_cgmii_tx_txd,
input wire [15:0] hlp_cgmii2_rxc_nss_0,
input wire [127:0] hlp_cgmii2_rxd_nss_0,
output wire [15:0] pcs_mac_pipeline_top_wrap_nss_pcs2_cgmii_tx_txc,
output wire [127:0] pcs_mac_pipeline_top_wrap_nss_pcs2_cgmii_tx_txd,
input wire [15:0] hlp_cgmii3_rxc_nss_0,
input wire [127:0] hlp_cgmii3_rxd_nss_0,
output wire [15:0] pcs_mac_pipeline_top_wrap_nss_pcs3_cgmii_tx_txc,
output wire [127:0] pcs_mac_pipeline_top_wrap_nss_pcs3_cgmii_tx_txd,
output wire pcs_mac_pipeline_top_wrap_mquad1_mac0_xlgmii_tx_clkena,
output wire pcs_mac_pipeline_top_wrap_mquad1_mac0_xlgmii_rx_clkena,
output wire [7:0] pcs_mac_pipeline_top_wrap_mquad1_mac0_xlgmii_rx_rxc,
output wire [63:0] pcs_mac_pipeline_top_wrap_mquad1_mac0_xlgmii_rx_rxd,
output wire pcs_mac_pipeline_top_wrap_mquad1_mac0_xlgmii_rxt0_next,
input wire [7:0] hlp_xlgmii0_txc_1,
input wire [63:0] hlp_xlgmii0_txd_1,
output wire [1:0] pcs_mac_pipeline_top_wrap_mquad1_tsu0_xlgmii_rx_sd,
output wire [1:0] pcs_mac_pipeline_top_wrap_mquad1_tsu0_xlgmii_rx_tsu,
output wire [1:0] pcs_mac_pipeline_top_wrap_mquad1_tsu0_xlgmii_tx_tsu,
output wire pcs_mac_pipeline_top_wrap_mquad1_mac1_xlgmii_tx_clkena,
output wire pcs_mac_pipeline_top_wrap_mquad1_mac1_xlgmii_rx_clkena,
output wire [7:0] pcs_mac_pipeline_top_wrap_mquad1_mac1_xlgmii_rx_rxc,
output wire [63:0] pcs_mac_pipeline_top_wrap_mquad1_mac1_xlgmii_rx_rxd,
output wire pcs_mac_pipeline_top_wrap_mquad1_mac1_xlgmii_rxt0_next,
input wire [7:0] hlp_xlgmii1_txc_1,
input wire [63:0] hlp_xlgmii1_txd_1,
output wire [1:0] pcs_mac_pipeline_top_wrap_mquad1_tsu1_xlgmii_rx_sd,
output wire [1:0] pcs_mac_pipeline_top_wrap_mquad1_tsu1_xlgmii_rx_tsu,
output wire [1:0] pcs_mac_pipeline_top_wrap_mquad1_tsu1_xlgmii_tx_tsu,
output wire pcs_mac_pipeline_top_wrap_mquad1_mac2_xlgmii_tx_clkena,
output wire pcs_mac_pipeline_top_wrap_mquad1_mac2_xlgmii_rx_clkena,
output wire [7:0] pcs_mac_pipeline_top_wrap_mquad1_mac2_xlgmii_rx_rxc,
output wire [63:0] pcs_mac_pipeline_top_wrap_mquad1_mac2_xlgmii_rx_rxd,
output wire pcs_mac_pipeline_top_wrap_mquad1_mac2_xlgmii_rxt0_next,
input wire [7:0] hlp_xlgmii2_txc_1,
input wire [63:0] hlp_xlgmii2_txd_1,
output wire [1:0] pcs_mac_pipeline_top_wrap_mquad1_tsu2_xlgmii_rx_sd,
output wire [1:0] pcs_mac_pipeline_top_wrap_mquad1_tsu2_xlgmii_rx_tsu,
output wire [1:0] pcs_mac_pipeline_top_wrap_mquad1_tsu2_xlgmii_tx_tsu,
output wire pcs_mac_pipeline_top_wrap_mquad1_mac3_xlgmii_tx_clkena,
output wire pcs_mac_pipeline_top_wrap_mquad1_mac3_xlgmii_rx_clkena,
output wire [7:0] pcs_mac_pipeline_top_wrap_mquad1_mac3_xlgmii_rx_rxc,
output wire [63:0] pcs_mac_pipeline_top_wrap_mquad1_mac3_xlgmii_rx_rxd,
output wire pcs_mac_pipeline_top_wrap_mquad1_mac3_xlgmii_rxt0_next,
input wire [7:0] hlp_xlgmii3_txc_1,
input wire [63:0] hlp_xlgmii3_txd_1,
output wire [1:0] pcs_mac_pipeline_top_wrap_mquad1_tsu3_xlgmii_rx_sd,
output wire [1:0] pcs_mac_pipeline_top_wrap_mquad1_tsu3_xlgmii_rx_tsu,
output wire [1:0] pcs_mac_pipeline_top_wrap_mquad1_tsu3_xlgmii_tx_tsu,
output wire pcs_mac_pipeline_top_wrap_mquad1_mac0_cgmii_tx_clkena,
output wire pcs_mac_pipeline_top_wrap_mquad1_mac0_cgmii_rx_clkena,
output wire [15:0] pcs_mac_pipeline_top_wrap_mquad1_mac0_cgmii_rx_rxc,
output wire [127:0] pcs_mac_pipeline_top_wrap_mquad1_mac0_cgmii_rx_rxd,
input wire [15:0] hlp_cgmii0_txc_1,
input wire [127:0] hlp_cgmii0_txd_1,
output wire pcs_mac_pipeline_top_wrap_mquad1_mac1_cgmii_tx_clkena,
output wire pcs_mac_pipeline_top_wrap_mquad1_mac1_cgmii_rx_clkena,
output wire [15:0] pcs_mac_pipeline_top_wrap_mquad1_mac1_cgmii_rx_rxc,
output wire [127:0] pcs_mac_pipeline_top_wrap_mquad1_mac1_cgmii_rx_rxd,
input wire [15:0] hlp_cgmii1_txc_1,
input wire [127:0] hlp_cgmii1_txd_1,
output wire pcs_mac_pipeline_top_wrap_mquad1_mac2_cgmii_tx_clkena,
output wire pcs_mac_pipeline_top_wrap_mquad1_mac2_cgmii_rx_clkena,
output wire [15:0] pcs_mac_pipeline_top_wrap_mquad1_mac2_cgmii_rx_rxc,
output wire [127:0] pcs_mac_pipeline_top_wrap_mquad1_mac2_cgmii_rx_rxd,
input wire [15:0] hlp_cgmii2_txc_1,
input wire [127:0] hlp_cgmii2_txd_1,
output wire pcs_mac_pipeline_top_wrap_mquad1_mac3_cgmii_tx_clkena,
output wire pcs_mac_pipeline_top_wrap_mquad1_mac3_cgmii_rx_clkena,
output wire [15:0] pcs_mac_pipeline_top_wrap_mquad1_mac3_cgmii_rx_rxc,
output wire [127:0] pcs_mac_pipeline_top_wrap_mquad1_mac3_cgmii_rx_rxd,
input wire [15:0] hlp_cgmii3_txc_1,
input wire [127:0] hlp_cgmii3_txd_1,
input wire pcs_mac_pipeline_top_wrap_pquad0_0_mac0_xlgmii_tx_clkena,
output wire pcs_mac_pipeline_top_wrap_pquad0_1_mac0_xlgmii_tx_clkena,
input wire pcs_mac_pipeline_top_wrap_pquad0_0_mac0_xlgmii_rx_clkena,
output wire pcs_mac_pipeline_top_wrap_pquad0_1_mac0_xlgmii_rx_clkena,
input wire [7:0] pcs_mac_pipeline_top_wrap_pquad0_0_mac0_xlgmii_rx_rxc,
output wire [7:0] pcs_mac_pipeline_top_wrap_pquad0_1_mac0_xlgmii_rx_rxc,
input wire [63:0] pcs_mac_pipeline_top_wrap_pquad0_0_mac0_xlgmii_rx_rxd,
output wire [63:0] pcs_mac_pipeline_top_wrap_pquad0_1_mac0_xlgmii_rx_rxd,
input wire pcs_mac_pipeline_top_wrap_pquad0_0_mac0_xlgmii_rxt0_next,
output wire pcs_mac_pipeline_top_wrap_pquad0_1_mac0_xlgmii_rxt0_next,
input wire [7:0] hlp_xlgmii0_txc_2,
output wire [7:0] pcs_mac_pipeline_top_wrap_pquad0_1_pcs0_xlgmii_tx_txc,
input wire [63:0] hlp_xlgmii0_txd_2,
output wire [63:0] pcs_mac_pipeline_top_wrap_pquad0_1_pcs0_xlgmii_tx_txd,
input wire [1:0] pcs_mac_pipeline_top_wrap_pquad0_0_tsu0_xlgmii_rx_sd,
output wire [1:0] pcs_mac_pipeline_top_wrap_pquad0_1_tsu0_xlgmii_rx_sd,
input wire [1:0] pcs_mac_pipeline_top_wrap_pquad0_0_tsu0_xlgmii_rx_tsu,
output wire [1:0] pcs_mac_pipeline_top_wrap_pquad0_1_tsu0_xlgmii_rx_tsu,
input wire [1:0] pcs_mac_pipeline_top_wrap_pquad0_0_tsu0_xlgmii_tx_tsu,
output wire [1:0] pcs_mac_pipeline_top_wrap_pquad0_1_tsu0_xlgmii_tx_tsu,
input wire pcs_mac_pipeline_top_wrap_pquad0_0_mac1_xlgmii_tx_clkena,
output wire pcs_mac_pipeline_top_wrap_pquad0_1_mac1_xlgmii_tx_clkena,
input wire pcs_mac_pipeline_top_wrap_pquad0_0_mac1_xlgmii_rx_clkena,
output wire pcs_mac_pipeline_top_wrap_pquad0_1_mac1_xlgmii_rx_clkena,
input wire [7:0] pcs_mac_pipeline_top_wrap_pquad0_0_mac1_xlgmii_rx_rxc,
output wire [7:0] pcs_mac_pipeline_top_wrap_pquad0_1_mac1_xlgmii_rx_rxc,
input wire [63:0] pcs_mac_pipeline_top_wrap_pquad0_0_mac1_xlgmii_rx_rxd,
output wire [63:0] pcs_mac_pipeline_top_wrap_pquad0_1_mac1_xlgmii_rx_rxd,
input wire pcs_mac_pipeline_top_wrap_pquad0_0_mac1_xlgmii_rxt0_next,
output wire pcs_mac_pipeline_top_wrap_pquad0_1_mac1_xlgmii_rxt0_next,
input wire [7:0] hlp_xlgmii1_txc_2,
output wire [7:0] pcs_mac_pipeline_top_wrap_pquad0_1_pcs1_xlgmii_tx_txc,
input wire [63:0] hlp_xlgmii1_txd_2,
output wire [63:0] pcs_mac_pipeline_top_wrap_pquad0_1_pcs1_xlgmii_tx_txd,
input wire [1:0] pcs_mac_pipeline_top_wrap_pquad0_0_tsu1_xlgmii_rx_sd,
output wire [1:0] pcs_mac_pipeline_top_wrap_pquad0_1_tsu1_xlgmii_rx_sd,
input wire [1:0] pcs_mac_pipeline_top_wrap_pquad0_0_tsu1_xlgmii_rx_tsu,
output wire [1:0] pcs_mac_pipeline_top_wrap_pquad0_1_tsu1_xlgmii_rx_tsu,
input wire [1:0] pcs_mac_pipeline_top_wrap_pquad0_0_tsu1_xlgmii_tx_tsu,
output wire [1:0] pcs_mac_pipeline_top_wrap_pquad0_1_tsu1_xlgmii_tx_tsu,
input wire pcs_mac_pipeline_top_wrap_pquad0_0_mac2_xlgmii_tx_clkena,
output wire pcs_mac_pipeline_top_wrap_pquad0_1_mac2_xlgmii_tx_clkena,
input wire pcs_mac_pipeline_top_wrap_pquad0_0_mac2_xlgmii_rx_clkena,
output wire pcs_mac_pipeline_top_wrap_pquad0_1_mac2_xlgmii_rx_clkena,
input wire [7:0] pcs_mac_pipeline_top_wrap_pquad0_0_mac2_xlgmii_rx_rxc,
output wire [7:0] pcs_mac_pipeline_top_wrap_pquad0_1_mac2_xlgmii_rx_rxc,
input wire [63:0] pcs_mac_pipeline_top_wrap_pquad0_0_mac2_xlgmii_rx_rxd,
output wire [63:0] pcs_mac_pipeline_top_wrap_pquad0_1_mac2_xlgmii_rx_rxd,
input wire pcs_mac_pipeline_top_wrap_pquad0_0_mac2_xlgmii_rxt0_next,
output wire pcs_mac_pipeline_top_wrap_pquad0_1_mac2_xlgmii_rxt0_next,
input wire [7:0] hlp_xlgmii2_txc_2,
output wire [7:0] pcs_mac_pipeline_top_wrap_pquad0_1_pcs2_xlgmii_tx_txc,
input wire [63:0] hlp_xlgmii2_txd_2,
output wire [63:0] pcs_mac_pipeline_top_wrap_pquad0_1_pcs2_xlgmii_tx_txd,
input wire [1:0] pcs_mac_pipeline_top_wrap_pquad0_0_tsu2_xlgmii_rx_sd,
output wire [1:0] pcs_mac_pipeline_top_wrap_pquad0_1_tsu2_xlgmii_rx_sd,
input wire [1:0] pcs_mac_pipeline_top_wrap_pquad0_0_tsu2_xlgmii_rx_tsu,
output wire [1:0] pcs_mac_pipeline_top_wrap_pquad0_1_tsu2_xlgmii_rx_tsu,
input wire [1:0] pcs_mac_pipeline_top_wrap_pquad0_0_tsu2_xlgmii_tx_tsu,
output wire [1:0] pcs_mac_pipeline_top_wrap_pquad0_1_tsu2_xlgmii_tx_tsu,
input wire pcs_mac_pipeline_top_wrap_pquad0_0_mac3_xlgmii_tx_clkena,
output wire pcs_mac_pipeline_top_wrap_pquad0_1_mac3_xlgmii_tx_clkena,
input wire pcs_mac_pipeline_top_wrap_pquad0_0_mac3_xlgmii_rx_clkena,
output wire pcs_mac_pipeline_top_wrap_pquad0_1_mac3_xlgmii_rx_clkena,
input wire [7:0] pcs_mac_pipeline_top_wrap_pquad0_0_mac3_xlgmii_rx_rxc,
output wire [7:0] pcs_mac_pipeline_top_wrap_pquad0_1_mac3_xlgmii_rx_rxc,
input wire [63:0] pcs_mac_pipeline_top_wrap_pquad0_0_mac3_xlgmii_rx_rxd,
output wire [63:0] pcs_mac_pipeline_top_wrap_pquad0_1_mac3_xlgmii_rx_rxd,
input wire pcs_mac_pipeline_top_wrap_pquad0_0_mac3_xlgmii_rxt0_next,
output wire pcs_mac_pipeline_top_wrap_pquad0_1_mac3_xlgmii_rxt0_next,
input wire [7:0] hlp_xlgmii3_txc_2,
output wire [7:0] pcs_mac_pipeline_top_wrap_pquad0_1_pcs3_xlgmii_tx_txc,
input wire [63:0] hlp_xlgmii3_txd_2,
output wire [63:0] pcs_mac_pipeline_top_wrap_pquad0_1_pcs3_xlgmii_tx_txd,
input wire [1:0] pcs_mac_pipeline_top_wrap_pquad0_0_tsu3_xlgmii_rx_sd,
output wire [1:0] pcs_mac_pipeline_top_wrap_pquad0_1_tsu3_xlgmii_rx_sd,
input wire [1:0] pcs_mac_pipeline_top_wrap_pquad0_0_tsu3_xlgmii_rx_tsu,
output wire [1:0] pcs_mac_pipeline_top_wrap_pquad0_1_tsu3_xlgmii_rx_tsu,
input wire [1:0] pcs_mac_pipeline_top_wrap_pquad0_0_tsu3_xlgmii_tx_tsu,
output wire [1:0] pcs_mac_pipeline_top_wrap_pquad0_1_tsu3_xlgmii_tx_tsu,
input wire pcs_mac_pipeline_top_wrap_pquad0_0_mac0_cgmii_tx_clkena,
output wire pcs_mac_pipeline_top_wrap_pquad0_1_mac0_cgmii_tx_clkena,
input wire pcs_mac_pipeline_top_wrap_pquad0_0_mac0_cgmii_rx_clkena,
output wire pcs_mac_pipeline_top_wrap_pquad0_1_mac0_cgmii_rx_clkena,
input wire [15:0] pcs_mac_pipeline_top_wrap_pquad0_0_mac0_cgmii_rx_rxc,
output wire [15:0] pcs_mac_pipeline_top_wrap_pquad0_1_mac0_cgmii_rx_rxc,
input wire [127:0] pcs_mac_pipeline_top_wrap_pquad0_0_mac0_cgmii_rx_rxd,
output wire [127:0] pcs_mac_pipeline_top_wrap_pquad0_1_mac0_cgmii_rx_rxd,
input wire [15:0] hlp_cgmii0_txc_2,
output wire [15:0] pcs_mac_pipeline_top_wrap_pquad0_1_pcs0_cgmii_tx_txc,
input wire [127:0] hlp_cgmii0_txd_2,
output wire [127:0] pcs_mac_pipeline_top_wrap_pquad0_1_pcs0_cgmii_tx_txd,
input wire pcs_mac_pipeline_top_wrap_pquad0_0_mac1_cgmii_tx_clkena,
output wire pcs_mac_pipeline_top_wrap_pquad0_1_mac1_cgmii_tx_clkena,
input wire pcs_mac_pipeline_top_wrap_pquad0_0_mac1_cgmii_rx_clkena,
output wire pcs_mac_pipeline_top_wrap_pquad0_1_mac1_cgmii_rx_clkena,
input wire [15:0] pcs_mac_pipeline_top_wrap_pquad0_0_mac1_cgmii_rx_rxc,
output wire [15:0] pcs_mac_pipeline_top_wrap_pquad0_1_mac1_cgmii_rx_rxc,
input wire [127:0] pcs_mac_pipeline_top_wrap_pquad0_0_mac1_cgmii_rx_rxd,
output wire [127:0] pcs_mac_pipeline_top_wrap_pquad0_1_mac1_cgmii_rx_rxd,
input wire [15:0] hlp_cgmii1_txc_2,
output wire [15:0] pcs_mac_pipeline_top_wrap_pquad0_1_pcs1_cgmii_tx_txc,
input wire [127:0] hlp_cgmii1_txd_2,
output wire [127:0] pcs_mac_pipeline_top_wrap_pquad0_1_pcs1_cgmii_tx_txd,
input wire pcs_mac_pipeline_top_wrap_pquad0_0_mac2_cgmii_tx_clkena,
output wire pcs_mac_pipeline_top_wrap_pquad0_1_mac2_cgmii_tx_clkena,
input wire pcs_mac_pipeline_top_wrap_pquad0_0_mac2_cgmii_rx_clkena,
output wire pcs_mac_pipeline_top_wrap_pquad0_1_mac2_cgmii_rx_clkena,
input wire [15:0] pcs_mac_pipeline_top_wrap_pquad0_0_mac2_cgmii_rx_rxc,
output wire [15:0] pcs_mac_pipeline_top_wrap_pquad0_1_mac2_cgmii_rx_rxc,
input wire [127:0] pcs_mac_pipeline_top_wrap_pquad0_0_mac2_cgmii_rx_rxd,
output wire [127:0] pcs_mac_pipeline_top_wrap_pquad0_1_mac2_cgmii_rx_rxd,
input wire [15:0] hlp_cgmii2_txc_2,
output wire [15:0] pcs_mac_pipeline_top_wrap_pquad0_1_pcs2_cgmii_tx_txc,
input wire [127:0] hlp_cgmii2_txd_2,
output wire [127:0] pcs_mac_pipeline_top_wrap_pquad0_1_pcs2_cgmii_tx_txd,
input wire pcs_mac_pipeline_top_wrap_pquad0_0_mac3_cgmii_tx_clkena,
output wire pcs_mac_pipeline_top_wrap_pquad0_1_mac3_cgmii_tx_clkena,
input wire pcs_mac_pipeline_top_wrap_pquad0_0_mac3_cgmii_rx_clkena,
output wire pcs_mac_pipeline_top_wrap_pquad0_1_mac3_cgmii_rx_clkena,
input wire [15:0] pcs_mac_pipeline_top_wrap_pquad0_0_mac3_cgmii_rx_rxc,
output wire [15:0] pcs_mac_pipeline_top_wrap_pquad0_1_mac3_cgmii_rx_rxc,
input wire [127:0] pcs_mac_pipeline_top_wrap_pquad0_0_mac3_cgmii_rx_rxd,
output wire [127:0] pcs_mac_pipeline_top_wrap_pquad0_1_mac3_cgmii_rx_rxd,
input wire [15:0] hlp_cgmii3_txc_2,
output wire [15:0] pcs_mac_pipeline_top_wrap_pquad0_1_pcs3_cgmii_tx_txc,
input wire [127:0] hlp_cgmii3_txd_2,
output wire [127:0] pcs_mac_pipeline_top_wrap_pquad0_1_pcs3_cgmii_tx_txd,
input wire pcs_mac_pipeline_top_wrap_pquad1_0_mac0_xlgmii_tx_clkena,
output wire pcs_mac_pipeline_top_wrap_pquad1_1_mac0_xlgmii_tx_clkena,
input wire pcs_mac_pipeline_top_wrap_pquad1_0_mac0_xlgmii_rx_clkena,
output wire pcs_mac_pipeline_top_wrap_pquad1_1_mac0_xlgmii_rx_clkena,
input wire [7:0] pcs_mac_pipeline_top_wrap_pquad1_0_mac0_xlgmii_rx_rxc,
output wire [7:0] pcs_mac_pipeline_top_wrap_pquad1_1_mac0_xlgmii_rx_rxc,
input wire [63:0] pcs_mac_pipeline_top_wrap_pquad1_0_mac0_xlgmii_rx_rxd,
output wire [63:0] pcs_mac_pipeline_top_wrap_pquad1_1_mac0_xlgmii_rx_rxd,
input wire pcs_mac_pipeline_top_wrap_pquad1_0_mac0_xlgmii_rxt0_next,
output wire pcs_mac_pipeline_top_wrap_pquad1_1_mac0_xlgmii_rxt0_next,
input wire [7:0] hlp_xlgmii0_txc_3,
output wire [7:0] pcs_mac_pipeline_top_wrap_pquad1_1_pcs0_xlgmii_tx_txc,
input wire [63:0] hlp_xlgmii0_txd_3,
output wire [63:0] pcs_mac_pipeline_top_wrap_pquad1_1_pcs0_xlgmii_tx_txd,
input wire [1:0] pcs_mac_pipeline_top_wrap_pquad1_0_tsu0_xlgmii_rx_sd,
output wire [1:0] pcs_mac_pipeline_top_wrap_pquad1_1_tsu0_xlgmii_rx_sd,
input wire [1:0] pcs_mac_pipeline_top_wrap_pquad1_0_tsu0_xlgmii_rx_tsu,
output wire [1:0] pcs_mac_pipeline_top_wrap_pquad1_1_tsu0_xlgmii_rx_tsu,
input wire [1:0] pcs_mac_pipeline_top_wrap_pquad1_0_tsu0_xlgmii_tx_tsu,
output wire [1:0] pcs_mac_pipeline_top_wrap_pquad1_1_tsu0_xlgmii_tx_tsu,
input wire pcs_mac_pipeline_top_wrap_pquad1_0_mac1_xlgmii_tx_clkena,
output wire pcs_mac_pipeline_top_wrap_pquad1_1_mac1_xlgmii_tx_clkena,
input wire pcs_mac_pipeline_top_wrap_pquad1_0_mac1_xlgmii_rx_clkena,
output wire pcs_mac_pipeline_top_wrap_pquad1_1_mac1_xlgmii_rx_clkena,
input wire [7:0] pcs_mac_pipeline_top_wrap_pquad1_0_mac1_xlgmii_rx_rxc,
output wire [7:0] pcs_mac_pipeline_top_wrap_pquad1_1_mac1_xlgmii_rx_rxc,
input wire [63:0] pcs_mac_pipeline_top_wrap_pquad1_0_mac1_xlgmii_rx_rxd,
output wire [63:0] pcs_mac_pipeline_top_wrap_pquad1_1_mac1_xlgmii_rx_rxd,
input wire pcs_mac_pipeline_top_wrap_pquad1_0_mac1_xlgmii_rxt0_next,
output wire pcs_mac_pipeline_top_wrap_pquad1_1_mac1_xlgmii_rxt0_next,
input wire [7:0] hlp_xlgmii1_txc_3,
output wire [7:0] pcs_mac_pipeline_top_wrap_pquad1_1_pcs1_xlgmii_tx_txc,
input wire [63:0] hlp_xlgmii1_txd_3,
output wire [63:0] pcs_mac_pipeline_top_wrap_pquad1_1_pcs1_xlgmii_tx_txd,
input wire [1:0] pcs_mac_pipeline_top_wrap_pquad1_0_tsu1_xlgmii_rx_sd,
output wire [1:0] pcs_mac_pipeline_top_wrap_pquad1_1_tsu1_xlgmii_rx_sd,
input wire [1:0] pcs_mac_pipeline_top_wrap_pquad1_0_tsu1_xlgmii_rx_tsu,
output wire [1:0] pcs_mac_pipeline_top_wrap_pquad1_1_tsu1_xlgmii_rx_tsu,
input wire [1:0] pcs_mac_pipeline_top_wrap_pquad1_0_tsu1_xlgmii_tx_tsu,
output wire [1:0] pcs_mac_pipeline_top_wrap_pquad1_1_tsu1_xlgmii_tx_tsu,
input wire pcs_mac_pipeline_top_wrap_pquad1_0_mac2_xlgmii_tx_clkena,
output wire pcs_mac_pipeline_top_wrap_pquad1_1_mac2_xlgmii_tx_clkena,
input wire pcs_mac_pipeline_top_wrap_pquad1_0_mac2_xlgmii_rx_clkena,
output wire pcs_mac_pipeline_top_wrap_pquad1_1_mac2_xlgmii_rx_clkena,
input wire [7:0] pcs_mac_pipeline_top_wrap_pquad1_0_mac2_xlgmii_rx_rxc,
output wire [7:0] pcs_mac_pipeline_top_wrap_pquad1_1_mac2_xlgmii_rx_rxc,
input wire [63:0] pcs_mac_pipeline_top_wrap_pquad1_0_mac2_xlgmii_rx_rxd,
output wire [63:0] pcs_mac_pipeline_top_wrap_pquad1_1_mac2_xlgmii_rx_rxd,
input wire pcs_mac_pipeline_top_wrap_pquad1_0_mac2_xlgmii_rxt0_next,
output wire pcs_mac_pipeline_top_wrap_pquad1_1_mac2_xlgmii_rxt0_next,
input wire [7:0] hlp_xlgmii2_txc_3,
output wire [7:0] pcs_mac_pipeline_top_wrap_pquad1_1_pcs2_xlgmii_tx_txc,
input wire [63:0] hlp_xlgmii2_txd_3,
output wire [63:0] pcs_mac_pipeline_top_wrap_pquad1_1_pcs2_xlgmii_tx_txd,
input wire [1:0] pcs_mac_pipeline_top_wrap_pquad1_0_tsu2_xlgmii_rx_sd,
output wire [1:0] pcs_mac_pipeline_top_wrap_pquad1_1_tsu2_xlgmii_rx_sd,
input wire [1:0] pcs_mac_pipeline_top_wrap_pquad1_0_tsu2_xlgmii_rx_tsu,
output wire [1:0] pcs_mac_pipeline_top_wrap_pquad1_1_tsu2_xlgmii_rx_tsu,
input wire [1:0] pcs_mac_pipeline_top_wrap_pquad1_0_tsu2_xlgmii_tx_tsu,
output wire [1:0] pcs_mac_pipeline_top_wrap_pquad1_1_tsu2_xlgmii_tx_tsu,
input wire pcs_mac_pipeline_top_wrap_pquad1_0_mac3_xlgmii_tx_clkena,
output wire pcs_mac_pipeline_top_wrap_pquad1_1_mac3_xlgmii_tx_clkena,
input wire pcs_mac_pipeline_top_wrap_pquad1_0_mac3_xlgmii_rx_clkena,
output wire pcs_mac_pipeline_top_wrap_pquad1_1_mac3_xlgmii_rx_clkena,
input wire [7:0] pcs_mac_pipeline_top_wrap_pquad1_0_mac3_xlgmii_rx_rxc,
output wire [7:0] pcs_mac_pipeline_top_wrap_pquad1_1_mac3_xlgmii_rx_rxc,
input wire [63:0] pcs_mac_pipeline_top_wrap_pquad1_0_mac3_xlgmii_rx_rxd,
output wire [63:0] pcs_mac_pipeline_top_wrap_pquad1_1_mac3_xlgmii_rx_rxd,
input wire pcs_mac_pipeline_top_wrap_pquad1_0_mac3_xlgmii_rxt0_next,
output wire pcs_mac_pipeline_top_wrap_pquad1_1_mac3_xlgmii_rxt0_next,
input wire [7:0] hlp_xlgmii3_txc_3,
output wire [7:0] pcs_mac_pipeline_top_wrap_pquad1_1_pcs3_xlgmii_tx_txc,
input wire [63:0] hlp_xlgmii3_txd_3,
output wire [63:0] pcs_mac_pipeline_top_wrap_pquad1_1_pcs3_xlgmii_tx_txd,
input wire [1:0] pcs_mac_pipeline_top_wrap_pquad1_0_tsu3_xlgmii_rx_sd,
output wire [1:0] pcs_mac_pipeline_top_wrap_pquad1_1_tsu3_xlgmii_rx_sd,
input wire [1:0] pcs_mac_pipeline_top_wrap_pquad1_0_tsu3_xlgmii_rx_tsu,
output wire [1:0] pcs_mac_pipeline_top_wrap_pquad1_1_tsu3_xlgmii_rx_tsu,
input wire [1:0] pcs_mac_pipeline_top_wrap_pquad1_0_tsu3_xlgmii_tx_tsu,
output wire [1:0] pcs_mac_pipeline_top_wrap_pquad1_1_tsu3_xlgmii_tx_tsu,
input wire pcs_mac_pipeline_top_wrap_pquad1_0_mac0_cgmii_tx_clkena,
output wire pcs_mac_pipeline_top_wrap_pquad1_1_mac0_cgmii_tx_clkena,
input wire pcs_mac_pipeline_top_wrap_pquad1_0_mac0_cgmii_rx_clkena,
output wire pcs_mac_pipeline_top_wrap_pquad1_1_mac0_cgmii_rx_clkena,
input wire [15:0] pcs_mac_pipeline_top_wrap_pquad1_0_mac0_cgmii_rx_rxc,
output wire [15:0] pcs_mac_pipeline_top_wrap_pquad1_1_mac0_cgmii_rx_rxc,
input wire [127:0] pcs_mac_pipeline_top_wrap_pquad1_0_mac0_cgmii_rx_rxd,
output wire [127:0] pcs_mac_pipeline_top_wrap_pquad1_1_mac0_cgmii_rx_rxd,
input wire [15:0] hlp_cgmii0_txc_3,
output wire [15:0] pcs_mac_pipeline_top_wrap_pquad1_1_pcs0_cgmii_tx_txc,
input wire [127:0] hlp_cgmii0_txd_3,
output wire [127:0] pcs_mac_pipeline_top_wrap_pquad1_1_pcs0_cgmii_tx_txd,
input wire pcs_mac_pipeline_top_wrap_pquad1_0_mac1_cgmii_tx_clkena,
output wire pcs_mac_pipeline_top_wrap_pquad1_1_mac1_cgmii_tx_clkena,
input wire pcs_mac_pipeline_top_wrap_pquad1_0_mac1_cgmii_rx_clkena,
output wire pcs_mac_pipeline_top_wrap_pquad1_1_mac1_cgmii_rx_clkena,
input wire [15:0] pcs_mac_pipeline_top_wrap_pquad1_0_mac1_cgmii_rx_rxc,
output wire [15:0] pcs_mac_pipeline_top_wrap_pquad1_1_mac1_cgmii_rx_rxc,
input wire [127:0] pcs_mac_pipeline_top_wrap_pquad1_0_mac1_cgmii_rx_rxd,
output wire [127:0] pcs_mac_pipeline_top_wrap_pquad1_1_mac1_cgmii_rx_rxd,
input wire [15:0] hlp_cgmii1_txc_3,
output wire [15:0] pcs_mac_pipeline_top_wrap_pquad1_1_pcs1_cgmii_tx_txc,
input wire [127:0] hlp_cgmii1_txd_3,
output wire [127:0] pcs_mac_pipeline_top_wrap_pquad1_1_pcs1_cgmii_tx_txd,
input wire pcs_mac_pipeline_top_wrap_pquad1_0_mac2_cgmii_tx_clkena,
output wire pcs_mac_pipeline_top_wrap_pquad1_1_mac2_cgmii_tx_clkena,
input wire pcs_mac_pipeline_top_wrap_pquad1_0_mac2_cgmii_rx_clkena,
output wire pcs_mac_pipeline_top_wrap_pquad1_1_mac2_cgmii_rx_clkena,
input wire [15:0] pcs_mac_pipeline_top_wrap_pquad1_0_mac2_cgmii_rx_rxc,
output wire [15:0] pcs_mac_pipeline_top_wrap_pquad1_1_mac2_cgmii_rx_rxc,
input wire [127:0] pcs_mac_pipeline_top_wrap_pquad1_0_mac2_cgmii_rx_rxd,
output wire [127:0] pcs_mac_pipeline_top_wrap_pquad1_1_mac2_cgmii_rx_rxd,
input wire [15:0] hlp_cgmii2_txc_3,
output wire [15:0] pcs_mac_pipeline_top_wrap_pquad1_1_pcs2_cgmii_tx_txc,
input wire [127:0] hlp_cgmii2_txd_3,
output wire [127:0] pcs_mac_pipeline_top_wrap_pquad1_1_pcs2_cgmii_tx_txd,
input wire pcs_mac_pipeline_top_wrap_pquad1_0_mac3_cgmii_tx_clkena,
output wire pcs_mac_pipeline_top_wrap_pquad1_1_mac3_cgmii_tx_clkena,
input wire pcs_mac_pipeline_top_wrap_pquad1_0_mac3_cgmii_rx_clkena,
output wire pcs_mac_pipeline_top_wrap_pquad1_1_mac3_cgmii_rx_clkena,
input wire [15:0] pcs_mac_pipeline_top_wrap_pquad1_0_mac3_cgmii_rx_rxc,
output wire [15:0] pcs_mac_pipeline_top_wrap_pquad1_1_mac3_cgmii_rx_rxc,
input wire [127:0] pcs_mac_pipeline_top_wrap_pquad1_0_mac3_cgmii_rx_rxd,
output wire [127:0] pcs_mac_pipeline_top_wrap_pquad1_1_mac3_cgmii_rx_rxd,
input wire [15:0] hlp_cgmii3_txc_3,
output wire [15:0] pcs_mac_pipeline_top_wrap_pquad1_1_pcs3_cgmii_tx_txc,
input wire [127:0] hlp_cgmii3_txd_3,
output wire [127:0] pcs_mac_pipeline_top_wrap_pquad1_1_pcs3_cgmii_tx_txd,
output [1:0] quad_interrupts_0_mac400_int,
output [1:0] quad_interrupts_1_mac400_int,
input [3:0] physs_0_AWID,
input [22:0] physs_0_AWADDR,
input [7:0] physs_0_AWLEN,
input [2:0] physs_0_AWSIZE,
input [1:0] physs_0_AWBURST,
input physs_0_AWLOCK,
input [3:0] physs_0_AWCACHE,
input [2:0] physs_0_AWPROT,
input physs_0_AWVALID,
input [31:0] physs_0_WDATA,
input [3:0] physs_0_WSTRB,
input physs_0_WLAST,
input physs_0_WVALID,
input physs_0_BREADY,
input [3:0] physs_0_ARID,
input [22:0] physs_0_ARADDR,
input [7:0] physs_0_ARLEN,
input [2:0] physs_0_ARSIZE,
input [1:0] physs_0_ARBURST,
input physs_0_ARLOCK,
input [3:0] physs_0_ARCACHE,
input [2:0] physs_0_ARPROT,
input physs_0_ARVALID,
output nic400_physs_0_awready_slave_physs,
output nic400_physs_0_wready_slave_physs,
input physs_0_RREADY,
output [3:0] nic400_physs_0_bid_slave_physs,
output [1:0] nic400_physs_0_bresp_slave_physs,
output nic400_physs_0_bvalid_slave_physs,
output nic400_physs_0_arready_slave_physs,
output [3:0] nic400_physs_0_rid_slave_physs,
output [31:0] nic400_physs_0_rdata_slave_physs,
output [1:0] nic400_physs_0_rresp_slave_physs,
output nic400_physs_0_rlast_slave_physs,
output nic400_physs_0_rvalid_slave_physs,
input mdio_in,
output mac100_0_mdc,
output mac100_0_mdio_out,
output mac100_0_mdio_oen_0,
output socviewpin_4to1digimux_0_outmux,
output [3:0] quad_interrupts_0_mac100_int,
output [3:0] quad_interrupts_1_mac100_int,
input [1:0] physs_timesync_sync_val,
output parmisc_int_logic_0_o,
output [3:0] quad_interrupts_0_ts_int_o,
output [3:0] quad_interrupts_1_ts_int_o,
output [6:0] quadpcs100_0_pcs_desk_buf_rlevel,
output [6:0] quadpcs100_0_pcs_desk_buf_rlevel_1,
output [6:0] quadpcs100_0_pcs_desk_buf_rlevel_2,
output [6:0] quadpcs100_0_pcs_desk_buf_rlevel_3,
output [6:0] quadpcs100_1_pcs_desk_buf_rlevel,
output [6:0] quadpcs100_1_pcs_desk_buf_rlevel_1,
output [6:0] quadpcs100_1_pcs_desk_buf_rlevel_2,
output [6:0] quadpcs100_1_pcs_desk_buf_rlevel_3,
output parmisc_physs0_BSCAN_PIPE_OUT_TO_parmisc_physs1_scan_in,
input parmisc_physs1_BSCAN_PIPE_OUT_scan_out,
output parmisc_physs0_BSCAN_PIPE_OUT_TO_parmisc_physs1_force_disable,
output parmisc_physs0_BSCAN_PIPE_OUT_TO_parmisc_physs1_select_jtag_input,
output parmisc_physs0_BSCAN_PIPE_OUT_TO_parmisc_physs1_select_jtag_output,
output parmisc_physs0_BSCAN_PIPE_OUT_TO_parmisc_physs1_ac_init_clock0,
output parmisc_physs0_BSCAN_PIPE_OUT_TO_parmisc_physs1_ac_init_clock1,
output parmisc_physs0_BSCAN_PIPE_OUT_TO_parmisc_physs1_ac_signal,
output parmisc_physs0_BSCAN_PIPE_OUT_TO_parmisc_physs1_ac_mode_en,
output parmisc_physs0_BSCAN_PIPE_OUT_TO_parmisc_physs1_intel_update_clk,
output parmisc_physs0_BSCAN_PIPE_OUT_TO_parmisc_physs1_intel_clamp_en,
output parmisc_physs0_BSCAN_PIPE_OUT_TO_parmisc_physs1_intel_bscan_mode,
output parmisc_physs0_BSCAN_PIPE_OUT_TO_parmisc_physs1_select,
output parmisc_physs0_BSCAN_PIPE_OUT_TO_parmisc_physs1_bscan_clock,
output parmisc_physs0_BSCAN_PIPE_OUT_TO_parmisc_physs1_capture_en,
output parmisc_physs0_BSCAN_PIPE_OUT_TO_parmisc_physs1_shift_en,
output parmisc_physs0_BSCAN_PIPE_OUT_TO_parmisc_physs1_update_en,
input PHYSS_BSCAN_BYPASS,
input PHYSS_BSCAN_BYPASS_0,
input PHYSS_BSCAN_BYPASS_1,
input PHYSS_BSCAN_BYPASS_2,
input PHYSS_BSCAN_BYPASS_3,
input PHYSS_BSCAN_BYPASS_4,
input PHYSS_BSCAN_BYPASS_5,
input PHYSS_BSCAN_BYPASS_6,
input PHYSS_BSCAN_BYPASS_7,
input PHYSS_BSCAN_BYPASS_8,
input BSCAN_PIPE_IN_1_bscan_clock,
input BSCAN_PIPE_IN_1_select,
input BSCAN_PIPE_IN_1_capture_en,
input BSCAN_PIPE_IN_1_shift_en,
input BSCAN_PIPE_IN_1_update_en,
input BSCAN_PIPE_IN_1_scan_in,
input BSCAN_PIPE_IN_1_ac_signal,
input BSCAN_PIPE_IN_1_ac_init_clock0,
input BSCAN_PIPE_IN_1_ac_init_clock1,
input BSCAN_PIPE_IN_1_ac_mode_en,
input BSCAN_PIPE_IN_1_force_disable,
input BSCAN_PIPE_IN_1_select_jtag_input,
input BSCAN_PIPE_IN_1_select_jtag_output,
input BSCAN_PIPE_IN_1_intel_update_clk,
input BSCAN_PIPE_IN_1_intel_clamp_en,
input BSCAN_PIPE_IN_1_intel_bscan_mode,
output parmisc_physs0_BSCAN_PIPE_OUT_scan_out,
input BSCAN_PIPE_IN_1_intel_d6actestsig_b,
input parmisc_physs1_BSCAN_PIPE_OUT_2_bscan_to_intel_d6actestsig_b,
output parmisc_physs0_BSCAN_PIPE_OUT_2_bscan_to_intel_d6actestsig_b,
input trst_b,
input tck,
input tms,
input tdi,
output parmisc_physs0_NW_IN_tdo_en,
output parmisc_physs0_NW_IN_tdo,
input ijtag_reset_b,
input ijtag_shift,
input ijtag_capture,
input ijtag_update,
input ijtag_select,
input ijtag_si,
output parmisc_physs0_NW_IN_ijtag_so,
input shift_ir_dr,
input tms_park_value,
input nw_mode,
output parmisc_physs0_NW_IN_tap_sel_out,
input parmisc_physs1_NW_IN_tdo,
input parmisc_physs1_NW_IN_tdo_en,
output parmisc_physs0_NW_OUT_parmisc_physs1_ijtag_to_reset,
output parmisc_physs0_NW_OUT_parmisc_physs1_ijtag_to_ce,
output parmisc_physs0_NW_OUT_parmisc_physs1_ijtag_to_se,
output parmisc_physs0_NW_OUT_parmisc_physs1_ijtag_to_ue,
output parmisc_physs0_NW_OUT_parmisc_physs1_ijtag_to_sel,
output parmisc_physs0_NW_OUT_parmisc_physs1_ijtag_to_si,
input parmisc_physs1_NW_IN_ijtag_so,
input parmisc_physs1_NW_IN_tap_sel_out );
// EDIT_PORT END


// EDIT_NET BEGIN
logic mbp_repeater_odi_parmisc_physs0_3_ubp_out ; 
logic mbp_repeater_odi_par400g0_ubp_out ; 
logic mbp_repeater_odi_parmisc_physs0_6_ubp_out ; 
logic mbp_repeater_odi_par400g1_ubp_out ; 
logic dfxsecure_plugin_dpt2_parmisc_physs0_adfx_tap_grpA_enable ; 
logic dfxsecure_plugin_dpt2_parmisc_physs0_adfx_tap_grpB_enable ; 
logic dfxsecure_plugin_dpt2_parmisc_physs0_adfx_tap_grpC_enable ; 
logic dfxsecure_plugin_dpt2_parmisc_physs0_adfx_tap_grpD_enable ; 
logic dfxsecure_plugin_dpt2_parmisc_physs0_adfx_tap_grpE_enable ; 
logic dfxsecure_plugin_dpt2_parmisc_physs0_adfx_tap_grpG_enable ; 
logic dfxsecure_plugin_dpt2_parmisc_physs0_adfx_tap_grpH_enable ; 
logic dfxsecure_plugin_dpt2_parmisc_physs0_adfx_tap_grpF_enable ; 
logic dfxsecure_plugin_dpt2_parmisc_physs0_adfx_tap_grpZ_enable ; 
logic [3:0] quadpcs100_0_pcs_link_status ; 
logic [3:0] quadpcs100_1_pcs_link_status ; 
logic versa_xmp_0_o_ucss_srds_phy_ready_pma0_l0_a ; 
logic versa_xmp_0_o_ucss_srds_phy_ready_pma1_l0_a ; 
logic versa_xmp_0_o_ucss_srds_phy_ready_pma2_l0_a ; 
logic versa_xmp_0_o_ucss_srds_phy_ready_pma3_l0_a ; 
logic versa_xmp_1_o_ucss_srds_phy_ready_pma0_l0_a ; 
logic versa_xmp_1_o_ucss_srds_phy_ready_pma1_l0_a ; 
logic versa_xmp_1_o_ucss_srds_phy_ready_pma2_l0_a ; 
logic versa_xmp_1_o_ucss_srds_phy_ready_pma3_l0_a ; 
logic physs_registers_wrapper_0_hlp_link_stat_speed_0_hlp_link_stat_0 ; 
logic physs_registers_wrapper_0_hlp_link_stat_speed_1_hlp_link_stat_1 ; 
logic physs_registers_wrapper_0_hlp_link_stat_speed_2_hlp_link_stat_2 ; 
logic physs_registers_wrapper_0_hlp_link_stat_speed_3_hlp_link_stat_3 ; 
logic physs_registers_wrapper_1_hlp_link_stat_speed_0_hlp_link_stat_0 ; 
logic physs_registers_wrapper_1_hlp_link_stat_speed_1_hlp_link_stat_1 ; 
logic physs_registers_wrapper_1_hlp_link_stat_speed_2_hlp_link_stat_2 ; 
logic physs_registers_wrapper_1_hlp_link_stat_speed_3_hlp_link_stat_3 ; 
logic physs_registers_wrapper_0_link_bypass_en ; 
logic physs_registers_wrapper_1_link_bypass_en ; 
logic physs_registers_wrapper_0_link_bypass_val ; 
logic physs_registers_wrapper_1_link_bypass_val ; 
logic physs_mac_port_glue_0_during_pkt_tx_mse_0 ; 
logic physs_mac_port_glue_0_during_pkt_rx_mtip_0 ; 
logic physs_mac_port_glue_0_rx_eop_vaild_0 ; 
logic physs_mac_port_glue_0_tx_eop_vaild_0 ; 
logic physs_core_rst_fsm_0_mse_if_iso_en ; 
logic physs_core_rst_fsm_0_force_if_mse_rx_en_port_num ; 
logic physs_core_rst_fsm_0_force_if_mse_tx_en_port_num ; 
logic physs_core_rst_fsm_0_during_pkt_tx_mse_ff_clr ; 
logic physs_mac_port_glue_0_mse_ff_rx_dval ; 
logic physs_mac_port_glue_0_mtip_ff_tx_rdy ; 
logic fifo_top_mux_0_mse_physs_port_0_rx_rdy ; 
logic fifo_top_mux_0_mse_physs_port_0_tx_wren ; 
logic fifo_top_mux_0_mse_physs_port_0_tx_sop ; 
logic fifo_top_mux_0_mse_physs_port_0_tx_eop ; 
logic physs_mac_port_glue_1_mse_ff_rx_dval ; 
logic physs_mac_port_glue_1_mtip_ff_tx_rdy ; 
logic fifo_top_mux_0_mse_physs_port_1_rx_rdy ; 
logic fifo_top_mux_0_mse_physs_port_1_tx_wren ; 
logic fifo_top_mux_0_mse_physs_port_1_tx_sop ; 
logic fifo_top_mux_0_mse_physs_port_1_tx_eop ; 
logic physs_mac_port_glue_2_mse_ff_rx_dval ; 
logic physs_mac_port_glue_2_mtip_ff_tx_rdy ; 
logic fifo_top_mux_0_mse_physs_port_2_rx_rdy ; 
logic fifo_top_mux_0_mse_physs_port_2_tx_wren ; 
logic fifo_top_mux_0_mse_physs_port_2_tx_sop ; 
logic fifo_top_mux_0_mse_physs_port_2_tx_eop ; 
logic physs_mac_port_glue_3_mse_ff_rx_dval ; 
logic physs_mac_port_glue_3_mtip_ff_tx_rdy ; 
logic fifo_top_mux_0_mse_physs_port_3_rx_rdy ; 
logic fifo_top_mux_0_mse_physs_port_3_tx_wren ; 
logic fifo_top_mux_0_mse_physs_port_3_tx_sop ; 
logic fifo_top_mux_0_mse_physs_port_3_tx_eop ; 
logic physs_mac_port_glue_4_mse_ff_rx_dval ; 
logic physs_mac_port_glue_4_mtip_ff_tx_rdy ; 
logic fifo_top_mux_0_mse_physs_port_4_rx_rdy ; 
logic fifo_top_mux_0_mse_physs_port_4_tx_wren ; 
logic fifo_top_mux_0_mse_physs_port_4_tx_sop ; 
logic fifo_top_mux_0_mse_physs_port_4_tx_eop ; 
logic physs_mac_port_glue_5_mse_ff_rx_dval ; 
logic physs_mac_port_glue_5_mtip_ff_tx_rdy ; 
logic fifo_top_mux_0_mse_physs_port_5_rx_rdy ; 
logic fifo_top_mux_0_mse_physs_port_5_tx_wren ; 
logic fifo_top_mux_0_mse_physs_port_5_tx_sop ; 
logic fifo_top_mux_0_mse_physs_port_5_tx_eop ; 
logic physs_mac_port_glue_6_mse_ff_rx_dval ; 
logic physs_mac_port_glue_6_mtip_ff_tx_rdy ; 
logic fifo_top_mux_0_mse_physs_port_6_rx_rdy ; 
logic fifo_top_mux_0_mse_physs_port_6_tx_wren ; 
logic fifo_top_mux_0_mse_physs_port_6_tx_sop ; 
logic fifo_top_mux_0_mse_physs_port_6_tx_eop ; 
logic physs_mac_port_glue_7_mse_ff_rx_dval ; 
logic physs_mac_port_glue_7_mtip_ff_tx_rdy ; 
logic fifo_top_mux_0_mse_physs_port_7_rx_rdy ; 
logic fifo_top_mux_0_mse_physs_port_7_tx_wren ; 
logic fifo_top_mux_0_mse_physs_port_7_tx_sop ; 
logic fifo_top_mux_0_mse_physs_port_7_tx_eop ; 
logic physs_mac_port_glue_1_during_pkt_tx_mse_0 ; 
logic physs_mac_port_glue_1_during_pkt_rx_mtip_0 ; 
logic physs_mac_port_glue_1_rx_eop_vaild_0 ; 
logic physs_mac_port_glue_1_tx_eop_vaild_0 ; 
logic physs_core_rst_fsm_0_force_if_mse_rx_en_port_num_0 ; 
logic physs_core_rst_fsm_0_force_if_mse_tx_en_port_num_0 ; 
logic physs_mac_port_glue_2_during_pkt_tx_mse_0 ; 
logic physs_mac_port_glue_2_during_pkt_rx_mtip_0 ; 
logic physs_mac_port_glue_2_rx_eop_vaild_0 ; 
logic physs_mac_port_glue_2_tx_eop_vaild_0 ; 
logic physs_core_rst_fsm_0_force_if_mse_rx_en_port_num_1 ; 
logic physs_core_rst_fsm_0_force_if_mse_tx_en_port_num_1 ; 
logic physs_mac_port_glue_3_during_pkt_tx_mse_0 ; 
logic physs_mac_port_glue_3_during_pkt_rx_mtip_0 ; 
logic physs_mac_port_glue_3_rx_eop_vaild_0 ; 
logic physs_mac_port_glue_3_tx_eop_vaild_0 ; 
logic physs_core_rst_fsm_0_force_if_mse_rx_en_port_num_2 ; 
logic physs_core_rst_fsm_0_force_if_mse_tx_en_port_num_2 ; 
logic physs_mac_port_glue_4_during_pkt_tx_mse_0 ; 
logic physs_mac_port_glue_4_during_pkt_rx_mtip_0 ; 
logic physs_mac_port_glue_4_rx_eop_vaild_0 ; 
logic physs_mac_port_glue_4_tx_eop_vaild_0 ; 
logic physs_core_rst_fsm_1_mse_if_iso_en ; 
logic physs_core_rst_fsm_1_force_if_mse_rx_en_port_num ; 
logic physs_core_rst_fsm_1_force_if_mse_tx_en_port_num ; 
logic physs_core_rst_fsm_1_during_pkt_tx_mse_ff_clr ; 
logic physs_mac_port_glue_5_during_pkt_tx_mse_0 ; 
logic physs_mac_port_glue_5_during_pkt_rx_mtip_0 ; 
logic physs_mac_port_glue_5_rx_eop_vaild_0 ; 
logic physs_mac_port_glue_5_tx_eop_vaild_0 ; 
logic physs_core_rst_fsm_1_force_if_mse_rx_en_port_num_0 ; 
logic physs_core_rst_fsm_1_force_if_mse_tx_en_port_num_0 ; 
logic physs_mac_port_glue_6_during_pkt_tx_mse_0 ; 
logic physs_mac_port_glue_6_during_pkt_rx_mtip_0 ; 
logic physs_mac_port_glue_6_rx_eop_vaild_0 ; 
logic physs_mac_port_glue_6_tx_eop_vaild_0 ; 
logic physs_core_rst_fsm_1_force_if_mse_rx_en_port_num_1 ; 
logic physs_core_rst_fsm_1_force_if_mse_tx_en_port_num_1 ; 
logic physs_mac_port_glue_7_during_pkt_tx_mse_0 ; 
logic physs_mac_port_glue_7_during_pkt_rx_mtip_0 ; 
logic physs_mac_port_glue_7_rx_eop_vaild_0 ; 
logic physs_mac_port_glue_7_tx_eop_vaild_0 ; 
logic physs_core_rst_fsm_1_force_if_mse_rx_en_port_num_2 ; 
logic physs_core_rst_fsm_1_force_if_mse_tx_en_port_num_2 ; 
logic physs_registers_wrapper_0_syncE_main_rst ; 
logic physs_registers_wrapper_0_syncE_link_up_md ; 
logic physs_registers_wrapper_0_syncE_link_dn_md ; 
logic [7:0] physs_registers_wrapper_0_syncE_link_enable ; 
logic physs_registers_wrapper_0_syncE_refclk0_div_rst ; 
logic [2:0] physs_registers_wrapper_0_syncE_refclk0_sel ; 
logic [3:0] physs_registers_wrapper_0_syncE_refclk0_div_m1 ; 
logic physs_registers_wrapper_0_syncE_refclk0_div_load ; 
logic physs_registers_wrapper_0_syncE_refclk1_div_rst ; 
logic [2:0] physs_registers_wrapper_0_syncE_refclk1_sel ; 
logic [3:0] physs_registers_wrapper_0_syncE_refclk1_div_m1 ; 
logic physs_registers_wrapper_0_syncE_refclk1_div_load ; 
logic physs_registers_wrapper_1_syncE_main_rst ; 
logic physs_registers_wrapper_1_syncE_link_up_md ; 
logic physs_registers_wrapper_1_syncE_link_dn_md ; 
logic [7:0] physs_registers_wrapper_1_syncE_link_enable ; 
logic physs_registers_wrapper_1_syncE_refclk0_div_rst ; 
logic [2:0] physs_registers_wrapper_1_syncE_refclk0_sel ; 
logic [3:0] physs_registers_wrapper_1_syncE_refclk0_div_m1 ; 
logic physs_registers_wrapper_1_syncE_refclk0_div_load ; 
logic physs_registers_wrapper_1_syncE_refclk1_div_rst ; 
logic [2:0] physs_registers_wrapper_1_syncE_refclk1_sel ; 
logic [3:0] physs_registers_wrapper_1_syncE_refclk1_div_m1 ; 
logic physs_registers_wrapper_1_syncE_refclk1_div_load ; 
logic physs_registers_wrapper_0_pcs_mode_config_syncE_mux_sel ; 
logic physs_registers_wrapper_1_pcs_mode_config_syncE_mux_sel ; 
logic physs_registers_wrapper_0_pcs_mode_config_syncE_mux_sel_0 ; 
logic physs_registers_wrapper_1_pcs_mode_config_syncE_mux_sel_0 ; 
logic [7:0] physs_registers_wrapper_0_mac200_config_0_xoff_gen ; 
logic physs_registers_wrapper_0_mac200_config_0_tx_loc_fault ; 
logic physs_registers_wrapper_0_mac200_config_0_tx_rem_fault ; 
logic physs_registers_wrapper_0_mac200_config_0_tx_li_fault ; 
logic physs_registers_wrapper_0_mac200_config_0_tx_smhold ; 
logic [7:0] physs_registers_wrapper_1_mac200_config_0_xoff_gen ; 
logic physs_registers_wrapper_1_mac200_config_0_tx_loc_fault ; 
logic physs_registers_wrapper_1_mac200_config_0_tx_rem_fault ; 
logic physs_registers_wrapper_1_mac200_config_0_tx_li_fault ; 
logic physs_registers_wrapper_1_mac200_config_0_tx_smhold ; 
logic [7:0] physs_registers_wrapper_0_mac400_config_0_xoff_gen ; 
logic physs_registers_wrapper_0_mac400_config_0_tx_loc_fault ; 
logic physs_registers_wrapper_0_mac400_config_0_tx_rem_fault ; 
logic physs_registers_wrapper_0_mac400_config_0_tx_li_fault ; 
logic physs_registers_wrapper_0_mac400_config_0_tx_smhold ; 
logic [7:0] physs_registers_wrapper_1_mac400_config_0_xoff_gen ; 
logic physs_registers_wrapper_1_mac400_config_0_tx_loc_fault ; 
logic physs_registers_wrapper_1_mac400_config_0_tx_rem_fault ; 
logic physs_registers_wrapper_1_mac400_config_0_tx_li_fault ; 
logic physs_registers_wrapper_1_mac400_config_0_tx_smhold ; 
wire physs_func_clk_adop_parmisc_physs0_clkout_0 ; 
wire o_ck_pma0_rx_postdiv_l0_adop_parmquad0_clkout ; 
wire o_ck_pma1_rx_postdiv_l0_adop_parmquad0_clkout ; 
wire o_ck_pma2_rx_postdiv_l0_adop_parmquad0_clkout ; 
wire o_ck_pma3_rx_postdiv_l0_adop_parmquad0_clkout ; 
wire o_ck_pma0_rx_postdiv_l0_adop_parmquad1_clkout ; 
wire o_ck_pma1_rx_postdiv_l0_adop_parmquad1_clkout ; 
wire o_ck_pma2_rx_postdiv_l0_adop_parmquad1_clkout ; 
wire o_ck_pma3_rx_postdiv_l0_adop_parmquad1_clkout ; 
wire fscan_ref_clk_adop_parmisc_physs0_clkout ; 
wire cosq_func_clk0_adop_parmisc_physs0_clkout_0 ; 
wire cosq_func_clk1_adop_parmisc_physs0_clkout_0 ; 
wire physs_pcs_mux_0_sd0_tx_clk_200G ; 
wire physs_pcs_mux_1_sd0_tx_clk_200G ; 
wire physs_pcs_mux_0_sd4_tx_clk_200G ; 
wire physs_pcs_mux_1_sd4_tx_clk_200G ; 
wire physs_pcs_mux_0_sd8_tx_clk_200G ; 
wire physs_pcs_mux_1_sd8_tx_clk_200G ; 
wire physs_pcs_mux_0_sd12_tx_clk_200G ; 
wire physs_pcs_mux_1_sd12_tx_clk_200G ; 
wire physs_pcs_mux_0_sd0_tx_clk_400G ; 
wire physs_pcs_mux_1_sd0_tx_clk_400G ; 
wire physs_pcs_mux_0_sd4_tx_clk_400G ; 
wire physs_pcs_mux_1_sd4_tx_clk_400G ; 
wire physs_pcs_mux_0_sd8_tx_clk_400G ; 
wire physs_pcs_mux_1_sd8_tx_clk_400G ; 
wire physs_pcs_mux_0_sd12_tx_clk_400G ; 
wire physs_pcs_mux_1_sd12_tx_clk_400G ; 
wire physs_pcs_mux_0_sd0_rx_clk_400G ; 
wire physs_pcs_mux_1_sd0_rx_clk_400G ; 
wire physs_pcs_mux_0_sd4_rx_clk_400G ; 
wire physs_pcs_mux_1_sd4_rx_clk_400G ; 
wire physs_pcs_mux_0_sd8_rx_clk_400G ; 
wire physs_pcs_mux_1_sd8_rx_clk_400G ; 
wire physs_pcs_mux_0_sd12_rx_clk_400G ; 
wire physs_pcs_mux_1_sd12_rx_clk_400G ; 
wire physs_pcs_mux_0_sd0_rx_clk_200G ; 
wire physs_pcs_mux_1_sd0_rx_clk_200G ; 
wire physs_pcs_mux_0_sd4_rx_clk_200G ; 
wire physs_pcs_mux_1_sd4_rx_clk_200G ; 
wire physs_pcs_mux_0_sd8_rx_clk_200G ; 
wire physs_pcs_mux_1_sd8_rx_clk_200G ; 
wire physs_pcs_mux_0_sd12_rx_clk_200G ; 
wire physs_pcs_mux_1_sd12_rx_clk_200G ; 
wire physs_funcx2_clk_adop_parmisc_physs0_clkout ; 
wire physs_pcs_mux_0_sd_rx_clk_800G ; 
wire physs_pcs_mux_0_sd_rx_clk_800G_0 ; 
wire physs_pcs_mux_0_sd_rx_clk_800G_1 ; 
wire physs_pcs_mux_0_sd_rx_clk_800G_2 ; 
wire physs_pcs_mux_1_sd_rx_clk_800G ; 
wire physs_pcs_mux_1_sd_rx_clk_800G_0 ; 
wire physs_pcs_mux_1_sd_rx_clk_800G_1 ; 
wire physs_pcs_mux_1_sd_rx_clk_800G_2 ; 
wire physs_pcs_mux_0_sd_tx_clk_800G ; 
wire physs_pcs_mux_0_sd_tx_clk_800G_0 ; 
wire physs_pcs_mux_0_sd_tx_clk_800G_1 ; 
wire physs_pcs_mux_0_sd_tx_clk_800G_2 ; 
wire physs_pcs_mux_1_sd_tx_clk_800G ; 
wire physs_pcs_mux_1_sd_tx_clk_800G_0 ; 
wire physs_pcs_mux_1_sd_tx_clk_800G_1 ; 
wire physs_pcs_mux_1_sd_tx_clk_800G_2 ; 
wire o_ck_pma0_cmnplla_postdiv_clk_mux_parmquad0_clkout ; 
wire uart_clk_adop_parmisc_physs0_clkout ; 
logic physs_registers_wrapper_0_uart_port_mux_sel_uart_mux_sel ; 
logic physs_registers_wrapper_0_uart_port_mux_sel_uart_mux_sel_0 ; 
wire uart_sel_and0_o ; 
wire uart_sel_and1_o ; 
logic [1023:0] fifo_top_mux_0_mse_physs_port_0_tx_data ; 
logic [6:0] fifo_top_mux_0_mse_physs_port_0_tx_mod ; 
logic fifo_top_mux_0_mse_physs_port_0_tx_err ; 
logic fifo_top_mux_0_mse_physs_port_0_tx_crc ; 
logic fifo_top_mux_0_mse_physs_port_0_ts_capture_vld ; 
logic [6:0] fifo_top_mux_0_mse_physs_port_0_ts_capture_idx ; 
logic mac800_ff_rx_dval ; 
logic [1023:0] mac800_ff_rx_data ; 
logic mac800_ff_rx_sop ; 
logic mac800_ff_rx_eop ; 
logic [6:0] mac800_ff_rx_mod ; 
logic mac800_ff_rx_err ; 
logic mac800_ff_rx_err_stat ; 
logic [6:0] mac800_ff_rx_ts ; 
logic [31:0] mac800_ff_rx_ts_0 ; 
logic mac800_ff_tx_rdy ; 
logic nic400_quad_0_hselx_mac400_stats_0 ; 
logic [17:0] nic400_quad_0_haddr_mac400_stats_0_out ; 
logic [1:0] nic400_quad_0_htrans_mac400_stats_0 ; 
logic nic400_quad_0_hwrite_mac400_stats_0 ; 
logic [2:0] nic400_quad_0_hsize_mac400_stats_0 ; 
logic [31:0] nic400_quad_0_hwdata_mac400_stats_0 ; 
logic nic400_quad_0_hready_mac400_stats_0 ; 
logic [2:0] nic400_quad_0_hburst_mac400_stats_0 ; 
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
logic [2:0] nic400_quad_0_hburst_mac400_stats_1 ; 
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
logic [2:0] nic400_quad_0_hburst_mac400_0 ; 
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
logic [2:0] nic400_quad_0_hburst_mac400_1 ; 
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
logic [2:0] nic400_quad_0_hburst_pcs400_0 ; 
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
logic [2:0] nic400_quad_0_hburst_rsfec400_0 ; 
logic [31:0] pcs200_ahb_bridge_1_hrdata ; 
wire pcs200_ahb_bridge_1_hresp ; 
wire pcs200_ahb_bridge_1_hreadyout ; 
logic nic400_quad_0_hselx_rsfecstats400_1 ; 
logic [17:0] nic400_quad_0_haddr_rsfecstats400_1_out ; 
logic [1:0] nic400_quad_0_htrans_rsfecstats400_1 ; 
logic nic400_quad_0_hwrite_rsfecstats400_1 ; 
logic [2:0] nic400_quad_0_hsize_rsfecstats400_1 ; 
logic [31:0] nic400_quad_0_hwdata_rsfecstats400_1 ; 
logic nic400_quad_0_hready_rsfecstats400_1 ; 
logic [2:0] nic400_quad_0_hburst_rsfecstats400_1 ; 
logic [31:0] pcs200_ahb_bridge_4_hrdata ; 
wire pcs200_ahb_bridge_4_hresp ; 
wire pcs200_ahb_bridge_4_hreadyout ; 
logic nic400_quad_0_hselx_pcs400_1 ; 
logic [17:0] nic400_quad_0_haddr_pcs400_1_out ; 
logic [1:0] nic400_quad_0_htrans_pcs400_1 ; 
logic nic400_quad_0_hwrite_pcs400_1 ; 
logic [2:0] nic400_quad_0_hsize_pcs400_1 ; 
logic [31:0] nic400_quad_0_hwdata_pcs400_1 ; 
logic nic400_quad_0_hready_pcs400_1 ; 
logic [2:0] nic400_quad_0_hburst_pcs400_1 ; 
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
logic [2:0] nic400_quad_0_hburst_rsfec400_1 ; 
logic [31:0] pcs400_ahb_bridge_1_hrdata ; 
wire pcs400_ahb_bridge_1_hresp ; 
wire pcs400_ahb_bridge_1_hreadyout ; 
logic nic400_quad_0_hselx_rsfecstats400_0 ; 
logic [17:0] nic400_quad_0_haddr_rsfecstats400_0_out ; 
logic [1:0] nic400_quad_0_htrans_rsfecstats400_0 ; 
logic nic400_quad_0_hwrite_rsfecstats400_0 ; 
logic [2:0] nic400_quad_0_hsize_rsfecstats400_0 ; 
logic [31:0] nic400_quad_0_hwdata_rsfecstats400_0 ; 
logic nic400_quad_0_hready_rsfecstats400_0 ; 
logic [2:0] nic400_quad_0_hburst_rsfecstats400_0 ; 
logic [31:0] pcs400_ahb_bridge_4_hrdata ; 
wire pcs400_ahb_bridge_4_hresp ; 
wire pcs400_ahb_bridge_4_hreadyout ; 
logic nic400_quad_0_hselx_tsu_400_0 ; 
logic [17:0] nic400_quad_0_haddr_tsu_400_0_out ; 
logic [1:0] nic400_quad_0_htrans_tsu_400_0 ; 
logic nic400_quad_0_hwrite_tsu_400_0 ; 
logic [2:0] nic400_quad_0_hsize_tsu_400_0 ; 
logic [31:0] nic400_quad_0_hwdata_tsu_400_0 ; 
logic nic400_quad_0_hready_tsu_400_0 ; 
logic [2:0] nic400_quad_0_hburst_tsu_400_0 ; 
logic [31:0] tsu400_ahb_bridge_0_hrdata ; 
wire tsu400_ahb_bridge_0_hresp ; 
wire tsu400_ahb_bridge_0_hreadyout ; 
logic nic400_quad_0_hselx_tsu_400_1 ; 
logic [17:0] nic400_quad_0_haddr_tsu_400_1_out ; 
logic [1:0] nic400_quad_0_htrans_tsu_400_1 ; 
logic nic400_quad_0_hwrite_tsu_400_1 ; 
logic [2:0] nic400_quad_0_hsize_tsu_400_1 ; 
logic [31:0] nic400_quad_0_hwdata_tsu_400_1 ; 
logic nic400_quad_0_hready_tsu_400_1 ; 
logic [2:0] nic400_quad_0_hburst_tsu_400_1 ; 
logic [31:0] tsu200_ahb_bridge_0_hrdata ; 
wire tsu200_ahb_bridge_0_hresp ; 
wire tsu200_ahb_bridge_0_hreadyout ; 
logic nic400_quad_1_hselx_mac400_stats_0 ; 
logic [17:0] nic400_quad_1_haddr_mac400_stats_0_out ; 
logic [1:0] nic400_quad_1_htrans_mac400_stats_0 ; 
logic nic400_quad_1_hwrite_mac400_stats_0 ; 
logic [2:0] nic400_quad_1_hsize_mac400_stats_0 ; 
logic [31:0] nic400_quad_1_hwdata_mac400_stats_0 ; 
logic nic400_quad_1_hready_mac400_stats_0 ; 
logic [2:0] nic400_quad_1_hburst_mac400_stats_0 ; 
logic [31:0] macstats_ahb_bridge_10_hrdata ; 
wire macstats_ahb_bridge_10_hresp ; 
wire macstats_ahb_bridge_10_hreadyout ; 
logic nic400_quad_1_hselx_mac400_stats_1 ; 
logic [17:0] nic400_quad_1_haddr_mac400_stats_1_out ; 
logic [1:0] nic400_quad_1_htrans_mac400_stats_1 ; 
logic nic400_quad_1_hwrite_mac400_stats_1 ; 
logic [2:0] nic400_quad_1_hsize_mac400_stats_1 ; 
logic [31:0] nic400_quad_1_hwdata_mac400_stats_1 ; 
logic nic400_quad_1_hready_mac400_stats_1 ; 
logic [2:0] nic400_quad_1_hburst_mac400_stats_1 ; 
logic [31:0] macstats_ahb_bridge_11_hrdata ; 
wire macstats_ahb_bridge_11_hresp ; 
wire macstats_ahb_bridge_11_hreadyout ; 
logic nic400_quad_1_hselx_mac400_0 ; 
logic [17:0] nic400_quad_1_haddr_mac400_0_out ; 
logic [1:0] nic400_quad_1_htrans_mac400_0 ; 
logic nic400_quad_1_hwrite_mac400_0 ; 
logic [2:0] nic400_quad_1_hsize_mac400_0 ; 
logic [31:0] nic400_quad_1_hwdata_mac400_0 ; 
logic nic400_quad_1_hready_mac400_0 ; 
logic [2:0] nic400_quad_1_hburst_mac400_0 ; 
logic [31:0] mac200_ahb_bridge_1_hrdata ; 
wire mac200_ahb_bridge_1_hresp ; 
wire mac200_ahb_bridge_1_hreadyout ; 
logic nic400_quad_1_hselx_mac400_1 ; 
logic [17:0] nic400_quad_1_haddr_mac400_1_out ; 
logic [1:0] nic400_quad_1_htrans_mac400_1 ; 
logic nic400_quad_1_hwrite_mac400_1 ; 
logic [2:0] nic400_quad_1_hsize_mac400_1 ; 
logic [31:0] nic400_quad_1_hwdata_mac400_1 ; 
logic nic400_quad_1_hready_mac400_1 ; 
logic [2:0] nic400_quad_1_hburst_mac400_1 ; 
logic [31:0] mac400_ahb_bridge_1_hrdata ; 
wire mac400_ahb_bridge_1_hresp ; 
wire mac400_ahb_bridge_1_hreadyout ; 
logic nic400_quad_1_hselx_pcs400_0 ; 
logic [17:0] nic400_quad_1_haddr_pcs400_0_out ; 
logic [1:0] nic400_quad_1_htrans_pcs400_0 ; 
logic nic400_quad_1_hwrite_pcs400_0 ; 
logic [2:0] nic400_quad_1_hsize_pcs400_0 ; 
logic [31:0] nic400_quad_1_hwdata_pcs400_0 ; 
logic nic400_quad_1_hready_pcs400_0 ; 
logic [2:0] nic400_quad_1_hburst_pcs400_0 ; 
logic [31:0] pcs200_ahb_bridge_2_hrdata ; 
wire pcs200_ahb_bridge_2_hresp ; 
wire pcs200_ahb_bridge_2_hreadyout ; 
logic nic400_quad_1_hselx_rsfec400_0 ; 
logic [17:0] nic400_quad_1_haddr_rsfec400_0_out ; 
logic [1:0] nic400_quad_1_htrans_rsfec400_0 ; 
logic nic400_quad_1_hwrite_rsfec400_0 ; 
logic [2:0] nic400_quad_1_hsize_rsfec400_0 ; 
logic [31:0] nic400_quad_1_hwdata_rsfec400_0 ; 
logic nic400_quad_1_hready_rsfec400_0 ; 
logic [2:0] nic400_quad_1_hburst_rsfec400_0 ; 
logic [31:0] pcs200_ahb_bridge_3_hrdata ; 
wire pcs200_ahb_bridge_3_hresp ; 
wire pcs200_ahb_bridge_3_hreadyout ; 
logic nic400_quad_1_hselx_rsfecstats400_1 ; 
logic [17:0] nic400_quad_1_haddr_rsfecstats400_1_out ; 
logic [1:0] nic400_quad_1_htrans_rsfecstats400_1 ; 
logic nic400_quad_1_hwrite_rsfecstats400_1 ; 
logic [2:0] nic400_quad_1_hsize_rsfecstats400_1 ; 
logic [31:0] nic400_quad_1_hwdata_rsfecstats400_1 ; 
logic nic400_quad_1_hready_rsfecstats400_1 ; 
logic [2:0] nic400_quad_1_hburst_rsfecstats400_1 ; 
logic [31:0] pcs200_ahb_bridge_5_hrdata ; 
wire pcs200_ahb_bridge_5_hresp ; 
wire pcs200_ahb_bridge_5_hreadyout ; 
logic nic400_quad_1_hselx_pcs400_1 ; 
logic [17:0] nic400_quad_1_haddr_pcs400_1_out ; 
logic [1:0] nic400_quad_1_htrans_pcs400_1 ; 
logic nic400_quad_1_hwrite_pcs400_1 ; 
logic [2:0] nic400_quad_1_hsize_pcs400_1 ; 
logic [31:0] nic400_quad_1_hwdata_pcs400_1 ; 
logic nic400_quad_1_hready_pcs400_1 ; 
logic [2:0] nic400_quad_1_hburst_pcs400_1 ; 
logic [31:0] pcs400_ahb_bridge_2_hrdata ; 
wire pcs400_ahb_bridge_2_hresp ; 
wire pcs400_ahb_bridge_2_hreadyout ; 
logic nic400_quad_1_hselx_rsfec400_1 ; 
logic [17:0] nic400_quad_1_haddr_rsfec400_1_out ; 
logic [1:0] nic400_quad_1_htrans_rsfec400_1 ; 
logic nic400_quad_1_hwrite_rsfec400_1 ; 
logic [2:0] nic400_quad_1_hsize_rsfec400_1 ; 
logic [31:0] nic400_quad_1_hwdata_rsfec400_1 ; 
logic nic400_quad_1_hready_rsfec400_1 ; 
logic [2:0] nic400_quad_1_hburst_rsfec400_1 ; 
logic [31:0] pcs400_ahb_bridge_3_hrdata ; 
wire pcs400_ahb_bridge_3_hresp ; 
wire pcs400_ahb_bridge_3_hreadyout ; 
logic nic400_quad_1_hselx_rsfecstats400_0 ; 
logic [17:0] nic400_quad_1_haddr_rsfecstats400_0_out ; 
logic [1:0] nic400_quad_1_htrans_rsfecstats400_0 ; 
logic nic400_quad_1_hwrite_rsfecstats400_0 ; 
logic [2:0] nic400_quad_1_hsize_rsfecstats400_0 ; 
logic [31:0] nic400_quad_1_hwdata_rsfecstats400_0 ; 
logic nic400_quad_1_hready_rsfecstats400_0 ; 
logic [2:0] nic400_quad_1_hburst_rsfecstats400_0 ; 
logic [31:0] pcs400_ahb_bridge_5_hrdata ; 
wire pcs400_ahb_bridge_5_hresp ; 
wire pcs400_ahb_bridge_5_hreadyout ; 
logic nic400_quad_1_hselx_tsu_400_0 ; 
logic [17:0] nic400_quad_1_haddr_tsu_400_0_out ; 
logic [1:0] nic400_quad_1_htrans_tsu_400_0 ; 
logic nic400_quad_1_hwrite_tsu_400_0 ; 
logic [2:0] nic400_quad_1_hsize_tsu_400_0 ; 
logic [31:0] nic400_quad_1_hwdata_tsu_400_0 ; 
logic nic400_quad_1_hready_tsu_400_0 ; 
logic [2:0] nic400_quad_1_hburst_tsu_400_0 ; 
logic [31:0] tsu400_ahb_bridge_1_hrdata ; 
wire tsu400_ahb_bridge_1_hresp ; 
wire tsu400_ahb_bridge_1_hreadyout ; 
logic nic400_quad_1_hselx_tsu_400_1 ; 
logic [17:0] nic400_quad_1_haddr_tsu_400_1_out ; 
logic [1:0] nic400_quad_1_htrans_tsu_400_1 ; 
logic nic400_quad_1_hwrite_tsu_400_1 ; 
logic [2:0] nic400_quad_1_hsize_tsu_400_1 ; 
logic [31:0] nic400_quad_1_hwdata_tsu_400_1 ; 
logic nic400_quad_1_hready_tsu_400_1 ; 
logic [2:0] nic400_quad_1_hburst_tsu_400_1 ; 
logic [31:0] tsu200_ahb_bridge_1_hrdata ; 
wire tsu200_ahb_bridge_1_hresp ; 
wire tsu200_ahb_bridge_1_hreadyout ; 
logic physs_registers_wrapper_0_reset_ref_clk_override_0 ; 
logic physs_registers_wrapper_0_reset_pcs100_override_en_0 ; 
logic physs_registers_wrapper_0_clk_gate_en_100G_mac_pcs_0 ; 
logic physs_registers_wrapper_0_power_fsm_clk_gate_en_0 ; 
logic physs_registers_wrapper_0_power_fsm_reset_gate_en_0 ; 
logic physs_registers_wrapper_1_reset_ref_clk_override_0 ; 
logic physs_registers_wrapper_1_reset_pcs100_override_en_0 ; 
logic physs_registers_wrapper_1_clk_gate_en_100G_mac_pcs_0 ; 
logic physs_registers_wrapper_1_power_fsm_clk_gate_en_0 ; 
logic physs_registers_wrapper_1_power_fsm_reset_gate_en_0 ; 
logic [7:0] mac200_0_pause_on ; 
logic [7:0] mac400_0_pause_on ; 
logic mac200_0_li_fault ; 
logic mac400_0_li_fault ; 
logic mac200_0_rem_fault ; 
logic mac400_0_rem_fault ; 
logic mac200_0_loc_fault ; 
logic mac400_0_loc_fault ; 
logic mac200_0_tx_empty ; 
logic mac400_0_tx_empty ; 
logic mac200_0_ff_rx_empty ; 
logic mac400_0_ff_rx_empty ; 
logic mac200_0_tx_isidle ; 
logic mac400_0_tx_isidle ; 
logic mac200_0_ff_tx_septy ; 
logic mac400_0_ff_tx_septy ; 
logic mac200_0_tx_underflow ; 
logic mac400_0_tx_underflow ; 
logic mac200_0_tx_ovr_err ; 
logic mac400_0_tx_ovr_err ; 
logic mac200_0_mdio_oen ; 
logic mac400_0_mdio_oen ; 
logic mac200_0_pfc_mode ; 
logic mac400_0_pfc_mode ; 
logic mac200_0_ff_rx_dsav ; 
logic mac400_0_ff_rx_dsav ; 
logic mac200_0_ff_tx_credit ; 
logic mac400_0_ff_tx_credit ; 
logic mac200_0_inv_loop_ind ; 
logic mac400_0_inv_loop_ind ; 
logic mac200_0_frm_drop ; 
logic mac400_0_frm_drop ; 
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
logic [2:0] physs_registers_wrapper_0_pcs200_reg_tx_am_sf ; 
logic physs_registers_wrapper_0_pcs200_reg_rsfec_mode_ll ; 
logic physs_registers_wrapper_0_pcs200_reg_sd_4x_en ; 
logic physs_registers_wrapper_0_pcs200_reg_sd_8x_en ; 
logic [2:0] physs_registers_wrapper_1_pcs200_reg_tx_am_sf ; 
logic physs_registers_wrapper_1_pcs200_reg_rsfec_mode_ll ; 
logic physs_registers_wrapper_1_pcs200_reg_sd_4x_en ; 
logic physs_registers_wrapper_1_pcs200_reg_sd_8x_en ; 
logic [2:0] physs_registers_wrapper_0_pcs400_reg_tx_am_sf ; 
logic physs_registers_wrapper_0_pcs400_reg_rsfec_mode_ll ; 
logic physs_registers_wrapper_0_pcs400_reg_sd_4x_en ; 
logic physs_registers_wrapper_0_pcs400_reg_sd_8x_en ; 
logic [2:0] physs_registers_wrapper_1_pcs400_reg_tx_am_sf ; 
logic physs_registers_wrapper_1_pcs400_reg_rsfec_mode_ll ; 
logic physs_registers_wrapper_1_pcs400_reg_sd_4x_en ; 
logic physs_registers_wrapper_1_pcs400_reg_sd_8x_en ; 
logic [1:0] physs_registers_wrapper_0_pcs_mode_config_pcs_mode_sel_0 ; 
logic parmquad0_mux_sel_800 ; 
logic [1:0] physs_registers_wrapper_0_pcs_mode_config_fifo_mode_sel ; 
logic [7:0] mac200_1_pause_on ; 
logic [7:0] mac400_1_pause_on ; 
logic mac200_1_li_fault ; 
logic mac400_1_li_fault ; 
logic mac200_1_rem_fault ; 
logic mac400_1_rem_fault ; 
logic mac200_1_loc_fault ; 
logic mac400_1_loc_fault ; 
logic mac200_1_tx_empty ; 
logic mac400_1_tx_empty ; 
logic mac200_1_ff_rx_empty ; 
logic mac400_1_ff_rx_empty ; 
logic mac200_1_tx_isidle ; 
logic mac400_1_tx_isidle ; 
logic mac200_1_ff_tx_septy ; 
logic mac400_1_ff_tx_septy ; 
logic mac200_1_tx_underflow ; 
logic mac400_1_tx_underflow ; 
logic mac200_1_tx_ovr_err ; 
logic mac400_1_tx_ovr_err ; 
logic mac200_1_mdio_oen ; 
logic mac400_1_mdio_oen ; 
logic mac200_1_pfc_mode ; 
logic mac400_1_pfc_mode ; 
logic mac200_1_ff_rx_dsav ; 
logic mac400_1_ff_rx_dsav ; 
logic mac200_1_ff_tx_credit ; 
logic mac400_1_ff_tx_credit ; 
logic mac200_1_inv_loop_ind ; 
logic mac400_1_inv_loop_ind ; 
logic mac200_1_frm_drop ; 
logic mac400_1_frm_drop ; 
logic [2:0] pcs200_1_rx_am_sf ; 
logic pcs200_1_degrade_ser ; 
logic pcs200_1_hi_ser ; 
logic pcs200_1_link_status ; 
logic [15:0] pcs200_1_amps_lock ; 
logic pcs200_1_align_lock ; 
logic [2:0] pcs400_1_rx_am_sf ; 
logic pcs400_1_degrade_ser ; 
logic pcs400_1_hi_ser ; 
logic pcs400_1_link_status ; 
logic [15:0] pcs400_1_amps_lock ; 
logic pcs400_1_align_lock ; 
logic [1:0] physs_registers_wrapper_1_pcs_mode_config_pcs_mode_sel_0 ; 
logic [1:0] physs_registers_wrapper_1_pcs_mode_config_fifo_mode_sel ; 
logic parmisc_physs0_pd_vinf_0_bisr_so ; 
logic par400g0_pd_vinf_0_bisr_so ; 
logic parmquad0_pd_vinf_0_bisr_so ; 
logic par400g0_pd_vinf_0_2_bisr_so ; 
logic parmisc_physs0_pd_vinf_1_bisr_so ; 
logic par400g1_pd_vinf_1_bisr_so ; 
logic parmquad1_pd_vinf_1_bisr_so ; 
logic par400g1_pd_vinf_1_2_bisr_so ; 
logic parmisc_physs0_pd_vinf_2_bisr_so ; 
logic par400g0_pd_vinf_2_bisr_so ; 
logic parmisc_physs0_pd_vinf_3_bisr_so ; 
logic par400g1_pd_vinf_3_bisr_so ; 
logic parmisc_physs0_pd_vinf_4_bisr_so ; 
logic par800g_pd_vinf_4_bisr_so ; 
wire physs_func_clk_pdop_parmquad0_clkout_0 ; 
wire physs_func_clk_pdop_parmquad1_clkout ; 
logic physs_clock_sync_parmisc_physs0_func_rstn_func_sync ; 
logic par800g_DIAG_0_mbist_diag_done ; 
logic par400g0_DIAG_AGGR_par400g0_mbist_diag_done ; 
logic par400g1_DIAG_AGGR_par400g1_mbist_diag_done ; 
logic parmquad0_DIAG_AGGR_mquad0_mbist_diag_done ; 
logic parmquad1_DIAG_AGGR_mquad1_mbist_diag_done ; 
logic versa_xmp_1_o_ucss_srds_pcs_tx_reset_pma0_l0_a ; 
logic versa_xmp_1_o_ucss_srds_pcs_rx_reset_pma0_l0_a ; 
logic versa_xmp_1_o_ucss_srds_pcs_tx_reset_pma2_l0_a ; 
logic versa_xmp_1_o_ucss_srds_pcs_rx_reset_pma2_l0_a ; 
logic physs_registers_wrapper_1_reset_cdmii_rxclk_override_200G ; 
logic physs_registers_wrapper_1_reset_cdmii_txclk_override_200G ; 
logic physs_registers_wrapper_1_reset_sd_tx_clk_override_200G ; 
logic physs_registers_wrapper_1_reset_sd_rx_clk_override_200G ; 
logic physs_registers_wrapper_1_reset_reg_clk_override_200G ; 
logic physs_registers_wrapper_1_reset_reg_ref_clk_override_200G ; 
logic physs_registers_wrapper_1_reset_cdmii_rxclk_override_400G ; 
logic physs_registers_wrapper_1_reset_cdmii_txclk_override_400G ; 
logic physs_registers_wrapper_1_reset_sd_tx_clk_override_400G ; 
logic physs_registers_wrapper_1_reset_sd_rx_clk_override_400G ; 
logic physs_registers_wrapper_1_reset_reg_clk_override_400G ; 
logic physs_registers_wrapper_1_reset_reg_ref_clk_override_400G ; 
logic physs_registers_wrapper_1_clk_gate_en_200G_mac_pcs_0 ; 
logic physs_registers_wrapper_1_clk_gate_en_400G_mac_pcs_0 ; 
logic physs_registers_wrapper_1_reset_pcs200_override_en ; 
logic physs_registers_wrapper_1_reset_pcs400_override_en ; 
logic physs_registers_wrapper_1_reset_mac200_override_en ; 
logic physs_registers_wrapper_1_reset_mac400_override_en ; 
logic [1:0] physs_registers_wrapper_1_reset_reg_clk_override_mac_0 ; 
logic [1:0] physs_registers_wrapper_1_reset_ff_tx_clk_override_0 ; 
logic [1:0] physs_registers_wrapper_1_reset_ff_rx_clk_override_0 ; 
logic [1:0] physs_registers_wrapper_1_reset_txclk_override_0 ; 
logic [1:0] physs_registers_wrapper_1_reset_rxclk_override_0 ; 
logic versa_xmp_0_o_ucss_srds_pcs_tx_reset_pma0_l0_a ; 
logic versa_xmp_0_o_ucss_srds_pcs_rx_reset_pma0_l0_a ; 
logic versa_xmp_0_o_ucss_srds_pcs_tx_reset_pma2_l0_a ; 
logic versa_xmp_0_o_ucss_srds_pcs_rx_reset_pma2_l0_a ; 
logic physs_registers_wrapper_0_reset_cdmii_rxclk_override_200G ; 
logic physs_registers_wrapper_0_reset_cdmii_txclk_override_200G ; 
logic physs_registers_wrapper_0_reset_sd_tx_clk_override_200G ; 
logic physs_registers_wrapper_0_reset_sd_rx_clk_override_200G ; 
logic physs_registers_wrapper_0_reset_reg_clk_override_200G ; 
logic physs_registers_wrapper_0_reset_reg_ref_clk_override_200G ; 
logic physs_registers_wrapper_0_reset_cdmii_rxclk_override_400G ; 
logic physs_registers_wrapper_0_reset_cdmii_txclk_override_400G ; 
logic physs_registers_wrapper_0_reset_sd_tx_clk_override_400G ; 
logic physs_registers_wrapper_0_reset_sd_rx_clk_override_400G ; 
logic physs_registers_wrapper_0_reset_reg_clk_override_400G ; 
logic physs_registers_wrapper_0_reset_reg_ref_clk_override_400G ; 
logic physs_registers_wrapper_0_clk_gate_en_200G_mac_pcs_0 ; 
logic physs_registers_wrapper_0_clk_gate_en_400G_mac_pcs_0 ; 
logic physs_registers_wrapper_0_reset_pcs200_override_en ; 
logic physs_registers_wrapper_0_reset_pcs400_override_en ; 
logic physs_registers_wrapper_0_reset_mac200_override_en ; 
logic physs_registers_wrapper_0_reset_mac400_override_en ; 
logic [1:0] physs_registers_wrapper_0_reset_reg_clk_override_mac_0 ; 
logic [1:0] physs_registers_wrapper_0_reset_ff_tx_clk_override_0 ; 
logic [1:0] physs_registers_wrapper_0_reset_ff_rx_clk_override_0 ; 
logic [1:0] physs_registers_wrapper_0_reset_txclk_override_0 ; 
logic [1:0] physs_registers_wrapper_0_reset_rxclk_override_0 ; 
logic [3:0] physs_registers_wrapper_0_pcs_mode_config_pcs_external_loopback_en_lane_0 ; 
logic [3:0] physs_registers_wrapper_1_pcs_mode_config_pcs_external_loopback_en_lane_0 ; 
logic versa_xmp_0_o_ucss_srds_pcs_tx_reset_pma1_l0_a ; 
logic versa_xmp_0_o_ucss_srds_pcs_tx_reset_pma3_l0_a ; 
logic versa_xmp_0_o_ucss_srds_pcs_rx_reset_pma1_l0_a ; 
logic versa_xmp_0_o_ucss_srds_pcs_rx_reset_pma3_l0_a ; 
logic versa_xmp_1_o_ucss_srds_pcs_tx_reset_pma1_l0_a ; 
logic versa_xmp_1_o_ucss_srds_pcs_tx_reset_pma3_l0_a ; 
logic versa_xmp_1_o_ucss_srds_pcs_rx_reset_pma1_l0_a ; 
logic versa_xmp_1_o_ucss_srds_pcs_rx_reset_pma3_l0_a ; 
logic physs_registers_wrapper_0_reset_ff_rx_override_MAC_800G ; 
logic physs_registers_wrapper_0_reset_ff_tx_override_MAC_800G ; 
logic physs_registers_wrapper_0_reset_reg_override_MAC_800G ; 
logic physs_registers_wrapper_0_reset_ref_override_MAC_800G ; 
logic [7:0] physs_registers_wrapper_0_reset_sd_tx_clk_override_800G ; 
logic [7:0] physs_registers_wrapper_0_reset_sd_rx_clk_override_800G ; 
logic physs_registers_wrapper_0_reset_ref_clk_override_PCS_800G ; 
logic physs_registers_wrapper_0_reset_ref_clk0_override_PCS_800G ; 
logic physs_registers_wrapper_0_reset_ref_clk1_override_PCS_800G ; 
logic physs_registers_wrapper_0_reset_reg_ref_clk_override_PCS_800G ; 
logic physs_registers_wrapper_0_clk_gate_en_800G_mac_pcs_0 ; 
logic versa_xmp_0_o_ucss_uart_txd ; 
logic versa_xmp_1_o_ucss_uart_txd ; 
logic physs_uart_demux_out0 ; 
logic physs_uart_demux_out1 ; 
logic [1:0] physs_registers_wrapper_0_uart_port_mux_sel_uart_mux_sel_1 ; 
logic [1:0] physs_registers_wrapper_0_uart_port_mux_sel_uart_mux_sel_2 ; 
wire xmp_mem_wrapper_0_aary_post_pass ; 
wire xmp_mem_wrapper_0_aary_post_complete ; 
wire xmp_mem_wrapper_1_aary_post_pass ; 
wire xmp_mem_wrapper_1_aary_post_complete ; 
wire pcs100_mem_wrapper_0_aary_post_pass ; 
wire pcs100_mem_wrapper_0_aary_post_complete ; 
wire pcs100_mem_wrapper_1_aary_post_pass ; 
wire pcs100_mem_wrapper_1_aary_post_complete ; 
wire ptpx_mem_wrapper_0_aary_post_pass ; 
wire ptpx_mem_wrapper_0_aary_post_complete ; 
wire ptpx_mem_wrapper_1_aary_post_pass ; 
wire ptpx_mem_wrapper_1_aary_post_complete ; 
wire mac100_mem_wrapper_0_aary_post_pass ; 
wire mac100_mem_wrapper_0_aary_post_complete ; 
wire mac100_mem_wrapper_1_aary_post_pass ; 
wire mac100_mem_wrapper_1_aary_post_complete ; 
logic par800g_macpcs800_6_post_pass_tdr ; 
logic par800g_macpcs800_6_post_complete_tdr ; 
logic par400g0_macpcs400_7_post_pass_tdr ; 
logic par400g0_macpcs400_7_post_complete_tdr ; 
logic par400g0_macpcs200_8_post_pass_tdr ; 
logic par400g0_macpcs200_8_post_complete_tdr ; 
logic par400g1_macpcs400_9_post_pass_tdr ; 
logic par400g1_macpcs400_9_post_complete_tdr ; 
logic par400g1_macpcs200_10_post_pass_tdr ; 
logic par400g1_macpcs200_10_post_complete_tdr ; 
logic par800g_macpcs800_6_post_busy_tdr ; 
logic par400g0_macpcs200_8_post_busy_tdr ; 
logic par400g0_macpcs400_7_post_busy_tdr ; 
logic par400g1_macpcs200_10_post_busy_tdr ; 
logic par400g1_macpcs400_9_post_busy_tdr ; 
logic parmisc_physs0_trig_clock_stop_to_parmquad0_o_ck_pma0_rx ; 
logic parmisc_physs0_trig_clock_stop_to_parmquad0_o_ck_pma1_rx ; 
logic parmisc_physs0_trig_clock_stop_to_parmquad0_o_ck_pma2_rx ; 
logic parmisc_physs0_trig_clock_stop_to_parmquad0_o_ck_pma3_rx ; 
logic parmisc_physs0_trig_clock_stop_to_parmquad0_pma0_rxdat ; 
logic parmisc_physs0_trig_clock_stop_to_parmquad0_pma1_rxdat ; 
logic parmisc_physs0_trig_clock_stop_to_parmquad0_pma2_rxdat ; 
logic parmisc_physs0_trig_clock_stop_to_parmquad0_pma3_rxdat ; 
logic parmisc_physs0_trig_clock_stop_to_parmquad0_o_ck_pma0_cmnplla_postdiv ; 
logic parmisc_physs0_trig_clock_stop_to_parmquad0_o_ck_pma1_cmnplla_postdiv ; 
logic parmisc_physs0_trig_clock_stop_to_parmquad0_o_ck_pma2_cmnplla_postdiv ; 
logic parmisc_physs0_trig_clock_stop_to_parmquad0_o_ck_pma3_cmnplla_postdiv ; 
logic parmisc_physs0_trig_clock_stop_to_parmquad0_o_ck_slv_pcs1 ; 
logic parmisc_physs0_trig_clock_stop_to_parmquad0_o_ck_ucss_mem_dram ; 
logic parmisc_physs0_trig_clock_stop_to_parmquad0_o_ck_ucss_mem_iram ; 
logic parmisc_physs0_trig_clock_stop_to_parmquad0_o_ck_ucss_mem_tracemem ; 
logic parmisc_physs0_trig_clock_stop_to_parmquad1_o_ck_pma0_rx ; 
logic parmisc_physs0_trig_clock_stop_to_parmquad1_o_ck_pma1_rx ; 
logic parmisc_physs0_trig_clock_stop_to_parmquad1_o_ck_pma2_rx ; 
logic parmisc_physs0_trig_clock_stop_to_parmquad1_o_ck_pma3_rx ; 
logic parmisc_physs0_trig_clock_stop_to_parmquad1_pma0_rxdat ; 
logic parmisc_physs0_trig_clock_stop_to_parmquad1_pma1_rxdat ; 
logic parmisc_physs0_trig_clock_stop_to_parmquad1_pma2_rxdat ; 
logic parmisc_physs0_trig_clock_stop_to_parmquad1_pma3_rxdat ; 
logic parmisc_physs0_trig_clock_stop_to_parmquad1_o_ck_pma0_cmnplla_postdiv ; 
logic parmisc_physs0_trig_clock_stop_to_parmquad1_o_ck_pma1_cmnplla_postdiv ; 
logic parmisc_physs0_trig_clock_stop_to_parmquad1_o_ck_pma2_cmnplla_postdiv ; 
logic parmisc_physs0_trig_clock_stop_to_parmquad1_o_ck_pma3_cmnplla_postdiv ; 
logic parmisc_physs0_trig_clock_stop_to_parmquad1_o_ck_slv_pcs1 ; 
logic parmisc_physs0_trig_clock_stop_to_parmquad1_o_ck_ucss_mem_dram ; 
logic parmisc_physs0_trig_clock_stop_to_parmquad1_o_ck_ucss_mem_iram ; 
logic parmisc_physs0_trig_clock_stop_to_parmquad1_o_ck_ucss_mem_tracemem ; 
logic [1:0] parmquad0_pcs_lane_sel_val_par400g0_rtdr ; 
logic parmquad0_pcs_lane_sel_ovr_par400g0_rtdr ; 
logic [1:0] parmquad1_pcs_lane_sel_val_par400g1_rtdr ; 
logic parmquad1_pcs_lane_sel_ovr_par400g1_rtdr ; 
logic physs_registers_wrapper_0_pcs800_config_400_8_en_in ; 
logic [1:0] physs_registers_wrapper_0_pcs800_config_400_en_in ; 
logic [1:0] physs_registers_wrapper_0_pcs800_config_200_4_en_in ; 
logic physs_registers_wrapper_0_pcs800_config_cdmii8blk ; 
logic [1:0] physs_registers_wrapper_0_pcs800_config_200_mode_ll ; 
logic physs_registers_wrapper_0_pcs800_config_loopback ; 
logic physs_registers_wrapper_0_pcs800_config_loopback_rev ; 
logic physs_registers_wrapper_0_mac800_ref_clkx2_en ; 
logic physs_registers_wrapper_0_mac800_mode1s_ena ; 
logic physs_registers_wrapper_0_mac800_tx_loc_fault ; 
logic physs_registers_wrapper_0_mac800_tx_rem_fault ; 
logic physs_registers_wrapper_0_mac800_tx_li_fault ; 
logic [7:0] physs_registers_wrapper_0_mac800_xoff_gen ; 
logic physs_registers_wrapper_0_mac800_tx_smhold ; 
logic [7:0] mac800_pause_on ; 
logic mac800_pfc_mode ; 
logic mac800_tx_ovr_err ; 
logic mac800_tx_underflow ; 
logic mac800_tx_empty ; 
logic mac800_tx_isidle ; 
logic mac800_mdio_oen ; 
logic mac800_loc_fault ; 
logic mac800_rem_fault ; 
logic mac800_li_fault ; 
logic mac800_inv_loop_ind ; 
logic mac800_frm_drop ; 
logic mac800_ff_tx_septy ; 
logic mac800_ff_tx_credit ; 
logic mac800_ff_rx_dsav ; 
logic mac800_ff_rx_empty ; 
logic mac800_tx_ts_val ; 
logic [3:0] mac800_tx_ts_id ; 
logic [71:0] mac800_tx_ts ; 
logic pcs800_p80_align_lock ; 
logic [15:0] pcs800_p80_amps_lock ; 
logic pcs800_p80_link_status_0 ; 
logic pcs800_p80_hi_ser ; 
logic pcs800_p80_degrade_ser_0 ; 
logic [2:0] pcs800_p80_rx_am_sf ; 
logic pcs800_p81_align_lock ; 
logic [15:0] pcs800_p81_amps_lock ; 
logic pcs800_p81_link_status_0 ; 
logic pcs800_p81_hi_ser ; 
logic pcs800_p81_degrade_ser_0 ; 
logic [2:0] pcs800_p81_rx_am_sf ; 
logic [6:0] physs_timestamp_0_timer_refpcs_0 ; 
logic [31:0] physs_timestamp_0_timer_refpcs_1 ; 
logic [6:0] physs_timestamp_1_timer_refpcs_0 ; 
logic [31:0] physs_timestamp_1_timer_refpcs_1 ; 
logic [6:0] physs_timestamp_0_timer_refpcs_2 ; 
logic [31:0] physs_timestamp_0_timer_refpcs_3 ; 
logic [6:0] physs_timestamp_1_timer_refpcs_2 ; 
logic [31:0] physs_timestamp_1_timer_refpcs_3 ; 
logic quad_interrupts_0_physs_fatal_int ; 
logic quad_interrupts_1_physs_fatal_int ; 
logic quad_interrupts_0_physs_imc_int ; 
logic quad_interrupts_1_physs_imc_int ; 
logic mac100_0_ff_rx_err_stat_0 ; 
logic mac100_1_ff_rx_err_stat_0 ; 
logic mac100_2_ff_rx_err_stat_0 ; 
logic mac100_3_ff_rx_err_stat_0 ; 
logic mac100_4_ff_rx_err_stat_0 ; 
logic mac100_5_ff_rx_err_stat_0 ; 
logic mac100_6_ff_rx_err_stat_0 ; 
logic mac100_7_ff_rx_err_stat_0 ; 
logic physs_core_rst_fsm_0_enable_link_traffic_to_nss_reg_clr ; 
logic physs_core_rst_fsm_1_enable_link_traffic_to_nss_reg_clr ; 
logic physs_registers_wrapper_0_link_traffic_to_nss_enable_O ; 
logic physs_registers_wrapper_1_link_traffic_to_nss_enable_O_0 ; 
logic [31:0] physs_registers_wrapper_0_ETH_GLTSYN_SHTIME_L_0_tsyntime_0_0 ; 
logic [31:0] physs_registers_wrapper_0_ETH_GLTSYN_SHTIME_H_0_tsyntime_l_0 ; 
logic [31:0] physs_registers_wrapper_0_ETH_GLTSYN_INCVAL_L_0_incval_l_0_0 ; 
logic [7:0] physs_registers_wrapper_0_ETH_GLTSYN_INCVAL_H_0_incval_h_0_0 ; 
logic [31:0] physs_registers_wrapper_0_ETH_GLTSYN_SHADJ_L_0_adjust_l_0 ; 
logic [31:0] physs_registers_wrapper_0_ETH_GLTSYN_SHADJ_H_0_adjust_h_0 ; 
logic [31:0] physs_registers_wrapper_0_ETH_GLTSYN_TIME_0_0_tsyntime_0_0 ; 
logic [31:0] physs_registers_wrapper_0_ETH_GLTSYN_TIME_L_0_tsyntime_l_0 ; 
logic physs_registers_wrapper_0_ETH_GLTSYN_ENA_0_tsyn_ena_0 ; 
logic [7:0] physs_registers_wrapper_0_ETH_GLTSYN_CMD_0_cmd_0 ; 
logic [7:0] physs_registers_wrapper_0_ETH_GLTSYN_SYNC_DLAY_0_sync_delay_0 ; 
logic [7:0] physs_registers_wrapper_0_TIMER_REFPCS_INCVAL_H_0_incval_h_0_0 ; 
logic [31:0] physs_registers_wrapper_0_TIMER_REFPCS_INCVAL_L_0_incval_l_0_0 ; 
logic physs_registers_wrapper_0_REFPCS_TIMER_CTRL_0_func_timer_err_chk_dis_0 ; 
logic physs_registers_wrapper_0_REFPCS_TIMER_CTRL_0_samp_1588_and_refpcs_timer_0 ; 
logic [3:0] physs_registers_wrapper_0_REFPCS_TIMER_CTRL_1_sync1588_pulse_interval ; 
logic physs_registers_wrapper_0_REFPCS_TIMER_CTRL_0_ts_valid_if_timer_en_0 ; 
wire nic_switch_mux_0_hlp_xlgmii0_txclk_ena ; 
wire nic_switch_mux_0_hlp_xlgmii0_rxclk_ena ; 
wire [7:0] nic_switch_mux_0_hlp_xlgmii0_rxc ; 
wire [63:0] nic_switch_mux_0_hlp_xlgmii0_rxd ; 
wire nic_switch_mux_0_hlp_xlgmii0_rxt0_next ; 
wire [7:0] pcs_mac_pipeline_top_wrap_mquad0_pcs0_xlgmii_tx_txc ; 
wire [63:0] pcs_mac_pipeline_top_wrap_mquad0_pcs0_xlgmii_tx_txd ; 
wire [1:0] quadpcs100_0_pcs_tsu_rx_sd_0 ; 
wire [1:0] quadpcs100_0_mii_rx_tsu_mux0_0 ; 
wire [1:0] quadpcs100_0_mii_tx_tsu_0 ; 
wire nic_switch_mux_0_hlp_xlgmii1_txclk_ena ; 
wire nic_switch_mux_0_hlp_xlgmii1_rxclk_ena ; 
wire [7:0] nic_switch_mux_0_hlp_xlgmii1_rxc ; 
wire [63:0] nic_switch_mux_0_hlp_xlgmii1_rxd ; 
wire nic_switch_mux_0_hlp_xlgmii1_rxt0_next ; 
wire [7:0] pcs_mac_pipeline_top_wrap_mquad0_pcs1_xlgmii_tx_txc ; 
wire [63:0] pcs_mac_pipeline_top_wrap_mquad0_pcs1_xlgmii_tx_txd ; 
wire [1:0] quadpcs100_0_pcs_tsu_rx_sd_1 ; 
wire [1:0] quadpcs100_0_mii_rx_tsu_mux1_0 ; 
wire [1:0] quadpcs100_0_mii_tx_tsu_1 ; 
wire nic_switch_mux_0_hlp_xlgmii2_txclk_ena ; 
wire nic_switch_mux_0_hlp_xlgmii2_rxclk_ena ; 
wire [7:0] nic_switch_mux_0_hlp_xlgmii2_rxc ; 
wire [63:0] nic_switch_mux_0_hlp_xlgmii2_rxd ; 
wire nic_switch_mux_0_hlp_xlgmii2_rxt0_next ; 
wire [7:0] pcs_mac_pipeline_top_wrap_mquad0_pcs2_xlgmii_tx_txc ; 
wire [63:0] pcs_mac_pipeline_top_wrap_mquad0_pcs2_xlgmii_tx_txd ; 
wire [1:0] quadpcs100_0_pcs_tsu_rx_sd_2 ; 
wire [1:0] quadpcs100_0_mii_rx_tsu_mux2_0 ; 
wire [1:0] quadpcs100_0_mii_tx_tsu_2 ; 
wire nic_switch_mux_0_hlp_xlgmii3_txclk_ena ; 
wire nic_switch_mux_0_hlp_xlgmii3_rxclk_ena ; 
wire [7:0] nic_switch_mux_0_hlp_xlgmii3_rxc ; 
wire [63:0] nic_switch_mux_0_hlp_xlgmii3_rxd ; 
wire nic_switch_mux_0_hlp_xlgmii3_rxt0_next ; 
wire [7:0] pcs_mac_pipeline_top_wrap_mquad0_pcs3_xlgmii_tx_txc ; 
wire [63:0] pcs_mac_pipeline_top_wrap_mquad0_pcs3_xlgmii_tx_txd ; 
wire [1:0] quadpcs100_0_pcs_tsu_rx_sd_3 ; 
wire [1:0] quadpcs100_0_mii_rx_tsu_mux3_0 ; 
wire [1:0] quadpcs100_0_mii_tx_tsu_3 ; 
wire nic_switch_mux_0_hlp_cgmii0_txclk_ena ; 
wire nic_switch_mux_0_hlp_cgmii0_rxclk_ena ; 
wire [15:0] nic_switch_mux_0_hlp_cgmii0_rxc ; 
wire [127:0] nic_switch_mux_0_hlp_cgmii0_rxd ; 
wire [15:0] pcs_mac_pipeline_top_wrap_mquad0_pcs0_cgmii_tx_txc ; 
wire [127:0] pcs_mac_pipeline_top_wrap_mquad0_pcs0_cgmii_tx_txd ; 
wire nic_switch_mux_0_hlp_cgmii1_txclk_ena ; 
wire nic_switch_mux_0_hlp_cgmii1_rxclk_ena ; 
wire [15:0] nic_switch_mux_0_hlp_cgmii1_rxc ; 
wire [127:0] nic_switch_mux_0_hlp_cgmii1_rxd ; 
wire [15:0] pcs_mac_pipeline_top_wrap_mquad0_pcs1_cgmii_tx_txc ; 
wire [127:0] pcs_mac_pipeline_top_wrap_mquad0_pcs1_cgmii_tx_txd ; 
wire nic_switch_mux_0_hlp_cgmii2_txclk_ena ; 
wire nic_switch_mux_0_hlp_cgmii2_rxclk_ena ; 
wire [15:0] nic_switch_mux_0_hlp_cgmii2_rxc ; 
wire [127:0] nic_switch_mux_0_hlp_cgmii2_rxd ; 
wire [15:0] pcs_mac_pipeline_top_wrap_mquad0_pcs2_cgmii_tx_txc ; 
wire [127:0] pcs_mac_pipeline_top_wrap_mquad0_pcs2_cgmii_tx_txd ; 
wire nic_switch_mux_0_hlp_cgmii3_txclk_ena ; 
wire nic_switch_mux_0_hlp_cgmii3_rxclk_ena ; 
wire [15:0] nic_switch_mux_0_hlp_cgmii3_rxc ; 
wire [127:0] nic_switch_mux_0_hlp_cgmii3_rxd ; 
wire [15:0] pcs_mac_pipeline_top_wrap_mquad0_pcs3_cgmii_tx_txc ; 
wire [127:0] pcs_mac_pipeline_top_wrap_mquad0_pcs3_cgmii_tx_txd ; 
wire [7:0] pcs_mac_pipeline_top_wrap_nss_mac0_xlgmii_rx_rxc ; 
wire [63:0] pcs_mac_pipeline_top_wrap_nss_mac0_xlgmii_rx_rxd ; 
wire [7:0] nic_switch_mux_0_hlp_xlgmii0_txc_nss ; 
wire [63:0] nic_switch_mux_0_hlp_xlgmii0_txd_nss ; 
wire [7:0] pcs_mac_pipeline_top_wrap_nss_mac1_xlgmii_rx_rxc ; 
wire [63:0] pcs_mac_pipeline_top_wrap_nss_mac1_xlgmii_rx_rxd ; 
wire [7:0] nic_switch_mux_0_hlp_xlgmii1_txc_nss ; 
wire [63:0] nic_switch_mux_0_hlp_xlgmii1_txd_nss ; 
wire [7:0] pcs_mac_pipeline_top_wrap_nss_mac2_xlgmii_rx_rxc ; 
wire [63:0] pcs_mac_pipeline_top_wrap_nss_mac2_xlgmii_rx_rxd ; 
wire [7:0] nic_switch_mux_0_hlp_xlgmii2_txc_nss ; 
wire [63:0] nic_switch_mux_0_hlp_xlgmii2_txd_nss ; 
wire [7:0] pcs_mac_pipeline_top_wrap_nss_mac3_xlgmii_rx_rxc ; 
wire [63:0] pcs_mac_pipeline_top_wrap_nss_mac3_xlgmii_rx_rxd ; 
wire [7:0] nic_switch_mux_0_hlp_xlgmii3_txc_nss ; 
wire [63:0] nic_switch_mux_0_hlp_xlgmii3_txd_nss ; 
wire [15:0] pcs_mac_pipeline_top_wrap_nss_mac0_cgmii_rx_rxc ; 
wire [127:0] pcs_mac_pipeline_top_wrap_nss_mac0_cgmii_rx_rxd ; 
wire [15:0] nic_switch_mux_0_hlp_cgmii0_txc_nss ; 
wire [127:0] nic_switch_mux_0_hlp_cgmii0_txd_nss ; 
wire [15:0] pcs_mac_pipeline_top_wrap_nss_mac1_cgmii_rx_rxc ; 
wire [127:0] pcs_mac_pipeline_top_wrap_nss_mac1_cgmii_rx_rxd ; 
wire [15:0] nic_switch_mux_0_hlp_cgmii1_txc_nss ; 
wire [127:0] nic_switch_mux_0_hlp_cgmii1_txd_nss ; 
wire [15:0] pcs_mac_pipeline_top_wrap_nss_mac2_cgmii_rx_rxc ; 
wire [127:0] pcs_mac_pipeline_top_wrap_nss_mac2_cgmii_rx_rxd ; 
wire [15:0] nic_switch_mux_0_hlp_cgmii2_txc_nss ; 
wire [127:0] nic_switch_mux_0_hlp_cgmii2_txd_nss ; 
wire [15:0] pcs_mac_pipeline_top_wrap_nss_mac3_cgmii_rx_rxc ; 
wire [127:0] pcs_mac_pipeline_top_wrap_nss_mac3_cgmii_rx_rxd ; 
wire [15:0] nic_switch_mux_0_hlp_cgmii3_txc_nss ; 
wire [127:0] nic_switch_mux_0_hlp_cgmii3_txd_nss ; 
wire nic_switch_mux_1_hlp_xlgmii0_txclk_ena ; 
wire nic_switch_mux_1_hlp_xlgmii0_rxclk_ena ; 
wire [7:0] nic_switch_mux_1_hlp_xlgmii0_rxc ; 
wire [63:0] nic_switch_mux_1_hlp_xlgmii0_rxd ; 
wire nic_switch_mux_1_hlp_xlgmii0_rxt0_next ; 
wire [7:0] pcs_mac_pipeline_top_wrap_mquad1_pcs0_xlgmii_tx_txc ; 
wire [63:0] pcs_mac_pipeline_top_wrap_mquad1_pcs0_xlgmii_tx_txd ; 
wire [1:0] quadpcs100_1_pcs_tsu_rx_sd_0 ; 
wire [1:0] quadpcs100_1_mii_rx_tsu_mux0_0 ; 
wire [1:0] quadpcs100_1_mii_tx_tsu_0 ; 
wire nic_switch_mux_1_hlp_xlgmii1_txclk_ena ; 
wire nic_switch_mux_1_hlp_xlgmii1_rxclk_ena ; 
wire [7:0] nic_switch_mux_1_hlp_xlgmii1_rxc ; 
wire [63:0] nic_switch_mux_1_hlp_xlgmii1_rxd ; 
wire nic_switch_mux_1_hlp_xlgmii1_rxt0_next ; 
wire [7:0] pcs_mac_pipeline_top_wrap_mquad1_pcs1_xlgmii_tx_txc ; 
wire [63:0] pcs_mac_pipeline_top_wrap_mquad1_pcs1_xlgmii_tx_txd ; 
wire [1:0] quadpcs100_1_pcs_tsu_rx_sd_1 ; 
wire [1:0] quadpcs100_1_mii_rx_tsu_mux1_0 ; 
wire [1:0] quadpcs100_1_mii_tx_tsu_1 ; 
wire nic_switch_mux_1_hlp_xlgmii2_txclk_ena ; 
wire nic_switch_mux_1_hlp_xlgmii2_rxclk_ena ; 
wire [7:0] nic_switch_mux_1_hlp_xlgmii2_rxc ; 
wire [63:0] nic_switch_mux_1_hlp_xlgmii2_rxd ; 
wire nic_switch_mux_1_hlp_xlgmii2_rxt0_next ; 
wire [7:0] pcs_mac_pipeline_top_wrap_mquad1_pcs2_xlgmii_tx_txc ; 
wire [63:0] pcs_mac_pipeline_top_wrap_mquad1_pcs2_xlgmii_tx_txd ; 
wire [1:0] quadpcs100_1_pcs_tsu_rx_sd_2 ; 
wire [1:0] quadpcs100_1_mii_rx_tsu_mux2_0 ; 
wire [1:0] quadpcs100_1_mii_tx_tsu_2 ; 
wire nic_switch_mux_1_hlp_xlgmii3_txclk_ena ; 
wire nic_switch_mux_1_hlp_xlgmii3_rxclk_ena ; 
wire [7:0] nic_switch_mux_1_hlp_xlgmii3_rxc ; 
wire [63:0] nic_switch_mux_1_hlp_xlgmii3_rxd ; 
wire nic_switch_mux_1_hlp_xlgmii3_rxt0_next ; 
wire [7:0] pcs_mac_pipeline_top_wrap_mquad1_pcs3_xlgmii_tx_txc ; 
wire [63:0] pcs_mac_pipeline_top_wrap_mquad1_pcs3_xlgmii_tx_txd ; 
wire [1:0] quadpcs100_1_pcs_tsu_rx_sd_3 ; 
wire [1:0] quadpcs100_1_mii_rx_tsu_mux3_0 ; 
wire [1:0] quadpcs100_1_mii_tx_tsu_3 ; 
wire nic_switch_mux_1_hlp_cgmii0_txclk_ena ; 
wire nic_switch_mux_1_hlp_cgmii0_rxclk_ena ; 
wire [15:0] nic_switch_mux_1_hlp_cgmii0_rxc ; 
wire [127:0] nic_switch_mux_1_hlp_cgmii0_rxd ; 
wire [15:0] pcs_mac_pipeline_top_wrap_mquad1_pcs0_cgmii_tx_txc ; 
wire [127:0] pcs_mac_pipeline_top_wrap_mquad1_pcs0_cgmii_tx_txd ; 
wire nic_switch_mux_1_hlp_cgmii1_txclk_ena ; 
wire nic_switch_mux_1_hlp_cgmii1_rxclk_ena ; 
wire [15:0] nic_switch_mux_1_hlp_cgmii1_rxc ; 
wire [127:0] nic_switch_mux_1_hlp_cgmii1_rxd ; 
wire [15:0] pcs_mac_pipeline_top_wrap_mquad1_pcs1_cgmii_tx_txc ; 
wire [127:0] pcs_mac_pipeline_top_wrap_mquad1_pcs1_cgmii_tx_txd ; 
wire nic_switch_mux_1_hlp_cgmii2_txclk_ena ; 
wire nic_switch_mux_1_hlp_cgmii2_rxclk_ena ; 
wire [15:0] nic_switch_mux_1_hlp_cgmii2_rxc ; 
wire [127:0] nic_switch_mux_1_hlp_cgmii2_rxd ; 
wire [15:0] pcs_mac_pipeline_top_wrap_mquad1_pcs2_cgmii_tx_txc ; 
wire [127:0] pcs_mac_pipeline_top_wrap_mquad1_pcs2_cgmii_tx_txd ; 
wire nic_switch_mux_1_hlp_cgmii3_txclk_ena ; 
wire nic_switch_mux_1_hlp_cgmii3_rxclk_ena ; 
wire [15:0] nic_switch_mux_1_hlp_cgmii3_rxc ; 
wire [127:0] nic_switch_mux_1_hlp_cgmii3_rxd ; 
wire [15:0] pcs_mac_pipeline_top_wrap_mquad1_pcs3_cgmii_tx_txc ; 
wire [127:0] pcs_mac_pipeline_top_wrap_mquad1_pcs3_cgmii_tx_txd ; 
logic [3:0] physs_pcs_mux_200_400_0_tx_ts_val ; 
logic [6:0] physs_pcs_mux_200_400_0_tx_ts_id_0 ; 
logic [6:0] physs_pcs_mux_200_400_0_tx_ts_id_1 ; 
logic [6:0] physs_pcs_mux_200_400_0_tx_ts_id_2 ; 
logic [6:0] physs_pcs_mux_200_400_0_tx_ts_id_3 ; 
logic [71:0] physs_pcs_mux_200_400_0_tx_ts_0 ; 
logic [71:0] physs_pcs_mux_200_400_0_tx_ts_1 ; 
logic [71:0] physs_pcs_mux_200_400_0_tx_ts_2 ; 
logic [71:0] physs_pcs_mux_200_400_0_tx_ts_3 ; 
logic fifo_mux_0_mac100g_0_tx_ts_frm ; 
logic [6:0] fifo_mux_0_mac100g_0_tx_id ; 
logic fifo_mux_0_mac100g_1_tx_ts_frm ; 
logic [6:0] fifo_mux_0_mac100g_1_tx_id ; 
logic fifo_mux_0_mac100g_2_tx_ts_frm ; 
logic [6:0] fifo_mux_0_mac100g_2_tx_id ; 
logic fifo_mux_0_mac100g_3_tx_ts_frm ; 
logic [6:0] fifo_mux_0_mac100g_3_tx_id ; 
logic fifo_mux_1_mac100g_0_tx_ts_frm ; 
logic [6:0] fifo_mux_1_mac100g_0_tx_id ; 
logic fifo_mux_1_mac100g_1_tx_ts_frm ; 
logic [6:0] fifo_mux_1_mac100g_1_tx_id ; 
logic fifo_mux_1_mac100g_2_tx_ts_frm ; 
logic [6:0] fifo_mux_1_mac100g_2_tx_id ; 
logic fifo_mux_1_mac100g_3_tx_ts_frm ; 
logic [6:0] fifo_mux_1_mac100g_3_tx_id ; 
logic [3:0] physs_pcs_mux_200_400_1_tx_ts_val ; 
logic [6:0] physs_pcs_mux_200_400_1_tx_ts_id_0 ; 
logic [6:0] physs_pcs_mux_200_400_1_tx_ts_id_1 ; 
logic [6:0] physs_pcs_mux_200_400_1_tx_ts_id_2 ; 
logic [6:0] physs_pcs_mux_200_400_1_tx_ts_id_3 ; 
logic [71:0] physs_pcs_mux_200_400_1_tx_ts_0 ; 
logic [71:0] physs_pcs_mux_200_400_1_tx_ts_1 ; 
logic [71:0] physs_pcs_mux_200_400_1_tx_ts_2 ; 
logic [71:0] physs_pcs_mux_200_400_1_tx_ts_3 ; 
logic physs_registers_wrapper_0_pcs_mode_config_lane_revsersal_mux_quad_0 ; 
logic [3:0] physs_pcs_mux_0_srds_rdy_out_800G ; 
logic [3:0] physs_pcs_mux_1_srds_rdy_out_800G ; 
logic [3:0] physs_registers_wrapper_0_pcs_xmp_align_done_sync ; 
logic [3:0] physs_registers_wrapper_1_pcs_xmp_align_done_sync ; 
logic [3:0] physs_registers_wrapper_0_pcs_xmp_hi_ber_sync ; 
logic [3:0] physs_registers_wrapper_1_pcs_xmp_hi_ber_sync ; 
logic [19:0] physs_registers_wrapper_0_pcs_xmp_block_lock_sync ; 
logic [19:0] physs_registers_wrapper_1_pcs_xmp_block_lock_sync ; 
logic [127:0] physs_mux_800G_sd0_tx_data_o ; 
logic [127:0] physs_pipeline_reg_800g_misc_0_data_out ; 
logic [127:0] physs_mux_800G_sd1_tx_data_o ; 
logic [127:0] physs_pipeline_reg_800g_misc_1_data_out ; 
logic [127:0] physs_mux_800G_sd2_tx_data_o ; 
logic [127:0] physs_pipeline_reg_800g_misc_2_data_out ; 
logic [127:0] physs_mux_800G_sd3_tx_data_o ; 
logic [127:0] physs_pipeline_reg_800g_misc_3_data_out ; 
logic physs_mux_800G_link_status_out ; 
logic [3:0] physs_mux_800G_pcs_align_done_out ; 
logic [3:0] physs_mux_800G_pcs_hi_ber_out ; 
logic [19:0] physs_mux_800G_pcs_block_lock_out ; 
logic [127:0] physs_mux_800G_sd4_tx_data_o ; 
logic [127:0] physs_pipeline_reg_800g_misc_4_data_out ; 
logic [127:0] physs_mux_800G_sd5_tx_data_o ; 
logic [127:0] physs_pipeline_reg_800g_misc_5_data_out ; 
logic [127:0] physs_mux_800G_sd6_tx_data_o ; 
logic [127:0] physs_pipeline_reg_800g_misc_6_data_out ; 
logic [127:0] physs_mux_800G_sd7_tx_data_o ; 
logic [127:0] physs_pipeline_reg_800g_misc_7_data_out ; 
logic [3:0] physs_mux_800G_pcs_align_done_out_0 ; 
logic [3:0] physs_mux_800G_pcs_hi_ber_out_0 ; 
logic [19:0] physs_mux_800G_pcs_block_lock_out_0 ; 
logic [127:0] physs_pipeline_reg_800g_8_data_out ; 
logic [127:0] physs_pipeline_reg_800g_misc_8_data_out ; 
logic [127:0] physs_pipeline_reg_800g_9_data_out ; 
logic [127:0] physs_pipeline_reg_800g_misc_9_data_out ; 
logic [127:0] physs_pipeline_reg_800g_10_data_out ; 
logic [127:0] physs_pipeline_reg_800g_misc_10_data_out ; 
logic [127:0] physs_pipeline_reg_800g_11_data_out ; 
logic [127:0] physs_pipeline_reg_800g_misc_11_data_out ; 
logic [127:0] physs_pipeline_reg_800g_12_data_out ; 
logic [127:0] physs_pipeline_reg_800g_misc_12_data_out ; 
logic [127:0] physs_pipeline_reg_800g_13_data_out ; 
logic [127:0] physs_pipeline_reg_800g_misc_13_data_out ; 
logic [127:0] physs_pipeline_reg_800g_14_data_out ; 
logic [127:0] physs_pipeline_reg_800g_misc_14_data_out ; 
logic [127:0] physs_pipeline_reg_800g_15_data_out ; 
logic [127:0] physs_pipeline_reg_800g_misc_15_data_out ; 
logic [127:0] physs_pcs_mux_200_400_0_sd0_tx_data_o ; 
logic [127:0] physs_pcs_mux_200_400_0_sd1_tx_data_o ; 
logic [127:0] physs_pcs_mux_200_400_0_sd2_tx_data_o ; 
logic [127:0] physs_pcs_mux_200_400_0_sd3_tx_data_o ; 
logic [127:0] physs_pipeline_reg_4_data_out ; 
logic [127:0] physs_pipeline_reg_5_data_out ; 
logic [127:0] physs_pipeline_reg_6_data_out ; 
logic [127:0] physs_pipeline_reg_7_data_out ; 
logic [127:0] physs_pcs_mux_200_400_1_sd0_tx_data_o ; 
logic [127:0] physs_pcs_mux_200_400_1_sd1_tx_data_o ; 
logic [127:0] physs_pcs_mux_200_400_1_sd2_tx_data_o ; 
logic [127:0] physs_pcs_mux_200_400_1_sd3_tx_data_o ; 
logic [127:0] physs_pipeline_reg_12_data_out ; 
logic [127:0] physs_pipeline_reg_13_data_out ; 
logic [127:0] physs_pipeline_reg_14_data_out ; 
logic [127:0] physs_pipeline_reg_15_data_out ; 
logic [3:0] physs_lane_reversal_mux_0_oflux_srds_rdy_out ; 
logic [3:0] physs_lane_reversal_mux_1_oflux_srds_rdy_out ; 
logic [3:0] physs_pcs_mux_200_400_0_link_status_out ; 
logic [3:0] physs_pcs_mux_200_400_1_link_status_out ; 
logic fifo_mux_0_physs_icq_port_0_link_stat_0 ; 
logic [3:0] fifo_mux_0_physs_mse_port_0_link_speed ; 
logic [1023:0] fifo_mux_0_physs_mse_port_0_rx_data ; 
logic fifo_mux_0_physs_mse_port_0_rx_sop_0 ; 
logic fifo_mux_0_physs_mse_port_0_rx_eop_0 ; 
logic [6:0] fifo_mux_0_physs_mse_port_0_rx_mod ; 
logic fifo_mux_0_physs_mse_port_0_rx_err ; 
logic fifo_mux_0_physs_mse_port_0_rx_ecc_err ; 
logic [38:0] fifo_mux_0_physs_mse_port_0_rx_ts ; 
logic fifo_mux_0_physs_mse_port_0_pfc_mode ; 
logic fifo_mux_0_physs_icq_port_1_link_stat_0 ; 
logic [3:0] fifo_mux_0_physs_mse_port_1_link_speed ; 
logic [255:0] fifo_mux_0_physs_mse_port_1_rx_data ; 
logic fifo_mux_0_physs_mse_port_1_rx_sop_0 ; 
logic fifo_mux_0_physs_mse_port_1_rx_eop_0 ; 
logic [6:0] fifo_mux_0_physs_mse_port_1_rx_mod ; 
logic fifo_mux_0_physs_mse_port_1_rx_err ; 
logic fifo_mux_0_physs_mse_port_1_rx_ecc_err ; 
logic [38:0] fifo_mux_0_physs_mse_port_1_rx_ts ; 
logic [255:0] fifo_top_mux_0_mse_physs_port_1_tx_data ; 
logic fifo_top_mux_0_mse_physs_port_1_ts_capture_vld ; 
logic [6:0] fifo_top_mux_0_mse_physs_port_1_ts_capture_idx ; 
logic [6:0] fifo_top_mux_0_mse_physs_port_1_tx_mod ; 
logic fifo_top_mux_0_mse_physs_port_1_tx_err ; 
logic fifo_top_mux_0_mse_physs_port_1_tx_crc ; 
logic fifo_mux_0_physs_mse_port_1_pfc_mode ; 
logic fifo_mux_0_physs_icq_port_2_link_stat_0 ; 
logic [3:0] fifo_mux_0_physs_mse_port_2_link_speed ; 
logic [511:0] fifo_mux_0_physs_mse_port_2_rx_data ; 
logic fifo_mux_0_physs_mse_port_2_rx_sop_0 ; 
logic fifo_mux_0_physs_mse_port_2_rx_eop_0 ; 
logic [6:0] fifo_mux_0_physs_mse_port_2_rx_mod ; 
logic fifo_mux_0_physs_mse_port_2_rx_err ; 
logic fifo_mux_0_physs_mse_port_2_rx_ecc_err ; 
logic [38:0] fifo_mux_0_physs_mse_port_2_rx_ts ; 
logic [511:0] fifo_top_mux_0_mse_physs_port_2_tx_data ; 
logic fifo_top_mux_0_mse_physs_port_2_ts_capture_vld ; 
logic [6:0] fifo_top_mux_0_mse_physs_port_2_ts_capture_idx ; 
logic [6:0] fifo_top_mux_0_mse_physs_port_2_tx_mod ; 
logic fifo_top_mux_0_mse_physs_port_2_tx_err ; 
logic fifo_top_mux_0_mse_physs_port_2_tx_crc ; 
logic fifo_mux_0_physs_mse_port_2_pfc_mode ; 
logic fifo_mux_0_physs_icq_port_3_link_stat_0 ; 
logic [3:0] fifo_mux_0_physs_mse_port_3_link_speed ; 
logic [255:0] fifo_mux_0_physs_mse_port_3_rx_data ; 
logic fifo_mux_0_physs_mse_port_3_rx_sop_0 ; 
logic fifo_mux_0_physs_mse_port_3_rx_eop_0 ; 
logic [6:0] fifo_mux_0_physs_mse_port_3_rx_mod ; 
logic fifo_mux_0_physs_mse_port_3_rx_err ; 
logic fifo_mux_0_physs_mse_port_3_rx_ecc_err ; 
logic [38:0] fifo_mux_0_physs_mse_port_3_rx_ts ; 
logic [255:0] fifo_top_mux_0_mse_physs_port_3_tx_data ; 
logic fifo_top_mux_0_mse_physs_port_3_ts_capture_vld ; 
logic [6:0] fifo_top_mux_0_mse_physs_port_3_ts_capture_idx ; 
logic [6:0] fifo_top_mux_0_mse_physs_port_3_tx_mod ; 
logic fifo_top_mux_0_mse_physs_port_3_tx_err ; 
logic fifo_top_mux_0_mse_physs_port_3_tx_crc ; 
logic fifo_mux_0_physs_mse_port_3_pfc_mode ; 
logic fifo_mux_1_physs_icq_port_0_link_stat_0 ; 
logic [3:0] fifo_mux_1_physs_mse_port_0_link_speed ; 
logic [1023:0] fifo_mux_1_physs_mse_port_0_rx_data ; 
logic fifo_mux_1_physs_mse_port_0_rx_sop_0 ; 
logic fifo_mux_1_physs_mse_port_0_rx_eop_0 ; 
logic [6:0] fifo_mux_1_physs_mse_port_0_rx_mod ; 
logic fifo_mux_1_physs_mse_port_0_rx_err ; 
logic fifo_mux_1_physs_mse_port_0_rx_ecc_err ; 
logic [38:0] fifo_mux_1_physs_mse_port_0_rx_ts ; 
logic [1023:0] fifo_top_mux_0_mse_physs_port_4_tx_data ; 
logic fifo_top_mux_0_mse_physs_port_4_ts_capture_vld ; 
logic [6:0] fifo_top_mux_0_mse_physs_port_4_ts_capture_idx ; 
logic [6:0] fifo_top_mux_0_mse_physs_port_4_tx_mod ; 
logic fifo_top_mux_0_mse_physs_port_4_tx_err ; 
logic fifo_top_mux_0_mse_physs_port_4_tx_crc ; 
logic fifo_mux_1_physs_mse_port_0_pfc_mode ; 
logic fifo_mux_1_physs_icq_port_1_link_stat_0 ; 
logic [3:0] fifo_mux_1_physs_mse_port_1_link_speed ; 
logic [255:0] fifo_mux_1_physs_mse_port_1_rx_data ; 
logic fifo_mux_1_physs_mse_port_1_rx_sop_0 ; 
logic fifo_mux_1_physs_mse_port_1_rx_eop_0 ; 
logic [6:0] fifo_mux_1_physs_mse_port_1_rx_mod ; 
logic fifo_mux_1_physs_mse_port_1_rx_err ; 
logic fifo_mux_1_physs_mse_port_1_rx_ecc_err ; 
logic [38:0] fifo_mux_1_physs_mse_port_1_rx_ts ; 
logic [255:0] fifo_top_mux_0_mse_physs_port_5_tx_data ; 
logic fifo_top_mux_0_mse_physs_port_5_ts_capture_vld ; 
logic [6:0] fifo_top_mux_0_mse_physs_port_5_ts_capture_idx ; 
logic [6:0] fifo_top_mux_0_mse_physs_port_5_tx_mod ; 
logic fifo_top_mux_0_mse_physs_port_5_tx_err ; 
logic fifo_top_mux_0_mse_physs_port_5_tx_crc ; 
logic fifo_mux_1_physs_mse_port_1_pfc_mode ; 
logic fifo_mux_1_physs_icq_port_2_link_stat_0 ; 
logic [3:0] fifo_mux_1_physs_mse_port_2_link_speed ; 
logic [511:0] fifo_mux_1_physs_mse_port_2_rx_data ; 
logic fifo_mux_1_physs_mse_port_2_rx_sop_0 ; 
logic fifo_mux_1_physs_mse_port_2_rx_eop_0 ; 
logic [6:0] fifo_mux_1_physs_mse_port_2_rx_mod ; 
logic fifo_mux_1_physs_mse_port_2_rx_err ; 
logic fifo_mux_1_physs_mse_port_2_rx_ecc_err ; 
logic [38:0] fifo_mux_1_physs_mse_port_2_rx_ts ; 
logic [511:0] fifo_top_mux_0_mse_physs_port_6_tx_data ; 
logic fifo_top_mux_0_mse_physs_port_6_ts_capture_vld ; 
logic [6:0] fifo_top_mux_0_mse_physs_port_6_ts_capture_idx ; 
logic [6:0] fifo_top_mux_0_mse_physs_port_6_tx_mod ; 
logic fifo_top_mux_0_mse_physs_port_6_tx_err ; 
logic fifo_top_mux_0_mse_physs_port_6_tx_crc ; 
logic fifo_mux_1_physs_mse_port_2_pfc_mode ; 
logic fifo_mux_1_physs_icq_port_3_link_stat_0 ; 
logic [3:0] fifo_mux_1_physs_mse_port_3_link_speed ; 
logic [255:0] fifo_mux_1_physs_mse_port_3_rx_data ; 
logic fifo_mux_1_physs_mse_port_3_rx_sop_0 ; 
logic fifo_mux_1_physs_mse_port_3_rx_eop_0 ; 
logic [6:0] fifo_mux_1_physs_mse_port_3_rx_mod ; 
logic fifo_mux_1_physs_mse_port_3_rx_err ; 
logic fifo_mux_1_physs_mse_port_3_rx_ecc_err ; 
logic [38:0] fifo_mux_1_physs_mse_port_3_rx_ts ; 
logic [255:0] fifo_top_mux_0_mse_physs_port_7_tx_data ; 
logic fifo_top_mux_0_mse_physs_port_7_ts_capture_vld ; 
logic [6:0] fifo_top_mux_0_mse_physs_port_7_ts_capture_idx ; 
logic [6:0] fifo_top_mux_0_mse_physs_port_7_tx_mod ; 
logic fifo_top_mux_0_mse_physs_port_7_tx_err ; 
logic fifo_top_mux_0_mse_physs_port_7_tx_crc ; 
logic fifo_mux_1_physs_mse_port_3_pfc_mode ; 
logic [3:0] physs_link_speed_decoder_0_link_speed_out ; 
logic [3:0] physs_link_speed_decoder_1_link_speed_out ; 
logic [3:0] physs_link_speed_decoder_2_link_speed_out ; 
logic [3:0] physs_link_speed_decoder_3_link_speed_out ; 
logic [3:0] physs_link_speed_decoder_4_link_speed_out ; 
logic [3:0] physs_link_speed_decoder_5_link_speed_out ; 
logic [3:0] physs_link_speed_decoder_6_link_speed_out ; 
logic [3:0] physs_link_speed_decoder_7_link_speed_out ; 
logic mac100_0_ff_rx_dval_0 ; 
logic [255:0] mac100_0_ff_rx_data ; 
logic mac100_0_ff_rx_sop ; 
logic mac100_0_ff_rx_eop_0 ; 
logic [4:0] mac100_0_ff_rx_mod_0 ; 
logic mac100_0_ff_rx_err_0 ; 
logic fifo_mux_0_mac100g_0_rx_rdy ; 
logic [6:0] mac100_0_ff_rx_ts_0 ; 
logic [31:0] mac100_0_ff_rx_ts_1 ; 
logic fifo_mux_0_mac100g_0_tx_wren ; 
logic [255:0] fifo_mux_0_mac100g_0_tx_data ; 
logic fifo_mux_0_mac100g_0_tx_sop ; 
logic fifo_mux_0_mac100g_0_tx_eop ; 
logic [4:0] fifo_mux_0_mac100g_0_tx_mod ; 
logic fifo_mux_0_mac100g_0_tx_err ; 
logic fifo_mux_0_mac100g_0_tx_crc ; 
logic mac100_0_ff_tx_rdy_0 ; 
logic mac100_0_pfc_mode ; 
logic mac100_1_ff_rx_dval_0 ; 
logic [255:0] mac100_1_ff_rx_data ; 
logic mac100_1_ff_rx_sop ; 
logic mac100_1_ff_rx_eop_0 ; 
logic [4:0] mac100_1_ff_rx_mod_0 ; 
logic mac100_1_ff_rx_err_0 ; 
logic fifo_mux_0_mac100g_1_rx_rdy ; 
logic [6:0] mac100_1_ff_rx_ts_0 ; 
logic [31:0] mac100_1_ff_rx_ts_1 ; 
logic fifo_mux_0_mac100g_1_tx_wren ; 
logic [255:0] fifo_mux_0_mac100g_1_tx_data ; 
logic fifo_mux_0_mac100g_1_tx_sop ; 
logic fifo_mux_0_mac100g_1_tx_eop ; 
logic [4:0] fifo_mux_0_mac100g_1_tx_mod ; 
logic fifo_mux_0_mac100g_1_tx_err ; 
logic fifo_mux_0_mac100g_1_tx_crc ; 
logic mac100_1_ff_tx_rdy_0 ; 
logic mac100_1_pfc_mode ; 
logic mac100_2_ff_rx_dval_0 ; 
logic [255:0] mac100_2_ff_rx_data ; 
logic mac100_2_ff_rx_sop ; 
logic mac100_2_ff_rx_eop_0 ; 
logic [4:0] mac100_2_ff_rx_mod_0 ; 
logic mac100_2_ff_rx_err_0 ; 
logic fifo_mux_0_mac100g_2_rx_rdy ; 
logic [6:0] mac100_2_ff_rx_ts_0 ; 
logic [31:0] mac100_2_ff_rx_ts_1 ; 
logic fifo_mux_0_mac100g_2_tx_wren ; 
logic [255:0] fifo_mux_0_mac100g_2_tx_data ; 
logic fifo_mux_0_mac100g_2_tx_sop ; 
logic fifo_mux_0_mac100g_2_tx_eop ; 
logic [4:0] fifo_mux_0_mac100g_2_tx_mod ; 
logic fifo_mux_0_mac100g_2_tx_err ; 
logic fifo_mux_0_mac100g_2_tx_crc ; 
logic mac100_2_ff_tx_rdy_0 ; 
logic mac100_2_pfc_mode ; 
logic mac100_3_ff_rx_dval_0 ; 
logic [255:0] mac100_3_ff_rx_data ; 
logic mac100_3_ff_rx_sop ; 
logic mac100_3_ff_rx_eop_0 ; 
logic [4:0] mac100_3_ff_rx_mod_0 ; 
logic mac100_3_ff_rx_err_0 ; 
logic fifo_mux_0_mac100g_3_rx_rdy ; 
logic [6:0] mac100_3_ff_rx_ts_0 ; 
logic [31:0] mac100_3_ff_rx_ts_1 ; 
logic fifo_mux_0_mac100g_3_tx_wren ; 
logic [255:0] fifo_mux_0_mac100g_3_tx_data ; 
logic fifo_mux_0_mac100g_3_tx_sop ; 
logic fifo_mux_0_mac100g_3_tx_eop ; 
logic [4:0] fifo_mux_0_mac100g_3_tx_mod ; 
logic fifo_mux_0_mac100g_3_tx_err ; 
logic fifo_mux_0_mac100g_3_tx_crc ; 
logic mac100_3_ff_tx_rdy_0 ; 
logic mac100_3_pfc_mode ; 
logic mac100_4_ff_rx_dval_0 ; 
logic [255:0] mac100_4_ff_rx_data ; 
logic mac100_4_ff_rx_sop ; 
logic mac100_4_ff_rx_eop_0 ; 
logic [4:0] mac100_4_ff_rx_mod_0 ; 
logic mac100_4_ff_rx_err_0 ; 
logic fifo_mux_1_mac100g_0_rx_rdy ; 
logic [6:0] mac100_4_ff_rx_ts_0 ; 
logic [31:0] mac100_4_ff_rx_ts_1 ; 
logic fifo_mux_1_mac100g_0_tx_wren ; 
logic [255:0] fifo_mux_1_mac100g_0_tx_data ; 
logic fifo_mux_1_mac100g_0_tx_sop ; 
logic fifo_mux_1_mac100g_0_tx_eop ; 
logic [4:0] fifo_mux_1_mac100g_0_tx_mod ; 
logic fifo_mux_1_mac100g_0_tx_err ; 
logic fifo_mux_1_mac100g_0_tx_crc ; 
logic mac100_4_ff_tx_rdy_0 ; 
logic mac100_4_pfc_mode ; 
logic mac100_5_ff_rx_dval_0 ; 
logic [255:0] mac100_5_ff_rx_data ; 
logic mac100_5_ff_rx_sop ; 
logic mac100_5_ff_rx_eop_0 ; 
logic [4:0] mac100_5_ff_rx_mod_0 ; 
logic mac100_5_ff_rx_err_0 ; 
logic fifo_mux_1_mac100g_1_rx_rdy ; 
logic [6:0] mac100_5_ff_rx_ts_0 ; 
logic [31:0] mac100_5_ff_rx_ts_1 ; 
logic fifo_mux_1_mac100g_1_tx_wren ; 
logic [255:0] fifo_mux_1_mac100g_1_tx_data ; 
logic fifo_mux_1_mac100g_1_tx_sop ; 
logic fifo_mux_1_mac100g_1_tx_eop ; 
logic [4:0] fifo_mux_1_mac100g_1_tx_mod ; 
logic fifo_mux_1_mac100g_1_tx_err ; 
logic fifo_mux_1_mac100g_1_tx_crc ; 
logic mac100_5_ff_tx_rdy_0 ; 
logic mac100_5_pfc_mode ; 
logic mac100_6_ff_rx_dval_0 ; 
logic [255:0] mac100_6_ff_rx_data ; 
logic mac100_6_ff_rx_sop ; 
logic mac100_6_ff_rx_eop_0 ; 
logic [4:0] mac100_6_ff_rx_mod_0 ; 
logic mac100_6_ff_rx_err_0 ; 
logic fifo_mux_1_mac100g_2_rx_rdy ; 
logic [6:0] mac100_6_ff_rx_ts_0 ; 
logic [31:0] mac100_6_ff_rx_ts_1 ; 
logic fifo_mux_1_mac100g_2_tx_wren ; 
logic [255:0] fifo_mux_1_mac100g_2_tx_data ; 
logic fifo_mux_1_mac100g_2_tx_sop ; 
logic fifo_mux_1_mac100g_2_tx_eop ; 
logic [4:0] fifo_mux_1_mac100g_2_tx_mod ; 
logic fifo_mux_1_mac100g_2_tx_err ; 
logic fifo_mux_1_mac100g_2_tx_crc ; 
logic mac100_6_ff_tx_rdy_0 ; 
logic mac100_6_pfc_mode ; 
logic mac100_7_ff_rx_dval_0 ; 
logic [255:0] mac100_7_ff_rx_data ; 
logic mac100_7_ff_rx_sop ; 
logic mac100_7_ff_rx_eop_0 ; 
logic [4:0] mac100_7_ff_rx_mod_0 ; 
logic mac100_7_ff_rx_err_0 ; 
logic fifo_mux_1_mac100g_3_rx_rdy ; 
logic [6:0] mac100_7_ff_rx_ts_0 ; 
logic [31:0] mac100_7_ff_rx_ts_1 ; 
logic fifo_mux_1_mac100g_3_tx_wren ; 
logic [255:0] fifo_mux_1_mac100g_3_tx_data ; 
logic fifo_mux_1_mac100g_3_tx_sop ; 
logic fifo_mux_1_mac100g_3_tx_eop ; 
logic [4:0] fifo_mux_1_mac100g_3_tx_mod ; 
logic fifo_mux_1_mac100g_3_tx_err ; 
logic fifo_mux_1_mac100g_3_tx_crc ; 
logic mac100_7_ff_tx_rdy_0 ; 
logic mac100_7_pfc_mode ; 
logic mac400_0_ff_rx_err_0 ; 
logic mac200_0_ff_rx_err_0 ; 
logic mac400_1_ff_rx_err_0 ; 
logic mac200_1_ff_rx_err_0 ; 
logic [31:0] nic400_physs_0_awaddr_master_quad0_out ; 
logic [7:0] nic400_physs_0_awlen_master_quad0 ; 
logic [2:0] nic400_physs_0_awsize_master_quad0 ; 
logic [1:0] nic400_physs_0_awburst_master_quad0 ; 
logic nic400_physs_0_awlock_master_quad0 ; 
logic [3:0] nic400_physs_0_awcache_master_quad0 ; 
logic [2:0] nic400_physs_0_awprot_master_quad0 ; 
logic nic400_physs_0_awvalid_master_quad0 ; 
logic nic400_quad_0_awready_slave_quad_if0 ; 
logic [31:0] nic400_physs_0_wdata_master_quad0 ; 
logic [3:0] nic400_physs_0_wstrb_master_quad0 ; 
logic nic400_physs_0_wlast_master_quad0 ; 
logic nic400_physs_0_wvalid_master_quad0 ; 
logic nic400_quad_0_wready_slave_quad_if0 ; 
logic [1:0] nic400_quad_0_bresp_slave_quad_if0 ; 
logic nic400_quad_0_bvalid_slave_quad_if0 ; 
logic nic400_physs_0_bready_master_quad0 ; 
logic [31:0] nic400_physs_0_araddr_master_quad0_out ; 
logic [7:0] nic400_physs_0_arlen_master_quad0 ; 
logic [2:0] nic400_physs_0_arsize_master_quad0 ; 
logic [1:0] nic400_physs_0_arburst_master_quad0 ; 
logic nic400_physs_0_arlock_master_quad0 ; 
logic [3:0] nic400_physs_0_arcache_master_quad0 ; 
logic [2:0] nic400_physs_0_arprot_master_quad0 ; 
logic nic400_physs_0_arvalid_master_quad0 ; 
logic nic400_quad_0_arready_slave_quad_if0 ; 
logic [31:0] nic400_quad_0_rdata_slave_quad_if0 ; 
logic [1:0] nic400_quad_0_rresp_slave_quad_if0 ; 
logic nic400_quad_0_rlast_slave_quad_if0 ; 
logic nic400_quad_0_rvalid_slave_quad_if0 ; 
logic nic400_physs_0_rready_master_quad0 ; 
logic [5:0] nic400_physs_0_awid_master_quad0 ; 
logic [5:0] nic400_physs_0_arid_master_quad0 ; 
logic [5:0] nic400_quad_0_rid_slave_quad_if0 ; 
logic [5:0] nic400_quad_0_bid_slave_quad_if0 ; 
logic [31:0] nic400_physs_0_awaddr_master_quad1_out ; 
logic [7:0] nic400_physs_0_awlen_master_quad1 ; 
logic [2:0] nic400_physs_0_awsize_master_quad1 ; 
logic [1:0] nic400_physs_0_awburst_master_quad1 ; 
logic nic400_physs_0_awlock_master_quad1 ; 
logic [3:0] nic400_physs_0_awcache_master_quad1 ; 
logic [2:0] nic400_physs_0_awprot_master_quad1 ; 
logic nic400_physs_0_awvalid_master_quad1 ; 
logic nic400_quad_1_awready_slave_quad_if0 ; 
logic [31:0] nic400_physs_0_wdata_master_quad1 ; 
logic [3:0] nic400_physs_0_wstrb_master_quad1 ; 
logic nic400_physs_0_wlast_master_quad1 ; 
logic nic400_physs_0_wvalid_master_quad1 ; 
logic nic400_quad_1_wready_slave_quad_if0 ; 
logic [1:0] nic400_quad_1_bresp_slave_quad_if0 ; 
logic nic400_quad_1_bvalid_slave_quad_if0 ; 
logic nic400_physs_0_bready_master_quad1 ; 
logic [31:0] nic400_physs_0_araddr_master_quad1_out ; 
logic [7:0] nic400_physs_0_arlen_master_quad1 ; 
logic [2:0] nic400_physs_0_arsize_master_quad1 ; 
logic [1:0] nic400_physs_0_arburst_master_quad1 ; 
logic nic400_physs_0_arlock_master_quad1 ; 
logic [3:0] nic400_physs_0_arcache_master_quad1 ; 
logic [2:0] nic400_physs_0_arprot_master_quad1 ; 
logic nic400_physs_0_arvalid_master_quad1 ; 
logic nic400_quad_1_arready_slave_quad_if0 ; 
logic [31:0] nic400_quad_1_rdata_slave_quad_if0 ; 
logic [1:0] nic400_quad_1_rresp_slave_quad_if0 ; 
logic nic400_quad_1_rlast_slave_quad_if0 ; 
logic nic400_quad_1_rvalid_slave_quad_if0 ; 
logic nic400_physs_0_rready_master_quad1 ; 
logic [5:0] nic400_physs_0_awid_master_quad1 ; 
logic [5:0] nic400_physs_0_arid_master_quad1 ; 
logic [5:0] nic400_quad_1_rid_slave_quad_if0 ; 
logic [5:0] nic400_quad_1_bid_slave_quad_if0 ; 
logic nic400_physs_0_hselx_mac800 ; 
logic [17:0] nic400_physs_0_haddr_mac800_out ; 
logic [1:0] nic400_physs_0_htrans_mac800 ; 
logic nic400_physs_0_hwrite_mac800 ; 
logic [2:0] nic400_physs_0_hsize_mac800 ; 
logic [31:0] nic400_physs_0_hwdata_mac800 ; 
logic nic400_physs_0_hready_mac800 ; 
logic [31:0] mac800_ahb_bridge_0_hrdata ; 
wire mac800_ahb_bridge_0_hresp ; 
wire mac800_ahb_bridge_0_hreadyout ; 
logic [2:0] nic400_physs_0_hburst_mac800 ; 
logic nic400_physs_0_hselx_macstats800 ; 
logic [17:0] nic400_physs_0_haddr_macstats800_out ; 
logic [1:0] nic400_physs_0_htrans_macstats800 ; 
logic nic400_physs_0_hwrite_macstats800 ; 
logic [2:0] nic400_physs_0_hsize_macstats800 ; 
logic [31:0] nic400_physs_0_hwdata_macstats800 ; 
logic nic400_physs_0_hready_macstats800 ; 
logic [31:0] macstats800_ahb_bridge_0_hrdata ; 
wire macstats800_ahb_bridge_0_hresp ; 
wire macstats800_ahb_bridge_0_hreadyout ; 
logic [2:0] nic400_physs_0_hburst_macstats800 ; 
logic nic400_physs_0_hselx_pcs800 ; 
logic [17:0] nic400_physs_0_haddr_pcs800_out ; 
logic [1:0] nic400_physs_0_htrans_pcs800 ; 
logic nic400_physs_0_hwrite_pcs800 ; 
logic [2:0] nic400_physs_0_hsize_pcs800 ; 
logic [31:0] nic400_physs_0_hwdata_pcs800 ; 
logic nic400_physs_0_hready_pcs800 ; 
logic [31:0] pcs800_ahb_bridge_0_hrdata ; 
wire pcs800_ahb_bridge_0_hresp ; 
wire pcs800_ahb_bridge_0_hreadyout ; 
logic [2:0] nic400_physs_0_hburst_pcs800 ; 
logic nic400_physs_0_hselx_tsu800 ; 
logic [17:0] nic400_physs_0_haddr_tsu800_out ; 
logic [1:0] nic400_physs_0_htrans_tsu800 ; 
logic nic400_physs_0_hwrite_tsu800 ; 
logic [2:0] nic400_physs_0_hsize_tsu800 ; 
logic [31:0] nic400_physs_0_hwdata_tsu800 ; 
logic nic400_physs_0_hready_tsu800 ; 
logic [31:0] tsu800_ahb_bridge_0_hrdata ; 
wire tsu800_ahb_bridge_0_hresp ; 
wire tsu800_ahb_bridge_0_hreadyout ; 
logic [2:0] nic400_physs_0_hburst_tsu800 ; 
logic nic400_physs_0_hreadyout_slave_quad0 ; 
logic nic400_physs_0_hresp_slave_quad0 ; 
logic [31:0] nic400_physs_0_hrdata_slave_quad0 ; 
logic nic400_quad_0_hselx_master_physs ; 
logic [31:0] nic400_quad_0_haddr_master_physs_out ; 
logic nic400_quad_0_hwrite_master_physs ; 
logic [1:0] nic400_quad_0_htrans_master_physs ; 
logic [2:0] nic400_quad_0_hsize_master_physs ; 
logic [2:0] nic400_quad_0_hburst_master_physs ; 
logic [3:0] nic400_quad_0_hprot_master_physs ; 
logic nic400_quad_0_hready_master_physs ; 
logic [31:0] nic400_quad_0_hwdata_master_physs ; 
logic nic400_physs_0_hreadyout_slave_quad1 ; 
logic nic400_physs_0_hresp_slave_quad1 ; 
logic [31:0] nic400_physs_0_hrdata_slave_quad1 ; 
logic nic400_quad_1_hselx_master_physs ; 
logic [31:0] nic400_quad_1_haddr_master_physs_out ; 
logic nic400_quad_1_hwrite_master_physs ; 
logic [1:0] nic400_quad_1_htrans_master_physs ; 
logic [2:0] nic400_quad_1_hsize_master_physs ; 
logic [2:0] nic400_quad_1_hburst_master_physs ; 
logic [3:0] nic400_quad_1_hprot_master_physs ; 
logic nic400_quad_1_hready_master_physs ; 
logic [31:0] nic400_quad_1_hwdata_master_physs ; 
logic socviewpin_32to1digimux_00_outmux ; 
logic socviewpin_32to1digimux_01_outmux ; 
logic socviewpin_32to1digimux_10_outmux ; 
logic socviewpin_32to1digimux_11_outmux ; 
logic [1:0] physs_registers_wrapper_0_viewpin_mux_select_2 ; 
logic physs_registers_wrapper_0_viewpin_mux_en_2 ; 
logic [1:0] physs_registers_wrapper_1_viewpin_mux_select_2 ; 
logic physs_registers_wrapper_1_viewpin_mux_en_2 ; 
logic quad_interrupts_0_ts_int_imc_o ; 
logic quad_interrupts_1_ts_int_imc_o ; 
logic parmisc_physs0_BSCAN_PIPE_OUT_1_scan_in ; 
logic parmisc_physs0_BSCAN_PIPE_OUT_2_scan_in ; 
logic parmquad0_BSCAN_PIPE_OUT_1_scan_out ; 
logic parmisc_physs0_BSCAN_PIPE_OUT_1_force_disable ; 
logic parmisc_physs0_BSCAN_PIPE_OUT_1_select_jtag_input ; 
logic parmisc_physs0_BSCAN_PIPE_OUT_1_select_jtag_output ; 
logic parmisc_physs0_BSCAN_PIPE_OUT_1_ac_init_clock0 ; 
logic parmisc_physs0_BSCAN_PIPE_OUT_1_ac_init_clock1 ; 
logic parmisc_physs0_BSCAN_PIPE_OUT_1_ac_signal ; 
logic parmisc_physs0_BSCAN_PIPE_OUT_1_ac_mode_en ; 
logic parmisc_physs0_BSCAN_PIPE_OUT_1_intel_update_clk ; 
logic parmisc_physs0_BSCAN_PIPE_OUT_1_intel_clamp_en ; 
logic parmisc_physs0_BSCAN_PIPE_OUT_1_intel_bscan_mode ; 
logic parmisc_physs0_BSCAN_PIPE_OUT_1_select ; 
logic parmisc_physs0_BSCAN_PIPE_OUT_1_bscan_clock ; 
logic parmisc_physs0_BSCAN_PIPE_OUT_1_capture_en ; 
logic parmisc_physs0_BSCAN_PIPE_OUT_1_shift_en ; 
logic parmisc_physs0_BSCAN_PIPE_OUT_1_update_en ; 
logic parmquad1_BSCAN_PIPE_OUT_2_scan_out ; 
logic parmisc_physs0_BSCAN_PIPE_OUT_2_force_disable ; 
logic parmisc_physs0_BSCAN_PIPE_OUT_2_select_jtag_input ; 
logic parmisc_physs0_BSCAN_PIPE_OUT_2_select_jtag_output ; 
logic parmisc_physs0_BSCAN_PIPE_OUT_2_ac_init_clock0 ; 
logic parmisc_physs0_BSCAN_PIPE_OUT_2_ac_init_clock1 ; 
logic parmisc_physs0_BSCAN_PIPE_OUT_2_ac_signal ; 
logic parmisc_physs0_BSCAN_PIPE_OUT_2_ac_mode_en ; 
logic parmisc_physs0_BSCAN_PIPE_OUT_2_intel_update_clk ; 
logic parmisc_physs0_BSCAN_PIPE_OUT_2_intel_clamp_en ; 
logic parmisc_physs0_BSCAN_PIPE_OUT_2_intel_bscan_mode ; 
logic parmisc_physs0_BSCAN_PIPE_OUT_2_select ; 
logic parmisc_physs0_BSCAN_PIPE_OUT_2_bscan_clock ; 
logic parmisc_physs0_BSCAN_PIPE_OUT_2_capture_en ; 
logic parmisc_physs0_BSCAN_PIPE_OUT_2_shift_en ; 
logic parmisc_physs0_BSCAN_PIPE_OUT_2_update_en ; 
logic parmisc_physs0_BSCAN_PIPE_OUT_1_bscan_to_intel_d6actestsig_b ; 
logic [31:0] parmquad0_SSN_END_0_bus_data_out ; 
logic [31:0] parmisc_physs0_SSN_END_towards_mquad0_bus_data_out ; 
logic [31:0] par400g0_END_0_bus_data_out ; 
logic [31:0] parmquad1_SSN_END_0_bus_data_out ; 
logic [31:0] parmisc_physs0_chain_rpt_mquad0_mquad1_end_bus_data_out ; 
logic [31:0] par400g1_END_0_bus_data_out ; 
logic [31:0] parmisc_physs0_END_2_bus_data_out ; 
logic [31:0] parmisc_physs0_chain_rpt_par800g_end_bus_data_out ; 
logic [31:0] par400g0_chain_rpt_mquad0_misc0_end_bus_data_out ; 
logic [31:0] par400g1_chain_rpt_mquad1_misc0_end_bus_data_out ; 
logic [31:0] parmisc_physs0_chain_rpt_misc1_physs0_end_bus_data_out ; 
logic [31:0] par800g_SSN_END_0_bus_data_out ; 
logic [31:0] parmisc_physs0_END_0_bus_data_out ; 
logic [31:0] par400g0_SSN_END_0_bus_data_out ; 
logic [31:0] par400g1_SSN_END_0_bus_data_out ; 
logic par400g0_JT_OUT_mbist_par400g0_ijtag_so ; 
logic par400g0_JT_OUT_misc_par400g0_ijtag_so ; 
logic par400g0_JT_OUT_scan_par400g0_ijtag_so ; 
logic parmisc_physs0_JT_OUT_mbist_400g0_ijtag_to_reset ; 
logic parmisc_physs0_JT_OUT_mbist_400g0_ijtag_to_se ; 
logic parmisc_physs0_JT_OUT_mbist_400g0_ijtag_to_ce ; 
logic parmisc_physs0_JT_OUT_mbist_400g0_ijtag_to_ue ; 
logic parmisc_physs0_JT_OUT_mbist_400g0_ijtag_to_sel ; 
logic parmisc_physs0_JT_OUT_misc_400g0_ijtag_to_reset ; 
logic parmisc_physs0_JT_OUT_misc_400g0_ijtag_to_se ; 
logic parmisc_physs0_JT_OUT_misc_400g0_ijtag_to_ce ; 
logic parmisc_physs0_JT_OUT_misc_400g0_ijtag_to_ue ; 
logic parmisc_physs0_JT_OUT_misc_400g0_ijtag_to_sel ; 
logic parmisc_physs0_JT_OUT_scan_400g0_to_tck ; 
logic parmisc_physs0_JT_OUT_scan_400g0_ijtag_to_reset ; 
logic parmisc_physs0_JT_OUT_scan_400g0_ijtag_to_se ; 
logic parmisc_physs0_JT_OUT_scan_400g0_ijtag_to_ce ; 
logic parmisc_physs0_JT_OUT_scan_400g0_ijtag_to_ue ; 
logic parmisc_physs0_JT_OUT_scan_400g0_ijtag_to_sel ; 
logic par400g1_JT_OUT_mbist_par400g1_ijtag_so ; 
logic par400g1_JT_OUT_misc_par400g1_ijtag_so ; 
logic par400g1_JT_OUT_scan_par400g1_ijtag_so ; 
logic parmisc_physs0_JT_OUT_mbist_400g1_ijtag_to_reset ; 
logic parmisc_physs0_JT_OUT_mbist_400g1_ijtag_to_se ; 
logic parmisc_physs0_JT_OUT_mbist_400g1_ijtag_to_ce ; 
logic parmisc_physs0_JT_OUT_mbist_400g1_ijtag_to_ue ; 
logic parmisc_physs0_JT_OUT_mbist_400g1_ijtag_to_sel ; 
logic parmisc_physs0_JT_OUT_misc_400g1_ijtag_to_reset ; 
logic parmisc_physs0_JT_OUT_misc_400g1_ijtag_to_se ; 
logic parmisc_physs0_JT_OUT_misc_400g1_ijtag_to_ce ; 
logic parmisc_physs0_JT_OUT_misc_400g1_ijtag_to_ue ; 
logic parmisc_physs0_JT_OUT_misc_400g1_ijtag_to_sel ; 
logic parmisc_physs0_JT_OUT_scan_400g1_to_tck ; 
logic parmisc_physs0_JT_OUT_scan_400g1_ijtag_to_reset ; 
logic parmisc_physs0_JT_OUT_scan_400g1_ijtag_to_se ; 
logic parmisc_physs0_JT_OUT_scan_400g1_ijtag_to_ce ; 
logic parmisc_physs0_JT_OUT_scan_400g1_ijtag_to_ue ; 
logic parmisc_physs0_JT_OUT_scan_400g1_ijtag_to_sel ; 
logic par800g_JT_OUT_mbist_par800g_ijtag_so ; 
logic par800g_JT_OUT_misc_par800g_ijtag_so ; 
logic par800g_JT_OUT_scan_par800g_ijtag_so ; 
logic parmisc_physs0_JT_OUT_mbist_800g_ijtag_to_reset ; 
logic parmisc_physs0_JT_OUT_mbist_800g_ijtag_to_se ; 
logic parmisc_physs0_JT_OUT_mbist_800g_ijtag_to_ce ; 
logic parmisc_physs0_JT_OUT_mbist_800g_ijtag_to_ue ; 
logic parmisc_physs0_JT_OUT_mbist_800g_ijtag_to_sel ; 
logic parmisc_physs0_JT_OUT_misc_800g_ijtag_to_reset ; 
logic parmisc_physs0_JT_OUT_misc_800g_ijtag_to_se ; 
logic parmisc_physs0_JT_OUT_misc_800g_ijtag_to_ce ; 
logic parmisc_physs0_JT_OUT_misc_800g_ijtag_to_ue ; 
logic parmisc_physs0_JT_OUT_misc_800g_ijtag_to_sel ; 
logic parmisc_physs0_JT_OUT_scan_800g_to_tck ; 
logic parmisc_physs0_JT_OUT_scan_800g_ijtag_to_reset ; 
logic parmisc_physs0_JT_OUT_scan_800g_ijtag_to_se ; 
logic parmisc_physs0_JT_OUT_scan_800g_ijtag_to_ce ; 
logic parmisc_physs0_JT_OUT_scan_800g_ijtag_to_ue ; 
logic parmisc_physs0_JT_OUT_scan_800g_ijtag_to_sel ; 
logic parmisc_physs0_JT_OUT_mbist_400g0_ijtag_to_si ; 
logic parmisc_physs0_JT_OUT_mbist_400g1_ijtag_to_si ; 
logic parmisc_physs0_JT_OUT_mbist_800g_ijtag_to_si ; 
logic parmisc_physs0_JT_OUT_misc_400g0_ijtag_to_si ; 
logic parmisc_physs0_JT_OUT_misc_400g1_ijtag_to_si ; 
logic parmisc_physs0_JT_OUT_misc_800g_ijtag_to_si ; 
logic parmisc_physs0_JT_OUT_scan_400g0_ijtag_to_si ; 
logic parmisc_physs0_JT_OUT_scan_400g1_ijtag_to_si ; 
logic parmisc_physs0_JT_OUT_scan_800g_ijtag_to_si ; 
logic parmquad0_NW_IN_tdo ; 
logic parmquad0_NW_IN_tdo_en ; 
logic parmisc_physs0_NW_OUT_parmquad0_ijtag_to_reset ; 
logic parmisc_physs0_NW_OUT_parmquad0_ijtag_to_ce ; 
logic parmisc_physs0_NW_OUT_parmquad0_ijtag_to_se ; 
logic parmisc_physs0_NW_OUT_parmquad0_ijtag_to_ue ; 
logic parmisc_physs0_NW_OUT_parmquad0_ijtag_to_sel ; 
logic parmisc_physs0_NW_OUT_parmquad0_ijtag_to_si ; 
logic parmquad0_NW_IN_ijtag_so ; 
logic parmquad0_NW_IN_tap_sel_out ; 
logic parmquad1_NW_IN_tdo ; 
logic parmquad1_NW_IN_tdo_en ; 
logic parmisc_physs0_NW_OUT_parmquad1_ijtag_to_reset ; 
logic parmisc_physs0_NW_OUT_parmquad1_ijtag_to_ce ; 
logic parmisc_physs0_NW_OUT_parmquad1_ijtag_to_se ; 
logic parmisc_physs0_NW_OUT_parmquad1_ijtag_to_ue ; 
logic parmisc_physs0_NW_OUT_parmquad1_ijtag_to_sel ; 
logic parmisc_physs0_NW_OUT_parmquad1_ijtag_to_si ; 
logic parmquad1_NW_IN_ijtag_so ; 
logic parmquad1_NW_IN_tap_sel_out ; 
// EDIT_NET END

// EDIT_INSTANCE BEGIN
parmisc_physs0 parmisc_physs0 (
    .mbp_repeater_odi_parmisc_physs0_3_ubp_out(mbp_repeater_odi_parmisc_physs0_3_ubp_out), 
    .mbp_repeater_odi_parmisc_physs0_6_ubp_out(mbp_repeater_odi_parmisc_physs0_6_ubp_out), 
    .mbp_repeater_odi_parmisc_physs0_5_ubp_out(mbp_repeater_odi_parmisc_physs0_5_ubp_out), 
    .mbp_repeater_sfe_parmisc_physs0_2_ubp_out(mbp_repeater_sfe_parmisc_physs0_2_ubp_out), 
    .dfxagg_security_policy(dfxagg_security_policy), 
    .dfxagg_policy_update(dfxagg_policy_update), 
    .dfxagg_early_boot_debug_exit(dfxagg_early_boot_debug_exit), 
    .dfxagg_debug_capabilities_enabling(dfxagg_debug_capabilities_enabling), 
    .dfxagg_debug_capabilities_enabling_valid(dfxagg_debug_capabilities_enabling_valid), 
    .fdfx_powergood(fdfx_powergood), 
    .dfxsecure_plugin_dpt2_parmisc_physs0_adfx_tap_grpA_enable(dfxsecure_plugin_dpt2_parmisc_physs0_adfx_tap_grpA_enable), 
    .dfxsecure_plugin_dpt2_parmisc_physs0_adfx_tap_grpB_enable(dfxsecure_plugin_dpt2_parmisc_physs0_adfx_tap_grpB_enable), 
    .dfxsecure_plugin_dpt2_parmisc_physs0_adfx_tap_grpC_enable(dfxsecure_plugin_dpt2_parmisc_physs0_adfx_tap_grpC_enable), 
    .dfxsecure_plugin_dpt2_parmisc_physs0_adfx_tap_grpD_enable(dfxsecure_plugin_dpt2_parmisc_physs0_adfx_tap_grpD_enable), 
    .dfxsecure_plugin_dpt2_parmisc_physs0_adfx_tap_grpE_enable(dfxsecure_plugin_dpt2_parmisc_physs0_adfx_tap_grpE_enable), 
    .dfxsecure_plugin_dpt2_parmisc_physs0_adfx_tap_grpG_enable(dfxsecure_plugin_dpt2_parmisc_physs0_adfx_tap_grpG_enable), 
    .dfxsecure_plugin_dpt2_parmisc_physs0_adfx_tap_grpH_enable(dfxsecure_plugin_dpt2_parmisc_physs0_adfx_tap_grpH_enable), 
    .dfxsecure_plugin_dpt2_parmisc_physs0_adfx_tap_grpF_enable(dfxsecure_plugin_dpt2_parmisc_physs0_adfx_tap_grpF_enable), 
    .dfxsecure_plugin_dpt2_parmisc_physs0_adfx_tap_grpZ_enable(dfxsecure_plugin_dpt2_parmisc_physs0_adfx_tap_grpZ_enable), 
    .quadpcs100_0_pcs_link_status(quadpcs100_0_pcs_link_status), 
    .quadpcs100_1_pcs_link_status(quadpcs100_1_pcs_link_status), 
    .quadpcs100_2_pcs_link_status(quadpcs100_2_pcs_link_status), 
    .quadpcs100_3_pcs_link_status(quadpcs100_3_pcs_link_status), 
    .physs_mac_port_glue_0_during_pkt_tx_mse_0(physs_mac_port_glue_0_during_pkt_tx_mse_0), 
    .physs_mac_port_glue_0_during_pkt_rx_mtip_0(physs_mac_port_glue_0_during_pkt_rx_mtip_0), 
    .physs_mac_port_glue_0_rx_eop_vaild_0(physs_mac_port_glue_0_rx_eop_vaild_0), 
    .physs_mac_port_glue_0_tx_eop_vaild_0(physs_mac_port_glue_0_tx_eop_vaild_0), 
    .physs_core_rst_fsm_0_mse_if_iso_en(physs_core_rst_fsm_0_mse_if_iso_en), 
    .physs_core_rst_fsm_0_force_if_mse_rx_en_port_num(physs_core_rst_fsm_0_force_if_mse_rx_en_port_num), 
    .physs_core_rst_fsm_0_force_if_mse_tx_en_port_num(physs_core_rst_fsm_0_force_if_mse_tx_en_port_num), 
    .physs_core_rst_fsm_0_during_pkt_tx_mse_ff_clr(physs_core_rst_fsm_0_during_pkt_tx_mse_ff_clr), 
    .physs_reset_prep_req(physs_reset_prep_req), 
    .fifo_top_mux_0_physs_scon_reset_prep_ack(fifo_top_mux_0_physs_scon_reset_prep_ack), 
    .physs_mac_port_glue_0_mse_ff_rx_dval(physs_mac_port_glue_0_mse_ff_rx_dval), 
    .physs_mac_port_glue_0_mtip_ff_tx_rdy(physs_mac_port_glue_0_mtip_ff_tx_rdy), 
    .fifo_top_mux_0_mse_physs_port_0_rx_rdy(fifo_top_mux_0_mse_physs_port_0_rx_rdy), 
    .fifo_top_mux_0_mse_physs_port_0_tx_wren(fifo_top_mux_0_mse_physs_port_0_tx_wren), 
    .fifo_top_mux_0_mse_physs_port_0_tx_sop(fifo_top_mux_0_mse_physs_port_0_tx_sop), 
    .fifo_top_mux_0_mse_physs_port_0_tx_eop(fifo_top_mux_0_mse_physs_port_0_tx_eop), 
    .physs_mac_port_glue_1_mse_ff_rx_dval(physs_mac_port_glue_1_mse_ff_rx_dval), 
    .physs_mac_port_glue_1_mtip_ff_tx_rdy(physs_mac_port_glue_1_mtip_ff_tx_rdy), 
    .fifo_top_mux_0_mse_physs_port_1_rx_rdy(fifo_top_mux_0_mse_physs_port_1_rx_rdy), 
    .fifo_top_mux_0_mse_physs_port_1_tx_wren(fifo_top_mux_0_mse_physs_port_1_tx_wren), 
    .fifo_top_mux_0_mse_physs_port_1_tx_sop(fifo_top_mux_0_mse_physs_port_1_tx_sop), 
    .fifo_top_mux_0_mse_physs_port_1_tx_eop(fifo_top_mux_0_mse_physs_port_1_tx_eop), 
    .physs_mac_port_glue_2_mse_ff_rx_dval(physs_mac_port_glue_2_mse_ff_rx_dval), 
    .physs_mac_port_glue_2_mtip_ff_tx_rdy(physs_mac_port_glue_2_mtip_ff_tx_rdy), 
    .fifo_top_mux_0_mse_physs_port_2_rx_rdy(fifo_top_mux_0_mse_physs_port_2_rx_rdy), 
    .fifo_top_mux_0_mse_physs_port_2_tx_wren(fifo_top_mux_0_mse_physs_port_2_tx_wren), 
    .fifo_top_mux_0_mse_physs_port_2_tx_sop(fifo_top_mux_0_mse_physs_port_2_tx_sop), 
    .fifo_top_mux_0_mse_physs_port_2_tx_eop(fifo_top_mux_0_mse_physs_port_2_tx_eop), 
    .physs_mac_port_glue_3_mse_ff_rx_dval(physs_mac_port_glue_3_mse_ff_rx_dval), 
    .physs_mac_port_glue_3_mtip_ff_tx_rdy(physs_mac_port_glue_3_mtip_ff_tx_rdy), 
    .fifo_top_mux_0_mse_physs_port_3_rx_rdy(fifo_top_mux_0_mse_physs_port_3_rx_rdy), 
    .fifo_top_mux_0_mse_physs_port_3_tx_wren(fifo_top_mux_0_mse_physs_port_3_tx_wren), 
    .fifo_top_mux_0_mse_physs_port_3_tx_sop(fifo_top_mux_0_mse_physs_port_3_tx_sop), 
    .fifo_top_mux_0_mse_physs_port_3_tx_eop(fifo_top_mux_0_mse_physs_port_3_tx_eop), 
    .physs_mac_port_glue_4_mse_ff_rx_dval(physs_mac_port_glue_4_mse_ff_rx_dval), 
    .physs_mac_port_glue_4_mtip_ff_tx_rdy(physs_mac_port_glue_4_mtip_ff_tx_rdy), 
    .fifo_top_mux_0_mse_physs_port_4_rx_rdy(fifo_top_mux_0_mse_physs_port_4_rx_rdy), 
    .fifo_top_mux_0_mse_physs_port_4_tx_wren(fifo_top_mux_0_mse_physs_port_4_tx_wren), 
    .fifo_top_mux_0_mse_physs_port_4_tx_sop(fifo_top_mux_0_mse_physs_port_4_tx_sop), 
    .fifo_top_mux_0_mse_physs_port_4_tx_eop(fifo_top_mux_0_mse_physs_port_4_tx_eop), 
    .physs_mac_port_glue_5_mse_ff_rx_dval(physs_mac_port_glue_5_mse_ff_rx_dval), 
    .physs_mac_port_glue_5_mtip_ff_tx_rdy(physs_mac_port_glue_5_mtip_ff_tx_rdy), 
    .fifo_top_mux_0_mse_physs_port_5_rx_rdy(fifo_top_mux_0_mse_physs_port_5_rx_rdy), 
    .fifo_top_mux_0_mse_physs_port_5_tx_wren(fifo_top_mux_0_mse_physs_port_5_tx_wren), 
    .fifo_top_mux_0_mse_physs_port_5_tx_sop(fifo_top_mux_0_mse_physs_port_5_tx_sop), 
    .fifo_top_mux_0_mse_physs_port_5_tx_eop(fifo_top_mux_0_mse_physs_port_5_tx_eop), 
    .physs_mac_port_glue_6_mse_ff_rx_dval(physs_mac_port_glue_6_mse_ff_rx_dval), 
    .physs_mac_port_glue_6_mtip_ff_tx_rdy(physs_mac_port_glue_6_mtip_ff_tx_rdy), 
    .fifo_top_mux_0_mse_physs_port_6_rx_rdy(fifo_top_mux_0_mse_physs_port_6_rx_rdy), 
    .fifo_top_mux_0_mse_physs_port_6_tx_wren(fifo_top_mux_0_mse_physs_port_6_tx_wren), 
    .fifo_top_mux_0_mse_physs_port_6_tx_sop(fifo_top_mux_0_mse_physs_port_6_tx_sop), 
    .fifo_top_mux_0_mse_physs_port_6_tx_eop(fifo_top_mux_0_mse_physs_port_6_tx_eop), 
    .physs_mac_port_glue_7_mse_ff_rx_dval(physs_mac_port_glue_7_mse_ff_rx_dval), 
    .physs_mac_port_glue_7_mtip_ff_tx_rdy(physs_mac_port_glue_7_mtip_ff_tx_rdy), 
    .fifo_top_mux_0_mse_physs_port_7_rx_rdy(fifo_top_mux_0_mse_physs_port_7_rx_rdy), 
    .fifo_top_mux_0_mse_physs_port_7_tx_wren(fifo_top_mux_0_mse_physs_port_7_tx_wren), 
    .fifo_top_mux_0_mse_physs_port_7_tx_sop(fifo_top_mux_0_mse_physs_port_7_tx_sop), 
    .fifo_top_mux_0_mse_physs_port_7_tx_eop(fifo_top_mux_0_mse_physs_port_7_tx_eop), 
    .physs_mac_port_glue_1_during_pkt_tx_mse_0(physs_mac_port_glue_1_during_pkt_tx_mse_0), 
    .physs_mac_port_glue_1_during_pkt_rx_mtip_0(physs_mac_port_glue_1_during_pkt_rx_mtip_0), 
    .physs_mac_port_glue_1_rx_eop_vaild_0(physs_mac_port_glue_1_rx_eop_vaild_0), 
    .physs_mac_port_glue_1_tx_eop_vaild_0(physs_mac_port_glue_1_tx_eop_vaild_0), 
    .physs_core_rst_fsm_0_force_if_mse_rx_en_port_num_0(physs_core_rst_fsm_0_force_if_mse_rx_en_port_num_0), 
    .physs_core_rst_fsm_0_force_if_mse_tx_en_port_num_0(physs_core_rst_fsm_0_force_if_mse_tx_en_port_num_0), 
    .physs_mac_port_glue_2_during_pkt_tx_mse_0(physs_mac_port_glue_2_during_pkt_tx_mse_0), 
    .physs_mac_port_glue_2_during_pkt_rx_mtip_0(physs_mac_port_glue_2_during_pkt_rx_mtip_0), 
    .physs_mac_port_glue_2_rx_eop_vaild_0(physs_mac_port_glue_2_rx_eop_vaild_0), 
    .physs_mac_port_glue_2_tx_eop_vaild_0(physs_mac_port_glue_2_tx_eop_vaild_0), 
    .physs_core_rst_fsm_0_force_if_mse_rx_en_port_num_1(physs_core_rst_fsm_0_force_if_mse_rx_en_port_num_1), 
    .physs_core_rst_fsm_0_force_if_mse_tx_en_port_num_1(physs_core_rst_fsm_0_force_if_mse_tx_en_port_num_1), 
    .physs_mac_port_glue_3_during_pkt_tx_mse_0(physs_mac_port_glue_3_during_pkt_tx_mse_0), 
    .physs_mac_port_glue_3_during_pkt_rx_mtip_0(physs_mac_port_glue_3_during_pkt_rx_mtip_0), 
    .physs_mac_port_glue_3_rx_eop_vaild_0(physs_mac_port_glue_3_rx_eop_vaild_0), 
    .physs_mac_port_glue_3_tx_eop_vaild_0(physs_mac_port_glue_3_tx_eop_vaild_0), 
    .physs_core_rst_fsm_0_force_if_mse_rx_en_port_num_2(physs_core_rst_fsm_0_force_if_mse_rx_en_port_num_2), 
    .physs_core_rst_fsm_0_force_if_mse_tx_en_port_num_2(physs_core_rst_fsm_0_force_if_mse_tx_en_port_num_2), 
    .physs_mac_port_glue_4_during_pkt_tx_mse_0(physs_mac_port_glue_4_during_pkt_tx_mse_0), 
    .physs_mac_port_glue_4_during_pkt_rx_mtip_0(physs_mac_port_glue_4_during_pkt_rx_mtip_0), 
    .physs_mac_port_glue_4_rx_eop_vaild_0(physs_mac_port_glue_4_rx_eop_vaild_0), 
    .physs_mac_port_glue_4_tx_eop_vaild_0(physs_mac_port_glue_4_tx_eop_vaild_0), 
    .physs_core_rst_fsm_1_mse_if_iso_en(physs_core_rst_fsm_1_mse_if_iso_en), 
    .physs_core_rst_fsm_1_force_if_mse_rx_en_port_num(physs_core_rst_fsm_1_force_if_mse_rx_en_port_num), 
    .physs_core_rst_fsm_1_force_if_mse_tx_en_port_num(physs_core_rst_fsm_1_force_if_mse_tx_en_port_num), 
    .physs_core_rst_fsm_1_during_pkt_tx_mse_ff_clr(physs_core_rst_fsm_1_during_pkt_tx_mse_ff_clr), 
    .physs_mac_port_glue_5_during_pkt_tx_mse_0(physs_mac_port_glue_5_during_pkt_tx_mse_0), 
    .physs_mac_port_glue_5_during_pkt_rx_mtip_0(physs_mac_port_glue_5_during_pkt_rx_mtip_0), 
    .physs_mac_port_glue_5_rx_eop_vaild_0(physs_mac_port_glue_5_rx_eop_vaild_0), 
    .physs_mac_port_glue_5_tx_eop_vaild_0(physs_mac_port_glue_5_tx_eop_vaild_0), 
    .physs_core_rst_fsm_1_force_if_mse_rx_en_port_num_0(physs_core_rst_fsm_1_force_if_mse_rx_en_port_num_0), 
    .physs_core_rst_fsm_1_force_if_mse_tx_en_port_num_0(physs_core_rst_fsm_1_force_if_mse_tx_en_port_num_0), 
    .physs_mac_port_glue_6_during_pkt_tx_mse_0(physs_mac_port_glue_6_during_pkt_tx_mse_0), 
    .physs_mac_port_glue_6_during_pkt_rx_mtip_0(physs_mac_port_glue_6_during_pkt_rx_mtip_0), 
    .physs_mac_port_glue_6_rx_eop_vaild_0(physs_mac_port_glue_6_rx_eop_vaild_0), 
    .physs_mac_port_glue_6_tx_eop_vaild_0(physs_mac_port_glue_6_tx_eop_vaild_0), 
    .physs_core_rst_fsm_1_force_if_mse_rx_en_port_num_1(physs_core_rst_fsm_1_force_if_mse_rx_en_port_num_1), 
    .physs_core_rst_fsm_1_force_if_mse_tx_en_port_num_1(physs_core_rst_fsm_1_force_if_mse_tx_en_port_num_1), 
    .physs_mac_port_glue_7_during_pkt_tx_mse_0(physs_mac_port_glue_7_during_pkt_tx_mse_0), 
    .physs_mac_port_glue_7_during_pkt_rx_mtip_0(physs_mac_port_glue_7_during_pkt_rx_mtip_0), 
    .physs_mac_port_glue_7_rx_eop_vaild_0(physs_mac_port_glue_7_rx_eop_vaild_0), 
    .physs_mac_port_glue_7_tx_eop_vaild_0(physs_mac_port_glue_7_tx_eop_vaild_0), 
    .physs_core_rst_fsm_1_force_if_mse_rx_en_port_num_2(physs_core_rst_fsm_1_force_if_mse_rx_en_port_num_2), 
    .physs_core_rst_fsm_1_force_if_mse_tx_en_port_num_2(physs_core_rst_fsm_1_force_if_mse_tx_en_port_num_2), 
    .physs_registers_wrapper_0_syncE_main_rst(physs_registers_wrapper_0_syncE_main_rst), 
    .physs_registers_wrapper_0_syncE_link_up_md(physs_registers_wrapper_0_syncE_link_up_md), 
    .physs_registers_wrapper_0_syncE_link_dn_md(physs_registers_wrapper_0_syncE_link_dn_md), 
    .physs_registers_wrapper_0_syncE_link_enable(physs_registers_wrapper_0_syncE_link_enable), 
    .physs_registers_wrapper_0_syncE_refclk0_div_rst(physs_registers_wrapper_0_syncE_refclk0_div_rst), 
    .physs_registers_wrapper_0_syncE_refclk0_sel(physs_registers_wrapper_0_syncE_refclk0_sel), 
    .physs_registers_wrapper_0_syncE_refclk0_div_m1(physs_registers_wrapper_0_syncE_refclk0_div_m1), 
    .physs_registers_wrapper_0_syncE_refclk0_div_load(physs_registers_wrapper_0_syncE_refclk0_div_load), 
    .physs_registers_wrapper_0_syncE_refclk1_div_rst(physs_registers_wrapper_0_syncE_refclk1_div_rst), 
    .physs_registers_wrapper_0_syncE_refclk1_sel(physs_registers_wrapper_0_syncE_refclk1_sel), 
    .physs_registers_wrapper_0_syncE_refclk1_div_m1(physs_registers_wrapper_0_syncE_refclk1_div_m1), 
    .physs_registers_wrapper_0_syncE_refclk1_div_load(physs_registers_wrapper_0_syncE_refclk1_div_load), 
    .physs_registers_wrapper_1_syncE_main_rst(physs_registers_wrapper_1_syncE_main_rst), 
    .physs_registers_wrapper_1_syncE_link_up_md(physs_registers_wrapper_1_syncE_link_up_md), 
    .physs_registers_wrapper_1_syncE_link_dn_md(physs_registers_wrapper_1_syncE_link_dn_md), 
    .physs_registers_wrapper_1_syncE_link_enable(physs_registers_wrapper_1_syncE_link_enable), 
    .physs_registers_wrapper_1_syncE_refclk0_div_rst(physs_registers_wrapper_1_syncE_refclk0_div_rst), 
    .physs_registers_wrapper_1_syncE_refclk0_sel(physs_registers_wrapper_1_syncE_refclk0_sel), 
    .physs_registers_wrapper_1_syncE_refclk0_div_m1(physs_registers_wrapper_1_syncE_refclk0_div_m1), 
    .physs_registers_wrapper_1_syncE_refclk0_div_load(physs_registers_wrapper_1_syncE_refclk0_div_load), 
    .physs_registers_wrapper_1_syncE_refclk1_div_rst(physs_registers_wrapper_1_syncE_refclk1_div_rst), 
    .physs_registers_wrapper_1_syncE_refclk1_sel(physs_registers_wrapper_1_syncE_refclk1_sel), 
    .physs_registers_wrapper_1_syncE_refclk1_div_m1(physs_registers_wrapper_1_syncE_refclk1_div_m1), 
    .physs_registers_wrapper_1_syncE_refclk1_div_load(physs_registers_wrapper_1_syncE_refclk1_div_load), 
    .physs_registers_wrapper_0_pcs_mode_config_syncE_mux_sel(physs_registers_wrapper_0_pcs_mode_config_syncE_mux_sel), 
    .physs_registers_wrapper_1_pcs_mode_config_syncE_mux_sel(physs_registers_wrapper_1_pcs_mode_config_syncE_mux_sel), 
    .physs_registers_wrapper_0_pcs_mode_config_syncE_mux_sel_0(physs_registers_wrapper_0_pcs_mode_config_syncE_mux_sel_0), 
    .physs_registers_wrapper_1_pcs_mode_config_syncE_mux_sel_0(physs_registers_wrapper_1_pcs_mode_config_syncE_mux_sel_0), 
    .ack_from_fabric_0(ack_from_fabric_0), 
    .req_from_fabric_0(req_from_fabric_0), 
    .dfd_rtb_trig_ctf_adapter_0_trig_req_to_fabric(dfd_rtb_trig_ctf_adapter_0_trig_req_to_fabric), 
    .dfd_rtb_trig_ctf_adapter_0_ack_to_fabric(dfd_rtb_trig_ctf_adapter_0_ack_to_fabric), 
    .ack_from_fabric_1(ack_from_fabric_1), 
    .req_from_fabric_1(req_from_fabric_1), 
    .dfd_rtb_trig_ctf_adapter_1_trig_req_to_fabric(dfd_rtb_trig_ctf_adapter_1_trig_req_to_fabric), 
    .dfd_rtb_trig_ctf_adapter_1_ack_to_fabric(dfd_rtb_trig_ctf_adapter_1_ack_to_fabric), 
    .physs_bbl_100G_0_disable(physs_bbl_100G_0_disable), 
    .physs_bbl_100G_1_disable(physs_bbl_100G_1_disable), 
    .physs_bbl_100G_2_disable(physs_bbl_100G_2_disable), 
    .physs_bbl_100G_3_disable(physs_bbl_100G_3_disable), 
    .physs_intf0_clk_adop_parmisc_physs0_clkout(physs_intf0_clk_adop_parmisc_physs0_clkout), 
    .soc_per_clk_adop_parmisc_physs0_clkout_0(soc_per_clk_adop_parmisc_physs0_clkout_0), 
    .physs_func_clk_adop_parmisc_physs0_clkout_0(physs_func_clk_adop_parmisc_physs0_clkout_0), 
    .physs_intf0_clk(physs_intf0_clk), 
    .physs_funcx2_clk(physs_funcx2_clk), 
    .soc_per_clk(soc_per_clk), 
    .tsu_clk(tsu_clk), 
    .o_ck_pma0_rx_postdiv_l0_adop_parmquad0_clkout(o_ck_pma0_rx_postdiv_l0_adop_parmquad0_clkout), 
    .o_ck_pma1_rx_postdiv_l0_adop_parmquad0_clkout(o_ck_pma1_rx_postdiv_l0_adop_parmquad0_clkout), 
    .o_ck_pma2_rx_postdiv_l0_adop_parmquad0_clkout(o_ck_pma2_rx_postdiv_l0_adop_parmquad0_clkout), 
    .o_ck_pma3_rx_postdiv_l0_adop_parmquad0_clkout(o_ck_pma3_rx_postdiv_l0_adop_parmquad0_clkout), 
    .o_ck_pma0_rx_postdiv_l0_adop_parmquad1_clkout(o_ck_pma0_rx_postdiv_l0_adop_parmquad1_clkout), 
    .o_ck_pma1_rx_postdiv_l0_adop_parmquad1_clkout(o_ck_pma1_rx_postdiv_l0_adop_parmquad1_clkout), 
    .o_ck_pma2_rx_postdiv_l0_adop_parmquad1_clkout(o_ck_pma2_rx_postdiv_l0_adop_parmquad1_clkout), 
    .o_ck_pma3_rx_postdiv_l0_adop_parmquad1_clkout(o_ck_pma3_rx_postdiv_l0_adop_parmquad1_clkout), 
    .o_ck_pma0_rx_postdiv_l0_adop_parpquad0_clkout(o_ck_pma0_rx_postdiv_l0_adop_parpquad0_clkout), 
    .o_ck_pma1_rx_postdiv_l0_adop_parpquad0_clkout(o_ck_pma1_rx_postdiv_l0_adop_parpquad0_clkout), 
    .o_ck_pma2_rx_postdiv_l0_adop_parpquad0_clkout(o_ck_pma2_rx_postdiv_l0_adop_parpquad0_clkout), 
    .o_ck_pma3_rx_postdiv_l0_adop_parpquad0_clkout(o_ck_pma3_rx_postdiv_l0_adop_parpquad0_clkout), 
    .o_ck_pma0_rx_postdiv_l0_adop_parpquad1_clkout(o_ck_pma0_rx_postdiv_l0_adop_parpquad1_clkout), 
    .o_ck_pma1_rx_postdiv_l0_adop_parpquad1_clkout(o_ck_pma1_rx_postdiv_l0_adop_parpquad1_clkout), 
    .o_ck_pma2_rx_postdiv_l0_adop_parpquad1_clkout(o_ck_pma2_rx_postdiv_l0_adop_parpquad1_clkout), 
    .o_ck_pma3_rx_postdiv_l0_adop_parpquad1_clkout(o_ck_pma3_rx_postdiv_l0_adop_parpquad1_clkout), 
    .fscan_ref_clk(fscan_ref_clk), 
    .fscan_ref_clk_adop_parmisc_physs0_clkout(fscan_ref_clk_adop_parmisc_physs0_clkout), 
    .nss_cosq_clk0(nss_cosq_clk0), 
    .nss_cosq_clk1(nss_cosq_clk1), 
    .cosq_func_clk0_adop_parmisc_physs0_clkout_0(cosq_func_clk0_adop_parmisc_physs0_clkout_0), 
    .cosq_func_clk1_adop_parmisc_physs0_clkout_0(cosq_func_clk1_adop_parmisc_physs0_clkout_0), 
    .clk_1588_freq(clk_1588_freq), 
    .physs_funcx2_clk_adop_parmisc_physs0_clkout(physs_funcx2_clk_adop_parmisc_physs0_clkout), 
    .i_ck_ucss_uart_sclk(i_ck_ucss_uart_sclk), 
    .uart_clk_adop_parmisc_physs0_clkout(uart_clk_adop_parmisc_physs0_clkout), 
    .physs_registers_wrapper_0_uart_port_mux_sel_uart_mux_sel(physs_registers_wrapper_0_uart_port_mux_sel_uart_mux_sel), 
    .physs_registers_wrapper_0_uart_port_mux_sel_uart_mux_sel_0(physs_registers_wrapper_0_uart_port_mux_sel_uart_mux_sel_0), 
    .uart_sel_and0_o(uart_sel_and0_o), 
    .uart_sel_and1_o(uart_sel_and1_o), 
    .uart_sel_and2_o(uart_sel_and2_o), 
    .uart_sel_and3_o(uart_sel_and3_o), 
    .fifo_top_mux_0_physs0_icq_port_0_link_stat(fifo_top_mux_0_physs0_icq_port_0_link_stat), 
    .fifo_top_mux_0_physs0_mse_port_0_link_speed(fifo_top_mux_0_physs0_mse_port_0_link_speed), 
    .fifo_top_mux_0_physs0_mse_port_0_rx_dval(fifo_top_mux_0_physs0_mse_port_0_rx_dval), 
    .fifo_top_mux_0_physs0_mse_port_0_rx_data(fifo_top_mux_0_physs0_mse_port_0_rx_data), 
    .fifo_top_mux_0_physs0_mse_port_0_rx_sop(fifo_top_mux_0_physs0_mse_port_0_rx_sop), 
    .fifo_top_mux_0_physs0_mse_port_0_rx_eop(fifo_top_mux_0_physs0_mse_port_0_rx_eop), 
    .fifo_top_mux_0_physs0_mse_port_0_rx_mod(fifo_top_mux_0_physs0_mse_port_0_rx_mod), 
    .fifo_top_mux_0_physs0_mse_port_0_rx_err(fifo_top_mux_0_physs0_mse_port_0_rx_err), 
    .fifo_top_mux_0_physs0_mse_port_0_rx_ecc_err(fifo_top_mux_0_physs0_mse_port_0_rx_ecc_err), 
    .fifo_top_mux_0_physs0_mse_port_0_rx_ts(fifo_top_mux_0_physs0_mse_port_0_rx_ts), 
    .fifo_top_mux_0_physs0_mse_port_0_tx_rdy(fifo_top_mux_0_physs0_mse_port_0_tx_rdy), 
    .fifo_top_mux_0_physs0_mse_port_0_pfc_mode(fifo_top_mux_0_physs0_mse_port_0_pfc_mode), 
    .mse_physs_port_0_rx_rdy(mse_physs_port_0_rx_rdy), 
    .mse_physs_port_0_tx_wren(mse_physs_port_0_tx_wren), 
    .mse_physs_port_0_tx_data(mse_physs_port_0_tx_data), 
    .mse_physs_port_0_tx_sop(mse_physs_port_0_tx_sop), 
    .mse_physs_port_0_tx_eop(mse_physs_port_0_tx_eop), 
    .mse_physs_port_0_tx_mod(mse_physs_port_0_tx_mod), 
    .mse_physs_port_0_tx_err(mse_physs_port_0_tx_err), 
    .mse_physs_port_0_tx_crc(mse_physs_port_0_tx_crc), 
    .mse_physs_port_0_ts_capture_vld(mse_physs_port_0_ts_capture_vld), 
    .mse_physs_port_0_ts_capture_idx(mse_physs_port_0_ts_capture_idx), 
    .fifo_top_mux_0_physs0_icq_port_1_link_stat(fifo_top_mux_0_physs0_icq_port_1_link_stat), 
    .fifo_top_mux_0_physs0_mse_port_1_link_speed(fifo_top_mux_0_physs0_mse_port_1_link_speed), 
    .fifo_top_mux_0_physs0_mse_port_1_rx_dval(fifo_top_mux_0_physs0_mse_port_1_rx_dval), 
    .fifo_top_mux_0_physs0_mse_port_1_rx_data(fifo_top_mux_0_physs0_mse_port_1_rx_data), 
    .fifo_top_mux_0_physs0_mse_port_1_rx_sop(fifo_top_mux_0_physs0_mse_port_1_rx_sop), 
    .fifo_top_mux_0_physs0_mse_port_1_rx_eop(fifo_top_mux_0_physs0_mse_port_1_rx_eop), 
    .fifo_top_mux_0_physs0_mse_port_1_rx_mod(fifo_top_mux_0_physs0_mse_port_1_rx_mod), 
    .fifo_top_mux_0_physs0_mse_port_1_rx_err(fifo_top_mux_0_physs0_mse_port_1_rx_err), 
    .fifo_top_mux_0_physs0_mse_port_1_rx_ecc_err(fifo_top_mux_0_physs0_mse_port_1_rx_ecc_err), 
    .fifo_top_mux_0_physs0_mse_port_1_rx_ts(fifo_top_mux_0_physs0_mse_port_1_rx_ts), 
    .fifo_top_mux_0_physs0_mse_port_1_tx_rdy(fifo_top_mux_0_physs0_mse_port_1_tx_rdy), 
    .fifo_top_mux_0_physs0_mse_port_1_pfc_mode(fifo_top_mux_0_physs0_mse_port_1_pfc_mode), 
    .mse_physs_port_1_rx_rdy(mse_physs_port_1_rx_rdy), 
    .mse_physs_port_1_tx_wren(mse_physs_port_1_tx_wren), 
    .mse_physs_port_1_tx_data(mse_physs_port_1_tx_data), 
    .mse_physs_port_1_tx_sop(mse_physs_port_1_tx_sop), 
    .mse_physs_port_1_tx_eop(mse_physs_port_1_tx_eop), 
    .mse_physs_port_1_tx_mod(mse_physs_port_1_tx_mod), 
    .mse_physs_port_1_tx_err(mse_physs_port_1_tx_err), 
    .mse_physs_port_1_tx_crc(mse_physs_port_1_tx_crc), 
    .mse_physs_port_1_ts_capture_vld(mse_physs_port_1_ts_capture_vld), 
    .mse_physs_port_1_ts_capture_idx(mse_physs_port_1_ts_capture_idx), 
    .fifo_top_mux_0_physs0_icq_port_2_link_stat(fifo_top_mux_0_physs0_icq_port_2_link_stat), 
    .fifo_top_mux_0_physs0_mse_port_2_link_speed(fifo_top_mux_0_physs0_mse_port_2_link_speed), 
    .fifo_top_mux_0_physs0_mse_port_2_rx_dval(fifo_top_mux_0_physs0_mse_port_2_rx_dval), 
    .fifo_top_mux_0_physs0_mse_port_2_rx_data(fifo_top_mux_0_physs0_mse_port_2_rx_data), 
    .fifo_top_mux_0_physs0_mse_port_2_rx_sop(fifo_top_mux_0_physs0_mse_port_2_rx_sop), 
    .fifo_top_mux_0_physs0_mse_port_2_rx_eop(fifo_top_mux_0_physs0_mse_port_2_rx_eop), 
    .fifo_top_mux_0_physs0_mse_port_2_rx_mod(fifo_top_mux_0_physs0_mse_port_2_rx_mod), 
    .fifo_top_mux_0_physs0_mse_port_2_rx_err(fifo_top_mux_0_physs0_mse_port_2_rx_err), 
    .fifo_top_mux_0_physs0_mse_port_2_rx_ecc_err(fifo_top_mux_0_physs0_mse_port_2_rx_ecc_err), 
    .fifo_top_mux_0_physs0_mse_port_2_rx_ts(fifo_top_mux_0_physs0_mse_port_2_rx_ts), 
    .fifo_top_mux_0_physs0_mse_port_2_tx_rdy(fifo_top_mux_0_physs0_mse_port_2_tx_rdy), 
    .fifo_top_mux_0_physs0_mse_port_2_pfc_mode(fifo_top_mux_0_physs0_mse_port_2_pfc_mode), 
    .mse_physs_port_2_rx_rdy(mse_physs_port_2_rx_rdy), 
    .mse_physs_port_2_tx_wren(mse_physs_port_2_tx_wren), 
    .mse_physs_port_2_tx_data(mse_physs_port_2_tx_data), 
    .mse_physs_port_2_tx_sop(mse_physs_port_2_tx_sop), 
    .mse_physs_port_2_tx_eop(mse_physs_port_2_tx_eop), 
    .mse_physs_port_2_tx_mod(mse_physs_port_2_tx_mod), 
    .mse_physs_port_2_tx_err(mse_physs_port_2_tx_err), 
    .mse_physs_port_2_tx_crc(mse_physs_port_2_tx_crc), 
    .mse_physs_port_2_ts_capture_vld(mse_physs_port_2_ts_capture_vld), 
    .mse_physs_port_2_ts_capture_idx(mse_physs_port_2_ts_capture_idx), 
    .fifo_top_mux_0_physs0_icq_port_3_link_stat(fifo_top_mux_0_physs0_icq_port_3_link_stat), 
    .fifo_top_mux_0_physs0_mse_port_3_link_speed(fifo_top_mux_0_physs0_mse_port_3_link_speed), 
    .fifo_top_mux_0_physs0_mse_port_3_rx_dval(fifo_top_mux_0_physs0_mse_port_3_rx_dval), 
    .fifo_top_mux_0_physs0_mse_port_3_rx_data(fifo_top_mux_0_physs0_mse_port_3_rx_data), 
    .fifo_top_mux_0_physs0_mse_port_3_rx_sop(fifo_top_mux_0_physs0_mse_port_3_rx_sop), 
    .fifo_top_mux_0_physs0_mse_port_3_rx_eop(fifo_top_mux_0_physs0_mse_port_3_rx_eop), 
    .fifo_top_mux_0_physs0_mse_port_3_rx_mod(fifo_top_mux_0_physs0_mse_port_3_rx_mod), 
    .fifo_top_mux_0_physs0_mse_port_3_rx_err(fifo_top_mux_0_physs0_mse_port_3_rx_err), 
    .fifo_top_mux_0_physs0_mse_port_3_rx_ecc_err(fifo_top_mux_0_physs0_mse_port_3_rx_ecc_err), 
    .fifo_top_mux_0_physs0_mse_port_3_rx_ts(fifo_top_mux_0_physs0_mse_port_3_rx_ts), 
    .fifo_top_mux_0_physs0_mse_port_3_tx_rdy(fifo_top_mux_0_physs0_mse_port_3_tx_rdy), 
    .fifo_top_mux_0_physs0_mse_port_3_pfc_mode(fifo_top_mux_0_physs0_mse_port_3_pfc_mode), 
    .mse_physs_port_3_rx_rdy(mse_physs_port_3_rx_rdy), 
    .mse_physs_port_3_tx_wren(mse_physs_port_3_tx_wren), 
    .mse_physs_port_3_tx_data(mse_physs_port_3_tx_data), 
    .mse_physs_port_3_tx_sop(mse_physs_port_3_tx_sop), 
    .mse_physs_port_3_tx_eop(mse_physs_port_3_tx_eop), 
    .mse_physs_port_3_tx_mod(mse_physs_port_3_tx_mod), 
    .mse_physs_port_3_tx_err(mse_physs_port_3_tx_err), 
    .mse_physs_port_3_tx_crc(mse_physs_port_3_tx_crc), 
    .mse_physs_port_3_ts_capture_vld(mse_physs_port_3_ts_capture_vld), 
    .mse_physs_port_3_ts_capture_idx(mse_physs_port_3_ts_capture_idx), 
    .fifo_top_mux_0_physs1_icq_port_4_link_stat(fifo_top_mux_0_physs1_icq_port_4_link_stat), 
    .fifo_top_mux_0_physs1_mse_port_4_link_speed(fifo_top_mux_0_physs1_mse_port_4_link_speed), 
    .fifo_top_mux_0_physs1_mse_port_4_rx_dval(fifo_top_mux_0_physs1_mse_port_4_rx_dval), 
    .fifo_top_mux_0_physs1_mse_port_4_rx_data(fifo_top_mux_0_physs1_mse_port_4_rx_data), 
    .fifo_top_mux_0_physs1_mse_port_4_rx_sop(fifo_top_mux_0_physs1_mse_port_4_rx_sop), 
    .fifo_top_mux_0_physs1_mse_port_4_rx_eop(fifo_top_mux_0_physs1_mse_port_4_rx_eop), 
    .fifo_top_mux_0_physs1_mse_port_4_rx_mod(fifo_top_mux_0_physs1_mse_port_4_rx_mod), 
    .fifo_top_mux_0_physs1_mse_port_4_rx_err(fifo_top_mux_0_physs1_mse_port_4_rx_err), 
    .fifo_top_mux_0_physs1_mse_port_4_rx_ecc_err(fifo_top_mux_0_physs1_mse_port_4_rx_ecc_err), 
    .fifo_top_mux_0_physs1_mse_port_4_rx_ts(fifo_top_mux_0_physs1_mse_port_4_rx_ts), 
    .fifo_top_mux_0_physs1_mse_port_4_tx_rdy(fifo_top_mux_0_physs1_mse_port_4_tx_rdy), 
    .fifo_top_mux_0_physs1_mse_port_4_pfc_mode(fifo_top_mux_0_physs1_mse_port_4_pfc_mode), 
    .mse_physs_port_4_rx_rdy(mse_physs_port_4_rx_rdy), 
    .mse_physs_port_4_tx_wren(mse_physs_port_4_tx_wren), 
    .mse_physs_port_4_tx_data(mse_physs_port_4_tx_data), 
    .mse_physs_port_4_tx_sop(mse_physs_port_4_tx_sop), 
    .mse_physs_port_4_tx_eop(mse_physs_port_4_tx_eop), 
    .mse_physs_port_4_tx_mod(mse_physs_port_4_tx_mod), 
    .mse_physs_port_4_tx_err(mse_physs_port_4_tx_err), 
    .mse_physs_port_4_tx_crc(mse_physs_port_4_tx_crc), 
    .mse_physs_port_4_ts_capture_vld(mse_physs_port_4_ts_capture_vld), 
    .mse_physs_port_4_ts_capture_idx(mse_physs_port_4_ts_capture_idx), 
    .fifo_top_mux_0_physs1_icq_port_5_link_stat(fifo_top_mux_0_physs1_icq_port_5_link_stat), 
    .fifo_top_mux_0_physs1_mse_port_5_link_speed(fifo_top_mux_0_physs1_mse_port_5_link_speed), 
    .fifo_top_mux_0_physs1_mse_port_5_rx_dval(fifo_top_mux_0_physs1_mse_port_5_rx_dval), 
    .fifo_top_mux_0_physs1_mse_port_5_rx_data(fifo_top_mux_0_physs1_mse_port_5_rx_data), 
    .fifo_top_mux_0_physs1_mse_port_5_rx_sop(fifo_top_mux_0_physs1_mse_port_5_rx_sop), 
    .fifo_top_mux_0_physs1_mse_port_5_rx_eop(fifo_top_mux_0_physs1_mse_port_5_rx_eop), 
    .fifo_top_mux_0_physs1_mse_port_5_rx_mod(fifo_top_mux_0_physs1_mse_port_5_rx_mod), 
    .fifo_top_mux_0_physs1_mse_port_5_rx_err(fifo_top_mux_0_physs1_mse_port_5_rx_err), 
    .fifo_top_mux_0_physs1_mse_port_5_rx_ecc_err(fifo_top_mux_0_physs1_mse_port_5_rx_ecc_err), 
    .fifo_top_mux_0_physs1_mse_port_5_rx_ts(fifo_top_mux_0_physs1_mse_port_5_rx_ts), 
    .fifo_top_mux_0_physs1_mse_port_5_tx_rdy(fifo_top_mux_0_physs1_mse_port_5_tx_rdy), 
    .fifo_top_mux_0_physs1_mse_port_5_pfc_mode(fifo_top_mux_0_physs1_mse_port_5_pfc_mode), 
    .mse_physs_port_5_rx_rdy(mse_physs_port_5_rx_rdy), 
    .mse_physs_port_5_tx_wren(mse_physs_port_5_tx_wren), 
    .mse_physs_port_5_tx_data(mse_physs_port_5_tx_data), 
    .mse_physs_port_5_tx_sop(mse_physs_port_5_tx_sop), 
    .mse_physs_port_5_tx_eop(mse_physs_port_5_tx_eop), 
    .mse_physs_port_5_tx_mod(mse_physs_port_5_tx_mod), 
    .mse_physs_port_5_tx_err(mse_physs_port_5_tx_err), 
    .mse_physs_port_5_tx_crc(mse_physs_port_5_tx_crc), 
    .mse_physs_port_5_ts_capture_vld(mse_physs_port_5_ts_capture_vld), 
    .mse_physs_port_5_ts_capture_idx(mse_physs_port_5_ts_capture_idx), 
    .fifo_top_mux_0_physs1_icq_port_6_link_stat(fifo_top_mux_0_physs1_icq_port_6_link_stat), 
    .fifo_top_mux_0_physs1_mse_port_6_link_speed(fifo_top_mux_0_physs1_mse_port_6_link_speed), 
    .fifo_top_mux_0_physs1_mse_port_6_rx_dval(fifo_top_mux_0_physs1_mse_port_6_rx_dval), 
    .fifo_top_mux_0_physs1_mse_port_6_rx_data(fifo_top_mux_0_physs1_mse_port_6_rx_data), 
    .fifo_top_mux_0_physs1_mse_port_6_rx_sop(fifo_top_mux_0_physs1_mse_port_6_rx_sop), 
    .fifo_top_mux_0_physs1_mse_port_6_rx_eop(fifo_top_mux_0_physs1_mse_port_6_rx_eop), 
    .fifo_top_mux_0_physs1_mse_port_6_rx_mod(fifo_top_mux_0_physs1_mse_port_6_rx_mod), 
    .fifo_top_mux_0_physs1_mse_port_6_rx_err(fifo_top_mux_0_physs1_mse_port_6_rx_err), 
    .fifo_top_mux_0_physs1_mse_port_6_rx_ecc_err(fifo_top_mux_0_physs1_mse_port_6_rx_ecc_err), 
    .fifo_top_mux_0_physs1_mse_port_6_rx_ts(fifo_top_mux_0_physs1_mse_port_6_rx_ts), 
    .fifo_top_mux_0_physs1_mse_port_6_tx_rdy(fifo_top_mux_0_physs1_mse_port_6_tx_rdy), 
    .fifo_top_mux_0_physs1_mse_port_6_pfc_mode(fifo_top_mux_0_physs1_mse_port_6_pfc_mode), 
    .mse_physs_port_6_rx_rdy(mse_physs_port_6_rx_rdy), 
    .mse_physs_port_6_tx_wren(mse_physs_port_6_tx_wren), 
    .mse_physs_port_6_tx_data(mse_physs_port_6_tx_data), 
    .mse_physs_port_6_tx_sop(mse_physs_port_6_tx_sop), 
    .mse_physs_port_6_tx_eop(mse_physs_port_6_tx_eop), 
    .mse_physs_port_6_tx_mod(mse_physs_port_6_tx_mod), 
    .mse_physs_port_6_tx_err(mse_physs_port_6_tx_err), 
    .mse_physs_port_6_tx_crc(mse_physs_port_6_tx_crc), 
    .mse_physs_port_6_ts_capture_vld(mse_physs_port_6_ts_capture_vld), 
    .mse_physs_port_6_ts_capture_idx(mse_physs_port_6_ts_capture_idx), 
    .fifo_top_mux_0_physs1_icq_port_7_link_stat(fifo_top_mux_0_physs1_icq_port_7_link_stat), 
    .fifo_top_mux_0_physs1_mse_port_7_link_speed(fifo_top_mux_0_physs1_mse_port_7_link_speed), 
    .fifo_top_mux_0_physs1_mse_port_7_rx_dval(fifo_top_mux_0_physs1_mse_port_7_rx_dval), 
    .fifo_top_mux_0_physs1_mse_port_7_rx_data(fifo_top_mux_0_physs1_mse_port_7_rx_data), 
    .fifo_top_mux_0_physs1_mse_port_7_rx_sop(fifo_top_mux_0_physs1_mse_port_7_rx_sop), 
    .fifo_top_mux_0_physs1_mse_port_7_rx_eop(fifo_top_mux_0_physs1_mse_port_7_rx_eop), 
    .fifo_top_mux_0_physs1_mse_port_7_rx_mod(fifo_top_mux_0_physs1_mse_port_7_rx_mod), 
    .fifo_top_mux_0_physs1_mse_port_7_rx_err(fifo_top_mux_0_physs1_mse_port_7_rx_err), 
    .fifo_top_mux_0_physs1_mse_port_7_rx_ecc_err(fifo_top_mux_0_physs1_mse_port_7_rx_ecc_err), 
    .fifo_top_mux_0_physs1_mse_port_7_rx_ts(fifo_top_mux_0_physs1_mse_port_7_rx_ts), 
    .fifo_top_mux_0_physs1_mse_port_7_tx_rdy(fifo_top_mux_0_physs1_mse_port_7_tx_rdy), 
    .fifo_top_mux_0_physs1_mse_port_7_pfc_mode(fifo_top_mux_0_physs1_mse_port_7_pfc_mode), 
    .mse_physs_port_7_rx_rdy(mse_physs_port_7_rx_rdy), 
    .mse_physs_port_7_tx_wren(mse_physs_port_7_tx_wren), 
    .mse_physs_port_7_tx_data(mse_physs_port_7_tx_data), 
    .mse_physs_port_7_tx_sop(mse_physs_port_7_tx_sop), 
    .mse_physs_port_7_tx_eop(mse_physs_port_7_tx_eop), 
    .mse_physs_port_7_tx_mod(mse_physs_port_7_tx_mod), 
    .mse_physs_port_7_tx_err(mse_physs_port_7_tx_err), 
    .mse_physs_port_7_tx_crc(mse_physs_port_7_tx_crc), 
    .mse_physs_port_7_ts_capture_vld(mse_physs_port_7_ts_capture_vld), 
    .mse_physs_port_7_ts_capture_idx(mse_physs_port_7_ts_capture_idx), 
    .fifo_top_mux_0_mse_physs_port_0_tx_data(fifo_top_mux_0_mse_physs_port_0_tx_data), 
    .fifo_top_mux_0_mse_physs_port_0_tx_mod(fifo_top_mux_0_mse_physs_port_0_tx_mod), 
    .fifo_top_mux_0_mse_physs_port_0_tx_err(fifo_top_mux_0_mse_physs_port_0_tx_err), 
    .fifo_top_mux_0_mse_physs_port_0_tx_crc(fifo_top_mux_0_mse_physs_port_0_tx_crc), 
    .fifo_top_mux_0_mse_physs_port_0_ts_capture_vld(fifo_top_mux_0_mse_physs_port_0_ts_capture_vld), 
    .fifo_top_mux_0_mse_physs_port_0_ts_capture_idx(fifo_top_mux_0_mse_physs_port_0_ts_capture_idx), 
    .mac800_ff_rx_dval(mac800_ff_rx_dval), 
    .mac800_ff_rx_data(mac800_ff_rx_data), 
    .mac800_ff_rx_sop(mac800_ff_rx_sop), 
    .mac800_ff_rx_eop(mac800_ff_rx_eop), 
    .mac800_ff_rx_mod(mac800_ff_rx_mod), 
    .mac800_ff_rx_err(mac800_ff_rx_err), 
    .mac800_ff_rx_err_stat(mac800_ff_rx_err_stat), 
    .mac800_ff_rx_ts(mac800_ff_rx_ts), 
    .mac800_ff_rx_ts_0(mac800_ff_rx_ts_0), 
    .mac800_ff_tx_rdy(mac800_ff_tx_rdy), 
    .physs_registers_wrapper_0_reset_ref_clk_override_0(physs_registers_wrapper_0_reset_ref_clk_override_0), 
    .physs_registers_wrapper_0_reset_pcs100_override_en_0(physs_registers_wrapper_0_reset_pcs100_override_en_0), 
    .physs_registers_wrapper_0_clk_gate_en_100G_mac_pcs_0(physs_registers_wrapper_0_clk_gate_en_100G_mac_pcs_0), 
    .physs_registers_wrapper_0_power_fsm_clk_gate_en_0(physs_registers_wrapper_0_power_fsm_clk_gate_en_0), 
    .physs_registers_wrapper_0_power_fsm_reset_gate_en_0(physs_registers_wrapper_0_power_fsm_reset_gate_en_0), 
    .physs_registers_wrapper_1_reset_ref_clk_override_0(physs_registers_wrapper_1_reset_ref_clk_override_0), 
    .physs_registers_wrapper_1_reset_pcs100_override_en_0(physs_registers_wrapper_1_reset_pcs100_override_en_0), 
    .physs_registers_wrapper_1_clk_gate_en_100G_mac_pcs_0(physs_registers_wrapper_1_clk_gate_en_100G_mac_pcs_0), 
    .physs_registers_wrapper_1_power_fsm_clk_gate_en_0(physs_registers_wrapper_1_power_fsm_clk_gate_en_0), 
    .physs_registers_wrapper_1_power_fsm_reset_gate_en_0(physs_registers_wrapper_1_power_fsm_reset_gate_en_0), 
    .parmquad0_mux_sel_800(parmquad0_mux_sel_800), 
    .physs_registers_wrapper_2_reset_ref_clk_override_0(physs_registers_wrapper_2_reset_ref_clk_override_0), 
    .physs_registers_wrapper_2_reset_pcs100_override_en_0(physs_registers_wrapper_2_reset_pcs100_override_en_0), 
    .physs_registers_wrapper_2_clk_gate_en_100G_mac_pcs_0(physs_registers_wrapper_2_clk_gate_en_100G_mac_pcs_0), 
    .physs_registers_wrapper_2_power_fsm_clk_gate_en_0(physs_registers_wrapper_2_power_fsm_clk_gate_en_0), 
    .physs_registers_wrapper_2_power_fsm_reset_gate_en_0(physs_registers_wrapper_2_power_fsm_reset_gate_en_0), 
    .physs_registers_wrapper_3_reset_ref_clk_override_0(physs_registers_wrapper_3_reset_ref_clk_override_0), 
    .physs_registers_wrapper_3_reset_pcs100_override_en_0(physs_registers_wrapper_3_reset_pcs100_override_en_0), 
    .physs_registers_wrapper_3_clk_gate_en_100G_mac_pcs_0(physs_registers_wrapper_3_clk_gate_en_100G_mac_pcs_0), 
    .physs_registers_wrapper_3_power_fsm_clk_gate_en_0(physs_registers_wrapper_3_power_fsm_clk_gate_en_0), 
    .physs_registers_wrapper_3_power_fsm_reset_gate_en_0(physs_registers_wrapper_3_power_fsm_reset_gate_en_0), 
    .pd_vinf_0_bisr_si(pd_vinf_0_bisr_si), 
    .pd_vinf_0_bisr_so(parmisc_physs0_pd_vinf_0_bisr_so), 
    .pd_vinf_0_2_bisr_si(par400g0_pd_vinf_0_2_bisr_so), 
    .pd_vinf_0_2_bisr_so(parmisc_physs0_pd_vinf_0_2_bisr_so), 
    .pd_vinf_0_bisr_reset(pd_vinf_0_bisr_reset), 
    .pd_vinf_0_bisr_shift_en(pd_vinf_0_bisr_shift_en), 
    .pd_vinf_0_bisr_clk(pd_vinf_0_bisr_clk), 
    .pd_vinf_1_bisr_si(pd_vinf_1_bisr_si), 
    .pd_vinf_1_bisr_so(parmisc_physs0_pd_vinf_1_bisr_so), 
    .pd_vinf_1_2_bisr_si(par400g1_pd_vinf_1_2_bisr_so), 
    .pd_vinf_1_2_bisr_so(parmisc_physs0_pd_vinf_1_2_bisr_so), 
    .pd_vinf_1_bisr_reset(pd_vinf_1_bisr_reset), 
    .pd_vinf_1_bisr_shift_en(pd_vinf_1_bisr_shift_en), 
    .pd_vinf_1_bisr_clk(pd_vinf_1_bisr_clk), 
    .pd_vinf_2_bisr_si(pd_vinf_2_bisr_si), 
    .pd_vinf_2_bisr_so(parmisc_physs0_pd_vinf_2_bisr_so), 
    .pd_vinf_2_2_bisr_si(par400g0_pd_vinf_2_bisr_so), 
    .pd_vinf_2_2_bisr_so(parmisc_physs0_pd_vinf_2_2_bisr_so), 
    .pd_vinf_2_bisr_reset(pd_vinf_2_bisr_reset), 
    .pd_vinf_2_bisr_shift_en(pd_vinf_2_bisr_shift_en), 
    .pd_vinf_2_bisr_clk(pd_vinf_2_bisr_clk), 
    .pd_vinf_3_bisr_si(pd_vinf_3_bisr_si), 
    .pd_vinf_3_bisr_so(parmisc_physs0_pd_vinf_3_bisr_so), 
    .pd_vinf_3_2_bisr_si(par400g1_pd_vinf_3_bisr_so), 
    .pd_vinf_3_2_bisr_so(parmisc_physs0_pd_vinf_3_2_bisr_so), 
    .pd_vinf_3_bisr_reset(pd_vinf_3_bisr_reset), 
    .pd_vinf_3_bisr_shift_en(pd_vinf_3_bisr_shift_en), 
    .pd_vinf_3_bisr_clk(pd_vinf_3_bisr_clk), 
    .pd_vinf_4_bisr_si(pd_vinf_4_bisr_si), 
    .pd_vinf_4_bisr_so(parmisc_physs0_pd_vinf_4_bisr_so), 
    .pd_vinf_4_2_bisr_si(par800g_pd_vinf_4_bisr_so), 
    .pd_vinf_4_2_bisr_so(parmisc_physs0_pd_vinf_4_2_bisr_so), 
    .pd_vinf_4_bisr_reset(pd_vinf_4_bisr_reset), 
    .pd_vinf_4_bisr_shift_en(pd_vinf_4_bisr_shift_en), 
    .pd_vinf_4_bisr_clk(pd_vinf_4_bisr_clk), 
    .pd_vinf_5_bisr_si(pd_vinf_5_bisr_si), 
    .pd_vinf_5_bisr_so(parmisc_physs0_pd_vinf_5_bisr_so), 
    .pd_vinf_5_2_bisr_si(parmisc_physs1_pd_vinf_5_2_bisr_so), 
    .pd_vinf_5_2_bisr_so(parmisc_physs0_pd_vinf_5_2_bisr_so), 
    .pd_vinf_5_bisr_reset(pd_vinf_5_bisr_reset), 
    .pd_vinf_5_bisr_shift_en(pd_vinf_5_bisr_shift_en), 
    .pd_vinf_5_bisr_clk(pd_vinf_5_bisr_clk), 
    .pd_vinf_6_bisr_si(pd_vinf_6_bisr_si), 
    .pd_vinf_6_bisr_so(parmisc_physs0_pd_vinf_6_bisr_so), 
    .pd_vinf_6_2_bisr_si(parmisc_physs1_pd_vinf_6_2_bisr_so), 
    .pd_vinf_6_2_bisr_so(parmisc_physs0_pd_vinf_6_2_bisr_so), 
    .pd_vinf_6_bisr_reset(pd_vinf_6_bisr_reset), 
    .pd_vinf_6_bisr_shift_en(pd_vinf_6_bisr_shift_en), 
    .pd_vinf_6_bisr_clk(pd_vinf_6_bisr_clk), 
    .physs_clock_sync_parmisc_physs0_func_rstn_func_sync(physs_clock_sync_parmisc_physs0_func_rstn_func_sync), 
    .physs0_func_rst_raw_n(physs0_func_rst_raw_n), 
    .physs_synce_top_mux_0_clkout(physs_synce_top_mux_0_clkout), 
    .physs_synce_top_mux_1_clkout(physs_synce_top_mux_1_clkout), 
    .DIAG_0_mbist_diag_done(par800g_DIAG_0_mbist_diag_done), 
    .DIAG_AGGR_parmisc0_mbist_diag_done(parmisc_physs0_DIAG_AGGR_parmisc0_mbist_diag_done), 
    .DIAG_1_mbist_diag_done(par400g0_DIAG_AGGR_par400g0_mbist_diag_done), 
    .DIAG_2_mbist_diag_done(par400g1_DIAG_AGGR_par400g1_mbist_diag_done), 
    .DIAG_3_mbist_diag_done(parmquad0_DIAG_AGGR_mquad0_mbist_diag_done), 
    .DIAG_4_mbist_diag_done(parmquad1_DIAG_AGGR_mquad1_mbist_diag_done), 
    .DIAG_5_mbist_diag_done(parpquad0_DIAG_AGGR_pquad_mbist_diag_done), 
    .DIAG_6_mbist_diag_done(parpquad1_DIAG_AGGR_pquad_mbist_diag_done), 
    .ethphyss_post_clk_mux_ctrl(ethphyss_post_clk_mux_ctrl), 
    .versa_xmp_0_o_ucss_uart_txd(versa_xmp_0_o_ucss_uart_txd), 
    .versa_xmp_1_o_ucss_uart_txd(versa_xmp_1_o_ucss_uart_txd), 
    .versa_xmp_2_o_ucss_uart_txd(versa_xmp_2_o_ucss_uart_txd), 
    .versa_xmp_3_o_ucss_uart_txd(versa_xmp_3_o_ucss_uart_txd), 
    .physs_uart_demux_out0(physs_uart_demux_out0), 
    .physs_uart_demux_out1(physs_uart_demux_out1), 
    .physs_uart_demux_out2(physs_uart_demux_out2), 
    .physs_uart_demux_out3(physs_uart_demux_out3), 
    .physs_registers_wrapper_0_uart_port_mux_sel_uart_mux_sel_1(physs_registers_wrapper_0_uart_port_mux_sel_uart_mux_sel_1), 
    .physs_registers_wrapper_0_uart_port_mux_sel_uart_mux_sel_2(physs_registers_wrapper_0_uart_port_mux_sel_uart_mux_sel_2), 
    .physs_uart_mux_out(physs_uart_mux_out), 
    .i_ucss_uart_rxd(i_ucss_uart_rxd), 
    .xmp_mem_wrapper_0_aary_post_pass(xmp_mem_wrapper_0_aary_post_pass), 
    .xmp_mem_wrapper_0_aary_post_complete(xmp_mem_wrapper_0_aary_post_complete), 
    .xmp_mem_wrapper_1_aary_post_pass(xmp_mem_wrapper_1_aary_post_pass), 
    .xmp_mem_wrapper_1_aary_post_complete(xmp_mem_wrapper_1_aary_post_complete), 
    .ethphyss_post_agg_mquad_0_post_pass_agg(ethphyss_post_agg_mquad_0_post_pass_agg), 
    .ethphyss_post_agg_mquad_0_post_complete_agg(ethphyss_post_agg_mquad_0_post_complete_agg), 
    .pcs100_mem_wrapper_0_aary_post_pass(pcs100_mem_wrapper_0_aary_post_pass), 
    .pcs100_mem_wrapper_0_aary_post_complete(pcs100_mem_wrapper_0_aary_post_complete), 
    .pcs100_mem_wrapper_1_aary_post_pass(pcs100_mem_wrapper_1_aary_post_pass), 
    .pcs100_mem_wrapper_1_aary_post_complete(pcs100_mem_wrapper_1_aary_post_complete), 
    .ethphyss_post_agg_mquad_1_post_pass_agg(ethphyss_post_agg_mquad_1_post_pass_agg), 
    .ethphyss_post_agg_mquad_1_post_complete_agg(ethphyss_post_agg_mquad_1_post_complete_agg), 
    .ptpx_mem_wrapper_0_aary_post_pass(ptpx_mem_wrapper_0_aary_post_pass), 
    .ptpx_mem_wrapper_0_aary_post_complete(ptpx_mem_wrapper_0_aary_post_complete), 
    .ptpx_mem_wrapper_1_aary_post_pass(ptpx_mem_wrapper_1_aary_post_pass), 
    .ptpx_mem_wrapper_1_aary_post_complete(ptpx_mem_wrapper_1_aary_post_complete), 
    .ethphyss_post_agg_mquad_2_post_pass_agg(ethphyss_post_agg_mquad_2_post_pass_agg), 
    .ethphyss_post_agg_mquad_2_post_complete_agg(ethphyss_post_agg_mquad_2_post_complete_agg), 
    .mac100_mem_wrapper_0_aary_post_pass(mac100_mem_wrapper_0_aary_post_pass), 
    .mac100_mem_wrapper_0_aary_post_complete(mac100_mem_wrapper_0_aary_post_complete), 
    .mac100_mem_wrapper_1_aary_post_pass(mac100_mem_wrapper_1_aary_post_pass), 
    .mac100_mem_wrapper_1_aary_post_complete(mac100_mem_wrapper_1_aary_post_complete), 
    .ethphyss_post_agg_mquad_3_post_pass_agg(ethphyss_post_agg_mquad_3_post_pass_agg), 
    .ethphyss_post_agg_mquad_3_post_complete_agg(ethphyss_post_agg_mquad_3_post_complete_agg), 
    .xmp_mem_wrapper_2_aary_post_pass(xmp_mem_wrapper_2_aary_post_pass), 
    .xmp_mem_wrapper_2_aary_post_complete(xmp_mem_wrapper_2_aary_post_complete), 
    .xmp_mem_wrapper_3_aary_post_pass(xmp_mem_wrapper_3_aary_post_pass), 
    .xmp_mem_wrapper_3_aary_post_complete(xmp_mem_wrapper_3_aary_post_complete), 
    .ethphyss_post_agg_pquad_4_post_pass_agg(ethphyss_post_agg_pquad_4_post_pass_agg), 
    .ethphyss_post_agg_pquad_4_post_complete_agg(ethphyss_post_agg_pquad_4_post_complete_agg), 
    .pcs100_mem_wrapper_2_aary_post_pass(pcs100_mem_wrapper_2_aary_post_pass), 
    .pcs100_mem_wrapper_2_aary_post_complete(pcs100_mem_wrapper_2_aary_post_complete), 
    .pcs100_mem_wrapper_3_aary_post_pass(pcs100_mem_wrapper_3_aary_post_pass), 
    .pcs100_mem_wrapper_3_aary_post_complete(pcs100_mem_wrapper_3_aary_post_complete), 
    .ethphyss_post_agg_pquad_5_post_pass_agg(ethphyss_post_agg_pquad_5_post_pass_agg), 
    .ethphyss_post_agg_pquad_5_post_complete_agg(ethphyss_post_agg_pquad_5_post_complete_agg), 
    .par800g_macpcs800_6_post_pass_tdr(par800g_macpcs800_6_post_pass_tdr), 
    .par800g_macpcs800_6_post_complete_tdr(par800g_macpcs800_6_post_complete_tdr), 
    .ethphyss_post_agg_par800g_6_post_pass_agg(ethphyss_post_agg_par800g_6_post_pass_agg), 
    .ethphyss_post_agg_par800g_6_post_complete_agg(ethphyss_post_agg_par800g_6_post_complete_agg), 
    .par400g0_macpcs400_7_post_pass_tdr(par400g0_macpcs400_7_post_pass_tdr), 
    .par400g0_macpcs400_7_post_complete_tdr(par400g0_macpcs400_7_post_complete_tdr), 
    .ethphyss_post_agg_par400g0_7_post_pass_agg(ethphyss_post_agg_par400g0_7_post_pass_agg), 
    .ethphyss_post_agg_par400g0_7_post_complete_agg(ethphyss_post_agg_par400g0_7_post_complete_agg), 
    .par400g0_macpcs200_8_post_pass_tdr(par400g0_macpcs200_8_post_pass_tdr), 
    .par400g0_macpcs200_8_post_complete_tdr(par400g0_macpcs200_8_post_complete_tdr), 
    .ethphyss_post_agg_par400g0_8_post_pass_agg(ethphyss_post_agg_par400g0_8_post_pass_agg), 
    .ethphyss_post_agg_par400g0_8_post_complete_agg(ethphyss_post_agg_par400g0_8_post_complete_agg), 
    .par400g1_macpcs400_9_post_pass_tdr(par400g1_macpcs400_9_post_pass_tdr), 
    .par400g1_macpcs400_9_post_complete_tdr(par400g1_macpcs400_9_post_complete_tdr), 
    .ethphyss_post_agg_par400g1_9_post_pass_agg(ethphyss_post_agg_par400g1_9_post_pass_agg), 
    .ethphyss_post_agg_par400g1_9_post_complete_agg(ethphyss_post_agg_par400g1_9_post_complete_agg), 
    .par400g1_macpcs200_10_post_pass_tdr(par400g1_macpcs200_10_post_pass_tdr), 
    .par400g1_macpcs200_10_post_complete_tdr(par400g1_macpcs200_10_post_complete_tdr), 
    .ethphyss_post_agg_par400g1_10_post_pass_agg(ethphyss_post_agg_par400g1_10_post_pass_agg), 
    .ethphyss_post_agg_par400g1_10_post_complete_agg(ethphyss_post_agg_par400g1_10_post_complete_agg), 
    .macpcs800_6_post_busy_tdr(par800g_macpcs800_6_post_busy_tdr), 
    .macpcs800_6_post_pass_tdr(par800g_macpcs800_6_post_pass_tdr), 
    .macpcs800_6_post_complete_tdr(par800g_macpcs800_6_post_complete_tdr), 
    .macpcs200_8_post_busy_tdr(par400g0_macpcs200_8_post_busy_tdr), 
    .macpcs200_8_post_pass_tdr(par400g0_macpcs200_8_post_pass_tdr), 
    .macpcs200_8_post_complete_tdr(par400g0_macpcs200_8_post_complete_tdr), 
    .macpcs400_7_post_busy_tdr(par400g0_macpcs400_7_post_busy_tdr), 
    .macpcs400_7_post_pass_tdr(par400g0_macpcs400_7_post_pass_tdr), 
    .macpcs400_7_post_complete_tdr(par400g0_macpcs400_7_post_complete_tdr), 
    .macpcs200_10_post_busy_tdr(par400g1_macpcs200_10_post_busy_tdr), 
    .macpcs200_10_post_pass_tdr(par400g1_macpcs200_10_post_pass_tdr), 
    .macpcs200_10_post_complete_tdr(par400g1_macpcs200_10_post_complete_tdr), 
    .macpcs400_9_post_busy_tdr(par400g1_macpcs400_9_post_busy_tdr), 
    .macpcs400_9_post_pass_tdr(par400g1_macpcs400_9_post_pass_tdr), 
    .macpcs400_9_post_complete_tdr(par400g1_macpcs400_9_post_complete_tdr), 
    .trig_clock_stop_to_parpquad0_pma0_txdat(parmisc_physs0_trig_clock_stop_to_parpquad0_pma0_txdat), 
    .trig_clock_stop_to_parpquad0_pma1_txdat(parmisc_physs0_trig_clock_stop_to_parpquad0_pma1_txdat), 
    .trig_clock_stop_to_parpquad0_pma2_txdat(parmisc_physs0_trig_clock_stop_to_parpquad0_pma2_txdat), 
    .trig_clock_stop_to_parpquad0_pma3_txdat(parmisc_physs0_trig_clock_stop_to_parpquad0_pma3_txdat), 
    .trig_clock_stop_to_parpquad0_o_ck_pma0_rx(parmisc_physs0_trig_clock_stop_to_parpquad0_o_ck_pma0_rx), 
    .trig_clock_stop_to_parpquad0_o_ck_pma1_rx(parmisc_physs0_trig_clock_stop_to_parpquad0_o_ck_pma1_rx), 
    .trig_clock_stop_to_parpquad0_o_ck_pma2_rx(parmisc_physs0_trig_clock_stop_to_parpquad0_o_ck_pma2_rx), 
    .trig_clock_stop_to_parpquad0_o_ck_pma3_rx(parmisc_physs0_trig_clock_stop_to_parpquad0_o_ck_pma3_rx), 
    .trig_clock_stop_to_parpquad0_pma0_rxdat(parmisc_physs0_trig_clock_stop_to_parpquad0_pma0_rxdat), 
    .trig_clock_stop_to_parpquad0_pma1_rxdat(parmisc_physs0_trig_clock_stop_to_parpquad0_pma1_rxdat), 
    .trig_clock_stop_to_parpquad0_pma2_rxdat(parmisc_physs0_trig_clock_stop_to_parpquad0_pma2_rxdat), 
    .trig_clock_stop_to_parpquad0_pma3_rxdat(parmisc_physs0_trig_clock_stop_to_parpquad0_pma3_rxdat), 
    .trig_clock_stop_to_parpquad0_o_ck_pma0_cmnplla_postdiv(parmisc_physs0_trig_clock_stop_to_parpquad0_o_ck_pma0_cmnplla_postdiv), 
    .trig_clock_stop_to_parpquad0_o_ck_pma1_cmnplla_postdiv(parmisc_physs0_trig_clock_stop_to_parpquad0_o_ck_pma1_cmnplla_postdiv), 
    .trig_clock_stop_to_parpquad0_o_ck_pma2_cmnplla_postdiv(parmisc_physs0_trig_clock_stop_to_parpquad0_o_ck_pma2_cmnplla_postdiv), 
    .trig_clock_stop_to_parpquad0_o_ck_pma3_cmnplla_postdiv(parmisc_physs0_trig_clock_stop_to_parpquad0_o_ck_pma3_cmnplla_postdiv), 
    .trig_clock_stop_to_parpquad0_o_ck_slv_pcs1(parmisc_physs0_trig_clock_stop_to_parpquad0_o_ck_slv_pcs1), 
    .trig_clock_stop_to_parpquad0_o_ck_ucss_mem_dram(parmisc_physs0_trig_clock_stop_to_parpquad0_o_ck_ucss_mem_dram), 
    .trig_clock_stop_to_parpquad0_o_ck_ucss_mem_iram(parmisc_physs0_trig_clock_stop_to_parpquad0_o_ck_ucss_mem_iram), 
    .trig_clock_stop_to_parpquad0_o_ck_ucss_mem_tracemem(parmisc_physs0_trig_clock_stop_to_parpquad0_o_ck_ucss_mem_tracemem), 
    .trig_clock_stop_to_parpquad1_pma0_txdat(parmisc_physs0_trig_clock_stop_to_parpquad1_pma0_txdat), 
    .trig_clock_stop_to_parpquad1_pma1_txdat(parmisc_physs0_trig_clock_stop_to_parpquad1_pma1_txdat), 
    .trig_clock_stop_to_parpquad1_pma2_txdat(parmisc_physs0_trig_clock_stop_to_parpquad1_pma2_txdat), 
    .trig_clock_stop_to_parpquad1_pma3_txdat(parmisc_physs0_trig_clock_stop_to_parpquad1_pma3_txdat), 
    .trig_clock_stop_to_parpquad1_o_ck_pma0_rx(parmisc_physs0_trig_clock_stop_to_parpquad1_o_ck_pma0_rx), 
    .trig_clock_stop_to_parpquad1_o_ck_pma1_rx(parmisc_physs0_trig_clock_stop_to_parpquad1_o_ck_pma1_rx), 
    .trig_clock_stop_to_parpquad1_o_ck_pma2_rx(parmisc_physs0_trig_clock_stop_to_parpquad1_o_ck_pma2_rx), 
    .trig_clock_stop_to_parpquad1_o_ck_pma3_rx(parmisc_physs0_trig_clock_stop_to_parpquad1_o_ck_pma3_rx), 
    .trig_clock_stop_to_parpquad1_pma0_rxdat(parmisc_physs0_trig_clock_stop_to_parpquad1_pma0_rxdat), 
    .trig_clock_stop_to_parpquad1_pma1_rxdat(parmisc_physs0_trig_clock_stop_to_parpquad1_pma1_rxdat), 
    .trig_clock_stop_to_parpquad1_pma2_rxdat(parmisc_physs0_trig_clock_stop_to_parpquad1_pma2_rxdat), 
    .trig_clock_stop_to_parpquad1_pma3_rxdat(parmisc_physs0_trig_clock_stop_to_parpquad1_pma3_rxdat), 
    .trig_clock_stop_to_parpquad1_o_ck_pma0_cmnplla_postdiv(parmisc_physs0_trig_clock_stop_to_parpquad1_o_ck_pma0_cmnplla_postdiv), 
    .trig_clock_stop_to_parpquad1_o_ck_pma1_cmnplla_postdiv(parmisc_physs0_trig_clock_stop_to_parpquad1_o_ck_pma1_cmnplla_postdiv), 
    .trig_clock_stop_to_parpquad1_o_ck_pma2_cmnplla_postdiv(parmisc_physs0_trig_clock_stop_to_parpquad1_o_ck_pma2_cmnplla_postdiv), 
    .trig_clock_stop_to_parpquad1_o_ck_pma3_cmnplla_postdiv(parmisc_physs0_trig_clock_stop_to_parpquad1_o_ck_pma3_cmnplla_postdiv), 
    .trig_clock_stop_to_parpquad1_o_ck_slv_pcs1(parmisc_physs0_trig_clock_stop_to_parpquad1_o_ck_slv_pcs1), 
    .trig_clock_stop_to_parpquad1_o_ck_ucss_mem_dram(parmisc_physs0_trig_clock_stop_to_parpquad1_o_ck_ucss_mem_dram), 
    .trig_clock_stop_to_parpquad1_o_ck_ucss_mem_iram(parmisc_physs0_trig_clock_stop_to_parpquad1_o_ck_ucss_mem_iram), 
    .trig_clock_stop_to_parpquad1_o_ck_ucss_mem_tracemem(parmisc_physs0_trig_clock_stop_to_parpquad1_o_ck_ucss_mem_tracemem), 
    .trig_clock_stop_to_parmquad0_o_ck_pma0_rx(parmisc_physs0_trig_clock_stop_to_parmquad0_o_ck_pma0_rx), 
    .trig_clock_stop_to_parmquad0_o_ck_pma1_rx(parmisc_physs0_trig_clock_stop_to_parmquad0_o_ck_pma1_rx), 
    .trig_clock_stop_to_parmquad0_o_ck_pma2_rx(parmisc_physs0_trig_clock_stop_to_parmquad0_o_ck_pma2_rx), 
    .trig_clock_stop_to_parmquad0_o_ck_pma3_rx(parmisc_physs0_trig_clock_stop_to_parmquad0_o_ck_pma3_rx), 
    .trig_clock_stop_to_parmquad0_pma0_rxdat(parmisc_physs0_trig_clock_stop_to_parmquad0_pma0_rxdat), 
    .trig_clock_stop_to_parmquad0_pma1_rxdat(parmisc_physs0_trig_clock_stop_to_parmquad0_pma1_rxdat), 
    .trig_clock_stop_to_parmquad0_pma2_rxdat(parmisc_physs0_trig_clock_stop_to_parmquad0_pma2_rxdat), 
    .trig_clock_stop_to_parmquad0_pma3_rxdat(parmisc_physs0_trig_clock_stop_to_parmquad0_pma3_rxdat), 
    .trig_clock_stop_to_parmquad0_o_ck_pma0_cmnplla_postdiv(parmisc_physs0_trig_clock_stop_to_parmquad0_o_ck_pma0_cmnplla_postdiv), 
    .trig_clock_stop_to_parmquad0_o_ck_pma1_cmnplla_postdiv(parmisc_physs0_trig_clock_stop_to_parmquad0_o_ck_pma1_cmnplla_postdiv), 
    .trig_clock_stop_to_parmquad0_o_ck_pma2_cmnplla_postdiv(parmisc_physs0_trig_clock_stop_to_parmquad0_o_ck_pma2_cmnplla_postdiv), 
    .trig_clock_stop_to_parmquad0_o_ck_pma3_cmnplla_postdiv(parmisc_physs0_trig_clock_stop_to_parmquad0_o_ck_pma3_cmnplla_postdiv), 
    .trig_clock_stop_to_parmquad0_o_ck_slv_pcs1(parmisc_physs0_trig_clock_stop_to_parmquad0_o_ck_slv_pcs1), 
    .trig_clock_stop_to_parmquad0_o_ck_ucss_mem_dram(parmisc_physs0_trig_clock_stop_to_parmquad0_o_ck_ucss_mem_dram), 
    .trig_clock_stop_to_parmquad0_o_ck_ucss_mem_iram(parmisc_physs0_trig_clock_stop_to_parmquad0_o_ck_ucss_mem_iram), 
    .trig_clock_stop_to_parmquad0_o_ck_ucss_mem_tracemem(parmisc_physs0_trig_clock_stop_to_parmquad0_o_ck_ucss_mem_tracemem), 
    .trig_clock_stop_to_parmquad1_o_ck_pma0_rx(parmisc_physs0_trig_clock_stop_to_parmquad1_o_ck_pma0_rx), 
    .trig_clock_stop_to_parmquad1_o_ck_pma1_rx(parmisc_physs0_trig_clock_stop_to_parmquad1_o_ck_pma1_rx), 
    .trig_clock_stop_to_parmquad1_o_ck_pma2_rx(parmisc_physs0_trig_clock_stop_to_parmquad1_o_ck_pma2_rx), 
    .trig_clock_stop_to_parmquad1_o_ck_pma3_rx(parmisc_physs0_trig_clock_stop_to_parmquad1_o_ck_pma3_rx), 
    .trig_clock_stop_to_parmquad1_pma0_rxdat(parmisc_physs0_trig_clock_stop_to_parmquad1_pma0_rxdat), 
    .trig_clock_stop_to_parmquad1_pma1_rxdat(parmisc_physs0_trig_clock_stop_to_parmquad1_pma1_rxdat), 
    .trig_clock_stop_to_parmquad1_pma2_rxdat(parmisc_physs0_trig_clock_stop_to_parmquad1_pma2_rxdat), 
    .trig_clock_stop_to_parmquad1_pma3_rxdat(parmisc_physs0_trig_clock_stop_to_parmquad1_pma3_rxdat), 
    .trig_clock_stop_to_parmquad1_o_ck_pma0_cmnplla_postdiv(parmisc_physs0_trig_clock_stop_to_parmquad1_o_ck_pma0_cmnplla_postdiv), 
    .trig_clock_stop_to_parmquad1_o_ck_pma1_cmnplla_postdiv(parmisc_physs0_trig_clock_stop_to_parmquad1_o_ck_pma1_cmnplla_postdiv), 
    .trig_clock_stop_to_parmquad1_o_ck_pma2_cmnplla_postdiv(parmisc_physs0_trig_clock_stop_to_parmquad1_o_ck_pma2_cmnplla_postdiv), 
    .trig_clock_stop_to_parmquad1_o_ck_pma3_cmnplla_postdiv(parmisc_physs0_trig_clock_stop_to_parmquad1_o_ck_pma3_cmnplla_postdiv), 
    .trig_clock_stop_to_parmquad1_o_ck_slv_pcs1(parmisc_physs0_trig_clock_stop_to_parmquad1_o_ck_slv_pcs1), 
    .trig_clock_stop_to_parmquad1_o_ck_ucss_mem_dram(parmisc_physs0_trig_clock_stop_to_parmquad1_o_ck_ucss_mem_dram), 
    .trig_clock_stop_to_parmquad1_o_ck_ucss_mem_iram(parmisc_physs0_trig_clock_stop_to_parmquad1_o_ck_ucss_mem_iram), 
    .trig_clock_stop_to_parmquad1_o_ck_ucss_mem_tracemem(parmisc_physs0_trig_clock_stop_to_parmquad1_o_ck_ucss_mem_tracemem), 
    .quad_interrupts_0_physs_fatal_int(quad_interrupts_0_physs_fatal_int), 
    .quad_interrupts_1_physs_fatal_int(quad_interrupts_1_physs_fatal_int), 
    .fatal_int_0_o(fatal_int_0_o), 
    .quad_interrupts_0_physs_imc_int(quad_interrupts_0_physs_imc_int), 
    .quad_interrupts_1_physs_imc_int(quad_interrupts_1_physs_imc_int), 
    .imc_int_0_o(imc_int_0_o), 
    .physs_core_rst_fsm_0_enable_link_traffic_to_nss_reg_clr(physs_core_rst_fsm_0_enable_link_traffic_to_nss_reg_clr), 
    .physs_core_rst_fsm_1_enable_link_traffic_to_nss_reg_clr(physs_core_rst_fsm_1_enable_link_traffic_to_nss_reg_clr), 
    .physs_registers_wrapper_0_link_traffic_to_nss_enable_O(physs_registers_wrapper_0_link_traffic_to_nss_enable_O), 
    .physs_registers_wrapper_1_link_traffic_to_nss_enable_O_0(physs_registers_wrapper_1_link_traffic_to_nss_enable_O_0), 
    .nic_switch_mux_0_hlp_xlgmii0_txclk_ena(nic_switch_mux_0_hlp_xlgmii0_txclk_ena), 
    .pcs_mac_pipeline_top_wrap_mquad0_mac0_xlgmii_tx_clkena(pcs_mac_pipeline_top_wrap_mquad0_mac0_xlgmii_tx_clkena), 
    .nic_switch_mux_0_hlp_xlgmii0_rxclk_ena(nic_switch_mux_0_hlp_xlgmii0_rxclk_ena), 
    .pcs_mac_pipeline_top_wrap_mquad0_mac0_xlgmii_rx_clkena(pcs_mac_pipeline_top_wrap_mquad0_mac0_xlgmii_rx_clkena), 
    .nic_switch_mux_0_hlp_xlgmii0_rxc(nic_switch_mux_0_hlp_xlgmii0_rxc), 
    .pcs_mac_pipeline_top_wrap_mquad0_mac0_xlgmii_rx_rxc(pcs_mac_pipeline_top_wrap_mquad0_mac0_xlgmii_rx_rxc), 
    .nic_switch_mux_0_hlp_xlgmii0_rxd(nic_switch_mux_0_hlp_xlgmii0_rxd), 
    .pcs_mac_pipeline_top_wrap_mquad0_mac0_xlgmii_rx_rxd(pcs_mac_pipeline_top_wrap_mquad0_mac0_xlgmii_rx_rxd), 
    .nic_switch_mux_0_hlp_xlgmii0_rxt0_next(nic_switch_mux_0_hlp_xlgmii0_rxt0_next), 
    .pcs_mac_pipeline_top_wrap_mquad0_mac0_xlgmii_rxt0_next(pcs_mac_pipeline_top_wrap_mquad0_mac0_xlgmii_rxt0_next), 
    .hlp_xlgmii0_txc_0(hlp_xlgmii0_txc_0), 
    .pcs_mac_pipeline_top_wrap_mquad0_pcs0_xlgmii_tx_txc(pcs_mac_pipeline_top_wrap_mquad0_pcs0_xlgmii_tx_txc), 
    .hlp_xlgmii0_txd_0(hlp_xlgmii0_txd_0), 
    .pcs_mac_pipeline_top_wrap_mquad0_pcs0_xlgmii_tx_txd(pcs_mac_pipeline_top_wrap_mquad0_pcs0_xlgmii_tx_txd), 
    .quadpcs100_0_pcs_tsu_rx_sd_0(quadpcs100_0_pcs_tsu_rx_sd_0), 
    .pcs_mac_pipeline_top_wrap_mquad0_tsu0_xlgmii_rx_sd(pcs_mac_pipeline_top_wrap_mquad0_tsu0_xlgmii_rx_sd), 
    .quadpcs100_0_mii_rx_tsu_mux0_0(quadpcs100_0_mii_rx_tsu_mux0_0), 
    .pcs_mac_pipeline_top_wrap_mquad0_tsu0_xlgmii_rx_tsu(pcs_mac_pipeline_top_wrap_mquad0_tsu0_xlgmii_rx_tsu), 
    .quadpcs100_0_mii_tx_tsu_0(quadpcs100_0_mii_tx_tsu_0), 
    .pcs_mac_pipeline_top_wrap_mquad0_tsu0_xlgmii_tx_tsu(pcs_mac_pipeline_top_wrap_mquad0_tsu0_xlgmii_tx_tsu), 
    .nic_switch_mux_0_hlp_xlgmii1_txclk_ena(nic_switch_mux_0_hlp_xlgmii1_txclk_ena), 
    .pcs_mac_pipeline_top_wrap_mquad0_mac1_xlgmii_tx_clkena(pcs_mac_pipeline_top_wrap_mquad0_mac1_xlgmii_tx_clkena), 
    .nic_switch_mux_0_hlp_xlgmii1_rxclk_ena(nic_switch_mux_0_hlp_xlgmii1_rxclk_ena), 
    .pcs_mac_pipeline_top_wrap_mquad0_mac1_xlgmii_rx_clkena(pcs_mac_pipeline_top_wrap_mquad0_mac1_xlgmii_rx_clkena), 
    .nic_switch_mux_0_hlp_xlgmii1_rxc(nic_switch_mux_0_hlp_xlgmii1_rxc), 
    .pcs_mac_pipeline_top_wrap_mquad0_mac1_xlgmii_rx_rxc(pcs_mac_pipeline_top_wrap_mquad0_mac1_xlgmii_rx_rxc), 
    .nic_switch_mux_0_hlp_xlgmii1_rxd(nic_switch_mux_0_hlp_xlgmii1_rxd), 
    .pcs_mac_pipeline_top_wrap_mquad0_mac1_xlgmii_rx_rxd(pcs_mac_pipeline_top_wrap_mquad0_mac1_xlgmii_rx_rxd), 
    .nic_switch_mux_0_hlp_xlgmii1_rxt0_next(nic_switch_mux_0_hlp_xlgmii1_rxt0_next), 
    .pcs_mac_pipeline_top_wrap_mquad0_mac1_xlgmii_rxt0_next(pcs_mac_pipeline_top_wrap_mquad0_mac1_xlgmii_rxt0_next), 
    .hlp_xlgmii1_txc_0(hlp_xlgmii1_txc_0), 
    .pcs_mac_pipeline_top_wrap_mquad0_pcs1_xlgmii_tx_txc(pcs_mac_pipeline_top_wrap_mquad0_pcs1_xlgmii_tx_txc), 
    .hlp_xlgmii1_txd_0(hlp_xlgmii1_txd_0), 
    .pcs_mac_pipeline_top_wrap_mquad0_pcs1_xlgmii_tx_txd(pcs_mac_pipeline_top_wrap_mquad0_pcs1_xlgmii_tx_txd), 
    .quadpcs100_0_pcs_tsu_rx_sd_1(quadpcs100_0_pcs_tsu_rx_sd_1), 
    .pcs_mac_pipeline_top_wrap_mquad0_tsu1_xlgmii_rx_sd(pcs_mac_pipeline_top_wrap_mquad0_tsu1_xlgmii_rx_sd), 
    .quadpcs100_0_mii_rx_tsu_mux1_0(quadpcs100_0_mii_rx_tsu_mux1_0), 
    .pcs_mac_pipeline_top_wrap_mquad0_tsu1_xlgmii_rx_tsu(pcs_mac_pipeline_top_wrap_mquad0_tsu1_xlgmii_rx_tsu), 
    .quadpcs100_0_mii_tx_tsu_1(quadpcs100_0_mii_tx_tsu_1), 
    .pcs_mac_pipeline_top_wrap_mquad0_tsu1_xlgmii_tx_tsu(pcs_mac_pipeline_top_wrap_mquad0_tsu1_xlgmii_tx_tsu), 
    .nic_switch_mux_0_hlp_xlgmii2_txclk_ena(nic_switch_mux_0_hlp_xlgmii2_txclk_ena), 
    .pcs_mac_pipeline_top_wrap_mquad0_mac2_xlgmii_tx_clkena(pcs_mac_pipeline_top_wrap_mquad0_mac2_xlgmii_tx_clkena), 
    .nic_switch_mux_0_hlp_xlgmii2_rxclk_ena(nic_switch_mux_0_hlp_xlgmii2_rxclk_ena), 
    .pcs_mac_pipeline_top_wrap_mquad0_mac2_xlgmii_rx_clkena(pcs_mac_pipeline_top_wrap_mquad0_mac2_xlgmii_rx_clkena), 
    .nic_switch_mux_0_hlp_xlgmii2_rxc(nic_switch_mux_0_hlp_xlgmii2_rxc), 
    .pcs_mac_pipeline_top_wrap_mquad0_mac2_xlgmii_rx_rxc(pcs_mac_pipeline_top_wrap_mquad0_mac2_xlgmii_rx_rxc), 
    .nic_switch_mux_0_hlp_xlgmii2_rxd(nic_switch_mux_0_hlp_xlgmii2_rxd), 
    .pcs_mac_pipeline_top_wrap_mquad0_mac2_xlgmii_rx_rxd(pcs_mac_pipeline_top_wrap_mquad0_mac2_xlgmii_rx_rxd), 
    .nic_switch_mux_0_hlp_xlgmii2_rxt0_next(nic_switch_mux_0_hlp_xlgmii2_rxt0_next), 
    .pcs_mac_pipeline_top_wrap_mquad0_mac2_xlgmii_rxt0_next(pcs_mac_pipeline_top_wrap_mquad0_mac2_xlgmii_rxt0_next), 
    .hlp_xlgmii2_txc_0(hlp_xlgmii2_txc_0), 
    .pcs_mac_pipeline_top_wrap_mquad0_pcs2_xlgmii_tx_txc(pcs_mac_pipeline_top_wrap_mquad0_pcs2_xlgmii_tx_txc), 
    .hlp_xlgmii2_txd_0(hlp_xlgmii2_txd_0), 
    .pcs_mac_pipeline_top_wrap_mquad0_pcs2_xlgmii_tx_txd(pcs_mac_pipeline_top_wrap_mquad0_pcs2_xlgmii_tx_txd), 
    .quadpcs100_0_pcs_tsu_rx_sd_2(quadpcs100_0_pcs_tsu_rx_sd_2), 
    .pcs_mac_pipeline_top_wrap_mquad0_tsu2_xlgmii_rx_sd(pcs_mac_pipeline_top_wrap_mquad0_tsu2_xlgmii_rx_sd), 
    .quadpcs100_0_mii_rx_tsu_mux2_0(quadpcs100_0_mii_rx_tsu_mux2_0), 
    .pcs_mac_pipeline_top_wrap_mquad0_tsu2_xlgmii_rx_tsu(pcs_mac_pipeline_top_wrap_mquad0_tsu2_xlgmii_rx_tsu), 
    .quadpcs100_0_mii_tx_tsu_2(quadpcs100_0_mii_tx_tsu_2), 
    .pcs_mac_pipeline_top_wrap_mquad0_tsu2_xlgmii_tx_tsu(pcs_mac_pipeline_top_wrap_mquad0_tsu2_xlgmii_tx_tsu), 
    .nic_switch_mux_0_hlp_xlgmii3_txclk_ena(nic_switch_mux_0_hlp_xlgmii3_txclk_ena), 
    .pcs_mac_pipeline_top_wrap_mquad0_mac3_xlgmii_tx_clkena(pcs_mac_pipeline_top_wrap_mquad0_mac3_xlgmii_tx_clkena), 
    .nic_switch_mux_0_hlp_xlgmii3_rxclk_ena(nic_switch_mux_0_hlp_xlgmii3_rxclk_ena), 
    .pcs_mac_pipeline_top_wrap_mquad0_mac3_xlgmii_rx_clkena(pcs_mac_pipeline_top_wrap_mquad0_mac3_xlgmii_rx_clkena), 
    .nic_switch_mux_0_hlp_xlgmii3_rxc(nic_switch_mux_0_hlp_xlgmii3_rxc), 
    .pcs_mac_pipeline_top_wrap_mquad0_mac3_xlgmii_rx_rxc(pcs_mac_pipeline_top_wrap_mquad0_mac3_xlgmii_rx_rxc), 
    .nic_switch_mux_0_hlp_xlgmii3_rxd(nic_switch_mux_0_hlp_xlgmii3_rxd), 
    .pcs_mac_pipeline_top_wrap_mquad0_mac3_xlgmii_rx_rxd(pcs_mac_pipeline_top_wrap_mquad0_mac3_xlgmii_rx_rxd), 
    .nic_switch_mux_0_hlp_xlgmii3_rxt0_next(nic_switch_mux_0_hlp_xlgmii3_rxt0_next), 
    .pcs_mac_pipeline_top_wrap_mquad0_mac3_xlgmii_rxt0_next(pcs_mac_pipeline_top_wrap_mquad0_mac3_xlgmii_rxt0_next), 
    .hlp_xlgmii3_txc_0(hlp_xlgmii3_txc_0), 
    .pcs_mac_pipeline_top_wrap_mquad0_pcs3_xlgmii_tx_txc(pcs_mac_pipeline_top_wrap_mquad0_pcs3_xlgmii_tx_txc), 
    .hlp_xlgmii3_txd_0(hlp_xlgmii3_txd_0), 
    .pcs_mac_pipeline_top_wrap_mquad0_pcs3_xlgmii_tx_txd(pcs_mac_pipeline_top_wrap_mquad0_pcs3_xlgmii_tx_txd), 
    .quadpcs100_0_pcs_tsu_rx_sd_3(quadpcs100_0_pcs_tsu_rx_sd_3), 
    .pcs_mac_pipeline_top_wrap_mquad0_tsu3_xlgmii_rx_sd(pcs_mac_pipeline_top_wrap_mquad0_tsu3_xlgmii_rx_sd), 
    .quadpcs100_0_mii_rx_tsu_mux3_0(quadpcs100_0_mii_rx_tsu_mux3_0), 
    .pcs_mac_pipeline_top_wrap_mquad0_tsu3_xlgmii_rx_tsu(pcs_mac_pipeline_top_wrap_mquad0_tsu3_xlgmii_rx_tsu), 
    .quadpcs100_0_mii_tx_tsu_3(quadpcs100_0_mii_tx_tsu_3), 
    .pcs_mac_pipeline_top_wrap_mquad0_tsu3_xlgmii_tx_tsu(pcs_mac_pipeline_top_wrap_mquad0_tsu3_xlgmii_tx_tsu), 
    .nic_switch_mux_0_hlp_cgmii0_txclk_ena(nic_switch_mux_0_hlp_cgmii0_txclk_ena), 
    .pcs_mac_pipeline_top_wrap_mquad0_mac0_cgmii_tx_clkena(pcs_mac_pipeline_top_wrap_mquad0_mac0_cgmii_tx_clkena), 
    .nic_switch_mux_0_hlp_cgmii0_rxclk_ena(nic_switch_mux_0_hlp_cgmii0_rxclk_ena), 
    .pcs_mac_pipeline_top_wrap_mquad0_mac0_cgmii_rx_clkena(pcs_mac_pipeline_top_wrap_mquad0_mac0_cgmii_rx_clkena), 
    .nic_switch_mux_0_hlp_cgmii0_rxc(nic_switch_mux_0_hlp_cgmii0_rxc), 
    .pcs_mac_pipeline_top_wrap_mquad0_mac0_cgmii_rx_rxc(pcs_mac_pipeline_top_wrap_mquad0_mac0_cgmii_rx_rxc), 
    .nic_switch_mux_0_hlp_cgmii0_rxd(nic_switch_mux_0_hlp_cgmii0_rxd), 
    .pcs_mac_pipeline_top_wrap_mquad0_mac0_cgmii_rx_rxd(pcs_mac_pipeline_top_wrap_mquad0_mac0_cgmii_rx_rxd), 
    .hlp_cgmii0_txc_0(hlp_cgmii0_txc_0), 
    .pcs_mac_pipeline_top_wrap_mquad0_pcs0_cgmii_tx_txc(pcs_mac_pipeline_top_wrap_mquad0_pcs0_cgmii_tx_txc), 
    .hlp_cgmii0_txd_0(hlp_cgmii0_txd_0), 
    .pcs_mac_pipeline_top_wrap_mquad0_pcs0_cgmii_tx_txd(pcs_mac_pipeline_top_wrap_mquad0_pcs0_cgmii_tx_txd), 
    .nic_switch_mux_0_hlp_cgmii1_txclk_ena(nic_switch_mux_0_hlp_cgmii1_txclk_ena), 
    .pcs_mac_pipeline_top_wrap_mquad0_mac1_cgmii_tx_clkena(pcs_mac_pipeline_top_wrap_mquad0_mac1_cgmii_tx_clkena), 
    .nic_switch_mux_0_hlp_cgmii1_rxclk_ena(nic_switch_mux_0_hlp_cgmii1_rxclk_ena), 
    .pcs_mac_pipeline_top_wrap_mquad0_mac1_cgmii_rx_clkena(pcs_mac_pipeline_top_wrap_mquad0_mac1_cgmii_rx_clkena), 
    .nic_switch_mux_0_hlp_cgmii1_rxc(nic_switch_mux_0_hlp_cgmii1_rxc), 
    .pcs_mac_pipeline_top_wrap_mquad0_mac1_cgmii_rx_rxc(pcs_mac_pipeline_top_wrap_mquad0_mac1_cgmii_rx_rxc), 
    .nic_switch_mux_0_hlp_cgmii1_rxd(nic_switch_mux_0_hlp_cgmii1_rxd), 
    .pcs_mac_pipeline_top_wrap_mquad0_mac1_cgmii_rx_rxd(pcs_mac_pipeline_top_wrap_mquad0_mac1_cgmii_rx_rxd), 
    .hlp_cgmii1_txc_0(hlp_cgmii1_txc_0), 
    .pcs_mac_pipeline_top_wrap_mquad0_pcs1_cgmii_tx_txc(pcs_mac_pipeline_top_wrap_mquad0_pcs1_cgmii_tx_txc), 
    .hlp_cgmii1_txd_0(hlp_cgmii1_txd_0), 
    .pcs_mac_pipeline_top_wrap_mquad0_pcs1_cgmii_tx_txd(pcs_mac_pipeline_top_wrap_mquad0_pcs1_cgmii_tx_txd), 
    .nic_switch_mux_0_hlp_cgmii2_txclk_ena(nic_switch_mux_0_hlp_cgmii2_txclk_ena), 
    .pcs_mac_pipeline_top_wrap_mquad0_mac2_cgmii_tx_clkena(pcs_mac_pipeline_top_wrap_mquad0_mac2_cgmii_tx_clkena), 
    .nic_switch_mux_0_hlp_cgmii2_rxclk_ena(nic_switch_mux_0_hlp_cgmii2_rxclk_ena), 
    .pcs_mac_pipeline_top_wrap_mquad0_mac2_cgmii_rx_clkena(pcs_mac_pipeline_top_wrap_mquad0_mac2_cgmii_rx_clkena), 
    .nic_switch_mux_0_hlp_cgmii2_rxc(nic_switch_mux_0_hlp_cgmii2_rxc), 
    .pcs_mac_pipeline_top_wrap_mquad0_mac2_cgmii_rx_rxc(pcs_mac_pipeline_top_wrap_mquad0_mac2_cgmii_rx_rxc), 
    .nic_switch_mux_0_hlp_cgmii2_rxd(nic_switch_mux_0_hlp_cgmii2_rxd), 
    .pcs_mac_pipeline_top_wrap_mquad0_mac2_cgmii_rx_rxd(pcs_mac_pipeline_top_wrap_mquad0_mac2_cgmii_rx_rxd), 
    .hlp_cgmii2_txc_0(hlp_cgmii2_txc_0), 
    .pcs_mac_pipeline_top_wrap_mquad0_pcs2_cgmii_tx_txc(pcs_mac_pipeline_top_wrap_mquad0_pcs2_cgmii_tx_txc), 
    .hlp_cgmii2_txd_0(hlp_cgmii2_txd_0), 
    .pcs_mac_pipeline_top_wrap_mquad0_pcs2_cgmii_tx_txd(pcs_mac_pipeline_top_wrap_mquad0_pcs2_cgmii_tx_txd), 
    .nic_switch_mux_0_hlp_cgmii3_txclk_ena(nic_switch_mux_0_hlp_cgmii3_txclk_ena), 
    .pcs_mac_pipeline_top_wrap_mquad0_mac3_cgmii_tx_clkena(pcs_mac_pipeline_top_wrap_mquad0_mac3_cgmii_tx_clkena), 
    .nic_switch_mux_0_hlp_cgmii3_rxclk_ena(nic_switch_mux_0_hlp_cgmii3_rxclk_ena), 
    .pcs_mac_pipeline_top_wrap_mquad0_mac3_cgmii_rx_clkena(pcs_mac_pipeline_top_wrap_mquad0_mac3_cgmii_rx_clkena), 
    .nic_switch_mux_0_hlp_cgmii3_rxc(nic_switch_mux_0_hlp_cgmii3_rxc), 
    .pcs_mac_pipeline_top_wrap_mquad0_mac3_cgmii_rx_rxc(pcs_mac_pipeline_top_wrap_mquad0_mac3_cgmii_rx_rxc), 
    .nic_switch_mux_0_hlp_cgmii3_rxd(nic_switch_mux_0_hlp_cgmii3_rxd), 
    .pcs_mac_pipeline_top_wrap_mquad0_mac3_cgmii_rx_rxd(pcs_mac_pipeline_top_wrap_mquad0_mac3_cgmii_rx_rxd), 
    .hlp_cgmii3_txc_0(hlp_cgmii3_txc_0), 
    .pcs_mac_pipeline_top_wrap_mquad0_pcs3_cgmii_tx_txc(pcs_mac_pipeline_top_wrap_mquad0_pcs3_cgmii_tx_txc), 
    .hlp_cgmii3_txd_0(hlp_cgmii3_txd_0), 
    .pcs_mac_pipeline_top_wrap_mquad0_pcs3_cgmii_tx_txd(pcs_mac_pipeline_top_wrap_mquad0_pcs3_cgmii_tx_txd), 
    .hlp_xlgmii0_rxc_nss_0(hlp_xlgmii0_rxc_nss_0), 
    .pcs_mac_pipeline_top_wrap_nss_mac0_xlgmii_rx_rxc(pcs_mac_pipeline_top_wrap_nss_mac0_xlgmii_rx_rxc), 
    .hlp_xlgmii0_rxd_nss_0(hlp_xlgmii0_rxd_nss_0), 
    .pcs_mac_pipeline_top_wrap_nss_mac0_xlgmii_rx_rxd(pcs_mac_pipeline_top_wrap_nss_mac0_xlgmii_rx_rxd), 
    .nic_switch_mux_0_hlp_xlgmii0_txc_nss(nic_switch_mux_0_hlp_xlgmii0_txc_nss), 
    .pcs_mac_pipeline_top_wrap_nss_pcs0_xlgmii_tx_txc(pcs_mac_pipeline_top_wrap_nss_pcs0_xlgmii_tx_txc), 
    .nic_switch_mux_0_hlp_xlgmii0_txd_nss(nic_switch_mux_0_hlp_xlgmii0_txd_nss), 
    .pcs_mac_pipeline_top_wrap_nss_pcs0_xlgmii_tx_txd(pcs_mac_pipeline_top_wrap_nss_pcs0_xlgmii_tx_txd), 
    .hlp_xlgmii1_rxc_nss_0(hlp_xlgmii1_rxc_nss_0), 
    .pcs_mac_pipeline_top_wrap_nss_mac1_xlgmii_rx_rxc(pcs_mac_pipeline_top_wrap_nss_mac1_xlgmii_rx_rxc), 
    .hlp_xlgmii1_rxd_nss_0(hlp_xlgmii1_rxd_nss_0), 
    .pcs_mac_pipeline_top_wrap_nss_mac1_xlgmii_rx_rxd(pcs_mac_pipeline_top_wrap_nss_mac1_xlgmii_rx_rxd), 
    .nic_switch_mux_0_hlp_xlgmii1_txc_nss(nic_switch_mux_0_hlp_xlgmii1_txc_nss), 
    .pcs_mac_pipeline_top_wrap_nss_pcs1_xlgmii_tx_txc(pcs_mac_pipeline_top_wrap_nss_pcs1_xlgmii_tx_txc), 
    .nic_switch_mux_0_hlp_xlgmii1_txd_nss(nic_switch_mux_0_hlp_xlgmii1_txd_nss), 
    .pcs_mac_pipeline_top_wrap_nss_pcs1_xlgmii_tx_txd(pcs_mac_pipeline_top_wrap_nss_pcs1_xlgmii_tx_txd), 
    .hlp_xlgmii2_rxc_nss_0(hlp_xlgmii2_rxc_nss_0), 
    .pcs_mac_pipeline_top_wrap_nss_mac2_xlgmii_rx_rxc(pcs_mac_pipeline_top_wrap_nss_mac2_xlgmii_rx_rxc), 
    .hlp_xlgmii2_rxd_nss_0(hlp_xlgmii2_rxd_nss_0), 
    .pcs_mac_pipeline_top_wrap_nss_mac2_xlgmii_rx_rxd(pcs_mac_pipeline_top_wrap_nss_mac2_xlgmii_rx_rxd), 
    .nic_switch_mux_0_hlp_xlgmii2_txc_nss(nic_switch_mux_0_hlp_xlgmii2_txc_nss), 
    .pcs_mac_pipeline_top_wrap_nss_pcs2_xlgmii_tx_txc(pcs_mac_pipeline_top_wrap_nss_pcs2_xlgmii_tx_txc), 
    .nic_switch_mux_0_hlp_xlgmii2_txd_nss(nic_switch_mux_0_hlp_xlgmii2_txd_nss), 
    .pcs_mac_pipeline_top_wrap_nss_pcs2_xlgmii_tx_txd(pcs_mac_pipeline_top_wrap_nss_pcs2_xlgmii_tx_txd), 
    .hlp_xlgmii3_rxc_nss_0(hlp_xlgmii3_rxc_nss_0), 
    .pcs_mac_pipeline_top_wrap_nss_mac3_xlgmii_rx_rxc(pcs_mac_pipeline_top_wrap_nss_mac3_xlgmii_rx_rxc), 
    .hlp_xlgmii3_rxd_nss_0(hlp_xlgmii3_rxd_nss_0), 
    .pcs_mac_pipeline_top_wrap_nss_mac3_xlgmii_rx_rxd(pcs_mac_pipeline_top_wrap_nss_mac3_xlgmii_rx_rxd), 
    .nic_switch_mux_0_hlp_xlgmii3_txc_nss(nic_switch_mux_0_hlp_xlgmii3_txc_nss), 
    .pcs_mac_pipeline_top_wrap_nss_pcs3_xlgmii_tx_txc(pcs_mac_pipeline_top_wrap_nss_pcs3_xlgmii_tx_txc), 
    .nic_switch_mux_0_hlp_xlgmii3_txd_nss(nic_switch_mux_0_hlp_xlgmii3_txd_nss), 
    .pcs_mac_pipeline_top_wrap_nss_pcs3_xlgmii_tx_txd(pcs_mac_pipeline_top_wrap_nss_pcs3_xlgmii_tx_txd), 
    .hlp_cgmii0_rxc_nss_0(hlp_cgmii0_rxc_nss_0), 
    .pcs_mac_pipeline_top_wrap_nss_mac0_cgmii_rx_rxc(pcs_mac_pipeline_top_wrap_nss_mac0_cgmii_rx_rxc), 
    .hlp_cgmii0_rxd_nss_0(hlp_cgmii0_rxd_nss_0), 
    .pcs_mac_pipeline_top_wrap_nss_mac0_cgmii_rx_rxd(pcs_mac_pipeline_top_wrap_nss_mac0_cgmii_rx_rxd), 
    .nic_switch_mux_0_hlp_cgmii0_txc_nss(nic_switch_mux_0_hlp_cgmii0_txc_nss), 
    .pcs_mac_pipeline_top_wrap_nss_pcs0_cgmii_tx_txc(pcs_mac_pipeline_top_wrap_nss_pcs0_cgmii_tx_txc), 
    .nic_switch_mux_0_hlp_cgmii0_txd_nss(nic_switch_mux_0_hlp_cgmii0_txd_nss), 
    .pcs_mac_pipeline_top_wrap_nss_pcs0_cgmii_tx_txd(pcs_mac_pipeline_top_wrap_nss_pcs0_cgmii_tx_txd), 
    .hlp_cgmii1_rxc_nss_0(hlp_cgmii1_rxc_nss_0), 
    .pcs_mac_pipeline_top_wrap_nss_mac1_cgmii_rx_rxc(pcs_mac_pipeline_top_wrap_nss_mac1_cgmii_rx_rxc), 
    .hlp_cgmii1_rxd_nss_0(hlp_cgmii1_rxd_nss_0), 
    .pcs_mac_pipeline_top_wrap_nss_mac1_cgmii_rx_rxd(pcs_mac_pipeline_top_wrap_nss_mac1_cgmii_rx_rxd), 
    .nic_switch_mux_0_hlp_cgmii1_txc_nss(nic_switch_mux_0_hlp_cgmii1_txc_nss), 
    .pcs_mac_pipeline_top_wrap_nss_pcs1_cgmii_tx_txc(pcs_mac_pipeline_top_wrap_nss_pcs1_cgmii_tx_txc), 
    .nic_switch_mux_0_hlp_cgmii1_txd_nss(nic_switch_mux_0_hlp_cgmii1_txd_nss), 
    .pcs_mac_pipeline_top_wrap_nss_pcs1_cgmii_tx_txd(pcs_mac_pipeline_top_wrap_nss_pcs1_cgmii_tx_txd), 
    .hlp_cgmii2_rxc_nss_0(hlp_cgmii2_rxc_nss_0), 
    .pcs_mac_pipeline_top_wrap_nss_mac2_cgmii_rx_rxc(pcs_mac_pipeline_top_wrap_nss_mac2_cgmii_rx_rxc), 
    .hlp_cgmii2_rxd_nss_0(hlp_cgmii2_rxd_nss_0), 
    .pcs_mac_pipeline_top_wrap_nss_mac2_cgmii_rx_rxd(pcs_mac_pipeline_top_wrap_nss_mac2_cgmii_rx_rxd), 
    .nic_switch_mux_0_hlp_cgmii2_txc_nss(nic_switch_mux_0_hlp_cgmii2_txc_nss), 
    .pcs_mac_pipeline_top_wrap_nss_pcs2_cgmii_tx_txc(pcs_mac_pipeline_top_wrap_nss_pcs2_cgmii_tx_txc), 
    .nic_switch_mux_0_hlp_cgmii2_txd_nss(nic_switch_mux_0_hlp_cgmii2_txd_nss), 
    .pcs_mac_pipeline_top_wrap_nss_pcs2_cgmii_tx_txd(pcs_mac_pipeline_top_wrap_nss_pcs2_cgmii_tx_txd), 
    .hlp_cgmii3_rxc_nss_0(hlp_cgmii3_rxc_nss_0), 
    .pcs_mac_pipeline_top_wrap_nss_mac3_cgmii_rx_rxc(pcs_mac_pipeline_top_wrap_nss_mac3_cgmii_rx_rxc), 
    .hlp_cgmii3_rxd_nss_0(hlp_cgmii3_rxd_nss_0), 
    .pcs_mac_pipeline_top_wrap_nss_mac3_cgmii_rx_rxd(pcs_mac_pipeline_top_wrap_nss_mac3_cgmii_rx_rxd), 
    .nic_switch_mux_0_hlp_cgmii3_txc_nss(nic_switch_mux_0_hlp_cgmii3_txc_nss), 
    .pcs_mac_pipeline_top_wrap_nss_pcs3_cgmii_tx_txc(pcs_mac_pipeline_top_wrap_nss_pcs3_cgmii_tx_txc), 
    .nic_switch_mux_0_hlp_cgmii3_txd_nss(nic_switch_mux_0_hlp_cgmii3_txd_nss), 
    .pcs_mac_pipeline_top_wrap_nss_pcs3_cgmii_tx_txd(pcs_mac_pipeline_top_wrap_nss_pcs3_cgmii_tx_txd), 
    .nic_switch_mux_1_hlp_xlgmii0_txclk_ena(nic_switch_mux_1_hlp_xlgmii0_txclk_ena), 
    .pcs_mac_pipeline_top_wrap_mquad1_mac0_xlgmii_tx_clkena(pcs_mac_pipeline_top_wrap_mquad1_mac0_xlgmii_tx_clkena), 
    .nic_switch_mux_1_hlp_xlgmii0_rxclk_ena(nic_switch_mux_1_hlp_xlgmii0_rxclk_ena), 
    .pcs_mac_pipeline_top_wrap_mquad1_mac0_xlgmii_rx_clkena(pcs_mac_pipeline_top_wrap_mquad1_mac0_xlgmii_rx_clkena), 
    .nic_switch_mux_1_hlp_xlgmii0_rxc(nic_switch_mux_1_hlp_xlgmii0_rxc), 
    .pcs_mac_pipeline_top_wrap_mquad1_mac0_xlgmii_rx_rxc(pcs_mac_pipeline_top_wrap_mquad1_mac0_xlgmii_rx_rxc), 
    .nic_switch_mux_1_hlp_xlgmii0_rxd(nic_switch_mux_1_hlp_xlgmii0_rxd), 
    .pcs_mac_pipeline_top_wrap_mquad1_mac0_xlgmii_rx_rxd(pcs_mac_pipeline_top_wrap_mquad1_mac0_xlgmii_rx_rxd), 
    .nic_switch_mux_1_hlp_xlgmii0_rxt0_next(nic_switch_mux_1_hlp_xlgmii0_rxt0_next), 
    .pcs_mac_pipeline_top_wrap_mquad1_mac0_xlgmii_rxt0_next(pcs_mac_pipeline_top_wrap_mquad1_mac0_xlgmii_rxt0_next), 
    .hlp_xlgmii0_txc_1(hlp_xlgmii0_txc_1), 
    .pcs_mac_pipeline_top_wrap_mquad1_pcs0_xlgmii_tx_txc(pcs_mac_pipeline_top_wrap_mquad1_pcs0_xlgmii_tx_txc), 
    .hlp_xlgmii0_txd_1(hlp_xlgmii0_txd_1), 
    .pcs_mac_pipeline_top_wrap_mquad1_pcs0_xlgmii_tx_txd(pcs_mac_pipeline_top_wrap_mquad1_pcs0_xlgmii_tx_txd), 
    .quadpcs100_1_pcs_tsu_rx_sd_0(quadpcs100_1_pcs_tsu_rx_sd_0), 
    .pcs_mac_pipeline_top_wrap_mquad1_tsu0_xlgmii_rx_sd(pcs_mac_pipeline_top_wrap_mquad1_tsu0_xlgmii_rx_sd), 
    .quadpcs100_1_mii_rx_tsu_mux0_0(quadpcs100_1_mii_rx_tsu_mux0_0), 
    .pcs_mac_pipeline_top_wrap_mquad1_tsu0_xlgmii_rx_tsu(pcs_mac_pipeline_top_wrap_mquad1_tsu0_xlgmii_rx_tsu), 
    .quadpcs100_1_mii_tx_tsu_0(quadpcs100_1_mii_tx_tsu_0), 
    .pcs_mac_pipeline_top_wrap_mquad1_tsu0_xlgmii_tx_tsu(pcs_mac_pipeline_top_wrap_mquad1_tsu0_xlgmii_tx_tsu), 
    .nic_switch_mux_1_hlp_xlgmii1_txclk_ena(nic_switch_mux_1_hlp_xlgmii1_txclk_ena), 
    .pcs_mac_pipeline_top_wrap_mquad1_mac1_xlgmii_tx_clkena(pcs_mac_pipeline_top_wrap_mquad1_mac1_xlgmii_tx_clkena), 
    .nic_switch_mux_1_hlp_xlgmii1_rxclk_ena(nic_switch_mux_1_hlp_xlgmii1_rxclk_ena), 
    .pcs_mac_pipeline_top_wrap_mquad1_mac1_xlgmii_rx_clkena(pcs_mac_pipeline_top_wrap_mquad1_mac1_xlgmii_rx_clkena), 
    .nic_switch_mux_1_hlp_xlgmii1_rxc(nic_switch_mux_1_hlp_xlgmii1_rxc), 
    .pcs_mac_pipeline_top_wrap_mquad1_mac1_xlgmii_rx_rxc(pcs_mac_pipeline_top_wrap_mquad1_mac1_xlgmii_rx_rxc), 
    .nic_switch_mux_1_hlp_xlgmii1_rxd(nic_switch_mux_1_hlp_xlgmii1_rxd), 
    .pcs_mac_pipeline_top_wrap_mquad1_mac1_xlgmii_rx_rxd(pcs_mac_pipeline_top_wrap_mquad1_mac1_xlgmii_rx_rxd), 
    .nic_switch_mux_1_hlp_xlgmii1_rxt0_next(nic_switch_mux_1_hlp_xlgmii1_rxt0_next), 
    .pcs_mac_pipeline_top_wrap_mquad1_mac1_xlgmii_rxt0_next(pcs_mac_pipeline_top_wrap_mquad1_mac1_xlgmii_rxt0_next), 
    .hlp_xlgmii1_txc_1(hlp_xlgmii1_txc_1), 
    .pcs_mac_pipeline_top_wrap_mquad1_pcs1_xlgmii_tx_txc(pcs_mac_pipeline_top_wrap_mquad1_pcs1_xlgmii_tx_txc), 
    .hlp_xlgmii1_txd_1(hlp_xlgmii1_txd_1), 
    .pcs_mac_pipeline_top_wrap_mquad1_pcs1_xlgmii_tx_txd(pcs_mac_pipeline_top_wrap_mquad1_pcs1_xlgmii_tx_txd), 
    .quadpcs100_1_pcs_tsu_rx_sd_1(quadpcs100_1_pcs_tsu_rx_sd_1), 
    .pcs_mac_pipeline_top_wrap_mquad1_tsu1_xlgmii_rx_sd(pcs_mac_pipeline_top_wrap_mquad1_tsu1_xlgmii_rx_sd), 
    .quadpcs100_1_mii_rx_tsu_mux1_0(quadpcs100_1_mii_rx_tsu_mux1_0), 
    .pcs_mac_pipeline_top_wrap_mquad1_tsu1_xlgmii_rx_tsu(pcs_mac_pipeline_top_wrap_mquad1_tsu1_xlgmii_rx_tsu), 
    .quadpcs100_1_mii_tx_tsu_1(quadpcs100_1_mii_tx_tsu_1), 
    .pcs_mac_pipeline_top_wrap_mquad1_tsu1_xlgmii_tx_tsu(pcs_mac_pipeline_top_wrap_mquad1_tsu1_xlgmii_tx_tsu), 
    .nic_switch_mux_1_hlp_xlgmii2_txclk_ena(nic_switch_mux_1_hlp_xlgmii2_txclk_ena), 
    .pcs_mac_pipeline_top_wrap_mquad1_mac2_xlgmii_tx_clkena(pcs_mac_pipeline_top_wrap_mquad1_mac2_xlgmii_tx_clkena), 
    .nic_switch_mux_1_hlp_xlgmii2_rxclk_ena(nic_switch_mux_1_hlp_xlgmii2_rxclk_ena), 
    .pcs_mac_pipeline_top_wrap_mquad1_mac2_xlgmii_rx_clkena(pcs_mac_pipeline_top_wrap_mquad1_mac2_xlgmii_rx_clkena), 
    .nic_switch_mux_1_hlp_xlgmii2_rxc(nic_switch_mux_1_hlp_xlgmii2_rxc), 
    .pcs_mac_pipeline_top_wrap_mquad1_mac2_xlgmii_rx_rxc(pcs_mac_pipeline_top_wrap_mquad1_mac2_xlgmii_rx_rxc), 
    .nic_switch_mux_1_hlp_xlgmii2_rxd(nic_switch_mux_1_hlp_xlgmii2_rxd), 
    .pcs_mac_pipeline_top_wrap_mquad1_mac2_xlgmii_rx_rxd(pcs_mac_pipeline_top_wrap_mquad1_mac2_xlgmii_rx_rxd), 
    .nic_switch_mux_1_hlp_xlgmii2_rxt0_next(nic_switch_mux_1_hlp_xlgmii2_rxt0_next), 
    .pcs_mac_pipeline_top_wrap_mquad1_mac2_xlgmii_rxt0_next(pcs_mac_pipeline_top_wrap_mquad1_mac2_xlgmii_rxt0_next), 
    .hlp_xlgmii2_txc_1(hlp_xlgmii2_txc_1), 
    .pcs_mac_pipeline_top_wrap_mquad1_pcs2_xlgmii_tx_txc(pcs_mac_pipeline_top_wrap_mquad1_pcs2_xlgmii_tx_txc), 
    .hlp_xlgmii2_txd_1(hlp_xlgmii2_txd_1), 
    .pcs_mac_pipeline_top_wrap_mquad1_pcs2_xlgmii_tx_txd(pcs_mac_pipeline_top_wrap_mquad1_pcs2_xlgmii_tx_txd), 
    .quadpcs100_1_pcs_tsu_rx_sd_2(quadpcs100_1_pcs_tsu_rx_sd_2), 
    .pcs_mac_pipeline_top_wrap_mquad1_tsu2_xlgmii_rx_sd(pcs_mac_pipeline_top_wrap_mquad1_tsu2_xlgmii_rx_sd), 
    .quadpcs100_1_mii_rx_tsu_mux2_0(quadpcs100_1_mii_rx_tsu_mux2_0), 
    .pcs_mac_pipeline_top_wrap_mquad1_tsu2_xlgmii_rx_tsu(pcs_mac_pipeline_top_wrap_mquad1_tsu2_xlgmii_rx_tsu), 
    .quadpcs100_1_mii_tx_tsu_2(quadpcs100_1_mii_tx_tsu_2), 
    .pcs_mac_pipeline_top_wrap_mquad1_tsu2_xlgmii_tx_tsu(pcs_mac_pipeline_top_wrap_mquad1_tsu2_xlgmii_tx_tsu), 
    .nic_switch_mux_1_hlp_xlgmii3_txclk_ena(nic_switch_mux_1_hlp_xlgmii3_txclk_ena), 
    .pcs_mac_pipeline_top_wrap_mquad1_mac3_xlgmii_tx_clkena(pcs_mac_pipeline_top_wrap_mquad1_mac3_xlgmii_tx_clkena), 
    .nic_switch_mux_1_hlp_xlgmii3_rxclk_ena(nic_switch_mux_1_hlp_xlgmii3_rxclk_ena), 
    .pcs_mac_pipeline_top_wrap_mquad1_mac3_xlgmii_rx_clkena(pcs_mac_pipeline_top_wrap_mquad1_mac3_xlgmii_rx_clkena), 
    .nic_switch_mux_1_hlp_xlgmii3_rxc(nic_switch_mux_1_hlp_xlgmii3_rxc), 
    .pcs_mac_pipeline_top_wrap_mquad1_mac3_xlgmii_rx_rxc(pcs_mac_pipeline_top_wrap_mquad1_mac3_xlgmii_rx_rxc), 
    .nic_switch_mux_1_hlp_xlgmii3_rxd(nic_switch_mux_1_hlp_xlgmii3_rxd), 
    .pcs_mac_pipeline_top_wrap_mquad1_mac3_xlgmii_rx_rxd(pcs_mac_pipeline_top_wrap_mquad1_mac3_xlgmii_rx_rxd), 
    .nic_switch_mux_1_hlp_xlgmii3_rxt0_next(nic_switch_mux_1_hlp_xlgmii3_rxt0_next), 
    .pcs_mac_pipeline_top_wrap_mquad1_mac3_xlgmii_rxt0_next(pcs_mac_pipeline_top_wrap_mquad1_mac3_xlgmii_rxt0_next), 
    .hlp_xlgmii3_txc_1(hlp_xlgmii3_txc_1), 
    .pcs_mac_pipeline_top_wrap_mquad1_pcs3_xlgmii_tx_txc(pcs_mac_pipeline_top_wrap_mquad1_pcs3_xlgmii_tx_txc), 
    .hlp_xlgmii3_txd_1(hlp_xlgmii3_txd_1), 
    .pcs_mac_pipeline_top_wrap_mquad1_pcs3_xlgmii_tx_txd(pcs_mac_pipeline_top_wrap_mquad1_pcs3_xlgmii_tx_txd), 
    .quadpcs100_1_pcs_tsu_rx_sd_3(quadpcs100_1_pcs_tsu_rx_sd_3), 
    .pcs_mac_pipeline_top_wrap_mquad1_tsu3_xlgmii_rx_sd(pcs_mac_pipeline_top_wrap_mquad1_tsu3_xlgmii_rx_sd), 
    .quadpcs100_1_mii_rx_tsu_mux3_0(quadpcs100_1_mii_rx_tsu_mux3_0), 
    .pcs_mac_pipeline_top_wrap_mquad1_tsu3_xlgmii_rx_tsu(pcs_mac_pipeline_top_wrap_mquad1_tsu3_xlgmii_rx_tsu), 
    .quadpcs100_1_mii_tx_tsu_3(quadpcs100_1_mii_tx_tsu_3), 
    .pcs_mac_pipeline_top_wrap_mquad1_tsu3_xlgmii_tx_tsu(pcs_mac_pipeline_top_wrap_mquad1_tsu3_xlgmii_tx_tsu), 
    .nic_switch_mux_1_hlp_cgmii0_txclk_ena(nic_switch_mux_1_hlp_cgmii0_txclk_ena), 
    .pcs_mac_pipeline_top_wrap_mquad1_mac0_cgmii_tx_clkena(pcs_mac_pipeline_top_wrap_mquad1_mac0_cgmii_tx_clkena), 
    .nic_switch_mux_1_hlp_cgmii0_rxclk_ena(nic_switch_mux_1_hlp_cgmii0_rxclk_ena), 
    .pcs_mac_pipeline_top_wrap_mquad1_mac0_cgmii_rx_clkena(pcs_mac_pipeline_top_wrap_mquad1_mac0_cgmii_rx_clkena), 
    .nic_switch_mux_1_hlp_cgmii0_rxc(nic_switch_mux_1_hlp_cgmii0_rxc), 
    .pcs_mac_pipeline_top_wrap_mquad1_mac0_cgmii_rx_rxc(pcs_mac_pipeline_top_wrap_mquad1_mac0_cgmii_rx_rxc), 
    .nic_switch_mux_1_hlp_cgmii0_rxd(nic_switch_mux_1_hlp_cgmii0_rxd), 
    .pcs_mac_pipeline_top_wrap_mquad1_mac0_cgmii_rx_rxd(pcs_mac_pipeline_top_wrap_mquad1_mac0_cgmii_rx_rxd), 
    .hlp_cgmii0_txc_1(hlp_cgmii0_txc_1), 
    .pcs_mac_pipeline_top_wrap_mquad1_pcs0_cgmii_tx_txc(pcs_mac_pipeline_top_wrap_mquad1_pcs0_cgmii_tx_txc), 
    .hlp_cgmii0_txd_1(hlp_cgmii0_txd_1), 
    .pcs_mac_pipeline_top_wrap_mquad1_pcs0_cgmii_tx_txd(pcs_mac_pipeline_top_wrap_mquad1_pcs0_cgmii_tx_txd), 
    .nic_switch_mux_1_hlp_cgmii1_txclk_ena(nic_switch_mux_1_hlp_cgmii1_txclk_ena), 
    .pcs_mac_pipeline_top_wrap_mquad1_mac1_cgmii_tx_clkena(pcs_mac_pipeline_top_wrap_mquad1_mac1_cgmii_tx_clkena), 
    .nic_switch_mux_1_hlp_cgmii1_rxclk_ena(nic_switch_mux_1_hlp_cgmii1_rxclk_ena), 
    .pcs_mac_pipeline_top_wrap_mquad1_mac1_cgmii_rx_clkena(pcs_mac_pipeline_top_wrap_mquad1_mac1_cgmii_rx_clkena), 
    .nic_switch_mux_1_hlp_cgmii1_rxc(nic_switch_mux_1_hlp_cgmii1_rxc), 
    .pcs_mac_pipeline_top_wrap_mquad1_mac1_cgmii_rx_rxc(pcs_mac_pipeline_top_wrap_mquad1_mac1_cgmii_rx_rxc), 
    .nic_switch_mux_1_hlp_cgmii1_rxd(nic_switch_mux_1_hlp_cgmii1_rxd), 
    .pcs_mac_pipeline_top_wrap_mquad1_mac1_cgmii_rx_rxd(pcs_mac_pipeline_top_wrap_mquad1_mac1_cgmii_rx_rxd), 
    .hlp_cgmii1_txc_1(hlp_cgmii1_txc_1), 
    .pcs_mac_pipeline_top_wrap_mquad1_pcs1_cgmii_tx_txc(pcs_mac_pipeline_top_wrap_mquad1_pcs1_cgmii_tx_txc), 
    .hlp_cgmii1_txd_1(hlp_cgmii1_txd_1), 
    .pcs_mac_pipeline_top_wrap_mquad1_pcs1_cgmii_tx_txd(pcs_mac_pipeline_top_wrap_mquad1_pcs1_cgmii_tx_txd), 
    .nic_switch_mux_1_hlp_cgmii2_txclk_ena(nic_switch_mux_1_hlp_cgmii2_txclk_ena), 
    .pcs_mac_pipeline_top_wrap_mquad1_mac2_cgmii_tx_clkena(pcs_mac_pipeline_top_wrap_mquad1_mac2_cgmii_tx_clkena), 
    .nic_switch_mux_1_hlp_cgmii2_rxclk_ena(nic_switch_mux_1_hlp_cgmii2_rxclk_ena), 
    .pcs_mac_pipeline_top_wrap_mquad1_mac2_cgmii_rx_clkena(pcs_mac_pipeline_top_wrap_mquad1_mac2_cgmii_rx_clkena), 
    .nic_switch_mux_1_hlp_cgmii2_rxc(nic_switch_mux_1_hlp_cgmii2_rxc), 
    .pcs_mac_pipeline_top_wrap_mquad1_mac2_cgmii_rx_rxc(pcs_mac_pipeline_top_wrap_mquad1_mac2_cgmii_rx_rxc), 
    .nic_switch_mux_1_hlp_cgmii2_rxd(nic_switch_mux_1_hlp_cgmii2_rxd), 
    .pcs_mac_pipeline_top_wrap_mquad1_mac2_cgmii_rx_rxd(pcs_mac_pipeline_top_wrap_mquad1_mac2_cgmii_rx_rxd), 
    .hlp_cgmii2_txc_1(hlp_cgmii2_txc_1), 
    .pcs_mac_pipeline_top_wrap_mquad1_pcs2_cgmii_tx_txc(pcs_mac_pipeline_top_wrap_mquad1_pcs2_cgmii_tx_txc), 
    .hlp_cgmii2_txd_1(hlp_cgmii2_txd_1), 
    .pcs_mac_pipeline_top_wrap_mquad1_pcs2_cgmii_tx_txd(pcs_mac_pipeline_top_wrap_mquad1_pcs2_cgmii_tx_txd), 
    .nic_switch_mux_1_hlp_cgmii3_txclk_ena(nic_switch_mux_1_hlp_cgmii3_txclk_ena), 
    .pcs_mac_pipeline_top_wrap_mquad1_mac3_cgmii_tx_clkena(pcs_mac_pipeline_top_wrap_mquad1_mac3_cgmii_tx_clkena), 
    .nic_switch_mux_1_hlp_cgmii3_rxclk_ena(nic_switch_mux_1_hlp_cgmii3_rxclk_ena), 
    .pcs_mac_pipeline_top_wrap_mquad1_mac3_cgmii_rx_clkena(pcs_mac_pipeline_top_wrap_mquad1_mac3_cgmii_rx_clkena), 
    .nic_switch_mux_1_hlp_cgmii3_rxc(nic_switch_mux_1_hlp_cgmii3_rxc), 
    .pcs_mac_pipeline_top_wrap_mquad1_mac3_cgmii_rx_rxc(pcs_mac_pipeline_top_wrap_mquad1_mac3_cgmii_rx_rxc), 
    .nic_switch_mux_1_hlp_cgmii3_rxd(nic_switch_mux_1_hlp_cgmii3_rxd), 
    .pcs_mac_pipeline_top_wrap_mquad1_mac3_cgmii_rx_rxd(pcs_mac_pipeline_top_wrap_mquad1_mac3_cgmii_rx_rxd), 
    .hlp_cgmii3_txc_1(hlp_cgmii3_txc_1), 
    .pcs_mac_pipeline_top_wrap_mquad1_pcs3_cgmii_tx_txc(pcs_mac_pipeline_top_wrap_mquad1_pcs3_cgmii_tx_txc), 
    .hlp_cgmii3_txd_1(hlp_cgmii3_txd_1), 
    .pcs_mac_pipeline_top_wrap_mquad1_pcs3_cgmii_tx_txd(pcs_mac_pipeline_top_wrap_mquad1_pcs3_cgmii_tx_txd), 
    .pcs_mac_pipeline_top_wrap_pquad0_0_mac0_xlgmii_tx_clkena(pcs_mac_pipeline_top_wrap_pquad0_0_mac0_xlgmii_tx_clkena), 
    .pcs_mac_pipeline_top_wrap_pquad0_1_mac0_xlgmii_tx_clkena(pcs_mac_pipeline_top_wrap_pquad0_1_mac0_xlgmii_tx_clkena), 
    .pcs_mac_pipeline_top_wrap_pquad0_0_mac0_xlgmii_rx_clkena(pcs_mac_pipeline_top_wrap_pquad0_0_mac0_xlgmii_rx_clkena), 
    .pcs_mac_pipeline_top_wrap_pquad0_1_mac0_xlgmii_rx_clkena(pcs_mac_pipeline_top_wrap_pquad0_1_mac0_xlgmii_rx_clkena), 
    .pcs_mac_pipeline_top_wrap_pquad0_0_mac0_xlgmii_rx_rxc(pcs_mac_pipeline_top_wrap_pquad0_0_mac0_xlgmii_rx_rxc), 
    .pcs_mac_pipeline_top_wrap_pquad0_1_mac0_xlgmii_rx_rxc(pcs_mac_pipeline_top_wrap_pquad0_1_mac0_xlgmii_rx_rxc), 
    .pcs_mac_pipeline_top_wrap_pquad0_0_mac0_xlgmii_rx_rxd(pcs_mac_pipeline_top_wrap_pquad0_0_mac0_xlgmii_rx_rxd), 
    .pcs_mac_pipeline_top_wrap_pquad0_1_mac0_xlgmii_rx_rxd(pcs_mac_pipeline_top_wrap_pquad0_1_mac0_xlgmii_rx_rxd), 
    .pcs_mac_pipeline_top_wrap_pquad0_0_mac0_xlgmii_rxt0_next(pcs_mac_pipeline_top_wrap_pquad0_0_mac0_xlgmii_rxt0_next), 
    .pcs_mac_pipeline_top_wrap_pquad0_1_mac0_xlgmii_rxt0_next(pcs_mac_pipeline_top_wrap_pquad0_1_mac0_xlgmii_rxt0_next), 
    .hlp_xlgmii0_txc_2(hlp_xlgmii0_txc_2), 
    .pcs_mac_pipeline_top_wrap_pquad0_1_pcs0_xlgmii_tx_txc(pcs_mac_pipeline_top_wrap_pquad0_1_pcs0_xlgmii_tx_txc), 
    .hlp_xlgmii0_txd_2(hlp_xlgmii0_txd_2), 
    .pcs_mac_pipeline_top_wrap_pquad0_1_pcs0_xlgmii_tx_txd(pcs_mac_pipeline_top_wrap_pquad0_1_pcs0_xlgmii_tx_txd), 
    .pcs_mac_pipeline_top_wrap_pquad0_0_tsu0_xlgmii_rx_sd(pcs_mac_pipeline_top_wrap_pquad0_0_tsu0_xlgmii_rx_sd), 
    .pcs_mac_pipeline_top_wrap_pquad0_1_tsu0_xlgmii_rx_sd(pcs_mac_pipeline_top_wrap_pquad0_1_tsu0_xlgmii_rx_sd), 
    .pcs_mac_pipeline_top_wrap_pquad0_0_tsu0_xlgmii_rx_tsu(pcs_mac_pipeline_top_wrap_pquad0_0_tsu0_xlgmii_rx_tsu), 
    .pcs_mac_pipeline_top_wrap_pquad0_1_tsu0_xlgmii_rx_tsu(pcs_mac_pipeline_top_wrap_pquad0_1_tsu0_xlgmii_rx_tsu), 
    .pcs_mac_pipeline_top_wrap_pquad0_0_tsu0_xlgmii_tx_tsu(pcs_mac_pipeline_top_wrap_pquad0_0_tsu0_xlgmii_tx_tsu), 
    .pcs_mac_pipeline_top_wrap_pquad0_1_tsu0_xlgmii_tx_tsu(pcs_mac_pipeline_top_wrap_pquad0_1_tsu0_xlgmii_tx_tsu), 
    .pcs_mac_pipeline_top_wrap_pquad0_0_mac1_xlgmii_tx_clkena(pcs_mac_pipeline_top_wrap_pquad0_0_mac1_xlgmii_tx_clkena), 
    .pcs_mac_pipeline_top_wrap_pquad0_1_mac1_xlgmii_tx_clkena(pcs_mac_pipeline_top_wrap_pquad0_1_mac1_xlgmii_tx_clkena), 
    .pcs_mac_pipeline_top_wrap_pquad0_0_mac1_xlgmii_rx_clkena(pcs_mac_pipeline_top_wrap_pquad0_0_mac1_xlgmii_rx_clkena), 
    .pcs_mac_pipeline_top_wrap_pquad0_1_mac1_xlgmii_rx_clkena(pcs_mac_pipeline_top_wrap_pquad0_1_mac1_xlgmii_rx_clkena), 
    .pcs_mac_pipeline_top_wrap_pquad0_0_mac1_xlgmii_rx_rxc(pcs_mac_pipeline_top_wrap_pquad0_0_mac1_xlgmii_rx_rxc), 
    .pcs_mac_pipeline_top_wrap_pquad0_1_mac1_xlgmii_rx_rxc(pcs_mac_pipeline_top_wrap_pquad0_1_mac1_xlgmii_rx_rxc), 
    .pcs_mac_pipeline_top_wrap_pquad0_0_mac1_xlgmii_rx_rxd(pcs_mac_pipeline_top_wrap_pquad0_0_mac1_xlgmii_rx_rxd), 
    .pcs_mac_pipeline_top_wrap_pquad0_1_mac1_xlgmii_rx_rxd(pcs_mac_pipeline_top_wrap_pquad0_1_mac1_xlgmii_rx_rxd), 
    .pcs_mac_pipeline_top_wrap_pquad0_0_mac1_xlgmii_rxt0_next(pcs_mac_pipeline_top_wrap_pquad0_0_mac1_xlgmii_rxt0_next), 
    .pcs_mac_pipeline_top_wrap_pquad0_1_mac1_xlgmii_rxt0_next(pcs_mac_pipeline_top_wrap_pquad0_1_mac1_xlgmii_rxt0_next), 
    .hlp_xlgmii1_txc_2(hlp_xlgmii1_txc_2), 
    .pcs_mac_pipeline_top_wrap_pquad0_1_pcs1_xlgmii_tx_txc(pcs_mac_pipeline_top_wrap_pquad0_1_pcs1_xlgmii_tx_txc), 
    .hlp_xlgmii1_txd_2(hlp_xlgmii1_txd_2), 
    .pcs_mac_pipeline_top_wrap_pquad0_1_pcs1_xlgmii_tx_txd(pcs_mac_pipeline_top_wrap_pquad0_1_pcs1_xlgmii_tx_txd), 
    .pcs_mac_pipeline_top_wrap_pquad0_0_tsu1_xlgmii_rx_sd(pcs_mac_pipeline_top_wrap_pquad0_0_tsu1_xlgmii_rx_sd), 
    .pcs_mac_pipeline_top_wrap_pquad0_1_tsu1_xlgmii_rx_sd(pcs_mac_pipeline_top_wrap_pquad0_1_tsu1_xlgmii_rx_sd), 
    .pcs_mac_pipeline_top_wrap_pquad0_0_tsu1_xlgmii_rx_tsu(pcs_mac_pipeline_top_wrap_pquad0_0_tsu1_xlgmii_rx_tsu), 
    .pcs_mac_pipeline_top_wrap_pquad0_1_tsu1_xlgmii_rx_tsu(pcs_mac_pipeline_top_wrap_pquad0_1_tsu1_xlgmii_rx_tsu), 
    .pcs_mac_pipeline_top_wrap_pquad0_0_tsu1_xlgmii_tx_tsu(pcs_mac_pipeline_top_wrap_pquad0_0_tsu1_xlgmii_tx_tsu), 
    .pcs_mac_pipeline_top_wrap_pquad0_1_tsu1_xlgmii_tx_tsu(pcs_mac_pipeline_top_wrap_pquad0_1_tsu1_xlgmii_tx_tsu), 
    .pcs_mac_pipeline_top_wrap_pquad0_0_mac2_xlgmii_tx_clkena(pcs_mac_pipeline_top_wrap_pquad0_0_mac2_xlgmii_tx_clkena), 
    .pcs_mac_pipeline_top_wrap_pquad0_1_mac2_xlgmii_tx_clkena(pcs_mac_pipeline_top_wrap_pquad0_1_mac2_xlgmii_tx_clkena), 
    .pcs_mac_pipeline_top_wrap_pquad0_0_mac2_xlgmii_rx_clkena(pcs_mac_pipeline_top_wrap_pquad0_0_mac2_xlgmii_rx_clkena), 
    .pcs_mac_pipeline_top_wrap_pquad0_1_mac2_xlgmii_rx_clkena(pcs_mac_pipeline_top_wrap_pquad0_1_mac2_xlgmii_rx_clkena), 
    .pcs_mac_pipeline_top_wrap_pquad0_0_mac2_xlgmii_rx_rxc(pcs_mac_pipeline_top_wrap_pquad0_0_mac2_xlgmii_rx_rxc), 
    .pcs_mac_pipeline_top_wrap_pquad0_1_mac2_xlgmii_rx_rxc(pcs_mac_pipeline_top_wrap_pquad0_1_mac2_xlgmii_rx_rxc), 
    .pcs_mac_pipeline_top_wrap_pquad0_0_mac2_xlgmii_rx_rxd(pcs_mac_pipeline_top_wrap_pquad0_0_mac2_xlgmii_rx_rxd), 
    .pcs_mac_pipeline_top_wrap_pquad0_1_mac2_xlgmii_rx_rxd(pcs_mac_pipeline_top_wrap_pquad0_1_mac2_xlgmii_rx_rxd), 
    .pcs_mac_pipeline_top_wrap_pquad0_0_mac2_xlgmii_rxt0_next(pcs_mac_pipeline_top_wrap_pquad0_0_mac2_xlgmii_rxt0_next), 
    .pcs_mac_pipeline_top_wrap_pquad0_1_mac2_xlgmii_rxt0_next(pcs_mac_pipeline_top_wrap_pquad0_1_mac2_xlgmii_rxt0_next), 
    .hlp_xlgmii2_txc_2(hlp_xlgmii2_txc_2), 
    .pcs_mac_pipeline_top_wrap_pquad0_1_pcs2_xlgmii_tx_txc(pcs_mac_pipeline_top_wrap_pquad0_1_pcs2_xlgmii_tx_txc), 
    .hlp_xlgmii2_txd_2(hlp_xlgmii2_txd_2), 
    .pcs_mac_pipeline_top_wrap_pquad0_1_pcs2_xlgmii_tx_txd(pcs_mac_pipeline_top_wrap_pquad0_1_pcs2_xlgmii_tx_txd), 
    .pcs_mac_pipeline_top_wrap_pquad0_0_tsu2_xlgmii_rx_sd(pcs_mac_pipeline_top_wrap_pquad0_0_tsu2_xlgmii_rx_sd), 
    .pcs_mac_pipeline_top_wrap_pquad0_1_tsu2_xlgmii_rx_sd(pcs_mac_pipeline_top_wrap_pquad0_1_tsu2_xlgmii_rx_sd), 
    .pcs_mac_pipeline_top_wrap_pquad0_0_tsu2_xlgmii_rx_tsu(pcs_mac_pipeline_top_wrap_pquad0_0_tsu2_xlgmii_rx_tsu), 
    .pcs_mac_pipeline_top_wrap_pquad0_1_tsu2_xlgmii_rx_tsu(pcs_mac_pipeline_top_wrap_pquad0_1_tsu2_xlgmii_rx_tsu), 
    .pcs_mac_pipeline_top_wrap_pquad0_0_tsu2_xlgmii_tx_tsu(pcs_mac_pipeline_top_wrap_pquad0_0_tsu2_xlgmii_tx_tsu), 
    .pcs_mac_pipeline_top_wrap_pquad0_1_tsu2_xlgmii_tx_tsu(pcs_mac_pipeline_top_wrap_pquad0_1_tsu2_xlgmii_tx_tsu), 
    .pcs_mac_pipeline_top_wrap_pquad0_0_mac3_xlgmii_tx_clkena(pcs_mac_pipeline_top_wrap_pquad0_0_mac3_xlgmii_tx_clkena), 
    .pcs_mac_pipeline_top_wrap_pquad0_1_mac3_xlgmii_tx_clkena(pcs_mac_pipeline_top_wrap_pquad0_1_mac3_xlgmii_tx_clkena), 
    .pcs_mac_pipeline_top_wrap_pquad0_0_mac3_xlgmii_rx_clkena(pcs_mac_pipeline_top_wrap_pquad0_0_mac3_xlgmii_rx_clkena), 
    .pcs_mac_pipeline_top_wrap_pquad0_1_mac3_xlgmii_rx_clkena(pcs_mac_pipeline_top_wrap_pquad0_1_mac3_xlgmii_rx_clkena), 
    .pcs_mac_pipeline_top_wrap_pquad0_0_mac3_xlgmii_rx_rxc(pcs_mac_pipeline_top_wrap_pquad0_0_mac3_xlgmii_rx_rxc), 
    .pcs_mac_pipeline_top_wrap_pquad0_1_mac3_xlgmii_rx_rxc(pcs_mac_pipeline_top_wrap_pquad0_1_mac3_xlgmii_rx_rxc), 
    .pcs_mac_pipeline_top_wrap_pquad0_0_mac3_xlgmii_rx_rxd(pcs_mac_pipeline_top_wrap_pquad0_0_mac3_xlgmii_rx_rxd), 
    .pcs_mac_pipeline_top_wrap_pquad0_1_mac3_xlgmii_rx_rxd(pcs_mac_pipeline_top_wrap_pquad0_1_mac3_xlgmii_rx_rxd), 
    .pcs_mac_pipeline_top_wrap_pquad0_0_mac3_xlgmii_rxt0_next(pcs_mac_pipeline_top_wrap_pquad0_0_mac3_xlgmii_rxt0_next), 
    .pcs_mac_pipeline_top_wrap_pquad0_1_mac3_xlgmii_rxt0_next(pcs_mac_pipeline_top_wrap_pquad0_1_mac3_xlgmii_rxt0_next), 
    .hlp_xlgmii3_txc_2(hlp_xlgmii3_txc_2), 
    .pcs_mac_pipeline_top_wrap_pquad0_1_pcs3_xlgmii_tx_txc(pcs_mac_pipeline_top_wrap_pquad0_1_pcs3_xlgmii_tx_txc), 
    .hlp_xlgmii3_txd_2(hlp_xlgmii3_txd_2), 
    .pcs_mac_pipeline_top_wrap_pquad0_1_pcs3_xlgmii_tx_txd(pcs_mac_pipeline_top_wrap_pquad0_1_pcs3_xlgmii_tx_txd), 
    .pcs_mac_pipeline_top_wrap_pquad0_0_tsu3_xlgmii_rx_sd(pcs_mac_pipeline_top_wrap_pquad0_0_tsu3_xlgmii_rx_sd), 
    .pcs_mac_pipeline_top_wrap_pquad0_1_tsu3_xlgmii_rx_sd(pcs_mac_pipeline_top_wrap_pquad0_1_tsu3_xlgmii_rx_sd), 
    .pcs_mac_pipeline_top_wrap_pquad0_0_tsu3_xlgmii_rx_tsu(pcs_mac_pipeline_top_wrap_pquad0_0_tsu3_xlgmii_rx_tsu), 
    .pcs_mac_pipeline_top_wrap_pquad0_1_tsu3_xlgmii_rx_tsu(pcs_mac_pipeline_top_wrap_pquad0_1_tsu3_xlgmii_rx_tsu), 
    .pcs_mac_pipeline_top_wrap_pquad0_0_tsu3_xlgmii_tx_tsu(pcs_mac_pipeline_top_wrap_pquad0_0_tsu3_xlgmii_tx_tsu), 
    .pcs_mac_pipeline_top_wrap_pquad0_1_tsu3_xlgmii_tx_tsu(pcs_mac_pipeline_top_wrap_pquad0_1_tsu3_xlgmii_tx_tsu), 
    .pcs_mac_pipeline_top_wrap_pquad0_0_mac0_cgmii_tx_clkena(pcs_mac_pipeline_top_wrap_pquad0_0_mac0_cgmii_tx_clkena), 
    .pcs_mac_pipeline_top_wrap_pquad0_1_mac0_cgmii_tx_clkena(pcs_mac_pipeline_top_wrap_pquad0_1_mac0_cgmii_tx_clkena), 
    .pcs_mac_pipeline_top_wrap_pquad0_0_mac0_cgmii_rx_clkena(pcs_mac_pipeline_top_wrap_pquad0_0_mac0_cgmii_rx_clkena), 
    .pcs_mac_pipeline_top_wrap_pquad0_1_mac0_cgmii_rx_clkena(pcs_mac_pipeline_top_wrap_pquad0_1_mac0_cgmii_rx_clkena), 
    .pcs_mac_pipeline_top_wrap_pquad0_0_mac0_cgmii_rx_rxc(pcs_mac_pipeline_top_wrap_pquad0_0_mac0_cgmii_rx_rxc), 
    .pcs_mac_pipeline_top_wrap_pquad0_1_mac0_cgmii_rx_rxc(pcs_mac_pipeline_top_wrap_pquad0_1_mac0_cgmii_rx_rxc), 
    .pcs_mac_pipeline_top_wrap_pquad0_0_mac0_cgmii_rx_rxd(pcs_mac_pipeline_top_wrap_pquad0_0_mac0_cgmii_rx_rxd), 
    .pcs_mac_pipeline_top_wrap_pquad0_1_mac0_cgmii_rx_rxd(pcs_mac_pipeline_top_wrap_pquad0_1_mac0_cgmii_rx_rxd), 
    .hlp_cgmii0_txc_2(hlp_cgmii0_txc_2), 
    .pcs_mac_pipeline_top_wrap_pquad0_1_pcs0_cgmii_tx_txc(pcs_mac_pipeline_top_wrap_pquad0_1_pcs0_cgmii_tx_txc), 
    .hlp_cgmii0_txd_2(hlp_cgmii0_txd_2), 
    .pcs_mac_pipeline_top_wrap_pquad0_1_pcs0_cgmii_tx_txd(pcs_mac_pipeline_top_wrap_pquad0_1_pcs0_cgmii_tx_txd), 
    .pcs_mac_pipeline_top_wrap_pquad0_0_mac1_cgmii_tx_clkena(pcs_mac_pipeline_top_wrap_pquad0_0_mac1_cgmii_tx_clkena), 
    .pcs_mac_pipeline_top_wrap_pquad0_1_mac1_cgmii_tx_clkena(pcs_mac_pipeline_top_wrap_pquad0_1_mac1_cgmii_tx_clkena), 
    .pcs_mac_pipeline_top_wrap_pquad0_0_mac1_cgmii_rx_clkena(pcs_mac_pipeline_top_wrap_pquad0_0_mac1_cgmii_rx_clkena), 
    .pcs_mac_pipeline_top_wrap_pquad0_1_mac1_cgmii_rx_clkena(pcs_mac_pipeline_top_wrap_pquad0_1_mac1_cgmii_rx_clkena), 
    .pcs_mac_pipeline_top_wrap_pquad0_0_mac1_cgmii_rx_rxc(pcs_mac_pipeline_top_wrap_pquad0_0_mac1_cgmii_rx_rxc), 
    .pcs_mac_pipeline_top_wrap_pquad0_1_mac1_cgmii_rx_rxc(pcs_mac_pipeline_top_wrap_pquad0_1_mac1_cgmii_rx_rxc), 
    .pcs_mac_pipeline_top_wrap_pquad0_0_mac1_cgmii_rx_rxd(pcs_mac_pipeline_top_wrap_pquad0_0_mac1_cgmii_rx_rxd), 
    .pcs_mac_pipeline_top_wrap_pquad0_1_mac1_cgmii_rx_rxd(pcs_mac_pipeline_top_wrap_pquad0_1_mac1_cgmii_rx_rxd), 
    .hlp_cgmii1_txc_2(hlp_cgmii1_txc_2), 
    .pcs_mac_pipeline_top_wrap_pquad0_1_pcs1_cgmii_tx_txc(pcs_mac_pipeline_top_wrap_pquad0_1_pcs1_cgmii_tx_txc), 
    .hlp_cgmii1_txd_2(hlp_cgmii1_txd_2), 
    .pcs_mac_pipeline_top_wrap_pquad0_1_pcs1_cgmii_tx_txd(pcs_mac_pipeline_top_wrap_pquad0_1_pcs1_cgmii_tx_txd), 
    .pcs_mac_pipeline_top_wrap_pquad0_0_mac2_cgmii_tx_clkena(pcs_mac_pipeline_top_wrap_pquad0_0_mac2_cgmii_tx_clkena), 
    .pcs_mac_pipeline_top_wrap_pquad0_1_mac2_cgmii_tx_clkena(pcs_mac_pipeline_top_wrap_pquad0_1_mac2_cgmii_tx_clkena), 
    .pcs_mac_pipeline_top_wrap_pquad0_0_mac2_cgmii_rx_clkena(pcs_mac_pipeline_top_wrap_pquad0_0_mac2_cgmii_rx_clkena), 
    .pcs_mac_pipeline_top_wrap_pquad0_1_mac2_cgmii_rx_clkena(pcs_mac_pipeline_top_wrap_pquad0_1_mac2_cgmii_rx_clkena), 
    .pcs_mac_pipeline_top_wrap_pquad0_0_mac2_cgmii_rx_rxc(pcs_mac_pipeline_top_wrap_pquad0_0_mac2_cgmii_rx_rxc), 
    .pcs_mac_pipeline_top_wrap_pquad0_1_mac2_cgmii_rx_rxc(pcs_mac_pipeline_top_wrap_pquad0_1_mac2_cgmii_rx_rxc), 
    .pcs_mac_pipeline_top_wrap_pquad0_0_mac2_cgmii_rx_rxd(pcs_mac_pipeline_top_wrap_pquad0_0_mac2_cgmii_rx_rxd), 
    .pcs_mac_pipeline_top_wrap_pquad0_1_mac2_cgmii_rx_rxd(pcs_mac_pipeline_top_wrap_pquad0_1_mac2_cgmii_rx_rxd), 
    .hlp_cgmii2_txc_2(hlp_cgmii2_txc_2), 
    .pcs_mac_pipeline_top_wrap_pquad0_1_pcs2_cgmii_tx_txc(pcs_mac_pipeline_top_wrap_pquad0_1_pcs2_cgmii_tx_txc), 
    .hlp_cgmii2_txd_2(hlp_cgmii2_txd_2), 
    .pcs_mac_pipeline_top_wrap_pquad0_1_pcs2_cgmii_tx_txd(pcs_mac_pipeline_top_wrap_pquad0_1_pcs2_cgmii_tx_txd), 
    .pcs_mac_pipeline_top_wrap_pquad0_0_mac3_cgmii_tx_clkena(pcs_mac_pipeline_top_wrap_pquad0_0_mac3_cgmii_tx_clkena), 
    .pcs_mac_pipeline_top_wrap_pquad0_1_mac3_cgmii_tx_clkena(pcs_mac_pipeline_top_wrap_pquad0_1_mac3_cgmii_tx_clkena), 
    .pcs_mac_pipeline_top_wrap_pquad0_0_mac3_cgmii_rx_clkena(pcs_mac_pipeline_top_wrap_pquad0_0_mac3_cgmii_rx_clkena), 
    .pcs_mac_pipeline_top_wrap_pquad0_1_mac3_cgmii_rx_clkena(pcs_mac_pipeline_top_wrap_pquad0_1_mac3_cgmii_rx_clkena), 
    .pcs_mac_pipeline_top_wrap_pquad0_0_mac3_cgmii_rx_rxc(pcs_mac_pipeline_top_wrap_pquad0_0_mac3_cgmii_rx_rxc), 
    .pcs_mac_pipeline_top_wrap_pquad0_1_mac3_cgmii_rx_rxc(pcs_mac_pipeline_top_wrap_pquad0_1_mac3_cgmii_rx_rxc), 
    .pcs_mac_pipeline_top_wrap_pquad0_0_mac3_cgmii_rx_rxd(pcs_mac_pipeline_top_wrap_pquad0_0_mac3_cgmii_rx_rxd), 
    .pcs_mac_pipeline_top_wrap_pquad0_1_mac3_cgmii_rx_rxd(pcs_mac_pipeline_top_wrap_pquad0_1_mac3_cgmii_rx_rxd), 
    .hlp_cgmii3_txc_2(hlp_cgmii3_txc_2), 
    .pcs_mac_pipeline_top_wrap_pquad0_1_pcs3_cgmii_tx_txc(pcs_mac_pipeline_top_wrap_pquad0_1_pcs3_cgmii_tx_txc), 
    .hlp_cgmii3_txd_2(hlp_cgmii3_txd_2), 
    .pcs_mac_pipeline_top_wrap_pquad0_1_pcs3_cgmii_tx_txd(pcs_mac_pipeline_top_wrap_pquad0_1_pcs3_cgmii_tx_txd), 
    .pcs_mac_pipeline_top_wrap_pquad1_0_mac0_xlgmii_tx_clkena(pcs_mac_pipeline_top_wrap_pquad1_0_mac0_xlgmii_tx_clkena), 
    .pcs_mac_pipeline_top_wrap_pquad1_1_mac0_xlgmii_tx_clkena(pcs_mac_pipeline_top_wrap_pquad1_1_mac0_xlgmii_tx_clkena), 
    .pcs_mac_pipeline_top_wrap_pquad1_0_mac0_xlgmii_rx_clkena(pcs_mac_pipeline_top_wrap_pquad1_0_mac0_xlgmii_rx_clkena), 
    .pcs_mac_pipeline_top_wrap_pquad1_1_mac0_xlgmii_rx_clkena(pcs_mac_pipeline_top_wrap_pquad1_1_mac0_xlgmii_rx_clkena), 
    .pcs_mac_pipeline_top_wrap_pquad1_0_mac0_xlgmii_rx_rxc(pcs_mac_pipeline_top_wrap_pquad1_0_mac0_xlgmii_rx_rxc), 
    .pcs_mac_pipeline_top_wrap_pquad1_1_mac0_xlgmii_rx_rxc(pcs_mac_pipeline_top_wrap_pquad1_1_mac0_xlgmii_rx_rxc), 
    .pcs_mac_pipeline_top_wrap_pquad1_0_mac0_xlgmii_rx_rxd(pcs_mac_pipeline_top_wrap_pquad1_0_mac0_xlgmii_rx_rxd), 
    .pcs_mac_pipeline_top_wrap_pquad1_1_mac0_xlgmii_rx_rxd(pcs_mac_pipeline_top_wrap_pquad1_1_mac0_xlgmii_rx_rxd), 
    .pcs_mac_pipeline_top_wrap_pquad1_0_mac0_xlgmii_rxt0_next(pcs_mac_pipeline_top_wrap_pquad1_0_mac0_xlgmii_rxt0_next), 
    .pcs_mac_pipeline_top_wrap_pquad1_1_mac0_xlgmii_rxt0_next(pcs_mac_pipeline_top_wrap_pquad1_1_mac0_xlgmii_rxt0_next), 
    .hlp_xlgmii0_txc_3(hlp_xlgmii0_txc_3), 
    .pcs_mac_pipeline_top_wrap_pquad1_1_pcs0_xlgmii_tx_txc(pcs_mac_pipeline_top_wrap_pquad1_1_pcs0_xlgmii_tx_txc), 
    .hlp_xlgmii0_txd_3(hlp_xlgmii0_txd_3), 
    .pcs_mac_pipeline_top_wrap_pquad1_1_pcs0_xlgmii_tx_txd(pcs_mac_pipeline_top_wrap_pquad1_1_pcs0_xlgmii_tx_txd), 
    .pcs_mac_pipeline_top_wrap_pquad1_0_tsu0_xlgmii_rx_sd(pcs_mac_pipeline_top_wrap_pquad1_0_tsu0_xlgmii_rx_sd), 
    .pcs_mac_pipeline_top_wrap_pquad1_1_tsu0_xlgmii_rx_sd(pcs_mac_pipeline_top_wrap_pquad1_1_tsu0_xlgmii_rx_sd), 
    .pcs_mac_pipeline_top_wrap_pquad1_0_tsu0_xlgmii_rx_tsu(pcs_mac_pipeline_top_wrap_pquad1_0_tsu0_xlgmii_rx_tsu), 
    .pcs_mac_pipeline_top_wrap_pquad1_1_tsu0_xlgmii_rx_tsu(pcs_mac_pipeline_top_wrap_pquad1_1_tsu0_xlgmii_rx_tsu), 
    .pcs_mac_pipeline_top_wrap_pquad1_0_tsu0_xlgmii_tx_tsu(pcs_mac_pipeline_top_wrap_pquad1_0_tsu0_xlgmii_tx_tsu), 
    .pcs_mac_pipeline_top_wrap_pquad1_1_tsu0_xlgmii_tx_tsu(pcs_mac_pipeline_top_wrap_pquad1_1_tsu0_xlgmii_tx_tsu), 
    .pcs_mac_pipeline_top_wrap_pquad1_0_mac1_xlgmii_tx_clkena(pcs_mac_pipeline_top_wrap_pquad1_0_mac1_xlgmii_tx_clkena), 
    .pcs_mac_pipeline_top_wrap_pquad1_1_mac1_xlgmii_tx_clkena(pcs_mac_pipeline_top_wrap_pquad1_1_mac1_xlgmii_tx_clkena), 
    .pcs_mac_pipeline_top_wrap_pquad1_0_mac1_xlgmii_rx_clkena(pcs_mac_pipeline_top_wrap_pquad1_0_mac1_xlgmii_rx_clkena), 
    .pcs_mac_pipeline_top_wrap_pquad1_1_mac1_xlgmii_rx_clkena(pcs_mac_pipeline_top_wrap_pquad1_1_mac1_xlgmii_rx_clkena), 
    .pcs_mac_pipeline_top_wrap_pquad1_0_mac1_xlgmii_rx_rxc(pcs_mac_pipeline_top_wrap_pquad1_0_mac1_xlgmii_rx_rxc), 
    .pcs_mac_pipeline_top_wrap_pquad1_1_mac1_xlgmii_rx_rxc(pcs_mac_pipeline_top_wrap_pquad1_1_mac1_xlgmii_rx_rxc), 
    .pcs_mac_pipeline_top_wrap_pquad1_0_mac1_xlgmii_rx_rxd(pcs_mac_pipeline_top_wrap_pquad1_0_mac1_xlgmii_rx_rxd), 
    .pcs_mac_pipeline_top_wrap_pquad1_1_mac1_xlgmii_rx_rxd(pcs_mac_pipeline_top_wrap_pquad1_1_mac1_xlgmii_rx_rxd), 
    .pcs_mac_pipeline_top_wrap_pquad1_0_mac1_xlgmii_rxt0_next(pcs_mac_pipeline_top_wrap_pquad1_0_mac1_xlgmii_rxt0_next), 
    .pcs_mac_pipeline_top_wrap_pquad1_1_mac1_xlgmii_rxt0_next(pcs_mac_pipeline_top_wrap_pquad1_1_mac1_xlgmii_rxt0_next), 
    .hlp_xlgmii1_txc_3(hlp_xlgmii1_txc_3), 
    .pcs_mac_pipeline_top_wrap_pquad1_1_pcs1_xlgmii_tx_txc(pcs_mac_pipeline_top_wrap_pquad1_1_pcs1_xlgmii_tx_txc), 
    .hlp_xlgmii1_txd_3(hlp_xlgmii1_txd_3), 
    .pcs_mac_pipeline_top_wrap_pquad1_1_pcs1_xlgmii_tx_txd(pcs_mac_pipeline_top_wrap_pquad1_1_pcs1_xlgmii_tx_txd), 
    .pcs_mac_pipeline_top_wrap_pquad1_0_tsu1_xlgmii_rx_sd(pcs_mac_pipeline_top_wrap_pquad1_0_tsu1_xlgmii_rx_sd), 
    .pcs_mac_pipeline_top_wrap_pquad1_1_tsu1_xlgmii_rx_sd(pcs_mac_pipeline_top_wrap_pquad1_1_tsu1_xlgmii_rx_sd), 
    .pcs_mac_pipeline_top_wrap_pquad1_0_tsu1_xlgmii_rx_tsu(pcs_mac_pipeline_top_wrap_pquad1_0_tsu1_xlgmii_rx_tsu), 
    .pcs_mac_pipeline_top_wrap_pquad1_1_tsu1_xlgmii_rx_tsu(pcs_mac_pipeline_top_wrap_pquad1_1_tsu1_xlgmii_rx_tsu), 
    .pcs_mac_pipeline_top_wrap_pquad1_0_tsu1_xlgmii_tx_tsu(pcs_mac_pipeline_top_wrap_pquad1_0_tsu1_xlgmii_tx_tsu), 
    .pcs_mac_pipeline_top_wrap_pquad1_1_tsu1_xlgmii_tx_tsu(pcs_mac_pipeline_top_wrap_pquad1_1_tsu1_xlgmii_tx_tsu), 
    .pcs_mac_pipeline_top_wrap_pquad1_0_mac2_xlgmii_tx_clkena(pcs_mac_pipeline_top_wrap_pquad1_0_mac2_xlgmii_tx_clkena), 
    .pcs_mac_pipeline_top_wrap_pquad1_1_mac2_xlgmii_tx_clkena(pcs_mac_pipeline_top_wrap_pquad1_1_mac2_xlgmii_tx_clkena), 
    .pcs_mac_pipeline_top_wrap_pquad1_0_mac2_xlgmii_rx_clkena(pcs_mac_pipeline_top_wrap_pquad1_0_mac2_xlgmii_rx_clkena), 
    .pcs_mac_pipeline_top_wrap_pquad1_1_mac2_xlgmii_rx_clkena(pcs_mac_pipeline_top_wrap_pquad1_1_mac2_xlgmii_rx_clkena), 
    .pcs_mac_pipeline_top_wrap_pquad1_0_mac2_xlgmii_rx_rxc(pcs_mac_pipeline_top_wrap_pquad1_0_mac2_xlgmii_rx_rxc), 
    .pcs_mac_pipeline_top_wrap_pquad1_1_mac2_xlgmii_rx_rxc(pcs_mac_pipeline_top_wrap_pquad1_1_mac2_xlgmii_rx_rxc), 
    .pcs_mac_pipeline_top_wrap_pquad1_0_mac2_xlgmii_rx_rxd(pcs_mac_pipeline_top_wrap_pquad1_0_mac2_xlgmii_rx_rxd), 
    .pcs_mac_pipeline_top_wrap_pquad1_1_mac2_xlgmii_rx_rxd(pcs_mac_pipeline_top_wrap_pquad1_1_mac2_xlgmii_rx_rxd), 
    .pcs_mac_pipeline_top_wrap_pquad1_0_mac2_xlgmii_rxt0_next(pcs_mac_pipeline_top_wrap_pquad1_0_mac2_xlgmii_rxt0_next), 
    .pcs_mac_pipeline_top_wrap_pquad1_1_mac2_xlgmii_rxt0_next(pcs_mac_pipeline_top_wrap_pquad1_1_mac2_xlgmii_rxt0_next), 
    .hlp_xlgmii2_txc_3(hlp_xlgmii2_txc_3), 
    .pcs_mac_pipeline_top_wrap_pquad1_1_pcs2_xlgmii_tx_txc(pcs_mac_pipeline_top_wrap_pquad1_1_pcs2_xlgmii_tx_txc), 
    .hlp_xlgmii2_txd_3(hlp_xlgmii2_txd_3), 
    .pcs_mac_pipeline_top_wrap_pquad1_1_pcs2_xlgmii_tx_txd(pcs_mac_pipeline_top_wrap_pquad1_1_pcs2_xlgmii_tx_txd), 
    .pcs_mac_pipeline_top_wrap_pquad1_0_tsu2_xlgmii_rx_sd(pcs_mac_pipeline_top_wrap_pquad1_0_tsu2_xlgmii_rx_sd), 
    .pcs_mac_pipeline_top_wrap_pquad1_1_tsu2_xlgmii_rx_sd(pcs_mac_pipeline_top_wrap_pquad1_1_tsu2_xlgmii_rx_sd), 
    .pcs_mac_pipeline_top_wrap_pquad1_0_tsu2_xlgmii_rx_tsu(pcs_mac_pipeline_top_wrap_pquad1_0_tsu2_xlgmii_rx_tsu), 
    .pcs_mac_pipeline_top_wrap_pquad1_1_tsu2_xlgmii_rx_tsu(pcs_mac_pipeline_top_wrap_pquad1_1_tsu2_xlgmii_rx_tsu), 
    .pcs_mac_pipeline_top_wrap_pquad1_0_tsu2_xlgmii_tx_tsu(pcs_mac_pipeline_top_wrap_pquad1_0_tsu2_xlgmii_tx_tsu), 
    .pcs_mac_pipeline_top_wrap_pquad1_1_tsu2_xlgmii_tx_tsu(pcs_mac_pipeline_top_wrap_pquad1_1_tsu2_xlgmii_tx_tsu), 
    .pcs_mac_pipeline_top_wrap_pquad1_0_mac3_xlgmii_tx_clkena(pcs_mac_pipeline_top_wrap_pquad1_0_mac3_xlgmii_tx_clkena), 
    .pcs_mac_pipeline_top_wrap_pquad1_1_mac3_xlgmii_tx_clkena(pcs_mac_pipeline_top_wrap_pquad1_1_mac3_xlgmii_tx_clkena), 
    .pcs_mac_pipeline_top_wrap_pquad1_0_mac3_xlgmii_rx_clkena(pcs_mac_pipeline_top_wrap_pquad1_0_mac3_xlgmii_rx_clkena), 
    .pcs_mac_pipeline_top_wrap_pquad1_1_mac3_xlgmii_rx_clkena(pcs_mac_pipeline_top_wrap_pquad1_1_mac3_xlgmii_rx_clkena), 
    .pcs_mac_pipeline_top_wrap_pquad1_0_mac3_xlgmii_rx_rxc(pcs_mac_pipeline_top_wrap_pquad1_0_mac3_xlgmii_rx_rxc), 
    .pcs_mac_pipeline_top_wrap_pquad1_1_mac3_xlgmii_rx_rxc(pcs_mac_pipeline_top_wrap_pquad1_1_mac3_xlgmii_rx_rxc), 
    .pcs_mac_pipeline_top_wrap_pquad1_0_mac3_xlgmii_rx_rxd(pcs_mac_pipeline_top_wrap_pquad1_0_mac3_xlgmii_rx_rxd), 
    .pcs_mac_pipeline_top_wrap_pquad1_1_mac3_xlgmii_rx_rxd(pcs_mac_pipeline_top_wrap_pquad1_1_mac3_xlgmii_rx_rxd), 
    .pcs_mac_pipeline_top_wrap_pquad1_0_mac3_xlgmii_rxt0_next(pcs_mac_pipeline_top_wrap_pquad1_0_mac3_xlgmii_rxt0_next), 
    .pcs_mac_pipeline_top_wrap_pquad1_1_mac3_xlgmii_rxt0_next(pcs_mac_pipeline_top_wrap_pquad1_1_mac3_xlgmii_rxt0_next), 
    .hlp_xlgmii3_txc_3(hlp_xlgmii3_txc_3), 
    .pcs_mac_pipeline_top_wrap_pquad1_1_pcs3_xlgmii_tx_txc(pcs_mac_pipeline_top_wrap_pquad1_1_pcs3_xlgmii_tx_txc), 
    .hlp_xlgmii3_txd_3(hlp_xlgmii3_txd_3), 
    .pcs_mac_pipeline_top_wrap_pquad1_1_pcs3_xlgmii_tx_txd(pcs_mac_pipeline_top_wrap_pquad1_1_pcs3_xlgmii_tx_txd), 
    .pcs_mac_pipeline_top_wrap_pquad1_0_tsu3_xlgmii_rx_sd(pcs_mac_pipeline_top_wrap_pquad1_0_tsu3_xlgmii_rx_sd), 
    .pcs_mac_pipeline_top_wrap_pquad1_1_tsu3_xlgmii_rx_sd(pcs_mac_pipeline_top_wrap_pquad1_1_tsu3_xlgmii_rx_sd), 
    .pcs_mac_pipeline_top_wrap_pquad1_0_tsu3_xlgmii_rx_tsu(pcs_mac_pipeline_top_wrap_pquad1_0_tsu3_xlgmii_rx_tsu), 
    .pcs_mac_pipeline_top_wrap_pquad1_1_tsu3_xlgmii_rx_tsu(pcs_mac_pipeline_top_wrap_pquad1_1_tsu3_xlgmii_rx_tsu), 
    .pcs_mac_pipeline_top_wrap_pquad1_0_tsu3_xlgmii_tx_tsu(pcs_mac_pipeline_top_wrap_pquad1_0_tsu3_xlgmii_tx_tsu), 
    .pcs_mac_pipeline_top_wrap_pquad1_1_tsu3_xlgmii_tx_tsu(pcs_mac_pipeline_top_wrap_pquad1_1_tsu3_xlgmii_tx_tsu), 
    .pcs_mac_pipeline_top_wrap_pquad1_0_mac0_cgmii_tx_clkena(pcs_mac_pipeline_top_wrap_pquad1_0_mac0_cgmii_tx_clkena), 
    .pcs_mac_pipeline_top_wrap_pquad1_1_mac0_cgmii_tx_clkena(pcs_mac_pipeline_top_wrap_pquad1_1_mac0_cgmii_tx_clkena), 
    .pcs_mac_pipeline_top_wrap_pquad1_0_mac0_cgmii_rx_clkena(pcs_mac_pipeline_top_wrap_pquad1_0_mac0_cgmii_rx_clkena), 
    .pcs_mac_pipeline_top_wrap_pquad1_1_mac0_cgmii_rx_clkena(pcs_mac_pipeline_top_wrap_pquad1_1_mac0_cgmii_rx_clkena), 
    .pcs_mac_pipeline_top_wrap_pquad1_0_mac0_cgmii_rx_rxc(pcs_mac_pipeline_top_wrap_pquad1_0_mac0_cgmii_rx_rxc), 
    .pcs_mac_pipeline_top_wrap_pquad1_1_mac0_cgmii_rx_rxc(pcs_mac_pipeline_top_wrap_pquad1_1_mac0_cgmii_rx_rxc), 
    .pcs_mac_pipeline_top_wrap_pquad1_0_mac0_cgmii_rx_rxd(pcs_mac_pipeline_top_wrap_pquad1_0_mac0_cgmii_rx_rxd), 
    .pcs_mac_pipeline_top_wrap_pquad1_1_mac0_cgmii_rx_rxd(pcs_mac_pipeline_top_wrap_pquad1_1_mac0_cgmii_rx_rxd), 
    .hlp_cgmii0_txc_3(hlp_cgmii0_txc_3), 
    .pcs_mac_pipeline_top_wrap_pquad1_1_pcs0_cgmii_tx_txc(pcs_mac_pipeline_top_wrap_pquad1_1_pcs0_cgmii_tx_txc), 
    .hlp_cgmii0_txd_3(hlp_cgmii0_txd_3), 
    .pcs_mac_pipeline_top_wrap_pquad1_1_pcs0_cgmii_tx_txd(pcs_mac_pipeline_top_wrap_pquad1_1_pcs0_cgmii_tx_txd), 
    .pcs_mac_pipeline_top_wrap_pquad1_0_mac1_cgmii_tx_clkena(pcs_mac_pipeline_top_wrap_pquad1_0_mac1_cgmii_tx_clkena), 
    .pcs_mac_pipeline_top_wrap_pquad1_1_mac1_cgmii_tx_clkena(pcs_mac_pipeline_top_wrap_pquad1_1_mac1_cgmii_tx_clkena), 
    .pcs_mac_pipeline_top_wrap_pquad1_0_mac1_cgmii_rx_clkena(pcs_mac_pipeline_top_wrap_pquad1_0_mac1_cgmii_rx_clkena), 
    .pcs_mac_pipeline_top_wrap_pquad1_1_mac1_cgmii_rx_clkena(pcs_mac_pipeline_top_wrap_pquad1_1_mac1_cgmii_rx_clkena), 
    .pcs_mac_pipeline_top_wrap_pquad1_0_mac1_cgmii_rx_rxc(pcs_mac_pipeline_top_wrap_pquad1_0_mac1_cgmii_rx_rxc), 
    .pcs_mac_pipeline_top_wrap_pquad1_1_mac1_cgmii_rx_rxc(pcs_mac_pipeline_top_wrap_pquad1_1_mac1_cgmii_rx_rxc), 
    .pcs_mac_pipeline_top_wrap_pquad1_0_mac1_cgmii_rx_rxd(pcs_mac_pipeline_top_wrap_pquad1_0_mac1_cgmii_rx_rxd), 
    .pcs_mac_pipeline_top_wrap_pquad1_1_mac1_cgmii_rx_rxd(pcs_mac_pipeline_top_wrap_pquad1_1_mac1_cgmii_rx_rxd), 
    .hlp_cgmii1_txc_3(hlp_cgmii1_txc_3), 
    .pcs_mac_pipeline_top_wrap_pquad1_1_pcs1_cgmii_tx_txc(pcs_mac_pipeline_top_wrap_pquad1_1_pcs1_cgmii_tx_txc), 
    .hlp_cgmii1_txd_3(hlp_cgmii1_txd_3), 
    .pcs_mac_pipeline_top_wrap_pquad1_1_pcs1_cgmii_tx_txd(pcs_mac_pipeline_top_wrap_pquad1_1_pcs1_cgmii_tx_txd), 
    .pcs_mac_pipeline_top_wrap_pquad1_0_mac2_cgmii_tx_clkena(pcs_mac_pipeline_top_wrap_pquad1_0_mac2_cgmii_tx_clkena), 
    .pcs_mac_pipeline_top_wrap_pquad1_1_mac2_cgmii_tx_clkena(pcs_mac_pipeline_top_wrap_pquad1_1_mac2_cgmii_tx_clkena), 
    .pcs_mac_pipeline_top_wrap_pquad1_0_mac2_cgmii_rx_clkena(pcs_mac_pipeline_top_wrap_pquad1_0_mac2_cgmii_rx_clkena), 
    .pcs_mac_pipeline_top_wrap_pquad1_1_mac2_cgmii_rx_clkena(pcs_mac_pipeline_top_wrap_pquad1_1_mac2_cgmii_rx_clkena), 
    .pcs_mac_pipeline_top_wrap_pquad1_0_mac2_cgmii_rx_rxc(pcs_mac_pipeline_top_wrap_pquad1_0_mac2_cgmii_rx_rxc), 
    .pcs_mac_pipeline_top_wrap_pquad1_1_mac2_cgmii_rx_rxc(pcs_mac_pipeline_top_wrap_pquad1_1_mac2_cgmii_rx_rxc), 
    .pcs_mac_pipeline_top_wrap_pquad1_0_mac2_cgmii_rx_rxd(pcs_mac_pipeline_top_wrap_pquad1_0_mac2_cgmii_rx_rxd), 
    .pcs_mac_pipeline_top_wrap_pquad1_1_mac2_cgmii_rx_rxd(pcs_mac_pipeline_top_wrap_pquad1_1_mac2_cgmii_rx_rxd), 
    .hlp_cgmii2_txc_3(hlp_cgmii2_txc_3), 
    .pcs_mac_pipeline_top_wrap_pquad1_1_pcs2_cgmii_tx_txc(pcs_mac_pipeline_top_wrap_pquad1_1_pcs2_cgmii_tx_txc), 
    .hlp_cgmii2_txd_3(hlp_cgmii2_txd_3), 
    .pcs_mac_pipeline_top_wrap_pquad1_1_pcs2_cgmii_tx_txd(pcs_mac_pipeline_top_wrap_pquad1_1_pcs2_cgmii_tx_txd), 
    .pcs_mac_pipeline_top_wrap_pquad1_0_mac3_cgmii_tx_clkena(pcs_mac_pipeline_top_wrap_pquad1_0_mac3_cgmii_tx_clkena), 
    .pcs_mac_pipeline_top_wrap_pquad1_1_mac3_cgmii_tx_clkena(pcs_mac_pipeline_top_wrap_pquad1_1_mac3_cgmii_tx_clkena), 
    .pcs_mac_pipeline_top_wrap_pquad1_0_mac3_cgmii_rx_clkena(pcs_mac_pipeline_top_wrap_pquad1_0_mac3_cgmii_rx_clkena), 
    .pcs_mac_pipeline_top_wrap_pquad1_1_mac3_cgmii_rx_clkena(pcs_mac_pipeline_top_wrap_pquad1_1_mac3_cgmii_rx_clkena), 
    .pcs_mac_pipeline_top_wrap_pquad1_0_mac3_cgmii_rx_rxc(pcs_mac_pipeline_top_wrap_pquad1_0_mac3_cgmii_rx_rxc), 
    .pcs_mac_pipeline_top_wrap_pquad1_1_mac3_cgmii_rx_rxc(pcs_mac_pipeline_top_wrap_pquad1_1_mac3_cgmii_rx_rxc), 
    .pcs_mac_pipeline_top_wrap_pquad1_0_mac3_cgmii_rx_rxd(pcs_mac_pipeline_top_wrap_pquad1_0_mac3_cgmii_rx_rxd), 
    .pcs_mac_pipeline_top_wrap_pquad1_1_mac3_cgmii_rx_rxd(pcs_mac_pipeline_top_wrap_pquad1_1_mac3_cgmii_rx_rxd), 
    .hlp_cgmii3_txc_3(hlp_cgmii3_txc_3), 
    .pcs_mac_pipeline_top_wrap_pquad1_1_pcs3_cgmii_tx_txc(pcs_mac_pipeline_top_wrap_pquad1_1_pcs3_cgmii_tx_txc), 
    .hlp_cgmii3_txd_3(hlp_cgmii3_txd_3), 
    .pcs_mac_pipeline_top_wrap_pquad1_1_pcs3_cgmii_tx_txd(pcs_mac_pipeline_top_wrap_pquad1_1_pcs3_cgmii_tx_txd), 
    .physs_mux_800G_sd0_tx_data_o(physs_mux_800G_sd0_tx_data_o), 
    .physs_pipeline_reg_800g_misc_0_data_out(physs_pipeline_reg_800g_misc_0_data_out), 
    .physs_mux_800G_sd1_tx_data_o(physs_mux_800G_sd1_tx_data_o), 
    .physs_pipeline_reg_800g_misc_1_data_out(physs_pipeline_reg_800g_misc_1_data_out), 
    .physs_mux_800G_sd2_tx_data_o(physs_mux_800G_sd2_tx_data_o), 
    .physs_pipeline_reg_800g_misc_2_data_out(physs_pipeline_reg_800g_misc_2_data_out), 
    .physs_mux_800G_sd3_tx_data_o(physs_mux_800G_sd3_tx_data_o), 
    .physs_pipeline_reg_800g_misc_3_data_out(physs_pipeline_reg_800g_misc_3_data_out), 
    .physs_mux_800G_sd4_tx_data_o(physs_mux_800G_sd4_tx_data_o), 
    .physs_pipeline_reg_800g_misc_4_data_out(physs_pipeline_reg_800g_misc_4_data_out), 
    .physs_mux_800G_sd5_tx_data_o(physs_mux_800G_sd5_tx_data_o), 
    .physs_pipeline_reg_800g_misc_5_data_out(physs_pipeline_reg_800g_misc_5_data_out), 
    .physs_mux_800G_sd6_tx_data_o(physs_mux_800G_sd6_tx_data_o), 
    .physs_pipeline_reg_800g_misc_6_data_out(physs_pipeline_reg_800g_misc_6_data_out), 
    .physs_mux_800G_sd7_tx_data_o(physs_mux_800G_sd7_tx_data_o), 
    .physs_pipeline_reg_800g_misc_7_data_out(physs_pipeline_reg_800g_misc_7_data_out), 
    .physs_pipeline_reg_800g_8_data_out(physs_pipeline_reg_800g_8_data_out), 
    .physs_pipeline_reg_800g_misc_8_data_out(physs_pipeline_reg_800g_misc_8_data_out), 
    .physs_pipeline_reg_800g_9_data_out(physs_pipeline_reg_800g_9_data_out), 
    .physs_pipeline_reg_800g_misc_9_data_out(physs_pipeline_reg_800g_misc_9_data_out), 
    .physs_pipeline_reg_800g_10_data_out(physs_pipeline_reg_800g_10_data_out), 
    .physs_pipeline_reg_800g_misc_10_data_out(physs_pipeline_reg_800g_misc_10_data_out), 
    .physs_pipeline_reg_800g_11_data_out(physs_pipeline_reg_800g_11_data_out), 
    .physs_pipeline_reg_800g_misc_11_data_out(physs_pipeline_reg_800g_misc_11_data_out), 
    .physs_pipeline_reg_800g_12_data_out(physs_pipeline_reg_800g_12_data_out), 
    .physs_pipeline_reg_800g_misc_12_data_out(physs_pipeline_reg_800g_misc_12_data_out), 
    .physs_pipeline_reg_800g_13_data_out(physs_pipeline_reg_800g_13_data_out), 
    .physs_pipeline_reg_800g_misc_13_data_out(physs_pipeline_reg_800g_misc_13_data_out), 
    .physs_pipeline_reg_800g_14_data_out(physs_pipeline_reg_800g_14_data_out), 
    .physs_pipeline_reg_800g_misc_14_data_out(physs_pipeline_reg_800g_misc_14_data_out), 
    .physs_pipeline_reg_800g_15_data_out(physs_pipeline_reg_800g_15_data_out), 
    .physs_pipeline_reg_800g_misc_15_data_out(physs_pipeline_reg_800g_misc_15_data_out), 
    .fifo_mux_0_physs_icq_port_0_link_stat_0(fifo_mux_0_physs_icq_port_0_link_stat_0), 
    .fifo_mux_0_physs_mse_port_0_link_speed(fifo_mux_0_physs_mse_port_0_link_speed), 
    .fifo_mux_0_physs_mse_port_0_rx_data(fifo_mux_0_physs_mse_port_0_rx_data), 
    .fifo_mux_0_physs_mse_port_0_rx_sop_0(fifo_mux_0_physs_mse_port_0_rx_sop_0), 
    .fifo_mux_0_physs_mse_port_0_rx_eop_0(fifo_mux_0_physs_mse_port_0_rx_eop_0), 
    .fifo_mux_0_physs_mse_port_0_rx_mod(fifo_mux_0_physs_mse_port_0_rx_mod), 
    .fifo_mux_0_physs_mse_port_0_rx_err(fifo_mux_0_physs_mse_port_0_rx_err), 
    .fifo_mux_0_physs_mse_port_0_rx_ecc_err(fifo_mux_0_physs_mse_port_0_rx_ecc_err), 
    .fifo_mux_0_physs_mse_port_0_rx_ts(fifo_mux_0_physs_mse_port_0_rx_ts), 
    .fifo_mux_0_physs_mse_port_0_pfc_mode(fifo_mux_0_physs_mse_port_0_pfc_mode), 
    .fifo_mux_0_physs_icq_port_1_link_stat_0(fifo_mux_0_physs_icq_port_1_link_stat_0), 
    .fifo_mux_0_physs_mse_port_1_link_speed(fifo_mux_0_physs_mse_port_1_link_speed), 
    .fifo_mux_0_physs_mse_port_1_rx_data(fifo_mux_0_physs_mse_port_1_rx_data), 
    .fifo_mux_0_physs_mse_port_1_rx_sop_0(fifo_mux_0_physs_mse_port_1_rx_sop_0), 
    .fifo_mux_0_physs_mse_port_1_rx_eop_0(fifo_mux_0_physs_mse_port_1_rx_eop_0), 
    .fifo_mux_0_physs_mse_port_1_rx_mod(fifo_mux_0_physs_mse_port_1_rx_mod), 
    .fifo_mux_0_physs_mse_port_1_rx_err(fifo_mux_0_physs_mse_port_1_rx_err), 
    .fifo_mux_0_physs_mse_port_1_rx_ecc_err(fifo_mux_0_physs_mse_port_1_rx_ecc_err), 
    .fifo_mux_0_physs_mse_port_1_rx_ts(fifo_mux_0_physs_mse_port_1_rx_ts), 
    .fifo_top_mux_0_mse_physs_port_1_tx_data(fifo_top_mux_0_mse_physs_port_1_tx_data), 
    .fifo_top_mux_0_mse_physs_port_1_ts_capture_vld(fifo_top_mux_0_mse_physs_port_1_ts_capture_vld), 
    .fifo_top_mux_0_mse_physs_port_1_ts_capture_idx(fifo_top_mux_0_mse_physs_port_1_ts_capture_idx), 
    .fifo_top_mux_0_mse_physs_port_1_tx_mod(fifo_top_mux_0_mse_physs_port_1_tx_mod), 
    .fifo_top_mux_0_mse_physs_port_1_tx_err(fifo_top_mux_0_mse_physs_port_1_tx_err), 
    .fifo_top_mux_0_mse_physs_port_1_tx_crc(fifo_top_mux_0_mse_physs_port_1_tx_crc), 
    .fifo_mux_0_physs_mse_port_1_pfc_mode(fifo_mux_0_physs_mse_port_1_pfc_mode), 
    .fifo_mux_0_physs_icq_port_2_link_stat_0(fifo_mux_0_physs_icq_port_2_link_stat_0), 
    .fifo_mux_0_physs_mse_port_2_link_speed(fifo_mux_0_physs_mse_port_2_link_speed), 
    .fifo_mux_0_physs_mse_port_2_rx_data(fifo_mux_0_physs_mse_port_2_rx_data), 
    .fifo_mux_0_physs_mse_port_2_rx_sop_0(fifo_mux_0_physs_mse_port_2_rx_sop_0), 
    .fifo_mux_0_physs_mse_port_2_rx_eop_0(fifo_mux_0_physs_mse_port_2_rx_eop_0), 
    .fifo_mux_0_physs_mse_port_2_rx_mod(fifo_mux_0_physs_mse_port_2_rx_mod), 
    .fifo_mux_0_physs_mse_port_2_rx_err(fifo_mux_0_physs_mse_port_2_rx_err), 
    .fifo_mux_0_physs_mse_port_2_rx_ecc_err(fifo_mux_0_physs_mse_port_2_rx_ecc_err), 
    .fifo_mux_0_physs_mse_port_2_rx_ts(fifo_mux_0_physs_mse_port_2_rx_ts), 
    .fifo_top_mux_0_mse_physs_port_2_tx_data(fifo_top_mux_0_mse_physs_port_2_tx_data), 
    .fifo_top_mux_0_mse_physs_port_2_ts_capture_vld(fifo_top_mux_0_mse_physs_port_2_ts_capture_vld), 
    .fifo_top_mux_0_mse_physs_port_2_ts_capture_idx(fifo_top_mux_0_mse_physs_port_2_ts_capture_idx), 
    .fifo_top_mux_0_mse_physs_port_2_tx_mod(fifo_top_mux_0_mse_physs_port_2_tx_mod), 
    .fifo_top_mux_0_mse_physs_port_2_tx_err(fifo_top_mux_0_mse_physs_port_2_tx_err), 
    .fifo_top_mux_0_mse_physs_port_2_tx_crc(fifo_top_mux_0_mse_physs_port_2_tx_crc), 
    .fifo_mux_0_physs_mse_port_2_pfc_mode(fifo_mux_0_physs_mse_port_2_pfc_mode), 
    .fifo_mux_0_physs_icq_port_3_link_stat_0(fifo_mux_0_physs_icq_port_3_link_stat_0), 
    .fifo_mux_0_physs_mse_port_3_link_speed(fifo_mux_0_physs_mse_port_3_link_speed), 
    .fifo_mux_0_physs_mse_port_3_rx_data(fifo_mux_0_physs_mse_port_3_rx_data), 
    .fifo_mux_0_physs_mse_port_3_rx_sop_0(fifo_mux_0_physs_mse_port_3_rx_sop_0), 
    .fifo_mux_0_physs_mse_port_3_rx_eop_0(fifo_mux_0_physs_mse_port_3_rx_eop_0), 
    .fifo_mux_0_physs_mse_port_3_rx_mod(fifo_mux_0_physs_mse_port_3_rx_mod), 
    .fifo_mux_0_physs_mse_port_3_rx_err(fifo_mux_0_physs_mse_port_3_rx_err), 
    .fifo_mux_0_physs_mse_port_3_rx_ecc_err(fifo_mux_0_physs_mse_port_3_rx_ecc_err), 
    .fifo_mux_0_physs_mse_port_3_rx_ts(fifo_mux_0_physs_mse_port_3_rx_ts), 
    .fifo_top_mux_0_mse_physs_port_3_tx_data(fifo_top_mux_0_mse_physs_port_3_tx_data), 
    .fifo_top_mux_0_mse_physs_port_3_ts_capture_vld(fifo_top_mux_0_mse_physs_port_3_ts_capture_vld), 
    .fifo_top_mux_0_mse_physs_port_3_ts_capture_idx(fifo_top_mux_0_mse_physs_port_3_ts_capture_idx), 
    .fifo_top_mux_0_mse_physs_port_3_tx_mod(fifo_top_mux_0_mse_physs_port_3_tx_mod), 
    .fifo_top_mux_0_mse_physs_port_3_tx_err(fifo_top_mux_0_mse_physs_port_3_tx_err), 
    .fifo_top_mux_0_mse_physs_port_3_tx_crc(fifo_top_mux_0_mse_physs_port_3_tx_crc), 
    .fifo_mux_0_physs_mse_port_3_pfc_mode(fifo_mux_0_physs_mse_port_3_pfc_mode), 
    .fifo_mux_1_physs_icq_port_0_link_stat_0(fifo_mux_1_physs_icq_port_0_link_stat_0), 
    .fifo_mux_1_physs_mse_port_0_link_speed(fifo_mux_1_physs_mse_port_0_link_speed), 
    .fifo_mux_1_physs_mse_port_0_rx_data(fifo_mux_1_physs_mse_port_0_rx_data), 
    .fifo_mux_1_physs_mse_port_0_rx_sop_0(fifo_mux_1_physs_mse_port_0_rx_sop_0), 
    .fifo_mux_1_physs_mse_port_0_rx_eop_0(fifo_mux_1_physs_mse_port_0_rx_eop_0), 
    .fifo_mux_1_physs_mse_port_0_rx_mod(fifo_mux_1_physs_mse_port_0_rx_mod), 
    .fifo_mux_1_physs_mse_port_0_rx_err(fifo_mux_1_physs_mse_port_0_rx_err), 
    .fifo_mux_1_physs_mse_port_0_rx_ecc_err(fifo_mux_1_physs_mse_port_0_rx_ecc_err), 
    .fifo_mux_1_physs_mse_port_0_rx_ts(fifo_mux_1_physs_mse_port_0_rx_ts), 
    .fifo_top_mux_0_mse_physs_port_4_tx_data(fifo_top_mux_0_mse_physs_port_4_tx_data), 
    .fifo_top_mux_0_mse_physs_port_4_ts_capture_vld(fifo_top_mux_0_mse_physs_port_4_ts_capture_vld), 
    .fifo_top_mux_0_mse_physs_port_4_ts_capture_idx(fifo_top_mux_0_mse_physs_port_4_ts_capture_idx), 
    .fifo_top_mux_0_mse_physs_port_4_tx_mod(fifo_top_mux_0_mse_physs_port_4_tx_mod), 
    .fifo_top_mux_0_mse_physs_port_4_tx_err(fifo_top_mux_0_mse_physs_port_4_tx_err), 
    .fifo_top_mux_0_mse_physs_port_4_tx_crc(fifo_top_mux_0_mse_physs_port_4_tx_crc), 
    .fifo_mux_1_physs_mse_port_0_pfc_mode(fifo_mux_1_physs_mse_port_0_pfc_mode), 
    .fifo_mux_1_physs_icq_port_1_link_stat_0(fifo_mux_1_physs_icq_port_1_link_stat_0), 
    .fifo_mux_1_physs_mse_port_1_link_speed(fifo_mux_1_physs_mse_port_1_link_speed), 
    .fifo_mux_1_physs_mse_port_1_rx_data(fifo_mux_1_physs_mse_port_1_rx_data), 
    .fifo_mux_1_physs_mse_port_1_rx_sop_0(fifo_mux_1_physs_mse_port_1_rx_sop_0), 
    .fifo_mux_1_physs_mse_port_1_rx_eop_0(fifo_mux_1_physs_mse_port_1_rx_eop_0), 
    .fifo_mux_1_physs_mse_port_1_rx_mod(fifo_mux_1_physs_mse_port_1_rx_mod), 
    .fifo_mux_1_physs_mse_port_1_rx_err(fifo_mux_1_physs_mse_port_1_rx_err), 
    .fifo_mux_1_physs_mse_port_1_rx_ecc_err(fifo_mux_1_physs_mse_port_1_rx_ecc_err), 
    .fifo_mux_1_physs_mse_port_1_rx_ts(fifo_mux_1_physs_mse_port_1_rx_ts), 
    .fifo_top_mux_0_mse_physs_port_5_tx_data(fifo_top_mux_0_mse_physs_port_5_tx_data), 
    .fifo_top_mux_0_mse_physs_port_5_ts_capture_vld(fifo_top_mux_0_mse_physs_port_5_ts_capture_vld), 
    .fifo_top_mux_0_mse_physs_port_5_ts_capture_idx(fifo_top_mux_0_mse_physs_port_5_ts_capture_idx), 
    .fifo_top_mux_0_mse_physs_port_5_tx_mod(fifo_top_mux_0_mse_physs_port_5_tx_mod), 
    .fifo_top_mux_0_mse_physs_port_5_tx_err(fifo_top_mux_0_mse_physs_port_5_tx_err), 
    .fifo_top_mux_0_mse_physs_port_5_tx_crc(fifo_top_mux_0_mse_physs_port_5_tx_crc), 
    .fifo_mux_1_physs_mse_port_1_pfc_mode(fifo_mux_1_physs_mse_port_1_pfc_mode), 
    .fifo_mux_1_physs_icq_port_2_link_stat_0(fifo_mux_1_physs_icq_port_2_link_stat_0), 
    .fifo_mux_1_physs_mse_port_2_link_speed(fifo_mux_1_physs_mse_port_2_link_speed), 
    .fifo_mux_1_physs_mse_port_2_rx_data(fifo_mux_1_physs_mse_port_2_rx_data), 
    .fifo_mux_1_physs_mse_port_2_rx_sop_0(fifo_mux_1_physs_mse_port_2_rx_sop_0), 
    .fifo_mux_1_physs_mse_port_2_rx_eop_0(fifo_mux_1_physs_mse_port_2_rx_eop_0), 
    .fifo_mux_1_physs_mse_port_2_rx_mod(fifo_mux_1_physs_mse_port_2_rx_mod), 
    .fifo_mux_1_physs_mse_port_2_rx_err(fifo_mux_1_physs_mse_port_2_rx_err), 
    .fifo_mux_1_physs_mse_port_2_rx_ecc_err(fifo_mux_1_physs_mse_port_2_rx_ecc_err), 
    .fifo_mux_1_physs_mse_port_2_rx_ts(fifo_mux_1_physs_mse_port_2_rx_ts), 
    .fifo_top_mux_0_mse_physs_port_6_tx_data(fifo_top_mux_0_mse_physs_port_6_tx_data), 
    .fifo_top_mux_0_mse_physs_port_6_ts_capture_vld(fifo_top_mux_0_mse_physs_port_6_ts_capture_vld), 
    .fifo_top_mux_0_mse_physs_port_6_ts_capture_idx(fifo_top_mux_0_mse_physs_port_6_ts_capture_idx), 
    .fifo_top_mux_0_mse_physs_port_6_tx_mod(fifo_top_mux_0_mse_physs_port_6_tx_mod), 
    .fifo_top_mux_0_mse_physs_port_6_tx_err(fifo_top_mux_0_mse_physs_port_6_tx_err), 
    .fifo_top_mux_0_mse_physs_port_6_tx_crc(fifo_top_mux_0_mse_physs_port_6_tx_crc), 
    .fifo_mux_1_physs_mse_port_2_pfc_mode(fifo_mux_1_physs_mse_port_2_pfc_mode), 
    .fifo_mux_1_physs_icq_port_3_link_stat_0(fifo_mux_1_physs_icq_port_3_link_stat_0), 
    .fifo_mux_1_physs_mse_port_3_link_speed(fifo_mux_1_physs_mse_port_3_link_speed), 
    .fifo_mux_1_physs_mse_port_3_rx_data(fifo_mux_1_physs_mse_port_3_rx_data), 
    .fifo_mux_1_physs_mse_port_3_rx_sop_0(fifo_mux_1_physs_mse_port_3_rx_sop_0), 
    .fifo_mux_1_physs_mse_port_3_rx_eop_0(fifo_mux_1_physs_mse_port_3_rx_eop_0), 
    .fifo_mux_1_physs_mse_port_3_rx_mod(fifo_mux_1_physs_mse_port_3_rx_mod), 
    .fifo_mux_1_physs_mse_port_3_rx_err(fifo_mux_1_physs_mse_port_3_rx_err), 
    .fifo_mux_1_physs_mse_port_3_rx_ecc_err(fifo_mux_1_physs_mse_port_3_rx_ecc_err), 
    .fifo_mux_1_physs_mse_port_3_rx_ts(fifo_mux_1_physs_mse_port_3_rx_ts), 
    .fifo_top_mux_0_mse_physs_port_7_tx_data(fifo_top_mux_0_mse_physs_port_7_tx_data), 
    .fifo_top_mux_0_mse_physs_port_7_ts_capture_vld(fifo_top_mux_0_mse_physs_port_7_ts_capture_vld), 
    .fifo_top_mux_0_mse_physs_port_7_ts_capture_idx(fifo_top_mux_0_mse_physs_port_7_ts_capture_idx), 
    .fifo_top_mux_0_mse_physs_port_7_tx_mod(fifo_top_mux_0_mse_physs_port_7_tx_mod), 
    .fifo_top_mux_0_mse_physs_port_7_tx_err(fifo_top_mux_0_mse_physs_port_7_tx_err), 
    .fifo_top_mux_0_mse_physs_port_7_tx_crc(fifo_top_mux_0_mse_physs_port_7_tx_crc), 
    .fifo_mux_1_physs_mse_port_3_pfc_mode(fifo_mux_1_physs_mse_port_3_pfc_mode), 
    .nic400_physs_0_awaddr_master_quad0_out(nic400_physs_0_awaddr_master_quad0_out), 
    .nic400_physs_0_awlen_master_quad0(nic400_physs_0_awlen_master_quad0), 
    .nic400_physs_0_awsize_master_quad0(nic400_physs_0_awsize_master_quad0), 
    .nic400_physs_0_awburst_master_quad0(nic400_physs_0_awburst_master_quad0), 
    .nic400_physs_0_awlock_master_quad0(nic400_physs_0_awlock_master_quad0), 
    .nic400_physs_0_awcache_master_quad0(nic400_physs_0_awcache_master_quad0), 
    .nic400_physs_0_awprot_master_quad0(nic400_physs_0_awprot_master_quad0), 
    .nic400_physs_0_awvalid_master_quad0(nic400_physs_0_awvalid_master_quad0), 
    .nic400_quad_0_awready_slave_quad_if0(nic400_quad_0_awready_slave_quad_if0), 
    .nic400_physs_0_wdata_master_quad0(nic400_physs_0_wdata_master_quad0), 
    .nic400_physs_0_wstrb_master_quad0(nic400_physs_0_wstrb_master_quad0), 
    .nic400_physs_0_wlast_master_quad0(nic400_physs_0_wlast_master_quad0), 
    .nic400_physs_0_wvalid_master_quad0(nic400_physs_0_wvalid_master_quad0), 
    .nic400_quad_0_wready_slave_quad_if0(nic400_quad_0_wready_slave_quad_if0), 
    .nic400_quad_0_bresp_slave_quad_if0(nic400_quad_0_bresp_slave_quad_if0), 
    .nic400_quad_0_bvalid_slave_quad_if0(nic400_quad_0_bvalid_slave_quad_if0), 
    .nic400_physs_0_bready_master_quad0(nic400_physs_0_bready_master_quad0), 
    .nic400_physs_0_araddr_master_quad0_out(nic400_physs_0_araddr_master_quad0_out), 
    .nic400_physs_0_arlen_master_quad0(nic400_physs_0_arlen_master_quad0), 
    .nic400_physs_0_arsize_master_quad0(nic400_physs_0_arsize_master_quad0), 
    .nic400_physs_0_arburst_master_quad0(nic400_physs_0_arburst_master_quad0), 
    .nic400_physs_0_arlock_master_quad0(nic400_physs_0_arlock_master_quad0), 
    .nic400_physs_0_arcache_master_quad0(nic400_physs_0_arcache_master_quad0), 
    .nic400_physs_0_arprot_master_quad0(nic400_physs_0_arprot_master_quad0), 
    .nic400_physs_0_arvalid_master_quad0(nic400_physs_0_arvalid_master_quad0), 
    .nic400_quad_0_arready_slave_quad_if0(nic400_quad_0_arready_slave_quad_if0), 
    .nic400_quad_0_rdata_slave_quad_if0(nic400_quad_0_rdata_slave_quad_if0), 
    .nic400_quad_0_rresp_slave_quad_if0(nic400_quad_0_rresp_slave_quad_if0), 
    .nic400_quad_0_rlast_slave_quad_if0(nic400_quad_0_rlast_slave_quad_if0), 
    .nic400_quad_0_rvalid_slave_quad_if0(nic400_quad_0_rvalid_slave_quad_if0), 
    .nic400_physs_0_rready_master_quad0(nic400_physs_0_rready_master_quad0), 
    .nic400_physs_0_awid_master_quad0(nic400_physs_0_awid_master_quad0), 
    .nic400_physs_0_arid_master_quad0(nic400_physs_0_arid_master_quad0), 
    .nic400_quad_0_rid_slave_quad_if0(nic400_quad_0_rid_slave_quad_if0), 
    .nic400_quad_0_bid_slave_quad_if0(nic400_quad_0_bid_slave_quad_if0), 
    .nic400_physs_0_awaddr_master_quad1_out(nic400_physs_0_awaddr_master_quad1_out), 
    .nic400_physs_0_awlen_master_quad1(nic400_physs_0_awlen_master_quad1), 
    .nic400_physs_0_awsize_master_quad1(nic400_physs_0_awsize_master_quad1), 
    .nic400_physs_0_awburst_master_quad1(nic400_physs_0_awburst_master_quad1), 
    .nic400_physs_0_awlock_master_quad1(nic400_physs_0_awlock_master_quad1), 
    .nic400_physs_0_awcache_master_quad1(nic400_physs_0_awcache_master_quad1), 
    .nic400_physs_0_awprot_master_quad1(nic400_physs_0_awprot_master_quad1), 
    .nic400_physs_0_awvalid_master_quad1(nic400_physs_0_awvalid_master_quad1), 
    .nic400_quad_1_awready_slave_quad_if0(nic400_quad_1_awready_slave_quad_if0), 
    .nic400_physs_0_wdata_master_quad1(nic400_physs_0_wdata_master_quad1), 
    .nic400_physs_0_wstrb_master_quad1(nic400_physs_0_wstrb_master_quad1), 
    .nic400_physs_0_wlast_master_quad1(nic400_physs_0_wlast_master_quad1), 
    .nic400_physs_0_wvalid_master_quad1(nic400_physs_0_wvalid_master_quad1), 
    .nic400_quad_1_wready_slave_quad_if0(nic400_quad_1_wready_slave_quad_if0), 
    .nic400_quad_1_bresp_slave_quad_if0(nic400_quad_1_bresp_slave_quad_if0), 
    .nic400_quad_1_bvalid_slave_quad_if0(nic400_quad_1_bvalid_slave_quad_if0), 
    .nic400_physs_0_bready_master_quad1(nic400_physs_0_bready_master_quad1), 
    .nic400_physs_0_araddr_master_quad1_out(nic400_physs_0_araddr_master_quad1_out), 
    .nic400_physs_0_arlen_master_quad1(nic400_physs_0_arlen_master_quad1), 
    .nic400_physs_0_arsize_master_quad1(nic400_physs_0_arsize_master_quad1), 
    .nic400_physs_0_arburst_master_quad1(nic400_physs_0_arburst_master_quad1), 
    .nic400_physs_0_arlock_master_quad1(nic400_physs_0_arlock_master_quad1), 
    .nic400_physs_0_arcache_master_quad1(nic400_physs_0_arcache_master_quad1), 
    .nic400_physs_0_arprot_master_quad1(nic400_physs_0_arprot_master_quad1), 
    .nic400_physs_0_arvalid_master_quad1(nic400_physs_0_arvalid_master_quad1), 
    .nic400_quad_1_arready_slave_quad_if0(nic400_quad_1_arready_slave_quad_if0), 
    .nic400_quad_1_rdata_slave_quad_if0(nic400_quad_1_rdata_slave_quad_if0), 
    .nic400_quad_1_rresp_slave_quad_if0(nic400_quad_1_rresp_slave_quad_if0), 
    .nic400_quad_1_rlast_slave_quad_if0(nic400_quad_1_rlast_slave_quad_if0), 
    .nic400_quad_1_rvalid_slave_quad_if0(nic400_quad_1_rvalid_slave_quad_if0), 
    .nic400_physs_0_rready_master_quad1(nic400_physs_0_rready_master_quad1), 
    .nic400_physs_0_awid_master_quad1(nic400_physs_0_awid_master_quad1), 
    .nic400_physs_0_arid_master_quad1(nic400_physs_0_arid_master_quad1), 
    .nic400_quad_1_rid_slave_quad_if0(nic400_quad_1_rid_slave_quad_if0), 
    .nic400_quad_1_bid_slave_quad_if0(nic400_quad_1_bid_slave_quad_if0), 
    .physs_0_AWID(physs_0_AWID), 
    .physs_0_AWADDR(physs_0_AWADDR), 
    .physs_0_AWLEN(physs_0_AWLEN), 
    .physs_0_AWSIZE(physs_0_AWSIZE), 
    .physs_0_AWBURST(physs_0_AWBURST), 
    .physs_0_AWLOCK(physs_0_AWLOCK), 
    .physs_0_AWCACHE(physs_0_AWCACHE), 
    .physs_0_AWPROT(physs_0_AWPROT), 
    .physs_0_AWVALID(physs_0_AWVALID), 
    .physs_0_WDATA(physs_0_WDATA), 
    .physs_0_WSTRB(physs_0_WSTRB), 
    .physs_0_WLAST(physs_0_WLAST), 
    .physs_0_WVALID(physs_0_WVALID), 
    .physs_0_BREADY(physs_0_BREADY), 
    .physs_0_ARID(physs_0_ARID), 
    .physs_0_ARADDR(physs_0_ARADDR), 
    .physs_0_ARLEN(physs_0_ARLEN), 
    .physs_0_ARSIZE(physs_0_ARSIZE), 
    .physs_0_ARBURST(physs_0_ARBURST), 
    .physs_0_ARLOCK(physs_0_ARLOCK), 
    .physs_0_ARCACHE(physs_0_ARCACHE), 
    .physs_0_ARPROT(physs_0_ARPROT), 
    .physs_0_ARVALID(physs_0_ARVALID), 
    .nic400_physs_0_awready_slave_physs(nic400_physs_0_awready_slave_physs), 
    .nic400_physs_0_wready_slave_physs(nic400_physs_0_wready_slave_physs), 
    .physs_0_RREADY(physs_0_RREADY), 
    .nic400_physs_0_bid_slave_physs(nic400_physs_0_bid_slave_physs), 
    .nic400_physs_0_bresp_slave_physs(nic400_physs_0_bresp_slave_physs), 
    .nic400_physs_0_bvalid_slave_physs(nic400_physs_0_bvalid_slave_physs), 
    .nic400_physs_0_arready_slave_physs(nic400_physs_0_arready_slave_physs), 
    .nic400_physs_0_rid_slave_physs(nic400_physs_0_rid_slave_physs), 
    .nic400_physs_0_rdata_slave_physs(nic400_physs_0_rdata_slave_physs), 
    .nic400_physs_0_rresp_slave_physs(nic400_physs_0_rresp_slave_physs), 
    .nic400_physs_0_rlast_slave_physs(nic400_physs_0_rlast_slave_physs), 
    .nic400_physs_0_rvalid_slave_physs(nic400_physs_0_rvalid_slave_physs), 
    .nic400_physs_0_hselx_mac800(nic400_physs_0_hselx_mac800), 
    .nic400_physs_0_haddr_mac800_out(nic400_physs_0_haddr_mac800_out), 
    .nic400_physs_0_htrans_mac800(nic400_physs_0_htrans_mac800), 
    .nic400_physs_0_hwrite_mac800(nic400_physs_0_hwrite_mac800), 
    .nic400_physs_0_hsize_mac800(nic400_physs_0_hsize_mac800), 
    .nic400_physs_0_hwdata_mac800(nic400_physs_0_hwdata_mac800), 
    .nic400_physs_0_hready_mac800(nic400_physs_0_hready_mac800), 
    .mac800_ahb_bridge_0_hrdata(mac800_ahb_bridge_0_hrdata), 
    .mac800_ahb_bridge_0_hresp(mac800_ahb_bridge_0_hresp), 
    .mac800_ahb_bridge_0_hreadyout(mac800_ahb_bridge_0_hreadyout), 
    .nic400_physs_0_hburst_mac800(nic400_physs_0_hburst_mac800), 
    .nic400_physs_0_hselx_macstats800(nic400_physs_0_hselx_macstats800), 
    .nic400_physs_0_haddr_macstats800_out(nic400_physs_0_haddr_macstats800_out), 
    .nic400_physs_0_htrans_macstats800(nic400_physs_0_htrans_macstats800), 
    .nic400_physs_0_hwrite_macstats800(nic400_physs_0_hwrite_macstats800), 
    .nic400_physs_0_hsize_macstats800(nic400_physs_0_hsize_macstats800), 
    .nic400_physs_0_hwdata_macstats800(nic400_physs_0_hwdata_macstats800), 
    .nic400_physs_0_hready_macstats800(nic400_physs_0_hready_macstats800), 
    .macstats800_ahb_bridge_0_hrdata(macstats800_ahb_bridge_0_hrdata), 
    .macstats800_ahb_bridge_0_hresp(macstats800_ahb_bridge_0_hresp), 
    .macstats800_ahb_bridge_0_hreadyout(macstats800_ahb_bridge_0_hreadyout), 
    .nic400_physs_0_hburst_macstats800(nic400_physs_0_hburst_macstats800), 
    .nic400_physs_0_hselx_pcs800(nic400_physs_0_hselx_pcs800), 
    .nic400_physs_0_haddr_pcs800_out(nic400_physs_0_haddr_pcs800_out), 
    .nic400_physs_0_htrans_pcs800(nic400_physs_0_htrans_pcs800), 
    .nic400_physs_0_hwrite_pcs800(nic400_physs_0_hwrite_pcs800), 
    .nic400_physs_0_hsize_pcs800(nic400_physs_0_hsize_pcs800), 
    .nic400_physs_0_hwdata_pcs800(nic400_physs_0_hwdata_pcs800), 
    .nic400_physs_0_hready_pcs800(nic400_physs_0_hready_pcs800), 
    .pcs800_ahb_bridge_0_hrdata(pcs800_ahb_bridge_0_hrdata), 
    .pcs800_ahb_bridge_0_hresp(pcs800_ahb_bridge_0_hresp), 
    .pcs800_ahb_bridge_0_hreadyout(pcs800_ahb_bridge_0_hreadyout), 
    .nic400_physs_0_hburst_pcs800(nic400_physs_0_hburst_pcs800), 
    .nic400_physs_0_hselx_tsu800(nic400_physs_0_hselx_tsu800), 
    .nic400_physs_0_haddr_tsu800_out(nic400_physs_0_haddr_tsu800_out), 
    .nic400_physs_0_htrans_tsu800(nic400_physs_0_htrans_tsu800), 
    .nic400_physs_0_hwrite_tsu800(nic400_physs_0_hwrite_tsu800), 
    .nic400_physs_0_hsize_tsu800(nic400_physs_0_hsize_tsu800), 
    .nic400_physs_0_hwdata_tsu800(nic400_physs_0_hwdata_tsu800), 
    .nic400_physs_0_hready_tsu800(nic400_physs_0_hready_tsu800), 
    .tsu800_ahb_bridge_0_hrdata(tsu800_ahb_bridge_0_hrdata), 
    .tsu800_ahb_bridge_0_hresp(tsu800_ahb_bridge_0_hresp), 
    .tsu800_ahb_bridge_0_hreadyout(tsu800_ahb_bridge_0_hreadyout), 
    .nic400_physs_0_hburst_tsu800(nic400_physs_0_hburst_tsu800), 
    .nic400_physs_0_hreadyout_slave_quad0(nic400_physs_0_hreadyout_slave_quad0), 
    .nic400_physs_0_hresp_slave_quad0(nic400_physs_0_hresp_slave_quad0), 
    .nic400_physs_0_hrdata_slave_quad0(nic400_physs_0_hrdata_slave_quad0), 
    .nic400_quad_0_hselx_master_physs(nic400_quad_0_hselx_master_physs), 
    .nic400_quad_0_haddr_master_physs_out(nic400_quad_0_haddr_master_physs_out), 
    .nic400_quad_0_hwrite_master_physs(nic400_quad_0_hwrite_master_physs), 
    .nic400_quad_0_htrans_master_physs(nic400_quad_0_htrans_master_physs), 
    .nic400_quad_0_hsize_master_physs(nic400_quad_0_hsize_master_physs), 
    .nic400_quad_0_hburst_master_physs(nic400_quad_0_hburst_master_physs), 
    .nic400_quad_0_hprot_master_physs(nic400_quad_0_hprot_master_physs), 
    .nic400_quad_0_hready_master_physs(nic400_quad_0_hready_master_physs), 
    .nic400_quad_0_hwdata_master_physs(nic400_quad_0_hwdata_master_physs), 
    .nic400_physs_0_hreadyout_slave_quad1(nic400_physs_0_hreadyout_slave_quad1), 
    .nic400_physs_0_hresp_slave_quad1(nic400_physs_0_hresp_slave_quad1), 
    .nic400_physs_0_hrdata_slave_quad1(nic400_physs_0_hrdata_slave_quad1), 
    .nic400_quad_1_hselx_master_physs(nic400_quad_1_hselx_master_physs), 
    .nic400_quad_1_haddr_master_physs_out(nic400_quad_1_haddr_master_physs_out), 
    .nic400_quad_1_hwrite_master_physs(nic400_quad_1_hwrite_master_physs), 
    .nic400_quad_1_htrans_master_physs(nic400_quad_1_htrans_master_physs), 
    .nic400_quad_1_hsize_master_physs(nic400_quad_1_hsize_master_physs), 
    .nic400_quad_1_hburst_master_physs(nic400_quad_1_hburst_master_physs), 
    .nic400_quad_1_hprot_master_physs(nic400_quad_1_hprot_master_physs), 
    .nic400_quad_1_hready_master_physs(nic400_quad_1_hready_master_physs), 
    .nic400_quad_1_hwdata_master_physs(nic400_quad_1_hwdata_master_physs), 
    .socviewpin_32to1digimux_00_outmux(socviewpin_32to1digimux_00_outmux), 
    .socviewpin_32to1digimux_01_outmux(socviewpin_32to1digimux_01_outmux), 
    .socviewpin_32to1digimux_10_outmux(socviewpin_32to1digimux_10_outmux), 
    .socviewpin_32to1digimux_11_outmux(socviewpin_32to1digimux_11_outmux), 
    .socviewpin_4to1digimux_0_outmux(socviewpin_4to1digimux_0_outmux), 
    .physs_registers_wrapper_0_viewpin_mux_select_2(physs_registers_wrapper_0_viewpin_mux_select_2), 
    .physs_registers_wrapper_0_viewpin_mux_en_2(physs_registers_wrapper_0_viewpin_mux_en_2), 
    .physs_registers_wrapper_1_viewpin_mux_select_2(physs_registers_wrapper_1_viewpin_mux_select_2), 
    .physs_registers_wrapper_1_viewpin_mux_en_2(physs_registers_wrapper_1_viewpin_mux_en_2), 
    .quad_interrupts_0_ts_int_imc_o(quad_interrupts_0_ts_int_imc_o), 
    .quad_interrupts_1_ts_int_imc_o(quad_interrupts_1_ts_int_imc_o), 
    .parmisc_int_logic_0_o(parmisc_int_logic_0_o), 
    .BSCAN_PIPE_OUT_1_scan_in(parmisc_physs0_BSCAN_PIPE_OUT_1_scan_in), 
    .BSCAN_PIPE_OUT_2_scan_in(parmisc_physs0_BSCAN_PIPE_OUT_2_scan_in), 
    .BSCAN_PIPE_OUT_TO_parmisc_physs1_scan_in(parmisc_physs0_BSCAN_PIPE_OUT_TO_parmisc_physs1_scan_in), 
    .BSCAN_PIPE_IN_FROM_parmisc_physs1_scan_out(parmisc_physs1_BSCAN_PIPE_OUT_scan_out), 
    .BSCAN_PIPE_OUT_TO_parmisc_physs1_force_disable(parmisc_physs0_BSCAN_PIPE_OUT_TO_parmisc_physs1_force_disable), 
    .BSCAN_PIPE_OUT_TO_parmisc_physs1_select_jtag_input(parmisc_physs0_BSCAN_PIPE_OUT_TO_parmisc_physs1_select_jtag_input), 
    .BSCAN_PIPE_OUT_TO_parmisc_physs1_select_jtag_output(parmisc_physs0_BSCAN_PIPE_OUT_TO_parmisc_physs1_select_jtag_output), 
    .BSCAN_PIPE_OUT_TO_parmisc_physs1_ac_init_clock0(parmisc_physs0_BSCAN_PIPE_OUT_TO_parmisc_physs1_ac_init_clock0), 
    .BSCAN_PIPE_OUT_TO_parmisc_physs1_ac_init_clock1(parmisc_physs0_BSCAN_PIPE_OUT_TO_parmisc_physs1_ac_init_clock1), 
    .BSCAN_PIPE_OUT_TO_parmisc_physs1_ac_signal(parmisc_physs0_BSCAN_PIPE_OUT_TO_parmisc_physs1_ac_signal), 
    .BSCAN_PIPE_OUT_TO_parmisc_physs1_ac_mode_en(parmisc_physs0_BSCAN_PIPE_OUT_TO_parmisc_physs1_ac_mode_en), 
    .BSCAN_PIPE_OUT_TO_parmisc_physs1_intel_update_clk(parmisc_physs0_BSCAN_PIPE_OUT_TO_parmisc_physs1_intel_update_clk), 
    .BSCAN_PIPE_OUT_TO_parmisc_physs1_intel_clamp_en(parmisc_physs0_BSCAN_PIPE_OUT_TO_parmisc_physs1_intel_clamp_en), 
    .BSCAN_PIPE_OUT_TO_parmisc_physs1_intel_bscan_mode(parmisc_physs0_BSCAN_PIPE_OUT_TO_parmisc_physs1_intel_bscan_mode), 
    .BSCAN_PIPE_OUT_TO_parmisc_physs1_select(parmisc_physs0_BSCAN_PIPE_OUT_TO_parmisc_physs1_select), 
    .BSCAN_PIPE_OUT_TO_parmisc_physs1_bscan_clock(parmisc_physs0_BSCAN_PIPE_OUT_TO_parmisc_physs1_bscan_clock), 
    .BSCAN_PIPE_OUT_TO_parmisc_physs1_capture_en(parmisc_physs0_BSCAN_PIPE_OUT_TO_parmisc_physs1_capture_en), 
    .BSCAN_PIPE_OUT_TO_parmisc_physs1_shift_en(parmisc_physs0_BSCAN_PIPE_OUT_TO_parmisc_physs1_shift_en), 
    .BSCAN_PIPE_OUT_TO_parmisc_physs1_update_en(parmisc_physs0_BSCAN_PIPE_OUT_TO_parmisc_physs1_update_en), 
    .BSCAN_PIPE_IN_1_scan_out(parmquad0_BSCAN_PIPE_OUT_1_scan_out), 
    .BSCAN_PIPE_OUT_1_force_disable(parmisc_physs0_BSCAN_PIPE_OUT_1_force_disable), 
    .BSCAN_PIPE_OUT_1_select_jtag_input(parmisc_physs0_BSCAN_PIPE_OUT_1_select_jtag_input), 
    .BSCAN_PIPE_OUT_1_select_jtag_output(parmisc_physs0_BSCAN_PIPE_OUT_1_select_jtag_output), 
    .BSCAN_PIPE_OUT_1_ac_init_clock0(parmisc_physs0_BSCAN_PIPE_OUT_1_ac_init_clock0), 
    .BSCAN_PIPE_OUT_1_ac_init_clock1(parmisc_physs0_BSCAN_PIPE_OUT_1_ac_init_clock1), 
    .BSCAN_PIPE_OUT_1_ac_signal(parmisc_physs0_BSCAN_PIPE_OUT_1_ac_signal), 
    .BSCAN_PIPE_OUT_1_ac_mode_en(parmisc_physs0_BSCAN_PIPE_OUT_1_ac_mode_en), 
    .BSCAN_PIPE_OUT_1_intel_update_clk(parmisc_physs0_BSCAN_PIPE_OUT_1_intel_update_clk), 
    .BSCAN_PIPE_OUT_1_intel_clamp_en(parmisc_physs0_BSCAN_PIPE_OUT_1_intel_clamp_en), 
    .BSCAN_PIPE_OUT_1_intel_bscan_mode(parmisc_physs0_BSCAN_PIPE_OUT_1_intel_bscan_mode), 
    .BSCAN_PIPE_OUT_1_select(parmisc_physs0_BSCAN_PIPE_OUT_1_select), 
    .BSCAN_PIPE_OUT_1_bscan_clock(parmisc_physs0_BSCAN_PIPE_OUT_1_bscan_clock), 
    .BSCAN_PIPE_OUT_1_capture_en(parmisc_physs0_BSCAN_PIPE_OUT_1_capture_en), 
    .BSCAN_PIPE_OUT_1_shift_en(parmisc_physs0_BSCAN_PIPE_OUT_1_shift_en), 
    .BSCAN_PIPE_OUT_1_update_en(parmisc_physs0_BSCAN_PIPE_OUT_1_update_en), 
    .BSCAN_PIPE_IN_2_scan_out(parmquad1_BSCAN_PIPE_OUT_2_scan_out), 
    .BSCAN_PIPE_OUT_2_force_disable(parmisc_physs0_BSCAN_PIPE_OUT_2_force_disable), 
    .BSCAN_PIPE_OUT_2_select_jtag_input(parmisc_physs0_BSCAN_PIPE_OUT_2_select_jtag_input), 
    .BSCAN_PIPE_OUT_2_select_jtag_output(parmisc_physs0_BSCAN_PIPE_OUT_2_select_jtag_output), 
    .BSCAN_PIPE_OUT_2_ac_init_clock0(parmisc_physs0_BSCAN_PIPE_OUT_2_ac_init_clock0), 
    .BSCAN_PIPE_OUT_2_ac_init_clock1(parmisc_physs0_BSCAN_PIPE_OUT_2_ac_init_clock1), 
    .BSCAN_PIPE_OUT_2_ac_signal(parmisc_physs0_BSCAN_PIPE_OUT_2_ac_signal), 
    .BSCAN_PIPE_OUT_2_ac_mode_en(parmisc_physs0_BSCAN_PIPE_OUT_2_ac_mode_en), 
    .BSCAN_PIPE_OUT_2_intel_update_clk(parmisc_physs0_BSCAN_PIPE_OUT_2_intel_update_clk), 
    .BSCAN_PIPE_OUT_2_intel_clamp_en(parmisc_physs0_BSCAN_PIPE_OUT_2_intel_clamp_en), 
    .BSCAN_PIPE_OUT_2_intel_bscan_mode(parmisc_physs0_BSCAN_PIPE_OUT_2_intel_bscan_mode), 
    .BSCAN_PIPE_OUT_2_select(parmisc_physs0_BSCAN_PIPE_OUT_2_select), 
    .BSCAN_PIPE_OUT_2_bscan_clock(parmisc_physs0_BSCAN_PIPE_OUT_2_bscan_clock), 
    .BSCAN_PIPE_OUT_2_capture_en(parmisc_physs0_BSCAN_PIPE_OUT_2_capture_en), 
    .BSCAN_PIPE_OUT_2_shift_en(parmisc_physs0_BSCAN_PIPE_OUT_2_shift_en), 
    .BSCAN_PIPE_OUT_2_update_en(parmisc_physs0_BSCAN_PIPE_OUT_2_update_en), 
    .BSCAN_bypass_bypass_parmisc_physs0_c1(PHYSS_BSCAN_BYPASS_7), 
    .BSCAN_bypass_bypass_parmisc_physs0_c2(PHYSS_BSCAN_BYPASS_8), 
    .BSCAN_PIPE_IN_bscan_clock(BSCAN_PIPE_IN_1_bscan_clock), 
    .BSCAN_PIPE_IN_select(BSCAN_PIPE_IN_1_select), 
    .BSCAN_PIPE_IN_capture_en(BSCAN_PIPE_IN_1_capture_en), 
    .BSCAN_PIPE_IN_shift_en(BSCAN_PIPE_IN_1_shift_en), 
    .BSCAN_PIPE_IN_update_en(BSCAN_PIPE_IN_1_update_en), 
    .BSCAN_PIPE_IN_scan_in(BSCAN_PIPE_IN_1_scan_in), 
    .BSCAN_PIPE_IN_ac_signal(BSCAN_PIPE_IN_1_ac_signal), 
    .BSCAN_PIPE_IN_ac_init_clock0(BSCAN_PIPE_IN_1_ac_init_clock0), 
    .BSCAN_PIPE_IN_ac_init_clock1(BSCAN_PIPE_IN_1_ac_init_clock1), 
    .BSCAN_PIPE_IN_ac_mode_en(BSCAN_PIPE_IN_1_ac_mode_en), 
    .BSCAN_PIPE_IN_force_disable(BSCAN_PIPE_IN_1_force_disable), 
    .BSCAN_PIPE_IN_select_jtag_input(BSCAN_PIPE_IN_1_select_jtag_input), 
    .BSCAN_PIPE_IN_select_jtag_output(BSCAN_PIPE_IN_1_select_jtag_output), 
    .BSCAN_PIPE_IN_intel_update_clk(BSCAN_PIPE_IN_1_intel_update_clk), 
    .BSCAN_PIPE_IN_intel_clamp_en(BSCAN_PIPE_IN_1_intel_clamp_en), 
    .BSCAN_PIPE_IN_intel_bscan_mode(BSCAN_PIPE_IN_1_intel_bscan_mode), 
    .BSCAN_PIPE_OUT_scan_out(parmisc_physs0_BSCAN_PIPE_OUT_scan_out), 
    .bscan_intel_d6actestsig_b(BSCAN_PIPE_IN_1_intel_d6actestsig_b), 
    .BSCAN_PIPE_OUT_1_bscan_to_intel_d6actestsig_b(parmisc_physs0_BSCAN_PIPE_OUT_1_bscan_to_intel_d6actestsig_b), 
    .BSCAN_PIPE_OUT_2_bscan_to_intel_d6actestsig_b(parmisc_physs0_BSCAN_PIPE_OUT_2_bscan_to_intel_d6actestsig_b), 
    .SSN_END_towards_mquad0_bus_data_out(parmisc_physs0_SSN_END_towards_mquad0_bus_data_out), 
    .chain_rpt_mquad0_mquad1_end_bus_data_out(parmisc_physs0_chain_rpt_mquad0_mquad1_end_bus_data_out), 
    .END_2_bus_data_out(parmisc_physs0_END_2_bus_data_out), 
    .chain_rpt_par800g_end_bus_data_out(parmisc_physs0_chain_rpt_par800g_end_bus_data_out), 
    .chain_rpt_final_exit_start_bus_data_in(parmisc_physs0_chain_rpt_par800g_end_bus_data_out), 
    .chain_rpt_misc1_physs0_start_bus_data_in(SSN_START_from_parmisc_physs1_bus_data_in), 
    .chain_rpt_mquad0_mquad1_start_bus_data_in(par400g0_chain_rpt_mquad0_misc0_end_bus_data_out), 
    .chain_rpt_mquad1_misc1_start_bus_data_in(par400g1_chain_rpt_mquad1_misc0_end_bus_data_out), 
    .chain_rpt_misc1_physs0_end_bus_data_out(parmisc_physs0_chain_rpt_misc1_physs0_end_bus_data_out), 
    .chain_rpt_par800g_start_bus_data_in(parmisc_physs0_chain_rpt_misc1_physs0_end_bus_data_out), 
    .SSN_START_from_physs0_bus_data_in(SSN_START_entry_from_nac_bus_data_in), 
    .START_3_bus_data_in(par800g_SSN_END_0_bus_data_out), 
    .END_0_bus_data_out(parmisc_physs0_END_0_bus_data_out), 
    .START_1_bus_data_in(parmisc_physs0_END_0_bus_data_out), 
    .chain_rpt_final_exit_end_bus_data_out(SSN_END_exit_to_nac_bus_data_out), 
    .chain_rpt_mquad1_misc1_end_bus_data_out(SSN_END_towards_parmisc_physs1_bus_data_out), 
    .JT_IN_mbist_400g0_ijtag_from_so(par400g0_JT_OUT_mbist_par400g0_ijtag_so), 
    .JT_IN_misc_400g0_ijtag_from_so(par400g0_JT_OUT_misc_par400g0_ijtag_so), 
    .JT_IN_scan_400g0_ijtag_from_so(par400g0_JT_OUT_scan_par400g0_ijtag_so), 
    .JT_OUT_mbist_400g0_ijtag_to_reset(parmisc_physs0_JT_OUT_mbist_400g0_ijtag_to_reset), 
    .JT_OUT_mbist_400g0_ijtag_to_se(parmisc_physs0_JT_OUT_mbist_400g0_ijtag_to_se), 
    .JT_OUT_mbist_400g0_ijtag_to_ce(parmisc_physs0_JT_OUT_mbist_400g0_ijtag_to_ce), 
    .JT_OUT_mbist_400g0_ijtag_to_ue(parmisc_physs0_JT_OUT_mbist_400g0_ijtag_to_ue), 
    .JT_OUT_mbist_400g0_ijtag_to_sel(parmisc_physs0_JT_OUT_mbist_400g0_ijtag_to_sel), 
    .JT_OUT_misc_400g0_ijtag_to_reset(parmisc_physs0_JT_OUT_misc_400g0_ijtag_to_reset), 
    .JT_OUT_misc_400g0_ijtag_to_se(parmisc_physs0_JT_OUT_misc_400g0_ijtag_to_se), 
    .JT_OUT_misc_400g0_ijtag_to_ce(parmisc_physs0_JT_OUT_misc_400g0_ijtag_to_ce), 
    .JT_OUT_misc_400g0_ijtag_to_ue(parmisc_physs0_JT_OUT_misc_400g0_ijtag_to_ue), 
    .JT_OUT_misc_400g0_ijtag_to_sel(parmisc_physs0_JT_OUT_misc_400g0_ijtag_to_sel), 
    .JT_OUT_scan_400g0_to_tck(parmisc_physs0_JT_OUT_scan_400g0_to_tck), 
    .JT_OUT_scan_400g0_ijtag_to_reset(parmisc_physs0_JT_OUT_scan_400g0_ijtag_to_reset), 
    .JT_OUT_scan_400g0_ijtag_to_se(parmisc_physs0_JT_OUT_scan_400g0_ijtag_to_se), 
    .JT_OUT_scan_400g0_ijtag_to_ce(parmisc_physs0_JT_OUT_scan_400g0_ijtag_to_ce), 
    .JT_OUT_scan_400g0_ijtag_to_ue(parmisc_physs0_JT_OUT_scan_400g0_ijtag_to_ue), 
    .JT_OUT_scan_400g0_ijtag_to_sel(parmisc_physs0_JT_OUT_scan_400g0_ijtag_to_sel), 
    .JT_IN_mbist_400g1_ijtag_from_so(par400g1_JT_OUT_mbist_par400g1_ijtag_so), 
    .JT_IN_misc_400g1_ijtag_from_so(par400g1_JT_OUT_misc_par400g1_ijtag_so), 
    .JT_IN_scan_400g1_ijtag_from_so(par400g1_JT_OUT_scan_par400g1_ijtag_so), 
    .JT_OUT_mbist_400g1_ijtag_to_reset(parmisc_physs0_JT_OUT_mbist_400g1_ijtag_to_reset), 
    .JT_OUT_mbist_400g1_ijtag_to_se(parmisc_physs0_JT_OUT_mbist_400g1_ijtag_to_se), 
    .JT_OUT_mbist_400g1_ijtag_to_ce(parmisc_physs0_JT_OUT_mbist_400g1_ijtag_to_ce), 
    .JT_OUT_mbist_400g1_ijtag_to_ue(parmisc_physs0_JT_OUT_mbist_400g1_ijtag_to_ue), 
    .JT_OUT_mbist_400g1_ijtag_to_sel(parmisc_physs0_JT_OUT_mbist_400g1_ijtag_to_sel), 
    .JT_OUT_misc_400g1_ijtag_to_reset(parmisc_physs0_JT_OUT_misc_400g1_ijtag_to_reset), 
    .JT_OUT_misc_400g1_ijtag_to_se(parmisc_physs0_JT_OUT_misc_400g1_ijtag_to_se), 
    .JT_OUT_misc_400g1_ijtag_to_ce(parmisc_physs0_JT_OUT_misc_400g1_ijtag_to_ce), 
    .JT_OUT_misc_400g1_ijtag_to_ue(parmisc_physs0_JT_OUT_misc_400g1_ijtag_to_ue), 
    .JT_OUT_misc_400g1_ijtag_to_sel(parmisc_physs0_JT_OUT_misc_400g1_ijtag_to_sel), 
    .JT_OUT_scan_400g1_to_tck(parmisc_physs0_JT_OUT_scan_400g1_to_tck), 
    .JT_OUT_scan_400g1_ijtag_to_reset(parmisc_physs0_JT_OUT_scan_400g1_ijtag_to_reset), 
    .JT_OUT_scan_400g1_ijtag_to_se(parmisc_physs0_JT_OUT_scan_400g1_ijtag_to_se), 
    .JT_OUT_scan_400g1_ijtag_to_ce(parmisc_physs0_JT_OUT_scan_400g1_ijtag_to_ce), 
    .JT_OUT_scan_400g1_ijtag_to_ue(parmisc_physs0_JT_OUT_scan_400g1_ijtag_to_ue), 
    .JT_OUT_scan_400g1_ijtag_to_sel(parmisc_physs0_JT_OUT_scan_400g1_ijtag_to_sel), 
    .JT_IN_mbist_800g_ijtag_from_so(par800g_JT_OUT_mbist_par800g_ijtag_so), 
    .JT_IN_misc_800g_ijtag_from_so(par800g_JT_OUT_misc_par800g_ijtag_so), 
    .JT_IN_scan_800g_ijtag_from_so(par800g_JT_OUT_scan_par800g_ijtag_so), 
    .JT_OUT_mbist_800g_ijtag_to_reset(parmisc_physs0_JT_OUT_mbist_800g_ijtag_to_reset), 
    .JT_OUT_mbist_800g_ijtag_to_se(parmisc_physs0_JT_OUT_mbist_800g_ijtag_to_se), 
    .JT_OUT_mbist_800g_ijtag_to_ce(parmisc_physs0_JT_OUT_mbist_800g_ijtag_to_ce), 
    .JT_OUT_mbist_800g_ijtag_to_ue(parmisc_physs0_JT_OUT_mbist_800g_ijtag_to_ue), 
    .JT_OUT_mbist_800g_ijtag_to_sel(parmisc_physs0_JT_OUT_mbist_800g_ijtag_to_sel), 
    .JT_OUT_misc_800g_ijtag_to_reset(parmisc_physs0_JT_OUT_misc_800g_ijtag_to_reset), 
    .JT_OUT_misc_800g_ijtag_to_se(parmisc_physs0_JT_OUT_misc_800g_ijtag_to_se), 
    .JT_OUT_misc_800g_ijtag_to_ce(parmisc_physs0_JT_OUT_misc_800g_ijtag_to_ce), 
    .JT_OUT_misc_800g_ijtag_to_ue(parmisc_physs0_JT_OUT_misc_800g_ijtag_to_ue), 
    .JT_OUT_misc_800g_ijtag_to_sel(parmisc_physs0_JT_OUT_misc_800g_ijtag_to_sel), 
    .JT_OUT_scan_800g_to_tck(parmisc_physs0_JT_OUT_scan_800g_to_tck), 
    .JT_OUT_scan_800g_ijtag_to_reset(parmisc_physs0_JT_OUT_scan_800g_ijtag_to_reset), 
    .JT_OUT_scan_800g_ijtag_to_se(parmisc_physs0_JT_OUT_scan_800g_ijtag_to_se), 
    .JT_OUT_scan_800g_ijtag_to_ce(parmisc_physs0_JT_OUT_scan_800g_ijtag_to_ce), 
    .JT_OUT_scan_800g_ijtag_to_ue(parmisc_physs0_JT_OUT_scan_800g_ijtag_to_ue), 
    .JT_OUT_scan_800g_ijtag_to_sel(parmisc_physs0_JT_OUT_scan_800g_ijtag_to_sel), 
    .JT_OUT_mbist_400g0_ijtag_to_si(parmisc_physs0_JT_OUT_mbist_400g0_ijtag_to_si), 
    .JT_OUT_mbist_400g1_ijtag_to_si(parmisc_physs0_JT_OUT_mbist_400g1_ijtag_to_si), 
    .JT_OUT_mbist_800g_ijtag_to_si(parmisc_physs0_JT_OUT_mbist_800g_ijtag_to_si), 
    .JT_OUT_misc_400g0_ijtag_to_si(parmisc_physs0_JT_OUT_misc_400g0_ijtag_to_si), 
    .JT_OUT_misc_400g1_ijtag_to_si(parmisc_physs0_JT_OUT_misc_400g1_ijtag_to_si), 
    .JT_OUT_misc_800g_ijtag_to_si(parmisc_physs0_JT_OUT_misc_800g_ijtag_to_si), 
    .JT_OUT_scan_400g0_ijtag_to_si(parmisc_physs0_JT_OUT_scan_400g0_ijtag_to_si), 
    .JT_OUT_scan_400g1_ijtag_to_si(parmisc_physs0_JT_OUT_scan_400g1_ijtag_to_si), 
    .JT_OUT_scan_800g_ijtag_to_si(parmisc_physs0_JT_OUT_scan_800g_ijtag_to_si), 
    .NW_IN_trst_b(trst_b), 
    .NW_IN_tck(tck), 
    .NW_IN_tms(tms), 
    .NW_IN_tdi(tdi), 
    .NW_IN_tdo_en(parmisc_physs0_NW_IN_tdo_en), 
    .NW_IN_tdo(parmisc_physs0_NW_IN_tdo), 
    .NW_IN_ijtag_reset_b(ijtag_reset_b), 
    .NW_IN_ijtag_shift(ijtag_shift), 
    .NW_IN_ijtag_capture(ijtag_capture), 
    .NW_IN_ijtag_update(ijtag_update), 
    .NW_IN_ijtag_select(ijtag_select), 
    .NW_IN_ijtag_si(ijtag_si), 
    .NW_IN_ijtag_so(parmisc_physs0_NW_IN_ijtag_so), 
    .NW_IN_shift_ir_dr(shift_ir_dr), 
    .NW_IN_tms_park_value(tms_park_value), 
    .NW_IN_nw_mode(nw_mode), 
    .NW_IN_tap_sel_out(parmisc_physs0_NW_IN_tap_sel_out), 
    .NW_OUT_parmisc_physs1_from_tdo(parmisc_physs1_NW_IN_tdo), 
    .NW_OUT_parmisc_physs1_from_tdo_en(parmisc_physs1_NW_IN_tdo_en), 
    .NW_OUT_parmisc_physs1_ijtag_to_reset(parmisc_physs0_NW_OUT_parmisc_physs1_ijtag_to_reset), 
    .NW_OUT_parmisc_physs1_ijtag_to_ce(parmisc_physs0_NW_OUT_parmisc_physs1_ijtag_to_ce), 
    .NW_OUT_parmisc_physs1_ijtag_to_se(parmisc_physs0_NW_OUT_parmisc_physs1_ijtag_to_se), 
    .NW_OUT_parmisc_physs1_ijtag_to_ue(parmisc_physs0_NW_OUT_parmisc_physs1_ijtag_to_ue), 
    .NW_OUT_parmisc_physs1_ijtag_to_sel(parmisc_physs0_NW_OUT_parmisc_physs1_ijtag_to_sel), 
    .NW_OUT_parmisc_physs1_ijtag_to_si(parmisc_physs0_NW_OUT_parmisc_physs1_ijtag_to_si), 
    .NW_OUT_parmisc_physs1_ijtag_from_so(parmisc_physs1_NW_IN_ijtag_so), 
    .NW_OUT_parmisc_physs1_tap_sel_in(parmisc_physs1_NW_IN_tap_sel_out), 
    .NW_OUT_parmquad0_from_tdo(parmquad0_NW_IN_tdo), 
    .NW_OUT_parmquad0_from_tdo_en(parmquad0_NW_IN_tdo_en), 
    .NW_OUT_parmquad0_ijtag_to_reset(parmisc_physs0_NW_OUT_parmquad0_ijtag_to_reset), 
    .NW_OUT_parmquad0_ijtag_to_ce(parmisc_physs0_NW_OUT_parmquad0_ijtag_to_ce), 
    .NW_OUT_parmquad0_ijtag_to_se(parmisc_physs0_NW_OUT_parmquad0_ijtag_to_se), 
    .NW_OUT_parmquad0_ijtag_to_ue(parmisc_physs0_NW_OUT_parmquad0_ijtag_to_ue), 
    .NW_OUT_parmquad0_ijtag_to_sel(parmisc_physs0_NW_OUT_parmquad0_ijtag_to_sel), 
    .NW_OUT_parmquad0_ijtag_to_si(parmisc_physs0_NW_OUT_parmquad0_ijtag_to_si), 
    .NW_OUT_parmquad0_ijtag_from_so(parmquad0_NW_IN_ijtag_so), 
    .NW_OUT_parmquad0_tap_sel_in(parmquad0_NW_IN_tap_sel_out), 
    .NW_OUT_parmquad1_from_tdo(parmquad1_NW_IN_tdo), 
    .NW_OUT_parmquad1_from_tdo_en(parmquad1_NW_IN_tdo_en), 
    .NW_OUT_parmquad1_ijtag_to_reset(parmisc_physs0_NW_OUT_parmquad1_ijtag_to_reset), 
    .NW_OUT_parmquad1_ijtag_to_ce(parmisc_physs0_NW_OUT_parmquad1_ijtag_to_ce), 
    .NW_OUT_parmquad1_ijtag_to_se(parmisc_physs0_NW_OUT_parmquad1_ijtag_to_se), 
    .NW_OUT_parmquad1_ijtag_to_ue(parmisc_physs0_NW_OUT_parmquad1_ijtag_to_ue), 
    .NW_OUT_parmquad1_ijtag_to_sel(parmisc_physs0_NW_OUT_parmquad1_ijtag_to_sel), 
    .NW_OUT_parmquad1_ijtag_to_si(parmisc_physs0_NW_OUT_parmquad1_ijtag_to_si), 
    .NW_OUT_parmquad1_ijtag_from_so(parmquad1_NW_IN_ijtag_so), 
    .NW_OUT_parmquad1_tap_sel_in(parmquad1_NW_IN_tap_sel_out), 
    .chain_rpt_final_exit_start_bus_clock_in(SSN_START_entry_from_nac_bus_clock_in), 
    .chain_rpt_misc1_physs0_start_bus_clock_in(SSN_START_entry_from_nac_bus_clock_in), 
    .chain_rpt_mquad0_mquad1_start_bus_clock_in(SSN_START_entry_from_nac_bus_clock_in), 
    .chain_rpt_mquad1_misc1_start_bus_clock_in(SSN_START_entry_from_nac_bus_clock_in), 
    .chain_rpt_par800g_start_bus_clock_in(SSN_START_entry_from_nac_bus_clock_in), 
    .SSN_START_from_physs0_bus_clock_in(SSN_START_entry_from_nac_bus_clock_in), 
    .START_3_bus_clock_in(SSN_START_entry_from_nac_bus_clock_in), 
    .START_1_bus_clock_in(SSN_START_entry_from_nac_bus_clock_in), 
    .JT_OUT_mbist_400g0_to_tck(), 
    .JT_OUT_mbist_400g1_to_tck(), 
    .JT_OUT_mbist_800g_to_tck(), 
    .JT_OUT_misc_400g0_to_tck(), 
    .JT_OUT_misc_400g1_to_tck(), 
    .JT_OUT_misc_800g_to_tck(), 
    .NW_OUT_parmisc_physs1_ijtag_to_tck(), 
    .NW_OUT_parmquad0_ijtag_to_tck(), 
    .NW_OUT_parmquad1_ijtag_to_tck(), 
    .NW_OUT_parmisc_physs1_to_trst(), 
    .NW_OUT_parmisc_physs1_to_tck(), 
    .NW_OUT_parmisc_physs1_to_tms(), 
    .NW_OUT_parmisc_physs1_to_tdi(), 
    .NW_OUT_parmquad0_to_trst(), 
    .NW_OUT_parmquad0_to_tck(), 
    .NW_OUT_parmquad0_to_tms(), 
    .NW_OUT_parmquad0_to_tdi(), 
    .NW_OUT_parmquad1_to_trst(), 
    .NW_OUT_parmquad1_to_tck(), 
    .NW_OUT_parmquad1_to_tms(), 
    .NW_OUT_parmquad1_to_tdi(), 
    .trig_clock_stop_to_parmquad0_pma0_txdat(), 
    .trig_clock_stop_to_parmquad0_pma1_txdat(), 
    .trig_clock_stop_to_parmquad0_pma2_txdat(), 
    .trig_clock_stop_to_parmquad0_pma3_txdat(), 
    .trig_clock_stop_to_parmquad1_pma0_txdat(), 
    .trig_clock_stop_to_parmquad1_pma1_txdat(), 
    .trig_clock_stop_to_parmquad1_pma2_txdat(), 
    .trig_clock_stop_to_parmquad1_pma3_txdat()
) ; 
parmquad0 parmquad0 (
    .mbp_repeater_odi_par400g0_ubp_out(mbp_repeater_odi_par400g0_ubp_out), 
    .dfxagg_security_policy(dfxagg_security_policy), 
    .dfxagg_policy_update(dfxagg_policy_update), 
    .dfxagg_early_boot_debug_exit(dfxagg_early_boot_debug_exit), 
    .dfxagg_debug_capabilities_enabling(dfxagg_debug_capabilities_enabling), 
    .dfxagg_debug_capabilities_enabling_valid(dfxagg_debug_capabilities_enabling_valid), 
    .fdfx_powergood(fdfx_powergood), 
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
    .quadpcs100_0_pcs_link_status(quadpcs100_0_pcs_link_status), 
    .physs_mse_800g_en(physs_mse_800g_en), 
    .versa_xmp_0_o_ucss_srds_phy_ready_pma0_l0_a(versa_xmp_0_o_ucss_srds_phy_ready_pma0_l0_a), 
    .versa_xmp_0_o_ucss_srds_phy_ready_pma1_l0_a(versa_xmp_0_o_ucss_srds_phy_ready_pma1_l0_a), 
    .versa_xmp_0_o_ucss_srds_phy_ready_pma2_l0_a(versa_xmp_0_o_ucss_srds_phy_ready_pma2_l0_a), 
    .versa_xmp_0_o_ucss_srds_phy_ready_pma3_l0_a(versa_xmp_0_o_ucss_srds_phy_ready_pma3_l0_a), 
    .physs_registers_wrapper_0_hlp_link_stat_speed_0_hlp_link_stat_0(physs_registers_wrapper_0_hlp_link_stat_speed_0_hlp_link_stat_0), 
    .physs_registers_wrapper_0_hlp_link_stat_speed_1_hlp_link_stat_1(physs_registers_wrapper_0_hlp_link_stat_speed_1_hlp_link_stat_1), 
    .physs_registers_wrapper_0_hlp_link_stat_speed_2_hlp_link_stat_2(physs_registers_wrapper_0_hlp_link_stat_speed_2_hlp_link_stat_2), 
    .physs_registers_wrapper_0_hlp_link_stat_speed_3_hlp_link_stat_3(physs_registers_wrapper_0_hlp_link_stat_speed_3_hlp_link_stat_3), 
    .physs_registers_wrapper_0_link_bypass_en(physs_registers_wrapper_0_link_bypass_en), 
    .physs_registers_wrapper_0_link_bypass_val(physs_registers_wrapper_0_link_bypass_val), 
    .physs_registers_wrapper_0_syncE_main_rst(physs_registers_wrapper_0_syncE_main_rst), 
    .physs_registers_wrapper_0_syncE_link_up_md(physs_registers_wrapper_0_syncE_link_up_md), 
    .physs_registers_wrapper_0_syncE_link_dn_md(physs_registers_wrapper_0_syncE_link_dn_md), 
    .physs_registers_wrapper_0_syncE_link_enable(physs_registers_wrapper_0_syncE_link_enable), 
    .physs_registers_wrapper_0_syncE_refclk0_div_rst(physs_registers_wrapper_0_syncE_refclk0_div_rst), 
    .physs_registers_wrapper_0_syncE_refclk0_sel(physs_registers_wrapper_0_syncE_refclk0_sel), 
    .physs_registers_wrapper_0_syncE_refclk0_div_m1(physs_registers_wrapper_0_syncE_refclk0_div_m1), 
    .physs_registers_wrapper_0_syncE_refclk0_div_load(physs_registers_wrapper_0_syncE_refclk0_div_load), 
    .physs_registers_wrapper_0_syncE_refclk1_div_rst(physs_registers_wrapper_0_syncE_refclk1_div_rst), 
    .physs_registers_wrapper_0_syncE_refclk1_sel(physs_registers_wrapper_0_syncE_refclk1_sel), 
    .physs_registers_wrapper_0_syncE_refclk1_div_m1(physs_registers_wrapper_0_syncE_refclk1_div_m1), 
    .physs_registers_wrapper_0_syncE_refclk1_div_load(physs_registers_wrapper_0_syncE_refclk1_div_load), 
    .physs_registers_wrapper_0_pcs_mode_config_syncE_mux_sel(physs_registers_wrapper_0_pcs_mode_config_syncE_mux_sel), 
    .physs_registers_wrapper_0_pcs_mode_config_syncE_mux_sel_0(physs_registers_wrapper_0_pcs_mode_config_syncE_mux_sel_0), 
    .physs_hd2prf_trim_fuse_in(physs_hd2prf_trim_fuse_in), 
    .physs_hdp2prf_trim_fuse_in(physs_hdp2prf_trim_fuse_in), 
    .physs_rfhs_trim_fuse_in(physs_rfhs_trim_fuse_in), 
    .physs_hdspsr_trim_fuse_in(physs_hdspsr_trim_fuse_in), 
    .physs_bbl_800G_0_disable(physs_bbl_800G_0_disable), 
    .physs_bbl_400G_0_disable(physs_bbl_400G_0_disable), 
    .physs_bbl_200G_0_disable(physs_bbl_200G_0_disable), 
    .physs_bbl_100G_0_disable(physs_bbl_100G_0_disable), 
    .physs_bbl_serdes_0_disable(physs_bbl_serdes_0_disable), 
    .physs_bbl_spare_0(physs_bbl_spare_0), 
    .physs_registers_wrapper_0_mac200_config_0_xoff_gen(physs_registers_wrapper_0_mac200_config_0_xoff_gen), 
    .physs_registers_wrapper_0_mac200_config_0_tx_loc_fault(physs_registers_wrapper_0_mac200_config_0_tx_loc_fault), 
    .physs_registers_wrapper_0_mac200_config_0_tx_rem_fault(physs_registers_wrapper_0_mac200_config_0_tx_rem_fault), 
    .physs_registers_wrapper_0_mac200_config_0_tx_li_fault(physs_registers_wrapper_0_mac200_config_0_tx_li_fault), 
    .physs_registers_wrapper_0_mac200_config_0_tx_smhold(physs_registers_wrapper_0_mac200_config_0_tx_smhold), 
    .physs_registers_wrapper_0_mac400_config_0_xoff_gen(physs_registers_wrapper_0_mac400_config_0_xoff_gen), 
    .physs_registers_wrapper_0_mac400_config_0_tx_loc_fault(physs_registers_wrapper_0_mac400_config_0_tx_loc_fault), 
    .physs_registers_wrapper_0_mac400_config_0_tx_rem_fault(physs_registers_wrapper_0_mac400_config_0_tx_rem_fault), 
    .physs_registers_wrapper_0_mac400_config_0_tx_li_fault(physs_registers_wrapper_0_mac400_config_0_tx_li_fault), 
    .physs_registers_wrapper_0_mac400_config_0_tx_smhold(physs_registers_wrapper_0_mac400_config_0_tx_smhold), 
    .ethphyss_post_clkungate(ethphyss_post_clkungate), 
    .soc_per_clk_adop_parmisc_physs0_clkout(soc_per_clk_adop_parmisc_physs0_clkout_0), 
    .physs_func_clk_adop_parmisc_physs0_clkout_0(physs_func_clk_adop_parmisc_physs0_clkout_0), 
    .o_ck_pma0_rx_postdiv_l0_adop_parmquad0_clkout(o_ck_pma0_rx_postdiv_l0_adop_parmquad0_clkout), 
    .o_ck_pma1_rx_postdiv_l0_adop_parmquad0_clkout(o_ck_pma1_rx_postdiv_l0_adop_parmquad0_clkout), 
    .o_ck_pma2_rx_postdiv_l0_adop_parmquad0_clkout(o_ck_pma2_rx_postdiv_l0_adop_parmquad0_clkout), 
    .o_ck_pma3_rx_postdiv_l0_adop_parmquad0_clkout(o_ck_pma3_rx_postdiv_l0_adop_parmquad0_clkout), 
    .tsu_clk(tsu_clk), 
    .fscan_txrxword_byp_clk(fscan_txrxword_byp_clk), 
    .fscan_ref_clk_adop_parmisc_physs0_clkout(fscan_ref_clk_adop_parmisc_physs0_clkout), 
    .cosq_func_clk0_adop_parmisc_physs0_clkout_0(cosq_func_clk0_adop_parmisc_physs0_clkout_0), 
    .physs_pcs_mux_0_sd0_tx_clk_200G(physs_pcs_mux_0_sd0_tx_clk_200G), 
    .physs_pcs_mux_0_sd4_tx_clk_200G(physs_pcs_mux_0_sd4_tx_clk_200G), 
    .physs_pcs_mux_0_sd8_tx_clk_200G(physs_pcs_mux_0_sd8_tx_clk_200G), 
    .physs_pcs_mux_0_sd12_tx_clk_200G(physs_pcs_mux_0_sd12_tx_clk_200G), 
    .physs_pcs_mux_0_sd0_tx_clk_400G(physs_pcs_mux_0_sd0_tx_clk_400G), 
    .physs_pcs_mux_0_sd4_tx_clk_400G(physs_pcs_mux_0_sd4_tx_clk_400G), 
    .physs_pcs_mux_0_sd8_tx_clk_400G(physs_pcs_mux_0_sd8_tx_clk_400G), 
    .physs_pcs_mux_0_sd12_tx_clk_400G(physs_pcs_mux_0_sd12_tx_clk_400G), 
    .physs_pcs_mux_0_sd0_rx_clk_400G(physs_pcs_mux_0_sd0_rx_clk_400G), 
    .physs_pcs_mux_0_sd4_rx_clk_400G(physs_pcs_mux_0_sd4_rx_clk_400G), 
    .physs_pcs_mux_0_sd8_rx_clk_400G(physs_pcs_mux_0_sd8_rx_clk_400G), 
    .physs_pcs_mux_0_sd12_rx_clk_400G(physs_pcs_mux_0_sd12_rx_clk_400G), 
    .physs_pcs_mux_0_sd0_rx_clk_200G(physs_pcs_mux_0_sd0_rx_clk_200G), 
    .physs_pcs_mux_0_sd4_rx_clk_200G(physs_pcs_mux_0_sd4_rx_clk_200G), 
    .physs_pcs_mux_0_sd8_rx_clk_200G(physs_pcs_mux_0_sd8_rx_clk_200G), 
    .physs_pcs_mux_0_sd12_rx_clk_200G(physs_pcs_mux_0_sd12_rx_clk_200G), 
    .physs_funcx2_clk_adop_parmisc_physs0_clkout(physs_funcx2_clk_adop_parmisc_physs0_clkout), 
    .physs_pcs_mux_0_sd_rx_clk_800G(physs_pcs_mux_0_sd_rx_clk_800G), 
    .physs_pcs_mux_0_sd_rx_clk_800G_0(physs_pcs_mux_0_sd_rx_clk_800G_0), 
    .physs_pcs_mux_0_sd_rx_clk_800G_1(physs_pcs_mux_0_sd_rx_clk_800G_1), 
    .physs_pcs_mux_0_sd_rx_clk_800G_2(physs_pcs_mux_0_sd_rx_clk_800G_2), 
    .physs_pcs_mux_0_sd_tx_clk_800G(physs_pcs_mux_0_sd_tx_clk_800G), 
    .physs_pcs_mux_0_sd_tx_clk_800G_0(physs_pcs_mux_0_sd_tx_clk_800G_0), 
    .physs_pcs_mux_0_sd_tx_clk_800G_1(physs_pcs_mux_0_sd_tx_clk_800G_1), 
    .physs_pcs_mux_0_sd_tx_clk_800G_2(physs_pcs_mux_0_sd_tx_clk_800G_2), 
    .o_ck_pma0_cmnplla_postdiv_clk_mux_parmquad0_clkout(o_ck_pma0_cmnplla_postdiv_clk_mux_parmquad0_clkout), 
    .uart_clk_adop_parmisc_physs0_clkout(uart_clk_adop_parmisc_physs0_clkout), 
    .physs_registers_wrapper_0_uart_port_mux_sel_uart_mux_sel(physs_registers_wrapper_0_uart_port_mux_sel_uart_mux_sel), 
    .physs_registers_wrapper_0_uart_port_mux_sel_uart_mux_sel_0(physs_registers_wrapper_0_uart_port_mux_sel_uart_mux_sel_0), 
    .uart_sel_and0_o(uart_sel_and0_o), 
    .nic400_quad_0_hselx_mac400_stats_0(nic400_quad_0_hselx_mac400_stats_0), 
    .nic400_quad_0_haddr_mac400_stats_0_out(nic400_quad_0_haddr_mac400_stats_0_out), 
    .nic400_quad_0_htrans_mac400_stats_0(nic400_quad_0_htrans_mac400_stats_0), 
    .nic400_quad_0_hwrite_mac400_stats_0(nic400_quad_0_hwrite_mac400_stats_0), 
    .nic400_quad_0_hsize_mac400_stats_0(nic400_quad_0_hsize_mac400_stats_0), 
    .nic400_quad_0_hwdata_mac400_stats_0(nic400_quad_0_hwdata_mac400_stats_0), 
    .nic400_quad_0_hready_mac400_stats_0(nic400_quad_0_hready_mac400_stats_0), 
    .nic400_quad_0_hburst_mac400_stats_0(nic400_quad_0_hburst_mac400_stats_0), 
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
    .nic400_quad_0_hburst_mac400_stats_1(nic400_quad_0_hburst_mac400_stats_1), 
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
    .nic400_quad_0_hburst_mac400_0(nic400_quad_0_hburst_mac400_0), 
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
    .nic400_quad_0_hburst_mac400_1(nic400_quad_0_hburst_mac400_1), 
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
    .nic400_quad_0_hburst_pcs400_0(nic400_quad_0_hburst_pcs400_0), 
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
    .nic400_quad_0_hburst_rsfec400_0(nic400_quad_0_hburst_rsfec400_0), 
    .pcs200_ahb_bridge_1_hrdata(pcs200_ahb_bridge_1_hrdata), 
    .pcs200_ahb_bridge_1_hresp(pcs200_ahb_bridge_1_hresp), 
    .pcs200_ahb_bridge_1_hreadyout(pcs200_ahb_bridge_1_hreadyout), 
    .nic400_quad_0_hselx_rsfecstats400_1(nic400_quad_0_hselx_rsfecstats400_1), 
    .nic400_quad_0_haddr_rsfecstats400_1_out(nic400_quad_0_haddr_rsfecstats400_1_out), 
    .nic400_quad_0_htrans_rsfecstats400_1(nic400_quad_0_htrans_rsfecstats400_1), 
    .nic400_quad_0_hwrite_rsfecstats400_1(nic400_quad_0_hwrite_rsfecstats400_1), 
    .nic400_quad_0_hsize_rsfecstats400_1(nic400_quad_0_hsize_rsfecstats400_1), 
    .nic400_quad_0_hwdata_rsfecstats400_1(nic400_quad_0_hwdata_rsfecstats400_1), 
    .nic400_quad_0_hready_rsfecstats400_1(nic400_quad_0_hready_rsfecstats400_1), 
    .nic400_quad_0_hburst_rsfecstats400_1(nic400_quad_0_hburst_rsfecstats400_1), 
    .pcs200_ahb_bridge_4_hrdata(pcs200_ahb_bridge_4_hrdata), 
    .pcs200_ahb_bridge_4_hresp(pcs200_ahb_bridge_4_hresp), 
    .pcs200_ahb_bridge_4_hreadyout(pcs200_ahb_bridge_4_hreadyout), 
    .nic400_quad_0_hselx_pcs400_1(nic400_quad_0_hselx_pcs400_1), 
    .nic400_quad_0_haddr_pcs400_1_out(nic400_quad_0_haddr_pcs400_1_out), 
    .nic400_quad_0_htrans_pcs400_1(nic400_quad_0_htrans_pcs400_1), 
    .nic400_quad_0_hwrite_pcs400_1(nic400_quad_0_hwrite_pcs400_1), 
    .nic400_quad_0_hsize_pcs400_1(nic400_quad_0_hsize_pcs400_1), 
    .nic400_quad_0_hwdata_pcs400_1(nic400_quad_0_hwdata_pcs400_1), 
    .nic400_quad_0_hready_pcs400_1(nic400_quad_0_hready_pcs400_1), 
    .nic400_quad_0_hburst_pcs400_1(nic400_quad_0_hburst_pcs400_1), 
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
    .nic400_quad_0_hburst_rsfec400_1(nic400_quad_0_hburst_rsfec400_1), 
    .pcs400_ahb_bridge_1_hrdata(pcs400_ahb_bridge_1_hrdata), 
    .pcs400_ahb_bridge_1_hresp(pcs400_ahb_bridge_1_hresp), 
    .pcs400_ahb_bridge_1_hreadyout(pcs400_ahb_bridge_1_hreadyout), 
    .nic400_quad_0_hselx_rsfecstats400_0(nic400_quad_0_hselx_rsfecstats400_0), 
    .nic400_quad_0_haddr_rsfecstats400_0_out(nic400_quad_0_haddr_rsfecstats400_0_out), 
    .nic400_quad_0_htrans_rsfecstats400_0(nic400_quad_0_htrans_rsfecstats400_0), 
    .nic400_quad_0_hwrite_rsfecstats400_0(nic400_quad_0_hwrite_rsfecstats400_0), 
    .nic400_quad_0_hsize_rsfecstats400_0(nic400_quad_0_hsize_rsfecstats400_0), 
    .nic400_quad_0_hwdata_rsfecstats400_0(nic400_quad_0_hwdata_rsfecstats400_0), 
    .nic400_quad_0_hready_rsfecstats400_0(nic400_quad_0_hready_rsfecstats400_0), 
    .nic400_quad_0_hburst_rsfecstats400_0(nic400_quad_0_hburst_rsfecstats400_0), 
    .pcs400_ahb_bridge_4_hrdata(pcs400_ahb_bridge_4_hrdata), 
    .pcs400_ahb_bridge_4_hresp(pcs400_ahb_bridge_4_hresp), 
    .pcs400_ahb_bridge_4_hreadyout(pcs400_ahb_bridge_4_hreadyout), 
    .nic400_quad_0_hselx_tsu_400_0(nic400_quad_0_hselx_tsu_400_0), 
    .nic400_quad_0_haddr_tsu_400_0_out(nic400_quad_0_haddr_tsu_400_0_out), 
    .nic400_quad_0_htrans_tsu_400_0(nic400_quad_0_htrans_tsu_400_0), 
    .nic400_quad_0_hwrite_tsu_400_0(nic400_quad_0_hwrite_tsu_400_0), 
    .nic400_quad_0_hsize_tsu_400_0(nic400_quad_0_hsize_tsu_400_0), 
    .nic400_quad_0_hwdata_tsu_400_0(nic400_quad_0_hwdata_tsu_400_0), 
    .nic400_quad_0_hready_tsu_400_0(nic400_quad_0_hready_tsu_400_0), 
    .nic400_quad_0_hburst_tsu_400_0(nic400_quad_0_hburst_tsu_400_0), 
    .tsu400_ahb_bridge_0_hrdata(tsu400_ahb_bridge_0_hrdata), 
    .tsu400_ahb_bridge_0_hresp(tsu400_ahb_bridge_0_hresp), 
    .tsu400_ahb_bridge_0_hreadyout(tsu400_ahb_bridge_0_hreadyout), 
    .nic400_quad_0_hselx_tsu_400_1(nic400_quad_0_hselx_tsu_400_1), 
    .nic400_quad_0_haddr_tsu_400_1_out(nic400_quad_0_haddr_tsu_400_1_out), 
    .nic400_quad_0_htrans_tsu_400_1(nic400_quad_0_htrans_tsu_400_1), 
    .nic400_quad_0_hwrite_tsu_400_1(nic400_quad_0_hwrite_tsu_400_1), 
    .nic400_quad_0_hsize_tsu_400_1(nic400_quad_0_hsize_tsu_400_1), 
    .nic400_quad_0_hwdata_tsu_400_1(nic400_quad_0_hwdata_tsu_400_1), 
    .nic400_quad_0_hready_tsu_400_1(nic400_quad_0_hready_tsu_400_1), 
    .nic400_quad_0_hburst_tsu_400_1(nic400_quad_0_hburst_tsu_400_1), 
    .tsu200_ahb_bridge_0_hrdata(tsu200_ahb_bridge_0_hrdata), 
    .tsu200_ahb_bridge_0_hresp(tsu200_ahb_bridge_0_hresp), 
    .tsu200_ahb_bridge_0_hreadyout(tsu200_ahb_bridge_0_hreadyout), 
    .physs_registers_wrapper_0_reset_ref_clk_override_0(physs_registers_wrapper_0_reset_ref_clk_override_0), 
    .physs_registers_wrapper_0_reset_pcs100_override_en_0(physs_registers_wrapper_0_reset_pcs100_override_en_0), 
    .physs_registers_wrapper_0_clk_gate_en_100G_mac_pcs_0(physs_registers_wrapper_0_clk_gate_en_100G_mac_pcs_0), 
    .physs_registers_wrapper_0_power_fsm_clk_gate_en_0(physs_registers_wrapper_0_power_fsm_clk_gate_en_0), 
    .physs_registers_wrapper_0_power_fsm_reset_gate_en_0(physs_registers_wrapper_0_power_fsm_reset_gate_en_0), 
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
    .mac200_0_mdio_oen(mac200_0_mdio_oen), 
    .mac400_0_mdio_oen(mac400_0_mdio_oen), 
    .mac200_0_pfc_mode(mac200_0_pfc_mode), 
    .mac400_0_pfc_mode(mac400_0_pfc_mode), 
    .mac200_0_ff_rx_dsav(mac200_0_ff_rx_dsav), 
    .mac400_0_ff_rx_dsav(mac400_0_ff_rx_dsav), 
    .mac200_0_ff_tx_credit(mac200_0_ff_tx_credit), 
    .mac400_0_ff_tx_credit(mac400_0_ff_tx_credit), 
    .mac200_0_inv_loop_ind(mac200_0_inv_loop_ind), 
    .mac400_0_inv_loop_ind(mac400_0_inv_loop_ind), 
    .mac200_0_frm_drop(mac200_0_frm_drop), 
    .mac400_0_frm_drop(mac400_0_frm_drop), 
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
    .physs_registers_wrapper_0_pcs_mode_config_pcs_mode_sel_0(physs_registers_wrapper_0_pcs_mode_config_pcs_mode_sel_0), 
    .mux_sel_800(parmquad0_mux_sel_800), 
    .physs_registers_wrapper_0_pcs_mode_config_fifo_mode_sel(physs_registers_wrapper_0_pcs_mode_config_fifo_mode_sel), 
    .pd_vinf_0_bisr_clk(pd_vinf_0_bisr_clk), 
    .pd_vinf_0_bisr_reset(pd_vinf_0_bisr_reset), 
    .pd_vinf_0_bisr_shift_en(pd_vinf_0_bisr_shift_en), 
    .pd_vinf_0_bisr_si(par400g0_pd_vinf_0_bisr_so), 
    .pd_vinf_0_bisr_so(parmquad0_pd_vinf_0_bisr_so), 
    .physs_func_clk_pdop_parmquad0_clkout_0(physs_func_clk_pdop_parmquad0_clkout_0), 
    .physs_func_clk_pdop_parmquad1_clkout(physs_func_clk_pdop_parmquad1_clkout), 
    .physs_clock_sync_parmisc_physs0_func_rstn_func_sync(physs_clock_sync_parmisc_physs0_func_rstn_func_sync), 
    .physs0_func_rst_raw_n(physs0_func_rst_raw_n), 
    .ethphyss_post_clk_mux_ctrl(ethphyss_post_clk_mux_ctrl), 
    .DIAG_AGGR_mquad0_mbist_diag_done(parmquad0_DIAG_AGGR_mquad0_mbist_diag_done), 
    .hlp_mac_rx_throttle_0_stop(hlp_mac_rx_throttle_0_stop), 
    .hlp_mac_rx_throttle_1_stop(hlp_mac_rx_throttle_1_stop), 
    .hlp_mac_rx_throttle_2_stop(hlp_mac_rx_throttle_2_stop), 
    .hlp_mac_rx_throttle_3_stop(hlp_mac_rx_throttle_3_stop), 
    .tx_stop_0_in(tx_stop_0_in), 
    .tx_stop_1_in(tx_stop_1_in), 
    .tx_stop_2_in(tx_stop_2_in), 
    .tx_stop_3_in(tx_stop_3_in), 
    .versa_xmp_0_o_ucss_srds_pcs_tx_reset_pma0_l0_a(versa_xmp_0_o_ucss_srds_pcs_tx_reset_pma0_l0_a), 
    .versa_xmp_0_o_ucss_srds_pcs_rx_reset_pma0_l0_a(versa_xmp_0_o_ucss_srds_pcs_rx_reset_pma0_l0_a), 
    .versa_xmp_0_o_ucss_srds_pcs_tx_reset_pma2_l0_a(versa_xmp_0_o_ucss_srds_pcs_tx_reset_pma2_l0_a), 
    .versa_xmp_0_o_ucss_srds_pcs_rx_reset_pma2_l0_a(versa_xmp_0_o_ucss_srds_pcs_rx_reset_pma2_l0_a), 
    .physs_registers_wrapper_0_reset_cdmii_rxclk_override_200G(physs_registers_wrapper_0_reset_cdmii_rxclk_override_200G), 
    .physs_registers_wrapper_0_reset_cdmii_txclk_override_200G(physs_registers_wrapper_0_reset_cdmii_txclk_override_200G), 
    .physs_registers_wrapper_0_reset_sd_tx_clk_override_200G(physs_registers_wrapper_0_reset_sd_tx_clk_override_200G), 
    .physs_registers_wrapper_0_reset_sd_rx_clk_override_200G(physs_registers_wrapper_0_reset_sd_rx_clk_override_200G), 
    .physs_registers_wrapper_0_reset_reg_clk_override_200G(physs_registers_wrapper_0_reset_reg_clk_override_200G), 
    .physs_registers_wrapper_0_reset_reg_ref_clk_override_200G(physs_registers_wrapper_0_reset_reg_ref_clk_override_200G), 
    .physs_registers_wrapper_0_reset_cdmii_rxclk_override_400G(physs_registers_wrapper_0_reset_cdmii_rxclk_override_400G), 
    .physs_registers_wrapper_0_reset_cdmii_txclk_override_400G(physs_registers_wrapper_0_reset_cdmii_txclk_override_400G), 
    .physs_registers_wrapper_0_reset_sd_tx_clk_override_400G(physs_registers_wrapper_0_reset_sd_tx_clk_override_400G), 
    .physs_registers_wrapper_0_reset_sd_rx_clk_override_400G(physs_registers_wrapper_0_reset_sd_rx_clk_override_400G), 
    .physs_registers_wrapper_0_reset_reg_clk_override_400G(physs_registers_wrapper_0_reset_reg_clk_override_400G), 
    .physs_registers_wrapper_0_reset_reg_ref_clk_override_400G(physs_registers_wrapper_0_reset_reg_ref_clk_override_400G), 
    .physs_registers_wrapper_0_clk_gate_en_200G_mac_pcs_0(physs_registers_wrapper_0_clk_gate_en_200G_mac_pcs_0), 
    .physs_registers_wrapper_0_clk_gate_en_400G_mac_pcs_0(physs_registers_wrapper_0_clk_gate_en_400G_mac_pcs_0), 
    .physs_registers_wrapper_0_reset_pcs200_override_en(physs_registers_wrapper_0_reset_pcs200_override_en), 
    .physs_registers_wrapper_0_reset_pcs400_override_en(physs_registers_wrapper_0_reset_pcs400_override_en), 
    .physs_registers_wrapper_0_reset_mac200_override_en(physs_registers_wrapper_0_reset_mac200_override_en), 
    .physs_registers_wrapper_0_reset_mac400_override_en(physs_registers_wrapper_0_reset_mac400_override_en), 
    .physs_registers_wrapper_0_reset_reg_clk_override_mac_0(physs_registers_wrapper_0_reset_reg_clk_override_mac_0), 
    .physs_registers_wrapper_0_reset_ff_tx_clk_override_0(physs_registers_wrapper_0_reset_ff_tx_clk_override_0), 
    .physs_registers_wrapper_0_reset_ff_rx_clk_override_0(physs_registers_wrapper_0_reset_ff_rx_clk_override_0), 
    .physs_registers_wrapper_0_reset_txclk_override_0(physs_registers_wrapper_0_reset_txclk_override_0), 
    .physs_registers_wrapper_0_reset_rxclk_override_0(physs_registers_wrapper_0_reset_rxclk_override_0), 
    .physs_registers_wrapper_0_pcs_mode_config_pcs_external_loopback_en_lane_0(physs_registers_wrapper_0_pcs_mode_config_pcs_external_loopback_en_lane_0), 
    .versa_xmp_0_o_ucss_srds_pcs_tx_reset_pma1_l0_a(versa_xmp_0_o_ucss_srds_pcs_tx_reset_pma1_l0_a), 
    .versa_xmp_0_o_ucss_srds_pcs_tx_reset_pma3_l0_a(versa_xmp_0_o_ucss_srds_pcs_tx_reset_pma3_l0_a), 
    .versa_xmp_0_o_ucss_srds_pcs_rx_reset_pma1_l0_a(versa_xmp_0_o_ucss_srds_pcs_rx_reset_pma1_l0_a), 
    .versa_xmp_0_o_ucss_srds_pcs_rx_reset_pma3_l0_a(versa_xmp_0_o_ucss_srds_pcs_rx_reset_pma3_l0_a), 
    .physs_registers_wrapper_0_reset_ff_rx_override_MAC_800G(physs_registers_wrapper_0_reset_ff_rx_override_MAC_800G), 
    .physs_registers_wrapper_0_reset_ff_tx_override_MAC_800G(physs_registers_wrapper_0_reset_ff_tx_override_MAC_800G), 
    .physs_registers_wrapper_0_reset_reg_override_MAC_800G(physs_registers_wrapper_0_reset_reg_override_MAC_800G), 
    .physs_registers_wrapper_0_reset_ref_override_MAC_800G(physs_registers_wrapper_0_reset_ref_override_MAC_800G), 
    .physs_registers_wrapper_0_reset_sd_tx_clk_override_800G(physs_registers_wrapper_0_reset_sd_tx_clk_override_800G), 
    .physs_registers_wrapper_0_reset_sd_rx_clk_override_800G(physs_registers_wrapper_0_reset_sd_rx_clk_override_800G), 
    .physs_registers_wrapper_0_reset_ref_clk_override_PCS_800G(physs_registers_wrapper_0_reset_ref_clk_override_PCS_800G), 
    .physs_registers_wrapper_0_reset_ref_clk0_override_PCS_800G(physs_registers_wrapper_0_reset_ref_clk0_override_PCS_800G), 
    .physs_registers_wrapper_0_reset_ref_clk1_override_PCS_800G(physs_registers_wrapper_0_reset_ref_clk1_override_PCS_800G), 
    .physs_registers_wrapper_0_reset_reg_ref_clk_override_PCS_800G(physs_registers_wrapper_0_reset_reg_ref_clk_override_PCS_800G), 
    .physs_registers_wrapper_0_clk_gate_en_800G_mac_pcs_0(physs_registers_wrapper_0_clk_gate_en_800G_mac_pcs_0), 
    .mac100_0_magic_ind_0(mac100_0_magic_ind_0), 
    .mac100_1_magic_ind_0(mac100_1_magic_ind_0), 
    .mac100_2_magic_ind_0(mac100_2_magic_ind_0), 
    .mac100_3_magic_ind_0(mac100_3_magic_ind_0), 
    .icq_physs_net_xoff(icq_physs_net_xoff), 
    .icq_physs_net_xoff_0(icq_physs_net_xoff_0), 
    .icq_physs_net_xoff_1(icq_physs_net_xoff_1), 
    .icq_physs_net_xoff_2(icq_physs_net_xoff_2), 
    .mac100_0_pause_on_0(mac100_0_pause_on_0), 
    .mac100_1_pause_on_0(mac100_1_pause_on_0), 
    .mac100_2_pause_on_0(mac100_2_pause_on_0), 
    .mac100_3_pause_on_0(mac100_3_pause_on_0), 
    .versa_xmp_0_o_ucss_uart_txd(versa_xmp_0_o_ucss_uart_txd), 
    .physs_uart_demux_out0(physs_uart_demux_out0), 
    .physs_registers_wrapper_0_uart_port_mux_sel_uart_mux_sel_1(physs_registers_wrapper_0_uart_port_mux_sel_uart_mux_sel_1), 
    .physs_registers_wrapper_0_uart_port_mux_sel_uart_mux_sel_2(physs_registers_wrapper_0_uart_port_mux_sel_uart_mux_sel_2), 
    .fary_0_post_force_fail(fary_0_post_force_fail), 
    .fary_0_trigger_post(fary_0_trigger_post), 
    .fary_0_post_algo_select(fary_0_post_algo_select), 
    .xmp_mem_wrapper_0_aary_post_pass(xmp_mem_wrapper_0_aary_post_pass), 
    .xmp_mem_wrapper_0_aary_post_complete(xmp_mem_wrapper_0_aary_post_complete), 
    .fary_1_post_force_fail(fary_1_post_force_fail), 
    .fary_1_trigger_post(fary_1_trigger_post), 
    .fary_1_post_algo_select(fary_1_post_algo_select), 
    .pcs100_mem_wrapper_0_aary_post_pass(pcs100_mem_wrapper_0_aary_post_pass), 
    .pcs100_mem_wrapper_0_aary_post_complete(pcs100_mem_wrapper_0_aary_post_complete), 
    .fary_2_post_force_fail(fary_2_post_force_fail), 
    .fary_2_trigger_post(fary_2_trigger_post), 
    .fary_2_post_algo_select(fary_2_post_algo_select), 
    .ptpx_mem_wrapper_0_aary_post_pass(ptpx_mem_wrapper_0_aary_post_pass), 
    .ptpx_mem_wrapper_0_aary_post_complete(ptpx_mem_wrapper_0_aary_post_complete), 
    .fary_3_post_force_fail(fary_3_post_force_fail), 
    .fary_3_trigger_post(fary_3_trigger_post), 
    .fary_3_post_algo_select(fary_3_post_algo_select), 
    .mac100_mem_wrapper_0_aary_post_pass(mac100_mem_wrapper_0_aary_post_pass), 
    .mac100_mem_wrapper_0_aary_post_complete(mac100_mem_wrapper_0_aary_post_complete), 
    .parmquad0_o_ck_pma0_rx_dfx_ubp_ctrl_act_out_4(parmisc_physs0_trig_clock_stop_to_parmquad0_o_ck_pma0_rx), 
    .parmquad0_o_ck_pma1_rx_dfx_ubp_ctrl_act_out_5(parmisc_physs0_trig_clock_stop_to_parmquad0_o_ck_pma1_rx), 
    .parmquad0_o_ck_pma2_rx_dfx_ubp_ctrl_act_out_6(parmisc_physs0_trig_clock_stop_to_parmquad0_o_ck_pma2_rx), 
    .parmquad0_o_ck_pma3_rx_dfx_ubp_ctrl_act_out_7(parmisc_physs0_trig_clock_stop_to_parmquad0_o_ck_pma3_rx), 
    .parmquad0_pma0_rxdat_dfx_ubp_ctrl_act_out_8(parmisc_physs0_trig_clock_stop_to_parmquad0_pma0_rxdat), 
    .parmquad0_pma1_rxdat_dfx_ubp_ctrl_act_out_9(parmisc_physs0_trig_clock_stop_to_parmquad0_pma1_rxdat), 
    .parmquad0_pma2_rxdat_dfx_ubp_ctrl_act_out_10(parmisc_physs0_trig_clock_stop_to_parmquad0_pma2_rxdat), 
    .parmquad0_pma3_rxdat_dfx_ubp_ctrl_act_out_11(parmisc_physs0_trig_clock_stop_to_parmquad0_pma3_rxdat), 
    .parmquad0_o_ck_pma0_cmnplla_postdiv_dfx_ubp_ctrl_act_out_12(parmisc_physs0_trig_clock_stop_to_parmquad0_o_ck_pma0_cmnplla_postdiv), 
    .parmquad0_o_ck_pma1_cmnplla_postdiv_dfx_ubp_ctrl_act_out_13(parmisc_physs0_trig_clock_stop_to_parmquad0_o_ck_pma1_cmnplla_postdiv), 
    .parmquad0_o_ck_pma2_cmnplla_postdiv_dfx_ubp_ctrl_act_out_14(parmisc_physs0_trig_clock_stop_to_parmquad0_o_ck_pma2_cmnplla_postdiv), 
    .parmquad0_o_ck_pma3_cmnplla_postdiv_dfx_ubp_ctrl_act_out_15(parmisc_physs0_trig_clock_stop_to_parmquad0_o_ck_pma3_cmnplla_postdiv), 
    .parmquad0_o_ck_slv_pcs1_rx_dfx_ubp_ctrl_act_out_16(parmisc_physs0_trig_clock_stop_to_parmquad0_o_ck_slv_pcs1), 
    .parmquad0_o_ck_ucss_mem_dram_dfx_ubp_ctrl_act_out_17(parmisc_physs0_trig_clock_stop_to_parmquad0_o_ck_ucss_mem_dram), 
    .parmquad0_o_ck_ucss_mem_iram_dfx_ubp_ctrl_act_out_18(parmisc_physs0_trig_clock_stop_to_parmquad0_o_ck_ucss_mem_iram), 
    .parmquad0_o_ck_ucss_mem_traceram_dfx_ubp_ctrl_act_out_19(parmisc_physs0_trig_clock_stop_to_parmquad0_o_ck_ucss_mem_tracemem), 
    .pcs_lane_sel_val_par400g0_rtdr(parmquad0_pcs_lane_sel_val_par400g0_rtdr), 
    .pcs_lane_sel_ovr_par400g0_rtdr(parmquad0_pcs_lane_sel_ovr_par400g0_rtdr), 
    .physs_registers_wrapper_0_pcs800_config_400_8_en_in(physs_registers_wrapper_0_pcs800_config_400_8_en_in), 
    .physs_registers_wrapper_0_pcs800_config_400_en_in(physs_registers_wrapper_0_pcs800_config_400_en_in), 
    .physs_registers_wrapper_0_pcs800_config_200_4_en_in(physs_registers_wrapper_0_pcs800_config_200_4_en_in), 
    .physs_registers_wrapper_0_pcs800_config_cdmii8blk(physs_registers_wrapper_0_pcs800_config_cdmii8blk), 
    .physs_registers_wrapper_0_pcs800_config_200_mode_ll(physs_registers_wrapper_0_pcs800_config_200_mode_ll), 
    .physs_registers_wrapper_0_pcs800_config_loopback(physs_registers_wrapper_0_pcs800_config_loopback), 
    .physs_registers_wrapper_0_pcs800_config_loopback_rev(physs_registers_wrapper_0_pcs800_config_loopback_rev), 
    .physs_registers_wrapper_0_mac800_ref_clkx2_en(physs_registers_wrapper_0_mac800_ref_clkx2_en), 
    .physs_registers_wrapper_0_mac800_mode1s_ena(physs_registers_wrapper_0_mac800_mode1s_ena), 
    .physs_registers_wrapper_0_mac800_tx_loc_fault(physs_registers_wrapper_0_mac800_tx_loc_fault), 
    .physs_registers_wrapper_0_mac800_tx_rem_fault(physs_registers_wrapper_0_mac800_tx_rem_fault), 
    .physs_registers_wrapper_0_mac800_tx_li_fault(physs_registers_wrapper_0_mac800_tx_li_fault), 
    .physs_registers_wrapper_0_mac800_xoff_gen(physs_registers_wrapper_0_mac800_xoff_gen), 
    .physs_registers_wrapper_0_mac800_tx_smhold(physs_registers_wrapper_0_mac800_tx_smhold), 
    .mac800_pause_on(mac800_pause_on), 
    .mac800_pfc_mode(mac800_pfc_mode), 
    .mac800_tx_ovr_err(mac800_tx_ovr_err), 
    .mac800_tx_underflow(mac800_tx_underflow), 
    .mac800_tx_empty(mac800_tx_empty), 
    .mac800_tx_isidle(mac800_tx_isidle), 
    .mac800_mdio_oen(mac800_mdio_oen), 
    .mac800_loc_fault(mac800_loc_fault), 
    .mac800_rem_fault(mac800_rem_fault), 
    .mac800_li_fault(mac800_li_fault), 
    .mac800_inv_loop_ind(mac800_inv_loop_ind), 
    .mac800_frm_drop(mac800_frm_drop), 
    .mac800_ff_tx_septy(mac800_ff_tx_septy), 
    .mac800_ff_tx_credit(mac800_ff_tx_credit), 
    .mac800_ff_rx_dsav(mac800_ff_rx_dsav), 
    .mac800_ff_rx_empty(mac800_ff_rx_empty), 
    .mac800_tx_ts_val(mac800_tx_ts_val), 
    .mac800_tx_ts_id(mac800_tx_ts_id), 
    .mac800_tx_ts(mac800_tx_ts), 
    .pcs800_p80_align_lock(pcs800_p80_align_lock), 
    .pcs800_p80_amps_lock(pcs800_p80_amps_lock), 
    .pcs800_p80_link_status_0(pcs800_p80_link_status_0), 
    .pcs800_p80_hi_ser(pcs800_p80_hi_ser), 
    .pcs800_p80_degrade_ser_0(pcs800_p80_degrade_ser_0), 
    .pcs800_p80_rx_am_sf(pcs800_p80_rx_am_sf), 
    .pcs800_p81_align_lock(pcs800_p81_align_lock), 
    .pcs800_p81_amps_lock(pcs800_p81_amps_lock), 
    .pcs800_p81_link_status_0(pcs800_p81_link_status_0), 
    .pcs800_p81_hi_ser(pcs800_p81_hi_ser), 
    .pcs800_p81_degrade_ser_0(pcs800_p81_degrade_ser_0), 
    .pcs800_p81_rx_am_sf(pcs800_p81_rx_am_sf), 
    .quadpcs100_0_pcs_desk_buf_rlevel_0(quadpcs100_0_pcs_desk_buf_rlevel_0), 
    .quadpcs100_0_pcs_sd_bit_slip_0(quadpcs100_0_pcs_sd_bit_slip_0), 
    .quadpcs100_0_pcs_link_status_tsu_0(quadpcs100_0_pcs_link_status_tsu_0), 
    .physs_timestamp_0_timer_refpcs_0(physs_timestamp_0_timer_refpcs_0), 
    .physs_timestamp_0_timer_refpcs_1(physs_timestamp_0_timer_refpcs_1), 
    .physs_timestamp_0_timer_refpcs_2(physs_timestamp_0_timer_refpcs_2), 
    .physs_timestamp_0_timer_refpcs_3(physs_timestamp_0_timer_refpcs_3), 
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
    .quad_interrupts_0_physs_fatal_int(quad_interrupts_0_physs_fatal_int), 
    .quad_interrupts_0_physs_imc_int(quad_interrupts_0_physs_imc_int), 
    .quad_interrupts_0_mac800_int(quad_interrupts_0_mac800_int), 
    .mac100_0_ff_rx_err_stat_0(mac100_0_ff_rx_err_stat_0), 
    .mac100_1_ff_rx_err_stat_0(mac100_1_ff_rx_err_stat_0), 
    .mac100_2_ff_rx_err_stat_0(mac100_2_ff_rx_err_stat_0), 
    .mac100_3_ff_rx_err_stat_0(mac100_3_ff_rx_err_stat_0), 
    .versa_xmp_0_o_ucss_irq_cpi_0_a(versa_xmp_0_o_ucss_irq_cpi_0_a), 
    .versa_xmp_0_o_ucss_irq_cpi_1_a(versa_xmp_0_o_ucss_irq_cpi_1_a), 
    .versa_xmp_0_o_ucss_irq_cpi_2_a(versa_xmp_0_o_ucss_irq_cpi_2_a), 
    .versa_xmp_0_o_ucss_irq_cpi_3_a(versa_xmp_0_o_ucss_irq_cpi_3_a), 
    .versa_xmp_0_o_ucss_irq_cpi_4_a(versa_xmp_0_o_ucss_irq_cpi_4_a), 
    .versa_xmp_0_o_ucss_irq_to_soc_l0_a(versa_xmp_0_o_ucss_irq_to_soc_l0_a), 
    .versa_xmp_0_o_ucss_irq_to_soc_l1_a(versa_xmp_0_o_ucss_irq_to_soc_l1_a), 
    .versa_xmp_0_o_ucss_irq_to_soc_l2_a(versa_xmp_0_o_ucss_irq_to_soc_l2_a), 
    .versa_xmp_0_o_ucss_irq_to_soc_l3_a(versa_xmp_0_o_ucss_irq_to_soc_l3_a), 
    .physs_core_rst_fsm_0_enable_link_traffic_to_nss_reg_clr(physs_core_rst_fsm_0_enable_link_traffic_to_nss_reg_clr), 
    .physs_registers_wrapper_0_link_traffic_to_nss_enable_O(physs_registers_wrapper_0_link_traffic_to_nss_enable_O), 
    .physs_registers_wrapper_0_ETH_GLTSYN_SHTIME_L_0_tsyntime_0_0(physs_registers_wrapper_0_ETH_GLTSYN_SHTIME_L_0_tsyntime_0_0), 
    .physs_registers_wrapper_0_ETH_GLTSYN_SHTIME_H_0_tsyntime_l_0(physs_registers_wrapper_0_ETH_GLTSYN_SHTIME_H_0_tsyntime_l_0), 
    .physs_registers_wrapper_0_ETH_GLTSYN_INCVAL_L_0_incval_l_0_0(physs_registers_wrapper_0_ETH_GLTSYN_INCVAL_L_0_incval_l_0_0), 
    .physs_registers_wrapper_0_ETH_GLTSYN_INCVAL_H_0_incval_h_0_0(physs_registers_wrapper_0_ETH_GLTSYN_INCVAL_H_0_incval_h_0_0), 
    .physs_registers_wrapper_0_ETH_GLTSYN_SHADJ_L_0_adjust_l_0(physs_registers_wrapper_0_ETH_GLTSYN_SHADJ_L_0_adjust_l_0), 
    .physs_registers_wrapper_0_ETH_GLTSYN_SHADJ_H_0_adjust_h_0(physs_registers_wrapper_0_ETH_GLTSYN_SHADJ_H_0_adjust_h_0), 
    .physs_registers_wrapper_0_ETH_GLTSYN_TIME_0_0_tsyntime_0_0(physs_registers_wrapper_0_ETH_GLTSYN_TIME_0_0_tsyntime_0_0), 
    .physs_registers_wrapper_0_ETH_GLTSYN_TIME_L_0_tsyntime_l_0(physs_registers_wrapper_0_ETH_GLTSYN_TIME_L_0_tsyntime_l_0), 
    .physs_registers_wrapper_0_ETH_GLTSYN_ENA_0_tsyn_ena_0(physs_registers_wrapper_0_ETH_GLTSYN_ENA_0_tsyn_ena_0), 
    .physs_registers_wrapper_0_ETH_GLTSYN_CMD_0_cmd_0(physs_registers_wrapper_0_ETH_GLTSYN_CMD_0_cmd_0), 
    .physs_registers_wrapper_0_ETH_GLTSYN_SYNC_DLAY_0_sync_delay_0(physs_registers_wrapper_0_ETH_GLTSYN_SYNC_DLAY_0_sync_delay_0), 
    .physs_registers_wrapper_0_TIMER_REFPCS_INCVAL_H_0_incval_h_0_0(physs_registers_wrapper_0_TIMER_REFPCS_INCVAL_H_0_incval_h_0_0), 
    .physs_registers_wrapper_0_TIMER_REFPCS_INCVAL_L_0_incval_l_0_0(physs_registers_wrapper_0_TIMER_REFPCS_INCVAL_L_0_incval_l_0_0), 
    .physs_registers_wrapper_0_REFPCS_TIMER_CTRL_0_func_timer_err_chk_dis_0(physs_registers_wrapper_0_REFPCS_TIMER_CTRL_0_func_timer_err_chk_dis_0), 
    .physs_registers_wrapper_0_REFPCS_TIMER_CTRL_0_samp_1588_and_refpcs_timer_0(physs_registers_wrapper_0_REFPCS_TIMER_CTRL_0_samp_1588_and_refpcs_timer_0), 
    .physs_registers_wrapper_0_REFPCS_TIMER_CTRL_1_sync1588_pulse_interval(physs_registers_wrapper_0_REFPCS_TIMER_CTRL_1_sync1588_pulse_interval), 
    .physs_registers_wrapper_0_REFPCS_TIMER_CTRL_0_ts_valid_if_timer_en_0(physs_registers_wrapper_0_REFPCS_TIMER_CTRL_0_ts_valid_if_timer_en_0), 
    .nic_switch_mux_0_hlp_xlgmii0_txclk_ena(nic_switch_mux_0_hlp_xlgmii0_txclk_ena), 
    .nic_switch_mux_0_hlp_xlgmii0_rxclk_ena(nic_switch_mux_0_hlp_xlgmii0_rxclk_ena), 
    .nic_switch_mux_0_hlp_xlgmii0_rxc(nic_switch_mux_0_hlp_xlgmii0_rxc), 
    .nic_switch_mux_0_hlp_xlgmii0_rxd(nic_switch_mux_0_hlp_xlgmii0_rxd), 
    .nic_switch_mux_0_hlp_xlgmii0_rxt0_next(nic_switch_mux_0_hlp_xlgmii0_rxt0_next), 
    .pcs_mac_pipeline_top_wrap_mquad0_pcs0_xlgmii_tx_txc(pcs_mac_pipeline_top_wrap_mquad0_pcs0_xlgmii_tx_txc), 
    .pcs_mac_pipeline_top_wrap_mquad0_pcs0_xlgmii_tx_txd(pcs_mac_pipeline_top_wrap_mquad0_pcs0_xlgmii_tx_txd), 
    .quadpcs100_0_pcs_tsu_rx_sd_0(quadpcs100_0_pcs_tsu_rx_sd_0), 
    .quadpcs100_0_mii_rx_tsu_mux0_0(quadpcs100_0_mii_rx_tsu_mux0_0), 
    .quadpcs100_0_mii_tx_tsu_0(quadpcs100_0_mii_tx_tsu_0), 
    .nic_switch_mux_0_hlp_xlgmii1_txclk_ena(nic_switch_mux_0_hlp_xlgmii1_txclk_ena), 
    .nic_switch_mux_0_hlp_xlgmii1_rxclk_ena(nic_switch_mux_0_hlp_xlgmii1_rxclk_ena), 
    .nic_switch_mux_0_hlp_xlgmii1_rxc(nic_switch_mux_0_hlp_xlgmii1_rxc), 
    .nic_switch_mux_0_hlp_xlgmii1_rxd(nic_switch_mux_0_hlp_xlgmii1_rxd), 
    .nic_switch_mux_0_hlp_xlgmii1_rxt0_next(nic_switch_mux_0_hlp_xlgmii1_rxt0_next), 
    .pcs_mac_pipeline_top_wrap_mquad0_pcs1_xlgmii_tx_txc(pcs_mac_pipeline_top_wrap_mquad0_pcs1_xlgmii_tx_txc), 
    .pcs_mac_pipeline_top_wrap_mquad0_pcs1_xlgmii_tx_txd(pcs_mac_pipeline_top_wrap_mquad0_pcs1_xlgmii_tx_txd), 
    .quadpcs100_0_pcs_tsu_rx_sd_1(quadpcs100_0_pcs_tsu_rx_sd_1), 
    .quadpcs100_0_mii_rx_tsu_mux1_0(quadpcs100_0_mii_rx_tsu_mux1_0), 
    .quadpcs100_0_mii_tx_tsu_1(quadpcs100_0_mii_tx_tsu_1), 
    .nic_switch_mux_0_hlp_xlgmii2_txclk_ena(nic_switch_mux_0_hlp_xlgmii2_txclk_ena), 
    .nic_switch_mux_0_hlp_xlgmii2_rxclk_ena(nic_switch_mux_0_hlp_xlgmii2_rxclk_ena), 
    .nic_switch_mux_0_hlp_xlgmii2_rxc(nic_switch_mux_0_hlp_xlgmii2_rxc), 
    .nic_switch_mux_0_hlp_xlgmii2_rxd(nic_switch_mux_0_hlp_xlgmii2_rxd), 
    .nic_switch_mux_0_hlp_xlgmii2_rxt0_next(nic_switch_mux_0_hlp_xlgmii2_rxt0_next), 
    .pcs_mac_pipeline_top_wrap_mquad0_pcs2_xlgmii_tx_txc(pcs_mac_pipeline_top_wrap_mquad0_pcs2_xlgmii_tx_txc), 
    .pcs_mac_pipeline_top_wrap_mquad0_pcs2_xlgmii_tx_txd(pcs_mac_pipeline_top_wrap_mquad0_pcs2_xlgmii_tx_txd), 
    .quadpcs100_0_pcs_tsu_rx_sd_2(quadpcs100_0_pcs_tsu_rx_sd_2), 
    .quadpcs100_0_mii_rx_tsu_mux2_0(quadpcs100_0_mii_rx_tsu_mux2_0), 
    .quadpcs100_0_mii_tx_tsu_2(quadpcs100_0_mii_tx_tsu_2), 
    .nic_switch_mux_0_hlp_xlgmii3_txclk_ena(nic_switch_mux_0_hlp_xlgmii3_txclk_ena), 
    .nic_switch_mux_0_hlp_xlgmii3_rxclk_ena(nic_switch_mux_0_hlp_xlgmii3_rxclk_ena), 
    .nic_switch_mux_0_hlp_xlgmii3_rxc(nic_switch_mux_0_hlp_xlgmii3_rxc), 
    .nic_switch_mux_0_hlp_xlgmii3_rxd(nic_switch_mux_0_hlp_xlgmii3_rxd), 
    .nic_switch_mux_0_hlp_xlgmii3_rxt0_next(nic_switch_mux_0_hlp_xlgmii3_rxt0_next), 
    .pcs_mac_pipeline_top_wrap_mquad0_pcs3_xlgmii_tx_txc(pcs_mac_pipeline_top_wrap_mquad0_pcs3_xlgmii_tx_txc), 
    .pcs_mac_pipeline_top_wrap_mquad0_pcs3_xlgmii_tx_txd(pcs_mac_pipeline_top_wrap_mquad0_pcs3_xlgmii_tx_txd), 
    .quadpcs100_0_pcs_tsu_rx_sd_3(quadpcs100_0_pcs_tsu_rx_sd_3), 
    .quadpcs100_0_mii_rx_tsu_mux3_0(quadpcs100_0_mii_rx_tsu_mux3_0), 
    .quadpcs100_0_mii_tx_tsu_3(quadpcs100_0_mii_tx_tsu_3), 
    .nic_switch_mux_0_hlp_cgmii0_txclk_ena(nic_switch_mux_0_hlp_cgmii0_txclk_ena), 
    .nic_switch_mux_0_hlp_cgmii0_rxclk_ena(nic_switch_mux_0_hlp_cgmii0_rxclk_ena), 
    .nic_switch_mux_0_hlp_cgmii0_rxc(nic_switch_mux_0_hlp_cgmii0_rxc), 
    .nic_switch_mux_0_hlp_cgmii0_rxd(nic_switch_mux_0_hlp_cgmii0_rxd), 
    .pcs_mac_pipeline_top_wrap_mquad0_pcs0_cgmii_tx_txc(pcs_mac_pipeline_top_wrap_mquad0_pcs0_cgmii_tx_txc), 
    .pcs_mac_pipeline_top_wrap_mquad0_pcs0_cgmii_tx_txd(pcs_mac_pipeline_top_wrap_mquad0_pcs0_cgmii_tx_txd), 
    .nic_switch_mux_0_hlp_cgmii1_txclk_ena(nic_switch_mux_0_hlp_cgmii1_txclk_ena), 
    .nic_switch_mux_0_hlp_cgmii1_rxclk_ena(nic_switch_mux_0_hlp_cgmii1_rxclk_ena), 
    .nic_switch_mux_0_hlp_cgmii1_rxc(nic_switch_mux_0_hlp_cgmii1_rxc), 
    .nic_switch_mux_0_hlp_cgmii1_rxd(nic_switch_mux_0_hlp_cgmii1_rxd), 
    .pcs_mac_pipeline_top_wrap_mquad0_pcs1_cgmii_tx_txc(pcs_mac_pipeline_top_wrap_mquad0_pcs1_cgmii_tx_txc), 
    .pcs_mac_pipeline_top_wrap_mquad0_pcs1_cgmii_tx_txd(pcs_mac_pipeline_top_wrap_mquad0_pcs1_cgmii_tx_txd), 
    .nic_switch_mux_0_hlp_cgmii2_txclk_ena(nic_switch_mux_0_hlp_cgmii2_txclk_ena), 
    .nic_switch_mux_0_hlp_cgmii2_rxclk_ena(nic_switch_mux_0_hlp_cgmii2_rxclk_ena), 
    .nic_switch_mux_0_hlp_cgmii2_rxc(nic_switch_mux_0_hlp_cgmii2_rxc), 
    .nic_switch_mux_0_hlp_cgmii2_rxd(nic_switch_mux_0_hlp_cgmii2_rxd), 
    .pcs_mac_pipeline_top_wrap_mquad0_pcs2_cgmii_tx_txc(pcs_mac_pipeline_top_wrap_mquad0_pcs2_cgmii_tx_txc), 
    .pcs_mac_pipeline_top_wrap_mquad0_pcs2_cgmii_tx_txd(pcs_mac_pipeline_top_wrap_mquad0_pcs2_cgmii_tx_txd), 
    .nic_switch_mux_0_hlp_cgmii3_txclk_ena(nic_switch_mux_0_hlp_cgmii3_txclk_ena), 
    .nic_switch_mux_0_hlp_cgmii3_rxclk_ena(nic_switch_mux_0_hlp_cgmii3_rxclk_ena), 
    .nic_switch_mux_0_hlp_cgmii3_rxc(nic_switch_mux_0_hlp_cgmii3_rxc), 
    .nic_switch_mux_0_hlp_cgmii3_rxd(nic_switch_mux_0_hlp_cgmii3_rxd), 
    .pcs_mac_pipeline_top_wrap_mquad0_pcs3_cgmii_tx_txc(pcs_mac_pipeline_top_wrap_mquad0_pcs3_cgmii_tx_txc), 
    .pcs_mac_pipeline_top_wrap_mquad0_pcs3_cgmii_tx_txd(pcs_mac_pipeline_top_wrap_mquad0_pcs3_cgmii_tx_txd), 
    .pcs_mac_pipeline_top_wrap_nss_mac0_xlgmii_rx_rxc(pcs_mac_pipeline_top_wrap_nss_mac0_xlgmii_rx_rxc), 
    .pcs_mac_pipeline_top_wrap_nss_mac0_xlgmii_rx_rxd(pcs_mac_pipeline_top_wrap_nss_mac0_xlgmii_rx_rxd), 
    .nic_switch_mux_0_hlp_xlgmii0_txc_nss(nic_switch_mux_0_hlp_xlgmii0_txc_nss), 
    .nic_switch_mux_0_hlp_xlgmii0_txd_nss(nic_switch_mux_0_hlp_xlgmii0_txd_nss), 
    .pcs_mac_pipeline_top_wrap_nss_mac1_xlgmii_rx_rxc(pcs_mac_pipeline_top_wrap_nss_mac1_xlgmii_rx_rxc), 
    .pcs_mac_pipeline_top_wrap_nss_mac1_xlgmii_rx_rxd(pcs_mac_pipeline_top_wrap_nss_mac1_xlgmii_rx_rxd), 
    .nic_switch_mux_0_hlp_xlgmii1_txc_nss(nic_switch_mux_0_hlp_xlgmii1_txc_nss), 
    .nic_switch_mux_0_hlp_xlgmii1_txd_nss(nic_switch_mux_0_hlp_xlgmii1_txd_nss), 
    .pcs_mac_pipeline_top_wrap_nss_mac2_xlgmii_rx_rxc(pcs_mac_pipeline_top_wrap_nss_mac2_xlgmii_rx_rxc), 
    .pcs_mac_pipeline_top_wrap_nss_mac2_xlgmii_rx_rxd(pcs_mac_pipeline_top_wrap_nss_mac2_xlgmii_rx_rxd), 
    .nic_switch_mux_0_hlp_xlgmii2_txc_nss(nic_switch_mux_0_hlp_xlgmii2_txc_nss), 
    .nic_switch_mux_0_hlp_xlgmii2_txd_nss(nic_switch_mux_0_hlp_xlgmii2_txd_nss), 
    .pcs_mac_pipeline_top_wrap_nss_mac3_xlgmii_rx_rxc(pcs_mac_pipeline_top_wrap_nss_mac3_xlgmii_rx_rxc), 
    .pcs_mac_pipeline_top_wrap_nss_mac3_xlgmii_rx_rxd(pcs_mac_pipeline_top_wrap_nss_mac3_xlgmii_rx_rxd), 
    .nic_switch_mux_0_hlp_xlgmii3_txc_nss(nic_switch_mux_0_hlp_xlgmii3_txc_nss), 
    .nic_switch_mux_0_hlp_xlgmii3_txd_nss(nic_switch_mux_0_hlp_xlgmii3_txd_nss), 
    .pcs_mac_pipeline_top_wrap_nss_mac0_cgmii_rx_rxc(pcs_mac_pipeline_top_wrap_nss_mac0_cgmii_rx_rxc), 
    .pcs_mac_pipeline_top_wrap_nss_mac0_cgmii_rx_rxd(pcs_mac_pipeline_top_wrap_nss_mac0_cgmii_rx_rxd), 
    .nic_switch_mux_0_hlp_cgmii0_txc_nss(nic_switch_mux_0_hlp_cgmii0_txc_nss), 
    .nic_switch_mux_0_hlp_cgmii0_txd_nss(nic_switch_mux_0_hlp_cgmii0_txd_nss), 
    .pcs_mac_pipeline_top_wrap_nss_mac1_cgmii_rx_rxc(pcs_mac_pipeline_top_wrap_nss_mac1_cgmii_rx_rxc), 
    .pcs_mac_pipeline_top_wrap_nss_mac1_cgmii_rx_rxd(pcs_mac_pipeline_top_wrap_nss_mac1_cgmii_rx_rxd), 
    .nic_switch_mux_0_hlp_cgmii1_txc_nss(nic_switch_mux_0_hlp_cgmii1_txc_nss), 
    .nic_switch_mux_0_hlp_cgmii1_txd_nss(nic_switch_mux_0_hlp_cgmii1_txd_nss), 
    .pcs_mac_pipeline_top_wrap_nss_mac2_cgmii_rx_rxc(pcs_mac_pipeline_top_wrap_nss_mac2_cgmii_rx_rxc), 
    .pcs_mac_pipeline_top_wrap_nss_mac2_cgmii_rx_rxd(pcs_mac_pipeline_top_wrap_nss_mac2_cgmii_rx_rxd), 
    .nic_switch_mux_0_hlp_cgmii2_txc_nss(nic_switch_mux_0_hlp_cgmii2_txc_nss), 
    .nic_switch_mux_0_hlp_cgmii2_txd_nss(nic_switch_mux_0_hlp_cgmii2_txd_nss), 
    .pcs_mac_pipeline_top_wrap_nss_mac3_cgmii_rx_rxc(pcs_mac_pipeline_top_wrap_nss_mac3_cgmii_rx_rxc), 
    .pcs_mac_pipeline_top_wrap_nss_mac3_cgmii_rx_rxd(pcs_mac_pipeline_top_wrap_nss_mac3_cgmii_rx_rxd), 
    .nic_switch_mux_0_hlp_cgmii3_txc_nss(nic_switch_mux_0_hlp_cgmii3_txc_nss), 
    .nic_switch_mux_0_hlp_cgmii3_txd_nss(nic_switch_mux_0_hlp_cgmii3_txd_nss), 
    .physs_pcs_mux_200_400_0_tx_ts_val(physs_pcs_mux_200_400_0_tx_ts_val), 
    .physs_pcs_mux_200_400_0_tx_ts_id_0(physs_pcs_mux_200_400_0_tx_ts_id_0), 
    .physs_pcs_mux_200_400_0_tx_ts_id_1(physs_pcs_mux_200_400_0_tx_ts_id_1), 
    .physs_pcs_mux_200_400_0_tx_ts_id_2(physs_pcs_mux_200_400_0_tx_ts_id_2), 
    .physs_pcs_mux_200_400_0_tx_ts_id_3(physs_pcs_mux_200_400_0_tx_ts_id_3), 
    .physs_pcs_mux_200_400_0_tx_ts_0(physs_pcs_mux_200_400_0_tx_ts_0), 
    .physs_pcs_mux_200_400_0_tx_ts_1(physs_pcs_mux_200_400_0_tx_ts_1), 
    .physs_pcs_mux_200_400_0_tx_ts_2(physs_pcs_mux_200_400_0_tx_ts_2), 
    .physs_pcs_mux_200_400_0_tx_ts_3(physs_pcs_mux_200_400_0_tx_ts_3), 
    .fifo_mux_0_mac100g_0_tx_ts_frm(fifo_mux_0_mac100g_0_tx_ts_frm), 
    .fifo_mux_0_mac100g_0_tx_id(fifo_mux_0_mac100g_0_tx_id), 
    .fifo_mux_0_mac100g_1_tx_ts_frm(fifo_mux_0_mac100g_1_tx_ts_frm), 
    .fifo_mux_0_mac100g_1_tx_id(fifo_mux_0_mac100g_1_tx_id), 
    .fifo_mux_0_mac100g_2_tx_ts_frm(fifo_mux_0_mac100g_2_tx_ts_frm), 
    .fifo_mux_0_mac100g_2_tx_id(fifo_mux_0_mac100g_2_tx_id), 
    .fifo_mux_0_mac100g_3_tx_ts_frm(fifo_mux_0_mac100g_3_tx_ts_frm), 
    .fifo_mux_0_mac100g_3_tx_id(fifo_mux_0_mac100g_3_tx_id), 
    .physs_registers_wrapper_0_pcs_mode_config_lane_revsersal_mux_quad_0(physs_registers_wrapper_0_pcs_mode_config_lane_revsersal_mux_quad_0), 
    .physs_pcs_mux_0_srds_rdy_out_800G(physs_pcs_mux_0_srds_rdy_out_800G), 
    .physs_registers_wrapper_0_pcs_xmp_align_done_sync(physs_registers_wrapper_0_pcs_xmp_align_done_sync), 
    .physs_registers_wrapper_0_pcs_xmp_hi_ber_sync(physs_registers_wrapper_0_pcs_xmp_hi_ber_sync), 
    .physs_registers_wrapper_0_pcs_xmp_block_lock_sync(physs_registers_wrapper_0_pcs_xmp_block_lock_sync), 
    .physs_pipeline_reg_800g_misc_0_data_out(physs_pipeline_reg_800g_misc_0_data_out), 
    .physs_pipeline_reg_800g_misc_1_data_out(physs_pipeline_reg_800g_misc_1_data_out), 
    .physs_pipeline_reg_800g_misc_2_data_out(physs_pipeline_reg_800g_misc_2_data_out), 
    .physs_pipeline_reg_800g_misc_3_data_out(physs_pipeline_reg_800g_misc_3_data_out), 
    .physs_mux_800G_link_status_out(physs_mux_800G_link_status_out), 
    .physs_mux_800G_pcs_align_done_out(physs_mux_800G_pcs_align_done_out), 
    .physs_mux_800G_pcs_hi_ber_out(physs_mux_800G_pcs_hi_ber_out), 
    .physs_mux_800G_pcs_block_lock_out(physs_mux_800G_pcs_block_lock_out), 
    .physs_pipeline_reg_800g_8_data_out(physs_pipeline_reg_800g_8_data_out), 
    .physs_pipeline_reg_800g_9_data_out(physs_pipeline_reg_800g_9_data_out), 
    .physs_pipeline_reg_800g_10_data_out(physs_pipeline_reg_800g_10_data_out), 
    .physs_pipeline_reg_800g_11_data_out(physs_pipeline_reg_800g_11_data_out), 
    .physs_pcs_mux_200_400_0_sd0_tx_data_o(physs_pcs_mux_200_400_0_sd0_tx_data_o), 
    .physs_pcs_mux_200_400_0_sd1_tx_data_o(physs_pcs_mux_200_400_0_sd1_tx_data_o), 
    .physs_pcs_mux_200_400_0_sd2_tx_data_o(physs_pcs_mux_200_400_0_sd2_tx_data_o), 
    .physs_pcs_mux_200_400_0_sd3_tx_data_o(physs_pcs_mux_200_400_0_sd3_tx_data_o), 
    .physs_pipeline_reg_4_data_out(physs_pipeline_reg_4_data_out), 
    .physs_pipeline_reg_5_data_out(physs_pipeline_reg_5_data_out), 
    .physs_pipeline_reg_6_data_out(physs_pipeline_reg_6_data_out), 
    .physs_pipeline_reg_7_data_out(physs_pipeline_reg_7_data_out), 
    .physs_lane_reversal_mux_0_oflux_srds_rdy_out(physs_lane_reversal_mux_0_oflux_srds_rdy_out), 
    .physs_pcs_mux_200_400_0_link_status_out(physs_pcs_mux_200_400_0_link_status_out), 
    .physs_link_speed_decoder_0_link_speed_out(physs_link_speed_decoder_0_link_speed_out), 
    .physs_link_speed_decoder_1_link_speed_out(physs_link_speed_decoder_1_link_speed_out), 
    .physs_link_speed_decoder_2_link_speed_out(physs_link_speed_decoder_2_link_speed_out), 
    .physs_link_speed_decoder_3_link_speed_out(physs_link_speed_decoder_3_link_speed_out), 
    .mac100_0_ff_rx_dval_0(mac100_0_ff_rx_dval_0), 
    .mac100_0_ff_rx_data(mac100_0_ff_rx_data), 
    .mac100_0_ff_rx_sop(mac100_0_ff_rx_sop), 
    .mac100_0_ff_rx_eop_0(mac100_0_ff_rx_eop_0), 
    .mac100_0_ff_rx_mod_0(mac100_0_ff_rx_mod_0), 
    .mac100_0_ff_rx_err_0(mac100_0_ff_rx_err_0), 
    .fifo_mux_0_mac100g_0_rx_rdy(fifo_mux_0_mac100g_0_rx_rdy), 
    .mac100_0_ff_rx_ts_0(mac100_0_ff_rx_ts_0), 
    .mac100_0_ff_rx_ts_1(mac100_0_ff_rx_ts_1), 
    .fifo_mux_0_mac100g_0_tx_wren(fifo_mux_0_mac100g_0_tx_wren), 
    .fifo_mux_0_mac100g_0_tx_data(fifo_mux_0_mac100g_0_tx_data), 
    .fifo_mux_0_mac100g_0_tx_sop(fifo_mux_0_mac100g_0_tx_sop), 
    .fifo_mux_0_mac100g_0_tx_eop(fifo_mux_0_mac100g_0_tx_eop), 
    .fifo_mux_0_mac100g_0_tx_mod(fifo_mux_0_mac100g_0_tx_mod), 
    .fifo_mux_0_mac100g_0_tx_err(fifo_mux_0_mac100g_0_tx_err), 
    .fifo_mux_0_mac100g_0_tx_crc(fifo_mux_0_mac100g_0_tx_crc), 
    .mac100_0_ff_tx_rdy_0(mac100_0_ff_tx_rdy_0), 
    .mac100_0_pfc_mode(mac100_0_pfc_mode), 
    .mac100_1_ff_rx_dval_0(mac100_1_ff_rx_dval_0), 
    .mac100_1_ff_rx_data(mac100_1_ff_rx_data), 
    .mac100_1_ff_rx_sop(mac100_1_ff_rx_sop), 
    .mac100_1_ff_rx_eop_0(mac100_1_ff_rx_eop_0), 
    .mac100_1_ff_rx_mod_0(mac100_1_ff_rx_mod_0), 
    .mac100_1_ff_rx_err_0(mac100_1_ff_rx_err_0), 
    .fifo_mux_0_mac100g_1_rx_rdy(fifo_mux_0_mac100g_1_rx_rdy), 
    .mac100_1_ff_rx_ts_0(mac100_1_ff_rx_ts_0), 
    .mac100_1_ff_rx_ts_1(mac100_1_ff_rx_ts_1), 
    .fifo_mux_0_mac100g_1_tx_wren(fifo_mux_0_mac100g_1_tx_wren), 
    .fifo_mux_0_mac100g_1_tx_data(fifo_mux_0_mac100g_1_tx_data), 
    .fifo_mux_0_mac100g_1_tx_sop(fifo_mux_0_mac100g_1_tx_sop), 
    .fifo_mux_0_mac100g_1_tx_eop(fifo_mux_0_mac100g_1_tx_eop), 
    .fifo_mux_0_mac100g_1_tx_mod(fifo_mux_0_mac100g_1_tx_mod), 
    .fifo_mux_0_mac100g_1_tx_err(fifo_mux_0_mac100g_1_tx_err), 
    .fifo_mux_0_mac100g_1_tx_crc(fifo_mux_0_mac100g_1_tx_crc), 
    .mac100_1_ff_tx_rdy_0(mac100_1_ff_tx_rdy_0), 
    .mac100_1_pfc_mode(mac100_1_pfc_mode), 
    .mac100_2_ff_rx_dval_0(mac100_2_ff_rx_dval_0), 
    .mac100_2_ff_rx_data(mac100_2_ff_rx_data), 
    .mac100_2_ff_rx_sop(mac100_2_ff_rx_sop), 
    .mac100_2_ff_rx_eop_0(mac100_2_ff_rx_eop_0), 
    .mac100_2_ff_rx_mod_0(mac100_2_ff_rx_mod_0), 
    .mac100_2_ff_rx_err_0(mac100_2_ff_rx_err_0), 
    .fifo_mux_0_mac100g_2_rx_rdy(fifo_mux_0_mac100g_2_rx_rdy), 
    .mac100_2_ff_rx_ts_0(mac100_2_ff_rx_ts_0), 
    .mac100_2_ff_rx_ts_1(mac100_2_ff_rx_ts_1), 
    .fifo_mux_0_mac100g_2_tx_wren(fifo_mux_0_mac100g_2_tx_wren), 
    .fifo_mux_0_mac100g_2_tx_data(fifo_mux_0_mac100g_2_tx_data), 
    .fifo_mux_0_mac100g_2_tx_sop(fifo_mux_0_mac100g_2_tx_sop), 
    .fifo_mux_0_mac100g_2_tx_eop(fifo_mux_0_mac100g_2_tx_eop), 
    .fifo_mux_0_mac100g_2_tx_mod(fifo_mux_0_mac100g_2_tx_mod), 
    .fifo_mux_0_mac100g_2_tx_err(fifo_mux_0_mac100g_2_tx_err), 
    .fifo_mux_0_mac100g_2_tx_crc(fifo_mux_0_mac100g_2_tx_crc), 
    .mac100_2_ff_tx_rdy_0(mac100_2_ff_tx_rdy_0), 
    .mac100_2_pfc_mode(mac100_2_pfc_mode), 
    .mac100_3_ff_rx_dval_0(mac100_3_ff_rx_dval_0), 
    .mac100_3_ff_rx_data(mac100_3_ff_rx_data), 
    .mac100_3_ff_rx_sop(mac100_3_ff_rx_sop), 
    .mac100_3_ff_rx_eop_0(mac100_3_ff_rx_eop_0), 
    .mac100_3_ff_rx_mod_0(mac100_3_ff_rx_mod_0), 
    .mac100_3_ff_rx_err_0(mac100_3_ff_rx_err_0), 
    .fifo_mux_0_mac100g_3_rx_rdy(fifo_mux_0_mac100g_3_rx_rdy), 
    .mac100_3_ff_rx_ts_0(mac100_3_ff_rx_ts_0), 
    .mac100_3_ff_rx_ts_1(mac100_3_ff_rx_ts_1), 
    .fifo_mux_0_mac100g_3_tx_wren(fifo_mux_0_mac100g_3_tx_wren), 
    .fifo_mux_0_mac100g_3_tx_data(fifo_mux_0_mac100g_3_tx_data), 
    .fifo_mux_0_mac100g_3_tx_sop(fifo_mux_0_mac100g_3_tx_sop), 
    .fifo_mux_0_mac100g_3_tx_eop(fifo_mux_0_mac100g_3_tx_eop), 
    .fifo_mux_0_mac100g_3_tx_mod(fifo_mux_0_mac100g_3_tx_mod), 
    .fifo_mux_0_mac100g_3_tx_err(fifo_mux_0_mac100g_3_tx_err), 
    .fifo_mux_0_mac100g_3_tx_crc(fifo_mux_0_mac100g_3_tx_crc), 
    .mac100_3_ff_tx_rdy_0(mac100_3_ff_tx_rdy_0), 
    .mac100_3_pfc_mode(mac100_3_pfc_mode), 
    .quad_interrupts_0_mac400_int(quad_interrupts_0_mac400_int), 
    .mac400_0_ff_rx_err_0(mac400_0_ff_rx_err_0), 
    .mac200_0_ff_rx_err_0(mac200_0_ff_rx_err_0), 
    .nic400_physs_0_awaddr_master_quad0_out(nic400_physs_0_awaddr_master_quad0_out), 
    .nic400_physs_0_awlen_master_quad0(nic400_physs_0_awlen_master_quad0), 
    .nic400_physs_0_awsize_master_quad0(nic400_physs_0_awsize_master_quad0), 
    .nic400_physs_0_awburst_master_quad0(nic400_physs_0_awburst_master_quad0), 
    .nic400_physs_0_awlock_master_quad0(nic400_physs_0_awlock_master_quad0), 
    .nic400_physs_0_awcache_master_quad0(nic400_physs_0_awcache_master_quad0), 
    .nic400_physs_0_awprot_master_quad0(nic400_physs_0_awprot_master_quad0), 
    .nic400_physs_0_awvalid_master_quad0(nic400_physs_0_awvalid_master_quad0), 
    .nic400_quad_0_awready_slave_quad_if0(nic400_quad_0_awready_slave_quad_if0), 
    .nic400_physs_0_wdata_master_quad0(nic400_physs_0_wdata_master_quad0), 
    .nic400_physs_0_wstrb_master_quad0(nic400_physs_0_wstrb_master_quad0), 
    .nic400_physs_0_wlast_master_quad0(nic400_physs_0_wlast_master_quad0), 
    .nic400_physs_0_wvalid_master_quad0(nic400_physs_0_wvalid_master_quad0), 
    .nic400_quad_0_wready_slave_quad_if0(nic400_quad_0_wready_slave_quad_if0), 
    .nic400_quad_0_bresp_slave_quad_if0(nic400_quad_0_bresp_slave_quad_if0), 
    .nic400_quad_0_bvalid_slave_quad_if0(nic400_quad_0_bvalid_slave_quad_if0), 
    .nic400_physs_0_bready_master_quad0(nic400_physs_0_bready_master_quad0), 
    .nic400_physs_0_araddr_master_quad0_out(nic400_physs_0_araddr_master_quad0_out), 
    .nic400_physs_0_arlen_master_quad0(nic400_physs_0_arlen_master_quad0), 
    .nic400_physs_0_arsize_master_quad0(nic400_physs_0_arsize_master_quad0), 
    .nic400_physs_0_arburst_master_quad0(nic400_physs_0_arburst_master_quad0), 
    .nic400_physs_0_arlock_master_quad0(nic400_physs_0_arlock_master_quad0), 
    .nic400_physs_0_arcache_master_quad0(nic400_physs_0_arcache_master_quad0), 
    .nic400_physs_0_arprot_master_quad0(nic400_physs_0_arprot_master_quad0), 
    .nic400_physs_0_arvalid_master_quad0(nic400_physs_0_arvalid_master_quad0), 
    .nic400_quad_0_arready_slave_quad_if0(nic400_quad_0_arready_slave_quad_if0), 
    .nic400_quad_0_rdata_slave_quad_if0(nic400_quad_0_rdata_slave_quad_if0), 
    .nic400_quad_0_rresp_slave_quad_if0(nic400_quad_0_rresp_slave_quad_if0), 
    .nic400_quad_0_rlast_slave_quad_if0(nic400_quad_0_rlast_slave_quad_if0), 
    .nic400_quad_0_rvalid_slave_quad_if0(nic400_quad_0_rvalid_slave_quad_if0), 
    .nic400_physs_0_rready_master_quad0(nic400_physs_0_rready_master_quad0), 
    .nic400_physs_0_awid_master_quad0(nic400_physs_0_awid_master_quad0), 
    .nic400_physs_0_arid_master_quad0(nic400_physs_0_arid_master_quad0), 
    .nic400_quad_0_rid_slave_quad_if0(nic400_quad_0_rid_slave_quad_if0), 
    .nic400_quad_0_bid_slave_quad_if0(nic400_quad_0_bid_slave_quad_if0), 
    .nic400_physs_0_hreadyout_slave_quad0(nic400_physs_0_hreadyout_slave_quad0), 
    .nic400_physs_0_hresp_slave_quad0(nic400_physs_0_hresp_slave_quad0), 
    .nic400_physs_0_hrdata_slave_quad0(nic400_physs_0_hrdata_slave_quad0), 
    .nic400_quad_0_hselx_master_physs(nic400_quad_0_hselx_master_physs), 
    .nic400_quad_0_haddr_master_physs_out(nic400_quad_0_haddr_master_physs_out), 
    .nic400_quad_0_hwrite_master_physs(nic400_quad_0_hwrite_master_physs), 
    .nic400_quad_0_htrans_master_physs(nic400_quad_0_htrans_master_physs), 
    .nic400_quad_0_hsize_master_physs(nic400_quad_0_hsize_master_physs), 
    .nic400_quad_0_hburst_master_physs(nic400_quad_0_hburst_master_physs), 
    .nic400_quad_0_hprot_master_physs(nic400_quad_0_hprot_master_physs), 
    .nic400_quad_0_hready_master_physs(nic400_quad_0_hready_master_physs), 
    .nic400_quad_0_hwdata_master_physs(nic400_quad_0_hwdata_master_physs), 
    .mdio_in(mdio_in), 
    .mac100_0_mdc(mac100_0_mdc), 
    .mac100_0_mdio_out(mac100_0_mdio_out), 
    .mac100_0_mdio_oen_0(mac100_0_mdio_oen_0), 
    .physs0_ioa_ck_pma0_ref_left_mquad0_physs0(ioa_ck_pma0_ref_left_mquad0_physs0), 
    .physs0_ioa_ck_pma3_ref_right_mquad0_physs0(ioa_ck_pma3_ref_right_mquad0_physs0), 
    .socviewpin_32to1digimux_00_outmux(socviewpin_32to1digimux_00_outmux), 
    .socviewpin_32to1digimux_01_outmux(socviewpin_32to1digimux_01_outmux), 
    .physs_registers_wrapper_0_viewpin_mux_select_2(physs_registers_wrapper_0_viewpin_mux_select_2), 
    .physs_registers_wrapper_0_viewpin_mux_en_2(physs_registers_wrapper_0_viewpin_mux_en_2), 
    .quad_interrupts_0_mac100_int(quad_interrupts_0_mac100_int), 
    .physs_timesync_sync_val(physs_timesync_sync_val), 
    .quad_interrupts_0_ts_int_imc_o(quad_interrupts_0_ts_int_imc_o), 
    .quad_interrupts_0_ts_int_o(quad_interrupts_0_ts_int_o), 
    .quadpcs100_0_pcs_desk_buf_rlevel(quadpcs100_0_pcs_desk_buf_rlevel), 
    .quadpcs100_0_pcs_desk_buf_rlevel_1(quadpcs100_0_pcs_desk_buf_rlevel_1), 
    .quadpcs100_0_pcs_desk_buf_rlevel_2(quadpcs100_0_pcs_desk_buf_rlevel_2), 
    .quadpcs100_0_pcs_desk_buf_rlevel_3(quadpcs100_0_pcs_desk_buf_rlevel_3), 
    .BSCAN_PIPE_IN_1_scan_in(parmisc_physs0_BSCAN_PIPE_OUT_1_scan_in), 
    .BSCAN_PIPE_OUT_1_scan_out(parmquad0_BSCAN_PIPE_OUT_1_scan_out), 
    .BSCAN_PIPE_IN_1_force_disable(parmisc_physs0_BSCAN_PIPE_OUT_1_force_disable), 
    .BSCAN_PIPE_IN_1_select_jtag_input(parmisc_physs0_BSCAN_PIPE_OUT_1_select_jtag_input), 
    .BSCAN_PIPE_IN_1_select_jtag_output(parmisc_physs0_BSCAN_PIPE_OUT_1_select_jtag_output), 
    .BSCAN_PIPE_IN_1_ac_init_clock0(parmisc_physs0_BSCAN_PIPE_OUT_1_ac_init_clock0), 
    .BSCAN_PIPE_IN_1_ac_init_clock1(parmisc_physs0_BSCAN_PIPE_OUT_1_ac_init_clock1), 
    .BSCAN_PIPE_IN_1_ac_signal(parmisc_physs0_BSCAN_PIPE_OUT_1_ac_signal), 
    .BSCAN_PIPE_IN_1_ac_mode_en(parmisc_physs0_BSCAN_PIPE_OUT_1_ac_mode_en), 
    .BSCAN_PIPE_IN_1_intel_update_clk(parmisc_physs0_BSCAN_PIPE_OUT_1_intel_update_clk), 
    .BSCAN_PIPE_IN_1_intel_clamp_en(parmisc_physs0_BSCAN_PIPE_OUT_1_intel_clamp_en), 
    .BSCAN_PIPE_IN_1_intel_bscan_mode(parmisc_physs0_BSCAN_PIPE_OUT_1_intel_bscan_mode), 
    .BSCAN_PIPE_IN_1_select(parmisc_physs0_BSCAN_PIPE_OUT_1_select), 
    .BSCAN_PIPE_IN_1_bscan_clock(parmisc_physs0_BSCAN_PIPE_OUT_1_bscan_clock), 
    .BSCAN_PIPE_IN_1_capture_en(parmisc_physs0_BSCAN_PIPE_OUT_1_capture_en), 
    .BSCAN_PIPE_IN_1_shift_en(parmisc_physs0_BSCAN_PIPE_OUT_1_shift_en), 
    .BSCAN_PIPE_IN_1_update_en(parmisc_physs0_BSCAN_PIPE_OUT_1_update_en), 
    .BSCAN_bypass_brk_xmp_phy0(PHYSS_BSCAN_BYPASS), 
    .BSCAN_bypass_brk_xmp_phy1(PHYSS_BSCAN_BYPASS_0), 
    .BSCAN_bypass_brk_xmp_phy2(PHYSS_BSCAN_BYPASS_1), 
    .BSCAN_bypass_brk_xmp_phy3(PHYSS_BSCAN_BYPASS_2), 
    .BSCAN_PIPE_IN_1_intel_d6actestsig_b(parmisc_physs0_BSCAN_PIPE_OUT_1_bscan_to_intel_d6actestsig_b), 
    .SSN_END_0_bus_data_out(parmquad0_SSN_END_0_bus_data_out), 
    .SSN_START_0_bus_data_in(par400g0_SSN_END_0_bus_data_out), 
    .NW_IN_tms(tms), 
    .NW_IN_tck(tck), 
    .NW_IN_tdi(tdi), 
    .NW_IN_trst_b(trst_b), 
    .NW_IN_tdo(parmquad0_NW_IN_tdo), 
    .NW_IN_tdo_en(parmquad0_NW_IN_tdo_en), 
    .NW_IN_ijtag_reset_b(parmisc_physs0_NW_OUT_parmquad0_ijtag_to_reset), 
    .NW_IN_ijtag_capture(parmisc_physs0_NW_OUT_parmquad0_ijtag_to_ce), 
    .NW_IN_ijtag_shift(parmisc_physs0_NW_OUT_parmquad0_ijtag_to_se), 
    .NW_IN_ijtag_update(parmisc_physs0_NW_OUT_parmquad0_ijtag_to_ue), 
    .NW_IN_ijtag_select(parmisc_physs0_NW_OUT_parmquad0_ijtag_to_sel), 
    .NW_IN_ijtag_si(parmisc_physs0_NW_OUT_parmquad0_ijtag_to_si), 
    .NW_IN_ijtag_so(parmquad0_NW_IN_ijtag_so), 
    .NW_IN_shift_ir_dr(shift_ir_dr), 
    .NW_IN_tms_park_value(tms_park_value), 
    .NW_IN_nw_mode(nw_mode), 
    .NW_IN_tap_sel_out(parmquad0_NW_IN_tap_sel_out), 
    .SSN_START_0_bus_clock_in(SSN_START_entry_from_nac_bus_clock_in), 
    .parmquad0_ck_pma0_txdat_dfx_ubp_ctrl_act_out_0(1'b0), 
    .parmquad0_ck_pma1_txdat_dfx_ubp_ctrl_act_out_1(1'b0), 
    .parmquad0_ck_pma2_txdat_dfx_ubp_ctrl_act_out_2(1'b0), 
    .parmquad0_ck_pma3_txdat_dfx_ubp_ctrl_act_out_3(1'b0), 
    .nic400_physs_reset_sync(1'b0)
) ; 
parmquad1 parmquad1 (
    .mbp_repeater_odi_par400g1_ubp_out(mbp_repeater_odi_par400g1_ubp_out), 
    .dfxagg_security_policy(dfxagg_security_policy), 
    .dfxagg_policy_update(dfxagg_policy_update), 
    .dfxagg_early_boot_debug_exit(dfxagg_early_boot_debug_exit), 
    .dfxagg_debug_capabilities_enabling(dfxagg_debug_capabilities_enabling), 
    .dfxagg_debug_capabilities_enabling_valid(dfxagg_debug_capabilities_enabling_valid), 
    .fdfx_powergood(fdfx_powergood), 
    .ETH_RXN4(ETH_RXN4), 
    .ETH_RXP4(ETH_RXP4), 
    .ETH_RXN5(ETH_RXN5), 
    .ETH_RXP5(ETH_RXP5), 
    .ETH_RXN6(ETH_RXN6), 
    .ETH_RXP6(ETH_RXP6), 
    .ETH_RXN7(ETH_RXN7), 
    .ETH_RXP7(ETH_RXP7), 
    .versa_xmp_1_xoa_pma0_tx_n_l0(versa_xmp_1_xoa_pma0_tx_n_l0), 
    .versa_xmp_1_xoa_pma0_tx_p_l0(versa_xmp_1_xoa_pma0_tx_p_l0), 
    .versa_xmp_1_xoa_pma1_tx_n_l0(versa_xmp_1_xoa_pma1_tx_n_l0), 
    .versa_xmp_1_xoa_pma1_tx_p_l0(versa_xmp_1_xoa_pma1_tx_p_l0), 
    .versa_xmp_1_xoa_pma2_tx_n_l0(versa_xmp_1_xoa_pma2_tx_n_l0), 
    .versa_xmp_1_xoa_pma2_tx_p_l0(versa_xmp_1_xoa_pma2_tx_p_l0), 
    .versa_xmp_1_xoa_pma3_tx_n_l0(versa_xmp_1_xoa_pma3_tx_n_l0), 
    .versa_xmp_1_xoa_pma3_tx_p_l0(versa_xmp_1_xoa_pma3_tx_p_l0), 
    .ioa_pma_remote_diode_i_anode_0(ioa_pma_remote_diode_i_anode_3), 
    .ioa_pma_remote_diode_i_anode_1(ioa_pma_remote_diode_i_anode_4), 
    .ioa_pma_remote_diode_i_anode_2(ioa_pma_remote_diode_i_anode_5), 
    .ioa_pma_remote_diode_i_anode_3(ioa_pma_remote_diode_i_anode_6), 
    .ioa_pma_remote_diode_v_anode_0(ioa_pma_remote_diode_v_anode_3), 
    .ioa_pma_remote_diode_v_anode_1(ioa_pma_remote_diode_v_anode_4), 
    .ioa_pma_remote_diode_v_anode_2(ioa_pma_remote_diode_v_anode_5), 
    .ioa_pma_remote_diode_v_anode_3(ioa_pma_remote_diode_v_anode_6), 
    .ioa_pma_remote_diode_i_cathode_0(ioa_pma_remote_diode_i_cathode_3), 
    .ioa_pma_remote_diode_i_cathode_1(ioa_pma_remote_diode_i_cathode_4), 
    .ioa_pma_remote_diode_i_cathode_2(ioa_pma_remote_diode_i_cathode_5), 
    .ioa_pma_remote_diode_i_cathode_3(ioa_pma_remote_diode_i_cathode_6), 
    .ioa_pma_remote_diode_v_cathode_0(ioa_pma_remote_diode_v_cathode_3), 
    .ioa_pma_remote_diode_v_cathode_1(ioa_pma_remote_diode_v_cathode_4), 
    .ioa_pma_remote_diode_v_cathode_2(ioa_pma_remote_diode_v_cathode_5), 
    .ioa_pma_remote_diode_v_cathode_3(ioa_pma_remote_diode_v_cathode_6), 
    .quadpcs100_1_pcs_link_status(quadpcs100_1_pcs_link_status), 
    .versa_xmp_1_o_ucss_srds_phy_ready_pma0_l0_a(versa_xmp_1_o_ucss_srds_phy_ready_pma0_l0_a), 
    .versa_xmp_1_o_ucss_srds_phy_ready_pma1_l0_a(versa_xmp_1_o_ucss_srds_phy_ready_pma1_l0_a), 
    .versa_xmp_1_o_ucss_srds_phy_ready_pma2_l0_a(versa_xmp_1_o_ucss_srds_phy_ready_pma2_l0_a), 
    .versa_xmp_1_o_ucss_srds_phy_ready_pma3_l0_a(versa_xmp_1_o_ucss_srds_phy_ready_pma3_l0_a), 
    .physs_registers_wrapper_1_hlp_link_stat_speed_0_hlp_link_stat_0(physs_registers_wrapper_1_hlp_link_stat_speed_0_hlp_link_stat_0), 
    .physs_registers_wrapper_1_hlp_link_stat_speed_1_hlp_link_stat_1(physs_registers_wrapper_1_hlp_link_stat_speed_1_hlp_link_stat_1), 
    .physs_registers_wrapper_1_hlp_link_stat_speed_2_hlp_link_stat_2(physs_registers_wrapper_1_hlp_link_stat_speed_2_hlp_link_stat_2), 
    .physs_registers_wrapper_1_hlp_link_stat_speed_3_hlp_link_stat_3(physs_registers_wrapper_1_hlp_link_stat_speed_3_hlp_link_stat_3), 
    .physs_registers_wrapper_1_link_bypass_en(physs_registers_wrapper_1_link_bypass_en), 
    .physs_registers_wrapper_1_link_bypass_val(physs_registers_wrapper_1_link_bypass_val), 
    .physs_registers_wrapper_1_syncE_main_rst(physs_registers_wrapper_1_syncE_main_rst), 
    .physs_registers_wrapper_1_syncE_link_up_md(physs_registers_wrapper_1_syncE_link_up_md), 
    .physs_registers_wrapper_1_syncE_link_dn_md(physs_registers_wrapper_1_syncE_link_dn_md), 
    .physs_registers_wrapper_1_syncE_link_enable(physs_registers_wrapper_1_syncE_link_enable), 
    .physs_registers_wrapper_1_syncE_refclk0_div_rst(physs_registers_wrapper_1_syncE_refclk0_div_rst), 
    .physs_registers_wrapper_1_syncE_refclk0_sel(physs_registers_wrapper_1_syncE_refclk0_sel), 
    .physs_registers_wrapper_1_syncE_refclk0_div_m1(physs_registers_wrapper_1_syncE_refclk0_div_m1), 
    .physs_registers_wrapper_1_syncE_refclk0_div_load(physs_registers_wrapper_1_syncE_refclk0_div_load), 
    .physs_registers_wrapper_1_syncE_refclk1_div_rst(physs_registers_wrapper_1_syncE_refclk1_div_rst), 
    .physs_registers_wrapper_1_syncE_refclk1_sel(physs_registers_wrapper_1_syncE_refclk1_sel), 
    .physs_registers_wrapper_1_syncE_refclk1_div_m1(physs_registers_wrapper_1_syncE_refclk1_div_m1), 
    .physs_registers_wrapper_1_syncE_refclk1_div_load(physs_registers_wrapper_1_syncE_refclk1_div_load), 
    .physs_registers_wrapper_1_pcs_mode_config_syncE_mux_sel(physs_registers_wrapper_1_pcs_mode_config_syncE_mux_sel), 
    .physs_registers_wrapper_1_pcs_mode_config_syncE_mux_sel_0(physs_registers_wrapper_1_pcs_mode_config_syncE_mux_sel_0), 
    .physs_hd2prf_trim_fuse_in(physs_hd2prf_trim_fuse_in), 
    .physs_hdp2prf_trim_fuse_in(physs_hdp2prf_trim_fuse_in), 
    .physs_rfhs_trim_fuse_in(physs_rfhs_trim_fuse_in), 
    .physs_hdspsr_trim_fuse_in(physs_hdspsr_trim_fuse_in), 
    .physs_bbl_800G_1_disable(1'b0), 
    .physs_bbl_400G_1_disable(physs_bbl_400G_1_disable), 
    .physs_bbl_200G_1_disable(physs_bbl_200G_1_disable), 
    .physs_bbl_100G_1_disable(physs_bbl_100G_1_disable), 
    .physs_bbl_serdes_1_disable(physs_bbl_serdes_1_disable), 
    .physs_bbl_spare_1(physs_bbl_spare_1), 
    .physs_registers_wrapper_1_mac200_config_0_xoff_gen(physs_registers_wrapper_1_mac200_config_0_xoff_gen), 
    .physs_registers_wrapper_1_mac200_config_0_tx_loc_fault(physs_registers_wrapper_1_mac200_config_0_tx_loc_fault), 
    .physs_registers_wrapper_1_mac200_config_0_tx_rem_fault(physs_registers_wrapper_1_mac200_config_0_tx_rem_fault), 
    .physs_registers_wrapper_1_mac200_config_0_tx_li_fault(physs_registers_wrapper_1_mac200_config_0_tx_li_fault), 
    .physs_registers_wrapper_1_mac200_config_0_tx_smhold(physs_registers_wrapper_1_mac200_config_0_tx_smhold), 
    .physs_registers_wrapper_1_mac400_config_0_xoff_gen(physs_registers_wrapper_1_mac400_config_0_xoff_gen), 
    .physs_registers_wrapper_1_mac400_config_0_tx_loc_fault(physs_registers_wrapper_1_mac400_config_0_tx_loc_fault), 
    .physs_registers_wrapper_1_mac400_config_0_tx_rem_fault(physs_registers_wrapper_1_mac400_config_0_tx_rem_fault), 
    .physs_registers_wrapper_1_mac400_config_0_tx_li_fault(physs_registers_wrapper_1_mac400_config_0_tx_li_fault), 
    .physs_registers_wrapper_1_mac400_config_0_tx_smhold(physs_registers_wrapper_1_mac400_config_0_tx_smhold), 
    .ethphyss_post_clkungate(ethphyss_post_clkungate), 
    .soc_per_clk_adop_parmisc_physs0_clkout(soc_per_clk_adop_parmisc_physs0_clkout_0), 
    .physs_func_clk_adop_parmisc_physs0_clkout(physs_func_clk_adop_parmisc_physs0_clkout_0), 
    .o_ck_pma0_rx_postdiv_l0_adop_parmquad1_clkout(o_ck_pma0_rx_postdiv_l0_adop_parmquad1_clkout), 
    .o_ck_pma1_rx_postdiv_l0_adop_parmquad1_clkout(o_ck_pma1_rx_postdiv_l0_adop_parmquad1_clkout), 
    .o_ck_pma2_rx_postdiv_l0_adop_parmquad1_clkout(o_ck_pma2_rx_postdiv_l0_adop_parmquad1_clkout), 
    .o_ck_pma3_rx_postdiv_l0_adop_parmquad1_clkout(o_ck_pma3_rx_postdiv_l0_adop_parmquad1_clkout), 
    .tsu_clk(tsu_clk), 
    .fscan_txrxword_byp_clk(fscan_txrxword_byp_clk), 
    .fscan_ref_clk_adop_parmisc_physs0_clkout(fscan_ref_clk_adop_parmisc_physs0_clkout), 
    .cosq_func_clk1_adop_parmisc_physs0_clkout_0(cosq_func_clk1_adop_parmisc_physs0_clkout_0), 
    .physs_pcs_mux_1_sd0_tx_clk_200G(physs_pcs_mux_1_sd0_tx_clk_200G), 
    .physs_pcs_mux_1_sd4_tx_clk_200G(physs_pcs_mux_1_sd4_tx_clk_200G), 
    .physs_pcs_mux_1_sd8_tx_clk_200G(physs_pcs_mux_1_sd8_tx_clk_200G), 
    .physs_pcs_mux_1_sd12_tx_clk_200G(physs_pcs_mux_1_sd12_tx_clk_200G), 
    .physs_pcs_mux_1_sd0_tx_clk_400G(physs_pcs_mux_1_sd0_tx_clk_400G), 
    .physs_pcs_mux_1_sd4_tx_clk_400G(physs_pcs_mux_1_sd4_tx_clk_400G), 
    .physs_pcs_mux_1_sd8_tx_clk_400G(physs_pcs_mux_1_sd8_tx_clk_400G), 
    .physs_pcs_mux_1_sd12_tx_clk_400G(physs_pcs_mux_1_sd12_tx_clk_400G), 
    .physs_pcs_mux_1_sd0_rx_clk_400G(physs_pcs_mux_1_sd0_rx_clk_400G), 
    .physs_pcs_mux_1_sd4_rx_clk_400G(physs_pcs_mux_1_sd4_rx_clk_400G), 
    .physs_pcs_mux_1_sd8_rx_clk_400G(physs_pcs_mux_1_sd8_rx_clk_400G), 
    .physs_pcs_mux_1_sd12_rx_clk_400G(physs_pcs_mux_1_sd12_rx_clk_400G), 
    .physs_pcs_mux_1_sd0_rx_clk_200G(physs_pcs_mux_1_sd0_rx_clk_200G), 
    .physs_pcs_mux_1_sd4_rx_clk_200G(physs_pcs_mux_1_sd4_rx_clk_200G), 
    .physs_pcs_mux_1_sd8_rx_clk_200G(physs_pcs_mux_1_sd8_rx_clk_200G), 
    .physs_pcs_mux_1_sd12_rx_clk_200G(physs_pcs_mux_1_sd12_rx_clk_200G), 
    .physs_funcx2_clk_adop_parmisc_physs0_clkout(physs_funcx2_clk_adop_parmisc_physs0_clkout), 
    .physs_pcs_mux_1_sd_rx_clk_800G(physs_pcs_mux_1_sd_rx_clk_800G), 
    .physs_pcs_mux_1_sd_rx_clk_800G_0(physs_pcs_mux_1_sd_rx_clk_800G_0), 
    .physs_pcs_mux_1_sd_rx_clk_800G_1(physs_pcs_mux_1_sd_rx_clk_800G_1), 
    .physs_pcs_mux_1_sd_rx_clk_800G_2(physs_pcs_mux_1_sd_rx_clk_800G_2), 
    .physs_pcs_mux_1_sd_tx_clk_800G(physs_pcs_mux_1_sd_tx_clk_800G), 
    .physs_pcs_mux_1_sd_tx_clk_800G_0(physs_pcs_mux_1_sd_tx_clk_800G_0), 
    .physs_pcs_mux_1_sd_tx_clk_800G_1(physs_pcs_mux_1_sd_tx_clk_800G_1), 
    .physs_pcs_mux_1_sd_tx_clk_800G_2(physs_pcs_mux_1_sd_tx_clk_800G_2), 
    .o_ck_pma0_cmnplla_postdiv_clk_mux_parmquad0_clkout(o_ck_pma0_cmnplla_postdiv_clk_mux_parmquad0_clkout), 
    .uart_clk_adop_parmisc_physs0_clkout(uart_clk_adop_parmisc_physs0_clkout), 
    .uart_sel_and1_o(uart_sel_and1_o), 
    .nic400_quad_1_hselx_mac400_stats_0(nic400_quad_1_hselx_mac400_stats_0), 
    .nic400_quad_1_haddr_mac400_stats_0_out(nic400_quad_1_haddr_mac400_stats_0_out), 
    .nic400_quad_1_htrans_mac400_stats_0(nic400_quad_1_htrans_mac400_stats_0), 
    .nic400_quad_1_hwrite_mac400_stats_0(nic400_quad_1_hwrite_mac400_stats_0), 
    .nic400_quad_1_hsize_mac400_stats_0(nic400_quad_1_hsize_mac400_stats_0), 
    .nic400_quad_1_hwdata_mac400_stats_0(nic400_quad_1_hwdata_mac400_stats_0), 
    .nic400_quad_1_hready_mac400_stats_0(nic400_quad_1_hready_mac400_stats_0), 
    .nic400_quad_1_hburst_mac400_stats_0(nic400_quad_1_hburst_mac400_stats_0), 
    .macstats_ahb_bridge_10_hrdata(macstats_ahb_bridge_10_hrdata), 
    .macstats_ahb_bridge_10_hresp(macstats_ahb_bridge_10_hresp), 
    .macstats_ahb_bridge_10_hreadyout(macstats_ahb_bridge_10_hreadyout), 
    .nic400_quad_1_hselx_mac400_stats_1(nic400_quad_1_hselx_mac400_stats_1), 
    .nic400_quad_1_haddr_mac400_stats_1_out(nic400_quad_1_haddr_mac400_stats_1_out), 
    .nic400_quad_1_htrans_mac400_stats_1(nic400_quad_1_htrans_mac400_stats_1), 
    .nic400_quad_1_hwrite_mac400_stats_1(nic400_quad_1_hwrite_mac400_stats_1), 
    .nic400_quad_1_hsize_mac400_stats_1(nic400_quad_1_hsize_mac400_stats_1), 
    .nic400_quad_1_hwdata_mac400_stats_1(nic400_quad_1_hwdata_mac400_stats_1), 
    .nic400_quad_1_hready_mac400_stats_1(nic400_quad_1_hready_mac400_stats_1), 
    .nic400_quad_1_hburst_mac400_stats_1(nic400_quad_1_hburst_mac400_stats_1), 
    .macstats_ahb_bridge_11_hrdata(macstats_ahb_bridge_11_hrdata), 
    .macstats_ahb_bridge_11_hresp(macstats_ahb_bridge_11_hresp), 
    .macstats_ahb_bridge_11_hreadyout(macstats_ahb_bridge_11_hreadyout), 
    .nic400_quad_1_hselx_mac400_0(nic400_quad_1_hselx_mac400_0), 
    .nic400_quad_1_haddr_mac400_0_out(nic400_quad_1_haddr_mac400_0_out), 
    .nic400_quad_1_htrans_mac400_0(nic400_quad_1_htrans_mac400_0), 
    .nic400_quad_1_hwrite_mac400_0(nic400_quad_1_hwrite_mac400_0), 
    .nic400_quad_1_hsize_mac400_0(nic400_quad_1_hsize_mac400_0), 
    .nic400_quad_1_hwdata_mac400_0(nic400_quad_1_hwdata_mac400_0), 
    .nic400_quad_1_hready_mac400_0(nic400_quad_1_hready_mac400_0), 
    .nic400_quad_1_hburst_mac400_0(nic400_quad_1_hburst_mac400_0), 
    .mac200_ahb_bridge_1_hrdata(mac200_ahb_bridge_1_hrdata), 
    .mac200_ahb_bridge_1_hresp(mac200_ahb_bridge_1_hresp), 
    .mac200_ahb_bridge_1_hreadyout(mac200_ahb_bridge_1_hreadyout), 
    .nic400_quad_1_hselx_mac400_1(nic400_quad_1_hselx_mac400_1), 
    .nic400_quad_1_haddr_mac400_1_out(nic400_quad_1_haddr_mac400_1_out), 
    .nic400_quad_1_htrans_mac400_1(nic400_quad_1_htrans_mac400_1), 
    .nic400_quad_1_hwrite_mac400_1(nic400_quad_1_hwrite_mac400_1), 
    .nic400_quad_1_hsize_mac400_1(nic400_quad_1_hsize_mac400_1), 
    .nic400_quad_1_hwdata_mac400_1(nic400_quad_1_hwdata_mac400_1), 
    .nic400_quad_1_hready_mac400_1(nic400_quad_1_hready_mac400_1), 
    .nic400_quad_1_hburst_mac400_1(nic400_quad_1_hburst_mac400_1), 
    .mac400_ahb_bridge_1_hrdata(mac400_ahb_bridge_1_hrdata), 
    .mac400_ahb_bridge_1_hresp(mac400_ahb_bridge_1_hresp), 
    .mac400_ahb_bridge_1_hreadyout(mac400_ahb_bridge_1_hreadyout), 
    .nic400_quad_1_hselx_pcs400_0(nic400_quad_1_hselx_pcs400_0), 
    .nic400_quad_1_haddr_pcs400_0_out(nic400_quad_1_haddr_pcs400_0_out), 
    .nic400_quad_1_htrans_pcs400_0(nic400_quad_1_htrans_pcs400_0), 
    .nic400_quad_1_hwrite_pcs400_0(nic400_quad_1_hwrite_pcs400_0), 
    .nic400_quad_1_hsize_pcs400_0(nic400_quad_1_hsize_pcs400_0), 
    .nic400_quad_1_hwdata_pcs400_0(nic400_quad_1_hwdata_pcs400_0), 
    .nic400_quad_1_hready_pcs400_0(nic400_quad_1_hready_pcs400_0), 
    .nic400_quad_1_hburst_pcs400_0(nic400_quad_1_hburst_pcs400_0), 
    .pcs200_ahb_bridge_2_hrdata(pcs200_ahb_bridge_2_hrdata), 
    .pcs200_ahb_bridge_2_hresp(pcs200_ahb_bridge_2_hresp), 
    .pcs200_ahb_bridge_2_hreadyout(pcs200_ahb_bridge_2_hreadyout), 
    .nic400_quad_1_hselx_rsfec400_0(nic400_quad_1_hselx_rsfec400_0), 
    .nic400_quad_1_haddr_rsfec400_0_out(nic400_quad_1_haddr_rsfec400_0_out), 
    .nic400_quad_1_htrans_rsfec400_0(nic400_quad_1_htrans_rsfec400_0), 
    .nic400_quad_1_hwrite_rsfec400_0(nic400_quad_1_hwrite_rsfec400_0), 
    .nic400_quad_1_hsize_rsfec400_0(nic400_quad_1_hsize_rsfec400_0), 
    .nic400_quad_1_hwdata_rsfec400_0(nic400_quad_1_hwdata_rsfec400_0), 
    .nic400_quad_1_hready_rsfec400_0(nic400_quad_1_hready_rsfec400_0), 
    .nic400_quad_1_hburst_rsfec400_0(nic400_quad_1_hburst_rsfec400_0), 
    .pcs200_ahb_bridge_3_hrdata(pcs200_ahb_bridge_3_hrdata), 
    .pcs200_ahb_bridge_3_hresp(pcs200_ahb_bridge_3_hresp), 
    .pcs200_ahb_bridge_3_hreadyout(pcs200_ahb_bridge_3_hreadyout), 
    .nic400_quad_1_hselx_rsfecstats400_1(nic400_quad_1_hselx_rsfecstats400_1), 
    .nic400_quad_1_haddr_rsfecstats400_1_out(nic400_quad_1_haddr_rsfecstats400_1_out), 
    .nic400_quad_1_htrans_rsfecstats400_1(nic400_quad_1_htrans_rsfecstats400_1), 
    .nic400_quad_1_hwrite_rsfecstats400_1(nic400_quad_1_hwrite_rsfecstats400_1), 
    .nic400_quad_1_hsize_rsfecstats400_1(nic400_quad_1_hsize_rsfecstats400_1), 
    .nic400_quad_1_hwdata_rsfecstats400_1(nic400_quad_1_hwdata_rsfecstats400_1), 
    .nic400_quad_1_hready_rsfecstats400_1(nic400_quad_1_hready_rsfecstats400_1), 
    .nic400_quad_1_hburst_rsfecstats400_1(nic400_quad_1_hburst_rsfecstats400_1), 
    .pcs200_ahb_bridge_5_hrdata(pcs200_ahb_bridge_5_hrdata), 
    .pcs200_ahb_bridge_5_hresp(pcs200_ahb_bridge_5_hresp), 
    .pcs200_ahb_bridge_5_hreadyout(pcs200_ahb_bridge_5_hreadyout), 
    .nic400_quad_1_hselx_pcs400_1(nic400_quad_1_hselx_pcs400_1), 
    .nic400_quad_1_haddr_pcs400_1_out(nic400_quad_1_haddr_pcs400_1_out), 
    .nic400_quad_1_htrans_pcs400_1(nic400_quad_1_htrans_pcs400_1), 
    .nic400_quad_1_hwrite_pcs400_1(nic400_quad_1_hwrite_pcs400_1), 
    .nic400_quad_1_hsize_pcs400_1(nic400_quad_1_hsize_pcs400_1), 
    .nic400_quad_1_hwdata_pcs400_1(nic400_quad_1_hwdata_pcs400_1), 
    .nic400_quad_1_hready_pcs400_1(nic400_quad_1_hready_pcs400_1), 
    .nic400_quad_1_hburst_pcs400_1(nic400_quad_1_hburst_pcs400_1), 
    .pcs400_ahb_bridge_2_hrdata(pcs400_ahb_bridge_2_hrdata), 
    .pcs400_ahb_bridge_2_hresp(pcs400_ahb_bridge_2_hresp), 
    .pcs400_ahb_bridge_2_hreadyout(pcs400_ahb_bridge_2_hreadyout), 
    .nic400_quad_1_hselx_rsfec400_1(nic400_quad_1_hselx_rsfec400_1), 
    .nic400_quad_1_haddr_rsfec400_1_out(nic400_quad_1_haddr_rsfec400_1_out), 
    .nic400_quad_1_htrans_rsfec400_1(nic400_quad_1_htrans_rsfec400_1), 
    .nic400_quad_1_hwrite_rsfec400_1(nic400_quad_1_hwrite_rsfec400_1), 
    .nic400_quad_1_hsize_rsfec400_1(nic400_quad_1_hsize_rsfec400_1), 
    .nic400_quad_1_hwdata_rsfec400_1(nic400_quad_1_hwdata_rsfec400_1), 
    .nic400_quad_1_hready_rsfec400_1(nic400_quad_1_hready_rsfec400_1), 
    .nic400_quad_1_hburst_rsfec400_1(nic400_quad_1_hburst_rsfec400_1), 
    .pcs400_ahb_bridge_3_hrdata(pcs400_ahb_bridge_3_hrdata), 
    .pcs400_ahb_bridge_3_hresp(pcs400_ahb_bridge_3_hresp), 
    .pcs400_ahb_bridge_3_hreadyout(pcs400_ahb_bridge_3_hreadyout), 
    .nic400_quad_1_hselx_rsfecstats400_0(nic400_quad_1_hselx_rsfecstats400_0), 
    .nic400_quad_1_haddr_rsfecstats400_0_out(nic400_quad_1_haddr_rsfecstats400_0_out), 
    .nic400_quad_1_htrans_rsfecstats400_0(nic400_quad_1_htrans_rsfecstats400_0), 
    .nic400_quad_1_hwrite_rsfecstats400_0(nic400_quad_1_hwrite_rsfecstats400_0), 
    .nic400_quad_1_hsize_rsfecstats400_0(nic400_quad_1_hsize_rsfecstats400_0), 
    .nic400_quad_1_hwdata_rsfecstats400_0(nic400_quad_1_hwdata_rsfecstats400_0), 
    .nic400_quad_1_hready_rsfecstats400_0(nic400_quad_1_hready_rsfecstats400_0), 
    .nic400_quad_1_hburst_rsfecstats400_0(nic400_quad_1_hburst_rsfecstats400_0), 
    .pcs400_ahb_bridge_5_hrdata(pcs400_ahb_bridge_5_hrdata), 
    .pcs400_ahb_bridge_5_hresp(pcs400_ahb_bridge_5_hresp), 
    .pcs400_ahb_bridge_5_hreadyout(pcs400_ahb_bridge_5_hreadyout), 
    .nic400_quad_1_hselx_tsu_400_0(nic400_quad_1_hselx_tsu_400_0), 
    .nic400_quad_1_haddr_tsu_400_0_out(nic400_quad_1_haddr_tsu_400_0_out), 
    .nic400_quad_1_htrans_tsu_400_0(nic400_quad_1_htrans_tsu_400_0), 
    .nic400_quad_1_hwrite_tsu_400_0(nic400_quad_1_hwrite_tsu_400_0), 
    .nic400_quad_1_hsize_tsu_400_0(nic400_quad_1_hsize_tsu_400_0), 
    .nic400_quad_1_hwdata_tsu_400_0(nic400_quad_1_hwdata_tsu_400_0), 
    .nic400_quad_1_hready_tsu_400_0(nic400_quad_1_hready_tsu_400_0), 
    .nic400_quad_1_hburst_tsu_400_0(nic400_quad_1_hburst_tsu_400_0), 
    .tsu400_ahb_bridge_1_hrdata(tsu400_ahb_bridge_1_hrdata), 
    .tsu400_ahb_bridge_1_hresp(tsu400_ahb_bridge_1_hresp), 
    .tsu400_ahb_bridge_1_hreadyout(tsu400_ahb_bridge_1_hreadyout), 
    .nic400_quad_1_hselx_tsu_400_1(nic400_quad_1_hselx_tsu_400_1), 
    .nic400_quad_1_haddr_tsu_400_1_out(nic400_quad_1_haddr_tsu_400_1_out), 
    .nic400_quad_1_htrans_tsu_400_1(nic400_quad_1_htrans_tsu_400_1), 
    .nic400_quad_1_hwrite_tsu_400_1(nic400_quad_1_hwrite_tsu_400_1), 
    .nic400_quad_1_hsize_tsu_400_1(nic400_quad_1_hsize_tsu_400_1), 
    .nic400_quad_1_hwdata_tsu_400_1(nic400_quad_1_hwdata_tsu_400_1), 
    .nic400_quad_1_hready_tsu_400_1(nic400_quad_1_hready_tsu_400_1), 
    .nic400_quad_1_hburst_tsu_400_1(nic400_quad_1_hburst_tsu_400_1), 
    .tsu200_ahb_bridge_1_hrdata(tsu200_ahb_bridge_1_hrdata), 
    .tsu200_ahb_bridge_1_hresp(tsu200_ahb_bridge_1_hresp), 
    .tsu200_ahb_bridge_1_hreadyout(tsu200_ahb_bridge_1_hreadyout), 
    .physs_registers_wrapper_1_reset_ref_clk_override_0(physs_registers_wrapper_1_reset_ref_clk_override_0), 
    .physs_registers_wrapper_1_reset_pcs100_override_en_0(physs_registers_wrapper_1_reset_pcs100_override_en_0), 
    .physs_registers_wrapper_1_clk_gate_en_100G_mac_pcs_0(physs_registers_wrapper_1_clk_gate_en_100G_mac_pcs_0), 
    .physs_registers_wrapper_1_power_fsm_clk_gate_en_0(physs_registers_wrapper_1_power_fsm_clk_gate_en_0), 
    .physs_registers_wrapper_1_power_fsm_reset_gate_en_0(physs_registers_wrapper_1_power_fsm_reset_gate_en_0), 
    .physs_registers_wrapper_1_pcs200_reg_tx_am_sf(physs_registers_wrapper_1_pcs200_reg_tx_am_sf), 
    .physs_registers_wrapper_1_pcs200_reg_rsfec_mode_ll(physs_registers_wrapper_1_pcs200_reg_rsfec_mode_ll), 
    .physs_registers_wrapper_1_pcs200_reg_sd_4x_en(physs_registers_wrapper_1_pcs200_reg_sd_4x_en), 
    .physs_registers_wrapper_1_pcs200_reg_sd_8x_en(physs_registers_wrapper_1_pcs200_reg_sd_8x_en), 
    .physs_registers_wrapper_1_pcs400_reg_tx_am_sf(physs_registers_wrapper_1_pcs400_reg_tx_am_sf), 
    .physs_registers_wrapper_1_pcs400_reg_rsfec_mode_ll(physs_registers_wrapper_1_pcs400_reg_rsfec_mode_ll), 
    .physs_registers_wrapper_1_pcs400_reg_sd_4x_en(physs_registers_wrapper_1_pcs400_reg_sd_4x_en), 
    .physs_registers_wrapper_1_pcs400_reg_sd_8x_en(physs_registers_wrapper_1_pcs400_reg_sd_8x_en), 
    .mac200_1_pause_on(mac200_1_pause_on), 
    .mac400_1_pause_on(mac400_1_pause_on), 
    .mac200_1_li_fault(mac200_1_li_fault), 
    .mac400_1_li_fault(mac400_1_li_fault), 
    .mac200_1_rem_fault(mac200_1_rem_fault), 
    .mac400_1_rem_fault(mac400_1_rem_fault), 
    .mac200_1_loc_fault(mac200_1_loc_fault), 
    .mac400_1_loc_fault(mac400_1_loc_fault), 
    .mac200_1_tx_empty(mac200_1_tx_empty), 
    .mac400_1_tx_empty(mac400_1_tx_empty), 
    .mac200_1_ff_rx_empty(mac200_1_ff_rx_empty), 
    .mac400_1_ff_rx_empty(mac400_1_ff_rx_empty), 
    .mac200_1_tx_isidle(mac200_1_tx_isidle), 
    .mac400_1_tx_isidle(mac400_1_tx_isidle), 
    .mac200_1_ff_tx_septy(mac200_1_ff_tx_septy), 
    .mac400_1_ff_tx_septy(mac400_1_ff_tx_septy), 
    .mac200_1_tx_underflow(mac200_1_tx_underflow), 
    .mac400_1_tx_underflow(mac400_1_tx_underflow), 
    .mac200_1_tx_ovr_err(mac200_1_tx_ovr_err), 
    .mac400_1_tx_ovr_err(mac400_1_tx_ovr_err), 
    .mac200_1_mdio_oen(mac200_1_mdio_oen), 
    .mac400_1_mdio_oen(mac400_1_mdio_oen), 
    .mac200_1_pfc_mode(mac200_1_pfc_mode), 
    .mac400_1_pfc_mode(mac400_1_pfc_mode), 
    .mac200_1_ff_rx_dsav(mac200_1_ff_rx_dsav), 
    .mac400_1_ff_rx_dsav(mac400_1_ff_rx_dsav), 
    .mac200_1_ff_tx_credit(mac200_1_ff_tx_credit), 
    .mac400_1_ff_tx_credit(mac400_1_ff_tx_credit), 
    .mac200_1_inv_loop_ind(mac200_1_inv_loop_ind), 
    .mac400_1_inv_loop_ind(mac400_1_inv_loop_ind), 
    .mac200_1_frm_drop(mac200_1_frm_drop), 
    .mac400_1_frm_drop(mac400_1_frm_drop), 
    .pcs200_1_rx_am_sf(pcs200_1_rx_am_sf), 
    .pcs200_1_degrade_ser(pcs200_1_degrade_ser), 
    .pcs200_1_hi_ser(pcs200_1_hi_ser), 
    .pcs200_1_link_status(pcs200_1_link_status), 
    .pcs200_1_amps_lock(pcs200_1_amps_lock), 
    .pcs200_1_align_lock(pcs200_1_align_lock), 
    .pcs400_1_rx_am_sf(pcs400_1_rx_am_sf), 
    .pcs400_1_degrade_ser(pcs400_1_degrade_ser), 
    .pcs400_1_hi_ser(pcs400_1_hi_ser), 
    .pcs400_1_link_status(pcs400_1_link_status), 
    .pcs400_1_amps_lock(pcs400_1_amps_lock), 
    .pcs400_1_align_lock(pcs400_1_align_lock), 
    .physs_bbl_spare_0(physs_bbl_spare_0), 
    .physs_registers_wrapper_1_pcs_mode_config_pcs_mode_sel_0(physs_registers_wrapper_1_pcs_mode_config_pcs_mode_sel_0), 
    .physs_registers_wrapper_1_pcs_mode_config_fifo_mode_sel(physs_registers_wrapper_1_pcs_mode_config_fifo_mode_sel), 
    .pd_vinf_1_bisr_clk(pd_vinf_1_bisr_clk), 
    .pd_vinf_1_bisr_reset(pd_vinf_1_bisr_reset), 
    .pd_vinf_1_bisr_shift_en(pd_vinf_1_bisr_shift_en), 
    .pd_vinf_1_bisr_si(par400g1_pd_vinf_1_bisr_so), 
    .pd_vinf_1_bisr_so(parmquad1_pd_vinf_1_bisr_so), 
    .physs_func_clk_pdop_parmquad0_clkout_0(physs_func_clk_pdop_parmquad0_clkout_0), 
    .physs_func_clk_pdop_parmquad1_clkout_0(physs_func_clk_pdop_parmquad1_clkout), 
    .physs_clock_sync_parmisc_physs0_func_rstn_func_sync(physs_clock_sync_parmisc_physs0_func_rstn_func_sync), 
    .physs0_func_rst_raw_n(physs0_func_rst_raw_n), 
    .ethphyss_post_clk_mux_ctrl(ethphyss_post_clk_mux_ctrl), 
    .DIAG_AGGR_mquad1_mbist_diag_done(parmquad1_DIAG_AGGR_mquad1_mbist_diag_done), 
    .versa_xmp_1_o_ucss_srds_pcs_tx_reset_pma0_l0_a(versa_xmp_1_o_ucss_srds_pcs_tx_reset_pma0_l0_a), 
    .versa_xmp_1_o_ucss_srds_pcs_rx_reset_pma0_l0_a(versa_xmp_1_o_ucss_srds_pcs_rx_reset_pma0_l0_a), 
    .versa_xmp_1_o_ucss_srds_pcs_tx_reset_pma2_l0_a(versa_xmp_1_o_ucss_srds_pcs_tx_reset_pma2_l0_a), 
    .versa_xmp_1_o_ucss_srds_pcs_rx_reset_pma2_l0_a(versa_xmp_1_o_ucss_srds_pcs_rx_reset_pma2_l0_a), 
    .physs_registers_wrapper_1_reset_cdmii_rxclk_override_200G(physs_registers_wrapper_1_reset_cdmii_rxclk_override_200G), 
    .physs_registers_wrapper_1_reset_cdmii_txclk_override_200G(physs_registers_wrapper_1_reset_cdmii_txclk_override_200G), 
    .physs_registers_wrapper_1_reset_sd_tx_clk_override_200G(physs_registers_wrapper_1_reset_sd_tx_clk_override_200G), 
    .physs_registers_wrapper_1_reset_sd_rx_clk_override_200G(physs_registers_wrapper_1_reset_sd_rx_clk_override_200G), 
    .physs_registers_wrapper_1_reset_reg_clk_override_200G(physs_registers_wrapper_1_reset_reg_clk_override_200G), 
    .physs_registers_wrapper_1_reset_reg_ref_clk_override_200G(physs_registers_wrapper_1_reset_reg_ref_clk_override_200G), 
    .physs_registers_wrapper_1_reset_cdmii_rxclk_override_400G(physs_registers_wrapper_1_reset_cdmii_rxclk_override_400G), 
    .physs_registers_wrapper_1_reset_cdmii_txclk_override_400G(physs_registers_wrapper_1_reset_cdmii_txclk_override_400G), 
    .physs_registers_wrapper_1_reset_sd_tx_clk_override_400G(physs_registers_wrapper_1_reset_sd_tx_clk_override_400G), 
    .physs_registers_wrapper_1_reset_sd_rx_clk_override_400G(physs_registers_wrapper_1_reset_sd_rx_clk_override_400G), 
    .physs_registers_wrapper_1_reset_reg_clk_override_400G(physs_registers_wrapper_1_reset_reg_clk_override_400G), 
    .physs_registers_wrapper_1_reset_reg_ref_clk_override_400G(physs_registers_wrapper_1_reset_reg_ref_clk_override_400G), 
    .physs_registers_wrapper_1_clk_gate_en_200G_mac_pcs_0(physs_registers_wrapper_1_clk_gate_en_200G_mac_pcs_0), 
    .physs_registers_wrapper_1_clk_gate_en_400G_mac_pcs_0(physs_registers_wrapper_1_clk_gate_en_400G_mac_pcs_0), 
    .physs_registers_wrapper_1_reset_pcs200_override_en(physs_registers_wrapper_1_reset_pcs200_override_en), 
    .physs_registers_wrapper_1_reset_pcs400_override_en(physs_registers_wrapper_1_reset_pcs400_override_en), 
    .physs_registers_wrapper_1_reset_mac200_override_en(physs_registers_wrapper_1_reset_mac200_override_en), 
    .physs_registers_wrapper_1_reset_mac400_override_en(physs_registers_wrapper_1_reset_mac400_override_en), 
    .physs_registers_wrapper_1_reset_reg_clk_override_mac_0(physs_registers_wrapper_1_reset_reg_clk_override_mac_0), 
    .physs_registers_wrapper_1_reset_ff_tx_clk_override_0(physs_registers_wrapper_1_reset_ff_tx_clk_override_0), 
    .physs_registers_wrapper_1_reset_ff_rx_clk_override_0(physs_registers_wrapper_1_reset_ff_rx_clk_override_0), 
    .physs_registers_wrapper_1_reset_txclk_override_0(physs_registers_wrapper_1_reset_txclk_override_0), 
    .physs_registers_wrapper_1_reset_rxclk_override_0(physs_registers_wrapper_1_reset_rxclk_override_0), 
    .physs_registers_wrapper_1_pcs_mode_config_pcs_external_loopback_en_lane_0(physs_registers_wrapper_1_pcs_mode_config_pcs_external_loopback_en_lane_0), 
    .versa_xmp_1_o_ucss_srds_pcs_tx_reset_pma1_l0_a(versa_xmp_1_o_ucss_srds_pcs_tx_reset_pma1_l0_a), 
    .versa_xmp_1_o_ucss_srds_pcs_tx_reset_pma3_l0_a(versa_xmp_1_o_ucss_srds_pcs_tx_reset_pma3_l0_a), 
    .versa_xmp_1_o_ucss_srds_pcs_rx_reset_pma1_l0_a(versa_xmp_1_o_ucss_srds_pcs_rx_reset_pma1_l0_a), 
    .versa_xmp_1_o_ucss_srds_pcs_rx_reset_pma3_l0_a(versa_xmp_1_o_ucss_srds_pcs_rx_reset_pma3_l0_a), 
    .rclk_diff_p(1'b0), 
    .rclk_diff_n(1'b0), 
    .mac100_4_magic_ind_0(mac100_4_magic_ind_0), 
    .mac100_5_magic_ind_0(mac100_5_magic_ind_0), 
    .mac100_6_magic_ind_0(mac100_6_magic_ind_0), 
    .mac100_7_magic_ind_0(mac100_7_magic_ind_0), 
    .icq_physs_net_xoff_0(icq_physs_net_xoff_3), 
    .icq_physs_net_xoff_1(icq_physs_net_xoff_4), 
    .icq_physs_net_xoff_2(icq_physs_net_xoff_5), 
    .icq_physs_net_xoff_3(icq_physs_net_xoff_6), 
    .mac100_4_pause_on_0(mac100_4_pause_on_0), 
    .mac100_5_pause_on_0(mac100_5_pause_on_0), 
    .mac100_6_pause_on_0(mac100_6_pause_on_0), 
    .mac100_7_pause_on_0(mac100_7_pause_on_0), 
    .versa_xmp_1_o_ucss_uart_txd(versa_xmp_1_o_ucss_uart_txd), 
    .physs_uart_demux_out1(physs_uart_demux_out1), 
    .fary_0_post_force_fail(fary_0_post_force_fail), 
    .fary_0_trigger_post(fary_0_trigger_post), 
    .fary_0_post_algo_select(fary_0_post_algo_select), 
    .xmp_mem_wrapper_1_aary_post_pass(xmp_mem_wrapper_1_aary_post_pass), 
    .xmp_mem_wrapper_1_aary_post_complete(xmp_mem_wrapper_1_aary_post_complete), 
    .fary_1_post_force_fail(fary_1_post_force_fail), 
    .fary_1_trigger_post(fary_1_trigger_post), 
    .fary_1_post_algo_select(fary_1_post_algo_select), 
    .pcs100_mem_wrapper_1_aary_post_pass(pcs100_mem_wrapper_1_aary_post_pass), 
    .pcs100_mem_wrapper_1_aary_post_complete(pcs100_mem_wrapper_1_aary_post_complete), 
    .fary_2_post_force_fail(fary_2_post_force_fail), 
    .fary_2_trigger_post(fary_2_trigger_post), 
    .fary_2_post_algo_select(fary_2_post_algo_select), 
    .ptpx_mem_wrapper_1_aary_post_pass(ptpx_mem_wrapper_1_aary_post_pass), 
    .ptpx_mem_wrapper_1_aary_post_complete(ptpx_mem_wrapper_1_aary_post_complete), 
    .fary_3_post_force_fail(fary_3_post_force_fail), 
    .fary_3_trigger_post(fary_3_trigger_post), 
    .fary_3_post_algo_select(fary_3_post_algo_select), 
    .mac100_mem_wrapper_1_aary_post_pass(mac100_mem_wrapper_1_aary_post_pass), 
    .mac100_mem_wrapper_1_aary_post_complete(mac100_mem_wrapper_1_aary_post_complete), 
    .parmquad1_o_ck_pma0_rx_dfx_ubp_ctrl_act_out_4(parmisc_physs0_trig_clock_stop_to_parmquad1_o_ck_pma0_rx), 
    .parmquad1_o_ck_pma1_rx_dfx_ubp_ctrl_act_out_5(parmisc_physs0_trig_clock_stop_to_parmquad1_o_ck_pma1_rx), 
    .parmquad1_o_ck_pma2_rx_dfx_ubp_ctrl_act_out_6(parmisc_physs0_trig_clock_stop_to_parmquad1_o_ck_pma2_rx), 
    .parmquad1_o_ck_pma3_rx_dfx_ubp_ctrl_act_out_7(parmisc_physs0_trig_clock_stop_to_parmquad1_o_ck_pma3_rx), 
    .parmquad1_pma0_rxdat_dfx_ubp_ctrl_act_out_8(parmisc_physs0_trig_clock_stop_to_parmquad1_pma0_rxdat), 
    .parmquad1_pma1_rxdat_dfx_ubp_ctrl_act_out_9(parmisc_physs0_trig_clock_stop_to_parmquad1_pma1_rxdat), 
    .parmquad1_pma2_rxdat_dfx_ubp_ctrl_act_out_10(parmisc_physs0_trig_clock_stop_to_parmquad1_pma2_rxdat), 
    .parmquad1_pma3_rxdat_dfx_ubp_ctrl_act_out_11(parmisc_physs0_trig_clock_stop_to_parmquad1_pma3_rxdat), 
    .parmquad1_o_ck_pma0_cmnplla_postdiv_dfx_ubp_ctrl_act_out_12(parmisc_physs0_trig_clock_stop_to_parmquad1_o_ck_pma0_cmnplla_postdiv), 
    .parmquad1_o_ck_pma1_cmnplla_postdiv_dfx_ubp_ctrl_act_out_13(parmisc_physs0_trig_clock_stop_to_parmquad1_o_ck_pma1_cmnplla_postdiv), 
    .parmquad1_o_ck_pma2_cmnplla_postdiv_dfx_ubp_ctrl_act_out_14(parmisc_physs0_trig_clock_stop_to_parmquad1_o_ck_pma2_cmnplla_postdiv), 
    .parmquad1_o_ck_pma3_cmnplla_postdiv_dfx_ubp_ctrl_act_out_15(parmisc_physs0_trig_clock_stop_to_parmquad1_o_ck_pma3_cmnplla_postdiv), 
    .parmquad1_o_ck_slv_pcs1_rx_dfx_ubp_ctrl_act_out_16(parmisc_physs0_trig_clock_stop_to_parmquad1_o_ck_slv_pcs1), 
    .parmquad1_o_ck_ucss_mem_dram_dfx_ubp_ctrl_act_out_17(parmisc_physs0_trig_clock_stop_to_parmquad1_o_ck_ucss_mem_dram), 
    .parmquad1_o_ck_ucss_mem_iram_dfx_ubp_ctrl_act_out_18(parmisc_physs0_trig_clock_stop_to_parmquad1_o_ck_ucss_mem_iram), 
    .parmquad1_o_ck_ucss_mem_traceram_dfx_ubp_ctrl_act_out_19(parmisc_physs0_trig_clock_stop_to_parmquad1_o_ck_ucss_mem_tracemem), 
    .pcs_lane_sel_val_par400g1_rtdr(parmquad1_pcs_lane_sel_val_par400g1_rtdr), 
    .pcs_lane_sel_ovr_par400g1_rtdr(parmquad1_pcs_lane_sel_ovr_par400g1_rtdr), 
    .quadpcs100_1_pcs_desk_buf_rlevel_0(quadpcs100_1_pcs_desk_buf_rlevel_0), 
    .quadpcs100_1_pcs_sd_bit_slip_0(quadpcs100_1_pcs_sd_bit_slip_0), 
    .quadpcs100_1_pcs_link_status_tsu_0(quadpcs100_1_pcs_link_status_tsu_0), 
    .physs_timestamp_1_timer_refpcs_0(physs_timestamp_1_timer_refpcs_0), 
    .physs_timestamp_1_timer_refpcs_1(physs_timestamp_1_timer_refpcs_1), 
    .physs_timestamp_1_timer_refpcs_2(physs_timestamp_1_timer_refpcs_2), 
    .physs_timestamp_1_timer_refpcs_3(physs_timestamp_1_timer_refpcs_3), 
    .versa_xmp_1_xioa_ck_pma0_ref0_n(versa_xmp_1_xioa_ck_pma0_ref0_n), 
    .versa_xmp_1_xioa_ck_pma0_ref0_p(versa_xmp_1_xioa_ck_pma0_ref0_p), 
    .versa_xmp_1_xioa_ck_pma0_ref1_n(versa_xmp_1_xioa_ck_pma0_ref1_n), 
    .versa_xmp_1_xioa_ck_pma0_ref1_p(versa_xmp_1_xioa_ck_pma0_ref1_p), 
    .versa_xmp_1_xioa_ck_pma1_ref0_n(versa_xmp_1_xioa_ck_pma1_ref0_n), 
    .versa_xmp_1_xioa_ck_pma1_ref0_p(versa_xmp_1_xioa_ck_pma1_ref0_p), 
    .versa_xmp_1_xioa_ck_pma1_ref1_n(versa_xmp_1_xioa_ck_pma1_ref1_n), 
    .versa_xmp_1_xioa_ck_pma1_ref1_p(versa_xmp_1_xioa_ck_pma1_ref1_p), 
    .versa_xmp_1_xioa_ck_pma2_ref0_n(versa_xmp_1_xioa_ck_pma2_ref0_n), 
    .versa_xmp_1_xioa_ck_pma2_ref0_p(versa_xmp_1_xioa_ck_pma2_ref0_p), 
    .versa_xmp_1_xioa_ck_pma2_ref1_n(versa_xmp_1_xioa_ck_pma2_ref1_n), 
    .versa_xmp_1_xioa_ck_pma2_ref1_p(versa_xmp_1_xioa_ck_pma2_ref1_p), 
    .versa_xmp_1_xioa_ck_pma3_ref0_n(versa_xmp_1_xioa_ck_pma3_ref0_n), 
    .versa_xmp_1_xioa_ck_pma3_ref0_p(versa_xmp_1_xioa_ck_pma3_ref0_p), 
    .versa_xmp_1_xioa_ck_pma3_ref1_n(versa_xmp_1_xioa_ck_pma3_ref1_n), 
    .versa_xmp_1_xioa_ck_pma3_ref1_p(versa_xmp_1_xioa_ck_pma3_ref1_p), 
    .versa_xmp_1_xoa_pma0_dcmon1(versa_xmp_1_xoa_pma0_dcmon1), 
    .versa_xmp_1_xoa_pma0_dcmon2(versa_xmp_1_xoa_pma0_dcmon2), 
    .versa_xmp_1_xoa_pma1_dcmon1(versa_xmp_1_xoa_pma1_dcmon1), 
    .versa_xmp_1_xoa_pma1_dcmon2(versa_xmp_1_xoa_pma1_dcmon2), 
    .versa_xmp_1_xoa_pma2_dcmon1(versa_xmp_1_xoa_pma2_dcmon1), 
    .versa_xmp_1_xoa_pma2_dcmon2(versa_xmp_1_xoa_pma2_dcmon2), 
    .versa_xmp_1_xoa_pma3_dcmon1(versa_xmp_1_xoa_pma3_dcmon1), 
    .versa_xmp_1_xoa_pma3_dcmon2(versa_xmp_1_xoa_pma3_dcmon2), 
    .quad_interrupts_1_physs_fatal_int(quad_interrupts_1_physs_fatal_int), 
    .quad_interrupts_1_physs_imc_int(quad_interrupts_1_physs_imc_int), 
    .mac100_4_ff_rx_err_stat_0(mac100_4_ff_rx_err_stat_0), 
    .mac100_5_ff_rx_err_stat_0(mac100_5_ff_rx_err_stat_0), 
    .mac100_6_ff_rx_err_stat_0(mac100_6_ff_rx_err_stat_0), 
    .mac100_7_ff_rx_err_stat_0(mac100_7_ff_rx_err_stat_0), 
    .versa_xmp_1_o_ucss_irq_cpi_0_a(versa_xmp_1_o_ucss_irq_cpi_0_a), 
    .versa_xmp_1_o_ucss_irq_cpi_1_a(versa_xmp_1_o_ucss_irq_cpi_1_a), 
    .versa_xmp_1_o_ucss_irq_cpi_2_a(versa_xmp_1_o_ucss_irq_cpi_2_a), 
    .versa_xmp_1_o_ucss_irq_cpi_3_a(versa_xmp_1_o_ucss_irq_cpi_3_a), 
    .versa_xmp_1_o_ucss_irq_cpi_4_a(versa_xmp_1_o_ucss_irq_cpi_4_a), 
    .versa_xmp_1_o_ucss_irq_to_soc_l0_a(versa_xmp_1_o_ucss_irq_to_soc_l0_a), 
    .versa_xmp_1_o_ucss_irq_to_soc_l1_a(versa_xmp_1_o_ucss_irq_to_soc_l1_a), 
    .versa_xmp_1_o_ucss_irq_to_soc_l2_a(versa_xmp_1_o_ucss_irq_to_soc_l2_a), 
    .versa_xmp_1_o_ucss_irq_to_soc_l3_a(versa_xmp_1_o_ucss_irq_to_soc_l3_a), 
    .physs_core_rst_fsm_1_enable_link_traffic_to_nss_reg_clr(physs_core_rst_fsm_1_enable_link_traffic_to_nss_reg_clr), 
    .physs_registers_wrapper_1_link_traffic_to_nss_enable_O_0(physs_registers_wrapper_1_link_traffic_to_nss_enable_O_0), 
    .physs_registers_wrapper_0_ETH_GLTSYN_SHTIME_L_0_tsyntime_0_0(physs_registers_wrapper_0_ETH_GLTSYN_SHTIME_L_0_tsyntime_0_0), 
    .physs_registers_wrapper_0_ETH_GLTSYN_SHTIME_H_0_tsyntime_l_0(physs_registers_wrapper_0_ETH_GLTSYN_SHTIME_H_0_tsyntime_l_0), 
    .physs_registers_wrapper_0_ETH_GLTSYN_INCVAL_L_0_incval_l_0_0(physs_registers_wrapper_0_ETH_GLTSYN_INCVAL_L_0_incval_l_0_0), 
    .physs_registers_wrapper_0_ETH_GLTSYN_INCVAL_H_0_incval_h_0_0(physs_registers_wrapper_0_ETH_GLTSYN_INCVAL_H_0_incval_h_0_0), 
    .physs_registers_wrapper_0_ETH_GLTSYN_SHADJ_L_0_adjust_l_0(physs_registers_wrapper_0_ETH_GLTSYN_SHADJ_L_0_adjust_l_0), 
    .physs_registers_wrapper_0_ETH_GLTSYN_SHADJ_H_0_adjust_h_0(physs_registers_wrapper_0_ETH_GLTSYN_SHADJ_H_0_adjust_h_0), 
    .physs_registers_wrapper_0_ETH_GLTSYN_TIME_0_0_tsyntime_0_0(physs_registers_wrapper_0_ETH_GLTSYN_TIME_0_0_tsyntime_0_0), 
    .physs_registers_wrapper_0_ETH_GLTSYN_TIME_L_0_tsyntime_l_0(physs_registers_wrapper_0_ETH_GLTSYN_TIME_L_0_tsyntime_l_0), 
    .physs_registers_wrapper_0_ETH_GLTSYN_ENA_0_tsyn_ena_0(physs_registers_wrapper_0_ETH_GLTSYN_ENA_0_tsyn_ena_0), 
    .physs_registers_wrapper_0_ETH_GLTSYN_CMD_0_cmd_0(physs_registers_wrapper_0_ETH_GLTSYN_CMD_0_cmd_0), 
    .physs_registers_wrapper_0_ETH_GLTSYN_SYNC_DLAY_0_sync_delay_0(physs_registers_wrapper_0_ETH_GLTSYN_SYNC_DLAY_0_sync_delay_0), 
    .physs_registers_wrapper_0_TIMER_REFPCS_INCVAL_H_0_incval_h_0_0(physs_registers_wrapper_0_TIMER_REFPCS_INCVAL_H_0_incval_h_0_0), 
    .physs_registers_wrapper_0_TIMER_REFPCS_INCVAL_L_0_incval_l_0_0(physs_registers_wrapper_0_TIMER_REFPCS_INCVAL_L_0_incval_l_0_0), 
    .physs_registers_wrapper_0_REFPCS_TIMER_CTRL_0_func_timer_err_chk_dis_0(physs_registers_wrapper_0_REFPCS_TIMER_CTRL_0_func_timer_err_chk_dis_0), 
    .physs_registers_wrapper_0_REFPCS_TIMER_CTRL_0_samp_1588_and_refpcs_timer_0(physs_registers_wrapper_0_REFPCS_TIMER_CTRL_0_samp_1588_and_refpcs_timer_0), 
    .physs_registers_wrapper_0_REFPCS_TIMER_CTRL_1_sync1588_pulse_interval(physs_registers_wrapper_0_REFPCS_TIMER_CTRL_1_sync1588_pulse_interval), 
    .physs_registers_wrapper_0_REFPCS_TIMER_CTRL_0_ts_valid_if_timer_en_0(physs_registers_wrapper_0_REFPCS_TIMER_CTRL_0_ts_valid_if_timer_en_0), 
    .nic_switch_mux_1_hlp_xlgmii0_txclk_ena(nic_switch_mux_1_hlp_xlgmii0_txclk_ena), 
    .nic_switch_mux_1_hlp_xlgmii0_rxclk_ena(nic_switch_mux_1_hlp_xlgmii0_rxclk_ena), 
    .nic_switch_mux_1_hlp_xlgmii0_rxc(nic_switch_mux_1_hlp_xlgmii0_rxc), 
    .nic_switch_mux_1_hlp_xlgmii0_rxd(nic_switch_mux_1_hlp_xlgmii0_rxd), 
    .nic_switch_mux_1_hlp_xlgmii0_rxt0_next(nic_switch_mux_1_hlp_xlgmii0_rxt0_next), 
    .pcs_mac_pipeline_top_wrap_mquad1_pcs0_xlgmii_tx_txc(pcs_mac_pipeline_top_wrap_mquad1_pcs0_xlgmii_tx_txc), 
    .pcs_mac_pipeline_top_wrap_mquad1_pcs0_xlgmii_tx_txd(pcs_mac_pipeline_top_wrap_mquad1_pcs0_xlgmii_tx_txd), 
    .quadpcs100_1_pcs_tsu_rx_sd_0(quadpcs100_1_pcs_tsu_rx_sd_0), 
    .quadpcs100_1_mii_rx_tsu_mux0_0(quadpcs100_1_mii_rx_tsu_mux0_0), 
    .quadpcs100_1_mii_tx_tsu_0(quadpcs100_1_mii_tx_tsu_0), 
    .nic_switch_mux_1_hlp_xlgmii1_txclk_ena(nic_switch_mux_1_hlp_xlgmii1_txclk_ena), 
    .nic_switch_mux_1_hlp_xlgmii1_rxclk_ena(nic_switch_mux_1_hlp_xlgmii1_rxclk_ena), 
    .nic_switch_mux_1_hlp_xlgmii1_rxc(nic_switch_mux_1_hlp_xlgmii1_rxc), 
    .nic_switch_mux_1_hlp_xlgmii1_rxd(nic_switch_mux_1_hlp_xlgmii1_rxd), 
    .nic_switch_mux_1_hlp_xlgmii1_rxt0_next(nic_switch_mux_1_hlp_xlgmii1_rxt0_next), 
    .pcs_mac_pipeline_top_wrap_mquad1_pcs1_xlgmii_tx_txc(pcs_mac_pipeline_top_wrap_mquad1_pcs1_xlgmii_tx_txc), 
    .pcs_mac_pipeline_top_wrap_mquad1_pcs1_xlgmii_tx_txd(pcs_mac_pipeline_top_wrap_mquad1_pcs1_xlgmii_tx_txd), 
    .quadpcs100_1_pcs_tsu_rx_sd_1(quadpcs100_1_pcs_tsu_rx_sd_1), 
    .quadpcs100_1_mii_rx_tsu_mux1_0(quadpcs100_1_mii_rx_tsu_mux1_0), 
    .quadpcs100_1_mii_tx_tsu_1(quadpcs100_1_mii_tx_tsu_1), 
    .nic_switch_mux_1_hlp_xlgmii2_txclk_ena(nic_switch_mux_1_hlp_xlgmii2_txclk_ena), 
    .nic_switch_mux_1_hlp_xlgmii2_rxclk_ena(nic_switch_mux_1_hlp_xlgmii2_rxclk_ena), 
    .nic_switch_mux_1_hlp_xlgmii2_rxc(nic_switch_mux_1_hlp_xlgmii2_rxc), 
    .nic_switch_mux_1_hlp_xlgmii2_rxd(nic_switch_mux_1_hlp_xlgmii2_rxd), 
    .nic_switch_mux_1_hlp_xlgmii2_rxt0_next(nic_switch_mux_1_hlp_xlgmii2_rxt0_next), 
    .pcs_mac_pipeline_top_wrap_mquad1_pcs2_xlgmii_tx_txc(pcs_mac_pipeline_top_wrap_mquad1_pcs2_xlgmii_tx_txc), 
    .pcs_mac_pipeline_top_wrap_mquad1_pcs2_xlgmii_tx_txd(pcs_mac_pipeline_top_wrap_mquad1_pcs2_xlgmii_tx_txd), 
    .quadpcs100_1_pcs_tsu_rx_sd_2(quadpcs100_1_pcs_tsu_rx_sd_2), 
    .quadpcs100_1_mii_rx_tsu_mux2_0(quadpcs100_1_mii_rx_tsu_mux2_0), 
    .quadpcs100_1_mii_tx_tsu_2(quadpcs100_1_mii_tx_tsu_2), 
    .nic_switch_mux_1_hlp_xlgmii3_txclk_ena(nic_switch_mux_1_hlp_xlgmii3_txclk_ena), 
    .nic_switch_mux_1_hlp_xlgmii3_rxclk_ena(nic_switch_mux_1_hlp_xlgmii3_rxclk_ena), 
    .nic_switch_mux_1_hlp_xlgmii3_rxc(nic_switch_mux_1_hlp_xlgmii3_rxc), 
    .nic_switch_mux_1_hlp_xlgmii3_rxd(nic_switch_mux_1_hlp_xlgmii3_rxd), 
    .nic_switch_mux_1_hlp_xlgmii3_rxt0_next(nic_switch_mux_1_hlp_xlgmii3_rxt0_next), 
    .pcs_mac_pipeline_top_wrap_mquad1_pcs3_xlgmii_tx_txc(pcs_mac_pipeline_top_wrap_mquad1_pcs3_xlgmii_tx_txc), 
    .pcs_mac_pipeline_top_wrap_mquad1_pcs3_xlgmii_tx_txd(pcs_mac_pipeline_top_wrap_mquad1_pcs3_xlgmii_tx_txd), 
    .quadpcs100_1_pcs_tsu_rx_sd_3(quadpcs100_1_pcs_tsu_rx_sd_3), 
    .quadpcs100_1_mii_rx_tsu_mux3_0(quadpcs100_1_mii_rx_tsu_mux3_0), 
    .quadpcs100_1_mii_tx_tsu_3(quadpcs100_1_mii_tx_tsu_3), 
    .nic_switch_mux_1_hlp_cgmii0_txclk_ena(nic_switch_mux_1_hlp_cgmii0_txclk_ena), 
    .nic_switch_mux_1_hlp_cgmii0_rxclk_ena(nic_switch_mux_1_hlp_cgmii0_rxclk_ena), 
    .nic_switch_mux_1_hlp_cgmii0_rxc(nic_switch_mux_1_hlp_cgmii0_rxc), 
    .nic_switch_mux_1_hlp_cgmii0_rxd(nic_switch_mux_1_hlp_cgmii0_rxd), 
    .pcs_mac_pipeline_top_wrap_mquad1_pcs0_cgmii_tx_txc(pcs_mac_pipeline_top_wrap_mquad1_pcs0_cgmii_tx_txc), 
    .pcs_mac_pipeline_top_wrap_mquad1_pcs0_cgmii_tx_txd(pcs_mac_pipeline_top_wrap_mquad1_pcs0_cgmii_tx_txd), 
    .nic_switch_mux_1_hlp_cgmii1_txclk_ena(nic_switch_mux_1_hlp_cgmii1_txclk_ena), 
    .nic_switch_mux_1_hlp_cgmii1_rxclk_ena(nic_switch_mux_1_hlp_cgmii1_rxclk_ena), 
    .nic_switch_mux_1_hlp_cgmii1_rxc(nic_switch_mux_1_hlp_cgmii1_rxc), 
    .nic_switch_mux_1_hlp_cgmii1_rxd(nic_switch_mux_1_hlp_cgmii1_rxd), 
    .pcs_mac_pipeline_top_wrap_mquad1_pcs1_cgmii_tx_txc(pcs_mac_pipeline_top_wrap_mquad1_pcs1_cgmii_tx_txc), 
    .pcs_mac_pipeline_top_wrap_mquad1_pcs1_cgmii_tx_txd(pcs_mac_pipeline_top_wrap_mquad1_pcs1_cgmii_tx_txd), 
    .nic_switch_mux_1_hlp_cgmii2_txclk_ena(nic_switch_mux_1_hlp_cgmii2_txclk_ena), 
    .nic_switch_mux_1_hlp_cgmii2_rxclk_ena(nic_switch_mux_1_hlp_cgmii2_rxclk_ena), 
    .nic_switch_mux_1_hlp_cgmii2_rxc(nic_switch_mux_1_hlp_cgmii2_rxc), 
    .nic_switch_mux_1_hlp_cgmii2_rxd(nic_switch_mux_1_hlp_cgmii2_rxd), 
    .pcs_mac_pipeline_top_wrap_mquad1_pcs2_cgmii_tx_txc(pcs_mac_pipeline_top_wrap_mquad1_pcs2_cgmii_tx_txc), 
    .pcs_mac_pipeline_top_wrap_mquad1_pcs2_cgmii_tx_txd(pcs_mac_pipeline_top_wrap_mquad1_pcs2_cgmii_tx_txd), 
    .nic_switch_mux_1_hlp_cgmii3_txclk_ena(nic_switch_mux_1_hlp_cgmii3_txclk_ena), 
    .nic_switch_mux_1_hlp_cgmii3_rxclk_ena(nic_switch_mux_1_hlp_cgmii3_rxclk_ena), 
    .nic_switch_mux_1_hlp_cgmii3_rxc(nic_switch_mux_1_hlp_cgmii3_rxc), 
    .nic_switch_mux_1_hlp_cgmii3_rxd(nic_switch_mux_1_hlp_cgmii3_rxd), 
    .pcs_mac_pipeline_top_wrap_mquad1_pcs3_cgmii_tx_txc(pcs_mac_pipeline_top_wrap_mquad1_pcs3_cgmii_tx_txc), 
    .pcs_mac_pipeline_top_wrap_mquad1_pcs3_cgmii_tx_txd(pcs_mac_pipeline_top_wrap_mquad1_pcs3_cgmii_tx_txd), 
    .hlp_xlgmii0_rxc_nss_1(8'b0), 
    .hlp_xlgmii0_rxd_nss_1(64'b0), 
    .hlp_xlgmii1_rxc_nss_1(8'b0), 
    .hlp_xlgmii1_rxd_nss_1(64'b0), 
    .hlp_xlgmii2_rxc_nss_1(8'b0), 
    .hlp_xlgmii2_rxd_nss_1(64'b0), 
    .hlp_xlgmii3_rxc_nss_1(8'b0), 
    .hlp_xlgmii3_rxd_nss_1(64'b0), 
    .hlp_cgmii0_rxd_nss_1(128'b0), 
    .hlp_cgmii0_rxc_nss_1(16'b0), 
    .hlp_cgmii1_rxd_nss_1(128'b0), 
    .hlp_cgmii1_rxc_nss_1(16'b0), 
    .hlp_cgmii2_rxd_nss_1(128'b0), 
    .hlp_cgmii2_rxc_nss_1(16'b0), 
    .hlp_cgmii3_rxd_nss_1(128'b0), 
    .hlp_cgmii3_rxc_nss_1(16'b0), 
    .fifo_mux_1_mac100g_0_tx_ts_frm(fifo_mux_1_mac100g_0_tx_ts_frm), 
    .fifo_mux_1_mac100g_0_tx_id(fifo_mux_1_mac100g_0_tx_id), 
    .fifo_mux_1_mac100g_1_tx_ts_frm(fifo_mux_1_mac100g_1_tx_ts_frm), 
    .fifo_mux_1_mac100g_1_tx_id(fifo_mux_1_mac100g_1_tx_id), 
    .fifo_mux_1_mac100g_2_tx_ts_frm(fifo_mux_1_mac100g_2_tx_ts_frm), 
    .fifo_mux_1_mac100g_2_tx_id(fifo_mux_1_mac100g_2_tx_id), 
    .fifo_mux_1_mac100g_3_tx_ts_frm(fifo_mux_1_mac100g_3_tx_ts_frm), 
    .fifo_mux_1_mac100g_3_tx_id(fifo_mux_1_mac100g_3_tx_id), 
    .physs_pcs_mux_200_400_1_tx_ts_val(physs_pcs_mux_200_400_1_tx_ts_val), 
    .physs_pcs_mux_200_400_1_tx_ts_id_0(physs_pcs_mux_200_400_1_tx_ts_id_0), 
    .physs_pcs_mux_200_400_1_tx_ts_id_1(physs_pcs_mux_200_400_1_tx_ts_id_1), 
    .physs_pcs_mux_200_400_1_tx_ts_id_2(physs_pcs_mux_200_400_1_tx_ts_id_2), 
    .physs_pcs_mux_200_400_1_tx_ts_id_3(physs_pcs_mux_200_400_1_tx_ts_id_3), 
    .physs_pcs_mux_200_400_1_tx_ts_0(physs_pcs_mux_200_400_1_tx_ts_0), 
    .physs_pcs_mux_200_400_1_tx_ts_1(physs_pcs_mux_200_400_1_tx_ts_1), 
    .physs_pcs_mux_200_400_1_tx_ts_2(physs_pcs_mux_200_400_1_tx_ts_2), 
    .physs_pcs_mux_200_400_1_tx_ts_3(physs_pcs_mux_200_400_1_tx_ts_3), 
    .physs_pcs_mux_1_srds_rdy_out_800G(physs_pcs_mux_1_srds_rdy_out_800G), 
    .physs_registers_wrapper_1_pcs_xmp_align_done_sync(physs_registers_wrapper_1_pcs_xmp_align_done_sync), 
    .physs_registers_wrapper_1_pcs_xmp_hi_ber_sync(physs_registers_wrapper_1_pcs_xmp_hi_ber_sync), 
    .physs_registers_wrapper_1_pcs_xmp_block_lock_sync(physs_registers_wrapper_1_pcs_xmp_block_lock_sync), 
    .physs_pipeline_reg_800g_misc_4_data_out(physs_pipeline_reg_800g_misc_4_data_out), 
    .physs_pipeline_reg_800g_misc_5_data_out(physs_pipeline_reg_800g_misc_5_data_out), 
    .physs_pipeline_reg_800g_misc_6_data_out(physs_pipeline_reg_800g_misc_6_data_out), 
    .physs_pipeline_reg_800g_misc_7_data_out(physs_pipeline_reg_800g_misc_7_data_out), 
    .physs_mux_800G_link_status_out(physs_mux_800G_link_status_out), 
    .physs_mux_800G_pcs_align_done_out_0(physs_mux_800G_pcs_align_done_out_0), 
    .physs_mux_800G_pcs_hi_ber_out_0(physs_mux_800G_pcs_hi_ber_out_0), 
    .physs_mux_800G_pcs_block_lock_out_0(physs_mux_800G_pcs_block_lock_out_0), 
    .physs_pipeline_reg_800g_12_data_out(physs_pipeline_reg_800g_12_data_out), 
    .physs_pipeline_reg_800g_13_data_out(physs_pipeline_reg_800g_13_data_out), 
    .physs_pipeline_reg_800g_14_data_out(physs_pipeline_reg_800g_14_data_out), 
    .physs_pipeline_reg_800g_15_data_out(physs_pipeline_reg_800g_15_data_out), 
    .physs_pcs_mux_200_400_1_sd0_tx_data_o(physs_pcs_mux_200_400_1_sd0_tx_data_o), 
    .physs_pcs_mux_200_400_1_sd1_tx_data_o(physs_pcs_mux_200_400_1_sd1_tx_data_o), 
    .physs_pcs_mux_200_400_1_sd2_tx_data_o(physs_pcs_mux_200_400_1_sd2_tx_data_o), 
    .physs_pcs_mux_200_400_1_sd3_tx_data_o(physs_pcs_mux_200_400_1_sd3_tx_data_o), 
    .physs_pipeline_reg_12_data_out(physs_pipeline_reg_12_data_out), 
    .physs_pipeline_reg_13_data_out(physs_pipeline_reg_13_data_out), 
    .physs_pipeline_reg_14_data_out(physs_pipeline_reg_14_data_out), 
    .physs_pipeline_reg_15_data_out(physs_pipeline_reg_15_data_out), 
    .physs_lane_reversal_mux_1_oflux_srds_rdy_out(physs_lane_reversal_mux_1_oflux_srds_rdy_out), 
    .physs_pcs_mux_200_400_1_link_status_out(physs_pcs_mux_200_400_1_link_status_out), 
    .physs_link_speed_decoder_4_link_speed_out(physs_link_speed_decoder_4_link_speed_out), 
    .physs_link_speed_decoder_5_link_speed_out(physs_link_speed_decoder_5_link_speed_out), 
    .physs_link_speed_decoder_6_link_speed_out(physs_link_speed_decoder_6_link_speed_out), 
    .physs_link_speed_decoder_7_link_speed_out(physs_link_speed_decoder_7_link_speed_out), 
    .mac100_4_ff_rx_dval_0(mac100_4_ff_rx_dval_0), 
    .mac100_4_ff_rx_data(mac100_4_ff_rx_data), 
    .mac100_4_ff_rx_sop(mac100_4_ff_rx_sop), 
    .mac100_4_ff_rx_eop_0(mac100_4_ff_rx_eop_0), 
    .mac100_4_ff_rx_mod_0(mac100_4_ff_rx_mod_0), 
    .mac100_4_ff_rx_err_0(mac100_4_ff_rx_err_0), 
    .fifo_mux_1_mac100g_0_rx_rdy(fifo_mux_1_mac100g_0_rx_rdy), 
    .mac100_4_ff_rx_ts_0(mac100_4_ff_rx_ts_0), 
    .mac100_4_ff_rx_ts_1(mac100_4_ff_rx_ts_1), 
    .fifo_mux_1_mac100g_0_tx_wren(fifo_mux_1_mac100g_0_tx_wren), 
    .fifo_mux_1_mac100g_0_tx_data(fifo_mux_1_mac100g_0_tx_data), 
    .fifo_mux_1_mac100g_0_tx_sop(fifo_mux_1_mac100g_0_tx_sop), 
    .fifo_mux_1_mac100g_0_tx_eop(fifo_mux_1_mac100g_0_tx_eop), 
    .fifo_mux_1_mac100g_0_tx_mod(fifo_mux_1_mac100g_0_tx_mod), 
    .fifo_mux_1_mac100g_0_tx_err(fifo_mux_1_mac100g_0_tx_err), 
    .fifo_mux_1_mac100g_0_tx_crc(fifo_mux_1_mac100g_0_tx_crc), 
    .mac100_4_ff_tx_rdy_0(mac100_4_ff_tx_rdy_0), 
    .mac100_4_pfc_mode(mac100_4_pfc_mode), 
    .mac100_5_ff_rx_dval_0(mac100_5_ff_rx_dval_0), 
    .mac100_5_ff_rx_data(mac100_5_ff_rx_data), 
    .mac100_5_ff_rx_sop(mac100_5_ff_rx_sop), 
    .mac100_5_ff_rx_eop_0(mac100_5_ff_rx_eop_0), 
    .mac100_5_ff_rx_mod_0(mac100_5_ff_rx_mod_0), 
    .mac100_5_ff_rx_err_0(mac100_5_ff_rx_err_0), 
    .fifo_mux_1_mac100g_1_rx_rdy(fifo_mux_1_mac100g_1_rx_rdy), 
    .mac100_5_ff_rx_ts_0(mac100_5_ff_rx_ts_0), 
    .mac100_5_ff_rx_ts_1(mac100_5_ff_rx_ts_1), 
    .fifo_mux_1_mac100g_1_tx_wren(fifo_mux_1_mac100g_1_tx_wren), 
    .fifo_mux_1_mac100g_1_tx_data(fifo_mux_1_mac100g_1_tx_data), 
    .fifo_mux_1_mac100g_1_tx_sop(fifo_mux_1_mac100g_1_tx_sop), 
    .fifo_mux_1_mac100g_1_tx_eop(fifo_mux_1_mac100g_1_tx_eop), 
    .fifo_mux_1_mac100g_1_tx_mod(fifo_mux_1_mac100g_1_tx_mod), 
    .fifo_mux_1_mac100g_1_tx_err(fifo_mux_1_mac100g_1_tx_err), 
    .fifo_mux_1_mac100g_1_tx_crc(fifo_mux_1_mac100g_1_tx_crc), 
    .mac100_5_ff_tx_rdy_0(mac100_5_ff_tx_rdy_0), 
    .mac100_5_pfc_mode(mac100_5_pfc_mode), 
    .mac100_6_ff_rx_dval_0(mac100_6_ff_rx_dval_0), 
    .mac100_6_ff_rx_data(mac100_6_ff_rx_data), 
    .mac100_6_ff_rx_sop(mac100_6_ff_rx_sop), 
    .mac100_6_ff_rx_eop_0(mac100_6_ff_rx_eop_0), 
    .mac100_6_ff_rx_mod_0(mac100_6_ff_rx_mod_0), 
    .mac100_6_ff_rx_err_0(mac100_6_ff_rx_err_0), 
    .fifo_mux_1_mac100g_2_rx_rdy(fifo_mux_1_mac100g_2_rx_rdy), 
    .mac100_6_ff_rx_ts_0(mac100_6_ff_rx_ts_0), 
    .mac100_6_ff_rx_ts_1(mac100_6_ff_rx_ts_1), 
    .fifo_mux_1_mac100g_2_tx_wren(fifo_mux_1_mac100g_2_tx_wren), 
    .fifo_mux_1_mac100g_2_tx_data(fifo_mux_1_mac100g_2_tx_data), 
    .fifo_mux_1_mac100g_2_tx_sop(fifo_mux_1_mac100g_2_tx_sop), 
    .fifo_mux_1_mac100g_2_tx_eop(fifo_mux_1_mac100g_2_tx_eop), 
    .fifo_mux_1_mac100g_2_tx_mod(fifo_mux_1_mac100g_2_tx_mod), 
    .fifo_mux_1_mac100g_2_tx_err(fifo_mux_1_mac100g_2_tx_err), 
    .fifo_mux_1_mac100g_2_tx_crc(fifo_mux_1_mac100g_2_tx_crc), 
    .mac100_6_ff_tx_rdy_0(mac100_6_ff_tx_rdy_0), 
    .mac100_6_pfc_mode(mac100_6_pfc_mode), 
    .mac100_7_ff_rx_dval_0(mac100_7_ff_rx_dval_0), 
    .mac100_7_ff_rx_data(mac100_7_ff_rx_data), 
    .mac100_7_ff_rx_sop(mac100_7_ff_rx_sop), 
    .mac100_7_ff_rx_eop_0(mac100_7_ff_rx_eop_0), 
    .mac100_7_ff_rx_mod_0(mac100_7_ff_rx_mod_0), 
    .mac100_7_ff_rx_err_0(mac100_7_ff_rx_err_0), 
    .fifo_mux_1_mac100g_3_rx_rdy(fifo_mux_1_mac100g_3_rx_rdy), 
    .mac100_7_ff_rx_ts_0(mac100_7_ff_rx_ts_0), 
    .mac100_7_ff_rx_ts_1(mac100_7_ff_rx_ts_1), 
    .fifo_mux_1_mac100g_3_tx_wren(fifo_mux_1_mac100g_3_tx_wren), 
    .fifo_mux_1_mac100g_3_tx_data(fifo_mux_1_mac100g_3_tx_data), 
    .fifo_mux_1_mac100g_3_tx_sop(fifo_mux_1_mac100g_3_tx_sop), 
    .fifo_mux_1_mac100g_3_tx_eop(fifo_mux_1_mac100g_3_tx_eop), 
    .fifo_mux_1_mac100g_3_tx_mod(fifo_mux_1_mac100g_3_tx_mod), 
    .fifo_mux_1_mac100g_3_tx_err(fifo_mux_1_mac100g_3_tx_err), 
    .fifo_mux_1_mac100g_3_tx_crc(fifo_mux_1_mac100g_3_tx_crc), 
    .mac100_7_ff_tx_rdy_0(mac100_7_ff_tx_rdy_0), 
    .mac100_7_pfc_mode(mac100_7_pfc_mode), 
    .quad_interrupts_1_mac400_int(quad_interrupts_1_mac400_int), 
    .mac400_1_ff_rx_err_0(mac400_1_ff_rx_err_0), 
    .mac200_1_ff_rx_err_0(mac200_1_ff_rx_err_0), 
    .nic400_physs_0_awaddr_master_quad1_out(nic400_physs_0_awaddr_master_quad1_out), 
    .nic400_physs_0_awlen_master_quad1(nic400_physs_0_awlen_master_quad1), 
    .nic400_physs_0_awsize_master_quad1(nic400_physs_0_awsize_master_quad1), 
    .nic400_physs_0_awburst_master_quad1(nic400_physs_0_awburst_master_quad1), 
    .nic400_physs_0_awlock_master_quad1(nic400_physs_0_awlock_master_quad1), 
    .nic400_physs_0_awcache_master_quad1(nic400_physs_0_awcache_master_quad1), 
    .nic400_physs_0_awprot_master_quad1(nic400_physs_0_awprot_master_quad1), 
    .nic400_physs_0_awvalid_master_quad1(nic400_physs_0_awvalid_master_quad1), 
    .nic400_quad_1_awready_slave_quad_if0(nic400_quad_1_awready_slave_quad_if0), 
    .nic400_physs_0_wdata_master_quad1(nic400_physs_0_wdata_master_quad1), 
    .nic400_physs_0_wstrb_master_quad1(nic400_physs_0_wstrb_master_quad1), 
    .nic400_physs_0_wlast_master_quad1(nic400_physs_0_wlast_master_quad1), 
    .nic400_physs_0_wvalid_master_quad1(nic400_physs_0_wvalid_master_quad1), 
    .nic400_quad_1_wready_slave_quad_if0(nic400_quad_1_wready_slave_quad_if0), 
    .nic400_quad_1_bresp_slave_quad_if0(nic400_quad_1_bresp_slave_quad_if0), 
    .nic400_quad_1_bvalid_slave_quad_if0(nic400_quad_1_bvalid_slave_quad_if0), 
    .nic400_physs_0_bready_master_quad1(nic400_physs_0_bready_master_quad1), 
    .nic400_physs_0_araddr_master_quad1_out(nic400_physs_0_araddr_master_quad1_out), 
    .nic400_physs_0_arlen_master_quad1(nic400_physs_0_arlen_master_quad1), 
    .nic400_physs_0_arsize_master_quad1(nic400_physs_0_arsize_master_quad1), 
    .nic400_physs_0_arburst_master_quad1(nic400_physs_0_arburst_master_quad1), 
    .nic400_physs_0_arlock_master_quad1(nic400_physs_0_arlock_master_quad1), 
    .nic400_physs_0_arcache_master_quad1(nic400_physs_0_arcache_master_quad1), 
    .nic400_physs_0_arprot_master_quad1(nic400_physs_0_arprot_master_quad1), 
    .nic400_physs_0_arvalid_master_quad1(nic400_physs_0_arvalid_master_quad1), 
    .nic400_quad_1_arready_slave_quad_if0(nic400_quad_1_arready_slave_quad_if0), 
    .nic400_quad_1_rdata_slave_quad_if0(nic400_quad_1_rdata_slave_quad_if0), 
    .nic400_quad_1_rresp_slave_quad_if0(nic400_quad_1_rresp_slave_quad_if0), 
    .nic400_quad_1_rlast_slave_quad_if0(nic400_quad_1_rlast_slave_quad_if0), 
    .nic400_quad_1_rvalid_slave_quad_if0(nic400_quad_1_rvalid_slave_quad_if0), 
    .nic400_physs_0_rready_master_quad1(nic400_physs_0_rready_master_quad1), 
    .nic400_physs_0_awid_master_quad1(nic400_physs_0_awid_master_quad1), 
    .nic400_physs_0_arid_master_quad1(nic400_physs_0_arid_master_quad1), 
    .nic400_quad_1_rid_slave_quad_if0(nic400_quad_1_rid_slave_quad_if0), 
    .nic400_quad_1_bid_slave_quad_if0(nic400_quad_1_bid_slave_quad_if0), 
    .nic400_physs_0_hreadyout_slave_quad1(nic400_physs_0_hreadyout_slave_quad1), 
    .nic400_physs_0_hresp_slave_quad1(nic400_physs_0_hresp_slave_quad1), 
    .nic400_physs_0_hrdata_slave_quad1(nic400_physs_0_hrdata_slave_quad1), 
    .nic400_quad_1_hselx_master_physs(nic400_quad_1_hselx_master_physs), 
    .nic400_quad_1_haddr_master_physs_out(nic400_quad_1_haddr_master_physs_out), 
    .nic400_quad_1_hwrite_master_physs(nic400_quad_1_hwrite_master_physs), 
    .nic400_quad_1_htrans_master_physs(nic400_quad_1_htrans_master_physs), 
    .nic400_quad_1_hsize_master_physs(nic400_quad_1_hsize_master_physs), 
    .nic400_quad_1_hburst_master_physs(nic400_quad_1_hburst_master_physs), 
    .nic400_quad_1_hprot_master_physs(nic400_quad_1_hprot_master_physs), 
    .nic400_quad_1_hready_master_physs(nic400_quad_1_hready_master_physs), 
    .nic400_quad_1_hwdata_master_physs(nic400_quad_1_hwdata_master_physs), 
    .physs0_ioa_ck_pma0_ref_left_mquad1_physs0(ioa_ck_pma0_ref_left_mquad1_physs0), 
    .physs0_ioa_ck_pma3_ref_right_mquad1_physs0(ioa_ck_pma3_ref_right_mquad1_physs0), 
    .socviewpin_32to1digimux_10_outmux(socviewpin_32to1digimux_10_outmux), 
    .socviewpin_32to1digimux_11_outmux(socviewpin_32to1digimux_11_outmux), 
    .physs_registers_wrapper_1_viewpin_mux_select_2(physs_registers_wrapper_1_viewpin_mux_select_2), 
    .physs_registers_wrapper_1_viewpin_mux_en_2(physs_registers_wrapper_1_viewpin_mux_en_2), 
    .quad_interrupts_1_mac100_int(quad_interrupts_1_mac100_int), 
    .physs_timesync_sync_val(physs_timesync_sync_val), 
    .quad_interrupts_1_ts_int_imc_o(quad_interrupts_1_ts_int_imc_o), 
    .quad_interrupts_1_ts_int_o(quad_interrupts_1_ts_int_o), 
    .quadpcs100_1_pcs_desk_buf_rlevel(quadpcs100_1_pcs_desk_buf_rlevel), 
    .quadpcs100_1_pcs_desk_buf_rlevel_1(quadpcs100_1_pcs_desk_buf_rlevel_1), 
    .quadpcs100_1_pcs_desk_buf_rlevel_2(quadpcs100_1_pcs_desk_buf_rlevel_2), 
    .quadpcs100_1_pcs_desk_buf_rlevel_3(quadpcs100_1_pcs_desk_buf_rlevel_3), 
    .BSCAN_PIPE_IN_2_scan_in(parmisc_physs0_BSCAN_PIPE_OUT_2_scan_in), 
    .BSCAN_PIPE_OUT_2_scan_out(parmquad1_BSCAN_PIPE_OUT_2_scan_out), 
    .BSCAN_PIPE_IN_2_force_disable(parmisc_physs0_BSCAN_PIPE_OUT_2_force_disable), 
    .BSCAN_PIPE_IN_2_select_jtag_input(parmisc_physs0_BSCAN_PIPE_OUT_2_select_jtag_input), 
    .BSCAN_PIPE_IN_2_select_jtag_output(parmisc_physs0_BSCAN_PIPE_OUT_2_select_jtag_output), 
    .BSCAN_PIPE_IN_2_ac_init_clock0(parmisc_physs0_BSCAN_PIPE_OUT_2_ac_init_clock0), 
    .BSCAN_PIPE_IN_2_ac_init_clock1(parmisc_physs0_BSCAN_PIPE_OUT_2_ac_init_clock1), 
    .BSCAN_PIPE_IN_2_ac_signal(parmisc_physs0_BSCAN_PIPE_OUT_2_ac_signal), 
    .BSCAN_PIPE_IN_2_ac_mode_en(parmisc_physs0_BSCAN_PIPE_OUT_2_ac_mode_en), 
    .BSCAN_PIPE_IN_2_intel_update_clk(parmisc_physs0_BSCAN_PIPE_OUT_2_intel_update_clk), 
    .BSCAN_PIPE_IN_2_intel_clamp_en(parmisc_physs0_BSCAN_PIPE_OUT_2_intel_clamp_en), 
    .BSCAN_PIPE_IN_2_intel_bscan_mode(parmisc_physs0_BSCAN_PIPE_OUT_2_intel_bscan_mode), 
    .BSCAN_PIPE_IN_2_select(parmisc_physs0_BSCAN_PIPE_OUT_2_select), 
    .BSCAN_PIPE_IN_2_bscan_clock(parmisc_physs0_BSCAN_PIPE_OUT_2_bscan_clock), 
    .BSCAN_PIPE_IN_2_capture_en(parmisc_physs0_BSCAN_PIPE_OUT_2_capture_en), 
    .BSCAN_PIPE_IN_2_shift_en(parmisc_physs0_BSCAN_PIPE_OUT_2_shift_en), 
    .BSCAN_PIPE_IN_2_update_en(parmisc_physs0_BSCAN_PIPE_OUT_2_update_en), 
    .BSCAN_bypass_brk_xmp_phy0(PHYSS_BSCAN_BYPASS_3), 
    .BSCAN_bypass_brk_xmp_phy1(PHYSS_BSCAN_BYPASS_4), 
    .BSCAN_bypass_brk_xmp_phy2(PHYSS_BSCAN_BYPASS_5), 
    .BSCAN_bypass_brk_xmp_phy3(PHYSS_BSCAN_BYPASS_6), 
    .BSCAN_PIPE_IN_2_intel_d6actestsig_b(parmisc_physs1_BSCAN_PIPE_OUT_2_bscan_to_intel_d6actestsig_b), 
    .SSN_END_0_bus_data_out(parmquad1_SSN_END_0_bus_data_out), 
    .SSN_START_0_bus_data_in(par400g1_SSN_END_0_bus_data_out), 
    .NW_IN_tms(tms), 
    .NW_IN_tck(tck), 
    .NW_IN_tdi(tdi), 
    .NW_IN_trst_b(trst_b), 
    .NW_IN_tdo(parmquad1_NW_IN_tdo), 
    .NW_IN_tdo_en(parmquad1_NW_IN_tdo_en), 
    .NW_IN_ijtag_reset_b(parmisc_physs0_NW_OUT_parmquad1_ijtag_to_reset), 
    .NW_IN_ijtag_capture(parmisc_physs0_NW_OUT_parmquad1_ijtag_to_ce), 
    .NW_IN_ijtag_shift(parmisc_physs0_NW_OUT_parmquad1_ijtag_to_se), 
    .NW_IN_ijtag_update(parmisc_physs0_NW_OUT_parmquad1_ijtag_to_ue), 
    .NW_IN_ijtag_select(parmisc_physs0_NW_OUT_parmquad1_ijtag_to_sel), 
    .NW_IN_ijtag_si(parmisc_physs0_NW_OUT_parmquad1_ijtag_to_si), 
    .NW_IN_ijtag_so(parmquad1_NW_IN_ijtag_so), 
    .NW_IN_shift_ir_dr(shift_ir_dr), 
    .NW_IN_tms_park_value(tms_park_value), 
    .NW_IN_nw_mode(nw_mode), 
    .NW_IN_tap_sel_out(parmquad1_NW_IN_tap_sel_out), 
    .SSN_START_0_bus_clock_in(SSN_START_entry_from_nac_bus_clock_in), 
    .mux_sel_800(), 
    .mac800_0_int(), 
    .tx_stop_4_in(1'b0), 
    .tx_stop_5_in(1'b0), 
    .tx_stop_6_in(1'b0), 
    .tx_stop_7_in(1'b0), 
    .tx_stop_4_out(), 
    .tx_stop_5_out(), 
    .tx_stop_6_out(), 
    .tx_stop_7_out(), 
    .parmquad1_ck_pma0_txdat_dfx_ubp_ctrl_act_out_0(1'b0), 
    .parmquad1_ck_pma1_txdat_dfx_ubp_ctrl_act_out_1(1'b0), 
    .parmquad1_ck_pma2_txdat_dfx_ubp_ctrl_act_out_2(1'b0), 
    .parmquad1_ck_pma3_txdat_dfx_ubp_ctrl_act_out_3(1'b0), 
    .hlp_xlgmii0_txc_nss_1(), 
    .hlp_xlgmii0_txd_nss_1(), 
    .hlp_xlgmii1_txc_nss_1(), 
    .hlp_xlgmii1_txd_nss_1(), 
    .hlp_xlgmii2_txc_nss_1(), 
    .hlp_xlgmii2_txd_nss_1(), 
    .hlp_xlgmii3_txc_nss_1(), 
    .hlp_xlgmii3_txd_nss_1(), 
    .hlp_cgmii0_txd_nss_1(), 
    .hlp_cgmii0_txc_nss_1(), 
    .hlp_cgmii1_txd_nss_1(), 
    .hlp_cgmii1_txc_nss_1(), 
    .hlp_cgmii2_txd_nss_1(), 
    .hlp_cgmii2_txc_nss_1(), 
    .hlp_cgmii3_txd_nss_1(), 
    .hlp_cgmii3_txc_nss_1(), 
    .mdio_in_1(1'b0), 
    .mdio_out_1(), 
    .mdio_oen_1(), 
    .mdc_1(), 
    .nic400_physs_reset_sync(1'b0), 
    .physs_clock_sync_1_func_rstn_func_sync_0(), 
    .physs_registers_wrapper_1_link_traffic_to_nss_enable_O()
) ; 
par400g0 par400g0 (
    .mbp_repeater_odi_parmisc_physs0_3_ubp_out(mbp_repeater_odi_parmisc_physs0_3_ubp_out), 
    .mbp_repeater_odi_par400g0_ubp_out(mbp_repeater_odi_par400g0_ubp_out), 
    .fdfx_powergood(fdfx_powergood), 
    .secure_group_a(dfxsecure_plugin_dpt2_parmisc_physs0_adfx_tap_grpA_enable), 
    .secure_group_b(dfxsecure_plugin_dpt2_parmisc_physs0_adfx_tap_grpB_enable), 
    .secure_group_c(dfxsecure_plugin_dpt2_parmisc_physs0_adfx_tap_grpC_enable), 
    .secure_group_d(dfxsecure_plugin_dpt2_parmisc_physs0_adfx_tap_grpD_enable), 
    .secure_group_e(dfxsecure_plugin_dpt2_parmisc_physs0_adfx_tap_grpE_enable), 
    .secure_group_g(dfxsecure_plugin_dpt2_parmisc_physs0_adfx_tap_grpG_enable), 
    .secure_group_h(dfxsecure_plugin_dpt2_parmisc_physs0_adfx_tap_grpH_enable), 
    .secure_group_f(dfxsecure_plugin_dpt2_parmisc_physs0_adfx_tap_grpF_enable), 
    .secure_group_z(dfxsecure_plugin_dpt2_parmisc_physs0_adfx_tap_grpZ_enable), 
    .physs_mse_800g_en(physs_mse_800g_en), 
    .versa_xmp_0_o_ucss_srds_phy_ready_pma0_l0_a(versa_xmp_0_o_ucss_srds_phy_ready_pma0_l0_a), 
    .versa_xmp_0_o_ucss_srds_phy_ready_pma1_l0_a(versa_xmp_0_o_ucss_srds_phy_ready_pma1_l0_a), 
    .versa_xmp_0_o_ucss_srds_phy_ready_pma2_l0_a(versa_xmp_0_o_ucss_srds_phy_ready_pma2_l0_a), 
    .versa_xmp_0_o_ucss_srds_phy_ready_pma3_l0_a(versa_xmp_0_o_ucss_srds_phy_ready_pma3_l0_a), 
    .physs_registers_wrapper_0_hlp_link_stat_speed_0_hlp_link_stat_0(physs_registers_wrapper_0_hlp_link_stat_speed_0_hlp_link_stat_0), 
    .physs_registers_wrapper_0_hlp_link_stat_speed_1_hlp_link_stat_1(physs_registers_wrapper_0_hlp_link_stat_speed_1_hlp_link_stat_1), 
    .physs_registers_wrapper_0_hlp_link_stat_speed_2_hlp_link_stat_2(physs_registers_wrapper_0_hlp_link_stat_speed_2_hlp_link_stat_2), 
    .physs_registers_wrapper_0_hlp_link_stat_speed_3_hlp_link_stat_3(physs_registers_wrapper_0_hlp_link_stat_speed_3_hlp_link_stat_3), 
    .physs_registers_wrapper_0_link_bypass_en(physs_registers_wrapper_0_link_bypass_en), 
    .physs_registers_wrapper_0_link_bypass_val(physs_registers_wrapper_0_link_bypass_val), 
    .physs_mac_port_glue_0_during_pkt_tx_mse_0(physs_mac_port_glue_0_during_pkt_tx_mse_0), 
    .physs_mac_port_glue_0_during_pkt_rx_mtip_0(physs_mac_port_glue_0_during_pkt_rx_mtip_0), 
    .physs_mac_port_glue_0_rx_eop_vaild_0(physs_mac_port_glue_0_rx_eop_vaild_0), 
    .physs_mac_port_glue_0_tx_eop_vaild_0(physs_mac_port_glue_0_tx_eop_vaild_0), 
    .physs_core_rst_fsm_0_mse_if_iso_en(physs_core_rst_fsm_0_mse_if_iso_en), 
    .physs_core_rst_fsm_0_force_if_mse_rx_en_port_num(physs_core_rst_fsm_0_force_if_mse_rx_en_port_num), 
    .physs_core_rst_fsm_0_force_if_mse_tx_en_port_num(physs_core_rst_fsm_0_force_if_mse_tx_en_port_num), 
    .physs_core_rst_fsm_0_during_pkt_tx_mse_ff_clr(physs_core_rst_fsm_0_during_pkt_tx_mse_ff_clr), 
    .physs_mac_port_glue_0_mse_ff_rx_dval(physs_mac_port_glue_0_mse_ff_rx_dval), 
    .physs_mac_port_glue_0_mtip_ff_tx_rdy(physs_mac_port_glue_0_mtip_ff_tx_rdy), 
    .fifo_top_mux_0_mse_physs_port_0_rx_rdy(fifo_top_mux_0_mse_physs_port_0_rx_rdy), 
    .fifo_top_mux_0_mse_physs_port_0_tx_wren(fifo_top_mux_0_mse_physs_port_0_tx_wren), 
    .fifo_top_mux_0_mse_physs_port_0_tx_sop(fifo_top_mux_0_mse_physs_port_0_tx_sop), 
    .fifo_top_mux_0_mse_physs_port_0_tx_eop(fifo_top_mux_0_mse_physs_port_0_tx_eop), 
    .physs_mac_port_glue_1_mse_ff_rx_dval(physs_mac_port_glue_1_mse_ff_rx_dval), 
    .physs_mac_port_glue_1_mtip_ff_tx_rdy(physs_mac_port_glue_1_mtip_ff_tx_rdy), 
    .fifo_top_mux_0_mse_physs_port_1_rx_rdy(fifo_top_mux_0_mse_physs_port_1_rx_rdy), 
    .fifo_top_mux_0_mse_physs_port_1_tx_wren(fifo_top_mux_0_mse_physs_port_1_tx_wren), 
    .fifo_top_mux_0_mse_physs_port_1_tx_sop(fifo_top_mux_0_mse_physs_port_1_tx_sop), 
    .fifo_top_mux_0_mse_physs_port_1_tx_eop(fifo_top_mux_0_mse_physs_port_1_tx_eop), 
    .physs_mac_port_glue_2_mse_ff_rx_dval(physs_mac_port_glue_2_mse_ff_rx_dval), 
    .physs_mac_port_glue_2_mtip_ff_tx_rdy(physs_mac_port_glue_2_mtip_ff_tx_rdy), 
    .fifo_top_mux_0_mse_physs_port_2_rx_rdy(fifo_top_mux_0_mse_physs_port_2_rx_rdy), 
    .fifo_top_mux_0_mse_physs_port_2_tx_wren(fifo_top_mux_0_mse_physs_port_2_tx_wren), 
    .fifo_top_mux_0_mse_physs_port_2_tx_sop(fifo_top_mux_0_mse_physs_port_2_tx_sop), 
    .fifo_top_mux_0_mse_physs_port_2_tx_eop(fifo_top_mux_0_mse_physs_port_2_tx_eop), 
    .physs_mac_port_glue_3_mse_ff_rx_dval(physs_mac_port_glue_3_mse_ff_rx_dval), 
    .physs_mac_port_glue_3_mtip_ff_tx_rdy(physs_mac_port_glue_3_mtip_ff_tx_rdy), 
    .fifo_top_mux_0_mse_physs_port_3_rx_rdy(fifo_top_mux_0_mse_physs_port_3_rx_rdy), 
    .fifo_top_mux_0_mse_physs_port_3_tx_wren(fifo_top_mux_0_mse_physs_port_3_tx_wren), 
    .fifo_top_mux_0_mse_physs_port_3_tx_sop(fifo_top_mux_0_mse_physs_port_3_tx_sop), 
    .fifo_top_mux_0_mse_physs_port_3_tx_eop(fifo_top_mux_0_mse_physs_port_3_tx_eop), 
    .physs_mac_port_glue_1_during_pkt_tx_mse_0(physs_mac_port_glue_1_during_pkt_tx_mse_0), 
    .physs_mac_port_glue_1_during_pkt_rx_mtip_0(physs_mac_port_glue_1_during_pkt_rx_mtip_0), 
    .physs_mac_port_glue_1_rx_eop_vaild_0(physs_mac_port_glue_1_rx_eop_vaild_0), 
    .physs_mac_port_glue_1_tx_eop_vaild_0(physs_mac_port_glue_1_tx_eop_vaild_0), 
    .physs_core_rst_fsm_0_force_if_mse_rx_en_port_num_0(physs_core_rst_fsm_0_force_if_mse_rx_en_port_num_0), 
    .physs_core_rst_fsm_0_force_if_mse_tx_en_port_num_0(physs_core_rst_fsm_0_force_if_mse_tx_en_port_num_0), 
    .physs_mac_port_glue_2_during_pkt_tx_mse_0(physs_mac_port_glue_2_during_pkt_tx_mse_0), 
    .physs_mac_port_glue_2_during_pkt_rx_mtip_0(physs_mac_port_glue_2_during_pkt_rx_mtip_0), 
    .physs_mac_port_glue_2_rx_eop_vaild_0(physs_mac_port_glue_2_rx_eop_vaild_0), 
    .physs_mac_port_glue_2_tx_eop_vaild_0(physs_mac_port_glue_2_tx_eop_vaild_0), 
    .physs_core_rst_fsm_0_force_if_mse_rx_en_port_num_1(physs_core_rst_fsm_0_force_if_mse_rx_en_port_num_1), 
    .physs_core_rst_fsm_0_force_if_mse_tx_en_port_num_1(physs_core_rst_fsm_0_force_if_mse_tx_en_port_num_1), 
    .physs_mac_port_glue_3_during_pkt_tx_mse_0(physs_mac_port_glue_3_during_pkt_tx_mse_0), 
    .physs_mac_port_glue_3_during_pkt_rx_mtip_0(physs_mac_port_glue_3_during_pkt_rx_mtip_0), 
    .physs_mac_port_glue_3_rx_eop_vaild_0(physs_mac_port_glue_3_rx_eop_vaild_0), 
    .physs_mac_port_glue_3_tx_eop_vaild_0(physs_mac_port_glue_3_tx_eop_vaild_0), 
    .physs_core_rst_fsm_0_force_if_mse_rx_en_port_num_2(physs_core_rst_fsm_0_force_if_mse_rx_en_port_num_2), 
    .physs_core_rst_fsm_0_force_if_mse_tx_en_port_num_2(physs_core_rst_fsm_0_force_if_mse_tx_en_port_num_2), 
    .physs_registers_wrapper_0_mac200_config_0_xoff_gen(physs_registers_wrapper_0_mac200_config_0_xoff_gen), 
    .physs_registers_wrapper_0_mac200_config_0_tx_loc_fault(physs_registers_wrapper_0_mac200_config_0_tx_loc_fault), 
    .physs_registers_wrapper_0_mac200_config_0_tx_rem_fault(physs_registers_wrapper_0_mac200_config_0_tx_rem_fault), 
    .physs_registers_wrapper_0_mac200_config_0_tx_li_fault(physs_registers_wrapper_0_mac200_config_0_tx_li_fault), 
    .physs_registers_wrapper_0_mac200_config_0_tx_smhold(physs_registers_wrapper_0_mac200_config_0_tx_smhold), 
    .physs_registers_wrapper_0_mac400_config_0_xoff_gen(physs_registers_wrapper_0_mac400_config_0_xoff_gen), 
    .physs_registers_wrapper_0_mac400_config_0_tx_loc_fault(physs_registers_wrapper_0_mac400_config_0_tx_loc_fault), 
    .physs_registers_wrapper_0_mac400_config_0_tx_rem_fault(physs_registers_wrapper_0_mac400_config_0_tx_rem_fault), 
    .physs_registers_wrapper_0_mac400_config_0_tx_li_fault(physs_registers_wrapper_0_mac400_config_0_tx_li_fault), 
    .physs_registers_wrapper_0_mac400_config_0_tx_smhold(physs_registers_wrapper_0_mac400_config_0_tx_smhold), 
    .physs_bbl_200G_0_disable(physs_bbl_200G_0_disable), 
    .physs_bbl_400G_0_disable(physs_bbl_400G_0_disable), 
    .soc_per_clk_adop_parmisc_physs0_clkout(soc_per_clk_adop_parmisc_physs0_clkout_0), 
    .physs_func_clk_adop_parmisc_physs0_clkout(physs_func_clk_adop_parmisc_physs0_clkout_0), 
    .cosq_func_clk0_adop_parmisc_physs0_clkout(cosq_func_clk0_adop_parmisc_physs0_clkout_0), 
    .physs_pcs_mux_0_sd0_tx_clk_200G(physs_pcs_mux_0_sd0_tx_clk_200G), 
    .physs_pcs_mux_0_sd4_tx_clk_200G(physs_pcs_mux_0_sd4_tx_clk_200G), 
    .physs_pcs_mux_0_sd8_tx_clk_200G(physs_pcs_mux_0_sd8_tx_clk_200G), 
    .physs_pcs_mux_0_sd12_tx_clk_200G(physs_pcs_mux_0_sd12_tx_clk_200G), 
    .physs_pcs_mux_0_sd0_tx_clk_400G(physs_pcs_mux_0_sd0_tx_clk_400G), 
    .physs_pcs_mux_0_sd4_tx_clk_400G(physs_pcs_mux_0_sd4_tx_clk_400G), 
    .physs_pcs_mux_0_sd8_tx_clk_400G(physs_pcs_mux_0_sd8_tx_clk_400G), 
    .physs_pcs_mux_0_sd12_tx_clk_400G(physs_pcs_mux_0_sd12_tx_clk_400G), 
    .physs_pcs_mux_0_sd0_rx_clk_400G(physs_pcs_mux_0_sd0_rx_clk_400G), 
    .physs_pcs_mux_0_sd4_rx_clk_400G(physs_pcs_mux_0_sd4_rx_clk_400G), 
    .physs_pcs_mux_0_sd8_rx_clk_400G(physs_pcs_mux_0_sd8_rx_clk_400G), 
    .physs_pcs_mux_0_sd12_rx_clk_400G(physs_pcs_mux_0_sd12_rx_clk_400G), 
    .physs_pcs_mux_0_sd0_rx_clk_200G(physs_pcs_mux_0_sd0_rx_clk_200G), 
    .physs_pcs_mux_0_sd4_rx_clk_200G(physs_pcs_mux_0_sd4_rx_clk_200G), 
    .physs_pcs_mux_0_sd8_rx_clk_200G(physs_pcs_mux_0_sd8_rx_clk_200G), 
    .physs_pcs_mux_0_sd12_rx_clk_200G(physs_pcs_mux_0_sd12_rx_clk_200G), 
    .physs_intf0_clk_adop_parmisc_physs0_clkout(physs_intf0_clk_adop_parmisc_physs0_clkout), 
    .ethphyss_post_clkungate(ethphyss_post_clkungate), 
    .nic400_quad_0_hselx_mac400_stats_0(nic400_quad_0_hselx_mac400_stats_0), 
    .nic400_quad_0_haddr_mac400_stats_0_out(nic400_quad_0_haddr_mac400_stats_0_out), 
    .nic400_quad_0_htrans_mac400_stats_0(nic400_quad_0_htrans_mac400_stats_0), 
    .nic400_quad_0_hwrite_mac400_stats_0(nic400_quad_0_hwrite_mac400_stats_0), 
    .nic400_quad_0_hsize_mac400_stats_0(nic400_quad_0_hsize_mac400_stats_0), 
    .nic400_quad_0_hwdata_mac400_stats_0(nic400_quad_0_hwdata_mac400_stats_0), 
    .nic400_quad_0_hready_mac400_stats_0(nic400_quad_0_hready_mac400_stats_0), 
    .nic400_quad_0_hburst_mac400_stats_0(nic400_quad_0_hburst_mac400_stats_0), 
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
    .nic400_quad_0_hburst_mac400_stats_1(nic400_quad_0_hburst_mac400_stats_1), 
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
    .nic400_quad_0_hburst_mac400_0(nic400_quad_0_hburst_mac400_0), 
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
    .nic400_quad_0_hburst_mac400_1(nic400_quad_0_hburst_mac400_1), 
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
    .nic400_quad_0_hburst_pcs400_0(nic400_quad_0_hburst_pcs400_0), 
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
    .nic400_quad_0_hburst_rsfec400_0(nic400_quad_0_hburst_rsfec400_0), 
    .pcs200_ahb_bridge_1_hrdata(pcs200_ahb_bridge_1_hrdata), 
    .pcs200_ahb_bridge_1_hresp(pcs200_ahb_bridge_1_hresp), 
    .pcs200_ahb_bridge_1_hreadyout(pcs200_ahb_bridge_1_hreadyout), 
    .nic400_quad_0_hselx_rsfecstats400_1(nic400_quad_0_hselx_rsfecstats400_1), 
    .nic400_quad_0_haddr_rsfecstats400_1_out(nic400_quad_0_haddr_rsfecstats400_1_out), 
    .nic400_quad_0_htrans_rsfecstats400_1(nic400_quad_0_htrans_rsfecstats400_1), 
    .nic400_quad_0_hwrite_rsfecstats400_1(nic400_quad_0_hwrite_rsfecstats400_1), 
    .nic400_quad_0_hsize_rsfecstats400_1(nic400_quad_0_hsize_rsfecstats400_1), 
    .nic400_quad_0_hwdata_rsfecstats400_1(nic400_quad_0_hwdata_rsfecstats400_1), 
    .nic400_quad_0_hready_rsfecstats400_1(nic400_quad_0_hready_rsfecstats400_1), 
    .nic400_quad_0_hburst_rsfecstats400_1(nic400_quad_0_hburst_rsfecstats400_1), 
    .pcs200_ahb_bridge_4_hrdata(pcs200_ahb_bridge_4_hrdata), 
    .pcs200_ahb_bridge_4_hresp(pcs200_ahb_bridge_4_hresp), 
    .pcs200_ahb_bridge_4_hreadyout(pcs200_ahb_bridge_4_hreadyout), 
    .nic400_quad_0_hselx_pcs400_1(nic400_quad_0_hselx_pcs400_1), 
    .nic400_quad_0_haddr_pcs400_1_out(nic400_quad_0_haddr_pcs400_1_out), 
    .nic400_quad_0_htrans_pcs400_1(nic400_quad_0_htrans_pcs400_1), 
    .nic400_quad_0_hwrite_pcs400_1(nic400_quad_0_hwrite_pcs400_1), 
    .nic400_quad_0_hsize_pcs400_1(nic400_quad_0_hsize_pcs400_1), 
    .nic400_quad_0_hwdata_pcs400_1(nic400_quad_0_hwdata_pcs400_1), 
    .nic400_quad_0_hready_pcs400_1(nic400_quad_0_hready_pcs400_1), 
    .nic400_quad_0_hburst_pcs400_1(nic400_quad_0_hburst_pcs400_1), 
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
    .nic400_quad_0_hburst_rsfec400_1(nic400_quad_0_hburst_rsfec400_1), 
    .pcs400_ahb_bridge_1_hrdata(pcs400_ahb_bridge_1_hrdata), 
    .pcs400_ahb_bridge_1_hresp(pcs400_ahb_bridge_1_hresp), 
    .pcs400_ahb_bridge_1_hreadyout(pcs400_ahb_bridge_1_hreadyout), 
    .nic400_quad_0_hselx_rsfecstats400_0(nic400_quad_0_hselx_rsfecstats400_0), 
    .nic400_quad_0_haddr_rsfecstats400_0_out(nic400_quad_0_haddr_rsfecstats400_0_out), 
    .nic400_quad_0_htrans_rsfecstats400_0(nic400_quad_0_htrans_rsfecstats400_0), 
    .nic400_quad_0_hwrite_rsfecstats400_0(nic400_quad_0_hwrite_rsfecstats400_0), 
    .nic400_quad_0_hsize_rsfecstats400_0(nic400_quad_0_hsize_rsfecstats400_0), 
    .nic400_quad_0_hwdata_rsfecstats400_0(nic400_quad_0_hwdata_rsfecstats400_0), 
    .nic400_quad_0_hready_rsfecstats400_0(nic400_quad_0_hready_rsfecstats400_0), 
    .nic400_quad_0_hburst_rsfecstats400_0(nic400_quad_0_hburst_rsfecstats400_0), 
    .pcs400_ahb_bridge_4_hrdata(pcs400_ahb_bridge_4_hrdata), 
    .pcs400_ahb_bridge_4_hresp(pcs400_ahb_bridge_4_hresp), 
    .pcs400_ahb_bridge_4_hreadyout(pcs400_ahb_bridge_4_hreadyout), 
    .nic400_quad_0_hselx_tsu_400_0(nic400_quad_0_hselx_tsu_400_0), 
    .nic400_quad_0_haddr_tsu_400_0_out(nic400_quad_0_haddr_tsu_400_0_out), 
    .nic400_quad_0_htrans_tsu_400_0(nic400_quad_0_htrans_tsu_400_0), 
    .nic400_quad_0_hwrite_tsu_400_0(nic400_quad_0_hwrite_tsu_400_0), 
    .nic400_quad_0_hsize_tsu_400_0(nic400_quad_0_hsize_tsu_400_0), 
    .nic400_quad_0_hwdata_tsu_400_0(nic400_quad_0_hwdata_tsu_400_0), 
    .nic400_quad_0_hready_tsu_400_0(nic400_quad_0_hready_tsu_400_0), 
    .nic400_quad_0_hburst_tsu_400_0(nic400_quad_0_hburst_tsu_400_0), 
    .tsu400_ahb_bridge_0_hrdata(tsu400_ahb_bridge_0_hrdata), 
    .tsu400_ahb_bridge_0_hresp(tsu400_ahb_bridge_0_hresp), 
    .tsu400_ahb_bridge_0_hreadyout(tsu400_ahb_bridge_0_hreadyout), 
    .nic400_quad_0_hselx_tsu_400_1(nic400_quad_0_hselx_tsu_400_1), 
    .nic400_quad_0_haddr_tsu_400_1_out(nic400_quad_0_haddr_tsu_400_1_out), 
    .nic400_quad_0_htrans_tsu_400_1(nic400_quad_0_htrans_tsu_400_1), 
    .nic400_quad_0_hwrite_tsu_400_1(nic400_quad_0_hwrite_tsu_400_1), 
    .nic400_quad_0_hsize_tsu_400_1(nic400_quad_0_hsize_tsu_400_1), 
    .nic400_quad_0_hwdata_tsu_400_1(nic400_quad_0_hwdata_tsu_400_1), 
    .nic400_quad_0_hready_tsu_400_1(nic400_quad_0_hready_tsu_400_1), 
    .nic400_quad_0_hburst_tsu_400_1(nic400_quad_0_hburst_tsu_400_1), 
    .tsu200_ahb_bridge_0_hrdata(tsu200_ahb_bridge_0_hrdata), 
    .tsu200_ahb_bridge_0_hresp(tsu200_ahb_bridge_0_hresp), 
    .tsu200_ahb_bridge_0_hreadyout(tsu200_ahb_bridge_0_hreadyout), 
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
    .mac200_0_mdio_oen(mac200_0_mdio_oen), 
    .mac400_0_mdio_oen(mac400_0_mdio_oen), 
    .mac200_0_pfc_mode(mac200_0_pfc_mode), 
    .mac400_0_pfc_mode(mac400_0_pfc_mode), 
    .mac200_0_ff_rx_dsav(mac200_0_ff_rx_dsav), 
    .mac400_0_ff_rx_dsav(mac400_0_ff_rx_dsav), 
    .mac200_0_ff_tx_credit(mac200_0_ff_tx_credit), 
    .mac400_0_ff_tx_credit(mac400_0_ff_tx_credit), 
    .mac200_0_inv_loop_ind(mac200_0_inv_loop_ind), 
    .mac400_0_inv_loop_ind(mac400_0_inv_loop_ind), 
    .mac200_0_frm_drop(mac200_0_frm_drop), 
    .mac400_0_frm_drop(mac400_0_frm_drop), 
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
    .physs_registers_wrapper_0_pcs_mode_config_pcs_mode_sel_0(physs_registers_wrapper_0_pcs_mode_config_pcs_mode_sel_0), 
    .physs_registers_wrapper_0_pcs_mode_config_fifo_mode_sel(physs_registers_wrapper_0_pcs_mode_config_fifo_mode_sel), 
    .physs_bbl_spare_0(physs_bbl_spare_0), 
    .pd_vinf_0_bisr_si(parmisc_physs0_pd_vinf_0_bisr_so), 
    .pd_vinf_0_bisr_so(par400g0_pd_vinf_0_bisr_so), 
    .pd_vinf_0_2_bisr_si(parmquad0_pd_vinf_0_bisr_so), 
    .pd_vinf_0_2_bisr_so(par400g0_pd_vinf_0_2_bisr_so), 
    .pd_vinf_0_bisr_reset(pd_vinf_0_bisr_reset), 
    .pd_vinf_0_bisr_shift_en(pd_vinf_0_bisr_shift_en), 
    .pd_vinf_0_bisr_clk(pd_vinf_0_bisr_clk), 
    .pd_vinf_2_bisr_clk(pd_vinf_2_bisr_clk), 
    .pd_vinf_2_bisr_reset(pd_vinf_2_bisr_reset), 
    .pd_vinf_2_bisr_shift_en(pd_vinf_2_bisr_shift_en), 
    .pd_vinf_2_bisr_si(parmisc_physs0_pd_vinf_2_bisr_so), 
    .pd_vinf_2_bisr_so(par400g0_pd_vinf_2_bisr_so), 
    .DIAG_AGGR_par400g0_mbist_diag_done(par400g0_DIAG_AGGR_par400g0_mbist_diag_done), 
    .physs0_func_rst_raw_n(physs0_func_rst_raw_n), 
    .versa_xmp_0_o_ucss_srds_pcs_tx_reset_pma0_l0_a(versa_xmp_0_o_ucss_srds_pcs_tx_reset_pma0_l0_a), 
    .versa_xmp_0_o_ucss_srds_pcs_rx_reset_pma0_l0_a(versa_xmp_0_o_ucss_srds_pcs_rx_reset_pma0_l0_a), 
    .versa_xmp_0_o_ucss_srds_pcs_tx_reset_pma2_l0_a(versa_xmp_0_o_ucss_srds_pcs_tx_reset_pma2_l0_a), 
    .versa_xmp_0_o_ucss_srds_pcs_rx_reset_pma2_l0_a(versa_xmp_0_o_ucss_srds_pcs_rx_reset_pma2_l0_a), 
    .physs_registers_wrapper_0_reset_cdmii_rxclk_override_200G(physs_registers_wrapper_0_reset_cdmii_rxclk_override_200G), 
    .physs_registers_wrapper_0_reset_cdmii_txclk_override_200G(physs_registers_wrapper_0_reset_cdmii_txclk_override_200G), 
    .physs_registers_wrapper_0_reset_sd_tx_clk_override_200G(physs_registers_wrapper_0_reset_sd_tx_clk_override_200G), 
    .physs_registers_wrapper_0_reset_sd_rx_clk_override_200G(physs_registers_wrapper_0_reset_sd_rx_clk_override_200G), 
    .physs_registers_wrapper_0_reset_reg_clk_override_200G(physs_registers_wrapper_0_reset_reg_clk_override_200G), 
    .physs_registers_wrapper_0_reset_reg_ref_clk_override_200G(physs_registers_wrapper_0_reset_reg_ref_clk_override_200G), 
    .physs_registers_wrapper_0_reset_cdmii_rxclk_override_400G(physs_registers_wrapper_0_reset_cdmii_rxclk_override_400G), 
    .physs_registers_wrapper_0_reset_cdmii_txclk_override_400G(physs_registers_wrapper_0_reset_cdmii_txclk_override_400G), 
    .physs_registers_wrapper_0_reset_sd_tx_clk_override_400G(physs_registers_wrapper_0_reset_sd_tx_clk_override_400G), 
    .physs_registers_wrapper_0_reset_sd_rx_clk_override_400G(physs_registers_wrapper_0_reset_sd_rx_clk_override_400G), 
    .physs_registers_wrapper_0_reset_reg_clk_override_400G(physs_registers_wrapper_0_reset_reg_clk_override_400G), 
    .physs_registers_wrapper_0_reset_reg_ref_clk_override_400G(physs_registers_wrapper_0_reset_reg_ref_clk_override_400G), 
    .physs_registers_wrapper_0_clk_gate_en_200G_mac_pcs_0(physs_registers_wrapper_0_clk_gate_en_200G_mac_pcs_0), 
    .physs_registers_wrapper_0_clk_gate_en_400G_mac_pcs_0(physs_registers_wrapper_0_clk_gate_en_400G_mac_pcs_0), 
    .physs_registers_wrapper_0_reset_pcs200_override_en(physs_registers_wrapper_0_reset_pcs200_override_en), 
    .physs_registers_wrapper_0_reset_pcs400_override_en(physs_registers_wrapper_0_reset_pcs400_override_en), 
    .physs_registers_wrapper_0_reset_mac200_override_en(physs_registers_wrapper_0_reset_mac200_override_en), 
    .physs_registers_wrapper_0_reset_mac400_override_en(physs_registers_wrapper_0_reset_mac400_override_en), 
    .physs_registers_wrapper_0_reset_reg_clk_override_mac_0(physs_registers_wrapper_0_reset_reg_clk_override_mac_0), 
    .physs_registers_wrapper_0_reset_ff_tx_clk_override_0(physs_registers_wrapper_0_reset_ff_tx_clk_override_0), 
    .physs_registers_wrapper_0_reset_ff_rx_clk_override_0(physs_registers_wrapper_0_reset_ff_rx_clk_override_0), 
    .physs_registers_wrapper_0_reset_txclk_override_0(physs_registers_wrapper_0_reset_txclk_override_0), 
    .physs_registers_wrapper_0_reset_rxclk_override_0(physs_registers_wrapper_0_reset_rxclk_override_0), 
    .physs_registers_wrapper_0_pcs_mode_config_pcs_external_loopback_en_lane_0(physs_registers_wrapper_0_pcs_mode_config_pcs_external_loopback_en_lane_0), 
    .physs_hd2prf_trim_fuse_in(physs_hd2prf_trim_fuse_in), 
    .ethphyss_post_clk_mux_ctrl(ethphyss_post_clk_mux_ctrl), 
    .fary_7_post_force_fail(fary_7_post_force_fail), 
    .fary_7_trigger_post(fary_7_trigger_post), 
    .fary_7_post_algo_select(fary_7_post_algo_select), 
    .macpcs400_7_post_pass_tdr(par400g0_macpcs400_7_post_pass_tdr), 
    .macpcs400_7_post_complete_tdr(par400g0_macpcs400_7_post_complete_tdr), 
    .fary_8_post_force_fail(fary_8_post_force_fail), 
    .fary_8_trigger_post(fary_8_trigger_post), 
    .fary_8_post_algo_select(fary_8_post_algo_select), 
    .macpcs200_8_post_pass_tdr(par400g0_macpcs200_8_post_pass_tdr), 
    .macpcs200_8_post_complete_tdr(par400g0_macpcs200_8_post_complete_tdr), 
    .macpcs200_8_post_busy_tdr(par400g0_macpcs200_8_post_busy_tdr), 
    .macpcs400_7_post_busy_tdr(par400g0_macpcs400_7_post_busy_tdr), 
    .parmquad0_pcs_lane_sel_val_par400g0_rtdr(parmquad0_pcs_lane_sel_val_par400g0_rtdr), 
    .parmquad0_pcs_lane_sel_ovr_par400g0_rtdr(parmquad0_pcs_lane_sel_ovr_par400g0_rtdr), 
    .physs_timestamp_0_timer_refpcs_0(physs_timestamp_0_timer_refpcs_0), 
    .physs_timestamp_0_timer_refpcs_1(physs_timestamp_0_timer_refpcs_1), 
    .physs_timestamp_0_timer_refpcs_2(physs_timestamp_0_timer_refpcs_2), 
    .physs_timestamp_0_timer_refpcs_3(physs_timestamp_0_timer_refpcs_3), 
    .mac100_0_ff_rx_err_stat_0(mac100_0_ff_rx_err_stat_0), 
    .mac100_1_ff_rx_err_stat_0(mac100_1_ff_rx_err_stat_0), 
    .mac100_2_ff_rx_err_stat_0(mac100_2_ff_rx_err_stat_0), 
    .mac100_3_ff_rx_err_stat_0(mac100_3_ff_rx_err_stat_0), 
    .physs_pcs_mux_200_400_0_tx_ts_val(physs_pcs_mux_200_400_0_tx_ts_val), 
    .physs_pcs_mux_200_400_0_tx_ts_id_0(physs_pcs_mux_200_400_0_tx_ts_id_0), 
    .physs_pcs_mux_200_400_0_tx_ts_id_1(physs_pcs_mux_200_400_0_tx_ts_id_1), 
    .physs_pcs_mux_200_400_0_tx_ts_id_2(physs_pcs_mux_200_400_0_tx_ts_id_2), 
    .physs_pcs_mux_200_400_0_tx_ts_id_3(physs_pcs_mux_200_400_0_tx_ts_id_3), 
    .physs_pcs_mux_200_400_0_tx_ts_0(physs_pcs_mux_200_400_0_tx_ts_0), 
    .physs_pcs_mux_200_400_0_tx_ts_1(physs_pcs_mux_200_400_0_tx_ts_1), 
    .physs_pcs_mux_200_400_0_tx_ts_2(physs_pcs_mux_200_400_0_tx_ts_2), 
    .physs_pcs_mux_200_400_0_tx_ts_3(physs_pcs_mux_200_400_0_tx_ts_3), 
    .fifo_mux_0_mac100g_0_tx_ts_frm(fifo_mux_0_mac100g_0_tx_ts_frm), 
    .fifo_mux_0_mac100g_0_tx_id(fifo_mux_0_mac100g_0_tx_id), 
    .fifo_mux_0_mac100g_1_tx_ts_frm(fifo_mux_0_mac100g_1_tx_ts_frm), 
    .fifo_mux_0_mac100g_1_tx_id(fifo_mux_0_mac100g_1_tx_id), 
    .fifo_mux_0_mac100g_2_tx_ts_frm(fifo_mux_0_mac100g_2_tx_ts_frm), 
    .fifo_mux_0_mac100g_2_tx_id(fifo_mux_0_mac100g_2_tx_id), 
    .fifo_mux_0_mac100g_3_tx_ts_frm(fifo_mux_0_mac100g_3_tx_ts_frm), 
    .fifo_mux_0_mac100g_3_tx_id(fifo_mux_0_mac100g_3_tx_id), 
    .physs_pcs_mux_200_400_0_sd0_tx_data_o(physs_pcs_mux_200_400_0_sd0_tx_data_o), 
    .physs_pcs_mux_200_400_0_sd1_tx_data_o(physs_pcs_mux_200_400_0_sd1_tx_data_o), 
    .physs_pcs_mux_200_400_0_sd2_tx_data_o(physs_pcs_mux_200_400_0_sd2_tx_data_o), 
    .physs_pcs_mux_200_400_0_sd3_tx_data_o(physs_pcs_mux_200_400_0_sd3_tx_data_o), 
    .physs_pipeline_reg_4_data_out(physs_pipeline_reg_4_data_out), 
    .physs_pipeline_reg_5_data_out(physs_pipeline_reg_5_data_out), 
    .physs_pipeline_reg_6_data_out(physs_pipeline_reg_6_data_out), 
    .physs_pipeline_reg_7_data_out(physs_pipeline_reg_7_data_out), 
    .physs_lane_reversal_mux_0_oflux_srds_rdy_out(physs_lane_reversal_mux_0_oflux_srds_rdy_out), 
    .physs_pcs_mux_200_400_0_link_status_out(physs_pcs_mux_200_400_0_link_status_out), 
    .fifo_mux_0_physs_icq_port_0_link_stat_0(fifo_mux_0_physs_icq_port_0_link_stat_0), 
    .fifo_mux_0_physs_mse_port_0_link_speed(fifo_mux_0_physs_mse_port_0_link_speed), 
    .fifo_mux_0_physs_mse_port_0_rx_data(fifo_mux_0_physs_mse_port_0_rx_data), 
    .fifo_mux_0_physs_mse_port_0_rx_sop_0(fifo_mux_0_physs_mse_port_0_rx_sop_0), 
    .fifo_mux_0_physs_mse_port_0_rx_eop_0(fifo_mux_0_physs_mse_port_0_rx_eop_0), 
    .fifo_mux_0_physs_mse_port_0_rx_mod(fifo_mux_0_physs_mse_port_0_rx_mod), 
    .fifo_mux_0_physs_mse_port_0_rx_err(fifo_mux_0_physs_mse_port_0_rx_err), 
    .fifo_mux_0_physs_mse_port_0_rx_ecc_err(fifo_mux_0_physs_mse_port_0_rx_ecc_err), 
    .fifo_mux_0_physs_mse_port_0_rx_ts(fifo_mux_0_physs_mse_port_0_rx_ts), 
    .fifo_top_mux_0_mse_physs_port_0_tx_data(fifo_top_mux_0_mse_physs_port_0_tx_data), 
    .fifo_top_mux_0_mse_physs_port_0_ts_capture_vld(fifo_top_mux_0_mse_physs_port_0_ts_capture_vld), 
    .fifo_top_mux_0_mse_physs_port_0_ts_capture_idx(fifo_top_mux_0_mse_physs_port_0_ts_capture_idx), 
    .fifo_top_mux_0_mse_physs_port_0_tx_mod(fifo_top_mux_0_mse_physs_port_0_tx_mod), 
    .fifo_top_mux_0_mse_physs_port_0_tx_err(fifo_top_mux_0_mse_physs_port_0_tx_err), 
    .fifo_top_mux_0_mse_physs_port_0_tx_crc(fifo_top_mux_0_mse_physs_port_0_tx_crc), 
    .fifo_mux_0_physs_mse_port_0_pfc_mode(fifo_mux_0_physs_mse_port_0_pfc_mode), 
    .fifo_mux_0_physs_icq_port_1_link_stat_0(fifo_mux_0_physs_icq_port_1_link_stat_0), 
    .fifo_mux_0_physs_mse_port_1_link_speed(fifo_mux_0_physs_mse_port_1_link_speed), 
    .fifo_mux_0_physs_mse_port_1_rx_data(fifo_mux_0_physs_mse_port_1_rx_data), 
    .fifo_mux_0_physs_mse_port_1_rx_sop_0(fifo_mux_0_physs_mse_port_1_rx_sop_0), 
    .fifo_mux_0_physs_mse_port_1_rx_eop_0(fifo_mux_0_physs_mse_port_1_rx_eop_0), 
    .fifo_mux_0_physs_mse_port_1_rx_mod(fifo_mux_0_physs_mse_port_1_rx_mod), 
    .fifo_mux_0_physs_mse_port_1_rx_err(fifo_mux_0_physs_mse_port_1_rx_err), 
    .fifo_mux_0_physs_mse_port_1_rx_ecc_err(fifo_mux_0_physs_mse_port_1_rx_ecc_err), 
    .fifo_mux_0_physs_mse_port_1_rx_ts(fifo_mux_0_physs_mse_port_1_rx_ts), 
    .fifo_top_mux_0_mse_physs_port_1_tx_data(fifo_top_mux_0_mse_physs_port_1_tx_data), 
    .fifo_top_mux_0_mse_physs_port_1_ts_capture_vld(fifo_top_mux_0_mse_physs_port_1_ts_capture_vld), 
    .fifo_top_mux_0_mse_physs_port_1_ts_capture_idx(fifo_top_mux_0_mse_physs_port_1_ts_capture_idx), 
    .fifo_top_mux_0_mse_physs_port_1_tx_mod(fifo_top_mux_0_mse_physs_port_1_tx_mod), 
    .fifo_top_mux_0_mse_physs_port_1_tx_err(fifo_top_mux_0_mse_physs_port_1_tx_err), 
    .fifo_top_mux_0_mse_physs_port_1_tx_crc(fifo_top_mux_0_mse_physs_port_1_tx_crc), 
    .fifo_mux_0_physs_mse_port_1_pfc_mode(fifo_mux_0_physs_mse_port_1_pfc_mode), 
    .fifo_mux_0_physs_icq_port_2_link_stat_0(fifo_mux_0_physs_icq_port_2_link_stat_0), 
    .fifo_mux_0_physs_mse_port_2_link_speed(fifo_mux_0_physs_mse_port_2_link_speed), 
    .fifo_mux_0_physs_mse_port_2_rx_data(fifo_mux_0_physs_mse_port_2_rx_data), 
    .fifo_mux_0_physs_mse_port_2_rx_sop_0(fifo_mux_0_physs_mse_port_2_rx_sop_0), 
    .fifo_mux_0_physs_mse_port_2_rx_eop_0(fifo_mux_0_physs_mse_port_2_rx_eop_0), 
    .fifo_mux_0_physs_mse_port_2_rx_mod(fifo_mux_0_physs_mse_port_2_rx_mod), 
    .fifo_mux_0_physs_mse_port_2_rx_err(fifo_mux_0_physs_mse_port_2_rx_err), 
    .fifo_mux_0_physs_mse_port_2_rx_ecc_err(fifo_mux_0_physs_mse_port_2_rx_ecc_err), 
    .fifo_mux_0_physs_mse_port_2_rx_ts(fifo_mux_0_physs_mse_port_2_rx_ts), 
    .fifo_top_mux_0_mse_physs_port_2_tx_data(fifo_top_mux_0_mse_physs_port_2_tx_data), 
    .fifo_top_mux_0_mse_physs_port_2_ts_capture_vld(fifo_top_mux_0_mse_physs_port_2_ts_capture_vld), 
    .fifo_top_mux_0_mse_physs_port_2_ts_capture_idx(fifo_top_mux_0_mse_physs_port_2_ts_capture_idx), 
    .fifo_top_mux_0_mse_physs_port_2_tx_mod(fifo_top_mux_0_mse_physs_port_2_tx_mod), 
    .fifo_top_mux_0_mse_physs_port_2_tx_err(fifo_top_mux_0_mse_physs_port_2_tx_err), 
    .fifo_top_mux_0_mse_physs_port_2_tx_crc(fifo_top_mux_0_mse_physs_port_2_tx_crc), 
    .fifo_mux_0_physs_mse_port_2_pfc_mode(fifo_mux_0_physs_mse_port_2_pfc_mode), 
    .fifo_mux_0_physs_icq_port_3_link_stat_0(fifo_mux_0_physs_icq_port_3_link_stat_0), 
    .fifo_mux_0_physs_mse_port_3_link_speed(fifo_mux_0_physs_mse_port_3_link_speed), 
    .fifo_mux_0_physs_mse_port_3_rx_data(fifo_mux_0_physs_mse_port_3_rx_data), 
    .fifo_mux_0_physs_mse_port_3_rx_sop_0(fifo_mux_0_physs_mse_port_3_rx_sop_0), 
    .fifo_mux_0_physs_mse_port_3_rx_eop_0(fifo_mux_0_physs_mse_port_3_rx_eop_0), 
    .fifo_mux_0_physs_mse_port_3_rx_mod(fifo_mux_0_physs_mse_port_3_rx_mod), 
    .fifo_mux_0_physs_mse_port_3_rx_err(fifo_mux_0_physs_mse_port_3_rx_err), 
    .fifo_mux_0_physs_mse_port_3_rx_ecc_err(fifo_mux_0_physs_mse_port_3_rx_ecc_err), 
    .fifo_mux_0_physs_mse_port_3_rx_ts(fifo_mux_0_physs_mse_port_3_rx_ts), 
    .fifo_top_mux_0_mse_physs_port_3_tx_data(fifo_top_mux_0_mse_physs_port_3_tx_data), 
    .fifo_top_mux_0_mse_physs_port_3_ts_capture_vld(fifo_top_mux_0_mse_physs_port_3_ts_capture_vld), 
    .fifo_top_mux_0_mse_physs_port_3_ts_capture_idx(fifo_top_mux_0_mse_physs_port_3_ts_capture_idx), 
    .fifo_top_mux_0_mse_physs_port_3_tx_mod(fifo_top_mux_0_mse_physs_port_3_tx_mod), 
    .fifo_top_mux_0_mse_physs_port_3_tx_err(fifo_top_mux_0_mse_physs_port_3_tx_err), 
    .fifo_top_mux_0_mse_physs_port_3_tx_crc(fifo_top_mux_0_mse_physs_port_3_tx_crc), 
    .fifo_mux_0_physs_mse_port_3_pfc_mode(fifo_mux_0_physs_mse_port_3_pfc_mode), 
    .physs_link_speed_decoder_0_link_speed_out(physs_link_speed_decoder_0_link_speed_out), 
    .physs_link_speed_decoder_1_link_speed_out(physs_link_speed_decoder_1_link_speed_out), 
    .physs_link_speed_decoder_2_link_speed_out(physs_link_speed_decoder_2_link_speed_out), 
    .physs_link_speed_decoder_3_link_speed_out(physs_link_speed_decoder_3_link_speed_out), 
    .mac100_0_ff_rx_dval_0(mac100_0_ff_rx_dval_0), 
    .mac100_0_ff_rx_data(mac100_0_ff_rx_data), 
    .mac100_0_ff_rx_sop(mac100_0_ff_rx_sop), 
    .mac100_0_ff_rx_eop_0(mac100_0_ff_rx_eop_0), 
    .mac100_0_ff_rx_mod_0(mac100_0_ff_rx_mod_0), 
    .mac100_0_ff_rx_err_0(mac100_0_ff_rx_err_0), 
    .fifo_mux_0_mac100g_0_rx_rdy(fifo_mux_0_mac100g_0_rx_rdy), 
    .mac100_0_ff_rx_ts_0(mac100_0_ff_rx_ts_0), 
    .mac100_0_ff_rx_ts_1(mac100_0_ff_rx_ts_1), 
    .fifo_mux_0_mac100g_0_tx_wren(fifo_mux_0_mac100g_0_tx_wren), 
    .fifo_mux_0_mac100g_0_tx_data(fifo_mux_0_mac100g_0_tx_data), 
    .fifo_mux_0_mac100g_0_tx_sop(fifo_mux_0_mac100g_0_tx_sop), 
    .fifo_mux_0_mac100g_0_tx_eop(fifo_mux_0_mac100g_0_tx_eop), 
    .fifo_mux_0_mac100g_0_tx_mod(fifo_mux_0_mac100g_0_tx_mod), 
    .fifo_mux_0_mac100g_0_tx_err(fifo_mux_0_mac100g_0_tx_err), 
    .fifo_mux_0_mac100g_0_tx_crc(fifo_mux_0_mac100g_0_tx_crc), 
    .mac100_0_ff_tx_rdy_0(mac100_0_ff_tx_rdy_0), 
    .mac100_0_pfc_mode(mac100_0_pfc_mode), 
    .mac100_1_ff_rx_dval_0(mac100_1_ff_rx_dval_0), 
    .mac100_1_ff_rx_data(mac100_1_ff_rx_data), 
    .mac100_1_ff_rx_sop(mac100_1_ff_rx_sop), 
    .mac100_1_ff_rx_eop_0(mac100_1_ff_rx_eop_0), 
    .mac100_1_ff_rx_mod_0(mac100_1_ff_rx_mod_0), 
    .mac100_1_ff_rx_err_0(mac100_1_ff_rx_err_0), 
    .fifo_mux_0_mac100g_1_rx_rdy(fifo_mux_0_mac100g_1_rx_rdy), 
    .mac100_1_ff_rx_ts_0(mac100_1_ff_rx_ts_0), 
    .mac100_1_ff_rx_ts_1(mac100_1_ff_rx_ts_1), 
    .fifo_mux_0_mac100g_1_tx_wren(fifo_mux_0_mac100g_1_tx_wren), 
    .fifo_mux_0_mac100g_1_tx_data(fifo_mux_0_mac100g_1_tx_data), 
    .fifo_mux_0_mac100g_1_tx_sop(fifo_mux_0_mac100g_1_tx_sop), 
    .fifo_mux_0_mac100g_1_tx_eop(fifo_mux_0_mac100g_1_tx_eop), 
    .fifo_mux_0_mac100g_1_tx_mod(fifo_mux_0_mac100g_1_tx_mod), 
    .fifo_mux_0_mac100g_1_tx_err(fifo_mux_0_mac100g_1_tx_err), 
    .fifo_mux_0_mac100g_1_tx_crc(fifo_mux_0_mac100g_1_tx_crc), 
    .mac100_1_ff_tx_rdy_0(mac100_1_ff_tx_rdy_0), 
    .mac100_1_pfc_mode(mac100_1_pfc_mode), 
    .mac100_2_ff_rx_dval_0(mac100_2_ff_rx_dval_0), 
    .mac100_2_ff_rx_data(mac100_2_ff_rx_data), 
    .mac100_2_ff_rx_sop(mac100_2_ff_rx_sop), 
    .mac100_2_ff_rx_eop_0(mac100_2_ff_rx_eop_0), 
    .mac100_2_ff_rx_mod_0(mac100_2_ff_rx_mod_0), 
    .mac100_2_ff_rx_err_0(mac100_2_ff_rx_err_0), 
    .fifo_mux_0_mac100g_2_rx_rdy(fifo_mux_0_mac100g_2_rx_rdy), 
    .mac100_2_ff_rx_ts_0(mac100_2_ff_rx_ts_0), 
    .mac100_2_ff_rx_ts_1(mac100_2_ff_rx_ts_1), 
    .fifo_mux_0_mac100g_2_tx_wren(fifo_mux_0_mac100g_2_tx_wren), 
    .fifo_mux_0_mac100g_2_tx_data(fifo_mux_0_mac100g_2_tx_data), 
    .fifo_mux_0_mac100g_2_tx_sop(fifo_mux_0_mac100g_2_tx_sop), 
    .fifo_mux_0_mac100g_2_tx_eop(fifo_mux_0_mac100g_2_tx_eop), 
    .fifo_mux_0_mac100g_2_tx_mod(fifo_mux_0_mac100g_2_tx_mod), 
    .fifo_mux_0_mac100g_2_tx_err(fifo_mux_0_mac100g_2_tx_err), 
    .fifo_mux_0_mac100g_2_tx_crc(fifo_mux_0_mac100g_2_tx_crc), 
    .mac100_2_ff_tx_rdy_0(mac100_2_ff_tx_rdy_0), 
    .mac100_2_pfc_mode(mac100_2_pfc_mode), 
    .mac100_3_ff_rx_dval_0(mac100_3_ff_rx_dval_0), 
    .mac100_3_ff_rx_data(mac100_3_ff_rx_data), 
    .mac100_3_ff_rx_sop(mac100_3_ff_rx_sop), 
    .mac100_3_ff_rx_eop_0(mac100_3_ff_rx_eop_0), 
    .mac100_3_ff_rx_mod_0(mac100_3_ff_rx_mod_0), 
    .mac100_3_ff_rx_err_0(mac100_3_ff_rx_err_0), 
    .fifo_mux_0_mac100g_3_rx_rdy(fifo_mux_0_mac100g_3_rx_rdy), 
    .mac100_3_ff_rx_ts_0(mac100_3_ff_rx_ts_0), 
    .mac100_3_ff_rx_ts_1(mac100_3_ff_rx_ts_1), 
    .fifo_mux_0_mac100g_3_tx_wren(fifo_mux_0_mac100g_3_tx_wren), 
    .fifo_mux_0_mac100g_3_tx_data(fifo_mux_0_mac100g_3_tx_data), 
    .fifo_mux_0_mac100g_3_tx_sop(fifo_mux_0_mac100g_3_tx_sop), 
    .fifo_mux_0_mac100g_3_tx_eop(fifo_mux_0_mac100g_3_tx_eop), 
    .fifo_mux_0_mac100g_3_tx_mod(fifo_mux_0_mac100g_3_tx_mod), 
    .fifo_mux_0_mac100g_3_tx_err(fifo_mux_0_mac100g_3_tx_err), 
    .fifo_mux_0_mac100g_3_tx_crc(fifo_mux_0_mac100g_3_tx_crc), 
    .mac100_3_ff_tx_rdy_0(mac100_3_ff_tx_rdy_0), 
    .mac100_3_pfc_mode(mac100_3_pfc_mode), 
    .mac400_0_ff_rx_err_0(mac400_0_ff_rx_err_0), 
    .mac200_0_ff_rx_err_0(mac200_0_ff_rx_err_0), 
    .physs_registers_wrapper_0_power_fsm_clk_gate_en(physs_registers_wrapper_0_power_fsm_clk_gate_en_0), 
    .physs_registers_wrapper_0_power_fsm_reset_gate_en(physs_registers_wrapper_0_power_fsm_reset_gate_en_0), 
    .chain_rpt_mquad0_misc0_start_bus_data_in(parmquad0_SSN_END_0_bus_data_out), 
    .SSN_START_0_bus_data_in(parmisc_physs0_SSN_END_towards_mquad0_bus_data_out), 
    .END_0_bus_data_out(par400g0_END_0_bus_data_out), 
    .START_0_bus_data_in(par400g0_END_0_bus_data_out), 
    .chain_rpt_mquad0_misc0_end_bus_data_out(par400g0_chain_rpt_mquad0_misc0_end_bus_data_out), 
    .SSN_END_0_bus_data_out(par400g0_SSN_END_0_bus_data_out), 
    .JT_OUT_mbist_par400g0_ijtag_so(par400g0_JT_OUT_mbist_par400g0_ijtag_so), 
    .JT_OUT_misc_par400g0_ijtag_so(par400g0_JT_OUT_misc_par400g0_ijtag_so), 
    .JT_OUT_scan_par400g0_ijtag_so(par400g0_JT_OUT_scan_par400g0_ijtag_so), 
    .JT_IN_mbist_par400g0_ijtag_reset_b(parmisc_physs0_JT_OUT_mbist_400g0_ijtag_to_reset), 
    .JT_IN_mbist_par400g0_ijtag_shift(parmisc_physs0_JT_OUT_mbist_400g0_ijtag_to_se), 
    .JT_IN_mbist_par400g0_ijtag_capture(parmisc_physs0_JT_OUT_mbist_400g0_ijtag_to_ce), 
    .JT_IN_mbist_par400g0_ijtag_update(parmisc_physs0_JT_OUT_mbist_400g0_ijtag_to_ue), 
    .JT_IN_mbist_par400g0_ijtag_select(parmisc_physs0_JT_OUT_mbist_400g0_ijtag_to_sel), 
    .JT_IN_misc_par400g0_ijtag_reset_b(parmisc_physs0_JT_OUT_misc_400g0_ijtag_to_reset), 
    .JT_IN_misc_par400g0_ijtag_shift(parmisc_physs0_JT_OUT_misc_400g0_ijtag_to_se), 
    .JT_IN_misc_par400g0_ijtag_capture(parmisc_physs0_JT_OUT_misc_400g0_ijtag_to_ce), 
    .JT_IN_misc_par400g0_ijtag_update(parmisc_physs0_JT_OUT_misc_400g0_ijtag_to_ue), 
    .JT_IN_misc_par400g0_ijtag_select(parmisc_physs0_JT_OUT_misc_400g0_ijtag_to_sel), 
    .JT_IN_scan_par400g0_ijtag_tck(parmisc_physs0_JT_OUT_scan_400g0_to_tck), 
    .JT_IN_scan_par400g0_ijtag_reset_b(parmisc_physs0_JT_OUT_scan_400g0_ijtag_to_reset), 
    .JT_IN_scan_par400g0_ijtag_shift(parmisc_physs0_JT_OUT_scan_400g0_ijtag_to_se), 
    .JT_IN_scan_par400g0_ijtag_capture(parmisc_physs0_JT_OUT_scan_400g0_ijtag_to_ce), 
    .JT_IN_scan_par400g0_ijtag_update(parmisc_physs0_JT_OUT_scan_400g0_ijtag_to_ue), 
    .JT_IN_scan_par400g0_ijtag_select(parmisc_physs0_JT_OUT_scan_400g0_ijtag_to_sel), 
    .JT_IN_mbist_par400g0_ijtag_si(parmisc_physs0_JT_OUT_mbist_400g0_ijtag_to_si), 
    .JT_IN_misc_par400g0_ijtag_si(parmisc_physs0_JT_OUT_misc_400g0_ijtag_to_si), 
    .JT_IN_scan_par400g0_ijtag_si(parmisc_physs0_JT_OUT_scan_400g0_ijtag_to_si), 
    .chain_rpt_mquad0_misc0_start_bus_clock_in(SSN_START_entry_from_nac_bus_clock_in), 
    .SSN_START_0_bus_clock_in(SSN_START_entry_from_nac_bus_clock_in), 
    .START_0_bus_clock_in(SSN_START_entry_from_nac_bus_clock_in)
) ; 
par400g1 par400g1 (
    .mbp_repeater_odi_parmisc_physs0_6_ubp_out(mbp_repeater_odi_parmisc_physs0_6_ubp_out), 
    .mbp_repeater_odi_par400g1_ubp_out(mbp_repeater_odi_par400g1_ubp_out), 
    .fdfx_powergood(fdfx_powergood), 
    .secure_group_a(dfxsecure_plugin_dpt2_parmisc_physs0_adfx_tap_grpA_enable), 
    .secure_group_b(dfxsecure_plugin_dpt2_parmisc_physs0_adfx_tap_grpB_enable), 
    .secure_group_c(dfxsecure_plugin_dpt2_parmisc_physs0_adfx_tap_grpC_enable), 
    .secure_group_d(dfxsecure_plugin_dpt2_parmisc_physs0_adfx_tap_grpD_enable), 
    .secure_group_e(dfxsecure_plugin_dpt2_parmisc_physs0_adfx_tap_grpE_enable), 
    .secure_group_g(dfxsecure_plugin_dpt2_parmisc_physs0_adfx_tap_grpG_enable), 
    .secure_group_h(dfxsecure_plugin_dpt2_parmisc_physs0_adfx_tap_grpH_enable), 
    .secure_group_f(dfxsecure_plugin_dpt2_parmisc_physs0_adfx_tap_grpF_enable), 
    .secure_group_z(dfxsecure_plugin_dpt2_parmisc_physs0_adfx_tap_grpZ_enable), 
    .physs_mse_800g_en(physs_mse_800g_en), 
    .versa_xmp_1_o_ucss_srds_phy_ready_pma0_l0_a(versa_xmp_1_o_ucss_srds_phy_ready_pma0_l0_a), 
    .versa_xmp_1_o_ucss_srds_phy_ready_pma1_l0_a(versa_xmp_1_o_ucss_srds_phy_ready_pma1_l0_a), 
    .versa_xmp_1_o_ucss_srds_phy_ready_pma2_l0_a(versa_xmp_1_o_ucss_srds_phy_ready_pma2_l0_a), 
    .versa_xmp_1_o_ucss_srds_phy_ready_pma3_l0_a(versa_xmp_1_o_ucss_srds_phy_ready_pma3_l0_a), 
    .physs_registers_wrapper_1_hlp_link_stat_speed_0_hlp_link_stat_0(physs_registers_wrapper_1_hlp_link_stat_speed_0_hlp_link_stat_0), 
    .physs_registers_wrapper_1_hlp_link_stat_speed_1_hlp_link_stat_1(physs_registers_wrapper_1_hlp_link_stat_speed_1_hlp_link_stat_1), 
    .physs_registers_wrapper_1_hlp_link_stat_speed_2_hlp_link_stat_2(physs_registers_wrapper_1_hlp_link_stat_speed_2_hlp_link_stat_2), 
    .physs_registers_wrapper_1_hlp_link_stat_speed_3_hlp_link_stat_3(physs_registers_wrapper_1_hlp_link_stat_speed_3_hlp_link_stat_3), 
    .physs_registers_wrapper_1_link_bypass_en(physs_registers_wrapper_1_link_bypass_en), 
    .physs_registers_wrapper_1_link_bypass_val(physs_registers_wrapper_1_link_bypass_val), 
    .physs_mac_port_glue_4_mse_ff_rx_dval(physs_mac_port_glue_4_mse_ff_rx_dval), 
    .physs_mac_port_glue_4_mtip_ff_tx_rdy(physs_mac_port_glue_4_mtip_ff_tx_rdy), 
    .fifo_top_mux_0_mse_physs_port_4_rx_rdy(fifo_top_mux_0_mse_physs_port_4_rx_rdy), 
    .fifo_top_mux_0_mse_physs_port_4_tx_wren(fifo_top_mux_0_mse_physs_port_4_tx_wren), 
    .fifo_top_mux_0_mse_physs_port_4_tx_sop(fifo_top_mux_0_mse_physs_port_4_tx_sop), 
    .fifo_top_mux_0_mse_physs_port_4_tx_eop(fifo_top_mux_0_mse_physs_port_4_tx_eop), 
    .physs_mac_port_glue_5_mse_ff_rx_dval(physs_mac_port_glue_5_mse_ff_rx_dval), 
    .physs_mac_port_glue_5_mtip_ff_tx_rdy(physs_mac_port_glue_5_mtip_ff_tx_rdy), 
    .fifo_top_mux_0_mse_physs_port_5_rx_rdy(fifo_top_mux_0_mse_physs_port_5_rx_rdy), 
    .fifo_top_mux_0_mse_physs_port_5_tx_wren(fifo_top_mux_0_mse_physs_port_5_tx_wren), 
    .fifo_top_mux_0_mse_physs_port_5_tx_sop(fifo_top_mux_0_mse_physs_port_5_tx_sop), 
    .fifo_top_mux_0_mse_physs_port_5_tx_eop(fifo_top_mux_0_mse_physs_port_5_tx_eop), 
    .physs_mac_port_glue_6_mse_ff_rx_dval(physs_mac_port_glue_6_mse_ff_rx_dval), 
    .physs_mac_port_glue_6_mtip_ff_tx_rdy(physs_mac_port_glue_6_mtip_ff_tx_rdy), 
    .fifo_top_mux_0_mse_physs_port_6_rx_rdy(fifo_top_mux_0_mse_physs_port_6_rx_rdy), 
    .fifo_top_mux_0_mse_physs_port_6_tx_wren(fifo_top_mux_0_mse_physs_port_6_tx_wren), 
    .fifo_top_mux_0_mse_physs_port_6_tx_sop(fifo_top_mux_0_mse_physs_port_6_tx_sop), 
    .fifo_top_mux_0_mse_physs_port_6_tx_eop(fifo_top_mux_0_mse_physs_port_6_tx_eop), 
    .physs_mac_port_glue_7_mse_ff_rx_dval(physs_mac_port_glue_7_mse_ff_rx_dval), 
    .physs_mac_port_glue_7_mtip_ff_tx_rdy(physs_mac_port_glue_7_mtip_ff_tx_rdy), 
    .fifo_top_mux_0_mse_physs_port_7_rx_rdy(fifo_top_mux_0_mse_physs_port_7_rx_rdy), 
    .fifo_top_mux_0_mse_physs_port_7_tx_wren(fifo_top_mux_0_mse_physs_port_7_tx_wren), 
    .fifo_top_mux_0_mse_physs_port_7_tx_sop(fifo_top_mux_0_mse_physs_port_7_tx_sop), 
    .fifo_top_mux_0_mse_physs_port_7_tx_eop(fifo_top_mux_0_mse_physs_port_7_tx_eop), 
    .physs_mac_port_glue_4_during_pkt_tx_mse_0(physs_mac_port_glue_4_during_pkt_tx_mse_0), 
    .physs_mac_port_glue_4_during_pkt_rx_mtip_0(physs_mac_port_glue_4_during_pkt_rx_mtip_0), 
    .physs_mac_port_glue_4_rx_eop_vaild_0(physs_mac_port_glue_4_rx_eop_vaild_0), 
    .physs_mac_port_glue_4_tx_eop_vaild_0(physs_mac_port_glue_4_tx_eop_vaild_0), 
    .physs_core_rst_fsm_1_mse_if_iso_en(physs_core_rst_fsm_1_mse_if_iso_en), 
    .physs_core_rst_fsm_1_force_if_mse_rx_en_port_num(physs_core_rst_fsm_1_force_if_mse_rx_en_port_num), 
    .physs_core_rst_fsm_1_force_if_mse_tx_en_port_num(physs_core_rst_fsm_1_force_if_mse_tx_en_port_num), 
    .physs_core_rst_fsm_1_during_pkt_tx_mse_ff_clr(physs_core_rst_fsm_1_during_pkt_tx_mse_ff_clr), 
    .physs_mac_port_glue_5_during_pkt_tx_mse_0(physs_mac_port_glue_5_during_pkt_tx_mse_0), 
    .physs_mac_port_glue_5_during_pkt_rx_mtip_0(physs_mac_port_glue_5_during_pkt_rx_mtip_0), 
    .physs_mac_port_glue_5_rx_eop_vaild_0(physs_mac_port_glue_5_rx_eop_vaild_0), 
    .physs_mac_port_glue_5_tx_eop_vaild_0(physs_mac_port_glue_5_tx_eop_vaild_0), 
    .physs_core_rst_fsm_1_force_if_mse_rx_en_port_num_0(physs_core_rst_fsm_1_force_if_mse_rx_en_port_num_0), 
    .physs_core_rst_fsm_1_force_if_mse_tx_en_port_num_0(physs_core_rst_fsm_1_force_if_mse_tx_en_port_num_0), 
    .physs_mac_port_glue_6_during_pkt_tx_mse_0(physs_mac_port_glue_6_during_pkt_tx_mse_0), 
    .physs_mac_port_glue_6_during_pkt_rx_mtip_0(physs_mac_port_glue_6_during_pkt_rx_mtip_0), 
    .physs_mac_port_glue_6_rx_eop_vaild_0(physs_mac_port_glue_6_rx_eop_vaild_0), 
    .physs_mac_port_glue_6_tx_eop_vaild_0(physs_mac_port_glue_6_tx_eop_vaild_0), 
    .physs_core_rst_fsm_1_force_if_mse_rx_en_port_num_1(physs_core_rst_fsm_1_force_if_mse_rx_en_port_num_1), 
    .physs_core_rst_fsm_1_force_if_mse_tx_en_port_num_1(physs_core_rst_fsm_1_force_if_mse_tx_en_port_num_1), 
    .physs_mac_port_glue_7_during_pkt_tx_mse_0(physs_mac_port_glue_7_during_pkt_tx_mse_0), 
    .physs_mac_port_glue_7_during_pkt_rx_mtip_0(physs_mac_port_glue_7_during_pkt_rx_mtip_0), 
    .physs_mac_port_glue_7_rx_eop_vaild_0(physs_mac_port_glue_7_rx_eop_vaild_0), 
    .physs_mac_port_glue_7_tx_eop_vaild_0(physs_mac_port_glue_7_tx_eop_vaild_0), 
    .physs_core_rst_fsm_1_force_if_mse_rx_en_port_num_2(physs_core_rst_fsm_1_force_if_mse_rx_en_port_num_2), 
    .physs_core_rst_fsm_1_force_if_mse_tx_en_port_num_2(physs_core_rst_fsm_1_force_if_mse_tx_en_port_num_2), 
    .physs_registers_wrapper_1_mac200_config_0_xoff_gen(physs_registers_wrapper_1_mac200_config_0_xoff_gen), 
    .physs_registers_wrapper_1_mac200_config_0_tx_loc_fault(physs_registers_wrapper_1_mac200_config_0_tx_loc_fault), 
    .physs_registers_wrapper_1_mac200_config_0_tx_rem_fault(physs_registers_wrapper_1_mac200_config_0_tx_rem_fault), 
    .physs_registers_wrapper_1_mac200_config_0_tx_li_fault(physs_registers_wrapper_1_mac200_config_0_tx_li_fault), 
    .physs_registers_wrapper_1_mac200_config_0_tx_smhold(physs_registers_wrapper_1_mac200_config_0_tx_smhold), 
    .physs_registers_wrapper_1_mac400_config_0_xoff_gen(physs_registers_wrapper_1_mac400_config_0_xoff_gen), 
    .physs_registers_wrapper_1_mac400_config_0_tx_loc_fault(physs_registers_wrapper_1_mac400_config_0_tx_loc_fault), 
    .physs_registers_wrapper_1_mac400_config_0_tx_rem_fault(physs_registers_wrapper_1_mac400_config_0_tx_rem_fault), 
    .physs_registers_wrapper_1_mac400_config_0_tx_li_fault(physs_registers_wrapper_1_mac400_config_0_tx_li_fault), 
    .physs_registers_wrapper_1_mac400_config_0_tx_smhold(physs_registers_wrapper_1_mac400_config_0_tx_smhold), 
    .physs_bbl_200G_1_disable(physs_bbl_200G_1_disable), 
    .physs_bbl_400G_1_disable(physs_bbl_400G_1_disable), 
    .soc_per_clk_adop_parmisc_physs0_clkout(soc_per_clk_adop_parmisc_physs0_clkout_0), 
    .physs_func_clk_adop_parmisc_physs0_clkout(physs_func_clk_adop_parmisc_physs0_clkout_0), 
    .cosq_func_clk1_adop_parmisc_physs0_clkout(cosq_func_clk1_adop_parmisc_physs0_clkout_0), 
    .physs_pcs_mux_1_sd0_tx_clk_200G(physs_pcs_mux_1_sd0_tx_clk_200G), 
    .physs_pcs_mux_1_sd4_tx_clk_200G(physs_pcs_mux_1_sd4_tx_clk_200G), 
    .physs_pcs_mux_1_sd8_tx_clk_200G(physs_pcs_mux_1_sd8_tx_clk_200G), 
    .physs_pcs_mux_1_sd12_tx_clk_200G(physs_pcs_mux_1_sd12_tx_clk_200G), 
    .physs_pcs_mux_1_sd0_tx_clk_400G(physs_pcs_mux_1_sd0_tx_clk_400G), 
    .physs_pcs_mux_1_sd4_tx_clk_400G(physs_pcs_mux_1_sd4_tx_clk_400G), 
    .physs_pcs_mux_1_sd8_tx_clk_400G(physs_pcs_mux_1_sd8_tx_clk_400G), 
    .physs_pcs_mux_1_sd12_tx_clk_400G(physs_pcs_mux_1_sd12_tx_clk_400G), 
    .physs_pcs_mux_1_sd0_rx_clk_400G(physs_pcs_mux_1_sd0_rx_clk_400G), 
    .physs_pcs_mux_1_sd4_rx_clk_400G(physs_pcs_mux_1_sd4_rx_clk_400G), 
    .physs_pcs_mux_1_sd8_rx_clk_400G(physs_pcs_mux_1_sd8_rx_clk_400G), 
    .physs_pcs_mux_1_sd12_rx_clk_400G(physs_pcs_mux_1_sd12_rx_clk_400G), 
    .physs_pcs_mux_1_sd0_rx_clk_200G(physs_pcs_mux_1_sd0_rx_clk_200G), 
    .physs_pcs_mux_1_sd4_rx_clk_200G(physs_pcs_mux_1_sd4_rx_clk_200G), 
    .physs_pcs_mux_1_sd8_rx_clk_200G(physs_pcs_mux_1_sd8_rx_clk_200G), 
    .physs_pcs_mux_1_sd12_rx_clk_200G(physs_pcs_mux_1_sd12_rx_clk_200G), 
    .physs_intf0_clk_adop_parmisc_physs0_clkout(physs_intf0_clk_adop_parmisc_physs0_clkout), 
    .ethphyss_post_clkungate(ethphyss_post_clkungate), 
    .nic400_quad_1_hselx_mac400_stats_0(nic400_quad_1_hselx_mac400_stats_0), 
    .nic400_quad_1_haddr_mac400_stats_0_out(nic400_quad_1_haddr_mac400_stats_0_out), 
    .nic400_quad_1_htrans_mac400_stats_0(nic400_quad_1_htrans_mac400_stats_0), 
    .nic400_quad_1_hwrite_mac400_stats_0(nic400_quad_1_hwrite_mac400_stats_0), 
    .nic400_quad_1_hsize_mac400_stats_0(nic400_quad_1_hsize_mac400_stats_0), 
    .nic400_quad_1_hwdata_mac400_stats_0(nic400_quad_1_hwdata_mac400_stats_0), 
    .nic400_quad_1_hready_mac400_stats_0(nic400_quad_1_hready_mac400_stats_0), 
    .nic400_quad_1_hburst_mac400_stats_0(nic400_quad_1_hburst_mac400_stats_0), 
    .macstats_ahb_bridge_10_hrdata(macstats_ahb_bridge_10_hrdata), 
    .macstats_ahb_bridge_10_hresp(macstats_ahb_bridge_10_hresp), 
    .macstats_ahb_bridge_10_hreadyout(macstats_ahb_bridge_10_hreadyout), 
    .nic400_quad_1_hselx_mac400_stats_1(nic400_quad_1_hselx_mac400_stats_1), 
    .nic400_quad_1_haddr_mac400_stats_1_out(nic400_quad_1_haddr_mac400_stats_1_out), 
    .nic400_quad_1_htrans_mac400_stats_1(nic400_quad_1_htrans_mac400_stats_1), 
    .nic400_quad_1_hwrite_mac400_stats_1(nic400_quad_1_hwrite_mac400_stats_1), 
    .nic400_quad_1_hsize_mac400_stats_1(nic400_quad_1_hsize_mac400_stats_1), 
    .nic400_quad_1_hwdata_mac400_stats_1(nic400_quad_1_hwdata_mac400_stats_1), 
    .nic400_quad_1_hready_mac400_stats_1(nic400_quad_1_hready_mac400_stats_1), 
    .nic400_quad_1_hburst_mac400_stats_1(nic400_quad_1_hburst_mac400_stats_1), 
    .macstats_ahb_bridge_11_hrdata(macstats_ahb_bridge_11_hrdata), 
    .macstats_ahb_bridge_11_hresp(macstats_ahb_bridge_11_hresp), 
    .macstats_ahb_bridge_11_hreadyout(macstats_ahb_bridge_11_hreadyout), 
    .nic400_quad_1_hselx_mac400_0(nic400_quad_1_hselx_mac400_0), 
    .nic400_quad_1_haddr_mac400_0_out(nic400_quad_1_haddr_mac400_0_out), 
    .nic400_quad_1_htrans_mac400_0(nic400_quad_1_htrans_mac400_0), 
    .nic400_quad_1_hwrite_mac400_0(nic400_quad_1_hwrite_mac400_0), 
    .nic400_quad_1_hsize_mac400_0(nic400_quad_1_hsize_mac400_0), 
    .nic400_quad_1_hwdata_mac400_0(nic400_quad_1_hwdata_mac400_0), 
    .nic400_quad_1_hready_mac400_0(nic400_quad_1_hready_mac400_0), 
    .nic400_quad_1_hburst_mac400_0(nic400_quad_1_hburst_mac400_0), 
    .mac200_ahb_bridge_1_hrdata(mac200_ahb_bridge_1_hrdata), 
    .mac200_ahb_bridge_1_hresp(mac200_ahb_bridge_1_hresp), 
    .mac200_ahb_bridge_1_hreadyout(mac200_ahb_bridge_1_hreadyout), 
    .nic400_quad_1_hselx_mac400_1(nic400_quad_1_hselx_mac400_1), 
    .nic400_quad_1_haddr_mac400_1_out(nic400_quad_1_haddr_mac400_1_out), 
    .nic400_quad_1_htrans_mac400_1(nic400_quad_1_htrans_mac400_1), 
    .nic400_quad_1_hwrite_mac400_1(nic400_quad_1_hwrite_mac400_1), 
    .nic400_quad_1_hsize_mac400_1(nic400_quad_1_hsize_mac400_1), 
    .nic400_quad_1_hwdata_mac400_1(nic400_quad_1_hwdata_mac400_1), 
    .nic400_quad_1_hready_mac400_1(nic400_quad_1_hready_mac400_1), 
    .nic400_quad_1_hburst_mac400_1(nic400_quad_1_hburst_mac400_1), 
    .mac400_ahb_bridge_1_hrdata(mac400_ahb_bridge_1_hrdata), 
    .mac400_ahb_bridge_1_hresp(mac400_ahb_bridge_1_hresp), 
    .mac400_ahb_bridge_1_hreadyout(mac400_ahb_bridge_1_hreadyout), 
    .nic400_quad_1_hselx_pcs400_0(nic400_quad_1_hselx_pcs400_0), 
    .nic400_quad_1_haddr_pcs400_0_out(nic400_quad_1_haddr_pcs400_0_out), 
    .nic400_quad_1_htrans_pcs400_0(nic400_quad_1_htrans_pcs400_0), 
    .nic400_quad_1_hwrite_pcs400_0(nic400_quad_1_hwrite_pcs400_0), 
    .nic400_quad_1_hsize_pcs400_0(nic400_quad_1_hsize_pcs400_0), 
    .nic400_quad_1_hwdata_pcs400_0(nic400_quad_1_hwdata_pcs400_0), 
    .nic400_quad_1_hready_pcs400_0(nic400_quad_1_hready_pcs400_0), 
    .nic400_quad_1_hburst_pcs400_0(nic400_quad_1_hburst_pcs400_0), 
    .pcs200_ahb_bridge_2_hrdata(pcs200_ahb_bridge_2_hrdata), 
    .pcs200_ahb_bridge_2_hresp(pcs200_ahb_bridge_2_hresp), 
    .pcs200_ahb_bridge_2_hreadyout(pcs200_ahb_bridge_2_hreadyout), 
    .nic400_quad_1_hselx_rsfec400_0(nic400_quad_1_hselx_rsfec400_0), 
    .nic400_quad_1_haddr_rsfec400_0_out(nic400_quad_1_haddr_rsfec400_0_out), 
    .nic400_quad_1_htrans_rsfec400_0(nic400_quad_1_htrans_rsfec400_0), 
    .nic400_quad_1_hwrite_rsfec400_0(nic400_quad_1_hwrite_rsfec400_0), 
    .nic400_quad_1_hsize_rsfec400_0(nic400_quad_1_hsize_rsfec400_0), 
    .nic400_quad_1_hwdata_rsfec400_0(nic400_quad_1_hwdata_rsfec400_0), 
    .nic400_quad_1_hready_rsfec400_0(nic400_quad_1_hready_rsfec400_0), 
    .nic400_quad_1_hburst_rsfec400_0(nic400_quad_1_hburst_rsfec400_0), 
    .pcs200_ahb_bridge_3_hrdata(pcs200_ahb_bridge_3_hrdata), 
    .pcs200_ahb_bridge_3_hresp(pcs200_ahb_bridge_3_hresp), 
    .pcs200_ahb_bridge_3_hreadyout(pcs200_ahb_bridge_3_hreadyout), 
    .nic400_quad_1_hselx_rsfecstats400_1(nic400_quad_1_hselx_rsfecstats400_1), 
    .nic400_quad_1_haddr_rsfecstats400_1_out(nic400_quad_1_haddr_rsfecstats400_1_out), 
    .nic400_quad_1_htrans_rsfecstats400_1(nic400_quad_1_htrans_rsfecstats400_1), 
    .nic400_quad_1_hwrite_rsfecstats400_1(nic400_quad_1_hwrite_rsfecstats400_1), 
    .nic400_quad_1_hsize_rsfecstats400_1(nic400_quad_1_hsize_rsfecstats400_1), 
    .nic400_quad_1_hwdata_rsfecstats400_1(nic400_quad_1_hwdata_rsfecstats400_1), 
    .nic400_quad_1_hready_rsfecstats400_1(nic400_quad_1_hready_rsfecstats400_1), 
    .nic400_quad_1_hburst_rsfecstats400_1(nic400_quad_1_hburst_rsfecstats400_1), 
    .pcs200_ahb_bridge_5_hrdata(pcs200_ahb_bridge_5_hrdata), 
    .pcs200_ahb_bridge_5_hresp(pcs200_ahb_bridge_5_hresp), 
    .pcs200_ahb_bridge_5_hreadyout(pcs200_ahb_bridge_5_hreadyout), 
    .nic400_quad_1_hselx_pcs400_1(nic400_quad_1_hselx_pcs400_1), 
    .nic400_quad_1_haddr_pcs400_1_out(nic400_quad_1_haddr_pcs400_1_out), 
    .nic400_quad_1_htrans_pcs400_1(nic400_quad_1_htrans_pcs400_1), 
    .nic400_quad_1_hwrite_pcs400_1(nic400_quad_1_hwrite_pcs400_1), 
    .nic400_quad_1_hsize_pcs400_1(nic400_quad_1_hsize_pcs400_1), 
    .nic400_quad_1_hwdata_pcs400_1(nic400_quad_1_hwdata_pcs400_1), 
    .nic400_quad_1_hready_pcs400_1(nic400_quad_1_hready_pcs400_1), 
    .nic400_quad_1_hburst_pcs400_1(nic400_quad_1_hburst_pcs400_1), 
    .pcs400_ahb_bridge_2_hrdata(pcs400_ahb_bridge_2_hrdata), 
    .pcs400_ahb_bridge_2_hresp(pcs400_ahb_bridge_2_hresp), 
    .pcs400_ahb_bridge_2_hreadyout(pcs400_ahb_bridge_2_hreadyout), 
    .nic400_quad_1_hselx_rsfec400_1(nic400_quad_1_hselx_rsfec400_1), 
    .nic400_quad_1_haddr_rsfec400_1_out(nic400_quad_1_haddr_rsfec400_1_out), 
    .nic400_quad_1_htrans_rsfec400_1(nic400_quad_1_htrans_rsfec400_1), 
    .nic400_quad_1_hwrite_rsfec400_1(nic400_quad_1_hwrite_rsfec400_1), 
    .nic400_quad_1_hsize_rsfec400_1(nic400_quad_1_hsize_rsfec400_1), 
    .nic400_quad_1_hwdata_rsfec400_1(nic400_quad_1_hwdata_rsfec400_1), 
    .nic400_quad_1_hready_rsfec400_1(nic400_quad_1_hready_rsfec400_1), 
    .nic400_quad_1_hburst_rsfec400_1(nic400_quad_1_hburst_rsfec400_1), 
    .pcs400_ahb_bridge_3_hrdata(pcs400_ahb_bridge_3_hrdata), 
    .pcs400_ahb_bridge_3_hresp(pcs400_ahb_bridge_3_hresp), 
    .pcs400_ahb_bridge_3_hreadyout(pcs400_ahb_bridge_3_hreadyout), 
    .nic400_quad_1_hselx_rsfecstats400_0(nic400_quad_1_hselx_rsfecstats400_0), 
    .nic400_quad_1_haddr_rsfecstats400_0_out(nic400_quad_1_haddr_rsfecstats400_0_out), 
    .nic400_quad_1_htrans_rsfecstats400_0(nic400_quad_1_htrans_rsfecstats400_0), 
    .nic400_quad_1_hwrite_rsfecstats400_0(nic400_quad_1_hwrite_rsfecstats400_0), 
    .nic400_quad_1_hsize_rsfecstats400_0(nic400_quad_1_hsize_rsfecstats400_0), 
    .nic400_quad_1_hwdata_rsfecstats400_0(nic400_quad_1_hwdata_rsfecstats400_0), 
    .nic400_quad_1_hready_rsfecstats400_0(nic400_quad_1_hready_rsfecstats400_0), 
    .nic400_quad_1_hburst_rsfecstats400_0(nic400_quad_1_hburst_rsfecstats400_0), 
    .pcs400_ahb_bridge_5_hrdata(pcs400_ahb_bridge_5_hrdata), 
    .pcs400_ahb_bridge_5_hresp(pcs400_ahb_bridge_5_hresp), 
    .pcs400_ahb_bridge_5_hreadyout(pcs400_ahb_bridge_5_hreadyout), 
    .nic400_quad_1_hselx_tsu_400_0(nic400_quad_1_hselx_tsu_400_0), 
    .nic400_quad_1_haddr_tsu_400_0_out(nic400_quad_1_haddr_tsu_400_0_out), 
    .nic400_quad_1_htrans_tsu_400_0(nic400_quad_1_htrans_tsu_400_0), 
    .nic400_quad_1_hwrite_tsu_400_0(nic400_quad_1_hwrite_tsu_400_0), 
    .nic400_quad_1_hsize_tsu_400_0(nic400_quad_1_hsize_tsu_400_0), 
    .nic400_quad_1_hwdata_tsu_400_0(nic400_quad_1_hwdata_tsu_400_0), 
    .nic400_quad_1_hready_tsu_400_0(nic400_quad_1_hready_tsu_400_0), 
    .nic400_quad_1_hburst_tsu_400_0(nic400_quad_1_hburst_tsu_400_0), 
    .tsu400_ahb_bridge_1_hrdata(tsu400_ahb_bridge_1_hrdata), 
    .tsu400_ahb_bridge_1_hresp(tsu400_ahb_bridge_1_hresp), 
    .tsu400_ahb_bridge_1_hreadyout(tsu400_ahb_bridge_1_hreadyout), 
    .nic400_quad_1_hselx_tsu_400_1(nic400_quad_1_hselx_tsu_400_1), 
    .nic400_quad_1_haddr_tsu_400_1_out(nic400_quad_1_haddr_tsu_400_1_out), 
    .nic400_quad_1_htrans_tsu_400_1(nic400_quad_1_htrans_tsu_400_1), 
    .nic400_quad_1_hwrite_tsu_400_1(nic400_quad_1_hwrite_tsu_400_1), 
    .nic400_quad_1_hsize_tsu_400_1(nic400_quad_1_hsize_tsu_400_1), 
    .nic400_quad_1_hwdata_tsu_400_1(nic400_quad_1_hwdata_tsu_400_1), 
    .nic400_quad_1_hready_tsu_400_1(nic400_quad_1_hready_tsu_400_1), 
    .nic400_quad_1_hburst_tsu_400_1(nic400_quad_1_hburst_tsu_400_1), 
    .tsu200_ahb_bridge_1_hrdata(tsu200_ahb_bridge_1_hrdata), 
    .tsu200_ahb_bridge_1_hresp(tsu200_ahb_bridge_1_hresp), 
    .tsu200_ahb_bridge_1_hreadyout(tsu200_ahb_bridge_1_hreadyout), 
    .physs_registers_wrapper_1_pcs200_reg_tx_am_sf(physs_registers_wrapper_1_pcs200_reg_tx_am_sf), 
    .physs_registers_wrapper_1_pcs200_reg_rsfec_mode_ll(physs_registers_wrapper_1_pcs200_reg_rsfec_mode_ll), 
    .physs_registers_wrapper_1_pcs200_reg_sd_4x_en(physs_registers_wrapper_1_pcs200_reg_sd_4x_en), 
    .physs_registers_wrapper_1_pcs200_reg_sd_8x_en(physs_registers_wrapper_1_pcs200_reg_sd_8x_en), 
    .physs_registers_wrapper_1_pcs400_reg_tx_am_sf(physs_registers_wrapper_1_pcs400_reg_tx_am_sf), 
    .physs_registers_wrapper_1_pcs400_reg_rsfec_mode_ll(physs_registers_wrapper_1_pcs400_reg_rsfec_mode_ll), 
    .physs_registers_wrapper_1_pcs400_reg_sd_4x_en(physs_registers_wrapper_1_pcs400_reg_sd_4x_en), 
    .physs_registers_wrapper_1_pcs400_reg_sd_8x_en(physs_registers_wrapper_1_pcs400_reg_sd_8x_en), 
    .physs_bbl_spare_0(physs_bbl_spare_0), 
    .mac200_1_pause_on(mac200_1_pause_on), 
    .mac400_1_pause_on(mac400_1_pause_on), 
    .mac200_1_li_fault(mac200_1_li_fault), 
    .mac400_1_li_fault(mac400_1_li_fault), 
    .mac200_1_rem_fault(mac200_1_rem_fault), 
    .mac400_1_rem_fault(mac400_1_rem_fault), 
    .mac200_1_loc_fault(mac200_1_loc_fault), 
    .mac400_1_loc_fault(mac400_1_loc_fault), 
    .mac200_1_tx_empty(mac200_1_tx_empty), 
    .mac400_1_tx_empty(mac400_1_tx_empty), 
    .mac200_1_ff_rx_empty(mac200_1_ff_rx_empty), 
    .mac400_1_ff_rx_empty(mac400_1_ff_rx_empty), 
    .mac200_1_tx_isidle(mac200_1_tx_isidle), 
    .mac400_1_tx_isidle(mac400_1_tx_isidle), 
    .mac200_1_ff_tx_septy(mac200_1_ff_tx_septy), 
    .mac400_1_ff_tx_septy(mac400_1_ff_tx_septy), 
    .mac200_1_tx_underflow(mac200_1_tx_underflow), 
    .mac400_1_tx_underflow(mac400_1_tx_underflow), 
    .mac200_1_tx_ovr_err(mac200_1_tx_ovr_err), 
    .mac400_1_tx_ovr_err(mac400_1_tx_ovr_err), 
    .mac200_1_mdio_oen(mac200_1_mdio_oen), 
    .mac400_1_mdio_oen(mac400_1_mdio_oen), 
    .mac200_1_pfc_mode(mac200_1_pfc_mode), 
    .mac400_1_pfc_mode(mac400_1_pfc_mode), 
    .mac200_1_ff_rx_dsav(mac200_1_ff_rx_dsav), 
    .mac400_1_ff_rx_dsav(mac400_1_ff_rx_dsav), 
    .mac200_1_ff_tx_credit(mac200_1_ff_tx_credit), 
    .mac400_1_ff_tx_credit(mac400_1_ff_tx_credit), 
    .mac200_1_inv_loop_ind(mac200_1_inv_loop_ind), 
    .mac400_1_inv_loop_ind(mac400_1_inv_loop_ind), 
    .mac200_1_frm_drop(mac200_1_frm_drop), 
    .mac400_1_frm_drop(mac400_1_frm_drop), 
    .pcs200_1_rx_am_sf(pcs200_1_rx_am_sf), 
    .pcs200_1_degrade_ser(pcs200_1_degrade_ser), 
    .pcs200_1_hi_ser(pcs200_1_hi_ser), 
    .pcs200_1_link_status(pcs200_1_link_status), 
    .pcs200_1_amps_lock(pcs200_1_amps_lock), 
    .pcs200_1_align_lock(pcs200_1_align_lock), 
    .pcs400_1_rx_am_sf(pcs400_1_rx_am_sf), 
    .pcs400_1_degrade_ser(pcs400_1_degrade_ser), 
    .pcs400_1_hi_ser(pcs400_1_hi_ser), 
    .pcs400_1_link_status(pcs400_1_link_status), 
    .pcs400_1_amps_lock(pcs400_1_amps_lock), 
    .pcs400_1_align_lock(pcs400_1_align_lock), 
    .physs_registers_wrapper_1_pcs_mode_config_pcs_mode_sel_0(physs_registers_wrapper_1_pcs_mode_config_pcs_mode_sel_0), 
    .physs_registers_wrapper_1_pcs_mode_config_fifo_mode_sel(physs_registers_wrapper_1_pcs_mode_config_fifo_mode_sel), 
    .pd_vinf_1_bisr_si(parmisc_physs0_pd_vinf_1_bisr_so), 
    .pd_vinf_1_bisr_so(par400g1_pd_vinf_1_bisr_so), 
    .pd_vinf_1_2_bisr_si(parmquad1_pd_vinf_1_bisr_so), 
    .pd_vinf_1_2_bisr_so(par400g1_pd_vinf_1_2_bisr_so), 
    .pd_vinf_1_bisr_reset(pd_vinf_1_bisr_reset), 
    .pd_vinf_1_bisr_shift_en(pd_vinf_1_bisr_shift_en), 
    .pd_vinf_1_bisr_clk(pd_vinf_1_bisr_clk), 
    .pd_vinf_3_bisr_clk(pd_vinf_3_bisr_clk), 
    .pd_vinf_3_bisr_reset(pd_vinf_3_bisr_reset), 
    .pd_vinf_3_bisr_shift_en(pd_vinf_3_bisr_shift_en), 
    .pd_vinf_3_bisr_si(parmisc_physs0_pd_vinf_3_bisr_so), 
    .pd_vinf_3_bisr_so(par400g1_pd_vinf_3_bisr_so), 
    .DIAG_AGGR_par400g1_mbist_diag_done(par400g1_DIAG_AGGR_par400g1_mbist_diag_done), 
    .physs0_func_rst_raw_n(physs0_func_rst_raw_n), 
    .versa_xmp_1_o_ucss_srds_pcs_tx_reset_pma0_l0_a(versa_xmp_1_o_ucss_srds_pcs_tx_reset_pma0_l0_a), 
    .versa_xmp_1_o_ucss_srds_pcs_rx_reset_pma0_l0_a(versa_xmp_1_o_ucss_srds_pcs_rx_reset_pma0_l0_a), 
    .versa_xmp_1_o_ucss_srds_pcs_tx_reset_pma2_l0_a(versa_xmp_1_o_ucss_srds_pcs_tx_reset_pma2_l0_a), 
    .versa_xmp_1_o_ucss_srds_pcs_rx_reset_pma2_l0_a(versa_xmp_1_o_ucss_srds_pcs_rx_reset_pma2_l0_a), 
    .physs_registers_wrapper_1_reset_cdmii_rxclk_override_200G(physs_registers_wrapper_1_reset_cdmii_rxclk_override_200G), 
    .physs_registers_wrapper_1_reset_cdmii_txclk_override_200G(physs_registers_wrapper_1_reset_cdmii_txclk_override_200G), 
    .physs_registers_wrapper_1_reset_sd_tx_clk_override_200G(physs_registers_wrapper_1_reset_sd_tx_clk_override_200G), 
    .physs_registers_wrapper_1_reset_sd_rx_clk_override_200G(physs_registers_wrapper_1_reset_sd_rx_clk_override_200G), 
    .physs_registers_wrapper_1_reset_reg_clk_override_200G(physs_registers_wrapper_1_reset_reg_clk_override_200G), 
    .physs_registers_wrapper_1_reset_reg_ref_clk_override_200G(physs_registers_wrapper_1_reset_reg_ref_clk_override_200G), 
    .physs_registers_wrapper_1_reset_cdmii_rxclk_override_400G(physs_registers_wrapper_1_reset_cdmii_rxclk_override_400G), 
    .physs_registers_wrapper_1_reset_cdmii_txclk_override_400G(physs_registers_wrapper_1_reset_cdmii_txclk_override_400G), 
    .physs_registers_wrapper_1_reset_sd_tx_clk_override_400G(physs_registers_wrapper_1_reset_sd_tx_clk_override_400G), 
    .physs_registers_wrapper_1_reset_sd_rx_clk_override_400G(physs_registers_wrapper_1_reset_sd_rx_clk_override_400G), 
    .physs_registers_wrapper_1_reset_reg_clk_override_400G(physs_registers_wrapper_1_reset_reg_clk_override_400G), 
    .physs_registers_wrapper_1_reset_reg_ref_clk_override_400G(physs_registers_wrapper_1_reset_reg_ref_clk_override_400G), 
    .physs_registers_wrapper_1_clk_gate_en_200G_mac_pcs_0(physs_registers_wrapper_1_clk_gate_en_200G_mac_pcs_0), 
    .physs_registers_wrapper_1_clk_gate_en_400G_mac_pcs_0(physs_registers_wrapper_1_clk_gate_en_400G_mac_pcs_0), 
    .physs_registers_wrapper_1_reset_pcs200_override_en(physs_registers_wrapper_1_reset_pcs200_override_en), 
    .physs_registers_wrapper_1_reset_pcs400_override_en(physs_registers_wrapper_1_reset_pcs400_override_en), 
    .physs_registers_wrapper_1_reset_mac200_override_en(physs_registers_wrapper_1_reset_mac200_override_en), 
    .physs_registers_wrapper_1_reset_mac400_override_en(physs_registers_wrapper_1_reset_mac400_override_en), 
    .physs_registers_wrapper_1_reset_reg_clk_override_mac_0(physs_registers_wrapper_1_reset_reg_clk_override_mac_0), 
    .physs_registers_wrapper_1_reset_ff_tx_clk_override_0(physs_registers_wrapper_1_reset_ff_tx_clk_override_0), 
    .physs_registers_wrapper_1_reset_ff_rx_clk_override_0(physs_registers_wrapper_1_reset_ff_rx_clk_override_0), 
    .physs_registers_wrapper_1_reset_txclk_override_0(physs_registers_wrapper_1_reset_txclk_override_0), 
    .physs_registers_wrapper_1_reset_rxclk_override_0(physs_registers_wrapper_1_reset_rxclk_override_0), 
    .physs_registers_wrapper_1_pcs_mode_config_pcs_external_loopback_en_lane_0(physs_registers_wrapper_1_pcs_mode_config_pcs_external_loopback_en_lane_0), 
    .physs_hd2prf_trim_fuse_in(physs_hd2prf_trim_fuse_in), 
    .ethphyss_post_clk_mux_ctrl(ethphyss_post_clk_mux_ctrl), 
    .fary_9_post_force_fail(fary_9_post_force_fail), 
    .fary_9_trigger_post(fary_9_trigger_post), 
    .fary_9_post_algo_select(fary_9_post_algo_select), 
    .macpcs400_9_post_pass_tdr(par400g1_macpcs400_9_post_pass_tdr), 
    .macpcs400_9_post_complete_tdr(par400g1_macpcs400_9_post_complete_tdr), 
    .fary_10_post_force_fail(fary_10_post_force_fail), 
    .fary_10_trigger_post(fary_10_trigger_post), 
    .fary_10_post_algo_select(fary_10_post_algo_select), 
    .macpcs200_10_post_pass_tdr(par400g1_macpcs200_10_post_pass_tdr), 
    .macpcs200_10_post_complete_tdr(par400g1_macpcs200_10_post_complete_tdr), 
    .macpcs200_10_post_busy_tdr(par400g1_macpcs200_10_post_busy_tdr), 
    .macpcs400_9_post_busy_tdr(par400g1_macpcs400_9_post_busy_tdr), 
    .parmquad1_pcs_lane_sel_val_par400g1_rtdr(parmquad1_pcs_lane_sel_val_par400g1_rtdr), 
    .parmquad1_pcs_lane_sel_ovr_par400g1_rtdr(parmquad1_pcs_lane_sel_ovr_par400g1_rtdr), 
    .physs_timestamp_1_timer_refpcs_0(physs_timestamp_1_timer_refpcs_0), 
    .physs_timestamp_1_timer_refpcs_1(physs_timestamp_1_timer_refpcs_1), 
    .physs_timestamp_1_timer_refpcs_2(physs_timestamp_1_timer_refpcs_2), 
    .physs_timestamp_1_timer_refpcs_3(physs_timestamp_1_timer_refpcs_3), 
    .mac100_4_ff_rx_err_stat_0(mac100_4_ff_rx_err_stat_0), 
    .mac100_5_ff_rx_err_stat_0(mac100_5_ff_rx_err_stat_0), 
    .mac100_6_ff_rx_err_stat_0(mac100_6_ff_rx_err_stat_0), 
    .mac100_7_ff_rx_err_stat_0(mac100_7_ff_rx_err_stat_0), 
    .fifo_mux_1_mac100g_0_tx_ts_frm(fifo_mux_1_mac100g_0_tx_ts_frm), 
    .fifo_mux_1_mac100g_0_tx_id(fifo_mux_1_mac100g_0_tx_id), 
    .fifo_mux_1_mac100g_1_tx_ts_frm(fifo_mux_1_mac100g_1_tx_ts_frm), 
    .fifo_mux_1_mac100g_1_tx_id(fifo_mux_1_mac100g_1_tx_id), 
    .fifo_mux_1_mac100g_2_tx_ts_frm(fifo_mux_1_mac100g_2_tx_ts_frm), 
    .fifo_mux_1_mac100g_2_tx_id(fifo_mux_1_mac100g_2_tx_id), 
    .fifo_mux_1_mac100g_3_tx_ts_frm(fifo_mux_1_mac100g_3_tx_ts_frm), 
    .fifo_mux_1_mac100g_3_tx_id(fifo_mux_1_mac100g_3_tx_id), 
    .physs_pcs_mux_200_400_1_tx_ts_val(physs_pcs_mux_200_400_1_tx_ts_val), 
    .physs_pcs_mux_200_400_1_tx_ts_id_0(physs_pcs_mux_200_400_1_tx_ts_id_0), 
    .physs_pcs_mux_200_400_1_tx_ts_id_1(physs_pcs_mux_200_400_1_tx_ts_id_1), 
    .physs_pcs_mux_200_400_1_tx_ts_id_2(physs_pcs_mux_200_400_1_tx_ts_id_2), 
    .physs_pcs_mux_200_400_1_tx_ts_id_3(physs_pcs_mux_200_400_1_tx_ts_id_3), 
    .physs_pcs_mux_200_400_1_tx_ts_0(physs_pcs_mux_200_400_1_tx_ts_0), 
    .physs_pcs_mux_200_400_1_tx_ts_1(physs_pcs_mux_200_400_1_tx_ts_1), 
    .physs_pcs_mux_200_400_1_tx_ts_2(physs_pcs_mux_200_400_1_tx_ts_2), 
    .physs_pcs_mux_200_400_1_tx_ts_3(physs_pcs_mux_200_400_1_tx_ts_3), 
    .physs_pcs_mux_200_400_1_sd0_tx_data_o(physs_pcs_mux_200_400_1_sd0_tx_data_o), 
    .physs_pcs_mux_200_400_1_sd1_tx_data_o(physs_pcs_mux_200_400_1_sd1_tx_data_o), 
    .physs_pcs_mux_200_400_1_sd2_tx_data_o(physs_pcs_mux_200_400_1_sd2_tx_data_o), 
    .physs_pcs_mux_200_400_1_sd3_tx_data_o(physs_pcs_mux_200_400_1_sd3_tx_data_o), 
    .physs_pipeline_reg_12_data_out(physs_pipeline_reg_12_data_out), 
    .physs_pipeline_reg_13_data_out(physs_pipeline_reg_13_data_out), 
    .physs_pipeline_reg_14_data_out(physs_pipeline_reg_14_data_out), 
    .physs_pipeline_reg_15_data_out(physs_pipeline_reg_15_data_out), 
    .physs_lane_reversal_mux_1_oflux_srds_rdy_out(physs_lane_reversal_mux_1_oflux_srds_rdy_out), 
    .physs_pcs_mux_200_400_1_link_status_out(physs_pcs_mux_200_400_1_link_status_out), 
    .fifo_mux_1_physs_icq_port_0_link_stat_0(fifo_mux_1_physs_icq_port_0_link_stat_0), 
    .fifo_mux_1_physs_mse_port_0_link_speed(fifo_mux_1_physs_mse_port_0_link_speed), 
    .fifo_mux_1_physs_mse_port_0_rx_data(fifo_mux_1_physs_mse_port_0_rx_data), 
    .fifo_mux_1_physs_mse_port_0_rx_sop_0(fifo_mux_1_physs_mse_port_0_rx_sop_0), 
    .fifo_mux_1_physs_mse_port_0_rx_eop_0(fifo_mux_1_physs_mse_port_0_rx_eop_0), 
    .fifo_mux_1_physs_mse_port_0_rx_mod(fifo_mux_1_physs_mse_port_0_rx_mod), 
    .fifo_mux_1_physs_mse_port_0_rx_err(fifo_mux_1_physs_mse_port_0_rx_err), 
    .fifo_mux_1_physs_mse_port_0_rx_ecc_err(fifo_mux_1_physs_mse_port_0_rx_ecc_err), 
    .fifo_mux_1_physs_mse_port_0_rx_ts(fifo_mux_1_physs_mse_port_0_rx_ts), 
    .fifo_top_mux_0_mse_physs_port_4_tx_data(fifo_top_mux_0_mse_physs_port_4_tx_data), 
    .fifo_top_mux_0_mse_physs_port_4_ts_capture_vld(fifo_top_mux_0_mse_physs_port_4_ts_capture_vld), 
    .fifo_top_mux_0_mse_physs_port_4_ts_capture_idx(fifo_top_mux_0_mse_physs_port_4_ts_capture_idx), 
    .fifo_top_mux_0_mse_physs_port_4_tx_mod(fifo_top_mux_0_mse_physs_port_4_tx_mod), 
    .fifo_top_mux_0_mse_physs_port_4_tx_err(fifo_top_mux_0_mse_physs_port_4_tx_err), 
    .fifo_top_mux_0_mse_physs_port_4_tx_crc(fifo_top_mux_0_mse_physs_port_4_tx_crc), 
    .fifo_mux_1_physs_mse_port_0_pfc_mode(fifo_mux_1_physs_mse_port_0_pfc_mode), 
    .fifo_mux_1_physs_icq_port_1_link_stat_0(fifo_mux_1_physs_icq_port_1_link_stat_0), 
    .fifo_mux_1_physs_mse_port_1_link_speed(fifo_mux_1_physs_mse_port_1_link_speed), 
    .fifo_mux_1_physs_mse_port_1_rx_data(fifo_mux_1_physs_mse_port_1_rx_data), 
    .fifo_mux_1_physs_mse_port_1_rx_sop_0(fifo_mux_1_physs_mse_port_1_rx_sop_0), 
    .fifo_mux_1_physs_mse_port_1_rx_eop_0(fifo_mux_1_physs_mse_port_1_rx_eop_0), 
    .fifo_mux_1_physs_mse_port_1_rx_mod(fifo_mux_1_physs_mse_port_1_rx_mod), 
    .fifo_mux_1_physs_mse_port_1_rx_err(fifo_mux_1_physs_mse_port_1_rx_err), 
    .fifo_mux_1_physs_mse_port_1_rx_ecc_err(fifo_mux_1_physs_mse_port_1_rx_ecc_err), 
    .fifo_mux_1_physs_mse_port_1_rx_ts(fifo_mux_1_physs_mse_port_1_rx_ts), 
    .fifo_top_mux_0_mse_physs_port_5_tx_data(fifo_top_mux_0_mse_physs_port_5_tx_data), 
    .fifo_top_mux_0_mse_physs_port_5_ts_capture_vld(fifo_top_mux_0_mse_physs_port_5_ts_capture_vld), 
    .fifo_top_mux_0_mse_physs_port_5_ts_capture_idx(fifo_top_mux_0_mse_physs_port_5_ts_capture_idx), 
    .fifo_top_mux_0_mse_physs_port_5_tx_mod(fifo_top_mux_0_mse_physs_port_5_tx_mod), 
    .fifo_top_mux_0_mse_physs_port_5_tx_err(fifo_top_mux_0_mse_physs_port_5_tx_err), 
    .fifo_top_mux_0_mse_physs_port_5_tx_crc(fifo_top_mux_0_mse_physs_port_5_tx_crc), 
    .fifo_mux_1_physs_mse_port_1_pfc_mode(fifo_mux_1_physs_mse_port_1_pfc_mode), 
    .fifo_mux_1_physs_icq_port_2_link_stat_0(fifo_mux_1_physs_icq_port_2_link_stat_0), 
    .fifo_mux_1_physs_mse_port_2_link_speed(fifo_mux_1_physs_mse_port_2_link_speed), 
    .fifo_mux_1_physs_mse_port_2_rx_data(fifo_mux_1_physs_mse_port_2_rx_data), 
    .fifo_mux_1_physs_mse_port_2_rx_sop_0(fifo_mux_1_physs_mse_port_2_rx_sop_0), 
    .fifo_mux_1_physs_mse_port_2_rx_eop_0(fifo_mux_1_physs_mse_port_2_rx_eop_0), 
    .fifo_mux_1_physs_mse_port_2_rx_mod(fifo_mux_1_physs_mse_port_2_rx_mod), 
    .fifo_mux_1_physs_mse_port_2_rx_err(fifo_mux_1_physs_mse_port_2_rx_err), 
    .fifo_mux_1_physs_mse_port_2_rx_ecc_err(fifo_mux_1_physs_mse_port_2_rx_ecc_err), 
    .fifo_mux_1_physs_mse_port_2_rx_ts(fifo_mux_1_physs_mse_port_2_rx_ts), 
    .fifo_top_mux_0_mse_physs_port_6_tx_data(fifo_top_mux_0_mse_physs_port_6_tx_data), 
    .fifo_top_mux_0_mse_physs_port_6_ts_capture_vld(fifo_top_mux_0_mse_physs_port_6_ts_capture_vld), 
    .fifo_top_mux_0_mse_physs_port_6_ts_capture_idx(fifo_top_mux_0_mse_physs_port_6_ts_capture_idx), 
    .fifo_top_mux_0_mse_physs_port_6_tx_mod(fifo_top_mux_0_mse_physs_port_6_tx_mod), 
    .fifo_top_mux_0_mse_physs_port_6_tx_err(fifo_top_mux_0_mse_physs_port_6_tx_err), 
    .fifo_top_mux_0_mse_physs_port_6_tx_crc(fifo_top_mux_0_mse_physs_port_6_tx_crc), 
    .fifo_mux_1_physs_mse_port_2_pfc_mode(fifo_mux_1_physs_mse_port_2_pfc_mode), 
    .fifo_mux_1_physs_icq_port_3_link_stat_0(fifo_mux_1_physs_icq_port_3_link_stat_0), 
    .fifo_mux_1_physs_mse_port_3_link_speed(fifo_mux_1_physs_mse_port_3_link_speed), 
    .fifo_mux_1_physs_mse_port_3_rx_data(fifo_mux_1_physs_mse_port_3_rx_data), 
    .fifo_mux_1_physs_mse_port_3_rx_sop_0(fifo_mux_1_physs_mse_port_3_rx_sop_0), 
    .fifo_mux_1_physs_mse_port_3_rx_eop_0(fifo_mux_1_physs_mse_port_3_rx_eop_0), 
    .fifo_mux_1_physs_mse_port_3_rx_mod(fifo_mux_1_physs_mse_port_3_rx_mod), 
    .fifo_mux_1_physs_mse_port_3_rx_err(fifo_mux_1_physs_mse_port_3_rx_err), 
    .fifo_mux_1_physs_mse_port_3_rx_ecc_err(fifo_mux_1_physs_mse_port_3_rx_ecc_err), 
    .fifo_mux_1_physs_mse_port_3_rx_ts(fifo_mux_1_physs_mse_port_3_rx_ts), 
    .fifo_top_mux_0_mse_physs_port_7_tx_data(fifo_top_mux_0_mse_physs_port_7_tx_data), 
    .fifo_top_mux_0_mse_physs_port_7_ts_capture_vld(fifo_top_mux_0_mse_physs_port_7_ts_capture_vld), 
    .fifo_top_mux_0_mse_physs_port_7_ts_capture_idx(fifo_top_mux_0_mse_physs_port_7_ts_capture_idx), 
    .fifo_top_mux_0_mse_physs_port_7_tx_mod(fifo_top_mux_0_mse_physs_port_7_tx_mod), 
    .fifo_top_mux_0_mse_physs_port_7_tx_err(fifo_top_mux_0_mse_physs_port_7_tx_err), 
    .fifo_top_mux_0_mse_physs_port_7_tx_crc(fifo_top_mux_0_mse_physs_port_7_tx_crc), 
    .fifo_mux_1_physs_mse_port_3_pfc_mode(fifo_mux_1_physs_mse_port_3_pfc_mode), 
    .physs_link_speed_decoder_4_link_speed_out(physs_link_speed_decoder_4_link_speed_out), 
    .physs_link_speed_decoder_5_link_speed_out(physs_link_speed_decoder_5_link_speed_out), 
    .physs_link_speed_decoder_6_link_speed_out(physs_link_speed_decoder_6_link_speed_out), 
    .physs_link_speed_decoder_7_link_speed_out(physs_link_speed_decoder_7_link_speed_out), 
    .mac100_4_ff_rx_dval_0(mac100_4_ff_rx_dval_0), 
    .mac100_4_ff_rx_data(mac100_4_ff_rx_data), 
    .mac100_4_ff_rx_sop(mac100_4_ff_rx_sop), 
    .mac100_4_ff_rx_eop_0(mac100_4_ff_rx_eop_0), 
    .mac100_4_ff_rx_mod_0(mac100_4_ff_rx_mod_0), 
    .mac100_4_ff_rx_err_0(mac100_4_ff_rx_err_0), 
    .fifo_mux_1_mac100g_0_rx_rdy(fifo_mux_1_mac100g_0_rx_rdy), 
    .mac100_4_ff_rx_ts_0(mac100_4_ff_rx_ts_0), 
    .mac100_4_ff_rx_ts_1(mac100_4_ff_rx_ts_1), 
    .fifo_mux_1_mac100g_0_tx_wren(fifo_mux_1_mac100g_0_tx_wren), 
    .fifo_mux_1_mac100g_0_tx_data(fifo_mux_1_mac100g_0_tx_data), 
    .fifo_mux_1_mac100g_0_tx_sop(fifo_mux_1_mac100g_0_tx_sop), 
    .fifo_mux_1_mac100g_0_tx_eop(fifo_mux_1_mac100g_0_tx_eop), 
    .fifo_mux_1_mac100g_0_tx_mod(fifo_mux_1_mac100g_0_tx_mod), 
    .fifo_mux_1_mac100g_0_tx_err(fifo_mux_1_mac100g_0_tx_err), 
    .fifo_mux_1_mac100g_0_tx_crc(fifo_mux_1_mac100g_0_tx_crc), 
    .mac100_4_ff_tx_rdy_0(mac100_4_ff_tx_rdy_0), 
    .mac100_4_pfc_mode(mac100_4_pfc_mode), 
    .mac100_5_ff_rx_dval_0(mac100_5_ff_rx_dval_0), 
    .mac100_5_ff_rx_data(mac100_5_ff_rx_data), 
    .mac100_5_ff_rx_sop(mac100_5_ff_rx_sop), 
    .mac100_5_ff_rx_eop_0(mac100_5_ff_rx_eop_0), 
    .mac100_5_ff_rx_mod_0(mac100_5_ff_rx_mod_0), 
    .mac100_5_ff_rx_err_0(mac100_5_ff_rx_err_0), 
    .fifo_mux_1_mac100g_1_rx_rdy(fifo_mux_1_mac100g_1_rx_rdy), 
    .mac100_5_ff_rx_ts_0(mac100_5_ff_rx_ts_0), 
    .mac100_5_ff_rx_ts_1(mac100_5_ff_rx_ts_1), 
    .fifo_mux_1_mac100g_1_tx_wren(fifo_mux_1_mac100g_1_tx_wren), 
    .fifo_mux_1_mac100g_1_tx_data(fifo_mux_1_mac100g_1_tx_data), 
    .fifo_mux_1_mac100g_1_tx_sop(fifo_mux_1_mac100g_1_tx_sop), 
    .fifo_mux_1_mac100g_1_tx_eop(fifo_mux_1_mac100g_1_tx_eop), 
    .fifo_mux_1_mac100g_1_tx_mod(fifo_mux_1_mac100g_1_tx_mod), 
    .fifo_mux_1_mac100g_1_tx_err(fifo_mux_1_mac100g_1_tx_err), 
    .fifo_mux_1_mac100g_1_tx_crc(fifo_mux_1_mac100g_1_tx_crc), 
    .mac100_5_ff_tx_rdy_0(mac100_5_ff_tx_rdy_0), 
    .mac100_5_pfc_mode(mac100_5_pfc_mode), 
    .mac100_6_ff_rx_dval_0(mac100_6_ff_rx_dval_0), 
    .mac100_6_ff_rx_data(mac100_6_ff_rx_data), 
    .mac100_6_ff_rx_sop(mac100_6_ff_rx_sop), 
    .mac100_6_ff_rx_eop_0(mac100_6_ff_rx_eop_0), 
    .mac100_6_ff_rx_mod_0(mac100_6_ff_rx_mod_0), 
    .mac100_6_ff_rx_err_0(mac100_6_ff_rx_err_0), 
    .fifo_mux_1_mac100g_2_rx_rdy(fifo_mux_1_mac100g_2_rx_rdy), 
    .mac100_6_ff_rx_ts_0(mac100_6_ff_rx_ts_0), 
    .mac100_6_ff_rx_ts_1(mac100_6_ff_rx_ts_1), 
    .fifo_mux_1_mac100g_2_tx_wren(fifo_mux_1_mac100g_2_tx_wren), 
    .fifo_mux_1_mac100g_2_tx_data(fifo_mux_1_mac100g_2_tx_data), 
    .fifo_mux_1_mac100g_2_tx_sop(fifo_mux_1_mac100g_2_tx_sop), 
    .fifo_mux_1_mac100g_2_tx_eop(fifo_mux_1_mac100g_2_tx_eop), 
    .fifo_mux_1_mac100g_2_tx_mod(fifo_mux_1_mac100g_2_tx_mod), 
    .fifo_mux_1_mac100g_2_tx_err(fifo_mux_1_mac100g_2_tx_err), 
    .fifo_mux_1_mac100g_2_tx_crc(fifo_mux_1_mac100g_2_tx_crc), 
    .mac100_6_ff_tx_rdy_0(mac100_6_ff_tx_rdy_0), 
    .mac100_6_pfc_mode(mac100_6_pfc_mode), 
    .mac100_7_ff_rx_dval_0(mac100_7_ff_rx_dval_0), 
    .mac100_7_ff_rx_data(mac100_7_ff_rx_data), 
    .mac100_7_ff_rx_sop(mac100_7_ff_rx_sop), 
    .mac100_7_ff_rx_eop_0(mac100_7_ff_rx_eop_0), 
    .mac100_7_ff_rx_mod_0(mac100_7_ff_rx_mod_0), 
    .mac100_7_ff_rx_err_0(mac100_7_ff_rx_err_0), 
    .fifo_mux_1_mac100g_3_rx_rdy(fifo_mux_1_mac100g_3_rx_rdy), 
    .mac100_7_ff_rx_ts_0(mac100_7_ff_rx_ts_0), 
    .mac100_7_ff_rx_ts_1(mac100_7_ff_rx_ts_1), 
    .fifo_mux_1_mac100g_3_tx_wren(fifo_mux_1_mac100g_3_tx_wren), 
    .fifo_mux_1_mac100g_3_tx_data(fifo_mux_1_mac100g_3_tx_data), 
    .fifo_mux_1_mac100g_3_tx_sop(fifo_mux_1_mac100g_3_tx_sop), 
    .fifo_mux_1_mac100g_3_tx_eop(fifo_mux_1_mac100g_3_tx_eop), 
    .fifo_mux_1_mac100g_3_tx_mod(fifo_mux_1_mac100g_3_tx_mod), 
    .fifo_mux_1_mac100g_3_tx_err(fifo_mux_1_mac100g_3_tx_err), 
    .fifo_mux_1_mac100g_3_tx_crc(fifo_mux_1_mac100g_3_tx_crc), 
    .mac100_7_ff_tx_rdy_0(mac100_7_ff_tx_rdy_0), 
    .mac100_7_pfc_mode(mac100_7_pfc_mode), 
    .mac400_1_ff_rx_err_0(mac400_1_ff_rx_err_0), 
    .mac200_1_ff_rx_err_0(mac200_1_ff_rx_err_0), 
    .physs_registers_wrapper_1_power_fsm_clk_gate_en(physs_registers_wrapper_1_power_fsm_clk_gate_en_0), 
    .physs_registers_wrapper_1_power_fsm_reset_gate_en(physs_registers_wrapper_1_power_fsm_reset_gate_en_0), 
    .chain_rpt_mquad1_misc0_start_bus_data_in(parmquad1_SSN_END_0_bus_data_out), 
    .SSN_START_0_bus_data_in(parmisc_physs0_chain_rpt_mquad0_mquad1_end_bus_data_out), 
    .END_0_bus_data_out(par400g1_END_0_bus_data_out), 
    .START_0_bus_data_in(par400g1_END_0_bus_data_out), 
    .chain_rpt_mquad1_misc0_end_bus_data_out(par400g1_chain_rpt_mquad1_misc0_end_bus_data_out), 
    .SSN_END_0_bus_data_out(par400g1_SSN_END_0_bus_data_out), 
    .JT_OUT_mbist_par400g1_ijtag_so(par400g1_JT_OUT_mbist_par400g1_ijtag_so), 
    .JT_OUT_misc_par400g1_ijtag_so(par400g1_JT_OUT_misc_par400g1_ijtag_so), 
    .JT_OUT_scan_par400g1_ijtag_so(par400g1_JT_OUT_scan_par400g1_ijtag_so), 
    .JT_IN_mbist_par400g1_ijtag_reset_b(parmisc_physs0_JT_OUT_mbist_400g1_ijtag_to_reset), 
    .JT_IN_mbist_par400g1_ijtag_shift(parmisc_physs0_JT_OUT_mbist_400g1_ijtag_to_se), 
    .JT_IN_mbist_par400g1_ijtag_capture(parmisc_physs0_JT_OUT_mbist_400g1_ijtag_to_ce), 
    .JT_IN_mbist_par400g1_ijtag_update(parmisc_physs0_JT_OUT_mbist_400g1_ijtag_to_ue), 
    .JT_IN_mbist_par400g1_ijtag_select(parmisc_physs0_JT_OUT_mbist_400g1_ijtag_to_sel), 
    .JT_IN_misc_par400g1_ijtag_reset_b(parmisc_physs0_JT_OUT_misc_400g1_ijtag_to_reset), 
    .JT_IN_misc_par400g1_ijtag_shift(parmisc_physs0_JT_OUT_misc_400g1_ijtag_to_se), 
    .JT_IN_misc_par400g1_ijtag_capture(parmisc_physs0_JT_OUT_misc_400g1_ijtag_to_ce), 
    .JT_IN_misc_par400g1_ijtag_update(parmisc_physs0_JT_OUT_misc_400g1_ijtag_to_ue), 
    .JT_IN_misc_par400g1_ijtag_select(parmisc_physs0_JT_OUT_misc_400g1_ijtag_to_sel), 
    .JT_IN_scan_par400g1_ijtag_tck(parmisc_physs0_JT_OUT_scan_400g1_to_tck), 
    .JT_IN_scan_par400g1_ijtag_reset_b(parmisc_physs0_JT_OUT_scan_400g1_ijtag_to_reset), 
    .JT_IN_scan_par400g1_ijtag_shift(parmisc_physs0_JT_OUT_scan_400g1_ijtag_to_se), 
    .JT_IN_scan_par400g1_ijtag_capture(parmisc_physs0_JT_OUT_scan_400g1_ijtag_to_ce), 
    .JT_IN_scan_par400g1_ijtag_update(parmisc_physs0_JT_OUT_scan_400g1_ijtag_to_ue), 
    .JT_IN_scan_par400g1_ijtag_select(parmisc_physs0_JT_OUT_scan_400g1_ijtag_to_sel), 
    .JT_IN_mbist_par400g1_ijtag_si(parmisc_physs0_JT_OUT_mbist_400g1_ijtag_to_si), 
    .JT_IN_misc_par400g1_ijtag_si(parmisc_physs0_JT_OUT_misc_400g1_ijtag_to_si), 
    .JT_IN_scan_par400g1_ijtag_si(parmisc_physs0_JT_OUT_scan_400g1_ijtag_to_si), 
    .chain_rpt_mquad1_misc0_start_bus_clock_in(SSN_START_entry_from_nac_bus_clock_in), 
    .SSN_START_0_bus_clock_in(SSN_START_entry_from_nac_bus_clock_in), 
    .START_0_bus_clock_in(SSN_START_entry_from_nac_bus_clock_in)
) ; 
par800g par800g (
    .fdfx_powergood(fdfx_powergood), 
    .secure_group_a(dfxsecure_plugin_dpt2_parmisc_physs0_adfx_tap_grpA_enable), 
    .secure_group_b(dfxsecure_plugin_dpt2_parmisc_physs0_adfx_tap_grpB_enable), 
    .secure_group_c(dfxsecure_plugin_dpt2_parmisc_physs0_adfx_tap_grpC_enable), 
    .secure_group_d(dfxsecure_plugin_dpt2_parmisc_physs0_adfx_tap_grpD_enable), 
    .secure_group_e(dfxsecure_plugin_dpt2_parmisc_physs0_adfx_tap_grpE_enable), 
    .secure_group_g(dfxsecure_plugin_dpt2_parmisc_physs0_adfx_tap_grpG_enable), 
    .secure_group_h(dfxsecure_plugin_dpt2_parmisc_physs0_adfx_tap_grpH_enable), 
    .secure_group_f(dfxsecure_plugin_dpt2_parmisc_physs0_adfx_tap_grpF_enable), 
    .secure_group_z(dfxsecure_plugin_dpt2_parmisc_physs0_adfx_tap_grpZ_enable), 
    .cosq_func_clk0_adop_parmisc_physs0_clkout(cosq_func_clk0_adop_parmisc_physs0_clkout_0), 
    .physs_intf0_clk_adop_parmisc_physs0_clkout(physs_intf0_clk_adop_parmisc_physs0_clkout), 
    .physs_func_clk_adop_parmisc_physs0_clkout(physs_func_clk_adop_parmisc_physs0_clkout_0), 
    .physs_funcx2_clk_adop_parmisc_physs0_clkout(physs_funcx2_clk_adop_parmisc_physs0_clkout), 
    .soc_per_clk_adop_parmisc_physs0_clkout(soc_per_clk_adop_parmisc_physs0_clkout_0), 
    .physs_pcs_mux_0_sd_rx_clk_800G(physs_pcs_mux_0_sd_rx_clk_800G), 
    .physs_pcs_mux_0_sd_rx_clk_800G_0(physs_pcs_mux_0_sd_rx_clk_800G_0), 
    .physs_pcs_mux_0_sd_rx_clk_800G_1(physs_pcs_mux_0_sd_rx_clk_800G_1), 
    .physs_pcs_mux_0_sd_rx_clk_800G_2(physs_pcs_mux_0_sd_rx_clk_800G_2), 
    .physs_pcs_mux_1_sd_rx_clk_800G(physs_pcs_mux_1_sd_rx_clk_800G), 
    .physs_pcs_mux_1_sd_rx_clk_800G_0(physs_pcs_mux_1_sd_rx_clk_800G_0), 
    .physs_pcs_mux_1_sd_rx_clk_800G_1(physs_pcs_mux_1_sd_rx_clk_800G_1), 
    .physs_pcs_mux_1_sd_rx_clk_800G_2(physs_pcs_mux_1_sd_rx_clk_800G_2), 
    .physs_pcs_mux_0_sd_tx_clk_800G(physs_pcs_mux_0_sd_tx_clk_800G), 
    .physs_pcs_mux_0_sd_tx_clk_800G_0(physs_pcs_mux_0_sd_tx_clk_800G_0), 
    .physs_pcs_mux_0_sd_tx_clk_800G_1(physs_pcs_mux_0_sd_tx_clk_800G_1), 
    .physs_pcs_mux_0_sd_tx_clk_800G_2(physs_pcs_mux_0_sd_tx_clk_800G_2), 
    .physs_pcs_mux_1_sd_tx_clk_800G(physs_pcs_mux_1_sd_tx_clk_800G), 
    .physs_pcs_mux_1_sd_tx_clk_800G_0(physs_pcs_mux_1_sd_tx_clk_800G_0), 
    .physs_pcs_mux_1_sd_tx_clk_800G_1(physs_pcs_mux_1_sd_tx_clk_800G_1), 
    .physs_pcs_mux_1_sd_tx_clk_800G_2(physs_pcs_mux_1_sd_tx_clk_800G_2), 
    .fifo_top_mux_0_mse_physs_port_0_rx_rdy(fifo_top_mux_0_mse_physs_port_0_rx_rdy), 
    .fifo_top_mux_0_mse_physs_port_0_tx_wren(fifo_top_mux_0_mse_physs_port_0_tx_wren), 
    .fifo_top_mux_0_mse_physs_port_0_tx_data(fifo_top_mux_0_mse_physs_port_0_tx_data), 
    .fifo_top_mux_0_mse_physs_port_0_tx_sop(fifo_top_mux_0_mse_physs_port_0_tx_sop), 
    .fifo_top_mux_0_mse_physs_port_0_tx_eop(fifo_top_mux_0_mse_physs_port_0_tx_eop), 
    .fifo_top_mux_0_mse_physs_port_0_tx_mod(fifo_top_mux_0_mse_physs_port_0_tx_mod), 
    .fifo_top_mux_0_mse_physs_port_0_tx_err(fifo_top_mux_0_mse_physs_port_0_tx_err), 
    .fifo_top_mux_0_mse_physs_port_0_tx_crc(fifo_top_mux_0_mse_physs_port_0_tx_crc), 
    .fifo_top_mux_0_mse_physs_port_0_ts_capture_vld(fifo_top_mux_0_mse_physs_port_0_ts_capture_vld), 
    .fifo_top_mux_0_mse_physs_port_0_ts_capture_idx(fifo_top_mux_0_mse_physs_port_0_ts_capture_idx), 
    .mac800_ff_rx_dval(mac800_ff_rx_dval), 
    .mac800_ff_rx_data(mac800_ff_rx_data), 
    .mac800_ff_rx_sop(mac800_ff_rx_sop), 
    .mac800_ff_rx_eop(mac800_ff_rx_eop), 
    .mac800_ff_rx_mod(mac800_ff_rx_mod), 
    .mac800_ff_rx_err(mac800_ff_rx_err), 
    .mac800_ff_rx_err_stat(mac800_ff_rx_err_stat), 
    .mac800_ff_rx_ts(mac800_ff_rx_ts), 
    .mac800_ff_rx_ts_0(mac800_ff_rx_ts_0), 
    .mac800_ff_tx_rdy(mac800_ff_tx_rdy), 
    .pd_vinf_4_bisr_clk(pd_vinf_4_bisr_clk), 
    .pd_vinf_4_bisr_reset(pd_vinf_4_bisr_reset), 
    .pd_vinf_4_bisr_shift_en(pd_vinf_4_bisr_shift_en), 
    .pd_vinf_4_bisr_si(parmisc_physs0_pd_vinf_4_bisr_so), 
    .pd_vinf_4_bisr_so(par800g_pd_vinf_4_bisr_so), 
    .DIAG_0_mbist_diag_done(par800g_DIAG_0_mbist_diag_done), 
    .physs0_func_rst_raw_n(physs0_func_rst_raw_n), 
    .physs_bbl_800G_0_disable(physs_bbl_800G_0_disable), 
    .versa_xmp_0_o_ucss_srds_pcs_tx_reset_pma0_l0_a(versa_xmp_0_o_ucss_srds_pcs_tx_reset_pma0_l0_a), 
    .versa_xmp_0_o_ucss_srds_pcs_tx_reset_pma1_l0_a(versa_xmp_0_o_ucss_srds_pcs_tx_reset_pma1_l0_a), 
    .versa_xmp_0_o_ucss_srds_pcs_tx_reset_pma2_l0_a(versa_xmp_0_o_ucss_srds_pcs_tx_reset_pma2_l0_a), 
    .versa_xmp_0_o_ucss_srds_pcs_tx_reset_pma3_l0_a(versa_xmp_0_o_ucss_srds_pcs_tx_reset_pma3_l0_a), 
    .versa_xmp_0_o_ucss_srds_pcs_rx_reset_pma0_l0_a(versa_xmp_0_o_ucss_srds_pcs_rx_reset_pma0_l0_a), 
    .versa_xmp_0_o_ucss_srds_pcs_rx_reset_pma1_l0_a(versa_xmp_0_o_ucss_srds_pcs_rx_reset_pma1_l0_a), 
    .versa_xmp_0_o_ucss_srds_pcs_rx_reset_pma2_l0_a(versa_xmp_0_o_ucss_srds_pcs_rx_reset_pma2_l0_a), 
    .versa_xmp_0_o_ucss_srds_pcs_rx_reset_pma3_l0_a(versa_xmp_0_o_ucss_srds_pcs_rx_reset_pma3_l0_a), 
    .versa_xmp_1_o_ucss_srds_pcs_tx_reset_pma0_l0_a(versa_xmp_1_o_ucss_srds_pcs_tx_reset_pma0_l0_a), 
    .versa_xmp_1_o_ucss_srds_pcs_tx_reset_pma1_l0_a(versa_xmp_1_o_ucss_srds_pcs_tx_reset_pma1_l0_a), 
    .versa_xmp_1_o_ucss_srds_pcs_tx_reset_pma2_l0_a(versa_xmp_1_o_ucss_srds_pcs_tx_reset_pma2_l0_a), 
    .versa_xmp_1_o_ucss_srds_pcs_tx_reset_pma3_l0_a(versa_xmp_1_o_ucss_srds_pcs_tx_reset_pma3_l0_a), 
    .versa_xmp_1_o_ucss_srds_pcs_rx_reset_pma0_l0_a(versa_xmp_1_o_ucss_srds_pcs_rx_reset_pma0_l0_a), 
    .versa_xmp_1_o_ucss_srds_pcs_rx_reset_pma1_l0_a(versa_xmp_1_o_ucss_srds_pcs_rx_reset_pma1_l0_a), 
    .versa_xmp_1_o_ucss_srds_pcs_rx_reset_pma2_l0_a(versa_xmp_1_o_ucss_srds_pcs_rx_reset_pma2_l0_a), 
    .versa_xmp_1_o_ucss_srds_pcs_rx_reset_pma3_l0_a(versa_xmp_1_o_ucss_srds_pcs_rx_reset_pma3_l0_a), 
    .physs_registers_wrapper_0_reset_ff_rx_override_MAC_800G(physs_registers_wrapper_0_reset_ff_rx_override_MAC_800G), 
    .physs_registers_wrapper_0_reset_ff_tx_override_MAC_800G(physs_registers_wrapper_0_reset_ff_tx_override_MAC_800G), 
    .physs_registers_wrapper_0_reset_reg_override_MAC_800G(physs_registers_wrapper_0_reset_reg_override_MAC_800G), 
    .physs_registers_wrapper_0_reset_ref_override_MAC_800G(physs_registers_wrapper_0_reset_ref_override_MAC_800G), 
    .physs_registers_wrapper_0_reset_sd_tx_clk_override_800G(physs_registers_wrapper_0_reset_sd_tx_clk_override_800G), 
    .physs_registers_wrapper_0_reset_sd_rx_clk_override_800G(physs_registers_wrapper_0_reset_sd_rx_clk_override_800G), 
    .physs_registers_wrapper_0_reset_ref_clk_override_PCS_800G(physs_registers_wrapper_0_reset_ref_clk_override_PCS_800G), 
    .physs_registers_wrapper_0_reset_ref_clk0_override_PCS_800G(physs_registers_wrapper_0_reset_ref_clk0_override_PCS_800G), 
    .physs_registers_wrapper_0_reset_ref_clk1_override_PCS_800G(physs_registers_wrapper_0_reset_ref_clk1_override_PCS_800G), 
    .physs_registers_wrapper_0_reset_reg_ref_clk_override_PCS_800G(physs_registers_wrapper_0_reset_reg_ref_clk_override_PCS_800G), 
    .physs_registers_wrapper_0_clk_gate_en_800G_mac_pcs_0(physs_registers_wrapper_0_clk_gate_en_800G_mac_pcs_0), 
    .physs_registers_wrapper_0_pcs_mode_config_pcs_external_loopback_en_lane(physs_registers_wrapper_0_pcs_mode_config_pcs_external_loopback_en_lane_0), 
    .physs_registers_wrapper_1_pcs_mode_config_pcs_external_loopback_en_lane(physs_registers_wrapper_1_pcs_mode_config_pcs_external_loopback_en_lane_0), 
    .physs_hd2prf_trim_fuse_in(physs_hd2prf_trim_fuse_in), 
    .ethphyss_post_clk_mux_ctrl(ethphyss_post_clk_mux_ctrl), 
    .fary_6_post_force_fail(fary_6_post_force_fail), 
    .fary_6_trigger_post(fary_6_trigger_post), 
    .fary_6_post_algo_select(fary_6_post_algo_select), 
    .macpcs800_6_post_pass_tdr(par800g_macpcs800_6_post_pass_tdr), 
    .macpcs800_6_post_complete_tdr(par800g_macpcs800_6_post_complete_tdr), 
    .macpcs800_6_post_busy_tdr(par800g_macpcs800_6_post_busy_tdr), 
    .physs_registers_wrapper_0_pcs800_config_400_8_en_in(physs_registers_wrapper_0_pcs800_config_400_8_en_in), 
    .physs_registers_wrapper_0_pcs800_config_400_en_in(physs_registers_wrapper_0_pcs800_config_400_en_in), 
    .physs_registers_wrapper_0_pcs800_config_200_4_en_in(physs_registers_wrapper_0_pcs800_config_200_4_en_in), 
    .physs_registers_wrapper_0_pcs800_config_cdmii8blk(physs_registers_wrapper_0_pcs800_config_cdmii8blk), 
    .physs_registers_wrapper_0_pcs800_config_200_mode_ll(physs_registers_wrapper_0_pcs800_config_200_mode_ll), 
    .physs_registers_wrapper_0_pcs800_config_loopback(physs_registers_wrapper_0_pcs800_config_loopback), 
    .physs_registers_wrapper_0_pcs800_config_loopback_rev(physs_registers_wrapper_0_pcs800_config_loopback_rev), 
    .physs_registers_wrapper_0_mac800_ref_clkx2_en(physs_registers_wrapper_0_mac800_ref_clkx2_en), 
    .physs_registers_wrapper_0_mac800_mode1s_ena(physs_registers_wrapper_0_mac800_mode1s_ena), 
    .physs_registers_wrapper_0_mac800_tx_loc_fault(physs_registers_wrapper_0_mac800_tx_loc_fault), 
    .physs_registers_wrapper_0_mac800_tx_rem_fault(physs_registers_wrapper_0_mac800_tx_rem_fault), 
    .physs_registers_wrapper_0_mac800_tx_li_fault(physs_registers_wrapper_0_mac800_tx_li_fault), 
    .physs_registers_wrapper_0_mac800_xoff_gen(physs_registers_wrapper_0_mac800_xoff_gen), 
    .physs_registers_wrapper_0_mac800_tx_smhold(physs_registers_wrapper_0_mac800_tx_smhold), 
    .mac800_pause_on(mac800_pause_on), 
    .mac800_pfc_mode(mac800_pfc_mode), 
    .mac800_tx_ovr_err(mac800_tx_ovr_err), 
    .mac800_tx_underflow(mac800_tx_underflow), 
    .mac800_tx_empty(mac800_tx_empty), 
    .mac800_tx_isidle(mac800_tx_isidle), 
    .mac800_mdio_oen(mac800_mdio_oen), 
    .mac800_loc_fault(mac800_loc_fault), 
    .mac800_rem_fault(mac800_rem_fault), 
    .mac800_li_fault(mac800_li_fault), 
    .mac800_inv_loop_ind(mac800_inv_loop_ind), 
    .mac800_frm_drop(mac800_frm_drop), 
    .mac800_ff_tx_septy(mac800_ff_tx_septy), 
    .mac800_ff_tx_credit(mac800_ff_tx_credit), 
    .mac800_ff_rx_dsav(mac800_ff_rx_dsav), 
    .mac800_ff_rx_empty(mac800_ff_rx_empty), 
    .mac800_tx_ts_val(mac800_tx_ts_val), 
    .mac800_tx_ts_id(mac800_tx_ts_id), 
    .mac800_tx_ts(mac800_tx_ts), 
    .pcs800_p80_align_lock(pcs800_p80_align_lock), 
    .pcs800_p80_amps_lock(pcs800_p80_amps_lock), 
    .pcs800_p80_link_status_0(pcs800_p80_link_status_0), 
    .pcs800_p80_hi_ser(pcs800_p80_hi_ser), 
    .pcs800_p80_degrade_ser_0(pcs800_p80_degrade_ser_0), 
    .pcs800_p80_rx_am_sf(pcs800_p80_rx_am_sf), 
    .pcs800_p81_align_lock(pcs800_p81_align_lock), 
    .pcs800_p81_amps_lock(pcs800_p81_amps_lock), 
    .pcs800_p81_link_status_0(pcs800_p81_link_status_0), 
    .pcs800_p81_hi_ser(pcs800_p81_hi_ser), 
    .pcs800_p81_degrade_ser_0(pcs800_p81_degrade_ser_0), 
    .pcs800_p81_rx_am_sf(pcs800_p81_rx_am_sf), 
    .physs_timestamp_0_timer_refpcs(physs_timestamp_0_timer_refpcs_2), 
    .physs_timestamp_0_timer_refpcs_0(physs_timestamp_0_timer_refpcs_3), 
    .physs_mse_800g_en(physs_mse_800g_en), 
    .physs_registers_wrapper_0_pcs_mode_config_lane_revsersal_mux_quad_0(physs_registers_wrapper_0_pcs_mode_config_lane_revsersal_mux_quad_0), 
    .physs_pcs_mux_0_srds_rdy_out_800G(physs_pcs_mux_0_srds_rdy_out_800G), 
    .physs_pcs_mux_1_srds_rdy_out_800G(physs_pcs_mux_1_srds_rdy_out_800G), 
    .physs_registers_wrapper_0_pcs_xmp_align_done_sync(physs_registers_wrapper_0_pcs_xmp_align_done_sync), 
    .physs_registers_wrapper_1_pcs_xmp_align_done_sync(physs_registers_wrapper_1_pcs_xmp_align_done_sync), 
    .physs_registers_wrapper_0_pcs_xmp_hi_ber_sync(physs_registers_wrapper_0_pcs_xmp_hi_ber_sync), 
    .physs_registers_wrapper_1_pcs_xmp_hi_ber_sync(physs_registers_wrapper_1_pcs_xmp_hi_ber_sync), 
    .physs_registers_wrapper_0_pcs_xmp_block_lock_sync(physs_registers_wrapper_0_pcs_xmp_block_lock_sync), 
    .physs_registers_wrapper_1_pcs_xmp_block_lock_sync(physs_registers_wrapper_1_pcs_xmp_block_lock_sync), 
    .physs_mux_800G_sd0_tx_data_o(physs_mux_800G_sd0_tx_data_o), 
    .physs_mux_800G_sd1_tx_data_o(physs_mux_800G_sd1_tx_data_o), 
    .physs_mux_800G_sd2_tx_data_o(physs_mux_800G_sd2_tx_data_o), 
    .physs_mux_800G_sd3_tx_data_o(physs_mux_800G_sd3_tx_data_o), 
    .physs_mux_800G_link_status_out(physs_mux_800G_link_status_out), 
    .physs_mux_800G_pcs_align_done_out(physs_mux_800G_pcs_align_done_out), 
    .physs_mux_800G_pcs_hi_ber_out(physs_mux_800G_pcs_hi_ber_out), 
    .physs_mux_800G_pcs_block_lock_out(physs_mux_800G_pcs_block_lock_out), 
    .physs_mux_800G_sd4_tx_data_o(physs_mux_800G_sd4_tx_data_o), 
    .physs_mux_800G_sd5_tx_data_o(physs_mux_800G_sd5_tx_data_o), 
    .physs_mux_800G_sd6_tx_data_o(physs_mux_800G_sd6_tx_data_o), 
    .physs_mux_800G_sd7_tx_data_o(physs_mux_800G_sd7_tx_data_o), 
    .physs_mux_800G_pcs_align_done_out_0(physs_mux_800G_pcs_align_done_out_0), 
    .physs_mux_800G_pcs_hi_ber_out_0(physs_mux_800G_pcs_hi_ber_out_0), 
    .physs_mux_800G_pcs_block_lock_out_0(physs_mux_800G_pcs_block_lock_out_0), 
    .physs_pipeline_reg_800g_misc_8_data_out(physs_pipeline_reg_800g_misc_8_data_out), 
    .physs_pipeline_reg_800g_misc_9_data_out(physs_pipeline_reg_800g_misc_9_data_out), 
    .physs_pipeline_reg_800g_misc_10_data_out(physs_pipeline_reg_800g_misc_10_data_out), 
    .physs_pipeline_reg_800g_misc_11_data_out(physs_pipeline_reg_800g_misc_11_data_out), 
    .physs_pipeline_reg_800g_misc_12_data_out(physs_pipeline_reg_800g_misc_12_data_out), 
    .physs_pipeline_reg_800g_misc_13_data_out(physs_pipeline_reg_800g_misc_13_data_out), 
    .physs_pipeline_reg_800g_misc_14_data_out(physs_pipeline_reg_800g_misc_14_data_out), 
    .physs_pipeline_reg_800g_misc_15_data_out(physs_pipeline_reg_800g_misc_15_data_out), 
    .nic400_physs_0_hselx_mac800(nic400_physs_0_hselx_mac800), 
    .nic400_physs_0_haddr_mac800_out(nic400_physs_0_haddr_mac800_out), 
    .nic400_physs_0_htrans_mac800(nic400_physs_0_htrans_mac800), 
    .nic400_physs_0_hwrite_mac800(nic400_physs_0_hwrite_mac800), 
    .nic400_physs_0_hsize_mac800(nic400_physs_0_hsize_mac800), 
    .nic400_physs_0_hwdata_mac800(nic400_physs_0_hwdata_mac800), 
    .nic400_physs_0_hready_mac800(nic400_physs_0_hready_mac800), 
    .mac800_ahb_bridge_0_hrdata(mac800_ahb_bridge_0_hrdata), 
    .mac800_ahb_bridge_0_hresp(mac800_ahb_bridge_0_hresp), 
    .mac800_ahb_bridge_0_hreadyout(mac800_ahb_bridge_0_hreadyout), 
    .nic400_physs_0_hburst_mac800(nic400_physs_0_hburst_mac800), 
    .nic400_physs_0_hselx_macstats800(nic400_physs_0_hselx_macstats800), 
    .nic400_physs_0_haddr_macstats800_out(nic400_physs_0_haddr_macstats800_out), 
    .nic400_physs_0_htrans_macstats800(nic400_physs_0_htrans_macstats800), 
    .nic400_physs_0_hwrite_macstats800(nic400_physs_0_hwrite_macstats800), 
    .nic400_physs_0_hsize_macstats800(nic400_physs_0_hsize_macstats800), 
    .nic400_physs_0_hwdata_macstats800(nic400_physs_0_hwdata_macstats800), 
    .nic400_physs_0_hready_macstats800(nic400_physs_0_hready_macstats800), 
    .macstats800_ahb_bridge_0_hrdata(macstats800_ahb_bridge_0_hrdata), 
    .macstats800_ahb_bridge_0_hresp(macstats800_ahb_bridge_0_hresp), 
    .macstats800_ahb_bridge_0_hreadyout(macstats800_ahb_bridge_0_hreadyout), 
    .nic400_physs_0_hburst_macstats800(nic400_physs_0_hburst_macstats800), 
    .nic400_physs_0_hselx_pcs800(nic400_physs_0_hselx_pcs800), 
    .nic400_physs_0_haddr_pcs800_out(nic400_physs_0_haddr_pcs800_out), 
    .nic400_physs_0_htrans_pcs800(nic400_physs_0_htrans_pcs800), 
    .nic400_physs_0_hwrite_pcs800(nic400_physs_0_hwrite_pcs800), 
    .nic400_physs_0_hsize_pcs800(nic400_physs_0_hsize_pcs800), 
    .nic400_physs_0_hwdata_pcs800(nic400_physs_0_hwdata_pcs800), 
    .nic400_physs_0_hready_pcs800(nic400_physs_0_hready_pcs800), 
    .pcs800_ahb_bridge_0_hrdata(pcs800_ahb_bridge_0_hrdata), 
    .pcs800_ahb_bridge_0_hresp(pcs800_ahb_bridge_0_hresp), 
    .pcs800_ahb_bridge_0_hreadyout(pcs800_ahb_bridge_0_hreadyout), 
    .nic400_physs_0_hburst_pcs800(nic400_physs_0_hburst_pcs800), 
    .nic400_physs_0_hselx_tsu800(nic400_physs_0_hselx_tsu800), 
    .nic400_physs_0_haddr_tsu800_out(nic400_physs_0_haddr_tsu800_out), 
    .nic400_physs_0_htrans_tsu800(nic400_physs_0_htrans_tsu800), 
    .nic400_physs_0_hwrite_tsu800(nic400_physs_0_hwrite_tsu800), 
    .nic400_physs_0_hsize_tsu800(nic400_physs_0_hsize_tsu800), 
    .nic400_physs_0_hwdata_tsu800(nic400_physs_0_hwdata_tsu800), 
    .nic400_physs_0_hready_tsu800(nic400_physs_0_hready_tsu800), 
    .tsu800_ahb_bridge_0_hrdata(tsu800_ahb_bridge_0_hrdata), 
    .tsu800_ahb_bridge_0_hresp(tsu800_ahb_bridge_0_hresp), 
    .tsu800_ahb_bridge_0_hreadyout(tsu800_ahb_bridge_0_hreadyout), 
    .nic400_physs_0_hburst_tsu800(nic400_physs_0_hburst_tsu800), 
    .physs_registers_wrapper_0_power_fsm_clk_gate_en(physs_registers_wrapper_0_power_fsm_clk_gate_en_0), 
    .physs_registers_wrapper_0_power_fsm_reset_gate_en(physs_registers_wrapper_0_power_fsm_reset_gate_en_0), 
    .SSN_START_0_bus_data_in(parmisc_physs0_END_2_bus_data_out), 
    .SSN_END_0_bus_data_out(par800g_SSN_END_0_bus_data_out), 
    .JT_OUT_mbist_par800g_ijtag_so(par800g_JT_OUT_mbist_par800g_ijtag_so), 
    .JT_OUT_misc_par800g_ijtag_so(par800g_JT_OUT_misc_par800g_ijtag_so), 
    .JT_OUT_scan_par800g_ijtag_so(par800g_JT_OUT_scan_par800g_ijtag_so), 
    .JT_IN_mbist_par800g_ijtag_reset_b(parmisc_physs0_JT_OUT_mbist_800g_ijtag_to_reset), 
    .JT_IN_mbist_par800g_ijtag_shift(parmisc_physs0_JT_OUT_mbist_800g_ijtag_to_se), 
    .JT_IN_mbist_par800g_ijtag_capture(parmisc_physs0_JT_OUT_mbist_800g_ijtag_to_ce), 
    .JT_IN_mbist_par800g_ijtag_update(parmisc_physs0_JT_OUT_mbist_800g_ijtag_to_ue), 
    .JT_IN_mbist_par800g_ijtag_select(parmisc_physs0_JT_OUT_mbist_800g_ijtag_to_sel), 
    .JT_IN_misc_par800g_ijtag_reset_b(parmisc_physs0_JT_OUT_misc_800g_ijtag_to_reset), 
    .JT_IN_misc_par800g_ijtag_shift(parmisc_physs0_JT_OUT_misc_800g_ijtag_to_se), 
    .JT_IN_misc_par800g_ijtag_capture(parmisc_physs0_JT_OUT_misc_800g_ijtag_to_ce), 
    .JT_IN_misc_par800g_ijtag_update(parmisc_physs0_JT_OUT_misc_800g_ijtag_to_ue), 
    .JT_IN_misc_par800g_ijtag_select(parmisc_physs0_JT_OUT_misc_800g_ijtag_to_sel), 
    .JT_IN_scan_par800g_ijtag_tck(parmisc_physs0_JT_OUT_scan_800g_to_tck), 
    .JT_IN_scan_par800g_ijtag_reset_b(parmisc_physs0_JT_OUT_scan_800g_ijtag_to_reset), 
    .JT_IN_scan_par800g_ijtag_shift(parmisc_physs0_JT_OUT_scan_800g_ijtag_to_se), 
    .JT_IN_scan_par800g_ijtag_capture(parmisc_physs0_JT_OUT_scan_800g_ijtag_to_ce), 
    .JT_IN_scan_par800g_ijtag_update(parmisc_physs0_JT_OUT_scan_800g_ijtag_to_ue), 
    .JT_IN_scan_par800g_ijtag_select(parmisc_physs0_JT_OUT_scan_800g_ijtag_to_sel), 
    .JT_IN_mbist_par800g_ijtag_si(parmisc_physs0_JT_OUT_mbist_800g_ijtag_to_si), 
    .JT_IN_misc_par800g_ijtag_si(parmisc_physs0_JT_OUT_misc_800g_ijtag_to_si), 
    .JT_IN_scan_par800g_ijtag_si(parmisc_physs0_JT_OUT_scan_800g_ijtag_to_si), 
    .SSN_START_0_bus_clock_in(SSN_START_entry_from_nac_bus_clock_in)
) ; 
// EDIT_INSTANCE END

// EDIT_CONTINUOUS_ASSIGN BEGIN
assign physs_registers_wrapper_1_power_fsm_reset_gate_en = physs_registers_wrapper_1_power_fsm_reset_gate_en_0 ; 
assign physs_registers_wrapper_1_power_fsm_clk_gate_en = physs_registers_wrapper_1_power_fsm_clk_gate_en_0 ; 
assign physs_registers_wrapper_1_clk_gate_en_100G_mac_pcs = physs_registers_wrapper_1_clk_gate_en_100G_mac_pcs_0 ; 
assign physs_registers_wrapper_1_reset_pcs100_override_en = physs_registers_wrapper_1_reset_pcs100_override_en_0 ; 
assign physs_registers_wrapper_1_reset_ref_clk_override = physs_registers_wrapper_1_reset_ref_clk_override_0 ; 
assign physs_registers_wrapper_0_power_fsm_reset_gate_en = physs_registers_wrapper_0_power_fsm_reset_gate_en_0 ; 
assign physs_registers_wrapper_0_power_fsm_clk_gate_en = physs_registers_wrapper_0_power_fsm_clk_gate_en_0 ; 
assign physs_registers_wrapper_0_clk_gate_en_100G_mac_pcs = physs_registers_wrapper_0_clk_gate_en_100G_mac_pcs_0 ; 
assign physs_registers_wrapper_0_reset_pcs100_override_en = physs_registers_wrapper_0_reset_pcs100_override_en_0 ; 
assign physs_registers_wrapper_0_reset_ref_clk_override = physs_registers_wrapper_0_reset_ref_clk_override_0 ; 
assign uart_clk_adop_parmisc_physs0_clkout_0 = uart_clk_adop_parmisc_physs0_clkout ; 
assign o_ck_pma0_cmnplla_postdiv_clk_mux_parmquad0_clkout_0 = o_ck_pma0_cmnplla_postdiv_clk_mux_parmquad0_clkout ; 
assign fscan_ref_clk_adop_parmisc_physs0_clkout_0 = fscan_ref_clk_adop_parmisc_physs0_clkout ; 
assign physs_func_clk_adop_parmisc_physs0_clkout = physs_func_clk_adop_parmisc_physs0_clkout_0 ; 
// EDIT_CONTINUOUS_ASSIGN END
endmodule
