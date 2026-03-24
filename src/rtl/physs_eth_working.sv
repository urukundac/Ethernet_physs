module physs_eth(
    input physs_func_rst_raw_n, //functional reset to PHYSS (LINKR). Should use for MEM init
//input physs_reset_prep_req, 
input physs_func_clk, //PCS and MAC data path clock (931.25MHz)
input physs_funcx2_clk, //MAC and PCS clock for 800 Mhz operaion (1.6 Ghz)
input physs_intf0_clk, //MAC Interface clock (1.35Ghz)
input soc_per_clk, //control and configuration clock (112.5MHz)
input timeref_clk,
input clk_125mhz,
input i_reset,
input rx_serial_data,
output tx_serial_data,//1588 clock (800MHz)
input rclk_diff_p, //on die differential signal _p
input rclk_diff_n //on die differential signal _n
);
logic physs_reset_prep_req; //Request to PHYSS to prepare before CORE reset for clearing the pipe interface with mse.
logic physs_reset_prep_ack; //Acknowledge from PHYSS that the interface is ready for CORE reset
//logic physs_func_clk; //PCS and MAC data path clock (931.25MHz)
//logic physs_funcx2_clk; //MAC and PCS clock for 800 Mhz operaion (1.6 Ghz)
//logic physs_intf0_clk; //MAC Interface clock (1.35Ghz)
//logic soc_per_clk; //control and configuration clock (112.5MHz)
//logic timeref_clk; //1588 clock (800MHz)
logic [1:0] physs_synce_rxclk; //Rx recovered clock divided for syncE . Expose 2 clocks selected from 8 lanes when link is stable. The maximum frequancy of this clock is 150Mhz
logic physs_o_ref_clk_out; //Digital reference clock logic from SERDES (single ended (156.25Mhz) . To used by top level PLLs as REFCLK
logic eref0_pad_clk_p; //Differential signal along with ref0_pad_clk_p. Reference clock bumped to SERDES. STAR connected at PKG with ref0_pad_clk_p
logic eref0_pad_clk_m; //Differential signal along with ref0_pad_clk_m. Reference clock bumped to SERDES. STAR connected at PKG with ref0_pad_clk_m
logic syncE_pad_clk_p; //Differential signal along with ref1_pad_clk_p. Reference clock bumped to SERDES. STAR connected at PKG with ref1_pad_clk_p
logic syncE_pad_clk_m; //Differential signal along with ref1_pad_clk_m. Reference clock bumped to SERDES. STAR connected at PKG with ref1_pad_clk_m
//logic rclk_diff_p; //on die differential signal _p
//logic rclk_diff_n; //on die differential signal _n
logic physs_clkobs_out_clk; //logic clock for observation
logic syscon_dfd_l0_dis; //l0 DFD security disable (1 = disable)
logic syscon_dfd_l1_dis; //l1 DFD security disable (1 = disable)
logic syscon_Int_only_l2_dis; //l2 DFD security disable (1 = disable)
logic ETH_TXP0; //Serdes analog transmit
logic ETH_TXN0; //Serdes analog transmit
logic ETH_TXP1; //Serdes analog transmit
logic ETH_TXN1; //Serdes analog transmit
logic ETH_TXP2; //Serdes analog transmit
logic ETH_TXN2; //Serdes analog transmit
logic ETH_TXP3; //Serdes analog transmit
logic ETH_TXN3; //Serdes analog transmit
logic ETH_TXP4; //Serdes analog transmit
logic ETH_TXN4; //Serdes analog transmit
logic ETH_TXP5; //Serdes analog transmit
logic ETH_TXN5; //Serdes analog transmit
logic ETH_TXP6; //Serdes analog transmit
logic ETH_TXN6; //Serdes analog transmit
logic ETH_TXP7; //Serdes analog transmit
logic ETH_TXN7; //Serdes analog transmit
logic ETH_RXP0; //Serdes analog receive
logic ETH_RXN0; //Serdes analog receive
logic ETH_RXP1; //Serdes analog receive
logic ETH_RXN1; //Serdes analog receive
logic ETH_RXP2; //Serdes analog receive
logic ETH_RXN2; //Serdes analog receive
logic ETH_RXP3; //Serdes analog receive
logic ETH_RXN3; //Serdes analog receive
logic ETH_RXP4; //Serdes analog receive
logic ETH_RXN4; //Serdes analog receive
logic ETH_RXP5; //Serdes analog receive
logic ETH_RXN5; //Serdes analog receive
logic ETH_RXP6; //Serdes analog receive
logic ETH_RXN6; //Serdes analog receive
logic ETH_RXP7; //Serdes analog receive
logic ETH_RXN7; //Serdes analog receive
logic ETH_TXP8; //Serdes analog transmit
logic ETH_TXN8; //Serdes analog transmit
logic ETH_TXP9; //Serdes analog transmit
logic ETH_TXN9; //Serdes analog transmit
logic ETH_TXP10; //Serdes analog transmit
logic ETH_TXN10; //Serdes analog transmit
logic ETH_TXP11; //Serdes analog transmit
logic ETH_TXN11; //Serdes analog transmit
logic ETH_TXP12; //Serdes analog transmit
logic ETH_TXN12; //Serdes analog transmit
logic ETH_TXP13; //Serdes analog transmit
logic ETH_TXN13; //Serdes analog transmit
logic ETH_TXP14; //Serdes analog transmit
logic ETH_TXN14; //Serdes analog transmit
logic ETH_TXP15; //Serdes analog transmit
logic ETH_TXN15; //Serdes analog transmit
logic ETH_RXP8; //Serdes analog receive
logic ETH_RXN8; //Serdes analog receive
logic ETH_RXP9; //Serdes analog receive
logic ETH_RXN9; //Serdes analog receive
logic ETH_RXP10; //Serdes analog receive
logic ETH_RXN10; //Serdes analog receive
logic ETH_RXP11; //Serdes analog receive
logic ETH_RXN11; //Serdes analog receive
logic ETH_RXP12; //Serdes analog receive
logic ETH_RXN12; //Serdes analog receive
logic ETH_RXP13; //Serdes analog receive
logic ETH_RXN13; //Serdes analog receive
logic ETH_RXP14; //Serdes analog receive
logic ETH_RXN14; //Serdes analog receive
logic ETH_RXP15; //Serdes analog receive
logic ETH_RXN15; //Serdes analog receive
logic [13:0] xioa_ck_pma_ref0_n; //Differential reference clock0 bump/pad. negative leg
logic [13:0] xioa_ck_pma_ref0_p; //Differential reference clock0 bump/pad. positive leg
logic [15:0] xioa_ck_pma_ref1_n; //Differential reference clock1 bump/pad. negative leg
logic [15:0] xioa_ck_pma_ref1_p; //Differential reference clock1 bump/pad. positive leg
logic [15:0] xoa_pma_dcmon1; //Aprobe bump /pad #1. Refer to aprobe recommendations section of the HAS
logic [15:0] xoa_pma_dcmon2; //Aprobe bump/pad #2. Refer to aprobe recommendations section of the HAS
logic [14:0] physs_0_AWID; //Write Address ID
logic [31:0] physs_0_AWADDR; //Write Address
logic [7:0] physs_0_AWLEN; //Burst Length
logic [2:0] physs_0_AWSIZE; //b
logic [1:0] physs_0_AWBURST; //Burst Type
logic physs_0_AWLOCK; //Lock Type
logic [3:0] physs_0_AWCACHE; //Memory Type
logic [2:0] physs_0_AWPROT; //Protection Type
logic [3:0] physs_0_AWQOS; //QoS
logic physs_0_AWUSER; //User-defined Signal. PHYSS does not have functional usage of this signal but it might be used for debug.
logic physs_0_AWVALID; //Write Address Valid
logic physs_0_AWREADY; //Write Address Readu
logic [31:0] physs_0_WDATA; //Write data
logic [3:0] physs_0_WSTRB; //Write strobe
logic physs_0_WLAST; //Write last
logic physs_0_WUSER; //User-defined signal. PHYSS does not have functional usage of this signal but it might be used for debug.
logic physs_0_WVALID; //Write valid
logic physs_0_WREADY; //Write ready
logic [14:0] physs_0_BID; //Response ID Tag
logic [1:0] physs_0_BRESP; //Write Response
logic physs_0_BVALID; //Write response valid
logic physs_0_BREADY; //Response ready
logic [14:0] physs_0_ARID; //Read Address ID
logic [31:0] physs_0_ARADDR; //Read Address
logic [7:0] physs_0_ARLEN; //Burst Length
logic [2:0] physs_0_ARSIZE; //Burst Size
logic [1:0] physs_0_ARBURST; //Burst Type
logic physs_0_ARLOCK; //Lock Type
logic [3:0] physs_0_ARCACHE; //Memory Type
logic [2:0] physs_0_ARPROT; //Protection Type
logic physs_0_ARVALID; //Read Address Valid
logic physs_0_ARREADY; //Read Address Ready
logic [14:0] physs_0_RID; //Read ID tag
logic [31:0] physs_0_RDATA; //Read data
logic [1:0] physs_0_RRESP; //Read response
logic physs_0_RLAST; //Read last
logic physs_0_RVALID; //Read valid
logic physs_0_RREADY; //Read ready
logic [14:0] physs_1_AWID; //Write Address ID
logic [31:0] physs_1_AWADDR; //Write Address
logic [7:0] physs_1_AWLEN; //Burst Length
logic [2:0] physs_1_AWSIZE; //b
logic [1:0] physs_1_AWBURST; //Burst Type
logic physs_1_AWLOCK; //Lock Type
logic [3:0] physs_1_AWCACHE; //Memory Type
logic [2:0] physs_1_AWPROT; //Protection Type
logic [3:0] physs_1_AWQOS; //QoS
logic physs_1_AWUSER; //User-defined Signal. PHYSS does not have functional usage of this signal but it might be used for debug.
logic physs_1_AWVALID; //Write Address Valid
logic physs_1_AWREADY; //Write Address Readu
logic [31:0] physs_1_WDATA; //Write data
logic [3:0] physs_1_WSTRB; //Write strobe
logic physs_1_WLAST; //Write last
logic physs_1_WUSER; //User-defined signal. PHYSS does not have functional usage of this signal but it might be used for debug.
logic physs_1_WVALID; //Write valid
logic physs_1_WREADY; //Write ready
logic [14:0] physs_1_BID; //Response ID Tag
logic [1:0] physs_1_BRESP; //Write Response
logic physs_1_BVALID; //Write response valid
logic physs_1_BREADY; //Response ready
logic [14:0] physs_1_ARID; //Read Address ID
logic [31:0] physs_1_ARADDR; //Read Address
logic [7:0] physs_1_ARLEN; //Burst Length
logic [2:0] physs_1_ARSIZE; //Burst Size
logic [1:0] physs_1_ARBURST; //Burst Type
logic physs_1_ARLOCK; //Lock Type
logic [3:0] physs_1_ARCACHE; //Memory Type
logic [2:0] physs_1_ARPROT; //Protection Type
logic physs_1_ARVALID; //Read Address Valid
logic physs_1_ARREADY; //Read Address Ready
logic [14:0] physs_1_RID; //Read ID tag
logic [31:0] physs_1_RDATA; //Read data
logic [1:0] physs_1_RRESP; //Read response
logic physs_1_RLAST; //Read last
logic physs_1_RVALID; //Read valid
logic physs_1_RREADY; //Read ready
logic physs_icq_port_0_link_stat; //indicate link UP status per port
logic [3:0] physs_mse_port_0_link_speed; //4 wires for each of 8 ports. Indicate speed when link UP status is asserted -per port.0 - 10Mbps1 - 100Mbps2 - 1Gbps3 - 2.5Gbps4 - 5Gbps5 - 10Gbps6 - Reserved7 - 25Gbps8 - 40Gbps9 - 50Gbps10 - 100Gbps11 - 200Gbps12 - 400Gbpsother - reserved.
logic physs_mse_port_0_rx_dval; //Receive Data Valid
logic [1023:0] physs_mse_port_0_rx_data; //receive data rx_data[1023:0] are valid in 400G mode or 200G mode at Port0. receive data rx_data[511:0] are valid in 200G mode at Port2/4. receive data rx_data[255:0] are valid in 100/50/25/10G mode. Port0 use 1024 bits for 400g. 512 bitsfor200g or 256 bits for 100g and lower speeds. Port2/4 use 512 bits for 200g or 256 bits for 100g and lower speeds. Ports 1/3/5/6/7 are always 256 bits data width
logic physs_mse_port_0_rx_sop; //Receive Start of Frame
logic physs_mse_port_0_rx_eop; //Receive End of Frame
logic [6:0] physs_mse_port_0_rx_mod; //Receive End Word Modulo. Only meaningful when eop signal is valid. Indicates which portion of the rx_data is valid. rx_mod[6:0] ( 400G / 200G Port0). 7'b0000000 : rx_data[1023:0] is valid. 7'b0000001 : rx_data[7:0] is valid. 7'b0000010 : rx_data[15:0] is valid. 7'b1111111:rx_data[1015:0] is valid. rx_mod[5:0] ( 200G ). 6'b000000 : rx_data[511:0] is valid. 6'b000001 : rx_data[7:0] is valid. 6'b000010 : rx_data[15:0] is valid. 6'b111111:rx_data[503:0] is valid. rx_mod[4:0] ( 100G or below ). 5'b00000 : rx_data[255:0] is valid. 5'b00001 : rx_data[7:0] is valid. 5'b00010 : rx_data[15:0] is valid. 5'b11111:rx_data[247:0] is valid
logic physs_mse_port_0_rx_err; //Receive frame error ( This is set when there is any type of error within the frame include L2 FCS Error )
logic physs_mse_port_0_rx_ecc_err; //Receive L2 FCS Error ( this bit is only set when there is L2 FCS error )
logic mse_physs_port_0_rx_rdy; //Receive Application Ready. Asserted (set to 1) by the Receive application to indicate it is ready to receive Data from the MAC. With the direct interface when the signal deasserts within frame receive the MAC will truncate the frame and eventually set receive frame error
logic [38:0] physs_mse_port_0_rx_ts; //Receive Timestamp Value. Time when the MAC detected the SFD of the frame and latched the mac00N_frc_in_rx value. Only meaningful when sop is valid. On ingress contains the 1588 ingress timestamp: Bits [39:8] - 32b timestamp in nano seconds. Bits [7:1] - 7b timestamp in sub-nano seconds. Bit 0 - 1b of valid for TIMESTAMP
logic mse_physs_port_0_tx_wren; //Transmit Data Write Enable
logic [1023:0] mse_physs_port_0_tx_data; //Transmit data rx_data[1023:0] are valid in 400G mode and 200G mode at Port 0. Transmit data rx_data[511:0] are valid in 200G mode at Ports2/4. Transmit data rx_data[255:0] are valid in 100/50/25/10G mode. Port0 use 1024 bits for 400g. 512 bits for 200g or 256 bits for 100g and lower speeds. Port2/4 use 512 bits for 200g or 256 bits for 100g and lower speeds. Ports 1/3/5/6/7 are always 256 bits data width
logic mse_physs_port_0_tx_sop; //Transmit Start of Frame
logic mse_physs_port_0_tx_eop; //Transmit End of Frame
logic [6:0] mse_physs_port_0_tx_mod; //Transmit End Word Modulo. Only meaningful when tx_eop is valid. Indicates which portion of the ff00N_tx_data is valid. tx_mod[6:0] (400G mode / 200G at Port0). 7'b000000 : tx_data[1023:0] is valid. 7'b000001 : tx_data[7:0] is valid. 7'b000010 : tx_data[15:0] is valid. 7'b111111 : tx_data[1015:0] is valid. tx_mod[5:0] ( 200G mode at Ports2/4 ). 6'b000000 : tx_data[511:0] is valid. 6'b000001 : tx_data[7:0] is valid. 6'b000010 : tx_data[15:0] is valid. 6'b111111:tx_data[503:0] is valid. tx_mod[4:0] ( 100G or below ). 5'b00000 : tx_data[255:0] is valid. 5'b00001 : tx_data[7:0] is valid. 5'b00010 : tx_data[15:0] is valid. 5'b11111 : tx_data[247:0] is valid
logic mse_physs_port_0_tx_err; //Transmit Frame Error. Asserted with the frames final segment to indicate that the transmitted frame is invalid. Only meaningful whentx_eopis valid. Whentx_erris asserted the frame is transmitted to the CDMII interface with a transmit error (invalid CRC)
logic mse_physs_port_0_tx_crc; //Transmit CRC Append. If set a CRC field the MAC will be appended to the frame. If cleared the MAC does not append a FCS to the frame
logic physs_mse_port_0_tx_rdy; //Transmit FIFO ready. mse can write words into the FIFO only when this signal is asserted (1). When 0 application should stop writing latest after 2 cycles
logic physs_icq_port_1_link_stat; //indicate link UP status per port
logic [3:0] physs_mse_port_1_link_speed; //4 wires for each of 8 ports. Indicate speed when link UP status is asserted -per port.0 - 10Mbps1 - 100Mbps2 - 1Gbps3 - 2.5Gbps4 - 5Gbps5 - 10Gbps6 - Reserved7 - 25Gbps8 - 40Gbps9 - 50Gbps10 - 100Gbps11 - 200Gbps12 - 400Gbpsother - reserved.
logic physs_mse_port_1_rx_dval; //Receive Data Valid
logic [1023:0] physs_mse_port_1_rx_data; //receive data rx_data[1023:0] are valid in 400G mode or 200G mode at Port0. receive data rx_data[511:0] are valid in 200G mode at Port2/4. receive data rx_data[255:0] are valid in 100/50/25/10G mode. Port0 use 1024 bits for 400g.512 bitsfor200gor 256 bits for 100g and lower speeds. Port2/4 use 512 bits for 200g or 256 bits for 100g and lower speeds. Ports 1/3/5/6/7 are always 256 bits data width
logic physs_mse_port_1_rx_sop; //Receive Start of Frame
logic physs_mse_port_1_rx_eop; //Receive End of Frame
logic [6:0] physs_mse_port_1_rx_mod; //Receive End Word Modulo. Only meaningful when eop signal is valid. Indicates which portion of the rx_data is valid. rx_mod[6:0] ( 400G / 200G Port0). 7'b0000000 : rx_data[1023:0] is valid. 7'b0000001 : rx_data[7:0] is valid. 7'b0000010 : rx_data[15:0] is valid. 7'b1111111:rx_data[1015:0] is valid. rx_mod[5:0] ( 200G ). 6'b000000 : rx_data[511:0] is valid. 6'b000001 : rx_data[7:0] is valid. 6'b000010 : rx_data[15:0] is valid. 6'b111111:rx_data[503:0] is valid. rx_mod[4:0] ( 100G or below ). 5'b00000 : rx_data[255:0] is valid. 5'b00001 : rx_data[7:0] is valid. 5'b00010 : rx_data[15:0] is valid. 5'b11111:rx_data[247:0] is valid
logic physs_mse_port_1_rx_err; //Receive frame error ( This is set when there is any type of error within the frame include L2 FCS Error )
logic physs_mse_port_1_rx_ecc_err; //Receive L2 FCS Error ( this bit is only set when there is L2 FCS error )
logic mse_physs_port_1_rx_rdy; //Receive Application Ready. Asserted (set to 1) by the Receive application to indicate it is ready to receive Data from the MAC. With the direct interface when the signal deasserts within frame receive the MAC will truncate the frame and eventually set receive frame error
logic [38:0] physs_mse_port_1_rx_ts; //Receive Timestamp Value. Time when the MAC detected the SFD of the frame and latched the mac00N_frc_in_rx value. Only meaningful when sop is valid. On ingress contains the 1588 ingress timestamp: Bits [39:8] - 32b timestamp in nano seconds. Bits [7:1] - 7b timestamp in sub-nano seconds. Bit 0 - 1b of valid for TIMESTAMP
logic mse_physs_port_1_tx_wren; //Transmit Data Write Enable
logic [1023:0] mse_physs_port_1_tx_data; //Transmit data rx_data[1023:0] are valid in 400G mode and 200G mode at Port 0. Transmit data rx_data[511:0] are valid in 200G mode at Ports2/4. Transmit data rx_data[255:0] are valid in 100/50/25/10G mode. Port0 use 1024 bits for 400g. 512 bits for 200g or 256 bits for 100g and lower speeds. Port2/4 use 512 bits for 200g or 256 bits for 100g and lower speeds. Ports 1/3/5/6/7 are always 256 bits data width
logic mse_physs_port_1_tx_sop; //Transmit Start of Frame
logic mse_physs_port_1_tx_eop; //Transmit End of Frame
logic [6:0] mse_physs_port_1_tx_mod; //Transmit End Word Modulo. Only meaningful when tx_eop is valid. Indicates which portion of the ff00N_tx_data is valid. tx_mod[6:0] (400G mode / 200G at Port0). 7'b000000 : tx_data[1023:0] is valid. 7'b000001 : tx_data[7:0] is valid. 7'b000010 : tx_data[15:0] is valid. 7'b111111 : tx_data[1015:0] is valid. tx_mod[5:0] ( 200G mode at Ports2/4 ). 6'b000000 : tx_data[511:0] is valid. 6'b000001 : tx_data[7:0] is valid. 6'b000010 : tx_data[15:0] is valid. 6'b111111:tx_data[503:0] is valid. tx_mod[4:0] ( 100G or below ). 5'b00000 : tx_data[255:0] is valid. 5'b00001 : tx_data[7:0] is valid. 5'b00010 : tx_data[15:0] is valid. 5'b11111 : tx_data[247:0] is valid
logic mse_physs_port_1_tx_err; //Transmit Frame Error. Asserted with the frames final segment to indicate that the transmitted frame is invalid. Only meaningful whentx_eopis valid. Whentx_erris asserted the frame is transmitted to the CDMII interface with a transmit error (invalid CRC)
logic mse_physs_port_1_tx_crc; //Transmit CRC Append. If set a CRC field the MAC will be appended to the frame. If cleared the MAC does not append a FCS to the frame
logic physs_mse_port_1_tx_rdy; //Transmit FIFO ready. mse can write words into the FIFO only when this signal is asserted (1). When 0 application should stop writing latest after 2 cycles
logic physs_icq_port_2_link_stat; //indicate link UP status per port
logic [3:0] physs_mse_port_2_link_speed; //4 wires for each of 8 ports. Indicate speed when link UP status is asserted -per port.0 - 10Mbps1 - 100Mbps2 - 1Gbps3 - 2.5Gbps4 - 5Gbps5 - 10Gbps6 - Reserved7 - 25Gbps8 - 40Gbps9 - 50Gbps10 - 100Gbps11 - 200Gbps12 - 400Gbpsother - reserved.
logic physs_mse_port_2_rx_dval; //Receive Data Valid
logic [1023:0] physs_mse_port_2_rx_data; //receive data rx_data[1023:0] are valid in 400G mode or 200G mode at Port0. receive data rx_data[511:0] are valid in 200G mode at Port2/4. receive data rx_data[255:0] are valid in 100/50/25/10G mode. Port0 use 1024 bits for 400g.512 bitsfor200gor 256 bits for 100g and lower speeds. Port2/4 use 512 bits for 200g or 256 bits for 100g and lower speeds. Ports 1/3/5/6/7 are always 256 bits data width
logic physs_mse_port_2_rx_sop; //Receive Start of Frame
logic physs_mse_port_2_rx_eop; //Receive End of Frame
logic [6:0] physs_mse_port_2_rx_mod; //Receive End Word Modulo. Only meaningful when eop signal is valid. Indicates which portion of the rx_data is valid. rx_mod[6:0] ( 400G / 200G Port0). 7'b0000000 : rx_data[1023:0] is valid. 7'b0000001 : rx_data[7:0] is valid. 7'b0000010 : rx_data[15:0] is valid. 7'b1111111:rx_data[1015:0] is valid. rx_mod[5:0] ( 200G ). 6'b000000 : rx_data[511:0] is valid. 6'b000001 : rx_data[7:0] is valid. 6'b000010 : rx_data[15:0] is valid. 6'b111111:rx_data[503:0] is valid. rx_mod[4:0] ( 100G or below ). 5'b00000 : rx_data[255:0] is valid. 5'b00001 : rx_data[7:0] is valid. 5'b00010 : rx_data[15:0] is valid. 5'b11111:rx_data[247:0] is valid
logic physs_mse_port_2_rx_err; //Receive frame error ( This is set when there is any type of error within the frame include L2 FCS Error )
logic physs_mse_port_2_rx_ecc_err; //Receive L2 FCS Error ( this bit is only set when there is L2 FCS error )
logic mse_physs_port_2_rx_rdy; //Receive Application Ready. Asserted (set to 1) by the Receive application to indicate it is ready to receive Data from the MAC. With the direct interface when the signal deasserts within frame receive the MAC will truncate the frame and eventually set receive frame error
logic [38:0] physs_mse_port_2_rx_ts; //Receive Timestamp Value. Time when the MAC detected the SFD of the frame and latched the mac00N_frc_in_rx value. Only meaningful when sop is valid. On ingress contains the 1588 ingress timestamp: Bits [39:8] - 32b timestamp in nano seconds. Bits [7:1] - 7b timestamp in sub-nano seconds. Bit 0 - 1b of valid for TIMESTAMP
logic mse_physs_port_2_tx_wren; //Transmit Data Write Enable
logic [1023:0] mse_physs_port_2_tx_data; //Transmit data rx_data[1023:0] are valid in 400G mode and 200G mode at Port 0. Transmit data rx_data[511:0] are valid in 200G mode at Ports2/4. Transmit data rx_data[255:0] are valid in 100/50/25/10G mode. Port0 use 1024 bits for 400g. 512 bits for 200g or 256 bits for 100g and lower speeds. Port2/4 use 512 bits for 200g or 256 bits for 100g and lower speeds. Ports 1/3/5/6/7 are always 256 bits data width
logic mse_physs_port_2_tx_sop; //Transmit Start of Frame
logic mse_physs_port_2_tx_eop; //Transmit End of Frame
logic [6:0] mse_physs_port_2_tx_mod; //Transmit End Word Modulo. Only meaningful when tx_eop is valid. Indicates which portion of the ff00N_tx_data is valid. tx_mod[6:0] (400G mode / 200G at Port0). 7'b000000 : tx_data[1023:0] is valid. 7'b000001 : tx_data[7:0] is valid. 7'b000010 : tx_data[15:0] is valid. 7'b111111 : tx_data[1015:0] is valid. tx_mod[5:0] ( 200G mode at Ports2/4 ). 6'b000000 : tx_data[511:0] is valid. 6'b000001 : tx_data[7:0] is valid. 6'b000010 : tx_data[15:0] is valid. 6'b111111:tx_data[503:0] is valid. tx_mod[4:0] ( 100G or below ). 5'b00000 : tx_data[255:0] is valid. 5'b00001 : tx_data[7:0] is valid. 5'b00010 : tx_data[15:0] is valid. 5'b11111 : tx_data[247:0] is valid
logic mse_physs_port_2_tx_err; //Transmit Frame Error. Asserted with the frames final segment to indicate that the transmitted frame is invalid. Only meaningful whentx_eopis valid. Whentx_erris asserted the frame is transmitted to the CDMII interface with a transmit error (invalid CRC)
logic mse_physs_port_2_tx_crc; //Transmit CRC Append. If set a CRC field the MAC will be appended to the frame. If cleared the MAC does not append a FCS to the frame
logic physs_mse_port_2_tx_rdy; //Transmit FIFO ready. mse can write words into the FIFO only when this signal is asserted (1). When 0 application should stop writing latest after 2 cycles
logic physs_icq_port_3_link_stat; //indicate link UP status per port
logic [3:0] physs_mse_port_3_link_speed; //4 wires for each of 8 ports. Indicate speed when link UP status is asserted -per port.0 - 10Mbps1 - 100Mbps2 - 1Gbps3 - 2.5Gbps4 - 5Gbps5 - 10Gbps6 - Reserved7 - 25Gbps8 - 40Gbps9 - 50Gbps10 - 100Gbps11 - 200Gbps12 - 400Gbpsother - reserved.
logic physs_mse_port_3_rx_dval; //Receive Data Valid
logic [1023:0] physs_mse_port_3_rx_data; //receive data rx_data[1023:0] are valid in 400G mode or 200G mode at Port0. receive data rx_data[511:0] are valid in 200G mode at Port2/4. receive data rx_data[255:0] are valid in 100/50/25/10G mode. Port0 use 1024 bits for 400g.512 bitsfor200gor 256 bits for 100g and lower speeds. Port2/4 use 512 bits for 200g or 256 bits for 100g and lower speeds. Ports 1/3/5/6/7 are always 256 bits data width
logic physs_mse_port_3_rx_sop; //Receive Start of Frame
logic physs_mse_port_3_rx_eop; //Receive End of Frame
logic [6:0] physs_mse_port_3_rx_mod; //Receive End Word Modulo. Only meaningful when eop signal is valid. Indicates which portion of the rx_data is valid. rx_mod[6:0] ( 400G / 200G Port0). 7'b0000000 : rx_data[1023:0] is valid. 7'b0000001 : rx_data[7:0] is valid. 7'b0000010 : rx_data[15:0] is valid. 7'b1111111:rx_data[1015:0] is valid. rx_mod[5:0] ( 200G ). 6'b000000 : rx_data[511:0] is valid. 6'b000001 : rx_data[7:0] is valid. 6'b000010 : rx_data[15:0] is valid. 6'b111111:rx_data[503:0] is valid. rx_mod[4:0] ( 100G or below ). 5'b00000 : rx_data[255:0] is valid. 5'b00001 : rx_data[7:0] is valid. 5'b00010 : rx_data[15:0] is valid. 5'b11111:rx_data[247:0] is valid
logic physs_mse_port_3_rx_err; //Receive frame error ( This is set when there is any type of error within the frame include L2 FCS Error )
logic physs_mse_port_3_rx_ecc_err; //Receive L2 FCS Error ( this bit is only set when there is L2 FCS error )
logic mse_physs_port_3_rx_rdy; //Receive Application Ready. Asserted (set to 1) by the Receive application to indicate it is ready to receive Data from the MAC. With the direct interface. when the signal deasserts within frame receive the MAC will truncate the frame and eventually set receive frame error
logic [38:0] physs_mse_port_3_rx_ts; //Receive Timestamp Value. Time when the MAC detected the SFD of the frame and latched the mac00N_frc_in_rx value. Only meaningful when sop is valid. On ingress contains the 1588 ingress timestamp: Bits [39:8] - 32b timestamp in nano seconds. Bits [7:1] - 7b timestamp in sub-nano seconds. Bit 0 - 1b of valid for TIMESTAMP
logic mse_physs_port_3_tx_wren; //Transmit Data Write Enable
logic [1023:0] mse_physs_port_3_tx_data; //Transmit data rx_data[1023:0] are valid in 400G mode and 200G mode at Port 0. Transmit data rx_data[511:0] are valid in 200G mode at Ports2/4. Transmit data rx_data[255:0] are valid in 100/50/25/10G mode. Port0 use 1024 bits for 400g. 512 bits for 200g or 256 bits for 100g and lower speeds. Port2/4 use 512 bits for 200g or 256 bits for 100g and lower speeds. Ports 1/3/5/6/7 are always 256 bits data width
logic mse_physs_port_3_tx_sop; //Transmit Start of Frame
logic mse_physs_port_3_tx_eop; //Transmit End of Frame
logic [6:0] mse_physs_port_3_tx_mod; //Transmit End Word Modulo. Only meaningful when tx_eop is valid. Indicates which portion of the ff00N_tx_data is valid. tx_mod[6:0] (400G mode / 200G at Port0). 7'b000000 : tx_data[1023:0] is valid. 7'b000001 : tx_data[7:0] is valid. 7'b000010 : tx_data[15:0] is valid. 7'b111111 : tx_data[1015:0] is valid. tx_mod[5:0] ( 200G mode at Ports2/4 ). 6'b000000 : tx_data[511:0] is valid. 6'b000001 : tx_data[7:0] is valid. 6'b000010 : tx_data[15:0] is valid. 6'b111111:tx_data[503:0] is valid. tx_mod[4:0] ( 100G or below ). 5'b00000 : tx_data[255:0] is valid. 5'b00001 : tx_data[7:0] is valid. 5'b00010 : tx_data[15:0] is valid. 5'b11111 : tx_data[247:0] is valid
logic mse_physs_port_3_tx_err; //Transmit Frame Error. Asserted with the frames final segment to indicate that the transmitted frame is invalid. Only meaningful whentx_eopis valid. Whentx_erris asserted. the frame is transmitted to the CDMII interface with a transmit error (invalid CRC)
logic mse_physs_port_3_tx_crc; //Transmit CRC Append. If set a CRC field the MAC will be appended to the frame. If cleared the MAC does not append a FCS to the frame
logic physs_mse_port_3_tx_rdy; //Transmit FIFO ready. mse can write words into the FIFO only when this signal is asserted (1). When 0 application should stop writing latest after 2 cycles
logic physs_icq_port_4_link_stat; //indicate link UP status per port
logic [3:0] physs_mse_port_4_link_speed; //4 wires for each of 8 ports. Indicate speed when link UP status is asserted -per port.0 - 10Mbps1 - 100Mbps2 - 1Gbps3 - 2.5Gbps4 - 5Gbps5 - 10Gbps6 - Reserved7 - 25Gbps8 - 40Gbps9 - 50Gbps10 - 100Gbps11 - 200Gbps12 - 400Gbpsother - reserved.
logic physs_mse_port_4_rx_dval; //Receive Data Valid
logic [1023:0] physs_mse_port_4_rx_data; //receive data rx_data[1023:0] are valid in 400G mode or 200G mode at Port0. receive data rx_data[511:0] are valid in 200G mode at Port2/4. receive data rx_data[255:0] are valid in 100/50/25/10G mode. Port0 use 1024 bits for 400g.512 bitsfor200gor 256 bits for 100g and lower speeds. Port2/4 use 512 bits for 200g or 256 bits for 100g and lower speeds. Ports 1/3/5/6/7 are always 256 bits data width
logic physs_mse_port_4_rx_sop; //Receive Start of Frame
logic physs_mse_port_4_rx_eop; //Receive End of Frame
logic [6:0] physs_mse_port_4_rx_mod; //Receive End Word Modulo. Only meaningful when eop signal is valid. Indicates which portion of the rx_data is valid. rx_mod[6:0] ( 400G / 200G Port0). 7'b0000000 : rx_data[1023:0] is valid. 7'b0000001 : rx_data[7:0] is valid. 7'b0000010 : rx_data[15:0] is valid. 7'b1111111:rx_data[1015:0] is valid. rx_mod[5:0] ( 200G ). 6'b000000 : rx_data[511:0] is valid. 6'b000001 : rx_data[7:0] is valid. 6'b000010 : rx_data[15:0] is valid. 6'b111111:rx_data[503:0] is valid. rx_mod[4:0] ( 100G or below ). 5'b00000 : rx_data[255:0] is valid. 5'b00001 : rx_data[7:0] is valid. 5'b00010 : rx_data[15:0] is valid. 5'b11111:rx_data[247:0] is valid
logic physs_mse_port_4_rx_err; //Receive frame error ( This is set when there is any type of error within the frame include L2 FCS Error )
logic physs_mse_port_4_rx_ecc_err; //Receive L2 FCS Error ( this bit is only set when there is L2 FCS error )
logic mse_physs_port_4_rx_rdy; //Receive Application Ready. Asserted (set to 1) by the Receive application to indicate it is ready to receive Data from the MAC. With the direct interface. when the signal deasserts within frame receive the MAC will truncate the frame and eventually set receive frame error
logic [38:0] physs_mse_port_4_rx_ts; //Receive Timestamp Value. Time when the MAC detected the SFD of the frame and latched the mac00N_frc_in_rx value. Only meaningful when sop is valid. On ingress contains the 1588 ingress timestamp: Bits [39:8] - 32b timestamp in nano seconds. Bits [7:1] - 7b timestamp in sub-nano seconds. Bit 0 - 1b of valid for TIMESTAMP
logic mse_physs_port_4_tx_wren; //Transmit Data Write Enable
logic [1023:0] mse_physs_port_4_tx_data; //Transmit data rx_data[1023:0] are valid in 400G mode and 200G mode at Port 0. Transmit data rx_data[511:0] are valid in 200G mode at Ports2/4. Transmit data rx_data[255:0] are valid in 100/50/25/10G mode. Port0 use 1024 bits for 400g. 512 bits for 200g or 256 bits for 100g and lower speeds. Port2/4 use 512 bits for 200g or 256 bits for 100g and lower speeds. Ports 1/3/5/6/7 are always 256 bits data width
logic mse_physs_port_4_tx_sop; //Transmit Start of Frame
logic mse_physs_port_4_tx_eop; //Transmit End of Frame
logic [6:0] mse_physs_port_4_tx_mod; //Transmit End Word Modulo. Only meaningful when tx_eop is valid. Indicates which portion of the ff00N_tx_data is valid. tx_mod[6:0] (400G mode / 200G at Port0). 7'b000000 : tx_data[1023:0] is valid. 7'b000001 : tx_data[7:0] is valid. 7'b000010 : tx_data[15:0] is valid. 7'b111111 : tx_data[1015:0] is valid. tx_mod[5:0] ( 200G mode at Ports2/4 ). 6'b000000 : tx_data[511:0] is valid. 6'b000001 : tx_data[7:0] is valid. 6'b000010 : tx_data[15:0] is valid. 6'b111111:tx_data[503:0] is valid. tx_mod[4:0] ( 100G or below ). 5'b00000 : tx_data[255:0] is valid. 5'b00001 : tx_data[7:0] is valid. 5'b00010 : tx_data[15:0] is valid. 5'b11111 : tx_data[247:0] is valid
logic mse_physs_port_4_tx_err; //Transmit Frame Error. Asserted with the frames final segment to indicate that the transmitted frame is invalid. Only meaningful whentx_eopis valid. Whentx_erris asserted. the frame is transmitted to the CDMII interface with a transmit error (invalid CRC)
logic mse_physs_port_4_tx_crc; //Transmit CRC Append. If set a CRC field the MAC will be appended to the frame. If cleared the MAC does not append a FCS to the frame
logic physs_mse_port_4_tx_rdy; //Transmit FIFO ready. mse can write words into the FIFO only when this signal is asserted (1). When 0 application should stop writing latest after 2 cycles
logic physs_icq_port_5_link_stat; //indicate link UP status per port
logic [3:0] physs_mse_port_5_link_speed; //4 wires for each of 8 ports. Indicate speed when link UP status is asserted -per port.0 - 10Mbps1 - 100Mbps2 - 1Gbps3 - 2.5Gbps4 - 5Gbps5 - 10Gbps6 - Reserved7 - 25Gbps8 - 40Gbps9 - 50Gbps10 - 100Gbps11 - 200Gbps12 - 400Gbpsother - reserved.
logic physs_mse_port_5_rx_dval; //Receive Data Valid
logic [1023:0] physs_mse_port_5_rx_data; //receive data rx_data[1023:0] are valid in 400G mode or 200G mode at Port0. receive data rx_data[511:0] are valid in 200G mode at Port2/4. receive data rx_data[255:0] are valid in 100/50/25/10G mode. Port0 use 1024 bits for 400g.512 bitsfor200gor 256 bits for 100g and lower speeds. Port2/4 use 512 bits for 200g or 256 bits for 100g and lower speeds. Ports 1/3/5/6/7 are always 256 bits data width
logic physs_mse_port_5_rx_sop; //Receive Start of Frame
logic physs_mse_port_5_rx_eop; //Receive End of Frame
logic [6:0] physs_mse_port_5_rx_mod; //Receive End Word Modulo. Only meaningful when eop signal is valid. Indicates which portion of the rx_data is valid. rx_mod[6:0] ( 400G / 200G Port0). 7'b0000000 : rx_data[1023:0] is valid. 7'b0000001 : rx_data[7:0] is valid. 7'b0000010 : rx_data[15:0] is valid. 7'b1111111:rx_data[1015:0] is valid. rx_mod[5:0] ( 200G ). 6'b000000 : rx_data[511:0] is valid. 6'b000001 : rx_data[7:0] is valid. 6'b000010 : rx_data[15:0] is valid. 6'b111111:rx_data[503:0] is valid. rx_mod[4:0] ( 100G or below ). 5'b00000 : rx_data[255:0] is valid. 5'b00001 : rx_data[7:0] is valid. 5'b00010 : rx_data[15:0] is valid. 5'b11111:rx_data[247:0] is valid
logic physs_mse_port_5_rx_err; //Receive frame error ( This is set when there is any type of error within the frame include L2 FCS Error )
logic physs_mse_port_5_rx_ecc_err; //Receive L2 FCS Error ( this bit is only set when there is L2 FCS error )
logic mse_physs_port_5_rx_rdy; //Receive Application Ready. Asserted (set to 1) by the Receive application to indicate it is ready to receive Data from the MAC. With the direct interface when the signal deasserts within frame receive the MAC will truncate the frame and eventually set receive frame error
logic [38:0] physs_mse_port_5_rx_ts; //Receive Timestamp Value. Time when the MAC detected the SFD of the frame and latched the mac00N_frc_in_rx value. Only meaningful when sop is valid. On ingress contains the 1588 ingress timestamp: Bits [39:8] - 32b timestamp in nano seconds. Bits [7:1] - 7b timestamp in sub-nano seconds. Bit 0 - 1b of valid for TIMESTAMP
logic mse_physs_port_5_tx_wren; //Transmit Data Write Enable
logic [1023:0] mse_physs_port_5_tx_data; //Transmit data rx_data[1023:0] are valid in 400G mode and 200G mode at Port 0. Transmit data rx_data[511:0] are valid in 200G mode at Ports2/4. Transmit data rx_data[255:0] are valid in 100/50/25/10G mode. Port0 use 1024 bits for 400g 512 bits for 200g or 256 bits for 100g and lower speeds. Port2/4 use 512 bits for 200g or 256 bits for 100g and lower speeds. Ports 1/3/5/6/7 are always 256 bits data width
logic mse_physs_port_5_tx_sop; //Transmit Start of Frame
logic mse_physs_port_5_tx_eop; //Transmit End of Frame
logic [6:0] mse_physs_port_5_tx_mod; //Transmit End Word Modulo. Only meaningful when tx_eop is valid. Indicates which portion of the ff00N_tx_data is valid. tx_mod[6:0] (400G mode / 200G at Port0). 7'b000000 : tx_data[1023:0] is valid. 7'b000001 : tx_data[7:0] is valid. 7'b000010 : tx_data[15:0] is valid. 7'b111111 : tx_data[1015:0] is valid. tx_mod[5:0] ( 200G mode at Ports2/4 ). 6'b000000 : tx_data[511:0] is valid. 6'b000001 : tx_data[7:0] is valid. 6'b000010 : tx_data[15:0] is valid. 6'b111111:tx_data[503:0] is valid. tx_mod[4:0] ( 100G or below ). 5'b00000 : tx_data[255:0] is valid. 5'b00001 : tx_data[7:0] is valid. 5'b00010 : tx_data[15:0] is valid. 5'b11111 : tx_data[247:0] is valid
logic mse_physs_port_5_tx_err; //Transmit Frame Error. Asserted with the frames final segment to indicate that the transmitted frame is invalid. Only meaningful whentx_eopis valid. Whentx_erris asserted the frame is transmitted to the CDMII interface with a transmit error (invalid CRC)
logic mse_physs_port_5_tx_crc; //Transmit CRC Append. If set a CRC field the MAC will be appended to the frame. If cleared the MAC does not append a FCS to the frame
logic physs_mse_port_5_tx_rdy; //Transmit FIFO ready. mse can write words into the FIFO only when this signal is asserted (1). When 0 application should stop writing latest after 2 cycles
logic physs_icq_port_6_link_stat; //indicate link UP status per port
logic [3:0] physs_mse_port_6_link_speed; //4 wires for each of 8 ports. Indicate speed when link UP status is asserted -per port.0 - 10Mbps1 - 100Mbps2 - 1Gbps3 - 2.5Gbps4 - 5Gbps5 - 10Gbps6 - Reserved7 - 25Gbps8 - 40Gbps9 - 50Gbps10 - 100Gbps11 - 200Gbps12 - 400Gbpsother - reserved.
logic physs_mse_port_6_rx_dval; //Receive Data Valid
logic [1023:0] physs_mse_port_6_rx_data; //receive data rx_data[1023:0] are valid in 400G mode or 200G mode at Port0. receive data rx_data[511:0] are valid in 200G mode at Port2/4. receive data rx_data[255:0] are valid in 100/50/25/10G mode. Port0 use 1024 bits for 400g512 bitsfor200gor 256 bits for 100g and lower speeds. Port2/4 use 512 bits for 200g or 256 bits for 100g and lower speeds. Ports 1/3/5/6/7 are always 256 bits data width
logic physs_mse_port_6_rx_sop; //Receive Start of Frame
logic physs_mse_port_6_rx_eop; //Receive End of Frame
logic [6:0] physs_mse_port_6_rx_mod; //Receive End Word Modulo. Only meaningful when eop signal is valid. Indicates which portion of the rx_data is valid. rx_mod[6:0] ( 400G / 200G Port0). 7'b0000000 : rx_data[1023:0] is valid. 7'b0000001 : rx_data[7:0] is valid. 7'b0000010 : rx_data[15:0] is valid. 7'b1111111:rx_data[1015:0] is valid. rx_mod[5:0] ( 200G ). 6'b000000 : rx_data[511:0] is valid. 6'b000001 : rx_data[7:0] is valid. 6'b000010 : rx_data[15:0] is valid. 6'b111111:rx_data[503:0] is valid. rx_mod[4:0] ( 100G or below ). 5'b00000 : rx_data[255:0] is valid. 5'b00001 : rx_data[7:0] is valid. 5'b00010 : rx_data[15:0] is valid. 5'b11111:rx_data[247:0] is valid
logic physs_mse_port_6_rx_err; //Receive frame error ( This is set when there is any type of error within the frame include L2 FCS Error )
logic physs_mse_port_6_rx_ecc_err; //Receive L2 FCS Error ( this bit is only set when there is L2 FCS error )
logic mse_physs_port_6_rx_rdy; //Receive Application Ready. Asserted (set to 1) by the Receive application to indicate it is ready to receive Data from the MAC. With the direct interface when the signal deasserts within frame receive the MAC will truncate the frame and eventually set receive frame error
logic [38:0] physs_mse_port_6_rx_ts; //Receive Timestamp Value. Time when the MAC detected the SFD of the frame and latched the mac00N_frc_in_rx value. Only meaningful when sop is valid. On ingress contains the 1588 ingress timestamp: Bits [39:8] - 32b timestamp in nano seconds. Bits [7:1] - 7b timestamp in sub-nano seconds. Bit 0 - 1b of valid for TIMESTAMP
logic mse_physs_port_6_tx_wren; //Transmit Data Write Enable
logic [1023:0] mse_physs_port_6_tx_data; //Transmit data rx_data[1023:0] are valid in 400G mode and 200G mode at Port 0. Transmit data rx_data[511:0] are valid in 200G mode at Ports2/4. Transmit data rx_data[255:0] are valid in 100/50/25/10G mode. Port0 use 1024 bits for 400g 512 bits for 200g or 256 bits for 100g and lower speeds. Port2/4 use 512 bits for 200g or 256 bits for 100g and lower speeds. Ports 1/3/5/6/7 are always 256 bits data width
logic mse_physs_port_6_tx_sop; //Transmit Start of Frame
logic mse_physs_port_6_tx_eop; //Transmit End of Frame
logic [6:0] mse_physs_port_6_tx_mod; //Transmit End Word Modulo. Only meaningful when tx_eop is valid. Indicates which portion of the ff00N_tx_data is valid. tx_mod[6:0] (400G mode / 200G at Port0). 7'b000000 : tx_data[1023:0] is valid. 7'b000001 : tx_data[7:0] is valid. 7'b000010 : tx_data[15:0] is valid. 7'b111111 : tx_data[1015:0] is valid. tx_mod[5:0] ( 200G mode at Ports2/4 ). 6'b000000 : tx_data[511:0] is valid. 6'b000001 : tx_data[7:0] is valid. 6'b000010 : tx_data[15:0] is valid. 6'b111111:tx_data[503:0] is valid. tx_mod[4:0] ( 100G or below ). 5'b00000 : tx_data[255:0] is valid. 5'b00001 : tx_data[7:0] is valid. 5'b00010 : tx_data[15:0] is valid. 5'b11111 : tx_data[247:0] is valid
logic mse_physs_port_6_tx_err; //Transmit Frame Error. Asserted with the frames final segment to indicate that the transmitted frame is invalid. Only meaningful whentx_eopis valid. Whentx_erris asserted the frame is transmitted to the CDMII interface with a transmit error (invalid CRC)
logic mse_physs_port_6_tx_crc; //Transmit CRC Append. If set a CRC field the MAC will be appended to the frame. If cleared the MAC does not append a FCS to the frame
logic physs_mse_port_6_tx_rdy; //Transmit FIFO ready. mse can write words into the FIFO only when this signal is asserted (1). When 0 application should stop writing latest after 2 cycles
logic physs_icq_port_7_link_stat; //indicate link UP status per port
logic [3:0] physs_mse_port_7_link_speed; //4 wires for each of 8 ports. Indicate speed when link UP status is asserted -per port.0 - 10Mbps1 - 100Mbps2 - 1Gbps3 - 2.5Gbps4 - 5Gbps5 - 10Gbps6 - Reserved7 - 25Gbps8 - 40Gbps9 - 50Gbps10 - 100Gbps11 - 200Gbps12 - 400Gbpsother - reserved.
logic physs_mse_port_7_rx_dval; //Receive Data Valid
logic [1023:0] physs_mse_port_7_rx_data; //receive data rx_data[1023:0] are valid in 400G mode or 200G mode at Port0. receive data rx_data[511:0] are valid in 200G mode at Port2/4. receive data rx_data[255:0] are valid in 100/50/25/10G mode. Port0 use 1024 bits for 400g512 bitsfor200gor 256 bits for 100g and lower speeds. Port2/4 use 512 bits for 200g or 256 bits for 100g and lower speeds. Ports 1/3/5/6/7 are always 256 bits data width
logic physs_mse_port_7_rx_sop; //Receive Start of Frame
logic physs_mse_port_7_rx_eop; //Receive End of Frame
logic [6:0] physs_mse_port_7_rx_mod; //Receive End Word Modulo. Only meaningful when eop signal is valid. Indicates which portion of the rx_data is valid. rx_mod[6:0] ( 400G / 200G Port0). 7'b0000000 : rx_data[1023:0] is valid. 7'b0000001 : rx_data[7:0] is valid. 7'b0000010 : rx_data[15:0] is valid. 7'b1111111:rx_data[1015:0] is valid. rx_mod[5:0] ( 200G ). 6'b000000 : rx_data[511:0] is valid. 6'b000001 : rx_data[7:0] is valid. 6'b000010 : rx_data[15:0] is valid. 6'b111111:rx_data[503:0] is valid. rx_mod[4:0] ( 100G or below ). 5'b00000 : rx_data[255:0] is valid. 5'b00001 : rx_data[7:0] is valid. 5'b00010 : rx_data[15:0] is valid. 5'b11111:rx_data[247:0] is valid
logic physs_mse_port_7_rx_err; //Receive frame error ( This is set when there is any type of error within the frame include L2 FCS Error )
logic physs_mse_port_7_rx_ecc_err; //Receive L2 FCS Error ( this bit is only set when there is L2 FCS error )
logic mse_physs_port_7_rx_rdy; //Receive Application Ready. Asserted (set to 1) by the Receive application to indicate it is ready to receive Data from the MAC. With the direct interface when the signal deasserts within frame receive the MAC will truncate the frame and eventually set receive frame error
logic [38:0] physs_mse_port_7_rx_ts; //Receive Timestamp Value. Time when the MAC detected the SFD of the frame and latched the mac00N_frc_in_rx value. Only meaningful when sop is valid. On ingress contains the 1588 ingress timestamp: Bits [39:8] - 32b timestamp in nano seconds. Bits [7:1] - 7b timestamp in sub-nano seconds. Bit 0 - 1b of valid for TIMESTAMP
logic mse_physs_port_7_tx_wren; //Transmit Data Write Enable
logic [1023:0] mse_physs_port_7_tx_data; //Transmit data rx_data[1023:0] are valid in 400G mode and 200G mode at Port 0. Transmit data rx_data[511:0] are valid in 200G mode at Ports2/4. Transmit data rx_data[255:0] are valid in 100/50/25/10G mode. Port0 use 1024 bits for 400g 512 bits for 200g or 256 bits for 100g and lower speeds. Port2/4 use 512 bits for 200g or 256 bits for 100g and lower speeds. Ports 1/3/5/6/7 are always 256 bits data width
logic mse_physs_port_7_tx_sop; //Transmit Start of Frame
logic mse_physs_port_7_tx_eop; //Transmit End of Frame
logic [6:0] mse_physs_port_7_tx_mod; //Transmit End Word Modulo. Only meaningful when tx_eop is valid. Indicates which portion of the ff00N_tx_data is valid. tx_mod[6:0] (400G mode / 200G at Port0). 7'b000000 : tx_data[1023:0] is valid. 7'b000001 : tx_data[7:0] is valid. 7'b000010 : tx_data[15:0] is valid. 7'b111111 : tx_data[1015:0] is valid. tx_mod[5:0] ( 200G mode at Ports2/4 ). 6'b000000 : tx_data[511:0] is valid. 6'b000001 : tx_data[7:0] is valid. 6'b000010 : tx_data[15:0] is valid. 6'b111111:tx_data[503:0] is valid. tx_mod[4:0] ( 100G or below ). 5'b00000 : tx_data[255:0] is valid. 5'b00001 : tx_data[7:0] is valid. 5'b00010 : tx_data[15:0] is valid. 5'b11111 : tx_data[247:0] is valid
logic mse_physs_port_7_tx_err; //Transmit Frame Error. Asserted with the frames final segment to indicate that the transmitted frame is invalid. Only meaningful whentx_eopis valid. Whentx_erris asserted the frame is transmitted to the CDMII interface with a transmit error (invalid CRC)
logic mse_physs_port_7_tx_crc; //Transmit CRC Append. If set a CRC field the MAC will be appended to the frame. If cleared the MAC does not append a FCS to the frame
logic physs_mse_port_7_tx_rdy; //Transmit FIFO ready. mse can write words into the FIFO only when this signal is asserted (1). When 0 application should stop writing latest after 2 cycles
logic hlp_xlgmii0_txclk_ena_0; //XLGMII Interface to HMAC
logic hlp_xlgmii0_rxclk_ena_0; //XLGMII Interface to HMAC
logic [7:0] hlp_xlgmii0_rxc_0; //XLGMII Interface to HMAC
logic [63:0] hlp_xlgmii0_rxd_0; //XLGMII Interface to HMAC
logic hlp_xlgmii0_rxt0_next_0; //XLGMII Interface to HMAC
logic [7:0] hlp_xlgmii0_txc_0; //XLGMII Interface to HMAC
logic [63:0] hlp_xlgmii0_txd_0; //XLGMII Interface to HMAC
logic hlp_xlgmii1_txclk_ena_0; //XLGMII Interface to HMAC
logic hlp_xlgmii1_rxclk_ena_0; //XLGMII Interface to HMAC
logic [7:0] hlp_xlgmii1_rxc_0; //XLGMII Interface to HMAC
logic [63:0] hlp_xlgmii1_rxd_0; //XLGMII Interface to HMAC
logic hlp_xlgmii1_rxt0_next_0; //XLGMII Interface to HMAC
logic [7:0] hlp_xlgmii1_txc_0; //XLGMII Interface to HMAC
logic [63:0] hlp_xlgmii1_txd_0; //XLGMII Interface to HMAC
logic hlp_xlgmii2_txclk_ena_0; //XLGMII Interface to HMAC
logic hlp_xlgmii2_rxclk_ena_0; //XLGMII Interface to HMAC
logic [7:0] hlp_xlgmii2_rxc_0; //XLGMII Interface to HMAC
logic [63:0] hlp_xlgmii2_rxd_0; //XLGMII Interface to HMAC
logic hlp_xlgmii2_rxt0_next_0; //XLGMII Interface to HMAC
logic [7:0] hlp_xlgmii2_txc_0; //XLGMII Interface to HMAC
logic [63:0] hlp_xlgmii2_txd_0; //XLGMII Interface to HMAC
logic hlp_xlgmii3_txclk_ena_0; //XLGMII Interface to HMAC
logic hlp_xlgmii3_rxclk_ena_0; //XLGMII Interface to HMAC
logic [7:0] hlp_xlgmii3_rxc_0; //XLGMII Interface to HMAC
logic [63:0] hlp_xlgmii3_rxd_0; //XLGMII Interface to HMAC
logic hlp_xlgmii3_rxt0_next_0; //XLGMII Interface to HMAC
logic [7:0] hlp_xlgmii3_txc_0; //XLGMII Interface to HMAC
logic [63:0] hlp_xlgmii3_txd_0; //XLGMII Interface to HMAC
logic [127:0] hlp_cgmii0_rxd_0; //CGMII Interface to HMAC
logic [15:0] hlp_cgmii0_rxc_0; //CGMII Interface to HMAC
logic hlp_cgmii0_rxclk_ena_0; //CGMII Interface to HMAC
logic [127:0] hlp_cgmii0_txd_0; //CGMII Interface to HMAC
logic [15:0] hlp_cgmii0_txc_0; //CGMII Interface to HMAC
logic hlp_cgmii0_txclk_ena_0; //CGMII Interface to HMAC
logic [127:0] hlp_cgmii1_rxd_0; //CGMII Interface to HMAC
logic [15:0] hlp_cgmii1_rxc_0; //CGMII Interface to HMAC
logic hlp_cgmii1_rxclk_ena_0; //CGMII Interface to HMAC
logic [127:0] hlp_cgmii1_txd_0; //CGMII Interface to HMAC
logic [15:0] hlp_cgmii1_txc_0; //CGMII Interface to HMAC
logic hlp_cgmii1_txclk_ena_0; //CGMII Interface to HMAC
logic [127:0] hlp_cgmii2_rxd_0; //CGMII Interface to HMAC
logic [15:0] hlp_cgmii2_rxc_0; //CGMII Interface to HMAC
logic hlp_cgmii2_rxclk_ena_0; //CGMII Interface to HMAC
logic [127:0] hlp_cgmii2_txd_0; //CGMII Interface to HMAC
logic [15:0] hlp_cgmii2_txc_0; //CGMII Interface to HMAC
logic hlp_cgmii2_txclk_ena_0; //CGMII Interface to HMAC
logic [127:0] hlp_cgmii3_rxd_0; //CGMII Interface to HMAC
logic [15:0] hlp_cgmii3_rxc_0; //CGMII Interface to HMAC
logic hlp_cgmii3_rxclk_ena_0; //CGMII Interface to HMAC
logic [127:0] hlp_cgmii3_txd_0; //CGMII Interface to HMAC
logic [15:0] hlp_cgmii3_txc_0; //CGMII Interface to HMAC
logic hlp_cgmii3_txclk_ena_0; //CGMII Interface to HMAC
logic hlp_xlgmii0_txclk_ena_nss_0; //XLGMII Interface to NSS
logic hlp_xlgmii0_rxclk_ena_nss_0; //XLGMII Interface to NSS
logic [7:0] hlp_xlgmii0_rxc_nss_0; //XLGMII Interface to NSS
logic [63:0] hlp_xlgmii0_rxd_nss_0; //XLGMII Interface to NSS
logic hlp_xlgmii0_rxt0_next_nss_0; //XLGMII Interface to NSS
logic [7:0] hlp_xlgmii0_txc_nss_0; //XLGMII Interface to NSS
logic [63:0] hlp_xlgmii0_txd_nss_0; //XLGMII Interface to NSS
logic hlp_xlgmii1_txclk_ena_nss_0; //XLGMII Interface to NSS
logic hlp_xlgmii1_rxclk_ena_nss_0; //XLGMII Interface to NSS
logic [7:0] hlp_xlgmii1_rxc_nss_0; //XLGMII Interface to NSS
logic [63:0] hlp_xlgmii1_rxd_nss_0; //XLGMII Interface to NSS
logic hlp_xlgmii1_rxt0_next_nss_0; //XLGMII Interface to NSS
logic [7:0] hlp_xlgmii1_txc_nss_0; //XLGMII Interface to NSS
logic [63:0] hlp_xlgmii1_txd_nss_0; //XLGMII Interface to NSS
logic hlp_xlgmii2_txclk_ena_nss_0; //XLGMII Interface to NSS
logic hlp_xlgmii2_rxclk_ena_nss_0; //XLGMII Interface to NSS
logic [7:0] hlp_xlgmii2_rxc_nss_0; //XLGMII Interface to NSS
logic [63:0] hlp_xlgmii2_rxd_nss_0; //XLGMII Interface to NSS
logic hlp_xlgmii2_rxt0_next_nss_0; //XLGMII Interface to NSS
logic [7:0] hlp_xlgmii2_txc_nss_0; //XLGMII Interface to NSS
logic [63:0] hlp_xlgmii2_txd_nss_0; //XLGMII Interface to NSS
logic hlp_xlgmii3_txclk_ena_nss_0; //XLGMII Interface to NSS
logic hlp_xlgmii3_rxclk_ena_nss_0; //XLGMII Interface to NSS
logic [7:0] hlp_xlgmii3_rxc_nss_0; //XLGMII Interface to NSS
logic [63:0] hlp_xlgmii3_rxd_nss_0; //XLGMII Interface to NSS
logic hlp_xlgmii3_rxt0_next_nss_0; //XLGMII Interface to NSS
logic [7:0] hlp_xlgmii3_txc_nss_0; //XLGMII Interface to NSS
logic [63:0] hlp_xlgmii3_txd_nss_0; //XLGMII Interface to NSS
logic [127:0] hlp_cgmii0_rxd_nss_0; //CGMII Interface to NSS
logic [15:0] hlp_cgmii0_rxc_nss_0; //CGMII Interface to NSS
logic hlp_cgmii0_rxclk_ena_nss_0; //CGMII Interface to NSS
logic [127:0] hlp_cgmii0_txd_nss_0; //CGMII Interface to NSS
logic [15:0] hlp_cgmii0_txc_nss_0; //CGMII Interface to NSS
logic hlp_cgmii0_txclk_ena_nss_0; //CGMII Interface to NSS
logic [127:0] hlp_cgmii1_rxd_nss_0; //CGMII Interface to NSS
logic [15:0] hlp_cgmii1_rxc_nss_0; //CGMII Interface to NSS
logic hlp_cgmii1_rxclk_ena_nss_0; //CGMII Interface to NSS
logic [127:0] hlp_cgmii1_txd_nss_0; //CGMII Interface to NSS
logic [15:0] hlp_cgmii1_txc_nss_0; //CGMII Interface to NSS
logic hlp_cgmii1_txclk_ena_nss_0; //CGMII Interface to NSS
logic [127:0] hlp_cgmii2_rxd_nss_0; //CGMII Interface to NSS
logic [15:0] hlp_cgmii2_rxc_nss_0; //CGMII Interface to NSS
logic hlp_cgmii2_rxclk_ena_nss_0; //CGMII Interface to NSS
logic [127:0] hlp_cgmii2_txd_nss_0; //CGMII Interface to NSS
logic [15:0] hlp_cgmii2_txc_nss_0; //CGMII Interface to NSS
logic hlp_cgmii2_txclk_ena_nss_0; //CGMII Interface to NSS
logic [127:0] hlp_cgmii3_rxd_nss_0; //CGMII Interface to NSS
logic [15:0] hlp_cgmii3_rxc_nss_0; //CGMII Interface to NSS
logic hlp_cgmii3_rxclk_ena_nss_0; //CGMII Interface to NSS
logic [127:0] hlp_cgmii3_txd_nss_0; //CGMII Interface to NSS
logic [15:0] hlp_cgmii3_txc_nss_0; //CGMII Interface to NSS
logic hlp_cgmii3_txclk_ena_nss_0; //CGMII Interface to NSS
logic hlp_xlgmii0_txclk_ena_1; //XLGMII Interface to HMAC
logic hlp_xlgmii0_rxclk_ena_1; //XLGMII Interface to HMAC
logic [7:0] hlp_xlgmii0_rxc_1; //XLGMII Interface to HMAC
logic [63:0] hlp_xlgmii0_rxd_1; //XLGMII Interface to HMAC
logic hlp_xlgmii0_rxt0_next_1; //XLGMII Interface to HMAC
logic [7:0] hlp_xlgmii0_txc_1; //XLGMII Interface to HMAC
logic [63:0] hlp_xlgmii0_txd_1; //XLGMII Interface to HMAC
logic hlp_xlgmii1_txclk_ena_1; //XLGMII Interface to HMAC
logic hlp_xlgmii1_rxclk_ena_1; //XLGMII Interface to HMAC
logic [7:0] hlp_xlgmii1_rxc_1; //XLGMII Interface to HMAC
logic [63:0] hlp_xlgmii1_rxd_1; //XLGMII Interface to HMAC
logic hlp_xlgmii1_rxt0_next_1; //XLGMII Interface to HMAC
logic [7:0] hlp_xlgmii1_txc_1; //XLGMII Interface to HMAC
logic [63:0] hlp_xlgmii1_txd_1; //XLGMII Interface to HMAC
logic hlp_xlgmii2_txclk_ena_1; //XLGMII Interface to HMAC
logic hlp_xlgmii2_rxclk_ena_1; //XLGMII Interface to HMAC
logic [7:0] hlp_xlgmii2_rxc_1; //XLGMII Interface to HMAC
logic [63:0] hlp_xlgmii2_rxd_1; //XLGMII Interface to HMAC
logic hlp_xlgmii2_rxt0_next_1; //XLGMII Interface to HMAC
logic [7:0] hlp_xlgmii2_txc_1; //XLGMII Interface to HMAC
logic [63:0] hlp_xlgmii2_txd_1; //XLGMII Interface to HMAC
logic hlp_xlgmii3_txclk_ena_1; //XLGMII Interface to HMAC
logic hlp_xlgmii3_rxclk_ena_1; //XLGMII Interface to HMAC
logic [7:0] hlp_xlgmii3_rxc_1; //XLGMII Interface to HMAC
logic [63:0] hlp_xlgmii3_rxd_1; //XLGMII Interface to HMAC
logic hlp_xlgmii3_rxt0_next_1; //XLGMII Interface to HMAC
logic [7:0] hlp_xlgmii3_txc_1; //XLGMII Interface to HMAC
logic [63:0] hlp_xlgmii3_txd_1; //XLGMII Interface to HMAC
logic [127:0] hlp_cgmii0_rxd_1; //CGMII Interface to HMAC
logic [15:0] hlp_cgmii0_rxc_1; //CGMII Interface to HMAC
logic hlp_cgmii0_rxclk_ena_1; //CGMII Interface to HMAC
logic [127:0] hlp_cgmii0_txd_1; //CGMII Interface to HMAC
logic [15:0] hlp_cgmii0_txc_1; //CGMII Interface to HMAC
logic hlp_cgmii0_txclk_ena_1; //CGMII Interface to HMAC
logic [127:0] hlp_cgmii1_rxd_1; //CGMII Interface to HMAC
logic [15:0] hlp_cgmii1_rxc_1; //CGMII Interface to HMAC
logic hlp_cgmii1_rxclk_ena_1; //CGMII Interface to HMAC
logic [127:0] hlp_cgmii1_txd_1; //CGMII Interface to HMAC
logic [15:0] hlp_cgmii1_txc_1; //CGMII Interface to HMAC
logic hlp_cgmii1_txclk_ena_1; //CGMII Interface to HMAC
logic [127:0] hlp_cgmii2_rxd_1; //CGMII Interface to HMAC
logic [15:0] hlp_cgmii2_rxc_1; //CGMII Interface to HMAC
logic hlp_cgmii2_rxclk_ena_1; //CGMII Interface to HMAC
logic [127:0] hlp_cgmii2_txd_1; //CGMII Interface to HMAC
logic [15:0] hlp_cgmii2_txc_1; //CGMII Interface to HMAC
logic hlp_cgmii2_txclk_ena_1; //CGMII Interface to HMAC
logic [127:0] hlp_cgmii3_rxd_1; //CGMII Interface to HMAC
logic [15:0] hlp_cgmii3_rxc_1; //CGMII Interface to HMAC
logic hlp_cgmii3_rxclk_ena_1; //CGMII Interface to HMAC
logic [127:0] hlp_cgmii3_txd_1; //CGMII Interface to HMAC
logic [15:0] hlp_cgmii3_txc_1; //CGMII Interface to HMAC
logic hlp_cgmii3_txclk_ena_1; //CGMII Interface to HMAC
logic hlp_xlgmii0_txclk_ena_2; //XLGMII Interface to HMAC
logic hlp_xlgmii0_rxclk_ena_2; //XLGMII Interface to HMAC
logic [7:0] hlp_xlgmii0_rxc_2; //XLGMII Interface to HMAC
logic [63:0] hlp_xlgmii0_rxd_2; //XLGMII Interface to HMAC
logic hlp_xlgmii0_rxt0_next_2; //XLGMII Interface to HMAC
logic [7:0] hlp_xlgmii0_txc_2; //XLGMII Interface to HMAC
logic [63:0] hlp_xlgmii0_txd_2; //XLGMII Interface to HMAC
logic hlp_xlgmii1_txclk_ena_2; //XLGMII Interface to HMAC
logic hlp_xlgmii1_rxclk_ena_2; //XLGMII Interface to HMAC
logic [7:0] hlp_xlgmii1_rxc_2; //XLGMII Interface to HMAC
logic [63:0] hlp_xlgmii1_rxd_2; //XLGMII Interface to HMAC
logic hlp_xlgmii1_rxt0_next_2; //XLGMII Interface to HMAC
logic [7:0] hlp_xlgmii1_txc_2; //XLGMII Interface to HMAC
logic [63:0] hlp_xlgmii1_txd_2; //XLGMII Interface to HMAC
logic hlp_xlgmii2_txclk_ena_2; //XLGMII Interface to HMAC
logic hlp_xlgmii2_rxclk_ena_2; //XLGMII Interface to HMAC
logic [7:0] hlp_xlgmii2_rxc_2; //XLGMII Interface to HMAC
logic [63:0] hlp_xlgmii2_rxd_2; //XLGMII Interface to HMAC
logic hlp_xlgmii2_rxt0_next_2; //XLGMII Interface to HMAC
logic [7:0] hlp_xlgmii2_txc_2; //XLGMII Interface to HMAC
logic [63:0] hlp_xlgmii2_txd_2; //XLGMII Interface to HMAC
logic hlp_xlgmii3_txclk_ena_2; //XLGMII Interface to HMAC
logic hlp_xlgmii3_rxclk_ena_2; //XLGMII Interface to HMAC
logic [7:0] hlp_xlgmii3_rxc_2; //XLGMII Interface to HMAC
logic [63:0] hlp_xlgmii3_rxd_2; //XLGMII Interface to HMAC
logic hlp_xlgmii3_rxt0_next_2; //XLGMII Interface to HMAC
logic [7:0] hlp_xlgmii3_txc_2; //XLGMII Interface to HMAC
logic [63:0] hlp_xlgmii3_txd_2; //XLGMII Interface to HMAC
logic [127:0] hlp_cgmii0_rxd_2; //CGMII Interface to HMAC
logic [15:0] hlp_cgmii0_rxc_2; //CGMII Interface to HMAC
logic hlp_cgmii0_rxclk_ena_2; //CGMII Interface to HMAC
logic [127:0] hlp_cgmii0_txd_2; //CGMII Interface to HMAC
logic [15:0] hlp_cgmii0_txc_2; //CGMII Interface to HMAC
logic hlp_cgmii0_txclk_ena_2; //CGMII Interface to HMAC
logic [127:0] hlp_cgmii1_rxd_2; //CGMII Interface to HMAC
logic [15:0] hlp_cgmii1_rxc_2; //CGMII Interface to HMAC
logic hlp_cgmii1_rxclk_ena_2; //CGMII Interface to HMAC
logic [127:0] hlp_cgmii1_txd_2; //CGMII Interface to HMAC
logic [15:0] hlp_cgmii1_txc_2; //CGMII Interface to HMAC
logic hlp_cgmii1_txclk_ena_2; //CGMII Interface to HMAC
logic [127:0] hlp_cgmii2_rxd_2; //CGMII Interface to HMAC
logic [15:0] hlp_cgmii2_rxc_2; //CGMII Interface to HMAC
logic hlp_cgmii2_rxclk_ena_2; //CGMII Interface to HMAC
logic [127:0] hlp_cgmii2_txd_2; //CGMII Interface to HMAC
logic [15:0] hlp_cgmii2_txc_2; //CGMII Interface to HMAC
logic hlp_cgmii2_txclk_ena_2; //CGMII Interface to HMAC
logic [127:0] hlp_cgmii3_rxd_2; //CGMII Interface to HMAC
logic [15:0] hlp_cgmii3_rxc_2; //CGMII Interface to HMAC
logic hlp_cgmii3_rxclk_ena_2; //CGMII Interface to HMAC
logic [127:0] hlp_cgmii3_txd_2; //CGMII Interface to HMAC
logic [15:0] hlp_cgmii3_txc_2; //CGMII Interface to HMAC
logic hlp_cgmii3_txclk_ena_2; //CGMII Interface to HMAC
logic hlp_xlgmii0_txclk_ena_3; //XLGMII Interface to HMAC
logic hlp_xlgmii0_rxclk_ena_3; //XLGMII Interface to HMAC
logic [7:0] hlp_xlgmii0_rxc_3; //XLGMII Interface to HMAC
logic [63:0] hlp_xlgmii0_rxd_3; //XLGMII Interface to HMAC
logic hlp_xlgmii0_rxt0_next_3; //XLGMII Interface to HMAC
logic [7:0] hlp_xlgmii0_txc_3; //XLGMII Interface to HMAC
logic [63:0] hlp_xlgmii0_txd_3; //XLGMII Interface to HMAC
logic hlp_xlgmii1_txclk_ena_3; //XLGMII Interface to HMAC
logic hlp_xlgmii1_rxclk_ena_3; //XLGMII Interface to HMAC
logic [7:0] hlp_xlgmii1_rxc_3; //XLGMII Interface to HMAC
logic [63:0] hlp_xlgmii1_rxd_3; //XLGMII Interface to HMAC
logic hlp_xlgmii1_rxt0_next_3; //XLGMII Interface to HMAC
logic [7:0] hlp_xlgmii1_txc_3; //XLGMII Interface to HMAC
logic [63:0] hlp_xlgmii1_txd_3; //XLGMII Interface to HMAC
logic hlp_xlgmii2_txclk_ena_3; //XLGMII Interface to HMAC
logic hlp_xlgmii2_rxclk_ena_3; //XLGMII Interface to HMAC
logic [7:0] hlp_xlgmii2_rxc_3; //XLGMII Interface to HMAC
logic [63:0] hlp_xlgmii2_rxd_3; //XLGMII Interface to HMAC
logic hlp_xlgmii2_rxt0_next_3; //XLGMII Interface to HMAC
logic [7:0] hlp_xlgmii2_txc_3; //XLGMII Interface to HMAC
logic [63:0] hlp_xlgmii2_txd_3; //XLGMII Interface to HMAC
logic hlp_xlgmii3_txclk_ena_3; //XLGMII Interface to HMAC
logic hlp_xlgmii3_rxclk_ena_3; //XLGMII Interface to HMAC
logic [7:0] hlp_xlgmii3_rxc_3; //XLGMII Interface to HMAC
logic [63:0] hlp_xlgmii3_rxd_3; //XLGMII Interface to HMAC
logic hlp_xlgmii3_rxt0_next_3; //XLGMII Interface to HMAC
logic [7:0] hlp_xlgmii3_txc_3; //XLGMII Interface to HMAC
logic [63:0] hlp_xlgmii3_txd_3; //XLGMII Interface to HMAC
logic [127:0] hlp_cgmii0_rxd_3; //CGMII Interface to HMAC
logic [15:0] hlp_cgmii0_rxc_3; //CGMII Interface to HMAC
logic hlp_cgmii0_rxclk_ena_3; //CGMII Interface to HMAC
logic [127:0] hlp_cgmii0_txd_3; //CGMII Interface to HMAC
logic [15:0] hlp_cgmii0_txc_3; //CGMII Interface to HMAC
logic hlp_cgmii0_txclk_ena_3; //CGMII Interface to HMAC
logic [127:0] hlp_cgmii1_rxd_3; //CGMII Interface to HMAC
logic [15:0] hlp_cgmii1_rxc_3; //CGMII Interface to HMAC
logic hlp_cgmii1_rxclk_ena_3; //CGMII Interface to HMAC
logic [127:0] hlp_cgmii1_txd_3; //CGMII Interface to HMAC
logic [15:0] hlp_cgmii1_txc_3; //CGMII Interface to HMAC
logic hlp_cgmii1_txclk_ena_3; //CGMII Interface to HMAC
logic [127:0] hlp_cgmii2_rxd_3; //CGMII Interface to HMAC
logic [15:0] hlp_cgmii2_rxc_3; //CGMII Interface to HMAC
logic hlp_cgmii2_rxclk_ena_3; //CGMII Interface to HMAC
logic [127:0] hlp_cgmii2_txd_3; //CGMII Interface to HMAC
logic [15:0] hlp_cgmii2_txc_3; //CGMII Interface to HMAC
logic hlp_cgmii2_txclk_ena_3; //CGMII Interface to HMAC
logic [127:0] hlp_cgmii3_rxd_3; //CGMII Interface to HMAC
logic [15:0] hlp_cgmii3_rxc_3; //CGMII Interface to HMAC
logic hlp_cgmii3_rxclk_ena_3; //CGMII Interface to HMAC
logic [127:0] hlp_cgmii3_txd_3; //CGMII Interface to HMAC
logic [15:0] hlp_cgmii3_txc_3; //CGMII Interface to HMAC
logic hlp_cgmii3_txclk_ena_3; //CGMII Interface to HMAC
logic mse_physs_port_0_ts_capture_vld; //Indicate the timestamp capture valid for 1588 2-step operation This should be valid as part of SOP
logic [6:0] mse_physs_port_0_ts_capture_idx; //Indicate the timestamp capture idx for 1588 2-step operation This should be valid as part of SOP
logic mse_physs_port_1_ts_capture_vld; //Indicate the timestamp capture valid for 1588 2-step operation This should be valid as part of SOP
logic [6:0] mse_physs_port_1_ts_capture_idx; //Indicate the timestamp capture idx for 1588 2-step operation This should be valid as part of SOP
logic mse_physs_port_2_ts_capture_vld; //Indicate the timestamp capture valid for 1588 2-step operation This should be valid as part of SOP
logic [6:0] mse_physs_port_2_ts_capture_idx; //Indicate the timestamp capture idx for 1588 2-step operation This should be valid as part of SOP
logic mse_physs_port_3_ts_capture_vld; //Indicate the timestamp capture valid for 1588 2-step operation This should be valid as part of SOP
logic [6:0] mse_physs_port_3_ts_capture_idx; //Indicate the timestamp capture idx for 1588 2-step operation This should be valid as part of SOP
logic mse_physs_port_4_ts_capture_vld; //Indicate the timestamp capture valid for 1588 2-step operation This should be valid as part of SOP
logic [6:0] mse_physs_port_4_ts_capture_idx; //Indicate the timestamp capture idx for 1588 2-step operation This should be valid as part of SOP
logic mse_physs_port_5_ts_capture_vld; //Indicate the timestamp capture valid for 1588 2-step operation This should be valid as part of SOP
logic [6:0] mse_physs_port_5_ts_capture_idx; //Indicate the timestamp capture idx for 1588 2-step operation This should be valid as part of SOP
logic mse_physs_port_6_ts_capture_vld; //Indicate the timestamp capture valid for 1588 2-step operation This should be valid as part of SOP
logic [6:0] mse_physs_port_6_ts_capture_idx; //Indicate the timestamp capture idx for 1588 2-step operation This should be valid as part of SOP
logic mse_physs_port_7_ts_capture_vld; //Indicate the timestamp capture valid for 1588 2-step operation This should be valid as part of SOP
logic [6:0] mse_physs_port_7_ts_capture_idx; //Indicate the timestamp capture idx for 1588 2-step operation This should be valid as part of SOP
logic [31:0] pcs_tsu_rx_sd;
logic [31:0] mii_rx_tsu_mux;
logic [31:0] mii_tx_tsu;
logic [127:0] pcs_sd_bit_slip;
logic [111:0] pcs_desk_buf_rlevel;
logic [15:0] pcs_link_status_tsu;
logic physs_icq_port_0_pfc_mode; //Indication from register bit COMMAND_CONFIG.PFC_ENA (bit 19) indicating (when 1) that the MAC operates in PFC mode. When 0 it indicates operation in link pause mode.
logic physs_icq_port_1_pfc_mode; //Indication from register bit COMMAND_CONFIG.PFC_ENA (bit 19) indicating (when 1) that the MAC operates in PFC mode. When 0 it indicates operation in link pause mode.
logic physs_icq_port_2_pfc_mode; //Indication from register bit COMMAND_CONFIG.PFC_ENA (bit 19) indicating (when 1) that the MAC operates in PFC mode. When 0 it indicates operation in link pause mode.
logic physs_icq_port_3_pfc_mode; //Indication from register bit COMMAND_CONFIG.PFC_ENA (bit 19) indicating (when 1) that the MAC operates in PFC mode. When 0 it indicates operation in link pause mode.
logic physs_icq_port_4_pfc_mode; //Indication from register bit COMMAND_CONFIG.PFC_ENA (bit 19) indicating (when 1) that the MAC operates in PFC mode. When 0 it indicates operation in link pause mode.
logic physs_icq_port_5_pfc_mode; //Indication from register bit COMMAND_CONFIG.PFC_ENA (bit 19) indicating (when 1) that the MAC operates in PFC mode. When 0 it indicates operation in link pause mode.
logic physs_icq_port_6_pfc_mode; //Indication from register bit COMMAND_CONFIG.PFC_ENA (bit 19) indicating (when 1) that the MAC operates in PFC mode. When 0 it indicates operation in link pause mode.
logic physs_icq_port_7_pfc_mode; //Indication from register bit COMMAND_CONFIG.PFC_ENA (bit 19) indicating (when 1) that the MAC operates in PFC mode. When 0 it indicates operation in link pause mode.
logic [63:0] icq_physs_net_xoff; //PFC flow control interface from the ingress CoS queues to the network. 8 bits - one for each UP for each PHYSS interface. Bits 0-7 correspond to User Priorities 0-7 of Physical Port0 / PHYSS interface 0 within the port MAC. Bits 8-15 correspond to User Priorities 0-3 of Physical Port1 / PHYSS interface 1 within the port MAC. Bits 16-23 correspond to User Priorities 0-3 of Physical Port2 / PHYSS interface 2 within the port MAC. Bits 24-31 correspond to User Priorities 0-3 of Physical Port3 / PHYSS interface 3 within the port MAC. Bits 32-39 correspond to User Priorities 0-3 of Physical Port4 / PHYSS interface 4 within the port MAC. Bits 40-47 correspond to User Priorities 0-3 of Physical Port5 / PHYSS interface 5 within the port MAC. Bits 48-55 correspond to User Priorities 0-3 of Physical Port6 / PHYSS interface 6 within the port MAC. Bits 56-63 correspond to User Priorities 0-3 of Physical Port7 / PHYSS interface 7 within the port MAC. When Port pfc_mode is configure as Link FLC. Bit0 correspond to Port0 Link FLC. Bit8 correspond to Port1 Link FLC. Bit16 correspond to Port2 Link FLC. Bit24 correspond to Port3 Link FLC. Bit32 correspond to Port4 Link FLC. Bit40 correspond to Port5 Link FLC. Bit48 correspond to Port6 Link FLC. Bit56 correspond to Port7 Link FLC
logic [63:0] physs_icq_net_xoff; //PFC flow control interface from network to the ingress CoS queues. 8 bits - one for each UP for each PHYSS interface. Bits 0-7 correspond to User Priorities 0-7 of Physical Port0 / PHYSS interface 0 within the port MAC. Bits 8-15 correspond to User Priorities 0-3 of Physical Port1 / PHYSS interface 1 within the port MAC. Bits 16-23 correspond to User Priorities 0-3 of Physical Port2 / PHYSS interface 2 within the port MAC. Bits 24-31 correspond to User Priorities 0-3 of Physical Port3 / PHYSS interface 3 within the port MAC. Bits 32-39 correspond to User Priorities 0-3 of Physical Port4 / PHYSS interface 4 within the port MAC. Bits 40-47 correspond to User Priorities 0-3 of Physical Port5 / PHYSS interface 5 within the port MAC. Bits 48-55 correspond to User Priorities 0-3 of Physical Port6 / PHYSS interface 6 within the port MAC. Bits 56-63 correspond to User Priorities 0-3 of Physical Port7 / PHYSS interface 7 within the port MAC. Hi. Bit0 correspond to Port0 Link FLC. Bit8 correspond to Port1 Link FLC. Bit16 correspond to Port2 Link FLC. Bit24 correspond to Port3 Link FLC. Bit32 correspond to Port4 Link FLC. Bit40 correspond to Port5 Link FLC. Bit48 correspond to Port6 Link FLC. Bit56 correspond to Port7 Link FLC
logic physs_hif_port_0_magic_pkt_ind_tgl; //Indicate magic packet received per port per PF/host to the HIF block.
logic physs_hif_port_1_magic_pkt_ind_tgl; //Indicate magic packet received per port per PF/host to the HIF block.
logic physs_hif_port_2_magic_pkt_ind_tgl; //Indicate magic packet received per port per PF/host to the HIF block.
logic physs_hif_port_3_magic_pkt_ind_tgl; //Indicate magic packet received per port per PF/host to the HIF block.
logic physs_hif_port_4_magic_pkt_ind_tgl; //Indicate magic packet received per port per PF/host to the HIF block.
logic physs_hif_port_5_magic_pkt_ind_tgl; //Indicate magic packet received per port per PF/host to the HIF block.
logic physs_hif_port_6_magic_pkt_ind_tgl; //Indicate magic packet received per port per PF/host to the HIF block.
logic physs_hif_port_7_magic_pkt_ind_tgl; //Indicate magic packet received per port per PF/host to the HIF block.
logic [1:0] physs_timesync_sync_val; //command valid to sync the 1588 timers
logic physs_fatal_int_0; //fatal interrupt indication for physs_0
logic physs_fatal_int_1; //fatal interrupt indication for physs_1
logic physs_ares_int_0; //interrupt indication for ARM cores for physs_0
logic physs_ares_int_1; //interrupt indication for ARM cores for physs_1
logic physs_imc_int_0; //interrupt indication for ARM IMC for physs_0
logic physs_imc_int_1; //interrupt indication for ARM IMC for physs_1
logic physs_0_ts_int; //PHY timestamp interrupt indication reflect 8 ports (faster interrupt tobypass IMC) for physs_0
logic physs_1_ts_int; //PHY timestamp interrupt indication reflect 8 ports (faster interrupt tobypass IMC) for physs_1
logic physs_0_noc_int; //NMF NOC interrupt. Connected to the inetrnal NOC interrupt pin for physs_0
logic physs_1_noc_int; //NMF NOC interrupt. Connected to the inetrnal NOC interrupt pin for physs_1
logic mdio_in;
logic mdio_out;
logic mdio_oen;
logic mdc;
logic [15:0] ioa_pma_remote_diode_i_anode;
logic [15:0] ioa_pma_remote_diode_v_anode;
logic [15:0] ioa_pma_remote_diode_i_cathode;
logic [15:0] ioa_pma_remote_diode_v_cathode;
logic i_ck_fbscan_tck_0; //Boundary scan clock
logic i_ck_fbscan_updatedr_0; //TAP Controller state. In this controller state data is latched onto the parallel logic of the test data registers from the shift-register path. The data held at the latched parallel logic should not change in any other controller state unless a change in operation is required
logic i_fbscan_capturedr_0; //TAP Controller state. In this controller state data may be parallel-loaded into test data registers selected by the current instruction on the rising edge of TC
logic i_fbscan_shiftdr_0; //TAP Controller stateIn this controller state the boundary scan data shifts data one stage toward its serial logic on each rising edge of i_ck_bs
logic i_fbscan_tdi_0; //Test data logic port from preceding boundary scan cell
logic o_abscan_pma0_tdo_0; //Bscan data timed to rising edge
logic o_abscan_pma0_tdo_f_0; //Bscan data timed to falling edge
logic o_abscan_pma1_tdo_0; //Bscan data timed to rising edge
logic o_abscan_pma1_tdo_f_0; //Bscan data timed to falling edge
logic o_abscan_pma2_tdo_0; //Bscan data timed to rising edge
logic o_abscan_pma2_tdo_f_0; //Bscan data timed to falling edge
logic o_abscan_pma3_tdo_0; //Bscan data timed to rising edge
logic o_abscan_pma3_tdo_f_0; //Bscan data timed to falling edge
logic i_fbscan_mode_0; //Boundary scan mode enable.
logic i_fbscan_chainen_0; //TBD
logic i_fbscan_d6init_0; //TAP instruction
logic i_fbscan_d6select_0; //TAP instruction
logic i_fbscan_d6actestsig_b_0; //TBD
logic i_fbscan_extogen_0; //TAP instruction
logic i_fbscan_extogsig_b_0; //TBD
logic i_fbscan_highz_0; //TBD
logic i_ck_fbscan_tck_1; //Boundary scan clock
logic i_ck_fbscan_updatedr_1; //TAP Controller state. In this controller state data is latched onto the parallel logic of the test data registers from the shift-register path. The data held at the latched parallel logic should not change in any other controller state unless a change in operation is required
logic i_fbscan_capturedr_1; //TAP Controller state. In this controller state data may be parallel-loaded into test data registers selected by the current instruction on the rising edge of TC
logic i_fbscan_shiftdr_1; //TAP Controller stateIn this controller state the boundary scan data shifts data one stage toward its serial logic on each rising edge of i_ck_bs
logic i_fbscan_tdi_1; //Test data logic port from preceding boundary scan cell
logic o_abscan_pma0_tdo_1; //Bscan data timed to rising edge
logic o_abscan_pma0_tdo_f_1; //Bscan data timed to falling edge
logic o_abscan_pma1_tdo_1; //Bscan data timed to rising edge
logic o_abscan_pma1_tdo_f_1; //Bscan data timed to falling edge
logic o_abscan_pma2_tdo_1; //Bscan data timed to rising edge
logic o_abscan_pma2_tdo_f_1; //Bscan data timed to falling edge
logic o_abscan_pma3_tdo_1; //Bscan data timed to rising edge
logic o_abscan_pma3_tdo_f_1; //Bscan data timed to falling edge
logic i_fbscan_mode_1; //Boundary scan mode enable.
logic i_fbscan_chainen_1; //TBD
logic i_fbscan_d6init_1; //TAP instruction
logic i_fbscan_d6select_1; //TAP instruction
logic i_fbscan_d6actestsig_b_1; //TBD
logic i_fbscan_extogen_1; //TAP instruction
logic i_fbscan_extogsig_b_1; //TBD
logic i_fbscan_highz_1; //TBD
logic i_ck_fbscan_tck_2; //Boundary scan clock
logic i_ck_fbscan_updatedr_2; //TAP Controller state. In this controller state data is latched onto the parallel logic of the test data registers from the shift-register path. The data held at the latched parallel logic should not change in any other controller state unless a change in operation is required
logic i_fbscan_capturedr_2; //TAP Controller state. In this controller state data may be parallel-loaded into test data registers selected by the current instruction on the rising edge of TC
logic i_fbscan_shiftdr_2; //TAP Controller stateIn this controller state the boundary scan data shifts data one stage toward its serial logic on each rising edge of i_ck_bs
logic i_fbscan_tdi_2; //Test data logic port from preceding boundary scan cell
logic o_abscan_pma0_tdo_2; //Bscan data timed to rising edge
logic o_abscan_pma0_tdo_f_2; //Bscan data timed to falling edge
logic o_abscan_pma1_tdo_2; //Bscan data timed to rising edge
logic o_abscan_pma1_tdo_f_2; //Bscan data timed to falling edge
logic o_abscan_pma2_tdo_2; //Bscan data timed to rising edge
logic o_abscan_pma2_tdo_f_2; //Bscan data timed to falling edge
logic o_abscan_pma3_tdo_2; //Bscan data timed to rising edge
logic o_abscan_pma3_tdo_f_2; //Bscan data timed to falling edge
logic i_fbscan_mode_2; //Boundary scan mode enable.
logic i_fbscan_chainen_2; //TBD
logic i_fbscan_d6init_2; //TAP instruction
logic i_fbscan_d6select_2; //TAP instruction
logic i_fbscan_d6actestsig_b_2; //TBD
logic i_fbscan_extogen_2; //TAP instruction
logic i_fbscan_extogsig_b_2; //TBD
logic i_fbscan_highz_2; //TBD
logic i_ck_fbscan_tck_3; //Boundary scan clock
logic i_ck_fbscan_updatedr_3; //TAP Controller state. In this controller state data is latched onto the parallel logic of the test data registers from the shift-register path. The data held at the latched parallel logic should not change in any other controller state unless a change in operation is required
logic i_fbscan_capturedr_3; //TAP Controller state. In this controller state data may be parallel-loaded into test data registers selected by the current instruction on the rising edge of TC
logic i_fbscan_shiftdr_3; //TAP Controller stateIn this controller state the boundary scan data shifts data one stage toward its serial logic on each rising edge of i_ck_bs
logic i_fbscan_tdi_3; //Test data logic port from preceding boundary scan cell
logic o_abscan_pma0_tdo_3; //Bscan data timed to rising edge
logic o_abscan_pma0_tdo_f_3; //Bscan data timed to falling edge
logic o_abscan_pma1_tdo_3; //Bscan data timed to rising edge
logic o_abscan_pma1_tdo_f_3; //Bscan data timed to falling edge
logic o_abscan_pma2_tdo_3; //Bscan data timed to rising edge
logic o_abscan_pma2_tdo_f_3; //Bscan data timed to falling edge
logic o_abscan_pma3_tdo_3; //Bscan data timed to rising edge
logic o_abscan_pma3_tdo_f_3; //Bscan data timed to falling edge
logic i_fbscan_mode_3; //Boundary scan mode enable.
logic i_fbscan_chainen_3; //TBD
logic i_fbscan_d6init_3; //TAP instruction
logic i_fbscan_d6select_3; //TAP instruction
logic i_fbscan_d6actestsig_b_3; //TBD
logic i_fbscan_extogen_3; //TAP instruction
logic i_fbscan_extogsig_b_3; //TBD
logic i_fbscan_highz_3; //TBD
logic i_fdfx_powergood; //TBD
logic i_ck_pma0_jtag_tck; //JTAG clock
logic i_dfx_pma0_secure_tap_green; //JTAG security level - Green
logic i_dfx_pma0_secure_tap_orange; //JTAG security level - Orange
logic i_dfx_pma0_secure_tap_red; //JTAG security level - Red
logic i_rst_pma0_jtag_trst_b_a; //JTAG reset
logic [7:0] i_pma0_jtag_id_nt; //Sets JTAG ID for JTAG controller. Used during private EN instruction to enable other private instructions
logic [31:0] i_pma0_jtag_slvid_nt; //Sets JTAG Slave ID for JTAG controller. logic when performing SLVIDCODE. Must be unique
logic i_pma0_jtag_tms; //JTAG TMS logic. Refer to JTAG documentation
logic i_pma0_jtag_tdi; //JTAG TDI logic. Refer to JTAG documentation
logic o_pma0_jtag_tdo_en; //JTAG TDO enable logic. Should be attached to the enable port of a tri-state buffer driving TDO if applicable
logic o_pma0_jtag_tdo; //JTAG TDO logic. Refer to JTAG documentation
logic i_ck_pma1_jtag_tck; //JTAG clock
logic i_dfx_pma1_secure_tap_green; //JTAG security level - Green
logic i_dfx_pma1_secure_tap_orange; //JTAG security level - Orange
logic i_dfx_pma1_secure_tap_red; //JTAG security level - Red
logic i_rst_pma1_jtag_trst_b_a; //JTAG reset
logic [7:0] i_pma1_jtag_id_nt; //Sets JTAG ID for JTAG controller. Used during private EN instruction to enable other private instructions
logic [31:0] i_pma1_jtag_slvid_nt; //Sets JTAG Slave ID for JTAG controller. logic when performing SLVIDCODE. Must be unique
logic i_pma1_jtag_tms; //JTAG TMS logic. Refer to JTAG documentation
logic i_pma1_jtag_tdi; //JTAG TDI logic. Refer to JTAG documentation
logic o_pma1_jtag_tdo_en; //JTAG TDO enable logic. Should be attached to the enable port of a tri-state buffer driving TDO if applicable
logic o_pma1_jtag_tdo; //JTAG TDO logic. Refer to JTAG documentation
logic i_ck_pma2_jtag_tck; //JTAG clock
logic i_dfx_pma2_secure_tap_green; //JTAG security level - Green
logic i_dfx_pma2_secure_tap_orange; //JTAG security level - Orange
logic i_dfx_pma2_secure_tap_red; //JTAG security level - Red
logic i_rst_pma2_jtag_trst_b_a; //JTAG reset
logic [7:0] i_pma2_jtag_id_nt; //Sets JTAG ID for JTAG controller. Used during private EN instruction to enable other private instructions
logic [31:0] i_pma2_jtag_slvid_nt; //Sets JTAG Slave ID for JTAG controller. logic when performing SLVIDCODE. Must be unique
logic i_pma2_jtag_tms; //JTAG TMS logic. Refer to JTAG documentation
logic i_pma2_jtag_tdi; //JTAG TDI logic. Refer to JTAG documentation
logic o_pma2_jtag_tdo_en; //JTAG TDO enable logic. Should be attached to the enable port of a tri-state buffer driving TDO if applicable
logic o_pma2_jtag_tdo; //JTAG TDO logic. Refer to JTAG documentation
logic i_ck_pma3_jtag_tck; //JTAG clock
logic i_dfx_pma3_secure_tap_green; //JTAG security level - Green
logic i_dfx_pma3_secure_tap_orange; //JTAG security level - Orange
logic i_dfx_pma3_secure_tap_red; //JTAG security level - Red
logic i_rst_pma3_jtag_trst_b_a; //JTAG reset
logic [7:0] i_pma3_jtag_id_nt; //Sets JTAG ID for JTAG controller. Used during private EN instruction to enable other private instructions
logic [31:0] i_pma3_jtag_slvid_nt; //Sets JTAG Slave ID for JTAG controller. logic when performing SLVIDCODE. Must be unique
logic i_pma3_jtag_tms; //JTAG TMS logic. Refer to JTAG documentation
logic i_pma3_jtag_tdi; //JTAG TDI logic. Refer to JTAG documentation
logic o_pma3_jtag_tdo_en; //JTAG TDO enable logic. Should be attached to the enable port of a tri-state buffer driving TDO if applicable
logic o_pma3_jtag_tdo; //JTAG TDO logic. Refer to JTAG documentation
logic i_ck_pma4_jtag_tck; //JTAG clock
logic i_dfx_pma4_secure_tap_green; //JTAG security level - Green
logic i_dfx_pma4_secure_tap_orange; //JTAG security level - Orange
logic i_dfx_pma4_secure_tap_red; //JTAG security level - Red
logic i_rst_pma4_jtag_trst_b_a; //JTAG reset
logic [7:0] i_pma4_jtag_id_nt; //Sets JTAG ID for JTAG controller. Used during private EN instruction to enable other private instructions
logic [31:0] i_pma4_jtag_slvid_nt; //Sets JTAG Slave ID for JTAG controller. logic when performing SLVIDCODE. Must be unique
logic i_pma4_jtag_tms; //JTAG TMS logic. Refer to JTAG documentation
logic i_pma4_jtag_tdi; //JTAG TDI logic. Refer to JTAG documentation
logic o_pma4_jtag_tdo_en; //JTAG TDO enable logic. Should be attached to the enable port of a tri-state buffer driving TDO if applicable
logic o_pma4_jtag_tdo; //JTAG TDO logic. Refer to JTAG documentation
logic i_ck_pma5_jtag_tck; //JTAG clock
logic i_dfx_pma5_secure_tap_green; //JTAG security level - Green
logic i_dfx_pma5_secure_tap_orange; //JTAG security level - Orange
logic i_dfx_pma5_secure_tap_red; //JTAG security level - Red
logic i_rst_pma5_jtag_trst_b_a; //JTAG reset
logic [7:0] i_pma5_jtag_id_nt; //Sets JTAG ID for JTAG controller. Used during private EN instruction to enable other private instructions
logic [31:0] i_pma5_jtag_slvid_nt; //Sets JTAG Slave ID for JTAG controller. logic when performing SLVIDCODE. Must be unique
logic i_pma5_jtag_tms; //JTAG TMS logic. Refer to JTAG documentation
logic i_pma5_jtag_tdi; //JTAG TDI logic. Refer to JTAG documentation
logic o_pma5_jtag_tdo_en; //JTAG TDO enable logic. Should be attached to the enable port of a tri-state buffer driving TDO if applicable
logic o_pma5_jtag_tdo; //JTAG TDO logic. Refer to JTAG documentation
logic i_ck_pma6_jtag_tck; //JTAG clock
logic i_dfx_pma6_secure_tap_green; //JTAG security level - Green
logic i_dfx_pma6_secure_tap_orange; //JTAG security level - Orange
logic i_dfx_pma6_secure_tap_red; //JTAG security level - Red
logic i_rst_pma6_jtag_trst_b_a; //JTAG reset
logic [7:0] i_pma6_jtag_id_nt; //Sets JTAG ID for JTAG controller. Used during private EN instruction to enable other private instructions
logic [31:0] i_pma6_jtag_slvid_nt; //Sets JTAG Slave ID for JTAG controller. logic when performing SLVIDCODE. Must be unique
logic i_pma6_jtag_tms; //JTAG TMS logic. Refer to JTAG documentation
logic i_pma6_jtag_tdi; //JTAG TDI logic. Refer to JTAG documentation
logic o_pma6_jtag_tdo_en; //JTAG TDO enable logic. Should be attached to the enable port of a tri-state buffer driving TDO if applicable
logic o_pma6_jtag_tdo; //JTAG TDO logic. Refer to JTAG documentation
logic i_ck_pma7_jtag_tck; //JTAG clock
logic i_dfx_pma7_secure_tap_green; //JTAG security level - Green
logic i_dfx_pma7_secure_tap_orange; //JTAG security level - Orange
logic i_dfx_pma7_secure_tap_red; //JTAG security level - Red
logic i_rst_pma7_jtag_trst_b_a; //JTAG reset
logic [7:0] i_pma7_jtag_id_nt; //Sets JTAG ID for JTAG controller. Used during private EN instruction to enable other private instructions
logic [31:0] i_pma7_jtag_slvid_nt; //Sets JTAG Slave ID for JTAG controller. logic when performing SLVIDCODE. Must be unique
logic i_pma7_jtag_tms; //JTAG TMS logic. Refer to JTAG documentation
logic i_pma7_jtag_tdi; //JTAG TDI logic. Refer to JTAG documentation
logic o_pma7_jtag_tdo_en; //JTAG TDO enable logic. Should be attached to the enable port of a tri-state buffer driving TDO if applicable
logic o_pma7_jtag_tdo; //JTAG TDO logic. Refer to JTAG documentation
logic i_ck_pma8_jtag_tck; //JTAG clock
logic i_dfx_pma8_secure_tap_green; //JTAG security level - Green
logic i_dfx_pma8_secure_tap_orange; //JTAG security level - Orange
logic i_dfx_pma8_secure_tap_red; //JTAG security level - Red
logic i_rst_pma8_jtag_trst_b_a; //JTAG reset
logic [7:0] i_pma8_jtag_id_nt; //Sets JTAG ID for JTAG controller. Used during private EN instruction to enable other private instructions
logic [31:0] i_pma8_jtag_slvid_nt; //Sets JTAG Slave ID for JTAG controller. logic when performing SLVIDCODE. Must be unique
logic i_pma8_jtag_tms; //JTAG TMS logic. Refer to JTAG documentation
logic i_pma8_jtag_tdi; //JTAG TDI logic. Refer to JTAG documentation
logic o_pma8_jtag_tdo_en; //JTAG TDO enable logic. Should be attached to the enable port of a tri-state buffer driving TDO if applicable
logic o_pma8_jtag_tdo; //JTAG TDO logic. Refer to JTAG documentation
logic i_ck_pma9_jtag_tck; //JTAG clock
logic i_dfx_pma9_secure_tap_green; //JTAG security level - Green
logic i_dfx_pma9_secure_tap_orange; //JTAG security level - Orange
logic i_dfx_pma9_secure_tap_red; //JTAG security level - Red
logic i_rst_pma9_jtag_trst_b_a; //JTAG reset
logic [7:0] i_pma9_jtag_id_nt; //Sets JTAG ID for JTAG controller. Used during private EN instruction to enable other private instructions
logic [31:0] i_pma9_jtag_slvid_nt; //Sets JTAG Slave ID for JTAG controller. logic when performing SLVIDCODE. Must be unique
logic i_pma9_jtag_tms; //JTAG TMS logic. Refer to JTAG documentation
logic i_pma9_jtag_tdi; //JTAG TDI logic. Refer to JTAG documentation
logic o_pma9_jtag_tdo_en; //JTAG TDO enable logic. Should be attached to the enable port of a tri-state buffer driving TDO if applicable
logic o_pma9_jtag_tdo; //JTAG TDO logic. Refer to JTAG documentation
logic i_ck_pma10_jtag_tck; //JTAG clock
logic i_dfx_pma10_secure_tap_green; //JTAG security level - Green
logic i_dfx_pma10_secure_tap_orange; //JTAG security level - Orange
logic i_dfx_pma10_secure_tap_red; //JTAG security level - Red
logic i_rst_pma10_jtag_trst_b_a; //JTAG reset
logic [7:0] i_pma10_jtag_id_nt; //Sets JTAG ID for JTAG controller. Used during private EN instruction to enable other private instructions
logic [31:0] i_pma10_jtag_slvid_nt; //Sets JTAG Slave ID for JTAG controller. logic when performing SLVIDCODE. Must be unique
logic i_pma10_jtag_tms; //JTAG TMS logic. Refer to JTAG documentation
logic i_pma10_jtag_tdi; //JTAG TDI logic. Refer to JTAG documentation
logic o_pma10_jtag_tdo_en; //JTAG TDO enable logic. Should be attached to the enable port of a tri-state buffer driving TDO if applicable
logic o_pma10_jtag_tdo; //JTAG TDO logic. Refer to JTAG documentation
logic i_ck_pma11_jtag_tck; //JTAG clock
logic i_dfx_pma11_secure_tap_green; //JTAG security level - Green
logic i_dfx_pma11_secure_tap_orange; //JTAG security level - Orange
logic i_dfx_pma11_secure_tap_red; //JTAG security level - Red
logic i_rst_pma11_jtag_trst_b_a; //JTAG reset
logic [7:0] i_pma11_jtag_id_nt; //Sets JTAG ID for JTAG controller. Used during private EN instruction to enable other private instructions
logic [31:0] i_pma11_jtag_slvid_nt; //Sets JTAG Slave ID for JTAG controller. logic when performing SLVIDCODE. Must be unique
logic i_pma11_jtag_tms; //JTAG TMS logic. Refer to JTAG documentation
logic i_pma11_jtag_tdi; //JTAG TDI logic. Refer to JTAG documentation
logic o_pma11_jtag_tdo_en; //JTAG TDO enable logic. Should be attached to the enable port of a tri-state buffer driving TDO if applicable
logic o_pma11_jtag_tdo; //JTAG TDO logic. Refer to JTAG documentation
logic i_ck_pma12_jtag_tck; //JTAG clock
logic i_dfx_pma12_secure_tap_green; //JTAG security level - Green
logic i_dfx_pma12_secure_tap_orange; //JTAG security level - Orange
logic i_dfx_pma12_secure_tap_red; //JTAG security level - Red
logic i_rst_pma12_jtag_trst_b_a; //JTAG reset
logic [7:0] i_pma12_jtag_id_nt; //Sets JTAG ID for JTAG controller. Used during private EN instruction to enable other private instructions
logic [31:0] i_pma12_jtag_slvid_nt; //Sets JTAG Slave ID for JTAG controller. logic when performing SLVIDCODE. Must be unique
logic i_pma12_jtag_tms; //JTAG TMS logic. Refer to JTAG documentation
logic i_pma12_jtag_tdi; //JTAG TDI logic. Refer to JTAG documentation
logic o_pma12_jtag_tdo_en; //JTAG TDO enable logic. Should be attached to the enable port of a tri-state buffer driving TDO if applicable
logic o_pma12_jtag_tdo; //JTAG TDO logic. Refer to JTAG documentation
logic i_ck_pma13_jtag_tck; //JTAG clock
logic i_dfx_pma13_secure_tap_green; //JTAG security level - Green
logic i_dfx_pma13_secure_tap_orange; //JTAG security level - Orange
logic i_dfx_pma13_secure_tap_red; //JTAG security level - Red
logic i_rst_pma13_jtag_trst_b_a; //JTAG reset
logic [7:0] i_pma13_jtag_id_nt; //Sets JTAG ID for JTAG controller. Used during private EN instruction to enable other private instructions
logic [31:0] i_pma13_jtag_slvid_nt; //Sets JTAG Slave ID for JTAG controller. logic when performing SLVIDCODE. Must be unique
logic i_pma13_jtag_tms; //JTAG TMS logic. Refer to JTAG documentation
logic i_pma13_jtag_tdi; //JTAG TDI logic. Refer to JTAG documentation
logic o_pma13_jtag_tdo_en; //JTAG TDO enable logic. Should be attached to the enable port of a tri-state buffer driving TDO if applicable
logic o_pma13_jtag_tdo; //JTAG TDO logic. Refer to JTAG documentation
logic i_ck_pma14_jtag_tck; //JTAG clock
logic i_dfx_pma14_secure_tap_green; //JTAG security level - Green
logic i_dfx_pma14_secure_tap_orange; //JTAG security level - Orange
logic i_dfx_pma14_secure_tap_red; //JTAG security level - Red
logic i_rst_pma14_jtag_trst_b_a; //JTAG reset
logic [7:0] i_pma14_jtag_id_nt; //Sets JTAG ID for JTAG controller. Used during private EN instruction to enable other private instructions
logic [31:0] i_pma14_jtag_slvid_nt; //Sets JTAG Slave ID for JTAG controller. logic when performing SLVIDCODE. Must be unique
logic i_pma14_jtag_tms; //JTAG TMS logic. Refer to JTAG documentation
logic i_pma14_jtag_tdi; //JTAG TDI logic. Refer to JTAG documentation
logic o_pma14_jtag_tdo_en; //JTAG TDO enable logic. Should be attached to the enable port of a tri-state buffer driving TDO if applicable
logic o_pma14_jtag_tdo; //JTAG TDO logic. Refer to JTAG documentation
logic i_ck_pma15_jtag_tck; //JTAG clock
logic i_dfx_pma15_secure_tap_green; //JTAG security level - Green
logic i_dfx_pma15_secure_tap_orange; //JTAG security level - Orange
logic i_dfx_pma15_secure_tap_red; //JTAG security level - Red
logic i_rst_pma15_jtag_trst_b_a; //JTAG reset
logic [7:0] i_pma15_jtag_id_nt; //Sets JTAG ID for JTAG controller. Used during private EN instruction to enable other private instructions
logic [31:0] i_pma15_jtag_slvid_nt; //Sets JTAG Slave ID for JTAG controller. logic when performing SLVIDCODE. Must be unique
logic i_pma15_jtag_tms; //JTAG TMS logic. Refer to JTAG documentation
logic i_pma15_jtag_tdi; //JTAG TDI logic. Refer to JTAG documentation
logic o_pma15_jtag_tdo_en; //JTAG TDO enable logic. Should be attached to the enable port of a tri-state buffer driving TDO if applicable
logic o_pma15_jtag_tdo; //JTAG TDO logic. Refer to JTAG documentation
logic i_ck_ucss_jtag_tck_0; //JTAG clock
logic i_rst_ucss_jtag_trst_b_a_0; //JTAG reset
logic [7:0] i_ucss_jtag_id_nt_0; //Sets JTAG ID for JTAG controller. Used during private EN instruction to enable other private instructions
logic [31:0] i_ucss_jtag_slvid_nt_0; //Sets JTAG Slave ID for JTAG controller. logic when performing SLVIDCODE. Must be unique
logic i_ucss_jtag_tms_0; //JTAG TMS logic. Refer to JTAG documentation
logic i_ucss_jtag_tdi_0; //JTAG TDI logic. Refer to JTAG documentation
logic o_ucss_jtag_tdo_en_0; //JTAG TDO enable logic. Should be attached to the enable port of a tri-state buffer driving TDO if applicable
logic o_ucss_jtag_tdo_0; //JTAG TDO logic. Refer to JTAG documentation
logic i_ck_cpu_debug_tck_0; //JTAG Debugger clock
logic i_rst_cpu_debug_trst_b_a_0; //JTAG resett
logic [15:0] i_cpu_debug_prid_nt_0; //CPU TAP (Debugger) IID
logic i_cpu_debug_tms_0; //JTAG Debugger TMS logic. Refer to JTAG
logic i_cpu_debug_tdi_0; //JTAG Debugger TDI logic. Refer to JTAG Debugger documentation
logic o_cpu_debug_tdo_0; //JTAG Debugger TDO logic. Refer to JTAG Debugger documentation
logic o_cpu_debug_tdo_en_0; //JTAG Debugger TDO enable logic. Should be attached to the enable port of a tri-state buffer driving TDO if applicable
logic i_dfx_ucss_secure_tap_green_0; //JTAG security level - Green
logic i_dfx_ucss_secure_tap_orange_0; //JTAG security level - Orange
logic i_dfx_ucss_secure_tap_red_0; //JTAG security level - Red
logic i_ck_ucss_jtag_tck_1; //JTAG clock
logic i_rst_ucss_jtag_trst_b_a_1; //JTAG reset
logic [7:0] i_ucss_jtag_id_nt_1; //Sets JTAG ID for JTAG controller. Used during private EN instruction to enable other private instructions
logic [31:0] i_ucss_jtag_slvid_nt_1; //Sets JTAG Slave ID for JTAG controller. logic when performing SLVIDCODE. Must be unique
logic i_ucss_jtag_tms_1; //JTAG TMS logic. Refer to JTAG documentation
logic i_ucss_jtag_tdi_1; //JTAG TDI logic. Refer to JTAG documentation
logic o_ucss_jtag_tdo_en_1; //JTAG TDO enable logic. Should be attached to the enable port of a tri-state buffer driving TDO if applicable
logic o_ucss_jtag_tdo_1; //JTAG TDO logic. Refer to JTAG documentation
logic i_ck_cpu_debug_tck_1; //JTAG Debugger clock
logic i_rst_cpu_debug_trst_b_a_1; //JTAG resett
logic [15:0] i_cpu_debug_prid_nt_1; //CPU TAP (Debugger) IID
logic i_cpu_debug_tms_1; //JTAG Debugger TMS logic. Refer to JTAG
logic i_cpu_debug_tdi_1; //JTAG Debugger TDI logic. Refer to JTAG Debugger documentation
logic o_cpu_debug_tdo_1; //JTAG Debugger TDO logic. Refer to JTAG Debugger documentation
logic o_cpu_debug_tdo_en_1; //JTAG Debugger TDO enable logic. Should be attached to the enable port of a tri-state buffer driving TDO if applicable
logic i_dfx_ucss_secure_tap_green_1; //JTAG security level - Green
logic i_dfx_ucss_secure_tap_orange_1; //JTAG security level - Orange
logic i_dfx_ucss_secure_tap_red_1; //JTAG security level - Red
logic i_ck_ucss_jtag_tck_2; //JTAG clock
logic i_rst_ucss_jtag_trst_b_a_2; //JTAG reset
logic [7:0] i_ucss_jtag_id_nt_2; //Sets JTAG ID for JTAG controller. Used during private EN instruction to enable other private instructions
logic [31:0] i_ucss_jtag_slvid_nt_2; //Sets JTAG Slave ID for JTAG controller. logic when performing SLVIDCODE. Must be unique
logic i_ucss_jtag_tms_2; //JTAG TMS logic. Refer to JTAG documentation
logic i_ucss_jtag_tdi_2; //JTAG TDI logic. Refer to JTAG documentation
logic o_ucss_jtag_tdo_en_2; //JTAG TDO enable logic. Should be attached to the enable port of a tri-state buffer driving TDO if applicable
logic o_ucss_jtag_tdo_2; //JTAG TDO logic. Refer to JTAG documentation
logic i_ck_cpu_debug_tck_2; //JTAG Debugger clock
logic i_rst_cpu_debug_trst_b_a_2; //JTAG resett
logic [15:0] i_cpu_debug_prid_nt_2; //CPU TAP (Debugger) IID
logic i_cpu_debug_tms_2; //JTAG Debugger TMS logic. Refer to JTAG
logic i_cpu_debug_tdi_2; //JTAG Debugger TDI logic. Refer to JTAG Debugger documentation
logic o_cpu_debug_tdo_2; //JTAG Debugger TDO logic. Refer to JTAG Debugger documentation
logic o_cpu_debug_tdo_en_2; //JTAG Debugger TDO enable logic. Should be attached to the enable port of a tri-state buffer driving TDO if applicable
logic i_dfx_ucss_secure_tap_green_2; //JTAG security level - Green
logic i_dfx_ucss_secure_tap_orange_2; //JTAG security level - Orange
logic i_dfx_ucss_secure_tap_red_2; //JTAG security level - Red
logic i_ck_ucss_jtag_tck_3; //JTAG clock
logic i_rst_ucss_jtag_trst_b_a_3; //JTAG reset
logic [7:0] i_ucss_jtag_id_nt_3; //Sets JTAG ID for JTAG controller. Used during private EN instruction to enable other private instructions
logic [31:0] i_ucss_jtag_slvid_nt_3; //Sets JTAG Slave ID for JTAG controller. logic when performing SLVIDCODE. Must be unique
logic i_ucss_jtag_tms_3; //JTAG TMS logic. Refer to JTAG documentation
logic i_ucss_jtag_tdi_3; //JTAG TDI logic. Refer to JTAG documentation
logic o_ucss_jtag_tdo_en_3; //JTAG TDO enable logic. Should be attached to the enable port of a tri-state buffer driving TDO if applicable
logic o_ucss_jtag_tdo_3; //JTAG TDO logic. Refer to JTAG documentation
logic i_ck_cpu_debug_tck_3; //JTAG Debugger clock
logic i_rst_cpu_debug_trst_b_a_3; //JTAG resett
logic [15:0] i_cpu_debug_prid_nt_3; //CPU TAP (Debugger) IID
logic i_cpu_debug_tms_3; //JTAG Debugger TMS logic. Refer to JTAG
logic i_cpu_debug_tdi_3; //JTAG Debugger TDI logic. Refer to JTAG Debugger documentation
logic o_cpu_debug_tdo_3; //JTAG Debugger TDO logic. Refer to JTAG Debugger documentation
logic o_cpu_debug_tdo_en_3; //JTAG Debugger TDO enable logic. Should be attached to the enable port of a tri-state buffer driving TDO if applicable
logic i_dfx_ucss_secure_tap_green_3; //JTAG security level - Green
logic i_dfx_ucss_secure_tap_orange_3; //JTAG security level - Orange
logic i_dfx_ucss_secure_tap_red_3; //JTAG security level - Red
logic i_ck_fscan_pma_ref_0; //Scan clock for reference clock domain. Driven by SOC at SOC level
logic i_ck_fscan_pma_apb_0; //Scan clock for APB clock domain. Driven by SOC at SOC level
logic i_ck_fscan_pma_cmnpll_postdiv_0; //Scan clock for CMN PLL postdivider logic
logic i_ck_fscan_pma_postclk_refclk_clk_cmnpll_0; //Scan clock for CMN PLL A and CMN PLL B logic
logic i_ck_fscan_pma_postclk_refclk_clk_txpll_0; //Scan clock for TxPLL PLL logic for all lanes
logic i_ck_fscan_ucss_postclk_0; //Scan clock
logic i_fscan_clkgenctrl_nt_0; //Unused
logic i_fscan_clkgenctrlen_nt_0; //TBD
logic i_fscan_clkungate_nt_0; //Enable for architectural clock gating
logic i_fscan_clkungate_syn_nt_0; //Enable for power complier inserted clock gating
logic i_fscan_shiften_nt_0; //Enable for shift mode. 1'b0: Capture mode. 1'b1: Shift mode
logic i_fscan_latchclosed_b_nt_0; //PLL Active low latch control
logic i_fscan_latchopen_nt_0; //PLL Active high latch control
logic i_fscan_mode_atspeed_nt_0; //This is a static signal that indicates that the device is in atspeed scan mode. Not used currently. It can be used in case any difference arises in terms of clocking or if need to bypass any logic from scan in the at-speed mode in future
logic i_fscan_mode_nt_0; //Enables scan test mode
logic i_fscan_ret_control_nt_0; //PLL Active low latch control
logic i_rst_fscan_byprst_b_0; //Scan reset bypass
logic i_rst_fscan_byplatrst_b_0; //TBD
logic i_fscan_rstbypen_nt_0; //This is a static signal this is used to mux the scan reset i.e. i_rst_fscan_byprst_b signal onto the functional resets within the IPs when this signal is set to 1'b1
logic i_fscan_slos_en_nt_0; //SLOS enable signal. Set to 1 to enable synchronous launch off shift feature in ATPG.
logic i_fscan_chain_bypass_nt_0; //pll chain bypass enable
logic i_fscan_latch_bypass_in_nt_0; //chain latch in bypass enable
logic i_fscan_latch_bypass_out_nt_0; //chain latch out bypass enable
logic i_fscan_pll_isolate_nt_0; //Currently unused.
logic i_fscan_pll_scan_if_dis_nt_0; //disable scan controls.
logic [79:0] i_fscan_pma0_sdi_ref_cmn_0; //Scan data bus
logic [3:0] i_fscan_pma0_sdi_apb_cmn_0; //Scan data bus
logic [41:0] i_fscan_pma0_sdi_ref_channelcmn_0; //Scan data bus
logic [9:0] i_fscan_pma0_sdi_cmnplla_0; //Scan data bus
logic [9:0] i_fscan_pma0_sdi_cmnpllb_0; //Scan data bus
logic [79:0] o_ascan_pma0_sdo_ref_cmn_0; //Scan data bus
logic [3:0] o_ascan_pma0_sdo_apb_cmn_0; //Scan data bus
logic [41:0] o_ascan_pma0_sdo_ref_channelcmn_0; //Scan data bus
logic [9:0] o_ascan_pma0_sdo_cmnplla_0; //Scan data bus
logic [9:0] o_ascan_pma0_sdo_cmnpllb_0; //Scan data bus
logic [19:0] i_fscan_pma0_sdi_ctrl_l0_0; //Scan data bus
logic [49:0] i_fscan_pma0_sdi_memarray_word_l0_0; //Scan data bus
logic [89:0] i_fscan_pma0_sdi_ref_l0_0; //Scan data bus
logic [149:0] i_fscan_pma0_sdi_word_l0_0; //Scan data bus
logic [41:0] i_fscan_pma0_sdi_ref_channelleft_l0_0; //Scan data bus
logic [41:0] i_fscan_pma0_sdi_ref_channelright_l0_0; //Scan data bus
logic [17:0] i_fscan_pma0_sdi_ref_txffe_l0_0; //Scan data bus
logic [6:0] i_fscan_pma0_sdi_word_txffe_l0_0; //Scan data bus
logic [9:0] i_fscan_pma0_sdi_txpll_l0_0; //Scan data bus
logic [19:0] o_ascan_pma0_sdo_ctrl_l0_0; //Scan data bus
logic [49:0] o_ascan_pma0_sdo_memarray_word_l0_0; //Scan data bus
logic [89:0] o_ascan_pma0_sdo_ref_l0_0; //Scan data bus
logic [149:0] o_ascan_pma0_sdo_word_l0_0; //Scan data bus
logic [41:0] o_ascan_pma0_sdo_ref_channelleft_l0_0; //Scan data bus
logic [41:0] o_ascan_pma0_sdo_ref_channelright_l0_0; //Scan data bus
logic [17:0] o_ascan_pma0_sdo_ref_txffe_l0_0; //Scan data bus
logic [6:0] o_ascan_pma0_sdo_word_txffe_l0_0; //Scan data bus
logic [9:0] o_ascan_pma0_sdo_txpll_l0_0; //Scan data bus
logic [79:0] i_fscan_pma1_sdi_ref_cmn_0; //Scan data bus
logic [3:0] i_fscan_pma1_sdi_apb_cmn_0; //Scan data bus
logic [41:0] i_fscan_pma1_sdi_ref_channelcmn_0; //Scan data bus
logic [9:0] i_fscan_pma1_sdi_cmnplla_0; //Scan data bus
logic [9:0] i_fscan_pma1_sdi_cmnpllb_0; //Scan data bus
logic [79:0] o_ascan_pma1_sdo_ref_cmn_0; //Scan data bus
logic [3:0] o_ascan_pma1_sdo_apb_cmn_0; //Scan data bus
logic [41:0] o_ascan_pma1_sdo_ref_channelcmn_0; //Scan data bus
logic [9:0] o_ascan_pma1_sdo_cmnplla_0; //Scan data bus
logic [9:0] o_ascan_pma1_sdo_cmnpllb_0; //Scan data bus
logic [19:0] i_fscan_pma1_sdi_ctrl_l0_0; //Scan data bus
logic [49:0] i_fscan_pma1_sdi_memarray_word_l0_0; //Scan data bus
logic [89:0] i_fscan_pma1_sdi_ref_l0_0; //Scan data bus
logic [149:0] i_fscan_pma1_sdi_word_l0_0; //Scan data bus
logic [41:0] i_fscan_pma1_sdi_ref_channelleft_l0_0; //Scan data bus
logic [41:0] i_fscan_pma1_sdi_ref_channelright_l0_0; //Scan data bus
logic [17:0] i_fscan_pma1_sdi_ref_txffe_l0_0; //Scan data bus
logic [6:0] i_fscan_pma1_sdi_word_txffe_l0_0; //Scan data bus
logic [9:0] i_fscan_pma1_sdi_txpll_l0_0; //Scan data bus
logic [19:0] o_ascan_pma1_sdo_ctrl_l0_0; //Scan data bus
logic [49:0] o_ascan_pma1_sdo_memarray_word_l0_0; //Scan data bus
logic [89:0] o_ascan_pma1_sdo_ref_l0_0; //Scan data bus
logic [149:0] o_ascan_pma1_sdo_word_l0_0; //Scan data bus
logic [41:0] o_ascan_pma1_sdo_ref_channelleft_l0_0; //Scan data bus
logic [41:0] o_ascan_pma1_sdo_ref_channelright_l0_0; //Scan data bus
logic [17:0] o_ascan_pma1_sdo_ref_txffe_l0_0; //Scan data bus
logic [6:0] o_ascan_pma1_sdo_word_txffe_l0_0; //Scan data bus
logic [9:0] o_ascan_pma1_sdo_txpll_l0_0; //Scan data bus
logic [79:0] i_fscan_pma2_sdi_ref_cmn_0; //Scan data bus
logic [3:0] i_fscan_pma2_sdi_apb_cmn_0; //Scan data bus
logic [41:0] i_fscan_pma2_sdi_ref_channelcmn_0; //Scan data bus
logic [9:0] i_fscan_pma2_sdi_cmnplla_0; //Scan data bus
logic [9:0] i_fscan_pma2_sdi_cmnpllb_0; //Scan data bus
logic [79:0] o_ascan_pma2_sdo_ref_cmn_0; //Scan data bus
logic [3:0] o_ascan_pma2_sdo_apb_cmn_0; //Scan data bus
logic [41:0] o_ascan_pma2_sdo_ref_channelcmn_0; //Scan data bus
logic [9:0] o_ascan_pma2_sdo_cmnplla_0; //Scan data bus
logic [9:0] o_ascan_pma2_sdo_cmnpllb_0; //Scan data bus
logic [19:0] i_fscan_pma2_sdi_ctrl_l0_0; //Scan data bus
logic [49:0] i_fscan_pma2_sdi_memarray_word_l0_0; //Scan data bus
logic [89:0] i_fscan_pma2_sdi_ref_l0_0; //Scan data bus
logic [149:0] i_fscan_pma2_sdi_word_l0_0; //Scan data bus
logic [41:0] i_fscan_pma2_sdi_ref_channelleft_l0_0; //Scan data bus
logic [41:0] i_fscan_pma2_sdi_ref_channelright_l0_0; //Scan data bus
logic [17:0] i_fscan_pma2_sdi_ref_txffe_l0_0; //Scan data bus
logic [6:0] i_fscan_pma2_sdi_word_txffe_l0_0; //Scan data bus
logic [9:0] i_fscan_pma2_sdi_txpll_l0_0; //Scan data bus
logic [19:0] o_ascan_pma2_sdo_ctrl_l0_0; //Scan data bus
logic [49:0] o_ascan_pma2_sdo_memarray_word_l0_0; //Scan data bus
logic [89:0] o_ascan_pma2_sdo_ref_l0_0; //Scan data bus
logic [149:0] o_ascan_pma2_sdo_word_l0_0; //Scan data bus
logic [41:0] o_ascan_pma2_sdo_ref_channelleft_l0_0; //Scan data bus
logic [41:0] o_ascan_pma2_sdo_ref_channelright_l0_0; //Scan data bus
logic [17:0] o_ascan_pma2_sdo_ref_txffe_l0_0; //Scan data bus
logic [6:0] o_ascan_pma2_sdo_word_txffe_l0_0; //Scan data bus
logic [9:0] o_ascan_pma2_sdo_txpll_l0_0; //Scan data bus
logic [79:0] i_fscan_pma3_sdi_ref_cmn_0; //Scan data bus
logic [3:0] i_fscan_pma3_sdi_apb_cmn_0; //Scan data bus
logic [41:0] i_fscan_pma3_sdi_ref_channelcmn_0; //Scan data bus
logic [9:0] i_fscan_pma3_sdi_cmnplla_0; //Scan data bus
logic [9:0] i_fscan_pma3_sdi_cmnpllb_0; //Scan data bus
logic [79:0] o_ascan_pma3_sdo_ref_cmn_0; //Scan data bus
logic [3:0] o_ascan_pma3_sdo_apb_cmn_0; //Scan data bus
logic [41:0] o_ascan_pma3_sdo_ref_channelcmn_0; //Scan data bus
logic [9:0] o_ascan_pma3_sdo_cmnplla_0; //Scan data bus
logic [9:0] o_ascan_pma3_sdo_cmnpllb_0; //Scan data bus
logic [19:0] i_fscan_pma3_sdi_ctrl_l0_0; //Scan data bus
logic [49:0] i_fscan_pma3_sdi_memarray_word_l0_0; //Scan data bus
logic [89:0] i_fscan_pma3_sdi_ref_l0_0; //Scan data bus
logic [149:0] i_fscan_pma3_sdi_word_l0_0; //Scan data bus
logic [41:0] i_fscan_pma3_sdi_ref_channelleft_l0_0; //Scan data bus
logic [41:0] i_fscan_pma3_sdi_ref_channelright_l0_0; //Scan data bus
logic [17:0] i_fscan_pma3_sdi_ref_txffe_l0_0; //Scan data bus
logic [6:0] i_fscan_pma3_sdi_word_txffe_l0_0; //Scan data bus
logic [9:0] i_fscan_pma3_sdi_txpll_l0_0; //Scan data bus
logic [19:0] o_ascan_pma3_sdo_ctrl_l0_0; //Scan data bus
logic [49:0] o_ascan_pma3_sdo_memarray_word_l0_0; //Scan data bus
logic [89:0] o_ascan_pma3_sdo_ref_l0_0; //Scan data bus
logic [149:0] o_ascan_pma3_sdo_word_l0_0; //Scan data bus
logic [41:0] o_ascan_pma3_sdo_ref_channelleft_l0_0; //Scan data bus
logic [41:0] o_ascan_pma3_sdo_ref_channelright_l0_0; //Scan data bus
logic [17:0] o_ascan_pma3_sdo_ref_txffe_l0_0; //Scan data bus
logic [6:0] o_ascan_pma3_sdo_word_txffe_l0_0; //Scan data bus
logic [9:0] o_ascan_pma3_sdo_txpll_l0_0; //Scan data bus
logic i_ck_fscan_pma_ref_1; //Scan clock for reference clock domain. Driven by SOC at SOC level
logic i_ck_fscan_pma_apb_1; //Scan clock for APB clock domain. Driven by SOC at SOC level
logic i_ck_fscan_pma_cmnpll_postdiv_1; //Scan clock for CMN PLL postdivider logic
logic i_ck_fscan_pma_postclk_refclk_clk_cmnpll_1; //Scan clock for CMN PLL A and CMN PLL B logic
logic i_ck_fscan_pma_postclk_refclk_clk_txpll_1; //Scan clock for TxPLL PLL logic for all lanes
logic i_ck_fscan_ucss_postclk_1; //Scan clock
logic i_fscan_clkgenctrl_nt_1; //Unused
logic i_fscan_clkgenctrlen_nt_1; //TBD
logic i_fscan_clkungate_nt_1; //Enable for architectural clock gating
logic i_fscan_clkungate_syn_nt_1; //Enable for power complier inserted clock gating
logic i_fscan_shiften_nt_1; //Enable for shift mode. 1'b0: Capture mode. 1'b1: Shift mode
logic i_fscan_latchclosed_b_nt_1; //PLL Active low latch control
logic i_fscan_latchopen_nt_1; //PLL Active high latch control
logic i_fscan_mode_atspeed_nt_1; //This is a static signal that indicates that the device is in atspeed scan mode. Not used currently. It can be used in case any difference arises in terms of clocking or if need to bypass any logic from scan in the at-speed mode in future
logic i_fscan_mode_nt_1; //Enables scan test mode
logic i_fscan_ret_control_nt_1; //PLL Active low latch control
logic i_rst_fscan_byprst_b_1; //Scan reset bypass
logic i_rst_fscan_byplatrst_b_1; //TBD
logic i_fscan_rstbypen_nt_1; //This is a static signal this is used to mux the scan reset i.e. i_rst_fscan_byprst_b signal onto the functional resets within the IPs when this signal is set to 1'b1
logic i_fscan_slos_en_nt_1; //SLOS enable signal. Set to 1 to enable synchronous launch off shift feature in ATPG.
logic i_fscan_chain_bypass_nt_1; //pll chain bypass enable
logic i_fscan_latch_bypass_in_nt_1; //chain latch in bypass enable
logic i_fscan_latch_bypass_out_nt_1; //chain latch out bypass enable
logic i_fscan_pll_isolate_nt_1; //Currently unused.
logic i_fscan_pll_scan_if_dis_nt_1; //disable scan controls.
logic [79:0] i_fscan_pma0_sdi_ref_cmn_1; //Scan data bus
logic [3:0] i_fscan_pma0_sdi_apb_cmn_1; //Scan data bus
logic [41:0] i_fscan_pma0_sdi_ref_channelcmn_1; //Scan data bus
logic [9:0] i_fscan_pma0_sdi_cmnplla_1; //Scan data bus
logic [9:0] i_fscan_pma0_sdi_cmnpllb_1; //Scan data bus
logic [79:0] o_ascan_pma0_sdo_ref_cmn_1; //Scan data bus
logic [3:0] o_ascan_pma0_sdo_apb_cmn_1; //Scan data bus
logic [41:0] o_ascan_pma0_sdo_ref_channelcmn_1; //Scan data bus
logic [9:0] o_ascan_pma0_sdo_cmnplla_1; //Scan data bus
logic [9:0] o_ascan_pma0_sdo_cmnpllb_1; //Scan data bus
logic [19:0] i_fscan_pma0_sdi_ctrl_l0_1; //Scan data bus
logic [49:0] i_fscan_pma0_sdi_memarray_word_l0_1; //Scan data bus
logic [89:0] i_fscan_pma0_sdi_ref_l0_1; //Scan data bus
logic [149:0] i_fscan_pma0_sdi_word_l0_1; //Scan data bus
logic [41:0] i_fscan_pma0_sdi_ref_channelleft_l0_1; //Scan data bus
logic [41:0] i_fscan_pma0_sdi_ref_channelright_l0_1; //Scan data bus
logic [17:0] i_fscan_pma0_sdi_ref_txffe_l0_1; //Scan data bus
logic [6:0] i_fscan_pma0_sdi_word_txffe_l0_1; //Scan data bus
logic [9:0] i_fscan_pma0_sdi_txpll_l0_1; //Scan data bus
logic [19:0] o_ascan_pma0_sdo_ctrl_l0_1; //Scan data bus
logic [49:0] o_ascan_pma0_sdo_memarray_word_l0_1; //Scan data bus
logic [89:0] o_ascan_pma0_sdo_ref_l0_1; //Scan data bus
logic [149:0] o_ascan_pma0_sdo_word_l0_1; //Scan data bus
logic [41:0] o_ascan_pma0_sdo_ref_channelleft_l0_1; //Scan data bus
logic [41:0] o_ascan_pma0_sdo_ref_channelright_l0_1; //Scan data bus
logic [17:0] o_ascan_pma0_sdo_ref_txffe_l0_1; //Scan data bus
logic [6:0] o_ascan_pma0_sdo_word_txffe_l0_1; //Scan data bus
logic [9:0] o_ascan_pma0_sdo_txpll_l0_1; //Scan data bus
logic [79:0] i_fscan_pma1_sdi_ref_cmn_1; //Scan data bus
logic [3:0] i_fscan_pma1_sdi_apb_cmn_1; //Scan data bus
logic [41:0] i_fscan_pma1_sdi_ref_channelcmn_1; //Scan data bus
logic [9:0] i_fscan_pma1_sdi_cmnplla_1; //Scan data bus
logic [9:0] i_fscan_pma1_sdi_cmnpllb_1; //Scan data bus
logic [79:0] o_ascan_pma1_sdo_ref_cmn_1; //Scan data bus
logic [3:0] o_ascan_pma1_sdo_apb_cmn_1; //Scan data bus
logic [41:0] o_ascan_pma1_sdo_ref_channelcmn_1; //Scan data bus
logic [9:0] o_ascan_pma1_sdo_cmnplla_1; //Scan data bus
logic [9:0] o_ascan_pma1_sdo_cmnpllb_1; //Scan data bus
logic [19:0] i_fscan_pma1_sdi_ctrl_l0_1; //Scan data bus
logic [49:0] i_fscan_pma1_sdi_memarray_word_l0_1; //Scan data bus
logic [89:0] i_fscan_pma1_sdi_ref_l0_1; //Scan data bus
logic [149:0] i_fscan_pma1_sdi_word_l0_1; //Scan data bus
logic [41:0] i_fscan_pma1_sdi_ref_channelleft_l0_1; //Scan data bus
logic [41:0] i_fscan_pma1_sdi_ref_channelright_l0_1; //Scan data bus
logic [17:0] i_fscan_pma1_sdi_ref_txffe_l0_1; //Scan data bus
logic [6:0] i_fscan_pma1_sdi_word_txffe_l0_1; //Scan data bus
logic [9:0] i_fscan_pma1_sdi_txpll_l0_1; //Scan data bus
logic [19:0] o_ascan_pma1_sdo_ctrl_l0_1; //Scan data bus
logic [49:0] o_ascan_pma1_sdo_memarray_word_l0_1; //Scan data bus
logic [89:0] o_ascan_pma1_sdo_ref_l0_1; //Scan data bus
logic [149:0] o_ascan_pma1_sdo_word_l0_1; //Scan data bus
logic [41:0] o_ascan_pma1_sdo_ref_channelleft_l0_1; //Scan data bus
logic [41:0] o_ascan_pma1_sdo_ref_channelright_l0_1; //Scan data bus
logic [17:0] o_ascan_pma1_sdo_ref_txffe_l0_1; //Scan data bus
logic [6:0] o_ascan_pma1_sdo_word_txffe_l0_1; //Scan data bus
logic [9:0] o_ascan_pma1_sdo_txpll_l0_1; //Scan data bus
logic [79:0] i_fscan_pma2_sdi_ref_cmn_1; //Scan data bus
logic [3:0] i_fscan_pma2_sdi_apb_cmn_1; //Scan data bus
logic [41:0] i_fscan_pma2_sdi_ref_channelcmn_1; //Scan data bus
logic [9:0] i_fscan_pma2_sdi_cmnplla_1; //Scan data bus
logic [9:0] i_fscan_pma2_sdi_cmnpllb_1; //Scan data bus
logic [79:0] o_ascan_pma2_sdo_ref_cmn_1; //Scan data bus
logic [3:0] o_ascan_pma2_sdo_apb_cmn_1; //Scan data bus
logic [41:0] o_ascan_pma2_sdo_ref_channelcmn_1; //Scan data bus
logic [9:0] o_ascan_pma2_sdo_cmnplla_1; //Scan data bus
logic [9:0] o_ascan_pma2_sdo_cmnpllb_1; //Scan data bus
logic [19:0] i_fscan_pma2_sdi_ctrl_l0_1; //Scan data bus
logic [49:0] i_fscan_pma2_sdi_memarray_word_l0_1; //Scan data bus
logic [89:0] i_fscan_pma2_sdi_ref_l0_1; //Scan data bus
logic [149:0] i_fscan_pma2_sdi_word_l0_1; //Scan data bus
logic [41:0] i_fscan_pma2_sdi_ref_channelleft_l0_1; //Scan data bus
logic [41:0] i_fscan_pma2_sdi_ref_channelright_l0_1; //Scan data bus
logic [17:0] i_fscan_pma2_sdi_ref_txffe_l0_1; //Scan data bus
logic [6:0] i_fscan_pma2_sdi_word_txffe_l0_1; //Scan data bus
logic [9:0] i_fscan_pma2_sdi_txpll_l0_1; //Scan data bus
logic [19:0] o_ascan_pma2_sdo_ctrl_l0_1; //Scan data bus
logic [49:0] o_ascan_pma2_sdo_memarray_word_l0_1; //Scan data bus
logic [89:0] o_ascan_pma2_sdo_ref_l0_1; //Scan data bus
logic [149:0] o_ascan_pma2_sdo_word_l0_1; //Scan data bus
logic [41:0] o_ascan_pma2_sdo_ref_channelleft_l0_1; //Scan data bus
logic [41:0] o_ascan_pma2_sdo_ref_channelright_l0_1; //Scan data bus
logic [17:0] o_ascan_pma2_sdo_ref_txffe_l0_1; //Scan data bus
logic [6:0] o_ascan_pma2_sdo_word_txffe_l0_1; //Scan data bus
logic [9:0] o_ascan_pma2_sdo_txpll_l0_1; //Scan data bus
logic [79:0] i_fscan_pma3_sdi_ref_cmn_1; //Scan data bus
logic [3:0] i_fscan_pma3_sdi_apb_cmn_1; //Scan data bus
logic [41:0] i_fscan_pma3_sdi_ref_channelcmn_1; //Scan data bus
logic [9:0] i_fscan_pma3_sdi_cmnplla_1; //Scan data bus
logic [9:0] i_fscan_pma3_sdi_cmnpllb_1; //Scan data bus
logic [79:0] o_ascan_pma3_sdo_ref_cmn_1; //Scan data bus
logic [3:0] o_ascan_pma3_sdo_apb_cmn_1; //Scan data bus
logic [41:0] o_ascan_pma3_sdo_ref_channelcmn_1; //Scan data bus
logic [9:0] o_ascan_pma3_sdo_cmnplla_1; //Scan data bus
logic [9:0] o_ascan_pma3_sdo_cmnpllb_1; //Scan data bus
logic [19:0] i_fscan_pma3_sdi_ctrl_l0_1; //Scan data bus
logic [49:0] i_fscan_pma3_sdi_memarray_word_l0_1; //Scan data bus
logic [89:0] i_fscan_pma3_sdi_ref_l0_1; //Scan data bus
logic [149:0] i_fscan_pma3_sdi_word_l0_1; //Scan data bus
logic [41:0] i_fscan_pma3_sdi_ref_channelleft_l0_1; //Scan data bus
logic [41:0] i_fscan_pma3_sdi_ref_channelright_l0_1; //Scan data bus
logic [17:0] i_fscan_pma3_sdi_ref_txffe_l0_1; //Scan data bus
logic [6:0] i_fscan_pma3_sdi_word_txffe_l0_1; //Scan data bus
logic [9:0] i_fscan_pma3_sdi_txpll_l0_1; //Scan data bus
logic [19:0] o_ascan_pma3_sdo_ctrl_l0_1; //Scan data bus
logic [49:0] o_ascan_pma3_sdo_memarray_word_l0_1; //Scan data bus
logic [89:0] o_ascan_pma3_sdo_ref_l0_1; //Scan data bus
logic [149:0] o_ascan_pma3_sdo_word_l0_1; //Scan data bus
logic [41:0] o_ascan_pma3_sdo_ref_channelleft_l0_1; //Scan data bus
logic [41:0] o_ascan_pma3_sdo_ref_channelright_l0_1; //Scan data bus
logic [17:0] o_ascan_pma3_sdo_ref_txffe_l0_1; //Scan data bus
logic [6:0] o_ascan_pma3_sdo_word_txffe_l0_1; //Scan data bus
logic [9:0] o_ascan_pma3_sdo_txpll_l0_1; //Scan data bus
logic i_ck_fscan_pma_ref_2; //Scan clock for reference clock domain. Driven by SOC at SOC level/i_fscan_pma2_sdi_ref_channelcmn_2
logic i_ck_fscan_pma_apb_2; //Scan clock for APB clock domain. Driven by SOC at SOC level
logic i_ck_fscan_pma_cmnpll_postdiv_2; //Scan clock for CMN PLL postdivider logic
logic i_ck_fscan_pma_postclk_refclk_clk_cmnpll_2; //Scan clock for CMN PLL A and CMN PLL B logic
logic i_ck_fscan_pma_postclk_refclk_clk_txpll_2; //Scan clock for TxPLL PLL logic for all lanes
logic i_ck_fscan_ucss_postclk_2; //Scan clock
logic i_fscan_clkgenctrl_nt_2; //Unused
logic i_fscan_clkgenctrlen_nt_2; //TBD
logic i_fscan_clkungate_nt_2; //Enable for architectural clock gating
logic i_fscan_clkungate_syn_nt_2; //Enable for power complier inserted clock gating
logic i_fscan_shiften_nt_2; //Enable for shift mode. 1'b0: Capture mode. 1'b1: Shift mode
logic i_fscan_latchclosed_b_nt_2; //PLL Active low latch control
logic i_fscan_latchopen_nt_2; //PLL Active high latch control
logic i_fscan_mode_atspeed_nt_2; //This is a static signal that indicates that the device is in atspeed scan mode. Not used currently. It can be used in case any difference arises in terms of clocking or if need to bypass any logic from scan in the at-speed mode in future
logic i_fscan_mode_nt_2; //Enables scan test mode
logic i_fscan_ret_control_nt_2; //PLL Active low latch control
logic i_rst_fscan_byprst_b_2; //Scan reset bypass
logic i_rst_fscan_byplatrst_b_2; //TBD
logic i_fscan_rstbypen_nt_2; //This is a static signal this is used to mux the scan reset i.e. i_rst_fscan_byprst_b signal onto the functional resets within the IPs when this signal is set to 1'b1
logic i_fscan_slos_en_nt_2; //SLOS enable signal. Set to 1 to enable synchronous launch off shift feature in ATPG.
logic i_fscan_chain_bypass_nt_2; //pll chain bypass enable
logic i_fscan_latch_bypass_in_nt_2; //chain latch in bypass enable
logic i_fscan_latch_bypass_out_nt_2; //chain latch out bypass enable
logic i_fscan_pll_isolate_nt_2; //Currently unused.
logic i_fscan_pll_scan_if_dis_nt_2; //disable scan controls.
logic [79:0] i_fscan_pma0_sdi_ref_cmn_2; //Scan data bus
logic [3:0] i_fscan_pma0_sdi_apb_cmn_2; //Scan data bus
logic [41:0] i_fscan_pma0_sdi_ref_channelcmn_2; //Scan data bus
logic [9:0] i_fscan_pma0_sdi_cmnplla_2; //Scan data bus
logic [9:0] i_fscan_pma0_sdi_cmnpllb_2; //Scan data bus
logic [79:0] o_ascan_pma0_sdo_ref_cmn_2; //Scan data bus
logic [3:0] o_ascan_pma0_sdo_apb_cmn_2; //Scan data bus
logic [41:0] o_ascan_pma0_sdo_ref_channelcmn_2; //Scan data bus
logic [9:0] o_ascan_pma0_sdo_cmnplla_2; //Scan data bus
logic [9:0] o_ascan_pma0_sdo_cmnpllb_2; //Scan data bus
logic [19:0] i_fscan_pma0_sdi_ctrl_l0_2; //Scan data bus
logic [49:0] i_fscan_pma0_sdi_memarray_word_l0_2; //Scan data bus
logic [89:0] i_fscan_pma0_sdi_ref_l0_2; //Scan data bus
logic [149:0] i_fscan_pma0_sdi_word_l0_2; //Scan data bus
logic [41:0] i_fscan_pma0_sdi_ref_channelleft_l0_2; //Scan data bus
logic [41:0] i_fscan_pma0_sdi_ref_channelright_l0_2; //Scan data bus
logic [17:0] i_fscan_pma0_sdi_ref_txffe_l0_2; //Scan data bus
logic [6:0] i_fscan_pma0_sdi_word_txffe_l0_2; //Scan data bus
logic [9:0] i_fscan_pma0_sdi_txpll_l0_2; //Scan data bus
logic [19:0] o_ascan_pma0_sdo_ctrl_l0_2; //Scan data bus
logic [49:0] o_ascan_pma0_sdo_memarray_word_l0_2; //Scan data bus
logic [89:0] o_ascan_pma0_sdo_ref_l0_2; //Scan data bus
logic [149:0] o_ascan_pma0_sdo_word_l0_2; //Scan data bus
logic [41:0] o_ascan_pma0_sdo_ref_channelleft_l0_2; //Scan data bus
logic [41:0] o_ascan_pma0_sdo_ref_channelright_l0_2; //Scan data bus
logic [17:0] o_ascan_pma0_sdo_ref_txffe_l0_2; //Scan data bus
logic [6:0] o_ascan_pma0_sdo_word_txffe_l0_2; //Scan data bus
logic [9:0] o_ascan_pma0_sdo_txpll_l0_2; //Scan data bus
logic [79:0] i_fscan_pma1_sdi_ref_cmn_2; //Scan data bus
logic [3:0] i_fscan_pma1_sdi_apb_cmn_2; //Scan data bus
logic [41:0] i_fscan_pma1_sdi_ref_channelcmn_2; //Scan data bus
logic [9:0] i_fscan_pma1_sdi_cmnplla_2; //Scan data bus
logic [9:0] i_fscan_pma1_sdi_cmnpllb_2; //Scan data bus
logic [79:0] o_ascan_pma1_sdo_ref_cmn_2; //Scan data bus
logic [3:0] o_ascan_pma1_sdo_apb_cmn_2; //Scan data bus
logic [41:0] o_ascan_pma1_sdo_ref_channelcmn_2; //Scan data bus
logic [9:0] o_ascan_pma1_sdo_cmnplla_2; //Scan data bus
logic [9:0] o_ascan_pma1_sdo_cmnpllb_2; //Scan data bus
logic [19:0] i_fscan_pma1_sdi_ctrl_l0_2; //Scan data bus
logic [49:0] i_fscan_pma1_sdi_memarray_word_l0_2; //Scan data bus
logic [89:0] i_fscan_pma1_sdi_ref_l0_2; //Scan data bus
logic [149:0] i_fscan_pma1_sdi_word_l0_2; //Scan data bus
logic [41:0] i_fscan_pma1_sdi_ref_channelleft_l0_2; //Scan data bus
logic [41:0] i_fscan_pma1_sdi_ref_channelright_l0_2; //Scan data bus
logic [17:0] i_fscan_pma1_sdi_ref_txffe_l0_2; //Scan data bus
logic [6:0] i_fscan_pma1_sdi_word_txffe_l0_2; //Scan data bus
logic [9:0] i_fscan_pma1_sdi_txpll_l0_2; //Scan data bus
logic [19:0] o_ascan_pma1_sdo_ctrl_l0_2; //Scan data bus
logic [49:0] o_ascan_pma1_sdo_memarray_word_l0_2; //Scan data bus
logic [89:0] o_ascan_pma1_sdo_ref_l0_2; //Scan data bus
logic [149:0] o_ascan_pma1_sdo_word_l0_2; //Scan data bus
logic [41:0] o_ascan_pma1_sdo_ref_channelleft_l0_2; //Scan data bus
logic [41:0] o_ascan_pma1_sdo_ref_channelright_l0_2; //Scan data bus
logic [17:0] o_ascan_pma1_sdo_ref_txffe_l0_2; //Scan data bus
logic [6:0] o_ascan_pma1_sdo_word_txffe_l0_2; //Scan data bus
logic [9:0] o_ascan_pma1_sdo_txpll_l0_2; //Scan data bus
logic [79:0] i_fscan_pma2_sdi_ref_cmn_2; //Scan data bus
logic [3:0] i_fscan_pma2_sdi_apb_cmn_2; //Scan data bus
logic [41:0] i_fscan_pma2_sdi_ref_channelcmn_2; //Scan data bus
logic [9:0] i_fscan_pma2_sdi_cmnplla_2; //Scan data bus
logic [9:0] i_fscan_pma2_sdi_cmnpllb_2; //Scan data bus
logic [79:0] o_ascan_pma2_sdo_ref_cmn_2; //Scan data bus
logic [3:0] o_ascan_pma2_sdo_apb_cmn_2; //Scan data bus
logic [41:0] o_ascan_pma2_sdo_ref_channelcmn_2; //Scan data bus
logic [9:0] o_ascan_pma2_sdo_cmnplla_2; //Scan data bus
logic [9:0] o_ascan_pma2_sdo_cmnpllb_2; //Scan data bus
logic [19:0] i_fscan_pma2_sdi_ctrl_l0_2; //Scan data bus
logic [49:0] i_fscan_pma2_sdi_memarray_word_l0_2; //Scan data bus
logic [89:0] i_fscan_pma2_sdi_ref_l0_2; //Scan data bus
logic [149:0] i_fscan_pma2_sdi_word_l0_2; //Scan data bus
logic [41:0] i_fscan_pma2_sdi_ref_channelleft_l0_2; //Scan data bus
logic [41:0] i_fscan_pma2_sdi_ref_channelright_l0_2; //Scan data bus
logic [17:0] i_fscan_pma2_sdi_ref_txffe_l0_2; //Scan data bus
logic [6:0] i_fscan_pma2_sdi_word_txffe_l0_2; //Scan data bus
logic [9:0] i_fscan_pma2_sdi_txpll_l0_2; //Scan data bus
logic [19:0] o_ascan_pma2_sdo_ctrl_l0_2; //Scan data bus
logic [49:0] o_ascan_pma2_sdo_memarray_word_l0_2; //Scan data bus
logic [89:0] o_ascan_pma2_sdo_ref_l0_2; //Scan data bus
logic [149:0] o_ascan_pma2_sdo_word_l0_2; //Scan data bus
logic [41:0] o_ascan_pma2_sdo_ref_channelleft_l0_2; //Scan data bus
logic [41:0] o_ascan_pma2_sdo_ref_channelright_l0_2; //Scan data bus
logic [17:0] o_ascan_pma2_sdo_ref_txffe_l0_2; //Scan data bus
logic [6:0] o_ascan_pma2_sdo_word_txffe_l0_2; //Scan data bus
logic [9:0] o_ascan_pma2_sdo_txpll_l0_2; //Scan data bus
logic [79:0] i_fscan_pma3_sdi_ref_cmn_2; //Scan data bus
logic [3:0] i_fscan_pma3_sdi_apb_cmn_2; //Scan data bus
logic [41:0] i_fscan_pma3_sdi_ref_channelcmn_2; //Scan data bus
logic [9:0] i_fscan_pma3_sdi_cmnplla_2; //Scan data bus
logic [9:0] i_fscan_pma3_sdi_cmnpllb_2; //Scan data bus
logic [79:0] o_ascan_pma3_sdo_ref_cmn_2; //Scan data bus
logic [3:0] o_ascan_pma3_sdo_apb_cmn_2; //Scan data bus
logic [41:0] o_ascan_pma3_sdo_ref_channelcmn_2; //Scan data bus
logic [9:0] o_ascan_pma3_sdo_cmnplla_2; //Scan data bus
logic [9:0] o_ascan_pma3_sdo_cmnpllb_2; //Scan data bus
logic [19:0] i_fscan_pma3_sdi_ctrl_l0_2; //Scan data bus
logic [49:0] i_fscan_pma3_sdi_memarray_word_l0_2; //Scan data bus
logic [89:0] i_fscan_pma3_sdi_ref_l0_2; //Scan data bus
logic [149:0] i_fscan_pma3_sdi_word_l0_2; //Scan data bus
logic [41:0] i_fscan_pma3_sdi_ref_channelleft_l0_2; //Scan data bus
logic [41:0] i_fscan_pma3_sdi_ref_channelright_l0_2; //Scan data bus
logic [17:0] i_fscan_pma3_sdi_ref_txffe_l0_2; //Scan data bus
logic [6:0] i_fscan_pma3_sdi_word_txffe_l0_2; //Scan data bus
logic [9:0] i_fscan_pma3_sdi_txpll_l0_2; //Scan data bus
logic [19:0] o_ascan_pma3_sdo_ctrl_l0_2; //Scan data bus
logic [49:0] o_ascan_pma3_sdo_memarray_word_l0_2; //Scan data bus
logic [89:0] o_ascan_pma3_sdo_ref_l0_2; //Scan data bus
logic [149:0] o_ascan_pma3_sdo_word_l0_2; //Scan data bus
logic [41:0] o_ascan_pma3_sdo_ref_channelleft_l0_2; //Scan data bus
logic [41:0] o_ascan_pma3_sdo_ref_channelright_l0_2; //Scan data bus
logic [17:0] o_ascan_pma3_sdo_ref_txffe_l0_2; //Scan data bus
logic [6:0] o_ascan_pma3_sdo_word_txffe_l0_2; //Scan data bus
logic [9:0] o_ascan_pma3_sdo_txpll_l0_2; //Scan data bus
logic i_ck_fscan_pma_ref_3; //Scan clock for reference clock domain. Driven by SOC at SOC level
logic i_ck_fscan_pma_apb_3; //Scan clock for APB clock domain. Driven by SOC at SOC level
logic i_ck_fscan_pma_cmnpll_postdiv_3; //Scan clock for CMN PLL postdivider logic
logic i_ck_fscan_pma_postclk_refclk_clk_cmnpll_3; //Scan clock for CMN PLL A and CMN PLL B logic
logic i_ck_fscan_pma_postclk_refclk_clk_txpll_3; //Scan clock for TxPLL PLL logic for all lanes
logic i_ck_fscan_ucss_postclk_3; //Scan clock
logic i_fscan_clkgenctrl_nt_3; //Unused
logic i_fscan_clkgenctrlen_nt_3; //TBD
logic i_fscan_clkungate_nt_3; //Enable for architectural clock gating
logic i_fscan_clkungate_syn_nt_3; //Enable for power complier inserted clock gating
logic i_fscan_shiften_nt_3; //Enable for shift mode. 1'b0: Capture mode. 1'b1: Shift mode
logic i_fscan_latchclosed_b_nt_3; //PLL Active low latch control
logic i_fscan_latchopen_nt_3; //PLL Active high latch control
logic i_fscan_mode_atspeed_nt_3; //This is a static signal that indicates that the device is in atspeed scan mode. Not used currently. It can be used in case any difference arises in terms of clocking or if need to bypass any logic from scan in the at-speed mode in future
logic i_fscan_mode_nt_3; //Enables scan test mode
logic i_fscan_ret_control_nt_3; //PLL Active low latch control
logic i_rst_fscan_byprst_b_3; //Scan reset bypass
logic i_rst_fscan_byplatrst_b_3; //TBD
logic i_fscan_rstbypen_nt_3; //This is a static signal this is used to mux the scan reset i.e. i_rst_fscan_byprst_b signal onto the functional resets within the IPs when this signal is set to 1'b1
logic i_fscan_slos_en_nt_3; //SLOS enable signal. Set to 1 to enable synchronous launch off shift feature in ATPG.
logic i_fscan_chain_bypass_nt_3; //pll chain bypass enable
logic i_fscan_latch_bypass_in_nt_3; //chain latch in bypass enable
logic i_fscan_latch_bypass_out_nt_3; //chain latch out bypass enable
logic i_fscan_pll_isolate_nt_3; //Currently unused.
logic i_fscan_pll_scan_if_dis_nt_3; //disable scan controls.
logic [79:0] i_fscan_pma0_sdi_ref_cmn_3; //Scan data bus
logic [3:0] i_fscan_pma0_sdi_apb_cmn_3; //Scan data bus
logic [41:0] i_fscan_pma0_sdi_ref_channelcmn_3; //Scan data bus
logic [9:0] i_fscan_pma0_sdi_cmnplla_3; //Scan data bus
logic [9:0] i_fscan_pma0_sdi_cmnpllb_3; //Scan data bus
logic [79:0] o_ascan_pma0_sdo_ref_cmn_3; //Scan data bus
logic [3:0] o_ascan_pma0_sdo_apb_cmn_3; //Scan data bus
logic [41:0] o_ascan_pma0_sdo_ref_channelcmn_3; //Scan data bus
logic [9:0] o_ascan_pma0_sdo_cmnplla_3; //Scan data bus
logic [9:0] o_ascan_pma0_sdo_cmnpllb_3; //Scan data bus
logic [19:0] i_fscan_pma0_sdi_ctrl_l0_3; //Scan data bus
logic [49:0] i_fscan_pma0_sdi_memarray_word_l0_3; //Scan data bus
logic [89:0] i_fscan_pma0_sdi_ref_l0_3; //Scan data bus
logic [149:0] i_fscan_pma0_sdi_word_l0_3; //Scan data bus
logic [41:0] i_fscan_pma0_sdi_ref_channelleft_l0_3; //Scan data bus
logic [41:0] i_fscan_pma0_sdi_ref_channelright_l0_3; //Scan data bus
logic [17:0] i_fscan_pma0_sdi_ref_txffe_l0_3; //Scan data bus
logic [6:0] i_fscan_pma0_sdi_word_txffe_l0_3; //Scan data bus
logic [9:0] i_fscan_pma0_sdi_txpll_l0_3; //Scan data bus
logic [19:0] o_ascan_pma0_sdo_ctrl_l0_3; //Scan data bus
logic [49:0] o_ascan_pma0_sdo_memarray_word_l0_3; //Scan data bus
logic [89:0] o_ascan_pma0_sdo_ref_l0_3; //Scan data bus
logic [149:0] o_ascan_pma0_sdo_word_l0_3; //Scan data bus
logic [41:0] o_ascan_pma0_sdo_ref_channelleft_l0_3; //Scan data bus
logic [41:0] o_ascan_pma0_sdo_ref_channelright_l0_3; //Scan data bus
logic [17:0] o_ascan_pma0_sdo_ref_txffe_l0_3; //Scan data bus
logic [6:0] o_ascan_pma0_sdo_word_txffe_l0_3; //Scan data bus
logic [9:0] o_ascan_pma0_sdo_txpll_l0_3; //Scan data bus
logic [79:0] i_fscan_pma1_sdi_ref_cmn_3; //Scan data bus
logic [3:0] i_fscan_pma1_sdi_apb_cmn_3; //Scan data bus
logic [41:0] i_fscan_pma1_sdi_ref_channelcmn_3; //Scan data bus
logic [9:0] i_fscan_pma1_sdi_cmnplla_3; //Scan data bus
logic [9:0] i_fscan_pma1_sdi_cmnpllb_3; //Scan data bus
logic [79:0] o_ascan_pma1_sdo_ref_cmn_3; //Scan data bus
logic [3:0] o_ascan_pma1_sdo_apb_cmn_3; //Scan data bus
logic [41:0] o_ascan_pma1_sdo_ref_channelcmn_3; //Scan data bus
logic [9:0] o_ascan_pma1_sdo_cmnplla_3; //Scan data bus
logic [9:0] o_ascan_pma1_sdo_cmnpllb_3; //Scan data bus
logic [19:0] i_fscan_pma1_sdi_ctrl_l0_3; //Scan data bus
logic [49:0] i_fscan_pma1_sdi_memarray_word_l0_3; //Scan data bus
logic [89:0] i_fscan_pma1_sdi_ref_l0_3; //Scan data bus
logic [149:0] i_fscan_pma1_sdi_word_l0_3; //Scan data bus
logic [41:0] i_fscan_pma1_sdi_ref_channelleft_l0_3; //Scan data bus
logic [41:0] i_fscan_pma1_sdi_ref_channelright_l0_3; //Scan data bus
logic [17:0] i_fscan_pma1_sdi_ref_txffe_l0_3; //Scan data bus
logic [6:0] i_fscan_pma1_sdi_word_txffe_l0_3; //Scan data bus
logic [9:0] i_fscan_pma1_sdi_txpll_l0_3; //Scan data bus
logic [19:0] o_ascan_pma1_sdo_ctrl_l0_3; //Scan data bus
logic [49:0] o_ascan_pma1_sdo_memarray_word_l0_3; //Scan data bus
logic [89:0] o_ascan_pma1_sdo_ref_l0_3; //Scan data bus
logic [149:0] o_ascan_pma1_sdo_word_l0_3; //Scan data bus
logic [41:0] o_ascan_pma1_sdo_ref_channelleft_l0_3; //Scan data bus
logic [41:0] o_ascan_pma1_sdo_ref_channelright_l0_3; //Scan data bus
logic [17:0] o_ascan_pma1_sdo_ref_txffe_l0_3; //Scan data bus
logic [6:0] o_ascan_pma1_sdo_word_txffe_l0_3; //Scan data bus
logic [9:0] o_ascan_pma1_sdo_txpll_l0_3; //Scan data bus
logic [79:0] i_fscan_pma2_sdi_ref_cmn_3; //Scan data bus
logic [3:0] i_fscan_pma2_sdi_apb_cmn_3; //Scan data bus
logic [41:0] i_fscan_pma2_sdi_ref_channelcmn_3; //Scan data bus
logic [9:0] i_fscan_pma2_sdi_cmnplla_3; //Scan data bus
logic [9:0] i_fscan_pma2_sdi_cmnpllb_3; //Scan data bus
logic [79:0] o_ascan_pma2_sdo_ref_cmn_3; //Scan data bus
logic [3:0] o_ascan_pma2_sdo_apb_cmn_3; //Scan data bus
logic [41:0] o_ascan_pma2_sdo_ref_channelcmn_3; //Scan data bus
logic [9:0] o_ascan_pma2_sdo_cmnplla_3; //Scan data bus
logic [9:0] o_ascan_pma2_sdo_cmnpllb_3; //Scan data bus
logic [19:0] i_fscan_pma2_sdi_ctrl_l0_3; //Scan data bus
logic [49:0] i_fscan_pma2_sdi_memarray_word_l0_3; //Scan data bus
logic [89:0] i_fscan_pma2_sdi_ref_l0_3; //Scan data bus
logic [149:0] i_fscan_pma2_sdi_word_l0_3; //Scan data bus
logic [41:0] i_fscan_pma2_sdi_ref_channelleft_l0_3; //Scan data bus
logic [41:0] i_fscan_pma2_sdi_ref_channelright_l0_3; //Scan data bus
logic [17:0] i_fscan_pma2_sdi_ref_txffe_l0_3; //Scan data bus
logic [6:0] i_fscan_pma2_sdi_word_txffe_l0_3; //Scan data bus
logic [9:0] i_fscan_pma2_sdi_txpll_l0_3; //Scan data bus
logic [19:0] o_ascan_pma2_sdo_ctrl_l0_3; //Scan data bus
logic [49:0] o_ascan_pma2_sdo_memarray_word_l0_3; //Scan data bus
logic [89:0] o_ascan_pma2_sdo_ref_l0_3; //Scan data bus
logic [149:0] o_ascan_pma2_sdo_word_l0_3; //Scan data bus
logic [41:0] o_ascan_pma2_sdo_ref_channelleft_l0_3; //Scan data bus
logic [41:0] o_ascan_pma2_sdo_ref_channelright_l0_3; //Scan data bus
logic [17:0] o_ascan_pma2_sdo_ref_txffe_l0_3; //Scan data bus
logic [6:0] o_ascan_pma2_sdo_word_txffe_l0_3; //Scan data bus
logic [9:0] o_ascan_pma2_sdo_txpll_l0_3; //Scan data bus
logic [79:0] i_fscan_pma3_sdi_ref_cmn_3; //Scan data bus
logic [3:0] i_fscan_pma3_sdi_apb_cmn_3; //Scan data bus
logic [41:0] i_fscan_pma3_sdi_ref_channelcmn_3; //Scan data bus
logic [9:0] i_fscan_pma3_sdi_cmnplla_3; //Scan data bus
logic [9:0] i_fscan_pma3_sdi_cmnpllb_3; //Scan data bus
logic [79:0] o_ascan_pma3_sdo_ref_cmn_3; //Scan data bus
logic [3:0] o_ascan_pma3_sdo_apb_cmn_3; //Scan data bus
logic [41:0] o_ascan_pma3_sdo_ref_channelcmn_3; //Scan data bus
logic [9:0] o_ascan_pma3_sdo_cmnplla_3; //Scan data bus
logic [9:0] o_ascan_pma3_sdo_cmnpllb_3; //Scan data bus
logic [19:0] i_fscan_pma3_sdi_ctrl_l0_3; //Scan data bus
logic [49:0] i_fscan_pma3_sdi_memarray_word_l0_3; //Scan data bus
logic [89:0] i_fscan_pma3_sdi_ref_l0_3; //Scan data bus
logic [149:0] i_fscan_pma3_sdi_word_l0_3; //Scan data bus
logic [41:0] i_fscan_pma3_sdi_ref_channelleft_l0_3; //Scan data bus
logic [41:0] i_fscan_pma3_sdi_ref_channelright_l0_3; //Scan data bus
logic [17:0] i_fscan_pma3_sdi_ref_txffe_l0_3; //Scan data bus
logic [6:0] i_fscan_pma3_sdi_word_txffe_l0_3; //Scan data bus
logic [9:0] i_fscan_pma3_sdi_txpll_l0_3; //Scan data bus
logic [19:0] o_ascan_pma3_sdo_ctrl_l0_3; //Scan data bus
logic [49:0] o_ascan_pma3_sdo_memarray_word_l0_3; //Scan data bus
logic [89:0] o_ascan_pma3_sdo_ref_l0_3; //Scan data bus
logic [149:0] o_ascan_pma3_sdo_word_l0_3; //Scan data bus
logic [41:0] o_ascan_pma3_sdo_ref_channelleft_l0_3; //Scan data bus
logic [41:0] o_ascan_pma3_sdo_ref_channelright_l0_3; //Scan data bus
logic [17:0] o_ascan_pma3_sdo_ref_txffe_l0_3; //Scan data bus
logic [6:0] o_ascan_pma3_sdo_word_txffe_l0_3; //Scan data bus
logic [9:0] o_ascan_pma3_sdo_txpll_l0_3; //Scan data bus
logic i_scanio_en_nt_0; //Scanio mode enable. 1'b0: Scanio mode disabled. 1'b1: Scanio mode enabled
logic i_scanio_pma0_ref0_outen_nt_0; //When in scanio mode direction control for xioa_ck_ref0_*. 1'b0: xioa_ck_ref0_* are both logics. 1'b1: xioa_ck_ref0_* are both logics
logic i_scanio_pma0_ref1_outen_nt_0; //When in scanio mode direction control for xioa_ck_ref1_*. 1'b0: xioa_ck_ref1_* are both logics. 1'b1: xioa_ck_ref1_* are both logics
logic i_scanio_pma0_dat_ref0_n_a_0; //Value driven to xioa_ck_ref0_n when i_scanio_en_nt is 1 and i_scanio_ref0_outen_nt is 1
logic i_scanio_pma0_dat_ref0_p_a_0; //Value driven to xioa_ck_ref0_p when i_scanio_en_nt is 1 and i_scanio_ref0_outen_nt is 1
logic i_scanio_pma0_dat_ref1_n_a_0; //Value driven to xioa_ck_ref1_n when i_scanio_en_nt is 1 and i_scanio_ref1_outen_nt is 1
logic i_scanio_pma0_dat_ref1_p_a_0; //Value driven to xioa_ck_ref1_p when i_scanio_en_nt is 1 and i_scanio_ref1_outen_nt is 1
logic i_scanio_pma0_dat_tx_p_l0_a_0; //When in scanio mode xoa_tx_p_l0 follows this value
logic i_scanio_pma0_dat_tx_n_l0_a_0; //When in scanio mode xoa_tx_n_l0 follows this value
logic o_scanio_pma0_dat_ref0_n_a_0; //Follows xioa_ck_ref0_n when i_scanio_en_nt is 1 and i_scanio_ref0_outen_nt is 0
logic o_scanio_pma0_dat_ref0_p_a_0; //Follows xioa_ck_ref1_p when i_scanio_en_nt is 1 and i_scanio_ref0_outen_nt is 0
logic o_scanio_pma0_dat_ref1_n_a_0; //Follows xioa_ck_ref1_n when i_scanio_en_nt is 1 and i_scanio_ref1_outen_nt is 0
logic o_scanio_pma0_dat_ref1_p_a_0; //Follows xioa_ck_ref1_p when i_scanio_en_nt is 1 and i_scanio_ref1_outen_nt is 0
logic o_scanio_pma0_dat_rx_n_l0_a_0; //When in scanio mode follows the value of xia_rx_n_l0
logic o_scanio_pma0_dat_rx_p_l0_a_0; //When in scanio mode follows the value of xia_rx_p_l0
logic i_scanio_pma1_ref0_outen_nt_0; //When in scanio mode direction control for xioa_ck_ref0_*. 1'b0: xioa_ck_ref0_* are both logics. 1'b1: xioa_ck_ref0_* are both logics
logic i_scanio_pma1_ref1_outen_nt_0; //When in scanio mode direction control for xioa_ck_ref1_*. 1'b0: xioa_ck_ref1_* are both logics. 1'b1: xioa_ck_ref1_* are both logics
logic i_scanio_pma1_dat_ref0_n_a_0; //Value driven to xioa_ck_ref0_n when i_scanio_en_nt is 1 and i_scanio_ref0_outen_nt is 1
logic i_scanio_pma1_dat_ref0_p_a_0; //Value driven to xioa_ck_ref0_p when i_scanio_en_nt is 1 and i_scanio_ref0_outen_nt is 1
logic i_scanio_pma1_dat_ref1_n_a_0; //Value driven to xioa_ck_ref1_n when i_scanio_en_nt is 1 and i_scanio_ref1_outen_nt is 1
logic i_scanio_pma1_dat_ref1_p_a_0; //Value driven to xioa_ck_ref1_p when i_scanio_en_nt is 1 and i_scanio_ref1_outen_nt is 1
logic i_scanio_pma1_dat_tx_p_l0_a_0; //When in scanio mode xoa_tx_p_l0 follows this value
logic i_scanio_pma1_dat_tx_n_l0_a_0; //When in scanio mode xoa_tx_n_l0 follows this value
logic o_scanio_pma1_dat_ref0_n_a_0; //Follows xioa_ck_ref0_n when i_scanio_en_nt is 1 and i_scanio_ref0_outen_nt is 0
logic o_scanio_pma1_dat_ref0_p_a_0; //Follows xioa_ck_ref1_p when i_scanio_en_nt is 1 and i_scanio_ref0_outen_nt is 0
logic o_scanio_pma1_dat_ref1_n_a_0; //Follows xioa_ck_ref1_n when i_scanio_en_nt is 1 and i_scanio_ref1_outen_nt is 0
logic o_scanio_pma1_dat_ref1_p_a_0; //Follows xioa_ck_ref1_p when i_scanio_en_nt is 1 and i_scanio_ref1_outen_nt is 0
logic o_scanio_pma1_dat_rx_n_l0_a_0; //When in scanio mode follows the value of xia_rx_n_l0
logic o_scanio_pma1_dat_rx_p_l0_a_0; //When in scanio mode follows the value of xia_rx_p_l0
logic i_scanio_pma2_ref0_outen_nt_0; //When in scanio mode direction control for xioa_ck_ref0_*. 1'b0: xioa_ck_ref0_* are both logics. 1'b1: xioa_ck_ref0_* are both logics
logic i_scanio_pma2_ref1_outen_nt_0; //When in scanio mode direction control for xioa_ck_ref1_*. 1'b0: xioa_ck_ref1_* are both logics. 1'b1: xioa_ck_ref1_* are both logics
logic i_scanio_pma2_dat_ref0_n_a_0; //Value driven to xioa_ck_ref0_n when i_scanio_en_nt is 1 and i_scanio_ref0_outen_nt is 1
logic i_scanio_pma2_dat_ref0_p_a_0; //Value driven to xioa_ck_ref0_p when i_scanio_en_nt is 1 and i_scanio_ref0_outen_nt is 1
logic i_scanio_pma2_dat_ref1_n_a_0; //Value driven to xioa_ck_ref1_n when i_scanio_en_nt is 1 and i_scanio_ref1_outen_nt is 1
logic i_scanio_pma2_dat_ref1_p_a_0; //Value driven to xioa_ck_ref1_p when i_scanio_en_nt is 1 and i_scanio_ref1_outen_nt is 1
logic i_scanio_pma2_dat_tx_p_l0_a_0; //When in scanio mode xoa_tx_p_l0 follows this value
logic i_scanio_pma2_dat_tx_n_l0_a_0; //When in scanio mode xoa_tx_n_l0 follows this value
logic o_scanio_pma2_dat_ref0_n_a_0; //Follows xioa_ck_ref0_n when i_scanio_en_nt is 1 and i_scanio_ref0_outen_nt is 0
logic o_scanio_pma2_dat_ref0_p_a_0; //Follows xioa_ck_ref1_p when i_scanio_en_nt is 1 and i_scanio_ref0_outen_nt is 0
logic o_scanio_pma2_dat_ref1_n_a_0; //Follows xioa_ck_ref1_n when i_scanio_en_nt is 1 and i_scanio_ref1_outen_nt is 0
logic o_scanio_pma2_dat_ref1_p_a_0; //Follows xioa_ck_ref1_p when i_scanio_en_nt is 1 and i_scanio_ref1_outen_nt is 0
logic o_scanio_pma2_dat_rx_n_l0_a_0; //When in scanio mode follows the value of xia_rx_n_l0
logic o_scanio_pma2_dat_rx_p_l0_a_0; //When in scanio mode follows the value of xia_rx_p_l0
logic i_scanio_pma3_ref0_outen_nt_0; //When in scanio mode direction control for xioa_ck_ref0_*. 1'b0: xioa_ck_ref0_* are both logics. 1'b1: xioa_ck_ref0_* are both logics
logic i_scanio_pma3_ref1_outen_nt_0; //When in scanio mode direction control for xioa_ck_ref1_*. 1'b0: xioa_ck_ref1_* are both logics. 1'b1: xioa_ck_ref1_* are both logics
logic i_scanio_pma3_dat_ref0_n_a_0; //Value driven to xioa_ck_ref0_n when i_scanio_en_nt is 1 and i_scanio_ref0_outen_nt is 1
logic i_scanio_pma3_dat_ref0_p_a_0; //Value driven to xioa_ck_ref0_p when i_scanio_en_nt is 1 and i_scanio_ref0_outen_nt is 1
logic i_scanio_pma3_dat_ref1_n_a_0; //Value driven to xioa_ck_ref1_n when i_scanio_en_nt is 1 and i_scanio_ref1_outen_nt is 1
logic i_scanio_pma3_dat_ref1_p_a_0; //Value driven to xioa_ck_ref1_p when i_scanio_en_nt is 1 and i_scanio_ref1_outen_nt is 1
logic i_scanio_pma3_dat_tx_p_l0_a_0; //When in scanio mode xoa_tx_p_l0 follows this value
logic i_scanio_pma3_dat_tx_n_l0_a_0; //When in scanio mode xoa_tx_n_l0 follows this value
logic o_scanio_pma3_dat_ref0_n_a_0; //Follows xioa_ck_ref0_n when i_scanio_en_nt is 1 and i_scanio_ref0_outen_nt is 0
logic o_scanio_pma3_dat_ref0_p_a_0; //Follows xioa_ck_ref1_p when i_scanio_en_nt is 1 and i_scanio_ref0_outen_nt is 0
logic o_scanio_pma3_dat_ref1_n_a_0; //Follows xioa_ck_ref1_n when i_scanio_en_nt is 1 and i_scanio_ref1_outen_nt is 0
logic o_scanio_pma3_dat_ref1_p_a_0; //Follows xioa_ck_ref1_p when i_scanio_en_nt is 1 and i_scanio_ref1_outen_nt is 0
logic o_scanio_pma3_dat_rx_n_l0_a_0; //When in scanio mode follows the value of xia_rx_n_l0
logic o_scanio_pma3_dat_rx_p_l0_a_0; //When in scanio mode follows the value of xia_rx_p_l0
logic i_scanio_en_nt_1; //Scanio mode enable. 1'b0: Scanio mode disabled. 1'b1: Scanio mode enabled
logic i_scanio_pma0_ref0_outen_nt_1; //When in scanio mode direction control for xioa_ck_ref0_*. 1'b0: xioa_ck_ref0_* are both logics. 1'b1: xioa_ck_ref0_* are both logics
logic i_scanio_pma0_ref1_outen_nt_1; //When in scanio mode direction control for xioa_ck_ref1_*. 1'b0: xioa_ck_ref1_* are both logics. 1'b1: xioa_ck_ref1_* are both logics
logic i_scanio_pma0_dat_ref0_n_a_1; //Value driven to xioa_ck_ref0_n when i_scanio_en_nt is 1 and i_scanio_ref0_outen_nt is 1
logic i_scanio_pma0_dat_ref0_p_a_1; //Value driven to xioa_ck_ref0_p when i_scanio_en_nt is 1 and i_scanio_ref0_outen_nt is 1
logic i_scanio_pma0_dat_ref1_n_a_1; //Value driven to xioa_ck_ref1_n when i_scanio_en_nt is 1 and i_scanio_ref1_outen_nt is 1
logic i_scanio_pma0_dat_ref1_p_a_1; //Value driven to xioa_ck_ref1_p when i_scanio_en_nt is 1 and i_scanio_ref1_outen_nt is 1
logic i_scanio_pma0_dat_tx_p_l0_a_1; //When in scanio mode xoa_tx_p_l0 follows this value
logic i_scanio_pma0_dat_tx_n_l0_a_1; //When in scanio mode xoa_tx_n_l0 follows this value
logic o_scanio_pma0_dat_ref0_n_a_1; //Follows xioa_ck_ref0_n when i_scanio_en_nt is 1 and i_scanio_ref0_outen_nt is 0
logic o_scanio_pma0_dat_ref0_p_a_1; //Follows xioa_ck_ref1_p when i_scanio_en_nt is 1 and i_scanio_ref0_outen_nt is 0
logic o_scanio_pma0_dat_ref1_n_a_1; //Follows xioa_ck_ref1_n when i_scanio_en_nt is 1 and i_scanio_ref1_outen_nt is 0
logic o_scanio_pma0_dat_ref1_p_a_1; //Follows xioa_ck_ref1_p when i_scanio_en_nt is 1 and i_scanio_ref1_outen_nt is 0
logic o_scanio_pma0_dat_rx_n_l0_a_1; //When in scanio mode follows the value of xia_rx_n_l0
logic o_scanio_pma0_dat_rx_p_l0_a_1; //When in scanio mode follows the value of xia_rx_p_l0
logic i_scanio_pma1_ref0_outen_nt_1; //When in scanio mode direction control for xioa_ck_ref0_*. 1'b0: xioa_ck_ref0_* are both logics. 1'b1: xioa_ck_ref0_* are both logics
logic i_scanio_pma1_ref1_outen_nt_1; //When in scanio mode direction control for xioa_ck_ref1_*. 1'b0: xioa_ck_ref1_* are both logics. 1'b1: xioa_ck_ref1_* are both logics
logic i_scanio_pma1_dat_ref0_n_a_1; //Value driven to xioa_ck_ref0_n when i_scanio_en_nt is 1 and i_scanio_ref0_outen_nt is 1
logic i_scanio_pma1_dat_ref0_p_a_1; //Value driven to xioa_ck_ref0_p when i_scanio_en_nt is 1 and i_scanio_ref0_outen_nt is 1
logic i_scanio_pma1_dat_ref1_n_a_1; //Value driven to xioa_ck_ref1_n when i_scanio_en_nt is 1 and i_scanio_ref1_outen_nt is 1
logic i_scanio_pma1_dat_ref1_p_a_1; //Value driven to xioa_ck_ref1_p when i_scanio_en_nt is 1 and i_scanio_ref1_outen_nt is 1
logic i_scanio_pma1_dat_tx_p_l0_a_1; //When in scanio mode xoa_tx_p_l0 follows this value
logic i_scanio_pma1_dat_tx_n_l0_a_1; //When in scanio mode xoa_tx_n_l0 follows this value
logic o_scanio_pma1_dat_ref0_n_a_1; //Follows xioa_ck_ref0_n when i_scanio_en_nt is 1 and i_scanio_ref0_outen_nt is 0
logic o_scanio_pma1_dat_ref0_p_a_1; //Follows xioa_ck_ref1_p when i_scanio_en_nt is 1 and i_scanio_ref0_outen_nt is 0
logic o_scanio_pma1_dat_ref1_n_a_1; //Follows xioa_ck_ref1_n when i_scanio_en_nt is 1 and i_scanio_ref1_outen_nt is 0
logic o_scanio_pma1_dat_ref1_p_a_1; //Follows xioa_ck_ref1_p when i_scanio_en_nt is 1 and i_scanio_ref1_outen_nt is 0
logic o_scanio_pma1_dat_rx_n_l0_a_1; //When in scanio mode follows the value of xia_rx_n_l0
logic o_scanio_pma1_dat_rx_p_l0_a_1; //When in scanio mode follows the value of xia_rx_p_l0
logic i_scanio_pma2_ref0_outen_nt_1; //When in scanio mode direction control for xioa_ck_ref0_*. 1'b0: xioa_ck_ref0_* are both logics. 1'b1: xioa_ck_ref0_* are both logics
logic i_scanio_pma2_ref1_outen_nt_1; //When in scanio mode direction control for xioa_ck_ref1_*. 1'b0: xioa_ck_ref1_* are both logics. 1'b1: xioa_ck_ref1_* are both logics
logic i_scanio_pma2_dat_ref0_n_a_1; //Value driven to xioa_ck_ref0_n when i_scanio_en_nt is 1 and i_scanio_ref0_outen_nt is 1
logic i_scanio_pma2_dat_ref0_p_a_1; //Value driven to xioa_ck_ref0_p when i_scanio_en_nt is 1 and i_scanio_ref0_outen_nt is 1
logic i_scanio_pma2_dat_ref1_n_a_1; //Value driven to xioa_ck_ref1_n when i_scanio_en_nt is 1 and i_scanio_ref1_outen_nt is 1
logic i_scanio_pma2_dat_ref1_p_a_1; //Value driven to xioa_ck_ref1_p when i_scanio_en_nt is 1 and i_scanio_ref1_outen_nt is 1
logic i_scanio_pma2_dat_tx_p_l0_a_1; //When in scanio mode xoa_tx_p_l0 follows this value
logic i_scanio_pma2_dat_tx_n_l0_a_1; //When in scanio mode xoa_tx_n_l0 follows this value
logic o_scanio_pma2_dat_ref0_n_a_1; //Follows xioa_ck_ref0_n when i_scanio_en_nt is 1 and i_scanio_ref0_outen_nt is 0
logic o_scanio_pma2_dat_ref0_p_a_1; //Follows xioa_ck_ref1_p when i_scanio_en_nt is 1 and i_scanio_ref0_outen_nt is 0
logic o_scanio_pma2_dat_ref1_n_a_1; //Follows xioa_ck_ref1_n when i_scanio_en_nt is 1 and i_scanio_ref1_outen_nt is 0
logic o_scanio_pma2_dat_ref1_p_a_1; //Follows xioa_ck_ref1_p when i_scanio_en_nt is 1 and i_scanio_ref1_outen_nt is 0
logic o_scanio_pma2_dat_rx_n_l0_a_1; //When in scanio mode follows the value of xia_rx_n_l0
logic o_scanio_pma2_dat_rx_p_l0_a_1; //When in scanio mode follows the value of xia_rx_p_l0
logic i_scanio_pma3_ref0_outen_nt_1; //When in scanio mode direction control for xioa_ck_ref0_*. 1'b0: xioa_ck_ref0_* are both logics. 1'b1: xioa_ck_ref0_* are both logics
logic i_scanio_pma3_ref1_outen_nt_1; //When in scanio mode direction control for xioa_ck_ref1_*. 1'b0: xioa_ck_ref1_* are both logics. 1'b1: xioa_ck_ref1_* are both logics
logic i_scanio_pma3_dat_ref0_n_a_1; //Value driven to xioa_ck_ref0_n when i_scanio_en_nt is 1 and i_scanio_ref0_outen_nt is 1
logic i_scanio_pma3_dat_ref0_p_a_1; //Value driven to xioa_ck_ref0_p when i_scanio_en_nt is 1 and i_scanio_ref0_outen_nt is 1
logic i_scanio_pma3_dat_ref1_n_a_1; //Value driven to xioa_ck_ref1_n when i_scanio_en_nt is 1 and i_scanio_ref1_outen_nt is 1
logic i_scanio_pma3_dat_ref1_p_a_1; //Value driven to xioa_ck_ref1_p when i_scanio_en_nt is 1 and i_scanio_ref1_outen_nt is 1
logic i_scanio_pma3_dat_tx_p_l0_a_1; //When in scanio mode xoa_tx_p_l0 follows this value
logic i_scanio_pma3_dat_tx_n_l0_a_1; //When in scanio mode xoa_tx_n_l0 follows this value
logic o_scanio_pma3_dat_ref0_n_a_1; //Follows xioa_ck_ref0_n when i_scanio_en_nt is 1 and i_scanio_ref0_outen_nt is 0
logic o_scanio_pma3_dat_ref0_p_a_1; //Follows xioa_ck_ref1_p when i_scanio_en_nt is 1 and i_scanio_ref0_outen_nt is 0
logic o_scanio_pma3_dat_ref1_n_a_1; //Follows xioa_ck_ref1_n when i_scanio_en_nt is 1 and i_scanio_ref1_outen_nt is 0
logic o_scanio_pma3_dat_ref1_p_a_1; //Follows xioa_ck_ref1_p when i_scanio_en_nt is 1 and i_scanio_ref1_outen_nt is 0
logic o_scanio_pma3_dat_rx_n_l0_a_1; //When in scanio mode follows the value of xia_rx_n_l0
logic o_scanio_pma3_dat_rx_p_l0_a_1; //When in scanio mode follows the value of xia_rx_p_l0
logic i_scanio_en_nt_2; //Scanio mode enable. 1'b0: Scanio mode disabled. 1'b1: Scanio mode enabled
logic i_scanio_pma0_ref0_outen_nt_2; //When in scanio mode direction control for xioa_ck_ref0_*. 1'b0: xioa_ck_ref0_* are both logics. 1'b1: xioa_ck_ref0_* are both logics
logic i_scanio_pma0_ref1_outen_nt_2; //When in scanio mode direction control for xioa_ck_ref1_*. 1'b0: xioa_ck_ref1_* are both logics. 1'b1: xioa_ck_ref1_* are both logics
logic i_scanio_pma0_dat_ref0_n_a_2; //Value driven to xioa_ck_ref0_n when i_scanio_en_nt is 1 and i_scanio_ref0_outen_nt is 1
logic i_scanio_pma0_dat_ref0_p_a_2; //Value driven to xioa_ck_ref0_p when i_scanio_en_nt is 1 and i_scanio_ref0_outen_nt is 1
logic i_scanio_pma0_dat_ref1_n_a_2; //Value driven to xioa_ck_ref1_n when i_scanio_en_nt is 1 and i_scanio_ref1_outen_nt is 1
logic i_scanio_pma0_dat_ref1_p_a_2; //Value driven to xioa_ck_ref1_p when i_scanio_en_nt is 1 and i_scanio_ref1_outen_nt is 1
logic i_scanio_pma0_dat_tx_p_l0_a_2; //When in scanio mode xoa_tx_p_l0 follows this value
logic i_scanio_pma0_dat_tx_n_l0_a_2; //When in scanio mode xoa_tx_n_l0 follows this value
logic o_scanio_pma0_dat_ref0_n_a_2; //Follows xioa_ck_ref0_n when i_scanio_en_nt is 1 and i_scanio_ref0_outen_nt is 0
logic o_scanio_pma0_dat_ref0_p_a_2; //Follows xioa_ck_ref1_p when i_scanio_en_nt is 1 and i_scanio_ref0_outen_nt is 0
logic o_scanio_pma0_dat_ref1_n_a_2; //Follows xioa_ck_ref1_n when i_scanio_en_nt is 1 and i_scanio_ref1_outen_nt is 0
logic o_scanio_pma0_dat_ref1_p_a_2; //Follows xioa_ck_ref1_p when i_scanio_en_nt is 1 and i_scanio_ref1_outen_nt is 0
logic o_scanio_pma0_dat_rx_n_l0_a_2; //When in scanio mode follows the value of xia_rx_n_l0
logic o_scanio_pma0_dat_rx_p_l0_a_2; //When in scanio mode follows the value of xia_rx_p_l0
logic i_scanio_pma1_ref0_outen_nt_2; //When in scanio mode direction control for xioa_ck_ref0_*. 1'b0: xioa_ck_ref0_* are both logics. 1'b1: xioa_ck_ref0_* are both logics
logic i_scanio_pma1_ref1_outen_nt_2; //When in scanio mode direction control for xioa_ck_ref1_*. 1'b0: xioa_ck_ref1_* are both logics. 1'b1: xioa_ck_ref1_* are both logics
logic i_scanio_pma1_dat_ref0_n_a_2; //Value driven to xioa_ck_ref0_n when i_scanio_en_nt is 1 and i_scanio_ref0_outen_nt is 1
logic i_scanio_pma1_dat_ref0_p_a_2; //Value driven to xioa_ck_ref0_p when i_scanio_en_nt is 1 and i_scanio_ref0_outen_nt is 1
logic i_scanio_pma1_dat_ref1_n_a_2; //Value driven to xioa_ck_ref1_n when i_scanio_en_nt is 1 and i_scanio_ref1_outen_nt is 1
logic i_scanio_pma1_dat_ref1_p_a_2; //Value driven to xioa_ck_ref1_p when i_scanio_en_nt is 1 and i_scanio_ref1_outen_nt is 1
logic i_scanio_pma1_dat_tx_p_l0_a_2; //When in scanio mode xoa_tx_p_l0 follows this value
logic i_scanio_pma1_dat_tx_n_l0_a_2; //When in scanio mode xoa_tx_n_l0 follows this value
logic o_scanio_pma1_dat_ref0_n_a_2; //Follows xioa_ck_ref0_n when i_scanio_en_nt is 1 and i_scanio_ref0_outen_nt is 0
logic o_scanio_pma1_dat_ref0_p_a_2; //Follows xioa_ck_ref1_p when i_scanio_en_nt is 1 and i_scanio_ref0_outen_nt is 0
logic o_scanio_pma1_dat_ref1_n_a_2; //Follows xioa_ck_ref1_n when i_scanio_en_nt is 1 and i_scanio_ref1_outen_nt is 0
logic o_scanio_pma1_dat_ref1_p_a_2; //Follows xioa_ck_ref1_p when i_scanio_en_nt is 1 and i_scanio_ref1_outen_nt is 0
logic o_scanio_pma1_dat_rx_n_l0_a_2; //When in scanio mode follows the value of xia_rx_n_l0
logic o_scanio_pma1_dat_rx_p_l0_a_2; //When in scanio mode follows the value of xia_rx_p_l0
logic i_scanio_pma2_ref0_outen_nt_2; //When in scanio mode direction control for xioa_ck_ref0_*. 1'b0: xioa_ck_ref0_* are both logics. 1'b1: xioa_ck_ref0_* are both logics
logic i_scanio_pma2_ref1_outen_nt_2; //When in scanio mode direction control for xioa_ck_ref1_*. 1'b0: xioa_ck_ref1_* are both logics. 1'b1: xioa_ck_ref1_* are both logics
logic i_scanio_pma2_dat_ref0_n_a_2; //Value driven to xioa_ck_ref0_n when i_scanio_en_nt is 1 and i_scanio_ref0_outen_nt is 1
logic i_scanio_pma2_dat_ref0_p_a_2; //Value driven to xioa_ck_ref0_p when i_scanio_en_nt is 1 and i_scanio_ref0_outen_nt is 1
logic i_scanio_pma2_dat_ref1_n_a_2; //Value driven to xioa_ck_ref1_n when i_scanio_en_nt is 1 and i_scanio_ref1_outen_nt is 1
logic i_scanio_pma2_dat_ref1_p_a_2; //Value driven to xioa_ck_ref1_p when i_scanio_en_nt is 1 and i_scanio_ref1_outen_nt is 1
logic i_scanio_pma2_dat_tx_p_l0_a_2; //When in scanio mode xoa_tx_p_l0 follows this value
logic i_scanio_pma2_dat_tx_n_l0_a_2; //When in scanio mode xoa_tx_n_l0 follows this value
logic o_scanio_pma2_dat_ref0_n_a_2; //Follows xioa_ck_ref0_n when i_scanio_en_nt is 1 and i_scanio_ref0_outen_nt is 0
logic o_scanio_pma2_dat_ref0_p_a_2; //Follows xioa_ck_ref1_p when i_scanio_en_nt is 1 and i_scanio_ref0_outen_nt is 0
logic o_scanio_pma2_dat_ref1_n_a_2; //Follows xioa_ck_ref1_n when i_scanio_en_nt is 1 and i_scanio_ref1_outen_nt is 0
logic o_scanio_pma2_dat_ref1_p_a_2; //Follows xioa_ck_ref1_p when i_scanio_en_nt is 1 and i_scanio_ref1_outen_nt is 0
logic o_scanio_pma2_dat_rx_n_l0_a_2; //When in scanio mode follows the value of xia_rx_n_l0
logic o_scanio_pma2_dat_rx_p_l0_a_2; //When in scanio mode follows the value of xia_rx_p_l0
logic i_scanio_pma3_ref0_outen_nt_2; //When in scanio mode direction control for xioa_ck_ref0_*. 1'b0: xioa_ck_ref0_* are both logics. 1'b1: xioa_ck_ref0_* are both logics
logic i_scanio_pma3_ref1_outen_nt_2; //When in scanio mode direction control for xioa_ck_ref1_*. 1'b0: xioa_ck_ref1_* are both logics. 1'b1: xioa_ck_ref1_* are both logics
logic i_scanio_pma3_dat_ref0_n_a_2; //Value driven to xioa_ck_ref0_n when i_scanio_en_nt is 1 and i_scanio_ref0_outen_nt is 1
logic i_scanio_pma3_dat_ref0_p_a_2; //Value driven to xioa_ck_ref0_p when i_scanio_en_nt is 1 and i_scanio_ref0_outen_nt is 1
logic i_scanio_pma3_dat_ref1_n_a_2; //Value driven to xioa_ck_ref1_n when i_scanio_en_nt is 1 and i_scanio_ref1_outen_nt is 1
logic i_scanio_pma3_dat_ref1_p_a_2; //Value driven to xioa_ck_ref1_p when i_scanio_en_nt is 1 and i_scanio_ref1_outen_nt is 1
logic i_scanio_pma3_dat_tx_p_l0_a_2; //When in scanio mode xoa_tx_p_l0 follows this value
logic i_scanio_pma3_dat_tx_n_l0_a_2; //When in scanio mode xoa_tx_n_l0 follows this value
logic o_scanio_pma3_dat_ref0_n_a_2; //Follows xioa_ck_ref0_n when i_scanio_en_nt is 1 and i_scanio_ref0_outen_nt is 0
logic o_scanio_pma3_dat_ref0_p_a_2; //Follows xioa_ck_ref1_p when i_scanio_en_nt is 1 and i_scanio_ref0_outen_nt is 0
logic o_scanio_pma3_dat_ref1_n_a_2; //Follows xioa_ck_ref1_n when i_scanio_en_nt is 1 and i_scanio_ref1_outen_nt is 0
logic o_scanio_pma3_dat_ref1_p_a_2; //Follows xioa_ck_ref1_p when i_scanio_en_nt is 1 and i_scanio_ref1_outen_nt is 0
logic o_scanio_pma3_dat_rx_n_l0_a_2; //When in scanio mode follows the value of xia_rx_n_l0
logic o_scanio_pma3_dat_rx_p_l0_a_2; //When in scanio mode follows the value of xia_rx_p_l0
logic i_scanio_en_nt_3; //Scanio mode enable. 1'b0: Scanio mode disabled. 1'b1: Scanio mode enabled
logic i_scanio_pma0_ref0_outen_nt_3; //When in scanio mode direction control for xioa_ck_ref0_*. 1'b0: xioa_ck_ref0_* are both logics. 1'b1: xioa_ck_ref0_* are both logics
logic i_scanio_pma0_ref1_outen_nt_3; //When in scanio mode direction control for xioa_ck_ref1_*. 1'b0: xioa_ck_ref1_* are both logics. 1'b1: xioa_ck_ref1_* are both logics
logic i_scanio_pma0_dat_ref0_n_a_3; //Value driven to xioa_ck_ref0_n when i_scanio_en_nt is 1 and i_scanio_ref0_outen_nt is 1
logic i_scanio_pma0_dat_ref0_p_a_3; //Value driven to xioa_ck_ref0_p when i_scanio_en_nt is 1 and i_scanio_ref0_outen_nt is 1
logic i_scanio_pma0_dat_ref1_n_a_3; //Value driven to xioa_ck_ref1_n when i_scanio_en_nt is 1 and i_scanio_ref1_outen_nt is 1
logic i_scanio_pma0_dat_ref1_p_a_3; //Value driven to xioa_ck_ref1_p when i_scanio_en_nt is 1 and i_scanio_ref1_outen_nt is 1
logic i_scanio_pma0_dat_tx_p_l0_a_3; //When in scanio mode xoa_tx_p_l0 follows this value
logic i_scanio_pma0_dat_tx_n_l0_a_3; //When in scanio mode xoa_tx_n_l0 follows this value
logic o_scanio_pma0_dat_ref0_n_a_3; //Follows xioa_ck_ref0_n when i_scanio_en_nt is 1 and i_scanio_ref0_outen_nt is 0
logic o_scanio_pma0_dat_ref0_p_a_3; //Follows xioa_ck_ref1_p when i_scanio_en_nt is 1 and i_scanio_ref0_outen_nt is 0
logic o_scanio_pma0_dat_ref1_n_a_3; //Follows xioa_ck_ref1_n when i_scanio_en_nt is 1 and i_scanio_ref1_outen_nt is 0
logic o_scanio_pma0_dat_ref1_p_a_3; //Follows xioa_ck_ref1_p when i_scanio_en_nt is 1 and i_scanio_ref1_outen_nt is 0
logic o_scanio_pma0_dat_rx_n_l0_a_3; //When in scanio mode follows the value of xia_rx_n_l0
logic o_scanio_pma0_dat_rx_p_l0_a_3; //When in scanio mode follows the value of xia_rx_p_l0
logic i_scanio_pma1_ref0_outen_nt_3; //When in scanio mode direction control for xioa_ck_ref0_*. 1'b0: xioa_ck_ref0_* are both logics. 1'b1: xioa_ck_ref0_* are both logics
logic i_scanio_pma1_ref1_outen_nt_3; //When in scanio mode direction control for xioa_ck_ref1_*. 1'b0: xioa_ck_ref1_* are both logics. 1'b1: xioa_ck_ref1_* are both logics
logic i_scanio_pma1_dat_ref0_n_a_3; //Value driven to xioa_ck_ref0_n when i_scanio_en_nt is 1 and i_scanio_ref0_outen_nt is 1
logic i_scanio_pma1_dat_ref0_p_a_3; //Value driven to xioa_ck_ref0_p when i_scanio_en_nt is 1 and i_scanio_ref0_outen_nt is 1
logic i_scanio_pma1_dat_ref1_n_a_3; //Value driven to xioa_ck_ref1_n when i_scanio_en_nt is 1 and i_scanio_ref1_outen_nt is 1
logic i_scanio_pma1_dat_ref1_p_a_3; //Value driven to xioa_ck_ref1_p when i_scanio_en_nt is 1 and i_scanio_ref1_outen_nt is 1
logic i_scanio_pma1_dat_tx_p_l0_a_3; //When in scanio mode xoa_tx_p_l0 follows this value
logic i_scanio_pma1_dat_tx_n_l0_a_3; //When in scanio mode xoa_tx_n_l0 follows this value
logic o_scanio_pma1_dat_ref0_n_a_3; //Follows xioa_ck_ref0_n when i_scanio_en_nt is 1 and i_scanio_ref0_outen_nt is 0
logic o_scanio_pma1_dat_ref0_p_a_3; //Follows xioa_ck_ref1_p when i_scanio_en_nt is 1 and i_scanio_ref0_outen_nt is 0
logic o_scanio_pma1_dat_ref1_n_a_3; //Follows xioa_ck_ref1_n when i_scanio_en_nt is 1 and i_scanio_ref1_outen_nt is 0
logic o_scanio_pma1_dat_ref1_p_a_3; //Follows xioa_ck_ref1_p when i_scanio_en_nt is 1 and i_scanio_ref1_outen_nt is 0
logic o_scanio_pma1_dat_rx_n_l0_a_3; //When in scanio mode follows the value of xia_rx_n_l0
logic o_scanio_pma1_dat_rx_p_l0_a_3; //When in scanio mode follows the value of xia_rx_p_l0
logic i_scanio_pma2_ref0_outen_nt_3; //When in scanio mode direction control for xioa_ck_ref0_*. 1'b0: xioa_ck_ref0_* are both logics. 1'b1: xioa_ck_ref0_* are both logics
logic i_scanio_pma2_ref1_outen_nt_3; //When in scanio mode direction control for xioa_ck_ref1_*. 1'b0: xioa_ck_ref1_* are both logics. 1'b1: xioa_ck_ref1_* are both logics
logic i_scanio_pma2_dat_ref0_n_a_3; //Value driven to xioa_ck_ref0_n when i_scanio_en_nt is 1 and i_scanio_ref0_outen_nt is 1
logic i_scanio_pma2_dat_ref0_p_a_3; //Value driven to xioa_ck_ref0_p when i_scanio_en_nt is 1 and i_scanio_ref0_outen_nt is 1
logic i_scanio_pma2_dat_ref1_n_a_3; //Value driven to xioa_ck_ref1_n when i_scanio_en_nt is 1 and i_scanio_ref1_outen_nt is 1
logic i_scanio_pma2_dat_ref1_p_a_3; //Value driven to xioa_ck_ref1_p when i_scanio_en_nt is 1 and i_scanio_ref1_outen_nt is 1
logic i_scanio_pma2_dat_tx_p_l0_a_3; //When in scanio mode xoa_tx_p_l0 follows this value
logic i_scanio_pma2_dat_tx_n_l0_a_3; //When in scanio mode xoa_tx_n_l0 follows this value
logic o_scanio_pma2_dat_ref0_n_a_3; //Follows xioa_ck_ref0_n when i_scanio_en_nt is 1 and i_scanio_ref0_outen_nt is 0
logic o_scanio_pma2_dat_ref0_p_a_3; //Follows xioa_ck_ref1_p when i_scanio_en_nt is 1 and i_scanio_ref0_outen_nt is 0
logic o_scanio_pma2_dat_ref1_n_a_3; //Follows xioa_ck_ref1_n when i_scanio_en_nt is 1 and i_scanio_ref1_outen_nt is 0
logic o_scanio_pma2_dat_ref1_p_a_3; //Follows xioa_ck_ref1_p when i_scanio_en_nt is 1 and i_scanio_ref1_outen_nt is 0
logic o_scanio_pma2_dat_rx_n_l0_a_3; //When in scanio mode follows the value of xia_rx_n_l0
logic o_scanio_pma2_dat_rx_p_l0_a_3; //When in scanio mode follows the value of xia_rx_p_l0
logic i_scanio_pma3_ref0_outen_nt_3; //When in scanio mode direction control for xioa_ck_ref0_*. 1'b0: xioa_ck_ref0_* are both logics. 1'b1: xioa_ck_ref0_* are both logics
logic i_scanio_pma3_ref1_outen_nt_3; //When in scanio mode direction control for xioa_ck_ref1_*. 1'b0: xioa_ck_ref1_* are both logics. 1'b1: xioa_ck_ref1_* are both logics
logic i_scanio_pma3_dat_ref0_n_a_3; //Value driven to xioa_ck_ref0_n when i_scanio_en_nt is 1 and i_scanio_ref0_outen_nt is 1
logic i_scanio_pma3_dat_ref0_p_a_3; //Value driven to xioa_ck_ref0_p when i_scanio_en_nt is 1 and i_scanio_ref0_outen_nt is 1
logic i_scanio_pma3_dat_ref1_n_a_3; //Value driven to xioa_ck_ref1_n when i_scanio_en_nt is 1 and i_scanio_ref1_outen_nt is 1
logic i_scanio_pma3_dat_ref1_p_a_3; //Value driven to xioa_ck_ref1_p when i_scanio_en_nt is 1 and i_scanio_ref1_outen_nt is 1
logic i_scanio_pma3_dat_tx_p_l0_a_3; //When in scanio mode xoa_tx_p_l0 follows this value
logic i_scanio_pma3_dat_tx_n_l0_a_3; //When in scanio mode xoa_tx_n_l0 follows this value
logic o_scanio_pma3_dat_ref0_n_a_3; //Follows xioa_ck_ref0_n when i_scanio_en_nt is 1 and i_scanio_ref0_outen_nt is 0
logic o_scanio_pma3_dat_ref0_p_a_3; //Follows xioa_ck_ref1_p when i_scanio_en_nt is 1 and i_scanio_ref0_outen_nt is 0
logic o_scanio_pma3_dat_ref1_n_a_3; //Follows xioa_ck_ref1_n when i_scanio_en_nt is 1 and i_scanio_ref1_outen_nt is 0
logic o_scanio_pma3_dat_ref1_p_a_3; //Follows xioa_ck_ref1_p when i_scanio_en_nt is 1 and i_scanio_ref1_outen_nt is 0
logic o_scanio_pma3_dat_rx_n_l0_a_3; //When in scanio mode follows the value of xia_rx_n_l0
logic o_scanio_pma3_dat_rx_p_l0_a_3; //When in scanio mode follows the value of xia_rx_p_l0
logic i_ck_dfx_upm_pma0_tck_0; //See UPM documentation
logic i_rst_dfx_upm_pma0_trst_b_0; //See UPM documentation
logic i_dfx_upm_pma0_fdfx_powergood_0; //See UPM documentation
logic i_dfx_upm_pma0_secure_0; //See UPM documentation
logic i_dfx_upm_pma0_sel_0; //See UPM documentation
logic i_dfx_upm_pma0_capture_0; //See UPM documentation
logic i_dfx_upm_pma0_shift_0; //See UPM documentation
logic i_dfx_upm_pma0_update_0; //See UPM documentation
logic i_dfx_upm_pma0_si_0; //See UPM documentation
logic o_dfx_upm_pma0_so_0; //See UPM documentation
logic i_ck_dfx_upm_pma0_clk_debug_0; //See UPM documentation
logic i_dfx_upm_pma0_iso_b_0; //See UPM documentation
logic i_ck_dfx_upm_pma1_tck_0; //See UPM documentation
logic i_rst_dfx_upm_pma1_trst_b_0; //See UPM documentation
logic i_dfx_upm_pma1_fdfx_powergood_0; //See UPM documentation
logic i_dfx_upm_pma1_secure_0; //See UPM documentation
logic i_dfx_upm_pma1_sel_0; //See UPM documentation
logic i_dfx_upm_pma1_capture_0; //See UPM documentation
logic i_dfx_upm_pma1_shift_0; //See UPM documentation
logic i_dfx_upm_pma1_update_0; //See UPM documentation
logic i_dfx_upm_pma1_si_0; //See UPM documentation
logic o_dfx_upm_pma1_so_0; //See UPM documentation
logic i_ck_dfx_upm_pma1_clk_debug_0; //See UPM documentation
logic i_dfx_upm_pma1_iso_b_0; //See UPM documentation
logic i_ck_dfx_upm_pma2_tck_0; //See UPM documentation
logic i_rst_dfx_upm_pma2_trst_b_0; //See UPM documentation
logic i_dfx_upm_pma2_fdfx_powergood_0; //See UPM documentation
logic i_dfx_upm_pma2_secure_0; //See UPM documentation
logic i_dfx_upm_pma2_sel_0; //See UPM documentation
logic i_dfx_upm_pma2_capture_0; //See UPM documentation
logic i_dfx_upm_pma2_shift_0; //See UPM documentation
logic i_dfx_upm_pma2_update_0; //See UPM documentation
logic i_dfx_upm_pma2_si_0; //See UPM documentation
logic o_dfx_upm_pma2_so_0; //See UPM documentation
logic i_ck_dfx_upm_pma2_clk_debug_0; //See UPM documentation
logic i_dfx_upm_pma2_iso_b_0; //See UPM documentation
logic i_ck_dfx_upm_pma3_tck_0; //See UPM documentation
logic i_rst_dfx_upm_pma3_trst_b_0; //See UPM documentation
logic i_dfx_upm_pma3_fdfx_powergood_0; //See UPM documentation
logic i_dfx_upm_pma3_secure_0; //See UPM documentation
logic i_dfx_upm_pma3_sel_0; //See UPM documentation
logic i_dfx_upm_pma3_capture_0; //See UPM documentation
logic i_dfx_upm_pma3_shift_0; //See UPM documentation
logic i_dfx_upm_pma3_update_0; //See UPM documentation
logic i_dfx_upm_pma3_si_0; //See UPM documentation
logic o_dfx_upm_pma3_so_0; //See UPM documentation
logic i_ck_dfx_upm_pma3_clk_debug_0; //See UPM documentation
logic i_dfx_upm_pma3_iso_b_0; //See UPM documentation
logic i_ck_dfx_upm_pma0_tck_1; //See UPM documentation
logic i_rst_dfx_upm_pma0_trst_b_1; //See UPM documentation
logic i_dfx_upm_pma0_fdfx_powergood_1; //See UPM documentation
logic i_dfx_upm_pma0_secure_1; //See UPM documentation
logic i_dfx_upm_pma0_sel_1; //See UPM documentation
logic i_dfx_upm_pma0_capture_1; //See UPM documentation
logic i_dfx_upm_pma0_shift_1; //See UPM documentation
logic i_dfx_upm_pma0_update_1; //See UPM documentation
logic i_dfx_upm_pma0_si_1; //See UPM documentation
logic o_dfx_upm_pma0_so_1; //See UPM documentation
logic i_ck_dfx_upm_pma0_clk_debug_1; //See UPM documentation
logic i_dfx_upm_pma0_iso_b_1; //See UPM documentation
logic i_ck_dfx_upm_pma1_tck_1; //See UPM documentation
logic i_rst_dfx_upm_pma1_trst_b_1; //See UPM documentation
logic i_dfx_upm_pma1_fdfx_powergood_1; //See UPM documentation
logic i_dfx_upm_pma1_secure_1; //See UPM documentation
logic i_dfx_upm_pma1_sel_1; //See UPM documentation
logic i_dfx_upm_pma1_capture_1; //See UPM documentation
logic i_dfx_upm_pma1_shift_1; //See UPM documentation
logic i_dfx_upm_pma1_update_1; //See UPM documentation
logic i_dfx_upm_pma1_si_1; //See UPM documentation
logic o_dfx_upm_pma1_so_1; //See UPM documentation
logic i_ck_dfx_upm_pma1_clk_debug_1; //See UPM documentation
logic i_dfx_upm_pma1_iso_b_1; //See UPM documentation
logic i_ck_dfx_upm_pma2_tck_1; //See UPM documentation
logic i_rst_dfx_upm_pma2_trst_b_1; //See UPM documentation
logic i_dfx_upm_pma2_fdfx_powergood_1; //See UPM documentation
logic i_dfx_upm_pma2_secure_1; //See UPM documentation
logic i_dfx_upm_pma2_sel_1; //See UPM documentation
logic i_dfx_upm_pma2_capture_1; //See UPM documentation
logic i_dfx_upm_pma2_shift_1; //See UPM documentation
logic i_dfx_upm_pma2_update_1; //See UPM documentation
logic i_dfx_upm_pma2_si_1; //See UPM documentation
logic o_dfx_upm_pma2_so_1; //See UPM documentation
logic i_ck_dfx_upm_pma2_clk_debug_1; //See UPM documentation
logic i_dfx_upm_pma2_iso_b_1; //See UPM documentation
logic i_ck_dfx_upm_pma3_tck_1; //See UPM documentation
logic i_rst_dfx_upm_pma3_trst_b_1; //See UPM documentation
logic i_dfx_upm_pma3_fdfx_powergood_1; //See UPM documentation
logic i_dfx_upm_pma3_secure_1; //See UPM documentation
logic i_dfx_upm_pma3_sel_1; //See UPM documentation
logic i_dfx_upm_pma3_capture_1; //See UPM documentation
logic i_dfx_upm_pma3_shift_1; //See UPM documentation
logic i_dfx_upm_pma3_update_1; //See UPM documentation
logic i_dfx_upm_pma3_si_1; //See UPM documentation
logic o_dfx_upm_pma3_so_1; //See UPM documentation
logic i_ck_dfx_upm_pma3_clk_debug_1; //See UPM documentation
logic i_dfx_upm_pma3_iso_b_1; //See UPM documentation
logic i_ck_dfx_upm_pma0_tck_2; //See UPM documentation
logic i_rst_dfx_upm_pma0_trst_b_2; //See UPM documentation
logic i_dfx_upm_pma0_fdfx_powergood_2; //See UPM documentation
logic i_dfx_upm_pma0_secure_2; //See UPM documentation
logic i_dfx_upm_pma0_sel_2; //See UPM documentation
logic i_dfx_upm_pma0_capture_2; //See UPM documentation
logic i_dfx_upm_pma0_shift_2; //See UPM documentation
logic i_dfx_upm_pma0_update_2; //See UPM documentation
logic i_dfx_upm_pma0_si_2; //See UPM documentation
logic o_dfx_upm_pma0_so_2; //See UPM documentation
logic i_ck_dfx_upm_pma0_clk_debug_2; //See UPM documentation
logic i_dfx_upm_pma0_iso_b_2; //See UPM documentation
logic i_ck_dfx_upm_pma1_tck_2; //See UPM documentation
logic i_rst_dfx_upm_pma1_trst_b_2; //See UPM documentation
logic i_dfx_upm_pma1_fdfx_powergood_2; //See UPM documentation
logic i_dfx_upm_pma1_secure_2; //See UPM documentation
logic i_dfx_upm_pma1_sel_2; //See UPM documentation
logic i_dfx_upm_pma1_capture_2; //See UPM documentation
logic i_dfx_upm_pma1_shift_2; //See UPM documentation
logic i_dfx_upm_pma1_update_2; //See UPM documentation
logic i_dfx_upm_pma1_si_2; //See UPM documentation
logic o_dfx_upm_pma1_so_2; //See UPM documentation
logic i_ck_dfx_upm_pma1_clk_debug_2; //See UPM documentation
logic i_dfx_upm_pma1_iso_b_2; //See UPM documentation
logic i_ck_dfx_upm_pma2_tck_2; //See UPM documentation
logic i_rst_dfx_upm_pma2_trst_b_2; //See UPM documentation
logic i_dfx_upm_pma2_fdfx_powergood_2; //See UPM documentation
logic i_dfx_upm_pma2_secure_2; //See UPM documentation
logic i_dfx_upm_pma2_sel_2; //See UPM documentation
logic i_dfx_upm_pma2_capture_2; //See UPM documentation
logic i_dfx_upm_pma2_shift_2; //See UPM documentation
logic i_dfx_upm_pma2_update_2; //See UPM documentation
logic i_dfx_upm_pma2_si_2; //See UPM documentation
logic o_dfx_upm_pma2_so_2; //See UPM documentation
logic i_ck_dfx_upm_pma2_clk_debug_2; //See UPM documentation
logic i_dfx_upm_pma2_iso_b_2; //See UPM documentation
logic i_ck_dfx_upm_pma3_tck_2; //See UPM documentation
logic i_rst_dfx_upm_pma3_trst_b_2; //See UPM documentation
logic i_dfx_upm_pma3_fdfx_powergood_2; //See UPM documentation
logic i_dfx_upm_pma3_secure_2; //See UPM documentation
logic i_dfx_upm_pma3_sel_2; //See UPM documentation
logic i_dfx_upm_pma3_capture_2; //See UPM documentation
logic i_dfx_upm_pma3_shift_2; //See UPM documentation
logic i_dfx_upm_pma3_update_2; //See UPM documentation
logic i_dfx_upm_pma3_si_2; //See UPM documentation
logic o_dfx_upm_pma3_so_2; //See UPM documentation
logic i_ck_dfx_upm_pma3_clk_debug_2; //See UPM documentation
logic i_dfx_upm_pma3_iso_b_2; //See UPM documentation
logic i_ck_dfx_upm_pma0_tck_3; //See UPM documentation
logic i_rst_dfx_upm_pma0_trst_b_3; //See UPM documentation
logic i_dfx_upm_pma0_fdfx_powergood_3; //See UPM documentation
logic i_dfx_upm_pma0_secure_3; //See UPM documentation
logic i_dfx_upm_pma0_sel_3; //See UPM documentation
logic i_dfx_upm_pma0_capture_3; //See UPM documentation
logic i_dfx_upm_pma0_shift_3; //See UPM documentation
logic i_dfx_upm_pma0_update_3; //See UPM documentation
logic i_dfx_upm_pma0_si_3; //See UPM documentation
logic o_dfx_upm_pma0_so_3; //See UPM documentation
logic i_ck_dfx_upm_pma0_clk_debug_3; //See UPM documentation
logic i_dfx_upm_pma0_iso_b_3; //See UPM documentation
logic i_ck_dfx_upm_pma1_tck_3; //See UPM documentation
logic i_rst_dfx_upm_pma1_trst_b_3; //See UPM documentation
logic i_dfx_upm_pma1_fdfx_powergood_3; //See UPM documentation
logic i_dfx_upm_pma1_secure_3; //See UPM documentation
logic i_dfx_upm_pma1_sel_3; //See UPM documentation
logic i_dfx_upm_pma1_capture_3; //See UPM documentation
logic i_dfx_upm_pma1_shift_3; //See UPM documentation
logic i_dfx_upm_pma1_update_3; //See UPM documentation
logic i_dfx_upm_pma1_si_3; //See UPM documentation
logic o_dfx_upm_pma1_so_3; //See UPM documentation
logic i_ck_dfx_upm_pma1_clk_debug_3; //See UPM documentation
logic i_dfx_upm_pma1_iso_b_3; //See UPM documentation
logic i_ck_dfx_upm_pma2_tck_3; //See UPM documentation
logic i_rst_dfx_upm_pma2_trst_b_3; //See UPM documentation
logic i_dfx_upm_pma2_fdfx_powergood_3; //See UPM documentation
logic i_dfx_upm_pma2_secure_3; //See UPM documentation
logic i_dfx_upm_pma2_sel_3; //See UPM documentation
logic i_dfx_upm_pma2_capture_3; //See UPM documentation
logic i_dfx_upm_pma2_shift_3; //See UPM documentation
logic i_dfx_upm_pma2_update_3; //See UPM documentation
logic i_dfx_upm_pma2_si_3; //See UPM documentation
logic o_dfx_upm_pma2_so_3; //See UPM documentation
logic i_ck_dfx_upm_pma2_clk_debug_3; //See UPM documentation
logic i_dfx_upm_pma2_iso_b_3; //See UPM documentation
logic i_ck_dfx_upm_pma3_tck_3; //See UPM documentation
logic i_rst_dfx_upm_pma3_trst_b_3; //See UPM documentation
logic i_dfx_upm_pma3_fdfx_powergood_3; //See UPM documentation
logic i_dfx_upm_pma3_secure_3; //See UPM documentation
logic i_dfx_upm_pma3_sel_3; //See UPM documentation
logic i_dfx_upm_pma3_capture_3; //See UPM documentation
logic i_dfx_upm_pma3_shift_3; //See UPM documentation
logic i_dfx_upm_pma3_update_3; //See UPM documentation
logic i_dfx_upm_pma3_si_3; //See UPM documentation
logic o_dfx_upm_pma3_so_3; //See UPM documentation
logic i_ck_dfx_upm_pma3_clk_debug_3; //See UPM documentation
logic i_dfx_upm_pma3_iso_b_3; //See UPM documentation
logic [3:0] mac100_0_int;
logic [3:0] pcs100_0_int;
logic [3:0] mac100_1_int;
logic [3:0] pcs100_1_int;
logic [3:0] mac100_2_int;
logic [3:0] pcs100_2_int;
logic [3:0] mac100_3_int;
logic [3:0] pcs100_3_int;
logic [3:0] physs_ts_int;

