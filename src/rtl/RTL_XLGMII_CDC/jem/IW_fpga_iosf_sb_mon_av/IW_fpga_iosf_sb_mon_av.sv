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

`include "iosf_sb_jem_tracker.vh"

module  IW_fpga_iosf_sb_mon_av #(
    parameter MON_TYPE              = "sbr"                     //Should be either pmsb or gpsb
  , parameter INSTANCE_NAME         = "u_iosf_sb_mon_avl"       //Can hold upto 16 ASCII characters
  , parameter MON_PAYLOAD_WIDTH     = 8                         //Width of payload used on iosfsb_mon
  , parameter DBG_PAYLOAD_WIDTH     = 32                        //Width of payload used on iosfsb_dbg
  , parameter MON_PORTID            = 'h12                      //ID of this avl
  , parameter LOGGER_PORTID         = 8'h1c                     //ID of dbg_logger to send captured records
  , parameter LOGGER_QUEUE_INDEX    = 8'h00                     //Partition ID within dbg_logger

  , parameter MMSG_Q_IDX            = 0                         //partition id of mmsg record
  , parameter TMSG_Q_IDX            = 1                         //partition id of tmsg record

  , parameter AV_MM_DATA_W          = 32
  , parameter AV_MM_ADDR_W          = 8

  , parameter AV_ST_SYMBOL_W        = 8
  , parameter AV_ST_DATA_W          = 8
  , parameter AV_ST_EMPTY_W         = (AV_ST_DATA_W <= AV_ST_SYMBOL_W) ? 1 : $clog2(AV_ST_DATA_W/AV_ST_SYMBOL_W)
  , parameter AV_ST_USE_BIG_ENDIAN  = 1

  , parameter READ_MISS_VAL         = 32'hDEADBABE              // Read miss value

) (

  /*  Logic/Monitor Interface */
    input  logic                          clk_logic
  , input  logic                          rst_logic_n

  , input  logic                          iosfsb_mon_MNPPUT
  , input  logic                          iosfsb_mon_MPCPUT
  , input  logic                          iosfsb_mon_MNPCUP
  , input  logic                          iosfsb_mon_MPCCUP
  , input  logic                          iosfsb_mon_MEOM
  , input  logic  [MON_PAYLOAD_WIDTH-1:0] iosfsb_mon_MPAYLOAD
  , input  logic                          iosfsb_mon_TNPPUT
  , input  logic                          iosfsb_mon_TPCPUT
  , input  logic                          iosfsb_mon_TNPCUP
  , input  logic                          iosfsb_mon_TPCCUP
  , input  logic                          iosfsb_mon_TEOM
  , input  logic  [MON_PAYLOAD_WIDTH-1:0] iosfsb_mon_TPAYLOAD
  , input  logic  [2:0]                   iosfsb_mon_SIDE_ISM_AGENT
  , input  logic  [2:0]                   iosfsb_mon_SIDE_ISM_FABRIC

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

  /*  Internal  Parameters  */
  localparam  NUM_CAP_INTFS       =2;
  localparam  int CHNL_Q_IDX_LIST  [NUM_CAP_INTFS-1:0]    = '{TMSG_Q_IDX,MMSG_Q_IDX};//queue index list for capture channel
  localparam  RECORD_ID_WIDTH     = 32;
  localparam  JEM_RECORD_WIDTH    = $bits(t_iosf_sb_jem_req);
  localparam  CAP_RECORD_W        = JEM_RECORD_WIDTH  + RECORD_ID_WIDTH;

  localparam  DBG_CAP_DATA_WIDTH_MAX  = 256;  //Should accomodate the maximum value in DBG_CAP_DATA_WIDTH_LIST
  localparam  int CHNL_DATA_W_LIST [NUM_CAP_INTFS-1:0]    = '{CAP_RECORD_W,CAP_RECORD_W};

  /*  Internal  Wires */
  wire  [$clog2(NUM_CAP_INTFS)-1:0]   cap_rdata_valid_bin;
  wire  [NUM_CAP_INTFS-1:0]           cap_rdata_valid;
  wire  [DBG_CAP_DATA_WIDTH_MAX-1:0]  cap_rdata[NUM_CAP_INTFS-1:0];
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

    .clk                       (clk_dbg_av),
    .rst_n                     (rst_dbg_av_n),

    .avl_st_ready              (avl_st_ready),
    .avl_st_valid              (avl_st_valid),
    .avl_st_startofpacket      (avl_st_startofpacket),
    .avl_st_endofpacket        (avl_st_endofpacket),
    .avl_st_empty              (avl_st_empty),
    .avl_st_data               (avl_st_data),

    .chnl_cap_rdata_valid_bin  (cap_rdata_valid_bin),
    .chnl_cap_rdata_valid      (cap_rdata_valid),
    .chnl_cap_rdata            (cap_rdata),
    .chnl_cap_rden             (cap_rden)

  );



  /*  Instantiate IOSF-SB Monitor */
  IW_fpga_iosf_sb_mon #(
     .MON_TYPE                    (MON_TYPE)
    ,.INSTANCE_NAME               (INSTANCE_NAME)
    ,.PAYLOAD_WIDTH               (MON_PAYLOAD_WIDTH)
    ,.MODE                        ("avl")

    ,.RECORD_ID_WIDTH             (RECORD_ID_WIDTH)
    ,.JEM_RECORD_WIDTH            (JEM_RECORD_WIDTH)
    ,.CAP_RECORD_W                (CAP_RECORD_W)

    ,.AV_MM_ADDR_W                 (AV_MM_ADDR_W)
    ,.AV_MM_DATA_W                 (AV_MM_DATA_W)
    ,.READ_MISS_VAL                (READ_MISS_VAL)

  ) u_iosf_sb_mon (

     .clk_csr                     (clk_dbg_av)
    ,.rst_csr_n                   (rst_dbg_av_n)

    ,.clk_logic                   (clk_logic)
    ,.rst_logic_n                 (rst_logic_n)

    ,.avl_mm_address              (avl_mm_address)
    ,.avl_mm_readdata             (avl_mm_readdata)
    ,.avl_mm_read                 (avl_mm_read)
    ,.avl_mm_readdatavalid        (avl_mm_readdatavalid)
    ,.avl_mm_write                (avl_mm_write)
    ,.avl_mm_writedata            (avl_mm_writedata)
    ,.avl_mm_byteenable           (avl_mm_byteenable)
    ,.avl_mm_waitrequest          (avl_mm_waitrequest)

                                                               
    ,.iosfsb_MNPPUT               (iosfsb_mon_MNPPUT)
    ,.iosfsb_MPCPUT               (iosfsb_mon_MPCPUT)
    ,.iosfsb_MNPCUP               (iosfsb_mon_MNPCUP)
    ,.iosfsb_MPCCUP               (iosfsb_mon_MPCCUP)
    ,.iosfsb_MEOM                 (iosfsb_mon_MEOM)
    ,.iosfsb_MPAYLOAD             (iosfsb_mon_MPAYLOAD)
    ,.iosfsb_TNPPUT               (iosfsb_mon_TNPPUT)
    ,.iosfsb_TPCPUT               (iosfsb_mon_TPCPUT)
    ,.iosfsb_TNPCUP               (iosfsb_mon_TNPCUP)
    ,.iosfsb_TPCCUP               (iosfsb_mon_TPCCUP)
    ,.iosfsb_TEOM                 (iosfsb_mon_TEOM)
    ,.iosfsb_TPAYLOAD             (iosfsb_mon_TPAYLOAD)
    ,.iosfsb_SIDE_ISM_AGENT       (iosfsb_mon_SIDE_ISM_AGENT)
    ,.iosfsb_SIDE_ISM_FABRIC      (iosfsb_mon_SIDE_ISM_FABRIC)

    ,.tmsg_chnnl_cap_rdata_valid  (cap_rdata_valid[0]             )
    ,.tmsg_chnnl_cap_rdata        (cap_rdata[0][CAP_RECORD_W-1:0] )

    ,.mmsg_chnnl_cap_rdata_valid  (cap_rdata_valid[1]             )
    ,.mmsg_chnnl_cap_rdata        (cap_rdata[1][CAP_RECORD_W-1:0] )

    ,.cap_rden                    (cap_rden)
    ,.chnnl_egr_valid_bin         (cap_rdata_valid_bin)

  );

  assign cap_rdata[0][DBG_CAP_DATA_WIDTH_MAX-1:CAP_RECORD_W]='h0;
  assign cap_rdata[1][DBG_CAP_DATA_WIDTH_MAX-1:CAP_RECORD_W]='h0;

endmodule //IW_fpga_iosf_sb_mon_av
