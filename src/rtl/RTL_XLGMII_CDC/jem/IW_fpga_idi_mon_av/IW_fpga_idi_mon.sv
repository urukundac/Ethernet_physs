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

module IW_fpga_idi_mon #(
    parameter MON_TYPE            = "IDI"
  , parameter INSTANCE_NAME       = "u_idi_mon"                 //Can hold upto 16 ASCII characters
  , parameter MODE                = "avl"                        //Either 'standalone' or 'avl' mode

  /*  Do Not Modify */

  , parameter JEM_RECORD_WIDTH    = $bits(C2URequest_t) + $bits(C2UResponse_t) + $bits(C2UData_t) +
                                    $bits(U2CRequest_t) + $bits(U2CResponse_t) + $bits(U2CData_t)   //Width of the struct captured from JEM tracker
  , parameter AV_MM_DATA_W        = 32
  , parameter AV_MM_ADDR_W        = 16

  , parameter READ_MISS_VAL       = 32'hDEADBABE          // Read miss value

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

  /*  CSR Interface */
    input   logic                        clk_csr
  , input   logic                        rst_csr_n

  , input   logic                        clk_logic
  , input   logic                        rst_logic_n,

    input   wire  [AV_MM_ADDR_W-1:0]     avl_mm_address,          // avl_mm.address
    output  reg   [AV_MM_DATA_W-1:0]     avl_mm_readdata,         //       .readdata
    input   wire                         avl_mm_read,             //       .read
    output  reg                          avl_mm_readdatavalid,    //       .readdatavalid
    input   wire                         avl_mm_write,            //       .write
    input   wire  [AV_MM_DATA_W-1:0]     avl_mm_writedata,        //       .writedata
    input   wire  [(AV_MM_DATA_W/8)-1:0] avl_mm_byteenable,       //       .byteenable
    output  wire                         avl_mm_waitrequest,      //       .waitrequest

  /*  Logic Interface */
    /*** C2U Request fields ***/
    input wire C2U_Req_Valid,
    input wire [1:0] C2U_Req_OpGroup,
    input wire [5:0] C2U_Req_Opcode,
    input wire [(C2U_ADDR_WIDTH - 1):0] C2U_Req_Address,
    input wire C2U_Req_AddrParity,         /* Optional field */
    input wire C2U_Req_SelfSnp,
    input wire [11:0] C2U_Req_CQid,
    input wire [5:0] C2U_Req_Length,
    input wire [2:0] C2U_Req_LPid,
    input wire [4:0] C2U_Req_CLoS,
    input wire [7:0] C2U_Req_SAI,
    input wire [1:0] C2U_Req_NonTemporal,
    input wire C2U_Req_CacheNear,
    input wire C2U_Req_CacheFar,
    input wire [5:0] C2U_Req_Hash,         /* Optional field */
    input wire [3:0] C2U_Req_Topology,     /* Optional field */
    input wire [9:0] C2U_Req_Spare,

    /*** C2U Response fields ***/
    input wire C2U_Rsp_Valid,
    input wire [4:0] C2U_Rsp_Opcode,
    input wire [12:0] C2U_Rsp_UQid,
    input wire C2U_Rsp_MonitorExist,
    input wire C2U_Rsp_HLEAbort,
    input wire [1:0] C2U_Rsp_Spare,

    /*** C2U Data fields ***/
    input wire C2U_Data_Valid,
    input wire [12:0] C2U_Data_UQid,
    input wire [3:0] C2U_Data_ChunkValid,
    input wire [(C2U_DATA_WIDTH - 1):0] C2U_Data_Data,
    input wire [(C2U_BE_WIDTH - 1):0] C2U_Data_ByteEnable,
    input wire C2U_Data_Bogus,
    input wire C2U_Data_Poison,
    input wire [(C2U_DATA_PARITY_WIDTH - 1):0] C2U_Data_DataParity,  /* Optional field */
    input wire C2U_Data_BEParity,          /* Optional field */
    input wire [(C2U_ECC_WIDTH - 1):0] C2U_Data_ECC,         /* Optional field */
    input wire C2U_Data_ECCValid,          /* Optional field */
    input wire [1:0] C2U_Data_Spare,

    /*** U2C Request fields ***/
    input wire U2C_Req_Valid,
    input wire [4:0] U2C_Req_Opcode,
    input wire [(U2C_ADDR_WIDTH - 1):0] U2C_Req_Address,
    input wire U2C_Req_AddrParity,              /* Optional field */
    input wire [15:0] U2C_Req_ReqData,
    input wire [1:0] U2C_Req_Spare,

    /*** U2C Response fields ***/
    input wire U2C_Rsp_Valid,
    input wire [3:0] U2C_Rsp_Opcode,
    input wire [12:0] U2C_Rsp_RspData,
    input wire [1:0] U2C_Rsp_PRE,
    input wire [11:0] U2C_Rsp_CQid,
    input wire [9:0] U2C_Rsp_Spare,

    /*** U2C Data fields ***/
    input wire U2C_Data_Valid,
    input wire [11:0] U2C_Data_CQid,
    input wire [3:0] U2C_Data_ChunkValid,
    input wire [(U2C_DATA_WIDTH - 1):0] U2C_Data_Data,
    input wire U2C_Data_Poison,
    input wire U2C_Data_Err,
    input wire [6:0] U2C_Data_PRE,
    input wire [(U2C_DATA_PARITY_WIDTH - 1):0] U2C_Data_DataParity,       /* Optional field */
    input wire [(U2C_ECC_WIDTH - 1):0] U2C_Data_ECC,              /* Optional field */
    input wire U2C_Data_ECCValid,    /* Optional field */
    input wire U2C_Data_Spare,

    /*** Clock, enable, and id ***/
    input wire clk,
    input wire enable,
    input wire [31:0] id

  /* CAP Interface  */
  , output logic                            cap_rdata_valid
  , output logic  [JEM_RECORD_WIDTH-1:0]    cap_rdata
  , input  logic                            cap_rden

);

  /*  Internal Parameters */
  localparam  CAP_FF_DATA_W           = JEM_RECORD_WIDTH%32?((JEM_RECORD_WIDTH/32)+1)*32:((JEM_RECORD_WIDTH/32))*32;
  localparam  CAP_FF_DEPTH            = 512;
  localparam  CAP_FF_ADDR_W           = $clog2 (CAP_FF_DEPTH);
  localparam  CAP_FF_USED_W           = 10;

  //import idi_jem_pkg::*;

  /*  wire/reg  */
  wire                            mon_enable;
  wire  [JEM_RECORD_WIDTH-1:0]    mask_en;
  wire  [JEM_RECORD_WIDTH-1:0]    mask_value;

  wire  [JEM_RECORD_WIDTH-1:0]    mon_data;
  wire                            mon_data_valid;

  wire  [JEM_RECORD_WIDTH-1:0]    filt_data;
  wire                            filt_data_valid;
  wire                            filt_bp;

  wire                        cap_ff_wrclk;
  wire                        cap_ff_full;
  wire                        cap_ff_wren;
  wire  [CAP_FF_DATA_W-1:0]   cap_ff_wdata;
  wire  [CAP_FF_USED_W-1:0]   cap_ff_wrused;
  wire                        cap_ff_rdclk;
  wire                        cap_ff_rst_n;
  wire                        cap_ff_empty;
  wire                        cap_ff_rden;
  wire  [CAP_FF_DATA_W-1:0]   cap_ff_rdata;
  wire  [CAP_FF_USED_W-1:0]   cap_ff_rdused;


  wire                        csr_cap_rdata_valid;
  wire  [CAP_FF_DATA_W-1:0]   csr_cap_rdata;
  wire  [CAP_FF_USED_W-1:0]   csr_cap_rdused;
  wire                        csr_cap_rden;

  wire                        clr_stats;
  wire                        flush_cap_ff;
  wire                        rec_ordering_en;
  wire  [31:0]                num_pkts;
  wire  [31:0]                num_beats;
  wire  [31:0]                num_dropped_pkts;

  C2URequest_t             C2U_Req;
  C2UResponse_t            C2U_Rsp; 
  C2UData_t                C2U_Data;
  
  U2CRequest_t             U2C_Req;
  U2CResponse_t            U2C_Rsp; 
  U2CData_t                U2C_Data;


