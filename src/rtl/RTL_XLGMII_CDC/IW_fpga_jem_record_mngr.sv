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
// File Name:     $RCSfile: IW_fpga_jem_record_mngr.sv.rca $
// File Revision: $Revision: 1.3 $
// Created by:    Gregory James
// Updated by:    $Author: gjames $ $Date: Wed Feb 24 00:05:54 2016 $
//------------------------------------------------------------------------------

`timescale  1ns/1ps

module  IW_fpga_jem_record_mngr #(
   parameter  NUM_CHANNELS      = 1   //Number of parallel channel to manage
  ,parameter  RECORD_ID_WIDTH   = 32  //Width of record ID

  /*  Do not modify */
  , parameter NUM_CHANNELS_BIN  = $clog2(NUM_CHANNELS)

) (

  //Ingress Side
   input    logic                         clk_ingr
  ,input    logic                         rst_ingr_n
  ,input    logic                         egr_ordering_en
  ,input    logic [NUM_CHANNELS-1:0]      chnnl_ingr_wren
  ,output   logic [RECORD_ID_WIDTH-1:0]   chnnl_ingr_rec_id [NUM_CHANNELS-1:0]

  //Egress  Side
  ,input    logic                         clk_egr
  ,input    logic                         rst_egr_n
  ,input    logic [NUM_CHANNELS-1:0]      chnnl_egr_empty
  ,input    logic [RECORD_ID_WIDTH-1:0]   chnnl_egr_rec_id [NUM_CHANNELS-1:0]
  ,output   logic [NUM_CHANNELS-1:0]      chnnl_egr_valid
  ,output   logic [NUM_CHANNELS_BIN-1:0]  chnnl_egr_valid_bin
  ,input    logic [NUM_CHANNELS-1:0]      chnnl_egr_rden

);

  /*  Internal Parameters */
  localparam  CHANNEL_CNTR_W  = $clog2(NUM_CHANNELS)  + 1;


  /*  Internal Variables  */
  genvar  i;
  integer n;

  logic [RECORD_ID_WIDTH-1:0] ingr_rec_cntr;
  logic [RECORD_ID_WIDTH-1:0] egr_rec_cntr;

  logic [CHANNEL_CNTR_W-1:0]  ingr_num_req;



  //Calculate the number of ingress requests in this cycle
  always@(*)
  begin
    ingr_num_req  = 0;

    for(n=0;n<NUM_CHANNELS;n++)
    begin : calc_ingr_num_req
      ingr_num_req  = ingr_num_req  + chnnl_ingr_wren[n];
    end
  end

  //Calculate the next valid record in egress side
  generate
    for(i=0;i<NUM_CHANNELS;i++)
    begin : calc_egr_valid
      assign  chnnl_egr_valid[i]  = egr_ordering_en ? ((chnnl_egr_rec_id[i] ==  egr_rec_cntr) ? ~chnnl_egr_empty[i] : 1'b0)
                                                    : ~chnnl_egr_empty[i];
    end
  endgenerate

  always@(posedge clk_ingr,  negedge rst_ingr_n)
  begin
    if(~rst_ingr_n)
    begin
      ingr_rec_cntr           <=  0;
    end
    else
    begin
      /*  Ingress Logic */
      ingr_rec_cntr           <=  ingr_rec_cntr + ingr_num_req;
    end
  end

  always@(posedge clk_egr,  negedge rst_egr_n)
  begin
    if(~rst_egr_n)
    begin
      egr_rec_cntr            <=  0;
    end
    else
    begin
      /*  Egress  Logic */
      egr_rec_cntr            <=  egr_rec_cntr  + (|chnnl_egr_rden);
    end
  end


  generate
    for(i=0;i<NUM_CHANNELS;i++)
    begin : gen_ingr_rec_id
      if(i==0)
      begin
        assign  chnnl_ingr_rec_id[i]  = ingr_rec_cntr;
      end
      else
      begin //Simple incremental ordering is followed for simultaneous ingress requests
        assign  chnnl_ingr_rec_id[i]  = chnnl_ingr_rec_id[i-1]  + chnnl_ingr_wren[i-1];
      end
    end
  endgenerate

  /*  Convert OneHot to Binary  */
  IW_fpga_onehot2bin #(
     .ONEHOT_WIDTH    (NUM_CHANNELS)
    ,.BIN_WIDTH       (NUM_CHANNELS_BIN)

  ) u_onehot2bin  (

     .onehot_i        (chnnl_egr_valid)
    ,.bin_o           (chnnl_egr_valid_bin)

  );


endmodule //IW_fpga_jem_record_mngr
