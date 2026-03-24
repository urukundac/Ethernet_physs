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

`include "iosf_p_jem_tracker.vh"

module  IW_fpga_iosf_p_mon_av #(
    parameter MON_TYPE              = "prim"                    //Should be either pmsb or gpsb
  , parameter INSTANCE_NAME         = "u_iosf_p_mon_av"       //Can hold upto 16 ASCII characters
  , parameter GNT_DELAY             = 0                         //grant command delay

  , parameter MREQ_Q_IDX            = 0                         //Partition id for mreq record
  , parameter TREQ_Q_IDX            = 1                         //Partition id for treq record
  , parameter MDATA_Q_IDX           = 2                         //Partition id for mdata record
  , parameter TDATA_Q_IDX           = 3                         //Partition id for tdata record

  , parameter AV_MM_DATA_W          = 32
  , parameter AV_MM_ADDR_W          = 8

  , parameter AV_ST_SYMBOL_W        = 8
  , parameter AV_ST_DATA_W          = 8
  , parameter AV_ST_EMPTY_W         = (AV_ST_DATA_W <= AV_ST_SYMBOL_W) ? 1 : $clog2(AV_ST_DATA_W/AV_ST_SYMBOL_W)
  , parameter AV_ST_USE_BIG_ENDIAN  = 1

  , parameter READ_MISS_VAL         = 32'hDEADBABE              // Read miss value

  , parameter    MAX_DATA_LEN          =  9   // Maximum Data Length on primary interface, >= 4
  , parameter    MMAX_ADDR             = 31   // Maximum Address width on primary master interface                     
  , parameter    AGENT_WIDTH           =  0   // Agent width
  , parameter    MNUMCHAN              =  0   // Master interface num of channels
  , parameter    MNUMCHANL2            =  0   // Num of channels log2               
  , parameter    MD_WIDTH              = 31   // Data Width on primary master interface
  , /*  reuse-pragma  attr  Value @MD_WIDTH>=511?1:2  */  parameter    MDP_WIDTH             = (MD_WIDTH  >=  511)  ? 2 : 1 // Master data parity
  , /*  reuse-pragma  attr  Value (@MD_WIDTH+1)/8     */  parameter    MDBE_WIDTH            = (MD_WIDTH+1)/8               // Master data byte-enable
  , parameter    RS_WIDTH              =  0   // 1 bit root space
  , parameter    SAI_WIDTH             =  0   // SAI width
  , parameter    DEADLINE_WIDTH        =  0   // Deadline time width  
  , parameter    SRC_ID_WIDTH          = 13   // Primary Src ID Width
  , parameter    DST_ID_WIDTH          = 13   // Primary Dst ID Width
  , parameter    GNT_CMD_DELAY         =  1   // Delay between grant and command phase 
 
  , parameter    TMAX_ADDR             = 31   // Maximum Address width on primary target interface
  , parameter    TNUMCHAN              =  0   // Target interface num of channels
  , parameter    TNUMCHANL2            =  0   // Num of channels log2
  , parameter    TNUMCHANL2CREDIT      =  0   // Channel credit width 
  , parameter    TD_WIDTH              = 31   // Data Width on primary target interface
  , /*  reuse-pragma  attr  Value @MD_WIDTH>=511?1:2  */  parameter    TDP_WIDTH             = (TD_WIDTH  >=  511)  ? 2 : 1 // Target data parity
  , /*  reuse-pragma  attr  Value (@TD_WIDTH+1)/8     */  parameter    TDBE_WIDTH            = (TD_WIDTH+1)/8               // Target data byte-enable


) (

  /*  Logic/Monitor Interface */
    input  logic                          clk_logic
  , input  logic                          rst_logic_n

  //----------------------------------------------------------------------------------
  , input     [2:0]                    iosfp_mon_PRIM_ISM_AGENT  // Agent ISM 
  , input     [2:0]                    iosfp_mon_PRIM_ISM_FABRIC // Fabric ISM
 
  , input                              iosfp_mon_REQ_PUT         // Request Put
  , input     [MNUMCHANL2:0]           iosfp_mon_REQ_CHID        // Request Channel
  , input     [RS_WIDTH:0]             iosfp_mon_REQ_RS          // Request Root space
  , input     [1:0]                    iosfp_mon_REQ_RTYPE       // Request Type
  , input                              iosfp_mon_REQ_CDATA       // Request Contains Data
  , input     [MAX_DATA_LEN:0]         iosfp_mon_REQ_DLEN        // Request Data Length
  , input     [3:0]                    iosfp_mon_REQ_TC          // Request Traffic Class
  , input                              iosfp_mon_REQ_NS          // Request Non-Snoop
  , input                              iosfp_mon_REQ_RO          // Request Relaxed Order
  , input                              iosfp_mon_REQ_IDO         // Request Id based ordering
  , input     [15:0]                   iosfp_mon_REQ_ID          // Request Id
  , input                              iosfp_mon_REQ_LOCKED      // Request Locked
  , input                              iosfp_mon_REQ_CHAIN       // Request chain
  , input                              iosfp_mon_REQ_OPP         // Request oppurtunistic
  , input     [AGENT_WIDTH:0]          iosfp_mon_REQ_AGENT       // Request agent specific
  , input     [MNUMCHAN:0]             iosfp_mon_REQ_PRIORITY    // Priority      request
  , input     [DST_ID_WIDTH:0]         iosfp_mon_REQ_DEST_ID     // Destination ID
  , input                              iosfp_mon_GNT             // Grant
  , input     [MNUMCHANL2:0]           iosfp_mon_GNT_CHID        // Grant Channel
  , input     [1:0]                    iosfp_mon_GNT_RTYPE       // Grant Request Type
  , input     [1:0]                    iosfp_mon_GNT_TYPE        // Grant Type
  , input     [1:0]                    iosfp_mon_OBFF            // Optimised Buffer Flush/Full

  , input     [1:0]                    iosfp_mon_MFMT            // Format
  , input     [4:0]                    iosfp_mon_MTYPE           // Type
  , input     [3:0]                    iosfp_mon_MTC             // Traffic Class
  , input                              iosfp_mon_MTH             // Transaction hint
  , input                              iosfp_mon_MEP             // Error Present
  , input                              iosfp_mon_MRO             // Relaxed Ordering
  , input                              iosfp_mon_MNS             // Non-Snoop
  , input                              iosfp_mon_MIDO            // ID Based Ordering
  , input     [1:0]                    iosfp_mon_MAT             // Address translation Services
  , input     [9:0]                    iosfp_mon_MLENGTH         // Length
  , input     [15:0]                   iosfp_mon_MRQID           // Requester ID
  , input     [7:0]                    iosfp_mon_MTAG            // mag
  , input     [3:0]                    iosfp_mon_MLBE            // Last DW Byte Enable
  , input     [3:0]                    iosfp_mon_MFBE            // First DW Byte Enable
  , input                              iosfp_mon_MBEWD           // Master Byte Enables With Data
  , input     [MMAX_ADDR:0]            iosfp_mon_MADDRESS        // Address
  , input     [RS_WIDTH:0]             iosfp_mon_MRS             // Root space
  , input                              iosfp_mon_MTD             // mLP Digest
  , input     [31:0]                   iosfp_mon_MECRC           // End to end CRC
  , input                              iosfp_mon_MECRC_GENERATE  // Ecrc generate  
  , input                              iosfp_mon_MECRC_ERROR     // Ecrc error
  , input                              iosfp_mon_MRSVD0_7        // PCI Express Reserved
  , input                              iosfp_mon_MRSVD1_1        // PCI Express Reserved
  , input                              iosfp_mon_MRSVD1_3        // PCI Express Reserved
  , input                              iosfp_mon_MRSVD1_7        // PCI Express Reserved
  , input                              iosfp_mon_MCPARITY        // Command Parity
  , input     [SRC_ID_WIDTH:0]         iosfp_mon_MSRC_ID         // Src ID
  , input     [DST_ID_WIDTH:0]         iosfp_mon_MDEST_ID        // Dest ID
  , input     [SAI_WIDTH:0]            iosfp_mon_MSAI            // SAI
  , input     [DEADLINE_WIDTH:0]       iosfp_mon_MDEADLINE       // Deadline
  , input     [22:0]                   iosfp_mon_MPASIDTLP       // PASID TLP prefix
 
  , input     [MD_WIDTH:0]             iosfp_mon_MDATA            // Data
  , input     [MDP_WIDTH:0]            iosfp_mon_MDPARITY         // Data Parity
  , input     [MDBE_WIDTH-1:0]         iosfp_mon_MDBE             // Master Data byte enables

  , input                              iosfp_mon_CMD_PUT          // Command Put
  , input     [TNUMCHANL2:0]           iosfp_mon_CMD_CHID         // Command Channel ID
  , input     [1:0]                    iosfp_mon_CMD_RTYPE        // Put Request Type*
  , input                              iosfp_mon_CMD_NFS_ERR      // Put Nonfunction specific error
  , input     [1:0]                    iosfp_mon_TFMT             // Format
  , input     [4:0]                    iosfp_mon_TTYPE            // Type
  , input     [3:0]                    iosfp_mon_TTC              // Traffic Class
  , input                              iosfp_mon_TEP              // Error Present
  , input                              iosfp_mon_TRO              // Relaxed Ordering
  , input                              iosfp_mon_TNS              // Non-Snoop
  , input                              iosfp_mon_TIDO             // ID Based Ordering
  , input                              iosfp_mon_TTH              // Transaction Hints
  , input                              iosfp_mon_TCHAIN           // Chain
  , input     [1:0]                    iosfp_mon_TAT              // Address Transaltion Services
  , input     [9:0]                    iosfp_mon_TLENGTH          // Length
  , input     [15:0]                   iosfp_mon_TRQID            // Requester ID
  , input     [7:0]                    iosfp_mon_TTAG             // Tag
  , input     [3:0]                    iosfp_mon_TLBE             // Last DW Byte Enable
  , input     [3:0]                    iosfp_mon_TFBE             // First DW Byte Enable
  , input                              iosfp_mon_TBEWD            // Target byte enable with data
  , input     [TMAX_ADDR:0]            iosfp_mon_TADDRESS         // Address
  , input     [RS_WIDTH:0]             iosfp_mon_TRS              // Root space
  , input                              iosfp_mon_TTD              // TLP Digest
  , input     [31:0]                   iosfp_mon_TECRC            // End to end CRC
  , input                              iosfp_mon_TECRC_GENERATE   // Ecrc generate
  , input                              iosfp_mon_TECRC_ERROR      // Ecrc error
  , input                              iosfp_mon_TRSVD0_7         // PCI Express Reserved
  , input                              iosfp_mon_TRSVD1_1         // PCI Express Reserved
  , input                              iosfp_mon_TRSVD1_3         // PCI Express Reserved
  , input                              iosfp_mon_TRSVD1_7         // PCI Express Reserved
  , input                              iosfp_mon_TCPARITY         // Command Parity
  , input     [SRC_ID_WIDTH:0]         iosfp_mon_TSRC_ID          // Src ID
  , input     [DST_ID_WIDTH:0]         iosfp_mon_TDEST_ID         // Dest ID
  , input     [SAI_WIDTH:0]            iosfp_mon_TSAI             // Security Attributes of Initiator
  , input     [DEADLINE_WIDTH:0]       iosfp_mon_TDEADLINE        // Deadline
  , input     [22:0]                   iosfp_mon_TPASIDTLP        // PASID TLP prefix
  , input     [TNUMCHAN:0]             iosfp_mon_TPRIORITY        // Priority

  , input     [TD_WIDTH:0]             iosfp_mon_TDATA            // Data
  , input     [TDBE_WIDTH-1:0]         iosfp_mon_TDBE             // Target Data byte enable
  , input     [TDP_WIDTH:0]            iosfp_mon_TDPARITY

  , input     [2:0]                    iosfp_mon_CREDIT_DATA
  , input     [TNUMCHANL2CREDIT:0]     iosfp_mon_CREDIT_CHID


  //Avalon clock/reset
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
  localparam  NUM_CAP_INTFS                           = 4;
  localparam  int CHNL_Q_IDX_LIST  [NUM_CAP_INTFS-1:0]    = '{TDATA_Q_IDX,MDATA_Q_IDX,TREQ_Q_IDX,MREQ_Q_IDX};//queue index list for capture channel

  localparam  RECORD_ID_WIDTH                   = 32;
  localparam  MREQ_JEM_CAP_RECORD_W             = $bits(t_iosf_p_jem_mreq);
  localparam  TREQ_JEM_CAP_RECORD_W             = $bits(t_iosf_p_jem_treq);
  localparam  MDATA_JEM_CAP_RECORD_W            = $bits(t_iosf_p_jem_mdata);
  localparam  TDATA_JEM_CAP_RECORD_W            = $bits(t_iosf_p_jem_tdata);
  localparam  MREQ_CAP_RECORD_W                 = MREQ_JEM_CAP_RECORD_W  + RECORD_ID_WIDTH;
  localparam  TREQ_CAP_RECORD_W                 = TREQ_JEM_CAP_RECORD_W  + RECORD_ID_WIDTH;
  localparam  MDATA_CAP_RECORD_W                = MDATA_JEM_CAP_RECORD_W + RECORD_ID_WIDTH;
  localparam  TDATA_CAP_RECORD_W                = TDATA_JEM_CAP_RECORD_W + RECORD_ID_WIDTH;
  localparam  REQ_CAP_FF_DATA_W                 = 224;
  localparam  DATA_CAP_FF_DATA_W                = 576;
  localparam  int CHNL_DATA_W_LIST [NUM_CAP_INTFS-1:0]    = '{TDATA_CAP_RECORD_W,MDATA_CAP_RECORD_W,TREQ_CAP_RECORD_W,MREQ_CAP_RECORD_W};
 
  localparam  DBG_CAP_DATA_WIDTH_MAX            = 1200; //should accomodate max value in array DBG_CAP_DATA_WIDTH_LIST


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

    .clk                        (clk_dbg_av),
    .rst_n                      (rst_dbg_av_n),

    .avl_st_ready               (avl_st_ready),
    .avl_st_valid               (avl_st_valid),
    .avl_st_startofpacket       (avl_st_startofpacket),
    .avl_st_endofpacket         (avl_st_endofpacket),
    .avl_st_empty               (avl_st_empty),
    .avl_st_data                (avl_st_data),

    .chnl_cap_rdata_valid_bin   (cap_rdata_valid_bin),
    .chnl_cap_rdata_valid       (cap_rdata_valid),
    .chnl_cap_rdata             (cap_rdata),
    .chnl_cap_rden              (cap_rden)

  );

  /*  Instantiate IOSF-SB Monitor */
  IW_fpga_iosf_p_mon #(
     .MON_TYPE                    (MON_TYPE)
    ,.INSTANCE_NAME               (INSTANCE_NAME)
    ,.MODE                        ("avl")
    ,.GNT_DELAY                   (GNT_DELAY)
    ,.MAX_DATA_LEN                (MAX_DATA_LEN)
    ,.MMAX_ADDR                   (MMAX_ADDR)
    ,.AGENT_WIDTH                 (AGENT_WIDTH)
    ,.MNUMCHAN                    (MNUMCHAN)
    ,.MNUMCHANL2                  (MNUMCHANL2)
    ,.MD_WIDTH                    (MD_WIDTH)
    ,.RS_WIDTH                    (RS_WIDTH)
    ,.SAI_WIDTH                   (SAI_WIDTH)
    ,.DEADLINE_WIDTH              (DEADLINE_WIDTH)
    ,.SRC_ID_WIDTH                (SRC_ID_WIDTH)
    ,.DST_ID_WIDTH                (DST_ID_WIDTH)
    ,.GNT_CMD_DELAY               (GNT_CMD_DELAY)
    ,.TMAX_ADDR                   (TMAX_ADDR)
    ,.TNUMCHAN                    (TNUMCHAN)
    ,.TNUMCHANL2                  (TNUMCHANL2)
    ,.TNUMCHANL2CREDIT            (TNUMCHANL2CREDIT)
    ,.TD_WIDTH                    (TD_WIDTH)
    ,.MDP_WIDTH                   (MDP_WIDTH)
    ,.TDP_WIDTH                   (TDP_WIDTH)

    ,.NUM_CAP_INTFS               (NUM_CAP_INTFS)
    ,.RECORD_ID_WIDTH             (RECORD_ID_WIDTH)
    ,.TREQ_CAP_RECORD_W           (TREQ_CAP_RECORD_W)
    ,.MREQ_CAP_RECORD_W           (MREQ_CAP_RECORD_W)
    ,.TDATA_CAP_RECORD_W          (TDATA_CAP_RECORD_W)
    ,.MDATA_CAP_RECORD_W          (MDATA_CAP_RECORD_W)
    ,.TREQ_JEM_CAP_RECORD_W       (TREQ_JEM_CAP_RECORD_W)
    ,.MREQ_JEM_CAP_RECORD_W       (MREQ_JEM_CAP_RECORD_W)
    ,.TDATA_JEM_CAP_RECORD_W      (TDATA_JEM_CAP_RECORD_W)
    ,.MDATA_JEM_CAP_RECORD_W      (MDATA_JEM_CAP_RECORD_W)
    ,.REQ_CAP_FF_DATA_W           (REQ_CAP_FF_DATA_W)
    ,.DATA_CAP_FF_DATA_W          (DATA_CAP_FF_DATA_W)

    ,.AV_MM_DATA_W                (AV_MM_DATA_W)
    ,.AV_MM_ADDR_W                (AV_MM_ADDR_W)
    ,.READ_MISS_VAL               (READ_MISS_VAL)
  ) u_iosf_p_mon (

     .clk_csr                     (clk_dbg_av                  )
    ,.rst_csr_n                   (rst_dbg_av_n                )

    ,.avl_mm_address              (avl_mm_address)
    ,.avl_mm_readdata             (avl_mm_readdata)
    ,.avl_mm_read                 (avl_mm_read)
    ,.avl_mm_readdatavalid        (avl_mm_readdatavalid)
    ,.avl_mm_write                (avl_mm_write)
    ,.avl_mm_writedata            (avl_mm_writedata)
    ,.avl_mm_byteenable           (avl_mm_byteenable)
    ,.avl_mm_waitrequest          (avl_mm_waitrequest)

    ,.clk_logic                   (clk_logic                   )
    ,.rst_logic_n                 (rst_logic_n                 )

    ,.iosf_mon_PRIM_ISM_AGENT     (iosfp_mon_PRIM_ISM_AGENT     )    
    ,.iosf_mon_PRIM_ISM_FABRIC    (iosfp_mon_PRIM_ISM_FABRIC    )
    ,.iosf_mon_REQ_PUT            (iosfp_mon_REQ_PUT            )
    ,.iosf_mon_REQ_CHID           (iosfp_mon_REQ_CHID           )
    ,.iosf_mon_REQ_RS             (iosfp_mon_REQ_RS             )
    ,.iosf_mon_REQ_RTYPE          (iosfp_mon_REQ_RTYPE          )
    ,.iosf_mon_REQ_CDATA          (iosfp_mon_REQ_CDATA          )
    ,.iosf_mon_REQ_DLEN           (iosfp_mon_REQ_DLEN           )
    ,.iosf_mon_REQ_TC             (iosfp_mon_REQ_TC             )
    ,.iosf_mon_REQ_NS             (iosfp_mon_REQ_NS             )
    ,.iosf_mon_REQ_RO             (iosfp_mon_REQ_RO             )
    ,.iosf_mon_REQ_IDO            (iosfp_mon_REQ_IDO            )
    ,.iosf_mon_REQ_ID             (iosfp_mon_REQ_ID             )
    ,.iosf_mon_REQ_LOCKED         (iosfp_mon_REQ_LOCKED         )
    ,.iosf_mon_REQ_CHAIN          (iosfp_mon_REQ_CHAIN          )
    ,.iosf_mon_REQ_OPP            (iosfp_mon_REQ_OPP            )
    ,.iosf_mon_REQ_AGENT          (iosfp_mon_REQ_AGENT          )
    ,.iosf_mon_REQ_PRIORITY       (iosfp_mon_REQ_PRIORITY       )
    ,.iosf_mon_REQ_DEST_ID        (iosfp_mon_REQ_DEST_ID        )
    ,.iosf_mon_GNT                (iosfp_mon_GNT                )
    ,.iosf_mon_GNT_CHID           (iosfp_mon_GNT_CHID           )
    ,.iosf_mon_GNT_RTYPE          (iosfp_mon_GNT_RTYPE          )
    ,.iosf_mon_GNT_TYPE           (iosfp_mon_GNT_TYPE           )
    ,.iosf_mon_OBFF               (iosfp_mon_OBFF               )
    ,.iosf_mon_MFMT               (iosfp_mon_MFMT               )
    ,.iosf_mon_MTYPE              (iosfp_mon_MTYPE              )
    ,.iosf_mon_MTC                (iosfp_mon_MTC                )
    ,.iosf_mon_MTH                (iosfp_mon_MTH                )
    ,.iosf_mon_MEP                (iosfp_mon_MEP                )
    ,.iosf_mon_MRO                (iosfp_mon_MRO                )
    ,.iosf_mon_MNS                (iosfp_mon_MNS                )
    ,.iosf_mon_MIDO               (iosfp_mon_MIDO               )
    ,.iosf_mon_MAT                (iosfp_mon_MAT                )
    ,.iosf_mon_MLENGTH            (iosfp_mon_MLENGTH            )
    ,.iosf_mon_MRQID              (iosfp_mon_MRQID              )
    ,.iosf_mon_MTAG               (iosfp_mon_MTAG               )
    ,.iosf_mon_MLBE               (iosfp_mon_MLBE               )
    ,.iosf_mon_MFBE               (iosfp_mon_MFBE               )
    ,.iosf_mon_MBEWD              (iosfp_mon_MBEWD              )
    ,.iosf_mon_MADDRESS           (iosfp_mon_MADDRESS           )
    ,.iosf_mon_MRS                (iosfp_mon_MRS                )
    ,.iosf_mon_MTD                (iosfp_mon_MTD                )
    ,.iosf_mon_MECRC              (iosfp_mon_MECRC              )
    ,.iosf_mon_MECRC_GENERATE     (iosfp_mon_MECRC_GENERATE     )
    ,.iosf_mon_MECRC_ERROR        (iosfp_mon_MECRC_ERROR        )
    ,.iosf_mon_MRSVD0_7           (iosfp_mon_MRSVD0_7           )
    ,.iosf_mon_MRSVD1_1           (iosfp_mon_MRSVD1_1           )
    ,.iosf_mon_MRSVD1_3           (iosfp_mon_MRSVD1_3           )
    ,.iosf_mon_MRSVD1_7           (iosfp_mon_MRSVD1_7           )
    ,.iosf_mon_MCPARITY           (iosfp_mon_MCPARITY           )
    ,.iosf_mon_MSRC_ID            (iosfp_mon_MSRC_ID            )
    ,.iosf_mon_MDEST_ID           (iosfp_mon_MDEST_ID           )
    ,.iosf_mon_MSAI               (iosfp_mon_MSAI               )
    ,.iosf_mon_MDEADLINE          (iosfp_mon_MDEADLINE          )
    ,.iosf_mon_MPASIDTLP          (iosfp_mon_MPASIDTLP          )
    ,.iosf_mon_MDATA              (iosfp_mon_MDATA              )
    ,.iosf_mon_MDPARITY           (iosfp_mon_MDPARITY           )
    ,.iosf_mon_MDBE               (iosfp_mon_MDBE               )
    ,.iosf_mon_CMD_PUT            (iosfp_mon_CMD_PUT            )
    ,.iosf_mon_CMD_CHID           (iosfp_mon_CMD_CHID           )
    ,.iosf_mon_CMD_RTYPE          (iosfp_mon_CMD_RTYPE          )
    ,.iosf_mon_CMD_NFS_ERR        (iosfp_mon_CMD_NFS_ERR        )
    ,.iosf_mon_TFMT               (iosfp_mon_TFMT               )
    ,.iosf_mon_TTYPE              (iosfp_mon_TTYPE              )
    ,.iosf_mon_TTC                (iosfp_mon_TTC                )
    ,.iosf_mon_TEP                (iosfp_mon_TEP                )
    ,.iosf_mon_TRO                (iosfp_mon_TRO                )
    ,.iosf_mon_TNS                (iosfp_mon_TNS                )
    ,.iosf_mon_TIDO               (iosfp_mon_TIDO               )
    ,.iosf_mon_TTH                (iosfp_mon_TTH                )
    ,.iosf_mon_TCHAIN             (iosfp_mon_TCHAIN             )
    ,.iosf_mon_TAT                (iosfp_mon_TAT                )
    ,.iosf_mon_TLENGTH            (iosfp_mon_TLENGTH            )
    ,.iosf_mon_TRQID              (iosfp_mon_TRQID              )
    ,.iosf_mon_TTAG               (iosfp_mon_TTAG               )
    ,.iosf_mon_TLBE               (iosfp_mon_TLBE               )
    ,.iosf_mon_TFBE               (iosfp_mon_TFBE               )
    ,.iosf_mon_TBEWD              (iosfp_mon_TBEWD              )
    ,.iosf_mon_TADDRESS           (iosfp_mon_TADDRESS           )
    ,.iosf_mon_TRS                (iosfp_mon_TRS                )
    ,.iosf_mon_TTD                (iosfp_mon_TTD                )
    ,.iosf_mon_TECRC              (iosfp_mon_TECRC              )
    ,.iosf_mon_TECRC_GENERATE     (iosfp_mon_TECRC_GENERATE     )
    ,.iosf_mon_TECRC_ERROR        (iosfp_mon_TECRC_ERROR        )
    ,.iosf_mon_TRSVD0_7           (iosfp_mon_TRSVD0_7           )
    ,.iosf_mon_TRSVD1_1           (iosfp_mon_TRSVD1_1           )
    ,.iosf_mon_TRSVD1_3           (iosfp_mon_TRSVD1_3           )
    ,.iosf_mon_TRSVD1_7           (iosfp_mon_TRSVD1_7           )
    ,.iosf_mon_TCPARITY           (iosfp_mon_TCPARITY           )
    ,.iosf_mon_TSRC_ID            (iosfp_mon_TSRC_ID            )
    ,.iosf_mon_TDEST_ID           (iosfp_mon_TDEST_ID           )
    ,.iosf_mon_TSAI               (iosfp_mon_TSAI               )
    ,.iosf_mon_TDEADLINE          (iosfp_mon_TDEADLINE          )
    ,.iosf_mon_TPASIDTLP          (iosfp_mon_TPASIDTLP          )
    ,.iosf_mon_TPRIORITY          (iosfp_mon_TPRIORITY          )
    ,.iosf_mon_TDATA              (iosfp_mon_TDATA              )
    ,.iosf_mon_TDBE               (iosfp_mon_TDBE               )
    ,.iosf_mon_TDPARITY           (iosfp_mon_TDPARITY           )
    ,.iosf_mon_CREDIT_DATA        (iosfp_mon_CREDIT_DATA        )
    ,.iosf_mon_CREDIT_CHID        (iosfp_mon_CREDIT_CHID        )

    ,.mreq_chnnl_cap_rdata_valid        (cap_rdata_valid[0])
    ,.mreq_chnnl_cap_rdata              (cap_rdata[0][REQ_CAP_FF_DATA_W-1:0])

    ,.treq_chnnl_cap_rdata_valid        (cap_rdata_valid[1])
    ,.treq_chnnl_cap_rdata              (cap_rdata[1][REQ_CAP_FF_DATA_W-1:0])

    ,.mdata_chnnl_cap_rdata_valid       (cap_rdata_valid[2])
    ,.mdata_chnnl_cap_rdata             (cap_rdata[2][DATA_CAP_FF_DATA_W-1:0])

    ,.tdata_chnnl_cap_rdata_valid       (cap_rdata_valid[3])
    ,.tdata_chnnl_cap_rdata             (cap_rdata[3][DATA_CAP_FF_DATA_W-1:0])

    ,.cap_rden                          (cap_rden)
    ,.chnnl_egr_valid_bin               (cap_rdata_valid_bin)

  );
  assign cap_rdata[0][DBG_CAP_DATA_WIDTH_MAX-1:REQ_CAP_FF_DATA_W]='h0;
  assign cap_rdata[1][DBG_CAP_DATA_WIDTH_MAX-1:REQ_CAP_FF_DATA_W]='h0;
  assign cap_rdata[2][DBG_CAP_DATA_WIDTH_MAX-1:DATA_CAP_FF_DATA_W]='h0;
  assign cap_rdata[3][DBG_CAP_DATA_WIDTH_MAX-1:DATA_CAP_FF_DATA_W]='h0;

endmodule //IW_fpga_iosf_p_mon_av
