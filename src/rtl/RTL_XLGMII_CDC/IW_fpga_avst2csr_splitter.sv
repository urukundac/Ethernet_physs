//------------------------------------------------------------------------------
//                               INTEL CONFIDENTIAL
//           Copyright 2013-2014 Intel Corporation All Rights Reserved. 
// 
// The source code contained or described herein and all documents related
// to the source code ("Material") are owned by Intel Corporation or its 
// suppliers or licensors. Title to the Material remains with Intel
// Corporation or its suppliers and licensors. The Material contains trade
// secrets and proprietary and confidential information of Intel or its 
// suppliers and licensors. The Material is protected by worldwide copyright
// and trade secret laws and treaty provisions. No part of the Material 
// may be used, copied, reproduced, modified, published, uploaded, posted,
// transmitted, distributed, or disclosed in any way without Intel's prior
// express written permission.
// 
// No license under any patent, copyright, trade secret or other intellectual
// property right is granted to or conferred upon you by disclosure or delivery
// of the Materials, either expressly, by implication, inducement, estoppel or
// otherwise. Any license under such intellectual property rights must be
// express and approved by Intel in writing.
//------------------------------------------------------------------------------

/*
 --------------------------------------------------------------------------
 -- Project Code      : IMPrES
 -- Module Name       : IW_fpga_avst2csr_splitter
 -- Author            : Vikas Akalwadi
 -- Associated modules:  
 -- Function          : Straming to CSR interface through splitter
 --------------------------------------------------------------------------
*/

