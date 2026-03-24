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

`include "onpi100g_jem_mon.vh"

module IW_fpga_onpi100g_mon_av #(
    parameter MON_TYPE              = "onpi"                    //Should be either pmsb or gpsb
  , parameter INSTANCE_NAME         = "u_onpi_mon_av"           //Can hold upto 16 ASCII characters
  , parameter ONPI100G_Q_IDX        = 0                         //Partition id for mreq record

  , parameter AV_MM_DATA_W          = 32
  , parameter AV_MM_ADDR_W          = 8

  , parameter AV_ST_SYMBOL_W        = 8
  , parameter AV_ST_DATA_W          = 8
  , parameter AV_ST_EMPTY_W         = (AV_ST_DATA_W <= AV_ST_SYMBOL_W) ? 1 : $clog2(AV_ST_DATA_W/AV_ST_SYMBOL_W)
  , parameter AV_ST_USE_BIG_ENDIAN  = 1

  , parameter READ_MISS_VAL         = 32'hDEADBABE              // Read miss value

) (
  /*  Logic Interface */
    input    logic                        clk_logic
  , input    logic                        rst_logic_n
  , input    logic [31:0]                 data0
  , input    logic [31:0]                 data1
  , input    logic [31:0]                 data2
  , input    logic [31:0]                 data3
  , input    logic [3:0]                  ctl0
  , input    logic [3:0]                  ctl1
  , input    logic [3:0]                  ctl2
  , input    logic [3:0]                  ctl3
  , input    logic [7:0]                  mdata0
  , input    logic [7:0]                  mdata1
  , input    logic [7:0]                  mdata2
  , input    logic [7:0]                  mdata3
  , input    logic [7:0]                  mdata4
  , input    logic [7:0]                  mdata5
  , input    logic [7:0]                  mdata6
  , input    logic [7:0]                  mdata7
  , input    logic                        msdata
  , input    logic                        linkup
  , input    logic                        lp_linkup
  , input    logic [7:0]                  speed
  , input    logic [7:0]                  xoff

  /*  IOSF-SB Debug Interface */
  , input  logic                          clk_dbg_av
  , input  logic                          rst_dbg_av_n

  //Avalon-MM interface
  , input  wire [AV_MM_ADDR_W-1:0]        avl_mm_address
  , output reg  [AV_MM_DATA_W-1:0]        avl_mm_readdata
  , input  wire                           avl_mm_read
  , output reg                            avl_mm_readdatavalid
  , input  wire                           avl_mm_write
  , input  wire [AV_MM_DATA_W-1:0]        avl_mm_writedata
  , input  wire [(AV_MM_DATA_W/8)-1:0]    avl_mm_byteenable
  , output wire                           avl_mm_waitrequest

  //Avalon-ST interface
  , input  reg                            avl_st_ready
  , output reg                            avl_st_valid
  , output reg                            avl_st_startofpacket
  , output reg                            avl_st_endofpacket
  , output reg  [AV_ST_EMPTY_W-1:0]       avl_st_empty
  , output reg  [AV_ST_DATA_W-1:0]        avl_st_data

);

  //import onpi100g_jem_pkg::*;

  /*  Internal  Parameters  */
  //localparam  JEM_RECORD_WIDTH    = $bits(onpi100g_xctn_t);
  localparam  JEM_RECORD_WIDTH    = $bits(onpi100g_xctn_t);

  localparam  NUM_CAP_INTFS       = 1;
  localparam  int CHNL_Q_IDX_LIST  [NUM_CAP_INTFS-1:0]    = '{ONPI100G_Q_IDX};//queue index list for capture channel

  localparam  RECORD_ID_WIDTH     = 0;
  localparam  int CHNL_DATA_W_LIST [NUM_CAP_INTFS-1:0]    = '{JEM_RECORD_WIDTH};

  parameter   int DBG_CAP_DATA_WIDTH_LIST [NUM_CAP_INTFS-1:0] = '{JEM_RECORD_WIDTH};
  localparam  DBG_CAP_DATA_WIDTH_MAX  = 256;  //Should accomodate the maximum value in DBG_CAP_DATA_WIDTH_LIST


  /*  Internal  Wires */
  wire  side_clkreq;
  wire  side_clk_ack;

  wire  [$clog2(NUM_CAP_INTFS)-1:0]   cap_rdata_valid_bin;
  wire  [NUM_CAP_INTFS-1:0]           cap_rdata_valid;
  wire  [DBG_CAP_DATA_WIDTH_MAX-1:0]  cap_rdata [NUM_CAP_INTFS-1:0];
  wire                                cap_rden;

  /*  Instantiate MON2AVST */
  IW_fpga_mon2avst #(
     .DBG_CAP_DATA_WIDTH      (DBG_CAP_DATA_WIDTH_MAX)
    ,.NUM_CAP_INTFS           (NUM_CAP_INTFS)
    ,.AV_ST_SYMBOL_W          (AV_ST_SYMBOL_W)
    ,.AV_ST_DATA_W            (AV_ST_DATA_W)
    ,.AV_ST_EMPTY_W           (AV_ST_EMPTY_W)
    ,.USE_BIG_ENDIAN          (AV_ST_USE_BIG_ENDIAN)
    ,.CHNL_Q_IDX_LIST         (CHNL_Q_IDX_LIST)
    ,.CHNL_DATA_W_LIST        (CHNL_DATA_W_LIST)
  ) u_IW_fpga_mon2avst (

    .clk                        (clk_dbg_av),
    .rst_n                      (rst_dbg_av_n),

    .avl_st_ready               (avl_st_ready),
    .avl_st_valid               (avl_st_valid),
    .avl_st_startofpacket       (avl_st_startofpacket),
    .avl_st_endofpacket         (avl_st_endofpacket),
    .avl_st_empty               (avl_st_empty),
    .avl_st_data                (avl_st_data),

    .chnl_cap_rdata_valid_bin   (0),
    .chnl_cap_rdata_valid       (cap_rdata_valid),
    .chnl_cap_rdata             (cap_rdata),
    .chnl_cap_rden              (cap_rden)

  );


 /* Instantiate ONPI MOnitor */
  IW_fpga_onpi100g_mon #(
     .MON_TYPE                    (MON_TYPE)
    ,.INSTANCE_NAME               (INSTANCE_NAME)
    ,.MODE                        ("avl")
    ,.ONPI_SPEED                  ("100G")

    ,.JEM_RECORD_WIDTH            (JEM_RECORD_WIDTH)
    ,.AV_MM_DATA_W                (AV_MM_DATA_W)
    ,.AV_MM_ADDR_W                (AV_MM_ADDR_W)
    ,.READ_MISS_VAL               (READ_MISS_VAL)

  ) u_onpi_mon (
     .clk_csr                  (clk_dbg_av)
    ,.rst_csr_n                (rst_dbg_av_n)

    ,.avl_mm_address           (avl_mm_address)
    ,.avl_mm_readdata          (avl_mm_readdata)
    ,.avl_mm_read              (avl_mm_read)
    ,.avl_mm_readdatavalid     (avl_mm_readdatavalid)
    ,.avl_mm_write             (avl_mm_write)
    ,.avl_mm_writedata         (avl_mm_writedata)
    ,.avl_mm_byteenable        (avl_mm_byteenable)
    ,.avl_mm_waitrequest       (avl_mm_waitrequest)

    ,.clk_logic                (clk_logic)
    ,.rst_logic_n              (rst_logic_n)
    ,.data0                    (data0)
    ,.data1                    (data1)
    ,.data2                    (data2)
    ,.data3                    (data3)
    ,.ctl0                     (ctl0)
    ,.ctl1                     (ctl1)
    ,.ctl2                     (ctl2)
    ,.ctl3                     (ctl3)
    ,.mdata0                   (mdata0)
    ,.mdata1                   (mdata1)
    ,.mdata2                   (mdata2)
    ,.mdata3                   (mdata3)
    ,.mdata4                   (mdata4)
    ,.mdata5                   (mdata5)
    ,.mdata6                   (mdata6)
    ,.mdata7                   (mdata7)
    ,.msdata                   (msdata)
    ,.linkup                   (linkup)
    ,.lp_linkup                (lp_linkup)
    ,.speed                    (speed)
    ,.xoff                     (xoff)

    ,.cap_rdata_valid          (cap_rdata_valid)
    ,.cap_rdata                (cap_rdata[0][JEM_RECORD_WIDTH-1:0])
    ,.cap_rden                 (cap_rden)
);

  assign cap_rdata[0][DBG_CAP_DATA_WIDTH_MAX-1:JEM_RECORD_WIDTH]='h0;

endmodule //IW_fpga_onpi100g_mon_av
