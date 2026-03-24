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
 -- Module Name       : IW_fpga_avst2mm
 -- Author            : Gregory James
 -- Associated modules: 
 -- Function          : This module converts Avalon-Streaming protocol
                        to Avalon-Memory-Mapped
 --------------------------------------------------------------------------
*/

`timescale 1ns / 10ps


module IW_fpga_avst2mm #(
   parameter  AVMM_ADDR_W         = 16  //Will help a lot if AVMM_ADDR_W & AVMM_DATA_W are multiples of AVST_SYMBOL_W
  ,parameter  AVMM_DATA_W         = 32

  ,parameter  AVST_SYMBOL_W       = 8
  ,parameter  AVST_CHANNEL_W      = 8
  ,parameter  AVST_DATA_W         = 1*AVST_SYMBOL_W

  ,parameter  RD_RSP_FF_MAX_DEPTH = 16

) (

   input  logic                             clk
  ,input  logic                             rst_n

  /*  AV-MM Interface */
  ,input  logic                             avmm_waitrequest
  ,output logic [AVMM_ADDR_W-1:0]           avmm_address
  ,output logic                             avmm_read
  ,output logic                             avmm_write
  ,output logic [AVMM_DATA_W-1:0]           avmm_writedata
  ,output logic [(AVMM_DATA_W/8)-1:0]       avmm_byteenable
  ,input  logic                             avmm_readdatavalid
  ,input  logic [AVMM_DATA_W-1:0]           avmm_readdata

  /*  AV-ST Request Interface */
  ,output logic                             avst_req_ready
  ,input  logic                             avst_req_valid
  ,input  logic                             avst_req_sop
  ,input  logic                             avst_req_eop
  ,input  logic [AVST_CHANNEL_W-1:0]        avst_req_channel
  ,input  logic [AVST_DATA_W-1:0]           avst_req_data

  /*  AV-ST Response Interface */
  ,input  logic                             avst_rsp_ready
  ,output logic                             avst_rsp_valid
  ,output logic                             avst_rsp_sop
  ,output logic                             avst_rsp_eop
  ,output logic [AVST_CHANNEL_W-1:0]        avst_rsp_channel
  ,output logic [AVST_DATA_W-1:0]           avst_rsp_data

);

//----------------------- Import Packages ---------------------------------


//----------------------- Internal Parameters -----------------------------
  localparam  CMD_W                 = 1*AVST_SYMBOL_W;
  localparam  AVMM_BYTE_EN_REMAP_W  = ((AVMM_DATA_W/8)  % AVST_SYMBOL_W)  ? (((AVMM_DATA_W/8)  / AVST_SYMBOL_W) + 1)*AVST_SYMBOL_W : ((AVMM_DATA_W/8) / AVST_SYMBOL_W)*AVST_SYMBOL_W;

  localparam  REQ_ADDR_W            = AVMM_ADDR_W-AVST_CHANNEL_W;
  localparam  REQ_PKT_SIZE          = CMD_W + REQ_ADDR_W  + AVMM_DATA_W + AVMM_BYTE_EN_REMAP_W;
  localparam  REQ_PKT_NUM_FLITS     = (REQ_PKT_SIZE % AVST_DATA_W)  ? (REQ_PKT_SIZE / AVST_DATA_W) + 1 : REQ_PKT_SIZE / AVST_DATA_W;
  localparam  REQ_PKT_FLIT_CNTR_W   = $clog2(REQ_PKT_NUM_FLITS) + 1;

  localparam  READ_RSP_FF_ADDR_W    = $clog2(RD_RSP_FF_MAX_DEPTH);
  localparam  READ_RSP_FF_USED_W    = READ_RSP_FF_ADDR_W+1;
  localparam  READ_RSP_FF_THRSHLD   = RD_RSP_FF_MAX_DEPTH-8;
  localparam  RSP_PKT_SIZE          = CMD_W + AVMM_DATA_W;
  localparam  RSP_PKT_NUM_FLITS     = (RSP_PKT_SIZE % AVST_DATA_W)  ? (RSP_PKT_SIZE / AVST_DATA_W) + 1 : RSP_PKT_SIZE / AVST_DATA_W;
  localparam  RSP_PKT_FLIT_CNTR_W   = $clog2(RSP_PKT_NUM_FLITS) + 1;

  localparam  READ_REQ_CMD_VAL      = 0;
  localparam  WRITE_REQ_CMD_VAL     = 1;
  localparam  READ_RSP_CMD_VAL      = 2;

  genvar  i;

//----------------------- Internal Register Declarations ------------------


//----------------------- Internal Wire Declarations ----------------------
  logic [CMD_W-1:0]                 req_pkt_cmd;
  logic [REQ_PKT_SIZE-1:0]          req_pkt_payload;
  logic [REQ_PKT_FLIT_CNTR_W-1:0]   req_pkt_flit_cntr;
  logic                             req_pkt_last_flit;
  logic [AVST_CHANNEL_W-1:0]        req_curr_chnnl;

  logic [AVMM_DATA_W-1:0]           read_rsp_ff_rdata;
  logic                             read_rsp_ff_rdempty;
  logic                             read_rsp_ff_rdreq;
  logic [READ_RSP_FF_USED_W-1:0]    read_rsp_ff_wrusedw;
  logic                             read_rsp_ff_afull;
  logic [CMD_W-1:0]                 rsp_pkt_cmd;
  logic [RSP_PKT_SIZE-1:0]          rsp_pkt_payload;
  logic [AVST_DATA_W-1:0]           rsp_pkt_payload_flits [RSP_PKT_NUM_FLITS-1:0];
  logic [RSP_PKT_FLIT_CNTR_W-1:0]   rsp_pkt_flit_cntr;
  logic                             rsp_pkt_last_flit;


//----------------------- Start of Code -----------------------------------

  /*  Request Logic */
  always@(posedge clk,  negedge rst_n)
  begin
    if(~rst_n)
    begin
      avmm_read               <=  0;
      avmm_write              <=  0;

      req_pkt_payload         <=  0;
      req_pkt_flit_cntr       <=  0;
      req_curr_chnnl          <=  0;
    end
    else
    begin
      if(avst_req_ready & avst_req_valid)
      begin
        req_curr_chnnl        <=  avst_req_sop  ? avst_req_channel  : req_curr_chnnl;
        req_pkt_payload       <=  {avst_req_data,req_pkt_payload[REQ_PKT_SIZE-1:AVST_DATA_W]};
        req_pkt_flit_cntr     <=  req_pkt_last_flit ? 0 : req_pkt_flit_cntr + 1'b1;
      end

      if(avmm_read  | avmm_write) //Wait for this xtn to be accepted
      begin
        if(avmm_waitrequest)
        begin
          avmm_read           <=  avmm_read;
          avmm_write          <=  avmm_write;
        end
        else if(avst_req_ready  & avst_req_valid  & req_pkt_last_flit)  //Back-to-Back transactions
        begin
          avmm_read           <=  (req_pkt_cmd  ==  READ_REQ_CMD_VAL)   ? 1'b1  : 1'b0;
          avmm_write          <=  (req_pkt_cmd  ==  WRITE_REQ_CMD_VAL)  ? 1'b1  : 1'b0;
        end
        else
        begin
          avmm_read           <=  0;
          avmm_write          <=  0;
        end
      end
      else if(avst_req_ready  & avst_req_valid  & req_pkt_last_flit)  //Wait for complete request to be received
      begin
        avmm_read             <=  (req_pkt_cmd  ==  READ_REQ_CMD_VAL)   ? 1'b1  : 1'b0;
        avmm_write            <=  (req_pkt_cmd  ==  WRITE_REQ_CMD_VAL)  ? 1'b1  : 1'b0;
      end
      else
      begin
        avmm_read             <=  0;
        avmm_write            <=  0;
      end
    end
  end

  //Check if last flit is being received
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

  //Backpressure Request Bus
  assign  avst_req_ready  = (((avmm_read | avmm_write) & avmm_waitrequest) | read_rsp_ff_afull) ? 1'b0  : 1'b1;

  //Tap fields from req_pkt payload
  assign  req_pkt_cmd     = req_pkt_payload[AVST_DATA_W +:  CMD_W]; //Tap 1 cycle early
  assign  avmm_address    = {req_curr_chnnl,req_pkt_payload[CMD_W +:  REQ_ADDR_W]};
  assign  avmm_writedata  = req_pkt_payload[(CMD_W+REQ_ADDR_W)  +:  AVMM_DATA_W];
  assign  avmm_byteenable = req_pkt_payload[(CMD_W+REQ_ADDR_W+AVMM_DATA_W)  +: (AVMM_DATA_W/8)]; 


  /*  Instantiate buffer to hold read responses */
  IW_fpga_async_fifo #(
    .ADDR_WD        (READ_RSP_FF_ADDR_W),
    .DATA_WD        (AVMM_DATA_W),
    .USE_RAM_MEMORY ("False")

  ) u_read_rsp_ff (

    .rstn           (rst_n),
    .data           (avmm_readdata),
    .rdclk          (clk),
    .rdreq          (read_rsp_ff_rdreq),
    .wrclk          (clk),
    .wrreq          (avmm_readdatavalid),
    .q              (read_rsp_ff_rdata),
    .rdempty        (read_rsp_ff_rdempty),
    .rdusedw        (),
    .wrfull         (),
    .wrusedw        (read_rsp_ff_wrusedw)
  );

  assign  read_rsp_ff_afull = (read_rsp_ff_wrusedw  >=  READ_RSP_FF_THRSHLD)  ? 1'b1  : 1'b0;


  /*  Response  Command Logic */
  assign  rsp_pkt_cmd = READ_RSP_CMD_VAL;

  /*  Pack fields into response packet  */
  assign  rsp_pkt_payload = {read_rsp_ff_rdata,rsp_pkt_cmd};

  generate
    for(i=0;i<RSP_PKT_NUM_FLITS;i++)
    begin : gen_rsp_pkt_payload_flits
      assign  rsp_pkt_payload_flits[i]  = rsp_pkt_payload[(i*AVST_DATA_W) +:  AVST_DATA_W];
    end
  endgenerate

  /*  Response Logic */
  always@(posedge clk,  negedge rst_n)
  begin
    if(~rst_n)
    begin
      avst_rsp_valid          <=  0;
      avst_rsp_sop            <=  0;
      avst_rsp_eop            <=  0;
      avst_rsp_data           <=  0;

      rsp_pkt_flit_cntr       <=  0;
    end
    else
    begin
      if(~read_rsp_ff_rdempty)
      begin
        if(avst_rsp_ready)
        begin
          avst_rsp_valid        <=  1'b1;
          avst_rsp_sop          <=  (rsp_pkt_flit_cntr  ==  0)  ? 1'b1  : 1'b0;
          avst_rsp_eop          <=  rsp_pkt_last_flit;
          avst_rsp_data         <=  rsp_pkt_payload_flits[rsp_pkt_flit_cntr];

          rsp_pkt_flit_cntr     <=  rsp_pkt_last_flit ? 0 : rsp_pkt_flit_cntr + 1'b1;
        end
        else
        begin
          avst_rsp_valid        <=  avst_rsp_valid;
          avst_rsp_sop          <=  avst_rsp_sop;
          avst_rsp_eop          <=  avst_rsp_eop;
          avst_rsp_data         <=  avst_rsp_data;

          rsp_pkt_flit_cntr     <=  rsp_pkt_flit_cntr;
        end
      end
      else
      begin
        avst_rsp_valid          <=  1'b0;
        avst_rsp_sop            <=  1'b0;
        avst_rsp_eop            <=  1'b0;
        avst_rsp_data           <=  avst_rsp_data;

        rsp_pkt_flit_cntr       <=  0;
      end
    end
  end

  assign  avst_rsp_channel  = 0;

  //Check if last flit is being sent
  generate
    if(RSP_PKT_NUM_FLITS  > 1)
    begin
      assign  rsp_pkt_last_flit = (rsp_pkt_flit_cntr  ==  RSP_PKT_NUM_FLITS-1)  ? 1'b1  : 1'b0;
    end
    else  //There is only one flit
    begin
      assign  rsp_pkt_last_flit = 1'b1;
    end
  endgenerate

  //Generate read-ack to fifo
  assign  read_rsp_ff_rdreq = (rsp_pkt_last_flit  & avst_rsp_valid  & avst_rsp_ready);


endmodule // IW_fpga_avst2mm
