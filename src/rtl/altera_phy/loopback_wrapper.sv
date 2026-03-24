
module loopback_wrapper (

input clk_eth_ref_125mhz,
input i_reset,
input rx_serial_data,
output tx_serial_data

);

logic  [3:0] usr_cntrl_0;  
logic   fpll_locked_SGMII;
logic xcvr_tx_serial_clk0;
logic xcvr_rx_clk_0;
logic [7:0] xcvr_tbi_rx_gmii_0;
logic [7:0] xcvr_tbi_tx_gmii_0;
logic  [3:0] pcs_loopback_en;
logic  [3:0] serdes_loopback_en;

assign xcvr_tbi_tx_gmii_0 = 'd1;
assign  usr_cntrl_0 = 'b0001;  

s10_fpll_ref125Mhz_625Mhz u_s10_fpll_ref125Mhz_625Mhz 
   (
      .pll_refclk0    (clk_eth_ref_125mhz)
     ,.pll_cal_busy   ()
     ,.pll_locked     (fpll_locked_SGMII)
     ,.tx_serial_clk  (xcvr_tx_serial_clk0)
   );


io_pll_125mhz_eth_clks io_pll_125mhz_eth_clks
     (
	    //.rst  (i_reset),
	    .rst  (1'b0),
      .refclk (clk_eth_ref_125mhz),
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
    .xcvr_125mhz_refclk (clk_eth_ref_125mhz),
    .xcvr_reset  (sync_i_reset),
    .xcvr_tx_serial_clk0  (xcvr_tx_serial_clk0),
    .fpll_locked_SGMII   (fpll_locked_SGMII),    
    .xcvr_rx_clk (xcvr_rx_clk_0), //output clock to pcs ip
    .xcvr_tbi_rx_gmii(xcvr_tbi_rx_gmii_0),
    .xcvr_tbi_tx_gmii(xcvr_tbi_tx_gmii_0),
    .usr_cntrl_0   (usr_cntrl_0[3:0]),
    .fpga_pcs_loopback_ena (pcs_loopback_en[0]),
    .fpga_serdes_loopback_ena (serdes_loopback_en[0]),
    .xcvr_rx_serial_data  (rx_serial_data),          // SGMII_PHY_S10 from board    
    .xcvr_tx_serial_data  (tx_serial_data)           // SGMIIS_S10_PHY from board   
);

endmodule 
