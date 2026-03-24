//------------------------------------------------------------------------------
//  INTEL TOP SECRET
//
//  Copyright 2018 Intel Corporation All Rights Reserved.
//
//  The source code contained or described herein and all documents related
//  to the source code ("Material") are owned by Intel Corporation or its
//  suppliers or licensors. Title to the Material remains with Intel
//  Corporation or its suppliers and licensors. The Material contains trade
//  secrets and proprietary and confidential information of Intel or its
//  suppliers and licensors. The Material is protected by worldwide copyright
//  and trade secret laws and treaty provisions. No part of the Material may
//  be used, copied, reproduced, modified, published, uploaded, posted,
//  transmitted, distributed, or disclosed in any way without Intel's prior
//  express written permission.
//
//  No license under any patent, copyright, trade secret or other intellectual
//  property right is granted to or conferred upon you by disclosure or
//  delivery of the Materials, either expressly, by implication, inducement,
//  estoppel or otherwise. Any license under such intellectual property rights
//  must be express and approved by Intel in writing.
//  Inserted by Intel DSD.
//
//------------------------------------------------------------------------------
//----------------------------------------------------------------------------//
//    Copyright 2018 Intel Corporation All Rights Reserved.
//    Intel Communication Group/ Platform Network Group / ICGh
//    Intel Proprietary
//
//       *               *     
//     (  `    (       (  `    
//     )\))(   )\ )    )\))(   
//    ((_)()\ (()/(   ((_)()\  
//    (_()((_) /(_))_ (_()((_) 
//    |  \/  |(_)) __||  \/  | 
//    | |\/| |  | (_ || |\/| | 
//    |_|  |_|   \___||_|  |_|
//
//    FILENAME          : mgm_master_1r1w_shell.v
//    DESIGNER          : Yevgeny Yankilevich
//    DATE              : 16/02/16
//    REVISION NUMBER   : 1.0
//    DESCRIPTION       :
//
//          This module serves as a general 1r1w Memory Shell
//
//---------------------------------------------------------------------------//
// --------------------------------------------------------------------------//
//      LAST MODIFICATION:      16/02/16
//      RECENT AUTHORS:         yevgeny.yankilevich@intel.com
//      PREVIOUS RELEASES:      
//                              16/02/16: First version.
// --------------------------------------------------------------------------//
`include        "hlp_mgm_mems.def"
module  hlp_mgm_master_1r1w_shell #(
        parameter       MEM_WIDTH                               = 42                                                                                                                    , // Number of Memory lines.
        parameter       MEM_DEPTH                               = 3072                                                                                                                  , // Memory line width in bits.
        parameter       MEM_WR_RESOLUTION                       = MEM_WIDTH                                                                                                             , // Write Resolution to the Memory: Should be a divisor of the MEM_WIDTH.
        parameter       MEM_WR_EN_WIDTH                         = (MEM_WIDTH/MEM_WR_RESOLUTION)                                                                                         , // Memory Write enable width. 
        parameter       MEM_CONT_BPS_MUX_TYPE                   = 0                                                                                                                     , // 0 - No MUX, 1 - New Data, 2 - Old Data             
        parameter       MEM_INIT_TYPE                           = 1                                                                                                                     , // Method of Memory Initialization: 1 - Const. Val. Init., 2 - LL, Other - No Init.
        parameter       LL_INIT_OFFSET                          = 1                                                                                                                     , //LINA CHANGE
        parameter       LL_IS_LAST                              = 1                                                                                                                     , //LINA CHANGE
        parameter       MEM_INIT_VALUE                          = MEM_WIDTH'(0)                                                                                                         , // Initialization Value: valid only when MEM_INIT_TYPE == 1.
        parameter       MEM_WR_RES_PROT_FRAGM                   = 1                                                                                                                     , // Memory Write Resolution Fragmentation for Protection.      
        parameter       MEM_PROT_TYPE                           = 0                                                                                                                     , // Memory Data Integrity Method: 0 - ECC, 1 - Parity, Other - No Protection.
        parameter       MEM_PROT_RESOLUTION                     = ((MEM_WR_RESOLUTION % MEM_WR_RES_PROT_FRAGM) != 0)  ? ((MEM_WR_RESOLUTION-(MEM_WR_RESOLUTION % MEM_WR_RES_PROT_FRAGM))/MEM_WR_RES_PROT_FRAGM) + 1 : (MEM_WR_RESOLUTION/MEM_WR_RES_PROT_FRAGM)                 , // Memory Protection Resolution in bits: Should be a divisor of MEM_WR_RESOLUTION.
        parameter       MEM_WR_RESOLUTION_ZERO_PADDING          = (MEM_PROT_RESOLUTION * MEM_WR_RES_PROT_FRAGM) - MEM_WR_RESOLUTION                                                     , // Memory Write Resolution Zero Padding.
        parameter       MEM_PROT_INTERLV_LEVEL                  = 1                                                                                                                     , // Memory Protection Bits Interleaving Level: 1 - No Interleaving, 2 - Every 2 bits (grouping of even and odd bits), 3 - Every 3 bits and Etc.
        parameter       MEM_PROT_PER_GEN_INST                   = (MEM_PROT_RESOLUTION % MEM_PROT_INTERLV_LEVEL) ? ((MEM_PROT_RESOLUTION-(MEM_PROT_RESOLUTION % MEM_PROT_INTERLV_LEVEL))/MEM_PROT_INTERLV_LEVEL) + 1 : (MEM_PROT_RESOLUTION/MEM_PROT_INTERLV_LEVEL)     , // Memory Width per protection module.
        parameter       MEM_PROT_RESOLUTION_ZERO_PADDING        = (MEM_PROT_PER_GEN_INST * MEM_PROT_INTERLV_LEVEL) - MEM_PROT_RESOLUTION                                                , // Memory Protection Resolution Zero Padding.
        parameter       MEM_TOTAL_ZERO_PADDING                  = ((MEM_PROT_RESOLUTION_ZERO_PADDING * MEM_WR_RES_PROT_FRAGM) + MEM_WR_RESOLUTION_ZERO_PADDING) * MEM_WR_EN_WIDTH       , // Memory Total Zero Padding. 
        parameter       MEM_PROT_TOTAL_GEN_INST                 = MEM_PROT_INTERLV_LEVEL * MEM_WR_RES_PROT_FRAGM * MEM_WR_EN_WIDTH                                                      , // Total number of protection modules.
        parameter       MEM_RD_DEBUG                            = 0                                                                                                                     , // Indirect Read Access Feature.
        parameter       MEM_PST_ECC_GEN_SAMPLE                  = 0                                                                                                                     , // Sample stage on the Write stage, after the ECC/PARITY generation.
        parameter       MEM_PRE_ECC_CHK_SAMPLE                  = 0                                                                                                                     , // Sample stage on the Read stage, before the ECC/PARITY generation.
        parameter       MEM_ECC_CHK_SYN_SAMPLE                  = 0                                                                                                                     , // Sample stage on the Read stage, in the ECC/PARITY, after syndrom generation.
        parameter       MEM_PST_ECC_CHK_SAMPLE                  = 0                                                                                                                     , // Sample stage on the Read stage, after the ECC/PARITY generation.
        parameter       MEM_ADR_WIDTH                           = (MEM_DEPTH>1) ? $clog2(MEM_DEPTH) : 1                                                                                 , // Memory Address bus width.
        parameter       MEM_PROT_INST_WIDTH                     = (MEM_PROT_TYPE == 0) ? $clog2(MEM_PROT_PER_GEN_INST+$clog2(MEM_PROT_PER_GEN_INST)+1)+1 : (MEM_PROT_TYPE == 1) ? 1 : 0 , // Data Integrity signature width for a single chunk of protected data.
        parameter       MEM_PROT_TOTAL_WIDTH                    = MEM_PROT_TOTAL_GEN_INST * MEM_PROT_INST_WIDTH                                                                         , // Total width of the Data Integrity signatures in Memory line.
        parameter       MEM_DBG_DW_SEL_WIDTH                    = `HLP_MEM_DBG_DW_SEL_WIDTH                                                                                                 , // Debug Read DWord Select width.
        parameter       MEM_DBG_RD_ADR_WIDTH                    = `HLP_MEM_DBG_RD_ADR_WIDTH                                                                                                 , // Debug Read Address width.
        parameter       MEM_RM_WIDTH                            = `HLP_MEM_RM_WIDTH                                                                                                         , // Read Margin Width. 
        parameter       MEM_GEN_ECC_INST_NUM                    = `HLP_MEM_GEN_ECC_INST_NUM                                                                                                 ,
        parameter       MEM_GEN_ECC_INST_NUM_WIDTH              = $clog2(MEM_GEN_ECC_INST_NUM)                                                                                          ,               
        parameter       MEM_CTL_WR_SYNC                         = 0                                                                                                                     , // Syncronize between the Shell Controller and the Memory Shells - wr_clk
        parameter       MEM_CTL_RD_SYNC                         = 0                                                                                                                     , // Syncronize between the Shell Controller and the Memory Shells - rd_clk
        parameter       MEM_MASK_RD_WR_CONTENTION               = 0                                                                                                                     , // don't fail on ECC Error on RD&WR to the same address, applicable for mems with BE only
        parameter       FROM_CTL_WIDTH                          = 9 + MEM_RM_WIDTH +  1 + MEM_DBG_RD_ADR_WIDTH + MEM_DBG_DW_SEL_WIDTH + MEM_GEN_ECC_INST_NUM_WIDTH + 2   + 1           , // FROM_CLT Bus Width.
        parameter       TO_CTL_WIDTH                            = 54                                                                                                                    , // TO_CTL Bus Width.
        parameter       FROM_MEM_WIDTH                          = MEM_WIDTH + MEM_PROT_TOTAL_WIDTH + 1                                                                                  , // FROM_MEM Bus Width.
        parameter       TO_MEM_WIDTH                            = 1 + MEM_RM_WIDTH + 1 + 1 + MEM_WR_EN_WIDTH + MEM_ADR_WIDTH + MEM_ADR_WIDTH + MEM_WIDTH*2 - MEM_PROT_TOTAL_WIDTH + MEM_PROT_TOTAL_WIDTH           // TO_MEM Bus Width.
)(
        //------------------- clock and reset -------------------
        input   logic                           rd_clk                  ,
        input   logic                           wr_clk                  ,
        input   logic                           rd_reset_n              ,
        input   logic                           wr_reset_n              ,
        input   logic                           sync_rd_reset_n         ,
        input   logic                           sync_wr_reset_n         ,
        //----------------- Functional Interface ----------------
        input   logic   [  MEM_ADR_WIDTH-1:0]   rd_adr                  ,
        input   logic   [  MEM_ADR_WIDTH-1:0]   wr_adr                  ,
        input   logic                           rd_en                   ,
        input   logic   [MEM_WR_EN_WIDTH-1:0]   wr_en                   ,
        input   logic   [      MEM_WIDTH-1:0]   wr_data                 ,
        output  logic   [      MEM_WIDTH-1:0]   rd_data                 ,
        output  logic                           rd_valid                ,
        output  logic                           init_done               ,
        //--------------------- ECC Interface -------------------
        output  logic                           ecc_cor_err             ,
        output  logic                           ecc_uncor_err           ,
        //----------------- Memory Wrap Interface ---------------
        input   logic   [FROM_MEM_WIDTH-1:0]    wrap_shell_from_mem     ,
        output  logic   [  TO_MEM_WIDTH-1:0]    wrap_shell_to_mem       ,
        //------------------- Gen CTR Interface -----------------
        input   logic   [FROM_CTL_WIDTH-1:0]    ctl_shell_to_mem        ,
        output  logic   [  TO_CTL_WIDTH-1:0]    ctl_shell_from_mem      ,
        //-------------------- Dyn Light Sleep ------------------
        input   logic                           mem_ls_enter
);


 `ifndef INTEL_SVA_OFF
    import intel_checkers_pkg::*;   
 `endif


`ifndef HLP_MGM_EMU_FPGA
  `ifdef INTEL_FPGA
     `define HLP_MGM_EMU_FPGA
  `else
     `ifdef INTEL_EMULATION
        `define HLP_MGM_EMU_FPGA
     `endif
  `endif
`endif


