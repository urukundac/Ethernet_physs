
`include "common_header.verilog"

//  *************************************************************************
//  File : top_pcs_sgmii_refck_host_xlgmii
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
//  Version     : $Id: top_pcs_sgmii_refck_host_xlgmii.v,v 1.6 2017/06/21 08:38:15 fb Exp $
//  *************************************************************************

module top_pcs_sgmii_refck_host_xlgmii_10b (

   reset_tx_clk,
   reset_rx_clk,
   reset_ref_clk,
   reset_reg_clk,
   tx_clk,
   rx_clk,
   ref_clk,
   reg_clk,
   tbi_tx,
   tbi_rx,
   xlgmii_txclk_ena,
   xlgmii_txd,
   xlgmii_txc,
   xlgmii_rxclk_ena,
   xlgmii_rxd,
   xlgmii_rxc,
   xlgmii_rxt0_next,
   sd_sig_det,
   sd_loopback,
   sgpcs_ena,
   sg_rx_sync,
   sg_an_done,
   sg_page_rx,
   sg_speed,
   sg_hd,
   mode_sync,
   mode_br_dis,
   seq_ena,
`ifdef SGMII_TSU_ENA
   sg_link_status,
   cycle_start,
   cfg_sfd_ts,
   sg_rx_tsu,  
`endif 
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

parameter BR_SUPPORT_ENA = 0;  // Set to 1 to enable detection of 802.3BR frames
parameter ENCAP127_SEQ   = 1;   //  if 1 Encode Sequence ordered set from XGMII (Clause 127) which is encoded on GMII as (dv=0, er=1, data=0x9c)

`include "pcs_pack_package.verilog"

input   reset_tx_clk;           //  async active high reset
input   reset_rx_clk;           //  async active high reset
input   reset_ref_clk;          //  async active high reset system
input   reset_reg_clk;          //  async active high reset host interface
input   tx_clk;                 //  transmit datapath clock
input   rx_clk;                 //  receive datapath clock
input   ref_clk;                //  system reference clock (>line clocks)
input   reg_clk;                //  host clock
output  [9:0] tbi_tx;           //  encoded datastream
input   [9:0] tbi_rx;           //  data input
output  xlgmii_txclk_ena;       //  XLGMII Transmit Clock Enable.
input   [63:0] xlgmii_txd;      //  XLGMII Transmit Data bus.
input   [7:0] xlgmii_txc;       //  XLGMII Transmit Control.
output  xlgmii_rxclk_ena;       //  XLGMII Receive Clock Enable.
output  [63:0] xlgmii_rxd;      //  XLGMII Receive Data bus.
output  [7:0] xlgmii_rxc;       //  XLGMII Receive Control.
output  xlgmii_rxt0_next;       //  XLGMII Terminate character (0xFD) on lane 0 in the next word
input   sd_sig_det;             //  signal detect from serdes (async)
output  sd_loopback;            //  loopback control bit from control register (reg_clk)
input   sgpcs_ena;              //  Enable 1G PCS
output  sg_rx_sync;             //  10B sync status
output  sg_an_done;             //  Autoneg done
output  sg_page_rx;             //  autoneg page received
output  [1:0] sg_speed;         //  00=>10M, 01=>100M, 10=>1G current speed
output  sg_hd;                  //  SGMII half-duplex(1)/ fullduplex(0)
input   mode_sync;              //  When 1 disable SFD search: assume preamble synchronized to IDLE even byte boundaries being fixed size 7 byte
input   mode_br_dis;            //  When 1 disable BR SFD searchs. Only 0xD5 is supported
input   seq_ena;                //  Enable decoding 0x9c Sequence Ordered Sets (Clause 127)
`ifdef SGMII_TSU_ENA
output  sg_link_status;         //  Link-up indication
output  cycle_start;            //  Cycle Start
input   cfg_sfd_ts;             //  Timestamp on FB(0) or SFD(1)
output  [1:0] sg_rx_tsu;        //  Bit 0: Receive SFD indication from XGMII/GMII converter Bit 1: GMII RX clock enable signal
`endif
input   reg_rd;                 //  Register Read Strobe
input   reg_wr;                 //  Register Write Strobe
input   [4:0] reg_addr;         //  Register Address
input   [15:0] reg_din;         //  Write Data from Host Bus
output  [15:0] reg_dout;        //  Read Data to Host Bus
output  reg_busy;               //  Acknowledgement for read/write operation
input   [3:0] tx_lane_thresh;   //  4 bit tx decoupling buffer level threshold (set 7 as a compromise if unsure)
input   [2:0] tx_lane_ckmult;   //  Multiplicator of ref_clk/125 used. 0>=126MHz, 1>=251MHz,... 7 >= 1000MHz