IW_fpga_idi_mon_addr_map_avmm_wrapper #(
     .MON_TYPE                (MON_TYPE)
    ,.INSTANCE_NAME           (INSTANCE_NAME)
    ,.MODE                    (MODE)
    ,.CAP_RECORD_W            (JEM_RECORD_WIDTH)
    ,.CAP_FF_DATA_W           (CAP_FF_DATA_W)
    ,.CAP_FF_DEPTH            (CAP_FF_DEPTH)
    ,.CAP_FF_USED_W           (CAP_FF_USED_W)

    ,.AV_MM_DATA_W            (AV_MM_DATA_W)
    ,.AV_MM_ADDR_W            (AV_MM_ADDR_W)    

    ,.READ_MISS_VAL           (READ_MISS_VAL)
) u_csr (

     .avl_mm_address          (avl_mm_address)
    ,.avl_mm_readdata         (avl_mm_readdata)
    ,.avl_mm_read             (avl_mm_read)
    ,.avl_mm_readdatavalid    (avl_mm_readdatavalid)
    ,.avl_mm_write            (avl_mm_write)
    ,.avl_mm_writedata        (avl_mm_writedata)
    ,.avl_mm_byteenable       (avl_mm_byteenable)
    ,.avl_mm_waitrequest      (avl_mm_waitrequest)
    ,.csi_clk                 (clk_csr)
    ,.rsi_reset               (~rst_logic_n)
    ,.clk_logic               (clk_logic)

    ,.cap_rdata_valid         (csr_cap_rdata_valid)
    ,.cap_rdata               (csr_cap_rdata)
    ,.cap_rdused              (csr_cap_rdused)
    ,.cap_rden                (csr_cap_rden)

    ,.num_pkts                (num_pkts                )
    ,.num_beats               (num_beats               )
    ,.num_dropped_pkts        (num_dropped_pkts        )

    ,.mon_enable              (mon_enable              )
    ,.clr_stats               (clr_stats               )
    ,.flush_cap_ff            (flush_cap_ff            )
    ,.rec_ordering_en         (rec_ordering_en         )

);

  /* Statistics Instance  */
  IW_fpga_idi_mon_stats u_stats
  (
     .clk_logic               (clk_logic)
    ,.rst_logic_n             (rst_logic_n)
    ,.clr_stats               (clr_stats)
    ,.mon_data_valid          (mon_data_valid)
    ,.filt_bp                 (filt_bp)

    ,.num_pkts                (num_pkts)
    ,.num_beats               (num_beats)
    ,.num_dropped_pkts        (num_dropped_pkts)
 
  );
    
  /* jem tracker instance */
  idi_v2_tracker u_idi_v2_tracker (
    .C2U_Req_Valid                    (C2U_Req_Valid),
    .C2U_Req_OpGroup                  (C2U_Req_OpGroup),
    .C2U_Req_Opcode                   (C2U_Req_Opcode),
    .C2U_Req_Address                  (C2U_Req_Address),
    .C2U_Req_AddrParity               (C2U_Req_AddrParity),
    .C2U_Req_SelfSnp                  (C2U_Req_SelfSnp),
    .C2U_Req_CQid                     (C2U_Req_CQid),
    .C2U_Req_Length                   (C2U_Req_Length),
    .C2U_Req_LPid                     (C2U_Req_LPid),
    .C2U_Req_CLoS                     (C2U_Req_CLoS),
    .C2U_Req_SAI                      (C2U_Req_SAI),
    .C2U_Req_NonTemporal              (C2U_Req_NonTemporal),
    .C2U_Req_CacheNear                (C2U_Req_CacheNear),
    .C2U_Req_CacheFar                 (C2U_Req_CacheFar),
    .C2U_Req_Hash                     (C2U_Req_Hash),
    .C2U_Req_Topology                 (C2U_Req_Topology),
    .C2U_Req_Spare                    (C2U_Req_Spare),
    .C2U_Rsp_Valid                    (C2U_Rsp_Valid),
    .C2U_Rsp_Opcode                   (C2U_Rsp_Opcode),
    .C2U_Rsp_UQid                     (C2U_Rsp_UQid),
    .C2U_Rsp_MonitorExist             (C2U_Rsp_MonitorExist),
    .C2U_Rsp_HLEAbort                 (C2U_Rsp_HLEAbort),
    .C2U_Rsp_Spare                    (C2U_Rsp_Spare),
    .C2U_Data_Valid                   (C2U_Data_Valid),
    .C2U_Data_UQid                    (C2U_Data_UQid),
    .C2U_Data_ChunkValid              (C2U_Data_ChunkValid),
    .C2U_Data_Data                    (C2U_Data_Data),
    .C2U_Data_ByteEnable              (C2U_Data_ByteEnable),
    .C2U_Data_Bogus                   (C2U_Data_Bogus),
    .C2U_Data_Poison                  (C2U_Data_Poison),
    .C2U_Data_DataParity              (C2U_Data_DataParity),
    .C2U_Data_BEParity                (C2U_Data_BEParity),
    .C2U_Data_ECC                     (C2U_Data_ECC),
    .C2U_Data_ECCValid                (C2U_Data_ECCValid),
    .C2U_Data_Spare                   (C2U_Data_Spare),
    .U2C_Req_Valid                    (U2C_Req_Valid),
    .U2C_Req_Opcode                   (U2C_Req_Opcode),
    .U2C_Req_Address                  (U2C_Req_Address),
    .U2C_Req_AddrParity               (U2C_Req_AddrParity),
    .U2C_Req_ReqData                  (U2C_Req_ReqData),
    .U2C_Req_Spare                    (U2C_Req_Spare),
    .U2C_Rsp_Valid                    (U2C_Rsp_Valid),
    .U2C_Rsp_Opcode                   (U2C_Rsp_Opcode),
    .U2C_Rsp_RspData                  (U2C_Rsp_RspData),
    .U2C_Rsp_PRE                      (U2C_Rsp_PRE),
    .U2C_Rsp_CQid                     (U2C_Rsp_CQid),
    .U2C_Rsp_Spare                    (U2C_Rsp_Spare),
    .U2C_Data_Valid                   (U2C_Data_Valid),
    .U2C_Data_CQid                    (U2C_Data_CQid),
    .U2C_Data_ChunkValid              (U2C_Data_ChunkValid),
    .U2C_Data_Data                    (U2C_Data_Data),
    .U2C_Data_Poison                  (U2C_Data_Poison),
    .U2C_Data_Err                     (U2C_Data_Err),
    .U2C_Data_PRE                     (U2C_Data_PRE),
    .U2C_Data_DataParity              (U2C_Data_DataParity),
    .U2C_Data_ECC                     (U2C_Data_ECC),
    .U2C_Data_ECCValid                (U2C_Data_ECCValid),
    .U2C_Data_Spare                   (U2C_Data_Spare),
    .clk                              (clk),
    .enable                           (enable),
    .id                               (id),
    .C2U_Req                          (C2U_Req),
    .C2U_Rsp                          (C2U_Rsp), 
    .C2U_Data                         (C2U_Data),
    .U2C_Req                          (U2C_Req),
    .U2C_Rsp                          (U2C_Rsp), 
    .U2C_Data                         (U2C_Data),
    .valid                            (mon_data_valid)
  );

  assign mask_en = {JEM_RECORD_WIDTH {1'b0}};
  assign mask_value = {JEM_RECORD_WIDTH {1'b0}};
  assign mon_data = {C2U_Req,C2U_Rsp,C2U_Data,U2C_Req,U2C_Rsp,U2C_Data};

  /* filter instance */
  IW_fpga_generic_filt #(
   .DATA_WIDTH  (JEM_RECORD_WIDTH),
   .USE_FLOP    (0)
  ) u_filter (
    .clk                  (clk_logic),
    .rst_n                (rst_logic_n),

    //jem tracker signals
    .mon_data             (mon_data),
    .mon_data_valid       (mon_data_valid),

    //csr signals
    .enable               (mon_enable),
    .match_mask           (mask_en),
    .match_data           (mask_value),

    //fifo interface
    .filt_data            (filt_data),
    .filt_data_valid      (filt_data_valid),
    .filt_bp              (filt_bp)

  );

  assign  cap_ff_wdata   = {{(CAP_FF_DATA_W-JEM_RECORD_WIDTH){1'b0}},filt_data};
  assign  cap_ff_wren    = filt_data_valid;
  assign  filt_bp        = cap_ff_full;

  /* capture fifo */
  //IW_fpga_idi_mon_ff_256x512 u_cap_ff
  IW_fpga_async_fifo #(
    .ADDR_WD (CAP_FF_ADDR_W),
    .DATA_WD (CAP_FF_DATA_W) ) u_cap_ff 
  (
    .rstn                         (cap_ff_rst_n),
    .data                         (cap_ff_wdata),
    .rdclk                        (cap_ff_rdclk),
    .rdreq                        (cap_ff_rden),
    .wrclk                        (cap_ff_wrclk),
    .wrreq                        (cap_ff_wren),
    .q                            (cap_ff_rdata),
    .rdempty                      (cap_ff_empty),
    .rdusedw                      (cap_ff_rdused),
    .wrfull                       (cap_ff_full),
    .wrusedw                      (cap_ff_wrused)
  );

  generate
    if(MODE ==  "avl")
    begin

      //CAP FF Read ports are accessed by external AVL; CSR equivalent ports & tied off
      assign  cap_ff_wrclk = clk_logic;
      assign  cap_ff_rdclk = clk_csr;
      assign  cap_ff_rst_n = rst_csr_n & ~flush_cap_ff;

      assign  cap_rdata_valid  = ~cap_ff_empty;
      assign  cap_rdata        = cap_ff_rdata[JEM_RECORD_WIDTH-1:0];
      assign  cap_ff_rden      = cap_rden;

      assign  csr_cap_rdata_valid    = 1'b0;
      assign  csr_cap_rdata          = {CAP_FF_DATA_W{1'b0}};
      assign  csr_cap_rdused         = {CAP_FF_USED_W{1'b0}};
    end
    else  //MODE  ==  "standalone"
    begin


      //CAP FF Read ports are accessed by CSR; AVL equivalent ports are tied off
      assign  cap_ff_wrclk = clk_logic;
      assign  cap_ff_rdclk = clk_logic;
      assign  cap_ff_rst_n = rst_csr_n & ~flush_cap_ff;

      assign  csr_cap_rdata_valid    = ~cap_ff_empty;
      assign  csr_cap_rdata          = cap_ff_rdata;
      assign  csr_cap_rdused         = cap_ff_rdused;
      assign  cap_ff_rden            = csr_cap_rden;

      assign  cap_rdata_valid  = 1'b0;
      assign  cap_rdata        = {JEM_RECORD_WIDTH{1'b0}};
    end
  endgenerate


endmodule //IW_fpga_idi_mon



