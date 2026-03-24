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


`timescale  1ns/1ps

`include  "iosf_p_jem_tracker.vh"

module  IW_fpga_iosf_p_mon_addr_map_avmm_wrapper #(
    parameter MON_TYPE            = "prim"              //Should be either pmsb or gpsb
  , parameter INSTANCE_NAME       = "u_iosf_p_mon"      //Can hold upto 16 ASCII characters
  , parameter MODE                = "standalone"        //Either 'standalone' or 'avl' mode
  , parameter REQ_CAP_FF_DATA_W   = 35
  , parameter DATA_CAP_FF_DATA_W  = 35
  , parameter CAP_FF_DEPTH        = 10
  , parameter CAP_FF_USED_W       = 8

  , parameter    MAX_DATA_LEN          =  9   // Maximum Data Length on primary interface, >= 4
  , parameter    MMAX_ADDR             = 31   // Maximum Address width on primary master interface
  , parameter    AGENT_WIDTH           =  0   // Agent width
  , parameter    MNUMCHAN              =  0   // Master interface num of channels
  , parameter    MNUMCHANL2            =  0   // Num of channels log2               
  , parameter    MD_WIDTH              = 31   // Data Width on primary master interface
  , parameter    MDP_WIDTH             =  0   // Master data parity
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
  , parameter    TDP_WIDTH             =  0   // Target data parity

  /*  Do Not Modify */
  , parameter AV_MM_DATA_W          = 32
  , parameter AV_MM_ADDR_W          = 16
  , parameter READ_MISS_VAL         = 32'hDEADBABE   // Read miss value

) (

    input  wire [AV_MM_ADDR_W-1:0]     avl_mm_address,          // avl_mm.address
    output reg  [AV_MM_DATA_W-1:0]     avl_mm_readdata,         //       .readdata
    input  wire                        avl_mm_read,             //       .read
    output reg                         avl_mm_readdatavalid,    //       .readdatavalid
    input  wire                        avl_mm_write,            //       .write
    input  wire [AV_MM_DATA_W-1:0]     avl_mm_writedata,        //       .writedata
    input  wire [(AV_MM_DATA_W/8)-1:0] avl_mm_byteenable,       //       .byteenable
    output wire                        avl_mm_waitrequest,      //       .waitrequest
    input  wire                        csi_clk,                 // csi.clk
    input  wire                        rsi_reset                // rsi.reset

  , input   logic                      clk_logic

  /*  This interface to CAP FF Read port will be used only in standalone mode */
  , input   logic                           treq_cap_rdata_valid
  , input   logic [REQ_CAP_FF_DATA_W-1:0]   treq_cap_rdata
  , input   logic [CAP_FF_USED_W-1:0]       treq_cap_rdused
  , output  logic                           treq_cap_rden

  , input   logic                           mreq_cap_rdata_valid
  , input   logic [REQ_CAP_FF_DATA_W-1:0]   mreq_cap_rdata
  , input   logic [CAP_FF_USED_W-1:0]       mreq_cap_rdused
  , output  logic                           mreq_cap_rden

  , input   logic                           tdata_cap_rdata_valid
  , input   logic [DATA_CAP_FF_DATA_W-1:0]  tdata_cap_rdata
  , input   logic [CAP_FF_USED_W-1:0]       tdata_cap_rdused
  , output  logic                           tdata_cap_rden

  , input   logic                           mdata_cap_rdata_valid
  , input   logic [DATA_CAP_FF_DATA_W-1:0]  mdata_cap_rdata
  , input   logic [CAP_FF_USED_W-1:0]       mdata_cap_rdused
  , output  logic                           mdata_cap_rden

  //----------------------------------------------------------------------------------
  // Ingress IOSF Consumer-Monitor Interface
  //----------------------------------------------------------------------------------
  , input     [2:0]                    iosf_mon_PRIM_ISM_AGENT  // Agent ISM 
  //, input                              iosf_mon_clk_PRIM_CLK    // Primary Interface Clock
  //, input                              iosf_mon_rst_PRIM_RST_B  // Primary Interface Reset
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
  , input     [((MD_WIDTH+1)/8)-1:0]   iosf_mon_MDBE             // Master Data byte enables

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
  , input     [((TD_WIDTH+1)/8)-1:0]   iosf_mon_TDBE             // Target Data byte enable
  , input     [TDP_WIDTH:0]            iosf_mon_TDPARITY
 

  /*  Statistics  */
  , input   logic  [31:0]               num_mreq_pkts
  , input   logic  [31:0]               num_mreq_beats
  , input   logic  [31:0]               num_treq_pkts
  , input   logic  [31:0]               num_treq_beats
  , input   logic  [31:0]               num_mdata_pkts
  , input   logic  [31:0]               num_mdata_beats
  , input   logic  [31:0]               num_tdata_pkts
  , input   logic  [31:0]               num_tdata_beats
  , input   logic  [31:0]               num_dropped_pkts

  /*  CSR Registers */
  , output  logic                       mon_enable
  , output  logic                       clr_stats
  , output  logic                       flush_cap_ff
  , output  logic                       rec_ordering_en
  , output  t_iosf_p_jem_mreq           mreq_mask_value
  , output  t_iosf_p_jem_treq           treq_mask_value
  , output  t_iosf_p_jem_mdata          mdata_mask_value
  , output  t_iosf_p_jem_tdata          tdata_mask_value
  , output  t_iosf_p_jem_mreq           mreq_mask_en
  , output  t_iosf_p_jem_treq           treq_mask_en
  , output  t_iosf_p_jem_mdata          mdata_mask_en
  , output  t_iosf_p_jem_tdata          tdata_mask_en


);

  import IW_fpga_iosf_p_mon_av_addr_map_pkg::*;
  //import rtlgen_pkg_v12::*;
  import rtlgen_pkg_IW_fpga_iosf_p_mon_av_addr_map::*;

  /*  Internal Parameters */
  localparam  INTERNAL_ADDR_W   = 8;
  localparam  MAX_ADDR          = 'hBC;
  localparam  REQ_DATA_W        = 1+AV_MM_ADDR_W+AV_MM_DATA_W+(AV_MM_DATA_W/8);

  localparam  RSP_DATA_W        = AV_MM_DATA_W;

  localparam  REQ_FF_W          = (REQ_DATA_W <=  32) ? 32  :
                                  (REQ_DATA_W <=  64) ? 64  :
                                  (REQ_DATA_W <=  96) ? 96  : 1;

  localparam  RSP_FF_W          = (RSP_DATA_W <=  32) ? 32  :
                                  (RSP_DATA_W <=  64) ? 64  :
                                  (RSP_DATA_W <=  96) ? 96  : 1;

  localparam  REQ_CAP_SLICE_RESIDUE = (REQ_CAP_FF_DATA_W  % AV_MM_DATA_W);
  localparam  REQ_NUM_SLICES_PER_CAP= (REQ_CAP_SLICE_RESIDUE  > 0)  ? (REQ_CAP_FF_DATA_W  / AV_MM_DATA_W) + 1
                                                            : (REQ_CAP_FF_DATA_W  / AV_MM_DATA_W);

  localparam  DATA_CAP_SLICE_RESIDUE = (DATA_CAP_FF_DATA_W  % AV_MM_DATA_W);
  localparam  DATA_NUM_SLICES_PER_CAP= (DATA_CAP_SLICE_RESIDUE  > 0)  ? (DATA_CAP_FF_DATA_W  / AV_MM_DATA_W) + 1
                                                            : (DATA_CAP_FF_DATA_W  / AV_MM_DATA_W);


  /*  Internal Signals  */
  genvar  i;
  integer n;
  reg   [0:3] [7:0] sbr_type_str  = MON_TYPE;
  reg   [0:15][7:0] inst_name_str = INSTANCE_NAME;

  wire                        req_ff_full;
  wire                        req_ff_wren;
  wire  [REQ_FF_W-1:0]        req_ff_wdata;
  wire                        req_ff_empty;
  wire                        req_ff_rden;
  wire  [REQ_FF_W-1:0]        req_ff_rdata;

  wire                        rsp_ff_full;
  wire                        rsp_ff_wren;
  wire  [RSP_FF_W-1:0]        rsp_ff_wdata;
  wire                        rsp_ff_empty;
  wire                        rsp_ff_rden;
  wire  [RSP_FF_W-1:0]        rsp_ff_rdata;

  wire                        csr2logic_wren;
  wire                        csr2logic_rden;
  wire  [AV_MM_ADDR_W-1:0]    csr2logic_addr;
  wire  [AV_MM_DATA_W-1:0]    csr2logic_wdata;
  wire  [(AV_MM_DATA_W/8)-1:0] csr2logic_be;
  reg                         logic2csr_rdata_valid;
  reg   [AV_MM_DATA_W-1:0]    logic2csr_rdata;

  wire  [AV_MM_DATA_W-1:0]      treq_cap_rdata_slices [REQ_NUM_SLICES_PER_CAP-1:0];
  wire  [AV_MM_DATA_W-1:0]      mreq_cap_rdata_slices [REQ_NUM_SLICES_PER_CAP-1:0];
  wire  [AV_MM_DATA_W-1:0]      treq_cap_fifo_status_reg;
  wire  [AV_MM_DATA_W-1:0]      treq_cap_fifo_cntrl_reg;
  wire  [AV_MM_DATA_W-1:0]      treq_cap_fifo_rdata_reg;
  wire  [AV_MM_DATA_W-1:0]      mreq_cap_fifo_status_reg;
  wire  [AV_MM_DATA_W-1:0]      mreq_cap_fifo_cntrl_reg;
  wire  [AV_MM_DATA_W-1:0]      mreq_cap_fifo_rdata_reg;

  wire  [AV_MM_DATA_W-1:0]      tdata_cap_rdata_slices [DATA_NUM_SLICES_PER_CAP-1:0];
  wire  [AV_MM_DATA_W-1:0]      mdata_cap_rdata_slices [DATA_NUM_SLICES_PER_CAP-1:0];
  wire  [AV_MM_DATA_W-1:0]      tdata_cap_fifo_status_reg;
  wire  [AV_MM_DATA_W-1:0]      tdata_cap_fifo_cntrl_reg;
  wire  [AV_MM_DATA_W-1:0]      tdata_cap_fifo_rdata_reg;
  wire  [AV_MM_DATA_W-1:0]      mdata_cap_fifo_status_reg;
  wire  [AV_MM_DATA_W-1:0]      mdata_cap_fifo_cntrl_reg;
  wire  [AV_MM_DATA_W-1:0]      mdata_cap_fifo_rdata_reg;
  wire                          rst_logic_n;


  reg                         mreq_mask_en_fmt    ;
  reg                         mreq_mask_en_type   ;
  reg                         mreq_mask_en_tc     ;
  reg                         mreq_mask_en_length ;
  reg                         mreq_mask_en_reqid  ;
  reg                         mreq_mask_en_lbe    ;
  reg                         mreq_mask_en_fbe    ;
  reg                         mreq_mask_en_sai    ;
  reg                         mreq_mask_en_addr   ;
  reg                         mreq_mask_en_srcid  ;
  reg                         mreq_mask_en_dstid  ;
  reg                         mreq_mask_en_mtag   ;
  reg                         treq_mask_en_fmt    ;
  reg                         treq_mask_en_type   ;
  reg                         treq_mask_en_tc     ;
  reg                         treq_mask_en_length ;
  reg                         treq_mask_en_reqid  ;
  reg                         treq_mask_en_lbe    ;
  reg                         treq_mask_en_fbe    ;
  reg                         treq_mask_en_sai    ;
  reg                         treq_mask_en_addr   ;
  reg                         treq_mask_en_srcid  ;
  reg                         treq_mask_en_dstid  ;
  reg                         treq_mask_en_ttag   ;
  reg                         tdata_mask_en_data  ;
  reg                         mdata_mask_en_data  ;
  reg [15:0]                  treq_cap_rdata_slice_idx;
  reg [15:0]                  mreq_cap_rdata_slice_idx;
  reg [15:0]                  tdata_cap_rdata_slice_idx;
  reg [15:0]                  mdata_cap_rdata_slice_idx;

