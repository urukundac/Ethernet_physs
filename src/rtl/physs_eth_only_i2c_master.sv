module physs_eth(
input physs_func_rst_raw_n, //functional reset to PHYSS (LINKR). Should use for MEM init
//logic physs_reset_prep_req, 
input physs_func_clk, //PCS and MAC data path clock (931.25MHz)
input physs_funcx2_clk, //MAC and PCS clock for 800 Mhz operaion (1.6 Ghz)
input physs_intf0_clk, //MAC Interface clock (1.35Ghz)
input soc_per_clk, //control and configuration clock (112.5MHz)
input i2c_apb_clk,
input timeref_clk,
input clk_125mhz,
input reference_clk,
input i_reset,
inout I2C_SDA,
inout I2C_SCL,
input rx_serial_data,
output tx_serial_data,//1588 clock (800MHz)
input rclk_diff_p, //on die differential signal _p
input rclk_diff_n //on die differential signal _n
);

logic secure_group_a;
logic secure_group_b;
logic secure_group_c;
logic secure_group_d;
logic secure_group_e;
logic secure_group_g;
logic secure_group_h;
logic secure_group_f;
logic secure_group_z;
logic fdfx_powergood;
logic tms_park_value;
logic shift_ir_dr;
logic nw_mode;
logic tap_sel_out;
logic [31:0] SSN_START_0_bus_data_in;
logic SSN_START_0_bus_clock_in;
logic [31:0] SSN_START_3_bus_data_in;
logic SSN_START_3_bus_clock_in;
logic [31:0] SSN_START_1_bus_data_in;
logic SSN_START_1_bus_clock_in;
logic [31:0] SSN_START_2_bus_data_in;
logic SSN_START_2_bus_clock_in;
logic [31:0] SSN_END_0_bus_data_out;
logic SSN_END_0_bus_clock_out;
logic [31:0] SSN_END_3_bus_data_out;
logic SSN_END_3_bus_clock_out;
logic [31:0] SSN_END_1_bus_data_out;
logic SSN_END_1_bus_clock_out;
logic [31:0] SSN_END_2_bus_data_out;
logic SSN_END_2_bus_clock_out;
logic [3:0] ioa_ck_pma3_ref_right_mquad0_physs0; //abutment signal on pam3
logic [3:0] ioa_ck_pma0_ref_left_mquad0_physs0; //abutment signal on pam0
logic [3:0] ioa_ck_pma0_ref_left_mquad1_physs0; //abutment signal on pam0
logic [3:0] ioa_ck_pma3_ref_right_mquad1_physs0; //abutment signal on pam3
logic ETH_RXN0;
logic ETH_RXP0;
logic ETH_RXN1;
logic ETH_RXP1;
logic ETH_RXN2;
logic ETH_RXP2;
logic ETH_RXN3;
logic ETH_RXP3;
logic versa_xmp_0_xoa_pma0_tx_n_l0;
logic versa_xmp_0_xoa_pma0_tx_p_l0;
logic versa_xmp_0_xoa_pma1_tx_n_l0;
logic versa_xmp_0_xoa_pma1_tx_p_l0;
logic versa_xmp_0_xoa_pma2_tx_n_l0;
logic versa_xmp_0_xoa_pma2_tx_p_l0;
logic versa_xmp_0_xoa_pma3_tx_n_l0;
logic versa_xmp_0_xoa_pma3_tx_p_l0;
logic ETH_RXN4;
logic ETH_RXP4;
logic ETH_RXN5;
logic ETH_RXP5;
logic ETH_RXN6;
logic ETH_RXP6;
logic ETH_RXN7;
logic ETH_RXP7;
logic versa_xmp_1_xoa_pma0_tx_n_l0;
logic versa_xmp_1_xoa_pma0_tx_p_l0;
logic versa_xmp_1_xoa_pma1_tx_n_l0;
logic versa_xmp_1_xoa_pma1_tx_p_l0;
logic versa_xmp_1_xoa_pma2_tx_n_l0;
logic versa_xmp_1_xoa_pma2_tx_p_l0;
logic versa_xmp_1_xoa_pma3_tx_n_l0;
logic versa_xmp_1_xoa_pma3_tx_p_l0;
logic ioa_pma_remote_diode_i_anode;
logic ioa_pma_remote_diode_i_anode_0;
logic ioa_pma_remote_diode_i_anode_1;
logic ioa_pma_remote_diode_i_anode_2;
logic ioa_pma_remote_diode_i_anode_3;
logic ioa_pma_remote_diode_i_anode_4;
logic ioa_pma_remote_diode_i_anode_5;
logic ioa_pma_remote_diode_i_anode_6;
logic ioa_pma_remote_diode_v_anode;
logic ioa_pma_remote_diode_v_anode_0;
logic ioa_pma_remote_diode_v_anode_1;
logic ioa_pma_remote_diode_v_anode_2;
logic ioa_pma_remote_diode_v_anode_3;
logic ioa_pma_remote_diode_v_anode_4;
logic ioa_pma_remote_diode_v_anode_5;
logic ioa_pma_remote_diode_v_anode_6;
logic ioa_pma_remote_diode_i_cathode;
logic ioa_pma_remote_diode_i_cathode_0;
logic ioa_pma_remote_diode_i_cathode_1;
logic ioa_pma_remote_diode_i_cathode_2;
logic ioa_pma_remote_diode_i_cathode_3;
logic ioa_pma_remote_diode_i_cathode_4;
logic ioa_pma_remote_diode_i_cathode_5;
logic ioa_pma_remote_diode_i_cathode_6;
logic ioa_pma_remote_diode_v_cathode;
logic ioa_pma_remote_diode_v_cathode_0;
logic ioa_pma_remote_diode_v_cathode_1;
logic ioa_pma_remote_diode_v_cathode_2;
logic ioa_pma_remote_diode_v_cathode_3;
logic ioa_pma_remote_diode_v_cathode_4;
logic ioa_pma_remote_diode_v_cathode_5;
logic ioa_pma_remote_diode_v_cathode_6;
logic [3:0] quadpcs100_2_pcs_link_status;
logic [3:0] quadpcs100_3_pcs_link_status;
logic versa_xmp_2_o_ck_pma0_rx_postdiv_l0;
logic versa_xmp_2_o_ck_pma1_rx_postdiv_l0;
logic versa_xmp_2_o_ck_pma2_rx_postdiv_l0;
logic versa_xmp_2_o_ck_pma3_rx_postdiv_l0;
logic versa_xmp_3_o_ck_pma0_rx_postdiv_l0;
logic versa_xmp_3_o_ck_pma1_rx_postdiv_l0;
logic versa_xmp_3_o_ck_pma2_rx_postdiv_l0;
logic versa_xmp_3_o_ck_pma3_rx_postdiv_l0;
logic physs_func_rst_raw_n;
logic soc_per_clk_adop_parmisc_physs0_clkout_0;
logic physs_func_clk_adop_parmisc_physs0_clkout;
logic timeref_clk_adop_parmisc_physs0_clkout;
logic physs_intf0_clk;
logic physs_funcx2_clk;
logic soc_per_clk;
logic physs_func_clk;
logic timeref_clk;
logic fifo_top_mux_0_physs0_icq_port_0_link_stat;
logic [3:0] fifo_top_mux_0_physs0_mse_port_0_link_speed;
logic fifo_top_mux_0_physs0_mse_port_0_rx_dval;
logic [1023:0] fifo_top_mux_0_physs0_mse_port_0_rx_data;
logic fifo_top_mux_0_physs0_mse_port_0_rx_sop;
logic fifo_top_mux_0_physs0_mse_port_0_rx_eop;
logic [6:0] fifo_top_mux_0_physs0_mse_port_0_rx_mod;
logic fifo_top_mux_0_physs0_mse_port_0_rx_err;
logic fifo_top_mux_0_physs0_mse_port_0_rx_ecc_err;
logic [38:0] fifo_top_mux_0_physs0_mse_port_0_rx_ts;
logic fifo_top_mux_0_physs0_mse_port_0_tx_rdy;
logic mse_physs_port_0_rx_rdy;
logic mse_physs_port_0_tx_wren;
logic [1023:0] mse_physs_port_0_tx_data;
logic mse_physs_port_0_tx_sop;
logic mse_physs_port_0_tx_eop;
logic [6:0] mse_physs_port_0_tx_mod;
logic mse_physs_port_0_tx_err;
logic mse_physs_port_0_tx_crc;
logic fifo_top_mux_0_physs0_icq_port_1_link_stat;
logic [3:0] fifo_top_mux_0_physs0_mse_port_1_link_speed;
logic fifo_top_mux_0_physs0_mse_port_1_rx_dval;
logic [1023:0] fifo_top_mux_0_physs0_mse_port_1_rx_data;
logic fifo_top_mux_0_physs0_mse_port_1_rx_sop;
logic fifo_top_mux_0_physs0_mse_port_1_rx_eop;
logic [6:0] fifo_top_mux_0_physs0_mse_port_1_rx_mod;
logic fifo_top_mux_0_physs0_mse_port_1_rx_err;
logic fifo_top_mux_0_physs0_mse_port_1_rx_ecc_err;
logic [38:0] fifo_top_mux_0_physs0_mse_port_1_rx_ts;
logic fifo_top_mux_0_physs0_mse_port_1_tx_rdy;
logic mse_physs_port_1_rx_rdy;
logic mse_physs_port_1_tx_wren;
logic [1023:0] mse_physs_port_1_tx_data;
logic mse_physs_port_1_tx_sop;
logic mse_physs_port_1_tx_eop;
logic [6:0] mse_physs_port_1_tx_mod;
logic mse_physs_port_1_tx_err;
logic mse_physs_port_1_tx_crc;
logic fifo_top_mux_0_physs0_icq_port_2_link_stat;
logic [3:0] fifo_top_mux_0_physs0_mse_port_2_link_speed;
logic fifo_top_mux_0_physs0_mse_port_2_rx_dval;
logic [1023:0] fifo_top_mux_0_physs0_mse_port_2_rx_data;
logic fifo_top_mux_0_physs0_mse_port_2_rx_sop;
logic fifo_top_mux_0_physs0_mse_port_2_rx_eop;
logic [6:0] fifo_top_mux_0_physs0_mse_port_2_rx_mod;
logic fifo_top_mux_0_physs0_mse_port_2_rx_err;
logic fifo_top_mux_0_physs0_mse_port_2_rx_ecc_err;
logic [38:0] fifo_top_mux_0_physs0_mse_port_2_rx_ts;
logic fifo_top_mux_0_physs0_mse_port_2_tx_rdy;
logic mse_physs_port_2_rx_rdy;
logic mse_physs_port_2_tx_wren;
logic [1023:0] mse_physs_port_2_tx_data;
logic mse_physs_port_2_tx_sop;
logic mse_physs_port_2_tx_eop;
logic [6:0] mse_physs_port_2_tx_mod;
logic mse_physs_port_2_tx_err;
logic mse_physs_port_2_tx_crc;
logic fifo_top_mux_0_physs0_icq_port_3_link_stat;
logic [3:0] fifo_top_mux_0_physs0_mse_port_3_link_speed;
logic fifo_top_mux_0_physs0_mse_port_3_rx_dval;
logic [1023:0] fifo_top_mux_0_physs0_mse_port_3_rx_data;
logic fifo_top_mux_0_physs0_mse_port_3_rx_sop;
logic fifo_top_mux_0_physs0_mse_port_3_rx_eop;
logic [6:0] fifo_top_mux_0_physs0_mse_port_3_rx_mod;
logic fifo_top_mux_0_physs0_mse_port_3_rx_err;
logic fifo_top_mux_0_physs0_mse_port_3_rx_ecc_err;
logic [38:0] fifo_top_mux_0_physs0_mse_port_3_rx_ts;
logic fifo_top_mux_0_physs0_mse_port_3_tx_rdy;
logic mse_physs_port_3_rx_rdy;
logic mse_physs_port_3_tx_wren;
logic [1023:0] mse_physs_port_3_tx_data;
logic mse_physs_port_3_tx_sop;
logic mse_physs_port_3_tx_eop;
logic [6:0] mse_physs_port_3_tx_mod;
logic mse_physs_port_3_tx_err;
logic mse_physs_port_3_tx_crc;
logic fifo_top_mux_0_physs1_icq_port_4_link_stat;
logic [3:0] fifo_top_mux_0_physs1_mse_port_4_link_speed;
logic fifo_top_mux_0_physs1_mse_port_4_rx_dval;
logic [1023:0] fifo_top_mux_0_physs1_mse_port_4_rx_data;
logic fifo_top_mux_0_physs1_mse_port_4_rx_sop;
logic fifo_top_mux_0_physs1_mse_port_4_rx_eop;
logic [6:0] fifo_top_mux_0_physs1_mse_port_4_rx_mod;
logic fifo_top_mux_0_physs1_mse_port_4_rx_err;
logic fifo_top_mux_0_physs1_mse_port_4_rx_ecc_err;
logic [38:0] fifo_top_mux_0_physs1_mse_port_4_rx_ts;
logic fifo_top_mux_0_physs1_mse_port_4_tx_rdy;
logic mse_physs_port_4_rx_rdy;
logic mse_physs_port_4_tx_wren;
logic [1023:0] mse_physs_port_4_tx_data;
logic mse_physs_port_4_tx_sop;
logic mse_physs_port_4_tx_eop;
logic [6:0] mse_physs_port_4_tx_mod;
logic mse_physs_port_4_tx_err;
logic mse_physs_port_4_tx_crc;
logic fifo_top_mux_0_physs1_icq_port_5_link_stat;
logic [3:0] fifo_top_mux_0_physs1_mse_port_5_link_speed;
logic fifo_top_mux_0_physs1_mse_port_5_rx_dval;
logic [1023:0] fifo_top_mux_0_physs1_mse_port_5_rx_data;
logic fifo_top_mux_0_physs1_mse_port_5_rx_sop;
logic fifo_top_mux_0_physs1_mse_port_5_rx_eop;
logic [6:0] fifo_top_mux_0_physs1_mse_port_5_rx_mod;
logic fifo_top_mux_0_physs1_mse_port_5_rx_err;
logic fifo_top_mux_0_physs1_mse_port_5_rx_ecc_err;
logic [38:0] fifo_top_mux_0_physs1_mse_port_5_rx_ts;
logic fifo_top_mux_0_physs1_mse_port_5_tx_rdy;
logic mse_physs_port_5_rx_rdy;
logic mse_physs_port_5_tx_wren;
logic [1023:0] mse_physs_port_5_tx_data;
logic mse_physs_port_5_tx_sop;
logic mse_physs_port_5_tx_eop;
logic [6:0] mse_physs_port_5_tx_mod;
logic mse_physs_port_5_tx_err;
logic mse_physs_port_5_tx_crc;
logic fifo_top_mux_0_physs1_icq_port_6_link_stat;
logic [3:0] fifo_top_mux_0_physs1_mse_port_6_link_speed;
logic fifo_top_mux_0_physs1_mse_port_6_rx_dval;
logic [1023:0] fifo_top_mux_0_physs1_mse_port_6_rx_data;
logic fifo_top_mux_0_physs1_mse_port_6_rx_sop;
logic fifo_top_mux_0_physs1_mse_port_6_rx_eop;
logic [6:0] fifo_top_mux_0_physs1_mse_port_6_rx_mod;
logic fifo_top_mux_0_physs1_mse_port_6_rx_err;
logic fifo_top_mux_0_physs1_mse_port_6_rx_ecc_err;
logic [38:0] fifo_top_mux_0_physs1_mse_port_6_rx_ts;
logic fifo_top_mux_0_physs1_mse_port_6_tx_rdy;
logic mse_physs_port_6_rx_rdy;
logic mse_physs_port_6_tx_wren;
logic [1023:0] mse_physs_port_6_tx_data;
logic mse_physs_port_6_tx_sop;
logic mse_physs_port_6_tx_eop;
logic [6:0] mse_physs_port_6_tx_mod;
logic mse_physs_port_6_tx_err;
logic mse_physs_port_6_tx_crc;
logic fifo_top_mux_0_physs1_icq_port_7_link_stat;
logic [3:0] fifo_top_mux_0_physs1_mse_port_7_link_speed;
logic fifo_top_mux_0_physs1_mse_port_7_rx_dval;
logic [1023:0] fifo_top_mux_0_physs1_mse_port_7_rx_data;
logic fifo_top_mux_0_physs1_mse_port_7_rx_sop;
logic fifo_top_mux_0_physs1_mse_port_7_rx_eop;
logic [6:0] fifo_top_mux_0_physs1_mse_port_7_rx_mod;
logic fifo_top_mux_0_physs1_mse_port_7_rx_err;
logic fifo_top_mux_0_physs1_mse_port_7_rx_ecc_err;
logic [38:0] fifo_top_mux_0_physs1_mse_port_7_rx_ts;
logic fifo_top_mux_0_physs1_mse_port_7_tx_rdy;
logic mse_physs_port_7_rx_rdy;
logic mse_physs_port_7_tx_wren;
logic [1023:0] mse_physs_port_7_tx_data;
logic mse_physs_port_7_tx_sop;
logic mse_physs_port_7_tx_eop;
logic [6:0] mse_physs_port_7_tx_mod;
logic mse_physs_port_7_tx_err;
logic mse_physs_port_7_tx_crc;
logic physs_synce_mux_0_clkout;
logic physs_synce_mux_1_clkout;
logic hlp_mac_rx_throttle_0_stop;
logic hlp_mac_rx_throttle_1_stop;
logic hlp_mac_rx_throttle_2_stop;
logic hlp_mac_rx_throttle_3_stop;
logic tx_stop_0_in;
logic tx_stop_1_in;
logic tx_stop_2_in;
logic tx_stop_3_in;
logic [7:0] physs_rfhs_trim_fuse_in;
logic [15:0] physs_hdspsr_trim_fuse_in;
logic [5:0] physs_hdp2prf_trim_fuse_in;
logic [5:0] physs_hd2prf_trim_fuse_in;
logic mac100_0_pfc_mode;
logic mac100_1_pfc_mode;
logic mac100_2_pfc_mode;
logic mac100_3_pfc_mode;
logic mac100_4_pfc_mode;
logic mac100_5_pfc_mode;
logic mac100_6_pfc_mode;
logic mac100_7_pfc_mode;
logic mac100_0_magic_ind_0;
logic mac100_1_magic_ind_0;
logic mac100_2_magic_ind_0;
logic mac100_3_magic_ind_0;
logic mac100_4_magic_ind_0;
logic mac100_5_magic_ind_0;
logic mac100_6_magic_ind_0;
logic mac100_7_magic_ind_0;
logic [7:0] icq_physs_net_xoff;
logic [7:0] icq_physs_net_xoff_0;
logic [7:0] icq_physs_net_xoff_1;
logic [7:0] icq_physs_net_xoff_2;
logic [7:0] icq_physs_net_xoff_3;
logic [7:0] icq_physs_net_xoff_4;
logic [7:0] icq_physs_net_xoff_5;
logic [7:0] icq_physs_net_xoff_6;
logic [7:0] mac100_0_pause_on_0;
logic [7:0] mac100_1_pause_on_0;
logic [7:0] mac100_2_pause_on_0;
logic [7:0] mac100_3_pause_on_0;
logic [7:0] mac100_4_pause_on_0;
logic [7:0] mac100_5_pause_on_0;
logic [7:0] mac100_6_pause_on_0;
logic [7:0] mac100_7_pause_on_0;
logic [7:0] quadpcs100_0_pcs_tsu_rx_sd_0;
logic [1:0] quadpcs100_0_mii_rx_tsu_mux0_0;
logic [1:0] quadpcs100_0_mii_rx_tsu_mux1_0;
logic [1:0] quadpcs100_0_mii_rx_tsu_mux2_0;
logic [1:0] quadpcs100_0_mii_rx_tsu_mux3_0;
logic [7:0] quadpcs100_0_mii_tx_tsu_0;
logic [27:0] quadpcs100_0_pcs_desk_buf_rlevel_0;
logic [31:0] quadpcs100_0_pcs_sd_bit_slip_0;
logic [3:0] quadpcs100_0_pcs_link_status_tsu_0;
logic [7:0] quadpcs100_1_pcs_tsu_rx_sd_0;
logic [1:0] quadpcs100_1_mii_rx_tsu_mux0_0;
logic [1:0] quadpcs100_1_mii_rx_tsu_mux1_0;
logic [1:0] quadpcs100_1_mii_rx_tsu_mux2_0;
logic [1:0] quadpcs100_1_mii_rx_tsu_mux3_0;
logic [7:0] quadpcs100_1_mii_tx_tsu_0;
logic [27:0] quadpcs100_1_pcs_desk_buf_rlevel_0;
logic [31:0] quadpcs100_1_pcs_sd_bit_slip_0;
logic [3:0] quadpcs100_1_pcs_link_status_tsu_0;
logic versa_xmp_0_xioa_ck_pma0_ref0_n;
logic versa_xmp_0_xioa_ck_pma0_ref0_p;
logic versa_xmp_0_xioa_ck_pma0_ref1_n;
logic versa_xmp_0_xioa_ck_pma0_ref1_p;
logic versa_xmp_0_xioa_ck_pma1_ref0_n;
logic versa_xmp_0_xioa_ck_pma1_ref0_p;
logic versa_xmp_0_xioa_ck_pma1_ref1_n;
logic versa_xmp_0_xioa_ck_pma1_ref1_p;
logic versa_xmp_0_xioa_ck_pma2_ref0_n;
logic versa_xmp_0_xioa_ck_pma2_ref0_p;
logic versa_xmp_0_xioa_ck_pma2_ref1_n;
logic versa_xmp_0_xioa_ck_pma2_ref1_p;
logic versa_xmp_0_xioa_ck_pma3_ref0_n;
logic versa_xmp_0_xioa_ck_pma3_ref0_p;
logic versa_xmp_0_xioa_ck_pma3_ref1_n;
logic versa_xmp_0_xioa_ck_pma3_ref1_p;
logic rclk_diff_p;
logic rclk_diff_n;
logic versa_xmp_0_xoa_pma0_dcmon1;
logic versa_xmp_0_xoa_pma0_dcmon2;
logic versa_xmp_0_xoa_pma1_dcmon1;
logic versa_xmp_0_xoa_pma1_dcmon2;
logic versa_xmp_0_xoa_pma2_dcmon1;
logic versa_xmp_0_xoa_pma2_dcmon2;
logic versa_xmp_0_xoa_pma3_dcmon1;
logic versa_xmp_0_xoa_pma3_dcmon2;
logic versa_xmp_1_xioa_ck_pma0_ref0_n;
logic versa_xmp_1_xioa_ck_pma0_ref0_p;
logic versa_xmp_1_xioa_ck_pma0_ref1_n;
logic versa_xmp_1_xioa_ck_pma0_ref1_p;
logic versa_xmp_1_xioa_ck_pma1_ref0_n;
logic versa_xmp_1_xioa_ck_pma1_ref0_p;
logic versa_xmp_1_xioa_ck_pma1_ref1_n;
logic versa_xmp_1_xioa_ck_pma1_ref1_p;
logic versa_xmp_1_xioa_ck_pma2_ref0_n;
logic versa_xmp_1_xioa_ck_pma2_ref0_p;
logic versa_xmp_1_xioa_ck_pma2_ref1_n;
logic versa_xmp_1_xioa_ck_pma2_ref1_p;
logic versa_xmp_1_xioa_ck_pma3_ref0_n;
logic versa_xmp_1_xioa_ck_pma3_ref0_p;
logic versa_xmp_1_xioa_ck_pma3_ref1_n;
logic versa_xmp_1_xioa_ck_pma3_ref1_p;
logic versa_xmp_1_xoa_pma0_dcmon1;
logic versa_xmp_1_xoa_pma0_dcmon2;
logic versa_xmp_1_xoa_pma1_dcmon1;
logic versa_xmp_1_xoa_pma1_dcmon2;
logic versa_xmp_1_xoa_pma2_dcmon1;
logic versa_xmp_1_xoa_pma2_dcmon2;
logic versa_xmp_1_xoa_pma3_dcmon1;
logic versa_xmp_1_xoa_pma3_dcmon2;
logic quad_interrupts_0_physs_fatal_int;
logic quad_interrupts_1_physs_fatal_int;
logic quad_interrupts_0_physs_imc_int;
logic quad_interrupts_1_physs_imc_int;
logic quad_interrupts_0_mac800_int;
logic versa_xmp_0_o_ucss_irq_cpi_0_a;
logic versa_xmp_1_o_ucss_irq_cpi_0_a;
logic versa_xmp_0_o_ucss_irq_cpi_1_a;
logic versa_xmp_1_o_ucss_irq_cpi_1_a;
logic versa_xmp_0_o_ucss_irq_cpi_2_a;
logic versa_xmp_1_o_ucss_irq_cpi_2_a;
logic versa_xmp_0_o_ucss_irq_cpi_3_a;
logic versa_xmp_1_o_ucss_irq_cpi_3_a;
logic versa_xmp_0_o_ucss_irq_cpi_4_a;
logic versa_xmp_1_o_ucss_irq_cpi_4_a;
logic versa_xmp_0_o_ucss_irq_status_a;
logic versa_xmp_1_o_ucss_irq_status_a;
logic nic_switch_mux_0_hlp_xlgmii0_txclk_ena;
logic nic_switch_mux_0_hlp_xlgmii0_rxclk_ena;
logic [7:0] nic_switch_mux_0_hlp_xlgmii0_rxc;
logic [63:0] nic_switch_mux_0_hlp_xlgmii0_rxd;
logic nic_switch_mux_0_hlp_xlgmii0_rxt0_next;
logic [7:0] hlp_xlgmii0_txc_0;
logic [63:0] hlp_xlgmii0_txd_0;
logic nic_switch_mux_0_hlp_xlgmii1_txclk_ena;
logic nic_switch_mux_0_hlp_xlgmii1_rxclk_ena;
logic [7:0] nic_switch_mux_0_hlp_xlgmii1_rxc;
logic [63:0] nic_switch_mux_0_hlp_xlgmii1_rxd;
logic nic_switch_mux_0_hlp_xlgmii1_rxt0_next;
logic [7:0] hlp_xlgmii1_txc_0;
logic [63:0] hlp_xlgmii1_txd_0;
logic nic_switch_mux_0_hlp_xlgmii2_txclk_ena;
logic nic_switch_mux_0_hlp_xlgmii2_rxclk_ena;
logic [7:0] nic_switch_mux_0_hlp_xlgmii2_rxc;
logic [63:0] nic_switch_mux_0_hlp_xlgmii2_rxd;
logic nic_switch_mux_0_hlp_xlgmii2_rxt0_next;
logic [7:0] hlp_xlgmii2_txc_0;
logic [63:0] hlp_xlgmii2_txd_0;
logic nic_switch_mux_0_hlp_xlgmii3_txclk_ena;
logic nic_switch_mux_0_hlp_xlgmii3_rxclk_ena;
logic [7:0] nic_switch_mux_0_hlp_xlgmii3_rxc;
logic [63:0] nic_switch_mux_0_hlp_xlgmii3_rxd;
logic nic_switch_mux_0_hlp_xlgmii3_rxt0_next;
logic [7:0] hlp_xlgmii3_txc_0;
logic [63:0] hlp_xlgmii3_txd_0;
logic [127:0] nic_switch_mux_0_hlp_cgmii0_rxd;
logic [15:0] nic_switch_mux_0_hlp_cgmii0_rxc;
logic nic_switch_mux_0_hlp_cgmii0_rxclk_ena;
logic [127:0] hlp_cgmii0_txd_0;
logic [15:0] hlp_cgmii0_txc_0;
logic nic_switch_mux_0_hlp_cgmii0_txclk_ena;
logic [127:0] nic_switch_mux_0_hlp_cgmii1_rxd;
logic [15:0] nic_switch_mux_0_hlp_cgmii1_rxc;
logic nic_switch_mux_0_hlp_cgmii1_rxclk_ena;
logic [127:0] hlp_cgmii1_txd_0;
logic [15:0] hlp_cgmii1_txc_0;
logic nic_switch_mux_0_hlp_cgmii1_txclk_ena;
logic [127:0] nic_switch_mux_0_hlp_cgmii2_rxd;
logic [15:0] nic_switch_mux_0_hlp_cgmii2_rxc;
logic nic_switch_mux_0_hlp_cgmii2_rxclk_ena;
logic [127:0] hlp_cgmii2_txd_0;
logic [15:0] hlp_cgmii2_txc_0;
logic nic_switch_mux_0_hlp_cgmii2_txclk_ena;
logic [127:0] nic_switch_mux_0_hlp_cgmii3_rxd;
logic [15:0] nic_switch_mux_0_hlp_cgmii3_rxc;
logic nic_switch_mux_0_hlp_cgmii3_rxclk_ena;
logic [127:0] hlp_cgmii3_txd_0;
logic [15:0] hlp_cgmii3_txc_0;
logic nic_switch_mux_0_hlp_cgmii3_txclk_ena;
logic hlp_xlgmii0_txclk_ena_nss_0;
logic hlp_xlgmii0_rxclk_ena_nss_0;
logic [7:0] hlp_xlgmii0_rxc_nss_0;
logic [63:0] hlp_xlgmii0_rxd_nss_0;
logic hlp_xlgmii0_rxt0_next_nss_0;
logic [7:0] nic_switch_mux_0_hlp_xlgmii0_txc_nss;
logic [63:0] nic_switch_mux_0_hlp_xlgmii0_txd_nss;
logic hlp_xlgmii1_txclk_ena_nss_0;
logic hlp_xlgmii1_rxclk_ena_nss_0;
logic [7:0] hlp_xlgmii1_rxc_nss_0;
logic [63:0] hlp_xlgmii1_rxd_nss_0;
logic hlp_xlgmii1_rxt0_next_nss_0;
logic [7:0] nic_switch_mux_0_hlp_xlgmii1_txc_nss;
logic [63:0] nic_switch_mux_0_hlp_xlgmii1_txd_nss;
logic hlp_xlgmii2_txclk_ena_nss_0;
logic hlp_xlgmii2_rxclk_ena_nss_0;
logic [7:0] hlp_xlgmii2_rxc_nss_0;
logic [63:0] hlp_xlgmii2_rxd_nss_0;
logic hlp_xlgmii2_rxt0_next_nss_0;
logic [7:0] nic_switch_mux_0_hlp_xlgmii2_txc_nss;
logic [63:0] nic_switch_mux_0_hlp_xlgmii2_txd_nss;
logic hlp_xlgmii3_txclk_ena_nss_0;
logic hlp_xlgmii3_rxclk_ena_nss_0;
logic [7:0] hlp_xlgmii3_rxc_nss_0;
logic [63:0] hlp_xlgmii3_rxd_nss_0;
logic hlp_xlgmii3_rxt0_next_nss_0;
logic [7:0] nic_switch_mux_0_hlp_xlgmii3_txc_nss;
logic [63:0] nic_switch_mux_0_hlp_xlgmii3_txd_nss;
logic [127:0] hlp_cgmii0_rxd_nss_0;
logic [15:0] hlp_cgmii0_rxc_nss_0;
logic hlp_cgmii0_rxclk_ena_nss_0;
logic [127:0] nic_switch_mux_0_hlp_cgmii0_txd_nss;
logic [15:0] nic_switch_mux_0_hlp_cgmii0_txc_nss;
logic hlp_cgmii0_txclk_ena_nss_0;
logic [127:0] hlp_cgmii1_rxd_nss_0;
logic [15:0] hlp_cgmii1_rxc_nss_0;
logic hlp_cgmii1_rxclk_ena_nss_0;
logic [127:0] nic_switch_mux_0_hlp_cgmii1_txd_nss;
logic [15:0] nic_switch_mux_0_hlp_cgmii1_txc_nss;
logic hlp_cgmii1_txclk_ena_nss_0;
logic [127:0] hlp_cgmii2_rxd_nss_0;
logic [15:0] hlp_cgmii2_rxc_nss_0;
logic hlp_cgmii2_rxclk_ena_nss_0;
logic [127:0] nic_switch_mux_0_hlp_cgmii2_txd_nss;
logic [15:0] nic_switch_mux_0_hlp_cgmii2_txc_nss;
logic hlp_cgmii2_txclk_ena_nss_0;
logic [127:0] hlp_cgmii3_rxd_nss_0;
logic [15:0] hlp_cgmii3_rxc_nss_0;
logic hlp_cgmii3_rxclk_ena_nss_0;
logic [127:0] nic_switch_mux_0_hlp_cgmii3_txd_nss;
logic [15:0] nic_switch_mux_0_hlp_cgmii3_txc_nss;
logic hlp_cgmii3_txclk_ena_nss_0;
logic nic_switch_mux_1_hlp_xlgmii0_txclk_ena;
logic nic_switch_mux_1_hlp_xlgmii0_rxclk_ena;
logic [7:0] nic_switch_mux_1_hlp_xlgmii0_rxc;
logic [63:0] nic_switch_mux_1_hlp_xlgmii0_rxd;
logic nic_switch_mux_1_hlp_xlgmii0_rxt0_next;
logic [7:0] hlp_xlgmii0_txc_1;
logic [63:0] hlp_xlgmii0_txd_1;
logic nic_switch_mux_1_hlp_xlgmii1_txclk_ena;
logic nic_switch_mux_1_hlp_xlgmii1_rxclk_ena;
logic [7:0] nic_switch_mux_1_hlp_xlgmii1_rxc;
logic [63:0] nic_switch_mux_1_hlp_xlgmii1_rxd;
logic nic_switch_mux_1_hlp_xlgmii1_rxt0_next;
logic [7:0] hlp_xlgmii1_txc_1;
logic [63:0] hlp_xlgmii1_txd_1;
logic nic_switch_mux_1_hlp_xlgmii2_txclk_ena;
logic nic_switch_mux_1_hlp_xlgmii2_rxclk_ena;
logic [7:0] nic_switch_mux_1_hlp_xlgmii2_rxc;
logic [63:0] nic_switch_mux_1_hlp_xlgmii2_rxd;
logic nic_switch_mux_1_hlp_xlgmii2_rxt0_next;
logic [7:0] hlp_xlgmii2_txc_1;
logic [63:0] hlp_xlgmii2_txd_1;
logic nic_switch_mux_1_hlp_xlgmii3_txclk_ena;
logic nic_switch_mux_1_hlp_xlgmii3_rxclk_ena;
logic [7:0] nic_switch_mux_1_hlp_xlgmii3_rxc;
logic [63:0] nic_switch_mux_1_hlp_xlgmii3_rxd;
logic nic_switch_mux_1_hlp_xlgmii3_rxt0_next;
logic [7:0] hlp_xlgmii3_txc_1;
logic [63:0] hlp_xlgmii3_txd_1;
logic [127:0] nic_switch_mux_1_hlp_cgmii0_rxd;
logic [15:0] nic_switch_mux_1_hlp_cgmii0_rxc;
logic nic_switch_mux_1_hlp_cgmii0_rxclk_ena;
logic [127:0] hlp_cgmii0_txd_1;
logic [15:0] hlp_cgmii0_txc_1;
logic nic_switch_mux_1_hlp_cgmii0_txclk_ena;
logic [127:0] nic_switch_mux_1_hlp_cgmii1_rxd;
logic [15:0] nic_switch_mux_1_hlp_cgmii1_rxc;
logic nic_switch_mux_1_hlp_cgmii1_rxclk_ena;
logic [127:0] hlp_cgmii1_txd_1;
logic [15:0] hlp_cgmii1_txc_1;
logic nic_switch_mux_1_hlp_cgmii1_txclk_ena;
logic [127:0] nic_switch_mux_1_hlp_cgmii2_rxd;
logic [15:0] nic_switch_mux_1_hlp_cgmii2_rxc;
logic nic_switch_mux_1_hlp_cgmii2_rxclk_ena;
logic [127:0] hlp_cgmii2_txd_1;
logic [15:0] hlp_cgmii2_txc_1;
logic nic_switch_mux_1_hlp_cgmii2_txclk_ena;
logic [127:0] nic_switch_mux_1_hlp_cgmii3_rxd;
logic [15:0] nic_switch_mux_1_hlp_cgmii3_rxc;
logic nic_switch_mux_1_hlp_cgmii3_rxclk_ena;
logic [127:0] hlp_cgmii3_txd_1;
logic [15:0] hlp_cgmii3_txc_1;
logic nic_switch_mux_1_hlp_cgmii3_txclk_ena;
logic mse_physs_port_0_ts_capture_vld;
logic [6:0] mse_physs_port_0_ts_capture_idx;
logic mse_physs_port_1_ts_capture_vld;
logic [6:0] mse_physs_port_1_ts_capture_idx;
logic mse_physs_port_2_ts_capture_vld;
logic [6:0] mse_physs_port_2_ts_capture_idx;
logic mse_physs_port_3_ts_capture_vld;
logic [6:0] mse_physs_port_3_ts_capture_idx;
logic mse_physs_port_4_ts_capture_vld;
logic [6:0] mse_physs_port_4_ts_capture_idx;
logic mse_physs_port_5_ts_capture_vld;
logic [6:0] mse_physs_port_5_ts_capture_idx;
logic mse_physs_port_6_ts_capture_vld;
logic [6:0] mse_physs_port_6_ts_capture_idx;
logic mse_physs_port_7_ts_capture_vld;
logic [6:0] mse_physs_port_7_ts_capture_idx;
logic [14:0] physs_0_AWID;
logic [31:0] physs_0_AWADDR;
logic [7:0] physs_0_AWLEN;
logic [2:0] physs_0_AWSIZE;
logic [1:0] physs_0_AWBURST;
logic physs_0_AWLOCK;
logic [3:0] physs_0_AWCACHE;
logic [2:0] physs_0_AWPROT;
logic physs_0_AWVALID;
logic [31:0] physs_0_WDATA;
logic [3:0] physs_0_WSTRB;
logic physs_0_WLAST;
logic physs_0_WVALID;
logic physs_0_BREADY;
logic [14:0] physs_0_ARID;
logic [31:0] physs_0_ARADDR;
logic [7:0] physs_0_ARLEN;
logic [2:0] physs_0_ARSIZE;
logic [1:0] physs_0_ARBURST;
logic physs_0_ARLOCK;
logic [3:0] physs_0_ARCACHE;
logic [2:0] physs_0_ARPROT;
logic physs_0_ARVALID;
logic nic400_physs_0_awready_slave_physs;
logic nic400_physs_0_wready_slave_physs;
logic physs_0_RREADY;
logic [14:0] nic400_physs_0_bid_slave_physs;
logic [1:0] nic400_physs_0_bresp_slave_physs;
logic nic400_physs_0_bvalid_slave_physs;
logic nic400_physs_0_arready_slave_physs;
logic [14:0] nic400_physs_0_rid_slave_physs;
logic [31:0] nic400_physs_0_rdata_slave_physs;
logic [1:0] nic400_physs_0_rresp_slave_physs;
logic nic400_physs_0_rlast_slave_physs;
logic nic400_physs_0_rvalid_slave_physs;
logic mdio_in;
logic mac100_0_mdc;
logic mac100_0_mdio_out;
logic mac100_0_mdio_oen_0;
logic [1:0] quad_interrupts_0_mac400_int;
logic [1:0] quad_interrupts_1_mac400_int;
logic [3:0] quad_interrupts_0_mac100_int;
logic [3:0] quad_interrupts_1_mac100_int;
logic [1:0] physs_timesync_sync_val;
logic parmisc_int_logic_0_o;
logic [3:0] physs_timestamp_0_o_int;
logic [3:0] physs_timestamp_1_o_int;
logic [6:0] quadpcs100_0_pcs_desk_buf_rlevel_1;
logic [6:0] quadpcs100_0_pcs_desk_buf_rlevel_2;
logic [6:0] quadpcs100_0_pcs_desk_buf_rlevel_3;
logic [6:0] quadpcs100_0_pcs_desk_buf_rlevel_4;
logic [6:0] quadpcs100_1_pcs_desk_buf_rlevel_1;
logic [6:0] quadpcs100_1_pcs_desk_buf_rlevel_2;
logic [6:0] quadpcs100_1_pcs_desk_buf_rlevel_3;
logic [6:0] quadpcs100_1_pcs_desk_buf_rlevel_4;
logic [31:0] parmisc_physs0_chain_rpt_misc0_physs0_end_bus_data_out;
logic parmisc_physs0_chain_rpt_misc0_physs0_end_bus_clock_out;
logic [31:0] parmisc_physs0_chain_rpt_misc0_misc1_end_bus_data_out;
logic parmisc_physs0_chain_rpt_misc0_misc1_end_bus_clock_out;
logic parmquad1_pd_vinf_bisr_so;
logic parmquad1_pd_vinf_bisr_clk_out;
logic parmquad1_pd_vinf_bisr_reset_out;
logic parmquad1_pd_vinf_bisr_shift_en_out;
logic trst_b;
logic tck;
logic tms;
logic tdi;
logic parmisc_physs0_NW_IN_tdo_en;
logic parmisc_physs0_NW_IN_tdo;
logic ijtag_reset_b;
logic ijtag_shift;
logic ijtag_capture;
logic ijtag_update;
logic ijtag_select;
logic ijtag_si;
logic parmisc_physs0_NW_IN_ijtag_so;
logic shift_ir_dr_0;
logic tms_park_value_0;
logic nw_mode_0;
logic parmisc_physs0_NW_IN_tap_sel_out;
logic parmisc_physs1_NW_IN_tdo;
logic parmisc_physs1_NW_IN_tdo_en;
logic parmisc_physs0_NW_OUT_parmisc_physs1_ijtag_to_reset;
logic parmisc_physs0_NW_OUT_parmisc_physs1_ijtag_to_ce;
logic parmisc_physs0_NW_OUT_parmisc_physs1_ijtag_to_se;
logic parmisc_physs0_NW_OUT_parmisc_physs1_ijtag_to_ue;
logic parmisc_physs0_NW_OUT_parmisc_physs1_ijtag_to_sel;
logic parmisc_physs0_NW_OUT_parmisc_physs1_ijtag_to_si;
logic parmisc_physs1_NW_IN_ijtag_so;
logic parmisc_physs1_NW_IN_tap_sel_out;
logic pd_vinf_bisr_si;
logic pd_vinf_bisr_clk;
logic pd_vinf_bisr_reset;
logic pd_vinf_bisr_shift_en;
logic dbg_rx_serial_data;
logic dbg_tx_serial_data;