// `ifdef HLP_HLP_FPGA_ECC_RDC_TOTAL
//     localparam MEM_SKIP_ECC = 1; 
// `else
     localparam MEM_SKIP_ECC = 0; 
// `endif
    

//-------------------------------
//      Gen MEM Interface
//-------------------------------

typedef struct packed{
        logic                                                   reset_n         ;
        logic                                                   init_done       ;
        logic                                                   rm_e            ;
        logic   [                         MEM_RM_WIDTH-1:0]     rm              ;
        logic                                                   rd_en           ;
        logic   [                      MEM_WR_EN_WIDTH-1:0]     wr_en           ;
        logic   [                        MEM_ADR_WIDTH-1:0]     rd_adr          ;
        logic   [                        MEM_ADR_WIDTH-1:0]     wr_adr          ;
        logic   [                            MEM_WIDTH-1:0]     wr_data_orig    ;
        logic   [       MEM_WIDTH+MEM_PROT_TOTAL_WIDTH-1:0]     wr_data         ;
} to_mem_1r1w_t;

typedef struct packed{
        logic   [       MEM_WIDTH+MEM_PROT_TOTAL_WIDTH-1:0]     rd_data         ;
        logic                                                   rd_valid        ;
} from_mem_t;

to_mem_1r1w_t        to_mem_bus      ;
from_mem_t      from_mem_bus    ;

//-------------------------------
//      Gen CTL Interface
//-------------------------------

typedef struct packed{
        logic                                                   cfg_wr_ind      ;
        logic                                                   stat_rd_ind     ;       
        logic                                                   ecc_en          ;
        logic                                                   ecc_invert_1    ;
        logic                                                   ecc_invert_2    ;
        logic   [           MEM_GEN_ECC_INST_NUM_WIDTH-1:0]     gen_ecc_inst_num;
        // logic                                                   pwren_b         ; 
        logic                                                   rm_e            ;
        logic   [                         MEM_RM_WIDTH-1:0]     rm              ;
        logic                                                   ls_bypass       ;
        logic                                                   ls_force        ;
        logic                                                   dbg_wr_ind      ;
        logic                                                   dbg_rd_en       ;
        logic   [                 MEM_DBG_RD_ADR_WIDTH-1:0]     dbg_adr         ;
        logic   [                 MEM_DBG_DW_SEL_WIDTH-1:0]     dbg_dw_sel      ;

        logic                                                   tcam_check_err_dis   ;
        logic                                                   tcam_update_dis      ;


} from_ctl_t;

typedef struct packed{
        logic                                                   ecc_uncor_err   ;
        logic                                                   ecc_cor_err     ;
        logic                                                   init_done       ;
        logic   [                                   32-1:0]     dbg_rd_data     ;
        logic                                                   dbg_done        ;
        logic   [                 MEM_DBG_RD_ADR_WIDTH-1:0]     ecc_err_adr     ;
 
} to_ctl_t;

from_ctl_t      from_ctl_bus    ;
to_ctl_t        to_ctl_bus      ;

// Debug Read

reg                                     dbg_flow                        ;
reg                                     dbg_rd_en                       ;
reg     [MEM_DBG_RD_ADR_WIDTH-1:0]      dbg_adr                         ;
reg     [MEM_DBG_DW_SEL_WIDTH-1:0]      dbg_dw_sel                      ;
logic   [31:0]                          dbg_rd_data                     ;
logic                                    dbg_done                        ;

// ECC Error Address Sampling

logic   [MEM_DBG_RD_ADR_WIDTH-1:0]      ecc_err_adr                     ;

// From CTL

logic                                   mem_ecc_en_rd                   ;
logic                                   mem_ecc_en_wr                   ;
logic                                   mem_ecc_invert_1                ;
logic                                   mem_ecc_invert_2                ;
logic   [MEM_GEN_ECC_INST_NUM_WIDTH-1:0]mem_gen_ecc_inst_idx            ;
// logic                                   mem_pwren_b; 
logic                                   mem_rm_e                        ;
logic   [MEM_RM_WIDTH-1:0]              mem_rm                          ;
logic                                   mem_ls_bypass                   ;
logic                                   mem_ls_force                    ;
logic                                   dbg_rd_en_int                   ;
logic   [MEM_DBG_RD_ADR_WIDTH-1:0]      dbg_adr_int                     ;
logic   [MEM_DBG_DW_SEL_WIDTH-1:0]      dbg_dw_sel_int                  ;
logic                                   dbg_flow_no_func_acc            ;
assign                                  dbg_flow_no_func_acc    = dbg_flow && !(rd_en)                  ;
assign                                  from_ctl_bus            = ctl_shell_to_mem                      ;


reg                                             pst_prot_rd_valid       ;
wire    [                    MEM_WIDTH - 1:0]   pst_prot_rd_data        ;
wire    [                    MEM_WIDTH - 1:0]   pst_prot_non_prot_rd_data        ;
logic   [      MEM_PROT_TOTAL_GEN_INST - 1:0]   gen_inst_cor_err_int    ;
logic   [      MEM_PROT_TOTAL_GEN_INST - 1:0]   gen_inst_uncor_err_int  ;
logic   [      MEM_PROT_TOTAL_GEN_INST - 1:0]   gen_inst_cor_err        ;
logic   [      MEM_PROT_TOTAL_GEN_INST - 1:0]   gen_inst_uncor_err      ;
wire    [MEM_WR_EN_WIDTH-1:0]                   wr_rd_cont ;
wire    [MEM_WR_EN_WIDTH-1:0]                   wr_rd_cont_out;
logic                           rd_valid_int   ;
reg     [MEM_WIDTH-1:0]         rd_data_int     ;
reg     [MEM_WIDTH-1:0]         rd_data_non_prot_int     ;
wire                            dbg_rd_valid    ;

logic   [      MEM_PROT_TOTAL_GEN_INST - 1:0]   mask_gen_inst_cor_err        ;
logic   [      MEM_PROT_TOTAL_GEN_INST - 1:0]   mask_gen_inst_uncor_err      ;

reg                                             rd_en_to_mem_int        ;
reg     [               MEM_WR_EN_WIDTH-1:0]    wr_en_to_mem_int        ;
reg     [                 MEM_ADR_WIDTH-1:0]    rd_adr_to_mem_int       ;
reg     [                 MEM_ADR_WIDTH-1:0]    wr_adr_to_mem_int       ;
reg     [MEM_WIDTH+MEM_PROT_TOTAL_WIDTH-1:0]    wr_data_to_mem_int      ;

logic                                           rd_en_to_mem            ;
logic   [               MEM_WR_EN_WIDTH-1:0]    wr_en_to_mem            ;
logic   [                 MEM_ADR_WIDTH-1:0]    rd_adr_to_mem           ;
logic   [                 MEM_ADR_WIDTH-1:0]    wr_adr_to_mem           ;
logic   [MEM_WIDTH+MEM_PROT_TOTAL_WIDTH-1:0]    wr_data_to_mem          ;

logic   [MEM_WIDTH+MEM_PROT_TOTAL_WIDTH-1:0]    prot_wr_data_out;

logic                           init_done_int   ;
logic                           init_done_int_s ; 
wire    [  MEM_ADR_WIDTH-1:0]   rd_adr_mux      ;
wire    [  MEM_ADR_WIDTH-1:0]   wr_adr_mux      ;
logic    [      MEM_WIDTH-1:0]   wr_data_mux , wr_data_mux_s     ;
wire    [MEM_WR_EN_WIDTH-1:0]   wr_en_mux       ;
wire                            rd_en_mux       ;
logic     [                            32 - 1:0] dbg_rd_data_dw_full_2d[(1 << MEM_DBG_DW_SEL_WIDTH)-1:0];

