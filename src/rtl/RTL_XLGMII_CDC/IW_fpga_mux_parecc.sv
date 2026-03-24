//----------------------------------------------------------------------------------------------------------------
//                               INTEL CONFIDENTIAL
//           Copyright 2013-2014 Intel Corporation All Rights Reserved. 
// 
// The source code contained or described herein and all documents related to the source code ("Material")
// are owned by Intel Corporation or its suppliers or licensors. Title to the Material remains with Intel
// Corporation or its suppliers and licensors. The Material contains trade secrets and proprietary and confidential
// information of Intel or its suppliers and licensors. The Material is protected by worldwide copyright and trade
// secret laws and treaty provisions. No part of the Material may be used, copied, reproduced, modified, published,
// uploaded, posted, transmitted, distributed, or disclosed in any way without Intel's prior express written
// permission.
// 
// No license under any patent, copyright, trade secret or other intellectual property right is granted to or
// conferred upon you by disclosure or delivery of the Materials, either expressly, by implication, inducement,
// estoppel or otherwise. Any license under such intellectual property rights must be express and approved by
// Intel in writing.
//----------------------------------------------------------------------------------------------------------------
// Version and Release Control Information:
//
// File Name:$RCSfile: IW_fpga_mux_parecc.sv.rca $
// File Revision:$
// Created by:    Balaji G
// Updated by:    $Author: balaji $ $Date: Mon Jun  1 06:38:29 2015 $
//------------------------------------------------------------------------------
// ECC generation and transmit over Muxed bus
// Module to be instanced with highesh mux clock that is used in the design with a dedicated
// Pin for transmitting the ECC over a parallel line
// The input is connected to signals which requires ECC verification
// Generally the signals which trasnmitted with highest clock ratio can be used here. 
//------------------------------------------------------------------------------


`timescale 10fs/10fs

module IW_fpga_mux_parecc #(
    parameter NUMBER_OF_256PAIRS   = 5 // Should be <= (MULTIPLEX_RATIO/10)
  , parameter MULTIPLEX_RATIO      = 52
  , parameter CLOCK_RATIO          = 28
  , parameter FPGA_FAMILY          = "S5"
  , parameter INFRA_AVST_CHNNL_W   = 8
  , parameter INFRA_AVST_DATA_W    = 8
  , parameter INFRA_AVST_CHNNL_ID  = 8
  , parameter CSR_ADDR_WIDTH       = 3*INFRA_AVST_DATA_W
  , parameter CSR_DATA_WIDTH       = 4*INFRA_AVST_DATA_W
  , parameter INSTANCE_NAME        = "u_mux_parecc"  //Can hold upto 16 ASCII characters
) (
    input                                 rst_mux_n
  , input                                 clk_mux    // Mux clock sync to clk
  , input                                 clk        // data_in is sync to this clock
  , input  [(256*NUMBER_OF_256PAIRS)-1:0] data_in
  , output                                outbus
  // Infra-Avst Ports
  , input                                 clk_avst
  , input                                 rst_avst_n
  , output                                avst_ingr_ready
  , input                                 avst_ingr_valid
  , input                                 avst_ingr_startofpacket
  , input                                 avst_ingr_endofpacket
  , input  [INFRA_AVST_CHNNL_W-1:0]       avst_ingr_channel
  , input  [INFRA_AVST_DATA_W-1:0]        avst_ingr_data

  , input                                 avst_egr_ready
  , output                                avst_egr_valid
  , output                                avst_egr_startofpacket
  , output                                avst_egr_endofpacket
  , output [INFRA_AVST_CHNNL_W-1:0]       avst_egr_channel
  , output [INFRA_AVST_DATA_W-1:0]        avst_egr_data

);

localparam wdth = 256;
localparam cbts = 10;

    reg    [(wdth*NUMBER_OF_256PAIRS)-1 : 0 ]  data_in_reg;
    wire   [(cbts*NUMBER_OF_256PAIRS)-1 : 0 ]  ecc_gen_w;
    reg    [(MULTIPLEX_RATIO*1)-1 : 0 ]        ecc_gen;
//============================================================
// Added ECC Generators and Checkers. 
// this uses the Synopsys DW_ecc designware component. may need
// to tune parameters for better error detection depending on channel 
// Note : errors are only detected, NOT corrected
//============================================================

 // Pipeline to safely break timing
 always @(posedge clk ) begin
   data_in_reg   <= data_in;
 end

 always @(* ) begin
   ecc_gen   = ecc_gen_w | {(MULTIPLEX_RATIO*1){1'b0}};
 end

 
 genvar                  ecc_i;
 generate
 
   //---------------------------------
   // ECC Code generator
   //---------------------------------
   for (ecc_i=0; ecc_i<NUMBER_OF_256PAIRS; ecc_i=ecc_i+1) begin: ecc
     DW_ecc #(.width(wdth),.chkbits(cbts),.synd_sel(0)) u_ecctx (
          //--- Inputs ---
          .gen         ( 1'b1 ),
          .correct_n   ( 1'b0 ),
          .datain      ( data_in_reg[(ecc_i*wdth) +: wdth] ),
          .chkin       ( {cbts{1'b0}}),
          //--- Outputs ---
          .err_detect  ( ),
          .err_multpl  ( ),
          .dataout     ( ),
          .chkout      ( ecc_gen_w[(ecc_i*cbts) +: cbts] ));
   end
 endgenerate

IW_fpga_mux #(
  .NUMBER_OF_OUTPUTS    (1),
  .MULTIPLEX_RATIO      (MULTIPLEX_RATIO),
  .CLOCK_RATIO          (CLOCK_RATIO),
  .FPGA_FAMILY          (FPGA_FAMILY),
  .INFRA_AVST_CHNNL_W   (INFRA_AVST_CHNNL_W),
  .INFRA_AVST_DATA_W    (INFRA_AVST_DATA_W),
  .INFRA_AVST_CHNNL_ID  (INFRA_AVST_CHNNL_ID),
  .CSR_ADDR_WIDTH       (CSR_ADDR_WIDTH),
  .CSR_DATA_WIDTH       (CSR_DATA_WIDTH),
  .INSTANCE_NAME        (INSTANCE_NAME)
) u_ecc_mux (
    .clk_mux                  (clk_mux)
  , .rst_mux_n                (rst_mux_n)
  , .inbus                    (ecc_gen)
  , .outbus                   (outbus)
  , .clk_avst                 (clk_avst)
  , .rst_avst_n               (rst_avst_n)
  , .avst_ingr_ready          (avst_ingr_ready)
  , .avst_ingr_valid          (avst_ingr_valid)
  , .avst_ingr_startofpacket  (avst_ingr_startofpacket)
  , .avst_ingr_endofpacket    (avst_ingr_endofpacket)
  , .avst_ingr_channel        (avst_ingr_channel)
  , .avst_ingr_data           (avst_ingr_data)
  , .avst_egr_ready           (avst_egr_ready)
  , .avst_egr_valid           (avst_egr_valid)
  , .avst_egr_startofpacket   (avst_egr_startofpacket)
  , .avst_egr_endofpacket     (avst_egr_endofpacket)
  , .avst_egr_channel         (avst_egr_channel)
  , .avst_egr_data            (avst_egr_data)
);

endmodule 

//------------------------------------------------------------------------------
// Change History:
//
// $Log: IW_fpga_mux_parecc.sv.rca $
// 
//  Revision: 1.1 Mon Jun  1 06:38:29 2015 balaji
//  Integrity check for parallel IO
//
//------------------------------------------------------------------------------





