physs0 physs0(.*);

//physs_bbl.physs0.parmquad0.pcs100_wrap_0.quadpcs100_0.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_0.tbi_tx[9:0]
assign physs0.parmquad0.pcs100_wrap_0.quadpcs100_0.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_0.clk_eth_ref_125mhz = clk_125mhz;
assign physs0.parmquad0.pcs100_wrap_0.quadpcs100_0.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_0.reference_clk = reference_clk;
assign physs0.parmquad0.pcs100_wrap_0.quadpcs100_0.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_0.i_reset = i_reset;
assign physs0.parmquad0.pcs100_wrap_0.quadpcs100_0.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_0.rx_serial_data = rx_serial_data;
assign tx_serial_data = physs0.parmquad0.pcs100_wrap_0.quadpcs100_0.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_0.tx_serial_data;
//assign physs0.parquad0.pcs100_wrap_0.quadpcs100_0.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_0.sgpcs_ena = 1 ;
assign physs_eth.physs0.parmquad0.physs_registers_wrapper_0.physs_common_registers_0.pcs100_sgmii0_reg_sg0_sgpcs_ena = 1;
//assign physs_eth.physs0.physs_tb.physs.parquad0.pcs100_wrap_0.physs_pcs_mux_0_srds_rdy_out_100G[3:0] = 1;
//assign dbg_rx_serial_data = physs0.parmquad0.pcs100_wrap_0.quadpcs100_0.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_0.rx_serial_data;
//assign dbg_tx_serial_data = physs0.parmquad0.pcs100_wrap_0.quadpcs100_0.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_0.tx_serial_data;

