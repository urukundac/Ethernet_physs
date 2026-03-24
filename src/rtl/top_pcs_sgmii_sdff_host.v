
`include "common_header.verilog"

//  *************************************************************************
//  File : top_pcs_sgmii_sdff_host
//  *************************************************************************
//  This program is controlled by a written license agreement.
//  Unauthorized reproduction or use is expressly prohibited.
//  Copyright (c) 2010 MorethanIP
//  Muenchner Strasse 199, 85757 Karlsfeld, Germany
//  info@morethanip.com
//  http://www.morethanip.com
//  *************************************************************************
//  Designed by : Daniel Koehler
//  info@morethanip.com
//  *************************************************************************
//  Description : 1000Base-X with SGMII PCS toplevel combining RX, TX with 
//                MMD registers.
//                It implements the TBI interface to external SERDES.
// 
//                TX and RX GMII are decoupled from the Serdes clock domains
//                sharing a single system clock (which must be at least 200ppm
//                higher than nominal rate).
//
//                Serdes interface rate can be controlled by enable signals.
// 
//  Version     : $Id: top_pcs_sgmii_sdff_host.v,v 1.1 2013/04/12 07:46:59 dk Exp $
//  *************************************************************************

module top_pcs_sgmii_sdff_host (

   reset_tx_clk,
   reset_rx_clk,
   reset_ref_clk,
   reset_reg_clk,
   tx_clk,
   tx_clk_ena,
   rx_clk,
   rx_clk_ena,
   ref_clk,
   reg_clk,
   tbi_tx,
   tbi_rx,
   sd_sig_det,
   sd_loopback,
   gmii_rxd,
   gmii_rxdv,
   gmii_rxer,
   gmii_crs,
   gmii_col,
   gmii_rxclk_ena,
   gmii_txd,
   gmii_txen,
   gmii_txer,
   gmii_txclk_ena,
   gmii_tx_even,   
   sgpcs_ena,
   sgpcs_ena_st,
   an_enable,
   sw_reset_r,
   sw_reset_t,
   sg_rx_sync,
   sg_an_done,
   sg_page_rx,
   sg_speed,
   sg_hd,
   cfg_clock_rate,
   reg_rd,
   reg_wr,
   reg_addr,
   reg_din,
   reg_dout,
   reg_busy,
   tx_lane_thresh,
   tx_lane_ckmult
 `ifdef MTIPPCS36_EEE_ENA
   ,
   pma_txmode_quiet,
   tx_lpi_active,
   pma_rxmode_quiet,
   rx_lpi_active,
   rx_wake_err,
   lpi_tick
   
 `endif

 `ifdef SGMII_BIT_SLIP_PIN
   ,
   sg_bit_slip
   
 `endif
   );

parameter CKE_ADVANCE = 1;      //  Define if gmii clock-enables are in advance (1) or aligned with gmii data (0).
                                //  When 0 the clock-enables will become registered to add delay to align the GMII to it.
parameter ENCAP127_SEQ   = 0;   //  if 1 Encode Sequence ordered set from XGMII (Clause 127) which is encoded on GMII as (dv=0, er=1, data=0x9c)

`include "pcs_pack_package.verilog"

