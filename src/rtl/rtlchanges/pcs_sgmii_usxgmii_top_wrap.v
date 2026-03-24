
// reuse-pragma startSub [::RCE::insert_copyright] endSub
//  *************************************************************************
//  Component Name   : pcs_sgmii_usxgmii_top_wrap
//  File             : pcs_sgmii_usxgmii_top_wrap.v
//  -------------------------------------------------------------------------
//  Description : - Top wrapper for SGMII(20b) and USXGMII64 Replicator
//                - 4 instances of 1000Base-X with SGMII PCS toplevel
//                  combining RX, TX with MMD registers with define based
//                  enable/disable option
//                - 4 instances of 10GBase-R PCS to/from MAC/SWITCH XGMII
//                  Symbol Replicator Converter (USXGMII Module)
//
//  -------------------------------------------------------------------------
//  *************************************************************************
//  Designed by : Anirudh Iruvanti iruvanti@synopsys.com
//  *************************************************************************
//  Version     : $Id:  $
//  *************************************************************************

`include "common_header.verilog"

module pcs_sgmii_usxgmii_top_wrap (

// **** [Clocks and Reset signals] ****

//`ifndef DWC_SS_SGMII_20B_EN
//  SGMII_20B 0/1/2/3 Clocks
//  ------------------------
input           sgmii0_tx_clk,                            //  SGMII_20B 0 - transmit datapath clock
input           sgmii0_rx_clk,                            //  SGMII_20B 0 - receive datapath clock
input           sgmii0_ref_clk,                           //  SGMII_20B 0 - system reference clock (>line clocks)
input           sgmii0_reg_clk,                           //  SGMII_20B 0 - host clock

input           sgmii1_tx_clk,                            //  SGMII_20B 1 - transmit datapath clock
input           sgmii1_rx_clk,                            //  SGMII_20B 1 - receive datapath clock
input           sgmii1_ref_clk,                           //  SGMII_20B 1 - system reference clock (>line clocks)
input           sgmii1_reg_clk,                           //  SGMII_20B 1 - host clock

input           sgmii2_tx_clk,                            //  SGMII_20B 2 - transmit datapath clock
input           sgmii2_rx_clk,                            //  SGMII_20B 2 - receive datapath clock
input           sgmii2_ref_clk,                           //  SGMII_20B 2 - system reference clock (>line clocks)
input           sgmii2_reg_clk,                           //  SGMII_20B 2 - host clock

input           sgmii3_tx_clk,                            //  SGMII_20B 3 - transmit datapath clock
input           sgmii3_rx_clk,                            //  SGMII_20B 3 - receive datapath clock
input           sgmii3_ref_clk,                           //  SGMII_20B 3 - system reference clock (>line clocks)
input           sgmii3_reg_clk,                           //  SGMII_20B 3 - host clock

//  SGMII_20B 0/1/2/3 Reset Signals
//  -------------------------------
input           sgmii0_reset_tx_clk,                      //  SGMII_20B 0 - async active high reset
input           sgmii0_reset_rx_clk,                      //  SGMII_20B 0 - sync active high reset
input           sgmii0_reset_ref_clk,                     //  SGMII_20B 0 - sync active high reset system
input           sgmii0_reset_reg_clk,                     //  SGMII_20B 0 - sync active high reset host interface

input           sgmii1_reset_tx_clk,                      //  SGMII_20B 1 - async active high reset
input           sgmii1_reset_rx_clk,                      //  SGMII_20B 1 - async active high reset
input           sgmii1_reset_ref_clk,                     //  SGMII_20B 1 - async active high reset system
input           sgmii1_reset_reg_clk,                     //  SGMII_20B 1 - async active high reset host interface

input           sgmii2_reset_tx_clk,                      //  SGMII_20B 2 - async active high reset
input           sgmii2_reset_rx_clk,                      //  SGMII_20B 2 - async active high reset
input           sgmii2_reset_ref_clk,                     //  SGMII_20B 2 - async active high reset system
input           sgmii2_reset_reg_clk,                     //  SGMII_20B 2 - async active high reset host interface

input           sgmii3_reset_tx_clk,                      //  SGMII_20B 3 - async active high reset
input           sgmii3_reset_rx_clk,                      //  SGMII_20B 3 - async active high reset
input           sgmii3_reset_ref_clk,                     //  SGMII_20B 3 - async active high reset system
input           sgmii3_reset_reg_clk,                     //  SGMII_20B 3 - async active high reset host interface
//`endif // DWC_SS_SGMII_20B_EN

//  USXGMII64 0/1/2/3 Clocks
//  ------------------------
input           usxgmii0_tx_clk,                          //  USXGMII64 0 - clock for the TX channel derived frmo the end-point PHY
input           usxgmii0_rx_clk,                          //  USXGMII64 0 - clock for the RX channel derived frmo the end-point PHY
input           usxgmii0_reg_clk,                         //  USXGMII64 0 - clock for the register access as part of the user interface

input           usxgmii1_tx_clk,                          //  USXGMII64 0 - clock for the TX channel derived frmo the end-point PHY
input           usxgmii1_rx_clk,                          //  USXGMII64 0 - clock for the RX channel derived frmo the end-point PHY
input           usxgmii1_reg_clk,                         //  USXGMII64 0 - clock for the register access as part of the user interface

input           usxgmii2_tx_clk,                          //  USXGMII64 0 - clock for the TX channel derived frmo the end-point PHY
input           usxgmii2_rx_clk,                          //  USXGMII64 0 - clock for the RX channel derived frmo the end-point PHY
input           usxgmii2_reg_clk,                         //  USXGMII64 0 - clock for the register access as part of the user interface

input           usxgmii3_tx_clk,                          //  USXGMII64 0 - clock for the TX channel derived frmo the end-point PHY
input           usxgmii3_rx_clk,                          //  USXGMII64 0 - clock for the RX channel derived frmo the end-point PHY
input           usxgmii3_reg_clk,                         //  USXGMII64 0 - clock for the register access as part of the user interface

//  USXGMII64 0/1/2/3 Reset Signals
//  -------------------------------
input           usxgmii0_reset_rxclk,                     //  USXGMII64 0 - active high async reset RX clock
input           usxgmii0_reset_txclk,                     //  USXGMII64 0 - active high async reset TX clock
input           usxgmii0_reset_reg_clk,                   //  USXGMII64 0 - active high async register access domain

input           usxgmii1_reset_rxclk,                     //  USXGMII64 0 - active high async reset RX clock
input           usxgmii1_reset_txclk,                     //  USXGMII64 0 - active high async reset TX clock
input           usxgmii1_reset_reg_clk,                   //  USXGMII64 0 - active high async register access domain

input           usxgmii2_reset_rxclk,                     //  USXGMII64 0 - active high async reset RX clock
input           usxgmii2_reset_txclk,                     //  USXGMII64 0 - active high async reset TX clock
input           usxgmii2_reset_reg_clk,                   //  USXGMII64 0 - active high async register access domain

input           usxgmii3_reset_rxclk,                     //  USXGMII64 0 - active high async reset RX clock
input           usxgmii3_reset_txclk,                     //  USXGMII64 0 - active high async reset TX clock
input           usxgmii3_reset_reg_clk,                   //  USXGMII64 0 - active high async register access domain

// **** [Input/Output signals] ****