logic loopback_req_ack;
logic [5:0] eth_hd2prf_trim_fuse_in; //2R2W time stamp Memory rfhs type Trim Fuse RMCE WMCE latency Read and Write Memory Latency
logic [7:0] eth_rfhs_trim_fuse_in; //2R2W time stamp Memory rfhs type Trim Fuse RMCE WMCE latency Read and Write Memory Latency
logic [15:0] eth_hdspsr_trim_fuse_in; //2R2W time stamp Memory rfhs type Trim Fuse RMCE WMCE latency Read and Write Memory Latency

logic hlp_mac0_tx_stop; //tx_stop backpressure signal for mac to mac
logic hlp_mac1_tx_stop; //tx_stop backpressure signal for mac to mac
logic hlp_mac2_tx_stop; //tx_stop backpressure signal for mac to mac
logic hlp_mac3_tx_stop; //tx_stop backpressure signal for mac to mac
logic hlp_mac4_tx_stop; //tx_stop backpressure signal for mac to mac
logic hlp_mac5_tx_stop; //tx_stop backpressure signal for mac to mac
logic hlp_mac6_tx_stop; //tx_stop backpressure signal for mac to mac
logic hlp_mac7_tx_stop; //tx_stop backpressure signal for mac to mac

assign loopback_req_ack = physs_reset_prep_ack;
assign physs_reset_prep_req = loopback_req_ack;

physs_bbl physs_bbl(.*);

assign physs_bbl.physs0.parmquad0.pcs100_wrap_0.quadpcs100_0.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_0.clk_eth_ref_125mhz = clk_125mhz;
assign physs_bbl.physs0.parmquad0.pcs100_wrap_0.quadpcs100_0.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_0.i_reset = i_reset;
assign physs_bbl.physs0.parmquad0.pcs100_wrap_0.quadpcs100_0.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_0.rx_serial_data = rx_serial_data;
assign physs_bbl.physs0.parmquad0.pcs100_wrap_0.quadpcs100_0.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_0.tx_serial_data = tx_serial_data;


endmodule