input   reset_tx_clk;           //  async active high reset
input   reset_rx_clk;           //  async active high reset
input   reset_ref_clk;          //  async active high reset system
input   reset_reg_clk;          //  async active high reset host interface
input   tx_clk;                 //  transmit serdes clock
input   tx_clk_ena;             //  transmit serdes interface data valid, clock enable
input   rx_clk;                 //  receive serdes clock
input   rx_clk_ena;             //  receive serdes interface data valid, clock enable
input   ref_clk;                //  system reference clock (>line clocks)
input   reg_clk;                //  host clock
output  [9:0] tbi_tx;           //  encoded datastream
input   [9:0] tbi_rx;           //  data input
input   sd_sig_det;             //  signal detect from serdes (async)
output  sd_loopback;            //  loopback control bit from control register (reg_clk)
output  [7:0] gmii_rxd;         //  GMII receive data
output  gmii_rxdv;              //  GMII receive data valid
output  gmii_rxer;              //  GMII receive data error
output  gmii_crs;               //  GMII carrier sense
output  gmii_col;               //  GMII collision
output  gmii_rxclk_ena;         //  GMII receive clock enable, advance
input   [7:0] gmii_txd;         //  GMII transmit data
input   gmii_txen;              //  GMII transmit enable
input   gmii_txer;              //  GMII transmit error
output  gmii_txclk_ena;         //  GMII transmit clock enable, advance
output  gmii_tx_even;           //  Statemachine in tx_even state sampling GMII (frame start sampled only if tx_even=0)
input   sgpcs_ena;              //  Enable 1G PCS
output  sgpcs_ena_st;           //  Enable for the 1G PCS. Combination of input pin and control register, reg_clk
output  an_enable;              //  Enable Autonegotiation
output  sw_reset_r;             //  Software Reset indication to lane modules (rx_clk)
output  sw_reset_t;             //  Software Reset indication to lane modules (tx_clk)
output  sg_rx_sync;             //  10B sync status
output  sg_an_done;             //  Autoneg done
output  sg_page_rx;             //  autoneg page received
output  [1:0] sg_speed;         //  00=>10M, 01=>100M, 10=>1G current speed
output  sg_hd;                  //  SGMII half-duplex(1)/ fullduplex(0)
output  [3:0] cfg_clock_rate;   //  compensate ref-clock overspeed dividing clock with exception 1 being 2/3, reg_clk
input   reg_rd;                 //  Register Read Strobe
input   reg_wr;                 //  Register Write Strobe
input   [4:0] reg_addr;         //  Register Address
input   [15:0] reg_din;         //  Write Data from Host Bus
output  [15:0] reg_dout;        //  Read Data to Host Bus
output  reg_busy;               //  Acknowledgement for read/write operation
input   [3:0] tx_lane_thresh;   //  4 bit tx decoupling buffer level threshold (set 7 as a compromise if unsure)
input   [2:0] tx_lane_ckmult;   //  Multiplicator of ref_clk/125 used. 0>=126MHz, 1>=251MHz,... 7 >= 1000MHz
`ifdef SGMII_BIT_SLIP_PIN
output  [3:0] sg_bit_slip;      // Bit slip indication

wire    [3:0] sg_bit_slip;
`endif
`ifdef MTIPPCS36_EEE_ENA
output  pma_txmode_quiet;       //  tx_mode (0 - DATA, 1 - QUIET)
output  tx_lpi_active;          //  1 - the TX is in the Low Power State, 0 - in the Active State
output  pma_rxmode_quiet;       //  rx_mode (0 - DATA, 1 - QUIET)                                   
output  rx_lpi_active;          //  1 - the Receiver in the Low Power State, 0 - in the Active State
output  rx_wake_err;            //  To increment the Wake Error Counter (pulse)                     
input   lpi_tick;               //  Timer Tick for all LPI timers (ref clock domain)

wire    pma_txmode_quiet;
wire    tx_lpi_active;
wire    pma_rxmode_quiet;
wire    rx_lpi_active;
wire    rx_wake_err;
`endif

wire    [9:0] tbi_tx; 
wire    sd_loopback; 
wire    [7:0] gmii_rxd; 
wire    gmii_rxdv; 
wire    gmii_rxer; 
wire    gmii_crs; 
wire    gmii_col; 
wire    gmii_rxclk_ena; 
wire    gmii_txclk_ena; 
wire    sgpcs_ena_st;
wire    sw_reset_r; 
wire    sw_reset_t; 
wire    sg_rx_sync; 
wire    sg_an_done; 
wire    sg_page_rx; 
wire    [1:0] sg_speed; 
wire    sg_hd; 
wire    [3:0] cfg_clock_rate;
wire    [15:0] reg_dout; 
wire    reg_busy; 

