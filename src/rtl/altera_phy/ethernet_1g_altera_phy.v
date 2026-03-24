//-----------------------------------------------------------------------------
//
//  INTEL CONFIDENTIAL
//
//  Copyright 2018 Intel Corporation All Rights Reserved.
//
//  The source code contained or described herein and all documents related
//  to the source code ("Material") are owned by Intel Corporation or its
//  suppliers or licensors. Title to the Material remains with Intel
//  Corporation or its suppliers and licensors. The Material contains trade
//  secrets and proprietary and confidential information of Intel or its
//  suppliers and licensors. The Material is protected by worldwide copyright
//  and trade secret laws and treaty provisions. No part of the Material may
//  be used, copied, reproduced, modified, published, uploaded, posted,
//  transmitted, distributed, or disclosed in any way without Intel's prior
//  express written permission.
//
//  No license under any patent, copyright, trade secret or other intellectual
//  property right is granted to or conferred upon you by disclosure or
//  delivery of the Materials, either expressly, by implication, inducement,
//  estoppel or otherwise. Any license under such intellectual property rights
//  must be express and approved by Intel in writing.
//
//------------------------------------------------------------------------------
//---------------------------------------------------------------
//                    Intel Proprietary
//              Copyright (C) 2018 Intel Corporation
//                  All Rights Reserved
//---------------------------------------------------------------
//-----------------------------------------------------------------------------------------------------
// Version and Release Control Information:
//
// File Name:     ethernet_1g_xlgmii_phy.v
// Created by:    Dhanabal Shanmugam
//-----------------------------------------------------------------------------------------------------
// Modules: MTIP: 1G PCS, Altera IPs: 1250Mbps SerDes, fPLL, DC FIFO, SerDes Reset Controller 
//-----------------------------------------------------------------------------------------------------

