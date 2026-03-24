/*------------------------------------------------------------------------------
  INTEL CONFIDENTIAL
  Copyright 2022 Intel Corporation All Rights Reserved.
  -----------------------------------------------------------------------------*/

module physs_bbl
// EDIT_PORT BEGIN
 // CDC: Added read clock inputs for XLGMII CDC wrappers (one per quad)
 (
input rd_clk_mquad0,   // Read clock for MQUAD0 XLGMII CDC
input rd_clk_mquad1,   // Read clock for MQUAD1 XLGMII CDC
input rd_clk_pquad,    // Read clock for PQUAD0 XLGMII CDC
input rd_clk_pquad1,   // Read clock for PQUAD1 XLGMII CDC
input tck,
output tap_sel_in,
input trst_b,
input tdi,
input tms,
input tms_park_value,
output tdo,
output tdo_en,
input ijtag_reset_b,
input ijtag_shift,
input ijtag_capture,
input ijtag_update,
input ijtag_select,
input ijtag_si,
output ijtag_so,
input [31:0] ssn_bus_data_in,
input ssn_bus_clock_in,
output ssn_bus_clock_out,
output [31:0] ssn_bus_data_out,
input shift_ir_dr,
input nw_mode,
output DIAG_AGGR_parmisc0_mbist_diag_done,
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
input BSCAN_PIPE_IN_1_intel_d6actestsig_b,
output BSCAN_PIPE_OUT_1_scan_out,
input [19:0] PHYSS_BSCAN_BYPASS,
input pd_vinf_0_bisr_shift_en,
input pd_vinf_0_bisr_si,
input pd_vinf_0_bisr_clk,
input pd_vinf_0_bisr_reset,
output pd_vinf_0_bisr_so,
input pd_vinf_1_bisr_shift_en,
input pd_vinf_1_bisr_reset,
output pd_vinf_1_bisr_so,
input pd_vinf_1_bisr_si,
input pd_vinf_1_bisr_clk,
output pd_vinf_2_bisr_so,
input pd_vinf_2_bisr_clk,
input pd_vinf_2_bisr_reset,
input pd_vinf_2_bisr_shift_en,
input pd_vinf_2_bisr_si,
input pd_vinf_3_bisr_shift_en,
input pd_vinf_3_bisr_si,
input pd_vinf_3_bisr_reset,
input pd_vinf_3_bisr_clk,
output pd_vinf_3_bisr_so,
input pd_vinf_4_bisr_clk,
input pd_vinf_4_bisr_reset,
input pd_vinf_4_bisr_shift_en,
output pd_vinf_4_bisr_so,
input pd_vinf_4_bisr_si,
output pd_vinf_5_bisr_so,
input pd_vinf_5_bisr_reset,
input pd_vinf_5_bisr_shift_en,
input pd_vinf_5_bisr_clk,
input pd_vinf_5_bisr_si,
input pd_vinf_6_bisr_shift_en,
input pd_vinf_6_bisr_reset,
output pd_vinf_6_bisr_so,
input pd_vinf_6_bisr_clk,
input pd_vinf_6_bisr_si,
input fary_post_force_fail,
input fary_0_trigger_post,
input [5:0] fary_post_algo_select,
output aary_0_post_pass,
output aary_0_post_complete,
input fary_1_trigger_post,
output aary_1_post_pass,
output aary_1_post_complete,
input fary_2_trigger_post,
output aary_2_post_pass,
output aary_2_post_complete,
input fary_3_trigger_post,
output aary_3_post_pass,
output aary_3_post_complete,
input fary_4_trigger_post,
output aary_4_post_pass,
output aary_4_post_complete,
input fary_5_trigger_post,
output aary_5_post_pass,
output aary_5_post_complete,
input fary_6_trigger_post,
output aary_6_post_pass,
output aary_6_post_complete,
input fary_7_trigger_post,
output aary_7_post_pass,
output aary_7_post_complete,
input fary_8_trigger_post,
output aary_8_post_pass,
output aary_8_post_complete,
input fary_9_trigger_post,
output aary_9_post_pass,
output aary_9_post_complete,
input fary_10_trigger_post,
output aary_10_post_pass,
output aary_10_post_complete,
input [7:0] dfxagg_security_policy,
input dfxagg_policy_update,
input dfxagg_early_boot_debug_exit,
input [7:0] dfxagg_debug_capabilities_enabling,
input dfxagg_debug_capabilities_enabling_valid,
input fdfx_powergood,
input physs0_func_rst_raw_n, //functional reset to PHYSS0 (LINKR). Should use for MEM init
input physs1_func_rst_raw_n, //functional reset to PHYSS1 (LINKR). Should use for MEM init
input physs_reset_prep_req, //Request to PHYSS to prepare before CORE reset for clearing the pipe interface with mse.
output physs_reset_prep_ack, //Acknowledge from PHYSS that the interface is ready for CORE reset
input tsu_clk, //PCS and MAC data path clock (800.00MHz)
input nss_cosq_clk0, //Fifo interface clk of MAC for mquad0 (800.00MHz)
input nss_cosq_clk1, //Fifo interface clk of MAC for mquad1 (800.00MHz)
input physs_funcx2_clk, //MAC and PCS clock for 800 Mhz operaion (1.6 Ghz)
input physs_intf0_clk, //MAC Interface clock (1.35Ghz)
output physs_intf0_clk_out, //MAC Interface clock routed to cosq(1.35Ghz)
input soc_per_clk, //control and configuration clock (112.5MHz)
output [1:0] physs_synce_rxclk, //Rx recovered clock divided for syncE . Expose 2 clocks selected from 8 lanes when link is stable. The maximum frequancy of this clock is 150Mhz
input clk_1588_freq, //1588_freq_out generated from NSS.MTS module from CPK. Muxed with recovered serdes clks to output on synce_rxclk[1:0]
input fscan_txrxword_byp_clk, //txrx dfx input clock (830.078125MHz)
input fscan_ref_clk, //dfx scan input clock (156.25MHz)
input ethphyss_post_clkungate, //clkgate override ctrl logic
input ethphyss_post_clk_mux_ctrl, //reset override post dft run logic
inout eref0_pad_clk_p, //Differential signal along with ref0_pad_clk_p. Reference clock bumped to SERDES. STAR connected at PKG with ref0_pad_clk_p
inout eref0_pad_clk_n, //Differential signal along with ref0_pad_clk_m. Reference clock bumped to SERDES. STAR connected at PKG with ref0_pad_clk_m
inout syncE_pad_clk_p, //Differential signal along with ref1_pad_clk_p. Reference clock bumped to SERDES. STAR connected at PKG with ref1_pad_clk_p
inout syncE_pad_clk_n, //Differential signal along with ref1_pad_clk_m. Reference clock bumped to SERDES. STAR connected at PKG with ref1_pad_clk_m
input rclk_diff_p, //on die differential signal _p
input rclk_diff_n, //on die differential signal _n
output [1:0] physs_clkobs_out_clk, //Output clock for observation
output ETH_TXP0, //Serdes analog transmit
output ETH_TXN0, //Serdes analog transmit
output ETH_TXP1, //Serdes analog transmit
output ETH_TXN1, //Serdes analog transmit
output ETH_TXP2, //Serdes analog transmit
output ETH_TXN2, //Serdes analog transmit
output ETH_TXP3, //Serdes analog transmit
output ETH_TXN3, //Serdes analog transmit
output ETH_TXP4, //Serdes analog transmit
output ETH_TXN4, //Serdes analog transmit
output ETH_TXP5, //Serdes analog transmit
output ETH_TXN5, //Serdes analog transmit
output ETH_TXP6, //Serdes analog transmit
output ETH_TXN6, //Serdes analog transmit
output ETH_TXP7, //Serdes analog transmit
output ETH_TXN7, //Serdes analog transmit
input ETH_RXP0, //Serdes analog receive
input ETH_RXN0, //Serdes analog receive
input ETH_RXP1, //Serdes analog receive
input ETH_RXN1, //Serdes analog receive
input ETH_RXP2, //Serdes analog receive
input ETH_RXN2, //Serdes analog receive
input ETH_RXP3, //Serdes analog receive
input ETH_RXN3, //Serdes analog receive
input ETH_RXP4, //Serdes analog receive
input ETH_RXN4, //Serdes analog receive
input ETH_RXP5, //Serdes analog receive
input ETH_RXN5, //Serdes analog receive
input ETH_RXP6, //Serdes analog receive
input ETH_RXN6, //Serdes analog receive
input ETH_RXP7, //Serdes analog receive
input ETH_RXN7, //Serdes analog receive
output ETH_TXP8, //Serdes analog transmit
output ETH_TXN8, //Serdes analog transmit
output ETH_TXP9, //Serdes analog transmit
output ETH_TXN9, //Serdes analog transmit
output ETH_TXP10, //Serdes analog transmit
output ETH_TXN10, //Serdes analog transmit
output ETH_TXP11, //Serdes analog transmit
output ETH_TXN11, //Serdes analog transmit
output ETH_TXP12, //Serdes analog transmit
output ETH_TXN12, //Serdes analog transmit
output ETH_TXP13, //Serdes analog transmit
output ETH_TXN13, //Serdes analog transmit
output ETH_TXP14, //Serdes analog transmit
output ETH_TXN14, //Serdes analog transmit
output ETH_TXP15, //Serdes analog transmit
output ETH_TXN15, //Serdes analog transmit
input ETH_RXP8, //Serdes analog receive
input ETH_RXN8, //Serdes analog receive
input ETH_RXP9, //Serdes analog receive
input ETH_RXN9, //Serdes analog receive
input ETH_RXP10, //Serdes analog receive
input ETH_RXN10, //Serdes analog receive
input ETH_RXP11, //Serdes analog receive
input ETH_RXN11, //Serdes analog receive
input ETH_RXP12, //Serdes analog receive
input ETH_RXN12, //Serdes analog receive
input ETH_RXP13, //Serdes analog receive
input ETH_RXN13, //Serdes analog receive
input ETH_RXP14, //Serdes analog receive
input ETH_RXN14, //Serdes analog receive
input ETH_RXP15, //Serdes analog receive
input ETH_RXN15, //Serdes analog receive
inout [15:0] xioa_ck_pma_ref0_n, //Differential reference clock0 bump/pad. negative leg
inout [15:0] xioa_ck_pma_ref0_p, //Differential reference clock0 bump/pad. positive leg
inout [13:0] xioa_ck_pma_ref1_n, //Differential reference clock1 bump/pad. negative leg
inout [13:0] xioa_ck_pma_ref1_p, //Differential reference clock1 bump/pad. positive leg
output [15:0] xoa_pma_dcmon1, //Aprobe bump /pad #1. Refer to aprobe recommendations section of the HAS
output [15:0] xoa_pma_dcmon2, //Aprobe bump/pad #2. Refer to aprobe recommendations section of the HAS
input [3:0] physs_0_AWID, //Write Address ID
input [31:0] physs_0_AWADDR, //Write Address
input [7:0] physs_0_AWLEN, //Burst Length
input [2:0] physs_0_AWSIZE, //b
input [1:0] physs_0_AWBURST, //Burst Type
input physs_0_AWLOCK, //Lock Type
input [3:0] physs_0_AWCACHE, //Memory Type
input [2:0] physs_0_AWPROT, //Protection Type
input physs_0_AWVALID, //Write Address Valid
output physs_0_AWREADY, //Write Address Readu
input [31:0] physs_0_WDATA, //Write data
input [3:0] physs_0_WSTRB, //Write strobe
input physs_0_WLAST, //Write last
input physs_0_WVALID, //Write valid
output physs_0_WREADY, //Write ready
output [3:0] physs_0_BID, //Response ID Tag
output [1:0] physs_0_BRESP, //Write Response
output physs_0_BVALID, //Write response valid
input physs_0_BREADY, //Response ready
input [3:0] physs_0_ARID, //Read Address ID
input [31:0] physs_0_ARADDR, //Read Address
input [7:0] physs_0_ARLEN, //Burst Length
input [2:0] physs_0_ARSIZE, //Burst Size
input [1:0] physs_0_ARBURST, //Burst Type
input physs_0_ARLOCK, //Lock Type
input [3:0] physs_0_ARCACHE, //Memory Type
input [2:0] physs_0_ARPROT, //Protection Type
input physs_0_ARVALID, //Read Address Valid
output physs_0_ARREADY, //Read Address Ready
output [3:0] physs_0_RID, //Read ID tag
output [31:0] physs_0_RDATA, //Read data
output [1:0] physs_0_RRESP, //Read response
output physs_0_RLAST, //Read last
output physs_0_RVALID, //Read valid
input physs_0_RREADY, //Read ready
input [3:0] physs_1_AWID, //Write Address ID
input [31:0] physs_1_AWADDR, //Write Address
input [7:0] physs_1_AWLEN, //Burst Length
input [2:0] physs_1_AWSIZE, //b
input [1:0] physs_1_AWBURST, //Burst Type
input physs_1_AWLOCK, //Lock Type
input [3:0] physs_1_AWCACHE, //Memory Type
input [2:0] physs_1_AWPROT, //Protection Type
input physs_1_AWVALID, //Write Address Valid
output physs_1_AWREADY, //Write Address Readu
input [31:0] physs_1_WDATA, //Write data
input [3:0] physs_1_WSTRB, //Write strobe
input physs_1_WLAST, //Write last
input physs_1_WVALID, //Write valid
output physs_1_WREADY, //Write ready
output [3:0] physs_1_BID, //Response ID Tag
output [1:0] physs_1_BRESP, //Write Response
output physs_1_BVALID, //Write response valid
input physs_1_BREADY, //Response ready
input [3:0] physs_1_ARID, //Read Address ID
input [31:0] physs_1_ARADDR, //Read Address
input [7:0] physs_1_ARLEN, //Burst Length
input [2:0] physs_1_ARSIZE, //Burst Size
input [1:0] physs_1_ARBURST, //Burst Type
input physs_1_ARLOCK, //Lock Type
input [3:0] physs_1_ARCACHE, //Memory Type
input [2:0] physs_1_ARPROT, //Protection Type
input physs_1_ARVALID, //Read Address Valid
output physs_1_ARREADY, //Read Address Ready
output [3:0] physs_1_RID, //Read ID tag
output [31:0] physs_1_RDATA, //Read data
output [1:0] physs_1_RRESP, //Read response
output physs_1_RLAST, //Read last
output physs_1_RVALID, //Read valid
input physs_1_RREADY, //Read ready
output physs_icq_port_0_link_stat, //indicate link UP status per port
output [3:0] physs_mse_port_0_link_speed, //4 wires for each of 8 ports. Indicate speed when link UP status is asserted -per port.0 - 10Mbps1 - 100Mbps2 - 1Gbps3 - 2.5Gbps4 - 5Gbps5 - 10Gbps6 - Reserved7 - 25Gbps8 - 40Gbps9 - 50Gbps10 - 100Gbps11 - 200Gbps12 - 400Gbpsother - reserved.
output physs_mse_port_0_rx_dval, //Receive Data Valid
output [1023:0] physs_mse_port_0_rx_data, //receive data rx_data[1023:0] are valid in 400G mode or 200G mode at Port0. receive data rx_data[511:0] are valid in 200G mode at Port2/4. receive data rx_data[255:0] are valid in 100/50/25/10G mode. Port0 use 1024 bits for 400g. 512 bitsfor200g or 256 bits for 100g and lower speeds. Port2/4 use 512 bits for 200g or 256 bits for 100g and lower speeds. Ports 1/3/5/6/7 are always 256 bits data width
output physs_mse_port_0_rx_sop, //Receive Start of Frame
output physs_mse_port_0_rx_eop, //Receive End of Frame
output [6:0] physs_mse_port_0_rx_mod, //Receive End Word Modulo. Only meaningful when eop signal is valid. Indicates which portion of the rx_data is valid. rx_mod[6:0] ( 400G / 200G Port0). 7'b0000000 : rx_data[1023:0] is valid. 7'b0000001 : rx_data[7:0] is valid. 7'b0000010 : rx_data[15:0] is valid. 7'b1111111:rx_data[1015:0] is valid. rx_mod[5:0] ( 200G ). 6'b000000 : rx_data[511:0] is valid. 6'b000001 : rx_data[7:0] is valid. 6'b000010 : rx_data[15:0] is valid. 6'b111111:rx_data[503:0] is valid. rx_mod[4:0] ( 100G or below ). 5'b00000 : rx_data[255:0] is valid. 5'b00001 : rx_data[7:0] is valid. 5'b00010 : rx_data[15:0] is valid. 5'b11111:rx_data[247:0] is valid
output physs_mse_port_0_rx_err, //Receive frame error ( This is set when there is any type of error within the frame include L2 FCS Error )
output physs_mse_port_0_rx_ecc_err, //Receive L2 FCS Error ( this bit is only set when there is L2 FCS error )
input mse_physs_port_0_rx_rdy, //Receive Application Ready. Asserted (set to 1) by the Receive application to indicate it is ready to receive Data from the MAC. With the direct interface when the signal deasserts within frame receive the MAC will truncate the frame and eventually set receive frame error
output [39:0] physs_mse_port_0_rx_ts, //Receive Timestamp Value. Time when the MAC detected the SFD of the frame and latched the mac00N_frc_in_rx value. Only meaningful when sop is valid. On ingress contains the 1588 ingress timestamp: Bits [39:8] - 32b timestamp in nano seconds. Bits [7:1] - 7b timestamp in sub-nano seconds. Bit 0 - 1b of valid for TIMESTAMP
input mse_physs_port_0_tx_wren, //Transmit Data Write Enable
input [1023:0] mse_physs_port_0_tx_data, //Transmit data rx_data[1023:0] are valid in 400G mode and 200G mode at Port 0. Transmit data rx_data[511:0] are valid in 200G mode at Ports2/4. Transmit data rx_data[255:0] are valid in 100/50/25/10G mode. Port0 use 1024 bits for 400g. 512 bits for 200g or 256 bits for 100g and lower speeds. Port2/4 use 512 bits for 200g or 256 bits for 100g and lower speeds. Ports 1/3/5/6/7 are always 256 bits data width
input mse_physs_port_0_tx_sop, //Transmit Start of Frame
input mse_physs_port_0_tx_eop, //Transmit End of Frame
input [6:0] mse_physs_port_0_tx_mod, //Transmit End Word Modulo. Only meaningful when tx_eop is valid. Indicates which portion of the ff00N_tx_data is valid. tx_mod[6:0] (400G mode / 200G at Port0). 7'b000000 : tx_data[1023:0] is valid. 7'b000001 : tx_data[7:0] is valid. 7'b000010 : tx_data[15:0] is valid. 7'b111111 : tx_data[1015:0] is valid. tx_mod[5:0] ( 200G mode at Ports2/4 ). 6'b000000 : tx_data[511:0] is valid. 6'b000001 : tx_data[7:0] is valid. 6'b000010 : tx_data[15:0] is valid. 6'b111111:tx_data[503:0] is valid. tx_mod[4:0] ( 100G or below ). 5'b00000 : tx_data[255:0] is valid. 5'b00001 : tx_data[7:0] is valid. 5'b00010 : tx_data[15:0] is valid. 5'b11111 : tx_data[247:0] is valid
input mse_physs_port_0_tx_err, //Transmit Frame Error. Asserted with the frames final segment to indicate that the transmitted frame is invalid. Only meaningful whentx_eopis valid. Whentx_erris asserted the frame is transmitted to the CDMII interface with a transmit error (invalid CRC)
input mse_physs_port_0_tx_crc, //Transmit CRC Append. If set a CRC field the MAC will be appended to the frame. If cleared the MAC does not append a FCS to the frame
output physs_mse_port_0_tx_rdy, //Transmit FIFO ready. mse can write words into the FIFO only when this signal is asserted (1). When 0 application should stop writing latest after 2 cycles
output physs_icq_port_1_link_stat, //indicate link UP status per port
output [3:0] physs_mse_port_1_link_speed, //4 wires for each of 8 ports. Indicate speed when link UP status is asserted -per port.0 - 10Mbps1 - 100Mbps2 - 1Gbps3 - 2.5Gbps4 - 5Gbps5 - 10Gbps6 - Reserved7 - 25Gbps8 - 40Gbps9 - 50Gbps10 - 100Gbps11 - 200Gbps12 - 400Gbpsother - reserved.
output physs_mse_port_1_rx_dval, //Receive Data Valid
output [255:0] physs_mse_port_1_rx_data, //receive data rx_data[1023:0] are valid in 400G mode or 200G mode at Port0. receive data rx_data[511:0] are valid in 200G mode at Port2/4. receive data rx_data[255:0] are valid in 100/50/25/10G mode. Port0 use 1024 bits for 400g.512 bitsfor200gor 256 bits for 100g and lower speeds. Port2/4 use 512 bits for 200g or 256 bits for 100g and lower speeds. Ports 1/3/5/6/7 are always 256 bits data width
output physs_mse_port_1_rx_sop, //Receive Start of Frame
output physs_mse_port_1_rx_eop, //Receive End of Frame
output [4:0] physs_mse_port_1_rx_mod, //Receive End Word Modulo. Only meaningful when eop signal is valid. Indicates which portion of the rx_data is valid. rx_mod[6:0] ( 400G / 200G Port0). 7'b0000000 : rx_data[1023:0] is valid. 7'b0000001 : rx_data[7:0] is valid. 7'b0000010 : rx_data[15:0] is valid. 7'b1111111:rx_data[1015:0] is valid. rx_mod[5:0] ( 200G ). 6'b000000 : rx_data[511:0] is valid. 6'b000001 : rx_data[7:0] is valid. 6'b000010 : rx_data[15:0] is valid. 6'b111111:rx_data[503:0] is valid. rx_mod[4:0] ( 100G or below ). 5'b00000 : rx_data[255:0] is valid. 5'b00001 : rx_data[7:0] is valid. 5'b00010 : rx_data[15:0] is valid. 5'b11111:rx_data[247:0] is valid
output physs_mse_port_1_rx_err, //Receive frame error ( This is set when there is any type of error within the frame include L2 FCS Error )
output physs_mse_port_1_rx_ecc_err, //Receive L2 FCS Error ( this bit is only set when there is L2 FCS error )
input mse_physs_port_1_rx_rdy, //Receive Application Ready. Asserted (set to 1) by the Receive application to indicate it is ready to receive Data from the MAC. With the direct interface when the signal deasserts within frame receive the MAC will truncate the frame and eventually set receive frame error
output [39:0] physs_mse_port_1_rx_ts, //Receive Timestamp Value. Time when the MAC detected the SFD of the frame and latched the mac00N_frc_in_rx value. Only meaningful when sop is valid. On ingress contains the 1588 ingress timestamp: Bits [39:8] - 32b timestamp in nano seconds. Bits [7:1] - 7b timestamp in sub-nano seconds. Bit 0 - 1b of valid for TIMESTAMP
input mse_physs_port_1_tx_wren, //Transmit Data Write Enable
input [255:0] mse_physs_port_1_tx_data, //Transmit data rx_data[1023:0] are valid in 400G mode and 200G mode at Port 0. Transmit data rx_data[511:0] are valid in 200G mode at Ports2/4. Transmit data rx_data[255:0] are valid in 100/50/25/10G mode. Port0 use 1024 bits for 400g. 512 bits for 200g or 256 bits for 100g and lower speeds. Port2/4 use 512 bits for 200g or 256 bits for 100g and lower speeds. Ports 1/3/5/6/7 are always 256 bits data width
input mse_physs_port_1_tx_sop, //Transmit Start of Frame
input mse_physs_port_1_tx_eop, //Transmit End of Frame
input [4:0] mse_physs_port_1_tx_mod, //Transmit End Word Modulo. Only meaningful when tx_eop is valid. Indicates which portion of the ff00N_tx_data is valid. tx_mod[6:0] (400G mode / 200G at Port0). 7'b000000 : tx_data[1023:0] is valid. 7'b000001 : tx_data[7:0] is valid. 7'b000010 : tx_data[15:0] is valid. 7'b111111 : tx_data[1015:0] is valid. tx_mod[5:0] ( 200G mode at Ports2/4 ). 6'b000000 : tx_data[511:0] is valid. 6'b000001 : tx_data[7:0] is valid. 6'b000010 : tx_data[15:0] is valid. 6'b111111:tx_data[503:0] is valid. tx_mod[4:0] ( 100G or below ). 5'b00000 : tx_data[255:0] is valid. 5'b00001 : tx_data[7:0] is valid. 5'b00010 : tx_data[15:0] is valid. 5'b11111 : tx_data[247:0] is valid
input mse_physs_port_1_tx_err, //Transmit Frame Error. Asserted with the frames final segment to indicate that the transmitted frame is invalid. Only meaningful whentx_eopis valid. Whentx_erris asserted the frame is transmitted to the CDMII interface with a transmit error (invalid CRC)
input mse_physs_port_1_tx_crc, //Transmit CRC Append. If set a CRC field the MAC will be appended to the frame. If cleared the MAC does not append a FCS to the frame
output physs_mse_port_1_tx_rdy, //Transmit FIFO ready. mse can write words into the FIFO only when this signal is asserted (1). When 0 application should stop writing latest after 2 cycles
output physs_icq_port_2_link_stat, //indicate link UP status per port
output [3:0] physs_mse_port_2_link_speed, //4 wires for each of 8 ports. Indicate speed when link UP status is asserted -per port.0 - 10Mbps1 - 100Mbps2 - 1Gbps3 - 2.5Gbps4 - 5Gbps5 - 10Gbps6 - Reserved7 - 25Gbps8 - 40Gbps9 - 50Gbps10 - 100Gbps11 - 200Gbps12 - 400Gbpsother - reserved.
output physs_mse_port_2_rx_dval, //Receive Data Valid
output [511:0] physs_mse_port_2_rx_data, //receive data rx_data[1023:0] are valid in 400G mode or 200G mode at Port0. receive data rx_data[511:0] are valid in 200G mode at Port2/4. receive data rx_data[255:0] are valid in 100/50/25/10G mode. Port0 use 1024 bits for 400g.512 bitsfor200gor 256 bits for 100g and lower speeds. Port2/4 use 512 bits for 200g or 256 bits for 100g and lower speeds. Ports 1/3/5/6/7 are always 256 bits data width
output physs_mse_port_2_rx_sop, //Receive Start of Frame
output physs_mse_port_2_rx_eop, //Receive End of Frame
output [5:0] physs_mse_port_2_rx_mod, //Receive End Word Modulo. Only meaningful when eop signal is valid. Indicates which portion of the rx_data is valid. rx_mod[6:0] ( 400G / 200G Port0). 7'b0000000 : rx_data[1023:0] is valid. 7'b0000001 : rx_data[7:0] is valid. 7'b0000010 : rx_data[15:0] is valid. 7'b1111111:rx_data[1015:0] is valid. rx_mod[5:0] ( 200G ). 6'b000000 : rx_data[511:0] is valid. 6'b000001 : rx_data[7:0] is valid. 6'b000010 : rx_data[15:0] is valid. 6'b111111:rx_data[503:0] is valid. rx_mod[4:0] ( 100G or below ). 5'b00000 : rx_data[255:0] is valid. 5'b00001 : rx_data[7:0] is valid. 5'b00010 : rx_data[15:0] is valid. 5'b11111:rx_data[247:0] is valid
output physs_mse_port_2_rx_err, //Receive frame error ( This is set when there is any type of error within the frame include L2 FCS Error )
output physs_mse_port_2_rx_ecc_err, //Receive L2 FCS Error ( this bit is only set when there is L2 FCS error )
input mse_physs_port_2_rx_rdy, //Receive Application Ready. Asserted (set to 1) by the Receive application to indicate it is ready to receive Data from the MAC. With the direct interface when the signal deasserts within frame receive the MAC will truncate the frame and eventually set receive frame error
output [39:0] physs_mse_port_2_rx_ts, //Receive Timestamp Value. Time when the MAC detected the SFD of the frame and latched the mac00N_frc_in_rx value. Only meaningful when sop is valid. On ingress contains the 1588 ingress timestamp: Bits [39:8] - 32b timestamp in nano seconds. Bits [7:1] - 7b timestamp in sub-nano seconds. Bit 0 - 1b of valid for TIMESTAMP
input mse_physs_port_2_tx_wren, //Transmit Data Write Enable
input [511:0] mse_physs_port_2_tx_data, //Transmit data rx_data[1023:0] are valid in 400G mode and 200G mode at Port 0. Transmit data rx_data[511:0] are valid in 200G mode at Ports2/4. Transmit data rx_data[255:0] are valid in 100/50/25/10G mode. Port0 use 1024 bits for 400g. 512 bits for 200g or 256 bits for 100g and lower speeds. Port2/4 use 512 bits for 200g or 256 bits for 100g and lower speeds. Ports 1/3/5/6/7 are always 256 bits data width
input mse_physs_port_2_tx_sop, //Transmit Start of Frame
input mse_physs_port_2_tx_eop, //Transmit End of Frame
input [5:0] mse_physs_port_2_tx_mod, //Transmit End Word Modulo. Only meaningful when tx_eop is valid. Indicates which portion of the ff00N_tx_data is valid. tx_mod[6:0] (400G mode / 200G at Port0). 7'b000000 : tx_data[1023:0] is valid. 7'b000001 : tx_data[7:0] is valid. 7'b000010 : tx_data[15:0] is valid. 7'b111111 : tx_data[1015:0] is valid. tx_mod[5:0] ( 200G mode at Ports2/4 ). 6'b000000 : tx_data[511:0] is valid. 6'b000001 : tx_data[7:0] is valid. 6'b000010 : tx_data[15:0] is valid. 6'b111111:tx_data[503:0] is valid. tx_mod[4:0] ( 100G or below ). 5'b00000 : tx_data[255:0] is valid. 5'b00001 : tx_data[7:0] is valid. 5'b00010 : tx_data[15:0] is valid. 5'b11111 : tx_data[247:0] is valid
input mse_physs_port_2_tx_err, //Transmit Frame Error. Asserted with the frames final segment to indicate that the transmitted frame is invalid. Only meaningful whentx_eopis valid. Whentx_erris asserted the frame is transmitted to the CDMII interface with a transmit error (invalid CRC)
input mse_physs_port_2_tx_crc, //Transmit CRC Append. If set a CRC field the MAC will be appended to the frame. If cleared the MAC does not append a FCS to the frame
output physs_mse_port_2_tx_rdy, //Transmit FIFO ready. mse can write words into the FIFO only when this signal is asserted (1). When 0 application should stop writing latest after 2 cycles
output physs_icq_port_3_link_stat, //indicate link UP status per port
output [3:0] physs_mse_port_3_link_speed, //4 wires for each of 8 ports. Indicate speed when link UP status is asserted -per port.0 - 10Mbps1 - 100Mbps2 - 1Gbps3 - 2.5Gbps4 - 5Gbps5 - 10Gbps6 - Reserved7 - 25Gbps8 - 40Gbps9 - 50Gbps10 - 100Gbps11 - 200Gbps12 - 400Gbpsother - reserved.
output physs_mse_port_3_rx_dval, //Receive Data Valid
output [255:0] physs_mse_port_3_rx_data, //receive data rx_data[1023:0] are valid in 400G mode or 200G mode at Port0. receive data rx_data[511:0] are valid in 200G mode at Port2/4. receive data rx_data[255:0] are valid in 100/50/25/10G mode. Port0 use 1024 bits for 400g.512 bitsfor200gor 256 bits for 100g and lower speeds. Port2/4 use 512 bits for 200g or 256 bits for 100g and lower speeds. Ports 1/3/5/6/7 are always 256 bits data width
output physs_mse_port_3_rx_sop, //Receive Start of Frame
output physs_mse_port_3_rx_eop, //Receive End of Frame
output [4:0] physs_mse_port_3_rx_mod, //Receive End Word Modulo. Only meaningful when eop signal is valid. Indicates which portion of the rx_data is valid. rx_mod[6:0] ( 400G / 200G Port0). 7'b0000000 : rx_data[1023:0] is valid. 7'b0000001 : rx_data[7:0] is valid. 7'b0000010 : rx_data[15:0] is valid. 7'b1111111:rx_data[1015:0] is valid. rx_mod[5:0] ( 200G ). 6'b000000 : rx_data[511:0] is valid. 6'b000001 : rx_data[7:0] is valid. 6'b000010 : rx_data[15:0] is valid. 6'b111111:rx_data[503:0] is valid. rx_mod[4:0] ( 100G or below ). 5'b00000 : rx_data[255:0] is valid. 5'b00001 : rx_data[7:0] is valid. 5'b00010 : rx_data[15:0] is valid. 5'b11111:rx_data[247:0] is valid
output physs_mse_port_3_rx_err, //Receive frame error ( This is set when there is any type of error within the frame include L2 FCS Error )
output physs_mse_port_3_rx_ecc_err, //Receive L2 FCS Error ( this bit is only set when there is L2 FCS error )
input mse_physs_port_3_rx_rdy, //Receive Application Ready. Asserted (set to 1) by the Receive application to indicate it is ready to receive Data from the MAC. With the direct interface. when the signal deasserts within frame receive the MAC will truncate the frame and eventually set receive frame error
output [39:0] physs_mse_port_3_rx_ts, //Receive Timestamp Value. Time when the MAC detected the SFD of the frame and latched the mac00N_frc_in_rx value. Only meaningful when sop is valid. On ingress contains the 1588 ingress timestamp: Bits [39:8] - 32b timestamp in nano seconds. Bits [7:1] - 7b timestamp in sub-nano seconds. Bit 0 - 1b of valid for TIMESTAMP
input mse_physs_port_3_tx_wren, //Transmit Data Write Enable
input [255:0] mse_physs_port_3_tx_data, //Transmit data rx_data[1023:0] are valid in 400G mode and 200G mode at Port 0. Transmit data rx_data[511:0] are valid in 200G mode at Ports2/4. Transmit data rx_data[255:0] are valid in 100/50/25/10G mode. Port0 use 1024 bits for 400g. 512 bits for 200g or 256 bits for 100g and lower speeds. Port2/4 use 512 bits for 200g or 256 bits for 100g and lower speeds. Ports 1/3/5/6/7 are always 256 bits data width
input mse_physs_port_3_tx_sop, //Transmit Start of Frame
input mse_physs_port_3_tx_eop, //Transmit End of Frame
input [4:0] mse_physs_port_3_tx_mod, //Transmit End Word Modulo. Only meaningful when tx_eop is valid. Indicates which portion of the ff00N_tx_data is valid. tx_mod[6:0] (400G mode / 200G at Port0). 7'b000000 : tx_data[1023:0] is valid. 7'b000001 : tx_data[7:0] is valid. 7'b000010 : tx_data[15:0] is valid. 7'b111111 : tx_data[1015:0] is valid. tx_mod[5:0] ( 200G mode at Ports2/4 ). 6'b000000 : tx_data[511:0] is valid. 6'b000001 : tx_data[7:0] is valid. 6'b000010 : tx_data[15:0] is valid. 6'b111111:tx_data[503:0] is valid. tx_mod[4:0] ( 100G or below ). 5'b00000 : tx_data[255:0] is valid. 5'b00001 : tx_data[7:0] is valid. 5'b00010 : tx_data[15:0] is valid. 5'b11111 : tx_data[247:0] is valid
input mse_physs_port_3_tx_err, //Transmit Frame Error. Asserted with the frames final segment to indicate that the transmitted frame is invalid. Only meaningful whentx_eopis valid. Whentx_erris asserted. the frame is transmitted to the CDMII interface with a transmit error (invalid CRC)
input mse_physs_port_3_tx_crc, //Transmit CRC Append. If set a CRC field the MAC will be appended to the frame. If cleared the MAC does not append a FCS to the frame
output physs_mse_port_3_tx_rdy, //Transmit FIFO ready. mse can write words into the FIFO only when this signal is asserted (1). When 0 application should stop writing latest after 2 cycles
output physs_icq_port_4_link_stat, //indicate link UP status per port
output [3:0] physs_mse_port_4_link_speed, //4 wires for each of 8 ports. Indicate speed when link UP status is asserted -per port.0 - 10Mbps1 - 100Mbps2 - 1Gbps3 - 2.5Gbps4 - 5Gbps5 - 10Gbps6 - Reserved7 - 25Gbps8 - 40Gbps9 - 50Gbps10 - 100Gbps11 - 200Gbps12 - 400Gbpsother - reserved.
output physs_mse_port_4_rx_dval, //Receive Data Valid
output [1023:0] physs_mse_port_4_rx_data, //receive data rx_data[1023:0] are valid in 400G mode or 200G mode at Port0. receive data rx_data[511:0] are valid in 200G mode at Port2/4. receive data rx_data[255:0] are valid in 100/50/25/10G mode. Port0 use 1024 bits for 400g.512 bitsfor200gor 256 bits for 100g and lower speeds. Port2/4 use 512 bits for 200g or 256 bits for 100g and lower speeds. Ports 1/3/5/6/7 are always 256 bits data width
output physs_mse_port_4_rx_sop, //Receive Start of Frame
output physs_mse_port_4_rx_eop, //Receive End of Frame
output [6:0] physs_mse_port_4_rx_mod, //Receive End Word Modulo. Only meaningful when eop signal is valid. Indicates which portion of the rx_data is valid. rx_mod[6:0] ( 400G / 200G Port0). 7'b0000000 : rx_data[1023:0] is valid. 7'b0000001 : rx_data[7:0] is valid. 7'b0000010 : rx_data[15:0] is valid. 7'b1111111:rx_data[1015:0] is valid. rx_mod[5:0] ( 200G ). 6'b000000 : rx_data[511:0] is valid. 6'b000001 : rx_data[7:0] is valid. 6'b000010 : rx_data[15:0] is valid. 6'b111111:rx_data[503:0] is valid. rx_mod[4:0] ( 100G or below ). 5'b00000 : rx_data[255:0] is valid. 5'b00001 : rx_data[7:0] is valid. 5'b00010 : rx_data[15:0] is valid. 5'b11111:rx_data[247:0] is valid
output physs_mse_port_4_rx_err, //Receive frame error ( This is set when there is any type of error within the frame include L2 FCS Error )
output physs_mse_port_4_rx_ecc_err, //Receive L2 FCS Error ( this bit is only set when there is L2 FCS error )
input mse_physs_port_4_rx_rdy, //Receive Application Ready. Asserted (set to 1) by the Receive application to indicate it is ready to receive Data from the MAC. With the direct interface. when the signal deasserts within frame receive the MAC will truncate the frame and eventually set receive frame error
output [39:0] physs_mse_port_4_rx_ts, //Receive Timestamp Value. Time when the MAC detected the SFD of the frame and latched the mac00N_frc_in_rx value. Only meaningful when sop is valid. On ingress contains the 1588 ingress timestamp: Bits [39:8] - 32b timestamp in nano seconds. Bits [7:1] - 7b timestamp in sub-nano seconds. Bit 0 - 1b of valid for TIMESTAMP
input mse_physs_port_4_tx_wren, //Transmit Data Write Enable
input [1023:0] mse_physs_port_4_tx_data, //Transmit data rx_data[1023:0] are valid in 400G mode and 200G mode at Port 0. Transmit data rx_data[511:0] are valid in 200G mode at Ports2/4. Transmit data rx_data[255:0] are valid in 100/50/25/10G mode. Port0 use 1024 bits for 400g. 512 bits for 200g or 256 bits for 100g and lower speeds. Port2/4 use 512 bits for 200g or 256 bits for 100g and lower speeds. Ports 1/3/5/6/7 are always 256 bits data width
input mse_physs_port_4_tx_sop, //Transmit Start of Frame
input mse_physs_port_4_tx_eop, //Transmit End of Frame
input [6:0] mse_physs_port_4_tx_mod, //Transmit End Word Modulo. Only meaningful when tx_eop is valid. Indicates which portion of the ff00N_tx_data is valid. tx_mod[6:0] (400G mode / 200G at Port0). 7'b000000 : tx_data[1023:0] is valid. 7'b000001 : tx_data[7:0] is valid. 7'b000010 : tx_data[15:0] is valid. 7'b111111 : tx_data[1015:0] is valid. tx_mod[5:0] ( 200G mode at Ports2/4 ). 6'b000000 : tx_data[511:0] is valid. 6'b000001 : tx_data[7:0] is valid. 6'b000010 : tx_data[15:0] is valid. 6'b111111:tx_data[503:0] is valid. tx_mod[4:0] ( 100G or below ). 5'b00000 : tx_data[255:0] is valid. 5'b00001 : tx_data[7:0] is valid. 5'b00010 : tx_data[15:0] is valid. 5'b11111 : tx_data[247:0] is valid
input mse_physs_port_4_tx_err, //Transmit Frame Error. Asserted with the frames final segment to indicate that the transmitted frame is invalid. Only meaningful whentx_eopis valid. Whentx_erris asserted. the frame is transmitted to the CDMII interface with a transmit error (invalid CRC)
input mse_physs_port_4_tx_crc, //Transmit CRC Append. If set a CRC field the MAC will be appended to the frame. If cleared the MAC does not append a FCS to the frame
output physs_mse_port_4_tx_rdy, //Transmit FIFO ready. mse can write words into the FIFO only when this signal is asserted (1). When 0 application should stop writing latest after 2 cycles
output physs_icq_port_5_link_stat, //indicate link UP status per port
output [3:0] physs_mse_port_5_link_speed, //4 wires for each of 8 ports. Indicate speed when link UP status is asserted -per port.0 - 10Mbps1 - 100Mbps2 - 1Gbps3 - 2.5Gbps4 - 5Gbps5 - 10Gbps6 - Reserved7 - 25Gbps8 - 40Gbps9 - 50Gbps10 - 100Gbps11 - 200Gbps12 - 400Gbpsother - reserved.
output physs_mse_port_5_rx_dval, //Receive Data Valid
output [255:0] physs_mse_port_5_rx_data, //receive data rx_data[1023:0] are valid in 400G mode or 200G mode at Port0. receive data rx_data[511:0] are valid in 200G mode at Port2/4. receive data rx_data[255:0] are valid in 100/50/25/10G mode. Port0 use 1024 bits for 400g.512 bitsfor200gor 256 bits for 100g and lower speeds. Port2/4 use 512 bits for 200g or 256 bits for 100g and lower speeds. Ports 1/3/5/6/7 are always 256 bits data width
output physs_mse_port_5_rx_sop, //Receive Start of Frame
output physs_mse_port_5_rx_eop, //Receive End of Frame
output [4:0] physs_mse_port_5_rx_mod, //Receive End Word Modulo. Only meaningful when eop signal is valid. Indicates which portion of the rx_data is valid. rx_mod[6:0] ( 400G / 200G Port0). 7'b0000000 : rx_data[1023:0] is valid. 7'b0000001 : rx_data[7:0] is valid. 7'b0000010 : rx_data[15:0] is valid. 7'b1111111:rx_data[1015:0] is valid. rx_mod[5:0] ( 200G ). 6'b000000 : rx_data[511:0] is valid. 6'b000001 : rx_data[7:0] is valid. 6'b000010 : rx_data[15:0] is valid. 6'b111111:rx_data[503:0] is valid. rx_mod[4:0] ( 100G or below ). 5'b00000 : rx_data[255:0] is valid. 5'b00001 : rx_data[7:0] is valid. 5'b00010 : rx_data[15:0] is valid. 5'b11111:rx_data[247:0] is valid
output physs_mse_port_5_rx_err, //Receive frame error ( This is set when there is any type of error within the frame include L2 FCS Error )
output physs_mse_port_5_rx_ecc_err, //Receive L2 FCS Error ( this bit is only set when there is L2 FCS error )
input mse_physs_port_5_rx_rdy, //Receive Application Ready. Asserted (set to 1) by the Receive application to indicate it is ready to receive Data from the MAC. With the direct interface when the signal deasserts within frame receive the MAC will truncate the frame and eventually set receive frame error
output [39:0] physs_mse_port_5_rx_ts, //Receive Timestamp Value. Time when the MAC detected the SFD of the frame and latched the mac00N_frc_in_rx value. Only meaningful when sop is valid. On ingress contains the 1588 ingress timestamp: Bits [39:8] - 32b timestamp in nano seconds. Bits [7:1] - 7b timestamp in sub-nano seconds. Bit 0 - 1b of valid for TIMESTAMP
input mse_physs_port_5_tx_wren, //Transmit Data Write Enable
input [255:0] mse_physs_port_5_tx_data, //Transmit data rx_data[1023:0] are valid in 400G mode and 200G mode at Port 0. Transmit data rx_data[511:0] are valid in 200G mode at Ports2/4. Transmit data rx_data[255:0] are valid in 100/50/25/10G mode. Port0 use 1024 bits for 400g 512 bits for 200g or 256 bits for 100g and lower speeds. Port2/4 use 512 bits for 200g or 256 bits for 100g and lower speeds. Ports 1/3/5/6/7 are always 256 bits data width
input mse_physs_port_5_tx_sop, //Transmit Start of Frame
input mse_physs_port_5_tx_eop, //Transmit End of Frame
input [4:0] mse_physs_port_5_tx_mod, //Transmit End Word Modulo. Only meaningful when tx_eop is valid. Indicates which portion of the ff00N_tx_data is valid. tx_mod[6:0] (400G mode / 200G at Port0). 7'b000000 : tx_data[1023:0] is valid. 7'b000001 : tx_data[7:0] is valid. 7'b000010 : tx_data[15:0] is valid. 7'b111111 : tx_data[1015:0] is valid. tx_mod[5:0] ( 200G mode at Ports2/4 ). 6'b000000 : tx_data[511:0] is valid. 6'b000001 : tx_data[7:0] is valid. 6'b000010 : tx_data[15:0] is valid. 6'b111111:tx_data[503:0] is valid. tx_mod[4:0] ( 100G or below ). 5'b00000 : tx_data[255:0] is valid. 5'b00001 : tx_data[7:0] is valid. 5'b00010 : tx_data[15:0] is valid. 5'b11111 : tx_data[247:0] is valid
input mse_physs_port_5_tx_err, //Transmit Frame Error. Asserted with the frames final segment to indicate that the transmitted frame is invalid. Only meaningful whentx_eopis valid. Whentx_erris asserted the frame is transmitted to the CDMII interface with a transmit error (invalid CRC)
input mse_physs_port_5_tx_crc, //Transmit CRC Append. If set a CRC field the MAC will be appended to the frame. If cleared the MAC does not append a FCS to the frame
output physs_mse_port_5_tx_rdy, //Transmit FIFO ready. mse can write words into the FIFO only when this signal is asserted (1). When 0 application should stop writing latest after 2 cycles
output physs_icq_port_6_link_stat, //indicate link UP status per port
output [3:0] physs_mse_port_6_link_speed, //4 wires for each of 8 ports. Indicate speed when link UP status is asserted -per port.0 - 10Mbps1 - 100Mbps2 - 1Gbps3 - 2.5Gbps4 - 5Gbps5 - 10Gbps6 - Reserved7 - 25Gbps8 - 40Gbps9 - 50Gbps10 - 100Gbps11 - 200Gbps12 - 400Gbpsother - reserved.
output physs_mse_port_6_rx_dval, //Receive Data Valid
output [511:0] physs_mse_port_6_rx_data, //receive data rx_data[1023:0] are valid in 400G mode or 200G mode at Port0. receive data rx_data[511:0] are valid in 200G mode at Port2/4. receive data rx_data[255:0] are valid in 100/50/25/10G mode. Port0 use 1024 bits for 400g512 bitsfor200gor 256 bits for 100g and lower speeds. Port2/4 use 512 bits for 200g or 256 bits for 100g and lower speeds. Ports 1/3/5/6/7 are always 256 bits data width
output physs_mse_port_6_rx_sop, //Receive Start of Frame
output physs_mse_port_6_rx_eop, //Receive End of Frame
output [5:0] physs_mse_port_6_rx_mod, //Receive End Word Modulo. Only meaningful when eop signal is valid. Indicates which portion of the rx_data is valid. rx_mod[6:0] ( 400G / 200G Port0). 7'b0000000 : rx_data[1023:0] is valid. 7'b0000001 : rx_data[7:0] is valid. 7'b0000010 : rx_data[15:0] is valid. 7'b1111111:rx_data[1015:0] is valid. rx_mod[5:0] ( 200G ). 6'b000000 : rx_data[511:0] is valid. 6'b000001 : rx_data[7:0] is valid. 6'b000010 : rx_data[15:0] is valid. 6'b111111:rx_data[503:0] is valid. rx_mod[4:0] ( 100G or below ). 5'b00000 : rx_data[255:0] is valid. 5'b00001 : rx_data[7:0] is valid. 5'b00010 : rx_data[15:0] is valid. 5'b11111:rx_data[247:0] is valid
output physs_mse_port_6_rx_err, //Receive frame error ( This is set when there is any type of error within the frame include L2 FCS Error )
output physs_mse_port_6_rx_ecc_err, //Receive L2 FCS Error ( this bit is only set when there is L2 FCS error )
input mse_physs_port_6_rx_rdy, //Receive Application Ready. Asserted (set to 1) by the Receive application to indicate it is ready to receive Data from the MAC. With the direct interface when the signal deasserts within frame receive the MAC will truncate the frame and eventually set receive frame error
output [39:0] physs_mse_port_6_rx_ts, //Receive Timestamp Value. Time when the MAC detected the SFD of the frame and latched the mac00N_frc_in_rx value. Only meaningful when sop is valid. On ingress contains the 1588 ingress timestamp: Bits [39:8] - 32b timestamp in nano seconds. Bits [7:1] - 7b timestamp in sub-nano seconds. Bit 0 - 1b of valid for TIMESTAMP
input mse_physs_port_6_tx_wren, //Transmit Data Write Enable
input [511:0] mse_physs_port_6_tx_data, //Transmit data rx_data[1023:0] are valid in 400G mode and 200G mode at Port 0. Transmit data rx_data[511:0] are valid in 200G mode at Ports2/4. Transmit data rx_data[255:0] are valid in 100/50/25/10G mode. Port0 use 1024 bits for 400g 512 bits for 200g or 256 bits for 100g and lower speeds. Port2/4 use 512 bits for 200g or 256 bits for 100g and lower speeds. Ports 1/3/5/6/7 are always 256 bits data width
input mse_physs_port_6_tx_sop, //Transmit Start of Frame
input mse_physs_port_6_tx_eop, //Transmit End of Frame
input [5:0] mse_physs_port_6_tx_mod, //Transmit End Word Modulo. Only meaningful when tx_eop is valid. Indicates which portion of the ff00N_tx_data is valid. tx_mod[6:0] (400G mode / 200G at Port0). 7'b000000 : tx_data[1023:0] is valid. 7'b000001 : tx_data[7:0] is valid. 7'b000010 : tx_data[15:0] is valid. 7'b111111 : tx_data[1015:0] is valid. tx_mod[5:0] ( 200G mode at Ports2/4 ). 6'b000000 : tx_data[511:0] is valid. 6'b000001 : tx_data[7:0] is valid. 6'b000010 : tx_data[15:0] is valid. 6'b111111:tx_data[503:0] is valid. tx_mod[4:0] ( 100G or below ). 5'b00000 : tx_data[255:0] is valid. 5'b00001 : tx_data[7:0] is valid. 5'b00010 : tx_data[15:0] is valid. 5'b11111 : tx_data[247:0] is valid
input mse_physs_port_6_tx_err, //Transmit Frame Error. Asserted with the frames final segment to indicate that the transmitted frame is invalid. Only meaningful whentx_eopis valid. Whentx_erris asserted the frame is transmitted to the CDMII interface with a transmit error (invalid CRC)
input mse_physs_port_6_tx_crc, //Transmit CRC Append. If set a CRC field the MAC will be appended to the frame. If cleared the MAC does not append a FCS to the frame
output physs_mse_port_6_tx_rdy, //Transmit FIFO ready. mse can write words into the FIFO only when this signal is asserted (1). When 0 application should stop writing latest after 2 cycles
output physs_icq_port_7_link_stat, //indicate link UP status per port
output [3:0] physs_mse_port_7_link_speed, //4 wires for each of 8 ports. Indicate speed when link UP status is asserted -per port.0 - 10Mbps1 - 100Mbps2 - 1Gbps3 - 2.5Gbps4 - 5Gbps5 - 10Gbps6 - Reserved7 - 25Gbps8 - 40Gbps9 - 50Gbps10 - 100Gbps11 - 200Gbps12 - 400Gbpsother - reserved.
output physs_mse_port_7_rx_dval, //Receive Data Valid
output [255:0] physs_mse_port_7_rx_data, //receive data rx_data[1023:0] are valid in 400G mode or 200G mode at Port0. receive data rx_data[511:0] are valid in 200G mode at Port2/4. receive data rx_data[255:0] are valid in 100/50/25/10G mode. Port0 use 1024 bits for 400g512 bitsfor200gor 256 bits for 100g and lower speeds. Port2/4 use 512 bits for 200g or 256 bits for 100g and lower speeds. Ports 1/3/5/6/7 are always 256 bits data width
output physs_mse_port_7_rx_sop, //Receive Start of Frame
output physs_mse_port_7_rx_eop, //Receive End of Frame
output [4:0] physs_mse_port_7_rx_mod, //Receive End Word Modulo. Only meaningful when eop signal is valid. Indicates which portion of the rx_data is valid. rx_mod[6:0] ( 400G / 200G Port0). 7'b0000000 : rx_data[1023:0] is valid. 7'b0000001 : rx_data[7:0] is valid. 7'b0000010 : rx_data[15:0] is valid. 7'b1111111:rx_data[1015:0] is valid. rx_mod[5:0] ( 200G ). 6'b000000 : rx_data[511:0] is valid. 6'b000001 : rx_data[7:0] is valid. 6'b000010 : rx_data[15:0] is valid. 6'b111111:rx_data[503:0] is valid. rx_mod[4:0] ( 100G or below ). 5'b00000 : rx_data[255:0] is valid. 5'b00001 : rx_data[7:0] is valid. 5'b00010 : rx_data[15:0] is valid. 5'b11111:rx_data[247:0] is valid
output physs_mse_port_7_rx_err, //Receive frame error ( This is set when there is any type of error within the frame include L2 FCS Error )
output physs_mse_port_7_rx_ecc_err, //Receive L2 FCS Error ( this bit is only set when there is L2 FCS error )
input mse_physs_port_7_rx_rdy, //Receive Application Ready. Asserted (set to 1) by the Receive application to indicate it is ready to receive Data from the MAC. With the direct interface when the signal deasserts within frame receive the MAC will truncate the frame and eventually set receive frame error
output [39:0] physs_mse_port_7_rx_ts, //Receive Timestamp Value. Time when the MAC detected the SFD of the frame and latched the mac00N_frc_in_rx value. Only meaningful when sop is valid. On ingress contains the 1588 ingress timestamp: Bits [39:8] - 32b timestamp in nano seconds. Bits [7:1] - 7b timestamp in sub-nano seconds. Bit 0 - 1b of valid for TIMESTAMP
input mse_physs_port_7_tx_wren, //Transmit Data Write Enable
input [255:0] mse_physs_port_7_tx_data, //Transmit data rx_data[1023:0] are valid in 400G mode and 200G mode at Port 0. Transmit data rx_data[511:0] are valid in 200G mode at Ports2/4. Transmit data rx_data[255:0] are valid in 100/50/25/10G mode. Port0 use 1024 bits for 400g 512 bits for 200g or 256 bits for 100g and lower speeds. Port2/4 use 512 bits for 200g or 256 bits for 100g and lower speeds. Ports 1/3/5/6/7 are always 256 bits data width
input mse_physs_port_7_tx_sop, //Transmit Start of Frame
input mse_physs_port_7_tx_eop, //Transmit End of Frame
input [4:0] mse_physs_port_7_tx_mod, //Transmit End Word Modulo. Only meaningful when tx_eop is valid. Indicates which portion of the ff00N_tx_data is valid. tx_mod[6:0] (400G mode / 200G at Port0). 7'b000000 : tx_data[1023:0] is valid. 7'b000001 : tx_data[7:0] is valid. 7'b000010 : tx_data[15:0] is valid. 7'b111111 : tx_data[1015:0] is valid. tx_mod[5:0] ( 200G mode at Ports2/4 ). 6'b000000 : tx_data[511:0] is valid. 6'b000001 : tx_data[7:0] is valid. 6'b000010 : tx_data[15:0] is valid. 6'b111111:tx_data[503:0] is valid. tx_mod[4:0] ( 100G or below ). 5'b00000 : tx_data[255:0] is valid. 5'b00001 : tx_data[7:0] is valid. 5'b00010 : tx_data[15:0] is valid. 5'b11111 : tx_data[247:0] is valid
input mse_physs_port_7_tx_err, //Transmit Frame Error. Asserted with the frames final segment to indicate that the transmitted frame is invalid. Only meaningful whentx_eopis valid. Whentx_erris asserted the frame is transmitted to the CDMII interface with a transmit error (invalid CRC)
input mse_physs_port_7_tx_crc, //Transmit CRC Append. If set a CRC field the MAC will be appended to the frame. If cleared the MAC does not append a FCS to the frame
output physs_mse_port_7_tx_rdy, //Transmit FIFO ready. mse can write words into the FIFO only when this signal is asserted (1). When 0 application should stop writing latest after 2 cycles
output tx_stop_0_out, //tx_stop backpressure signal for physs mac to hlp mac
output tx_stop_1_out, //tx_stop backpressure signal for physs mac to hlp mac
output tx_stop_2_out, //tx_stop backpressure signal for physs mac to hlp mac
output tx_stop_3_out, //tx_stop backpressure signal for physs mac to hlp mac
input tx_stop_0_in, //tx_stop backpressure signal for hlp mac to phys mac
input tx_stop_1_in, //tx_stop backpressure signal for hlp mac to phys mac
input tx_stop_2_in, //tx_stop backpressure signal for hlp mac to phys mac
input tx_stop_3_in, //tx_stop backpressure signal for hlp mac to phys mac
output hlp_xlgmii0_txclk_ena_0, //XLGMII Interface to HMAC
output hlp_xlgmii0_rxclk_ena_0, //XLGMII Interface to HMAC
output [7:0] hlp_xlgmii0_rxc_0, //XLGMII Interface to HMAC
output [63:0] hlp_xlgmii0_rxd_0, //XLGMII Interface to HMAC
output hlp_xlgmii0_rxt0_next_0, //XLGMII Interface to HMAC
input [7:0] hlp_xlgmii0_txc_0, //XLGMII Interface to HMAC
input [63:0] hlp_xlgmii0_txd_0, //XLGMII Interface to HMAC
output hlp_xlgmii1_txclk_ena_0, //XLGMII Interface to HMAC
output hlp_xlgmii1_rxclk_ena_0, //XLGMII Interface to HMAC
output [7:0] hlp_xlgmii1_rxc_0, //XLGMII Interface to HMAC
output [63:0] hlp_xlgmii1_rxd_0, //XLGMII Interface to HMAC
output hlp_xlgmii1_rxt0_next_0, //XLGMII Interface to HMAC
input [7:0] hlp_xlgmii1_txc_0, //XLGMII Interface to HMAC
input [63:0] hlp_xlgmii1_txd_0, //XLGMII Interface to HMAC
output hlp_xlgmii2_txclk_ena_0, //XLGMII Interface to HMAC
output hlp_xlgmii2_rxclk_ena_0, //XLGMII Interface to HMAC
output [7:0] hlp_xlgmii2_rxc_0, //XLGMII Interface to HMAC
output [63:0] hlp_xlgmii2_rxd_0, //XLGMII Interface to HMAC
output hlp_xlgmii2_rxt0_next_0, //XLGMII Interface to HMAC
input [7:0] hlp_xlgmii2_txc_0, //XLGMII Interface to HMAC
input [63:0] hlp_xlgmii2_txd_0, //XLGMII Interface to HMAC
output hlp_xlgmii3_txclk_ena_0, //XLGMII Interface to HMAC
output hlp_xlgmii3_rxclk_ena_0, //XLGMII Interface to HMAC
output [7:0] hlp_xlgmii3_rxc_0, //XLGMII Interface to HMAC
output [63:0] hlp_xlgmii3_rxd_0, //XLGMII Interface to HMAC
output hlp_xlgmii3_rxt0_next_0, //XLGMII Interface to HMAC
input [7:0] hlp_xlgmii3_txc_0, //XLGMII Interface to HMAC
input [63:0] hlp_xlgmii3_txd_0, //XLGMII Interface to HMAC
output [127:0] hlp_cgmii0_rxd_0, //CGMII Interface to HMAC
output [15:0] hlp_cgmii0_rxc_0, //CGMII Interface to HMAC
output hlp_cgmii0_rxclk_ena_0, //CGMII Interface to HMAC
input [127:0] hlp_cgmii0_txd_0, //CGMII Interface to HMAC
input [15:0] hlp_cgmii0_txc_0, //CGMII Interface to HMAC
output hlp_cgmii0_txclk_ena_0, //CGMII Interface to HMAC
output [127:0] hlp_cgmii1_rxd_0, //CGMII Interface to HMAC
output [15:0] hlp_cgmii1_rxc_0, //CGMII Interface to HMAC
output hlp_cgmii1_rxclk_ena_0, //CGMII Interface to HMAC
input [127:0] hlp_cgmii1_txd_0, //CGMII Interface to HMAC
input [15:0] hlp_cgmii1_txc_0, //CGMII Interface to HMAC
output hlp_cgmii1_txclk_ena_0, //CGMII Interface to HMAC
output [127:0] hlp_cgmii2_rxd_0, //CGMII Interface to HMAC
output [15:0] hlp_cgmii2_rxc_0, //CGMII Interface to HMAC
output hlp_cgmii2_rxclk_ena_0, //CGMII Interface to HMAC
input [127:0] hlp_cgmii2_txd_0, //CGMII Interface to HMAC
input [15:0] hlp_cgmii2_txc_0, //CGMII Interface to HMAC
output hlp_cgmii2_txclk_ena_0, //CGMII Interface to HMAC
output [127:0] hlp_cgmii3_rxd_0, //CGMII Interface to HMAC
output [15:0] hlp_cgmii3_rxc_0, //CGMII Interface to HMAC
output hlp_cgmii3_rxclk_ena_0, //CGMII Interface to HMAC
input [127:0] hlp_cgmii3_txd_0, //CGMII Interface to HMAC
input [15:0] hlp_cgmii3_txc_0, //CGMII Interface to HMAC
output hlp_cgmii3_txclk_ena_0, //CGMII Interface to HMAC
input [7:0] hlp_xlgmii0_rxc_nss_0, //XLGMII Interface to NSS
input [63:0] hlp_xlgmii0_rxd_nss_0, //XLGMII Interface to NSS
output [7:0] hlp_xlgmii0_txc_nss_0, //XLGMII Interface to NSS
output [63:0] hlp_xlgmii0_txd_nss_0, //XLGMII Interface to NSS
input [7:0] hlp_xlgmii1_rxc_nss_0, //XLGMII Interface to NSS
input [63:0] hlp_xlgmii1_rxd_nss_0, //XLGMII Interface to NSS
output [7:0] hlp_xlgmii1_txc_nss_0, //XLGMII Interface to NSS
output [63:0] hlp_xlgmii1_txd_nss_0, //XLGMII Interface to NSS
input [7:0] hlp_xlgmii2_rxc_nss_0, //XLGMII Interface to NSS
input [63:0] hlp_xlgmii2_rxd_nss_0, //XLGMII Interface to NSS
output [7:0] hlp_xlgmii2_txc_nss_0, //XLGMII Interface to NSS
output [63:0] hlp_xlgmii2_txd_nss_0, //XLGMII Interface to NSS
input [7:0] hlp_xlgmii3_rxc_nss_0, //XLGMII Interface to NSS
input [63:0] hlp_xlgmii3_rxd_nss_0, //XLGMII Interface to NSS
output [7:0] hlp_xlgmii3_txc_nss_0, //XLGMII Interface to NSS
output [63:0] hlp_xlgmii3_txd_nss_0, //XLGMII Interface to NSS
input [127:0] hlp_cgmii0_rxd_nss_0, //CGMII Interface to NSS
input [15:0] hlp_cgmii0_rxc_nss_0, //CGMII Interface to NSS
output [127:0] hlp_cgmii0_txd_nss_0, //CGMII Interface to NSS
output [15:0] hlp_cgmii0_txc_nss_0, //CGMII Interface to NSS
input [127:0] hlp_cgmii1_rxd_nss_0, //CGMII Interface to NSS
input [15:0] hlp_cgmii1_rxc_nss_0, //CGMII Interface to NSS
output [127:0] hlp_cgmii1_txd_nss_0, //CGMII Interface to NSS
output [15:0] hlp_cgmii1_txc_nss_0, //CGMII Interface to NSS
input [127:0] hlp_cgmii2_rxd_nss_0, //CGMII Interface to NSS
input [15:0] hlp_cgmii2_rxc_nss_0, //CGMII Interface to NSS
output [127:0] hlp_cgmii2_txd_nss_0, //CGMII Interface to NSS
output [15:0] hlp_cgmii2_txc_nss_0, //CGMII Interface to NSS
input [127:0] hlp_cgmii3_rxd_nss_0, //CGMII Interface to NSS
input [15:0] hlp_cgmii3_rxc_nss_0, //CGMII Interface to NSS
output [127:0] hlp_cgmii3_txd_nss_0, //CGMII Interface to NSS
output [15:0] hlp_cgmii3_txc_nss_0, //CGMII Interface to NSS
output hlp_xlgmii0_txclk_ena_1, //XLGMII Interface to HMAC
output hlp_xlgmii0_rxclk_ena_1, //XLGMII Interface to HMAC
output [7:0] hlp_xlgmii0_rxc_1, //XLGMII Interface to HMAC
output [63:0] hlp_xlgmii0_rxd_1, //XLGMII Interface to HMAC
output hlp_xlgmii0_rxt0_next_1, //XLGMII Interface to HMAC
input [7:0] hlp_xlgmii0_txc_1, //XLGMII Interface to HMAC
input [63:0] hlp_xlgmii0_txd_1, //XLGMII Interface to HMAC
output hlp_xlgmii1_txclk_ena_1, //XLGMII Interface to HMAC
output hlp_xlgmii1_rxclk_ena_1, //XLGMII Interface to HMAC
output [7:0] hlp_xlgmii1_rxc_1, //XLGMII Interface to HMAC
output [63:0] hlp_xlgmii1_rxd_1, //XLGMII Interface to HMAC
output hlp_xlgmii1_rxt0_next_1, //XLGMII Interface to HMAC
input [7:0] hlp_xlgmii1_txc_1, //XLGMII Interface to HMAC
input [63:0] hlp_xlgmii1_txd_1, //XLGMII Interface to HMAC
output hlp_xlgmii2_txclk_ena_1, //XLGMII Interface to HMAC
output hlp_xlgmii2_rxclk_ena_1, //XLGMII Interface to HMAC
output [7:0] hlp_xlgmii2_rxc_1, //XLGMII Interface to HMAC
output [63:0] hlp_xlgmii2_rxd_1, //XLGMII Interface to HMAC
output hlp_xlgmii2_rxt0_next_1, //XLGMII Interface to HMAC
input [7:0] hlp_xlgmii2_txc_1, //XLGMII Interface to HMAC
input [63:0] hlp_xlgmii2_txd_1, //XLGMII Interface to HMAC
output hlp_xlgmii3_txclk_ena_1, //XLGMII Interface to HMAC
output hlp_xlgmii3_rxclk_ena_1, //XLGMII Interface to HMAC
output [7:0] hlp_xlgmii3_rxc_1, //XLGMII Interface to HMAC
output [63:0] hlp_xlgmii3_rxd_1, //XLGMII Interface to HMAC
output hlp_xlgmii3_rxt0_next_1, //XLGMII Interface to HMAC
input [7:0] hlp_xlgmii3_txc_1, //XLGMII Interface to HMAC
input [63:0] hlp_xlgmii3_txd_1, //XLGMII Interface to HMAC
output [127:0] hlp_cgmii0_rxd_1, //CGMII Interface to HMAC
output [15:0] hlp_cgmii0_rxc_1, //CGMII Interface to HMAC
output hlp_cgmii0_rxclk_ena_1, //CGMII Interface to HMAC
input [127:0] hlp_cgmii0_txd_1, //CGMII Interface to HMAC
input [15:0] hlp_cgmii0_txc_1, //CGMII Interface to HMAC
output hlp_cgmii0_txclk_ena_1, //CGMII Interface to HMAC
output [127:0] hlp_cgmii1_rxd_1, //CGMII Interface to HMAC
output [15:0] hlp_cgmii1_rxc_1, //CGMII Interface to HMAC
output hlp_cgmii1_rxclk_ena_1, //CGMII Interface to HMAC
input [127:0] hlp_cgmii1_txd_1, //CGMII Interface to HMAC
input [15:0] hlp_cgmii1_txc_1, //CGMII Interface to HMAC
output hlp_cgmii1_txclk_ena_1, //CGMII Interface to HMAC
output [127:0] hlp_cgmii2_rxd_1, //CGMII Interface to HMAC
output [15:0] hlp_cgmii2_rxc_1, //CGMII Interface to HMAC
output hlp_cgmii2_rxclk_ena_1, //CGMII Interface to HMAC
input [127:0] hlp_cgmii2_txd_1, //CGMII Interface to HMAC
input [15:0] hlp_cgmii2_txc_1, //CGMII Interface to HMAC
output hlp_cgmii2_txclk_ena_1, //CGMII Interface to HMAC
output [127:0] hlp_cgmii3_rxd_1, //CGMII Interface to HMAC
output [15:0] hlp_cgmii3_rxc_1, //CGMII Interface to HMAC
output hlp_cgmii3_rxclk_ena_1, //CGMII Interface to HMAC
input [127:0] hlp_cgmii3_txd_1, //CGMII Interface to HMAC
input [15:0] hlp_cgmii3_txc_1, //CGMII Interface to HMAC
output hlp_cgmii3_txclk_ena_1, //CGMII Interface to HMAC
output hlp_xlgmii0_txclk_ena_2, //XLGMII Interface to HMAC
output hlp_xlgmii0_rxclk_ena_2, //XLGMII Interface to HMAC
output [7:0] hlp_xlgmii0_rxc_2, //XLGMII Interface to HMAC
output [63:0] hlp_xlgmii0_rxd_2, //XLGMII Interface to HMAC
output hlp_xlgmii0_rxt0_next_2, //XLGMII Interface to HMAC
input [7:0] hlp_xlgmii0_txc_2, //XLGMII Interface to HMAC
input [63:0] hlp_xlgmii0_txd_2, //XLGMII Interface to HMAC
output hlp_xlgmii1_txclk_ena_2, //XLGMII Interface to HMAC
output hlp_xlgmii1_rxclk_ena_2, //XLGMII Interface to HMAC
output [7:0] hlp_xlgmii1_rxc_2, //XLGMII Interface to HMAC
output [63:0] hlp_xlgmii1_rxd_2, //XLGMII Interface to HMAC
output hlp_xlgmii1_rxt0_next_2, //XLGMII Interface to HMAC
input [7:0] hlp_xlgmii1_txc_2, //XLGMII Interface to HMAC
input [63:0] hlp_xlgmii1_txd_2, //XLGMII Interface to HMAC
output hlp_xlgmii2_txclk_ena_2, //XLGMII Interface to HMAC
output hlp_xlgmii2_rxclk_ena_2, //XLGMII Interface to HMAC
output [7:0] hlp_xlgmii2_rxc_2, //XLGMII Interface to HMAC
output [63:0] hlp_xlgmii2_rxd_2, //XLGMII Interface to HMAC
output hlp_xlgmii2_rxt0_next_2, //XLGMII Interface to HMAC
input [7:0] hlp_xlgmii2_txc_2, //XLGMII Interface to HMAC
input [63:0] hlp_xlgmii2_txd_2, //XLGMII Interface to HMAC
output hlp_xlgmii3_txclk_ena_2, //XLGMII Interface to HMAC
output hlp_xlgmii3_rxclk_ena_2, //XLGMII Interface to HMAC
output [7:0] hlp_xlgmii3_rxc_2, //XLGMII Interface to HMAC
output [63:0] hlp_xlgmii3_rxd_2, //XLGMII Interface to HMAC
output hlp_xlgmii3_rxt0_next_2, //XLGMII Interface to HMAC
input [7:0] hlp_xlgmii3_txc_2, //XLGMII Interface to HMAC
input [63:0] hlp_xlgmii3_txd_2, //XLGMII Interface to HMAC
output [127:0] hlp_cgmii0_rxd_2, //CGMII Interface to HMAC
output [15:0] hlp_cgmii0_rxc_2, //CGMII Interface to HMAC
output hlp_cgmii0_rxclk_ena_2, //CGMII Interface to HMAC
input [127:0] hlp_cgmii0_txd_2, //CGMII Interface to HMAC
input [15:0] hlp_cgmii0_txc_2, //CGMII Interface to HMAC
output hlp_cgmii0_txclk_ena_2, //CGMII Interface to HMAC
output [127:0] hlp_cgmii1_rxd_2, //CGMII Interface to HMAC
output [15:0] hlp_cgmii1_rxc_2, //CGMII Interface to HMAC
output hlp_cgmii1_rxclk_ena_2, //CGMII Interface to HMAC
input [127:0] hlp_cgmii1_txd_2, //CGMII Interface to HMAC
input [15:0] hlp_cgmii1_txc_2, //CGMII Interface to HMAC
output hlp_cgmii1_txclk_ena_2, //CGMII Interface to HMAC
output [127:0] hlp_cgmii2_rxd_2, //CGMII Interface to HMAC
output [15:0] hlp_cgmii2_rxc_2, //CGMII Interface to HMAC
output hlp_cgmii2_rxclk_ena_2, //CGMII Interface to HMAC
input [127:0] hlp_cgmii2_txd_2, //CGMII Interface to HMAC
input [15:0] hlp_cgmii2_txc_2, //CGMII Interface to HMAC
output hlp_cgmii2_txclk_ena_2, //CGMII Interface to HMAC
output [127:0] hlp_cgmii3_rxd_2, //CGMII Interface to HMAC
output [15:0] hlp_cgmii3_rxc_2, //CGMII Interface to HMAC
output hlp_cgmii3_rxclk_ena_2, //CGMII Interface to HMAC
input [127:0] hlp_cgmii3_txd_2, //CGMII Interface to HMAC
input [15:0] hlp_cgmii3_txc_2, //CGMII Interface to HMAC
output hlp_cgmii3_txclk_ena_2, //CGMII Interface to HMAC
output hlp_xlgmii0_txclk_ena_3, //XLGMII Interface to HMAC
output hlp_xlgmii0_rxclk_ena_3, //XLGMII Interface to HMAC
output [7:0] hlp_xlgmii0_rxc_3, //XLGMII Interface to HMAC
output [63:0] hlp_xlgmii0_rxd_3, //XLGMII Interface to HMAC
output hlp_xlgmii0_rxt0_next_3, //XLGMII Interface to HMAC
input [7:0] hlp_xlgmii0_txc_3, //XLGMII Interface to HMAC
input [63:0] hlp_xlgmii0_txd_3, //XLGMII Interface to HMAC
output hlp_xlgmii1_txclk_ena_3, //XLGMII Interface to HMAC
output hlp_xlgmii1_rxclk_ena_3, //XLGMII Interface to HMAC
output [7:0] hlp_xlgmii1_rxc_3, //XLGMII Interface to HMAC
output [63:0] hlp_xlgmii1_rxd_3, //XLGMII Interface to HMAC
output hlp_xlgmii1_rxt0_next_3, //XLGMII Interface to HMAC
input [7:0] hlp_xlgmii1_txc_3, //XLGMII Interface to HMAC
input [63:0] hlp_xlgmii1_txd_3, //XLGMII Interface to HMAC
output hlp_xlgmii2_txclk_ena_3, //XLGMII Interface to HMAC
output hlp_xlgmii2_rxclk_ena_3, //XLGMII Interface to HMAC
output [7:0] hlp_xlgmii2_rxc_3, //XLGMII Interface to HMAC
output [63:0] hlp_xlgmii2_rxd_3, //XLGMII Interface to HMAC
output hlp_xlgmii2_rxt0_next_3, //XLGMII Interface to HMAC
input [7:0] hlp_xlgmii2_txc_3, //XLGMII Interface to HMAC
input [63:0] hlp_xlgmii2_txd_3, //XLGMII Interface to HMAC
output hlp_xlgmii3_txclk_ena_3, //XLGMII Interface to HMAC
output hlp_xlgmii3_rxclk_ena_3, //XLGMII Interface to HMAC
output [7:0] hlp_xlgmii3_rxc_3, //XLGMII Interface to HMAC
output [63:0] hlp_xlgmii3_rxd_3, //XLGMII Interface to HMAC
output hlp_xlgmii3_rxt0_next_3, //XLGMII Interface to HMAC
input [7:0] hlp_xlgmii3_txc_3, //XLGMII Interface to HMAC
input [63:0] hlp_xlgmii3_txd_3, //XLGMII Interface to HMAC
output [127:0] hlp_cgmii0_rxd_3, //CGMII Interface to HMAC
output [15:0] hlp_cgmii0_rxc_3, //CGMII Interface to HMAC
output hlp_cgmii0_rxclk_ena_3, //CGMII Interface to HMAC
input [127:0] hlp_cgmii0_txd_3, //CGMII Interface to HMAC
input [15:0] hlp_cgmii0_txc_3, //CGMII Interface to HMAC
output hlp_cgmii0_txclk_ena_3, //CGMII Interface to HMAC
output [127:0] hlp_cgmii1_rxd_3, //CGMII Interface to HMAC
output [15:0] hlp_cgmii1_rxc_3, //CGMII Interface to HMAC
output hlp_cgmii1_rxclk_ena_3, //CGMII Interface to HMAC
input [127:0] hlp_cgmii1_txd_3, //CGMII Interface to HMAC
input [15:0] hlp_cgmii1_txc_3, //CGMII Interface to HMAC
output hlp_cgmii1_txclk_ena_3, //CGMII Interface to HMAC
output [127:0] hlp_cgmii2_rxd_3, //CGMII Interface to HMAC
output [15:0] hlp_cgmii2_rxc_3, //CGMII Interface to HMAC
output hlp_cgmii2_rxclk_ena_3, //CGMII Interface to HMAC
input [127:0] hlp_cgmii2_txd_3, //CGMII Interface to HMAC
input [15:0] hlp_cgmii2_txc_3, //CGMII Interface to HMAC
output hlp_cgmii2_txclk_ena_3, //CGMII Interface to HMAC
output [127:0] hlp_cgmii3_rxd_3, //CGMII Interface to HMAC
output [15:0] hlp_cgmii3_rxc_3, //CGMII Interface to HMAC
output hlp_cgmii3_rxclk_ena_3, //CGMII Interface to HMAC
input [127:0] hlp_cgmii3_txd_3, //CGMII Interface to HMAC
input [15:0] hlp_cgmii3_txc_3, //CGMII Interface to HMAC
output hlp_cgmii3_txclk_ena_3, //CGMII Interface to HMAC
input mse_physs_port_0_ts_capture_vld, //Indicate the timestamp capture valid for 1588 2-step operation This should be valid as part of SOP
input [6:0] mse_physs_port_0_ts_capture_idx, //Indicate the timestamp capture idx for 1588 2-step operation This should be valid as part of SOP
input mse_physs_port_1_ts_capture_vld, //Indicate the timestamp capture valid for 1588 2-step operation This should be valid as part of SOP
input [6:0] mse_physs_port_1_ts_capture_idx, //Indicate the timestamp capture idx for 1588 2-step operation This should be valid as part of SOP
input mse_physs_port_2_ts_capture_vld, //Indicate the timestamp capture valid for 1588 2-step operation This should be valid as part of SOP
input [6:0] mse_physs_port_2_ts_capture_idx, //Indicate the timestamp capture idx for 1588 2-step operation This should be valid as part of SOP
input mse_physs_port_3_ts_capture_vld, //Indicate the timestamp capture valid for 1588 2-step operation This should be valid as part of SOP
input [6:0] mse_physs_port_3_ts_capture_idx, //Indicate the timestamp capture idx for 1588 2-step operation This should be valid as part of SOP
input mse_physs_port_4_ts_capture_vld, //Indicate the timestamp capture valid for 1588 2-step operation This should be valid as part of SOP
input [6:0] mse_physs_port_4_ts_capture_idx, //Indicate the timestamp capture idx for 1588 2-step operation This should be valid as part of SOP
input mse_physs_port_5_ts_capture_vld, //Indicate the timestamp capture valid for 1588 2-step operation This should be valid as part of SOP
input [6:0] mse_physs_port_5_ts_capture_idx, //Indicate the timestamp capture idx for 1588 2-step operation This should be valid as part of SOP
input mse_physs_port_6_ts_capture_vld, //Indicate the timestamp capture valid for 1588 2-step operation This should be valid as part of SOP
input [6:0] mse_physs_port_6_ts_capture_idx, //Indicate the timestamp capture idx for 1588 2-step operation This should be valid as part of SOP
input mse_physs_port_7_ts_capture_vld, //Indicate the timestamp capture valid for 1588 2-step operation This should be valid as part of SOP
input [6:0] mse_physs_port_7_ts_capture_idx, //Indicate the timestamp capture idx for 1588 2-step operation This should be valid as part of SOP
output [31:0] pcs_tsu_rx_sd,
output [31:0] mii_rx_tsu_mux,
output [31:0] mii_tx_tsu,
output [127:0] pcs_sd_bit_slip,
output [111:0] pcs_desk_buf_rlevel,
output [15:0] pcs_link_status_tsu,
output physs_icq_port_0_pfc_mode, //Indication from register bit COMMAND_CONFIG.PFC_ENA (bit 19) indicating (when 1) that the MAC operates in PFC mode. When 0 it indicates operation in link pause mode.
output physs_icq_port_1_pfc_mode, //Indication from register bit COMMAND_CONFIG.PFC_ENA (bit 19) indicating (when 1) that the MAC operates in PFC mode. When 0 it indicates operation in link pause mode.
output physs_icq_port_2_pfc_mode, //Indication from register bit COMMAND_CONFIG.PFC_ENA (bit 19) indicating (when 1) that the MAC operates in PFC mode. When 0 it indicates operation in link pause mode.
output physs_icq_port_3_pfc_mode, //Indication from register bit COMMAND_CONFIG.PFC_ENA (bit 19) indicating (when 1) that the MAC operates in PFC mode. When 0 it indicates operation in link pause mode.
output physs_icq_port_4_pfc_mode, //Indication from register bit COMMAND_CONFIG.PFC_ENA (bit 19) indicating (when 1) that the MAC operates in PFC mode. When 0 it indicates operation in link pause mode.
output physs_icq_port_5_pfc_mode, //Indication from register bit COMMAND_CONFIG.PFC_ENA (bit 19) indicating (when 1) that the MAC operates in PFC mode. When 0 it indicates operation in link pause mode.
output physs_icq_port_6_pfc_mode, //Indication from register bit COMMAND_CONFIG.PFC_ENA (bit 19) indicating (when 1) that the MAC operates in PFC mode. When 0 it indicates operation in link pause mode.
output physs_icq_port_7_pfc_mode, //Indication from register bit COMMAND_CONFIG.PFC_ENA (bit 19) indicating (when 1) that the MAC operates in PFC mode. When 0 it indicates operation in link pause mode.
input [63:0] icq_physs_net_xoff, //PFC flow control interface from the ingress CoS queues to the network. 8 bits - one for each UP for each PHYSS interface. Bits 0-7 correspond to User Priorities 0-7 of Physical Port0 / PHYSS interface 0 within the port MAC. Bits 8-15 correspond to User Priorities 0-3 of Physical Port1 / PHYSS interface 1 within the port MAC. Bits 16-23 correspond to User Priorities 0-3 of Physical Port2 / PHYSS interface 2 within the port MAC. Bits 24-31 correspond to User Priorities 0-3 of Physical Port3 / PHYSS interface 3 within the port MAC. Bits 32-39 correspond to User Priorities 0-3 of Physical Port4 / PHYSS interface 4 within the port MAC. Bits 40-47 correspond to User Priorities 0-3 of Physical Port5 / PHYSS interface 5 within the port MAC. Bits 48-55 correspond to User Priorities 0-3 of Physical Port6 / PHYSS interface 6 within the port MAC. Bits 56-63 correspond to User Priorities 0-3 of Physical Port7 / PHYSS interface 7 within the port MAC. When Port pfc_mode is configure as Link FLC. Bit0 correspond to Port0 Link FLC. Bit8 correspond to Port1 Link FLC. Bit16 correspond to Port2 Link FLC. Bit24 correspond to Port3 Link FLC. Bit32 correspond to Port4 Link FLC. Bit40 correspond to Port5 Link FLC. Bit48 correspond to Port6 Link FLC. Bit56 correspond to Port7 Link FLC
output [63:0] physs_icq_net_xoff, //PFC flow control interface from network to the ingress CoS queues. 8 bits - one for each UP for each PHYSS interface. Bits 0-7 correspond to User Priorities 0-7 of Physical Port0 / PHYSS interface 0 within the port MAC. Bits 8-15 correspond to User Priorities 0-3 of Physical Port1 / PHYSS interface 1 within the port MAC. Bits 16-23 correspond to User Priorities 0-3 of Physical Port2 / PHYSS interface 2 within the port MAC. Bits 24-31 correspond to User Priorities 0-3 of Physical Port3 / PHYSS interface 3 within the port MAC. Bits 32-39 correspond to User Priorities 0-3 of Physical Port4 / PHYSS interface 4 within the port MAC. Bits 40-47 correspond to User Priorities 0-3 of Physical Port5 / PHYSS interface 5 within the port MAC. Bits 48-55 correspond to User Priorities 0-3 of Physical Port6 / PHYSS interface 6 within the port MAC. Bits 56-63 correspond to User Priorities 0-3 of Physical Port7 / PHYSS interface 7 within the port MAC. Hi. Bit0 correspond to Port0 Link FLC. Bit8 correspond to Port1 Link FLC. Bit16 correspond to Port2 Link FLC. Bit24 correspond to Port3 Link FLC. Bit32 correspond to Port4 Link FLC. Bit40 correspond to Port5 Link FLC. Bit48 correspond to Port6 Link FLC. Bit56 correspond to Port7 Link FLC
output physs_hif_port_0_magic_pkt_ind_tgl, //Indicate magic packet received per port per PF/host to the HIF block.
output physs_hif_port_1_magic_pkt_ind_tgl, //Indicate magic packet received per port per PF/host to the HIF block.
output physs_hif_port_2_magic_pkt_ind_tgl, //Indicate magic packet received per port per PF/host to the HIF block.
output physs_hif_port_3_magic_pkt_ind_tgl, //Indicate magic packet received per port per PF/host to the HIF block.
output physs_hif_port_4_magic_pkt_ind_tgl, //Indicate magic packet received per port per PF/host to the HIF block.
output physs_hif_port_5_magic_pkt_ind_tgl, //Indicate magic packet received per port per PF/host to the HIF block.
output physs_hif_port_6_magic_pkt_ind_tgl, //Indicate magic packet received per port per PF/host to the HIF block.
output physs_hif_port_7_magic_pkt_ind_tgl, //Indicate magic packet received per port per PF/host to the HIF block.
input [1:0] physs_timesync_sync_val, //command valid to sync the 1588 timers
output physs_fatal_int_0, //fatal interrupt indication for physs_0
output physs_fatal_int_1, //fatal interrupt indication for physs_1
output physs_imc_int_0, //interrupt indication for ARM IMC for physs_0
output physs_imc_int_1, //interrupt indication for ARM IMC for physs_1
output physs_0_ts_int, //PHY timestamp interrupt indication reflect 8 ports (faster interrupt tobypass IMC) for physs_0
output [3:0] o_ucss_irq_cpi_0_a, //xmp cpi interrupt
output [3:0] o_ucss_irq_cpi_1_a, //xmp cpi interrupt
output [3:0] o_ucss_irq_cpi_2_a, //xmp cpi interrupt
output [3:0] o_ucss_irq_cpi_3_a, //xmp cpi interrupt
output [3:0] o_ucss_irq_cpi_4_a, //xmp cpi interrupt
output [15:0] o_ucss_irq_status_a, //xmp ucss interrupt
input mdio_in,
output mdio_out,
output mdio_oen,
output mdc,
inout [15:0] ioa_pma_remote_diode_i_anode,
inout [15:0] ioa_pma_remote_diode_v_anode,
inout [15:0] ioa_pma_remote_diode_i_cathode,
inout [15:0] ioa_pma_remote_diode_v_cathode,
output [3:0] mac100_0_int,
output [3:0] mac100_1_int,
output [1:0] mac400_0_int,
output [1:0] mac400_1_int,
output mac800_0_int,
output [7:0] physs_ts_int,
input [5:0] physs_hd2prf_trim_fuse_in, //1R1W time stamp Memory dual-clock rfhd type Trim Fuse RMCE WMCE latency Read and Write Memory Latency
input [6:0] physs_hs2prf_trim_fuse_in, //1R1W time stamp Memory rfhs type Trim Fuse RMCE WMCE latency Read and Write Memory Latency
input [7:0] physs_rfhs_trim_fuse_in, //2R2W time stamp Memory rfhs type Trim Fuse RMCE WMCE latency Read and Write Memory Latency
input [15:0] physs_hdspsr_trim_fuse_in, //Memory SRAM type Trim Fuse RMCE WMCE latency Read and Write Memory Latency
input physs_bbl_800G_0_disable, //SKU based fuse to disable 800G stack in physs0/mquad0
input physs_bbl_400G_0_disable, //SKU based fuse to disable 400G stack in physs0/mquad0
input physs_bbl_200G_0_disable, //SKU based fuse to disable 400G stack in physs0/mquad0
input physs_bbl_100G_0_disable, //SKU based fuse to disable 100G stack in physs0/mquad0
input [3:0] physs_bbl_serdes_0_disable, //SKU based fuse to disable serdes lanes in quads in physs0/mquad0
input physs_bbl_400G_1_disable, //SKU based fuse to disable 400G stack in physs0/mquad1
input physs_bbl_200G_1_disable, //SKU based fuse to disable 400G stack in physs0/mquad1
input physs_bbl_100G_1_disable, //SKU based fuse to disable 100G stack in physs0/mquad1
input [3:0] physs_bbl_serdes_1_disable, //SKU based fuse to disable serdes lanes in quads in physs0/mquad1
input physs_bbl_100G_2_disable, //SKU based fuse to disable 100G stack in physs1/pquad0
input [3:0] physs_bbl_serdes_2_disable, //SKU based fuse to disable serdes lanes in quads in physs1/pquad0
input physs_bbl_100G_3_disable, //SKU based fuse to disable 100G stack in physs1/pquad1
input [3:0] physs_bbl_serdes_3_disable, //SKU based fuse to disable serdes lanes in quads in physs1/pquad1
input physs_bbl_spare_0, //spare fuses
input physs_bbl_spare_1, //spare fuses
input physs_bbl_spare_2, //spare fuses
input physs_bbl_spare_3, //spare fuses
output physs_mse_800g_en,
input i_ck_ucss_uart_sclk,
input i_ucss_uart_rxd,
output o_ucss_uart_txd,
input [3:0] ack_from_fabric_0, //rtb connection
input [3:0] req_from_fabric_0, //rtb connection
output [3:0] trig_req_to_fabric_0, //rtb connection
output [3:0] ack_to_fabric_0, //rtb connection
input [3:0] ack_from_fabric_1, //rtb connection
input [3:0] req_from_fabric_1, //rtb connection
output [3:0] trig_req_to_fabric_1, //rtb connection
output [3:0] ack_to_fabric_1 //rtb connection
 );
// EDIT_PORT END


// EDIT_NET BEGIN
logic mbp_repeater_odi_parmisc_physs0_5_ubp_out ; 
logic mbp_repeater_sfe_parmisc_physs0_2_ubp_out ; 
logic [3:0] quadpcs100_2_pcs_link_status ; 
logic [3:0] quadpcs100_3_pcs_link_status ; 
wire soc_per_clk_adop_parmisc_physs0_clkout_0 ; 
wire physs_func_clk_adop_parmisc_physs0_clkout ; 
wire o_ck_pma0_rx_postdiv_l0_adop_parpquad0_clkout ; 
wire o_ck_pma1_rx_postdiv_l0_adop_parpquad0_clkout ; 
wire o_ck_pma2_rx_postdiv_l0_adop_parpquad0_clkout ; 
wire o_ck_pma3_rx_postdiv_l0_adop_parpquad0_clkout ; 
wire o_ck_pma0_rx_postdiv_l0_adop_parpquad1_clkout ; 
wire o_ck_pma1_rx_postdiv_l0_adop_parpquad1_clkout ; 
wire o_ck_pma2_rx_postdiv_l0_adop_parpquad1_clkout ; 
wire o_ck_pma3_rx_postdiv_l0_adop_parpquad1_clkout ; 
logic o_ck_pma0_cmnplla_postdiv_clk_mux_parmquad0_clkout ; 
wire fscan_ref_clk_adop_parmisc_physs0_clkout_0 ; 
wire uart_clk_adop_parmisc_physs0_clkout_0 ; 
logic physs_registers_wrapper_0_reset_ref_clk_override ; 
logic physs_registers_wrapper_0_reset_pcs100_override_en ; 
logic physs_registers_wrapper_0_clk_gate_en_100G_mac_pcs ; 
logic physs_registers_wrapper_0_power_fsm_clk_gate_en ; 
logic physs_registers_wrapper_0_power_fsm_reset_gate_en ; 
logic physs_registers_wrapper_1_reset_ref_clk_override ; 
logic physs_registers_wrapper_1_reset_pcs100_override_en ; 
logic physs_registers_wrapper_1_clk_gate_en_100G_mac_pcs ; 
logic physs_registers_wrapper_1_power_fsm_clk_gate_en ; 
logic physs_registers_wrapper_1_power_fsm_reset_gate_en ; 
logic physs_registers_wrapper_0_clk_gate_en_800G_mac_pcs ; 
wire [3:0] physs1_ioa_ck_pma0_ref_left_pquad1_physs1 ; 
logic physs_registers_wrapper_2_reset_ref_clk_override_0 ; 
logic physs_registers_wrapper_2_reset_pcs100_override_en_0 ; 
logic physs_registers_wrapper_2_clk_gate_en_100G_mac_pcs_0 ; 
logic physs_registers_wrapper_2_power_fsm_clk_gate_en_0 ; 
logic physs_registers_wrapper_2_power_fsm_reset_gate_en_0 ; 
logic physs_registers_wrapper_3_reset_ref_clk_override_0 ; 
logic physs_registers_wrapper_3_reset_pcs100_override_en_0 ; 
logic physs_registers_wrapper_3_clk_gate_en_100G_mac_pcs_0 ; 
logic physs_registers_wrapper_3_power_fsm_clk_gate_en_0 ; 
logic physs_registers_wrapper_3_power_fsm_reset_gate_en_0 ; 
logic parmisc_physs0_pd_vinf_5_bisr_so ; 
logic parmisc_physs1_pd_vinf_5_2_bisr_so ; 
logic parmisc_physs0_pd_vinf_6_bisr_so ; 
logic parmisc_physs1_pd_vinf_6_2_bisr_so ; 
logic parpquad0_DIAG_AGGR_pquad_mbist_diag_done ; 
logic parpquad1_DIAG_AGGR_pquad_mbist_diag_done ; 
logic [7:0] physs_registers_wrapper_1_reset_sd_tx_clk_override_800G_0 ; 
logic [7:0] physs_registers_wrapper_1_reset_sd_rx_clk_override_800G_0 ; 
logic versa_xmp_2_o_ucss_uart_txd ; 
logic versa_xmp_3_o_ucss_uart_txd ; 
logic physs_uart_demux_out2 ; 
logic physs_uart_demux_out3 ; 
logic versa_xmp_0_o_rst_ucss_srds_pcs_rx_reset_pma0_l0_b_a_0 ; 
logic versa_xmp_0_o_rst_ucss_srds_pcs_rx_reset_pma1_l0_b_a_0 ; 
logic versa_xmp_0_o_rst_ucss_srds_pcs_rx_reset_pma2_l0_b_a_0 ; 
logic versa_xmp_0_o_rst_ucss_srds_pcs_rx_reset_pma3_l0_b_a_0 ; 
logic versa_xmp_1_o_rst_ucss_srds_pcs_rx_reset_pma0_l0_b_a_0 ; 
logic versa_xmp_1_o_rst_ucss_srds_pcs_rx_reset_pma1_l0_b_a_0 ; 
logic versa_xmp_1_o_rst_ucss_srds_pcs_rx_reset_pma2_l0_b_a_0 ; 
logic versa_xmp_1_o_rst_ucss_srds_pcs_rx_reset_pma3_l0_b_a_0 ; 
wire xmp_mem_wrapper_2_aary_post_pass ; 
wire xmp_mem_wrapper_2_aary_post_complete ; 
wire xmp_mem_wrapper_3_aary_post_pass ; 
wire xmp_mem_wrapper_3_aary_post_complete ; 
wire pcs100_mem_wrapper_2_aary_post_pass ; 
wire pcs100_mem_wrapper_2_aary_post_complete ; 
wire pcs100_mem_wrapper_3_aary_post_pass ; 
wire pcs100_mem_wrapper_3_aary_post_complete ; 
logic parmisc_physs1_dfx_ubp_ctrl_trig_in_to_parmisc_physs0_ubpc ; 
logic parmisc_physs0_trig_clock_stop_to_parpquad0_pma0_txdat ; 
logic parmisc_physs0_trig_clock_stop_to_parpquad0_pma1_txdat ; 
logic parmisc_physs0_trig_clock_stop_to_parpquad0_pma2_txdat ; 
logic parmisc_physs0_trig_clock_stop_to_parpquad0_pma3_txdat ; 
logic parmisc_physs0_trig_clock_stop_to_parpquad0_o_ck_pma0_rx ; 
logic parmisc_physs0_trig_clock_stop_to_parpquad0_o_ck_pma1_rx ; 
logic parmisc_physs0_trig_clock_stop_to_parpquad0_o_ck_pma2_rx ; 
logic parmisc_physs0_trig_clock_stop_to_parpquad0_o_ck_pma3_rx ; 
logic parmisc_physs0_trig_clock_stop_to_parpquad0_pma0_rxdat ; 
logic parmisc_physs0_trig_clock_stop_to_parpquad0_pma1_rxdat ; 
logic parmisc_physs0_trig_clock_stop_to_parpquad0_pma2_rxdat ; 
logic parmisc_physs0_trig_clock_stop_to_parpquad0_pma3_rxdat ; 
logic parmisc_physs0_trig_clock_stop_to_parpquad0_o_ck_pma0_cmnplla_postdiv ; 
logic parmisc_physs0_trig_clock_stop_to_parpquad0_o_ck_pma1_cmnplla_postdiv ; 
logic parmisc_physs0_trig_clock_stop_to_parpquad0_o_ck_pma2_cmnplla_postdiv ; 
logic parmisc_physs0_trig_clock_stop_to_parpquad0_o_ck_pma3_cmnplla_postdiv ; 
logic parmisc_physs0_trig_clock_stop_to_parpquad0_o_ck_slv_pcs1 ; 
logic parmisc_physs0_trig_clock_stop_to_parpquad0_o_ck_ucss_mem_dram ; 
logic parmisc_physs0_trig_clock_stop_to_parpquad0_o_ck_ucss_mem_iram ; 
logic parmisc_physs0_trig_clock_stop_to_parpquad0_o_ck_ucss_mem_tracemem ; 
logic parmisc_physs0_trig_clock_stop_to_parpquad1_pma0_txdat ; 
logic parmisc_physs0_trig_clock_stop_to_parpquad1_pma1_txdat ; 
logic parmisc_physs0_trig_clock_stop_to_parpquad1_pma2_txdat ; 
logic parmisc_physs0_trig_clock_stop_to_parpquad1_pma3_txdat ; 
logic parmisc_physs0_trig_clock_stop_to_parpquad1_o_ck_pma0_rx ; 
logic parmisc_physs0_trig_clock_stop_to_parpquad1_o_ck_pma1_rx ; 
logic parmisc_physs0_trig_clock_stop_to_parpquad1_o_ck_pma2_rx ; 
logic parmisc_physs0_trig_clock_stop_to_parpquad1_o_ck_pma3_rx ; 
logic parmisc_physs0_trig_clock_stop_to_parpquad1_pma0_rxdat ; 
logic parmisc_physs0_trig_clock_stop_to_parpquad1_pma1_rxdat ; 
logic parmisc_physs0_trig_clock_stop_to_parpquad1_pma2_rxdat ; 
logic parmisc_physs0_trig_clock_stop_to_parpquad1_pma3_rxdat ; 
logic parmisc_physs0_trig_clock_stop_to_parpquad1_o_ck_pma0_cmnplla_postdiv ; 
logic parmisc_physs0_trig_clock_stop_to_parpquad1_o_ck_pma1_cmnplla_postdiv ; 
logic parmisc_physs0_trig_clock_stop_to_parpquad1_o_ck_pma2_cmnplla_postdiv ; 
logic parmisc_physs0_trig_clock_stop_to_parpquad1_o_ck_pma3_cmnplla_postdiv ; 
logic parmisc_physs0_trig_clock_stop_to_parpquad1_o_ck_slv_pcs1 ; 
logic parmisc_physs0_trig_clock_stop_to_parpquad1_o_ck_ucss_mem_dram ; 
logic parmisc_physs0_trig_clock_stop_to_parpquad1_o_ck_ucss_mem_iram ; 
logic parmisc_physs0_trig_clock_stop_to_parpquad1_o_ck_ucss_mem_tracemem ; 
wire [3:0] physs1_ioa_ck_pma0_ref_left_pquad0_physs1 ; 
wire pcs_mac_pipeline_top_wrap_pquad0_0_mac0_xlgmii_tx_clkena ; 
wire pcs_mac_pipeline_top_wrap_pquad0_0_mac0_xlgmii_rx_clkena ; 
wire [7:0] pcs_mac_pipeline_top_wrap_pquad0_0_mac0_xlgmii_rx_rxc ; 
wire [63:0] pcs_mac_pipeline_top_wrap_pquad0_0_mac0_xlgmii_rx_rxd ; 
wire pcs_mac_pipeline_top_wrap_pquad0_0_mac0_xlgmii_rxt0_next ; 
wire [7:0] pcs_mac_pipeline_top_wrap_pquad0_1_pcs0_xlgmii_tx_txc ; 
wire [63:0] pcs_mac_pipeline_top_wrap_pquad0_1_pcs0_xlgmii_tx_txd ; 
wire [1:0] pcs_mac_pipeline_top_wrap_pquad0_0_tsu0_xlgmii_rx_sd ; 
wire [1:0] pcs_mac_pipeline_top_wrap_pquad0_0_tsu0_xlgmii_rx_tsu ; 
wire [1:0] pcs_mac_pipeline_top_wrap_pquad0_0_tsu0_xlgmii_tx_tsu ; 
wire pcs_mac_pipeline_top_wrap_pquad0_0_mac1_xlgmii_tx_clkena ; 
wire pcs_mac_pipeline_top_wrap_pquad0_0_mac1_xlgmii_rx_clkena ; 
wire [7:0] pcs_mac_pipeline_top_wrap_pquad0_0_mac1_xlgmii_rx_rxc ; 
wire [63:0] pcs_mac_pipeline_top_wrap_pquad0_0_mac1_xlgmii_rx_rxd ; 
wire pcs_mac_pipeline_top_wrap_pquad0_0_mac1_xlgmii_rxt0_next ; 
wire [7:0] pcs_mac_pipeline_top_wrap_pquad0_1_pcs1_xlgmii_tx_txc ; 
wire [63:0] pcs_mac_pipeline_top_wrap_pquad0_1_pcs1_xlgmii_tx_txd ; 
wire [1:0] pcs_mac_pipeline_top_wrap_pquad0_0_tsu1_xlgmii_rx_sd ; 
wire [1:0] pcs_mac_pipeline_top_wrap_pquad0_0_tsu1_xlgmii_rx_tsu ; 
wire [1:0] pcs_mac_pipeline_top_wrap_pquad0_0_tsu1_xlgmii_tx_tsu ; 
wire pcs_mac_pipeline_top_wrap_pquad0_0_mac2_xlgmii_tx_clkena ; 
wire pcs_mac_pipeline_top_wrap_pquad0_0_mac2_xlgmii_rx_clkena ; 
wire [7:0] pcs_mac_pipeline_top_wrap_pquad0_0_mac2_xlgmii_rx_rxc ; 
wire [63:0] pcs_mac_pipeline_top_wrap_pquad0_0_mac2_xlgmii_rx_rxd ; 
wire pcs_mac_pipeline_top_wrap_pquad0_0_mac2_xlgmii_rxt0_next ; 
wire [7:0] pcs_mac_pipeline_top_wrap_pquad0_1_pcs2_xlgmii_tx_txc ; 
wire [63:0] pcs_mac_pipeline_top_wrap_pquad0_1_pcs2_xlgmii_tx_txd ; 
wire [1:0] pcs_mac_pipeline_top_wrap_pquad0_0_tsu2_xlgmii_rx_sd ; 
wire [1:0] pcs_mac_pipeline_top_wrap_pquad0_0_tsu2_xlgmii_rx_tsu ; 
wire [1:0] pcs_mac_pipeline_top_wrap_pquad0_0_tsu2_xlgmii_tx_tsu ; 
wire pcs_mac_pipeline_top_wrap_pquad0_0_mac3_xlgmii_tx_clkena ; 
wire pcs_mac_pipeline_top_wrap_pquad0_0_mac3_xlgmii_rx_clkena ; 
wire [7:0] pcs_mac_pipeline_top_wrap_pquad0_0_mac3_xlgmii_rx_rxc ; 
wire [63:0] pcs_mac_pipeline_top_wrap_pquad0_0_mac3_xlgmii_rx_rxd ; 
wire pcs_mac_pipeline_top_wrap_pquad0_0_mac3_xlgmii_rxt0_next ; 
wire [7:0] pcs_mac_pipeline_top_wrap_pquad0_1_pcs3_xlgmii_tx_txc ; 
wire [63:0] pcs_mac_pipeline_top_wrap_pquad0_1_pcs3_xlgmii_tx_txd ; 
wire [1:0] pcs_mac_pipeline_top_wrap_pquad0_0_tsu3_xlgmii_rx_sd ; 
wire [1:0] pcs_mac_pipeline_top_wrap_pquad0_0_tsu3_xlgmii_rx_tsu ; 
wire [1:0] pcs_mac_pipeline_top_wrap_pquad0_0_tsu3_xlgmii_tx_tsu ; 
wire pcs_mac_pipeline_top_wrap_pquad0_0_mac0_cgmii_tx_clkena ; 
wire pcs_mac_pipeline_top_wrap_pquad0_0_mac0_cgmii_rx_clkena ; 
wire [15:0] pcs_mac_pipeline_top_wrap_pquad0_0_mac0_cgmii_rx_rxc ; 
wire [127:0] pcs_mac_pipeline_top_wrap_pquad0_0_mac0_cgmii_rx_rxd ; 
wire [15:0] pcs_mac_pipeline_top_wrap_pquad0_1_pcs0_cgmii_tx_txc ; 
wire [127:0] pcs_mac_pipeline_top_wrap_pquad0_1_pcs0_cgmii_tx_txd ; 
wire pcs_mac_pipeline_top_wrap_pquad0_0_mac1_cgmii_tx_clkena ; 
wire pcs_mac_pipeline_top_wrap_pquad0_0_mac1_cgmii_rx_clkena ; 
wire [15:0] pcs_mac_pipeline_top_wrap_pquad0_0_mac1_cgmii_rx_rxc ; 
wire [127:0] pcs_mac_pipeline_top_wrap_pquad0_0_mac1_cgmii_rx_rxd ; 
wire [15:0] pcs_mac_pipeline_top_wrap_pquad0_1_pcs1_cgmii_tx_txc ; 
wire [127:0] pcs_mac_pipeline_top_wrap_pquad0_1_pcs1_cgmii_tx_txd ; 
wire pcs_mac_pipeline_top_wrap_pquad0_0_mac2_cgmii_tx_clkena ; 
wire pcs_mac_pipeline_top_wrap_pquad0_0_mac2_cgmii_rx_clkena ; 
wire [15:0] pcs_mac_pipeline_top_wrap_pquad0_0_mac2_cgmii_rx_rxc ; 
wire [127:0] pcs_mac_pipeline_top_wrap_pquad0_0_mac2_cgmii_rx_rxd ; 
wire [15:0] pcs_mac_pipeline_top_wrap_pquad0_1_pcs2_cgmii_tx_txc ; 
wire [127:0] pcs_mac_pipeline_top_wrap_pquad0_1_pcs2_cgmii_tx_txd ; 
wire pcs_mac_pipeline_top_wrap_pquad0_0_mac3_cgmii_tx_clkena ; 
wire pcs_mac_pipeline_top_wrap_pquad0_0_mac3_cgmii_rx_clkena ; 
wire [15:0] pcs_mac_pipeline_top_wrap_pquad0_0_mac3_cgmii_rx_rxc ; 
wire [127:0] pcs_mac_pipeline_top_wrap_pquad0_0_mac3_cgmii_rx_rxd ; 
wire [15:0] pcs_mac_pipeline_top_wrap_pquad0_1_pcs3_cgmii_tx_txc ; 
wire [127:0] pcs_mac_pipeline_top_wrap_pquad0_1_pcs3_cgmii_tx_txd ; 
wire pcs_mac_pipeline_top_wrap_pquad1_0_mac0_xlgmii_tx_clkena ; 
wire pcs_mac_pipeline_top_wrap_pquad1_0_mac0_xlgmii_rx_clkena ; 
wire [7:0] pcs_mac_pipeline_top_wrap_pquad1_0_mac0_xlgmii_rx_rxc ; 
wire [63:0] pcs_mac_pipeline_top_wrap_pquad1_0_mac0_xlgmii_rx_rxd ; 
wire pcs_mac_pipeline_top_wrap_pquad1_0_mac0_xlgmii_rxt0_next ; 
wire [7:0] pcs_mac_pipeline_top_wrap_pquad1_1_pcs0_xlgmii_tx_txc ; 
wire [63:0] pcs_mac_pipeline_top_wrap_pquad1_1_pcs0_xlgmii_tx_txd ; 
wire [1:0] pcs_mac_pipeline_top_wrap_pquad1_0_tsu0_xlgmii_rx_sd ; 
wire [1:0] pcs_mac_pipeline_top_wrap_pquad1_0_tsu0_xlgmii_rx_tsu ; 
wire [1:0] pcs_mac_pipeline_top_wrap_pquad1_0_tsu0_xlgmii_tx_tsu ; 
wire pcs_mac_pipeline_top_wrap_pquad1_0_mac1_xlgmii_tx_clkena ; 
wire pcs_mac_pipeline_top_wrap_pquad1_0_mac1_xlgmii_rx_clkena ; 
wire [7:0] pcs_mac_pipeline_top_wrap_pquad1_0_mac1_xlgmii_rx_rxc ; 
wire [63:0] pcs_mac_pipeline_top_wrap_pquad1_0_mac1_xlgmii_rx_rxd ; 
wire pcs_mac_pipeline_top_wrap_pquad1_0_mac1_xlgmii_rxt0_next ; 
wire [7:0] pcs_mac_pipeline_top_wrap_pquad1_1_pcs1_xlgmii_tx_txc ; 
wire [63:0] pcs_mac_pipeline_top_wrap_pquad1_1_pcs1_xlgmii_tx_txd ; 
wire [1:0] pcs_mac_pipeline_top_wrap_pquad1_0_tsu1_xlgmii_rx_sd ; 
wire [1:0] pcs_mac_pipeline_top_wrap_pquad1_0_tsu1_xlgmii_rx_tsu ; 
wire [1:0] pcs_mac_pipeline_top_wrap_pquad1_0_tsu1_xlgmii_tx_tsu ; 
wire pcs_mac_pipeline_top_wrap_pquad1_0_mac2_xlgmii_tx_clkena ; 
wire pcs_mac_pipeline_top_wrap_pquad1_0_mac2_xlgmii_rx_clkena ; 
wire [7:0] pcs_mac_pipeline_top_wrap_pquad1_0_mac2_xlgmii_rx_rxc ; 
wire [63:0] pcs_mac_pipeline_top_wrap_pquad1_0_mac2_xlgmii_rx_rxd ; 
wire pcs_mac_pipeline_top_wrap_pquad1_0_mac2_xlgmii_rxt0_next ; 
wire [7:0] pcs_mac_pipeline_top_wrap_pquad1_1_pcs2_xlgmii_tx_txc ; 
wire [63:0] pcs_mac_pipeline_top_wrap_pquad1_1_pcs2_xlgmii_tx_txd ; 
wire [1:0] pcs_mac_pipeline_top_wrap_pquad1_0_tsu2_xlgmii_rx_sd ; 
wire [1:0] pcs_mac_pipeline_top_wrap_pquad1_0_tsu2_xlgmii_rx_tsu ; 
wire [1:0] pcs_mac_pipeline_top_wrap_pquad1_0_tsu2_xlgmii_tx_tsu ; 
wire pcs_mac_pipeline_top_wrap_pquad1_0_mac3_xlgmii_tx_clkena ; 
wire pcs_mac_pipeline_top_wrap_pquad1_0_mac3_xlgmii_rx_clkena ; 
wire [7:0] pcs_mac_pipeline_top_wrap_pquad1_0_mac3_xlgmii_rx_rxc ; 
wire [63:0] pcs_mac_pipeline_top_wrap_pquad1_0_mac3_xlgmii_rx_rxd ; 
wire pcs_mac_pipeline_top_wrap_pquad1_0_mac3_xlgmii_rxt0_next ; 
wire [7:0] pcs_mac_pipeline_top_wrap_pquad1_1_pcs3_xlgmii_tx_txc ; 
wire [63:0] pcs_mac_pipeline_top_wrap_pquad1_1_pcs3_xlgmii_tx_txd ; 
wire [1:0] pcs_mac_pipeline_top_wrap_pquad1_0_tsu3_xlgmii_rx_sd ; 
wire [1:0] pcs_mac_pipeline_top_wrap_pquad1_0_tsu3_xlgmii_rx_tsu ; 
wire [1:0] pcs_mac_pipeline_top_wrap_pquad1_0_tsu3_xlgmii_tx_tsu ; 
wire pcs_mac_pipeline_top_wrap_pquad1_0_mac0_cgmii_tx_clkena ; 
wire pcs_mac_pipeline_top_wrap_pquad1_0_mac0_cgmii_rx_clkena ; 
wire [15:0] pcs_mac_pipeline_top_wrap_pquad1_0_mac0_cgmii_rx_rxc ; 
wire [127:0] pcs_mac_pipeline_top_wrap_pquad1_0_mac0_cgmii_rx_rxd ; 
wire [15:0] pcs_mac_pipeline_top_wrap_pquad1_1_pcs0_cgmii_tx_txc ; 
wire [127:0] pcs_mac_pipeline_top_wrap_pquad1_1_pcs0_cgmii_tx_txd ; 
wire pcs_mac_pipeline_top_wrap_pquad1_0_mac1_cgmii_tx_clkena ; 
wire pcs_mac_pipeline_top_wrap_pquad1_0_mac1_cgmii_rx_clkena ; 
wire [15:0] pcs_mac_pipeline_top_wrap_pquad1_0_mac1_cgmii_rx_rxc ; 
wire [127:0] pcs_mac_pipeline_top_wrap_pquad1_0_mac1_cgmii_rx_rxd ; 
wire [15:0] pcs_mac_pipeline_top_wrap_pquad1_1_pcs1_cgmii_tx_txc ; 
wire [127:0] pcs_mac_pipeline_top_wrap_pquad1_1_pcs1_cgmii_tx_txd ; 
wire pcs_mac_pipeline_top_wrap_pquad1_0_mac2_cgmii_tx_clkena ; 
wire pcs_mac_pipeline_top_wrap_pquad1_0_mac2_cgmii_rx_clkena ; 
wire [15:0] pcs_mac_pipeline_top_wrap_pquad1_0_mac2_cgmii_rx_rxc ; 
wire [127:0] pcs_mac_pipeline_top_wrap_pquad1_0_mac2_cgmii_rx_rxd ; 
wire [15:0] pcs_mac_pipeline_top_wrap_pquad1_1_pcs2_cgmii_tx_txc ; 
wire [127:0] pcs_mac_pipeline_top_wrap_pquad1_1_pcs2_cgmii_tx_txd ; 
wire pcs_mac_pipeline_top_wrap_pquad1_0_mac3_cgmii_tx_clkena ; 
wire pcs_mac_pipeline_top_wrap_pquad1_0_mac3_cgmii_rx_clkena ; 
wire [15:0] pcs_mac_pipeline_top_wrap_pquad1_0_mac3_cgmii_rx_rxc ; 
wire [127:0] pcs_mac_pipeline_top_wrap_pquad1_0_mac3_cgmii_rx_rxd ; 
wire [15:0] pcs_mac_pipeline_top_wrap_pquad1_1_pcs3_cgmii_tx_txc ; 
wire [127:0] pcs_mac_pipeline_top_wrap_pquad1_1_pcs3_cgmii_tx_txd ; 
wire [3:0] physs0_ioa_ck_pma0_ref_left_mquad1_physs0 ; 
logic parmisc_physs0_BSCAN_PIPE_OUT_TO_parmisc_physs1_scan_in ; 
logic parmisc_physs1_BSCAN_PIPE_OUT_scan_out ; 
logic parmisc_physs0_BSCAN_PIPE_OUT_TO_parmisc_physs1_force_disable ; 
logic parmisc_physs0_BSCAN_PIPE_OUT_TO_parmisc_physs1_select_jtag_input ; 
logic parmisc_physs0_BSCAN_PIPE_OUT_TO_parmisc_physs1_select_jtag_output ; 
logic parmisc_physs0_BSCAN_PIPE_OUT_TO_parmisc_physs1_ac_init_clock0 ; 
logic parmisc_physs0_BSCAN_PIPE_OUT_TO_parmisc_physs1_ac_init_clock1 ; 
logic parmisc_physs0_BSCAN_PIPE_OUT_TO_parmisc_physs1_ac_signal ; 
logic parmisc_physs0_BSCAN_PIPE_OUT_TO_parmisc_physs1_ac_mode_en ; 
logic parmisc_physs0_BSCAN_PIPE_OUT_TO_parmisc_physs1_intel_update_clk ; 
logic parmisc_physs0_BSCAN_PIPE_OUT_TO_parmisc_physs1_intel_clamp_en ; 
logic parmisc_physs0_BSCAN_PIPE_OUT_TO_parmisc_physs1_intel_bscan_mode ; 
logic parmisc_physs0_BSCAN_PIPE_OUT_TO_parmisc_physs1_select ; 
logic parmisc_physs0_BSCAN_PIPE_OUT_TO_parmisc_physs1_bscan_clock ; 
logic parmisc_physs0_BSCAN_PIPE_OUT_TO_parmisc_physs1_capture_en ; 
logic parmisc_physs0_BSCAN_PIPE_OUT_TO_parmisc_physs1_shift_en ; 
logic parmisc_physs0_BSCAN_PIPE_OUT_TO_parmisc_physs1_update_en ; 
logic parmisc_physs1_BSCAN_PIPE_OUT_2_bscan_to_intel_d6actestsig_b ; 
logic parmisc_physs0_BSCAN_PIPE_OUT_2_bscan_to_intel_d6actestsig_b ; 
logic [31:0] physs1_SSN_END_chain_towards_parmisc_physs0_bus_data_out ; 
logic [31:0] physs0_SSN_END_towards_parmisc_physs1_bus_data_out ; 
logic parmisc_physs1_NW_IN_tdo ; 
logic parmisc_physs1_NW_IN_tdo_en ; 
logic parmisc_physs0_NW_OUT_parmisc_physs1_ijtag_to_reset ; 
logic parmisc_physs0_NW_OUT_parmisc_physs1_ijtag_to_ce ; 
logic parmisc_physs0_NW_OUT_parmisc_physs1_ijtag_to_se ; 
logic parmisc_physs0_NW_OUT_parmisc_physs1_ijtag_to_ue ; 
logic parmisc_physs0_NW_OUT_parmisc_physs1_ijtag_to_sel ; 
logic parmisc_physs0_NW_OUT_parmisc_physs1_ijtag_to_si ; 
logic parmisc_physs1_NW_IN_ijtag_so ; 
logic parmisc_physs1_NW_IN_tap_sel_out ;

// ============================================================================
// CDC: XLGMII CDC Wire Declarations (112 wires total = 7 signals × 16 interfaces)
// These wires connect between CDC wrappers and physs0 module for clock domain crossing
// Naming convention:
//   - physs_hlp_xlgmii*_rx* : RX path from physs0 to CDC
//   - hlp_physs_xlgmii*_tx* : TX path from CDC to physs0
//   - physs_hlp_xlgmii*_txclk_ena : TX clock enable from physs0 to CDC
// Suffix: _0=MQUAD0, _1=MQUAD1, _2=PQUAD0, _3=PQUAD1
// ============================================================================

logic [7:0] physs_hlp_xlgmii0_rxc_0;
logic [63:0] physs_hlp_xlgmii0_rxd_0;
logic physs_hlp_xlgmii0_rxt0_next_0;
logic physs_hlp_xlgmii0_rxclk_ena_0;
logic [63:0] hlp_physs_xlgmii0_txd_0;
logic [7:0] hlp_physs_xlgmii0_txc_0;
logic physs_hlp_xlgmii0_txclk_ena_0;
logic [7:0] physs_hlp_xlgmii1_rxc_0;
logic [63:0] physs_hlp_xlgmii1_rxd_0;
logic physs_hlp_xlgmii1_rxt0_next_0;
logic physs_hlp_xlgmii1_rxclk_ena_0;
logic [63:0] hlp_physs_xlgmii1_txd_0;
logic [7:0] hlp_physs_xlgmii1_txc_0;
logic physs_hlp_xlgmii1_txclk_ena_0;
logic [7:0] physs_hlp_xlgmii2_rxc_0;
logic [63:0] physs_hlp_xlgmii2_rxd_0;
logic physs_hlp_xlgmii2_rxt0_next_0;
logic physs_hlp_xlgmii2_rxclk_ena_0;
logic [63:0] hlp_physs_xlgmii2_txd_0;
logic [7:0] hlp_physs_xlgmii2_txc_0;
logic physs_hlp_xlgmii2_txclk_ena_0;
logic [7:0] physs_hlp_xlgmii3_rxc_0;
logic [63:0] physs_hlp_xlgmii3_rxd_0;
logic physs_hlp_xlgmii3_rxt0_next_0;
logic physs_hlp_xlgmii3_rxclk_ena_0;
logic [63:0] hlp_physs_xlgmii3_txd_0;
logic [7:0] hlp_physs_xlgmii3_txc_0;
logic physs_hlp_xlgmii3_txclk_ena_0;
logic [7:0] physs_hlp_xlgmii0_rxc_1;
logic [63:0] physs_hlp_xlgmii0_rxd_1;
logic physs_hlp_xlgmii0_rxt0_next_1;
logic physs_hlp_xlgmii0_rxclk_ena_1;
logic [63:0] hlp_physs_xlgmii0_txd_1;
logic [7:0] hlp_physs_xlgmii0_txc_1;
logic physs_hlp_xlgmii0_txclk_ena_1;
logic [7:0] physs_hlp_xlgmii1_rxc_1;
logic [63:0] physs_hlp_xlgmii1_rxd_1;
logic physs_hlp_xlgmii1_rxt0_next_1;
logic physs_hlp_xlgmii1_rxclk_ena_1;
logic [63:0] hlp_physs_xlgmii1_txd_1;
logic [7:0] hlp_physs_xlgmii1_txc_1;
logic physs_hlp_xlgmii1_txclk_ena_1;
logic [7:0] physs_hlp_xlgmii2_rxc_1;
logic [63:0] physs_hlp_xlgmii2_rxd_1;
logic physs_hlp_xlgmii2_rxt0_next_1;
logic physs_hlp_xlgmii2_rxclk_ena_1;
logic [63:0] hlp_physs_xlgmii2_txd_1;
logic [7:0] hlp_physs_xlgmii2_txc_1;
logic physs_hlp_xlgmii2_txclk_ena_1;
logic [7:0] physs_hlp_xlgmii3_rxc_1;
logic [63:0] physs_hlp_xlgmii3_rxd_1;
logic physs_hlp_xlgmii3_rxt0_next_1;
logic physs_hlp_xlgmii3_rxclk_ena_1;
logic [63:0] hlp_physs_xlgmii3_txd_1;
logic [7:0] hlp_physs_xlgmii3_txc_1;
logic physs_hlp_xlgmii3_txclk_ena_1;
logic [7:0] physs_hlp_xlgmii0_rxc_2;
logic [63:0] physs_hlp_xlgmii0_rxd_2;
logic physs_hlp_xlgmii0_rxt0_next_2;
logic physs_hlp_xlgmii0_rxclk_ena_2;
logic [63:0] hlp_physs_xlgmii0_txd_2;
logic [7:0] hlp_physs_xlgmii0_txc_2;
logic physs_hlp_xlgmii0_txclk_ena_2;
logic [7:0] physs_hlp_xlgmii1_rxc_2;
logic [63:0] physs_hlp_xlgmii1_rxd_2;
logic physs_hlp_xlgmii1_rxt0_next_2;
logic physs_hlp_xlgmii1_rxclk_ena_2;
logic [63:0] hlp_physs_xlgmii1_txd_2;
logic [7:0] hlp_physs_xlgmii1_txc_2;
logic physs_hlp_xlgmii1_txclk_ena_2;
logic [7:0] physs_hlp_xlgmii2_rxc_2;
logic [63:0] physs_hlp_xlgmii2_rxd_2;
logic physs_hlp_xlgmii2_rxt0_next_2;
logic physs_hlp_xlgmii2_rxclk_ena_2;
logic [63:0] hlp_physs_xlgmii2_txd_2;
logic [7:0] hlp_physs_xlgmii2_txc_2;
logic physs_hlp_xlgmii2_txclk_ena_2;
logic [7:0] physs_hlp_xlgmii3_rxc_2;
logic [63:0] physs_hlp_xlgmii3_rxd_2;
logic physs_hlp_xlgmii3_rxt0_next_2;
logic physs_hlp_xlgmii3_rxclk_ena_2;
logic [63:0] hlp_physs_xlgmii3_txd_2;
logic [7:0] hlp_physs_xlgmii3_txc_2;
logic physs_hlp_xlgmii3_txclk_ena_2;
logic [7:0] physs_hlp_xlgmii0_rxc_3;
logic [63:0] physs_hlp_xlgmii0_rxd_3;
logic physs_hlp_xlgmii0_rxt0_next_3;
logic physs_hlp_xlgmii0_rxclk_ena_3;
logic [63:0] hlp_physs_xlgmii0_txd_3;
logic [7:0] hlp_physs_xlgmii0_txc_3;
logic physs_hlp_xlgmii0_txclk_ena_3;
logic [7:0] physs_hlp_xlgmii1_rxc_3;
logic [63:0] physs_hlp_xlgmii1_rxd_3;
logic physs_hlp_xlgmii1_rxt0_next_3;
logic physs_hlp_xlgmii1_rxclk_ena_3;
logic [63:0] hlp_physs_xlgmii1_txd_3;
logic [7:0] hlp_physs_xlgmii1_txc_3;
logic physs_hlp_xlgmii1_txclk_ena_3;
logic [7:0] physs_hlp_xlgmii2_rxc_3;
logic [63:0] physs_hlp_xlgmii2_rxd_3;
logic physs_hlp_xlgmii2_rxt0_next_3;
logic physs_hlp_xlgmii2_rxclk_ena_3;
logic [63:0] hlp_physs_xlgmii2_txd_3;
logic [7:0] hlp_physs_xlgmii2_txc_3;
logic physs_hlp_xlgmii2_txclk_ena_3;
logic [7:0] physs_hlp_xlgmii3_rxc_3;
logic [63:0] physs_hlp_xlgmii3_rxd_3;
logic physs_hlp_xlgmii3_rxt0_next_3;
logic physs_hlp_xlgmii3_rxclk_ena_3;
logic [63:0] hlp_physs_xlgmii3_txd_3;
logic [7:0] hlp_physs_xlgmii3_txc_3;
logic physs_hlp_xlgmii3_txclk_ena_3;
// EDIT_NET END

// EDIT_INSTANCE BEGIN
physs0 physs0 (
    .mbp_repeater_odi_parmisc_physs0_5_ubp_out(mbp_repeater_odi_parmisc_physs0_5_ubp_out), 
    .mbp_repeater_sfe_parmisc_physs0_2_ubp_out(mbp_repeater_sfe_parmisc_physs0_2_ubp_out), 
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
    .versa_xmp_0_xoa_pma0_tx_n_l0(ETH_TXN0), 
    .versa_xmp_0_xoa_pma0_tx_p_l0(ETH_TXP0), 
    .versa_xmp_0_xoa_pma1_tx_n_l0(ETH_TXN1), 
    .versa_xmp_0_xoa_pma1_tx_p_l0(ETH_TXP1), 
    .versa_xmp_0_xoa_pma2_tx_n_l0(ETH_TXN2), 
    .versa_xmp_0_xoa_pma2_tx_p_l0(ETH_TXP2), 
    .versa_xmp_0_xoa_pma3_tx_n_l0(ETH_TXN3), 
    .versa_xmp_0_xoa_pma3_tx_p_l0(ETH_TXP3), 
    .ETH_RXN4(ETH_RXN4), 
    .ETH_RXP4(ETH_RXP4), 
    .ETH_RXN5(ETH_RXN5), 
    .ETH_RXP5(ETH_RXP5), 
    .ETH_RXN6(ETH_RXN6), 
    .ETH_RXP6(ETH_RXP6), 
    .ETH_RXN7(ETH_RXN7), 
    .ETH_RXP7(ETH_RXP7), 
    .versa_xmp_1_xoa_pma0_tx_n_l0(ETH_TXN4), 
    .versa_xmp_1_xoa_pma0_tx_p_l0(ETH_TXP4), 
    .versa_xmp_1_xoa_pma1_tx_n_l0(ETH_TXN5), 
    .versa_xmp_1_xoa_pma1_tx_p_l0(ETH_TXP5), 
    .versa_xmp_1_xoa_pma2_tx_n_l0(ETH_TXN6), 
    .versa_xmp_1_xoa_pma2_tx_p_l0(ETH_TXP6), 
    .versa_xmp_1_xoa_pma3_tx_n_l0(ETH_TXN7), 
    .versa_xmp_1_xoa_pma3_tx_p_l0(ETH_TXP7), 
    .ioa_pma_remote_diode_i_anode(ioa_pma_remote_diode_i_anode[0]), 
    .ioa_pma_remote_diode_i_anode_0(ioa_pma_remote_diode_i_anode[1]), 
    .ioa_pma_remote_diode_i_anode_1(ioa_pma_remote_diode_i_anode[2]), 
    .ioa_pma_remote_diode_i_anode_2(ioa_pma_remote_diode_i_anode[3]), 
    .ioa_pma_remote_diode_i_anode_3(ioa_pma_remote_diode_i_anode[4]), 
    .ioa_pma_remote_diode_i_anode_4(ioa_pma_remote_diode_i_anode[5]), 
    .ioa_pma_remote_diode_i_anode_5(ioa_pma_remote_diode_i_anode[6]), 
    .ioa_pma_remote_diode_i_anode_6(ioa_pma_remote_diode_i_anode[7]), 
    .ioa_pma_remote_diode_v_anode(ioa_pma_remote_diode_v_anode[0]), 
    .ioa_pma_remote_diode_v_anode_0(ioa_pma_remote_diode_v_anode[1]), 
    .ioa_pma_remote_diode_v_anode_1(ioa_pma_remote_diode_v_anode[2]), 
    .ioa_pma_remote_diode_v_anode_2(ioa_pma_remote_diode_v_anode[3]), 
    .ioa_pma_remote_diode_v_anode_3(ioa_pma_remote_diode_v_anode[4]), 
    .ioa_pma_remote_diode_v_anode_4(ioa_pma_remote_diode_v_anode[5]), 
    .ioa_pma_remote_diode_v_anode_5(ioa_pma_remote_diode_v_anode[6]), 
    .ioa_pma_remote_diode_v_anode_6(ioa_pma_remote_diode_v_anode[7]), 
    .ioa_pma_remote_diode_i_cathode(ioa_pma_remote_diode_i_cathode[0]), 
    .ioa_pma_remote_diode_i_cathode_0(ioa_pma_remote_diode_i_cathode[1]), 
    .ioa_pma_remote_diode_i_cathode_1(ioa_pma_remote_diode_i_cathode[2]), 
    .ioa_pma_remote_diode_i_cathode_2(ioa_pma_remote_diode_i_cathode[3]), 
    .ioa_pma_remote_diode_i_cathode_3(ioa_pma_remote_diode_i_cathode[4]), 
    .ioa_pma_remote_diode_i_cathode_4(ioa_pma_remote_diode_i_cathode[5]), 
    .ioa_pma_remote_diode_i_cathode_5(ioa_pma_remote_diode_i_cathode[6]), 
    .ioa_pma_remote_diode_i_cathode_6(ioa_pma_remote_diode_i_cathode[7]), 
    .ioa_pma_remote_diode_v_cathode(ioa_pma_remote_diode_v_cathode[0]), 
    .ioa_pma_remote_diode_v_cathode_0(ioa_pma_remote_diode_v_cathode[1]), 
    .ioa_pma_remote_diode_v_cathode_1(ioa_pma_remote_diode_v_cathode[2]), 
    .ioa_pma_remote_diode_v_cathode_2(ioa_pma_remote_diode_v_cathode[3]), 
    .ioa_pma_remote_diode_v_cathode_3(ioa_pma_remote_diode_v_cathode[4]), 
    .ioa_pma_remote_diode_v_cathode_4(ioa_pma_remote_diode_v_cathode[5]), 
    .ioa_pma_remote_diode_v_cathode_5(ioa_pma_remote_diode_v_cathode[6]), 
    .ioa_pma_remote_diode_v_cathode_6(ioa_pma_remote_diode_v_cathode[7]), 
    .quadpcs100_2_pcs_link_status(quadpcs100_2_pcs_link_status), 
    .quadpcs100_3_pcs_link_status(quadpcs100_3_pcs_link_status), 
    .physs_reset_prep_req(physs_reset_prep_req), 
    .physs_reset_prep_ack_double_sync_physs_scon_reset_prep_ack_sync(physs_reset_prep_ack), 
    .physs_hd2prf_trim_fuse_in(physs_hd2prf_trim_fuse_in), 
    .physs_hs2prf_trim_fuse_in(physs_hs2prf_trim_fuse_in), 
    .physs_rfhs_trim_fuse_in(physs_rfhs_trim_fuse_in), 
    .physs_hdspsr_trim_fuse_in(physs_hdspsr_trim_fuse_in), 
    .physs_bbl_800G_0_disable(physs_bbl_800G_0_disable), 
    .physs_bbl_400G_0_disable(physs_bbl_400G_0_disable), 
    .physs_bbl_200G_0_disable(physs_bbl_200G_0_disable), 
    .physs_bbl_100G_0_disable(physs_bbl_100G_0_disable), 
    .physs_bbl_400G_1_disable(physs_bbl_400G_1_disable), 
    .physs_bbl_200G_1_disable(physs_bbl_200G_1_disable), 
    .physs_bbl_100G_1_disable(physs_bbl_100G_1_disable), 
    .physs_bbl_serdes_0_disable(physs_bbl_serdes_0_disable), 
    .physs_bbl_serdes_1_disable(physs_bbl_serdes_1_disable), 
    .physs_bbl_spare_0(physs_bbl_spare_0), 
    .physs_bbl_spare_1(physs_bbl_spare_1), 
    .ack_from_fabric_0(ack_from_fabric_0), 
    .req_from_fabric_0(req_from_fabric_0), 
    .dfd_rtb_trig_ctf_adapter_0_trig_req_to_fabric(trig_req_to_fabric_0), 
    .dfd_rtb_trig_ctf_adapter_0_ack_to_fabric(ack_to_fabric_0), 
    .ack_from_fabric_1(ack_from_fabric_1), 
    .req_from_fabric_1(req_from_fabric_1), 
    .dfd_rtb_trig_ctf_adapter_1_trig_req_to_fabric(trig_req_to_fabric_1), 
    .dfd_rtb_trig_ctf_adapter_1_ack_to_fabric(ack_to_fabric_1), 
    .physs_bbl_100G_2_disable(physs_bbl_100G_2_disable), 
    .physs_bbl_100G_3_disable(physs_bbl_100G_3_disable), 
    .ethphyss_post_clkungate(ethphyss_post_clkungate), 
    .physs_intf0_clk_adop_parmisc_physs0_clkout_0(physs_intf0_clk_out), 
    .soc_per_clk_adop_parmisc_physs0_clkout_0(soc_per_clk_adop_parmisc_physs0_clkout_0), 
    .physs_func_clk_adop_parmisc_physs0_clkout(physs_func_clk_adop_parmisc_physs0_clkout), 
    .physs_intf0_clk(physs_intf0_clk), 
    .physs_funcx2_clk(physs_funcx2_clk), 
    .soc_per_clk(soc_per_clk), 
    .tsu_clk(tsu_clk), 
    .o_ck_pma0_rx_postdiv_l0_adop_parpquad0_clkout(o_ck_pma0_rx_postdiv_l0_adop_parpquad0_clkout), 
    .o_ck_pma1_rx_postdiv_l0_adop_parpquad0_clkout(o_ck_pma1_rx_postdiv_l0_adop_parpquad0_clkout), 
    .o_ck_pma2_rx_postdiv_l0_adop_parpquad0_clkout(o_ck_pma2_rx_postdiv_l0_adop_parpquad0_clkout), 
    .o_ck_pma3_rx_postdiv_l0_adop_parpquad0_clkout(o_ck_pma3_rx_postdiv_l0_adop_parpquad0_clkout), 
    .o_ck_pma0_rx_postdiv_l0_adop_parpquad1_clkout(o_ck_pma0_rx_postdiv_l0_adop_parpquad1_clkout), 
    .o_ck_pma1_rx_postdiv_l0_adop_parpquad1_clkout(o_ck_pma1_rx_postdiv_l0_adop_parpquad1_clkout), 
    .o_ck_pma2_rx_postdiv_l0_adop_parpquad1_clkout(o_ck_pma2_rx_postdiv_l0_adop_parpquad1_clkout), 
    .o_ck_pma3_rx_postdiv_l0_adop_parpquad1_clkout(o_ck_pma3_rx_postdiv_l0_adop_parpquad1_clkout), 
    .fscan_txrxword_byp_clk(fscan_txrxword_byp_clk), 
    .o_ck_pma0_cmnplla_postdiv_clk_mux_parmquad0_clkout(o_ck_pma0_cmnplla_postdiv_clk_mux_parmquad0_clkout), 
    .fscan_ref_clk(fscan_ref_clk), 
    .fscan_ref_clk_adop_parmisc_physs0_clkout_0(fscan_ref_clk_adop_parmisc_physs0_clkout_0), 
    .nss_cosq_clk0(nss_cosq_clk0), 
    .nss_cosq_clk1(nss_cosq_clk1), 
    .clk_1588_freq(clk_1588_freq), 
    .i_ck_ucss_uart_sclk(i_ck_ucss_uart_sclk), 
    .uart_clk_adop_parmisc_physs0_clkout_0(uart_clk_adop_parmisc_physs0_clkout_0), 
    .fifo_top_mux_0_physs0_icq_port_0_link_stat(physs_icq_port_0_link_stat), 
    .fifo_top_mux_0_physs0_mse_port_0_link_speed(physs_mse_port_0_link_speed), 
    .fifo_top_mux_0_physs0_mse_port_0_rx_dval(physs_mse_port_0_rx_dval), 
    .fifo_top_mux_0_physs0_mse_port_0_rx_data(physs_mse_port_0_rx_data), 
    .fifo_top_mux_0_physs0_mse_port_0_rx_sop(physs_mse_port_0_rx_sop), 
    .fifo_top_mux_0_physs0_mse_port_0_rx_eop(physs_mse_port_0_rx_eop), 
    .fifo_top_mux_0_physs0_mse_port_0_rx_mod(physs_mse_port_0_rx_mod), 
    .fifo_top_mux_0_physs0_mse_port_0_rx_err(physs_mse_port_0_rx_err), 
    .fifo_top_mux_0_physs0_mse_port_0_rx_ecc_err(physs_mse_port_0_rx_ecc_err), 
    .fifo_top_mux_0_physs0_mse_port_0_rx_ts(physs_mse_port_0_rx_ts), 
    .fifo_top_mux_0_physs0_mse_port_0_tx_rdy(physs_mse_port_0_tx_rdy), 
    .fifo_top_mux_0_physs0_mse_port_0_pfc_mode(physs_icq_port_0_pfc_mode), 
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
    .fifo_top_mux_0_physs0_icq_port_1_link_stat(physs_icq_port_1_link_stat), 
    .fifo_top_mux_0_physs0_mse_port_1_link_speed(physs_mse_port_1_link_speed), 
    .fifo_top_mux_0_physs0_mse_port_1_rx_dval(physs_mse_port_1_rx_dval), 
    .fifo_top_mux_0_physs0_mse_port_1_rx_data(physs_mse_port_1_rx_data), 
    .fifo_top_mux_0_physs0_mse_port_1_rx_sop(physs_mse_port_1_rx_sop), 
    .fifo_top_mux_0_physs0_mse_port_1_rx_eop(physs_mse_port_1_rx_eop), 
    .fifo_top_mux_0_physs0_mse_port_1_rx_mod(physs_mse_port_1_rx_mod), 
    .fifo_top_mux_0_physs0_mse_port_1_rx_err(physs_mse_port_1_rx_err), 
    .fifo_top_mux_0_physs0_mse_port_1_rx_ecc_err(physs_mse_port_1_rx_ecc_err), 
    .fifo_top_mux_0_physs0_mse_port_1_rx_ts(physs_mse_port_1_rx_ts), 
    .fifo_top_mux_0_physs0_mse_port_1_tx_rdy(physs_mse_port_1_tx_rdy), 
    .fifo_top_mux_0_physs0_mse_port_1_pfc_mode(physs_icq_port_1_pfc_mode), 
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
    .fifo_top_mux_0_physs0_icq_port_2_link_stat(physs_icq_port_2_link_stat), 
    .fifo_top_mux_0_physs0_mse_port_2_link_speed(physs_mse_port_2_link_speed), 
    .fifo_top_mux_0_physs0_mse_port_2_rx_dval(physs_mse_port_2_rx_dval), 
    .fifo_top_mux_0_physs0_mse_port_2_rx_data(physs_mse_port_2_rx_data), 
    .fifo_top_mux_0_physs0_mse_port_2_rx_sop(physs_mse_port_2_rx_sop), 
    .fifo_top_mux_0_physs0_mse_port_2_rx_eop(physs_mse_port_2_rx_eop), 
    .fifo_top_mux_0_physs0_mse_port_2_rx_mod(physs_mse_port_2_rx_mod), 
    .fifo_top_mux_0_physs0_mse_port_2_rx_err(physs_mse_port_2_rx_err), 
    .fifo_top_mux_0_physs0_mse_port_2_rx_ecc_err(physs_mse_port_2_rx_ecc_err), 
    .fifo_top_mux_0_physs0_mse_port_2_rx_ts(physs_mse_port_2_rx_ts), 
    .fifo_top_mux_0_physs0_mse_port_2_tx_rdy(physs_mse_port_2_tx_rdy), 
    .fifo_top_mux_0_physs0_mse_port_2_pfc_mode(physs_icq_port_2_pfc_mode), 
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
    .fifo_top_mux_0_physs0_icq_port_3_link_stat(physs_icq_port_3_link_stat), 
    .fifo_top_mux_0_physs0_mse_port_3_link_speed(physs_mse_port_3_link_speed), 
    .fifo_top_mux_0_physs0_mse_port_3_rx_dval(physs_mse_port_3_rx_dval), 
    .fifo_top_mux_0_physs0_mse_port_3_rx_data(physs_mse_port_3_rx_data), 
    .fifo_top_mux_0_physs0_mse_port_3_rx_sop(physs_mse_port_3_rx_sop), 
    .fifo_top_mux_0_physs0_mse_port_3_rx_eop(physs_mse_port_3_rx_eop), 
    .fifo_top_mux_0_physs0_mse_port_3_rx_mod(physs_mse_port_3_rx_mod), 
    .fifo_top_mux_0_physs0_mse_port_3_rx_err(physs_mse_port_3_rx_err), 
    .fifo_top_mux_0_physs0_mse_port_3_rx_ecc_err(physs_mse_port_3_rx_ecc_err), 
    .fifo_top_mux_0_physs0_mse_port_3_rx_ts(physs_mse_port_3_rx_ts), 
    .fifo_top_mux_0_physs0_mse_port_3_tx_rdy(physs_mse_port_3_tx_rdy), 
    .fifo_top_mux_0_physs0_mse_port_3_pfc_mode(physs_icq_port_3_pfc_mode), 
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
    .fifo_top_mux_0_physs1_icq_port_4_link_stat(physs_icq_port_4_link_stat), 
    .fifo_top_mux_0_physs1_mse_port_4_link_speed(physs_mse_port_4_link_speed), 
    .fifo_top_mux_0_physs1_mse_port_4_rx_dval(physs_mse_port_4_rx_dval), 
    .fifo_top_mux_0_physs1_mse_port_4_rx_data(physs_mse_port_4_rx_data), 
    .fifo_top_mux_0_physs1_mse_port_4_rx_sop(physs_mse_port_4_rx_sop), 
    .fifo_top_mux_0_physs1_mse_port_4_rx_eop(physs_mse_port_4_rx_eop), 
    .fifo_top_mux_0_physs1_mse_port_4_rx_mod(physs_mse_port_4_rx_mod), 
    .fifo_top_mux_0_physs1_mse_port_4_rx_err(physs_mse_port_4_rx_err), 
    .fifo_top_mux_0_physs1_mse_port_4_rx_ecc_err(physs_mse_port_4_rx_ecc_err), 
    .fifo_top_mux_0_physs1_mse_port_4_rx_ts(physs_mse_port_4_rx_ts), 
    .fifo_top_mux_0_physs1_mse_port_4_tx_rdy(physs_mse_port_4_tx_rdy), 
    .fifo_top_mux_0_physs1_mse_port_4_pfc_mode(physs_icq_port_4_pfc_mode), 
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
    .fifo_top_mux_0_physs1_icq_port_5_link_stat(physs_icq_port_5_link_stat), 
    .fifo_top_mux_0_physs1_mse_port_5_link_speed(physs_mse_port_5_link_speed), 
    .fifo_top_mux_0_physs1_mse_port_5_rx_dval(physs_mse_port_5_rx_dval), 
    .fifo_top_mux_0_physs1_mse_port_5_rx_data(physs_mse_port_5_rx_data), 
    .fifo_top_mux_0_physs1_mse_port_5_rx_sop(physs_mse_port_5_rx_sop), 
    .fifo_top_mux_0_physs1_mse_port_5_rx_eop(physs_mse_port_5_rx_eop), 
    .fifo_top_mux_0_physs1_mse_port_5_rx_mod(physs_mse_port_5_rx_mod), 
    .fifo_top_mux_0_physs1_mse_port_5_rx_err(physs_mse_port_5_rx_err), 
    .fifo_top_mux_0_physs1_mse_port_5_rx_ecc_err(physs_mse_port_5_rx_ecc_err), 
    .fifo_top_mux_0_physs1_mse_port_5_rx_ts(physs_mse_port_5_rx_ts), 
    .fifo_top_mux_0_physs1_mse_port_5_tx_rdy(physs_mse_port_5_tx_rdy), 
    .fifo_top_mux_0_physs1_mse_port_5_pfc_mode(physs_icq_port_5_pfc_mode), 
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
    .fifo_top_mux_0_physs1_icq_port_6_link_stat(physs_icq_port_6_link_stat), 
    .fifo_top_mux_0_physs1_mse_port_6_link_speed(physs_mse_port_6_link_speed), 
    .fifo_top_mux_0_physs1_mse_port_6_rx_dval(physs_mse_port_6_rx_dval), 
    .fifo_top_mux_0_physs1_mse_port_6_rx_data(physs_mse_port_6_rx_data), 
    .fifo_top_mux_0_physs1_mse_port_6_rx_sop(physs_mse_port_6_rx_sop), 
    .fifo_top_mux_0_physs1_mse_port_6_rx_eop(physs_mse_port_6_rx_eop), 
    .fifo_top_mux_0_physs1_mse_port_6_rx_mod(physs_mse_port_6_rx_mod), 
    .fifo_top_mux_0_physs1_mse_port_6_rx_err(physs_mse_port_6_rx_err), 
    .fifo_top_mux_0_physs1_mse_port_6_rx_ecc_err(physs_mse_port_6_rx_ecc_err), 
    .fifo_top_mux_0_physs1_mse_port_6_rx_ts(physs_mse_port_6_rx_ts), 
    .fifo_top_mux_0_physs1_mse_port_6_tx_rdy(physs_mse_port_6_tx_rdy), 
    .fifo_top_mux_0_physs1_mse_port_6_pfc_mode(physs_icq_port_6_pfc_mode), 
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
    .fifo_top_mux_0_physs1_icq_port_7_link_stat(physs_icq_port_7_link_stat), 
    .fifo_top_mux_0_physs1_mse_port_7_link_speed(physs_mse_port_7_link_speed), 
    .fifo_top_mux_0_physs1_mse_port_7_rx_dval(physs_mse_port_7_rx_dval), 
    .fifo_top_mux_0_physs1_mse_port_7_rx_data(physs_mse_port_7_rx_data), 
    .fifo_top_mux_0_physs1_mse_port_7_rx_sop(physs_mse_port_7_rx_sop), 
    .fifo_top_mux_0_physs1_mse_port_7_rx_eop(physs_mse_port_7_rx_eop), 
    .fifo_top_mux_0_physs1_mse_port_7_rx_mod(physs_mse_port_7_rx_mod), 
    .fifo_top_mux_0_physs1_mse_port_7_rx_err(physs_mse_port_7_rx_err), 
    .fifo_top_mux_0_physs1_mse_port_7_rx_ecc_err(physs_mse_port_7_rx_ecc_err), 
    .fifo_top_mux_0_physs1_mse_port_7_rx_ts(physs_mse_port_7_rx_ts), 
    .fifo_top_mux_0_physs1_mse_port_7_tx_rdy(physs_mse_port_7_tx_rdy), 
    .fifo_top_mux_0_physs1_mse_port_7_pfc_mode(physs_icq_port_7_pfc_mode), 
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
    .physs_registers_wrapper_0_reset_ref_clk_override(physs_registers_wrapper_0_reset_ref_clk_override), 
    .physs_registers_wrapper_0_reset_pcs100_override_en(physs_registers_wrapper_0_reset_pcs100_override_en), 
    .physs_registers_wrapper_0_clk_gate_en_100G_mac_pcs(physs_registers_wrapper_0_clk_gate_en_100G_mac_pcs), 
    .physs_registers_wrapper_0_power_fsm_clk_gate_en(physs_registers_wrapper_0_power_fsm_clk_gate_en), 
    .physs_registers_wrapper_0_power_fsm_reset_gate_en(physs_registers_wrapper_0_power_fsm_reset_gate_en), 
    .physs_registers_wrapper_1_reset_ref_clk_override(physs_registers_wrapper_1_reset_ref_clk_override), 
    .physs_registers_wrapper_1_reset_pcs100_override_en(physs_registers_wrapper_1_reset_pcs100_override_en), 
    .physs_registers_wrapper_1_clk_gate_en_100G_mac_pcs(physs_registers_wrapper_1_clk_gate_en_100G_mac_pcs), 
    .physs_registers_wrapper_1_power_fsm_clk_gate_en(physs_registers_wrapper_1_power_fsm_clk_gate_en), 
    .physs_registers_wrapper_1_power_fsm_reset_gate_en(physs_registers_wrapper_1_power_fsm_reset_gate_en), 
    .physs_registers_wrapper_0_clk_gate_en_800G_mac_pcs(physs_registers_wrapper_0_clk_gate_en_800G_mac_pcs), 
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
    .pd_vinf_0_bisr_clk(pd_vinf_0_bisr_clk), 
    .pd_vinf_0_bisr_reset(pd_vinf_0_bisr_reset), 
    .pd_vinf_0_bisr_shift_en(pd_vinf_0_bisr_shift_en), 
    .parmisc_physs0_pd_vinf_0_2_bisr_so(pd_vinf_0_bisr_so), 
    .pd_vinf_1_bisr_si(pd_vinf_1_bisr_si), 
    .pd_vinf_1_bisr_clk(pd_vinf_1_bisr_clk), 
    .pd_vinf_1_bisr_reset(pd_vinf_1_bisr_reset), 
    .pd_vinf_1_bisr_shift_en(pd_vinf_1_bisr_shift_en), 
    .parmisc_physs0_pd_vinf_1_2_bisr_so(pd_vinf_1_bisr_so), 
    .pd_vinf_2_bisr_si(pd_vinf_2_bisr_si), 
    .pd_vinf_2_bisr_clk(pd_vinf_2_bisr_clk), 
    .pd_vinf_2_bisr_reset(pd_vinf_2_bisr_reset), 
    .pd_vinf_2_bisr_shift_en(pd_vinf_2_bisr_shift_en), 
    .parmisc_physs0_pd_vinf_2_2_bisr_so(pd_vinf_2_bisr_so), 
    .pd_vinf_3_bisr_si(pd_vinf_3_bisr_si), 
    .pd_vinf_3_bisr_clk(pd_vinf_3_bisr_clk), 
    .pd_vinf_3_bisr_reset(pd_vinf_3_bisr_reset), 
    .pd_vinf_3_bisr_shift_en(pd_vinf_3_bisr_shift_en), 
    .parmisc_physs0_pd_vinf_3_2_bisr_so(pd_vinf_3_bisr_so), 
    .pd_vinf_4_bisr_si(pd_vinf_4_bisr_si), 
    .pd_vinf_4_bisr_clk(pd_vinf_4_bisr_clk), 
    .pd_vinf_4_bisr_reset(pd_vinf_4_bisr_reset), 
    .pd_vinf_4_bisr_shift_en(pd_vinf_4_bisr_shift_en), 
    .parmisc_physs0_pd_vinf_4_2_bisr_so(pd_vinf_4_bisr_so), 
    .pd_vinf_5_bisr_si(pd_vinf_5_bisr_si), 
    .parmisc_physs0_pd_vinf_5_bisr_so(parmisc_physs0_pd_vinf_5_bisr_so), 
    .parmisc_physs1_pd_vinf_5_2_bisr_so(parmisc_physs1_pd_vinf_5_2_bisr_so), 
    .parmisc_physs0_pd_vinf_5_2_bisr_so(pd_vinf_5_bisr_so), 
    .pd_vinf_5_bisr_reset(pd_vinf_5_bisr_reset), 
    .pd_vinf_5_bisr_shift_en(pd_vinf_5_bisr_shift_en), 
    .pd_vinf_5_bisr_clk(pd_vinf_5_bisr_clk), 
    .pd_vinf_6_bisr_si(pd_vinf_6_bisr_si), 
    .parmisc_physs0_pd_vinf_6_bisr_so(parmisc_physs0_pd_vinf_6_bisr_so), 
    .parmisc_physs1_pd_vinf_6_2_bisr_so(parmisc_physs1_pd_vinf_6_2_bisr_so), 
    .parmisc_physs0_pd_vinf_6_2_bisr_so(pd_vinf_6_bisr_so), 
    .pd_vinf_6_bisr_reset(pd_vinf_6_bisr_reset), 
    .pd_vinf_6_bisr_shift_en(pd_vinf_6_bisr_shift_en), 
    .pd_vinf_6_bisr_clk(pd_vinf_6_bisr_clk), 
    .physs0_func_rst_raw_n(physs0_func_rst_raw_n), 
    .ethphyss_post_clk_mux_ctrl(ethphyss_post_clk_mux_ctrl), 
    .physs_synce_top_mux_0_clkout(physs_synce_rxclk[0]), 
    .physs_synce_top_mux_1_clkout(physs_synce_rxclk[1]), 
    .parmisc_physs0_DIAG_AGGR_parmisc0_mbist_diag_done(DIAG_AGGR_parmisc0_mbist_diag_done), 
    .parpquad0_DIAG_AGGR_pquad_mbist_diag_done(parpquad0_DIAG_AGGR_pquad_mbist_diag_done), 
    .parpquad1_DIAG_AGGR_pquad_mbist_diag_done(parpquad1_DIAG_AGGR_pquad_mbist_diag_done), 
    .hlp_mac_rx_throttle_0_stop(tx_stop_0_out), 
    .hlp_mac_rx_throttle_1_stop(tx_stop_1_out), 
    .hlp_mac_rx_throttle_2_stop(tx_stop_2_out), 
    .hlp_mac_rx_throttle_3_stop(tx_stop_3_out), 
    .tx_stop_0_in(tx_stop_0_in), 
    .tx_stop_1_in(tx_stop_1_in), 
    .tx_stop_2_in(tx_stop_2_in), 
    .tx_stop_3_in(tx_stop_3_in), 
    .physs_registers_wrapper_1_reset_sd_tx_clk_override_800G_0(physs_registers_wrapper_1_reset_sd_tx_clk_override_800G_0), 
    .physs_registers_wrapper_1_reset_sd_rx_clk_override_800G_0(physs_registers_wrapper_1_reset_sd_rx_clk_override_800G_0), 
    .mac100_0_magic_ind_0(physs_hif_port_0_magic_pkt_ind_tgl), 
    .mac100_1_magic_ind_0(physs_hif_port_1_magic_pkt_ind_tgl), 
    .mac100_2_magic_ind_0(physs_hif_port_2_magic_pkt_ind_tgl), 
    .mac100_3_magic_ind_0(physs_hif_port_3_magic_pkt_ind_tgl), 
    .mac100_4_magic_ind_0(physs_hif_port_4_magic_pkt_ind_tgl), 
    .mac100_5_magic_ind_0(physs_hif_port_5_magic_pkt_ind_tgl), 
    .mac100_6_magic_ind_0(physs_hif_port_6_magic_pkt_ind_tgl), 
    .mac100_7_magic_ind_0(physs_hif_port_7_magic_pkt_ind_tgl), 
    .icq_physs_net_xoff(icq_physs_net_xoff[7:0]), 
    .icq_physs_net_xoff_0(icq_physs_net_xoff[15:8]), 
    .icq_physs_net_xoff_1(icq_physs_net_xoff[23:16]), 
    .icq_physs_net_xoff_2(icq_physs_net_xoff[31:24]), 
    .icq_physs_net_xoff_3(icq_physs_net_xoff[39:32]), 
    .icq_physs_net_xoff_4(icq_physs_net_xoff[47:40]), 
    .icq_physs_net_xoff_5(icq_physs_net_xoff[55:48]), 
    .icq_physs_net_xoff_6(icq_physs_net_xoff[63:56]), 
    .mac100_0_pause_on_0(physs_icq_net_xoff[7:0]), 
    .mac100_1_pause_on_0(physs_icq_net_xoff[15:8]), 
    .mac100_2_pause_on_0(physs_icq_net_xoff[23:16]), 
    .mac100_3_pause_on_0(physs_icq_net_xoff[31:24]), 
    .mac100_4_pause_on_0(physs_icq_net_xoff[39:32]), 
    .mac100_5_pause_on_0(physs_icq_net_xoff[47:40]), 
    .mac100_6_pause_on_0(physs_icq_net_xoff[55:48]), 
    .mac100_7_pause_on_0(physs_icq_net_xoff[63:56]), 
    .fifo_top_mux_0_physs_mse_800g_en_0(physs_mse_800g_en), 
    .versa_xmp_2_o_ucss_uart_txd(versa_xmp_2_o_ucss_uart_txd), 
    .versa_xmp_3_o_ucss_uart_txd(versa_xmp_3_o_ucss_uart_txd), 
    .physs_uart_demux_out2(physs_uart_demux_out2), 
    .physs_uart_demux_out3(physs_uart_demux_out3), 
    .physs_uart_mux_out(o_ucss_uart_txd), 
    .i_ucss_uart_rxd(i_ucss_uart_rxd), 
    .versa_xmp_0_o_rst_ucss_srds_pcs_rx_reset_pma0_l0_b_a_0(versa_xmp_0_o_rst_ucss_srds_pcs_rx_reset_pma0_l0_b_a_0), 
    .versa_xmp_0_o_rst_ucss_srds_pcs_rx_reset_pma1_l0_b_a_0(versa_xmp_0_o_rst_ucss_srds_pcs_rx_reset_pma1_l0_b_a_0), 
    .versa_xmp_0_o_rst_ucss_srds_pcs_rx_reset_pma2_l0_b_a_0(versa_xmp_0_o_rst_ucss_srds_pcs_rx_reset_pma2_l0_b_a_0), 
    .versa_xmp_0_o_rst_ucss_srds_pcs_rx_reset_pma3_l0_b_a_0(versa_xmp_0_o_rst_ucss_srds_pcs_rx_reset_pma3_l0_b_a_0), 
    .versa_xmp_1_o_rst_ucss_srds_pcs_rx_reset_pma0_l0_b_a_0(versa_xmp_1_o_rst_ucss_srds_pcs_rx_reset_pma0_l0_b_a_0), 
    .versa_xmp_1_o_rst_ucss_srds_pcs_rx_reset_pma1_l0_b_a_0(versa_xmp_1_o_rst_ucss_srds_pcs_rx_reset_pma1_l0_b_a_0), 
    .versa_xmp_1_o_rst_ucss_srds_pcs_rx_reset_pma2_l0_b_a_0(versa_xmp_1_o_rst_ucss_srds_pcs_rx_reset_pma2_l0_b_a_0), 
    .versa_xmp_1_o_rst_ucss_srds_pcs_rx_reset_pma3_l0_b_a_0(versa_xmp_1_o_rst_ucss_srds_pcs_rx_reset_pma3_l0_b_a_0), 
    .fary_post_force_fail(fary_post_force_fail), 
    .fary_0_trigger_post(fary_0_trigger_post), 
    .fary_post_algo_select(fary_post_algo_select), 
    .ethphyss_post_agg_mquad_0_post_pass_agg(aary_0_post_pass), 
    .ethphyss_post_agg_mquad_0_post_complete_agg(aary_0_post_complete), 
    .fary_1_trigger_post(fary_1_trigger_post), 
    .ethphyss_post_agg_mquad_1_post_pass_agg(aary_1_post_pass), 
    .ethphyss_post_agg_mquad_1_post_complete_agg(aary_1_post_complete), 
    .fary_2_trigger_post(fary_2_trigger_post), 
    .ethphyss_post_agg_mquad_2_post_pass_agg(aary_2_post_pass), 
    .ethphyss_post_agg_mquad_2_post_complete_agg(aary_2_post_complete), 
    .fary_3_trigger_post(fary_3_trigger_post), 
    .ethphyss_post_agg_mquad_3_post_pass_agg(aary_3_post_pass), 
    .ethphyss_post_agg_mquad_3_post_complete_agg(aary_3_post_complete), 
    .xmp_mem_wrapper_2_aary_post_pass(xmp_mem_wrapper_2_aary_post_pass), 
    .xmp_mem_wrapper_2_aary_post_complete(xmp_mem_wrapper_2_aary_post_complete), 
    .xmp_mem_wrapper_3_aary_post_pass(xmp_mem_wrapper_3_aary_post_pass), 
    .xmp_mem_wrapper_3_aary_post_complete(xmp_mem_wrapper_3_aary_post_complete), 
    .ethphyss_post_agg_pquad_4_post_pass_agg(aary_4_post_pass), 
    .ethphyss_post_agg_pquad_4_post_complete_agg(aary_4_post_complete), 
    .pcs100_mem_wrapper_2_aary_post_pass(pcs100_mem_wrapper_2_aary_post_pass), 
    .pcs100_mem_wrapper_2_aary_post_complete(pcs100_mem_wrapper_2_aary_post_complete), 
    .pcs100_mem_wrapper_3_aary_post_pass(pcs100_mem_wrapper_3_aary_post_pass), 
    .pcs100_mem_wrapper_3_aary_post_complete(pcs100_mem_wrapper_3_aary_post_complete), 
    .ethphyss_post_agg_pquad_5_post_pass_agg(aary_5_post_pass), 
    .ethphyss_post_agg_pquad_5_post_complete_agg(aary_5_post_complete), 
    .fary_6_trigger_post(fary_6_trigger_post), 
    .ethphyss_post_agg_par800g_6_post_pass_agg(aary_6_post_pass), 
    .ethphyss_post_agg_par800g_6_post_complete_agg(aary_6_post_complete), 
    .fary_7_trigger_post(fary_7_trigger_post), 
    .ethphyss_post_agg_par400g0_7_post_pass_agg(aary_7_post_pass), 
    .ethphyss_post_agg_par400g0_7_post_complete_agg(aary_7_post_complete), 
    .fary_8_trigger_post(fary_8_trigger_post), 
    .ethphyss_post_agg_par400g0_8_post_pass_agg(aary_8_post_pass), 
    .ethphyss_post_agg_par400g0_8_post_complete_agg(aary_8_post_complete), 
    .fary_9_trigger_post(fary_9_trigger_post), 
    .ethphyss_post_agg_par400g1_9_post_pass_agg(aary_9_post_pass), 
    .ethphyss_post_agg_par400g1_9_post_complete_agg(aary_9_post_complete), 
    .fary_10_trigger_post(fary_10_trigger_post), 
    .ethphyss_post_agg_par400g1_10_post_pass_agg(aary_10_post_pass), 
    .ethphyss_post_agg_par400g1_10_post_complete_agg(aary_10_post_complete), 
    .parmisc_physs1_dfx_ubp_ctrl_trig_in_to_parmisc_physs0_ubpc(parmisc_physs1_dfx_ubp_ctrl_trig_in_to_parmisc_physs0_ubpc), 
    .parmisc_physs0_trig_clock_stop_to_parpquad0_pma0_txdat(parmisc_physs0_trig_clock_stop_to_parpquad0_pma0_txdat), 
    .parmisc_physs0_trig_clock_stop_to_parpquad0_pma1_txdat(parmisc_physs0_trig_clock_stop_to_parpquad0_pma1_txdat), 
    .parmisc_physs0_trig_clock_stop_to_parpquad0_pma2_txdat(parmisc_physs0_trig_clock_stop_to_parpquad0_pma2_txdat), 
    .parmisc_physs0_trig_clock_stop_to_parpquad0_pma3_txdat(parmisc_physs0_trig_clock_stop_to_parpquad0_pma3_txdat), 
    .parmisc_physs0_trig_clock_stop_to_parpquad0_o_ck_pma0_rx(parmisc_physs0_trig_clock_stop_to_parpquad0_o_ck_pma0_rx), 
    .parmisc_physs0_trig_clock_stop_to_parpquad0_o_ck_pma1_rx(parmisc_physs0_trig_clock_stop_to_parpquad0_o_ck_pma1_rx), 
    .parmisc_physs0_trig_clock_stop_to_parpquad0_o_ck_pma2_rx(parmisc_physs0_trig_clock_stop_to_parpquad0_o_ck_pma2_rx), 
    .parmisc_physs0_trig_clock_stop_to_parpquad0_o_ck_pma3_rx(parmisc_physs0_trig_clock_stop_to_parpquad0_o_ck_pma3_rx), 
    .parmisc_physs0_trig_clock_stop_to_parpquad0_pma0_rxdat(parmisc_physs0_trig_clock_stop_to_parpquad0_pma0_rxdat), 
    .parmisc_physs0_trig_clock_stop_to_parpquad0_pma1_rxdat(parmisc_physs0_trig_clock_stop_to_parpquad0_pma1_rxdat), 
    .parmisc_physs0_trig_clock_stop_to_parpquad0_pma2_rxdat(parmisc_physs0_trig_clock_stop_to_parpquad0_pma2_rxdat), 
    .parmisc_physs0_trig_clock_stop_to_parpquad0_pma3_rxdat(parmisc_physs0_trig_clock_stop_to_parpquad0_pma3_rxdat), 
    .parmisc_physs0_trig_clock_stop_to_parpquad0_o_ck_pma0_cmnplla_postdiv(parmisc_physs0_trig_clock_stop_to_parpquad0_o_ck_pma0_cmnplla_postdiv), 
    .parmisc_physs0_trig_clock_stop_to_parpquad0_o_ck_pma1_cmnplla_postdiv(parmisc_physs0_trig_clock_stop_to_parpquad0_o_ck_pma1_cmnplla_postdiv), 
    .parmisc_physs0_trig_clock_stop_to_parpquad0_o_ck_pma2_cmnplla_postdiv(parmisc_physs0_trig_clock_stop_to_parpquad0_o_ck_pma2_cmnplla_postdiv), 
    .parmisc_physs0_trig_clock_stop_to_parpquad0_o_ck_pma3_cmnplla_postdiv(parmisc_physs0_trig_clock_stop_to_parpquad0_o_ck_pma3_cmnplla_postdiv), 
    .parmisc_physs0_trig_clock_stop_to_parpquad0_o_ck_slv_pcs1(parmisc_physs0_trig_clock_stop_to_parpquad0_o_ck_slv_pcs1), 
    .parmisc_physs0_trig_clock_stop_to_parpquad0_o_ck_ucss_mem_dram(parmisc_physs0_trig_clock_stop_to_parpquad0_o_ck_ucss_mem_dram), 
    .parmisc_physs0_trig_clock_stop_to_parpquad0_o_ck_ucss_mem_iram(parmisc_physs0_trig_clock_stop_to_parpquad0_o_ck_ucss_mem_iram), 
    .parmisc_physs0_trig_clock_stop_to_parpquad0_o_ck_ucss_mem_tracemem(parmisc_physs0_trig_clock_stop_to_parpquad0_o_ck_ucss_mem_tracemem), 
    .parmisc_physs0_trig_clock_stop_to_parpquad1_pma0_txdat(parmisc_physs0_trig_clock_stop_to_parpquad1_pma0_txdat), 
    .parmisc_physs0_trig_clock_stop_to_parpquad1_pma1_txdat(parmisc_physs0_trig_clock_stop_to_parpquad1_pma1_txdat), 
    .parmisc_physs0_trig_clock_stop_to_parpquad1_pma2_txdat(parmisc_physs0_trig_clock_stop_to_parpquad1_pma2_txdat), 
    .parmisc_physs0_trig_clock_stop_to_parpquad1_pma3_txdat(parmisc_physs0_trig_clock_stop_to_parpquad1_pma3_txdat), 
    .parmisc_physs0_trig_clock_stop_to_parpquad1_o_ck_pma0_rx(parmisc_physs0_trig_clock_stop_to_parpquad1_o_ck_pma0_rx), 
    .parmisc_physs0_trig_clock_stop_to_parpquad1_o_ck_pma1_rx(parmisc_physs0_trig_clock_stop_to_parpquad1_o_ck_pma1_rx), 
    .parmisc_physs0_trig_clock_stop_to_parpquad1_o_ck_pma2_rx(parmisc_physs0_trig_clock_stop_to_parpquad1_o_ck_pma2_rx), 
    .parmisc_physs0_trig_clock_stop_to_parpquad1_o_ck_pma3_rx(parmisc_physs0_trig_clock_stop_to_parpquad1_o_ck_pma3_rx), 
    .parmisc_physs0_trig_clock_stop_to_parpquad1_pma0_rxdat(parmisc_physs0_trig_clock_stop_to_parpquad1_pma0_rxdat), 
    .parmisc_physs0_trig_clock_stop_to_parpquad1_pma1_rxdat(parmisc_physs0_trig_clock_stop_to_parpquad1_pma1_rxdat), 
    .parmisc_physs0_trig_clock_stop_to_parpquad1_pma2_rxdat(parmisc_physs0_trig_clock_stop_to_parpquad1_pma2_rxdat), 
    .parmisc_physs0_trig_clock_stop_to_parpquad1_pma3_rxdat(parmisc_physs0_trig_clock_stop_to_parpquad1_pma3_rxdat), 
    .parmisc_physs0_trig_clock_stop_to_parpquad1_o_ck_pma0_cmnplla_postdiv(parmisc_physs0_trig_clock_stop_to_parpquad1_o_ck_pma0_cmnplla_postdiv), 
    .parmisc_physs0_trig_clock_stop_to_parpquad1_o_ck_pma1_cmnplla_postdiv(parmisc_physs0_trig_clock_stop_to_parpquad1_o_ck_pma1_cmnplla_postdiv), 
    .parmisc_physs0_trig_clock_stop_to_parpquad1_o_ck_pma2_cmnplla_postdiv(parmisc_physs0_trig_clock_stop_to_parpquad1_o_ck_pma2_cmnplla_postdiv), 
    .parmisc_physs0_trig_clock_stop_to_parpquad1_o_ck_pma3_cmnplla_postdiv(parmisc_physs0_trig_clock_stop_to_parpquad1_o_ck_pma3_cmnplla_postdiv), 
    .parmisc_physs0_trig_clock_stop_to_parpquad1_o_ck_slv_pcs1(parmisc_physs0_trig_clock_stop_to_parpquad1_o_ck_slv_pcs1), 
    .parmisc_physs0_trig_clock_stop_to_parpquad1_o_ck_ucss_mem_dram(parmisc_physs0_trig_clock_stop_to_parpquad1_o_ck_ucss_mem_dram), 
    .parmisc_physs0_trig_clock_stop_to_parpquad1_o_ck_ucss_mem_iram(parmisc_physs0_trig_clock_stop_to_parpquad1_o_ck_ucss_mem_iram), 
    .parmisc_physs0_trig_clock_stop_to_parpquad1_o_ck_ucss_mem_tracemem(parmisc_physs0_trig_clock_stop_to_parpquad1_o_ck_ucss_mem_tracemem), 
    .ioa_ck_pma3_ref_right_mquad1_physs0(physs1_ioa_ck_pma0_ref_left_pquad0_physs1), 
    .quadpcs100_0_pcs_desk_buf_rlevel_0(pcs_desk_buf_rlevel[27:0]), 
    .quadpcs100_0_pcs_sd_bit_slip_0(pcs_sd_bit_slip[31:0]), 
    .quadpcs100_0_pcs_link_status_tsu_0(pcs_link_status_tsu[3:0]), 
    .quadpcs100_1_pcs_desk_buf_rlevel_0(pcs_desk_buf_rlevel[55:28]), 
    .quadpcs100_1_pcs_sd_bit_slip_0(pcs_sd_bit_slip[63:32]), 
    .quadpcs100_1_pcs_link_status_tsu_0(pcs_link_status_tsu[7:4]), 
    .versa_xmp_0_xioa_ck_pma0_ref0_n(xioa_ck_pma_ref0_n[0]), 
    .versa_xmp_0_xioa_ck_pma0_ref0_p(xioa_ck_pma_ref0_p[0]), 
    .versa_xmp_0_xioa_ck_pma0_ref1_n(eref0_pad_clk_n), 
    .versa_xmp_0_xioa_ck_pma0_ref1_p(eref0_pad_clk_p), 
    .versa_xmp_0_xioa_ck_pma1_ref0_n(xioa_ck_pma_ref0_n[1]), 
    .versa_xmp_0_xioa_ck_pma1_ref0_p(xioa_ck_pma_ref0_p[1]), 
    .versa_xmp_0_xioa_ck_pma1_ref1_n(syncE_pad_clk_n), 
    .versa_xmp_0_xioa_ck_pma1_ref1_p(syncE_pad_clk_p), 
    .versa_xmp_0_xioa_ck_pma2_ref0_n(xioa_ck_pma_ref0_n[2]), 
    .versa_xmp_0_xioa_ck_pma2_ref0_p(xioa_ck_pma_ref0_p[2]), 
    .versa_xmp_0_xioa_ck_pma2_ref1_n(xioa_ck_pma_ref1_n[0]), 
    .versa_xmp_0_xioa_ck_pma2_ref1_p(xioa_ck_pma_ref1_p[0]), 
    .versa_xmp_0_xioa_ck_pma3_ref0_n(xioa_ck_pma_ref0_n[3]), 
    .versa_xmp_0_xioa_ck_pma3_ref0_p(xioa_ck_pma_ref0_p[3]), 
    .versa_xmp_0_xioa_ck_pma3_ref1_n(xioa_ck_pma_ref1_n[1]), 
    .versa_xmp_0_xioa_ck_pma3_ref1_p(xioa_ck_pma_ref1_p[1]), 
    .rclk_diff_p(rclk_diff_p), 
    .rclk_diff_n(rclk_diff_n), 
    .versa_xmp_0_xoa_pma0_dcmon1(xoa_pma_dcmon1[0]), 
    .versa_xmp_0_xoa_pma0_dcmon2(xoa_pma_dcmon2[0]), 
    .versa_xmp_0_xoa_pma1_dcmon1(xoa_pma_dcmon1[1]), 
    .versa_xmp_0_xoa_pma1_dcmon2(xoa_pma_dcmon2[1]), 
    .versa_xmp_0_xoa_pma2_dcmon1(xoa_pma_dcmon1[2]), 
    .versa_xmp_0_xoa_pma2_dcmon2(xoa_pma_dcmon2[2]), 
    .versa_xmp_0_xoa_pma3_dcmon1(xoa_pma_dcmon1[3]), 
    .versa_xmp_0_xoa_pma3_dcmon2(xoa_pma_dcmon2[3]), 
    .versa_xmp_1_xioa_ck_pma0_ref0_n(xioa_ck_pma_ref0_n[4]), 
    .versa_xmp_1_xioa_ck_pma0_ref0_p(xioa_ck_pma_ref0_p[4]), 
    .versa_xmp_1_xioa_ck_pma0_ref1_n(xioa_ck_pma_ref1_n[2]), 
    .versa_xmp_1_xioa_ck_pma0_ref1_p(xioa_ck_pma_ref1_p[2]), 
    .versa_xmp_1_xioa_ck_pma1_ref0_n(xioa_ck_pma_ref0_n[5]), 
    .versa_xmp_1_xioa_ck_pma1_ref0_p(xioa_ck_pma_ref0_p[5]), 
    .versa_xmp_1_xioa_ck_pma1_ref1_n(xioa_ck_pma_ref1_n[3]), 
    .versa_xmp_1_xioa_ck_pma1_ref1_p(xioa_ck_pma_ref1_p[3]), 
    .versa_xmp_1_xioa_ck_pma2_ref0_n(xioa_ck_pma_ref0_n[6]), 
    .versa_xmp_1_xioa_ck_pma2_ref0_p(xioa_ck_pma_ref0_p[6]), 
    .versa_xmp_1_xioa_ck_pma2_ref1_n(xioa_ck_pma_ref1_n[4]), 
    .versa_xmp_1_xioa_ck_pma2_ref1_p(xioa_ck_pma_ref1_p[4]), 
    .versa_xmp_1_xioa_ck_pma3_ref0_n(xioa_ck_pma_ref0_n[7]), 
    .versa_xmp_1_xioa_ck_pma3_ref0_p(xioa_ck_pma_ref0_p[7]), 
    .versa_xmp_1_xioa_ck_pma3_ref1_n(xioa_ck_pma_ref1_n[5]), 
    .versa_xmp_1_xioa_ck_pma3_ref1_p(xioa_ck_pma_ref1_p[5]), 
    .versa_xmp_1_xoa_pma0_dcmon1(xoa_pma_dcmon1[4]), 
    .versa_xmp_1_xoa_pma0_dcmon2(xoa_pma_dcmon2[4]), 
    .versa_xmp_1_xoa_pma1_dcmon1(xoa_pma_dcmon1[5]), 
    .versa_xmp_1_xoa_pma1_dcmon2(xoa_pma_dcmon2[5]), 
    .versa_xmp_1_xoa_pma2_dcmon1(xoa_pma_dcmon1[6]), 
    .versa_xmp_1_xoa_pma2_dcmon2(xoa_pma_dcmon2[6]), 
    .versa_xmp_1_xoa_pma3_dcmon1(xoa_pma_dcmon1[7]), 
    .versa_xmp_1_xoa_pma3_dcmon2(xoa_pma_dcmon2[7]), 
    .interrupts_counter_level_fatal_int_0_out_signal_sync(physs_fatal_int_0), 
    .interrupts_counter_level_imc_int_0_out_signal_sync(physs_imc_int_0), 
    .quad_interrupts_0_mac800_int(mac800_0_int), 
    .versa_xmp_0_o_ucss_irq_cpi_0_a(o_ucss_irq_cpi_0_a[0]), 
    .versa_xmp_1_o_ucss_irq_cpi_0_a(o_ucss_irq_cpi_0_a[1]), 
    .versa_xmp_0_o_ucss_irq_cpi_1_a(o_ucss_irq_cpi_1_a[0]), 
    .versa_xmp_1_o_ucss_irq_cpi_1_a(o_ucss_irq_cpi_1_a[1]), 
    .versa_xmp_0_o_ucss_irq_cpi_2_a(o_ucss_irq_cpi_2_a[0]), 
    .versa_xmp_1_o_ucss_irq_cpi_2_a(o_ucss_irq_cpi_2_a[1]), 
    .versa_xmp_0_o_ucss_irq_cpi_3_a(o_ucss_irq_cpi_3_a[0]), 
    .versa_xmp_1_o_ucss_irq_cpi_3_a(o_ucss_irq_cpi_3_a[1]), 
    .versa_xmp_0_o_ucss_irq_cpi_4_a(o_ucss_irq_cpi_4_a[0]), 
    .versa_xmp_1_o_ucss_irq_cpi_4_a(o_ucss_irq_cpi_4_a[1]), 
    .versa_xmp_0_o_ucss_irq_to_soc_l0_a(o_ucss_irq_status_a[0]), 
    .versa_xmp_0_o_ucss_irq_to_soc_l1_a(o_ucss_irq_status_a[1]), 
    .versa_xmp_0_o_ucss_irq_to_soc_l2_a(o_ucss_irq_status_a[2]), 
    .versa_xmp_0_o_ucss_irq_to_soc_l3_a(o_ucss_irq_status_a[3]), 
    .versa_xmp_1_o_ucss_irq_to_soc_l0_a(o_ucss_irq_status_a[4]), 
    .versa_xmp_1_o_ucss_irq_to_soc_l1_a(o_ucss_irq_status_a[5]), 
    .versa_xmp_1_o_ucss_irq_to_soc_l2_a(o_ucss_irq_status_a[6]), 
    .versa_xmp_1_o_ucss_irq_to_soc_l3_a(o_ucss_irq_status_a[7]), 
    // CDC: MQUAD0 XLGMII connections modified to route through CDC wires
    .pcs_mac_pipeline_top_wrap_mquad0_mac0_xlgmii_tx_clkena(physs_hlp_xlgmii0_txclk_ena_0), 
    .pcs_mac_pipeline_top_wrap_mquad0_mac0_xlgmii_rx_clkena(physs_hlp_xlgmii0_rxclk_ena_0), 
    .pcs_mac_pipeline_top_wrap_mquad0_mac0_xlgmii_rx_rxc(physs_hlp_xlgmii0_rxc_0), 
    .pcs_mac_pipeline_top_wrap_mquad0_mac0_xlgmii_rx_rxd(physs_hlp_xlgmii0_rxd_0), 
    .pcs_mac_pipeline_top_wrap_mquad0_mac0_xlgmii_rxt0_next(physs_hlp_xlgmii0_rxt0_next_0), 
    .hlp_xlgmii0_txc_0(hlp_physs_xlgmii0_txc_0), 
    .hlp_xlgmii0_txd_0(hlp_physs_xlgmii0_txd_0), 
    .pcs_mac_pipeline_top_wrap_mquad0_tsu0_xlgmii_rx_sd(pcs_tsu_rx_sd[1:0]), 
    .pcs_mac_pipeline_top_wrap_mquad0_tsu0_xlgmii_rx_tsu(mii_rx_tsu_mux[1:0]), 
    .pcs_mac_pipeline_top_wrap_mquad0_tsu0_xlgmii_tx_tsu(mii_tx_tsu[1:0]), 
    .pcs_mac_pipeline_top_wrap_mquad0_mac1_xlgmii_tx_clkena(physs_hlp_xlgmii1_txclk_ena_0), 
    .pcs_mac_pipeline_top_wrap_mquad0_mac1_xlgmii_rx_clkena(physs_hlp_xlgmii1_rxclk_ena_0), 
    .pcs_mac_pipeline_top_wrap_mquad0_mac1_xlgmii_rx_rxc(physs_hlp_xlgmii1_rxc_0), 
    .pcs_mac_pipeline_top_wrap_mquad0_mac1_xlgmii_rx_rxd(physs_hlp_xlgmii1_rxd_0), 
    .pcs_mac_pipeline_top_wrap_mquad0_mac1_xlgmii_rxt0_next(physs_hlp_xlgmii1_rxt0_next_0), 
    .hlp_xlgmii1_txc_0(hlp_physs_xlgmii1_txc_0), 
    .hlp_xlgmii1_txd_0(hlp_physs_xlgmii1_txd_0), 
    .pcs_mac_pipeline_top_wrap_mquad0_tsu1_xlgmii_rx_sd(pcs_tsu_rx_sd[3:2]), 
    .pcs_mac_pipeline_top_wrap_mquad0_tsu1_xlgmii_rx_tsu(mii_rx_tsu_mux[3:2]), 
    .pcs_mac_pipeline_top_wrap_mquad0_tsu1_xlgmii_tx_tsu(mii_tx_tsu[3:2]), 
    .pcs_mac_pipeline_top_wrap_mquad0_mac2_xlgmii_tx_clkena(physs_hlp_xlgmii2_txclk_ena_0), 
    .pcs_mac_pipeline_top_wrap_mquad0_mac2_xlgmii_rx_clkena(physs_hlp_xlgmii2_rxclk_ena_0), 
    .pcs_mac_pipeline_top_wrap_mquad0_mac2_xlgmii_rx_rxc(physs_hlp_xlgmii2_rxc_0), 
    .pcs_mac_pipeline_top_wrap_mquad0_mac2_xlgmii_rx_rxd(physs_hlp_xlgmii2_rxd_0), 
    .pcs_mac_pipeline_top_wrap_mquad0_mac2_xlgmii_rxt0_next(physs_hlp_xlgmii2_rxt0_next_0), 
    .hlp_xlgmii2_txc_0(hlp_physs_xlgmii2_txc_0), 
    .hlp_xlgmii2_txd_0(hlp_physs_xlgmii2_txd_0), 
    .pcs_mac_pipeline_top_wrap_mquad0_tsu2_xlgmii_rx_sd(pcs_tsu_rx_sd[5:4]), 
    .pcs_mac_pipeline_top_wrap_mquad0_tsu2_xlgmii_rx_tsu(mii_rx_tsu_mux[5:4]), 
    .pcs_mac_pipeline_top_wrap_mquad0_tsu2_xlgmii_tx_tsu(mii_tx_tsu[5:4]), 
    .pcs_mac_pipeline_top_wrap_mquad0_mac3_xlgmii_tx_clkena(physs_hlp_xlgmii3_txclk_ena_0), 
    .pcs_mac_pipeline_top_wrap_mquad0_mac3_xlgmii_rx_clkena(physs_hlp_xlgmii3_rxclk_ena_0), 
    .pcs_mac_pipeline_top_wrap_mquad0_mac3_xlgmii_rx_rxc(physs_hlp_xlgmii3_rxc_0), 
    .pcs_mac_pipeline_top_wrap_mquad0_mac3_xlgmii_rx_rxd(physs_hlp_xlgmii3_rxd_0), 
    .pcs_mac_pipeline_top_wrap_mquad0_mac3_xlgmii_rxt0_next(physs_hlp_xlgmii3_rxt0_next_0), 
    .hlp_xlgmii3_txc_0(hlp_physs_xlgmii3_txc_0), 
    .hlp_xlgmii3_txd_0(hlp_physs_xlgmii3_txd_0), 
    .pcs_mac_pipeline_top_wrap_mquad0_tsu3_xlgmii_rx_sd(pcs_tsu_rx_sd[7:6]), 
    .pcs_mac_pipeline_top_wrap_mquad0_tsu3_xlgmii_rx_tsu(mii_rx_tsu_mux[7:6]), 
    .pcs_mac_pipeline_top_wrap_mquad0_tsu3_xlgmii_tx_tsu(mii_tx_tsu[7:6]), 
    .pcs_mac_pipeline_top_wrap_mquad0_mac0_cgmii_tx_clkena(hlp_cgmii0_txclk_ena_0), 
    .pcs_mac_pipeline_top_wrap_mquad0_mac0_cgmii_rx_clkena(hlp_cgmii0_rxclk_ena_0), 
    .pcs_mac_pipeline_top_wrap_mquad0_mac0_cgmii_rx_rxc(hlp_cgmii0_rxc_0), 
    .pcs_mac_pipeline_top_wrap_mquad0_mac0_cgmii_rx_rxd(hlp_cgmii0_rxd_0), 
    .hlp_cgmii0_txc_0(hlp_cgmii0_txc_0), 
    .hlp_cgmii0_txd_0(hlp_cgmii0_txd_0), 
    .pcs_mac_pipeline_top_wrap_mquad0_mac1_cgmii_tx_clkena(hlp_cgmii1_txclk_ena_0), 
    .pcs_mac_pipeline_top_wrap_mquad0_mac1_cgmii_rx_clkena(hlp_cgmii1_rxclk_ena_0), 
    .pcs_mac_pipeline_top_wrap_mquad0_mac1_cgmii_rx_rxc(hlp_cgmii1_rxc_0), 
    .pcs_mac_pipeline_top_wrap_mquad0_mac1_cgmii_rx_rxd(hlp_cgmii1_rxd_0), 
    .hlp_cgmii1_txc_0(hlp_cgmii1_txc_0), 
    .hlp_cgmii1_txd_0(hlp_cgmii1_txd_0), 
    .pcs_mac_pipeline_top_wrap_mquad0_mac2_cgmii_tx_clkena(hlp_cgmii2_txclk_ena_0), 
    .pcs_mac_pipeline_top_wrap_mquad0_mac2_cgmii_rx_clkena(hlp_cgmii2_rxclk_ena_0), 
    .pcs_mac_pipeline_top_wrap_mquad0_mac2_cgmii_rx_rxc(hlp_cgmii2_rxc_0), 
    .pcs_mac_pipeline_top_wrap_mquad0_mac2_cgmii_rx_rxd(hlp_cgmii2_rxd_0), 
    .hlp_cgmii2_txc_0(hlp_cgmii2_txc_0), 
    .hlp_cgmii2_txd_0(hlp_cgmii2_txd_0), 
    .pcs_mac_pipeline_top_wrap_mquad0_mac3_cgmii_tx_clkena(hlp_cgmii3_txclk_ena_0), 
    .pcs_mac_pipeline_top_wrap_mquad0_mac3_cgmii_rx_clkena(hlp_cgmii3_rxclk_ena_0), 
    .pcs_mac_pipeline_top_wrap_mquad0_mac3_cgmii_rx_rxc(hlp_cgmii3_rxc_0), 
    .pcs_mac_pipeline_top_wrap_mquad0_mac3_cgmii_rx_rxd(hlp_cgmii3_rxd_0), 
    .hlp_cgmii3_txc_0(hlp_cgmii3_txc_0), 
    .hlp_cgmii3_txd_0(hlp_cgmii3_txd_0), 
    .hlp_xlgmii0_rxc_nss_0(hlp_xlgmii0_rxc_nss_0), 
    .hlp_xlgmii0_rxd_nss_0(hlp_xlgmii0_rxd_nss_0), 
    .pcs_mac_pipeline_top_wrap_nss_pcs0_xlgmii_tx_txc(hlp_xlgmii0_txc_nss_0), 
    .pcs_mac_pipeline_top_wrap_nss_pcs0_xlgmii_tx_txd(hlp_xlgmii0_txd_nss_0), 
    .hlp_xlgmii1_rxc_nss_0(hlp_xlgmii1_rxc_nss_0), 
    .hlp_xlgmii1_rxd_nss_0(hlp_xlgmii1_rxd_nss_0), 
    .pcs_mac_pipeline_top_wrap_nss_pcs1_xlgmii_tx_txc(hlp_xlgmii1_txc_nss_0), 
    .pcs_mac_pipeline_top_wrap_nss_pcs1_xlgmii_tx_txd(hlp_xlgmii1_txd_nss_0), 
    .hlp_xlgmii2_rxc_nss_0(hlp_xlgmii2_rxc_nss_0), 
    .hlp_xlgmii2_rxd_nss_0(hlp_xlgmii2_rxd_nss_0), 
    .pcs_mac_pipeline_top_wrap_nss_pcs2_xlgmii_tx_txc(hlp_xlgmii2_txc_nss_0), 
    .pcs_mac_pipeline_top_wrap_nss_pcs2_xlgmii_tx_txd(hlp_xlgmii2_txd_nss_0), 
    .hlp_xlgmii3_rxc_nss_0(hlp_xlgmii3_rxc_nss_0), 
    .hlp_xlgmii3_rxd_nss_0(hlp_xlgmii3_rxd_nss_0), 
    .pcs_mac_pipeline_top_wrap_nss_pcs3_xlgmii_tx_txc(hlp_xlgmii3_txc_nss_0), 
    .pcs_mac_pipeline_top_wrap_nss_pcs3_xlgmii_tx_txd(hlp_xlgmii3_txd_nss_0), 
    .hlp_cgmii0_rxc_nss_0(hlp_cgmii0_rxc_nss_0), 
    .hlp_cgmii0_rxd_nss_0(hlp_cgmii0_rxd_nss_0), 
    .pcs_mac_pipeline_top_wrap_nss_pcs0_cgmii_tx_txc(hlp_cgmii0_txc_nss_0), 
    .pcs_mac_pipeline_top_wrap_nss_pcs0_cgmii_tx_txd(hlp_cgmii0_txd_nss_0), 
    .hlp_cgmii1_rxc_nss_0(hlp_cgmii1_rxc_nss_0), 
    .hlp_cgmii1_rxd_nss_0(hlp_cgmii1_rxd_nss_0), 
    .pcs_mac_pipeline_top_wrap_nss_pcs1_cgmii_tx_txc(hlp_cgmii1_txc_nss_0), 
    .pcs_mac_pipeline_top_wrap_nss_pcs1_cgmii_tx_txd(hlp_cgmii1_txd_nss_0), 
    .hlp_cgmii2_rxc_nss_0(hlp_cgmii2_rxc_nss_0), 
    .hlp_cgmii2_rxd_nss_0(hlp_cgmii2_rxd_nss_0), 
    .pcs_mac_pipeline_top_wrap_nss_pcs2_cgmii_tx_txc(hlp_cgmii2_txc_nss_0), 
    .pcs_mac_pipeline_top_wrap_nss_pcs2_cgmii_tx_txd(hlp_cgmii2_txd_nss_0), 
    .hlp_cgmii3_rxc_nss_0(hlp_cgmii3_rxc_nss_0), 
    .hlp_cgmii3_rxd_nss_0(hlp_cgmii3_rxd_nss_0), 
    .pcs_mac_pipeline_top_wrap_nss_pcs3_cgmii_tx_txc(hlp_cgmii3_txc_nss_0), 
    .pcs_mac_pipeline_top_wrap_nss_pcs3_cgmii_tx_txd(hlp_cgmii3_txd_nss_0), 
    // CDC: MQUAD1 XLGMII connections modified to route through CDC wires
    .pcs_mac_pipeline_top_wrap_mquad1_mac0_xlgmii_tx_clkena(physs_hlp_xlgmii0_txclk_ena_1), 
    .pcs_mac_pipeline_top_wrap_mquad1_mac0_xlgmii_rx_clkena(physs_hlp_xlgmii0_rxclk_ena_1), 
    .pcs_mac_pipeline_top_wrap_mquad1_mac0_xlgmii_rx_rxc(physs_hlp_xlgmii0_rxc_1), 
    .pcs_mac_pipeline_top_wrap_mquad1_mac0_xlgmii_rx_rxd(physs_hlp_xlgmii0_rxd_1), 
    .pcs_mac_pipeline_top_wrap_mquad1_mac0_xlgmii_rxt0_next(physs_hlp_xlgmii0_rxt0_next_1), 
    .hlp_xlgmii0_txc_1(hlp_physs_xlgmii0_txc_1), 
    .hlp_xlgmii0_txd_1(hlp_physs_xlgmii0_txd_1), 
    .pcs_mac_pipeline_top_wrap_mquad1_tsu0_xlgmii_rx_sd(pcs_tsu_rx_sd[9:8]), 
    .pcs_mac_pipeline_top_wrap_mquad1_tsu0_xlgmii_rx_tsu(mii_rx_tsu_mux[9:8]), 
    .pcs_mac_pipeline_top_wrap_mquad1_tsu0_xlgmii_tx_tsu(mii_tx_tsu[9:8]), 
    .pcs_mac_pipeline_top_wrap_mquad1_mac1_xlgmii_tx_clkena(physs_hlp_xlgmii1_txclk_ena_1), 
    .pcs_mac_pipeline_top_wrap_mquad1_mac1_xlgmii_rx_clkena(physs_hlp_xlgmii1_rxclk_ena_1), 
    .pcs_mac_pipeline_top_wrap_mquad1_mac1_xlgmii_rx_rxc(physs_hlp_xlgmii1_rxc_1), 
    .pcs_mac_pipeline_top_wrap_mquad1_mac1_xlgmii_rx_rxd(physs_hlp_xlgmii1_rxd_1), 
    .pcs_mac_pipeline_top_wrap_mquad1_mac1_xlgmii_rxt0_next(physs_hlp_xlgmii1_rxt0_next_1), 
    .hlp_xlgmii1_txc_1(hlp_physs_xlgmii1_txc_1), 
    .hlp_xlgmii1_txd_1(hlp_physs_xlgmii1_txd_1), 
    .pcs_mac_pipeline_top_wrap_mquad1_tsu1_xlgmii_rx_sd(pcs_tsu_rx_sd[11:10]), 
    .pcs_mac_pipeline_top_wrap_mquad1_tsu1_xlgmii_rx_tsu(mii_rx_tsu_mux[11:10]), 
    .pcs_mac_pipeline_top_wrap_mquad1_tsu1_xlgmii_tx_tsu(mii_tx_tsu[11:10]), 
    .pcs_mac_pipeline_top_wrap_mquad1_mac2_xlgmii_tx_clkena(physs_hlp_xlgmii2_txclk_ena_1), 
    .pcs_mac_pipeline_top_wrap_mquad1_mac2_xlgmii_rx_clkena(physs_hlp_xlgmii2_rxclk_ena_1), 
    .pcs_mac_pipeline_top_wrap_mquad1_mac2_xlgmii_rx_rxc(physs_hlp_xlgmii2_rxc_1), 
    .pcs_mac_pipeline_top_wrap_mquad1_mac2_xlgmii_rx_rxd(physs_hlp_xlgmii2_rxd_1), 
    .pcs_mac_pipeline_top_wrap_mquad1_mac2_xlgmii_rxt0_next(physs_hlp_xlgmii2_rxt0_next_1), 
    .hlp_xlgmii2_txc_1(hlp_physs_xlgmii2_txc_1), 
    .hlp_xlgmii2_txd_1(hlp_physs_xlgmii2_txd_1), 
    .pcs_mac_pipeline_top_wrap_mquad1_tsu2_xlgmii_rx_sd(pcs_tsu_rx_sd[13:12]), 
    .pcs_mac_pipeline_top_wrap_mquad1_tsu2_xlgmii_rx_tsu(mii_rx_tsu_mux[13:12]), 
    .pcs_mac_pipeline_top_wrap_mquad1_tsu2_xlgmii_tx_tsu(mii_tx_tsu[13:12]), 
    .pcs_mac_pipeline_top_wrap_mquad1_mac3_xlgmii_tx_clkena(physs_hlp_xlgmii3_txclk_ena_1), 
    .pcs_mac_pipeline_top_wrap_mquad1_mac3_xlgmii_rx_clkena(physs_hlp_xlgmii3_rxclk_ena_1), 
    .pcs_mac_pipeline_top_wrap_mquad1_mac3_xlgmii_rx_rxc(physs_hlp_xlgmii3_rxc_1), 
    .pcs_mac_pipeline_top_wrap_mquad1_mac3_xlgmii_rx_rxd(physs_hlp_xlgmii3_rxd_1), 
    .pcs_mac_pipeline_top_wrap_mquad1_mac3_xlgmii_rxt0_next(physs_hlp_xlgmii3_rxt0_next_1), 
    .hlp_xlgmii3_txc_1(hlp_physs_xlgmii3_txc_1), 
    .hlp_xlgmii3_txd_1(hlp_physs_xlgmii3_txd_1), 
    .pcs_mac_pipeline_top_wrap_mquad1_tsu3_xlgmii_rx_sd(pcs_tsu_rx_sd[15:14]), 
    .pcs_mac_pipeline_top_wrap_mquad1_tsu3_xlgmii_rx_tsu(mii_rx_tsu_mux[15:14]), 
    .pcs_mac_pipeline_top_wrap_mquad1_tsu3_xlgmii_tx_tsu(mii_tx_tsu[15:14]), 
    .pcs_mac_pipeline_top_wrap_mquad1_mac0_cgmii_tx_clkena(hlp_cgmii0_txclk_ena_1), 
    .pcs_mac_pipeline_top_wrap_mquad1_mac0_cgmii_rx_clkena(hlp_cgmii0_rxclk_ena_1), 
    .pcs_mac_pipeline_top_wrap_mquad1_mac0_cgmii_rx_rxc(hlp_cgmii0_rxc_1), 
    .pcs_mac_pipeline_top_wrap_mquad1_mac0_cgmii_rx_rxd(hlp_cgmii0_rxd_1), 
    .hlp_cgmii0_txc_1(hlp_cgmii0_txc_1), 
    .hlp_cgmii0_txd_1(hlp_cgmii0_txd_1), 
    .pcs_mac_pipeline_top_wrap_mquad1_mac1_cgmii_tx_clkena(hlp_cgmii1_txclk_ena_1), 
    .pcs_mac_pipeline_top_wrap_mquad1_mac1_cgmii_rx_clkena(hlp_cgmii1_rxclk_ena_1), 
    .pcs_mac_pipeline_top_wrap_mquad1_mac1_cgmii_rx_rxc(hlp_cgmii1_rxc_1), 
    .pcs_mac_pipeline_top_wrap_mquad1_mac1_cgmii_rx_rxd(hlp_cgmii1_rxd_1), 
    .hlp_cgmii1_txc_1(hlp_cgmii1_txc_1), 
    .hlp_cgmii1_txd_1(hlp_cgmii1_txd_1), 
    .pcs_mac_pipeline_top_wrap_mquad1_mac2_cgmii_tx_clkena(hlp_cgmii2_txclk_ena_1), 
    .pcs_mac_pipeline_top_wrap_mquad1_mac2_cgmii_rx_clkena(hlp_cgmii2_rxclk_ena_1), 
    .pcs_mac_pipeline_top_wrap_mquad1_mac2_cgmii_rx_rxc(hlp_cgmii2_rxc_1), 
    .pcs_mac_pipeline_top_wrap_mquad1_mac2_cgmii_rx_rxd(hlp_cgmii2_rxd_1), 
    .hlp_cgmii2_txc_1(hlp_cgmii2_txc_1), 
    .hlp_cgmii2_txd_1(hlp_cgmii2_txd_1), 
    .pcs_mac_pipeline_top_wrap_mquad1_mac3_cgmii_tx_clkena(hlp_cgmii3_txclk_ena_1), 
    .pcs_mac_pipeline_top_wrap_mquad1_mac3_cgmii_rx_clkena(hlp_cgmii3_rxclk_ena_1), 
    .pcs_mac_pipeline_top_wrap_mquad1_mac3_cgmii_rx_rxc(hlp_cgmii3_rxc_1), 
    .pcs_mac_pipeline_top_wrap_mquad1_mac3_cgmii_rx_rxd(hlp_cgmii3_rxd_1), 
    .hlp_cgmii3_txc_1(hlp_cgmii3_txc_1), 
    .hlp_cgmii3_txd_1(hlp_cgmii3_txd_1), 
    // CDC: PQUAD0 XLGMII connections modified to route through CDC wires
    // Note: pquad0_0 ports remain internal, pquad0_1 ports route to top-level via CDC
    .pcs_mac_pipeline_top_wrap_pquad0_0_mac0_xlgmii_tx_clkena(pcs_mac_pipeline_top_wrap_pquad0_0_mac0_xlgmii_tx_clkena), 
    .pcs_mac_pipeline_top_wrap_pquad0_1_mac0_xlgmii_tx_clkena(physs_hlp_xlgmii0_txclk_ena_2), 
    .pcs_mac_pipeline_top_wrap_pquad0_0_mac0_xlgmii_rx_clkena(pcs_mac_pipeline_top_wrap_pquad0_0_mac0_xlgmii_rx_clkena), 
    .pcs_mac_pipeline_top_wrap_pquad0_1_mac0_xlgmii_rx_clkena(physs_hlp_xlgmii0_rxclk_ena_2), 
    .pcs_mac_pipeline_top_wrap_pquad0_0_mac0_xlgmii_rx_rxc(pcs_mac_pipeline_top_wrap_pquad0_0_mac0_xlgmii_rx_rxc), 
    .pcs_mac_pipeline_top_wrap_pquad0_1_mac0_xlgmii_rx_rxc(physs_hlp_xlgmii0_rxc_2), 
    .pcs_mac_pipeline_top_wrap_pquad0_0_mac0_xlgmii_rx_rxd(pcs_mac_pipeline_top_wrap_pquad0_0_mac0_xlgmii_rx_rxd), 
    .pcs_mac_pipeline_top_wrap_pquad0_1_mac0_xlgmii_rx_rxd(physs_hlp_xlgmii0_rxd_2), 
    .pcs_mac_pipeline_top_wrap_pquad0_0_mac0_xlgmii_rxt0_next(pcs_mac_pipeline_top_wrap_pquad0_0_mac0_xlgmii_rxt0_next), 
    .pcs_mac_pipeline_top_wrap_pquad0_1_mac0_xlgmii_rxt0_next(physs_hlp_xlgmii0_rxt0_next_2), 
    .hlp_xlgmii0_txc_2(hlp_physs_xlgmii0_txc_2), 
    .pcs_mac_pipeline_top_wrap_pquad0_1_pcs0_xlgmii_tx_txc(pcs_mac_pipeline_top_wrap_pquad0_1_pcs0_xlgmii_tx_txc), 
    .hlp_xlgmii0_txd_2(hlp_physs_xlgmii0_txd_2), 
    .pcs_mac_pipeline_top_wrap_pquad0_1_pcs0_xlgmii_tx_txd(pcs_mac_pipeline_top_wrap_pquad0_1_pcs0_xlgmii_tx_txd), 
    .pcs_mac_pipeline_top_wrap_pquad0_0_tsu0_xlgmii_rx_sd(pcs_mac_pipeline_top_wrap_pquad0_0_tsu0_xlgmii_rx_sd), 
    .pcs_mac_pipeline_top_wrap_pquad0_1_tsu0_xlgmii_rx_sd(pcs_tsu_rx_sd[17:16]), 
    .pcs_mac_pipeline_top_wrap_pquad0_0_tsu0_xlgmii_rx_tsu(pcs_mac_pipeline_top_wrap_pquad0_0_tsu0_xlgmii_rx_tsu), 
    .pcs_mac_pipeline_top_wrap_pquad0_1_tsu0_xlgmii_rx_tsu(mii_rx_tsu_mux[17:16]), 
    .pcs_mac_pipeline_top_wrap_pquad0_0_tsu0_xlgmii_tx_tsu(pcs_mac_pipeline_top_wrap_pquad0_0_tsu0_xlgmii_tx_tsu), 
    .pcs_mac_pipeline_top_wrap_pquad0_1_tsu0_xlgmii_tx_tsu(mii_tx_tsu[17:16]), 
    .pcs_mac_pipeline_top_wrap_pquad0_0_mac1_xlgmii_tx_clkena(pcs_mac_pipeline_top_wrap_pquad0_0_mac1_xlgmii_tx_clkena), 
    .pcs_mac_pipeline_top_wrap_pquad0_1_mac1_xlgmii_tx_clkena(physs_hlp_xlgmii1_txclk_ena_2), 
    .pcs_mac_pipeline_top_wrap_pquad0_0_mac1_xlgmii_rx_clkena(pcs_mac_pipeline_top_wrap_pquad0_0_mac1_xlgmii_rx_clkena), 
    .pcs_mac_pipeline_top_wrap_pquad0_1_mac1_xlgmii_rx_clkena(physs_hlp_xlgmii1_rxclk_ena_2), 
    .pcs_mac_pipeline_top_wrap_pquad0_0_mac1_xlgmii_rx_rxc(pcs_mac_pipeline_top_wrap_pquad0_0_mac1_xlgmii_rx_rxc), 
    .pcs_mac_pipeline_top_wrap_pquad0_1_mac1_xlgmii_rx_rxc(physs_hlp_xlgmii1_rxc_2), 
    .pcs_mac_pipeline_top_wrap_pquad0_0_mac1_xlgmii_rx_rxd(pcs_mac_pipeline_top_wrap_pquad0_0_mac1_xlgmii_rx_rxd), 
    .pcs_mac_pipeline_top_wrap_pquad0_1_mac1_xlgmii_rx_rxd(physs_hlp_xlgmii1_rxd_2), 
    .pcs_mac_pipeline_top_wrap_pquad0_0_mac1_xlgmii_rxt0_next(pcs_mac_pipeline_top_wrap_pquad0_0_mac1_xlgmii_rxt0_next), 
    .pcs_mac_pipeline_top_wrap_pquad0_1_mac1_xlgmii_rxt0_next(physs_hlp_xlgmii1_rxt0_next_2), 
    .hlp_xlgmii1_txc_2(hlp_physs_xlgmii1_txc_2), 
    .pcs_mac_pipeline_top_wrap_pquad0_1_pcs1_xlgmii_tx_txc(pcs_mac_pipeline_top_wrap_pquad0_1_pcs1_xlgmii_tx_txc), 
    .hlp_xlgmii1_txd_2(hlp_physs_xlgmii1_txd_2), 
    .pcs_mac_pipeline_top_wrap_pquad0_1_pcs1_xlgmii_tx_txd(pcs_mac_pipeline_top_wrap_pquad0_1_pcs1_xlgmii_tx_txd), 
    .pcs_mac_pipeline_top_wrap_pquad0_0_tsu1_xlgmii_rx_sd(pcs_mac_pipeline_top_wrap_pquad0_0_tsu1_xlgmii_rx_sd), 
    .pcs_mac_pipeline_top_wrap_pquad0_1_tsu1_xlgmii_rx_sd(pcs_tsu_rx_sd[19:18]), 
    .pcs_mac_pipeline_top_wrap_pquad0_0_tsu1_xlgmii_rx_tsu(pcs_mac_pipeline_top_wrap_pquad0_0_tsu1_xlgmii_rx_tsu), 
    .pcs_mac_pipeline_top_wrap_pquad0_1_tsu1_xlgmii_rx_tsu(mii_rx_tsu_mux[19:18]), 
    .pcs_mac_pipeline_top_wrap_pquad0_0_tsu1_xlgmii_tx_tsu(pcs_mac_pipeline_top_wrap_pquad0_0_tsu1_xlgmii_tx_tsu), 
    .pcs_mac_pipeline_top_wrap_pquad0_1_tsu1_xlgmii_tx_tsu(mii_tx_tsu[19:18]), 
    .pcs_mac_pipeline_top_wrap_pquad0_0_mac2_xlgmii_tx_clkena(pcs_mac_pipeline_top_wrap_pquad0_0_mac2_xlgmii_tx_clkena), 
    .pcs_mac_pipeline_top_wrap_pquad0_1_mac2_xlgmii_tx_clkena(physs_hlp_xlgmii2_txclk_ena_2), 
    .pcs_mac_pipeline_top_wrap_pquad0_0_mac2_xlgmii_rx_clkena(pcs_mac_pipeline_top_wrap_pquad0_0_mac2_xlgmii_rx_clkena), 
    .pcs_mac_pipeline_top_wrap_pquad0_1_mac2_xlgmii_rx_clkena(physs_hlp_xlgmii2_rxclk_ena_2), 
    .pcs_mac_pipeline_top_wrap_pquad0_0_mac2_xlgmii_rx_rxc(pcs_mac_pipeline_top_wrap_pquad0_0_mac2_xlgmii_rx_rxc), 
    .pcs_mac_pipeline_top_wrap_pquad0_1_mac2_xlgmii_rx_rxc(physs_hlp_xlgmii2_rxc_2), 
    .pcs_mac_pipeline_top_wrap_pquad0_0_mac2_xlgmii_rx_rxd(pcs_mac_pipeline_top_wrap_pquad0_0_mac2_xlgmii_rx_rxd), 
    .pcs_mac_pipeline_top_wrap_pquad0_1_mac2_xlgmii_rx_rxd(physs_hlp_xlgmii2_rxd_2), 
    .pcs_mac_pipeline_top_wrap_pquad0_0_mac2_xlgmii_rxt0_next(pcs_mac_pipeline_top_wrap_pquad0_0_mac2_xlgmii_rxt0_next), 
    .pcs_mac_pipeline_top_wrap_pquad0_1_mac2_xlgmii_rxt0_next(physs_hlp_xlgmii2_rxt0_next_2), 
    .hlp_xlgmii2_txc_2(hlp_physs_xlgmii2_txc_2), 
    .pcs_mac_pipeline_top_wrap_pquad0_1_pcs2_xlgmii_tx_txc(pcs_mac_pipeline_top_wrap_pquad0_1_pcs2_xlgmii_tx_txc), 
    .hlp_xlgmii2_txd_2(hlp_physs_xlgmii2_txd_2), 
    .pcs_mac_pipeline_top_wrap_pquad0_1_pcs2_xlgmii_tx_txd(pcs_mac_pipeline_top_wrap_pquad0_1_pcs2_xlgmii_tx_txd), 
    .pcs_mac_pipeline_top_wrap_pquad0_0_tsu2_xlgmii_rx_sd(pcs_mac_pipeline_top_wrap_pquad0_0_tsu2_xlgmii_rx_sd), 
    .pcs_mac_pipeline_top_wrap_pquad0_1_tsu2_xlgmii_rx_sd(pcs_tsu_rx_sd[21:20]), 
    .pcs_mac_pipeline_top_wrap_pquad0_0_tsu2_xlgmii_rx_tsu(pcs_mac_pipeline_top_wrap_pquad0_0_tsu2_xlgmii_rx_tsu), 
    .pcs_mac_pipeline_top_wrap_pquad0_1_tsu2_xlgmii_rx_tsu(mii_rx_tsu_mux[21:20]), 
    .pcs_mac_pipeline_top_wrap_pquad0_0_tsu2_xlgmii_tx_tsu(pcs_mac_pipeline_top_wrap_pquad0_0_tsu2_xlgmii_tx_tsu), 
    .pcs_mac_pipeline_top_wrap_pquad0_1_tsu2_xlgmii_tx_tsu(mii_tx_tsu[21:20]), 
    .pcs_mac_pipeline_top_wrap_pquad0_0_mac3_xlgmii_tx_clkena(pcs_mac_pipeline_top_wrap_pquad0_0_mac3_xlgmii_tx_clkena), 
    .pcs_mac_pipeline_top_wrap_pquad0_1_mac3_xlgmii_tx_clkena(physs_hlp_xlgmii3_txclk_ena_2), 
    .pcs_mac_pipeline_top_wrap_pquad0_0_mac3_xlgmii_rx_clkena(pcs_mac_pipeline_top_wrap_pquad0_0_mac3_xlgmii_rx_clkena), 
    .pcs_mac_pipeline_top_wrap_pquad0_1_mac3_xlgmii_rx_clkena(physs_hlp_xlgmii3_rxclk_ena_2), 
    .pcs_mac_pipeline_top_wrap_pquad0_0_mac3_xlgmii_rx_rxc(pcs_mac_pipeline_top_wrap_pquad0_0_mac3_xlgmii_rx_rxc), 
    .pcs_mac_pipeline_top_wrap_pquad0_1_mac3_xlgmii_rx_rxc(physs_hlp_xlgmii3_rxc_2), 
    .pcs_mac_pipeline_top_wrap_pquad0_0_mac3_xlgmii_rx_rxd(pcs_mac_pipeline_top_wrap_pquad0_0_mac3_xlgmii_rx_rxd), 
    .pcs_mac_pipeline_top_wrap_pquad0_1_mac3_xlgmii_rx_rxd(physs_hlp_xlgmii3_rxd_2), 
    .pcs_mac_pipeline_top_wrap_pquad0_0_mac3_xlgmii_rxt0_next(pcs_mac_pipeline_top_wrap_pquad0_0_mac3_xlgmii_rxt0_next), 
    .pcs_mac_pipeline_top_wrap_pquad0_1_mac3_xlgmii_rxt0_next(physs_hlp_xlgmii3_rxt0_next_2), 
    .hlp_xlgmii3_txc_2(hlp_physs_xlgmii3_txc_2), 
    .pcs_mac_pipeline_top_wrap_pquad0_1_pcs3_xlgmii_tx_txc(pcs_mac_pipeline_top_wrap_pquad0_1_pcs3_xlgmii_tx_txc), 
    .hlp_xlgmii3_txd_2(hlp_physs_xlgmii3_txd_2), 
    .pcs_mac_pipeline_top_wrap_pquad0_1_pcs3_xlgmii_tx_txd(pcs_mac_pipeline_top_wrap_pquad0_1_pcs3_xlgmii_tx_txd), 
    .pcs_mac_pipeline_top_wrap_pquad0_0_tsu3_xlgmii_rx_sd(pcs_mac_pipeline_top_wrap_pquad0_0_tsu3_xlgmii_rx_sd), 
    .pcs_mac_pipeline_top_wrap_pquad0_1_tsu3_xlgmii_rx_sd(pcs_tsu_rx_sd[23:22]), 
    .pcs_mac_pipeline_top_wrap_pquad0_0_tsu3_xlgmii_rx_tsu(pcs_mac_pipeline_top_wrap_pquad0_0_tsu3_xlgmii_rx_tsu), 
    .pcs_mac_pipeline_top_wrap_pquad0_1_tsu3_xlgmii_rx_tsu(mii_rx_tsu_mux[23:22]), 
    .pcs_mac_pipeline_top_wrap_pquad0_0_tsu3_xlgmii_tx_tsu(pcs_mac_pipeline_top_wrap_pquad0_0_tsu3_xlgmii_tx_tsu), 
    .pcs_mac_pipeline_top_wrap_pquad0_1_tsu3_xlgmii_tx_tsu(mii_tx_tsu[23:22]), 
    .pcs_mac_pipeline_top_wrap_pquad0_0_mac0_cgmii_tx_clkena(pcs_mac_pipeline_top_wrap_pquad0_0_mac0_cgmii_tx_clkena), 
    .pcs_mac_pipeline_top_wrap_pquad0_1_mac0_cgmii_tx_clkena(hlp_cgmii0_txclk_ena_2), 
    .pcs_mac_pipeline_top_wrap_pquad0_0_mac0_cgmii_rx_clkena(pcs_mac_pipeline_top_wrap_pquad0_0_mac0_cgmii_rx_clkena), 
    .pcs_mac_pipeline_top_wrap_pquad0_1_mac0_cgmii_rx_clkena(hlp_cgmii0_rxclk_ena_2), 
    .pcs_mac_pipeline_top_wrap_pquad0_0_mac0_cgmii_rx_rxc(pcs_mac_pipeline_top_wrap_pquad0_0_mac0_cgmii_rx_rxc), 
    .pcs_mac_pipeline_top_wrap_pquad0_1_mac0_cgmii_rx_rxc(hlp_cgmii0_rxc_2), 
    .pcs_mac_pipeline_top_wrap_pquad0_0_mac0_cgmii_rx_rxd(pcs_mac_pipeline_top_wrap_pquad0_0_mac0_cgmii_rx_rxd), 
    .pcs_mac_pipeline_top_wrap_pquad0_1_mac0_cgmii_rx_rxd(hlp_cgmii0_rxd_2), 
    .hlp_cgmii0_txc_2(hlp_cgmii0_txc_2), 
    .pcs_mac_pipeline_top_wrap_pquad0_1_pcs0_cgmii_tx_txc(pcs_mac_pipeline_top_wrap_pquad0_1_pcs0_cgmii_tx_txc), 
    .hlp_cgmii0_txd_2(hlp_cgmii0_txd_2), 
    .pcs_mac_pipeline_top_wrap_pquad0_1_pcs0_cgmii_tx_txd(pcs_mac_pipeline_top_wrap_pquad0_1_pcs0_cgmii_tx_txd), 
    .pcs_mac_pipeline_top_wrap_pquad0_0_mac1_cgmii_tx_clkena(pcs_mac_pipeline_top_wrap_pquad0_0_mac1_cgmii_tx_clkena), 
    .pcs_mac_pipeline_top_wrap_pquad0_1_mac1_cgmii_tx_clkena(hlp_cgmii1_txclk_ena_2), 
    .pcs_mac_pipeline_top_wrap_pquad0_0_mac1_cgmii_rx_clkena(pcs_mac_pipeline_top_wrap_pquad0_0_mac1_cgmii_rx_clkena), 
    .pcs_mac_pipeline_top_wrap_pquad0_1_mac1_cgmii_rx_clkena(hlp_cgmii1_rxclk_ena_2), 
    .pcs_mac_pipeline_top_wrap_pquad0_0_mac1_cgmii_rx_rxc(pcs_mac_pipeline_top_wrap_pquad0_0_mac1_cgmii_rx_rxc), 
    .pcs_mac_pipeline_top_wrap_pquad0_1_mac1_cgmii_rx_rxc(hlp_cgmii1_rxc_2), 
    .pcs_mac_pipeline_top_wrap_pquad0_0_mac1_cgmii_rx_rxd(pcs_mac_pipeline_top_wrap_pquad0_0_mac1_cgmii_rx_rxd), 
    .pcs_mac_pipeline_top_wrap_pquad0_1_mac1_cgmii_rx_rxd(hlp_cgmii1_rxd_2), 
    .hlp_cgmii1_txc_2(hlp_cgmii1_txc_2), 
    .pcs_mac_pipeline_top_wrap_pquad0_1_pcs1_cgmii_tx_txc(pcs_mac_pipeline_top_wrap_pquad0_1_pcs1_cgmii_tx_txc), 
    .hlp_cgmii1_txd_2(hlp_cgmii1_txd_2), 
    .pcs_mac_pipeline_top_wrap_pquad0_1_pcs1_cgmii_tx_txd(pcs_mac_pipeline_top_wrap_pquad0_1_pcs1_cgmii_tx_txd), 
    .pcs_mac_pipeline_top_wrap_pquad0_0_mac2_cgmii_tx_clkena(pcs_mac_pipeline_top_wrap_pquad0_0_mac2_cgmii_tx_clkena), 
    .pcs_mac_pipeline_top_wrap_pquad0_1_mac2_cgmii_tx_clkena(hlp_cgmii2_txclk_ena_2), 
    .pcs_mac_pipeline_top_wrap_pquad0_0_mac2_cgmii_rx_clkena(pcs_mac_pipeline_top_wrap_pquad0_0_mac2_cgmii_rx_clkena), 
    .pcs_mac_pipeline_top_wrap_pquad0_1_mac2_cgmii_rx_clkena(hlp_cgmii2_rxclk_ena_2), 
    .pcs_mac_pipeline_top_wrap_pquad0_0_mac2_cgmii_rx_rxc(pcs_mac_pipeline_top_wrap_pquad0_0_mac2_cgmii_rx_rxc), 
    .pcs_mac_pipeline_top_wrap_pquad0_1_mac2_cgmii_rx_rxc(hlp_cgmii2_rxc_2), 
    .pcs_mac_pipeline_top_wrap_pquad0_0_mac2_cgmii_rx_rxd(pcs_mac_pipeline_top_wrap_pquad0_0_mac2_cgmii_rx_rxd), 
    .pcs_mac_pipeline_top_wrap_pquad0_1_mac2_cgmii_rx_rxd(hlp_cgmii2_rxd_2), 
    .hlp_cgmii2_txc_2(hlp_cgmii2_txc_2), 
    .pcs_mac_pipeline_top_wrap_pquad0_1_pcs2_cgmii_tx_txc(pcs_mac_pipeline_top_wrap_pquad0_1_pcs2_cgmii_tx_txc), 
    .hlp_cgmii2_txd_2(hlp_cgmii2_txd_2), 
    .pcs_mac_pipeline_top_wrap_pquad0_1_pcs2_cgmii_tx_txd(pcs_mac_pipeline_top_wrap_pquad0_1_pcs2_cgmii_tx_txd), 
    .pcs_mac_pipeline_top_wrap_pquad0_0_mac3_cgmii_tx_clkena(pcs_mac_pipeline_top_wrap_pquad0_0_mac3_cgmii_tx_clkena), 
    .pcs_mac_pipeline_top_wrap_pquad0_1_mac3_cgmii_tx_clkena(hlp_cgmii3_txclk_ena_2), 
    .pcs_mac_pipeline_top_wrap_pquad0_0_mac3_cgmii_rx_clkena(pcs_mac_pipeline_top_wrap_pquad0_0_mac3_cgmii_rx_clkena), 
    .pcs_mac_pipeline_top_wrap_pquad0_1_mac3_cgmii_rx_clkena(hlp_cgmii3_rxclk_ena_2), 
    .pcs_mac_pipeline_top_wrap_pquad0_0_mac3_cgmii_rx_rxc(pcs_mac_pipeline_top_wrap_pquad0_0_mac3_cgmii_rx_rxc), 
    .pcs_mac_pipeline_top_wrap_pquad0_1_mac3_cgmii_rx_rxc(hlp_cgmii3_rxc_2), 
    .pcs_mac_pipeline_top_wrap_pquad0_0_mac3_cgmii_rx_rxd(pcs_mac_pipeline_top_wrap_pquad0_0_mac3_cgmii_rx_rxd), 
    .pcs_mac_pipeline_top_wrap_pquad0_1_mac3_cgmii_rx_rxd(hlp_cgmii3_rxd_2), 
    .hlp_cgmii3_txc_2(hlp_cgmii3_txc_2), 
    .pcs_mac_pipeline_top_wrap_pquad0_1_pcs3_cgmii_tx_txc(pcs_mac_pipeline_top_wrap_pquad0_1_pcs3_cgmii_tx_txc), 
    .hlp_cgmii3_txd_2(hlp_cgmii3_txd_2), 
    .pcs_mac_pipeline_top_wrap_pquad0_1_pcs3_cgmii_tx_txd(pcs_mac_pipeline_top_wrap_pquad0_1_pcs3_cgmii_tx_txd), 
    // CDC: PQUAD1 XLGMII connections modified to route through CDC wires
    // Note: pquad1_0 ports remain internal, pquad1_1 ports route to top-level via CDC
    .pcs_mac_pipeline_top_wrap_pquad1_0_mac0_xlgmii_tx_clkena(pcs_mac_pipeline_top_wrap_pquad1_0_mac0_xlgmii_tx_clkena), 
    .pcs_mac_pipeline_top_wrap_pquad1_1_mac0_xlgmii_tx_clkena(physs_hlp_xlgmii0_txclk_ena_3), 
    .pcs_mac_pipeline_top_wrap_pquad1_0_mac0_xlgmii_rx_clkena(pcs_mac_pipeline_top_wrap_pquad1_0_mac0_xlgmii_rx_clkena), 
    .pcs_mac_pipeline_top_wrap_pquad1_1_mac0_xlgmii_rx_clkena(physs_hlp_xlgmii0_rxclk_ena_3), 
    .pcs_mac_pipeline_top_wrap_pquad1_0_mac0_xlgmii_rx_rxc(pcs_mac_pipeline_top_wrap_pquad1_0_mac0_xlgmii_rx_rxc), 
    .pcs_mac_pipeline_top_wrap_pquad1_1_mac0_xlgmii_rx_rxc(physs_hlp_xlgmii0_rxc_3), 
    .pcs_mac_pipeline_top_wrap_pquad1_0_mac0_xlgmii_rx_rxd(pcs_mac_pipeline_top_wrap_pquad1_0_mac0_xlgmii_rx_rxd), 
    .pcs_mac_pipeline_top_wrap_pquad1_1_mac0_xlgmii_rx_rxd(physs_hlp_xlgmii0_rxd_3), 
    .pcs_mac_pipeline_top_wrap_pquad1_0_mac0_xlgmii_rxt0_next(pcs_mac_pipeline_top_wrap_pquad1_0_mac0_xlgmii_rxt0_next), 
    .pcs_mac_pipeline_top_wrap_pquad1_1_mac0_xlgmii_rxt0_next(physs_hlp_xlgmii0_rxt0_next_3), 
    .hlp_xlgmii0_txc_3(hlp_physs_xlgmii0_txc_3), 
    .pcs_mac_pipeline_top_wrap_pquad1_1_pcs0_xlgmii_tx_txc(pcs_mac_pipeline_top_wrap_pquad1_1_pcs0_xlgmii_tx_txc), 
    .hlp_xlgmii0_txd_3(hlp_physs_xlgmii0_txd_3), 
    .pcs_mac_pipeline_top_wrap_pquad1_1_pcs0_xlgmii_tx_txd(pcs_mac_pipeline_top_wrap_pquad1_1_pcs0_xlgmii_tx_txd), 
    .pcs_mac_pipeline_top_wrap_pquad1_0_tsu0_xlgmii_rx_sd(pcs_mac_pipeline_top_wrap_pquad1_0_tsu0_xlgmii_rx_sd), 
    .pcs_mac_pipeline_top_wrap_pquad1_1_tsu0_xlgmii_rx_sd(pcs_tsu_rx_sd[25:24]), 
    .pcs_mac_pipeline_top_wrap_pquad1_0_tsu0_xlgmii_rx_tsu(pcs_mac_pipeline_top_wrap_pquad1_0_tsu0_xlgmii_rx_tsu), 
    .pcs_mac_pipeline_top_wrap_pquad1_1_tsu0_xlgmii_rx_tsu(mii_rx_tsu_mux[25:24]), 
    .pcs_mac_pipeline_top_wrap_pquad1_0_tsu0_xlgmii_tx_tsu(pcs_mac_pipeline_top_wrap_pquad1_0_tsu0_xlgmii_tx_tsu), 
    .pcs_mac_pipeline_top_wrap_pquad1_1_tsu0_xlgmii_tx_tsu(mii_tx_tsu[25:24]), 
    .pcs_mac_pipeline_top_wrap_pquad1_0_mac1_xlgmii_tx_clkena(pcs_mac_pipeline_top_wrap_pquad1_0_mac1_xlgmii_tx_clkena), 
    .pcs_mac_pipeline_top_wrap_pquad1_1_mac1_xlgmii_tx_clkena(physs_hlp_xlgmii1_txclk_ena_3), 
    .pcs_mac_pipeline_top_wrap_pquad1_0_mac1_xlgmii_rx_clkena(pcs_mac_pipeline_top_wrap_pquad1_0_mac1_xlgmii_rx_clkena), 
    .pcs_mac_pipeline_top_wrap_pquad1_1_mac1_xlgmii_rx_clkena(physs_hlp_xlgmii1_rxclk_ena_3), 
    .pcs_mac_pipeline_top_wrap_pquad1_0_mac1_xlgmii_rx_rxc(pcs_mac_pipeline_top_wrap_pquad1_0_mac1_xlgmii_rx_rxc), 
    .pcs_mac_pipeline_top_wrap_pquad1_1_mac1_xlgmii_rx_rxc(physs_hlp_xlgmii1_rxc_3), 
    .pcs_mac_pipeline_top_wrap_pquad1_0_mac1_xlgmii_rx_rxd(pcs_mac_pipeline_top_wrap_pquad1_0_mac1_xlgmii_rx_rxd), 
    .pcs_mac_pipeline_top_wrap_pquad1_1_mac1_xlgmii_rx_rxd(physs_hlp_xlgmii1_rxd_3), 
    .pcs_mac_pipeline_top_wrap_pquad1_0_mac1_xlgmii_rxt0_next(pcs_mac_pipeline_top_wrap_pquad1_0_mac1_xlgmii_rxt0_next), 
    .pcs_mac_pipeline_top_wrap_pquad1_1_mac1_xlgmii_rxt0_next(physs_hlp_xlgmii1_rxt0_next_3), 
    .hlp_xlgmii1_txc_3(hlp_physs_xlgmii1_txc_3), 
    .pcs_mac_pipeline_top_wrap_pquad1_1_pcs1_xlgmii_tx_txc(pcs_mac_pipeline_top_wrap_pquad1_1_pcs1_xlgmii_tx_txc), 
    .hlp_xlgmii1_txd_3(hlp_physs_xlgmii1_txd_3), 
    .pcs_mac_pipeline_top_wrap_pquad1_1_pcs1_xlgmii_tx_txd(pcs_mac_pipeline_top_wrap_pquad1_1_pcs1_xlgmii_tx_txd), 
    .pcs_mac_pipeline_top_wrap_pquad1_0_tsu1_xlgmii_rx_sd(pcs_mac_pipeline_top_wrap_pquad1_0_tsu1_xlgmii_rx_sd), 
    .pcs_mac_pipeline_top_wrap_pquad1_1_tsu1_xlgmii_rx_sd(pcs_tsu_rx_sd[27:26]), 
    .pcs_mac_pipeline_top_wrap_pquad1_0_tsu1_xlgmii_rx_tsu(pcs_mac_pipeline_top_wrap_pquad1_0_tsu1_xlgmii_rx_tsu), 
    .pcs_mac_pipeline_top_wrap_pquad1_1_tsu1_xlgmii_rx_tsu(mii_rx_tsu_mux[27:26]), 
    .pcs_mac_pipeline_top_wrap_pquad1_0_tsu1_xlgmii_tx_tsu(pcs_mac_pipeline_top_wrap_pquad1_0_tsu1_xlgmii_tx_tsu), 
    .pcs_mac_pipeline_top_wrap_pquad1_1_tsu1_xlgmii_tx_tsu(mii_tx_tsu[27:26]), 
    .pcs_mac_pipeline_top_wrap_pquad1_0_mac2_xlgmii_tx_clkena(pcs_mac_pipeline_top_wrap_pquad1_0_mac2_xlgmii_tx_clkena), 
    .pcs_mac_pipeline_top_wrap_pquad1_1_mac2_xlgmii_tx_clkena(physs_hlp_xlgmii2_txclk_ena_3), 
    .pcs_mac_pipeline_top_wrap_pquad1_0_mac2_xlgmii_rx_clkena(pcs_mac_pipeline_top_wrap_pquad1_0_mac2_xlgmii_rx_clkena), 
    .pcs_mac_pipeline_top_wrap_pquad1_1_mac2_xlgmii_rx_clkena(physs_hlp_xlgmii2_rxclk_ena_3), 
    .pcs_mac_pipeline_top_wrap_pquad1_0_mac2_xlgmii_rx_rxc(pcs_mac_pipeline_top_wrap_pquad1_0_mac2_xlgmii_rx_rxc), 
    .pcs_mac_pipeline_top_wrap_pquad1_1_mac2_xlgmii_rx_rxc(physs_hlp_xlgmii2_rxc_3), 
    .pcs_mac_pipeline_top_wrap_pquad1_0_mac2_xlgmii_rx_rxd(pcs_mac_pipeline_top_wrap_pquad1_0_mac2_xlgmii_rx_rxd), 
    .pcs_mac_pipeline_top_wrap_pquad1_1_mac2_xlgmii_rx_rxd(physs_hlp_xlgmii2_rxd_3), 
    .pcs_mac_pipeline_top_wrap_pquad1_0_mac2_xlgmii_rxt0_next(pcs_mac_pipeline_top_wrap_pquad1_0_mac2_xlgmii_rxt0_next), 
    .pcs_mac_pipeline_top_wrap_pquad1_1_mac2_xlgmii_rxt0_next(physs_hlp_xlgmii2_rxt0_next_3), 
    .hlp_xlgmii2_txc_3(hlp_physs_xlgmii2_txc_3), 
    .pcs_mac_pipeline_top_wrap_pquad1_1_pcs2_xlgmii_tx_txc(pcs_mac_pipeline_top_wrap_pquad1_1_pcs2_xlgmii_tx_txc), 
    .hlp_xlgmii2_txd_3(hlp_physs_xlgmii2_txd_3), 
    .pcs_mac_pipeline_top_wrap_pquad1_1_pcs2_xlgmii_tx_txd(pcs_mac_pipeline_top_wrap_pquad1_1_pcs2_xlgmii_tx_txd), 
    .pcs_mac_pipeline_top_wrap_pquad1_0_tsu2_xlgmii_rx_sd(pcs_mac_pipeline_top_wrap_pquad1_0_tsu2_xlgmii_rx_sd), 
    .pcs_mac_pipeline_top_wrap_pquad1_1_tsu2_xlgmii_rx_sd(pcs_tsu_rx_sd[29:28]), 
    .pcs_mac_pipeline_top_wrap_pquad1_0_tsu2_xlgmii_rx_tsu(pcs_mac_pipeline_top_wrap_pquad1_0_tsu2_xlgmii_rx_tsu), 
    .pcs_mac_pipeline_top_wrap_pquad1_1_tsu2_xlgmii_rx_tsu(mii_rx_tsu_mux[29:28]), 
    .pcs_mac_pipeline_top_wrap_pquad1_0_tsu2_xlgmii_tx_tsu(pcs_mac_pipeline_top_wrap_pquad1_0_tsu2_xlgmii_tx_tsu), 
    .pcs_mac_pipeline_top_wrap_pquad1_1_tsu2_xlgmii_tx_tsu(mii_tx_tsu[29:28]), 
    .pcs_mac_pipeline_top_wrap_pquad1_0_mac3_xlgmii_tx_clkena(pcs_mac_pipeline_top_wrap_pquad1_0_mac3_xlgmii_tx_clkena), 
    .pcs_mac_pipeline_top_wrap_pquad1_1_mac3_xlgmii_tx_clkena(physs_hlp_xlgmii3_txclk_ena_3), 
    .pcs_mac_pipeline_top_wrap_pquad1_0_mac3_xlgmii_rx_clkena(pcs_mac_pipeline_top_wrap_pquad1_0_mac3_xlgmii_rx_clkena), 
    .pcs_mac_pipeline_top_wrap_pquad1_1_mac3_xlgmii_rx_clkena(physs_hlp_xlgmii3_rxclk_ena_3), 
    .pcs_mac_pipeline_top_wrap_pquad1_0_mac3_xlgmii_rx_rxc(pcs_mac_pipeline_top_wrap_pquad1_0_mac3_xlgmii_rx_rxc), 
    .pcs_mac_pipeline_top_wrap_pquad1_1_mac3_xlgmii_rx_rxc(physs_hlp_xlgmii3_rxc_3), 
    .pcs_mac_pipeline_top_wrap_pquad1_0_mac3_xlgmii_rx_rxd(pcs_mac_pipeline_top_wrap_pquad1_0_mac3_xlgmii_rx_rxd), 
    .pcs_mac_pipeline_top_wrap_pquad1_1_mac3_xlgmii_rx_rxd(physs_hlp_xlgmii3_rxd_3), 
    .pcs_mac_pipeline_top_wrap_pquad1_0_mac3_xlgmii_rxt0_next(pcs_mac_pipeline_top_wrap_pquad1_0_mac3_xlgmii_rxt0_next), 
    .pcs_mac_pipeline_top_wrap_pquad1_1_mac3_xlgmii_rxt0_next(physs_hlp_xlgmii3_rxt0_next_3), 
    .hlp_xlgmii3_txc_3(hlp_physs_xlgmii3_txc_3), 
    .pcs_mac_pipeline_top_wrap_pquad1_1_pcs3_xlgmii_tx_txc(pcs_mac_pipeline_top_wrap_pquad1_1_pcs3_xlgmii_tx_txc), 
    .hlp_xlgmii3_txd_3(hlp_physs_xlgmii3_txd_3), 
    .pcs_mac_pipeline_top_wrap_pquad1_1_pcs3_xlgmii_tx_txd(pcs_mac_pipeline_top_wrap_pquad1_1_pcs3_xlgmii_tx_txd), 
    .pcs_mac_pipeline_top_wrap_pquad1_0_tsu3_xlgmii_rx_sd(pcs_mac_pipeline_top_wrap_pquad1_0_tsu3_xlgmii_rx_sd), 
    .pcs_mac_pipeline_top_wrap_pquad1_1_tsu3_xlgmii_rx_sd(pcs_tsu_rx_sd[31:30]), 
    .pcs_mac_pipeline_top_wrap_pquad1_0_tsu3_xlgmii_rx_tsu(pcs_mac_pipeline_top_wrap_pquad1_0_tsu3_xlgmii_rx_tsu), 
    .pcs_mac_pipeline_top_wrap_pquad1_1_tsu3_xlgmii_rx_tsu(mii_rx_tsu_mux[31:30]), 
    .pcs_mac_pipeline_top_wrap_pquad1_0_tsu3_xlgmii_tx_tsu(pcs_mac_pipeline_top_wrap_pquad1_0_tsu3_xlgmii_tx_tsu), 
    .pcs_mac_pipeline_top_wrap_pquad1_1_tsu3_xlgmii_tx_tsu(mii_tx_tsu[31:30]), 
    .pcs_mac_pipeline_top_wrap_pquad1_0_mac0_cgmii_tx_clkena(pcs_mac_pipeline_top_wrap_pquad1_0_mac0_cgmii_tx_clkena), 
    .pcs_mac_pipeline_top_wrap_pquad1_1_mac0_cgmii_tx_clkena(hlp_cgmii0_txclk_ena_3), 
    .pcs_mac_pipeline_top_wrap_pquad1_0_mac0_cgmii_rx_clkena(pcs_mac_pipeline_top_wrap_pquad1_0_mac0_cgmii_rx_clkena), 
    .pcs_mac_pipeline_top_wrap_pquad1_1_mac0_cgmii_rx_clkena(hlp_cgmii0_rxclk_ena_3), 
    .pcs_mac_pipeline_top_wrap_pquad1_0_mac0_cgmii_rx_rxc(pcs_mac_pipeline_top_wrap_pquad1_0_mac0_cgmii_rx_rxc), 
    .pcs_mac_pipeline_top_wrap_pquad1_1_mac0_cgmii_rx_rxc(hlp_cgmii0_rxc_3), 
    .pcs_mac_pipeline_top_wrap_pquad1_0_mac0_cgmii_rx_rxd(pcs_mac_pipeline_top_wrap_pquad1_0_mac0_cgmii_rx_rxd), 
    .pcs_mac_pipeline_top_wrap_pquad1_1_mac0_cgmii_rx_rxd(hlp_cgmii0_rxd_3), 
    .hlp_cgmii0_txc_3(hlp_cgmii0_txc_3), 
    .pcs_mac_pipeline_top_wrap_pquad1_1_pcs0_cgmii_tx_txc(pcs_mac_pipeline_top_wrap_pquad1_1_pcs0_cgmii_tx_txc), 
    .hlp_cgmii0_txd_3(hlp_cgmii0_txd_3), 
    .pcs_mac_pipeline_top_wrap_pquad1_1_pcs0_cgmii_tx_txd(pcs_mac_pipeline_top_wrap_pquad1_1_pcs0_cgmii_tx_txd), 
    .pcs_mac_pipeline_top_wrap_pquad1_0_mac1_cgmii_tx_clkena(pcs_mac_pipeline_top_wrap_pquad1_0_mac1_cgmii_tx_clkena), 
    .pcs_mac_pipeline_top_wrap_pquad1_1_mac1_cgmii_tx_clkena(hlp_cgmii1_txclk_ena_3), 
    .pcs_mac_pipeline_top_wrap_pquad1_0_mac1_cgmii_rx_clkena(pcs_mac_pipeline_top_wrap_pquad1_0_mac1_cgmii_rx_clkena), 
    .pcs_mac_pipeline_top_wrap_pquad1_1_mac1_cgmii_rx_clkena(hlp_cgmii1_rxclk_ena_3), 
    .pcs_mac_pipeline_top_wrap_pquad1_0_mac1_cgmii_rx_rxc(pcs_mac_pipeline_top_wrap_pquad1_0_mac1_cgmii_rx_rxc), 
    .pcs_mac_pipeline_top_wrap_pquad1_1_mac1_cgmii_rx_rxc(hlp_cgmii1_rxc_3), 
    .pcs_mac_pipeline_top_wrap_pquad1_0_mac1_cgmii_rx_rxd(pcs_mac_pipeline_top_wrap_pquad1_0_mac1_cgmii_rx_rxd), 
    .pcs_mac_pipeline_top_wrap_pquad1_1_mac1_cgmii_rx_rxd(hlp_cgmii1_rxd_3), 
    .hlp_cgmii1_txc_3(hlp_cgmii1_txc_3), 
    .pcs_mac_pipeline_top_wrap_pquad1_1_pcs1_cgmii_tx_txc(pcs_mac_pipeline_top_wrap_pquad1_1_pcs1_cgmii_tx_txc), 
    .hlp_cgmii1_txd_3(hlp_cgmii1_txd_3), 
    .pcs_mac_pipeline_top_wrap_pquad1_1_pcs1_cgmii_tx_txd(pcs_mac_pipeline_top_wrap_pquad1_1_pcs1_cgmii_tx_txd), 
    .pcs_mac_pipeline_top_wrap_pquad1_0_mac2_cgmii_tx_clkena(pcs_mac_pipeline_top_wrap_pquad1_0_mac2_cgmii_tx_clkena), 
    .pcs_mac_pipeline_top_wrap_pquad1_1_mac2_cgmii_tx_clkena(hlp_cgmii2_txclk_ena_3), 
    .pcs_mac_pipeline_top_wrap_pquad1_0_mac2_cgmii_rx_clkena(pcs_mac_pipeline_top_wrap_pquad1_0_mac2_cgmii_rx_clkena), 
    .pcs_mac_pipeline_top_wrap_pquad1_1_mac2_cgmii_rx_clkena(hlp_cgmii2_rxclk_ena_3), 
    .pcs_mac_pipeline_top_wrap_pquad1_0_mac2_cgmii_rx_rxc(pcs_mac_pipeline_top_wrap_pquad1_0_mac2_cgmii_rx_rxc), 
    .pcs_mac_pipeline_top_wrap_pquad1_1_mac2_cgmii_rx_rxc(hlp_cgmii2_rxc_3), 
    .pcs_mac_pipeline_top_wrap_pquad1_0_mac2_cgmii_rx_rxd(pcs_mac_pipeline_top_wrap_pquad1_0_mac2_cgmii_rx_rxd), 
    .pcs_mac_pipeline_top_wrap_pquad1_1_mac2_cgmii_rx_rxd(hlp_cgmii2_rxd_3), 
    .hlp_cgmii2_txc_3(hlp_cgmii2_txc_3), 
    .pcs_mac_pipeline_top_wrap_pquad1_1_pcs2_cgmii_tx_txc(pcs_mac_pipeline_top_wrap_pquad1_1_pcs2_cgmii_tx_txc), 
    .hlp_cgmii2_txd_3(hlp_cgmii2_txd_3), 
    .pcs_mac_pipeline_top_wrap_pquad1_1_pcs2_cgmii_tx_txd(pcs_mac_pipeline_top_wrap_pquad1_1_pcs2_cgmii_tx_txd), 
    .pcs_mac_pipeline_top_wrap_pquad1_0_mac3_cgmii_tx_clkena(pcs_mac_pipeline_top_wrap_pquad1_0_mac3_cgmii_tx_clkena), 
    .pcs_mac_pipeline_top_wrap_pquad1_1_mac3_cgmii_tx_clkena(hlp_cgmii3_txclk_ena_3), 
    .pcs_mac_pipeline_top_wrap_pquad1_0_mac3_cgmii_rx_clkena(pcs_mac_pipeline_top_wrap_pquad1_0_mac3_cgmii_rx_clkena), 
    .pcs_mac_pipeline_top_wrap_pquad1_1_mac3_cgmii_rx_clkena(hlp_cgmii3_rxclk_ena_3), 
    .pcs_mac_pipeline_top_wrap_pquad1_0_mac3_cgmii_rx_rxc(pcs_mac_pipeline_top_wrap_pquad1_0_mac3_cgmii_rx_rxc), 
    .pcs_mac_pipeline_top_wrap_pquad1_1_mac3_cgmii_rx_rxc(hlp_cgmii3_rxc_3), 
    .pcs_mac_pipeline_top_wrap_pquad1_0_mac3_cgmii_rx_rxd(pcs_mac_pipeline_top_wrap_pquad1_0_mac3_cgmii_rx_rxd), 
    .pcs_mac_pipeline_top_wrap_pquad1_1_mac3_cgmii_rx_rxd(hlp_cgmii3_rxd_3), 
    .hlp_cgmii3_txc_3(hlp_cgmii3_txc_3), 
    .pcs_mac_pipeline_top_wrap_pquad1_1_pcs3_cgmii_tx_txc(pcs_mac_pipeline_top_wrap_pquad1_1_pcs3_cgmii_tx_txc), 
    .hlp_cgmii3_txd_3(hlp_cgmii3_txd_3), 
    .pcs_mac_pipeline_top_wrap_pquad1_1_pcs3_cgmii_tx_txd(pcs_mac_pipeline_top_wrap_pquad1_1_pcs3_cgmii_tx_txd), 
    .quad_interrupts_0_mac400_int(mac400_0_int), 
    .quad_interrupts_1_mac400_int(mac400_1_int), 
    .physs_0_AWID(physs_0_AWID), 
    .physs_0_AWADDR(physs_0_AWADDR[22:0]), 
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
    .physs_0_ARADDR(physs_0_ARADDR[22:0]), 
    .physs_0_ARLEN(physs_0_ARLEN), 
    .physs_0_ARSIZE(physs_0_ARSIZE), 
    .physs_0_ARBURST(physs_0_ARBURST), 
    .physs_0_ARLOCK(physs_0_ARLOCK), 
    .physs_0_ARCACHE(physs_0_ARCACHE), 
    .physs_0_ARPROT(physs_0_ARPROT), 
    .physs_0_ARVALID(physs_0_ARVALID), 
    .nic400_physs_0_awready_slave_physs(physs_0_AWREADY), 
    .nic400_physs_0_wready_slave_physs(physs_0_WREADY), 
    .physs_0_RREADY(physs_0_RREADY), 
    .nic400_physs_0_bid_slave_physs(physs_0_BID), 
    .nic400_physs_0_bresp_slave_physs(physs_0_BRESP), 
    .nic400_physs_0_bvalid_slave_physs(physs_0_BVALID), 
    .nic400_physs_0_arready_slave_physs(physs_0_ARREADY), 
    .nic400_physs_0_rid_slave_physs(physs_0_RID), 
    .nic400_physs_0_rdata_slave_physs(physs_0_RDATA), 
    .nic400_physs_0_rresp_slave_physs(physs_0_RRESP), 
    .nic400_physs_0_rlast_slave_physs(physs_0_RLAST), 
    .nic400_physs_0_rvalid_slave_physs(physs_0_RVALID), 
    .mdio_in(mdio_in), 
    .mac100_0_mdc(mdc), 
    .mac100_0_mdio_out(mdio_out), 
    .mac100_0_mdio_oen_0(mdio_oen), 
    .ioa_ck_pma0_ref_left_mquad1_physs0(physs0_ioa_ck_pma0_ref_left_mquad1_physs0), 
    .ioa_ck_pma3_ref_right_mquad0_physs0(physs0_ioa_ck_pma0_ref_left_mquad1_physs0), 
    .socviewpin_4to1digimux_0_outmux(physs_clkobs_out_clk[0]), 
    .physs_timesync_sync_val(physs_timesync_sync_val), 
    .quad_interrupts_0_mac100_int(mac100_0_int), 
    .quad_interrupts_1_mac100_int(mac100_1_int), 
    .interrupts_counter_level_imc_ts_int_out_signal_sync(physs_0_ts_int), 
    .quad_interrupts_0_ts_int_o(physs_ts_int[3:0]), 
    .quad_interrupts_1_ts_int_o(physs_ts_int[7:4]), 
    .parmisc_physs0_BSCAN_PIPE_OUT_TO_parmisc_physs1_scan_in(parmisc_physs0_BSCAN_PIPE_OUT_TO_parmisc_physs1_scan_in), 
    .parmisc_physs1_BSCAN_PIPE_OUT_scan_out(parmisc_physs1_BSCAN_PIPE_OUT_scan_out), 
    .parmisc_physs0_BSCAN_PIPE_IN_FROM_parmisc_physs1_scan_final_out(BSCAN_PIPE_OUT_1_scan_out), 
    .parmisc_physs0_BSCAN_PIPE_OUT_TO_parmisc_physs1_force_disable(parmisc_physs0_BSCAN_PIPE_OUT_TO_parmisc_physs1_force_disable), 
    .parmisc_physs0_BSCAN_PIPE_OUT_TO_parmisc_physs1_select_jtag_input(parmisc_physs0_BSCAN_PIPE_OUT_TO_parmisc_physs1_select_jtag_input), 
    .parmisc_physs0_BSCAN_PIPE_OUT_TO_parmisc_physs1_select_jtag_output(parmisc_physs0_BSCAN_PIPE_OUT_TO_parmisc_physs1_select_jtag_output), 
    .parmisc_physs0_BSCAN_PIPE_OUT_TO_parmisc_physs1_ac_init_clock0(parmisc_physs0_BSCAN_PIPE_OUT_TO_parmisc_physs1_ac_init_clock0), 
    .parmisc_physs0_BSCAN_PIPE_OUT_TO_parmisc_physs1_ac_init_clock1(parmisc_physs0_BSCAN_PIPE_OUT_TO_parmisc_physs1_ac_init_clock1), 
    .parmisc_physs0_BSCAN_PIPE_OUT_TO_parmisc_physs1_ac_signal(parmisc_physs0_BSCAN_PIPE_OUT_TO_parmisc_physs1_ac_signal), 
    .parmisc_physs0_BSCAN_PIPE_OUT_TO_parmisc_physs1_ac_mode_en(parmisc_physs0_BSCAN_PIPE_OUT_TO_parmisc_physs1_ac_mode_en), 
    .parmisc_physs0_BSCAN_PIPE_OUT_TO_parmisc_physs1_intel_update_clk(parmisc_physs0_BSCAN_PIPE_OUT_TO_parmisc_physs1_intel_update_clk), 
    .parmisc_physs0_BSCAN_PIPE_OUT_TO_parmisc_physs1_intel_clamp_en(parmisc_physs0_BSCAN_PIPE_OUT_TO_parmisc_physs1_intel_clamp_en), 
    .parmisc_physs0_BSCAN_PIPE_OUT_TO_parmisc_physs1_intel_bscan_mode(parmisc_physs0_BSCAN_PIPE_OUT_TO_parmisc_physs1_intel_bscan_mode), 
    .parmisc_physs0_BSCAN_PIPE_OUT_TO_parmisc_physs1_select(parmisc_physs0_BSCAN_PIPE_OUT_TO_parmisc_physs1_select), 
    .parmisc_physs0_BSCAN_PIPE_OUT_TO_parmisc_physs1_bscan_clock(parmisc_physs0_BSCAN_PIPE_OUT_TO_parmisc_physs1_bscan_clock), 
    .parmisc_physs0_BSCAN_PIPE_OUT_TO_parmisc_physs1_capture_en(parmisc_physs0_BSCAN_PIPE_OUT_TO_parmisc_physs1_capture_en), 
    .parmisc_physs0_BSCAN_PIPE_OUT_TO_parmisc_physs1_shift_en(parmisc_physs0_BSCAN_PIPE_OUT_TO_parmisc_physs1_shift_en), 
    .parmisc_physs0_BSCAN_PIPE_OUT_TO_parmisc_physs1_update_en(parmisc_physs0_BSCAN_PIPE_OUT_TO_parmisc_physs1_update_en), 
    .PHYSS_BSCAN_BYPASS(PHYSS_BSCAN_BYPASS[8]), 
    .PHYSS_BSCAN_BYPASS_0(PHYSS_BSCAN_BYPASS[9]), 
    .PHYSS_BSCAN_BYPASS_1(PHYSS_BSCAN_BYPASS[10]), 
    .PHYSS_BSCAN_BYPASS_2(PHYSS_BSCAN_BYPASS[11]), 
    .PHYSS_BSCAN_BYPASS_3(PHYSS_BSCAN_BYPASS[12]), 
    .PHYSS_BSCAN_BYPASS_4(PHYSS_BSCAN_BYPASS[13]), 
    .PHYSS_BSCAN_BYPASS_5(PHYSS_BSCAN_BYPASS[14]), 
    .PHYSS_BSCAN_BYPASS_6(PHYSS_BSCAN_BYPASS[15]), 
    .PHYSS_BSCAN_BYPASS_7(PHYSS_BSCAN_BYPASS[16]), 
    .PHYSS_BSCAN_BYPASS_8(PHYSS_BSCAN_BYPASS[17]), 
    .BSCAN_PIPE_IN_1_bscan_clock(BSCAN_PIPE_IN_1_bscan_clock), 
    .BSCAN_PIPE_IN_1_select(BSCAN_PIPE_IN_1_select), 
    .BSCAN_PIPE_IN_1_capture_en(BSCAN_PIPE_IN_1_capture_en), 
    .BSCAN_PIPE_IN_1_shift_en(BSCAN_PIPE_IN_1_shift_en), 
    .BSCAN_PIPE_IN_1_update_en(BSCAN_PIPE_IN_1_update_en), 
    .BSCAN_PIPE_IN_1_scan_in(BSCAN_PIPE_IN_1_scan_in), 
    .BSCAN_PIPE_IN_1_ac_signal(BSCAN_PIPE_IN_1_ac_signal), 
    .BSCAN_PIPE_IN_1_ac_init_clock0(BSCAN_PIPE_IN_1_ac_init_clock0), 
    .BSCAN_PIPE_IN_1_ac_init_clock1(BSCAN_PIPE_IN_1_ac_init_clock1), 
    .BSCAN_PIPE_IN_1_ac_mode_en(BSCAN_PIPE_IN_1_ac_mode_en), 
    .BSCAN_PIPE_IN_1_force_disable(BSCAN_PIPE_IN_1_force_disable), 
    .BSCAN_PIPE_IN_1_select_jtag_input(BSCAN_PIPE_IN_1_select_jtag_input), 
    .BSCAN_PIPE_IN_1_select_jtag_output(BSCAN_PIPE_IN_1_select_jtag_output), 
    .BSCAN_PIPE_IN_1_intel_update_clk(BSCAN_PIPE_IN_1_intel_update_clk), 
    .BSCAN_PIPE_IN_1_intel_clamp_en(BSCAN_PIPE_IN_1_intel_clamp_en), 
    .BSCAN_PIPE_IN_1_intel_bscan_mode(BSCAN_PIPE_IN_1_intel_bscan_mode), 
    .BSCAN_PIPE_IN_1_intel_d6actestsig_b(BSCAN_PIPE_IN_1_intel_d6actestsig_b), 
    .parmisc_physs1_BSCAN_PIPE_OUT_2_bscan_to_intel_d6actestsig_b(parmisc_physs1_BSCAN_PIPE_OUT_2_bscan_to_intel_d6actestsig_b), 
    .parmisc_physs0_BSCAN_PIPE_OUT_2_bscan_to_intel_d6actestsig_b(parmisc_physs0_BSCAN_PIPE_OUT_2_bscan_to_intel_d6actestsig_b), 
    .SSN_START_entry_from_nac_bus_data_in(ssn_bus_data_in), 
    .SSN_END_exit_to_nac_bus_data_out(ssn_bus_data_out), 
    .SSN_START_from_parmisc_physs1_bus_data_in(physs1_SSN_END_chain_towards_parmisc_physs0_bus_data_out), 
    .SSN_END_towards_parmisc_physs1_bus_data_out(physs0_SSN_END_towards_parmisc_physs1_bus_data_out), 
    .trst_b(trst_b), 
    .tck(tck), 
    .tms(tms), 
    .tdi(tdi), 
    .parmisc_physs0_NW_IN_tdo_en(tdo_en), 
    .parmisc_physs0_NW_IN_tdo(tdo), 
    .ijtag_reset_b(ijtag_reset_b), 
    .ijtag_shift(ijtag_shift), 
    .ijtag_capture(ijtag_capture), 
    .ijtag_update(ijtag_update), 
    .ijtag_select(ijtag_select), 
    .ijtag_si(ijtag_si), 
    .parmisc_physs0_NW_IN_ijtag_so(ijtag_so), 
    .shift_ir_dr(shift_ir_dr), 
    .tms_park_value(tms_park_value), 
    .nw_mode(nw_mode), 
    .parmisc_physs0_NW_IN_tap_sel_out(tap_sel_in), 
    .parmisc_physs1_NW_IN_tdo(parmisc_physs1_NW_IN_tdo), 
    .parmisc_physs1_NW_IN_tdo_en(parmisc_physs1_NW_IN_tdo_en), 
    .parmisc_physs0_NW_OUT_parmisc_physs1_ijtag_to_reset(parmisc_physs0_NW_OUT_parmisc_physs1_ijtag_to_reset), 
    .parmisc_physs0_NW_OUT_parmisc_physs1_ijtag_to_ce(parmisc_physs0_NW_OUT_parmisc_physs1_ijtag_to_ce), 
    .parmisc_physs0_NW_OUT_parmisc_physs1_ijtag_to_se(parmisc_physs0_NW_OUT_parmisc_physs1_ijtag_to_se), 
    .parmisc_physs0_NW_OUT_parmisc_physs1_ijtag_to_ue(parmisc_physs0_NW_OUT_parmisc_physs1_ijtag_to_ue), 
    .parmisc_physs0_NW_OUT_parmisc_physs1_ijtag_to_sel(parmisc_physs0_NW_OUT_parmisc_physs1_ijtag_to_sel), 
    .parmisc_physs0_NW_OUT_parmisc_physs1_ijtag_to_si(parmisc_physs0_NW_OUT_parmisc_physs1_ijtag_to_si), 
    .parmisc_physs1_NW_IN_ijtag_so(parmisc_physs1_NW_IN_ijtag_so), 
    .parmisc_physs1_NW_IN_tap_sel_out(parmisc_physs1_NW_IN_tap_sel_out), 
    .SSN_START_entry_from_nac_bus_clock_in(ssn_bus_clock_in), 
    .SSN_END_entry_from_nac_bus_data_out(), 
    .ioa_ck_pma0_ref_left_mquad0_physs0()
) ; 
physs1 physs1 (
    .mbp_repeater_odi_parmisc_physs0_5_ubp_out(mbp_repeater_odi_parmisc_physs0_5_ubp_out), 
    .mbp_repeater_sfe_parmisc_physs0_2_ubp_out(mbp_repeater_sfe_parmisc_physs0_2_ubp_out), 
    .dfxagg_security_policy(dfxagg_security_policy), 
    .dfxagg_policy_update(dfxagg_policy_update), 
    .dfxagg_early_boot_debug_exit(dfxagg_early_boot_debug_exit), 
    .dfxagg_debug_capabilities_enabling(dfxagg_debug_capabilities_enabling), 
    .dfxagg_debug_capabilities_enabling_valid(dfxagg_debug_capabilities_enabling_valid), 
    .fdfx_powergood(fdfx_powergood), 
    .ETH_RXN8(ETH_RXN8), 
    .ETH_RXP8(ETH_RXP8), 
    .ETH_RXN9(ETH_RXN9), 
    .ETH_RXP9(ETH_RXP9), 
    .ETH_RXN10(ETH_RXN10), 
    .ETH_RXP10(ETH_RXP10), 
    .ETH_RXN11(ETH_RXN11), 
    .ETH_RXP11(ETH_RXP11), 
    .versa_xmp_2_xoa_pma0_tx_n_l0(ETH_TXN8), 
    .versa_xmp_2_xoa_pma0_tx_p_l0(ETH_TXP8), 
    .versa_xmp_2_xoa_pma1_tx_n_l0(ETH_TXN9), 
    .versa_xmp_2_xoa_pma1_tx_p_l0(ETH_TXP9), 
    .versa_xmp_2_xoa_pma2_tx_n_l0(ETH_TXN10), 
    .versa_xmp_2_xoa_pma2_tx_p_l0(ETH_TXP10), 
    .versa_xmp_2_xoa_pma3_tx_n_l0(ETH_TXN11), 
    .versa_xmp_2_xoa_pma3_tx_p_l0(ETH_TXP11), 
    .ETH_RXN12(ETH_RXN12), 
    .ETH_RXP12(ETH_RXP12), 
    .ETH_RXN13(ETH_RXN13), 
    .ETH_RXP13(ETH_RXP13), 
    .ETH_RXN14(ETH_RXN14), 
    .ETH_RXP14(ETH_RXP14), 
    .ETH_RXN15(ETH_RXN15), 
    .ETH_RXP15(ETH_RXP15), 
    .versa_xmp_3_xoa_pma0_tx_n_l0(ETH_TXN12), 
    .versa_xmp_3_xoa_pma0_tx_p_l0(ETH_TXP12), 
    .versa_xmp_3_xoa_pma1_tx_n_l0(ETH_TXN13), 
    .versa_xmp_3_xoa_pma1_tx_p_l0(ETH_TXP13), 
    .versa_xmp_3_xoa_pma2_tx_n_l0(ETH_TXN14), 
    .versa_xmp_3_xoa_pma2_tx_p_l0(ETH_TXP14), 
    .versa_xmp_3_xoa_pma3_tx_n_l0(ETH_TXN15), 
    .versa_xmp_3_xoa_pma3_tx_p_l0(ETH_TXP15), 
    .ioa_pma_remote_diode_i_anode(ioa_pma_remote_diode_i_anode[8]), 
    .ioa_pma_remote_diode_i_anode_0(ioa_pma_remote_diode_i_anode[9]), 
    .ioa_pma_remote_diode_i_anode_1(ioa_pma_remote_diode_i_anode[10]), 
    .ioa_pma_remote_diode_i_anode_2(ioa_pma_remote_diode_i_anode[11]), 
    .ioa_pma_remote_diode_i_anode_3(ioa_pma_remote_diode_i_anode[12]), 
    .ioa_pma_remote_diode_i_anode_4(ioa_pma_remote_diode_i_anode[13]), 
    .ioa_pma_remote_diode_i_anode_5(ioa_pma_remote_diode_i_anode[14]), 
    .ioa_pma_remote_diode_i_anode_6(ioa_pma_remote_diode_i_anode[15]), 
    .ioa_pma_remote_diode_v_anode(ioa_pma_remote_diode_v_anode[8]), 
    .ioa_pma_remote_diode_v_anode_0(ioa_pma_remote_diode_v_anode[9]), 
    .ioa_pma_remote_diode_v_anode_1(ioa_pma_remote_diode_v_anode[10]), 
    .ioa_pma_remote_diode_v_anode_2(ioa_pma_remote_diode_v_anode[11]), 
    .ioa_pma_remote_diode_v_anode_3(ioa_pma_remote_diode_v_anode[12]), 
    .ioa_pma_remote_diode_v_anode_4(ioa_pma_remote_diode_v_anode[13]), 
    .ioa_pma_remote_diode_v_anode_5(ioa_pma_remote_diode_v_anode[14]), 
    .ioa_pma_remote_diode_v_anode_6(ioa_pma_remote_diode_v_anode[15]), 
    .ioa_pma_remote_diode_i_cathode(ioa_pma_remote_diode_i_cathode[8]), 
    .ioa_pma_remote_diode_i_cathode_0(ioa_pma_remote_diode_i_cathode[9]), 
    .ioa_pma_remote_diode_i_cathode_1(ioa_pma_remote_diode_i_cathode[10]), 
    .ioa_pma_remote_diode_i_cathode_2(ioa_pma_remote_diode_i_cathode[11]), 
    .ioa_pma_remote_diode_i_cathode_3(ioa_pma_remote_diode_i_cathode[12]), 
    .ioa_pma_remote_diode_i_cathode_4(ioa_pma_remote_diode_i_cathode[13]), 
    .ioa_pma_remote_diode_i_cathode_5(ioa_pma_remote_diode_i_cathode[14]), 
    .ioa_pma_remote_diode_i_cathode_6(ioa_pma_remote_diode_i_cathode[15]), 
    .ioa_pma_remote_diode_v_cathode(ioa_pma_remote_diode_v_cathode[8]), 
    .ioa_pma_remote_diode_v_cathode_0(ioa_pma_remote_diode_v_cathode[9]), 
    .ioa_pma_remote_diode_v_cathode_1(ioa_pma_remote_diode_v_cathode[10]), 
    .ioa_pma_remote_diode_v_cathode_2(ioa_pma_remote_diode_v_cathode[11]), 
    .ioa_pma_remote_diode_v_cathode_3(ioa_pma_remote_diode_v_cathode[12]), 
    .ioa_pma_remote_diode_v_cathode_4(ioa_pma_remote_diode_v_cathode[13]), 
    .ioa_pma_remote_diode_v_cathode_5(ioa_pma_remote_diode_v_cathode[14]), 
    .ioa_pma_remote_diode_v_cathode_6(ioa_pma_remote_diode_v_cathode[15]), 
    .quadpcs100_2_pcs_link_status(quadpcs100_2_pcs_link_status), 
    .quadpcs100_3_pcs_link_status(quadpcs100_3_pcs_link_status), 
    .physs_hd2prf_trim_fuse_in(physs_hd2prf_trim_fuse_in), 
    .physs_hs2prf_trim_fuse_in(physs_hs2prf_trim_fuse_in), 
    .physs_rfhs_trim_fuse_in(physs_rfhs_trim_fuse_in), 
    .physs_hdspsr_trim_fuse_in(physs_hdspsr_trim_fuse_in), 
    .physs_bbl_100G_2_disable(physs_bbl_100G_2_disable), 
    .physs_bbl_serdes_2_disable(physs_bbl_serdes_2_disable), 
    .physs_bbl_100G_3_disable(physs_bbl_100G_3_disable), 
    .physs_bbl_serdes_3_disable(physs_bbl_serdes_3_disable), 
    .physs_bbl_spare_2(physs_bbl_spare_2), 
    .physs_bbl_spare_3(physs_bbl_spare_3), 
    .physs_bbl_100G_0_disable(physs_bbl_100G_0_disable), 
    .physs_bbl_100G_1_disable(physs_bbl_100G_1_disable), 
    .ethphyss_post_clkungate(ethphyss_post_clkungate), 
    .soc_per_clk_adop_parmisc_physs0_clkout_0(soc_per_clk_adop_parmisc_physs0_clkout_0), 
    .physs_func_clk_adop_parmisc_physs0_clkout(physs_func_clk_adop_parmisc_physs0_clkout), 
    .o_ck_pma0_rx_postdiv_l0_adop_parpquad0_clkout(o_ck_pma0_rx_postdiv_l0_adop_parpquad0_clkout), 
    .o_ck_pma1_rx_postdiv_l0_adop_parpquad0_clkout(o_ck_pma1_rx_postdiv_l0_adop_parpquad0_clkout), 
    .o_ck_pma2_rx_postdiv_l0_adop_parpquad0_clkout(o_ck_pma2_rx_postdiv_l0_adop_parpquad0_clkout), 
    .o_ck_pma3_rx_postdiv_l0_adop_parpquad0_clkout(o_ck_pma3_rx_postdiv_l0_adop_parpquad0_clkout), 
    .o_ck_pma0_rx_postdiv_l0_adop_parpquad1_clkout(o_ck_pma0_rx_postdiv_l0_adop_parpquad1_clkout), 
    .o_ck_pma1_rx_postdiv_l0_adop_parpquad1_clkout(o_ck_pma1_rx_postdiv_l0_adop_parpquad1_clkout), 
    .o_ck_pma2_rx_postdiv_l0_adop_parpquad1_clkout(o_ck_pma2_rx_postdiv_l0_adop_parpquad1_clkout), 
    .o_ck_pma3_rx_postdiv_l0_adop_parpquad1_clkout(o_ck_pma3_rx_postdiv_l0_adop_parpquad1_clkout), 
    .fscan_txrxword_byp_clk(fscan_txrxword_byp_clk), 
    .o_ck_pma0_cmnplla_postdiv_clk_mux_parmquad0_clkout(o_ck_pma0_cmnplla_postdiv_clk_mux_parmquad0_clkout), 
    .fscan_ref_clk_adop_parmisc_physs0_clkout_0(fscan_ref_clk_adop_parmisc_physs0_clkout_0), 
    .uart_clk_adop_parmisc_physs0_clkout_0(uart_clk_adop_parmisc_physs0_clkout_0), 
    .physs_registers_wrapper_0_reset_ref_clk_override(physs_registers_wrapper_0_reset_ref_clk_override), 
    .physs_registers_wrapper_0_reset_pcs100_override_en(physs_registers_wrapper_0_reset_pcs100_override_en), 
    .physs_registers_wrapper_0_clk_gate_en_100G_mac_pcs(physs_registers_wrapper_0_clk_gate_en_100G_mac_pcs), 
    .physs_registers_wrapper_0_power_fsm_clk_gate_en(physs_registers_wrapper_0_power_fsm_clk_gate_en), 
    .physs_registers_wrapper_0_power_fsm_reset_gate_en(physs_registers_wrapper_0_power_fsm_reset_gate_en), 
    .physs_registers_wrapper_1_reset_ref_clk_override(physs_registers_wrapper_1_reset_ref_clk_override), 
    .physs_registers_wrapper_1_reset_pcs100_override_en(physs_registers_wrapper_1_reset_pcs100_override_en), 
    .physs_registers_wrapper_1_clk_gate_en_100G_mac_pcs(physs_registers_wrapper_1_clk_gate_en_100G_mac_pcs), 
    .physs_registers_wrapper_1_power_fsm_clk_gate_en(physs_registers_wrapper_1_power_fsm_clk_gate_en), 
    .physs_registers_wrapper_1_power_fsm_reset_gate_en(physs_registers_wrapper_1_power_fsm_reset_gate_en), 
    .physs_registers_wrapper_0_clk_gate_en_800G_mac_pcs(physs_registers_wrapper_0_clk_gate_en_800G_mac_pcs), 
    .ioa_ck_pma0_ref_left_pquad1_physs1(physs1_ioa_ck_pma0_ref_left_pquad1_physs1), 
    .ioa_ck_pma3_ref_right_pquad0_physs1(physs1_ioa_ck_pma0_ref_left_pquad1_physs1), 
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
    .pd_vinf_5_bisr_clk(pd_vinf_5_bisr_clk), 
    .pd_vinf_5_bisr_reset(pd_vinf_5_bisr_reset), 
    .pd_vinf_5_bisr_shift_en(pd_vinf_5_bisr_shift_en), 
    .parmisc_physs0_pd_vinf_5_bisr_so(parmisc_physs0_pd_vinf_5_bisr_so), 
    .parmisc_physs1_pd_vinf_5_2_bisr_so(parmisc_physs1_pd_vinf_5_2_bisr_so), 
    .pd_vinf_6_bisr_clk(pd_vinf_6_bisr_clk), 
    .pd_vinf_6_bisr_reset(pd_vinf_6_bisr_reset), 
    .pd_vinf_6_bisr_shift_en(pd_vinf_6_bisr_shift_en), 
    .parmisc_physs0_pd_vinf_6_bisr_so(parmisc_physs0_pd_vinf_6_bisr_so), 
    .parmisc_physs1_pd_vinf_6_2_bisr_so(parmisc_physs1_pd_vinf_6_2_bisr_so), 
    .physs1_func_rst_raw_n(physs1_func_rst_raw_n), 
    .ethphyss_post_clk_mux_ctrl(ethphyss_post_clk_mux_ctrl), 
    .parpquad0_DIAG_AGGR_pquad_mbist_diag_done(parpquad0_DIAG_AGGR_pquad_mbist_diag_done), 
    .parpquad1_DIAG_AGGR_pquad_mbist_diag_done(parpquad1_DIAG_AGGR_pquad_mbist_diag_done), 
    .physs_bbl_800G_0_disable(physs_bbl_800G_0_disable), 
    .physs_registers_wrapper_1_reset_sd_tx_clk_override_800G_0(physs_registers_wrapper_1_reset_sd_tx_clk_override_800G_0), 
    .physs_registers_wrapper_1_reset_sd_rx_clk_override_800G_0(physs_registers_wrapper_1_reset_sd_rx_clk_override_800G_0), 
    .versa_xmp_2_o_ucss_uart_txd(versa_xmp_2_o_ucss_uart_txd), 
    .versa_xmp_3_o_ucss_uart_txd(versa_xmp_3_o_ucss_uart_txd), 
    .physs_uart_demux_out2(physs_uart_demux_out2), 
    .physs_uart_demux_out3(physs_uart_demux_out3), 
    .versa_xmp_0_o_rst_ucss_srds_pcs_rx_reset_pma0_l0_b_a_0(versa_xmp_0_o_rst_ucss_srds_pcs_rx_reset_pma0_l0_b_a_0), 
    .versa_xmp_0_o_rst_ucss_srds_pcs_rx_reset_pma1_l0_b_a_0(versa_xmp_0_o_rst_ucss_srds_pcs_rx_reset_pma1_l0_b_a_0), 
    .versa_xmp_0_o_rst_ucss_srds_pcs_rx_reset_pma2_l0_b_a_0(versa_xmp_0_o_rst_ucss_srds_pcs_rx_reset_pma2_l0_b_a_0), 
    .versa_xmp_0_o_rst_ucss_srds_pcs_rx_reset_pma3_l0_b_a_0(versa_xmp_0_o_rst_ucss_srds_pcs_rx_reset_pma3_l0_b_a_0), 
    .versa_xmp_1_o_rst_ucss_srds_pcs_rx_reset_pma0_l0_b_a_0(versa_xmp_1_o_rst_ucss_srds_pcs_rx_reset_pma0_l0_b_a_0), 
    .versa_xmp_1_o_rst_ucss_srds_pcs_rx_reset_pma1_l0_b_a_0(versa_xmp_1_o_rst_ucss_srds_pcs_rx_reset_pma1_l0_b_a_0), 
    .versa_xmp_1_o_rst_ucss_srds_pcs_rx_reset_pma2_l0_b_a_0(versa_xmp_1_o_rst_ucss_srds_pcs_rx_reset_pma2_l0_b_a_0), 
    .versa_xmp_1_o_rst_ucss_srds_pcs_rx_reset_pma3_l0_b_a_0(versa_xmp_1_o_rst_ucss_srds_pcs_rx_reset_pma3_l0_b_a_0), 
    .fary_post_force_fail(fary_post_force_fail), 
    .fary_4_trigger_post(fary_4_trigger_post), 
    .fary_post_algo_select(fary_post_algo_select), 
    .xmp_mem_wrapper_2_aary_post_pass(xmp_mem_wrapper_2_aary_post_pass), 
    .xmp_mem_wrapper_2_aary_post_complete(xmp_mem_wrapper_2_aary_post_complete), 
    .xmp_mem_wrapper_3_aary_post_pass(xmp_mem_wrapper_3_aary_post_pass), 
    .xmp_mem_wrapper_3_aary_post_complete(xmp_mem_wrapper_3_aary_post_complete), 
    .fary_5_trigger_post(fary_5_trigger_post), 
    .pcs100_mem_wrapper_2_aary_post_pass(pcs100_mem_wrapper_2_aary_post_pass), 
    .pcs100_mem_wrapper_2_aary_post_complete(pcs100_mem_wrapper_2_aary_post_complete), 
    .pcs100_mem_wrapper_3_aary_post_pass(pcs100_mem_wrapper_3_aary_post_pass), 
    .pcs100_mem_wrapper_3_aary_post_complete(pcs100_mem_wrapper_3_aary_post_complete), 
    .parmisc_physs1_dfx_ubp_ctrl_trig_in_to_parmisc_physs0_ubpc(parmisc_physs1_dfx_ubp_ctrl_trig_in_to_parmisc_physs0_ubpc), 
    .parmisc_physs0_trig_clock_stop_to_parpquad0_pma0_txdat(parmisc_physs0_trig_clock_stop_to_parpquad0_pma0_txdat), 
    .parmisc_physs0_trig_clock_stop_to_parpquad0_pma1_txdat(parmisc_physs0_trig_clock_stop_to_parpquad0_pma1_txdat), 
    .parmisc_physs0_trig_clock_stop_to_parpquad0_pma2_txdat(parmisc_physs0_trig_clock_stop_to_parpquad0_pma2_txdat), 
    .parmisc_physs0_trig_clock_stop_to_parpquad0_pma3_txdat(parmisc_physs0_trig_clock_stop_to_parpquad0_pma3_txdat), 
    .parmisc_physs0_trig_clock_stop_to_parpquad0_o_ck_pma0_rx(parmisc_physs0_trig_clock_stop_to_parpquad0_o_ck_pma0_rx), 
    .parmisc_physs0_trig_clock_stop_to_parpquad0_o_ck_pma1_rx(parmisc_physs0_trig_clock_stop_to_parpquad0_o_ck_pma1_rx), 
    .parmisc_physs0_trig_clock_stop_to_parpquad0_o_ck_pma2_rx(parmisc_physs0_trig_clock_stop_to_parpquad0_o_ck_pma2_rx), 
    .parmisc_physs0_trig_clock_stop_to_parpquad0_o_ck_pma3_rx(parmisc_physs0_trig_clock_stop_to_parpquad0_o_ck_pma3_rx), 
    .parmisc_physs0_trig_clock_stop_to_parpquad0_pma0_rxdat(parmisc_physs0_trig_clock_stop_to_parpquad0_pma0_rxdat), 
    .parmisc_physs0_trig_clock_stop_to_parpquad0_pma1_rxdat(parmisc_physs0_trig_clock_stop_to_parpquad0_pma1_rxdat), 
    .parmisc_physs0_trig_clock_stop_to_parpquad0_pma2_rxdat(parmisc_physs0_trig_clock_stop_to_parpquad0_pma2_rxdat), 
    .parmisc_physs0_trig_clock_stop_to_parpquad0_pma3_rxdat(parmisc_physs0_trig_clock_stop_to_parpquad0_pma3_rxdat), 
    .parmisc_physs0_trig_clock_stop_to_parpquad0_o_ck_pma0_cmnplla_postdiv(parmisc_physs0_trig_clock_stop_to_parpquad0_o_ck_pma0_cmnplla_postdiv), 
    .parmisc_physs0_trig_clock_stop_to_parpquad0_o_ck_pma1_cmnplla_postdiv(parmisc_physs0_trig_clock_stop_to_parpquad0_o_ck_pma1_cmnplla_postdiv), 
    .parmisc_physs0_trig_clock_stop_to_parpquad0_o_ck_pma2_cmnplla_postdiv(parmisc_physs0_trig_clock_stop_to_parpquad0_o_ck_pma2_cmnplla_postdiv), 
    .parmisc_physs0_trig_clock_stop_to_parpquad0_o_ck_pma3_cmnplla_postdiv(parmisc_physs0_trig_clock_stop_to_parpquad0_o_ck_pma3_cmnplla_postdiv), 
    .parmisc_physs0_trig_clock_stop_to_parpquad0_o_ck_slv_pcs1(parmisc_physs0_trig_clock_stop_to_parpquad0_o_ck_slv_pcs1), 
    .parmisc_physs0_trig_clock_stop_to_parpquad0_o_ck_ucss_mem_dram(parmisc_physs0_trig_clock_stop_to_parpquad0_o_ck_ucss_mem_dram), 
    .parmisc_physs0_trig_clock_stop_to_parpquad0_o_ck_ucss_mem_iram(parmisc_physs0_trig_clock_stop_to_parpquad0_o_ck_ucss_mem_iram), 
    .parmisc_physs0_trig_clock_stop_to_parpquad0_o_ck_ucss_mem_tracemem(parmisc_physs0_trig_clock_stop_to_parpquad0_o_ck_ucss_mem_tracemem), 
    .parmisc_physs0_trig_clock_stop_to_parpquad1_pma0_txdat(parmisc_physs0_trig_clock_stop_to_parpquad1_pma0_txdat), 
    .parmisc_physs0_trig_clock_stop_to_parpquad1_pma1_txdat(parmisc_physs0_trig_clock_stop_to_parpquad1_pma1_txdat), 
    .parmisc_physs0_trig_clock_stop_to_parpquad1_pma2_txdat(parmisc_physs0_trig_clock_stop_to_parpquad1_pma2_txdat), 
    .parmisc_physs0_trig_clock_stop_to_parpquad1_pma3_txdat(parmisc_physs0_trig_clock_stop_to_parpquad1_pma3_txdat), 
    .parmisc_physs0_trig_clock_stop_to_parpquad1_o_ck_pma0_rx(parmisc_physs0_trig_clock_stop_to_parpquad1_o_ck_pma0_rx), 
    .parmisc_physs0_trig_clock_stop_to_parpquad1_o_ck_pma1_rx(parmisc_physs0_trig_clock_stop_to_parpquad1_o_ck_pma1_rx), 
    .parmisc_physs0_trig_clock_stop_to_parpquad1_o_ck_pma2_rx(parmisc_physs0_trig_clock_stop_to_parpquad1_o_ck_pma2_rx), 
    .parmisc_physs0_trig_clock_stop_to_parpquad1_o_ck_pma3_rx(parmisc_physs0_trig_clock_stop_to_parpquad1_o_ck_pma3_rx), 
    .parmisc_physs0_trig_clock_stop_to_parpquad1_pma0_rxdat(parmisc_physs0_trig_clock_stop_to_parpquad1_pma0_rxdat), 
    .parmisc_physs0_trig_clock_stop_to_parpquad1_pma1_rxdat(parmisc_physs0_trig_clock_stop_to_parpquad1_pma1_rxdat), 
    .parmisc_physs0_trig_clock_stop_to_parpquad1_pma2_rxdat(parmisc_physs0_trig_clock_stop_to_parpquad1_pma2_rxdat), 
    .parmisc_physs0_trig_clock_stop_to_parpquad1_pma3_rxdat(parmisc_physs0_trig_clock_stop_to_parpquad1_pma3_rxdat), 
    .parmisc_physs0_trig_clock_stop_to_parpquad1_o_ck_pma0_cmnplla_postdiv(parmisc_physs0_trig_clock_stop_to_parpquad1_o_ck_pma0_cmnplla_postdiv), 
    .parmisc_physs0_trig_clock_stop_to_parpquad1_o_ck_pma1_cmnplla_postdiv(parmisc_physs0_trig_clock_stop_to_parpquad1_o_ck_pma1_cmnplla_postdiv), 
    .parmisc_physs0_trig_clock_stop_to_parpquad1_o_ck_pma2_cmnplla_postdiv(parmisc_physs0_trig_clock_stop_to_parpquad1_o_ck_pma2_cmnplla_postdiv), 
    .parmisc_physs0_trig_clock_stop_to_parpquad1_o_ck_pma3_cmnplla_postdiv(parmisc_physs0_trig_clock_stop_to_parpquad1_o_ck_pma3_cmnplla_postdiv), 
    .parmisc_physs0_trig_clock_stop_to_parpquad1_o_ck_slv_pcs1(parmisc_physs0_trig_clock_stop_to_parpquad1_o_ck_slv_pcs1), 
    .parmisc_physs0_trig_clock_stop_to_parpquad1_o_ck_ucss_mem_dram(parmisc_physs0_trig_clock_stop_to_parpquad1_o_ck_ucss_mem_dram), 
    .parmisc_physs0_trig_clock_stop_to_parpquad1_o_ck_ucss_mem_iram(parmisc_physs0_trig_clock_stop_to_parpquad1_o_ck_ucss_mem_iram), 
    .parmisc_physs0_trig_clock_stop_to_parpquad1_o_ck_ucss_mem_tracemem(parmisc_physs0_trig_clock_stop_to_parpquad1_o_ck_ucss_mem_tracemem), 
    .ioa_ck_pma0_ref_left_pquad0_physs1(physs1_ioa_ck_pma0_ref_left_pquad0_physs1), 
    .quadpcs100_2_pcs_desk_buf_rlevel(pcs_desk_buf_rlevel[83:56]), 
    .quadpcs100_2_pcs_sd_bit_slip(pcs_sd_bit_slip[95:64]), 
    .quadpcs100_2_pcs_link_status_tsu(pcs_link_status_tsu[11:8]), 
    .quadpcs100_3_pcs_desk_buf_rlevel(pcs_desk_buf_rlevel[111:84]), 
    .quadpcs100_3_pcs_sd_bit_slip(pcs_sd_bit_slip[127:96]), 
    .quadpcs100_3_pcs_link_status_tsu(pcs_link_status_tsu[15:12]), 
    .versa_xmp_2_xioa_ck_pma0_ref0_n(xioa_ck_pma_ref0_n[8]), 
    .versa_xmp_2_xioa_ck_pma0_ref0_p(xioa_ck_pma_ref0_p[8]), 
    .versa_xmp_2_xioa_ck_pma0_ref1_n(xioa_ck_pma_ref1_n[6]), 
    .versa_xmp_2_xioa_ck_pma0_ref1_p(xioa_ck_pma_ref1_p[6]), 
    .versa_xmp_2_xioa_ck_pma1_ref0_n(xioa_ck_pma_ref0_n[9]), 
    .versa_xmp_2_xioa_ck_pma1_ref0_p(xioa_ck_pma_ref0_p[9]), 
    .versa_xmp_2_xioa_ck_pma1_ref1_n(xioa_ck_pma_ref1_n[7]), 
    .versa_xmp_2_xioa_ck_pma1_ref1_p(xioa_ck_pma_ref1_p[7]), 
    .versa_xmp_2_xioa_ck_pma2_ref0_n(xioa_ck_pma_ref0_n[10]), 
    .versa_xmp_2_xioa_ck_pma2_ref0_p(xioa_ck_pma_ref0_p[10]), 
    .versa_xmp_2_xioa_ck_pma2_ref1_n(xioa_ck_pma_ref1_n[8]), 
    .versa_xmp_2_xioa_ck_pma2_ref1_p(xioa_ck_pma_ref1_p[8]), 
    .versa_xmp_2_xioa_ck_pma3_ref0_n(xioa_ck_pma_ref0_n[11]), 
    .versa_xmp_2_xioa_ck_pma3_ref0_p(xioa_ck_pma_ref0_p[11]), 
    .versa_xmp_2_xioa_ck_pma3_ref1_n(xioa_ck_pma_ref1_n[9]), 
    .versa_xmp_2_xioa_ck_pma3_ref1_p(xioa_ck_pma_ref1_p[9]), 
    .versa_xmp_2_xoa_pma0_dcmon1(xoa_pma_dcmon1[8]), 
    .versa_xmp_2_xoa_pma0_dcmon2(xoa_pma_dcmon2[8]), 
    .versa_xmp_2_xoa_pma1_dcmon1(xoa_pma_dcmon1[9]), 
    .versa_xmp_2_xoa_pma1_dcmon2(xoa_pma_dcmon2[9]), 
    .versa_xmp_2_xoa_pma2_dcmon1(xoa_pma_dcmon1[10]), 
    .versa_xmp_2_xoa_pma2_dcmon2(xoa_pma_dcmon2[10]), 
    .versa_xmp_2_xoa_pma3_dcmon1(xoa_pma_dcmon1[11]), 
    .versa_xmp_2_xoa_pma3_dcmon2(xoa_pma_dcmon2[11]), 
    .versa_xmp_3_xioa_ck_pma0_ref0_n(xioa_ck_pma_ref0_n[12]), 
    .versa_xmp_3_xioa_ck_pma0_ref0_p(xioa_ck_pma_ref0_p[12]), 
    .versa_xmp_3_xioa_ck_pma0_ref1_n(xioa_ck_pma_ref1_n[10]), 
    .versa_xmp_3_xioa_ck_pma0_ref1_p(xioa_ck_pma_ref1_p[10]), 
    .versa_xmp_3_xioa_ck_pma1_ref0_n(xioa_ck_pma_ref0_n[13]), 
    .versa_xmp_3_xioa_ck_pma1_ref0_p(xioa_ck_pma_ref0_p[13]), 
    .versa_xmp_3_xioa_ck_pma1_ref1_n(xioa_ck_pma_ref1_n[11]), 
    .versa_xmp_3_xioa_ck_pma1_ref1_p(xioa_ck_pma_ref1_p[11]), 
    .versa_xmp_3_xioa_ck_pma2_ref0_n(xioa_ck_pma_ref0_n[14]), 
    .versa_xmp_3_xioa_ck_pma2_ref0_p(xioa_ck_pma_ref0_p[14]), 
    .versa_xmp_3_xioa_ck_pma2_ref1_n(xioa_ck_pma_ref1_n[12]), 
    .versa_xmp_3_xioa_ck_pma2_ref1_p(xioa_ck_pma_ref1_p[12]), 
    .versa_xmp_3_xioa_ck_pma3_ref0_n(xioa_ck_pma_ref0_n[15]), 
    .versa_xmp_3_xioa_ck_pma3_ref0_p(xioa_ck_pma_ref0_p[15]), 
    .versa_xmp_3_xioa_ck_pma3_ref1_n(xioa_ck_pma_ref1_n[13]), 
    .versa_xmp_3_xioa_ck_pma3_ref1_p(xioa_ck_pma_ref1_p[13]), 
    .versa_xmp_3_xoa_pma0_dcmon1(xoa_pma_dcmon1[12]), 
    .versa_xmp_3_xoa_pma0_dcmon2(xoa_pma_dcmon2[12]), 
    .versa_xmp_3_xoa_pma1_dcmon1(xoa_pma_dcmon1[13]), 
    .versa_xmp_3_xoa_pma1_dcmon2(xoa_pma_dcmon2[13]), 
    .versa_xmp_3_xoa_pma2_dcmon1(xoa_pma_dcmon1[14]), 
    .versa_xmp_3_xoa_pma2_dcmon2(xoa_pma_dcmon2[14]), 
    .versa_xmp_3_xoa_pma3_dcmon1(xoa_pma_dcmon1[15]), 
    .versa_xmp_3_xoa_pma3_dcmon2(xoa_pma_dcmon2[15]), 
    .interrupts_counter_level_fatal_int_1_out_signal_sync(physs_fatal_int_1), 
    .interrupts_counter_level_imc_int_1_out_signal_sync(physs_imc_int_1), 
    .versa_xmp_2_o_ucss_irq_cpi_0_a(o_ucss_irq_cpi_0_a[2]), 
    .versa_xmp_3_o_ucss_irq_cpi_0_a(o_ucss_irq_cpi_0_a[3]), 
    .versa_xmp_2_o_ucss_irq_cpi_1_a(o_ucss_irq_cpi_1_a[2]), 
    .versa_xmp_3_o_ucss_irq_cpi_1_a(o_ucss_irq_cpi_1_a[3]), 
    .versa_xmp_2_o_ucss_irq_cpi_2_a(o_ucss_irq_cpi_2_a[2]), 
    .versa_xmp_3_o_ucss_irq_cpi_2_a(o_ucss_irq_cpi_2_a[3]), 
    .versa_xmp_2_o_ucss_irq_cpi_3_a(o_ucss_irq_cpi_3_a[2]), 
    .versa_xmp_3_o_ucss_irq_cpi_3_a(o_ucss_irq_cpi_3_a[3]), 
    .versa_xmp_2_o_ucss_irq_cpi_4_a(o_ucss_irq_cpi_4_a[2]), 
    .versa_xmp_3_o_ucss_irq_cpi_4_a(o_ucss_irq_cpi_4_a[3]), 
    .versa_xmp_2_o_ucss_irq_to_soc_l0_a(o_ucss_irq_status_a[8]), 
    .versa_xmp_2_o_ucss_irq_to_soc_l1_a(o_ucss_irq_status_a[9]), 
    .versa_xmp_2_o_ucss_irq_to_soc_l2_a(o_ucss_irq_status_a[10]), 
    .versa_xmp_2_o_ucss_irq_to_soc_l3_a(o_ucss_irq_status_a[11]), 
    .versa_xmp_3_o_ucss_irq_to_soc_l0_a(o_ucss_irq_status_a[12]), 
    .versa_xmp_3_o_ucss_irq_to_soc_l1_a(o_ucss_irq_status_a[13]), 
    .versa_xmp_3_o_ucss_irq_to_soc_l2_a(o_ucss_irq_status_a[14]), 
    .versa_xmp_3_o_ucss_irq_to_soc_l3_a(o_ucss_irq_status_a[15]), 
    .pcs_mac_pipeline_top_wrap_pquad0_0_mac0_xlgmii_tx_clkena(pcs_mac_pipeline_top_wrap_pquad0_0_mac0_xlgmii_tx_clkena), 
    .pcs_mac_pipeline_top_wrap_pquad0_0_mac0_xlgmii_rx_clkena(pcs_mac_pipeline_top_wrap_pquad0_0_mac0_xlgmii_rx_clkena), 
    .pcs_mac_pipeline_top_wrap_pquad0_0_mac0_xlgmii_rx_rxc(pcs_mac_pipeline_top_wrap_pquad0_0_mac0_xlgmii_rx_rxc), 
    .pcs_mac_pipeline_top_wrap_pquad0_0_mac0_xlgmii_rx_rxd(pcs_mac_pipeline_top_wrap_pquad0_0_mac0_xlgmii_rx_rxd), 
    .pcs_mac_pipeline_top_wrap_pquad0_0_mac0_xlgmii_rxt0_next(pcs_mac_pipeline_top_wrap_pquad0_0_mac0_xlgmii_rxt0_next), 
    .pcs_mac_pipeline_top_wrap_pquad0_1_pcs0_xlgmii_tx_txc(pcs_mac_pipeline_top_wrap_pquad0_1_pcs0_xlgmii_tx_txc), 
    .pcs_mac_pipeline_top_wrap_pquad0_1_pcs0_xlgmii_tx_txd(pcs_mac_pipeline_top_wrap_pquad0_1_pcs0_xlgmii_tx_txd), 
    .pcs_mac_pipeline_top_wrap_pquad0_0_tsu0_xlgmii_rx_sd(pcs_mac_pipeline_top_wrap_pquad0_0_tsu0_xlgmii_rx_sd), 
    .pcs_mac_pipeline_top_wrap_pquad0_0_tsu0_xlgmii_rx_tsu(pcs_mac_pipeline_top_wrap_pquad0_0_tsu0_xlgmii_rx_tsu), 
    .pcs_mac_pipeline_top_wrap_pquad0_0_tsu0_xlgmii_tx_tsu(pcs_mac_pipeline_top_wrap_pquad0_0_tsu0_xlgmii_tx_tsu), 
    .pcs_mac_pipeline_top_wrap_pquad0_0_mac1_xlgmii_tx_clkena(pcs_mac_pipeline_top_wrap_pquad0_0_mac1_xlgmii_tx_clkena), 
    .pcs_mac_pipeline_top_wrap_pquad0_0_mac1_xlgmii_rx_clkena(pcs_mac_pipeline_top_wrap_pquad0_0_mac1_xlgmii_rx_clkena), 
    .pcs_mac_pipeline_top_wrap_pquad0_0_mac1_xlgmii_rx_rxc(pcs_mac_pipeline_top_wrap_pquad0_0_mac1_xlgmii_rx_rxc), 
    .pcs_mac_pipeline_top_wrap_pquad0_0_mac1_xlgmii_rx_rxd(pcs_mac_pipeline_top_wrap_pquad0_0_mac1_xlgmii_rx_rxd), 
    .pcs_mac_pipeline_top_wrap_pquad0_0_mac1_xlgmii_rxt0_next(pcs_mac_pipeline_top_wrap_pquad0_0_mac1_xlgmii_rxt0_next), 
    .pcs_mac_pipeline_top_wrap_pquad0_1_pcs1_xlgmii_tx_txc(pcs_mac_pipeline_top_wrap_pquad0_1_pcs1_xlgmii_tx_txc), 
    .pcs_mac_pipeline_top_wrap_pquad0_1_pcs1_xlgmii_tx_txd(pcs_mac_pipeline_top_wrap_pquad0_1_pcs1_xlgmii_tx_txd), 
    .pcs_mac_pipeline_top_wrap_pquad0_0_tsu1_xlgmii_rx_sd(pcs_mac_pipeline_top_wrap_pquad0_0_tsu1_xlgmii_rx_sd), 
    .pcs_mac_pipeline_top_wrap_pquad0_0_tsu1_xlgmii_rx_tsu(pcs_mac_pipeline_top_wrap_pquad0_0_tsu1_xlgmii_rx_tsu), 
    .pcs_mac_pipeline_top_wrap_pquad0_0_tsu1_xlgmii_tx_tsu(pcs_mac_pipeline_top_wrap_pquad0_0_tsu1_xlgmii_tx_tsu), 
    .pcs_mac_pipeline_top_wrap_pquad0_0_mac2_xlgmii_tx_clkena(pcs_mac_pipeline_top_wrap_pquad0_0_mac2_xlgmii_tx_clkena), 
    .pcs_mac_pipeline_top_wrap_pquad0_0_mac2_xlgmii_rx_clkena(pcs_mac_pipeline_top_wrap_pquad0_0_mac2_xlgmii_rx_clkena), 
    .pcs_mac_pipeline_top_wrap_pquad0_0_mac2_xlgmii_rx_rxc(pcs_mac_pipeline_top_wrap_pquad0_0_mac2_xlgmii_rx_rxc), 
    .pcs_mac_pipeline_top_wrap_pquad0_0_mac2_xlgmii_rx_rxd(pcs_mac_pipeline_top_wrap_pquad0_0_mac2_xlgmii_rx_rxd), 
    .pcs_mac_pipeline_top_wrap_pquad0_0_mac2_xlgmii_rxt0_next(pcs_mac_pipeline_top_wrap_pquad0_0_mac2_xlgmii_rxt0_next), 
    .pcs_mac_pipeline_top_wrap_pquad0_1_pcs2_xlgmii_tx_txc(pcs_mac_pipeline_top_wrap_pquad0_1_pcs2_xlgmii_tx_txc), 
    .pcs_mac_pipeline_top_wrap_pquad0_1_pcs2_xlgmii_tx_txd(pcs_mac_pipeline_top_wrap_pquad0_1_pcs2_xlgmii_tx_txd), 
    .pcs_mac_pipeline_top_wrap_pquad0_0_tsu2_xlgmii_rx_sd(pcs_mac_pipeline_top_wrap_pquad0_0_tsu2_xlgmii_rx_sd), 
    .pcs_mac_pipeline_top_wrap_pquad0_0_tsu2_xlgmii_rx_tsu(pcs_mac_pipeline_top_wrap_pquad0_0_tsu2_xlgmii_rx_tsu), 
    .pcs_mac_pipeline_top_wrap_pquad0_0_tsu2_xlgmii_tx_tsu(pcs_mac_pipeline_top_wrap_pquad0_0_tsu2_xlgmii_tx_tsu), 
    .pcs_mac_pipeline_top_wrap_pquad0_0_mac3_xlgmii_tx_clkena(pcs_mac_pipeline_top_wrap_pquad0_0_mac3_xlgmii_tx_clkena), 
    .pcs_mac_pipeline_top_wrap_pquad0_0_mac3_xlgmii_rx_clkena(pcs_mac_pipeline_top_wrap_pquad0_0_mac3_xlgmii_rx_clkena), 
    .pcs_mac_pipeline_top_wrap_pquad0_0_mac3_xlgmii_rx_rxc(pcs_mac_pipeline_top_wrap_pquad0_0_mac3_xlgmii_rx_rxc), 
    .pcs_mac_pipeline_top_wrap_pquad0_0_mac3_xlgmii_rx_rxd(pcs_mac_pipeline_top_wrap_pquad0_0_mac3_xlgmii_rx_rxd), 
    .pcs_mac_pipeline_top_wrap_pquad0_0_mac3_xlgmii_rxt0_next(pcs_mac_pipeline_top_wrap_pquad0_0_mac3_xlgmii_rxt0_next), 
    .pcs_mac_pipeline_top_wrap_pquad0_1_pcs3_xlgmii_tx_txc(pcs_mac_pipeline_top_wrap_pquad0_1_pcs3_xlgmii_tx_txc), 
    .pcs_mac_pipeline_top_wrap_pquad0_1_pcs3_xlgmii_tx_txd(pcs_mac_pipeline_top_wrap_pquad0_1_pcs3_xlgmii_tx_txd), 
    .pcs_mac_pipeline_top_wrap_pquad0_0_tsu3_xlgmii_rx_sd(pcs_mac_pipeline_top_wrap_pquad0_0_tsu3_xlgmii_rx_sd), 
    .pcs_mac_pipeline_top_wrap_pquad0_0_tsu3_xlgmii_rx_tsu(pcs_mac_pipeline_top_wrap_pquad0_0_tsu3_xlgmii_rx_tsu), 
    .pcs_mac_pipeline_top_wrap_pquad0_0_tsu3_xlgmii_tx_tsu(pcs_mac_pipeline_top_wrap_pquad0_0_tsu3_xlgmii_tx_tsu), 
    .pcs_mac_pipeline_top_wrap_pquad0_0_mac0_cgmii_tx_clkena(pcs_mac_pipeline_top_wrap_pquad0_0_mac0_cgmii_tx_clkena), 
    .pcs_mac_pipeline_top_wrap_pquad0_0_mac0_cgmii_rx_clkena(pcs_mac_pipeline_top_wrap_pquad0_0_mac0_cgmii_rx_clkena), 
    .pcs_mac_pipeline_top_wrap_pquad0_0_mac0_cgmii_rx_rxc(pcs_mac_pipeline_top_wrap_pquad0_0_mac0_cgmii_rx_rxc), 
    .pcs_mac_pipeline_top_wrap_pquad0_0_mac0_cgmii_rx_rxd(pcs_mac_pipeline_top_wrap_pquad0_0_mac0_cgmii_rx_rxd), 
    .pcs_mac_pipeline_top_wrap_pquad0_1_pcs0_cgmii_tx_txc(pcs_mac_pipeline_top_wrap_pquad0_1_pcs0_cgmii_tx_txc), 
    .pcs_mac_pipeline_top_wrap_pquad0_1_pcs0_cgmii_tx_txd(pcs_mac_pipeline_top_wrap_pquad0_1_pcs0_cgmii_tx_txd), 
    .pcs_mac_pipeline_top_wrap_pquad0_0_mac1_cgmii_tx_clkena(pcs_mac_pipeline_top_wrap_pquad0_0_mac1_cgmii_tx_clkena), 
    .pcs_mac_pipeline_top_wrap_pquad0_0_mac1_cgmii_rx_clkena(pcs_mac_pipeline_top_wrap_pquad0_0_mac1_cgmii_rx_clkena), 
    .pcs_mac_pipeline_top_wrap_pquad0_0_mac1_cgmii_rx_rxc(pcs_mac_pipeline_top_wrap_pquad0_0_mac1_cgmii_rx_rxc), 
    .pcs_mac_pipeline_top_wrap_pquad0_0_mac1_cgmii_rx_rxd(pcs_mac_pipeline_top_wrap_pquad0_0_mac1_cgmii_rx_rxd), 
    .pcs_mac_pipeline_top_wrap_pquad0_1_pcs1_cgmii_tx_txc(pcs_mac_pipeline_top_wrap_pquad0_1_pcs1_cgmii_tx_txc), 
    .pcs_mac_pipeline_top_wrap_pquad0_1_pcs1_cgmii_tx_txd(pcs_mac_pipeline_top_wrap_pquad0_1_pcs1_cgmii_tx_txd), 
    .pcs_mac_pipeline_top_wrap_pquad0_0_mac2_cgmii_tx_clkena(pcs_mac_pipeline_top_wrap_pquad0_0_mac2_cgmii_tx_clkena), 
    .pcs_mac_pipeline_top_wrap_pquad0_0_mac2_cgmii_rx_clkena(pcs_mac_pipeline_top_wrap_pquad0_0_mac2_cgmii_rx_clkena), 
    .pcs_mac_pipeline_top_wrap_pquad0_0_mac2_cgmii_rx_rxc(pcs_mac_pipeline_top_wrap_pquad0_0_mac2_cgmii_rx_rxc), 
    .pcs_mac_pipeline_top_wrap_pquad0_0_mac2_cgmii_rx_rxd(pcs_mac_pipeline_top_wrap_pquad0_0_mac2_cgmii_rx_rxd), 
    .pcs_mac_pipeline_top_wrap_pquad0_1_pcs2_cgmii_tx_txc(pcs_mac_pipeline_top_wrap_pquad0_1_pcs2_cgmii_tx_txc), 
    .pcs_mac_pipeline_top_wrap_pquad0_1_pcs2_cgmii_tx_txd(pcs_mac_pipeline_top_wrap_pquad0_1_pcs2_cgmii_tx_txd), 
    .pcs_mac_pipeline_top_wrap_pquad0_0_mac3_cgmii_tx_clkena(pcs_mac_pipeline_top_wrap_pquad0_0_mac3_cgmii_tx_clkena), 
    .pcs_mac_pipeline_top_wrap_pquad0_0_mac3_cgmii_rx_clkena(pcs_mac_pipeline_top_wrap_pquad0_0_mac3_cgmii_rx_clkena), 
    .pcs_mac_pipeline_top_wrap_pquad0_0_mac3_cgmii_rx_rxc(pcs_mac_pipeline_top_wrap_pquad0_0_mac3_cgmii_rx_rxc), 
    .pcs_mac_pipeline_top_wrap_pquad0_0_mac3_cgmii_rx_rxd(pcs_mac_pipeline_top_wrap_pquad0_0_mac3_cgmii_rx_rxd), 
    .pcs_mac_pipeline_top_wrap_pquad0_1_pcs3_cgmii_tx_txc(pcs_mac_pipeline_top_wrap_pquad0_1_pcs3_cgmii_tx_txc), 
    .pcs_mac_pipeline_top_wrap_pquad0_1_pcs3_cgmii_tx_txd(pcs_mac_pipeline_top_wrap_pquad0_1_pcs3_cgmii_tx_txd), 
    .pcs_mac_pipeline_top_wrap_pquad1_0_mac0_xlgmii_tx_clkena(pcs_mac_pipeline_top_wrap_pquad1_0_mac0_xlgmii_tx_clkena), 
    .pcs_mac_pipeline_top_wrap_pquad1_0_mac0_xlgmii_rx_clkena(pcs_mac_pipeline_top_wrap_pquad1_0_mac0_xlgmii_rx_clkena), 
    .pcs_mac_pipeline_top_wrap_pquad1_0_mac0_xlgmii_rx_rxc(pcs_mac_pipeline_top_wrap_pquad1_0_mac0_xlgmii_rx_rxc), 
    .pcs_mac_pipeline_top_wrap_pquad1_0_mac0_xlgmii_rx_rxd(pcs_mac_pipeline_top_wrap_pquad1_0_mac0_xlgmii_rx_rxd), 
    .pcs_mac_pipeline_top_wrap_pquad1_0_mac0_xlgmii_rxt0_next(pcs_mac_pipeline_top_wrap_pquad1_0_mac0_xlgmii_rxt0_next), 
    .pcs_mac_pipeline_top_wrap_pquad1_1_pcs0_xlgmii_tx_txc(pcs_mac_pipeline_top_wrap_pquad1_1_pcs0_xlgmii_tx_txc), 
    .pcs_mac_pipeline_top_wrap_pquad1_1_pcs0_xlgmii_tx_txd(pcs_mac_pipeline_top_wrap_pquad1_1_pcs0_xlgmii_tx_txd), 
    .pcs_mac_pipeline_top_wrap_pquad1_0_tsu0_xlgmii_rx_sd(pcs_mac_pipeline_top_wrap_pquad1_0_tsu0_xlgmii_rx_sd), 
    .pcs_mac_pipeline_top_wrap_pquad1_0_tsu0_xlgmii_rx_tsu(pcs_mac_pipeline_top_wrap_pquad1_0_tsu0_xlgmii_rx_tsu), 
    .pcs_mac_pipeline_top_wrap_pquad1_0_tsu0_xlgmii_tx_tsu(pcs_mac_pipeline_top_wrap_pquad1_0_tsu0_xlgmii_tx_tsu), 
    .pcs_mac_pipeline_top_wrap_pquad1_0_mac1_xlgmii_tx_clkena(pcs_mac_pipeline_top_wrap_pquad1_0_mac1_xlgmii_tx_clkena), 
    .pcs_mac_pipeline_top_wrap_pquad1_0_mac1_xlgmii_rx_clkena(pcs_mac_pipeline_top_wrap_pquad1_0_mac1_xlgmii_rx_clkena), 
    .pcs_mac_pipeline_top_wrap_pquad1_0_mac1_xlgmii_rx_rxc(pcs_mac_pipeline_top_wrap_pquad1_0_mac1_xlgmii_rx_rxc), 
    .pcs_mac_pipeline_top_wrap_pquad1_0_mac1_xlgmii_rx_rxd(pcs_mac_pipeline_top_wrap_pquad1_0_mac1_xlgmii_rx_rxd), 
    .pcs_mac_pipeline_top_wrap_pquad1_0_mac1_xlgmii_rxt0_next(pcs_mac_pipeline_top_wrap_pquad1_0_mac1_xlgmii_rxt0_next), 
    .pcs_mac_pipeline_top_wrap_pquad1_1_pcs1_xlgmii_tx_txc(pcs_mac_pipeline_top_wrap_pquad1_1_pcs1_xlgmii_tx_txc), 
    .pcs_mac_pipeline_top_wrap_pquad1_1_pcs1_xlgmii_tx_txd(pcs_mac_pipeline_top_wrap_pquad1_1_pcs1_xlgmii_tx_txd), 
    .pcs_mac_pipeline_top_wrap_pquad1_0_tsu1_xlgmii_rx_sd(pcs_mac_pipeline_top_wrap_pquad1_0_tsu1_xlgmii_rx_sd), 
    .pcs_mac_pipeline_top_wrap_pquad1_0_tsu1_xlgmii_rx_tsu(pcs_mac_pipeline_top_wrap_pquad1_0_tsu1_xlgmii_rx_tsu), 
    .pcs_mac_pipeline_top_wrap_pquad1_0_tsu1_xlgmii_tx_tsu(pcs_mac_pipeline_top_wrap_pquad1_0_tsu1_xlgmii_tx_tsu), 
    .pcs_mac_pipeline_top_wrap_pquad1_0_mac2_xlgmii_tx_clkena(pcs_mac_pipeline_top_wrap_pquad1_0_mac2_xlgmii_tx_clkena), 
    .pcs_mac_pipeline_top_wrap_pquad1_0_mac2_xlgmii_rx_clkena(pcs_mac_pipeline_top_wrap_pquad1_0_mac2_xlgmii_rx_clkena), 
    .pcs_mac_pipeline_top_wrap_pquad1_0_mac2_xlgmii_rx_rxc(pcs_mac_pipeline_top_wrap_pquad1_0_mac2_xlgmii_rx_rxc), 
    .pcs_mac_pipeline_top_wrap_pquad1_0_mac2_xlgmii_rx_rxd(pcs_mac_pipeline_top_wrap_pquad1_0_mac2_xlgmii_rx_rxd), 
    .pcs_mac_pipeline_top_wrap_pquad1_0_mac2_xlgmii_rxt0_next(pcs_mac_pipeline_top_wrap_pquad1_0_mac2_xlgmii_rxt0_next), 
    .pcs_mac_pipeline_top_wrap_pquad1_1_pcs2_xlgmii_tx_txc(pcs_mac_pipeline_top_wrap_pquad1_1_pcs2_xlgmii_tx_txc), 
    .pcs_mac_pipeline_top_wrap_pquad1_1_pcs2_xlgmii_tx_txd(pcs_mac_pipeline_top_wrap_pquad1_1_pcs2_xlgmii_tx_txd), 
    .pcs_mac_pipeline_top_wrap_pquad1_0_tsu2_xlgmii_rx_sd(pcs_mac_pipeline_top_wrap_pquad1_0_tsu2_xlgmii_rx_sd), 
    .pcs_mac_pipeline_top_wrap_pquad1_0_tsu2_xlgmii_rx_tsu(pcs_mac_pipeline_top_wrap_pquad1_0_tsu2_xlgmii_rx_tsu), 
    .pcs_mac_pipeline_top_wrap_pquad1_0_tsu2_xlgmii_tx_tsu(pcs_mac_pipeline_top_wrap_pquad1_0_tsu2_xlgmii_tx_tsu), 
    .pcs_mac_pipeline_top_wrap_pquad1_0_mac3_xlgmii_tx_clkena(pcs_mac_pipeline_top_wrap_pquad1_0_mac3_xlgmii_tx_clkena), 
    .pcs_mac_pipeline_top_wrap_pquad1_0_mac3_xlgmii_rx_clkena(pcs_mac_pipeline_top_wrap_pquad1_0_mac3_xlgmii_rx_clkena), 
    .pcs_mac_pipeline_top_wrap_pquad1_0_mac3_xlgmii_rx_rxc(pcs_mac_pipeline_top_wrap_pquad1_0_mac3_xlgmii_rx_rxc), 
    .pcs_mac_pipeline_top_wrap_pquad1_0_mac3_xlgmii_rx_rxd(pcs_mac_pipeline_top_wrap_pquad1_0_mac3_xlgmii_rx_rxd), 
    .pcs_mac_pipeline_top_wrap_pquad1_0_mac3_xlgmii_rxt0_next(pcs_mac_pipeline_top_wrap_pquad1_0_mac3_xlgmii_rxt0_next), 
    .pcs_mac_pipeline_top_wrap_pquad1_1_pcs3_xlgmii_tx_txc(pcs_mac_pipeline_top_wrap_pquad1_1_pcs3_xlgmii_tx_txc), 
    .pcs_mac_pipeline_top_wrap_pquad1_1_pcs3_xlgmii_tx_txd(pcs_mac_pipeline_top_wrap_pquad1_1_pcs3_xlgmii_tx_txd), 
    .pcs_mac_pipeline_top_wrap_pquad1_0_tsu3_xlgmii_rx_sd(pcs_mac_pipeline_top_wrap_pquad1_0_tsu3_xlgmii_rx_sd), 
    .pcs_mac_pipeline_top_wrap_pquad1_0_tsu3_xlgmii_rx_tsu(pcs_mac_pipeline_top_wrap_pquad1_0_tsu3_xlgmii_rx_tsu), 
    .pcs_mac_pipeline_top_wrap_pquad1_0_tsu3_xlgmii_tx_tsu(pcs_mac_pipeline_top_wrap_pquad1_0_tsu3_xlgmii_tx_tsu), 
    .pcs_mac_pipeline_top_wrap_pquad1_0_mac0_cgmii_tx_clkena(pcs_mac_pipeline_top_wrap_pquad1_0_mac0_cgmii_tx_clkena), 
    .pcs_mac_pipeline_top_wrap_pquad1_0_mac0_cgmii_rx_clkena(pcs_mac_pipeline_top_wrap_pquad1_0_mac0_cgmii_rx_clkena), 
    .pcs_mac_pipeline_top_wrap_pquad1_0_mac0_cgmii_rx_rxc(pcs_mac_pipeline_top_wrap_pquad1_0_mac0_cgmii_rx_rxc), 
    .pcs_mac_pipeline_top_wrap_pquad1_0_mac0_cgmii_rx_rxd(pcs_mac_pipeline_top_wrap_pquad1_0_mac0_cgmii_rx_rxd), 
    .pcs_mac_pipeline_top_wrap_pquad1_1_pcs0_cgmii_tx_txc(pcs_mac_pipeline_top_wrap_pquad1_1_pcs0_cgmii_tx_txc), 
    .pcs_mac_pipeline_top_wrap_pquad1_1_pcs0_cgmii_tx_txd(pcs_mac_pipeline_top_wrap_pquad1_1_pcs0_cgmii_tx_txd), 
    .pcs_mac_pipeline_top_wrap_pquad1_0_mac1_cgmii_tx_clkena(pcs_mac_pipeline_top_wrap_pquad1_0_mac1_cgmii_tx_clkena), 
    .pcs_mac_pipeline_top_wrap_pquad1_0_mac1_cgmii_rx_clkena(pcs_mac_pipeline_top_wrap_pquad1_0_mac1_cgmii_rx_clkena), 
    .pcs_mac_pipeline_top_wrap_pquad1_0_mac1_cgmii_rx_rxc(pcs_mac_pipeline_top_wrap_pquad1_0_mac1_cgmii_rx_rxc), 
    .pcs_mac_pipeline_top_wrap_pquad1_0_mac1_cgmii_rx_rxd(pcs_mac_pipeline_top_wrap_pquad1_0_mac1_cgmii_rx_rxd), 
    .pcs_mac_pipeline_top_wrap_pquad1_1_pcs1_cgmii_tx_txc(pcs_mac_pipeline_top_wrap_pquad1_1_pcs1_cgmii_tx_txc), 
    .pcs_mac_pipeline_top_wrap_pquad1_1_pcs1_cgmii_tx_txd(pcs_mac_pipeline_top_wrap_pquad1_1_pcs1_cgmii_tx_txd), 
    .pcs_mac_pipeline_top_wrap_pquad1_0_mac2_cgmii_tx_clkena(pcs_mac_pipeline_top_wrap_pquad1_0_mac2_cgmii_tx_clkena), 
    .pcs_mac_pipeline_top_wrap_pquad1_0_mac2_cgmii_rx_clkena(pcs_mac_pipeline_top_wrap_pquad1_0_mac2_cgmii_rx_clkena), 
    .pcs_mac_pipeline_top_wrap_pquad1_0_mac2_cgmii_rx_rxc(pcs_mac_pipeline_top_wrap_pquad1_0_mac2_cgmii_rx_rxc), 
    .pcs_mac_pipeline_top_wrap_pquad1_0_mac2_cgmii_rx_rxd(pcs_mac_pipeline_top_wrap_pquad1_0_mac2_cgmii_rx_rxd), 
    .pcs_mac_pipeline_top_wrap_pquad1_1_pcs2_cgmii_tx_txc(pcs_mac_pipeline_top_wrap_pquad1_1_pcs2_cgmii_tx_txc), 
    .pcs_mac_pipeline_top_wrap_pquad1_1_pcs2_cgmii_tx_txd(pcs_mac_pipeline_top_wrap_pquad1_1_pcs2_cgmii_tx_txd), 
    .pcs_mac_pipeline_top_wrap_pquad1_0_mac3_cgmii_tx_clkena(pcs_mac_pipeline_top_wrap_pquad1_0_mac3_cgmii_tx_clkena), 
    .pcs_mac_pipeline_top_wrap_pquad1_0_mac3_cgmii_rx_clkena(pcs_mac_pipeline_top_wrap_pquad1_0_mac3_cgmii_rx_clkena), 
    .pcs_mac_pipeline_top_wrap_pquad1_0_mac3_cgmii_rx_rxc(pcs_mac_pipeline_top_wrap_pquad1_0_mac3_cgmii_rx_rxc), 
    .pcs_mac_pipeline_top_wrap_pquad1_0_mac3_cgmii_rx_rxd(pcs_mac_pipeline_top_wrap_pquad1_0_mac3_cgmii_rx_rxd), 
    .pcs_mac_pipeline_top_wrap_pquad1_1_pcs3_cgmii_tx_txc(pcs_mac_pipeline_top_wrap_pquad1_1_pcs3_cgmii_tx_txc), 
    .pcs_mac_pipeline_top_wrap_pquad1_1_pcs3_cgmii_tx_txd(pcs_mac_pipeline_top_wrap_pquad1_1_pcs3_cgmii_tx_txd), 
    .physs_1_AWID(physs_1_AWID), 
    .physs_1_AWADDR(physs_1_AWADDR[22:0]), 
    .physs_1_AWLEN(physs_1_AWLEN), 
    .physs_1_AWSIZE(physs_1_AWSIZE), 
    .physs_1_AWBURST(physs_1_AWBURST), 
    .physs_1_AWLOCK(physs_1_AWLOCK), 
    .physs_1_AWCACHE(physs_1_AWCACHE), 
    .physs_1_AWPROT(physs_1_AWPROT), 
    .physs_1_AWVALID(physs_1_AWVALID), 
    .physs_1_WDATA(physs_1_WDATA), 
    .physs_1_WSTRB(physs_1_WSTRB), 
    .physs_1_WLAST(physs_1_WLAST), 
    .physs_1_WVALID(physs_1_WVALID), 
    .physs_1_BREADY(physs_1_BREADY), 
    .physs_1_ARID(physs_1_ARID), 
    .physs_1_ARADDR(physs_1_ARADDR[22:0]), 
    .physs_1_ARLEN(physs_1_ARLEN), 
    .physs_1_ARSIZE(physs_1_ARSIZE), 
    .physs_1_ARBURST(physs_1_ARBURST), 
    .physs_1_ARLOCK(physs_1_ARLOCK), 
    .physs_1_ARCACHE(physs_1_ARCACHE), 
    .physs_1_ARPROT(physs_1_ARPROT), 
    .physs_1_ARVALID(physs_1_ARVALID), 
    .nic400_physs_1_awready_slave_physs(physs_1_AWREADY), 
    .nic400_physs_1_wready_slave_physs(physs_1_WREADY), 
    .physs_1_RREADY(physs_1_RREADY), 
    .nic400_physs_1_bid_slave_physs(physs_1_BID), 
    .nic400_physs_1_bresp_slave_physs(physs_1_BRESP), 
    .nic400_physs_1_bvalid_slave_physs(physs_1_BVALID), 
    .nic400_physs_1_arready_slave_physs(physs_1_ARREADY), 
    .nic400_physs_1_rid_slave_physs(physs_1_RID), 
    .nic400_physs_1_rdata_slave_physs(physs_1_RDATA), 
    .nic400_physs_1_rresp_slave_physs(physs_1_RRESP), 
    .nic400_physs_1_rlast_slave_physs(physs_1_RLAST), 
    .nic400_physs_1_rvalid_slave_physs(physs_1_RVALID), 
    .socviewpin_4to1digimux_1_outmux(physs_clkobs_out_clk[1]), 
    .parmisc_physs0_BSCAN_PIPE_OUT_TO_parmisc_physs1_scan_in(parmisc_physs0_BSCAN_PIPE_OUT_TO_parmisc_physs1_scan_in), 
    .parmisc_physs1_BSCAN_PIPE_OUT_scan_out(parmisc_physs1_BSCAN_PIPE_OUT_scan_out), 
    .parmisc_physs0_BSCAN_PIPE_OUT_TO_parmisc_physs1_force_disable(parmisc_physs0_BSCAN_PIPE_OUT_TO_parmisc_physs1_force_disable), 
    .parmisc_physs0_BSCAN_PIPE_OUT_TO_parmisc_physs1_select_jtag_input(parmisc_physs0_BSCAN_PIPE_OUT_TO_parmisc_physs1_select_jtag_input), 
    .parmisc_physs0_BSCAN_PIPE_OUT_TO_parmisc_physs1_select_jtag_output(parmisc_physs0_BSCAN_PIPE_OUT_TO_parmisc_physs1_select_jtag_output), 
    .parmisc_physs0_BSCAN_PIPE_OUT_TO_parmisc_physs1_ac_init_clock0(parmisc_physs0_BSCAN_PIPE_OUT_TO_parmisc_physs1_ac_init_clock0), 
    .parmisc_physs0_BSCAN_PIPE_OUT_TO_parmisc_physs1_ac_init_clock1(parmisc_physs0_BSCAN_PIPE_OUT_TO_parmisc_physs1_ac_init_clock1), 
    .parmisc_physs0_BSCAN_PIPE_OUT_TO_parmisc_physs1_ac_signal(parmisc_physs0_BSCAN_PIPE_OUT_TO_parmisc_physs1_ac_signal), 
    .parmisc_physs0_BSCAN_PIPE_OUT_TO_parmisc_physs1_ac_mode_en(parmisc_physs0_BSCAN_PIPE_OUT_TO_parmisc_physs1_ac_mode_en), 
    .parmisc_physs0_BSCAN_PIPE_OUT_TO_parmisc_physs1_intel_update_clk(parmisc_physs0_BSCAN_PIPE_OUT_TO_parmisc_physs1_intel_update_clk), 
    .parmisc_physs0_BSCAN_PIPE_OUT_TO_parmisc_physs1_intel_clamp_en(parmisc_physs0_BSCAN_PIPE_OUT_TO_parmisc_physs1_intel_clamp_en), 
    .parmisc_physs0_BSCAN_PIPE_OUT_TO_parmisc_physs1_intel_bscan_mode(parmisc_physs0_BSCAN_PIPE_OUT_TO_parmisc_physs1_intel_bscan_mode), 
    .parmisc_physs0_BSCAN_PIPE_OUT_TO_parmisc_physs1_select(parmisc_physs0_BSCAN_PIPE_OUT_TO_parmisc_physs1_select), 
    .parmisc_physs0_BSCAN_PIPE_OUT_TO_parmisc_physs1_bscan_clock(parmisc_physs0_BSCAN_PIPE_OUT_TO_parmisc_physs1_bscan_clock), 
    .parmisc_physs0_BSCAN_PIPE_OUT_TO_parmisc_physs1_capture_en(parmisc_physs0_BSCAN_PIPE_OUT_TO_parmisc_physs1_capture_en), 
    .parmisc_physs0_BSCAN_PIPE_OUT_TO_parmisc_physs1_shift_en(parmisc_physs0_BSCAN_PIPE_OUT_TO_parmisc_physs1_shift_en), 
    .parmisc_physs0_BSCAN_PIPE_OUT_TO_parmisc_physs1_update_en(parmisc_physs0_BSCAN_PIPE_OUT_TO_parmisc_physs1_update_en), 
    .PHYSS_BSCAN_BYPASS(PHYSS_BSCAN_BYPASS[0]), 
    .PHYSS_BSCAN_BYPASS_0(PHYSS_BSCAN_BYPASS[1]), 
    .PHYSS_BSCAN_BYPASS_1(PHYSS_BSCAN_BYPASS[2]), 
    .PHYSS_BSCAN_BYPASS_2(PHYSS_BSCAN_BYPASS[3]), 
    .PHYSS_BSCAN_BYPASS_3(PHYSS_BSCAN_BYPASS[4]), 
    .PHYSS_BSCAN_BYPASS_4(PHYSS_BSCAN_BYPASS[5]), 
    .PHYSS_BSCAN_BYPASS_5(PHYSS_BSCAN_BYPASS[6]), 
    .PHYSS_BSCAN_BYPASS_6(PHYSS_BSCAN_BYPASS[7]), 
    .PHYSS_BSCAN_BYPASS_7(PHYSS_BSCAN_BYPASS[18]), 
    .PHYSS_BSCAN_BYPASS_8(PHYSS_BSCAN_BYPASS[19]), 
    .parmisc_physs1_BSCAN_PIPE_OUT_2_bscan_to_intel_d6actestsig_b(parmisc_physs1_BSCAN_PIPE_OUT_2_bscan_to_intel_d6actestsig_b), 
    .parmisc_physs0_BSCAN_PIPE_OUT_2_bscan_to_intel_d6actestsig_b(parmisc_physs0_BSCAN_PIPE_OUT_2_bscan_to_intel_d6actestsig_b), 
    .SSN_END_chain_towards_parmisc_physs0_bus_data_out(physs1_SSN_END_chain_towards_parmisc_physs0_bus_data_out), 
    .SSN_START_from_parmisc_physs0_bus_data_in(physs0_SSN_END_towards_parmisc_physs1_bus_data_out), 
    .tms(tms), 
    .tck(tck), 
    .tdi(tdi), 
    .trst_b(trst_b), 
    .parmisc_physs1_NW_IN_tdo(parmisc_physs1_NW_IN_tdo), 
    .parmisc_physs1_NW_IN_tdo_en(parmisc_physs1_NW_IN_tdo_en), 
    .parmisc_physs0_NW_OUT_parmisc_physs1_ijtag_to_reset(parmisc_physs0_NW_OUT_parmisc_physs1_ijtag_to_reset), 
    .parmisc_physs0_NW_OUT_parmisc_physs1_ijtag_to_ce(parmisc_physs0_NW_OUT_parmisc_physs1_ijtag_to_ce), 
    .parmisc_physs0_NW_OUT_parmisc_physs1_ijtag_to_se(parmisc_physs0_NW_OUT_parmisc_physs1_ijtag_to_se), 
    .parmisc_physs0_NW_OUT_parmisc_physs1_ijtag_to_ue(parmisc_physs0_NW_OUT_parmisc_physs1_ijtag_to_ue), 
    .parmisc_physs0_NW_OUT_parmisc_physs1_ijtag_to_sel(parmisc_physs0_NW_OUT_parmisc_physs1_ijtag_to_sel), 
    .parmisc_physs0_NW_OUT_parmisc_physs1_ijtag_to_si(parmisc_physs0_NW_OUT_parmisc_physs1_ijtag_to_si), 
    .parmisc_physs1_NW_IN_ijtag_so(parmisc_physs1_NW_IN_ijtag_so), 
    .shift_ir_dr(shift_ir_dr), 
    .tms_park_value(tms_park_value), 
    .nw_mode(nw_mode), 
    .parmisc_physs1_NW_IN_tap_sel_out(parmisc_physs1_NW_IN_tap_sel_out), 
    .SSN_START_from_parmisc_physs0_bus_clock_in(ssn_bus_clock_in), 
    .ioa_ck_pma3_ref_right_pquad1_physs1()
) ;

// ============================================================================
// CDC: XLGMII CDC Wrapper Instantiations (16 instances total)
// These CDC wrappers handle clock domain crossing for all 16 XLGMII interfaces
// connecting top-level ports (hlp_xlgmii*) to physs0 internal signals
// 
// Organization:
//   - 4 instances for MQUAD0 (xlgmii[0-3]_cdc_mquad0)
//   - 4 instances for MQUAD1 (xlgmii[0-3]_cdc_mquad1)
//   - 4 instances for PQUAD0 (xlgmii[0-3]_cdc_pquad0)
//   - 4 instances for PQUAD1 (xlgmii[0-3]_cdc_pquad1)
// 
// Signal Flow:
//   RX: hlp_xlgmii*_rx* (top) → CDC → physs_hlp_xlgmii*_rx* (to physs0)
//   TX: hlp_physs_xlgmii*_tx* (from physs0) → CDC → hlp_xlgmii*_tx* (top)
// ============================================================================

xlgmii_cdc_wrapper xlgmii0_cdc_mquad0 (
     .rd_clk(rd_clk_mquad0),
     .wr_clk(tsu_clk),
     .rstn(physs0_func_rst_raw_n),
     .physs_hlp_xlgmii0_rxc_0(physs_hlp_xlgmii0_rxc_0),
     .physs_hlp_xlgmii0_rxd_0(physs_hlp_xlgmii0_rxd_0),
     .physs_hlp_xlgmii0_rxt0_next_0(physs_hlp_xlgmii0_rxt0_next_0),
     .physs_hlp_xlgmii0_rxclk_ena_0(physs_hlp_xlgmii0_rxclk_ena_0),
     .hlp_xlgmii0_rxc_0(hlp_xlgmii0_rxc_0),
     .hlp_xlgmii0_rxd_0(hlp_xlgmii0_rxd_0),
     .hlp_xlgmii0_rxt0_next_0(hlp_xlgmii0_rxt0_next_0),
     .hlp_xlgmii0_rxclk_ena_0(hlp_xlgmii0_rxclk_ena_0),
     .physs_hlp_xlgmii0_txclk_ena_0(physs_hlp_xlgmii0_txclk_ena_0),
     .hlp_xlgmii0_txclk_ena_0(hlp_xlgmii0_txclk_ena_0),
     .hlp_port4_xlgmii_tx_data(hlp_xlgmii0_txd_0),
     .hlp_port4_xlgmii_tx_c(hlp_xlgmii0_txc_0),
     .hlp_xlgmii0_txd_0(hlp_physs_xlgmii0_txd_0),
     .hlp_xlgmii0_txc_0(hlp_physs_xlgmii0_txc_0)
 ) ; 

xlgmii_cdc_wrapper xlgmii1_cdc_mquad0 (
     .rd_clk(rd_clk_mquad0),
     .wr_clk(tsu_clk),
     .rstn(physs0_func_rst_raw_n),
     .physs_hlp_xlgmii0_rxc_0(physs_hlp_xlgmii1_rxc_0),
     .physs_hlp_xlgmii0_rxd_0(physs_hlp_xlgmii1_rxd_0),
     .physs_hlp_xlgmii0_rxt0_next_0(physs_hlp_xlgmii1_rxt0_next_0),
     .physs_hlp_xlgmii0_rxclk_ena_0(physs_hlp_xlgmii1_rxclk_ena_0),
     .hlp_xlgmii0_rxc_0(hlp_xlgmii1_rxc_0),
     .hlp_xlgmii0_rxd_0(hlp_xlgmii1_rxd_0),
     .hlp_xlgmii0_rxt0_next_0(hlp_xlgmii1_rxt0_next_0),
     .hlp_xlgmii0_rxclk_ena_0(hlp_xlgmii1_rxclk_ena_0),
     .physs_hlp_xlgmii0_txclk_ena_0(physs_hlp_xlgmii1_txclk_ena_0),
     .hlp_xlgmii0_txclk_ena_0(hlp_xlgmii1_txclk_ena_0),
     .hlp_port4_xlgmii_tx_data(hlp_xlgmii1_txd_0),
     .hlp_port4_xlgmii_tx_c(hlp_xlgmii1_txc_0),
     .hlp_xlgmii0_txd_0(hlp_physs_xlgmii1_txd_0),
     .hlp_xlgmii0_txc_0(hlp_physs_xlgmii1_txc_0)
 ) ; 

xlgmii_cdc_wrapper xlgmii2_cdc_mquad0 (
     .rd_clk(rd_clk_mquad0),
     .wr_clk(tsu_clk),
     .rstn(physs0_func_rst_raw_n),
     .physs_hlp_xlgmii0_rxc_0(physs_hlp_xlgmii2_rxc_0),
     .physs_hlp_xlgmii0_rxd_0(physs_hlp_xlgmii2_rxd_0),
     .physs_hlp_xlgmii0_rxt0_next_0(physs_hlp_xlgmii2_rxt0_next_0),
     .physs_hlp_xlgmii0_rxclk_ena_0(physs_hlp_xlgmii2_rxclk_ena_0),
     .hlp_xlgmii0_rxc_0(hlp_xlgmii2_rxc_0),
     .hlp_xlgmii0_rxd_0(hlp_xlgmii2_rxd_0),
     .hlp_xlgmii0_rxt0_next_0(hlp_xlgmii2_rxt0_next_0),
     .hlp_xlgmii0_rxclk_ena_0(hlp_xlgmii2_rxclk_ena_0),
     .physs_hlp_xlgmii0_txclk_ena_0(physs_hlp_xlgmii2_txclk_ena_0),
     .hlp_xlgmii0_txclk_ena_0(hlp_xlgmii2_txclk_ena_0),
     .hlp_port4_xlgmii_tx_data(hlp_xlgmii2_txd_0),
     .hlp_port4_xlgmii_tx_c(hlp_xlgmii2_txc_0),
     .hlp_xlgmii0_txd_0(hlp_physs_xlgmii2_txd_0),
     .hlp_xlgmii0_txc_0(hlp_physs_xlgmii2_txc_0)
 ) ; 

xlgmii_cdc_wrapper xlgmii3_cdc_mquad0 (
     .rd_clk(rd_clk_mquad0),
     .wr_clk(tsu_clk),
     .rstn(physs0_func_rst_raw_n),
     .physs_hlp_xlgmii0_rxc_0(physs_hlp_xlgmii3_rxc_0),
     .physs_hlp_xlgmii0_rxd_0(physs_hlp_xlgmii3_rxd_0),
     .physs_hlp_xlgmii0_rxt0_next_0(physs_hlp_xlgmii3_rxt0_next_0),
     .physs_hlp_xlgmii0_rxclk_ena_0(physs_hlp_xlgmii3_rxclk_ena_0),
     .hlp_xlgmii0_rxc_0(hlp_xlgmii3_rxc_0),
     .hlp_xlgmii0_rxd_0(hlp_xlgmii3_rxd_0),
     .hlp_xlgmii0_rxt0_next_0(hlp_xlgmii3_rxt0_next_0),
     .hlp_xlgmii0_rxclk_ena_0(hlp_xlgmii3_rxclk_ena_0),
     .physs_hlp_xlgmii0_txclk_ena_0(physs_hlp_xlgmii3_txclk_ena_0),
     .hlp_xlgmii0_txclk_ena_0(hlp_xlgmii3_txclk_ena_0),
     .hlp_port4_xlgmii_tx_data(hlp_xlgmii3_txd_0),
     .hlp_port4_xlgmii_tx_c(hlp_xlgmii3_txc_0),
     .hlp_xlgmii0_txd_0(hlp_physs_xlgmii3_txd_0),
     .hlp_xlgmii0_txc_0(hlp_physs_xlgmii3_txc_0)
 ) ; 

// CDC: MQUAD1 XLGMII CDC Instances (4 interfaces with suffix _1)
xlgmii_cdc_wrapper xlgmii0_cdc_mquad1 (
     .rd_clk(rd_clk_mquad1),
     .wr_clk(tsu_clk),
     .rstn(physs0_func_rst_raw_n),
     .physs_hlp_xlgmii0_rxc_0(physs_hlp_xlgmii0_rxc_1),
     .physs_hlp_xlgmii0_rxd_0(physs_hlp_xlgmii0_rxd_1),
     .physs_hlp_xlgmii0_rxt0_next_0(physs_hlp_xlgmii0_rxt0_next_1),
     .physs_hlp_xlgmii0_rxclk_ena_0(physs_hlp_xlgmii0_rxclk_ena_1),
     .hlp_xlgmii0_rxc_0(hlp_xlgmii0_rxc_1),
     .hlp_xlgmii0_rxd_0(hlp_xlgmii0_rxd_1),
     .hlp_xlgmii0_rxt0_next_0(hlp_xlgmii0_rxt0_next_1),
     .hlp_xlgmii0_rxclk_ena_0(hlp_xlgmii0_rxclk_ena_1),
     .physs_hlp_xlgmii0_txclk_ena_0(physs_hlp_xlgmii0_txclk_ena_1),
     .hlp_xlgmii0_txclk_ena_0(hlp_xlgmii0_txclk_ena_1),
     .hlp_port4_xlgmii_tx_data(hlp_xlgmii0_txd_1),
     .hlp_port4_xlgmii_tx_c(hlp_xlgmii0_txc_1),
     .hlp_xlgmii0_txd_0(hlp_physs_xlgmii0_txd_1),
     .hlp_xlgmii0_txc_0(hlp_physs_xlgmii0_txc_1)
 ) ; 

// CDC: MQUAD1 XLGMII CDC Instances (4 interfaces with suffix _1)
xlgmii_cdc_wrapper xlgmii1_cdc_mquad1 (
     .rd_clk(rd_clk_mquad1),
     .wr_clk(tsu_clk),
     .rstn(physs0_func_rst_raw_n),
     .physs_hlp_xlgmii0_rxc_0(physs_hlp_xlgmii1_rxc_1),
     .physs_hlp_xlgmii0_rxd_0(physs_hlp_xlgmii1_rxd_1),
     .physs_hlp_xlgmii0_rxt0_next_0(physs_hlp_xlgmii1_rxt0_next_1),
     .physs_hlp_xlgmii0_rxclk_ena_0(physs_hlp_xlgmii1_rxclk_ena_1),
     .hlp_xlgmii0_rxc_0(hlp_xlgmii1_rxc_1),
     .hlp_xlgmii0_rxd_0(hlp_xlgmii1_rxd_1),
     .hlp_xlgmii0_rxt0_next_0(hlp_xlgmii1_rxt0_next_1),
     .hlp_xlgmii0_rxclk_ena_0(hlp_xlgmii1_rxclk_ena_1),
     .physs_hlp_xlgmii0_txclk_ena_0(physs_hlp_xlgmii1_txclk_ena_1),
     .hlp_xlgmii0_txclk_ena_0(hlp_xlgmii1_txclk_ena_1),
     .hlp_port4_xlgmii_tx_data(hlp_xlgmii1_txd_1),
     .hlp_port4_xlgmii_tx_c(hlp_xlgmii1_txc_1),
     .hlp_xlgmii0_txd_0(hlp_physs_xlgmii1_txd_1),
     .hlp_xlgmii0_txc_0(hlp_physs_xlgmii1_txc_1)
 ) ; 

xlgmii_cdc_wrapper xlgmii2_cdc_mquad1 (
     .rd_clk(rd_clk_mquad1),
     .wr_clk(tsu_clk),
     .rstn(physs0_func_rst_raw_n),
     .physs_hlp_xlgmii0_rxc_0(physs_hlp_xlgmii2_rxc_1),
     .physs_hlp_xlgmii0_rxd_0(physs_hlp_xlgmii2_rxd_1),
     .physs_hlp_xlgmii0_rxt0_next_0(physs_hlp_xlgmii2_rxt0_next_1),
     .physs_hlp_xlgmii0_rxclk_ena_0(physs_hlp_xlgmii2_rxclk_ena_1),
     .hlp_xlgmii0_rxc_0(hlp_xlgmii2_rxc_1),
     .hlp_xlgmii0_rxd_0(hlp_xlgmii2_rxd_1),
     .hlp_xlgmii0_rxt0_next_0(hlp_xlgmii2_rxt0_next_1),
     .hlp_xlgmii0_rxclk_ena_0(hlp_xlgmii2_rxclk_ena_1),
     .physs_hlp_xlgmii0_txclk_ena_0(physs_hlp_xlgmii2_txclk_ena_1),
     .hlp_xlgmii0_txclk_ena_0(hlp_xlgmii2_txclk_ena_1),
     .hlp_port4_xlgmii_tx_data(hlp_xlgmii2_txd_1),
     .hlp_port4_xlgmii_tx_c(hlp_xlgmii2_txc_1),
     .hlp_xlgmii0_txd_0(hlp_physs_xlgmii2_txd_1),
     .hlp_xlgmii0_txc_0(hlp_physs_xlgmii2_txc_1)
 ) ; 

xlgmii_cdc_wrapper xlgmii3_cdc_mquad1 (
     .rd_clk(rd_clk_mquad1),
     .wr_clk(tsu_clk),
     .rstn(physs0_func_rst_raw_n),
     .physs_hlp_xlgmii0_rxc_0(physs_hlp_xlgmii3_rxc_1),
     .physs_hlp_xlgmii0_rxd_0(physs_hlp_xlgmii3_rxd_1),
     .physs_hlp_xlgmii0_rxt0_next_0(physs_hlp_xlgmii3_rxt0_next_1),
     .physs_hlp_xlgmii0_rxclk_ena_0(physs_hlp_xlgmii3_rxclk_ena_1),
     .hlp_xlgmii0_rxc_0(hlp_xlgmii3_rxc_1),
     .hlp_xlgmii0_rxd_0(hlp_xlgmii3_rxd_1),
     .hlp_xlgmii0_rxt0_next_0(hlp_xlgmii3_rxt0_next_1),
     .hlp_xlgmii0_rxclk_ena_0(hlp_xlgmii3_rxclk_ena_1),
     .physs_hlp_xlgmii0_txclk_ena_0(physs_hlp_xlgmii3_txclk_ena_1),
     .hlp_xlgmii0_txclk_ena_0(hlp_xlgmii3_txclk_ena_1),
     .hlp_port4_xlgmii_tx_data(hlp_xlgmii3_txd_1),
     .hlp_port4_xlgmii_tx_c(hlp_xlgmii3_txc_1),
     .hlp_xlgmii0_txd_0(hlp_physs_xlgmii3_txd_1),
     .hlp_xlgmii0_txc_0(hlp_physs_xlgmii3_txc_1)
 ) ; 

// CDC: PQUAD0 XLGMII CDC Instances (4 interfaces with suffix _2)
xlgmii_cdc_wrapper xlgmii0_cdc_pquad0 (
     .rd_clk(rd_clk_pquad),
     .wr_clk(tsu_clk),
     .rstn(physs0_func_rst_raw_n),
     .physs_hlp_xlgmii0_rxc_0(physs_hlp_xlgmii0_rxc_2),
     .physs_hlp_xlgmii0_rxd_0(physs_hlp_xlgmii0_rxd_2),
     .physs_hlp_xlgmii0_rxt0_next_0(physs_hlp_xlgmii0_rxt0_next_2),
     .physs_hlp_xlgmii0_rxclk_ena_0(physs_hlp_xlgmii0_rxclk_ena_2),
     .hlp_xlgmii0_rxc_0(hlp_xlgmii0_rxc_2),
     .hlp_xlgmii0_rxd_0(hlp_xlgmii0_rxd_2),
     .hlp_xlgmii0_rxt0_next_0(hlp_xlgmii0_rxt0_next_2),
     .hlp_xlgmii0_rxclk_ena_0(hlp_xlgmii0_rxclk_ena_2),
     .physs_hlp_xlgmii0_txclk_ena_0(physs_hlp_xlgmii0_txclk_ena_2),
     .hlp_xlgmii0_txclk_ena_0(hlp_xlgmii0_txclk_ena_2),
     .hlp_port4_xlgmii_tx_data(hlp_xlgmii0_txd_2),
     .hlp_port4_xlgmii_tx_c(hlp_xlgmii0_txc_2),
     .hlp_xlgmii0_txd_0(hlp_physs_xlgmii0_txd_2),
     .hlp_xlgmii0_txc_0(hlp_physs_xlgmii0_txc_2)
 ) ; 

xlgmii_cdc_wrapper xlgmii1_cdc_pquad0 (
     .rd_clk(rd_clk_pquad),
     .wr_clk(tsu_clk),
     .rstn(physs0_func_rst_raw_n),
     .physs_hlp_xlgmii0_rxc_0(physs_hlp_xlgmii1_rxc_2),
     .physs_hlp_xlgmii0_rxd_0(physs_hlp_xlgmii1_rxd_2),
     .physs_hlp_xlgmii0_rxt0_next_0(physs_hlp_xlgmii1_rxt0_next_2),
     .physs_hlp_xlgmii0_rxclk_ena_0(physs_hlp_xlgmii1_rxclk_ena_2),
     .hlp_xlgmii0_rxc_0(hlp_xlgmii1_rxc_2),
     .hlp_xlgmii0_rxd_0(hlp_xlgmii1_rxd_2),
     .hlp_xlgmii0_rxt0_next_0(hlp_xlgmii1_rxt0_next_2),
     .hlp_xlgmii0_rxclk_ena_0(hlp_xlgmii1_rxclk_ena_2),
     .physs_hlp_xlgmii0_txclk_ena_0(physs_hlp_xlgmii1_txclk_ena_2),
     .hlp_xlgmii0_txclk_ena_0(hlp_xlgmii1_txclk_ena_2),
     .hlp_port4_xlgmii_tx_data(hlp_xlgmii1_txd_2),
     .hlp_port4_xlgmii_tx_c(hlp_xlgmii1_txc_2),
     .hlp_xlgmii0_txd_0(hlp_physs_xlgmii1_txd_2),
     .hlp_xlgmii0_txc_0(hlp_physs_xlgmii1_txc_2)
 ) ; 

xlgmii_cdc_wrapper xlgmii2_cdc_pquad0 (
     .rd_clk(rd_clk_pquad),
     .wr_clk(tsu_clk),
     .rstn(physs0_func_rst_raw_n),
     .physs_hlp_xlgmii0_rxc_0(physs_hlp_xlgmii2_rxc_2),
     .physs_hlp_xlgmii0_rxd_0(physs_hlp_xlgmii2_rxd_2),
     .physs_hlp_xlgmii0_rxt0_next_0(physs_hlp_xlgmii2_rxt0_next_2),
     .physs_hlp_xlgmii0_rxclk_ena_0(physs_hlp_xlgmii2_rxclk_ena_2),
     .hlp_xlgmii0_rxc_0(hlp_xlgmii2_rxc_2),
     .hlp_xlgmii0_rxd_0(hlp_xlgmii2_rxd_2),
     .hlp_xlgmii0_rxt0_next_0(hlp_xlgmii2_rxt0_next_2),
     .hlp_xlgmii0_rxclk_ena_0(hlp_xlgmii2_rxclk_ena_2),
     .physs_hlp_xlgmii0_txclk_ena_0(physs_hlp_xlgmii2_txclk_ena_2),
     .hlp_xlgmii0_txclk_ena_0(hlp_xlgmii2_txclk_ena_2),
     .hlp_port4_xlgmii_tx_data(hlp_xlgmii2_txd_2),
     .hlp_port4_xlgmii_tx_c(hlp_xlgmii2_txc_2),
     .hlp_xlgmii0_txd_0(hlp_physs_xlgmii2_txd_2),
     .hlp_xlgmii0_txc_0(hlp_physs_xlgmii2_txc_2)
 ) ; 

xlgmii_cdc_wrapper xlgmii3_cdc_pquad0 (
     .rd_clk(rd_clk_pquad),
     .wr_clk(tsu_clk),
     .rstn(physs0_func_rst_raw_n),
     .physs_hlp_xlgmii0_rxc_0(physs_hlp_xlgmii3_rxc_2),
     .physs_hlp_xlgmii0_rxd_0(physs_hlp_xlgmii3_rxd_2),
     .physs_hlp_xlgmii0_rxt0_next_0(physs_hlp_xlgmii3_rxt0_next_2),
     .physs_hlp_xlgmii0_rxclk_ena_0(physs_hlp_xlgmii3_rxclk_ena_2),
     .hlp_xlgmii0_rxc_0(hlp_xlgmii3_rxc_2),
     .hlp_xlgmii0_rxd_0(hlp_xlgmii3_rxd_2),
     .hlp_xlgmii0_rxt0_next_0(hlp_xlgmii3_rxt0_next_2),
     .hlp_xlgmii0_rxclk_ena_0(hlp_xlgmii3_rxclk_ena_2),
     .physs_hlp_xlgmii0_txclk_ena_0(physs_hlp_xlgmii3_txclk_ena_2),
     .hlp_xlgmii0_txclk_ena_0(hlp_xlgmii3_txclk_ena_2),
     .hlp_port4_xlgmii_tx_data(hlp_xlgmii3_txd_2),
     .hlp_port4_xlgmii_tx_c(hlp_xlgmii3_txc_2),
     .hlp_xlgmii0_txd_0(hlp_physs_xlgmii3_txd_2),
     .hlp_xlgmii0_txc_0(hlp_physs_xlgmii3_txc_2)
 ) ; 

// CDC: PQUAD1 XLGMII CDC Instances (4 interfaces with suffix _3)
xlgmii_cdc_wrapper xlgmii0_cdc_pquad1 (
     .rd_clk(rd_clk_pquad1),
     .wr_clk(tsu_clk),
     .rstn(physs0_func_rst_raw_n),
     .physs_hlp_xlgmii0_rxc_0(physs_hlp_xlgmii0_rxc_3),
     .physs_hlp_xlgmii0_rxd_0(physs_hlp_xlgmii0_rxd_3),
     .physs_hlp_xlgmii0_rxt0_next_0(physs_hlp_xlgmii0_rxt0_next_3),
     .physs_hlp_xlgmii0_rxclk_ena_0(physs_hlp_xlgmii0_rxclk_ena_3),
     .hlp_xlgmii0_rxc_0(hlp_xlgmii0_rxc_3),
     .hlp_xlgmii0_rxd_0(hlp_xlgmii0_rxd_3),
     .hlp_xlgmii0_rxt0_next_0(hlp_xlgmii0_rxt0_next_3),
     .hlp_xlgmii0_rxclk_ena_0(hlp_xlgmii0_rxclk_ena_3),
     .physs_hlp_xlgmii0_txclk_ena_0(physs_hlp_xlgmii0_txclk_ena_3),
     .hlp_xlgmii0_txclk_ena_0(hlp_xlgmii0_txclk_ena_3),
     .hlp_port4_xlgmii_tx_data(hlp_xlgmii0_txd_3),
     .hlp_port4_xlgmii_tx_c(hlp_xlgmii0_txc_3),
     .hlp_xlgmii0_txd_0(hlp_physs_xlgmii0_txd_3),
     .hlp_xlgmii0_txc_0(hlp_physs_xlgmii0_txc_3)
 ) ; 

xlgmii_cdc_wrapper xlgmii1_cdc_pquad1 (
     .rd_clk(rd_clk_pquad1),
     .wr_clk(tsu_clk),
     .rstn(physs0_func_rst_raw_n),
     .physs_hlp_xlgmii0_rxc_0(physs_hlp_xlgmii1_rxc_3),
     .physs_hlp_xlgmii0_rxd_0(physs_hlp_xlgmii1_rxd_3),
     .physs_hlp_xlgmii0_rxt0_next_0(physs_hlp_xlgmii1_rxt0_next_3),
     .physs_hlp_xlgmii0_rxclk_ena_0(physs_hlp_xlgmii1_rxclk_ena_3),
     .hlp_xlgmii0_rxc_0(hlp_xlgmii1_rxc_3),
     .hlp_xlgmii0_rxd_0(hlp_xlgmii1_rxd_3),
     .hlp_xlgmii0_rxt0_next_0(hlp_xlgmii1_rxt0_next_3),
     .hlp_xlgmii0_rxclk_ena_0(hlp_xlgmii1_rxclk_ena_3),
     .physs_hlp_xlgmii0_txclk_ena_0(physs_hlp_xlgmii1_txclk_ena_3),
     .hlp_xlgmii0_txclk_ena_0(hlp_xlgmii1_txclk_ena_3),
     .hlp_port4_xlgmii_tx_data(hlp_xlgmii1_txd_3),
     .hlp_port4_xlgmii_tx_c(hlp_xlgmii1_txc_3),
     .hlp_xlgmii0_txd_0(hlp_physs_xlgmii1_txd_3),
     .hlp_xlgmii0_txc_0(hlp_physs_xlgmii1_txc_3)
 ) ; 

xlgmii_cdc_wrapper xlgmii2_cdc_pquad1 (
     .rd_clk(rd_clk_pquad1),
     .wr_clk(tsu_clk),
     .rstn(physs0_func_rst_raw_n),
     .physs_hlp_xlgmii0_rxc_0(physs_hlp_xlgmii2_rxc_3),
     .physs_hlp_xlgmii0_rxd_0(physs_hlp_xlgmii2_rxd_3),
     .physs_hlp_xlgmii0_rxt0_next_0(physs_hlp_xlgmii2_rxt0_next_3),
     .physs_hlp_xlgmii0_rxclk_ena_0(physs_hlp_xlgmii2_rxclk_ena_3),
     .hlp_xlgmii0_rxc_0(hlp_xlgmii2_rxc_3),
     .hlp_xlgmii0_rxd_0(hlp_xlgmii2_rxd_3),
     .hlp_xlgmii0_rxt0_next_0(hlp_xlgmii2_rxt0_next_3),
     .hlp_xlgmii0_rxclk_ena_0(hlp_xlgmii2_rxclk_ena_3),
     .physs_hlp_xlgmii0_txclk_ena_0(physs_hlp_xlgmii2_txclk_ena_3),
     .hlp_xlgmii0_txclk_ena_0(hlp_xlgmii2_txclk_ena_3),
     .hlp_port4_xlgmii_tx_data(hlp_xlgmii2_txd_3),
     .hlp_port4_xlgmii_tx_c(hlp_xlgmii2_txc_3),
     .hlp_xlgmii0_txd_0(hlp_physs_xlgmii2_txd_3),
     .hlp_xlgmii0_txc_0(hlp_physs_xlgmii2_txc_3)
 ) ; 

xlgmii_cdc_wrapper xlgmii3_cdc_pquad1 (
     .rd_clk(rd_clk_pquad1),
     .wr_clk(tsu_clk),
     .rstn(physs0_func_rst_raw_n),
     .physs_hlp_xlgmii0_rxc_0(physs_hlp_xlgmii3_rxc_3),
     .physs_hlp_xlgmii0_rxd_0(physs_hlp_xlgmii3_rxd_3),
     .physs_hlp_xlgmii0_rxt0_next_0(physs_hlp_xlgmii3_rxt0_next_3),
     .physs_hlp_xlgmii0_rxclk_ena_0(physs_hlp_xlgmii3_rxclk_ena_3),
     .hlp_xlgmii0_rxc_0(hlp_xlgmii3_rxc_3),
     .hlp_xlgmii0_rxd_0(hlp_xlgmii3_rxd_3),
     .hlp_xlgmii0_rxt0_next_0(hlp_xlgmii3_rxt0_next_3),
     .hlp_xlgmii0_rxclk_ena_0(hlp_xlgmii3_rxclk_ena_3),
     .physs_hlp_xlgmii0_txclk_ena_0(physs_hlp_xlgmii3_txclk_ena_3),
     .hlp_xlgmii0_txclk_ena_0(hlp_xlgmii3_txclk_ena_3),
     .hlp_port4_xlgmii_tx_data(hlp_xlgmii3_txd_3),
     .hlp_port4_xlgmii_tx_c(hlp_xlgmii3_txc_3),
     .hlp_xlgmii0_txd_0(hlp_physs_xlgmii3_txd_3),
     .hlp_xlgmii0_txc_0(hlp_physs_xlgmii3_txc_3)
 ) ; 

// EDIT_INSTANCE END
endmodule
