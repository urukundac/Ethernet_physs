
module IW_iosf_prim_mux_consumer (
/****************************************************************************************
 * IOSF primary ports
 ****************************************************************************************/
    iosf_prim_CMD_NFS_ERR      ,
    iosf_prim_CMD_PUT          ,
    iosf_prim_GNT              ,
    iosf_prim_TBEWD            ,
    iosf_prim_TCHAIN           ,
    iosf_prim_TCPARITY         ,
    iosf_prim_TDEC             ,
    iosf_prim_TECRC_ERROR      ,
    iosf_prim_TECRC_GENERATE   ,
    iosf_prim_TEP              ,
    iosf_prim_TIDO             ,
    iosf_prim_TNS              ,
    iosf_prim_TRO              ,
    iosf_prim_TRSVD0_7         ,
    iosf_prim_TRSVD1_1         ,
    iosf_prim_TRSVD1_3         ,
    iosf_prim_TRSVD1_7         ,
    iosf_prim_TTD              ,
    iosf_prim_TTH              ,
    iosf_prim_TDBE             ,
    iosf_prim_CMD_RTYPE        ,
    iosf_prim_GNT_RTYPE        ,
    iosf_prim_GNT_TYPE         ,
    iosf_prim_OBFF             ,
    iosf_prim_TAT              ,
    iosf_prim_TFMT             ,
    iosf_prim_TRQID            ,
    iosf_prim_PRIM_ISM_FABRIC  ,
    iosf_prim_TPASIDTLP        ,
    iosf_prim_TFBE             ,
    iosf_prim_TLBE             ,
    iosf_prim_TTC              ,
    iosf_prim_TECRC            ,
    iosf_prim_TTYPE            ,
    iosf_prim_TTAG             ,
    iosf_prim_TLENGTH          ,
    iosf_prim_TCID             ,
    iosf_prim_TDEADLINE        ,
    iosf_prim_TDEST_ID         ,
    iosf_prim_GNT_CHID         ,
    iosf_prim_TRS              ,
    iosf_prim_TSAI             ,
    iosf_prim_TSRC_ID          ,
    iosf_prim_TDPARITY         ,
    iosf_prim_TDATA            ,
    iosf_prim_TADDRESS         ,
    iosf_prim_TPRIORITY        ,
    iosf_prim_CMD_CHID         ,
    iosf_prim_CREDIT_CMD       ,
    iosf_prim_CREDIT_PUT       ,
    iosf_prim_MBEWD            ,
    iosf_prim_MCPARITY         ,
    iosf_prim_MECRC_ERROR      ,
    iosf_prim_MECRC_GENERATE   ,
    iosf_prim_MEP              ,
    iosf_prim_MIDO             ,
    iosf_prim_MNS              ,
    iosf_prim_MRO              ,
    iosf_prim_MRSVD0_7         ,
    iosf_prim_MRSVD1_1         ,
    iosf_prim_MRSVD1_3         ,
    iosf_prim_MRSVD1_7         ,
    iosf_prim_MTD              ,
    iosf_prim_MTH              ,
    iosf_prim_REQ_CDATA        ,
    iosf_prim_REQ_CHAIN        ,
    iosf_prim_REQ_IDO          ,
    iosf_prim_REQ_LOCKED       ,
    iosf_prim_REQ_NS           ,
    iosf_prim_REQ_OPP          ,
    iosf_prim_REQ_PUT          ,
    iosf_prim_REQ_RO           ,
    iosf_prim_MDBE             ,
    iosf_prim_CREDIT_RTYPE     ,
    iosf_prim_MAT              ,
    iosf_prim_MFMT             ,
    iosf_prim_REQ_RTYPE        ,
    iosf_prim_MRQID            ,
    iosf_prim_REQ_ID           ,
    iosf_prim_CREDIT_DATA      ,
    iosf_prim_PRIM_ISM_AGENT   ,
    iosf_prim_MPASIDTLP        ,
    iosf_prim_MFBE             ,
    iosf_prim_MLBE             ,
    iosf_prim_MTC              ,
    iosf_prim_MECRC            ,
    iosf_prim_MTYPE            ,
    iosf_prim_MTAG             ,
    iosf_prim_REQ_AGENT        ,
    iosf_prim_MCID             ,
    iosf_prim_MDEADLINE        ,
    iosf_prim_MDEST_ID         ,
    iosf_prim_REQ_DEST_ID      ,
    iosf_prim_REQ_DLEN         ,
    iosf_prim_MDPARITY         ,
    iosf_prim_MDATA            ,
    iosf_prim_MLENGTH          ,
    iosf_prim_MADDRESS         ,
    iosf_prim_REQ_PRIORITY     ,
    iosf_prim_REQ_CHID         ,
    iosf_prim_REQ_TC           ,
    iosf_prim_MRS              ,
    iosf_prim_REQ_RS           ,
    iosf_prim_MSAI             ,
    iosf_prim_MSRC_ID          ,
    iosf_prim_HIT              ,
    iosf_prim_SUB_HIT          ,
    iosf_prim_CREDIT_CHID      ,

    mux_data                  ,
    demux_data

 );

  // Internal parameters
  parameter MNUMCHAN           =  0   ;  // 1   ;
  parameter CID_WIDTH          =  19  ;  // 20  ;
  parameter DEADLINE_WIDTH     =  3   ;  // 4   ;
  parameter RS_WIDTH           =  3   ;  // 4   ;
  parameter TNUMCHANL2CREDIT   =  0   ;  // 1   ;
  parameter AGENT_WIDTH        =  3   ;  // 4   ;
  parameter TNUMCHAN           =  0   ;  // 1   ;
  parameter MlengthSize        =  9   ;  // 10  ;
  parameter DST_ID_WIDTH       =  13  ;  // 14  ;
  parameter SRC_ID_WIDTH       =  13  ;  // 14  ;
  parameter MMAX_ADDR          =  63  ;  // 64  ;
  parameter MNUMCHANL2         =  0   ;  // 1   ;
  parameter MD_WIDTH           =  255 ;  // 256 ;
  parameter MAX_DATA_LEN       =  6   ;  // 7   ;
  parameter ReqTcSize          =  4   ;  // 4   ;
  parameter TNUMCHANL2         =  0   ;  // 1   ;
  parameter SAI_WIDTH          =  7   ;  // 8   ;
  parameter TMAX_ADDR          =  63  ;  // 64  ;
  parameter TD_WIDTH           =  511  ; // 512 ;
  //Interface definitions expects parameters with actual width-1
  //So we must add count of no. of parameters being used fo mux/demux signals
  parameter NUM_DEMUX_SIGNALS  = (SAI_WIDTH+TNUMCHANL2+DST_ID_WIDTH+MNUMCHANL2+TMAX_ADDR+
                                 CID_WIDTH+DEADLINE_WIDTH+RS_WIDTH+SRC_ID_WIDTH+TD_WIDTH+
                                 TNUMCHAN+(TD_WIDTH/8)+(TD_WIDTH>=511?2:1)+ 140+12);

  parameter NUM_MUX_SIGNALS   = (MNUMCHAN+MlengthSize+DST_ID_WIDTH+DST_ID_WIDTH+SRC_ID_WIDTH+MMAX_ADDR+
                                 CID_WIDTH+DEADLINE_WIDTH+RS_WIDTH+RS_WIDTH+SAI_WIDTH+TNUMCHANL2CREDIT+
                                 MNUMCHANL2+MD_WIDTH+MAX_DATA_LEN+AGENT_WIDTH+(ReqTcSize-1)+TNUMCHAN+
                                 TNUMCHAN+(MD_WIDTH/8)+(MD_WIDTH>=511?2:1)+150+20);

