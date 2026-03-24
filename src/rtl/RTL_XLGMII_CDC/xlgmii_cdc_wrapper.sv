module xlgmii_cdc_wrapper (
rd_clk,
wr_clk,
rstn,
physs_hlp_xlgmii0_rxc_0,
physs_hlp_xlgmii0_rxd_0,
physs_hlp_xlgmii0_rxt0_next_0,
physs_hlp_xlgmii0_rxclk_ena_0,
hlp_xlgmii0_rxc_0,
hlp_xlgmii0_rxd_0,
hlp_xlgmii0_rxt0_next_0,
hlp_xlgmii0_rxclk_ena_0,
physs_hlp_xlgmii0_txclk_ena_0,
hlp_xlgmii0_txclk_ena_0,
hlp_port4_xlgmii_tx_data,
hlp_port4_xlgmii_tx_c,
hlp_xlgmii0_txd_0,
hlp_xlgmii0_txc_0
);

// Clock and resets
input rd_clk;
input wr_clk;
input rstn;

// PHYSS -> CDC 125 Mhz
input [7:0] physs_hlp_xlgmii0_rxc_0;
input [63:0] physs_hlp_xlgmii0_rxd_0;
input physs_hlp_xlgmii0_rxt0_next_0;
input physs_hlp_xlgmii0_rxclk_ena_0;

// CDC -> HLP 1 Mhz
output logic [7:0] hlp_xlgmii0_rxc_0;
output logic [63:0] hlp_xlgmii0_rxd_0;
output logic hlp_xlgmii0_rxt0_next_0;
output logic hlp_xlgmii0_rxclk_ena_0;

// PHYSS -> CDC 125 Mhz
input physs_hlp_xlgmii0_txclk_ena_0;

// CDC -> HLP 1 MHz
output logic hlp_xlgmii0_txclk_ena_0;

// HLP -> CDC 1 Mhz
input [63:0] hlp_port4_xlgmii_tx_data;
input [7:0] hlp_port4_xlgmii_tx_c;

// CDC -> PHYSS 125 Mhz
output logic [63:0] hlp_xlgmii0_txd_0;
output logic [7:0] hlp_xlgmii0_txc_0;

wire [7:0] hlp_xlgmii0_rxmisc_0;

assign hlp_xlgmii0_rxt0_next_0 = hlp_xlgmii0_rxmisc_0[0];

xlgmii_cdc_125_to_1 phy_hlp_fifo ( 
	 .xlgmii_rx_data(physs_hlp_xlgmii0_rxd_0),
         .xlgmii_rx_c(physs_hlp_xlgmii0_rxc_0),
         .xlgmii_rxt0_next(physs_hlp_xlgmii0_rxt0_next_0),
	 .xlgmii_rxclk_ena(physs_hlp_xlgmii0_rxclk_ena_0),
         .xlgmii_tx_data(hlp_xlgmii0_rxd_0),
	 .xlgmii_tx_c(hlp_xlgmii0_rxc_0),
	 .xlgmii_tx_misc(hlp_xlgmii0_rxmisc_0),
	 .xlgmii_txclk_ena(hlp_xlgmii0_rxclk_ena_0),
	 .rstn(rstn),
	 .wr_clk(wr_clk),  
	 .rd_clk(rd_clk)	   
) ;

xlgmii_cdc_1_to_125 hlp_phy_fifo (
        .xlgmii_rx_data(hlp_port4_xlgmii_tx_data),
        .xlgmii_rx_c(hlp_port4_xlgmii_tx_c),
        .xlgmii_txclk_ena(physs_hlp_xlgmii0_txclk_ena_0),
        .xlgmii_rx_misc(8'h00),
        .xlgmii_tx_data(hlp_xlgmii0_txd_0),
        .xlgmii_tx_c(hlp_xlgmii0_txc_0),
	.xlgmii_rxclk_ena(hlp_xlgmii0_txclk_ena_0),
        .xlgmii_tx_misc(),
        .rd_clk(wr_clk),
        .wr_clk(rd_clk),
        .rstn(rstn)
);


endmodule
