// (C) 2001-2024 Intel Corporation. All rights reserved.
// Your use of Intel Corporation's design tools, logic functions and other 
// software and tools, and its AMPP partner logic functions, and any output 
// files from any of the foregoing (including device programming or simulation 
// files), and any associated documentation or information are expressly subject 
// to the terms and conditions of the Intel Program License Subscription 
// Agreement, Intel FPGA IP License Agreement, or other applicable 
// license agreement, including, without limitation, that your use is for the 
// sole purpose of programming logic devices manufactured by Intel and sold by 
// Intel or its authorized distributors.  Please refer to the applicable 
// agreement for further details.


`timescale 1ps/1ps

module alt_xcvr_pll_embedded_debug #(
  parameter dbg_capability_reg_enable   = 0,
  parameter dbg_user_identifier         = 0,
  parameter dbg_stat_soft_logic_enable  = 0,
  parameter dbg_ctrl_soft_logic_enable  = 0,
  parameter en_master_cgb               = 0
) (
  // avmm signals
  input         avmm_clk,
  input         avmm_reset,
  input  [8:0]  avmm_address,
  input  [7:0]  avmm_writedata,
  input         avmm_write,
  input         avmm_read,
  output [7:0]  avmm_readdata,
  output        avmm_waitrequest,

  // input signals from the core
  input         in_pll_powerdown,
  input         in_pll_locked,
  input         in_pll_cal_busy,
  input         in_avmm_busy,

  // output signals to the ip
  output        out_pll_powerdown
);

wire        prbs_done_sync;
wire        csr_prbs_snapshot;
wire        csr_prbs_count_en;
wire        csr_prbs_reset;
wire [47:0] prbs_err_count;
wire [47:0] prbs_bit_count;

alt_xcvr_pll_avmm_csr #(
  .dbg_capability_reg_enable   ( dbg_capability_reg_enable ),
  .dbg_user_identifier         ( dbg_user_identifier ),
  .dbg_stat_soft_logic_enable  ( dbg_stat_soft_logic_enable ),
  .dbg_ctrl_soft_logic_enable  ( dbg_ctrl_soft_logic_enable ),
  .en_master_cgb               ( en_master_cgb)
) embedded_debug_soft_csr (
  // avmm signals
  .avmm_clk                            (avmm_clk),
  .avmm_reset                          (avmm_reset),
  .avmm_address                        (avmm_address),
  .avmm_writedata                      (avmm_writedata),
  .avmm_write                          (avmm_write),
  .avmm_read                           (avmm_read),
  .avmm_readdata                       (avmm_readdata),
  .avmm_waitrequest                    (avmm_waitrequest),

  // input status signals from the channel
  .pll_powerdown                       (in_pll_powerdown),
  .pll_locked                          (in_pll_locked),
  .pll_cal_busy                        (in_pll_cal_busy),
  .avmm_busy                           (in_avmm_busy),

  // output control signals
  .csr_pll_powerdown                   (out_pll_powerdown)
);

endmodule
`ifdef QUESTA_INTEL_OEM
`pragma questa_oem_00 "q1PpsihSbRg0dVwZoyKpf3L+LygQkRGfx8yrHPG65eRhVrnQlmVaypYeKj6GgKTpn/Gq07pm7QFGc6+RFf8dm2BohFrvSyXEOADb37gghUZ9s7ph0Btnhiq8IZd2/mzAKQ4cGuIfqa0ii7Bm0ZIIzPvhdU6dEdqEo1pmuk/0KC/XZF3/UOIf6Xwc/sk6KMjXKLUmWC7hfd/WN5grX+WFAnpfGzpIFXXXSxpWU1u4uRBUEt6Kp7T7LEnTfcu3SPYpj1svX+Id9KlRFeEu3k0nZt0SYvPr4FiVz4YcpnzMEKe+MQUX+nNMHcncq9m2ds44MerPCFr7z2lR8mLoV1Mb4EVLLjIVNgPiN18TYlDUxJWAKmV41ne5QraY80USCsZ/4vCi9M4Ckl56hqVVHbIAl1hHdJqy49cWsYfUadevmoOLAuOpTtnhSkg6+HtomwujV7u6JfqA4b2giDqZpSH7/l1P4dtD6weLTqa7U2S8uB7WHROv18ASk2Fb/WsYqkCxXQmb90ECNEykJblSovSXNFvt3pmO8xuu1W/zuG5p8R6xv99DvRM8e0wHB2vlsVmtktgi4VtSrxGxw2NLRzMxNELn3j/UCc/66+hUlteJVsBUa/3wRpxRLxXqFgvEgC7BcAQsvNjnKhk11+su6lzvUuS/BnBAg6nmQfrpA5xN7nIkc++nQ4SOfQjOJcIAjKeTNcaZvzqH9AiK8/3EydsZh8kI+GwaCD2AG3H4jC6R0qqzNYBXMYQpP4Bdg9k+UyfICDNkGdOWuvuD416ZgbyD1pvRZOqvdSX8ATnhIWphpApEfYJcjcPpEGnl8wlxw+ImoIIdNTt9FJ/JMIIZE4CtvvqOitbe4JfQ69o2NbYBo+9jlGnN+xqR7oDg5I8nq05rLvWhdVvg5z3940107H5ke4TFrM7y6eFqPRMzDfwMi1k9Y3e0oPDKM7axqXB6gMUcyKOA2FIdqXKoasFkUSDQGipuywHr7XlkP0lu8HtvxPArpp35hJ1Akt2TPES/FfT6"
`endif