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

module IW_fpga_iosf_p_mon #(
    parameter MON_TYPE            = "prim"                    //Should be either pmsb or gpsb
  , parameter INSTANCE_NAME       = "u_iosf_p_mon"            //Can hold upto 16 ASCII characters
  , parameter MODE                = "avl"                     //Either 'standalone' or 'avl' mode
  , parameter GNT_DELAY           = 0                         //grant command delay

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

  /*  Do Not Modify */
  , parameter NUM_CAP_INTFS            = 4
  , parameter RECORD_ID_WIDTH          = 32
  , parameter MREQ_JEM_CAP_RECORD_W    = $bits(t_iosf_p_jem_mreq)  //Width of the structure/record captured from JEM
  , parameter TREQ_JEM_CAP_RECORD_W    = $bits(t_iosf_p_jem_treq)  //Width of the structure/record captured from JEM
  , parameter MDATA_JEM_CAP_RECORD_W   = $bits(t_iosf_p_jem_mdata) //Width of the structure/record captured from JEM
  , parameter TDATA_JEM_CAP_RECORD_W   = $bits(t_iosf_p_jem_tdata) //Width of the structure/record captured from JEM
  , parameter MREQ_CAP_RECORD_W        = MREQ_JEM_CAP_RECORD_W  + RECORD_ID_WIDTH //Width of the structure/record captured with record-id
  , parameter TREQ_CAP_RECORD_W        = TREQ_JEM_CAP_RECORD_W  + RECORD_ID_WIDTH //Width of the structure/record captured with record-id
  , parameter MDATA_CAP_RECORD_W       = MDATA_JEM_CAP_RECORD_W + RECORD_ID_WIDTH //Width of the structure/record captured with record-id
  , parameter TDATA_CAP_RECORD_W       = TDATA_JEM_CAP_RECORD_W + RECORD_ID_WIDTH //Width of the structure/record captured with record-id
  , parameter REQ_CAP_FF_DATA_W        = 224
  , parameter DATA_CAP_FF_DATA_W       = 576
  , parameter AV_MM_DATA_W             = 32
  , parameter AV_MM_ADDR_W             = 16
  , parameter READ_MISS_VAL            = 32'hDEADBABE   // Read miss value

  /*  Do not modify */
  , parameter NUM_CHANNELS_BIN  = $clog2(NUM_CAP_INTFS)

) (

  /*  CSR Interface */
    input   logic                        clk_csr
  , input   logic                        rst_csr_n,

    input   wire  [AV_MM_ADDR_W-1:0]     avl_mm_address,          // avl_mm.address
    output  reg   [AV_MM_DATA_W-1:0]     avl_mm_readdata,         //       .readdata
    input   wire                         avl_mm_read,             //       .read
    output  reg                          avl_mm_readdatavalid,    //       .readdatavalid
    input   wire                         avl_mm_write,            //       .write
    input   wire  [AV_MM_DATA_W-1:0]     avl_mm_writedata,        //       .writedata
    input   wire  [(AV_MM_DATA_W/8)-1:0] avl_mm_byteenable,       //       .byteenable
    output  wire                         avl_mm_waitrequest       //       .waitrequest

  /*  Logic Interface */
  , input  logic                        clk_logic
  , input  logic                        rst_logic_n

  //----------------------------------------------------------------------------------
  // Ingress IOSF Consumer-Monitor Interface
  //----------------------------------------------------------------------------------
  , input     [2:0]                    iosf_mon_PRIM_ISM_AGENT  // Agent ISM 
//  , input                              iosf_mon_clk_PRIM_CLK    // Primary Interface Clock
//  , input                              iosf_mon_rst_PRIM_RST_B  // Primary Interface Reset
  , input     [2:0]                    iosf_mon_PRIM_ISM_FABRIC // Fabric ISM
 
  , input                              iosf_mon_REQ_PUT         // Request Put
  , input     [MNUMCHANL2:0]           iosf_mon_REQ_CHID        // Request Channel
  , input     [RS_WIDTH:0]             iosf_mon_REQ_RS          // Request Root space
  , input     [1:0]                    iosf_mon_REQ_RTYPE       // Request Type
  , input                              iosf_mon_REQ_CDATA       // Request Contains Data
  , input     [MAX_DATA_LEN:0]         iosf_mon_REQ_DLEN        // Request Data Length
  , input     [3:0]                    iosf_mon_REQ_TC          // Request Traffic Class
  , input                              iosf_mon_REQ_NS          // Request Non-Snoop
  , input                              iosf_mon_REQ_RO          // Request Relaxed Order
  , input                              iosf_mon_REQ_IDO         // Request Id based ordering
  , input     [15:0]                   iosf_mon_REQ_ID          // Request Id
  , input                              iosf_mon_REQ_LOCKED      // Request Locked
  , input                              iosf_mon_REQ_CHAIN       // Request chain
  , input                              iosf_mon_REQ_OPP         // Request oppurtunistic
  , input     [AGENT_WIDTH:0]          iosf_mon_REQ_AGENT       // Request agent specific
  , input     [MNUMCHAN:0]             iosf_mon_REQ_PRIORITY    // Priority      request
  , input     [DST_ID_WIDTH:0]         iosf_mon_REQ_DEST_ID     // Destination ID
  , input                              iosf_mon_GNT             // Grant
  , input     [MNUMCHANL2:0]           iosf_mon_GNT_CHID        // Grant Channel
  , input     [1:0]                    iosf_mon_GNT_RTYPE       // Grant Request Type
  , input     [1:0]                    iosf_mon_GNT_TYPE        // Grant Type
  , input     [1:0]                    iosf_mon_OBFF            // Optimised Buffer Flush/Full

  , input     [1:0]                    iosf_mon_MFMT            // Format
  , input     [4:0]                    iosf_mon_MTYPE           // Type
  , input     [3:0]                    iosf_mon_MTC             // Traffic Class
  , input                              iosf_mon_MTH             // Transaction hint
  , input                              iosf_mon_MEP             // Error Present
  , input                              iosf_mon_MRO             // Relaxed Ordering
  , input                              iosf_mon_MNS             // Non-Snoop
  , input                              iosf_mon_MIDO            // ID Based Ordering
  , input     [1:0]                    iosf_mon_MAT             // Address translation Services
  , input     [9:0]                    iosf_mon_MLENGTH         // Length
  , input     [15:0]                   iosf_mon_MRQID           // Requester ID
  , input     [7:0]                    iosf_mon_MTAG            // mag
  , input     [3:0]                    iosf_mon_MLBE            // Last DW Byte Enable
  , input     [3:0]                    iosf_mon_MFBE            // First DW Byte Enable
  , input                              iosf_mon_MBEWD           // Master Byte Enables With Data
  , input     [MMAX_ADDR:0]            iosf_mon_MADDRESS        // Address
  , input     [RS_WIDTH:0]             iosf_mon_MRS             // Root space
  , input                              iosf_mon_MTD             // mLP Digest
  , input     [31:0]                   iosf_mon_MECRC           // End to end CRC
  , input                              iosf_mon_MECRC_GENERATE  // Ecrc generate  
  , input                              iosf_mon_MECRC_ERROR     // Ecrc error
  , input                              iosf_mon_MRSVD0_7        // PCI Express Reserved
  , input                              iosf_mon_MRSVD1_1        // PCI Express Reserved
  , input                              iosf_mon_MRSVD1_3        // PCI Express Reserved
  , input                              iosf_mon_MRSVD1_7        // PCI Express Reserved
  , input                              iosf_mon_MCPARITY        // Command Parity
  , input     [SRC_ID_WIDTH:0]         iosf_mon_MSRC_ID         // Src ID
  , input     [DST_ID_WIDTH:0]         iosf_mon_MDEST_ID        // Dest ID
  , input     [SAI_WIDTH:0]            iosf_mon_MSAI            // SAI
  , input     [DEADLINE_WIDTH:0]       iosf_mon_MDEADLINE       // Deadline
  , input     [22:0]                   iosf_mon_MPASIDTLP       // PASID TLP prefix
 
  , input     [MD_WIDTH:0]             iosf_mon_MDATA            // Data
  , input     [MDP_WIDTH:0]            iosf_mon_MDPARITY         // Data Parity
  , input     [MDBE_WIDTH-1:0]         iosf_mon_MDBE             // Master Data byte enables

  , input                              iosf_mon_CMD_PUT          // Command Put
  , input     [TNUMCHANL2:0]           iosf_mon_CMD_CHID         // Command Channel ID
  , input     [1:0]                    iosf_mon_CMD_RTYPE        // Put Request Type*
  , input                              iosf_mon_CMD_NFS_ERR      // Put Nonfunction specific error
  , input     [1:0]                    iosf_mon_TFMT             // Format
  , input     [4:0]                    iosf_mon_TTYPE            // Type
  , input     [3:0]                    iosf_mon_TTC              // Traffic Class
  , input                              iosf_mon_TEP              // Error Present
  , input                              iosf_mon_TRO              // Relaxed Ordering
  , input                              iosf_mon_TNS              // Non-Snoop
  , input                              iosf_mon_TIDO             // ID Based Ordering
  , input                              iosf_mon_TTH              // Transaction Hints
  , input                              iosf_mon_TCHAIN           // Chain
  , input     [1:0]                    iosf_mon_TAT              // Address Transaltion Services
  , input     [9:0]                    iosf_mon_TLENGTH          // Length
  , input     [15:0]                   iosf_mon_TRQID            // Requester ID
  , input     [7:0]                    iosf_mon_TTAG             // Tag
  , input     [3:0]                    iosf_mon_TLBE             // Last DW Byte Enable
  , input     [3:0]                    iosf_mon_TFBE             // First DW Byte Enable
  , input                              iosf_mon_TBEWD            // Target byte enable with data
  , input     [TMAX_ADDR:0]            iosf_mon_TADDRESS         // Address
  , input     [RS_WIDTH:0]             iosf_mon_TRS              // Root space
  , input                              iosf_mon_TTD              // TLP Digest
  , input     [31:0]                   iosf_mon_TECRC            // End to end CRC
  , input                              iosf_mon_TECRC_GENERATE   // Ecrc generate
  , input                              iosf_mon_TECRC_ERROR      // Ecrc error
  , input                              iosf_mon_TRSVD0_7         // PCI Express Reserved
  , input                              iosf_mon_TRSVD1_1         // PCI Express Reserved
  , input                              iosf_mon_TRSVD1_3         // PCI Express Reserved
  , input                              iosf_mon_TRSVD1_7         // PCI Express Reserved
  , input                              iosf_mon_TCPARITY         // Command Parity
  , input     [SRC_ID_WIDTH:0]         iosf_mon_TSRC_ID          // Src ID
  , input     [DST_ID_WIDTH:0]         iosf_mon_TDEST_ID         // Dest ID
  , input     [SAI_WIDTH:0]            iosf_mon_TSAI             // Security Attributes of Initiator
  , input     [DEADLINE_WIDTH:0]       iosf_mon_TDEADLINE        // Deadline
  , input     [22:0]                   iosf_mon_TPASIDTLP        // PASID TLP prefix
  , input     [TNUMCHAN:0]             iosf_mon_TPRIORITY        // Priority

  , input     [TD_WIDTH:0]             iosf_mon_TDATA            // Data
  , input     [TDBE_WIDTH-1:0]         iosf_mon_TDBE             // Target Data byte enable
  , input     [TDP_WIDTH:0]            iosf_mon_TDPARITY

  , input     [2:0]                    iosf_mon_CREDIT_DATA
  , input     [TNUMCHANL2CREDIT:0]     iosf_mon_CREDIT_CHID

  /*  treq channel CAP Interface  */
  , output logic                                treq_chnnl_cap_rdata_valid
  , output logic  [REQ_CAP_FF_DATA_W-1:0]       treq_chnnl_cap_rdata

  /*  mreq channel CAP Interface  */
  , output logic                                mreq_chnnl_cap_rdata_valid
  , output logic  [REQ_CAP_FF_DATA_W-1:0]       mreq_chnnl_cap_rdata

  /*  tdata channel CAP Interface  */
  , output logic                                tdata_chnnl_cap_rdata_valid
  , output logic  [DATA_CAP_FF_DATA_W-1:0]      tdata_chnnl_cap_rdata

  /*  mdata channel CAP Interface  */
  , output logic                                mdata_chnnl_cap_rdata_valid
  , output logic  [DATA_CAP_FF_DATA_W-1:0]      mdata_chnnl_cap_rdata

  , input logic                                 cap_rden            
  , output logic  [NUM_CHANNELS_BIN-1:0]        chnnl_egr_valid_bin

);

  /*  Internal Parameters */
  //localparam  JEM_TRACKER_BUFFER_SIZE = 160;  //Should match with t_iosf_p_jem_req.data
  localparam  CAP_FF_DEPTH            = 512;
  localparam  CAP_FF_USED_W           = 10;

  /*  wire/reg  */
  wire                                mon_enable;
  wire  [TREQ_JEM_CAP_RECORD_W-1:0]   treq_mask_en;
  wire  [TREQ_JEM_CAP_RECORD_W-1:0]   treq_mask_value;
  wire  [MREQ_JEM_CAP_RECORD_W-1:0]   mreq_mask_en;
  wire  [MREQ_JEM_CAP_RECORD_W-1:0]   mreq_mask_value;

  wire                                mreq_mon_data_valid;
  wire                                treq_mon_data_valid;

  wire  [TDATA_JEM_CAP_RECORD_W-1:0]  tdata_mask_en;
  wire  [TDATA_JEM_CAP_RECORD_W-1:0]  tdata_mask_value;
  wire  [MDATA_JEM_CAP_RECORD_W-1:0]  mdata_mask_en;
  wire  [MDATA_JEM_CAP_RECORD_W-1:0]  mdata_mask_value;

  wire                                mdata_mon_data_valid;
  wire                                tdata_mon_data_valid;

  wire  [MREQ_JEM_CAP_RECORD_W-1:0]   mreq_filt_data;
  wire                                mreq_filt_data_valid;
  wire                                mreq_filt_bp;

  wire  [TREQ_JEM_CAP_RECORD_W-1:0]   treq_filt_data;
  wire                                treq_filt_data_valid;
  wire                                treq_filt_bp;

  wire                             mreq_cap_ff_wrclk;
  wire                             mreq_cap_ff_full;
  wire                             mreq_cap_ff_wren;
  wire  [REQ_CAP_FF_DATA_W-1:0]    mreq_cap_ff_wdata;
  wire  [CAP_FF_USED_W-1:0]        mreq_cap_ff_wrused;
  wire                             mreq_cap_ff_rdclk;
  wire                             mreq_cap_ff_empty;
  wire                             mreq_cap_ff_rden;
  wire  [REQ_CAP_FF_DATA_W-1:0]    mreq_cap_ff_rdata;
  wire  [CAP_FF_USED_W-1:0]        mreq_cap_ff_rdused;
  wire                             mreq_cap_ff_rst_n;

  wire                             treq_cap_ff_wrclk;
  wire                             treq_cap_ff_full;
  wire                             treq_cap_ff_wren;
  wire  [REQ_CAP_FF_DATA_W-1:0]    treq_cap_ff_wdata;
  wire  [CAP_FF_USED_W-1:0]        treq_cap_ff_wrused;
  wire                             treq_cap_ff_rdclk;
  wire                             treq_cap_ff_empty;
  wire                             treq_cap_ff_rden;
  wire  [REQ_CAP_FF_DATA_W-1:0]    treq_cap_ff_rdata;
  wire  [CAP_FF_USED_W-1:0]        treq_cap_ff_rdused;
  wire                             treq_cap_ff_rst_n;

  wire  [MDATA_JEM_CAP_RECORD_W-1:0]  mdata_filt_data;
  wire                                mdata_filt_data_valid;
  wire                                mdata_filt_bp;

  wire  [TDATA_JEM_CAP_RECORD_W-1:0]  tdata_filt_data;
  wire                                tdata_filt_data_valid;
  wire                                tdata_filt_bp;

  wire                              mdata_cap_ff_wrclk;
  wire                              mdata_cap_ff_full;
  wire                              mdata_cap_ff_wren;
  wire  [DATA_CAP_FF_DATA_W-1:0]    mdata_cap_ff_wdata;
  wire  [CAP_FF_USED_W-1:0]         mdata_cap_ff_wrused;
  wire                              mdata_cap_ff_rdclk;
  wire                              mdata_cap_ff_empty;
  wire                              mdata_cap_ff_rden;
  wire  [DATA_CAP_FF_DATA_W-1:0]    mdata_cap_ff_rdata;
  wire  [CAP_FF_USED_W-1:0]         mdata_cap_ff_rdused;
  wire                              mdata_cap_ff_rst_n;

  wire                              tdata_cap_ff_wrclk;
  wire                              tdata_cap_ff_full;
  wire                              tdata_cap_ff_wren;
  wire  [DATA_CAP_FF_DATA_W-1:0]    tdata_cap_ff_wdata;
  wire  [CAP_FF_USED_W-1:0]         tdata_cap_ff_wrused;
  wire                              tdata_cap_ff_rdclk;
  wire                              tdata_cap_ff_empty;
  wire                              tdata_cap_ff_rden;
  wire  [DATA_CAP_FF_DATA_W-1:0]    tdata_cap_ff_rdata;
  wire  [CAP_FF_USED_W-1:0]         tdata_cap_ff_rdused;
  wire                              tdata_cap_ff_rst_n;

  wire                              csr_mreq_cap_rdata_valid;
  wire  [REQ_CAP_FF_DATA_W-1:0]     csr_mreq_cap_rdata;
  wire  [CAP_FF_USED_W-1:0]         csr_mreq_cap_rdused;
  wire                              csr_mreq_cap_rden;

  wire                              csr_treq_cap_rdata_valid;
  wire  [REQ_CAP_FF_DATA_W-1:0]     csr_treq_cap_rdata;
  wire  [CAP_FF_USED_W-1:0]         csr_treq_cap_rdused;
  wire                              csr_treq_cap_rden;

  wire                              csr_mdata_cap_rdata_valid;
  wire  [DATA_CAP_FF_DATA_W-1:0]    csr_mdata_cap_rdata;
  wire  [CAP_FF_USED_W-1:0]         csr_mdata_cap_rdused;
  wire                              csr_mdata_cap_rden;

  wire                              csr_tdata_cap_rdata_valid;
  wire  [DATA_CAP_FF_DATA_W-1:0]    csr_tdata_cap_rdata;
  wire  [CAP_FF_USED_W-1:0]         csr_tdata_cap_rdused;
  wire                              csr_tdata_cap_rden;

  wire  [MREQ_JEM_CAP_RECORD_W-1:0]   data_mreq;
  wire                                data_mreq_valid;
  wire  [TREQ_JEM_CAP_RECORD_W-1:0]   data_treq;
  wire                                data_treq_valid;
  wire  [MDATA_JEM_CAP_RECORD_W-1:0]  data_mdata;
  wire                                data_mdata_valid;
  wire  [TDATA_JEM_CAP_RECORD_W-1:0]  data_tdata;
  wire                                data_tdata_valid;

  wire  [RECORD_ID_WIDTH-1:0] cap_rec_id  [NUM_CAP_INTFS-1:0];
  wire  [NUM_CAP_INTFS-1:0]   chnnl_egr_valid;

  wire                        clr_stats;
  wire                        flush_cap_ff;
  wire                        rec_ordering_en;
  wire  [31:0]                num_mreq_pkts     ;
  wire  [31:0]                num_mreq_beats    ;
  wire  [31:0]                num_treq_pkts     ;
  wire  [31:0]                num_treq_beats    ;
  wire  [31:0]                num_mdata_pkts    ;
  wire  [31:0]                num_mdata_beats   ;
  wire  [31:0]                num_tdata_pkts    ;
  wire  [31:0]                num_tdata_beats   ;
  wire  [31:0]                num_dropped_pkts  ;


  /*  CSR Instance  */
  IW_fpga_iosf_p_mon_addr_map_avmm_wrapper #(
    .MON_TYPE                (MON_TYPE           ), 
    .INSTANCE_NAME           (INSTANCE_NAME      ),
    .MODE                    (MODE               ),
    .REQ_CAP_FF_DATA_W       (REQ_CAP_FF_DATA_W  ),
    .DATA_CAP_FF_DATA_W      (DATA_CAP_FF_DATA_W ),
    .CAP_FF_DEPTH            (CAP_FF_DEPTH       ),
    .CAP_FF_USED_W           (CAP_FF_USED_W      ),
    .AV_MM_DATA_W            (AV_MM_DATA_W       ), 
    .AV_MM_ADDR_W            (AV_MM_ADDR_W       ),
    .MAX_DATA_LEN            (MAX_DATA_LEN       ),
    .MMAX_ADDR               (MMAX_ADDR          ),
    .AGENT_WIDTH             (AGENT_WIDTH        ),
    .MNUMCHAN                (MNUMCHAN           ),
    .MNUMCHANL2              (MNUMCHANL2         ),
    .MD_WIDTH                (MD_WIDTH           ),
    .RS_WIDTH                (RS_WIDTH           ),
    .SAI_WIDTH               (SAI_WIDTH          ),
    .DEADLINE_WIDTH          (DEADLINE_WIDTH     ),
    .SRC_ID_WIDTH            (SRC_ID_WIDTH       ),
    .DST_ID_WIDTH            (DST_ID_WIDTH       ),
    .GNT_CMD_DELAY           (GNT_CMD_DELAY      ),
    .TMAX_ADDR               (TMAX_ADDR          ),
    .TNUMCHAN                (TNUMCHAN           ),
    .TNUMCHANL2              (TNUMCHANL2         ),
    .TNUMCHANL2CREDIT        (TNUMCHANL2CREDIT   ),
    .TD_WIDTH                (TD_WIDTH           ),
    .MDP_WIDTH               (MDP_WIDTH          ),
    .TDP_WIDTH               (TDP_WIDTH          ),
    .READ_MISS_VAL           (READ_MISS_VAL)
  ) u_csr (

    .avl_mm_address           (avl_mm_address),
    .avl_mm_readdata          (avl_mm_readdata),
    .avl_mm_read              (avl_mm_read),
    .avl_mm_readdatavalid     (avl_mm_readdatavalid),
    .avl_mm_write             (avl_mm_write),
    .avl_mm_writedata         (avl_mm_writedata),
    .avl_mm_byteenable        (avl_mm_byteenable),
    .avl_mm_waitrequest       (avl_mm_waitrequest),
    .csi_clk                  (clk_csr),
    .rsi_reset                (~rst_logic_n),
                                               
    .clk_logic                (clk_logic),

    .treq_cap_rdata_valid     (csr_treq_cap_rdata_valid),
    .treq_cap_rdata           (csr_treq_cap_rdata),
    .treq_cap_rdused          (csr_treq_cap_rdused),
    .treq_cap_rden            (csr_treq_cap_rden),

    .mreq_cap_rdata_valid     (csr_mreq_cap_rdata_valid),
    .mreq_cap_rdata           (csr_mreq_cap_rdata),
    .mreq_cap_rdused          (csr_mreq_cap_rdused),
    .mreq_cap_rden            (csr_mreq_cap_rden),
 
    .tdata_cap_rdata_valid    (csr_tdata_cap_rdata_valid),
    .tdata_cap_rdata          (csr_tdata_cap_rdata),
    .tdata_cap_rdused         (csr_tdata_cap_rdused),
    .tdata_cap_rden           (csr_tdata_cap_rden),

    .mdata_cap_rdata_valid    (csr_mdata_cap_rdata_valid),
    .mdata_cap_rdata          (csr_mdata_cap_rdata),
    .mdata_cap_rdused         (csr_mdata_cap_rdused),
    .mdata_cap_rden           (csr_mdata_cap_rden),

    .iosf_mon_PRIM_ISM_AGENT  (iosf_mon_PRIM_ISM_AGENT),
    .iosf_mon_PRIM_ISM_FABRIC (iosf_mon_PRIM_ISM_FABRIC),

    .iosf_mon_REQ_PUT         (iosf_mon_REQ_PUT          ), 
    .iosf_mon_REQ_CHID        (iosf_mon_REQ_CHID         ),
    .iosf_mon_REQ_RS          (iosf_mon_REQ_RS           ),
    .iosf_mon_REQ_RTYPE       (iosf_mon_REQ_RTYPE        ),
    .iosf_mon_REQ_CDATA       (iosf_mon_REQ_CDATA        ),
    .iosf_mon_REQ_DLEN        (iosf_mon_REQ_DLEN         ),
    .iosf_mon_REQ_TC          (iosf_mon_REQ_TC           ),
    .iosf_mon_REQ_NS          (iosf_mon_REQ_NS           ),
    .iosf_mon_REQ_RO          (iosf_mon_REQ_RO           ),
    .iosf_mon_REQ_IDO         (iosf_mon_REQ_IDO          ),
    .iosf_mon_REQ_ID          (iosf_mon_REQ_ID           ),
    .iosf_mon_REQ_LOCKED      (iosf_mon_REQ_LOCKED       ),
    .iosf_mon_REQ_CHAIN       (iosf_mon_REQ_CHAIN        ),
    .iosf_mon_REQ_OPP         (iosf_mon_REQ_OPP          ),
    .iosf_mon_REQ_AGENT       (iosf_mon_REQ_AGENT        ),
    .iosf_mon_REQ_PRIORITY    (iosf_mon_REQ_PRIORITY     ),
    .iosf_mon_REQ_DEST_ID     (iosf_mon_REQ_DEST_ID      ),
    .iosf_mon_GNT             (iosf_mon_GNT              ),
    .iosf_mon_GNT_CHID        (iosf_mon_GNT_CHID         ),
    .iosf_mon_GNT_RTYPE       (iosf_mon_GNT_RTYPE        ),
    .iosf_mon_GNT_TYPE        (iosf_mon_GNT_TYPE         ),
    .iosf_mon_OBFF            (iosf_mon_OBFF             ),
   
    .iosf_mon_MFMT            (iosf_mon_MFMT             ),
    .iosf_mon_MTYPE           (iosf_mon_MTYPE            ),
    .iosf_mon_MTC             (iosf_mon_MTC              ),
    .iosf_mon_MTH             (iosf_mon_MTH              ),
    .iosf_mon_MEP             (iosf_mon_MEP              ),
    .iosf_mon_MRO             (iosf_mon_MRO              ),
    .iosf_mon_MNS             (iosf_mon_MNS              ),
    .iosf_mon_MIDO            (iosf_mon_MIDO             ),
    .iosf_mon_MAT             (iosf_mon_MAT              ),
    .iosf_mon_MLENGTH         (iosf_mon_MLENGTH          ),
    .iosf_mon_MRQID           (iosf_mon_MRQID            ),
    .iosf_mon_MTAG            (iosf_mon_MTAG             ),
    .iosf_mon_MLBE            (iosf_mon_MLBE             ),
    .iosf_mon_MFBE            (iosf_mon_MFBE             ),
    .iosf_mon_MBEWD           (iosf_mon_MBEWD            ),
    .iosf_mon_MADDRESS        (iosf_mon_MADDRESS         ),
    .iosf_mon_MRS             (iosf_mon_MRS              ),
    .iosf_mon_MTD             (iosf_mon_MTD              ),
    .iosf_mon_MECRC           (iosf_mon_MECRC            ),
    .iosf_mon_MECRC_GENERATE  (iosf_mon_MECRC_GENERATE   ),
    .iosf_mon_MECRC_ERROR     (iosf_mon_MECRC_ERROR      ),
    .iosf_mon_MRSVD0_7        (iosf_mon_MRSVD0_7         ),
    .iosf_mon_MRSVD1_1        (iosf_mon_MRSVD1_1         ),
    .iosf_mon_MRSVD1_3        (iosf_mon_MRSVD1_3         ),
    .iosf_mon_MRSVD1_7        (iosf_mon_MRSVD1_7         ),
    .iosf_mon_MCPARITY        (iosf_mon_MCPARITY         ),
    .iosf_mon_MSRC_ID         (iosf_mon_MSRC_ID          ),
    .iosf_mon_MDEST_ID        (iosf_mon_MDEST_ID         ),
    .iosf_mon_MSAI            (iosf_mon_MSAI             ),
    .iosf_mon_MDEADLINE       (iosf_mon_MDEADLINE        ),
    .iosf_mon_MPASIDTLP       (iosf_mon_MPASIDTLP        ),
  
    .iosf_mon_MDATA           (iosf_mon_MDATA            ),
    .iosf_mon_MDPARITY        (iosf_mon_MDPARITY         ),
    .iosf_mon_MDBE            (iosf_mon_MDBE             ),
  
    .iosf_mon_CMD_PUT         (iosf_mon_CMD_PUT          ),
    .iosf_mon_CMD_CHID        (iosf_mon_CMD_CHID         ),
    .iosf_mon_CMD_RTYPE       (iosf_mon_CMD_RTYPE        ),
    .iosf_mon_CMD_NFS_ERR     (iosf_mon_CMD_NFS_ERR      ),
    .iosf_mon_TFMT            (iosf_mon_TFMT             ),
    .iosf_mon_TTYPE           (iosf_mon_TTYPE            ),
    .iosf_mon_TTC             (iosf_mon_TTC              ),
    .iosf_mon_TEP             (iosf_mon_TEP              ),
    .iosf_mon_TRO             (iosf_mon_TRO              ),
    .iosf_mon_TNS             (iosf_mon_TNS              ),
    .iosf_mon_TIDO            (iosf_mon_TIDO             ),
    .iosf_mon_TTH             (iosf_mon_TTH              ),
    .iosf_mon_TCHAIN          (iosf_mon_TCHAIN           ),
    .iosf_mon_TAT             (iosf_mon_TAT              ),
    .iosf_mon_TLENGTH         (iosf_mon_TLENGTH          ),
    .iosf_mon_TRQID           (iosf_mon_TRQID            ),
    .iosf_mon_TTAG            (iosf_mon_TTAG             ),
    .iosf_mon_TLBE            (iosf_mon_TLBE             ),
    .iosf_mon_TFBE            (iosf_mon_TFBE             ),
    .iosf_mon_TBEWD           (iosf_mon_TBEWD            ),
    .iosf_mon_TADDRESS        (iosf_mon_TADDRESS         ),
    .iosf_mon_TRS             (iosf_mon_TRS              ),
    .iosf_mon_TTD             (iosf_mon_TTD              ),
    .iosf_mon_TECRC           (iosf_mon_TECRC            ),
    .iosf_mon_TECRC_GENERATE  (iosf_mon_TECRC_GENERATE   ),
    .iosf_mon_TECRC_ERROR     (iosf_mon_TECRC_ERROR      ),
    .iosf_mon_TRSVD0_7        (iosf_mon_TRSVD0_7         ),
    .iosf_mon_TRSVD1_1        (iosf_mon_TRSVD1_1         ),
    .iosf_mon_TRSVD1_3        (iosf_mon_TRSVD1_3         ),
    .iosf_mon_TRSVD1_7        (iosf_mon_TRSVD1_7         ),
    .iosf_mon_TCPARITY        (iosf_mon_TCPARITY         ),
    .iosf_mon_TSRC_ID         (iosf_mon_TSRC_ID          ),
    .iosf_mon_TDEST_ID        (iosf_mon_TDEST_ID         ),
    .iosf_mon_TSAI            (iosf_mon_TSAI             ),
    .iosf_mon_TDEADLINE       (iosf_mon_TDEADLINE        ),
    .iosf_mon_TPASIDTLP       (iosf_mon_TPASIDTLP        ),
    .iosf_mon_TPRIORITY       (iosf_mon_TPRIORITY        ),
 
    .iosf_mon_TDATA           (iosf_mon_TDATA            ),
    .iosf_mon_TDBE            (iosf_mon_TDBE             ),

    .iosf_mon_TDPARITY        (iosf_mon_TDPARITY         ),
                                                
    .num_mreq_pkts             (num_mreq_pkts),
    .num_mreq_beats            (num_mreq_beats),
    .num_treq_pkts             (num_treq_pkts),
    .num_treq_beats            (num_treq_beats),
    .num_mdata_pkts            (num_mdata_pkts),
    .num_mdata_beats           (num_mdata_beats),
    .num_tdata_pkts            (num_tdata_pkts),
    .num_tdata_beats           (num_tdata_beats),
    .num_dropped_pkts          (num_dropped_pkts),
 

    .mon_enable                (mon_enable),
    .clr_stats                 (clr_stats),
    .flush_cap_ff              (flush_cap_ff),
    .rec_ordering_en           (rec_ordering_en),
    .mreq_mask_value           (mreq_mask_value),
    .treq_mask_value           (treq_mask_value),
    .mdata_mask_value          (mdata_mask_value),
    .tdata_mask_value          (tdata_mask_value),
    .mreq_mask_en              (mreq_mask_en),
    .treq_mask_en              (treq_mask_en),
    .mdata_mask_en             (mdata_mask_en),
    .tdata_mask_en             (tdata_mask_en)
  );

  /*  Statistics  Instance  */
  IW_fpga_iosf_p_mon_stats   u_stats
  (
     .clk_logic               (clk_logic               )
    ,.rst_logic_n             (rst_logic_n             )

    ,.clr_stats               (clr_stats               )

    ,.mreq_mon_data_valid     (mreq_mon_data_valid     )
    ,.mreq_filt_bp            (mreq_filt_bp            )

    ,.treq_mon_data_valid     (treq_mon_data_valid     )
    ,.treq_filt_bp            (treq_filt_bp            )

    ,.mdata_mon_data_valid    (mdata_mon_data_valid    )
    ,.mdata_filt_bp           (mdata_filt_bp           )

    ,.tdata_mon_data_valid    (tdata_mon_data_valid    )
    ,.tdata_filt_bp           (tdata_filt_bp           )
   
    ,.iosf_mon_CMD_PUT        (iosf_mon_CMD_PUT        )
    ,.iosf_mon_REQ_PUT        (iosf_mon_REQ_PUT        )

    ,.num_mreq_pkts             (num_mreq_pkts)
    ,.num_mreq_beats            (num_mreq_beats)
    ,.num_treq_pkts             (num_treq_pkts)
    ,.num_treq_beats            (num_treq_beats)
    ,.num_mdata_pkts            (num_mdata_pkts)
    ,.num_mdata_beats           (num_mdata_beats)
    ,.num_tdata_pkts            (num_tdata_pkts)
    ,.num_tdata_beats           (num_tdata_beats)
    ,.num_dropped_pkts          (num_dropped_pkts)
  );
 assign mreq_mon_data_valid = data_mreq_valid;
 assign treq_mon_data_valid = data_treq_valid;
 assign mdata_mon_data_valid = data_mdata_valid;
 assign tdata_mon_data_valid = data_tdata_valid;

  /*  iosf primary jem tracker  */
  iosf_p_jem_tracker #(       
    .GNT_DELAY(GNT_DELAY)  
  ) iosf_p_jem_tracker (     
    .enable            (mon_enable),                      
    .dir               (1'b0),                        
    .clk               (clk_logic),                
    .resetb            (rst_logic_n),              
    .cmd_maddr         ({{(63-MMAX_ADDR){1'b0}},iosf_mon_MADDRESS}),         
    .cmd_msrcid        ({{(15-SRC_ID_WIDTH){1'b0}},iosf_mon_MSRC_ID}),                         
    .cmd_mdestid       ({{(15-DST_ID_WIDTH){1'b0}},iosf_mon_MDEST_ID}),
    .cmd_mrs           (iosf_mon_MRS),              
    .cmd_mep           (iosf_mon_MEP),
    .cmd_mido          (iosf_mon_MIDO),                         
    .cmd_mns           (iosf_mon_MNS),
    .cmd_mro           (iosf_mon_MRO),
    .cmd_msai          ({{(7-SAI_WIDTH){1'b0}},iosf_mon_MSAI}),             
    .cmd_mfbe          (iosf_mon_MFBE),             
    .cmd_mfmt          (iosf_mon_MFMT),             
    .cmd_mlbe          (iosf_mon_MLBE),             
    .cmd_mlength       (iosf_mon_MLENGTH),          
    .cmd_mreqid        (iosf_mon_MRQID),            
    .cmd_mtag          (iosf_mon_MTAG),             
    .cmd_mtc           (iosf_mon_MTC),              
    .cmd_mtype         (iosf_mon_MTYPE),            
    .cmd_taddr         ({{(63-TMAX_ADDR){1'b0}},iosf_mon_TADDRESS}),         
    .cmd_tfbe          (iosf_mon_TFBE),             
    .cmd_tfmt          (iosf_mon_TFMT),             
    .cmd_tlbe          (iosf_mon_TLBE),             
    .cmd_tlength       (iosf_mon_TLENGTH),          
    .cmd_tput          (iosf_mon_CMD_PUT),          
    .cmd_tchid         ({{(3-TNUMCHANL2){1'b0}},iosf_mon_CMD_CHID}),
    .cmd_trtype        (iosf_mon_CMD_RTYPE),        
    .cmd_treqid        (iosf_mon_TRQID),            
    .cmd_ttag          (iosf_mon_TTAG),             
    .cmd_ttc           (iosf_mon_TTC),              
    .cmd_tsrcid        ({{(15-SRC_ID_WIDTH){1'b0}},iosf_mon_TSRC_ID}),
    .cmd_tdestid       ({{(15-DST_ID_WIDTH){1'b0}},iosf_mon_TDEST_ID}),         
    .cmd_trs           (iosf_mon_TRS),               
    .cmd_tep           (iosf_mon_TEP),               
    .cmd_tido          (iosf_mon_TIDO),                          
    .cmd_tns           (iosf_mon_TNS),               
    .cmd_tro           (iosf_mon_TRO),               
    .cmd_tsai          ({{(7-SAI_WIDTH){1'b0}},iosf_mon_TSAI}),             
    .cmd_ttype         (iosf_mon_TTYPE),            
    .gnt               (iosf_mon_GNT),              
    .gnt_chid          ({{(3-MNUMCHANL2){1'b0}},iosf_mon_GNT_CHID}),
    .gnt_rtype         (iosf_mon_GNT_RTYPE),        
    .gnt_type          (iosf_mon_GNT_TYPE),         
    .mdata             ({{(511-MD_WIDTH){1'b0}},iosf_mon_MDATA}),            
    .mdata_width       ((MD_WIDTH+1)>>5),
    .req_cdata         (iosf_mon_CREDIT_DATA),      
    .req_chid          ({{(3-TNUMCHANL2CREDIT){1'b0}},iosf_mon_CREDIT_CHID}),      
    .req_dlen          (iosf_mon_REQ_DLEN),         
    .req_locked        (iosf_mon_REQ_LOCKED),       
    .req_put           (iosf_mon_REQ_PUT),          
    .req_rtype         (iosf_mon_REQ_RTYPE),        
    .req_tc            (iosf_mon_REQ_TC),           
    .tdata             ({{(511-TD_WIDTH){1'b0}},iosf_mon_TDATA}),            
    .tdata_width       ((TD_WIDTH+1)>>5),       

    //jem tracker structure output
    //mreq
    .data_mreq         (data_mreq),
    .data_mreq_valid   (data_mreq_valid),
    //treq
    .data_treq         (data_treq),
    .data_treq_valid   (data_treq_valid),
    //mdata
    .data_mdata        (data_mdata),
    .data_tdata_valid  (data_tdata_valid),
    //tdata
    .data_tdata        (data_tdata),
    .data_mdata_valid  (data_mdata_valid)
  );                                                

  /*  filter instance for mreq data  */
  IW_fpga_generic_filt #(
   .DATA_WIDTH  (MREQ_JEM_CAP_RECORD_W),
   .USE_FLOP    (0)
  ) IW_fpga_generic_filt_data_mreq (
    .clk                  (clk_logic),
    .rst_n                (rst_logic_n),

    //jem tracker signals
    .mon_data             (data_mreq),
    .mon_data_valid       (data_mreq_valid),

    //csr signals
    .enable               (mon_enable),
    .match_mask           (mreq_mask_en),
    .match_data           (mreq_mask_value),

    //fifo interface
    .filt_data            (mreq_filt_data),
    .filt_data_valid      (mreq_filt_data_valid),
    .filt_bp              (mreq_filt_bp)
  );

  assign mreq_cap_ff_wdata = {{(REQ_CAP_FF_DATA_W-MREQ_CAP_RECORD_W){1'b0}},mreq_filt_data,cap_rec_id[0]};
  assign mreq_cap_ff_wren  = mreq_filt_data_valid;
  assign mreq_filt_bp      = mreq_cap_ff_full;

  /*  mreq channel capture fifo */
  //IW_fpga_iosf_p_mon_ff_224x512  u_mreq_cap_ff
  IW_fpga_async_fifo #(
    .ADDR_WD (9),
    .DATA_WD (224) ) u_mreq_cap_ff 
  (
    .rstn                         (mreq_cap_ff_rst_n),
    .data                         (mreq_cap_ff_wdata),
    .rdclk                        (mreq_cap_ff_rdclk),
    .rdreq                        (mreq_cap_ff_rden),
    .wrclk                        (mreq_cap_ff_wrclk),
    .wrreq                        (mreq_cap_ff_wren),
    .q                            (mreq_cap_ff_rdata),
    .rdempty                      (mreq_cap_ff_empty),
    .rdusedw                      (mreq_cap_ff_rdused),
    .wrfull                       (mreq_cap_ff_full),
    .wrusedw                      (mreq_cap_ff_wrused)
  );

  /*  filter instance for treq data  */
  IW_fpga_generic_filt #(
   .DATA_WIDTH  (TREQ_JEM_CAP_RECORD_W),
   .USE_FLOP    (0)
  ) IW_fpga_generic_filt_data_treq (
    .clk                  (clk_logic),
    .rst_n                (rst_logic_n),

    //jem tracker signals
    .mon_data             (data_treq),
    .mon_data_valid       (data_treq_valid),

    //csr signals
    .enable               (mon_enable),
    .match_mask           (treq_mask_en),
    .match_data           (treq_mask_value),

    //fifo interface
    .filt_data            (treq_filt_data),
    .filt_data_valid      (treq_filt_data_valid),
    .filt_bp              (treq_filt_bp)
  );

  assign  treq_cap_ff_wdata   = {{(REQ_CAP_FF_DATA_W-TREQ_CAP_RECORD_W){1'b0}},treq_filt_data,cap_rec_id[1]};
  assign  treq_cap_ff_wren    = treq_filt_data_valid;
  assign  treq_filt_bp        = treq_cap_ff_full;


  /*  treq channel capture fifo */
  //IW_fpga_iosf_p_mon_ff_224x512  u_treq_cap_ff
  IW_fpga_async_fifo #(
    .ADDR_WD (9),
    .DATA_WD (224) ) u_treq_cap_ff 
  (
    .rstn                         (treq_cap_ff_rst_n),
    .data                         (treq_cap_ff_wdata),
    .rdclk                        (treq_cap_ff_rdclk),
    .rdreq                        (treq_cap_ff_rden),
    .wrclk                        (treq_cap_ff_wrclk),
    .wrreq                        (treq_cap_ff_wren),
    .q                            (treq_cap_ff_rdata),
    .rdempty                      (treq_cap_ff_empty),
    .rdusedw                      (treq_cap_ff_rdused),
    .wrfull                       (treq_cap_ff_full),
    .wrusedw                      (treq_cap_ff_wrused)
  );

  /* filter instance for mdata  */
  IW_fpga_generic_filt #(
   .DATA_WIDTH  (MDATA_JEM_CAP_RECORD_W),
   .USE_FLOP    (0)
  ) IW_fpga_generic_filt_mdata (
    .clk                  (clk_logic),
    .rst_n                (rst_logic_n),

    //jem tracker signals
    .mon_data             (data_mdata),
    .mon_data_valid       (data_mdata_valid),

    //csr signals
    .enable               (mon_enable),
    .match_mask           (mdata_mask_en),
    .match_data           (mdata_mask_value),

    //fifo interface
    .filt_data            (mdata_filt_data),
    .filt_data_valid      (mdata_filt_data_valid),
    .filt_bp              (mdata_filt_bp)
  );

  /*  mdata channel capture fifo */
  //IW_fpga_iosf_p_mon_ff_576x512  u_mdata_cap_ff
  IW_fpga_async_fifo #(
    .ADDR_WD (9),
    .DATA_WD (576) ) u_mdata_cap_ff 
  (
    .rstn                         (mdata_cap_ff_rst_n),
    .data                         (mdata_cap_ff_wdata),
    .rdclk                        (mdata_cap_ff_rdclk),
    .rdreq                        (mdata_cap_ff_rden),
    .wrclk                        (mdata_cap_ff_wrclk),
    .wrreq                        (mdata_cap_ff_wren),
    .q                            (mdata_cap_ff_rdata),
    .rdempty                      (mdata_cap_ff_empty),
    .rdusedw                      (mdata_cap_ff_rdused),
    .wrfull                       (mdata_cap_ff_full),
    .wrusedw                      (mdata_cap_ff_wrused)
  );

  assign  mdata_cap_ff_wdata   = {{(DATA_CAP_FF_DATA_W-MDATA_CAP_RECORD_W){1'b0}},mdata_filt_data,cap_rec_id[2]};
  assign  mdata_cap_ff_wren    = mdata_filt_data_valid;
  assign  mdata_filt_bp        = mdata_cap_ff_full;

  /* filter instance for tdata  */
  IW_fpga_generic_filt #(
   .DATA_WIDTH  (TDATA_JEM_CAP_RECORD_W),
   .USE_FLOP    (0)
  ) IW_fpga_generic_filt_tdata (
    .clk                  (clk_logic),
    .rst_n                (rst_logic_n),

    //jem tracker signals
    .mon_data             (data_tdata),
    .mon_data_valid       (data_tdata_valid),

    //csr signals
    .enable               (mon_enable),
    .match_mask           (tdata_mask_en),
    .match_data           (tdata_mask_value),

    //fifo interface
    .filt_data            (tdata_filt_data),
    .filt_data_valid      (tdata_filt_data_valid),
    .filt_bp              (tdata_filt_bp)
  );

  assign  tdata_cap_ff_wdata   = {{(DATA_CAP_FF_DATA_W-TDATA_CAP_RECORD_W){1'b0}},tdata_filt_data,cap_rec_id[3]};
  assign  tdata_cap_ff_wren    = tdata_filt_data_valid;
  assign  tdata_filt_bp        = tdata_cap_ff_full;


  /*  tdata channel capture fifo */
  //IW_fpga_iosf_p_mon_ff_576x512  u_tdata_cap_ff
  IW_fpga_async_fifo #(
    .ADDR_WD (9),
    .DATA_WD (576) ) u_tdata_cap_ff 
  (
    .rstn                         (tdata_cap_ff_rst_n),
    .data                         (tdata_cap_ff_wdata),
    .rdclk                        (tdata_cap_ff_rdclk),
    .rdreq                        (tdata_cap_ff_rden),
    .wrclk                        (tdata_cap_ff_wrclk),
    .wrreq                        (tdata_cap_ff_wren),
    .q                            (tdata_cap_ff_rdata),
    .rdempty                      (tdata_cap_ff_empty),
    .rdusedw                      (tdata_cap_ff_rdused),
    .wrfull                       (tdata_cap_ff_full),
    .wrusedw                      (tdata_cap_ff_wrused)
  );

  //Switch connections between standalone & avl modes
  generate
    if(MODE ==  "avl")
    begin
      IW_fpga_jem_record_mngr #(
         .NUM_CHANNELS        (NUM_CAP_INTFS)
        ,.RECORD_ID_WIDTH     (RECORD_ID_WIDTH)

      ) u_IW_fpga_jem_record_mngr (

         .clk_ingr            (clk_logic)
        ,.rst_ingr_n          (rst_logic_n)
        ,.egr_ordering_en     (rec_ordering_en)
        ,.chnnl_ingr_wren     ({tdata_cap_ff_wren,mdata_cap_ff_wren,treq_cap_ff_wren,mreq_cap_ff_wren})
        ,.chnnl_ingr_rec_id   (cap_rec_id)

        ,.clk_egr             (clk_csr)
        ,.rst_egr_n           (rst_csr_n)
        ,.chnnl_egr_empty     ({tdata_cap_ff_empty,mdata_cap_ff_empty,treq_cap_ff_empty,mreq_cap_ff_empty})
        ,.chnnl_egr_rec_id    ('{tdata_cap_ff_rdata[RECORD_ID_WIDTH-1:0],mdata_cap_ff_rdata[RECORD_ID_WIDTH-1:0],treq_cap_ff_rdata[RECORD_ID_WIDTH-1:0],mreq_cap_ff_rdata[RECORD_ID_WIDTH-1:0]})
        ,.chnnl_egr_valid     (chnnl_egr_valid)
        ,.chnnl_egr_valid_bin (chnnl_egr_valid_bin)
        ,.chnnl_egr_rden      ({tdata_cap_ff_rden,mdata_cap_ff_rden,treq_cap_ff_rden,mreq_cap_ff_rden})

      );


      //CAP FF Read ports are accessed by external SBE; CSR equivalent ports & tied off
      assign  mreq_cap_ff_wrclk   = clk_logic;
      assign  mreq_cap_ff_rdclk   = clk_csr;
      assign  mreq_cap_ff_rst_n   = rst_logic_n & ~flush_cap_ff;

      assign  treq_cap_ff_wrclk   = clk_logic;
      assign  treq_cap_ff_rdclk   = clk_csr;
      assign  treq_cap_ff_rst_n   = rst_logic_n & ~flush_cap_ff;

      assign  mdata_cap_ff_wrclk  = clk_logic;
      assign  mdata_cap_ff_rdclk  = clk_csr;
      assign  mdata_cap_ff_rst_n  = rst_logic_n & ~flush_cap_ff;

      assign  tdata_cap_ff_wrclk  = clk_logic;
      assign  tdata_cap_ff_rdclk  = clk_csr;
      assign  tdata_cap_ff_rst_n  = rst_logic_n & ~flush_cap_ff;

      assign  treq_chnnl_cap_rdata_valid   = chnnl_egr_valid[1];
      assign  treq_chnnl_cap_rdata         = treq_cap_ff_rdata;
      assign  treq_cap_ff_rden             = chnnl_egr_valid[1] & cap_rden;

      assign  mreq_chnnl_cap_rdata_valid   = chnnl_egr_valid[0];
      assign  mreq_chnnl_cap_rdata         = mreq_cap_ff_rdata;
      assign  mreq_cap_ff_rden             = chnnl_egr_valid[0] & cap_rden;

      assign  tdata_chnnl_cap_rdata_valid  = chnnl_egr_valid[3];
      assign  tdata_chnnl_cap_rdata        = tdata_cap_ff_rdata;
      assign  tdata_cap_ff_rden            = chnnl_egr_valid[3] & cap_rden;

      assign  mdata_chnnl_cap_rdata_valid  = chnnl_egr_valid[2];
      assign  mdata_chnnl_cap_rdata        = mdata_cap_ff_rdata;
      assign  mdata_cap_ff_rden            = chnnl_egr_valid[2] & cap_rden;

      assign  csr_treq_cap_rdata_valid     = 1'b0;
      assign  csr_treq_cap_rdata           = {REQ_CAP_FF_DATA_W{1'b0}};
      assign  csr_treq_cap_rdused          = {CAP_FF_USED_W{1'b0}};

      assign  csr_mreq_cap_rdata_valid     = 1'b0;
      assign  csr_mreq_cap_rdata           = {REQ_CAP_FF_DATA_W{1'b0}};
      assign  csr_mreq_cap_rdused          = {CAP_FF_USED_W{1'b0}};

      assign  csr_tdata_cap_rdata_valid    = 1'b0;
      assign  csr_tdata_cap_rdata          = {DATA_CAP_FF_DATA_W{1'b0}};
      assign  csr_tdata_cap_rdused         = {CAP_FF_USED_W{1'b0}};

      assign  csr_mdata_cap_rdata_valid    = 1'b0;
      assign  csr_mdata_cap_rdata          = {DATA_CAP_FF_DATA_W{1'b0}};
      assign  csr_mdata_cap_rdused         = {CAP_FF_USED_W{1'b0}};
    end
    else  //MODE  ==  "standalone"
    begin
      IW_fpga_jem_record_mngr #(
         .NUM_CHANNELS        (NUM_CAP_INTFS)
        ,.RECORD_ID_WIDTH     (RECORD_ID_WIDTH)

      ) u_IW_fpga_jem_record_mngr (

         .clk_ingr            (clk_logic)
        ,.rst_ingr_n          (rst_logic_n)
        ,.egr_ordering_en     (rec_ordering_en)
        ,.chnnl_ingr_wren     ({tdata_cap_ff_wren,mdata_cap_ff_wren,treq_cap_ff_wren,mreq_cap_ff_wren})
        ,.chnnl_ingr_rec_id   (cap_rec_id)

        ,.clk_egr             (clk_csr)
        ,.rst_egr_n           (rst_csr_n)
        ,.chnnl_egr_empty     ({tdata_cap_ff_empty,mdata_cap_ff_empty,treq_cap_ff_empty,mreq_cap_ff_empty})
        ,.chnnl_egr_rec_id    ('{tdata_cap_ff_rdata[RECORD_ID_WIDTH-1:0],mdata_cap_ff_rdata[RECORD_ID_WIDTH-1:0],treq_cap_ff_rdata[RECORD_ID_WIDTH-1:0],mreq_cap_ff_rdata[RECORD_ID_WIDTH-1:0]})
        ,.chnnl_egr_valid     (chnnl_egr_valid)
        ,.chnnl_egr_rden      ({tdata_cap_ff_rden,mdata_cap_ff_rden,treq_cap_ff_rden,mreq_cap_ff_rden})

      );


      //CAP FF Read ports are accessed by CSR; SBE equivalent ports are tied off
      assign  mreq_cap_ff_wrclk   = clk_logic;
      assign  mreq_cap_ff_rdclk   = clk_logic;
      assign  mreq_cap_ff_rst_n   = rst_logic_n & ~flush_cap_ff;

      assign  treq_cap_ff_wrclk   = clk_logic;
      assign  treq_cap_ff_rdclk   = clk_logic;
      assign  treq_cap_ff_rst_n   = rst_logic_n & ~flush_cap_ff;

      assign  mdata_cap_ff_wrclk  = clk_logic;
      assign  mdata_cap_ff_rdclk  = clk_logic;
      assign  mdata_cap_ff_rst_n  = rst_logic_n & ~flush_cap_ff;

      assign  tdata_cap_ff_wrclk  = clk_logic;
      assign  tdata_cap_ff_rdclk  = clk_logic;
      assign  tdata_cap_ff_rst_n  = rst_logic_n & ~flush_cap_ff;

      assign  csr_treq_cap_rdata_valid     = chnnl_egr_valid[1];
      assign  csr_treq_cap_rdata           = treq_cap_ff_rdata;
      assign  csr_treq_cap_rdused          = treq_cap_ff_rdused;
      assign  treq_cap_ff_rden             = csr_treq_cap_rden;

      assign  csr_mreq_cap_rdata_valid     = chnnl_egr_valid[0];
      assign  csr_mreq_cap_rdata           = mreq_cap_ff_rdata;
      assign  csr_mreq_cap_rdused          = mreq_cap_ff_rdused;
      assign  mreq_cap_ff_rden             = csr_mreq_cap_rden;

      assign  csr_tdata_cap_rdata_valid    = chnnl_egr_valid[3];
      assign  csr_tdata_cap_rdata          = tdata_cap_ff_rdata;
      assign  csr_tdata_cap_rdused         = tdata_cap_ff_rdused;
      assign  tdata_cap_ff_rden            = csr_tdata_cap_rden;

      assign  csr_mdata_cap_rdata_valid    = chnnl_egr_valid[2];
      assign  csr_mdata_cap_rdata          = mdata_cap_ff_rdata;
      assign  csr_mdata_cap_rdused         = mdata_cap_ff_rdused;
      assign  mdata_cap_ff_rden            = csr_mdata_cap_rden;

      assign  treq_chnnl_cap_rdata_valid   = 1'b0;
      assign  treq_chnnl_cap_rdata         = {REQ_CAP_FF_DATA_W{1'b0}};

      assign  mreq_chnnl_cap_rdata_valid   = 1'b0;
      assign  mreq_chnnl_cap_rdata         = {REQ_CAP_FF_DATA_W{1'b0}};

      assign  tdata_chnnl_cap_rdata_valid  = 1'b0;
      assign  tdata_chnnl_cap_rdata        = {DATA_CAP_FF_DATA_W{1'b0}};

      assign  mdata_chnnl_cap_rdata_valid  = 1'b0;
      assign  mdata_chnnl_cap_rdata        = {DATA_CAP_FF_DATA_W{1'b0}};

    end
  endgenerate
endmodule
