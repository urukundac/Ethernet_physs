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
 -- Module Name       : IW_fpga_avst_dbg_master
 -- Author            : Gregory James
 -- Associated modules: 
 -- Function          : This module acts as a master node for driving transactions
                        on the debug-avst interfaces
 --------------------------------------------------------------------------
*/

`timescale 1ns / 10ps


module IW_fpga_avst_dbg_master #(
   parameter  AVMM_ADDR_W     = 16  //Will help a lot if AVMM_ADDR_W & AVMM_DATA_W are multiples of AVST_SYMBOL_W
  ,parameter  AVMM_DATA_W     = 32

  ,parameter  AVST_SYMBOL_W   = 8
  ,parameter  AVST_CHANNEL_W  = 8
  ,parameter  AVST_DATA_W     = 1*AVST_SYMBOL_W

  ,parameter  FLOP_AVST_PORTS = 1
  ,parameter  USE_SOP_EOP     = 1

) (

   input  logic                             avmm_clk
  ,input  logic                             avmm_rst_n

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

  ,input  logic                             avst_rsp_clk
  ,input  logic                             avst_rsp_rst_n

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
  localparam  RSP_FF_DATA_WIDTH   = 1+1+AVST_CHANNEL_W+AVST_DATA_W;
  localparam  AVST_BUF_DATA_WIDTH = 1+1+AVST_CHANNEL_W+AVST_DATA_W;


//----------------------- Internal Register Declarations ------------------


//----------------------- Internal Wire Declarations ----------------------
  wire                            avst_req_ready_buf_w;
  wire                            avst_req_valid_buf_w;
  wire                            avst_req_sop_buf_w;
  wire                            avst_req_eop_buf_w;
  wire  [AVST_CHANNEL_W-1:0]      avst_req_channel_buf_w;
  wire  [AVST_DATA_W-1:0]         avst_req_data_buf_w;

  wire                            avst_rsp_ready_buf_w;
  wire                            avst_rsp_valid_buf_w;
  wire                            avst_rsp_sop_buf_w;
  wire                            avst_rsp_eop_buf_w;
  wire  [AVST_CHANNEL_W-1:0]      avst_rsp_channel_buf_w;
  wire  [AVST_DATA_W-1:0]         avst_rsp_data_buf_w;

  wire  [RSP_FF_DATA_WIDTH-1:0]   rsp_ff_wdata;
  wire  [RSP_FF_DATA_WIDTH-1:0]   rsp_ff_rdata;
  wire                            rsp_ff_empty;
  wire                            rsp_ff_full;

  wire                            avst_rsp_sync_ready;
  wire                            avst_rsp_sync_valid;
  wire                            avst_rsp_sync_sop;
  wire                            avst_rsp_sync_eop;
  wire  [AVST_CHANNEL_W-1:0]      avst_rsp_sync_channel;
  wire  [AVST_DATA_W-1:0]         avst_rsp_sync_data;


//----------------------- Start of Code -----------------------------------

  /*  Buffer AVST Ports */
  generate
    if(FLOP_AVST_PORTS)
    begin
      wire  [AVST_BUF_DATA_WIDTH-1:0] avst_req_buf_data_in_w;
      wire  [AVST_BUF_DATA_WIDTH-1:0] avst_req_buf_data_out_w;
      wire  [AVST_BUF_DATA_WIDTH-1:0] avst_rsp_buf_data_in_w;
      wire  [AVST_BUF_DATA_WIDTH-1:0] avst_rsp_buf_data_out_w;

      /*  Request Interface */
      assign  avst_req_buf_data_in_w  = {  avst_req_sop_buf_w
                                          ,avst_req_eop_buf_w
                                          ,avst_req_channel_buf_w
                                          ,avst_req_data_buf_w
                                        };

      IW_fpga_double_buffer #(
        .WIDTH  (AVST_BUF_DATA_WIDTH)

      ) u_avst_req_buf  (

        .clk          (avmm_clk)
       ,.rst_n        (avmm_rst_n)

       ,.status       ()

       ,.in_ready     (avst_req_ready_buf_w)
       ,.in_valid     (avst_req_valid_buf_w)
       ,.in_data      (avst_req_buf_data_in_w)

       ,.out_ready    (avst_req_ready)
       ,.out_valid    (avst_req_valid)
       ,.out_data     (avst_req_buf_data_out_w)

      );

      assign  {  avst_req_sop
                ,avst_req_eop
                ,avst_req_channel
                ,avst_req_data
              } = avst_req_buf_data_out_w;


      /*  Response Interface */
      assign  avst_rsp_buf_data_in_w  = {  avst_rsp_sop
                                          ,avst_rsp_eop
                                          ,avst_rsp_channel
                                          ,avst_rsp_data
                                        };

      IW_fpga_double_buffer #(
        .WIDTH  (AVST_BUF_DATA_WIDTH)

      ) u_avst_rsp_buf  (

        .clk          (avst_rsp_clk)
       ,.rst_n        (avst_rsp_rst_n)

       ,.status       ()

       ,.in_ready     (avst_rsp_ready)
       ,.in_valid     (avst_rsp_valid)
       ,.in_data      (avst_rsp_buf_data_in_w)

       ,.out_ready    (avst_rsp_ready_buf_w)
       ,.out_valid    (avst_rsp_valid_buf_w)
       ,.out_data     (avst_rsp_buf_data_out_w)

      );

      assign  {  avst_rsp_sop_buf_w
                ,avst_rsp_eop_buf_w
                ,avst_rsp_channel_buf_w
                ,avst_rsp_data_buf_w
              } = avst_rsp_buf_data_out_w;
    end
    else
    begin
      assign  avst_req_ready_buf_w    = avst_req_ready;
      assign  avst_req_valid          = avst_req_valid_buf_w;
      assign  avst_req_sop            = avst_req_sop_buf_w;
      assign  avst_req_eop            = avst_req_eop_buf_w;
      assign  avst_req_channel        = avst_req_channel_buf_w;
      assign  avst_req_data           = avst_req_data_buf_w;

      assign  avst_rsp_ready          = avst_rsp_ready_buf_w;
      assign  avst_rsp_valid_buf_w    = avst_rsp_valid;
      assign  avst_rsp_sop_buf_w      = avst_rsp_sop;
      assign  avst_rsp_eop_buf_w      = avst_rsp_eop;
      assign  avst_rsp_channel_buf_w  = avst_rsp_channel;
      assign  avst_rsp_data_buf_w     = avst_rsp_data;
    end
  endgenerate

  /*  Instantiate AVMM-to-ST bridge */
  IW_fpga_avmm2st #(
     .AVMM_ADDR_W         (AVMM_ADDR_W   )
    ,.AVMM_DATA_W         (AVMM_DATA_W   )

    ,.AVST_SYMBOL_W       (AVST_SYMBOL_W )
    ,.AVST_CHANNEL_W      (AVST_CHANNEL_W)
    ,.AVST_DATA_W         (AVST_DATA_W   )
    ,.USE_SOP_EOP         (USE_SOP_EOP   )

  ) u_IW_fpga_avmm2st (

     .clk                 (avmm_clk                 )
    ,.rst_n               (avmm_rst_n               )

    ,.avmm_waitrequest    (avmm_waitrequest         )
    ,.avmm_address        (avmm_address             )
    ,.avmm_read           (avmm_read                )
    ,.avmm_write          (avmm_write               )
    ,.avmm_writedata      (avmm_writedata           )
    ,.avmm_byteenable     (avmm_byteenable          )
    ,.avmm_readdatavalid  (avmm_readdatavalid       )
    ,.avmm_readdata       (avmm_readdata            )

    ,.avst_req_ready      (avst_req_ready_buf_w     )
    ,.avst_req_valid      (avst_req_valid_buf_w     )
    ,.avst_req_sop        (avst_req_sop_buf_w       )
    ,.avst_req_eop        (avst_req_eop_buf_w       )
    ,.avst_req_channel    (avst_req_channel_buf_w   )
    ,.avst_req_data       (avst_req_data_buf_w      )

    ,.avst_rsp_ready      (avst_rsp_sync_ready      )
    ,.avst_rsp_valid      (avst_rsp_sync_valid      )
    ,.avst_rsp_sop        (avst_rsp_sync_sop        )
    ,.avst_rsp_eop        (avst_rsp_sync_eop        )
    ,.avst_rsp_channel    (avst_rsp_sync_channel    )
    ,.avst_rsp_data       (avst_rsp_sync_data       )

  );

  /*  FIFO for buffering responses  */
  IW_fpga_async_fifo #(
     .USE_RAM_MEMORY  ("True")
    ,.ADDR_WD         (4)
    ,.DATA_WD         (RSP_FF_DATA_WIDTH)

  ) u_rsp_fifo  (

     .rstn            (avst_rsp_rst_n & avmm_rst_n)
    ,.data            (rsp_ff_wdata)
    ,.rdclk           (avmm_clk)
    ,.rdreq           (avst_rsp_sync_ready  & ~rsp_ff_empty)
    ,.wrclk           (avst_rsp_clk)
    ,.wrreq           (avst_rsp_valid_buf_w & avst_rsp_ready_buf_w)
    ,.q               (rsp_ff_rdata)
    ,.rdempty         (rsp_ff_empty)
    ,.rdusedw         ()
    ,.wrfull          (rsp_ff_full)
    ,.wrusedw         ()

  );

  assign  rsp_ff_wdata  = {  avst_rsp_sop_buf_w
                            ,avst_rsp_eop_buf_w
                            ,avst_rsp_channel_buf_w
                            ,avst_rsp_data_buf_w
                          };

  assign  {  avst_rsp_sync_sop
            ,avst_rsp_sync_eop
            ,avst_rsp_sync_channel
            ,avst_rsp_sync_data
          } = rsp_ff_rdata;

  assign  avst_rsp_sync_valid   = ~rsp_ff_empty;

  assign  avst_rsp_ready_buf_w  = ~rsp_ff_full;

endmodule // IW_fpga_avst_dbg_master
