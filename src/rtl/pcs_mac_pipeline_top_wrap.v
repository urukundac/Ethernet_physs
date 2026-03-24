
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
// Component Name   : pcs_mac_pipeline_top_wrap
// Component Version: 
// Release Type     : 
// Build ID         :
// Description      : pipeline register is added for MII & TSU signals between PCS & MAC for all four channels
//                    all arithmetic control signals should be maintained with respect to acutal data path signals
// ------------------------------------------------------------------------------
/////////////////////////////////////////////////////////////////////////////////

`include "common_header.verilog"

module pcs_mac_pipeline_top_wrap  #(

parameter PIPE_NUM = 4,
parameter CGDW     = 128,
parameter CGCW     = 16)
(

input             reset_mac0_ref_clk,                                     //  Active high Asynchronous Reset for MAC 0 - ref_clk Clock Domain
input             reset_mac1_ref_clk,                                     //  Active high Asynchronous Reset for MAC 1 - ref_clk Clock Domain
input             reset_mac2_ref_clk,                                     //  Active high Asynchronous Reset for MAC 2 - ref_clk Clock Domain
input             reset_mac3_ref_clk,                                     //  Active high Asynchronous Reset for MAC 3 - ref_clk Clock Domain

input             mac0_ref_clk,                                           //  MAC 0 - ref_clk Clock Domain
input             mac1_ref_clk,                                           //  MAC 1 - ref_clk Clock Domain
input             mac2_ref_clk,                                           //  MAC 2 - ref_clk Clock Domain
input             mac3_ref_clk,                                           //  MAC 3 - ref_clk Clock Domain

input             pcs0_cgmii_tx_clkena,
output [CGCW-1:0] pcs0_cgmii_tx_txc,
output [CGDW-1:0] pcs0_cgmii_tx_txd,
input  [1:0]      pcs0_cgmii_tx_tsu,
input             pcs0_cgmii_rx_clkena,
input [CGCW-1:0]  pcs0_cgmii_rx_rxc,
input [CGDW-1:0]  pcs0_cgmii_rx_rxd,
input [1:0]       pcs0_cgmii_rx_tsu,
input [1:0]       pcs0_cgmii_tsu_rx_sd, 
output            mac0_cgmii_tx_clkena,
input [CGCW-1:0]  mac0_cgmii_tx_txc,
input [CGDW-1:0]  mac0_cgmii_tx_txd,
output            mac0_cgmii_rx_clkena,
output [CGCW-1:0] mac0_cgmii_rx_rxc,
output [CGDW-1:0] mac0_cgmii_rx_rxd,
output            tsu0_cgmii_tx_clkena,
output [1:0]      tsu0_cgmii_tx_tsu,
output            tsu0_cgmii_rx_clkena,
output [1:0]      tsu0_cgmii_rx_tsu,
output [1:0]      tsu0_cgmii_rx_sd,

input             pcs0_xlgmii_tx_clkena,
output [7:0]      pcs0_xlgmii_tx_txc,
output [63:0]     pcs0_xlgmii_tx_txd,
input  [1:0]      pcs0_xlgmii_tx_tsu,
input             pcs0_xlgmii_rx_clkena,
input [7:0]       pcs0_xlgmii_rx_rxc,
input [63:0]      pcs0_xlgmii_rx_rxd,
input             pcs0_xlgmii_rxt0_next,
input [1:0]       pcs0_xlgmii_rx_tsu,
input [1:0]       pcs0_xlgmii_tsu_rx_sd,
output            mac0_xlgmii_tx_clkena,
input [7:0]       mac0_xlgmii_tx_txc,
input [63:0]      mac0_xlgmii_tx_txd,
output            mac0_xlgmii_rx_clkena,
output [7:0]      mac0_xlgmii_rx_rxc,
output [63:0]     mac0_xlgmii_rx_rxd,
output            mac0_xlgmii_rxt0_next,
output            tsu0_xlgmii_tx_clkena,
output [1:0]      tsu0_xlgmii_tx_tsu,
output            tsu0_xlgmii_rx_clkena,
output [1:0]      tsu0_xlgmii_rx_tsu,
output [1:0]      tsu0_xlgmii_rx_sd,

input             pcs1_cgmii_tx_clkena,
output [CGCW-1:0] pcs1_cgmii_tx_txc,
output [CGDW-1:0] pcs1_cgmii_tx_txd,
input  [1:0]      pcs1_cgmii_tx_tsu,
input             pcs1_cgmii_rx_clkena,
input [CGCW-1:0]  pcs1_cgmii_rx_rxc,
input [CGDW-1:0]  pcs1_cgmii_rx_rxd,
input [1:0]       pcs1_cgmii_rx_tsu,
input [1:0]       pcs1_cgmii_tsu_rx_sd,
output            mac1_cgmii_tx_clkena,
input [CGCW-1:0]  mac1_cgmii_tx_txc,
input [CGDW-1:0]  mac1_cgmii_tx_txd,
output            mac1_cgmii_rx_clkena,
output [CGCW-1:0] mac1_cgmii_rx_rxc,
output [CGDW-1:0] mac1_cgmii_rx_rxd,
output            tsu1_cgmii_tx_clkena,
output [1:0]      tsu1_cgmii_tx_tsu,
output            tsu1_cgmii_rx_clkena,
output [1:0]      tsu1_cgmii_rx_tsu,
output [1:0]      tsu1_cgmii_rx_sd,

input             pcs1_xlgmii_tx_clkena,
output [7:0]      pcs1_xlgmii_tx_txc,
output [63:0]     pcs1_xlgmii_tx_txd,
input  [1:0]      pcs1_xlgmii_tx_tsu,
input             pcs1_xlgmii_rx_clkena,
input [7:0]       pcs1_xlgmii_rx_rxc,
input [63:0]      pcs1_xlgmii_rx_rxd,
input             pcs1_xlgmii_rxt0_next,
input [1:0]       pcs1_xlgmii_rx_tsu,
input [1:0]       pcs1_xlgmii_tsu_rx_sd,
output            mac1_xlgmii_tx_clkena,
input [7:0]       mac1_xlgmii_tx_txc,
input [63:0]      mac1_xlgmii_tx_txd,
output            mac1_xlgmii_rx_clkena,
output [7:0]      mac1_xlgmii_rx_rxc,
output [63:0]     mac1_xlgmii_rx_rxd,
output            mac1_xlgmii_rxt0_next,
output            tsu1_xlgmii_tx_clkena,
output [1:0]      tsu1_xlgmii_tx_tsu,
output            tsu1_xlgmii_rx_clkena,
output [1:0]      tsu1_xlgmii_rx_tsu,
output [1:0]      tsu1_xlgmii_rx_sd,

input             pcs2_cgmii_tx_clkena,
output [CGCW-1:0] pcs2_cgmii_tx_txc,
output [CGDW-1:0] pcs2_cgmii_tx_txd,
input  [1:0]      pcs2_cgmii_tx_tsu,
input             pcs2_cgmii_rx_clkena,
input [CGCW-1:0]  pcs2_cgmii_rx_rxc,
input [CGDW-1:0]  pcs2_cgmii_rx_rxd,
input [1:0]       pcs2_cgmii_rx_tsu,
input [1:0]       pcs2_cgmii_tsu_rx_sd,
output            mac2_cgmii_tx_clkena,
input [CGCW-1:0]  mac2_cgmii_tx_txc,
input [CGDW-1:0]  mac2_cgmii_tx_txd,
output            mac2_cgmii_rx_clkena,
output [CGCW-1:0] mac2_cgmii_rx_rxc,
output [CGDW-1:0] mac2_cgmii_rx_rxd,
output            tsu2_cgmii_tx_clkena,
output [1:0]      tsu2_cgmii_tx_tsu,
output            tsu2_cgmii_rx_clkena,
output [1:0]      tsu2_cgmii_rx_tsu,
output [1:0]      tsu2_cgmii_rx_sd,

input             pcs2_xlgmii_tx_clkena,
output [7:0]      pcs2_xlgmii_tx_txc,
output [63:0]     pcs2_xlgmii_tx_txd,
input  [1:0]      pcs2_xlgmii_tx_tsu,
input             pcs2_xlgmii_rx_clkena,
input [7:0]       pcs2_xlgmii_rx_rxc,
input [63:0]      pcs2_xlgmii_rx_rxd,
input             pcs2_xlgmii_rxt0_next,
input [1:0]       pcs2_xlgmii_rx_tsu,
input [1:0]       pcs2_xlgmii_tsu_rx_sd,
output            mac2_xlgmii_tx_clkena,
input [7:0]       mac2_xlgmii_tx_txc,
input [63:0]      mac2_xlgmii_tx_txd,
output            mac2_xlgmii_rx_clkena,
output [7:0]      mac2_xlgmii_rx_rxc,
output [63:0]     mac2_xlgmii_rx_rxd,
output            mac2_xlgmii_rxt0_next,
output            tsu2_xlgmii_tx_clkena,
output [1:0]      tsu2_xlgmii_tx_tsu,
output            tsu2_xlgmii_rx_clkena,
output [1:0]      tsu2_xlgmii_rx_tsu,
output [1:0]      tsu2_xlgmii_rx_sd,

input             pcs3_cgmii_tx_clkena,
output [CGCW-1:0] pcs3_cgmii_tx_txc,
output [CGDW-1:0] pcs3_cgmii_tx_txd,
input  [1:0]      pcs3_cgmii_tx_tsu,
input             pcs3_cgmii_rx_clkena,
input [CGCW-1:0]  pcs3_cgmii_rx_rxc,
input [CGDW-1:0]  pcs3_cgmii_rx_rxd,
input [1:0]       pcs3_cgmii_rx_tsu,
input [1:0]       pcs3_cgmii_tsu_rx_sd,
output            mac3_cgmii_tx_clkena,
input [CGCW-1:0]  mac3_cgmii_tx_txc,
input [CGDW-1:0]  mac3_cgmii_tx_txd,
output            mac3_cgmii_rx_clkena,
output [CGCW-1:0] mac3_cgmii_rx_rxc,
output [CGDW-1:0] mac3_cgmii_rx_rxd,
output            tsu3_cgmii_tx_clkena,
output [1:0]      tsu3_cgmii_tx_tsu,
output            tsu3_cgmii_rx_clkena,
output [1:0]      tsu3_cgmii_rx_tsu,
output [1:0]      tsu3_cgmii_rx_sd,

input             pcs3_xlgmii_tx_clkena,
output [7:0]      pcs3_xlgmii_tx_txc,
output [63:0]     pcs3_xlgmii_tx_txd,
input  [1:0]      pcs3_xlgmii_tx_tsu,
input             pcs3_xlgmii_rx_clkena,
input [7:0]       pcs3_xlgmii_rx_rxc,
input [63:0]      pcs3_xlgmii_rx_rxd,
input             pcs3_xlgmii_rxt0_next,
input [1:0]       pcs3_xlgmii_rx_tsu,
input [1:0]       pcs3_xlgmii_tsu_rx_sd,
output            mac3_xlgmii_tx_clkena,
input [7:0]       mac3_xlgmii_tx_txc,
input [63:0]      mac3_xlgmii_tx_txd,
output            mac3_xlgmii_rx_clkena,
output [7:0]      mac3_xlgmii_rx_rxc,
output [63:0]     mac3_xlgmii_rx_rxd,
output            mac3_xlgmii_rxt0_next,
output            tsu3_xlgmii_tx_clkena,
output [1:0]      tsu3_xlgmii_tx_tsu,
output            tsu3_xlgmii_rx_clkena,
output [1:0]      tsu3_xlgmii_rx_tsu,
output [1:0]      tsu3_xlgmii_rx_sd

);

wire pcs0_xlgmii_tx_txc_nc;
wire pcs1_xlgmii_tx_txc_nc;
wire pcs2_xlgmii_tx_txc_nc;
wire pcs3_xlgmii_tx_txc_nc;

pcs_mac_pipeline_top  #(
.PIPE_NUM (PIPE_NUM),
.CGDW     (CGDW),
.CGCW     (CGCW)
) U0_PIPE_CGMII (
//.reset             (reset_mac0_ref_clk   ),
//.clk               (mac0_ref_clk         ),
.pcs_mii_tx_clkena (pcs0_cgmii_tx_clkena ),
.pcs_mii_tx_txc    (pcs0_cgmii_tx_txc    ),
.pcs_mii_tx_txd    (pcs0_cgmii_tx_txd    ),
.pcs_mii_tx_tsu    (pcs0_cgmii_tx_tsu    ),
.pcs_mii_rx_clkena (pcs0_cgmii_rx_clkena ),
.pcs_mii_rx_ctrl   (pcs0_cgmii_rx_rxc    ),
.pcs_mii_rx_rxd    (pcs0_cgmii_rx_rxd    ),
.pcs_mii_rx_tsu    (pcs0_cgmii_rx_tsu    ),
.pcs_tsu_rx_sd     (pcs0_cgmii_tsu_rx_sd ), 
.mac_mii_tx_clkena (mac0_cgmii_tx_clkena ),
.mac_mii_tx_txc    (mac0_cgmii_tx_txc    ),
.mac_mii_tx_txd    (mac0_cgmii_tx_txd    ),
.mac_mii_rx_clkena (mac0_cgmii_rx_clkena ),
.mac_mii_rx_ctrl   (mac0_cgmii_rx_rxc    ),
.mac_mii_rx_rxd    (mac0_cgmii_rx_rxd    ),
.tsu_mii_tx_clkena (tsu0_cgmii_tx_clkena ),
.tsu_mii_tx_tsu    (tsu0_cgmii_tx_tsu    ),
.tsu_mii_rx_clkena (tsu0_cgmii_rx_clkena ),
.tsu_mii_rx_tsu    (tsu0_cgmii_rx_tsu    ),
.tsu_mii_rx_sd     (tsu0_cgmii_rx_sd     ));


pcs_mac_pipeline_top  #(
.PIPE_NUM (PIPE_NUM),
.CGDW     (CGDW),
.CGCW     (CGCW)
) U1_PIPE_CGMII (
//.reset             (reset_mac1_ref_clk   ),
//.clk               (mac1_ref_clk         ),
.pcs_mii_tx_clkena (pcs1_cgmii_tx_clkena ),
.pcs_mii_tx_txc    (pcs1_cgmii_tx_txc    ),
.pcs_mii_tx_txd    (pcs1_cgmii_tx_txd    ),
.pcs_mii_tx_tsu    (pcs1_cgmii_tx_tsu    ),
.pcs_mii_rx_clkena (pcs1_cgmii_rx_clkena ),
.pcs_mii_rx_ctrl   (pcs1_cgmii_rx_rxc    ),
.pcs_mii_rx_rxd    (pcs1_cgmii_rx_rxd    ),
.pcs_mii_rx_tsu    (pcs1_cgmii_rx_tsu    ),
.pcs_tsu_rx_sd     (pcs1_cgmii_tsu_rx_sd ), 
.mac_mii_tx_clkena (mac1_cgmii_tx_clkena ),
.mac_mii_tx_txc    (mac1_cgmii_tx_txc    ),
.mac_mii_tx_txd    (mac1_cgmii_tx_txd    ),
.mac_mii_rx_clkena (mac1_cgmii_rx_clkena ),
.mac_mii_rx_ctrl   (mac1_cgmii_rx_rxc    ),
.mac_mii_rx_rxd    (mac1_cgmii_rx_rxd    ),
.tsu_mii_tx_clkena (tsu1_cgmii_tx_clkena ),
.tsu_mii_tx_tsu    (tsu1_cgmii_tx_tsu    ),
.tsu_mii_rx_clkena (tsu1_cgmii_rx_clkena ),
.tsu_mii_rx_tsu    (tsu1_cgmii_rx_tsu    ),
.tsu_mii_rx_sd     (tsu1_cgmii_rx_sd     ));


pcs_mac_pipeline_top  #(
.PIPE_NUM (PIPE_NUM),
.CGDW     (CGDW),
.CGCW     (CGCW)
) U2_PIPE_CGMII (
//.reset             (reset_mac2_ref_clk   ),
//.clk               (mac2_ref_clk         ),
.pcs_mii_tx_clkena (pcs2_cgmii_tx_clkena ),
.pcs_mii_tx_txc    (pcs2_cgmii_tx_txc    ),
.pcs_mii_tx_txd    (pcs2_cgmii_tx_txd    ),
.pcs_mii_tx_tsu    (pcs2_cgmii_tx_tsu    ),
.pcs_mii_rx_clkena (pcs2_cgmii_rx_clkena ),
.pcs_mii_rx_ctrl   (pcs2_cgmii_rx_rxc    ),
.pcs_mii_rx_rxd    (pcs2_cgmii_rx_rxd    ),
.pcs_mii_rx_tsu    (pcs2_cgmii_rx_tsu    ),
.pcs_tsu_rx_sd     (pcs2_cgmii_tsu_rx_sd ), 
.mac_mii_tx_clkena (mac2_cgmii_tx_clkena ),
.mac_mii_tx_txc    (mac2_cgmii_tx_txc    ),
.mac_mii_tx_txd    (mac2_cgmii_tx_txd    ),
.mac_mii_rx_clkena (mac2_cgmii_rx_clkena ),
.mac_mii_rx_ctrl   (mac2_cgmii_rx_rxc    ),
.mac_mii_rx_rxd    (mac2_cgmii_rx_rxd    ),
.tsu_mii_tx_clkena (tsu2_cgmii_tx_clkena ),
.tsu_mii_tx_tsu    (tsu2_cgmii_tx_tsu    ),
.tsu_mii_rx_clkena (tsu2_cgmii_rx_clkena ),
.tsu_mii_rx_tsu    (tsu2_cgmii_rx_tsu    ),
.tsu_mii_rx_sd     (tsu2_cgmii_rx_sd     ));

pcs_mac_pipeline_top  #(
.PIPE_NUM (PIPE_NUM),
.CGDW     (CGDW),
.CGCW     (CGCW)
) U3_PIPE_CGMII (
//.reset             (reset_mac3_ref_clk   ),
//.clk               (mac3_ref_clk         ),
.pcs_mii_tx_clkena (pcs3_cgmii_tx_clkena ),
.pcs_mii_tx_txc    (pcs3_cgmii_tx_txc    ),
.pcs_mii_tx_txd    (pcs3_cgmii_tx_txd    ),
.pcs_mii_tx_tsu    (pcs3_cgmii_tx_tsu    ),
.pcs_mii_rx_clkena (pcs3_cgmii_rx_clkena ),
.pcs_mii_rx_ctrl   (pcs3_cgmii_rx_rxc    ),
.pcs_mii_rx_rxd    (pcs3_cgmii_rx_rxd    ),
.pcs_mii_rx_tsu    (pcs3_cgmii_rx_tsu    ),
.pcs_tsu_rx_sd     (pcs3_cgmii_tsu_rx_sd ), 
.mac_mii_tx_clkena (mac3_cgmii_tx_clkena ),
.mac_mii_tx_txc    (mac3_cgmii_tx_txc    ),
.mac_mii_tx_txd    (mac3_cgmii_tx_txd    ),
.mac_mii_rx_clkena (mac3_cgmii_rx_clkena ),
.mac_mii_rx_ctrl   (mac3_cgmii_rx_rxc    ),
.mac_mii_rx_rxd    (mac3_cgmii_rx_rxd    ),
.tsu_mii_tx_clkena (tsu3_cgmii_tx_clkena ),
.tsu_mii_tx_tsu    (tsu3_cgmii_tx_tsu    ),
.tsu_mii_rx_clkena (tsu3_cgmii_rx_clkena ),
.tsu_mii_rx_tsu    (tsu3_cgmii_rx_tsu    ),
.tsu_mii_rx_sd     (tsu3_cgmii_rx_sd     ));



pcs_mac_pipeline_top  #(
.PIPE_NUM (PIPE_NUM),
.CGDW     (64),
.CGCW     (8+1)
) U0_PIPE_XLGMII (
//.reset             (reset_mac0_ref_clk    ),
//.clk               (mac0_ref_clk          ),
.pcs_mii_tx_clkena (pcs0_xlgmii_tx_clkena ),
.pcs_mii_tx_txc    ({pcs0_xlgmii_tx_txc_nc, pcs0_xlgmii_tx_txc}    ),
.pcs_mii_tx_txd    (pcs0_xlgmii_tx_txd    ),
.pcs_mii_tx_tsu    (pcs0_xlgmii_tx_tsu    ),
.pcs_mii_rx_clkena (pcs0_xlgmii_rx_clkena ),
.pcs_mii_rx_ctrl   ({pcs0_xlgmii_rx_rxc,pcs0_xlgmii_rxt0_next}    ),
.pcs_mii_rx_rxd    (pcs0_xlgmii_rx_rxd    ),
.pcs_mii_rx_tsu    (pcs0_xlgmii_rx_tsu    ),
.pcs_tsu_rx_sd     (pcs0_xlgmii_tsu_rx_sd ), 
.mac_mii_tx_clkena (mac0_xlgmii_tx_clkena ),
.mac_mii_tx_txc    ({1'b0, mac0_xlgmii_tx_txc}    ),
.mac_mii_tx_txd    (mac0_xlgmii_tx_txd    ),
.mac_mii_rx_clkena (mac0_xlgmii_rx_clkena ),
.mac_mii_rx_ctrl   ({mac0_xlgmii_rx_rxc,mac0_xlgmii_rxt0_next}    ),
.mac_mii_rx_rxd    (mac0_xlgmii_rx_rxd    ),
.tsu_mii_tx_clkena (tsu0_xlgmii_tx_clkena    ),
.tsu_mii_tx_tsu    (tsu0_xlgmii_tx_tsu       ),
.tsu_mii_rx_clkena (tsu0_xlgmii_rx_clkena    ),
.tsu_mii_rx_tsu    (tsu0_xlgmii_rx_tsu       ),
.tsu_mii_rx_sd     (tsu0_xlgmii_rx_sd        ));


pcs_mac_pipeline_top  #(
.PIPE_NUM (PIPE_NUM),
.CGDW     (64),
.CGCW     (8+1)
) U1_PIPE_XLGMII (
//.reset             (reset_mac1_ref_clk    ),
//.clk               (mac1_ref_clk          ),
.pcs_mii_tx_clkena (pcs1_xlgmii_tx_clkena ),
.pcs_mii_tx_txc    ({pcs1_xlgmii_tx_txc_nc, pcs1_xlgmii_tx_txc}    ),
.pcs_mii_tx_txd    (pcs1_xlgmii_tx_txd    ),
.pcs_mii_tx_tsu    (pcs1_xlgmii_tx_tsu    ),
.pcs_mii_rx_clkena (pcs1_xlgmii_rx_clkena ),
.pcs_mii_rx_ctrl   ({pcs1_xlgmii_rx_rxc,pcs1_xlgmii_rxt0_next}   ),
.pcs_mii_rx_rxd    (pcs1_xlgmii_rx_rxd    ),
.pcs_mii_rx_tsu    (pcs1_xlgmii_rx_tsu    ),
.pcs_tsu_rx_sd     (pcs1_xlgmii_tsu_rx_sd ), 
.mac_mii_tx_clkena (mac1_xlgmii_tx_clkena ),
.mac_mii_tx_txc    ({1'b0, mac1_xlgmii_tx_txc}    ),
.mac_mii_tx_txd    (mac1_xlgmii_tx_txd    ),
.mac_mii_rx_clkena (mac1_xlgmii_rx_clkena ),
.mac_mii_rx_ctrl   ({mac1_xlgmii_rx_rxc,mac1_xlgmii_rxt0_next}    ),
.mac_mii_rx_rxd    (mac1_xlgmii_rx_rxd    ),
.tsu_mii_tx_clkena (tsu1_xlgmii_tx_clkena    ),
.tsu_mii_tx_tsu    (tsu1_xlgmii_tx_tsu       ),
.tsu_mii_rx_clkena (tsu1_xlgmii_rx_clkena    ),
.tsu_mii_rx_tsu    (tsu1_xlgmii_rx_tsu       ),
.tsu_mii_rx_sd     (tsu1_xlgmii_rx_sd        ));


pcs_mac_pipeline_top  #(
.PIPE_NUM (PIPE_NUM),
.CGDW     (64),
.CGCW     (8+1)
) U2_PIPE_XLGMII (
//.reset             (reset_mac2_ref_clk    ),
//.clk               (mac2_ref_clk          ),
.pcs_mii_tx_clkena (pcs2_xlgmii_tx_clkena ),
.pcs_mii_tx_txc    ({pcs2_xlgmii_tx_txc_nc, pcs2_xlgmii_tx_txc}    ),
.pcs_mii_tx_txd    (pcs2_xlgmii_tx_txd    ),
.pcs_mii_tx_tsu    (pcs2_xlgmii_tx_tsu    ),
.pcs_mii_rx_clkena (pcs2_xlgmii_rx_clkena ),
.pcs_mii_rx_ctrl   ({pcs2_xlgmii_rx_rxc,pcs2_xlgmii_rxt0_next}    ),
.pcs_mii_rx_rxd    (pcs2_xlgmii_rx_rxd    ),
.pcs_mii_rx_tsu    (pcs2_xlgmii_rx_tsu    ),
.pcs_tsu_rx_sd     (pcs2_xlgmii_tsu_rx_sd ), 
.mac_mii_tx_clkena (mac2_xlgmii_tx_clkena ),
.mac_mii_tx_txc    ({1'b0, mac2_xlgmii_tx_txc}    ),
.mac_mii_tx_txd    (mac2_xlgmii_tx_txd    ),
.mac_mii_rx_clkena (mac2_xlgmii_rx_clkena ),
.mac_mii_rx_ctrl   ({mac2_xlgmii_rx_rxc,mac2_xlgmii_rxt0_next}    ),
.mac_mii_rx_rxd    (mac2_xlgmii_rx_rxd    ),
.tsu_mii_tx_clkena (tsu2_xlgmii_tx_clkena    ),
.tsu_mii_tx_tsu    (tsu2_xlgmii_tx_tsu       ),
.tsu_mii_rx_clkena (tsu2_xlgmii_rx_clkena    ),
.tsu_mii_rx_tsu    (tsu2_xlgmii_rx_tsu       ),
.tsu_mii_rx_sd     (tsu2_xlgmii_rx_sd        ));

pcs_mac_pipeline_top  #(
.PIPE_NUM (PIPE_NUM),
.CGDW     (64),
.CGCW     (8+1)      
) U3_PIPE_XLGMII (
//.reset             (reset_mac3_ref_clk    ),
//.clk               (mac3_ref_clk          ),
.pcs_mii_tx_clkena (pcs3_xlgmii_tx_clkena ),
.pcs_mii_tx_txc    ({pcs3_xlgmii_tx_txc_nc, pcs3_xlgmii_tx_txc}    ),
.pcs_mii_tx_txd    (pcs3_xlgmii_tx_txd    ),
.pcs_mii_tx_tsu    (pcs3_xlgmii_tx_tsu    ),
.pcs_mii_rx_clkena (pcs3_xlgmii_rx_clkena ),
.pcs_mii_rx_ctrl   ({pcs3_xlgmii_rx_rxc,pcs3_xlgmii_rxt0_next}    ),
.pcs_mii_rx_rxd    (pcs3_xlgmii_rx_rxd    ),
.pcs_mii_rx_tsu    (pcs3_xlgmii_rx_tsu    ),
.pcs_tsu_rx_sd     (pcs3_xlgmii_tsu_rx_sd ), 
.mac_mii_tx_clkena (mac3_xlgmii_tx_clkena ),
.mac_mii_tx_txc    ({1'b0, mac3_xlgmii_tx_txc}    ),
.mac_mii_tx_txd    (mac3_xlgmii_tx_txd    ),
.mac_mii_rx_clkena (mac3_xlgmii_rx_clkena ),
.mac_mii_rx_ctrl   ({mac3_xlgmii_rx_rxc,mac3_xlgmii_rxt0_next}    ),
.mac_mii_rx_rxd    (mac3_xlgmii_rx_rxd    ),
.tsu_mii_tx_clkena (tsu3_xlgmii_tx_clkena    ),
.tsu_mii_tx_tsu    (tsu3_xlgmii_tx_tsu       ),
.tsu_mii_rx_clkena (tsu3_xlgmii_rx_clkena    ),
.tsu_mii_rx_tsu    (tsu3_xlgmii_rx_tsu       ),
.tsu_mii_rx_sd     (tsu3_xlgmii_rx_sd        ));



endmodule