//`ifndef DWC_SS_SGMII_20B_EN
//  SGMII_20B 0
//  ------------------
output  [9:0]   sgmii0_tbi_tx,                            //  encoded datastream
input   [9:0]   sgmii0_tbi_rx,                            //  data input
output          sgmii0_xlgmii_txclk_ena,                  //  XLGMII Transmit Clock Enable.
input   [63:0]  sgmii0_xlgmii_txd,                        //  XLGMII Transmit Data bus.
input   [7:0]   sgmii0_xlgmii_txc,                        //  XLGMII Transmit Control.
output          sgmii0_xlgmii_rxclk_ena,                  //  XLGMII Receive Clock Enable.
output  [63:0]  sgmii0_xlgmii_rxd,                        //  XLGMII Receive Data bus.
output  [7:0]   sgmii0_xlgmii_rxc,                        //  XLGMII Receive Control.
output          sgmii0_xlgmii_rxt0_next,                  //  XLGMII Terminate character (0xFD) on lane 0 in the next word
input           sgmii0_sd_sig_det,                        //  signal detect from serdes (async)
output          sgmii0_sd_loopback,                       //  loopback control bit from control register (reg_clk)
input           sgmii0_sgpcs_ena,                         //  Enable 1G PCS
output          sgmii0_sg_rx_sync,                        //  10B sync status
output          sgmii0_sg_an_done,                        //  Autoneg done
output          sgmii0_sg_page_rx,                        //  autoneg page received
output  [1:0]   sgmii0_sg_speed,                          //  00=>10M, 01=>100M, 10=>1G current speed
output          sgmii0_sg_hd,                             //  SGMII half-duplex(1)/ fullduplex(0)
input           sgmii0_mode_sync,                         //  When 1 disable SFD search: assume preamble synchronized to IDLE even byte boundaries being fixed size 7 byte
input           sgmii0_mode_br_dis,                       //  When 1 disable BR SFD searchs. Only 0xD5 is supported
input           sgmii0_seq_ena,                           //  Enable decoding 0x9c Sequence Ordered Sets (Clause 127)
input           sgmii0_reg_rd,                            //  Register Read Strobe
input           sgmii0_reg_wr,                            //  Register Write Strobe
input   [4:0]   sgmii0_reg_addr,                          //  Register Address
input   [15:0]  sgmii0_reg_din,                           //  Write Data from Host Bus
output  [15:0]  sgmii0_reg_dout,                          //  Read Data to Host Bus
output          sgmii0_reg_busy,                          //  Acknowledgement for read/write operation
input   [3:0]   sgmii0_tx_lane_thresh,                    //  4 bit tx decoupling buffer level threshold (set 7 as a compromise if unsure)
input   [2:0]   sgmii0_tx_lane_ckmult,                    //  Multiplicator of ref_clk/125 used. 0>=126MHz, 1>=251MHz,... 7 >= 1000MHz

`ifdef SGMII_TSU_ENA
output          sgmii0_sg_link_status,                    //  Link-up indication
output          sgmii0_cycle_start,
input           sgmii0_cfg_sfd_ts,                        //  Timestamp on FB(0) or SFD(1)
output  [1:0]   sgmii0_sg_rx_tsu,                         //  Bit 0: Receive SFD indication from XGMII/GMII converter Bit 1: GMII RX clock enable signal
`endif

`ifdef MTIPPCS36_EEE_ENA

 output         sgmii0_pma_txmode_quiet,                  //  tx_mode (0 - DATA, 1 - QUIET)
 output         sgmii0_tx_lpi_active,                     //  1 - the TX is in the Low Power State, 0 - in the Active State
 output         sgmii0_pma_rxmode_quiet,                  //  rx_mode (0 - DATA, 1 - QUIET)
 output         sgmii0_rx_lpi_active,                     //  1 - the Receiver in the Low Power State, 0 - in the Active State
 output         sgmii0_rx_wake_err,                       //  To increment the Wake Error Counter (pulse)
 input          sgmii0_lpi_tick,                          //  Timer Tick for all LPI timers (ref clock domain)
`endif

`ifdef SGMII_BIT_SLIP_PIN
 output [3:0]   sgmii0_sg_bit_slip,                       //  Bit slip indication
`endif

//  SGMII_20B 1
//  ------------------
output  [9:0]   sgmii1_tbi_tx,                            //  encoded datastream
input   [9:0]   sgmii1_tbi_rx,                            //  data input
output          sgmii1_xlgmii_txclk_ena,                  //  XLGMII Transmit Clock Enable.
input   [63:0]  sgmii1_xlgmii_txd,                        //  XLGMII Transmit Data bus.
input   [7:0]   sgmii1_xlgmii_txc,                        //  XLGMII Transmit Control.
output          sgmii1_xlgmii_rxclk_ena,                  //  XLGMII Receive Clock Enable.
output  [63:0]  sgmii1_xlgmii_rxd,                        //  XLGMII Receive Data bus.
output  [7:0]   sgmii1_xlgmii_rxc,                        //  XLGMII Receive Control.
output          sgmii1_xlgmii_rxt0_next,                  //  XLGMII Terminate character (0xFD) on lane 0 in the next word
input           sgmii1_sd_sig_det,                        //  signal detect from serdes (async)
output          sgmii1_sd_loopback,                       //  loopback control bit from control register (reg_clk)
input           sgmii1_sgpcs_ena,                         //  Enable 1G PCS
output          sgmii1_sg_rx_sync,                        //  10B sync status
output          sgmii1_sg_an_done,                        //  Autoneg done
output          sgmii1_sg_page_rx,                        //  autoneg page received
output  [1:0]   sgmii1_sg_speed,                          //  00=>10M, 01=>100M, 10=>1G current speed
output          sgmii1_sg_hd,                             //  SGMII half-duplex(1)/ fullduplex(0)
input           sgmii1_mode_sync,                         //  When 1 disable SFD search: assume preamble synchronized to IDLE even byte boundaries being fixed size 7 byte
input           sgmii1_mode_br_dis,                       //  When 1 disable BR SFD searchs. Only 0xD5 is supported
input           sgmii1_seq_ena,                           //  Enable decoding 0x9c Sequence Ordered Sets (Clause 127)
input           sgmii1_reg_rd,                            //  Register Read Strobe
input           sgmii1_reg_wr,                            //  Register Write Strobe
input   [4:0]   sgmii1_reg_addr,                          //  Register Address
input   [15:0]  sgmii1_reg_din,                           //  Write Data from Host Bus
output  [15:0]  sgmii1_reg_dout,                          //  Read Data to Host Bus
output          sgmii1_reg_busy,                          //  Acknowledgement for read/write operation
input   [3:0]   sgmii1_tx_lane_thresh,                    //  4 bit tx decoupling buffer level threshold (set 7 as a compromise if unsure)
input   [2:0]   sgmii1_tx_lane_ckmult,                    //  Multiplicator of ref_clk/125 used. 0>=126MHz, 1>=251MHz,... 7 >= 1000MHz

`ifdef SGMII_TSU_ENA
output          sgmii1_sg_link_status,                    //  Link-up indication
output          sgmii1_cycle_start,
input           sgmii1_cfg_sfd_ts,                        //  Timestamp on FB(0) or SFD(1)
output  [1:0]   sgmii1_sg_rx_tsu,                         //  Bit 0: Receive SFD indication from XGMII/GMII converter Bit 1: GMII RX clock enable signal
`endif

`ifdef MTIPPCS36_EEE_ENA

 output         sgmii1_pma_txmode_quiet,                  //  tx_mode (0 - DATA, 1 - QUIET)
 output         sgmii1_tx_lpi_active,                     //  1 - the TX is in the Low Power State, 0 - in the Active State
 output         sgmii1_pma_rxmode_quiet,                  //  rx_mode (0 - DATA, 1 - QUIET)
 output         sgmii1_rx_lpi_active,                     //  1 - the Receiver in the Low Power State, 0 - in the Active State
 output         sgmii1_rx_wake_err,                       //  To increment the Wake Error Counter (pulse)
 input          sgmii1_lpi_tick,                          //  Timer Tick for all LPI timers (ref clock domain)
`endif

`ifdef SGMII_BIT_SLIP_PIN
 output [3:0]   sgmii1_sg_bit_slip,                       //  Bit slip indication
`endif

