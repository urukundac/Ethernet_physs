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
// File Name:     $RCSfile: IW_fpga_mux_demux_io.sv.rca $
// File Revision: $Revision: 1.1 $
// Created by:    Hari kurapati
// Updated by:    $Author: balaji $ $Date: Mon Jul 20 04:45:45 2015 $
//------------------------------------------------------------------------------

`timescale 10fs/10fs

module IW_fpga_mux_demux_io #(
    parameter MUX_PARALLEL_IO_WIDTH           = 16
  , parameter MUX_CLOCK_RATIO                 = 28
  , parameter MUX_MULTIPLEX_RATIO             = 52
  , parameter DMUX_PARALLEL_IO_WIDTH          = 16
  , parameter DMUX_CLOCK_RATIO                = 28
  , parameter DMUX_MULTIPLEX_RATIO            = 52
  , parameter BYPASS                          = 0
  , parameter FPGA_FAMILY                     = "S5"
  , parameter INFRA_AVST_CHNNL_W              = 8
  , parameter INFRA_AVST_DATA_W               = 8
  , parameter INFRA_AVST_CHNNL_ID_MUX         = 8
  , parameter INFRA_AVST_CHNNL_ID_DEMUX       = 8
  , parameter CSR_ADDR_WIDTH                  = 3*INFRA_AVST_DATA_W
  , parameter CSR_DATA_WIDTH                  = 4*INFRA_AVST_DATA_W
  , parameter INSTANCE_NAME                   = "u_mux_demux_io"
  )(
    input   rst_mux
  , input   clk_mux
  , input   clk_demux

  , input   clk_sys
  , input   rst_to_logic_n

  , inout   [MUX_PARALLEL_IO_WIDTH-1:0]   MUX_PARALLEL_IO
  , inout   [DMUX_PARALLEL_IO_WIDTH-1:0]   DMUX_PARALLEL_IO
  , output  [(DMUX_MULTIPLEX_RATIO*DMUX_PARALLEL_IO_WIDTH)-1 : 0 ] demux_data_out
  , input   [(MUX_MULTIPLEX_RATIO*MUX_PARALLEL_IO_WIDTH)-1 : 0 ]   mux_data_in

  // MUX IO Infra-Avst Ports
  , input                                 mux_io_clk_avst
  , input                                 mux_io_rst_avst_n
  , output                                mux_io_avst_ingr_ready
  , input                                 mux_io_avst_ingr_valid
  , input                                 mux_io_avst_ingr_startofpacket
  , input                                 mux_io_avst_ingr_endofpacket
  , input  [INFRA_AVST_CHNNL_W-1:0]       mux_io_avst_ingr_channel
  , input  [INFRA_AVST_DATA_W-1:0]        mux_io_avst_ingr_data

  , input                                 mux_io_avst_egr_ready
  , output                                mux_io_avst_egr_valid
  , output                                mux_io_avst_egr_startofpacket
  , output                                mux_io_avst_egr_endofpacket
  , output [INFRA_AVST_CHNNL_W-1:0]       mux_io_avst_egr_channel
  , output [INFRA_AVST_DATA_W-1:0]        mux_io_avst_egr_data

  // Demux IO Infra-Avst Ports
  , input                                 demux_io_clk_avst
  , input                                 demux_io_rst_avst_n
  , output                                demux_io_avst_ingr_ready
  , input                                 demux_io_avst_ingr_valid
  , input                                 demux_io_avst_ingr_startofpacket
  , input                                 demux_io_avst_ingr_endofpacket
  , input  [INFRA_AVST_CHNNL_W-1:0]       demux_io_avst_ingr_channel
  , input  [INFRA_AVST_DATA_W-1:0]        demux_io_avst_ingr_data

  , input                                 demux_io_avst_egr_ready
  , output                                demux_io_avst_egr_valid
  , output                                demux_io_avst_egr_startofpacket
  , output                                demux_io_avst_egr_endofpacket
  , output [INFRA_AVST_CHNNL_W-1:0]       demux_io_avst_egr_channel
  , output [INFRA_AVST_DATA_W-1:0]        demux_io_avst_egr_data

 );

 reg  [(MUX_MULTIPLEX_RATIO*MUX_PARALLEL_IO_WIDTH)-1 : 0 ] mux_data_in_q;
 wire  [(MUX_MULTIPLEX_RATIO*MUX_PARALLEL_IO_WIDTH)-1 : 0 ] mux_data_in_final;

IW_fpga_mux #(
  .NUMBER_OF_OUTPUTS         (MUX_PARALLEL_IO_WIDTH),
  .MULTIPLEX_RATIO           (MUX_MULTIPLEX_RATIO),
  .CLOCK_RATIO               (MUX_CLOCK_RATIO),
  .FPGA_FAMILY               (FPGA_FAMILY),
  .INFRA_AVST_CHNNL_W        (INFRA_AVST_CHNNL_W),
  .INFRA_AVST_DATA_W         (INFRA_AVST_DATA_W),
  .INFRA_AVST_CHNNL_ID       (INFRA_AVST_CHNNL_ID_MUX),
  .CSR_ADDR_WIDTH            (CSR_ADDR_WIDTH),
  .CSR_DATA_WIDTH            (CSR_DATA_WIDTH),
  .INSTANCE_NAME             ("mux_io")
) u_erif_to_eshim_apb_mux (
    .clk_mux                  (clk_mux)
  , .rst_mux_n                (rst_mux)
  , .inbus                    (mux_data_in_final)
  , .outbus                   (MUX_PARALLEL_IO)
  , .clk_avst                 (mux_io_clk_avst)
  , .rst_avst_n               (mux_io_rst_avst_n)
  , .avst_ingr_ready          (mux_io_avst_ingr_ready)
  , .avst_ingr_valid          (mux_io_avst_ingr_valid)
  , .avst_ingr_startofpacket  (mux_io_avst_ingr_startofpacket)
  , .avst_ingr_endofpacket    (mux_io_avst_ingr_endofpacket)
  , .avst_ingr_channel        (mux_io_avst_ingr_channel)
  , .avst_ingr_data           (mux_io_avst_ingr_data)
  , .avst_egr_ready           (mux_io_avst_egr_ready)
  , .avst_egr_valid           (mux_io_avst_egr_valid)
  , .avst_egr_startofpacket   (mux_io_avst_egr_startofpacket)
  , .avst_egr_endofpacket     (mux_io_avst_egr_endofpacket)
  , .avst_egr_channel         (mux_io_avst_egr_channel)
  , .avst_egr_data            (mux_io_avst_egr_data)
); // IW_fpga_mux

IW_fpga_demux #(
  .NUMBER_OF_INPUTS           (DMUX_PARALLEL_IO_WIDTH),
  .MULTIPLEX_RATIO            (DMUX_MULTIPLEX_RATIO),
  .CLOCK_RATIO                (DMUX_CLOCK_RATIO),
  .FPGA_FAMILY                (FPGA_FAMILY),
  .INFRA_AVST_CHNNL_W         (INFRA_AVST_CHNNL_W),
  .INFRA_AVST_DATA_W          (INFRA_AVST_DATA_W),
  .INFRA_AVST_CHNNL_ID        (INFRA_AVST_CHNNL_ID_DEMUX),
  .CSR_ADDR_WIDTH             (CSR_ADDR_WIDTH),
  .CSR_DATA_WIDTH             (CSR_DATA_WIDTH),
  .INSTANCE_NAME              ("demux_io")
) u_erif_from_eshim_apb_demux (
    .clk_demux                (clk_demux)
  , .outbus                   (demux_data_out)
  , .inbus                    (DMUX_PARALLEL_IO)
  , .clk_avst                 (demux_io_clk_avst)
  , .rst_avst_n               (demux_io_rst_avst_n)
  , .avst_ingr_ready          (demux_io_avst_ingr_ready)
  , .avst_ingr_valid          (demux_io_avst_ingr_valid)
  , .avst_ingr_startofpacket  (demux_io_avst_ingr_startofpacket)
  , .avst_ingr_endofpacket    (demux_io_avst_ingr_endofpacket)
  , .avst_ingr_channel        (demux_io_avst_ingr_channel)
  , .avst_ingr_data           (demux_io_avst_ingr_data)
  , .avst_egr_ready           (demux_io_avst_egr_ready)
  , .avst_egr_valid           (demux_io_avst_egr_valid)
  , .avst_egr_startofpacket   (demux_io_avst_egr_startofpacket)
  , .avst_egr_endofpacket     (demux_io_avst_egr_endofpacket)
  , .avst_egr_channel         (demux_io_avst_egr_channel)
  , .avst_egr_data            (demux_io_avst_egr_data)
); // IW_fpga_demux

generate 
   if (BYPASS == 1)
   begin 
      always @ (posedge clk_sys or negedge rst_to_logic_n)
      begin
         if (~rst_to_logic_n)
         begin
            mux_data_in_q <= 0;
         end
         else
         begin
            mux_data_in_q <= demux_data_out;
         end
      end
     
      assign mux_data_in_final = mux_data_in_q;
   end
   else
   begin
      assign mux_data_in_final = mux_data_in;
   end
endgenerate

endmodule