`ifdef SGMII_BIT_SLIP_PIN

  output  [3:0] sg_bit_slip;    // Bit slip indication

  wire    [3:0] sg_bit_slip;
  
`endif

`ifdef MTIPPCS36_EEE_ENA

 output pma_txmode_quiet;       //  tx_mode (0 - DATA, 1 - QUIET)
 output tx_lpi_active;          //  1 - the TX is in the Low Power State, 0 - in the Active State
 output pma_rxmode_quiet;       //  rx_mode (0 - DATA, 1 - QUIET)                                   
 output rx_lpi_active;          //  1 - the Receiver in the Low Power State, 0 - in the Active State
 output rx_wake_err;            //  To increment the Wake Error Counter (pulse)                     
 input  lpi_tick;               //  Timer Tick for all LPI timers (ref clock domain)

 wire   pma_txmode_quiet;
 wire   tx_lpi_active;
 wire   pma_rxmode_quiet;
 wire   rx_lpi_active;
 wire   rx_wake_err;

`endif

wire    [9:0] tbi_tx; 
wire    xlgmii_txclk_ena;
wire    xlgmii_rxclk_ena;
wire    [63:0] xlgmii_rxd;
wire    [7:0] xlgmii_rxc;
wire    xlgmii_rxt0_next;
wire    sd_loopback;  
wire    sg_rx_sync; 
wire    sg_an_done; 
wire    sg_page_rx; 
wire    [1:0] sg_speed; 
wire    sg_hd; 
wire    [15:0] reg_dout; 
wire    reg_busy; 

//  GMII Interface
//  --------------

wire    [7:0] gmii_rxd;         //  GMII receive data
wire    gmii_rxdv;              //  GMII receive data valid
wire    gmii_rxer;              //  GMII receive data error
wire    gmii_rxclk_ena;         //  GMII receive clock enable, advance
wire    [7:0] gmii_txd;         //  GMII transmit data
wire    gmii_txen;              //  GMII transmit enable
wire    gmii_txer;              //  GMII transmit error
wire    gmii_txclk_ena;         //  GMII transmit clock enable, advance
wire    gmii_tx_even;           //  Statemachine in tx_even state sampling GMII (frame start sampled only if tx_even=0)

//  PCS Status
//  ----------

`ifdef SGMII_TSU_ENA
wire    sg_link_status;
wire    sg_link_status_int;
wire    sg_link_status_dff;
`endif
wire    sg_an_enable_int;       //  Auto-neg enabled
wire    sg_rx_sync_int;         //  10B sync status
wire    sg_an_done_int;         //  Autoneg done

//  Control
//  -------

wire  ena_r;
wire  ena_int;
reg   ena_int_r;

// Unused signals
// ---------------

wire  tx_sfd_o_nc;
wire [3:0] cnt_nc;

// Force SGMII enable when it indicates link up to avoid it gets stuck in this state when disabled
// -----------------------------------------------------------------------------------------------

mtip_xsync #(1) U_SYENA (

   .reset(sync_i_reset),
   .clk(rx_clk_out),
   .data_in(sgpcs_ena),
   .data_s(ena_r));

assign ena_int = ena_r | sg_rx_sync_int | sg_an_done_int;     // all status operates in reg_clk