`timescale 1ns / 10ps

module IW_fpga_avst2csr_splitter #(
    parameter INFRA_AVST_CHNNL_ID             = 0
  , parameter INFRA_AVST_CHNNL_W              = 8
  , parameter AVST_SYMBOL_WIDTH               = 8
  , parameter INFRA_AVST_DATA_W               = 1*AVST_SYMBOL_WIDTH
  , parameter CSR_ADDR_WIDTH                  = 3*AVST_SYMBOL_WIDTH
  , parameter CSR_DATA_WIDTH                  = 4*AVST_SYMBOL_WIDTH
  
  , parameter NUM_CSR_SUBMODULES              = 1
  , parameter CSR_SUBMODULE_DATA_WIDTH        = 32
  , parameter CSR_SUBMODULE_ADDR_WIDTH        = 16

  , parameter PIPELINE_REQS                   = 0
  , parameter PIPELINE_RSPS                   = 0
  /* Do not modify */
  , parameter CMD_WIDTH                       = 1*AVST_SYMBOL_WIDTH
) (
    input    logic                                  clk_avst
  , input    logic                                  rst_avst_n

  , output   logic                                  avst_ingr_ready
  , input    logic                                  avst_ingr_valid
  , input    logic                                  avst_ingr_startofpacket
  , input    logic                                  avst_ingr_endofpacket
  , input    logic  [INFRA_AVST_CHNNL_W-1:0]        avst_ingr_channel
  , input    logic  [INFRA_AVST_DATA_W-1:0]         avst_ingr_data

  , input    logic                                  avst_egr_ready
  , output   logic                                  avst_egr_valid
  , output   logic                                  avst_egr_startofpacket
  , output   logic                                  avst_egr_endofpacket
  , output   logic  [INFRA_AVST_CHNNL_W-1:0]        avst_egr_channel
  , output   logic  [INFRA_AVST_DATA_W-1:0]         avst_egr_data

  , input   logic                                   clk_csr
  , input   logic                                   rst_csr_n

  //Split CSR Bus
  , output  logic   [NUM_CSR_SUBMODULES-1:0]        csr_submodule_write
  , output  logic   [NUM_CSR_SUBMODULES-1:0]        csr_submodule_read
  , output  logic   [CSR_SUBMODULE_ADDR_WIDTH-1:0]  csr_submodule_addr     [NUM_CSR_SUBMODULES-1:0]
  , output  logic   [CSR_SUBMODULE_DATA_WIDTH-1:0]  csr_submodule_wr_data  [NUM_CSR_SUBMODULES-1:0]
  , input   logic   [CSR_SUBMODULE_DATA_WIDTH-1:0]  csr_submodule_rd_data  [NUM_CSR_SUBMODULES-1:0]
  , input   logic   [NUM_CSR_SUBMODULES-1:0]        csr_submodule_rd_valid
);

  logic                             csr_write;
  logic                             csr_read;
  logic [CSR_ADDR_WIDTH-1:0]        csr_addr;
  logic [CSR_DATA_WIDTH-1:0]        csr_wr_data;
  logic [CSR_DATA_WIDTH-1:0]        csr_rd_data;
  logic                             csr_rd_valid;

  // Component declaration for AVST interface to CSR interface
  IW_fpga_avst2csr #(
     .AVST_CHANNEL_ID        ( INFRA_AVST_CHNNL_ID  )
    ,.AVST_CHANNEL_WIDTH     ( INFRA_AVST_CHNNL_W   )
    ,.AVST_SYMBOL_WIDTH      ( AVST_SYMBOL_WIDTH    )
    ,.AVST_DATA_WIDTH        ( INFRA_AVST_DATA_W    )
    ,.CSR_ADDR_WIDTH         ( CSR_ADDR_WIDTH       )
    ,.CSR_DATA_WIDTH         ( CSR_DATA_WIDTH       )
    ,.CMD_WIDTH              ( CMD_WIDTH            ) 
  ) u_IW_fpga_avst2csr (
     .clk_avst               ( clk_avst                )
    ,.rst_avst_n             ( rst_avst_n              )
    ,.avst_ingr_ready        ( avst_ingr_ready         )
    ,.avst_ingr_valid        ( avst_ingr_valid         )
    ,.avst_ingr_sop          ( avst_ingr_startofpacket )
    ,.avst_ingr_eop          ( avst_ingr_endofpacket   )
    ,.avst_ingr_channel      ( avst_ingr_channel       )
    ,.avst_ingr_data         ( avst_ingr_data          )
    ,.avst_egr_ready         ( avst_egr_ready          )
    ,.avst_egr_valid         ( avst_egr_valid          )
    ,.avst_egr_sop           ( avst_egr_startofpacket  )
    ,.avst_egr_eop           ( avst_egr_endofpacket    )
    ,.avst_egr_channel       ( avst_egr_channel        )
    ,.avst_egr_data          ( avst_egr_data           )
    ,.clk_csr                ( clk_csr                 )
    ,.rst_csr_n              ( rst_csr_n               )
    ,.csr_write              ( csr_write               )
    ,.csr_read               ( csr_read                )
    ,.csr_addr               ( csr_addr                )
    ,.csr_wr_data            ( csr_wr_data             )
    ,.csr_rd_data            ( csr_rd_data             )
    ,.csr_rd_valid           ( csr_rd_valid            )
   );

  // Component declaration for CSR Splitter module
  IW_fpga_csr_splitter #(
     .CSR_DATA_WIDTH            ( CSR_DATA_WIDTH           )
    ,.CSR_ADDR_WIDTH            ( CSR_ADDR_WIDTH           )
    ,.NUM_CSR_SUBMODULES        ( NUM_CSR_SUBMODULES       )
    ,.CSR_SUBMODULE_DATA_WIDTH  ( CSR_SUBMODULE_DATA_WIDTH )
    ,.CSR_SUBMODULE_ADDR_WIDTH  ( CSR_SUBMODULE_ADDR_WIDTH )
    ,.PIPELINE_REQS             ( PIPELINE_REQS            )
    ,.PIPELINE_RSPS             ( PIPELINE_RSPS            )
  ) u_IW_fpga_csr_splitter (
     .clk_csr                   ( clk_csr                  )
    ,.rst_csr_n                 ( rst_csr_n                )
    ,.csr_write                 ( csr_write                )
    ,.csr_read                  ( csr_read                 )
    ,.csr_addr                  ( csr_addr                 )
    ,.csr_wr_data               ( csr_wr_data              )
    ,.csr_rd_data               ( csr_rd_data              )
    ,.csr_rd_valid              ( csr_rd_valid             )
    ,.csr_submodule_write       ( csr_submodule_write      )
    ,.csr_submodule_read        ( csr_submodule_read       )
    ,.csr_submodule_addr        ( csr_submodule_addr       )
    ,.csr_submodule_wr_data     ( csr_submodule_wr_data    )
    ,.csr_submodule_rd_data     ( csr_submodule_rd_data    )
    ,.csr_submodule_rd_valid    ( csr_submodule_rd_valid   )
  );

endmodule // IW_fpga_csr_splitter