//  SGMII_20B 2
//  ------------------
output  [9:0]   sgmii2_tbi_tx,                            //  encoded datastream
input   [9:0]   sgmii2_tbi_rx,                            //  data input
output          sgmii2_xlgmii_txclk_ena,                  //  XLGMII Transmit Clock Enable.
input   [63:0]  sgmii2_xlgmii_txd,                        //  XLGMII Transmit Data bus.
input   [7:0]   sgmii2_xlgmii_txc,                        //  XLGMII Transmit Control.
output          sgmii2_xlgmii_rxclk_ena,                  //  XLGMII Receive Clock Enable.
output  [63:0]  sgmii2_xlgmii_rxd,                        //  XLGMII Receive Data bus.
output  [7:0]   sgmii2_xlgmii_rxc,                        //  XLGMII Receive Control.
output          sgmii2_xlgmii_rxt0_next,                  //  XLGMII Terminate character (0xFD) on lane 0 in the next word
input           sgmii2_sd_sig_det,                        //  signal detect from serdes (async)
output          sgmii2_sd_loopback,                       //  loopback control bit from control register (reg_clk)
input           sgmii2_sgpcs_ena,                         //  Enable 1G PCS
output          sgmii2_sg_rx_sync,                        //  10B sync status
output          sgmii2_sg_an_done,                        //  Autoneg done
output          sgmii2_sg_page_rx,                        //  autoneg page received
output  [1:0]   sgmii2_sg_speed,                          //  00=>10M, 01=>100M, 10=>1G current speed
output          sgmii2_sg_hd,                             //  SGMII half-duplex(1)/ fullduplex(0)
input           sgmii2_mode_sync,                         //  When 1 disable SFD search: assume preamble synchronized to IDLE even byte boundaries being fixed size 7 byte
input           sgmii2_mode_br_dis,                       //  When 1 disable BR SFD searchs. Only 0xD5 is supported
input           sgmii2_seq_ena,                           //  Enable decoding 0x9c Sequence Ordered Sets (Clause 127)
input           sgmii2_reg_rd,                            //  Register Read Strobe
input           sgmii2_reg_wr,                            //  Register Write Strobe
input   [4:0]   sgmii2_reg_addr,                          //  Register Address
input   [15:0]  sgmii2_reg_din,                           //  Write Data from Host Bus
output  [15:0]  sgmii2_reg_dout,                          //  Read Data to Host Bus
output          sgmii2_reg_busy,                          //  Acknowledgement for read/write operation
input   [3:0]   sgmii2_tx_lane_thresh,                    //  4 bit tx decoupling buffer level threshold (set 7 as a compromise if unsure)
input   [2:0]   sgmii2_tx_lane_ckmult,                    //  Multiplicator of ref_clk/125 used. 0>=126MHz, 1>=251MHz,... 7 >= 1000MHz

`ifdef SGMII_TSU_ENA
output          sgmii2_sg_link_status,                    //  Link-up indication
output          sgmii2_cycle_start,
input           sgmii2_cfg_sfd_ts,                        //  Timestamp on FB(0) or SFD(1)
output  [1:0]   sgmii2_sg_rx_tsu,                         //  Bit 0: Receive SFD indication from XGMII/GMII converter Bit 1: GMII RX clock enable signal
`endif

`ifdef MTIPPCS36_EEE_ENA

 output         sgmii2_pma_txmode_quiet,                  //  tx_mode (0 - DATA, 1 - QUIET)
 output         sgmii2_tx_lpi_active,                     //  1 - the TX is in the Low Power State, 0 - in the Active State
 output         sgmii2_pma_rxmode_quiet,                  //  rx_mode (0 - DATA, 1 - QUIET)
 output         sgmii2_rx_lpi_active,                     //  1 - the Receiver in the Low Power State, 0 - in the Active State
 output         sgmii2_rx_wake_err,                       //  To increment the Wake Error Counter (pulse)
 input          sgmii2_lpi_tick,                          //  Timer Tick for all LPI timers (ref clock domain)
`endif

`ifdef SGMII_BIT_SLIP_PIN
 output [3:0]   sgmii2_sg_bit_slip,                       //  Bit slip indication
`endif

//  SGMII_20B 3
//  ------------------
output  [9:0]   sgmii3_tbi_tx,                            //  encoded datastream
input   [9:0]   sgmii3_tbi_rx,                            //  data input
output          sgmii3_xlgmii_txclk_ena,                  //  XLGMII Transmit Clock Enable.
input   [63:0]  sgmii3_xlgmii_txd,                        //  XLGMII Transmit Data bus.
input   [7:0]   sgmii3_xlgmii_txc,                        //  XLGMII Transmit Control.
output          sgmii3_xlgmii_rxclk_ena,                  //  XLGMII Receive Clock Enable.
output  [63:0]  sgmii3_xlgmii_rxd,                        //  XLGMII Receive Data bus.
output  [7:0]   sgmii3_xlgmii_rxc,                        //  XLGMII Receive Control.
output          sgmii3_xlgmii_rxt0_next,                  //  XLGMII Terminate character (0xFD) on lane 0 in the next word
input           sgmii3_sd_sig_det,                        //  signal detect from serdes (async)
output          sgmii3_sd_loopback,                       //  loopback control bit from control register (reg_clk)
input           sgmii3_sgpcs_ena,                         //  Enable 1G PCS
output          sgmii3_sg_rx_sync,                        //  10B sync status
output          sgmii3_sg_an_done,                        //  Autoneg done
output          sgmii3_sg_page_rx,                        //  autoneg page received
output  [1:0]   sgmii3_sg_speed,                          //  00=>10M, 01=>100M, 10=>1G current speed
output          sgmii3_sg_hd,                             //  SGMII half-duplex(1)/ fullduplex(0)
input           sgmii3_mode_sync,                         //  When 1 disable SFD search: assume preamble synchronized to IDLE even byte boundaries being fixed size 7 byte
input           sgmii3_mode_br_dis,                       //  When 1 disable BR SFD searchs. Only 0xD5 is supported
input           sgmii3_seq_ena,                           //  Enable decoding 0x9c Sequence Ordered Sets (Clause 127)
input           sgmii3_reg_rd,                            //  Register Read Strobe
input           sgmii3_reg_wr,                            //  Register Write Strobe
input   [4:0]   sgmii3_reg_addr,                          //  Register Address
input   [15:0]  sgmii3_reg_din,                           //  Write Data from Host Bus
output  [15:0]  sgmii3_reg_dout,                          //  Read Data to Host Bus
output          sgmii3_reg_busy,                          //  Acknowledgement for read/write operation
input   [3:0]   sgmii3_tx_lane_thresh,                    //  4 bit tx decoupling buffer level threshold (set 7 as a compromise if unsure)
input   [2:0]   sgmii3_tx_lane_ckmult,                    //  Multiplicator of ref_clk/125 used. 0>=126MHz, 1>=251MHz,... 7 >= 1000MHz

`ifdef SGMII_TSU_ENA
output          sgmii3_sg_link_status,                    //  Link-up indication
output          sgmii3_cycle_start,
input           sgmii3_cfg_sfd_ts,                        //  Timestamp on FB(0) or SFD(1)
output  [1:0]   sgmii3_sg_rx_tsu,                         //  Bit 0: Receive SFD indication from XGMII/GMII converter Bit 1: GMII RX clock enable signal
`endif

`ifdef MTIPPCS36_EEE_ENA

 output         sgmii3_pma_txmode_quiet,                  //  tx_mode (0 - DATA, 1 - QUIET)
 output         sgmii3_tx_lpi_active,                     //  1 - the TX is in the Low Power State, 0 - in the Active State
 output         sgmii3_pma_rxmode_quiet,                  //  rx_mode (0 - DATA, 1 - QUIET)
 output         sgmii3_rx_lpi_active,                     //  1 - the Receiver in the Low Power State, 0 - in the Active State
 output         sgmii3_rx_wake_err,                       //  To increment the Wake Error Counter (pulse)
 input          sgmii3_lpi_tick,                          //  Timer Tick for all LPI timers (ref clock domain)
`endif

`ifdef SGMII_BIT_SLIP_PIN
 output [3:0]   sgmii3_sg_bit_slip,                       //  Bit slip indication
`endif
//`endif // DWC_SS_SGMII_20B_EN

//  USXGMII64 0
//  -----------