//initial
//begin
////Added by Lokesh
//assign physs0.parquad0.pcs100_wrap_0.quadpcs100_0.sg0_sgpcs_ena_s =1;
//end

//Physs I2C registers interface

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

    //logic           i2c_smbalert_in_n   ;   //  SMBUS alert in
    //logic           i2c_smbalert_oe_n   ;   //  SMBUS Alert out

    //logic           i2c_smbsus_in_n     ;

    //logic           intr_i2c            ;   //  Combined Interrupt
    //logic           I2C_SDA            ;   
    //logic           I2C_SCL            ;   

//tristate_buf tristate_inst0(.in (XX_SPI_TXD[0]),.oe (~i2c_clk_oe),.out(i2c_clk_in),.pad(SCL));
//tristate_buf tristate_inst0(.in (XX_SPI_TXD[0]),.oe (~i2c_data_oe),.out(i2c_data_in),.pad(SDA));

//assign soc_tb.iodie_0.XX_MBP3_N_I3C_SDA = (hvm_enabled & hvm_data_bus_enable_d1[680]) ? hvm_data_bus_drive_d1[680] : 'z;
//assign I2C_SDA = (i2c_data_oe) ? i2c_data_in : 'z;
//assign I2C_SCL = (i2c_clock_oe) ? i2c_clock_in : 'z;

