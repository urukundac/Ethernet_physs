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

`include "idi_v2_type.vh"

module  IW_fpga_idi_mon_av #(
    parameter MON_TYPE              = "IDI"                     //Should be either pmsb or gpsb
  , parameter INSTANCE_NAME         = "u_idi_mon_avl"           //Can hold upto 16 ASCII characters

  , parameter Q_IDX                 = 0                         //partition id of tmsg record

  , parameter AV_MM_DATA_W          = 32
  , parameter AV_MM_ADDR_W          = 8

  , parameter AV_ST_SYMBOL_W        = 8
  , parameter AV_ST_DATA_W          = 8
  , parameter AV_ST_EMPTY_W         = (AV_ST_DATA_W <= AV_ST_SYMBOL_W) ? 1 : $clog2(AV_ST_DATA_W/AV_ST_SYMBOL_W)
  , parameter AV_ST_USE_BIG_ENDIAN  = 1

  , parameter READ_MISS_VAL         = 32'hDEADBABE              // Read miss value

  //IDI parameters
  , parameter C2U_ADDR_WIDTH         = 52
  , parameter C2U_DATA_WIDTH         = 256
  , parameter U2C_ADDR_WIDTH         = 49
  , parameter U2C_DATA_WIDTH         = 256
  , parameter C2U_BE_WIDTH           = (C2U_DATA_WIDTH / 8)
  , parameter C2U_DATA_PARITY_WIDTH  =(C2U_DATA_WIDTH / 64)
  , parameter C2U_ECC_WIDTH          =((512 / C2U_DATA_WIDTH) * 5)
  , parameter U2C_DATA_PARITY_WIDTH  =(U2C_DATA_WIDTH / 64)
  , parameter U2C_ECC_WIDTH          =((512 / U2C_DATA_WIDTH) * 5)
) (
  /*  Logic Interface */
    input wire                                       idi_mon_c2u_req_valid,
    input wire [1:0]                                 idi_mon_c2u_req_opgroup,
    input wire [5:0]                                 idi_mon_c2u_req_opcode,
    input wire [(C2U_ADDR_WIDTH - 1):0]              idi_mon_c2u_req_address,
    input wire                                       idi_mon_c2u_req_addrparity,
    input wire                                       idi_mon_c2u_req_selfsnp,
    input wire [11:0]                                idi_mon_c2u_req_cqid,
    input wire [5:0]                                 idi_mon_c2u_req_length,
    input wire [2:0]                                 idi_mon_c2u_req_lpid,
    input wire [4:0]                                 idi_mon_c2u_req_clos,
    input wire [7:0]                                 idi_mon_c2u_req_sai,
    input wire [1:0]                                 idi_mon_c2u_req_nontemporal,
    input wire                                       idi_mon_c2u_req_cachenear,
    input wire                                       idi_mon_c2u_req_cachefar,
    input wire [5:0]                                 idi_mon_c2u_req_hash,
    input wire [3:0]                                 idi_mon_c2u_req_topology,
    input wire [9:0]                                 idi_mon_c2u_req_spare,
    /*** C2U Response fields ***/
    input wire                                       idi_mon_c2u_rsp_valid,
    input wire [4:0]                                 idi_mon_c2u_rsp_opcode,
    input wire [12:0]                                idi_mon_c2u_rsp_uqid,
    input wire                                       idi_mon_c2u_rsp_monitorexist,
    input wire                                       idi_mon_c2u_rsp_hleabort,
    input wire [1:0]                                 idi_mon_c2u_rsp_spare,
    /*** C2U Data fields ***/
    input wire                                       idi_mon_c2u_data_valid,
    input wire [12:0]                                idi_mon_c2u_data_uqid,
    input wire [3:0]                                 idi_mon_c2u_data_chunkvalid,
    input wire [(C2U_DATA_WIDTH - 1):0]              idi_mon_c2u_data_data,
    input wire [(C2U_BE_WIDTH - 1):0]                idi_mon_c2u_data_byteenable,
    input wire                                       idi_mon_c2u_data_bogus,
    input wire                                       idi_mon_c2u_data_poison,
    input wire [(C2U_DATA_PARITY_WIDTH-1):0]         idi_mon_c2u_data_dataparity,
    input wire                                       idi_mon_c2u_data_beparity,
    input wire [(C2U_ECC_WIDTH-1):0]                                 idi_mon_c2u_data_ecc,
    input wire                                       idi_mon_c2u_data_eccvalid,
    input wire [1:0]                                 idi_mon_c2u_data_spare,
    /*** U2C Request fields ***/
    input wire                                       idi_mon_u2c_req_valid,
    input wire [4:0]                                 idi_mon_u2c_req_opcode,
    input wire [(U2C_ADDR_WIDTH - 1):0]              idi_mon_u2c_req_address,
    input wire                                       idi_mon_u2c_req_addrparity,
    input wire [15:0]                                idi_mon_u2c_req_reqdata,
    input wire [1:0]                                 idi_mon_u2c_req_spare,
    /*** U2C Response fields ***/
    input wire                                       idi_mon_u2c_rsp_valid,
    input wire [3:0]                                 idi_mon_u2c_rsp_opcode,
    input wire [12:0]                                idi_mon_u2c_rsp_rspdata,
    input wire [1:0]                                 idi_mon_u2c_rsp_pre,
    input wire [11:0]                                idi_mon_u2c_rsp_cqid,
    input wire [9:0]                                 idi_mon_u2c_rsp_spare,
    /*** U2C Data fields ***/
    input wire                                       idi_mon_u2c_data_valid,
    input wire [11:0]                                idi_mon_u2c_data_cqid,
    input wire [3:0]                                 idi_mon_u2c_data_chunkvalid,
    input wire [(U2C_DATA_WIDTH - 1):0]              idi_mon_u2c_data_data,
    input wire                                       idi_mon_u2c_data_poison,
    input wire                                       idi_mon_u2c_data_err,
    input wire [6:0]                                 idi_mon_u2c_data_pre,
    input wire [(U2C_DATA_PARITY_WIDTH - 1):0]       idi_mon_u2c_data_dataparity,
    input wire [(U2C_ECC_WIDTH-1):0]                 idi_mon_u2c_data_ecc,
    input wire                                       idi_mon_u2c_data_eccvalid,
    input wire                                       idi_mon_u2c_data_spare,
    /*** Clock, enable, and id ***/
    input wire enable,
    input wire [31:0] id

  /*  IOSF-SB Debug Interface */
  , input  logic                          clk_dbg_av
  , input  logic                          rst_dbg_av_n

  , input  logic                          clk_logic 
  , input  logic                          rst_logic_n 


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
  localparam  NUM_CAP_INTFS       =1;
  localparam  int CHNL_Q_IDX_LIST  [NUM_CAP_INTFS-1:0]    = '{Q_IDX};//queue index list for capture channel
  localparam  JEM_RECORD_WIDTH    = $bits(C2URequest_t) + $bits(C2UResponse_t) + $bits(C2UData_t) +
                                    $bits(U2CRequest_t) + $bits(U2CResponse_t) + $bits(U2CData_t);   //Width of the struct captured from JEM tracker

  localparam  DBG_CAP_DATA_WIDTH_MAX  = JEM_RECORD_WIDTH;  //Should accomodate the maximum value in DBG_CAP_DATA_WIDTH_LIST
  localparam  int CHNL_DATA_W_LIST [NUM_CAP_INTFS-1:0]    = '{JEM_RECORD_WIDTH};

  /*  Internal  Wires */
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

    .chnl_cap_rdata_valid_bin  (1'b0),
    .chnl_cap_rdata_valid      (cap_rdata_valid),
    .chnl_cap_rdata            (cap_rdata),
    .chnl_cap_rden             (cap_rden)

  );



  /*  Instantiate IOSF-SB Monitor */
  IW_fpga_idi_mon #(
     .MON_TYPE                    (MON_TYPE)
    ,.INSTANCE_NAME               (INSTANCE_NAME)
    ,.MODE                        ("avl")

    ,.JEM_RECORD_WIDTH            (JEM_RECORD_WIDTH)

    ,.AV_MM_ADDR_W                 (AV_MM_ADDR_W)
    ,.AV_MM_DATA_W                 (AV_MM_DATA_W)
    ,.READ_MISS_VAL                (READ_MISS_VAL)

    ,.C2U_ADDR_WIDTH               (C2U_ADDR_WIDTH)
    ,.C2U_DATA_WIDTH               (C2U_DATA_WIDTH)
    ,.U2C_ADDR_WIDTH               (U2C_ADDR_WIDTH)
    ,.U2C_DATA_WIDTH               (U2C_DATA_WIDTH)
    ,.C2U_BE_WIDTH                 (C2U_BE_WIDTH)
    ,.C2U_DATA_PARITY_WIDTH        (C2U_DATA_PARITY_WIDTH)
    ,.C2U_ECC_WIDTH                (C2U_ECC_WIDTH)
    ,.U2C_DATA_PARITY_WIDTH        (U2C_DATA_PARITY_WIDTH)
    ,.U2C_ECC_WIDTH                (U2C_ECC_WIDTH)

  ) u_idi_mon (

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
    ,.avl_mm_waitrequest          (avl_mm_waitrequest),

    .C2U_Req_Valid                    (idi_mon_c2u_req_valid),
    .C2U_Req_OpGroup                  (idi_mon_c2u_req_opgroup),
    .C2U_Req_Opcode                   (idi_mon_c2u_req_opcode),
    .C2U_Req_Address                  (idi_mon_c2u_req_address),
    .C2U_Req_AddrParity               (idi_mon_c2u_req_addrparity),
    .C2U_Req_SelfSnp                  (idi_mon_c2u_req_selfsnp),
    .C2U_Req_CQid                     (idi_mon_c2u_req_cqid),
    .C2U_Req_Length                   (idi_mon_c2u_req_length),
    .C2U_Req_LPid                     (idi_mon_c2u_req_lpid),
    .C2U_Req_CLoS                     (idi_mon_c2u_req_clos),
    .C2U_Req_SAI                      (idi_mon_c2u_req_sai),
    .C2U_Req_NonTemporal              (idi_mon_c2u_req_nontemporal),
    .C2U_Req_CacheNear                (idi_mon_c2u_req_cachenear),
    .C2U_Req_CacheFar                 (idi_mon_c2u_req_cachefar),
    .C2U_Req_Hash                     (idi_mon_c2u_req_hash),
    .C2U_Req_Topology                 (idi_mon_c2u_req_topology),
    .C2U_Req_Spare                    (idi_mon_c2u_req_spare),
    .C2U_Rsp_Valid                    (idi_mon_c2u_rsp_valid),
    .C2U_Rsp_Opcode                   (idi_mon_c2u_rsp_opcode),
    .C2U_Rsp_UQid                     (idi_mon_c2u_rsp_uqid),
    .C2U_Rsp_MonitorExist             (idi_mon_c2u_rsp_monitorexist),
    .C2U_Rsp_HLEAbort                 (idi_mon_c2u_rsp_hleabort),
    .C2U_Rsp_Spare                    (idi_mon_c2u_rsp_spare),
    .C2U_Data_Valid                   (idi_mon_c2u_data_valid),
    .C2U_Data_UQid                    (idi_mon_c2u_data_uqid),
    .C2U_Data_ChunkValid              (idi_mon_c2u_data_chunkvalid),
    .C2U_Data_Data                    (idi_mon_c2u_data_data),
    .C2U_Data_ByteEnable              (idi_mon_c2u_data_byteenable),
    .C2U_Data_Bogus                   (idi_mon_c2u_data_bogus),
    .C2U_Data_Poison                  (idi_mon_c2u_data_poison),
    .C2U_Data_DataParity              (idi_mon_c2u_data_dataparity),
    .C2U_Data_BEParity                (idi_mon_c2u_data_beparity),
    .C2U_Data_ECC                     (idi_mon_c2u_data_ecc),
    .C2U_Data_ECCValid                (idi_mon_c2u_data_eccvalid),
    .C2U_Data_Spare                   (idi_mon_c2u_data_spare),
    .U2C_Req_Valid                    (idi_mon_u2c_req_valid),
    .U2C_Req_Opcode                   (idi_mon_u2c_req_opcode),
    .U2C_Req_Address                  (idi_mon_u2c_req_address),
    .U2C_Req_AddrParity               (idi_mon_u2c_req_addrparity),
    .U2C_Req_ReqData                  (idi_mon_u2c_req_reqdata),
    .U2C_Req_Spare                    (idi_mon_u2c_req_spare),
    .U2C_Rsp_Valid                    (idi_mon_u2c_rsp_valid),
    .U2C_Rsp_Opcode                   (idi_mon_u2c_rsp_opcode),
    .U2C_Rsp_RspData                  (idi_mon_u2c_rsp_rspdata),
    .U2C_Rsp_PRE                      (idi_mon_u2c_rsp_pre),
    .U2C_Rsp_CQid                     (idi_mon_u2c_rsp_cqid),
    .U2C_Rsp_Spare                    (idi_mon_u2c_rsp_spare),
    .U2C_Data_Valid                   (idi_mon_u2c_data_valid),
    .U2C_Data_CQid                    (idi_mon_u2c_data_cqid),
    .U2C_Data_ChunkValid              (idi_mon_u2c_data_chunkvalid),
    .U2C_Data_Data                    (idi_mon_u2c_data_data),
    .U2C_Data_Poison                  (idi_mon_u2c_data_poison),
    .U2C_Data_Err                     (idi_mon_u2c_data_err),
    .U2C_Data_PRE                     (idi_mon_u2c_data_pre),
    .U2C_Data_DataParity              (idi_mon_u2c_data_dataparity),
    .U2C_Data_ECC                     (idi_mon_u2c_data_ecc),
    .U2C_Data_ECCValid                (idi_mon_u2c_data_eccvalid),
    .U2C_Data_Spare                   (idi_mon_u2c_data_spare),
    .clk                              (clk_logic),
    .enable                           (enable),
    .id                               (id)

    ,.cap_rdata_valid                 (cap_rdata_valid[0])
    ,.cap_rdata                       (cap_rdata[0][JEM_RECORD_WIDTH-1:0])

    ,.cap_rden                        (cap_rden)

  );


endmodule //IW_fpga_idi_mon_av
