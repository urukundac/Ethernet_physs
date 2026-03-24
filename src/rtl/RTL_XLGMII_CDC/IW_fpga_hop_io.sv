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
// File Name:$RCSfile:$
// File Revision:$
// Created by:    Gregory James
// Updated by:    $Author:$ $Date:$
//------------------------------------------------------------------------------
// This module is used to register signals when hopping from FPGA-to-FPGA
//------------------------------------------------------------------------------

`timescale  1ns/1ps

module  IW_fpga_hop_io  #(
   parameter  INSTANCE_TAG    = "hop"     //Prefix tag used to uniquely identify this module's instance

  ,parameter  BYPASS_DEMUX    = 0         //1->Do not instantiate IW_fpga_demux & use demux_bypass_data
  ,parameter  DEMUX_NUM_IOS   = 1         //Number of pins for demuxing
  ,parameter  DEMUX_RATIO     = 20        //Mux-ratio for demux
  ,parameter  DEMUX_CLK_RATIO = 12        //clock-ratio for demux

  ,parameter  BYPASS_MUX      = 0         //1->Do not instantiate IW_fpga_mux & use mux_bypass_data
  ,parameter  MUX_NUM_IOS     = 1         //Number of pins for muxing
  ,parameter  MUX_RATIO       = 20        //Mux-ratio for mux
  ,parameter  MUX_CLK_RATIO   = 12        //clock-ratio for mux
  ,parameter  FPGA_FAMILY     = "S5"

  ,parameter  INFRA_AVST_CHNNL_W         = 8
  ,parameter  INFRA_AVST_DATA_W          = 8
  ,parameter  INFRA_AVST_CHNNL_ID_DEMUX  = 8
  ,parameter  INFRA_AVST_CHNNL_ID_MUX    = 8

  ,parameter  CSR_ADDR_WIDTH             = 3*INFRA_AVST_DATA_W
  ,parameter  CSR_DATA_WIDTH             = 4*INFRA_AVST_DATA_W

  ,parameter DEMUX_DATA_GRADUAL          = 1 // 1: demuxed data changes bit after bit
  /*  Do not modify */
  , /*  reuse-pragma attr ReplaceInHDL 0  */  parameter  DEBUG_REG_W        = 32
  , /*  reuse-pragma attr ReplaceInHDL 0  */  parameter  NUM_DEBUG_REGS     = 16
  , /*  reuse-pragma attr ReplaceInHDL 0  */  parameter  NUM_DEMUX_SIGNALS  = DEMUX_NUM_IOS*DEMUX_RATIO
  , /*  reuse-pragma attr ReplaceInHDL 0  */  parameter  NUM_MUX_SIGNALS    = MUX_NUM_IOS*MUX_RATIO

) (

  /*  Common clocks, resets */
   input                          clk_register
  ,input                          clk_mux
  ,input                          rst_mux_n
  ,input                          clk_demux
  ,input                          rst_demux_n

  /*  Demux side ports  */
  ,inout  [DEMUX_NUM_IOS-1:0]     DEMUX_IO

  ,input  [NUM_MUX_SIGNALS-1:0]   demux_bypass_data

  ,output                         demux_ecc_err

  /*  Mux side ports  */
  ,inout  [MUX_NUM_IOS-1:0]       MUX_IO

  ,output [NUM_DEMUX_SIGNALS-1:0] mux_bypass_data

  //Common Infra-Avst clock, reset
  , input                                 clk_avst
  , input                                 rst_avst_n

  // HOP IO Mux Infra-Avst Ports
  , output                                hop_io_mux_avst_ingr_ready
  , input                                 hop_io_mux_avst_ingr_valid
  , input                                 hop_io_mux_avst_ingr_startofpacket
  , input                                 hop_io_mux_avst_ingr_endofpacket
  , input  [INFRA_AVST_CHNNL_W-1:0]       hop_io_mux_avst_ingr_channel
  , input  [INFRA_AVST_DATA_W-1:0]        hop_io_mux_avst_ingr_data

  , input                                 hop_io_mux_avst_egr_ready
  , output                                hop_io_mux_avst_egr_valid
  , output                                hop_io_mux_avst_egr_startofpacket
  , output                                hop_io_mux_avst_egr_endofpacket
  , output [INFRA_AVST_CHNNL_W-1:0]       hop_io_mux_avst_egr_channel
  , output [INFRA_AVST_DATA_W-1:0]        hop_io_mux_avst_egr_data

  // HOP IO Demux Infra-Avst Ports
  , output                                hop_io_demux_avst_ingr_ready
  , input                                 hop_io_demux_avst_ingr_valid
  , input                                 hop_io_demux_avst_ingr_startofpacket
  , input                                 hop_io_demux_avst_ingr_endofpacket
  , input  [INFRA_AVST_CHNNL_W-1:0]       hop_io_demux_avst_ingr_channel
  , input  [INFRA_AVST_DATA_W-1:0]        hop_io_demux_avst_ingr_data

  , input                                 hop_io_demux_avst_egr_ready
  , output                                hop_io_demux_avst_egr_valid
  , output                                hop_io_demux_avst_egr_startofpacket
  , output                                hop_io_demux_avst_egr_endofpacket
  , output [INFRA_AVST_CHNNL_W-1:0]       hop_io_demux_avst_egr_channel
  , output [INFRA_AVST_DATA_W-1:0]        hop_io_demux_avst_egr_data


);

  /*  Internal Parameters */


  /*  Internal Variables  */
  wire  [NUM_DEMUX_SIGNALS-1:0]   demux_signals_w;
  reg   [NUM_MUX_SIGNALS-1:0]     mux_signals_f;

  generate
    if(BYPASS_DEMUX)
    begin
      assign  demux_signals_w = {NUM_DEMUX_SIGNALS{1'b0}};
      assign  demux_ecc_err   = 1'b0;

      always@(*)
      begin
        mux_signals_f = demux_bypass_data;
      end

      //Bypass demux infra ring
      assign  hop_io_demux_avst_ingr_ready        = hop_io_demux_avst_egr_ready;
      assign  hop_io_demux_avst_egr_valid         = hop_io_demux_avst_ingr_valid;
      assign  hop_io_demux_avst_egr_startofpacket = hop_io_demux_avst_ingr_startofpacket;
      assign  hop_io_demux_avst_egr_endofpacket   = hop_io_demux_avst_ingr_endofpacket;
      assign  hop_io_demux_avst_egr_channel       = hop_io_demux_avst_ingr_channel;
      assign  hop_io_demux_avst_egr_data          = hop_io_demux_avst_ingr_data;
    end
    else
    begin
      /*  Instantiate Demux */
      if ( DEMUX_RATIO == ((DEMUX_CLK_RATIO*2)-4)) begin
        IW_fpga_demux_v2   #(
           .NUMBER_OF_INPUTS      (DEMUX_NUM_IOS)
          ,.MULTIPLEX_RATIO       (DEMUX_RATIO)
          ,.CLOCK_RATIO           (DEMUX_CLK_RATIO)
          ,.INSTANCE_NAME         ({INSTANCE_TAG,"_demux"})
          ,.FPGA_FAMILY           (FPGA_FAMILY)
          ,.INFRA_AVST_CHNNL_W    (INFRA_AVST_CHNNL_W)
          ,.INFRA_AVST_DATA_W     (INFRA_AVST_DATA_W)
          ,.INFRA_AVST_CHNNL_ID   (INFRA_AVST_CHNNL_ID_DEMUX)
          ,.AVST2CSR_BYPASS_EN    (0)
          ,.DEMUX_DATA_GRADUAL    (DEMUX_DATA_GRADUAL)
          ,.CSR_ADDR_WIDTH        (CSR_ADDR_WIDTH)
          ,.CSR_DATA_WIDTH        (CSR_DATA_WIDTH)
  
        ) u_IW_fpga_demux_v2  (
           
           .clk_demux                (clk_demux)
          ,.rst_demux_n              (rst_demux_n)
          ,.outbus                   (demux_signals_w)
          ,.inbus                    (DEMUX_IO)
          ,.ecc_err                  (demux_ecc_err)
          ,.clk_avst                 (clk_avst)
          ,.rst_avst_n               (rst_avst_n)
          ,.avst_ingr_ready          (hop_io_demux_avst_ingr_ready)
          ,.avst_ingr_valid          (hop_io_demux_avst_ingr_valid)
          ,.avst_ingr_startofpacket  (hop_io_demux_avst_ingr_startofpacket)
          ,.avst_ingr_endofpacket    (hop_io_demux_avst_ingr_endofpacket)
          ,.avst_ingr_channel        (hop_io_demux_avst_ingr_channel)
          ,.avst_ingr_data           (hop_io_demux_avst_ingr_data)
          ,.avst_egr_ready           (hop_io_demux_avst_egr_ready)
          ,.avst_egr_valid           (hop_io_demux_avst_egr_valid)
          ,.avst_egr_startofpacket   (hop_io_demux_avst_egr_startofpacket)
          ,.avst_egr_endofpacket     (hop_io_demux_avst_egr_endofpacket)
          ,.avst_egr_channel         (hop_io_demux_avst_egr_channel)
          ,.avst_egr_data            (hop_io_demux_avst_egr_data)
          ,.ext_csr_write            ('h0)
          ,.ext_csr_read             ('h0)
          ,.ext_csr_addr             ('h0)
          ,.ext_csr_wr_data          ('h0)
          ,.ext_csr_rd_data          ( )
          ,.ext_csr_rd_valid         ( )
        );
      end
      else begin
        IW_fpga_demux_v3   #(
           .NUMBER_OF_INPUTS      (DEMUX_NUM_IOS)
          ,.MULTIPLEX_RATIO       (DEMUX_RATIO)
          ,.CLOCK_RATIO           (DEMUX_CLK_RATIO)
          ,.INSTANCE_NAME         ({INSTANCE_TAG,"_demuxv3"})
          ,.FPGA_FAMILY           (FPGA_FAMILY)
          ,.INFRA_AVST_CHNNL_W    (INFRA_AVST_CHNNL_W)
          ,.INFRA_AVST_DATA_W     (INFRA_AVST_DATA_W)
          ,.INFRA_AVST_CHNNL_ID   (INFRA_AVST_CHNNL_ID_DEMUX)
//          ,.AVST2CSR_BYPASS_EN    (0)
//          ,.DEMUX_DATA_GRADUAL    (DEMUX_DATA_GRADUAL)
          ,.CSR_ADDR_WIDTH        (CSR_ADDR_WIDTH)
          ,.CSR_DATA_WIDTH        (CSR_DATA_WIDTH)
  
        ) u_IW_fpga_demux_v3  (
           
           .clk_demux                (clk_demux)
          ,.rst_demux_n              (rst_demux_n)
          ,.outbus                   (demux_signals_w)
          ,.inbus                    (DEMUX_IO)
//          ,.ecc_err                  (demux_ecc_err)
          ,.clk_avst                 (clk_avst)
          ,.rst_avst_n               (rst_avst_n)
          ,.avst_ingr_ready          (hop_io_demux_avst_ingr_ready)
          ,.avst_ingr_valid          (hop_io_demux_avst_ingr_valid)
          ,.avst_ingr_startofpacket  (hop_io_demux_avst_ingr_startofpacket)
          ,.avst_ingr_endofpacket    (hop_io_demux_avst_ingr_endofpacket)
          ,.avst_ingr_channel        (hop_io_demux_avst_ingr_channel)
          ,.avst_ingr_data           (hop_io_demux_avst_ingr_data)
          ,.avst_egr_ready           (hop_io_demux_avst_egr_ready)
          ,.avst_egr_valid           (hop_io_demux_avst_egr_valid)
          ,.avst_egr_startofpacket   (hop_io_demux_avst_egr_startofpacket)
          ,.avst_egr_endofpacket     (hop_io_demux_avst_egr_endofpacket)
          ,.avst_egr_channel         (hop_io_demux_avst_egr_channel)
          ,.avst_egr_data            (hop_io_demux_avst_egr_data)
        );
      end 
      /*  Register the demuxed signals  */
      always@(posedge clk_register)
      begin
        mux_signals_f <=  demux_signals_w;  //The values of NUM_MUX_SIGNALS & NUM_DEMUX_SIGNALS should match
      end
    end
  endgenerate

  generate
    if(BYPASS_MUX)
    begin
      if(BYPASS_DEMUX)
      begin
        assign  mux_bypass_data = mux_signals_f;
      end
      else
      begin
        assign  mux_bypass_data = demux_signals_w;
      end

      //Bypass mux infra ring
      assign  hop_io_mux_avst_ingr_ready        = hop_io_mux_avst_egr_ready;
      assign  hop_io_mux_avst_egr_valid         = hop_io_mux_avst_ingr_valid;
      assign  hop_io_mux_avst_egr_startofpacket = hop_io_mux_avst_ingr_startofpacket;
      assign  hop_io_mux_avst_egr_endofpacket   = hop_io_mux_avst_ingr_endofpacket;
      assign  hop_io_mux_avst_egr_channel       = hop_io_mux_avst_ingr_channel;
      assign  hop_io_mux_avst_egr_data          = hop_io_mux_avst_ingr_data;
    end
    else
    begin
      assign  mux_bypass_data = {NUM_DEMUX_SIGNALS{1'b0}};

      /*  Instantiate Mux */
      if ( MUX_RATIO == ((MUX_CLK_RATIO*2)-4)) begin
        IW_fpga_mux_v2  #(
           .NUMBER_OF_OUTPUTS     (MUX_NUM_IOS)
          ,.MULTIPLEX_RATIO       (MUX_RATIO)
          ,.CLOCK_RATIO           (MUX_CLK_RATIO)
          ,.INSTANCE_NAME         ({INSTANCE_TAG,"_mux"})
          ,.FPGA_FAMILY           (FPGA_FAMILY)
          ,.INFRA_AVST_CHNNL_W    (INFRA_AVST_CHNNL_W)
          ,.INFRA_AVST_DATA_W     (INFRA_AVST_DATA_W)
          ,.INFRA_AVST_CHNNL_ID   (INFRA_AVST_CHNNL_ID_MUX)
          ,.AVST2CSR_BYPASS_EN    (0)
          ,.CSR_ADDR_WIDTH        (CSR_ADDR_WIDTH)
          ,.CSR_DATA_WIDTH        (CSR_DATA_WIDTH)
  
        ) u_IW_fpga_mux_v2  (
           
           .clk_mux                  (clk_mux)
          ,.rst_mux_n                (rst_mux_n)
          ,.outbus                   (MUX_IO)
          ,.inbus                    (mux_signals_f)
          ,.clk_avst                 (clk_avst)
          ,.rst_avst_n               (rst_avst_n)
          ,.avst_ingr_ready          (hop_io_mux_avst_ingr_ready)
          ,.avst_ingr_valid          (hop_io_mux_avst_ingr_valid)
          ,.avst_ingr_startofpacket  (hop_io_mux_avst_ingr_startofpacket)
          ,.avst_ingr_endofpacket    (hop_io_mux_avst_ingr_endofpacket)
          ,.avst_ingr_channel        (hop_io_mux_avst_ingr_channel)
          ,.avst_ingr_data           (hop_io_mux_avst_ingr_data)
          ,.avst_egr_ready           (hop_io_mux_avst_egr_ready)
          ,.avst_egr_valid           (hop_io_mux_avst_egr_valid)
          ,.avst_egr_startofpacket   (hop_io_mux_avst_egr_startofpacket)
          ,.avst_egr_endofpacket     (hop_io_mux_avst_egr_endofpacket)
          ,.avst_egr_channel         (hop_io_mux_avst_egr_channel)
          ,.avst_egr_data            (hop_io_mux_avst_egr_data)
          ,.ext_csr_write            ('h0)
          ,.ext_csr_read             ('h0)
          ,.ext_csr_addr             ('h0)
          ,.ext_csr_wr_data          ('h0)
          ,.ext_csr_rd_data          ( )
          ,.ext_csr_rd_valid         ( )
        );
      end
      else begin
        IW_fpga_mux_v3  #(
           .NUMBER_OF_OUTPUTS     (MUX_NUM_IOS)
          ,.MULTIPLEX_RATIO       (MUX_RATIO)
          ,.CLOCK_RATIO           (MUX_CLK_RATIO)
          ,.INSTANCE_NAME         ({INSTANCE_TAG,"_muxv3"})
          ,.FPGA_FAMILY           (FPGA_FAMILY)
          ,.INFRA_AVST_CHNNL_W    (INFRA_AVST_CHNNL_W)
          ,.INFRA_AVST_DATA_W     (INFRA_AVST_DATA_W)
          ,.INFRA_AVST_CHNNL_ID   (INFRA_AVST_CHNNL_ID_MUX)
//          ,.AVST2CSR_BYPASS_EN    (0)
          ,.CSR_ADDR_WIDTH        (CSR_ADDR_WIDTH)
          ,.CSR_DATA_WIDTH        (CSR_DATA_WIDTH)
  
        ) u_IW_fpga_mux_v3  (
           
           .clk_mux                  (clk_mux)
          ,.rst_mux_n                (rst_mux_n)
          ,.outbus                   (MUX_IO)
          ,.inbus                    (mux_signals_f)
          ,.clk_avst                 (clk_avst)
          ,.rst_avst_n               (rst_avst_n)
          ,.avst_ingr_ready          (hop_io_mux_avst_ingr_ready)
          ,.avst_ingr_valid          (hop_io_mux_avst_ingr_valid)
          ,.avst_ingr_startofpacket  (hop_io_mux_avst_ingr_startofpacket)
          ,.avst_ingr_endofpacket    (hop_io_mux_avst_ingr_endofpacket)
          ,.avst_ingr_channel        (hop_io_mux_avst_ingr_channel)
          ,.avst_ingr_data           (hop_io_mux_avst_ingr_data)
          ,.avst_egr_ready           (hop_io_mux_avst_egr_ready)
          ,.avst_egr_valid           (hop_io_mux_avst_egr_valid)
          ,.avst_egr_startofpacket   (hop_io_mux_avst_egr_startofpacket)
          ,.avst_egr_endofpacket     (hop_io_mux_avst_egr_endofpacket)
          ,.avst_egr_channel         (hop_io_mux_avst_egr_channel)
          ,.avst_egr_data            (hop_io_mux_avst_egr_data)
        );
      end
    end
  endgenerate



endmodule //IW_fpga_hop_io
