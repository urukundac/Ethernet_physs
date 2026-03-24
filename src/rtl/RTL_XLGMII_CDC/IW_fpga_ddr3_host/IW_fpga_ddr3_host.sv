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
// File Name:IW_fpga_ddr3_host.sv
// File Revision:$
// Created by:    Niteesh Mastaiah
// Updated by:    $Author:$ $Date:$
//------------------------------------------------------------------------------

module  IW_fpga_ddr3_host  #(
  parameter ADDR_WIDTH       = 26,    // avl addr width of ddr 
  parameter DATA_WIDTH       = 256,
  parameter AVL_SIZE_WIDTH   = 3

) (

  input wire                                    clk_hst,
  input wire                                    rst_hst_n,     // host clk and reset  

  input wire                                    clk_cntrlr,
  input wire                                    rst_cntrlr_n, // ddr3_cntrlr clk and reset 

  // host side avalon interface 
  
  input  wire [ADDR_WIDTH-1:0]                  hst_addr,
  input  wire                                   hst_read_req,
  input  wire                                   hst_write_req,
  input  wire [DATA_WIDTH-1:0]                  hst_wdata,
  input  wire                                   hst_burstbegin,
  input  wire [AVL_SIZE_WIDTH-1:0]              hst_size, 
  input  wire [(DATA_WIDTH/8)-1:0]              hst_be,
  
  output wire                                   hst_ready,
  output wire                                   hst_rdata_valid,
  input  wire                                   hst_rdata_bp,
  output wire [DATA_WIDTH-1:0]                  hst_rdata,

  // DDR3 cntrlr side avalon interface 

  input wire                                    cntrlr_ready,
  input wire                                    cntrlr_rdata_valid,
  input wire  [DATA_WIDTH-1:0]                  cntrlr_rdata,
  input wire  [3:0]                             cntrlr_rdata_error,

  output wire                                   cntrlr_read_req,
  output wire                                   cntrlr_write_req,
  output wire                                   cntrlr_burstbegin,
  output wire [ADDR_WIDTH-1:0]                  cntrlr_addr,
  output wire [AVL_SIZE_WIDTH-1:0]              cntrlr_size,
  output wire [DATA_WIDTH-1:0]                  cntrlr_wdata,
  output wire [(DATA_WIDTH/8)-1:0]              cntrlr_be,
  output wire                                   ecc_err_detect

);
  
localparam TRANS_FIFO_WIDTH  = 80;
localparam TRANS_FIFO_DEPTH  = 512;
localparam DATA_FIFO_WIDTH   = 256;
localparam DATA_FIFO_DEPTH   = 512;
localparam CNTRLR_BE_WIDTH   = (DATA_WIDTH/8);
localparam TRANS_WRUSE_WIDTH = $clog2(TRANS_FIFO_DEPTH);
localparam DATA_WRUSE_WIDTH  = $clog2(DATA_FIFO_DEPTH);

wire [TRANS_FIFO_WIDTH-1:0]      avl_cmd_trans;
wire                             trans_fifo_rd;
wire                             trans_fifo_wr;
wire [TRANS_FIFO_WIDTH-1:0]      trans_fifo_rdata;
wire                             trans_fifo_empty;
wire [TRANS_WRUSE_WIDTH-1:0]     trans_fifo_rduse;
wire                             trans_fifo_full;
wire [TRANS_WRUSE_WIDTH-1:0]     trans_fifo_wruse;
wire [DATA_WIDTH-1:0]            avl_hst_wdata;
wire                             data_fifo_rd;
wire                             data_fifo_wr;
wire [DATA_WIDTH-1:0]            data_fifo_rdata;
wire                             data_fifo_empty;
wire [DATA_WRUSE_WIDTH-1:0]      data_fifo_rduse;
wire                             data_fifo_full;
wire [DATA_WRUSE_WIDTH-1:0]      data_fifo_wruse;
wire                             resp_fifo_wr;
wire [DATA_WIDTH-1:0]            resp_fifo_rdata;
wire [DATA_WIDTH-1:0]            resp_fifo_wdata;
wire                             resp_fifo_empty;
wire [DATA_WRUSE_WIDTH-1:0]      resp_fifo_rduse;
wire                             resp_fifo_full;
wire [DATA_WRUSE_WIDTH-1:0]      resp_fifo_wruse;


  



IW_80x512_fifo_fwft  avl_trans_fifo (
  
   .aclr         (!rst_hst_n),
   .data         (avl_cmd_trans),
   .rdclk        (clk_cntrlr),       //  reading is from cntrlr_domain
   .rdreq        (trans_fifo_rd),   
   .wrclk        (clk_hst),    // writing is from hst_domain
   .wrreq        (trans_fifo_wr), 
   .q            (trans_fifo_rdata),    
   .rdempty      (trans_fifo_empty),   
   .rdusedw      (trans_fifo_rduse),  
   .wrfull       (trans_fifo_full),   
   .wrusedw      (trans_fifo_wruse)

);   // trans_fifo




