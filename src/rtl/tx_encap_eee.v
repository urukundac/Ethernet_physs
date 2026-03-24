
`include "common_header.verilog"

//  *************************************************************************
//  File : tx_encap_eee.v
//  *************************************************************************
//  This program is controlled by a written license agreement.
//  Unauthorized Reproduction or Use is Expressly Prohibited. 
//  Copyright (c) 2003-2007 MoreThanIP, Germany
//  Designed by : Francois Balay
//  fbalay@morethanip.com
//  *************************************************************************
//  Decription : Frame Encapsulation with Configuration Sequence
//  Version    : $Id: tx_encap_eee.v,v 1.1 2011/07/11 10:03:25 dk Exp $
//  *************************************************************************

module tx_encap_eee (

   reset,
   sw_reset,
   clk,
  `ifdef USE_CLK_ENA
   clk_ena,
  `endif       
   tx_ena,
   tx_idle,
   an_ability,
   an_ena,
   gmii_dv,
   gmii_ctl,
   gmii_data,
   gmii_tx_even,
   disparity,
   transmit,
   kchar,
   frame
   
   `ifdef MTIPPCS36_EEE_ENA
   ,
   tx_oset_li
   `endif
   
   );

parameter ENCAP127_SEQ = 0;     //  if 1 Encode Sequence ordered set from XGMII (Clause 127) which is encoded on GMII as (dv=0, er=1, data=0x9c)

input   reset;                  //  Active High Global Reset
input   sw_reset;               //  SW Asynchronous Reset           
input   clk;                    //  125MHz Common Clock
`ifdef USE_CLK_ENA
input   clk_ena;
`endif 
input   tx_ena;                 //  Enable Data Transmit - Autonegotiation Complete
input   tx_idle;                //  Enable Idle Transmit
input   [15:0] an_ability;      //  Autonegotiation Ability Register          
input   an_ena;                 //  Enable Autonegotiation
input   gmii_dv;                //  Data Valid
input   gmii_ctl;               //  Data Control
input   [7:0] gmii_data;        //  Data
output  gmii_tx_even;           //  Statemachine in tx_even state sampling GMII (frame0 start sampled only if tx_even=0)
input   disparity;              //  Current Disparity
output  transmit;               //  Frame Transmission Active
output  kchar;                  //  Special Character Indication
output  [7:0] frame;            //  Frame
`ifdef MTIPPCS36_EEE_ENA
output  tx_oset_li;             // transmitting LPI (stable, clk_ena independent)
wire    tx_oset_li;
reg     tx_oset_li_int;         //  indicate statemachine transmitting LPI
`endif

// out wires

wire    gmii_tx_even;
reg     transmit; 
reg     kchar; 
reg     [7:0] frame0;
reg     [7:0] frame;

parameter STM_TYP_IDLE = 4'h0;
parameter STM_TYP_FRM_START = 4'h1;
parameter STM_TYP_FRM = 4'h2;
parameter STM_TYP_FRM_END = 4'h3;
parameter STM_TYP_FRM_END2 = 4'h4;
parameter STM_TYP_FRM_START_ERR = 4'h5;
parameter STM_TYP_FRM_DATA_ERR = 4'h6;
parameter STM_TYP_FRM_END3 = 4'h7;
parameter STM_TYP_CF_C1A = 4'h8;
parameter STM_TYP_CF_C1B = 4'h9;
parameter STM_TYP_CF_C1C = 4'hA;
parameter STM_TYP_CF_C1D = 4'hB;
parameter STM_TYP_CF_C2A = 4'hC;
parameter STM_TYP_CF_C2B = 4'hD;
parameter STM_TYP_CF_C2C = 4'hE;
parameter STM_TYP_CF_C2D = 4'hF;

reg     [3:0] state; 
reg     [3:0] nextstate; 

reg     tx_even_int; 
reg     tx_oset_seq;            //  Sequence ordered set pair arrives, send data (802.3cb, Clause 127)

//  Domain Synchronization
//  ----------------------
wire [7:0] frame0;
wire   sw_reset_reg2;
wire   tx_ena_reg2;
wire   tx_idle_reg2;
wire   an_ena_reg2;
wire   [15:0] an_ability_reg2;
//wire [7:0] frame
mtip_xsync #(20) U_SYNC (

   .data_in({sw_reset, tx_ena, tx_idle, an_ena, an_ability}),
   .reset(reset),
   .clk(clk),
   .data_s({sw_reset_reg2, tx_ena_reg2, tx_idle_reg2, an_ena_reg2, an_ability_reg2}));

always @(posedge reset or posedge clk)
   begin : process_1
   if (reset == 1'b 1)
      begin
      state <= STM_TYP_IDLE;	
      end
   else
      begin
      if (sw_reset_reg2 == 1'b 1)
         begin
         state <= STM_TYP_IDLE;	
         end
     `ifdef USE_CLK_ENA
      else if(clk_ena == 1'b 1)
     `else
      else
     `endif
         begin
         state <= nextstate;
         frame <= gmii_data;   
         end
      end
   end

always @(state or gmii_dv or gmii_ctl or tx_even_int or an_ena_reg2 or tx_ena_reg2 or tx_idle_reg2)
   begin : process_2
   case (state)
   STM_TYP_IDLE:
      begin

   //  Autonegotiation Enabled / Restarted
   //  -----------------------------------
   
      if (an_ena_reg2 == 1'b 1 & tx_idle_reg2 == 1'b 0 & tx_even_int == 1'b 0 & tx_ena_reg2 == 1'b 0)
         begin
         nextstate = STM_TYP_CF_C1A;	

   //  Start of Frame without Error
   //  ----------------------------
   
         end
      else if (gmii_dv == 1'b 1 & gmii_ctl == 1'b 0 & tx_even_int == 1'b 0 & tx_ena_reg2 == 1'b 1 )
         begin
         nextstate = STM_TYP_FRM_START;	

   //  Start of Frame with Error
   //  -------------------------
   
         end
      else if (gmii_dv == 1'b 1 & gmii_ctl == 1'b 1 & tx_even_int == 1'b 1 & tx_ena_reg2 == 1'b 1 )
         begin
         nextstate = STM_TYP_FRM_START_ERR;	
         end
      else
         begin
         nextstate = STM_TYP_IDLE;	
         end

   //  Start of Frame with Error
   //  -------------------------
   
      end
   STM_TYP_FRM_START_ERR:
      begin
      nextstate = STM_TYP_FRM_DATA_ERR;	
      end
   STM_TYP_FRM_DATA_ERR:
      begin
      nextstate = STM_TYP_FRM;	

   //  Start of Frame without Error
   //  ----------------------------
   
      end
   STM_TYP_FRM_START:
      begin
      nextstate = STM_TYP_FRM;	
      end
   STM_TYP_FRM:
      begin

   //  End of Frame without Extended Carrier
   //  -------------------------------------
   
      if ((gmii_dv == 1'b 0 & gmii_ctl == 1'b 0) | tx_ena_reg2 == 1'b 0)
         begin
         nextstate = STM_TYP_FRM_END;	
         end
      else
         begin
         nextstate = STM_TYP_FRM;	
         end
      end
   STM_TYP_FRM_END:
      begin
      nextstate = STM_TYP_FRM_END2;	
      end
   STM_TYP_FRM_END2:
      begin

   //  Odd Number of Bytes Transmitted
   //  -------------------------------
   
      if (tx_even_int == 1'b 1)
         begin
         nextstate = STM_TYP_FRM_END3;	
         end
      else
         begin
         nextstate = STM_TYP_IDLE;	
         end
      end
   STM_TYP_FRM_END3:
      begin
      nextstate = STM_TYP_IDLE;	

   //  Configuration Sequence when Autonegiation Enabled / Requested - Send /C1/ Orderset
   //  ----------------------------------------------------------------------------------
   
      end
   STM_TYP_CF_C1A:
      begin
      nextstate = STM_TYP_CF_C1B;	
      end
   STM_TYP_CF_C1B:
      begin
      nextstate = STM_TYP_CF_C1C;	
      end
   STM_TYP_CF_C1C:
      begin
      nextstate = STM_TYP_CF_C1D;	
      end
   STM_TYP_CF_C1D:
      begin

   //  Autonegotiation not Done Send /C2/ Orderset
   //  -------------------------------------------
   
      if (tx_ena_reg2 == 1'b 0 & tx_idle_reg2 == 1'b 0)
         begin
         nextstate = STM_TYP_CF_C2A;	
         end
      else if (gmii_dv == 1'b 1 & gmii_ctl == 1'b 0 & tx_even_int == 1'b 0 & tx_ena_reg2 == 1'b 1)
         begin
         nextstate = STM_TYP_FRM_START;	
         end
      else if (gmii_dv == 1'b 1 & gmii_ctl == 1'b 1 & tx_even_int == 1'b 1 & tx_ena_reg2 == 1'b 1)            // 271005
         begin
         nextstate = STM_TYP_FRM_START_ERR;	
         end
      else
         begin
         nextstate = STM_TYP_IDLE;	
         end
      end
   STM_TYP_CF_C2A:
      begin
      nextstate = STM_TYP_CF_C2B;	
      end
   STM_TYP_CF_C2B:
      begin
      nextstate = STM_TYP_CF_C2C;	
      end
   STM_TYP_CF_C2C:
      begin
      nextstate = STM_TYP_CF_C2D;	
      end
   STM_TYP_CF_C2D:
      begin

   //  Autonegotiation not Done Send /C1/ Orderset
   //  -------------------------------------------
   
      if (tx_ena_reg2 == 1'b 0 & tx_idle_reg2 == 1'b 0)
         begin
         nextstate = STM_TYP_CF_C1A;	
         end
      else if (gmii_dv == 1'b 1 & gmii_ctl == 1'b 0 & tx_even_int == 1'b 0 & tx_ena_reg2 == 1'b 1)            // 271005
         begin
         nextstate = STM_TYP_FRM_START;	
         end
      else if (gmii_dv == 1'b 1 & gmii_ctl == 1'b 1 & tx_even_int == 1'b 1 & tx_ena_reg2 == 1'b 1)
         begin
         nextstate = STM_TYP_FRM_START_ERR;	
         end
      else
         begin
         nextstate = STM_TYP_IDLE;	
         end
      end

   default:     // never reached
         begin
         nextstate = STM_TYP_IDLE;	
         end

   endcase
   end

//  Frame Encapsulation
//  ------------------- 

always @(posedge reset or posedge clk)
   begin : process_3
   if (reset == 1'b 1)
      begin
      frame0 <= 8'h BC;	
      kchar <= 1'b 1;	
      end
   else
      begin
      if (sw_reset_reg2 == 1'b 1)
         begin
         frame0 <= 8'h BC;	
         kchar <= 1'b 1;	

   //  Start of Packet: First Preamble Byte Replaced by K27.7
   //  ------------------------------------------------------
   
         end
     `ifdef USE_CLK_ENA
      else if(clk_ena == 1'b 1)
     `else
      else
     `endif
         begin
         if (nextstate == STM_TYP_FRM_START)
            begin
            frame0 <= 8'h FB;	
            kchar <= 1'b 1;	

   //  End of Packet: K29.7 Added after Last CRC Byte
   //  ----------------------------------------------
   
            end
         else if (nextstate == STM_TYP_FRM_END )
            begin
            frame0 <= 8'h FD;	
            kchar <= 1'b 1;	
   
   //  End of Packet: K23.7 Added after K29.7
   //  --------------------------------------
   
            end
         else if (nextstate == STM_TYP_FRM_END2 )
            begin
            frame0 <= 8'h F7;	
            kchar <= 1'b 1;	
   
   //  End of Packet: Second K23.7 if Even Number of Character
   //  -------------------------------------------------------
   
            end
         else if (nextstate == STM_TYP_FRM_END3 )
            begin
            frame0 <= 8'h F7;	
            kchar <= 1'b 1;	
   
   //  Error: Frame Start with Error
   //  -----------------------------
   
            end
         else if (nextstate == STM_TYP_FRM_START_ERR )
            begin
            frame0 <= 8'h F7;	
            kchar <= 1'b 1;	
            end
         else if (nextstate == STM_TYP_FRM_DATA_ERR )
            begin
            frame0 <= 8'h FE;	
            kchar <= 1'b 1;	

   //  Error: K30.7 Added
   //  ------------------
   
            end
         else if (nextstate == STM_TYP_FRM & gmii_ctl == 1'b 1 )
            begin
            frame0 <= 8'h FE;	
            kchar <= 1'b 1;	
            end
         else if (nextstate == STM_TYP_FRM )
            begin
            frame0 <= gmii_data;	
            kchar <= 1'b 0;	

   //  Send Configuration /C1/ Orderset
   //  --------------------------------
   
            end
         else if (nextstate == STM_TYP_CF_C1A )
            begin
            frame0 <= 8'h BC;	
            kchar <= 1'b 1;	
            end
         else if (nextstate == STM_TYP_CF_C1B )
            begin
            frame0 <= 8'h B5;	//  D21.5
            kchar <= 1'b 0;	
            end
         else if (nextstate == STM_TYP_CF_C1C )
            begin
            frame0 <= an_ability_reg2[7:0];	
            kchar <= 1'b 0;	
            end
         else if (nextstate == STM_TYP_CF_C1D )
            begin
            frame0 <= an_ability_reg2[15:8];	
            kchar <= 1'b 0;	

   //  Send Configuration /C2/ Orderset
   //  --------------------------------
   
            end
         else if (nextstate == STM_TYP_CF_C2A )
            begin
            frame0 <= 8'h BC;	
            kchar <= 1'b 1;	
            end
         else if (nextstate == STM_TYP_CF_C2B )
            begin
            frame0 <= 8'h 42;	//  D2.2
            kchar <= 1'b 0;	
            end
         else if (nextstate == STM_TYP_CF_C2C )
            begin
            frame0 <= an_ability_reg2[7:0];	
            kchar <= 1'b 0;	
            end
         else if (nextstate == STM_TYP_CF_C2D )
            begin
            frame0 <= an_ability_reg2[15:8];	
            kchar <= 1'b 0;	

   //  Idle: K28.5
   //  -----------
   
            end
         else if (nextstate == STM_TYP_IDLE & state != STM_TYP_IDLE )
            begin
            frame0 <= 8'h BC;	//  K28.5
            kchar <= 1'b 1;	
            end
         else if (nextstate == STM_TYP_IDLE & tx_even_int == 1'b 1 & tx_oset_seq == 1'b 1 )
            begin
            kchar <= 1'b 0;     
            frame0 <= gmii_data; // Sequence ordered set byte (no disparity correction)
            end
         else if (nextstate == STM_TYP_IDLE & tx_even_int == 1'b 1 & disparity == 1'b 0 )
            begin

            kchar <= 1'b 0;	

            `ifdef MTIPPCS36_EEE_ENA
            if (tx_oset_li_int == 1'b 1)
               begin
               frame0 <= 8'h 9A;	//  D26.4     (LPI)
               end
            else
            `endif
               frame0 <= 8'h 50;	//  D16.2

            end
         else if (nextstate == STM_TYP_IDLE & tx_even_int == 1'b 1 & disparity == 1'b 1 )
            begin

   //  Disparity Correction
   //  --------------------------
            
            kchar <= 1'b 0;	

            `ifdef MTIPPCS36_EEE_ENA
            if (tx_oset_li_int == 1'b 1)
               begin
               frame0 <= 8'h A6;	//  D6.5       (LPI)
               end
            else
            `endif
               frame0 <= 8'h C5;	//  D5.6

            end
         else
            begin
            frame0 <= 8'h BC;	
            kchar <= 1'b 1;	
            end
         end
      end
   end

always @(posedge reset or posedge clk)
   begin : process_4
   if (reset == 1'b 1)
      begin
      tx_even_int <= 1'b 1;	
      end
   else
      begin
      if (sw_reset_reg2 == 1'b 1)
         begin
         tx_even_int <= 1'b 1;	
         end
     `ifdef USE_CLK_ENA
      else if(clk_ena == 1'b 1)
     `else
      else
     `endif
         begin
         if (nextstate == STM_TYP_CF_C1A)
            begin
            tx_even_int <= 1'b 1;	
            end
         else if (nextstate == STM_TYP_IDLE & state != STM_TYP_IDLE )
            begin
            tx_even_int <= 1'b 1;	
            end
         else
            begin
            tx_even_int <= ~tx_even_int;	
            end
         end
      end
   end

assign gmii_tx_even = tx_even_int;   // aligned with GMII input: Start sampling occurs when tx_even=0


always @(posedge reset or posedge clk)
   begin : process_5
   if (reset == 1'b 1)
      begin
      transmit <= 1'b 0;	
      end
   else
      begin
      if (sw_reset_reg2 == 1'b 1)
         begin
         transmit <= 1'b 0;	
         end
     `ifdef USE_CLK_ENA
      else if(clk_ena == 1'b 1)
     `else
      else
     `endif
         begin
         if (nextstate == STM_TYP_FRM_START)
            begin
            transmit <= 1'b 1;	
            end
         else if (nextstate == STM_TYP_FRM_END )
            begin
            transmit <= 1'b 0;	
            end
         end
      end
   end

//  ----------------------------------------------------
//  EEE & Low Power Idle handling
//  Treat the IDLE state identically to LPI.
//  ----------------------------------------------------

`ifdef MTIPPCS36_EEE_ENA

assign tx_oset_li = tx_oset_li_int; 

always @(posedge reset or posedge clk)
   begin : process_7
   if (reset == 1'b 1)
      begin
      tx_oset_li_int <= 1'b 0;	
      end
   else
      begin
      if (sw_reset_reg2 == 1'b 1)
         begin
         tx_oset_li_int <= 1'b 0;	
         end
      else
     `ifdef USE_CLK_ENA
      if(clk_ena == 1'b 1)
     `endif
         begin

         if (nextstate == STM_TYP_IDLE & gmii_dv == 1'b 0 & gmii_ctl == 1'b 1 & gmii_data == 8'h 01)
            begin
            tx_oset_li_int <= 1'b 1;	
            end
         else
            begin
            tx_oset_li_int <= 1'b 0;	
            end

         end

      end
   end

`endif

//  ----------------------------------------------------
//  Encode Sequence ordered set from XGMII (Clause 127)
//  It is encoded on GMII as (dv=0, er=1, data=0x9c) during
//  even state then followed by a data.
//  ----------------------------------------------------

always @(posedge reset or posedge clk)
   begin : process_8
   if (reset == 1'b 1)
      begin
      tx_oset_seq <= 1'b 0;
      end
   else
      begin
      if (sw_reset == 1'b 1)
         begin
         tx_oset_seq <= 1'b 0;
         end
      else
      if(clk_ena == 1'b 1)
         begin

                // Sequence ordered set must always occur in sync with tx_even as the Control
                // must coincide with the K28.5 transmission and only the /D/ of the pair is different.
                // Input will toggle (dv=0,er=1,9c (K28.5) -> dv=1,er=0,Sx (Data) -> dv=0,er=1,9c (K28.5) -> ...

         if (nextstate == STM_TYP_IDLE && gmii_dv == 1'b 0 && gmii_ctl == 1'b 1 && gmii_data == 8'h 9c && ENCAP127_SEQ==1)
            begin
            tx_oset_seq <= 1'b 1;
            end
         else
            begin
            tx_oset_seq <= 1'b 0;
            end

         end

      end
   end
   
endmodule // module tx_encap_eee