// MAC/SWITCH XGMII interface signals
output          usxgmii0_mrx_xgmii_clk_ena,               //  MAC [RX] XGMII data-valid signal  (not in advance for 64bit!)
output  [63:0]  usxgmii0_mrx_xgmii_rxd,                   //  MAC [RX] XGMII data bus
output  [7:0]   usxgmii0_mrx_xgmii_rxc,                   //  MAC [RX] XGMII control
output          usxgmii0_mrx_xgmii_rxt0_next,             //  MAC [RX] XGMII next block has TERM 0
output          usxgmii0_mtx_xgmii_clk_ena,               //  MAC [TX] XGMII data-valid signal  (not in advance for 64bit!)
input   [63:0]  usxgmii0_mtx_xgmii_txd,                   //  MAC [TX] XGMII data bus
input   [7:0]   usxgmii0_mtx_xgmii_txc,                   //  MAC [TX] XGMII control

// PCS XGMII interface signals
input           usxgmii0_prx_xgmii_clk_ena,               //  PCS [RX] XGMII data-valid signal  (not in advance for 64bit!)
input   [63:0]  usxgmii0_prx_xgmii_rxd,                   //  PCS [RX] XGMII data bus
input   [7:0]   usxgmii0_prx_xgmii_rxc,                   //  PCS [RX] XGMII control
input           usxgmii0_prx_xgmii_rxt0_next,             //  PCS [RX] XGMII next block has TERM 0
input           usxgmii0_ptx_xgmii_clk_ena,               //  PCS [TX] XGMII data-valid signal  (not in advance for 64bit!)
output  [63:0]  usxgmii0_ptx_xgmii_txd,                   //  PCS [TX] XGMII data bus
output  [7:0]   usxgmii0_ptx_xgmii_txc,                   //  PCS [TX] XGMII control

// register interface signals
input           usxgmii0_reg_rd,                          //  Software Register Interface BUS [read] strobe
input           usxgmii0_reg_wr,                          //  Software Register Interface BUS [write] strobe
input   [4:0]   usxgmii0_reg_addr,                        //  Software Register Interface BUS address
input   [15:0]  usxgmii0_reg_din,                         //  Software Register Interface BUS data IN
output  [15:0]  usxgmii0_reg_dout,                        //  Software Register Interface BUS data OUT
output          usxgmii0_reg_busy,                        //  Software Register Interface BUS busy indicator

// Configuration control signals
output          usxgmii0_usxgmii_active,                  //  Asserts when USXGMII is active (tx_clk). Deasserts if it operates in 10G bypassing all logic.
input   [9:0]   usxgmii0_conf_speed_rx,                   //  Speed of operation [RX] control input
input   [9:0]   usxgmii0_conf_speed_tx,                   //  Speed of operation [TX] control input
input           usxgmii0_link_status,                     //  PCS block-lock sync status input (rx_clk)
input           usxgmii0_conf_speed_rx_2_5,
input           usxgmii0_conf_speed_tx_2_5,
output          usxgmii0_an_busy,
output          usxgmii0_an_pability_done,
output  [15:0]  usxgmii0_an_pability,

//  USXGMII64 1
//  -----------

// MAC/SWITCH XGMII interface signals
output          usxgmii1_mrx_xgmii_clk_ena,               //  MAC [RX] XGMII data-valid signal  (not in advance for 64bit!)
output  [63:0]  usxgmii1_mrx_xgmii_rxd,                   //  MAC [RX] XGMII data bus
output  [7:0]   usxgmii1_mrx_xgmii_rxc,                   //  MAC [RX] XGMII control
output          usxgmii1_mrx_xgmii_rxt0_next,             //  MAC [RX] XGMII next block has TERM 0
output          usxgmii1_mtx_xgmii_clk_ena,               //  MAC [TX] XGMII data-valid signal  (not in advance for 64bit!)
input   [63:0]  usxgmii1_mtx_xgmii_txd,                   //  MAC [TX] XGMII data bus
input   [7:0]   usxgmii1_mtx_xgmii_txc,                   //  MAC [TX] XGMII control

// PCS XGMII interface signals
input           usxgmii1_prx_xgmii_clk_ena,               //  PCS [RX] XGMII data-valid signal  (not in advance for 64bit!)
input   [63:0]  usxgmii1_prx_xgmii_rxd,                   //  PCS [RX] XGMII data bus
input   [7:0]   usxgmii1_prx_xgmii_rxc,                   //  PCS [RX] XGMII control
input           usxgmii1_prx_xgmii_rxt0_next,             //  PCS [RX] XGMII next block has TERM 0
input           usxgmii1_ptx_xgmii_clk_ena,               //  PCS [TX] XGMII data-valid signal  (not in advance for 64bit!)
output  [63:0]  usxgmii1_ptx_xgmii_txd,                   //  PCS [TX] XGMII data bus
output  [7:0]   usxgmii1_ptx_xgmii_txc,                   //  PCS [TX] XGMII control

// register interface signals
input           usxgmii1_reg_rd,                          //  Software Register Interface BUS [read] strobe
input           usxgmii1_reg_wr,                          //  Software Register Interface BUS [write] strobe
input   [4:0]   usxgmii1_reg_addr,                        //  Software Register Interface BUS address
input   [15:0]  usxgmii1_reg_din,                         //  Software Register Interface BUS data IN
output  [15:0]  usxgmii1_reg_dout,                        //  Software Register Interface BUS data OUT
output          usxgmii1_reg_busy,                        //  Software Register Interface BUS busy indicator

// Configuration control signals
output          usxgmii1_usxgmii_active,                  //  Asserts when USXGMII is active (tx_clk). Deasserts if it operates in 10G bypassing all logic.
input   [9:0]   usxgmii1_conf_speed_rx,                   //  Speed of operation [RX] control input
input   [9:0]   usxgmii1_conf_speed_tx,                   //  Speed of operation [TX] control input
input           usxgmii1_link_status,                     //  PCS block-lock sync status input (rx_clk)
input           usxgmii1_conf_speed_rx_2_5,
input           usxgmii1_conf_speed_tx_2_5,
output          usxgmii1_an_busy,
output          usxgmii1_an_pability_done,
output  [15:0]  usxgmii1_an_pability,

//  USXGMII64 2
//  -----------

// MAC/SWITCH XGMII interface signals
output          usxgmii2_mrx_xgmii_clk_ena,               //  MAC [RX] XGMII data-valid signal  (not in advance for 64bit!)
output  [63:0]  usxgmii2_mrx_xgmii_rxd,                   //  MAC [RX] XGMII data bus
output  [7:0]   usxgmii2_mrx_xgmii_rxc,                   //  MAC [RX] XGMII control
output          usxgmii2_mrx_xgmii_rxt0_next,             //  MAC [RX] XGMII next block has TERM 0
output          usxgmii2_mtx_xgmii_clk_ena,               //  MAC [TX] XGMII data-valid signal  (not in advance for 64bit!)
input   [63:0]  usxgmii2_mtx_xgmii_txd,                   //  MAC [TX] XGMII data bus
input   [7:0]   usxgmii2_mtx_xgmii_txc,                   //  MAC [TX] XGMII control

// PCS XGMII interface signals
input           usxgmii2_prx_xgmii_clk_ena,               //  PCS [RX] XGMII data-valid signal  (not in advance for 64bit!)
input   [63:0]  usxgmii2_prx_xgmii_rxd,                   //  PCS [RX] XGMII data bus
input   [7:0]   usxgmii2_prx_xgmii_rxc,                   //  PCS [RX] XGMII control
input           usxgmii2_prx_xgmii_rxt0_next,             //  PCS [RX] XGMII next block has TERM 0
input           usxgmii2_ptx_xgmii_clk_ena,               //  PCS [TX] XGMII data-valid signal  (not in advance for 64bit!)
output  [63:0]  usxgmii2_ptx_xgmii_txd,                   //  PCS [TX] XGMII data bus
output  [7:0]   usxgmii2_ptx_xgmii_txc,                   //  PCS [TX] XGMII control

// register interface signals
input           usxgmii2_reg_rd,                          //  Software Register Interface BUS [read] strobe
input           usxgmii2_reg_wr,                          //  Software Register Interface BUS [write] strobe
input   [4:0]   usxgmii2_reg_addr,                        //  Software Register Interface BUS address
input   [15:0]  usxgmii2_reg_din,                         //  Software Register Interface BUS data IN
output  [15:0]  usxgmii2_reg_dout,                        //  Software Register Interface BUS data OUT
output          usxgmii2_reg_busy,                        //  Software Register Interface BUS busy indicator

