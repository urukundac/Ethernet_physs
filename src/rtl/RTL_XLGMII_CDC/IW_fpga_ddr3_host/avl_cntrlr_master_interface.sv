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
// File Name:avl_cntrlr_master_interface.sv
// File Revision:$
// Created by:    Niteesh Mastaiah
// Updated by:    $Author:$ $Date:$
//------------------------------------------------------------------------------

module  avl_cntrlr_master_interface  #(
  parameter ADDR_WIDTH        = 26,    // avl addr width of ddr 
  parameter DATA_WIDTH        = 256,
  parameter AVL_SIZE_WIDTH    = 3,
  parameter TRANS_FIFO_WIDTH  = 40,
  parameter TRANS_FIFO_DEPTH  = 512,
  parameter DATA_FIFO_WIDTH   = 256,
  parameter DATA_FIFO_DEPTH   = 512,
  parameter TRANS_WRUSE_WIDTH = $clog2(TRANS_FIFO_DEPTH),
  parameter DATA_WRUSE_WIDTH  = $clog2(DATA_FIFO_DEPTH)

) (

  input  wire                              avl_clk,
  input  wire                              avl_rst_n,
  
  input  wire                              avl_ready,
  input  wire                              avl_rdata_valid,
  input  wire  [DATA_WIDTH-1:0]            avl_rdata,
  input  wire  [3:0]                       avl_rdata_error,
  input  wire                              resp_fifo_full,
  input  wire  [DATA_WRUSE_WIDTH-1:0]      resp_fifo_wruse,
  input  wire                              trans_fifo_empty,
  input  wire  [TRANS_WRUSE_WIDTH-1:0]     trans_fifo_rduse,
  input  wire  [TRANS_FIFO_WIDTH-1:0]      trans_fifo_rdata,
  input  wire                              data_fifo_empty,
  input  wire  [DATA_WRUSE_WIDTH-1:0]      data_fifo_rduse,
  input  wire  [DATA_FIFO_WIDTH-1:0]       data_fifo_rdata,


  output reg  [ADDR_WIDTH-1:0]             avl_addr,
  output reg  [DATA_WIDTH-1:0]             avl_wdata,
  output reg  [AVL_SIZE_WIDTH-1:0]         avl_size,
  output reg  [(DATA_WIDTH/8)-1:0]         avl_be,
  output reg                               avl_burstbegin,
  output reg                               avl_write_req,
  output reg                               avl_read_req,

  output reg                               resp_fifo_wr,
  output reg [DATA_FIFO_WIDTH-1:0]         resp_fifo_wdata,
  output reg                               trans_fifo_rd,
  output wire                              data_fifo_rd,
  output reg                               ecc_err_detect

  );

  /*  Internal Parameters */
  localparam  TRANS_FF_VALID_WIDTH  = 1 + AVL_SIZE_WIDTH + ADDR_WIDTH + (DATA_WIDTH/8);

  /*  Internal Variables  */
  reg     xtn_active;
  reg     xtn_wr_n_rd;

  wire  [ADDR_WIDTH-1:0]      avl_addr_tap;
  wire  [AVL_SIZE_WIDTH-1:0]  avl_size_tap;
  wire  [(DATA_WIDTH/8)-1:0]  avl_be_tap;
  wire                        xtn_wr_n_rd_tap;
  wire                        avl_wr_valid;
  reg   [AVL_SIZE_WIDTH-1:0]  avl_burst_cntr;
  wire                        end_of_burst;


  //Extract the members of transaction fifo
  assign  {  avl_be_tap
            ,avl_addr_tap
            ,avl_size_tap
            ,xtn_wr_n_rd_tap
          } = trans_fifo_rdata[TRANS_FF_VALID_WIDTH-1:0];

  //Qualify a valid write phase
  assign  avl_wr_valid  = avl_write_req & avl_ready;

  /*
    * Main logic
  */
  always@(posedge avl_clk,  negedge avl_rst_n)
  begin
    if(~avl_rst_n)
    begin
      avl_addr                <=  0;
      avl_wdata               <=  0;
      avl_size                <=  0;
      avl_be                  <=  0;
      avl_burstbegin          <=  0;
      avl_write_req           <=  0;
      avl_read_req            <=  0;

      resp_fifo_wr            <=  0;
      resp_fifo_wdata         <=  0;
      trans_fifo_rd           <=  0;
      ecc_err_detect          <=  0;

      xtn_active              <=  0;
      xtn_wr_n_rd             <=  0;
      avl_burst_cntr          <=  0;
    end
    else
    begin

      if(xtn_active)  //Wait for end of transaction
      begin
        trans_fifo_rd         <=  0;
        avl_burst_cntr        <=  (avl_burst_cntr ==  0)  ? 1 : avl_burst_cntr  + avl_wr_valid;

        if(~xtn_wr_n_rd)  //Keep read request active until accepted
        begin
          avl_burstbegin      <=  0;
          avl_read_req        <=  ~avl_ready;
          xtn_active          <=  ~avl_ready;
        end
        else  //Write
        begin
          avl_burstbegin      <=  (avl_burst_cntr ==  0)  ? 1'b1  : 1'b0;
          avl_write_req       <=  ~(end_of_burst  & avl_ready);
          xtn_active          <=  ~(end_of_burst  & avl_ready);
        end
      end
      else  //Wait for new transaction
      begin
        avl_burst_cntr        <=  0;

        if(~trans_fifo_empty)
        begin

          if(xtn_wr_n_rd_tap) //Write
          begin
            if(data_fifo_rduse  >=  {{(DATA_WRUSE_WIDTH-AVL_SIZE_WIDTH){1'b0}},avl_size_tap}) //Wait for full wdata
            begin
              xtn_active      <=  1'b1; 
              trans_fifo_rd   <=  1'b1;
              avl_burstbegin  <=  1'b0; //Intended delay
              avl_write_req   <=  1'b0; //Intended delay
              avl_read_req    <=  1'b0;
            end
          end
          else  //Read
          begin
            xtn_active        <=  1'b1; 
            trans_fifo_rd     <=  1'b1;
            avl_burstbegin    <=  1'b1;
            avl_write_req     <=  1'b0;
            avl_read_req      <=  1'b1;
          end
        end

        avl_addr              <=  avl_addr_tap;
        avl_size              <=  avl_size_tap;
        avl_be                <=  avl_be_tap;
        xtn_wr_n_rd           <=  xtn_wr_n_rd_tap;
      end

      avl_wdata             <=  data_fifo_rdata;

      //Register response
      resp_fifo_wr          <=  avl_rdata_valid;
      resp_fifo_wdata       <=  avl_rdata;

      //ECC error sticky bit
      ecc_err_detect        <=  ecc_err_detect  | (avl_rdata_valid  & (|avl_rdata_error));
    end
  end

  assign  end_of_burst  = (avl_burst_cntr ==  avl_size) ? 1'b1  : 1'b0;

  assign  data_fifo_rd  = xtn_active  & xtn_wr_n_rd & ((avl_ready & ~end_of_burst)  | trans_fifo_rd);

endmodule //avl_cntrlr_master_interface