// Register module ports
 new_bus_status_reg_cr_t                       new_bus_status_reg_cr;
 new_inst_name0_reg_cr_t                       new_inst_name0_reg_cr;
 new_inst_name1_reg_cr_t                       new_inst_name1_reg_cr;
 new_inst_name2_reg_cr_t                       new_inst_name2_reg_cr;
 new_inst_name3_reg_cr_t                       new_inst_name3_reg_cr;
 new_mon_type_reg_cr_t                         new_mon_type_reg_cr;
 new_params0_reg_cr_t                          new_params0_reg_cr;
 new_params1_reg_cr_t                          new_params1_reg_cr;
 new_mdata_cap_fifo_rdata_reg_cr_t             new_mdata_cap_fifo_rdata_reg_cr;
 new_mdata_cap_fifo_status_reg_cr_t            new_mdata_cap_fifo_status_reg_cr;
 new_mreq_cap_fifo_rdata_reg_cr_t              new_mreq_cap_fifo_rdata_reg_cr;
 new_mreq_cap_fifo_status_reg_cr_t             new_mreq_cap_fifo_status_reg_cr;
 new_num_dropped_pkts_cnt_reg_cr_t             new_num_dropped_pkts_cnt_reg_cr;
 new_num_mdata_beats_cnt_reg_cr_t              new_num_mdata_beats_cnt_reg_cr;
 new_num_mdata_pkts_cnt_reg_cr_t               new_num_mdata_pkts_cnt_reg_cr;
 new_num_mreq_beats_cnt_reg_cr_t               new_num_mreq_beats_cnt_reg_cr;
 new_num_mreq_pkts_cnt_reg_cr_t                new_num_mreq_pkts_cnt_reg_cr;
 new_num_tdata_beats_cnt_reg_cr_t              new_num_tdata_beats_cnt_reg_cr;
 new_num_tdata_pkts_cnt_reg_cr_t               new_num_tdata_pkts_cnt_reg_cr;
 new_num_treq_beats_cnt_reg_cr_t               new_num_treq_beats_cnt_reg_cr;
 new_num_treq_pkts_cnt_reg_cr_t                new_num_treq_pkts_cnt_reg_cr;
 new_tdata_cap_fifo_rdata_reg_cr_t             new_tdata_cap_fifo_rdata_reg_cr;
 new_tdata_cap_fifo_status_reg_cr_t            new_tdata_cap_fifo_status_reg_cr;
 new_treq_cap_fifo_rdata_reg_cr_t              new_treq_cap_fifo_rdata_reg_cr;
 new_treq_cap_fifo_status_reg_cr_t             new_treq_cap_fifo_status_reg_cr;

 handcode_rdata_mdata_cap_fifo_cntrl_reg_cr_t  handcode_rdata_mdata_cap_fifo_cntrl_reg_cr;
 handcode_rdata_mreq_cap_fifo_cntrl_reg_cr_t   handcode_rdata_mreq_cap_fifo_cntrl_reg_cr;
 handcode_rdata_tdata_cap_fifo_cntrl_reg_cr_t  handcode_rdata_tdata_cap_fifo_cntrl_reg_cr;
 handcode_rdata_treq_cap_fifo_cntrl_reg_cr_t   handcode_rdata_treq_cap_fifo_cntrl_reg_cr;

 bus_status_reg_cr_t                           bus_status_reg_cr;
 cntrl_reg_cr_t                                cntrl_reg_cr;
 inst_name0_reg_cr_t                           inst_name0_reg_cr;
 inst_name1_reg_cr_t                           inst_name1_reg_cr;
 inst_name2_reg_cr_t                           inst_name2_reg_cr;
 inst_name3_reg_cr_t                           inst_name3_reg_cr;
 mask_cntrl_mdata_reg_cr_t                     mask_cntrl_mdata_reg_cr;
 mask_cntrl_mreq_reg_cr_t                      mask_cntrl_mreq_reg_cr;
 mask_cntrl_tdata_reg_cr_t                     mask_cntrl_tdata_reg_cr;
 mask_cntrl_treq_reg_cr_t                      mask_cntrl_treq_reg_cr;
 mask_value_mdata0_reg_cr_t                    mask_value_mdata0_reg_cr;
 mask_value_mreq0_reg_cr_t                     mask_value_mreq0_reg_cr;
 mask_value_mreq1_reg_cr_t                     mask_value_mreq1_reg_cr;
 mask_value_mreq2_reg_cr_t                     mask_value_mreq2_reg_cr;
 mask_value_mreq3_reg_cr_t                     mask_value_mreq3_reg_cr;
 mask_value_mreq4_reg_cr_t                     mask_value_mreq4_reg_cr;
 mask_value_mreq5_reg_cr_t                     mask_value_mreq5_reg_cr;
 mask_value_tdata0_reg_cr_t                    mask_value_tdata0_reg_cr;
 mask_value_treq0_reg_cr_t                     mask_value_treq0_reg_cr;
 mask_value_treq1_reg_cr_t                     mask_value_treq1_reg_cr;
 mask_value_treq2_reg_cr_t                     mask_value_treq2_reg_cr;
 mask_value_treq3_reg_cr_t                     mask_value_treq3_reg_cr;
 mask_value_treq4_reg_cr_t                     mask_value_treq4_reg_cr;
 mask_value_treq5_reg_cr_t                     mask_value_treq5_reg_cr;
 mdata_cap_fifo_cntrl_reg_cr_t                 mdata_cap_fifo_cntrl_reg_cr;
 mdata_cap_fifo_rdata_reg_cr_t                 mdata_cap_fifo_rdata_reg_cr;
 mdata_cap_fifo_status_reg_cr_t                mdata_cap_fifo_status_reg_cr;
 mon_type_reg_cr_t                             mon_type_reg_cr;
 mreq_cap_fifo_cntrl_reg_cr_t                  mreq_cap_fifo_cntrl_reg_cr;
 mreq_cap_fifo_rdata_reg_cr_t                  mreq_cap_fifo_rdata_reg_cr;
 mreq_cap_fifo_status_reg_cr_t                 mreq_cap_fifo_status_reg_cr;
 num_dropped_pkts_cnt_reg_cr_t                 num_dropped_pkts_cnt_reg_cr;
 num_mdata_beats_cnt_reg_cr_t                  num_mdata_beats_cnt_reg_cr;
 num_mdata_pkts_cnt_reg_cr_t                   num_mdata_pkts_cnt_reg_cr;
 num_mreq_beats_cnt_reg_cr_t                   num_mreq_beats_cnt_reg_cr;
 num_mreq_pkts_cnt_reg_cr_t                    num_mreq_pkts_cnt_reg_cr;
 num_tdata_beats_cnt_reg_cr_t                  num_tdata_beats_cnt_reg_cr;
 num_tdata_pkts_cnt_reg_cr_t                   num_tdata_pkts_cnt_reg_cr;
 num_treq_beats_cnt_reg_cr_t                   num_treq_beats_cnt_reg_cr;
 num_treq_pkts_cnt_reg_cr_t                    num_treq_pkts_cnt_reg_cr;
 params0_reg_cr_t                              params0_reg_cr;
 params1_reg_cr_t                              params1_reg_cr;
 tdata_cap_fifo_cntrl_reg_cr_t                 tdata_cap_fifo_cntrl_reg_cr;
 tdata_cap_fifo_rdata_reg_cr_t                 tdata_cap_fifo_rdata_reg_cr;
 tdata_cap_fifo_status_reg_cr_t                tdata_cap_fifo_status_reg_cr;
 treq_cap_fifo_cntrl_reg_cr_t                  treq_cap_fifo_cntrl_reg_cr;
 treq_cap_fifo_rdata_reg_cr_t                  treq_cap_fifo_rdata_reg_cr;
 treq_cap_fifo_status_reg_cr_t                 treq_cap_fifo_status_reg_cr;

 handcode_wdata_mdata_cap_fifo_cntrl_reg_cr_t  handcode_wdata_mdata_cap_fifo_cntrl_reg_cr;
 handcode_wdata_mreq_cap_fifo_cntrl_reg_cr_t   handcode_wdata_mreq_cap_fifo_cntrl_reg_cr;
 handcode_wdata_tdata_cap_fifo_cntrl_reg_cr_t  handcode_wdata_tdata_cap_fifo_cntrl_reg_cr;
 handcode_wdata_treq_cap_fifo_cntrl_reg_cr_t   handcode_wdata_treq_cap_fifo_cntrl_reg_cr;
 
 we_mdata_cap_fifo_cntrl_reg_cr_t              we_mdata_cap_fifo_cntrl_reg_cr;
 we_mreq_cap_fifo_cntrl_reg_cr_t               we_mreq_cap_fifo_cntrl_reg_cr;
 we_tdata_cap_fifo_cntrl_reg_cr_t              we_tdata_cap_fifo_cntrl_reg_cr;
 we_treq_cap_fifo_cntrl_reg_cr_t               we_treq_cap_fifo_cntrl_reg_cr;
 
 IW_fpga_iosf_p_mon_av_addr_map_cr_req_t       req;
 IW_fpga_iosf_p_mon_av_addr_map_cr_ack_t       ack;

  /*  Pack/Unpack req & rsp signals based on mode  */
  assign  req_ff_wdata  = {  {(REQ_FF_W-REQ_DATA_W){1'b0}}
                            ,avl_mm_byteenable
                            ,avl_mm_writedata
                            ,avl_mm_address
                            ,(avl_mm_read & ~avl_mm_write)
                          };
  assign  req_ff_wren   = avl_mm_read | avl_mm_write;

  assign  {
           avl_mm_readdata 
          } = rsp_ff_rdata[RSP_DATA_W-1:0];

  assign  rsp_ff_rden          = ~rsp_ff_empty;
  assign  avl_mm_readdatavalid = ~rsp_ff_empty;


  assign  {
             csr2logic_be
            ,csr2logic_wdata
            ,csr2logic_addr
          } = req_ff_rdata[REQ_DATA_W-1:1];
  assign  csr2logic_wren  = ~req_ff_empty & ~req_ff_rdata[0];
  assign  csr2logic_rden  = ~req_ff_empty &  req_ff_rdata[0];

  assign  rsp_ff_wdata[RSP_DATA_W-1:0]  = {
                                            logic2csr_rdata
                                          };
  assign  rsp_ff_wren = logic2csr_rdata_valid;

/*  Instantiate Request Fifo  */
 IW_fpga_async_fifo #(
   .ADDR_WD (9),
   .DATA_WD (REQ_FF_W) ) u_req_ff 
 (
   .rstn                         (rst_logic_n),
   .data                         (req_ff_wdata),
   .rdclk                        (clk_logic),
   .rdreq                        (req_ff_rden),
   .wrclk                        (csi_clk),
   .wrreq                        (req_ff_wren),
   .q                            (req_ff_rdata),
   .rdempty                      (req_ff_empty),
   .rdusedw                      (),
   .wrfull                       (req_ff_full),
   .wrusedw                      ()
 );

/*  Instantiate Response Fifo  */
  IW_fpga_async_fifo #(
    .ADDR_WD (9),
    .DATA_WD (RSP_FF_W) ) u_rsp_ff
  (
    .rstn                         (rst_logic_n),
    .data                         (rsp_ff_wdata),
    .rdclk                        (csi_clk),
    .rdreq                        (rsp_ff_rden),
    .wrclk                        (clk_logic),
    .wrreq                        (rsp_ff_wren),
    .q                            (rsp_ff_rdata),
    .rdempty                      (rsp_ff_empty),
    .rdusedw                      (),
    .wrfull                       (rsp_ff_full),
    .wrusedw                      ()
  );

  assign  req_ff_rden = ~rsp_ff_full & ~req_ff_empty;


  //Generate Mask Enables
  assign  mreq_mask_en.dir             =  1'b0;
  assign  mreq_mask_en.cmd_mfmt        =  {$bits(mreq_mask_en.cmd_mfmt   )      {mreq_mask_en_fmt   }};
  assign  mreq_mask_en.cmd_mtype       =  {$bits(mreq_mask_en.cmd_mtype  )      {mreq_mask_en_type  }};
  assign  mreq_mask_en.cmd_mtc         =  {$bits(mreq_mask_en.cmd_mtc    )      {mreq_mask_en_tc    }};
  assign  mreq_mask_en.cmd_mlength     =  {$bits(mreq_mask_en.cmd_mlength)      {mreq_mask_en_length}};
  assign  mreq_mask_en.cmd_mreqid      =  {$bits(mreq_mask_en.cmd_mreqid )      {mreq_mask_en_reqid }};
  assign  mreq_mask_en.cmd_mlbe        =  {$bits(mreq_mask_en.cmd_mlbe   )      {mreq_mask_en_lbe   }};
  assign  mreq_mask_en.cmd_mfbe        =  {$bits(mreq_mask_en.cmd_mfbe   )      {mreq_mask_en_fbe   }};
  assign  mreq_mask_en.cmd_msai        =  {$bits(mreq_mask_en.cmd_msai   )      {mreq_mask_en_sai   }};
  assign  mreq_mask_en.cmd_maddr       =  {$bits(mreq_mask_en.cmd_maddr  )      {mreq_mask_en_addr  }};
  assign  mreq_mask_en.cmd_msrcid      =  {$bits(mreq_mask_en.cmd_msrcid )      {mreq_mask_en_srcid }};
  assign  mreq_mask_en.cmd_mdestid     =  {$bits(mreq_mask_en.cmd_mdestid)      {mreq_mask_en_dstid }};
  assign  mreq_mask_en.cmd_mtag        =  {$bits(mreq_mask_en.cmd_mtag   )      {mreq_mask_en_mtag }};
  assign  mreq_mask_en.cmd_mrs         =  0;
  assign  mreq_mask_en.cmd_mep         =  0;
  assign  mreq_mask_en.cmd_mido        =  0;
  assign  mreq_mask_en.cmd_mns         =  0;
  assign  mreq_mask_en.cmd_mro         =  0;
  assign  mreq_mask_en.gnt_rtype       =  0;
  assign  mreq_mask_en.gnt_chid        =  0;
  assign  mreq_mask_en.mstr_reqid      =  0;


  assign  treq_mask_en.dir             =  0;
  assign  treq_mask_en.cmd_tput        =  0;
  assign  treq_mask_en.cmd_tchid       =  0;
  assign  treq_mask_en.cmd_trtype      =  0;
  assign  treq_mask_en.cmd_tfmt        =  {$bits(treq_mask_en.cmd_tfmt   )      {treq_mask_en_fmt   }};
  assign  treq_mask_en.cmd_ttype       =  {$bits(treq_mask_en.cmd_ttype  )      {treq_mask_en_type  }};
  assign  treq_mask_en.cmd_ttc         =  {$bits(treq_mask_en.cmd_ttc    )      {treq_mask_en_tc    }};
  assign  treq_mask_en.cmd_tlength     =  {$bits(treq_mask_en.cmd_tlength)      {treq_mask_en_length}};
  assign  treq_mask_en.cmd_treqid      =  {$bits(treq_mask_en.cmd_treqid )      {treq_mask_en_reqid }};
  assign  treq_mask_en.cmd_tlbe        =  {$bits(treq_mask_en.cmd_tlbe   )      {treq_mask_en_lbe   }};
  assign  treq_mask_en.cmd_tfbe        =  {$bits(treq_mask_en.cmd_tfbe   )      {treq_mask_en_fbe   }};
  assign  treq_mask_en.cmd_tsai        =  {$bits(treq_mask_en.cmd_tsai   )      {treq_mask_en_sai   }};
  assign  treq_mask_en.cmd_taddr       =  {$bits(treq_mask_en.cmd_taddr  )      {treq_mask_en_addr  }};
  assign  treq_mask_en.cmd_tsrcid      =  {$bits(treq_mask_en.cmd_tsrcid )      {treq_mask_en_srcid }};
  assign  treq_mask_en.cmd_tdestid     =  {$bits(treq_mask_en.cmd_tdestid)      {treq_mask_en_dstid }};
  assign  treq_mask_en.cmd_ttag        =  {$bits(treq_mask_en.cmd_ttag   )      {treq_mask_en_ttag  }};
  assign  treq_mask_en.cmd_trs         =  0;
  assign  treq_mask_en.cmd_tep         =  0;
  assign  treq_mask_en.cmd_tido        =  0;
  assign  treq_mask_en.cmd_tns         =  0;
  assign  treq_mask_en.cmd_tro         =  0;
  assign  treq_mask_en.tgt_reqid       =  0;

  assign  mdata_mask_en.mdata          =  {$bits(mdata_mask_en.mdata)   {mdata_mask_en_data}};
  assign  mdata_mask_en.dir            =  0;
  assign  mdata_mask_en.data_mvalid    =  0;
  assign  mdata_mask_en.mdata_width    =  0;
  assign  mdata_mask_en.mdata_last     =  0;
  assign  mdata_mask_en.mdata_id       =  0;
 
  assign  tdata_mask_en.tdata          =  {$bits(tdata_mask_en.tdata)   {tdata_mask_en_data}};
  assign  tdata_mask_en.dir            =  0;
  assign  tdata_mask_en.data_tvalid    =  0;
  assign  tdata_mask_en.tdata_width    =  0;
  assign  tdata_mask_en.tdata_last     =  0;
  assign  tdata_mask_en.tdata_id       =  0;

  assign treq_mask_value.cmd_tfmt          =  mask_value_treq0_reg_cr.fmt_mask_value;
  assign treq_mask_value.cmd_ttype         =  mask_value_treq0_reg_cr.type_mask_value;
  assign treq_mask_value.cmd_ttc           =  mask_value_treq0_reg_cr.tc_mask_value;
  assign treq_mask_value.cmd_tlength       =  mask_value_treq0_reg_cr.length_mask_value;
  assign treq_mask_value.cmd_ttag          =  mask_value_treq0_reg_cr.tag_mask_value;

  assign treq_mask_value.cmd_treqid        =  mask_value_treq1_reg_cr.reqid_mask_value;
  assign treq_mask_value.cmd_tlbe          =  mask_value_treq1_reg_cr.lbe_mask_value;
  assign treq_mask_value.cmd_tfbe          =  mask_value_treq1_reg_cr.fbe_mask_value;
  assign treq_mask_value.cmd_tsai          =  mask_value_treq1_reg_cr.sai_mask_value;

  assign treq_mask_value.cmd_taddr[31:0]   =  mask_value_treq2_reg_cr.address_ls32b_mask_value;
  assign treq_mask_value.cmd_taddr[63:32]  =  mask_value_treq3_reg_cr.address_ms32b_mask_value;

  assign treq_mask_value.cmd_tsrcid        =  mask_value_treq4_reg_cr.srcid_mask_value;
  assign treq_mask_value.cmd_tdestid       =  mask_value_treq4_reg_cr.dstid_mask_value;

  assign treq_mask_value.cmd_trtype        =  mask_value_treq5_reg_cr.gnt_rtype_mask_value;
  assign treq_mask_value.cmd_tchid         =  mask_value_treq5_reg_cr.gnt_chid_mask_value;
  assign treq_mask_value.tgt_reqid         =  mask_value_treq5_reg_cr.mstr_reqid_mask_value;

  assign treq_mask_value.cmd_trs           =  0;
  assign treq_mask_value.cmd_tep           =  0;
  assign treq_mask_value.cmd_tido          =  0;
  assign treq_mask_value.cmd_tns           =  0;
  assign treq_mask_value.cmd_tro           =  0;
  assign treq_mask_value.dir               =  0;
  assign treq_mask_value.cmd_tput          =  0;

  assign mreq_mask_value.cmd_mfmt          =  mask_value_mreq0_reg_cr.fmt_mask_value;
  assign mreq_mask_value.cmd_mtype         =  mask_value_mreq0_reg_cr.type_mask_value;
  assign mreq_mask_value.cmd_mtc           =  mask_value_mreq0_reg_cr.tc_mask_value;
  assign mreq_mask_value.cmd_mlength       =  mask_value_mreq0_reg_cr.length_mask_value;
  assign mreq_mask_value.cmd_mtag          =  mask_value_mreq0_reg_cr.tag_mask_value;

  assign mreq_mask_value.cmd_mreqid        =  mask_value_mreq1_reg_cr.reqid_mask_value;
  assign mreq_mask_value.cmd_mlbe          =  mask_value_mreq1_reg_cr.lbe_mask_value;
  assign mreq_mask_value.cmd_mfbe          =  mask_value_mreq1_reg_cr.fbe_mask_value;
  assign mreq_mask_value.cmd_msai          =  mask_value_mreq1_reg_cr.sai_mask_value;

  assign mreq_mask_value.cmd_maddr[31:0]   =  mask_value_mreq2_reg_cr.address_ls32b_mask_value;
  assign mreq_mask_value.cmd_maddr[63:32]  =  mask_value_mreq3_reg_cr.address_ms32b_mask_value;

  assign mreq_mask_value.cmd_msrcid        =  mask_value_mreq4_reg_cr.srcid_mask_value;
  assign mreq_mask_value.cmd_mdestid       =  mask_value_mreq4_reg_cr.dstid_mask_value;

  assign mreq_mask_value.gnt_rtype         =  mask_value_mreq5_reg_cr.gnt_rtype_mask_value;
  assign mreq_mask_value.gnt_chid          =  mask_value_mreq5_reg_cr.gnt_chid_mask_value;
  assign mreq_mask_value.mstr_reqid        =  mask_value_mreq5_reg_cr.mstr_reqid_mask_value;

  assign mreq_mask_value.cmd_mrs           =  0;
  assign mreq_mask_value.cmd_mep           =  0;
  assign mreq_mask_value.cmd_mido          =  0;
  assign mreq_mask_value.cmd_mns           =  0;
  assign mreq_mask_value.cmd_mro           =  0;
  assign mreq_mask_value.dir               =  0;

  assign mdata_mask_value.mdata[31:0]      =  mask_value_mdata0_reg_cr.data_mask_value;
  assign tdata_mask_value.tdata[31:0]      =  mask_value_tdata0_reg_cr.data_mask_value;

  /*  Convert the CAP rdata bus into an array of CSR_DATA_W width */
  generate
    for(i=0;i<REQ_NUM_SLICES_PER_CAP;i++)
    begin : gen_cap_req_rdata_slices
      if((i==REQ_NUM_SLICES_PER_CAP-1)  &&  (REQ_CAP_SLICE_RESIDUE  > 0))
      begin
        assign  treq_cap_rdata_slices[i]  = {{(AV_MM_DATA_W-REQ_CAP_SLICE_RESIDUE){1'b0}},treq_cap_rdata[(i*AV_MM_DATA_W) +:  REQ_CAP_SLICE_RESIDUE]};
        assign  mreq_cap_rdata_slices[i]  = {{(AV_MM_DATA_W-REQ_CAP_SLICE_RESIDUE){1'b0}},mreq_cap_rdata[(i*AV_MM_DATA_W) +:  REQ_CAP_SLICE_RESIDUE]};
      end
      else
      begin
        assign  treq_cap_rdata_slices[i]  = treq_cap_rdata[(i*AV_MM_DATA_W) +:  AV_MM_DATA_W];
        assign  mreq_cap_rdata_slices[i]  = mreq_cap_rdata[(i*AV_MM_DATA_W) +:  AV_MM_DATA_W];
      end
    end
  endgenerate

  generate
    for(i=0;i<DATA_NUM_SLICES_PER_CAP;i++)
    begin : gen_cap_data_rdata_slices
      if((i==DATA_NUM_SLICES_PER_CAP-1)  &&  (DATA_CAP_SLICE_RESIDUE  > 0))
      begin
        assign  mdata_cap_rdata_slices[i]  = {{(AV_MM_DATA_W-DATA_CAP_SLICE_RESIDUE){1'b0}},mdata_cap_rdata[(i*AV_MM_DATA_W) +:  DATA_CAP_SLICE_RESIDUE]};
        assign  tdata_cap_rdata_slices[i]  = {{(AV_MM_DATA_W-DATA_CAP_SLICE_RESIDUE){1'b0}},tdata_cap_rdata[(i*AV_MM_DATA_W) +:  DATA_CAP_SLICE_RESIDUE]};
      end
      else
      begin
        assign  mdata_cap_rdata_slices[i]  = mdata_cap_rdata[(i*AV_MM_DATA_W) +:  AV_MM_DATA_W];
        assign  tdata_cap_rdata_slices[i]  = tdata_cap_rdata[(i*AV_MM_DATA_W) +:  AV_MM_DATA_W];
      end
    end
  endgenerate

  /*  Interfacing with Capture FIFO */
  generate
    if(MODE ==  "avl")
    begin
      assign  treq_cap_rden             = 1'b0;
      assign  treq_cap_fifo_rdata_reg   = 'hdeadbabe;

      assign  mreq_cap_rden             = 1'b0;
      assign  mreq_cap_fifo_rdata_reg   = 'hdeadbabe;

      assign  tdata_cap_rden             = 1'b0;
      assign  tdata_cap_fifo_rdata_reg   = 'hdeadbabe;

      assign  mdata_cap_rden             = 1'b0;
      assign  mdata_cap_fifo_rdata_reg   = 'hdeadbabe;

    end
    else  //MODE  ==  "standalone"
    begin

      always@(posedge clk_logic,  negedge rst_logic_n)
      begin
        if(~rst_logic_n)
        begin
          treq_cap_rden   <=  0;
          mreq_cap_rden   <=  0;
          tdata_cap_rden  <=  0;
          mdata_cap_rden  <=  0;
        end
        else
        begin
          //Generate a read enable pulse & update slice indexes
         //added based on handcode output
         mdata_cap_rden <=  we_mdata_cap_fifo_cntrl_reg_cr.cap_fifo_rden & handcode_wdata_mdata_cap_fifo_cntrl_reg_cr.cap_fifo_rden;
         tdata_cap_rden <=  we_tdata_cap_fifo_cntrl_reg_cr.cap_fifo_rden & handcode_wdata_tdata_cap_fifo_cntrl_reg_cr.cap_fifo_rden;
         treq_cap_rden  <=  we_treq_cap_fifo_cntrl_reg_cr.cap_fifo_rden  & handcode_wdata_treq_cap_fifo_cntrl_reg_cr.cap_fifo_rden;
         mreq_cap_rden  <=  we_mreq_cap_fifo_cntrl_reg_cr.cap_fifo_rden  & handcode_wdata_mreq_cap_fifo_cntrl_reg_cr.cap_fifo_rden;
        end
      end

      //Build registers for read
      assign  treq_cap_fifo_rdata_reg   = treq_cap_rdata_slices[treq_cap_rdata_slice_idx];
      assign  mreq_cap_fifo_rdata_reg   = mreq_cap_rdata_slices[mreq_cap_rdata_slice_idx];
      assign  tdata_cap_fifo_rdata_reg  = tdata_cap_rdata_slices[tdata_cap_rdata_slice_idx];
      assign  mdata_cap_fifo_rdata_reg  = mdata_cap_rdata_slices[mdata_cap_rdata_slice_idx];

    end
  endgenerate


  //Assigning HW inputs to register fields
  always@(*)
  begin

    for (n=0;n<4;n++)
    begin
      new_mon_type_reg_cr.inst_name[(n*8) +:  8] =  sbr_type_str[3-n];
    end
    
    for (n=0;n<4;n++)
    begin
      new_inst_name0_reg_cr.inst_name[(n*8) +:  8]=  inst_name_str[15-n];
    end
  
    for (n=0;n<4;n++)
    begin
      new_inst_name1_reg_cr.inst_name[(n*8) +:  8]=  inst_name_str[15-4-n];
    end
  
    for (n=0;n<4;n++)
    begin
      new_inst_name2_reg_cr.inst_name[(n*8) +:  8]=  inst_name_str[15-8-n];
    end
  
    for (n=0;n<4;n++)
    begin
      new_inst_name3_reg_cr.inst_name[(n*8) +:  8]=  inst_name_str[15-12-n];
    end
  
    new_params0_reg_cr.payload_width  = 0;
    new_params0_reg_cr.mode           = (MODE ==  "avl")  ? 1'b0  : 1'b1;
    new_params0_reg_cr.cap_fifo_depth = CAP_FF_DEPTH;
  
    new_params1_reg_cr.DATA_CAP_FF_DATA_W = DATA_CAP_FF_DATA_W;
    new_params1_reg_cr.REQ_CAP_FF_DATA_W  = REQ_CAP_FF_DATA_W; 
  
    mon_enable        =   cntrl_reg_cr.mon_enable;
    clr_stats         =   cntrl_reg_cr.clr_stats;
    flush_cap_ff      =   cntrl_reg_cr.flush_cap_ff;
    rec_ordering_en   =   cntrl_reg_cr.rec_ordering_en;

    treq_mask_en_fmt       = mask_cntrl_treq_reg_cr.fmt_mask_en;
    treq_mask_en_type      = mask_cntrl_treq_reg_cr.type_mask_en;
    treq_mask_en_tc        = mask_cntrl_treq_reg_cr.tc_mask_en;
    treq_mask_en_length    = mask_cntrl_treq_reg_cr.length_mask_en;
    treq_mask_en_reqid     = mask_cntrl_treq_reg_cr.reqid_mask_en;
    treq_mask_en_lbe       = mask_cntrl_treq_reg_cr.lbe_mask_en;
    treq_mask_en_fbe       = mask_cntrl_treq_reg_cr.fbe_mask_en;
    treq_mask_en_sai       = mask_cntrl_treq_reg_cr.sai_mask_en;
    treq_mask_en_addr      = mask_cntrl_treq_reg_cr.addr_mask_en;
    treq_mask_en_srcid     = mask_cntrl_treq_reg_cr.srcid_mask_en;
    treq_mask_en_dstid     = mask_cntrl_treq_reg_cr.dstid_mask_en;
    treq_mask_en_ttag      = mask_cntrl_treq_reg_cr.tag_mask_en;

    mreq_mask_en_fmt       = mask_cntrl_mreq_reg_cr.fmt_mask_en;
    mreq_mask_en_type      = mask_cntrl_mreq_reg_cr.type_mask_en;
    mreq_mask_en_tc        = mask_cntrl_mreq_reg_cr.tc_mask_en;
    mreq_mask_en_length    = mask_cntrl_mreq_reg_cr.length_mask_en;
    mreq_mask_en_reqid     = mask_cntrl_mreq_reg_cr.reqid_mask_en;
    mreq_mask_en_lbe       = mask_cntrl_mreq_reg_cr.lbe_mask_en;
    mreq_mask_en_fbe       = mask_cntrl_mreq_reg_cr.fbe_mask_en;
    mreq_mask_en_sai       = mask_cntrl_mreq_reg_cr.sai_mask_en;
    mreq_mask_en_addr      = mask_cntrl_mreq_reg_cr.addr_mask_en;
    mreq_mask_en_srcid     = mask_cntrl_mreq_reg_cr.srcid_mask_en;
    mreq_mask_en_dstid     = mask_cntrl_mreq_reg_cr.dstid_mask_en;
    mreq_mask_en_mtag      = mask_cntrl_mreq_reg_cr.tag_mask_en;

    mdata_mask_en_data     = mask_cntrl_mdata_reg_cr.data_mask_en;
    tdata_mask_en_data     = mask_cntrl_tdata_reg_cr.data_mask_en;

    new_bus_status_reg_cr.prim_ism_agent               = iosf_mon_PRIM_ISM_AGENT;
    new_bus_status_reg_cr.prim_ism_fabric              = iosf_mon_PRIM_ISM_FABRIC;
    new_num_mreq_pkts_cnt_reg_cr.num_pkts              = num_mreq_pkts;
    new_num_mreq_beats_cnt_reg_cr.num_beats            = num_mreq_beats;
    new_num_mdata_beats_cnt_reg_cr.num_beats           = num_mdata_beats;
    new_num_mdata_pkts_cnt_reg_cr.num_pkts             = num_mdata_pkts;
    new_num_tdata_beats_cnt_reg_cr.num_beats           = num_tdata_beats;
    new_num_tdata_pkts_cnt_reg_cr.num_pkts             = num_tdata_pkts;
    new_num_treq_beats_cnt_reg_cr.num_beats            = num_treq_beats;
    new_num_treq_pkts_cnt_reg_cr.num_pkts              = num_treq_pkts;
    new_num_dropped_pkts_cnt_reg_cr.num_pkts_dropped   = num_dropped_pkts;

    handcode_rdata_mdata_cap_fifo_cntrl_reg_cr.cap_fifo_rden  = 1'b0;
    handcode_rdata_mreq_cap_fifo_cntrl_reg_cr.cap_fifo_rden   = 1'b0;
    handcode_rdata_tdata_cap_fifo_cntrl_reg_cr.cap_fifo_rden  = 1'b0;
    handcode_rdata_treq_cap_fifo_cntrl_reg_cr.cap_fifo_rden   = 1'b0;

    mreq_cap_rdata_slice_idx  =  mreq_cap_fifo_cntrl_reg_cr.cap_fifo_rdata_slice_idx;
    treq_cap_rdata_slice_idx  =  treq_cap_fifo_cntrl_reg_cr.cap_fifo_rdata_slice_idx;
    mdata_cap_rdata_slice_idx =  mdata_cap_fifo_cntrl_reg_cr.cap_fifo_rdata_slice_idx;
    tdata_cap_rdata_slice_idx =  tdata_cap_fifo_cntrl_reg_cr.cap_fifo_rdata_slice_idx;

    new_tdata_cap_fifo_status_reg_cr.cap_fifo_used = tdata_cap_rdused;
    new_mdata_cap_fifo_status_reg_cr.cap_fifo_used = mdata_cap_rdused;
    new_treq_cap_fifo_status_reg_cr.cap_fifo_used  = treq_cap_rdused;
    new_mreq_cap_fifo_status_reg_cr.cap_fifo_used  = mreq_cap_rdused;

    new_tdata_cap_fifo_rdata_reg_cr.cap_fifo_rdata_slice  = tdata_cap_fifo_rdata_reg;
    new_mdata_cap_fifo_rdata_reg_cr.cap_fifo_rdata_slice  = mdata_cap_fifo_rdata_reg;
    new_treq_cap_fifo_rdata_reg_cr.cap_fifo_rdata_slice   = treq_cap_fifo_rdata_reg;
    new_mreq_cap_fifo_rdata_reg_cr.cap_fifo_rdata_slice   = mreq_cap_fifo_rdata_reg;

  end

// IOSF Primary data path monitor register module instantiation
  IW_fpga_iosf_p_mon_av_addr_map u_addr_map (
    .gated_clk                                   (clk_logic),
    .rst_n                                       (rst_logic_n),

    .new_bus_status_reg_cr                       (new_bus_status_reg_cr                      ),
    .new_mon_type_reg_cr                         (new_mon_type_reg_cr                        ),
    .new_inst_name0_reg_cr                       (new_inst_name0_reg_cr                      ),
    .new_inst_name1_reg_cr                       (new_inst_name1_reg_cr                      ),
    .new_inst_name2_reg_cr                       (new_inst_name2_reg_cr                      ),
    .new_inst_name3_reg_cr                       (new_inst_name3_reg_cr                      ),
    .new_params0_reg_cr                          (new_params0_reg_cr                         ),
    .new_params1_reg_cr                          (new_params1_reg_cr                         ),
    .new_mdata_cap_fifo_rdata_reg_cr             (new_mdata_cap_fifo_rdata_reg_cr            ),
    .new_mdata_cap_fifo_status_reg_cr            (new_mdata_cap_fifo_status_reg_cr           ),
    .new_mreq_cap_fifo_rdata_reg_cr              (new_mreq_cap_fifo_rdata_reg_cr             ),
    .new_mreq_cap_fifo_status_reg_cr             (new_mreq_cap_fifo_status_reg_cr            ),
    .new_num_dropped_pkts_cnt_reg_cr             (new_num_dropped_pkts_cnt_reg_cr            ),
    .new_num_mdata_beats_cnt_reg_cr              (new_num_mdata_beats_cnt_reg_cr             ),
    .new_num_mdata_pkts_cnt_reg_cr               (new_num_mdata_pkts_cnt_reg_cr              ),
    .new_num_mreq_beats_cnt_reg_cr               (new_num_mreq_beats_cnt_reg_cr              ),
    .new_num_mreq_pkts_cnt_reg_cr                (new_num_mreq_pkts_cnt_reg_cr               ),
    .new_num_tdata_beats_cnt_reg_cr              (new_num_tdata_beats_cnt_reg_cr             ),
    .new_num_tdata_pkts_cnt_reg_cr               (new_num_tdata_pkts_cnt_reg_cr              ),
    .new_num_treq_beats_cnt_reg_cr               (new_num_treq_beats_cnt_reg_cr              ),
    .new_num_treq_pkts_cnt_reg_cr                (new_num_treq_pkts_cnt_reg_cr               ),
    .new_tdata_cap_fifo_rdata_reg_cr             (new_tdata_cap_fifo_rdata_reg_cr            ),
    .new_tdata_cap_fifo_status_reg_cr            (new_tdata_cap_fifo_status_reg_cr           ),
    .new_treq_cap_fifo_rdata_reg_cr              (new_treq_cap_fifo_rdata_reg_cr             ),
    .new_treq_cap_fifo_status_reg_cr             (new_treq_cap_fifo_status_reg_cr            ),

    .handcode_rdata_mdata_cap_fifo_cntrl_reg_cr  (handcode_rdata_mdata_cap_fifo_cntrl_reg_cr ),
    .handcode_rdata_mreq_cap_fifo_cntrl_reg_cr   (handcode_rdata_mreq_cap_fifo_cntrl_reg_cr  ),
    .handcode_rdata_tdata_cap_fifo_cntrl_reg_cr  (handcode_rdata_tdata_cap_fifo_cntrl_reg_cr ),
    .handcode_rdata_treq_cap_fifo_cntrl_reg_cr   (handcode_rdata_treq_cap_fifo_cntrl_reg_cr  ),

    // Register Outputs
    .bus_status_reg_cr                           (bus_status_reg_cr           ),
    .cntrl_reg_cr                                (cntrl_reg_cr                ),
    .inst_name0_reg_cr                           (inst_name0_reg_cr           ),
    .inst_name1_reg_cr                           (inst_name1_reg_cr           ),
    .inst_name2_reg_cr                           (inst_name2_reg_cr           ),
    .inst_name3_reg_cr                           (inst_name3_reg_cr           ),
    .mask_cntrl_mdata_reg_cr                     (mask_cntrl_mdata_reg_cr     ),
    .mask_cntrl_mreq_reg_cr                      (mask_cntrl_mreq_reg_cr      ),
    .mask_cntrl_tdata_reg_cr                     (mask_cntrl_tdata_reg_cr     ),
    .mask_cntrl_treq_reg_cr                      (mask_cntrl_treq_reg_cr      ),
    .mask_value_mdata0_reg_cr                    (mask_value_mdata0_reg_cr    ),
    .mask_value_mreq0_reg_cr                     (mask_value_mreq0_reg_cr     ),
    .mask_value_mreq1_reg_cr                     (mask_value_mreq1_reg_cr     ),
    .mask_value_mreq2_reg_cr                     (mask_value_mreq2_reg_cr     ),
    .mask_value_mreq3_reg_cr                     (mask_value_mreq3_reg_cr     ),
    .mask_value_mreq4_reg_cr                     (mask_value_mreq4_reg_cr     ),
    .mask_value_mreq5_reg_cr                     (mask_value_mreq5_reg_cr     ),
    .mask_value_tdata0_reg_cr                    (mask_value_tdata0_reg_cr    ),
    .mask_value_treq0_reg_cr                     (mask_value_treq0_reg_cr     ),
    .mask_value_treq1_reg_cr                     (mask_value_treq1_reg_cr     ),
    .mask_value_treq2_reg_cr                     (mask_value_treq2_reg_cr     ),
    .mask_value_treq3_reg_cr                     (mask_value_treq3_reg_cr     ),
    .mask_value_treq4_reg_cr                     (mask_value_treq4_reg_cr     ),
    .mask_value_treq5_reg_cr                     (mask_value_treq5_reg_cr     ),
    .mdata_cap_fifo_cntrl_reg_cr                 (mdata_cap_fifo_cntrl_reg_cr ),
    .mdata_cap_fifo_rdata_reg_cr                 (mdata_cap_fifo_rdata_reg_cr ),
    .mdata_cap_fifo_status_reg_cr                (mdata_cap_fifo_status_reg_cr),
    .mon_type_reg_cr                             (mon_type_reg_cr             ),
    .mreq_cap_fifo_cntrl_reg_cr                  (mreq_cap_fifo_cntrl_reg_cr  ),
    .mreq_cap_fifo_rdata_reg_cr                  (mreq_cap_fifo_rdata_reg_cr  ),
    .mreq_cap_fifo_status_reg_cr                 (mreq_cap_fifo_status_reg_cr ),
    .num_dropped_pkts_cnt_reg_cr                 (num_dropped_pkts_cnt_reg_cr ),
    .num_mdata_beats_cnt_reg_cr                  (num_mdata_beats_cnt_reg_cr  ),
    .num_mdata_pkts_cnt_reg_cr                   (num_mdata_pkts_cnt_reg_cr   ),
    .num_mreq_beats_cnt_reg_cr                   (num_mreq_beats_cnt_reg_cr   ),
    .num_mreq_pkts_cnt_reg_cr                    (num_mreq_pkts_cnt_reg_cr    ),
    .num_tdata_beats_cnt_reg_cr                  (num_tdata_beats_cnt_reg_cr  ),
    .num_tdata_pkts_cnt_reg_cr                   (num_tdata_pkts_cnt_reg_cr   ),
    .num_treq_beats_cnt_reg_cr                   (num_treq_beats_cnt_reg_cr   ),
    .num_treq_pkts_cnt_reg_cr                    (num_treq_pkts_cnt_reg_cr    ),
    .params0_reg_cr                              (params0_reg_cr              ),
    .params1_reg_cr                              (params1_reg_cr              ),
    .tdata_cap_fifo_cntrl_reg_cr                 (tdata_cap_fifo_cntrl_reg_cr ),
    .tdata_cap_fifo_rdata_reg_cr                 (tdata_cap_fifo_rdata_reg_cr ),
    .tdata_cap_fifo_status_reg_cr                (tdata_cap_fifo_status_reg_cr),
    .treq_cap_fifo_cntrl_reg_cr                  (treq_cap_fifo_cntrl_reg_cr  ),
    .treq_cap_fifo_rdata_reg_cr                  (treq_cap_fifo_rdata_reg_cr  ),
    .treq_cap_fifo_status_reg_cr                 (treq_cap_fifo_status_reg_cr ),

    // Register signals for HandCoded registers
    .handcode_wdata_mdata_cap_fifo_cntrl_reg_cr  (handcode_wdata_mdata_cap_fifo_cntrl_reg_cr),
    .handcode_wdata_mreq_cap_fifo_cntrl_reg_cr   (handcode_wdata_mreq_cap_fifo_cntrl_reg_cr ),
    .handcode_wdata_tdata_cap_fifo_cntrl_reg_cr  (handcode_wdata_tdata_cap_fifo_cntrl_reg_cr),
    .handcode_wdata_treq_cap_fifo_cntrl_reg_cr   (handcode_wdata_treq_cap_fifo_cntrl_reg_cr ),
                                                                                            
    .we_mdata_cap_fifo_cntrl_reg_cr              (we_mdata_cap_fifo_cntrl_reg_cr            ),
    .we_mreq_cap_fifo_cntrl_reg_cr               (we_mreq_cap_fifo_cntrl_reg_cr             ),
    .we_tdata_cap_fifo_cntrl_reg_cr              (we_tdata_cap_fifo_cntrl_reg_cr            ),
    .we_treq_cap_fifo_cntrl_reg_cr               (we_treq_cap_fifo_cntrl_reg_cr             ),
    // Config Access
    .req                                         (req),
    .ack                                         (ack)
);

  //------------------------------------------------------//
  //    REQ SIGNALS        :     ACK SIGNALS              //
  //------------------------------------------------------//
  // req.valid     : ack.read_valid       //
  // req.opcode    : ack.read_miss        //
  // req.addr      : ack.write_valid      //
  // req.be        : ack.write_miss       //
  // req.data      : ack.sai_successfull  //
  // req.sai       : ack.data             //
  // req.fid       :                      //
  // req.bar       :                      //
  //------------------------------------------------------//
  
  //------------------------------------------------------//
  // Register module config request signals logic         //
  //------------------------------------------------------//
  //Request is valid for any read or write transaction occurs when waitrequest
  //is inactive/low 
  assign req.valid  = (csr2logic_wren||csr2logic_rden) && (!avl_mm_waitrequest);
  //Register CFG opcode selection
  assign req.opcode = csr2logic_wren? CFGWR : CFGRD;
  //Register CFG address excpets 48bit. Appending zeros to 
  //AV MM slave address
  assign req.addr   = {'h0,csr2logic_addr};
  assign req.be     = csr2logic_be;
  assign req.data   = csr2logic_wdata;
  assign req.sai    = 7'h00;
  assign req.fid    = 7'h00;
  assign req.bar    = 3'h0;
  
  //AV MM Slave waitrequest
  assign avl_mm_waitrequest = 1'b0;
  //AV MM Slave read data valid is registered CFG ack's read_valid or read_miss
  always @(posedge csi_clk  or posedge rsi_reset)
  begin
    if(rsi_reset)
      logic2csr_rdata_valid <= 1'b0;
    else
      logic2csr_rdata_valid <= ack.read_valid || ack.read_miss;
  end
  //AV MM Slave read data 
  always @(posedge csi_clk  or posedge rsi_reset)
  begin
    if(rsi_reset)
      logic2csr_rdata <= 'h0;
    else if(ack.read_miss)
      logic2csr_rdata <= READ_MISS_VAL;
    else if(ack.read_valid)
      logic2csr_rdata <= ack.data;
    else
      logic2csr_rdata <= 'h0;
  end

  assign  rst_logic_n = ~rsi_reset; 

endmodule //IW_fpga_iosf_p_mon_addr_map_avmm_wrapper