// Configuration control signals
output          usxgmii2_usxgmii_active,                  //  Asserts when USXGMII is active (tx_clk). Deasserts if it operates in 10G bypassing all logic.
input   [9:0]   usxgmii2_conf_speed_rx,                   //  Speed of operation [RX] control input
input   [9:0]   usxgmii2_conf_speed_tx,                   //  Speed of operation [TX] control input
input           usxgmii2_link_status,                     //  PCS block-lock sync status input (rx_clk)
input           usxgmii2_conf_speed_rx_2_5,
input           usxgmii2_conf_speed_tx_2_5,
output          usxgmii2_an_busy,
output          usxgmii2_an_pability_done,
output  [15:0]  usxgmii2_an_pability,

//  USXGMII64 3
//  -----------

// MAC/SWITCH XGMII interface signals
output          usxgmii3_mrx_xgmii_clk_ena,               //  MAC [RX] XGMII data-valid signal  (not in advance for 64bit!)
output  [63:0]  usxgmii3_mrx_xgmii_rxd,                   //  MAC [RX] XGMII data bus
output  [7:0]   usxgmii3_mrx_xgmii_rxc,                   //  MAC [RX] XGMII control
output          usxgmii3_mrx_xgmii_rxt0_next,             //  MAC [RX] XGMII next block has TERM 0
output          usxgmii3_mtx_xgmii_clk_ena,               //  MAC [TX] XGMII data-valid signal  (not in advance for 64bit!)
input   [63:0]  usxgmii3_mtx_xgmii_txd,                   //  MAC [TX] XGMII data bus
input   [7:0]   usxgmii3_mtx_xgmii_txc,                   //  MAC [TX] XGMII control

// PCS XGMII interface signals
input           usxgmii3_prx_xgmii_clk_ena,               //  PCS [RX] XGMII data-valid signal  (not in advance for 64bit!)
input   [63:0]  usxgmii3_prx_xgmii_rxd,                   //  PCS [RX] XGMII data bus
input   [7:0]   usxgmii3_prx_xgmii_rxc,                   //  PCS [RX] XGMII control
input           usxgmii3_prx_xgmii_rxt0_next,             //  PCS [RX] XGMII next block has TERM 0
input           usxgmii3_ptx_xgmii_clk_ena,               //  PCS [TX] XGMII data-valid signal  (not in advance for 64bit!)
output  [63:0]  usxgmii3_ptx_xgmii_txd,                   //  PCS [TX] XGMII data bus
output  [7:0]   usxgmii3_ptx_xgmii_txc,                   //  PCS [TX] XGMII control

// register interface signals
input           usxgmii3_reg_rd,                          //  Software Register Interface BUS [read] strobe
input           usxgmii3_reg_wr,                          //  Software Register Interface BUS [write] strobe
input   [4:0]   usxgmii3_reg_addr,                        //  Software Register Interface BUS address
input   [15:0]  usxgmii3_reg_din,                         //  Software Register Interface BUS data IN
output  [15:0]  usxgmii3_reg_dout,                        //  Software Register Interface BUS data OUT
output          usxgmii3_reg_busy,                        //  Software Register Interface BUS busy indicator

// Configuration control signals
output          usxgmii3_usxgmii_active,                  //  Asserts when USXGMII is active (tx_clk). Deasserts if it operates in 10G bypassing all logic.
input   [9:0]   usxgmii3_conf_speed_rx,                   //  Speed of operation [RX] control input
input   [9:0]   usxgmii3_conf_speed_tx,                   //  Speed of operation [TX] control input
input           usxgmii3_link_status,                     //  PCS block-lock sync status input (rx_clk)
input           usxgmii3_conf_speed_rx_2_5,
input           usxgmii3_conf_speed_tx_2_5,
output          usxgmii3_an_busy,
output          usxgmii3_an_pability_done,
output  [15:0]  usxgmii3_an_pability

);

`include "pcs_pack_package.verilog"

`ifdef DWC_SS_SGMII_20B_EN
top_pcs_sgmii_refck_host_xlgmii U_SGMII_20B_0 (
`else
top_pcs_sgmii_refck_host_xlgmii_10b U_SGMII_10B_0 (
`endif
//        .reset_tx_clk                        ( sgmii0_reset_tx_clk     ),
//        .reset_rx_clk                        ( sgmii0_reset_rx_clk     ),
//        .reset_ref_clk                       ( sgmii0_reset_ref_clk    ),
//        .reset_reg_clk                       ( sgmii0_reset_reg_clk    ),
//        .tx_clk                              ( sgmii0_tx_clk           ),
//        .rx_clk                              ( sgmii0_rx_clk           ),
//        .ref_clk                             ( sgmii0_ref_clk          ),
//        .reg_clk                             ( sgmii0_reg_clk          ),
        .tbi_tx                              ( sgmii0_tbi_tx           ),
        .tbi_rx                              ( sgmii0_tbi_rx           ),
        .xlgmii_txclk_ena                    ( sgmii0_xlgmii_txclk_ena ),
        .xlgmii_txd                          ( sgmii0_xlgmii_txd       ),
        .xlgmii_txc                          ( sgmii0_xlgmii_txc       ),
        .xlgmii_rxclk_ena                    ( sgmii0_xlgmii_rxclk_ena ),
        .xlgmii_rxd                          ( sgmii0_xlgmii_rxd       ),
        .xlgmii_rxc                          ( sgmii0_xlgmii_rxc       ),
        .xlgmii_rxt0_next                    ( sgmii0_xlgmii_rxt0_next ),
        .sd_sig_det                          ( sgmii0_sd_sig_det       ),
        .sd_loopback                         ( sgmii0_sd_loopback      ),
        .sgpcs_ena                           ( sgmii0_sgpcs_ena        ),
        .sg_rx_sync                          ( sgmii0_sg_rx_sync       ),
        .sg_an_done                          ( sgmii0_sg_an_done       ),
        .sg_page_rx                          ( sgmii0_sg_page_rx       ),
        .sg_speed                            ( sgmii0_sg_speed         ),
        .sg_hd                               ( sgmii0_sg_hd            ),
        .mode_sync                           ( sgmii0_mode_sync        ),
        .mode_br_dis                         ( sgmii0_mode_br_dis      ),
        .seq_ena                             ( sgmii0_seq_ena          ),
        .reg_rd                              ( sgmii0_reg_rd           ),
        .reg_wr                              ( sgmii0_reg_wr           ),
        .reg_addr                            ( sgmii0_reg_addr         ),
        .reg_din                             ( sgmii0_reg_din          ),
        .reg_dout                            ( sgmii0_reg_dout         ),
        .reg_busy                            ( sgmii0_reg_busy         ),
        .tx_lane_thresh                      ( sgmii0_tx_lane_thresh   ),
        .tx_lane_ckmult                      ( sgmii0_tx_lane_ckmult   )
											   
        `ifdef SGMII_TSU_ENA                   
        ,                                      
        .sg_link_status                      ( sgmii0_sg_link_status   ),
        .cycle_start                         ( sgmii0_cycle_start      ),
        .cfg_sfd_ts                          ( sgmii0_cfg_sfd_ts       ),
        .sg_rx_tsu                           ( sgmii0_sg_rx_tsu        )
        `endif                                 
											   
        `ifdef MTIPPCS36_EEE_ENA               
        ,                                      
        .pma_txmode_quiet                    ( sgmii0_pma_txmode_quiet ),
        .tx_lpi_active                       ( sgmii0_tx_lpi_active    ),
        .pma_rxmode_quiet                    ( sgmii0_pma_rxmode_quiet ),
        .rx_lpi_active                       ( sgmii0_rx_lpi_active    ),
        .rx_wake_err                         ( sgmii0_rx_wake_err      ),
        .lpi_tick                            ( sgmii0_lpi_tick         )
											   
        `endif                                 
        `ifdef SGMII_BIT_SLIP_PIN              
        ,                                      
        .sg_bit_slip                         ( sgmii0_sg_bit_slip      )
        `endif
        );