/****************************************************************************************
 * IOSF primary ports
 ****************************************************************************************/
output                            iosf_prim_CMD_NFS_ERR      ;
output                            iosf_prim_CMD_PUT          ;
output                            iosf_prim_GNT              ;
output                            iosf_prim_TBEWD            ;
output                            iosf_prim_TCHAIN           ;
output                            iosf_prim_TCPARITY         ;
output                            iosf_prim_TDEC             ;
output                            iosf_prim_TECRC_ERROR      ;
output                            iosf_prim_TECRC_GENERATE   ;
output                            iosf_prim_TEP              ;
output                            iosf_prim_TIDO             ;
output                            iosf_prim_TNS              ;
output                            iosf_prim_TRO              ;
output                            iosf_prim_TRSVD0_7         ;
output                            iosf_prim_TRSVD1_1         ;
output                            iosf_prim_TRSVD1_3         ;
output                            iosf_prim_TRSVD1_7         ;
output                            iosf_prim_TTD              ;
output                            iosf_prim_TTH              ;
output [(TD_WIDTH/8):0]           iosf_prim_TDBE             ;
output [1:0]                      iosf_prim_CMD_RTYPE        ;
output [1:0]                      iosf_prim_GNT_RTYPE        ;
output [1:0]                      iosf_prim_GNT_TYPE         ;
output [1:0]                      iosf_prim_OBFF             ;
output [1:0]                      iosf_prim_TAT              ;
output [1:0]                      iosf_prim_TFMT             ;
output [15:0]                     iosf_prim_TRQID            ;
output [2:0]                      iosf_prim_PRIM_ISM_FABRIC  ;
output [22:0]                     iosf_prim_TPASIDTLP        ;
output [3:0]                      iosf_prim_TFBE             ;
output [3:0]                      iosf_prim_TLBE             ;
output [3:0]                      iosf_prim_TTC              ;
output [31:0]                     iosf_prim_TECRC            ;
output [4:0]                      iosf_prim_TTYPE            ;
output [7:0]                      iosf_prim_TTAG             ;
output [9:0]                      iosf_prim_TLENGTH          ;
output [CID_WIDTH:0]              iosf_prim_TCID             ;
output [DEADLINE_WIDTH:0]         iosf_prim_TDEADLINE        ;
output [DST_ID_WIDTH:0]           iosf_prim_TDEST_ID         ;
output [MNUMCHANL2:0]             iosf_prim_GNT_CHID         ;
output [RS_WIDTH:0]               iosf_prim_TRS              ;
output [SAI_WIDTH:0]              iosf_prim_TSAI             ;
output [SRC_ID_WIDTH:0]           iosf_prim_TSRC_ID          ;
output [(TD_WIDTH>=511?2:1)-1:0]  iosf_prim_TDPARITY         ;
output [TD_WIDTH:0]               iosf_prim_TDATA            ;
output [TMAX_ADDR:0]              iosf_prim_TADDRESS         ;
output [TNUMCHAN:0]               iosf_prim_TPRIORITY        ;
output [TNUMCHANL2:0]             iosf_prim_CMD_CHID         ;
input                             iosf_prim_CREDIT_CMD       ;
input                             iosf_prim_CREDIT_PUT       ;
input                             iosf_prim_MBEWD            ;
input                             iosf_prim_MCPARITY         ;
input                             iosf_prim_MECRC_ERROR      ;
input                             iosf_prim_MECRC_GENERATE   ;
input                             iosf_prim_MEP              ;
input                             iosf_prim_MIDO             ;
input                             iosf_prim_MNS              ;
input                             iosf_prim_MRO              ;
input                             iosf_prim_MRSVD0_7         ;
input                             iosf_prim_MRSVD1_1         ;
input                             iosf_prim_MRSVD1_3         ;
input                             iosf_prim_MRSVD1_7         ;
input                             iosf_prim_MTD              ;
input                             iosf_prim_MTH              ;
input                             iosf_prim_REQ_CDATA        ;
input                             iosf_prim_REQ_CHAIN        ;
input                             iosf_prim_REQ_IDO          ;
input                             iosf_prim_REQ_LOCKED       ;
input                             iosf_prim_REQ_NS           ;
input                             iosf_prim_REQ_OPP          ;
input                             iosf_prim_REQ_PUT          ;
input                             iosf_prim_REQ_RO           ;
input  [(MD_WIDTH/8):0]           iosf_prim_MDBE             ;
input  [1:0]                      iosf_prim_CREDIT_RTYPE     ;
input  [1:0]                      iosf_prim_MAT              ;
input  [1:0]                      iosf_prim_MFMT             ;
input  [1:0]                      iosf_prim_REQ_RTYPE        ;
input  [15:0]                     iosf_prim_MRQID            ;
input  [15:0]                     iosf_prim_REQ_ID           ;
input  [2:0]                      iosf_prim_CREDIT_DATA      ;
input  [2:0]                      iosf_prim_PRIM_ISM_AGENT   ;
input  [22:0]                     iosf_prim_MPASIDTLP        ;
input  [3:0]                      iosf_prim_MFBE             ;
input  [3:0]                      iosf_prim_MLBE             ;
input  [3:0]                      iosf_prim_MTC              ;
input  [31:0]                     iosf_prim_MECRC            ;
input  [4:0]                      iosf_prim_MTYPE            ;
input  [7:0]                      iosf_prim_MTAG             ;
input  [AGENT_WIDTH:0]            iosf_prim_REQ_AGENT        ;
input  [CID_WIDTH:0]              iosf_prim_MCID             ;
input  [DEADLINE_WIDTH:0]         iosf_prim_MDEADLINE        ;
input  [DST_ID_WIDTH:0]           iosf_prim_MDEST_ID         ;
input  [DST_ID_WIDTH:0]           iosf_prim_REQ_DEST_ID      ;
input  [MAX_DATA_LEN:0]           iosf_prim_REQ_DLEN         ;
input  [(MD_WIDTH>=511?2:1)-1:0]  iosf_prim_MDPARITY         ;
input  [MD_WIDTH:0]               iosf_prim_MDATA            ;
input  [MlengthSize:0]            iosf_prim_MLENGTH          ;
input  [MMAX_ADDR:0]              iosf_prim_MADDRESS         ;
input  [MNUMCHAN:0]               iosf_prim_REQ_PRIORITY     ;
input  [MNUMCHANL2:0]             iosf_prim_REQ_CHID         ;
input  [ReqTcSize-1:0]            iosf_prim_REQ_TC           ;
input  [RS_WIDTH:0]               iosf_prim_MRS              ;
input  [RS_WIDTH:0]               iosf_prim_REQ_RS           ;
input  [SAI_WIDTH:0]              iosf_prim_MSAI             ;
input  [SRC_ID_WIDTH:0]           iosf_prim_MSRC_ID          ;
input  [TNUMCHAN:0]               iosf_prim_HIT              ;
input  [TNUMCHAN:0]               iosf_prim_SUB_HIT          ;
input  [TNUMCHANL2CREDIT:0]       iosf_prim_CREDIT_CHID      ;

