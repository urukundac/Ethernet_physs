
`include "common_header.verilog"

//  *************************************************************************
//  File : sgpcs_mdio_np_reg.v
//  *************************************************************************
//  This program is controlled by a written license agreement.
//  Unauthorized Reproduction or Use is Expressly Prohibited. 
//  Copyright (c) 2003-2006 MoreThanIP.com, Germany
//  Designed by : Francois Balay
//  fbalay@morethanip.com
//  *************************************************************************
//  Decription : MDIO Registers with SGMII special controls
//  Version    : $Id: sgpcs_mdio_np_reg.v,v 1.13 2019/03/05 11:23:31 gc Exp $
//  *************************************************************************

module sgpcs_mdio_np_reg (

`ifdef SGMII_BIT_SLIP_REG
 
   bit_slip,
 
`endif

   reset_rx_clk,
   reset_clk,
   clk,
   rx_clk,
   reg_addr,
   reg_write,
   reg_read,
   reg_dout,
   reg_din,
`ifdef MTIP_DIR_CONFIG
   sw_reset_dir,
`endif
   reg_page_rx,
   sw_reset,
   loopback_ena,
   isolate,
   powerdown,
   dec_err,
   link_status,
   an_enable,
   an_restart,
   an_ability,
   mr_np,
   mr_np_loaded,
   mr_np_loaded_rst,   
   link_timer,
   an_restart_rst,
   mr_page_rx,
   mr_is_basepage,
   mr_page,
   an_restart_state,   
   an_done,
   an_ack,
   page_receive,
`ifdef MTIP_DEBUG_BUSES
   d_cfg_int,
   d_idle_int,
`endif
   sgmii_speed,
   sgmii_duplex,
   sgmii_ena,
   sgpcs_ena,
   sgpcs_ena_st,
   cfg_clock_rate);
   
//`include "pcs_pack_package.verilog"

parameter PHY_IDENTIFIER = 32'h 4d544950; 
parameter DEV_VERSION    = 16'h 0001; 

`ifdef SGMII_BIT_SLIP_REG
 
 input  [3:0] bit_slip;         //  Bit Slip Indication 
 
`endif

input   reset_rx_clk;           //  Asynchronous Reset - rx_clk Domain
input   reset_clk;              //  Asynchronous Reset - clk Domain
input   clk;                    //  MDIO 2.5MHz Clock
input   rx_clk;                 //  125MHz TBI Line Clock
input   [4:0] reg_addr;         //  Address Register
input   reg_write;              //  Write Register 		
input   reg_read;               //  Read Register 		
output  [15:0] reg_dout;        //  Data Bus OUT
input   [15:0] reg_din;         //  Data Bus IN
`ifdef MTIP_DIR_CONFIG
input   sw_reset_dir;           //  SW reset from the direct interface
`endif
output  reg_page_rx;            //  new page received (reg_clk pulse)
output  sw_reset;               //  PHY Reset
output  loopback_ena;           //  PHY Loopback Enable
output  isolate;                //  Isolate Channel
output  powerdown;              //  Power Down
input   dec_err;                //  Decoder Error
input   link_status;            //  Valid Link Indication
output  an_enable;              //  Enable Autonegotiation
output  an_restart;             //  Restart Autonegotiation        
output  [15:0] an_ability;      //  Autonegotiation Ability Register
output  [15:0] mr_np;           //  Next Page Register
output  mr_np_loaded;           //  Next page loaded
input   mr_np_loaded_rst;       //  Handshake to clear mr_np_loaded (Pulse)   
output  [20:1] link_timer;      //  Link Timer Maximim Value
input   an_restart_rst;         //  Reset Re-Negotiate Command
input   mr_page_rx;             //  New page received (Pulse)
input   mr_is_basepage;         //  Received page is base page
input   [15:0] mr_page;         //  Received page
input   an_restart_state;       //  current state is AUTONEG_RESTART state   
input   an_done;                //  Autonegotiation Done
input   an_ack;                 //  Acknowledge Bit
input   page_receive;           //  Page Receive Indication
`ifdef MTIP_DEBUG_BUSES
input   d_cfg_int;              //  D2.2 or D21.5 (Config)  0x42/B5
input   d_idle_int;             //  D5.6 or D16.2 (IDLE)    0xC5/50
`endif
output  [1:0] sgmii_speed;      //  SGMII Speed
output  sgmii_duplex;           //  SGMII Half-Duplex Mode
output  sgmii_ena;              //  SGMII PCS datapath enable
input   sgpcs_ena;              //  Enable for the 1G PCS from input pin
output  sgpcs_ena_st;           //  Enable for the 1G PCS. Combination of input pin and control register
output  [3:0] cfg_clock_rate;   //  compensate ref-clock overspeed dividing clock with exception 1 being 2/3

reg     [15:0] reg_dout; 
wire    reg_page_rx;
reg     sw_reset; 
reg     loopback_ena; 
reg     isolate; 
reg     powerdown; 
reg     an_enable; 
reg     an_restart; 
wire    [15:0] an_ability; 
wire    [15:0] mr_np;           //  Next Page Register
reg     mr_np_loaded;           //  Next page loaded
wire    [20:1] link_timer; 
reg     [1:0] sgmii_speed;
reg     sgmii_duplex;
reg     sgmii_ena;              //  SGMII PCS datapath enable
reg     sgpcs_ena_st;
reg     [3:0] cfg_clock_rate;