// Register ena_int to avoid CDC violations when it gets synchronized
always @(posedge rx_clk_out or posedge sync_i_reset)
begin : p_ena_int_r
    if (sync_i_reset == 1'b 1)
    begin
        ena_int_r <= 1'b 0;
    end
    else
    begin
        ena_int_r <= ena_int;
    end
end

localparam CKE_ADVANCE = 1;     // 1: (default) create PCS mii clk_ena 1 clock cycle in advane. Must be consistent with MII converter
                
top_pcs_sgmii_sdff_host #(
                .ENCAP127_SEQ(ENCAP127_SEQ),    //  if 1 Encode Sequence ordered set from XGMII (Clause 127) which is encoded on GMII as (dv=0, er=1, data=0x9c)
                .CKE_ADVANCE(CKE_ADVANCE) )

        U_PCS (

   .reset_tx_clk(sync_i_reset),
   .reset_rx_clk(sync_i_reset),
   .reset_ref_clk(sync_i_reset),
   .reset_reg_clk(sync_i_reset),
   .tx_clk(rx_clk_out),
   .tx_clk_ena(1'b 1),
   .rx_clk(rx_clk_out),
   .rx_clk_ena(1'b 1),
   .ref_clk(rx_clk_out),
   .reg_clk(rx_clk_out),
   .tbi_tx(tbi_tx_phy),
   .tbi_rx(tbi_rx_phy),
   .sd_sig_det(1'b1),
   .sd_loopback(sd_loopback),
   `ifdef   PHY_LOOPBACK_DOUT
   .gmii_rxd(),
   .gmii_rxdv(),
   .gmii_rxer(),
   `else
   .gmii_rxd(gmii0_rxd_mux),
   .gmii_rxdv(gmii0_rxdv_mux),
   .gmii_rxer(gmii0_rxer_mux),
   `endif
   .gmii_crs(),       // spyglass disable W287b
   .gmii_col(),       // spyglass disable W287b
   .gmii_rxclk_ena(gmii_rxclk_ena),
   `ifdef   PHY_LOOPBACK_DOUT
   .gmii_txd(1'b0),
   .gmii_txen(1'b0),
   .gmii_txer(1'b0),
   `else
   .gmii_txd(gmii0_txd_mux),
   .gmii_txen(gmii0_txen_mux),
   .gmii_txer(gmii0_txer_mux),
   `endif
   .gmii_txclk_ena(gmii_txclk_ena),
   .gmii_tx_even(gmii_tx_even),
   .sgpcs_ena(1'b1),
   .sgpcs_ena_st(),   // spyglass disable W287b
   .sw_reset_r(),     // spyglass disable W287b
   .sw_reset_t(),     // spyglass disable W287b
   .an_enable(sg_an_enable_int),
   .sg_rx_sync(sg_rx_sync_int),
   .sg_an_done(sg_an_done_int),
   .sg_page_rx(sg_page_rx),
   .sg_speed(sg_speed),
   .sg_hd(sg_hd),
   .cfg_clock_rate(), // spyglass disable W287b
   .reg_rd(reg_rd),
   .reg_wr(reg_wr),
   .reg_addr(reg_addr),
   .reg_din(reg_din),
   .reg_dout(reg_dout),
   .reg_busy(reg_busy),
   .tx_lane_thresh(4'b0110),
   .tx_lane_ckmult(tx_lane_ckmult)
   
 `ifdef MTIPPCS36_EEE_ENA
   ,
   .pma_txmode_quiet(pma_txmode_quiet),
   .tx_lpi_active(tx_lpi_active),
   .pma_rxmode_quiet(pma_rxmode_quiet),
   .rx_lpi_active(rx_lpi_active),
   .rx_wake_err(rx_wake_err),
   .lpi_tick(lpi_tick)
 
 `endif

 `ifdef SGMII_BIT_SLIP_PIN
    ,
    .sg_bit_slip(sg_bit_slip)
    
 `endif
   
   );
wire  [9:0] xcvr_tbi_rx_gmii_0;
wire  [9:0] xcvr_tbi_tx_gmii_0;
wire  [9:0] xcvr_tbi_rx_gmii_1;
wire  [9:0] xcvr_tbi_tx_gmii_1;
wire  [9:0] xcvr_tbi_rx_gmii_2;
wire  [9:0] xcvr_tbi_tx_gmii_2;
wire  [9:0] xcvr_tbi_rx_gmii_3;
wire  [9:0] xcvr_tbi_tx_gmii_3;
wire clk_eth_ref_125mhz;
wire reference_clk;
 wire   fpll_locked_SGMII;
wire xcvr_tx_serial_clk0;
wire xcvr_rx_clk_0;
wire xcvr_rx_clk_1;
wire xcvr_rx_clk_2;
wire xcvr_rx_clk_3;
wire  rx_serial_data;
wire tx_serial_data;
wire  [31:0] usr_cntrl_0;  
wire [9:0] tbi_rx_phy;
wire [9:0] tbi_tx_phy;
wire [9:0] phy_loopback_inp; 
wire i_reset;
wire  [3:0] pcs_loopback_en;
wire  [3:0] serdes_loopback_en;

wire [7:0] gmii0_txd_mux;
wire gmii0_txen_mux;
wire gmii0_txer_mux;
wire [7:0] gmii0_rxd_mux;
wire gmii0_rxdv_mux;
wire gmii0_rxer_mux;
wire rx_clk_out;

wire [7:0] gmii_txd_conv;
wire gmii_txen_conv;
wire gmii_txer_conv;
wire [7:0] gmii_rxd_conv;
wire gmii_rxdv_conv;
wire gmii_rxer_conv;

//assign gmii_rxd_conv  = (~pcs_loopback_en[0]) ? (serdes_loopback_en[0] ? gmii_txd_conv : physs_eth.physs0.parmquad0.pcs100_wrap_0.quadpcs100_0.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_0.U_PCS.U_RXBUF.dout) : 0;
//assign gmii_rxdv_conv = (~pcs_loopback_en[0]) ? (serdes_loopback_en[0] ? gmii_txen_conv : physs_eth.physs0.parmquad0.pcs100_wrap_0.quadpcs100_0.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_0.U_PCS.U_RXBUF.rden) : 0;
//assign gmii_rxer_conv = (~pcs_loopback_en[0]) ? (serdes_loopback_en[0] ? gmii_txer_conv : gmii0_rxer_mux) : 0;

assign phy_loopback_inp = (pcs_loopback_en[0]) ?  physs_eth.physs0.parmquad0.pcs100_wrap_0.quadpcs100_0.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_0.U_PCS.U_RXBUF.sdbf_data :  gmii_txd_conv;
//assign  gmii0_txd_mux   = (pcs_loopback_en[0]) ?  physs_eth.physs0.parmquad0.pcs100_wrap_0.quadpcs100_0.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_0.U_PCS.U_RXBUF.dout :  gmii_txd_conv;                                   
//assign  gmii0_txen_mux  = (pcs_loopback_en[0]) ?  physs_eth.physs0.parmquad0.pcs100_wrap_0.quadpcs100_0.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_0.U_PCS.U_RXBUF.rden : gmii_txen_conv;                                  
//assign  gmii0_txer_mux  = (pcs_loopback_en[0]) ?  gmii0_rxer_mux : gmii_txer_conv;

assign gmii_rxd_conv  = (~pcs_loopback_en[0]) ? (serdes_loopback_en[0] ? gmii_txd_conv : gmii0_rxd_mux) : 0;
assign gmii_rxdv_conv = (~pcs_loopback_en[0]) ? (serdes_loopback_en[0] ? gmii_txen_conv : gmii0_rxdv_mux) : 0;
assign gmii_rxer_conv = (~pcs_loopback_en[0]) ? (serdes_loopback_en[0] ? gmii_txer_conv : gmii0_rxer_mux) : 0;

assign  gmii0_txd_mux   = (pcs_loopback_en[0]) ?  gmii0_rxd_mux :  gmii_txd_conv;                                   
assign  gmii0_txen_mux  = (pcs_loopback_en[0]) ?  gmii0_rxdv_mux : gmii_txen_conv;                                  
assign  gmii0_txer_mux  = (pcs_loopback_en[0]) ?  gmii0_rxer_mux : gmii_txer_conv;


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
assign usr_cntrl_0[3:0]  = 4'b0010;


ethernet_altera_phy u0_ethernet_altera_phy (

    .pcs_ref_clk_125mhz (pcs_ref_clk_125mhz),
    .xcvr_125mhz_refclk (clk_eth_ref_125mhz),
    .xcvr_reset  (sync_i_reset),
    .xcvr_tx_serial_clk0  (xcvr_tx_serial_clk0),
    .fpll_locked_SGMII   (fpll_locked_SGMII),    
    .xcvr_rx_clk (rx_clk_out),
    .xcvr_tbi_rx_gmii(tbi_rx_phy),
    `ifdef PHY_LOOPBACK_DOUT
    .xcvr_tbi_tx_gmii(phy_loopback_inp),
    `else
     .xcvr_tbi_tx_gmii(tbi_tx_phy),
    `endif
    .usr_cntrl_0   (usr_cntrl_0[3:0]),
    .fpga_pcs_loopback_ena (pcs_loopback_en[0]),
    .fpga_serdes_loopback_ena (serdes_loopback_en[0]),
    .xcvr_rx_serial_data  (rx_serial_data),          // SGMII_PHY_S10 from board    
    .xcvr_tx_serial_data  (tx_serial_data)           // SGMIIS_S10_PHY from board   
);


assign sg_rx_sync = sg_rx_sync_int;
assign sg_an_done = sg_an_done_int;
`ifdef SGMII_TSU_ENA
xgmii64_gmii_converter_seq_ts #(.CKE_ADVANCE(1), .BR_SUPPORT_ENA(BR_SUPPORT_ENA)) U_SCONV (
`else 
xgmii64_gmii_converter_seq #(.CKE_ADVANCE(1), .BR_SUPPORT_ENA(BR_SUPPORT_ENA)) U_SCONV (
`endif 
   .reset_txclk(sync_i_reset),
   .tx_clk(rx_clk_out),   
   .reset_rxclk(sync_i_reset),
   .rx_clk(rx_clk_out),
   .xgmii_txclk_ena(xlgmii_txclk_ena),
   .xgmii_txd(xlgmii_txd),
   .xgmii_txc(xlgmii_txc),
   .xgmii_rxclk_ena(xlgmii_rxclk_ena),
   .xgmii_rxd(xlgmii_rxd),
   .xgmii_rxc(xlgmii_rxc),
   .xgmii_rxt0_next(xlgmii_rxt0_next),
   .mode_sync(mode_sync),
   .mode_br_dis(mode_br_dis),
   .seq_ena(seq_ena),
   .gmii_ena(ena_int_r),
   .gmii_rxclk_ena(gmii_rxclk_ena),
   .gmii_rxd(gmii_rxd_conv),
   .gmii_rxdv(gmii_rxdv_conv),
   .gmii_rxer(gmii_rxer_conv),
   .gmii_txclk_ena(gmii_txclk_ena),
   .gmii_tx_even(gmii_tx_even),
   .gmii_txd(gmii_txd_conv),
   .gmii_txen(gmii_txen_conv),
   .gmii_txer(gmii_txer_conv)
`ifdef SGMII_TSU_ENA
    ,
   .cfg_sfd_ts(cfg_sfd_ts),
   .tx_sfd_o(tx_sfd_o_nc),
   .rx_sfd_o(sg_rx_tsu[0])
`endif 
);
   
`ifdef SGMII_TSU_ENA
assign sg_rx_tsu[1] = gmii_rxclk_ena;

// Counter from 0 to 15 to indicate the 16 byte cycle of gmii clock enables

cycle_counter #(

    .CNT_WIDTH(4),
    .CNT_MAX(16)) 
    
  U_CYCCNT (

    .clk(rx_clk_out),
    .reset(sync_i_reset),
    .enable(gmii_rxclk_ena),
    .cnt_out(cnt_nc),
    .cyc_start(cycle_start));
    
// Link status
// -----------

assign sg_link_status_int = (ena_int & ((sg_an_enable_int & sg_an_done_int) | sg_rx_sync_int));

mtip_dffvec #(1) U_LINKSTATUS_DFF (

    .reset  (sync_i_reset),
    .clk    (rx_clk_out),
    .i      (sg_link_status_int),
    .o      (sg_link_status_dff));

mtip_xsync #(1) U_LINKSTATUS_SYNC (

   .reset(sync_i_reset),
   .clk(rx_clk_out),
   .data_in(sg_link_status_dff),
   .data_s(sg_link_status));

`endif 
endmodule // module top_pcs_sgmii_refck_host_xlgmii