`ifdef DWC_SS_SGMII_20B_EN
top_pcs_sgmii_refck_host_xlgmii U_SGMII_20B_1 (
`else
top_pcs_sgmii_refck_host_xlgmii_10b U_SGMII_10B_1 (
`endif
//        .reset_tx_clk                        ( sgmii1_reset_tx_clk     ),
//        .reset_rx_clk                        ( sgmii1_reset_rx_clk     ),
//        .reset_ref_clk                       ( sgmii1_reset_ref_clk    ),
//        .reset_reg_clk                       ( sgmii1_reset_reg_clk    ),
//        .tx_clk                              ( sgmii1_tx_clk           ),
//        .rx_clk                              ( sgmii1_rx_clk           ),
//        .ref_clk                             ( sgmii1_ref_clk          ),
//        .reg_clk                             ( sgmii1_reg_clk          ),
        .tbi_tx                              ( sgmii1_tbi_tx           ),
        .tbi_rx                              ( sgmii1_tbi_rx           ),
        .xlgmii_txclk_ena                    ( sgmii1_xlgmii_txclk_ena ),
        .xlgmii_txd                          ( sgmii1_xlgmii_txd       ),
        .xlgmii_txc                          ( sgmii1_xlgmii_txc       ),
        .xlgmii_rxclk_ena                    ( sgmii1_xlgmii_rxclk_ena ),
        .xlgmii_rxd                          ( sgmii1_xlgmii_rxd       ),
        .xlgmii_rxc                          ( sgmii1_xlgmii_rxc       ),
        .xlgmii_rxt0_next                    ( sgmii1_xlgmii_rxt0_next ),
        .sd_sig_det                          ( sgmii1_sd_sig_det       ),
        .sd_loopback                         ( sgmii1_sd_loopback      ),
        .sgpcs_ena                           ( sgmii1_sgpcs_ena        ),
        .sg_rx_sync                          ( sgmii1_sg_rx_sync       ),
        .sg_an_done                          ( sgmii1_sg_an_done       ),
        .sg_page_rx                          ( sgmii1_sg_page_rx       ),
        .sg_speed                            ( sgmii1_sg_speed         ),
        .sg_hd                               ( sgmii1_sg_hd            ),
        .mode_sync                           ( sgmii1_mode_sync        ),
        .mode_br_dis                         ( sgmii1_mode_br_dis      ),
        .seq_ena                             ( sgmii1_seq_ena          ),
        .reg_rd                              ( sgmii1_reg_rd           ),
        .reg_wr                              ( sgmii1_reg_wr           ),
        .reg_addr                            ( sgmii1_reg_addr         ),
        .reg_din                             ( sgmii1_reg_din          ),
        .reg_dout                            ( sgmii1_reg_dout         ),
        .reg_busy                            ( sgmii1_reg_busy         ),
        .tx_lane_thresh                      ( sgmii1_tx_lane_thresh   ),
        .tx_lane_ckmult                      ( sgmii1_tx_lane_ckmult   )

        `ifdef SGMII_TSU_ENA
        ,
        .sg_link_status                      ( sgmii1_sg_link_status   ),
        .cycle_start                         ( sgmii1_cycle_start      ),
        .cfg_sfd_ts                          ( sgmii1_cfg_sfd_ts       ),
        .sg_rx_tsu                           ( sgmii1_sg_rx_tsu        )
        `endif

        `ifdef MTIPPCS36_EEE_ENA
        ,
        .pma_txmode_quiet                    ( sgmii1_pma_txmode_quiet ),
        .tx_lpi_active                       ( sgmii1_tx_lpi_active    ),
        .pma_rxmode_quiet                    ( sgmii1_pma_rxmode_quiet ),
        .rx_lpi_active                       ( sgmii1_rx_lpi_active    ),
        .rx_wake_err                         ( sgmii1_rx_wake_err      ),
        .lpi_tick                            ( sgmii1_lpi_tick         )

        `endif
        `ifdef SGMII_BIT_SLIP_PIN
        ,
        .sg_bit_slip                         ( sgmii1_sg_bit_slip      )
        `endif
        );

`ifdef DWC_SS_SGMII_20B_EN
top_pcs_sgmii_refck_host_xlgmii U_SGMII_20B_2 (
`else
top_pcs_sgmii_refck_host_xlgmii_10b U_SGMII_10B_2 (
`endif

//        .reset_tx_clk                        ( sgmii2_reset_tx_clk     ),
//        .reset_rx_clk                        ( sgmii2_reset_rx_clk     ),
//        .reset_ref_clk                       ( sgmii2_reset_ref_clk    ),
//        .reset_reg_clk                       ( sgmii2_reset_reg_clk    ),
//        .tx_clk                              ( sgmii2_tx_clk           ),
//        .rx_clk                              ( sgmii2_rx_clk           ),
//        .ref_clk                             ( sgmii2_ref_clk          ),
//        .reg_clk                             ( sgmii2_reg_clk          ),
        .tbi_tx                              ( sgmii2_tbi_tx           ),
        .tbi_rx                              ( sgmii2_tbi_rx           ),
        .xlgmii_txclk_ena                    ( sgmii2_xlgmii_txclk_ena ),
        .xlgmii_txd                          ( sgmii2_xlgmii_txd       ),
        .xlgmii_txc                          ( sgmii2_xlgmii_txc       ),
        .xlgmii_rxclk_ena                    ( sgmii2_xlgmii_rxclk_ena ),
        .xlgmii_rxd                          ( sgmii2_xlgmii_rxd       ),
        .xlgmii_rxc                          ( sgmii2_xlgmii_rxc       ),
        .xlgmii_rxt0_next                    ( sgmii2_xlgmii_rxt0_next ),
        .sd_sig_det                          ( sgmii2_sd_sig_det       ),
        .sd_loopback                         ( sgmii2_sd_loopback      ),
        .sgpcs_ena                           ( sgmii2_sgpcs_ena        ),
        .sg_rx_sync                          ( sgmii2_sg_rx_sync       ),
        .sg_an_done                          ( sgmii2_sg_an_done       ),
        .sg_page_rx                          ( sgmii2_sg_page_rx       ),
        .sg_speed                            ( sgmii2_sg_speed         ),
        .sg_hd                               ( sgmii2_sg_hd            ),
        .mode_sync                           ( sgmii2_mode_sync        ),
        .mode_br_dis                         ( sgmii2_mode_br_dis      ),
        .seq_ena                             ( sgmii2_seq_ena          ),
        .reg_rd                              ( sgmii2_reg_rd           ),
        .reg_wr                              ( sgmii2_reg_wr           ),
        .reg_addr                            ( sgmii2_reg_addr         ),
        .reg_din                             ( sgmii2_reg_din          ),
        .reg_dout                            ( sgmii2_reg_dout         ),
        .reg_busy                            ( sgmii2_reg_busy         ),
        .tx_lane_thresh                      ( sgmii2_tx_lane_thresh   ),
        .tx_lane_ckmult                      ( sgmii2_tx_lane_ckmult   )
											   
        `ifdef SGMII_TSU_ENA                   
        ,                                      
        .sg_link_status                      ( sgmii2_sg_link_status   ),
        .cycle_start                         ( sgmii2_cycle_start      ),
        .cfg_sfd_ts                          ( sgmii2_cfg_sfd_ts       ),
        .sg_rx_tsu                           ( sgmii2_sg_rx_tsu        )
        `endif                                 
											   
        `ifdef MTIPPCS36_EEE_ENA               
        ,                                      
        .pma_txmode_quiet                    ( sgmii2_pma_txmode_quiet ),
        .tx_lpi_active                       ( sgmii2_tx_lpi_active    ),
        .pma_rxmode_quiet                    ( sgmii2_pma_rxmode_quiet ),
        .rx_lpi_active                       ( sgmii2_rx_lpi_active    ),
        .rx_wake_err                         ( sgmii2_rx_wake_err      ),
        .lpi_tick                            ( sgmii2_lpi_tick         )
											   
        `endif                                 
        `ifdef SGMII_BIT_SLIP_PIN              
        ,                                      
        .sg_bit_slip                         ( sgmii2_sg_bit_slip      )
        `endif
        );

`ifdef DWC_SS_SGMII_20B_EN
top_pcs_sgmii_refck_host_xlgmii U_SGMII_20B_3 (
`else
top_pcs_sgmii_refck_host_xlgmii_10b U_SGMII_10B_3 (
`endif
//        .reset_tx_clk                        ( sgmii3_reset_tx_clk     ),
//        .reset_rx_clk                        ( sgmii3_reset_rx_clk     ),
//        .reset_ref_clk                       ( sgmii3_reset_ref_clk    ),
//        .reset_reg_clk                       ( sgmii3_reset_reg_clk    ),
//        .tx_clk                              ( sgmii3_tx_clk           ),
//        .rx_clk                              ( sgmii3_rx_clk           ),
//        .ref_clk                             ( sgmii3_ref_clk          ),
//        .reg_clk                             ( sgmii3_reg_clk          ),
        .tbi_tx                              ( sgmii3_tbi_tx           ),
        .tbi_rx                              ( sgmii3_tbi_rx           ),
        .xlgmii_txclk_ena                    ( sgmii3_xlgmii_txclk_ena ),
        .xlgmii_txd                          ( sgmii3_xlgmii_txd       ),
        .xlgmii_txc                          ( sgmii3_xlgmii_txc       ),
        .xlgmii_rxclk_ena                    ( sgmii3_xlgmii_rxclk_ena ),
        .xlgmii_rxd                          ( sgmii3_xlgmii_rxd       ),
        .xlgmii_rxc                          ( sgmii3_xlgmii_rxc       ),
        .xlgmii_rxt0_next                    ( sgmii3_xlgmii_rxt0_next ),
        .sd_sig_det                          ( sgmii3_sd_sig_det       ),
        .sd_loopback                         ( sgmii3_sd_loopback      ),
        .sgpcs_ena                           ( sgmii3_sgpcs_ena        ),
        .sg_rx_sync                          ( sgmii3_sg_rx_sync       ),
        .sg_an_done                          ( sgmii3_sg_an_done       ),
        .sg_page_rx                          ( sgmii3_sg_page_rx       ),
        .sg_speed                            ( sgmii3_sg_speed         ),
        .sg_hd                               ( sgmii3_sg_hd            ),
        .mode_sync                           ( sgmii3_mode_sync        ),
        .mode_br_dis                         ( sgmii3_mode_br_dis      ),
        .seq_ena                             ( sgmii3_seq_ena          ),
        .reg_rd                              ( sgmii3_reg_rd           ),
        .reg_wr                              ( sgmii3_reg_wr           ),
        .reg_addr                            ( sgmii3_reg_addr         ),
        .reg_din                             ( sgmii3_reg_din          ),
        .reg_dout                            ( sgmii3_reg_dout         ),
        .reg_busy                            ( sgmii3_reg_busy         ),
        .tx_lane_thresh                      ( sgmii3_tx_lane_thresh   ),
        .tx_lane_ckmult                      ( sgmii3_tx_lane_ckmult   )
											   
        `ifdef SGMII_TSU_ENA                   
        ,                                      
        .sg_link_status                      ( sgmii3_sg_link_status   ),
        .cycle_start                         ( sgmii3_cycle_start      ),
        .cfg_sfd_ts                          ( sgmii3_cfg_sfd_ts       ),
        .sg_rx_tsu                           ( sgmii3_sg_rx_tsu        )
        `endif                                 
											   
        `ifdef MTIPPCS36_EEE_ENA               
        ,                                      
        .pma_txmode_quiet                    ( sgmii3_pma_txmode_quiet ),
        .tx_lpi_active                       ( sgmii3_tx_lpi_active    ),
        .pma_rxmode_quiet                    ( sgmii3_pma_rxmode_quiet ),
        .rx_lpi_active                       ( sgmii3_rx_lpi_active    ),
        .rx_wake_err                         ( sgmii3_rx_wake_err      ),
        .lpi_tick                            ( sgmii3_lpi_tick         )
											   
        `endif                                 
        `ifdef SGMII_BIT_SLIP_PIN              
        ,                                      
        .sg_bit_slip                         ( sgmii3_sg_bit_slip      )
        `endif
        );

top_usxgmii64 U_USXGMII64_0 (
        .tx_clk                              ( usxgmii0_tx_clk              ),
        .rx_clk                              ( usxgmii0_rx_clk              ),
        .reset_rxclk                         ( usxgmii0_reset_rxclk         ),
        .reset_txclk                         ( usxgmii0_reset_txclk         ),
        .mrx_xgmii_clk_ena                   ( usxgmii0_mrx_xgmii_clk_ena   ),
        .mrx_xgmii_rxd                       ( usxgmii0_mrx_xgmii_rxd       ),
        .mrx_xgmii_rxc                       ( usxgmii0_mrx_xgmii_rxc       ),
        .mrx_xgmii_rxt0_next                 ( usxgmii0_mrx_xgmii_rxt0_next ),
        .mtx_xgmii_clk_ena                   ( usxgmii0_mtx_xgmii_clk_ena   ),
        .mtx_xgmii_txd                       ( usxgmii0_mtx_xgmii_txd       ),
        .mtx_xgmii_txc                       ( usxgmii0_mtx_xgmii_txc       ),
        .prx_xgmii_clk_ena                   ( usxgmii0_prx_xgmii_clk_ena   ),
        .prx_xgmii_rxd                       ( usxgmii0_prx_xgmii_rxd       ),
        .prx_xgmii_rxc                       ( usxgmii0_prx_xgmii_rxc       ),
        .prx_xgmii_rxt0_next                 ( usxgmii0_prx_xgmii_rxt0_next ),
        .ptx_xgmii_clk_ena                   ( usxgmii0_ptx_xgmii_clk_ena   ),
        .ptx_xgmii_txd                       ( usxgmii0_ptx_xgmii_txd       ),
        .ptx_xgmii_txc                       ( usxgmii0_ptx_xgmii_txc       ),
        .reset_reg_clk                       ( usxgmii0_reset_reg_clk       ),
        .reg_clk                             ( usxgmii0_reg_clk             ),
        .reg_rd                              ( usxgmii0_reg_rd              ),
        .reg_wr                              ( usxgmii0_reg_wr              ),
        .reg_addr                            ( usxgmii0_reg_addr            ),
        .reg_din                             ( usxgmii0_reg_din             ),
        .reg_dout                            ( usxgmii0_reg_dout            ),
        .reg_busy                            ( usxgmii0_reg_busy            ),
        .usxgmii_active                      ( usxgmii0_usxgmii_active      ),
        .conf_speed_rx                       ( usxgmii0_conf_speed_rx       ),
        .conf_speed_tx                       ( usxgmii0_conf_speed_tx       ),
        .link_status                         ( usxgmii0_link_status         ),
        .conf_speed_rx_2_5                   ( usxgmii0_conf_speed_rx_2_5   ),
        .conf_speed_tx_2_5                   ( usxgmii0_conf_speed_tx_2_5   ),
        .an_busy                             ( usxgmii0_an_busy             ),
        .an_pability_done                    ( usxgmii0_an_pability_done    ),
        .an_pability                         ( usxgmii0_an_pability         )
        );

top_usxgmii64 U_USXGMII64_1 (
        .tx_clk                              ( usxgmii1_tx_clk              ),
        .rx_clk                              ( usxgmii1_rx_clk              ),
        .reset_rxclk                         ( usxgmii1_reset_rxclk         ),
        .reset_txclk                         ( usxgmii1_reset_txclk         ),
        .mrx_xgmii_clk_ena                   ( usxgmii1_mrx_xgmii_clk_ena   ),
        .mrx_xgmii_rxd                       ( usxgmii1_mrx_xgmii_rxd       ),
        .mrx_xgmii_rxc                       ( usxgmii1_mrx_xgmii_rxc       ),
        .mrx_xgmii_rxt0_next                 ( usxgmii1_mrx_xgmii_rxt0_next ),
        .mtx_xgmii_clk_ena                   ( usxgmii1_mtx_xgmii_clk_ena   ),
        .mtx_xgmii_txd                       ( usxgmii1_mtx_xgmii_txd       ),
        .mtx_xgmii_txc                       ( usxgmii1_mtx_xgmii_txc       ),
        .prx_xgmii_clk_ena                   ( usxgmii1_prx_xgmii_clk_ena   ),
        .prx_xgmii_rxd                       ( usxgmii1_prx_xgmii_rxd       ),
        .prx_xgmii_rxc                       ( usxgmii1_prx_xgmii_rxc       ),
        .prx_xgmii_rxt0_next                 ( usxgmii1_prx_xgmii_rxt0_next ),
        .ptx_xgmii_clk_ena                   ( usxgmii1_ptx_xgmii_clk_ena   ),
        .ptx_xgmii_txd                       ( usxgmii1_ptx_xgmii_txd       ),
        .ptx_xgmii_txc                       ( usxgmii1_ptx_xgmii_txc       ),
        .reset_reg_clk                       ( usxgmii1_reset_reg_clk       ),
        .reg_clk                             ( usxgmii1_reg_clk             ),
        .reg_rd                              ( usxgmii1_reg_rd              ),
        .reg_wr                              ( usxgmii1_reg_wr              ),
        .reg_addr                            ( usxgmii1_reg_addr            ),
        .reg_din                             ( usxgmii1_reg_din             ),
        .reg_dout                            ( usxgmii1_reg_dout            ),
        .reg_busy                            ( usxgmii1_reg_busy            ),
        .usxgmii_active                      ( usxgmii1_usxgmii_active      ),
        .conf_speed_rx                       ( usxgmii1_conf_speed_rx       ),
        .conf_speed_tx                       ( usxgmii1_conf_speed_tx       ),
        .link_status                         ( usxgmii1_link_status         ),
        .conf_speed_rx_2_5                   ( usxgmii1_conf_speed_rx_2_5   ),
        .conf_speed_tx_2_5                   ( usxgmii1_conf_speed_tx_2_5   ),
        .an_busy                             ( usxgmii1_an_busy             ),
        .an_pability_done                    ( usxgmii1_an_pability_done    ),
        .an_pability                         ( usxgmii1_an_pability         )
        );

top_usxgmii64 U_USXGMII64_2 (
        .tx_clk                              ( usxgmii2_tx_clk              ),
        .rx_clk                              ( usxgmii2_rx_clk              ),
        .reset_rxclk                         ( usxgmii2_reset_rxclk         ),
        .reset_txclk                         ( usxgmii2_reset_txclk         ),
        .mrx_xgmii_clk_ena                   ( usxgmii2_mrx_xgmii_clk_ena   ),
        .mrx_xgmii_rxd                       ( usxgmii2_mrx_xgmii_rxd       ),
        .mrx_xgmii_rxc                       ( usxgmii2_mrx_xgmii_rxc       ),
        .mrx_xgmii_rxt0_next                 ( usxgmii2_mrx_xgmii_rxt0_next ),
        .mtx_xgmii_clk_ena                   ( usxgmii2_mtx_xgmii_clk_ena   ),
        .mtx_xgmii_txd                       ( usxgmii2_mtx_xgmii_txd       ),
        .mtx_xgmii_txc                       ( usxgmii2_mtx_xgmii_txc       ),
        .prx_xgmii_clk_ena                   ( usxgmii2_prx_xgmii_clk_ena   ),
        .prx_xgmii_rxd                       ( usxgmii2_prx_xgmii_rxd       ),
        .prx_xgmii_rxc                       ( usxgmii2_prx_xgmii_rxc       ),
        .prx_xgmii_rxt0_next                 ( usxgmii2_prx_xgmii_rxt0_next ),
        .ptx_xgmii_clk_ena                   ( usxgmii2_ptx_xgmii_clk_ena   ),
        .ptx_xgmii_txd                       ( usxgmii2_ptx_xgmii_txd       ),
        .ptx_xgmii_txc                       ( usxgmii2_ptx_xgmii_txc       ),
        .reset_reg_clk                       ( usxgmii2_reset_reg_clk       ),
        .reg_clk                             ( usxgmii2_reg_clk             ),
        .reg_rd                              ( usxgmii2_reg_rd              ),
        .reg_wr                              ( usxgmii2_reg_wr              ),
        .reg_addr                            ( usxgmii2_reg_addr            ),
        .reg_din                             ( usxgmii2_reg_din             ),
        .reg_dout                            ( usxgmii2_reg_dout            ),
        .reg_busy                            ( usxgmii2_reg_busy            ),
        .usxgmii_active                      ( usxgmii2_usxgmii_active      ),
        .conf_speed_rx                       ( usxgmii2_conf_speed_rx       ),
        .conf_speed_tx                       ( usxgmii2_conf_speed_tx       ),
        .link_status                         ( usxgmii2_link_status         ),
        .conf_speed_rx_2_5                   ( usxgmii2_conf_speed_rx_2_5   ),
        .conf_speed_tx_2_5                   ( usxgmii2_conf_speed_tx_2_5   ),
        .an_busy                             ( usxgmii2_an_busy             ),
        .an_pability_done                    ( usxgmii2_an_pability_done    ),
        .an_pability                         ( usxgmii2_an_pability         )
        );

top_usxgmii64 U_USXGMII64_3 (
        .tx_clk                              ( usxgmii3_tx_clk              ),
        .rx_clk                              ( usxgmii3_rx_clk              ),
        .reset_rxclk                         ( usxgmii3_reset_rxclk         ),
        .reset_txclk                         ( usxgmii3_reset_txclk         ),
        .mrx_xgmii_clk_ena                   ( usxgmii3_mrx_xgmii_clk_ena   ),
        .mrx_xgmii_rxd                       ( usxgmii3_mrx_xgmii_rxd       ),
        .mrx_xgmii_rxc                       ( usxgmii3_mrx_xgmii_rxc       ),
        .mrx_xgmii_rxt0_next                 ( usxgmii3_mrx_xgmii_rxt0_next ),
        .mtx_xgmii_clk_ena                   ( usxgmii3_mtx_xgmii_clk_ena   ),
        .mtx_xgmii_txd                       ( usxgmii3_mtx_xgmii_txd       ),
        .mtx_xgmii_txc                       ( usxgmii3_mtx_xgmii_txc       ),
        .prx_xgmii_clk_ena                   ( usxgmii3_prx_xgmii_clk_ena   ),
        .prx_xgmii_rxd                       ( usxgmii3_prx_xgmii_rxd       ),
        .prx_xgmii_rxc                       ( usxgmii3_prx_xgmii_rxc       ),
        .prx_xgmii_rxt0_next                 ( usxgmii3_prx_xgmii_rxt0_next ),
        .ptx_xgmii_clk_ena                   ( usxgmii3_ptx_xgmii_clk_ena   ),
        .ptx_xgmii_txd                       ( usxgmii3_ptx_xgmii_txd       ),
        .ptx_xgmii_txc                       ( usxgmii3_ptx_xgmii_txc       ),
        .reset_reg_clk                       ( usxgmii3_reset_reg_clk       ),
        .reg_clk                             ( usxgmii3_reg_clk             ),
        .reg_rd                              ( usxgmii3_reg_rd              ),
        .reg_wr                              ( usxgmii3_reg_wr              ),
        .reg_addr                            ( usxgmii3_reg_addr            ),
        .reg_din                             ( usxgmii3_reg_din             ),
        .reg_dout                            ( usxgmii3_reg_dout            ),
        .reg_busy                            ( usxgmii3_reg_busy            ),
        .usxgmii_active                      ( usxgmii3_usxgmii_active      ),
        .conf_speed_rx                       ( usxgmii3_conf_speed_rx       ),
        .conf_speed_tx                       ( usxgmii3_conf_speed_tx       ),
        .link_status                         ( usxgmii3_link_status         ),
        .conf_speed_rx_2_5                   ( usxgmii3_conf_speed_rx_2_5   ),
        .conf_speed_tx_2_5                   ( usxgmii3_conf_speed_tx_2_5   ),
        .an_busy                             ( usxgmii3_an_busy             ),
        .an_pability_done                    ( usxgmii3_an_pability_done    ),
        .an_pability                         ( usxgmii3_an_pability         )
        );

endmodule