IW_256x512_fifo_fwft  avl_data_fifo (
  
   .aclr         (!rst_hst_n),
   .data         (avl_hst_wdata),
   .rdclk        (clk_cntrlr),       //  reading is from cntrlr_domain
   .rdreq        (data_fifo_rd),   
   .wrclk        (clk_hst),    // writing is from hst_domain
   .wrreq        (data_fifo_wr), 
   .q            (data_fifo_rdata),    
   .rdempty      (data_fifo_empty),   
   .rdusedw      (data_fifo_rduse),  
   .wrfull       (data_fifo_full),   
   .wrusedw      (data_fifo_wruse)

);   // data_fifo



IW_256x512_fifo_fwft  avl_resp_fifo (
  
   .aclr         (!rst_hst_n),
   .data         (resp_fifo_wdata),
   .rdclk        (clk_hst),       //  reading is from hst_domain
   .rdreq        (~hst_rdata_bp & hst_rdata_valid),   
   .wrclk        (clk_cntrlr),    // writing is from cntrlr_domain
   .wrreq        (resp_fifo_wr), 
   .q            (resp_fifo_rdata),    
   .rdempty      (resp_fifo_empty),   
   .rdusedw      (resp_fifo_rduse),  
   .wrfull       (resp_fifo_full),   
   .wrusedw      (resp_fifo_wruse)

);   // resp_fifo



avl_hst_slave_interface #(
   .ADDR_WIDTH       (ADDR_WIDTH),
   .DATA_WIDTH       (DATA_WIDTH),
   .AVL_SIZE_WIDTH   (AVL_SIZE_WIDTH),
   .TRANS_FIFO_WIDTH (TRANS_FIFO_WIDTH),
   .TRANS_FIFO_DEPTH (TRANS_FIFO_DEPTH),
   .DATA_FIFO_WIDTH  (DATA_FIFO_WIDTH),
   .DATA_FIFO_DEPTH  (DATA_FIFO_DEPTH)
   )  avl_hst_slv_interface (
           // inputs
           .avl_clk          (clk_hst),
           .avl_rst_n        (rst_hst_n),
           .avl_addr         (hst_addr),
           .avl_read_req     (hst_read_req),
           .avl_write_req    (hst_write_req),
           .avl_wdata        (hst_wdata),
           .avl_burstbegin   (hst_burstbegin),
           .avl_size         (hst_size),
           .avl_be           (hst_be),
           .trans_fifo_full  (trans_fifo_full),
           .trans_fifo_wruse (trans_fifo_wruse),
           .data_fifo_full   (data_fifo_full),
           .data_fifo_wruse  (data_fifo_wruse),
           .resp_fifo_empty  (resp_fifo_empty),
           .resp_fifo_rdata  (resp_fifo_rdata),
           
           // outputs 
           .avl_ready        (hst_ready),
           .avl_rdata_valid  (hst_rdata_valid),
           .avl_rdata        (hst_rdata),
           .trans_fifo_wr    (trans_fifo_wr),
           .avl_cmd_trans    (avl_cmd_trans),
           .data_fifo_wr     (data_fifo_wr),
           .avl_hst_wdata    (avl_hst_wdata)
       );

avl_cntrlr_master_interface #(
   .ADDR_WIDTH       (ADDR_WIDTH),
   .DATA_WIDTH       (DATA_WIDTH),
   .AVL_SIZE_WIDTH   (AVL_SIZE_WIDTH),
   .TRANS_FIFO_WIDTH (TRANS_FIFO_WIDTH),
   .TRANS_FIFO_DEPTH (TRANS_FIFO_DEPTH),
   .DATA_FIFO_WIDTH  (DATA_FIFO_WIDTH),
   .DATA_FIFO_DEPTH  (DATA_FIFO_DEPTH)
   )  avl_cntrlr_mst_interface (
           // inputs 
           .avl_clk          (clk_cntrlr),
           .avl_rst_n        (rst_cntrlr_n),
           .avl_ready        (cntrlr_ready),
           .avl_rdata_valid  (cntrlr_rdata_valid),
           .avl_rdata        (cntrlr_rdata),
           .avl_rdata_error  (cntrlr_rdata_error),
           .resp_fifo_full   (resp_fifo_full),
           .resp_fifo_wruse  (resp_fifo_wruse),
           .trans_fifo_empty (trans_fifo_empty),
           .trans_fifo_rduse (trans_fifo_rduse),
           .trans_fifo_rdata (trans_fifo_rdata),
           .data_fifo_empty  (data_fifo_empty),
           .data_fifo_rduse  (data_fifo_rduse),
           .data_fifo_rdata  (data_fifo_rdata),

           //outputs
           .avl_addr         (cntrlr_addr),
           .avl_wdata        (cntrlr_wdata),
           .avl_size         (cntrlr_size),
           .avl_be           (cntrlr_be),
           .avl_burstbegin   (cntrlr_burstbegin),
           .avl_write_req    (cntrlr_write_req),
           .avl_read_req     (cntrlr_read_req),
           .resp_fifo_wr     (resp_fifo_wr),
           .resp_fifo_wdata  (resp_fifo_wdata),
           .trans_fifo_rd    (trans_fifo_rd),
           .data_fifo_rd     (data_fifo_rd),
           .ecc_err_detect   (ecc_err_detect)
       );


endmodule //IW_fpga_ddr3_host