`timescale 1 ns / 1 ps
  
module ethernet_1g_altera_phy (

   pcs_ref_clk_125mhz,
   xcvr_125mhz_refclk,
   xcvr_reset,
   xcvr_tx_serial_clk0,
   fpll_locked_SGMII,
      
 
   serdes_fpga_serial_loopback_ena,  // later tie this line to a register
// interface to pcs
   xcvr_rx_clk_o,
   xcvr_tbi_rx_gmii,
   xcvr_tbi_tx_gmii,

// altera serdes ports  
   xcvr_rx_serial_data,          // SGMII_PHY_S10 from board    
   xcvr_tx_serial_data           // SGMIIS_S10_PHY from board   
  
   );

  input   pcs_ref_clk_125mhz;
  input   xcvr_125mhz_refclk;     // 125MHz onboard osc reference clock input
  input   xcvr_reset;             // SerDes Reset input

  input   xcvr_tx_serial_clk0;    
  input   fpll_locked_SGMII;             

  input   serdes_fpga_serial_loopback_ena;   // S10 SerDes seril loopback enabled option for connectivity testing
 /// PCS interface signals 

  output xcvr_rx_clk_o;
  output [9:0] xcvr_tbi_rx_gmii;
  input [9:0] xcvr_tbi_tx_gmii;

 
// altera serdes ports 
  input      xcvr_rx_serial_data;         //  rx_serial_data.rx_serial_data
  output  xcvr_tx_serial_data;         //  tx_serial_data.tx_serial_data
  
  logic   xcvr_rx_analogreset;          //  rx_analogreset.rx_analogreset
  logic   xcvr_rx_digitalreset;         //  rx_digitalreset.rx_digitalreset
  logic   xcvr_tx_analogreset;          //  tx_analogreset.tx_analogreset
  logic   xcvr_tx_digitalreset;         //  tx_digitalreset.tx_digitalreset
  logic   xcvr_rx_digitalreset_stat;
  logic   xcvr_tx_digitalreset_stat;
  logic   xcvr_tx_analogreset_stat;
  logic   xcvr_rx_analogreset_stat;
  logic   xcvr_rx_cal_busy;
  logic   xcvr_tx_cal_busy;
  logic   xcvr_rx_is_lockedtodata;
  logic   xcvr_rx_is_lockedtoref;  
  logic   xcvr_rx_ready;
  logic   xcvr_tx_ready;
  
  logic   xcvr_tx_clk;                  //  transmit datapath clock
  logic   xcvr_rx_clk;                  //  receive datapath clock


  logic   [9:0]  xcvr_tbi_rx; 
  logic   [9:0]  xcvr_tbi_rx_reg; 
  logic   [9:0]  xcvr_tbi_tx; 
  logic   [9:0]  xcvr_tbi_tx_fifo_out;

  logic   [7:0]  xcvr_par_rx_8b; 
  logic   [7:0]  xcvr_par_tx_8b; 
  logic   xcvr_rx_datak;
  logic   xcvr_tx_datak;

  logic   [7:0]  xcvr_par_rx_8b_reg; 
  logic   xcvr_rx_datak_reg;  


  logic   [7:0]  xcvr_rx_parallel_data; 
  logic   [7:0]  xcvr_tx_parallel_data; 

  logic   signalTap_4xclk,  xcvr_tx_cal_busy_d, serdes_fifo_wrreq, serdes_fifo_rdreq, serdes_fifo_wr_wrfull, serdes_fifo_rdempty;    
  
  logic   xcvr_sg_rx_sync;           // rx link synchronization indication (i.e. comma characters are received)
    reg [9:0] xcvr_tbi_rx_gmii;
  reg [9:0] xcvr_tbi_tx_gmii; 

  logic   [63:0] demux_in_xlgmii_rxd;
  logic   [7:0] demux_in_xlgmii_rxc;
  logic   [63:0] mux_out_xlgmii_txd;
  logic   [7:0] mux_out_xlgmii_txc;

  logic   [71:0] async_fifo_xlgmii_rx_bus;
  logic   [71:0] async_fifo_xlgmii_tx_bus;
   
  logic    async_fifo_wrreq;
  logic    async_fifo_rdreq, prefetch_disable;
  logic    async_fifo_wr_wrfull;
  logic    async_fifo_rdempty;

  logic    async_fifo_rdreq_d1, async_fifo_rdreq_d2;

  logic    mux_out_xcvr_rx_serial_data;
  logic    loopback_xcvr_rx_serial_data;
  logic    mux_in_xcvr_tx_serial_data;

 
//  assign  xcvr_tx_clk_o =  xcvr_tx_clk;  
  assign  xcvr_tx_clk_o =  pcs_ref_clk_125mhz;   // using common clock for both tx/rx  
  assign  xcvr_rx_clk_o =  pcs_ref_clk_125mhz;
        
 
   
   
//  always@(*) 
//  
//  begin
//     if(xlgmii_fpga_loopback_ena) begin 
//     
//      async_fifo_xlgmii_rx_bus = {demux_in_xlgmii_rxc, demux_in_xlgmii_rxd};
//      mux_out_xlgmii_txc   = async_fifo_xlgmii_tx_bus[71:64]; 
//      mux_out_xlgmii_txd   = async_fifo_xlgmii_tx_bus[63:0]; 
//      xlgmii_rxc = 0;  // tie 10G MAC input to 0 during internal loopback mode
//      xlgmii_rxd = 0;  // tie 10G MAC input to 0 during internal loopback mode
//      
//     end else begin 
//      xlgmii_rxc = demux_in_xlgmii_rxc;
//      xlgmii_rxd = demux_in_xlgmii_rxd;
//      mux_out_xlgmii_txc   = xlgmii_txc; 
//      mux_out_xlgmii_txd   = xlgmii_txd;           
//          
//     end
//  end
//

////////////////////////////////////////////////////////////////

    always_ff@(posedge pcs_ref_clk_125mhz or posedge xcvr_reset) begin
        if( xcvr_reset ) begin
          xcvr_tbi_rx_reg   <= '0 ;

        end
        else begin 
          xcvr_tbi_rx_reg  <= xcvr_tbi_rx ;
        end
      end  
      
     
///////////////////////////////////////////////////////////////////


//////////////// temp.....
    always_ff@(posedge signalTap_4xclk) begin
          xcvr_tx_cal_busy_d   <= xcvr_tx_cal_busy ;
      end  
///////////////////////// ..temp/////////////////////


/////////////////////////////////////////////////////// SerDes TBI FIFO based aync loopback.... ////////////////////////
  always@(*) 
    begin
  
     if(serdes_fpga_serial_loopback_ena) begin 
      //xcvr_tbi_tx = xcvr_tbi_rx_reg;     
     xcvr_tbi_tx   = xcvr_tbi_tx_fifo_out;
     xcvr_tbi_rx_gmii = 0;   // tie 1G PHY inputs to 0
     
     end else begin 
      xcvr_tbi_tx  = xcvr_tbi_tx_gmii; 
      xcvr_tbi_rx_gmii = xcvr_tbi_rx;
        
     end
  end

assign serdes_fifo_wrreq = serdes_fpga_serial_loopback_ena  & (~serdes_fifo_wr_wrfull);
assign serdes_fifo_rdreq = serdes_fpga_serial_loopback_ena  & (~serdes_fifo_rdempty);


  serdes_tbi_loopback_fifo u_serdes_tbi_loopback_fifo (
        .data    (xcvr_tbi_rx),    //   input,  width = 10,  fifo_input.datain
        .wrreq   (serdes_fifo_wrreq),   //   input,   width = 1,            .wrreq
        .rdreq   (serdes_fifo_rdreq),   //   input,   width = 1,            .rdreq
        .wrclk   (pcs_ref_clk_125mhz),   //   input,   width = 1,            .wrclk
//        .rdclk   (xcvr_tx_clk),   //   input,   width = 1,            .rdclk
        .rdclk   (pcs_ref_clk_125mhz),   //   input,   width = 1,            .rdclk    // common tx/rx clock
        .q       (xcvr_tbi_tx_fifo_out),       //  output,  width = 10, fifo_output.dataout
        .rdempty (serdes_fifo_rdempty), //  output,   width = 1,            .rdempty
        .wrfull  (serdes_fifo_wr_wrfull)   //  output,   width = 1,            .wrfull
    );
    
//////////////////////////////////////////////////////////////////////////////////

  s10_xcvr_phy_reset_controller   u_xcvr_rst_cntrlr_tx (
       /*  input  wire       */   .clock                  (xcvr_125mhz_refclk)
       /*  input  wire [0:0] */  ,.pll_locked             (fpll_locked_SGMII)
       /*  input  wire [0:0] */  ,.pll_select             ( 1'b0 )
       /*  input  wire       */  ,.reset                  (xcvr_reset)
       /*  output wire [0:0] */  ,.rx_analogreset         (xcvr_rx_analogreset)       
       /*  input  wire [0:0] */  ,.rx_analogreset_stat    (xcvr_rx_analogreset_stat)  
       /*  input  wire [0:0] */  ,.rx_cal_busy            (xcvr_rx_cal_busy)          
       /*  output wire [0:0] */  ,.rx_digitalreset        (xcvr_rx_digitalreset)      
       /*  input  wire [0:0] */  ,.rx_digitalreset_stat   (xcvr_rx_digitalreset_stat) 
       /*  input  wire [0:0] */  ,.rx_is_lockedtodata     (xcvr_rx_is_lockedtodata)
       /*  output wire [0:0] */  ,.rx_ready               (xcvr_rx_ready)
       /*  output wire [0:0] */  ,.tx_analogreset         (xcvr_tx_analogreset)
       /*  input  wire [0:0] */  ,.tx_analogreset_stat    (xcvr_tx_analogreset_stat)
       /*  input  wire [0:0] */  ,.tx_cal_busy            (xcvr_tx_cal_busy_d)
       /*  output wire [0:0] */  ,.tx_digitalreset        (xcvr_tx_digitalreset)
       /*  input  wire [0:0] */  ,.tx_digitalreset_stat   (xcvr_tx_digitalreset_stat)
       /*  output wire [0:0] */  ,.tx_ready               (xcvr_tx_ready)
      );
  
  
// "Stratix 10 L-Tile/H-Tile Transceiver Native PHY"
// Parameters used:
// - Transceiver configuration: Basic/Custom(Standard PCS), Type:GX, Mode:Duplex, Num of Data Chs:1
// - Enable simplified data interface
// - Enable rx_is_lockedtodata port
// - Enable rx_is_lockedtoref port 
// - Tx PLL reference clock freuency 125MHz
// - Data rate selected = 1250Mbps
// - tx_clkout2, rx_clkout2 are disabled
// - tx_clkout, rx_clkout clock sources are PCS clkout (PCS clkout is the low speed parallel clock recovered by the transceiver RX PMA, that clocks the blocks in the RX PCS. The frequency of this clock is equal to datarate divided by PCS/PMA interface width)
// - rx_cdr_refclk0 --> 125 MHz input reference clock source for the PHY's TX PLL and RX CDR
// - rx_coreclkin, tx_coreclkin --> Select 'Dedicated Clock' if the rx_coreclkin input port is being driven by either tx/rx_clkout or tx/rx_clkout2 from the transceiver channel
// - rx PCS-Core Interface FIFO Mode  --> Phase Compensation mode
// - check rx_coreclkin to be shorted with rx_clkout? 
// - check tx_coreclkin to be shorted with tx_clkout?
// - tx_serial_clk0 -->  High-speed serial clock generated by TX PLL. Frequency of this clock depends on the datarate and clock division factor.
// - tx_serial_clk0 --> Connect to fpll_refclk output which supposed to be equal to 10x(125Mhz PLL reference input).
// - TX PLL selected = ATX or fPLL. PLL Ref Clk frequency = 125MHz(set_cdr_refclk_freq, tx_pll_refclk). The external TX PLL IP must be configured with an output clock frequency of 625MHz(cdr_pll_out_freq). Its equal to Data rate/2



  s10_serdes_Ltile_with8b10b_tbi_eth u_s10_serdes_Ltile_wo8b10b_tbi (
      .tx_analogreset          (xcvr_tx_analogreset),          //   input,   width = 1,          tx_analogreset.tx_analogreset
      .rx_analogreset          (xcvr_rx_analogreset),          //   input,   width = 1,          rx_analogreset.rx_analogreset
      .tx_digitalreset         (xcvr_tx_digitalreset),         //   input,   width = 1,         tx_digitalreset.tx_digitalreset
      .rx_digitalreset         (xcvr_rx_digitalreset),         //   input,   width = 1,         rx_digitalreset.rx_digitalreset
      .tx_analogreset_stat     (xcvr_tx_analogreset_stat),     //  output,   width = 1,     tx_analogreset_stat.tx_analogreset_stat
      .rx_analogreset_stat     (xcvr_rx_analogreset_stat),     //  output,   width = 1,     rx_analogreset_stat.rx_analogreset_stat
      .tx_digitalreset_stat    (xcvr_tx_digitalreset_stat),    //  output,   width = 1,    tx_digitalreset_stat.tx_digitalreset_stat
      .rx_digitalreset_stat    (xcvr_rx_digitalreset_stat),    //  output,   width = 1,    rx_digitalreset_stat.rx_digitalreset_stat
      .tx_cal_busy             (xcvr_tx_cal_busy),             //  output,   width = 1,             tx_cal_busy.tx_cal_busy
      .rx_cal_busy             (xcvr_rx_cal_busy),             //  output,   width = 1,             rx_cal_busy.rx_cal_busy
      .tx_serial_clk0          (xcvr_tx_serial_clk0),          //   input,   width = 1,          tx_serial_clk0.clk
      .rx_cdr_refclk0          (xcvr_125mhz_refclk),          //   input,   width = 1,          rx_cdr_refclk0.clk
      .tx_serial_data          (xcvr_tx_serial_data),          //  output,   width = 1,          tx_serial_data.tx_serial_data
      .rx_serial_data          (xcvr_rx_serial_data),          //   input,   width = 1,          rx_serial_data.rx_serial_data
      .rx_is_lockedtoref       (xcvr_rx_is_lockedtoref),       //  output,   width = 1,       rx_is_lockedtoref.rx_is_lockedtoref
      .rx_is_lockedtodata      (xcvr_rx_is_lockedtodata),      //  output,   width = 1,      rx_is_lockedtodata.rx_is_lockedtodata
//      .tx_coreclkin            (xcvr_tx_clk),            //   input,   width = 1,            tx_coreclkin.clk    // using common clock
      .tx_coreclkin            (pcs_ref_clk_125mhz),            //   input,   width = 1,            tx_coreclkin.clk
      .rx_coreclkin            (pcs_ref_clk_125mhz),            //   input,   width = 1,            rx_coreclkin.clk
      .tx_clkout               (xcvr_tx_clk),               //  output,   width = 1,               tx_clkout.clk
      .rx_clkout               (xcvr_rx_clk),               //  output,   width = 1,               rx_clkout.clk
      .tx_parallel_data        (xcvr_par_tx_8b),        //   input,   width = 8,        tx_parallel_data.tx_parallel_data
      .tx_datak                (xcvr_tx_datak),                //   input,   width = 1,                tx_datak.tx_datak
      .unused_tx_parallel_data (), //   input,  width = 71, unused_tx_parallel_data.unused_tx_parallel_data
      .rx_parallel_data        (xcvr_par_rx_8b),        //  output,   width = 8,        rx_parallel_data.rx_parallel_data
      .rx_datak                (xcvr_rx_datak),                //  output,   width = 1,                rx_datak.rx_datak
      .rx_syncstatus           (),           //  output,   width = 1,           rx_syncstatus.rx_syncstatus
      .rx_errdetect            (),            //  output,   width = 1,            rx_errdetect.rx_errdetect
      .rx_disperr              (),              //  output,   width = 1,              rx_disperr.rx_disperr
      .rx_runningdisp          (),          //  output,   width = 1,          rx_runningdisp.rx_runningdisp
      .rx_patterndetect        (),        //  output,   width = 1,        rx_patterndetect.rx_patterndetect
      .rx_rmfifostatus         (),         //  output,   width = 2,         rx_rmfifostatus.rx_rmfifostatus
      .unused_rx_parallel_data ()  //  output,  width = 64, unused_rx_parallel_data.unused_rx_parallel_data
    );

  assign xcvr_tbi_rx = { 1'b0, xcvr_rx_datak, xcvr_par_rx_8b };
  assign xcvr_par_tx_8b = xcvr_tbi_tx[7:0];
  assign xcvr_tx_datak = xcvr_tbi_tx[8];  
assign  xcvr_rx_clk_o =  pcs_ref_clk_125mhz;
/*

// MTIP's 1G PCS with 8b/10b. Purpose of this IP is enable connecting 100Mhz external test instrument with 10G CED ethernet MAC 
   top_pcs_sgxlgmii u_top_pcs_sgxlgmii (
   
     .reset_tx_clk        ( xcvr_reset ),
//     .tx_clk              ( xcvr_tx_clk ),
     .tx_clk              ( xcvr_rx_clk ),      // using common clock for both tx/rx
     .tx_clk_ena          ( 1'b1 ),
     .reset_rx_clk        ( xcvr_reset ),
     .rx_clk              ( xcvr_rx_clk ),
     .rx_clk_ena          ( 1'b1 ),
     .reset_reg_clk       ( xcvr_reset ),
     .reg_clk             ( xcvr_125mhz_refclk ),
     .tbi_rx              ( xcvr_tbi_rx_xlgmii ),      // loopback mux
     .sd_sig_det          ( 1'b1 ),
     .xlgmii_rxclk_ena    ( xlgmii_rxclk_ena ),
     .xlgmii_rxd          ( demux_in_xlgmii_rxd  ),
     .xlgmii_rxc          ( demux_in_xlgmii_rxc  ),
     .xlgmii_rxt0_next    ( xlgmii_rxt0_next ),
     .tbi_tx              ( xcvr_tbi_tx_xlgmii   ),  // loopback mux
     .xlgmii_txclk_ena    ( xlgmii_txclk_ena ),
     .xlgmii_txd          ( mux_out_xlgmii_txd  ),
     .xlgmii_txc          ( mux_out_xlgmii_txc  ),
     .sgpcs_ena           ( 1'b1 ),
     .tx_ipg_length       ( 7'b0000000 ),            // 96-bits time for 100mbps ethernet (960ns count in 125mhz clock --> 960/8=120)
     .sw_reset_r          ( ),
     .sw_reset_t          (  ),
     .sd_loopback         (  ),
     .sg_rx_sync          ( xcvr_sg_rx_sync ),
     .sg_an_done          (xcvr_sg_an_done ),
     .sg_page_rx          (  ),
     .sg_speed            (xcvr_sg_speed  ),
     .sg_hd               (  ),
     .reg_rd              ( 1'b0  ),
     .reg_wr              ( 1'b0  ),
     .reg_addr            ( 5'b00000 ),
     .reg_din             (  ),
     .reg_dout            (  ),
     .reg_busy            (  )
   );

assign async_fifo_wrreq = xlgmii_fpga_loopback_ena & xlgmii_rxclk_ena & (~async_fifo_wr_wrfull); // 1G PHY generates gmii_rxclk_en at 1/8th rate of GMII 
assign async_fifo_rdreq = xlgmii_fpga_loopback_ena & (~async_fifo_rdempty) & !prefetch_disable;   // 1G PHY generates gmii_txclk_en at same rate as GMII 
//assign async_fifo_rdreq = xlgmii_fpga_loopback_ena & (~async_fifo_rdempty) & async_fifo_rdreq_d2;   // 1G PHY generates gmii_txclk_en at same rate as GMII 

    //always_ff@(posedge xcvr_tx_clk or posedge xcvr_reset) begin
    always_ff@(posedge xcvr_rx_clk or posedge xcvr_reset) begin    // common tx/rx clock
       if( xcvr_reset )
         prefetch_disable <= 1'b0;
       else if(xlgmii_fpga_loopback_ena & (~async_fifo_rdempty) & (mux_out_xlgmii_txd != 64'h0707070707070707) & (~xlgmii_txclk_ena) )  
         prefetch_disable <= 1'b1;
       else if (xlgmii_txclk_ena)  // as soon as write is done generate read
         prefetch_disable <= 1'b0;
    end  
   

//assign async_fifo_wrreq = xlgmii_fpga_loopback_ena & (~async_fifo_wr_wrfull);
//assign async_fifo_rdreq = xlgmii_fpga_loopback_ena & (~async_fifo_rdempty);


//    always_ff@(posedge xcvr_tx_clk or posedge xcvr_reset or posedge xlgmii_txclk_ena) begin
//       if( xcvr_reset ) begin
//         async_fifo_rdreq_enable  <= '1 ;
//         async_fifo_rd_done  <= '0 ;
//       end
//     
//       else if (async_fifo_rdreq) begin 
//         async_fifo_rdreq_enable  <= '0 ;              
//       end    
//       
//     else if(xlgmii_txclk_ena) begin 
//       async_fifo_rdreq_enable = 1;
//     end       
//  
//
//     end  

     

// DC FIFO for XLGMII level loopback enable for internal test
  xlgmii_loopback_fifo u_xlgmii_loopback_fifo (
    .data    ( async_fifo_xlgmii_rx_bus ),          //  input,  width = 72,  fifo_input.datain
    .wrreq   ( async_fifo_wrreq ),                  //  input,   width = 1,            .wrreq
    .rdreq   ( async_fifo_rdreq ),                  //  input,   width = 1,            .rdreq
    .wrclk   ( xcvr_rx_clk ),                       //  input,   width = 1,            .wrclk
//    .rdclk   ( xcvr_tx_clk ),                       //  input,   width = 1,            .rdclk
    .rdclk   ( xcvr_rx_clk ),                       //  input,   width = 1,            .rdclk    // using common clock for both tx/rx
    .q       ( async_fifo_xlgmii_tx_bus ),          //  output,  width = 72, fifo_output.dataout
    .rdempty ( async_fifo_rdempty ),                //  output,   width = 1,            .rdempty
    .wrfull  ( async_fifo_wr_wrfull)                //  output,   width = 1,            .wrfull
  );



// Ref input: 125Mhz from on-board Osc, Output: 625Mhz (1.25Ghz/2)
//     s10_fpll_ref125Mhz_625Mhz u_s10_fpll_ref125Mhz_625Mhz 
//     (
//        .pll_refclk0    (xcvr_125mhz_refclk)
//       ,.pll_cal_busy   ()
//       ,.pll_locked     (fpll_locked_SGMII)
//       ,.tx_serial_clk  (xcvr_tx_serial_clk0)
//     );
     
//	ioPLL_4x125mhz u_signalTap_clk (
//		.rst      (xcvr_reset),      //   input,  width = 1,   reset.reset
//		.refclk   (xcvr_125mhz_refclk),   //   input,  width = 1,  refclk.clk
//		.locked   (),   //  output,  width = 1,  locked.export
//		.outclk_0 (signalTap_4xclk)  //  output,  width = 1, outclk0.clk
//	);

*/
endmodule // module top_pcs_sgxlgmii

