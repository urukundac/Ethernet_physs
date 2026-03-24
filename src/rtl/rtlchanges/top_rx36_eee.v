//
//

`include "common_header.verilog"

//  *************************************************************************
//  File : top_rx36_eee.v
//  *************************************************************************
//  This program is controlled by a written license agreement.
//  Unauthorized Reproduction or Use is Expressly Prohibited. 
//  Copyright (c) 2002-2003-2004-2005 MoreThanIP.com, Germany
//  Designed by : Francois Balay
//  fbalay@morethanip.com
//  *************************************************************************
//  Decription : 1000 Base X Receive Top Level
//  Version    : $Id: top_rx36_eee.v,v 1.2 2012/11/23 12:20:13 wt Exp $
//  *************************************************************************

module top_rx36_eee (

 `ifdef SGMII_BIT_SLIP_REG
 
   bit_slip,
 
 `endif

   reset,
   sw_reset,
   gmii_rxdv,
   gmii_rxd,
   gmii_rxerr,
   page_receive,
   xmit_data,
   lp_ability,
   lp_ability_ena,
   idle_ena,
   rx_invalid,
   rx_clk,
  `ifdef USE_CLK_ENA
   rx_clk_ena,
  `endif
`ifdef MTIP_DEBUG_BUSES
   decode_err,
   desparity_err,
   decoder_sync,
   d_cfg_int,
   d_idle_int,
`endif
   rx_detect,
   tbi_rx,
   comma,
   receive,
   dec_sync,
   dec_err,
   sync_acqurd
   `ifdef MTIPPCS36_EEE_ENA
   ,
   lpi_tick,
   rx_mode_quiet,
   rx_lpi_active,
   rx_wake_err
   `endif
   );

parameter ENCAP127_SEQ = 0;     //  if 1 Encode Sequence ordered set from XGMII (Clause 127) which is encoded on GMII as (dv=0, er=1, data=0x9c)
   
`ifdef SGMII_BIT_SLIP_REG
 
 output [3:0] bit_slip;         //  Bit Slip Indication 
 
`endif

input   reset;                  //  Asynchronous Reset
input   sw_reset;               //  SW Asynchronous Reset           
output  gmii_rxdv;              //  Enable
output  [7:0] gmii_rxd;         //  Data
output  gmii_rxerr;             //  Error
output  page_receive;           //  Page Receive Indication
input   xmit_data;              //  Auto-Negotiation Status
output  [15:0] lp_ability;      //  Link Partner Ability Register
output  lp_ability_ena;         //  Link Partner Ability Valid 
output  idle_ena;               //  Idle Received        
output  rx_invalid;             //  Invalid Signal
input   rx_clk;                 //  125MHz Recoved Clock
`ifdef USE_CLK_ENA
input   rx_clk_ena;
`endif 
input   rx_detect;              //  Signal Detect
input   [9:0] tbi_rx;           //  Non Aligned 10-Bit Characters
output  comma;                  //  Comma Detected            
output  receive;                //  Frame Transmission Active
output  dec_sync;               //  Decoder Synchronized
output  dec_err;                //  Decoded Symbol Error
output  sync_acqurd;            //  Receiver Synchronized
`ifdef MTIPPCS36_EEE_ENA
input   lpi_tick;               //  Timer Tick for all LPI timers
output  rx_mode_quiet;          //  rx_mode (0 - DATA, 1 - QUIET)
output  rx_lpi_active;          //  1 - the Receiver in the Low Power State, 0 - in the Active State
output  rx_wake_err;            //  To increment the Wake Error Counter (pulse)

`ifdef MTIP_DEBUG_BUSES
output  decode_err;             //  Decode error
output  desparity_err;          //  Desparity error
output  decoder_sync;           //  10B sync statemachine status
output  d_cfg_int;              //  D2.2 or D21.5 (Config)  0x42/B5
output  d_idle_int;             //  D5.6 or D16.2 (IDLE)    0xC5/50
`endif

wire    rx_mode_quiet;
wire    rx_lpi_active;
wire    rx_wake_err;

wire    rx_sync_eee;            //  Link Sync OK masked to use for system status/AN(link-status)
`endif

`ifdef MTIP_DEBUG_BUSES
wire    decode_err;
wire    desparity_err;
wire    decoder_sync;
wire    d_cfg_int;              //  D2.2 or D21.5 (Config)  0x42/B5
wire    d_idle_int;             //  D5.6 or D16.2 (IDLE)    0xC5/50
`endif

`ifdef SGMII_BIT_SLIP_REG
 
 wire [3:0] bit_slip; 
 