wire    [15:0] mdio_control; 
wire    [5:0] mdio_control_5_0;
wire    mdio_control_6;
wire    mdio_control_7;
wire    mdio_control_8;
reg     mdio_control_9;
reg     mdio_control_10;
reg     mdio_control_11;
reg     mdio_control_12;
wire    mdio_control_13;
reg     mdio_control_14;
reg     mdio_control_15;
wire    [15:0] mdio_status; 
reg            mdio_status2; 
reg            mdio_status5; 
reg     [15:0] dev_ability; 
reg     [15:0] partner_ability; 
reg     [15:0] scratch_reg; 
wire    [31:0] link_timer_reg; 
wire    [31:21] link_timer_reg_31_21;
reg     [20:1] link_timer_reg_20_1;
wire    link_timer_reg_0;
wire    an_expansion0;
reg     an_expansion1;
wire    an_expansion2;
wire    [31:0] phy_identifier_w;
reg     page_receive_reg;
reg     page_receive_current;
reg     [15:0] dec_err_cnt;
wire    [15:0] dec_err_cnt_reg2;
reg     cnt_rst_reg;
wire    cnt_rst_reg2;

reg     [15:0] np_tx;
reg     [15:0] lp_np_rx;
wire    np_loaded_rst;

wire    page_rx_pulse;
reg     sgpcs_ena_r; //  Enable for the 1G PCS, register
wire    sgpcs_ena_s;

// Sgmii controls
// --------------
reg     [5:0] if_mode;



// Clock domain crossing
// ---------------------
wire    [15:0] partner_ability_reg2;
wire    [15:0] lp_np_rx_reg2;
`ifdef MTIP_DEBUG_BUSES
reg     [1:0] an_seq;
`endif
wire    an_done_reg2;
wire    an_ack_reg2;            //  Acknowledge Bit
wire    link_status_reg2;
wire    an_restart_rst_reg1;
wire    an_restart_state_reg1;

//  Latch Low Control
//  -----------------

reg     link_rst; 
reg     reg_read_d; 
reg     [4:0] reg_addr_d;


`ifdef MTIP_DEBUG_BUSES
wire    d_cfg;                  //  D2.2 or D21.5 (Config)  0x42/B5
wire    d_idle;                 //  D5.6 or D16.2 (IDLE)    0xC5/50


redge_ckxing_tog U_CONF_IDLE_SEQ(
   
        .reset          (reset_rx_clk),
        .clk            (rx_clk),
        .sig            (d_cfg_int),
        .reset_clk_o    (reset_clk),
        .clk_o          (clk),
        .sig_o          (d_cfg));


redge_ckxing_tog U_IDLE_SEQ(
   
        .reset          (reset_rx_clk),
        .clk            (rx_clk),
        .sig            (d_idle_int),
        .reset_clk_o    (reset_clk),
        .clk_o          (clk),
        .sig_o          (d_idle));

`endif

`ifdef SGMII_BIT_SLIP_REG
 
 wire   [3:0] bit_slip_reg2;
 
 mtip_xsync #(4) U_BTSLP (

          .data_in(bit_slip),
          .reset(reset_clk),
          .clk(clk),
          .data_s(bit_slip_reg2)); 

`endif

always @(posedge reset_clk or posedge clk)
   begin : process_23
   if (reset_clk == 1'b 1)
      begin
      reg_read_d   <= 1'b 0;  
      reg_addr_d   <= 5'b 00000;
      end
   else
      begin
      reg_read_d   <= reg_read;   
      reg_addr_d   <= reg_addr;
      end
   end

// clock domain crossing

mtip_xsync #(16) U_PTRABS (

          .data_in(partner_ability),
          .reset(reset_clk),
          .clk(clk),
          .data_s(partner_ability_reg2));

mtip_xsync #(16) U_LPNPS (

          .data_in(lp_np_rx),
          .reset(reset_clk),
          .clk(clk),
          .data_s(lp_np_rx_reg2));

`ifdef XSYNC_ENA_SGMII_ANDONE
    assign an_done_reg2 = an_done ;
`else 
mtip_xsync #(1) U_ANDNS (

          .data_in(an_done),
          .reset(reset_clk),
          .clk(clk),
          .data_s(an_done_reg2));
`endif
          
mtip_xsync #(1) U_ANACKS (

          .data_in(an_ack),
          .reset(reset_clk),
          .clk(clk),
          .data_s(an_ack_reg2));
`ifdef XSYNC_ENA_SGMII_LINK
    assign link_status_reg2 = link_status ;
`else 
mtip_xsync #(1) U_LNKSTS (

          .data_in(link_status),
          .reset(reset_clk),
          .clk(clk),
          .data_s(link_status_reg2));
`endif

//  Control Register
//  ----------------

assign mdio_control_5_0 = 6'b 000000; 
assign mdio_control_6   = 1'b 1; 
assign mdio_control_7   = 1'b 0; 
assign mdio_control_8   = 1'b 1; 
assign mdio_control_13  = 1'b 0; 

assign mdio_control[5:0] = mdio_control_5_0;
assign mdio_control[6]   = mdio_control_6;
assign mdio_control[7]   = mdio_control_7;
assign mdio_control[8]   = mdio_control_8;
assign mdio_control[9]   = mdio_control_9;
assign mdio_control[10]  = mdio_control_10;
assign mdio_control[11]  = mdio_control_11;
assign mdio_control[12]  = mdio_control_12;
assign mdio_control[13]  = mdio_control_13;
assign mdio_control[14]  = mdio_control_14;
assign mdio_control[15]  = mdio_control_15;

// Clock domain crossing

mtip_xsync #(1) U_RSTRSTS (

          .data_in(an_restart_rst),
          .reset(reset_clk),
          .clk(clk),
          .data_s(an_restart_rst_reg1));
          
mtip_xsync #(1) U_RSTRST (

          .data_in(an_restart_state),
          .reset(reset_clk),
          .clk(clk),
          .data_s(an_restart_state_reg1));