//assign I2C_SDA = i2c_data_oe ?  1’b0 : 1’bz ;
//assign i2c_data_in = I2C_SDA;    
//assign I2C_SCL = i2c_clk_oe ?  1’b0 : 1’bz ;
//assign i2c_clock_in = I2C_SCL;    
 
tristate_buf tristate_inst0(.in (1'b0),.oe (i2c_clk_oe),.out(i2c_clk_in),.pad(I2C_SCL));
tristate_buf tristate_inst1(.in (1'b0),.oe (i2c_data_oe),.out(i2c_data_in),.pad(I2C_SDA));

RED_VAPB #(
      .APB_ADDRESS_WIDTH   ( 12           ),
      .APB_DATA_WIDTH      ( 32           ),
      .DUT_CLK_PROVIDED    ( 1            )
    ) phy_i2c_vapb_master (
       // APB interface
      .u_apb_pclk          (  i2c_apb_clk     ), 
      .u_apb_presetn       (  physs_func_rst_raw_n  ), 
      .u_apb_psel          (  i2c_psel     ), 
      .u_apb_penable       (  i2c_penable  ), 
      .u_apb_pwrite        (  i2c_pwrite   ), 
      .u_apb_paddr         (  i2c_paddr    ), 
      .u_apb_pwdata        (  i2c_pwdata   ), 
      .u_apb_prdata        (  i2c_prdata   ), 
      .u_apb_pready        (  i2c_pready   ), 
      .u_apb_pslverr       (  i2c_pslverr  ), 
                                               
      .dut_apb_pclk        ( i2c_apb_clk ),
      .dut_apb_presetn     ( physs_func_rst_raw_n )
  );

   Imc_DW_apb_i2c
        A00_i2c (
        .pclk               (   i2c_apb_clk             ),  //  APB Clock Signal
        .presetn            (   physs_func_rst_raw_n  ),  //  APB Reset Signal (active low)
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
        .ic_rst_n           (   physs_func_rst_raw_n  ),
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
      .u_apb_presetn       (  physs_func_rst_raw_n  ), 
      .u_apb_psel          (  apb_psel     ), 
      .u_apb_penable       (  apb_penable  ), 
      .u_apb_pwrite        (  apb_pwrite   ), 
      .u_apb_paddr         (  apb_paddr    ), 
      .u_apb_pwdata        (  apb_pwdata   ), 
      .u_apb_prdata        (  apb_prdata   ), 
      .u_apb_pready        (  apb_pready   ), 
      .u_apb_pslverr       (  apb_pslverr  ), 
                                               
      .dut_apb_pclk        ( i2c_apb_clk ),
      .dut_apb_presetn     ( physs_func_rst_raw_n )
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
      .apb_reset            (~physs_func_rst_raw_n),   
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

endmodule