wire    [9:0] sdbf_data;        //  data input
wire    sdbf_dval;              //  data input valid, advance
wire    [9:0] tx_d;             //  encoded datastream
wire    tx_d_wr;                //  data valid (buffer write)
wire    tx_bf_afull;            //  line buffer almost full (backpressure)
wire    loopback_ena;           //  enable PCS loopback
wire    sw_reset_t_int; 

assign sw_reset_t = sw_reset_t_int;

//  loopback control to serdes
//  ---------------

assign sd_loopback      = loopback_ena; 


//  Wire TBI receive decoupling FIFO
//  ---------------

sd_rx_lanebuf #(
        
        .FF_DEPTH(8),
        .FF_ADDR(3),
        .FF_WIDTH(10) )

        U_RXBUF (
   
        .reset_rx_clk(reset_rx_clk),
        .rx_clk(rx_clk),
        .rx_clk_ena(rx_clk_ena),
        .sd_rx(tbi_rx),
        .reset_ref_clk(reset_ref_clk),
        .ref_clk(ref_clk),
        .sdbf_data(sdbf_data),
        .sdbf_dval(sdbf_dval) );


//  Wire TBI transmit decoupling FIFO
//  ---------------

sd_tx_lanebuf_ena U_TXBUF (

   .reset_txclk         (reset_ref_clk),        // write
   .reset_sd_tx_clk     (reset_tx_clk),         // line
   .txclk               (ref_clk),              // write
   .sd_tx_clk           (tx_clk),               // line
   .sd_tx_clk_ena       (tx_clk_ena),
   .tx_d                (tx_d),
   .tx_d_wr             (tx_d_wr),
   .tx_bf_afull         (tx_bf_afull),
   .tx_bf_full          (), // spyglass disable W287b
   .tx_bf_empty         (), // spyglass disable W287b
   .sd_tx               (tbi_tx),
   .sw_reset            (sw_reset_t_int),
   .sw_reset_wclk       (), // spyglass disable W287b
   .sw_reset_rclk       (), // spyglass disable W287b
   .tx_lane_thresh      (tx_lane_thresh),
   .tx_lane_ckmult      (tx_lane_ckmult) );