generate
        if (MEM_CTL_WR_SYNC) begin: FROM_CTL_WR_SYNC
                wire                            from_ctl_bus_pre_sync;
                wire                            from_ctl_bus_pst_sync;
                assign                          from_ctl_bus_pre_sync           = from_ctl_bus.cfg_wr_ind       ;
                hlp_mgm_sync_ta2pb from_ctl_bus_sync(
                        .clkb           (wr_clk)                        , 
                        .rst_n_b        (sync_wr_reset_n)               ,
                        .toggle_in      (from_ctl_bus_pre_sync)         ,        
                        .pulse_out      (from_ctl_bus_pst_sync)
                );
                wire                               cfg_wr_ind                      ;
                assign                             cfg_wr_ind                      = from_ctl_bus_pst_sync         ;
                
                always_ff  @(posedge wr_clk or negedge wr_reset_n)
                        if (!wr_reset_n) begin
                                mem_ecc_en_wr           <= 1'b1                                 ;
                                mem_ecc_invert_1        <= 1'b0                                 ;
                                mem_ecc_invert_2        <= 1'b0                                 ;
                                mem_gen_ecc_inst_idx    <= {(MEM_GEN_ECC_INST_NUM_WIDTH){1'b0}} ;
                                mem_ls_bypass           <= 1'b1                                 ;
                                mem_ls_force            <= 1'b0                                 ;
                        end
                        else if (cfg_wr_ind) begin
                                mem_ecc_en_wr           <= from_ctl_bus.ecc_en                  ;
                                mem_ecc_invert_1        <= from_ctl_bus.ecc_invert_1            ;
                                mem_ecc_invert_2        <= from_ctl_bus.ecc_invert_2            ;
                                mem_gen_ecc_inst_idx    <= from_ctl_bus.gen_ecc_inst_num        ;
                                mem_ls_bypass           <= from_ctl_bus.ls_bypass               ;
                                mem_ls_force            <= from_ctl_bus.ls_force                ;               
                        end
        end
        else begin: NO_FROM_CTL_WR_SYNC
                assign          mem_ecc_en_wr           = from_ctl_bus.ecc_en                   ;
                assign          mem_ecc_invert_1        = from_ctl_bus.ecc_invert_1             ;
                assign          mem_ecc_invert_2        = from_ctl_bus.ecc_invert_2             ;
                assign          mem_gen_ecc_inst_idx    = from_ctl_bus.gen_ecc_inst_num         ;
                assign          mem_ls_bypass           = from_ctl_bus.ls_bypass                ;
                assign          mem_ls_force            = from_ctl_bus.ls_force                 ;
        end
endgenerate

generate
        if (MEM_CTL_RD_SYNC) begin: FROM_CTL_RD_SYNC
                wire    [2-1:0]                 from_ctl_bus_pre_sync;
                wire    [2-1:0]                 from_ctl_bus_pst_sync;
                
                assign                          from_ctl_bus_pre_sync[0]        = from_ctl_bus.cfg_wr_ind       ;
                assign                          from_ctl_bus_pre_sync[1]        = from_ctl_bus.dbg_wr_ind       ;
                hlp_mgm_sync_ta2pb #(
                        .BUS_WIDTH    (2)
                ) from_ctl_bus_sync(
                        .clkb           (rd_clk)                        , 
                        .rst_n_b        (sync_rd_reset_n)               ,
                        .toggle_in      (from_ctl_bus_pre_sync)         ,        
                        .pulse_out      (from_ctl_bus_pst_sync)
                );              
                wire                            cfg_wr_ind                     ;
                wire                            dbg_wr_ind                     ;
                assign                          cfg_wr_ind                      = from_ctl_bus_pst_sync[0]      ;
                assign                          dbg_wr_ind                      = from_ctl_bus_pst_sync[1]      ;
        
                always_ff  @(posedge rd_clk or negedge rd_reset_n)
                        if (!rd_reset_n) begin
                                mem_ecc_en_rd           <= 1'b1                                 ;
                                // mem_pwren_b             <= 1'b0 ; 
                                mem_rm_e                <= 1'b0                                 ;
                                mem_rm                  <= {{(MEM_RM_WIDTH-2){1'b0}},{2'b10}}   ;
                        end
                        else if (cfg_wr_ind) begin
                                mem_ecc_en_rd           <= from_ctl_bus.ecc_en                  ;
                                // mem_pwren_b             <= from_ctl_bus.pwren_b                 ;
                                mem_rm_e                <= from_ctl_bus.rm_e                    ;
                                mem_rm                  <= from_ctl_bus.rm                      ;
                        end
                always_ff  @(posedge rd_clk or negedge rd_reset_n)
                        if (!rd_reset_n) begin
                                dbg_rd_en_int           <= 1'b0                                 ;
                                dbg_adr_int             <= {(MEM_DBG_RD_ADR_WIDTH){1'b0}}       ;
                                dbg_dw_sel_int          <= {(MEM_DBG_DW_SEL_WIDTH){1'b0}}       ;               
                        end
                        else if (dbg_wr_ind) begin
                                dbg_rd_en_int           <= from_ctl_bus.dbg_rd_en               ;
                                dbg_adr_int             <= from_ctl_bus.dbg_adr                 ;
                                dbg_dw_sel_int          <= from_ctl_bus.dbg_dw_sel              ;               
                        end
                        else if (dbg_done) begin
                                dbg_rd_en_int           <= 1'b0                                 ;
                        end

        end
        else begin: NO_FROM_CTL_RD_SYNC
                assign          mem_ecc_en_rd           = from_ctl_bus.ecc_en                   ;
                // assign          mem_pwren_b             = from_ctl_bus.pwren_b                  ;
                assign          mem_rm_e                = from_ctl_bus.rm_e                     ;
                assign          mem_rm                  = from_ctl_bus.rm                       ;

                assign          dbg_rd_en_int                                   = from_ctl_bus.dbg_rd_en        ;
                assign          dbg_adr_int        [MEM_DBG_RD_ADR_WIDTH-1:0]   = from_ctl_bus.dbg_adr          ;
                assign          dbg_dw_sel_int     [MEM_DBG_DW_SEL_WIDTH-1:0]   = from_ctl_bus.dbg_dw_sel       ;
        end
endgenerate

// To CTL


wire                            ecc_err_occured; 

wire    [3-1:0]                 to_ctl_bus_pre_sync ;
assign                          to_ctl_bus_pre_sync     = {dbg_done, ecc_cor_err, ecc_uncor_err};
wire    [3-1:0]                 to_ctl_bus_pst_sync;
generate
        if (MEM_CTL_RD_SYNC) begin: TO_CTL_RD_SYNC
                hlp_mgm_sync_pa2ta #(
                        .BUS_WIDTH      (3)
                ) to_ctl_bus_sync(
                        .clka           (rd_clk)                ,
                        .rst_n_a        (sync_rd_reset_n)       ,
                        .pulse_in       (to_ctl_bus_pre_sync)   ,
                        .toggle_out     (to_ctl_bus_pst_sync)   
                );
        end
        else begin: NO_TO_CTL_RD_SYNC
                assign  to_ctl_bus_pst_sync = to_ctl_bus_pre_sync;
        end
endgenerate

assign                          to_ctl_bus.ecc_uncor_err        = to_ctl_bus_pst_sync[0]        ;
assign                          to_ctl_bus.ecc_cor_err          = to_ctl_bus_pst_sync[1]        ;
assign                          to_ctl_bus.init_done            = init_done                     ;
assign                          to_ctl_bus.dbg_rd_data          = dbg_rd_data                   ;
assign                          to_ctl_bus.dbg_done             = to_ctl_bus_pst_sync[2]        ;
assign                          to_ctl_bus.ecc_err_adr          = ecc_err_adr                   ;
assign                          ctl_shell_from_mem              = to_ctl_bus                    ;
assign                          ecc_err_occured  = ecc_uncor_err | ecc_cor_err; 







`ifdef INTEL_SIMONLY
    `ifndef INTEL_SVA_OFF
        logic sva_err_check_en ; 
        logic sva_err_occurred_x ; 
        logic sva_addr_exc_check_en ; 

        always_ff  @(posedge rd_reset_n)
        begin
        `ifndef HLP_FEV_APPROVE_SIM_ONLY

            if ($test$plusargs("HLP_UNC_ECC_ASSERT_DIS")) 
                sva_err_check_en = 0; 
            else
                sva_err_check_en = 1;

            if ($test$plusargs("HLP_ADDR_EXC_ASSERT_DIS")) 
                sva_addr_exc_check_en = 0; 
            else
                sva_addr_exc_check_en = 1; 
        `else
            sva_err_check_en = 1; 
            sva_addr_exc_check_en = 1; 
        `endif

        end
        
        always_comb  sva_err_occurred_x = (ecc_err_occured !== 0) ; 
              
        `ASSERTS_NEVER (ecc_err_occurred_assert, sva_err_occurred_x & sva_err_check_en, posedge rd_clk, ~rd_reset_n,
                 `ERR_MSG ("Error: ECC Error occurred when not expected on addr = %h , mem[addr] = %h",ecc_err_adr,rd_data));


       `ASSERTS_TRIGGER (illegal_wr_addr_exceed   ,  wr_en& sva_addr_exc_check_en, ~(wr_adr >= MEM_DEPTH) , posedge wr_clk, ~wr_reset_n, `ERR_MSG ( "Error write address range exceeded" ) ) ; // lintra s-2034
       `ASSERTS_TRIGGER (illegal_rd_addr_exceed   ,  rd_en& sva_addr_exc_check_en, ~(rd_adr >= MEM_DEPTH) , posedge rd_clk, ~rd_reset_n, `ERR_MSG ( "Error read  address range exceeded" ) ) ; // lintra s-2034


    `endif
 `endif



// Post Protection Read Data and Valid


//wire                            dbg_rd_valid;

reg    [4:0]    inner_ls_delay;
always_ff @(posedge wr_clk or negedge wr_reset_n)
if (!wr_reset_n)
       inner_ls_delay[4:0]   <= 5'h0;
else 
       inner_ls_delay[4:0]   <= (inner_ls_delay[4:0] == 5'h10) ? inner_ls_delay[4:0] : inner_ls_delay[4:0] + 5'h1;
wire            inner_ls_delay_comp;
assign          inner_ls_delay_comp  = inner_ls_delay[4];

generate
        if (MEM_RD_DEBUG == 1)
                begin: MEM_RD_DEBUG_LOGIC
                        always_ff   @(posedge rd_clk or negedge rd_reset_n)
                                if (!rd_reset_n) begin
                                        dbg_flow        <= 1'b0;
                                        dbg_rd_en       <= 1'b0;
                                        dbg_dw_sel      <= {(MEM_DBG_DW_SEL_WIDTH){1'b0}};
                                        dbg_adr         <= '0;
                                end
                                else if (dbg_rd_en_int && !rd_en && !dbg_flow) begin
                                        dbg_flow        <= 1'b1;
                                        dbg_rd_en       <= 1'b1;
                                        dbg_adr         <= dbg_adr_int;
                                        dbg_dw_sel      <= dbg_dw_sel_int       ;
                                end
                                else if (dbg_rd_en && rd_en) begin
                                        dbg_flow        <= 1'b0;
                                        dbg_rd_en       <= 1'b0;                                        
                                end
                                else if (dbg_rd_en && dbg_flow) begin
                                        dbg_rd_en       <= 1'b0;
                                end
                                else if (dbg_done) begin
                                        dbg_flow        <= 1'b0;
                                end
                        
                        wire    [(32*(1 << MEM_DBG_DW_SEL_WIDTH))-1:0] dbg_rd_data_dw_full  ;
//                      assign                                         dbg_rd_data_dw_full      = {{(32*(1 << MEM_DBG_DW_SEL_WIDTH) - MEM_WIDTH){1'b0}}, {rd_data_int}};
                        assign                                         dbg_rd_data_dw_full      = {{(32*(1 << MEM_DBG_DW_SEL_WIDTH) - MEM_WIDTH){1'b0}}, {rd_data_non_prot_int}};
                                                
                        
                        always_comb
                                begin
                                        for(int k = 0; k < (1 << MEM_DBG_DW_SEL_WIDTH); k = k + 1)
                                                dbg_rd_data_dw_full_2d[k]       = dbg_rd_data_dw_full[32*k+:32];
                                end
                        
                        
                        hlp_mgm_fifo #(
                                .WIDTH  (1)         ,
                                .ADD_L  (2)                     
                            ) 
                        u_dbg_rd_fifo(
                                .clk            (rd_clk)            ,
                                .rst_n          (rd_reset_n)        ,
                                .d_out          (dbg_rd_valid)      ,
                                .d_in           (dbg_rd_en & !rd_en),
                                .rd             (rd_valid_int)      ,
                                .wr             (rd_en_mux)   ,
                                .empty          ()                  ,
                                .full           ()                  ,
                                .state_cnt      ()                      
                        );


                    end
        else
                begin: NO_MEM_RD_DEBUG_LOGIC
                        always_comb
                                begin
                                        dbg_flow                        = 1'b0  ;
                                        dbg_rd_en                       = 1'b0  ;
                                        dbg_dw_sel                      = {(MEM_DBG_DW_SEL_WIDTH){1'b0}};
                                        for(int k = 0; k < (1 << MEM_DBG_DW_SEL_WIDTH); k = k + 1)
                                            dbg_rd_data_dw_full_2d[k]       = 32'b0;

                                end     

                        assign  dbg_rd_valid            = 1'b0                                                          ;

                end
endgenerate

 
//-----------------------------------
//      Function Interface MUXs
//-----------------------------------

// Initialization

generate
        if (MEM_INIT_TYPE == 1)
                begin:  CONST_MEM_INIT
                        reg     [MEM_ADR_WIDTH-1:0]     wr_aux_adr;
                        assign  wr_adr_mux      = init_done ? wr_adr    : wr_aux_adr                                                            ;
                        assign  wr_en_mux       = init_done ? wr_en     :{(MEM_WR_EN_WIDTH){inner_ls_delay_comp & !init_done_int_s}}                              ;// init_done_int_s ;
                        assign  wr_data_mux     = init_done ? wr_data   : MEM_INIT_VALUE                                                        ;
                        
                        always_ff  @(posedge wr_clk or negedge wr_reset_n) begin 
                                if (!wr_reset_n) begin
                                        wr_aux_adr      <= MEM_ADR_WIDTH'(MEM_DEPTH - 1);
                                        init_done_int   <= 1'b0;  
                                        init_done_int_s <= 1'b0; 
                                end
                                else  if (inner_ls_delay_comp) begin                                                    
                                        wr_aux_adr      <= (wr_aux_adr == {MEM_ADR_WIDTH{1'b0}}) ? {MEM_ADR_WIDTH{1'b0}} : wr_aux_adr - {{(MEM_ADR_WIDTH-1){1'b0}},1'b1};
                                        init_done_int_s   <= (wr_aux_adr  == {MEM_ADR_WIDTH{1'b0}}) || init_done_int_s; // the original is "  init_done_int   <= (wr_aux_adr == {MEM_ADR_WIDTH{1'b0}}) || init_done_int;"
                                        init_done_int <= init_done_int_s;
                                        
                                end
                        end 
                end
                
        else if (MEM_INIT_TYPE == 2)
                begin:  LL_MEM_INIT
                        reg     [MEM_ADR_WIDTH-1:0]    wr_aux_adr;
                        reg     [MEM_WIDTH-1:0]        init_value;
                        assign  wr_adr_mux      = init_done ? wr_adr    : wr_aux_adr                    ;
//  MGM fix 1305467907 = MGM bug: In 1r1w  RegFile,  wr_en is asserted right after reset deassetion, not waiting  minimum delay upon LL init
//                        assign  wr_en_mux       = init_done ? wr_en     : {(MEM_WR_EN_WIDTH){1'b1}}     ;
                        assign  wr_en_mux       = init_done ? wr_en     :{(MEM_WR_EN_WIDTH){inner_ls_delay_comp & !init_done_int_s}}     ;//init_done_int_s;//this is the original
                        assign  wr_data_mux     = init_done ? wr_data   : init_value; 

                        always_ff  @(posedge wr_clk or negedge wr_reset_n) begin
                                if (!wr_reset_n) begin
                                        wr_aux_adr      <= MEM_ADR_WIDTH'(MEM_DEPTH - 1);
                                        init_done_int   <= 1'b0;
                                        init_done_int_s <= 1'b0;
                                        init_value      <= (LL_IS_LAST==1'b1) ? {MEM_WIDTH{1'b0}} : MEM_WIDTH'(MEM_DEPTH+LL_INIT_OFFSET-1) ; 
                                end
                                else  if (inner_ls_delay_comp) begin
                                        wr_aux_adr      <= (wr_aux_adr == {MEM_ADR_WIDTH{1'b0}}) ? {MEM_ADR_WIDTH{1'b0}} : wr_aux_adr - {{(MEM_ADR_WIDTH-1){1'b0}},1'b1};
                                        init_done_int_s   <= (wr_aux_adr == {MEM_ADR_WIDTH{1'b0}}) || init_done_int_s;  // the original is "  init_done_int   <= (wr_aux_adr == {MEM_ADR_WIDTH{1'b0}}) || init_done_int;"                                      
                                        init_done_int <= init_done_int_s;
                                        init_value      <=  MEM_WIDTH'(wr_aux_adr + LL_INIT_OFFSET - 1);
                                end
                        end 
                end            
                
        else 
                begin:  NO_MEM_INIT
                        assign  wr_adr_mux      = wr_adr        ;
                        assign  wr_en_mux       = wr_en         ;
                        assign  wr_data_mux     = wr_data       ;

                        always_comb
                                init_done_int   = inner_ls_delay_comp;
                end
endgenerate

`ifdef INTEL_SIMONLY
//         `ifdef INTEL_DC
//                 "ERROR, do not use this code for DC"
//         `endif
    `ifndef HLP_FEV_APPROVE_SIM_ONLY
        assign init_done = ($test$plusargs("HLP_FAST_CONFIG")) ? inner_ls_delay_comp : init_done_int;
    `else
        assign init_done = init_done_int;
    `endif
`else
        assign init_done = init_done_int;
`endif

generate
        if (MEM_RD_DEBUG == 1)
                begin: MEM_RD_DEBUG_MODE
                        assign  rd_en_mux       = dbg_flow_no_func_acc ? dbg_rd_en                      : rd_en ;
                        assign  rd_adr_mux      = dbg_flow_no_func_acc ? dbg_adr[MEM_ADR_WIDTH-1:0]     : rd_adr;
                end
        else
                begin: NO_DEBUG_RD_MODE
                        assign  rd_en_mux       = rd_en ;
                        assign  rd_adr_mux      = rd_adr;
                end
endgenerate
//-------------------------------
//     PROTECTION GENERATION
//-------------------------------
genvar gen_ecc_inst_wr;
generate
        if (((MEM_PROT_TYPE == 0) || (MEM_PROT_TYPE == 1)) & (MEM_SKIP_ECC == 0))
                begin: GENERATE_PROT
                        wire    mem_ecc_wr_compute;
                        assign  mem_ecc_wr_compute      = mem_ecc_en_wr & ~(|wr_en_mux)         ;
                        logic   [MEM_WIDTH + (MEM_WR_RESOLUTION_ZERO_PADDING * MEM_WR_EN_WIDTH) - 1:0]  wr_data_for_prot_full_int                               ;
                        logic   [MEM_WIDTH + MEM_TOTAL_ZERO_PADDING - 1:0]                              wr_data_for_prot_full                                   ;
                        logic   [MEM_PROT_PER_GEN_INST-1:0]                                             wr_data_for_prot_interlv[MEM_PROT_TOTAL_GEN_INST-1:0]   ;
                        logic   [MEM_PROT_PER_GEN_INST-1:0]                     wr_data_pst_prot_interlv[MEM_PROT_TOTAL_GEN_INST-1:0]                           ;
                        logic   [MEM_PROT_INST_WIDTH-1:0]                       wr_data_pst_prot_sign[MEM_PROT_TOTAL_GEN_INST-1:0]                              ;
                        logic   [MEM_WIDTH + MEM_TOTAL_ZERO_PADDING - 1:0]      wr_data_pst_prot_full                                                           ;
                        logic   [MEM_PROT_TOTAL_GEN_INST-1:0]                   mem_gen_ecc_inst_invert_1                                                       ;
                        logic   [MEM_PROT_TOTAL_GEN_INST-1:0]                   mem_gen_ecc_inst_invert_2                                                       ;

                        // Zero Padding before protection
                        always_comb begin
                                wr_data_for_prot_full_int[MEM_WIDTH + (MEM_WR_RESOLUTION_ZERO_PADDING * MEM_WR_EN_WIDTH) - 1:0]                 = {(MEM_WIDTH + (MEM_WR_RESOLUTION_ZERO_PADDING * MEM_WR_EN_WIDTH)){1'b0}}      ;
                                for (int i=0; i<MEM_WR_EN_WIDTH; i=i+1) begin
                                        wr_data_for_prot_full_int[i*(MEM_WR_RESOLUTION + MEM_WR_RESOLUTION_ZERO_PADDING)+:MEM_WR_RESOLUTION]    = wr_data_mux[i*(MEM_WR_RESOLUTION)+:MEM_WR_RESOLUTION]                         ;
                                end
                        end
                        always_comb begin
                                wr_data_for_prot_full[MEM_WIDTH + MEM_TOTAL_ZERO_PADDING - 1:0]                                                 = {(MEM_WIDTH + MEM_TOTAL_ZERO_PADDING){1'b0}}                                  ;
                                for (int i=0; i < (MEM_WR_RES_PROT_FRAGM * MEM_WR_EN_WIDTH); i=i+1) begin
                                        wr_data_for_prot_full[i*(MEM_PROT_RESOLUTION + MEM_PROT_RESOLUTION_ZERO_PADDING)+:MEM_PROT_RESOLUTION]  = wr_data_for_prot_full_int[i*(MEM_PROT_RESOLUTION)+:MEM_PROT_RESOLUTION]       ;
                                end
                        end

                        // Interleaving
                        always_comb begin
                                for (int i=0; i < (MEM_WR_EN_WIDTH * MEM_WR_RES_PROT_FRAGM); i=i+1) begin
                                        for (int j=0; j<MEM_PROT_INTERLV_LEVEL; j=j+1) begin
                                                for (int k=0; k<MEM_PROT_PER_GEN_INST; k=k+1) begin
                                                        wr_data_for_prot_interlv[i*(MEM_PROT_INTERLV_LEVEL)+j][k]       = wr_data_for_prot_full[i*(MEM_PROT_RESOLUTION+MEM_PROT_RESOLUTION_ZERO_PADDING)+k*(MEM_PROT_INTERLV_LEVEL)+j]                          ;
                                                end
                                        end
                                end
                        end

                        always_comb begin
                                for (int i = 0; i<MEM_PROT_TOTAL_GEN_INST; i=i+1) begin
                                        mem_gen_ecc_inst_invert_1[i] = (mem_gen_ecc_inst_idx[MEM_GEN_ECC_INST_NUM_WIDTH-1:0] == i) && mem_ecc_invert_1;
                                        mem_gen_ecc_inst_invert_2[i] = (mem_gen_ecc_inst_idx[MEM_GEN_ECC_INST_NUM_WIDTH-1:0] == i) && mem_ecc_invert_2;
                                end
                        end
                
                        for (gen_ecc_inst_wr = 0; gen_ecc_inst_wr < MEM_PROT_TOTAL_GEN_INST; gen_ecc_inst_wr++) begin: ECC_COMPUTE_WR
                                                                
                                        hlp_mgm_ecc_compute #(
                                                                .ECC_WDTH_DATA          (MEM_PROT_PER_GEN_INST)         ,
                                                                .ECC_WDTH_CHK           (MEM_PROT_INST_WIDTH)           ,
                                                                .PARITY_ECC_N           (MEM_PROT_TYPE[0])              ,
                                                                .PAR_RES                (MEM_PROT_PER_GEN_INST)         ,
                                                                .SAMPLE_SYND            (1'b0)                          ,
                                                                .ECC_SAMPLE_EN_PARAM    (1'b0)
                                        ) ecc_compute_wr(
                                                .clk                    (wr_clk)                                                                                                                        ,
                                                .reset_n                (wr_reset_n)                                                                                                                    ,
                                                .ecc_en                 (mem_ecc_wr_compute)                                                                                                            ,
                                                .ecc_invert_1           (mem_gen_ecc_inst_invert_1[gen_ecc_inst_wr])                                                                                    ,
                                                .ecc_invert_2           (mem_gen_ecc_inst_invert_2[gen_ecc_inst_wr])                                                                                    ,
                                                .correct_en             (1'b0)                                                                                                                          ,
                                                .data_in                (wr_data_for_prot_interlv[gen_ecc_inst_wr][MEM_PROT_PER_GEN_INST-1:0])                                                          ,
                                                .check_in               ({(MEM_PROT_INST_WIDTH){1'b0}})                                                                                                 ,
                                                .data_out               (wr_data_pst_prot_interlv[gen_ecc_inst_wr][MEM_PROT_PER_GEN_INST-1:0])                                                          ,
                                                .check_out              (wr_data_pst_prot_sign[gen_ecc_inst_wr][MEM_PROT_INST_WIDTH-1:0])                                                               ,
                                                .correctable_error      () , // lintra s-60024b
                                                .uncorrectable_error    () , // lintra s-60024b
                                                .syndrome               () , // lintra s-60024b
                                                .ecc_sample_en          (1'b0)
                                        );
                        end
                        // Creating post protection write data (without signature)
                        always_comb begin
                                for (int i=0; i < (MEM_WR_EN_WIDTH * MEM_WR_RES_PROT_FRAGM); i=i+1) begin
                                        for (int j=0; j<MEM_PROT_INTERLV_LEVEL; j=j+1) begin
                                                for (int k=0; k<MEM_PROT_PER_GEN_INST; k=k+1) begin
                                                        wr_data_pst_prot_full[i*(MEM_PROT_RESOLUTION+MEM_PROT_RESOLUTION_ZERO_PADDING)+k*(MEM_PROT_INTERLV_LEVEL)+j]    = wr_data_pst_prot_interlv[i*(MEM_PROT_INTERLV_LEVEL)+j][k]     ;
                                                end
                                        end
                                end
                        end
                        // Getting rid of the protection resolution zero padding
                        logic   [MEM_WIDTH + (MEM_WR_RESOLUTION_ZERO_PADDING * MEM_WR_EN_WIDTH) - 1:0]  wr_data_pst_prot_int    ;
                        always_comb begin
                                for (int i=0; i < (MEM_WR_RES_PROT_FRAGM * MEM_WR_EN_WIDTH); i=i+1) begin
                                        wr_data_pst_prot_int[i*(MEM_PROT_RESOLUTION)+:MEM_PROT_RESOLUTION]      = wr_data_pst_prot_full[i*(MEM_PROT_RESOLUTION + MEM_PROT_RESOLUTION_ZERO_PADDING)+:MEM_PROT_RESOLUTION]        ;
                                end
                        end
                        // Getting rid of the write resolution zero padding
                        logic   [MEM_WIDTH-1:0] wr_data_pst_prot        ;
                        always_comb begin
                                for (int i=0; i<MEM_WR_EN_WIDTH; i=i+1) begin
                                        wr_data_pst_prot[i*(MEM_WR_RESOLUTION)+:MEM_WR_RESOLUTION]              = wr_data_pst_prot_int[i*(MEM_WR_RESOLUTION + MEM_WR_RESOLUTION_ZERO_PADDING)+:MEM_WR_RESOLUTION]               ;
                                end
                        end
                        // Combinning the write data together with the signature
                        always_comb begin
                                for (int i=0; i<MEM_WR_EN_WIDTH; i=i+1) begin
                                        prot_wr_data_out[i*(MEM_WR_RESOLUTION+(MEM_PROT_INST_WIDTH*MEM_PROT_INTERLV_LEVEL*MEM_WR_RES_PROT_FRAGM))+:MEM_WR_RESOLUTION]                                   =wr_data_pst_prot[i*(MEM_WR_RESOLUTION)+:MEM_WR_RESOLUTION]                                             ;
                                        for (int j=0; j < (MEM_PROT_INTERLV_LEVEL * MEM_WR_RES_PROT_FRAGM); j=j+1) begin
                                                prot_wr_data_out[i*(MEM_WR_RESOLUTION+(MEM_PROT_INST_WIDTH*MEM_PROT_INTERLV_LEVEL*MEM_WR_RES_PROT_FRAGM))+MEM_WR_RESOLUTION+j*MEM_PROT_INST_WIDTH+:MEM_PROT_INST_WIDTH] = wr_data_pst_prot_sign[i*(MEM_PROT_INTERLV_LEVEL*MEM_WR_RES_PROT_FRAGM) + j][MEM_PROT_INST_WIDTH-1:0]  ;
                                        end
                                end
                           
                           //HSD 1306304740	MGM Memories for  INTEL_EMULATION  should  be without ECC
                           `ifdef HLP_MGM_EMU_FPGA
                              prot_wr_data_out        = wr_data_mux;
                           `endif

                        end
                

                end
        else
                begin: NO_PROTECTION
                        assign  prot_wr_data_out        = wr_data_mux;
                end
endgenerate

// Sample

generate
        if (MEM_PST_ECC_GEN_SAMPLE == 1) begin: PST_ECC_GEN_SAMPLE
                always_ff   @(posedge wr_clk or negedge wr_reset_n)
                        if (!wr_reset_n)        begin
                                wr_en_to_mem_int                <= {(MEM_WR_EN_WIDTH){1'b0}}    ;
                        end
                        else begin
                                wr_en_to_mem_int                <= wr_en_mux                    ;
                        end

                always_ff   @(posedge wr_clk) begin
                        wr_data_to_mem_int      <= prot_wr_data_out                             ;
                        wr_adr_to_mem_int       <= wr_adr_mux                                   ;
                        wr_data_mux_s           <= wr_data_mux                                   ;
               end

                assign  to_mem_bus.wr_data_orig = wr_data_mux_s ;

                always_ff   @(posedge rd_clk or negedge rd_reset_n)
                        if (!rd_reset_n)        begin
                                rd_en_to_mem_int                <= 1'b0                         ;                                       
                        end
                        else begin
                                rd_en_to_mem_int                <= rd_en_mux                    ;
                        end
                        
                always_ff   @(posedge rd_clk) begin
                        rd_adr_to_mem_int       <= rd_adr_mux                                   ;
                end
        end//PST_ECC_GEN_SAMPLE
        else if (MEM_PST_ECC_GEN_SAMPLE == 2) begin: PST_ECC_GEN_SAMPLE_CLKG
                always_ff   @(posedge wr_clk or negedge wr_reset_n)
                        if (!wr_reset_n)        begin
                                wr_en_to_mem_int                <= {(MEM_WR_EN_WIDTH){1'b0}}    ;
                        end
                        else begin
                                wr_en_to_mem_int                <= wr_en_mux                    ;
                        end

                always_ff   @(posedge wr_clk or negedge wr_reset_n) 
                        if (!wr_reset_n)   begin
                            wr_adr_to_mem_int  <= {(MEM_ADR_WIDTH){1'b0}};
                            wr_data_to_mem_int  <= {(MEM_WIDTH+MEM_PROT_TOTAL_WIDTH){1'b0}};                                  
                            wr_data_mux_s           <= 0                                   ;
                         end
                        else if (|wr_en_mux) begin
                                wr_data_to_mem_int      <= prot_wr_data_out                     ;
                                wr_adr_to_mem_int       <= wr_adr_mux                           ;
                                wr_data_mux_s           <= wr_data_mux                                   ;
                        end
                assign  to_mem_bus.wr_data_orig = wr_data_mux_s ;

                always_ff   @(posedge rd_clk or negedge rd_reset_n)
                        if (!rd_reset_n)        begin
                                rd_en_to_mem_int                <= 1'b0                         ;                                       
                        end
                        else begin
                                rd_en_to_mem_int                <= rd_en_mux                    ;
                        end
                        
                always_ff   @(posedge rd_clk or negedge rd_reset_n)
                        if (!rd_reset_n)   begin
                            rd_adr_to_mem_int  <= {(MEM_ADR_WIDTH){1'b0}};                               
                        end
                        else if (rd_en_mux) begin
                                rd_adr_to_mem_int       <= rd_adr_mux                           ;
                        end
        end//PST_ECC_GEN_SAMPLE_CLKG
        else begin: NO_PST_ECC_GEN_SAMPLE
                always_comb begin
                        rd_adr_to_mem_int       = rd_adr_mux                                    ;
                        wr_adr_to_mem_int       = wr_adr_mux                                    ;
                        wr_data_to_mem_int      = prot_wr_data_out                              ;
                        wr_en_to_mem_int        = wr_en_mux                                     ;
                        rd_en_to_mem_int        = rd_en_mux                                     ;
                end
               assign  to_mem_bus.wr_data_orig = wr_data_mux;
       end//PST_ECC_GEN_SAMPLE
endgenerate

//-------------------------------
//     TO_MEM Bus Assembly
//-------------------------------
`ifdef INTEL_SIMONLY
//         `ifdef INTEL_DC
//                 "ERROR, do not use this code for DC"
//         `endif
     `ifndef HLP_FEV_APPROVE_SIM_ONLY
        assign to_mem_bus.reset_n = ($test$plusargs("HLP_FAST_CONFIG")) ? wr_reset_n : 1'b0;
     `else
        assign to_mem_bus.reset_n = 1'b0;
     `endif
`else
        assign to_mem_bus.reset_n = 1'b0;
`endif
        assign  to_mem_bus.init_done    = init_done   ;

//        assign  to_mem_bus.pwren_b      = mem_pwren_b     ;
        assign  to_mem_bus.rm_e         = mem_rm_e      ;
        assign  to_mem_bus.rm           = mem_rm        ;
        assign  to_mem_bus.rd_en        = rd_en_to_mem  ;
        assign  to_mem_bus.wr_en        = wr_en_to_mem  ;
        assign  to_mem_bus.rd_adr       = rd_adr_to_mem ;
        assign  to_mem_bus.wr_adr       = wr_adr_to_mem ;



        assign  to_mem_bus.wr_data      = wr_data_to_mem;
        assign  wrap_shell_to_mem       = to_mem_bus    ;

//-------------------------------
//   FROM_MEM Bus Disassembly
//-------------------------------
assign                                          from_mem_bus            = wrap_shell_from_mem   ;
wire                                            wrap_shell_rd_valid_int                         ;
assign                                          wrap_shell_rd_valid_int = from_mem_bus.rd_valid ;
wire    [MEM_WIDTH+MEM_PROT_TOTAL_WIDTH-1:0]    wrap_shell_rd_data_int ;
assign                                          wrap_shell_rd_data_int  = from_mem_bus.rd_data  ;
logic                                           wrap_shell_rd_valid;
logic   [MEM_WIDTH+MEM_PROT_TOTAL_WIDTH-1:0]    wrap_shell_rd_data;
logic                                           cont_bps_rd_valid;

reg                                             pre_prot_rd_valid       ;
reg     [MEM_WIDTH+MEM_PROT_TOTAL_WIDTH-1:0]    pre_prot_rd_data        ;
reg                                             rd_valid_fw             ;

always_ff  @(posedge rd_clk or negedge rd_reset_n)
        if (!rd_reset_n) begin
                rd_valid_fw     <= 1'b0                                 ;
        end
        else begin
                rd_valid_fw     <= rd_en_to_mem ? rd_en_to_mem : rd_valid_fw    ;
        end

generate
        if (MEM_PRE_ECC_CHK_SAMPLE == 1) 
                begin: PRE_ECC_CHK_SAMPLE
                        always_ff   @(posedge rd_clk or negedge rd_reset_n)
                                if (!rd_reset_n) begin
                                        pre_prot_rd_valid       <= 1'b0                                                         ;
                                end
                                else begin
                                        pre_prot_rd_valid       <= (wrap_shell_rd_valid & rd_valid_fw) || cont_bps_rd_valid     ;
                                end

                        always_ff   @(posedge rd_clk) begin
                                pre_prot_rd_data        <= wrap_shell_rd_data                           ;
                        end
                end
        else if (MEM_PRE_ECC_CHK_SAMPLE == 2)
                begin: MEM_PRE_ECC_CHK_SAMPLE_CLKG
                        always_ff  @(posedge rd_clk or negedge rd_reset_n)
                                if (!rd_reset_n) begin
                                        pre_prot_rd_valid       <= 1'b0                                                         ;
                                end
                                else begin
                                        pre_prot_rd_valid       <= (wrap_shell_rd_valid & rd_valid_fw)  || cont_bps_rd_valid    ;
                                end

                        always_ff  @(posedge rd_clk) begin
                                if ((wrap_shell_rd_valid & rd_valid_fw) || cont_bps_rd_valid)
                                        pre_prot_rd_data        <= wrap_shell_rd_data                   ;
                        end
                end
        else
                begin: NO_PRE_ECC_CHK_SAMPLE
                        always_comb
                                begin
                                        pre_prot_rd_data        = wrap_shell_rd_data                                                    ;
                                        pre_prot_rd_valid       = (wrap_shell_rd_valid & rd_valid_fw) || cont_bps_rd_valid              ;
                                end
                end
endgenerate

//-------------------------------
//      PROTECTION CHECKING      
//-------------------------------

always_comb begin
    for (int i=0; i<MEM_PROT_TOTAL_GEN_INST; i=i+1) begin
        mask_gen_inst_cor_err[i] = gen_inst_cor_err[i]     & !wr_rd_cont_out[i/(MEM_PROT_INTERLV_LEVEL * MEM_WR_RES_PROT_FRAGM)] & rd_valid ; 
        mask_gen_inst_uncor_err[i] = gen_inst_uncor_err[i] & !wr_rd_cont_out[i/(MEM_PROT_INTERLV_LEVEL * MEM_WR_RES_PROT_FRAGM)] & rd_valid ;
    end
end



 `ifndef HLP_MGM_EMU_FPGA
    assign  ecc_cor_err     = MEM_MASK_RD_WR_CONTENTION  ? |(mask_gen_inst_cor_err)   :
                                           (|gen_inst_cor_err)                        && rd_valid      ;

    assign  ecc_uncor_err   = MEM_MASK_RD_WR_CONTENTION  ? |(mask_gen_inst_uncor_err)   :
                                            (|gen_inst_uncor_err)                     && rd_valid              ;
  
 `else

    assign  ecc_cor_err     = 0  ;
    assign  ecc_uncor_err   = 0  ;
          
 `endif

                     

genvar gen_ecc_inst_rd;
generate
        if (((MEM_PROT_TYPE == 0) || (MEM_PROT_TYPE == 1)) & (MEM_SKIP_ECC == 0))
                begin: CHECK_PROT
                        logic   [MEM_WIDTH-1:0]                                                         rd_data_pre_prot_no_sign                                ;
                        logic   [MEM_WIDTH + (MEM_WR_RESOLUTION_ZERO_PADDING * MEM_WR_EN_WIDTH) - 1:0]  rd_data_pre_prot_full_int                               ;
                        logic   [MEM_WIDTH + MEM_TOTAL_ZERO_PADDING - 1:0]                              rd_data_pre_prot_full                                   ;
                        logic   [MEM_PROT_PER_GEN_INST-1:0]                                             rd_data_pre_prot_interlv[MEM_PROT_TOTAL_GEN_INST-1:0]   ;
                        logic   [MEM_PROT_INST_WIDTH-1:0]                                               rd_data_pre_prot_sign[MEM_PROT_TOTAL_GEN_INST-1:0]      ;
                        logic   [MEM_PROT_PER_GEN_INST-1:0]                                             rd_data_pst_prot_interlv[MEM_PROT_TOTAL_GEN_INST-1:0]   ;
                
                        // Separating the Signature from the rd_data
                        always_comb begin
                                for (int i=0; i<MEM_WR_EN_WIDTH; i=i+1) begin
                                        rd_data_pre_prot_no_sign[i*(MEM_WR_RESOLUTION)+:MEM_WR_RESOLUTION]                                              = pre_prot_rd_data[i*(MEM_WR_RESOLUTION+(MEM_PROT_INST_WIDTH*MEM_PROT_INTERLV_LEVEL*MEM_WR_RES_PROT_FRAGM))+:MEM_WR_RESOLUTION]                                                 ;
                                        for (int j=0; j < (MEM_PROT_INTERLV_LEVEL * MEM_WR_RES_PROT_FRAGM); j=j+1) begin
                                                rd_data_pre_prot_sign[i*(MEM_PROT_INTERLV_LEVEL*MEM_WR_RES_PROT_FRAGM)+j][MEM_PROT_INST_WIDTH-1:0]      = pre_prot_rd_data[i*(MEM_WR_RESOLUTION+(MEM_PROT_INST_WIDTH*MEM_PROT_INTERLV_LEVEL*MEM_WR_RES_PROT_FRAGM))+MEM_WR_RESOLUTION+j*MEM_PROT_INST_WIDTH+:MEM_PROT_INST_WIDTH]       ;
                                        end
                                end
                        end

                        // Zero Padding before protection
                        always_comb begin
                                rd_data_pre_prot_full_int[MEM_WIDTH + (MEM_WR_RESOLUTION_ZERO_PADDING * MEM_WR_EN_WIDTH) - 1:0]                 = {(MEM_WIDTH + (MEM_WR_RESOLUTION_ZERO_PADDING * MEM_WR_EN_WIDTH)){1'b0}}      ;
                                for (int i=0; i<MEM_WR_EN_WIDTH; i=i+1) begin
                                        rd_data_pre_prot_full_int[i*(MEM_WR_RESOLUTION + MEM_WR_RESOLUTION_ZERO_PADDING)+:MEM_WR_RESOLUTION]    = rd_data_pre_prot_no_sign[i*(MEM_WR_RESOLUTION)+:MEM_WR_RESOLUTION]            ;
                                end
                        end
                        always_comb begin
                                rd_data_pre_prot_full[MEM_WIDTH + MEM_TOTAL_ZERO_PADDING - 1:0]                                                 = {(MEM_WIDTH + MEM_TOTAL_ZERO_PADDING){1'b0}}                                  ;
                                for (int i=0; i < (MEM_WR_RES_PROT_FRAGM * MEM_WR_EN_WIDTH); i=i+1) begin
                                        rd_data_pre_prot_full[i*(MEM_PROT_RESOLUTION + MEM_PROT_RESOLUTION_ZERO_PADDING)+:MEM_PROT_RESOLUTION]  = rd_data_pre_prot_full_int[i*(MEM_PROT_RESOLUTION)+:MEM_PROT_RESOLUTION]       ;
                                end
                        end

                        // Interleaving
                        always_comb begin
                                for (int i=0; i < (MEM_WR_EN_WIDTH * MEM_WR_RES_PROT_FRAGM); i=i+1) begin
                                        for (int j=0; j<MEM_PROT_INTERLV_LEVEL; j=j+1) begin
                                                for (int k=0; k<MEM_PROT_PER_GEN_INST; k=k+1) begin
                                                        rd_data_pre_prot_interlv[i*(MEM_PROT_INTERLV_LEVEL)+j][k]       = rd_data_pre_prot_full[i*(MEM_PROT_RESOLUTION+MEM_PROT_RESOLUTION_ZERO_PADDING)+k*(MEM_PROT_INTERLV_LEVEL)+j]                          ;
                                                end
                                        end
                                end                             
                        end

                        for (gen_ecc_inst_rd = 0; gen_ecc_inst_rd < MEM_PROT_TOTAL_GEN_INST; gen_ecc_inst_rd++)
                                begin: ECC_COMPUTE_RD
                                        hlp_mgm_ecc_compute #(
                                                                .ECC_WDTH_DATA          (MEM_PROT_PER_GEN_INST)         ,
                                                                .ECC_WDTH_CHK           (MEM_PROT_INST_WIDTH)           ,
                                                                .PARITY_ECC_N           (MEM_PROT_TYPE[0])              ,
                                                                .PAR_RES                (MEM_PROT_PER_GEN_INST)         ,
                                                                .SAMPLE_SYND            (MEM_ECC_CHK_SYN_SAMPLE)        ,
                                                                .ECC_SAMPLE_EN_PARAM    (1'b0)
                                        ) ecc_compute_rd(
                                                .clk                    (rd_clk)                                                                                                                ,
                                                .reset_n                (rd_reset_n)                                                                                                            ,
                                                .ecc_en                 (1'b1)                                                                                                                  ,
                                                .ecc_invert_1           (1'b0)                                                                                                                  ,
                                                .ecc_invert_2           (1'b0)                                                                                                                  ,
                                                .correct_en             (mem_ecc_en_rd)                                                                                                         ,
                                                .data_in                (rd_data_pre_prot_interlv[gen_ecc_inst_rd][MEM_PROT_PER_GEN_INST-1:0])          ,
                                                .check_in               (rd_data_pre_prot_sign[gen_ecc_inst_rd][MEM_PROT_INST_WIDTH-1:0])               ,
                                                .data_out               (rd_data_pst_prot_interlv[gen_ecc_inst_rd][MEM_PROT_PER_GEN_INST-1:0])                                                  ,
                                                .check_out              ()                                                                                                                      ,
                                                .correctable_error      (gen_inst_cor_err_int[gen_ecc_inst_rd])                                                                                                 ,
                                                .uncorrectable_error    (gen_inst_uncor_err_int[gen_ecc_inst_rd])                                                                                                       ,
                                                .syndrome               ()                                                                                                                      ,
                                                .ecc_sample_en          (1'b0)
                                        );
                                end
                                // Creating post protection read data (without signature)
                                logic   [MEM_WIDTH + MEM_TOTAL_ZERO_PADDING - 1:0]              rd_data_pst_prot_full                   ;       
                                logic   [MEM_WIDTH + MEM_TOTAL_ZERO_PADDING - 1:0]              rd_data_pst_prot_non_prot_full                   ;       
                                always_comb begin
                                        for (int i=0; i < (MEM_WR_EN_WIDTH * MEM_WR_RES_PROT_FRAGM); i=i+1) begin
                                                for (int j=0; j<MEM_PROT_INTERLV_LEVEL; j=j+1) begin
                                                        for (int k=0; k<MEM_PROT_PER_GEN_INST; k=k+1) begin
                                                                rd_data_pst_prot_full         [i*(MEM_PROT_RESOLUTION+MEM_PROT_RESOLUTION_ZERO_PADDING)+k*(MEM_PROT_INTERLV_LEVEL)+j]    = rd_data_pst_prot_interlv[i*(MEM_PROT_INTERLV_LEVEL)+j][k]     ;
																rd_data_pst_prot_non_prot_full[i*(MEM_PROT_RESOLUTION+MEM_PROT_RESOLUTION_ZERO_PADDING)+k*(MEM_PROT_INTERLV_LEVEL)+j]    = rd_data_pre_prot_interlv[i*(MEM_PROT_INTERLV_LEVEL)+j][k]     ;                                                      
                                                      end
                                                end
                                        end
                                end
                                // Getting rid of the protection resolution zero padding
                                logic   [MEM_WIDTH + (MEM_WR_RESOLUTION_ZERO_PADDING * MEM_WR_EN_WIDTH) - 1:0]  rd_data_pst_prot_int    ;
                                logic   [MEM_WIDTH + (MEM_WR_RESOLUTION_ZERO_PADDING * MEM_WR_EN_WIDTH) - 1:0]  rd_data_pst_prot_non_prot_int    ;
                                always_comb begin
                                        for (int i=0; i < (MEM_WR_RES_PROT_FRAGM * MEM_WR_EN_WIDTH); i=i+1) begin
                                                rd_data_pst_prot_int[i*(MEM_PROT_RESOLUTION)+:MEM_PROT_RESOLUTION]      = rd_data_pst_prot_full[i*(MEM_PROT_RESOLUTION + MEM_PROT_RESOLUTION_ZERO_PADDING)+:MEM_PROT_RESOLUTION]        ;
                                                rd_data_pst_prot_non_prot_int[i*(MEM_PROT_RESOLUTION)+:MEM_PROT_RESOLUTION]      = rd_data_pst_prot_non_prot_full[i*(MEM_PROT_RESOLUTION + MEM_PROT_RESOLUTION_ZERO_PADDING)+:MEM_PROT_RESOLUTION]        ;

                                        end
                                end
                                // Getting rid of the write resolution zero padding
                                logic   [MEM_WIDTH-1:0] rd_data_pst_prot        ;
                                logic   [MEM_WIDTH-1:0] rd_data_pst_prot_non_prot        ;
                                always_comb begin
                                        for (int i=0; i<MEM_WR_EN_WIDTH; i=i+1) begin
                                                rd_data_pst_prot[i*(MEM_WR_RESOLUTION)+:MEM_WR_RESOLUTION]              = rd_data_pst_prot_int[i*(MEM_WR_RESOLUTION + MEM_WR_RESOLUTION_ZERO_PADDING)+:MEM_WR_RESOLUTION]               ;
                                                rd_data_pst_prot_non_prot[i*(MEM_WR_RESOLUTION)+:MEM_WR_RESOLUTION]     = rd_data_pst_prot_non_prot_int[i*(MEM_WR_RESOLUTION + MEM_WR_RESOLUTION_ZERO_PADDING)+:MEM_WR_RESOLUTION]               ;
                                        end
                                end
                                
                               // assign  pst_prot_rd_data        = rd_data_pst_prot;


                                //HSD 1306304740	MGM Memories for  INTEL_EMULATION  should  be without ECC
                                `ifndef HLP_MGM_EMU_FPGA
                                     assign  pst_prot_rd_data        = rd_data_pst_prot;
                                     assign  pst_prot_non_prot_rd_data   = rd_data_pst_prot_non_prot;
                                `else
                                     assign  pst_prot_rd_data        = pre_prot_rd_data[MEM_WIDTH-1:0];
                                     assign  pst_prot_non_prot_rd_data   = pre_prot_rd_data[MEM_WIDTH-1:0];
                                `endif

                end
        else
                begin: NO_CHECK
                        assign  pst_prot_rd_data        = pre_prot_rd_data;
                        assign  pst_prot_non_prot_rd_data  = pre_prot_rd_data;
                        assign  gen_inst_cor_err_int    = {(MEM_WIDTH/MEM_PROT_RESOLUTION){1'b0}};
                        assign  gen_inst_uncor_err_int  = {(MEM_WIDTH/MEM_PROT_RESOLUTION){1'b0}};
                end
endgenerate

generate
        if (MEM_ECC_CHK_SYN_SAMPLE == 1) begin: ECC_CHK_SYN_SAMPLE
                always_ff   @(posedge rd_clk or negedge rd_reset_n)
                        if (!rd_reset_n)
                                pst_prot_rd_valid       <= 1'b0                 ;
                        else
                                pst_prot_rd_valid       <= pre_prot_rd_valid    ;
        end
        else begin: NO_ECC_CHK_SYN_SAMPLE
                always_comb
                        pst_prot_rd_valid       = pre_prot_rd_valid             ;
        end
endgenerate

generate
        if (MEM_PST_ECC_CHK_SAMPLE == 1) begin: PST_ECC_CHK_SAMPLE
                always_ff  @(posedge rd_clk or negedge rd_reset_n)
                        if (!rd_reset_n) begin
                                rd_valid_int            <= 1'b0                                         ;
                                gen_inst_cor_err        <= {MEM_PROT_TOTAL_GEN_INST{1'b0}}              ; 
                                gen_inst_uncor_err      <= {MEM_PROT_TOTAL_GEN_INST{1'b0}}              ;
                        end
                        else begin
                                rd_valid_int            <= pst_prot_rd_valid                            ;
                                gen_inst_cor_err        <= gen_inst_cor_err_int                         ; 
                                gen_inst_uncor_err      <= gen_inst_uncor_err_int                       ;
                        end


		
                always_ff  @(posedge rd_clk) begin
                        rd_data_int                     <= pst_prot_rd_data     ;
                        rd_data_non_prot_int            <= pst_prot_non_prot_rd_data     ;
                end
                
                always_ff  @(posedge rd_clk or negedge rd_reset_n)
                    if (!rd_reset_n) begin
                      dbg_rd_data <= '0;
                      dbg_done <= 0; 
                    end else begin
			            if ((rd_valid_int & dbg_flow)&&dbg_rd_valid) begin
	  			                dbg_rd_data        <= dbg_rd_data_dw_full_2d[dbg_dw_sel[MEM_DBG_DW_SEL_WIDTH-1:0]] ;
				                dbg_done <= 1; 
		                end else begin
    			                dbg_done <= 0; 
                        end
                    end


        end//PST_ECC_CHK_SAMPLE
        else if (MEM_PST_ECC_CHK_SAMPLE == 2) begin: PST_ECC_CHK_SAMPLE_CLKG
                always_ff  @(posedge rd_clk or negedge rd_reset_n)
                        if (!rd_reset_n) begin
                                rd_valid_int            <= 1'b0                                         ;
                                gen_inst_cor_err        <= {MEM_PROT_TOTAL_GEN_INST{1'b0}}              ; 
                                gen_inst_uncor_err      <= {MEM_PROT_TOTAL_GEN_INST{1'b0}}              ;
                        end
                        else begin
                                rd_valid_int            <= pst_prot_rd_valid                            ;
                                gen_inst_cor_err        <= gen_inst_cor_err_int                         ; 
                                gen_inst_uncor_err      <= gen_inst_uncor_err_int                       ;
                        end

	

                always_ff  @(posedge rd_clk) begin
                        if (pst_prot_rd_valid) begin
                                rd_data_int             <= pst_prot_rd_data     ;
                                rd_data_non_prot_int    <= pst_prot_non_prot_rd_data     ;
                        end
                end


                always_ff  @(posedge rd_clk or negedge rd_reset_n)
                    if (!rd_reset_n) begin
                      dbg_rd_data <= '0;
                      dbg_done <= 0; 
                    end else begin
			            if ((rd_valid_int & dbg_flow)&&dbg_rd_valid ) begin
	  			                dbg_rd_data        <= dbg_rd_data_dw_full_2d[dbg_dw_sel[MEM_DBG_DW_SEL_WIDTH-1:0]] ;
				                dbg_done <= 1; 
		                end else begin
    			                dbg_done <= 0; 
                        end
                    end

        end//PST_ECC_CHK_SAMPLE_CLKG
        else begin: NO_PST_ECC_CHK_SAMPLE
            logic dbg_done_int ;

                always_comb begin
                        rd_valid_int                    = pst_prot_rd_valid     ;
                        rd_data_int                     = pst_prot_rd_data      ;
                        rd_data_non_prot_int            = pst_prot_non_prot_rd_data      ;
                        gen_inst_cor_err                = gen_inst_cor_err_int  ;
                        gen_inst_uncor_err              = gen_inst_uncor_err_int;

             			if ((rd_valid_int & dbg_flow)&&dbg_rd_valid ) begin
                            dbg_done_int = 1; 
		                end else begin
    			            dbg_done_int = 0; 
                        end
                end

                  
                always_ff  @(posedge rd_clk or negedge rd_reset_n)
                    if (!rd_reset_n) begin
                      dbg_rd_data <= '0;
                      dbg_done <= 0; 
                    end else begin
			            if (dbg_done_int) begin
	  			                dbg_rd_data        <= dbg_rd_data_dw_full_2d[dbg_dw_sel[MEM_DBG_DW_SEL_WIDTH-1:0]] ;
				                dbg_done <= 1; 
		                end else begin
    			                dbg_done <= 0; 
                        end
                    end


        end//PST_ECC_CHK_SAMPLE
endgenerate

assign  rd_valid        = rd_valid_int && !dbg_rd_valid ;
assign  rd_data         = rd_data_int                   ;

// Contention Resolving Bypass MUX
hlp_mgm_1r1w_cont_bps #(
                .MEM_CONT_BPS_MUX_TYPE                  (MEM_CONT_BPS_MUX_TYPE)                                                         , // 0 - No MUX, 1 - New Data, 2 - Old Data
                .MEM_WIDTH                              (MEM_WIDTH+MEM_PROT_TOTAL_WIDTH)                                                , // Number of Memory lines.
                .MEM_DEPTH                              (MEM_DEPTH)                                                                     , // Memory line width in bits.
                .MEM_WR_RESOLUTION                      ((MEM_WIDTH+MEM_PROT_TOTAL_WIDTH)/MEM_WR_EN_WIDTH)                                // Write Resolution to the Memory: Should be a divisor of the MEM_WIDTH.
)
mgm_1r1w_cont_bps (
                //------------------- clock and reset -------------------
                .clk                    (wr_clk),
                .reset_n                (wr_reset_n),
                //---------------- Functional Interface In --------------
                .rd_adr_pre             (rd_adr_to_mem_int),
                .wr_adr_pre             (wr_adr_to_mem_int),
                .rd_en_pre              (rd_en_to_mem_int),
                .wr_en_pre              (wr_en_to_mem_int),
                .wr_data_pre            (wr_data_to_mem_int),
                .rd_data_pre            (wrap_shell_rd_data_int),
                .rd_valid_pre           (wrap_shell_rd_valid_int),
                //--------------- Functional Interface Out --------------
                .rd_adr_pst             (rd_adr_to_mem),
                .wr_adr_pst             (wr_adr_to_mem),
                .rd_en_pst              (rd_en_to_mem),
                .wr_en_pst              (wr_en_to_mem),
                .wr_data_pst            (wr_data_to_mem),
                .rd_data_pst            (wrap_shell_rd_data),
                .rd_valid_pst           (wrap_shell_rd_valid),
                .rd_valid_int           (cont_bps_rd_valid)
);//mgm_1r1w_cont_bps

// ADDRESS SAMPLING
generate


        if (((MEM_PROT_TYPE == 0) || (MEM_PROT_TYPE == 1)) & (MEM_SKIP_ECC == 0))
                begin: RD_ADDRESS_SAMPLING

                        logic                           stat_rd_ind                                     ;

                        logic                           ecc_err_adr_sample_en, ecc_err_adr_sample_en_int;
                        if (MEM_CTL_RD_SYNC) begin: FROM_CTL_RD_SYNC
                                wire                            from_ctl_bus_pre_sync;
                                wire                            from_ctl_bus_pst_sync;
                                assign                          from_ctl_bus_pre_sync           = from_ctl_bus.stat_rd_ind      ;
                                hlp_mgm_sync_ta2pb from_ctl_bus_sync(
                                        .clkb           (rd_clk)                        , 
                                        .rst_n_b        (sync_rd_reset_n)               ,
                                        .toggle_in      (from_ctl_bus_pre_sync)         ,        
                                        .pulse_out      (from_ctl_bus_pst_sync)
                                );              
                                assign                          stat_rd_ind                     = from_ctl_bus_pst_sync         ;
                        end
                        else begin: NO_FROM_CTL_RD_SYNC
                                assign                          stat_rd_ind                     = from_ctl_bus.stat_rd_ind      ;
                        end
                        always_ff @(posedge rd_clk or negedge rd_reset_n)
                                if (!rd_reset_n) begin
                                        ecc_err_adr_sample_en_int       <= 1'b1         ;                                       
                                end
                                else if (stat_rd_ind) begin
                                        ecc_err_adr_sample_en_int       <= 1'b1         ;
                                end
//                              else if (ecc_uncor_err) begin
                                else if (ecc_err_occured) begin
                                         ecc_err_adr_sample_en_int       <= 1'b0         ;
                                end
                        assign          ecc_err_adr_sample_en           = ecc_err_adr_sample_en_int || stat_rd_ind      ;

                        wire                            adr_fifo_wr_en                                  ;
                        wire                            adr_fifo_rd_en                                  ;
                        wire                            adr_fifo_empty                                  ;
                        wire                            adr_fifo_full                                   ;
                        assign                          adr_fifo_wr_en  = rd_en_mux     & ~adr_fifo_full ;
                        assign                          adr_fifo_rd_en  = rd_valid_int  & ~adr_fifo_empty	 ;

                        
                        wire    [MEM_ADR_WIDTH-1:0]     adr_fifo_data_out                               ;

                        
                        hlp_mgm_fifo #(
                                .WIDTH  (MEM_ADR_WIDTH)         ,
                                .ADD_L  (2)                     
                        ) 
                        u_gen_fifo(
                                .clk            (rd_clk)                ,
                                .rst_n          (rd_reset_n)            ,
                                .d_out          (adr_fifo_data_out)     ,
                                .d_in           (rd_adr_mux)         ,
                                .rd             (adr_fifo_rd_en)        ,
                                .wr             (adr_fifo_wr_en)        ,
                                .empty          (adr_fifo_empty)        ,
                                .full           (adr_fifo_full)         ,
                                .state_cnt      ()                      
                        );

                        always_ff @(posedge rd_clk or negedge rd_reset_n)
                                if (!rd_reset_n) begin
                                        ecc_err_adr     <= {(MEM_DBG_RD_ADR_WIDTH){1'b0}};
                                end
//                                else if (ecc_uncor_err && ecc_err_adr_sample_en) begin
                                else if (ecc_err_occured && ecc_err_adr_sample_en) begin
                                        ecc_err_adr     <= {{(MEM_DBG_RD_ADR_WIDTH-MEM_ADR_WIDTH){1'b0}}, {adr_fifo_data_out}};
                                end
                end
        else
                begin: NO_RD_ADDRESS_SAMPLING
                        assign  ecc_err_adr[MEM_DBG_RD_ADR_WIDTH-1:0]   = {(MEM_DBG_RD_ADR_WIDTH){1'b0}};
                end
endgenerate

////////////////////////////////
// RD & WR contention handling
////////////////////////////////

generate
        if (MEM_MASK_RD_WR_CONTENTION) begin: MEM_MASK_RD_WR_CONTENT
            assign  wr_rd_cont =  {(MEM_WR_EN_WIDTH){rd_en & (rd_adr  == wr_adr) & (MEM_MASK_RD_WR_CONTENTION != 0)}} & wr_en ;
                // put wr_rd_cont into fifo "wr_data" (lanpe_mgm_fifo), depth is max 4. data in is "wr_rd_cont"
                // write into fifo using "rd_en"
                // Read from fifo upon "rd_valid", read data "wr_rd_cont_dly[MEM_WR_EN_WIDTH-1:0]"

            hlp_mgm_fifo #(
                                .WIDTH  (MEM_WR_EN_WIDTH)         ,
                                .ADD_L  (4)                     
                        ) 
                        u_follow_rd_wr_fifo (
                                .clk            (rd_clk)                ,
                                .rst_n          (rd_reset_n)            ,
                                .d_out          (wr_rd_cont_out)        ,
                                .d_in           (wr_rd_cont)            ,
                                .rd             (rd_valid)                ,
                                .wr             (rd_en) ,
                                .empty          ()                      ,
                                .full           ()                      ,
                                .state_cnt      ()                      
                        );

        end
        else begin: NO_MEM_MASK_RD_WR_CONTENT
          assign  wr_rd_cont_out =  0 ;
        end
endgenerate


  
 endmodule//mgm_master_1r1w_shell