/****************************************************************************************
 * Bundelled signals for mux/demux
 ****************************************************************************************/
output [NUM_MUX_SIGNALS-1 :0]            mux_data;
input  [NUM_DEMUX_SIGNALS-1 :0]          demux_data;

/****************************************************************************************/
wire [NUM_MUX_SIGNALS-1 :0]             mux_signals;
wire [NUM_DEMUX_SIGNALS-1 :0]           demux_signals;


  assign  mux_data = {
             iosf_prim_CREDIT_CMD       ,
             iosf_prim_CREDIT_PUT       ,
             iosf_prim_MBEWD            ,
             iosf_prim_MCPARITY         ,
             iosf_prim_MECRC_ERROR      ,
             iosf_prim_MECRC_GENERATE   ,
             iosf_prim_MEP              ,
             iosf_prim_MIDO             ,
             iosf_prim_MNS              ,
             iosf_prim_MRO              ,
             iosf_prim_MRSVD0_7         ,
             iosf_prim_MRSVD1_1         ,
             iosf_prim_MRSVD1_3         ,
             iosf_prim_MRSVD1_7         ,
             iosf_prim_MTD              ,
             iosf_prim_MTH              ,
             iosf_prim_REQ_CDATA        ,
             iosf_prim_REQ_CHAIN        ,
             iosf_prim_REQ_IDO          ,
             iosf_prim_REQ_LOCKED       ,
             iosf_prim_REQ_NS           ,
             iosf_prim_REQ_OPP          ,
             iosf_prim_REQ_PUT          ,
             iosf_prim_REQ_RO           ,
             iosf_prim_MDBE             ,
             iosf_prim_CREDIT_RTYPE     ,
             iosf_prim_MAT              ,
             iosf_prim_MFMT             ,
             iosf_prim_REQ_RTYPE        ,
             iosf_prim_MRQID            ,
             iosf_prim_REQ_ID           ,
             iosf_prim_CREDIT_DATA      ,
             iosf_prim_PRIM_ISM_AGENT   ,
             iosf_prim_MPASIDTLP        ,
             iosf_prim_MFBE             ,
             iosf_prim_MLBE             ,
             iosf_prim_MTC              ,
             iosf_prim_MECRC            ,
             iosf_prim_MTYPE            ,
             iosf_prim_MTAG             ,
             iosf_prim_REQ_AGENT        ,
             iosf_prim_MCID             ,
             iosf_prim_MDEADLINE        ,
             iosf_prim_MDEST_ID         ,
             iosf_prim_REQ_DEST_ID      ,
             iosf_prim_REQ_DLEN         ,
             iosf_prim_MDPARITY         ,
             iosf_prim_MDATA            ,
             iosf_prim_MLENGTH          ,
             iosf_prim_MADDRESS         ,
             iosf_prim_REQ_PRIORITY     ,
             iosf_prim_REQ_CHID         ,
             iosf_prim_REQ_TC           ,
             iosf_prim_MRS              ,
             iosf_prim_REQ_RS           ,
             iosf_prim_MSAI             ,
             iosf_prim_MSRC_ID          ,
             iosf_prim_HIT              ,
             iosf_prim_SUB_HIT          ,
             iosf_prim_CREDIT_CHID
            };

  assign {
           iosf_prim_CMD_NFS_ERR      ,
           iosf_prim_CMD_PUT          ,
           iosf_prim_GNT              ,
           iosf_prim_TBEWD            ,
           iosf_prim_TCHAIN           ,
           iosf_prim_TCPARITY         ,
           iosf_prim_TDEC             ,
           iosf_prim_TECRC_ERROR      ,
           iosf_prim_TECRC_GENERATE   ,
           iosf_prim_TEP              ,
           iosf_prim_TIDO             ,
           iosf_prim_TNS              ,
           iosf_prim_TRO              ,
           iosf_prim_TRSVD0_7         ,
           iosf_prim_TRSVD1_1         ,
           iosf_prim_TRSVD1_3         ,
           iosf_prim_TRSVD1_7         ,
           iosf_prim_TTD              ,
           iosf_prim_TTH              ,
           iosf_prim_TDBE             ,
           iosf_prim_CMD_RTYPE        ,
           iosf_prim_GNT_RTYPE        ,
           iosf_prim_GNT_TYPE         ,
           iosf_prim_OBFF             ,
           iosf_prim_TAT              ,
           iosf_prim_TFMT             ,
           iosf_prim_TRQID            ,
           iosf_prim_PRIM_ISM_FABRIC  ,
           iosf_prim_TPASIDTLP        ,
           iosf_prim_TFBE             ,
           iosf_prim_TLBE             ,
           iosf_prim_TTC              ,
           iosf_prim_TECRC            ,
           iosf_prim_TTYPE            ,
           iosf_prim_TTAG             ,
           iosf_prim_TLENGTH          ,
           iosf_prim_TCID             ,
           iosf_prim_TDEADLINE        ,
           iosf_prim_TDEST_ID         ,
           iosf_prim_GNT_CHID         ,
           iosf_prim_TRS              ,
           iosf_prim_TSAI             ,
           iosf_prim_TSRC_ID          ,
           iosf_prim_TDPARITY         ,
           iosf_prim_TDATA            ,
           iosf_prim_TADDRESS         ,
           iosf_prim_TPRIORITY        ,
           iosf_prim_CMD_CHID
            } = demux_data;

endmodule
