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

/*
 --------------------------------------------------------------------------
 -- Project Code      : IMPrES
 -- Module Name       : IW_fpga_avmm2st
 -- Author            : Gregory James
 -- Associated modules: 
 -- Function          : This module converts Avalon-Memory-Mapped protocol
                        to Avalon-Streaming
 --------------------------------------------------------------------------
*/

`timescale 1ns / 10ps


module IW_fpga_avmm2st #(
   parameter  AVMM_ADDR_W     = 16  //Will help a lot if AVMM_ADDR_W & AVMM_DATA_W are multiples of AVST_SYMBOL_W
  ,parameter  AVMM_DATA_W     = 32

  ,parameter  AVST_SYMBOL_W   = 8
  ,parameter  AVST_CHANNEL_W  = 8
  ,parameter  AVST_DATA_W     = 1*AVST_SYMBOL_W
  ,parameter  DEFAULT_RSP     = 1  // This option will send Default read after timeout

  ,parameter  USE_SOP_EOP     = 1

) (

   input  logic                             clk
  ,input  logic                             rst_n

  /*  AV-MM Interface */
  ,output logic                             avmm_waitrequest
  ,input  logic [AVMM_ADDR_W-1:0]           avmm_address
  ,input  logic                             avmm_read
  ,input  logic                             avmm_write
  ,input  logic [AVMM_DATA_W-1:0]           avmm_writedata
  ,input  logic [(AVMM_DATA_W/8)-1:0]       avmm_byteenable
  ,output logic                             avmm_readdatavalid
  ,output logic [AVMM_DATA_W-1:0]           avmm_readdata

  /*  AV-ST Request Interface */
  ,input  logic                             avst_req_ready
  ,output logic                             avst_req_valid
  ,output logic                             avst_req_sop
  ,output logic                             avst_req_eop
  ,output logic [AVST_CHANNEL_W-1:0]        avst_req_channel
  ,output logic [AVST_DATA_W-1:0]           avst_req_data

  /*  AV-ST Response Interface */
  ,output logic                             avst_rsp_ready
  ,input  logic                             avst_rsp_valid
  ,input  logic                             avst_rsp_sop
  ,input  logic                             avst_rsp_eop
  ,input  logic [AVST_CHANNEL_W-1:0]        avst_rsp_channel
  ,input  logic [AVST_DATA_W-1:0]           avst_rsp_data

);

//----------------------- Import Packages ---------------------------------


//----------------------- Internal Parameters -----------------------------
  localparam  CMD_W                 = 1*AVST_SYMBOL_W;
  localparam  AVMM_BYTE_EN_REMAP_W  = ((AVMM_DATA_W/8)  % AVST_SYMBOL_W)  ? (((AVMM_DATA_W/8)  / AVST_SYMBOL_W) + 1)*AVST_SYMBOL_W : ((AVMM_DATA_W/8) / AVST_SYMBOL_W)*AVST_SYMBOL_W;

  localparam  REQ_ADDR_W            = AVMM_ADDR_W-AVST_CHANNEL_W;
  localparam  REQ_PKT_SIZE          = CMD_W + REQ_ADDR_W  + AVMM_DATA_W + AVMM_BYTE_EN_REMAP_W;
  localparam  REQ_PKT_NUM_FLITS     = (REQ_PKT_SIZE % AVST_DATA_W)  ? (REQ_PKT_SIZE / AVST_DATA_W) + 1 : REQ_PKT_SIZE / AVST_DATA_W;
  localparam  REQ_PKT_FLIT_CNTR_W   = $clog2(REQ_PKT_NUM_FLITS) + 1;

  localparam  RSP_PKT_SIZE          = CMD_W + AVMM_DATA_W;
  localparam  RSP_PKT_NUM_FLITS     = (RSP_PKT_SIZE % AVST_DATA_W)  ? (RSP_PKT_SIZE / AVST_DATA_W) + 1 : RSP_PKT_SIZE / AVST_DATA_W;
  localparam  RSP_PKT_FLIT_CNTR_W   = $clog2(RSP_PKT_NUM_FLITS) + 1;

  localparam  READ_REQ_CMD_VAL      = 0;
  localparam  WRITE_REQ_CMD_VAL     = 1;
  localparam  READ_RSP_CMD_VAL      = 2;

  localparam  TIMEOUT_W             = 16;
  localparam  TIMEOUT_VALUE         = 16'hffff;
  localparam  DEFAULT_RSP_DATA      = 'hDEADBABA;
  genvar  i;

//----------------------- Internal Register Declarations ------------------


//----------------------- Internal Wire Declarations ----------------------
  logic                             avmm_read_valid;
  logic                             avmm_write_valid;
  logic [AVMM_BYTE_EN_REMAP_W-1:0]  avmm_byteenable_remap;
  logic                             avmm_default_readvalid;
  logic                             avmm_rsp_readvalid;

  logic [CMD_W-1:0]                 req_pkt_cmd;
  logic [REQ_PKT_SIZE-1:0]          req_pkt_payload_w;
  logic [REQ_PKT_SIZE-1:0]          req_pkt_payload;
  logic [AVST_DATA_W-1:0]           req_pkt_payload_flits [REQ_PKT_NUM_FLITS-1:0];
  logic [REQ_PKT_FLIT_CNTR_W-1:0]   req_pkt_flit_cntr;
  logic                             req_pkt_last_flit;

  logic [CMD_W-1:0]                 rsp_pkt_cmd;
  logic [RSP_PKT_SIZE-1:0]          rsp_pkt_payload;
  logic [RSP_PKT_FLIT_CNTR_W-1:0]   rsp_pkt_flit_cntr;
  logic                             rsp_pkt_last_flit;
  logic [TIMEOUT_W-1:0]             timeout_counter;
  logic                             read_pending;


//----------------------- Start of Code -----------------------------------

  /*  Remap Byte-Enable */
  always@(*)
  begin
    avmm_byteenable_remap = 0;
    avmm_byteenable_remap[(AVMM_DATA_W/8)-1:0]  = avmm_byteenable;
  end

  /*  Request Command Logic */
  assign  req_pkt_cmd = avmm_read_valid  ? READ_REQ_CMD_VAL  :
                        avmm_write_valid ? WRITE_REQ_CMD_VAL :
                                           'hFF;

  /*  Read and Write are valid when wait_request is low  */
  assign  avmm_read_valid       =  avmm_read  & !avmm_waitrequest;
  assign  avmm_write_valid      =  avmm_write & !avmm_waitrequest;

  /*  Pack request fields */
  assign  req_pkt_payload_w = {  avmm_byteenable_remap
                                ,avmm_writedata
                                ,avmm_address[REQ_ADDR_W-1:0]
                                ,req_pkt_cmd
                              };


  generate
    for(i=0;i<REQ_PKT_NUM_FLITS;i++)
    begin : gen_req_pkt_payload_flits
      assign  req_pkt_payload_flits[i]  = (avmm_read_valid | avmm_write_valid) ? req_pkt_payload_w[(i*AVST_DATA_W) +:  AVST_DATA_W]: req_pkt_payload[(i*AVST_DATA_W) +:  AVST_DATA_W];
    end
  endgenerate

  /*  Request Logic */
  always@(posedge clk,  negedge rst_n)
  begin
    if(~rst_n)
    begin
      avst_req_valid          <=  0;
      avst_req_sop            <=  0;
      avst_req_eop            <=  0;
      avst_req_channel        <=  0;
      avst_req_data           <=  0;
      req_pkt_payload         <=  0;

      req_pkt_flit_cntr       <=  0;
    end
    else
    begin
      /*  Pack request fields */
      req_pkt_payload       <=  (avmm_read_valid | avmm_write_valid) ? req_pkt_payload_w : req_pkt_payload ;

      if(avst_req_valid)  //In the middle of transmission
      begin
        if(avst_req_ready)
        begin
          avst_req_valid        <=  ~avst_req_eop;
          avst_req_sop          <=  1'b0;
          avst_req_eop          <=  req_pkt_last_flit;
          avst_req_channel      <=  avst_req_channel;
          avst_req_data         <=  req_pkt_payload_flits[req_pkt_flit_cntr];

          req_pkt_flit_cntr     <=  (req_pkt_last_flit  | avst_req_eop) ? 0 : req_pkt_flit_cntr + 1'b1;
        end
        else
        begin
          avst_req_valid        <=  avst_req_valid;
          avst_req_sop          <=  avst_req_sop;
          avst_req_eop          <=  avst_req_eop;
          avst_req_channel      <=  avst_req_channel;
          avst_req_data         <=  avst_req_data;

          req_pkt_flit_cntr     <=  req_pkt_flit_cntr;
        end
      end
      else  //Idle
      begin
        if(avmm_read_valid | avmm_write_valid)
        begin
          avst_req_valid        <=  1'b1;
          avst_req_sop          <=  1'b1;
          avst_req_eop          <=  req_pkt_last_flit;
          avst_req_channel      <=  avmm_address[(AVMM_ADDR_W-1)  -:  AVST_CHANNEL_W];  //Upper bits of avmm-address are used for channel
          avst_req_data         <=  req_pkt_payload_flits[req_pkt_flit_cntr];

          req_pkt_flit_cntr     <=  req_pkt_last_flit ? 0 : req_pkt_flit_cntr + 1'b1;
        end
      end
    end
  end

  //Check if last flit is being transferred
  generate
    if(REQ_PKT_NUM_FLITS  > 1)
    begin
      assign  req_pkt_last_flit = (req_pkt_flit_cntr  ==  REQ_PKT_NUM_FLITS-1)  ? 1'b1  : 1'b0;
    end
    else  //There is only one flit
    begin
      assign  req_pkt_last_flit = 1'b1;
    end
  endgenerate

  //Backpressure request bus
  assign  avmm_waitrequest  = avst_req_valid | !avst_req_ready;


  /*  Response  Logic */
  always@(posedge clk,  negedge rst_n)
  begin
    if(~rst_n)
    begin
      rsp_pkt_payload         <=  0;

      avmm_default_readvalid  <=  0;
      avmm_rsp_readvalid      <=  0;

      timeout_counter         <=  0;
      read_pending            <=  0;
    end
    else
    begin
      read_pending            <= avmm_read_valid ? 1'b1 : (avmm_readdatavalid ? 1'b0 : read_pending) ;
      timeout_counter         <= DEFAULT_RSP     ? (read_pending    ? timeout_counter + 1 : 0 ) : 0 ;

      if(avst_rsp_ready & avst_rsp_valid)
      begin
        rsp_pkt_payload       <=  {avst_rsp_data,rsp_pkt_payload[RSP_PKT_SIZE-1:AVST_DATA_W]};
      end

      avmm_default_readvalid  <=  (timeout_counter  == TIMEOUT_VALUE)  ? 1'b1 : 1'b0;
      avmm_rsp_readvalid      <=  (rsp_pkt_cmd == READ_RSP_CMD_VAL) ? rsp_pkt_last_flit & avst_rsp_ready  & avst_rsp_valid  : 1'b0;
    end
  end

  // handling of rsp_pkt_flit_cntr under EOP condition and non-EOP condition
	// non-EOP condition assumes transactions are continous
	always @(posedge clk, negedge rst_n) begin
	  if(~rst_n)
      rsp_pkt_flit_cntr       <=  0;
    else begin
      if(avst_rsp_ready & avst_rsp_valid)
        rsp_pkt_flit_cntr     <=  rsp_pkt_last_flit ? 0 : rsp_pkt_flit_cntr + 1'b1;
      else
        rsp_pkt_flit_cntr     <=  (USE_SOP_EOP == 0) ? 0 : rsp_pkt_flit_cntr;
    end
	end

  //Read data and Valid signal
  assign  avmm_readdata      = avmm_default_readvalid ? DEFAULT_RSP_DATA : rsp_pkt_payload[CMD_W +:  AVMM_DATA_W];
  assign  avmm_readdatavalid = (DEFAULT_RSP && avmm_default_readvalid) || avmm_rsp_readvalid;

  //Check if last flit is being received
  generate
    if(USE_SOP_EOP == 1) begin
      always @(posedge clk) begin
        if(avst_rsp_sop & avst_rsp_ready & avst_rsp_valid)
      		rsp_pkt_cmd <= avst_rsp_data[0 +: CMD_W]; 
      end

      assign rsp_pkt_last_flit = avst_rsp_ready & avst_rsp_valid & avst_rsp_eop;
    end else begin
      //Tap fields from rsp_pkt_payload
      assign  rsp_pkt_cmd        = rsp_pkt_payload[AVST_DATA_W +:  CMD_W]; //tap 1 cycle early

      // Only response to be handled is Read response in case of sysFPGA
      assign rsp_pkt_last_flit = avst_rsp_ready & avst_rsp_valid & (rsp_pkt_flit_cntr == 4);
    end
  endgenerate

  //Always ready to receive responses
  assign  avst_rsp_ready  = 1'b1;

endmodule // IW_fpga_avmm2st