`endif

wire    gmii_rxdv; 
wire    [7:0] gmii_rxd; 
wire    gmii_rxerr; 
wire    page_receive; 
wire    [15:0] lp_ability; 
wire    lp_ability_ena; 
wire    idle_ena; 
wire    rx_invalid; 
wire    comma; 
wire    receive; 
wire    dec_sync; 
wire    dec_err; 
wire    sync_acqurd; 

wire    kchar;                  //  Special Character Decoding
wire    [7:0] frame;            //  Framed Ethernet Packet
wire    carrier_detect;         //  Carrier detect 

//  TBI I/O Registers
//  -----------------

wire    rx_detect_int;          //  Signal Detect
reg     [9:0] tbi_rx_int;       //  Non Aligned 10-Bit Characters        

// GbE XCVR changes by Dhanabal

reg     [7:0] frame_gbe_i;
reg     kchar_gbe_i;
wire    [9:0] tbi_rx_gbe;



//  Status
//  ------

wire    sync_acqurd_int;        //  Rx Synchronized / Autonegociation Completed
wire    rx_sync_lost;           //  Synchronization Lost
wire    rx_even;                //  Even Code Group Receive
wire    dec_sync_int;           //  Rx Synchronized
wire    dec_err_int;            //  Character Error
wire    align_ena;              //  Enable aligner to perform word alignment if 1, else keep current unchanged

wire    sw_reset_s;

`ifdef MTIP_DEBUG_BUSES
assign    decoder_sync = sync_acqurd_int;
`endif


//  Domain Synchronization
//  -----------------------
`ifdef XSYNC_DISABLE_SGMII
assign sw_reset_s = sw_reset ;
`else
mtip_xsync #(1) U_SYSWRST (
          .data_in(sw_reset),
          .reset(reset),
          .clk(rx_clk),
          .data_s(sw_reset_s));
`endif

mtip_xsync #(1) U_SYRXDETECT (
          .data_in(rx_detect),
          .reset(reset),
          .clk(rx_clk),
          .data_s(rx_detect_int));

// TBI input register
always @(posedge reset or posedge rx_clk)
   begin : tbireg
   if (reset == 1'b 1)
      begin
      tbi_rx_int <= {10{1'b 0}};	
      end
   else
      begin
      if (rx_clk_ena == 1'b 1)
         begin
         tbi_rx_int <= tbi_rx;	
         end
      end
   end

assign align_ena = ~sync_acqurd_int;

dec10b8b U_DECOD (

        `ifdef SGMII_BIT_SLIP_REG
 
          .bit_slip(bit_slip),
 
        `endif

          .align_ena(align_ena),
          .rst_align(rx_sync_lost),
          .din(tbi_rx_gbe),
          `ifdef USE_CLK_ENA
          .ce(rx_clk_ena), 
          `else
          .ce(1'b 1),
          `endif
          .dout(frame),
          .kout(kchar),
          .nd(),
          .carrier(carrier_detect),
          .comma(comma),
          .sync(dec_sync_int),
          .error(dec_err_int),
           `ifdef MTIP_DEBUG_BUSES
          .decode_err(decode_err),
          .desparity_err(desparity_err),
           `endif
          .clk(rx_clk),
          .sw_reset(sw_reset_s),
          .rst(reset));

assign dec_sync = dec_sync_int; 
assign dec_err  = dec_err_int; 

rx_sync U_SYNC (

          .reset(reset),
          .sw_reset(sw_reset_s),
          .clk(rx_clk),
          `ifdef USE_CLK_ENA
          .clk_ena(rx_clk_ena),
          `endif          
          .signal_detect(rx_detect_int),
          .comma_detect(dec_sync_int),
          .kchar(kchar),
          .data(frame),
          .char_err(dec_err_int),
          .sync_acqurd(sync_acqurd_int),
          .sync_lost(rx_sync_lost),
          .rx_even(rx_even));

`ifdef MTIPPCS36_EEE_ENA
assign sync_acqurd = rx_sync_eee; //  masked during LPI (sync_acqurd_int)
`else
assign sync_acqurd = sync_acqurd_int; 
`endif

////////////////////////////////////////////////////////////////////////////////
// Dhanabal added encoder to enable connection with Altera GbE transiever which has built-in 8b/10b coders

assign  frame_gbe_i = tbi_rx_int[7:0];
assign  kchar_gbe_i = tbi_rx_int[8];

enc8b10b U1_ENCOD (
          .din(frame_gbe_i),
          .kin(kchar_gbe_i),
          `ifdef USE_CLK_ENA
          .ce(rx_clk_ena), 
          `else
          .ce(vcc),
          `endif
          .disp(),
          .dout(tbi_rx_gbe),
          .clk(rx_clk),
          .sw_reset(sw_reset_reg2),
          .rst(reset));
          
/////////////////////////////////////////////////////////////////////////////////////          


rx_encap_eee #(.ENCAP127_SEQ(ENCAP127_SEQ)) U_FRM (

          .reset(reset),
          .sw_reset(sw_reset_s),
          .clk(rx_clk),
          `ifdef USE_CLK_ENA
          .clk_ena(rx_clk_ena),
          `endif
          .signal_det(rx_detect_int),
          .rx_sync(sync_acqurd_int),
          .rx_even(rx_even),
          .receive(receive),
          .idle_ena(idle_ena),
          .rx_invalid(rx_invalid),
          .xmit_data(xmit_data),
          .page_receive(page_receive),
          .lp_ability(lp_ability),
          .lp_ability_ena(lp_ability_ena),
          .kchar(kchar),
          .frame(frame),
          .char_err(dec_err_int),
          .carrier_detect(carrier_detect),
        `ifdef MTIP_DEBUG_BUSES
          .d_cfg_int(d_cfg_int),
          .d_idle_int(d_idle_int),
        `endif
          .gmii_dv(gmii_rxdv),
          .gmii_err(gmii_rxerr),
          .gmii_data(gmii_rxd)
        `ifdef MTIPPCS36_EEE_ENA
          ,
          .lpi_tick(lpi_tick),
          .rx_sync_eee(rx_sync_eee),
          .rx_mode_quiet(rx_mode_quiet),
          .rx_lpi_active(rx_lpi_active),
          .rx_wake_err(rx_wake_err)
        `endif
          );

endmodule // module top_rx36_eee
