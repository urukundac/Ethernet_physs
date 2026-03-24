/*------------------------------------------------------------------------------
  INTEL CONFIDENTIAL
  Copyright 2022 Intel Corporation All Rights Reserved.
  -----------------------------------------------------------------------------*/

module physs_bbl
// EDIT_PORT BEGIN
 ( 
input physs_func_rst_raw_n, //functional reset to PHYSS (LINKR). Should use for MEM init
input physs_reset_prep_req, //Request to PHYSS to prepare before CORE reset for clearing the pipe interface with mse.
output physs_reset_prep_ack, //Acknowledge from PHYSS that the interface is ready for CORE reset
input physs_func_clk, //PCS and MAC data path clock (931.25MHz)
input physs_funcx2_clk, //MAC and PCS clock for 800 Mhz operaion (1.6 Ghz)
input physs_intf0_clk, //MAC Interface clock (1.35Ghz)
input soc_per_clk, //control and configuration clock (112.5MHz)
input timeref_clk, //1588 clock (800MHz)
output [1:0] physs_synce_rxclk, //Rx recovered clock divided for syncE . Expose 2 clocks selected from 8 lanes when link is stable. The maximum frequancy of this clock is 150Mhz
output physs_o_ref_clk_out, //Digital reference clock output from SERDES (single ended (156.25Mhz) . To used by top level PLLs as REFCLK
inout eref0_pad_clk_p, //Differential signal along with ref0_pad_clk_p. Reference clock bumped to SERDES. STAR connected at PKG with ref0_pad_clk_p
inout eref0_pad_clk_m, //Differential signal along with ref0_pad_clk_m. Reference clock bumped to SERDES. STAR connected at PKG with ref0_pad_clk_m
inout syncE_pad_clk_p, //Differential signal along with ref1_pad_clk_p. Reference clock bumped to SERDES. STAR connected at PKG with ref1_pad_clk_p
inout syncE_pad_clk_m, //Differential signal along with ref1_pad_clk_m. Reference clock bumped to SERDES. STAR connected at PKG with ref1_pad_clk_m
input rclk_diff_p, //on die differential signal _p
input rclk_diff_n, //on die differential signal _n
output physs_clkobs_out_clk, //Output clock for observation
input syscon_dfd_l0_dis, //l0 DFD security disable (1 = disable)
input syscon_dfd_l1_dis, //l1 DFD security disable (1 = disable)
input syscon_Int_only_l2_dis, //l2 DFD security disable (1 = disable)
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
inout [13:0] xioa_ck_pma_ref0_n, //Differential reference clock0 bump/pad. negative leg
inout [13:0] xioa_ck_pma_ref0_p, //Differential reference clock0 bump/pad. positive leg
inout [15:0] xioa_ck_pma_ref1_n, //Differential reference clock1 bump/pad. negative leg
inout [15:0] xioa_ck_pma_ref1_p, //Differential reference clock1 bump/pad. positive leg
output [15:0] xoa_pma_dcmon1, //Aprobe bump /pad #1. Refer to aprobe recommendations section of the HAS
output [15:0] xoa_pma_dcmon2, //Aprobe bump/pad #2. Refer to aprobe recommendations section of the HAS
input [14:0] physs_0_AWID, //Write Address ID
input [31:0] physs_0_AWADDR, //Write Address
input [7:0] physs_0_AWLEN, //Burst Length
input [2:0] physs_0_AWSIZE, //b
input [1:0] physs_0_AWBURST, //Burst Type
input physs_0_AWLOCK, //Lock Type
input [3:0] physs_0_AWCACHE, //Memory Type
input [2:0] physs_0_AWPROT, //Protection Type
input [3:0] physs_0_AWQOS, //QoS
input physs_0_AWUSER, //User-defined Signal. PHYSS does not have functional usage of this signal but it might be used for debug.
input physs_0_AWVALID, //Write Address Valid
output physs_0_AWREADY, //Write Address Readu
input [31:0] physs_0_WDATA, //Write data
input [3:0] physs_0_WSTRB, //Write strobe
input physs_0_WLAST, //Write last
input physs_0_WUSER, //User-defined signal. PHYSS does not have functional usage of this signal but it might be used for debug.
input physs_0_WVALID, //Write valid
output physs_0_WREADY, //Write ready
output [14:0] physs_0_BID, //Response ID Tag
output [1:0] physs_0_BRESP, //Write Response
output physs_0_BVALID, //Write response valid
input physs_0_BREADY, //Response ready
input [14:0] physs_0_ARID, //Read Address ID
input [31:0] physs_0_ARADDR, //Read Address
input [7:0] physs_0_ARLEN, //Burst Length
input [2:0] physs_0_ARSIZE, //Burst Size
input [1:0] physs_0_ARBURST, //Burst Type
input physs_0_ARLOCK, //Lock Type
input [3:0] physs_0_ARCACHE, //Memory Type
input [2:0] physs_0_ARPROT, //Protection Type
input physs_0_ARVALID, //Read Address Valid
output physs_0_ARREADY, //Read Address Ready
output [14:0] physs_0_RID, //Read ID tag
output [31:0] physs_0_RDATA, //Read data
output [1:0] physs_0_RRESP, //Read response
output physs_0_RLAST, //Read last
output physs_0_RVALID, //Read valid
input physs_0_RREADY, //Read ready
input [14:0] physs_1_AWID, //Write Address ID
input [31:0] physs_1_AWADDR, //Write Address
input [7:0] physs_1_AWLEN, //Burst Length
input [2:0] physs_1_AWSIZE, //b
input [1:0] physs_1_AWBURST, //Burst Type
input physs_1_AWLOCK, //Lock Type
input [3:0] physs_1_AWCACHE, //Memory Type
input [2:0] physs_1_AWPROT, //Protection Type
input [3:0] physs_1_AWQOS, //QoS
input physs_1_AWUSER, //User-defined Signal. PHYSS does not have functional usage of this signal but it might be used for debug.
input physs_1_AWVALID, //Write Address Valid
output physs_1_AWREADY, //Write Address Readu
input [31:0] physs_1_WDATA, //Write data
input [3:0] physs_1_WSTRB, //Write strobe
input physs_1_WLAST, //Write last
input physs_1_WUSER, //User-defined signal. PHYSS does not have functional usage of this signal but it might be used for debug.
input physs_1_WVALID, //Write valid
output physs_1_WREADY, //Write ready
output [14:0] physs_1_BID, //Response ID Tag
output [1:0] physs_1_BRESP, //Write Response
output physs_1_BVALID, //Write response valid
input physs_1_BREADY, //Response ready
input [14:0] physs_1_ARID, //Read Address ID
input [31:0] physs_1_ARADDR, //Read Address
input [7:0] physs_1_ARLEN, //Burst Length
input [2:0] physs_1_ARSIZE, //Burst Size
input [1:0] physs_1_ARBURST, //Burst Type
input physs_1_ARLOCK, //Lock Type
input [3:0] physs_1_ARCACHE, //Memory Type
input [2:0] physs_1_ARPROT, //Protection Type
input physs_1_ARVALID, //Read Address Valid
output physs_1_ARREADY, //Read Address Ready
output [14:0] physs_1_RID, //Read ID tag
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
output [38:0] physs_mse_port_0_rx_ts, //Receive Timestamp Value. Time when the MAC detected the SFD of the frame and latched the mac00N_frc_in_rx value. Only meaningful when sop is valid. On ingress contains the 1588 ingress timestamp: Bits [39:8] - 32b timestamp in nano seconds. Bits [7:1] - 7b timestamp in sub-nano seconds. Bit 0 - 1b of valid for TIMESTAMP
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
output [1023:0] physs_mse_port_1_rx_data, //receive data rx_data[1023:0] are valid in 400G mode or 200G mode at Port0. receive data rx_data[511:0] are valid in 200G mode at Port2/4. receive data rx_data[255:0] are valid in 100/50/25/10G mode. Port0 use 1024 bits for 400g.512 bitsfor200gor 256 bits for 100g and lower speeds. Port2/4 use 512 bits for 200g or 256 bits for 100g and lower speeds. Ports 1/3/5/6/7 are always 256 bits data width
output physs_mse_port_1_rx_sop, //Receive Start of Frame
output physs_mse_port_1_rx_eop, //Receive End of Frame
output [6:0] physs_mse_port_1_rx_mod, //Receive End Word Modulo. Only meaningful when eop signal is valid. Indicates which portion of the rx_data is valid. rx_mod[6:0] ( 400G / 200G Port0). 7'b0000000 : rx_data[1023:0] is valid. 7'b0000001 : rx_data[7:0] is valid. 7'b0000010 : rx_data[15:0] is valid. 7'b1111111:rx_data[1015:0] is valid. rx_mod[5:0] ( 200G ). 6'b000000 : rx_data[511:0] is valid. 6'b000001 : rx_data[7:0] is valid. 6'b000010 : rx_data[15:0] is valid. 6'b111111:rx_data[503:0] is valid. rx_mod[4:0] ( 100G or below ). 5'b00000 : rx_data[255:0] is valid. 5'b00001 : rx_data[7:0] is valid. 5'b00010 : rx_data[15:0] is valid. 5'b11111:rx_data[247:0] is valid
output physs_mse_port_1_rx_err, //Receive frame error ( This is set when there is any type of error within the frame include L2 FCS Error )
output physs_mse_port_1_rx_ecc_err, //Receive L2 FCS Error ( this bit is only set when there is L2 FCS error )
input mse_physs_port_1_rx_rdy, //Receive Application Ready. Asserted (set to 1) by the Receive application to indicate it is ready to receive Data from the MAC. With the direct interface when the signal deasserts within frame receive the MAC will truncate the frame and eventually set receive frame error
output [38:0] physs_mse_port_1_rx_ts, //Receive Timestamp Value. Time when the MAC detected the SFD of the frame and latched the mac00N_frc_in_rx value. Only meaningful when sop is valid. On ingress contains the 1588 ingress timestamp: Bits [39:8] - 32b timestamp in nano seconds. Bits [7:1] - 7b timestamp in sub-nano seconds. Bit 0 - 1b of valid for TIMESTAMP
input mse_physs_port_1_tx_wren, //Transmit Data Write Enable
input [1023:0] mse_physs_port_1_tx_data, //Transmit data rx_data[1023:0] are valid in 400G mode and 200G mode at Port 0. Transmit data rx_data[511:0] are valid in 200G mode at Ports2/4. Transmit data rx_data[255:0] are valid in 100/50/25/10G mode. Port0 use 1024 bits for 400g. 512 bits for 200g or 256 bits for 100g and lower speeds. Port2/4 use 512 bits for 200g or 256 bits for 100g and lower speeds. Ports 1/3/5/6/7 are always 256 bits data width
input mse_physs_port_1_tx_sop, //Transmit Start of Frame
input mse_physs_port_1_tx_eop, //Transmit End of Frame
input [6:0] mse_physs_port_1_tx_mod, //Transmit End Word Modulo. Only meaningful when tx_eop is valid. Indicates which portion of the ff00N_tx_data is valid. tx_mod[6:0] (400G mode / 200G at Port0). 7'b000000 : tx_data[1023:0] is valid. 7'b000001 : tx_data[7:0] is valid. 7'b000010 : tx_data[15:0] is valid. 7'b111111 : tx_data[1015:0] is valid. tx_mod[5:0] ( 200G mode at Ports2/4 ). 6'b000000 : tx_data[511:0] is valid. 6'b000001 : tx_data[7:0] is valid. 6'b000010 : tx_data[15:0] is valid. 6'b111111:tx_data[503:0] is valid. tx_mod[4:0] ( 100G or below ). 5'b00000 : tx_data[255:0] is valid. 5'b00001 : tx_data[7:0] is valid. 5'b00010 : tx_data[15:0] is valid. 5'b11111 : tx_data[247:0] is valid
input mse_physs_port_1_tx_err, //Transmit Frame Error. Asserted with the frames final segment to indicate that the transmitted frame is invalid. Only meaningful whentx_eopis valid. Whentx_erris asserted the frame is transmitted to the CDMII interface with a transmit error (invalid CRC)
input mse_physs_port_1_tx_crc, //Transmit CRC Append. If set a CRC field the MAC will be appended to the frame. If cleared the MAC does not append a FCS to the frame
output physs_mse_port_1_tx_rdy, //Transmit FIFO ready. mse can write words into the FIFO only when this signal is asserted (1). When 0 application should stop writing latest after 2 cycles
output physs_icq_port_2_link_stat, //indicate link UP status per port
output [3:0] physs_mse_port_2_link_speed, //4 wires for each of 8 ports. Indicate speed when link UP status is asserted -per port.0 - 10Mbps1 - 100Mbps2 - 1Gbps3 - 2.5Gbps4 - 5Gbps5 - 10Gbps6 - Reserved7 - 25Gbps8 - 40Gbps9 - 50Gbps10 - 100Gbps11 - 200Gbps12 - 400Gbpsother - reserved.
output physs_mse_port_2_rx_dval, //Receive Data Valid
output [1023:0] physs_mse_port_2_rx_data, //receive data rx_data[1023:0] are valid in 400G mode or 200G mode at Port0. receive data rx_data[511:0] are valid in 200G mode at Port2/4. receive data rx_data[255:0] are valid in 100/50/25/10G mode. Port0 use 1024 bits for 400g.512 bitsfor200gor 256 bits for 100g and lower speeds. Port2/4 use 512 bits for 200g or 256 bits for 100g and lower speeds. Ports 1/3/5/6/7 are always 256 bits data width
output physs_mse_port_2_rx_sop, //Receive Start of Frame
output physs_mse_port_2_rx_eop, //Receive End of Frame
output [6:0] physs_mse_port_2_rx_mod, //Receive End Word Modulo. Only meaningful when eop signal is valid. Indicates which portion of the rx_data is valid. rx_mod[6:0] ( 400G / 200G Port0). 7'b0000000 : rx_data[1023:0] is valid. 7'b0000001 : rx_data[7:0] is valid. 7'b0000010 : rx_data[15:0] is valid. 7'b1111111:rx_data[1015:0] is valid. rx_mod[5:0] ( 200G ). 6'b000000 : rx_data[511:0] is valid. 6'b000001 : rx_data[7:0] is valid. 6'b000010 : rx_data[15:0] is valid. 6'b111111:rx_data[503:0] is valid. rx_mod[4:0] ( 100G or below ). 5'b00000 : rx_data[255:0] is valid. 5'b00001 : rx_data[7:0] is valid. 5'b00010 : rx_data[15:0] is valid. 5'b11111:rx_data[247:0] is valid
output physs_mse_port_2_rx_err, //Receive frame error ( This is set when there is any type of error within the frame include L2 FCS Error )
output physs_mse_port_2_rx_ecc_err, //Receive L2 FCS Error ( this bit is only set when there is L2 FCS error )
input mse_physs_port_2_rx_rdy, //Receive Application Ready. Asserted (set to 1) by the Receive application to indicate it is ready to receive Data from the MAC. With the direct interface when the signal deasserts within frame receive the MAC will truncate the frame and eventually set receive frame error
output [38:0] physs_mse_port_2_rx_ts, //Receive Timestamp Value. Time when the MAC detected the SFD of the frame and latched the mac00N_frc_in_rx value. Only meaningful when sop is valid. On ingress contains the 1588 ingress timestamp: Bits [39:8] - 32b timestamp in nano seconds. Bits [7:1] - 7b timestamp in sub-nano seconds. Bit 0 - 1b of valid for TIMESTAMP
input mse_physs_port_2_tx_wren, //Transmit Data Write Enable
input [1023:0] mse_physs_port_2_tx_data, //Transmit data rx_data[1023:0] are valid in 400G mode and 200G mode at Port 0. Transmit data rx_data[511:0] are valid in 200G mode at Ports2/4. Transmit data rx_data[255:0] are valid in 100/50/25/10G mode. Port0 use 1024 bits for 400g. 512 bits for 200g or 256 bits for 100g and lower speeds. Port2/4 use 512 bits for 200g or 256 bits for 100g and lower speeds. Ports 1/3/5/6/7 are always 256 bits data width
input mse_physs_port_2_tx_sop, //Transmit Start of Frame
input mse_physs_port_2_tx_eop, //Transmit End of Frame
input [6:0] mse_physs_port_2_tx_mod, //Transmit End Word Modulo. Only meaningful when tx_eop is valid. Indicates which portion of the ff00N_tx_data is valid. tx_mod[6:0] (400G mode / 200G at Port0). 7'b000000 : tx_data[1023:0] is valid. 7'b000001 : tx_data[7:0] is valid. 7'b000010 : tx_data[15:0] is valid. 7'b111111 : tx_data[1015:0] is valid. tx_mod[5:0] ( 200G mode at Ports2/4 ). 6'b000000 : tx_data[511:0] is valid. 6'b000001 : tx_data[7:0] is valid. 6'b000010 : tx_data[15:0] is valid. 6'b111111:tx_data[503:0] is valid. tx_mod[4:0] ( 100G or below ). 5'b00000 : tx_data[255:0] is valid. 5'b00001 : tx_data[7:0] is valid. 5'b00010 : tx_data[15:0] is valid. 5'b11111 : tx_data[247:0] is valid
input mse_physs_port_2_tx_err, //Transmit Frame Error. Asserted with the frames final segment to indicate that the transmitted frame is invalid. Only meaningful whentx_eopis valid. Whentx_erris asserted the frame is transmitted to the CDMII interface with a transmit error (invalid CRC)
input mse_physs_port_2_tx_crc, //Transmit CRC Append. If set a CRC field the MAC will be appended to the frame. If cleared the MAC does not append a FCS to the frame
output physs_mse_port_2_tx_rdy, //Transmit FIFO ready. mse can write words into the FIFO only when this signal is asserted (1). When 0 application should stop writing latest after 2 cycles
output physs_icq_port_3_link_stat, //indicate link UP status per port
output [3:0] physs_mse_port_3_link_speed, //4 wires for each of 8 ports. Indicate speed when link UP status is asserted -per port.0 - 10Mbps1 - 100Mbps2 - 1Gbps3 - 2.5Gbps4 - 5Gbps5 - 10Gbps6 - Reserved7 - 25Gbps8 - 40Gbps9 - 50Gbps10 - 100Gbps11 - 200Gbps12 - 400Gbpsother - reserved.
output physs_mse_port_3_rx_dval, //Receive Data Valid
output [1023:0] physs_mse_port_3_rx_data, //receive data rx_data[1023:0] are valid in 400G mode or 200G mode at Port0. receive data rx_data[511:0] are valid in 200G mode at Port2/4. receive data rx_data[255:0] are valid in 100/50/25/10G mode. Port0 use 1024 bits for 400g.512 bitsfor200gor 256 bits for 100g and lower speeds. Port2/4 use 512 bits for 200g or 256 bits for 100g and lower speeds. Ports 1/3/5/6/7 are always 256 bits data width
output physs_mse_port_3_rx_sop, //Receive Start of Frame
output physs_mse_port_3_rx_eop, //Receive End of Frame
output [6:0] physs_mse_port_3_rx_mod, //Receive End Word Modulo. Only meaningful when eop signal is valid. Indicates which portion of the rx_data is valid. rx_mod[6:0] ( 400G / 200G Port0). 7'b0000000 : rx_data[1023:0] is valid. 7'b0000001 : rx_data[7:0] is valid. 7'b0000010 : rx_data[15:0] is valid. 7'b1111111:rx_data[1015:0] is valid. rx_mod[5:0] ( 200G ). 6'b000000 : rx_data[511:0] is valid. 6'b000001 : rx_data[7:0] is valid. 6'b000010 : rx_data[15:0] is valid. 6'b111111:rx_data[503:0] is valid. rx_mod[4:0] ( 100G or below ). 5'b00000 : rx_data[255:0] is valid. 5'b00001 : rx_data[7:0] is valid. 5'b00010 : rx_data[15:0] is valid. 5'b11111:rx_data[247:0] is valid
output physs_mse_port_3_rx_err, //Receive frame error ( This is set when there is any type of error within the frame include L2 FCS Error )
output physs_mse_port_3_rx_ecc_err, //Receive L2 FCS Error ( this bit is only set when there is L2 FCS error )
input mse_physs_port_3_rx_rdy, //Receive Application Ready. Asserted (set to 1) by the Receive application to indicate it is ready to receive Data from the MAC. With the direct interface. when the signal deasserts within frame receive the MAC will truncate the frame and eventually set receive frame error
output [38:0] physs_mse_port_3_rx_ts, //Receive Timestamp Value. Time when the MAC detected the SFD of the frame and latched the mac00N_frc_in_rx value. Only meaningful when sop is valid. On ingress contains the 1588 ingress timestamp: Bits [39:8] - 32b timestamp in nano seconds. Bits [7:1] - 7b timestamp in sub-nano seconds. Bit 0 - 1b of valid for TIMESTAMP
input mse_physs_port_3_tx_wren, //Transmit Data Write Enable
input [1023:0] mse_physs_port_3_tx_data, //Transmit data rx_data[1023:0] are valid in 400G mode and 200G mode at Port 0. Transmit data rx_data[511:0] are valid in 200G mode at Ports2/4. Transmit data rx_data[255:0] are valid in 100/50/25/10G mode. Port0 use 1024 bits for 400g. 512 bits for 200g or 256 bits for 100g and lower speeds. Port2/4 use 512 bits for 200g or 256 bits for 100g and lower speeds. Ports 1/3/5/6/7 are always 256 bits data width
input mse_physs_port_3_tx_sop, //Transmit Start of Frame
input mse_physs_port_3_tx_eop, //Transmit End of Frame
input [6:0] mse_physs_port_3_tx_mod, //Transmit End Word Modulo. Only meaningful when tx_eop is valid. Indicates which portion of the ff00N_tx_data is valid. tx_mod[6:0] (400G mode / 200G at Port0). 7'b000000 : tx_data[1023:0] is valid. 7'b000001 : tx_data[7:0] is valid. 7'b000010 : tx_data[15:0] is valid. 7'b111111 : tx_data[1015:0] is valid. tx_mod[5:0] ( 200G mode at Ports2/4 ). 6'b000000 : tx_data[511:0] is valid. 6'b000001 : tx_data[7:0] is valid. 6'b000010 : tx_data[15:0] is valid. 6'b111111:tx_data[503:0] is valid. tx_mod[4:0] ( 100G or below ). 5'b00000 : tx_data[255:0] is valid. 5'b00001 : tx_data[7:0] is valid. 5'b00010 : tx_data[15:0] is valid. 5'b11111 : tx_data[247:0] is valid
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
output [38:0] physs_mse_port_4_rx_ts, //Receive Timestamp Value. Time when the MAC detected the SFD of the frame and latched the mac00N_frc_in_rx value. Only meaningful when sop is valid. On ingress contains the 1588 ingress timestamp: Bits [39:8] - 32b timestamp in nano seconds. Bits [7:1] - 7b timestamp in sub-nano seconds. Bit 0 - 1b of valid for TIMESTAMP
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
output [1023:0] physs_mse_port_5_rx_data, //receive data rx_data[1023:0] are valid in 400G mode or 200G mode at Port0. receive data rx_data[511:0] are valid in 200G mode at Port2/4. receive data rx_data[255:0] are valid in 100/50/25/10G mode. Port0 use 1024 bits for 400g.512 bitsfor200gor 256 bits for 100g and lower speeds. Port2/4 use 512 bits for 200g or 256 bits for 100g and lower speeds. Ports 1/3/5/6/7 are always 256 bits data width
output physs_mse_port_5_rx_sop, //Receive Start of Frame
output physs_mse_port_5_rx_eop, //Receive End of Frame
output [6:0] physs_mse_port_5_rx_mod, //Receive End Word Modulo. Only meaningful when eop signal is valid. Indicates which portion of the rx_data is valid. rx_mod[6:0] ( 400G / 200G Port0). 7'b0000000 : rx_data[1023:0] is valid. 7'b0000001 : rx_data[7:0] is valid. 7'b0000010 : rx_data[15:0] is valid. 7'b1111111:rx_data[1015:0] is valid. rx_mod[5:0] ( 200G ). 6'b000000 : rx_data[511:0] is valid. 6'b000001 : rx_data[7:0] is valid. 6'b000010 : rx_data[15:0] is valid. 6'b111111:rx_data[503:0] is valid. rx_mod[4:0] ( 100G or below ). 5'b00000 : rx_data[255:0] is valid. 5'b00001 : rx_data[7:0] is valid. 5'b00010 : rx_data[15:0] is valid. 5'b11111:rx_data[247:0] is valid
output physs_mse_port_5_rx_err, //Receive frame error ( This is set when there is any type of error within the frame include L2 FCS Error )
output physs_mse_port_5_rx_ecc_err, //Receive L2 FCS Error ( this bit is only set when there is L2 FCS error )
input mse_physs_port_5_rx_rdy, //Receive Application Ready. Asserted (set to 1) by the Receive application to indicate it is ready to receive Data from the MAC. With the direct interface when the signal deasserts within frame receive the MAC will truncate the frame and eventually set receive frame error
output [38:0] physs_mse_port_5_rx_ts, //Receive Timestamp Value. Time when the MAC detected the SFD of the frame and latched the mac00N_frc_in_rx value. Only meaningful when sop is valid. On ingress contains the 1588 ingress timestamp: Bits [39:8] - 32b timestamp in nano seconds. Bits [7:1] - 7b timestamp in sub-nano seconds. Bit 0 - 1b of valid for TIMESTAMP
input mse_physs_port_5_tx_wren, //Transmit Data Write Enable
input [1023:0] mse_physs_port_5_tx_data, //Transmit data rx_data[1023:0] are valid in 400G mode and 200G mode at Port 0. Transmit data rx_data[511:0] are valid in 200G mode at Ports2/4. Transmit data rx_data[255:0] are valid in 100/50/25/10G mode. Port0 use 1024 bits for 400g 512 bits for 200g or 256 bits for 100g and lower speeds. Port2/4 use 512 bits for 200g or 256 bits for 100g and lower speeds. Ports 1/3/5/6/7 are always 256 bits data width
input mse_physs_port_5_tx_sop, //Transmit Start of Frame
input mse_physs_port_5_tx_eop, //Transmit End of Frame
input [6:0] mse_physs_port_5_tx_mod, //Transmit End Word Modulo. Only meaningful when tx_eop is valid. Indicates which portion of the ff00N_tx_data is valid. tx_mod[6:0] (400G mode / 200G at Port0). 7'b000000 : tx_data[1023:0] is valid. 7'b000001 : tx_data[7:0] is valid. 7'b000010 : tx_data[15:0] is valid. 7'b111111 : tx_data[1015:0] is valid. tx_mod[5:0] ( 200G mode at Ports2/4 ). 6'b000000 : tx_data[511:0] is valid. 6'b000001 : tx_data[7:0] is valid. 6'b000010 : tx_data[15:0] is valid. 6'b111111:tx_data[503:0] is valid. tx_mod[4:0] ( 100G or below ). 5'b00000 : tx_data[255:0] is valid. 5'b00001 : tx_data[7:0] is valid. 5'b00010 : tx_data[15:0] is valid. 5'b11111 : tx_data[247:0] is valid
input mse_physs_port_5_tx_err, //Transmit Frame Error. Asserted with the frames final segment to indicate that the transmitted frame is invalid. Only meaningful whentx_eopis valid. Whentx_erris asserted the frame is transmitted to the CDMII interface with a transmit error (invalid CRC)
input mse_physs_port_5_tx_crc, //Transmit CRC Append. If set a CRC field the MAC will be appended to the frame. If cleared the MAC does not append a FCS to the frame
output physs_mse_port_5_tx_rdy, //Transmit FIFO ready. mse can write words into the FIFO only when this signal is asserted (1). When 0 application should stop writing latest after 2 cycles
output physs_icq_port_6_link_stat, //indicate link UP status per port
output [3:0] physs_mse_port_6_link_speed, //4 wires for each of 8 ports. Indicate speed when link UP status is asserted -per port.0 - 10Mbps1 - 100Mbps2 - 1Gbps3 - 2.5Gbps4 - 5Gbps5 - 10Gbps6 - Reserved7 - 25Gbps8 - 40Gbps9 - 50Gbps10 - 100Gbps11 - 200Gbps12 - 400Gbpsother - reserved.
output physs_mse_port_6_rx_dval, //Receive Data Valid
output [1023:0] physs_mse_port_6_rx_data, //receive data rx_data[1023:0] are valid in 400G mode or 200G mode at Port0. receive data rx_data[511:0] are valid in 200G mode at Port2/4. receive data rx_data[255:0] are valid in 100/50/25/10G mode. Port0 use 1024 bits for 400g512 bitsfor200gor 256 bits for 100g and lower speeds. Port2/4 use 512 bits for 200g or 256 bits for 100g and lower speeds. Ports 1/3/5/6/7 are always 256 bits data width
output physs_mse_port_6_rx_sop, //Receive Start of Frame
output physs_mse_port_6_rx_eop, //Receive End of Frame
output [6:0] physs_mse_port_6_rx_mod, //Receive End Word Modulo. Only meaningful when eop signal is valid. Indicates which portion of the rx_data is valid. rx_mod[6:0] ( 400G / 200G Port0). 7'b0000000 : rx_data[1023:0] is valid. 7'b0000001 : rx_data[7:0] is valid. 7'b0000010 : rx_data[15:0] is valid. 7'b1111111:rx_data[1015:0] is valid. rx_mod[5:0] ( 200G ). 6'b000000 : rx_data[511:0] is valid. 6'b000001 : rx_data[7:0] is valid. 6'b000010 : rx_data[15:0] is valid. 6'b111111:rx_data[503:0] is valid. rx_mod[4:0] ( 100G or below ). 5'b00000 : rx_data[255:0] is valid. 5'b00001 : rx_data[7:0] is valid. 5'b00010 : rx_data[15:0] is valid. 5'b11111:rx_data[247:0] is valid
output physs_mse_port_6_rx_err, //Receive frame error ( This is set when there is any type of error within the frame include L2 FCS Error )
output physs_mse_port_6_rx_ecc_err, //Receive L2 FCS Error ( this bit is only set when there is L2 FCS error )
input mse_physs_port_6_rx_rdy, //Receive Application Ready. Asserted (set to 1) by the Receive application to indicate it is ready to receive Data from the MAC. With the direct interface when the signal deasserts within frame receive the MAC will truncate the frame and eventually set receive frame error
output [38:0] physs_mse_port_6_rx_ts, //Receive Timestamp Value. Time when the MAC detected the SFD of the frame and latched the mac00N_frc_in_rx value. Only meaningful when sop is valid. On ingress contains the 1588 ingress timestamp: Bits [39:8] - 32b timestamp in nano seconds. Bits [7:1] - 7b timestamp in sub-nano seconds. Bit 0 - 1b of valid for TIMESTAMP
input mse_physs_port_6_tx_wren, //Transmit Data Write Enable
input [1023:0] mse_physs_port_6_tx_data, //Transmit data rx_data[1023:0] are valid in 400G mode and 200G mode at Port 0. Transmit data rx_data[511:0] are valid in 200G mode at Ports2/4. Transmit data rx_data[255:0] are valid in 100/50/25/10G mode. Port0 use 1024 bits for 400g 512 bits for 200g or 256 bits for 100g and lower speeds. Port2/4 use 512 bits for 200g or 256 bits for 100g and lower speeds. Ports 1/3/5/6/7 are always 256 bits data width
input mse_physs_port_6_tx_sop, //Transmit Start of Frame
input mse_physs_port_6_tx_eop, //Transmit End of Frame
input [6:0] mse_physs_port_6_tx_mod, //Transmit End Word Modulo. Only meaningful when tx_eop is valid. Indicates which portion of the ff00N_tx_data is valid. tx_mod[6:0] (400G mode / 200G at Port0). 7'b000000 : tx_data[1023:0] is valid. 7'b000001 : tx_data[7:0] is valid. 7'b000010 : tx_data[15:0] is valid. 7'b111111 : tx_data[1015:0] is valid. tx_mod[5:0] ( 200G mode at Ports2/4 ). 6'b000000 : tx_data[511:0] is valid. 6'b000001 : tx_data[7:0] is valid. 6'b000010 : tx_data[15:0] is valid. 6'b111111:tx_data[503:0] is valid. tx_mod[4:0] ( 100G or below ). 5'b00000 : tx_data[255:0] is valid. 5'b00001 : tx_data[7:0] is valid. 5'b00010 : tx_data[15:0] is valid. 5'b11111 : tx_data[247:0] is valid
input mse_physs_port_6_tx_err, //Transmit Frame Error. Asserted with the frames final segment to indicate that the transmitted frame is invalid. Only meaningful whentx_eopis valid. Whentx_erris asserted the frame is transmitted to the CDMII interface with a transmit error (invalid CRC)
input mse_physs_port_6_tx_crc, //Transmit CRC Append. If set a CRC field the MAC will be appended to the frame. If cleared the MAC does not append a FCS to the frame
output physs_mse_port_6_tx_rdy, //Transmit FIFO ready. mse can write words into the FIFO only when this signal is asserted (1). When 0 application should stop writing latest after 2 cycles
output physs_icq_port_7_link_stat, //indicate link UP status per port
output [3:0] physs_mse_port_7_link_speed, //4 wires for each of 8 ports. Indicate speed when link UP status is asserted -per port.0 - 10Mbps1 - 100Mbps2 - 1Gbps3 - 2.5Gbps4 - 5Gbps5 - 10Gbps6 - Reserved7 - 25Gbps8 - 40Gbps9 - 50Gbps10 - 100Gbps11 - 200Gbps12 - 400Gbpsother - reserved.
output physs_mse_port_7_rx_dval, //Receive Data Valid
output [1023:0] physs_mse_port_7_rx_data, //receive data rx_data[1023:0] are valid in 400G mode or 200G mode at Port0. receive data rx_data[511:0] are valid in 200G mode at Port2/4. receive data rx_data[255:0] are valid in 100/50/25/10G mode. Port0 use 1024 bits for 400g512 bitsfor200gor 256 bits for 100g and lower speeds. Port2/4 use 512 bits for 200g or 256 bits for 100g and lower speeds. Ports 1/3/5/6/7 are always 256 bits data width
output physs_mse_port_7_rx_sop, //Receive Start of Frame
output physs_mse_port_7_rx_eop, //Receive End of Frame
output [6:0] physs_mse_port_7_rx_mod, //Receive End Word Modulo. Only meaningful when eop signal is valid. Indicates which portion of the rx_data is valid. rx_mod[6:0] ( 400G / 200G Port0). 7'b0000000 : rx_data[1023:0] is valid. 7'b0000001 : rx_data[7:0] is valid. 7'b0000010 : rx_data[15:0] is valid. 7'b1111111:rx_data[1015:0] is valid. rx_mod[5:0] ( 200G ). 6'b000000 : rx_data[511:0] is valid. 6'b000001 : rx_data[7:0] is valid. 6'b000010 : rx_data[15:0] is valid. 6'b111111:rx_data[503:0] is valid. rx_mod[4:0] ( 100G or below ). 5'b00000 : rx_data[255:0] is valid. 5'b00001 : rx_data[7:0] is valid. 5'b00010 : rx_data[15:0] is valid. 5'b11111:rx_data[247:0] is valid
output physs_mse_port_7_rx_err, //Receive frame error ( This is set when there is any type of error within the frame include L2 FCS Error )
output physs_mse_port_7_rx_ecc_err, //Receive L2 FCS Error ( this bit is only set when there is L2 FCS error )
input mse_physs_port_7_rx_rdy, //Receive Application Ready. Asserted (set to 1) by the Receive application to indicate it is ready to receive Data from the MAC. With the direct interface when the signal deasserts within frame receive the MAC will truncate the frame and eventually set receive frame error
output [38:0] physs_mse_port_7_rx_ts, //Receive Timestamp Value. Time when the MAC detected the SFD of the frame and latched the mac00N_frc_in_rx value. Only meaningful when sop is valid. On ingress contains the 1588 ingress timestamp: Bits [39:8] - 32b timestamp in nano seconds. Bits [7:1] - 7b timestamp in sub-nano seconds. Bit 0 - 1b of valid for TIMESTAMP
input mse_physs_port_7_tx_wren, //Transmit Data Write Enable
input [1023:0] mse_physs_port_7_tx_data, //Transmit data rx_data[1023:0] are valid in 400G mode and 200G mode at Port 0. Transmit data rx_data[511:0] are valid in 200G mode at Ports2/4. Transmit data rx_data[255:0] are valid in 100/50/25/10G mode. Port0 use 1024 bits for 400g 512 bits for 200g or 256 bits for 100g and lower speeds. Port2/4 use 512 bits for 200g or 256 bits for 100g and lower speeds. Ports 1/3/5/6/7 are always 256 bits data width
input mse_physs_port_7_tx_sop, //Transmit Start of Frame
input mse_physs_port_7_tx_eop, //Transmit End of Frame
input [6:0] mse_physs_port_7_tx_mod, //Transmit End Word Modulo. Only meaningful when tx_eop is valid. Indicates which portion of the ff00N_tx_data is valid. tx_mod[6:0] (400G mode / 200G at Port0). 7'b000000 : tx_data[1023:0] is valid. 7'b000001 : tx_data[7:0] is valid. 7'b000010 : tx_data[15:0] is valid. 7'b111111 : tx_data[1015:0] is valid. tx_mod[5:0] ( 200G mode at Ports2/4 ). 6'b000000 : tx_data[511:0] is valid. 6'b000001 : tx_data[7:0] is valid. 6'b000010 : tx_data[15:0] is valid. 6'b111111:tx_data[503:0] is valid. tx_mod[4:0] ( 100G or below ). 5'b00000 : tx_data[255:0] is valid. 5'b00001 : tx_data[7:0] is valid. 5'b00010 : tx_data[15:0] is valid. 5'b11111 : tx_data[247:0] is valid
input mse_physs_port_7_tx_err, //Transmit Frame Error. Asserted with the frames final segment to indicate that the transmitted frame is invalid. Only meaningful whentx_eopis valid. Whentx_erris asserted the frame is transmitted to the CDMII interface with a transmit error (invalid CRC)
input mse_physs_port_7_tx_crc, //Transmit CRC Append. If set a CRC field the MAC will be appended to the frame. If cleared the MAC does not append a FCS to the frame
output physs_mse_port_7_tx_rdy, //Transmit FIFO ready. mse can write words into the FIFO only when this signal is asserted (1). When 0 application should stop writing latest after 2 cycles
output hlp_mac0_tx_stop, //tx_stop backpressure signal for mac to mac
output hlp_mac1_tx_stop, //tx_stop backpressure signal for mac to mac
output hlp_mac2_tx_stop, //tx_stop backpressure signal for mac to mac
output hlp_mac3_tx_stop, //tx_stop backpressure signal for mac to mac
output hlp_mac4_tx_stop, //tx_stop backpressure signal for mac to mac
output hlp_mac5_tx_stop, //tx_stop backpressure signal for mac to mac
output hlp_mac6_tx_stop, //tx_stop backpressure signal for mac to mac
output hlp_mac7_tx_stop, //tx_stop backpressure signal for mac to mac
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
input hlp_xlgmii0_txclk_ena_nss_0, //XLGMII Interface to NSS
input hlp_xlgmii0_rxclk_ena_nss_0, //XLGMII Interface to NSS
input [7:0] hlp_xlgmii0_rxc_nss_0, //XLGMII Interface to NSS
input [63:0] hlp_xlgmii0_rxd_nss_0, //XLGMII Interface to NSS
input hlp_xlgmii0_rxt0_next_nss_0, //XLGMII Interface to NSS
output [7:0] hlp_xlgmii0_txc_nss_0, //XLGMII Interface to NSS
output [63:0] hlp_xlgmii0_txd_nss_0, //XLGMII Interface to NSS
input hlp_xlgmii1_txclk_ena_nss_0, //XLGMII Interface to NSS
input hlp_xlgmii1_rxclk_ena_nss_0, //XLGMII Interface to NSS
input [7:0] hlp_xlgmii1_rxc_nss_0, //XLGMII Interface to NSS
input [63:0] hlp_xlgmii1_rxd_nss_0, //XLGMII Interface to NSS
input hlp_xlgmii1_rxt0_next_nss_0, //XLGMII Interface to NSS
output [7:0] hlp_xlgmii1_txc_nss_0, //XLGMII Interface to NSS
output [63:0] hlp_xlgmii1_txd_nss_0, //XLGMII Interface to NSS
input hlp_xlgmii2_txclk_ena_nss_0, //XLGMII Interface to NSS
input hlp_xlgmii2_rxclk_ena_nss_0, //XLGMII Interface to NSS
input [7:0] hlp_xlgmii2_rxc_nss_0, //XLGMII Interface to NSS
input [63:0] hlp_xlgmii2_rxd_nss_0, //XLGMII Interface to NSS
input hlp_xlgmii2_rxt0_next_nss_0, //XLGMII Interface to NSS
output [7:0] hlp_xlgmii2_txc_nss_0, //XLGMII Interface to NSS
output [63:0] hlp_xlgmii2_txd_nss_0, //XLGMII Interface to NSS
input hlp_xlgmii3_txclk_ena_nss_0, //XLGMII Interface to NSS
input hlp_xlgmii3_rxclk_ena_nss_0, //XLGMII Interface to NSS
input [7:0] hlp_xlgmii3_rxc_nss_0, //XLGMII Interface to NSS
input [63:0] hlp_xlgmii3_rxd_nss_0, //XLGMII Interface to NSS
input hlp_xlgmii3_rxt0_next_nss_0, //XLGMII Interface to NSS
output [7:0] hlp_xlgmii3_txc_nss_0, //XLGMII Interface to NSS
output [63:0] hlp_xlgmii3_txd_nss_0, //XLGMII Interface to NSS
input [127:0] hlp_cgmii0_rxd_nss_0, //CGMII Interface to NSS
input [15:0] hlp_cgmii0_rxc_nss_0, //CGMII Interface to NSS
input hlp_cgmii0_rxclk_ena_nss_0, //CGMII Interface to NSS
output [127:0] hlp_cgmii0_txd_nss_0, //CGMII Interface to NSS
output [15:0] hlp_cgmii0_txc_nss_0, //CGMII Interface to NSS
input hlp_cgmii0_txclk_ena_nss_0, //CGMII Interface to NSS
input [127:0] hlp_cgmii1_rxd_nss_0, //CGMII Interface to NSS
input [15:0] hlp_cgmii1_rxc_nss_0, //CGMII Interface to NSS
input hlp_cgmii1_rxclk_ena_nss_0, //CGMII Interface to NSS
output [127:0] hlp_cgmii1_txd_nss_0, //CGMII Interface to NSS
output [15:0] hlp_cgmii1_txc_nss_0, //CGMII Interface to NSS
input hlp_cgmii1_txclk_ena_nss_0, //CGMII Interface to NSS
input [127:0] hlp_cgmii2_rxd_nss_0, //CGMII Interface to NSS
input [15:0] hlp_cgmii2_rxc_nss_0, //CGMII Interface to NSS
input hlp_cgmii2_rxclk_ena_nss_0, //CGMII Interface to NSS
output [127:0] hlp_cgmii2_txd_nss_0, //CGMII Interface to NSS
output [15:0] hlp_cgmii2_txc_nss_0, //CGMII Interface to NSS
input hlp_cgmii2_txclk_ena_nss_0, //CGMII Interface to NSS
input [127:0] hlp_cgmii3_rxd_nss_0, //CGMII Interface to NSS
input [15:0] hlp_cgmii3_rxc_nss_0, //CGMII Interface to NSS
input hlp_cgmii3_rxclk_ena_nss_0, //CGMII Interface to NSS
output [127:0] hlp_cgmii3_txd_nss_0, //CGMII Interface to NSS
output [15:0] hlp_cgmii3_txc_nss_0, //CGMII Interface to NSS
input hlp_cgmii3_txclk_ena_nss_0, //CGMII Interface to NSS
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
output physs_ares_int_0, //interrupt indication for ARM cores for physs_0
output physs_ares_int_1, //interrupt indication for ARM cores for physs_1
output physs_imc_int_0, //interrupt indication for ARM IMC for physs_0
output physs_imc_int_1, //interrupt indication for ARM IMC for physs_1
output physs_0_ts_int, //PHY timestamp interrupt indication reflect 8 ports (faster interrupt tobypass IMC) for physs_0
output physs_1_ts_int, //PHY timestamp interrupt indication reflect 8 ports (faster interrupt tobypass IMC) for physs_1
output physs_0_noc_int, //NMF NOC interrupt. Connected to the inetrnal NOC interrupt pin for physs_0
output physs_1_noc_int, //NMF NOC interrupt. Connected to the inetrnal NOC interrupt pin for physs_1
input mdio_in,
output mdio_out,
output mdio_oen,
output mdc,
inout [15:0] ioa_pma_remote_diode_i_anode,
inout [15:0] ioa_pma_remote_diode_v_anode,
inout [15:0] ioa_pma_remote_diode_i_cathode,
inout [15:0] ioa_pma_remote_diode_v_cathode,
input i_ck_fbscan_tck_0, //Boundary scan clock
input i_ck_fbscan_updatedr_0, //TAP Controller state. In this controller state data is latched onto the parallel output of the test data registers from the shift-register path. The data held at the latched parallel output should not change in any other controller state unless a change in operation is required
input i_fbscan_capturedr_0, //TAP Controller state. In this controller state data may be parallel-loaded into test data registers selected by the current instruction on the rising edge of TC
input i_fbscan_shiftdr_0, //TAP Controller stateIn this controller state the boundary scan data shifts data one stage toward its serial output on each rising edge of i_ck_bs
input i_fbscan_tdi_0, //Test data input port from preceding boundary scan cell
output o_abscan_pma0_tdo_0, //Bscan data timed to rising edge
output o_abscan_pma0_tdo_f_0, //Bscan data timed to falling edge
output o_abscan_pma1_tdo_0, //Bscan data timed to rising edge
output o_abscan_pma1_tdo_f_0, //Bscan data timed to falling edge
output o_abscan_pma2_tdo_0, //Bscan data timed to rising edge
output o_abscan_pma2_tdo_f_0, //Bscan data timed to falling edge
output o_abscan_pma3_tdo_0, //Bscan data timed to rising edge
output o_abscan_pma3_tdo_f_0, //Bscan data timed to falling edge
input i_fbscan_mode_0, //Boundary scan mode enable.
input i_fbscan_chainen_0, //TBD
input i_fbscan_d6init_0, //TAP instruction
input i_fbscan_d6select_0, //TAP instruction
input i_fbscan_d6actestsig_b_0, //TBD
input i_fbscan_extogen_0, //TAP instruction
input i_fbscan_extogsig_b_0, //TBD
input i_fbscan_highz_0, //TBD
input i_ck_fbscan_tck_1, //Boundary scan clock
input i_ck_fbscan_updatedr_1, //TAP Controller state. In this controller state data is latched onto the parallel output of the test data registers from the shift-register path. The data held at the latched parallel output should not change in any other controller state unless a change in operation is required
input i_fbscan_capturedr_1, //TAP Controller state. In this controller state data may be parallel-loaded into test data registers selected by the current instruction on the rising edge of TC
input i_fbscan_shiftdr_1, //TAP Controller stateIn this controller state the boundary scan data shifts data one stage toward its serial output on each rising edge of i_ck_bs
input i_fbscan_tdi_1, //Test data input port from preceding boundary scan cell
output o_abscan_pma0_tdo_1, //Bscan data timed to rising edge
output o_abscan_pma0_tdo_f_1, //Bscan data timed to falling edge
output o_abscan_pma1_tdo_1, //Bscan data timed to rising edge
output o_abscan_pma1_tdo_f_1, //Bscan data timed to falling edge
output o_abscan_pma2_tdo_1, //Bscan data timed to rising edge
output o_abscan_pma2_tdo_f_1, //Bscan data timed to falling edge
output o_abscan_pma3_tdo_1, //Bscan data timed to rising edge
output o_abscan_pma3_tdo_f_1, //Bscan data timed to falling edge
input i_fbscan_mode_1, //Boundary scan mode enable.
input i_fbscan_chainen_1, //TBD
input i_fbscan_d6init_1, //TAP instruction
input i_fbscan_d6select_1, //TAP instruction
input i_fbscan_d6actestsig_b_1, //TBD
input i_fbscan_extogen_1, //TAP instruction
input i_fbscan_extogsig_b_1, //TBD
input i_fbscan_highz_1, //TBD
input i_ck_fbscan_tck_2, //Boundary scan clock
input i_ck_fbscan_updatedr_2, //TAP Controller state. In this controller state data is latched onto the parallel output of the test data registers from the shift-register path. The data held at the latched parallel output should not change in any other controller state unless a change in operation is required
input i_fbscan_capturedr_2, //TAP Controller state. In this controller state data may be parallel-loaded into test data registers selected by the current instruction on the rising edge of TC
input i_fbscan_shiftdr_2, //TAP Controller stateIn this controller state the boundary scan data shifts data one stage toward its serial output on each rising edge of i_ck_bs
input i_fbscan_tdi_2, //Test data input port from preceding boundary scan cell
output o_abscan_pma0_tdo_2, //Bscan data timed to rising edge
output o_abscan_pma0_tdo_f_2, //Bscan data timed to falling edge
output o_abscan_pma1_tdo_2, //Bscan data timed to rising edge
output o_abscan_pma1_tdo_f_2, //Bscan data timed to falling edge
output o_abscan_pma2_tdo_2, //Bscan data timed to rising edge
output o_abscan_pma2_tdo_f_2, //Bscan data timed to falling edge
output o_abscan_pma3_tdo_2, //Bscan data timed to rising edge
output o_abscan_pma3_tdo_f_2, //Bscan data timed to falling edge
input i_fbscan_mode_2, //Boundary scan mode enable.
input i_fbscan_chainen_2, //TBD
input i_fbscan_d6init_2, //TAP instruction
input i_fbscan_d6select_2, //TAP instruction
input i_fbscan_d6actestsig_b_2, //TBD
input i_fbscan_extogen_2, //TAP instruction
input i_fbscan_extogsig_b_2, //TBD
input i_fbscan_highz_2, //TBD
input i_ck_fbscan_tck_3, //Boundary scan clock
input i_ck_fbscan_updatedr_3, //TAP Controller state. In this controller state data is latched onto the parallel output of the test data registers from the shift-register path. The data held at the latched parallel output should not change in any other controller state unless a change in operation is required
input i_fbscan_capturedr_3, //TAP Controller state. In this controller state data may be parallel-loaded into test data registers selected by the current instruction on the rising edge of TC
input i_fbscan_shiftdr_3, //TAP Controller stateIn this controller state the boundary scan data shifts data one stage toward its serial output on each rising edge of i_ck_bs
input i_fbscan_tdi_3, //Test data input port from preceding boundary scan cell
output o_abscan_pma0_tdo_3, //Bscan data timed to rising edge
output o_abscan_pma0_tdo_f_3, //Bscan data timed to falling edge
output o_abscan_pma1_tdo_3, //Bscan data timed to rising edge
output o_abscan_pma1_tdo_f_3, //Bscan data timed to falling edge
output o_abscan_pma2_tdo_3, //Bscan data timed to rising edge
output o_abscan_pma2_tdo_f_3, //Bscan data timed to falling edge
output o_abscan_pma3_tdo_3, //Bscan data timed to rising edge
output o_abscan_pma3_tdo_f_3, //Bscan data timed to falling edge
input i_fbscan_mode_3, //Boundary scan mode enable.
input i_fbscan_chainen_3, //TBD
input i_fbscan_d6init_3, //TAP instruction
input i_fbscan_d6select_3, //TAP instruction
input i_fbscan_d6actestsig_b_3, //TBD
input i_fbscan_extogen_3, //TAP instruction
input i_fbscan_extogsig_b_3, //TBD
input i_fbscan_highz_3, //TBD
input i_fdfx_powergood, //TBD
input i_ck_pma0_jtag_tck, //JTAG clock
input i_dfx_pma0_secure_tap_green, //JTAG security level - Green
input i_dfx_pma0_secure_tap_orange, //JTAG security level - Orange
input i_dfx_pma0_secure_tap_red, //JTAG security level - Red
input i_rst_pma0_jtag_trst_b_a, //JTAG reset
input [7:0] i_pma0_jtag_id_nt, //Sets JTAG ID for JTAG controller. Used during private EN instruction to enable other private instructions
input [31:0] i_pma0_jtag_slvid_nt, //Sets JTAG Slave ID for JTAG controller. Output when performing SLVIDCODE. Must be unique
input i_pma0_jtag_tms, //JTAG TMS input. Refer to JTAG documentation
input i_pma0_jtag_tdi, //JTAG TDI input. Refer to JTAG documentation
output o_pma0_jtag_tdo_en, //JTAG TDO enable output. Should be attached to the enable port of a tri-state buffer driving TDO if applicable
output o_pma0_jtag_tdo, //JTAG TDO output. Refer to JTAG documentation
input i_ck_pma1_jtag_tck, //JTAG clock
input i_dfx_pma1_secure_tap_green, //JTAG security level - Green
input i_dfx_pma1_secure_tap_orange, //JTAG security level - Orange
input i_dfx_pma1_secure_tap_red, //JTAG security level - Red
input i_rst_pma1_jtag_trst_b_a, //JTAG reset
input [7:0] i_pma1_jtag_id_nt, //Sets JTAG ID for JTAG controller. Used during private EN instruction to enable other private instructions
input [31:0] i_pma1_jtag_slvid_nt, //Sets JTAG Slave ID for JTAG controller. Output when performing SLVIDCODE. Must be unique
input i_pma1_jtag_tms, //JTAG TMS input. Refer to JTAG documentation
input i_pma1_jtag_tdi, //JTAG TDI input. Refer to JTAG documentation
output o_pma1_jtag_tdo_en, //JTAG TDO enable output. Should be attached to the enable port of a tri-state buffer driving TDO if applicable
output o_pma1_jtag_tdo, //JTAG TDO output. Refer to JTAG documentation
input i_ck_pma2_jtag_tck, //JTAG clock
input i_dfx_pma2_secure_tap_green, //JTAG security level - Green
input i_dfx_pma2_secure_tap_orange, //JTAG security level - Orange
input i_dfx_pma2_secure_tap_red, //JTAG security level - Red
input i_rst_pma2_jtag_trst_b_a, //JTAG reset
input [7:0] i_pma2_jtag_id_nt, //Sets JTAG ID for JTAG controller. Used during private EN instruction to enable other private instructions
input [31:0] i_pma2_jtag_slvid_nt, //Sets JTAG Slave ID for JTAG controller. Output when performing SLVIDCODE. Must be unique
input i_pma2_jtag_tms, //JTAG TMS input. Refer to JTAG documentation
input i_pma2_jtag_tdi, //JTAG TDI input. Refer to JTAG documentation
output o_pma2_jtag_tdo_en, //JTAG TDO enable output. Should be attached to the enable port of a tri-state buffer driving TDO if applicable
output o_pma2_jtag_tdo, //JTAG TDO output. Refer to JTAG documentation
input i_ck_pma3_jtag_tck, //JTAG clock
input i_dfx_pma3_secure_tap_green, //JTAG security level - Green
input i_dfx_pma3_secure_tap_orange, //JTAG security level - Orange
input i_dfx_pma3_secure_tap_red, //JTAG security level - Red
input i_rst_pma3_jtag_trst_b_a, //JTAG reset
input [7:0] i_pma3_jtag_id_nt, //Sets JTAG ID for JTAG controller. Used during private EN instruction to enable other private instructions
input [31:0] i_pma3_jtag_slvid_nt, //Sets JTAG Slave ID for JTAG controller. Output when performing SLVIDCODE. Must be unique
input i_pma3_jtag_tms, //JTAG TMS input. Refer to JTAG documentation
input i_pma3_jtag_tdi, //JTAG TDI input. Refer to JTAG documentation
output o_pma3_jtag_tdo_en, //JTAG TDO enable output. Should be attached to the enable port of a tri-state buffer driving TDO if applicable
output o_pma3_jtag_tdo, //JTAG TDO output. Refer to JTAG documentation
input i_ck_pma4_jtag_tck, //JTAG clock
input i_dfx_pma4_secure_tap_green, //JTAG security level - Green
input i_dfx_pma4_secure_tap_orange, //JTAG security level - Orange
input i_dfx_pma4_secure_tap_red, //JTAG security level - Red
input i_rst_pma4_jtag_trst_b_a, //JTAG reset
input [7:0] i_pma4_jtag_id_nt, //Sets JTAG ID for JTAG controller. Used during private EN instruction to enable other private instructions
input [31:0] i_pma4_jtag_slvid_nt, //Sets JTAG Slave ID for JTAG controller. Output when performing SLVIDCODE. Must be unique
input i_pma4_jtag_tms, //JTAG TMS input. Refer to JTAG documentation
input i_pma4_jtag_tdi, //JTAG TDI input. Refer to JTAG documentation
output o_pma4_jtag_tdo_en, //JTAG TDO enable output. Should be attached to the enable port of a tri-state buffer driving TDO if applicable
output o_pma4_jtag_tdo, //JTAG TDO output. Refer to JTAG documentation
input i_ck_pma5_jtag_tck, //JTAG clock
input i_dfx_pma5_secure_tap_green, //JTAG security level - Green
input i_dfx_pma5_secure_tap_orange, //JTAG security level - Orange
input i_dfx_pma5_secure_tap_red, //JTAG security level - Red
input i_rst_pma5_jtag_trst_b_a, //JTAG reset
input [7:0] i_pma5_jtag_id_nt, //Sets JTAG ID for JTAG controller. Used during private EN instruction to enable other private instructions
input [31:0] i_pma5_jtag_slvid_nt, //Sets JTAG Slave ID for JTAG controller. Output when performing SLVIDCODE. Must be unique
input i_pma5_jtag_tms, //JTAG TMS input. Refer to JTAG documentation
input i_pma5_jtag_tdi, //JTAG TDI input. Refer to JTAG documentation
output o_pma5_jtag_tdo_en, //JTAG TDO enable output. Should be attached to the enable port of a tri-state buffer driving TDO if applicable
output o_pma5_jtag_tdo, //JTAG TDO output. Refer to JTAG documentation
input i_ck_pma6_jtag_tck, //JTAG clock
input i_dfx_pma6_secure_tap_green, //JTAG security level - Green
input i_dfx_pma6_secure_tap_orange, //JTAG security level - Orange
input i_dfx_pma6_secure_tap_red, //JTAG security level - Red
input i_rst_pma6_jtag_trst_b_a, //JTAG reset
input [7:0] i_pma6_jtag_id_nt, //Sets JTAG ID for JTAG controller. Used during private EN instruction to enable other private instructions
input [31:0] i_pma6_jtag_slvid_nt, //Sets JTAG Slave ID for JTAG controller. Output when performing SLVIDCODE. Must be unique
input i_pma6_jtag_tms, //JTAG TMS input. Refer to JTAG documentation
input i_pma6_jtag_tdi, //JTAG TDI input. Refer to JTAG documentation
output o_pma6_jtag_tdo_en, //JTAG TDO enable output. Should be attached to the enable port of a tri-state buffer driving TDO if applicable
output o_pma6_jtag_tdo, //JTAG TDO output. Refer to JTAG documentation
input i_ck_pma7_jtag_tck, //JTAG clock
input i_dfx_pma7_secure_tap_green, //JTAG security level - Green
input i_dfx_pma7_secure_tap_orange, //JTAG security level - Orange
input i_dfx_pma7_secure_tap_red, //JTAG security level - Red
input i_rst_pma7_jtag_trst_b_a, //JTAG reset
input [7:0] i_pma7_jtag_id_nt, //Sets JTAG ID for JTAG controller. Used during private EN instruction to enable other private instructions
input [31:0] i_pma7_jtag_slvid_nt, //Sets JTAG Slave ID for JTAG controller. Output when performing SLVIDCODE. Must be unique
input i_pma7_jtag_tms, //JTAG TMS input. Refer to JTAG documentation
input i_pma7_jtag_tdi, //JTAG TDI input. Refer to JTAG documentation
output o_pma7_jtag_tdo_en, //JTAG TDO enable output. Should be attached to the enable port of a tri-state buffer driving TDO if applicable
output o_pma7_jtag_tdo, //JTAG TDO output. Refer to JTAG documentation
input i_ck_pma8_jtag_tck, //JTAG clock
input i_dfx_pma8_secure_tap_green, //JTAG security level - Green
input i_dfx_pma8_secure_tap_orange, //JTAG security level - Orange
input i_dfx_pma8_secure_tap_red, //JTAG security level - Red
input i_rst_pma8_jtag_trst_b_a, //JTAG reset
input [7:0] i_pma8_jtag_id_nt, //Sets JTAG ID for JTAG controller. Used during private EN instruction to enable other private instructions
input [31:0] i_pma8_jtag_slvid_nt, //Sets JTAG Slave ID for JTAG controller. Output when performing SLVIDCODE. Must be unique
input i_pma8_jtag_tms, //JTAG TMS input. Refer to JTAG documentation
input i_pma8_jtag_tdi, //JTAG TDI input. Refer to JTAG documentation
output o_pma8_jtag_tdo_en, //JTAG TDO enable output. Should be attached to the enable port of a tri-state buffer driving TDO if applicable
output o_pma8_jtag_tdo, //JTAG TDO output. Refer to JTAG documentation
input i_ck_pma9_jtag_tck, //JTAG clock
input i_dfx_pma9_secure_tap_green, //JTAG security level - Green
input i_dfx_pma9_secure_tap_orange, //JTAG security level - Orange
input i_dfx_pma9_secure_tap_red, //JTAG security level - Red
input i_rst_pma9_jtag_trst_b_a, //JTAG reset
input [7:0] i_pma9_jtag_id_nt, //Sets JTAG ID for JTAG controller. Used during private EN instruction to enable other private instructions
input [31:0] i_pma9_jtag_slvid_nt, //Sets JTAG Slave ID for JTAG controller. Output when performing SLVIDCODE. Must be unique
input i_pma9_jtag_tms, //JTAG TMS input. Refer to JTAG documentation
input i_pma9_jtag_tdi, //JTAG TDI input. Refer to JTAG documentation
output o_pma9_jtag_tdo_en, //JTAG TDO enable output. Should be attached to the enable port of a tri-state buffer driving TDO if applicable
output o_pma9_jtag_tdo, //JTAG TDO output. Refer to JTAG documentation
input i_ck_pma10_jtag_tck, //JTAG clock
input i_dfx_pma10_secure_tap_green, //JTAG security level - Green
input i_dfx_pma10_secure_tap_orange, //JTAG security level - Orange
input i_dfx_pma10_secure_tap_red, //JTAG security level - Red
input i_rst_pma10_jtag_trst_b_a, //JTAG reset
input [7:0] i_pma10_jtag_id_nt, //Sets JTAG ID for JTAG controller. Used during private EN instruction to enable other private instructions
input [31:0] i_pma10_jtag_slvid_nt, //Sets JTAG Slave ID for JTAG controller. Output when performing SLVIDCODE. Must be unique
input i_pma10_jtag_tms, //JTAG TMS input. Refer to JTAG documentation
input i_pma10_jtag_tdi, //JTAG TDI input. Refer to JTAG documentation
output o_pma10_jtag_tdo_en, //JTAG TDO enable output. Should be attached to the enable port of a tri-state buffer driving TDO if applicable
output o_pma10_jtag_tdo, //JTAG TDO output. Refer to JTAG documentation
input i_ck_pma11_jtag_tck, //JTAG clock
input i_dfx_pma11_secure_tap_green, //JTAG security level - Green
input i_dfx_pma11_secure_tap_orange, //JTAG security level - Orange
input i_dfx_pma11_secure_tap_red, //JTAG security level - Red
input i_rst_pma11_jtag_trst_b_a, //JTAG reset
input [7:0] i_pma11_jtag_id_nt, //Sets JTAG ID for JTAG controller. Used during private EN instruction to enable other private instructions
input [31:0] i_pma11_jtag_slvid_nt, //Sets JTAG Slave ID for JTAG controller. Output when performing SLVIDCODE. Must be unique
input i_pma11_jtag_tms, //JTAG TMS input. Refer to JTAG documentation
input i_pma11_jtag_tdi, //JTAG TDI input. Refer to JTAG documentation
output o_pma11_jtag_tdo_en, //JTAG TDO enable output. Should be attached to the enable port of a tri-state buffer driving TDO if applicable
output o_pma11_jtag_tdo, //JTAG TDO output. Refer to JTAG documentation
input i_ck_pma12_jtag_tck, //JTAG clock
input i_dfx_pma12_secure_tap_green, //JTAG security level - Green
input i_dfx_pma12_secure_tap_orange, //JTAG security level - Orange
input i_dfx_pma12_secure_tap_red, //JTAG security level - Red
input i_rst_pma12_jtag_trst_b_a, //JTAG reset
input [7:0] i_pma12_jtag_id_nt, //Sets JTAG ID for JTAG controller. Used during private EN instruction to enable other private instructions
input [31:0] i_pma12_jtag_slvid_nt, //Sets JTAG Slave ID for JTAG controller. Output when performing SLVIDCODE. Must be unique
input i_pma12_jtag_tms, //JTAG TMS input. Refer to JTAG documentation
input i_pma12_jtag_tdi, //JTAG TDI input. Refer to JTAG documentation
output o_pma12_jtag_tdo_en, //JTAG TDO enable output. Should be attached to the enable port of a tri-state buffer driving TDO if applicable
output o_pma12_jtag_tdo, //JTAG TDO output. Refer to JTAG documentation
input i_ck_pma13_jtag_tck, //JTAG clock
input i_dfx_pma13_secure_tap_green, //JTAG security level - Green
input i_dfx_pma13_secure_tap_orange, //JTAG security level - Orange
input i_dfx_pma13_secure_tap_red, //JTAG security level - Red
input i_rst_pma13_jtag_trst_b_a, //JTAG reset
input [7:0] i_pma13_jtag_id_nt, //Sets JTAG ID for JTAG controller. Used during private EN instruction to enable other private instructions
input [31:0] i_pma13_jtag_slvid_nt, //Sets JTAG Slave ID for JTAG controller. Output when performing SLVIDCODE. Must be unique
input i_pma13_jtag_tms, //JTAG TMS input. Refer to JTAG documentation
input i_pma13_jtag_tdi, //JTAG TDI input. Refer to JTAG documentation
output o_pma13_jtag_tdo_en, //JTAG TDO enable output. Should be attached to the enable port of a tri-state buffer driving TDO if applicable
output o_pma13_jtag_tdo, //JTAG TDO output. Refer to JTAG documentation
input i_ck_pma14_jtag_tck, //JTAG clock
input i_dfx_pma14_secure_tap_green, //JTAG security level - Green
input i_dfx_pma14_secure_tap_orange, //JTAG security level - Orange
input i_dfx_pma14_secure_tap_red, //JTAG security level - Red
input i_rst_pma14_jtag_trst_b_a, //JTAG reset
input [7:0] i_pma14_jtag_id_nt, //Sets JTAG ID for JTAG controller. Used during private EN instruction to enable other private instructions
input [31:0] i_pma14_jtag_slvid_nt, //Sets JTAG Slave ID for JTAG controller. Output when performing SLVIDCODE. Must be unique
input i_pma14_jtag_tms, //JTAG TMS input. Refer to JTAG documentation
input i_pma14_jtag_tdi, //JTAG TDI input. Refer to JTAG documentation
output o_pma14_jtag_tdo_en, //JTAG TDO enable output. Should be attached to the enable port of a tri-state buffer driving TDO if applicable
output o_pma14_jtag_tdo, //JTAG TDO output. Refer to JTAG documentation
input i_ck_pma15_jtag_tck, //JTAG clock
input i_dfx_pma15_secure_tap_green, //JTAG security level - Green
input i_dfx_pma15_secure_tap_orange, //JTAG security level - Orange
input i_dfx_pma15_secure_tap_red, //JTAG security level - Red
input i_rst_pma15_jtag_trst_b_a, //JTAG reset
input [7:0] i_pma15_jtag_id_nt, //Sets JTAG ID for JTAG controller. Used during private EN instruction to enable other private instructions
input [31:0] i_pma15_jtag_slvid_nt, //Sets JTAG Slave ID for JTAG controller. Output when performing SLVIDCODE. Must be unique
input i_pma15_jtag_tms, //JTAG TMS input. Refer to JTAG documentation
input i_pma15_jtag_tdi, //JTAG TDI input. Refer to JTAG documentation
output o_pma15_jtag_tdo_en, //JTAG TDO enable output. Should be attached to the enable port of a tri-state buffer driving TDO if applicable
output o_pma15_jtag_tdo, //JTAG TDO output. Refer to JTAG documentation
input i_ck_ucss_jtag_tck_0, //JTAG clock
input i_rst_ucss_jtag_trst_b_a_0, //JTAG reset
input [7:0] i_ucss_jtag_id_nt_0, //Sets JTAG ID for JTAG controller. Used during private EN instruction to enable other private instructions
input [31:0] i_ucss_jtag_slvid_nt_0, //Sets JTAG Slave ID for JTAG controller. Output when performing SLVIDCODE. Must be unique
input i_ucss_jtag_tms_0, //JTAG TMS input. Refer to JTAG documentation
input i_ucss_jtag_tdi_0, //JTAG TDI input. Refer to JTAG documentation
output o_ucss_jtag_tdo_en_0, //JTAG TDO enable output. Should be attached to the enable port of a tri-state buffer driving TDO if applicable
output o_ucss_jtag_tdo_0, //JTAG TDO output. Refer to JTAG documentation
input i_ck_cpu_debug_tck_0, //JTAG Debugger clock
input i_rst_cpu_debug_trst_b_a_0, //JTAG resett
input [15:0] i_cpu_debug_prid_nt_0, //CPU TAP (Debugger) IID
input i_cpu_debug_tms_0, //JTAG Debugger TMS input. Refer to JTAG
input i_cpu_debug_tdi_0, //JTAG Debugger TDI input. Refer to JTAG Debugger documentation
output o_cpu_debug_tdo_0, //JTAG Debugger TDO output. Refer to JTAG Debugger documentation
output o_cpu_debug_tdo_en_0, //JTAG Debugger TDO enable output. Should be attached to the enable port of a tri-state buffer driving TDO if applicable
input i_dfx_ucss_secure_tap_green_0, //JTAG security level - Green
input i_dfx_ucss_secure_tap_orange_0, //JTAG security level - Orange
input i_dfx_ucss_secure_tap_red_0, //JTAG security level - Red
input i_ck_ucss_jtag_tck_1, //JTAG clock
input i_rst_ucss_jtag_trst_b_a_1, //JTAG reset
input [7:0] i_ucss_jtag_id_nt_1, //Sets JTAG ID for JTAG controller. Used during private EN instruction to enable other private instructions
input [31:0] i_ucss_jtag_slvid_nt_1, //Sets JTAG Slave ID for JTAG controller. Output when performing SLVIDCODE. Must be unique
input i_ucss_jtag_tms_1, //JTAG TMS input. Refer to JTAG documentation
input i_ucss_jtag_tdi_1, //JTAG TDI input. Refer to JTAG documentation
output o_ucss_jtag_tdo_en_1, //JTAG TDO enable output. Should be attached to the enable port of a tri-state buffer driving TDO if applicable
output o_ucss_jtag_tdo_1, //JTAG TDO output. Refer to JTAG documentation
input i_ck_cpu_debug_tck_1, //JTAG Debugger clock
input i_rst_cpu_debug_trst_b_a_1, //JTAG resett
input [15:0] i_cpu_debug_prid_nt_1, //CPU TAP (Debugger) IID
input i_cpu_debug_tms_1, //JTAG Debugger TMS input. Refer to JTAG
input i_cpu_debug_tdi_1, //JTAG Debugger TDI input. Refer to JTAG Debugger documentation
output o_cpu_debug_tdo_1, //JTAG Debugger TDO output. Refer to JTAG Debugger documentation
output o_cpu_debug_tdo_en_1, //JTAG Debugger TDO enable output. Should be attached to the enable port of a tri-state buffer driving TDO if applicable
input i_dfx_ucss_secure_tap_green_1, //JTAG security level - Green
input i_dfx_ucss_secure_tap_orange_1, //JTAG security level - Orange
input i_dfx_ucss_secure_tap_red_1, //JTAG security level - Red
input i_ck_ucss_jtag_tck_2, //JTAG clock
input i_rst_ucss_jtag_trst_b_a_2, //JTAG reset
input [7:0] i_ucss_jtag_id_nt_2, //Sets JTAG ID for JTAG controller. Used during private EN instruction to enable other private instructions
input [31:0] i_ucss_jtag_slvid_nt_2, //Sets JTAG Slave ID for JTAG controller. Output when performing SLVIDCODE. Must be unique
input i_ucss_jtag_tms_2, //JTAG TMS input. Refer to JTAG documentation
input i_ucss_jtag_tdi_2, //JTAG TDI input. Refer to JTAG documentation
output o_ucss_jtag_tdo_en_2, //JTAG TDO enable output. Should be attached to the enable port of a tri-state buffer driving TDO if applicable
output o_ucss_jtag_tdo_2, //JTAG TDO output. Refer to JTAG documentation
input i_ck_cpu_debug_tck_2, //JTAG Debugger clock
input i_rst_cpu_debug_trst_b_a_2, //JTAG resett
input [15:0] i_cpu_debug_prid_nt_2, //CPU TAP (Debugger) IID
input i_cpu_debug_tms_2, //JTAG Debugger TMS input. Refer to JTAG
input i_cpu_debug_tdi_2, //JTAG Debugger TDI input. Refer to JTAG Debugger documentation
output o_cpu_debug_tdo_2, //JTAG Debugger TDO output. Refer to JTAG Debugger documentation
output o_cpu_debug_tdo_en_2, //JTAG Debugger TDO enable output. Should be attached to the enable port of a tri-state buffer driving TDO if applicable
input i_dfx_ucss_secure_tap_green_2, //JTAG security level - Green
input i_dfx_ucss_secure_tap_orange_2, //JTAG security level - Orange
input i_dfx_ucss_secure_tap_red_2, //JTAG security level - Red
input i_ck_ucss_jtag_tck_3, //JTAG clock
input i_rst_ucss_jtag_trst_b_a_3, //JTAG reset
input [7:0] i_ucss_jtag_id_nt_3, //Sets JTAG ID for JTAG controller. Used during private EN instruction to enable other private instructions
input [31:0] i_ucss_jtag_slvid_nt_3, //Sets JTAG Slave ID for JTAG controller. Output when performing SLVIDCODE. Must be unique
input i_ucss_jtag_tms_3, //JTAG TMS input. Refer to JTAG documentation
input i_ucss_jtag_tdi_3, //JTAG TDI input. Refer to JTAG documentation
output o_ucss_jtag_tdo_en_3, //JTAG TDO enable output. Should be attached to the enable port of a tri-state buffer driving TDO if applicable
output o_ucss_jtag_tdo_3, //JTAG TDO output. Refer to JTAG documentation
input i_ck_cpu_debug_tck_3, //JTAG Debugger clock
input i_rst_cpu_debug_trst_b_a_3, //JTAG resett
input [15:0] i_cpu_debug_prid_nt_3, //CPU TAP (Debugger) IID
input i_cpu_debug_tms_3, //JTAG Debugger TMS input. Refer to JTAG
input i_cpu_debug_tdi_3, //JTAG Debugger TDI input. Refer to JTAG Debugger documentation
output o_cpu_debug_tdo_3, //JTAG Debugger TDO output. Refer to JTAG Debugger documentation
output o_cpu_debug_tdo_en_3, //JTAG Debugger TDO enable output. Should be attached to the enable port of a tri-state buffer driving TDO if applicable
input i_dfx_ucss_secure_tap_green_3, //JTAG security level - Green
input i_dfx_ucss_secure_tap_orange_3, //JTAG security level - Orange
input i_dfx_ucss_secure_tap_red_3, //JTAG security level - Red
input i_ck_fscan_pma_ref_0, //Scan clock for reference clock domain. Driven by SOC at SOC level
input i_ck_fscan_pma_apb_0, //Scan clock for APB clock domain. Driven by SOC at SOC level
input i_ck_fscan_pma_cmnpll_postdiv_0, //Scan clock for CMN PLL postdivider logic
input i_ck_fscan_pma_postclk_refclk_clk_cmnpll_0, //Scan clock for CMN PLL A and CMN PLL B logic
input i_ck_fscan_pma_postclk_refclk_clk_txpll_0, //Scan clock for TxPLL PLL logic for all lanes
input i_ck_fscan_ucss_postclk_0, //Scan clock
input i_fscan_clkgenctrl_nt_0, //Unused
input i_fscan_clkgenctrlen_nt_0, //TBD
input i_fscan_clkungate_nt_0, //Enable for architectural clock gating
input i_fscan_clkungate_syn_nt_0, //Enable for power complier inserted clock gating
input i_fscan_shiften_nt_0, //Enable for shift mode. 1'b0: Capture mode. 1'b1: Shift mode
input i_fscan_latchclosed_b_nt_0, //PLL Active low latch control
input i_fscan_latchopen_nt_0, //PLL Active high latch control
input i_fscan_mode_atspeed_nt_0, //This is a static signal that indicates that the device is in atspeed scan mode. Not used currently. It can be used in case any difference arises in terms of clocking or if need to bypass any logic from scan in the at-speed mode in future
input i_fscan_mode_nt_0, //Enables scan test mode
input i_fscan_ret_control_nt_0, //PLL Active low latch control
input i_rst_fscan_byprst_b_0, //Scan reset bypass
input i_rst_fscan_byplatrst_b_0, //TBD
input i_fscan_rstbypen_nt_0, //This is a static signal this is used to mux the scan reset i.e. i_rst_fscan_byprst_b signal onto the functional resets within the IPs when this signal is set to 1'b1
input i_fscan_slos_en_nt_0, //SLOS enable signal. Set to 1 to enable synchronous launch off shift feature in ATPG.
input i_fscan_chain_bypass_nt_0, //pll chain bypass enable
input i_fscan_latch_bypass_in_nt_0, //chain latch in bypass enable
input i_fscan_latch_bypass_out_nt_0, //chain latch out bypass enable
input i_fscan_pll_isolate_nt_0, //Currently unused.
input i_fscan_pll_scan_if_dis_nt_0, //disable scan controls.
input [79:0] i_fscan_pma0_sdi_ref_cmn_0, //Scan data bus
input [3:0] i_fscan_pma0_sdi_apb_cmn_0, //Scan data bus
input [41:0] i_fscan_pma0_sdi_ref_channelcmn_0, //Scan data bus
input [9:0] i_fscan_pma0_sdi_cmnplla_0, //Scan data bus
input [9:0] i_fscan_pma0_sdi_cmnpllb_0, //Scan data bus
output [79:0] o_ascan_pma0_sdo_ref_cmn_0, //Scan data bus
output [3:0] o_ascan_pma0_sdo_apb_cmn_0, //Scan data bus
output [41:0] o_ascan_pma0_sdo_ref_channelcmn_0, //Scan data bus
output [9:0] o_ascan_pma0_sdo_cmnplla_0, //Scan data bus
output [9:0] o_ascan_pma0_sdo_cmnpllb_0, //Scan data bus
input [19:0] i_fscan_pma0_sdi_ctrl_l0_0, //Scan data bus
input [49:0] i_fscan_pma0_sdi_memarray_word_l0_0, //Scan data bus
input [89:0] i_fscan_pma0_sdi_ref_l0_0, //Scan data bus
input [149:0] i_fscan_pma0_sdi_word_l0_0, //Scan data bus
input [41:0] i_fscan_pma0_sdi_ref_channelleft_l0_0, //Scan data bus
input [41:0] i_fscan_pma0_sdi_ref_channelright_l0_0, //Scan data bus
input [17:0] i_fscan_pma0_sdi_ref_txffe_l0_0, //Scan data bus
input [6:0] i_fscan_pma0_sdi_word_txffe_l0_0, //Scan data bus
input [9:0] i_fscan_pma0_sdi_txpll_l0_0, //Scan data bus
output [19:0] o_ascan_pma0_sdo_ctrl_l0_0, //Scan data bus
output [49:0] o_ascan_pma0_sdo_memarray_word_l0_0, //Scan data bus
output [89:0] o_ascan_pma0_sdo_ref_l0_0, //Scan data bus
output [149:0] o_ascan_pma0_sdo_word_l0_0, //Scan data bus
output [41:0] o_ascan_pma0_sdo_ref_channelleft_l0_0, //Scan data bus
output [41:0] o_ascan_pma0_sdo_ref_channelright_l0_0, //Scan data bus
output [17:0] o_ascan_pma0_sdo_ref_txffe_l0_0, //Scan data bus
output [6:0] o_ascan_pma0_sdo_word_txffe_l0_0, //Scan data bus
output [9:0] o_ascan_pma0_sdo_txpll_l0_0, //Scan data bus
input [79:0] i_fscan_pma1_sdi_ref_cmn_0, //Scan data bus
input [3:0] i_fscan_pma1_sdi_apb_cmn_0, //Scan data bus
input [41:0] i_fscan_pma1_sdi_ref_channelcmn_0, //Scan data bus
input [9:0] i_fscan_pma1_sdi_cmnplla_0, //Scan data bus
input [9:0] i_fscan_pma1_sdi_cmnpllb_0, //Scan data bus
output [79:0] o_ascan_pma1_sdo_ref_cmn_0, //Scan data bus
output [3:0] o_ascan_pma1_sdo_apb_cmn_0, //Scan data bus
output [41:0] o_ascan_pma1_sdo_ref_channelcmn_0, //Scan data bus
output [9:0] o_ascan_pma1_sdo_cmnplla_0, //Scan data bus
output [9:0] o_ascan_pma1_sdo_cmnpllb_0, //Scan data bus
input [19:0] i_fscan_pma1_sdi_ctrl_l0_0, //Scan data bus
input [49:0] i_fscan_pma1_sdi_memarray_word_l0_0, //Scan data bus
input [89:0] i_fscan_pma1_sdi_ref_l0_0, //Scan data bus
input [149:0] i_fscan_pma1_sdi_word_l0_0, //Scan data bus
input [41:0] i_fscan_pma1_sdi_ref_channelleft_l0_0, //Scan data bus
input [41:0] i_fscan_pma1_sdi_ref_channelright_l0_0, //Scan data bus
input [17:0] i_fscan_pma1_sdi_ref_txffe_l0_0, //Scan data bus
input [6:0] i_fscan_pma1_sdi_word_txffe_l0_0, //Scan data bus
input [9:0] i_fscan_pma1_sdi_txpll_l0_0, //Scan data bus
output [19:0] o_ascan_pma1_sdo_ctrl_l0_0, //Scan data bus
output [49:0] o_ascan_pma1_sdo_memarray_word_l0_0, //Scan data bus
output [89:0] o_ascan_pma1_sdo_ref_l0_0, //Scan data bus
output [149:0] o_ascan_pma1_sdo_word_l0_0, //Scan data bus
output [41:0] o_ascan_pma1_sdo_ref_channelleft_l0_0, //Scan data bus
output [41:0] o_ascan_pma1_sdo_ref_channelright_l0_0, //Scan data bus
output [17:0] o_ascan_pma1_sdo_ref_txffe_l0_0, //Scan data bus
output [6:0] o_ascan_pma1_sdo_word_txffe_l0_0, //Scan data bus
output [9:0] o_ascan_pma1_sdo_txpll_l0_0, //Scan data bus
input [79:0] i_fscan_pma2_sdi_ref_cmn_0, //Scan data bus
input [3:0] i_fscan_pma2_sdi_apb_cmn_0, //Scan data bus
input [41:0] i_fscan_pma2_sdi_ref_channelcmn_0, //Scan data bus
input [9:0] i_fscan_pma2_sdi_cmnplla_0, //Scan data bus
input [9:0] i_fscan_pma2_sdi_cmnpllb_0, //Scan data bus
output [79:0] o_ascan_pma2_sdo_ref_cmn_0, //Scan data bus
output [3:0] o_ascan_pma2_sdo_apb_cmn_0, //Scan data bus
output [41:0] o_ascan_pma2_sdo_ref_channelcmn_0, //Scan data bus
output [9:0] o_ascan_pma2_sdo_cmnplla_0, //Scan data bus
output [9:0] o_ascan_pma2_sdo_cmnpllb_0, //Scan data bus
input [19:0] i_fscan_pma2_sdi_ctrl_l0_0, //Scan data bus
input [49:0] i_fscan_pma2_sdi_memarray_word_l0_0, //Scan data bus
input [89:0] i_fscan_pma2_sdi_ref_l0_0, //Scan data bus
input [149:0] i_fscan_pma2_sdi_word_l0_0, //Scan data bus
input [41:0] i_fscan_pma2_sdi_ref_channelleft_l0_0, //Scan data bus
input [41:0] i_fscan_pma2_sdi_ref_channelright_l0_0, //Scan data bus
input [17:0] i_fscan_pma2_sdi_ref_txffe_l0_0, //Scan data bus
input [6:0] i_fscan_pma2_sdi_word_txffe_l0_0, //Scan data bus
input [9:0] i_fscan_pma2_sdi_txpll_l0_0, //Scan data bus
output [19:0] o_ascan_pma2_sdo_ctrl_l0_0, //Scan data bus
output [49:0] o_ascan_pma2_sdo_memarray_word_l0_0, //Scan data bus
output [89:0] o_ascan_pma2_sdo_ref_l0_0, //Scan data bus
output [149:0] o_ascan_pma2_sdo_word_l0_0, //Scan data bus
output [41:0] o_ascan_pma2_sdo_ref_channelleft_l0_0, //Scan data bus
output [41:0] o_ascan_pma2_sdo_ref_channelright_l0_0, //Scan data bus
output [17:0] o_ascan_pma2_sdo_ref_txffe_l0_0, //Scan data bus
output [6:0] o_ascan_pma2_sdo_word_txffe_l0_0, //Scan data bus
output [9:0] o_ascan_pma2_sdo_txpll_l0_0, //Scan data bus
input [79:0] i_fscan_pma3_sdi_ref_cmn_0, //Scan data bus
input [3:0] i_fscan_pma3_sdi_apb_cmn_0, //Scan data bus
input [41:0] i_fscan_pma3_sdi_ref_channelcmn_0, //Scan data bus
input [9:0] i_fscan_pma3_sdi_cmnplla_0, //Scan data bus
input [9:0] i_fscan_pma3_sdi_cmnpllb_0, //Scan data bus
output [79:0] o_ascan_pma3_sdo_ref_cmn_0, //Scan data bus
output [3:0] o_ascan_pma3_sdo_apb_cmn_0, //Scan data bus
output [41:0] o_ascan_pma3_sdo_ref_channelcmn_0, //Scan data bus
output [9:0] o_ascan_pma3_sdo_cmnplla_0, //Scan data bus
output [9:0] o_ascan_pma3_sdo_cmnpllb_0, //Scan data bus
input [19:0] i_fscan_pma3_sdi_ctrl_l0_0, //Scan data bus
input [49:0] i_fscan_pma3_sdi_memarray_word_l0_0, //Scan data bus
input [89:0] i_fscan_pma3_sdi_ref_l0_0, //Scan data bus
input [149:0] i_fscan_pma3_sdi_word_l0_0, //Scan data bus
input [41:0] i_fscan_pma3_sdi_ref_channelleft_l0_0, //Scan data bus
input [41:0] i_fscan_pma3_sdi_ref_channelright_l0_0, //Scan data bus
input [17:0] i_fscan_pma3_sdi_ref_txffe_l0_0, //Scan data bus
input [6:0] i_fscan_pma3_sdi_word_txffe_l0_0, //Scan data bus
input [9:0] i_fscan_pma3_sdi_txpll_l0_0, //Scan data bus
output [19:0] o_ascan_pma3_sdo_ctrl_l0_0, //Scan data bus
output [49:0] o_ascan_pma3_sdo_memarray_word_l0_0, //Scan data bus
output [89:0] o_ascan_pma3_sdo_ref_l0_0, //Scan data bus
output [149:0] o_ascan_pma3_sdo_word_l0_0, //Scan data bus
output [41:0] o_ascan_pma3_sdo_ref_channelleft_l0_0, //Scan data bus
output [41:0] o_ascan_pma3_sdo_ref_channelright_l0_0, //Scan data bus
output [17:0] o_ascan_pma3_sdo_ref_txffe_l0_0, //Scan data bus
output [6:0] o_ascan_pma3_sdo_word_txffe_l0_0, //Scan data bus
output [9:0] o_ascan_pma3_sdo_txpll_l0_0, //Scan data bus
input i_ck_fscan_pma_ref_1, //Scan clock for reference clock domain. Driven by SOC at SOC level
input i_ck_fscan_pma_apb_1, //Scan clock for APB clock domain. Driven by SOC at SOC level
input i_ck_fscan_pma_cmnpll_postdiv_1, //Scan clock for CMN PLL postdivider logic
input i_ck_fscan_pma_postclk_refclk_clk_cmnpll_1, //Scan clock for CMN PLL A and CMN PLL B logic
input i_ck_fscan_pma_postclk_refclk_clk_txpll_1, //Scan clock for TxPLL PLL logic for all lanes
input i_ck_fscan_ucss_postclk_1, //Scan clock
input i_fscan_clkgenctrl_nt_1, //Unused
input i_fscan_clkgenctrlen_nt_1, //TBD
input i_fscan_clkungate_nt_1, //Enable for architectural clock gating
input i_fscan_clkungate_syn_nt_1, //Enable for power complier inserted clock gating
input i_fscan_shiften_nt_1, //Enable for shift mode. 1'b0: Capture mode. 1'b1: Shift mode
input i_fscan_latchclosed_b_nt_1, //PLL Active low latch control
input i_fscan_latchopen_nt_1, //PLL Active high latch control
input i_fscan_mode_atspeed_nt_1, //This is a static signal that indicates that the device is in atspeed scan mode. Not used currently. It can be used in case any difference arises in terms of clocking or if need to bypass any logic from scan in the at-speed mode in future
input i_fscan_mode_nt_1, //Enables scan test mode
input i_fscan_ret_control_nt_1, //PLL Active low latch control
input i_rst_fscan_byprst_b_1, //Scan reset bypass
input i_rst_fscan_byplatrst_b_1, //TBD
input i_fscan_rstbypen_nt_1, //This is a static signal this is used to mux the scan reset i.e. i_rst_fscan_byprst_b signal onto the functional resets within the IPs when this signal is set to 1'b1
input i_fscan_slos_en_nt_1, //SLOS enable signal. Set to 1 to enable synchronous launch off shift feature in ATPG.
input i_fscan_chain_bypass_nt_1, //pll chain bypass enable
input i_fscan_latch_bypass_in_nt_1, //chain latch in bypass enable
input i_fscan_latch_bypass_out_nt_1, //chain latch out bypass enable
input i_fscan_pll_isolate_nt_1, //Currently unused.
input i_fscan_pll_scan_if_dis_nt_1, //disable scan controls.
input [79:0] i_fscan_pma0_sdi_ref_cmn_1, //Scan data bus
input [3:0] i_fscan_pma0_sdi_apb_cmn_1, //Scan data bus
input [41:0] i_fscan_pma0_sdi_ref_channelcmn_1, //Scan data bus
input [9:0] i_fscan_pma0_sdi_cmnplla_1, //Scan data bus
input [9:0] i_fscan_pma0_sdi_cmnpllb_1, //Scan data bus
output [79:0] o_ascan_pma0_sdo_ref_cmn_1, //Scan data bus
output [3:0] o_ascan_pma0_sdo_apb_cmn_1, //Scan data bus
output [41:0] o_ascan_pma0_sdo_ref_channelcmn_1, //Scan data bus
output [9:0] o_ascan_pma0_sdo_cmnplla_1, //Scan data bus
output [9:0] o_ascan_pma0_sdo_cmnpllb_1, //Scan data bus
input [19:0] i_fscan_pma0_sdi_ctrl_l0_1, //Scan data bus
input [49:0] i_fscan_pma0_sdi_memarray_word_l0_1, //Scan data bus
input [89:0] i_fscan_pma0_sdi_ref_l0_1, //Scan data bus
input [149:0] i_fscan_pma0_sdi_word_l0_1, //Scan data bus
input [41:0] i_fscan_pma0_sdi_ref_channelleft_l0_1, //Scan data bus
input [41:0] i_fscan_pma0_sdi_ref_channelright_l0_1, //Scan data bus
input [17:0] i_fscan_pma0_sdi_ref_txffe_l0_1, //Scan data bus
input [6:0] i_fscan_pma0_sdi_word_txffe_l0_1, //Scan data bus
input [9:0] i_fscan_pma0_sdi_txpll_l0_1, //Scan data bus
output [19:0] o_ascan_pma0_sdo_ctrl_l0_1, //Scan data bus
output [49:0] o_ascan_pma0_sdo_memarray_word_l0_1, //Scan data bus
output [89:0] o_ascan_pma0_sdo_ref_l0_1, //Scan data bus
output [149:0] o_ascan_pma0_sdo_word_l0_1, //Scan data bus
output [41:0] o_ascan_pma0_sdo_ref_channelleft_l0_1, //Scan data bus
output [41:0] o_ascan_pma0_sdo_ref_channelright_l0_1, //Scan data bus
output [17:0] o_ascan_pma0_sdo_ref_txffe_l0_1, //Scan data bus
output [6:0] o_ascan_pma0_sdo_word_txffe_l0_1, //Scan data bus
output [9:0] o_ascan_pma0_sdo_txpll_l0_1, //Scan data bus
input [79:0] i_fscan_pma1_sdi_ref_cmn_1, //Scan data bus
input [3:0] i_fscan_pma1_sdi_apb_cmn_1, //Scan data bus
input [41:0] i_fscan_pma1_sdi_ref_channelcmn_1, //Scan data bus
input [9:0] i_fscan_pma1_sdi_cmnplla_1, //Scan data bus
input [9:0] i_fscan_pma1_sdi_cmnpllb_1, //Scan data bus
output [79:0] o_ascan_pma1_sdo_ref_cmn_1, //Scan data bus
output [3:0] o_ascan_pma1_sdo_apb_cmn_1, //Scan data bus
output [41:0] o_ascan_pma1_sdo_ref_channelcmn_1, //Scan data bus
output [9:0] o_ascan_pma1_sdo_cmnplla_1, //Scan data bus
output [9:0] o_ascan_pma1_sdo_cmnpllb_1, //Scan data bus
input [19:0] i_fscan_pma1_sdi_ctrl_l0_1, //Scan data bus
input [49:0] i_fscan_pma1_sdi_memarray_word_l0_1, //Scan data bus
input [89:0] i_fscan_pma1_sdi_ref_l0_1, //Scan data bus
input [149:0] i_fscan_pma1_sdi_word_l0_1, //Scan data bus
input [41:0] i_fscan_pma1_sdi_ref_channelleft_l0_1, //Scan data bus
input [41:0] i_fscan_pma1_sdi_ref_channelright_l0_1, //Scan data bus
input [17:0] i_fscan_pma1_sdi_ref_txffe_l0_1, //Scan data bus
input [6:0] i_fscan_pma1_sdi_word_txffe_l0_1, //Scan data bus
input [9:0] i_fscan_pma1_sdi_txpll_l0_1, //Scan data bus
output [19:0] o_ascan_pma1_sdo_ctrl_l0_1, //Scan data bus
output [49:0] o_ascan_pma1_sdo_memarray_word_l0_1, //Scan data bus
output [89:0] o_ascan_pma1_sdo_ref_l0_1, //Scan data bus
output [149:0] o_ascan_pma1_sdo_word_l0_1, //Scan data bus
output [41:0] o_ascan_pma1_sdo_ref_channelleft_l0_1, //Scan data bus
output [41:0] o_ascan_pma1_sdo_ref_channelright_l0_1, //Scan data bus
output [17:0] o_ascan_pma1_sdo_ref_txffe_l0_1, //Scan data bus
output [6:0] o_ascan_pma1_sdo_word_txffe_l0_1, //Scan data bus
output [9:0] o_ascan_pma1_sdo_txpll_l0_1, //Scan data bus
input [79:0] i_fscan_pma2_sdi_ref_cmn_1, //Scan data bus
input [3:0] i_fscan_pma2_sdi_apb_cmn_1, //Scan data bus
input [41:0] i_fscan_pma2_sdi_ref_channelcmn_1, //Scan data bus
input [9:0] i_fscan_pma2_sdi_cmnplla_1, //Scan data bus
input [9:0] i_fscan_pma2_sdi_cmnpllb_1, //Scan data bus
output [79:0] o_ascan_pma2_sdo_ref_cmn_1, //Scan data bus
output [3:0] o_ascan_pma2_sdo_apb_cmn_1, //Scan data bus
output [41:0] o_ascan_pma2_sdo_ref_channelcmn_1, //Scan data bus
output [9:0] o_ascan_pma2_sdo_cmnplla_1, //Scan data bus
output [9:0] o_ascan_pma2_sdo_cmnpllb_1, //Scan data bus
input [19:0] i_fscan_pma2_sdi_ctrl_l0_1, //Scan data bus
input [49:0] i_fscan_pma2_sdi_memarray_word_l0_1, //Scan data bus
input [89:0] i_fscan_pma2_sdi_ref_l0_1, //Scan data bus
input [149:0] i_fscan_pma2_sdi_word_l0_1, //Scan data bus
input [41:0] i_fscan_pma2_sdi_ref_channelleft_l0_1, //Scan data bus
input [41:0] i_fscan_pma2_sdi_ref_channelright_l0_1, //Scan data bus
input [17:0] i_fscan_pma2_sdi_ref_txffe_l0_1, //Scan data bus
input [6:0] i_fscan_pma2_sdi_word_txffe_l0_1, //Scan data bus
input [9:0] i_fscan_pma2_sdi_txpll_l0_1, //Scan data bus
output [19:0] o_ascan_pma2_sdo_ctrl_l0_1, //Scan data bus
output [49:0] o_ascan_pma2_sdo_memarray_word_l0_1, //Scan data bus
output [89:0] o_ascan_pma2_sdo_ref_l0_1, //Scan data bus
output [149:0] o_ascan_pma2_sdo_word_l0_1, //Scan data bus
output [41:0] o_ascan_pma2_sdo_ref_channelleft_l0_1, //Scan data bus
output [41:0] o_ascan_pma2_sdo_ref_channelright_l0_1, //Scan data bus
output [17:0] o_ascan_pma2_sdo_ref_txffe_l0_1, //Scan data bus
output [6:0] o_ascan_pma2_sdo_word_txffe_l0_1, //Scan data bus
output [9:0] o_ascan_pma2_sdo_txpll_l0_1, //Scan data bus
input [79:0] i_fscan_pma3_sdi_ref_cmn_1, //Scan data bus
input [3:0] i_fscan_pma3_sdi_apb_cmn_1, //Scan data bus
input [41:0] i_fscan_pma3_sdi_ref_channelcmn_1, //Scan data bus
input [9:0] i_fscan_pma3_sdi_cmnplla_1, //Scan data bus
input [9:0] i_fscan_pma3_sdi_cmnpllb_1, //Scan data bus
output [79:0] o_ascan_pma3_sdo_ref_cmn_1, //Scan data bus
output [3:0] o_ascan_pma3_sdo_apb_cmn_1, //Scan data bus
output [41:0] o_ascan_pma3_sdo_ref_channelcmn_1, //Scan data bus
output [9:0] o_ascan_pma3_sdo_cmnplla_1, //Scan data bus
output [9:0] o_ascan_pma3_sdo_cmnpllb_1, //Scan data bus
input [19:0] i_fscan_pma3_sdi_ctrl_l0_1, //Scan data bus
input [49:0] i_fscan_pma3_sdi_memarray_word_l0_1, //Scan data bus
input [89:0] i_fscan_pma3_sdi_ref_l0_1, //Scan data bus
input [149:0] i_fscan_pma3_sdi_word_l0_1, //Scan data bus
input [41:0] i_fscan_pma3_sdi_ref_channelleft_l0_1, //Scan data bus
input [41:0] i_fscan_pma3_sdi_ref_channelright_l0_1, //Scan data bus
input [17:0] i_fscan_pma3_sdi_ref_txffe_l0_1, //Scan data bus
input [6:0] i_fscan_pma3_sdi_word_txffe_l0_1, //Scan data bus
input [9:0] i_fscan_pma3_sdi_txpll_l0_1, //Scan data bus
output [19:0] o_ascan_pma3_sdo_ctrl_l0_1, //Scan data bus
output [49:0] o_ascan_pma3_sdo_memarray_word_l0_1, //Scan data bus
output [89:0] o_ascan_pma3_sdo_ref_l0_1, //Scan data bus
output [149:0] o_ascan_pma3_sdo_word_l0_1, //Scan data bus
output [41:0] o_ascan_pma3_sdo_ref_channelleft_l0_1, //Scan data bus
output [41:0] o_ascan_pma3_sdo_ref_channelright_l0_1, //Scan data bus
output [17:0] o_ascan_pma3_sdo_ref_txffe_l0_1, //Scan data bus
output [6:0] o_ascan_pma3_sdo_word_txffe_l0_1, //Scan data bus
output [9:0] o_ascan_pma3_sdo_txpll_l0_1, //Scan data bus
input i_ck_fscan_pma_ref_2, //Scan clock for reference clock domain. Driven by SOC at SOC level
input i_ck_fscan_pma_apb_2, //Scan clock for APB clock domain. Driven by SOC at SOC level
input i_ck_fscan_pma_cmnpll_postdiv_2, //Scan clock for CMN PLL postdivider logic
input i_ck_fscan_pma_postclk_refclk_clk_cmnpll_2, //Scan clock for CMN PLL A and CMN PLL B logic
input i_ck_fscan_pma_postclk_refclk_clk_txpll_2, //Scan clock for TxPLL PLL logic for all lanes
input i_ck_fscan_ucss_postclk_2, //Scan clock
input i_fscan_clkgenctrl_nt_2, //Unused
input i_fscan_clkgenctrlen_nt_2, //TBD
input i_fscan_clkungate_nt_2, //Enable for architectural clock gating
input i_fscan_clkungate_syn_nt_2, //Enable for power complier inserted clock gating
input i_fscan_shiften_nt_2, //Enable for shift mode. 1'b0: Capture mode. 1'b1: Shift mode
input i_fscan_latchclosed_b_nt_2, //PLL Active low latch control
input i_fscan_latchopen_nt_2, //PLL Active high latch control
input i_fscan_mode_atspeed_nt_2, //This is a static signal that indicates that the device is in atspeed scan mode. Not used currently. It can be used in case any difference arises in terms of clocking or if need to bypass any logic from scan in the at-speed mode in future
input i_fscan_mode_nt_2, //Enables scan test mode
input i_fscan_ret_control_nt_2, //PLL Active low latch control
input i_rst_fscan_byprst_b_2, //Scan reset bypass
input i_rst_fscan_byplatrst_b_2, //TBD
input i_fscan_rstbypen_nt_2, //This is a static signal this is used to mux the scan reset i.e. i_rst_fscan_byprst_b signal onto the functional resets within the IPs when this signal is set to 1'b1
input i_fscan_slos_en_nt_2, //SLOS enable signal. Set to 1 to enable synchronous launch off shift feature in ATPG.
input i_fscan_chain_bypass_nt_2, //pll chain bypass enable
input i_fscan_latch_bypass_in_nt_2, //chain latch in bypass enable
input i_fscan_latch_bypass_out_nt_2, //chain latch out bypass enable
input i_fscan_pll_isolate_nt_2, //Currently unused.
input i_fscan_pll_scan_if_dis_nt_2, //disable scan controls.
input [79:0] i_fscan_pma0_sdi_ref_cmn_2, //Scan data bus
input [3:0] i_fscan_pma0_sdi_apb_cmn_2, //Scan data bus
input [41:0] i_fscan_pma0_sdi_ref_channelcmn_2, //Scan data bus
input [9:0] i_fscan_pma0_sdi_cmnplla_2, //Scan data bus
input [9:0] i_fscan_pma0_sdi_cmnpllb_2, //Scan data bus
output [79:0] o_ascan_pma0_sdo_ref_cmn_2, //Scan data bus
output [3:0] o_ascan_pma0_sdo_apb_cmn_2, //Scan data bus
output [41:0] o_ascan_pma0_sdo_ref_channelcmn_2, //Scan data bus
output [9:0] o_ascan_pma0_sdo_cmnplla_2, //Scan data bus
output [9:0] o_ascan_pma0_sdo_cmnpllb_2, //Scan data bus
input [19:0] i_fscan_pma0_sdi_ctrl_l0_2, //Scan data bus
input [49:0] i_fscan_pma0_sdi_memarray_word_l0_2, //Scan data bus
input [89:0] i_fscan_pma0_sdi_ref_l0_2, //Scan data bus
input [149:0] i_fscan_pma0_sdi_word_l0_2, //Scan data bus
input [41:0] i_fscan_pma0_sdi_ref_channelleft_l0_2, //Scan data bus
input [41:0] i_fscan_pma0_sdi_ref_channelright_l0_2, //Scan data bus
input [17:0] i_fscan_pma0_sdi_ref_txffe_l0_2, //Scan data bus
input [6:0] i_fscan_pma0_sdi_word_txffe_l0_2, //Scan data bus
input [9:0] i_fscan_pma0_sdi_txpll_l0_2, //Scan data bus
output [19:0] o_ascan_pma0_sdo_ctrl_l0_2, //Scan data bus
output [49:0] o_ascan_pma0_sdo_memarray_word_l0_2, //Scan data bus
output [89:0] o_ascan_pma0_sdo_ref_l0_2, //Scan data bus
output [149:0] o_ascan_pma0_sdo_word_l0_2, //Scan data bus
output [41:0] o_ascan_pma0_sdo_ref_channelleft_l0_2, //Scan data bus
output [41:0] o_ascan_pma0_sdo_ref_channelright_l0_2, //Scan data bus
output [17:0] o_ascan_pma0_sdo_ref_txffe_l0_2, //Scan data bus
output [6:0] o_ascan_pma0_sdo_word_txffe_l0_2, //Scan data bus
output [9:0] o_ascan_pma0_sdo_txpll_l0_2, //Scan data bus
input [79:0] i_fscan_pma1_sdi_ref_cmn_2, //Scan data bus
input [3:0] i_fscan_pma1_sdi_apb_cmn_2, //Scan data bus
input [41:0] i_fscan_pma1_sdi_ref_channelcmn_2, //Scan data bus
input [9:0] i_fscan_pma1_sdi_cmnplla_2, //Scan data bus
input [9:0] i_fscan_pma1_sdi_cmnpllb_2, //Scan data bus
output [79:0] o_ascan_pma1_sdo_ref_cmn_2, //Scan data bus
output [3:0] o_ascan_pma1_sdo_apb_cmn_2, //Scan data bus
output [41:0] o_ascan_pma1_sdo_ref_channelcmn_2, //Scan data bus
output [9:0] o_ascan_pma1_sdo_cmnplla_2, //Scan data bus
output [9:0] o_ascan_pma1_sdo_cmnpllb_2, //Scan data bus
input [19:0] i_fscan_pma1_sdi_ctrl_l0_2, //Scan data bus
input [49:0] i_fscan_pma1_sdi_memarray_word_l0_2, //Scan data bus
input [89:0] i_fscan_pma1_sdi_ref_l0_2, //Scan data bus
input [149:0] i_fscan_pma1_sdi_word_l0_2, //Scan data bus
input [41:0] i_fscan_pma1_sdi_ref_channelleft_l0_2, //Scan data bus
input [41:0] i_fscan_pma1_sdi_ref_channelright_l0_2, //Scan data bus
input [17:0] i_fscan_pma1_sdi_ref_txffe_l0_2, //Scan data bus
input [6:0] i_fscan_pma1_sdi_word_txffe_l0_2, //Scan data bus
input [9:0] i_fscan_pma1_sdi_txpll_l0_2, //Scan data bus
output [19:0] o_ascan_pma1_sdo_ctrl_l0_2, //Scan data bus
output [49:0] o_ascan_pma1_sdo_memarray_word_l0_2, //Scan data bus
output [89:0] o_ascan_pma1_sdo_ref_l0_2, //Scan data bus
output [149:0] o_ascan_pma1_sdo_word_l0_2, //Scan data bus
output [41:0] o_ascan_pma1_sdo_ref_channelleft_l0_2, //Scan data bus
output [41:0] o_ascan_pma1_sdo_ref_channelright_l0_2, //Scan data bus
output [17:0] o_ascan_pma1_sdo_ref_txffe_l0_2, //Scan data bus
output [6:0] o_ascan_pma1_sdo_word_txffe_l0_2, //Scan data bus
output [9:0] o_ascan_pma1_sdo_txpll_l0_2, //Scan data bus
input [79:0] i_fscan_pma2_sdi_ref_cmn_2, //Scan data bus
input [3:0] i_fscan_pma2_sdi_apb_cmn_2, //Scan data bus
input [41:0] i_fscan_pma2_sdi_ref_channelcmn_2, //Scan data bus
input [9:0] i_fscan_pma2_sdi_cmnplla_2, //Scan data bus
input [9:0] i_fscan_pma2_sdi_cmnpllb_2, //Scan data bus
output [79:0] o_ascan_pma2_sdo_ref_cmn_2, //Scan data bus
output [3:0] o_ascan_pma2_sdo_apb_cmn_2, //Scan data bus
output [41:0] o_ascan_pma2_sdo_ref_channelcmn_2, //Scan data bus
output [9:0] o_ascan_pma2_sdo_cmnplla_2, //Scan data bus
output [9:0] o_ascan_pma2_sdo_cmnpllb_2, //Scan data bus
input [19:0] i_fscan_pma2_sdi_ctrl_l0_2, //Scan data bus
input [49:0] i_fscan_pma2_sdi_memarray_word_l0_2, //Scan data bus
input [89:0] i_fscan_pma2_sdi_ref_l0_2, //Scan data bus
input [149:0] i_fscan_pma2_sdi_word_l0_2, //Scan data bus
input [41:0] i_fscan_pma2_sdi_ref_channelleft_l0_2, //Scan data bus
input [41:0] i_fscan_pma2_sdi_ref_channelright_l0_2, //Scan data bus
input [17:0] i_fscan_pma2_sdi_ref_txffe_l0_2, //Scan data bus
input [6:0] i_fscan_pma2_sdi_word_txffe_l0_2, //Scan data bus
input [9:0] i_fscan_pma2_sdi_txpll_l0_2, //Scan data bus
output [19:0] o_ascan_pma2_sdo_ctrl_l0_2, //Scan data bus
output [49:0] o_ascan_pma2_sdo_memarray_word_l0_2, //Scan data bus
output [89:0] o_ascan_pma2_sdo_ref_l0_2, //Scan data bus
output [149:0] o_ascan_pma2_sdo_word_l0_2, //Scan data bus
output [41:0] o_ascan_pma2_sdo_ref_channelleft_l0_2, //Scan data bus
output [41:0] o_ascan_pma2_sdo_ref_channelright_l0_2, //Scan data bus
output [17:0] o_ascan_pma2_sdo_ref_txffe_l0_2, //Scan data bus
output [6:0] o_ascan_pma2_sdo_word_txffe_l0_2, //Scan data bus
output [9:0] o_ascan_pma2_sdo_txpll_l0_2, //Scan data bus
input [79:0] i_fscan_pma3_sdi_ref_cmn_2, //Scan data bus
input [3:0] i_fscan_pma3_sdi_apb_cmn_2, //Scan data bus
input [41:0] i_fscan_pma3_sdi_ref_channelcmn_2, //Scan data bus
input [9:0] i_fscan_pma3_sdi_cmnplla_2, //Scan data bus
input [9:0] i_fscan_pma3_sdi_cmnpllb_2, //Scan data bus
output [79:0] o_ascan_pma3_sdo_ref_cmn_2, //Scan data bus
output [3:0] o_ascan_pma3_sdo_apb_cmn_2, //Scan data bus
output [41:0] o_ascan_pma3_sdo_ref_channelcmn_2, //Scan data bus
output [9:0] o_ascan_pma3_sdo_cmnplla_2, //Scan data bus
output [9:0] o_ascan_pma3_sdo_cmnpllb_2, //Scan data bus
input [19:0] i_fscan_pma3_sdi_ctrl_l0_2, //Scan data bus
input [49:0] i_fscan_pma3_sdi_memarray_word_l0_2, //Scan data bus
input [89:0] i_fscan_pma3_sdi_ref_l0_2, //Scan data bus
input [149:0] i_fscan_pma3_sdi_word_l0_2, //Scan data bus
input [41:0] i_fscan_pma3_sdi_ref_channelleft_l0_2, //Scan data bus
input [41:0] i_fscan_pma3_sdi_ref_channelright_l0_2, //Scan data bus
input [17:0] i_fscan_pma3_sdi_ref_txffe_l0_2, //Scan data bus
input [6:0] i_fscan_pma3_sdi_word_txffe_l0_2, //Scan data bus
input [9:0] i_fscan_pma3_sdi_txpll_l0_2, //Scan data bus
output [19:0] o_ascan_pma3_sdo_ctrl_l0_2, //Scan data bus
output [49:0] o_ascan_pma3_sdo_memarray_word_l0_2, //Scan data bus
output [89:0] o_ascan_pma3_sdo_ref_l0_2, //Scan data bus
output [149:0] o_ascan_pma3_sdo_word_l0_2, //Scan data bus
output [41:0] o_ascan_pma3_sdo_ref_channelleft_l0_2, //Scan data bus
output [41:0] o_ascan_pma3_sdo_ref_channelright_l0_2, //Scan data bus
output [17:0] o_ascan_pma3_sdo_ref_txffe_l0_2, //Scan data bus
output [6:0] o_ascan_pma3_sdo_word_txffe_l0_2, //Scan data bus
output [9:0] o_ascan_pma3_sdo_txpll_l0_2, //Scan data bus
input i_ck_fscan_pma_ref_3, //Scan clock for reference clock domain. Driven by SOC at SOC level
input i_ck_fscan_pma_apb_3, //Scan clock for APB clock domain. Driven by SOC at SOC level
input i_ck_fscan_pma_cmnpll_postdiv_3, //Scan clock for CMN PLL postdivider logic
input i_ck_fscan_pma_postclk_refclk_clk_cmnpll_3, //Scan clock for CMN PLL A and CMN PLL B logic
input i_ck_fscan_pma_postclk_refclk_clk_txpll_3, //Scan clock for TxPLL PLL logic for all lanes
input i_ck_fscan_ucss_postclk_3, //Scan clock
input i_fscan_clkgenctrl_nt_3, //Unused
input i_fscan_clkgenctrlen_nt_3, //TBD
input i_fscan_clkungate_nt_3, //Enable for architectural clock gating
input i_fscan_clkungate_syn_nt_3, //Enable for power complier inserted clock gating
input i_fscan_shiften_nt_3, //Enable for shift mode. 1'b0: Capture mode. 1'b1: Shift mode
input i_fscan_latchclosed_b_nt_3, //PLL Active low latch control
input i_fscan_latchopen_nt_3, //PLL Active high latch control
input i_fscan_mode_atspeed_nt_3, //This is a static signal that indicates that the device is in atspeed scan mode. Not used currently. It can be used in case any difference arises in terms of clocking or if need to bypass any logic from scan in the at-speed mode in future
input i_fscan_mode_nt_3, //Enables scan test mode
input i_fscan_ret_control_nt_3, //PLL Active low latch control
input i_rst_fscan_byprst_b_3, //Scan reset bypass
input i_rst_fscan_byplatrst_b_3, //TBD
input i_fscan_rstbypen_nt_3, //This is a static signal this is used to mux the scan reset i.e. i_rst_fscan_byprst_b signal onto the functional resets within the IPs when this signal is set to 1'b1
input i_fscan_slos_en_nt_3, //SLOS enable signal. Set to 1 to enable synchronous launch off shift feature in ATPG.
input i_fscan_chain_bypass_nt_3, //pll chain bypass enable
input i_fscan_latch_bypass_in_nt_3, //chain latch in bypass enable
input i_fscan_latch_bypass_out_nt_3, //chain latch out bypass enable
input i_fscan_pll_isolate_nt_3, //Currently unused.
input i_fscan_pll_scan_if_dis_nt_3, //disable scan controls.
input [79:0] i_fscan_pma0_sdi_ref_cmn_3, //Scan data bus
input [3:0] i_fscan_pma0_sdi_apb_cmn_3, //Scan data bus
input [41:0] i_fscan_pma0_sdi_ref_channelcmn_3, //Scan data bus
input [9:0] i_fscan_pma0_sdi_cmnplla_3, //Scan data bus
input [9:0] i_fscan_pma0_sdi_cmnpllb_3, //Scan data bus
output [79:0] o_ascan_pma0_sdo_ref_cmn_3, //Scan data bus
output [3:0] o_ascan_pma0_sdo_apb_cmn_3, //Scan data bus
output [41:0] o_ascan_pma0_sdo_ref_channelcmn_3, //Scan data bus
output [9:0] o_ascan_pma0_sdo_cmnplla_3, //Scan data bus
output [9:0] o_ascan_pma0_sdo_cmnpllb_3, //Scan data bus
input [19:0] i_fscan_pma0_sdi_ctrl_l0_3, //Scan data bus
input [49:0] i_fscan_pma0_sdi_memarray_word_l0_3, //Scan data bus
input [89:0] i_fscan_pma0_sdi_ref_l0_3, //Scan data bus
input [149:0] i_fscan_pma0_sdi_word_l0_3, //Scan data bus
input [41:0] i_fscan_pma0_sdi_ref_channelleft_l0_3, //Scan data bus
input [41:0] i_fscan_pma0_sdi_ref_channelright_l0_3, //Scan data bus
input [17:0] i_fscan_pma0_sdi_ref_txffe_l0_3, //Scan data bus
input [6:0] i_fscan_pma0_sdi_word_txffe_l0_3, //Scan data bus
input [9:0] i_fscan_pma0_sdi_txpll_l0_3, //Scan data bus
output [19:0] o_ascan_pma0_sdo_ctrl_l0_3, //Scan data bus
output [49:0] o_ascan_pma0_sdo_memarray_word_l0_3, //Scan data bus
output [89:0] o_ascan_pma0_sdo_ref_l0_3, //Scan data bus
output [149:0] o_ascan_pma0_sdo_word_l0_3, //Scan data bus
output [41:0] o_ascan_pma0_sdo_ref_channelleft_l0_3, //Scan data bus
output [41:0] o_ascan_pma0_sdo_ref_channelright_l0_3, //Scan data bus
output [17:0] o_ascan_pma0_sdo_ref_txffe_l0_3, //Scan data bus
output [6:0] o_ascan_pma0_sdo_word_txffe_l0_3, //Scan data bus
output [9:0] o_ascan_pma0_sdo_txpll_l0_3, //Scan data bus
input [79:0] i_fscan_pma1_sdi_ref_cmn_3, //Scan data bus
input [3:0] i_fscan_pma1_sdi_apb_cmn_3, //Scan data bus
input [41:0] i_fscan_pma1_sdi_ref_channelcmn_3, //Scan data bus
input [9:0] i_fscan_pma1_sdi_cmnplla_3, //Scan data bus
input [9:0] i_fscan_pma1_sdi_cmnpllb_3, //Scan data bus
output [79:0] o_ascan_pma1_sdo_ref_cmn_3, //Scan data bus
output [3:0] o_ascan_pma1_sdo_apb_cmn_3, //Scan data bus
output [41:0] o_ascan_pma1_sdo_ref_channelcmn_3, //Scan data bus
output [9:0] o_ascan_pma1_sdo_cmnplla_3, //Scan data bus
output [9:0] o_ascan_pma1_sdo_cmnpllb_3, //Scan data bus
input [19:0] i_fscan_pma1_sdi_ctrl_l0_3, //Scan data bus
input [49:0] i_fscan_pma1_sdi_memarray_word_l0_3, //Scan data bus
input [89:0] i_fscan_pma1_sdi_ref_l0_3, //Scan data bus
input [149:0] i_fscan_pma1_sdi_word_l0_3, //Scan data bus
input [41:0] i_fscan_pma1_sdi_ref_channelleft_l0_3, //Scan data bus
input [41:0] i_fscan_pma1_sdi_ref_channelright_l0_3, //Scan data bus
input [17:0] i_fscan_pma1_sdi_ref_txffe_l0_3, //Scan data bus
input [6:0] i_fscan_pma1_sdi_word_txffe_l0_3, //Scan data bus
input [9:0] i_fscan_pma1_sdi_txpll_l0_3, //Scan data bus
output [19:0] o_ascan_pma1_sdo_ctrl_l0_3, //Scan data bus
output [49:0] o_ascan_pma1_sdo_memarray_word_l0_3, //Scan data bus
output [89:0] o_ascan_pma1_sdo_ref_l0_3, //Scan data bus
output [149:0] o_ascan_pma1_sdo_word_l0_3, //Scan data bus
output [41:0] o_ascan_pma1_sdo_ref_channelleft_l0_3, //Scan data bus
output [41:0] o_ascan_pma1_sdo_ref_channelright_l0_3, //Scan data bus
output [17:0] o_ascan_pma1_sdo_ref_txffe_l0_3, //Scan data bus
output [6:0] o_ascan_pma1_sdo_word_txffe_l0_3, //Scan data bus
output [9:0] o_ascan_pma1_sdo_txpll_l0_3, //Scan data bus
input [79:0] i_fscan_pma2_sdi_ref_cmn_3, //Scan data bus
input [3:0] i_fscan_pma2_sdi_apb_cmn_3, //Scan data bus
input [41:0] i_fscan_pma2_sdi_ref_channelcmn_3, //Scan data bus
input [9:0] i_fscan_pma2_sdi_cmnplla_3, //Scan data bus
input [9:0] i_fscan_pma2_sdi_cmnpllb_3, //Scan data bus
output [79:0] o_ascan_pma2_sdo_ref_cmn_3, //Scan data bus
output [3:0] o_ascan_pma2_sdo_apb_cmn_3, //Scan data bus
output [41:0] o_ascan_pma2_sdo_ref_channelcmn_3, //Scan data bus
output [9:0] o_ascan_pma2_sdo_cmnplla_3, //Scan data bus
output [9:0] o_ascan_pma2_sdo_cmnpllb_3, //Scan data bus
input [19:0] i_fscan_pma2_sdi_ctrl_l0_3, //Scan data bus
input [49:0] i_fscan_pma2_sdi_memarray_word_l0_3, //Scan data bus
input [89:0] i_fscan_pma2_sdi_ref_l0_3, //Scan data bus
input [149:0] i_fscan_pma2_sdi_word_l0_3, //Scan data bus
input [41:0] i_fscan_pma2_sdi_ref_channelleft_l0_3, //Scan data bus
input [41:0] i_fscan_pma2_sdi_ref_channelright_l0_3, //Scan data bus
input [17:0] i_fscan_pma2_sdi_ref_txffe_l0_3, //Scan data bus
input [6:0] i_fscan_pma2_sdi_word_txffe_l0_3, //Scan data bus
input [9:0] i_fscan_pma2_sdi_txpll_l0_3, //Scan data bus
output [19:0] o_ascan_pma2_sdo_ctrl_l0_3, //Scan data bus
output [49:0] o_ascan_pma2_sdo_memarray_word_l0_3, //Scan data bus
output [89:0] o_ascan_pma2_sdo_ref_l0_3, //Scan data bus
output [149:0] o_ascan_pma2_sdo_word_l0_3, //Scan data bus
output [41:0] o_ascan_pma2_sdo_ref_channelleft_l0_3, //Scan data bus
output [41:0] o_ascan_pma2_sdo_ref_channelright_l0_3, //Scan data bus
output [17:0] o_ascan_pma2_sdo_ref_txffe_l0_3, //Scan data bus
output [6:0] o_ascan_pma2_sdo_word_txffe_l0_3, //Scan data bus
output [9:0] o_ascan_pma2_sdo_txpll_l0_3, //Scan data bus
input [79:0] i_fscan_pma3_sdi_ref_cmn_3, //Scan data bus
input [3:0] i_fscan_pma3_sdi_apb_cmn_3, //Scan data bus
input [41:0] i_fscan_pma3_sdi_ref_channelcmn_3, //Scan data bus
input [9:0] i_fscan_pma3_sdi_cmnplla_3, //Scan data bus
input [9:0] i_fscan_pma3_sdi_cmnpllb_3, //Scan data bus
output [79:0] o_ascan_pma3_sdo_ref_cmn_3, //Scan data bus
output [3:0] o_ascan_pma3_sdo_apb_cmn_3, //Scan data bus
output [41:0] o_ascan_pma3_sdo_ref_channelcmn_3, //Scan data bus
output [9:0] o_ascan_pma3_sdo_cmnplla_3, //Scan data bus
output [9:0] o_ascan_pma3_sdo_cmnpllb_3, //Scan data bus
input [19:0] i_fscan_pma3_sdi_ctrl_l0_3, //Scan data bus
input [49:0] i_fscan_pma3_sdi_memarray_word_l0_3, //Scan data bus
input [89:0] i_fscan_pma3_sdi_ref_l0_3, //Scan data bus
input [149:0] i_fscan_pma3_sdi_word_l0_3, //Scan data bus
input [41:0] i_fscan_pma3_sdi_ref_channelleft_l0_3, //Scan data bus
input [41:0] i_fscan_pma3_sdi_ref_channelright_l0_3, //Scan data bus
input [17:0] i_fscan_pma3_sdi_ref_txffe_l0_3, //Scan data bus
input [6:0] i_fscan_pma3_sdi_word_txffe_l0_3, //Scan data bus
input [9:0] i_fscan_pma3_sdi_txpll_l0_3, //Scan data bus
output [19:0] o_ascan_pma3_sdo_ctrl_l0_3, //Scan data bus
output [49:0] o_ascan_pma3_sdo_memarray_word_l0_3, //Scan data bus
output [89:0] o_ascan_pma3_sdo_ref_l0_3, //Scan data bus
output [149:0] o_ascan_pma3_sdo_word_l0_3, //Scan data bus
output [41:0] o_ascan_pma3_sdo_ref_channelleft_l0_3, //Scan data bus
output [41:0] o_ascan_pma3_sdo_ref_channelright_l0_3, //Scan data bus
output [17:0] o_ascan_pma3_sdo_ref_txffe_l0_3, //Scan data bus
output [6:0] o_ascan_pma3_sdo_word_txffe_l0_3, //Scan data bus
output [9:0] o_ascan_pma3_sdo_txpll_l0_3, //Scan data bus
input i_scanio_en_nt_0, //Scanio mode enable. 1'b0: Scanio mode disabled. 1'b1: Scanio mode enabled
input i_scanio_pma0_ref0_outen_nt_0, //When in scanio mode direction control for xioa_ck_ref0_*. 1'b0: xioa_ck_ref0_* are both inputs. 1'b1: xioa_ck_ref0_* are both outputs
input i_scanio_pma0_ref1_outen_nt_0, //When in scanio mode direction control for xioa_ck_ref1_*. 1'b0: xioa_ck_ref1_* are both inputs. 1'b1: xioa_ck_ref1_* are both outputs
input i_scanio_pma0_dat_ref0_n_a_0, //Value driven to xioa_ck_ref0_n when i_scanio_en_nt is 1 and i_scanio_ref0_outen_nt is 1
input i_scanio_pma0_dat_ref0_p_a_0, //Value driven to xioa_ck_ref0_p when i_scanio_en_nt is 1 and i_scanio_ref0_outen_nt is 1
input i_scanio_pma0_dat_ref1_n_a_0, //Value driven to xioa_ck_ref1_n when i_scanio_en_nt is 1 and i_scanio_ref1_outen_nt is 1
input i_scanio_pma0_dat_ref1_p_a_0, //Value driven to xioa_ck_ref1_p when i_scanio_en_nt is 1 and i_scanio_ref1_outen_nt is 1
input i_scanio_pma0_dat_tx_p_l0_a_0, //When in scanio mode xoa_tx_p_l0 follows this value
input i_scanio_pma0_dat_tx_n_l0_a_0, //When in scanio mode xoa_tx_n_l0 follows this value
output o_scanio_pma0_dat_ref0_n_a_0, //Follows xioa_ck_ref0_n when i_scanio_en_nt is 1 and i_scanio_ref0_outen_nt is 0
output o_scanio_pma0_dat_ref0_p_a_0, //Follows xioa_ck_ref1_p when i_scanio_en_nt is 1 and i_scanio_ref0_outen_nt is 0
output o_scanio_pma0_dat_ref1_n_a_0, //Follows xioa_ck_ref1_n when i_scanio_en_nt is 1 and i_scanio_ref1_outen_nt is 0
output o_scanio_pma0_dat_ref1_p_a_0, //Follows xioa_ck_ref1_p when i_scanio_en_nt is 1 and i_scanio_ref1_outen_nt is 0
output o_scanio_pma0_dat_rx_n_l0_a_0, //When in scanio mode follows the value of xia_rx_n_l0
output o_scanio_pma0_dat_rx_p_l0_a_0, //When in scanio mode follows the value of xia_rx_p_l0
input i_scanio_pma1_ref0_outen_nt_0, //When in scanio mode direction control for xioa_ck_ref0_*. 1'b0: xioa_ck_ref0_* are both inputs. 1'b1: xioa_ck_ref0_* are both outputs
input i_scanio_pma1_ref1_outen_nt_0, //When in scanio mode direction control for xioa_ck_ref1_*. 1'b0: xioa_ck_ref1_* are both inputs. 1'b1: xioa_ck_ref1_* are both outputs
input i_scanio_pma1_dat_ref0_n_a_0, //Value driven to xioa_ck_ref0_n when i_scanio_en_nt is 1 and i_scanio_ref0_outen_nt is 1
input i_scanio_pma1_dat_ref0_p_a_0, //Value driven to xioa_ck_ref0_p when i_scanio_en_nt is 1 and i_scanio_ref0_outen_nt is 1
input i_scanio_pma1_dat_ref1_n_a_0, //Value driven to xioa_ck_ref1_n when i_scanio_en_nt is 1 and i_scanio_ref1_outen_nt is 1
input i_scanio_pma1_dat_ref1_p_a_0, //Value driven to xioa_ck_ref1_p when i_scanio_en_nt is 1 and i_scanio_ref1_outen_nt is 1
input i_scanio_pma1_dat_tx_p_l0_a_0, //When in scanio mode xoa_tx_p_l0 follows this value
input i_scanio_pma1_dat_tx_n_l0_a_0, //When in scanio mode xoa_tx_n_l0 follows this value
output o_scanio_pma1_dat_ref0_n_a_0, //Follows xioa_ck_ref0_n when i_scanio_en_nt is 1 and i_scanio_ref0_outen_nt is 0
output o_scanio_pma1_dat_ref0_p_a_0, //Follows xioa_ck_ref1_p when i_scanio_en_nt is 1 and i_scanio_ref0_outen_nt is 0
output o_scanio_pma1_dat_ref1_n_a_0, //Follows xioa_ck_ref1_n when i_scanio_en_nt is 1 and i_scanio_ref1_outen_nt is 0
output o_scanio_pma1_dat_ref1_p_a_0, //Follows xioa_ck_ref1_p when i_scanio_en_nt is 1 and i_scanio_ref1_outen_nt is 0
output o_scanio_pma1_dat_rx_n_l0_a_0, //When in scanio mode follows the value of xia_rx_n_l0
output o_scanio_pma1_dat_rx_p_l0_a_0, //When in scanio mode follows the value of xia_rx_p_l0
input i_scanio_pma2_ref0_outen_nt_0, //When in scanio mode direction control for xioa_ck_ref0_*. 1'b0: xioa_ck_ref0_* are both inputs. 1'b1: xioa_ck_ref0_* are both outputs
input i_scanio_pma2_ref1_outen_nt_0, //When in scanio mode direction control for xioa_ck_ref1_*. 1'b0: xioa_ck_ref1_* are both inputs. 1'b1: xioa_ck_ref1_* are both outputs
input i_scanio_pma2_dat_ref0_n_a_0, //Value driven to xioa_ck_ref0_n when i_scanio_en_nt is 1 and i_scanio_ref0_outen_nt is 1
input i_scanio_pma2_dat_ref0_p_a_0, //Value driven to xioa_ck_ref0_p when i_scanio_en_nt is 1 and i_scanio_ref0_outen_nt is 1
input i_scanio_pma2_dat_ref1_n_a_0, //Value driven to xioa_ck_ref1_n when i_scanio_en_nt is 1 and i_scanio_ref1_outen_nt is 1
input i_scanio_pma2_dat_ref1_p_a_0, //Value driven to xioa_ck_ref1_p when i_scanio_en_nt is 1 and i_scanio_ref1_outen_nt is 1
input i_scanio_pma2_dat_tx_p_l0_a_0, //When in scanio mode xoa_tx_p_l0 follows this value
input i_scanio_pma2_dat_tx_n_l0_a_0, //When in scanio mode xoa_tx_n_l0 follows this value
output o_scanio_pma2_dat_ref0_n_a_0, //Follows xioa_ck_ref0_n when i_scanio_en_nt is 1 and i_scanio_ref0_outen_nt is 0
output o_scanio_pma2_dat_ref0_p_a_0, //Follows xioa_ck_ref1_p when i_scanio_en_nt is 1 and i_scanio_ref0_outen_nt is 0
output o_scanio_pma2_dat_ref1_n_a_0, //Follows xioa_ck_ref1_n when i_scanio_en_nt is 1 and i_scanio_ref1_outen_nt is 0
output o_scanio_pma2_dat_ref1_p_a_0, //Follows xioa_ck_ref1_p when i_scanio_en_nt is 1 and i_scanio_ref1_outen_nt is 0
output o_scanio_pma2_dat_rx_n_l0_a_0, //When in scanio mode follows the value of xia_rx_n_l0
output o_scanio_pma2_dat_rx_p_l0_a_0, //When in scanio mode follows the value of xia_rx_p_l0
input i_scanio_pma3_ref0_outen_nt_0, //When in scanio mode direction control for xioa_ck_ref0_*. 1'b0: xioa_ck_ref0_* are both inputs. 1'b1: xioa_ck_ref0_* are both outputs
input i_scanio_pma3_ref1_outen_nt_0, //When in scanio mode direction control for xioa_ck_ref1_*. 1'b0: xioa_ck_ref1_* are both inputs. 1'b1: xioa_ck_ref1_* are both outputs
input i_scanio_pma3_dat_ref0_n_a_0, //Value driven to xioa_ck_ref0_n when i_scanio_en_nt is 1 and i_scanio_ref0_outen_nt is 1
input i_scanio_pma3_dat_ref0_p_a_0, //Value driven to xioa_ck_ref0_p when i_scanio_en_nt is 1 and i_scanio_ref0_outen_nt is 1
input i_scanio_pma3_dat_ref1_n_a_0, //Value driven to xioa_ck_ref1_n when i_scanio_en_nt is 1 and i_scanio_ref1_outen_nt is 1
input i_scanio_pma3_dat_ref1_p_a_0, //Value driven to xioa_ck_ref1_p when i_scanio_en_nt is 1 and i_scanio_ref1_outen_nt is 1
input i_scanio_pma3_dat_tx_p_l0_a_0, //When in scanio mode xoa_tx_p_l0 follows this value
input i_scanio_pma3_dat_tx_n_l0_a_0, //When in scanio mode xoa_tx_n_l0 follows this value
output o_scanio_pma3_dat_ref0_n_a_0, //Follows xioa_ck_ref0_n when i_scanio_en_nt is 1 and i_scanio_ref0_outen_nt is 0
output o_scanio_pma3_dat_ref0_p_a_0, //Follows xioa_ck_ref1_p when i_scanio_en_nt is 1 and i_scanio_ref0_outen_nt is 0
output o_scanio_pma3_dat_ref1_n_a_0, //Follows xioa_ck_ref1_n when i_scanio_en_nt is 1 and i_scanio_ref1_outen_nt is 0
output o_scanio_pma3_dat_ref1_p_a_0, //Follows xioa_ck_ref1_p when i_scanio_en_nt is 1 and i_scanio_ref1_outen_nt is 0
output o_scanio_pma3_dat_rx_n_l0_a_0, //When in scanio mode follows the value of xia_rx_n_l0
output o_scanio_pma3_dat_rx_p_l0_a_0, //When in scanio mode follows the value of xia_rx_p_l0
input i_scanio_en_nt_1, //Scanio mode enable. 1'b0: Scanio mode disabled. 1'b1: Scanio mode enabled
input i_scanio_pma0_ref0_outen_nt_1, //When in scanio mode direction control for xioa_ck_ref0_*. 1'b0: xioa_ck_ref0_* are both inputs. 1'b1: xioa_ck_ref0_* are both outputs
input i_scanio_pma0_ref1_outen_nt_1, //When in scanio mode direction control for xioa_ck_ref1_*. 1'b0: xioa_ck_ref1_* are both inputs. 1'b1: xioa_ck_ref1_* are both outputs
input i_scanio_pma0_dat_ref0_n_a_1, //Value driven to xioa_ck_ref0_n when i_scanio_en_nt is 1 and i_scanio_ref0_outen_nt is 1
input i_scanio_pma0_dat_ref0_p_a_1, //Value driven to xioa_ck_ref0_p when i_scanio_en_nt is 1 and i_scanio_ref0_outen_nt is 1
input i_scanio_pma0_dat_ref1_n_a_1, //Value driven to xioa_ck_ref1_n when i_scanio_en_nt is 1 and i_scanio_ref1_outen_nt is 1
input i_scanio_pma0_dat_ref1_p_a_1, //Value driven to xioa_ck_ref1_p when i_scanio_en_nt is 1 and i_scanio_ref1_outen_nt is 1
input i_scanio_pma0_dat_tx_p_l0_a_1, //When in scanio mode xoa_tx_p_l0 follows this value
input i_scanio_pma0_dat_tx_n_l0_a_1, //When in scanio mode xoa_tx_n_l0 follows this value
output o_scanio_pma0_dat_ref0_n_a_1, //Follows xioa_ck_ref0_n when i_scanio_en_nt is 1 and i_scanio_ref0_outen_nt is 0
output o_scanio_pma0_dat_ref0_p_a_1, //Follows xioa_ck_ref1_p when i_scanio_en_nt is 1 and i_scanio_ref0_outen_nt is 0
output o_scanio_pma0_dat_ref1_n_a_1, //Follows xioa_ck_ref1_n when i_scanio_en_nt is 1 and i_scanio_ref1_outen_nt is 0
output o_scanio_pma0_dat_ref1_p_a_1, //Follows xioa_ck_ref1_p when i_scanio_en_nt is 1 and i_scanio_ref1_outen_nt is 0
output o_scanio_pma0_dat_rx_n_l0_a_1, //When in scanio mode follows the value of xia_rx_n_l0
output o_scanio_pma0_dat_rx_p_l0_a_1, //When in scanio mode follows the value of xia_rx_p_l0
input i_scanio_pma1_ref0_outen_nt_1, //When in scanio mode direction control for xioa_ck_ref0_*. 1'b0: xioa_ck_ref0_* are both inputs. 1'b1: xioa_ck_ref0_* are both outputs
input i_scanio_pma1_ref1_outen_nt_1, //When in scanio mode direction control for xioa_ck_ref1_*. 1'b0: xioa_ck_ref1_* are both inputs. 1'b1: xioa_ck_ref1_* are both outputs
input i_scanio_pma1_dat_ref0_n_a_1, //Value driven to xioa_ck_ref0_n when i_scanio_en_nt is 1 and i_scanio_ref0_outen_nt is 1
input i_scanio_pma1_dat_ref0_p_a_1, //Value driven to xioa_ck_ref0_p when i_scanio_en_nt is 1 and i_scanio_ref0_outen_nt is 1
input i_scanio_pma1_dat_ref1_n_a_1, //Value driven to xioa_ck_ref1_n when i_scanio_en_nt is 1 and i_scanio_ref1_outen_nt is 1
input i_scanio_pma1_dat_ref1_p_a_1, //Value driven to xioa_ck_ref1_p when i_scanio_en_nt is 1 and i_scanio_ref1_outen_nt is 1
input i_scanio_pma1_dat_tx_p_l0_a_1, //When in scanio mode xoa_tx_p_l0 follows this value
input i_scanio_pma1_dat_tx_n_l0_a_1, //When in scanio mode xoa_tx_n_l0 follows this value
output o_scanio_pma1_dat_ref0_n_a_1, //Follows xioa_ck_ref0_n when i_scanio_en_nt is 1 and i_scanio_ref0_outen_nt is 0
output o_scanio_pma1_dat_ref0_p_a_1, //Follows xioa_ck_ref1_p when i_scanio_en_nt is 1 and i_scanio_ref0_outen_nt is 0
output o_scanio_pma1_dat_ref1_n_a_1, //Follows xioa_ck_ref1_n when i_scanio_en_nt is 1 and i_scanio_ref1_outen_nt is 0
output o_scanio_pma1_dat_ref1_p_a_1, //Follows xioa_ck_ref1_p when i_scanio_en_nt is 1 and i_scanio_ref1_outen_nt is 0
output o_scanio_pma1_dat_rx_n_l0_a_1, //When in scanio mode follows the value of xia_rx_n_l0
output o_scanio_pma1_dat_rx_p_l0_a_1, //When in scanio mode follows the value of xia_rx_p_l0
input i_scanio_pma2_ref0_outen_nt_1, //When in scanio mode direction control for xioa_ck_ref0_*. 1'b0: xioa_ck_ref0_* are both inputs. 1'b1: xioa_ck_ref0_* are both outputs
input i_scanio_pma2_ref1_outen_nt_1, //When in scanio mode direction control for xioa_ck_ref1_*. 1'b0: xioa_ck_ref1_* are both inputs. 1'b1: xioa_ck_ref1_* are both outputs
input i_scanio_pma2_dat_ref0_n_a_1, //Value driven to xioa_ck_ref0_n when i_scanio_en_nt is 1 and i_scanio_ref0_outen_nt is 1
input i_scanio_pma2_dat_ref0_p_a_1, //Value driven to xioa_ck_ref0_p when i_scanio_en_nt is 1 and i_scanio_ref0_outen_nt is 1
input i_scanio_pma2_dat_ref1_n_a_1, //Value driven to xioa_ck_ref1_n when i_scanio_en_nt is 1 and i_scanio_ref1_outen_nt is 1
input i_scanio_pma2_dat_ref1_p_a_1, //Value driven to xioa_ck_ref1_p when i_scanio_en_nt is 1 and i_scanio_ref1_outen_nt is 1
input i_scanio_pma2_dat_tx_p_l0_a_1, //When in scanio mode xoa_tx_p_l0 follows this value
input i_scanio_pma2_dat_tx_n_l0_a_1, //When in scanio mode xoa_tx_n_l0 follows this value
output o_scanio_pma2_dat_ref0_n_a_1, //Follows xioa_ck_ref0_n when i_scanio_en_nt is 1 and i_scanio_ref0_outen_nt is 0
output o_scanio_pma2_dat_ref0_p_a_1, //Follows xioa_ck_ref1_p when i_scanio_en_nt is 1 and i_scanio_ref0_outen_nt is 0
output o_scanio_pma2_dat_ref1_n_a_1, //Follows xioa_ck_ref1_n when i_scanio_en_nt is 1 and i_scanio_ref1_outen_nt is 0
output o_scanio_pma2_dat_ref1_p_a_1, //Follows xioa_ck_ref1_p when i_scanio_en_nt is 1 and i_scanio_ref1_outen_nt is 0
output o_scanio_pma2_dat_rx_n_l0_a_1, //When in scanio mode follows the value of xia_rx_n_l0
output o_scanio_pma2_dat_rx_p_l0_a_1, //When in scanio mode follows the value of xia_rx_p_l0
input i_scanio_pma3_ref0_outen_nt_1, //When in scanio mode direction control for xioa_ck_ref0_*. 1'b0: xioa_ck_ref0_* are both inputs. 1'b1: xioa_ck_ref0_* are both outputs
input i_scanio_pma3_ref1_outen_nt_1, //When in scanio mode direction control for xioa_ck_ref1_*. 1'b0: xioa_ck_ref1_* are both inputs. 1'b1: xioa_ck_ref1_* are both outputs
input i_scanio_pma3_dat_ref0_n_a_1, //Value driven to xioa_ck_ref0_n when i_scanio_en_nt is 1 and i_scanio_ref0_outen_nt is 1
input i_scanio_pma3_dat_ref0_p_a_1, //Value driven to xioa_ck_ref0_p when i_scanio_en_nt is 1 and i_scanio_ref0_outen_nt is 1
input i_scanio_pma3_dat_ref1_n_a_1, //Value driven to xioa_ck_ref1_n when i_scanio_en_nt is 1 and i_scanio_ref1_outen_nt is 1
input i_scanio_pma3_dat_ref1_p_a_1, //Value driven to xioa_ck_ref1_p when i_scanio_en_nt is 1 and i_scanio_ref1_outen_nt is 1
input i_scanio_pma3_dat_tx_p_l0_a_1, //When in scanio mode xoa_tx_p_l0 follows this value
input i_scanio_pma3_dat_tx_n_l0_a_1, //When in scanio mode xoa_tx_n_l0 follows this value
output o_scanio_pma3_dat_ref0_n_a_1, //Follows xioa_ck_ref0_n when i_scanio_en_nt is 1 and i_scanio_ref0_outen_nt is 0
output o_scanio_pma3_dat_ref0_p_a_1, //Follows xioa_ck_ref1_p when i_scanio_en_nt is 1 and i_scanio_ref0_outen_nt is 0
output o_scanio_pma3_dat_ref1_n_a_1, //Follows xioa_ck_ref1_n when i_scanio_en_nt is 1 and i_scanio_ref1_outen_nt is 0
output o_scanio_pma3_dat_ref1_p_a_1, //Follows xioa_ck_ref1_p when i_scanio_en_nt is 1 and i_scanio_ref1_outen_nt is 0
output o_scanio_pma3_dat_rx_n_l0_a_1, //When in scanio mode follows the value of xia_rx_n_l0
output o_scanio_pma3_dat_rx_p_l0_a_1, //When in scanio mode follows the value of xia_rx_p_l0
input i_scanio_en_nt_2, //Scanio mode enable. 1'b0: Scanio mode disabled. 1'b1: Scanio mode enabled
input i_scanio_pma0_ref0_outen_nt_2, //When in scanio mode direction control for xioa_ck_ref0_*. 1'b0: xioa_ck_ref0_* are both inputs. 1'b1: xioa_ck_ref0_* are both outputs
input i_scanio_pma0_ref1_outen_nt_2, //When in scanio mode direction control for xioa_ck_ref1_*. 1'b0: xioa_ck_ref1_* are both inputs. 1'b1: xioa_ck_ref1_* are both outputs
input i_scanio_pma0_dat_ref0_n_a_2, //Value driven to xioa_ck_ref0_n when i_scanio_en_nt is 1 and i_scanio_ref0_outen_nt is 1
input i_scanio_pma0_dat_ref0_p_a_2, //Value driven to xioa_ck_ref0_p when i_scanio_en_nt is 1 and i_scanio_ref0_outen_nt is 1
input i_scanio_pma0_dat_ref1_n_a_2, //Value driven to xioa_ck_ref1_n when i_scanio_en_nt is 1 and i_scanio_ref1_outen_nt is 1
input i_scanio_pma0_dat_ref1_p_a_2, //Value driven to xioa_ck_ref1_p when i_scanio_en_nt is 1 and i_scanio_ref1_outen_nt is 1
input i_scanio_pma0_dat_tx_p_l0_a_2, //When in scanio mode xoa_tx_p_l0 follows this value
input i_scanio_pma0_dat_tx_n_l0_a_2, //When in scanio mode xoa_tx_n_l0 follows this value
output o_scanio_pma0_dat_ref0_n_a_2, //Follows xioa_ck_ref0_n when i_scanio_en_nt is 1 and i_scanio_ref0_outen_nt is 0
output o_scanio_pma0_dat_ref0_p_a_2, //Follows xioa_ck_ref1_p when i_scanio_en_nt is 1 and i_scanio_ref0_outen_nt is 0
output o_scanio_pma0_dat_ref1_n_a_2, //Follows xioa_ck_ref1_n when i_scanio_en_nt is 1 and i_scanio_ref1_outen_nt is 0
output o_scanio_pma0_dat_ref1_p_a_2, //Follows xioa_ck_ref1_p when i_scanio_en_nt is 1 and i_scanio_ref1_outen_nt is 0
output o_scanio_pma0_dat_rx_n_l0_a_2, //When in scanio mode follows the value of xia_rx_n_l0
output o_scanio_pma0_dat_rx_p_l0_a_2, //When in scanio mode follows the value of xia_rx_p_l0
input i_scanio_pma1_ref0_outen_nt_2, //When in scanio mode direction control for xioa_ck_ref0_*. 1'b0: xioa_ck_ref0_* are both inputs. 1'b1: xioa_ck_ref0_* are both outputs
input i_scanio_pma1_ref1_outen_nt_2, //When in scanio mode direction control for xioa_ck_ref1_*. 1'b0: xioa_ck_ref1_* are both inputs. 1'b1: xioa_ck_ref1_* are both outputs
input i_scanio_pma1_dat_ref0_n_a_2, //Value driven to xioa_ck_ref0_n when i_scanio_en_nt is 1 and i_scanio_ref0_outen_nt is 1
input i_scanio_pma1_dat_ref0_p_a_2, //Value driven to xioa_ck_ref0_p when i_scanio_en_nt is 1 and i_scanio_ref0_outen_nt is 1
input i_scanio_pma1_dat_ref1_n_a_2, //Value driven to xioa_ck_ref1_n when i_scanio_en_nt is 1 and i_scanio_ref1_outen_nt is 1
input i_scanio_pma1_dat_ref1_p_a_2, //Value driven to xioa_ck_ref1_p when i_scanio_en_nt is 1 and i_scanio_ref1_outen_nt is 1
input i_scanio_pma1_dat_tx_p_l0_a_2, //When in scanio mode xoa_tx_p_l0 follows this value
input i_scanio_pma1_dat_tx_n_l0_a_2, //When in scanio mode xoa_tx_n_l0 follows this value
output o_scanio_pma1_dat_ref0_n_a_2, //Follows xioa_ck_ref0_n when i_scanio_en_nt is 1 and i_scanio_ref0_outen_nt is 0
output o_scanio_pma1_dat_ref0_p_a_2, //Follows xioa_ck_ref1_p when i_scanio_en_nt is 1 and i_scanio_ref0_outen_nt is 0
output o_scanio_pma1_dat_ref1_n_a_2, //Follows xioa_ck_ref1_n when i_scanio_en_nt is 1 and i_scanio_ref1_outen_nt is 0
output o_scanio_pma1_dat_ref1_p_a_2, //Follows xioa_ck_ref1_p when i_scanio_en_nt is 1 and i_scanio_ref1_outen_nt is 0
output o_scanio_pma1_dat_rx_n_l0_a_2, //When in scanio mode follows the value of xia_rx_n_l0
output o_scanio_pma1_dat_rx_p_l0_a_2, //When in scanio mode follows the value of xia_rx_p_l0
input i_scanio_pma2_ref0_outen_nt_2, //When in scanio mode direction control for xioa_ck_ref0_*. 1'b0: xioa_ck_ref0_* are both inputs. 1'b1: xioa_ck_ref0_* are both outputs
input i_scanio_pma2_ref1_outen_nt_2, //When in scanio mode direction control for xioa_ck_ref1_*. 1'b0: xioa_ck_ref1_* are both inputs. 1'b1: xioa_ck_ref1_* are both outputs
input i_scanio_pma2_dat_ref0_n_a_2, //Value driven to xioa_ck_ref0_n when i_scanio_en_nt is 1 and i_scanio_ref0_outen_nt is 1
input i_scanio_pma2_dat_ref0_p_a_2, //Value driven to xioa_ck_ref0_p when i_scanio_en_nt is 1 and i_scanio_ref0_outen_nt is 1
input i_scanio_pma2_dat_ref1_n_a_2, //Value driven to xioa_ck_ref1_n when i_scanio_en_nt is 1 and i_scanio_ref1_outen_nt is 1
input i_scanio_pma2_dat_ref1_p_a_2, //Value driven to xioa_ck_ref1_p when i_scanio_en_nt is 1 and i_scanio_ref1_outen_nt is 1
input i_scanio_pma2_dat_tx_p_l0_a_2, //When in scanio mode xoa_tx_p_l0 follows this value
input i_scanio_pma2_dat_tx_n_l0_a_2, //When in scanio mode xoa_tx_n_l0 follows this value
output o_scanio_pma2_dat_ref0_n_a_2, //Follows xioa_ck_ref0_n when i_scanio_en_nt is 1 and i_scanio_ref0_outen_nt is 0
output o_scanio_pma2_dat_ref0_p_a_2, //Follows xioa_ck_ref1_p when i_scanio_en_nt is 1 and i_scanio_ref0_outen_nt is 0
output o_scanio_pma2_dat_ref1_n_a_2, //Follows xioa_ck_ref1_n when i_scanio_en_nt is 1 and i_scanio_ref1_outen_nt is 0
output o_scanio_pma2_dat_ref1_p_a_2, //Follows xioa_ck_ref1_p when i_scanio_en_nt is 1 and i_scanio_ref1_outen_nt is 0
output o_scanio_pma2_dat_rx_n_l0_a_2, //When in scanio mode follows the value of xia_rx_n_l0
output o_scanio_pma2_dat_rx_p_l0_a_2, //When in scanio mode follows the value of xia_rx_p_l0
input i_scanio_pma3_ref0_outen_nt_2, //When in scanio mode direction control for xioa_ck_ref0_*. 1'b0: xioa_ck_ref0_* are both inputs. 1'b1: xioa_ck_ref0_* are both outputs
input i_scanio_pma3_ref1_outen_nt_2, //When in scanio mode direction control for xioa_ck_ref1_*. 1'b0: xioa_ck_ref1_* are both inputs. 1'b1: xioa_ck_ref1_* are both outputs
input i_scanio_pma3_dat_ref0_n_a_2, //Value driven to xioa_ck_ref0_n when i_scanio_en_nt is 1 and i_scanio_ref0_outen_nt is 1
input i_scanio_pma3_dat_ref0_p_a_2, //Value driven to xioa_ck_ref0_p when i_scanio_en_nt is 1 and i_scanio_ref0_outen_nt is 1
input i_scanio_pma3_dat_ref1_n_a_2, //Value driven to xioa_ck_ref1_n when i_scanio_en_nt is 1 and i_scanio_ref1_outen_nt is 1
input i_scanio_pma3_dat_ref1_p_a_2, //Value driven to xioa_ck_ref1_p when i_scanio_en_nt is 1 and i_scanio_ref1_outen_nt is 1
input i_scanio_pma3_dat_tx_p_l0_a_2, //When in scanio mode xoa_tx_p_l0 follows this value
input i_scanio_pma3_dat_tx_n_l0_a_2, //When in scanio mode xoa_tx_n_l0 follows this value
output o_scanio_pma3_dat_ref0_n_a_2, //Follows xioa_ck_ref0_n when i_scanio_en_nt is 1 and i_scanio_ref0_outen_nt is 0
output o_scanio_pma3_dat_ref0_p_a_2, //Follows xioa_ck_ref1_p when i_scanio_en_nt is 1 and i_scanio_ref0_outen_nt is 0
output o_scanio_pma3_dat_ref1_n_a_2, //Follows xioa_ck_ref1_n when i_scanio_en_nt is 1 and i_scanio_ref1_outen_nt is 0
output o_scanio_pma3_dat_ref1_p_a_2, //Follows xioa_ck_ref1_p when i_scanio_en_nt is 1 and i_scanio_ref1_outen_nt is 0
output o_scanio_pma3_dat_rx_n_l0_a_2, //When in scanio mode follows the value of xia_rx_n_l0
output o_scanio_pma3_dat_rx_p_l0_a_2, //When in scanio mode follows the value of xia_rx_p_l0
input i_scanio_en_nt_3, //Scanio mode enable. 1'b0: Scanio mode disabled. 1'b1: Scanio mode enabled
input i_scanio_pma0_ref0_outen_nt_3, //When in scanio mode direction control for xioa_ck_ref0_*. 1'b0: xioa_ck_ref0_* are both inputs. 1'b1: xioa_ck_ref0_* are both outputs
input i_scanio_pma0_ref1_outen_nt_3, //When in scanio mode direction control for xioa_ck_ref1_*. 1'b0: xioa_ck_ref1_* are both inputs. 1'b1: xioa_ck_ref1_* are both outputs
input i_scanio_pma0_dat_ref0_n_a_3, //Value driven to xioa_ck_ref0_n when i_scanio_en_nt is 1 and i_scanio_ref0_outen_nt is 1
input i_scanio_pma0_dat_ref0_p_a_3, //Value driven to xioa_ck_ref0_p when i_scanio_en_nt is 1 and i_scanio_ref0_outen_nt is 1
input i_scanio_pma0_dat_ref1_n_a_3, //Value driven to xioa_ck_ref1_n when i_scanio_en_nt is 1 and i_scanio_ref1_outen_nt is 1
input i_scanio_pma0_dat_ref1_p_a_3, //Value driven to xioa_ck_ref1_p when i_scanio_en_nt is 1 and i_scanio_ref1_outen_nt is 1
input i_scanio_pma0_dat_tx_p_l0_a_3, //When in scanio mode xoa_tx_p_l0 follows this value
input i_scanio_pma0_dat_tx_n_l0_a_3, //When in scanio mode xoa_tx_n_l0 follows this value
output o_scanio_pma0_dat_ref0_n_a_3, //Follows xioa_ck_ref0_n when i_scanio_en_nt is 1 and i_scanio_ref0_outen_nt is 0
output o_scanio_pma0_dat_ref0_p_a_3, //Follows xioa_ck_ref1_p when i_scanio_en_nt is 1 and i_scanio_ref0_outen_nt is 0
output o_scanio_pma0_dat_ref1_n_a_3, //Follows xioa_ck_ref1_n when i_scanio_en_nt is 1 and i_scanio_ref1_outen_nt is 0
output o_scanio_pma0_dat_ref1_p_a_3, //Follows xioa_ck_ref1_p when i_scanio_en_nt is 1 and i_scanio_ref1_outen_nt is 0
output o_scanio_pma0_dat_rx_n_l0_a_3, //When in scanio mode follows the value of xia_rx_n_l0
output o_scanio_pma0_dat_rx_p_l0_a_3, //When in scanio mode follows the value of xia_rx_p_l0
input i_scanio_pma1_ref0_outen_nt_3, //When in scanio mode direction control for xioa_ck_ref0_*. 1'b0: xioa_ck_ref0_* are both inputs. 1'b1: xioa_ck_ref0_* are both outputs
input i_scanio_pma1_ref1_outen_nt_3, //When in scanio mode direction control for xioa_ck_ref1_*. 1'b0: xioa_ck_ref1_* are both inputs. 1'b1: xioa_ck_ref1_* are both outputs
input i_scanio_pma1_dat_ref0_n_a_3, //Value driven to xioa_ck_ref0_n when i_scanio_en_nt is 1 and i_scanio_ref0_outen_nt is 1
input i_scanio_pma1_dat_ref0_p_a_3, //Value driven to xioa_ck_ref0_p when i_scanio_en_nt is 1 and i_scanio_ref0_outen_nt is 1
input i_scanio_pma1_dat_ref1_n_a_3, //Value driven to xioa_ck_ref1_n when i_scanio_en_nt is 1 and i_scanio_ref1_outen_nt is 1
input i_scanio_pma1_dat_ref1_p_a_3, //Value driven to xioa_ck_ref1_p when i_scanio_en_nt is 1 and i_scanio_ref1_outen_nt is 1
input i_scanio_pma1_dat_tx_p_l0_a_3, //When in scanio mode xoa_tx_p_l0 follows this value
input i_scanio_pma1_dat_tx_n_l0_a_3, //When in scanio mode xoa_tx_n_l0 follows this value
output o_scanio_pma1_dat_ref0_n_a_3, //Follows xioa_ck_ref0_n when i_scanio_en_nt is 1 and i_scanio_ref0_outen_nt is 0
output o_scanio_pma1_dat_ref0_p_a_3, //Follows xioa_ck_ref1_p when i_scanio_en_nt is 1 and i_scanio_ref0_outen_nt is 0
output o_scanio_pma1_dat_ref1_n_a_3, //Follows xioa_ck_ref1_n when i_scanio_en_nt is 1 and i_scanio_ref1_outen_nt is 0
output o_scanio_pma1_dat_ref1_p_a_3, //Follows xioa_ck_ref1_p when i_scanio_en_nt is 1 and i_scanio_ref1_outen_nt is 0
output o_scanio_pma1_dat_rx_n_l0_a_3, //When in scanio mode follows the value of xia_rx_n_l0
output o_scanio_pma1_dat_rx_p_l0_a_3, //When in scanio mode follows the value of xia_rx_p_l0
input i_scanio_pma2_ref0_outen_nt_3, //When in scanio mode direction control for xioa_ck_ref0_*. 1'b0: xioa_ck_ref0_* are both inputs. 1'b1: xioa_ck_ref0_* are both outputs
input i_scanio_pma2_ref1_outen_nt_3, //When in scanio mode direction control for xioa_ck_ref1_*. 1'b0: xioa_ck_ref1_* are both inputs. 1'b1: xioa_ck_ref1_* are both outputs
input i_scanio_pma2_dat_ref0_n_a_3, //Value driven to xioa_ck_ref0_n when i_scanio_en_nt is 1 and i_scanio_ref0_outen_nt is 1
input i_scanio_pma2_dat_ref0_p_a_3, //Value driven to xioa_ck_ref0_p when i_scanio_en_nt is 1 and i_scanio_ref0_outen_nt is 1
input i_scanio_pma2_dat_ref1_n_a_3, //Value driven to xioa_ck_ref1_n when i_scanio_en_nt is 1 and i_scanio_ref1_outen_nt is 1
input i_scanio_pma2_dat_ref1_p_a_3, //Value driven to xioa_ck_ref1_p when i_scanio_en_nt is 1 and i_scanio_ref1_outen_nt is 1
input i_scanio_pma2_dat_tx_p_l0_a_3, //When in scanio mode xoa_tx_p_l0 follows this value
input i_scanio_pma2_dat_tx_n_l0_a_3, //When in scanio mode xoa_tx_n_l0 follows this value
output o_scanio_pma2_dat_ref0_n_a_3, //Follows xioa_ck_ref0_n when i_scanio_en_nt is 1 and i_scanio_ref0_outen_nt is 0
output o_scanio_pma2_dat_ref0_p_a_3, //Follows xioa_ck_ref1_p when i_scanio_en_nt is 1 and i_scanio_ref0_outen_nt is 0
output o_scanio_pma2_dat_ref1_n_a_3, //Follows xioa_ck_ref1_n when i_scanio_en_nt is 1 and i_scanio_ref1_outen_nt is 0
output o_scanio_pma2_dat_ref1_p_a_3, //Follows xioa_ck_ref1_p when i_scanio_en_nt is 1 and i_scanio_ref1_outen_nt is 0
output o_scanio_pma2_dat_rx_n_l0_a_3, //When in scanio mode follows the value of xia_rx_n_l0
output o_scanio_pma2_dat_rx_p_l0_a_3, //When in scanio mode follows the value of xia_rx_p_l0
input i_scanio_pma3_ref0_outen_nt_3, //When in scanio mode direction control for xioa_ck_ref0_*. 1'b0: xioa_ck_ref0_* are both inputs. 1'b1: xioa_ck_ref0_* are both outputs
input i_scanio_pma3_ref1_outen_nt_3, //When in scanio mode direction control for xioa_ck_ref1_*. 1'b0: xioa_ck_ref1_* are both inputs. 1'b1: xioa_ck_ref1_* are both outputs
input i_scanio_pma3_dat_ref0_n_a_3, //Value driven to xioa_ck_ref0_n when i_scanio_en_nt is 1 and i_scanio_ref0_outen_nt is 1
input i_scanio_pma3_dat_ref0_p_a_3, //Value driven to xioa_ck_ref0_p when i_scanio_en_nt is 1 and i_scanio_ref0_outen_nt is 1
input i_scanio_pma3_dat_ref1_n_a_3, //Value driven to xioa_ck_ref1_n when i_scanio_en_nt is 1 and i_scanio_ref1_outen_nt is 1
input i_scanio_pma3_dat_ref1_p_a_3, //Value driven to xioa_ck_ref1_p when i_scanio_en_nt is 1 and i_scanio_ref1_outen_nt is 1
input i_scanio_pma3_dat_tx_p_l0_a_3, //When in scanio mode xoa_tx_p_l0 follows this value
input i_scanio_pma3_dat_tx_n_l0_a_3, //When in scanio mode xoa_tx_n_l0 follows this value
output o_scanio_pma3_dat_ref0_n_a_3, //Follows xioa_ck_ref0_n when i_scanio_en_nt is 1 and i_scanio_ref0_outen_nt is 0
output o_scanio_pma3_dat_ref0_p_a_3, //Follows xioa_ck_ref1_p when i_scanio_en_nt is 1 and i_scanio_ref0_outen_nt is 0
output o_scanio_pma3_dat_ref1_n_a_3, //Follows xioa_ck_ref1_n when i_scanio_en_nt is 1 and i_scanio_ref1_outen_nt is 0
output o_scanio_pma3_dat_ref1_p_a_3, //Follows xioa_ck_ref1_p when i_scanio_en_nt is 1 and i_scanio_ref1_outen_nt is 0
output o_scanio_pma3_dat_rx_n_l0_a_3, //When in scanio mode follows the value of xia_rx_n_l0
output o_scanio_pma3_dat_rx_p_l0_a_3, //When in scanio mode follows the value of xia_rx_p_l0
input i_ck_dfx_upm_pma0_tck_0, //See UPM documentation
input i_rst_dfx_upm_pma0_trst_b_0, //See UPM documentation
input i_dfx_upm_pma0_fdfx_powergood_0, //See UPM documentation
input i_dfx_upm_pma0_secure_0, //See UPM documentation
input i_dfx_upm_pma0_sel_0, //See UPM documentation
input i_dfx_upm_pma0_capture_0, //See UPM documentation
input i_dfx_upm_pma0_shift_0, //See UPM documentation
input i_dfx_upm_pma0_update_0, //See UPM documentation
input i_dfx_upm_pma0_si_0, //See UPM documentation
output o_dfx_upm_pma0_so_0, //See UPM documentation
input i_ck_dfx_upm_pma0_clk_debug_0, //See UPM documentation
input i_dfx_upm_pma0_iso_b_0, //See UPM documentation
input i_ck_dfx_upm_pma1_tck_0, //See UPM documentation
input i_rst_dfx_upm_pma1_trst_b_0, //See UPM documentation
input i_dfx_upm_pma1_fdfx_powergood_0, //See UPM documentation
input i_dfx_upm_pma1_secure_0, //See UPM documentation
input i_dfx_upm_pma1_sel_0, //See UPM documentation
input i_dfx_upm_pma1_capture_0, //See UPM documentation
input i_dfx_upm_pma1_shift_0, //See UPM documentation
input i_dfx_upm_pma1_update_0, //See UPM documentation
input i_dfx_upm_pma1_si_0, //See UPM documentation
output o_dfx_upm_pma1_so_0, //See UPM documentation
input i_ck_dfx_upm_pma1_clk_debug_0, //See UPM documentation
input i_dfx_upm_pma1_iso_b_0, //See UPM documentation
input i_ck_dfx_upm_pma2_tck_0, //See UPM documentation
input i_rst_dfx_upm_pma2_trst_b_0, //See UPM documentation
input i_dfx_upm_pma2_fdfx_powergood_0, //See UPM documentation
input i_dfx_upm_pma2_secure_0, //See UPM documentation
input i_dfx_upm_pma2_sel_0, //See UPM documentation
input i_dfx_upm_pma2_capture_0, //See UPM documentation
input i_dfx_upm_pma2_shift_0, //See UPM documentation
input i_dfx_upm_pma2_update_0, //See UPM documentation
input i_dfx_upm_pma2_si_0, //See UPM documentation
output o_dfx_upm_pma2_so_0, //See UPM documentation
input i_ck_dfx_upm_pma2_clk_debug_0, //See UPM documentation
input i_dfx_upm_pma2_iso_b_0, //See UPM documentation
input i_ck_dfx_upm_pma3_tck_0, //See UPM documentation
input i_rst_dfx_upm_pma3_trst_b_0, //See UPM documentation
input i_dfx_upm_pma3_fdfx_powergood_0, //See UPM documentation
input i_dfx_upm_pma3_secure_0, //See UPM documentation
input i_dfx_upm_pma3_sel_0, //See UPM documentation
input i_dfx_upm_pma3_capture_0, //See UPM documentation
input i_dfx_upm_pma3_shift_0, //See UPM documentation
input i_dfx_upm_pma3_update_0, //See UPM documentation
input i_dfx_upm_pma3_si_0, //See UPM documentation
output o_dfx_upm_pma3_so_0, //See UPM documentation
input i_ck_dfx_upm_pma3_clk_debug_0, //See UPM documentation
input i_dfx_upm_pma3_iso_b_0, //See UPM documentation
input i_ck_dfx_upm_pma0_tck_1, //See UPM documentation
input i_rst_dfx_upm_pma0_trst_b_1, //See UPM documentation
input i_dfx_upm_pma0_fdfx_powergood_1, //See UPM documentation
input i_dfx_upm_pma0_secure_1, //See UPM documentation
input i_dfx_upm_pma0_sel_1, //See UPM documentation
input i_dfx_upm_pma0_capture_1, //See UPM documentation
input i_dfx_upm_pma0_shift_1, //See UPM documentation
input i_dfx_upm_pma0_update_1, //See UPM documentation
input i_dfx_upm_pma0_si_1, //See UPM documentation
output o_dfx_upm_pma0_so_1, //See UPM documentation
input i_ck_dfx_upm_pma0_clk_debug_1, //See UPM documentation
input i_dfx_upm_pma0_iso_b_1, //See UPM documentation
input i_ck_dfx_upm_pma1_tck_1, //See UPM documentation
input i_rst_dfx_upm_pma1_trst_b_1, //See UPM documentation
input i_dfx_upm_pma1_fdfx_powergood_1, //See UPM documentation
input i_dfx_upm_pma1_secure_1, //See UPM documentation
input i_dfx_upm_pma1_sel_1, //See UPM documentation
input i_dfx_upm_pma1_capture_1, //See UPM documentation
input i_dfx_upm_pma1_shift_1, //See UPM documentation
input i_dfx_upm_pma1_update_1, //See UPM documentation
input i_dfx_upm_pma1_si_1, //See UPM documentation
output o_dfx_upm_pma1_so_1, //See UPM documentation
input i_ck_dfx_upm_pma1_clk_debug_1, //See UPM documentation
input i_dfx_upm_pma1_iso_b_1, //See UPM documentation
input i_ck_dfx_upm_pma2_tck_1, //See UPM documentation
input i_rst_dfx_upm_pma2_trst_b_1, //See UPM documentation
input i_dfx_upm_pma2_fdfx_powergood_1, //See UPM documentation
input i_dfx_upm_pma2_secure_1, //See UPM documentation
input i_dfx_upm_pma2_sel_1, //See UPM documentation
input i_dfx_upm_pma2_capture_1, //See UPM documentation
input i_dfx_upm_pma2_shift_1, //See UPM documentation
input i_dfx_upm_pma2_update_1, //See UPM documentation
input i_dfx_upm_pma2_si_1, //See UPM documentation
output o_dfx_upm_pma2_so_1, //See UPM documentation
input i_ck_dfx_upm_pma2_clk_debug_1, //See UPM documentation
input i_dfx_upm_pma2_iso_b_1, //See UPM documentation
input i_ck_dfx_upm_pma3_tck_1, //See UPM documentation
input i_rst_dfx_upm_pma3_trst_b_1, //See UPM documentation
input i_dfx_upm_pma3_fdfx_powergood_1, //See UPM documentation
input i_dfx_upm_pma3_secure_1, //See UPM documentation
input i_dfx_upm_pma3_sel_1, //See UPM documentation
input i_dfx_upm_pma3_capture_1, //See UPM documentation
input i_dfx_upm_pma3_shift_1, //See UPM documentation
input i_dfx_upm_pma3_update_1, //See UPM documentation
input i_dfx_upm_pma3_si_1, //See UPM documentation
output o_dfx_upm_pma3_so_1, //See UPM documentation
input i_ck_dfx_upm_pma3_clk_debug_1, //See UPM documentation
input i_dfx_upm_pma3_iso_b_1, //See UPM documentation
input i_ck_dfx_upm_pma0_tck_2, //See UPM documentation
input i_rst_dfx_upm_pma0_trst_b_2, //See UPM documentation
input i_dfx_upm_pma0_fdfx_powergood_2, //See UPM documentation
input i_dfx_upm_pma0_secure_2, //See UPM documentation
input i_dfx_upm_pma0_sel_2, //See UPM documentation
input i_dfx_upm_pma0_capture_2, //See UPM documentation
input i_dfx_upm_pma0_shift_2, //See UPM documentation
input i_dfx_upm_pma0_update_2, //See UPM documentation
input i_dfx_upm_pma0_si_2, //See UPM documentation
output o_dfx_upm_pma0_so_2, //See UPM documentation
input i_ck_dfx_upm_pma0_clk_debug_2, //See UPM documentation
input i_dfx_upm_pma0_iso_b_2, //See UPM documentation
input i_ck_dfx_upm_pma1_tck_2, //See UPM documentation
input i_rst_dfx_upm_pma1_trst_b_2, //See UPM documentation
input i_dfx_upm_pma1_fdfx_powergood_2, //See UPM documentation
input i_dfx_upm_pma1_secure_2, //See UPM documentation
input i_dfx_upm_pma1_sel_2, //See UPM documentation
input i_dfx_upm_pma1_capture_2, //See UPM documentation
input i_dfx_upm_pma1_shift_2, //See UPM documentation
input i_dfx_upm_pma1_update_2, //See UPM documentation
input i_dfx_upm_pma1_si_2, //See UPM documentation
output o_dfx_upm_pma1_so_2, //See UPM documentation
input i_ck_dfx_upm_pma1_clk_debug_2, //See UPM documentation
input i_dfx_upm_pma1_iso_b_2, //See UPM documentation
input i_ck_dfx_upm_pma2_tck_2, //See UPM documentation
input i_rst_dfx_upm_pma2_trst_b_2, //See UPM documentation
input i_dfx_upm_pma2_fdfx_powergood_2, //See UPM documentation
input i_dfx_upm_pma2_secure_2, //See UPM documentation
input i_dfx_upm_pma2_sel_2, //See UPM documentation
input i_dfx_upm_pma2_capture_2, //See UPM documentation
input i_dfx_upm_pma2_shift_2, //See UPM documentation
input i_dfx_upm_pma2_update_2, //See UPM documentation
input i_dfx_upm_pma2_si_2, //See UPM documentation
output o_dfx_upm_pma2_so_2, //See UPM documentation
input i_ck_dfx_upm_pma2_clk_debug_2, //See UPM documentation
input i_dfx_upm_pma2_iso_b_2, //See UPM documentation
input i_ck_dfx_upm_pma3_tck_2, //See UPM documentation
input i_rst_dfx_upm_pma3_trst_b_2, //See UPM documentation
input i_dfx_upm_pma3_fdfx_powergood_2, //See UPM documentation
input i_dfx_upm_pma3_secure_2, //See UPM documentation
input i_dfx_upm_pma3_sel_2, //See UPM documentation
input i_dfx_upm_pma3_capture_2, //See UPM documentation
input i_dfx_upm_pma3_shift_2, //See UPM documentation
input i_dfx_upm_pma3_update_2, //See UPM documentation
input i_dfx_upm_pma3_si_2, //See UPM documentation
output o_dfx_upm_pma3_so_2, //See UPM documentation
input i_ck_dfx_upm_pma3_clk_debug_2, //See UPM documentation
input i_dfx_upm_pma3_iso_b_2, //See UPM documentation
input i_ck_dfx_upm_pma0_tck_3, //See UPM documentation
input i_rst_dfx_upm_pma0_trst_b_3, //See UPM documentation
input i_dfx_upm_pma0_fdfx_powergood_3, //See UPM documentation
input i_dfx_upm_pma0_secure_3, //See UPM documentation
input i_dfx_upm_pma0_sel_3, //See UPM documentation
input i_dfx_upm_pma0_capture_3, //See UPM documentation
input i_dfx_upm_pma0_shift_3, //See UPM documentation
input i_dfx_upm_pma0_update_3, //See UPM documentation
input i_dfx_upm_pma0_si_3, //See UPM documentation
output o_dfx_upm_pma0_so_3, //See UPM documentation
input i_ck_dfx_upm_pma0_clk_debug_3, //See UPM documentation
input i_dfx_upm_pma0_iso_b_3, //See UPM documentation
input i_ck_dfx_upm_pma1_tck_3, //See UPM documentation
input i_rst_dfx_upm_pma1_trst_b_3, //See UPM documentation
input i_dfx_upm_pma1_fdfx_powergood_3, //See UPM documentation
input i_dfx_upm_pma1_secure_3, //See UPM documentation
input i_dfx_upm_pma1_sel_3, //See UPM documentation
input i_dfx_upm_pma1_capture_3, //See UPM documentation
input i_dfx_upm_pma1_shift_3, //See UPM documentation
input i_dfx_upm_pma1_update_3, //See UPM documentation
input i_dfx_upm_pma1_si_3, //See UPM documentation
output o_dfx_upm_pma1_so_3, //See UPM documentation
input i_ck_dfx_upm_pma1_clk_debug_3, //See UPM documentation
input i_dfx_upm_pma1_iso_b_3, //See UPM documentation
input i_ck_dfx_upm_pma2_tck_3, //See UPM documentation
input i_rst_dfx_upm_pma2_trst_b_3, //See UPM documentation
input i_dfx_upm_pma2_fdfx_powergood_3, //See UPM documentation
input i_dfx_upm_pma2_secure_3, //See UPM documentation
input i_dfx_upm_pma2_sel_3, //See UPM documentation
input i_dfx_upm_pma2_capture_3, //See UPM documentation
input i_dfx_upm_pma2_shift_3, //See UPM documentation
input i_dfx_upm_pma2_update_3, //See UPM documentation
input i_dfx_upm_pma2_si_3, //See UPM documentation
output o_dfx_upm_pma2_so_3, //See UPM documentation
input i_ck_dfx_upm_pma2_clk_debug_3, //See UPM documentation
input i_dfx_upm_pma2_iso_b_3, //See UPM documentation
input i_ck_dfx_upm_pma3_tck_3, //See UPM documentation
input i_rst_dfx_upm_pma3_trst_b_3, //See UPM documentation
input i_dfx_upm_pma3_fdfx_powergood_3, //See UPM documentation
input i_dfx_upm_pma3_secure_3, //See UPM documentation
input i_dfx_upm_pma3_sel_3, //See UPM documentation
input i_dfx_upm_pma3_capture_3, //See UPM documentation
input i_dfx_upm_pma3_shift_3, //See UPM documentation
input i_dfx_upm_pma3_update_3, //See UPM documentation
input i_dfx_upm_pma3_si_3, //See UPM documentation
output o_dfx_upm_pma3_so_3, //See UPM documentation
input i_ck_dfx_upm_pma3_clk_debug_3, //See UPM documentation
input i_dfx_upm_pma3_iso_b_3, //See UPM documentation
output [3:0] mac100_0_int,
output [3:0] pcs100_0_int,
output [3:0] mac100_1_int,
output [3:0] pcs100_1_int,
output [3:0] mac100_2_int,
output [3:0] pcs100_2_int,
output [3:0] mac100_3_int,
output [3:0] pcs100_3_int,
output [3:0] physs_ts_int,
input [5:0] eth_hd2prf_trim_fuse_in, //2R2W time stamp Memory rfhs type Trim Fuse RMCE WMCE latency Read and Write Memory Latency
input [7:0] eth_rfhs_trim_fuse_in, //2R2W time stamp Memory rfhs type Trim Fuse RMCE WMCE latency Read and Write Memory Latency
input [15:0] eth_hdspsr_trim_fuse_in //2R2W time stamp Memory rfhs type Trim Fuse RMCE WMCE latency Read and Write Memory Latency
 );
// EDIT_PORT END


// EDIT_NET BEGIN
logic soc_per_clk_adop_parmisc_physs0_clkout_0 ; 
logic physs_func_clk_adop_parmisc_physs0_clkout ; 
logic timeref_clk_adop_parmisc_physs0_clkout ; 
logic physs_clock_sync_2_physs_func_clk_gated_100 ; 
logic physs_clock_sync_3_physs_func_clk_gated_100 ; 
wire [3:0] physs1_ioa_ck_pma0_ref_left_pquad1_physs1 ; 
wire [3:0] physs1_ioa_ck_pma0_ref_left_pquad0_physs1 ; 
wire [3:0] physs0_ioa_ck_pma0_ref_left_mquad1_physs0 ; 
logic [6:0] quadpcs100_0_pcs_desk_buf_rlevel_1 ; 
logic [6:0] quadpcs100_0_pcs_desk_buf_rlevel_2 ; 
logic [6:0] quadpcs100_0_pcs_desk_buf_rlevel_3 ; 
logic [6:0] quadpcs100_0_pcs_desk_buf_rlevel_4 ; 
logic [6:0] quadpcs100_1_pcs_desk_buf_rlevel_1 ; 
logic [6:0] quadpcs100_1_pcs_desk_buf_rlevel_2 ; 
logic [6:0] quadpcs100_1_pcs_desk_buf_rlevel_3 ; 
logic [6:0] quadpcs100_1_pcs_desk_buf_rlevel_4 ; 
// EDIT_NET END

// EDIT_INSTANCE BEGIN
physs0 physs0 (
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
    .physs_func_rst_raw_n(physs_func_rst_raw_n), 
    .soc_per_clk_adop_parmisc_physs0_clkout_0(soc_per_clk_adop_parmisc_physs0_clkout_0), 
    .physs_func_clk_adop_parmisc_physs0_clkout(physs_func_clk_adop_parmisc_physs0_clkout), 
    .timeref_clk_adop_parmisc_physs0_clkout(timeref_clk_adop_parmisc_physs0_clkout), 
    .physs_intf0_clk(physs_intf0_clk), 
    .physs_funcx2_clk(physs_funcx2_clk), 
    .soc_per_clk(soc_per_clk), 
    .physs_func_clk(physs_func_clk), 
    .timeref_clk(timeref_clk), 
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
    .mse_physs_port_0_rx_rdy(mse_physs_port_0_rx_rdy), 
    .mse_physs_port_0_tx_wren(mse_physs_port_0_tx_wren), 
    .mse_physs_port_0_tx_data(mse_physs_port_0_tx_data), 
    .mse_physs_port_0_tx_sop(mse_physs_port_0_tx_sop), 
    .mse_physs_port_0_tx_eop(mse_physs_port_0_tx_eop), 
    .mse_physs_port_0_tx_mod(mse_physs_port_0_tx_mod), 
    .mse_physs_port_0_tx_err(mse_physs_port_0_tx_err), 
    .mse_physs_port_0_tx_crc(mse_physs_port_0_tx_crc), 
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
    .mse_physs_port_1_rx_rdy(mse_physs_port_1_rx_rdy), 
    .mse_physs_port_1_tx_wren(mse_physs_port_1_tx_wren), 
    .mse_physs_port_1_tx_data(mse_physs_port_1_tx_data), 
    .mse_physs_port_1_tx_sop(mse_physs_port_1_tx_sop), 
    .mse_physs_port_1_tx_eop(mse_physs_port_1_tx_eop), 
    .mse_physs_port_1_tx_mod(mse_physs_port_1_tx_mod), 
    .mse_physs_port_1_tx_err(mse_physs_port_1_tx_err), 
    .mse_physs_port_1_tx_crc(mse_physs_port_1_tx_crc), 
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
    .mse_physs_port_2_rx_rdy(mse_physs_port_2_rx_rdy), 
    .mse_physs_port_2_tx_wren(mse_physs_port_2_tx_wren), 
    .mse_physs_port_2_tx_data(mse_physs_port_2_tx_data), 
    .mse_physs_port_2_tx_sop(mse_physs_port_2_tx_sop), 
    .mse_physs_port_2_tx_eop(mse_physs_port_2_tx_eop), 
    .mse_physs_port_2_tx_mod(mse_physs_port_2_tx_mod), 
    .mse_physs_port_2_tx_err(mse_physs_port_2_tx_err), 
    .mse_physs_port_2_tx_crc(mse_physs_port_2_tx_crc), 
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
    .mse_physs_port_3_rx_rdy(mse_physs_port_3_rx_rdy), 
    .mse_physs_port_3_tx_wren(mse_physs_port_3_tx_wren), 
    .mse_physs_port_3_tx_data(mse_physs_port_3_tx_data), 
    .mse_physs_port_3_tx_sop(mse_physs_port_3_tx_sop), 
    .mse_physs_port_3_tx_eop(mse_physs_port_3_tx_eop), 
    .mse_physs_port_3_tx_mod(mse_physs_port_3_tx_mod), 
    .mse_physs_port_3_tx_err(mse_physs_port_3_tx_err), 
    .mse_physs_port_3_tx_crc(mse_physs_port_3_tx_crc), 
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
    .mse_physs_port_4_rx_rdy(mse_physs_port_4_rx_rdy), 
    .mse_physs_port_4_tx_wren(mse_physs_port_4_tx_wren), 
    .mse_physs_port_4_tx_data(mse_physs_port_4_tx_data), 
    .mse_physs_port_4_tx_sop(mse_physs_port_4_tx_sop), 
    .mse_physs_port_4_tx_eop(mse_physs_port_4_tx_eop), 
    .mse_physs_port_4_tx_mod(mse_physs_port_4_tx_mod), 
    .mse_physs_port_4_tx_err(mse_physs_port_4_tx_err), 
    .mse_physs_port_4_tx_crc(mse_physs_port_4_tx_crc), 
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
    .mse_physs_port_5_rx_rdy(mse_physs_port_5_rx_rdy), 
    .mse_physs_port_5_tx_wren(mse_physs_port_5_tx_wren), 
    .mse_physs_port_5_tx_data(mse_physs_port_5_tx_data), 
    .mse_physs_port_5_tx_sop(mse_physs_port_5_tx_sop), 
    .mse_physs_port_5_tx_eop(mse_physs_port_5_tx_eop), 
    .mse_physs_port_5_tx_mod(mse_physs_port_5_tx_mod), 
    .mse_physs_port_5_tx_err(mse_physs_port_5_tx_err), 
    .mse_physs_port_5_tx_crc(mse_physs_port_5_tx_crc), 
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
    .mse_physs_port_6_rx_rdy(mse_physs_port_6_rx_rdy), 
    .mse_physs_port_6_tx_wren(mse_physs_port_6_tx_wren), 
    .mse_physs_port_6_tx_data(mse_physs_port_6_tx_data), 
    .mse_physs_port_6_tx_sop(mse_physs_port_6_tx_sop), 
    .mse_physs_port_6_tx_eop(mse_physs_port_6_tx_eop), 
    .mse_physs_port_6_tx_mod(mse_physs_port_6_tx_mod), 
    .mse_physs_port_6_tx_err(mse_physs_port_6_tx_err), 
    .mse_physs_port_6_tx_crc(mse_physs_port_6_tx_crc), 
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
    .mse_physs_port_7_rx_rdy(mse_physs_port_7_rx_rdy), 
    .mse_physs_port_7_tx_wren(mse_physs_port_7_tx_wren), 
    .mse_physs_port_7_tx_data(mse_physs_port_7_tx_data), 
    .mse_physs_port_7_tx_sop(mse_physs_port_7_tx_sop), 
    .mse_physs_port_7_tx_eop(mse_physs_port_7_tx_eop), 
    .mse_physs_port_7_tx_mod(mse_physs_port_7_tx_mod), 
    .mse_physs_port_7_tx_err(mse_physs_port_7_tx_err), 
    .mse_physs_port_7_tx_crc(mse_physs_port_7_tx_crc), 
    .physs_clock_sync_2_physs_func_clk_gated_100(physs_clock_sync_2_physs_func_clk_gated_100), 
    .physs_clock_sync_3_physs_func_clk_gated_100(physs_clock_sync_3_physs_func_clk_gated_100), 
    .i_ck_cpu_debug_tck_0(i_ck_cpu_debug_tck_0), 
    .i_ck_cpu_debug_tck_1(i_ck_cpu_debug_tck_1), 
    .i_ck_dfx_upm_pma0_clk_debug_0(i_ck_dfx_upm_pma0_clk_debug_0), 
    .i_ck_dfx_upm_pma0_clk_debug_1(i_ck_dfx_upm_pma0_clk_debug_1), 
    .i_ck_dfx_upm_pma0_tck_0(i_ck_dfx_upm_pma0_tck_0), 
    .i_ck_dfx_upm_pma0_tck_1(i_ck_dfx_upm_pma0_tck_1), 
    .i_ck_dfx_upm_pma1_clk_debug_0(i_ck_dfx_upm_pma1_clk_debug_0), 
    .i_ck_dfx_upm_pma1_clk_debug_1(i_ck_dfx_upm_pma1_clk_debug_1), 
    .i_ck_dfx_upm_pma1_tck_0(i_ck_dfx_upm_pma1_tck_0), 
    .i_ck_dfx_upm_pma1_tck_1(i_ck_dfx_upm_pma1_tck_1), 
    .i_ck_dfx_upm_pma2_clk_debug_0(i_ck_dfx_upm_pma2_clk_debug_0), 
    .i_ck_dfx_upm_pma2_clk_debug_1(i_ck_dfx_upm_pma2_clk_debug_1), 
    .i_ck_dfx_upm_pma2_tck_0(i_ck_dfx_upm_pma2_tck_0), 
    .i_ck_dfx_upm_pma2_tck_1(i_ck_dfx_upm_pma2_tck_1), 
    .i_ck_dfx_upm_pma3_clk_debug_0(i_ck_dfx_upm_pma3_clk_debug_0), 
    .i_ck_dfx_upm_pma3_clk_debug_1(i_ck_dfx_upm_pma3_clk_debug_1), 
    .i_ck_dfx_upm_pma3_tck_0(i_ck_dfx_upm_pma3_tck_0), 
    .i_ck_dfx_upm_pma3_tck_1(i_ck_dfx_upm_pma3_tck_1), 
    .i_ck_fbscan_tck_0(i_ck_fbscan_tck_0), 
    .i_ck_fbscan_tck_1(i_ck_fbscan_tck_1), 
    .i_ck_fbscan_updatedr_0(i_ck_fbscan_updatedr_0), 
    .i_ck_fbscan_updatedr_1(i_ck_fbscan_updatedr_1), 
    .i_ck_fscan_pma_cmnpll_postdiv_0(i_ck_fscan_pma_cmnpll_postdiv_0), 
    .i_ck_fscan_pma_cmnpll_postdiv_1(i_ck_fscan_pma_cmnpll_postdiv_1), 
    .i_ck_fscan_pma_postclk_refclk_clk_cmnpll_0(i_ck_fscan_pma_postclk_refclk_clk_cmnpll_0), 
    .i_ck_fscan_pma_postclk_refclk_clk_cmnpll_1(i_ck_fscan_pma_postclk_refclk_clk_cmnpll_1), 
    .i_ck_fscan_pma_postclk_refclk_clk_txpll_0(i_ck_fscan_pma_postclk_refclk_clk_txpll_0), 
    .i_ck_fscan_pma_postclk_refclk_clk_txpll_1(i_ck_fscan_pma_postclk_refclk_clk_txpll_1), 
    .i_ck_fscan_pma_ref_0(i_ck_fscan_pma_ref_0), 
    .i_ck_fscan_pma_ref_1(i_ck_fscan_pma_ref_1), 
    .i_ck_fscan_ucss_postclk_0(i_ck_fscan_ucss_postclk_0), 
    .i_ck_fscan_ucss_postclk_1(i_ck_fscan_ucss_postclk_1), 
    .i_ck_pma0_jtag_tck(i_ck_pma0_jtag_tck), 
    .i_ck_pma1_jtag_tck(i_ck_pma1_jtag_tck), 
    .i_ck_pma2_jtag_tck(i_ck_pma2_jtag_tck), 
    .i_ck_pma3_jtag_tck(i_ck_pma3_jtag_tck), 
    .i_ck_pma4_jtag_tck(i_ck_pma4_jtag_tck), 
    .i_ck_pma5_jtag_tck(i_ck_pma5_jtag_tck), 
    .i_ck_pma6_jtag_tck(i_ck_pma6_jtag_tck), 
    .i_ck_pma7_jtag_tck(i_ck_pma7_jtag_tck), 
    .i_ck_ucss_jtag_tck_0(i_ck_ucss_jtag_tck_0), 
    .i_ck_ucss_jtag_tck_1(i_ck_ucss_jtag_tck_1), 
    .i_cpu_debug_prid_nt_0(i_cpu_debug_prid_nt_0), 
    .i_cpu_debug_prid_nt_1(i_cpu_debug_prid_nt_1), 
    .i_cpu_debug_tdi_0(i_cpu_debug_tdi_0), 
    .i_cpu_debug_tdi_1(i_cpu_debug_tdi_1), 
    .i_cpu_debug_tms_0(i_cpu_debug_tms_0), 
    .i_cpu_debug_tms_1(i_cpu_debug_tms_1), 
    .i_dfx_pma0_secure_tap_green(i_dfx_pma0_secure_tap_green), 
    .i_dfx_pma0_secure_tap_orange(i_dfx_pma0_secure_tap_orange), 
    .i_dfx_pma0_secure_tap_red(i_dfx_pma0_secure_tap_red), 
    .i_dfx_pma1_secure_tap_green(i_dfx_pma1_secure_tap_green), 
    .i_dfx_pma1_secure_tap_orange(i_dfx_pma1_secure_tap_orange), 
    .i_dfx_pma1_secure_tap_red(i_dfx_pma1_secure_tap_red), 
    .i_dfx_pma2_secure_tap_green(i_dfx_pma2_secure_tap_green), 
    .i_dfx_pma2_secure_tap_orange(i_dfx_pma2_secure_tap_orange), 
    .i_dfx_pma2_secure_tap_red(i_dfx_pma2_secure_tap_red), 
    .i_dfx_pma3_secure_tap_green(i_dfx_pma3_secure_tap_green), 
    .i_dfx_pma3_secure_tap_orange(i_dfx_pma3_secure_tap_orange), 
    .i_dfx_pma3_secure_tap_red(i_dfx_pma3_secure_tap_red), 
    .i_dfx_pma4_secure_tap_green(i_dfx_pma4_secure_tap_green), 
    .i_dfx_pma4_secure_tap_orange(i_dfx_pma4_secure_tap_orange), 
    .i_dfx_pma4_secure_tap_red(i_dfx_pma4_secure_tap_red), 
    .i_dfx_pma5_secure_tap_green(i_dfx_pma5_secure_tap_green), 
    .i_dfx_pma5_secure_tap_orange(i_dfx_pma5_secure_tap_orange), 
    .i_dfx_pma5_secure_tap_red(i_dfx_pma5_secure_tap_red), 
    .i_dfx_pma6_secure_tap_green(i_dfx_pma6_secure_tap_green), 
    .i_dfx_pma6_secure_tap_orange(i_dfx_pma6_secure_tap_orange), 
    .i_dfx_pma6_secure_tap_red(i_dfx_pma6_secure_tap_red), 
    .i_dfx_pma7_secure_tap_green(i_dfx_pma7_secure_tap_green), 
    .i_dfx_pma7_secure_tap_orange(i_dfx_pma7_secure_tap_orange), 
    .i_dfx_pma7_secure_tap_red(i_dfx_pma7_secure_tap_red), 
    .i_dfx_ucss_secure_tap_green_0(i_dfx_ucss_secure_tap_green_0), 
    .i_dfx_ucss_secure_tap_green_1(i_dfx_ucss_secure_tap_green_1), 
    .i_dfx_ucss_secure_tap_orange_0(i_dfx_ucss_secure_tap_orange_0), 
    .i_dfx_ucss_secure_tap_orange_1(i_dfx_ucss_secure_tap_orange_1), 
    .i_dfx_ucss_secure_tap_red_0(i_dfx_ucss_secure_tap_red_0), 
    .i_dfx_ucss_secure_tap_red_1(i_dfx_ucss_secure_tap_red_1), 
    .i_dfx_upm_pma0_capture_0(i_dfx_upm_pma0_capture_0), 
    .i_dfx_upm_pma0_capture_1(i_dfx_upm_pma0_capture_1), 
    .i_dfx_upm_pma0_fdfx_powergood_0(i_dfx_upm_pma0_fdfx_powergood_0), 
    .i_dfx_upm_pma0_fdfx_powergood_1(i_dfx_upm_pma0_fdfx_powergood_1), 
    .i_dfx_upm_pma0_iso_b_0(i_dfx_upm_pma0_iso_b_0), 
    .i_dfx_upm_pma0_iso_b_1(i_dfx_upm_pma0_iso_b_1), 
    .i_dfx_upm_pma0_secure_0(i_dfx_upm_pma0_secure_0), 
    .i_dfx_upm_pma0_secure_1(i_dfx_upm_pma0_secure_1), 
    .i_dfx_upm_pma0_sel_0(i_dfx_upm_pma0_sel_0), 
    .i_dfx_upm_pma0_sel_1(i_dfx_upm_pma0_sel_1), 
    .i_dfx_upm_pma0_shift_0(i_dfx_upm_pma0_shift_0), 
    .i_dfx_upm_pma0_shift_1(i_dfx_upm_pma0_shift_1), 
    .i_dfx_upm_pma0_si_0(i_dfx_upm_pma0_si_0), 
    .i_dfx_upm_pma0_si_1(i_dfx_upm_pma0_si_1), 
    .i_dfx_upm_pma0_update_0(i_dfx_upm_pma0_update_0), 
    .i_dfx_upm_pma0_update_1(i_dfx_upm_pma0_update_1), 
    .i_dfx_upm_pma1_capture_0(i_dfx_upm_pma1_capture_0), 
    .i_dfx_upm_pma1_capture_1(i_dfx_upm_pma1_capture_1), 
    .i_dfx_upm_pma1_fdfx_powergood_0(i_dfx_upm_pma1_fdfx_powergood_0), 
    .i_dfx_upm_pma1_fdfx_powergood_1(i_dfx_upm_pma1_fdfx_powergood_1), 
    .i_dfx_upm_pma1_iso_b_0(i_dfx_upm_pma1_iso_b_0), 
    .i_dfx_upm_pma1_iso_b_1(i_dfx_upm_pma1_iso_b_1), 
    .i_dfx_upm_pma1_secure_0(i_dfx_upm_pma1_secure_0), 
    .i_dfx_upm_pma1_secure_1(i_dfx_upm_pma1_secure_1), 
    .i_dfx_upm_pma1_sel_0(i_dfx_upm_pma1_sel_0), 
    .i_dfx_upm_pma1_sel_1(i_dfx_upm_pma1_sel_1), 
    .i_dfx_upm_pma1_shift_0(i_dfx_upm_pma1_shift_0), 
    .i_dfx_upm_pma1_shift_1(i_dfx_upm_pma1_shift_1), 
    .i_dfx_upm_pma1_si_0(i_dfx_upm_pma1_si_0), 
    .i_dfx_upm_pma1_si_1(i_dfx_upm_pma1_si_1), 
    .i_dfx_upm_pma1_update_0(i_dfx_upm_pma1_update_0), 
    .i_dfx_upm_pma1_update_1(i_dfx_upm_pma1_update_1), 
    .i_dfx_upm_pma2_capture_0(i_dfx_upm_pma2_capture_0), 
    .i_dfx_upm_pma2_capture_1(i_dfx_upm_pma2_capture_1), 
    .i_dfx_upm_pma2_fdfx_powergood_0(i_dfx_upm_pma2_fdfx_powergood_0), 
    .i_dfx_upm_pma2_fdfx_powergood_1(i_dfx_upm_pma2_fdfx_powergood_1), 
    .i_dfx_upm_pma2_iso_b_0(i_dfx_upm_pma2_iso_b_0), 
    .i_dfx_upm_pma2_iso_b_1(i_dfx_upm_pma2_iso_b_1), 
    .i_dfx_upm_pma2_secure_0(i_dfx_upm_pma2_secure_0), 
    .i_dfx_upm_pma2_secure_1(i_dfx_upm_pma2_secure_1), 
    .i_dfx_upm_pma2_sel_0(i_dfx_upm_pma2_sel_0), 
    .i_dfx_upm_pma2_sel_1(i_dfx_upm_pma2_sel_1), 
    .i_dfx_upm_pma2_shift_0(i_dfx_upm_pma2_shift_0), 
    .i_dfx_upm_pma2_shift_1(i_dfx_upm_pma2_shift_1), 
    .i_dfx_upm_pma2_si_0(i_dfx_upm_pma2_si_0), 
    .i_dfx_upm_pma2_si_1(i_dfx_upm_pma2_si_1), 
    .i_dfx_upm_pma2_update_0(i_dfx_upm_pma2_update_0), 
    .i_dfx_upm_pma2_update_1(i_dfx_upm_pma2_update_1), 
    .i_dfx_upm_pma3_capture_0(i_dfx_upm_pma3_capture_0), 
    .i_dfx_upm_pma3_capture_1(i_dfx_upm_pma3_capture_1), 
    .i_dfx_upm_pma3_fdfx_powergood_0(i_dfx_upm_pma3_fdfx_powergood_0), 
    .i_dfx_upm_pma3_fdfx_powergood_1(i_dfx_upm_pma3_fdfx_powergood_1), 
    .i_dfx_upm_pma3_iso_b_0(i_dfx_upm_pma3_iso_b_0), 
    .i_dfx_upm_pma3_iso_b_1(i_dfx_upm_pma3_iso_b_1), 
    .i_dfx_upm_pma3_secure_0(i_dfx_upm_pma3_secure_0), 
    .i_dfx_upm_pma3_secure_1(i_dfx_upm_pma3_secure_1), 
    .i_dfx_upm_pma3_sel_0(i_dfx_upm_pma3_sel_0), 
    .i_dfx_upm_pma3_sel_1(i_dfx_upm_pma3_sel_1), 
    .i_dfx_upm_pma3_shift_0(i_dfx_upm_pma3_shift_0), 
    .i_dfx_upm_pma3_shift_1(i_dfx_upm_pma3_shift_1), 
    .i_dfx_upm_pma3_si_0(i_dfx_upm_pma3_si_0), 
    .i_dfx_upm_pma3_si_1(i_dfx_upm_pma3_si_1), 
    .i_dfx_upm_pma3_update_0(i_dfx_upm_pma3_update_0), 
    .i_dfx_upm_pma3_update_1(i_dfx_upm_pma3_update_1), 
    .i_fbscan_capturedr_0(i_fbscan_capturedr_0), 
    .i_fbscan_capturedr_1(i_fbscan_capturedr_1), 
    .i_fbscan_chainen_0(i_fbscan_chainen_0), 
    .i_fbscan_chainen_1(i_fbscan_chainen_1), 
    .i_fbscan_d6actestsig_b_0(i_fbscan_d6actestsig_b_0), 
    .i_fbscan_d6actestsig_b_1(i_fbscan_d6actestsig_b_1), 
    .i_fbscan_d6init_0(i_fbscan_d6init_0), 
    .i_fbscan_d6init_1(i_fbscan_d6init_1), 
    .i_fbscan_d6select_0(i_fbscan_d6select_0), 
    .i_fbscan_d6select_1(i_fbscan_d6select_1), 
    .i_fbscan_extogen_0(i_fbscan_extogen_0), 
    .i_fbscan_extogen_1(i_fbscan_extogen_1), 
    .i_fbscan_extogsig_b_0(i_fbscan_extogsig_b_0), 
    .i_fbscan_extogsig_b_1(i_fbscan_extogsig_b_1), 
    .i_fbscan_highz_0(i_fbscan_highz_0), 
    .i_fbscan_highz_1(i_fbscan_highz_1), 
    .i_fbscan_mode_0(i_fbscan_mode_0), 
    .i_fbscan_mode_1(i_fbscan_mode_1), 
    .i_fbscan_shiftdr_0(i_fbscan_shiftdr_0), 
    .i_fbscan_shiftdr_1(i_fbscan_shiftdr_1), 
    .i_fbscan_tdi_0(i_fbscan_tdi_0), 
    .i_fbscan_tdi_1(i_fbscan_tdi_1), 
    .i_fdfx_powergood(i_fdfx_powergood), 
    .i_fscan_chain_bypass_nt_0(i_fscan_chain_bypass_nt_0), 
    .i_fscan_chain_bypass_nt_1(i_fscan_chain_bypass_nt_1), 
    .i_fscan_clkgenctrl_nt_0(i_fscan_clkgenctrl_nt_0), 
    .i_fscan_clkgenctrl_nt_1(i_fscan_clkgenctrl_nt_1), 
    .i_fscan_clkgenctrlen_nt_0(i_fscan_clkgenctrlen_nt_0), 
    .i_fscan_clkgenctrlen_nt_1(i_fscan_clkgenctrlen_nt_1), 
    .i_fscan_clkungate_nt_0(i_fscan_clkungate_nt_0), 
    .i_fscan_clkungate_nt_1(i_fscan_clkungate_nt_1), 
    .i_fscan_clkungate_syn_nt_0(i_fscan_clkungate_syn_nt_0), 
    .i_fscan_clkungate_syn_nt_1(i_fscan_clkungate_syn_nt_1), 
    .i_fscan_latch_bypass_in_nt_0(i_fscan_latch_bypass_in_nt_0), 
    .i_fscan_latch_bypass_in_nt_1(i_fscan_latch_bypass_in_nt_1), 
    .i_fscan_latch_bypass_out_nt_0(i_fscan_latch_bypass_out_nt_0), 
    .i_fscan_latch_bypass_out_nt_1(i_fscan_latch_bypass_out_nt_1), 
    .i_fscan_latchclosed_b_nt_0(i_fscan_latchclosed_b_nt_0), 
    .i_fscan_latchclosed_b_nt_1(i_fscan_latchclosed_b_nt_1), 
    .i_fscan_latchopen_nt_0(i_fscan_latchopen_nt_0), 
    .i_fscan_latchopen_nt_1(i_fscan_latchopen_nt_1), 
    .i_fscan_mode_atspeed_nt_0(i_fscan_mode_atspeed_nt_0), 
    .i_fscan_mode_atspeed_nt_1(i_fscan_mode_atspeed_nt_1), 
    .i_fscan_mode_nt_0(i_fscan_mode_nt_0), 
    .i_fscan_mode_nt_1(i_fscan_mode_nt_1), 
    .i_fscan_pll_isolate_nt_0(i_fscan_pll_isolate_nt_0), 
    .i_fscan_pll_isolate_nt_1(i_fscan_pll_isolate_nt_1), 
    .i_fscan_pll_scan_if_dis_nt_0(i_fscan_pll_scan_if_dis_nt_0), 
    .i_fscan_pll_scan_if_dis_nt_1(i_fscan_pll_scan_if_dis_nt_1), 
    .i_fscan_pma0_sdi_apb_cmn_0(i_fscan_pma0_sdi_apb_cmn_0), 
    .i_fscan_pma0_sdi_apb_cmn_1(i_fscan_pma0_sdi_apb_cmn_1), 
    .i_fscan_pma0_sdi_cmnplla_0(i_fscan_pma0_sdi_cmnplla_0), 
    .i_fscan_pma0_sdi_cmnplla_1(i_fscan_pma0_sdi_cmnplla_1), 
    .i_fscan_pma0_sdi_cmnpllb_0(i_fscan_pma0_sdi_cmnpllb_0), 
    .i_fscan_pma0_sdi_cmnpllb_1(i_fscan_pma0_sdi_cmnpllb_1), 
    .i_fscan_pma0_sdi_ctrl_l0_0(i_fscan_pma0_sdi_ctrl_l0_0), 
    .i_fscan_pma0_sdi_ctrl_l0_1(i_fscan_pma0_sdi_ctrl_l0_1), 
    .i_fscan_pma0_sdi_memarray_word_l0_0(i_fscan_pma0_sdi_memarray_word_l0_0), 
    .i_fscan_pma0_sdi_memarray_word_l0_1(i_fscan_pma0_sdi_memarray_word_l0_1), 
    .i_fscan_pma0_sdi_ref_channelcmn_0(i_fscan_pma0_sdi_ref_channelcmn_0), 
    .i_fscan_pma0_sdi_ref_channelcmn_1(i_fscan_pma0_sdi_ref_channelcmn_1), 
    .i_fscan_pma0_sdi_ref_channelleft_l0_0(i_fscan_pma0_sdi_ref_channelleft_l0_0), 
    .i_fscan_pma0_sdi_ref_channelleft_l0_1(i_fscan_pma0_sdi_ref_channelleft_l0_1), 
    .i_fscan_pma0_sdi_ref_channelright_l0_0(i_fscan_pma0_sdi_ref_channelright_l0_0), 
    .i_fscan_pma0_sdi_ref_channelright_l0_1(i_fscan_pma0_sdi_ref_channelright_l0_1), 
    .i_fscan_pma0_sdi_ref_cmn_0(i_fscan_pma0_sdi_ref_cmn_0), 
    .i_fscan_pma0_sdi_ref_cmn_1(i_fscan_pma0_sdi_ref_cmn_1), 
    .i_fscan_pma0_sdi_ref_l0_0(i_fscan_pma0_sdi_ref_l0_0), 
    .i_fscan_pma0_sdi_ref_l0_1(i_fscan_pma0_sdi_ref_l0_1), 
    .i_fscan_pma0_sdi_ref_txffe_l0_0(i_fscan_pma0_sdi_ref_txffe_l0_0), 
    .i_fscan_pma0_sdi_ref_txffe_l0_1(i_fscan_pma0_sdi_ref_txffe_l0_1), 
    .i_fscan_pma0_sdi_txpll_l0_0(i_fscan_pma0_sdi_txpll_l0_0), 
    .i_fscan_pma0_sdi_txpll_l0_1(i_fscan_pma0_sdi_txpll_l0_1), 
    .i_fscan_pma0_sdi_word_l0_0(i_fscan_pma0_sdi_word_l0_0), 
    .i_fscan_pma0_sdi_word_l0_1(i_fscan_pma0_sdi_word_l0_1), 
    .i_fscan_pma0_sdi_word_txffe_l0_0(i_fscan_pma0_sdi_word_txffe_l0_0), 
    .i_fscan_pma0_sdi_word_txffe_l0_1(i_fscan_pma0_sdi_word_txffe_l0_1), 
    .i_fscan_pma1_sdi_apb_cmn_0(i_fscan_pma1_sdi_apb_cmn_0), 
    .i_fscan_pma1_sdi_apb_cmn_1(i_fscan_pma1_sdi_apb_cmn_1), 
    .i_fscan_pma1_sdi_cmnplla_0(i_fscan_pma1_sdi_cmnplla_0), 
    .i_fscan_pma1_sdi_cmnplla_1(i_fscan_pma1_sdi_cmnplla_1), 
    .i_fscan_pma1_sdi_cmnpllb_0(i_fscan_pma1_sdi_cmnpllb_0), 
    .i_fscan_pma1_sdi_cmnpllb_1(i_fscan_pma1_sdi_cmnpllb_1), 
    .i_fscan_pma1_sdi_ctrl_l0_0(i_fscan_pma1_sdi_ctrl_l0_0), 
    .i_fscan_pma1_sdi_ctrl_l0_1(i_fscan_pma1_sdi_ctrl_l0_1), 
    .i_fscan_pma1_sdi_memarray_word_l0_0(i_fscan_pma1_sdi_memarray_word_l0_0), 
    .i_fscan_pma1_sdi_memarray_word_l0_1(i_fscan_pma1_sdi_memarray_word_l0_1), 
    .i_fscan_pma1_sdi_ref_channelcmn_0(i_fscan_pma1_sdi_ref_channelcmn_0), 
    .i_fscan_pma1_sdi_ref_channelcmn_1(i_fscan_pma1_sdi_ref_channelcmn_1), 
    .i_fscan_pma1_sdi_ref_channelleft_l0_0(i_fscan_pma1_sdi_ref_channelleft_l0_0), 
    .i_fscan_pma1_sdi_ref_channelleft_l0_1(i_fscan_pma1_sdi_ref_channelleft_l0_1), 
    .i_fscan_pma1_sdi_ref_channelright_l0_0(i_fscan_pma1_sdi_ref_channelright_l0_0), 
    .i_fscan_pma1_sdi_ref_channelright_l0_1(i_fscan_pma1_sdi_ref_channelright_l0_1), 
    .i_fscan_pma1_sdi_ref_cmn_0(i_fscan_pma1_sdi_ref_cmn_0), 
    .i_fscan_pma1_sdi_ref_cmn_1(i_fscan_pma1_sdi_ref_cmn_1), 
    .i_fscan_pma1_sdi_ref_l0_0(i_fscan_pma1_sdi_ref_l0_0), 
    .i_fscan_pma1_sdi_ref_l0_1(i_fscan_pma1_sdi_ref_l0_1), 
    .i_fscan_pma1_sdi_ref_txffe_l0_0(i_fscan_pma1_sdi_ref_txffe_l0_0), 
    .i_fscan_pma1_sdi_ref_txffe_l0_1(i_fscan_pma1_sdi_ref_txffe_l0_1), 
    .i_fscan_pma1_sdi_txpll_l0_0(i_fscan_pma1_sdi_txpll_l0_0), 
    .i_fscan_pma1_sdi_txpll_l0_1(i_fscan_pma1_sdi_txpll_l0_1), 
    .i_fscan_pma1_sdi_word_l0_0(i_fscan_pma1_sdi_word_l0_0), 
    .i_fscan_pma1_sdi_word_l0_1(i_fscan_pma1_sdi_word_l0_1), 
    .i_fscan_pma1_sdi_word_txffe_l0_0(i_fscan_pma1_sdi_word_txffe_l0_0), 
    .i_fscan_pma1_sdi_word_txffe_l0_1(i_fscan_pma1_sdi_word_txffe_l0_1), 
    .i_fscan_pma2_sdi_apb_cmn_0(i_fscan_pma2_sdi_apb_cmn_0), 
    .i_fscan_pma2_sdi_apb_cmn_1(i_fscan_pma2_sdi_apb_cmn_1), 
    .i_fscan_pma2_sdi_cmnplla_0(i_fscan_pma2_sdi_cmnplla_0), 
    .i_fscan_pma2_sdi_cmnplla_1(i_fscan_pma2_sdi_cmnplla_1), 
    .i_fscan_pma2_sdi_cmnpllb_0(i_fscan_pma2_sdi_cmnpllb_0), 
    .i_fscan_pma2_sdi_cmnpllb_1(i_fscan_pma2_sdi_cmnpllb_1), 
    .i_fscan_pma2_sdi_ctrl_l0_0(i_fscan_pma2_sdi_ctrl_l0_0), 
    .i_fscan_pma2_sdi_ctrl_l0_1(i_fscan_pma2_sdi_ctrl_l0_1), 
    .i_fscan_pma2_sdi_memarray_word_l0_0(i_fscan_pma2_sdi_memarray_word_l0_0), 
    .i_fscan_pma2_sdi_memarray_word_l0_1(i_fscan_pma2_sdi_memarray_word_l0_1), 
    .i_fscan_pma2_sdi_ref_channelcmn_0(i_fscan_pma2_sdi_ref_channelcmn_0), 
    .i_fscan_pma2_sdi_ref_channelcmn_1(i_fscan_pma2_sdi_ref_channelcmn_1), 
    .i_fscan_pma2_sdi_ref_channelleft_l0_0(i_fscan_pma2_sdi_ref_channelleft_l0_0), 
    .i_fscan_pma2_sdi_ref_channelleft_l0_1(i_fscan_pma2_sdi_ref_channelleft_l0_1), 
    .i_fscan_pma2_sdi_ref_channelright_l0_0(i_fscan_pma2_sdi_ref_channelright_l0_0), 
    .i_fscan_pma2_sdi_ref_channelright_l0_1(i_fscan_pma2_sdi_ref_channelright_l0_1), 
    .i_fscan_pma2_sdi_ref_cmn_0(i_fscan_pma2_sdi_ref_cmn_0), 
    .i_fscan_pma2_sdi_ref_cmn_1(i_fscan_pma2_sdi_ref_cmn_1), 
    .i_fscan_pma2_sdi_ref_l0_0(i_fscan_pma2_sdi_ref_l0_0), 
    .i_fscan_pma2_sdi_ref_l0_1(i_fscan_pma2_sdi_ref_l0_1), 
    .i_fscan_pma2_sdi_ref_txffe_l0_0(i_fscan_pma2_sdi_ref_txffe_l0_0), 
    .i_fscan_pma2_sdi_ref_txffe_l0_1(i_fscan_pma2_sdi_ref_txffe_l0_1), 
    .i_fscan_pma2_sdi_txpll_l0_0(i_fscan_pma2_sdi_txpll_l0_0), 
    .i_fscan_pma2_sdi_txpll_l0_1(i_fscan_pma2_sdi_txpll_l0_1), 
    .i_fscan_pma2_sdi_word_l0_0(i_fscan_pma2_sdi_word_l0_0), 
    .i_fscan_pma2_sdi_word_l0_1(i_fscan_pma2_sdi_word_l0_1), 
    .i_fscan_pma2_sdi_word_txffe_l0_0(i_fscan_pma2_sdi_word_txffe_l0_0), 
    .i_fscan_pma2_sdi_word_txffe_l0_1(i_fscan_pma2_sdi_word_txffe_l0_1), 
    .i_fscan_pma3_sdi_apb_cmn_0(i_fscan_pma3_sdi_apb_cmn_0), 
    .i_fscan_pma3_sdi_apb_cmn_1(i_fscan_pma3_sdi_apb_cmn_1), 
    .i_fscan_pma3_sdi_cmnplla_0(i_fscan_pma3_sdi_cmnplla_0), 
    .i_fscan_pma3_sdi_cmnplla_1(i_fscan_pma3_sdi_cmnplla_1), 
    .i_fscan_pma3_sdi_cmnpllb_0(i_fscan_pma3_sdi_cmnpllb_0), 
    .i_fscan_pma3_sdi_cmnpllb_1(i_fscan_pma3_sdi_cmnpllb_1), 
    .i_fscan_pma3_sdi_ctrl_l0_0(i_fscan_pma3_sdi_ctrl_l0_0), 
    .i_fscan_pma3_sdi_ctrl_l0_1(i_fscan_pma3_sdi_ctrl_l0_1), 
    .i_fscan_pma3_sdi_memarray_word_l0_0(i_fscan_pma3_sdi_memarray_word_l0_0), 
    .i_fscan_pma3_sdi_memarray_word_l0_1(i_fscan_pma3_sdi_memarray_word_l0_1), 
    .i_fscan_pma3_sdi_ref_channelcmn_0(i_fscan_pma3_sdi_ref_channelcmn_0), 
    .i_fscan_pma3_sdi_ref_channelcmn_1(i_fscan_pma3_sdi_ref_channelcmn_1), 
    .i_fscan_pma3_sdi_ref_channelleft_l0_0(i_fscan_pma3_sdi_ref_channelleft_l0_0), 
    .i_fscan_pma3_sdi_ref_channelleft_l0_1(i_fscan_pma3_sdi_ref_channelleft_l0_1), 
    .i_fscan_pma3_sdi_ref_channelright_l0_0(i_fscan_pma3_sdi_ref_channelright_l0_0), 
    .i_fscan_pma3_sdi_ref_channelright_l0_1(i_fscan_pma3_sdi_ref_channelright_l0_1), 
    .i_fscan_pma3_sdi_ref_cmn_0(i_fscan_pma3_sdi_ref_cmn_0), 
    .i_fscan_pma3_sdi_ref_cmn_1(i_fscan_pma3_sdi_ref_cmn_1), 
    .i_fscan_pma3_sdi_ref_l0_0(i_fscan_pma3_sdi_ref_l0_0), 
    .i_fscan_pma3_sdi_ref_l0_1(i_fscan_pma3_sdi_ref_l0_1), 
    .i_fscan_pma3_sdi_ref_txffe_l0_0(i_fscan_pma3_sdi_ref_txffe_l0_0), 
    .i_fscan_pma3_sdi_ref_txffe_l0_1(i_fscan_pma3_sdi_ref_txffe_l0_1), 
    .i_fscan_pma3_sdi_txpll_l0_0(i_fscan_pma3_sdi_txpll_l0_0), 
    .i_fscan_pma3_sdi_txpll_l0_1(i_fscan_pma3_sdi_txpll_l0_1), 
    .i_fscan_pma3_sdi_word_l0_0(i_fscan_pma3_sdi_word_l0_0), 
    .i_fscan_pma3_sdi_word_l0_1(i_fscan_pma3_sdi_word_l0_1), 
    .i_fscan_pma3_sdi_word_txffe_l0_0(i_fscan_pma3_sdi_word_txffe_l0_0), 
    .i_fscan_pma3_sdi_word_txffe_l0_1(i_fscan_pma3_sdi_word_txffe_l0_1), 
    .i_fscan_ret_control_nt_0(i_fscan_ret_control_nt_0), 
    .i_fscan_ret_control_nt_1(i_fscan_ret_control_nt_1), 
    .i_fscan_rstbypen_nt_0(i_fscan_rstbypen_nt_0), 
    .i_fscan_rstbypen_nt_1(i_fscan_rstbypen_nt_1), 
    .i_fscan_shiften_nt_0(i_fscan_shiften_nt_0), 
    .i_fscan_shiften_nt_1(i_fscan_shiften_nt_1), 
    .i_fscan_slos_en_nt_0(i_fscan_slos_en_nt_0), 
    .i_fscan_slos_en_nt_1(i_fscan_slos_en_nt_1), 
    .i_rst_cpu_debug_trst_b_a_0(i_rst_cpu_debug_trst_b_a_0), 
    .i_rst_cpu_debug_trst_b_a_1(i_rst_cpu_debug_trst_b_a_1), 
    .i_rst_dfx_upm_pma0_trst_b_0(i_rst_dfx_upm_pma0_trst_b_0), 
    .i_rst_dfx_upm_pma0_trst_b_1(i_rst_dfx_upm_pma0_trst_b_1), 
    .i_rst_dfx_upm_pma1_trst_b_0(i_rst_dfx_upm_pma1_trst_b_0), 
    .i_rst_dfx_upm_pma1_trst_b_1(i_rst_dfx_upm_pma1_trst_b_1), 
    .i_rst_dfx_upm_pma2_trst_b_0(i_rst_dfx_upm_pma2_trst_b_0), 
    .i_rst_dfx_upm_pma2_trst_b_1(i_rst_dfx_upm_pma2_trst_b_1), 
    .i_rst_dfx_upm_pma3_trst_b_0(i_rst_dfx_upm_pma3_trst_b_0), 
    .i_rst_dfx_upm_pma3_trst_b_1(i_rst_dfx_upm_pma3_trst_b_1), 
    .i_rst_fscan_byplatrst_b_0(i_rst_fscan_byplatrst_b_0), 
    .i_rst_fscan_byplatrst_b_1(i_rst_fscan_byplatrst_b_1), 
    .i_rst_fscan_byprst_b_0(i_rst_fscan_byprst_b_0), 
    .i_rst_fscan_byprst_b_1(i_rst_fscan_byprst_b_1), 
    .i_rst_ucss_jtag_trst_b_a_0(i_rst_ucss_jtag_trst_b_a_0), 
    .i_rst_ucss_jtag_trst_b_a_1(i_rst_ucss_jtag_trst_b_a_1), 
    .i_scanio_en_nt_0(i_scanio_en_nt_0), 
    .i_scanio_en_nt_1(i_scanio_en_nt_1), 
    .i_scanio_pma0_dat_ref0_n_a_0(i_scanio_pma0_dat_ref0_n_a_0), 
    .i_scanio_pma0_dat_ref0_n_a_1(i_scanio_pma0_dat_ref0_n_a_1), 
    .i_scanio_pma0_dat_ref0_p_a_0(i_scanio_pma0_dat_ref0_p_a_0), 
    .i_scanio_pma0_dat_ref0_p_a_1(i_scanio_pma0_dat_ref0_p_a_1), 
    .i_scanio_pma0_dat_ref1_n_a_0(i_scanio_pma0_dat_ref1_n_a_0), 
    .i_scanio_pma0_dat_ref1_n_a_1(i_scanio_pma0_dat_ref1_n_a_1), 
    .i_scanio_pma0_dat_ref1_p_a_0(i_scanio_pma0_dat_ref1_p_a_0), 
    .i_scanio_pma0_dat_ref1_p_a_1(i_scanio_pma0_dat_ref1_p_a_1), 
    .i_scanio_pma0_dat_tx_n_l0_a_0(i_scanio_pma0_dat_tx_n_l0_a_0), 
    .i_scanio_pma0_dat_tx_n_l0_a_1(i_scanio_pma0_dat_tx_n_l0_a_1), 
    .i_scanio_pma0_dat_tx_p_l0_a_0(i_scanio_pma0_dat_tx_p_l0_a_0), 
    .i_scanio_pma0_dat_tx_p_l0_a_1(i_scanio_pma0_dat_tx_p_l0_a_1), 
    .i_scanio_pma0_ref0_outen_nt_0(i_scanio_pma0_ref0_outen_nt_0), 
    .i_scanio_pma0_ref0_outen_nt_1(i_scanio_pma0_ref0_outen_nt_1), 
    .i_scanio_pma0_ref1_outen_nt_0(i_scanio_pma0_ref1_outen_nt_0), 
    .i_scanio_pma0_ref1_outen_nt_1(i_scanio_pma0_ref1_outen_nt_1), 
    .i_scanio_pma1_dat_ref0_n_a_0(i_scanio_pma1_dat_ref0_n_a_0), 
    .i_scanio_pma1_dat_ref0_n_a_1(i_scanio_pma1_dat_ref0_n_a_1), 
    .i_scanio_pma1_dat_ref0_p_a_0(i_scanio_pma1_dat_ref0_p_a_0), 
    .i_scanio_pma1_dat_ref0_p_a_1(i_scanio_pma1_dat_ref0_p_a_1), 
    .i_scanio_pma1_dat_ref1_n_a_0(i_scanio_pma1_dat_ref1_n_a_0), 
    .i_scanio_pma1_dat_ref1_n_a_1(i_scanio_pma1_dat_ref1_n_a_1), 
    .i_scanio_pma1_dat_ref1_p_a_0(i_scanio_pma1_dat_ref1_p_a_0), 
    .i_scanio_pma1_dat_ref1_p_a_1(i_scanio_pma1_dat_ref1_p_a_1), 
    .i_scanio_pma1_dat_tx_n_l0_a_0(i_scanio_pma1_dat_tx_n_l0_a_0), 
    .i_scanio_pma1_dat_tx_n_l0_a_1(i_scanio_pma1_dat_tx_n_l0_a_1), 
    .i_scanio_pma1_dat_tx_p_l0_a_0(i_scanio_pma1_dat_tx_p_l0_a_0), 
    .i_scanio_pma1_dat_tx_p_l0_a_1(i_scanio_pma1_dat_tx_p_l0_a_1), 
    .i_scanio_pma1_ref0_outen_nt_0(i_scanio_pma1_ref0_outen_nt_0), 
    .i_scanio_pma1_ref0_outen_nt_1(i_scanio_pma1_ref0_outen_nt_1), 
    .i_scanio_pma1_ref1_outen_nt_0(i_scanio_pma1_ref1_outen_nt_0), 
    .i_scanio_pma1_ref1_outen_nt_1(i_scanio_pma1_ref1_outen_nt_1), 
    .i_scanio_pma2_dat_ref0_n_a_0(i_scanio_pma2_dat_ref0_n_a_0), 
    .i_scanio_pma2_dat_ref0_n_a_1(i_scanio_pma2_dat_ref0_n_a_1), 
    .i_scanio_pma2_dat_ref0_p_a_0(i_scanio_pma2_dat_ref0_p_a_0), 
    .i_scanio_pma2_dat_ref0_p_a_1(i_scanio_pma2_dat_ref0_p_a_1), 
    .i_scanio_pma2_dat_ref1_n_a_0(i_scanio_pma2_dat_ref1_n_a_0), 
    .i_scanio_pma2_dat_ref1_n_a_1(i_scanio_pma2_dat_ref1_n_a_1), 
    .i_scanio_pma2_dat_ref1_p_a_0(i_scanio_pma2_dat_ref1_p_a_0), 
    .i_scanio_pma2_dat_ref1_p_a_1(i_scanio_pma2_dat_ref1_p_a_1), 
    .i_scanio_pma2_dat_tx_n_l0_a_0(i_scanio_pma2_dat_tx_n_l0_a_0), 
    .i_scanio_pma2_dat_tx_n_l0_a_1(i_scanio_pma2_dat_tx_n_l0_a_1), 
    .i_scanio_pma2_dat_tx_p_l0_a_0(i_scanio_pma2_dat_tx_p_l0_a_0), 
    .i_scanio_pma2_dat_tx_p_l0_a_1(i_scanio_pma2_dat_tx_p_l0_a_1), 
    .i_scanio_pma2_ref0_outen_nt_0(i_scanio_pma2_ref0_outen_nt_0), 
    .i_scanio_pma2_ref0_outen_nt_1(i_scanio_pma2_ref0_outen_nt_1), 
    .i_scanio_pma2_ref1_outen_nt_0(i_scanio_pma2_ref1_outen_nt_0), 
    .i_scanio_pma2_ref1_outen_nt_1(i_scanio_pma2_ref1_outen_nt_1), 
    .i_scanio_pma3_dat_ref0_n_a_0(i_scanio_pma3_dat_ref0_n_a_0), 
    .i_scanio_pma3_dat_ref0_n_a_1(i_scanio_pma3_dat_ref0_n_a_1), 
    .i_scanio_pma3_dat_ref0_p_a_0(i_scanio_pma3_dat_ref0_p_a_0), 
    .i_scanio_pma3_dat_ref0_p_a_1(i_scanio_pma3_dat_ref0_p_a_1), 
    .i_scanio_pma3_dat_ref1_n_a_0(i_scanio_pma3_dat_ref1_n_a_0), 
    .i_scanio_pma3_dat_ref1_n_a_1(i_scanio_pma3_dat_ref1_n_a_1), 
    .i_scanio_pma3_dat_ref1_p_a_0(i_scanio_pma3_dat_ref1_p_a_0), 
    .i_scanio_pma3_dat_ref1_p_a_1(i_scanio_pma3_dat_ref1_p_a_1), 
    .i_scanio_pma3_dat_tx_n_l0_a_0(i_scanio_pma3_dat_tx_n_l0_a_0), 
    .i_scanio_pma3_dat_tx_n_l0_a_1(i_scanio_pma3_dat_tx_n_l0_a_1), 
    .i_scanio_pma3_dat_tx_p_l0_a_0(i_scanio_pma3_dat_tx_p_l0_a_0), 
    .i_scanio_pma3_dat_tx_p_l0_a_1(i_scanio_pma3_dat_tx_p_l0_a_1), 
    .i_scanio_pma3_ref0_outen_nt_0(i_scanio_pma3_ref0_outen_nt_0), 
    .i_scanio_pma3_ref0_outen_nt_1(i_scanio_pma3_ref0_outen_nt_1), 
    .i_scanio_pma3_ref1_outen_nt_0(i_scanio_pma3_ref1_outen_nt_0), 
    .i_scanio_pma3_ref1_outen_nt_1(i_scanio_pma3_ref1_outen_nt_1), 
    .i_ucss_jtag_id_nt_0(i_ucss_jtag_id_nt_0), 
    .i_ucss_jtag_id_nt_1(i_ucss_jtag_id_nt_1), 
    .i_ucss_jtag_slvid_nt_0(i_ucss_jtag_slvid_nt_0), 
    .i_ucss_jtag_slvid_nt_1(i_ucss_jtag_slvid_nt_1), 
    .i_ucss_jtag_tdi_0(i_ucss_jtag_tdi_0), 
    .i_ucss_jtag_tdi_1(i_ucss_jtag_tdi_1), 
    .i_ucss_jtag_tms_0(i_ucss_jtag_tms_0), 
    .i_ucss_jtag_tms_1(i_ucss_jtag_tms_1), 
    .versa_xmp_0_o_abscan_pma0_tdo(o_abscan_pma0_tdo_0), 
    .versa_xmp_1_o_abscan_pma0_tdo(o_abscan_pma0_tdo_1), 
    .versa_xmp_0_o_abscan_pma0_tdo_f(o_abscan_pma0_tdo_f_0), 
    .versa_xmp_1_o_abscan_pma0_tdo_f(o_abscan_pma0_tdo_f_1), 
    .versa_xmp_0_o_abscan_pma1_tdo(o_abscan_pma1_tdo_0), 
    .versa_xmp_1_o_abscan_pma1_tdo(o_abscan_pma1_tdo_1), 
    .versa_xmp_0_o_abscan_pma1_tdo_f(o_abscan_pma1_tdo_f_0), 
    .versa_xmp_1_o_abscan_pma1_tdo_f(o_abscan_pma1_tdo_f_1), 
    .versa_xmp_0_o_abscan_pma2_tdo(o_abscan_pma2_tdo_0), 
    .versa_xmp_1_o_abscan_pma2_tdo(o_abscan_pma2_tdo_1), 
    .versa_xmp_0_o_abscan_pma2_tdo_f(o_abscan_pma2_tdo_f_0), 
    .versa_xmp_1_o_abscan_pma2_tdo_f(o_abscan_pma2_tdo_f_1), 
    .versa_xmp_0_o_abscan_pma3_tdo(o_abscan_pma3_tdo_0), 
    .versa_xmp_1_o_abscan_pma3_tdo(o_abscan_pma3_tdo_1), 
    .versa_xmp_0_o_abscan_pma3_tdo_f(o_abscan_pma3_tdo_f_0), 
    .versa_xmp_1_o_abscan_pma3_tdo_f(o_abscan_pma3_tdo_f_1), 
    .versa_xmp_0_o_ascan_pma0_sdo_apb_cmn(o_ascan_pma0_sdo_apb_cmn_0), 
    .versa_xmp_1_o_ascan_pma0_sdo_apb_cmn(o_ascan_pma0_sdo_apb_cmn_1), 
    .versa_xmp_0_o_ascan_pma0_sdo_cmnplla(o_ascan_pma0_sdo_cmnplla_0), 
    .versa_xmp_1_o_ascan_pma0_sdo_cmnplla(o_ascan_pma0_sdo_cmnplla_1), 
    .versa_xmp_0_o_ascan_pma0_sdo_cmnpllb(o_ascan_pma0_sdo_cmnpllb_0), 
    .versa_xmp_1_o_ascan_pma0_sdo_cmnpllb(o_ascan_pma0_sdo_cmnpllb_1), 
    .versa_xmp_0_o_ascan_pma0_sdo_ctrl_l0(o_ascan_pma0_sdo_ctrl_l0_0), 
    .versa_xmp_1_o_ascan_pma0_sdo_ctrl_l0(o_ascan_pma0_sdo_ctrl_l0_1), 
    .versa_xmp_0_o_ascan_pma0_sdo_memarray_word_l0(o_ascan_pma0_sdo_memarray_word_l0_0), 
    .versa_xmp_1_o_ascan_pma0_sdo_memarray_word_l0(o_ascan_pma0_sdo_memarray_word_l0_1), 
    .versa_xmp_0_o_ascan_pma0_sdo_ref_channelcmn(o_ascan_pma0_sdo_ref_channelcmn_0), 
    .versa_xmp_1_o_ascan_pma0_sdo_ref_channelcmn(o_ascan_pma0_sdo_ref_channelcmn_1), 
    .versa_xmp_0_o_ascan_pma0_sdo_ref_channelleft_l0(o_ascan_pma0_sdo_ref_channelleft_l0_0), 
    .versa_xmp_1_o_ascan_pma0_sdo_ref_channelleft_l0(o_ascan_pma0_sdo_ref_channelleft_l0_1), 
    .versa_xmp_0_o_ascan_pma0_sdo_ref_channelright_l0(o_ascan_pma0_sdo_ref_channelright_l0_0), 
    .versa_xmp_1_o_ascan_pma0_sdo_ref_channelright_l0(o_ascan_pma0_sdo_ref_channelright_l0_1), 
    .versa_xmp_0_o_ascan_pma0_sdo_ref_cmn(o_ascan_pma0_sdo_ref_cmn_0), 
    .versa_xmp_1_o_ascan_pma0_sdo_ref_cmn(o_ascan_pma0_sdo_ref_cmn_1), 
    .versa_xmp_0_o_ascan_pma0_sdo_ref_l0(o_ascan_pma0_sdo_ref_l0_0), 
    .versa_xmp_1_o_ascan_pma0_sdo_ref_l0(o_ascan_pma0_sdo_ref_l0_1), 
    .versa_xmp_0_o_ascan_pma0_sdo_ref_txffe_l0(o_ascan_pma0_sdo_ref_txffe_l0_0), 
    .versa_xmp_1_o_ascan_pma0_sdo_ref_txffe_l0(o_ascan_pma0_sdo_ref_txffe_l0_1), 
    .versa_xmp_0_o_ascan_pma0_sdo_txpll_l0(o_ascan_pma0_sdo_txpll_l0_0), 
    .versa_xmp_1_o_ascan_pma0_sdo_txpll_l0(o_ascan_pma0_sdo_txpll_l0_1), 
    .versa_xmp_0_o_ascan_pma0_sdo_word_l0(o_ascan_pma0_sdo_word_l0_0), 
    .versa_xmp_1_o_ascan_pma0_sdo_word_l0(o_ascan_pma0_sdo_word_l0_1), 
    .versa_xmp_0_o_ascan_pma0_sdo_word_txffe_l0(o_ascan_pma0_sdo_word_txffe_l0_0), 
    .versa_xmp_1_o_ascan_pma0_sdo_word_txffe_l0(o_ascan_pma0_sdo_word_txffe_l0_1), 
    .versa_xmp_0_o_ascan_pma1_sdo_apb_cmn(o_ascan_pma1_sdo_apb_cmn_0), 
    .versa_xmp_1_o_ascan_pma1_sdo_apb_cmn(o_ascan_pma1_sdo_apb_cmn_1), 
    .versa_xmp_0_o_ascan_pma1_sdo_cmnplla(o_ascan_pma1_sdo_cmnplla_0), 
    .versa_xmp_1_o_ascan_pma1_sdo_cmnplla(o_ascan_pma1_sdo_cmnplla_1), 
    .versa_xmp_0_o_ascan_pma1_sdo_cmnpllb(o_ascan_pma1_sdo_cmnpllb_0), 
    .versa_xmp_1_o_ascan_pma1_sdo_cmnpllb(o_ascan_pma1_sdo_cmnpllb_1), 
    .versa_xmp_0_o_ascan_pma1_sdo_ctrl_l0(o_ascan_pma1_sdo_ctrl_l0_0), 
    .versa_xmp_1_o_ascan_pma1_sdo_ctrl_l0(o_ascan_pma1_sdo_ctrl_l0_1), 
    .versa_xmp_0_o_ascan_pma1_sdo_memarray_word_l0(o_ascan_pma1_sdo_memarray_word_l0_0), 
    .versa_xmp_1_o_ascan_pma1_sdo_memarray_word_l0(o_ascan_pma1_sdo_memarray_word_l0_1), 
    .versa_xmp_0_o_ascan_pma1_sdo_ref_channelcmn(o_ascan_pma1_sdo_ref_channelcmn_0), 
    .versa_xmp_1_o_ascan_pma1_sdo_ref_channelcmn(o_ascan_pma1_sdo_ref_channelcmn_1), 
    .versa_xmp_0_o_ascan_pma1_sdo_ref_channelleft_l0(o_ascan_pma1_sdo_ref_channelleft_l0_0), 
    .versa_xmp_1_o_ascan_pma1_sdo_ref_channelleft_l0(o_ascan_pma1_sdo_ref_channelleft_l0_1), 
    .versa_xmp_0_o_ascan_pma1_sdo_ref_channelright_l0(o_ascan_pma1_sdo_ref_channelright_l0_0), 
    .versa_xmp_1_o_ascan_pma1_sdo_ref_channelright_l0(o_ascan_pma1_sdo_ref_channelright_l0_1), 
    .versa_xmp_0_o_ascan_pma1_sdo_ref_cmn(o_ascan_pma1_sdo_ref_cmn_0), 
    .versa_xmp_1_o_ascan_pma1_sdo_ref_cmn(o_ascan_pma1_sdo_ref_cmn_1), 
    .versa_xmp_0_o_ascan_pma1_sdo_ref_l0(o_ascan_pma1_sdo_ref_l0_0), 
    .versa_xmp_1_o_ascan_pma1_sdo_ref_l0(o_ascan_pma1_sdo_ref_l0_1), 
    .versa_xmp_0_o_ascan_pma1_sdo_ref_txffe_l0(o_ascan_pma1_sdo_ref_txffe_l0_0), 
    .versa_xmp_1_o_ascan_pma1_sdo_ref_txffe_l0(o_ascan_pma1_sdo_ref_txffe_l0_1), 
    .versa_xmp_0_o_ascan_pma1_sdo_txpll_l0(o_ascan_pma1_sdo_txpll_l0_0), 
    .versa_xmp_1_o_ascan_pma1_sdo_txpll_l0(o_ascan_pma1_sdo_txpll_l0_1), 
    .versa_xmp_0_o_ascan_pma1_sdo_word_l0(o_ascan_pma1_sdo_word_l0_0), 
    .versa_xmp_1_o_ascan_pma1_sdo_word_l0(o_ascan_pma1_sdo_word_l0_1), 
    .versa_xmp_0_o_ascan_pma1_sdo_word_txffe_l0(o_ascan_pma1_sdo_word_txffe_l0_0), 
    .versa_xmp_1_o_ascan_pma1_sdo_word_txffe_l0(o_ascan_pma1_sdo_word_txffe_l0_1), 
    .versa_xmp_0_o_ascan_pma2_sdo_apb_cmn(o_ascan_pma2_sdo_apb_cmn_0), 
    .versa_xmp_1_o_ascan_pma2_sdo_apb_cmn(o_ascan_pma2_sdo_apb_cmn_1), 
    .versa_xmp_0_o_ascan_pma2_sdo_cmnplla(o_ascan_pma2_sdo_cmnplla_0), 
    .versa_xmp_1_o_ascan_pma2_sdo_cmnplla(o_ascan_pma2_sdo_cmnplla_1), 
    .versa_xmp_0_o_ascan_pma2_sdo_cmnpllb(o_ascan_pma2_sdo_cmnpllb_0), 
    .versa_xmp_1_o_ascan_pma2_sdo_cmnpllb(o_ascan_pma2_sdo_cmnpllb_1), 
    .versa_xmp_0_o_ascan_pma2_sdo_ctrl_l0(o_ascan_pma2_sdo_ctrl_l0_0), 
    .versa_xmp_1_o_ascan_pma2_sdo_ctrl_l0(o_ascan_pma2_sdo_ctrl_l0_1), 
    .versa_xmp_0_o_ascan_pma2_sdo_memarray_word_l0(o_ascan_pma2_sdo_memarray_word_l0_0), 
    .versa_xmp_1_o_ascan_pma2_sdo_memarray_word_l0(o_ascan_pma2_sdo_memarray_word_l0_1), 
    .versa_xmp_0_o_ascan_pma2_sdo_ref_channelcmn(o_ascan_pma2_sdo_ref_channelcmn_0), 
    .versa_xmp_1_o_ascan_pma2_sdo_ref_channelcmn(o_ascan_pma2_sdo_ref_channelcmn_1), 
    .versa_xmp_0_o_ascan_pma2_sdo_ref_channelleft_l0(o_ascan_pma2_sdo_ref_channelleft_l0_0), 
    .versa_xmp_1_o_ascan_pma2_sdo_ref_channelleft_l0(o_ascan_pma2_sdo_ref_channelleft_l0_1), 
    .versa_xmp_0_o_ascan_pma2_sdo_ref_channelright_l0(o_ascan_pma2_sdo_ref_channelright_l0_0), 
    .versa_xmp_1_o_ascan_pma2_sdo_ref_channelright_l0(o_ascan_pma2_sdo_ref_channelright_l0_1), 
    .versa_xmp_0_o_ascan_pma2_sdo_ref_cmn(o_ascan_pma2_sdo_ref_cmn_0), 
    .versa_xmp_1_o_ascan_pma2_sdo_ref_cmn(o_ascan_pma2_sdo_ref_cmn_1), 
    .versa_xmp_0_o_ascan_pma2_sdo_ref_l0(o_ascan_pma2_sdo_ref_l0_0), 
    .versa_xmp_1_o_ascan_pma2_sdo_ref_l0(o_ascan_pma2_sdo_ref_l0_1), 
    .versa_xmp_0_o_ascan_pma2_sdo_ref_txffe_l0(o_ascan_pma2_sdo_ref_txffe_l0_0), 
    .versa_xmp_1_o_ascan_pma2_sdo_ref_txffe_l0(o_ascan_pma2_sdo_ref_txffe_l0_1), 
    .versa_xmp_0_o_ascan_pma2_sdo_txpll_l0(o_ascan_pma2_sdo_txpll_l0_0), 
    .versa_xmp_1_o_ascan_pma2_sdo_txpll_l0(o_ascan_pma2_sdo_txpll_l0_1), 
    .versa_xmp_0_o_ascan_pma2_sdo_word_l0(o_ascan_pma2_sdo_word_l0_0), 
    .versa_xmp_1_o_ascan_pma2_sdo_word_l0(o_ascan_pma2_sdo_word_l0_1), 
    .versa_xmp_0_o_ascan_pma2_sdo_word_txffe_l0(o_ascan_pma2_sdo_word_txffe_l0_0), 
    .versa_xmp_1_o_ascan_pma2_sdo_word_txffe_l0(o_ascan_pma2_sdo_word_txffe_l0_1), 
    .versa_xmp_0_o_ascan_pma3_sdo_apb_cmn(o_ascan_pma3_sdo_apb_cmn_0), 
    .versa_xmp_1_o_ascan_pma3_sdo_apb_cmn(o_ascan_pma3_sdo_apb_cmn_1), 
    .versa_xmp_0_o_ascan_pma3_sdo_cmnplla(o_ascan_pma3_sdo_cmnplla_0), 
    .versa_xmp_1_o_ascan_pma3_sdo_cmnplla(o_ascan_pma3_sdo_cmnplla_1), 
    .versa_xmp_0_o_ascan_pma3_sdo_cmnpllb(o_ascan_pma3_sdo_cmnpllb_0), 
    .versa_xmp_1_o_ascan_pma3_sdo_cmnpllb(o_ascan_pma3_sdo_cmnpllb_1), 
    .versa_xmp_0_o_ascan_pma3_sdo_ctrl_l0(o_ascan_pma3_sdo_ctrl_l0_0), 
    .versa_xmp_1_o_ascan_pma3_sdo_ctrl_l0(o_ascan_pma3_sdo_ctrl_l0_1), 
    .versa_xmp_0_o_ascan_pma3_sdo_memarray_word_l0(o_ascan_pma3_sdo_memarray_word_l0_0), 
    .versa_xmp_1_o_ascan_pma3_sdo_memarray_word_l0(o_ascan_pma3_sdo_memarray_word_l0_1), 
    .versa_xmp_0_o_ascan_pma3_sdo_ref_channelcmn(o_ascan_pma3_sdo_ref_channelcmn_0), 
    .versa_xmp_1_o_ascan_pma3_sdo_ref_channelcmn(o_ascan_pma3_sdo_ref_channelcmn_1), 
    .versa_xmp_0_o_ascan_pma3_sdo_ref_channelleft_l0(o_ascan_pma3_sdo_ref_channelleft_l0_0), 
    .versa_xmp_1_o_ascan_pma3_sdo_ref_channelleft_l0(o_ascan_pma3_sdo_ref_channelleft_l0_1), 
    .versa_xmp_0_o_ascan_pma3_sdo_ref_channelright_l0(o_ascan_pma3_sdo_ref_channelright_l0_0), 
    .versa_xmp_1_o_ascan_pma3_sdo_ref_channelright_l0(o_ascan_pma3_sdo_ref_channelright_l0_1), 
    .versa_xmp_0_o_ascan_pma3_sdo_ref_cmn(o_ascan_pma3_sdo_ref_cmn_0), 
    .versa_xmp_1_o_ascan_pma3_sdo_ref_cmn(o_ascan_pma3_sdo_ref_cmn_1), 
    .versa_xmp_0_o_ascan_pma3_sdo_ref_l0(o_ascan_pma3_sdo_ref_l0_0), 
    .versa_xmp_1_o_ascan_pma3_sdo_ref_l0(o_ascan_pma3_sdo_ref_l0_1), 
    .versa_xmp_0_o_ascan_pma3_sdo_ref_txffe_l0(o_ascan_pma3_sdo_ref_txffe_l0_0), 
    .versa_xmp_1_o_ascan_pma3_sdo_ref_txffe_l0(o_ascan_pma3_sdo_ref_txffe_l0_1), 
    .versa_xmp_0_o_ascan_pma3_sdo_txpll_l0(o_ascan_pma3_sdo_txpll_l0_0), 
    .versa_xmp_1_o_ascan_pma3_sdo_txpll_l0(o_ascan_pma3_sdo_txpll_l0_1), 
    .versa_xmp_0_o_ascan_pma3_sdo_word_l0(o_ascan_pma3_sdo_word_l0_0), 
    .versa_xmp_1_o_ascan_pma3_sdo_word_l0(o_ascan_pma3_sdo_word_l0_1), 
    .versa_xmp_0_o_ascan_pma3_sdo_word_txffe_l0(o_ascan_pma3_sdo_word_txffe_l0_0), 
    .versa_xmp_1_o_ascan_pma3_sdo_word_txffe_l0(o_ascan_pma3_sdo_word_txffe_l0_1), 
    .hlp_mac_rx_throttle_0_stop(hlp_mac0_tx_stop), 
    .hlp_mac_rx_throttle_1_stop(hlp_mac1_tx_stop), 
    .hlp_mac_rx_throttle_2_stop(hlp_mac2_tx_stop), 
    .hlp_mac_rx_throttle_3_stop(hlp_mac3_tx_stop), 
    .hlp_mac_rx_throttle_4_stop(hlp_mac4_tx_stop), 
    .hlp_mac_rx_throttle_5_stop(hlp_mac5_tx_stop), 
    .hlp_mac_rx_throttle_6_stop(hlp_mac6_tx_stop), 
    .hlp_mac_rx_throttle_7_stop(hlp_mac7_tx_stop), 
    .eth_rfhs_trim_fuse_in(eth_rfhs_trim_fuse_in), 
    .eth_hdspsr_trim_fuse_in(eth_hdspsr_trim_fuse_in), 
    .eth_hd2prf_trim_fuse_in(eth_hd2prf_trim_fuse_in), 
    .mac100_0_pfc_mode(physs_icq_port_0_pfc_mode), 
    .mac100_1_pfc_mode(physs_icq_port_1_pfc_mode), 
    .mac100_2_pfc_mode(physs_icq_port_2_pfc_mode), 
    .mac100_3_pfc_mode(physs_icq_port_3_pfc_mode), 
    .mac100_4_pfc_mode(physs_icq_port_4_pfc_mode), 
    .mac100_5_pfc_mode(physs_icq_port_5_pfc_mode), 
    .mac100_6_pfc_mode(physs_icq_port_6_pfc_mode), 
    .mac100_7_pfc_mode(physs_icq_port_7_pfc_mode), 
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
    .versa_xmp_0_o_scanio_pma0_dat_ref0_n_a(o_scanio_pma0_dat_ref0_n_a_0), 
    .versa_xmp_0_o_scanio_pma0_dat_ref0_p_a(o_scanio_pma0_dat_ref0_p_a_0), 
    .versa_xmp_0_o_scanio_pma0_dat_ref1_n_a(o_scanio_pma0_dat_ref1_n_a_0), 
    .versa_xmp_0_o_scanio_pma0_dat_ref1_p_a(o_scanio_pma0_dat_ref1_p_a_0), 
    .versa_xmp_0_o_scanio_pma0_dat_rx_n_l0_a(o_scanio_pma0_dat_rx_n_l0_a_0), 
    .versa_xmp_0_o_scanio_pma0_dat_rx_p_l0_a(o_scanio_pma0_dat_rx_p_l0_a_0), 
    .versa_xmp_0_o_scanio_pma1_dat_ref0_n_a(o_scanio_pma1_dat_ref0_n_a_0), 
    .versa_xmp_0_o_scanio_pma1_dat_ref0_p_a(o_scanio_pma1_dat_ref0_p_a_0), 
    .versa_xmp_0_o_scanio_pma1_dat_ref1_n_a(o_scanio_pma1_dat_ref1_n_a_0), 
    .versa_xmp_0_o_scanio_pma1_dat_ref1_p_a(o_scanio_pma1_dat_ref1_p_a_0), 
    .versa_xmp_0_o_scanio_pma1_dat_rx_n_l0_a(o_scanio_pma1_dat_rx_n_l0_a_0), 
    .versa_xmp_0_o_scanio_pma1_dat_rx_p_l0_a(o_scanio_pma1_dat_rx_p_l0_a_0), 
    .versa_xmp_0_o_scanio_pma2_dat_ref0_n_a(o_scanio_pma2_dat_ref0_n_a_0), 
    .versa_xmp_0_o_scanio_pma2_dat_ref0_p_a(o_scanio_pma2_dat_ref0_p_a_0), 
    .versa_xmp_0_o_scanio_pma2_dat_ref1_n_a(o_scanio_pma2_dat_ref1_n_a_0), 
    .versa_xmp_0_o_scanio_pma2_dat_ref1_p_a(o_scanio_pma2_dat_ref1_p_a_0), 
    .versa_xmp_0_o_scanio_pma2_dat_rx_n_l0_a(o_scanio_pma2_dat_rx_n_l0_a_0), 
    .versa_xmp_0_o_scanio_pma2_dat_rx_p_l0_a(o_scanio_pma2_dat_rx_p_l0_a_0), 
    .versa_xmp_0_o_scanio_pma3_dat_ref0_n_a(o_scanio_pma3_dat_ref0_n_a_0), 
    .versa_xmp_0_o_scanio_pma3_dat_ref0_p_a(o_scanio_pma3_dat_ref0_p_a_0), 
    .versa_xmp_0_o_scanio_pma3_dat_ref1_n_a(o_scanio_pma3_dat_ref1_n_a_0), 
    .versa_xmp_0_o_scanio_pma3_dat_ref1_p_a(o_scanio_pma3_dat_ref1_p_a_0), 
    .versa_xmp_0_o_scanio_pma3_dat_rx_n_l0_a(o_scanio_pma3_dat_rx_n_l0_a_0), 
    .versa_xmp_0_o_scanio_pma3_dat_rx_p_l0_a(o_scanio_pma3_dat_rx_p_l0_a_0), 
    .versa_xmp_1_o_scanio_pma0_dat_ref0_n_a(o_scanio_pma0_dat_ref0_n_a_1), 
    .versa_xmp_1_o_scanio_pma0_dat_ref0_p_a(o_scanio_pma0_dat_ref0_p_a_1), 
    .versa_xmp_1_o_scanio_pma0_dat_ref1_n_a(o_scanio_pma0_dat_ref1_n_a_1), 
    .versa_xmp_1_o_scanio_pma0_dat_ref1_p_a(o_scanio_pma0_dat_ref1_p_a_1), 
    .versa_xmp_1_o_scanio_pma0_dat_rx_n_l0_a(o_scanio_pma0_dat_rx_n_l0_a_1), 
    .versa_xmp_1_o_scanio_pma0_dat_rx_p_l0_a(o_scanio_pma0_dat_rx_p_l0_a_1), 
    .versa_xmp_1_o_scanio_pma1_dat_ref0_n_a(o_scanio_pma1_dat_ref0_n_a_1), 
    .versa_xmp_1_o_scanio_pma1_dat_ref0_p_a(o_scanio_pma1_dat_ref0_p_a_1), 
    .versa_xmp_1_o_scanio_pma1_dat_ref1_n_a(o_scanio_pma1_dat_ref1_n_a_1), 
    .versa_xmp_1_o_scanio_pma1_dat_ref1_p_a(o_scanio_pma1_dat_ref1_p_a_1), 
    .versa_xmp_1_o_scanio_pma1_dat_rx_n_l0_a(o_scanio_pma1_dat_rx_n_l0_a_1), 
    .versa_xmp_1_o_scanio_pma1_dat_rx_p_l0_a(o_scanio_pma1_dat_rx_p_l0_a_1), 
    .versa_xmp_1_o_scanio_pma2_dat_ref0_n_a(o_scanio_pma2_dat_ref0_n_a_1), 
    .versa_xmp_1_o_scanio_pma2_dat_ref0_p_a(o_scanio_pma2_dat_ref0_p_a_1), 
    .versa_xmp_1_o_scanio_pma2_dat_ref1_n_a(o_scanio_pma2_dat_ref1_n_a_1), 
    .versa_xmp_1_o_scanio_pma2_dat_ref1_p_a(o_scanio_pma2_dat_ref1_p_a_1), 
    .versa_xmp_1_o_scanio_pma2_dat_rx_n_l0_a(o_scanio_pma2_dat_rx_n_l0_a_1), 
    .versa_xmp_1_o_scanio_pma2_dat_rx_p_l0_a(o_scanio_pma2_dat_rx_p_l0_a_1), 
    .versa_xmp_1_o_scanio_pma3_dat_ref0_n_a(o_scanio_pma3_dat_ref0_n_a_1), 
    .versa_xmp_1_o_scanio_pma3_dat_ref0_p_a(o_scanio_pma3_dat_ref0_p_a_1), 
    .versa_xmp_1_o_scanio_pma3_dat_ref1_n_a(o_scanio_pma3_dat_ref1_n_a_1), 
    .versa_xmp_1_o_scanio_pma3_dat_ref1_p_a(o_scanio_pma3_dat_ref1_p_a_1), 
    .versa_xmp_1_o_scanio_pma3_dat_rx_n_l0_a(o_scanio_pma3_dat_rx_n_l0_a_1), 
    .versa_xmp_1_o_scanio_pma3_dat_rx_p_l0_a(o_scanio_pma3_dat_rx_p_l0_a_1), 
    .i_pma0_jtag_id_nt(i_pma0_jtag_id_nt), 
    .i_pma0_jtag_slvid_nt(i_pma0_jtag_slvid_nt), 
    .i_pma0_jtag_tms(i_pma0_jtag_tms), 
    .i_pma0_jtag_tdi(i_pma0_jtag_tdi), 
    .versa_xmp_0_o_pma0_jtag_tdo_en(o_pma0_jtag_tdo_en), 
    .versa_xmp_0_o_pma0_jtag_tdo(o_pma0_jtag_tdo), 
    .i_pma1_jtag_id_nt(i_pma1_jtag_id_nt), 
    .i_pma1_jtag_slvid_nt(i_pma1_jtag_slvid_nt), 
    .i_pma1_jtag_tms(i_pma1_jtag_tms), 
    .i_pma1_jtag_tdi(i_pma1_jtag_tdi), 
    .versa_xmp_0_o_pma1_jtag_tdo_en(o_pma1_jtag_tdo_en), 
    .versa_xmp_0_o_pma1_jtag_tdo(o_pma1_jtag_tdo), 
    .i_pma2_jtag_id_nt(i_pma2_jtag_id_nt), 
    .i_pma2_jtag_slvid_nt(i_pma2_jtag_slvid_nt), 
    .i_pma2_jtag_tms(i_pma2_jtag_tms), 
    .i_pma2_jtag_tdi(i_pma2_jtag_tdi), 
    .versa_xmp_0_o_pma2_jtag_tdo_en(o_pma2_jtag_tdo_en), 
    .versa_xmp_0_o_pma2_jtag_tdo(o_pma2_jtag_tdo), 
    .i_pma3_jtag_id_nt(i_pma3_jtag_id_nt), 
    .i_pma3_jtag_slvid_nt(i_pma3_jtag_slvid_nt), 
    .i_pma3_jtag_tms(i_pma3_jtag_tms), 
    .i_pma3_jtag_tdi(i_pma3_jtag_tdi), 
    .versa_xmp_0_o_pma3_jtag_tdo_en(o_pma3_jtag_tdo_en), 
    .versa_xmp_0_o_pma3_jtag_tdo(o_pma3_jtag_tdo), 
    .i_pma4_jtag_id_nt(i_pma4_jtag_id_nt), 
    .i_pma4_jtag_slvid_nt(i_pma4_jtag_slvid_nt), 
    .i_pma4_jtag_tms(i_pma4_jtag_tms), 
    .i_pma4_jtag_tdi(i_pma4_jtag_tdi), 
    .versa_xmp_1_o_pma0_jtag_tdo_en(o_pma4_jtag_tdo_en), 
    .versa_xmp_1_o_pma0_jtag_tdo(o_pma4_jtag_tdo), 
    .i_pma5_jtag_id_nt(i_pma5_jtag_id_nt), 
    .i_pma5_jtag_slvid_nt(i_pma5_jtag_slvid_nt), 
    .i_pma5_jtag_tms(i_pma5_jtag_tms), 
    .i_pma5_jtag_tdi(i_pma5_jtag_tdi), 
    .versa_xmp_1_o_pma1_jtag_tdo_en(o_pma5_jtag_tdo_en), 
    .versa_xmp_1_o_pma1_jtag_tdo(o_pma5_jtag_tdo), 
    .i_pma6_jtag_id_nt(i_pma6_jtag_id_nt), 
    .i_pma6_jtag_slvid_nt(i_pma6_jtag_slvid_nt), 
    .i_pma6_jtag_tms(i_pma6_jtag_tms), 
    .i_pma6_jtag_tdi(i_pma6_jtag_tdi), 
    .versa_xmp_1_o_pma2_jtag_tdo_en(o_pma6_jtag_tdo_en), 
    .versa_xmp_1_o_pma2_jtag_tdo(o_pma6_jtag_tdo), 
    .i_pma7_jtag_id_nt(i_pma7_jtag_id_nt), 
    .i_pma7_jtag_slvid_nt(i_pma7_jtag_slvid_nt), 
    .i_pma7_jtag_tms(i_pma7_jtag_tms), 
    .i_pma7_jtag_tdi(i_pma7_jtag_tdi), 
    .versa_xmp_1_o_pma3_jtag_tdo_en(o_pma7_jtag_tdo_en), 
    .versa_xmp_1_o_pma3_jtag_tdo(o_pma7_jtag_tdo), 
    .versa_xmp_0_o_ucss_jtag_tdo_en(o_ucss_jtag_tdo_en_0), 
    .versa_xmp_0_o_ucss_jtag_tdo(o_ucss_jtag_tdo_0), 
    .versa_xmp_1_o_ucss_jtag_tdo_en(o_ucss_jtag_tdo_en_1), 
    .versa_xmp_1_o_ucss_jtag_tdo(o_ucss_jtag_tdo_1), 
    .versa_xmp_0_o_cpu_debug_tdo_en(o_cpu_debug_tdo_en_0), 
    .versa_xmp_0_o_cpu_debug_tdo(o_cpu_debug_tdo_0), 
    .versa_xmp_1_o_cpu_debug_tdo_en(o_cpu_debug_tdo_en_1), 
    .versa_xmp_1_o_cpu_debug_tdo(o_cpu_debug_tdo_1), 
    .i_ck_fscan_pma_apb_0(i_ck_fscan_pma_apb_0), 
    .i_ck_fscan_pma_apb_1(i_ck_fscan_pma_apb_1), 
    .versa_xmp_0_o_dfx_upm_pma0_so(o_dfx_upm_pma0_so_0), 
    .versa_xmp_0_o_dfx_upm_pma1_so(o_dfx_upm_pma1_so_0), 
    .versa_xmp_0_o_dfx_upm_pma2_so(o_dfx_upm_pma2_so_0), 
    .versa_xmp_0_o_dfx_upm_pma3_so(o_dfx_upm_pma3_so_0), 
    .versa_xmp_1_o_dfx_upm_pma0_so(o_dfx_upm_pma0_so_1), 
    .versa_xmp_1_o_dfx_upm_pma1_so(o_dfx_upm_pma1_so_1), 
    .versa_xmp_1_o_dfx_upm_pma2_so(o_dfx_upm_pma2_so_1), 
    .versa_xmp_1_o_dfx_upm_pma3_so(o_dfx_upm_pma3_so_1), 
    .i_rst_pma0_jtag_trst_b_a(i_rst_pma0_jtag_trst_b_a), 
    .i_rst_pma1_jtag_trst_b_a(i_rst_pma1_jtag_trst_b_a), 
    .i_rst_pma2_jtag_trst_b_a(i_rst_pma2_jtag_trst_b_a), 
    .i_rst_pma3_jtag_trst_b_a(i_rst_pma3_jtag_trst_b_a), 
    .i_rst_pma4_jtag_trst_b_a(i_rst_pma4_jtag_trst_b_a), 
    .i_rst_pma5_jtag_trst_b_a(i_rst_pma5_jtag_trst_b_a), 
    .i_rst_pma6_jtag_trst_b_a(i_rst_pma6_jtag_trst_b_a), 
    .i_rst_pma7_jtag_trst_b_a(i_rst_pma7_jtag_trst_b_a), 
    .ioa_ck_pma3_ref_right_mquad1_physs0(physs1_ioa_ck_pma0_ref_left_pquad0_physs1), 
    .quadpcs100_0_pcs_tsu_rx_sd_0(pcs_tsu_rx_sd[7:0]), 
    .quadpcs100_0_mii_rx_tsu_mux0_0(mii_rx_tsu_mux[1:0]), 
    .quadpcs100_0_mii_rx_tsu_mux1_0(mii_rx_tsu_mux[3:2]), 
    .quadpcs100_0_mii_rx_tsu_mux2_0(mii_rx_tsu_mux[5:4]), 
    .quadpcs100_0_mii_rx_tsu_mux3_0(mii_rx_tsu_mux[7:6]), 
    .quadpcs100_0_mii_tx_tsu_0(mii_tx_tsu[7:0]), 
    .quadpcs100_0_pcs_desk_buf_rlevel_0(pcs_desk_buf_rlevel[27:0]), 
    .quadpcs100_0_pcs_sd_bit_slip_0(pcs_sd_bit_slip[31:0]), 
    .quadpcs100_0_pcs_link_status_tsu_0(pcs_link_status_tsu[3:0]), 
    .quadpcs100_1_pcs_tsu_rx_sd_0(pcs_tsu_rx_sd[15:8]), 
    .quadpcs100_1_mii_rx_tsu_mux0_0(mii_rx_tsu_mux[9:8]), 
    .quadpcs100_1_mii_rx_tsu_mux1_0(mii_rx_tsu_mux[11:10]), 
    .quadpcs100_1_mii_rx_tsu_mux2_0(mii_rx_tsu_mux[13:12]), 
    .quadpcs100_1_mii_rx_tsu_mux3_0(mii_rx_tsu_mux[15:14]), 
    .quadpcs100_1_mii_tx_tsu_0(mii_tx_tsu[15:8]), 
    .quadpcs100_1_pcs_desk_buf_rlevel_0(pcs_desk_buf_rlevel[55:28]), 
    .quadpcs100_1_pcs_sd_bit_slip_0(pcs_sd_bit_slip[63:32]), 
    .quadpcs100_1_pcs_link_status_tsu_0(pcs_link_status_tsu[7:4]), 
    .versa_xmp_0_xioa_ck_pma0_ref0_n(xioa_ck_pma_ref0_n[0]), 
    .versa_xmp_0_xioa_ck_pma0_ref0_p(xioa_ck_pma_ref0_p[0]), 
    .versa_xmp_0_xioa_ck_pma0_ref1_n(xioa_ck_pma_ref1_n[0]), 
    .versa_xmp_0_xioa_ck_pma0_ref1_p(xioa_ck_pma_ref1_p[0]), 
    .versa_xmp_0_xioa_ck_pma1_ref0_n(xioa_ck_pma_ref0_n[1]), 
    .versa_xmp_0_xioa_ck_pma1_ref0_p(xioa_ck_pma_ref0_p[1]), 
    .versa_xmp_0_xioa_ck_pma1_ref1_n(xioa_ck_pma_ref1_n[1]), 
    .versa_xmp_0_xioa_ck_pma1_ref1_p(xioa_ck_pma_ref1_p[1]), 
    .versa_xmp_0_xioa_ck_pma2_ref0_n(xioa_ck_pma_ref0_n[2]), 
    .versa_xmp_0_xioa_ck_pma2_ref0_p(xioa_ck_pma_ref0_p[2]), 
    .versa_xmp_0_xioa_ck_pma2_ref1_n(xioa_ck_pma_ref1_n[2]), 
    .versa_xmp_0_xioa_ck_pma2_ref1_p(xioa_ck_pma_ref1_p[2]), 
    .versa_xmp_0_xioa_ck_pma3_ref0_n(xioa_ck_pma_ref0_n[3]), 
    .versa_xmp_0_xioa_ck_pma3_ref0_p(xioa_ck_pma_ref0_p[3]), 
    .versa_xmp_0_xioa_ck_pma3_ref1_n(xioa_ck_pma_ref1_n[3]), 
    .versa_xmp_0_xioa_ck_pma3_ref1_p(xioa_ck_pma_ref1_p[3]), 
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
    .versa_xmp_1_xioa_ck_pma0_ref1_n(xioa_ck_pma_ref1_n[4]), 
    .versa_xmp_1_xioa_ck_pma0_ref1_p(xioa_ck_pma_ref1_p[4]), 
    .versa_xmp_1_xioa_ck_pma1_ref0_n(xioa_ck_pma_ref0_n[5]), 
    .versa_xmp_1_xioa_ck_pma1_ref0_p(xioa_ck_pma_ref0_p[5]), 
    .versa_xmp_1_xioa_ck_pma1_ref1_n(xioa_ck_pma_ref1_n[5]), 
    .versa_xmp_1_xioa_ck_pma1_ref1_p(xioa_ck_pma_ref1_p[5]), 
    .versa_xmp_1_xioa_ck_pma2_ref0_n(xioa_ck_pma_ref0_n[6]), 
    .versa_xmp_1_xioa_ck_pma2_ref0_p(xioa_ck_pma_ref0_p[6]), 
    .versa_xmp_1_xioa_ck_pma2_ref1_n(xioa_ck_pma_ref1_n[6]), 
    .versa_xmp_1_xioa_ck_pma2_ref1_p(xioa_ck_pma_ref1_p[6]), 
    .versa_xmp_1_xioa_ck_pma3_ref0_n(xioa_ck_pma_ref0_n[7]), 
    .versa_xmp_1_xioa_ck_pma3_ref0_p(xioa_ck_pma_ref0_p[7]), 
    .versa_xmp_1_xioa_ck_pma3_ref1_n(xioa_ck_pma_ref1_n[7]), 
    .versa_xmp_1_xioa_ck_pma3_ref1_p(xioa_ck_pma_ref1_p[7]), 
    .versa_xmp_1_xoa_pma0_dcmon1(xoa_pma_dcmon1[4]), 
    .versa_xmp_1_xoa_pma0_dcmon2(xoa_pma_dcmon2[4]), 
    .versa_xmp_1_xoa_pma1_dcmon1(xoa_pma_dcmon1[5]), 
    .versa_xmp_1_xoa_pma1_dcmon2(xoa_pma_dcmon2[5]), 
    .versa_xmp_1_xoa_pma2_dcmon1(xoa_pma_dcmon1[6]), 
    .versa_xmp_1_xoa_pma2_dcmon2(xoa_pma_dcmon2[6]), 
    .versa_xmp_1_xoa_pma3_dcmon1(xoa_pma_dcmon1[7]), 
    .versa_xmp_1_xoa_pma3_dcmon2(xoa_pma_dcmon2[7]), 
    .nic_switch_mux_0_hlp_xlgmii0_txclk_ena(hlp_xlgmii0_txclk_ena_0), 
    .nic_switch_mux_0_hlp_xlgmii0_rxclk_ena(hlp_xlgmii0_rxclk_ena_0), 
    .nic_switch_mux_0_hlp_xlgmii0_rxc(hlp_xlgmii0_rxc_0), 
    .nic_switch_mux_0_hlp_xlgmii0_rxd(hlp_xlgmii0_rxd_0), 
    .nic_switch_mux_0_hlp_xlgmii0_rxt0_next(hlp_xlgmii0_rxt0_next_0), 
    .hlp_xlgmii0_txc_0(hlp_xlgmii0_txc_0), 
    .hlp_xlgmii0_txd_0(hlp_xlgmii0_txd_0), 
    .nic_switch_mux_0_hlp_xlgmii1_txclk_ena(hlp_xlgmii1_txclk_ena_0), 
    .nic_switch_mux_0_hlp_xlgmii1_rxclk_ena(hlp_xlgmii1_rxclk_ena_0), 
    .nic_switch_mux_0_hlp_xlgmii1_rxc(hlp_xlgmii1_rxc_0), 
    .nic_switch_mux_0_hlp_xlgmii1_rxd(hlp_xlgmii1_rxd_0), 
    .nic_switch_mux_0_hlp_xlgmii1_rxt0_next(hlp_xlgmii1_rxt0_next_0), 
    .hlp_xlgmii1_txc_0(hlp_xlgmii1_txc_0), 
    .hlp_xlgmii1_txd_0(hlp_xlgmii1_txd_0), 
    .nic_switch_mux_0_hlp_xlgmii2_txclk_ena(hlp_xlgmii2_txclk_ena_0), 
    .nic_switch_mux_0_hlp_xlgmii2_rxclk_ena(hlp_xlgmii2_rxclk_ena_0), 
    .nic_switch_mux_0_hlp_xlgmii2_rxc(hlp_xlgmii2_rxc_0), 
    .nic_switch_mux_0_hlp_xlgmii2_rxd(hlp_xlgmii2_rxd_0), 
    .nic_switch_mux_0_hlp_xlgmii2_rxt0_next(hlp_xlgmii2_rxt0_next_0), 
    .hlp_xlgmii2_txc_0(hlp_xlgmii2_txc_0), 
    .hlp_xlgmii2_txd_0(hlp_xlgmii2_txd_0), 
    .nic_switch_mux_0_hlp_xlgmii3_txclk_ena(hlp_xlgmii3_txclk_ena_0), 
    .nic_switch_mux_0_hlp_xlgmii3_rxclk_ena(hlp_xlgmii3_rxclk_ena_0), 
    .nic_switch_mux_0_hlp_xlgmii3_rxc(hlp_xlgmii3_rxc_0), 
    .nic_switch_mux_0_hlp_xlgmii3_rxd(hlp_xlgmii3_rxd_0), 
    .nic_switch_mux_0_hlp_xlgmii3_rxt0_next(hlp_xlgmii3_rxt0_next_0), 
    .hlp_xlgmii3_txc_0(hlp_xlgmii3_txc_0), 
    .hlp_xlgmii3_txd_0(hlp_xlgmii3_txd_0), 
    .nic_switch_mux_0_hlp_cgmii0_rxd(hlp_cgmii0_rxd_0), 
    .nic_switch_mux_0_hlp_cgmii0_rxc(hlp_cgmii0_rxc_0), 
    .nic_switch_mux_0_hlp_cgmii0_rxclk_ena(hlp_cgmii0_rxclk_ena_0), 
    .hlp_cgmii0_txd_0(hlp_cgmii0_txd_0), 
    .hlp_cgmii0_txc_0(hlp_cgmii0_txc_0), 
    .nic_switch_mux_0_hlp_cgmii0_txclk_ena(hlp_cgmii0_txclk_ena_0), 
    .nic_switch_mux_0_hlp_cgmii1_rxd(hlp_cgmii1_rxd_0), 
    .nic_switch_mux_0_hlp_cgmii1_rxc(hlp_cgmii1_rxc_0), 
    .nic_switch_mux_0_hlp_cgmii1_rxclk_ena(hlp_cgmii1_rxclk_ena_0), 
    .hlp_cgmii1_txd_0(hlp_cgmii1_txd_0), 
    .hlp_cgmii1_txc_0(hlp_cgmii1_txc_0), 
    .nic_switch_mux_0_hlp_cgmii1_txclk_ena(hlp_cgmii1_txclk_ena_0), 
    .nic_switch_mux_0_hlp_cgmii2_rxd(hlp_cgmii2_rxd_0), 
    .nic_switch_mux_0_hlp_cgmii2_rxc(hlp_cgmii2_rxc_0), 
    .nic_switch_mux_0_hlp_cgmii2_rxclk_ena(hlp_cgmii2_rxclk_ena_0), 
    .hlp_cgmii2_txd_0(hlp_cgmii2_txd_0), 
    .hlp_cgmii2_txc_0(hlp_cgmii2_txc_0), 
    .nic_switch_mux_0_hlp_cgmii2_txclk_ena(hlp_cgmii2_txclk_ena_0), 
    .nic_switch_mux_0_hlp_cgmii3_rxd(hlp_cgmii3_rxd_0), 
    .nic_switch_mux_0_hlp_cgmii3_rxc(hlp_cgmii3_rxc_0), 
    .nic_switch_mux_0_hlp_cgmii3_rxclk_ena(hlp_cgmii3_rxclk_ena_0), 
    .hlp_cgmii3_txd_0(hlp_cgmii3_txd_0), 
    .hlp_cgmii3_txc_0(hlp_cgmii3_txc_0), 
    .nic_switch_mux_0_hlp_cgmii3_txclk_ena(hlp_cgmii3_txclk_ena_0), 
    .hlp_xlgmii0_txclk_ena_nss_0(hlp_xlgmii0_txclk_ena_nss_0), 
    .hlp_xlgmii0_rxclk_ena_nss_0(hlp_xlgmii0_rxclk_ena_nss_0), 
    .hlp_xlgmii0_rxc_nss_0(hlp_xlgmii0_rxc_nss_0), 
    .hlp_xlgmii0_rxd_nss_0(hlp_xlgmii0_rxd_nss_0), 
    .hlp_xlgmii0_rxt0_next_nss_0(hlp_xlgmii0_rxt0_next_nss_0), 
    .nic_switch_mux_0_hlp_xlgmii0_txc_nss(hlp_xlgmii0_txc_nss_0), 
    .nic_switch_mux_0_hlp_xlgmii0_txd_nss(hlp_xlgmii0_txd_nss_0), 
    .hlp_xlgmii1_txclk_ena_nss_0(hlp_xlgmii1_txclk_ena_nss_0), 
    .hlp_xlgmii1_rxclk_ena_nss_0(hlp_xlgmii1_rxclk_ena_nss_0), 
    .hlp_xlgmii1_rxc_nss_0(hlp_xlgmii1_rxc_nss_0), 
    .hlp_xlgmii1_rxd_nss_0(hlp_xlgmii1_rxd_nss_0), 
    .hlp_xlgmii1_rxt0_next_nss_0(hlp_xlgmii1_rxt0_next_nss_0), 
    .nic_switch_mux_0_hlp_xlgmii1_txc_nss(hlp_xlgmii1_txc_nss_0), 
    .nic_switch_mux_0_hlp_xlgmii1_txd_nss(hlp_xlgmii1_txd_nss_0), 
    .hlp_xlgmii2_txclk_ena_nss_0(hlp_xlgmii2_txclk_ena_nss_0), 
    .hlp_xlgmii2_rxclk_ena_nss_0(hlp_xlgmii2_rxclk_ena_nss_0), 
    .hlp_xlgmii2_rxc_nss_0(hlp_xlgmii2_rxc_nss_0), 
    .hlp_xlgmii2_rxd_nss_0(hlp_xlgmii2_rxd_nss_0), 
    .hlp_xlgmii2_rxt0_next_nss_0(hlp_xlgmii2_rxt0_next_nss_0), 
    .nic_switch_mux_0_hlp_xlgmii2_txc_nss(hlp_xlgmii2_txc_nss_0), 
    .nic_switch_mux_0_hlp_xlgmii2_txd_nss(hlp_xlgmii2_txd_nss_0), 
    .hlp_xlgmii3_txclk_ena_nss_0(hlp_xlgmii3_txclk_ena_nss_0), 
    .hlp_xlgmii3_rxclk_ena_nss_0(hlp_xlgmii3_rxclk_ena_nss_0), 
    .hlp_xlgmii3_rxc_nss_0(hlp_xlgmii3_rxc_nss_0), 
    .hlp_xlgmii3_rxd_nss_0(hlp_xlgmii3_rxd_nss_0), 
    .hlp_xlgmii3_rxt0_next_nss_0(hlp_xlgmii3_rxt0_next_nss_0), 
    .nic_switch_mux_0_hlp_xlgmii3_txc_nss(hlp_xlgmii3_txc_nss_0), 
    .nic_switch_mux_0_hlp_xlgmii3_txd_nss(hlp_xlgmii3_txd_nss_0), 
    .hlp_cgmii0_rxd_nss_0(hlp_cgmii0_rxd_nss_0), 
    .hlp_cgmii0_rxc_nss_0(hlp_cgmii0_rxc_nss_0), 
    .hlp_cgmii0_rxclk_ena_nss_0(hlp_cgmii0_rxclk_ena_nss_0), 
    .nic_switch_mux_0_hlp_cgmii0_txd_nss(hlp_cgmii0_txd_nss_0), 
    .nic_switch_mux_0_hlp_cgmii0_txc_nss(hlp_cgmii0_txc_nss_0), 
    .hlp_cgmii0_txclk_ena_nss_0(hlp_cgmii0_txclk_ena_nss_0), 
    .hlp_cgmii1_rxd_nss_0(hlp_cgmii1_rxd_nss_0), 
    .hlp_cgmii1_rxc_nss_0(hlp_cgmii1_rxc_nss_0), 
    .hlp_cgmii1_rxclk_ena_nss_0(hlp_cgmii1_rxclk_ena_nss_0), 
    .nic_switch_mux_0_hlp_cgmii1_txd_nss(hlp_cgmii1_txd_nss_0), 
    .nic_switch_mux_0_hlp_cgmii1_txc_nss(hlp_cgmii1_txc_nss_0), 
    .hlp_cgmii1_txclk_ena_nss_0(hlp_cgmii1_txclk_ena_nss_0), 
    .hlp_cgmii2_rxd_nss_0(hlp_cgmii2_rxd_nss_0), 
    .hlp_cgmii2_rxc_nss_0(hlp_cgmii2_rxc_nss_0), 
    .hlp_cgmii2_rxclk_ena_nss_0(hlp_cgmii2_rxclk_ena_nss_0), 
    .nic_switch_mux_0_hlp_cgmii2_txd_nss(hlp_cgmii2_txd_nss_0), 
    .nic_switch_mux_0_hlp_cgmii2_txc_nss(hlp_cgmii2_txc_nss_0), 
    .hlp_cgmii2_txclk_ena_nss_0(hlp_cgmii2_txclk_ena_nss_0), 
    .hlp_cgmii3_rxd_nss_0(hlp_cgmii3_rxd_nss_0), 
    .hlp_cgmii3_rxc_nss_0(hlp_cgmii3_rxc_nss_0), 
    .hlp_cgmii3_rxclk_ena_nss_0(hlp_cgmii3_rxclk_ena_nss_0), 
    .nic_switch_mux_0_hlp_cgmii3_txd_nss(hlp_cgmii3_txd_nss_0), 
    .nic_switch_mux_0_hlp_cgmii3_txc_nss(hlp_cgmii3_txc_nss_0), 
    .hlp_cgmii3_txclk_ena_nss_0(hlp_cgmii3_txclk_ena_nss_0), 
    .nic_switch_mux_1_hlp_xlgmii0_txclk_ena(hlp_xlgmii0_txclk_ena_1), 
    .nic_switch_mux_1_hlp_xlgmii0_rxclk_ena(hlp_xlgmii0_rxclk_ena_1), 
    .nic_switch_mux_1_hlp_xlgmii0_rxc(hlp_xlgmii0_rxc_1), 
    .nic_switch_mux_1_hlp_xlgmii0_rxd(hlp_xlgmii0_rxd_1), 
    .nic_switch_mux_1_hlp_xlgmii0_rxt0_next(hlp_xlgmii0_rxt0_next_1), 
    .hlp_xlgmii0_txc_1(hlp_xlgmii0_txc_1), 
    .hlp_xlgmii0_txd_1(hlp_xlgmii0_txd_1), 
    .nic_switch_mux_1_hlp_xlgmii1_txclk_ena(hlp_xlgmii1_txclk_ena_1), 
    .nic_switch_mux_1_hlp_xlgmii1_rxclk_ena(hlp_xlgmii1_rxclk_ena_1), 
    .nic_switch_mux_1_hlp_xlgmii1_rxc(hlp_xlgmii1_rxc_1), 
    .nic_switch_mux_1_hlp_xlgmii1_rxd(hlp_xlgmii1_rxd_1), 
    .nic_switch_mux_1_hlp_xlgmii1_rxt0_next(hlp_xlgmii1_rxt0_next_1), 
    .hlp_xlgmii1_txc_1(hlp_xlgmii1_txc_1), 
    .hlp_xlgmii1_txd_1(hlp_xlgmii1_txd_1), 
    .nic_switch_mux_1_hlp_xlgmii2_txclk_ena(hlp_xlgmii2_txclk_ena_1), 
    .nic_switch_mux_1_hlp_xlgmii2_rxclk_ena(hlp_xlgmii2_rxclk_ena_1), 
    .nic_switch_mux_1_hlp_xlgmii2_rxc(hlp_xlgmii2_rxc_1), 
    .nic_switch_mux_1_hlp_xlgmii2_rxd(hlp_xlgmii2_rxd_1), 
    .nic_switch_mux_1_hlp_xlgmii2_rxt0_next(hlp_xlgmii2_rxt0_next_1), 
    .hlp_xlgmii2_txc_1(hlp_xlgmii2_txc_1), 
    .hlp_xlgmii2_txd_1(hlp_xlgmii2_txd_1), 
    .nic_switch_mux_1_hlp_xlgmii3_txclk_ena(hlp_xlgmii3_txclk_ena_1), 
    .nic_switch_mux_1_hlp_xlgmii3_rxclk_ena(hlp_xlgmii3_rxclk_ena_1), 
    .nic_switch_mux_1_hlp_xlgmii3_rxc(hlp_xlgmii3_rxc_1), 
    .nic_switch_mux_1_hlp_xlgmii3_rxd(hlp_xlgmii3_rxd_1), 
    .nic_switch_mux_1_hlp_xlgmii3_rxt0_next(hlp_xlgmii3_rxt0_next_1), 
    .hlp_xlgmii3_txc_1(hlp_xlgmii3_txc_1), 
    .hlp_xlgmii3_txd_1(hlp_xlgmii3_txd_1), 
    .nic_switch_mux_1_hlp_cgmii0_rxd(hlp_cgmii0_rxd_1), 
    .nic_switch_mux_1_hlp_cgmii0_rxc(hlp_cgmii0_rxc_1), 
    .nic_switch_mux_1_hlp_cgmii0_rxclk_ena(hlp_cgmii0_rxclk_ena_1), 
    .hlp_cgmii0_txd_1(hlp_cgmii0_txd_1), 
    .hlp_cgmii0_txc_1(hlp_cgmii0_txc_1), 
    .nic_switch_mux_1_hlp_cgmii0_txclk_ena(hlp_cgmii0_txclk_ena_1), 
    .nic_switch_mux_1_hlp_cgmii1_rxd(hlp_cgmii1_rxd_1), 
    .nic_switch_mux_1_hlp_cgmii1_rxc(hlp_cgmii1_rxc_1), 
    .nic_switch_mux_1_hlp_cgmii1_rxclk_ena(hlp_cgmii1_rxclk_ena_1), 
    .hlp_cgmii1_txd_1(hlp_cgmii1_txd_1), 
    .hlp_cgmii1_txc_1(hlp_cgmii1_txc_1), 
    .nic_switch_mux_1_hlp_cgmii1_txclk_ena(hlp_cgmii1_txclk_ena_1), 
    .nic_switch_mux_1_hlp_cgmii2_rxd(hlp_cgmii2_rxd_1), 
    .nic_switch_mux_1_hlp_cgmii2_rxc(hlp_cgmii2_rxc_1), 
    .nic_switch_mux_1_hlp_cgmii2_rxclk_ena(hlp_cgmii2_rxclk_ena_1), 
    .hlp_cgmii2_txd_1(hlp_cgmii2_txd_1), 
    .hlp_cgmii2_txc_1(hlp_cgmii2_txc_1), 
    .nic_switch_mux_1_hlp_cgmii2_txclk_ena(hlp_cgmii2_txclk_ena_1), 
    .nic_switch_mux_1_hlp_cgmii3_rxd(hlp_cgmii3_rxd_1), 
    .nic_switch_mux_1_hlp_cgmii3_rxc(hlp_cgmii3_rxc_1), 
    .nic_switch_mux_1_hlp_cgmii3_rxclk_ena(hlp_cgmii3_rxclk_ena_1), 
    .hlp_cgmii3_txd_1(hlp_cgmii3_txd_1), 
    .hlp_cgmii3_txc_1(hlp_cgmii3_txc_1), 
    .nic_switch_mux_1_hlp_cgmii3_txclk_ena(hlp_cgmii3_txclk_ena_1), 
    .mse_physs_port_0_ts_capture_vld(mse_physs_port_0_ts_capture_vld), 
    .mse_physs_port_0_ts_capture_idx(mse_physs_port_0_ts_capture_idx), 
    .mse_physs_port_1_ts_capture_vld(mse_physs_port_1_ts_capture_vld), 
    .mse_physs_port_1_ts_capture_idx(mse_physs_port_1_ts_capture_idx), 
    .mse_physs_port_2_ts_capture_vld(mse_physs_port_2_ts_capture_vld), 
    .mse_physs_port_2_ts_capture_idx(mse_physs_port_2_ts_capture_idx), 
    .mse_physs_port_3_ts_capture_vld(mse_physs_port_3_ts_capture_vld), 
    .mse_physs_port_3_ts_capture_idx(mse_physs_port_3_ts_capture_idx), 
    .mse_physs_port_4_ts_capture_vld(mse_physs_port_4_ts_capture_vld), 
    .mse_physs_port_4_ts_capture_idx(mse_physs_port_4_ts_capture_idx), 
    .mse_physs_port_5_ts_capture_vld(mse_physs_port_5_ts_capture_vld), 
    .mse_physs_port_5_ts_capture_idx(mse_physs_port_5_ts_capture_idx), 
    .mse_physs_port_6_ts_capture_vld(mse_physs_port_6_ts_capture_vld), 
    .mse_physs_port_6_ts_capture_idx(mse_physs_port_6_ts_capture_idx), 
    .mse_physs_port_7_ts_capture_vld(mse_physs_port_7_ts_capture_vld), 
    .mse_physs_port_7_ts_capture_idx(mse_physs_port_7_ts_capture_idx), 
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
    .quad_interrupts_0_mac100_int(mac100_0_int), 
    .quad_interrupts_0_pcs100_int(pcs100_0_int), 
    .quad_interrupts_1_mac100_int(mac100_1_int), 
    .quad_interrupts_1_pcs100_int(pcs100_1_int), 
    .physs_timesync_sync_val(physs_timesync_sync_val), 
    .physs_timestamp_0_ts_int(physs_ts_int[0]), 
    .physs_timestamp_1_ts_int(physs_ts_int[1]), 
    .quadpcs100_0_pcs_desk_buf_rlevel_1(quadpcs100_0_pcs_desk_buf_rlevel_1), 
    .quadpcs100_0_pcs_desk_buf_rlevel_2(quadpcs100_0_pcs_desk_buf_rlevel_2), 
    .quadpcs100_0_pcs_desk_buf_rlevel_3(quadpcs100_0_pcs_desk_buf_rlevel_3), 
    .quadpcs100_0_pcs_desk_buf_rlevel_4(quadpcs100_0_pcs_desk_buf_rlevel_4), 
    .quadpcs100_1_pcs_desk_buf_rlevel_1(quadpcs100_1_pcs_desk_buf_rlevel_1), 
    .quadpcs100_1_pcs_desk_buf_rlevel_2(quadpcs100_1_pcs_desk_buf_rlevel_2), 
    .quadpcs100_1_pcs_desk_buf_rlevel_3(quadpcs100_1_pcs_desk_buf_rlevel_3), 
    .quadpcs100_1_pcs_desk_buf_rlevel_4(quadpcs100_1_pcs_desk_buf_rlevel_4), 
    .ioa_ck_pma0_ref_left_mquad0_physs0()
) ; 
physs1 physs1 (
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
    .physs_func_rst_raw_n(physs_func_rst_raw_n), 
    .soc_per_clk_adop_parmisc_physs0_clkout_0(soc_per_clk_adop_parmisc_physs0_clkout_0), 
    .physs_func_clk_adop_parmisc_physs0_clkout(physs_func_clk_adop_parmisc_physs0_clkout), 
    .timeref_clk_adop_parmisc_physs0_clkout(timeref_clk_adop_parmisc_physs0_clkout), 
    .physs_clock_sync_2_physs_func_clk_gated_100(physs_clock_sync_2_physs_func_clk_gated_100), 
    .physs_clock_sync_3_physs_func_clk_gated_100(physs_clock_sync_3_physs_func_clk_gated_100), 
    .i_ck_cpu_debug_tck_2(i_ck_cpu_debug_tck_2), 
    .i_ck_cpu_debug_tck_3(i_ck_cpu_debug_tck_3), 
    .i_ck_dfx_upm_pma0_clk_debug_2(i_ck_dfx_upm_pma0_clk_debug_2), 
    .i_ck_dfx_upm_pma0_clk_debug_3(i_ck_dfx_upm_pma0_clk_debug_3), 
    .i_ck_dfx_upm_pma0_tck_2(i_ck_dfx_upm_pma0_tck_2), 
    .i_ck_dfx_upm_pma0_tck_3(i_ck_dfx_upm_pma0_tck_3), 
    .i_ck_dfx_upm_pma1_clk_debug_2(i_ck_dfx_upm_pma1_clk_debug_2), 
    .i_ck_dfx_upm_pma1_clk_debug_3(i_ck_dfx_upm_pma1_clk_debug_3), 
    .i_ck_dfx_upm_pma1_tck_2(i_ck_dfx_upm_pma1_tck_2), 
    .i_ck_dfx_upm_pma1_tck_3(i_ck_dfx_upm_pma1_tck_3), 
    .i_ck_dfx_upm_pma2_clk_debug_2(i_ck_dfx_upm_pma2_clk_debug_2), 
    .i_ck_dfx_upm_pma2_clk_debug_3(i_ck_dfx_upm_pma2_clk_debug_3), 
    .i_ck_dfx_upm_pma2_tck_2(i_ck_dfx_upm_pma2_tck_2), 
    .i_ck_dfx_upm_pma2_tck_3(i_ck_dfx_upm_pma2_tck_3), 
    .i_ck_dfx_upm_pma3_clk_debug_2(i_ck_dfx_upm_pma3_clk_debug_2), 
    .i_ck_dfx_upm_pma3_clk_debug_3(i_ck_dfx_upm_pma3_clk_debug_3), 
    .i_ck_dfx_upm_pma3_tck_2(i_ck_dfx_upm_pma3_tck_2), 
    .i_ck_dfx_upm_pma3_tck_3(i_ck_dfx_upm_pma3_tck_3), 
    .i_ck_fbscan_tck_2(i_ck_fbscan_tck_2), 
    .i_ck_fbscan_tck_3(i_ck_fbscan_tck_3), 
    .i_ck_fbscan_updatedr_2(i_ck_fbscan_updatedr_2), 
    .i_ck_fbscan_updatedr_3(i_ck_fbscan_updatedr_3), 
    .i_ck_fscan_pma_cmnpll_postdiv_2(i_ck_fscan_pma_cmnpll_postdiv_2), 
    .i_ck_fscan_pma_cmnpll_postdiv_3(i_ck_fscan_pma_cmnpll_postdiv_3), 
    .i_ck_fscan_pma_postclk_refclk_clk_cmnpll_2(i_ck_fscan_pma_postclk_refclk_clk_cmnpll_2), 
    .i_ck_fscan_pma_postclk_refclk_clk_cmnpll_3(i_ck_fscan_pma_postclk_refclk_clk_cmnpll_3), 
    .i_ck_fscan_pma_postclk_refclk_clk_txpll_2(i_ck_fscan_pma_postclk_refclk_clk_txpll_2), 
    .i_ck_fscan_pma_postclk_refclk_clk_txpll_3(i_ck_fscan_pma_postclk_refclk_clk_txpll_3), 
    .i_ck_fscan_pma_ref_2(i_ck_fscan_pma_ref_2), 
    .i_ck_fscan_pma_ref_3(i_ck_fscan_pma_ref_3), 
    .i_ck_fscan_ucss_postclk_2(i_ck_fscan_ucss_postclk_2), 
    .i_ck_fscan_ucss_postclk_3(i_ck_fscan_ucss_postclk_3), 
    .i_ck_pma8_jtag_tck(i_ck_pma8_jtag_tck), 
    .i_ck_pma9_jtag_tck(i_ck_pma9_jtag_tck), 
    .i_ck_pma10_jtag_tck(i_ck_pma10_jtag_tck), 
    .i_ck_pma11_jtag_tck(i_ck_pma11_jtag_tck), 
    .i_ck_pma12_jtag_tck(i_ck_pma12_jtag_tck), 
    .i_ck_pma13_jtag_tck(i_ck_pma13_jtag_tck), 
    .i_ck_pma14_jtag_tck(i_ck_pma14_jtag_tck), 
    .i_ck_pma15_jtag_tck(i_ck_pma15_jtag_tck), 
    .i_ck_ucss_jtag_tck_2(i_ck_ucss_jtag_tck_2), 
    .i_ck_ucss_jtag_tck_3(i_ck_ucss_jtag_tck_3), 
    .i_cpu_debug_prid_nt_2(i_cpu_debug_prid_nt_2), 
    .i_cpu_debug_prid_nt_3(i_cpu_debug_prid_nt_3), 
    .i_cpu_debug_tdi_2(i_cpu_debug_tdi_2), 
    .i_cpu_debug_tdi_3(i_cpu_debug_tdi_3), 
    .i_cpu_debug_tms_2(i_cpu_debug_tms_2), 
    .i_cpu_debug_tms_3(i_cpu_debug_tms_3), 
    .i_dfx_pma8_secure_tap_green(i_dfx_pma8_secure_tap_green), 
    .i_dfx_pma8_secure_tap_orange(i_dfx_pma8_secure_tap_orange), 
    .i_dfx_pma8_secure_tap_red(i_dfx_pma8_secure_tap_red), 
    .i_dfx_pma9_secure_tap_green(i_dfx_pma9_secure_tap_green), 
    .i_dfx_pma9_secure_tap_orange(i_dfx_pma9_secure_tap_orange), 
    .i_dfx_pma9_secure_tap_red(i_dfx_pma9_secure_tap_red), 
    .i_dfx_pma10_secure_tap_green(i_dfx_pma10_secure_tap_green), 
    .i_dfx_pma10_secure_tap_orange(i_dfx_pma10_secure_tap_orange), 
    .i_dfx_pma10_secure_tap_red(i_dfx_pma10_secure_tap_red), 
    .i_dfx_pma11_secure_tap_green(i_dfx_pma11_secure_tap_green), 
    .i_dfx_pma11_secure_tap_orange(i_dfx_pma11_secure_tap_orange), 
    .i_dfx_pma11_secure_tap_red(i_dfx_pma11_secure_tap_red), 
    .i_dfx_pma12_secure_tap_green(i_dfx_pma12_secure_tap_green), 
    .i_dfx_pma12_secure_tap_orange(i_dfx_pma12_secure_tap_orange), 
    .i_dfx_pma12_secure_tap_red(i_dfx_pma12_secure_tap_red), 
    .i_dfx_pma13_secure_tap_green(i_dfx_pma13_secure_tap_green), 
    .i_dfx_pma13_secure_tap_orange(i_dfx_pma13_secure_tap_orange), 
    .i_dfx_pma13_secure_tap_red(i_dfx_pma13_secure_tap_red), 
    .i_dfx_pma14_secure_tap_green(i_dfx_pma14_secure_tap_green), 
    .i_dfx_pma14_secure_tap_orange(i_dfx_pma14_secure_tap_orange), 
    .i_dfx_pma14_secure_tap_red(i_dfx_pma14_secure_tap_red), 
    .i_dfx_pma15_secure_tap_green(i_dfx_pma15_secure_tap_green), 
    .i_dfx_pma15_secure_tap_orange(i_dfx_pma15_secure_tap_orange), 
    .i_dfx_pma15_secure_tap_red(i_dfx_pma15_secure_tap_red), 
    .i_dfx_ucss_secure_tap_green_2(i_dfx_ucss_secure_tap_green_2), 
    .i_dfx_ucss_secure_tap_green_3(i_dfx_ucss_secure_tap_green_3), 
    .i_dfx_ucss_secure_tap_orange_2(i_dfx_ucss_secure_tap_orange_2), 
    .i_dfx_ucss_secure_tap_orange_3(i_dfx_ucss_secure_tap_orange_3), 
    .i_dfx_ucss_secure_tap_red_2(i_dfx_ucss_secure_tap_red_2), 
    .i_dfx_ucss_secure_tap_red_3(i_dfx_ucss_secure_tap_red_3), 
    .i_dfx_upm_pma0_capture_2(i_dfx_upm_pma0_capture_2), 
    .i_dfx_upm_pma0_capture_3(i_dfx_upm_pma0_capture_3), 
    .i_dfx_upm_pma0_fdfx_powergood_2(i_dfx_upm_pma0_fdfx_powergood_2), 
    .i_dfx_upm_pma0_fdfx_powergood_3(i_dfx_upm_pma0_fdfx_powergood_3), 
    .i_dfx_upm_pma0_iso_b_2(i_dfx_upm_pma0_iso_b_2), 
    .i_dfx_upm_pma0_iso_b_3(i_dfx_upm_pma0_iso_b_3), 
    .i_dfx_upm_pma0_secure_2(i_dfx_upm_pma0_secure_2), 
    .i_dfx_upm_pma0_secure_3(i_dfx_upm_pma0_secure_3), 
    .i_dfx_upm_pma0_sel_2(i_dfx_upm_pma0_sel_2), 
    .i_dfx_upm_pma0_sel_3(i_dfx_upm_pma0_sel_3), 
    .i_dfx_upm_pma0_shift_2(i_dfx_upm_pma0_shift_2), 
    .i_dfx_upm_pma0_shift_3(i_dfx_upm_pma0_shift_3), 
    .i_dfx_upm_pma0_si_2(i_dfx_upm_pma0_si_2), 
    .i_dfx_upm_pma0_si_3(i_dfx_upm_pma0_si_3), 
    .i_dfx_upm_pma0_update_2(i_dfx_upm_pma0_update_2), 
    .i_dfx_upm_pma0_update_3(i_dfx_upm_pma0_update_3), 
    .i_dfx_upm_pma1_capture_2(i_dfx_upm_pma1_capture_2), 
    .i_dfx_upm_pma1_capture_3(i_dfx_upm_pma1_capture_3), 
    .i_dfx_upm_pma1_fdfx_powergood_2(i_dfx_upm_pma1_fdfx_powergood_2), 
    .i_dfx_upm_pma1_fdfx_powergood_3(i_dfx_upm_pma1_fdfx_powergood_3), 
    .i_dfx_upm_pma1_iso_b_2(i_dfx_upm_pma1_iso_b_2), 
    .i_dfx_upm_pma1_iso_b_3(i_dfx_upm_pma1_iso_b_3), 
    .i_dfx_upm_pma1_secure_2(i_dfx_upm_pma1_secure_2), 
    .i_dfx_upm_pma1_secure_3(i_dfx_upm_pma1_secure_3), 
    .i_dfx_upm_pma1_sel_2(i_dfx_upm_pma1_sel_2), 
    .i_dfx_upm_pma1_sel_3(i_dfx_upm_pma1_sel_3), 
    .i_dfx_upm_pma1_shift_2(i_dfx_upm_pma1_shift_2), 
    .i_dfx_upm_pma1_shift_3(i_dfx_upm_pma1_shift_3), 
    .i_dfx_upm_pma1_si_2(i_dfx_upm_pma1_si_2), 
    .i_dfx_upm_pma1_si_3(i_dfx_upm_pma1_si_3), 
    .i_dfx_upm_pma1_update_2(i_dfx_upm_pma1_update_2), 
    .i_dfx_upm_pma1_update_3(i_dfx_upm_pma1_update_3), 
    .i_dfx_upm_pma2_capture_2(i_dfx_upm_pma2_capture_2), 
    .i_dfx_upm_pma2_capture_3(i_dfx_upm_pma2_capture_3), 
    .i_dfx_upm_pma2_fdfx_powergood_2(i_dfx_upm_pma2_fdfx_powergood_2), 
    .i_dfx_upm_pma2_fdfx_powergood_3(i_dfx_upm_pma2_fdfx_powergood_3), 
    .i_dfx_upm_pma2_iso_b_2(i_dfx_upm_pma2_iso_b_2), 
    .i_dfx_upm_pma2_iso_b_3(i_dfx_upm_pma2_iso_b_3), 
    .i_dfx_upm_pma2_secure_2(i_dfx_upm_pma2_secure_2), 
    .i_dfx_upm_pma2_secure_3(i_dfx_upm_pma2_secure_3), 
    .i_dfx_upm_pma2_sel_2(i_dfx_upm_pma2_sel_2), 
    .i_dfx_upm_pma2_sel_3(i_dfx_upm_pma2_sel_3), 
    .i_dfx_upm_pma2_shift_2(i_dfx_upm_pma2_shift_2), 
    .i_dfx_upm_pma2_shift_3(i_dfx_upm_pma2_shift_3), 
    .i_dfx_upm_pma2_si_2(i_dfx_upm_pma2_si_2), 
    .i_dfx_upm_pma2_si_3(i_dfx_upm_pma2_si_3), 
    .i_dfx_upm_pma2_update_2(i_dfx_upm_pma2_update_2), 
    .i_dfx_upm_pma2_update_3(i_dfx_upm_pma2_update_3), 
    .i_dfx_upm_pma3_capture_2(i_dfx_upm_pma3_capture_2), 
    .i_dfx_upm_pma3_capture_3(i_dfx_upm_pma3_capture_3), 
    .i_dfx_upm_pma3_fdfx_powergood_2(i_dfx_upm_pma3_fdfx_powergood_2), 
    .i_dfx_upm_pma3_fdfx_powergood_3(i_dfx_upm_pma3_fdfx_powergood_3), 
    .i_dfx_upm_pma3_iso_b_2(i_dfx_upm_pma3_iso_b_2), 
    .i_dfx_upm_pma3_iso_b_3(i_dfx_upm_pma3_iso_b_3), 
    .i_dfx_upm_pma3_secure_2(i_dfx_upm_pma3_secure_2), 
    .i_dfx_upm_pma3_secure_3(i_dfx_upm_pma3_secure_3), 
    .i_dfx_upm_pma3_sel_2(i_dfx_upm_pma3_sel_2), 
    .i_dfx_upm_pma3_sel_3(i_dfx_upm_pma3_sel_3), 
    .i_dfx_upm_pma3_shift_2(i_dfx_upm_pma3_shift_2), 
    .i_dfx_upm_pma3_shift_3(i_dfx_upm_pma3_shift_3), 
    .i_dfx_upm_pma3_si_2(i_dfx_upm_pma3_si_2), 
    .i_dfx_upm_pma3_si_3(i_dfx_upm_pma3_si_3), 
    .i_dfx_upm_pma3_update_2(i_dfx_upm_pma3_update_2), 
    .i_dfx_upm_pma3_update_3(i_dfx_upm_pma3_update_3), 
    .i_fbscan_capturedr_2(i_fbscan_capturedr_2), 
    .i_fbscan_capturedr_3(i_fbscan_capturedr_3), 
    .i_fbscan_chainen_2(i_fbscan_chainen_2), 
    .i_fbscan_chainen_3(i_fbscan_chainen_3), 
    .i_fbscan_d6actestsig_b_2(i_fbscan_d6actestsig_b_2), 
    .i_fbscan_d6actestsig_b_3(i_fbscan_d6actestsig_b_3), 
    .i_fbscan_d6init_2(i_fbscan_d6init_2), 
    .i_fbscan_d6init_3(i_fbscan_d6init_3), 
    .i_fbscan_d6select_2(i_fbscan_d6select_2), 
    .i_fbscan_d6select_3(i_fbscan_d6select_3), 
    .i_fbscan_extogen_2(i_fbscan_extogen_2), 
    .i_fbscan_extogen_3(i_fbscan_extogen_3), 
    .i_fbscan_extogsig_b_2(i_fbscan_extogsig_b_2), 
    .i_fbscan_extogsig_b_3(i_fbscan_extogsig_b_3), 
    .i_fbscan_highz_2(i_fbscan_highz_2), 
    .i_fbscan_highz_3(i_fbscan_highz_3), 
    .i_fbscan_mode_2(i_fbscan_mode_2), 
    .i_fbscan_mode_3(i_fbscan_mode_3), 
    .i_fbscan_shiftdr_2(i_fbscan_shiftdr_2), 
    .i_fbscan_shiftdr_3(i_fbscan_shiftdr_3), 
    .i_fbscan_tdi_2(i_fbscan_tdi_2), 
    .i_fbscan_tdi_3(i_fbscan_tdi_3), 
    .i_fdfx_powergood(i_fdfx_powergood), 
    .i_fscan_chain_bypass_nt_2(i_fscan_chain_bypass_nt_2), 
    .i_fscan_chain_bypass_nt_3(i_fscan_chain_bypass_nt_3), 
    .i_fscan_clkgenctrl_nt_2(i_fscan_clkgenctrl_nt_2), 
    .i_fscan_clkgenctrl_nt_3(i_fscan_clkgenctrl_nt_3), 
    .i_fscan_clkgenctrlen_nt_2(i_fscan_clkgenctrlen_nt_2), 
    .i_fscan_clkgenctrlen_nt_3(i_fscan_clkgenctrlen_nt_3), 
    .i_fscan_clkungate_nt_2(i_fscan_clkungate_nt_2), 
    .i_fscan_clkungate_nt_3(i_fscan_clkungate_nt_3), 
    .i_fscan_clkungate_syn_nt_2(i_fscan_clkungate_syn_nt_2), 
    .i_fscan_clkungate_syn_nt_3(i_fscan_clkungate_syn_nt_3), 
    .i_fscan_latch_bypass_in_nt_2(i_fscan_latch_bypass_in_nt_2), 
    .i_fscan_latch_bypass_in_nt_3(i_fscan_latch_bypass_in_nt_3), 
    .i_fscan_latch_bypass_out_nt_2(i_fscan_latch_bypass_out_nt_2), 
    .i_fscan_latch_bypass_out_nt_3(i_fscan_latch_bypass_out_nt_3), 
    .i_fscan_latchclosed_b_nt_2(i_fscan_latchclosed_b_nt_2), 
    .i_fscan_latchclosed_b_nt_3(i_fscan_latchclosed_b_nt_3), 
    .i_fscan_latchopen_nt_2(i_fscan_latchopen_nt_2), 
    .i_fscan_latchopen_nt_3(i_fscan_latchopen_nt_3), 
    .i_fscan_mode_atspeed_nt_2(i_fscan_mode_atspeed_nt_2), 
    .i_fscan_mode_atspeed_nt_3(i_fscan_mode_atspeed_nt_3), 
    .i_fscan_mode_nt_2(i_fscan_mode_nt_2), 
    .i_fscan_mode_nt_3(i_fscan_mode_nt_3), 
    .i_fscan_pll_isolate_nt_2(i_fscan_pll_isolate_nt_2), 
    .i_fscan_pll_isolate_nt_3(i_fscan_pll_isolate_nt_3), 
    .i_fscan_pll_scan_if_dis_nt_2(i_fscan_pll_scan_if_dis_nt_2), 
    .i_fscan_pll_scan_if_dis_nt_3(i_fscan_pll_scan_if_dis_nt_3), 
    .i_fscan_pma0_sdi_apb_cmn_2(i_fscan_pma0_sdi_apb_cmn_2), 
    .i_fscan_pma0_sdi_apb_cmn_3(i_fscan_pma0_sdi_apb_cmn_3), 
    .i_fscan_pma0_sdi_cmnplla_2(i_fscan_pma0_sdi_cmnplla_2), 
    .i_fscan_pma0_sdi_cmnplla_3(i_fscan_pma0_sdi_cmnplla_3), 
    .i_fscan_pma0_sdi_cmnpllb_2(i_fscan_pma0_sdi_cmnpllb_2), 
    .i_fscan_pma0_sdi_cmnpllb_3(i_fscan_pma0_sdi_cmnpllb_3), 
    .i_fscan_pma0_sdi_ctrl_l0_2(i_fscan_pma0_sdi_ctrl_l0_2), 
    .i_fscan_pma0_sdi_ctrl_l0_3(i_fscan_pma0_sdi_ctrl_l0_3), 
    .i_fscan_pma0_sdi_memarray_word_l0_2(i_fscan_pma0_sdi_memarray_word_l0_2), 
    .i_fscan_pma0_sdi_memarray_word_l0_3(i_fscan_pma0_sdi_memarray_word_l0_3), 
    .i_fscan_pma0_sdi_ref_channelcmn_2(i_fscan_pma0_sdi_ref_channelcmn_2), 
    .i_fscan_pma0_sdi_ref_channelcmn_3(i_fscan_pma0_sdi_ref_channelcmn_3), 
    .i_fscan_pma0_sdi_ref_channelleft_l0_2(i_fscan_pma0_sdi_ref_channelleft_l0_2), 
    .i_fscan_pma0_sdi_ref_channelleft_l0_3(i_fscan_pma0_sdi_ref_channelleft_l0_3), 
    .i_fscan_pma0_sdi_ref_channelright_l0_2(i_fscan_pma0_sdi_ref_channelright_l0_2), 
    .i_fscan_pma0_sdi_ref_channelright_l0_3(i_fscan_pma0_sdi_ref_channelright_l0_3), 
    .i_fscan_pma0_sdi_ref_cmn_2(i_fscan_pma0_sdi_ref_cmn_2), 
    .i_fscan_pma0_sdi_ref_cmn_3(i_fscan_pma0_sdi_ref_cmn_3), 
    .i_fscan_pma0_sdi_ref_l0_2(i_fscan_pma0_sdi_ref_l0_2), 
    .i_fscan_pma0_sdi_ref_l0_3(i_fscan_pma0_sdi_ref_l0_3), 
    .i_fscan_pma0_sdi_ref_txffe_l0_2(i_fscan_pma0_sdi_ref_txffe_l0_2), 
    .i_fscan_pma0_sdi_ref_txffe_l0_3(i_fscan_pma0_sdi_ref_txffe_l0_3), 
    .i_fscan_pma0_sdi_txpll_l0_2(i_fscan_pma0_sdi_txpll_l0_2), 
    .i_fscan_pma0_sdi_txpll_l0_3(i_fscan_pma0_sdi_txpll_l0_3), 
    .i_fscan_pma0_sdi_word_l0_2(i_fscan_pma0_sdi_word_l0_2), 
    .i_fscan_pma0_sdi_word_l0_3(i_fscan_pma0_sdi_word_l0_3), 
    .i_fscan_pma0_sdi_word_txffe_l0_2(i_fscan_pma0_sdi_word_txffe_l0_2), 
    .i_fscan_pma0_sdi_word_txffe_l0_3(i_fscan_pma0_sdi_word_txffe_l0_3), 
    .i_fscan_pma1_sdi_apb_cmn_2(i_fscan_pma1_sdi_apb_cmn_2), 
    .i_fscan_pma1_sdi_apb_cmn_3(i_fscan_pma1_sdi_apb_cmn_3), 
    .i_fscan_pma1_sdi_cmnplla_2(i_fscan_pma1_sdi_cmnplla_2), 
    .i_fscan_pma1_sdi_cmnplla_3(i_fscan_pma1_sdi_cmnplla_3), 
    .i_fscan_pma1_sdi_cmnpllb_2(i_fscan_pma1_sdi_cmnpllb_2), 
    .i_fscan_pma1_sdi_cmnpllb_3(i_fscan_pma1_sdi_cmnpllb_3), 
    .i_fscan_pma1_sdi_ctrl_l0_2(i_fscan_pma1_sdi_ctrl_l0_2), 
    .i_fscan_pma1_sdi_ctrl_l0_3(i_fscan_pma1_sdi_ctrl_l0_3), 
    .i_fscan_pma1_sdi_memarray_word_l0_2(i_fscan_pma1_sdi_memarray_word_l0_2), 
    .i_fscan_pma1_sdi_memarray_word_l0_3(i_fscan_pma1_sdi_memarray_word_l0_3), 
    .i_fscan_pma1_sdi_ref_channelcmn_2(i_fscan_pma1_sdi_ref_channelcmn_2), 
    .i_fscan_pma1_sdi_ref_channelcmn_3(i_fscan_pma1_sdi_ref_channelcmn_3), 
    .i_fscan_pma1_sdi_ref_channelleft_l0_2(i_fscan_pma1_sdi_ref_channelleft_l0_2), 
    .i_fscan_pma1_sdi_ref_channelleft_l0_3(i_fscan_pma1_sdi_ref_channelleft_l0_3), 
    .i_fscan_pma1_sdi_ref_channelright_l0_2(i_fscan_pma1_sdi_ref_channelright_l0_2), 
    .i_fscan_pma1_sdi_ref_channelright_l0_3(i_fscan_pma1_sdi_ref_channelright_l0_3), 
    .i_fscan_pma1_sdi_ref_cmn_2(i_fscan_pma1_sdi_ref_cmn_2), 
    .i_fscan_pma1_sdi_ref_cmn_3(i_fscan_pma1_sdi_ref_cmn_3), 
    .i_fscan_pma1_sdi_ref_l0_2(i_fscan_pma1_sdi_ref_l0_2), 
    .i_fscan_pma1_sdi_ref_l0_3(i_fscan_pma1_sdi_ref_l0_3), 
    .i_fscan_pma1_sdi_ref_txffe_l0_2(i_fscan_pma1_sdi_ref_txffe_l0_2), 
    .i_fscan_pma1_sdi_ref_txffe_l0_3(i_fscan_pma1_sdi_ref_txffe_l0_3), 
    .i_fscan_pma1_sdi_txpll_l0_2(i_fscan_pma1_sdi_txpll_l0_2), 
    .i_fscan_pma1_sdi_txpll_l0_3(i_fscan_pma1_sdi_txpll_l0_3), 
    .i_fscan_pma1_sdi_word_l0_2(i_fscan_pma1_sdi_word_l0_2), 
    .i_fscan_pma1_sdi_word_l0_3(i_fscan_pma1_sdi_word_l0_3), 
    .i_fscan_pma1_sdi_word_txffe_l0_2(i_fscan_pma1_sdi_word_txffe_l0_2), 
    .i_fscan_pma1_sdi_word_txffe_l0_3(i_fscan_pma1_sdi_word_txffe_l0_3), 
    .i_fscan_pma2_sdi_apb_cmn_2(i_fscan_pma2_sdi_apb_cmn_2), 
    .i_fscan_pma2_sdi_apb_cmn_3(i_fscan_pma2_sdi_apb_cmn_3), 
    .i_fscan_pma2_sdi_cmnplla_2(i_fscan_pma2_sdi_cmnplla_2), 
    .i_fscan_pma2_sdi_cmnplla_3(i_fscan_pma2_sdi_cmnplla_3), 
    .i_fscan_pma2_sdi_cmnpllb_2(i_fscan_pma2_sdi_cmnpllb_2), 
    .i_fscan_pma2_sdi_cmnpllb_3(i_fscan_pma2_sdi_cmnpllb_3), 
    .i_fscan_pma2_sdi_ctrl_l0_2(i_fscan_pma2_sdi_ctrl_l0_2), 
    .i_fscan_pma2_sdi_ctrl_l0_3(i_fscan_pma2_sdi_ctrl_l0_3), 
    .i_fscan_pma2_sdi_memarray_word_l0_2(i_fscan_pma2_sdi_memarray_word_l0_2), 
    .i_fscan_pma2_sdi_memarray_word_l0_3(i_fscan_pma2_sdi_memarray_word_l0_3), 
    .i_fscan_pma2_sdi_ref_channelcmn_2(i_fscan_pma2_sdi_ref_channelcmn_2), 
    .i_fscan_pma2_sdi_ref_channelcmn_3(i_fscan_pma2_sdi_ref_channelcmn_3), 
    .i_fscan_pma2_sdi_ref_channelleft_l0_2(i_fscan_pma2_sdi_ref_channelleft_l0_2), 
    .i_fscan_pma2_sdi_ref_channelleft_l0_3(i_fscan_pma2_sdi_ref_channelleft_l0_3), 
    .i_fscan_pma2_sdi_ref_channelright_l0_2(i_fscan_pma2_sdi_ref_channelright_l0_2), 
    .i_fscan_pma2_sdi_ref_channelright_l0_3(i_fscan_pma2_sdi_ref_channelright_l0_3), 
    .i_fscan_pma2_sdi_ref_cmn_2(i_fscan_pma2_sdi_ref_cmn_2), 
    .i_fscan_pma2_sdi_ref_cmn_3(i_fscan_pma2_sdi_ref_cmn_3), 
    .i_fscan_pma2_sdi_ref_l0_2(i_fscan_pma2_sdi_ref_l0_2), 
    .i_fscan_pma2_sdi_ref_l0_3(i_fscan_pma2_sdi_ref_l0_3), 
    .i_fscan_pma2_sdi_ref_txffe_l0_2(i_fscan_pma2_sdi_ref_txffe_l0_2), 
    .i_fscan_pma2_sdi_ref_txffe_l0_3(i_fscan_pma2_sdi_ref_txffe_l0_3), 
    .i_fscan_pma2_sdi_txpll_l0_2(i_fscan_pma2_sdi_txpll_l0_2), 
    .i_fscan_pma2_sdi_txpll_l0_3(i_fscan_pma2_sdi_txpll_l0_3), 
    .i_fscan_pma2_sdi_word_l0_2(i_fscan_pma2_sdi_word_l0_2), 
    .i_fscan_pma2_sdi_word_l0_3(i_fscan_pma2_sdi_word_l0_3), 
    .i_fscan_pma2_sdi_word_txffe_l0_2(i_fscan_pma2_sdi_word_txffe_l0_2), 
    .i_fscan_pma2_sdi_word_txffe_l0_3(i_fscan_pma2_sdi_word_txffe_l0_3), 
    .i_fscan_pma3_sdi_apb_cmn_2(i_fscan_pma3_sdi_apb_cmn_2), 
    .i_fscan_pma3_sdi_apb_cmn_3(i_fscan_pma3_sdi_apb_cmn_3), 
    .i_fscan_pma3_sdi_cmnplla_2(i_fscan_pma3_sdi_cmnplla_2), 
    .i_fscan_pma3_sdi_cmnplla_3(i_fscan_pma3_sdi_cmnplla_3), 
    .i_fscan_pma3_sdi_cmnpllb_2(i_fscan_pma3_sdi_cmnpllb_2), 
    .i_fscan_pma3_sdi_cmnpllb_3(i_fscan_pma3_sdi_cmnpllb_3), 
    .i_fscan_pma3_sdi_ctrl_l0_2(i_fscan_pma3_sdi_ctrl_l0_2), 
    .i_fscan_pma3_sdi_ctrl_l0_3(i_fscan_pma3_sdi_ctrl_l0_3), 
    .i_fscan_pma3_sdi_memarray_word_l0_2(i_fscan_pma3_sdi_memarray_word_l0_2), 
    .i_fscan_pma3_sdi_memarray_word_l0_3(i_fscan_pma3_sdi_memarray_word_l0_3), 
    .i_fscan_pma3_sdi_ref_channelcmn_2(i_fscan_pma3_sdi_ref_channelcmn_2), 
    .i_fscan_pma3_sdi_ref_channelcmn_3(i_fscan_pma3_sdi_ref_channelcmn_3), 
    .i_fscan_pma3_sdi_ref_channelleft_l0_2(i_fscan_pma3_sdi_ref_channelleft_l0_2), 
    .i_fscan_pma3_sdi_ref_channelleft_l0_3(i_fscan_pma3_sdi_ref_channelleft_l0_3), 
    .i_fscan_pma3_sdi_ref_channelright_l0_2(i_fscan_pma3_sdi_ref_channelright_l0_2), 
    .i_fscan_pma3_sdi_ref_channelright_l0_3(i_fscan_pma3_sdi_ref_channelright_l0_3), 
    .i_fscan_pma3_sdi_ref_cmn_2(i_fscan_pma3_sdi_ref_cmn_2), 
    .i_fscan_pma3_sdi_ref_cmn_3(i_fscan_pma3_sdi_ref_cmn_3), 
    .i_fscan_pma3_sdi_ref_l0_2(i_fscan_pma3_sdi_ref_l0_2), 
    .i_fscan_pma3_sdi_ref_l0_3(i_fscan_pma3_sdi_ref_l0_3), 
    .i_fscan_pma3_sdi_ref_txffe_l0_2(i_fscan_pma3_sdi_ref_txffe_l0_2), 
    .i_fscan_pma3_sdi_ref_txffe_l0_3(i_fscan_pma3_sdi_ref_txffe_l0_3), 
    .i_fscan_pma3_sdi_txpll_l0_2(i_fscan_pma3_sdi_txpll_l0_2), 
    .i_fscan_pma3_sdi_txpll_l0_3(i_fscan_pma3_sdi_txpll_l0_3), 
    .i_fscan_pma3_sdi_word_l0_2(i_fscan_pma3_sdi_word_l0_2), 
    .i_fscan_pma3_sdi_word_l0_3(i_fscan_pma3_sdi_word_l0_3), 
    .i_fscan_pma3_sdi_word_txffe_l0_2(i_fscan_pma3_sdi_word_txffe_l0_2), 
    .i_fscan_pma3_sdi_word_txffe_l0_3(i_fscan_pma3_sdi_word_txffe_l0_3), 
    .i_fscan_ret_control_nt_2(i_fscan_ret_control_nt_2), 
    .i_fscan_ret_control_nt_3(i_fscan_ret_control_nt_3), 
    .i_fscan_rstbypen_nt_2(i_fscan_rstbypen_nt_2), 
    .i_fscan_rstbypen_nt_3(i_fscan_rstbypen_nt_3), 
    .i_fscan_shiften_nt_2(i_fscan_shiften_nt_2), 
    .i_fscan_shiften_nt_3(i_fscan_shiften_nt_3), 
    .i_fscan_slos_en_nt_2(i_fscan_slos_en_nt_2), 
    .i_fscan_slos_en_nt_3(i_fscan_slos_en_nt_3), 
    .i_rst_cpu_debug_trst_b_a_2(i_rst_cpu_debug_trst_b_a_2), 
    .i_rst_cpu_debug_trst_b_a_3(i_rst_cpu_debug_trst_b_a_3), 
    .i_rst_dfx_upm_pma0_trst_b_2(i_rst_dfx_upm_pma0_trst_b_2), 
    .i_rst_dfx_upm_pma0_trst_b_3(i_rst_dfx_upm_pma0_trst_b_3), 
    .i_rst_dfx_upm_pma1_trst_b_2(i_rst_dfx_upm_pma1_trst_b_2), 
    .i_rst_dfx_upm_pma1_trst_b_3(i_rst_dfx_upm_pma1_trst_b_3), 
    .i_rst_dfx_upm_pma2_trst_b_2(i_rst_dfx_upm_pma2_trst_b_2), 
    .i_rst_dfx_upm_pma2_trst_b_3(i_rst_dfx_upm_pma2_trst_b_3), 
    .i_rst_dfx_upm_pma3_trst_b_2(i_rst_dfx_upm_pma3_trst_b_2), 
    .i_rst_dfx_upm_pma3_trst_b_3(i_rst_dfx_upm_pma3_trst_b_3), 
    .i_rst_fscan_byplatrst_b_2(i_rst_fscan_byplatrst_b_2), 
    .i_rst_fscan_byplatrst_b_3(i_rst_fscan_byplatrst_b_3), 
    .i_rst_fscan_byprst_b_2(i_rst_fscan_byprst_b_2), 
    .i_rst_fscan_byprst_b_3(i_rst_fscan_byprst_b_3), 
    .i_rst_ucss_jtag_trst_b_a_2(i_rst_ucss_jtag_trst_b_a_2), 
    .i_rst_ucss_jtag_trst_b_a_3(i_rst_ucss_jtag_trst_b_a_3), 
    .i_scanio_en_nt_2(i_scanio_en_nt_2), 
    .i_scanio_en_nt_3(i_scanio_en_nt_3), 
    .i_scanio_pma0_dat_ref0_n_a_2(i_scanio_pma0_dat_ref0_n_a_2), 
    .i_scanio_pma0_dat_ref0_n_a_3(i_scanio_pma0_dat_ref0_n_a_3), 
    .i_scanio_pma0_dat_ref0_p_a_2(i_scanio_pma0_dat_ref0_p_a_2), 
    .i_scanio_pma0_dat_ref0_p_a_3(i_scanio_pma0_dat_ref0_p_a_3), 
    .i_scanio_pma0_dat_ref1_n_a_2(i_scanio_pma0_dat_ref1_n_a_2), 
    .i_scanio_pma0_dat_ref1_n_a_3(i_scanio_pma0_dat_ref1_n_a_3), 
    .i_scanio_pma0_dat_ref1_p_a_2(i_scanio_pma0_dat_ref1_p_a_2), 
    .i_scanio_pma0_dat_ref1_p_a_3(i_scanio_pma0_dat_ref1_p_a_3), 
    .i_scanio_pma0_dat_tx_n_l0_a_2(i_scanio_pma0_dat_tx_n_l0_a_2), 
    .i_scanio_pma0_dat_tx_n_l0_a_3(i_scanio_pma0_dat_tx_n_l0_a_3), 
    .i_scanio_pma0_dat_tx_p_l0_a_2(i_scanio_pma0_dat_tx_p_l0_a_2), 
    .i_scanio_pma0_dat_tx_p_l0_a_3(i_scanio_pma0_dat_tx_p_l0_a_3), 
    .i_scanio_pma0_ref0_outen_nt_2(i_scanio_pma0_ref0_outen_nt_2), 
    .i_scanio_pma0_ref0_outen_nt_3(i_scanio_pma0_ref0_outen_nt_3), 
    .i_scanio_pma0_ref1_outen_nt_2(i_scanio_pma0_ref1_outen_nt_2), 
    .i_scanio_pma0_ref1_outen_nt_3(i_scanio_pma0_ref1_outen_nt_3), 
    .i_scanio_pma1_dat_ref0_n_a_2(i_scanio_pma1_dat_ref0_n_a_2), 
    .i_scanio_pma1_dat_ref0_n_a_3(i_scanio_pma1_dat_ref0_n_a_3), 
    .i_scanio_pma1_dat_ref0_p_a_2(i_scanio_pma1_dat_ref0_p_a_2), 
    .i_scanio_pma1_dat_ref0_p_a_3(i_scanio_pma1_dat_ref0_p_a_3), 
    .i_scanio_pma1_dat_ref1_n_a_2(i_scanio_pma1_dat_ref1_n_a_2), 
    .i_scanio_pma1_dat_ref1_n_a_3(i_scanio_pma1_dat_ref1_n_a_3), 
    .i_scanio_pma1_dat_ref1_p_a_2(i_scanio_pma1_dat_ref1_p_a_2), 
    .i_scanio_pma1_dat_ref1_p_a_3(i_scanio_pma1_dat_ref1_p_a_3), 
    .i_scanio_pma1_dat_tx_n_l0_a_2(i_scanio_pma1_dat_tx_n_l0_a_2), 
    .i_scanio_pma1_dat_tx_n_l0_a_3(i_scanio_pma1_dat_tx_n_l0_a_3), 
    .i_scanio_pma1_dat_tx_p_l0_a_2(i_scanio_pma1_dat_tx_p_l0_a_2), 
    .i_scanio_pma1_dat_tx_p_l0_a_3(i_scanio_pma1_dat_tx_p_l0_a_3), 
    .i_scanio_pma1_ref0_outen_nt_2(i_scanio_pma1_ref0_outen_nt_2), 
    .i_scanio_pma1_ref0_outen_nt_3(i_scanio_pma1_ref0_outen_nt_3), 
    .i_scanio_pma1_ref1_outen_nt_2(i_scanio_pma1_ref1_outen_nt_2), 
    .i_scanio_pma1_ref1_outen_nt_3(i_scanio_pma1_ref1_outen_nt_3), 
    .i_scanio_pma2_dat_ref0_n_a_2(i_scanio_pma2_dat_ref0_n_a_2), 
    .i_scanio_pma2_dat_ref0_n_a_3(i_scanio_pma2_dat_ref0_n_a_3), 
    .i_scanio_pma2_dat_ref0_p_a_2(i_scanio_pma2_dat_ref0_p_a_2), 
    .i_scanio_pma2_dat_ref0_p_a_3(i_scanio_pma2_dat_ref0_p_a_3), 
    .i_scanio_pma2_dat_ref1_n_a_2(i_scanio_pma2_dat_ref1_n_a_2), 
    .i_scanio_pma2_dat_ref1_n_a_3(i_scanio_pma2_dat_ref1_n_a_3), 
    .i_scanio_pma2_dat_ref1_p_a_2(i_scanio_pma2_dat_ref1_p_a_2), 
    .i_scanio_pma2_dat_ref1_p_a_3(i_scanio_pma2_dat_ref1_p_a_3), 
    .i_scanio_pma2_dat_tx_n_l0_a_2(i_scanio_pma2_dat_tx_n_l0_a_2), 
    .i_scanio_pma2_dat_tx_n_l0_a_3(i_scanio_pma2_dat_tx_n_l0_a_3), 
    .i_scanio_pma2_dat_tx_p_l0_a_2(i_scanio_pma2_dat_tx_p_l0_a_2), 
    .i_scanio_pma2_dat_tx_p_l0_a_3(i_scanio_pma2_dat_tx_p_l0_a_3), 
    .i_scanio_pma2_ref0_outen_nt_2(i_scanio_pma2_ref0_outen_nt_2), 
    .i_scanio_pma2_ref0_outen_nt_3(i_scanio_pma2_ref0_outen_nt_3), 
    .i_scanio_pma2_ref1_outen_nt_2(i_scanio_pma2_ref1_outen_nt_2), 
    .i_scanio_pma2_ref1_outen_nt_3(i_scanio_pma2_ref1_outen_nt_3), 
    .i_scanio_pma3_dat_ref0_n_a_2(i_scanio_pma3_dat_ref0_n_a_2), 
    .i_scanio_pma3_dat_ref0_n_a_3(i_scanio_pma3_dat_ref0_n_a_3), 
    .i_scanio_pma3_dat_ref0_p_a_2(i_scanio_pma3_dat_ref0_p_a_2), 
    .i_scanio_pma3_dat_ref0_p_a_3(i_scanio_pma3_dat_ref0_p_a_3), 
    .i_scanio_pma3_dat_ref1_n_a_2(i_scanio_pma3_dat_ref1_n_a_2), 
    .i_scanio_pma3_dat_ref1_n_a_3(i_scanio_pma3_dat_ref1_n_a_3), 
    .i_scanio_pma3_dat_ref1_p_a_2(i_scanio_pma3_dat_ref1_p_a_2), 
    .i_scanio_pma3_dat_ref1_p_a_3(i_scanio_pma3_dat_ref1_p_a_3), 
    .i_scanio_pma3_dat_tx_n_l0_a_2(i_scanio_pma3_dat_tx_n_l0_a_2), 
    .i_scanio_pma3_dat_tx_n_l0_a_3(i_scanio_pma3_dat_tx_n_l0_a_3), 
    .i_scanio_pma3_dat_tx_p_l0_a_2(i_scanio_pma3_dat_tx_p_l0_a_2), 
    .i_scanio_pma3_dat_tx_p_l0_a_3(i_scanio_pma3_dat_tx_p_l0_a_3), 
    .i_scanio_pma3_ref0_outen_nt_2(i_scanio_pma3_ref0_outen_nt_2), 
    .i_scanio_pma3_ref0_outen_nt_3(i_scanio_pma3_ref0_outen_nt_3), 
    .i_scanio_pma3_ref1_outen_nt_2(i_scanio_pma3_ref1_outen_nt_2), 
    .i_scanio_pma3_ref1_outen_nt_3(i_scanio_pma3_ref1_outen_nt_3), 
    .i_ucss_jtag_id_nt_2(i_ucss_jtag_id_nt_2), 
    .i_ucss_jtag_id_nt_3(i_ucss_jtag_id_nt_3), 
    .i_ucss_jtag_slvid_nt_2(i_ucss_jtag_slvid_nt_2), 
    .i_ucss_jtag_slvid_nt_3(i_ucss_jtag_slvid_nt_3), 
    .i_ucss_jtag_tdi_2(i_ucss_jtag_tdi_2), 
    .i_ucss_jtag_tdi_3(i_ucss_jtag_tdi_3), 
    .i_ucss_jtag_tms_2(i_ucss_jtag_tms_2), 
    .i_ucss_jtag_tms_3(i_ucss_jtag_tms_3), 
    .versa_xmp_2_o_abscan_pma0_tdo(o_abscan_pma0_tdo_2), 
    .versa_xmp_3_o_abscan_pma0_tdo(o_abscan_pma0_tdo_3), 
    .versa_xmp_2_o_abscan_pma0_tdo_f(o_abscan_pma0_tdo_f_2), 
    .versa_xmp_3_o_abscan_pma0_tdo_f(o_abscan_pma0_tdo_f_3), 
    .versa_xmp_2_o_abscan_pma1_tdo(o_abscan_pma1_tdo_2), 
    .versa_xmp_3_o_abscan_pma1_tdo(o_abscan_pma1_tdo_3), 
    .versa_xmp_2_o_abscan_pma1_tdo_f(o_abscan_pma1_tdo_f_2), 
    .versa_xmp_3_o_abscan_pma1_tdo_f(o_abscan_pma1_tdo_f_3), 
    .versa_xmp_2_o_abscan_pma2_tdo(o_abscan_pma2_tdo_2), 
    .versa_xmp_3_o_abscan_pma2_tdo(o_abscan_pma2_tdo_3), 
    .versa_xmp_2_o_abscan_pma2_tdo_f(o_abscan_pma2_tdo_f_2), 
    .versa_xmp_3_o_abscan_pma2_tdo_f(o_abscan_pma2_tdo_f_3), 
    .versa_xmp_2_o_abscan_pma3_tdo(o_abscan_pma3_tdo_2), 
    .versa_xmp_3_o_abscan_pma3_tdo(o_abscan_pma3_tdo_3), 
    .versa_xmp_2_o_abscan_pma3_tdo_f(o_abscan_pma3_tdo_f_2), 
    .versa_xmp_3_o_abscan_pma3_tdo_f(o_abscan_pma3_tdo_f_3), 
    .versa_xmp_2_o_ascan_pma0_sdo_apb_cmn(o_ascan_pma0_sdo_apb_cmn_2), 
    .versa_xmp_3_o_ascan_pma0_sdo_apb_cmn(o_ascan_pma0_sdo_apb_cmn_3), 
    .versa_xmp_2_o_ascan_pma0_sdo_cmnplla(o_ascan_pma0_sdo_cmnplla_2), 
    .versa_xmp_3_o_ascan_pma0_sdo_cmnplla(o_ascan_pma0_sdo_cmnplla_3), 
    .versa_xmp_2_o_ascan_pma0_sdo_cmnpllb(o_ascan_pma0_sdo_cmnpllb_2), 
    .versa_xmp_3_o_ascan_pma0_sdo_cmnpllb(o_ascan_pma0_sdo_cmnpllb_3), 
    .versa_xmp_2_o_ascan_pma0_sdo_ctrl_l0(o_ascan_pma0_sdo_ctrl_l0_2), 
    .versa_xmp_3_o_ascan_pma0_sdo_ctrl_l0(o_ascan_pma0_sdo_ctrl_l0_3), 
    .versa_xmp_2_o_ascan_pma0_sdo_memarray_word_l0(o_ascan_pma0_sdo_memarray_word_l0_2), 
    .versa_xmp_3_o_ascan_pma0_sdo_memarray_word_l0(o_ascan_pma0_sdo_memarray_word_l0_3), 
    .versa_xmp_2_o_ascan_pma0_sdo_ref_channelcmn(o_ascan_pma0_sdo_ref_channelcmn_2), 
    .versa_xmp_3_o_ascan_pma0_sdo_ref_channelcmn(o_ascan_pma0_sdo_ref_channelcmn_3), 
    .versa_xmp_2_o_ascan_pma0_sdo_ref_channelleft_l0(o_ascan_pma0_sdo_ref_channelleft_l0_2), 
    .versa_xmp_3_o_ascan_pma0_sdo_ref_channelleft_l0(o_ascan_pma0_sdo_ref_channelleft_l0_3), 
    .versa_xmp_2_o_ascan_pma0_sdo_ref_channelright_l0(o_ascan_pma0_sdo_ref_channelright_l0_2), 
    .versa_xmp_3_o_ascan_pma0_sdo_ref_channelright_l0(o_ascan_pma0_sdo_ref_channelright_l0_3), 
    .versa_xmp_2_o_ascan_pma0_sdo_ref_cmn(o_ascan_pma0_sdo_ref_cmn_2), 
    .versa_xmp_3_o_ascan_pma0_sdo_ref_cmn(o_ascan_pma0_sdo_ref_cmn_3), 
    .versa_xmp_2_o_ascan_pma0_sdo_ref_l0(o_ascan_pma0_sdo_ref_l0_2), 
    .versa_xmp_3_o_ascan_pma0_sdo_ref_l0(o_ascan_pma0_sdo_ref_l0_3), 
    .versa_xmp_2_o_ascan_pma0_sdo_ref_txffe_l0(o_ascan_pma0_sdo_ref_txffe_l0_2), 
    .versa_xmp_3_o_ascan_pma0_sdo_ref_txffe_l0(o_ascan_pma0_sdo_ref_txffe_l0_3), 
    .versa_xmp_2_o_ascan_pma0_sdo_txpll_l0(o_ascan_pma0_sdo_txpll_l0_2), 
    .versa_xmp_3_o_ascan_pma0_sdo_txpll_l0(o_ascan_pma0_sdo_txpll_l0_3), 
    .versa_xmp_2_o_ascan_pma0_sdo_word_l0(o_ascan_pma0_sdo_word_l0_2), 
    .versa_xmp_3_o_ascan_pma0_sdo_word_l0(o_ascan_pma0_sdo_word_l0_3), 
    .versa_xmp_2_o_ascan_pma0_sdo_word_txffe_l0(o_ascan_pma0_sdo_word_txffe_l0_2), 
    .versa_xmp_3_o_ascan_pma0_sdo_word_txffe_l0(o_ascan_pma0_sdo_word_txffe_l0_3), 
    .versa_xmp_2_o_ascan_pma1_sdo_apb_cmn(o_ascan_pma1_sdo_apb_cmn_2), 
    .versa_xmp_3_o_ascan_pma1_sdo_apb_cmn(o_ascan_pma1_sdo_apb_cmn_3), 
    .versa_xmp_2_o_ascan_pma1_sdo_cmnplla(o_ascan_pma1_sdo_cmnplla_2), 
    .versa_xmp_3_o_ascan_pma1_sdo_cmnplla(o_ascan_pma1_sdo_cmnplla_3), 
    .versa_xmp_2_o_ascan_pma1_sdo_cmnpllb(o_ascan_pma1_sdo_cmnpllb_2), 
    .versa_xmp_3_o_ascan_pma1_sdo_cmnpllb(o_ascan_pma1_sdo_cmnpllb_3), 
    .versa_xmp_2_o_ascan_pma1_sdo_ctrl_l0(o_ascan_pma1_sdo_ctrl_l0_2), 
    .versa_xmp_3_o_ascan_pma1_sdo_ctrl_l0(o_ascan_pma1_sdo_ctrl_l0_3), 
    .versa_xmp_2_o_ascan_pma1_sdo_memarray_word_l0(o_ascan_pma1_sdo_memarray_word_l0_2), 
    .versa_xmp_3_o_ascan_pma1_sdo_memarray_word_l0(o_ascan_pma1_sdo_memarray_word_l0_3), 
    .versa_xmp_2_o_ascan_pma1_sdo_ref_channelcmn(o_ascan_pma1_sdo_ref_channelcmn_2), 
    .versa_xmp_3_o_ascan_pma1_sdo_ref_channelcmn(o_ascan_pma1_sdo_ref_channelcmn_3), 
    .versa_xmp_2_o_ascan_pma1_sdo_ref_channelleft_l0(o_ascan_pma1_sdo_ref_channelleft_l0_2), 
    .versa_xmp_3_o_ascan_pma1_sdo_ref_channelleft_l0(o_ascan_pma1_sdo_ref_channelleft_l0_3), 
    .versa_xmp_2_o_ascan_pma1_sdo_ref_channelright_l0(o_ascan_pma1_sdo_ref_channelright_l0_2), 
    .versa_xmp_3_o_ascan_pma1_sdo_ref_channelright_l0(o_ascan_pma1_sdo_ref_channelright_l0_3), 
    .versa_xmp_2_o_ascan_pma1_sdo_ref_cmn(o_ascan_pma1_sdo_ref_cmn_2), 
    .versa_xmp_3_o_ascan_pma1_sdo_ref_cmn(o_ascan_pma1_sdo_ref_cmn_3), 
    .versa_xmp_2_o_ascan_pma1_sdo_ref_l0(o_ascan_pma1_sdo_ref_l0_2), 
    .versa_xmp_3_o_ascan_pma1_sdo_ref_l0(o_ascan_pma1_sdo_ref_l0_3), 
    .versa_xmp_2_o_ascan_pma1_sdo_ref_txffe_l0(o_ascan_pma1_sdo_ref_txffe_l0_2), 
    .versa_xmp_3_o_ascan_pma1_sdo_ref_txffe_l0(o_ascan_pma1_sdo_ref_txffe_l0_3), 
    .versa_xmp_2_o_ascan_pma1_sdo_txpll_l0(o_ascan_pma1_sdo_txpll_l0_2), 
    .versa_xmp_3_o_ascan_pma1_sdo_txpll_l0(o_ascan_pma1_sdo_txpll_l0_3), 
    .versa_xmp_2_o_ascan_pma1_sdo_word_l0(o_ascan_pma1_sdo_word_l0_2), 
    .versa_xmp_3_o_ascan_pma1_sdo_word_l0(o_ascan_pma1_sdo_word_l0_3), 
    .versa_xmp_2_o_ascan_pma1_sdo_word_txffe_l0(o_ascan_pma1_sdo_word_txffe_l0_2), 
    .versa_xmp_3_o_ascan_pma1_sdo_word_txffe_l0(o_ascan_pma1_sdo_word_txffe_l0_3), 
    .versa_xmp_2_o_ascan_pma2_sdo_apb_cmn(o_ascan_pma2_sdo_apb_cmn_2), 
    .versa_xmp_3_o_ascan_pma2_sdo_apb_cmn(o_ascan_pma2_sdo_apb_cmn_3), 
    .versa_xmp_2_o_ascan_pma2_sdo_cmnplla(o_ascan_pma2_sdo_cmnplla_2), 
    .versa_xmp_3_o_ascan_pma2_sdo_cmnplla(o_ascan_pma2_sdo_cmnplla_3), 
    .versa_xmp_2_o_ascan_pma2_sdo_cmnpllb(o_ascan_pma2_sdo_cmnpllb_2), 
    .versa_xmp_3_o_ascan_pma2_sdo_cmnpllb(o_ascan_pma2_sdo_cmnpllb_3), 
    .versa_xmp_2_o_ascan_pma2_sdo_ctrl_l0(o_ascan_pma2_sdo_ctrl_l0_2), 
    .versa_xmp_3_o_ascan_pma2_sdo_ctrl_l0(o_ascan_pma2_sdo_ctrl_l0_3), 
    .versa_xmp_2_o_ascan_pma2_sdo_memarray_word_l0(o_ascan_pma2_sdo_memarray_word_l0_2), 
    .versa_xmp_3_o_ascan_pma2_sdo_memarray_word_l0(o_ascan_pma2_sdo_memarray_word_l0_3), 
    .versa_xmp_2_o_ascan_pma2_sdo_ref_channelcmn(o_ascan_pma2_sdo_ref_channelcmn_2), 
    .versa_xmp_3_o_ascan_pma2_sdo_ref_channelcmn(o_ascan_pma2_sdo_ref_channelcmn_3), 
    .versa_xmp_2_o_ascan_pma2_sdo_ref_channelleft_l0(o_ascan_pma2_sdo_ref_channelleft_l0_2), 
    .versa_xmp_3_o_ascan_pma2_sdo_ref_channelleft_l0(o_ascan_pma2_sdo_ref_channelleft_l0_3), 
    .versa_xmp_2_o_ascan_pma2_sdo_ref_channelright_l0(o_ascan_pma2_sdo_ref_channelright_l0_2), 
    .versa_xmp_3_o_ascan_pma2_sdo_ref_channelright_l0(o_ascan_pma2_sdo_ref_channelright_l0_3), 
    .versa_xmp_2_o_ascan_pma2_sdo_ref_cmn(o_ascan_pma2_sdo_ref_cmn_2), 
    .versa_xmp_3_o_ascan_pma2_sdo_ref_cmn(o_ascan_pma2_sdo_ref_cmn_3), 
    .versa_xmp_2_o_ascan_pma2_sdo_ref_l0(o_ascan_pma2_sdo_ref_l0_2), 
    .versa_xmp_3_o_ascan_pma2_sdo_ref_l0(o_ascan_pma2_sdo_ref_l0_3), 
    .versa_xmp_2_o_ascan_pma2_sdo_ref_txffe_l0(o_ascan_pma2_sdo_ref_txffe_l0_2), 
    .versa_xmp_3_o_ascan_pma2_sdo_ref_txffe_l0(o_ascan_pma2_sdo_ref_txffe_l0_3), 
    .versa_xmp_2_o_ascan_pma2_sdo_txpll_l0(o_ascan_pma2_sdo_txpll_l0_2), 
    .versa_xmp_3_o_ascan_pma2_sdo_txpll_l0(o_ascan_pma2_sdo_txpll_l0_3), 
    .versa_xmp_2_o_ascan_pma2_sdo_word_l0(o_ascan_pma2_sdo_word_l0_2), 
    .versa_xmp_3_o_ascan_pma2_sdo_word_l0(o_ascan_pma2_sdo_word_l0_3), 
    .versa_xmp_2_o_ascan_pma2_sdo_word_txffe_l0(o_ascan_pma2_sdo_word_txffe_l0_2), 
    .versa_xmp_3_o_ascan_pma2_sdo_word_txffe_l0(o_ascan_pma2_sdo_word_txffe_l0_3), 
    .versa_xmp_2_o_ascan_pma3_sdo_apb_cmn(o_ascan_pma3_sdo_apb_cmn_2), 
    .versa_xmp_3_o_ascan_pma3_sdo_apb_cmn(o_ascan_pma3_sdo_apb_cmn_3), 
    .versa_xmp_2_o_ascan_pma3_sdo_cmnplla(o_ascan_pma3_sdo_cmnplla_2), 
    .versa_xmp_3_o_ascan_pma3_sdo_cmnplla(o_ascan_pma3_sdo_cmnplla_3), 
    .versa_xmp_2_o_ascan_pma3_sdo_cmnpllb(o_ascan_pma3_sdo_cmnpllb_2), 
    .versa_xmp_3_o_ascan_pma3_sdo_cmnpllb(o_ascan_pma3_sdo_cmnpllb_3), 
    .versa_xmp_2_o_ascan_pma3_sdo_ctrl_l0(o_ascan_pma3_sdo_ctrl_l0_2), 
    .versa_xmp_3_o_ascan_pma3_sdo_ctrl_l0(o_ascan_pma3_sdo_ctrl_l0_3), 
    .versa_xmp_2_o_ascan_pma3_sdo_memarray_word_l0(o_ascan_pma3_sdo_memarray_word_l0_2), 
    .versa_xmp_3_o_ascan_pma3_sdo_memarray_word_l0(o_ascan_pma3_sdo_memarray_word_l0_3), 
    .versa_xmp_2_o_ascan_pma3_sdo_ref_channelcmn(o_ascan_pma3_sdo_ref_channelcmn_2), 
    .versa_xmp_3_o_ascan_pma3_sdo_ref_channelcmn(o_ascan_pma3_sdo_ref_channelcmn_3), 
    .versa_xmp_2_o_ascan_pma3_sdo_ref_channelleft_l0(o_ascan_pma3_sdo_ref_channelleft_l0_2), 
    .versa_xmp_3_o_ascan_pma3_sdo_ref_channelleft_l0(o_ascan_pma3_sdo_ref_channelleft_l0_3), 
    .versa_xmp_2_o_ascan_pma3_sdo_ref_channelright_l0(o_ascan_pma3_sdo_ref_channelright_l0_2), 
    .versa_xmp_3_o_ascan_pma3_sdo_ref_channelright_l0(o_ascan_pma3_sdo_ref_channelright_l0_3), 
    .versa_xmp_2_o_ascan_pma3_sdo_ref_cmn(o_ascan_pma3_sdo_ref_cmn_2), 
    .versa_xmp_3_o_ascan_pma3_sdo_ref_cmn(o_ascan_pma3_sdo_ref_cmn_3), 
    .versa_xmp_2_o_ascan_pma3_sdo_ref_l0(o_ascan_pma3_sdo_ref_l0_2), 
    .versa_xmp_3_o_ascan_pma3_sdo_ref_l0(o_ascan_pma3_sdo_ref_l0_3), 
    .versa_xmp_2_o_ascan_pma3_sdo_ref_txffe_l0(o_ascan_pma3_sdo_ref_txffe_l0_2), 
    .versa_xmp_3_o_ascan_pma3_sdo_ref_txffe_l0(o_ascan_pma3_sdo_ref_txffe_l0_3), 
    .versa_xmp_2_o_ascan_pma3_sdo_txpll_l0(o_ascan_pma3_sdo_txpll_l0_2), 
    .versa_xmp_3_o_ascan_pma3_sdo_txpll_l0(o_ascan_pma3_sdo_txpll_l0_3), 
    .versa_xmp_2_o_ascan_pma3_sdo_word_l0(o_ascan_pma3_sdo_word_l0_2), 
    .versa_xmp_3_o_ascan_pma3_sdo_word_l0(o_ascan_pma3_sdo_word_l0_3), 
    .versa_xmp_2_o_ascan_pma3_sdo_word_txffe_l0(o_ascan_pma3_sdo_word_txffe_l0_2), 
    .versa_xmp_3_o_ascan_pma3_sdo_word_txffe_l0(o_ascan_pma3_sdo_word_txffe_l0_3), 
    .soc_per_clk(soc_per_clk), 
    .ioa_ck_pma0_ref_left_pquad1_physs1(physs1_ioa_ck_pma0_ref_left_pquad1_physs1), 
    .ioa_ck_pma3_ref_right_pquad0_physs1(physs1_ioa_ck_pma0_ref_left_pquad1_physs1), 
    .eth_hdspsr_trim_fuse_in(eth_hdspsr_trim_fuse_in), 
    .eth_hd2prf_trim_fuse_in(eth_hd2prf_trim_fuse_in), 
    .versa_xmp_2_o_scanio_pma0_dat_ref0_n_a(o_scanio_pma0_dat_ref0_n_a_2), 
    .versa_xmp_2_o_scanio_pma0_dat_ref0_p_a(o_scanio_pma0_dat_ref0_p_a_2), 
    .versa_xmp_2_o_scanio_pma0_dat_ref1_n_a(o_scanio_pma0_dat_ref1_n_a_2), 
    .versa_xmp_2_o_scanio_pma0_dat_ref1_p_a(o_scanio_pma0_dat_ref1_p_a_2), 
    .versa_xmp_2_o_scanio_pma0_dat_rx_n_l0_a(o_scanio_pma0_dat_rx_n_l0_a_2), 
    .versa_xmp_2_o_scanio_pma0_dat_rx_p_l0_a(o_scanio_pma0_dat_rx_p_l0_a_2), 
    .versa_xmp_2_o_scanio_pma1_dat_ref0_n_a(o_scanio_pma1_dat_ref0_n_a_2), 
    .versa_xmp_2_o_scanio_pma1_dat_ref0_p_a(o_scanio_pma1_dat_ref0_p_a_2), 
    .versa_xmp_2_o_scanio_pma1_dat_ref1_n_a(o_scanio_pma1_dat_ref1_n_a_2), 
    .versa_xmp_2_o_scanio_pma1_dat_ref1_p_a(o_scanio_pma1_dat_ref1_p_a_2), 
    .versa_xmp_2_o_scanio_pma1_dat_rx_n_l0_a(o_scanio_pma1_dat_rx_n_l0_a_2), 
    .versa_xmp_2_o_scanio_pma1_dat_rx_p_l0_a(o_scanio_pma1_dat_rx_p_l0_a_2), 
    .versa_xmp_2_o_scanio_pma2_dat_ref0_n_a(o_scanio_pma2_dat_ref0_n_a_2), 
    .versa_xmp_2_o_scanio_pma2_dat_ref0_p_a(o_scanio_pma2_dat_ref0_p_a_2), 
    .versa_xmp_2_o_scanio_pma2_dat_ref1_n_a(o_scanio_pma2_dat_ref1_n_a_2), 
    .versa_xmp_2_o_scanio_pma2_dat_ref1_p_a(o_scanio_pma2_dat_ref1_p_a_2), 
    .versa_xmp_2_o_scanio_pma2_dat_rx_n_l0_a(o_scanio_pma2_dat_rx_n_l0_a_2), 
    .versa_xmp_2_o_scanio_pma2_dat_rx_p_l0_a(o_scanio_pma2_dat_rx_p_l0_a_2), 
    .versa_xmp_2_o_scanio_pma3_dat_ref0_n_a(o_scanio_pma3_dat_ref0_n_a_2), 
    .versa_xmp_2_o_scanio_pma3_dat_ref0_p_a(o_scanio_pma3_dat_ref0_p_a_2), 
    .versa_xmp_2_o_scanio_pma3_dat_ref1_n_a(o_scanio_pma3_dat_ref1_n_a_2), 
    .versa_xmp_2_o_scanio_pma3_dat_ref1_p_a(o_scanio_pma3_dat_ref1_p_a_2), 
    .versa_xmp_2_o_scanio_pma3_dat_rx_n_l0_a(o_scanio_pma3_dat_rx_n_l0_a_2), 
    .versa_xmp_2_o_scanio_pma3_dat_rx_p_l0_a(o_scanio_pma3_dat_rx_p_l0_a_2), 
    .versa_xmp_3_o_scanio_pma0_dat_ref0_n_a(o_scanio_pma0_dat_ref0_n_a_3), 
    .versa_xmp_3_o_scanio_pma0_dat_ref0_p_a(o_scanio_pma0_dat_ref0_p_a_3), 
    .versa_xmp_3_o_scanio_pma0_dat_ref1_n_a(o_scanio_pma0_dat_ref1_n_a_3), 
    .versa_xmp_3_o_scanio_pma0_dat_ref1_p_a(o_scanio_pma0_dat_ref1_p_a_3), 
    .versa_xmp_3_o_scanio_pma0_dat_rx_n_l0_a(o_scanio_pma0_dat_rx_n_l0_a_3), 
    .versa_xmp_3_o_scanio_pma0_dat_rx_p_l0_a(o_scanio_pma0_dat_rx_p_l0_a_3), 
    .versa_xmp_3_o_scanio_pma1_dat_ref0_n_a(o_scanio_pma1_dat_ref0_n_a_3), 
    .versa_xmp_3_o_scanio_pma1_dat_ref0_p_a(o_scanio_pma1_dat_ref0_p_a_3), 
    .versa_xmp_3_o_scanio_pma1_dat_ref1_n_a(o_scanio_pma1_dat_ref1_n_a_3), 
    .versa_xmp_3_o_scanio_pma1_dat_ref1_p_a(o_scanio_pma1_dat_ref1_p_a_3), 
    .versa_xmp_3_o_scanio_pma1_dat_rx_n_l0_a(o_scanio_pma1_dat_rx_n_l0_a_3), 
    .versa_xmp_3_o_scanio_pma1_dat_rx_p_l0_a(o_scanio_pma1_dat_rx_p_l0_a_3), 
    .versa_xmp_3_o_scanio_pma2_dat_ref0_n_a(o_scanio_pma2_dat_ref0_n_a_3), 
    .versa_xmp_3_o_scanio_pma2_dat_ref0_p_a(o_scanio_pma2_dat_ref0_p_a_3), 
    .versa_xmp_3_o_scanio_pma2_dat_ref1_n_a(o_scanio_pma2_dat_ref1_n_a_3), 
    .versa_xmp_3_o_scanio_pma2_dat_ref1_p_a(o_scanio_pma2_dat_ref1_p_a_3), 
    .versa_xmp_3_o_scanio_pma2_dat_rx_n_l0_a(o_scanio_pma2_dat_rx_n_l0_a_3), 
    .versa_xmp_3_o_scanio_pma2_dat_rx_p_l0_a(o_scanio_pma2_dat_rx_p_l0_a_3), 
    .versa_xmp_3_o_scanio_pma3_dat_ref0_n_a(o_scanio_pma3_dat_ref0_n_a_3), 
    .versa_xmp_3_o_scanio_pma3_dat_ref0_p_a(o_scanio_pma3_dat_ref0_p_a_3), 
    .versa_xmp_3_o_scanio_pma3_dat_ref1_n_a(o_scanio_pma3_dat_ref1_n_a_3), 
    .versa_xmp_3_o_scanio_pma3_dat_ref1_p_a(o_scanio_pma3_dat_ref1_p_a_3), 
    .versa_xmp_3_o_scanio_pma3_dat_rx_n_l0_a(o_scanio_pma3_dat_rx_n_l0_a_3), 
    .versa_xmp_3_o_scanio_pma3_dat_rx_p_l0_a(o_scanio_pma3_dat_rx_p_l0_a_3), 
    .i_pma8_jtag_id_nt(i_pma8_jtag_id_nt), 
    .i_pma8_jtag_slvid_nt(i_pma8_jtag_slvid_nt), 
    .i_pma8_jtag_tms(i_pma8_jtag_tms), 
    .i_pma8_jtag_tdi(i_pma8_jtag_tdi), 
    .versa_xmp_2_o_pma0_jtag_tdo_en(o_pma8_jtag_tdo_en), 
    .versa_xmp_2_o_pma0_jtag_tdo(o_pma8_jtag_tdo), 
    .i_pma9_jtag_id_nt(i_pma9_jtag_id_nt), 
    .i_pma9_jtag_slvid_nt(i_pma9_jtag_slvid_nt), 
    .i_pma9_jtag_tms(i_pma9_jtag_tms), 
    .i_pma9_jtag_tdi(i_pma9_jtag_tdi), 
    .versa_xmp_2_o_pma1_jtag_tdo_en(o_pma9_jtag_tdo_en), 
    .versa_xmp_2_o_pma1_jtag_tdo(o_pma9_jtag_tdo), 
    .i_pma10_jtag_id_nt(i_pma10_jtag_id_nt), 
    .i_pma10_jtag_slvid_nt(i_pma10_jtag_slvid_nt), 
    .i_pma10_jtag_tms(i_pma10_jtag_tms), 
    .i_pma10_jtag_tdi(i_pma10_jtag_tdi), 
    .versa_xmp_2_o_pma2_jtag_tdo_en(o_pma10_jtag_tdo_en), 
    .versa_xmp_2_o_pma2_jtag_tdo(o_pma10_jtag_tdo), 
    .i_pma11_jtag_id_nt(i_pma11_jtag_id_nt), 
    .i_pma11_jtag_slvid_nt(i_pma11_jtag_slvid_nt), 
    .i_pma11_jtag_tms(i_pma11_jtag_tms), 
    .i_pma11_jtag_tdi(i_pma11_jtag_tdi), 
    .versa_xmp_2_o_pma3_jtag_tdo_en(o_pma11_jtag_tdo_en), 
    .versa_xmp_2_o_pma3_jtag_tdo(o_pma11_jtag_tdo), 
    .i_pma12_jtag_id_nt(i_pma12_jtag_id_nt), 
    .i_pma12_jtag_slvid_nt(i_pma12_jtag_slvid_nt), 
    .i_pma12_jtag_tms(i_pma12_jtag_tms), 
    .i_pma12_jtag_tdi(i_pma12_jtag_tdi), 
    .versa_xmp_3_o_pma0_jtag_tdo_en(o_pma12_jtag_tdo_en), 
    .versa_xmp_3_o_pma0_jtag_tdo(o_pma12_jtag_tdo), 
    .i_pma13_jtag_id_nt(i_pma13_jtag_id_nt), 
    .i_pma13_jtag_slvid_nt(i_pma13_jtag_slvid_nt), 
    .i_pma13_jtag_tms(i_pma13_jtag_tms), 
    .i_pma13_jtag_tdi(i_pma13_jtag_tdi), 
    .versa_xmp_3_o_pma1_jtag_tdo_en(o_pma13_jtag_tdo_en), 
    .versa_xmp_3_o_pma1_jtag_tdo(o_pma13_jtag_tdo), 
    .i_pma14_jtag_id_nt(i_pma14_jtag_id_nt), 
    .i_pma14_jtag_slvid_nt(i_pma14_jtag_slvid_nt), 
    .i_pma14_jtag_tms(i_pma14_jtag_tms), 
    .i_pma14_jtag_tdi(i_pma14_jtag_tdi), 
    .versa_xmp_3_o_pma2_jtag_tdo_en(o_pma14_jtag_tdo_en), 
    .versa_xmp_3_o_pma2_jtag_tdo(o_pma14_jtag_tdo), 
    .i_pma15_jtag_id_nt(i_pma15_jtag_id_nt), 
    .i_pma15_jtag_slvid_nt(i_pma15_jtag_slvid_nt), 
    .i_pma15_jtag_tms(i_pma15_jtag_tms), 
    .i_pma15_jtag_tdi(i_pma15_jtag_tdi), 
    .versa_xmp_3_o_pma3_jtag_tdo_en(o_pma15_jtag_tdo_en), 
    .versa_xmp_3_o_pma3_jtag_tdo(o_pma15_jtag_tdo), 
    .versa_xmp_2_o_ucss_jtag_tdo_en(o_ucss_jtag_tdo_en_2), 
    .versa_xmp_2_o_ucss_jtag_tdo(o_ucss_jtag_tdo_2), 
    .versa_xmp_3_o_ucss_jtag_tdo_en(o_ucss_jtag_tdo_en_3), 
    .versa_xmp_3_o_ucss_jtag_tdo(o_ucss_jtag_tdo_3), 
    .versa_xmp_2_o_cpu_debug_tdo_en(o_cpu_debug_tdo_en_2), 
    .versa_xmp_2_o_cpu_debug_tdo(o_cpu_debug_tdo_2), 
    .versa_xmp_3_o_cpu_debug_tdo_en(o_cpu_debug_tdo_en_3), 
    .versa_xmp_3_o_cpu_debug_tdo(o_cpu_debug_tdo_3), 
    .i_ck_fscan_pma_apb_2(i_ck_fscan_pma_apb_2), 
    .i_ck_fscan_pma_apb_3(i_ck_fscan_pma_apb_3), 
    .versa_xmp_2_o_dfx_upm_pma0_so(o_dfx_upm_pma0_so_2), 
    .versa_xmp_2_o_dfx_upm_pma1_so(o_dfx_upm_pma1_so_2), 
    .versa_xmp_2_o_dfx_upm_pma2_so(o_dfx_upm_pma2_so_2), 
    .versa_xmp_2_o_dfx_upm_pma3_so(o_dfx_upm_pma3_so_2), 
    .versa_xmp_3_o_dfx_upm_pma0_so(o_dfx_upm_pma0_so_3), 
    .versa_xmp_3_o_dfx_upm_pma1_so(o_dfx_upm_pma1_so_3), 
    .versa_xmp_3_o_dfx_upm_pma2_so(o_dfx_upm_pma2_so_3), 
    .versa_xmp_3_o_dfx_upm_pma3_so(o_dfx_upm_pma3_so_3), 
    .i_rst_pma8_jtag_trst_b_a(i_rst_pma8_jtag_trst_b_a), 
    .i_rst_pma9_jtag_trst_b_a(i_rst_pma9_jtag_trst_b_a), 
    .i_rst_pma10_jtag_trst_b_a(i_rst_pma10_jtag_trst_b_a), 
    .i_rst_pma11_jtag_trst_b_a(i_rst_pma11_jtag_trst_b_a), 
    .i_rst_pma12_jtag_trst_b_a(i_rst_pma12_jtag_trst_b_a), 
    .i_rst_pma13_jtag_trst_b_a(i_rst_pma13_jtag_trst_b_a), 
    .i_rst_pma14_jtag_trst_b_a(i_rst_pma14_jtag_trst_b_a), 
    .i_rst_pma15_jtag_trst_b_a(i_rst_pma15_jtag_trst_b_a), 
    .ioa_ck_pma0_ref_left_pquad0_physs1(physs1_ioa_ck_pma0_ref_left_pquad0_physs1), 
    .quadpcs100_2_pcs_tsu_rx_sd(pcs_tsu_rx_sd[23:16]), 
    .quadpcs100_2_mii_rx_tsu_mux0(mii_rx_tsu_mux[17:16]), 
    .quadpcs100_2_mii_rx_tsu_mux1(mii_rx_tsu_mux[19:18]), 
    .quadpcs100_2_mii_rx_tsu_mux2(mii_rx_tsu_mux[21:20]), 
    .quadpcs100_2_mii_rx_tsu_mux3(mii_rx_tsu_mux[23:22]), 
    .quadpcs100_2_mii_tx_tsu(mii_tx_tsu[23:16]), 
    .quadpcs100_2_pcs_desk_buf_rlevel_0(pcs_desk_buf_rlevel[83:56]), 
    .quadpcs100_2_pcs_sd_bit_slip(pcs_sd_bit_slip[95:64]), 
    .quadpcs100_2_pcs_link_status_tsu(pcs_link_status_tsu[11:8]), 
    .quadpcs100_3_pcs_tsu_rx_sd(pcs_tsu_rx_sd[31:24]), 
    .quadpcs100_3_mii_rx_tsu_mux0(mii_rx_tsu_mux[25:24]), 
    .quadpcs100_3_mii_rx_tsu_mux1(mii_rx_tsu_mux[27:26]), 
    .quadpcs100_3_mii_rx_tsu_mux2(mii_rx_tsu_mux[29:28]), 
    .quadpcs100_3_mii_rx_tsu_mux3(mii_rx_tsu_mux[31:30]), 
    .quadpcs100_3_mii_tx_tsu(mii_tx_tsu[31:24]), 
    .quadpcs100_3_pcs_desk_buf_rlevel_0(pcs_desk_buf_rlevel[111:84]), 
    .quadpcs100_3_pcs_sd_bit_slip(pcs_sd_bit_slip[127:96]), 
    .quadpcs100_3_pcs_link_status_tsu(pcs_link_status_tsu[15:12]), 
    .versa_xmp_2_xioa_ck_pma0_ref0_n(xioa_ck_pma_ref0_n[8]), 
    .versa_xmp_2_xioa_ck_pma0_ref0_p(xioa_ck_pma_ref0_p[8]), 
    .versa_xmp_2_xioa_ck_pma0_ref1_n(xioa_ck_pma_ref1_n[8]), 
    .versa_xmp_2_xioa_ck_pma0_ref1_p(xioa_ck_pma_ref1_p[8]), 
    .versa_xmp_2_xioa_ck_pma1_ref0_n(xioa_ck_pma_ref0_n[9]), 
    .versa_xmp_2_xioa_ck_pma1_ref0_p(xioa_ck_pma_ref0_p[9]), 
    .versa_xmp_2_xioa_ck_pma1_ref1_n(xioa_ck_pma_ref1_n[9]), 
    .versa_xmp_2_xioa_ck_pma1_ref1_p(xioa_ck_pma_ref1_p[9]), 
    .versa_xmp_2_xioa_ck_pma2_ref0_n(xioa_ck_pma_ref0_n[10]), 
    .versa_xmp_2_xioa_ck_pma2_ref0_p(xioa_ck_pma_ref0_p[10]), 
    .versa_xmp_2_xioa_ck_pma2_ref1_n(xioa_ck_pma_ref1_n[10]), 
    .versa_xmp_2_xioa_ck_pma2_ref1_p(xioa_ck_pma_ref1_p[10]), 
    .versa_xmp_2_xioa_ck_pma3_ref0_n(xioa_ck_pma_ref0_n[11]), 
    .versa_xmp_2_xioa_ck_pma3_ref0_p(xioa_ck_pma_ref0_p[11]), 
    .versa_xmp_2_xioa_ck_pma3_ref1_n(xioa_ck_pma_ref1_n[11]), 
    .versa_xmp_2_xioa_ck_pma3_ref1_p(xioa_ck_pma_ref1_p[11]), 
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
    .versa_xmp_3_xioa_ck_pma0_ref1_n(xioa_ck_pma_ref1_n[12]), 
    .versa_xmp_3_xioa_ck_pma0_ref1_p(xioa_ck_pma_ref1_p[12]), 
    .versa_xmp_3_xioa_ck_pma1_ref0_n(xioa_ck_pma_ref0_n[13]), 
    .versa_xmp_3_xioa_ck_pma1_ref0_p(xioa_ck_pma_ref0_p[13]), 
    .versa_xmp_3_xioa_ck_pma1_ref1_n(xioa_ck_pma_ref1_n[13]), 
    .versa_xmp_3_xioa_ck_pma1_ref1_p(xioa_ck_pma_ref1_p[13]), 
    .versa_xmp_3_xioa_ck_pma2_ref0_n(eref0_pad_clk_m), 
    .versa_xmp_3_xioa_ck_pma2_ref0_p(eref0_pad_clk_p), 
    .versa_xmp_3_xioa_ck_pma2_ref1_n(xioa_ck_pma_ref1_n[14]), 
    .versa_xmp_3_xioa_ck_pma2_ref1_p(xioa_ck_pma_ref1_p[14]), 
    .versa_xmp_3_xioa_ck_pma3_ref0_n(syncE_pad_clk_m), 
    .versa_xmp_3_xioa_ck_pma3_ref0_p(syncE_pad_clk_p), 
    .versa_xmp_3_xioa_ck_pma3_ref1_n(xioa_ck_pma_ref1_n[15]), 
    .versa_xmp_3_xioa_ck_pma3_ref1_p(xioa_ck_pma_ref1_p[15]), 
    .versa_xmp_3_xoa_pma0_dcmon1(xoa_pma_dcmon1[12]), 
    .versa_xmp_3_xoa_pma0_dcmon2(xoa_pma_dcmon2[12]), 
    .versa_xmp_3_xoa_pma1_dcmon1(xoa_pma_dcmon1[13]), 
    .versa_xmp_3_xoa_pma1_dcmon2(xoa_pma_dcmon2[13]), 
    .versa_xmp_3_xoa_pma2_dcmon1(xoa_pma_dcmon1[14]), 
    .versa_xmp_3_xoa_pma2_dcmon2(xoa_pma_dcmon2[14]), 
    .versa_xmp_3_xoa_pma3_dcmon1(xoa_pma_dcmon1[15]), 
    .versa_xmp_3_xoa_pma3_dcmon2(xoa_pma_dcmon2[15]), 
    .nic_switch_mux_2_hlp_xlgmii0_txclk_ena(hlp_xlgmii0_txclk_ena_2), 
    .nic_switch_mux_2_hlp_xlgmii0_rxclk_ena(hlp_xlgmii0_rxclk_ena_2), 
    .nic_switch_mux_2_hlp_xlgmii0_rxc(hlp_xlgmii0_rxc_2), 
    .nic_switch_mux_2_hlp_xlgmii0_rxd(hlp_xlgmii0_rxd_2), 
    .nic_switch_mux_2_hlp_xlgmii0_rxt0_next(hlp_xlgmii0_rxt0_next_2), 
    .hlp_xlgmii0_txc_2(hlp_xlgmii0_txc_2), 
    .hlp_xlgmii0_txd_2(hlp_xlgmii0_txd_2), 
    .nic_switch_mux_2_hlp_xlgmii1_txclk_ena(hlp_xlgmii1_txclk_ena_2), 
    .nic_switch_mux_2_hlp_xlgmii1_rxclk_ena(hlp_xlgmii1_rxclk_ena_2), 
    .nic_switch_mux_2_hlp_xlgmii1_rxc(hlp_xlgmii1_rxc_2), 
    .nic_switch_mux_2_hlp_xlgmii1_rxd(hlp_xlgmii1_rxd_2), 
    .nic_switch_mux_2_hlp_xlgmii1_rxt0_next(hlp_xlgmii1_rxt0_next_2), 
    .hlp_xlgmii1_txc_2(hlp_xlgmii1_txc_2), 
    .hlp_xlgmii1_txd_2(hlp_xlgmii1_txd_2), 
    .nic_switch_mux_2_hlp_xlgmii2_txclk_ena(hlp_xlgmii2_txclk_ena_2), 
    .nic_switch_mux_2_hlp_xlgmii2_rxclk_ena(hlp_xlgmii2_rxclk_ena_2), 
    .nic_switch_mux_2_hlp_xlgmii2_rxc(hlp_xlgmii2_rxc_2), 
    .nic_switch_mux_2_hlp_xlgmii2_rxd(hlp_xlgmii2_rxd_2), 
    .nic_switch_mux_2_hlp_xlgmii2_rxt0_next(hlp_xlgmii2_rxt0_next_2), 
    .hlp_xlgmii2_txc_2(hlp_xlgmii2_txc_2), 
    .hlp_xlgmii2_txd_2(hlp_xlgmii2_txd_2), 
    .nic_switch_mux_2_hlp_xlgmii3_txclk_ena(hlp_xlgmii3_txclk_ena_2), 
    .nic_switch_mux_2_hlp_xlgmii3_rxclk_ena(hlp_xlgmii3_rxclk_ena_2), 
    .nic_switch_mux_2_hlp_xlgmii3_rxc(hlp_xlgmii3_rxc_2), 
    .nic_switch_mux_2_hlp_xlgmii3_rxd(hlp_xlgmii3_rxd_2), 
    .nic_switch_mux_2_hlp_xlgmii3_rxt0_next(hlp_xlgmii3_rxt0_next_2), 
    .hlp_xlgmii3_txc_2(hlp_xlgmii3_txc_2), 
    .hlp_xlgmii3_txd_2(hlp_xlgmii3_txd_2), 
    .nic_switch_mux_3_hlp_xlgmii0_txclk_ena(hlp_xlgmii0_txclk_ena_3), 
    .nic_switch_mux_3_hlp_xlgmii0_rxclk_ena(hlp_xlgmii0_rxclk_ena_3), 
    .nic_switch_mux_3_hlp_xlgmii0_rxc(hlp_xlgmii0_rxc_3), 
    .nic_switch_mux_3_hlp_xlgmii0_rxd(hlp_xlgmii0_rxd_3), 
    .nic_switch_mux_3_hlp_xlgmii0_rxt0_next(hlp_xlgmii0_rxt0_next_3), 
    .hlp_xlgmii0_txc_3(hlp_xlgmii0_txc_3), 
    .hlp_xlgmii0_txd_3(hlp_xlgmii0_txd_3), 
    .nic_switch_mux_3_hlp_xlgmii1_txclk_ena(hlp_xlgmii1_txclk_ena_3), 
    .nic_switch_mux_3_hlp_xlgmii1_rxclk_ena(hlp_xlgmii1_rxclk_ena_3), 
    .nic_switch_mux_3_hlp_xlgmii1_rxc(hlp_xlgmii1_rxc_3), 
    .nic_switch_mux_3_hlp_xlgmii1_rxd(hlp_xlgmii1_rxd_3), 
    .nic_switch_mux_3_hlp_xlgmii1_rxt0_next(hlp_xlgmii1_rxt0_next_3), 
    .hlp_xlgmii1_txc_3(hlp_xlgmii1_txc_3), 
    .hlp_xlgmii1_txd_3(hlp_xlgmii1_txd_3), 
    .nic_switch_mux_3_hlp_xlgmii2_txclk_ena(hlp_xlgmii2_txclk_ena_3), 
    .nic_switch_mux_3_hlp_xlgmii2_rxclk_ena(hlp_xlgmii2_rxclk_ena_3), 
    .nic_switch_mux_3_hlp_xlgmii2_rxc(hlp_xlgmii2_rxc_3), 
    .nic_switch_mux_3_hlp_xlgmii2_rxd(hlp_xlgmii2_rxd_3), 
    .nic_switch_mux_3_hlp_xlgmii2_rxt0_next(hlp_xlgmii2_rxt0_next_3), 
    .hlp_xlgmii2_txc_3(hlp_xlgmii2_txc_3), 
    .hlp_xlgmii2_txd_3(hlp_xlgmii2_txd_3), 
    .nic_switch_mux_3_hlp_xlgmii3_txclk_ena(hlp_xlgmii3_txclk_ena_3), 
    .nic_switch_mux_3_hlp_xlgmii3_rxclk_ena(hlp_xlgmii3_rxclk_ena_3), 
    .nic_switch_mux_3_hlp_xlgmii3_rxc(hlp_xlgmii3_rxc_3), 
    .nic_switch_mux_3_hlp_xlgmii3_rxd(hlp_xlgmii3_rxd_3), 
    .nic_switch_mux_3_hlp_xlgmii3_rxt0_next(hlp_xlgmii3_rxt0_next_3), 
    .hlp_xlgmii3_txc_3(hlp_xlgmii3_txc_3), 
    .hlp_xlgmii3_txd_3(hlp_xlgmii3_txd_3), 
    .nic_switch_mux_2_hlp_cgmii0_rxd(hlp_cgmii0_rxd_2), 
    .nic_switch_mux_2_hlp_cgmii0_rxc(hlp_cgmii0_rxc_2), 
    .nic_switch_mux_2_hlp_cgmii0_rxclk_ena(hlp_cgmii0_rxclk_ena_2), 
    .hlp_cgmii0_txd_2(hlp_cgmii0_txd_2), 
    .hlp_cgmii0_txc_2(hlp_cgmii0_txc_2), 
    .nic_switch_mux_2_hlp_cgmii0_txclk_ena(hlp_cgmii0_txclk_ena_2), 
    .nic_switch_mux_2_hlp_cgmii1_rxd(hlp_cgmii1_rxd_2), 
    .nic_switch_mux_2_hlp_cgmii1_rxc(hlp_cgmii1_rxc_2), 
    .nic_switch_mux_2_hlp_cgmii1_rxclk_ena(hlp_cgmii1_rxclk_ena_2), 
    .hlp_cgmii1_txd_2(hlp_cgmii1_txd_2), 
    .hlp_cgmii1_txc_2(hlp_cgmii1_txc_2), 
    .nic_switch_mux_2_hlp_cgmii1_txclk_ena(hlp_cgmii1_txclk_ena_2), 
    .nic_switch_mux_2_hlp_cgmii2_rxd(hlp_cgmii2_rxd_2), 
    .nic_switch_mux_2_hlp_cgmii2_rxc(hlp_cgmii2_rxc_2), 
    .nic_switch_mux_2_hlp_cgmii2_rxclk_ena(hlp_cgmii2_rxclk_ena_2), 
    .hlp_cgmii2_txd_2(hlp_cgmii2_txd_2), 
    .hlp_cgmii2_txc_2(hlp_cgmii2_txc_2), 
    .nic_switch_mux_2_hlp_cgmii2_txclk_ena(hlp_cgmii2_txclk_ena_2), 
    .nic_switch_mux_2_hlp_cgmii3_rxd(hlp_cgmii3_rxd_2), 
    .nic_switch_mux_2_hlp_cgmii3_rxc(hlp_cgmii3_rxc_2), 
    .nic_switch_mux_2_hlp_cgmii3_rxclk_ena(hlp_cgmii3_rxclk_ena_2), 
    .hlp_cgmii3_txd_2(hlp_cgmii3_txd_2), 
    .hlp_cgmii3_txc_2(hlp_cgmii3_txc_2), 
    .nic_switch_mux_2_hlp_cgmii3_txclk_ena(hlp_cgmii3_txclk_ena_2), 
    .nic_switch_mux_3_hlp_cgmii0_rxd(hlp_cgmii0_rxd_3), 
    .nic_switch_mux_3_hlp_cgmii0_rxc(hlp_cgmii0_rxc_3), 
    .nic_switch_mux_3_hlp_cgmii0_rxclk_ena(hlp_cgmii0_rxclk_ena_3), 
    .hlp_cgmii0_txd_3(hlp_cgmii0_txd_3), 
    .hlp_cgmii0_txc_3(hlp_cgmii0_txc_3), 
    .nic_switch_mux_3_hlp_cgmii0_txclk_ena(hlp_cgmii0_txclk_ena_3), 
    .nic_switch_mux_3_hlp_cgmii1_rxd(hlp_cgmii1_rxd_3), 
    .nic_switch_mux_3_hlp_cgmii1_rxc(hlp_cgmii1_rxc_3), 
    .nic_switch_mux_3_hlp_cgmii1_rxclk_ena(hlp_cgmii1_rxclk_ena_3), 
    .hlp_cgmii1_txd_3(hlp_cgmii1_txd_3), 
    .hlp_cgmii1_txc_3(hlp_cgmii1_txc_3), 
    .nic_switch_mux_3_hlp_cgmii1_txclk_ena(hlp_cgmii1_txclk_ena_3), 
    .nic_switch_mux_3_hlp_cgmii2_rxd(hlp_cgmii2_rxd_3), 
    .nic_switch_mux_3_hlp_cgmii2_rxc(hlp_cgmii2_rxc_3), 
    .nic_switch_mux_3_hlp_cgmii2_rxclk_ena(hlp_cgmii2_rxclk_ena_3), 
    .hlp_cgmii2_txd_3(hlp_cgmii2_txd_3), 
    .hlp_cgmii2_txc_3(hlp_cgmii2_txc_3), 
    .nic_switch_mux_3_hlp_cgmii2_txclk_ena(hlp_cgmii2_txclk_ena_3), 
    .nic_switch_mux_3_hlp_cgmii3_rxd(hlp_cgmii3_rxd_3), 
    .nic_switch_mux_3_hlp_cgmii3_rxc(hlp_cgmii3_rxc_3), 
    .nic_switch_mux_3_hlp_cgmii3_rxclk_ena(hlp_cgmii3_rxclk_ena_3), 
    .hlp_cgmii3_txd_3(hlp_cgmii3_txd_3), 
    .hlp_cgmii3_txc_3(hlp_cgmii3_txc_3), 
    .nic_switch_mux_3_hlp_cgmii3_txclk_ena(hlp_cgmii3_txclk_ena_3), 
    .physs_1_AWID(physs_1_AWID), 
    .physs_1_AWADDR(physs_1_AWADDR), 
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
    .physs_1_ARADDR(physs_1_ARADDR), 
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
    .quad_interrupts_2_mac100_int(mac100_2_int), 
    .quad_interrupts_2_pcs100_int(pcs100_2_int), 
    .quad_interrupts_3_mac100_int(mac100_3_int), 
    .quad_interrupts_3_pcs100_int(pcs100_3_int), 
    .quadpcs100_0_pcs_desk_buf_rlevel_0(quadpcs100_0_pcs_desk_buf_rlevel_1), 
    .quadpcs100_0_pcs_desk_buf_rlevel_1(quadpcs100_0_pcs_desk_buf_rlevel_2), 
    .quadpcs100_0_pcs_desk_buf_rlevel_2(quadpcs100_0_pcs_desk_buf_rlevel_3), 
    .quadpcs100_0_pcs_desk_buf_rlevel_3(quadpcs100_0_pcs_desk_buf_rlevel_4), 
    .quadpcs100_1_pcs_desk_buf_rlevel_0(quadpcs100_1_pcs_desk_buf_rlevel_1), 
    .quadpcs100_1_pcs_desk_buf_rlevel_1(quadpcs100_1_pcs_desk_buf_rlevel_2), 
    .quadpcs100_1_pcs_desk_buf_rlevel_2(quadpcs100_1_pcs_desk_buf_rlevel_3), 
    .quadpcs100_1_pcs_desk_buf_rlevel_3(quadpcs100_1_pcs_desk_buf_rlevel_4), 
    .ioa_ck_pma3_ref_right_pquad1_physs1()
) ; 
// EDIT_INSTANCE END
endmodule
