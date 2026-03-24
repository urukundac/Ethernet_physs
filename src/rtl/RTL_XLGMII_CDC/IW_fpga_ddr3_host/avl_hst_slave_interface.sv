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
// File Name:avl_hst_slave_interface.sv
// File Revision:$
// Created by:    Niteesh Mastaiah
// Updated by:    $Author:$ $Date:$
//------------------------------------------------------------------------------

module  avl_hst_slave_interface  #(  
  parameter ADDR_WIDTH        = 26,    // avl addr width of ddr 
  parameter DATA_WIDTH        = 256,
  parameter AVL_SIZE_WIDTH    = 3,
  parameter TRANS_FIFO_WIDTH  = 80,
  parameter TRANS_FIFO_DEPTH  = 512,
  parameter DATA_FIFO_WIDTH   = 256,
  parameter DATA_FIFO_DEPTH   = 512,
  // do not modify these 
  parameter TRANS_WRUSE_WIDTH = $clog2(TRANS_FIFO_DEPTH),
  parameter DATA_WRUSE_WIDTH  = $clog2(DATA_FIFO_DEPTH)

) (

  input  wire                         avl_clk,
  input  wire                         avl_rst_n,

  input  wire [ADDR_WIDTH-1:0]        avl_addr,
  input  wire                         avl_read_req,
  input  wire                         avl_write_req,
  input  wire [DATA_WIDTH-1:0]        avl_wdata,
  input  wire                         avl_burstbegin,
  input  wire [AVL_SIZE_WIDTH-1:0]    avl_size,
  input  wire [(DATA_WIDTH/8)-1:0]    avl_be,
  input  wire                         trans_fifo_full,
  input  wire [TRANS_WRUSE_WIDTH-1:0] trans_fifo_wruse,
  input  wire                         data_fifo_full,
  input  wire [DATA_WRUSE_WIDTH-1:0]  data_fifo_wruse,
  input  wire                         resp_fifo_empty,
  input  wire [DATA_FIFO_WIDTH-1:0]   resp_fifo_rdata,


  output reg                          avl_ready,
  output reg                          avl_rdata_valid,
  output reg [DATA_WIDTH-1:0]         avl_rdata,
  output reg                          trans_fifo_wr,
  output reg [TRANS_FIFO_WIDTH-1:0]   avl_cmd_trans,
  output reg                          data_fifo_wr,
  output reg [DATA_FIFO_WIDTH-1:0]    avl_hst_wdata

);

localparam ZEROS_TOBE_APPENDED = TRANS_FIFO_WIDTH-(DATA_WIDTH/8)-AVL_SIZE_WIDTH-ADDR_WIDTH-1;




genvar  i;

wire                         avl_next_burstbegin;
wire                         avl_error;
wire                         avl_next_ready;
wire                         avl_next_rdata_valid;
wire [DATA_WIDTH-1:0]        avl_next_rdata;       
wire                         trans_fifo_next_wr;
wire [TRANS_FIFO_WIDTH-1:0]  avl_next_cmd_trans;
wire                         data_fifo_next_wr;
wire [DATA_FIFO_WIDTH-1:0]   avl_hst_next_wdata;
wire                         data_valid;
wire                         transaction_valid; 
wire                         sample_transaction;
wire                         avl_cmd;
wire                         read_ready;
wire                         write_ready;

reg                          avl_curr_burstbegin;



always @(posedge avl_clk or negedge avl_rst_n) begin
  if(avl_rst_n == 0) begin
    avl_ready            <= 0;
    trans_fifo_wr        <= 0;
    avl_cmd_trans        <= 0;
    data_fifo_wr         <= 0;
    avl_hst_wdata        <= 0;
    avl_curr_burstbegin  <= 0;
  end
  
  else
  begin
    avl_ready            <= avl_next_ready;
    trans_fifo_wr        <= trans_fifo_next_wr;
    avl_cmd_trans        <= avl_next_cmd_trans;
    data_fifo_wr         <= data_fifo_next_wr;
    avl_hst_wdata        <= avl_hst_next_wdata;
    avl_curr_burstbegin  <= avl_next_burstbegin;
  end
end // always


always@(*)
begin
  avl_rdata       = avl_next_rdata;
  avl_rdata_valid = avl_next_rdata_valid;
end

assign read_ready           = (trans_fifo_wruse > TRANS_FIFO_DEPTH-5) ? 0: 1;
assign write_ready          = (data_fifo_wruse > DATA_FIFO_DEPTH-10) ? 0: 1;
assign avl_next_ready       = (read_ready) && (write_ready);
assign avl_next_burstbegin  = (avl_curr_burstbegin || avl_burstbegin) && (!avl_ready);
assign sample_transaction   = (avl_curr_burstbegin || avl_burstbegin) && (avl_ready);
assign avl_error            = ((sample_transaction)  && (!avl_read_req) && (!avl_write_req)) ||  (sample_transaction && avl_read_req && avl_write_req);     // burst begin is there but no request assereted
assign transaction_valid    = (sample_transaction) && (!avl_error);
assign avl_cmd              = (transaction_valid) ? ((avl_read_req) ? 0: 1): 0;    //assuming if not read it will be write
assign avl_next_cmd_trans   = {{ZEROS_TOBE_APPENDED{1'b0}},avl_be,avl_addr,avl_size,avl_cmd}; 
assign trans_fifo_next_wr   = (transaction_valid) ? 1: 0;
assign data_valid           = (avl_ready) && (avl_write_req) && (!avl_error);
assign data_fifo_next_wr    = (data_valid) ? 1: 0;
assign avl_next_rdata       = resp_fifo_rdata;
assign avl_next_rdata_valid = (!resp_fifo_empty);
assign avl_hst_next_wdata   = {{(DATA_FIFO_WIDTH-DATA_WIDTH){1'b0}},avl_wdata};


endmodule 
