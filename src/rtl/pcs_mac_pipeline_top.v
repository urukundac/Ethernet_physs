// ------------------------------------------------------------------------------
//
// Copyright 2014 - 2024 Synopsys, INC.
//
// This Synopsys IP and all associated documentation are proprietary to
// Synopsys, Inc. and may only be used pursuant to the terms and conditions of a
// written license agreement with Synopsys, Inc. All other use, reproduction,
// modification, or distribution of the Synopsys IP or the associated
// documentation is strictly prohibited.
// Inclusivity & Diversity - Read the Synopsys Statement on Inclusivity and Diversity at.
// https://solvnetplus.synopsys.com/s/article/Synopsys-Statement-on-Inclusivity-and-Diversity
//
// Component Name   : pcs_mac_pipeline_top
// Component Version: 
// Release Type     : 
// Build ID         :
// Description      : Pipeline register is added for TX/RX MII & TSU signals between PCS & MAC.  
//                    All arithmetic control signals should be maintained with respect to acutal data path signals
// ------------------------------------------------------------------------------

`include "common_header.verilog"

module pcs_mac_pipeline_top  #(

parameter PIPE_NUM = 4,
parameter CGDW     = 128,
parameter CGCW     = 16)
(

input             reset, 
input             clk,
// PCS TX Interface
input             pcs_mii_tx_clkena,   // PCS MII Transmit Clock Enable
output [CGCW-1:0] pcs_mii_tx_txc,      // PCS MII Transmit Control
output [CGDW-1:0] pcs_mii_tx_txd,      // PCS MII Transmit Data
input  [1:0]      pcs_mii_tx_tsu,      // PCS bit0: 1, bs start or start of the conter 33
                                       //     bit1: 1, am start 
// PCS RX Interface
input             pcs_mii_rx_clkena,   // PCS MII Receive Clock Enable
input [CGCW-1:0]  pcs_mii_rx_ctrl,     // PCS MII Rx control includes CGMII  - pcs_mii_rx_rxc,
                                       //                             XLGMII - pcs_mii_rx_rxc & pcs_mii_rxt0_next
input [CGDW-1:0]  pcs_mii_rx_rxd,      // PCS MII Receive Data 
input [1:0]       pcs_mii_rx_tsu,      // PCS MII Receive TSU ([1]AM, [0]CW/Cycle-start)
input [1:0]       pcs_tsu_rx_sd,       // Timestamp on serdes interface


// MAC TX Interface
output            mac_mii_tx_clkena,   // MAC MII Transmit Clock Enable
input [CGCW-1:0]  mac_mii_tx_txc,      // MAC MII Transmit Control
input [CGDW-1:0]  mac_mii_tx_txd,      // MAC MII Transmit Data
// MAC RX Interface
output            mac_mii_rx_clkena,   // MAC MII Receive Clock Enable
output [CGCW-1:0] mac_mii_rx_ctrl,     // MAC Rx control includes CGMII  - mac_mii_rx_rxc
                                       //                         XLGMII - mac_mii_rx_rxc & mac_mii_rxt0_next
output [CGDW-1:0] mac_mii_rx_rxd,      // Timestamp on serdes interface

// Timestamping arithmetic
output            tsu_mii_tx_clkena,   // TSU MII Transmit Clock Enable
output [1:0]      tsu_mii_tx_tsu,      // TSU bit0: 1, bs start or start of the conter 33
                                       //     bit1: 1, am start
// Timestamping arithmetic
output            tsu_mii_rx_clkena,   // TSU MII Receive Clock Enable
output [1:0]      tsu_mii_rx_tsu,      // TSU MII Receive TSU ([1]AM, [0]CW/Cycle-start)
output [1:0]      tsu_mii_rx_sd        // Timestamp on serdes interface

);
logic clock;
logic rst; //TBD

pcs_mac_pipeline_tx  #(

.PIPE_NUM(PIPE_NUM),  // Number of pipeline stages
.CGDW    (CGDW),      // MII Data Width
.CGCW    (CGCW)       // MII Control Width
) U_PCSMAC_PIPE_TX(
.reset                (rst               ),
.clk                  (clock                 ),
// PCS TX Interface
.pcs_mii_tx_clkena    (pcs_mii_tx_clkena   ),
.pcs_mii_tx_txc       (pcs_mii_tx_txc      ),
.pcs_mii_tx_txd       (pcs_mii_tx_txd      ),
.pcs_mii_tx_tsu       (pcs_mii_tx_tsu      ),
// MAC TX Interface
.mac_mii_tx_clkena    (mac_mii_tx_clkena   ),
.mac_mii_tx_txc       (mac_mii_tx_txc      ),
.mac_mii_tx_txd       (mac_mii_tx_txd      ),
// Timestamping arithmetic                 
.tsu_mii_tx_clkena    (tsu_mii_tx_clkena   ),
.tsu_mii_tx_tsu       (tsu_mii_tx_tsu      )
);


pcs_mac_pipeline_rx  #(
.PIPE_NUM(PIPE_NUM),  // Number of pipeline stages
.CGDW    (CGDW),      // MII Data Width
.CGCW    (CGCW)       // MII Control Width 
) U_PCSMAC_PIPE_RX (
.reset                 (rst),
.clk                   (clock),
// PCS RX Interface
.pcs_mii_rx_clkena     (pcs_mii_rx_clkena ),
.pcs_mii_rx_ctrl       (pcs_mii_rx_ctrl   ),
.pcs_mii_rx_rxd        (pcs_mii_rx_rxd    ),
.pcs_mii_rx_tsu        (pcs_mii_rx_tsu    ),
.pcs_tsu_rx_sd         (pcs_tsu_rx_sd     ), 
// MAC RX Interface
.mac_mii_rx_clkena     (mac_mii_rx_clkena ),
.mac_mii_rx_ctrl       (mac_mii_rx_ctrl   ),
.mac_mii_rx_rxd        (mac_mii_rx_rxd    ),
// Timestamping arithmetic
.tsu_mii_rx_clkena     (tsu_mii_rx_clkena ),
.tsu_mii_rx_tsu        (tsu_mii_rx_tsu    ),
.tsu_mii_rx_sd         (tsu_mii_rx_sd     )
);


endmodule