// spyglass disable_block STARC05-2.11.3.1 -- Combinatorial and sequential parts of an FSM in the same always block -- not applicable here
always @(posedge reset_clk or posedge clk)
   begin : process_24
   if (reset_clk == 1'b 1)
      begin
      mdio_control_9  <= 1'b 0;   
      mdio_control_10 <= 1'b 0;   
      mdio_control_11 <= 1'b 0;   
      mdio_control_12 <= 1'b 0;   //  an_enable default enabled. (commented by Dhanabal)
      mdio_control_14 <= 1'b 0;   
      mdio_control_15 <= 1'b 0;   
      end
   else
      begin

   //  Self Clearing Reset
   //  -------------------
   
      if (reg_addr == 5'b 00000 & reg_write == 1'b 1 )
         begin
         mdio_control_15 <= reg_din[15];   
         end
      `ifdef MTIP_DIR_CONFIG
      else if (sw_reset_dir == 1'b 1)
         begin
         mdio_control_15 <= 1'b 1;   
         end
      `endif
      else if (mdio_control_15 == 1'b 1)
         begin
         mdio_control_15 <= 1'b 0;   
         end

   //  Self Clearing Auto Negotiation Re-Start
   //  ---------------------------------------
   
      if (an_restart_rst_reg1 == 1'b 1)
         begin
         mdio_control_9 <= 1'b 0;   
         end
      else if (reg_addr == 5'b 00000 & reg_write == 1'b 1 )
         begin
         mdio_control_9 <= reg_din[9];   
         end
      if (reg_addr == 5'b 00000 & reg_write == 1'b 1)
         begin
         mdio_control_10 <= reg_din[10];   
         mdio_control_11 <= reg_din[11];   
         mdio_control_12 <= reg_din[12];   
         mdio_control_14 <= reg_din[14];   
         end
      end
   end
// spyglass enable_block STARC05-2.11.3.1 -- Combinatorial and sequential parts of an FSM in the same always block -- not applicable here

always @(posedge reset_clk or posedge clk)
   begin : process_25
   if (reset_clk == 1'b 1)
      begin
      an_restart   <= 1'b 0;   
      isolate      <= 1'b 0;   
      powerdown    <= 1'b 0;   
      an_enable    <= 1'b 0;   
      loopback_ena <= 1'b 0;   
      sw_reset     <= 1'b 0;   
      end
   else
      begin
      an_restart   <= mdio_control[9];   
      isolate      <= mdio_control[10];   
      powerdown    <= mdio_control[11];   
      an_enable    <= mdio_control[12];   
      loopback_ena <= mdio_control[14];   
      sw_reset     <= mdio_control[15] | mdio_control[10];   
      end
   end

//  Status Register
//  ---------------

assign mdio_status = { 10'd 0, mdio_status5, 1'b 0, 1'b 1, mdio_status2, 1'b 0, 1'b 1 };

always @(posedge reset_clk or posedge clk)
   begin : process_26
   if (reset_clk == 1'b 1)
      begin
      link_rst <= 1'b 0;   
      end
   else
      begin
      if (reg_addr_d == 5'b 00001 & reg_read == 1'b 0 & reg_read_d == 1'b 1)
         begin
         link_rst <= 1'b 1;   
         end
      else 
         begin
         link_rst <= 1'b 0;   
         end
      end
   end

always @(posedge reset_clk or posedge clk)
   begin : process_27
   if (reset_clk == 1'b 1)
      begin
      mdio_status2 <= 1'b 0;   
      mdio_status5 <= 1'b 0;   
      end
   else
      begin

   //  Latching Low Link Status
   //  ------------------------
   
      if (link_rst == 1'b 1)
         begin
         mdio_status2 <= link_status_reg2;   
         end
      else if (link_status_reg2 == 1'b 0 )
         begin
         mdio_status2 <= 1'b 0;   
         end

      if (an_done_reg2 == 1'b 1 & mdio_control[12] == 1'b 1 & mdio_control[15]==1'b 0)
         begin
         mdio_status5 <= 1'b 1;   
         end
      else
         begin
         mdio_status5 <= 1'b 0;   
         end

      end
   end

//  ------------------------ //
//  Auto-Negotiation Control //
//  ------------------------ //

//  Device Ability
//  --------------

always @(posedge reset_clk or posedge clk)
   begin : process_28
   if (reset_clk == 1'b 1)
      begin
      dev_ability[4:0]   <= 5'b 00000; 
      dev_ability[8:5]   <= 4'b 1101; // default 1000 Base-X. Fullduplex only, full pause support
      dev_ability[15:9]  <= 7'b 0000000; 
      end
   else
      begin
      
        if (reg_addr == 5'h 4 & reg_write == 1'b 1)
        begin
                dev_ability[13:0]  <= reg_din[13:0];   
                dev_ability[15]    <= reg_din[15];  
        end 
      
        dev_ability[14] <= an_ack_reg2;   
         
      end
   end

assign an_ability = dev_ability;        // will be sync'ed in arbitration
        
always @(posedge reset_clk or posedge clk)
   begin : process_np
   if (reset_clk == 1'b 1)
      begin
      np_tx[15:0]   <= {16{1'b 0}};
      end
   else
      begin
      if (reg_addr == 5'h 7 & reg_write == 1'b 1)
         begin
         np_tx<= reg_din;
         end 
      end
   end

assign mr_np = np_tx;


redge_ckxing U_CKXING0(
        
        .reset           (reset_rx_clk),
        .clk             (rx_clk),
        .sig             (mr_np_loaded_rst),
        .reset_clk_o     (reset_clk),
        .clk_o           (clk),
        .sig_o           (np_loaded_rst));

always @(posedge reset_clk or posedge clk)
   begin : process_np_loaded
   if (reset_clk == 1'b 1)
      begin
      mr_np_loaded   <= 1'b 0;
      end
   else
      begin
      if(np_loaded_rst==1'b 1)
         begin
         mr_np_loaded   <= 1'b 0;
         end       
      else if (reg_addr == 5'h 7 & reg_write == 1'b 1)
         begin
         mr_np_loaded   <= 1'b 1;
         end       
      end
   end

//  Partner Next Page
//  -----------------

always @(posedge reset_rx_clk or posedge rx_clk)
   begin : process_30
   if (reset_rx_clk == 1'b 1)
      begin
        partner_ability <= {16{1'b 0}};   
       //partner_ability <= {16{1'b 1}};   // Dhanabal changed for manual SGMII configuration

      end
   else
      begin
      if (an_restart_state == 1'b 1)
         begin
         partner_ability <= {16{1'b 0}};
         end       
      else if (mr_page_rx == 1'b 1 & mr_is_basepage==1'b 1)
         begin
         partner_ability <= mr_page;   
         end
      end
   end


always @(posedge reset_rx_clk or posedge rx_clk)
   begin : process_lp_np
   if (reset_rx_clk == 1'b 1)
      begin
      lp_np_rx <= {16{1'b 0}};   
      end
   else
      begin
      if (an_restart_state == 1'b 1)
         begin
         lp_np_rx <= {16{1'b 0}};
         end       
      else if (mr_page_rx == 1'b 1 & mr_is_basepage==1'b 0)
         begin
         lp_np_rx <= mr_page;
         end
      end
   end

//  Auto-Negotiation Expansion
//  --------------------------

assign  an_expansion2 = 1'b 0;  // Nextpageable

redge_ckxing U_CKXING1(
        
        .reset           (reset_rx_clk),
        .clk             (rx_clk),
        .sig             (mr_page_rx),
        .reset_clk_o     (reset_clk),
        .clk_o           (clk),
        .sig_o           (page_rx_pulse));

assign reg_page_rx = page_rx_pulse;     // external interrupt pin, however only a single cycle pulse!

always @(posedge reset_clk or posedge clk)
   begin : process_32a
   if (reset_clk == 1'b 1)
      begin
      an_expansion1  <= 1'b 0; 
      end
   else
      begin      
      if(an_restart_state_reg1==1'b 1)
         begin
         an_expansion1 <= 1'b 0;   
         end        
      else if (page_rx_pulse == 1'b 1)
         begin
         an_expansion1 <= 1'b 1;   
         end      
      else if (reg_addr == 5'b 00110 & reg_read == 1'b 1 & reg_read_d == 1'b 0) // sampled on very first cycle only, must not clear flag at any other time
         begin
         an_expansion1 <= 1'b 0;      
         end
      end
   end

always @(posedge reset_rx_clk or posedge rx_clk)
   begin : process_32
   if (reset_rx_clk == 1'b 1)
      begin      
      page_receive_reg          <= 1'b 0;
      page_receive_current      <= 1'b 0;
      end
   else
      begin
      page_receive_reg          <= page_receive ;
      page_receive_current      <= page_receive | page_receive_reg;       // Real Time      
      end
   end

// Clock domain crossing
mtip_xsync #(1) U_ANEXP0S (

          .data_in(page_receive_current),
          .reset(reset_clk),
          .clk(clk),
          .data_s(an_expansion0));

   
//  ------------------ //
//  Extended Registers //
//  ------------------ // 

//  Scratch Register
//  ----------------

always @(posedge reset_clk or posedge clk)
   begin : process_33
   if (reset_clk == 1'b 1)
      begin
      scratch_reg <= {16{1'b 0}};   
      end
   else
      begin
      if (reg_addr == 5'b 10000 & reg_write == 1'b 1)
         begin
         scratch_reg <= reg_din;   
         end
      end
   end

//  Link Timer Register
//  -------------------

assign link_timer_reg_31_21 = {11{1'b 0}}; 
assign link_timer_reg_0     = 1'b 0; 

assign link_timer_reg[31:21] = link_timer_reg_31_21;
assign link_timer_reg[20:1]  = link_timer_reg_20_1;
assign link_timer_reg[0]     = link_timer_reg_0;

always @(posedge reset_clk or posedge clk)
   begin : process_34
   if (reset_clk == 1'b 1)
      begin
    //  link_timer_reg_20_1 <= 20'h 98968;   //  (1250000) Link Timer set to 10ms    
     // link_timer_reg_20_1 <= 20'h 00000;   //  Link Timer set to 0 for manual configration (Dhanabal)
        link_timer_reg_20_1 <= 20'h 2625a;   //  Link Timer set to 2.5ms for manual configration (Dhanabal)
    
      end
   else
      begin
      if (reg_addr == 5'b 10010 & reg_write == 1'b 1)
         begin
         link_timer_reg_20_1[15:1] <= reg_din[15:1];   
         end

      if (reg_addr == 5'b 10011 & reg_write == 1'b 1)
         begin
         link_timer_reg_20_1[20:16] <= reg_din[4:0];   
         end
      end
   end

assign link_timer = link_timer_reg[20:1]; 

//  PHY identifier
//  --------------

assign phy_identifier_w = PHY_IDENTIFIER ;

//  Decoder Error Counter
//  ---------------------

redge_ckxing U_SYSRSTR (
          .reset(reset_clk),
          .clk(clk),
          .sig(cnt_rst_reg),
          .reset_clk_o(reset_rx_clk),
          .clk_o(rx_clk),
          .sig_o(cnt_rst_reg2));

always @(posedge reset_rx_clk or posedge rx_clk)
   begin : process_37
   if (reset_rx_clk == 1'b 1)
      begin
      dec_err_cnt  <= {16{1'b 0}};  
      end
   else
      begin
      if (cnt_rst_reg2==1'b1)
         begin
         dec_err_cnt <= 16'd0;
         end
      else if (dec_err==1'b1)
         begin
         dec_err_cnt <= dec_err_cnt+16'd1;
         end  
      end
   end

mtip_xsync #(16) U_DECERRS (

          .data_in(dec_err_cnt),
          .reset(reset_clk),
          .clk(clk),
          .data_s(dec_err_cnt_reg2));
   
always @(posedge reset_clk or posedge clk)
   begin : process_38
   if (reset_clk == 1'b 1)
      begin
      cnt_rst_reg <= 1'b0;
      end
   else
      begin
      cnt_rst_reg <= mdio_control[15] | mdio_control[10];
      end
   end

//  ------------------------------
// Vendor specific: SGMII controls
//  ------------------------------

//  Interface Mode
//  --------------

always @(posedge reset_clk or posedge clk)
   begin
   if (reset_clk == 1'b 1)
      begin
      if_mode <= 6'h0 ;
      end
   else
      begin
      if (reg_addr == 5'b 10100 & reg_write == 1'b 1)
         begin
         if_mode <= reg_din[5:0]; 
         end
      end
   end

//assign sgmii_ena = if_mode[5];
   
// Auto-Negotiation Resolution
// ---------------------------

always @(posedge reset_clk or posedge clk)
   begin
   if (reset_clk == 1'b 1)
      begin
      sgmii_speed  <= 2'b00 ;
      sgmii_duplex <= 1'b0 ;
      sgmii_ena    <= 1'b 0;
      end
   else
      begin
      
        sgmii_ena <= if_mode[0] | if_mode[5];   // bit5 is for compatibility with in-MAC PCS Layer

      // SGMII Disabled - 1000Base-X Mode Enabled
      // ----------------------------------------
      
      if (if_mode[0]==1'b0)
         begin
         sgmii_speed  <= 2'b10; 
         sgmii_duplex <= 1'b0;
         end
         
      // SGMII Enabled, Static Configuration
      // -----------------------------------
         
      else if (if_mode[0]==1'b1 & if_mode[1]==1'b0)
         begin
         sgmii_speed  <= if_mode[3:2];
         
                if (if_mode[3:2]==2'b10)
                begin
         
                        sgmii_duplex <= 1'b0 ;
                
                end
                else
                begin
         
                        sgmii_duplex <= if_mode[4];
                        
                end
                
         end
         
      // SGMII Enabled, Dynamic Configuration
      // ------------------------------------  
         
      else if (if_mode[0]==1'b1 & if_mode[1]==1'b1 & an_done_reg2==1'b 1) // & partner_ability15_reg2==1'b 1 
         begin
                // reload data only when there is a real link and AN has completed
                
                sgmii_speed  <= partner_ability_reg2[11:10];

                if (partner_ability_reg2[11:10]==2'b10)
                begin
         
                        sgmii_duplex <= 1'b0 ;
                
                end
                else
                begin
         
                        sgmii_duplex <= !(partner_ability_reg2[12]); // copper status: 0=halfduplex
                        
                end
         
         end
      end
   end


`ifdef MTIP_DEBUG_BUSES
// AN Current Sequence Register
always @(posedge reset_clk or posedge clk)
begin
        if (reset_clk == 1'b 1)
        begin
                an_seq <= 2'b 0;   
        end
        else
        begin
                if (d_idle == 1'b1)
                begin
                        an_seq[0] <= 1'b 1;        
                end
                else if (reg_read == 1'b 1 & reg_addr == 5'b 01001)
                begin
                        an_seq[0] <= 1'b 0;   
                end
                if (d_cfg == 1'b1)
                begin
                        an_seq[1] <= 1'b 1;        
                end
                else if (reg_read == 1'b 1 & reg_addr == 5'b 01001)
                begin
                        an_seq[1] <= 1'b 0;   
                end
      end
 end
`endif


//  Vendor PCS Control
//  ------------------

always @(posedge reset_clk or posedge clk)
   begin
   if (reset_clk == 1'b 1)
      begin
      cfg_clock_rate <= 4'd 0;
      sgpcs_ena_r    <= 1'b 0;
      end
   else
      begin
      if (reg_addr == 5'b 10110 & reg_write == 1'b 1)
         begin
         cfg_clock_rate <= reg_din[7:4]; 
         sgpcs_ena_r    <= reg_din[0];
         end
      end
   end

mtip_xsync #(1) U_SYSGPCSENA (
          .reset(reset_clk),
          .clk(clk),
          .data_in(sgpcs_ena),
          .data_s(sgpcs_ena_s));

//  Glitch Protection
//  -----------------

always @(posedge reset_clk or posedge clk)
   begin
   if (reset_clk == 1'b 1)
      begin
      sgpcs_ena_st <= 1'b 0;
      end
   else
      begin
      sgpcs_ena_st <= sgpcs_ena_s | sgpcs_ena_r;
      end
   end
   
//  Read MUX
//  --------

always @(*)
   begin : process_36
   case (reg_addr)
   5'b 00000:
      begin
      reg_dout = mdio_control;   
      end
   5'b 00001:
      begin
      reg_dout = mdio_status;   
      end
   5'b 00010:
      begin
      reg_dout = phy_identifier_w[15:0];   
      end
   5'b 00011:
      begin
      reg_dout = phy_identifier_w[31:16];   
      end
   5'b 00100:
      begin
      reg_dout = dev_ability;   
      end
   5'b 00101:
      begin
      reg_dout = partner_ability_reg2;   
      end
   5'b 00110:
      begin
      reg_dout[15:3] = 13'd0;
      reg_dout[2]  = an_expansion2;
      reg_dout[1]  = an_expansion1;
      reg_dout[0]  = an_expansion0;
      end
   5'b 00111:
      begin
      reg_dout = np_tx;   
      end
   5'b 01000:
      begin
      reg_dout = lp_np_rx_reg2;
      end
`ifdef MTIP_DEBUG_BUSES
   5'b 01001:
      begin
      reg_dout = {14'b 0, an_seq};   
      end
`else
   5'b 01001:
      begin
      reg_dout = {16{1'b 0}};   
      end
`endif

   5'b 01010:
      begin
      reg_dout = {16{1'b 0}};   
      end
   5'b 01011:
      begin
      reg_dout = {16{1'b 0}};   
      end
   5'b 01100:
      begin
      reg_dout = {16{1'b 0}};   
      end
   5'b 01101:
      begin
      reg_dout = {16{1'b 0}};   
      end
   5'b 01110:
      begin
      reg_dout = {16{1'b 0}};   
      end
   5'b 01111:
      begin
      reg_dout = {16{1'b 0}};   
      end
   5'b 10000:
      begin
      reg_dout = scratch_reg;   
      end
   5'b 10001:
      begin
      reg_dout = DEV_VERSION;   
      end
   5'b 10010:
      begin
      reg_dout = link_timer_reg[15:0];   
      end
   5'b 10011:
      begin
      reg_dout = link_timer_reg[31:16];   
      end
   5'b 10100:
      begin
      reg_dout = {10'b 0000000000 , if_mode};   
      end
   5'b 10101:
      begin
      reg_dout = dec_err_cnt_reg2 ;
      end
   5'b 10110:
      begin
      reg_dout = {sgpcs_ena_st, 7'd 0, cfg_clock_rate, 3'd 0, sgpcs_ena_r} ;
      end

 `ifdef SGMII_BIT_SLIP_REG
 
   5'b 10111:
      begin
      reg_dout = {12'd 0, bit_slip_reg2} ;
      end 

 `endif

   default:
      begin
      reg_dout = {16{1'b 0}};   
      end
   endcase
   end


`ifdef MTIPHDLPATH_DISPLAY
// synthesis translate_off
// synopsys translate_off

// For use by SystemRDL importer provide pathes to the individual registers.
// Lines must contain the tag-pattern "<mtiphdlpath," then followed by comma separated list. Anything before the tag is ignored.
// Additional proprietary key=value pairs can be propagated having a '+' as first character of 'key' in such an entry.
// Registernames(regname) and Fieldnames (fieldname) need to exactly match the string in corresponding IPXact.
// A first line must reference the ipxact file associated with this mapping
//      '<mtiphdlpath,+ipxact=nameofipxactfile.xml");
// Examples:
// must-have:
//      'anything...<mtiphdlpath,fullpath,module,reset,regname,fieldname,slice[,moreslices]'
// proprietary keys at end: 
//      'anything...<mtiphdlpath,fullpath,module,reset,regname,fieldname,slice1,+somekey=value[,moreslices]'

initial 
begin

        // 'regname' and 'fieldname' to match IPXact file
        $display("<mtiphdlpath,+ipxact=PCS_1000basex_sgmii.1.0.xml");

        $display("<mtiphdlpath,%m,sgpcs_mdio_np_reg, reset_clk, CONTROL, Reset          , mdio_control_15, +sw=rw, +hw=rw");
        $display("<mtiphdlpath,%m,sgpcs_mdio_np_reg, reset_clk, CONTROL, Loopback       , mdio_control_14, +sw=rw, +hw=rw");
        $display("<mtiphdlpath,%m,sgpcs_mdio_np_reg, reset_clk, CONTROL, Speed_13       , mdio_control_13, +sw=r,  +hw=r");
        $display("<mtiphdlpath,%m,sgpcs_mdio_np_reg, reset_clk, CONTROL, Anenable       , mdio_control_12, +sw=rw, +hw=rw");
        $display("<mtiphdlpath,%m,sgpcs_mdio_np_reg, reset_clk, CONTROL, Powerdown      , mdio_control_11, +sw=rw, +hw=rw");
        $display("<mtiphdlpath,%m,sgpcs_mdio_np_reg, reset_clk, CONTROL, Isolate        , mdio_control_10, +sw=rw, +hw=rw");
        $display("<mtiphdlpath,%m,sgpcs_mdio_np_reg, reset_clk, CONTROL, Anrestart      , mdio_control_9 , +sw=rw, +hw=rw");
        $display("<mtiphdlpath,%m,sgpcs_mdio_np_reg, reset_clk, CONTROL, Duplex         , mdio_control_8 , +sw=r,  +hw=r");
        $display("<mtiphdlpath,%m,sgpcs_mdio_np_reg, reset_clk, CONTROL, Speed_6        , mdio_control_6 , +sw=r,  +hw=r");

        $display("<mtiphdlpath,%m,sgpcs_mdio_np_reg, reset_clk, STATUS , Anegcomplete   , mdio_status5  , +sw=r, +hw=w");
        $display("<mtiphdlpath,%m,sgpcs_mdio_np_reg, reset_clk, STATUS , Anegability    , mdio_status[3], +sw=r, +hw=w");
        $display("<mtiphdlpath,%m,sgpcs_mdio_np_reg, reset_clk, STATUS , Linkstatus     , mdio_status2  , +sw=r, +hw=w, +onread=rset");
        $display("<mtiphdlpath,%m,sgpcs_mdio_np_reg, reset_clk, STATUS , Extdcapability , mdio_status[0], +sw=r, +hw=w");

        $display("<mtiphdlpath,%m,sgpcs_mdio_np_reg, reset_clk, PHY_ID_0, Phyid         , phy_identifier_w[15:0] , +sw=r, +hw=r");
        $display("<mtiphdlpath,%m,sgpcs_mdio_np_reg, reset_clk, PHY_ID_1, Phyid         , phy_identifier_w[31:16], +sw=r, +hw=r");

        $display("<mtiphdlpath,%m,sgpcs_mdio_np_reg, reset_clk, DEV_ABILITY, NP         , dev_ability[15], +sw=rw, +hw=rw");
        $display("<mtiphdlpath,%m,sgpcs_mdio_np_reg, reset_clk, DEV_ABILITY, Ack        , an_ack_reg2    , +sw=r,  +hw=r");   // dev_ability[14]
        $display("<mtiphdlpath,%m,sgpcs_mdio_np_reg, reset_clk, DEV_ABILITY, RF2        , dev_ability[13], +sw=rw, +hw=rw");
        $display("<mtiphdlpath,%m,sgpcs_mdio_np_reg, reset_clk, DEV_ABILITY, RF1        , dev_ability[12], +sw=rw, +hw=rw");
        $display("<mtiphdlpath,%m,sgpcs_mdio_np_reg, reset_clk, DEV_ABILITY,ability_rsv9, dev_ability[11:9], +sw=rw, +hw=rw");
        $display("<mtiphdlpath,%m,sgpcs_mdio_np_reg, reset_clk, DEV_ABILITY, PS2        , dev_ability[8] , +sw=rw, +hw=rw");
        $display("<mtiphdlpath,%m,sgpcs_mdio_np_reg, reset_clk, DEV_ABILITY, PS1        , dev_ability[7] , +sw=rw, +hw=rw");
        $display("<mtiphdlpath,%m,sgpcs_mdio_np_reg, reset_clk, DEV_ABILITY, HD         , dev_ability[6] , +sw=rw, +hw=rw");
        $display("<mtiphdlpath,%m,sgpcs_mdio_np_reg, reset_clk, DEV_ABILITY, FD         , dev_ability[5] , +sw=rw, +hw=rw");
        $display("<mtiphdlpath,%m,sgpcs_mdio_np_reg, reset_clk, DEV_ABILITY,ability_rsv05,dev_ability[4:0] , +sw=rw, +hw=rw");

        $display("<mtiphdlpath,%m,sgpcs_mdio_np_reg, reset_clk, PARTNER_ABILITY, NP             , partner_ability_reg2[15]      , +sw=r, +hw=r");
        $display("<mtiphdlpath,%m,sgpcs_mdio_np_reg, reset_clk, PARTNER_ABILITY, Ack            , partner_ability_reg2[14]      , +sw=r, +hw=r");
        $display("<mtiphdlpath,%m,sgpcs_mdio_np_reg, reset_clk, PARTNER_ABILITY, RF2            , partner_ability_reg2[13]      , +sw=r, +hw=r");
        $display("<mtiphdlpath,%m,sgpcs_mdio_np_reg, reset_clk, PARTNER_ABILITY, RF1            , partner_ability_reg2[12]      , +sw=r, +hw=r");
        $display("<mtiphdlpath,%m,sgpcs_mdio_np_reg, reset_clk, PARTNER_ABILITY, pability_rsv10 , partner_ability_reg2[11:10]   , +sw=r, +hw=r");
        $display("<mtiphdlpath,%m,sgpcs_mdio_np_reg, reset_clk, PARTNER_ABILITY, pability_rsv9  , partner_ability_reg2[9]       , +sw=r, +hw=r");
        $display("<mtiphdlpath,%m,sgpcs_mdio_np_reg, reset_clk, PARTNER_ABILITY, PS2            , partner_ability_reg2[8]       , +sw=r, +hw=r");
        $display("<mtiphdlpath,%m,sgpcs_mdio_np_reg, reset_clk, PARTNER_ABILITY, PS1            , partner_ability_reg2[7]       , +sw=r, +hw=r");
        $display("<mtiphdlpath,%m,sgpcs_mdio_np_reg, reset_clk, PARTNER_ABILITY, HD             , partner_ability_reg2[6]       , +sw=r, +hw=r");
        $display("<mtiphdlpath,%m,sgpcs_mdio_np_reg, reset_clk, PARTNER_ABILITY, FD             , partner_ability_reg2[5]       , +sw=r, +hw=r");
        $display("<mtiphdlpath,%m,sgpcs_mdio_np_reg, reset_clk, PARTNER_ABILITY, pability_rsv05 , partner_ability_reg2[4:0]     , +sw=r, +hw=r");

        $display("<mtiphdlpath,%m,sgpcs_mdio_np_reg, reset_clk, AN_EXPANSION    , Nextpageable   , an_expansion2        , +sw=r, +hw=r");
        $display("<mtiphdlpath,%m,sgpcs_mdio_np_reg, reset_clk, AN_EXPANSION    , Pagereceived   , an_expansion1        , +sw=r, +hw=r, +onread=rclr");
        $display("<mtiphdlpath,%m,sgpcs_mdio_np_reg, reset_clk, AN_EXPANSION    , Pagercvcurrent , an_expansion0        , +sw=r, +hw=r");

        $display("<mtiphdlpath,%m,sgpcs_mdio_np_reg, reset_clk, NP_TX, NP       , np_tx[15], +sw=rw, +hw=rw");
        $display("<mtiphdlpath,%m,sgpcs_mdio_np_reg, reset_clk, NP_TX, Ack      , np_tx[14], +sw=rw, +hw=rw");
        $display("<mtiphdlpath,%m,sgpcs_mdio_np_reg, reset_clk, NP_TX, MP       , np_tx[13], +sw=rw, +hw=rw");
        $display("<mtiphdlpath,%m,sgpcs_mdio_np_reg, reset_clk, NP_TX, Ack2     , np_tx[12], +sw=rw, +hw=rw");
        $display("<mtiphdlpath,%m,sgpcs_mdio_np_reg, reset_clk, NP_TX, Toggle   , np_tx[11], +sw=rw, +hw=rw");
        $display("<mtiphdlpath,%m,sgpcs_mdio_np_reg, reset_clk, NP_TX, Data     , np_tx[10:0] , +sw=rw, +hw=rw");

        $display("<mtiphdlpath,%m,sgpcs_mdio_np_reg, reset_clk, LP_NP_RX, NP       , lp_np_rx_reg2[15], +sw=r, +hw=r");
        $display("<mtiphdlpath,%m,sgpcs_mdio_np_reg, reset_clk, LP_NP_RX, Ack      , lp_np_rx_reg2[14], +sw=r, +hw=r");
        $display("<mtiphdlpath,%m,sgpcs_mdio_np_reg, reset_clk, LP_NP_RX, MP       , lp_np_rx_reg2[13], +sw=r, +hw=r");
        $display("<mtiphdlpath,%m,sgpcs_mdio_np_reg, reset_clk, LP_NP_RX, Ack2     , lp_np_rx_reg2[12], +sw=r, +hw=r");
        $display("<mtiphdlpath,%m,sgpcs_mdio_np_reg, reset_clk, LP_NP_RX, Toggle   , lp_np_rx_reg2[11], +sw=r, +hw=r");
        $display("<mtiphdlpath,%m,sgpcs_mdio_np_reg, reset_clk, LP_NP_RX, Data     , lp_np_rx_reg2[10:0] , +sw=r, +hw=r");

        $display("<mtiphdlpath,%m,sgpcs_mdio_np_reg, reset_clk, SCRATCH, Scratch, scratch_reg, +sw=rw, +hw=rw");

        $display("<mtiphdlpath,%m,sgpcs_mdio_np_reg, reset_clk, REV, Revision, DEV_VERSION, +sw=r, +hw=na");

        $display("<mtiphdlpath,%m,sgpcs_mdio_np_reg, reset_clk, LINK_TIMER_0, Timer15_1 , link_timer_reg_20_1[15:1], +sw=rw, +hw=rw");
        $display("<mtiphdlpath,%m,sgpcs_mdio_np_reg, reset_clk, LINK_TIMER_1, Timer20_16, link_timer_reg_20_1[20:16], +sw=rw, +hw=rw");

        $display("<mtiphdlpath,%m,sgpcs_mdio_np_reg, reset_clk, IF_MODE, Ifmode_seq_ena          , na, +sw=na, +ispresent=false");      // exists in xml, but not in this variant, hence remove from RDL output.
        $display("<mtiphdlpath,%m,sgpcs_mdio_np_reg, reset_clk, IF_MODE, Ifmode_mode_xgmii_basex , na, +sw=na, +ispresent=false");      // exists in xml, but not in this variant, hence remove from RDL output.
        $display("<mtiphdlpath,%m,sgpcs_mdio_np_reg, reset_clk, IF_MODE, Ifmode_rx_preamble_sync , na, +sw=na, +ispresent=false");      // exists in xml, but not in this variant, hence remove from RDL output.
        $display("<mtiphdlpath,%m,sgpcs_mdio_np_reg, reset_clk, IF_MODE, Ifmode_tx_preamble_sync , na, +sw=na, +ispresent=false");      // exists in xml, but not in this variant, hence remove from RDL output.

        $display("<mtiphdlpath,%m,sgpcs_mdio_np_reg, reset_clk, IF_MODE, Ifmode_rsv5    , if_mode[5], +sw=rw, +hw=rw");
        $display("<mtiphdlpath,%m,sgpcs_mdio_np_reg, reset_clk, IF_MODE, Sgmii_duplex   , if_mode[4], +sw=rw, +hw=rw");
        $display("<mtiphdlpath,%m,sgpcs_mdio_np_reg, reset_clk, IF_MODE, Sgmii_speed    , if_mode[3:2], +sw=rw, +hw=rw");
        $display("<mtiphdlpath,%m,sgpcs_mdio_np_reg, reset_clk, IF_MODE, Use_sgmii_an   , if_mode[1], +sw=rw, +hw=rw");
        $display("<mtiphdlpath,%m,sgpcs_mdio_np_reg, reset_clk, IF_MODE, Sgmii_ena      , if_mode[0], +sw=rw, +hw=rw");

        $display("<mtiphdlpath,%m,sgpcs_mdio_np_reg, reset_clk, DECODE_ERRORS, Decodeerrors , dec_err_cnt_reg2, +sw=r, +hw=r, +onread=rclr");

        $display("<mtiphdlpath,%m,sgpcs_mdio_np_reg, reset_clk, SGPCS_CONTROL, Sgpcs_enable_status, sgpcs_ena_st  , +sw=r, +hw=w");
        $display("<mtiphdlpath,%m,sgpcs_mdio_np_reg, reset_clk, SGPCS_CONTROL, Cfg_clock_rate     , cfg_clock_rate, +sw=rw, +hw=rw");
        $display("<mtiphdlpath,%m,sgpcs_mdio_np_reg, reset_clk, SGPCS_CONTROL, Sgpcs_enable       , sgpcs_ena_r   , +sw=rw, +hw=rw");

    `ifdef SGMII_BIT_SLIP_REG
        $display("<mtiphdlpath,%m,sgpcs_mdio_np_reg, reset_clk, SGPCS_BITSLIP, Bitslip, bit_slip_reg2  , +sw=r, +hw=w");
    `else
        $display("<mtiphdlpath,%m,sgpcs_mdio_np_reg, reset_clk, SGPCS_BITSLIP, Bitslip, bit_slip_reg2  , +sw=r, +hw=w, +ispresent=false");
    `endif
end
// synopsys translate_on
// synthesis translate_on
`endif


endmodule // module sgpcs_mdio_np_reg