//  PCS with TBI Buffer Interface
//  -----------------------------
top_pcs_sgcke_mmd #(

        .PHY_IDENTIFIER(PHY_IDENTIFIER),
        .DEV_VERSION(DEV_VERSION),
        .ENCAP127_SEQ(ENCAP127_SEQ),    //  if 1 Encode Sequence ordered set from XGMII (Clause 127) which is encoded on GMII as (dv=0, er=1, data=0x9c)
        .CKE_ADVANCE(CKE_ADVANCE) )

        U_PCSMMD (

// -----------------------------------
//  System
// -----------------------------------
          .reset_tx_clk(reset_ref_clk), 
          .tx_clk(ref_clk),             // system domain
          .reset_rx_clk(reset_ref_clk),
          .rx_clk(ref_clk),             // system domain
          .reset_reg_clk(reset_reg_clk),
          .reg_clk(reg_clk),
// -----------------------------------
//  RX Input from Buffer / Serdes
// -----------------------------------
          .sdbf_data(sdbf_data),
          .sdbf_dval(sdbf_dval),
          .sd_sig_det(sd_sig_det),
// -----------------------------------
//  RX GMII Interface out
// -----------------------------------
          .gmii_rxd(gmii_rxd),
          .gmii_rxdv(gmii_rxdv),
          .gmii_rxer(gmii_rxer),
          .gmii_crs(gmii_crs),
          .gmii_col(gmii_col),
          .gmii_rxclk_ena(gmii_rxclk_ena),
// -----------------------------------
//  TX Output to line buffer / Serdes
// -----------------------------------
          .tx_d(tx_d),
          .tx_d_wr(tx_d_wr),
          .tx_bf_afull(tx_bf_afull),
// -----------------------------------
//  TX GMII Interface in
// -----------------------------------
          .gmii_txd(gmii_txd),
          .gmii_txen(gmii_txen),
          .gmii_txer(gmii_txer),
          .gmii_txclk_ena(gmii_txclk_ena),
          .gmii_tx_even(gmii_tx_even),
// -----------------------------------
//  Configuration (global)
// -----------------------------------
          .sgpcs_ena(sgpcs_ena),
          .sgpcs_ena_st(sgpcs_ena_st),
          .an_enable(an_enable),
// -----------------------------------
//  Controls/status out (line clk)
// -----------------------------------
          .sw_reset_r(sw_reset_r),
          .sw_reset_t(sw_reset_t_int),
// -----------------------------------
//  Controls/status out (reg_clk)
// -----------------------------------
          .loopback_ena(loopback_ena),
          .sg_rx_sync(sg_rx_sync),
          .sg_an_done(sg_an_done),
          .sg_page_rx(sg_page_rx),
          .sg_speed(sg_speed),
          .sg_hd(sg_hd),
          .cfg_clock_rate(cfg_clock_rate),
// -----------------------------------
//  MMD Registers
// -----------------------------------
          .reg_rd(reg_rd),
          .reg_wr(reg_wr),
          .reg_addr(reg_addr),
          .reg_din(reg_din),
          .reg_dout(reg_dout),
          .reg_busy(reg_busy)
// -----------------------------------
//  EEE Extension
// -----------------------------------
        `ifdef MTIPPCS36_EEE_ENA
          ,
          .tx_lpi_tick(lpi_tick),               // both datapathes operate in ref_clk
          .tx_mode_quiet(pma_txmode_quiet),
          .tx_lpi_active(tx_lpi_active),
          .rx_lpi_tick(lpi_tick),               // both datapathes operate in ref_clk
          .rx_mode_quiet(pma_rxmode_quiet),
          .rx_lpi_active(rx_lpi_active),
          .rx_wake_err(rx_wake_err)
        `endif
        `ifdef SGMII_BIT_SLIP_PIN
         ,
         .sg_bit_slip(sg_bit_slip)
        `endif
          );

logic  [9:0] xcvr_tbi_rx_gmii_0;
logic  [9:0] xcvr_tbi_tx_gmii_0;
logic  [9:0] xcvr_tbi_rx_gmii_1;
logic  [9:0] xcvr_tbi_tx_gmii_1;
logic  [9:0] xcvr_tbi_rx_gmii_2;
logic  [9:0] xcvr_tbi_tx_gmii_2;
logic  [9:0] xcvr_tbi_rx_gmii_3;
logic  [9:0] xcvr_tbi_tx_gmii_3;
logic clk_eth_ref_125mhz;
 logic   fpll_locked_SGMII;
logic xcvr_tx_serial_clk0;
logic xcvr_rx_clk_0;
logic xcvr_rx_clk_1;
logic xcvr_rx_clk_2;
logic xcvr_rx_clk_3;
logic  [3:0] rx_serial_data;
logic  [3:0] tx_serial_data;
logic  [31:0] usr_cntrl_0;  

logic i_reset;
wire  [3:0] pcs_loopback_en;
wire  [3:0] serdes_loopback_en;
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
      .outclk_0 (pcs_ref_clk_125mhz)
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
    .xcvr_rx_clk (rx_clk),
    .xcvr_tbi_rx_gmii(tbi_rx),
    .xcvr_tbi_tx_gmii(tbi_tx),
    .usr_cntrl_0   (usr_cntrl_0[3:0]),
    .fpga_pcs_loopback_ena (pcs_loopback_en[0]),
    .fpga_serdes_loopback_ena (serdes_loopback_en[0]),
    .xcvr_rx_serial_data  (rx_serial_data[0]),          // SGMII_PHY_S10 from board    
    .xcvr_tx_serial_data  (tx_serial_data[0])           // SGMIIS_S10_PHY from board   
);

endmodule // module top_pcs_sgmii_sdff_host

