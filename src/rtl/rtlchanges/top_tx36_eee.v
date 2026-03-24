//
//

`include "common_header.verilog"

//  *************************************************************************
//  File : top_tx36_eee.v
//  *************************************************************************
//  This program is controlled by a written license agreement.
//  Unauthorized Reproduction or Use is Expressly Prohibited. 
//  Copyright (c) 2002-2003 MoreThanIP.com, Germany
//  Designed by : Francois Balay
//  fbalay@morethanip.com
//  *************************************************************************
//  Decription : 1000 Base X Transmit Top Level
//  Version    : $Id: top_tx36_eee.v,v 1.1 2011/07/11 10:07:37 dk Exp $
//  *************************************************************************

module top_tx36_eee (

   reset,
   sw_reset,
   gmii_txclk,
  `ifdef USE_CLK_ENA
   gmii_txclk_ena,
  `endif   
   gmii_txen,
   gmii_txd,
   gmii_txerr,
   gmii_tx_even,
   transmit,
   an_ena,
   tx_ena,
   tx_idle,
   an_ability,
   tbi_tx
   `ifdef MTIPPCS36_EEE_ENA
   ,
   lpi_tick,
   tx_mode_quiet,
   tx_lpi_active
   `endif
   );

parameter ENCAP127_SEQ = 0;     //  if 1 Encode Sequence ordered set from XGMII (Clause 127) which is encoded on GMII as (dv=0, er=1, data=0x9c)
   
input   reset;                  //  Asynchronous Reset
input   sw_reset;               //  SW Asynchronous Reset           
input   gmii_txclk;             //  125MHz Transmit Clock
`ifdef USE_CLK_ENA
input   gmii_txclk_ena;
`endif 
input   gmii_txen;              //  Enable
input   [7:0] gmii_txd;         //  Data
input   gmii_txerr;             //  Error
output  gmii_tx_even;           //  Statemachine in tx_even state sampling GMII (frame start sampled only if tx_even=0)
output  transmit;               //  Frame Transmission Active
input   an_ena;                 //  Autonegotiation Enable   
input   tx_ena;                 //  Enable Transmit Enable - Autonegotiation Complete
input   tx_idle;                //  Enable Idle Transmit
input   [15:0] an_ability;      //  Autonegotiation Ability Register        
output  [9:0] tbi_tx;           //  Transmit TBI Interface
`ifdef MTIPPCS36_EEE_ENA
input   lpi_tick;               //  Timer Tick for all LPI timers
output  tx_mode_quiet;          //  tx_mode (0 - DATA, 1 - QUIET)
output  tx_lpi_active;          //  1 - the TX is in the Low Power State, 0 - in the Active State

wire    tx_mode_quiet; 
wire    tx_lpi_active; 
wire    tx_oset_li;             //  transmitting LPI (stable, clk_ena independent)
`endif

wire    transmit; 
wire    [9:0] tbi_tx; 

//  PMA I/O Registers
//  -----------------

wire    [9:0] tbi_tx_int;       //  Data 

///////////////////////////////////////////////
// For GbE XCVR connection changes added by Dhanabal
wire    [7:0] frame_gbe_o;    
wire    kchar_gbe_o;
///////////////////////////////////////////////


//  Encoder Interface
//  -----------------

wire    kchar;                  //  Special Character Encoding
wire    [7:0] frame;            //  Framed Ethernet Packet
wire    curr_disparity;         //  Current Disparity

wire    sw_reset_s;         //  Current Disparity


`ifdef XSYNC_DISABLE_SGMII
assign sw_reset_s = sw_reset ;
`else
// sync the async soft reset 
mtip_xsync #(1) U_SYSWRST (
          .data_in(sw_reset),
          .reset(reset),
          .clk(gmii_txclk),
          .data_s(sw_reset_s));
`endif

tx_encap_eee #(.ENCAP127_SEQ(ENCAP127_SEQ)) U_FRM (

          .reset(reset),
          .sw_reset(sw_reset_s),
          .clk(gmii_txclk),
          `ifdef USE_CLK_ENA
          .clk_ena(gmii_txclk_ena),
          `endif          
          .tx_ena(tx_ena),
          .tx_idle(tx_idle),
          .an_ability(an_ability),
          .an_ena(an_ena),
          .gmii_dv(gmii_txen),
          .gmii_ctl(gmii_txerr),
          .gmii_data(gmii_txd),
          .gmii_tx_even(gmii_tx_even),
          .transmit(transmit),
          .disparity(curr_disparity),
          .kchar(kchar),
          .frame(frame)
        `ifdef MTIPPCS36_EEE_ENA
          ,
          .tx_oset_li(tx_oset_li)
        `endif          
          );

enc8b10b U_ENCOD (

          .din(frame),
          .kin(kchar),
          `ifdef USE_CLK_ENA
          .ce(gmii_txclk_ena), 
          `else
          .ce(1'b 1),
          `endif
          .disp(curr_disparity),
          .dout(tbi_tx_int),
          .clk(gmii_txclk),
          .sw_reset(sw_reset_s),
          .rst(reset));

///////////////////////////////////////////////////////////////////////////
// Dhanabal added 8b/10b decoder to drive external altera GbE XCVR which has buil-in 8b/10b coders

assign  tbi_tx[7:0] = frame_gbe_o;
assign  tbi_tx[8] = kchar_gbe_o ;
assign  tbi_tx[9] = 1'b0 ;  // tie unsed bit to 0

dec10b8b U1_DECOD (

          .align_ena(1'b1),
          .rst_align(1'b0),    //rx_sync_lost 
          .din(tbi_tx_int),
          `ifdef USE_CLK_ENA
          .ce(gmii_txclk_ena), 
          `else
          .ce(vcc),
          `endif
          .dout(frame_gbe_o),
          .kout(kchar_gbe_o),
          .nd(),
          .carrier(),
          .comma(),
          .sync(),
          .error(),
          .clk(gmii_txclk),
          .sw_reset(sw_reset),
          .rst(reset));


//////////////////////////////////////////////////////////////////////////
//// Dhanabal commeneted below line
//assign tbi_tx = tbi_tx_int;     // comes already registered from enc8b10b


//  EEE statemachine
//  ----------------
`ifdef MTIPPCS36_EEE_ENA

tx_encap_stm36_9a U_TXSTMEEE (
          .reset(reset),
          .sw_reset(sw_reset_s),
          .clk(gmii_txclk),
          .tx_oset_li(tx_oset_li),
          .lpi_tick(lpi_tick),
          .tx_mode_quiet(tx_mode_quiet),
          .tx_lpi_active(tx_lpi_active));

`endif


endmodule // module top_tx36_eee
