//------------------------------------------------------------------------------
///  INTEL TOP SECRET

///

///  Copyright 2018 Intel Corporation All Rights Reserved.

///

///  The source code contained or described herein and all documents related

///  to the source code ("Material") are owned by Intel Corporation or its

///  suppliers or licensors. Title to the Material remains with Intel

///  Corporation or its suppliers and licensors. The Material contains trade

///  secrets and proprietary and confidential information of Intel or its

///  suppliers and licensors. The Material is protected by worldwide copyright

///  and trade secret laws and treaty provisions. No part of the Material may

///  be used, copied, reproduced, modified, published, uploaded, posted,

///  transmitted, distributed, or disclosed in any way without Intel's prior

///  express written permission.

///

///  No license under any patent, copyright, trade secret or other intellectual

///  property right is granted to or conferred upon you by disclosure or

///  delivery of the Materials, either expressly, by implication, inducement,

///  estoppel or otherwise. Any license under such intellectual property rights

///  must be express and approved by Intel in writing.

///  Inserted by Intel DSD.
//------------------------------------------------------------------------------
//////////////////////////////////////////////////////////////////////
//
//                      Automated Memory Wrappers Creator
//
//                                      & 
//
//                          Logical File Details
//
//              
//                      Author's name   : 
//                      Author's email  : 
//                      Commited on     : 
//                      Commit tag      : 
//                      Hash            : 
//
//////////////////////////////////////////////////////////////////////
`include        "hlp_sched_mem.def"
module  hlp_sched_wrap_mem_rxq_mcast_len_table_shell_16384x27 #(
                // Memory General Parameters
                parameter MEM_WIDTH                     = 42                                                                                                                            ,
                parameter MEM_DEPTH                     = 3086                                                                                                                          ,
                parameter MEM_WR_RESOLUTION             = MEM_WIDTH                                                                                                                     ,
                parameter MEM_WR_EN_WIDTH               = (MEM_WIDTH/MEM_WR_RESOLUTION)                                                                                                 ,
                parameter MEM_DELAY                     = 1                                                                                                                             ,
                parameter MEM_PST_EBB_SAMPLE            = 0                                                                                                                             ,
                parameter MEM_ADR_WIDTH                 = (MEM_DEPTH>1) ? $clog2(MEM_DEPTH) : 1                                                                                         ,
                parameter MEM_RM_WIDTH                  = `HLP_MEM_RM_WIDTH                                                                                                         ,
                parameter FROM_MEM_WIDTH                = MEM_WIDTH + 1                                                                                                                 ,
                parameter TO_MEM_WIDTH                  = 0+1+MEM_RM_WIDTH+1+1+MEM_WR_EN_WIDTH+ (2 * MEM_ADR_WIDTH) +MEM_WIDTH                                                                  ,                                       
                // FAST_CONFIG Parameters
                parameter MEM_INIT_TYPE                 = 1                                                                                                                             , // 1 - Const. Val. Init., 2 - LL, Other - No Init.
                parameter LL_INIT_OFFSET                = 1                                                                                                                             ,
                parameter LL_IS_LAST                    = 1                                                                                                                             ,
                parameter MEM_INIT_VALUE                = 0                                                                                                                             ,
                parameter MEM_INIT_VALUE_WIDTH          = $bits(MEM_INIT_VALUE)                                                                                                         ,
                parameter MEM_PROT_TYPE                 = 0                                                                                                                             ,
                parameter MEM_PROT_RESOLUTION           = MEM_WR_RESOLUTION                                                                                                             ,
                parameter MEM_PROT_INST_WIDTH           = (MEM_PROT_TYPE == 0) ? $clog2(MEM_PROT_RESOLUTION+$clog2(MEM_PROT_RESOLUTION)+1)+1 : 1                                        ,                                                                                                                               
                parameter MEM_INIT_PROT_INST_NUM        = MEM_INIT_VALUE_WIDTH/MEM_PROT_RESOLUTION                                                                                      ,

                parameter       MEM_WIDTH_NO_SIG                        = MEM_INIT_VALUE_WIDTH                                                                                                  ,
                parameter       MEM_WR_RESOLUTION_NO_SIG                = MEM_WIDTH_NO_SIG                                                                                                      ,
                parameter       MEM_WR_RES_PROT_FRAGM                   = 1                                                                                                                     , // Memory Write Resolution Fragmentation for Protection.      
                parameter       MEM_WR_RESOLUTION_ZERO_PADDING          = (MEM_PROT_RESOLUTION * MEM_WR_RES_PROT_FRAGM) - MEM_WR_RESOLUTION_NO_SIG                                       , // Memory Write Resolution Zero Padding.
                parameter       MEM_PROT_INTERLV_LEVEL                  = 1                                                                                                                     , // Memory Protection Bits Interleaving Level: 1 - No Interleaving, 2 - Every 2 bits (grouping of even and odd bits), 3 - Every 3 bits and Etc.
                parameter       MEM_PROT_PER_GEN_INST                   = (MEM_PROT_RESOLUTION % MEM_PROT_INTERLV_LEVEL) ? ((MEM_PROT_RESOLUTION-(MEM_PROT_RESOLUTION % MEM_PROT_INTERLV_LEVEL))/MEM_PROT_INTERLV_LEVEL) + 1 : (MEM_PROT_RESOLUTION/MEM_PROT_INTERLV_LEVEL)     , // Memory Width per protection module.
                parameter       MEM_PROT_RESOLUTION_ZERO_PADDING        = (MEM_PROT_PER_GEN_INST * MEM_PROT_INTERLV_LEVEL) - MEM_PROT_RESOLUTION                                         , // Memory Protection Resolution Zero Padding.
                parameter       MEM_TOTAL_ZERO_PADDING                  = ((MEM_PROT_RESOLUTION_ZERO_PADDING * MEM_WR_RES_PROT_FRAGM) + MEM_WR_RESOLUTION_ZERO_PADDING) * MEM_WR_EN_WIDTH       , // Memory Total Zero Padding. 
                parameter       MEM_PROT_TOTAL_GEN_INST                 = MEM_PROT_INTERLV_LEVEL * MEM_WR_RES_PROT_FRAGM * MEM_WR_EN_WIDTH                                                      ,
                parameter       MEM_PROT_INST_WIDTH_NO_SIG              = (MEM_PROT_TYPE == 0) ? $clog2(MEM_PROT_PER_GEN_INST+$clog2(MEM_PROT_PER_GEN_INST)+1)+1 : (MEM_PROT_TYPE == 1) ? 1 : 0 , // Data Integrity signature width for a single chunk of protected data
                parameter       MEM_PROT_TOTAL_WIDTH                    = MEM_PROT_TOTAL_GEN_INST * MEM_PROT_INST_WIDTH_NO_SIG                                                                         , // Total width of the Data Integrity signatures in Memory line.




                // FPGA Memory Parameters
                parameter FPGA_MEM_ZERO_PADDING         = (8 - (MEM_WR_RESOLUTION % 8)) % 8                                                                                             ,
                parameter FPGA_MEM_WR_RESOLUTION        = MEM_WR_RESOLUTION + FPGA_MEM_ZERO_PADDING                                                                                     ,
                parameter FPGA_MEM_WIDTH                = MEM_WR_EN_WIDTH*(FPGA_MEM_WR_RESOLUTION)                                                                                      ,
                parameter FPGA_MEM_WR_EN_WIDTH          = FPGA_MEM_WIDTH/8                                                                                                              
                // DFx Memory Parameters
               ,
                parameter MSWT_MODE                             = 0                                                                     ,
                parameter BYPASS_RD_CLK_MUX                     = 0                                                                     ,
                parameter BYPASS_WR_CLK_MUX                     = 0                                                                     ,
                parameter BYPASS_AFD_SYNC                       = 1                                                                     ,
                parameter BYPASS_RST_B_SYNC                     = 1                                                                     ,
                parameter BYPASS_MBIST_EN_SYNC                  = 0                                                                     ,
                parameter NFUSE_RF                              = 7                                                                     ,
                parameter PWR_MGMT_IN_SIZE                      = 5                                                                     ,
                parameter NFUSERED_RF                           = $clog2(MEM_WIDTH) + 1                                                 ,
                parameter TOTAL_MEMORY_INSTANCE                 = 1                                               ,
                parameter TOTAL_WRITEABLE_MEMORY_INSTANCE       = 1                                     
)(
        // Memory General Interface
        input                                                   clk_a                           ,
        input                                                   clk_b                           ,
        input           [  TO_MEM_WIDTH-1:0]                    wrap_shell_to_mem               ,
        output  wire    [FROM_MEM_WIDTH-1:0]                    wrap_shell_from_mem             
        // Memory DFx Interface 
       ,
        input                                                   fary_output_reset               ,
        input                                                   fary_isolation_control_in       ,
        input                                 [1:0]             fary_ffuse_rf_sleep             ,        
        input                                                   fsta_dfxact_afd                 ,        
        input                                                   ip_reset_b                      ,  
        input                                                   post_mux_ctrl                   ,
        input                                                   fscan_clkungate                 ,                        
        input                                                   fscan_ram_bypsel_rf             ,
        input                                                   fscan_ram_init_en               ,
        input                                                   fscan_ram_init_val              ,
        input                                                   fscan_ram_rdis_b                ,
        input                                                   fscan_ram_wdis_b                ,
        input           [PWR_MGMT_IN_SIZE-1:0]                  pwr_mgmt_in_rf                  ,
        input           [10-1:0]                             fary_ffuse_rfhs2r2w_trim        , 
        input                                                   fary_pwren_b_rf                 ,
        input                                                   DFTSHIFTEN                      ,
        input                                                   DFTMASK                         ,
        input                                                   DFT_ARRAY_FREEZE                ,
        input                                                   DFT_AFD_RESET_B                 ,
        input                                                   fary_trigger_post_rf            ,
        output                                                  aary_post_pass_rf               ,
        output                                                  aary_post_complete_rf           ,
        output                                                  aary_pwren_b_rf         







        , input wire BIST_SETUP, input wire BIST_SETUP_ts1, 
        input wire BIST_SETUP_ts2, input wire to_interfaces_tck, 
        input wire mcp_bounding_to_en, input wire scan_to_en, 
        input wire memory_bypass_to_en, input wire GO_ID_REG_SEL, 
        input wire GO_ID_REG_SEL_ts1, input wire BIST_CLEAR_BIRA, 
        input wire BIST_COLLAR_DIAG_EN, input wire BIST_COLLAR_BIRA_EN, 
        input wire BIST_SHIFT_BIRA_COLLAR, input wire BIST_CLEAR_BIRA_ts1, 
        input wire BIST_COLLAR_DIAG_EN_ts1, input wire BIST_COLLAR_BIRA_EN_ts1, 
        input wire BIST_SHIFT_BIRA_COLLAR_ts1, input wire CHECK_REPAIR_NEEDED, 
        input wire MEM0_BIST_COLLAR_SI, input wire MEM1_BIST_COLLAR_SI, 
        input wire MEM2_BIST_COLLAR_SI, input wire MEM3_BIST_COLLAR_SI, 
        input wire MEM4_BIST_COLLAR_SI, input wire MEM5_BIST_COLLAR_SI, 
        input wire MEM6_BIST_COLLAR_SI, input wire MEM7_BIST_COLLAR_SI, 
        input wire MEM8_BIST_COLLAR_SI, input wire MEM9_BIST_COLLAR_SI, 
        input wire MEM10_BIST_COLLAR_SI, input wire MEM11_BIST_COLLAR_SI, 
        input wire MEM12_BIST_COLLAR_SI, input wire MEM13_BIST_COLLAR_SI, 
        input wire MEM14_BIST_COLLAR_SI, input wire MEM15_BIST_COLLAR_SI, 
        input wire MEM16_BIST_COLLAR_SI, input wire MEM17_BIST_COLLAR_SI, 
        input wire MEM18_BIST_COLLAR_SI, input wire MEM19_BIST_COLLAR_SI, 
        input wire MEM20_BIST_COLLAR_SI, input wire MEM21_BIST_COLLAR_SI, 
        input wire MEM22_BIST_COLLAR_SI, input wire MEM23_BIST_COLLAR_SI, 
        input wire MEM24_BIST_COLLAR_SI, input wire MEM25_BIST_COLLAR_SI, 
        input wire MEM26_BIST_COLLAR_SI, input wire MEM27_BIST_COLLAR_SI, 
        input wire MEM28_BIST_COLLAR_SI, input wire MEM29_BIST_COLLAR_SI, 
        input wire MEM30_BIST_COLLAR_SI, input wire MEM31_BIST_COLLAR_SI, 
        input wire MEM0_BIST_COLLAR_SI_ts1, input wire MEM1_BIST_COLLAR_SI_ts1, 
        input wire MEM2_BIST_COLLAR_SI_ts1, input wire MEM3_BIST_COLLAR_SI_ts1, 
        input wire MEM4_BIST_COLLAR_SI_ts1, input wire MEM5_BIST_COLLAR_SI_ts1, 
        input wire MEM6_BIST_COLLAR_SI_ts1, input wire MEM7_BIST_COLLAR_SI_ts1, 
        input wire MEM8_BIST_COLLAR_SI_ts1, input wire MEM9_BIST_COLLAR_SI_ts1, 
        input wire MEM10_BIST_COLLAR_SI_ts1, 
        input wire MEM11_BIST_COLLAR_SI_ts1, 
        input wire MEM12_BIST_COLLAR_SI_ts1, 
        input wire MEM13_BIST_COLLAR_SI_ts1, 
        input wire MEM14_BIST_COLLAR_SI_ts1, 
        input wire MEM15_BIST_COLLAR_SI_ts1, 
        input wire MEM16_BIST_COLLAR_SI_ts1, 
        input wire MEM17_BIST_COLLAR_SI_ts1, 
        input wire MEM18_BIST_COLLAR_SI_ts1, 
        input wire MEM19_BIST_COLLAR_SI_ts1, 
        input wire MEM20_BIST_COLLAR_SI_ts1, 
        input wire MEM21_BIST_COLLAR_SI_ts1, 
        input wire MEM22_BIST_COLLAR_SI_ts1, 
        input wire MEM23_BIST_COLLAR_SI_ts1, 
        input wire MEM24_BIST_COLLAR_SI_ts1, 
        input wire MEM25_BIST_COLLAR_SI_ts1, 
        input wire MEM26_BIST_COLLAR_SI_ts1, 
        input wire MEM27_BIST_COLLAR_SI_ts1, 
        input wire MEM28_BIST_COLLAR_SI_ts1, 
        input wire MEM29_BIST_COLLAR_SI_ts1, 
        input wire MEM30_BIST_COLLAR_SI_ts1, 
        input wire MEM31_BIST_COLLAR_SI_ts1, output wire BIST_SO, 
        output wire BIST_SO_ts1, output wire BIST_SO_ts2, 
        output wire BIST_SO_ts3, output wire BIST_SO_ts4, 
        output wire BIST_SO_ts5, output wire BIST_SO_ts6, 
        output wire BIST_SO_ts7, output wire BIST_SO_ts8, 
        output wire BIST_SO_ts9, output wire BIST_SO_ts10, 
        output wire BIST_SO_ts11, output wire BIST_SO_ts12, 
        output wire BIST_SO_ts13, output wire BIST_SO_ts14, 
        output wire BIST_SO_ts15, output wire BIST_SO_ts16, 
        output wire BIST_SO_ts17, output wire BIST_SO_ts18, 
        output wire BIST_SO_ts19, output wire BIST_SO_ts20, 
        output wire BIST_SO_ts21, output wire BIST_SO_ts22, 
        output wire BIST_SO_ts23, output wire BIST_SO_ts24, 
        output wire BIST_SO_ts25, output wire BIST_SO_ts26, 
        output wire BIST_SO_ts27, output wire BIST_SO_ts28, 
        output wire BIST_SO_ts29, output wire BIST_SO_ts30, 
        output wire BIST_SO_ts31, output wire BIST_SO_ts32, 
        output wire BIST_SO_ts33, output wire BIST_SO_ts34, 
        output wire BIST_SO_ts35, output wire BIST_SO_ts36, 
        output wire BIST_SO_ts37, output wire BIST_SO_ts38, 
        output wire BIST_SO_ts39, output wire BIST_SO_ts40, 
        output wire BIST_SO_ts41, output wire BIST_SO_ts42, 
        output wire BIST_SO_ts43, output wire BIST_SO_ts44, 
        output wire BIST_SO_ts45, output wire BIST_SO_ts46, 
        output wire BIST_SO_ts47, output wire BIST_SO_ts48, 
        output wire BIST_SO_ts49, output wire BIST_SO_ts50, 
        output wire BIST_SO_ts51, output wire BIST_SO_ts52, 
        output wire BIST_SO_ts53, output wire BIST_SO_ts54, 
        output wire BIST_SO_ts55, output wire BIST_SO_ts56, 
        output wire BIST_SO_ts57, output wire BIST_SO_ts58, 
        output wire BIST_SO_ts59, output wire BIST_SO_ts60, 
        output wire BIST_SO_ts61, output wire BIST_SO_ts62, 
        output wire BIST_SO_ts63, output wire BIST_GO, output wire BIST_GO_ts1, 
        output wire BIST_GO_ts2, output wire BIST_GO_ts3, 
        output wire BIST_GO_ts4, output wire BIST_GO_ts5, 
        output wire BIST_GO_ts6, output wire BIST_GO_ts7, 
        output wire BIST_GO_ts8, output wire BIST_GO_ts9, 
        output wire BIST_GO_ts10, output wire BIST_GO_ts11, 
        output wire BIST_GO_ts12, output wire BIST_GO_ts13, 
        output wire BIST_GO_ts14, output wire BIST_GO_ts15, 
        output wire BIST_GO_ts16, output wire BIST_GO_ts17, 
        output wire BIST_GO_ts18, output wire BIST_GO_ts19, 
        output wire BIST_GO_ts20, output wire BIST_GO_ts21, 
        output wire BIST_GO_ts22, output wire BIST_GO_ts23, 
        output wire BIST_GO_ts24, output wire BIST_GO_ts25, 
        output wire BIST_GO_ts26, output wire BIST_GO_ts27, 
        output wire BIST_GO_ts28, output wire BIST_GO_ts29, 
        output wire BIST_GO_ts30, output wire BIST_GO_ts31, 
        output wire BIST_GO_ts32, output wire BIST_GO_ts33, 
        output wire BIST_GO_ts34, output wire BIST_GO_ts35, 
        output wire BIST_GO_ts36, output wire BIST_GO_ts37, 
        output wire BIST_GO_ts38, output wire BIST_GO_ts39, 
        output wire BIST_GO_ts40, output wire BIST_GO_ts41, 
        output wire BIST_GO_ts42, output wire BIST_GO_ts43, 
        output wire BIST_GO_ts44, output wire BIST_GO_ts45, 
        output wire BIST_GO_ts46, output wire BIST_GO_ts47, 
        output wire BIST_GO_ts48, output wire BIST_GO_ts49, 
        output wire BIST_GO_ts50, output wire BIST_GO_ts51, 
        output wire BIST_GO_ts52, output wire BIST_GO_ts53, 
        output wire BIST_GO_ts54, output wire BIST_GO_ts55, 
        output wire BIST_GO_ts56, output wire BIST_GO_ts57, 
        output wire BIST_GO_ts58, output wire BIST_GO_ts59, 
        output wire BIST_GO_ts60, output wire BIST_GO_ts61, 
        output wire BIST_GO_ts62, output wire BIST_GO_ts63, 
        input wire ltest_to_en, input wire BIST_READENABLE, 
        input wire BIST_WRITEENABLE, input wire BIST_READENABLE_ts1, 
        input wire BIST_WRITEENABLE_ts1, input wire BIST_CMP, 
        input wire BIST_CMP_ts1, input wire INCLUDE_MEM_RESULTS_REG, 
        input wire BIST_ROW_ADD, input wire BIST_ROW_ADD_ts1, 
        input wire BIST_ROW_ADD_ts2, input wire BIST_ROW_ADD_ts3, 
        input wire BIST_ROW_ADD_ts4, input wire BIST_ROW_ADD_ts5, 
        input wire BIST_ROW_ADD_ts6, input wire BIST_ROW_ADD_ts7, 
        input wire BIST_BANK_ADD, input wire BIST_BANK_ADD_ts1, 
        input wire BIST_BANK_ADD_ts2, input wire BIST_BANK_ADD_ts3, 
        input wire BIST_BANK_ADD_ts4, input wire BIST_BANK_ADD_ts5, 
        input wire BIST_BANK_ADD_ts6, input wire BIST_BANK_ADD_ts7, 
        input wire BIST_COLLAR_EN0, input wire BIST_COLLAR_EN1, 
        input wire BIST_COLLAR_EN2, input wire BIST_COLLAR_EN3, 
        input wire BIST_COLLAR_EN4, input wire BIST_COLLAR_EN5, 
        input wire BIST_COLLAR_EN6, input wire BIST_COLLAR_EN7, 
        input wire BIST_COLLAR_EN8, input wire BIST_COLLAR_EN9, 
        input wire BIST_COLLAR_EN10, input wire BIST_COLLAR_EN11, 
        input wire BIST_COLLAR_EN12, input wire BIST_COLLAR_EN13, 
        input wire BIST_COLLAR_EN14, input wire BIST_COLLAR_EN15, 
        input wire BIST_COLLAR_EN16, input wire BIST_COLLAR_EN17, 
        input wire BIST_COLLAR_EN18, input wire BIST_COLLAR_EN19, 
        input wire BIST_COLLAR_EN20, input wire BIST_COLLAR_EN21, 
        input wire BIST_COLLAR_EN22, input wire BIST_COLLAR_EN23, 
        input wire BIST_COLLAR_EN24, input wire BIST_COLLAR_EN25, 
        input wire BIST_COLLAR_EN26, input wire BIST_COLLAR_EN27, 
        input wire BIST_COLLAR_EN28, input wire BIST_COLLAR_EN29, 
        input wire BIST_COLLAR_EN30, input wire BIST_COLLAR_EN31, 
        input wire BIST_COLLAR_EN0_ts1, input wire BIST_COLLAR_EN1_ts1, 
        input wire BIST_COLLAR_EN2_ts1, input wire BIST_COLLAR_EN3_ts1, 
        input wire BIST_COLLAR_EN4_ts1, input wire BIST_COLLAR_EN5_ts1, 
        input wire BIST_COLLAR_EN6_ts1, input wire BIST_COLLAR_EN7_ts1, 
        input wire BIST_COLLAR_EN8_ts1, input wire BIST_COLLAR_EN9_ts1, 
        input wire BIST_COLLAR_EN10_ts1, input wire BIST_COLLAR_EN11_ts1, 
        input wire BIST_COLLAR_EN12_ts1, input wire BIST_COLLAR_EN13_ts1, 
        input wire BIST_COLLAR_EN14_ts1, input wire BIST_COLLAR_EN15_ts1, 
        input wire BIST_COLLAR_EN16_ts1, input wire BIST_COLLAR_EN17_ts1, 
        input wire BIST_COLLAR_EN18_ts1, input wire BIST_COLLAR_EN19_ts1, 
        input wire BIST_COLLAR_EN20_ts1, input wire BIST_COLLAR_EN21_ts1, 
        input wire BIST_COLLAR_EN22_ts1, input wire BIST_COLLAR_EN23_ts1, 
        input wire BIST_COLLAR_EN24_ts1, input wire BIST_COLLAR_EN25_ts1, 
        input wire BIST_COLLAR_EN26_ts1, input wire BIST_COLLAR_EN27_ts1, 
        input wire BIST_COLLAR_EN28_ts1, input wire BIST_COLLAR_EN29_ts1, 
        input wire BIST_COLLAR_EN30_ts1, input wire BIST_COLLAR_EN31_ts1, 
        input wire BIST_RUN_TO_COLLAR0, input wire BIST_RUN_TO_COLLAR1, 
        input wire BIST_RUN_TO_COLLAR2, input wire BIST_RUN_TO_COLLAR3, 
        input wire BIST_RUN_TO_COLLAR4, input wire BIST_RUN_TO_COLLAR5, 
        input wire BIST_RUN_TO_COLLAR6, input wire BIST_RUN_TO_COLLAR7, 
        input wire BIST_RUN_TO_COLLAR8, input wire BIST_RUN_TO_COLLAR9, 
        input wire BIST_RUN_TO_COLLAR10, input wire BIST_RUN_TO_COLLAR11, 
        input wire BIST_RUN_TO_COLLAR12, input wire BIST_RUN_TO_COLLAR13, 
        input wire BIST_RUN_TO_COLLAR14, input wire BIST_RUN_TO_COLLAR15, 
        input wire BIST_RUN_TO_COLLAR16, input wire BIST_RUN_TO_COLLAR17, 
        input wire BIST_RUN_TO_COLLAR18, input wire BIST_RUN_TO_COLLAR19, 
        input wire BIST_RUN_TO_COLLAR20, input wire BIST_RUN_TO_COLLAR21, 
        input wire BIST_RUN_TO_COLLAR22, input wire BIST_RUN_TO_COLLAR23, 
        input wire BIST_RUN_TO_COLLAR24, input wire BIST_RUN_TO_COLLAR25, 
        input wire BIST_RUN_TO_COLLAR26, input wire BIST_RUN_TO_COLLAR27, 
        input wire BIST_RUN_TO_COLLAR28, input wire BIST_RUN_TO_COLLAR29, 
        input wire BIST_RUN_TO_COLLAR30, input wire BIST_RUN_TO_COLLAR31, 
        input wire BIST_RUN_TO_COLLAR0_ts1, input wire BIST_RUN_TO_COLLAR1_ts1, 
        input wire BIST_RUN_TO_COLLAR2_ts1, input wire BIST_RUN_TO_COLLAR3_ts1, 
        input wire BIST_RUN_TO_COLLAR4_ts1, input wire BIST_RUN_TO_COLLAR5_ts1, 
        input wire BIST_RUN_TO_COLLAR6_ts1, input wire BIST_RUN_TO_COLLAR7_ts1, 
        input wire BIST_RUN_TO_COLLAR8_ts1, input wire BIST_RUN_TO_COLLAR9_ts1, 
        input wire BIST_RUN_TO_COLLAR10_ts1, 
        input wire BIST_RUN_TO_COLLAR11_ts1, 
        input wire BIST_RUN_TO_COLLAR12_ts1, 
        input wire BIST_RUN_TO_COLLAR13_ts1, 
        input wire BIST_RUN_TO_COLLAR14_ts1, 
        input wire BIST_RUN_TO_COLLAR15_ts1, 
        input wire BIST_RUN_TO_COLLAR16_ts1, 
        input wire BIST_RUN_TO_COLLAR17_ts1, 
        input wire BIST_RUN_TO_COLLAR18_ts1, 
        input wire BIST_RUN_TO_COLLAR19_ts1, 
        input wire BIST_RUN_TO_COLLAR20_ts1, 
        input wire BIST_RUN_TO_COLLAR21_ts1, 
        input wire BIST_RUN_TO_COLLAR22_ts1, 
        input wire BIST_RUN_TO_COLLAR23_ts1, 
        input wire BIST_RUN_TO_COLLAR24_ts1, 
        input wire BIST_RUN_TO_COLLAR25_ts1, 
        input wire BIST_RUN_TO_COLLAR26_ts1, 
        input wire BIST_RUN_TO_COLLAR27_ts1, 
        input wire BIST_RUN_TO_COLLAR28_ts1, 
        input wire BIST_RUN_TO_COLLAR29_ts1, 
        input wire BIST_RUN_TO_COLLAR30_ts1, 
        input wire BIST_RUN_TO_COLLAR31_ts1, input wire BIST_ASYNC_RESET, 
        input wire BIST_SHADOW_READENABLE, input wire BIST_SHADOW_READADDRESS, 
        input wire BIST_SHADOW_READENABLE_ts1, 
        input wire BIST_SHADOW_READADDRESS_ts1, 
        input wire BIST_CONWRITE_ROWADDRESS, input wire BIST_CONWRITE_ENABLE, 
        input wire BIST_CONWRITE_ROWADDRESS_ts1, 
        input wire BIST_CONWRITE_ENABLE_ts1, 
        input wire BIST_CONREAD_ROWADDRESS, input wire BIST_CONREAD_ENABLE, 
        input wire BIST_CONREAD_ROWADDRESS_ts1, 
        input wire BIST_CONREAD_ENABLE_ts1, 
        input wire BIST_TESTDATA_SELECT_TO_COLLAR, 
        input wire BIST_TESTDATA_SELECT_TO_COLLAR_ts1, 
        input wire BIST_ON_TO_COLLAR, input wire BIST_ON_TO_COLLAR_ts1, 
        input wire BIST_WRITE_DATA, input wire BIST_WRITE_DATA_ts1, 
        input wire BIST_WRITE_DATA_ts2, input wire BIST_WRITE_DATA_ts3, 
        input wire BIST_WRITE_DATA_ts4, input wire BIST_WRITE_DATA_ts5, 
        input wire BIST_WRITE_DATA_ts6, input wire BIST_WRITE_DATA_ts7, 
        input wire BIST_WRITE_DATA_ts8, input wire BIST_WRITE_DATA_ts9, 
        input wire BIST_WRITE_DATA_ts10, input wire BIST_WRITE_DATA_ts11, 
        input wire BIST_WRITE_DATA_ts12, input wire BIST_WRITE_DATA_ts13, 
        input wire BIST_WRITE_DATA_ts14, input wire BIST_WRITE_DATA_ts15, 
        input wire BIST_EXPECT_DATA, input wire BIST_EXPECT_DATA_ts1, 
        input wire BIST_EXPECT_DATA_ts2, input wire BIST_EXPECT_DATA_ts3, 
        input wire BIST_EXPECT_DATA_ts4, input wire BIST_EXPECT_DATA_ts5, 
        input wire BIST_EXPECT_DATA_ts6, input wire BIST_EXPECT_DATA_ts7, 
        input wire BIST_EXPECT_DATA_ts8, input wire BIST_EXPECT_DATA_ts9, 
        input wire BIST_EXPECT_DATA_ts10, input wire BIST_EXPECT_DATA_ts11, 
        input wire BIST_EXPECT_DATA_ts12, input wire BIST_EXPECT_DATA_ts13, 
        input wire BIST_EXPECT_DATA_ts14, input wire BIST_EXPECT_DATA_ts15, 
        input wire BIST_SHIFT_COLLAR, input wire BIST_SHIFT_COLLAR_ts1, 
        input wire BIST_COLLAR_SETUP, input wire BIST_COLLAR_SETUP_ts1, 
        input wire BIST_CLEAR_DEFAULT, input wire BIST_CLEAR_DEFAULT_ts1, 
        input wire BIST_CLEAR, input wire BIST_CLEAR_ts1, 
        input wire BIST_COLLAR_OPSET_SELECT, 
        input wire BIST_COLLAR_OPSET_SELECT_ts1, input wire BIST_COLLAR_HOLD, 
        input wire FREEZE_STOP_ERROR, input wire ERROR_CNT_ZERO, 
        input wire BIST_COLLAR_HOLD_ts1, input wire FREEZE_STOP_ERROR_ts1, 
        input wire ERROR_CNT_ZERO_ts1, input wire MBISTPG_RESET_REG_SETUP2, 
        input wire MBISTPG_RESET_REG_SETUP2_ts1, input wire BIST_TEST_PORT, 
        input wire BIST_TEST_PORT_ts1, input wire bisr_shift_en_pd_vinf, 
        input wire bisr_clk_pd_vinf, input wire bisr_reset_pd_vinf, 
        input wire ram_row_0_col_0_bisr_inst_SO, 
        output wire ram_row_9_col_0_bisr_inst_SO);


        wire    [TO_MEM_WIDTH/2-1:0]    wrap_shell_to_mem_b, wrap_shell_to_mem_a                                ;
        
        wire [7:0] ADRRD_P0, ADRRD_P0_ts1, ADRRD_P0_ts2, ADRRD_P0_ts3, 
                   ADRRD_P0_ts4, ADRRD_P0_ts5, ADRRD_P0_ts6, ADRRD_P0_ts7, 
                   ADRRD_P0_ts8, ADRRD_P0_ts9, ADRRD_P0_ts10, ADRRD_P0_ts11, 
                   ADRRD_P0_ts12, ADRRD_P0_ts13, ADRRD_P0_ts14, ADRRD_P0_ts15, 
                   ADRRD_P0_ts16, ADRRD_P0_ts17, ADRRD_P0_ts18, ADRRD_P0_ts19, 
                   ADRRD_P0_ts20, ADRRD_P0_ts21, ADRRD_P0_ts22, ADRRD_P0_ts23, 
                   ADRRD_P0_ts24, ADRRD_P0_ts25, ADRRD_P0_ts26, ADRRD_P0_ts27, 
                   ADRRD_P0_ts28, ADRRD_P0_ts29, ADRRD_P0_ts30, ADRRD_P0_ts31, 
                   ADRRD_P0_ts32, ADRRD_P0_ts33, ADRRD_P0_ts34, ADRRD_P0_ts35, 
                   ADRRD_P0_ts36, ADRRD_P0_ts37, ADRRD_P0_ts38, ADRRD_P0_ts39, 
                   ADRRD_P0_ts40, ADRRD_P0_ts41, ADRRD_P0_ts42, ADRRD_P0_ts43, 
                   ADRRD_P0_ts44, ADRRD_P0_ts45, ADRRD_P0_ts46, ADRRD_P0_ts47, 
                   ADRRD_P0_ts48, ADRRD_P0_ts49, ADRRD_P0_ts50, ADRRD_P0_ts51, 
                   ADRRD_P0_ts52, ADRRD_P0_ts53, ADRRD_P0_ts54, ADRRD_P0_ts55, 
                   ADRRD_P0_ts56, ADRRD_P0_ts57, ADRRD_P0_ts58, ADRRD_P0_ts59, 
                   ADRRD_P0_ts60, ADRRD_P0_ts61, ADRRD_P0_ts62, ADRRD_P0_ts63, 
                   ADRRD_P1, ADRRD_P1_ts1, ADRRD_P1_ts2, ADRRD_P1_ts3, 
                   ADRRD_P1_ts4, ADRRD_P1_ts5, ADRRD_P1_ts6, ADRRD_P1_ts7, 
                   ADRRD_P1_ts8, ADRRD_P1_ts9, ADRRD_P1_ts10, ADRRD_P1_ts11, 
                   ADRRD_P1_ts12, ADRRD_P1_ts13, ADRRD_P1_ts14, ADRRD_P1_ts15, 
                   ADRRD_P1_ts16, ADRRD_P1_ts17, ADRRD_P1_ts18, ADRRD_P1_ts19, 
                   ADRRD_P1_ts20, ADRRD_P1_ts21, ADRRD_P1_ts22, ADRRD_P1_ts23, 
                   ADRRD_P1_ts24, ADRRD_P1_ts25, ADRRD_P1_ts26, ADRRD_P1_ts27, 
                   ADRRD_P1_ts28, ADRRD_P1_ts29, ADRRD_P1_ts30, ADRRD_P1_ts31, 
                   ADRRD_P1_ts32, ADRRD_P1_ts33, ADRRD_P1_ts34, ADRRD_P1_ts35, 
                   ADRRD_P1_ts36, ADRRD_P1_ts37, ADRRD_P1_ts38, ADRRD_P1_ts39, 
                   ADRRD_P1_ts40, ADRRD_P1_ts41, ADRRD_P1_ts42, ADRRD_P1_ts43, 
                   ADRRD_P1_ts44, ADRRD_P1_ts45, ADRRD_P1_ts46, ADRRD_P1_ts47, 
                   ADRRD_P1_ts48, ADRRD_P1_ts49, ADRRD_P1_ts50, ADRRD_P1_ts51, 
                   ADRRD_P1_ts52, ADRRD_P1_ts53, ADRRD_P1_ts54, ADRRD_P1_ts55, 
                   ADRRD_P1_ts56, ADRRD_P1_ts57, ADRRD_P1_ts58, ADRRD_P1_ts59, 
                   ADRRD_P1_ts60, ADRRD_P1_ts61, ADRRD_P1_ts62, ADRRD_P1_ts63, 
                   ADRWR_P0, ADRWR_P0_ts1, ADRWR_P0_ts2, ADRWR_P0_ts3, 
                   ADRWR_P0_ts4, ADRWR_P0_ts5, ADRWR_P0_ts6, ADRWR_P0_ts7, 
                   ADRWR_P0_ts8, ADRWR_P0_ts9, ADRWR_P0_ts10, ADRWR_P0_ts11, 
                   ADRWR_P0_ts12, ADRWR_P0_ts13, ADRWR_P0_ts14, ADRWR_P0_ts15, 
                   ADRWR_P0_ts16, ADRWR_P0_ts17, ADRWR_P0_ts18, ADRWR_P0_ts19, 
                   ADRWR_P0_ts20, ADRWR_P0_ts21, ADRWR_P0_ts22, ADRWR_P0_ts23, 
                   ADRWR_P0_ts24, ADRWR_P0_ts25, ADRWR_P0_ts26, ADRWR_P0_ts27, 
                   ADRWR_P0_ts28, ADRWR_P0_ts29, ADRWR_P0_ts30, ADRWR_P0_ts31, 
                   ADRWR_P0_ts32, ADRWR_P0_ts33, ADRWR_P0_ts34, ADRWR_P0_ts35, 
                   ADRWR_P0_ts36, ADRWR_P0_ts37, ADRWR_P0_ts38, ADRWR_P0_ts39, 
                   ADRWR_P0_ts40, ADRWR_P0_ts41, ADRWR_P0_ts42, ADRWR_P0_ts43, 
                   ADRWR_P0_ts44, ADRWR_P0_ts45, ADRWR_P0_ts46, ADRWR_P0_ts47, 
                   ADRWR_P0_ts48, ADRWR_P0_ts49, ADRWR_P0_ts50, ADRWR_P0_ts51, 
                   ADRWR_P0_ts52, ADRWR_P0_ts53, ADRWR_P0_ts54, ADRWR_P0_ts55, 
                   ADRWR_P0_ts56, ADRWR_P0_ts57, ADRWR_P0_ts58, ADRWR_P0_ts59, 
                   ADRWR_P0_ts60, ADRWR_P0_ts61, ADRWR_P0_ts62, ADRWR_P0_ts63, 
                   ADRWR_P1, ADRWR_P1_ts1, ADRWR_P1_ts2, ADRWR_P1_ts3, 
                   ADRWR_P1_ts4, ADRWR_P1_ts5, ADRWR_P1_ts6, ADRWR_P1_ts7, 
                   ADRWR_P1_ts8, ADRWR_P1_ts9, ADRWR_P1_ts10, ADRWR_P1_ts11, 
                   ADRWR_P1_ts12, ADRWR_P1_ts13, ADRWR_P1_ts14, ADRWR_P1_ts15, 
                   ADRWR_P1_ts16, ADRWR_P1_ts17, ADRWR_P1_ts18, ADRWR_P1_ts19, 
                   ADRWR_P1_ts20, ADRWR_P1_ts21, ADRWR_P1_ts22, ADRWR_P1_ts23, 
                   ADRWR_P1_ts24, ADRWR_P1_ts25, ADRWR_P1_ts26, ADRWR_P1_ts27, 
                   ADRWR_P1_ts28, ADRWR_P1_ts29, ADRWR_P1_ts30, ADRWR_P1_ts31, 
                   ADRWR_P1_ts32, ADRWR_P1_ts33, ADRWR_P1_ts34, ADRWR_P1_ts35, 
                   ADRWR_P1_ts36, ADRWR_P1_ts37, ADRWR_P1_ts38, ADRWR_P1_ts39, 
                   ADRWR_P1_ts40, ADRWR_P1_ts41, ADRWR_P1_ts42, ADRWR_P1_ts43, 
                   ADRWR_P1_ts44, ADRWR_P1_ts45, ADRWR_P1_ts46, ADRWR_P1_ts47, 
                   ADRWR_P1_ts48, ADRWR_P1_ts49, ADRWR_P1_ts50, ADRWR_P1_ts51, 
                   ADRWR_P1_ts52, ADRWR_P1_ts53, ADRWR_P1_ts54, ADRWR_P1_ts55, 
                   ADRWR_P1_ts56, ADRWR_P1_ts57, ADRWR_P1_ts58, ADRWR_P1_ts59, 
                   ADRWR_P1_ts60, ADRWR_P1_ts61, ADRWR_P1_ts62, ADRWR_P1_ts63;
        wire [33:0] DIN_P0, DIN_P0_ts1, DIN_P0_ts2, DIN_P0_ts3, DIN_P0_ts4, 
                    DIN_P0_ts5, DIN_P0_ts6, DIN_P0_ts7, DIN_P0_ts8, DIN_P0_ts9, 
                    DIN_P0_ts10, DIN_P0_ts11, DIN_P0_ts12, DIN_P0_ts13, 
                    DIN_P0_ts14, DIN_P0_ts15, DIN_P0_ts16, DIN_P0_ts17, 
                    DIN_P0_ts18, DIN_P0_ts19, DIN_P0_ts20, DIN_P0_ts21, 
                    DIN_P0_ts22, DIN_P0_ts23, DIN_P0_ts24, DIN_P0_ts25, 
                    DIN_P0_ts26, DIN_P0_ts27, DIN_P0_ts28, DIN_P0_ts29, 
                    DIN_P0_ts30, DIN_P0_ts31, DIN_P0_ts32, DIN_P0_ts33, 
                    DIN_P0_ts34, DIN_P0_ts35, DIN_P0_ts36, DIN_P0_ts37, 
                    DIN_P0_ts38, DIN_P0_ts39, DIN_P0_ts40, DIN_P0_ts41, 
                    DIN_P0_ts42, DIN_P0_ts43, DIN_P0_ts44, DIN_P0_ts45, 
                    DIN_P0_ts46, DIN_P0_ts47, DIN_P0_ts48, DIN_P0_ts49, 
                    DIN_P0_ts50, DIN_P0_ts51, DIN_P0_ts52, DIN_P0_ts53, 
                    DIN_P0_ts54, DIN_P0_ts55, DIN_P0_ts56, DIN_P0_ts57, 
                    DIN_P0_ts58, DIN_P0_ts59, DIN_P0_ts60, DIN_P0_ts61, 
                    DIN_P0_ts62, DIN_P0_ts63, DIN_P1, DIN_P1_ts1, DIN_P1_ts2, 
                    DIN_P1_ts3, DIN_P1_ts4, DIN_P1_ts5, DIN_P1_ts6, DIN_P1_ts7, 
                    DIN_P1_ts8, DIN_P1_ts9, DIN_P1_ts10, DIN_P1_ts11, 
                    DIN_P1_ts12, DIN_P1_ts13, DIN_P1_ts14, DIN_P1_ts15, 
                    DIN_P1_ts16, DIN_P1_ts17, DIN_P1_ts18, DIN_P1_ts19, 
                    DIN_P1_ts20, DIN_P1_ts21, DIN_P1_ts22, DIN_P1_ts23, 
                    DIN_P1_ts24, DIN_P1_ts25, DIN_P1_ts26, DIN_P1_ts27, 
                    DIN_P1_ts28, DIN_P1_ts29, DIN_P1_ts30, DIN_P1_ts31, 
                    DIN_P1_ts32, DIN_P1_ts33, DIN_P1_ts34, DIN_P1_ts35, 
                    DIN_P1_ts36, DIN_P1_ts37, DIN_P1_ts38, DIN_P1_ts39, 
                    DIN_P1_ts40, DIN_P1_ts41, DIN_P1_ts42, DIN_P1_ts43, 
                    DIN_P1_ts44, DIN_P1_ts45, DIN_P1_ts46, DIN_P1_ts47, 
                    DIN_P1_ts48, DIN_P1_ts49, DIN_P1_ts50, DIN_P1_ts51, 
                    DIN_P1_ts52, DIN_P1_ts53, DIN_P1_ts54, DIN_P1_ts55, 
                    DIN_P1_ts56, DIN_P1_ts57, DIN_P1_ts58, DIN_P1_ts59, 
                    DIN_P1_ts60, DIN_P1_ts61, DIN_P1_ts62, DIN_P1_ts63;
        wire [6:0] ram_row_0_col_0_bisr_inst_Q, ram_row_10_col_0_bisr_inst_Q, 
                   ram_row_11_col_0_bisr_inst_Q, ram_row_12_col_0_bisr_inst_Q, 
                   ram_row_13_col_0_bisr_inst_Q, ram_row_14_col_0_bisr_inst_Q, 
                   ram_row_15_col_0_bisr_inst_Q, ram_row_16_col_0_bisr_inst_Q, 
                   ram_row_17_col_0_bisr_inst_Q, ram_row_18_col_0_bisr_inst_Q, 
                   ram_row_19_col_0_bisr_inst_Q, ram_row_1_col_0_bisr_inst_Q, 
                   ram_row_20_col_0_bisr_inst_Q, ram_row_21_col_0_bisr_inst_Q, 
                   ram_row_22_col_0_bisr_inst_Q, ram_row_23_col_0_bisr_inst_Q, 
                   ram_row_24_col_0_bisr_inst_Q, ram_row_25_col_0_bisr_inst_Q, 
                   ram_row_26_col_0_bisr_inst_Q, ram_row_27_col_0_bisr_inst_Q, 
                   ram_row_28_col_0_bisr_inst_Q, ram_row_29_col_0_bisr_inst_Q, 
                   ram_row_2_col_0_bisr_inst_Q, ram_row_30_col_0_bisr_inst_Q, 
                   ram_row_31_col_0_bisr_inst_Q, ram_row_32_col_0_bisr_inst_Q, 
                   ram_row_33_col_0_bisr_inst_Q, ram_row_34_col_0_bisr_inst_Q, 
                   ram_row_35_col_0_bisr_inst_Q, ram_row_36_col_0_bisr_inst_Q, 
                   ram_row_37_col_0_bisr_inst_Q, ram_row_38_col_0_bisr_inst_Q, 
                   ram_row_39_col_0_bisr_inst_Q, ram_row_3_col_0_bisr_inst_Q, 
                   ram_row_40_col_0_bisr_inst_Q, ram_row_41_col_0_bisr_inst_Q, 
                   ram_row_42_col_0_bisr_inst_Q, ram_row_43_col_0_bisr_inst_Q, 
                   ram_row_44_col_0_bisr_inst_Q, ram_row_45_col_0_bisr_inst_Q, 
                   ram_row_46_col_0_bisr_inst_Q, ram_row_47_col_0_bisr_inst_Q, 
                   ram_row_48_col_0_bisr_inst_Q, ram_row_49_col_0_bisr_inst_Q, 
                   ram_row_4_col_0_bisr_inst_Q, ram_row_50_col_0_bisr_inst_Q, 
                   ram_row_51_col_0_bisr_inst_Q, ram_row_52_col_0_bisr_inst_Q, 
                   ram_row_53_col_0_bisr_inst_Q, ram_row_54_col_0_bisr_inst_Q, 
                   ram_row_55_col_0_bisr_inst_Q, ram_row_56_col_0_bisr_inst_Q, 
                   ram_row_57_col_0_bisr_inst_Q, ram_row_58_col_0_bisr_inst_Q, 
                   ram_row_59_col_0_bisr_inst_Q, ram_row_5_col_0_bisr_inst_Q, 
                   ram_row_60_col_0_bisr_inst_Q, ram_row_61_col_0_bisr_inst_Q, 
                   ram_row_62_col_0_bisr_inst_Q, ram_row_63_col_0_bisr_inst_Q, 
                   ram_row_6_col_0_bisr_inst_Q, ram_row_7_col_0_bisr_inst_Q, 
                   ram_row_8_col_0_bisr_inst_Q, ram_row_9_col_0_bisr_inst_Q;
        wire WREN_P0, WREN_P0_ts1, WREN_P0_ts2, WREN_P0_ts3, WREN_P0_ts4, 
             WREN_P0_ts5, WREN_P0_ts6, WREN_P0_ts7, WREN_P0_ts8, WREN_P0_ts9, 
             WREN_P0_ts10, WREN_P0_ts11, WREN_P0_ts12, WREN_P0_ts13, 
             WREN_P0_ts14, WREN_P0_ts15, WREN_P0_ts16, WREN_P0_ts17, 
             WREN_P0_ts18, WREN_P0_ts19, WREN_P0_ts20, WREN_P0_ts21, 
             WREN_P0_ts22, WREN_P0_ts23, WREN_P0_ts24, WREN_P0_ts25, 
             WREN_P0_ts26, WREN_P0_ts27, WREN_P0_ts28, WREN_P0_ts29, 
             WREN_P0_ts30, WREN_P0_ts31, WREN_P0_ts32, WREN_P0_ts33, 
             WREN_P0_ts34, WREN_P0_ts35, WREN_P0_ts36, WREN_P0_ts37, 
             WREN_P0_ts38, WREN_P0_ts39, WREN_P0_ts40, WREN_P0_ts41, 
             WREN_P0_ts42, WREN_P0_ts43, WREN_P0_ts44, WREN_P0_ts45, 
             WREN_P0_ts46, WREN_P0_ts47, WREN_P0_ts48, WREN_P0_ts49, 
             WREN_P0_ts50, WREN_P0_ts51, WREN_P0_ts52, WREN_P0_ts53, 
             WREN_P0_ts54, WREN_P0_ts55, WREN_P0_ts56, WREN_P0_ts57, 
             WREN_P0_ts58, WREN_P0_ts59, WREN_P0_ts60, WREN_P0_ts61, 
             WREN_P0_ts62, WREN_P0_ts63, WREN_P1, WREN_P1_ts1, WREN_P1_ts2, 
             WREN_P1_ts3, WREN_P1_ts4, WREN_P1_ts5, WREN_P1_ts6, WREN_P1_ts7, 
             WREN_P1_ts8, WREN_P1_ts9, WREN_P1_ts10, WREN_P1_ts11, WREN_P1_ts12, 
             WREN_P1_ts13, WREN_P1_ts14, WREN_P1_ts15, WREN_P1_ts16, 
             WREN_P1_ts17, WREN_P1_ts18, WREN_P1_ts19, WREN_P1_ts20, 
             WREN_P1_ts21, WREN_P1_ts22, WREN_P1_ts23, WREN_P1_ts24, 
             WREN_P1_ts25, WREN_P1_ts26, WREN_P1_ts27, WREN_P1_ts28, 
             WREN_P1_ts29, WREN_P1_ts30, WREN_P1_ts31, WREN_P1_ts32, 
             WREN_P1_ts33, WREN_P1_ts34, WREN_P1_ts35, WREN_P1_ts36, 
             WREN_P1_ts37, WREN_P1_ts38, WREN_P1_ts39, WREN_P1_ts40, 
             WREN_P1_ts41, WREN_P1_ts42, WREN_P1_ts43, WREN_P1_ts44, 
             WREN_P1_ts45, WREN_P1_ts46, WREN_P1_ts47, WREN_P1_ts48, 
             WREN_P1_ts49, WREN_P1_ts50, WREN_P1_ts51, WREN_P1_ts52, 
             WREN_P1_ts53, WREN_P1_ts54, WREN_P1_ts55, WREN_P1_ts56, 
             WREN_P1_ts57, WREN_P1_ts58, WREN_P1_ts59, WREN_P1_ts60, 
             WREN_P1_ts61, WREN_P1_ts62, WREN_P1_ts63, RDEN_P0, RDEN_P0_ts1, 
             RDEN_P0_ts2, RDEN_P0_ts3, RDEN_P0_ts4, RDEN_P0_ts5, RDEN_P0_ts6, 
             RDEN_P0_ts7, RDEN_P0_ts8, RDEN_P0_ts9, RDEN_P0_ts10, RDEN_P0_ts11, 
             RDEN_P0_ts12, RDEN_P0_ts13, RDEN_P0_ts14, RDEN_P0_ts15, 
             RDEN_P0_ts16, RDEN_P0_ts17, RDEN_P0_ts18, RDEN_P0_ts19, 
             RDEN_P0_ts20, RDEN_P0_ts21, RDEN_P0_ts22, RDEN_P0_ts23, 
             RDEN_P0_ts24, RDEN_P0_ts25, RDEN_P0_ts26, RDEN_P0_ts27, 
             RDEN_P0_ts28, RDEN_P0_ts29, RDEN_P0_ts30, RDEN_P0_ts31, 
             RDEN_P0_ts32, RDEN_P0_ts33, RDEN_P0_ts34, RDEN_P0_ts35, 
             RDEN_P0_ts36, RDEN_P0_ts37, RDEN_P0_ts38, RDEN_P0_ts39, 
             RDEN_P0_ts40, RDEN_P0_ts41, RDEN_P0_ts42, RDEN_P0_ts43, 
             RDEN_P0_ts44, RDEN_P0_ts45, RDEN_P0_ts46, RDEN_P0_ts47, 
             RDEN_P0_ts48, RDEN_P0_ts49, RDEN_P0_ts50, RDEN_P0_ts51, 
             RDEN_P0_ts52, RDEN_P0_ts53, RDEN_P0_ts54, RDEN_P0_ts55, 
             RDEN_P0_ts56, RDEN_P0_ts57, RDEN_P0_ts58, RDEN_P0_ts59, 
             RDEN_P0_ts60, RDEN_P0_ts61, RDEN_P0_ts62, RDEN_P0_ts63, RDEN_P1, 
             RDEN_P1_ts1, RDEN_P1_ts2, RDEN_P1_ts3, RDEN_P1_ts4, RDEN_P1_ts5, 
             RDEN_P1_ts6, RDEN_P1_ts7, RDEN_P1_ts8, RDEN_P1_ts9, RDEN_P1_ts10, 
             RDEN_P1_ts11, RDEN_P1_ts12, RDEN_P1_ts13, RDEN_P1_ts14, 
             RDEN_P1_ts15, RDEN_P1_ts16, RDEN_P1_ts17, RDEN_P1_ts18, 
             RDEN_P1_ts19, RDEN_P1_ts20, RDEN_P1_ts21, RDEN_P1_ts22, 
             RDEN_P1_ts23, RDEN_P1_ts24, RDEN_P1_ts25, RDEN_P1_ts26, 
             RDEN_P1_ts27, RDEN_P1_ts28, RDEN_P1_ts29, RDEN_P1_ts30, 
             RDEN_P1_ts31, RDEN_P1_ts32, RDEN_P1_ts33, RDEN_P1_ts34, 
             RDEN_P1_ts35, RDEN_P1_ts36, RDEN_P1_ts37, RDEN_P1_ts38, 
             RDEN_P1_ts39, RDEN_P1_ts40, RDEN_P1_ts41, RDEN_P1_ts42, 
             RDEN_P1_ts43, RDEN_P1_ts44, RDEN_P1_ts45, RDEN_P1_ts46, 
             RDEN_P1_ts47, RDEN_P1_ts48, RDEN_P1_ts49, RDEN_P1_ts50, 
             RDEN_P1_ts51, RDEN_P1_ts52, RDEN_P1_ts53, RDEN_P1_ts54, 
             RDEN_P1_ts55, RDEN_P1_ts56, RDEN_P1_ts57, RDEN_P1_ts58, 
             RDEN_P1_ts59, RDEN_P1_ts60, RDEN_P1_ts61, RDEN_P1_ts62, 
             RDEN_P1_ts63, ram_row_0_col_0_bisr_inst_SO_ts1, 
             ram_row_10_col_0_bisr_inst_SO, ram_row_11_col_0_bisr_inst_SO, 
             ram_row_12_col_0_bisr_inst_SO, ram_row_13_col_0_bisr_inst_SO, 
             ram_row_14_col_0_bisr_inst_SO, ram_row_15_col_0_bisr_inst_SO, 
             ram_row_16_col_0_bisr_inst_SO, ram_row_17_col_0_bisr_inst_SO, 
             ram_row_18_col_0_bisr_inst_SO, ram_row_19_col_0_bisr_inst_SO, 
             ram_row_1_col_0_bisr_inst_SO, ram_row_20_col_0_bisr_inst_SO, 
             ram_row_21_col_0_bisr_inst_SO, ram_row_22_col_0_bisr_inst_SO, 
             ram_row_23_col_0_bisr_inst_SO, ram_row_24_col_0_bisr_inst_SO, 
             ram_row_25_col_0_bisr_inst_SO, ram_row_26_col_0_bisr_inst_SO, 
             ram_row_27_col_0_bisr_inst_SO, ram_row_28_col_0_bisr_inst_SO, 
             ram_row_29_col_0_bisr_inst_SO, ram_row_2_col_0_bisr_inst_SO, 
             ram_row_30_col_0_bisr_inst_SO, ram_row_31_col_0_bisr_inst_SO, 
             ram_row_32_col_0_bisr_inst_SO, ram_row_33_col_0_bisr_inst_SO, 
             ram_row_34_col_0_bisr_inst_SO, ram_row_35_col_0_bisr_inst_SO, 
             ram_row_36_col_0_bisr_inst_SO, ram_row_37_col_0_bisr_inst_SO, 
             ram_row_38_col_0_bisr_inst_SO, ram_row_39_col_0_bisr_inst_SO, 
             ram_row_3_col_0_bisr_inst_SO, ram_row_40_col_0_bisr_inst_SO, 
             ram_row_41_col_0_bisr_inst_SO, ram_row_42_col_0_bisr_inst_SO, 
             ram_row_43_col_0_bisr_inst_SO, ram_row_44_col_0_bisr_inst_SO, 
             ram_row_45_col_0_bisr_inst_SO, ram_row_46_col_0_bisr_inst_SO, 
             ram_row_47_col_0_bisr_inst_SO, ram_row_48_col_0_bisr_inst_SO, 
             ram_row_49_col_0_bisr_inst_SO, ram_row_4_col_0_bisr_inst_SO, 
             ram_row_50_col_0_bisr_inst_SO, ram_row_51_col_0_bisr_inst_SO, 
             ram_row_52_col_0_bisr_inst_SO, ram_row_53_col_0_bisr_inst_SO, 
             ram_row_54_col_0_bisr_inst_SO, ram_row_55_col_0_bisr_inst_SO, 
             ram_row_56_col_0_bisr_inst_SO, ram_row_57_col_0_bisr_inst_SO, 
             ram_row_58_col_0_bisr_inst_SO, ram_row_59_col_0_bisr_inst_SO, 
             ram_row_5_col_0_bisr_inst_SO, ram_row_60_col_0_bisr_inst_SO, 
             ram_row_61_col_0_bisr_inst_SO, ram_row_62_col_0_bisr_inst_SO, 
             ram_row_63_col_0_bisr_inst_SO, ram_row_6_col_0_bisr_inst_SO, 
             ram_row_7_col_0_bisr_inst_SO, ram_row_8_col_0_bisr_inst_SO, 
             All_SCOL0_ALLOC_REG, All_SCOL0_ALLOC_REG_ts1, 
             All_SCOL0_ALLOC_REG_ts2, All_SCOL0_ALLOC_REG_ts3, 
             All_SCOL0_ALLOC_REG_ts4, All_SCOL0_ALLOC_REG_ts5, 
             All_SCOL0_ALLOC_REG_ts6, All_SCOL0_ALLOC_REG_ts7, 
             All_SCOL0_ALLOC_REG_ts8, All_SCOL0_ALLOC_REG_ts9, 
             All_SCOL0_ALLOC_REG_ts10, All_SCOL0_ALLOC_REG_ts11, 
             All_SCOL0_ALLOC_REG_ts12, All_SCOL0_ALLOC_REG_ts13, 
             All_SCOL0_ALLOC_REG_ts14, All_SCOL0_ALLOC_REG_ts15, 
             All_SCOL0_ALLOC_REG_ts16, All_SCOL0_ALLOC_REG_ts17, 
             All_SCOL0_ALLOC_REG_ts18, All_SCOL0_ALLOC_REG_ts19, 
             All_SCOL0_ALLOC_REG_ts20, All_SCOL0_ALLOC_REG_ts21, 
             All_SCOL0_ALLOC_REG_ts22, All_SCOL0_ALLOC_REG_ts23, 
             All_SCOL0_ALLOC_REG_ts24, All_SCOL0_ALLOC_REG_ts25, 
             All_SCOL0_ALLOC_REG_ts26, All_SCOL0_ALLOC_REG_ts27, 
             All_SCOL0_ALLOC_REG_ts28, All_SCOL0_ALLOC_REG_ts29, 
             All_SCOL0_ALLOC_REG_ts30, All_SCOL0_ALLOC_REG_ts31, 
             All_SCOL0_ALLOC_REG_ts32, All_SCOL0_ALLOC_REG_ts33, 
             All_SCOL0_ALLOC_REG_ts34, All_SCOL0_ALLOC_REG_ts35, 
             All_SCOL0_ALLOC_REG_ts36, All_SCOL0_ALLOC_REG_ts37, 
             All_SCOL0_ALLOC_REG_ts38, All_SCOL0_ALLOC_REG_ts39, 
             All_SCOL0_ALLOC_REG_ts40, All_SCOL0_ALLOC_REG_ts41, 
             All_SCOL0_ALLOC_REG_ts42, All_SCOL0_ALLOC_REG_ts43, 
             All_SCOL0_ALLOC_REG_ts44, All_SCOL0_ALLOC_REG_ts45, 
             All_SCOL0_ALLOC_REG_ts46, All_SCOL0_ALLOC_REG_ts47, 
             All_SCOL0_ALLOC_REG_ts48, All_SCOL0_ALLOC_REG_ts49, 
             All_SCOL0_ALLOC_REG_ts50, All_SCOL0_ALLOC_REG_ts51, 
             All_SCOL0_ALLOC_REG_ts52, All_SCOL0_ALLOC_REG_ts53, 
             All_SCOL0_ALLOC_REG_ts54, All_SCOL0_ALLOC_REG_ts55, 
             All_SCOL0_ALLOC_REG_ts56, All_SCOL0_ALLOC_REG_ts57, 
             All_SCOL0_ALLOC_REG_ts58, All_SCOL0_ALLOC_REG_ts59, 
             All_SCOL0_ALLOC_REG_ts60, All_SCOL0_ALLOC_REG_ts61, 
             All_SCOL0_ALLOC_REG_ts62, All_SCOL0_ALLOC_REG_ts63;
        wire [5:0] All_SCOL0_FUSE_REG, All_SCOL0_FUSE_REG_ts1, 
                   All_SCOL0_FUSE_REG_ts2, All_SCOL0_FUSE_REG_ts3, 
                   All_SCOL0_FUSE_REG_ts4, All_SCOL0_FUSE_REG_ts5, 
                   All_SCOL0_FUSE_REG_ts6, All_SCOL0_FUSE_REG_ts7, 
                   All_SCOL0_FUSE_REG_ts8, All_SCOL0_FUSE_REG_ts9, 
                   All_SCOL0_FUSE_REG_ts10, All_SCOL0_FUSE_REG_ts11, 
                   All_SCOL0_FUSE_REG_ts12, All_SCOL0_FUSE_REG_ts13, 
                   All_SCOL0_FUSE_REG_ts14, All_SCOL0_FUSE_REG_ts15, 
                   All_SCOL0_FUSE_REG_ts16, All_SCOL0_FUSE_REG_ts17, 
                   All_SCOL0_FUSE_REG_ts18, All_SCOL0_FUSE_REG_ts19, 
                   All_SCOL0_FUSE_REG_ts20, All_SCOL0_FUSE_REG_ts21, 
                   All_SCOL0_FUSE_REG_ts22, All_SCOL0_FUSE_REG_ts23, 
                   All_SCOL0_FUSE_REG_ts24, All_SCOL0_FUSE_REG_ts25, 
                   All_SCOL0_FUSE_REG_ts26, All_SCOL0_FUSE_REG_ts27, 
                   All_SCOL0_FUSE_REG_ts28, All_SCOL0_FUSE_REG_ts29, 
                   All_SCOL0_FUSE_REG_ts30, All_SCOL0_FUSE_REG_ts31, 
                   All_SCOL0_FUSE_REG_ts32, All_SCOL0_FUSE_REG_ts33, 
                   All_SCOL0_FUSE_REG_ts34, All_SCOL0_FUSE_REG_ts35, 
                   All_SCOL0_FUSE_REG_ts36, All_SCOL0_FUSE_REG_ts37, 
                   All_SCOL0_FUSE_REG_ts38, All_SCOL0_FUSE_REG_ts39, 
                   All_SCOL0_FUSE_REG_ts40, All_SCOL0_FUSE_REG_ts41, 
                   All_SCOL0_FUSE_REG_ts42, All_SCOL0_FUSE_REG_ts43, 
                   All_SCOL0_FUSE_REG_ts44, All_SCOL0_FUSE_REG_ts45, 
                   All_SCOL0_FUSE_REG_ts46, All_SCOL0_FUSE_REG_ts47, 
                   All_SCOL0_FUSE_REG_ts48, All_SCOL0_FUSE_REG_ts49, 
                   All_SCOL0_FUSE_REG_ts50, All_SCOL0_FUSE_REG_ts51, 
                   All_SCOL0_FUSE_REG_ts52, All_SCOL0_FUSE_REG_ts53, 
                   All_SCOL0_FUSE_REG_ts54, All_SCOL0_FUSE_REG_ts55, 
                   All_SCOL0_FUSE_REG_ts56, All_SCOL0_FUSE_REG_ts57, 
                   All_SCOL0_FUSE_REG_ts58, All_SCOL0_FUSE_REG_ts59, 
                   All_SCOL0_FUSE_REG_ts60, All_SCOL0_FUSE_REG_ts61, 
                   All_SCOL0_FUSE_REG_ts62, All_SCOL0_FUSE_REG_ts63;
        assign                         {wrap_shell_to_mem_b, wrap_shell_to_mem_a}       = wrap_shell_to_mem     ;

        // Disassembling the to_mem bus
        wire                            reset_n         = wrap_shell_to_mem_a[2*MEM_WIDTH-MEM_PROT_TOTAL_WIDTH+(2*MEM_ADR_WIDTH)+MEM_WR_EN_WIDTH+MEM_RM_WIDTH+2 +:1                     ];
        wire                            mem_rm_e        = wrap_shell_to_mem_a[2*MEM_WIDTH-MEM_PROT_TOTAL_WIDTH+(2*MEM_ADR_WIDTH)+MEM_WR_EN_WIDTH+MEM_RM_WIDTH+1             +:1                     ];
        wire    [   MEM_RM_WIDTH-1:0]   mem_rm          = wrap_shell_to_mem_a[2*MEM_WIDTH-MEM_PROT_TOTAL_WIDTH+(2*MEM_ADR_WIDTH)+MEM_WR_EN_WIDTH+1             +:MEM_RM_WIDTH          ];

        wire                            rd_en_a         = wrap_shell_to_mem_a[2*MEM_WIDTH-MEM_PROT_TOTAL_WIDTH+(2*MEM_ADR_WIDTH)+MEM_WR_EN_WIDTH               +:1                     ];
        wire    [MEM_WR_EN_WIDTH-1:0]   wr_en_a         = wrap_shell_to_mem_a[2*MEM_WIDTH-MEM_PROT_TOTAL_WIDTH+(2*MEM_ADR_WIDTH)                               +:MEM_WR_EN_WIDTH       ];
        wire    [  MEM_ADR_WIDTH-1:0]   rd_adr_a        = wrap_shell_to_mem_a[2*MEM_WIDTH-MEM_PROT_TOTAL_WIDTH+MEM_ADR_WIDTH                                  +:MEM_ADR_WIDTH         ];
        wire    [  MEM_ADR_WIDTH-1:0]   wr_adr_a        = wrap_shell_to_mem_a[2*MEM_WIDTH - MEM_PROT_TOTAL_WIDTH                                                 +:MEM_ADR_WIDTH         ];
        //Next line added by SIVAKUMA for wr_data_orig
        wire    [      MEM_WIDTH-MEM_PROT_TOTAL_WIDTH-1:0]   wr_data_orig_a    = wrap_shell_to_mem_a[MEM_WIDTH                                                   +:MEM_WIDTH - MEM_PROT_TOTAL_WIDTH             ];
        wire    [      MEM_WIDTH-1:0]   wr_data_a       = wrap_shell_to_mem_a[0                                                         +:MEM_WIDTH             ];


        wire                            rd_en_b         = wrap_shell_to_mem_b[2*MEM_WIDTH-MEM_PROT_TOTAL_WIDTH+(2*MEM_ADR_WIDTH)+MEM_WR_EN_WIDTH               +:1                     ];
        wire    [MEM_WR_EN_WIDTH-1:0]   wr_en_b         = wrap_shell_to_mem_b[2*MEM_WIDTH-MEM_PROT_TOTAL_WIDTH+(2*MEM_ADR_WIDTH)                               +:MEM_WR_EN_WIDTH       ];
        wire    [  MEM_ADR_WIDTH-1:0]   rd_adr_b        = wrap_shell_to_mem_b[2*MEM_WIDTH-MEM_PROT_TOTAL_WIDTH+MEM_ADR_WIDTH                                  +:MEM_ADR_WIDTH         ];
        wire    [  MEM_ADR_WIDTH-1:0]   wr_adr_b        = wrap_shell_to_mem_b[2*MEM_WIDTH - MEM_PROT_TOTAL_WIDTH                                                 +:MEM_ADR_WIDTH         ];
        //Next line added by SIVAKUMA for wr_data_orig
        wire    [      MEM_WIDTH-MEM_PROT_TOTAL_WIDTH-1:0]   wr_data_orig_b    = wrap_shell_to_mem_b[MEM_WIDTH                                                   +:MEM_WIDTH - MEM_PROT_TOTAL_WIDTH             ];
        wire    [      MEM_WIDTH-1:0]   wr_data_b       = wrap_shell_to_mem_b[0                                                         +:MEM_WIDTH             ];


        // Assembling the from_mem bus
        wire    [FROM_MEM_WIDTH/2-1:0]  wrap_shell_from_mem_b, wrap_shell_from_mem_a                                                    ;
        wire                            rd_valid_a                                                                                      ;
        wire    [      MEM_WIDTH-1:0]   rd_data_a                                                                                       ;
        wire                            rd_valid_b                                                                                      ;
        wire    [      MEM_WIDTH-1:0]   rd_data_b                                                                                       ;
        assign                          wrap_shell_from_mem_a[0]                = rd_valid_a                                            ;
        assign                          wrap_shell_from_mem_a[1+:MEM_WIDTH]     = rd_data_a                                             ;
        assign                          wrap_shell_from_mem_b[0]                = rd_valid_b                                            ;
        assign                          wrap_shell_from_mem_b[1+:MEM_WIDTH]     = rd_data_b                                             ;
        assign                          wrap_shell_from_mem                     = {wrap_shell_from_mem_b, wrap_shell_from_mem_a}        ;

`ifdef DC
        `ifndef HLP_SCHED_ASIC_MEMS_EXCLUDE
                `define HLP_SCHED_ASIC_MEMS
        `endif
`endif

        // Memories Implementation
`ifdef HLP_SCHED_ASIC_MEMS

////////////////////////////////////////////////////////////////////////
//
//                              ASIC MEMORIES                                                                                                                   
//
////////////////////////////////////////////////////////////////////////
        


    // RAM Row Select

    wire    [64-1:0]                wr_ram_row_sel_a;
    wire    [64-1:0]                wr_ram_row_sel_b;
    wire    [64-1:0]                rd_ram_row_sel_a;
    wire    [64-1:0]                rd_ram_row_sel_b;
    assign                    wr_ram_row_sel_a[0]        = ((wr_adr_a>=14'd0) && (wr_adr_a<14'd256));
    assign                    wr_ram_row_sel_b[0]        = ((wr_adr_b>=14'd0) && (wr_adr_b<14'd256));
    assign                    rd_ram_row_sel_a[0]        = ((rd_adr_a>=14'd0) && (rd_adr_a<14'd256));
    assign                    rd_ram_row_sel_b[0]        = ((rd_adr_b>=14'd0) && (rd_adr_b<14'd256));
    assign                    wr_ram_row_sel_a[1]        = ((wr_adr_a>=14'd256) && (wr_adr_a<14'd512));
    assign                    wr_ram_row_sel_b[1]        = ((wr_adr_b>=14'd256) && (wr_adr_b<14'd512));
    assign                    rd_ram_row_sel_a[1]        = ((rd_adr_a>=14'd256) && (rd_adr_a<14'd512));
    assign                    rd_ram_row_sel_b[1]        = ((rd_adr_b>=14'd256) && (rd_adr_b<14'd512));
    assign                    wr_ram_row_sel_a[2]        = ((wr_adr_a>=14'd512) && (wr_adr_a<14'd768));
    assign                    wr_ram_row_sel_b[2]        = ((wr_adr_b>=14'd512) && (wr_adr_b<14'd768));
    assign                    rd_ram_row_sel_a[2]        = ((rd_adr_a>=14'd512) && (rd_adr_a<14'd768));
    assign                    rd_ram_row_sel_b[2]        = ((rd_adr_b>=14'd512) && (rd_adr_b<14'd768));
    assign                    wr_ram_row_sel_a[3]        = ((wr_adr_a>=14'd768) && (wr_adr_a<14'd1024));
    assign                    wr_ram_row_sel_b[3]        = ((wr_adr_b>=14'd768) && (wr_adr_b<14'd1024));
    assign                    rd_ram_row_sel_a[3]        = ((rd_adr_a>=14'd768) && (rd_adr_a<14'd1024));
    assign                    rd_ram_row_sel_b[3]        = ((rd_adr_b>=14'd768) && (rd_adr_b<14'd1024));
    assign                    wr_ram_row_sel_a[4]        = ((wr_adr_a>=14'd1024) && (wr_adr_a<14'd1280));
    assign                    wr_ram_row_sel_b[4]        = ((wr_adr_b>=14'd1024) && (wr_adr_b<14'd1280));
    assign                    rd_ram_row_sel_a[4]        = ((rd_adr_a>=14'd1024) && (rd_adr_a<14'd1280));
    assign                    rd_ram_row_sel_b[4]        = ((rd_adr_b>=14'd1024) && (rd_adr_b<14'd1280));
    assign                    wr_ram_row_sel_a[5]        = ((wr_adr_a>=14'd1280) && (wr_adr_a<14'd1536));
    assign                    wr_ram_row_sel_b[5]        = ((wr_adr_b>=14'd1280) && (wr_adr_b<14'd1536));
    assign                    rd_ram_row_sel_a[5]        = ((rd_adr_a>=14'd1280) && (rd_adr_a<14'd1536));
    assign                    rd_ram_row_sel_b[5]        = ((rd_adr_b>=14'd1280) && (rd_adr_b<14'd1536));
    assign                    wr_ram_row_sel_a[6]        = ((wr_adr_a>=14'd1536) && (wr_adr_a<14'd1792));
    assign                    wr_ram_row_sel_b[6]        = ((wr_adr_b>=14'd1536) && (wr_adr_b<14'd1792));
    assign                    rd_ram_row_sel_a[6]        = ((rd_adr_a>=14'd1536) && (rd_adr_a<14'd1792));
    assign                    rd_ram_row_sel_b[6]        = ((rd_adr_b>=14'd1536) && (rd_adr_b<14'd1792));
    assign                    wr_ram_row_sel_a[7]        = ((wr_adr_a>=14'd1792) && (wr_adr_a<14'd2048));
    assign                    wr_ram_row_sel_b[7]        = ((wr_adr_b>=14'd1792) && (wr_adr_b<14'd2048));
    assign                    rd_ram_row_sel_a[7]        = ((rd_adr_a>=14'd1792) && (rd_adr_a<14'd2048));
    assign                    rd_ram_row_sel_b[7]        = ((rd_adr_b>=14'd1792) && (rd_adr_b<14'd2048));
    assign                    wr_ram_row_sel_a[8]        = ((wr_adr_a>=14'd2048) && (wr_adr_a<14'd2304));
    assign                    wr_ram_row_sel_b[8]        = ((wr_adr_b>=14'd2048) && (wr_adr_b<14'd2304));
    assign                    rd_ram_row_sel_a[8]        = ((rd_adr_a>=14'd2048) && (rd_adr_a<14'd2304));
    assign                    rd_ram_row_sel_b[8]        = ((rd_adr_b>=14'd2048) && (rd_adr_b<14'd2304));
    assign                    wr_ram_row_sel_a[9]        = ((wr_adr_a>=14'd2304) && (wr_adr_a<14'd2560));
    assign                    wr_ram_row_sel_b[9]        = ((wr_adr_b>=14'd2304) && (wr_adr_b<14'd2560));
    assign                    rd_ram_row_sel_a[9]        = ((rd_adr_a>=14'd2304) && (rd_adr_a<14'd2560));
    assign                    rd_ram_row_sel_b[9]        = ((rd_adr_b>=14'd2304) && (rd_adr_b<14'd2560));
    assign                    wr_ram_row_sel_a[10]        = ((wr_adr_a>=14'd2560) && (wr_adr_a<14'd2816));
    assign                    wr_ram_row_sel_b[10]        = ((wr_adr_b>=14'd2560) && (wr_adr_b<14'd2816));
    assign                    rd_ram_row_sel_a[10]        = ((rd_adr_a>=14'd2560) && (rd_adr_a<14'd2816));
    assign                    rd_ram_row_sel_b[10]        = ((rd_adr_b>=14'd2560) && (rd_adr_b<14'd2816));
    assign                    wr_ram_row_sel_a[11]        = ((wr_adr_a>=14'd2816) && (wr_adr_a<14'd3072));
    assign                    wr_ram_row_sel_b[11]        = ((wr_adr_b>=14'd2816) && (wr_adr_b<14'd3072));
    assign                    rd_ram_row_sel_a[11]        = ((rd_adr_a>=14'd2816) && (rd_adr_a<14'd3072));
    assign                    rd_ram_row_sel_b[11]        = ((rd_adr_b>=14'd2816) && (rd_adr_b<14'd3072));
    assign                    wr_ram_row_sel_a[12]        = ((wr_adr_a>=14'd3072) && (wr_adr_a<14'd3328));
    assign                    wr_ram_row_sel_b[12]        = ((wr_adr_b>=14'd3072) && (wr_adr_b<14'd3328));
    assign                    rd_ram_row_sel_a[12]        = ((rd_adr_a>=14'd3072) && (rd_adr_a<14'd3328));
    assign                    rd_ram_row_sel_b[12]        = ((rd_adr_b>=14'd3072) && (rd_adr_b<14'd3328));
    assign                    wr_ram_row_sel_a[13]        = ((wr_adr_a>=14'd3328) && (wr_adr_a<14'd3584));
    assign                    wr_ram_row_sel_b[13]        = ((wr_adr_b>=14'd3328) && (wr_adr_b<14'd3584));
    assign                    rd_ram_row_sel_a[13]        = ((rd_adr_a>=14'd3328) && (rd_adr_a<14'd3584));
    assign                    rd_ram_row_sel_b[13]        = ((rd_adr_b>=14'd3328) && (rd_adr_b<14'd3584));
    assign                    wr_ram_row_sel_a[14]        = ((wr_adr_a>=14'd3584) && (wr_adr_a<14'd3840));
    assign                    wr_ram_row_sel_b[14]        = ((wr_adr_b>=14'd3584) && (wr_adr_b<14'd3840));
    assign                    rd_ram_row_sel_a[14]        = ((rd_adr_a>=14'd3584) && (rd_adr_a<14'd3840));
    assign                    rd_ram_row_sel_b[14]        = ((rd_adr_b>=14'd3584) && (rd_adr_b<14'd3840));
    assign                    wr_ram_row_sel_a[15]        = ((wr_adr_a>=14'd3840) && (wr_adr_a<14'd4096));
    assign                    wr_ram_row_sel_b[15]        = ((wr_adr_b>=14'd3840) && (wr_adr_b<14'd4096));
    assign                    rd_ram_row_sel_a[15]        = ((rd_adr_a>=14'd3840) && (rd_adr_a<14'd4096));
    assign                    rd_ram_row_sel_b[15]        = ((rd_adr_b>=14'd3840) && (rd_adr_b<14'd4096));
    assign                    wr_ram_row_sel_a[16]        = ((wr_adr_a>=14'd4096) && (wr_adr_a<14'd4352));
    assign                    wr_ram_row_sel_b[16]        = ((wr_adr_b>=14'd4096) && (wr_adr_b<14'd4352));
    assign                    rd_ram_row_sel_a[16]        = ((rd_adr_a>=14'd4096) && (rd_adr_a<14'd4352));
    assign                    rd_ram_row_sel_b[16]        = ((rd_adr_b>=14'd4096) && (rd_adr_b<14'd4352));
    assign                    wr_ram_row_sel_a[17]        = ((wr_adr_a>=14'd4352) && (wr_adr_a<14'd4608));
    assign                    wr_ram_row_sel_b[17]        = ((wr_adr_b>=14'd4352) && (wr_adr_b<14'd4608));
    assign                    rd_ram_row_sel_a[17]        = ((rd_adr_a>=14'd4352) && (rd_adr_a<14'd4608));
    assign                    rd_ram_row_sel_b[17]        = ((rd_adr_b>=14'd4352) && (rd_adr_b<14'd4608));
    assign                    wr_ram_row_sel_a[18]        = ((wr_adr_a>=14'd4608) && (wr_adr_a<14'd4864));
    assign                    wr_ram_row_sel_b[18]        = ((wr_adr_b>=14'd4608) && (wr_adr_b<14'd4864));
    assign                    rd_ram_row_sel_a[18]        = ((rd_adr_a>=14'd4608) && (rd_adr_a<14'd4864));
    assign                    rd_ram_row_sel_b[18]        = ((rd_adr_b>=14'd4608) && (rd_adr_b<14'd4864));
    assign                    wr_ram_row_sel_a[19]        = ((wr_adr_a>=14'd4864) && (wr_adr_a<14'd5120));
    assign                    wr_ram_row_sel_b[19]        = ((wr_adr_b>=14'd4864) && (wr_adr_b<14'd5120));
    assign                    rd_ram_row_sel_a[19]        = ((rd_adr_a>=14'd4864) && (rd_adr_a<14'd5120));
    assign                    rd_ram_row_sel_b[19]        = ((rd_adr_b>=14'd4864) && (rd_adr_b<14'd5120));
    assign                    wr_ram_row_sel_a[20]        = ((wr_adr_a>=14'd5120) && (wr_adr_a<14'd5376));
    assign                    wr_ram_row_sel_b[20]        = ((wr_adr_b>=14'd5120) && (wr_adr_b<14'd5376));
    assign                    rd_ram_row_sel_a[20]        = ((rd_adr_a>=14'd5120) && (rd_adr_a<14'd5376));
    assign                    rd_ram_row_sel_b[20]        = ((rd_adr_b>=14'd5120) && (rd_adr_b<14'd5376));
    assign                    wr_ram_row_sel_a[21]        = ((wr_adr_a>=14'd5376) && (wr_adr_a<14'd5632));
    assign                    wr_ram_row_sel_b[21]        = ((wr_adr_b>=14'd5376) && (wr_adr_b<14'd5632));
    assign                    rd_ram_row_sel_a[21]        = ((rd_adr_a>=14'd5376) && (rd_adr_a<14'd5632));
    assign                    rd_ram_row_sel_b[21]        = ((rd_adr_b>=14'd5376) && (rd_adr_b<14'd5632));
    assign                    wr_ram_row_sel_a[22]        = ((wr_adr_a>=14'd5632) && (wr_adr_a<14'd5888));
    assign                    wr_ram_row_sel_b[22]        = ((wr_adr_b>=14'd5632) && (wr_adr_b<14'd5888));
    assign                    rd_ram_row_sel_a[22]        = ((rd_adr_a>=14'd5632) && (rd_adr_a<14'd5888));
    assign                    rd_ram_row_sel_b[22]        = ((rd_adr_b>=14'd5632) && (rd_adr_b<14'd5888));
    assign                    wr_ram_row_sel_a[23]        = ((wr_adr_a>=14'd5888) && (wr_adr_a<14'd6144));
    assign                    wr_ram_row_sel_b[23]        = ((wr_adr_b>=14'd5888) && (wr_adr_b<14'd6144));
    assign                    rd_ram_row_sel_a[23]        = ((rd_adr_a>=14'd5888) && (rd_adr_a<14'd6144));
    assign                    rd_ram_row_sel_b[23]        = ((rd_adr_b>=14'd5888) && (rd_adr_b<14'd6144));
    assign                    wr_ram_row_sel_a[24]        = ((wr_adr_a>=14'd6144) && (wr_adr_a<14'd6400));
    assign                    wr_ram_row_sel_b[24]        = ((wr_adr_b>=14'd6144) && (wr_adr_b<14'd6400));
    assign                    rd_ram_row_sel_a[24]        = ((rd_adr_a>=14'd6144) && (rd_adr_a<14'd6400));
    assign                    rd_ram_row_sel_b[24]        = ((rd_adr_b>=14'd6144) && (rd_adr_b<14'd6400));
    assign                    wr_ram_row_sel_a[25]        = ((wr_adr_a>=14'd6400) && (wr_adr_a<14'd6656));
    assign                    wr_ram_row_sel_b[25]        = ((wr_adr_b>=14'd6400) && (wr_adr_b<14'd6656));
    assign                    rd_ram_row_sel_a[25]        = ((rd_adr_a>=14'd6400) && (rd_adr_a<14'd6656));
    assign                    rd_ram_row_sel_b[25]        = ((rd_adr_b>=14'd6400) && (rd_adr_b<14'd6656));
    assign                    wr_ram_row_sel_a[26]        = ((wr_adr_a>=14'd6656) && (wr_adr_a<14'd6912));
    assign                    wr_ram_row_sel_b[26]        = ((wr_adr_b>=14'd6656) && (wr_adr_b<14'd6912));
    assign                    rd_ram_row_sel_a[26]        = ((rd_adr_a>=14'd6656) && (rd_adr_a<14'd6912));
    assign                    rd_ram_row_sel_b[26]        = ((rd_adr_b>=14'd6656) && (rd_adr_b<14'd6912));
    assign                    wr_ram_row_sel_a[27]        = ((wr_adr_a>=14'd6912) && (wr_adr_a<14'd7168));
    assign                    wr_ram_row_sel_b[27]        = ((wr_adr_b>=14'd6912) && (wr_adr_b<14'd7168));
    assign                    rd_ram_row_sel_a[27]        = ((rd_adr_a>=14'd6912) && (rd_adr_a<14'd7168));
    assign                    rd_ram_row_sel_b[27]        = ((rd_adr_b>=14'd6912) && (rd_adr_b<14'd7168));
    assign                    wr_ram_row_sel_a[28]        = ((wr_adr_a>=14'd7168) && (wr_adr_a<14'd7424));
    assign                    wr_ram_row_sel_b[28]        = ((wr_adr_b>=14'd7168) && (wr_adr_b<14'd7424));
    assign                    rd_ram_row_sel_a[28]        = ((rd_adr_a>=14'd7168) && (rd_adr_a<14'd7424));
    assign                    rd_ram_row_sel_b[28]        = ((rd_adr_b>=14'd7168) && (rd_adr_b<14'd7424));
    assign                    wr_ram_row_sel_a[29]        = ((wr_adr_a>=14'd7424) && (wr_adr_a<14'd7680));
    assign                    wr_ram_row_sel_b[29]        = ((wr_adr_b>=14'd7424) && (wr_adr_b<14'd7680));
    assign                    rd_ram_row_sel_a[29]        = ((rd_adr_a>=14'd7424) && (rd_adr_a<14'd7680));
    assign                    rd_ram_row_sel_b[29]        = ((rd_adr_b>=14'd7424) && (rd_adr_b<14'd7680));
    assign                    wr_ram_row_sel_a[30]        = ((wr_adr_a>=14'd7680) && (wr_adr_a<14'd7936));
    assign                    wr_ram_row_sel_b[30]        = ((wr_adr_b>=14'd7680) && (wr_adr_b<14'd7936));
    assign                    rd_ram_row_sel_a[30]        = ((rd_adr_a>=14'd7680) && (rd_adr_a<14'd7936));
    assign                    rd_ram_row_sel_b[30]        = ((rd_adr_b>=14'd7680) && (rd_adr_b<14'd7936));
    assign                    wr_ram_row_sel_a[31]        = ((wr_adr_a>=14'd7936) && (wr_adr_a<14'd8192));
    assign                    wr_ram_row_sel_b[31]        = ((wr_adr_b>=14'd7936) && (wr_adr_b<14'd8192));
    assign                    rd_ram_row_sel_a[31]        = ((rd_adr_a>=14'd7936) && (rd_adr_a<14'd8192));
    assign                    rd_ram_row_sel_b[31]        = ((rd_adr_b>=14'd7936) && (rd_adr_b<14'd8192));
    assign                    wr_ram_row_sel_a[32]        = ((wr_adr_a>=14'd8192) && (wr_adr_a<14'd8448));
    assign                    wr_ram_row_sel_b[32]        = ((wr_adr_b>=14'd8192) && (wr_adr_b<14'd8448));
    assign                    rd_ram_row_sel_a[32]        = ((rd_adr_a>=14'd8192) && (rd_adr_a<14'd8448));
    assign                    rd_ram_row_sel_b[32]        = ((rd_adr_b>=14'd8192) && (rd_adr_b<14'd8448));
    assign                    wr_ram_row_sel_a[33]        = ((wr_adr_a>=14'd8448) && (wr_adr_a<14'd8704));
    assign                    wr_ram_row_sel_b[33]        = ((wr_adr_b>=14'd8448) && (wr_adr_b<14'd8704));
    assign                    rd_ram_row_sel_a[33]        = ((rd_adr_a>=14'd8448) && (rd_adr_a<14'd8704));
    assign                    rd_ram_row_sel_b[33]        = ((rd_adr_b>=14'd8448) && (rd_adr_b<14'd8704));
    assign                    wr_ram_row_sel_a[34]        = ((wr_adr_a>=14'd8704) && (wr_adr_a<14'd8960));
    assign                    wr_ram_row_sel_b[34]        = ((wr_adr_b>=14'd8704) && (wr_adr_b<14'd8960));
    assign                    rd_ram_row_sel_a[34]        = ((rd_adr_a>=14'd8704) && (rd_adr_a<14'd8960));
    assign                    rd_ram_row_sel_b[34]        = ((rd_adr_b>=14'd8704) && (rd_adr_b<14'd8960));
    assign                    wr_ram_row_sel_a[35]        = ((wr_adr_a>=14'd8960) && (wr_adr_a<14'd9216));
    assign                    wr_ram_row_sel_b[35]        = ((wr_adr_b>=14'd8960) && (wr_adr_b<14'd9216));
    assign                    rd_ram_row_sel_a[35]        = ((rd_adr_a>=14'd8960) && (rd_adr_a<14'd9216));
    assign                    rd_ram_row_sel_b[35]        = ((rd_adr_b>=14'd8960) && (rd_adr_b<14'd9216));
    assign                    wr_ram_row_sel_a[36]        = ((wr_adr_a>=14'd9216) && (wr_adr_a<14'd9472));
    assign                    wr_ram_row_sel_b[36]        = ((wr_adr_b>=14'd9216) && (wr_adr_b<14'd9472));
    assign                    rd_ram_row_sel_a[36]        = ((rd_adr_a>=14'd9216) && (rd_adr_a<14'd9472));
    assign                    rd_ram_row_sel_b[36]        = ((rd_adr_b>=14'd9216) && (rd_adr_b<14'd9472));
    assign                    wr_ram_row_sel_a[37]        = ((wr_adr_a>=14'd9472) && (wr_adr_a<14'd9728));
    assign                    wr_ram_row_sel_b[37]        = ((wr_adr_b>=14'd9472) && (wr_adr_b<14'd9728));
    assign                    rd_ram_row_sel_a[37]        = ((rd_adr_a>=14'd9472) && (rd_adr_a<14'd9728));
    assign                    rd_ram_row_sel_b[37]        = ((rd_adr_b>=14'd9472) && (rd_adr_b<14'd9728));
    assign                    wr_ram_row_sel_a[38]        = ((wr_adr_a>=14'd9728) && (wr_adr_a<14'd9984));
    assign                    wr_ram_row_sel_b[38]        = ((wr_adr_b>=14'd9728) && (wr_adr_b<14'd9984));
    assign                    rd_ram_row_sel_a[38]        = ((rd_adr_a>=14'd9728) && (rd_adr_a<14'd9984));
    assign                    rd_ram_row_sel_b[38]        = ((rd_adr_b>=14'd9728) && (rd_adr_b<14'd9984));
    assign                    wr_ram_row_sel_a[39]        = ((wr_adr_a>=14'd9984) && (wr_adr_a<14'd10240));
    assign                    wr_ram_row_sel_b[39]        = ((wr_adr_b>=14'd9984) && (wr_adr_b<14'd10240));
    assign                    rd_ram_row_sel_a[39]        = ((rd_adr_a>=14'd9984) && (rd_adr_a<14'd10240));
    assign                    rd_ram_row_sel_b[39]        = ((rd_adr_b>=14'd9984) && (rd_adr_b<14'd10240));
    assign                    wr_ram_row_sel_a[40]        = ((wr_adr_a>=14'd10240) && (wr_adr_a<14'd10496));
    assign                    wr_ram_row_sel_b[40]        = ((wr_adr_b>=14'd10240) && (wr_adr_b<14'd10496));
    assign                    rd_ram_row_sel_a[40]        = ((rd_adr_a>=14'd10240) && (rd_adr_a<14'd10496));
    assign                    rd_ram_row_sel_b[40]        = ((rd_adr_b>=14'd10240) && (rd_adr_b<14'd10496));
    assign                    wr_ram_row_sel_a[41]        = ((wr_adr_a>=14'd10496) && (wr_adr_a<14'd10752));
    assign                    wr_ram_row_sel_b[41]        = ((wr_adr_b>=14'd10496) && (wr_adr_b<14'd10752));
    assign                    rd_ram_row_sel_a[41]        = ((rd_adr_a>=14'd10496) && (rd_adr_a<14'd10752));
    assign                    rd_ram_row_sel_b[41]        = ((rd_adr_b>=14'd10496) && (rd_adr_b<14'd10752));
    assign                    wr_ram_row_sel_a[42]        = ((wr_adr_a>=14'd10752) && (wr_adr_a<14'd11008));
    assign                    wr_ram_row_sel_b[42]        = ((wr_adr_b>=14'd10752) && (wr_adr_b<14'd11008));
    assign                    rd_ram_row_sel_a[42]        = ((rd_adr_a>=14'd10752) && (rd_adr_a<14'd11008));
    assign                    rd_ram_row_sel_b[42]        = ((rd_adr_b>=14'd10752) && (rd_adr_b<14'd11008));
    assign                    wr_ram_row_sel_a[43]        = ((wr_adr_a>=14'd11008) && (wr_adr_a<14'd11264));
    assign                    wr_ram_row_sel_b[43]        = ((wr_adr_b>=14'd11008) && (wr_adr_b<14'd11264));
    assign                    rd_ram_row_sel_a[43]        = ((rd_adr_a>=14'd11008) && (rd_adr_a<14'd11264));
    assign                    rd_ram_row_sel_b[43]        = ((rd_adr_b>=14'd11008) && (rd_adr_b<14'd11264));
    assign                    wr_ram_row_sel_a[44]        = ((wr_adr_a>=14'd11264) && (wr_adr_a<14'd11520));
    assign                    wr_ram_row_sel_b[44]        = ((wr_adr_b>=14'd11264) && (wr_adr_b<14'd11520));
    assign                    rd_ram_row_sel_a[44]        = ((rd_adr_a>=14'd11264) && (rd_adr_a<14'd11520));
    assign                    rd_ram_row_sel_b[44]        = ((rd_adr_b>=14'd11264) && (rd_adr_b<14'd11520));
    assign                    wr_ram_row_sel_a[45]        = ((wr_adr_a>=14'd11520) && (wr_adr_a<14'd11776));
    assign                    wr_ram_row_sel_b[45]        = ((wr_adr_b>=14'd11520) && (wr_adr_b<14'd11776));
    assign                    rd_ram_row_sel_a[45]        = ((rd_adr_a>=14'd11520) && (rd_adr_a<14'd11776));
    assign                    rd_ram_row_sel_b[45]        = ((rd_adr_b>=14'd11520) && (rd_adr_b<14'd11776));
    assign                    wr_ram_row_sel_a[46]        = ((wr_adr_a>=14'd11776) && (wr_adr_a<14'd12032));
    assign                    wr_ram_row_sel_b[46]        = ((wr_adr_b>=14'd11776) && (wr_adr_b<14'd12032));
    assign                    rd_ram_row_sel_a[46]        = ((rd_adr_a>=14'd11776) && (rd_adr_a<14'd12032));
    assign                    rd_ram_row_sel_b[46]        = ((rd_adr_b>=14'd11776) && (rd_adr_b<14'd12032));
    assign                    wr_ram_row_sel_a[47]        = ((wr_adr_a>=14'd12032) && (wr_adr_a<14'd12288));
    assign                    wr_ram_row_sel_b[47]        = ((wr_adr_b>=14'd12032) && (wr_adr_b<14'd12288));
    assign                    rd_ram_row_sel_a[47]        = ((rd_adr_a>=14'd12032) && (rd_adr_a<14'd12288));
    assign                    rd_ram_row_sel_b[47]        = ((rd_adr_b>=14'd12032) && (rd_adr_b<14'd12288));
    assign                    wr_ram_row_sel_a[48]        = ((wr_adr_a>=14'd12288) && (wr_adr_a<14'd12544));
    assign                    wr_ram_row_sel_b[48]        = ((wr_adr_b>=14'd12288) && (wr_adr_b<14'd12544));
    assign                    rd_ram_row_sel_a[48]        = ((rd_adr_a>=14'd12288) && (rd_adr_a<14'd12544));
    assign                    rd_ram_row_sel_b[48]        = ((rd_adr_b>=14'd12288) && (rd_adr_b<14'd12544));
    assign                    wr_ram_row_sel_a[49]        = ((wr_adr_a>=14'd12544) && (wr_adr_a<14'd12800));
    assign                    wr_ram_row_sel_b[49]        = ((wr_adr_b>=14'd12544) && (wr_adr_b<14'd12800));
    assign                    rd_ram_row_sel_a[49]        = ((rd_adr_a>=14'd12544) && (rd_adr_a<14'd12800));
    assign                    rd_ram_row_sel_b[49]        = ((rd_adr_b>=14'd12544) && (rd_adr_b<14'd12800));
    assign                    wr_ram_row_sel_a[50]        = ((wr_adr_a>=14'd12800) && (wr_adr_a<14'd13056));
    assign                    wr_ram_row_sel_b[50]        = ((wr_adr_b>=14'd12800) && (wr_adr_b<14'd13056));
    assign                    rd_ram_row_sel_a[50]        = ((rd_adr_a>=14'd12800) && (rd_adr_a<14'd13056));
    assign                    rd_ram_row_sel_b[50]        = ((rd_adr_b>=14'd12800) && (rd_adr_b<14'd13056));
    assign                    wr_ram_row_sel_a[51]        = ((wr_adr_a>=14'd13056) && (wr_adr_a<14'd13312));
    assign                    wr_ram_row_sel_b[51]        = ((wr_adr_b>=14'd13056) && (wr_adr_b<14'd13312));
    assign                    rd_ram_row_sel_a[51]        = ((rd_adr_a>=14'd13056) && (rd_adr_a<14'd13312));
    assign                    rd_ram_row_sel_b[51]        = ((rd_adr_b>=14'd13056) && (rd_adr_b<14'd13312));
    assign                    wr_ram_row_sel_a[52]        = ((wr_adr_a>=14'd13312) && (wr_adr_a<14'd13568));
    assign                    wr_ram_row_sel_b[52]        = ((wr_adr_b>=14'd13312) && (wr_adr_b<14'd13568));
    assign                    rd_ram_row_sel_a[52]        = ((rd_adr_a>=14'd13312) && (rd_adr_a<14'd13568));
    assign                    rd_ram_row_sel_b[52]        = ((rd_adr_b>=14'd13312) && (rd_adr_b<14'd13568));
    assign                    wr_ram_row_sel_a[53]        = ((wr_adr_a>=14'd13568) && (wr_adr_a<14'd13824));
    assign                    wr_ram_row_sel_b[53]        = ((wr_adr_b>=14'd13568) && (wr_adr_b<14'd13824));
    assign                    rd_ram_row_sel_a[53]        = ((rd_adr_a>=14'd13568) && (rd_adr_a<14'd13824));
    assign                    rd_ram_row_sel_b[53]        = ((rd_adr_b>=14'd13568) && (rd_adr_b<14'd13824));
    assign                    wr_ram_row_sel_a[54]        = ((wr_adr_a>=14'd13824) && (wr_adr_a<14'd14080));
    assign                    wr_ram_row_sel_b[54]        = ((wr_adr_b>=14'd13824) && (wr_adr_b<14'd14080));
    assign                    rd_ram_row_sel_a[54]        = ((rd_adr_a>=14'd13824) && (rd_adr_a<14'd14080));
    assign                    rd_ram_row_sel_b[54]        = ((rd_adr_b>=14'd13824) && (rd_adr_b<14'd14080));
    assign                    wr_ram_row_sel_a[55]        = ((wr_adr_a>=14'd14080) && (wr_adr_a<14'd14336));
    assign                    wr_ram_row_sel_b[55]        = ((wr_adr_b>=14'd14080) && (wr_adr_b<14'd14336));
    assign                    rd_ram_row_sel_a[55]        = ((rd_adr_a>=14'd14080) && (rd_adr_a<14'd14336));
    assign                    rd_ram_row_sel_b[55]        = ((rd_adr_b>=14'd14080) && (rd_adr_b<14'd14336));
    assign                    wr_ram_row_sel_a[56]        = ((wr_adr_a>=14'd14336) && (wr_adr_a<14'd14592));
    assign                    wr_ram_row_sel_b[56]        = ((wr_adr_b>=14'd14336) && (wr_adr_b<14'd14592));
    assign                    rd_ram_row_sel_a[56]        = ((rd_adr_a>=14'd14336) && (rd_adr_a<14'd14592));
    assign                    rd_ram_row_sel_b[56]        = ((rd_adr_b>=14'd14336) && (rd_adr_b<14'd14592));
    assign                    wr_ram_row_sel_a[57]        = ((wr_adr_a>=14'd14592) && (wr_adr_a<14'd14848));
    assign                    wr_ram_row_sel_b[57]        = ((wr_adr_b>=14'd14592) && (wr_adr_b<14'd14848));
    assign                    rd_ram_row_sel_a[57]        = ((rd_adr_a>=14'd14592) && (rd_adr_a<14'd14848));
    assign                    rd_ram_row_sel_b[57]        = ((rd_adr_b>=14'd14592) && (rd_adr_b<14'd14848));
    assign                    wr_ram_row_sel_a[58]        = ((wr_adr_a>=14'd14848) && (wr_adr_a<14'd15104));
    assign                    wr_ram_row_sel_b[58]        = ((wr_adr_b>=14'd14848) && (wr_adr_b<14'd15104));
    assign                    rd_ram_row_sel_a[58]        = ((rd_adr_a>=14'd14848) && (rd_adr_a<14'd15104));
    assign                    rd_ram_row_sel_b[58]        = ((rd_adr_b>=14'd14848) && (rd_adr_b<14'd15104));
    assign                    wr_ram_row_sel_a[59]        = ((wr_adr_a>=14'd15104) && (wr_adr_a<14'd15360));
    assign                    wr_ram_row_sel_b[59]        = ((wr_adr_b>=14'd15104) && (wr_adr_b<14'd15360));
    assign                    rd_ram_row_sel_a[59]        = ((rd_adr_a>=14'd15104) && (rd_adr_a<14'd15360));
    assign                    rd_ram_row_sel_b[59]        = ((rd_adr_b>=14'd15104) && (rd_adr_b<14'd15360));
    assign                    wr_ram_row_sel_a[60]        = ((wr_adr_a>=14'd15360) && (wr_adr_a<14'd15616));
    assign                    wr_ram_row_sel_b[60]        = ((wr_adr_b>=14'd15360) && (wr_adr_b<14'd15616));
    assign                    rd_ram_row_sel_a[60]        = ((rd_adr_a>=14'd15360) && (rd_adr_a<14'd15616));
    assign                    rd_ram_row_sel_b[60]        = ((rd_adr_b>=14'd15360) && (rd_adr_b<14'd15616));
    assign                    wr_ram_row_sel_a[61]        = ((wr_adr_a>=14'd15616) && (wr_adr_a<14'd15872));
    assign                    wr_ram_row_sel_b[61]        = ((wr_adr_b>=14'd15616) && (wr_adr_b<14'd15872));
    assign                    rd_ram_row_sel_a[61]        = ((rd_adr_a>=14'd15616) && (rd_adr_a<14'd15872));
    assign                    rd_ram_row_sel_b[61]        = ((rd_adr_b>=14'd15616) && (rd_adr_b<14'd15872));
    assign                    wr_ram_row_sel_a[62]        = ((wr_adr_a>=14'd15872) && (wr_adr_a<14'd16128));
    assign                    wr_ram_row_sel_b[62]        = ((wr_adr_b>=14'd15872) && (wr_adr_b<14'd16128));
    assign                    rd_ram_row_sel_a[62]        = ((rd_adr_a>=14'd15872) && (rd_adr_a<14'd16128));
    assign                    rd_ram_row_sel_b[62]        = ((rd_adr_b>=14'd15872) && (rd_adr_b<14'd16128));
    assign                    wr_ram_row_sel_a[63]        = (wr_adr_a>=14'd16128);
    assign                    wr_ram_row_sel_b[63]        = (wr_adr_b>=14'd16128);
    assign                    rd_ram_row_sel_a[63]        = (rd_adr_a>=14'd16128);
    assign                    rd_ram_row_sel_b[63]        = (rd_adr_b>=14'd16128);


    // RAM Address Decoder

    wire    [14-1:0]        ram_row_wr_adr_a[64-1:0];
    wire    [14-1:0]        ram_row_wr_adr_b[64-1:0];
    wire    [14-1:0]        ram_row_rd_adr_a[64-1:0];
    wire    [14-1:0]        ram_row_rd_adr_b[64-1:0];
    assign                    ram_row_wr_adr_a[0][14-1:0]    = wr_ram_row_sel_a[0] ? wr_adr_a - 14'd0 : 14'd0;
    assign                    ram_row_wr_adr_b[0][14-1:0]    = wr_ram_row_sel_b[0] ? wr_adr_b - 14'd0 : 14'd0;
    assign                    ram_row_rd_adr_a[0][14-1:0]    = rd_ram_row_sel_a[0] ? rd_adr_a - 14'd0 : 14'd0;
    assign                    ram_row_rd_adr_b[0][14-1:0]    = rd_ram_row_sel_b[0] ? rd_adr_b - 14'd0 : 14'd0;
    assign                    ram_row_wr_adr_a[1][14-1:0]    = wr_ram_row_sel_a[1] ? wr_adr_a - 14'd256 : 14'd0;
    assign                    ram_row_wr_adr_b[1][14-1:0]    = wr_ram_row_sel_b[1] ? wr_adr_b - 14'd256 : 14'd0;
    assign                    ram_row_rd_adr_a[1][14-1:0]    = rd_ram_row_sel_a[1] ? rd_adr_a - 14'd256 : 14'd0;
    assign                    ram_row_rd_adr_b[1][14-1:0]    = rd_ram_row_sel_b[1] ? rd_adr_b - 14'd256 : 14'd0;
    assign                    ram_row_wr_adr_a[2][14-1:0]    = wr_ram_row_sel_a[2] ? wr_adr_a - 14'd512 : 14'd0;
    assign                    ram_row_wr_adr_b[2][14-1:0]    = wr_ram_row_sel_b[2] ? wr_adr_b - 14'd512 : 14'd0;
    assign                    ram_row_rd_adr_a[2][14-1:0]    = rd_ram_row_sel_a[2] ? rd_adr_a - 14'd512 : 14'd0;
    assign                    ram_row_rd_adr_b[2][14-1:0]    = rd_ram_row_sel_b[2] ? rd_adr_b - 14'd512 : 14'd0;
    assign                    ram_row_wr_adr_a[3][14-1:0]    = wr_ram_row_sel_a[3] ? wr_adr_a - 14'd768 : 14'd0;
    assign                    ram_row_wr_adr_b[3][14-1:0]    = wr_ram_row_sel_b[3] ? wr_adr_b - 14'd768 : 14'd0;
    assign                    ram_row_rd_adr_a[3][14-1:0]    = rd_ram_row_sel_a[3] ? rd_adr_a - 14'd768 : 14'd0;
    assign                    ram_row_rd_adr_b[3][14-1:0]    = rd_ram_row_sel_b[3] ? rd_adr_b - 14'd768 : 14'd0;
    assign                    ram_row_wr_adr_a[4][14-1:0]    = wr_ram_row_sel_a[4] ? wr_adr_a - 14'd1024 : 14'd0;
    assign                    ram_row_wr_adr_b[4][14-1:0]    = wr_ram_row_sel_b[4] ? wr_adr_b - 14'd1024 : 14'd0;
    assign                    ram_row_rd_adr_a[4][14-1:0]    = rd_ram_row_sel_a[4] ? rd_adr_a - 14'd1024 : 14'd0;
    assign                    ram_row_rd_adr_b[4][14-1:0]    = rd_ram_row_sel_b[4] ? rd_adr_b - 14'd1024 : 14'd0;
    assign                    ram_row_wr_adr_a[5][14-1:0]    = wr_ram_row_sel_a[5] ? wr_adr_a - 14'd1280 : 14'd0;
    assign                    ram_row_wr_adr_b[5][14-1:0]    = wr_ram_row_sel_b[5] ? wr_adr_b - 14'd1280 : 14'd0;
    assign                    ram_row_rd_adr_a[5][14-1:0]    = rd_ram_row_sel_a[5] ? rd_adr_a - 14'd1280 : 14'd0;
    assign                    ram_row_rd_adr_b[5][14-1:0]    = rd_ram_row_sel_b[5] ? rd_adr_b - 14'd1280 : 14'd0;
    assign                    ram_row_wr_adr_a[6][14-1:0]    = wr_ram_row_sel_a[6] ? wr_adr_a - 14'd1536 : 14'd0;
    assign                    ram_row_wr_adr_b[6][14-1:0]    = wr_ram_row_sel_b[6] ? wr_adr_b - 14'd1536 : 14'd0;
    assign                    ram_row_rd_adr_a[6][14-1:0]    = rd_ram_row_sel_a[6] ? rd_adr_a - 14'd1536 : 14'd0;
    assign                    ram_row_rd_adr_b[6][14-1:0]    = rd_ram_row_sel_b[6] ? rd_adr_b - 14'd1536 : 14'd0;
    assign                    ram_row_wr_adr_a[7][14-1:0]    = wr_ram_row_sel_a[7] ? wr_adr_a - 14'd1792 : 14'd0;
    assign                    ram_row_wr_adr_b[7][14-1:0]    = wr_ram_row_sel_b[7] ? wr_adr_b - 14'd1792 : 14'd0;
    assign                    ram_row_rd_adr_a[7][14-1:0]    = rd_ram_row_sel_a[7] ? rd_adr_a - 14'd1792 : 14'd0;
    assign                    ram_row_rd_adr_b[7][14-1:0]    = rd_ram_row_sel_b[7] ? rd_adr_b - 14'd1792 : 14'd0;
    assign                    ram_row_wr_adr_a[8][14-1:0]    = wr_ram_row_sel_a[8] ? wr_adr_a - 14'd2048 : 14'd0;
    assign                    ram_row_wr_adr_b[8][14-1:0]    = wr_ram_row_sel_b[8] ? wr_adr_b - 14'd2048 : 14'd0;
    assign                    ram_row_rd_adr_a[8][14-1:0]    = rd_ram_row_sel_a[8] ? rd_adr_a - 14'd2048 : 14'd0;
    assign                    ram_row_rd_adr_b[8][14-1:0]    = rd_ram_row_sel_b[8] ? rd_adr_b - 14'd2048 : 14'd0;
    assign                    ram_row_wr_adr_a[9][14-1:0]    = wr_ram_row_sel_a[9] ? wr_adr_a - 14'd2304 : 14'd0;
    assign                    ram_row_wr_adr_b[9][14-1:0]    = wr_ram_row_sel_b[9] ? wr_adr_b - 14'd2304 : 14'd0;
    assign                    ram_row_rd_adr_a[9][14-1:0]    = rd_ram_row_sel_a[9] ? rd_adr_a - 14'd2304 : 14'd0;
    assign                    ram_row_rd_adr_b[9][14-1:0]    = rd_ram_row_sel_b[9] ? rd_adr_b - 14'd2304 : 14'd0;
    assign                    ram_row_wr_adr_a[10][14-1:0]    = wr_ram_row_sel_a[10] ? wr_adr_a - 14'd2560 : 14'd0;
    assign                    ram_row_wr_adr_b[10][14-1:0]    = wr_ram_row_sel_b[10] ? wr_adr_b - 14'd2560 : 14'd0;
    assign                    ram_row_rd_adr_a[10][14-1:0]    = rd_ram_row_sel_a[10] ? rd_adr_a - 14'd2560 : 14'd0;
    assign                    ram_row_rd_adr_b[10][14-1:0]    = rd_ram_row_sel_b[10] ? rd_adr_b - 14'd2560 : 14'd0;
    assign                    ram_row_wr_adr_a[11][14-1:0]    = wr_ram_row_sel_a[11] ? wr_adr_a - 14'd2816 : 14'd0;
    assign                    ram_row_wr_adr_b[11][14-1:0]    = wr_ram_row_sel_b[11] ? wr_adr_b - 14'd2816 : 14'd0;
    assign                    ram_row_rd_adr_a[11][14-1:0]    = rd_ram_row_sel_a[11] ? rd_adr_a - 14'd2816 : 14'd0;
    assign                    ram_row_rd_adr_b[11][14-1:0]    = rd_ram_row_sel_b[11] ? rd_adr_b - 14'd2816 : 14'd0;
    assign                    ram_row_wr_adr_a[12][14-1:0]    = wr_ram_row_sel_a[12] ? wr_adr_a - 14'd3072 : 14'd0;
    assign                    ram_row_wr_adr_b[12][14-1:0]    = wr_ram_row_sel_b[12] ? wr_adr_b - 14'd3072 : 14'd0;
    assign                    ram_row_rd_adr_a[12][14-1:0]    = rd_ram_row_sel_a[12] ? rd_adr_a - 14'd3072 : 14'd0;
    assign                    ram_row_rd_adr_b[12][14-1:0]    = rd_ram_row_sel_b[12] ? rd_adr_b - 14'd3072 : 14'd0;
    assign                    ram_row_wr_adr_a[13][14-1:0]    = wr_ram_row_sel_a[13] ? wr_adr_a - 14'd3328 : 14'd0;
    assign                    ram_row_wr_adr_b[13][14-1:0]    = wr_ram_row_sel_b[13] ? wr_adr_b - 14'd3328 : 14'd0;
    assign                    ram_row_rd_adr_a[13][14-1:0]    = rd_ram_row_sel_a[13] ? rd_adr_a - 14'd3328 : 14'd0;
    assign                    ram_row_rd_adr_b[13][14-1:0]    = rd_ram_row_sel_b[13] ? rd_adr_b - 14'd3328 : 14'd0;
    assign                    ram_row_wr_adr_a[14][14-1:0]    = wr_ram_row_sel_a[14] ? wr_adr_a - 14'd3584 : 14'd0;
    assign                    ram_row_wr_adr_b[14][14-1:0]    = wr_ram_row_sel_b[14] ? wr_adr_b - 14'd3584 : 14'd0;
    assign                    ram_row_rd_adr_a[14][14-1:0]    = rd_ram_row_sel_a[14] ? rd_adr_a - 14'd3584 : 14'd0;
    assign                    ram_row_rd_adr_b[14][14-1:0]    = rd_ram_row_sel_b[14] ? rd_adr_b - 14'd3584 : 14'd0;
    assign                    ram_row_wr_adr_a[15][14-1:0]    = wr_ram_row_sel_a[15] ? wr_adr_a - 14'd3840 : 14'd0;
    assign                    ram_row_wr_adr_b[15][14-1:0]    = wr_ram_row_sel_b[15] ? wr_adr_b - 14'd3840 : 14'd0;
    assign                    ram_row_rd_adr_a[15][14-1:0]    = rd_ram_row_sel_a[15] ? rd_adr_a - 14'd3840 : 14'd0;
    assign                    ram_row_rd_adr_b[15][14-1:0]    = rd_ram_row_sel_b[15] ? rd_adr_b - 14'd3840 : 14'd0;
    assign                    ram_row_wr_adr_a[16][14-1:0]    = wr_ram_row_sel_a[16] ? wr_adr_a - 14'd4096 : 14'd0;
    assign                    ram_row_wr_adr_b[16][14-1:0]    = wr_ram_row_sel_b[16] ? wr_adr_b - 14'd4096 : 14'd0;
    assign                    ram_row_rd_adr_a[16][14-1:0]    = rd_ram_row_sel_a[16] ? rd_adr_a - 14'd4096 : 14'd0;
    assign                    ram_row_rd_adr_b[16][14-1:0]    = rd_ram_row_sel_b[16] ? rd_adr_b - 14'd4096 : 14'd0;
    assign                    ram_row_wr_adr_a[17][14-1:0]    = wr_ram_row_sel_a[17] ? wr_adr_a - 14'd4352 : 14'd0;
    assign                    ram_row_wr_adr_b[17][14-1:0]    = wr_ram_row_sel_b[17] ? wr_adr_b - 14'd4352 : 14'd0;
    assign                    ram_row_rd_adr_a[17][14-1:0]    = rd_ram_row_sel_a[17] ? rd_adr_a - 14'd4352 : 14'd0;
    assign                    ram_row_rd_adr_b[17][14-1:0]    = rd_ram_row_sel_b[17] ? rd_adr_b - 14'd4352 : 14'd0;
    assign                    ram_row_wr_adr_a[18][14-1:0]    = wr_ram_row_sel_a[18] ? wr_adr_a - 14'd4608 : 14'd0;
    assign                    ram_row_wr_adr_b[18][14-1:0]    = wr_ram_row_sel_b[18] ? wr_adr_b - 14'd4608 : 14'd0;
    assign                    ram_row_rd_adr_a[18][14-1:0]    = rd_ram_row_sel_a[18] ? rd_adr_a - 14'd4608 : 14'd0;
    assign                    ram_row_rd_adr_b[18][14-1:0]    = rd_ram_row_sel_b[18] ? rd_adr_b - 14'd4608 : 14'd0;
    assign                    ram_row_wr_adr_a[19][14-1:0]    = wr_ram_row_sel_a[19] ? wr_adr_a - 14'd4864 : 14'd0;
    assign                    ram_row_wr_adr_b[19][14-1:0]    = wr_ram_row_sel_b[19] ? wr_adr_b - 14'd4864 : 14'd0;
    assign                    ram_row_rd_adr_a[19][14-1:0]    = rd_ram_row_sel_a[19] ? rd_adr_a - 14'd4864 : 14'd0;
    assign                    ram_row_rd_adr_b[19][14-1:0]    = rd_ram_row_sel_b[19] ? rd_adr_b - 14'd4864 : 14'd0;
    assign                    ram_row_wr_adr_a[20][14-1:0]    = wr_ram_row_sel_a[20] ? wr_adr_a - 14'd5120 : 14'd0;
    assign                    ram_row_wr_adr_b[20][14-1:0]    = wr_ram_row_sel_b[20] ? wr_adr_b - 14'd5120 : 14'd0;
    assign                    ram_row_rd_adr_a[20][14-1:0]    = rd_ram_row_sel_a[20] ? rd_adr_a - 14'd5120 : 14'd0;
    assign                    ram_row_rd_adr_b[20][14-1:0]    = rd_ram_row_sel_b[20] ? rd_adr_b - 14'd5120 : 14'd0;
    assign                    ram_row_wr_adr_a[21][14-1:0]    = wr_ram_row_sel_a[21] ? wr_adr_a - 14'd5376 : 14'd0;
    assign                    ram_row_wr_adr_b[21][14-1:0]    = wr_ram_row_sel_b[21] ? wr_adr_b - 14'd5376 : 14'd0;
    assign                    ram_row_rd_adr_a[21][14-1:0]    = rd_ram_row_sel_a[21] ? rd_adr_a - 14'd5376 : 14'd0;
    assign                    ram_row_rd_adr_b[21][14-1:0]    = rd_ram_row_sel_b[21] ? rd_adr_b - 14'd5376 : 14'd0;
    assign                    ram_row_wr_adr_a[22][14-1:0]    = wr_ram_row_sel_a[22] ? wr_adr_a - 14'd5632 : 14'd0;
    assign                    ram_row_wr_adr_b[22][14-1:0]    = wr_ram_row_sel_b[22] ? wr_adr_b - 14'd5632 : 14'd0;
    assign                    ram_row_rd_adr_a[22][14-1:0]    = rd_ram_row_sel_a[22] ? rd_adr_a - 14'd5632 : 14'd0;
    assign                    ram_row_rd_adr_b[22][14-1:0]    = rd_ram_row_sel_b[22] ? rd_adr_b - 14'd5632 : 14'd0;
    assign                    ram_row_wr_adr_a[23][14-1:0]    = wr_ram_row_sel_a[23] ? wr_adr_a - 14'd5888 : 14'd0;
    assign                    ram_row_wr_adr_b[23][14-1:0]    = wr_ram_row_sel_b[23] ? wr_adr_b - 14'd5888 : 14'd0;
    assign                    ram_row_rd_adr_a[23][14-1:0]    = rd_ram_row_sel_a[23] ? rd_adr_a - 14'd5888 : 14'd0;
    assign                    ram_row_rd_adr_b[23][14-1:0]    = rd_ram_row_sel_b[23] ? rd_adr_b - 14'd5888 : 14'd0;
    assign                    ram_row_wr_adr_a[24][14-1:0]    = wr_ram_row_sel_a[24] ? wr_adr_a - 14'd6144 : 14'd0;
    assign                    ram_row_wr_adr_b[24][14-1:0]    = wr_ram_row_sel_b[24] ? wr_adr_b - 14'd6144 : 14'd0;
    assign                    ram_row_rd_adr_a[24][14-1:0]    = rd_ram_row_sel_a[24] ? rd_adr_a - 14'd6144 : 14'd0;
    assign                    ram_row_rd_adr_b[24][14-1:0]    = rd_ram_row_sel_b[24] ? rd_adr_b - 14'd6144 : 14'd0;
    assign                    ram_row_wr_adr_a[25][14-1:0]    = wr_ram_row_sel_a[25] ? wr_adr_a - 14'd6400 : 14'd0;
    assign                    ram_row_wr_adr_b[25][14-1:0]    = wr_ram_row_sel_b[25] ? wr_adr_b - 14'd6400 : 14'd0;
    assign                    ram_row_rd_adr_a[25][14-1:0]    = rd_ram_row_sel_a[25] ? rd_adr_a - 14'd6400 : 14'd0;
    assign                    ram_row_rd_adr_b[25][14-1:0]    = rd_ram_row_sel_b[25] ? rd_adr_b - 14'd6400 : 14'd0;
    assign                    ram_row_wr_adr_a[26][14-1:0]    = wr_ram_row_sel_a[26] ? wr_adr_a - 14'd6656 : 14'd0;
    assign                    ram_row_wr_adr_b[26][14-1:0]    = wr_ram_row_sel_b[26] ? wr_adr_b - 14'd6656 : 14'd0;
    assign                    ram_row_rd_adr_a[26][14-1:0]    = rd_ram_row_sel_a[26] ? rd_adr_a - 14'd6656 : 14'd0;
    assign                    ram_row_rd_adr_b[26][14-1:0]    = rd_ram_row_sel_b[26] ? rd_adr_b - 14'd6656 : 14'd0;
    assign                    ram_row_wr_adr_a[27][14-1:0]    = wr_ram_row_sel_a[27] ? wr_adr_a - 14'd6912 : 14'd0;
    assign                    ram_row_wr_adr_b[27][14-1:0]    = wr_ram_row_sel_b[27] ? wr_adr_b - 14'd6912 : 14'd0;
    assign                    ram_row_rd_adr_a[27][14-1:0]    = rd_ram_row_sel_a[27] ? rd_adr_a - 14'd6912 : 14'd0;
    assign                    ram_row_rd_adr_b[27][14-1:0]    = rd_ram_row_sel_b[27] ? rd_adr_b - 14'd6912 : 14'd0;
    assign                    ram_row_wr_adr_a[28][14-1:0]    = wr_ram_row_sel_a[28] ? wr_adr_a - 14'd7168 : 14'd0;
    assign                    ram_row_wr_adr_b[28][14-1:0]    = wr_ram_row_sel_b[28] ? wr_adr_b - 14'd7168 : 14'd0;
    assign                    ram_row_rd_adr_a[28][14-1:0]    = rd_ram_row_sel_a[28] ? rd_adr_a - 14'd7168 : 14'd0;
    assign                    ram_row_rd_adr_b[28][14-1:0]    = rd_ram_row_sel_b[28] ? rd_adr_b - 14'd7168 : 14'd0;
    assign                    ram_row_wr_adr_a[29][14-1:0]    = wr_ram_row_sel_a[29] ? wr_adr_a - 14'd7424 : 14'd0;
    assign                    ram_row_wr_adr_b[29][14-1:0]    = wr_ram_row_sel_b[29] ? wr_adr_b - 14'd7424 : 14'd0;
    assign                    ram_row_rd_adr_a[29][14-1:0]    = rd_ram_row_sel_a[29] ? rd_adr_a - 14'd7424 : 14'd0;
    assign                    ram_row_rd_adr_b[29][14-1:0]    = rd_ram_row_sel_b[29] ? rd_adr_b - 14'd7424 : 14'd0;
    assign                    ram_row_wr_adr_a[30][14-1:0]    = wr_ram_row_sel_a[30] ? wr_adr_a - 14'd7680 : 14'd0;
    assign                    ram_row_wr_adr_b[30][14-1:0]    = wr_ram_row_sel_b[30] ? wr_adr_b - 14'd7680 : 14'd0;
    assign                    ram_row_rd_adr_a[30][14-1:0]    = rd_ram_row_sel_a[30] ? rd_adr_a - 14'd7680 : 14'd0;
    assign                    ram_row_rd_adr_b[30][14-1:0]    = rd_ram_row_sel_b[30] ? rd_adr_b - 14'd7680 : 14'd0;
    assign                    ram_row_wr_adr_a[31][14-1:0]    = wr_ram_row_sel_a[31] ? wr_adr_a - 14'd7936 : 14'd0;
    assign                    ram_row_wr_adr_b[31][14-1:0]    = wr_ram_row_sel_b[31] ? wr_adr_b - 14'd7936 : 14'd0;
    assign                    ram_row_rd_adr_a[31][14-1:0]    = rd_ram_row_sel_a[31] ? rd_adr_a - 14'd7936 : 14'd0;
    assign                    ram_row_rd_adr_b[31][14-1:0]    = rd_ram_row_sel_b[31] ? rd_adr_b - 14'd7936 : 14'd0;
    assign                    ram_row_wr_adr_a[32][14-1:0]    = wr_ram_row_sel_a[32] ? wr_adr_a - 14'd8192 : 14'd0;
    assign                    ram_row_wr_adr_b[32][14-1:0]    = wr_ram_row_sel_b[32] ? wr_adr_b - 14'd8192 : 14'd0;
    assign                    ram_row_rd_adr_a[32][14-1:0]    = rd_ram_row_sel_a[32] ? rd_adr_a - 14'd8192 : 14'd0;
    assign                    ram_row_rd_adr_b[32][14-1:0]    = rd_ram_row_sel_b[32] ? rd_adr_b - 14'd8192 : 14'd0;
    assign                    ram_row_wr_adr_a[33][14-1:0]    = wr_ram_row_sel_a[33] ? wr_adr_a - 14'd8448 : 14'd0;
    assign                    ram_row_wr_adr_b[33][14-1:0]    = wr_ram_row_sel_b[33] ? wr_adr_b - 14'd8448 : 14'd0;
    assign                    ram_row_rd_adr_a[33][14-1:0]    = rd_ram_row_sel_a[33] ? rd_adr_a - 14'd8448 : 14'd0;
    assign                    ram_row_rd_adr_b[33][14-1:0]    = rd_ram_row_sel_b[33] ? rd_adr_b - 14'd8448 : 14'd0;
    assign                    ram_row_wr_adr_a[34][14-1:0]    = wr_ram_row_sel_a[34] ? wr_adr_a - 14'd8704 : 14'd0;
    assign                    ram_row_wr_adr_b[34][14-1:0]    = wr_ram_row_sel_b[34] ? wr_adr_b - 14'd8704 : 14'd0;
    assign                    ram_row_rd_adr_a[34][14-1:0]    = rd_ram_row_sel_a[34] ? rd_adr_a - 14'd8704 : 14'd0;
    assign                    ram_row_rd_adr_b[34][14-1:0]    = rd_ram_row_sel_b[34] ? rd_adr_b - 14'd8704 : 14'd0;
    assign                    ram_row_wr_adr_a[35][14-1:0]    = wr_ram_row_sel_a[35] ? wr_adr_a - 14'd8960 : 14'd0;
    assign                    ram_row_wr_adr_b[35][14-1:0]    = wr_ram_row_sel_b[35] ? wr_adr_b - 14'd8960 : 14'd0;
    assign                    ram_row_rd_adr_a[35][14-1:0]    = rd_ram_row_sel_a[35] ? rd_adr_a - 14'd8960 : 14'd0;
    assign                    ram_row_rd_adr_b[35][14-1:0]    = rd_ram_row_sel_b[35] ? rd_adr_b - 14'd8960 : 14'd0;
    assign                    ram_row_wr_adr_a[36][14-1:0]    = wr_ram_row_sel_a[36] ? wr_adr_a - 14'd9216 : 14'd0;
    assign                    ram_row_wr_adr_b[36][14-1:0]    = wr_ram_row_sel_b[36] ? wr_adr_b - 14'd9216 : 14'd0;
    assign                    ram_row_rd_adr_a[36][14-1:0]    = rd_ram_row_sel_a[36] ? rd_adr_a - 14'd9216 : 14'd0;
    assign                    ram_row_rd_adr_b[36][14-1:0]    = rd_ram_row_sel_b[36] ? rd_adr_b - 14'd9216 : 14'd0;
    assign                    ram_row_wr_adr_a[37][14-1:0]    = wr_ram_row_sel_a[37] ? wr_adr_a - 14'd9472 : 14'd0;
    assign                    ram_row_wr_adr_b[37][14-1:0]    = wr_ram_row_sel_b[37] ? wr_adr_b - 14'd9472 : 14'd0;
    assign                    ram_row_rd_adr_a[37][14-1:0]    = rd_ram_row_sel_a[37] ? rd_adr_a - 14'd9472 : 14'd0;
    assign                    ram_row_rd_adr_b[37][14-1:0]    = rd_ram_row_sel_b[37] ? rd_adr_b - 14'd9472 : 14'd0;
    assign                    ram_row_wr_adr_a[38][14-1:0]    = wr_ram_row_sel_a[38] ? wr_adr_a - 14'd9728 : 14'd0;
    assign                    ram_row_wr_adr_b[38][14-1:0]    = wr_ram_row_sel_b[38] ? wr_adr_b - 14'd9728 : 14'd0;
    assign                    ram_row_rd_adr_a[38][14-1:0]    = rd_ram_row_sel_a[38] ? rd_adr_a - 14'd9728 : 14'd0;
    assign                    ram_row_rd_adr_b[38][14-1:0]    = rd_ram_row_sel_b[38] ? rd_adr_b - 14'd9728 : 14'd0;
    assign                    ram_row_wr_adr_a[39][14-1:0]    = wr_ram_row_sel_a[39] ? wr_adr_a - 14'd9984 : 14'd0;
    assign                    ram_row_wr_adr_b[39][14-1:0]    = wr_ram_row_sel_b[39] ? wr_adr_b - 14'd9984 : 14'd0;
    assign                    ram_row_rd_adr_a[39][14-1:0]    = rd_ram_row_sel_a[39] ? rd_adr_a - 14'd9984 : 14'd0;
    assign                    ram_row_rd_adr_b[39][14-1:0]    = rd_ram_row_sel_b[39] ? rd_adr_b - 14'd9984 : 14'd0;
    assign                    ram_row_wr_adr_a[40][14-1:0]    = wr_ram_row_sel_a[40] ? wr_adr_a - 14'd10240 : 14'd0;
    assign                    ram_row_wr_adr_b[40][14-1:0]    = wr_ram_row_sel_b[40] ? wr_adr_b - 14'd10240 : 14'd0;
    assign                    ram_row_rd_adr_a[40][14-1:0]    = rd_ram_row_sel_a[40] ? rd_adr_a - 14'd10240 : 14'd0;
    assign                    ram_row_rd_adr_b[40][14-1:0]    = rd_ram_row_sel_b[40] ? rd_adr_b - 14'd10240 : 14'd0;
    assign                    ram_row_wr_adr_a[41][14-1:0]    = wr_ram_row_sel_a[41] ? wr_adr_a - 14'd10496 : 14'd0;
    assign                    ram_row_wr_adr_b[41][14-1:0]    = wr_ram_row_sel_b[41] ? wr_adr_b - 14'd10496 : 14'd0;
    assign                    ram_row_rd_adr_a[41][14-1:0]    = rd_ram_row_sel_a[41] ? rd_adr_a - 14'd10496 : 14'd0;
    assign                    ram_row_rd_adr_b[41][14-1:0]    = rd_ram_row_sel_b[41] ? rd_adr_b - 14'd10496 : 14'd0;
    assign                    ram_row_wr_adr_a[42][14-1:0]    = wr_ram_row_sel_a[42] ? wr_adr_a - 14'd10752 : 14'd0;
    assign                    ram_row_wr_adr_b[42][14-1:0]    = wr_ram_row_sel_b[42] ? wr_adr_b - 14'd10752 : 14'd0;
    assign                    ram_row_rd_adr_a[42][14-1:0]    = rd_ram_row_sel_a[42] ? rd_adr_a - 14'd10752 : 14'd0;
    assign                    ram_row_rd_adr_b[42][14-1:0]    = rd_ram_row_sel_b[42] ? rd_adr_b - 14'd10752 : 14'd0;
    assign                    ram_row_wr_adr_a[43][14-1:0]    = wr_ram_row_sel_a[43] ? wr_adr_a - 14'd11008 : 14'd0;
    assign                    ram_row_wr_adr_b[43][14-1:0]    = wr_ram_row_sel_b[43] ? wr_adr_b - 14'd11008 : 14'd0;
    assign                    ram_row_rd_adr_a[43][14-1:0]    = rd_ram_row_sel_a[43] ? rd_adr_a - 14'd11008 : 14'd0;
    assign                    ram_row_rd_adr_b[43][14-1:0]    = rd_ram_row_sel_b[43] ? rd_adr_b - 14'd11008 : 14'd0;
    assign                    ram_row_wr_adr_a[44][14-1:0]    = wr_ram_row_sel_a[44] ? wr_adr_a - 14'd11264 : 14'd0;
    assign                    ram_row_wr_adr_b[44][14-1:0]    = wr_ram_row_sel_b[44] ? wr_adr_b - 14'd11264 : 14'd0;
    assign                    ram_row_rd_adr_a[44][14-1:0]    = rd_ram_row_sel_a[44] ? rd_adr_a - 14'd11264 : 14'd0;
    assign                    ram_row_rd_adr_b[44][14-1:0]    = rd_ram_row_sel_b[44] ? rd_adr_b - 14'd11264 : 14'd0;
    assign                    ram_row_wr_adr_a[45][14-1:0]    = wr_ram_row_sel_a[45] ? wr_adr_a - 14'd11520 : 14'd0;
    assign                    ram_row_wr_adr_b[45][14-1:0]    = wr_ram_row_sel_b[45] ? wr_adr_b - 14'd11520 : 14'd0;
    assign                    ram_row_rd_adr_a[45][14-1:0]    = rd_ram_row_sel_a[45] ? rd_adr_a - 14'd11520 : 14'd0;
    assign                    ram_row_rd_adr_b[45][14-1:0]    = rd_ram_row_sel_b[45] ? rd_adr_b - 14'd11520 : 14'd0;
    assign                    ram_row_wr_adr_a[46][14-1:0]    = wr_ram_row_sel_a[46] ? wr_adr_a - 14'd11776 : 14'd0;
    assign                    ram_row_wr_adr_b[46][14-1:0]    = wr_ram_row_sel_b[46] ? wr_adr_b - 14'd11776 : 14'd0;
    assign                    ram_row_rd_adr_a[46][14-1:0]    = rd_ram_row_sel_a[46] ? rd_adr_a - 14'd11776 : 14'd0;
    assign                    ram_row_rd_adr_b[46][14-1:0]    = rd_ram_row_sel_b[46] ? rd_adr_b - 14'd11776 : 14'd0;
    assign                    ram_row_wr_adr_a[47][14-1:0]    = wr_ram_row_sel_a[47] ? wr_adr_a - 14'd12032 : 14'd0;
    assign                    ram_row_wr_adr_b[47][14-1:0]    = wr_ram_row_sel_b[47] ? wr_adr_b - 14'd12032 : 14'd0;
    assign                    ram_row_rd_adr_a[47][14-1:0]    = rd_ram_row_sel_a[47] ? rd_adr_a - 14'd12032 : 14'd0;
    assign                    ram_row_rd_adr_b[47][14-1:0]    = rd_ram_row_sel_b[47] ? rd_adr_b - 14'd12032 : 14'd0;
    assign                    ram_row_wr_adr_a[48][14-1:0]    = wr_ram_row_sel_a[48] ? wr_adr_a - 14'd12288 : 14'd0;
    assign                    ram_row_wr_adr_b[48][14-1:0]    = wr_ram_row_sel_b[48] ? wr_adr_b - 14'd12288 : 14'd0;
    assign                    ram_row_rd_adr_a[48][14-1:0]    = rd_ram_row_sel_a[48] ? rd_adr_a - 14'd12288 : 14'd0;
    assign                    ram_row_rd_adr_b[48][14-1:0]    = rd_ram_row_sel_b[48] ? rd_adr_b - 14'd12288 : 14'd0;
    assign                    ram_row_wr_adr_a[49][14-1:0]    = wr_ram_row_sel_a[49] ? wr_adr_a - 14'd12544 : 14'd0;
    assign                    ram_row_wr_adr_b[49][14-1:0]    = wr_ram_row_sel_b[49] ? wr_adr_b - 14'd12544 : 14'd0;
    assign                    ram_row_rd_adr_a[49][14-1:0]    = rd_ram_row_sel_a[49] ? rd_adr_a - 14'd12544 : 14'd0;
    assign                    ram_row_rd_adr_b[49][14-1:0]    = rd_ram_row_sel_b[49] ? rd_adr_b - 14'd12544 : 14'd0;
    assign                    ram_row_wr_adr_a[50][14-1:0]    = wr_ram_row_sel_a[50] ? wr_adr_a - 14'd12800 : 14'd0;
    assign                    ram_row_wr_adr_b[50][14-1:0]    = wr_ram_row_sel_b[50] ? wr_adr_b - 14'd12800 : 14'd0;
    assign                    ram_row_rd_adr_a[50][14-1:0]    = rd_ram_row_sel_a[50] ? rd_adr_a - 14'd12800 : 14'd0;
    assign                    ram_row_rd_adr_b[50][14-1:0]    = rd_ram_row_sel_b[50] ? rd_adr_b - 14'd12800 : 14'd0;
    assign                    ram_row_wr_adr_a[51][14-1:0]    = wr_ram_row_sel_a[51] ? wr_adr_a - 14'd13056 : 14'd0;
    assign                    ram_row_wr_adr_b[51][14-1:0]    = wr_ram_row_sel_b[51] ? wr_adr_b - 14'd13056 : 14'd0;
    assign                    ram_row_rd_adr_a[51][14-1:0]    = rd_ram_row_sel_a[51] ? rd_adr_a - 14'd13056 : 14'd0;
    assign                    ram_row_rd_adr_b[51][14-1:0]    = rd_ram_row_sel_b[51] ? rd_adr_b - 14'd13056 : 14'd0;
    assign                    ram_row_wr_adr_a[52][14-1:0]    = wr_ram_row_sel_a[52] ? wr_adr_a - 14'd13312 : 14'd0;
    assign                    ram_row_wr_adr_b[52][14-1:0]    = wr_ram_row_sel_b[52] ? wr_adr_b - 14'd13312 : 14'd0;
    assign                    ram_row_rd_adr_a[52][14-1:0]    = rd_ram_row_sel_a[52] ? rd_adr_a - 14'd13312 : 14'd0;
    assign                    ram_row_rd_adr_b[52][14-1:0]    = rd_ram_row_sel_b[52] ? rd_adr_b - 14'd13312 : 14'd0;
    assign                    ram_row_wr_adr_a[53][14-1:0]    = wr_ram_row_sel_a[53] ? wr_adr_a - 14'd13568 : 14'd0;
    assign                    ram_row_wr_adr_b[53][14-1:0]    = wr_ram_row_sel_b[53] ? wr_adr_b - 14'd13568 : 14'd0;
    assign                    ram_row_rd_adr_a[53][14-1:0]    = rd_ram_row_sel_a[53] ? rd_adr_a - 14'd13568 : 14'd0;
    assign                    ram_row_rd_adr_b[53][14-1:0]    = rd_ram_row_sel_b[53] ? rd_adr_b - 14'd13568 : 14'd0;
    assign                    ram_row_wr_adr_a[54][14-1:0]    = wr_ram_row_sel_a[54] ? wr_adr_a - 14'd13824 : 14'd0;
    assign                    ram_row_wr_adr_b[54][14-1:0]    = wr_ram_row_sel_b[54] ? wr_adr_b - 14'd13824 : 14'd0;
    assign                    ram_row_rd_adr_a[54][14-1:0]    = rd_ram_row_sel_a[54] ? rd_adr_a - 14'd13824 : 14'd0;
    assign                    ram_row_rd_adr_b[54][14-1:0]    = rd_ram_row_sel_b[54] ? rd_adr_b - 14'd13824 : 14'd0;
    assign                    ram_row_wr_adr_a[55][14-1:0]    = wr_ram_row_sel_a[55] ? wr_adr_a - 14'd14080 : 14'd0;
    assign                    ram_row_wr_adr_b[55][14-1:0]    = wr_ram_row_sel_b[55] ? wr_adr_b - 14'd14080 : 14'd0;
    assign                    ram_row_rd_adr_a[55][14-1:0]    = rd_ram_row_sel_a[55] ? rd_adr_a - 14'd14080 : 14'd0;
    assign                    ram_row_rd_adr_b[55][14-1:0]    = rd_ram_row_sel_b[55] ? rd_adr_b - 14'd14080 : 14'd0;
    assign                    ram_row_wr_adr_a[56][14-1:0]    = wr_ram_row_sel_a[56] ? wr_adr_a - 14'd14336 : 14'd0;
    assign                    ram_row_wr_adr_b[56][14-1:0]    = wr_ram_row_sel_b[56] ? wr_adr_b - 14'd14336 : 14'd0;
    assign                    ram_row_rd_adr_a[56][14-1:0]    = rd_ram_row_sel_a[56] ? rd_adr_a - 14'd14336 : 14'd0;
    assign                    ram_row_rd_adr_b[56][14-1:0]    = rd_ram_row_sel_b[56] ? rd_adr_b - 14'd14336 : 14'd0;
    assign                    ram_row_wr_adr_a[57][14-1:0]    = wr_ram_row_sel_a[57] ? wr_adr_a - 14'd14592 : 14'd0;
    assign                    ram_row_wr_adr_b[57][14-1:0]    = wr_ram_row_sel_b[57] ? wr_adr_b - 14'd14592 : 14'd0;
    assign                    ram_row_rd_adr_a[57][14-1:0]    = rd_ram_row_sel_a[57] ? rd_adr_a - 14'd14592 : 14'd0;
    assign                    ram_row_rd_adr_b[57][14-1:0]    = rd_ram_row_sel_b[57] ? rd_adr_b - 14'd14592 : 14'd0;
    assign                    ram_row_wr_adr_a[58][14-1:0]    = wr_ram_row_sel_a[58] ? wr_adr_a - 14'd14848 : 14'd0;
    assign                    ram_row_wr_adr_b[58][14-1:0]    = wr_ram_row_sel_b[58] ? wr_adr_b - 14'd14848 : 14'd0;
    assign                    ram_row_rd_adr_a[58][14-1:0]    = rd_ram_row_sel_a[58] ? rd_adr_a - 14'd14848 : 14'd0;
    assign                    ram_row_rd_adr_b[58][14-1:0]    = rd_ram_row_sel_b[58] ? rd_adr_b - 14'd14848 : 14'd0;
    assign                    ram_row_wr_adr_a[59][14-1:0]    = wr_ram_row_sel_a[59] ? wr_adr_a - 14'd15104 : 14'd0;
    assign                    ram_row_wr_adr_b[59][14-1:0]    = wr_ram_row_sel_b[59] ? wr_adr_b - 14'd15104 : 14'd0;
    assign                    ram_row_rd_adr_a[59][14-1:0]    = rd_ram_row_sel_a[59] ? rd_adr_a - 14'd15104 : 14'd0;
    assign                    ram_row_rd_adr_b[59][14-1:0]    = rd_ram_row_sel_b[59] ? rd_adr_b - 14'd15104 : 14'd0;
    assign                    ram_row_wr_adr_a[60][14-1:0]    = wr_ram_row_sel_a[60] ? wr_adr_a - 14'd15360 : 14'd0;
    assign                    ram_row_wr_adr_b[60][14-1:0]    = wr_ram_row_sel_b[60] ? wr_adr_b - 14'd15360 : 14'd0;
    assign                    ram_row_rd_adr_a[60][14-1:0]    = rd_ram_row_sel_a[60] ? rd_adr_a - 14'd15360 : 14'd0;
    assign                    ram_row_rd_adr_b[60][14-1:0]    = rd_ram_row_sel_b[60] ? rd_adr_b - 14'd15360 : 14'd0;
    assign                    ram_row_wr_adr_a[61][14-1:0]    = wr_ram_row_sel_a[61] ? wr_adr_a - 14'd15616 : 14'd0;
    assign                    ram_row_wr_adr_b[61][14-1:0]    = wr_ram_row_sel_b[61] ? wr_adr_b - 14'd15616 : 14'd0;
    assign                    ram_row_rd_adr_a[61][14-1:0]    = rd_ram_row_sel_a[61] ? rd_adr_a - 14'd15616 : 14'd0;
    assign                    ram_row_rd_adr_b[61][14-1:0]    = rd_ram_row_sel_b[61] ? rd_adr_b - 14'd15616 : 14'd0;
    assign                    ram_row_wr_adr_a[62][14-1:0]    = wr_ram_row_sel_a[62] ? wr_adr_a - 14'd15872 : 14'd0;
    assign                    ram_row_wr_adr_b[62][14-1:0]    = wr_ram_row_sel_b[62] ? wr_adr_b - 14'd15872 : 14'd0;
    assign                    ram_row_rd_adr_a[62][14-1:0]    = rd_ram_row_sel_a[62] ? rd_adr_a - 14'd15872 : 14'd0;
    assign                    ram_row_rd_adr_b[62][14-1:0]    = rd_ram_row_sel_b[62] ? rd_adr_b - 14'd15872 : 14'd0;
    assign                    ram_row_wr_adr_a[63][14-1:0]    = wr_ram_row_sel_a[63] ? wr_adr_a - 14'd16128 : 14'd0;
    assign                    ram_row_wr_adr_b[63][14-1:0]    = wr_ram_row_sel_b[63] ? wr_adr_b - 14'd16128 : 14'd0;
    assign                    ram_row_rd_adr_a[63][14-1:0]    = rd_ram_row_sel_a[63] ? rd_adr_a - 14'd16128 : 14'd0;
    assign                    ram_row_rd_adr_b[63][14-1:0]    = rd_ram_row_sel_b[63] ? rd_adr_b - 14'd16128 : 14'd0;


    // RAM Read Enable Decoder

    wire    [64-1:0]        ram_row_rd_en_a;
    assign            ram_row_rd_en_a[0]        = rd_ram_row_sel_a[0] ? rd_en_a : 1'b0;
    assign            ram_row_rd_en_a[1]        = rd_ram_row_sel_a[1] ? rd_en_a : 1'b0;
    assign            ram_row_rd_en_a[2]        = rd_ram_row_sel_a[2] ? rd_en_a : 1'b0;
    assign            ram_row_rd_en_a[3]        = rd_ram_row_sel_a[3] ? rd_en_a : 1'b0;
    assign            ram_row_rd_en_a[4]        = rd_ram_row_sel_a[4] ? rd_en_a : 1'b0;
    assign            ram_row_rd_en_a[5]        = rd_ram_row_sel_a[5] ? rd_en_a : 1'b0;
    assign            ram_row_rd_en_a[6]        = rd_ram_row_sel_a[6] ? rd_en_a : 1'b0;
    assign            ram_row_rd_en_a[7]        = rd_ram_row_sel_a[7] ? rd_en_a : 1'b0;
    assign            ram_row_rd_en_a[8]        = rd_ram_row_sel_a[8] ? rd_en_a : 1'b0;
    assign            ram_row_rd_en_a[9]        = rd_ram_row_sel_a[9] ? rd_en_a : 1'b0;
    assign            ram_row_rd_en_a[10]        = rd_ram_row_sel_a[10] ? rd_en_a : 1'b0;
    assign            ram_row_rd_en_a[11]        = rd_ram_row_sel_a[11] ? rd_en_a : 1'b0;
    assign            ram_row_rd_en_a[12]        = rd_ram_row_sel_a[12] ? rd_en_a : 1'b0;
    assign            ram_row_rd_en_a[13]        = rd_ram_row_sel_a[13] ? rd_en_a : 1'b0;
    assign            ram_row_rd_en_a[14]        = rd_ram_row_sel_a[14] ? rd_en_a : 1'b0;
    assign            ram_row_rd_en_a[15]        = rd_ram_row_sel_a[15] ? rd_en_a : 1'b0;
    assign            ram_row_rd_en_a[16]        = rd_ram_row_sel_a[16] ? rd_en_a : 1'b0;
    assign            ram_row_rd_en_a[17]        = rd_ram_row_sel_a[17] ? rd_en_a : 1'b0;
    assign            ram_row_rd_en_a[18]        = rd_ram_row_sel_a[18] ? rd_en_a : 1'b0;
    assign            ram_row_rd_en_a[19]        = rd_ram_row_sel_a[19] ? rd_en_a : 1'b0;
    assign            ram_row_rd_en_a[20]        = rd_ram_row_sel_a[20] ? rd_en_a : 1'b0;
    assign            ram_row_rd_en_a[21]        = rd_ram_row_sel_a[21] ? rd_en_a : 1'b0;
    assign            ram_row_rd_en_a[22]        = rd_ram_row_sel_a[22] ? rd_en_a : 1'b0;
    assign            ram_row_rd_en_a[23]        = rd_ram_row_sel_a[23] ? rd_en_a : 1'b0;
    assign            ram_row_rd_en_a[24]        = rd_ram_row_sel_a[24] ? rd_en_a : 1'b0;
    assign            ram_row_rd_en_a[25]        = rd_ram_row_sel_a[25] ? rd_en_a : 1'b0;
    assign            ram_row_rd_en_a[26]        = rd_ram_row_sel_a[26] ? rd_en_a : 1'b0;
    assign            ram_row_rd_en_a[27]        = rd_ram_row_sel_a[27] ? rd_en_a : 1'b0;
    assign            ram_row_rd_en_a[28]        = rd_ram_row_sel_a[28] ? rd_en_a : 1'b0;
    assign            ram_row_rd_en_a[29]        = rd_ram_row_sel_a[29] ? rd_en_a : 1'b0;
    assign            ram_row_rd_en_a[30]        = rd_ram_row_sel_a[30] ? rd_en_a : 1'b0;
    assign            ram_row_rd_en_a[31]        = rd_ram_row_sel_a[31] ? rd_en_a : 1'b0;
    assign            ram_row_rd_en_a[32]        = rd_ram_row_sel_a[32] ? rd_en_a : 1'b0;
    assign            ram_row_rd_en_a[33]        = rd_ram_row_sel_a[33] ? rd_en_a : 1'b0;
    assign            ram_row_rd_en_a[34]        = rd_ram_row_sel_a[34] ? rd_en_a : 1'b0;
    assign            ram_row_rd_en_a[35]        = rd_ram_row_sel_a[35] ? rd_en_a : 1'b0;
    assign            ram_row_rd_en_a[36]        = rd_ram_row_sel_a[36] ? rd_en_a : 1'b0;
    assign            ram_row_rd_en_a[37]        = rd_ram_row_sel_a[37] ? rd_en_a : 1'b0;
    assign            ram_row_rd_en_a[38]        = rd_ram_row_sel_a[38] ? rd_en_a : 1'b0;
    assign            ram_row_rd_en_a[39]        = rd_ram_row_sel_a[39] ? rd_en_a : 1'b0;
    assign            ram_row_rd_en_a[40]        = rd_ram_row_sel_a[40] ? rd_en_a : 1'b0;
    assign            ram_row_rd_en_a[41]        = rd_ram_row_sel_a[41] ? rd_en_a : 1'b0;
    assign            ram_row_rd_en_a[42]        = rd_ram_row_sel_a[42] ? rd_en_a : 1'b0;
    assign            ram_row_rd_en_a[43]        = rd_ram_row_sel_a[43] ? rd_en_a : 1'b0;
    assign            ram_row_rd_en_a[44]        = rd_ram_row_sel_a[44] ? rd_en_a : 1'b0;
    assign            ram_row_rd_en_a[45]        = rd_ram_row_sel_a[45] ? rd_en_a : 1'b0;
    assign            ram_row_rd_en_a[46]        = rd_ram_row_sel_a[46] ? rd_en_a : 1'b0;
    assign            ram_row_rd_en_a[47]        = rd_ram_row_sel_a[47] ? rd_en_a : 1'b0;
    assign            ram_row_rd_en_a[48]        = rd_ram_row_sel_a[48] ? rd_en_a : 1'b0;
    assign            ram_row_rd_en_a[49]        = rd_ram_row_sel_a[49] ? rd_en_a : 1'b0;
    assign            ram_row_rd_en_a[50]        = rd_ram_row_sel_a[50] ? rd_en_a : 1'b0;
    assign            ram_row_rd_en_a[51]        = rd_ram_row_sel_a[51] ? rd_en_a : 1'b0;
    assign            ram_row_rd_en_a[52]        = rd_ram_row_sel_a[52] ? rd_en_a : 1'b0;
    assign            ram_row_rd_en_a[53]        = rd_ram_row_sel_a[53] ? rd_en_a : 1'b0;
    assign            ram_row_rd_en_a[54]        = rd_ram_row_sel_a[54] ? rd_en_a : 1'b0;
    assign            ram_row_rd_en_a[55]        = rd_ram_row_sel_a[55] ? rd_en_a : 1'b0;
    assign            ram_row_rd_en_a[56]        = rd_ram_row_sel_a[56] ? rd_en_a : 1'b0;
    assign            ram_row_rd_en_a[57]        = rd_ram_row_sel_a[57] ? rd_en_a : 1'b0;
    assign            ram_row_rd_en_a[58]        = rd_ram_row_sel_a[58] ? rd_en_a : 1'b0;
    assign            ram_row_rd_en_a[59]        = rd_ram_row_sel_a[59] ? rd_en_a : 1'b0;
    assign            ram_row_rd_en_a[60]        = rd_ram_row_sel_a[60] ? rd_en_a : 1'b0;
    assign            ram_row_rd_en_a[61]        = rd_ram_row_sel_a[61] ? rd_en_a : 1'b0;
    assign            ram_row_rd_en_a[62]        = rd_ram_row_sel_a[62] ? rd_en_a : 1'b0;
    assign            ram_row_rd_en_a[63]        = rd_ram_row_sel_a[63] ? rd_en_a : 1'b0;
    wire    [64-1:0]        ram_row_rd_en_b;
    assign            ram_row_rd_en_b[0]        = rd_ram_row_sel_b[0] ? rd_en_b : 1'b0;
    assign            ram_row_rd_en_b[1]        = rd_ram_row_sel_b[1] ? rd_en_b : 1'b0;
    assign            ram_row_rd_en_b[2]        = rd_ram_row_sel_b[2] ? rd_en_b : 1'b0;
    assign            ram_row_rd_en_b[3]        = rd_ram_row_sel_b[3] ? rd_en_b : 1'b0;
    assign            ram_row_rd_en_b[4]        = rd_ram_row_sel_b[4] ? rd_en_b : 1'b0;
    assign            ram_row_rd_en_b[5]        = rd_ram_row_sel_b[5] ? rd_en_b : 1'b0;
    assign            ram_row_rd_en_b[6]        = rd_ram_row_sel_b[6] ? rd_en_b : 1'b0;
    assign            ram_row_rd_en_b[7]        = rd_ram_row_sel_b[7] ? rd_en_b : 1'b0;
    assign            ram_row_rd_en_b[8]        = rd_ram_row_sel_b[8] ? rd_en_b : 1'b0;
    assign            ram_row_rd_en_b[9]        = rd_ram_row_sel_b[9] ? rd_en_b : 1'b0;
    assign            ram_row_rd_en_b[10]        = rd_ram_row_sel_b[10] ? rd_en_b : 1'b0;
    assign            ram_row_rd_en_b[11]        = rd_ram_row_sel_b[11] ? rd_en_b : 1'b0;
    assign            ram_row_rd_en_b[12]        = rd_ram_row_sel_b[12] ? rd_en_b : 1'b0;
    assign            ram_row_rd_en_b[13]        = rd_ram_row_sel_b[13] ? rd_en_b : 1'b0;
    assign            ram_row_rd_en_b[14]        = rd_ram_row_sel_b[14] ? rd_en_b : 1'b0;
    assign            ram_row_rd_en_b[15]        = rd_ram_row_sel_b[15] ? rd_en_b : 1'b0;
    assign            ram_row_rd_en_b[16]        = rd_ram_row_sel_b[16] ? rd_en_b : 1'b0;
    assign            ram_row_rd_en_b[17]        = rd_ram_row_sel_b[17] ? rd_en_b : 1'b0;
    assign            ram_row_rd_en_b[18]        = rd_ram_row_sel_b[18] ? rd_en_b : 1'b0;
    assign            ram_row_rd_en_b[19]        = rd_ram_row_sel_b[19] ? rd_en_b : 1'b0;
    assign            ram_row_rd_en_b[20]        = rd_ram_row_sel_b[20] ? rd_en_b : 1'b0;
    assign            ram_row_rd_en_b[21]        = rd_ram_row_sel_b[21] ? rd_en_b : 1'b0;
    assign            ram_row_rd_en_b[22]        = rd_ram_row_sel_b[22] ? rd_en_b : 1'b0;
    assign            ram_row_rd_en_b[23]        = rd_ram_row_sel_b[23] ? rd_en_b : 1'b0;
    assign            ram_row_rd_en_b[24]        = rd_ram_row_sel_b[24] ? rd_en_b : 1'b0;
    assign            ram_row_rd_en_b[25]        = rd_ram_row_sel_b[25] ? rd_en_b : 1'b0;
    assign            ram_row_rd_en_b[26]        = rd_ram_row_sel_b[26] ? rd_en_b : 1'b0;
    assign            ram_row_rd_en_b[27]        = rd_ram_row_sel_b[27] ? rd_en_b : 1'b0;
    assign            ram_row_rd_en_b[28]        = rd_ram_row_sel_b[28] ? rd_en_b : 1'b0;
    assign            ram_row_rd_en_b[29]        = rd_ram_row_sel_b[29] ? rd_en_b : 1'b0;
    assign            ram_row_rd_en_b[30]        = rd_ram_row_sel_b[30] ? rd_en_b : 1'b0;
    assign            ram_row_rd_en_b[31]        = rd_ram_row_sel_b[31] ? rd_en_b : 1'b0;
    assign            ram_row_rd_en_b[32]        = rd_ram_row_sel_b[32] ? rd_en_b : 1'b0;
    assign            ram_row_rd_en_b[33]        = rd_ram_row_sel_b[33] ? rd_en_b : 1'b0;
    assign            ram_row_rd_en_b[34]        = rd_ram_row_sel_b[34] ? rd_en_b : 1'b0;
    assign            ram_row_rd_en_b[35]        = rd_ram_row_sel_b[35] ? rd_en_b : 1'b0;
    assign            ram_row_rd_en_b[36]        = rd_ram_row_sel_b[36] ? rd_en_b : 1'b0;
    assign            ram_row_rd_en_b[37]        = rd_ram_row_sel_b[37] ? rd_en_b : 1'b0;
    assign            ram_row_rd_en_b[38]        = rd_ram_row_sel_b[38] ? rd_en_b : 1'b0;
    assign            ram_row_rd_en_b[39]        = rd_ram_row_sel_b[39] ? rd_en_b : 1'b0;
    assign            ram_row_rd_en_b[40]        = rd_ram_row_sel_b[40] ? rd_en_b : 1'b0;
    assign            ram_row_rd_en_b[41]        = rd_ram_row_sel_b[41] ? rd_en_b : 1'b0;
    assign            ram_row_rd_en_b[42]        = rd_ram_row_sel_b[42] ? rd_en_b : 1'b0;
    assign            ram_row_rd_en_b[43]        = rd_ram_row_sel_b[43] ? rd_en_b : 1'b0;
    assign            ram_row_rd_en_b[44]        = rd_ram_row_sel_b[44] ? rd_en_b : 1'b0;
    assign            ram_row_rd_en_b[45]        = rd_ram_row_sel_b[45] ? rd_en_b : 1'b0;
    assign            ram_row_rd_en_b[46]        = rd_ram_row_sel_b[46] ? rd_en_b : 1'b0;
    assign            ram_row_rd_en_b[47]        = rd_ram_row_sel_b[47] ? rd_en_b : 1'b0;
    assign            ram_row_rd_en_b[48]        = rd_ram_row_sel_b[48] ? rd_en_b : 1'b0;
    assign            ram_row_rd_en_b[49]        = rd_ram_row_sel_b[49] ? rd_en_b : 1'b0;
    assign            ram_row_rd_en_b[50]        = rd_ram_row_sel_b[50] ? rd_en_b : 1'b0;
    assign            ram_row_rd_en_b[51]        = rd_ram_row_sel_b[51] ? rd_en_b : 1'b0;
    assign            ram_row_rd_en_b[52]        = rd_ram_row_sel_b[52] ? rd_en_b : 1'b0;
    assign            ram_row_rd_en_b[53]        = rd_ram_row_sel_b[53] ? rd_en_b : 1'b0;
    assign            ram_row_rd_en_b[54]        = rd_ram_row_sel_b[54] ? rd_en_b : 1'b0;
    assign            ram_row_rd_en_b[55]        = rd_ram_row_sel_b[55] ? rd_en_b : 1'b0;
    assign            ram_row_rd_en_b[56]        = rd_ram_row_sel_b[56] ? rd_en_b : 1'b0;
    assign            ram_row_rd_en_b[57]        = rd_ram_row_sel_b[57] ? rd_en_b : 1'b0;
    assign            ram_row_rd_en_b[58]        = rd_ram_row_sel_b[58] ? rd_en_b : 1'b0;
    assign            ram_row_rd_en_b[59]        = rd_ram_row_sel_b[59] ? rd_en_b : 1'b0;
    assign            ram_row_rd_en_b[60]        = rd_ram_row_sel_b[60] ? rd_en_b : 1'b0;
    assign            ram_row_rd_en_b[61]        = rd_ram_row_sel_b[61] ? rd_en_b : 1'b0;
    assign            ram_row_rd_en_b[62]        = rd_ram_row_sel_b[62] ? rd_en_b : 1'b0;
    assign            ram_row_rd_en_b[63]        = rd_ram_row_sel_b[63] ? rd_en_b : 1'b0;


    // Read Delay

    reg    [64-1:0]    rd_en_a_delay[MEM_DELAY:0];
    reg    [64-1:0]    rd_en_b_delay[MEM_DELAY:0];
    generate
            if (MEM_PST_EBB_SAMPLE == 1) begin: PST_EBB_SAMPLE_RD_EN_DELAY

                  logic [64-1:0]        ram_row_rd_en_a_s;
                  always_ff @(posedge clk_a) begin
                      ram_row_rd_en_a_s <= ram_row_rd_en_a;
                  end
                  assign  rd_en_a_delay[0][64-1:0] = ram_row_rd_en_a_s[64-1:0];

                  logic [64-1:0]        ram_row_rd_en_b_s;
                  always_ff @(posedge clk_b) begin
                      ram_row_rd_en_b_s <= ram_row_rd_en_b;
                  end
                  assign  rd_en_b_delay[0][64-1:0] = ram_row_rd_en_b_s[64-1:0];
              end
              else begin: NO_PST_EBB_SAMPLE_RD_EN_DELAY
                  assign  rd_en_a_delay[0][64-1:0] = ram_row_rd_en_a[64-1:0];
                  assign  rd_en_b_delay[0][64-1:0] = ram_row_rd_en_b[64-1:0];
              end
    endgenerate
    always_ff @(posedge clk_a)
            for (int i = 0; i <= (MEM_DELAY - 1); i = i + 1) begin
                rd_en_a_delay[i+1]        <= rd_en_a_delay[i];
            end
    always_ff @(posedge clk_b)
            for (int i = 0; i <= (MEM_DELAY - 1); i = i + 1) begin
                rd_en_b_delay[i+1]        <= rd_en_b_delay[i];
            end
    logic    [6-1:0]        ram_row_num_rd_en_a_delay;
    always_ff @(posedge clk_a) begin
        if (|rd_en_a_delay[MEM_DELAY-1]) begin
            for (int i = 0; i < 64; i = i + 1) begin
                if (rd_en_a_delay[MEM_DELAY-1][i]) begin
                    ram_row_num_rd_en_a_delay[6-1:0]    <= i;
                end
            end
        end
    end
    logic    [6-1:0]        ram_row_num_rd_en_b_delay;
    always_ff @(posedge clk_b) begin
        if (|rd_en_b_delay[MEM_DELAY-1]) begin
            for (int i = 0; i < 64; i = i + 1) begin
                if (rd_en_b_delay[MEM_DELAY-1][i]) begin
                    ram_row_num_rd_en_b_delay[6-1:0]    <= i;
                end
            end
        end
    end


    // Write Data

    logic    [34-1:0]    wr_data_a_full;
    assign            wr_data_a_full    = wr_data_a;
    logic    [34-1:0]    wr_data_b_full;
    assign            wr_data_b_full    = wr_data_b;
    logic    [34-1:0]    ram_row_wr_data_a;
    always_comb begin
        for (int i = 0; i < MEM_WR_EN_WIDTH; i = i + 1) begin
            ram_row_wr_data_a[i*(MEM_WR_RESOLUTION)+:MEM_WR_RESOLUTION]    = wr_data_a_full[i*MEM_WR_RESOLUTION+:MEM_WR_RESOLUTION];
        end
    end
    logic    [34-1:0]    ram_row_wr_data_b;
    always_comb begin
        for (int i = 0; i < MEM_WR_EN_WIDTH; i = i + 1) begin
            ram_row_wr_data_b[i*(MEM_WR_RESOLUTION)+:MEM_WR_RESOLUTION]    = wr_data_b_full[i*MEM_WR_RESOLUTION+:MEM_WR_RESOLUTION];
        end
    end
    logic    [34-1:0]    ram_wr_data_a_col[1-1:0];
    logic    [34-1:0]    ram_wr_data_b_col[1-1:0];
    always_comb begin
        for (int i = 0; i < 1; i = i + 1) begin
            ram_wr_data_a_col[i][34-1:0]        = ram_row_wr_data_a[i*34+:34];
            ram_wr_data_b_col[i][34-1:0]        = ram_row_wr_data_b[i*34+:34];
        end
    end


    // Write Enable

    logic    [MEM_WR_EN_WIDTH-1:0]    wr_en_a_full;
    assign            wr_en_a_full    = wr_en_a;
    logic    [MEM_WR_EN_WIDTH-1:0]    wr_en_b_full;
    assign            wr_en_b_full    = wr_en_b;
    logic    [1-1:0]    ram_row_wr_en_a[64-1:0];
    logic    [1-1:0]    ram_row_wr_en_b[64-1:0];
    always_comb begin
        ram_row_wr_en_a[0] = {1{1'b0}};
        ram_row_wr_en_a[0][1-1:0]    =  wr_ram_row_sel_a[0] ? {{1{wr_en_a_full[0]}}} : 1'd0;
    end
    always_comb begin
        ram_row_wr_en_b[0] = {1{1'b0}};
        ram_row_wr_en_b[0][1-1:0]    =  wr_ram_row_sel_b[0] ? {{1{wr_en_b_full[0]}}} : 1'd0;
    end
    always_comb begin
        ram_row_wr_en_a[1] = {1{1'b0}};
        ram_row_wr_en_a[1][1-1:0]    =  wr_ram_row_sel_a[1] ? {{1{wr_en_a_full[0]}}} : 1'd0;
    end
    always_comb begin
        ram_row_wr_en_b[1] = {1{1'b0}};
        ram_row_wr_en_b[1][1-1:0]    =  wr_ram_row_sel_b[1] ? {{1{wr_en_b_full[0]}}} : 1'd0;
    end
    always_comb begin
        ram_row_wr_en_a[2] = {1{1'b0}};
        ram_row_wr_en_a[2][1-1:0]    =  wr_ram_row_sel_a[2] ? {{1{wr_en_a_full[0]}}} : 1'd0;
    end
    always_comb begin
        ram_row_wr_en_b[2] = {1{1'b0}};
        ram_row_wr_en_b[2][1-1:0]    =  wr_ram_row_sel_b[2] ? {{1{wr_en_b_full[0]}}} : 1'd0;
    end
    always_comb begin
        ram_row_wr_en_a[3] = {1{1'b0}};
        ram_row_wr_en_a[3][1-1:0]    =  wr_ram_row_sel_a[3] ? {{1{wr_en_a_full[0]}}} : 1'd0;
    end
    always_comb begin
        ram_row_wr_en_b[3] = {1{1'b0}};
        ram_row_wr_en_b[3][1-1:0]    =  wr_ram_row_sel_b[3] ? {{1{wr_en_b_full[0]}}} : 1'd0;
    end
    always_comb begin
        ram_row_wr_en_a[4] = {1{1'b0}};
        ram_row_wr_en_a[4][1-1:0]    =  wr_ram_row_sel_a[4] ? {{1{wr_en_a_full[0]}}} : 1'd0;
    end
    always_comb begin
        ram_row_wr_en_b[4] = {1{1'b0}};
        ram_row_wr_en_b[4][1-1:0]    =  wr_ram_row_sel_b[4] ? {{1{wr_en_b_full[0]}}} : 1'd0;
    end
    always_comb begin
        ram_row_wr_en_a[5] = {1{1'b0}};
        ram_row_wr_en_a[5][1-1:0]    =  wr_ram_row_sel_a[5] ? {{1{wr_en_a_full[0]}}} : 1'd0;
    end
    always_comb begin
        ram_row_wr_en_b[5] = {1{1'b0}};
        ram_row_wr_en_b[5][1-1:0]    =  wr_ram_row_sel_b[5] ? {{1{wr_en_b_full[0]}}} : 1'd0;
    end
    always_comb begin
        ram_row_wr_en_a[6] = {1{1'b0}};
        ram_row_wr_en_a[6][1-1:0]    =  wr_ram_row_sel_a[6] ? {{1{wr_en_a_full[0]}}} : 1'd0;
    end
    always_comb begin
        ram_row_wr_en_b[6] = {1{1'b0}};
        ram_row_wr_en_b[6][1-1:0]    =  wr_ram_row_sel_b[6] ? {{1{wr_en_b_full[0]}}} : 1'd0;
    end
    always_comb begin
        ram_row_wr_en_a[7] = {1{1'b0}};
        ram_row_wr_en_a[7][1-1:0]    =  wr_ram_row_sel_a[7] ? {{1{wr_en_a_full[0]}}} : 1'd0;
    end
    always_comb begin
        ram_row_wr_en_b[7] = {1{1'b0}};
        ram_row_wr_en_b[7][1-1:0]    =  wr_ram_row_sel_b[7] ? {{1{wr_en_b_full[0]}}} : 1'd0;
    end
    always_comb begin
        ram_row_wr_en_a[8] = {1{1'b0}};
        ram_row_wr_en_a[8][1-1:0]    =  wr_ram_row_sel_a[8] ? {{1{wr_en_a_full[0]}}} : 1'd0;
    end
    always_comb begin
        ram_row_wr_en_b[8] = {1{1'b0}};
        ram_row_wr_en_b[8][1-1:0]    =  wr_ram_row_sel_b[8] ? {{1{wr_en_b_full[0]}}} : 1'd0;
    end
    always_comb begin
        ram_row_wr_en_a[9] = {1{1'b0}};
        ram_row_wr_en_a[9][1-1:0]    =  wr_ram_row_sel_a[9] ? {{1{wr_en_a_full[0]}}} : 1'd0;
    end
    always_comb begin
        ram_row_wr_en_b[9] = {1{1'b0}};
        ram_row_wr_en_b[9][1-1:0]    =  wr_ram_row_sel_b[9] ? {{1{wr_en_b_full[0]}}} : 1'd0;
    end
    always_comb begin
        ram_row_wr_en_a[10] = {1{1'b0}};
        ram_row_wr_en_a[10][1-1:0]    =  wr_ram_row_sel_a[10] ? {{1{wr_en_a_full[0]}}} : 1'd0;
    end
    always_comb begin
        ram_row_wr_en_b[10] = {1{1'b0}};
        ram_row_wr_en_b[10][1-1:0]    =  wr_ram_row_sel_b[10] ? {{1{wr_en_b_full[0]}}} : 1'd0;
    end
    always_comb begin
        ram_row_wr_en_a[11] = {1{1'b0}};
        ram_row_wr_en_a[11][1-1:0]    =  wr_ram_row_sel_a[11] ? {{1{wr_en_a_full[0]}}} : 1'd0;
    end
    always_comb begin
        ram_row_wr_en_b[11] = {1{1'b0}};
        ram_row_wr_en_b[11][1-1:0]    =  wr_ram_row_sel_b[11] ? {{1{wr_en_b_full[0]}}} : 1'd0;
    end
    always_comb begin
        ram_row_wr_en_a[12] = {1{1'b0}};
        ram_row_wr_en_a[12][1-1:0]    =  wr_ram_row_sel_a[12] ? {{1{wr_en_a_full[0]}}} : 1'd0;
    end
    always_comb begin
        ram_row_wr_en_b[12] = {1{1'b0}};
        ram_row_wr_en_b[12][1-1:0]    =  wr_ram_row_sel_b[12] ? {{1{wr_en_b_full[0]}}} : 1'd0;
    end
    always_comb begin
        ram_row_wr_en_a[13] = {1{1'b0}};
        ram_row_wr_en_a[13][1-1:0]    =  wr_ram_row_sel_a[13] ? {{1{wr_en_a_full[0]}}} : 1'd0;
    end
    always_comb begin
        ram_row_wr_en_b[13] = {1{1'b0}};
        ram_row_wr_en_b[13][1-1:0]    =  wr_ram_row_sel_b[13] ? {{1{wr_en_b_full[0]}}} : 1'd0;
    end
    always_comb begin
        ram_row_wr_en_a[14] = {1{1'b0}};
        ram_row_wr_en_a[14][1-1:0]    =  wr_ram_row_sel_a[14] ? {{1{wr_en_a_full[0]}}} : 1'd0;
    end
    always_comb begin
        ram_row_wr_en_b[14] = {1{1'b0}};
        ram_row_wr_en_b[14][1-1:0]    =  wr_ram_row_sel_b[14] ? {{1{wr_en_b_full[0]}}} : 1'd0;
    end
    always_comb begin
        ram_row_wr_en_a[15] = {1{1'b0}};
        ram_row_wr_en_a[15][1-1:0]    =  wr_ram_row_sel_a[15] ? {{1{wr_en_a_full[0]}}} : 1'd0;
    end
    always_comb begin
        ram_row_wr_en_b[15] = {1{1'b0}};
        ram_row_wr_en_b[15][1-1:0]    =  wr_ram_row_sel_b[15] ? {{1{wr_en_b_full[0]}}} : 1'd0;
    end
    always_comb begin
        ram_row_wr_en_a[16] = {1{1'b0}};
        ram_row_wr_en_a[16][1-1:0]    =  wr_ram_row_sel_a[16] ? {{1{wr_en_a_full[0]}}} : 1'd0;
    end
    always_comb begin
        ram_row_wr_en_b[16] = {1{1'b0}};
        ram_row_wr_en_b[16][1-1:0]    =  wr_ram_row_sel_b[16] ? {{1{wr_en_b_full[0]}}} : 1'd0;
    end
    always_comb begin
        ram_row_wr_en_a[17] = {1{1'b0}};
        ram_row_wr_en_a[17][1-1:0]    =  wr_ram_row_sel_a[17] ? {{1{wr_en_a_full[0]}}} : 1'd0;
    end
    always_comb begin
        ram_row_wr_en_b[17] = {1{1'b0}};
        ram_row_wr_en_b[17][1-1:0]    =  wr_ram_row_sel_b[17] ? {{1{wr_en_b_full[0]}}} : 1'd0;
    end
    always_comb begin
        ram_row_wr_en_a[18] = {1{1'b0}};
        ram_row_wr_en_a[18][1-1:0]    =  wr_ram_row_sel_a[18] ? {{1{wr_en_a_full[0]}}} : 1'd0;
    end
    always_comb begin
        ram_row_wr_en_b[18] = {1{1'b0}};
        ram_row_wr_en_b[18][1-1:0]    =  wr_ram_row_sel_b[18] ? {{1{wr_en_b_full[0]}}} : 1'd0;
    end
    always_comb begin
        ram_row_wr_en_a[19] = {1{1'b0}};
        ram_row_wr_en_a[19][1-1:0]    =  wr_ram_row_sel_a[19] ? {{1{wr_en_a_full[0]}}} : 1'd0;
    end
    always_comb begin
        ram_row_wr_en_b[19] = {1{1'b0}};
        ram_row_wr_en_b[19][1-1:0]    =  wr_ram_row_sel_b[19] ? {{1{wr_en_b_full[0]}}} : 1'd0;
    end
    always_comb begin
        ram_row_wr_en_a[20] = {1{1'b0}};
        ram_row_wr_en_a[20][1-1:0]    =  wr_ram_row_sel_a[20] ? {{1{wr_en_a_full[0]}}} : 1'd0;
    end
    always_comb begin
        ram_row_wr_en_b[20] = {1{1'b0}};
        ram_row_wr_en_b[20][1-1:0]    =  wr_ram_row_sel_b[20] ? {{1{wr_en_b_full[0]}}} : 1'd0;
    end
    always_comb begin
        ram_row_wr_en_a[21] = {1{1'b0}};
        ram_row_wr_en_a[21][1-1:0]    =  wr_ram_row_sel_a[21] ? {{1{wr_en_a_full[0]}}} : 1'd0;
    end
    always_comb begin
        ram_row_wr_en_b[21] = {1{1'b0}};
        ram_row_wr_en_b[21][1-1:0]    =  wr_ram_row_sel_b[21] ? {{1{wr_en_b_full[0]}}} : 1'd0;
    end
    always_comb begin
        ram_row_wr_en_a[22] = {1{1'b0}};
        ram_row_wr_en_a[22][1-1:0]    =  wr_ram_row_sel_a[22] ? {{1{wr_en_a_full[0]}}} : 1'd0;
    end
    always_comb begin
        ram_row_wr_en_b[22] = {1{1'b0}};
        ram_row_wr_en_b[22][1-1:0]    =  wr_ram_row_sel_b[22] ? {{1{wr_en_b_full[0]}}} : 1'd0;
    end
    always_comb begin
        ram_row_wr_en_a[23] = {1{1'b0}};
        ram_row_wr_en_a[23][1-1:0]    =  wr_ram_row_sel_a[23] ? {{1{wr_en_a_full[0]}}} : 1'd0;
    end
    always_comb begin
        ram_row_wr_en_b[23] = {1{1'b0}};
        ram_row_wr_en_b[23][1-1:0]    =  wr_ram_row_sel_b[23] ? {{1{wr_en_b_full[0]}}} : 1'd0;
    end
    always_comb begin
        ram_row_wr_en_a[24] = {1{1'b0}};
        ram_row_wr_en_a[24][1-1:0]    =  wr_ram_row_sel_a[24] ? {{1{wr_en_a_full[0]}}} : 1'd0;
    end
    always_comb begin
        ram_row_wr_en_b[24] = {1{1'b0}};
        ram_row_wr_en_b[24][1-1:0]    =  wr_ram_row_sel_b[24] ? {{1{wr_en_b_full[0]}}} : 1'd0;
    end
    always_comb begin
        ram_row_wr_en_a[25] = {1{1'b0}};
        ram_row_wr_en_a[25][1-1:0]    =  wr_ram_row_sel_a[25] ? {{1{wr_en_a_full[0]}}} : 1'd0;
    end
    always_comb begin
        ram_row_wr_en_b[25] = {1{1'b0}};
        ram_row_wr_en_b[25][1-1:0]    =  wr_ram_row_sel_b[25] ? {{1{wr_en_b_full[0]}}} : 1'd0;
    end
    always_comb begin
        ram_row_wr_en_a[26] = {1{1'b0}};
        ram_row_wr_en_a[26][1-1:0]    =  wr_ram_row_sel_a[26] ? {{1{wr_en_a_full[0]}}} : 1'd0;
    end
    always_comb begin
        ram_row_wr_en_b[26] = {1{1'b0}};
        ram_row_wr_en_b[26][1-1:0]    =  wr_ram_row_sel_b[26] ? {{1{wr_en_b_full[0]}}} : 1'd0;
    end
    always_comb begin
        ram_row_wr_en_a[27] = {1{1'b0}};
        ram_row_wr_en_a[27][1-1:0]    =  wr_ram_row_sel_a[27] ? {{1{wr_en_a_full[0]}}} : 1'd0;
    end
    always_comb begin
        ram_row_wr_en_b[27] = {1{1'b0}};
        ram_row_wr_en_b[27][1-1:0]    =  wr_ram_row_sel_b[27] ? {{1{wr_en_b_full[0]}}} : 1'd0;
    end
    always_comb begin
        ram_row_wr_en_a[28] = {1{1'b0}};
        ram_row_wr_en_a[28][1-1:0]    =  wr_ram_row_sel_a[28] ? {{1{wr_en_a_full[0]}}} : 1'd0;
    end
    always_comb begin
        ram_row_wr_en_b[28] = {1{1'b0}};
        ram_row_wr_en_b[28][1-1:0]    =  wr_ram_row_sel_b[28] ? {{1{wr_en_b_full[0]}}} : 1'd0;
    end
    always_comb begin
        ram_row_wr_en_a[29] = {1{1'b0}};
        ram_row_wr_en_a[29][1-1:0]    =  wr_ram_row_sel_a[29] ? {{1{wr_en_a_full[0]}}} : 1'd0;
    end
    always_comb begin
        ram_row_wr_en_b[29] = {1{1'b0}};
        ram_row_wr_en_b[29][1-1:0]    =  wr_ram_row_sel_b[29] ? {{1{wr_en_b_full[0]}}} : 1'd0;
    end
    always_comb begin
        ram_row_wr_en_a[30] = {1{1'b0}};
        ram_row_wr_en_a[30][1-1:0]    =  wr_ram_row_sel_a[30] ? {{1{wr_en_a_full[0]}}} : 1'd0;
    end
    always_comb begin
        ram_row_wr_en_b[30] = {1{1'b0}};
        ram_row_wr_en_b[30][1-1:0]    =  wr_ram_row_sel_b[30] ? {{1{wr_en_b_full[0]}}} : 1'd0;
    end
    always_comb begin
        ram_row_wr_en_a[31] = {1{1'b0}};
        ram_row_wr_en_a[31][1-1:0]    =  wr_ram_row_sel_a[31] ? {{1{wr_en_a_full[0]}}} : 1'd0;
    end
    always_comb begin
        ram_row_wr_en_b[31] = {1{1'b0}};
        ram_row_wr_en_b[31][1-1:0]    =  wr_ram_row_sel_b[31] ? {{1{wr_en_b_full[0]}}} : 1'd0;
    end
    always_comb begin
        ram_row_wr_en_a[32] = {1{1'b0}};
        ram_row_wr_en_a[32][1-1:0]    =  wr_ram_row_sel_a[32] ? {{1{wr_en_a_full[0]}}} : 1'd0;
    end
    always_comb begin
        ram_row_wr_en_b[32] = {1{1'b0}};
        ram_row_wr_en_b[32][1-1:0]    =  wr_ram_row_sel_b[32] ? {{1{wr_en_b_full[0]}}} : 1'd0;
    end
    always_comb begin
        ram_row_wr_en_a[33] = {1{1'b0}};
        ram_row_wr_en_a[33][1-1:0]    =  wr_ram_row_sel_a[33] ? {{1{wr_en_a_full[0]}}} : 1'd0;
    end
    always_comb begin
        ram_row_wr_en_b[33] = {1{1'b0}};
        ram_row_wr_en_b[33][1-1:0]    =  wr_ram_row_sel_b[33] ? {{1{wr_en_b_full[0]}}} : 1'd0;
    end
    always_comb begin
        ram_row_wr_en_a[34] = {1{1'b0}};
        ram_row_wr_en_a[34][1-1:0]    =  wr_ram_row_sel_a[34] ? {{1{wr_en_a_full[0]}}} : 1'd0;
    end
    always_comb begin
        ram_row_wr_en_b[34] = {1{1'b0}};
        ram_row_wr_en_b[34][1-1:0]    =  wr_ram_row_sel_b[34] ? {{1{wr_en_b_full[0]}}} : 1'd0;
    end
    always_comb begin
        ram_row_wr_en_a[35] = {1{1'b0}};
        ram_row_wr_en_a[35][1-1:0]    =  wr_ram_row_sel_a[35] ? {{1{wr_en_a_full[0]}}} : 1'd0;
    end
    always_comb begin
        ram_row_wr_en_b[35] = {1{1'b0}};
        ram_row_wr_en_b[35][1-1:0]    =  wr_ram_row_sel_b[35] ? {{1{wr_en_b_full[0]}}} : 1'd0;
    end
    always_comb begin
        ram_row_wr_en_a[36] = {1{1'b0}};
        ram_row_wr_en_a[36][1-1:0]    =  wr_ram_row_sel_a[36] ? {{1{wr_en_a_full[0]}}} : 1'd0;
    end
    always_comb begin
        ram_row_wr_en_b[36] = {1{1'b0}};
        ram_row_wr_en_b[36][1-1:0]    =  wr_ram_row_sel_b[36] ? {{1{wr_en_b_full[0]}}} : 1'd0;
    end
    always_comb begin
        ram_row_wr_en_a[37] = {1{1'b0}};
        ram_row_wr_en_a[37][1-1:0]    =  wr_ram_row_sel_a[37] ? {{1{wr_en_a_full[0]}}} : 1'd0;
    end
    always_comb begin
        ram_row_wr_en_b[37] = {1{1'b0}};
        ram_row_wr_en_b[37][1-1:0]    =  wr_ram_row_sel_b[37] ? {{1{wr_en_b_full[0]}}} : 1'd0;
    end
    always_comb begin
        ram_row_wr_en_a[38] = {1{1'b0}};
        ram_row_wr_en_a[38][1-1:0]    =  wr_ram_row_sel_a[38] ? {{1{wr_en_a_full[0]}}} : 1'd0;
    end
    always_comb begin
        ram_row_wr_en_b[38] = {1{1'b0}};
        ram_row_wr_en_b[38][1-1:0]    =  wr_ram_row_sel_b[38] ? {{1{wr_en_b_full[0]}}} : 1'd0;
    end
    always_comb begin
        ram_row_wr_en_a[39] = {1{1'b0}};
        ram_row_wr_en_a[39][1-1:0]    =  wr_ram_row_sel_a[39] ? {{1{wr_en_a_full[0]}}} : 1'd0;
    end
    always_comb begin
        ram_row_wr_en_b[39] = {1{1'b0}};
        ram_row_wr_en_b[39][1-1:0]    =  wr_ram_row_sel_b[39] ? {{1{wr_en_b_full[0]}}} : 1'd0;
    end
    always_comb begin
        ram_row_wr_en_a[40] = {1{1'b0}};
        ram_row_wr_en_a[40][1-1:0]    =  wr_ram_row_sel_a[40] ? {{1{wr_en_a_full[0]}}} : 1'd0;
    end
    always_comb begin
        ram_row_wr_en_b[40] = {1{1'b0}};
        ram_row_wr_en_b[40][1-1:0]    =  wr_ram_row_sel_b[40] ? {{1{wr_en_b_full[0]}}} : 1'd0;
    end
    always_comb begin
        ram_row_wr_en_a[41] = {1{1'b0}};
        ram_row_wr_en_a[41][1-1:0]    =  wr_ram_row_sel_a[41] ? {{1{wr_en_a_full[0]}}} : 1'd0;
    end
    always_comb begin
        ram_row_wr_en_b[41] = {1{1'b0}};
        ram_row_wr_en_b[41][1-1:0]    =  wr_ram_row_sel_b[41] ? {{1{wr_en_b_full[0]}}} : 1'd0;
    end
    always_comb begin
        ram_row_wr_en_a[42] = {1{1'b0}};
        ram_row_wr_en_a[42][1-1:0]    =  wr_ram_row_sel_a[42] ? {{1{wr_en_a_full[0]}}} : 1'd0;
    end
    always_comb begin
        ram_row_wr_en_b[42] = {1{1'b0}};
        ram_row_wr_en_b[42][1-1:0]    =  wr_ram_row_sel_b[42] ? {{1{wr_en_b_full[0]}}} : 1'd0;
    end
    always_comb begin
        ram_row_wr_en_a[43] = {1{1'b0}};
        ram_row_wr_en_a[43][1-1:0]    =  wr_ram_row_sel_a[43] ? {{1{wr_en_a_full[0]}}} : 1'd0;
    end
    always_comb begin
        ram_row_wr_en_b[43] = {1{1'b0}};
        ram_row_wr_en_b[43][1-1:0]    =  wr_ram_row_sel_b[43] ? {{1{wr_en_b_full[0]}}} : 1'd0;
    end
    always_comb begin
        ram_row_wr_en_a[44] = {1{1'b0}};
        ram_row_wr_en_a[44][1-1:0]    =  wr_ram_row_sel_a[44] ? {{1{wr_en_a_full[0]}}} : 1'd0;
    end
    always_comb begin
        ram_row_wr_en_b[44] = {1{1'b0}};
        ram_row_wr_en_b[44][1-1:0]    =  wr_ram_row_sel_b[44] ? {{1{wr_en_b_full[0]}}} : 1'd0;
    end
    always_comb begin
        ram_row_wr_en_a[45] = {1{1'b0}};
        ram_row_wr_en_a[45][1-1:0]    =  wr_ram_row_sel_a[45] ? {{1{wr_en_a_full[0]}}} : 1'd0;
    end
    always_comb begin
        ram_row_wr_en_b[45] = {1{1'b0}};
        ram_row_wr_en_b[45][1-1:0]    =  wr_ram_row_sel_b[45] ? {{1{wr_en_b_full[0]}}} : 1'd0;
    end
    always_comb begin
        ram_row_wr_en_a[46] = {1{1'b0}};
        ram_row_wr_en_a[46][1-1:0]    =  wr_ram_row_sel_a[46] ? {{1{wr_en_a_full[0]}}} : 1'd0;
    end
    always_comb begin
        ram_row_wr_en_b[46] = {1{1'b0}};
        ram_row_wr_en_b[46][1-1:0]    =  wr_ram_row_sel_b[46] ? {{1{wr_en_b_full[0]}}} : 1'd0;
    end
    always_comb begin
        ram_row_wr_en_a[47] = {1{1'b0}};
        ram_row_wr_en_a[47][1-1:0]    =  wr_ram_row_sel_a[47] ? {{1{wr_en_a_full[0]}}} : 1'd0;
    end
    always_comb begin
        ram_row_wr_en_b[47] = {1{1'b0}};
        ram_row_wr_en_b[47][1-1:0]    =  wr_ram_row_sel_b[47] ? {{1{wr_en_b_full[0]}}} : 1'd0;
    end
    always_comb begin
        ram_row_wr_en_a[48] = {1{1'b0}};
        ram_row_wr_en_a[48][1-1:0]    =  wr_ram_row_sel_a[48] ? {{1{wr_en_a_full[0]}}} : 1'd0;
    end
    always_comb begin
        ram_row_wr_en_b[48] = {1{1'b0}};
        ram_row_wr_en_b[48][1-1:0]    =  wr_ram_row_sel_b[48] ? {{1{wr_en_b_full[0]}}} : 1'd0;
    end
    always_comb begin
        ram_row_wr_en_a[49] = {1{1'b0}};
        ram_row_wr_en_a[49][1-1:0]    =  wr_ram_row_sel_a[49] ? {{1{wr_en_a_full[0]}}} : 1'd0;
    end
    always_comb begin
        ram_row_wr_en_b[49] = {1{1'b0}};
        ram_row_wr_en_b[49][1-1:0]    =  wr_ram_row_sel_b[49] ? {{1{wr_en_b_full[0]}}} : 1'd0;
    end
    always_comb begin
        ram_row_wr_en_a[50] = {1{1'b0}};
        ram_row_wr_en_a[50][1-1:0]    =  wr_ram_row_sel_a[50] ? {{1{wr_en_a_full[0]}}} : 1'd0;
    end
    always_comb begin
        ram_row_wr_en_b[50] = {1{1'b0}};
        ram_row_wr_en_b[50][1-1:0]    =  wr_ram_row_sel_b[50] ? {{1{wr_en_b_full[0]}}} : 1'd0;
    end
    always_comb begin
        ram_row_wr_en_a[51] = {1{1'b0}};
        ram_row_wr_en_a[51][1-1:0]    =  wr_ram_row_sel_a[51] ? {{1{wr_en_a_full[0]}}} : 1'd0;
    end
    always_comb begin
        ram_row_wr_en_b[51] = {1{1'b0}};
        ram_row_wr_en_b[51][1-1:0]    =  wr_ram_row_sel_b[51] ? {{1{wr_en_b_full[0]}}} : 1'd0;
    end
    always_comb begin
        ram_row_wr_en_a[52] = {1{1'b0}};
        ram_row_wr_en_a[52][1-1:0]    =  wr_ram_row_sel_a[52] ? {{1{wr_en_a_full[0]}}} : 1'd0;
    end
    always_comb begin
        ram_row_wr_en_b[52] = {1{1'b0}};
        ram_row_wr_en_b[52][1-1:0]    =  wr_ram_row_sel_b[52] ? {{1{wr_en_b_full[0]}}} : 1'd0;
    end
    always_comb begin
        ram_row_wr_en_a[53] = {1{1'b0}};
        ram_row_wr_en_a[53][1-1:0]    =  wr_ram_row_sel_a[53] ? {{1{wr_en_a_full[0]}}} : 1'd0;
    end
    always_comb begin
        ram_row_wr_en_b[53] = {1{1'b0}};
        ram_row_wr_en_b[53][1-1:0]    =  wr_ram_row_sel_b[53] ? {{1{wr_en_b_full[0]}}} : 1'd0;
    end
    always_comb begin
        ram_row_wr_en_a[54] = {1{1'b0}};
        ram_row_wr_en_a[54][1-1:0]    =  wr_ram_row_sel_a[54] ? {{1{wr_en_a_full[0]}}} : 1'd0;
    end
    always_comb begin
        ram_row_wr_en_b[54] = {1{1'b0}};
        ram_row_wr_en_b[54][1-1:0]    =  wr_ram_row_sel_b[54] ? {{1{wr_en_b_full[0]}}} : 1'd0;
    end
    always_comb begin
        ram_row_wr_en_a[55] = {1{1'b0}};
        ram_row_wr_en_a[55][1-1:0]    =  wr_ram_row_sel_a[55] ? {{1{wr_en_a_full[0]}}} : 1'd0;
    end
    always_comb begin
        ram_row_wr_en_b[55] = {1{1'b0}};
        ram_row_wr_en_b[55][1-1:0]    =  wr_ram_row_sel_b[55] ? {{1{wr_en_b_full[0]}}} : 1'd0;
    end
    always_comb begin
        ram_row_wr_en_a[56] = {1{1'b0}};
        ram_row_wr_en_a[56][1-1:0]    =  wr_ram_row_sel_a[56] ? {{1{wr_en_a_full[0]}}} : 1'd0;
    end
    always_comb begin
        ram_row_wr_en_b[56] = {1{1'b0}};
        ram_row_wr_en_b[56][1-1:0]    =  wr_ram_row_sel_b[56] ? {{1{wr_en_b_full[0]}}} : 1'd0;
    end
    always_comb begin
        ram_row_wr_en_a[57] = {1{1'b0}};
        ram_row_wr_en_a[57][1-1:0]    =  wr_ram_row_sel_a[57] ? {{1{wr_en_a_full[0]}}} : 1'd0;
    end
    always_comb begin
        ram_row_wr_en_b[57] = {1{1'b0}};
        ram_row_wr_en_b[57][1-1:0]    =  wr_ram_row_sel_b[57] ? {{1{wr_en_b_full[0]}}} : 1'd0;
    end
    always_comb begin
        ram_row_wr_en_a[58] = {1{1'b0}};
        ram_row_wr_en_a[58][1-1:0]    =  wr_ram_row_sel_a[58] ? {{1{wr_en_a_full[0]}}} : 1'd0;
    end
    always_comb begin
        ram_row_wr_en_b[58] = {1{1'b0}};
        ram_row_wr_en_b[58][1-1:0]    =  wr_ram_row_sel_b[58] ? {{1{wr_en_b_full[0]}}} : 1'd0;
    end
    always_comb begin
        ram_row_wr_en_a[59] = {1{1'b0}};
        ram_row_wr_en_a[59][1-1:0]    =  wr_ram_row_sel_a[59] ? {{1{wr_en_a_full[0]}}} : 1'd0;
    end
    always_comb begin
        ram_row_wr_en_b[59] = {1{1'b0}};
        ram_row_wr_en_b[59][1-1:0]    =  wr_ram_row_sel_b[59] ? {{1{wr_en_b_full[0]}}} : 1'd0;
    end
    always_comb begin
        ram_row_wr_en_a[60] = {1{1'b0}};
        ram_row_wr_en_a[60][1-1:0]    =  wr_ram_row_sel_a[60] ? {{1{wr_en_a_full[0]}}} : 1'd0;
    end
    always_comb begin
        ram_row_wr_en_b[60] = {1{1'b0}};
        ram_row_wr_en_b[60][1-1:0]    =  wr_ram_row_sel_b[60] ? {{1{wr_en_b_full[0]}}} : 1'd0;
    end
    always_comb begin
        ram_row_wr_en_a[61] = {1{1'b0}};
        ram_row_wr_en_a[61][1-1:0]    =  wr_ram_row_sel_a[61] ? {{1{wr_en_a_full[0]}}} : 1'd0;
    end
    always_comb begin
        ram_row_wr_en_b[61] = {1{1'b0}};
        ram_row_wr_en_b[61][1-1:0]    =  wr_ram_row_sel_b[61] ? {{1{wr_en_b_full[0]}}} : 1'd0;
    end
    always_comb begin
        ram_row_wr_en_a[62] = {1{1'b0}};
        ram_row_wr_en_a[62][1-1:0]    =  wr_ram_row_sel_a[62] ? {{1{wr_en_a_full[0]}}} : 1'd0;
    end
    always_comb begin
        ram_row_wr_en_b[62] = {1{1'b0}};
        ram_row_wr_en_b[62][1-1:0]    =  wr_ram_row_sel_b[62] ? {{1{wr_en_b_full[0]}}} : 1'd0;
    end
    always_comb begin
        ram_row_wr_en_a[63] = {1{1'b0}};
        ram_row_wr_en_a[63][1-1:0]    =  wr_ram_row_sel_a[63] ? {{1{wr_en_a_full[0]}}} : 1'd0;
    end
    always_comb begin
        ram_row_wr_en_b[63] = {1{1'b0}};
        ram_row_wr_en_b[63][1-1:0]    =  wr_ram_row_sel_b[63] ? {{1{wr_en_b_full[0]}}} : 1'd0;
    end
    logic    [1-1:0]        ram_col_wr_en_a[64-1:0][1-1:0];
    assign        ram_col_wr_en_a[0][0]    = ram_row_wr_en_a[0][0*(1)+:1];
    assign        ram_col_wr_en_a[1][0]    = ram_row_wr_en_a[1][0*(1)+:1];
    assign        ram_col_wr_en_a[2][0]    = ram_row_wr_en_a[2][0*(1)+:1];
    assign        ram_col_wr_en_a[3][0]    = ram_row_wr_en_a[3][0*(1)+:1];
    assign        ram_col_wr_en_a[4][0]    = ram_row_wr_en_a[4][0*(1)+:1];
    assign        ram_col_wr_en_a[5][0]    = ram_row_wr_en_a[5][0*(1)+:1];
    assign        ram_col_wr_en_a[6][0]    = ram_row_wr_en_a[6][0*(1)+:1];
    assign        ram_col_wr_en_a[7][0]    = ram_row_wr_en_a[7][0*(1)+:1];
    assign        ram_col_wr_en_a[8][0]    = ram_row_wr_en_a[8][0*(1)+:1];
    assign        ram_col_wr_en_a[9][0]    = ram_row_wr_en_a[9][0*(1)+:1];
    assign        ram_col_wr_en_a[10][0]    = ram_row_wr_en_a[10][0*(1)+:1];
    assign        ram_col_wr_en_a[11][0]    = ram_row_wr_en_a[11][0*(1)+:1];
    assign        ram_col_wr_en_a[12][0]    = ram_row_wr_en_a[12][0*(1)+:1];
    assign        ram_col_wr_en_a[13][0]    = ram_row_wr_en_a[13][0*(1)+:1];
    assign        ram_col_wr_en_a[14][0]    = ram_row_wr_en_a[14][0*(1)+:1];
    assign        ram_col_wr_en_a[15][0]    = ram_row_wr_en_a[15][0*(1)+:1];
    assign        ram_col_wr_en_a[16][0]    = ram_row_wr_en_a[16][0*(1)+:1];
    assign        ram_col_wr_en_a[17][0]    = ram_row_wr_en_a[17][0*(1)+:1];
    assign        ram_col_wr_en_a[18][0]    = ram_row_wr_en_a[18][0*(1)+:1];
    assign        ram_col_wr_en_a[19][0]    = ram_row_wr_en_a[19][0*(1)+:1];
    assign        ram_col_wr_en_a[20][0]    = ram_row_wr_en_a[20][0*(1)+:1];
    assign        ram_col_wr_en_a[21][0]    = ram_row_wr_en_a[21][0*(1)+:1];
    assign        ram_col_wr_en_a[22][0]    = ram_row_wr_en_a[22][0*(1)+:1];
    assign        ram_col_wr_en_a[23][0]    = ram_row_wr_en_a[23][0*(1)+:1];
    assign        ram_col_wr_en_a[24][0]    = ram_row_wr_en_a[24][0*(1)+:1];
    assign        ram_col_wr_en_a[25][0]    = ram_row_wr_en_a[25][0*(1)+:1];
    assign        ram_col_wr_en_a[26][0]    = ram_row_wr_en_a[26][0*(1)+:1];
    assign        ram_col_wr_en_a[27][0]    = ram_row_wr_en_a[27][0*(1)+:1];
    assign        ram_col_wr_en_a[28][0]    = ram_row_wr_en_a[28][0*(1)+:1];
    assign        ram_col_wr_en_a[29][0]    = ram_row_wr_en_a[29][0*(1)+:1];
    assign        ram_col_wr_en_a[30][0]    = ram_row_wr_en_a[30][0*(1)+:1];
    assign        ram_col_wr_en_a[31][0]    = ram_row_wr_en_a[31][0*(1)+:1];
    assign        ram_col_wr_en_a[32][0]    = ram_row_wr_en_a[32][0*(1)+:1];
    assign        ram_col_wr_en_a[33][0]    = ram_row_wr_en_a[33][0*(1)+:1];
    assign        ram_col_wr_en_a[34][0]    = ram_row_wr_en_a[34][0*(1)+:1];
    assign        ram_col_wr_en_a[35][0]    = ram_row_wr_en_a[35][0*(1)+:1];
    assign        ram_col_wr_en_a[36][0]    = ram_row_wr_en_a[36][0*(1)+:1];
    assign        ram_col_wr_en_a[37][0]    = ram_row_wr_en_a[37][0*(1)+:1];
    assign        ram_col_wr_en_a[38][0]    = ram_row_wr_en_a[38][0*(1)+:1];
    assign        ram_col_wr_en_a[39][0]    = ram_row_wr_en_a[39][0*(1)+:1];
    assign        ram_col_wr_en_a[40][0]    = ram_row_wr_en_a[40][0*(1)+:1];
    assign        ram_col_wr_en_a[41][0]    = ram_row_wr_en_a[41][0*(1)+:1];
    assign        ram_col_wr_en_a[42][0]    = ram_row_wr_en_a[42][0*(1)+:1];
    assign        ram_col_wr_en_a[43][0]    = ram_row_wr_en_a[43][0*(1)+:1];
    assign        ram_col_wr_en_a[44][0]    = ram_row_wr_en_a[44][0*(1)+:1];
    assign        ram_col_wr_en_a[45][0]    = ram_row_wr_en_a[45][0*(1)+:1];
    assign        ram_col_wr_en_a[46][0]    = ram_row_wr_en_a[46][0*(1)+:1];
    assign        ram_col_wr_en_a[47][0]    = ram_row_wr_en_a[47][0*(1)+:1];
    assign        ram_col_wr_en_a[48][0]    = ram_row_wr_en_a[48][0*(1)+:1];
    assign        ram_col_wr_en_a[49][0]    = ram_row_wr_en_a[49][0*(1)+:1];
    assign        ram_col_wr_en_a[50][0]    = ram_row_wr_en_a[50][0*(1)+:1];
    assign        ram_col_wr_en_a[51][0]    = ram_row_wr_en_a[51][0*(1)+:1];
    assign        ram_col_wr_en_a[52][0]    = ram_row_wr_en_a[52][0*(1)+:1];
    assign        ram_col_wr_en_a[53][0]    = ram_row_wr_en_a[53][0*(1)+:1];
    assign        ram_col_wr_en_a[54][0]    = ram_row_wr_en_a[54][0*(1)+:1];
    assign        ram_col_wr_en_a[55][0]    = ram_row_wr_en_a[55][0*(1)+:1];
    assign        ram_col_wr_en_a[56][0]    = ram_row_wr_en_a[56][0*(1)+:1];
    assign        ram_col_wr_en_a[57][0]    = ram_row_wr_en_a[57][0*(1)+:1];
    assign        ram_col_wr_en_a[58][0]    = ram_row_wr_en_a[58][0*(1)+:1];
    assign        ram_col_wr_en_a[59][0]    = ram_row_wr_en_a[59][0*(1)+:1];
    assign        ram_col_wr_en_a[60][0]    = ram_row_wr_en_a[60][0*(1)+:1];
    assign        ram_col_wr_en_a[61][0]    = ram_row_wr_en_a[61][0*(1)+:1];
    assign        ram_col_wr_en_a[62][0]    = ram_row_wr_en_a[62][0*(1)+:1];
    assign        ram_col_wr_en_a[63][0]    = ram_row_wr_en_a[63][0*(1)+:1];
    logic    [1-1:0]        ram_col_wr_en_b[64-1:0][1-1:0];
    assign        ram_col_wr_en_b[0][0]    = ram_row_wr_en_b[0][0*(1)+:1];
    assign        ram_col_wr_en_b[1][0]    = ram_row_wr_en_b[1][0*(1)+:1];
    assign        ram_col_wr_en_b[2][0]    = ram_row_wr_en_b[2][0*(1)+:1];
    assign        ram_col_wr_en_b[3][0]    = ram_row_wr_en_b[3][0*(1)+:1];
    assign        ram_col_wr_en_b[4][0]    = ram_row_wr_en_b[4][0*(1)+:1];
    assign        ram_col_wr_en_b[5][0]    = ram_row_wr_en_b[5][0*(1)+:1];
    assign        ram_col_wr_en_b[6][0]    = ram_row_wr_en_b[6][0*(1)+:1];
    assign        ram_col_wr_en_b[7][0]    = ram_row_wr_en_b[7][0*(1)+:1];
    assign        ram_col_wr_en_b[8][0]    = ram_row_wr_en_b[8][0*(1)+:1];
    assign        ram_col_wr_en_b[9][0]    = ram_row_wr_en_b[9][0*(1)+:1];
    assign        ram_col_wr_en_b[10][0]    = ram_row_wr_en_b[10][0*(1)+:1];
    assign        ram_col_wr_en_b[11][0]    = ram_row_wr_en_b[11][0*(1)+:1];
    assign        ram_col_wr_en_b[12][0]    = ram_row_wr_en_b[12][0*(1)+:1];
    assign        ram_col_wr_en_b[13][0]    = ram_row_wr_en_b[13][0*(1)+:1];
    assign        ram_col_wr_en_b[14][0]    = ram_row_wr_en_b[14][0*(1)+:1];
    assign        ram_col_wr_en_b[15][0]    = ram_row_wr_en_b[15][0*(1)+:1];
    assign        ram_col_wr_en_b[16][0]    = ram_row_wr_en_b[16][0*(1)+:1];
    assign        ram_col_wr_en_b[17][0]    = ram_row_wr_en_b[17][0*(1)+:1];
    assign        ram_col_wr_en_b[18][0]    = ram_row_wr_en_b[18][0*(1)+:1];
    assign        ram_col_wr_en_b[19][0]    = ram_row_wr_en_b[19][0*(1)+:1];
    assign        ram_col_wr_en_b[20][0]    = ram_row_wr_en_b[20][0*(1)+:1];
    assign        ram_col_wr_en_b[21][0]    = ram_row_wr_en_b[21][0*(1)+:1];
    assign        ram_col_wr_en_b[22][0]    = ram_row_wr_en_b[22][0*(1)+:1];
    assign        ram_col_wr_en_b[23][0]    = ram_row_wr_en_b[23][0*(1)+:1];
    assign        ram_col_wr_en_b[24][0]    = ram_row_wr_en_b[24][0*(1)+:1];
    assign        ram_col_wr_en_b[25][0]    = ram_row_wr_en_b[25][0*(1)+:1];
    assign        ram_col_wr_en_b[26][0]    = ram_row_wr_en_b[26][0*(1)+:1];
    assign        ram_col_wr_en_b[27][0]    = ram_row_wr_en_b[27][0*(1)+:1];
    assign        ram_col_wr_en_b[28][0]    = ram_row_wr_en_b[28][0*(1)+:1];
    assign        ram_col_wr_en_b[29][0]    = ram_row_wr_en_b[29][0*(1)+:1];
    assign        ram_col_wr_en_b[30][0]    = ram_row_wr_en_b[30][0*(1)+:1];
    assign        ram_col_wr_en_b[31][0]    = ram_row_wr_en_b[31][0*(1)+:1];
    assign        ram_col_wr_en_b[32][0]    = ram_row_wr_en_b[32][0*(1)+:1];
    assign        ram_col_wr_en_b[33][0]    = ram_row_wr_en_b[33][0*(1)+:1];
    assign        ram_col_wr_en_b[34][0]    = ram_row_wr_en_b[34][0*(1)+:1];
    assign        ram_col_wr_en_b[35][0]    = ram_row_wr_en_b[35][0*(1)+:1];
    assign        ram_col_wr_en_b[36][0]    = ram_row_wr_en_b[36][0*(1)+:1];
    assign        ram_col_wr_en_b[37][0]    = ram_row_wr_en_b[37][0*(1)+:1];
    assign        ram_col_wr_en_b[38][0]    = ram_row_wr_en_b[38][0*(1)+:1];
    assign        ram_col_wr_en_b[39][0]    = ram_row_wr_en_b[39][0*(1)+:1];
    assign        ram_col_wr_en_b[40][0]    = ram_row_wr_en_b[40][0*(1)+:1];
    assign        ram_col_wr_en_b[41][0]    = ram_row_wr_en_b[41][0*(1)+:1];
    assign        ram_col_wr_en_b[42][0]    = ram_row_wr_en_b[42][0*(1)+:1];
    assign        ram_col_wr_en_b[43][0]    = ram_row_wr_en_b[43][0*(1)+:1];
    assign        ram_col_wr_en_b[44][0]    = ram_row_wr_en_b[44][0*(1)+:1];
    assign        ram_col_wr_en_b[45][0]    = ram_row_wr_en_b[45][0*(1)+:1];
    assign        ram_col_wr_en_b[46][0]    = ram_row_wr_en_b[46][0*(1)+:1];
    assign        ram_col_wr_en_b[47][0]    = ram_row_wr_en_b[47][0*(1)+:1];
    assign        ram_col_wr_en_b[48][0]    = ram_row_wr_en_b[48][0*(1)+:1];
    assign        ram_col_wr_en_b[49][0]    = ram_row_wr_en_b[49][0*(1)+:1];
    assign        ram_col_wr_en_b[50][0]    = ram_row_wr_en_b[50][0*(1)+:1];
    assign        ram_col_wr_en_b[51][0]    = ram_row_wr_en_b[51][0*(1)+:1];
    assign        ram_col_wr_en_b[52][0]    = ram_row_wr_en_b[52][0*(1)+:1];
    assign        ram_col_wr_en_b[53][0]    = ram_row_wr_en_b[53][0*(1)+:1];
    assign        ram_col_wr_en_b[54][0]    = ram_row_wr_en_b[54][0*(1)+:1];
    assign        ram_col_wr_en_b[55][0]    = ram_row_wr_en_b[55][0*(1)+:1];
    assign        ram_col_wr_en_b[56][0]    = ram_row_wr_en_b[56][0*(1)+:1];
    assign        ram_col_wr_en_b[57][0]    = ram_row_wr_en_b[57][0*(1)+:1];
    assign        ram_col_wr_en_b[58][0]    = ram_row_wr_en_b[58][0*(1)+:1];
    assign        ram_col_wr_en_b[59][0]    = ram_row_wr_en_b[59][0*(1)+:1];
    assign        ram_col_wr_en_b[60][0]    = ram_row_wr_en_b[60][0*(1)+:1];
    assign        ram_col_wr_en_b[61][0]    = ram_row_wr_en_b[61][0*(1)+:1];
    assign        ram_col_wr_en_b[62][0]    = ram_row_wr_en_b[62][0*(1)+:1];
    assign        ram_col_wr_en_b[63][0]    = ram_row_wr_en_b[63][0*(1)+:1];


    // Read Data

    logic    [34-1:0]    ram_rd_data_a_col[64-1:0][1-1:0];
    logic    [34-1:0]    ram_rd_data_b_col[64-1:0][1-1:0];
    logic    [34-1:0]    ram_rd_data_a_row;
    logic    [34-1:0]    ram_rd_data_b_row;
    always_comb begin
        for (int i = 0; i < 1; i = i + 1) begin
            ram_rd_data_a_row[i*(34)+:34]        = ram_rd_data_a_col[ram_row_num_rd_en_a_delay[6-1:0]][i][34-1:0];
        end
    end
    always_comb begin
        for (int i = 0; i < 1; i = i + 1) begin
            ram_rd_data_b_row[i*(34)+:34]        = ram_rd_data_b_col[ram_row_num_rd_en_b_delay[6-1:0]][i][34-1:0];
        end
    end
    logic    [1*MEM_WIDTH-1:0]    ram_rd_data_a_full;
    logic    [1*MEM_WIDTH-1:0]    ram_rd_data_b_full;
    always_comb begin
        for (int i = 0; i < (MEM_WIDTH / MEM_WR_RESOLUTION); i = i + 1) begin
            ram_rd_data_a_full[i*MEM_WR_RESOLUTION+:MEM_WR_RESOLUTION]        = ram_rd_data_a_row[i*(MEM_WR_RESOLUTION+0)+:MEM_WR_RESOLUTION];
        end
    end
    always_comb begin
        for (int i = 0; i < (MEM_WIDTH / MEM_WR_RESOLUTION); i = i + 1) begin
            ram_rd_data_b_full[i*MEM_WR_RESOLUTION+:MEM_WR_RESOLUTION]        = ram_rd_data_b_row[i*(MEM_WR_RESOLUTION+0)+:MEM_WR_RESOLUTION];
        end
    end
    logic    [MEM_WIDTH-1:0]    rd_data_a_int;
    always_comb begin
        rd_data_a_int[MEM_WIDTH-1:0]    =    ram_rd_data_a_full[MEM_WIDTH-1:0];
    end
    logic    [MEM_WIDTH-1:0]    rd_data_b_int;
    always_comb begin
        rd_data_b_int[MEM_WIDTH-1:0]    =    ram_rd_data_b_full[MEM_WIDTH-1:0];
    end
    assign        rd_data_a    = rd_data_a_int;
    assign        rd_valid_a    = |rd_en_a_delay[MEM_DELAY];
    assign        rd_data_b    = rd_data_b_int;
    assign        rd_valid_b    = |rd_en_b_delay[MEM_DELAY];


    // EBBs Instantiation

        wire                            ram_row_0_col_0_clk_a       = clk_a;
        wire                            ram_row_0_col_0_clk_b       = clk_b;
        wire    [8-1:0]       ram_row_0_col_0_wr_adr_a    = ram_row_wr_adr_a[0][8-1:0];
        wire    [8-1:0]       ram_row_0_col_0_wr_adr_b    = ram_row_wr_adr_b[0][8-1:0];
        wire    [8-1:0]       ram_row_0_col_0_rd_adr_a    = ram_row_rd_adr_a[0][8-1:0];
        wire    [8-1:0]       ram_row_0_col_0_rd_adr_b    = ram_row_rd_adr_b[0][8-1:0];
        wire                            ram_row_0_col_0_rd_en_a     = ram_row_rd_en_a[0];
        wire                            ram_row_0_col_0_rd_en_b     = ram_row_rd_en_b[0];
        wire                            ram_row_0_col_0_wr_en_a     = |ram_col_wr_en_a[0][0];
        wire                            ram_row_0_col_0_wr_en_b     = |ram_col_wr_en_b[0][0];
        wire    [34-1:0]              ram_row_0_col_0_data_in_a   = ram_wr_data_a_col[0][34-1:0];
        wire    [34-1:0]              ram_row_0_col_0_data_in_b   = ram_wr_data_b_col[0][34-1:0];
        wire    [34-1:0]              ram_row_0_col_0_data_out_a;
        wire    [34-1:0]              ram_row_0_col_0_data_out_b;
        wire    [2:0]                   ram_row_0_col_0_aary_pwren_b;
        wire                            ram_row_0_col_0_vcc = 1'b1;
        
        
        ip783rfhs2r2w256x34s0c1p1d0_dft_wrp #(
                    )
        ram_row_0_col_0 (
                    //------------------------------------------------------------
                    // Functional Interfaces
                    //------------------------------------------------------------      
        
                     .CLKWR_P0                (ram_row_0_col_0_clk_a),
                     .ADRWR_P0                (ADRWR_P0),
                     .WREN_P0                 (WREN_P0),
                     .DIN_P0                  (DIN_P0),
        
                     .CLKWR_P1                (ram_row_0_col_0_clk_b),
                     .ADRWR_P1                (ADRWR_P1),
                     .WREN_P1                 (WREN_P1),
                     .DIN_P1                  (DIN_P1),
        
                     .CLKRD_P0                (ram_row_0_col_0_clk_a),
                     .ADRRD_P0                (ADRRD_P0),
                     .RDEN_P0                 (RDEN_P0),
                     .QOUT_P0                 (ram_row_0_col_0_data_out_a),
                         
                     .CLKRD_P1                (ram_row_0_col_0_clk_b),
                     .ADRRD_P1                (ADRRD_P1),
                     .RDEN_P1                 (RDEN_P1),
                     .QOUT_P1                 (ram_row_0_col_0_data_out_b),                
                                                     
                    
                   //-------------------------------------------------------------
                   // Power Management Interfaces
                   //-------------------------------------------------------------
                  //   .PWR_MGMT_IN                        ({pwr_mgmt_in_rf[PWR_MGMT_IN_SIZE-1:1],ram_fary_pwren_b[0]}), // MSB changed from 3'b100
                  //   .PWR_MGMT_OUT                       (ram_aary_pwren_b[0]),  
                
                       
                     `ifndef INTEL_NO_PWR_PINS
                        .vddp                            (ram_row_0_col_0_vcc),
                        `ifdef INTC_ADD_VSS
                        .vss                            (1'b0),
                        `endif  
                     `endif
               
        
        
        
                      //REPAIR INPUTS
        
                    .FCA           (ram_row_0_col_0_bisr_inst_Q[6:1]), // column repair addres --- > F means faulty
                    .CRE          (ram_row_0_col_0_bisr_inst_Q[0]), //Column repair enable
                    
        
                    // POWER MGMT inputs
                    //.ROP_SD             (), // shutoffout
                    //.ROP_DS             (), //dpslp_or_shutoffout
                    //TEMPCOMMENT1.MPMS              (1'b0), // {shutoff,deepsleep,fastsleep}
        
                    //TIMING and TRIM
                    // MDST = {async_reset0,async_reset1,wmce,mce,stbyp,rmce}
                    .MDST_hs2r2w       ({fary_ffuse_rfhs2r2w_trim[9],fary_ffuse_rfhs2r2w_trim[8],fary_ffuse_rfhs2r2w_trim[7:5],fary_ffuse_rfhs2r2w_trim[4],fary_ffuse_rfhs2r2w_trim[3],fary_ffuse_rfhs2r2w_trim[2:0]}),
                                        
        
                    //DFT inputs
                    .DFTSHIFTEN        (DFTSHIFTEN),
                    .DFTMASK           (DFTMASK),
                    .DFT_ARRAY_FREEZE    (DFT_ARRAY_FREEZE),
                    
                    .DFT_AFD_RESET_B    (DFT_AFD_RESET_B)
        
        
        
        );//ip783rfhs2r2w256x34s0c1p1d0_dft_wrp
        
        assign          ram_rd_data_a_col[0][0]    = ram_row_0_col_0_data_out_a;
        assign          ram_rd_data_b_col[0][0]    = ram_row_0_col_0_data_out_b;
        
             

        wire                            ram_row_1_col_0_clk_a       = clk_a;
        wire                            ram_row_1_col_0_clk_b       = clk_b;
        wire    [8-1:0]       ram_row_1_col_0_wr_adr_a    = ram_row_wr_adr_a[1][8-1:0];
        wire    [8-1:0]       ram_row_1_col_0_wr_adr_b    = ram_row_wr_adr_b[1][8-1:0];
        wire    [8-1:0]       ram_row_1_col_0_rd_adr_a    = ram_row_rd_adr_a[1][8-1:0];
        wire    [8-1:0]       ram_row_1_col_0_rd_adr_b    = ram_row_rd_adr_b[1][8-1:0];
        wire                            ram_row_1_col_0_rd_en_a     = ram_row_rd_en_a[1];
        wire                            ram_row_1_col_0_rd_en_b     = ram_row_rd_en_b[1];
        wire                            ram_row_1_col_0_wr_en_a     = |ram_col_wr_en_a[1][0];
        wire                            ram_row_1_col_0_wr_en_b     = |ram_col_wr_en_b[1][0];
        wire    [34-1:0]              ram_row_1_col_0_data_in_a   = ram_wr_data_a_col[0][34-1:0];
        wire    [34-1:0]              ram_row_1_col_0_data_in_b   = ram_wr_data_b_col[0][34-1:0];
        wire    [34-1:0]              ram_row_1_col_0_data_out_a;
        wire    [34-1:0]              ram_row_1_col_0_data_out_b;
        wire    [2:0]                   ram_row_1_col_0_aary_pwren_b;
        wire                            ram_row_1_col_0_vcc = 1'b1;
        
        
        ip783rfhs2r2w256x34s0c1p1d0_dft_wrp #(
                    )
        ram_row_1_col_0 (
                    //------------------------------------------------------------
                    // Functional Interfaces
                    //------------------------------------------------------------      
        
                     .CLKWR_P0                (ram_row_1_col_0_clk_a),
                     .ADRWR_P0                (ADRWR_P0_ts11),
                     .WREN_P0                 (WREN_P0_ts11),
                     .DIN_P0                  (DIN_P0_ts11),
        
                     .CLKWR_P1                (ram_row_1_col_0_clk_b),
                     .ADRWR_P1                (ADRWR_P1_ts11),
                     .WREN_P1                 (WREN_P1_ts11),
                     .DIN_P1                  (DIN_P1_ts11),
        
                     .CLKRD_P0                (ram_row_1_col_0_clk_a),
                     .ADRRD_P0                (ADRRD_P0_ts11),
                     .RDEN_P0                 (RDEN_P0_ts11),
                     .QOUT_P0                 (ram_row_1_col_0_data_out_a),
                         
                     .CLKRD_P1                (ram_row_1_col_0_clk_b),
                     .ADRRD_P1                (ADRRD_P1_ts11),
                     .RDEN_P1                 (RDEN_P1_ts11),
                     .QOUT_P1                 (ram_row_1_col_0_data_out_b),                
                                                     
                    
                   //-------------------------------------------------------------
                   // Power Management Interfaces
                   //-------------------------------------------------------------
                  //   .PWR_MGMT_IN                        ({pwr_mgmt_in_rf[PWR_MGMT_IN_SIZE-1:1],ram_fary_pwren_b[1]}), // MSB changed from 3'b100
                  //   .PWR_MGMT_OUT                       (ram_aary_pwren_b[1]),  
                
                       
                     `ifndef INTEL_NO_PWR_PINS
                        .vddp                            (ram_row_1_col_0_vcc),
                        `ifdef INTC_ADD_VSS
                        .vss                            (1'b0),
                        `endif  
                     `endif
               
        
        
        
                      //REPAIR INPUTS
        
                    .FCA           (ram_row_1_col_0_bisr_inst_Q[6:1]), // column repair addres --- > F means faulty
                    .CRE          (ram_row_1_col_0_bisr_inst_Q[0]), //Column repair enable
                    
        
                    // POWER MGMT inputs
                    //.ROP_SD             (), // shutoffout
                    //.ROP_DS             (), //dpslp_or_shutoffout
                    //TEMPCOMMENT1.MPMS              (1'b0), // {shutoff,deepsleep,fastsleep}
        
                    //TIMING and TRIM
                    // MDST = {async_reset0,async_reset1,wmce,mce,stbyp,rmce}
                    .MDST_hs2r2w       ({fary_ffuse_rfhs2r2w_trim[9],fary_ffuse_rfhs2r2w_trim[8],fary_ffuse_rfhs2r2w_trim[7:5],fary_ffuse_rfhs2r2w_trim[4],fary_ffuse_rfhs2r2w_trim[3],fary_ffuse_rfhs2r2w_trim[2:0]}),
                                        
        
                    //DFT inputs
                    .DFTSHIFTEN        (DFTSHIFTEN),
                    .DFTMASK           (DFTMASK),
                    .DFT_ARRAY_FREEZE    (DFT_ARRAY_FREEZE),
                    
                    .DFT_AFD_RESET_B    (DFT_AFD_RESET_B)
        
        
        
        );//ip783rfhs2r2w256x34s0c1p1d0_dft_wrp
        
        assign          ram_rd_data_a_col[1][0]    = ram_row_1_col_0_data_out_a;
        assign          ram_rd_data_b_col[1][0]    = ram_row_1_col_0_data_out_b;
        
             

        wire                            ram_row_2_col_0_clk_a       = clk_a;
        wire                            ram_row_2_col_0_clk_b       = clk_b;
        wire    [8-1:0]       ram_row_2_col_0_wr_adr_a    = ram_row_wr_adr_a[2][8-1:0];
        wire    [8-1:0]       ram_row_2_col_0_wr_adr_b    = ram_row_wr_adr_b[2][8-1:0];
        wire    [8-1:0]       ram_row_2_col_0_rd_adr_a    = ram_row_rd_adr_a[2][8-1:0];
        wire    [8-1:0]       ram_row_2_col_0_rd_adr_b    = ram_row_rd_adr_b[2][8-1:0];
        wire                            ram_row_2_col_0_rd_en_a     = ram_row_rd_en_a[2];
        wire                            ram_row_2_col_0_rd_en_b     = ram_row_rd_en_b[2];
        wire                            ram_row_2_col_0_wr_en_a     = |ram_col_wr_en_a[2][0];
        wire                            ram_row_2_col_0_wr_en_b     = |ram_col_wr_en_b[2][0];
        wire    [34-1:0]              ram_row_2_col_0_data_in_a   = ram_wr_data_a_col[0][34-1:0];
        wire    [34-1:0]              ram_row_2_col_0_data_in_b   = ram_wr_data_b_col[0][34-1:0];
        wire    [34-1:0]              ram_row_2_col_0_data_out_a;
        wire    [34-1:0]              ram_row_2_col_0_data_out_b;
        wire    [2:0]                   ram_row_2_col_0_aary_pwren_b;
        wire                            ram_row_2_col_0_vcc = 1'b1;
        
        
        ip783rfhs2r2w256x34s0c1p1d0_dft_wrp #(
                    )
        ram_row_2_col_0 (
                    //------------------------------------------------------------
                    // Functional Interfaces
                    //------------------------------------------------------------      
        
                     .CLKWR_P0                (ram_row_2_col_0_clk_a),
                     .ADRWR_P0                (ADRWR_P0_ts22),
                     .WREN_P0                 (WREN_P0_ts22),
                     .DIN_P0                  (DIN_P0_ts22),
        
                     .CLKWR_P1                (ram_row_2_col_0_clk_b),
                     .ADRWR_P1                (ADRWR_P1_ts22),
                     .WREN_P1                 (WREN_P1_ts22),
                     .DIN_P1                  (DIN_P1_ts22),
        
                     .CLKRD_P0                (ram_row_2_col_0_clk_a),
                     .ADRRD_P0                (ADRRD_P0_ts22),
                     .RDEN_P0                 (RDEN_P0_ts22),
                     .QOUT_P0                 (ram_row_2_col_0_data_out_a),
                         
                     .CLKRD_P1                (ram_row_2_col_0_clk_b),
                     .ADRRD_P1                (ADRRD_P1_ts22),
                     .RDEN_P1                 (RDEN_P1_ts22),
                     .QOUT_P1                 (ram_row_2_col_0_data_out_b),                
                                                     
                    
                   //-------------------------------------------------------------
                   // Power Management Interfaces
                   //-------------------------------------------------------------
                  //   .PWR_MGMT_IN                        ({pwr_mgmt_in_rf[PWR_MGMT_IN_SIZE-1:1],ram_fary_pwren_b[2]}), // MSB changed from 3'b100
                  //   .PWR_MGMT_OUT                       (ram_aary_pwren_b[2]),  
                
                       
                     `ifndef INTEL_NO_PWR_PINS
                        .vddp                            (ram_row_2_col_0_vcc),
                        `ifdef INTC_ADD_VSS
                        .vss                            (1'b0),
                        `endif  
                     `endif
               
        
        
        
                      //REPAIR INPUTS
        
                    .FCA           (ram_row_2_col_0_bisr_inst_Q[6:1]), // column repair addres --- > F means faulty
                    .CRE          (ram_row_2_col_0_bisr_inst_Q[0]), //Column repair enable
                    
        
                    // POWER MGMT inputs
                    //.ROP_SD             (), // shutoffout
                    //.ROP_DS             (), //dpslp_or_shutoffout
                    //TEMPCOMMENT1.MPMS              (1'b0), // {shutoff,deepsleep,fastsleep}
        
                    //TIMING and TRIM
                    // MDST = {async_reset0,async_reset1,wmce,mce,stbyp,rmce}
                    .MDST_hs2r2w       ({fary_ffuse_rfhs2r2w_trim[9],fary_ffuse_rfhs2r2w_trim[8],fary_ffuse_rfhs2r2w_trim[7:5],fary_ffuse_rfhs2r2w_trim[4],fary_ffuse_rfhs2r2w_trim[3],fary_ffuse_rfhs2r2w_trim[2:0]}),
                                        
        
                    //DFT inputs
                    .DFTSHIFTEN        (DFTSHIFTEN),
                    .DFTMASK           (DFTMASK),
                    .DFT_ARRAY_FREEZE    (DFT_ARRAY_FREEZE),
                    
                    .DFT_AFD_RESET_B    (DFT_AFD_RESET_B)
        
        
        
        );//ip783rfhs2r2w256x34s0c1p1d0_dft_wrp
        
        assign          ram_rd_data_a_col[2][0]    = ram_row_2_col_0_data_out_a;
        assign          ram_rd_data_b_col[2][0]    = ram_row_2_col_0_data_out_b;
        
             

        wire                            ram_row_3_col_0_clk_a       = clk_a;
        wire                            ram_row_3_col_0_clk_b       = clk_b;
        wire    [8-1:0]       ram_row_3_col_0_wr_adr_a    = ram_row_wr_adr_a[3][8-1:0];
        wire    [8-1:0]       ram_row_3_col_0_wr_adr_b    = ram_row_wr_adr_b[3][8-1:0];
        wire    [8-1:0]       ram_row_3_col_0_rd_adr_a    = ram_row_rd_adr_a[3][8-1:0];
        wire    [8-1:0]       ram_row_3_col_0_rd_adr_b    = ram_row_rd_adr_b[3][8-1:0];
        wire                            ram_row_3_col_0_rd_en_a     = ram_row_rd_en_a[3];
        wire                            ram_row_3_col_0_rd_en_b     = ram_row_rd_en_b[3];
        wire                            ram_row_3_col_0_wr_en_a     = |ram_col_wr_en_a[3][0];
        wire                            ram_row_3_col_0_wr_en_b     = |ram_col_wr_en_b[3][0];
        wire    [34-1:0]              ram_row_3_col_0_data_in_a   = ram_wr_data_a_col[0][34-1:0];
        wire    [34-1:0]              ram_row_3_col_0_data_in_b   = ram_wr_data_b_col[0][34-1:0];
        wire    [34-1:0]              ram_row_3_col_0_data_out_a;
        wire    [34-1:0]              ram_row_3_col_0_data_out_b;
        wire    [2:0]                   ram_row_3_col_0_aary_pwren_b;
        wire                            ram_row_3_col_0_vcc = 1'b1;
        
        
        ip783rfhs2r2w256x34s0c1p1d0_dft_wrp #(
                    )
        ram_row_3_col_0 (
                    //------------------------------------------------------------
                    // Functional Interfaces
                    //------------------------------------------------------------      
        
                     .CLKWR_P0                (ram_row_3_col_0_clk_a),
                     .ADRWR_P0                (ADRWR_P0_ts33),
                     .WREN_P0                 (WREN_P0_ts33),
                     .DIN_P0                  (DIN_P0_ts33),
        
                     .CLKWR_P1                (ram_row_3_col_0_clk_b),
                     .ADRWR_P1                (ADRWR_P1_ts33),
                     .WREN_P1                 (WREN_P1_ts33),
                     .DIN_P1                  (DIN_P1_ts33),
        
                     .CLKRD_P0                (ram_row_3_col_0_clk_a),
                     .ADRRD_P0                (ADRRD_P0_ts33),
                     .RDEN_P0                 (RDEN_P0_ts33),
                     .QOUT_P0                 (ram_row_3_col_0_data_out_a),
                         
                     .CLKRD_P1                (ram_row_3_col_0_clk_b),
                     .ADRRD_P1                (ADRRD_P1_ts33),
                     .RDEN_P1                 (RDEN_P1_ts33),
                     .QOUT_P1                 (ram_row_3_col_0_data_out_b),                
                                                     
                    
                   //-------------------------------------------------------------
                   // Power Management Interfaces
                   //-------------------------------------------------------------
                  //   .PWR_MGMT_IN                        ({pwr_mgmt_in_rf[PWR_MGMT_IN_SIZE-1:1],ram_fary_pwren_b[3]}), // MSB changed from 3'b100
                  //   .PWR_MGMT_OUT                       (ram_aary_pwren_b[3]),  
                
                       
                     `ifndef INTEL_NO_PWR_PINS
                        .vddp                            (ram_row_3_col_0_vcc),
                        `ifdef INTC_ADD_VSS
                        .vss                            (1'b0),
                        `endif  
                     `endif
               
        
        
        
                      //REPAIR INPUTS
        
                    .FCA           (ram_row_3_col_0_bisr_inst_Q[6:1]), // column repair addres --- > F means faulty
                    .CRE          (ram_row_3_col_0_bisr_inst_Q[0]), //Column repair enable
                    
        
                    // POWER MGMT inputs
                    //.ROP_SD             (), // shutoffout
                    //.ROP_DS             (), //dpslp_or_shutoffout
                    //TEMPCOMMENT1.MPMS              (1'b0), // {shutoff,deepsleep,fastsleep}
        
                    //TIMING and TRIM
                    // MDST = {async_reset0,async_reset1,wmce,mce,stbyp,rmce}
                    .MDST_hs2r2w       ({fary_ffuse_rfhs2r2w_trim[9],fary_ffuse_rfhs2r2w_trim[8],fary_ffuse_rfhs2r2w_trim[7:5],fary_ffuse_rfhs2r2w_trim[4],fary_ffuse_rfhs2r2w_trim[3],fary_ffuse_rfhs2r2w_trim[2:0]}),
                                        
        
                    //DFT inputs
                    .DFTSHIFTEN        (DFTSHIFTEN),
                    .DFTMASK           (DFTMASK),
                    .DFT_ARRAY_FREEZE    (DFT_ARRAY_FREEZE),
                    
                    .DFT_AFD_RESET_B    (DFT_AFD_RESET_B)
        
        
        
        );//ip783rfhs2r2w256x34s0c1p1d0_dft_wrp
        
        assign          ram_rd_data_a_col[3][0]    = ram_row_3_col_0_data_out_a;
        assign          ram_rd_data_b_col[3][0]    = ram_row_3_col_0_data_out_b;
        
             

        wire                            ram_row_4_col_0_clk_a       = clk_a;
        wire                            ram_row_4_col_0_clk_b       = clk_b;
        wire    [8-1:0]       ram_row_4_col_0_wr_adr_a    = ram_row_wr_adr_a[4][8-1:0];
        wire    [8-1:0]       ram_row_4_col_0_wr_adr_b    = ram_row_wr_adr_b[4][8-1:0];
        wire    [8-1:0]       ram_row_4_col_0_rd_adr_a    = ram_row_rd_adr_a[4][8-1:0];
        wire    [8-1:0]       ram_row_4_col_0_rd_adr_b    = ram_row_rd_adr_b[4][8-1:0];
        wire                            ram_row_4_col_0_rd_en_a     = ram_row_rd_en_a[4];
        wire                            ram_row_4_col_0_rd_en_b     = ram_row_rd_en_b[4];
        wire                            ram_row_4_col_0_wr_en_a     = |ram_col_wr_en_a[4][0];
        wire                            ram_row_4_col_0_wr_en_b     = |ram_col_wr_en_b[4][0];
        wire    [34-1:0]              ram_row_4_col_0_data_in_a   = ram_wr_data_a_col[0][34-1:0];
        wire    [34-1:0]              ram_row_4_col_0_data_in_b   = ram_wr_data_b_col[0][34-1:0];
        wire    [34-1:0]              ram_row_4_col_0_data_out_a;
        wire    [34-1:0]              ram_row_4_col_0_data_out_b;
        wire    [2:0]                   ram_row_4_col_0_aary_pwren_b;
        wire                            ram_row_4_col_0_vcc = 1'b1;
        
        
        ip783rfhs2r2w256x34s0c1p1d0_dft_wrp #(
                    )
        ram_row_4_col_0 (
                    //------------------------------------------------------------
                    // Functional Interfaces
                    //------------------------------------------------------------      
        
                     .CLKWR_P0                (ram_row_4_col_0_clk_a),
                     .ADRWR_P0                (ADRWR_P0_ts44),
                     .WREN_P0                 (WREN_P0_ts44),
                     .DIN_P0                  (DIN_P0_ts44),
        
                     .CLKWR_P1                (ram_row_4_col_0_clk_b),
                     .ADRWR_P1                (ADRWR_P1_ts44),
                     .WREN_P1                 (WREN_P1_ts44),
                     .DIN_P1                  (DIN_P1_ts44),
        
                     .CLKRD_P0                (ram_row_4_col_0_clk_a),
                     .ADRRD_P0                (ADRRD_P0_ts44),
                     .RDEN_P0                 (RDEN_P0_ts44),
                     .QOUT_P0                 (ram_row_4_col_0_data_out_a),
                         
                     .CLKRD_P1                (ram_row_4_col_0_clk_b),
                     .ADRRD_P1                (ADRRD_P1_ts44),
                     .RDEN_P1                 (RDEN_P1_ts44),
                     .QOUT_P1                 (ram_row_4_col_0_data_out_b),                
                                                     
                    
                   //-------------------------------------------------------------
                   // Power Management Interfaces
                   //-------------------------------------------------------------
                  //   .PWR_MGMT_IN                        ({pwr_mgmt_in_rf[PWR_MGMT_IN_SIZE-1:1],ram_fary_pwren_b[4]}), // MSB changed from 3'b100
                  //   .PWR_MGMT_OUT                       (ram_aary_pwren_b[4]),  
                
                       
                     `ifndef INTEL_NO_PWR_PINS
                        .vddp                            (ram_row_4_col_0_vcc),
                        `ifdef INTC_ADD_VSS
                        .vss                            (1'b0),
                        `endif  
                     `endif
               
        
        
        
                      //REPAIR INPUTS
        
                    .FCA           (ram_row_4_col_0_bisr_inst_Q[6:1]), // column repair addres --- > F means faulty
                    .CRE          (ram_row_4_col_0_bisr_inst_Q[0]), //Column repair enable
                    
        
                    // POWER MGMT inputs
                    //.ROP_SD             (), // shutoffout
                    //.ROP_DS             (), //dpslp_or_shutoffout
                    //TEMPCOMMENT1.MPMS              (1'b0), // {shutoff,deepsleep,fastsleep}
        
                    //TIMING and TRIM
                    // MDST = {async_reset0,async_reset1,wmce,mce,stbyp,rmce}
                    .MDST_hs2r2w       ({fary_ffuse_rfhs2r2w_trim[9],fary_ffuse_rfhs2r2w_trim[8],fary_ffuse_rfhs2r2w_trim[7:5],fary_ffuse_rfhs2r2w_trim[4],fary_ffuse_rfhs2r2w_trim[3],fary_ffuse_rfhs2r2w_trim[2:0]}),
                                        
        
                    //DFT inputs
                    .DFTSHIFTEN        (DFTSHIFTEN),
                    .DFTMASK           (DFTMASK),
                    .DFT_ARRAY_FREEZE    (DFT_ARRAY_FREEZE),
                    
                    .DFT_AFD_RESET_B    (DFT_AFD_RESET_B)
        
        
        
        );//ip783rfhs2r2w256x34s0c1p1d0_dft_wrp
        
        assign          ram_rd_data_a_col[4][0]    = ram_row_4_col_0_data_out_a;
        assign          ram_rd_data_b_col[4][0]    = ram_row_4_col_0_data_out_b;
        
             

        wire                            ram_row_5_col_0_clk_a       = clk_a;
        wire                            ram_row_5_col_0_clk_b       = clk_b;
        wire    [8-1:0]       ram_row_5_col_0_wr_adr_a    = ram_row_wr_adr_a[5][8-1:0];
        wire    [8-1:0]       ram_row_5_col_0_wr_adr_b    = ram_row_wr_adr_b[5][8-1:0];
        wire    [8-1:0]       ram_row_5_col_0_rd_adr_a    = ram_row_rd_adr_a[5][8-1:0];
        wire    [8-1:0]       ram_row_5_col_0_rd_adr_b    = ram_row_rd_adr_b[5][8-1:0];
        wire                            ram_row_5_col_0_rd_en_a     = ram_row_rd_en_a[5];
        wire                            ram_row_5_col_0_rd_en_b     = ram_row_rd_en_b[5];
        wire                            ram_row_5_col_0_wr_en_a     = |ram_col_wr_en_a[5][0];
        wire                            ram_row_5_col_0_wr_en_b     = |ram_col_wr_en_b[5][0];
        wire    [34-1:0]              ram_row_5_col_0_data_in_a   = ram_wr_data_a_col[0][34-1:0];
        wire    [34-1:0]              ram_row_5_col_0_data_in_b   = ram_wr_data_b_col[0][34-1:0];
        wire    [34-1:0]              ram_row_5_col_0_data_out_a;
        wire    [34-1:0]              ram_row_5_col_0_data_out_b;
        wire    [2:0]                   ram_row_5_col_0_aary_pwren_b;
        wire                            ram_row_5_col_0_vcc = 1'b1;
        
        
        ip783rfhs2r2w256x34s0c1p1d0_dft_wrp #(
                    )
        ram_row_5_col_0 (
                    //------------------------------------------------------------
                    // Functional Interfaces
                    //------------------------------------------------------------      
        
                     .CLKWR_P0                (ram_row_5_col_0_clk_a),
                     .ADRWR_P0                (ADRWR_P0_ts55),
                     .WREN_P0                 (WREN_P0_ts55),
                     .DIN_P0                  (DIN_P0_ts55),
        
                     .CLKWR_P1                (ram_row_5_col_0_clk_b),
                     .ADRWR_P1                (ADRWR_P1_ts55),
                     .WREN_P1                 (WREN_P1_ts55),
                     .DIN_P1                  (DIN_P1_ts55),
        
                     .CLKRD_P0                (ram_row_5_col_0_clk_a),
                     .ADRRD_P0                (ADRRD_P0_ts55),
                     .RDEN_P0                 (RDEN_P0_ts55),
                     .QOUT_P0                 (ram_row_5_col_0_data_out_a),
                         
                     .CLKRD_P1                (ram_row_5_col_0_clk_b),
                     .ADRRD_P1                (ADRRD_P1_ts55),
                     .RDEN_P1                 (RDEN_P1_ts55),
                     .QOUT_P1                 (ram_row_5_col_0_data_out_b),                
                                                     
                    
                   //-------------------------------------------------------------
                   // Power Management Interfaces
                   //-------------------------------------------------------------
                  //   .PWR_MGMT_IN                        ({pwr_mgmt_in_rf[PWR_MGMT_IN_SIZE-1:1],ram_fary_pwren_b[5]}), // MSB changed from 3'b100
                  //   .PWR_MGMT_OUT                       (ram_aary_pwren_b[5]),  
                
                       
                     `ifndef INTEL_NO_PWR_PINS
                        .vddp                            (ram_row_5_col_0_vcc),
                        `ifdef INTC_ADD_VSS
                        .vss                            (1'b0),
                        `endif  
                     `endif
               
        
        
        
                      //REPAIR INPUTS
        
                    .FCA           (ram_row_5_col_0_bisr_inst_Q[6:1]), // column repair addres --- > F means faulty
                    .CRE          (ram_row_5_col_0_bisr_inst_Q[0]), //Column repair enable
                    
        
                    // POWER MGMT inputs
                    //.ROP_SD             (), // shutoffout
                    //.ROP_DS             (), //dpslp_or_shutoffout
                    //TEMPCOMMENT1.MPMS              (1'b0), // {shutoff,deepsleep,fastsleep}
        
                    //TIMING and TRIM
                    // MDST = {async_reset0,async_reset1,wmce,mce,stbyp,rmce}
                    .MDST_hs2r2w       ({fary_ffuse_rfhs2r2w_trim[9],fary_ffuse_rfhs2r2w_trim[8],fary_ffuse_rfhs2r2w_trim[7:5],fary_ffuse_rfhs2r2w_trim[4],fary_ffuse_rfhs2r2w_trim[3],fary_ffuse_rfhs2r2w_trim[2:0]}),
                                        
        
                    //DFT inputs
                    .DFTSHIFTEN        (DFTSHIFTEN),
                    .DFTMASK           (DFTMASK),
                    .DFT_ARRAY_FREEZE    (DFT_ARRAY_FREEZE),
                    
                    .DFT_AFD_RESET_B    (DFT_AFD_RESET_B)
        
        
        
        );//ip783rfhs2r2w256x34s0c1p1d0_dft_wrp
        
        assign          ram_rd_data_a_col[5][0]    = ram_row_5_col_0_data_out_a;
        assign          ram_rd_data_b_col[5][0]    = ram_row_5_col_0_data_out_b;
        
             

        wire                            ram_row_6_col_0_clk_a       = clk_a;
        wire                            ram_row_6_col_0_clk_b       = clk_b;
        wire    [8-1:0]       ram_row_6_col_0_wr_adr_a    = ram_row_wr_adr_a[6][8-1:0];
        wire    [8-1:0]       ram_row_6_col_0_wr_adr_b    = ram_row_wr_adr_b[6][8-1:0];
        wire    [8-1:0]       ram_row_6_col_0_rd_adr_a    = ram_row_rd_adr_a[6][8-1:0];
        wire    [8-1:0]       ram_row_6_col_0_rd_adr_b    = ram_row_rd_adr_b[6][8-1:0];
        wire                            ram_row_6_col_0_rd_en_a     = ram_row_rd_en_a[6];
        wire                            ram_row_6_col_0_rd_en_b     = ram_row_rd_en_b[6];
        wire                            ram_row_6_col_0_wr_en_a     = |ram_col_wr_en_a[6][0];
        wire                            ram_row_6_col_0_wr_en_b     = |ram_col_wr_en_b[6][0];
        wire    [34-1:0]              ram_row_6_col_0_data_in_a   = ram_wr_data_a_col[0][34-1:0];
        wire    [34-1:0]              ram_row_6_col_0_data_in_b   = ram_wr_data_b_col[0][34-1:0];
        wire    [34-1:0]              ram_row_6_col_0_data_out_a;
        wire    [34-1:0]              ram_row_6_col_0_data_out_b;
        wire    [2:0]                   ram_row_6_col_0_aary_pwren_b;
        wire                            ram_row_6_col_0_vcc = 1'b1;
        
        
        ip783rfhs2r2w256x34s0c1p1d0_dft_wrp #(
                    )
        ram_row_6_col_0 (
                    //------------------------------------------------------------
                    // Functional Interfaces
                    //------------------------------------------------------------      
        
                     .CLKWR_P0                (ram_row_6_col_0_clk_a),
                     .ADRWR_P0                (ADRWR_P0_ts60),
                     .WREN_P0                 (WREN_P0_ts60),
                     .DIN_P0                  (DIN_P0_ts60),
        
                     .CLKWR_P1                (ram_row_6_col_0_clk_b),
                     .ADRWR_P1                (ADRWR_P1_ts60),
                     .WREN_P1                 (WREN_P1_ts60),
                     .DIN_P1                  (DIN_P1_ts60),
        
                     .CLKRD_P0                (ram_row_6_col_0_clk_a),
                     .ADRRD_P0                (ADRRD_P0_ts60),
                     .RDEN_P0                 (RDEN_P0_ts60),
                     .QOUT_P0                 (ram_row_6_col_0_data_out_a),
                         
                     .CLKRD_P1                (ram_row_6_col_0_clk_b),
                     .ADRRD_P1                (ADRRD_P1_ts60),
                     .RDEN_P1                 (RDEN_P1_ts60),
                     .QOUT_P1                 (ram_row_6_col_0_data_out_b),                
                                                     
                    
                   //-------------------------------------------------------------
                   // Power Management Interfaces
                   //-------------------------------------------------------------
                  //   .PWR_MGMT_IN                        ({pwr_mgmt_in_rf[PWR_MGMT_IN_SIZE-1:1],ram_fary_pwren_b[6]}), // MSB changed from 3'b100
                  //   .PWR_MGMT_OUT                       (ram_aary_pwren_b[6]),  
                
                       
                     `ifndef INTEL_NO_PWR_PINS
                        .vddp                            (ram_row_6_col_0_vcc),
                        `ifdef INTC_ADD_VSS
                        .vss                            (1'b0),
                        `endif  
                     `endif
               
        
        
        
                      //REPAIR INPUTS
        
                    .FCA           (ram_row_6_col_0_bisr_inst_Q[6:1]), // column repair addres --- > F means faulty
                    .CRE          (ram_row_6_col_0_bisr_inst_Q[0]), //Column repair enable
                    
        
                    // POWER MGMT inputs
                    //.ROP_SD             (), // shutoffout
                    //.ROP_DS             (), //dpslp_or_shutoffout
                    //TEMPCOMMENT1.MPMS              (1'b0), // {shutoff,deepsleep,fastsleep}
        
                    //TIMING and TRIM
                    // MDST = {async_reset0,async_reset1,wmce,mce,stbyp,rmce}
                    .MDST_hs2r2w       ({fary_ffuse_rfhs2r2w_trim[9],fary_ffuse_rfhs2r2w_trim[8],fary_ffuse_rfhs2r2w_trim[7:5],fary_ffuse_rfhs2r2w_trim[4],fary_ffuse_rfhs2r2w_trim[3],fary_ffuse_rfhs2r2w_trim[2:0]}),
                                        
        
                    //DFT inputs
                    .DFTSHIFTEN        (DFTSHIFTEN),
                    .DFTMASK           (DFTMASK),
                    .DFT_ARRAY_FREEZE    (DFT_ARRAY_FREEZE),
                    
                    .DFT_AFD_RESET_B    (DFT_AFD_RESET_B)
        
        
        
        );//ip783rfhs2r2w256x34s0c1p1d0_dft_wrp
        
        assign          ram_rd_data_a_col[6][0]    = ram_row_6_col_0_data_out_a;
        assign          ram_rd_data_b_col[6][0]    = ram_row_6_col_0_data_out_b;
        
             

        wire                            ram_row_7_col_0_clk_a       = clk_a;
        wire                            ram_row_7_col_0_clk_b       = clk_b;
        wire    [8-1:0]       ram_row_7_col_0_wr_adr_a    = ram_row_wr_adr_a[7][8-1:0];
        wire    [8-1:0]       ram_row_7_col_0_wr_adr_b    = ram_row_wr_adr_b[7][8-1:0];
        wire    [8-1:0]       ram_row_7_col_0_rd_adr_a    = ram_row_rd_adr_a[7][8-1:0];
        wire    [8-1:0]       ram_row_7_col_0_rd_adr_b    = ram_row_rd_adr_b[7][8-1:0];
        wire                            ram_row_7_col_0_rd_en_a     = ram_row_rd_en_a[7];
        wire                            ram_row_7_col_0_rd_en_b     = ram_row_rd_en_b[7];
        wire                            ram_row_7_col_0_wr_en_a     = |ram_col_wr_en_a[7][0];
        wire                            ram_row_7_col_0_wr_en_b     = |ram_col_wr_en_b[7][0];
        wire    [34-1:0]              ram_row_7_col_0_data_in_a   = ram_wr_data_a_col[0][34-1:0];
        wire    [34-1:0]              ram_row_7_col_0_data_in_b   = ram_wr_data_b_col[0][34-1:0];
        wire    [34-1:0]              ram_row_7_col_0_data_out_a;
        wire    [34-1:0]              ram_row_7_col_0_data_out_b;
        wire    [2:0]                   ram_row_7_col_0_aary_pwren_b;
        wire                            ram_row_7_col_0_vcc = 1'b1;
        
        
        ip783rfhs2r2w256x34s0c1p1d0_dft_wrp #(
                    )
        ram_row_7_col_0 (
                    //------------------------------------------------------------
                    // Functional Interfaces
                    //------------------------------------------------------------      
        
                     .CLKWR_P0                (ram_row_7_col_0_clk_a),
                     .ADRWR_P0                (ADRWR_P0_ts61),
                     .WREN_P0                 (WREN_P0_ts61),
                     .DIN_P0                  (DIN_P0_ts61),
        
                     .CLKWR_P1                (ram_row_7_col_0_clk_b),
                     .ADRWR_P1                (ADRWR_P1_ts61),
                     .WREN_P1                 (WREN_P1_ts61),
                     .DIN_P1                  (DIN_P1_ts61),
        
                     .CLKRD_P0                (ram_row_7_col_0_clk_a),
                     .ADRRD_P0                (ADRRD_P0_ts61),
                     .RDEN_P0                 (RDEN_P0_ts61),
                     .QOUT_P0                 (ram_row_7_col_0_data_out_a),
                         
                     .CLKRD_P1                (ram_row_7_col_0_clk_b),
                     .ADRRD_P1                (ADRRD_P1_ts61),
                     .RDEN_P1                 (RDEN_P1_ts61),
                     .QOUT_P1                 (ram_row_7_col_0_data_out_b),                
                                                     
                    
                   //-------------------------------------------------------------
                   // Power Management Interfaces
                   //-------------------------------------------------------------
                  //   .PWR_MGMT_IN                        ({pwr_mgmt_in_rf[PWR_MGMT_IN_SIZE-1:1],ram_fary_pwren_b[7]}), // MSB changed from 3'b100
                  //   .PWR_MGMT_OUT                       (ram_aary_pwren_b[7]),  
                
                       
                     `ifndef INTEL_NO_PWR_PINS
                        .vddp                            (ram_row_7_col_0_vcc),
                        `ifdef INTC_ADD_VSS
                        .vss                            (1'b0),
                        `endif  
                     `endif
               
        
        
        
                      //REPAIR INPUTS
        
                    .FCA           (ram_row_7_col_0_bisr_inst_Q[6:1]), // column repair addres --- > F means faulty
                    .CRE          (ram_row_7_col_0_bisr_inst_Q[0]), //Column repair enable
                    
        
                    // POWER MGMT inputs
                    //.ROP_SD             (), // shutoffout
                    //.ROP_DS             (), //dpslp_or_shutoffout
                    //TEMPCOMMENT1.MPMS              (1'b0), // {shutoff,deepsleep,fastsleep}
        
                    //TIMING and TRIM
                    // MDST = {async_reset0,async_reset1,wmce,mce,stbyp,rmce}
                    .MDST_hs2r2w       ({fary_ffuse_rfhs2r2w_trim[9],fary_ffuse_rfhs2r2w_trim[8],fary_ffuse_rfhs2r2w_trim[7:5],fary_ffuse_rfhs2r2w_trim[4],fary_ffuse_rfhs2r2w_trim[3],fary_ffuse_rfhs2r2w_trim[2:0]}),
                                        
        
                    //DFT inputs
                    .DFTSHIFTEN        (DFTSHIFTEN),
                    .DFTMASK           (DFTMASK),
                    .DFT_ARRAY_FREEZE    (DFT_ARRAY_FREEZE),
                    
                    .DFT_AFD_RESET_B    (DFT_AFD_RESET_B)
        
        
        
        );//ip783rfhs2r2w256x34s0c1p1d0_dft_wrp
        
        assign          ram_rd_data_a_col[7][0]    = ram_row_7_col_0_data_out_a;
        assign          ram_rd_data_b_col[7][0]    = ram_row_7_col_0_data_out_b;
        
             

        wire                            ram_row_8_col_0_clk_a       = clk_a;
        wire                            ram_row_8_col_0_clk_b       = clk_b;
        wire    [8-1:0]       ram_row_8_col_0_wr_adr_a    = ram_row_wr_adr_a[8][8-1:0];
        wire    [8-1:0]       ram_row_8_col_0_wr_adr_b    = ram_row_wr_adr_b[8][8-1:0];
        wire    [8-1:0]       ram_row_8_col_0_rd_adr_a    = ram_row_rd_adr_a[8][8-1:0];
        wire    [8-1:0]       ram_row_8_col_0_rd_adr_b    = ram_row_rd_adr_b[8][8-1:0];
        wire                            ram_row_8_col_0_rd_en_a     = ram_row_rd_en_a[8];
        wire                            ram_row_8_col_0_rd_en_b     = ram_row_rd_en_b[8];
        wire                            ram_row_8_col_0_wr_en_a     = |ram_col_wr_en_a[8][0];
        wire                            ram_row_8_col_0_wr_en_b     = |ram_col_wr_en_b[8][0];
        wire    [34-1:0]              ram_row_8_col_0_data_in_a   = ram_wr_data_a_col[0][34-1:0];
        wire    [34-1:0]              ram_row_8_col_0_data_in_b   = ram_wr_data_b_col[0][34-1:0];
        wire    [34-1:0]              ram_row_8_col_0_data_out_a;
        wire    [34-1:0]              ram_row_8_col_0_data_out_b;
        wire    [2:0]                   ram_row_8_col_0_aary_pwren_b;
        wire                            ram_row_8_col_0_vcc = 1'b1;
        
        
        ip783rfhs2r2w256x34s0c1p1d0_dft_wrp #(
                    )
        ram_row_8_col_0 (
                    //------------------------------------------------------------
                    // Functional Interfaces
                    //------------------------------------------------------------      
        
                     .CLKWR_P0                (ram_row_8_col_0_clk_a),
                     .ADRWR_P0                (ADRWR_P0_ts62),
                     .WREN_P0                 (WREN_P0_ts62),
                     .DIN_P0                  (DIN_P0_ts62),
        
                     .CLKWR_P1                (ram_row_8_col_0_clk_b),
                     .ADRWR_P1                (ADRWR_P1_ts62),
                     .WREN_P1                 (WREN_P1_ts62),
                     .DIN_P1                  (DIN_P1_ts62),
        
                     .CLKRD_P0                (ram_row_8_col_0_clk_a),
                     .ADRRD_P0                (ADRRD_P0_ts62),
                     .RDEN_P0                 (RDEN_P0_ts62),
                     .QOUT_P0                 (ram_row_8_col_0_data_out_a),
                         
                     .CLKRD_P1                (ram_row_8_col_0_clk_b),
                     .ADRRD_P1                (ADRRD_P1_ts62),
                     .RDEN_P1                 (RDEN_P1_ts62),
                     .QOUT_P1                 (ram_row_8_col_0_data_out_b),                
                                                     
                    
                   //-------------------------------------------------------------
                   // Power Management Interfaces
                   //-------------------------------------------------------------
                  //   .PWR_MGMT_IN                        ({pwr_mgmt_in_rf[PWR_MGMT_IN_SIZE-1:1],ram_fary_pwren_b[8]}), // MSB changed from 3'b100
                  //   .PWR_MGMT_OUT                       (ram_aary_pwren_b[8]),  
                
                       
                     `ifndef INTEL_NO_PWR_PINS
                        .vddp                            (ram_row_8_col_0_vcc),
                        `ifdef INTC_ADD_VSS
                        .vss                            (1'b0),
                        `endif  
                     `endif
               
        
        
        
                      //REPAIR INPUTS
        
                    .FCA           (ram_row_8_col_0_bisr_inst_Q[6:1]), // column repair addres --- > F means faulty
                    .CRE          (ram_row_8_col_0_bisr_inst_Q[0]), //Column repair enable
                    
        
                    // POWER MGMT inputs
                    //.ROP_SD             (), // shutoffout
                    //.ROP_DS             (), //dpslp_or_shutoffout
                    //TEMPCOMMENT1.MPMS              (1'b0), // {shutoff,deepsleep,fastsleep}
        
                    //TIMING and TRIM
                    // MDST = {async_reset0,async_reset1,wmce,mce,stbyp,rmce}
                    .MDST_hs2r2w       ({fary_ffuse_rfhs2r2w_trim[9],fary_ffuse_rfhs2r2w_trim[8],fary_ffuse_rfhs2r2w_trim[7:5],fary_ffuse_rfhs2r2w_trim[4],fary_ffuse_rfhs2r2w_trim[3],fary_ffuse_rfhs2r2w_trim[2:0]}),
                                        
        
                    //DFT inputs
                    .DFTSHIFTEN        (DFTSHIFTEN),
                    .DFTMASK           (DFTMASK),
                    .DFT_ARRAY_FREEZE    (DFT_ARRAY_FREEZE),
                    
                    .DFT_AFD_RESET_B    (DFT_AFD_RESET_B)
        
        
        
        );//ip783rfhs2r2w256x34s0c1p1d0_dft_wrp
        
        assign          ram_rd_data_a_col[8][0]    = ram_row_8_col_0_data_out_a;
        assign          ram_rd_data_b_col[8][0]    = ram_row_8_col_0_data_out_b;
        
             

        wire                            ram_row_9_col_0_clk_a       = clk_a;
        wire                            ram_row_9_col_0_clk_b       = clk_b;
        wire    [8-1:0]       ram_row_9_col_0_wr_adr_a    = ram_row_wr_adr_a[9][8-1:0];
        wire    [8-1:0]       ram_row_9_col_0_wr_adr_b    = ram_row_wr_adr_b[9][8-1:0];
        wire    [8-1:0]       ram_row_9_col_0_rd_adr_a    = ram_row_rd_adr_a[9][8-1:0];
        wire    [8-1:0]       ram_row_9_col_0_rd_adr_b    = ram_row_rd_adr_b[9][8-1:0];
        wire                            ram_row_9_col_0_rd_en_a     = ram_row_rd_en_a[9];
        wire                            ram_row_9_col_0_rd_en_b     = ram_row_rd_en_b[9];
        wire                            ram_row_9_col_0_wr_en_a     = |ram_col_wr_en_a[9][0];
        wire                            ram_row_9_col_0_wr_en_b     = |ram_col_wr_en_b[9][0];
        wire    [34-1:0]              ram_row_9_col_0_data_in_a   = ram_wr_data_a_col[0][34-1:0];
        wire    [34-1:0]              ram_row_9_col_0_data_in_b   = ram_wr_data_b_col[0][34-1:0];
        wire    [34-1:0]              ram_row_9_col_0_data_out_a;
        wire    [34-1:0]              ram_row_9_col_0_data_out_b;
        wire    [2:0]                   ram_row_9_col_0_aary_pwren_b;
        wire                            ram_row_9_col_0_vcc = 1'b1;
        
        
        ip783rfhs2r2w256x34s0c1p1d0_dft_wrp #(
                    )
        ram_row_9_col_0 (
                    //------------------------------------------------------------
                    // Functional Interfaces
                    //------------------------------------------------------------      
        
                     .CLKWR_P0                (ram_row_9_col_0_clk_a),
                     .ADRWR_P0                (ADRWR_P0_ts63),
                     .WREN_P0                 (WREN_P0_ts63),
                     .DIN_P0                  (DIN_P0_ts63),
        
                     .CLKWR_P1                (ram_row_9_col_0_clk_b),
                     .ADRWR_P1                (ADRWR_P1_ts63),
                     .WREN_P1                 (WREN_P1_ts63),
                     .DIN_P1                  (DIN_P1_ts63),
        
                     .CLKRD_P0                (ram_row_9_col_0_clk_a),
                     .ADRRD_P0                (ADRRD_P0_ts63),
                     .RDEN_P0                 (RDEN_P0_ts63),
                     .QOUT_P0                 (ram_row_9_col_0_data_out_a),
                         
                     .CLKRD_P1                (ram_row_9_col_0_clk_b),
                     .ADRRD_P1                (ADRRD_P1_ts63),
                     .RDEN_P1                 (RDEN_P1_ts63),
                     .QOUT_P1                 (ram_row_9_col_0_data_out_b),                
                                                     
                    
                   //-------------------------------------------------------------
                   // Power Management Interfaces
                   //-------------------------------------------------------------
                  //   .PWR_MGMT_IN                        ({pwr_mgmt_in_rf[PWR_MGMT_IN_SIZE-1:1],ram_fary_pwren_b[9]}), // MSB changed from 3'b100
                  //   .PWR_MGMT_OUT                       (ram_aary_pwren_b[9]),  
                
                       
                     `ifndef INTEL_NO_PWR_PINS
                        .vddp                            (ram_row_9_col_0_vcc),
                        `ifdef INTC_ADD_VSS
                        .vss                            (1'b0),
                        `endif  
                     `endif
               
        
        
        
                      //REPAIR INPUTS
        
                    .FCA           (ram_row_9_col_0_bisr_inst_Q[6:1]), // column repair addres --- > F means faulty
                    .CRE          (ram_row_9_col_0_bisr_inst_Q[0]), //Column repair enable
                    
        
                    // POWER MGMT inputs
                    //.ROP_SD             (), // shutoffout
                    //.ROP_DS             (), //dpslp_or_shutoffout
                    //TEMPCOMMENT1.MPMS              (1'b0), // {shutoff,deepsleep,fastsleep}
        
                    //TIMING and TRIM
                    // MDST = {async_reset0,async_reset1,wmce,mce,stbyp,rmce}
                    .MDST_hs2r2w       ({fary_ffuse_rfhs2r2w_trim[9],fary_ffuse_rfhs2r2w_trim[8],fary_ffuse_rfhs2r2w_trim[7:5],fary_ffuse_rfhs2r2w_trim[4],fary_ffuse_rfhs2r2w_trim[3],fary_ffuse_rfhs2r2w_trim[2:0]}),
                                        
        
                    //DFT inputs
                    .DFTSHIFTEN        (DFTSHIFTEN),
                    .DFTMASK           (DFTMASK),
                    .DFT_ARRAY_FREEZE    (DFT_ARRAY_FREEZE),
                    
                    .DFT_AFD_RESET_B    (DFT_AFD_RESET_B)
        
        
        
        );//ip783rfhs2r2w256x34s0c1p1d0_dft_wrp
        
        assign          ram_rd_data_a_col[9][0]    = ram_row_9_col_0_data_out_a;
        assign          ram_rd_data_b_col[9][0]    = ram_row_9_col_0_data_out_b;
        
             

        wire                            ram_row_10_col_0_clk_a       = clk_a;
        wire                            ram_row_10_col_0_clk_b       = clk_b;
        wire    [8-1:0]       ram_row_10_col_0_wr_adr_a    = ram_row_wr_adr_a[10][8-1:0];
        wire    [8-1:0]       ram_row_10_col_0_wr_adr_b    = ram_row_wr_adr_b[10][8-1:0];
        wire    [8-1:0]       ram_row_10_col_0_rd_adr_a    = ram_row_rd_adr_a[10][8-1:0];
        wire    [8-1:0]       ram_row_10_col_0_rd_adr_b    = ram_row_rd_adr_b[10][8-1:0];
        wire                            ram_row_10_col_0_rd_en_a     = ram_row_rd_en_a[10];
        wire                            ram_row_10_col_0_rd_en_b     = ram_row_rd_en_b[10];
        wire                            ram_row_10_col_0_wr_en_a     = |ram_col_wr_en_a[10][0];
        wire                            ram_row_10_col_0_wr_en_b     = |ram_col_wr_en_b[10][0];
        wire    [34-1:0]              ram_row_10_col_0_data_in_a   = ram_wr_data_a_col[0][34-1:0];
        wire    [34-1:0]              ram_row_10_col_0_data_in_b   = ram_wr_data_b_col[0][34-1:0];
        wire    [34-1:0]              ram_row_10_col_0_data_out_a;
        wire    [34-1:0]              ram_row_10_col_0_data_out_b;
        wire    [2:0]                   ram_row_10_col_0_aary_pwren_b;
        wire                            ram_row_10_col_0_vcc = 1'b1;
        
        
        ip783rfhs2r2w256x34s0c1p1d0_dft_wrp #(
                    )
        ram_row_10_col_0 (
                    //------------------------------------------------------------
                    // Functional Interfaces
                    //------------------------------------------------------------      
        
                     .CLKWR_P0                (ram_row_10_col_0_clk_a),
                     .ADRWR_P0                (ADRWR_P0_ts1),
                     .WREN_P0                 (WREN_P0_ts1),
                     .DIN_P0                  (DIN_P0_ts1),
        
                     .CLKWR_P1                (ram_row_10_col_0_clk_b),
                     .ADRWR_P1                (ADRWR_P1_ts1),
                     .WREN_P1                 (WREN_P1_ts1),
                     .DIN_P1                  (DIN_P1_ts1),
        
                     .CLKRD_P0                (ram_row_10_col_0_clk_a),
                     .ADRRD_P0                (ADRRD_P0_ts1),
                     .RDEN_P0                 (RDEN_P0_ts1),
                     .QOUT_P0                 (ram_row_10_col_0_data_out_a),
                         
                     .CLKRD_P1                (ram_row_10_col_0_clk_b),
                     .ADRRD_P1                (ADRRD_P1_ts1),
                     .RDEN_P1                 (RDEN_P1_ts1),
                     .QOUT_P1                 (ram_row_10_col_0_data_out_b),                
                                                     
                    
                   //-------------------------------------------------------------
                   // Power Management Interfaces
                   //-------------------------------------------------------------
                  //   .PWR_MGMT_IN                        ({pwr_mgmt_in_rf[PWR_MGMT_IN_SIZE-1:1],ram_fary_pwren_b[10]}), // MSB changed from 3'b100
                  //   .PWR_MGMT_OUT                       (ram_aary_pwren_b[10]),  
                
                       
                     `ifndef INTEL_NO_PWR_PINS
                        .vddp                            (ram_row_10_col_0_vcc),
                        `ifdef INTC_ADD_VSS
                        .vss                            (1'b0),
                        `endif  
                     `endif
               
        
        
        
                      //REPAIR INPUTS
        
                    .FCA           (ram_row_10_col_0_bisr_inst_Q[6:1]), // column repair addres --- > F means faulty
                    .CRE          (ram_row_10_col_0_bisr_inst_Q[0]), //Column repair enable
                    
        
                    // POWER MGMT inputs
                    //.ROP_SD             (), // shutoffout
                    //.ROP_DS             (), //dpslp_or_shutoffout
                    //TEMPCOMMENT1.MPMS              (1'b0), // {shutoff,deepsleep,fastsleep}
        
                    //TIMING and TRIM
                    // MDST = {async_reset0,async_reset1,wmce,mce,stbyp,rmce}
                    .MDST_hs2r2w       ({fary_ffuse_rfhs2r2w_trim[9],fary_ffuse_rfhs2r2w_trim[8],fary_ffuse_rfhs2r2w_trim[7:5],fary_ffuse_rfhs2r2w_trim[4],fary_ffuse_rfhs2r2w_trim[3],fary_ffuse_rfhs2r2w_trim[2:0]}),
                                        
        
                    //DFT inputs
                    .DFTSHIFTEN        (DFTSHIFTEN),
                    .DFTMASK           (DFTMASK),
                    .DFT_ARRAY_FREEZE    (DFT_ARRAY_FREEZE),
                    
                    .DFT_AFD_RESET_B    (DFT_AFD_RESET_B)
        
        
        
        );//ip783rfhs2r2w256x34s0c1p1d0_dft_wrp
        
        assign          ram_rd_data_a_col[10][0]    = ram_row_10_col_0_data_out_a;
        assign          ram_rd_data_b_col[10][0]    = ram_row_10_col_0_data_out_b;
        
             

        wire                            ram_row_11_col_0_clk_a       = clk_a;
        wire                            ram_row_11_col_0_clk_b       = clk_b;
        wire    [8-1:0]       ram_row_11_col_0_wr_adr_a    = ram_row_wr_adr_a[11][8-1:0];
        wire    [8-1:0]       ram_row_11_col_0_wr_adr_b    = ram_row_wr_adr_b[11][8-1:0];
        wire    [8-1:0]       ram_row_11_col_0_rd_adr_a    = ram_row_rd_adr_a[11][8-1:0];
        wire    [8-1:0]       ram_row_11_col_0_rd_adr_b    = ram_row_rd_adr_b[11][8-1:0];
        wire                            ram_row_11_col_0_rd_en_a     = ram_row_rd_en_a[11];
        wire                            ram_row_11_col_0_rd_en_b     = ram_row_rd_en_b[11];
        wire                            ram_row_11_col_0_wr_en_a     = |ram_col_wr_en_a[11][0];
        wire                            ram_row_11_col_0_wr_en_b     = |ram_col_wr_en_b[11][0];
        wire    [34-1:0]              ram_row_11_col_0_data_in_a   = ram_wr_data_a_col[0][34-1:0];
        wire    [34-1:0]              ram_row_11_col_0_data_in_b   = ram_wr_data_b_col[0][34-1:0];
        wire    [34-1:0]              ram_row_11_col_0_data_out_a;
        wire    [34-1:0]              ram_row_11_col_0_data_out_b;
        wire    [2:0]                   ram_row_11_col_0_aary_pwren_b;
        wire                            ram_row_11_col_0_vcc = 1'b1;
        
        
        ip783rfhs2r2w256x34s0c1p1d0_dft_wrp #(
                    )
        ram_row_11_col_0 (
                    //------------------------------------------------------------
                    // Functional Interfaces
                    //------------------------------------------------------------      
        
                     .CLKWR_P0                (ram_row_11_col_0_clk_a),
                     .ADRWR_P0                (ADRWR_P0_ts2),
                     .WREN_P0                 (WREN_P0_ts2),
                     .DIN_P0                  (DIN_P0_ts2),
        
                     .CLKWR_P1                (ram_row_11_col_0_clk_b),
                     .ADRWR_P1                (ADRWR_P1_ts2),
                     .WREN_P1                 (WREN_P1_ts2),
                     .DIN_P1                  (DIN_P1_ts2),
        
                     .CLKRD_P0                (ram_row_11_col_0_clk_a),
                     .ADRRD_P0                (ADRRD_P0_ts2),
                     .RDEN_P0                 (RDEN_P0_ts2),
                     .QOUT_P0                 (ram_row_11_col_0_data_out_a),
                         
                     .CLKRD_P1                (ram_row_11_col_0_clk_b),
                     .ADRRD_P1                (ADRRD_P1_ts2),
                     .RDEN_P1                 (RDEN_P1_ts2),
                     .QOUT_P1                 (ram_row_11_col_0_data_out_b),                
                                                     
                    
                   //-------------------------------------------------------------
                   // Power Management Interfaces
                   //-------------------------------------------------------------
                  //   .PWR_MGMT_IN                        ({pwr_mgmt_in_rf[PWR_MGMT_IN_SIZE-1:1],ram_fary_pwren_b[11]}), // MSB changed from 3'b100
                  //   .PWR_MGMT_OUT                       (ram_aary_pwren_b[11]),  
                
                       
                     `ifndef INTEL_NO_PWR_PINS
                        .vddp                            (ram_row_11_col_0_vcc),
                        `ifdef INTC_ADD_VSS
                        .vss                            (1'b0),
                        `endif  
                     `endif
               
        
        
        
                      //REPAIR INPUTS
        
                    .FCA           (ram_row_11_col_0_bisr_inst_Q[6:1]), // column repair addres --- > F means faulty
                    .CRE          (ram_row_11_col_0_bisr_inst_Q[0]), //Column repair enable
                    
        
                    // POWER MGMT inputs
                    //.ROP_SD             (), // shutoffout
                    //.ROP_DS             (), //dpslp_or_shutoffout
                    //TEMPCOMMENT1.MPMS              (1'b0), // {shutoff,deepsleep,fastsleep}
        
                    //TIMING and TRIM
                    // MDST = {async_reset0,async_reset1,wmce,mce,stbyp,rmce}
                    .MDST_hs2r2w       ({fary_ffuse_rfhs2r2w_trim[9],fary_ffuse_rfhs2r2w_trim[8],fary_ffuse_rfhs2r2w_trim[7:5],fary_ffuse_rfhs2r2w_trim[4],fary_ffuse_rfhs2r2w_trim[3],fary_ffuse_rfhs2r2w_trim[2:0]}),
                                        
        
                    //DFT inputs
                    .DFTSHIFTEN        (DFTSHIFTEN),
                    .DFTMASK           (DFTMASK),
                    .DFT_ARRAY_FREEZE    (DFT_ARRAY_FREEZE),
                    
                    .DFT_AFD_RESET_B    (DFT_AFD_RESET_B)
        
        
        
        );//ip783rfhs2r2w256x34s0c1p1d0_dft_wrp
        
        assign          ram_rd_data_a_col[11][0]    = ram_row_11_col_0_data_out_a;
        assign          ram_rd_data_b_col[11][0]    = ram_row_11_col_0_data_out_b;
        
             

        wire                            ram_row_12_col_0_clk_a       = clk_a;
        wire                            ram_row_12_col_0_clk_b       = clk_b;
        wire    [8-1:0]       ram_row_12_col_0_wr_adr_a    = ram_row_wr_adr_a[12][8-1:0];
        wire    [8-1:0]       ram_row_12_col_0_wr_adr_b    = ram_row_wr_adr_b[12][8-1:0];
        wire    [8-1:0]       ram_row_12_col_0_rd_adr_a    = ram_row_rd_adr_a[12][8-1:0];
        wire    [8-1:0]       ram_row_12_col_0_rd_adr_b    = ram_row_rd_adr_b[12][8-1:0];
        wire                            ram_row_12_col_0_rd_en_a     = ram_row_rd_en_a[12];
        wire                            ram_row_12_col_0_rd_en_b     = ram_row_rd_en_b[12];
        wire                            ram_row_12_col_0_wr_en_a     = |ram_col_wr_en_a[12][0];
        wire                            ram_row_12_col_0_wr_en_b     = |ram_col_wr_en_b[12][0];
        wire    [34-1:0]              ram_row_12_col_0_data_in_a   = ram_wr_data_a_col[0][34-1:0];
        wire    [34-1:0]              ram_row_12_col_0_data_in_b   = ram_wr_data_b_col[0][34-1:0];
        wire    [34-1:0]              ram_row_12_col_0_data_out_a;
        wire    [34-1:0]              ram_row_12_col_0_data_out_b;
        wire    [2:0]                   ram_row_12_col_0_aary_pwren_b;
        wire                            ram_row_12_col_0_vcc = 1'b1;
        
        
        ip783rfhs2r2w256x34s0c1p1d0_dft_wrp #(
                    )
        ram_row_12_col_0 (
                    //------------------------------------------------------------
                    // Functional Interfaces
                    //------------------------------------------------------------      
        
                     .CLKWR_P0                (ram_row_12_col_0_clk_a),
                     .ADRWR_P0                (ADRWR_P0_ts3),
                     .WREN_P0                 (WREN_P0_ts3),
                     .DIN_P0                  (DIN_P0_ts3),
        
                     .CLKWR_P1                (ram_row_12_col_0_clk_b),
                     .ADRWR_P1                (ADRWR_P1_ts3),
                     .WREN_P1                 (WREN_P1_ts3),
                     .DIN_P1                  (DIN_P1_ts3),
        
                     .CLKRD_P0                (ram_row_12_col_0_clk_a),
                     .ADRRD_P0                (ADRRD_P0_ts3),
                     .RDEN_P0                 (RDEN_P0_ts3),
                     .QOUT_P0                 (ram_row_12_col_0_data_out_a),
                         
                     .CLKRD_P1                (ram_row_12_col_0_clk_b),
                     .ADRRD_P1                (ADRRD_P1_ts3),
                     .RDEN_P1                 (RDEN_P1_ts3),
                     .QOUT_P1                 (ram_row_12_col_0_data_out_b),                
                                                     
                    
                   //-------------------------------------------------------------
                   // Power Management Interfaces
                   //-------------------------------------------------------------
                  //   .PWR_MGMT_IN                        ({pwr_mgmt_in_rf[PWR_MGMT_IN_SIZE-1:1],ram_fary_pwren_b[12]}), // MSB changed from 3'b100
                  //   .PWR_MGMT_OUT                       (ram_aary_pwren_b[12]),  
                
                       
                     `ifndef INTEL_NO_PWR_PINS
                        .vddp                            (ram_row_12_col_0_vcc),
                        `ifdef INTC_ADD_VSS
                        .vss                            (1'b0),
                        `endif  
                     `endif
               
        
        
        
                      //REPAIR INPUTS
        
                    .FCA           (ram_row_12_col_0_bisr_inst_Q[6:1]), // column repair addres --- > F means faulty
                    .CRE          (ram_row_12_col_0_bisr_inst_Q[0]), //Column repair enable
                    
        
                    // POWER MGMT inputs
                    //.ROP_SD             (), // shutoffout
                    //.ROP_DS             (), //dpslp_or_shutoffout
                    //TEMPCOMMENT1.MPMS              (1'b0), // {shutoff,deepsleep,fastsleep}
        
                    //TIMING and TRIM
                    // MDST = {async_reset0,async_reset1,wmce,mce,stbyp,rmce}
                    .MDST_hs2r2w       ({fary_ffuse_rfhs2r2w_trim[9],fary_ffuse_rfhs2r2w_trim[8],fary_ffuse_rfhs2r2w_trim[7:5],fary_ffuse_rfhs2r2w_trim[4],fary_ffuse_rfhs2r2w_trim[3],fary_ffuse_rfhs2r2w_trim[2:0]}),
                                        
        
                    //DFT inputs
                    .DFTSHIFTEN        (DFTSHIFTEN),
                    .DFTMASK           (DFTMASK),
                    .DFT_ARRAY_FREEZE    (DFT_ARRAY_FREEZE),
                    
                    .DFT_AFD_RESET_B    (DFT_AFD_RESET_B)
        
        
        
        );//ip783rfhs2r2w256x34s0c1p1d0_dft_wrp
        
        assign          ram_rd_data_a_col[12][0]    = ram_row_12_col_0_data_out_a;
        assign          ram_rd_data_b_col[12][0]    = ram_row_12_col_0_data_out_b;
        
             

        wire                            ram_row_13_col_0_clk_a       = clk_a;
        wire                            ram_row_13_col_0_clk_b       = clk_b;
        wire    [8-1:0]       ram_row_13_col_0_wr_adr_a    = ram_row_wr_adr_a[13][8-1:0];
        wire    [8-1:0]       ram_row_13_col_0_wr_adr_b    = ram_row_wr_adr_b[13][8-1:0];
        wire    [8-1:0]       ram_row_13_col_0_rd_adr_a    = ram_row_rd_adr_a[13][8-1:0];
        wire    [8-1:0]       ram_row_13_col_0_rd_adr_b    = ram_row_rd_adr_b[13][8-1:0];
        wire                            ram_row_13_col_0_rd_en_a     = ram_row_rd_en_a[13];
        wire                            ram_row_13_col_0_rd_en_b     = ram_row_rd_en_b[13];
        wire                            ram_row_13_col_0_wr_en_a     = |ram_col_wr_en_a[13][0];
        wire                            ram_row_13_col_0_wr_en_b     = |ram_col_wr_en_b[13][0];
        wire    [34-1:0]              ram_row_13_col_0_data_in_a   = ram_wr_data_a_col[0][34-1:0];
        wire    [34-1:0]              ram_row_13_col_0_data_in_b   = ram_wr_data_b_col[0][34-1:0];
        wire    [34-1:0]              ram_row_13_col_0_data_out_a;
        wire    [34-1:0]              ram_row_13_col_0_data_out_b;
        wire    [2:0]                   ram_row_13_col_0_aary_pwren_b;
        wire                            ram_row_13_col_0_vcc = 1'b1;
        
        
        ip783rfhs2r2w256x34s0c1p1d0_dft_wrp #(
                    )
        ram_row_13_col_0 (
                    //------------------------------------------------------------
                    // Functional Interfaces
                    //------------------------------------------------------------      
        
                     .CLKWR_P0                (ram_row_13_col_0_clk_a),
                     .ADRWR_P0                (ADRWR_P0_ts4),
                     .WREN_P0                 (WREN_P0_ts4),
                     .DIN_P0                  (DIN_P0_ts4),
        
                     .CLKWR_P1                (ram_row_13_col_0_clk_b),
                     .ADRWR_P1                (ADRWR_P1_ts4),
                     .WREN_P1                 (WREN_P1_ts4),
                     .DIN_P1                  (DIN_P1_ts4),
        
                     .CLKRD_P0                (ram_row_13_col_0_clk_a),
                     .ADRRD_P0                (ADRRD_P0_ts4),
                     .RDEN_P0                 (RDEN_P0_ts4),
                     .QOUT_P0                 (ram_row_13_col_0_data_out_a),
                         
                     .CLKRD_P1                (ram_row_13_col_0_clk_b),
                     .ADRRD_P1                (ADRRD_P1_ts4),
                     .RDEN_P1                 (RDEN_P1_ts4),
                     .QOUT_P1                 (ram_row_13_col_0_data_out_b),                
                                                     
                    
                   //-------------------------------------------------------------
                   // Power Management Interfaces
                   //-------------------------------------------------------------
                  //   .PWR_MGMT_IN                        ({pwr_mgmt_in_rf[PWR_MGMT_IN_SIZE-1:1],ram_fary_pwren_b[13]}), // MSB changed from 3'b100
                  //   .PWR_MGMT_OUT                       (ram_aary_pwren_b[13]),  
                
                       
                     `ifndef INTEL_NO_PWR_PINS
                        .vddp                            (ram_row_13_col_0_vcc),
                        `ifdef INTC_ADD_VSS
                        .vss                            (1'b0),
                        `endif  
                     `endif
               
        
        
        
                      //REPAIR INPUTS
        
                    .FCA           (ram_row_13_col_0_bisr_inst_Q[6:1]), // column repair addres --- > F means faulty
                    .CRE          (ram_row_13_col_0_bisr_inst_Q[0]), //Column repair enable
                    
        
                    // POWER MGMT inputs
                    //.ROP_SD             (), // shutoffout
                    //.ROP_DS             (), //dpslp_or_shutoffout
                    //TEMPCOMMENT1.MPMS              (1'b0), // {shutoff,deepsleep,fastsleep}
        
                    //TIMING and TRIM
                    // MDST = {async_reset0,async_reset1,wmce,mce,stbyp,rmce}
                    .MDST_hs2r2w       ({fary_ffuse_rfhs2r2w_trim[9],fary_ffuse_rfhs2r2w_trim[8],fary_ffuse_rfhs2r2w_trim[7:5],fary_ffuse_rfhs2r2w_trim[4],fary_ffuse_rfhs2r2w_trim[3],fary_ffuse_rfhs2r2w_trim[2:0]}),
                                        
        
                    //DFT inputs
                    .DFTSHIFTEN        (DFTSHIFTEN),
                    .DFTMASK           (DFTMASK),
                    .DFT_ARRAY_FREEZE    (DFT_ARRAY_FREEZE),
                    
                    .DFT_AFD_RESET_B    (DFT_AFD_RESET_B)
        
        
        
        );//ip783rfhs2r2w256x34s0c1p1d0_dft_wrp
        
        assign          ram_rd_data_a_col[13][0]    = ram_row_13_col_0_data_out_a;
        assign          ram_rd_data_b_col[13][0]    = ram_row_13_col_0_data_out_b;
        
             

        wire                            ram_row_14_col_0_clk_a       = clk_a;
        wire                            ram_row_14_col_0_clk_b       = clk_b;
        wire    [8-1:0]       ram_row_14_col_0_wr_adr_a    = ram_row_wr_adr_a[14][8-1:0];
        wire    [8-1:0]       ram_row_14_col_0_wr_adr_b    = ram_row_wr_adr_b[14][8-1:0];
        wire    [8-1:0]       ram_row_14_col_0_rd_adr_a    = ram_row_rd_adr_a[14][8-1:0];
        wire    [8-1:0]       ram_row_14_col_0_rd_adr_b    = ram_row_rd_adr_b[14][8-1:0];
        wire                            ram_row_14_col_0_rd_en_a     = ram_row_rd_en_a[14];
        wire                            ram_row_14_col_0_rd_en_b     = ram_row_rd_en_b[14];
        wire                            ram_row_14_col_0_wr_en_a     = |ram_col_wr_en_a[14][0];
        wire                            ram_row_14_col_0_wr_en_b     = |ram_col_wr_en_b[14][0];
        wire    [34-1:0]              ram_row_14_col_0_data_in_a   = ram_wr_data_a_col[0][34-1:0];
        wire    [34-1:0]              ram_row_14_col_0_data_in_b   = ram_wr_data_b_col[0][34-1:0];
        wire    [34-1:0]              ram_row_14_col_0_data_out_a;
        wire    [34-1:0]              ram_row_14_col_0_data_out_b;
        wire    [2:0]                   ram_row_14_col_0_aary_pwren_b;
        wire                            ram_row_14_col_0_vcc = 1'b1;
        
        
        ip783rfhs2r2w256x34s0c1p1d0_dft_wrp #(
                    )
        ram_row_14_col_0 (
                    //------------------------------------------------------------
                    // Functional Interfaces
                    //------------------------------------------------------------      
        
                     .CLKWR_P0                (ram_row_14_col_0_clk_a),
                     .ADRWR_P0                (ADRWR_P0_ts5),
                     .WREN_P0                 (WREN_P0_ts5),
                     .DIN_P0                  (DIN_P0_ts5),
        
                     .CLKWR_P1                (ram_row_14_col_0_clk_b),
                     .ADRWR_P1                (ADRWR_P1_ts5),
                     .WREN_P1                 (WREN_P1_ts5),
                     .DIN_P1                  (DIN_P1_ts5),
        
                     .CLKRD_P0                (ram_row_14_col_0_clk_a),
                     .ADRRD_P0                (ADRRD_P0_ts5),
                     .RDEN_P0                 (RDEN_P0_ts5),
                     .QOUT_P0                 (ram_row_14_col_0_data_out_a),
                         
                     .CLKRD_P1                (ram_row_14_col_0_clk_b),
                     .ADRRD_P1                (ADRRD_P1_ts5),
                     .RDEN_P1                 (RDEN_P1_ts5),
                     .QOUT_P1                 (ram_row_14_col_0_data_out_b),                
                                                     
                    
                   //-------------------------------------------------------------
                   // Power Management Interfaces
                   //-------------------------------------------------------------
                  //   .PWR_MGMT_IN                        ({pwr_mgmt_in_rf[PWR_MGMT_IN_SIZE-1:1],ram_fary_pwren_b[14]}), // MSB changed from 3'b100
                  //   .PWR_MGMT_OUT                       (ram_aary_pwren_b[14]),  
                
                       
                     `ifndef INTEL_NO_PWR_PINS
                        .vddp                            (ram_row_14_col_0_vcc),
                        `ifdef INTC_ADD_VSS
                        .vss                            (1'b0),
                        `endif  
                     `endif
               
        
        
        
                      //REPAIR INPUTS
        
                    .FCA           (ram_row_14_col_0_bisr_inst_Q[6:1]), // column repair addres --- > F means faulty
                    .CRE          (ram_row_14_col_0_bisr_inst_Q[0]), //Column repair enable
                    
        
                    // POWER MGMT inputs
                    //.ROP_SD             (), // shutoffout
                    //.ROP_DS             (), //dpslp_or_shutoffout
                    //TEMPCOMMENT1.MPMS              (1'b0), // {shutoff,deepsleep,fastsleep}
        
                    //TIMING and TRIM
                    // MDST = {async_reset0,async_reset1,wmce,mce,stbyp,rmce}
                    .MDST_hs2r2w       ({fary_ffuse_rfhs2r2w_trim[9],fary_ffuse_rfhs2r2w_trim[8],fary_ffuse_rfhs2r2w_trim[7:5],fary_ffuse_rfhs2r2w_trim[4],fary_ffuse_rfhs2r2w_trim[3],fary_ffuse_rfhs2r2w_trim[2:0]}),
                                        
        
                    //DFT inputs
                    .DFTSHIFTEN        (DFTSHIFTEN),
                    .DFTMASK           (DFTMASK),
                    .DFT_ARRAY_FREEZE    (DFT_ARRAY_FREEZE),
                    
                    .DFT_AFD_RESET_B    (DFT_AFD_RESET_B)
        
        
        
        );//ip783rfhs2r2w256x34s0c1p1d0_dft_wrp
        
        assign          ram_rd_data_a_col[14][0]    = ram_row_14_col_0_data_out_a;
        assign          ram_rd_data_b_col[14][0]    = ram_row_14_col_0_data_out_b;
        
             

        wire                            ram_row_15_col_0_clk_a       = clk_a;
        wire                            ram_row_15_col_0_clk_b       = clk_b;
        wire    [8-1:0]       ram_row_15_col_0_wr_adr_a    = ram_row_wr_adr_a[15][8-1:0];
        wire    [8-1:0]       ram_row_15_col_0_wr_adr_b    = ram_row_wr_adr_b[15][8-1:0];
        wire    [8-1:0]       ram_row_15_col_0_rd_adr_a    = ram_row_rd_adr_a[15][8-1:0];
        wire    [8-1:0]       ram_row_15_col_0_rd_adr_b    = ram_row_rd_adr_b[15][8-1:0];
        wire                            ram_row_15_col_0_rd_en_a     = ram_row_rd_en_a[15];
        wire                            ram_row_15_col_0_rd_en_b     = ram_row_rd_en_b[15];
        wire                            ram_row_15_col_0_wr_en_a     = |ram_col_wr_en_a[15][0];
        wire                            ram_row_15_col_0_wr_en_b     = |ram_col_wr_en_b[15][0];
        wire    [34-1:0]              ram_row_15_col_0_data_in_a   = ram_wr_data_a_col[0][34-1:0];
        wire    [34-1:0]              ram_row_15_col_0_data_in_b   = ram_wr_data_b_col[0][34-1:0];
        wire    [34-1:0]              ram_row_15_col_0_data_out_a;
        wire    [34-1:0]              ram_row_15_col_0_data_out_b;
        wire    [2:0]                   ram_row_15_col_0_aary_pwren_b;
        wire                            ram_row_15_col_0_vcc = 1'b1;
        
        
        ip783rfhs2r2w256x34s0c1p1d0_dft_wrp #(
                    )
        ram_row_15_col_0 (
                    //------------------------------------------------------------
                    // Functional Interfaces
                    //------------------------------------------------------------      
        
                     .CLKWR_P0                (ram_row_15_col_0_clk_a),
                     .ADRWR_P0                (ADRWR_P0_ts6),
                     .WREN_P0                 (WREN_P0_ts6),
                     .DIN_P0                  (DIN_P0_ts6),
        
                     .CLKWR_P1                (ram_row_15_col_0_clk_b),
                     .ADRWR_P1                (ADRWR_P1_ts6),
                     .WREN_P1                 (WREN_P1_ts6),
                     .DIN_P1                  (DIN_P1_ts6),
        
                     .CLKRD_P0                (ram_row_15_col_0_clk_a),
                     .ADRRD_P0                (ADRRD_P0_ts6),
                     .RDEN_P0                 (RDEN_P0_ts6),
                     .QOUT_P0                 (ram_row_15_col_0_data_out_a),
                         
                     .CLKRD_P1                (ram_row_15_col_0_clk_b),
                     .ADRRD_P1                (ADRRD_P1_ts6),
                     .RDEN_P1                 (RDEN_P1_ts6),
                     .QOUT_P1                 (ram_row_15_col_0_data_out_b),                
                                                     
                    
                   //-------------------------------------------------------------
                   // Power Management Interfaces
                   //-------------------------------------------------------------
                  //   .PWR_MGMT_IN                        ({pwr_mgmt_in_rf[PWR_MGMT_IN_SIZE-1:1],ram_fary_pwren_b[15]}), // MSB changed from 3'b100
                  //   .PWR_MGMT_OUT                       (ram_aary_pwren_b[15]),  
                
                       
                     `ifndef INTEL_NO_PWR_PINS
                        .vddp                            (ram_row_15_col_0_vcc),
                        `ifdef INTC_ADD_VSS
                        .vss                            (1'b0),
                        `endif  
                     `endif
               
        
        
        
                      //REPAIR INPUTS
        
                    .FCA           (ram_row_15_col_0_bisr_inst_Q[6:1]), // column repair addres --- > F means faulty
                    .CRE          (ram_row_15_col_0_bisr_inst_Q[0]), //Column repair enable
                    
        
                    // POWER MGMT inputs
                    //.ROP_SD             (), // shutoffout
                    //.ROP_DS             (), //dpslp_or_shutoffout
                    //TEMPCOMMENT1.MPMS              (1'b0), // {shutoff,deepsleep,fastsleep}
        
                    //TIMING and TRIM
                    // MDST = {async_reset0,async_reset1,wmce,mce,stbyp,rmce}
                    .MDST_hs2r2w       ({fary_ffuse_rfhs2r2w_trim[9],fary_ffuse_rfhs2r2w_trim[8],fary_ffuse_rfhs2r2w_trim[7:5],fary_ffuse_rfhs2r2w_trim[4],fary_ffuse_rfhs2r2w_trim[3],fary_ffuse_rfhs2r2w_trim[2:0]}),
                                        
        
                    //DFT inputs
                    .DFTSHIFTEN        (DFTSHIFTEN),
                    .DFTMASK           (DFTMASK),
                    .DFT_ARRAY_FREEZE    (DFT_ARRAY_FREEZE),
                    
                    .DFT_AFD_RESET_B    (DFT_AFD_RESET_B)
        
        
        
        );//ip783rfhs2r2w256x34s0c1p1d0_dft_wrp
        
        assign          ram_rd_data_a_col[15][0]    = ram_row_15_col_0_data_out_a;
        assign          ram_rd_data_b_col[15][0]    = ram_row_15_col_0_data_out_b;
        
             

        wire                            ram_row_16_col_0_clk_a       = clk_a;
        wire                            ram_row_16_col_0_clk_b       = clk_b;
        wire    [8-1:0]       ram_row_16_col_0_wr_adr_a    = ram_row_wr_adr_a[16][8-1:0];
        wire    [8-1:0]       ram_row_16_col_0_wr_adr_b    = ram_row_wr_adr_b[16][8-1:0];
        wire    [8-1:0]       ram_row_16_col_0_rd_adr_a    = ram_row_rd_adr_a[16][8-1:0];
        wire    [8-1:0]       ram_row_16_col_0_rd_adr_b    = ram_row_rd_adr_b[16][8-1:0];
        wire                            ram_row_16_col_0_rd_en_a     = ram_row_rd_en_a[16];
        wire                            ram_row_16_col_0_rd_en_b     = ram_row_rd_en_b[16];
        wire                            ram_row_16_col_0_wr_en_a     = |ram_col_wr_en_a[16][0];
        wire                            ram_row_16_col_0_wr_en_b     = |ram_col_wr_en_b[16][0];
        wire    [34-1:0]              ram_row_16_col_0_data_in_a   = ram_wr_data_a_col[0][34-1:0];
        wire    [34-1:0]              ram_row_16_col_0_data_in_b   = ram_wr_data_b_col[0][34-1:0];
        wire    [34-1:0]              ram_row_16_col_0_data_out_a;
        wire    [34-1:0]              ram_row_16_col_0_data_out_b;
        wire    [2:0]                   ram_row_16_col_0_aary_pwren_b;
        wire                            ram_row_16_col_0_vcc = 1'b1;
        
        
        ip783rfhs2r2w256x34s0c1p1d0_dft_wrp #(
                    )
        ram_row_16_col_0 (
                    //------------------------------------------------------------
                    // Functional Interfaces
                    //------------------------------------------------------------      
        
                     .CLKWR_P0                (ram_row_16_col_0_clk_a),
                     .ADRWR_P0                (ADRWR_P0_ts7),
                     .WREN_P0                 (WREN_P0_ts7),
                     .DIN_P0                  (DIN_P0_ts7),
        
                     .CLKWR_P1                (ram_row_16_col_0_clk_b),
                     .ADRWR_P1                (ADRWR_P1_ts7),
                     .WREN_P1                 (WREN_P1_ts7),
                     .DIN_P1                  (DIN_P1_ts7),
        
                     .CLKRD_P0                (ram_row_16_col_0_clk_a),
                     .ADRRD_P0                (ADRRD_P0_ts7),
                     .RDEN_P0                 (RDEN_P0_ts7),
                     .QOUT_P0                 (ram_row_16_col_0_data_out_a),
                         
                     .CLKRD_P1                (ram_row_16_col_0_clk_b),
                     .ADRRD_P1                (ADRRD_P1_ts7),
                     .RDEN_P1                 (RDEN_P1_ts7),
                     .QOUT_P1                 (ram_row_16_col_0_data_out_b),                
                                                     
                    
                   //-------------------------------------------------------------
                   // Power Management Interfaces
                   //-------------------------------------------------------------
                  //   .PWR_MGMT_IN                        ({pwr_mgmt_in_rf[PWR_MGMT_IN_SIZE-1:1],ram_fary_pwren_b[16]}), // MSB changed from 3'b100
                  //   .PWR_MGMT_OUT                       (ram_aary_pwren_b[16]),  
                
                       
                     `ifndef INTEL_NO_PWR_PINS
                        .vddp                            (ram_row_16_col_0_vcc),
                        `ifdef INTC_ADD_VSS
                        .vss                            (1'b0),
                        `endif  
                     `endif
               
        
        
        
                      //REPAIR INPUTS
        
                    .FCA           (ram_row_16_col_0_bisr_inst_Q[6:1]), // column repair addres --- > F means faulty
                    .CRE          (ram_row_16_col_0_bisr_inst_Q[0]), //Column repair enable
                    
        
                    // POWER MGMT inputs
                    //.ROP_SD             (), // shutoffout
                    //.ROP_DS             (), //dpslp_or_shutoffout
                    //TEMPCOMMENT1.MPMS              (1'b0), // {shutoff,deepsleep,fastsleep}
        
                    //TIMING and TRIM
                    // MDST = {async_reset0,async_reset1,wmce,mce,stbyp,rmce}
                    .MDST_hs2r2w       ({fary_ffuse_rfhs2r2w_trim[9],fary_ffuse_rfhs2r2w_trim[8],fary_ffuse_rfhs2r2w_trim[7:5],fary_ffuse_rfhs2r2w_trim[4],fary_ffuse_rfhs2r2w_trim[3],fary_ffuse_rfhs2r2w_trim[2:0]}),
                                        
        
                    //DFT inputs
                    .DFTSHIFTEN        (DFTSHIFTEN),
                    .DFTMASK           (DFTMASK),
                    .DFT_ARRAY_FREEZE    (DFT_ARRAY_FREEZE),
                    
                    .DFT_AFD_RESET_B    (DFT_AFD_RESET_B)
        
        
        
        );//ip783rfhs2r2w256x34s0c1p1d0_dft_wrp
        
        assign          ram_rd_data_a_col[16][0]    = ram_row_16_col_0_data_out_a;
        assign          ram_rd_data_b_col[16][0]    = ram_row_16_col_0_data_out_b;
        
             

        wire                            ram_row_17_col_0_clk_a       = clk_a;
        wire                            ram_row_17_col_0_clk_b       = clk_b;
        wire    [8-1:0]       ram_row_17_col_0_wr_adr_a    = ram_row_wr_adr_a[17][8-1:0];
        wire    [8-1:0]       ram_row_17_col_0_wr_adr_b    = ram_row_wr_adr_b[17][8-1:0];
        wire    [8-1:0]       ram_row_17_col_0_rd_adr_a    = ram_row_rd_adr_a[17][8-1:0];
        wire    [8-1:0]       ram_row_17_col_0_rd_adr_b    = ram_row_rd_adr_b[17][8-1:0];
        wire                            ram_row_17_col_0_rd_en_a     = ram_row_rd_en_a[17];
        wire                            ram_row_17_col_0_rd_en_b     = ram_row_rd_en_b[17];
        wire                            ram_row_17_col_0_wr_en_a     = |ram_col_wr_en_a[17][0];
        wire                            ram_row_17_col_0_wr_en_b     = |ram_col_wr_en_b[17][0];
        wire    [34-1:0]              ram_row_17_col_0_data_in_a   = ram_wr_data_a_col[0][34-1:0];
        wire    [34-1:0]              ram_row_17_col_0_data_in_b   = ram_wr_data_b_col[0][34-1:0];
        wire    [34-1:0]              ram_row_17_col_0_data_out_a;
        wire    [34-1:0]              ram_row_17_col_0_data_out_b;
        wire    [2:0]                   ram_row_17_col_0_aary_pwren_b;
        wire                            ram_row_17_col_0_vcc = 1'b1;
        
        
        ip783rfhs2r2w256x34s0c1p1d0_dft_wrp #(
                    )
        ram_row_17_col_0 (
                    //------------------------------------------------------------
                    // Functional Interfaces
                    //------------------------------------------------------------      
        
                     .CLKWR_P0                (ram_row_17_col_0_clk_a),
                     .ADRWR_P0                (ADRWR_P0_ts8),
                     .WREN_P0                 (WREN_P0_ts8),
                     .DIN_P0                  (DIN_P0_ts8),
        
                     .CLKWR_P1                (ram_row_17_col_0_clk_b),
                     .ADRWR_P1                (ADRWR_P1_ts8),
                     .WREN_P1                 (WREN_P1_ts8),
                     .DIN_P1                  (DIN_P1_ts8),
        
                     .CLKRD_P0                (ram_row_17_col_0_clk_a),
                     .ADRRD_P0                (ADRRD_P0_ts8),
                     .RDEN_P0                 (RDEN_P0_ts8),
                     .QOUT_P0                 (ram_row_17_col_0_data_out_a),
                         
                     .CLKRD_P1                (ram_row_17_col_0_clk_b),
                     .ADRRD_P1                (ADRRD_P1_ts8),
                     .RDEN_P1                 (RDEN_P1_ts8),
                     .QOUT_P1                 (ram_row_17_col_0_data_out_b),                
                                                     
                    
                   //-------------------------------------------------------------
                   // Power Management Interfaces
                   //-------------------------------------------------------------
                  //   .PWR_MGMT_IN                        ({pwr_mgmt_in_rf[PWR_MGMT_IN_SIZE-1:1],ram_fary_pwren_b[17]}), // MSB changed from 3'b100
                  //   .PWR_MGMT_OUT                       (ram_aary_pwren_b[17]),  
                
                       
                     `ifndef INTEL_NO_PWR_PINS
                        .vddp                            (ram_row_17_col_0_vcc),
                        `ifdef INTC_ADD_VSS
                        .vss                            (1'b0),
                        `endif  
                     `endif
               
        
        
        
                      //REPAIR INPUTS
        
                    .FCA           (ram_row_17_col_0_bisr_inst_Q[6:1]), // column repair addres --- > F means faulty
                    .CRE          (ram_row_17_col_0_bisr_inst_Q[0]), //Column repair enable
                    
        
                    // POWER MGMT inputs
                    //.ROP_SD             (), // shutoffout
                    //.ROP_DS             (), //dpslp_or_shutoffout
                    //TEMPCOMMENT1.MPMS              (1'b0), // {shutoff,deepsleep,fastsleep}
        
                    //TIMING and TRIM
                    // MDST = {async_reset0,async_reset1,wmce,mce,stbyp,rmce}
                    .MDST_hs2r2w       ({fary_ffuse_rfhs2r2w_trim[9],fary_ffuse_rfhs2r2w_trim[8],fary_ffuse_rfhs2r2w_trim[7:5],fary_ffuse_rfhs2r2w_trim[4],fary_ffuse_rfhs2r2w_trim[3],fary_ffuse_rfhs2r2w_trim[2:0]}),
                                        
        
                    //DFT inputs
                    .DFTSHIFTEN        (DFTSHIFTEN),
                    .DFTMASK           (DFTMASK),
                    .DFT_ARRAY_FREEZE    (DFT_ARRAY_FREEZE),
                    
                    .DFT_AFD_RESET_B    (DFT_AFD_RESET_B)
        
        
        
        );//ip783rfhs2r2w256x34s0c1p1d0_dft_wrp
        
        assign          ram_rd_data_a_col[17][0]    = ram_row_17_col_0_data_out_a;
        assign          ram_rd_data_b_col[17][0]    = ram_row_17_col_0_data_out_b;
        
             

        wire                            ram_row_18_col_0_clk_a       = clk_a;
        wire                            ram_row_18_col_0_clk_b       = clk_b;
        wire    [8-1:0]       ram_row_18_col_0_wr_adr_a    = ram_row_wr_adr_a[18][8-1:0];
        wire    [8-1:0]       ram_row_18_col_0_wr_adr_b    = ram_row_wr_adr_b[18][8-1:0];
        wire    [8-1:0]       ram_row_18_col_0_rd_adr_a    = ram_row_rd_adr_a[18][8-1:0];
        wire    [8-1:0]       ram_row_18_col_0_rd_adr_b    = ram_row_rd_adr_b[18][8-1:0];
        wire                            ram_row_18_col_0_rd_en_a     = ram_row_rd_en_a[18];
        wire                            ram_row_18_col_0_rd_en_b     = ram_row_rd_en_b[18];
        wire                            ram_row_18_col_0_wr_en_a     = |ram_col_wr_en_a[18][0];
        wire                            ram_row_18_col_0_wr_en_b     = |ram_col_wr_en_b[18][0];
        wire    [34-1:0]              ram_row_18_col_0_data_in_a   = ram_wr_data_a_col[0][34-1:0];
        wire    [34-1:0]              ram_row_18_col_0_data_in_b   = ram_wr_data_b_col[0][34-1:0];
        wire    [34-1:0]              ram_row_18_col_0_data_out_a;
        wire    [34-1:0]              ram_row_18_col_0_data_out_b;
        wire    [2:0]                   ram_row_18_col_0_aary_pwren_b;
        wire                            ram_row_18_col_0_vcc = 1'b1;
        
        
        ip783rfhs2r2w256x34s0c1p1d0_dft_wrp #(
                    )
        ram_row_18_col_0 (
                    //------------------------------------------------------------
                    // Functional Interfaces
                    //------------------------------------------------------------      
        
                     .CLKWR_P0                (ram_row_18_col_0_clk_a),
                     .ADRWR_P0                (ADRWR_P0_ts9),
                     .WREN_P0                 (WREN_P0_ts9),
                     .DIN_P0                  (DIN_P0_ts9),
        
                     .CLKWR_P1                (ram_row_18_col_0_clk_b),
                     .ADRWR_P1                (ADRWR_P1_ts9),
                     .WREN_P1                 (WREN_P1_ts9),
                     .DIN_P1                  (DIN_P1_ts9),
        
                     .CLKRD_P0                (ram_row_18_col_0_clk_a),
                     .ADRRD_P0                (ADRRD_P0_ts9),
                     .RDEN_P0                 (RDEN_P0_ts9),
                     .QOUT_P0                 (ram_row_18_col_0_data_out_a),
                         
                     .CLKRD_P1                (ram_row_18_col_0_clk_b),
                     .ADRRD_P1                (ADRRD_P1_ts9),
                     .RDEN_P1                 (RDEN_P1_ts9),
                     .QOUT_P1                 (ram_row_18_col_0_data_out_b),                
                                                     
                    
                   //-------------------------------------------------------------
                   // Power Management Interfaces
                   //-------------------------------------------------------------
                  //   .PWR_MGMT_IN                        ({pwr_mgmt_in_rf[PWR_MGMT_IN_SIZE-1:1],ram_fary_pwren_b[18]}), // MSB changed from 3'b100
                  //   .PWR_MGMT_OUT                       (ram_aary_pwren_b[18]),  
                
                       
                     `ifndef INTEL_NO_PWR_PINS
                        .vddp                            (ram_row_18_col_0_vcc),
                        `ifdef INTC_ADD_VSS
                        .vss                            (1'b0),
                        `endif  
                     `endif
               
        
        
        
                      //REPAIR INPUTS
        
                    .FCA           (ram_row_18_col_0_bisr_inst_Q[6:1]), // column repair addres --- > F means faulty
                    .CRE          (ram_row_18_col_0_bisr_inst_Q[0]), //Column repair enable
                    
        
                    // POWER MGMT inputs
                    //.ROP_SD             (), // shutoffout
                    //.ROP_DS             (), //dpslp_or_shutoffout
                    //TEMPCOMMENT1.MPMS              (1'b0), // {shutoff,deepsleep,fastsleep}
        
                    //TIMING and TRIM
                    // MDST = {async_reset0,async_reset1,wmce,mce,stbyp,rmce}
                    .MDST_hs2r2w       ({fary_ffuse_rfhs2r2w_trim[9],fary_ffuse_rfhs2r2w_trim[8],fary_ffuse_rfhs2r2w_trim[7:5],fary_ffuse_rfhs2r2w_trim[4],fary_ffuse_rfhs2r2w_trim[3],fary_ffuse_rfhs2r2w_trim[2:0]}),
                                        
        
                    //DFT inputs
                    .DFTSHIFTEN        (DFTSHIFTEN),
                    .DFTMASK           (DFTMASK),
                    .DFT_ARRAY_FREEZE    (DFT_ARRAY_FREEZE),
                    
                    .DFT_AFD_RESET_B    (DFT_AFD_RESET_B)
        
        
        
        );//ip783rfhs2r2w256x34s0c1p1d0_dft_wrp
        
        assign          ram_rd_data_a_col[18][0]    = ram_row_18_col_0_data_out_a;
        assign          ram_rd_data_b_col[18][0]    = ram_row_18_col_0_data_out_b;
        
             

        wire                            ram_row_19_col_0_clk_a       = clk_a;
        wire                            ram_row_19_col_0_clk_b       = clk_b;
        wire    [8-1:0]       ram_row_19_col_0_wr_adr_a    = ram_row_wr_adr_a[19][8-1:0];
        wire    [8-1:0]       ram_row_19_col_0_wr_adr_b    = ram_row_wr_adr_b[19][8-1:0];
        wire    [8-1:0]       ram_row_19_col_0_rd_adr_a    = ram_row_rd_adr_a[19][8-1:0];
        wire    [8-1:0]       ram_row_19_col_0_rd_adr_b    = ram_row_rd_adr_b[19][8-1:0];
        wire                            ram_row_19_col_0_rd_en_a     = ram_row_rd_en_a[19];
        wire                            ram_row_19_col_0_rd_en_b     = ram_row_rd_en_b[19];
        wire                            ram_row_19_col_0_wr_en_a     = |ram_col_wr_en_a[19][0];
        wire                            ram_row_19_col_0_wr_en_b     = |ram_col_wr_en_b[19][0];
        wire    [34-1:0]              ram_row_19_col_0_data_in_a   = ram_wr_data_a_col[0][34-1:0];
        wire    [34-1:0]              ram_row_19_col_0_data_in_b   = ram_wr_data_b_col[0][34-1:0];
        wire    [34-1:0]              ram_row_19_col_0_data_out_a;
        wire    [34-1:0]              ram_row_19_col_0_data_out_b;
        wire    [2:0]                   ram_row_19_col_0_aary_pwren_b;
        wire                            ram_row_19_col_0_vcc = 1'b1;
        
        
        ip783rfhs2r2w256x34s0c1p1d0_dft_wrp #(
                    )
        ram_row_19_col_0 (
                    //------------------------------------------------------------
                    // Functional Interfaces
                    //------------------------------------------------------------      
        
                     .CLKWR_P0                (ram_row_19_col_0_clk_a),
                     .ADRWR_P0                (ADRWR_P0_ts10),
                     .WREN_P0                 (WREN_P0_ts10),
                     .DIN_P0                  (DIN_P0_ts10),
        
                     .CLKWR_P1                (ram_row_19_col_0_clk_b),
                     .ADRWR_P1                (ADRWR_P1_ts10),
                     .WREN_P1                 (WREN_P1_ts10),
                     .DIN_P1                  (DIN_P1_ts10),
        
                     .CLKRD_P0                (ram_row_19_col_0_clk_a),
                     .ADRRD_P0                (ADRRD_P0_ts10),
                     .RDEN_P0                 (RDEN_P0_ts10),
                     .QOUT_P0                 (ram_row_19_col_0_data_out_a),
                         
                     .CLKRD_P1                (ram_row_19_col_0_clk_b),
                     .ADRRD_P1                (ADRRD_P1_ts10),
                     .RDEN_P1                 (RDEN_P1_ts10),
                     .QOUT_P1                 (ram_row_19_col_0_data_out_b),                
                                                     
                    
                   //-------------------------------------------------------------
                   // Power Management Interfaces
                   //-------------------------------------------------------------
                  //   .PWR_MGMT_IN                        ({pwr_mgmt_in_rf[PWR_MGMT_IN_SIZE-1:1],ram_fary_pwren_b[19]}), // MSB changed from 3'b100
                  //   .PWR_MGMT_OUT                       (ram_aary_pwren_b[19]),  
                
                       
                     `ifndef INTEL_NO_PWR_PINS
                        .vddp                            (ram_row_19_col_0_vcc),
                        `ifdef INTC_ADD_VSS
                        .vss                            (1'b0),
                        `endif  
                     `endif
               
        
        
        
                      //REPAIR INPUTS
        
                    .FCA           (ram_row_19_col_0_bisr_inst_Q[6:1]), // column repair addres --- > F means faulty
                    .CRE          (ram_row_19_col_0_bisr_inst_Q[0]), //Column repair enable
                    
        
                    // POWER MGMT inputs
                    //.ROP_SD             (), // shutoffout
                    //.ROP_DS             (), //dpslp_or_shutoffout
                    //TEMPCOMMENT1.MPMS              (1'b0), // {shutoff,deepsleep,fastsleep}
        
                    //TIMING and TRIM
                    // MDST = {async_reset0,async_reset1,wmce,mce,stbyp,rmce}
                    .MDST_hs2r2w       ({fary_ffuse_rfhs2r2w_trim[9],fary_ffuse_rfhs2r2w_trim[8],fary_ffuse_rfhs2r2w_trim[7:5],fary_ffuse_rfhs2r2w_trim[4],fary_ffuse_rfhs2r2w_trim[3],fary_ffuse_rfhs2r2w_trim[2:0]}),
                                        
        
                    //DFT inputs
                    .DFTSHIFTEN        (DFTSHIFTEN),
                    .DFTMASK           (DFTMASK),
                    .DFT_ARRAY_FREEZE    (DFT_ARRAY_FREEZE),
                    
                    .DFT_AFD_RESET_B    (DFT_AFD_RESET_B)
        
        
        
        );//ip783rfhs2r2w256x34s0c1p1d0_dft_wrp
        
        assign          ram_rd_data_a_col[19][0]    = ram_row_19_col_0_data_out_a;
        assign          ram_rd_data_b_col[19][0]    = ram_row_19_col_0_data_out_b;
        
             

        wire                            ram_row_20_col_0_clk_a       = clk_a;
        wire                            ram_row_20_col_0_clk_b       = clk_b;
        wire    [8-1:0]       ram_row_20_col_0_wr_adr_a    = ram_row_wr_adr_a[20][8-1:0];
        wire    [8-1:0]       ram_row_20_col_0_wr_adr_b    = ram_row_wr_adr_b[20][8-1:0];
        wire    [8-1:0]       ram_row_20_col_0_rd_adr_a    = ram_row_rd_adr_a[20][8-1:0];
        wire    [8-1:0]       ram_row_20_col_0_rd_adr_b    = ram_row_rd_adr_b[20][8-1:0];
        wire                            ram_row_20_col_0_rd_en_a     = ram_row_rd_en_a[20];
        wire                            ram_row_20_col_0_rd_en_b     = ram_row_rd_en_b[20];
        wire                            ram_row_20_col_0_wr_en_a     = |ram_col_wr_en_a[20][0];
        wire                            ram_row_20_col_0_wr_en_b     = |ram_col_wr_en_b[20][0];
        wire    [34-1:0]              ram_row_20_col_0_data_in_a   = ram_wr_data_a_col[0][34-1:0];
        wire    [34-1:0]              ram_row_20_col_0_data_in_b   = ram_wr_data_b_col[0][34-1:0];
        wire    [34-1:0]              ram_row_20_col_0_data_out_a;
        wire    [34-1:0]              ram_row_20_col_0_data_out_b;
        wire    [2:0]                   ram_row_20_col_0_aary_pwren_b;
        wire                            ram_row_20_col_0_vcc = 1'b1;
        
        
        ip783rfhs2r2w256x34s0c1p1d0_dft_wrp #(
                    )
        ram_row_20_col_0 (
                    //------------------------------------------------------------
                    // Functional Interfaces
                    //------------------------------------------------------------      
        
                     .CLKWR_P0                (ram_row_20_col_0_clk_a),
                     .ADRWR_P0                (ADRWR_P0_ts12),
                     .WREN_P0                 (WREN_P0_ts12),
                     .DIN_P0                  (DIN_P0_ts12),
        
                     .CLKWR_P1                (ram_row_20_col_0_clk_b),
                     .ADRWR_P1                (ADRWR_P1_ts12),
                     .WREN_P1                 (WREN_P1_ts12),
                     .DIN_P1                  (DIN_P1_ts12),
        
                     .CLKRD_P0                (ram_row_20_col_0_clk_a),
                     .ADRRD_P0                (ADRRD_P0_ts12),
                     .RDEN_P0                 (RDEN_P0_ts12),
                     .QOUT_P0                 (ram_row_20_col_0_data_out_a),
                         
                     .CLKRD_P1                (ram_row_20_col_0_clk_b),
                     .ADRRD_P1                (ADRRD_P1_ts12),
                     .RDEN_P1                 (RDEN_P1_ts12),
                     .QOUT_P1                 (ram_row_20_col_0_data_out_b),                
                                                     
                    
                   //-------------------------------------------------------------
                   // Power Management Interfaces
                   //-------------------------------------------------------------
                  //   .PWR_MGMT_IN                        ({pwr_mgmt_in_rf[PWR_MGMT_IN_SIZE-1:1],ram_fary_pwren_b[20]}), // MSB changed from 3'b100
                  //   .PWR_MGMT_OUT                       (ram_aary_pwren_b[20]),  
                
                       
                     `ifndef INTEL_NO_PWR_PINS
                        .vddp                            (ram_row_20_col_0_vcc),
                        `ifdef INTC_ADD_VSS
                        .vss                            (1'b0),
                        `endif  
                     `endif
               
        
        
        
                      //REPAIR INPUTS
        
                    .FCA           (ram_row_20_col_0_bisr_inst_Q[6:1]), // column repair addres --- > F means faulty
                    .CRE          (ram_row_20_col_0_bisr_inst_Q[0]), //Column repair enable
                    
        
                    // POWER MGMT inputs
                    //.ROP_SD             (), // shutoffout
                    //.ROP_DS             (), //dpslp_or_shutoffout
                    //TEMPCOMMENT1.MPMS              (1'b0), // {shutoff,deepsleep,fastsleep}
        
                    //TIMING and TRIM
                    // MDST = {async_reset0,async_reset1,wmce,mce,stbyp,rmce}
                    .MDST_hs2r2w       ({fary_ffuse_rfhs2r2w_trim[9],fary_ffuse_rfhs2r2w_trim[8],fary_ffuse_rfhs2r2w_trim[7:5],fary_ffuse_rfhs2r2w_trim[4],fary_ffuse_rfhs2r2w_trim[3],fary_ffuse_rfhs2r2w_trim[2:0]}),
                                        
        
                    //DFT inputs
                    .DFTSHIFTEN        (DFTSHIFTEN),
                    .DFTMASK           (DFTMASK),
                    .DFT_ARRAY_FREEZE    (DFT_ARRAY_FREEZE),
                    
                    .DFT_AFD_RESET_B    (DFT_AFD_RESET_B)
        
        
        
        );//ip783rfhs2r2w256x34s0c1p1d0_dft_wrp
        
        assign          ram_rd_data_a_col[20][0]    = ram_row_20_col_0_data_out_a;
        assign          ram_rd_data_b_col[20][0]    = ram_row_20_col_0_data_out_b;
        
             

        wire                            ram_row_21_col_0_clk_a       = clk_a;
        wire                            ram_row_21_col_0_clk_b       = clk_b;
        wire    [8-1:0]       ram_row_21_col_0_wr_adr_a    = ram_row_wr_adr_a[21][8-1:0];
        wire    [8-1:0]       ram_row_21_col_0_wr_adr_b    = ram_row_wr_adr_b[21][8-1:0];
        wire    [8-1:0]       ram_row_21_col_0_rd_adr_a    = ram_row_rd_adr_a[21][8-1:0];
        wire    [8-1:0]       ram_row_21_col_0_rd_adr_b    = ram_row_rd_adr_b[21][8-1:0];
        wire                            ram_row_21_col_0_rd_en_a     = ram_row_rd_en_a[21];
        wire                            ram_row_21_col_0_rd_en_b     = ram_row_rd_en_b[21];
        wire                            ram_row_21_col_0_wr_en_a     = |ram_col_wr_en_a[21][0];
        wire                            ram_row_21_col_0_wr_en_b     = |ram_col_wr_en_b[21][0];
        wire    [34-1:0]              ram_row_21_col_0_data_in_a   = ram_wr_data_a_col[0][34-1:0];
        wire    [34-1:0]              ram_row_21_col_0_data_in_b   = ram_wr_data_b_col[0][34-1:0];
        wire    [34-1:0]              ram_row_21_col_0_data_out_a;
        wire    [34-1:0]              ram_row_21_col_0_data_out_b;
        wire    [2:0]                   ram_row_21_col_0_aary_pwren_b;
        wire                            ram_row_21_col_0_vcc = 1'b1;
        
        
        ip783rfhs2r2w256x34s0c1p1d0_dft_wrp #(
                    )
        ram_row_21_col_0 (
                    //------------------------------------------------------------
                    // Functional Interfaces
                    //------------------------------------------------------------      
        
                     .CLKWR_P0                (ram_row_21_col_0_clk_a),
                     .ADRWR_P0                (ADRWR_P0_ts13),
                     .WREN_P0                 (WREN_P0_ts13),
                     .DIN_P0                  (DIN_P0_ts13),
        
                     .CLKWR_P1                (ram_row_21_col_0_clk_b),
                     .ADRWR_P1                (ADRWR_P1_ts13),
                     .WREN_P1                 (WREN_P1_ts13),
                     .DIN_P1                  (DIN_P1_ts13),
        
                     .CLKRD_P0                (ram_row_21_col_0_clk_a),
                     .ADRRD_P0                (ADRRD_P0_ts13),
                     .RDEN_P0                 (RDEN_P0_ts13),
                     .QOUT_P0                 (ram_row_21_col_0_data_out_a),
                         
                     .CLKRD_P1                (ram_row_21_col_0_clk_b),
                     .ADRRD_P1                (ADRRD_P1_ts13),
                     .RDEN_P1                 (RDEN_P1_ts13),
                     .QOUT_P1                 (ram_row_21_col_0_data_out_b),                
                                                     
                    
                   //-------------------------------------------------------------
                   // Power Management Interfaces
                   //-------------------------------------------------------------
                  //   .PWR_MGMT_IN                        ({pwr_mgmt_in_rf[PWR_MGMT_IN_SIZE-1:1],ram_fary_pwren_b[21]}), // MSB changed from 3'b100
                  //   .PWR_MGMT_OUT                       (ram_aary_pwren_b[21]),  
                
                       
                     `ifndef INTEL_NO_PWR_PINS
                        .vddp                            (ram_row_21_col_0_vcc),
                        `ifdef INTC_ADD_VSS
                        .vss                            (1'b0),
                        `endif  
                     `endif
               
        
        
        
                      //REPAIR INPUTS
        
                    .FCA           (ram_row_21_col_0_bisr_inst_Q[6:1]), // column repair addres --- > F means faulty
                    .CRE          (ram_row_21_col_0_bisr_inst_Q[0]), //Column repair enable
                    
        
                    // POWER MGMT inputs
                    //.ROP_SD             (), // shutoffout
                    //.ROP_DS             (), //dpslp_or_shutoffout
                    //TEMPCOMMENT1.MPMS              (1'b0), // {shutoff,deepsleep,fastsleep}
        
                    //TIMING and TRIM
                    // MDST = {async_reset0,async_reset1,wmce,mce,stbyp,rmce}
                    .MDST_hs2r2w       ({fary_ffuse_rfhs2r2w_trim[9],fary_ffuse_rfhs2r2w_trim[8],fary_ffuse_rfhs2r2w_trim[7:5],fary_ffuse_rfhs2r2w_trim[4],fary_ffuse_rfhs2r2w_trim[3],fary_ffuse_rfhs2r2w_trim[2:0]}),
                                        
        
                    //DFT inputs
                    .DFTSHIFTEN        (DFTSHIFTEN),
                    .DFTMASK           (DFTMASK),
                    .DFT_ARRAY_FREEZE    (DFT_ARRAY_FREEZE),
                    
                    .DFT_AFD_RESET_B    (DFT_AFD_RESET_B)
        
        
        
        );//ip783rfhs2r2w256x34s0c1p1d0_dft_wrp
        
        assign          ram_rd_data_a_col[21][0]    = ram_row_21_col_0_data_out_a;
        assign          ram_rd_data_b_col[21][0]    = ram_row_21_col_0_data_out_b;
        
             

        wire                            ram_row_22_col_0_clk_a       = clk_a;
        wire                            ram_row_22_col_0_clk_b       = clk_b;
        wire    [8-1:0]       ram_row_22_col_0_wr_adr_a    = ram_row_wr_adr_a[22][8-1:0];
        wire    [8-1:0]       ram_row_22_col_0_wr_adr_b    = ram_row_wr_adr_b[22][8-1:0];
        wire    [8-1:0]       ram_row_22_col_0_rd_adr_a    = ram_row_rd_adr_a[22][8-1:0];
        wire    [8-1:0]       ram_row_22_col_0_rd_adr_b    = ram_row_rd_adr_b[22][8-1:0];
        wire                            ram_row_22_col_0_rd_en_a     = ram_row_rd_en_a[22];
        wire                            ram_row_22_col_0_rd_en_b     = ram_row_rd_en_b[22];
        wire                            ram_row_22_col_0_wr_en_a     = |ram_col_wr_en_a[22][0];
        wire                            ram_row_22_col_0_wr_en_b     = |ram_col_wr_en_b[22][0];
        wire    [34-1:0]              ram_row_22_col_0_data_in_a   = ram_wr_data_a_col[0][34-1:0];
        wire    [34-1:0]              ram_row_22_col_0_data_in_b   = ram_wr_data_b_col[0][34-1:0];
        wire    [34-1:0]              ram_row_22_col_0_data_out_a;
        wire    [34-1:0]              ram_row_22_col_0_data_out_b;
        wire    [2:0]                   ram_row_22_col_0_aary_pwren_b;
        wire                            ram_row_22_col_0_vcc = 1'b1;
        
        
        ip783rfhs2r2w256x34s0c1p1d0_dft_wrp #(
                    )
        ram_row_22_col_0 (
                    //------------------------------------------------------------
                    // Functional Interfaces
                    //------------------------------------------------------------      
        
                     .CLKWR_P0                (ram_row_22_col_0_clk_a),
                     .ADRWR_P0                (ADRWR_P0_ts14),
                     .WREN_P0                 (WREN_P0_ts14),
                     .DIN_P0                  (DIN_P0_ts14),
        
                     .CLKWR_P1                (ram_row_22_col_0_clk_b),
                     .ADRWR_P1                (ADRWR_P1_ts14),
                     .WREN_P1                 (WREN_P1_ts14),
                     .DIN_P1                  (DIN_P1_ts14),
        
                     .CLKRD_P0                (ram_row_22_col_0_clk_a),
                     .ADRRD_P0                (ADRRD_P0_ts14),
                     .RDEN_P0                 (RDEN_P0_ts14),
                     .QOUT_P0                 (ram_row_22_col_0_data_out_a),
                         
                     .CLKRD_P1                (ram_row_22_col_0_clk_b),
                     .ADRRD_P1                (ADRRD_P1_ts14),
                     .RDEN_P1                 (RDEN_P1_ts14),
                     .QOUT_P1                 (ram_row_22_col_0_data_out_b),                
                                                     
                    
                   //-------------------------------------------------------------
                   // Power Management Interfaces
                   //-------------------------------------------------------------
                  //   .PWR_MGMT_IN                        ({pwr_mgmt_in_rf[PWR_MGMT_IN_SIZE-1:1],ram_fary_pwren_b[22]}), // MSB changed from 3'b100
                  //   .PWR_MGMT_OUT                       (ram_aary_pwren_b[22]),  
                
                       
                     `ifndef INTEL_NO_PWR_PINS
                        .vddp                            (ram_row_22_col_0_vcc),
                        `ifdef INTC_ADD_VSS
                        .vss                            (1'b0),
                        `endif  
                     `endif
               
        
        
        
                      //REPAIR INPUTS
        
                    .FCA           (ram_row_22_col_0_bisr_inst_Q[6:1]), // column repair addres --- > F means faulty
                    .CRE          (ram_row_22_col_0_bisr_inst_Q[0]), //Column repair enable
                    
        
                    // POWER MGMT inputs
                    //.ROP_SD             (), // shutoffout
                    //.ROP_DS             (), //dpslp_or_shutoffout
                    //TEMPCOMMENT1.MPMS              (1'b0), // {shutoff,deepsleep,fastsleep}
        
                    //TIMING and TRIM
                    // MDST = {async_reset0,async_reset1,wmce,mce,stbyp,rmce}
                    .MDST_hs2r2w       ({fary_ffuse_rfhs2r2w_trim[9],fary_ffuse_rfhs2r2w_trim[8],fary_ffuse_rfhs2r2w_trim[7:5],fary_ffuse_rfhs2r2w_trim[4],fary_ffuse_rfhs2r2w_trim[3],fary_ffuse_rfhs2r2w_trim[2:0]}),
                                        
        
                    //DFT inputs
                    .DFTSHIFTEN        (DFTSHIFTEN),
                    .DFTMASK           (DFTMASK),
                    .DFT_ARRAY_FREEZE    (DFT_ARRAY_FREEZE),
                    
                    .DFT_AFD_RESET_B    (DFT_AFD_RESET_B)
        
        
        
        );//ip783rfhs2r2w256x34s0c1p1d0_dft_wrp
        
        assign          ram_rd_data_a_col[22][0]    = ram_row_22_col_0_data_out_a;
        assign          ram_rd_data_b_col[22][0]    = ram_row_22_col_0_data_out_b;
        
             

        wire                            ram_row_23_col_0_clk_a       = clk_a;
        wire                            ram_row_23_col_0_clk_b       = clk_b;
        wire    [8-1:0]       ram_row_23_col_0_wr_adr_a    = ram_row_wr_adr_a[23][8-1:0];
        wire    [8-1:0]       ram_row_23_col_0_wr_adr_b    = ram_row_wr_adr_b[23][8-1:0];
        wire    [8-1:0]       ram_row_23_col_0_rd_adr_a    = ram_row_rd_adr_a[23][8-1:0];
        wire    [8-1:0]       ram_row_23_col_0_rd_adr_b    = ram_row_rd_adr_b[23][8-1:0];
        wire                            ram_row_23_col_0_rd_en_a     = ram_row_rd_en_a[23];
        wire                            ram_row_23_col_0_rd_en_b     = ram_row_rd_en_b[23];
        wire                            ram_row_23_col_0_wr_en_a     = |ram_col_wr_en_a[23][0];
        wire                            ram_row_23_col_0_wr_en_b     = |ram_col_wr_en_b[23][0];
        wire    [34-1:0]              ram_row_23_col_0_data_in_a   = ram_wr_data_a_col[0][34-1:0];
        wire    [34-1:0]              ram_row_23_col_0_data_in_b   = ram_wr_data_b_col[0][34-1:0];
        wire    [34-1:0]              ram_row_23_col_0_data_out_a;
        wire    [34-1:0]              ram_row_23_col_0_data_out_b;
        wire    [2:0]                   ram_row_23_col_0_aary_pwren_b;
        wire                            ram_row_23_col_0_vcc = 1'b1;
        
        
        ip783rfhs2r2w256x34s0c1p1d0_dft_wrp #(
                    )
        ram_row_23_col_0 (
                    //------------------------------------------------------------
                    // Functional Interfaces
                    //------------------------------------------------------------      
        
                     .CLKWR_P0                (ram_row_23_col_0_clk_a),
                     .ADRWR_P0                (ADRWR_P0_ts15),
                     .WREN_P0                 (WREN_P0_ts15),
                     .DIN_P0                  (DIN_P0_ts15),
        
                     .CLKWR_P1                (ram_row_23_col_0_clk_b),
                     .ADRWR_P1                (ADRWR_P1_ts15),
                     .WREN_P1                 (WREN_P1_ts15),
                     .DIN_P1                  (DIN_P1_ts15),
        
                     .CLKRD_P0                (ram_row_23_col_0_clk_a),
                     .ADRRD_P0                (ADRRD_P0_ts15),
                     .RDEN_P0                 (RDEN_P0_ts15),
                     .QOUT_P0                 (ram_row_23_col_0_data_out_a),
                         
                     .CLKRD_P1                (ram_row_23_col_0_clk_b),
                     .ADRRD_P1                (ADRRD_P1_ts15),
                     .RDEN_P1                 (RDEN_P1_ts15),
                     .QOUT_P1                 (ram_row_23_col_0_data_out_b),                
                                                     
                    
                   //-------------------------------------------------------------
                   // Power Management Interfaces
                   //-------------------------------------------------------------
                  //   .PWR_MGMT_IN                        ({pwr_mgmt_in_rf[PWR_MGMT_IN_SIZE-1:1],ram_fary_pwren_b[23]}), // MSB changed from 3'b100
                  //   .PWR_MGMT_OUT                       (ram_aary_pwren_b[23]),  
                
                       
                     `ifndef INTEL_NO_PWR_PINS
                        .vddp                            (ram_row_23_col_0_vcc),
                        `ifdef INTC_ADD_VSS
                        .vss                            (1'b0),
                        `endif  
                     `endif
               
        
        
        
                      //REPAIR INPUTS
        
                    .FCA           (ram_row_23_col_0_bisr_inst_Q[6:1]), // column repair addres --- > F means faulty
                    .CRE          (ram_row_23_col_0_bisr_inst_Q[0]), //Column repair enable
                    
        
                    // POWER MGMT inputs
                    //.ROP_SD             (), // shutoffout
                    //.ROP_DS             (), //dpslp_or_shutoffout
                    //TEMPCOMMENT1.MPMS              (1'b0), // {shutoff,deepsleep,fastsleep}
        
                    //TIMING and TRIM
                    // MDST = {async_reset0,async_reset1,wmce,mce,stbyp,rmce}
                    .MDST_hs2r2w       ({fary_ffuse_rfhs2r2w_trim[9],fary_ffuse_rfhs2r2w_trim[8],fary_ffuse_rfhs2r2w_trim[7:5],fary_ffuse_rfhs2r2w_trim[4],fary_ffuse_rfhs2r2w_trim[3],fary_ffuse_rfhs2r2w_trim[2:0]}),
                                        
        
                    //DFT inputs
                    .DFTSHIFTEN        (DFTSHIFTEN),
                    .DFTMASK           (DFTMASK),
                    .DFT_ARRAY_FREEZE    (DFT_ARRAY_FREEZE),
                    
                    .DFT_AFD_RESET_B    (DFT_AFD_RESET_B)
        
        
        
        );//ip783rfhs2r2w256x34s0c1p1d0_dft_wrp
        
        assign          ram_rd_data_a_col[23][0]    = ram_row_23_col_0_data_out_a;
        assign          ram_rd_data_b_col[23][0]    = ram_row_23_col_0_data_out_b;
        
             

        wire                            ram_row_24_col_0_clk_a       = clk_a;
        wire                            ram_row_24_col_0_clk_b       = clk_b;
        wire    [8-1:0]       ram_row_24_col_0_wr_adr_a    = ram_row_wr_adr_a[24][8-1:0];
        wire    [8-1:0]       ram_row_24_col_0_wr_adr_b    = ram_row_wr_adr_b[24][8-1:0];
        wire    [8-1:0]       ram_row_24_col_0_rd_adr_a    = ram_row_rd_adr_a[24][8-1:0];
        wire    [8-1:0]       ram_row_24_col_0_rd_adr_b    = ram_row_rd_adr_b[24][8-1:0];
        wire                            ram_row_24_col_0_rd_en_a     = ram_row_rd_en_a[24];
        wire                            ram_row_24_col_0_rd_en_b     = ram_row_rd_en_b[24];
        wire                            ram_row_24_col_0_wr_en_a     = |ram_col_wr_en_a[24][0];
        wire                            ram_row_24_col_0_wr_en_b     = |ram_col_wr_en_b[24][0];
        wire    [34-1:0]              ram_row_24_col_0_data_in_a   = ram_wr_data_a_col[0][34-1:0];
        wire    [34-1:0]              ram_row_24_col_0_data_in_b   = ram_wr_data_b_col[0][34-1:0];
        wire    [34-1:0]              ram_row_24_col_0_data_out_a;
        wire    [34-1:0]              ram_row_24_col_0_data_out_b;
        wire    [2:0]                   ram_row_24_col_0_aary_pwren_b;
        wire                            ram_row_24_col_0_vcc = 1'b1;
        
        
        ip783rfhs2r2w256x34s0c1p1d0_dft_wrp #(
                    )
        ram_row_24_col_0 (
                    //------------------------------------------------------------
                    // Functional Interfaces
                    //------------------------------------------------------------      
        
                     .CLKWR_P0                (ram_row_24_col_0_clk_a),
                     .ADRWR_P0                (ADRWR_P0_ts16),
                     .WREN_P0                 (WREN_P0_ts16),
                     .DIN_P0                  (DIN_P0_ts16),
        
                     .CLKWR_P1                (ram_row_24_col_0_clk_b),
                     .ADRWR_P1                (ADRWR_P1_ts16),
                     .WREN_P1                 (WREN_P1_ts16),
                     .DIN_P1                  (DIN_P1_ts16),
        
                     .CLKRD_P0                (ram_row_24_col_0_clk_a),
                     .ADRRD_P0                (ADRRD_P0_ts16),
                     .RDEN_P0                 (RDEN_P0_ts16),
                     .QOUT_P0                 (ram_row_24_col_0_data_out_a),
                         
                     .CLKRD_P1                (ram_row_24_col_0_clk_b),
                     .ADRRD_P1                (ADRRD_P1_ts16),
                     .RDEN_P1                 (RDEN_P1_ts16),
                     .QOUT_P1                 (ram_row_24_col_0_data_out_b),                
                                                     
                    
                   //-------------------------------------------------------------
                   // Power Management Interfaces
                   //-------------------------------------------------------------
                  //   .PWR_MGMT_IN                        ({pwr_mgmt_in_rf[PWR_MGMT_IN_SIZE-1:1],ram_fary_pwren_b[24]}), // MSB changed from 3'b100
                  //   .PWR_MGMT_OUT                       (ram_aary_pwren_b[24]),  
                
                       
                     `ifndef INTEL_NO_PWR_PINS
                        .vddp                            (ram_row_24_col_0_vcc),
                        `ifdef INTC_ADD_VSS
                        .vss                            (1'b0),
                        `endif  
                     `endif
               
        
        
        
                      //REPAIR INPUTS
        
                    .FCA           (ram_row_24_col_0_bisr_inst_Q[6:1]), // column repair addres --- > F means faulty
                    .CRE          (ram_row_24_col_0_bisr_inst_Q[0]), //Column repair enable
                    
        
                    // POWER MGMT inputs
                    //.ROP_SD             (), // shutoffout
                    //.ROP_DS             (), //dpslp_or_shutoffout
                    //TEMPCOMMENT1.MPMS              (1'b0), // {shutoff,deepsleep,fastsleep}
        
                    //TIMING and TRIM
                    // MDST = {async_reset0,async_reset1,wmce,mce,stbyp,rmce}
                    .MDST_hs2r2w       ({fary_ffuse_rfhs2r2w_trim[9],fary_ffuse_rfhs2r2w_trim[8],fary_ffuse_rfhs2r2w_trim[7:5],fary_ffuse_rfhs2r2w_trim[4],fary_ffuse_rfhs2r2w_trim[3],fary_ffuse_rfhs2r2w_trim[2:0]}),
                                        
        
                    //DFT inputs
                    .DFTSHIFTEN        (DFTSHIFTEN),
                    .DFTMASK           (DFTMASK),
                    .DFT_ARRAY_FREEZE    (DFT_ARRAY_FREEZE),
                    
                    .DFT_AFD_RESET_B    (DFT_AFD_RESET_B)
        
        
        
        );//ip783rfhs2r2w256x34s0c1p1d0_dft_wrp
        
        assign          ram_rd_data_a_col[24][0]    = ram_row_24_col_0_data_out_a;
        assign          ram_rd_data_b_col[24][0]    = ram_row_24_col_0_data_out_b;
        
             

        wire                            ram_row_25_col_0_clk_a       = clk_a;
        wire                            ram_row_25_col_0_clk_b       = clk_b;
        wire    [8-1:0]       ram_row_25_col_0_wr_adr_a    = ram_row_wr_adr_a[25][8-1:0];
        wire    [8-1:0]       ram_row_25_col_0_wr_adr_b    = ram_row_wr_adr_b[25][8-1:0];
        wire    [8-1:0]       ram_row_25_col_0_rd_adr_a    = ram_row_rd_adr_a[25][8-1:0];
        wire    [8-1:0]       ram_row_25_col_0_rd_adr_b    = ram_row_rd_adr_b[25][8-1:0];
        wire                            ram_row_25_col_0_rd_en_a     = ram_row_rd_en_a[25];
        wire                            ram_row_25_col_0_rd_en_b     = ram_row_rd_en_b[25];
        wire                            ram_row_25_col_0_wr_en_a     = |ram_col_wr_en_a[25][0];
        wire                            ram_row_25_col_0_wr_en_b     = |ram_col_wr_en_b[25][0];
        wire    [34-1:0]              ram_row_25_col_0_data_in_a   = ram_wr_data_a_col[0][34-1:0];
        wire    [34-1:0]              ram_row_25_col_0_data_in_b   = ram_wr_data_b_col[0][34-1:0];
        wire    [34-1:0]              ram_row_25_col_0_data_out_a;
        wire    [34-1:0]              ram_row_25_col_0_data_out_b;
        wire    [2:0]                   ram_row_25_col_0_aary_pwren_b;
        wire                            ram_row_25_col_0_vcc = 1'b1;
        
        
        ip783rfhs2r2w256x34s0c1p1d0_dft_wrp #(
                    )
        ram_row_25_col_0 (
                    //------------------------------------------------------------
                    // Functional Interfaces
                    //------------------------------------------------------------      
        
                     .CLKWR_P0                (ram_row_25_col_0_clk_a),
                     .ADRWR_P0                (ADRWR_P0_ts17),
                     .WREN_P0                 (WREN_P0_ts17),
                     .DIN_P0                  (DIN_P0_ts17),
        
                     .CLKWR_P1                (ram_row_25_col_0_clk_b),
                     .ADRWR_P1                (ADRWR_P1_ts17),
                     .WREN_P1                 (WREN_P1_ts17),
                     .DIN_P1                  (DIN_P1_ts17),
        
                     .CLKRD_P0                (ram_row_25_col_0_clk_a),
                     .ADRRD_P0                (ADRRD_P0_ts17),
                     .RDEN_P0                 (RDEN_P0_ts17),
                     .QOUT_P0                 (ram_row_25_col_0_data_out_a),
                         
                     .CLKRD_P1                (ram_row_25_col_0_clk_b),
                     .ADRRD_P1                (ADRRD_P1_ts17),
                     .RDEN_P1                 (RDEN_P1_ts17),
                     .QOUT_P1                 (ram_row_25_col_0_data_out_b),                
                                                     
                    
                   //-------------------------------------------------------------
                   // Power Management Interfaces
                   //-------------------------------------------------------------
                  //   .PWR_MGMT_IN                        ({pwr_mgmt_in_rf[PWR_MGMT_IN_SIZE-1:1],ram_fary_pwren_b[25]}), // MSB changed from 3'b100
                  //   .PWR_MGMT_OUT                       (ram_aary_pwren_b[25]),  
                
                       
                     `ifndef INTEL_NO_PWR_PINS
                        .vddp                            (ram_row_25_col_0_vcc),
                        `ifdef INTC_ADD_VSS
                        .vss                            (1'b0),
                        `endif  
                     `endif
               
        
        
        
                      //REPAIR INPUTS
        
                    .FCA           (ram_row_25_col_0_bisr_inst_Q[6:1]), // column repair addres --- > F means faulty
                    .CRE          (ram_row_25_col_0_bisr_inst_Q[0]), //Column repair enable
                    
        
                    // POWER MGMT inputs
                    //.ROP_SD             (), // shutoffout
                    //.ROP_DS             (), //dpslp_or_shutoffout
                    //TEMPCOMMENT1.MPMS              (1'b0), // {shutoff,deepsleep,fastsleep}
        
                    //TIMING and TRIM
                    // MDST = {async_reset0,async_reset1,wmce,mce,stbyp,rmce}
                    .MDST_hs2r2w       ({fary_ffuse_rfhs2r2w_trim[9],fary_ffuse_rfhs2r2w_trim[8],fary_ffuse_rfhs2r2w_trim[7:5],fary_ffuse_rfhs2r2w_trim[4],fary_ffuse_rfhs2r2w_trim[3],fary_ffuse_rfhs2r2w_trim[2:0]}),
                                        
        
                    //DFT inputs
                    .DFTSHIFTEN        (DFTSHIFTEN),
                    .DFTMASK           (DFTMASK),
                    .DFT_ARRAY_FREEZE    (DFT_ARRAY_FREEZE),
                    
                    .DFT_AFD_RESET_B    (DFT_AFD_RESET_B)
        
        
        
        );//ip783rfhs2r2w256x34s0c1p1d0_dft_wrp
        
        assign          ram_rd_data_a_col[25][0]    = ram_row_25_col_0_data_out_a;
        assign          ram_rd_data_b_col[25][0]    = ram_row_25_col_0_data_out_b;
        
             

        wire                            ram_row_26_col_0_clk_a       = clk_a;
        wire                            ram_row_26_col_0_clk_b       = clk_b;
        wire    [8-1:0]       ram_row_26_col_0_wr_adr_a    = ram_row_wr_adr_a[26][8-1:0];
        wire    [8-1:0]       ram_row_26_col_0_wr_adr_b    = ram_row_wr_adr_b[26][8-1:0];
        wire    [8-1:0]       ram_row_26_col_0_rd_adr_a    = ram_row_rd_adr_a[26][8-1:0];
        wire    [8-1:0]       ram_row_26_col_0_rd_adr_b    = ram_row_rd_adr_b[26][8-1:0];
        wire                            ram_row_26_col_0_rd_en_a     = ram_row_rd_en_a[26];
        wire                            ram_row_26_col_0_rd_en_b     = ram_row_rd_en_b[26];
        wire                            ram_row_26_col_0_wr_en_a     = |ram_col_wr_en_a[26][0];
        wire                            ram_row_26_col_0_wr_en_b     = |ram_col_wr_en_b[26][0];
        wire    [34-1:0]              ram_row_26_col_0_data_in_a   = ram_wr_data_a_col[0][34-1:0];
        wire    [34-1:0]              ram_row_26_col_0_data_in_b   = ram_wr_data_b_col[0][34-1:0];
        wire    [34-1:0]              ram_row_26_col_0_data_out_a;
        wire    [34-1:0]              ram_row_26_col_0_data_out_b;
        wire    [2:0]                   ram_row_26_col_0_aary_pwren_b;
        wire                            ram_row_26_col_0_vcc = 1'b1;
        
        
        ip783rfhs2r2w256x34s0c1p1d0_dft_wrp #(
                    )
        ram_row_26_col_0 (
                    //------------------------------------------------------------
                    // Functional Interfaces
                    //------------------------------------------------------------      
        
                     .CLKWR_P0                (ram_row_26_col_0_clk_a),
                     .ADRWR_P0                (ADRWR_P0_ts18),
                     .WREN_P0                 (WREN_P0_ts18),
                     .DIN_P0                  (DIN_P0_ts18),
        
                     .CLKWR_P1                (ram_row_26_col_0_clk_b),
                     .ADRWR_P1                (ADRWR_P1_ts18),
                     .WREN_P1                 (WREN_P1_ts18),
                     .DIN_P1                  (DIN_P1_ts18),
        
                     .CLKRD_P0                (ram_row_26_col_0_clk_a),
                     .ADRRD_P0                (ADRRD_P0_ts18),
                     .RDEN_P0                 (RDEN_P0_ts18),
                     .QOUT_P0                 (ram_row_26_col_0_data_out_a),
                         
                     .CLKRD_P1                (ram_row_26_col_0_clk_b),
                     .ADRRD_P1                (ADRRD_P1_ts18),
                     .RDEN_P1                 (RDEN_P1_ts18),
                     .QOUT_P1                 (ram_row_26_col_0_data_out_b),                
                                                     
                    
                   //-------------------------------------------------------------
                   // Power Management Interfaces
                   //-------------------------------------------------------------
                  //   .PWR_MGMT_IN                        ({pwr_mgmt_in_rf[PWR_MGMT_IN_SIZE-1:1],ram_fary_pwren_b[26]}), // MSB changed from 3'b100
                  //   .PWR_MGMT_OUT                       (ram_aary_pwren_b[26]),  
                
                       
                     `ifndef INTEL_NO_PWR_PINS
                        .vddp                            (ram_row_26_col_0_vcc),
                        `ifdef INTC_ADD_VSS
                        .vss                            (1'b0),
                        `endif  
                     `endif
               
        
        
        
                      //REPAIR INPUTS
        
                    .FCA           (ram_row_26_col_0_bisr_inst_Q[6:1]), // column repair addres --- > F means faulty
                    .CRE          (ram_row_26_col_0_bisr_inst_Q[0]), //Column repair enable
                    
        
                    // POWER MGMT inputs
                    //.ROP_SD             (), // shutoffout
                    //.ROP_DS             (), //dpslp_or_shutoffout
                    //TEMPCOMMENT1.MPMS              (1'b0), // {shutoff,deepsleep,fastsleep}
        
                    //TIMING and TRIM
                    // MDST = {async_reset0,async_reset1,wmce,mce,stbyp,rmce}
                    .MDST_hs2r2w       ({fary_ffuse_rfhs2r2w_trim[9],fary_ffuse_rfhs2r2w_trim[8],fary_ffuse_rfhs2r2w_trim[7:5],fary_ffuse_rfhs2r2w_trim[4],fary_ffuse_rfhs2r2w_trim[3],fary_ffuse_rfhs2r2w_trim[2:0]}),
                                        
        
                    //DFT inputs
                    .DFTSHIFTEN        (DFTSHIFTEN),
                    .DFTMASK           (DFTMASK),
                    .DFT_ARRAY_FREEZE    (DFT_ARRAY_FREEZE),
                    
                    .DFT_AFD_RESET_B    (DFT_AFD_RESET_B)
        
        
        
        );//ip783rfhs2r2w256x34s0c1p1d0_dft_wrp
        
        assign          ram_rd_data_a_col[26][0]    = ram_row_26_col_0_data_out_a;
        assign          ram_rd_data_b_col[26][0]    = ram_row_26_col_0_data_out_b;
        
             

        wire                            ram_row_27_col_0_clk_a       = clk_a;
        wire                            ram_row_27_col_0_clk_b       = clk_b;
        wire    [8-1:0]       ram_row_27_col_0_wr_adr_a    = ram_row_wr_adr_a[27][8-1:0];
        wire    [8-1:0]       ram_row_27_col_0_wr_adr_b    = ram_row_wr_adr_b[27][8-1:0];
        wire    [8-1:0]       ram_row_27_col_0_rd_adr_a    = ram_row_rd_adr_a[27][8-1:0];
        wire    [8-1:0]       ram_row_27_col_0_rd_adr_b    = ram_row_rd_adr_b[27][8-1:0];
        wire                            ram_row_27_col_0_rd_en_a     = ram_row_rd_en_a[27];
        wire                            ram_row_27_col_0_rd_en_b     = ram_row_rd_en_b[27];
        wire                            ram_row_27_col_0_wr_en_a     = |ram_col_wr_en_a[27][0];
        wire                            ram_row_27_col_0_wr_en_b     = |ram_col_wr_en_b[27][0];
        wire    [34-1:0]              ram_row_27_col_0_data_in_a   = ram_wr_data_a_col[0][34-1:0];
        wire    [34-1:0]              ram_row_27_col_0_data_in_b   = ram_wr_data_b_col[0][34-1:0];
        wire    [34-1:0]              ram_row_27_col_0_data_out_a;
        wire    [34-1:0]              ram_row_27_col_0_data_out_b;
        wire    [2:0]                   ram_row_27_col_0_aary_pwren_b;
        wire                            ram_row_27_col_0_vcc = 1'b1;
        
        
        ip783rfhs2r2w256x34s0c1p1d0_dft_wrp #(
                    )
        ram_row_27_col_0 (
                    //------------------------------------------------------------
                    // Functional Interfaces
                    //------------------------------------------------------------      
        
                     .CLKWR_P0                (ram_row_27_col_0_clk_a),
                     .ADRWR_P0                (ADRWR_P0_ts19),
                     .WREN_P0                 (WREN_P0_ts19),
                     .DIN_P0                  (DIN_P0_ts19),
        
                     .CLKWR_P1                (ram_row_27_col_0_clk_b),
                     .ADRWR_P1                (ADRWR_P1_ts19),
                     .WREN_P1                 (WREN_P1_ts19),
                     .DIN_P1                  (DIN_P1_ts19),
        
                     .CLKRD_P0                (ram_row_27_col_0_clk_a),
                     .ADRRD_P0                (ADRRD_P0_ts19),
                     .RDEN_P0                 (RDEN_P0_ts19),
                     .QOUT_P0                 (ram_row_27_col_0_data_out_a),
                         
                     .CLKRD_P1                (ram_row_27_col_0_clk_b),
                     .ADRRD_P1                (ADRRD_P1_ts19),
                     .RDEN_P1                 (RDEN_P1_ts19),
                     .QOUT_P1                 (ram_row_27_col_0_data_out_b),                
                                                     
                    
                   //-------------------------------------------------------------
                   // Power Management Interfaces
                   //-------------------------------------------------------------
                  //   .PWR_MGMT_IN                        ({pwr_mgmt_in_rf[PWR_MGMT_IN_SIZE-1:1],ram_fary_pwren_b[27]}), // MSB changed from 3'b100
                  //   .PWR_MGMT_OUT                       (ram_aary_pwren_b[27]),  
                
                       
                     `ifndef INTEL_NO_PWR_PINS
                        .vddp                            (ram_row_27_col_0_vcc),
                        `ifdef INTC_ADD_VSS
                        .vss                            (1'b0),
                        `endif  
                     `endif
               
        
        
        
                      //REPAIR INPUTS
        
                    .FCA           (ram_row_27_col_0_bisr_inst_Q[6:1]), // column repair addres --- > F means faulty
                    .CRE          (ram_row_27_col_0_bisr_inst_Q[0]), //Column repair enable
                    
        
                    // POWER MGMT inputs
                    //.ROP_SD             (), // shutoffout
                    //.ROP_DS             (), //dpslp_or_shutoffout
                    //TEMPCOMMENT1.MPMS              (1'b0), // {shutoff,deepsleep,fastsleep}
        
                    //TIMING and TRIM
                    // MDST = {async_reset0,async_reset1,wmce,mce,stbyp,rmce}
                    .MDST_hs2r2w       ({fary_ffuse_rfhs2r2w_trim[9],fary_ffuse_rfhs2r2w_trim[8],fary_ffuse_rfhs2r2w_trim[7:5],fary_ffuse_rfhs2r2w_trim[4],fary_ffuse_rfhs2r2w_trim[3],fary_ffuse_rfhs2r2w_trim[2:0]}),
                                        
        
                    //DFT inputs
                    .DFTSHIFTEN        (DFTSHIFTEN),
                    .DFTMASK           (DFTMASK),
                    .DFT_ARRAY_FREEZE    (DFT_ARRAY_FREEZE),
                    
                    .DFT_AFD_RESET_B    (DFT_AFD_RESET_B)
        
        
        
        );//ip783rfhs2r2w256x34s0c1p1d0_dft_wrp
        
        assign          ram_rd_data_a_col[27][0]    = ram_row_27_col_0_data_out_a;
        assign          ram_rd_data_b_col[27][0]    = ram_row_27_col_0_data_out_b;
        
             

        wire                            ram_row_28_col_0_clk_a       = clk_a;
        wire                            ram_row_28_col_0_clk_b       = clk_b;
        wire    [8-1:0]       ram_row_28_col_0_wr_adr_a    = ram_row_wr_adr_a[28][8-1:0];
        wire    [8-1:0]       ram_row_28_col_0_wr_adr_b    = ram_row_wr_adr_b[28][8-1:0];
        wire    [8-1:0]       ram_row_28_col_0_rd_adr_a    = ram_row_rd_adr_a[28][8-1:0];
        wire    [8-1:0]       ram_row_28_col_0_rd_adr_b    = ram_row_rd_adr_b[28][8-1:0];
        wire                            ram_row_28_col_0_rd_en_a     = ram_row_rd_en_a[28];
        wire                            ram_row_28_col_0_rd_en_b     = ram_row_rd_en_b[28];
        wire                            ram_row_28_col_0_wr_en_a     = |ram_col_wr_en_a[28][0];
        wire                            ram_row_28_col_0_wr_en_b     = |ram_col_wr_en_b[28][0];
        wire    [34-1:0]              ram_row_28_col_0_data_in_a   = ram_wr_data_a_col[0][34-1:0];
        wire    [34-1:0]              ram_row_28_col_0_data_in_b   = ram_wr_data_b_col[0][34-1:0];
        wire    [34-1:0]              ram_row_28_col_0_data_out_a;
        wire    [34-1:0]              ram_row_28_col_0_data_out_b;
        wire    [2:0]                   ram_row_28_col_0_aary_pwren_b;
        wire                            ram_row_28_col_0_vcc = 1'b1;
        
        
        ip783rfhs2r2w256x34s0c1p1d0_dft_wrp #(
                    )
        ram_row_28_col_0 (
                    //------------------------------------------------------------
                    // Functional Interfaces
                    //------------------------------------------------------------      
        
                     .CLKWR_P0                (ram_row_28_col_0_clk_a),
                     .ADRWR_P0                (ADRWR_P0_ts20),
                     .WREN_P0                 (WREN_P0_ts20),
                     .DIN_P0                  (DIN_P0_ts20),
        
                     .CLKWR_P1                (ram_row_28_col_0_clk_b),
                     .ADRWR_P1                (ADRWR_P1_ts20),
                     .WREN_P1                 (WREN_P1_ts20),
                     .DIN_P1                  (DIN_P1_ts20),
        
                     .CLKRD_P0                (ram_row_28_col_0_clk_a),
                     .ADRRD_P0                (ADRRD_P0_ts20),
                     .RDEN_P0                 (RDEN_P0_ts20),
                     .QOUT_P0                 (ram_row_28_col_0_data_out_a),
                         
                     .CLKRD_P1                (ram_row_28_col_0_clk_b),
                     .ADRRD_P1                (ADRRD_P1_ts20),
                     .RDEN_P1                 (RDEN_P1_ts20),
                     .QOUT_P1                 (ram_row_28_col_0_data_out_b),                
                                                     
                    
                   //-------------------------------------------------------------
                   // Power Management Interfaces
                   //-------------------------------------------------------------
                  //   .PWR_MGMT_IN                        ({pwr_mgmt_in_rf[PWR_MGMT_IN_SIZE-1:1],ram_fary_pwren_b[28]}), // MSB changed from 3'b100
                  //   .PWR_MGMT_OUT                       (ram_aary_pwren_b[28]),  
                
                       
                     `ifndef INTEL_NO_PWR_PINS
                        .vddp                            (ram_row_28_col_0_vcc),
                        `ifdef INTC_ADD_VSS
                        .vss                            (1'b0),
                        `endif  
                     `endif
               
        
        
        
                      //REPAIR INPUTS
        
                    .FCA           (ram_row_28_col_0_bisr_inst_Q[6:1]), // column repair addres --- > F means faulty
                    .CRE          (ram_row_28_col_0_bisr_inst_Q[0]), //Column repair enable
                    
        
                    // POWER MGMT inputs
                    //.ROP_SD             (), // shutoffout
                    //.ROP_DS             (), //dpslp_or_shutoffout
                    //TEMPCOMMENT1.MPMS              (1'b0), // {shutoff,deepsleep,fastsleep}
        
                    //TIMING and TRIM
                    // MDST = {async_reset0,async_reset1,wmce,mce,stbyp,rmce}
                    .MDST_hs2r2w       ({fary_ffuse_rfhs2r2w_trim[9],fary_ffuse_rfhs2r2w_trim[8],fary_ffuse_rfhs2r2w_trim[7:5],fary_ffuse_rfhs2r2w_trim[4],fary_ffuse_rfhs2r2w_trim[3],fary_ffuse_rfhs2r2w_trim[2:0]}),
                                        
        
                    //DFT inputs
                    .DFTSHIFTEN        (DFTSHIFTEN),
                    .DFTMASK           (DFTMASK),
                    .DFT_ARRAY_FREEZE    (DFT_ARRAY_FREEZE),
                    
                    .DFT_AFD_RESET_B    (DFT_AFD_RESET_B)
        
        
        
        );//ip783rfhs2r2w256x34s0c1p1d0_dft_wrp
        
        assign          ram_rd_data_a_col[28][0]    = ram_row_28_col_0_data_out_a;
        assign          ram_rd_data_b_col[28][0]    = ram_row_28_col_0_data_out_b;
        
             

        wire                            ram_row_29_col_0_clk_a       = clk_a;
        wire                            ram_row_29_col_0_clk_b       = clk_b;
        wire    [8-1:0]       ram_row_29_col_0_wr_adr_a    = ram_row_wr_adr_a[29][8-1:0];
        wire    [8-1:0]       ram_row_29_col_0_wr_adr_b    = ram_row_wr_adr_b[29][8-1:0];
        wire    [8-1:0]       ram_row_29_col_0_rd_adr_a    = ram_row_rd_adr_a[29][8-1:0];
        wire    [8-1:0]       ram_row_29_col_0_rd_adr_b    = ram_row_rd_adr_b[29][8-1:0];
        wire                            ram_row_29_col_0_rd_en_a     = ram_row_rd_en_a[29];
        wire                            ram_row_29_col_0_rd_en_b     = ram_row_rd_en_b[29];
        wire                            ram_row_29_col_0_wr_en_a     = |ram_col_wr_en_a[29][0];
        wire                            ram_row_29_col_0_wr_en_b     = |ram_col_wr_en_b[29][0];
        wire    [34-1:0]              ram_row_29_col_0_data_in_a   = ram_wr_data_a_col[0][34-1:0];
        wire    [34-1:0]              ram_row_29_col_0_data_in_b   = ram_wr_data_b_col[0][34-1:0];
        wire    [34-1:0]              ram_row_29_col_0_data_out_a;
        wire    [34-1:0]              ram_row_29_col_0_data_out_b;
        wire    [2:0]                   ram_row_29_col_0_aary_pwren_b;
        wire                            ram_row_29_col_0_vcc = 1'b1;
        
        
        ip783rfhs2r2w256x34s0c1p1d0_dft_wrp #(
                    )
        ram_row_29_col_0 (
                    //------------------------------------------------------------
                    // Functional Interfaces
                    //------------------------------------------------------------      
        
                     .CLKWR_P0                (ram_row_29_col_0_clk_a),
                     .ADRWR_P0                (ADRWR_P0_ts21),
                     .WREN_P0                 (WREN_P0_ts21),
                     .DIN_P0                  (DIN_P0_ts21),
        
                     .CLKWR_P1                (ram_row_29_col_0_clk_b),
                     .ADRWR_P1                (ADRWR_P1_ts21),
                     .WREN_P1                 (WREN_P1_ts21),
                     .DIN_P1                  (DIN_P1_ts21),
        
                     .CLKRD_P0                (ram_row_29_col_0_clk_a),
                     .ADRRD_P0                (ADRRD_P0_ts21),
                     .RDEN_P0                 (RDEN_P0_ts21),
                     .QOUT_P0                 (ram_row_29_col_0_data_out_a),
                         
                     .CLKRD_P1                (ram_row_29_col_0_clk_b),
                     .ADRRD_P1                (ADRRD_P1_ts21),
                     .RDEN_P1                 (RDEN_P1_ts21),
                     .QOUT_P1                 (ram_row_29_col_0_data_out_b),                
                                                     
                    
                   //-------------------------------------------------------------
                   // Power Management Interfaces
                   //-------------------------------------------------------------
                  //   .PWR_MGMT_IN                        ({pwr_mgmt_in_rf[PWR_MGMT_IN_SIZE-1:1],ram_fary_pwren_b[29]}), // MSB changed from 3'b100
                  //   .PWR_MGMT_OUT                       (ram_aary_pwren_b[29]),  
                
                       
                     `ifndef INTEL_NO_PWR_PINS
                        .vddp                            (ram_row_29_col_0_vcc),
                        `ifdef INTC_ADD_VSS
                        .vss                            (1'b0),
                        `endif  
                     `endif
               
        
        
        
                      //REPAIR INPUTS
        
                    .FCA           (ram_row_29_col_0_bisr_inst_Q[6:1]), // column repair addres --- > F means faulty
                    .CRE          (ram_row_29_col_0_bisr_inst_Q[0]), //Column repair enable
                    
        
                    // POWER MGMT inputs
                    //.ROP_SD             (), // shutoffout
                    //.ROP_DS             (), //dpslp_or_shutoffout
                    //TEMPCOMMENT1.MPMS              (1'b0), // {shutoff,deepsleep,fastsleep}
        
                    //TIMING and TRIM
                    // MDST = {async_reset0,async_reset1,wmce,mce,stbyp,rmce}
                    .MDST_hs2r2w       ({fary_ffuse_rfhs2r2w_trim[9],fary_ffuse_rfhs2r2w_trim[8],fary_ffuse_rfhs2r2w_trim[7:5],fary_ffuse_rfhs2r2w_trim[4],fary_ffuse_rfhs2r2w_trim[3],fary_ffuse_rfhs2r2w_trim[2:0]}),
                                        
        
                    //DFT inputs
                    .DFTSHIFTEN        (DFTSHIFTEN),
                    .DFTMASK           (DFTMASK),
                    .DFT_ARRAY_FREEZE    (DFT_ARRAY_FREEZE),
                    
                    .DFT_AFD_RESET_B    (DFT_AFD_RESET_B)
        
        
        
        );//ip783rfhs2r2w256x34s0c1p1d0_dft_wrp
        
        assign          ram_rd_data_a_col[29][0]    = ram_row_29_col_0_data_out_a;
        assign          ram_rd_data_b_col[29][0]    = ram_row_29_col_0_data_out_b;
        
             

        wire                            ram_row_30_col_0_clk_a       = clk_a;
        wire                            ram_row_30_col_0_clk_b       = clk_b;
        wire    [8-1:0]       ram_row_30_col_0_wr_adr_a    = ram_row_wr_adr_a[30][8-1:0];
        wire    [8-1:0]       ram_row_30_col_0_wr_adr_b    = ram_row_wr_adr_b[30][8-1:0];
        wire    [8-1:0]       ram_row_30_col_0_rd_adr_a    = ram_row_rd_adr_a[30][8-1:0];
        wire    [8-1:0]       ram_row_30_col_0_rd_adr_b    = ram_row_rd_adr_b[30][8-1:0];
        wire                            ram_row_30_col_0_rd_en_a     = ram_row_rd_en_a[30];
        wire                            ram_row_30_col_0_rd_en_b     = ram_row_rd_en_b[30];
        wire                            ram_row_30_col_0_wr_en_a     = |ram_col_wr_en_a[30][0];
        wire                            ram_row_30_col_0_wr_en_b     = |ram_col_wr_en_b[30][0];
        wire    [34-1:0]              ram_row_30_col_0_data_in_a   = ram_wr_data_a_col[0][34-1:0];
        wire    [34-1:0]              ram_row_30_col_0_data_in_b   = ram_wr_data_b_col[0][34-1:0];
        wire    [34-1:0]              ram_row_30_col_0_data_out_a;
        wire    [34-1:0]              ram_row_30_col_0_data_out_b;
        wire    [2:0]                   ram_row_30_col_0_aary_pwren_b;
        wire                            ram_row_30_col_0_vcc = 1'b1;
        
        
        ip783rfhs2r2w256x34s0c1p1d0_dft_wrp #(
                    )
        ram_row_30_col_0 (
                    //------------------------------------------------------------
                    // Functional Interfaces
                    //------------------------------------------------------------      
        
                     .CLKWR_P0                (ram_row_30_col_0_clk_a),
                     .ADRWR_P0                (ADRWR_P0_ts23),
                     .WREN_P0                 (WREN_P0_ts23),
                     .DIN_P0                  (DIN_P0_ts23),
        
                     .CLKWR_P1                (ram_row_30_col_0_clk_b),
                     .ADRWR_P1                (ADRWR_P1_ts23),
                     .WREN_P1                 (WREN_P1_ts23),
                     .DIN_P1                  (DIN_P1_ts23),
        
                     .CLKRD_P0                (ram_row_30_col_0_clk_a),
                     .ADRRD_P0                (ADRRD_P0_ts23),
                     .RDEN_P0                 (RDEN_P0_ts23),
                     .QOUT_P0                 (ram_row_30_col_0_data_out_a),
                         
                     .CLKRD_P1                (ram_row_30_col_0_clk_b),
                     .ADRRD_P1                (ADRRD_P1_ts23),
                     .RDEN_P1                 (RDEN_P1_ts23),
                     .QOUT_P1                 (ram_row_30_col_0_data_out_b),                
                                                     
                    
                   //-------------------------------------------------------------
                   // Power Management Interfaces
                   //-------------------------------------------------------------
                  //   .PWR_MGMT_IN                        ({pwr_mgmt_in_rf[PWR_MGMT_IN_SIZE-1:1],ram_fary_pwren_b[30]}), // MSB changed from 3'b100
                  //   .PWR_MGMT_OUT                       (ram_aary_pwren_b[30]),  
                
                       
                     `ifndef INTEL_NO_PWR_PINS
                        .vddp                            (ram_row_30_col_0_vcc),
                        `ifdef INTC_ADD_VSS
                        .vss                            (1'b0),
                        `endif  
                     `endif
               
        
        
        
                      //REPAIR INPUTS
        
                    .FCA           (ram_row_30_col_0_bisr_inst_Q[6:1]), // column repair addres --- > F means faulty
                    .CRE          (ram_row_30_col_0_bisr_inst_Q[0]), //Column repair enable
                    
        
                    // POWER MGMT inputs
                    //.ROP_SD             (), // shutoffout
                    //.ROP_DS             (), //dpslp_or_shutoffout
                    //TEMPCOMMENT1.MPMS              (1'b0), // {shutoff,deepsleep,fastsleep}
        
                    //TIMING and TRIM
                    // MDST = {async_reset0,async_reset1,wmce,mce,stbyp,rmce}
                    .MDST_hs2r2w       ({fary_ffuse_rfhs2r2w_trim[9],fary_ffuse_rfhs2r2w_trim[8],fary_ffuse_rfhs2r2w_trim[7:5],fary_ffuse_rfhs2r2w_trim[4],fary_ffuse_rfhs2r2w_trim[3],fary_ffuse_rfhs2r2w_trim[2:0]}),
                                        
        
                    //DFT inputs
                    .DFTSHIFTEN        (DFTSHIFTEN),
                    .DFTMASK           (DFTMASK),
                    .DFT_ARRAY_FREEZE    (DFT_ARRAY_FREEZE),
                    
                    .DFT_AFD_RESET_B    (DFT_AFD_RESET_B)
        
        
        
        );//ip783rfhs2r2w256x34s0c1p1d0_dft_wrp
        
        assign          ram_rd_data_a_col[30][0]    = ram_row_30_col_0_data_out_a;
        assign          ram_rd_data_b_col[30][0]    = ram_row_30_col_0_data_out_b;
        
             

        wire                            ram_row_31_col_0_clk_a       = clk_a;
        wire                            ram_row_31_col_0_clk_b       = clk_b;
        wire    [8-1:0]       ram_row_31_col_0_wr_adr_a    = ram_row_wr_adr_a[31][8-1:0];
        wire    [8-1:0]       ram_row_31_col_0_wr_adr_b    = ram_row_wr_adr_b[31][8-1:0];
        wire    [8-1:0]       ram_row_31_col_0_rd_adr_a    = ram_row_rd_adr_a[31][8-1:0];
        wire    [8-1:0]       ram_row_31_col_0_rd_adr_b    = ram_row_rd_adr_b[31][8-1:0];
        wire                            ram_row_31_col_0_rd_en_a     = ram_row_rd_en_a[31];
        wire                            ram_row_31_col_0_rd_en_b     = ram_row_rd_en_b[31];
        wire                            ram_row_31_col_0_wr_en_a     = |ram_col_wr_en_a[31][0];
        wire                            ram_row_31_col_0_wr_en_b     = |ram_col_wr_en_b[31][0];
        wire    [34-1:0]              ram_row_31_col_0_data_in_a   = ram_wr_data_a_col[0][34-1:0];
        wire    [34-1:0]              ram_row_31_col_0_data_in_b   = ram_wr_data_b_col[0][34-1:0];
        wire    [34-1:0]              ram_row_31_col_0_data_out_a;
        wire    [34-1:0]              ram_row_31_col_0_data_out_b;
        wire    [2:0]                   ram_row_31_col_0_aary_pwren_b;
        wire                            ram_row_31_col_0_vcc = 1'b1;
        
        
        ip783rfhs2r2w256x34s0c1p1d0_dft_wrp #(
                    )
        ram_row_31_col_0 (
                    //------------------------------------------------------------
                    // Functional Interfaces
                    //------------------------------------------------------------      
        
                     .CLKWR_P0                (ram_row_31_col_0_clk_a),
                     .ADRWR_P0                (ADRWR_P0_ts24),
                     .WREN_P0                 (WREN_P0_ts24),
                     .DIN_P0                  (DIN_P0_ts24),
        
                     .CLKWR_P1                (ram_row_31_col_0_clk_b),
                     .ADRWR_P1                (ADRWR_P1_ts24),
                     .WREN_P1                 (WREN_P1_ts24),
                     .DIN_P1                  (DIN_P1_ts24),
        
                     .CLKRD_P0                (ram_row_31_col_0_clk_a),
                     .ADRRD_P0                (ADRRD_P0_ts24),
                     .RDEN_P0                 (RDEN_P0_ts24),
                     .QOUT_P0                 (ram_row_31_col_0_data_out_a),
                         
                     .CLKRD_P1                (ram_row_31_col_0_clk_b),
                     .ADRRD_P1                (ADRRD_P1_ts24),
                     .RDEN_P1                 (RDEN_P1_ts24),
                     .QOUT_P1                 (ram_row_31_col_0_data_out_b),                
                                                     
                    
                   //-------------------------------------------------------------
                   // Power Management Interfaces
                   //-------------------------------------------------------------
                  //   .PWR_MGMT_IN                        ({pwr_mgmt_in_rf[PWR_MGMT_IN_SIZE-1:1],ram_fary_pwren_b[31]}), // MSB changed from 3'b100
                  //   .PWR_MGMT_OUT                       (ram_aary_pwren_b[31]),  
                
                       
                     `ifndef INTEL_NO_PWR_PINS
                        .vddp                            (ram_row_31_col_0_vcc),
                        `ifdef INTC_ADD_VSS
                        .vss                            (1'b0),
                        `endif  
                     `endif
               
        
        
        
                      //REPAIR INPUTS
        
                    .FCA           (ram_row_31_col_0_bisr_inst_Q[6:1]), // column repair addres --- > F means faulty
                    .CRE          (ram_row_31_col_0_bisr_inst_Q[0]), //Column repair enable
                    
        
                    // POWER MGMT inputs
                    //.ROP_SD             (), // shutoffout
                    //.ROP_DS             (), //dpslp_or_shutoffout
                    //TEMPCOMMENT1.MPMS              (1'b0), // {shutoff,deepsleep,fastsleep}
        
                    //TIMING and TRIM
                    // MDST = {async_reset0,async_reset1,wmce,mce,stbyp,rmce}
                    .MDST_hs2r2w       ({fary_ffuse_rfhs2r2w_trim[9],fary_ffuse_rfhs2r2w_trim[8],fary_ffuse_rfhs2r2w_trim[7:5],fary_ffuse_rfhs2r2w_trim[4],fary_ffuse_rfhs2r2w_trim[3],fary_ffuse_rfhs2r2w_trim[2:0]}),
                                        
        
                    //DFT inputs
                    .DFTSHIFTEN        (DFTSHIFTEN),
                    .DFTMASK           (DFTMASK),
                    .DFT_ARRAY_FREEZE    (DFT_ARRAY_FREEZE),
                    
                    .DFT_AFD_RESET_B    (DFT_AFD_RESET_B)
        
        
        
        );//ip783rfhs2r2w256x34s0c1p1d0_dft_wrp
        
        assign          ram_rd_data_a_col[31][0]    = ram_row_31_col_0_data_out_a;
        assign          ram_rd_data_b_col[31][0]    = ram_row_31_col_0_data_out_b;
        
             

        wire                            ram_row_32_col_0_clk_a       = clk_a;
        wire                            ram_row_32_col_0_clk_b       = clk_b;
        wire    [8-1:0]       ram_row_32_col_0_wr_adr_a    = ram_row_wr_adr_a[32][8-1:0];
        wire    [8-1:0]       ram_row_32_col_0_wr_adr_b    = ram_row_wr_adr_b[32][8-1:0];
        wire    [8-1:0]       ram_row_32_col_0_rd_adr_a    = ram_row_rd_adr_a[32][8-1:0];
        wire    [8-1:0]       ram_row_32_col_0_rd_adr_b    = ram_row_rd_adr_b[32][8-1:0];
        wire                            ram_row_32_col_0_rd_en_a     = ram_row_rd_en_a[32];
        wire                            ram_row_32_col_0_rd_en_b     = ram_row_rd_en_b[32];
        wire                            ram_row_32_col_0_wr_en_a     = |ram_col_wr_en_a[32][0];
        wire                            ram_row_32_col_0_wr_en_b     = |ram_col_wr_en_b[32][0];
        wire    [34-1:0]              ram_row_32_col_0_data_in_a   = ram_wr_data_a_col[0][34-1:0];
        wire    [34-1:0]              ram_row_32_col_0_data_in_b   = ram_wr_data_b_col[0][34-1:0];
        wire    [34-1:0]              ram_row_32_col_0_data_out_a;
        wire    [34-1:0]              ram_row_32_col_0_data_out_b;
        wire    [2:0]                   ram_row_32_col_0_aary_pwren_b;
        wire                            ram_row_32_col_0_vcc = 1'b1;
        
        
        ip783rfhs2r2w256x34s0c1p1d0_dft_wrp #(
                    )
        ram_row_32_col_0 (
                    //------------------------------------------------------------
                    // Functional Interfaces
                    //------------------------------------------------------------      
        
                     .CLKWR_P0                (ram_row_32_col_0_clk_a),
                     .ADRWR_P0                (ADRWR_P0_ts25),
                     .WREN_P0                 (WREN_P0_ts25),
                     .DIN_P0                  (DIN_P0_ts25),
        
                     .CLKWR_P1                (ram_row_32_col_0_clk_b),
                     .ADRWR_P1                (ADRWR_P1_ts25),
                     .WREN_P1                 (WREN_P1_ts25),
                     .DIN_P1                  (DIN_P1_ts25),
        
                     .CLKRD_P0                (ram_row_32_col_0_clk_a),
                     .ADRRD_P0                (ADRRD_P0_ts25),
                     .RDEN_P0                 (RDEN_P0_ts25),
                     .QOUT_P0                 (ram_row_32_col_0_data_out_a),
                         
                     .CLKRD_P1                (ram_row_32_col_0_clk_b),
                     .ADRRD_P1                (ADRRD_P1_ts25),
                     .RDEN_P1                 (RDEN_P1_ts25),
                     .QOUT_P1                 (ram_row_32_col_0_data_out_b),                
                                                     
                    
                   //-------------------------------------------------------------
                   // Power Management Interfaces
                   //-------------------------------------------------------------
                  //   .PWR_MGMT_IN                        ({pwr_mgmt_in_rf[PWR_MGMT_IN_SIZE-1:1],ram_fary_pwren_b[32]}), // MSB changed from 3'b100
                  //   .PWR_MGMT_OUT                       (ram_aary_pwren_b[32]),  
                
                       
                     `ifndef INTEL_NO_PWR_PINS
                        .vddp                            (ram_row_32_col_0_vcc),
                        `ifdef INTC_ADD_VSS
                        .vss                            (1'b0),
                        `endif  
                     `endif
               
        
        
        
                      //REPAIR INPUTS
        
                    .FCA           (ram_row_32_col_0_bisr_inst_Q[6:1]), // column repair addres --- > F means faulty
                    .CRE          (ram_row_32_col_0_bisr_inst_Q[0]), //Column repair enable
                    
        
                    // POWER MGMT inputs
                    //.ROP_SD             (), // shutoffout
                    //.ROP_DS             (), //dpslp_or_shutoffout
                    //TEMPCOMMENT1.MPMS              (1'b0), // {shutoff,deepsleep,fastsleep}
        
                    //TIMING and TRIM
                    // MDST = {async_reset0,async_reset1,wmce,mce,stbyp,rmce}
                    .MDST_hs2r2w       ({fary_ffuse_rfhs2r2w_trim[9],fary_ffuse_rfhs2r2w_trim[8],fary_ffuse_rfhs2r2w_trim[7:5],fary_ffuse_rfhs2r2w_trim[4],fary_ffuse_rfhs2r2w_trim[3],fary_ffuse_rfhs2r2w_trim[2:0]}),
                                        
        
                    //DFT inputs
                    .DFTSHIFTEN        (DFTSHIFTEN),
                    .DFTMASK           (DFTMASK),
                    .DFT_ARRAY_FREEZE    (DFT_ARRAY_FREEZE),
                    
                    .DFT_AFD_RESET_B    (DFT_AFD_RESET_B)
        
        
        
        );//ip783rfhs2r2w256x34s0c1p1d0_dft_wrp
        
        assign          ram_rd_data_a_col[32][0]    = ram_row_32_col_0_data_out_a;
        assign          ram_rd_data_b_col[32][0]    = ram_row_32_col_0_data_out_b;
        
             

        wire                            ram_row_33_col_0_clk_a       = clk_a;
        wire                            ram_row_33_col_0_clk_b       = clk_b;
        wire    [8-1:0]       ram_row_33_col_0_wr_adr_a    = ram_row_wr_adr_a[33][8-1:0];
        wire    [8-1:0]       ram_row_33_col_0_wr_adr_b    = ram_row_wr_adr_b[33][8-1:0];
        wire    [8-1:0]       ram_row_33_col_0_rd_adr_a    = ram_row_rd_adr_a[33][8-1:0];
        wire    [8-1:0]       ram_row_33_col_0_rd_adr_b    = ram_row_rd_adr_b[33][8-1:0];
        wire                            ram_row_33_col_0_rd_en_a     = ram_row_rd_en_a[33];
        wire                            ram_row_33_col_0_rd_en_b     = ram_row_rd_en_b[33];
        wire                            ram_row_33_col_0_wr_en_a     = |ram_col_wr_en_a[33][0];
        wire                            ram_row_33_col_0_wr_en_b     = |ram_col_wr_en_b[33][0];
        wire    [34-1:0]              ram_row_33_col_0_data_in_a   = ram_wr_data_a_col[0][34-1:0];
        wire    [34-1:0]              ram_row_33_col_0_data_in_b   = ram_wr_data_b_col[0][34-1:0];
        wire    [34-1:0]              ram_row_33_col_0_data_out_a;
        wire    [34-1:0]              ram_row_33_col_0_data_out_b;
        wire    [2:0]                   ram_row_33_col_0_aary_pwren_b;
        wire                            ram_row_33_col_0_vcc = 1'b1;
        
        
        ip783rfhs2r2w256x34s0c1p1d0_dft_wrp #(
                    )
        ram_row_33_col_0 (
                    //------------------------------------------------------------
                    // Functional Interfaces
                    //------------------------------------------------------------      
        
                     .CLKWR_P0                (ram_row_33_col_0_clk_a),
                     .ADRWR_P0                (ADRWR_P0_ts26),
                     .WREN_P0                 (WREN_P0_ts26),
                     .DIN_P0                  (DIN_P0_ts26),
        
                     .CLKWR_P1                (ram_row_33_col_0_clk_b),
                     .ADRWR_P1                (ADRWR_P1_ts26),
                     .WREN_P1                 (WREN_P1_ts26),
                     .DIN_P1                  (DIN_P1_ts26),
        
                     .CLKRD_P0                (ram_row_33_col_0_clk_a),
                     .ADRRD_P0                (ADRRD_P0_ts26),
                     .RDEN_P0                 (RDEN_P0_ts26),
                     .QOUT_P0                 (ram_row_33_col_0_data_out_a),
                         
                     .CLKRD_P1                (ram_row_33_col_0_clk_b),
                     .ADRRD_P1                (ADRRD_P1_ts26),
                     .RDEN_P1                 (RDEN_P1_ts26),
                     .QOUT_P1                 (ram_row_33_col_0_data_out_b),                
                                                     
                    
                   //-------------------------------------------------------------
                   // Power Management Interfaces
                   //-------------------------------------------------------------
                  //   .PWR_MGMT_IN                        ({pwr_mgmt_in_rf[PWR_MGMT_IN_SIZE-1:1],ram_fary_pwren_b[33]}), // MSB changed from 3'b100
                  //   .PWR_MGMT_OUT                       (ram_aary_pwren_b[33]),  
                
                       
                     `ifndef INTEL_NO_PWR_PINS
                        .vddp                            (ram_row_33_col_0_vcc),
                        `ifdef INTC_ADD_VSS
                        .vss                            (1'b0),
                        `endif  
                     `endif
               
        
        
        
                      //REPAIR INPUTS
        
                    .FCA           (ram_row_33_col_0_bisr_inst_Q[6:1]), // column repair addres --- > F means faulty
                    .CRE          (ram_row_33_col_0_bisr_inst_Q[0]), //Column repair enable
                    
        
                    // POWER MGMT inputs
                    //.ROP_SD             (), // shutoffout
                    //.ROP_DS             (), //dpslp_or_shutoffout
                    //TEMPCOMMENT1.MPMS              (1'b0), // {shutoff,deepsleep,fastsleep}
        
                    //TIMING and TRIM
                    // MDST = {async_reset0,async_reset1,wmce,mce,stbyp,rmce}
                    .MDST_hs2r2w       ({fary_ffuse_rfhs2r2w_trim[9],fary_ffuse_rfhs2r2w_trim[8],fary_ffuse_rfhs2r2w_trim[7:5],fary_ffuse_rfhs2r2w_trim[4],fary_ffuse_rfhs2r2w_trim[3],fary_ffuse_rfhs2r2w_trim[2:0]}),
                                        
        
                    //DFT inputs
                    .DFTSHIFTEN        (DFTSHIFTEN),
                    .DFTMASK           (DFTMASK),
                    .DFT_ARRAY_FREEZE    (DFT_ARRAY_FREEZE),
                    
                    .DFT_AFD_RESET_B    (DFT_AFD_RESET_B)
        
        
        
        );//ip783rfhs2r2w256x34s0c1p1d0_dft_wrp
        
        assign          ram_rd_data_a_col[33][0]    = ram_row_33_col_0_data_out_a;
        assign          ram_rd_data_b_col[33][0]    = ram_row_33_col_0_data_out_b;
        
             

        wire                            ram_row_34_col_0_clk_a       = clk_a;
        wire                            ram_row_34_col_0_clk_b       = clk_b;
        wire    [8-1:0]       ram_row_34_col_0_wr_adr_a    = ram_row_wr_adr_a[34][8-1:0];
        wire    [8-1:0]       ram_row_34_col_0_wr_adr_b    = ram_row_wr_adr_b[34][8-1:0];
        wire    [8-1:0]       ram_row_34_col_0_rd_adr_a    = ram_row_rd_adr_a[34][8-1:0];
        wire    [8-1:0]       ram_row_34_col_0_rd_adr_b    = ram_row_rd_adr_b[34][8-1:0];
        wire                            ram_row_34_col_0_rd_en_a     = ram_row_rd_en_a[34];
        wire                            ram_row_34_col_0_rd_en_b     = ram_row_rd_en_b[34];
        wire                            ram_row_34_col_0_wr_en_a     = |ram_col_wr_en_a[34][0];
        wire                            ram_row_34_col_0_wr_en_b     = |ram_col_wr_en_b[34][0];
        wire    [34-1:0]              ram_row_34_col_0_data_in_a   = ram_wr_data_a_col[0][34-1:0];
        wire    [34-1:0]              ram_row_34_col_0_data_in_b   = ram_wr_data_b_col[0][34-1:0];
        wire    [34-1:0]              ram_row_34_col_0_data_out_a;
        wire    [34-1:0]              ram_row_34_col_0_data_out_b;
        wire    [2:0]                   ram_row_34_col_0_aary_pwren_b;
        wire                            ram_row_34_col_0_vcc = 1'b1;
        
        
        ip783rfhs2r2w256x34s0c1p1d0_dft_wrp #(
                    )
        ram_row_34_col_0 (
                    //------------------------------------------------------------
                    // Functional Interfaces
                    //------------------------------------------------------------      
        
                     .CLKWR_P0                (ram_row_34_col_0_clk_a),
                     .ADRWR_P0                (ADRWR_P0_ts27),
                     .WREN_P0                 (WREN_P0_ts27),
                     .DIN_P0                  (DIN_P0_ts27),
        
                     .CLKWR_P1                (ram_row_34_col_0_clk_b),
                     .ADRWR_P1                (ADRWR_P1_ts27),
                     .WREN_P1                 (WREN_P1_ts27),
                     .DIN_P1                  (DIN_P1_ts27),
        
                     .CLKRD_P0                (ram_row_34_col_0_clk_a),
                     .ADRRD_P0                (ADRRD_P0_ts27),
                     .RDEN_P0                 (RDEN_P0_ts27),
                     .QOUT_P0                 (ram_row_34_col_0_data_out_a),
                         
                     .CLKRD_P1                (ram_row_34_col_0_clk_b),
                     .ADRRD_P1                (ADRRD_P1_ts27),
                     .RDEN_P1                 (RDEN_P1_ts27),
                     .QOUT_P1                 (ram_row_34_col_0_data_out_b),                
                                                     
                    
                   //-------------------------------------------------------------
                   // Power Management Interfaces
                   //-------------------------------------------------------------
                  //   .PWR_MGMT_IN                        ({pwr_mgmt_in_rf[PWR_MGMT_IN_SIZE-1:1],ram_fary_pwren_b[34]}), // MSB changed from 3'b100
                  //   .PWR_MGMT_OUT                       (ram_aary_pwren_b[34]),  
                
                       
                     `ifndef INTEL_NO_PWR_PINS
                        .vddp                            (ram_row_34_col_0_vcc),
                        `ifdef INTC_ADD_VSS
                        .vss                            (1'b0),
                        `endif  
                     `endif
               
        
        
        
                      //REPAIR INPUTS
        
                    .FCA           (ram_row_34_col_0_bisr_inst_Q[6:1]), // column repair addres --- > F means faulty
                    .CRE          (ram_row_34_col_0_bisr_inst_Q[0]), //Column repair enable
                    
        
                    // POWER MGMT inputs
                    //.ROP_SD             (), // shutoffout
                    //.ROP_DS             (), //dpslp_or_shutoffout
                    //TEMPCOMMENT1.MPMS              (1'b0), // {shutoff,deepsleep,fastsleep}
        
                    //TIMING and TRIM
                    // MDST = {async_reset0,async_reset1,wmce,mce,stbyp,rmce}
                    .MDST_hs2r2w       ({fary_ffuse_rfhs2r2w_trim[9],fary_ffuse_rfhs2r2w_trim[8],fary_ffuse_rfhs2r2w_trim[7:5],fary_ffuse_rfhs2r2w_trim[4],fary_ffuse_rfhs2r2w_trim[3],fary_ffuse_rfhs2r2w_trim[2:0]}),
                                        
        
                    //DFT inputs
                    .DFTSHIFTEN        (DFTSHIFTEN),
                    .DFTMASK           (DFTMASK),
                    .DFT_ARRAY_FREEZE    (DFT_ARRAY_FREEZE),
                    
                    .DFT_AFD_RESET_B    (DFT_AFD_RESET_B)
        
        
        
        );//ip783rfhs2r2w256x34s0c1p1d0_dft_wrp
        
        assign          ram_rd_data_a_col[34][0]    = ram_row_34_col_0_data_out_a;
        assign          ram_rd_data_b_col[34][0]    = ram_row_34_col_0_data_out_b;
        
             

        wire                            ram_row_35_col_0_clk_a       = clk_a;
        wire                            ram_row_35_col_0_clk_b       = clk_b;
        wire    [8-1:0]       ram_row_35_col_0_wr_adr_a    = ram_row_wr_adr_a[35][8-1:0];
        wire    [8-1:0]       ram_row_35_col_0_wr_adr_b    = ram_row_wr_adr_b[35][8-1:0];
        wire    [8-1:0]       ram_row_35_col_0_rd_adr_a    = ram_row_rd_adr_a[35][8-1:0];
        wire    [8-1:0]       ram_row_35_col_0_rd_adr_b    = ram_row_rd_adr_b[35][8-1:0];
        wire                            ram_row_35_col_0_rd_en_a     = ram_row_rd_en_a[35];
        wire                            ram_row_35_col_0_rd_en_b     = ram_row_rd_en_b[35];
        wire                            ram_row_35_col_0_wr_en_a     = |ram_col_wr_en_a[35][0];
        wire                            ram_row_35_col_0_wr_en_b     = |ram_col_wr_en_b[35][0];
        wire    [34-1:0]              ram_row_35_col_0_data_in_a   = ram_wr_data_a_col[0][34-1:0];
        wire    [34-1:0]              ram_row_35_col_0_data_in_b   = ram_wr_data_b_col[0][34-1:0];
        wire    [34-1:0]              ram_row_35_col_0_data_out_a;
        wire    [34-1:0]              ram_row_35_col_0_data_out_b;
        wire    [2:0]                   ram_row_35_col_0_aary_pwren_b;
        wire                            ram_row_35_col_0_vcc = 1'b1;
        
        
        ip783rfhs2r2w256x34s0c1p1d0_dft_wrp #(
                    )
        ram_row_35_col_0 (
                    //------------------------------------------------------------
                    // Functional Interfaces
                    //------------------------------------------------------------      
        
                     .CLKWR_P0                (ram_row_35_col_0_clk_a),
                     .ADRWR_P0                (ADRWR_P0_ts28),
                     .WREN_P0                 (WREN_P0_ts28),
                     .DIN_P0                  (DIN_P0_ts28),
        
                     .CLKWR_P1                (ram_row_35_col_0_clk_b),
                     .ADRWR_P1                (ADRWR_P1_ts28),
                     .WREN_P1                 (WREN_P1_ts28),
                     .DIN_P1                  (DIN_P1_ts28),
        
                     .CLKRD_P0                (ram_row_35_col_0_clk_a),
                     .ADRRD_P0                (ADRRD_P0_ts28),
                     .RDEN_P0                 (RDEN_P0_ts28),
                     .QOUT_P0                 (ram_row_35_col_0_data_out_a),
                         
                     .CLKRD_P1                (ram_row_35_col_0_clk_b),
                     .ADRRD_P1                (ADRRD_P1_ts28),
                     .RDEN_P1                 (RDEN_P1_ts28),
                     .QOUT_P1                 (ram_row_35_col_0_data_out_b),                
                                                     
                    
                   //-------------------------------------------------------------
                   // Power Management Interfaces
                   //-------------------------------------------------------------
                  //   .PWR_MGMT_IN                        ({pwr_mgmt_in_rf[PWR_MGMT_IN_SIZE-1:1],ram_fary_pwren_b[35]}), // MSB changed from 3'b100
                  //   .PWR_MGMT_OUT                       (ram_aary_pwren_b[35]),  
                
                       
                     `ifndef INTEL_NO_PWR_PINS
                        .vddp                            (ram_row_35_col_0_vcc),
                        `ifdef INTC_ADD_VSS
                        .vss                            (1'b0),
                        `endif  
                     `endif
               
        
        
        
                      //REPAIR INPUTS
        
                    .FCA           (ram_row_35_col_0_bisr_inst_Q[6:1]), // column repair addres --- > F means faulty
                    .CRE          (ram_row_35_col_0_bisr_inst_Q[0]), //Column repair enable
                    
        
                    // POWER MGMT inputs
                    //.ROP_SD             (), // shutoffout
                    //.ROP_DS             (), //dpslp_or_shutoffout
                    //TEMPCOMMENT1.MPMS              (1'b0), // {shutoff,deepsleep,fastsleep}
        
                    //TIMING and TRIM
                    // MDST = {async_reset0,async_reset1,wmce,mce,stbyp,rmce}
                    .MDST_hs2r2w       ({fary_ffuse_rfhs2r2w_trim[9],fary_ffuse_rfhs2r2w_trim[8],fary_ffuse_rfhs2r2w_trim[7:5],fary_ffuse_rfhs2r2w_trim[4],fary_ffuse_rfhs2r2w_trim[3],fary_ffuse_rfhs2r2w_trim[2:0]}),
                                        
        
                    //DFT inputs
                    .DFTSHIFTEN        (DFTSHIFTEN),
                    .DFTMASK           (DFTMASK),
                    .DFT_ARRAY_FREEZE    (DFT_ARRAY_FREEZE),
                    
                    .DFT_AFD_RESET_B    (DFT_AFD_RESET_B)
        
        
        
        );//ip783rfhs2r2w256x34s0c1p1d0_dft_wrp
        
        assign          ram_rd_data_a_col[35][0]    = ram_row_35_col_0_data_out_a;
        assign          ram_rd_data_b_col[35][0]    = ram_row_35_col_0_data_out_b;
        
             

        wire                            ram_row_36_col_0_clk_a       = clk_a;
        wire                            ram_row_36_col_0_clk_b       = clk_b;
        wire    [8-1:0]       ram_row_36_col_0_wr_adr_a    = ram_row_wr_adr_a[36][8-1:0];
        wire    [8-1:0]       ram_row_36_col_0_wr_adr_b    = ram_row_wr_adr_b[36][8-1:0];
        wire    [8-1:0]       ram_row_36_col_0_rd_adr_a    = ram_row_rd_adr_a[36][8-1:0];
        wire    [8-1:0]       ram_row_36_col_0_rd_adr_b    = ram_row_rd_adr_b[36][8-1:0];
        wire                            ram_row_36_col_0_rd_en_a     = ram_row_rd_en_a[36];
        wire                            ram_row_36_col_0_rd_en_b     = ram_row_rd_en_b[36];
        wire                            ram_row_36_col_0_wr_en_a     = |ram_col_wr_en_a[36][0];
        wire                            ram_row_36_col_0_wr_en_b     = |ram_col_wr_en_b[36][0];
        wire    [34-1:0]              ram_row_36_col_0_data_in_a   = ram_wr_data_a_col[0][34-1:0];
        wire    [34-1:0]              ram_row_36_col_0_data_in_b   = ram_wr_data_b_col[0][34-1:0];
        wire    [34-1:0]              ram_row_36_col_0_data_out_a;
        wire    [34-1:0]              ram_row_36_col_0_data_out_b;
        wire    [2:0]                   ram_row_36_col_0_aary_pwren_b;
        wire                            ram_row_36_col_0_vcc = 1'b1;
        
        
        ip783rfhs2r2w256x34s0c1p1d0_dft_wrp #(
                    )
        ram_row_36_col_0 (
                    //------------------------------------------------------------
                    // Functional Interfaces
                    //------------------------------------------------------------      
        
                     .CLKWR_P0                (ram_row_36_col_0_clk_a),
                     .ADRWR_P0                (ADRWR_P0_ts29),
                     .WREN_P0                 (WREN_P0_ts29),
                     .DIN_P0                  (DIN_P0_ts29),
        
                     .CLKWR_P1                (ram_row_36_col_0_clk_b),
                     .ADRWR_P1                (ADRWR_P1_ts29),
                     .WREN_P1                 (WREN_P1_ts29),
                     .DIN_P1                  (DIN_P1_ts29),
        
                     .CLKRD_P0                (ram_row_36_col_0_clk_a),
                     .ADRRD_P0                (ADRRD_P0_ts29),
                     .RDEN_P0                 (RDEN_P0_ts29),
                     .QOUT_P0                 (ram_row_36_col_0_data_out_a),
                         
                     .CLKRD_P1                (ram_row_36_col_0_clk_b),
                     .ADRRD_P1                (ADRRD_P1_ts29),
                     .RDEN_P1                 (RDEN_P1_ts29),
                     .QOUT_P1                 (ram_row_36_col_0_data_out_b),                
                                                     
                    
                   //-------------------------------------------------------------
                   // Power Management Interfaces
                   //-------------------------------------------------------------
                  //   .PWR_MGMT_IN                        ({pwr_mgmt_in_rf[PWR_MGMT_IN_SIZE-1:1],ram_fary_pwren_b[36]}), // MSB changed from 3'b100
                  //   .PWR_MGMT_OUT                       (ram_aary_pwren_b[36]),  
                
                       
                     `ifndef INTEL_NO_PWR_PINS
                        .vddp                            (ram_row_36_col_0_vcc),
                        `ifdef INTC_ADD_VSS
                        .vss                            (1'b0),
                        `endif  
                     `endif
               
        
        
        
                      //REPAIR INPUTS
        
                    .FCA           (ram_row_36_col_0_bisr_inst_Q[6:1]), // column repair addres --- > F means faulty
                    .CRE          (ram_row_36_col_0_bisr_inst_Q[0]), //Column repair enable
                    
        
                    // POWER MGMT inputs
                    //.ROP_SD             (), // shutoffout
                    //.ROP_DS             (), //dpslp_or_shutoffout
                    //TEMPCOMMENT1.MPMS              (1'b0), // {shutoff,deepsleep,fastsleep}
        
                    //TIMING and TRIM
                    // MDST = {async_reset0,async_reset1,wmce,mce,stbyp,rmce}
                    .MDST_hs2r2w       ({fary_ffuse_rfhs2r2w_trim[9],fary_ffuse_rfhs2r2w_trim[8],fary_ffuse_rfhs2r2w_trim[7:5],fary_ffuse_rfhs2r2w_trim[4],fary_ffuse_rfhs2r2w_trim[3],fary_ffuse_rfhs2r2w_trim[2:0]}),
                                        
        
                    //DFT inputs
                    .DFTSHIFTEN        (DFTSHIFTEN),
                    .DFTMASK           (DFTMASK),
                    .DFT_ARRAY_FREEZE    (DFT_ARRAY_FREEZE),
                    
                    .DFT_AFD_RESET_B    (DFT_AFD_RESET_B)
        
        
        
        );//ip783rfhs2r2w256x34s0c1p1d0_dft_wrp
        
        assign          ram_rd_data_a_col[36][0]    = ram_row_36_col_0_data_out_a;
        assign          ram_rd_data_b_col[36][0]    = ram_row_36_col_0_data_out_b;
        
             

        wire                            ram_row_37_col_0_clk_a       = clk_a;
        wire                            ram_row_37_col_0_clk_b       = clk_b;
        wire    [8-1:0]       ram_row_37_col_0_wr_adr_a    = ram_row_wr_adr_a[37][8-1:0];
        wire    [8-1:0]       ram_row_37_col_0_wr_adr_b    = ram_row_wr_adr_b[37][8-1:0];
        wire    [8-1:0]       ram_row_37_col_0_rd_adr_a    = ram_row_rd_adr_a[37][8-1:0];
        wire    [8-1:0]       ram_row_37_col_0_rd_adr_b    = ram_row_rd_adr_b[37][8-1:0];
        wire                            ram_row_37_col_0_rd_en_a     = ram_row_rd_en_a[37];
        wire                            ram_row_37_col_0_rd_en_b     = ram_row_rd_en_b[37];
        wire                            ram_row_37_col_0_wr_en_a     = |ram_col_wr_en_a[37][0];
        wire                            ram_row_37_col_0_wr_en_b     = |ram_col_wr_en_b[37][0];
        wire    [34-1:0]              ram_row_37_col_0_data_in_a   = ram_wr_data_a_col[0][34-1:0];
        wire    [34-1:0]              ram_row_37_col_0_data_in_b   = ram_wr_data_b_col[0][34-1:0];
        wire    [34-1:0]              ram_row_37_col_0_data_out_a;
        wire    [34-1:0]              ram_row_37_col_0_data_out_b;
        wire    [2:0]                   ram_row_37_col_0_aary_pwren_b;
        wire                            ram_row_37_col_0_vcc = 1'b1;
        
        
        ip783rfhs2r2w256x34s0c1p1d0_dft_wrp #(
                    )
        ram_row_37_col_0 (
                    //------------------------------------------------------------
                    // Functional Interfaces
                    //------------------------------------------------------------      
        
                     .CLKWR_P0                (ram_row_37_col_0_clk_a),
                     .ADRWR_P0                (ADRWR_P0_ts30),
                     .WREN_P0                 (WREN_P0_ts30),
                     .DIN_P0                  (DIN_P0_ts30),
        
                     .CLKWR_P1                (ram_row_37_col_0_clk_b),
                     .ADRWR_P1                (ADRWR_P1_ts30),
                     .WREN_P1                 (WREN_P1_ts30),
                     .DIN_P1                  (DIN_P1_ts30),
        
                     .CLKRD_P0                (ram_row_37_col_0_clk_a),
                     .ADRRD_P0                (ADRRD_P0_ts30),
                     .RDEN_P0                 (RDEN_P0_ts30),
                     .QOUT_P0                 (ram_row_37_col_0_data_out_a),
                         
                     .CLKRD_P1                (ram_row_37_col_0_clk_b),
                     .ADRRD_P1                (ADRRD_P1_ts30),
                     .RDEN_P1                 (RDEN_P1_ts30),
                     .QOUT_P1                 (ram_row_37_col_0_data_out_b),                
                                                     
                    
                   //-------------------------------------------------------------
                   // Power Management Interfaces
                   //-------------------------------------------------------------
                  //   .PWR_MGMT_IN                        ({pwr_mgmt_in_rf[PWR_MGMT_IN_SIZE-1:1],ram_fary_pwren_b[37]}), // MSB changed from 3'b100
                  //   .PWR_MGMT_OUT                       (ram_aary_pwren_b[37]),  
                
                       
                     `ifndef INTEL_NO_PWR_PINS
                        .vddp                            (ram_row_37_col_0_vcc),
                        `ifdef INTC_ADD_VSS
                        .vss                            (1'b0),
                        `endif  
                     `endif
               
        
        
        
                      //REPAIR INPUTS
        
                    .FCA           (ram_row_37_col_0_bisr_inst_Q[6:1]), // column repair addres --- > F means faulty
                    .CRE          (ram_row_37_col_0_bisr_inst_Q[0]), //Column repair enable
                    
        
                    // POWER MGMT inputs
                    //.ROP_SD             (), // shutoffout
                    //.ROP_DS             (), //dpslp_or_shutoffout
                    //TEMPCOMMENT1.MPMS              (1'b0), // {shutoff,deepsleep,fastsleep}
        
                    //TIMING and TRIM
                    // MDST = {async_reset0,async_reset1,wmce,mce,stbyp,rmce}
                    .MDST_hs2r2w       ({fary_ffuse_rfhs2r2w_trim[9],fary_ffuse_rfhs2r2w_trim[8],fary_ffuse_rfhs2r2w_trim[7:5],fary_ffuse_rfhs2r2w_trim[4],fary_ffuse_rfhs2r2w_trim[3],fary_ffuse_rfhs2r2w_trim[2:0]}),
                                        
        
                    //DFT inputs
                    .DFTSHIFTEN        (DFTSHIFTEN),
                    .DFTMASK           (DFTMASK),
                    .DFT_ARRAY_FREEZE    (DFT_ARRAY_FREEZE),
                    
                    .DFT_AFD_RESET_B    (DFT_AFD_RESET_B)
        
        
        
        );//ip783rfhs2r2w256x34s0c1p1d0_dft_wrp
        
        assign          ram_rd_data_a_col[37][0]    = ram_row_37_col_0_data_out_a;
        assign          ram_rd_data_b_col[37][0]    = ram_row_37_col_0_data_out_b;
        
             

        wire                            ram_row_38_col_0_clk_a       = clk_a;
        wire                            ram_row_38_col_0_clk_b       = clk_b;
        wire    [8-1:0]       ram_row_38_col_0_wr_adr_a    = ram_row_wr_adr_a[38][8-1:0];
        wire    [8-1:0]       ram_row_38_col_0_wr_adr_b    = ram_row_wr_adr_b[38][8-1:0];
        wire    [8-1:0]       ram_row_38_col_0_rd_adr_a    = ram_row_rd_adr_a[38][8-1:0];
        wire    [8-1:0]       ram_row_38_col_0_rd_adr_b    = ram_row_rd_adr_b[38][8-1:0];
        wire                            ram_row_38_col_0_rd_en_a     = ram_row_rd_en_a[38];
        wire                            ram_row_38_col_0_rd_en_b     = ram_row_rd_en_b[38];
        wire                            ram_row_38_col_0_wr_en_a     = |ram_col_wr_en_a[38][0];
        wire                            ram_row_38_col_0_wr_en_b     = |ram_col_wr_en_b[38][0];
        wire    [34-1:0]              ram_row_38_col_0_data_in_a   = ram_wr_data_a_col[0][34-1:0];
        wire    [34-1:0]              ram_row_38_col_0_data_in_b   = ram_wr_data_b_col[0][34-1:0];
        wire    [34-1:0]              ram_row_38_col_0_data_out_a;
        wire    [34-1:0]              ram_row_38_col_0_data_out_b;
        wire    [2:0]                   ram_row_38_col_0_aary_pwren_b;
        wire                            ram_row_38_col_0_vcc = 1'b1;
        
        
        ip783rfhs2r2w256x34s0c1p1d0_dft_wrp #(
                    )
        ram_row_38_col_0 (
                    //------------------------------------------------------------
                    // Functional Interfaces
                    //------------------------------------------------------------      
        
                     .CLKWR_P0                (ram_row_38_col_0_clk_a),
                     .ADRWR_P0                (ADRWR_P0_ts31),
                     .WREN_P0                 (WREN_P0_ts31),
                     .DIN_P0                  (DIN_P0_ts31),
        
                     .CLKWR_P1                (ram_row_38_col_0_clk_b),
                     .ADRWR_P1                (ADRWR_P1_ts31),
                     .WREN_P1                 (WREN_P1_ts31),
                     .DIN_P1                  (DIN_P1_ts31),
        
                     .CLKRD_P0                (ram_row_38_col_0_clk_a),
                     .ADRRD_P0                (ADRRD_P0_ts31),
                     .RDEN_P0                 (RDEN_P0_ts31),
                     .QOUT_P0                 (ram_row_38_col_0_data_out_a),
                         
                     .CLKRD_P1                (ram_row_38_col_0_clk_b),
                     .ADRRD_P1                (ADRRD_P1_ts31),
                     .RDEN_P1                 (RDEN_P1_ts31),
                     .QOUT_P1                 (ram_row_38_col_0_data_out_b),                
                                                     
                    
                   //-------------------------------------------------------------
                   // Power Management Interfaces
                   //-------------------------------------------------------------
                  //   .PWR_MGMT_IN                        ({pwr_mgmt_in_rf[PWR_MGMT_IN_SIZE-1:1],ram_fary_pwren_b[38]}), // MSB changed from 3'b100
                  //   .PWR_MGMT_OUT                       (ram_aary_pwren_b[38]),  
                
                       
                     `ifndef INTEL_NO_PWR_PINS
                        .vddp                            (ram_row_38_col_0_vcc),
                        `ifdef INTC_ADD_VSS
                        .vss                            (1'b0),
                        `endif  
                     `endif
               
        
        
        
                      //REPAIR INPUTS
        
                    .FCA           (ram_row_38_col_0_bisr_inst_Q[6:1]), // column repair addres --- > F means faulty
                    .CRE          (ram_row_38_col_0_bisr_inst_Q[0]), //Column repair enable
                    
        
                    // POWER MGMT inputs
                    //.ROP_SD             (), // shutoffout
                    //.ROP_DS             (), //dpslp_or_shutoffout
                    //TEMPCOMMENT1.MPMS              (1'b0), // {shutoff,deepsleep,fastsleep}
        
                    //TIMING and TRIM
                    // MDST = {async_reset0,async_reset1,wmce,mce,stbyp,rmce}
                    .MDST_hs2r2w       ({fary_ffuse_rfhs2r2w_trim[9],fary_ffuse_rfhs2r2w_trim[8],fary_ffuse_rfhs2r2w_trim[7:5],fary_ffuse_rfhs2r2w_trim[4],fary_ffuse_rfhs2r2w_trim[3],fary_ffuse_rfhs2r2w_trim[2:0]}),
                                        
        
                    //DFT inputs
                    .DFTSHIFTEN        (DFTSHIFTEN),
                    .DFTMASK           (DFTMASK),
                    .DFT_ARRAY_FREEZE    (DFT_ARRAY_FREEZE),
                    
                    .DFT_AFD_RESET_B    (DFT_AFD_RESET_B)
        
        
        
        );//ip783rfhs2r2w256x34s0c1p1d0_dft_wrp
        
        assign          ram_rd_data_a_col[38][0]    = ram_row_38_col_0_data_out_a;
        assign          ram_rd_data_b_col[38][0]    = ram_row_38_col_0_data_out_b;
        
             

        wire                            ram_row_39_col_0_clk_a       = clk_a;
        wire                            ram_row_39_col_0_clk_b       = clk_b;
        wire    [8-1:0]       ram_row_39_col_0_wr_adr_a    = ram_row_wr_adr_a[39][8-1:0];
        wire    [8-1:0]       ram_row_39_col_0_wr_adr_b    = ram_row_wr_adr_b[39][8-1:0];
        wire    [8-1:0]       ram_row_39_col_0_rd_adr_a    = ram_row_rd_adr_a[39][8-1:0];
        wire    [8-1:0]       ram_row_39_col_0_rd_adr_b    = ram_row_rd_adr_b[39][8-1:0];
        wire                            ram_row_39_col_0_rd_en_a     = ram_row_rd_en_a[39];
        wire                            ram_row_39_col_0_rd_en_b     = ram_row_rd_en_b[39];
        wire                            ram_row_39_col_0_wr_en_a     = |ram_col_wr_en_a[39][0];
        wire                            ram_row_39_col_0_wr_en_b     = |ram_col_wr_en_b[39][0];
        wire    [34-1:0]              ram_row_39_col_0_data_in_a   = ram_wr_data_a_col[0][34-1:0];
        wire    [34-1:0]              ram_row_39_col_0_data_in_b   = ram_wr_data_b_col[0][34-1:0];
        wire    [34-1:0]              ram_row_39_col_0_data_out_a;
        wire    [34-1:0]              ram_row_39_col_0_data_out_b;
        wire    [2:0]                   ram_row_39_col_0_aary_pwren_b;
        wire                            ram_row_39_col_0_vcc = 1'b1;
        
        
        ip783rfhs2r2w256x34s0c1p1d0_dft_wrp #(
                    )
        ram_row_39_col_0 (
                    //------------------------------------------------------------
                    // Functional Interfaces
                    //------------------------------------------------------------      
        
                     .CLKWR_P0                (ram_row_39_col_0_clk_a),
                     .ADRWR_P0                (ADRWR_P0_ts32),
                     .WREN_P0                 (WREN_P0_ts32),
                     .DIN_P0                  (DIN_P0_ts32),
        
                     .CLKWR_P1                (ram_row_39_col_0_clk_b),
                     .ADRWR_P1                (ADRWR_P1_ts32),
                     .WREN_P1                 (WREN_P1_ts32),
                     .DIN_P1                  (DIN_P1_ts32),
        
                     .CLKRD_P0                (ram_row_39_col_0_clk_a),
                     .ADRRD_P0                (ADRRD_P0_ts32),
                     .RDEN_P0                 (RDEN_P0_ts32),
                     .QOUT_P0                 (ram_row_39_col_0_data_out_a),
                         
                     .CLKRD_P1                (ram_row_39_col_0_clk_b),
                     .ADRRD_P1                (ADRRD_P1_ts32),
                     .RDEN_P1                 (RDEN_P1_ts32),
                     .QOUT_P1                 (ram_row_39_col_0_data_out_b),                
                                                     
                    
                   //-------------------------------------------------------------
                   // Power Management Interfaces
                   //-------------------------------------------------------------
                  //   .PWR_MGMT_IN                        ({pwr_mgmt_in_rf[PWR_MGMT_IN_SIZE-1:1],ram_fary_pwren_b[39]}), // MSB changed from 3'b100
                  //   .PWR_MGMT_OUT                       (ram_aary_pwren_b[39]),  
                
                       
                     `ifndef INTEL_NO_PWR_PINS
                        .vddp                            (ram_row_39_col_0_vcc),
                        `ifdef INTC_ADD_VSS
                        .vss                            (1'b0),
                        `endif  
                     `endif
               
        
        
        
                      //REPAIR INPUTS
        
                    .FCA           (ram_row_39_col_0_bisr_inst_Q[6:1]), // column repair addres --- > F means faulty
                    .CRE          (ram_row_39_col_0_bisr_inst_Q[0]), //Column repair enable
                    
        
                    // POWER MGMT inputs
                    //.ROP_SD             (), // shutoffout
                    //.ROP_DS             (), //dpslp_or_shutoffout
                    //TEMPCOMMENT1.MPMS              (1'b0), // {shutoff,deepsleep,fastsleep}
        
                    //TIMING and TRIM
                    // MDST = {async_reset0,async_reset1,wmce,mce,stbyp,rmce}
                    .MDST_hs2r2w       ({fary_ffuse_rfhs2r2w_trim[9],fary_ffuse_rfhs2r2w_trim[8],fary_ffuse_rfhs2r2w_trim[7:5],fary_ffuse_rfhs2r2w_trim[4],fary_ffuse_rfhs2r2w_trim[3],fary_ffuse_rfhs2r2w_trim[2:0]}),
                                        
        
                    //DFT inputs
                    .DFTSHIFTEN        (DFTSHIFTEN),
                    .DFTMASK           (DFTMASK),
                    .DFT_ARRAY_FREEZE    (DFT_ARRAY_FREEZE),
                    
                    .DFT_AFD_RESET_B    (DFT_AFD_RESET_B)
        
        
        
        );//ip783rfhs2r2w256x34s0c1p1d0_dft_wrp
        
        assign          ram_rd_data_a_col[39][0]    = ram_row_39_col_0_data_out_a;
        assign          ram_rd_data_b_col[39][0]    = ram_row_39_col_0_data_out_b;
        
             

        wire                            ram_row_40_col_0_clk_a       = clk_a;
        wire                            ram_row_40_col_0_clk_b       = clk_b;
        wire    [8-1:0]       ram_row_40_col_0_wr_adr_a    = ram_row_wr_adr_a[40][8-1:0];
        wire    [8-1:0]       ram_row_40_col_0_wr_adr_b    = ram_row_wr_adr_b[40][8-1:0];
        wire    [8-1:0]       ram_row_40_col_0_rd_adr_a    = ram_row_rd_adr_a[40][8-1:0];
        wire    [8-1:0]       ram_row_40_col_0_rd_adr_b    = ram_row_rd_adr_b[40][8-1:0];
        wire                            ram_row_40_col_0_rd_en_a     = ram_row_rd_en_a[40];
        wire                            ram_row_40_col_0_rd_en_b     = ram_row_rd_en_b[40];
        wire                            ram_row_40_col_0_wr_en_a     = |ram_col_wr_en_a[40][0];
        wire                            ram_row_40_col_0_wr_en_b     = |ram_col_wr_en_b[40][0];
        wire    [34-1:0]              ram_row_40_col_0_data_in_a   = ram_wr_data_a_col[0][34-1:0];
        wire    [34-1:0]              ram_row_40_col_0_data_in_b   = ram_wr_data_b_col[0][34-1:0];
        wire    [34-1:0]              ram_row_40_col_0_data_out_a;
        wire    [34-1:0]              ram_row_40_col_0_data_out_b;
        wire    [2:0]                   ram_row_40_col_0_aary_pwren_b;
        wire                            ram_row_40_col_0_vcc = 1'b1;
        
        
        ip783rfhs2r2w256x34s0c1p1d0_dft_wrp #(
                    )
        ram_row_40_col_0 (
                    //------------------------------------------------------------
                    // Functional Interfaces
                    //------------------------------------------------------------      
        
                     .CLKWR_P0                (ram_row_40_col_0_clk_a),
                     .ADRWR_P0                (ADRWR_P0_ts34),
                     .WREN_P0                 (WREN_P0_ts34),
                     .DIN_P0                  (DIN_P0_ts34),
        
                     .CLKWR_P1                (ram_row_40_col_0_clk_b),
                     .ADRWR_P1                (ADRWR_P1_ts34),
                     .WREN_P1                 (WREN_P1_ts34),
                     .DIN_P1                  (DIN_P1_ts34),
        
                     .CLKRD_P0                (ram_row_40_col_0_clk_a),
                     .ADRRD_P0                (ADRRD_P0_ts34),
                     .RDEN_P0                 (RDEN_P0_ts34),
                     .QOUT_P0                 (ram_row_40_col_0_data_out_a),
                         
                     .CLKRD_P1                (ram_row_40_col_0_clk_b),
                     .ADRRD_P1                (ADRRD_P1_ts34),
                     .RDEN_P1                 (RDEN_P1_ts34),
                     .QOUT_P1                 (ram_row_40_col_0_data_out_b),                
                                                     
                    
                   //-------------------------------------------------------------
                   // Power Management Interfaces
                   //-------------------------------------------------------------
                  //   .PWR_MGMT_IN                        ({pwr_mgmt_in_rf[PWR_MGMT_IN_SIZE-1:1],ram_fary_pwren_b[40]}), // MSB changed from 3'b100
                  //   .PWR_MGMT_OUT                       (ram_aary_pwren_b[40]),  
                
                       
                     `ifndef INTEL_NO_PWR_PINS
                        .vddp                            (ram_row_40_col_0_vcc),
                        `ifdef INTC_ADD_VSS
                        .vss                            (1'b0),
                        `endif  
                     `endif
               
        
        
        
                      //REPAIR INPUTS
        
                    .FCA           (ram_row_40_col_0_bisr_inst_Q[6:1]), // column repair addres --- > F means faulty
                    .CRE          (ram_row_40_col_0_bisr_inst_Q[0]), //Column repair enable
                    
        
                    // POWER MGMT inputs
                    //.ROP_SD             (), // shutoffout
                    //.ROP_DS             (), //dpslp_or_shutoffout
                    //TEMPCOMMENT1.MPMS              (1'b0), // {shutoff,deepsleep,fastsleep}
        
                    //TIMING and TRIM
                    // MDST = {async_reset0,async_reset1,wmce,mce,stbyp,rmce}
                    .MDST_hs2r2w       ({fary_ffuse_rfhs2r2w_trim[9],fary_ffuse_rfhs2r2w_trim[8],fary_ffuse_rfhs2r2w_trim[7:5],fary_ffuse_rfhs2r2w_trim[4],fary_ffuse_rfhs2r2w_trim[3],fary_ffuse_rfhs2r2w_trim[2:0]}),
                                        
        
                    //DFT inputs
                    .DFTSHIFTEN        (DFTSHIFTEN),
                    .DFTMASK           (DFTMASK),
                    .DFT_ARRAY_FREEZE    (DFT_ARRAY_FREEZE),
                    
                    .DFT_AFD_RESET_B    (DFT_AFD_RESET_B)
        
        
        
        );//ip783rfhs2r2w256x34s0c1p1d0_dft_wrp
        
        assign          ram_rd_data_a_col[40][0]    = ram_row_40_col_0_data_out_a;
        assign          ram_rd_data_b_col[40][0]    = ram_row_40_col_0_data_out_b;
        
             

        wire                            ram_row_41_col_0_clk_a       = clk_a;
        wire                            ram_row_41_col_0_clk_b       = clk_b;
        wire    [8-1:0]       ram_row_41_col_0_wr_adr_a    = ram_row_wr_adr_a[41][8-1:0];
        wire    [8-1:0]       ram_row_41_col_0_wr_adr_b    = ram_row_wr_adr_b[41][8-1:0];
        wire    [8-1:0]       ram_row_41_col_0_rd_adr_a    = ram_row_rd_adr_a[41][8-1:0];
        wire    [8-1:0]       ram_row_41_col_0_rd_adr_b    = ram_row_rd_adr_b[41][8-1:0];
        wire                            ram_row_41_col_0_rd_en_a     = ram_row_rd_en_a[41];
        wire                            ram_row_41_col_0_rd_en_b     = ram_row_rd_en_b[41];
        wire                            ram_row_41_col_0_wr_en_a     = |ram_col_wr_en_a[41][0];
        wire                            ram_row_41_col_0_wr_en_b     = |ram_col_wr_en_b[41][0];
        wire    [34-1:0]              ram_row_41_col_0_data_in_a   = ram_wr_data_a_col[0][34-1:0];
        wire    [34-1:0]              ram_row_41_col_0_data_in_b   = ram_wr_data_b_col[0][34-1:0];
        wire    [34-1:0]              ram_row_41_col_0_data_out_a;
        wire    [34-1:0]              ram_row_41_col_0_data_out_b;
        wire    [2:0]                   ram_row_41_col_0_aary_pwren_b;
        wire                            ram_row_41_col_0_vcc = 1'b1;
        
        
        ip783rfhs2r2w256x34s0c1p1d0_dft_wrp #(
                    )
        ram_row_41_col_0 (
                    //------------------------------------------------------------
                    // Functional Interfaces
                    //------------------------------------------------------------      
        
                     .CLKWR_P0                (ram_row_41_col_0_clk_a),
                     .ADRWR_P0                (ADRWR_P0_ts35),
                     .WREN_P0                 (WREN_P0_ts35),
                     .DIN_P0                  (DIN_P0_ts35),
        
                     .CLKWR_P1                (ram_row_41_col_0_clk_b),
                     .ADRWR_P1                (ADRWR_P1_ts35),
                     .WREN_P1                 (WREN_P1_ts35),
                     .DIN_P1                  (DIN_P1_ts35),
        
                     .CLKRD_P0                (ram_row_41_col_0_clk_a),
                     .ADRRD_P0                (ADRRD_P0_ts35),
                     .RDEN_P0                 (RDEN_P0_ts35),
                     .QOUT_P0                 (ram_row_41_col_0_data_out_a),
                         
                     .CLKRD_P1                (ram_row_41_col_0_clk_b),
                     .ADRRD_P1                (ADRRD_P1_ts35),
                     .RDEN_P1                 (RDEN_P1_ts35),
                     .QOUT_P1                 (ram_row_41_col_0_data_out_b),                
                                                     
                    
                   //-------------------------------------------------------------
                   // Power Management Interfaces
                   //-------------------------------------------------------------
                  //   .PWR_MGMT_IN                        ({pwr_mgmt_in_rf[PWR_MGMT_IN_SIZE-1:1],ram_fary_pwren_b[41]}), // MSB changed from 3'b100
                  //   .PWR_MGMT_OUT                       (ram_aary_pwren_b[41]),  
                
                       
                     `ifndef INTEL_NO_PWR_PINS
                        .vddp                            (ram_row_41_col_0_vcc),
                        `ifdef INTC_ADD_VSS
                        .vss                            (1'b0),
                        `endif  
                     `endif
               
        
        
        
                      //REPAIR INPUTS
        
                    .FCA           (ram_row_41_col_0_bisr_inst_Q[6:1]), // column repair addres --- > F means faulty
                    .CRE          (ram_row_41_col_0_bisr_inst_Q[0]), //Column repair enable
                    
        
                    // POWER MGMT inputs
                    //.ROP_SD             (), // shutoffout
                    //.ROP_DS             (), //dpslp_or_shutoffout
                    //TEMPCOMMENT1.MPMS              (1'b0), // {shutoff,deepsleep,fastsleep}
        
                    //TIMING and TRIM
                    // MDST = {async_reset0,async_reset1,wmce,mce,stbyp,rmce}
                    .MDST_hs2r2w       ({fary_ffuse_rfhs2r2w_trim[9],fary_ffuse_rfhs2r2w_trim[8],fary_ffuse_rfhs2r2w_trim[7:5],fary_ffuse_rfhs2r2w_trim[4],fary_ffuse_rfhs2r2w_trim[3],fary_ffuse_rfhs2r2w_trim[2:0]}),
                                        
        
                    //DFT inputs
                    .DFTSHIFTEN        (DFTSHIFTEN),
                    .DFTMASK           (DFTMASK),
                    .DFT_ARRAY_FREEZE    (DFT_ARRAY_FREEZE),
                    
                    .DFT_AFD_RESET_B    (DFT_AFD_RESET_B)
        
        
        
        );//ip783rfhs2r2w256x34s0c1p1d0_dft_wrp
        
        assign          ram_rd_data_a_col[41][0]    = ram_row_41_col_0_data_out_a;
        assign          ram_rd_data_b_col[41][0]    = ram_row_41_col_0_data_out_b;
        
             

        wire                            ram_row_42_col_0_clk_a       = clk_a;
        wire                            ram_row_42_col_0_clk_b       = clk_b;
        wire    [8-1:0]       ram_row_42_col_0_wr_adr_a    = ram_row_wr_adr_a[42][8-1:0];
        wire    [8-1:0]       ram_row_42_col_0_wr_adr_b    = ram_row_wr_adr_b[42][8-1:0];
        wire    [8-1:0]       ram_row_42_col_0_rd_adr_a    = ram_row_rd_adr_a[42][8-1:0];
        wire    [8-1:0]       ram_row_42_col_0_rd_adr_b    = ram_row_rd_adr_b[42][8-1:0];
        wire                            ram_row_42_col_0_rd_en_a     = ram_row_rd_en_a[42];
        wire                            ram_row_42_col_0_rd_en_b     = ram_row_rd_en_b[42];
        wire                            ram_row_42_col_0_wr_en_a     = |ram_col_wr_en_a[42][0];
        wire                            ram_row_42_col_0_wr_en_b     = |ram_col_wr_en_b[42][0];
        wire    [34-1:0]              ram_row_42_col_0_data_in_a   = ram_wr_data_a_col[0][34-1:0];
        wire    [34-1:0]              ram_row_42_col_0_data_in_b   = ram_wr_data_b_col[0][34-1:0];
        wire    [34-1:0]              ram_row_42_col_0_data_out_a;
        wire    [34-1:0]              ram_row_42_col_0_data_out_b;
        wire    [2:0]                   ram_row_42_col_0_aary_pwren_b;
        wire                            ram_row_42_col_0_vcc = 1'b1;
        
        
        ip783rfhs2r2w256x34s0c1p1d0_dft_wrp #(
                    )
        ram_row_42_col_0 (
                    //------------------------------------------------------------
                    // Functional Interfaces
                    //------------------------------------------------------------      
        
                     .CLKWR_P0                (ram_row_42_col_0_clk_a),
                     .ADRWR_P0                (ADRWR_P0_ts36),
                     .WREN_P0                 (WREN_P0_ts36),
                     .DIN_P0                  (DIN_P0_ts36),
        
                     .CLKWR_P1                (ram_row_42_col_0_clk_b),
                     .ADRWR_P1                (ADRWR_P1_ts36),
                     .WREN_P1                 (WREN_P1_ts36),
                     .DIN_P1                  (DIN_P1_ts36),
        
                     .CLKRD_P0                (ram_row_42_col_0_clk_a),
                     .ADRRD_P0                (ADRRD_P0_ts36),
                     .RDEN_P0                 (RDEN_P0_ts36),
                     .QOUT_P0                 (ram_row_42_col_0_data_out_a),
                         
                     .CLKRD_P1                (ram_row_42_col_0_clk_b),
                     .ADRRD_P1                (ADRRD_P1_ts36),
                     .RDEN_P1                 (RDEN_P1_ts36),
                     .QOUT_P1                 (ram_row_42_col_0_data_out_b),                
                                                     
                    
                   //-------------------------------------------------------------
                   // Power Management Interfaces
                   //-------------------------------------------------------------
                  //   .PWR_MGMT_IN                        ({pwr_mgmt_in_rf[PWR_MGMT_IN_SIZE-1:1],ram_fary_pwren_b[42]}), // MSB changed from 3'b100
                  //   .PWR_MGMT_OUT                       (ram_aary_pwren_b[42]),  
                
                       
                     `ifndef INTEL_NO_PWR_PINS
                        .vddp                            (ram_row_42_col_0_vcc),
                        `ifdef INTC_ADD_VSS
                        .vss                            (1'b0),
                        `endif  
                     `endif
               
        
        
        
                      //REPAIR INPUTS
        
                    .FCA           (ram_row_42_col_0_bisr_inst_Q[6:1]), // column repair addres --- > F means faulty
                    .CRE          (ram_row_42_col_0_bisr_inst_Q[0]), //Column repair enable
                    
        
                    // POWER MGMT inputs
                    //.ROP_SD             (), // shutoffout
                    //.ROP_DS             (), //dpslp_or_shutoffout
                    //TEMPCOMMENT1.MPMS              (1'b0), // {shutoff,deepsleep,fastsleep}
        
                    //TIMING and TRIM
                    // MDST = {async_reset0,async_reset1,wmce,mce,stbyp,rmce}
                    .MDST_hs2r2w       ({fary_ffuse_rfhs2r2w_trim[9],fary_ffuse_rfhs2r2w_trim[8],fary_ffuse_rfhs2r2w_trim[7:5],fary_ffuse_rfhs2r2w_trim[4],fary_ffuse_rfhs2r2w_trim[3],fary_ffuse_rfhs2r2w_trim[2:0]}),
                                        
        
                    //DFT inputs
                    .DFTSHIFTEN        (DFTSHIFTEN),
                    .DFTMASK           (DFTMASK),
                    .DFT_ARRAY_FREEZE    (DFT_ARRAY_FREEZE),
                    
                    .DFT_AFD_RESET_B    (DFT_AFD_RESET_B)
        
        
        
        );//ip783rfhs2r2w256x34s0c1p1d0_dft_wrp
        
        assign          ram_rd_data_a_col[42][0]    = ram_row_42_col_0_data_out_a;
        assign          ram_rd_data_b_col[42][0]    = ram_row_42_col_0_data_out_b;
        
             

        wire                            ram_row_43_col_0_clk_a       = clk_a;
        wire                            ram_row_43_col_0_clk_b       = clk_b;
        wire    [8-1:0]       ram_row_43_col_0_wr_adr_a    = ram_row_wr_adr_a[43][8-1:0];
        wire    [8-1:0]       ram_row_43_col_0_wr_adr_b    = ram_row_wr_adr_b[43][8-1:0];
        wire    [8-1:0]       ram_row_43_col_0_rd_adr_a    = ram_row_rd_adr_a[43][8-1:0];
        wire    [8-1:0]       ram_row_43_col_0_rd_adr_b    = ram_row_rd_adr_b[43][8-1:0];
        wire                            ram_row_43_col_0_rd_en_a     = ram_row_rd_en_a[43];
        wire                            ram_row_43_col_0_rd_en_b     = ram_row_rd_en_b[43];
        wire                            ram_row_43_col_0_wr_en_a     = |ram_col_wr_en_a[43][0];
        wire                            ram_row_43_col_0_wr_en_b     = |ram_col_wr_en_b[43][0];
        wire    [34-1:0]              ram_row_43_col_0_data_in_a   = ram_wr_data_a_col[0][34-1:0];
        wire    [34-1:0]              ram_row_43_col_0_data_in_b   = ram_wr_data_b_col[0][34-1:0];
        wire    [34-1:0]              ram_row_43_col_0_data_out_a;
        wire    [34-1:0]              ram_row_43_col_0_data_out_b;
        wire    [2:0]                   ram_row_43_col_0_aary_pwren_b;
        wire                            ram_row_43_col_0_vcc = 1'b1;
        
        
        ip783rfhs2r2w256x34s0c1p1d0_dft_wrp #(
                    )
        ram_row_43_col_0 (
                    //------------------------------------------------------------
                    // Functional Interfaces
                    //------------------------------------------------------------      
        
                     .CLKWR_P0                (ram_row_43_col_0_clk_a),
                     .ADRWR_P0                (ADRWR_P0_ts37),
                     .WREN_P0                 (WREN_P0_ts37),
                     .DIN_P0                  (DIN_P0_ts37),
        
                     .CLKWR_P1                (ram_row_43_col_0_clk_b),
                     .ADRWR_P1                (ADRWR_P1_ts37),
                     .WREN_P1                 (WREN_P1_ts37),
                     .DIN_P1                  (DIN_P1_ts37),
        
                     .CLKRD_P0                (ram_row_43_col_0_clk_a),
                     .ADRRD_P0                (ADRRD_P0_ts37),
                     .RDEN_P0                 (RDEN_P0_ts37),
                     .QOUT_P0                 (ram_row_43_col_0_data_out_a),
                         
                     .CLKRD_P1                (ram_row_43_col_0_clk_b),
                     .ADRRD_P1                (ADRRD_P1_ts37),
                     .RDEN_P1                 (RDEN_P1_ts37),
                     .QOUT_P1                 (ram_row_43_col_0_data_out_b),                
                                                     
                    
                   //-------------------------------------------------------------
                   // Power Management Interfaces
                   //-------------------------------------------------------------
                  //   .PWR_MGMT_IN                        ({pwr_mgmt_in_rf[PWR_MGMT_IN_SIZE-1:1],ram_fary_pwren_b[43]}), // MSB changed from 3'b100
                  //   .PWR_MGMT_OUT                       (ram_aary_pwren_b[43]),  
                
                       
                     `ifndef INTEL_NO_PWR_PINS
                        .vddp                            (ram_row_43_col_0_vcc),
                        `ifdef INTC_ADD_VSS
                        .vss                            (1'b0),
                        `endif  
                     `endif
               
        
        
        
                      //REPAIR INPUTS
        
                    .FCA           (ram_row_43_col_0_bisr_inst_Q[6:1]), // column repair addres --- > F means faulty
                    .CRE          (ram_row_43_col_0_bisr_inst_Q[0]), //Column repair enable
                    
        
                    // POWER MGMT inputs
                    //.ROP_SD             (), // shutoffout
                    //.ROP_DS             (), //dpslp_or_shutoffout
                    //TEMPCOMMENT1.MPMS              (1'b0), // {shutoff,deepsleep,fastsleep}
        
                    //TIMING and TRIM
                    // MDST = {async_reset0,async_reset1,wmce,mce,stbyp,rmce}
                    .MDST_hs2r2w       ({fary_ffuse_rfhs2r2w_trim[9],fary_ffuse_rfhs2r2w_trim[8],fary_ffuse_rfhs2r2w_trim[7:5],fary_ffuse_rfhs2r2w_trim[4],fary_ffuse_rfhs2r2w_trim[3],fary_ffuse_rfhs2r2w_trim[2:0]}),
                                        
        
                    //DFT inputs
                    .DFTSHIFTEN        (DFTSHIFTEN),
                    .DFTMASK           (DFTMASK),
                    .DFT_ARRAY_FREEZE    (DFT_ARRAY_FREEZE),
                    
                    .DFT_AFD_RESET_B    (DFT_AFD_RESET_B)
        
        
        
        );//ip783rfhs2r2w256x34s0c1p1d0_dft_wrp
        
        assign          ram_rd_data_a_col[43][0]    = ram_row_43_col_0_data_out_a;
        assign          ram_rd_data_b_col[43][0]    = ram_row_43_col_0_data_out_b;
        
             

        wire                            ram_row_44_col_0_clk_a       = clk_a;
        wire                            ram_row_44_col_0_clk_b       = clk_b;
        wire    [8-1:0]       ram_row_44_col_0_wr_adr_a    = ram_row_wr_adr_a[44][8-1:0];
        wire    [8-1:0]       ram_row_44_col_0_wr_adr_b    = ram_row_wr_adr_b[44][8-1:0];
        wire    [8-1:0]       ram_row_44_col_0_rd_adr_a    = ram_row_rd_adr_a[44][8-1:0];
        wire    [8-1:0]       ram_row_44_col_0_rd_adr_b    = ram_row_rd_adr_b[44][8-1:0];
        wire                            ram_row_44_col_0_rd_en_a     = ram_row_rd_en_a[44];
        wire                            ram_row_44_col_0_rd_en_b     = ram_row_rd_en_b[44];
        wire                            ram_row_44_col_0_wr_en_a     = |ram_col_wr_en_a[44][0];
        wire                            ram_row_44_col_0_wr_en_b     = |ram_col_wr_en_b[44][0];
        wire    [34-1:0]              ram_row_44_col_0_data_in_a   = ram_wr_data_a_col[0][34-1:0];
        wire    [34-1:0]              ram_row_44_col_0_data_in_b   = ram_wr_data_b_col[0][34-1:0];
        wire    [34-1:0]              ram_row_44_col_0_data_out_a;
        wire    [34-1:0]              ram_row_44_col_0_data_out_b;
        wire    [2:0]                   ram_row_44_col_0_aary_pwren_b;
        wire                            ram_row_44_col_0_vcc = 1'b1;
        
        
        ip783rfhs2r2w256x34s0c1p1d0_dft_wrp #(
                    )
        ram_row_44_col_0 (
                    //------------------------------------------------------------
                    // Functional Interfaces
                    //------------------------------------------------------------      
        
                     .CLKWR_P0                (ram_row_44_col_0_clk_a),
                     .ADRWR_P0                (ADRWR_P0_ts38),
                     .WREN_P0                 (WREN_P0_ts38),
                     .DIN_P0                  (DIN_P0_ts38),
        
                     .CLKWR_P1                (ram_row_44_col_0_clk_b),
                     .ADRWR_P1                (ADRWR_P1_ts38),
                     .WREN_P1                 (WREN_P1_ts38),
                     .DIN_P1                  (DIN_P1_ts38),
        
                     .CLKRD_P0                (ram_row_44_col_0_clk_a),
                     .ADRRD_P0                (ADRRD_P0_ts38),
                     .RDEN_P0                 (RDEN_P0_ts38),
                     .QOUT_P0                 (ram_row_44_col_0_data_out_a),
                         
                     .CLKRD_P1                (ram_row_44_col_0_clk_b),
                     .ADRRD_P1                (ADRRD_P1_ts38),
                     .RDEN_P1                 (RDEN_P1_ts38),
                     .QOUT_P1                 (ram_row_44_col_0_data_out_b),                
                                                     
                    
                   //-------------------------------------------------------------
                   // Power Management Interfaces
                   //-------------------------------------------------------------
                  //   .PWR_MGMT_IN                        ({pwr_mgmt_in_rf[PWR_MGMT_IN_SIZE-1:1],ram_fary_pwren_b[44]}), // MSB changed from 3'b100
                  //   .PWR_MGMT_OUT                       (ram_aary_pwren_b[44]),  
                
                       
                     `ifndef INTEL_NO_PWR_PINS
                        .vddp                            (ram_row_44_col_0_vcc),
                        `ifdef INTC_ADD_VSS
                        .vss                            (1'b0),
                        `endif  
                     `endif
               
        
        
        
                      //REPAIR INPUTS
        
                    .FCA           (ram_row_44_col_0_bisr_inst_Q[6:1]), // column repair addres --- > F means faulty
                    .CRE          (ram_row_44_col_0_bisr_inst_Q[0]), //Column repair enable
                    
        
                    // POWER MGMT inputs
                    //.ROP_SD             (), // shutoffout
                    //.ROP_DS             (), //dpslp_or_shutoffout
                    //TEMPCOMMENT1.MPMS              (1'b0), // {shutoff,deepsleep,fastsleep}
        
                    //TIMING and TRIM
                    // MDST = {async_reset0,async_reset1,wmce,mce,stbyp,rmce}
                    .MDST_hs2r2w       ({fary_ffuse_rfhs2r2w_trim[9],fary_ffuse_rfhs2r2w_trim[8],fary_ffuse_rfhs2r2w_trim[7:5],fary_ffuse_rfhs2r2w_trim[4],fary_ffuse_rfhs2r2w_trim[3],fary_ffuse_rfhs2r2w_trim[2:0]}),
                                        
        
                    //DFT inputs
                    .DFTSHIFTEN        (DFTSHIFTEN),
                    .DFTMASK           (DFTMASK),
                    .DFT_ARRAY_FREEZE    (DFT_ARRAY_FREEZE),
                    
                    .DFT_AFD_RESET_B    (DFT_AFD_RESET_B)
        
        
        
        );//ip783rfhs2r2w256x34s0c1p1d0_dft_wrp
        
        assign          ram_rd_data_a_col[44][0]    = ram_row_44_col_0_data_out_a;
        assign          ram_rd_data_b_col[44][0]    = ram_row_44_col_0_data_out_b;
        
             

        wire                            ram_row_45_col_0_clk_a       = clk_a;
        wire                            ram_row_45_col_0_clk_b       = clk_b;
        wire    [8-1:0]       ram_row_45_col_0_wr_adr_a    = ram_row_wr_adr_a[45][8-1:0];
        wire    [8-1:0]       ram_row_45_col_0_wr_adr_b    = ram_row_wr_adr_b[45][8-1:0];
        wire    [8-1:0]       ram_row_45_col_0_rd_adr_a    = ram_row_rd_adr_a[45][8-1:0];
        wire    [8-1:0]       ram_row_45_col_0_rd_adr_b    = ram_row_rd_adr_b[45][8-1:0];
        wire                            ram_row_45_col_0_rd_en_a     = ram_row_rd_en_a[45];
        wire                            ram_row_45_col_0_rd_en_b     = ram_row_rd_en_b[45];
        wire                            ram_row_45_col_0_wr_en_a     = |ram_col_wr_en_a[45][0];
        wire                            ram_row_45_col_0_wr_en_b     = |ram_col_wr_en_b[45][0];
        wire    [34-1:0]              ram_row_45_col_0_data_in_a   = ram_wr_data_a_col[0][34-1:0];
        wire    [34-1:0]              ram_row_45_col_0_data_in_b   = ram_wr_data_b_col[0][34-1:0];
        wire    [34-1:0]              ram_row_45_col_0_data_out_a;
        wire    [34-1:0]              ram_row_45_col_0_data_out_b;
        wire    [2:0]                   ram_row_45_col_0_aary_pwren_b;
        wire                            ram_row_45_col_0_vcc = 1'b1;
        
        
        ip783rfhs2r2w256x34s0c1p1d0_dft_wrp #(
                    )
        ram_row_45_col_0 (
                    //------------------------------------------------------------
                    // Functional Interfaces
                    //------------------------------------------------------------      
        
                     .CLKWR_P0                (ram_row_45_col_0_clk_a),
                     .ADRWR_P0                (ADRWR_P0_ts39),
                     .WREN_P0                 (WREN_P0_ts39),
                     .DIN_P0                  (DIN_P0_ts39),
        
                     .CLKWR_P1                (ram_row_45_col_0_clk_b),
                     .ADRWR_P1                (ADRWR_P1_ts39),
                     .WREN_P1                 (WREN_P1_ts39),
                     .DIN_P1                  (DIN_P1_ts39),
        
                     .CLKRD_P0                (ram_row_45_col_0_clk_a),
                     .ADRRD_P0                (ADRRD_P0_ts39),
                     .RDEN_P0                 (RDEN_P0_ts39),
                     .QOUT_P0                 (ram_row_45_col_0_data_out_a),
                         
                     .CLKRD_P1                (ram_row_45_col_0_clk_b),
                     .ADRRD_P1                (ADRRD_P1_ts39),
                     .RDEN_P1                 (RDEN_P1_ts39),
                     .QOUT_P1                 (ram_row_45_col_0_data_out_b),                
                                                     
                    
                   //-------------------------------------------------------------
                   // Power Management Interfaces
                   //-------------------------------------------------------------
                  //   .PWR_MGMT_IN                        ({pwr_mgmt_in_rf[PWR_MGMT_IN_SIZE-1:1],ram_fary_pwren_b[45]}), // MSB changed from 3'b100
                  //   .PWR_MGMT_OUT                       (ram_aary_pwren_b[45]),  
                
                       
                     `ifndef INTEL_NO_PWR_PINS
                        .vddp                            (ram_row_45_col_0_vcc),
                        `ifdef INTC_ADD_VSS
                        .vss                            (1'b0),
                        `endif  
                     `endif
               
        
        
        
                      //REPAIR INPUTS
        
                    .FCA           (ram_row_45_col_0_bisr_inst_Q[6:1]), // column repair addres --- > F means faulty
                    .CRE          (ram_row_45_col_0_bisr_inst_Q[0]), //Column repair enable
                    
        
                    // POWER MGMT inputs
                    //.ROP_SD             (), // shutoffout
                    //.ROP_DS             (), //dpslp_or_shutoffout
                    //TEMPCOMMENT1.MPMS              (1'b0), // {shutoff,deepsleep,fastsleep}
        
                    //TIMING and TRIM
                    // MDST = {async_reset0,async_reset1,wmce,mce,stbyp,rmce}
                    .MDST_hs2r2w       ({fary_ffuse_rfhs2r2w_trim[9],fary_ffuse_rfhs2r2w_trim[8],fary_ffuse_rfhs2r2w_trim[7:5],fary_ffuse_rfhs2r2w_trim[4],fary_ffuse_rfhs2r2w_trim[3],fary_ffuse_rfhs2r2w_trim[2:0]}),
                                        
        
                    //DFT inputs
                    .DFTSHIFTEN        (DFTSHIFTEN),
                    .DFTMASK           (DFTMASK),
                    .DFT_ARRAY_FREEZE    (DFT_ARRAY_FREEZE),
                    
                    .DFT_AFD_RESET_B    (DFT_AFD_RESET_B)
        
        
        
        );//ip783rfhs2r2w256x34s0c1p1d0_dft_wrp
        
        assign          ram_rd_data_a_col[45][0]    = ram_row_45_col_0_data_out_a;
        assign          ram_rd_data_b_col[45][0]    = ram_row_45_col_0_data_out_b;
        
             

        wire                            ram_row_46_col_0_clk_a       = clk_a;
        wire                            ram_row_46_col_0_clk_b       = clk_b;
        wire    [8-1:0]       ram_row_46_col_0_wr_adr_a    = ram_row_wr_adr_a[46][8-1:0];
        wire    [8-1:0]       ram_row_46_col_0_wr_adr_b    = ram_row_wr_adr_b[46][8-1:0];
        wire    [8-1:0]       ram_row_46_col_0_rd_adr_a    = ram_row_rd_adr_a[46][8-1:0];
        wire    [8-1:0]       ram_row_46_col_0_rd_adr_b    = ram_row_rd_adr_b[46][8-1:0];
        wire                            ram_row_46_col_0_rd_en_a     = ram_row_rd_en_a[46];
        wire                            ram_row_46_col_0_rd_en_b     = ram_row_rd_en_b[46];
        wire                            ram_row_46_col_0_wr_en_a     = |ram_col_wr_en_a[46][0];
        wire                            ram_row_46_col_0_wr_en_b     = |ram_col_wr_en_b[46][0];
        wire    [34-1:0]              ram_row_46_col_0_data_in_a   = ram_wr_data_a_col[0][34-1:0];
        wire    [34-1:0]              ram_row_46_col_0_data_in_b   = ram_wr_data_b_col[0][34-1:0];
        wire    [34-1:0]              ram_row_46_col_0_data_out_a;
        wire    [34-1:0]              ram_row_46_col_0_data_out_b;
        wire    [2:0]                   ram_row_46_col_0_aary_pwren_b;
        wire                            ram_row_46_col_0_vcc = 1'b1;
        
        
        ip783rfhs2r2w256x34s0c1p1d0_dft_wrp #(
                    )
        ram_row_46_col_0 (
                    //------------------------------------------------------------
                    // Functional Interfaces
                    //------------------------------------------------------------      
        
                     .CLKWR_P0                (ram_row_46_col_0_clk_a),
                     .ADRWR_P0                (ADRWR_P0_ts40),
                     .WREN_P0                 (WREN_P0_ts40),
                     .DIN_P0                  (DIN_P0_ts40),
        
                     .CLKWR_P1                (ram_row_46_col_0_clk_b),
                     .ADRWR_P1                (ADRWR_P1_ts40),
                     .WREN_P1                 (WREN_P1_ts40),
                     .DIN_P1                  (DIN_P1_ts40),
        
                     .CLKRD_P0                (ram_row_46_col_0_clk_a),
                     .ADRRD_P0                (ADRRD_P0_ts40),
                     .RDEN_P0                 (RDEN_P0_ts40),
                     .QOUT_P0                 (ram_row_46_col_0_data_out_a),
                         
                     .CLKRD_P1                (ram_row_46_col_0_clk_b),
                     .ADRRD_P1                (ADRRD_P1_ts40),
                     .RDEN_P1                 (RDEN_P1_ts40),
                     .QOUT_P1                 (ram_row_46_col_0_data_out_b),                
                                                     
                    
                   //-------------------------------------------------------------
                   // Power Management Interfaces
                   //-------------------------------------------------------------
                  //   .PWR_MGMT_IN                        ({pwr_mgmt_in_rf[PWR_MGMT_IN_SIZE-1:1],ram_fary_pwren_b[46]}), // MSB changed from 3'b100
                  //   .PWR_MGMT_OUT                       (ram_aary_pwren_b[46]),  
                
                       
                     `ifndef INTEL_NO_PWR_PINS
                        .vddp                            (ram_row_46_col_0_vcc),
                        `ifdef INTC_ADD_VSS
                        .vss                            (1'b0),
                        `endif  
                     `endif
               
        
        
        
                      //REPAIR INPUTS
        
                    .FCA           (ram_row_46_col_0_bisr_inst_Q[6:1]), // column repair addres --- > F means faulty
                    .CRE          (ram_row_46_col_0_bisr_inst_Q[0]), //Column repair enable
                    
        
                    // POWER MGMT inputs
                    //.ROP_SD             (), // shutoffout
                    //.ROP_DS             (), //dpslp_or_shutoffout
                    //TEMPCOMMENT1.MPMS              (1'b0), // {shutoff,deepsleep,fastsleep}
        
                    //TIMING and TRIM
                    // MDST = {async_reset0,async_reset1,wmce,mce,stbyp,rmce}
                    .MDST_hs2r2w       ({fary_ffuse_rfhs2r2w_trim[9],fary_ffuse_rfhs2r2w_trim[8],fary_ffuse_rfhs2r2w_trim[7:5],fary_ffuse_rfhs2r2w_trim[4],fary_ffuse_rfhs2r2w_trim[3],fary_ffuse_rfhs2r2w_trim[2:0]}),
                                        
        
                    //DFT inputs
                    .DFTSHIFTEN        (DFTSHIFTEN),
                    .DFTMASK           (DFTMASK),
                    .DFT_ARRAY_FREEZE    (DFT_ARRAY_FREEZE),
                    
                    .DFT_AFD_RESET_B    (DFT_AFD_RESET_B)
        
        
        
        );//ip783rfhs2r2w256x34s0c1p1d0_dft_wrp
        
        assign          ram_rd_data_a_col[46][0]    = ram_row_46_col_0_data_out_a;
        assign          ram_rd_data_b_col[46][0]    = ram_row_46_col_0_data_out_b;
        
             

        wire                            ram_row_47_col_0_clk_a       = clk_a;
        wire                            ram_row_47_col_0_clk_b       = clk_b;
        wire    [8-1:0]       ram_row_47_col_0_wr_adr_a    = ram_row_wr_adr_a[47][8-1:0];
        wire    [8-1:0]       ram_row_47_col_0_wr_adr_b    = ram_row_wr_adr_b[47][8-1:0];
        wire    [8-1:0]       ram_row_47_col_0_rd_adr_a    = ram_row_rd_adr_a[47][8-1:0];
        wire    [8-1:0]       ram_row_47_col_0_rd_adr_b    = ram_row_rd_adr_b[47][8-1:0];
        wire                            ram_row_47_col_0_rd_en_a     = ram_row_rd_en_a[47];
        wire                            ram_row_47_col_0_rd_en_b     = ram_row_rd_en_b[47];
        wire                            ram_row_47_col_0_wr_en_a     = |ram_col_wr_en_a[47][0];
        wire                            ram_row_47_col_0_wr_en_b     = |ram_col_wr_en_b[47][0];
        wire    [34-1:0]              ram_row_47_col_0_data_in_a   = ram_wr_data_a_col[0][34-1:0];
        wire    [34-1:0]              ram_row_47_col_0_data_in_b   = ram_wr_data_b_col[0][34-1:0];
        wire    [34-1:0]              ram_row_47_col_0_data_out_a;
        wire    [34-1:0]              ram_row_47_col_0_data_out_b;
        wire    [2:0]                   ram_row_47_col_0_aary_pwren_b;
        wire                            ram_row_47_col_0_vcc = 1'b1;
        
        
        ip783rfhs2r2w256x34s0c1p1d0_dft_wrp #(
                    )
        ram_row_47_col_0 (
                    //------------------------------------------------------------
                    // Functional Interfaces
                    //------------------------------------------------------------      
        
                     .CLKWR_P0                (ram_row_47_col_0_clk_a),
                     .ADRWR_P0                (ADRWR_P0_ts41),
                     .WREN_P0                 (WREN_P0_ts41),
                     .DIN_P0                  (DIN_P0_ts41),
        
                     .CLKWR_P1                (ram_row_47_col_0_clk_b),
                     .ADRWR_P1                (ADRWR_P1_ts41),
                     .WREN_P1                 (WREN_P1_ts41),
                     .DIN_P1                  (DIN_P1_ts41),
        
                     .CLKRD_P0                (ram_row_47_col_0_clk_a),
                     .ADRRD_P0                (ADRRD_P0_ts41),
                     .RDEN_P0                 (RDEN_P0_ts41),
                     .QOUT_P0                 (ram_row_47_col_0_data_out_a),
                         
                     .CLKRD_P1                (ram_row_47_col_0_clk_b),
                     .ADRRD_P1                (ADRRD_P1_ts41),
                     .RDEN_P1                 (RDEN_P1_ts41),
                     .QOUT_P1                 (ram_row_47_col_0_data_out_b),                
                                                     
                    
                   //-------------------------------------------------------------
                   // Power Management Interfaces
                   //-------------------------------------------------------------
                  //   .PWR_MGMT_IN                        ({pwr_mgmt_in_rf[PWR_MGMT_IN_SIZE-1:1],ram_fary_pwren_b[47]}), // MSB changed from 3'b100
                  //   .PWR_MGMT_OUT                       (ram_aary_pwren_b[47]),  
                
                       
                     `ifndef INTEL_NO_PWR_PINS
                        .vddp                            (ram_row_47_col_0_vcc),
                        `ifdef INTC_ADD_VSS
                        .vss                            (1'b0),
                        `endif  
                     `endif
               
        
        
        
                      //REPAIR INPUTS
        
                    .FCA           (ram_row_47_col_0_bisr_inst_Q[6:1]), // column repair addres --- > F means faulty
                    .CRE          (ram_row_47_col_0_bisr_inst_Q[0]), //Column repair enable
                    
        
                    // POWER MGMT inputs
                    //.ROP_SD             (), // shutoffout
                    //.ROP_DS             (), //dpslp_or_shutoffout
                    //TEMPCOMMENT1.MPMS              (1'b0), // {shutoff,deepsleep,fastsleep}
        
                    //TIMING and TRIM
                    // MDST = {async_reset0,async_reset1,wmce,mce,stbyp,rmce}
                    .MDST_hs2r2w       ({fary_ffuse_rfhs2r2w_trim[9],fary_ffuse_rfhs2r2w_trim[8],fary_ffuse_rfhs2r2w_trim[7:5],fary_ffuse_rfhs2r2w_trim[4],fary_ffuse_rfhs2r2w_trim[3],fary_ffuse_rfhs2r2w_trim[2:0]}),
                                        
        
                    //DFT inputs
                    .DFTSHIFTEN        (DFTSHIFTEN),
                    .DFTMASK           (DFTMASK),
                    .DFT_ARRAY_FREEZE    (DFT_ARRAY_FREEZE),
                    
                    .DFT_AFD_RESET_B    (DFT_AFD_RESET_B)
        
        
        
        );//ip783rfhs2r2w256x34s0c1p1d0_dft_wrp
        
        assign          ram_rd_data_a_col[47][0]    = ram_row_47_col_0_data_out_a;
        assign          ram_rd_data_b_col[47][0]    = ram_row_47_col_0_data_out_b;
        
             

        wire                            ram_row_48_col_0_clk_a       = clk_a;
        wire                            ram_row_48_col_0_clk_b       = clk_b;
        wire    [8-1:0]       ram_row_48_col_0_wr_adr_a    = ram_row_wr_adr_a[48][8-1:0];
        wire    [8-1:0]       ram_row_48_col_0_wr_adr_b    = ram_row_wr_adr_b[48][8-1:0];
        wire    [8-1:0]       ram_row_48_col_0_rd_adr_a    = ram_row_rd_adr_a[48][8-1:0];
        wire    [8-1:0]       ram_row_48_col_0_rd_adr_b    = ram_row_rd_adr_b[48][8-1:0];
        wire                            ram_row_48_col_0_rd_en_a     = ram_row_rd_en_a[48];
        wire                            ram_row_48_col_0_rd_en_b     = ram_row_rd_en_b[48];
        wire                            ram_row_48_col_0_wr_en_a     = |ram_col_wr_en_a[48][0];
        wire                            ram_row_48_col_0_wr_en_b     = |ram_col_wr_en_b[48][0];
        wire    [34-1:0]              ram_row_48_col_0_data_in_a   = ram_wr_data_a_col[0][34-1:0];
        wire    [34-1:0]              ram_row_48_col_0_data_in_b   = ram_wr_data_b_col[0][34-1:0];
        wire    [34-1:0]              ram_row_48_col_0_data_out_a;
        wire    [34-1:0]              ram_row_48_col_0_data_out_b;
        wire    [2:0]                   ram_row_48_col_0_aary_pwren_b;
        wire                            ram_row_48_col_0_vcc = 1'b1;
        
        
        ip783rfhs2r2w256x34s0c1p1d0_dft_wrp #(
                    )
        ram_row_48_col_0 (
                    //------------------------------------------------------------
                    // Functional Interfaces
                    //------------------------------------------------------------      
        
                     .CLKWR_P0                (ram_row_48_col_0_clk_a),
                     .ADRWR_P0                (ADRWR_P0_ts42),
                     .WREN_P0                 (WREN_P0_ts42),
                     .DIN_P0                  (DIN_P0_ts42),
        
                     .CLKWR_P1                (ram_row_48_col_0_clk_b),
                     .ADRWR_P1                (ADRWR_P1_ts42),
                     .WREN_P1                 (WREN_P1_ts42),
                     .DIN_P1                  (DIN_P1_ts42),
        
                     .CLKRD_P0                (ram_row_48_col_0_clk_a),
                     .ADRRD_P0                (ADRRD_P0_ts42),
                     .RDEN_P0                 (RDEN_P0_ts42),
                     .QOUT_P0                 (ram_row_48_col_0_data_out_a),
                         
                     .CLKRD_P1                (ram_row_48_col_0_clk_b),
                     .ADRRD_P1                (ADRRD_P1_ts42),
                     .RDEN_P1                 (RDEN_P1_ts42),
                     .QOUT_P1                 (ram_row_48_col_0_data_out_b),                
                                                     
                    
                   //-------------------------------------------------------------
                   // Power Management Interfaces
                   //-------------------------------------------------------------
                  //   .PWR_MGMT_IN                        ({pwr_mgmt_in_rf[PWR_MGMT_IN_SIZE-1:1],ram_fary_pwren_b[48]}), // MSB changed from 3'b100
                  //   .PWR_MGMT_OUT                       (ram_aary_pwren_b[48]),  
                
                       
                     `ifndef INTEL_NO_PWR_PINS
                        .vddp                            (ram_row_48_col_0_vcc),
                        `ifdef INTC_ADD_VSS
                        .vss                            (1'b0),
                        `endif  
                     `endif
               
        
        
        
                      //REPAIR INPUTS
        
                    .FCA           (ram_row_48_col_0_bisr_inst_Q[6:1]), // column repair addres --- > F means faulty
                    .CRE          (ram_row_48_col_0_bisr_inst_Q[0]), //Column repair enable
                    
        
                    // POWER MGMT inputs
                    //.ROP_SD             (), // shutoffout
                    //.ROP_DS             (), //dpslp_or_shutoffout
                    //TEMPCOMMENT1.MPMS              (1'b0), // {shutoff,deepsleep,fastsleep}
        
                    //TIMING and TRIM
                    // MDST = {async_reset0,async_reset1,wmce,mce,stbyp,rmce}
                    .MDST_hs2r2w       ({fary_ffuse_rfhs2r2w_trim[9],fary_ffuse_rfhs2r2w_trim[8],fary_ffuse_rfhs2r2w_trim[7:5],fary_ffuse_rfhs2r2w_trim[4],fary_ffuse_rfhs2r2w_trim[3],fary_ffuse_rfhs2r2w_trim[2:0]}),
                                        
        
                    //DFT inputs
                    .DFTSHIFTEN        (DFTSHIFTEN),
                    .DFTMASK           (DFTMASK),
                    .DFT_ARRAY_FREEZE    (DFT_ARRAY_FREEZE),
                    
                    .DFT_AFD_RESET_B    (DFT_AFD_RESET_B)
        
        
        
        );//ip783rfhs2r2w256x34s0c1p1d0_dft_wrp
        
        assign          ram_rd_data_a_col[48][0]    = ram_row_48_col_0_data_out_a;
        assign          ram_rd_data_b_col[48][0]    = ram_row_48_col_0_data_out_b;
        
             

        wire                            ram_row_49_col_0_clk_a       = clk_a;
        wire                            ram_row_49_col_0_clk_b       = clk_b;
        wire    [8-1:0]       ram_row_49_col_0_wr_adr_a    = ram_row_wr_adr_a[49][8-1:0];
        wire    [8-1:0]       ram_row_49_col_0_wr_adr_b    = ram_row_wr_adr_b[49][8-1:0];
        wire    [8-1:0]       ram_row_49_col_0_rd_adr_a    = ram_row_rd_adr_a[49][8-1:0];
        wire    [8-1:0]       ram_row_49_col_0_rd_adr_b    = ram_row_rd_adr_b[49][8-1:0];
        wire                            ram_row_49_col_0_rd_en_a     = ram_row_rd_en_a[49];
        wire                            ram_row_49_col_0_rd_en_b     = ram_row_rd_en_b[49];
        wire                            ram_row_49_col_0_wr_en_a     = |ram_col_wr_en_a[49][0];
        wire                            ram_row_49_col_0_wr_en_b     = |ram_col_wr_en_b[49][0];
        wire    [34-1:0]              ram_row_49_col_0_data_in_a   = ram_wr_data_a_col[0][34-1:0];
        wire    [34-1:0]              ram_row_49_col_0_data_in_b   = ram_wr_data_b_col[0][34-1:0];
        wire    [34-1:0]              ram_row_49_col_0_data_out_a;
        wire    [34-1:0]              ram_row_49_col_0_data_out_b;
        wire    [2:0]                   ram_row_49_col_0_aary_pwren_b;
        wire                            ram_row_49_col_0_vcc = 1'b1;
        
        
        ip783rfhs2r2w256x34s0c1p1d0_dft_wrp #(
                    )
        ram_row_49_col_0 (
                    //------------------------------------------------------------
                    // Functional Interfaces
                    //------------------------------------------------------------      
        
                     .CLKWR_P0                (ram_row_49_col_0_clk_a),
                     .ADRWR_P0                (ADRWR_P0_ts43),
                     .WREN_P0                 (WREN_P0_ts43),
                     .DIN_P0                  (DIN_P0_ts43),
        
                     .CLKWR_P1                (ram_row_49_col_0_clk_b),
                     .ADRWR_P1                (ADRWR_P1_ts43),
                     .WREN_P1                 (WREN_P1_ts43),
                     .DIN_P1                  (DIN_P1_ts43),
        
                     .CLKRD_P0                (ram_row_49_col_0_clk_a),
                     .ADRRD_P0                (ADRRD_P0_ts43),
                     .RDEN_P0                 (RDEN_P0_ts43),
                     .QOUT_P0                 (ram_row_49_col_0_data_out_a),
                         
                     .CLKRD_P1                (ram_row_49_col_0_clk_b),
                     .ADRRD_P1                (ADRRD_P1_ts43),
                     .RDEN_P1                 (RDEN_P1_ts43),
                     .QOUT_P1                 (ram_row_49_col_0_data_out_b),                
                                                     
                    
                   //-------------------------------------------------------------
                   // Power Management Interfaces
                   //-------------------------------------------------------------
                  //   .PWR_MGMT_IN                        ({pwr_mgmt_in_rf[PWR_MGMT_IN_SIZE-1:1],ram_fary_pwren_b[49]}), // MSB changed from 3'b100
                  //   .PWR_MGMT_OUT                       (ram_aary_pwren_b[49]),  
                
                       
                     `ifndef INTEL_NO_PWR_PINS
                        .vddp                            (ram_row_49_col_0_vcc),
                        `ifdef INTC_ADD_VSS
                        .vss                            (1'b0),
                        `endif  
                     `endif
               
        
        
        
                      //REPAIR INPUTS
        
                    .FCA           (ram_row_49_col_0_bisr_inst_Q[6:1]), // column repair addres --- > F means faulty
                    .CRE          (ram_row_49_col_0_bisr_inst_Q[0]), //Column repair enable
                    
        
                    // POWER MGMT inputs
                    //.ROP_SD             (), // shutoffout
                    //.ROP_DS             (), //dpslp_or_shutoffout
                    //TEMPCOMMENT1.MPMS              (1'b0), // {shutoff,deepsleep,fastsleep}
        
                    //TIMING and TRIM
                    // MDST = {async_reset0,async_reset1,wmce,mce,stbyp,rmce}
                    .MDST_hs2r2w       ({fary_ffuse_rfhs2r2w_trim[9],fary_ffuse_rfhs2r2w_trim[8],fary_ffuse_rfhs2r2w_trim[7:5],fary_ffuse_rfhs2r2w_trim[4],fary_ffuse_rfhs2r2w_trim[3],fary_ffuse_rfhs2r2w_trim[2:0]}),
                                        
        
                    //DFT inputs
                    .DFTSHIFTEN        (DFTSHIFTEN),
                    .DFTMASK           (DFTMASK),
                    .DFT_ARRAY_FREEZE    (DFT_ARRAY_FREEZE),
                    
                    .DFT_AFD_RESET_B    (DFT_AFD_RESET_B)
        
        
        
        );//ip783rfhs2r2w256x34s0c1p1d0_dft_wrp
        
        assign          ram_rd_data_a_col[49][0]    = ram_row_49_col_0_data_out_a;
        assign          ram_rd_data_b_col[49][0]    = ram_row_49_col_0_data_out_b;
        
             

        wire                            ram_row_50_col_0_clk_a       = clk_a;
        wire                            ram_row_50_col_0_clk_b       = clk_b;
        wire    [8-1:0]       ram_row_50_col_0_wr_adr_a    = ram_row_wr_adr_a[50][8-1:0];
        wire    [8-1:0]       ram_row_50_col_0_wr_adr_b    = ram_row_wr_adr_b[50][8-1:0];
        wire    [8-1:0]       ram_row_50_col_0_rd_adr_a    = ram_row_rd_adr_a[50][8-1:0];
        wire    [8-1:0]       ram_row_50_col_0_rd_adr_b    = ram_row_rd_adr_b[50][8-1:0];
        wire                            ram_row_50_col_0_rd_en_a     = ram_row_rd_en_a[50];
        wire                            ram_row_50_col_0_rd_en_b     = ram_row_rd_en_b[50];
        wire                            ram_row_50_col_0_wr_en_a     = |ram_col_wr_en_a[50][0];
        wire                            ram_row_50_col_0_wr_en_b     = |ram_col_wr_en_b[50][0];
        wire    [34-1:0]              ram_row_50_col_0_data_in_a   = ram_wr_data_a_col[0][34-1:0];
        wire    [34-1:0]              ram_row_50_col_0_data_in_b   = ram_wr_data_b_col[0][34-1:0];
        wire    [34-1:0]              ram_row_50_col_0_data_out_a;
        wire    [34-1:0]              ram_row_50_col_0_data_out_b;
        wire    [2:0]                   ram_row_50_col_0_aary_pwren_b;
        wire                            ram_row_50_col_0_vcc = 1'b1;
        
        
        ip783rfhs2r2w256x34s0c1p1d0_dft_wrp #(
                    )
        ram_row_50_col_0 (
                    //------------------------------------------------------------
                    // Functional Interfaces
                    //------------------------------------------------------------      
        
                     .CLKWR_P0                (ram_row_50_col_0_clk_a),
                     .ADRWR_P0                (ADRWR_P0_ts45),
                     .WREN_P0                 (WREN_P0_ts45),
                     .DIN_P0                  (DIN_P0_ts45),
        
                     .CLKWR_P1                (ram_row_50_col_0_clk_b),
                     .ADRWR_P1                (ADRWR_P1_ts45),
                     .WREN_P1                 (WREN_P1_ts45),
                     .DIN_P1                  (DIN_P1_ts45),
        
                     .CLKRD_P0                (ram_row_50_col_0_clk_a),
                     .ADRRD_P0                (ADRRD_P0_ts45),
                     .RDEN_P0                 (RDEN_P0_ts45),
                     .QOUT_P0                 (ram_row_50_col_0_data_out_a),
                         
                     .CLKRD_P1                (ram_row_50_col_0_clk_b),
                     .ADRRD_P1                (ADRRD_P1_ts45),
                     .RDEN_P1                 (RDEN_P1_ts45),
                     .QOUT_P1                 (ram_row_50_col_0_data_out_b),                
                                                     
                    
                   //-------------------------------------------------------------
                   // Power Management Interfaces
                   //-------------------------------------------------------------
                  //   .PWR_MGMT_IN                        ({pwr_mgmt_in_rf[PWR_MGMT_IN_SIZE-1:1],ram_fary_pwren_b[50]}), // MSB changed from 3'b100
                  //   .PWR_MGMT_OUT                       (ram_aary_pwren_b[50]),  
                
                       
                     `ifndef INTEL_NO_PWR_PINS
                        .vddp                            (ram_row_50_col_0_vcc),
                        `ifdef INTC_ADD_VSS
                        .vss                            (1'b0),
                        `endif  
                     `endif
               
        
        
        
                      //REPAIR INPUTS
        
                    .FCA           (ram_row_50_col_0_bisr_inst_Q[6:1]), // column repair addres --- > F means faulty
                    .CRE          (ram_row_50_col_0_bisr_inst_Q[0]), //Column repair enable
                    
        
                    // POWER MGMT inputs
                    //.ROP_SD             (), // shutoffout
                    //.ROP_DS             (), //dpslp_or_shutoffout
                    //TEMPCOMMENT1.MPMS              (1'b0), // {shutoff,deepsleep,fastsleep}
        
                    //TIMING and TRIM
                    // MDST = {async_reset0,async_reset1,wmce,mce,stbyp,rmce}
                    .MDST_hs2r2w       ({fary_ffuse_rfhs2r2w_trim[9],fary_ffuse_rfhs2r2w_trim[8],fary_ffuse_rfhs2r2w_trim[7:5],fary_ffuse_rfhs2r2w_trim[4],fary_ffuse_rfhs2r2w_trim[3],fary_ffuse_rfhs2r2w_trim[2:0]}),
                                        
        
                    //DFT inputs
                    .DFTSHIFTEN        (DFTSHIFTEN),
                    .DFTMASK           (DFTMASK),
                    .DFT_ARRAY_FREEZE    (DFT_ARRAY_FREEZE),
                    
                    .DFT_AFD_RESET_B    (DFT_AFD_RESET_B)
        
        
        
        );//ip783rfhs2r2w256x34s0c1p1d0_dft_wrp
        
        assign          ram_rd_data_a_col[50][0]    = ram_row_50_col_0_data_out_a;
        assign          ram_rd_data_b_col[50][0]    = ram_row_50_col_0_data_out_b;
        
             

        wire                            ram_row_51_col_0_clk_a       = clk_a;
        wire                            ram_row_51_col_0_clk_b       = clk_b;
        wire    [8-1:0]       ram_row_51_col_0_wr_adr_a    = ram_row_wr_adr_a[51][8-1:0];
        wire    [8-1:0]       ram_row_51_col_0_wr_adr_b    = ram_row_wr_adr_b[51][8-1:0];
        wire    [8-1:0]       ram_row_51_col_0_rd_adr_a    = ram_row_rd_adr_a[51][8-1:0];
        wire    [8-1:0]       ram_row_51_col_0_rd_adr_b    = ram_row_rd_adr_b[51][8-1:0];
        wire                            ram_row_51_col_0_rd_en_a     = ram_row_rd_en_a[51];
        wire                            ram_row_51_col_0_rd_en_b     = ram_row_rd_en_b[51];
        wire                            ram_row_51_col_0_wr_en_a     = |ram_col_wr_en_a[51][0];
        wire                            ram_row_51_col_0_wr_en_b     = |ram_col_wr_en_b[51][0];
        wire    [34-1:0]              ram_row_51_col_0_data_in_a   = ram_wr_data_a_col[0][34-1:0];
        wire    [34-1:0]              ram_row_51_col_0_data_in_b   = ram_wr_data_b_col[0][34-1:0];
        wire    [34-1:0]              ram_row_51_col_0_data_out_a;
        wire    [34-1:0]              ram_row_51_col_0_data_out_b;
        wire    [2:0]                   ram_row_51_col_0_aary_pwren_b;
        wire                            ram_row_51_col_0_vcc = 1'b1;
        
        
        ip783rfhs2r2w256x34s0c1p1d0_dft_wrp #(
                    )
        ram_row_51_col_0 (
                    //------------------------------------------------------------
                    // Functional Interfaces
                    //------------------------------------------------------------      
        
                     .CLKWR_P0                (ram_row_51_col_0_clk_a),
                     .ADRWR_P0                (ADRWR_P0_ts46),
                     .WREN_P0                 (WREN_P0_ts46),
                     .DIN_P0                  (DIN_P0_ts46),
        
                     .CLKWR_P1                (ram_row_51_col_0_clk_b),
                     .ADRWR_P1                (ADRWR_P1_ts46),
                     .WREN_P1                 (WREN_P1_ts46),
                     .DIN_P1                  (DIN_P1_ts46),
        
                     .CLKRD_P0                (ram_row_51_col_0_clk_a),
                     .ADRRD_P0                (ADRRD_P0_ts46),
                     .RDEN_P0                 (RDEN_P0_ts46),
                     .QOUT_P0                 (ram_row_51_col_0_data_out_a),
                         
                     .CLKRD_P1                (ram_row_51_col_0_clk_b),
                     .ADRRD_P1                (ADRRD_P1_ts46),
                     .RDEN_P1                 (RDEN_P1_ts46),
                     .QOUT_P1                 (ram_row_51_col_0_data_out_b),                
                                                     
                    
                   //-------------------------------------------------------------
                   // Power Management Interfaces
                   //-------------------------------------------------------------
                  //   .PWR_MGMT_IN                        ({pwr_mgmt_in_rf[PWR_MGMT_IN_SIZE-1:1],ram_fary_pwren_b[51]}), // MSB changed from 3'b100
                  //   .PWR_MGMT_OUT                       (ram_aary_pwren_b[51]),  
                
                       
                     `ifndef INTEL_NO_PWR_PINS
                        .vddp                            (ram_row_51_col_0_vcc),
                        `ifdef INTC_ADD_VSS
                        .vss                            (1'b0),
                        `endif  
                     `endif
               
        
        
        
                      //REPAIR INPUTS
        
                    .FCA           (ram_row_51_col_0_bisr_inst_Q[6:1]), // column repair addres --- > F means faulty
                    .CRE          (ram_row_51_col_0_bisr_inst_Q[0]), //Column repair enable
                    
        
                    // POWER MGMT inputs
                    //.ROP_SD             (), // shutoffout
                    //.ROP_DS             (), //dpslp_or_shutoffout
                    //TEMPCOMMENT1.MPMS              (1'b0), // {shutoff,deepsleep,fastsleep}
        
                    //TIMING and TRIM
                    // MDST = {async_reset0,async_reset1,wmce,mce,stbyp,rmce}
                    .MDST_hs2r2w       ({fary_ffuse_rfhs2r2w_trim[9],fary_ffuse_rfhs2r2w_trim[8],fary_ffuse_rfhs2r2w_trim[7:5],fary_ffuse_rfhs2r2w_trim[4],fary_ffuse_rfhs2r2w_trim[3],fary_ffuse_rfhs2r2w_trim[2:0]}),
                                        
        
                    //DFT inputs
                    .DFTSHIFTEN        (DFTSHIFTEN),
                    .DFTMASK           (DFTMASK),
                    .DFT_ARRAY_FREEZE    (DFT_ARRAY_FREEZE),
                    
                    .DFT_AFD_RESET_B    (DFT_AFD_RESET_B)
        
        
        
        );//ip783rfhs2r2w256x34s0c1p1d0_dft_wrp
        
        assign          ram_rd_data_a_col[51][0]    = ram_row_51_col_0_data_out_a;
        assign          ram_rd_data_b_col[51][0]    = ram_row_51_col_0_data_out_b;
        
             

        wire                            ram_row_52_col_0_clk_a       = clk_a;
        wire                            ram_row_52_col_0_clk_b       = clk_b;
        wire    [8-1:0]       ram_row_52_col_0_wr_adr_a    = ram_row_wr_adr_a[52][8-1:0];
        wire    [8-1:0]       ram_row_52_col_0_wr_adr_b    = ram_row_wr_adr_b[52][8-1:0];
        wire    [8-1:0]       ram_row_52_col_0_rd_adr_a    = ram_row_rd_adr_a[52][8-1:0];
        wire    [8-1:0]       ram_row_52_col_0_rd_adr_b    = ram_row_rd_adr_b[52][8-1:0];
        wire                            ram_row_52_col_0_rd_en_a     = ram_row_rd_en_a[52];
        wire                            ram_row_52_col_0_rd_en_b     = ram_row_rd_en_b[52];
        wire                            ram_row_52_col_0_wr_en_a     = |ram_col_wr_en_a[52][0];
        wire                            ram_row_52_col_0_wr_en_b     = |ram_col_wr_en_b[52][0];
        wire    [34-1:0]              ram_row_52_col_0_data_in_a   = ram_wr_data_a_col[0][34-1:0];
        wire    [34-1:0]              ram_row_52_col_0_data_in_b   = ram_wr_data_b_col[0][34-1:0];
        wire    [34-1:0]              ram_row_52_col_0_data_out_a;
        wire    [34-1:0]              ram_row_52_col_0_data_out_b;
        wire    [2:0]                   ram_row_52_col_0_aary_pwren_b;
        wire                            ram_row_52_col_0_vcc = 1'b1;
        
        
        ip783rfhs2r2w256x34s0c1p1d0_dft_wrp #(
                    )
        ram_row_52_col_0 (
                    //------------------------------------------------------------
                    // Functional Interfaces
                    //------------------------------------------------------------      
        
                     .CLKWR_P0                (ram_row_52_col_0_clk_a),
                     .ADRWR_P0                (ADRWR_P0_ts47),
                     .WREN_P0                 (WREN_P0_ts47),
                     .DIN_P0                  (DIN_P0_ts47),
        
                     .CLKWR_P1                (ram_row_52_col_0_clk_b),
                     .ADRWR_P1                (ADRWR_P1_ts47),
                     .WREN_P1                 (WREN_P1_ts47),
                     .DIN_P1                  (DIN_P1_ts47),
        
                     .CLKRD_P0                (ram_row_52_col_0_clk_a),
                     .ADRRD_P0                (ADRRD_P0_ts47),
                     .RDEN_P0                 (RDEN_P0_ts47),
                     .QOUT_P0                 (ram_row_52_col_0_data_out_a),
                         
                     .CLKRD_P1                (ram_row_52_col_0_clk_b),
                     .ADRRD_P1                (ADRRD_P1_ts47),
                     .RDEN_P1                 (RDEN_P1_ts47),
                     .QOUT_P1                 (ram_row_52_col_0_data_out_b),                
                                                     
                    
                   //-------------------------------------------------------------
                   // Power Management Interfaces
                   //-------------------------------------------------------------
                  //   .PWR_MGMT_IN                        ({pwr_mgmt_in_rf[PWR_MGMT_IN_SIZE-1:1],ram_fary_pwren_b[52]}), // MSB changed from 3'b100
                  //   .PWR_MGMT_OUT                       (ram_aary_pwren_b[52]),  
                
                       
                     `ifndef INTEL_NO_PWR_PINS
                        .vddp                            (ram_row_52_col_0_vcc),
                        `ifdef INTC_ADD_VSS
                        .vss                            (1'b0),
                        `endif  
                     `endif
               
        
        
        
                      //REPAIR INPUTS
        
                    .FCA           (ram_row_52_col_0_bisr_inst_Q[6:1]), // column repair addres --- > F means faulty
                    .CRE          (ram_row_52_col_0_bisr_inst_Q[0]), //Column repair enable
                    
        
                    // POWER MGMT inputs
                    //.ROP_SD             (), // shutoffout
                    //.ROP_DS             (), //dpslp_or_shutoffout
                    //TEMPCOMMENT1.MPMS              (1'b0), // {shutoff,deepsleep,fastsleep}
        
                    //TIMING and TRIM
                    // MDST = {async_reset0,async_reset1,wmce,mce,stbyp,rmce}
                    .MDST_hs2r2w       ({fary_ffuse_rfhs2r2w_trim[9],fary_ffuse_rfhs2r2w_trim[8],fary_ffuse_rfhs2r2w_trim[7:5],fary_ffuse_rfhs2r2w_trim[4],fary_ffuse_rfhs2r2w_trim[3],fary_ffuse_rfhs2r2w_trim[2:0]}),
                                        
        
                    //DFT inputs
                    .DFTSHIFTEN        (DFTSHIFTEN),
                    .DFTMASK           (DFTMASK),
                    .DFT_ARRAY_FREEZE    (DFT_ARRAY_FREEZE),
                    
                    .DFT_AFD_RESET_B    (DFT_AFD_RESET_B)
        
        
        
        );//ip783rfhs2r2w256x34s0c1p1d0_dft_wrp
        
        assign          ram_rd_data_a_col[52][0]    = ram_row_52_col_0_data_out_a;
        assign          ram_rd_data_b_col[52][0]    = ram_row_52_col_0_data_out_b;
        
             

        wire                            ram_row_53_col_0_clk_a       = clk_a;
        wire                            ram_row_53_col_0_clk_b       = clk_b;
        wire    [8-1:0]       ram_row_53_col_0_wr_adr_a    = ram_row_wr_adr_a[53][8-1:0];
        wire    [8-1:0]       ram_row_53_col_0_wr_adr_b    = ram_row_wr_adr_b[53][8-1:0];
        wire    [8-1:0]       ram_row_53_col_0_rd_adr_a    = ram_row_rd_adr_a[53][8-1:0];
        wire    [8-1:0]       ram_row_53_col_0_rd_adr_b    = ram_row_rd_adr_b[53][8-1:0];
        wire                            ram_row_53_col_0_rd_en_a     = ram_row_rd_en_a[53];
        wire                            ram_row_53_col_0_rd_en_b     = ram_row_rd_en_b[53];
        wire                            ram_row_53_col_0_wr_en_a     = |ram_col_wr_en_a[53][0];
        wire                            ram_row_53_col_0_wr_en_b     = |ram_col_wr_en_b[53][0];
        wire    [34-1:0]              ram_row_53_col_0_data_in_a   = ram_wr_data_a_col[0][34-1:0];
        wire    [34-1:0]              ram_row_53_col_0_data_in_b   = ram_wr_data_b_col[0][34-1:0];
        wire    [34-1:0]              ram_row_53_col_0_data_out_a;
        wire    [34-1:0]              ram_row_53_col_0_data_out_b;
        wire    [2:0]                   ram_row_53_col_0_aary_pwren_b;
        wire                            ram_row_53_col_0_vcc = 1'b1;
        
        
        ip783rfhs2r2w256x34s0c1p1d0_dft_wrp #(
                    )
        ram_row_53_col_0 (
                    //------------------------------------------------------------
                    // Functional Interfaces
                    //------------------------------------------------------------      
        
                     .CLKWR_P0                (ram_row_53_col_0_clk_a),
                     .ADRWR_P0                (ADRWR_P0_ts48),
                     .WREN_P0                 (WREN_P0_ts48),
                     .DIN_P0                  (DIN_P0_ts48),
        
                     .CLKWR_P1                (ram_row_53_col_0_clk_b),
                     .ADRWR_P1                (ADRWR_P1_ts48),
                     .WREN_P1                 (WREN_P1_ts48),
                     .DIN_P1                  (DIN_P1_ts48),
        
                     .CLKRD_P0                (ram_row_53_col_0_clk_a),
                     .ADRRD_P0                (ADRRD_P0_ts48),
                     .RDEN_P0                 (RDEN_P0_ts48),
                     .QOUT_P0                 (ram_row_53_col_0_data_out_a),
                         
                     .CLKRD_P1                (ram_row_53_col_0_clk_b),
                     .ADRRD_P1                (ADRRD_P1_ts48),
                     .RDEN_P1                 (RDEN_P1_ts48),
                     .QOUT_P1                 (ram_row_53_col_0_data_out_b),                
                                                     
                    
                   //-------------------------------------------------------------
                   // Power Management Interfaces
                   //-------------------------------------------------------------
                  //   .PWR_MGMT_IN                        ({pwr_mgmt_in_rf[PWR_MGMT_IN_SIZE-1:1],ram_fary_pwren_b[53]}), // MSB changed from 3'b100
                  //   .PWR_MGMT_OUT                       (ram_aary_pwren_b[53]),  
                
                       
                     `ifndef INTEL_NO_PWR_PINS
                        .vddp                            (ram_row_53_col_0_vcc),
                        `ifdef INTC_ADD_VSS
                        .vss                            (1'b0),
                        `endif  
                     `endif
               
        
        
        
                      //REPAIR INPUTS
        
                    .FCA           (ram_row_53_col_0_bisr_inst_Q[6:1]), // column repair addres --- > F means faulty
                    .CRE          (ram_row_53_col_0_bisr_inst_Q[0]), //Column repair enable
                    
        
                    // POWER MGMT inputs
                    //.ROP_SD             (), // shutoffout
                    //.ROP_DS             (), //dpslp_or_shutoffout
                    //TEMPCOMMENT1.MPMS              (1'b0), // {shutoff,deepsleep,fastsleep}
        
                    //TIMING and TRIM
                    // MDST = {async_reset0,async_reset1,wmce,mce,stbyp,rmce}
                    .MDST_hs2r2w       ({fary_ffuse_rfhs2r2w_trim[9],fary_ffuse_rfhs2r2w_trim[8],fary_ffuse_rfhs2r2w_trim[7:5],fary_ffuse_rfhs2r2w_trim[4],fary_ffuse_rfhs2r2w_trim[3],fary_ffuse_rfhs2r2w_trim[2:0]}),
                                        
        
                    //DFT inputs
                    .DFTSHIFTEN        (DFTSHIFTEN),
                    .DFTMASK           (DFTMASK),
                    .DFT_ARRAY_FREEZE    (DFT_ARRAY_FREEZE),
                    
                    .DFT_AFD_RESET_B    (DFT_AFD_RESET_B)
        
        
        
        );//ip783rfhs2r2w256x34s0c1p1d0_dft_wrp
        
        assign          ram_rd_data_a_col[53][0]    = ram_row_53_col_0_data_out_a;
        assign          ram_rd_data_b_col[53][0]    = ram_row_53_col_0_data_out_b;
        
             

        wire                            ram_row_54_col_0_clk_a       = clk_a;
        wire                            ram_row_54_col_0_clk_b       = clk_b;
        wire    [8-1:0]       ram_row_54_col_0_wr_adr_a    = ram_row_wr_adr_a[54][8-1:0];
        wire    [8-1:0]       ram_row_54_col_0_wr_adr_b    = ram_row_wr_adr_b[54][8-1:0];
        wire    [8-1:0]       ram_row_54_col_0_rd_adr_a    = ram_row_rd_adr_a[54][8-1:0];
        wire    [8-1:0]       ram_row_54_col_0_rd_adr_b    = ram_row_rd_adr_b[54][8-1:0];
        wire                            ram_row_54_col_0_rd_en_a     = ram_row_rd_en_a[54];
        wire                            ram_row_54_col_0_rd_en_b     = ram_row_rd_en_b[54];
        wire                            ram_row_54_col_0_wr_en_a     = |ram_col_wr_en_a[54][0];
        wire                            ram_row_54_col_0_wr_en_b     = |ram_col_wr_en_b[54][0];
        wire    [34-1:0]              ram_row_54_col_0_data_in_a   = ram_wr_data_a_col[0][34-1:0];
        wire    [34-1:0]              ram_row_54_col_0_data_in_b   = ram_wr_data_b_col[0][34-1:0];
        wire    [34-1:0]              ram_row_54_col_0_data_out_a;
        wire    [34-1:0]              ram_row_54_col_0_data_out_b;
        wire    [2:0]                   ram_row_54_col_0_aary_pwren_b;
        wire                            ram_row_54_col_0_vcc = 1'b1;
        
        
        ip783rfhs2r2w256x34s0c1p1d0_dft_wrp #(
                    )
        ram_row_54_col_0 (
                    //------------------------------------------------------------
                    // Functional Interfaces
                    //------------------------------------------------------------      
        
                     .CLKWR_P0                (ram_row_54_col_0_clk_a),
                     .ADRWR_P0                (ADRWR_P0_ts49),
                     .WREN_P0                 (WREN_P0_ts49),
                     .DIN_P0                  (DIN_P0_ts49),
        
                     .CLKWR_P1                (ram_row_54_col_0_clk_b),
                     .ADRWR_P1                (ADRWR_P1_ts49),
                     .WREN_P1                 (WREN_P1_ts49),
                     .DIN_P1                  (DIN_P1_ts49),
        
                     .CLKRD_P0                (ram_row_54_col_0_clk_a),
                     .ADRRD_P0                (ADRRD_P0_ts49),
                     .RDEN_P0                 (RDEN_P0_ts49),
                     .QOUT_P0                 (ram_row_54_col_0_data_out_a),
                         
                     .CLKRD_P1                (ram_row_54_col_0_clk_b),
                     .ADRRD_P1                (ADRRD_P1_ts49),
                     .RDEN_P1                 (RDEN_P1_ts49),
                     .QOUT_P1                 (ram_row_54_col_0_data_out_b),                
                                                     
                    
                   //-------------------------------------------------------------
                   // Power Management Interfaces
                   //-------------------------------------------------------------
                  //   .PWR_MGMT_IN                        ({pwr_mgmt_in_rf[PWR_MGMT_IN_SIZE-1:1],ram_fary_pwren_b[54]}), // MSB changed from 3'b100
                  //   .PWR_MGMT_OUT                       (ram_aary_pwren_b[54]),  
                
                       
                     `ifndef INTEL_NO_PWR_PINS
                        .vddp                            (ram_row_54_col_0_vcc),
                        `ifdef INTC_ADD_VSS
                        .vss                            (1'b0),
                        `endif  
                     `endif
               
        
        
        
                      //REPAIR INPUTS
        
                    .FCA           (ram_row_54_col_0_bisr_inst_Q[6:1]), // column repair addres --- > F means faulty
                    .CRE          (ram_row_54_col_0_bisr_inst_Q[0]), //Column repair enable
                    
        
                    // POWER MGMT inputs
                    //.ROP_SD             (), // shutoffout
                    //.ROP_DS             (), //dpslp_or_shutoffout
                    //TEMPCOMMENT1.MPMS              (1'b0), // {shutoff,deepsleep,fastsleep}
        
                    //TIMING and TRIM
                    // MDST = {async_reset0,async_reset1,wmce,mce,stbyp,rmce}
                    .MDST_hs2r2w       ({fary_ffuse_rfhs2r2w_trim[9],fary_ffuse_rfhs2r2w_trim[8],fary_ffuse_rfhs2r2w_trim[7:5],fary_ffuse_rfhs2r2w_trim[4],fary_ffuse_rfhs2r2w_trim[3],fary_ffuse_rfhs2r2w_trim[2:0]}),
                                        
        
                    //DFT inputs
                    .DFTSHIFTEN        (DFTSHIFTEN),
                    .DFTMASK           (DFTMASK),
                    .DFT_ARRAY_FREEZE    (DFT_ARRAY_FREEZE),
                    
                    .DFT_AFD_RESET_B    (DFT_AFD_RESET_B)
        
        
        
        );//ip783rfhs2r2w256x34s0c1p1d0_dft_wrp
        
        assign          ram_rd_data_a_col[54][0]    = ram_row_54_col_0_data_out_a;
        assign          ram_rd_data_b_col[54][0]    = ram_row_54_col_0_data_out_b;
        
             

        wire                            ram_row_55_col_0_clk_a       = clk_a;
        wire                            ram_row_55_col_0_clk_b       = clk_b;
        wire    [8-1:0]       ram_row_55_col_0_wr_adr_a    = ram_row_wr_adr_a[55][8-1:0];
        wire    [8-1:0]       ram_row_55_col_0_wr_adr_b    = ram_row_wr_adr_b[55][8-1:0];
        wire    [8-1:0]       ram_row_55_col_0_rd_adr_a    = ram_row_rd_adr_a[55][8-1:0];
        wire    [8-1:0]       ram_row_55_col_0_rd_adr_b    = ram_row_rd_adr_b[55][8-1:0];
        wire                            ram_row_55_col_0_rd_en_a     = ram_row_rd_en_a[55];
        wire                            ram_row_55_col_0_rd_en_b     = ram_row_rd_en_b[55];
        wire                            ram_row_55_col_0_wr_en_a     = |ram_col_wr_en_a[55][0];
        wire                            ram_row_55_col_0_wr_en_b     = |ram_col_wr_en_b[55][0];
        wire    [34-1:0]              ram_row_55_col_0_data_in_a   = ram_wr_data_a_col[0][34-1:0];
        wire    [34-1:0]              ram_row_55_col_0_data_in_b   = ram_wr_data_b_col[0][34-1:0];
        wire    [34-1:0]              ram_row_55_col_0_data_out_a;
        wire    [34-1:0]              ram_row_55_col_0_data_out_b;
        wire    [2:0]                   ram_row_55_col_0_aary_pwren_b;
        wire                            ram_row_55_col_0_vcc = 1'b1;
        
        
        ip783rfhs2r2w256x34s0c1p1d0_dft_wrp #(
                    )
        ram_row_55_col_0 (
                    //------------------------------------------------------------
                    // Functional Interfaces
                    //------------------------------------------------------------      
        
                     .CLKWR_P0                (ram_row_55_col_0_clk_a),
                     .ADRWR_P0                (ADRWR_P0_ts50),
                     .WREN_P0                 (WREN_P0_ts50),
                     .DIN_P0                  (DIN_P0_ts50),
        
                     .CLKWR_P1                (ram_row_55_col_0_clk_b),
                     .ADRWR_P1                (ADRWR_P1_ts50),
                     .WREN_P1                 (WREN_P1_ts50),
                     .DIN_P1                  (DIN_P1_ts50),
        
                     .CLKRD_P0                (ram_row_55_col_0_clk_a),
                     .ADRRD_P0                (ADRRD_P0_ts50),
                     .RDEN_P0                 (RDEN_P0_ts50),
                     .QOUT_P0                 (ram_row_55_col_0_data_out_a),
                         
                     .CLKRD_P1                (ram_row_55_col_0_clk_b),
                     .ADRRD_P1                (ADRRD_P1_ts50),
                     .RDEN_P1                 (RDEN_P1_ts50),
                     .QOUT_P1                 (ram_row_55_col_0_data_out_b),                
                                                     
                    
                   //-------------------------------------------------------------
                   // Power Management Interfaces
                   //-------------------------------------------------------------
                  //   .PWR_MGMT_IN                        ({pwr_mgmt_in_rf[PWR_MGMT_IN_SIZE-1:1],ram_fary_pwren_b[55]}), // MSB changed from 3'b100
                  //   .PWR_MGMT_OUT                       (ram_aary_pwren_b[55]),  
                
                       
                     `ifndef INTEL_NO_PWR_PINS
                        .vddp                            (ram_row_55_col_0_vcc),
                        `ifdef INTC_ADD_VSS
                        .vss                            (1'b0),
                        `endif  
                     `endif
               
        
        
        
                      //REPAIR INPUTS
        
                    .FCA           (ram_row_55_col_0_bisr_inst_Q[6:1]), // column repair addres --- > F means faulty
                    .CRE          (ram_row_55_col_0_bisr_inst_Q[0]), //Column repair enable
                    
        
                    // POWER MGMT inputs
                    //.ROP_SD             (), // shutoffout
                    //.ROP_DS             (), //dpslp_or_shutoffout
                    //TEMPCOMMENT1.MPMS              (1'b0), // {shutoff,deepsleep,fastsleep}
        
                    //TIMING and TRIM
                    // MDST = {async_reset0,async_reset1,wmce,mce,stbyp,rmce}
                    .MDST_hs2r2w       ({fary_ffuse_rfhs2r2w_trim[9],fary_ffuse_rfhs2r2w_trim[8],fary_ffuse_rfhs2r2w_trim[7:5],fary_ffuse_rfhs2r2w_trim[4],fary_ffuse_rfhs2r2w_trim[3],fary_ffuse_rfhs2r2w_trim[2:0]}),
                                        
        
                    //DFT inputs
                    .DFTSHIFTEN        (DFTSHIFTEN),
                    .DFTMASK           (DFTMASK),
                    .DFT_ARRAY_FREEZE    (DFT_ARRAY_FREEZE),
                    
                    .DFT_AFD_RESET_B    (DFT_AFD_RESET_B)
        
        
        
        );//ip783rfhs2r2w256x34s0c1p1d0_dft_wrp
        
        assign          ram_rd_data_a_col[55][0]    = ram_row_55_col_0_data_out_a;
        assign          ram_rd_data_b_col[55][0]    = ram_row_55_col_0_data_out_b;
        
             

        wire                            ram_row_56_col_0_clk_a       = clk_a;
        wire                            ram_row_56_col_0_clk_b       = clk_b;
        wire    [8-1:0]       ram_row_56_col_0_wr_adr_a    = ram_row_wr_adr_a[56][8-1:0];
        wire    [8-1:0]       ram_row_56_col_0_wr_adr_b    = ram_row_wr_adr_b[56][8-1:0];
        wire    [8-1:0]       ram_row_56_col_0_rd_adr_a    = ram_row_rd_adr_a[56][8-1:0];
        wire    [8-1:0]       ram_row_56_col_0_rd_adr_b    = ram_row_rd_adr_b[56][8-1:0];
        wire                            ram_row_56_col_0_rd_en_a     = ram_row_rd_en_a[56];
        wire                            ram_row_56_col_0_rd_en_b     = ram_row_rd_en_b[56];
        wire                            ram_row_56_col_0_wr_en_a     = |ram_col_wr_en_a[56][0];
        wire                            ram_row_56_col_0_wr_en_b     = |ram_col_wr_en_b[56][0];
        wire    [34-1:0]              ram_row_56_col_0_data_in_a   = ram_wr_data_a_col[0][34-1:0];
        wire    [34-1:0]              ram_row_56_col_0_data_in_b   = ram_wr_data_b_col[0][34-1:0];
        wire    [34-1:0]              ram_row_56_col_0_data_out_a;
        wire    [34-1:0]              ram_row_56_col_0_data_out_b;
        wire    [2:0]                   ram_row_56_col_0_aary_pwren_b;
        wire                            ram_row_56_col_0_vcc = 1'b1;
        
        
        ip783rfhs2r2w256x34s0c1p1d0_dft_wrp #(
                    )
        ram_row_56_col_0 (
                    //------------------------------------------------------------
                    // Functional Interfaces
                    //------------------------------------------------------------      
        
                     .CLKWR_P0                (ram_row_56_col_0_clk_a),
                     .ADRWR_P0                (ADRWR_P0_ts51),
                     .WREN_P0                 (WREN_P0_ts51),
                     .DIN_P0                  (DIN_P0_ts51),
        
                     .CLKWR_P1                (ram_row_56_col_0_clk_b),
                     .ADRWR_P1                (ADRWR_P1_ts51),
                     .WREN_P1                 (WREN_P1_ts51),
                     .DIN_P1                  (DIN_P1_ts51),
        
                     .CLKRD_P0                (ram_row_56_col_0_clk_a),
                     .ADRRD_P0                (ADRRD_P0_ts51),
                     .RDEN_P0                 (RDEN_P0_ts51),
                     .QOUT_P0                 (ram_row_56_col_0_data_out_a),
                         
                     .CLKRD_P1                (ram_row_56_col_0_clk_b),
                     .ADRRD_P1                (ADRRD_P1_ts51),
                     .RDEN_P1                 (RDEN_P1_ts51),
                     .QOUT_P1                 (ram_row_56_col_0_data_out_b),                
                                                     
                    
                   //-------------------------------------------------------------
                   // Power Management Interfaces
                   //-------------------------------------------------------------
                  //   .PWR_MGMT_IN                        ({pwr_mgmt_in_rf[PWR_MGMT_IN_SIZE-1:1],ram_fary_pwren_b[56]}), // MSB changed from 3'b100
                  //   .PWR_MGMT_OUT                       (ram_aary_pwren_b[56]),  
                
                       
                     `ifndef INTEL_NO_PWR_PINS
                        .vddp                            (ram_row_56_col_0_vcc),
                        `ifdef INTC_ADD_VSS
                        .vss                            (1'b0),
                        `endif  
                     `endif
               
        
        
        
                      //REPAIR INPUTS
        
                    .FCA           (ram_row_56_col_0_bisr_inst_Q[6:1]), // column repair addres --- > F means faulty
                    .CRE          (ram_row_56_col_0_bisr_inst_Q[0]), //Column repair enable
                    
        
                    // POWER MGMT inputs
                    //.ROP_SD             (), // shutoffout
                    //.ROP_DS             (), //dpslp_or_shutoffout
                    //TEMPCOMMENT1.MPMS              (1'b0), // {shutoff,deepsleep,fastsleep}
        
                    //TIMING and TRIM
                    // MDST = {async_reset0,async_reset1,wmce,mce,stbyp,rmce}
                    .MDST_hs2r2w       ({fary_ffuse_rfhs2r2w_trim[9],fary_ffuse_rfhs2r2w_trim[8],fary_ffuse_rfhs2r2w_trim[7:5],fary_ffuse_rfhs2r2w_trim[4],fary_ffuse_rfhs2r2w_trim[3],fary_ffuse_rfhs2r2w_trim[2:0]}),
                                        
        
                    //DFT inputs
                    .DFTSHIFTEN        (DFTSHIFTEN),
                    .DFTMASK           (DFTMASK),
                    .DFT_ARRAY_FREEZE    (DFT_ARRAY_FREEZE),
                    
                    .DFT_AFD_RESET_B    (DFT_AFD_RESET_B)
        
        
        
        );//ip783rfhs2r2w256x34s0c1p1d0_dft_wrp
        
        assign          ram_rd_data_a_col[56][0]    = ram_row_56_col_0_data_out_a;
        assign          ram_rd_data_b_col[56][0]    = ram_row_56_col_0_data_out_b;
        
             

        wire                            ram_row_57_col_0_clk_a       = clk_a;
        wire                            ram_row_57_col_0_clk_b       = clk_b;
        wire    [8-1:0]       ram_row_57_col_0_wr_adr_a    = ram_row_wr_adr_a[57][8-1:0];
        wire    [8-1:0]       ram_row_57_col_0_wr_adr_b    = ram_row_wr_adr_b[57][8-1:0];
        wire    [8-1:0]       ram_row_57_col_0_rd_adr_a    = ram_row_rd_adr_a[57][8-1:0];
        wire    [8-1:0]       ram_row_57_col_0_rd_adr_b    = ram_row_rd_adr_b[57][8-1:0];
        wire                            ram_row_57_col_0_rd_en_a     = ram_row_rd_en_a[57];
        wire                            ram_row_57_col_0_rd_en_b     = ram_row_rd_en_b[57];
        wire                            ram_row_57_col_0_wr_en_a     = |ram_col_wr_en_a[57][0];
        wire                            ram_row_57_col_0_wr_en_b     = |ram_col_wr_en_b[57][0];
        wire    [34-1:0]              ram_row_57_col_0_data_in_a   = ram_wr_data_a_col[0][34-1:0];
        wire    [34-1:0]              ram_row_57_col_0_data_in_b   = ram_wr_data_b_col[0][34-1:0];
        wire    [34-1:0]              ram_row_57_col_0_data_out_a;
        wire    [34-1:0]              ram_row_57_col_0_data_out_b;
        wire    [2:0]                   ram_row_57_col_0_aary_pwren_b;
        wire                            ram_row_57_col_0_vcc = 1'b1;
        
        
        ip783rfhs2r2w256x34s0c1p1d0_dft_wrp #(
                    )
        ram_row_57_col_0 (
                    //------------------------------------------------------------
                    // Functional Interfaces
                    //------------------------------------------------------------      
        
                     .CLKWR_P0                (ram_row_57_col_0_clk_a),
                     .ADRWR_P0                (ADRWR_P0_ts52),
                     .WREN_P0                 (WREN_P0_ts52),
                     .DIN_P0                  (DIN_P0_ts52),
        
                     .CLKWR_P1                (ram_row_57_col_0_clk_b),
                     .ADRWR_P1                (ADRWR_P1_ts52),
                     .WREN_P1                 (WREN_P1_ts52),
                     .DIN_P1                  (DIN_P1_ts52),
        
                     .CLKRD_P0                (ram_row_57_col_0_clk_a),
                     .ADRRD_P0                (ADRRD_P0_ts52),
                     .RDEN_P0                 (RDEN_P0_ts52),
                     .QOUT_P0                 (ram_row_57_col_0_data_out_a),
                         
                     .CLKRD_P1                (ram_row_57_col_0_clk_b),
                     .ADRRD_P1                (ADRRD_P1_ts52),
                     .RDEN_P1                 (RDEN_P1_ts52),
                     .QOUT_P1                 (ram_row_57_col_0_data_out_b),                
                                                     
                    
                   //-------------------------------------------------------------
                   // Power Management Interfaces
                   //-------------------------------------------------------------
                  //   .PWR_MGMT_IN                        ({pwr_mgmt_in_rf[PWR_MGMT_IN_SIZE-1:1],ram_fary_pwren_b[57]}), // MSB changed from 3'b100
                  //   .PWR_MGMT_OUT                       (ram_aary_pwren_b[57]),  
                
                       
                     `ifndef INTEL_NO_PWR_PINS
                        .vddp                            (ram_row_57_col_0_vcc),
                        `ifdef INTC_ADD_VSS
                        .vss                            (1'b0),
                        `endif  
                     `endif
               
        
        
        
                      //REPAIR INPUTS
        
                    .FCA           (ram_row_57_col_0_bisr_inst_Q[6:1]), // column repair addres --- > F means faulty
                    .CRE          (ram_row_57_col_0_bisr_inst_Q[0]), //Column repair enable
                    
        
                    // POWER MGMT inputs
                    //.ROP_SD             (), // shutoffout
                    //.ROP_DS             (), //dpslp_or_shutoffout
                    //TEMPCOMMENT1.MPMS              (1'b0), // {shutoff,deepsleep,fastsleep}
        
                    //TIMING and TRIM
                    // MDST = {async_reset0,async_reset1,wmce,mce,stbyp,rmce}
                    .MDST_hs2r2w       ({fary_ffuse_rfhs2r2w_trim[9],fary_ffuse_rfhs2r2w_trim[8],fary_ffuse_rfhs2r2w_trim[7:5],fary_ffuse_rfhs2r2w_trim[4],fary_ffuse_rfhs2r2w_trim[3],fary_ffuse_rfhs2r2w_trim[2:0]}),
                                        
        
                    //DFT inputs
                    .DFTSHIFTEN        (DFTSHIFTEN),
                    .DFTMASK           (DFTMASK),
                    .DFT_ARRAY_FREEZE    (DFT_ARRAY_FREEZE),
                    
                    .DFT_AFD_RESET_B    (DFT_AFD_RESET_B)
        
        
        
        );//ip783rfhs2r2w256x34s0c1p1d0_dft_wrp
        
        assign          ram_rd_data_a_col[57][0]    = ram_row_57_col_0_data_out_a;
        assign          ram_rd_data_b_col[57][0]    = ram_row_57_col_0_data_out_b;
        
             

        wire                            ram_row_58_col_0_clk_a       = clk_a;
        wire                            ram_row_58_col_0_clk_b       = clk_b;
        wire    [8-1:0]       ram_row_58_col_0_wr_adr_a    = ram_row_wr_adr_a[58][8-1:0];
        wire    [8-1:0]       ram_row_58_col_0_wr_adr_b    = ram_row_wr_adr_b[58][8-1:0];
        wire    [8-1:0]       ram_row_58_col_0_rd_adr_a    = ram_row_rd_adr_a[58][8-1:0];
        wire    [8-1:0]       ram_row_58_col_0_rd_adr_b    = ram_row_rd_adr_b[58][8-1:0];
        wire                            ram_row_58_col_0_rd_en_a     = ram_row_rd_en_a[58];
        wire                            ram_row_58_col_0_rd_en_b     = ram_row_rd_en_b[58];
        wire                            ram_row_58_col_0_wr_en_a     = |ram_col_wr_en_a[58][0];
        wire                            ram_row_58_col_0_wr_en_b     = |ram_col_wr_en_b[58][0];
        wire    [34-1:0]              ram_row_58_col_0_data_in_a   = ram_wr_data_a_col[0][34-1:0];
        wire    [34-1:0]              ram_row_58_col_0_data_in_b   = ram_wr_data_b_col[0][34-1:0];
        wire    [34-1:0]              ram_row_58_col_0_data_out_a;
        wire    [34-1:0]              ram_row_58_col_0_data_out_b;
        wire    [2:0]                   ram_row_58_col_0_aary_pwren_b;
        wire                            ram_row_58_col_0_vcc = 1'b1;
        
        
        ip783rfhs2r2w256x34s0c1p1d0_dft_wrp #(
                    )
        ram_row_58_col_0 (
                    //------------------------------------------------------------
                    // Functional Interfaces
                    //------------------------------------------------------------      
        
                     .CLKWR_P0                (ram_row_58_col_0_clk_a),
                     .ADRWR_P0                (ADRWR_P0_ts53),
                     .WREN_P0                 (WREN_P0_ts53),
                     .DIN_P0                  (DIN_P0_ts53),
        
                     .CLKWR_P1                (ram_row_58_col_0_clk_b),
                     .ADRWR_P1                (ADRWR_P1_ts53),
                     .WREN_P1                 (WREN_P1_ts53),
                     .DIN_P1                  (DIN_P1_ts53),
        
                     .CLKRD_P0                (ram_row_58_col_0_clk_a),
                     .ADRRD_P0                (ADRRD_P0_ts53),
                     .RDEN_P0                 (RDEN_P0_ts53),
                     .QOUT_P0                 (ram_row_58_col_0_data_out_a),
                         
                     .CLKRD_P1                (ram_row_58_col_0_clk_b),
                     .ADRRD_P1                (ADRRD_P1_ts53),
                     .RDEN_P1                 (RDEN_P1_ts53),
                     .QOUT_P1                 (ram_row_58_col_0_data_out_b),                
                                                     
                    
                   //-------------------------------------------------------------
                   // Power Management Interfaces
                   //-------------------------------------------------------------
                  //   .PWR_MGMT_IN                        ({pwr_mgmt_in_rf[PWR_MGMT_IN_SIZE-1:1],ram_fary_pwren_b[58]}), // MSB changed from 3'b100
                  //   .PWR_MGMT_OUT                       (ram_aary_pwren_b[58]),  
                
                       
                     `ifndef INTEL_NO_PWR_PINS
                        .vddp                            (ram_row_58_col_0_vcc),
                        `ifdef INTC_ADD_VSS
                        .vss                            (1'b0),
                        `endif  
                     `endif
               
        
        
        
                      //REPAIR INPUTS
        
                    .FCA           (ram_row_58_col_0_bisr_inst_Q[6:1]), // column repair addres --- > F means faulty
                    .CRE          (ram_row_58_col_0_bisr_inst_Q[0]), //Column repair enable
                    
        
                    // POWER MGMT inputs
                    //.ROP_SD             (), // shutoffout
                    //.ROP_DS             (), //dpslp_or_shutoffout
                    //TEMPCOMMENT1.MPMS              (1'b0), // {shutoff,deepsleep,fastsleep}
        
                    //TIMING and TRIM
                    // MDST = {async_reset0,async_reset1,wmce,mce,stbyp,rmce}
                    .MDST_hs2r2w       ({fary_ffuse_rfhs2r2w_trim[9],fary_ffuse_rfhs2r2w_trim[8],fary_ffuse_rfhs2r2w_trim[7:5],fary_ffuse_rfhs2r2w_trim[4],fary_ffuse_rfhs2r2w_trim[3],fary_ffuse_rfhs2r2w_trim[2:0]}),
                                        
        
                    //DFT inputs
                    .DFTSHIFTEN        (DFTSHIFTEN),
                    .DFTMASK           (DFTMASK),
                    .DFT_ARRAY_FREEZE    (DFT_ARRAY_FREEZE),
                    
                    .DFT_AFD_RESET_B    (DFT_AFD_RESET_B)
        
        
        
        );//ip783rfhs2r2w256x34s0c1p1d0_dft_wrp
        
        assign          ram_rd_data_a_col[58][0]    = ram_row_58_col_0_data_out_a;
        assign          ram_rd_data_b_col[58][0]    = ram_row_58_col_0_data_out_b;
        
             

        wire                            ram_row_59_col_0_clk_a       = clk_a;
        wire                            ram_row_59_col_0_clk_b       = clk_b;
        wire    [8-1:0]       ram_row_59_col_0_wr_adr_a    = ram_row_wr_adr_a[59][8-1:0];
        wire    [8-1:0]       ram_row_59_col_0_wr_adr_b    = ram_row_wr_adr_b[59][8-1:0];
        wire    [8-1:0]       ram_row_59_col_0_rd_adr_a    = ram_row_rd_adr_a[59][8-1:0];
        wire    [8-1:0]       ram_row_59_col_0_rd_adr_b    = ram_row_rd_adr_b[59][8-1:0];
        wire                            ram_row_59_col_0_rd_en_a     = ram_row_rd_en_a[59];
        wire                            ram_row_59_col_0_rd_en_b     = ram_row_rd_en_b[59];
        wire                            ram_row_59_col_0_wr_en_a     = |ram_col_wr_en_a[59][0];
        wire                            ram_row_59_col_0_wr_en_b     = |ram_col_wr_en_b[59][0];
        wire    [34-1:0]              ram_row_59_col_0_data_in_a   = ram_wr_data_a_col[0][34-1:0];
        wire    [34-1:0]              ram_row_59_col_0_data_in_b   = ram_wr_data_b_col[0][34-1:0];
        wire    [34-1:0]              ram_row_59_col_0_data_out_a;
        wire    [34-1:0]              ram_row_59_col_0_data_out_b;
        wire    [2:0]                   ram_row_59_col_0_aary_pwren_b;
        wire                            ram_row_59_col_0_vcc = 1'b1;
        
        
        ip783rfhs2r2w256x34s0c1p1d0_dft_wrp #(
                    )
        ram_row_59_col_0 (
                    //------------------------------------------------------------
                    // Functional Interfaces
                    //------------------------------------------------------------      
        
                     .CLKWR_P0                (ram_row_59_col_0_clk_a),
                     .ADRWR_P0                (ADRWR_P0_ts54),
                     .WREN_P0                 (WREN_P0_ts54),
                     .DIN_P0                  (DIN_P0_ts54),
        
                     .CLKWR_P1                (ram_row_59_col_0_clk_b),
                     .ADRWR_P1                (ADRWR_P1_ts54),
                     .WREN_P1                 (WREN_P1_ts54),
                     .DIN_P1                  (DIN_P1_ts54),
        
                     .CLKRD_P0                (ram_row_59_col_0_clk_a),
                     .ADRRD_P0                (ADRRD_P0_ts54),
                     .RDEN_P0                 (RDEN_P0_ts54),
                     .QOUT_P0                 (ram_row_59_col_0_data_out_a),
                         
                     .CLKRD_P1                (ram_row_59_col_0_clk_b),
                     .ADRRD_P1                (ADRRD_P1_ts54),
                     .RDEN_P1                 (RDEN_P1_ts54),
                     .QOUT_P1                 (ram_row_59_col_0_data_out_b),                
                                                     
                    
                   //-------------------------------------------------------------
                   // Power Management Interfaces
                   //-------------------------------------------------------------
                  //   .PWR_MGMT_IN                        ({pwr_mgmt_in_rf[PWR_MGMT_IN_SIZE-1:1],ram_fary_pwren_b[59]}), // MSB changed from 3'b100
                  //   .PWR_MGMT_OUT                       (ram_aary_pwren_b[59]),  
                
                       
                     `ifndef INTEL_NO_PWR_PINS
                        .vddp                            (ram_row_59_col_0_vcc),
                        `ifdef INTC_ADD_VSS
                        .vss                            (1'b0),
                        `endif  
                     `endif
               
        
        
        
                      //REPAIR INPUTS
        
                    .FCA           (ram_row_59_col_0_bisr_inst_Q[6:1]), // column repair addres --- > F means faulty
                    .CRE          (ram_row_59_col_0_bisr_inst_Q[0]), //Column repair enable
                    
        
                    // POWER MGMT inputs
                    //.ROP_SD             (), // shutoffout
                    //.ROP_DS             (), //dpslp_or_shutoffout
                    //TEMPCOMMENT1.MPMS              (1'b0), // {shutoff,deepsleep,fastsleep}
        
                    //TIMING and TRIM
                    // MDST = {async_reset0,async_reset1,wmce,mce,stbyp,rmce}
                    .MDST_hs2r2w       ({fary_ffuse_rfhs2r2w_trim[9],fary_ffuse_rfhs2r2w_trim[8],fary_ffuse_rfhs2r2w_trim[7:5],fary_ffuse_rfhs2r2w_trim[4],fary_ffuse_rfhs2r2w_trim[3],fary_ffuse_rfhs2r2w_trim[2:0]}),
                                        
        
                    //DFT inputs
                    .DFTSHIFTEN        (DFTSHIFTEN),
                    .DFTMASK           (DFTMASK),
                    .DFT_ARRAY_FREEZE    (DFT_ARRAY_FREEZE),
                    
                    .DFT_AFD_RESET_B    (DFT_AFD_RESET_B)
        
        
        
        );//ip783rfhs2r2w256x34s0c1p1d0_dft_wrp
        
        assign          ram_rd_data_a_col[59][0]    = ram_row_59_col_0_data_out_a;
        assign          ram_rd_data_b_col[59][0]    = ram_row_59_col_0_data_out_b;
        
             

        wire                            ram_row_60_col_0_clk_a       = clk_a;
        wire                            ram_row_60_col_0_clk_b       = clk_b;
        wire    [8-1:0]       ram_row_60_col_0_wr_adr_a    = ram_row_wr_adr_a[60][8-1:0];
        wire    [8-1:0]       ram_row_60_col_0_wr_adr_b    = ram_row_wr_adr_b[60][8-1:0];
        wire    [8-1:0]       ram_row_60_col_0_rd_adr_a    = ram_row_rd_adr_a[60][8-1:0];
        wire    [8-1:0]       ram_row_60_col_0_rd_adr_b    = ram_row_rd_adr_b[60][8-1:0];
        wire                            ram_row_60_col_0_rd_en_a     = ram_row_rd_en_a[60];
        wire                            ram_row_60_col_0_rd_en_b     = ram_row_rd_en_b[60];
        wire                            ram_row_60_col_0_wr_en_a     = |ram_col_wr_en_a[60][0];
        wire                            ram_row_60_col_0_wr_en_b     = |ram_col_wr_en_b[60][0];
        wire    [34-1:0]              ram_row_60_col_0_data_in_a   = ram_wr_data_a_col[0][34-1:0];
        wire    [34-1:0]              ram_row_60_col_0_data_in_b   = ram_wr_data_b_col[0][34-1:0];
        wire    [34-1:0]              ram_row_60_col_0_data_out_a;
        wire    [34-1:0]              ram_row_60_col_0_data_out_b;
        wire    [2:0]                   ram_row_60_col_0_aary_pwren_b;
        wire                            ram_row_60_col_0_vcc = 1'b1;
        
        
        ip783rfhs2r2w256x34s0c1p1d0_dft_wrp #(
                    )
        ram_row_60_col_0 (
                    //------------------------------------------------------------
                    // Functional Interfaces
                    //------------------------------------------------------------      
        
                     .CLKWR_P0                (ram_row_60_col_0_clk_a),
                     .ADRWR_P0                (ADRWR_P0_ts56),
                     .WREN_P0                 (WREN_P0_ts56),
                     .DIN_P0                  (DIN_P0_ts56),
        
                     .CLKWR_P1                (ram_row_60_col_0_clk_b),
                     .ADRWR_P1                (ADRWR_P1_ts56),
                     .WREN_P1                 (WREN_P1_ts56),
                     .DIN_P1                  (DIN_P1_ts56),
        
                     .CLKRD_P0                (ram_row_60_col_0_clk_a),
                     .ADRRD_P0                (ADRRD_P0_ts56),
                     .RDEN_P0                 (RDEN_P0_ts56),
                     .QOUT_P0                 (ram_row_60_col_0_data_out_a),
                         
                     .CLKRD_P1                (ram_row_60_col_0_clk_b),
                     .ADRRD_P1                (ADRRD_P1_ts56),
                     .RDEN_P1                 (RDEN_P1_ts56),
                     .QOUT_P1                 (ram_row_60_col_0_data_out_b),                
                                                     
                    
                   //-------------------------------------------------------------
                   // Power Management Interfaces
                   //-------------------------------------------------------------
                  //   .PWR_MGMT_IN                        ({pwr_mgmt_in_rf[PWR_MGMT_IN_SIZE-1:1],ram_fary_pwren_b[60]}), // MSB changed from 3'b100
                  //   .PWR_MGMT_OUT                       (ram_aary_pwren_b[60]),  
                
                       
                     `ifndef INTEL_NO_PWR_PINS
                        .vddp                            (ram_row_60_col_0_vcc),
                        `ifdef INTC_ADD_VSS
                        .vss                            (1'b0),
                        `endif  
                     `endif
               
        
        
        
                      //REPAIR INPUTS
        
                    .FCA           (ram_row_60_col_0_bisr_inst_Q[6:1]), // column repair addres --- > F means faulty
                    .CRE          (ram_row_60_col_0_bisr_inst_Q[0]), //Column repair enable
                    
        
                    // POWER MGMT inputs
                    //.ROP_SD             (), // shutoffout
                    //.ROP_DS             (), //dpslp_or_shutoffout
                    //TEMPCOMMENT1.MPMS              (1'b0), // {shutoff,deepsleep,fastsleep}
        
                    //TIMING and TRIM
                    // MDST = {async_reset0,async_reset1,wmce,mce,stbyp,rmce}
                    .MDST_hs2r2w       ({fary_ffuse_rfhs2r2w_trim[9],fary_ffuse_rfhs2r2w_trim[8],fary_ffuse_rfhs2r2w_trim[7:5],fary_ffuse_rfhs2r2w_trim[4],fary_ffuse_rfhs2r2w_trim[3],fary_ffuse_rfhs2r2w_trim[2:0]}),
                                        
        
                    //DFT inputs
                    .DFTSHIFTEN        (DFTSHIFTEN),
                    .DFTMASK           (DFTMASK),
                    .DFT_ARRAY_FREEZE    (DFT_ARRAY_FREEZE),
                    
                    .DFT_AFD_RESET_B    (DFT_AFD_RESET_B)
        
        
        
        );//ip783rfhs2r2w256x34s0c1p1d0_dft_wrp
        
        assign          ram_rd_data_a_col[60][0]    = ram_row_60_col_0_data_out_a;
        assign          ram_rd_data_b_col[60][0]    = ram_row_60_col_0_data_out_b;
        
             

        wire                            ram_row_61_col_0_clk_a       = clk_a;
        wire                            ram_row_61_col_0_clk_b       = clk_b;
        wire    [8-1:0]       ram_row_61_col_0_wr_adr_a    = ram_row_wr_adr_a[61][8-1:0];
        wire    [8-1:0]       ram_row_61_col_0_wr_adr_b    = ram_row_wr_adr_b[61][8-1:0];
        wire    [8-1:0]       ram_row_61_col_0_rd_adr_a    = ram_row_rd_adr_a[61][8-1:0];
        wire    [8-1:0]       ram_row_61_col_0_rd_adr_b    = ram_row_rd_adr_b[61][8-1:0];
        wire                            ram_row_61_col_0_rd_en_a     = ram_row_rd_en_a[61];
        wire                            ram_row_61_col_0_rd_en_b     = ram_row_rd_en_b[61];
        wire                            ram_row_61_col_0_wr_en_a     = |ram_col_wr_en_a[61][0];
        wire                            ram_row_61_col_0_wr_en_b     = |ram_col_wr_en_b[61][0];
        wire    [34-1:0]              ram_row_61_col_0_data_in_a   = ram_wr_data_a_col[0][34-1:0];
        wire    [34-1:0]              ram_row_61_col_0_data_in_b   = ram_wr_data_b_col[0][34-1:0];
        wire    [34-1:0]              ram_row_61_col_0_data_out_a;
        wire    [34-1:0]              ram_row_61_col_0_data_out_b;
        wire    [2:0]                   ram_row_61_col_0_aary_pwren_b;
        wire                            ram_row_61_col_0_vcc = 1'b1;
        
        
        ip783rfhs2r2w256x34s0c1p1d0_dft_wrp #(
                    )
        ram_row_61_col_0 (
                    //------------------------------------------------------------
                    // Functional Interfaces
                    //------------------------------------------------------------      
        
                     .CLKWR_P0                (ram_row_61_col_0_clk_a),
                     .ADRWR_P0                (ADRWR_P0_ts57),
                     .WREN_P0                 (WREN_P0_ts57),
                     .DIN_P0                  (DIN_P0_ts57),
        
                     .CLKWR_P1                (ram_row_61_col_0_clk_b),
                     .ADRWR_P1                (ADRWR_P1_ts57),
                     .WREN_P1                 (WREN_P1_ts57),
                     .DIN_P1                  (DIN_P1_ts57),
        
                     .CLKRD_P0                (ram_row_61_col_0_clk_a),
                     .ADRRD_P0                (ADRRD_P0_ts57),
                     .RDEN_P0                 (RDEN_P0_ts57),
                     .QOUT_P0                 (ram_row_61_col_0_data_out_a),
                         
                     .CLKRD_P1                (ram_row_61_col_0_clk_b),
                     .ADRRD_P1                (ADRRD_P1_ts57),
                     .RDEN_P1                 (RDEN_P1_ts57),
                     .QOUT_P1                 (ram_row_61_col_0_data_out_b),                
                                                     
                    
                   //-------------------------------------------------------------
                   // Power Management Interfaces
                   //-------------------------------------------------------------
                  //   .PWR_MGMT_IN                        ({pwr_mgmt_in_rf[PWR_MGMT_IN_SIZE-1:1],ram_fary_pwren_b[61]}), // MSB changed from 3'b100
                  //   .PWR_MGMT_OUT                       (ram_aary_pwren_b[61]),  
                
                       
                     `ifndef INTEL_NO_PWR_PINS
                        .vddp                            (ram_row_61_col_0_vcc),
                        `ifdef INTC_ADD_VSS
                        .vss                            (1'b0),
                        `endif  
                     `endif
               
        
        
        
                      //REPAIR INPUTS
        
                    .FCA           (ram_row_61_col_0_bisr_inst_Q[6:1]), // column repair addres --- > F means faulty
                    .CRE          (ram_row_61_col_0_bisr_inst_Q[0]), //Column repair enable
                    
        
                    // POWER MGMT inputs
                    //.ROP_SD             (), // shutoffout
                    //.ROP_DS             (), //dpslp_or_shutoffout
                    //TEMPCOMMENT1.MPMS              (1'b0), // {shutoff,deepsleep,fastsleep}
        
                    //TIMING and TRIM
                    // MDST = {async_reset0,async_reset1,wmce,mce,stbyp,rmce}
                    .MDST_hs2r2w       ({fary_ffuse_rfhs2r2w_trim[9],fary_ffuse_rfhs2r2w_trim[8],fary_ffuse_rfhs2r2w_trim[7:5],fary_ffuse_rfhs2r2w_trim[4],fary_ffuse_rfhs2r2w_trim[3],fary_ffuse_rfhs2r2w_trim[2:0]}),
                                        
        
                    //DFT inputs
                    .DFTSHIFTEN        (DFTSHIFTEN),
                    .DFTMASK           (DFTMASK),
                    .DFT_ARRAY_FREEZE    (DFT_ARRAY_FREEZE),
                    
                    .DFT_AFD_RESET_B    (DFT_AFD_RESET_B)
        
        
        
        );//ip783rfhs2r2w256x34s0c1p1d0_dft_wrp
        
        assign          ram_rd_data_a_col[61][0]    = ram_row_61_col_0_data_out_a;
        assign          ram_rd_data_b_col[61][0]    = ram_row_61_col_0_data_out_b;
        
             

        wire                            ram_row_62_col_0_clk_a       = clk_a;
        wire                            ram_row_62_col_0_clk_b       = clk_b;
        wire    [8-1:0]       ram_row_62_col_0_wr_adr_a    = ram_row_wr_adr_a[62][8-1:0];
        wire    [8-1:0]       ram_row_62_col_0_wr_adr_b    = ram_row_wr_adr_b[62][8-1:0];
        wire    [8-1:0]       ram_row_62_col_0_rd_adr_a    = ram_row_rd_adr_a[62][8-1:0];
        wire    [8-1:0]       ram_row_62_col_0_rd_adr_b    = ram_row_rd_adr_b[62][8-1:0];
        wire                            ram_row_62_col_0_rd_en_a     = ram_row_rd_en_a[62];
        wire                            ram_row_62_col_0_rd_en_b     = ram_row_rd_en_b[62];
        wire                            ram_row_62_col_0_wr_en_a     = |ram_col_wr_en_a[62][0];
        wire                            ram_row_62_col_0_wr_en_b     = |ram_col_wr_en_b[62][0];
        wire    [34-1:0]              ram_row_62_col_0_data_in_a   = ram_wr_data_a_col[0][34-1:0];
        wire    [34-1:0]              ram_row_62_col_0_data_in_b   = ram_wr_data_b_col[0][34-1:0];
        wire    [34-1:0]              ram_row_62_col_0_data_out_a;
        wire    [34-1:0]              ram_row_62_col_0_data_out_b;
        wire    [2:0]                   ram_row_62_col_0_aary_pwren_b;
        wire                            ram_row_62_col_0_vcc = 1'b1;
        
        
        ip783rfhs2r2w256x34s0c1p1d0_dft_wrp #(
                    )
        ram_row_62_col_0 (
                    //------------------------------------------------------------
                    // Functional Interfaces
                    //------------------------------------------------------------      
        
                     .CLKWR_P0                (ram_row_62_col_0_clk_a),
                     .ADRWR_P0                (ADRWR_P0_ts58),
                     .WREN_P0                 (WREN_P0_ts58),
                     .DIN_P0                  (DIN_P0_ts58),
        
                     .CLKWR_P1                (ram_row_62_col_0_clk_b),
                     .ADRWR_P1                (ADRWR_P1_ts58),
                     .WREN_P1                 (WREN_P1_ts58),
                     .DIN_P1                  (DIN_P1_ts58),
        
                     .CLKRD_P0                (ram_row_62_col_0_clk_a),
                     .ADRRD_P0                (ADRRD_P0_ts58),
                     .RDEN_P0                 (RDEN_P0_ts58),
                     .QOUT_P0                 (ram_row_62_col_0_data_out_a),
                         
                     .CLKRD_P1                (ram_row_62_col_0_clk_b),
                     .ADRRD_P1                (ADRRD_P1_ts58),
                     .RDEN_P1                 (RDEN_P1_ts58),
                     .QOUT_P1                 (ram_row_62_col_0_data_out_b),                
                                                     
                    
                   //-------------------------------------------------------------
                   // Power Management Interfaces
                   //-------------------------------------------------------------
                  //   .PWR_MGMT_IN                        ({pwr_mgmt_in_rf[PWR_MGMT_IN_SIZE-1:1],ram_fary_pwren_b[62]}), // MSB changed from 3'b100
                  //   .PWR_MGMT_OUT                       (ram_aary_pwren_b[62]),  
                
                       
                     `ifndef INTEL_NO_PWR_PINS
                        .vddp                            (ram_row_62_col_0_vcc),
                        `ifdef INTC_ADD_VSS
                        .vss                            (1'b0),
                        `endif  
                     `endif
               
        
        
        
                      //REPAIR INPUTS
        
                    .FCA           (ram_row_62_col_0_bisr_inst_Q[6:1]), // column repair addres --- > F means faulty
                    .CRE          (ram_row_62_col_0_bisr_inst_Q[0]), //Column repair enable
                    
        
                    // POWER MGMT inputs
                    //.ROP_SD             (), // shutoffout
                    //.ROP_DS             (), //dpslp_or_shutoffout
                    //TEMPCOMMENT1.MPMS              (1'b0), // {shutoff,deepsleep,fastsleep}
        
                    //TIMING and TRIM
                    // MDST = {async_reset0,async_reset1,wmce,mce,stbyp,rmce}
                    .MDST_hs2r2w       ({fary_ffuse_rfhs2r2w_trim[9],fary_ffuse_rfhs2r2w_trim[8],fary_ffuse_rfhs2r2w_trim[7:5],fary_ffuse_rfhs2r2w_trim[4],fary_ffuse_rfhs2r2w_trim[3],fary_ffuse_rfhs2r2w_trim[2:0]}),
                                        
        
                    //DFT inputs
                    .DFTSHIFTEN        (DFTSHIFTEN),
                    .DFTMASK           (DFTMASK),
                    .DFT_ARRAY_FREEZE    (DFT_ARRAY_FREEZE),
                    
                    .DFT_AFD_RESET_B    (DFT_AFD_RESET_B)
        
        
        
        );//ip783rfhs2r2w256x34s0c1p1d0_dft_wrp
        
        assign          ram_rd_data_a_col[62][0]    = ram_row_62_col_0_data_out_a;
        assign          ram_rd_data_b_col[62][0]    = ram_row_62_col_0_data_out_b;
        
             

        wire                            ram_row_63_col_0_clk_a       = clk_a;
        wire                            ram_row_63_col_0_clk_b       = clk_b;
        wire    [8-1:0]       ram_row_63_col_0_wr_adr_a    = ram_row_wr_adr_a[63][8-1:0];
        wire    [8-1:0]       ram_row_63_col_0_wr_adr_b    = ram_row_wr_adr_b[63][8-1:0];
        wire    [8-1:0]       ram_row_63_col_0_rd_adr_a    = ram_row_rd_adr_a[63][8-1:0];
        wire    [8-1:0]       ram_row_63_col_0_rd_adr_b    = ram_row_rd_adr_b[63][8-1:0];
        wire                            ram_row_63_col_0_rd_en_a     = ram_row_rd_en_a[63];
        wire                            ram_row_63_col_0_rd_en_b     = ram_row_rd_en_b[63];
        wire                            ram_row_63_col_0_wr_en_a     = |ram_col_wr_en_a[63][0];
        wire                            ram_row_63_col_0_wr_en_b     = |ram_col_wr_en_b[63][0];
        wire    [34-1:0]              ram_row_63_col_0_data_in_a   = ram_wr_data_a_col[0][34-1:0];
        wire    [34-1:0]              ram_row_63_col_0_data_in_b   = ram_wr_data_b_col[0][34-1:0];
        wire    [34-1:0]              ram_row_63_col_0_data_out_a;
        wire    [34-1:0]              ram_row_63_col_0_data_out_b;
        wire    [2:0]                   ram_row_63_col_0_aary_pwren_b;
        wire                            ram_row_63_col_0_vcc = 1'b1;
        
        
        ip783rfhs2r2w256x34s0c1p1d0_dft_wrp #(
                    )
        ram_row_63_col_0 (
                    //------------------------------------------------------------
                    // Functional Interfaces
                    //------------------------------------------------------------      
        
                     .CLKWR_P0                (ram_row_63_col_0_clk_a),
                     .ADRWR_P0                (ADRWR_P0_ts59),
                     .WREN_P0                 (WREN_P0_ts59),
                     .DIN_P0                  (DIN_P0_ts59),
        
                     .CLKWR_P1                (ram_row_63_col_0_clk_b),
                     .ADRWR_P1                (ADRWR_P1_ts59),
                     .WREN_P1                 (WREN_P1_ts59),
                     .DIN_P1                  (DIN_P1_ts59),
        
                     .CLKRD_P0                (ram_row_63_col_0_clk_a),
                     .ADRRD_P0                (ADRRD_P0_ts59),
                     .RDEN_P0                 (RDEN_P0_ts59),
                     .QOUT_P0                 (ram_row_63_col_0_data_out_a),
                         
                     .CLKRD_P1                (ram_row_63_col_0_clk_b),
                     .ADRRD_P1                (ADRRD_P1_ts59),
                     .RDEN_P1                 (RDEN_P1_ts59),
                     .QOUT_P1                 (ram_row_63_col_0_data_out_b),                
                                                     
                    
                   //-------------------------------------------------------------
                   // Power Management Interfaces
                   //-------------------------------------------------------------
                  //   .PWR_MGMT_IN                        ({pwr_mgmt_in_rf[PWR_MGMT_IN_SIZE-1:1],ram_fary_pwren_b[63]}), // MSB changed from 3'b100
                  //   .PWR_MGMT_OUT                       (ram_aary_pwren_b[63]),  
                
                       
                     `ifndef INTEL_NO_PWR_PINS
                        .vddp                            (ram_row_63_col_0_vcc),
                        `ifdef INTC_ADD_VSS
                        .vss                            (1'b0),
                        `endif  
                     `endif
               
        
        
        
                      //REPAIR INPUTS
        
                    .FCA           (ram_row_63_col_0_bisr_inst_Q[6:1]), // column repair addres --- > F means faulty
                    .CRE          (ram_row_63_col_0_bisr_inst_Q[0]), //Column repair enable
                    
        
                    // POWER MGMT inputs
                    //.ROP_SD             (), // shutoffout
                    //.ROP_DS             (), //dpslp_or_shutoffout
                    //TEMPCOMMENT1.MPMS              (1'b0), // {shutoff,deepsleep,fastsleep}
        
                    //TIMING and TRIM
                    // MDST = {async_reset0,async_reset1,wmce,mce,stbyp,rmce}
                    .MDST_hs2r2w       ({fary_ffuse_rfhs2r2w_trim[9],fary_ffuse_rfhs2r2w_trim[8],fary_ffuse_rfhs2r2w_trim[7:5],fary_ffuse_rfhs2r2w_trim[4],fary_ffuse_rfhs2r2w_trim[3],fary_ffuse_rfhs2r2w_trim[2:0]}),
                                        
        
                    //DFT inputs
                    .DFTSHIFTEN        (DFTSHIFTEN),
                    .DFTMASK           (DFTMASK),
                    .DFT_ARRAY_FREEZE    (DFT_ARRAY_FREEZE),
                    
                    .DFT_AFD_RESET_B    (DFT_AFD_RESET_B)
        
        
        
        );//ip783rfhs2r2w256x34s0c1p1d0_dft_wrp
        
        assign          ram_rd_data_a_col[63][0]    = ram_row_63_col_0_data_out_a;
        assign          ram_rd_data_b_col[63][0]    = ram_row_63_col_0_data_out_b;
        
             

// DFX output concatination 
                
`elsif HLP_FPGA_MEMS
/*
////////////////////////////////////////////////////////////////////////
//
//                              FPGA MEMORIES                                                                                                                   
//
////////////////////////////////////////////////////////////////////////



// per coordination with FPGA team - 2R2W would be implemented using Flops



        wire    [      MEM_WIDTH-1:0]   rd_data_a_int;
        wire    [      MEM_WIDTH-1:0]   rd_data_b_int;

    ecip_mgm_flop_based_2r2w_memory #(
        .MEM_WIDTH        (MEM_WIDTH),
        .MEM_DEPTH        (MEM_DEPTH),
        .MEM_WR_RESOLUTION(MEM_WR_RESOLUTION),
        .MEM_WR_EN_WIDTH  (MEM_WR_EN_WIDTH),
        .MEM_ADR_WIDTH    (MEM_ADR_WIDTH)
    )

    fpga_mem (
        .clk_a     (clk_a),
        .clk_b     (clk_b),
        .rd_add_a  (rd_adr_a),
        .rd_add_b  (rd_adr_b),
        .wr_add_a  (wr_adr_a),
        .wr_add_b  (wr_adr_b),
        .rd_en_a   (rd_en_a),
        .rd_en_b   (rd_en_b),
        .wr_en_a   (wr_en_a),
        .wr_en_b   (wr_en_b),
        .data_in_a (wr_data_a),
        .data_in_b (wr_data_b),
        .data_out_a(rd_data_a_int),
        .data_out_b(rd_data_b_int)
    );




        // Read Delay A
        logic   [MEM_DELAY:0]           rd_en_a_delay;
        always_comb
                rd_en_a_delay[0]                        = rd_en_a;
        always @(posedge clk_a) begin
                rd_en_a_delay[MEM_DELAY:1]      <= rd_en_a_delay[MEM_DELAY-1:0];
        end
        assign          rd_valid_a                      = rd_en_a_delay[MEM_DELAY];

        // Read Data Delay A
        logic   [MEM_WIDTH-1:0]         rd_data_a_delay[MEM_DELAY:0];
        always_comb
                rd_data_a_delay[0]                      = rd_data_a_int;
        always @(posedge clk_a) begin
                for (int i = 1; i <= MEM_DELAY; i = i + 1) begin
                        if (rd_en_a_delay[i])
                                rd_data_a_delay[i]      <= rd_data_a_delay[i-1];
                end
        end
        assign          rd_data_a[MEM_WIDTH-1:0]        = rd_en_a_delay[MEM_DELAY] ? rd_data_a_delay[MEM_DELAY-1][MEM_WIDTH-1:0] : rd_data_a_delay[MEM_DELAY][MEM_WIDTH-1:0];

        // Read Delay B
        logic   [MEM_DELAY:0]           rd_en_b_delay;
        always_comb
                rd_en_b_delay[0]                        = rd_en_b;
        always @(posedge clk_b) begin
                rd_en_b_delay[MEM_DELAY:1]      <= rd_en_b_delay[MEM_DELAY-1:0];
        end
        assign          rd_valid_b                      = rd_en_b_delay[MEM_DELAY];

        // Read Data Delay B
        logic   [MEM_WIDTH-1:0]         rd_data_b_delay[MEM_DELAY:0];
        always_comb
                rd_data_b_delay[0]                      = rd_data_b_int;
        always @(posedge clk_b) begin
                for (int i = 1; i <= MEM_DELAY; i = i + 1) begin
                        if (rd_en_b_delay[i])
                                rd_data_b_delay[i]      <= rd_data_b_delay[i-1];
                end
        end
        assign          rd_data_b[MEM_WIDTH-1:0]        = rd_en_b_delay[MEM_DELAY] ? rd_data_b_delay[MEM_DELAY-1][MEM_WIDTH-1:0] : rd_data_b_delay[MEM_DELAY][MEM_WIDTH-1:0];

        `ifdef HLP_RTL
                generate
                        if (MEM_INIT_TYPE == 1)
                                begin:  CONST_MEM_INIT

                                        reg [MEM_WIDTH-1:0] init_word[MEM_DEPTH-1:0];

                                        hlp_mgm_functions mem_func();

                                        if (MEM_PROT_TYPE < 2) begin    
                                                
                                                initial begin
                                                
                                                        for (int i = 0; i < MEM_DEPTH; i = i + 1) begin
                                                                for (int j = 0; j < MEM_INIT_PROT_INST_NUM; j = j + 1) begin
                                                                        init_word[i][j*(MEM_INIT_VALUE_WIDTH/MEM_INIT_PROT_INST_NUM) +: MEM_INIT_VALUE_WIDTH/MEM_INIT_PROT_INST_NUM]    = MEM_INIT_VALUE[j*(MEM_INIT_VALUE_WIDTH/MEM_INIT_PROT_INST_NUM)+:(MEM_INIT_VALUE_WIDTH/MEM_INIT_PROT_INST_NUM)];
                                                                        init_word[i][MEM_INIT_VALUE_WIDTH + j*(MEM_PROT_INST_WIDTH)  +: MEM_PROT_INST_WIDTH]                            = mem_func.gen_ecc(MEM_INIT_VALUE[j*(MEM_INIT_VALUE_WIDTH/MEM_INIT_PROT_INST_NUM)+:(MEM_INIT_VALUE_WIDTH/MEM_INIT_PROT_INST_NUM)], MEM_PROT_TYPE);
                                                                end
                                                        end
                                                        
                                                end
                                                
                                        end
                                        else begin
                                        
                                                initial begin

                                                        for (int i = 0; i < MEM_DEPTH; i = i + 1) begin
                                                                init_word[i] = MEM_INIT_VALUE;
                                                        end
                                                
                                                end
                                        
                                        end

                                        if (FPGA_MEM_ZERO_PADDING > 0) begin
                                                always @(posedge reset_n)
                                                        if ($test$plusargs("HLP_FAST_CONFIG")) begin
                                                                for (int i = 0; i < MEM_DEPTH; i = i + 1)
                                                                        for(int j = 0; j < MEM_WR_EN_WIDTH; j = j + 1)
                                                                                fpga_mem.sram[i][j*FPGA_MEM_WR_RESOLUTION+:FPGA_MEM_WR_RESOLUTION]  = {{(FPGA_MEM_ZERO_PADDING){1'b0}},init_word[i][j*MEM_WR_RESOLUTION+:MEM_WR_RESOLUTION]};
                                                        end
                                        end
                                        else begin
                                                always @(posedge reset_n)
                                                        if ($test$plusargs("HLP_FAST_CONFIG")) begin
                                                                for (int i = 0; i < MEM_DEPTH; i = i + 1)
                                                                        for(int j = 0; j < MEM_WR_EN_WIDTH; j = j + 1)
                                                                                fpga_mem.sram[i][j*FPGA_MEM_WR_RESOLUTION+:FPGA_MEM_WR_RESOLUTION]  = {init_word[i][j*MEM_WR_RESOLUTION+:MEM_WR_RESOLUTION]};
                                                        end
                                        end
                                                                                                                                
                                end
                        else if (MEM_INIT_TYPE == 2)
                                begin:  LL_MEM_INIT
                                
                                        reg [MEM_WIDTH-1:0] init_word[MEM_DEPTH-1:0];

                                        hlp_mgm_functions mem_func();

                                        if (MEM_PROT_TYPE < 2) begin    
                                                
                                                initial begin
                                                        init_word[MEM_DEPTH-1]={(MEM_INIT_VALUE_WIDTH){1'b0}};
                                                        for (int i = 0; i < MEM_DEPTH-1; i = i + 1) begin
                                                                for (int j = 0; j < MEM_INIT_PROT_INST_NUM; j = j + 1) begin
                                                                        init_word[i][j*(MEM_INIT_VALUE_WIDTH/MEM_INIT_PROT_INST_NUM) +: MEM_INIT_VALUE_WIDTH/MEM_INIT_PROT_INST_NUM]    = i+1;
                                                                        init_word[i][MEM_INIT_VALUE_WIDTH + j*(MEM_PROT_INST_WIDTH)  +: MEM_PROT_INST_WIDTH]                            = mem_func.gen_ecc(i+1, MEM_PROT_TYPE);
                                                                end
                                                        end
                                                        
                                                end
                                                
                                        end
                                        else begin
                                        
                                                initial begin
                                                        init_word[MEM_DEPTH-1]={(MEM_INIT_VALUE_WIDTH){1'b0}};
                                                        for (int i = 0; i < MEM_DEPTH-1; i = i + 1) begin
                                                                init_word[i] = i;
                                                        end
                                                
                                                end
                                        
                                        end

                                        if (FPGA_MEM_ZERO_PADDING > 0) begin
                                                always @(posedge reset_n)
                                                        if ($test$plusargs("HLP_FAST_CONFIG")) begin
                                                                for (int i = 0; i < MEM_DEPTH; i = i + 1)
                                                                        for(int j = 0; j < MEM_WR_EN_WIDTH; j = j + 1)
                                                                                fpga_mem.sram[i][j*FPGA_MEM_WR_RESOLUTION+:FPGA_MEM_WR_RESOLUTION]  = {{(FPGA_MEM_ZERO_PADDING){1'b0}},init_word[i][j*MEM_WR_RESOLUTION+:MEM_WR_RESOLUTION]};
                                                        end
                                        end
                                        else begin
                                                always @(posedge reset_n)
                                                        if ($test$plusargs("HLP_FAST_CONFIG")) begin
                                                                for (int i = 0; i < MEM_DEPTH; i = i + 1)
                                                                        for(int j = 0; j < MEM_WR_EN_WIDTH; j = j + 1)
                                                                                fpga_mem.sram[i][j*FPGA_MEM_WR_RESOLUTION+:FPGA_MEM_WR_RESOLUTION]  = {init_word[i][j*MEM_WR_RESOLUTION+:MEM_WR_RESOLUTION]};
                                                        end
                                        end

                                end
                endgenerate
        `endif

`else
*/
////////////////////////////////////////////////////////////////////////
//
//                              BEHAVE MEMORIES                                                                                                                                         
//
////////////////////////////////////////////////////////////////////////
        
        wire    [MEM_WIDTH-1:0]         behave_mem_rd_data_a;
        wire    [MEM_WIDTH-1:0]         behave_mem_rd_data_b;
        wire    [MEM_WIDTH-1:0]         rd_data_a_int, rd_data_b_int;
        assign                          rd_data_a_int   = behave_mem_rd_data_a;
        assign                          rd_data_b_int   = behave_mem_rd_data_b;

        hlp_mgm_2r2w_behave #(
                .MEM_WIDTH              (MEM_WIDTH)                     ,
                .MEM_DEPTH              (MEM_DEPTH)                     ,
                .MEM_WR_RESOLUTION      (MEM_WR_RESOLUTION), 
                .MEM_ADDR_COLL_X        (1)) // Apply 'X on data output in case rd/wr addressing collide (SAME RD_WR ADDR COLLISION IND  <YES, NO>)
        behave_mem (
                .clk_a                  (clk_a)                         ,
                .clk_b                  (clk_b)                         ,
                .rd_add_a               (rd_adr_a)                      ,
                .rd_add_b               (rd_adr_b)                      ,
                .wr_add_a               (wr_adr_a)                      ,
                .wr_add_b               (wr_adr_b)                      ,
                .rd_en_a                (rd_en_a)                       ,
                .rd_en_b                (rd_en_b)                       ,
                .wr_en_a                (wr_en_a)                       ,
                .wr_en_b                (wr_en_b)                       ,
                .data_in_a              (wr_data_a)                     ,
                .data_in_b              (wr_data_b)                     ,
                .data_out_a             (behave_mem_rd_data_a)          ,
                .data_out_b             (behave_mem_rd_data_b));

        // Read Delay A
        logic   [MEM_DELAY:0]           rd_en_a_delay;
        always_comb
                rd_en_a_delay[0]                        = rd_en_a;
        always @(posedge clk_a) begin
                rd_en_a_delay[MEM_DELAY:1]      <= rd_en_a_delay[MEM_DELAY-1:0];
        end
        assign          rd_valid_a                      = rd_en_a_delay[MEM_DELAY];

        // Read Data Delay A
        logic   [MEM_WIDTH-1:0]         rd_data_a_delay[MEM_DELAY:0];
        always_comb
                rd_data_a_delay[0]                      = rd_data_a_int;
        always @(posedge clk_a) begin
                for (int i = 1; i <= MEM_DELAY; i = i + 1) begin
                        if (rd_en_a_delay[i])
                                rd_data_a_delay[i]      <= rd_data_a_delay[i-1];
                end
        end
        assign          rd_data_a[MEM_WIDTH-1:0]        = rd_en_a_delay[MEM_DELAY] ? rd_data_a_delay[MEM_DELAY-1][MEM_WIDTH-1:0] : rd_data_a_delay[MEM_DELAY][MEM_WIDTH-1:0];

        // Read Delay B
        logic   [MEM_DELAY:0]           rd_en_b_delay;
        always_comb
                rd_en_b_delay[0]                        = rd_en_b;
        always @(posedge clk_b) begin
                rd_en_b_delay[MEM_DELAY:1]      <= rd_en_b_delay[MEM_DELAY-1:0];
        end
        assign          rd_valid_b                      = rd_en_b_delay[MEM_DELAY];

        // Read Data Delay B
        logic   [MEM_WIDTH-1:0]         rd_data_b_delay[MEM_DELAY:0];
        always_comb
                rd_data_b_delay[0]                      = rd_data_b_int;
        always @(posedge clk_b) begin
                for (int i = 1; i <= MEM_DELAY; i = i + 1) begin
                        if (rd_en_b_delay[i])
                                rd_data_b_delay[i]      <= rd_data_b_delay[i-1];
                end
        end
        assign          rd_data_b[MEM_WIDTH-1:0]        = rd_en_b_delay[MEM_DELAY] ? rd_data_b_delay[MEM_DELAY-1][MEM_WIDTH-1:0] : rd_data_b_delay[MEM_DELAY][MEM_WIDTH-1:0];

        `ifdef HLP_RTL
                generate

                        logic   [MEM_WIDTH_NO_SIG + (MEM_WR_RESOLUTION_ZERO_PADDING * MEM_WR_EN_WIDTH) - 1:0]  wr_data_for_prot_full_int                          ;
                        logic   [MEM_WIDTH_NO_SIG + MEM_TOTAL_ZERO_PADDING - 1:0]                              wr_data_for_prot_full                              ;
                        logic   [MEM_PROT_PER_GEN_INST-1:0]                                             wr_data_for_prot_interlv[MEM_PROT_TOTAL_GEN_INST-1:0]     ;
                        logic   [MEM_PROT_TOTAL_WIDTH-1:0]              signature_full;
                        logic   [MEM_WIDTH-1:0]                 prot_wr_data_out;


                        if (MEM_INIT_TYPE == 1)
                                begin:  CONST_MEM_INIT

                                        logic [MEM_WIDTH-1:0] init_word[MEM_DEPTH-1:0];
                                        logic [MEM_INIT_VALUE_WIDTH-1:0] init_value = MEM_INIT_VALUE[MEM_INIT_VALUE_WIDTH-1:0];                                                                 

                                        hlp_mgm_functions mem_func();

                                        if (MEM_PROT_TYPE < 2) begin    
                                                
                                                initial begin
                                                
                
                                                // Zero Padding before protection
                                                        wr_data_for_prot_full_int[MEM_WIDTH_NO_SIG + (MEM_WR_RESOLUTION_ZERO_PADDING * MEM_WR_EN_WIDTH) - 1:0]                 = {(MEM_WIDTH_NO_SIG + (MEM_WR_RESOLUTION_ZERO_PADDING * MEM_WR_EN_WIDTH)){1'b0}}      ;
                                                        for (int i=0; i<MEM_WR_EN_WIDTH; i=i+1) begin
                                                                wr_data_for_prot_full_int[i*(MEM_WR_RESOLUTION_NO_SIG + MEM_WR_RESOLUTION_ZERO_PADDING)+:MEM_WR_RESOLUTION_NO_SIG]    = init_value[i*(MEM_WR_RESOLUTION_NO_SIG)+:MEM_WR_RESOLUTION_NO_SIG]                         ;
                                                        end

                                                        wr_data_for_prot_full[MEM_WIDTH_NO_SIG + MEM_TOTAL_ZERO_PADDING - 1:0]                                                 = {(MEM_WIDTH_NO_SIG + MEM_TOTAL_ZERO_PADDING){1'b0}}                                  ;
                                                        for (int i=0; i<MEM_WR_RES_PROT_FRAGM*MEM_WR_EN_WIDTH; i=i+1) begin
                                                                wr_data_for_prot_full[i*(MEM_PROT_RESOLUTION + MEM_PROT_RESOLUTION_ZERO_PADDING)+:MEM_PROT_RESOLUTION]  = wr_data_for_prot_full_int[i*(MEM_PROT_RESOLUTION)+:MEM_PROT_RESOLUTION]       ;
                                                        end

                                                // Interleaving
                                                        for (int i=0; i<MEM_WR_EN_WIDTH*MEM_WR_RES_PROT_FRAGM; i=i+1) begin
                                                                for (int j=0; j<MEM_PROT_INTERLV_LEVEL; j=j+1) begin
                                                                        for (int k=0; k<MEM_PROT_PER_GEN_INST; k=k+1) begin
                                                                                wr_data_for_prot_interlv[i*(MEM_PROT_INTERLV_LEVEL)+j][k]       = wr_data_for_prot_full[i*(MEM_PROT_RESOLUTION+MEM_PROT_RESOLUTION_ZERO_PADDING)+k*(MEM_PROT_INTERLV_LEVEL)+j]                          ;
                                                                        end
                                                                end
                                                        end

                                                // Combining all signatures into one 
           
                                                        for (int i=0; i<MEM_PROT_TOTAL_GEN_INST; i=i+1) begin
                                                                signature_full[i*MEM_PROT_INST_WIDTH_NO_SIG+:MEM_PROT_INST_WIDTH_NO_SIG] =mem_func.gen_ecc(wr_data_for_prot_interlv[i][MEM_PROT_PER_GEN_INST-1:0], MEM_PROT_TYPE);                

                                                        end
                                                

                                                // Combining the write data together with the signature
                                                
                                                        for (int i=0; i<MEM_WR_EN_WIDTH; i=i+1) begin
                                                                prot_wr_data_out[i*MEM_WR_RESOLUTION+:MEM_WR_RESOLUTION]={signature_full[i*MEM_PROT_TOTAL_WIDTH/MEM_WR_EN_WIDTH+:MEM_PROT_TOTAL_WIDTH/MEM_WR_EN_WIDTH],MEM_INIT_VALUE[i*MEM_WR_RESOLUTION_NO_SIG+:MEM_WR_RESOLUTION_NO_SIG]};
                                                        end
                                    
                                                        for (int i = 0; i < MEM_DEPTH; i = i + 1) begin
                                                                        init_word[i][MEM_WIDTH-1:0]    = prot_wr_data_out[MEM_WIDTH-1:0];
                                                        end
                                                        
                                                        
                                                end
                                        end        
                                        else begin
                                        
                                                initial begin

                                                        for (int i = 0; i < MEM_DEPTH; i = i + 1) begin
                                                                init_word[i] = MEM_INIT_VALUE;
                                                        end
                                                
                                                end
                                        
                                        end

                                        always @(posedge reset_n) 
                                                if ($test$plusargs("HLP_FAST_CONFIG")) begin
                                                        for (int i = 0; i < MEM_DEPTH; i = i + 1)
                                                                behave_mem.sram[i]      = init_word[i];
                                                end
                                                                                                        
                                end
                        else if (MEM_INIT_TYPE == 2)
                                begin:  LL_MEM_INIT

                                        logic [MEM_WIDTH-1:0] init_word[MEM_DEPTH-1:0]    ;
                                        logic [MEM_INIT_VALUE_WIDTH-1:0] init_value       ;                                     

                                        hlp_mgm_functions mem_func();

                                        if (MEM_PROT_TYPE < 2) begin    
                                                
                                                initial begin

                                                        init_word[MEM_DEPTH-1]={(MEM_INIT_VALUE_WIDTH){1'b0}};
                                                        for (int i = 0; i < MEM_DEPTH-1; i = i + 1) begin
                                                                init_value=i+1    ;                                                                     
 
                                                        // Zero Padding before protection
                                                        
                                                                wr_data_for_prot_full_int[MEM_WIDTH_NO_SIG + (MEM_WR_RESOLUTION_ZERO_PADDING * MEM_WR_EN_WIDTH) - 1:0]                 = {(MEM_WIDTH_NO_SIG + (MEM_WR_RESOLUTION_ZERO_PADDING * MEM_WR_EN_WIDTH)){1'b0}}      ;
                                                                for (int i=0; i<MEM_WR_EN_WIDTH; i=i+1) begin
                                                                        wr_data_for_prot_full_int[i*(MEM_WR_RESOLUTION_NO_SIG + MEM_WR_RESOLUTION_ZERO_PADDING)+:MEM_WR_RESOLUTION_NO_SIG]    = init_value[i*(MEM_WR_RESOLUTION_NO_SIG)+:MEM_WR_RESOLUTION_NO_SIG]                         ;
                                                                end

                                                                wr_data_for_prot_full[MEM_WIDTH_NO_SIG + MEM_TOTAL_ZERO_PADDING - 1:0]                                                 = {(MEM_WIDTH_NO_SIG + MEM_TOTAL_ZERO_PADDING){1'b0}}                                  ;
                                                                for (int i=0; i<MEM_WR_RES_PROT_FRAGM*MEM_WR_EN_WIDTH; i=i+1) begin
                                                                        wr_data_for_prot_full[i*(MEM_PROT_RESOLUTION + MEM_PROT_RESOLUTION_ZERO_PADDING)+:MEM_PROT_RESOLUTION]  = wr_data_for_prot_full_int[i*(MEM_PROT_RESOLUTION)+:MEM_PROT_RESOLUTION]       ;
                                                                end

                                                        // Interleaving

                                                                for (int i=0; i<MEM_WR_EN_WIDTH*MEM_WR_RES_PROT_FRAGM; i=i+1) begin
                                                                        for (int j=0; j<MEM_PROT_INTERLV_LEVEL; j=j+1) begin
                                                                                for (int k=0; k<MEM_PROT_PER_GEN_INST; k=k+1) begin
                                                                                        wr_data_for_prot_interlv[i*(MEM_PROT_INTERLV_LEVEL)+j][k]       = wr_data_for_prot_full[i*(MEM_PROT_RESOLUTION+MEM_PROT_RESOLUTION_ZERO_PADDING)+k*(MEM_PROT_INTERLV_LEVEL)+j]                          ;
                                                                                end
                                                                        end
                                                                end

                                                        // Combining all signatures into one 
           
                                                                for (int i=0; i<MEM_PROT_TOTAL_GEN_INST; i=i+1) begin
                                                                        signature_full[i*MEM_PROT_INST_WIDTH_NO_SIG+:MEM_PROT_INST_WIDTH_NO_SIG] =mem_func.gen_ecc(wr_data_for_prot_interlv[i][MEM_PROT_PER_GEN_INST-1:0], MEM_PROT_TYPE);                
        
                                                                end
                                                        

                                                        // Combining the write data together with the signature

                                                                for (int i=0; i<MEM_WR_EN_WIDTH; i=i+1) begin
                                                                        prot_wr_data_out[i*MEM_WR_RESOLUTION+:MEM_WR_RESOLUTION]={signature_full[i*MEM_PROT_TOTAL_WIDTH/MEM_WR_EN_WIDTH+:MEM_PROT_TOTAL_WIDTH/MEM_WR_EN_WIDTH],init_value[i*MEM_WR_RESOLUTION_NO_SIG+:MEM_WR_RESOLUTION_NO_SIG]};
                                                                end
                                                        



                                                        // put a protected word back                    
                                                                init_word[i][MEM_WIDTH-1:0]    = prot_wr_data_out[MEM_WIDTH-1:0];
                                                       
                                                       end 
                                                end
                                        end        
                                        else begin
                                        
                                                initial begin
                                                        init_word[MEM_DEPTH-1]={(MEM_INIT_VALUE_WIDTH){1'b0}};
                                                        for (int i = 0; i < MEM_DEPTH-1; i = i + 1) begin
                                                                init_word[i] = i+1;
                                                        end
                                                
                                                end
                                        
                                        end

                                        always @(posedge reset_n) begin
                                                if ($test$plusargs("HLP_FAST_CONFIG"))
                                                        for (int i = 0; i < MEM_DEPTH; i = i + 1)
                                                                behave_mem.sram[i]      = init_word[i];
                                                end

                                end
                endgenerate     
        `endif
        
`endif


  hlp_sched_apr_rtl_tessent_mbist_RF_c3_interface_MEM1 ram_row_0_col_0_interface_inst(
      .BIST_SHADOW_READENABLE(BIST_SHADOW_READENABLE), .BIST_SHADOW_READADDRESS(BIST_SHADOW_READADDRESS), 
      .BIST_CONREAD_ROWADDRESS(BIST_CONREAD_ROWADDRESS), .BIST_CONREAD_ENABLE(BIST_CONREAD_ENABLE), 
      .BIST_CONWRITE_ROWADDRESS(BIST_CONWRITE_ROWADDRESS), .BIST_CONWRITE_ENABLE(BIST_CONWRITE_ENABLE), 
      .BIST_CLEAR_BIRA(BIST_CLEAR_BIRA), .WREN_P0_IN(ram_row_0_col_0_wr_en_a), 
      .WREN_P1_IN(ram_row_0_col_0_wr_en_b), .RDEN_P0_IN(ram_row_0_col_0_rd_en_a), 
      .RDEN_P1_IN(ram_row_0_col_0_rd_en_b), .ADRRD_P0_IN(ram_row_0_col_0_rd_adr_a[7:0]), 
      .ADRRD_P1_IN(ram_row_0_col_0_rd_adr_b[7:0]), .ADRWR_P0_IN(ram_row_0_col_0_wr_adr_a[7:0]), 
      .ADRWR_P1_IN(ram_row_0_col_0_wr_adr_b[7:0]), .QOUT_P0(ram_row_0_col_0_data_out_a), 
      .QOUT_P1(ram_row_0_col_0_data_out_b), .DIN_P0_IN(ram_row_0_col_0_data_in_a[33:0]), 
      .DIN_P1_IN(ram_row_0_col_0_data_in_b[33:0]), .TCK(to_interfaces_tck), .BIST_CMP(BIST_CMP), 
      .INCLUDE_MEM_RESULTS_REG(INCLUDE_MEM_RESULTS_REG), .BIST_READENABLE(BIST_READENABLE), 
      .BIST_WRITEENABLE(BIST_WRITEENABLE), .BIST_ROW_ADD({BIST_ROW_ADD_ts3, 
      BIST_ROW_ADD_ts2, BIST_ROW_ADD_ts1, BIST_ROW_ADD}), .BIST_BANK_ADD({
      BIST_BANK_ADD_ts3, BIST_BANK_ADD_ts2, BIST_BANK_ADD_ts1, BIST_BANK_ADD}), .BIST_TEST_PORT(BIST_TEST_PORT), 
      .BIST_WRITE_DATA({BIST_WRITE_DATA_ts7, BIST_WRITE_DATA_ts6, 
      BIST_WRITE_DATA_ts5, BIST_WRITE_DATA_ts4, BIST_WRITE_DATA_ts3, 
      BIST_WRITE_DATA_ts2, BIST_WRITE_DATA_ts1, BIST_WRITE_DATA}), .BIST_TESTDATA_SELECT_TO_COLLAR(BIST_TESTDATA_SELECT_TO_COLLAR), 
      .MEM_BYPASS_EN(memory_bypass_to_en), .SCAN_SHIFT_EN(scan_to_en), .MCP_BOUNDING_EN(mcp_bounding_to_en), 
      .BIST_ON(BIST_ON_TO_COLLAR), .BIST_RUN(BIST_RUN_TO_COLLAR0), .BIST_ASYNC_RESETN(BIST_ASYNC_RESET), 
      .BIST_CLK(clk_a), .BIST_SHIFT_COLLAR(BIST_SHIFT_COLLAR), .BIST_EXPECT_DATA({
      BIST_EXPECT_DATA_ts7, BIST_EXPECT_DATA_ts6, BIST_EXPECT_DATA_ts5, 
      BIST_EXPECT_DATA_ts4, BIST_EXPECT_DATA_ts3, BIST_EXPECT_DATA_ts2, 
      BIST_EXPECT_DATA_ts1, BIST_EXPECT_DATA}), .BIST_SI(MEM0_BIST_COLLAR_SI), .BIST_COLLAR_SETUP(BIST_COLLAR_SETUP), 
      .BIST_COLLAR_OPSET_SELECT(BIST_COLLAR_OPSET_SELECT), .BIST_COLLAR_HOLD(BIST_COLLAR_HOLD), 
      .BIST_BIRA_EN(BIST_COLLAR_BIRA_EN), .CHECK_REPAIR_NEEDED(CHECK_REPAIR_NEEDED), 
      .BIST_DIAG_EN(BIST_COLLAR_DIAG_EN), .BIST_CLEAR_DEFAULT(BIST_CLEAR_DEFAULT), 
      .BIST_CLEAR(BIST_CLEAR), .BIST_SETUP2(BIST_SETUP_ts2), .BIST_SETUP1(BIST_SETUP_ts1), 
      .BIST_SETUP0(BIST_SETUP), .LV_TM(ltest_to_en), .FREEZE_STOP_ERROR(FREEZE_STOP_ERROR), 
      .GO_ID_REG_SEL(GO_ID_REG_SEL), .BIST_COLLAR_EN(BIST_COLLAR_EN0), .FROM_BISR_All_SCOL0_FUSE_REG(ram_row_0_col_0_bisr_inst_Q[6:1]), 
      .FROM_BISR_All_SCOL0_ALLOC_REG(ram_row_0_col_0_bisr_inst_Q[0]), .BIST_SHIFT_BIRA_COLLAR(BIST_SHIFT_BIRA_COLLAR), 
      .RESET_REG_SETUP2(MBISTPG_RESET_REG_SETUP2), .ERROR_CNT_ZERO(ERROR_CNT_ZERO), 
      .WREN_P0(WREN_P0), .WREN_P1(WREN_P1), .RDEN_P0(RDEN_P0), .RDEN_P1(RDEN_P1), 
      .ADRRD_P0(ADRRD_P0), .ADRRD_P1(ADRRD_P1), .ADRWR_P0(ADRWR_P0), .ADRWR_P1(ADRWR_P1), 
      .DIN_P0(DIN_P0), .DIN_P1(DIN_P1), .BIST_SO(BIST_SO), .BIST_GO(BIST_GO), .All_SCOL0_FUSE_REG(All_SCOL0_FUSE_REG[5:0]), 
      .All_SCOL0_ALLOC_REG(All_SCOL0_ALLOC_REG), .REPAIR_STATUS(), .fscan_clkungate(fscan_clkungate)
  );

  hlp_sched_apr_rtl_tessent_mbist_RF_c3_interface_MEM2 ram_row_10_col_0_interface_inst(
      .BIST_SHADOW_READENABLE(BIST_SHADOW_READENABLE), .BIST_SHADOW_READADDRESS(BIST_SHADOW_READADDRESS), 
      .BIST_CONREAD_ROWADDRESS(BIST_CONREAD_ROWADDRESS), .BIST_CONREAD_ENABLE(BIST_CONREAD_ENABLE), 
      .BIST_CONWRITE_ROWADDRESS(BIST_CONWRITE_ROWADDRESS), .BIST_CONWRITE_ENABLE(BIST_CONWRITE_ENABLE), 
      .BIST_CLEAR_BIRA(BIST_CLEAR_BIRA), .WREN_P0_IN(ram_row_10_col_0_wr_en_a), 
      .WREN_P1_IN(ram_row_10_col_0_wr_en_b), .RDEN_P0_IN(ram_row_10_col_0_rd_en_a), 
      .RDEN_P1_IN(ram_row_10_col_0_rd_en_b), .ADRRD_P0_IN(ram_row_10_col_0_rd_adr_a[7:0]), 
      .ADRRD_P1_IN(ram_row_10_col_0_rd_adr_b[7:0]), .ADRWR_P0_IN(ram_row_10_col_0_wr_adr_a[7:0]), 
      .ADRWR_P1_IN(ram_row_10_col_0_wr_adr_b[7:0]), .QOUT_P0(ram_row_10_col_0_data_out_a), 
      .QOUT_P1(ram_row_10_col_0_data_out_b), .DIN_P0_IN(ram_row_10_col_0_data_in_a[33:0]), 
      .DIN_P1_IN(ram_row_10_col_0_data_in_b[33:0]), .TCK(to_interfaces_tck), .BIST_CMP(BIST_CMP), 
      .INCLUDE_MEM_RESULTS_REG(INCLUDE_MEM_RESULTS_REG), .BIST_READENABLE(BIST_READENABLE), 
      .BIST_WRITEENABLE(BIST_WRITEENABLE), .BIST_ROW_ADD({BIST_ROW_ADD_ts3, 
      BIST_ROW_ADD_ts2, BIST_ROW_ADD_ts1, BIST_ROW_ADD}), .BIST_BANK_ADD({
      BIST_BANK_ADD_ts3, BIST_BANK_ADD_ts2, BIST_BANK_ADD_ts1, BIST_BANK_ADD}), .BIST_TEST_PORT(BIST_TEST_PORT), 
      .BIST_WRITE_DATA({BIST_WRITE_DATA_ts7, BIST_WRITE_DATA_ts6, 
      BIST_WRITE_DATA_ts5, BIST_WRITE_DATA_ts4, BIST_WRITE_DATA_ts3, 
      BIST_WRITE_DATA_ts2, BIST_WRITE_DATA_ts1, BIST_WRITE_DATA}), .BIST_TESTDATA_SELECT_TO_COLLAR(BIST_TESTDATA_SELECT_TO_COLLAR), 
      .MEM_BYPASS_EN(memory_bypass_to_en), .SCAN_SHIFT_EN(scan_to_en), .MCP_BOUNDING_EN(mcp_bounding_to_en), 
      .BIST_ON(BIST_ON_TO_COLLAR), .BIST_RUN(BIST_RUN_TO_COLLAR1), .BIST_ASYNC_RESETN(BIST_ASYNC_RESET), 
      .BIST_CLK(clk_a), .BIST_SHIFT_COLLAR(BIST_SHIFT_COLLAR), .BIST_EXPECT_DATA({
      BIST_EXPECT_DATA_ts7, BIST_EXPECT_DATA_ts6, BIST_EXPECT_DATA_ts5, 
      BIST_EXPECT_DATA_ts4, BIST_EXPECT_DATA_ts3, BIST_EXPECT_DATA_ts2, 
      BIST_EXPECT_DATA_ts1, BIST_EXPECT_DATA}), .BIST_SI(MEM1_BIST_COLLAR_SI), .BIST_COLLAR_SETUP(BIST_COLLAR_SETUP), 
      .BIST_COLLAR_OPSET_SELECT(BIST_COLLAR_OPSET_SELECT), .BIST_COLLAR_HOLD(BIST_COLLAR_HOLD), 
      .BIST_BIRA_EN(BIST_COLLAR_BIRA_EN), .CHECK_REPAIR_NEEDED(CHECK_REPAIR_NEEDED), 
      .BIST_DIAG_EN(BIST_COLLAR_DIAG_EN), .BIST_CLEAR_DEFAULT(BIST_CLEAR_DEFAULT), 
      .BIST_CLEAR(BIST_CLEAR), .BIST_SETUP2(BIST_SETUP_ts2), .BIST_SETUP1(BIST_SETUP_ts1), 
      .BIST_SETUP0(BIST_SETUP), .LV_TM(ltest_to_en), .FREEZE_STOP_ERROR(FREEZE_STOP_ERROR), 
      .GO_ID_REG_SEL(GO_ID_REG_SEL), .BIST_COLLAR_EN(BIST_COLLAR_EN1), .FROM_BISR_All_SCOL0_FUSE_REG(ram_row_10_col_0_bisr_inst_Q[6:1]), 
      .FROM_BISR_All_SCOL0_ALLOC_REG(ram_row_10_col_0_bisr_inst_Q[0]), .BIST_SHIFT_BIRA_COLLAR(BIST_SHIFT_BIRA_COLLAR), 
      .RESET_REG_SETUP2(MBISTPG_RESET_REG_SETUP2), .ERROR_CNT_ZERO(ERROR_CNT_ZERO), 
      .WREN_P0(WREN_P0_ts1), .WREN_P1(WREN_P1_ts1), .RDEN_P0(RDEN_P0_ts1), .RDEN_P1(RDEN_P1_ts1), 
      .ADRRD_P0(ADRRD_P0_ts1), .ADRRD_P1(ADRRD_P1_ts1), .ADRWR_P0(ADRWR_P0_ts1), 
      .ADRWR_P1(ADRWR_P1_ts1), .DIN_P0(DIN_P0_ts1), .DIN_P1(DIN_P1_ts1), .BIST_SO(BIST_SO_ts1), 
      .BIST_GO(BIST_GO_ts1), .All_SCOL0_FUSE_REG(All_SCOL0_FUSE_REG_ts1[5:0]), 
      .All_SCOL0_ALLOC_REG(All_SCOL0_ALLOC_REG_ts1), .REPAIR_STATUS(), .fscan_clkungate(fscan_clkungate)
  );

  hlp_sched_apr_rtl_tessent_mbist_RF_c3_interface_MEM3 ram_row_11_col_0_interface_inst(
      .BIST_SHADOW_READENABLE(BIST_SHADOW_READENABLE), .BIST_SHADOW_READADDRESS(BIST_SHADOW_READADDRESS), 
      .BIST_CONREAD_ROWADDRESS(BIST_CONREAD_ROWADDRESS), .BIST_CONREAD_ENABLE(BIST_CONREAD_ENABLE), 
      .BIST_CONWRITE_ROWADDRESS(BIST_CONWRITE_ROWADDRESS), .BIST_CONWRITE_ENABLE(BIST_CONWRITE_ENABLE), 
      .BIST_CLEAR_BIRA(BIST_CLEAR_BIRA), .WREN_P0_IN(ram_row_11_col_0_wr_en_a), 
      .WREN_P1_IN(ram_row_11_col_0_wr_en_b), .RDEN_P0_IN(ram_row_11_col_0_rd_en_a), 
      .RDEN_P1_IN(ram_row_11_col_0_rd_en_b), .ADRRD_P0_IN(ram_row_11_col_0_rd_adr_a[7:0]), 
      .ADRRD_P1_IN(ram_row_11_col_0_rd_adr_b[7:0]), .ADRWR_P0_IN(ram_row_11_col_0_wr_adr_a[7:0]), 
      .ADRWR_P1_IN(ram_row_11_col_0_wr_adr_b[7:0]), .QOUT_P0(ram_row_11_col_0_data_out_a), 
      .QOUT_P1(ram_row_11_col_0_data_out_b), .DIN_P0_IN(ram_row_11_col_0_data_in_a[33:0]), 
      .DIN_P1_IN(ram_row_11_col_0_data_in_b[33:0]), .TCK(to_interfaces_tck), .BIST_CMP(BIST_CMP), 
      .INCLUDE_MEM_RESULTS_REG(INCLUDE_MEM_RESULTS_REG), .BIST_READENABLE(BIST_READENABLE), 
      .BIST_WRITEENABLE(BIST_WRITEENABLE), .BIST_ROW_ADD({BIST_ROW_ADD_ts3, 
      BIST_ROW_ADD_ts2, BIST_ROW_ADD_ts1, BIST_ROW_ADD}), .BIST_BANK_ADD({
      BIST_BANK_ADD_ts3, BIST_BANK_ADD_ts2, BIST_BANK_ADD_ts1, BIST_BANK_ADD}), .BIST_TEST_PORT(BIST_TEST_PORT), 
      .BIST_WRITE_DATA({BIST_WRITE_DATA_ts7, BIST_WRITE_DATA_ts6, 
      BIST_WRITE_DATA_ts5, BIST_WRITE_DATA_ts4, BIST_WRITE_DATA_ts3, 
      BIST_WRITE_DATA_ts2, BIST_WRITE_DATA_ts1, BIST_WRITE_DATA}), .BIST_TESTDATA_SELECT_TO_COLLAR(BIST_TESTDATA_SELECT_TO_COLLAR), 
      .MEM_BYPASS_EN(memory_bypass_to_en), .SCAN_SHIFT_EN(scan_to_en), .MCP_BOUNDING_EN(mcp_bounding_to_en), 
      .BIST_ON(BIST_ON_TO_COLLAR), .BIST_RUN(BIST_RUN_TO_COLLAR2), .BIST_ASYNC_RESETN(BIST_ASYNC_RESET), 
      .BIST_CLK(clk_a), .BIST_SHIFT_COLLAR(BIST_SHIFT_COLLAR), .BIST_EXPECT_DATA({
      BIST_EXPECT_DATA_ts7, BIST_EXPECT_DATA_ts6, BIST_EXPECT_DATA_ts5, 
      BIST_EXPECT_DATA_ts4, BIST_EXPECT_DATA_ts3, BIST_EXPECT_DATA_ts2, 
      BIST_EXPECT_DATA_ts1, BIST_EXPECT_DATA}), .BIST_SI(MEM2_BIST_COLLAR_SI), .BIST_COLLAR_SETUP(BIST_COLLAR_SETUP), 
      .BIST_COLLAR_OPSET_SELECT(BIST_COLLAR_OPSET_SELECT), .BIST_COLLAR_HOLD(BIST_COLLAR_HOLD), 
      .BIST_BIRA_EN(BIST_COLLAR_BIRA_EN), .CHECK_REPAIR_NEEDED(CHECK_REPAIR_NEEDED), 
      .BIST_DIAG_EN(BIST_COLLAR_DIAG_EN), .BIST_CLEAR_DEFAULT(BIST_CLEAR_DEFAULT), 
      .BIST_CLEAR(BIST_CLEAR), .BIST_SETUP2(BIST_SETUP_ts2), .BIST_SETUP1(BIST_SETUP_ts1), 
      .BIST_SETUP0(BIST_SETUP), .LV_TM(ltest_to_en), .FREEZE_STOP_ERROR(FREEZE_STOP_ERROR), 
      .GO_ID_REG_SEL(GO_ID_REG_SEL), .BIST_COLLAR_EN(BIST_COLLAR_EN2), .FROM_BISR_All_SCOL0_FUSE_REG(ram_row_11_col_0_bisr_inst_Q[6:1]), 
      .FROM_BISR_All_SCOL0_ALLOC_REG(ram_row_11_col_0_bisr_inst_Q[0]), .BIST_SHIFT_BIRA_COLLAR(BIST_SHIFT_BIRA_COLLAR), 
      .RESET_REG_SETUP2(MBISTPG_RESET_REG_SETUP2), .ERROR_CNT_ZERO(ERROR_CNT_ZERO), 
      .WREN_P0(WREN_P0_ts2), .WREN_P1(WREN_P1_ts2), .RDEN_P0(RDEN_P0_ts2), .RDEN_P1(RDEN_P1_ts2), 
      .ADRRD_P0(ADRRD_P0_ts2), .ADRRD_P1(ADRRD_P1_ts2), .ADRWR_P0(ADRWR_P0_ts2), 
      .ADRWR_P1(ADRWR_P1_ts2), .DIN_P0(DIN_P0_ts2), .DIN_P1(DIN_P1_ts2), .BIST_SO(BIST_SO_ts2), 
      .BIST_GO(BIST_GO_ts2), .All_SCOL0_FUSE_REG(All_SCOL0_FUSE_REG_ts2[5:0]), 
      .All_SCOL0_ALLOC_REG(All_SCOL0_ALLOC_REG_ts2), .REPAIR_STATUS(), .fscan_clkungate(fscan_clkungate)
  );

  hlp_sched_apr_rtl_tessent_mbist_RF_c3_interface_MEM4 ram_row_12_col_0_interface_inst(
      .BIST_SHADOW_READENABLE(BIST_SHADOW_READENABLE), .BIST_SHADOW_READADDRESS(BIST_SHADOW_READADDRESS), 
      .BIST_CONREAD_ROWADDRESS(BIST_CONREAD_ROWADDRESS), .BIST_CONREAD_ENABLE(BIST_CONREAD_ENABLE), 
      .BIST_CONWRITE_ROWADDRESS(BIST_CONWRITE_ROWADDRESS), .BIST_CONWRITE_ENABLE(BIST_CONWRITE_ENABLE), 
      .BIST_CLEAR_BIRA(BIST_CLEAR_BIRA), .WREN_P0_IN(ram_row_12_col_0_wr_en_a), 
      .WREN_P1_IN(ram_row_12_col_0_wr_en_b), .RDEN_P0_IN(ram_row_12_col_0_rd_en_a), 
      .RDEN_P1_IN(ram_row_12_col_0_rd_en_b), .ADRRD_P0_IN(ram_row_12_col_0_rd_adr_a[7:0]), 
      .ADRRD_P1_IN(ram_row_12_col_0_rd_adr_b[7:0]), .ADRWR_P0_IN(ram_row_12_col_0_wr_adr_a[7:0]), 
      .ADRWR_P1_IN(ram_row_12_col_0_wr_adr_b[7:0]), .QOUT_P0(ram_row_12_col_0_data_out_a), 
      .QOUT_P1(ram_row_12_col_0_data_out_b), .DIN_P0_IN(ram_row_12_col_0_data_in_a[33:0]), 
      .DIN_P1_IN(ram_row_12_col_0_data_in_b[33:0]), .TCK(to_interfaces_tck), .BIST_CMP(BIST_CMP), 
      .INCLUDE_MEM_RESULTS_REG(INCLUDE_MEM_RESULTS_REG), .BIST_READENABLE(BIST_READENABLE), 
      .BIST_WRITEENABLE(BIST_WRITEENABLE), .BIST_ROW_ADD({BIST_ROW_ADD_ts3, 
      BIST_ROW_ADD_ts2, BIST_ROW_ADD_ts1, BIST_ROW_ADD}), .BIST_BANK_ADD({
      BIST_BANK_ADD_ts3, BIST_BANK_ADD_ts2, BIST_BANK_ADD_ts1, BIST_BANK_ADD}), .BIST_TEST_PORT(BIST_TEST_PORT), 
      .BIST_WRITE_DATA({BIST_WRITE_DATA_ts7, BIST_WRITE_DATA_ts6, 
      BIST_WRITE_DATA_ts5, BIST_WRITE_DATA_ts4, BIST_WRITE_DATA_ts3, 
      BIST_WRITE_DATA_ts2, BIST_WRITE_DATA_ts1, BIST_WRITE_DATA}), .BIST_TESTDATA_SELECT_TO_COLLAR(BIST_TESTDATA_SELECT_TO_COLLAR), 
      .MEM_BYPASS_EN(memory_bypass_to_en), .SCAN_SHIFT_EN(scan_to_en), .MCP_BOUNDING_EN(mcp_bounding_to_en), 
      .BIST_ON(BIST_ON_TO_COLLAR), .BIST_RUN(BIST_RUN_TO_COLLAR3), .BIST_ASYNC_RESETN(BIST_ASYNC_RESET), 
      .BIST_CLK(clk_a), .BIST_SHIFT_COLLAR(BIST_SHIFT_COLLAR), .BIST_EXPECT_DATA({
      BIST_EXPECT_DATA_ts7, BIST_EXPECT_DATA_ts6, BIST_EXPECT_DATA_ts5, 
      BIST_EXPECT_DATA_ts4, BIST_EXPECT_DATA_ts3, BIST_EXPECT_DATA_ts2, 
      BIST_EXPECT_DATA_ts1, BIST_EXPECT_DATA}), .BIST_SI(MEM3_BIST_COLLAR_SI), .BIST_COLLAR_SETUP(BIST_COLLAR_SETUP), 
      .BIST_COLLAR_OPSET_SELECT(BIST_COLLAR_OPSET_SELECT), .BIST_COLLAR_HOLD(BIST_COLLAR_HOLD), 
      .BIST_BIRA_EN(BIST_COLLAR_BIRA_EN), .CHECK_REPAIR_NEEDED(CHECK_REPAIR_NEEDED), 
      .BIST_DIAG_EN(BIST_COLLAR_DIAG_EN), .BIST_CLEAR_DEFAULT(BIST_CLEAR_DEFAULT), 
      .BIST_CLEAR(BIST_CLEAR), .BIST_SETUP2(BIST_SETUP_ts2), .BIST_SETUP1(BIST_SETUP_ts1), 
      .BIST_SETUP0(BIST_SETUP), .LV_TM(ltest_to_en), .FREEZE_STOP_ERROR(FREEZE_STOP_ERROR), 
      .GO_ID_REG_SEL(GO_ID_REG_SEL), .BIST_COLLAR_EN(BIST_COLLAR_EN3), .FROM_BISR_All_SCOL0_FUSE_REG(ram_row_12_col_0_bisr_inst_Q[6:1]), 
      .FROM_BISR_All_SCOL0_ALLOC_REG(ram_row_12_col_0_bisr_inst_Q[0]), .BIST_SHIFT_BIRA_COLLAR(BIST_SHIFT_BIRA_COLLAR), 
      .RESET_REG_SETUP2(MBISTPG_RESET_REG_SETUP2), .ERROR_CNT_ZERO(ERROR_CNT_ZERO), 
      .WREN_P0(WREN_P0_ts3), .WREN_P1(WREN_P1_ts3), .RDEN_P0(RDEN_P0_ts3), .RDEN_P1(RDEN_P1_ts3), 
      .ADRRD_P0(ADRRD_P0_ts3), .ADRRD_P1(ADRRD_P1_ts3), .ADRWR_P0(ADRWR_P0_ts3), 
      .ADRWR_P1(ADRWR_P1_ts3), .DIN_P0(DIN_P0_ts3), .DIN_P1(DIN_P1_ts3), .BIST_SO(BIST_SO_ts3), 
      .BIST_GO(BIST_GO_ts3), .All_SCOL0_FUSE_REG(All_SCOL0_FUSE_REG_ts3[5:0]), 
      .All_SCOL0_ALLOC_REG(All_SCOL0_ALLOC_REG_ts3), .REPAIR_STATUS(), .fscan_clkungate(fscan_clkungate)
  );

  hlp_sched_apr_rtl_tessent_mbist_RF_c3_interface_MEM5 ram_row_13_col_0_interface_inst(
      .BIST_SHADOW_READENABLE(BIST_SHADOW_READENABLE), .BIST_SHADOW_READADDRESS(BIST_SHADOW_READADDRESS), 
      .BIST_CONREAD_ROWADDRESS(BIST_CONREAD_ROWADDRESS), .BIST_CONREAD_ENABLE(BIST_CONREAD_ENABLE), 
      .BIST_CONWRITE_ROWADDRESS(BIST_CONWRITE_ROWADDRESS), .BIST_CONWRITE_ENABLE(BIST_CONWRITE_ENABLE), 
      .BIST_CLEAR_BIRA(BIST_CLEAR_BIRA), .WREN_P0_IN(ram_row_13_col_0_wr_en_a), 
      .WREN_P1_IN(ram_row_13_col_0_wr_en_b), .RDEN_P0_IN(ram_row_13_col_0_rd_en_a), 
      .RDEN_P1_IN(ram_row_13_col_0_rd_en_b), .ADRRD_P0_IN(ram_row_13_col_0_rd_adr_a[7:0]), 
      .ADRRD_P1_IN(ram_row_13_col_0_rd_adr_b[7:0]), .ADRWR_P0_IN(ram_row_13_col_0_wr_adr_a[7:0]), 
      .ADRWR_P1_IN(ram_row_13_col_0_wr_adr_b[7:0]), .QOUT_P0(ram_row_13_col_0_data_out_a), 
      .QOUT_P1(ram_row_13_col_0_data_out_b), .DIN_P0_IN(ram_row_13_col_0_data_in_a[33:0]), 
      .DIN_P1_IN(ram_row_13_col_0_data_in_b[33:0]), .TCK(to_interfaces_tck), .BIST_CMP(BIST_CMP), 
      .INCLUDE_MEM_RESULTS_REG(INCLUDE_MEM_RESULTS_REG), .BIST_READENABLE(BIST_READENABLE), 
      .BIST_WRITEENABLE(BIST_WRITEENABLE), .BIST_ROW_ADD({BIST_ROW_ADD_ts3, 
      BIST_ROW_ADD_ts2, BIST_ROW_ADD_ts1, BIST_ROW_ADD}), .BIST_BANK_ADD({
      BIST_BANK_ADD_ts3, BIST_BANK_ADD_ts2, BIST_BANK_ADD_ts1, BIST_BANK_ADD}), .BIST_TEST_PORT(BIST_TEST_PORT), 
      .BIST_WRITE_DATA({BIST_WRITE_DATA_ts7, BIST_WRITE_DATA_ts6, 
      BIST_WRITE_DATA_ts5, BIST_WRITE_DATA_ts4, BIST_WRITE_DATA_ts3, 
      BIST_WRITE_DATA_ts2, BIST_WRITE_DATA_ts1, BIST_WRITE_DATA}), .BIST_TESTDATA_SELECT_TO_COLLAR(BIST_TESTDATA_SELECT_TO_COLLAR), 
      .MEM_BYPASS_EN(memory_bypass_to_en), .SCAN_SHIFT_EN(scan_to_en), .MCP_BOUNDING_EN(mcp_bounding_to_en), 
      .BIST_ON(BIST_ON_TO_COLLAR), .BIST_RUN(BIST_RUN_TO_COLLAR4), .BIST_ASYNC_RESETN(BIST_ASYNC_RESET), 
      .BIST_CLK(clk_a), .BIST_SHIFT_COLLAR(BIST_SHIFT_COLLAR), .BIST_EXPECT_DATA({
      BIST_EXPECT_DATA_ts7, BIST_EXPECT_DATA_ts6, BIST_EXPECT_DATA_ts5, 
      BIST_EXPECT_DATA_ts4, BIST_EXPECT_DATA_ts3, BIST_EXPECT_DATA_ts2, 
      BIST_EXPECT_DATA_ts1, BIST_EXPECT_DATA}), .BIST_SI(MEM4_BIST_COLLAR_SI), .BIST_COLLAR_SETUP(BIST_COLLAR_SETUP), 
      .BIST_COLLAR_OPSET_SELECT(BIST_COLLAR_OPSET_SELECT), .BIST_COLLAR_HOLD(BIST_COLLAR_HOLD), 
      .BIST_BIRA_EN(BIST_COLLAR_BIRA_EN), .CHECK_REPAIR_NEEDED(CHECK_REPAIR_NEEDED), 
      .BIST_DIAG_EN(BIST_COLLAR_DIAG_EN), .BIST_CLEAR_DEFAULT(BIST_CLEAR_DEFAULT), 
      .BIST_CLEAR(BIST_CLEAR), .BIST_SETUP2(BIST_SETUP_ts2), .BIST_SETUP1(BIST_SETUP_ts1), 
      .BIST_SETUP0(BIST_SETUP), .LV_TM(ltest_to_en), .FREEZE_STOP_ERROR(FREEZE_STOP_ERROR), 
      .GO_ID_REG_SEL(GO_ID_REG_SEL), .BIST_COLLAR_EN(BIST_COLLAR_EN4), .FROM_BISR_All_SCOL0_FUSE_REG(ram_row_13_col_0_bisr_inst_Q[6:1]), 
      .FROM_BISR_All_SCOL0_ALLOC_REG(ram_row_13_col_0_bisr_inst_Q[0]), .BIST_SHIFT_BIRA_COLLAR(BIST_SHIFT_BIRA_COLLAR), 
      .RESET_REG_SETUP2(MBISTPG_RESET_REG_SETUP2), .ERROR_CNT_ZERO(ERROR_CNT_ZERO), 
      .WREN_P0(WREN_P0_ts4), .WREN_P1(WREN_P1_ts4), .RDEN_P0(RDEN_P0_ts4), .RDEN_P1(RDEN_P1_ts4), 
      .ADRRD_P0(ADRRD_P0_ts4), .ADRRD_P1(ADRRD_P1_ts4), .ADRWR_P0(ADRWR_P0_ts4), 
      .ADRWR_P1(ADRWR_P1_ts4), .DIN_P0(DIN_P0_ts4), .DIN_P1(DIN_P1_ts4), .BIST_SO(BIST_SO_ts4), 
      .BIST_GO(BIST_GO_ts4), .All_SCOL0_FUSE_REG(All_SCOL0_FUSE_REG_ts4[5:0]), 
      .All_SCOL0_ALLOC_REG(All_SCOL0_ALLOC_REG_ts4), .REPAIR_STATUS(), .fscan_clkungate(fscan_clkungate)
  );

  hlp_sched_apr_rtl_tessent_mbist_RF_c3_interface_MEM6 ram_row_14_col_0_interface_inst(
      .BIST_SHADOW_READENABLE(BIST_SHADOW_READENABLE), .BIST_SHADOW_READADDRESS(BIST_SHADOW_READADDRESS), 
      .BIST_CONREAD_ROWADDRESS(BIST_CONREAD_ROWADDRESS), .BIST_CONREAD_ENABLE(BIST_CONREAD_ENABLE), 
      .BIST_CONWRITE_ROWADDRESS(BIST_CONWRITE_ROWADDRESS), .BIST_CONWRITE_ENABLE(BIST_CONWRITE_ENABLE), 
      .BIST_CLEAR_BIRA(BIST_CLEAR_BIRA), .WREN_P0_IN(ram_row_14_col_0_wr_en_a), 
      .WREN_P1_IN(ram_row_14_col_0_wr_en_b), .RDEN_P0_IN(ram_row_14_col_0_rd_en_a), 
      .RDEN_P1_IN(ram_row_14_col_0_rd_en_b), .ADRRD_P0_IN(ram_row_14_col_0_rd_adr_a[7:0]), 
      .ADRRD_P1_IN(ram_row_14_col_0_rd_adr_b[7:0]), .ADRWR_P0_IN(ram_row_14_col_0_wr_adr_a[7:0]), 
      .ADRWR_P1_IN(ram_row_14_col_0_wr_adr_b[7:0]), .QOUT_P0(ram_row_14_col_0_data_out_a), 
      .QOUT_P1(ram_row_14_col_0_data_out_b), .DIN_P0_IN(ram_row_14_col_0_data_in_a[33:0]), 
      .DIN_P1_IN(ram_row_14_col_0_data_in_b[33:0]), .TCK(to_interfaces_tck), .BIST_CMP(BIST_CMP), 
      .INCLUDE_MEM_RESULTS_REG(INCLUDE_MEM_RESULTS_REG), .BIST_READENABLE(BIST_READENABLE), 
      .BIST_WRITEENABLE(BIST_WRITEENABLE), .BIST_ROW_ADD({BIST_ROW_ADD_ts3, 
      BIST_ROW_ADD_ts2, BIST_ROW_ADD_ts1, BIST_ROW_ADD}), .BIST_BANK_ADD({
      BIST_BANK_ADD_ts3, BIST_BANK_ADD_ts2, BIST_BANK_ADD_ts1, BIST_BANK_ADD}), .BIST_TEST_PORT(BIST_TEST_PORT), 
      .BIST_WRITE_DATA({BIST_WRITE_DATA_ts7, BIST_WRITE_DATA_ts6, 
      BIST_WRITE_DATA_ts5, BIST_WRITE_DATA_ts4, BIST_WRITE_DATA_ts3, 
      BIST_WRITE_DATA_ts2, BIST_WRITE_DATA_ts1, BIST_WRITE_DATA}), .BIST_TESTDATA_SELECT_TO_COLLAR(BIST_TESTDATA_SELECT_TO_COLLAR), 
      .MEM_BYPASS_EN(memory_bypass_to_en), .SCAN_SHIFT_EN(scan_to_en), .MCP_BOUNDING_EN(mcp_bounding_to_en), 
      .BIST_ON(BIST_ON_TO_COLLAR), .BIST_RUN(BIST_RUN_TO_COLLAR5), .BIST_ASYNC_RESETN(BIST_ASYNC_RESET), 
      .BIST_CLK(clk_a), .BIST_SHIFT_COLLAR(BIST_SHIFT_COLLAR), .BIST_EXPECT_DATA({
      BIST_EXPECT_DATA_ts7, BIST_EXPECT_DATA_ts6, BIST_EXPECT_DATA_ts5, 
      BIST_EXPECT_DATA_ts4, BIST_EXPECT_DATA_ts3, BIST_EXPECT_DATA_ts2, 
      BIST_EXPECT_DATA_ts1, BIST_EXPECT_DATA}), .BIST_SI(MEM5_BIST_COLLAR_SI), .BIST_COLLAR_SETUP(BIST_COLLAR_SETUP), 
      .BIST_COLLAR_OPSET_SELECT(BIST_COLLAR_OPSET_SELECT), .BIST_COLLAR_HOLD(BIST_COLLAR_HOLD), 
      .BIST_BIRA_EN(BIST_COLLAR_BIRA_EN), .CHECK_REPAIR_NEEDED(CHECK_REPAIR_NEEDED), 
      .BIST_DIAG_EN(BIST_COLLAR_DIAG_EN), .BIST_CLEAR_DEFAULT(BIST_CLEAR_DEFAULT), 
      .BIST_CLEAR(BIST_CLEAR), .BIST_SETUP2(BIST_SETUP_ts2), .BIST_SETUP1(BIST_SETUP_ts1), 
      .BIST_SETUP0(BIST_SETUP), .LV_TM(ltest_to_en), .FREEZE_STOP_ERROR(FREEZE_STOP_ERROR), 
      .GO_ID_REG_SEL(GO_ID_REG_SEL), .BIST_COLLAR_EN(BIST_COLLAR_EN5), .FROM_BISR_All_SCOL0_FUSE_REG(ram_row_14_col_0_bisr_inst_Q[6:1]), 
      .FROM_BISR_All_SCOL0_ALLOC_REG(ram_row_14_col_0_bisr_inst_Q[0]), .BIST_SHIFT_BIRA_COLLAR(BIST_SHIFT_BIRA_COLLAR), 
      .RESET_REG_SETUP2(MBISTPG_RESET_REG_SETUP2), .ERROR_CNT_ZERO(ERROR_CNT_ZERO), 
      .WREN_P0(WREN_P0_ts5), .WREN_P1(WREN_P1_ts5), .RDEN_P0(RDEN_P0_ts5), .RDEN_P1(RDEN_P1_ts5), 
      .ADRRD_P0(ADRRD_P0_ts5), .ADRRD_P1(ADRRD_P1_ts5), .ADRWR_P0(ADRWR_P0_ts5), 
      .ADRWR_P1(ADRWR_P1_ts5), .DIN_P0(DIN_P0_ts5), .DIN_P1(DIN_P1_ts5), .BIST_SO(BIST_SO_ts5), 
      .BIST_GO(BIST_GO_ts5), .All_SCOL0_FUSE_REG(All_SCOL0_FUSE_REG_ts5[5:0]), 
      .All_SCOL0_ALLOC_REG(All_SCOL0_ALLOC_REG_ts5), .REPAIR_STATUS(), .fscan_clkungate(fscan_clkungate)
  );

  hlp_sched_apr_rtl_tessent_mbist_RF_c3_interface_MEM7 ram_row_15_col_0_interface_inst(
      .BIST_SHADOW_READENABLE(BIST_SHADOW_READENABLE), .BIST_SHADOW_READADDRESS(BIST_SHADOW_READADDRESS), 
      .BIST_CONREAD_ROWADDRESS(BIST_CONREAD_ROWADDRESS), .BIST_CONREAD_ENABLE(BIST_CONREAD_ENABLE), 
      .BIST_CONWRITE_ROWADDRESS(BIST_CONWRITE_ROWADDRESS), .BIST_CONWRITE_ENABLE(BIST_CONWRITE_ENABLE), 
      .BIST_CLEAR_BIRA(BIST_CLEAR_BIRA), .WREN_P0_IN(ram_row_15_col_0_wr_en_a), 
      .WREN_P1_IN(ram_row_15_col_0_wr_en_b), .RDEN_P0_IN(ram_row_15_col_0_rd_en_a), 
      .RDEN_P1_IN(ram_row_15_col_0_rd_en_b), .ADRRD_P0_IN(ram_row_15_col_0_rd_adr_a[7:0]), 
      .ADRRD_P1_IN(ram_row_15_col_0_rd_adr_b[7:0]), .ADRWR_P0_IN(ram_row_15_col_0_wr_adr_a[7:0]), 
      .ADRWR_P1_IN(ram_row_15_col_0_wr_adr_b[7:0]), .QOUT_P0(ram_row_15_col_0_data_out_a), 
      .QOUT_P1(ram_row_15_col_0_data_out_b), .DIN_P0_IN(ram_row_15_col_0_data_in_a[33:0]), 
      .DIN_P1_IN(ram_row_15_col_0_data_in_b[33:0]), .TCK(to_interfaces_tck), .BIST_CMP(BIST_CMP), 
      .INCLUDE_MEM_RESULTS_REG(INCLUDE_MEM_RESULTS_REG), .BIST_READENABLE(BIST_READENABLE), 
      .BIST_WRITEENABLE(BIST_WRITEENABLE), .BIST_ROW_ADD({BIST_ROW_ADD_ts3, 
      BIST_ROW_ADD_ts2, BIST_ROW_ADD_ts1, BIST_ROW_ADD}), .BIST_BANK_ADD({
      BIST_BANK_ADD_ts3, BIST_BANK_ADD_ts2, BIST_BANK_ADD_ts1, BIST_BANK_ADD}), .BIST_TEST_PORT(BIST_TEST_PORT), 
      .BIST_WRITE_DATA({BIST_WRITE_DATA_ts7, BIST_WRITE_DATA_ts6, 
      BIST_WRITE_DATA_ts5, BIST_WRITE_DATA_ts4, BIST_WRITE_DATA_ts3, 
      BIST_WRITE_DATA_ts2, BIST_WRITE_DATA_ts1, BIST_WRITE_DATA}), .BIST_TESTDATA_SELECT_TO_COLLAR(BIST_TESTDATA_SELECT_TO_COLLAR), 
      .MEM_BYPASS_EN(memory_bypass_to_en), .SCAN_SHIFT_EN(scan_to_en), .MCP_BOUNDING_EN(mcp_bounding_to_en), 
      .BIST_ON(BIST_ON_TO_COLLAR), .BIST_RUN(BIST_RUN_TO_COLLAR6), .BIST_ASYNC_RESETN(BIST_ASYNC_RESET), 
      .BIST_CLK(clk_a), .BIST_SHIFT_COLLAR(BIST_SHIFT_COLLAR), .BIST_EXPECT_DATA({
      BIST_EXPECT_DATA_ts7, BIST_EXPECT_DATA_ts6, BIST_EXPECT_DATA_ts5, 
      BIST_EXPECT_DATA_ts4, BIST_EXPECT_DATA_ts3, BIST_EXPECT_DATA_ts2, 
      BIST_EXPECT_DATA_ts1, BIST_EXPECT_DATA}), .BIST_SI(MEM6_BIST_COLLAR_SI), .BIST_COLLAR_SETUP(BIST_COLLAR_SETUP), 
      .BIST_COLLAR_OPSET_SELECT(BIST_COLLAR_OPSET_SELECT), .BIST_COLLAR_HOLD(BIST_COLLAR_HOLD), 
      .BIST_BIRA_EN(BIST_COLLAR_BIRA_EN), .CHECK_REPAIR_NEEDED(CHECK_REPAIR_NEEDED), 
      .BIST_DIAG_EN(BIST_COLLAR_DIAG_EN), .BIST_CLEAR_DEFAULT(BIST_CLEAR_DEFAULT), 
      .BIST_CLEAR(BIST_CLEAR), .BIST_SETUP2(BIST_SETUP_ts2), .BIST_SETUP1(BIST_SETUP_ts1), 
      .BIST_SETUP0(BIST_SETUP), .LV_TM(ltest_to_en), .FREEZE_STOP_ERROR(FREEZE_STOP_ERROR), 
      .GO_ID_REG_SEL(GO_ID_REG_SEL), .BIST_COLLAR_EN(BIST_COLLAR_EN6), .FROM_BISR_All_SCOL0_FUSE_REG(ram_row_15_col_0_bisr_inst_Q[6:1]), 
      .FROM_BISR_All_SCOL0_ALLOC_REG(ram_row_15_col_0_bisr_inst_Q[0]), .BIST_SHIFT_BIRA_COLLAR(BIST_SHIFT_BIRA_COLLAR), 
      .RESET_REG_SETUP2(MBISTPG_RESET_REG_SETUP2), .ERROR_CNT_ZERO(ERROR_CNT_ZERO), 
      .WREN_P0(WREN_P0_ts6), .WREN_P1(WREN_P1_ts6), .RDEN_P0(RDEN_P0_ts6), .RDEN_P1(RDEN_P1_ts6), 
      .ADRRD_P0(ADRRD_P0_ts6), .ADRRD_P1(ADRRD_P1_ts6), .ADRWR_P0(ADRWR_P0_ts6), 
      .ADRWR_P1(ADRWR_P1_ts6), .DIN_P0(DIN_P0_ts6), .DIN_P1(DIN_P1_ts6), .BIST_SO(BIST_SO_ts6), 
      .BIST_GO(BIST_GO_ts6), .All_SCOL0_FUSE_REG(All_SCOL0_FUSE_REG_ts6[5:0]), 
      .All_SCOL0_ALLOC_REG(All_SCOL0_ALLOC_REG_ts6), .REPAIR_STATUS(), .fscan_clkungate(fscan_clkungate)
  );

  hlp_sched_apr_rtl_tessent_mbist_RF_c3_interface_MEM8 ram_row_16_col_0_interface_inst(
      .BIST_SHADOW_READENABLE(BIST_SHADOW_READENABLE), .BIST_SHADOW_READADDRESS(BIST_SHADOW_READADDRESS), 
      .BIST_CONREAD_ROWADDRESS(BIST_CONREAD_ROWADDRESS), .BIST_CONREAD_ENABLE(BIST_CONREAD_ENABLE), 
      .BIST_CONWRITE_ROWADDRESS(BIST_CONWRITE_ROWADDRESS), .BIST_CONWRITE_ENABLE(BIST_CONWRITE_ENABLE), 
      .BIST_CLEAR_BIRA(BIST_CLEAR_BIRA), .WREN_P0_IN(ram_row_16_col_0_wr_en_a), 
      .WREN_P1_IN(ram_row_16_col_0_wr_en_b), .RDEN_P0_IN(ram_row_16_col_0_rd_en_a), 
      .RDEN_P1_IN(ram_row_16_col_0_rd_en_b), .ADRRD_P0_IN(ram_row_16_col_0_rd_adr_a[7:0]), 
      .ADRRD_P1_IN(ram_row_16_col_0_rd_adr_b[7:0]), .ADRWR_P0_IN(ram_row_16_col_0_wr_adr_a[7:0]), 
      .ADRWR_P1_IN(ram_row_16_col_0_wr_adr_b[7:0]), .QOUT_P0(ram_row_16_col_0_data_out_a), 
      .QOUT_P1(ram_row_16_col_0_data_out_b), .DIN_P0_IN(ram_row_16_col_0_data_in_a[33:0]), 
      .DIN_P1_IN(ram_row_16_col_0_data_in_b[33:0]), .TCK(to_interfaces_tck), .BIST_CMP(BIST_CMP), 
      .INCLUDE_MEM_RESULTS_REG(INCLUDE_MEM_RESULTS_REG), .BIST_READENABLE(BIST_READENABLE), 
      .BIST_WRITEENABLE(BIST_WRITEENABLE), .BIST_ROW_ADD({BIST_ROW_ADD_ts3, 
      BIST_ROW_ADD_ts2, BIST_ROW_ADD_ts1, BIST_ROW_ADD}), .BIST_BANK_ADD({
      BIST_BANK_ADD_ts3, BIST_BANK_ADD_ts2, BIST_BANK_ADD_ts1, BIST_BANK_ADD}), .BIST_TEST_PORT(BIST_TEST_PORT), 
      .BIST_WRITE_DATA({BIST_WRITE_DATA_ts7, BIST_WRITE_DATA_ts6, 
      BIST_WRITE_DATA_ts5, BIST_WRITE_DATA_ts4, BIST_WRITE_DATA_ts3, 
      BIST_WRITE_DATA_ts2, BIST_WRITE_DATA_ts1, BIST_WRITE_DATA}), .BIST_TESTDATA_SELECT_TO_COLLAR(BIST_TESTDATA_SELECT_TO_COLLAR), 
      .MEM_BYPASS_EN(memory_bypass_to_en), .SCAN_SHIFT_EN(scan_to_en), .MCP_BOUNDING_EN(mcp_bounding_to_en), 
      .BIST_ON(BIST_ON_TO_COLLAR), .BIST_RUN(BIST_RUN_TO_COLLAR7), .BIST_ASYNC_RESETN(BIST_ASYNC_RESET), 
      .BIST_CLK(clk_a), .BIST_SHIFT_COLLAR(BIST_SHIFT_COLLAR), .BIST_EXPECT_DATA({
      BIST_EXPECT_DATA_ts7, BIST_EXPECT_DATA_ts6, BIST_EXPECT_DATA_ts5, 
      BIST_EXPECT_DATA_ts4, BIST_EXPECT_DATA_ts3, BIST_EXPECT_DATA_ts2, 
      BIST_EXPECT_DATA_ts1, BIST_EXPECT_DATA}), .BIST_SI(MEM7_BIST_COLLAR_SI), .BIST_COLLAR_SETUP(BIST_COLLAR_SETUP), 
      .BIST_COLLAR_OPSET_SELECT(BIST_COLLAR_OPSET_SELECT), .BIST_COLLAR_HOLD(BIST_COLLAR_HOLD), 
      .BIST_BIRA_EN(BIST_COLLAR_BIRA_EN), .CHECK_REPAIR_NEEDED(CHECK_REPAIR_NEEDED), 
      .BIST_DIAG_EN(BIST_COLLAR_DIAG_EN), .BIST_CLEAR_DEFAULT(BIST_CLEAR_DEFAULT), 
      .BIST_CLEAR(BIST_CLEAR), .BIST_SETUP2(BIST_SETUP_ts2), .BIST_SETUP1(BIST_SETUP_ts1), 
      .BIST_SETUP0(BIST_SETUP), .LV_TM(ltest_to_en), .FREEZE_STOP_ERROR(FREEZE_STOP_ERROR), 
      .GO_ID_REG_SEL(GO_ID_REG_SEL), .BIST_COLLAR_EN(BIST_COLLAR_EN7), .FROM_BISR_All_SCOL0_FUSE_REG(ram_row_16_col_0_bisr_inst_Q[6:1]), 
      .FROM_BISR_All_SCOL0_ALLOC_REG(ram_row_16_col_0_bisr_inst_Q[0]), .BIST_SHIFT_BIRA_COLLAR(BIST_SHIFT_BIRA_COLLAR), 
      .RESET_REG_SETUP2(MBISTPG_RESET_REG_SETUP2), .ERROR_CNT_ZERO(ERROR_CNT_ZERO), 
      .WREN_P0(WREN_P0_ts7), .WREN_P1(WREN_P1_ts7), .RDEN_P0(RDEN_P0_ts7), .RDEN_P1(RDEN_P1_ts7), 
      .ADRRD_P0(ADRRD_P0_ts7), .ADRRD_P1(ADRRD_P1_ts7), .ADRWR_P0(ADRWR_P0_ts7), 
      .ADRWR_P1(ADRWR_P1_ts7), .DIN_P0(DIN_P0_ts7), .DIN_P1(DIN_P1_ts7), .BIST_SO(BIST_SO_ts7), 
      .BIST_GO(BIST_GO_ts7), .All_SCOL0_FUSE_REG(All_SCOL0_FUSE_REG_ts7[5:0]), 
      .All_SCOL0_ALLOC_REG(All_SCOL0_ALLOC_REG_ts7), .REPAIR_STATUS(), .fscan_clkungate(fscan_clkungate)
  );

  hlp_sched_apr_rtl_tessent_mbist_RF_c3_interface_MEM9 ram_row_17_col_0_interface_inst(
      .BIST_SHADOW_READENABLE(BIST_SHADOW_READENABLE), .BIST_SHADOW_READADDRESS(BIST_SHADOW_READADDRESS), 
      .BIST_CONREAD_ROWADDRESS(BIST_CONREAD_ROWADDRESS), .BIST_CONREAD_ENABLE(BIST_CONREAD_ENABLE), 
      .BIST_CONWRITE_ROWADDRESS(BIST_CONWRITE_ROWADDRESS), .BIST_CONWRITE_ENABLE(BIST_CONWRITE_ENABLE), 
      .BIST_CLEAR_BIRA(BIST_CLEAR_BIRA), .WREN_P0_IN(ram_row_17_col_0_wr_en_a), 
      .WREN_P1_IN(ram_row_17_col_0_wr_en_b), .RDEN_P0_IN(ram_row_17_col_0_rd_en_a), 
      .RDEN_P1_IN(ram_row_17_col_0_rd_en_b), .ADRRD_P0_IN(ram_row_17_col_0_rd_adr_a[7:0]), 
      .ADRRD_P1_IN(ram_row_17_col_0_rd_adr_b[7:0]), .ADRWR_P0_IN(ram_row_17_col_0_wr_adr_a[7:0]), 
      .ADRWR_P1_IN(ram_row_17_col_0_wr_adr_b[7:0]), .QOUT_P0(ram_row_17_col_0_data_out_a), 
      .QOUT_P1(ram_row_17_col_0_data_out_b), .DIN_P0_IN(ram_row_17_col_0_data_in_a[33:0]), 
      .DIN_P1_IN(ram_row_17_col_0_data_in_b[33:0]), .TCK(to_interfaces_tck), .BIST_CMP(BIST_CMP), 
      .INCLUDE_MEM_RESULTS_REG(INCLUDE_MEM_RESULTS_REG), .BIST_READENABLE(BIST_READENABLE), 
      .BIST_WRITEENABLE(BIST_WRITEENABLE), .BIST_ROW_ADD({BIST_ROW_ADD_ts3, 
      BIST_ROW_ADD_ts2, BIST_ROW_ADD_ts1, BIST_ROW_ADD}), .BIST_BANK_ADD({
      BIST_BANK_ADD_ts3, BIST_BANK_ADD_ts2, BIST_BANK_ADD_ts1, BIST_BANK_ADD}), .BIST_TEST_PORT(BIST_TEST_PORT), 
      .BIST_WRITE_DATA({BIST_WRITE_DATA_ts7, BIST_WRITE_DATA_ts6, 
      BIST_WRITE_DATA_ts5, BIST_WRITE_DATA_ts4, BIST_WRITE_DATA_ts3, 
      BIST_WRITE_DATA_ts2, BIST_WRITE_DATA_ts1, BIST_WRITE_DATA}), .BIST_TESTDATA_SELECT_TO_COLLAR(BIST_TESTDATA_SELECT_TO_COLLAR), 
      .MEM_BYPASS_EN(memory_bypass_to_en), .SCAN_SHIFT_EN(scan_to_en), .MCP_BOUNDING_EN(mcp_bounding_to_en), 
      .BIST_ON(BIST_ON_TO_COLLAR), .BIST_RUN(BIST_RUN_TO_COLLAR8), .BIST_ASYNC_RESETN(BIST_ASYNC_RESET), 
      .BIST_CLK(clk_a), .BIST_SHIFT_COLLAR(BIST_SHIFT_COLLAR), .BIST_EXPECT_DATA({
      BIST_EXPECT_DATA_ts7, BIST_EXPECT_DATA_ts6, BIST_EXPECT_DATA_ts5, 
      BIST_EXPECT_DATA_ts4, BIST_EXPECT_DATA_ts3, BIST_EXPECT_DATA_ts2, 
      BIST_EXPECT_DATA_ts1, BIST_EXPECT_DATA}), .BIST_SI(MEM8_BIST_COLLAR_SI), .BIST_COLLAR_SETUP(BIST_COLLAR_SETUP), 
      .BIST_COLLAR_OPSET_SELECT(BIST_COLLAR_OPSET_SELECT), .BIST_COLLAR_HOLD(BIST_COLLAR_HOLD), 
      .BIST_BIRA_EN(BIST_COLLAR_BIRA_EN), .CHECK_REPAIR_NEEDED(CHECK_REPAIR_NEEDED), 
      .BIST_DIAG_EN(BIST_COLLAR_DIAG_EN), .BIST_CLEAR_DEFAULT(BIST_CLEAR_DEFAULT), 
      .BIST_CLEAR(BIST_CLEAR), .BIST_SETUP2(BIST_SETUP_ts2), .BIST_SETUP1(BIST_SETUP_ts1), 
      .BIST_SETUP0(BIST_SETUP), .LV_TM(ltest_to_en), .FREEZE_STOP_ERROR(FREEZE_STOP_ERROR), 
      .GO_ID_REG_SEL(GO_ID_REG_SEL), .BIST_COLLAR_EN(BIST_COLLAR_EN8), .FROM_BISR_All_SCOL0_FUSE_REG(ram_row_17_col_0_bisr_inst_Q[6:1]), 
      .FROM_BISR_All_SCOL0_ALLOC_REG(ram_row_17_col_0_bisr_inst_Q[0]), .BIST_SHIFT_BIRA_COLLAR(BIST_SHIFT_BIRA_COLLAR), 
      .RESET_REG_SETUP2(MBISTPG_RESET_REG_SETUP2), .ERROR_CNT_ZERO(ERROR_CNT_ZERO), 
      .WREN_P0(WREN_P0_ts8), .WREN_P1(WREN_P1_ts8), .RDEN_P0(RDEN_P0_ts8), .RDEN_P1(RDEN_P1_ts8), 
      .ADRRD_P0(ADRRD_P0_ts8), .ADRRD_P1(ADRRD_P1_ts8), .ADRWR_P0(ADRWR_P0_ts8), 
      .ADRWR_P1(ADRWR_P1_ts8), .DIN_P0(DIN_P0_ts8), .DIN_P1(DIN_P1_ts8), .BIST_SO(BIST_SO_ts8), 
      .BIST_GO(BIST_GO_ts8), .All_SCOL0_FUSE_REG(All_SCOL0_FUSE_REG_ts8[5:0]), 
      .All_SCOL0_ALLOC_REG(All_SCOL0_ALLOC_REG_ts8), .REPAIR_STATUS(), .fscan_clkungate(fscan_clkungate)
  );

  hlp_sched_apr_rtl_tessent_mbist_RF_c3_interface_MEM10 ram_row_18_col_0_interface_inst(
      .BIST_SHADOW_READENABLE(BIST_SHADOW_READENABLE), .BIST_SHADOW_READADDRESS(BIST_SHADOW_READADDRESS), 
      .BIST_CONREAD_ROWADDRESS(BIST_CONREAD_ROWADDRESS), .BIST_CONREAD_ENABLE(BIST_CONREAD_ENABLE), 
      .BIST_CONWRITE_ROWADDRESS(BIST_CONWRITE_ROWADDRESS), .BIST_CONWRITE_ENABLE(BIST_CONWRITE_ENABLE), 
      .BIST_CLEAR_BIRA(BIST_CLEAR_BIRA), .WREN_P0_IN(ram_row_18_col_0_wr_en_a), 
      .WREN_P1_IN(ram_row_18_col_0_wr_en_b), .RDEN_P0_IN(ram_row_18_col_0_rd_en_a), 
      .RDEN_P1_IN(ram_row_18_col_0_rd_en_b), .ADRRD_P0_IN(ram_row_18_col_0_rd_adr_a[7:0]), 
      .ADRRD_P1_IN(ram_row_18_col_0_rd_adr_b[7:0]), .ADRWR_P0_IN(ram_row_18_col_0_wr_adr_a[7:0]), 
      .ADRWR_P1_IN(ram_row_18_col_0_wr_adr_b[7:0]), .QOUT_P0(ram_row_18_col_0_data_out_a), 
      .QOUT_P1(ram_row_18_col_0_data_out_b), .DIN_P0_IN(ram_row_18_col_0_data_in_a[33:0]), 
      .DIN_P1_IN(ram_row_18_col_0_data_in_b[33:0]), .TCK(to_interfaces_tck), .BIST_CMP(BIST_CMP), 
      .INCLUDE_MEM_RESULTS_REG(INCLUDE_MEM_RESULTS_REG), .BIST_READENABLE(BIST_READENABLE), 
      .BIST_WRITEENABLE(BIST_WRITEENABLE), .BIST_ROW_ADD({BIST_ROW_ADD_ts3, 
      BIST_ROW_ADD_ts2, BIST_ROW_ADD_ts1, BIST_ROW_ADD}), .BIST_BANK_ADD({
      BIST_BANK_ADD_ts3, BIST_BANK_ADD_ts2, BIST_BANK_ADD_ts1, BIST_BANK_ADD}), .BIST_TEST_PORT(BIST_TEST_PORT), 
      .BIST_WRITE_DATA({BIST_WRITE_DATA_ts7, BIST_WRITE_DATA_ts6, 
      BIST_WRITE_DATA_ts5, BIST_WRITE_DATA_ts4, BIST_WRITE_DATA_ts3, 
      BIST_WRITE_DATA_ts2, BIST_WRITE_DATA_ts1, BIST_WRITE_DATA}), .BIST_TESTDATA_SELECT_TO_COLLAR(BIST_TESTDATA_SELECT_TO_COLLAR), 
      .MEM_BYPASS_EN(memory_bypass_to_en), .SCAN_SHIFT_EN(scan_to_en), .MCP_BOUNDING_EN(mcp_bounding_to_en), 
      .BIST_ON(BIST_ON_TO_COLLAR), .BIST_RUN(BIST_RUN_TO_COLLAR9), .BIST_ASYNC_RESETN(BIST_ASYNC_RESET), 
      .BIST_CLK(clk_a), .BIST_SHIFT_COLLAR(BIST_SHIFT_COLLAR), .BIST_EXPECT_DATA({
      BIST_EXPECT_DATA_ts7, BIST_EXPECT_DATA_ts6, BIST_EXPECT_DATA_ts5, 
      BIST_EXPECT_DATA_ts4, BIST_EXPECT_DATA_ts3, BIST_EXPECT_DATA_ts2, 
      BIST_EXPECT_DATA_ts1, BIST_EXPECT_DATA}), .BIST_SI(MEM9_BIST_COLLAR_SI), .BIST_COLLAR_SETUP(BIST_COLLAR_SETUP), 
      .BIST_COLLAR_OPSET_SELECT(BIST_COLLAR_OPSET_SELECT), .BIST_COLLAR_HOLD(BIST_COLLAR_HOLD), 
      .BIST_BIRA_EN(BIST_COLLAR_BIRA_EN), .CHECK_REPAIR_NEEDED(CHECK_REPAIR_NEEDED), 
      .BIST_DIAG_EN(BIST_COLLAR_DIAG_EN), .BIST_CLEAR_DEFAULT(BIST_CLEAR_DEFAULT), 
      .BIST_CLEAR(BIST_CLEAR), .BIST_SETUP2(BIST_SETUP_ts2), .BIST_SETUP1(BIST_SETUP_ts1), 
      .BIST_SETUP0(BIST_SETUP), .LV_TM(ltest_to_en), .FREEZE_STOP_ERROR(FREEZE_STOP_ERROR), 
      .GO_ID_REG_SEL(GO_ID_REG_SEL), .BIST_COLLAR_EN(BIST_COLLAR_EN9), .FROM_BISR_All_SCOL0_FUSE_REG(ram_row_18_col_0_bisr_inst_Q[6:1]), 
      .FROM_BISR_All_SCOL0_ALLOC_REG(ram_row_18_col_0_bisr_inst_Q[0]), .BIST_SHIFT_BIRA_COLLAR(BIST_SHIFT_BIRA_COLLAR), 
      .RESET_REG_SETUP2(MBISTPG_RESET_REG_SETUP2), .ERROR_CNT_ZERO(ERROR_CNT_ZERO), 
      .WREN_P0(WREN_P0_ts9), .WREN_P1(WREN_P1_ts9), .RDEN_P0(RDEN_P0_ts9), .RDEN_P1(RDEN_P1_ts9), 
      .ADRRD_P0(ADRRD_P0_ts9), .ADRRD_P1(ADRRD_P1_ts9), .ADRWR_P0(ADRWR_P0_ts9), 
      .ADRWR_P1(ADRWR_P1_ts9), .DIN_P0(DIN_P0_ts9), .DIN_P1(DIN_P1_ts9), .BIST_SO(BIST_SO_ts9), 
      .BIST_GO(BIST_GO_ts9), .All_SCOL0_FUSE_REG(All_SCOL0_FUSE_REG_ts9[5:0]), 
      .All_SCOL0_ALLOC_REG(All_SCOL0_ALLOC_REG_ts9), .REPAIR_STATUS(), .fscan_clkungate(fscan_clkungate)
  );

  hlp_sched_apr_rtl_tessent_mbist_RF_c3_interface_MEM11 ram_row_19_col_0_interface_inst(
      .BIST_SHADOW_READENABLE(BIST_SHADOW_READENABLE), .BIST_SHADOW_READADDRESS(BIST_SHADOW_READADDRESS), 
      .BIST_CONREAD_ROWADDRESS(BIST_CONREAD_ROWADDRESS), .BIST_CONREAD_ENABLE(BIST_CONREAD_ENABLE), 
      .BIST_CONWRITE_ROWADDRESS(BIST_CONWRITE_ROWADDRESS), .BIST_CONWRITE_ENABLE(BIST_CONWRITE_ENABLE), 
      .BIST_CLEAR_BIRA(BIST_CLEAR_BIRA), .WREN_P0_IN(ram_row_19_col_0_wr_en_a), 
      .WREN_P1_IN(ram_row_19_col_0_wr_en_b), .RDEN_P0_IN(ram_row_19_col_0_rd_en_a), 
      .RDEN_P1_IN(ram_row_19_col_0_rd_en_b), .ADRRD_P0_IN(ram_row_19_col_0_rd_adr_a[7:0]), 
      .ADRRD_P1_IN(ram_row_19_col_0_rd_adr_b[7:0]), .ADRWR_P0_IN(ram_row_19_col_0_wr_adr_a[7:0]), 
      .ADRWR_P1_IN(ram_row_19_col_0_wr_adr_b[7:0]), .QOUT_P0(ram_row_19_col_0_data_out_a), 
      .QOUT_P1(ram_row_19_col_0_data_out_b), .DIN_P0_IN(ram_row_19_col_0_data_in_a[33:0]), 
      .DIN_P1_IN(ram_row_19_col_0_data_in_b[33:0]), .TCK(to_interfaces_tck), .BIST_CMP(BIST_CMP), 
      .INCLUDE_MEM_RESULTS_REG(INCLUDE_MEM_RESULTS_REG), .BIST_READENABLE(BIST_READENABLE), 
      .BIST_WRITEENABLE(BIST_WRITEENABLE), .BIST_ROW_ADD({BIST_ROW_ADD_ts3, 
      BIST_ROW_ADD_ts2, BIST_ROW_ADD_ts1, BIST_ROW_ADD}), .BIST_BANK_ADD({
      BIST_BANK_ADD_ts3, BIST_BANK_ADD_ts2, BIST_BANK_ADD_ts1, BIST_BANK_ADD}), .BIST_TEST_PORT(BIST_TEST_PORT), 
      .BIST_WRITE_DATA({BIST_WRITE_DATA_ts7, BIST_WRITE_DATA_ts6, 
      BIST_WRITE_DATA_ts5, BIST_WRITE_DATA_ts4, BIST_WRITE_DATA_ts3, 
      BIST_WRITE_DATA_ts2, BIST_WRITE_DATA_ts1, BIST_WRITE_DATA}), .BIST_TESTDATA_SELECT_TO_COLLAR(BIST_TESTDATA_SELECT_TO_COLLAR), 
      .MEM_BYPASS_EN(memory_bypass_to_en), .SCAN_SHIFT_EN(scan_to_en), .MCP_BOUNDING_EN(mcp_bounding_to_en), 
      .BIST_ON(BIST_ON_TO_COLLAR), .BIST_RUN(BIST_RUN_TO_COLLAR10), .BIST_ASYNC_RESETN(BIST_ASYNC_RESET), 
      .BIST_CLK(clk_a), .BIST_SHIFT_COLLAR(BIST_SHIFT_COLLAR), .BIST_EXPECT_DATA({
      BIST_EXPECT_DATA_ts7, BIST_EXPECT_DATA_ts6, BIST_EXPECT_DATA_ts5, 
      BIST_EXPECT_DATA_ts4, BIST_EXPECT_DATA_ts3, BIST_EXPECT_DATA_ts2, 
      BIST_EXPECT_DATA_ts1, BIST_EXPECT_DATA}), .BIST_SI(MEM10_BIST_COLLAR_SI), .BIST_COLLAR_SETUP(BIST_COLLAR_SETUP), 
      .BIST_COLLAR_OPSET_SELECT(BIST_COLLAR_OPSET_SELECT), .BIST_COLLAR_HOLD(BIST_COLLAR_HOLD), 
      .BIST_BIRA_EN(BIST_COLLAR_BIRA_EN), .CHECK_REPAIR_NEEDED(CHECK_REPAIR_NEEDED), 
      .BIST_DIAG_EN(BIST_COLLAR_DIAG_EN), .BIST_CLEAR_DEFAULT(BIST_CLEAR_DEFAULT), 
      .BIST_CLEAR(BIST_CLEAR), .BIST_SETUP2(BIST_SETUP_ts2), .BIST_SETUP1(BIST_SETUP_ts1), 
      .BIST_SETUP0(BIST_SETUP), .LV_TM(ltest_to_en), .FREEZE_STOP_ERROR(FREEZE_STOP_ERROR), 
      .GO_ID_REG_SEL(GO_ID_REG_SEL), .BIST_COLLAR_EN(BIST_COLLAR_EN10), .FROM_BISR_All_SCOL0_FUSE_REG(ram_row_19_col_0_bisr_inst_Q[6:1]), 
      .FROM_BISR_All_SCOL0_ALLOC_REG(ram_row_19_col_0_bisr_inst_Q[0]), .BIST_SHIFT_BIRA_COLLAR(BIST_SHIFT_BIRA_COLLAR), 
      .RESET_REG_SETUP2(MBISTPG_RESET_REG_SETUP2), .ERROR_CNT_ZERO(ERROR_CNT_ZERO), 
      .WREN_P0(WREN_P0_ts10), .WREN_P1(WREN_P1_ts10), .RDEN_P0(RDEN_P0_ts10), .RDEN_P1(RDEN_P1_ts10), 
      .ADRRD_P0(ADRRD_P0_ts10), .ADRRD_P1(ADRRD_P1_ts10), .ADRWR_P0(ADRWR_P0_ts10), 
      .ADRWR_P1(ADRWR_P1_ts10), .DIN_P0(DIN_P0_ts10), .DIN_P1(DIN_P1_ts10), .BIST_SO(BIST_SO_ts10), 
      .BIST_GO(BIST_GO_ts10), .All_SCOL0_FUSE_REG(All_SCOL0_FUSE_REG_ts10[5:0]), 
      .All_SCOL0_ALLOC_REG(All_SCOL0_ALLOC_REG_ts10), .REPAIR_STATUS(), .fscan_clkungate(fscan_clkungate)
  );

  hlp_sched_apr_rtl_tessent_mbist_RF_c3_interface_MEM12 ram_row_1_col_0_interface_inst(
      .BIST_SHADOW_READENABLE(BIST_SHADOW_READENABLE), .BIST_SHADOW_READADDRESS(BIST_SHADOW_READADDRESS), 
      .BIST_CONREAD_ROWADDRESS(BIST_CONREAD_ROWADDRESS), .BIST_CONREAD_ENABLE(BIST_CONREAD_ENABLE), 
      .BIST_CONWRITE_ROWADDRESS(BIST_CONWRITE_ROWADDRESS), .BIST_CONWRITE_ENABLE(BIST_CONWRITE_ENABLE), 
      .BIST_CLEAR_BIRA(BIST_CLEAR_BIRA), .WREN_P0_IN(ram_row_1_col_0_wr_en_a), 
      .WREN_P1_IN(ram_row_1_col_0_wr_en_b), .RDEN_P0_IN(ram_row_1_col_0_rd_en_a), 
      .RDEN_P1_IN(ram_row_1_col_0_rd_en_b), .ADRRD_P0_IN(ram_row_1_col_0_rd_adr_a[7:0]), 
      .ADRRD_P1_IN(ram_row_1_col_0_rd_adr_b[7:0]), .ADRWR_P0_IN(ram_row_1_col_0_wr_adr_a[7:0]), 
      .ADRWR_P1_IN(ram_row_1_col_0_wr_adr_b[7:0]), .QOUT_P0(ram_row_1_col_0_data_out_a), 
      .QOUT_P1(ram_row_1_col_0_data_out_b), .DIN_P0_IN(ram_row_1_col_0_data_in_a[33:0]), 
      .DIN_P1_IN(ram_row_1_col_0_data_in_b[33:0]), .TCK(to_interfaces_tck), .BIST_CMP(BIST_CMP), 
      .INCLUDE_MEM_RESULTS_REG(INCLUDE_MEM_RESULTS_REG), .BIST_READENABLE(BIST_READENABLE), 
      .BIST_WRITEENABLE(BIST_WRITEENABLE), .BIST_ROW_ADD({BIST_ROW_ADD_ts3, 
      BIST_ROW_ADD_ts2, BIST_ROW_ADD_ts1, BIST_ROW_ADD}), .BIST_BANK_ADD({
      BIST_BANK_ADD_ts3, BIST_BANK_ADD_ts2, BIST_BANK_ADD_ts1, BIST_BANK_ADD}), .BIST_TEST_PORT(BIST_TEST_PORT), 
      .BIST_WRITE_DATA({BIST_WRITE_DATA_ts7, BIST_WRITE_DATA_ts6, 
      BIST_WRITE_DATA_ts5, BIST_WRITE_DATA_ts4, BIST_WRITE_DATA_ts3, 
      BIST_WRITE_DATA_ts2, BIST_WRITE_DATA_ts1, BIST_WRITE_DATA}), .BIST_TESTDATA_SELECT_TO_COLLAR(BIST_TESTDATA_SELECT_TO_COLLAR), 
      .MEM_BYPASS_EN(memory_bypass_to_en), .SCAN_SHIFT_EN(scan_to_en), .MCP_BOUNDING_EN(mcp_bounding_to_en), 
      .BIST_ON(BIST_ON_TO_COLLAR), .BIST_RUN(BIST_RUN_TO_COLLAR11), .BIST_ASYNC_RESETN(BIST_ASYNC_RESET), 
      .BIST_CLK(clk_a), .BIST_SHIFT_COLLAR(BIST_SHIFT_COLLAR), .BIST_EXPECT_DATA({
      BIST_EXPECT_DATA_ts7, BIST_EXPECT_DATA_ts6, BIST_EXPECT_DATA_ts5, 
      BIST_EXPECT_DATA_ts4, BIST_EXPECT_DATA_ts3, BIST_EXPECT_DATA_ts2, 
      BIST_EXPECT_DATA_ts1, BIST_EXPECT_DATA}), .BIST_SI(MEM11_BIST_COLLAR_SI), .BIST_COLLAR_SETUP(BIST_COLLAR_SETUP), 
      .BIST_COLLAR_OPSET_SELECT(BIST_COLLAR_OPSET_SELECT), .BIST_COLLAR_HOLD(BIST_COLLAR_HOLD), 
      .BIST_BIRA_EN(BIST_COLLAR_BIRA_EN), .CHECK_REPAIR_NEEDED(CHECK_REPAIR_NEEDED), 
      .BIST_DIAG_EN(BIST_COLLAR_DIAG_EN), .BIST_CLEAR_DEFAULT(BIST_CLEAR_DEFAULT), 
      .BIST_CLEAR(BIST_CLEAR), .BIST_SETUP2(BIST_SETUP_ts2), .BIST_SETUP1(BIST_SETUP_ts1), 
      .BIST_SETUP0(BIST_SETUP), .LV_TM(ltest_to_en), .FREEZE_STOP_ERROR(FREEZE_STOP_ERROR), 
      .GO_ID_REG_SEL(GO_ID_REG_SEL), .BIST_COLLAR_EN(BIST_COLLAR_EN11), .FROM_BISR_All_SCOL0_FUSE_REG(ram_row_1_col_0_bisr_inst_Q[6:1]), 
      .FROM_BISR_All_SCOL0_ALLOC_REG(ram_row_1_col_0_bisr_inst_Q[0]), .BIST_SHIFT_BIRA_COLLAR(BIST_SHIFT_BIRA_COLLAR), 
      .RESET_REG_SETUP2(MBISTPG_RESET_REG_SETUP2), .ERROR_CNT_ZERO(ERROR_CNT_ZERO), 
      .WREN_P0(WREN_P0_ts11), .WREN_P1(WREN_P1_ts11), .RDEN_P0(RDEN_P0_ts11), .RDEN_P1(RDEN_P1_ts11), 
      .ADRRD_P0(ADRRD_P0_ts11), .ADRRD_P1(ADRRD_P1_ts11), .ADRWR_P0(ADRWR_P0_ts11), 
      .ADRWR_P1(ADRWR_P1_ts11), .DIN_P0(DIN_P0_ts11), .DIN_P1(DIN_P1_ts11), .BIST_SO(BIST_SO_ts11), 
      .BIST_GO(BIST_GO_ts11), .All_SCOL0_FUSE_REG(All_SCOL0_FUSE_REG_ts11[5:0]), 
      .All_SCOL0_ALLOC_REG(All_SCOL0_ALLOC_REG_ts11), .REPAIR_STATUS(), .fscan_clkungate(fscan_clkungate)
  );

  hlp_sched_apr_rtl_tessent_mbist_RF_c3_interface_MEM13 ram_row_20_col_0_interface_inst(
      .BIST_SHADOW_READENABLE(BIST_SHADOW_READENABLE), .BIST_SHADOW_READADDRESS(BIST_SHADOW_READADDRESS), 
      .BIST_CONREAD_ROWADDRESS(BIST_CONREAD_ROWADDRESS), .BIST_CONREAD_ENABLE(BIST_CONREAD_ENABLE), 
      .BIST_CONWRITE_ROWADDRESS(BIST_CONWRITE_ROWADDRESS), .BIST_CONWRITE_ENABLE(BIST_CONWRITE_ENABLE), 
      .BIST_CLEAR_BIRA(BIST_CLEAR_BIRA), .WREN_P0_IN(ram_row_20_col_0_wr_en_a), 
      .WREN_P1_IN(ram_row_20_col_0_wr_en_b), .RDEN_P0_IN(ram_row_20_col_0_rd_en_a), 
      .RDEN_P1_IN(ram_row_20_col_0_rd_en_b), .ADRRD_P0_IN(ram_row_20_col_0_rd_adr_a[7:0]), 
      .ADRRD_P1_IN(ram_row_20_col_0_rd_adr_b[7:0]), .ADRWR_P0_IN(ram_row_20_col_0_wr_adr_a[7:0]), 
      .ADRWR_P1_IN(ram_row_20_col_0_wr_adr_b[7:0]), .QOUT_P0(ram_row_20_col_0_data_out_a), 
      .QOUT_P1(ram_row_20_col_0_data_out_b), .DIN_P0_IN(ram_row_20_col_0_data_in_a[33:0]), 
      .DIN_P1_IN(ram_row_20_col_0_data_in_b[33:0]), .TCK(to_interfaces_tck), .BIST_CMP(BIST_CMP), 
      .INCLUDE_MEM_RESULTS_REG(INCLUDE_MEM_RESULTS_REG), .BIST_READENABLE(BIST_READENABLE), 
      .BIST_WRITEENABLE(BIST_WRITEENABLE), .BIST_ROW_ADD({BIST_ROW_ADD_ts3, 
      BIST_ROW_ADD_ts2, BIST_ROW_ADD_ts1, BIST_ROW_ADD}), .BIST_BANK_ADD({
      BIST_BANK_ADD_ts3, BIST_BANK_ADD_ts2, BIST_BANK_ADD_ts1, BIST_BANK_ADD}), .BIST_TEST_PORT(BIST_TEST_PORT), 
      .BIST_WRITE_DATA({BIST_WRITE_DATA_ts7, BIST_WRITE_DATA_ts6, 
      BIST_WRITE_DATA_ts5, BIST_WRITE_DATA_ts4, BIST_WRITE_DATA_ts3, 
      BIST_WRITE_DATA_ts2, BIST_WRITE_DATA_ts1, BIST_WRITE_DATA}), .BIST_TESTDATA_SELECT_TO_COLLAR(BIST_TESTDATA_SELECT_TO_COLLAR), 
      .MEM_BYPASS_EN(memory_bypass_to_en), .SCAN_SHIFT_EN(scan_to_en), .MCP_BOUNDING_EN(mcp_bounding_to_en), 
      .BIST_ON(BIST_ON_TO_COLLAR), .BIST_RUN(BIST_RUN_TO_COLLAR12), .BIST_ASYNC_RESETN(BIST_ASYNC_RESET), 
      .BIST_CLK(clk_a), .BIST_SHIFT_COLLAR(BIST_SHIFT_COLLAR), .BIST_EXPECT_DATA({
      BIST_EXPECT_DATA_ts7, BIST_EXPECT_DATA_ts6, BIST_EXPECT_DATA_ts5, 
      BIST_EXPECT_DATA_ts4, BIST_EXPECT_DATA_ts3, BIST_EXPECT_DATA_ts2, 
      BIST_EXPECT_DATA_ts1, BIST_EXPECT_DATA}), .BIST_SI(MEM12_BIST_COLLAR_SI), .BIST_COLLAR_SETUP(BIST_COLLAR_SETUP), 
      .BIST_COLLAR_OPSET_SELECT(BIST_COLLAR_OPSET_SELECT), .BIST_COLLAR_HOLD(BIST_COLLAR_HOLD), 
      .BIST_BIRA_EN(BIST_COLLAR_BIRA_EN), .CHECK_REPAIR_NEEDED(CHECK_REPAIR_NEEDED), 
      .BIST_DIAG_EN(BIST_COLLAR_DIAG_EN), .BIST_CLEAR_DEFAULT(BIST_CLEAR_DEFAULT), 
      .BIST_CLEAR(BIST_CLEAR), .BIST_SETUP2(BIST_SETUP_ts2), .BIST_SETUP1(BIST_SETUP_ts1), 
      .BIST_SETUP0(BIST_SETUP), .LV_TM(ltest_to_en), .FREEZE_STOP_ERROR(FREEZE_STOP_ERROR), 
      .GO_ID_REG_SEL(GO_ID_REG_SEL), .BIST_COLLAR_EN(BIST_COLLAR_EN12), .FROM_BISR_All_SCOL0_FUSE_REG(ram_row_20_col_0_bisr_inst_Q[6:1]), 
      .FROM_BISR_All_SCOL0_ALLOC_REG(ram_row_20_col_0_bisr_inst_Q[0]), .BIST_SHIFT_BIRA_COLLAR(BIST_SHIFT_BIRA_COLLAR), 
      .RESET_REG_SETUP2(MBISTPG_RESET_REG_SETUP2), .ERROR_CNT_ZERO(ERROR_CNT_ZERO), 
      .WREN_P0(WREN_P0_ts12), .WREN_P1(WREN_P1_ts12), .RDEN_P0(RDEN_P0_ts12), .RDEN_P1(RDEN_P1_ts12), 
      .ADRRD_P0(ADRRD_P0_ts12), .ADRRD_P1(ADRRD_P1_ts12), .ADRWR_P0(ADRWR_P0_ts12), 
      .ADRWR_P1(ADRWR_P1_ts12), .DIN_P0(DIN_P0_ts12), .DIN_P1(DIN_P1_ts12), .BIST_SO(BIST_SO_ts12), 
      .BIST_GO(BIST_GO_ts12), .All_SCOL0_FUSE_REG(All_SCOL0_FUSE_REG_ts12[5:0]), 
      .All_SCOL0_ALLOC_REG(All_SCOL0_ALLOC_REG_ts12), .REPAIR_STATUS(), .fscan_clkungate(fscan_clkungate)
  );

  hlp_sched_apr_rtl_tessent_mbist_RF_c3_interface_MEM14 ram_row_21_col_0_interface_inst(
      .BIST_SHADOW_READENABLE(BIST_SHADOW_READENABLE), .BIST_SHADOW_READADDRESS(BIST_SHADOW_READADDRESS), 
      .BIST_CONREAD_ROWADDRESS(BIST_CONREAD_ROWADDRESS), .BIST_CONREAD_ENABLE(BIST_CONREAD_ENABLE), 
      .BIST_CONWRITE_ROWADDRESS(BIST_CONWRITE_ROWADDRESS), .BIST_CONWRITE_ENABLE(BIST_CONWRITE_ENABLE), 
      .BIST_CLEAR_BIRA(BIST_CLEAR_BIRA), .WREN_P0_IN(ram_row_21_col_0_wr_en_a), 
      .WREN_P1_IN(ram_row_21_col_0_wr_en_b), .RDEN_P0_IN(ram_row_21_col_0_rd_en_a), 
      .RDEN_P1_IN(ram_row_21_col_0_rd_en_b), .ADRRD_P0_IN(ram_row_21_col_0_rd_adr_a[7:0]), 
      .ADRRD_P1_IN(ram_row_21_col_0_rd_adr_b[7:0]), .ADRWR_P0_IN(ram_row_21_col_0_wr_adr_a[7:0]), 
      .ADRWR_P1_IN(ram_row_21_col_0_wr_adr_b[7:0]), .QOUT_P0(ram_row_21_col_0_data_out_a), 
      .QOUT_P1(ram_row_21_col_0_data_out_b), .DIN_P0_IN(ram_row_21_col_0_data_in_a[33:0]), 
      .DIN_P1_IN(ram_row_21_col_0_data_in_b[33:0]), .TCK(to_interfaces_tck), .BIST_CMP(BIST_CMP), 
      .INCLUDE_MEM_RESULTS_REG(INCLUDE_MEM_RESULTS_REG), .BIST_READENABLE(BIST_READENABLE), 
      .BIST_WRITEENABLE(BIST_WRITEENABLE), .BIST_ROW_ADD({BIST_ROW_ADD_ts3, 
      BIST_ROW_ADD_ts2, BIST_ROW_ADD_ts1, BIST_ROW_ADD}), .BIST_BANK_ADD({
      BIST_BANK_ADD_ts3, BIST_BANK_ADD_ts2, BIST_BANK_ADD_ts1, BIST_BANK_ADD}), .BIST_TEST_PORT(BIST_TEST_PORT), 
      .BIST_WRITE_DATA({BIST_WRITE_DATA_ts7, BIST_WRITE_DATA_ts6, 
      BIST_WRITE_DATA_ts5, BIST_WRITE_DATA_ts4, BIST_WRITE_DATA_ts3, 
      BIST_WRITE_DATA_ts2, BIST_WRITE_DATA_ts1, BIST_WRITE_DATA}), .BIST_TESTDATA_SELECT_TO_COLLAR(BIST_TESTDATA_SELECT_TO_COLLAR), 
      .MEM_BYPASS_EN(memory_bypass_to_en), .SCAN_SHIFT_EN(scan_to_en), .MCP_BOUNDING_EN(mcp_bounding_to_en), 
      .BIST_ON(BIST_ON_TO_COLLAR), .BIST_RUN(BIST_RUN_TO_COLLAR13), .BIST_ASYNC_RESETN(BIST_ASYNC_RESET), 
      .BIST_CLK(clk_a), .BIST_SHIFT_COLLAR(BIST_SHIFT_COLLAR), .BIST_EXPECT_DATA({
      BIST_EXPECT_DATA_ts7, BIST_EXPECT_DATA_ts6, BIST_EXPECT_DATA_ts5, 
      BIST_EXPECT_DATA_ts4, BIST_EXPECT_DATA_ts3, BIST_EXPECT_DATA_ts2, 
      BIST_EXPECT_DATA_ts1, BIST_EXPECT_DATA}), .BIST_SI(MEM13_BIST_COLLAR_SI), .BIST_COLLAR_SETUP(BIST_COLLAR_SETUP), 
      .BIST_COLLAR_OPSET_SELECT(BIST_COLLAR_OPSET_SELECT), .BIST_COLLAR_HOLD(BIST_COLLAR_HOLD), 
      .BIST_BIRA_EN(BIST_COLLAR_BIRA_EN), .CHECK_REPAIR_NEEDED(CHECK_REPAIR_NEEDED), 
      .BIST_DIAG_EN(BIST_COLLAR_DIAG_EN), .BIST_CLEAR_DEFAULT(BIST_CLEAR_DEFAULT), 
      .BIST_CLEAR(BIST_CLEAR), .BIST_SETUP2(BIST_SETUP_ts2), .BIST_SETUP1(BIST_SETUP_ts1), 
      .BIST_SETUP0(BIST_SETUP), .LV_TM(ltest_to_en), .FREEZE_STOP_ERROR(FREEZE_STOP_ERROR), 
      .GO_ID_REG_SEL(GO_ID_REG_SEL), .BIST_COLLAR_EN(BIST_COLLAR_EN13), .FROM_BISR_All_SCOL0_FUSE_REG(ram_row_21_col_0_bisr_inst_Q[6:1]), 
      .FROM_BISR_All_SCOL0_ALLOC_REG(ram_row_21_col_0_bisr_inst_Q[0]), .BIST_SHIFT_BIRA_COLLAR(BIST_SHIFT_BIRA_COLLAR), 
      .RESET_REG_SETUP2(MBISTPG_RESET_REG_SETUP2), .ERROR_CNT_ZERO(ERROR_CNT_ZERO), 
      .WREN_P0(WREN_P0_ts13), .WREN_P1(WREN_P1_ts13), .RDEN_P0(RDEN_P0_ts13), .RDEN_P1(RDEN_P1_ts13), 
      .ADRRD_P0(ADRRD_P0_ts13), .ADRRD_P1(ADRRD_P1_ts13), .ADRWR_P0(ADRWR_P0_ts13), 
      .ADRWR_P1(ADRWR_P1_ts13), .DIN_P0(DIN_P0_ts13), .DIN_P1(DIN_P1_ts13), .BIST_SO(BIST_SO_ts13), 
      .BIST_GO(BIST_GO_ts13), .All_SCOL0_FUSE_REG(All_SCOL0_FUSE_REG_ts13[5:0]), 
      .All_SCOL0_ALLOC_REG(All_SCOL0_ALLOC_REG_ts13), .REPAIR_STATUS(), .fscan_clkungate(fscan_clkungate)
  );

  hlp_sched_apr_rtl_tessent_mbist_RF_c3_interface_MEM15 ram_row_22_col_0_interface_inst(
      .BIST_SHADOW_READENABLE(BIST_SHADOW_READENABLE), .BIST_SHADOW_READADDRESS(BIST_SHADOW_READADDRESS), 
      .BIST_CONREAD_ROWADDRESS(BIST_CONREAD_ROWADDRESS), .BIST_CONREAD_ENABLE(BIST_CONREAD_ENABLE), 
      .BIST_CONWRITE_ROWADDRESS(BIST_CONWRITE_ROWADDRESS), .BIST_CONWRITE_ENABLE(BIST_CONWRITE_ENABLE), 
      .BIST_CLEAR_BIRA(BIST_CLEAR_BIRA), .WREN_P0_IN(ram_row_22_col_0_wr_en_a), 
      .WREN_P1_IN(ram_row_22_col_0_wr_en_b), .RDEN_P0_IN(ram_row_22_col_0_rd_en_a), 
      .RDEN_P1_IN(ram_row_22_col_0_rd_en_b), .ADRRD_P0_IN(ram_row_22_col_0_rd_adr_a[7:0]), 
      .ADRRD_P1_IN(ram_row_22_col_0_rd_adr_b[7:0]), .ADRWR_P0_IN(ram_row_22_col_0_wr_adr_a[7:0]), 
      .ADRWR_P1_IN(ram_row_22_col_0_wr_adr_b[7:0]), .QOUT_P0(ram_row_22_col_0_data_out_a), 
      .QOUT_P1(ram_row_22_col_0_data_out_b), .DIN_P0_IN(ram_row_22_col_0_data_in_a[33:0]), 
      .DIN_P1_IN(ram_row_22_col_0_data_in_b[33:0]), .TCK(to_interfaces_tck), .BIST_CMP(BIST_CMP), 
      .INCLUDE_MEM_RESULTS_REG(INCLUDE_MEM_RESULTS_REG), .BIST_READENABLE(BIST_READENABLE), 
      .BIST_WRITEENABLE(BIST_WRITEENABLE), .BIST_ROW_ADD({BIST_ROW_ADD_ts3, 
      BIST_ROW_ADD_ts2, BIST_ROW_ADD_ts1, BIST_ROW_ADD}), .BIST_BANK_ADD({
      BIST_BANK_ADD_ts3, BIST_BANK_ADD_ts2, BIST_BANK_ADD_ts1, BIST_BANK_ADD}), .BIST_TEST_PORT(BIST_TEST_PORT), 
      .BIST_WRITE_DATA({BIST_WRITE_DATA_ts7, BIST_WRITE_DATA_ts6, 
      BIST_WRITE_DATA_ts5, BIST_WRITE_DATA_ts4, BIST_WRITE_DATA_ts3, 
      BIST_WRITE_DATA_ts2, BIST_WRITE_DATA_ts1, BIST_WRITE_DATA}), .BIST_TESTDATA_SELECT_TO_COLLAR(BIST_TESTDATA_SELECT_TO_COLLAR), 
      .MEM_BYPASS_EN(memory_bypass_to_en), .SCAN_SHIFT_EN(scan_to_en), .MCP_BOUNDING_EN(mcp_bounding_to_en), 
      .BIST_ON(BIST_ON_TO_COLLAR), .BIST_RUN(BIST_RUN_TO_COLLAR14), .BIST_ASYNC_RESETN(BIST_ASYNC_RESET), 
      .BIST_CLK(clk_a), .BIST_SHIFT_COLLAR(BIST_SHIFT_COLLAR), .BIST_EXPECT_DATA({
      BIST_EXPECT_DATA_ts7, BIST_EXPECT_DATA_ts6, BIST_EXPECT_DATA_ts5, 
      BIST_EXPECT_DATA_ts4, BIST_EXPECT_DATA_ts3, BIST_EXPECT_DATA_ts2, 
      BIST_EXPECT_DATA_ts1, BIST_EXPECT_DATA}), .BIST_SI(MEM14_BIST_COLLAR_SI), .BIST_COLLAR_SETUP(BIST_COLLAR_SETUP), 
      .BIST_COLLAR_OPSET_SELECT(BIST_COLLAR_OPSET_SELECT), .BIST_COLLAR_HOLD(BIST_COLLAR_HOLD), 
      .BIST_BIRA_EN(BIST_COLLAR_BIRA_EN), .CHECK_REPAIR_NEEDED(CHECK_REPAIR_NEEDED), 
      .BIST_DIAG_EN(BIST_COLLAR_DIAG_EN), .BIST_CLEAR_DEFAULT(BIST_CLEAR_DEFAULT), 
      .BIST_CLEAR(BIST_CLEAR), .BIST_SETUP2(BIST_SETUP_ts2), .BIST_SETUP1(BIST_SETUP_ts1), 
      .BIST_SETUP0(BIST_SETUP), .LV_TM(ltest_to_en), .FREEZE_STOP_ERROR(FREEZE_STOP_ERROR), 
      .GO_ID_REG_SEL(GO_ID_REG_SEL), .BIST_COLLAR_EN(BIST_COLLAR_EN14), .FROM_BISR_All_SCOL0_FUSE_REG(ram_row_22_col_0_bisr_inst_Q[6:1]), 
      .FROM_BISR_All_SCOL0_ALLOC_REG(ram_row_22_col_0_bisr_inst_Q[0]), .BIST_SHIFT_BIRA_COLLAR(BIST_SHIFT_BIRA_COLLAR), 
      .RESET_REG_SETUP2(MBISTPG_RESET_REG_SETUP2), .ERROR_CNT_ZERO(ERROR_CNT_ZERO), 
      .WREN_P0(WREN_P0_ts14), .WREN_P1(WREN_P1_ts14), .RDEN_P0(RDEN_P0_ts14), .RDEN_P1(RDEN_P1_ts14), 
      .ADRRD_P0(ADRRD_P0_ts14), .ADRRD_P1(ADRRD_P1_ts14), .ADRWR_P0(ADRWR_P0_ts14), 
      .ADRWR_P1(ADRWR_P1_ts14), .DIN_P0(DIN_P0_ts14), .DIN_P1(DIN_P1_ts14), .BIST_SO(BIST_SO_ts14), 
      .BIST_GO(BIST_GO_ts14), .All_SCOL0_FUSE_REG(All_SCOL0_FUSE_REG_ts14[5:0]), 
      .All_SCOL0_ALLOC_REG(All_SCOL0_ALLOC_REG_ts14), .REPAIR_STATUS(), .fscan_clkungate(fscan_clkungate)
  );

  hlp_sched_apr_rtl_tessent_mbist_RF_c3_interface_MEM16 ram_row_23_col_0_interface_inst(
      .BIST_SHADOW_READENABLE(BIST_SHADOW_READENABLE), .BIST_SHADOW_READADDRESS(BIST_SHADOW_READADDRESS), 
      .BIST_CONREAD_ROWADDRESS(BIST_CONREAD_ROWADDRESS), .BIST_CONREAD_ENABLE(BIST_CONREAD_ENABLE), 
      .BIST_CONWRITE_ROWADDRESS(BIST_CONWRITE_ROWADDRESS), .BIST_CONWRITE_ENABLE(BIST_CONWRITE_ENABLE), 
      .BIST_CLEAR_BIRA(BIST_CLEAR_BIRA), .WREN_P0_IN(ram_row_23_col_0_wr_en_a), 
      .WREN_P1_IN(ram_row_23_col_0_wr_en_b), .RDEN_P0_IN(ram_row_23_col_0_rd_en_a), 
      .RDEN_P1_IN(ram_row_23_col_0_rd_en_b), .ADRRD_P0_IN(ram_row_23_col_0_rd_adr_a[7:0]), 
      .ADRRD_P1_IN(ram_row_23_col_0_rd_adr_b[7:0]), .ADRWR_P0_IN(ram_row_23_col_0_wr_adr_a[7:0]), 
      .ADRWR_P1_IN(ram_row_23_col_0_wr_adr_b[7:0]), .QOUT_P0(ram_row_23_col_0_data_out_a), 
      .QOUT_P1(ram_row_23_col_0_data_out_b), .DIN_P0_IN(ram_row_23_col_0_data_in_a[33:0]), 
      .DIN_P1_IN(ram_row_23_col_0_data_in_b[33:0]), .TCK(to_interfaces_tck), .BIST_CMP(BIST_CMP), 
      .INCLUDE_MEM_RESULTS_REG(INCLUDE_MEM_RESULTS_REG), .BIST_READENABLE(BIST_READENABLE), 
      .BIST_WRITEENABLE(BIST_WRITEENABLE), .BIST_ROW_ADD({BIST_ROW_ADD_ts3, 
      BIST_ROW_ADD_ts2, BIST_ROW_ADD_ts1, BIST_ROW_ADD}), .BIST_BANK_ADD({
      BIST_BANK_ADD_ts3, BIST_BANK_ADD_ts2, BIST_BANK_ADD_ts1, BIST_BANK_ADD}), .BIST_TEST_PORT(BIST_TEST_PORT), 
      .BIST_WRITE_DATA({BIST_WRITE_DATA_ts7, BIST_WRITE_DATA_ts6, 
      BIST_WRITE_DATA_ts5, BIST_WRITE_DATA_ts4, BIST_WRITE_DATA_ts3, 
      BIST_WRITE_DATA_ts2, BIST_WRITE_DATA_ts1, BIST_WRITE_DATA}), .BIST_TESTDATA_SELECT_TO_COLLAR(BIST_TESTDATA_SELECT_TO_COLLAR), 
      .MEM_BYPASS_EN(memory_bypass_to_en), .SCAN_SHIFT_EN(scan_to_en), .MCP_BOUNDING_EN(mcp_bounding_to_en), 
      .BIST_ON(BIST_ON_TO_COLLAR), .BIST_RUN(BIST_RUN_TO_COLLAR15), .BIST_ASYNC_RESETN(BIST_ASYNC_RESET), 
      .BIST_CLK(clk_a), .BIST_SHIFT_COLLAR(BIST_SHIFT_COLLAR), .BIST_EXPECT_DATA({
      BIST_EXPECT_DATA_ts7, BIST_EXPECT_DATA_ts6, BIST_EXPECT_DATA_ts5, 
      BIST_EXPECT_DATA_ts4, BIST_EXPECT_DATA_ts3, BIST_EXPECT_DATA_ts2, 
      BIST_EXPECT_DATA_ts1, BIST_EXPECT_DATA}), .BIST_SI(MEM15_BIST_COLLAR_SI), .BIST_COLLAR_SETUP(BIST_COLLAR_SETUP), 
      .BIST_COLLAR_OPSET_SELECT(BIST_COLLAR_OPSET_SELECT), .BIST_COLLAR_HOLD(BIST_COLLAR_HOLD), 
      .BIST_BIRA_EN(BIST_COLLAR_BIRA_EN), .CHECK_REPAIR_NEEDED(CHECK_REPAIR_NEEDED), 
      .BIST_DIAG_EN(BIST_COLLAR_DIAG_EN), .BIST_CLEAR_DEFAULT(BIST_CLEAR_DEFAULT), 
      .BIST_CLEAR(BIST_CLEAR), .BIST_SETUP2(BIST_SETUP_ts2), .BIST_SETUP1(BIST_SETUP_ts1), 
      .BIST_SETUP0(BIST_SETUP), .LV_TM(ltest_to_en), .FREEZE_STOP_ERROR(FREEZE_STOP_ERROR), 
      .GO_ID_REG_SEL(GO_ID_REG_SEL), .BIST_COLLAR_EN(BIST_COLLAR_EN15), .FROM_BISR_All_SCOL0_FUSE_REG(ram_row_23_col_0_bisr_inst_Q[6:1]), 
      .FROM_BISR_All_SCOL0_ALLOC_REG(ram_row_23_col_0_bisr_inst_Q[0]), .BIST_SHIFT_BIRA_COLLAR(BIST_SHIFT_BIRA_COLLAR), 
      .RESET_REG_SETUP2(MBISTPG_RESET_REG_SETUP2), .ERROR_CNT_ZERO(ERROR_CNT_ZERO), 
      .WREN_P0(WREN_P0_ts15), .WREN_P1(WREN_P1_ts15), .RDEN_P0(RDEN_P0_ts15), .RDEN_P1(RDEN_P1_ts15), 
      .ADRRD_P0(ADRRD_P0_ts15), .ADRRD_P1(ADRRD_P1_ts15), .ADRWR_P0(ADRWR_P0_ts15), 
      .ADRWR_P1(ADRWR_P1_ts15), .DIN_P0(DIN_P0_ts15), .DIN_P1(DIN_P1_ts15), .BIST_SO(BIST_SO_ts15), 
      .BIST_GO(BIST_GO_ts15), .All_SCOL0_FUSE_REG(All_SCOL0_FUSE_REG_ts15[5:0]), 
      .All_SCOL0_ALLOC_REG(All_SCOL0_ALLOC_REG_ts15), .REPAIR_STATUS(), .fscan_clkungate(fscan_clkungate)
  );

  hlp_sched_apr_rtl_tessent_mbist_RF_c3_interface_MEM17 ram_row_24_col_0_interface_inst(
      .BIST_SHADOW_READENABLE(BIST_SHADOW_READENABLE), .BIST_SHADOW_READADDRESS(BIST_SHADOW_READADDRESS), 
      .BIST_CONREAD_ROWADDRESS(BIST_CONREAD_ROWADDRESS), .BIST_CONREAD_ENABLE(BIST_CONREAD_ENABLE), 
      .BIST_CONWRITE_ROWADDRESS(BIST_CONWRITE_ROWADDRESS), .BIST_CONWRITE_ENABLE(BIST_CONWRITE_ENABLE), 
      .BIST_CLEAR_BIRA(BIST_CLEAR_BIRA), .WREN_P0_IN(ram_row_24_col_0_wr_en_a), 
      .WREN_P1_IN(ram_row_24_col_0_wr_en_b), .RDEN_P0_IN(ram_row_24_col_0_rd_en_a), 
      .RDEN_P1_IN(ram_row_24_col_0_rd_en_b), .ADRRD_P0_IN(ram_row_24_col_0_rd_adr_a[7:0]), 
      .ADRRD_P1_IN(ram_row_24_col_0_rd_adr_b[7:0]), .ADRWR_P0_IN(ram_row_24_col_0_wr_adr_a[7:0]), 
      .ADRWR_P1_IN(ram_row_24_col_0_wr_adr_b[7:0]), .QOUT_P0(ram_row_24_col_0_data_out_a), 
      .QOUT_P1(ram_row_24_col_0_data_out_b), .DIN_P0_IN(ram_row_24_col_0_data_in_a[33:0]), 
      .DIN_P1_IN(ram_row_24_col_0_data_in_b[33:0]), .TCK(to_interfaces_tck), .BIST_CMP(BIST_CMP), 
      .INCLUDE_MEM_RESULTS_REG(INCLUDE_MEM_RESULTS_REG), .BIST_READENABLE(BIST_READENABLE), 
      .BIST_WRITEENABLE(BIST_WRITEENABLE), .BIST_ROW_ADD({BIST_ROW_ADD_ts3, 
      BIST_ROW_ADD_ts2, BIST_ROW_ADD_ts1, BIST_ROW_ADD}), .BIST_BANK_ADD({
      BIST_BANK_ADD_ts3, BIST_BANK_ADD_ts2, BIST_BANK_ADD_ts1, BIST_BANK_ADD}), .BIST_TEST_PORT(BIST_TEST_PORT), 
      .BIST_WRITE_DATA({BIST_WRITE_DATA_ts7, BIST_WRITE_DATA_ts6, 
      BIST_WRITE_DATA_ts5, BIST_WRITE_DATA_ts4, BIST_WRITE_DATA_ts3, 
      BIST_WRITE_DATA_ts2, BIST_WRITE_DATA_ts1, BIST_WRITE_DATA}), .BIST_TESTDATA_SELECT_TO_COLLAR(BIST_TESTDATA_SELECT_TO_COLLAR), 
      .MEM_BYPASS_EN(memory_bypass_to_en), .SCAN_SHIFT_EN(scan_to_en), .MCP_BOUNDING_EN(mcp_bounding_to_en), 
      .BIST_ON(BIST_ON_TO_COLLAR), .BIST_RUN(BIST_RUN_TO_COLLAR16), .BIST_ASYNC_RESETN(BIST_ASYNC_RESET), 
      .BIST_CLK(clk_a), .BIST_SHIFT_COLLAR(BIST_SHIFT_COLLAR), .BIST_EXPECT_DATA({
      BIST_EXPECT_DATA_ts7, BIST_EXPECT_DATA_ts6, BIST_EXPECT_DATA_ts5, 
      BIST_EXPECT_DATA_ts4, BIST_EXPECT_DATA_ts3, BIST_EXPECT_DATA_ts2, 
      BIST_EXPECT_DATA_ts1, BIST_EXPECT_DATA}), .BIST_SI(MEM16_BIST_COLLAR_SI), .BIST_COLLAR_SETUP(BIST_COLLAR_SETUP), 
      .BIST_COLLAR_OPSET_SELECT(BIST_COLLAR_OPSET_SELECT), .BIST_COLLAR_HOLD(BIST_COLLAR_HOLD), 
      .BIST_BIRA_EN(BIST_COLLAR_BIRA_EN), .CHECK_REPAIR_NEEDED(CHECK_REPAIR_NEEDED), 
      .BIST_DIAG_EN(BIST_COLLAR_DIAG_EN), .BIST_CLEAR_DEFAULT(BIST_CLEAR_DEFAULT), 
      .BIST_CLEAR(BIST_CLEAR), .BIST_SETUP2(BIST_SETUP_ts2), .BIST_SETUP1(BIST_SETUP_ts1), 
      .BIST_SETUP0(BIST_SETUP), .LV_TM(ltest_to_en), .FREEZE_STOP_ERROR(FREEZE_STOP_ERROR), 
      .GO_ID_REG_SEL(GO_ID_REG_SEL), .BIST_COLLAR_EN(BIST_COLLAR_EN16), .FROM_BISR_All_SCOL0_FUSE_REG(ram_row_24_col_0_bisr_inst_Q[6:1]), 
      .FROM_BISR_All_SCOL0_ALLOC_REG(ram_row_24_col_0_bisr_inst_Q[0]), .BIST_SHIFT_BIRA_COLLAR(BIST_SHIFT_BIRA_COLLAR), 
      .RESET_REG_SETUP2(MBISTPG_RESET_REG_SETUP2), .ERROR_CNT_ZERO(ERROR_CNT_ZERO), 
      .WREN_P0(WREN_P0_ts16), .WREN_P1(WREN_P1_ts16), .RDEN_P0(RDEN_P0_ts16), .RDEN_P1(RDEN_P1_ts16), 
      .ADRRD_P0(ADRRD_P0_ts16), .ADRRD_P1(ADRRD_P1_ts16), .ADRWR_P0(ADRWR_P0_ts16), 
      .ADRWR_P1(ADRWR_P1_ts16), .DIN_P0(DIN_P0_ts16), .DIN_P1(DIN_P1_ts16), .BIST_SO(BIST_SO_ts16), 
      .BIST_GO(BIST_GO_ts16), .All_SCOL0_FUSE_REG(All_SCOL0_FUSE_REG_ts16[5:0]), 
      .All_SCOL0_ALLOC_REG(All_SCOL0_ALLOC_REG_ts16), .REPAIR_STATUS(), .fscan_clkungate(fscan_clkungate)
  );

  hlp_sched_apr_rtl_tessent_mbist_RF_c3_interface_MEM18 ram_row_25_col_0_interface_inst(
      .BIST_SHADOW_READENABLE(BIST_SHADOW_READENABLE), .BIST_SHADOW_READADDRESS(BIST_SHADOW_READADDRESS), 
      .BIST_CONREAD_ROWADDRESS(BIST_CONREAD_ROWADDRESS), .BIST_CONREAD_ENABLE(BIST_CONREAD_ENABLE), 
      .BIST_CONWRITE_ROWADDRESS(BIST_CONWRITE_ROWADDRESS), .BIST_CONWRITE_ENABLE(BIST_CONWRITE_ENABLE), 
      .BIST_CLEAR_BIRA(BIST_CLEAR_BIRA), .WREN_P0_IN(ram_row_25_col_0_wr_en_a), 
      .WREN_P1_IN(ram_row_25_col_0_wr_en_b), .RDEN_P0_IN(ram_row_25_col_0_rd_en_a), 
      .RDEN_P1_IN(ram_row_25_col_0_rd_en_b), .ADRRD_P0_IN(ram_row_25_col_0_rd_adr_a[7:0]), 
      .ADRRD_P1_IN(ram_row_25_col_0_rd_adr_b[7:0]), .ADRWR_P0_IN(ram_row_25_col_0_wr_adr_a[7:0]), 
      .ADRWR_P1_IN(ram_row_25_col_0_wr_adr_b[7:0]), .QOUT_P0(ram_row_25_col_0_data_out_a), 
      .QOUT_P1(ram_row_25_col_0_data_out_b), .DIN_P0_IN(ram_row_25_col_0_data_in_a[33:0]), 
      .DIN_P1_IN(ram_row_25_col_0_data_in_b[33:0]), .TCK(to_interfaces_tck), .BIST_CMP(BIST_CMP), 
      .INCLUDE_MEM_RESULTS_REG(INCLUDE_MEM_RESULTS_REG), .BIST_READENABLE(BIST_READENABLE), 
      .BIST_WRITEENABLE(BIST_WRITEENABLE), .BIST_ROW_ADD({BIST_ROW_ADD_ts3, 
      BIST_ROW_ADD_ts2, BIST_ROW_ADD_ts1, BIST_ROW_ADD}), .BIST_BANK_ADD({
      BIST_BANK_ADD_ts3, BIST_BANK_ADD_ts2, BIST_BANK_ADD_ts1, BIST_BANK_ADD}), .BIST_TEST_PORT(BIST_TEST_PORT), 
      .BIST_WRITE_DATA({BIST_WRITE_DATA_ts7, BIST_WRITE_DATA_ts6, 
      BIST_WRITE_DATA_ts5, BIST_WRITE_DATA_ts4, BIST_WRITE_DATA_ts3, 
      BIST_WRITE_DATA_ts2, BIST_WRITE_DATA_ts1, BIST_WRITE_DATA}), .BIST_TESTDATA_SELECT_TO_COLLAR(BIST_TESTDATA_SELECT_TO_COLLAR), 
      .MEM_BYPASS_EN(memory_bypass_to_en), .SCAN_SHIFT_EN(scan_to_en), .MCP_BOUNDING_EN(mcp_bounding_to_en), 
      .BIST_ON(BIST_ON_TO_COLLAR), .BIST_RUN(BIST_RUN_TO_COLLAR17), .BIST_ASYNC_RESETN(BIST_ASYNC_RESET), 
      .BIST_CLK(clk_a), .BIST_SHIFT_COLLAR(BIST_SHIFT_COLLAR), .BIST_EXPECT_DATA({
      BIST_EXPECT_DATA_ts7, BIST_EXPECT_DATA_ts6, BIST_EXPECT_DATA_ts5, 
      BIST_EXPECT_DATA_ts4, BIST_EXPECT_DATA_ts3, BIST_EXPECT_DATA_ts2, 
      BIST_EXPECT_DATA_ts1, BIST_EXPECT_DATA}), .BIST_SI(MEM17_BIST_COLLAR_SI), .BIST_COLLAR_SETUP(BIST_COLLAR_SETUP), 
      .BIST_COLLAR_OPSET_SELECT(BIST_COLLAR_OPSET_SELECT), .BIST_COLLAR_HOLD(BIST_COLLAR_HOLD), 
      .BIST_BIRA_EN(BIST_COLLAR_BIRA_EN), .CHECK_REPAIR_NEEDED(CHECK_REPAIR_NEEDED), 
      .BIST_DIAG_EN(BIST_COLLAR_DIAG_EN), .BIST_CLEAR_DEFAULT(BIST_CLEAR_DEFAULT), 
      .BIST_CLEAR(BIST_CLEAR), .BIST_SETUP2(BIST_SETUP_ts2), .BIST_SETUP1(BIST_SETUP_ts1), 
      .BIST_SETUP0(BIST_SETUP), .LV_TM(ltest_to_en), .FREEZE_STOP_ERROR(FREEZE_STOP_ERROR), 
      .GO_ID_REG_SEL(GO_ID_REG_SEL), .BIST_COLLAR_EN(BIST_COLLAR_EN17), .FROM_BISR_All_SCOL0_FUSE_REG(ram_row_25_col_0_bisr_inst_Q[6:1]), 
      .FROM_BISR_All_SCOL0_ALLOC_REG(ram_row_25_col_0_bisr_inst_Q[0]), .BIST_SHIFT_BIRA_COLLAR(BIST_SHIFT_BIRA_COLLAR), 
      .RESET_REG_SETUP2(MBISTPG_RESET_REG_SETUP2), .ERROR_CNT_ZERO(ERROR_CNT_ZERO), 
      .WREN_P0(WREN_P0_ts17), .WREN_P1(WREN_P1_ts17), .RDEN_P0(RDEN_P0_ts17), .RDEN_P1(RDEN_P1_ts17), 
      .ADRRD_P0(ADRRD_P0_ts17), .ADRRD_P1(ADRRD_P1_ts17), .ADRWR_P0(ADRWR_P0_ts17), 
      .ADRWR_P1(ADRWR_P1_ts17), .DIN_P0(DIN_P0_ts17), .DIN_P1(DIN_P1_ts17), .BIST_SO(BIST_SO_ts17), 
      .BIST_GO(BIST_GO_ts17), .All_SCOL0_FUSE_REG(All_SCOL0_FUSE_REG_ts17[5:0]), 
      .All_SCOL0_ALLOC_REG(All_SCOL0_ALLOC_REG_ts17), .REPAIR_STATUS(), .fscan_clkungate(fscan_clkungate)
  );

  hlp_sched_apr_rtl_tessent_mbist_RF_c3_interface_MEM19 ram_row_26_col_0_interface_inst(
      .BIST_SHADOW_READENABLE(BIST_SHADOW_READENABLE), .BIST_SHADOW_READADDRESS(BIST_SHADOW_READADDRESS), 
      .BIST_CONREAD_ROWADDRESS(BIST_CONREAD_ROWADDRESS), .BIST_CONREAD_ENABLE(BIST_CONREAD_ENABLE), 
      .BIST_CONWRITE_ROWADDRESS(BIST_CONWRITE_ROWADDRESS), .BIST_CONWRITE_ENABLE(BIST_CONWRITE_ENABLE), 
      .BIST_CLEAR_BIRA(BIST_CLEAR_BIRA), .WREN_P0_IN(ram_row_26_col_0_wr_en_a), 
      .WREN_P1_IN(ram_row_26_col_0_wr_en_b), .RDEN_P0_IN(ram_row_26_col_0_rd_en_a), 
      .RDEN_P1_IN(ram_row_26_col_0_rd_en_b), .ADRRD_P0_IN(ram_row_26_col_0_rd_adr_a[7:0]), 
      .ADRRD_P1_IN(ram_row_26_col_0_rd_adr_b[7:0]), .ADRWR_P0_IN(ram_row_26_col_0_wr_adr_a[7:0]), 
      .ADRWR_P1_IN(ram_row_26_col_0_wr_adr_b[7:0]), .QOUT_P0(ram_row_26_col_0_data_out_a), 
      .QOUT_P1(ram_row_26_col_0_data_out_b), .DIN_P0_IN(ram_row_26_col_0_data_in_a[33:0]), 
      .DIN_P1_IN(ram_row_26_col_0_data_in_b[33:0]), .TCK(to_interfaces_tck), .BIST_CMP(BIST_CMP), 
      .INCLUDE_MEM_RESULTS_REG(INCLUDE_MEM_RESULTS_REG), .BIST_READENABLE(BIST_READENABLE), 
      .BIST_WRITEENABLE(BIST_WRITEENABLE), .BIST_ROW_ADD({BIST_ROW_ADD_ts3, 
      BIST_ROW_ADD_ts2, BIST_ROW_ADD_ts1, BIST_ROW_ADD}), .BIST_BANK_ADD({
      BIST_BANK_ADD_ts3, BIST_BANK_ADD_ts2, BIST_BANK_ADD_ts1, BIST_BANK_ADD}), .BIST_TEST_PORT(BIST_TEST_PORT), 
      .BIST_WRITE_DATA({BIST_WRITE_DATA_ts7, BIST_WRITE_DATA_ts6, 
      BIST_WRITE_DATA_ts5, BIST_WRITE_DATA_ts4, BIST_WRITE_DATA_ts3, 
      BIST_WRITE_DATA_ts2, BIST_WRITE_DATA_ts1, BIST_WRITE_DATA}), .BIST_TESTDATA_SELECT_TO_COLLAR(BIST_TESTDATA_SELECT_TO_COLLAR), 
      .MEM_BYPASS_EN(memory_bypass_to_en), .SCAN_SHIFT_EN(scan_to_en), .MCP_BOUNDING_EN(mcp_bounding_to_en), 
      .BIST_ON(BIST_ON_TO_COLLAR), .BIST_RUN(BIST_RUN_TO_COLLAR18), .BIST_ASYNC_RESETN(BIST_ASYNC_RESET), 
      .BIST_CLK(clk_a), .BIST_SHIFT_COLLAR(BIST_SHIFT_COLLAR), .BIST_EXPECT_DATA({
      BIST_EXPECT_DATA_ts7, BIST_EXPECT_DATA_ts6, BIST_EXPECT_DATA_ts5, 
      BIST_EXPECT_DATA_ts4, BIST_EXPECT_DATA_ts3, BIST_EXPECT_DATA_ts2, 
      BIST_EXPECT_DATA_ts1, BIST_EXPECT_DATA}), .BIST_SI(MEM18_BIST_COLLAR_SI), .BIST_COLLAR_SETUP(BIST_COLLAR_SETUP), 
      .BIST_COLLAR_OPSET_SELECT(BIST_COLLAR_OPSET_SELECT), .BIST_COLLAR_HOLD(BIST_COLLAR_HOLD), 
      .BIST_BIRA_EN(BIST_COLLAR_BIRA_EN), .CHECK_REPAIR_NEEDED(CHECK_REPAIR_NEEDED), 
      .BIST_DIAG_EN(BIST_COLLAR_DIAG_EN), .BIST_CLEAR_DEFAULT(BIST_CLEAR_DEFAULT), 
      .BIST_CLEAR(BIST_CLEAR), .BIST_SETUP2(BIST_SETUP_ts2), .BIST_SETUP1(BIST_SETUP_ts1), 
      .BIST_SETUP0(BIST_SETUP), .LV_TM(ltest_to_en), .FREEZE_STOP_ERROR(FREEZE_STOP_ERROR), 
      .GO_ID_REG_SEL(GO_ID_REG_SEL), .BIST_COLLAR_EN(BIST_COLLAR_EN18), .FROM_BISR_All_SCOL0_FUSE_REG(ram_row_26_col_0_bisr_inst_Q[6:1]), 
      .FROM_BISR_All_SCOL0_ALLOC_REG(ram_row_26_col_0_bisr_inst_Q[0]), .BIST_SHIFT_BIRA_COLLAR(BIST_SHIFT_BIRA_COLLAR), 
      .RESET_REG_SETUP2(MBISTPG_RESET_REG_SETUP2), .ERROR_CNT_ZERO(ERROR_CNT_ZERO), 
      .WREN_P0(WREN_P0_ts18), .WREN_P1(WREN_P1_ts18), .RDEN_P0(RDEN_P0_ts18), .RDEN_P1(RDEN_P1_ts18), 
      .ADRRD_P0(ADRRD_P0_ts18), .ADRRD_P1(ADRRD_P1_ts18), .ADRWR_P0(ADRWR_P0_ts18), 
      .ADRWR_P1(ADRWR_P1_ts18), .DIN_P0(DIN_P0_ts18), .DIN_P1(DIN_P1_ts18), .BIST_SO(BIST_SO_ts18), 
      .BIST_GO(BIST_GO_ts18), .All_SCOL0_FUSE_REG(All_SCOL0_FUSE_REG_ts18[5:0]), 
      .All_SCOL0_ALLOC_REG(All_SCOL0_ALLOC_REG_ts18), .REPAIR_STATUS(), .fscan_clkungate(fscan_clkungate)
  );

  hlp_sched_apr_rtl_tessent_mbist_RF_c3_interface_MEM20 ram_row_27_col_0_interface_inst(
      .BIST_SHADOW_READENABLE(BIST_SHADOW_READENABLE), .BIST_SHADOW_READADDRESS(BIST_SHADOW_READADDRESS), 
      .BIST_CONREAD_ROWADDRESS(BIST_CONREAD_ROWADDRESS), .BIST_CONREAD_ENABLE(BIST_CONREAD_ENABLE), 
      .BIST_CONWRITE_ROWADDRESS(BIST_CONWRITE_ROWADDRESS), .BIST_CONWRITE_ENABLE(BIST_CONWRITE_ENABLE), 
      .BIST_CLEAR_BIRA(BIST_CLEAR_BIRA), .WREN_P0_IN(ram_row_27_col_0_wr_en_a), 
      .WREN_P1_IN(ram_row_27_col_0_wr_en_b), .RDEN_P0_IN(ram_row_27_col_0_rd_en_a), 
      .RDEN_P1_IN(ram_row_27_col_0_rd_en_b), .ADRRD_P0_IN(ram_row_27_col_0_rd_adr_a[7:0]), 
      .ADRRD_P1_IN(ram_row_27_col_0_rd_adr_b[7:0]), .ADRWR_P0_IN(ram_row_27_col_0_wr_adr_a[7:0]), 
      .ADRWR_P1_IN(ram_row_27_col_0_wr_adr_b[7:0]), .QOUT_P0(ram_row_27_col_0_data_out_a), 
      .QOUT_P1(ram_row_27_col_0_data_out_b), .DIN_P0_IN(ram_row_27_col_0_data_in_a[33:0]), 
      .DIN_P1_IN(ram_row_27_col_0_data_in_b[33:0]), .TCK(to_interfaces_tck), .BIST_CMP(BIST_CMP), 
      .INCLUDE_MEM_RESULTS_REG(INCLUDE_MEM_RESULTS_REG), .BIST_READENABLE(BIST_READENABLE), 
      .BIST_WRITEENABLE(BIST_WRITEENABLE), .BIST_ROW_ADD({BIST_ROW_ADD_ts3, 
      BIST_ROW_ADD_ts2, BIST_ROW_ADD_ts1, BIST_ROW_ADD}), .BIST_BANK_ADD({
      BIST_BANK_ADD_ts3, BIST_BANK_ADD_ts2, BIST_BANK_ADD_ts1, BIST_BANK_ADD}), .BIST_TEST_PORT(BIST_TEST_PORT), 
      .BIST_WRITE_DATA({BIST_WRITE_DATA_ts7, BIST_WRITE_DATA_ts6, 
      BIST_WRITE_DATA_ts5, BIST_WRITE_DATA_ts4, BIST_WRITE_DATA_ts3, 
      BIST_WRITE_DATA_ts2, BIST_WRITE_DATA_ts1, BIST_WRITE_DATA}), .BIST_TESTDATA_SELECT_TO_COLLAR(BIST_TESTDATA_SELECT_TO_COLLAR), 
      .MEM_BYPASS_EN(memory_bypass_to_en), .SCAN_SHIFT_EN(scan_to_en), .MCP_BOUNDING_EN(mcp_bounding_to_en), 
      .BIST_ON(BIST_ON_TO_COLLAR), .BIST_RUN(BIST_RUN_TO_COLLAR19), .BIST_ASYNC_RESETN(BIST_ASYNC_RESET), 
      .BIST_CLK(clk_a), .BIST_SHIFT_COLLAR(BIST_SHIFT_COLLAR), .BIST_EXPECT_DATA({
      BIST_EXPECT_DATA_ts7, BIST_EXPECT_DATA_ts6, BIST_EXPECT_DATA_ts5, 
      BIST_EXPECT_DATA_ts4, BIST_EXPECT_DATA_ts3, BIST_EXPECT_DATA_ts2, 
      BIST_EXPECT_DATA_ts1, BIST_EXPECT_DATA}), .BIST_SI(MEM19_BIST_COLLAR_SI), .BIST_COLLAR_SETUP(BIST_COLLAR_SETUP), 
      .BIST_COLLAR_OPSET_SELECT(BIST_COLLAR_OPSET_SELECT), .BIST_COLLAR_HOLD(BIST_COLLAR_HOLD), 
      .BIST_BIRA_EN(BIST_COLLAR_BIRA_EN), .CHECK_REPAIR_NEEDED(CHECK_REPAIR_NEEDED), 
      .BIST_DIAG_EN(BIST_COLLAR_DIAG_EN), .BIST_CLEAR_DEFAULT(BIST_CLEAR_DEFAULT), 
      .BIST_CLEAR(BIST_CLEAR), .BIST_SETUP2(BIST_SETUP_ts2), .BIST_SETUP1(BIST_SETUP_ts1), 
      .BIST_SETUP0(BIST_SETUP), .LV_TM(ltest_to_en), .FREEZE_STOP_ERROR(FREEZE_STOP_ERROR), 
      .GO_ID_REG_SEL(GO_ID_REG_SEL), .BIST_COLLAR_EN(BIST_COLLAR_EN19), .FROM_BISR_All_SCOL0_FUSE_REG(ram_row_27_col_0_bisr_inst_Q[6:1]), 
      .FROM_BISR_All_SCOL0_ALLOC_REG(ram_row_27_col_0_bisr_inst_Q[0]), .BIST_SHIFT_BIRA_COLLAR(BIST_SHIFT_BIRA_COLLAR), 
      .RESET_REG_SETUP2(MBISTPG_RESET_REG_SETUP2), .ERROR_CNT_ZERO(ERROR_CNT_ZERO), 
      .WREN_P0(WREN_P0_ts19), .WREN_P1(WREN_P1_ts19), .RDEN_P0(RDEN_P0_ts19), .RDEN_P1(RDEN_P1_ts19), 
      .ADRRD_P0(ADRRD_P0_ts19), .ADRRD_P1(ADRRD_P1_ts19), .ADRWR_P0(ADRWR_P0_ts19), 
      .ADRWR_P1(ADRWR_P1_ts19), .DIN_P0(DIN_P0_ts19), .DIN_P1(DIN_P1_ts19), .BIST_SO(BIST_SO_ts19), 
      .BIST_GO(BIST_GO_ts19), .All_SCOL0_FUSE_REG(All_SCOL0_FUSE_REG_ts19[5:0]), 
      .All_SCOL0_ALLOC_REG(All_SCOL0_ALLOC_REG_ts19), .REPAIR_STATUS(), .fscan_clkungate(fscan_clkungate)
  );

  hlp_sched_apr_rtl_tessent_mbist_RF_c3_interface_MEM21 ram_row_28_col_0_interface_inst(
      .BIST_SHADOW_READENABLE(BIST_SHADOW_READENABLE), .BIST_SHADOW_READADDRESS(BIST_SHADOW_READADDRESS), 
      .BIST_CONREAD_ROWADDRESS(BIST_CONREAD_ROWADDRESS), .BIST_CONREAD_ENABLE(BIST_CONREAD_ENABLE), 
      .BIST_CONWRITE_ROWADDRESS(BIST_CONWRITE_ROWADDRESS), .BIST_CONWRITE_ENABLE(BIST_CONWRITE_ENABLE), 
      .BIST_CLEAR_BIRA(BIST_CLEAR_BIRA), .WREN_P0_IN(ram_row_28_col_0_wr_en_a), 
      .WREN_P1_IN(ram_row_28_col_0_wr_en_b), .RDEN_P0_IN(ram_row_28_col_0_rd_en_a), 
      .RDEN_P1_IN(ram_row_28_col_0_rd_en_b), .ADRRD_P0_IN(ram_row_28_col_0_rd_adr_a[7:0]), 
      .ADRRD_P1_IN(ram_row_28_col_0_rd_adr_b[7:0]), .ADRWR_P0_IN(ram_row_28_col_0_wr_adr_a[7:0]), 
      .ADRWR_P1_IN(ram_row_28_col_0_wr_adr_b[7:0]), .QOUT_P0(ram_row_28_col_0_data_out_a), 
      .QOUT_P1(ram_row_28_col_0_data_out_b), .DIN_P0_IN(ram_row_28_col_0_data_in_a[33:0]), 
      .DIN_P1_IN(ram_row_28_col_0_data_in_b[33:0]), .TCK(to_interfaces_tck), .BIST_CMP(BIST_CMP), 
      .INCLUDE_MEM_RESULTS_REG(INCLUDE_MEM_RESULTS_REG), .BIST_READENABLE(BIST_READENABLE), 
      .BIST_WRITEENABLE(BIST_WRITEENABLE), .BIST_ROW_ADD({BIST_ROW_ADD_ts3, 
      BIST_ROW_ADD_ts2, BIST_ROW_ADD_ts1, BIST_ROW_ADD}), .BIST_BANK_ADD({
      BIST_BANK_ADD_ts3, BIST_BANK_ADD_ts2, BIST_BANK_ADD_ts1, BIST_BANK_ADD}), .BIST_TEST_PORT(BIST_TEST_PORT), 
      .BIST_WRITE_DATA({BIST_WRITE_DATA_ts7, BIST_WRITE_DATA_ts6, 
      BIST_WRITE_DATA_ts5, BIST_WRITE_DATA_ts4, BIST_WRITE_DATA_ts3, 
      BIST_WRITE_DATA_ts2, BIST_WRITE_DATA_ts1, BIST_WRITE_DATA}), .BIST_TESTDATA_SELECT_TO_COLLAR(BIST_TESTDATA_SELECT_TO_COLLAR), 
      .MEM_BYPASS_EN(memory_bypass_to_en), .SCAN_SHIFT_EN(scan_to_en), .MCP_BOUNDING_EN(mcp_bounding_to_en), 
      .BIST_ON(BIST_ON_TO_COLLAR), .BIST_RUN(BIST_RUN_TO_COLLAR20), .BIST_ASYNC_RESETN(BIST_ASYNC_RESET), 
      .BIST_CLK(clk_a), .BIST_SHIFT_COLLAR(BIST_SHIFT_COLLAR), .BIST_EXPECT_DATA({
      BIST_EXPECT_DATA_ts7, BIST_EXPECT_DATA_ts6, BIST_EXPECT_DATA_ts5, 
      BIST_EXPECT_DATA_ts4, BIST_EXPECT_DATA_ts3, BIST_EXPECT_DATA_ts2, 
      BIST_EXPECT_DATA_ts1, BIST_EXPECT_DATA}), .BIST_SI(MEM20_BIST_COLLAR_SI), .BIST_COLLAR_SETUP(BIST_COLLAR_SETUP), 
      .BIST_COLLAR_OPSET_SELECT(BIST_COLLAR_OPSET_SELECT), .BIST_COLLAR_HOLD(BIST_COLLAR_HOLD), 
      .BIST_BIRA_EN(BIST_COLLAR_BIRA_EN), .CHECK_REPAIR_NEEDED(CHECK_REPAIR_NEEDED), 
      .BIST_DIAG_EN(BIST_COLLAR_DIAG_EN), .BIST_CLEAR_DEFAULT(BIST_CLEAR_DEFAULT), 
      .BIST_CLEAR(BIST_CLEAR), .BIST_SETUP2(BIST_SETUP_ts2), .BIST_SETUP1(BIST_SETUP_ts1), 
      .BIST_SETUP0(BIST_SETUP), .LV_TM(ltest_to_en), .FREEZE_STOP_ERROR(FREEZE_STOP_ERROR), 
      .GO_ID_REG_SEL(GO_ID_REG_SEL), .BIST_COLLAR_EN(BIST_COLLAR_EN20), .FROM_BISR_All_SCOL0_FUSE_REG(ram_row_28_col_0_bisr_inst_Q[6:1]), 
      .FROM_BISR_All_SCOL0_ALLOC_REG(ram_row_28_col_0_bisr_inst_Q[0]), .BIST_SHIFT_BIRA_COLLAR(BIST_SHIFT_BIRA_COLLAR), 
      .RESET_REG_SETUP2(MBISTPG_RESET_REG_SETUP2), .ERROR_CNT_ZERO(ERROR_CNT_ZERO), 
      .WREN_P0(WREN_P0_ts20), .WREN_P1(WREN_P1_ts20), .RDEN_P0(RDEN_P0_ts20), .RDEN_P1(RDEN_P1_ts20), 
      .ADRRD_P0(ADRRD_P0_ts20), .ADRRD_P1(ADRRD_P1_ts20), .ADRWR_P0(ADRWR_P0_ts20), 
      .ADRWR_P1(ADRWR_P1_ts20), .DIN_P0(DIN_P0_ts20), .DIN_P1(DIN_P1_ts20), .BIST_SO(BIST_SO_ts20), 
      .BIST_GO(BIST_GO_ts20), .All_SCOL0_FUSE_REG(All_SCOL0_FUSE_REG_ts20[5:0]), 
      .All_SCOL0_ALLOC_REG(All_SCOL0_ALLOC_REG_ts20), .REPAIR_STATUS(), .fscan_clkungate(fscan_clkungate)
  );

  hlp_sched_apr_rtl_tessent_mbist_RF_c3_interface_MEM22 ram_row_29_col_0_interface_inst(
      .BIST_SHADOW_READENABLE(BIST_SHADOW_READENABLE), .BIST_SHADOW_READADDRESS(BIST_SHADOW_READADDRESS), 
      .BIST_CONREAD_ROWADDRESS(BIST_CONREAD_ROWADDRESS), .BIST_CONREAD_ENABLE(BIST_CONREAD_ENABLE), 
      .BIST_CONWRITE_ROWADDRESS(BIST_CONWRITE_ROWADDRESS), .BIST_CONWRITE_ENABLE(BIST_CONWRITE_ENABLE), 
      .BIST_CLEAR_BIRA(BIST_CLEAR_BIRA), .WREN_P0_IN(ram_row_29_col_0_wr_en_a), 
      .WREN_P1_IN(ram_row_29_col_0_wr_en_b), .RDEN_P0_IN(ram_row_29_col_0_rd_en_a), 
      .RDEN_P1_IN(ram_row_29_col_0_rd_en_b), .ADRRD_P0_IN(ram_row_29_col_0_rd_adr_a[7:0]), 
      .ADRRD_P1_IN(ram_row_29_col_0_rd_adr_b[7:0]), .ADRWR_P0_IN(ram_row_29_col_0_wr_adr_a[7:0]), 
      .ADRWR_P1_IN(ram_row_29_col_0_wr_adr_b[7:0]), .QOUT_P0(ram_row_29_col_0_data_out_a), 
      .QOUT_P1(ram_row_29_col_0_data_out_b), .DIN_P0_IN(ram_row_29_col_0_data_in_a[33:0]), 
      .DIN_P1_IN(ram_row_29_col_0_data_in_b[33:0]), .TCK(to_interfaces_tck), .BIST_CMP(BIST_CMP), 
      .INCLUDE_MEM_RESULTS_REG(INCLUDE_MEM_RESULTS_REG), .BIST_READENABLE(BIST_READENABLE), 
      .BIST_WRITEENABLE(BIST_WRITEENABLE), .BIST_ROW_ADD({BIST_ROW_ADD_ts3, 
      BIST_ROW_ADD_ts2, BIST_ROW_ADD_ts1, BIST_ROW_ADD}), .BIST_BANK_ADD({
      BIST_BANK_ADD_ts3, BIST_BANK_ADD_ts2, BIST_BANK_ADD_ts1, BIST_BANK_ADD}), .BIST_TEST_PORT(BIST_TEST_PORT), 
      .BIST_WRITE_DATA({BIST_WRITE_DATA_ts7, BIST_WRITE_DATA_ts6, 
      BIST_WRITE_DATA_ts5, BIST_WRITE_DATA_ts4, BIST_WRITE_DATA_ts3, 
      BIST_WRITE_DATA_ts2, BIST_WRITE_DATA_ts1, BIST_WRITE_DATA}), .BIST_TESTDATA_SELECT_TO_COLLAR(BIST_TESTDATA_SELECT_TO_COLLAR), 
      .MEM_BYPASS_EN(memory_bypass_to_en), .SCAN_SHIFT_EN(scan_to_en), .MCP_BOUNDING_EN(mcp_bounding_to_en), 
      .BIST_ON(BIST_ON_TO_COLLAR), .BIST_RUN(BIST_RUN_TO_COLLAR21), .BIST_ASYNC_RESETN(BIST_ASYNC_RESET), 
      .BIST_CLK(clk_a), .BIST_SHIFT_COLLAR(BIST_SHIFT_COLLAR), .BIST_EXPECT_DATA({
      BIST_EXPECT_DATA_ts7, BIST_EXPECT_DATA_ts6, BIST_EXPECT_DATA_ts5, 
      BIST_EXPECT_DATA_ts4, BIST_EXPECT_DATA_ts3, BIST_EXPECT_DATA_ts2, 
      BIST_EXPECT_DATA_ts1, BIST_EXPECT_DATA}), .BIST_SI(MEM21_BIST_COLLAR_SI), .BIST_COLLAR_SETUP(BIST_COLLAR_SETUP), 
      .BIST_COLLAR_OPSET_SELECT(BIST_COLLAR_OPSET_SELECT), .BIST_COLLAR_HOLD(BIST_COLLAR_HOLD), 
      .BIST_BIRA_EN(BIST_COLLAR_BIRA_EN), .CHECK_REPAIR_NEEDED(CHECK_REPAIR_NEEDED), 
      .BIST_DIAG_EN(BIST_COLLAR_DIAG_EN), .BIST_CLEAR_DEFAULT(BIST_CLEAR_DEFAULT), 
      .BIST_CLEAR(BIST_CLEAR), .BIST_SETUP2(BIST_SETUP_ts2), .BIST_SETUP1(BIST_SETUP_ts1), 
      .BIST_SETUP0(BIST_SETUP), .LV_TM(ltest_to_en), .FREEZE_STOP_ERROR(FREEZE_STOP_ERROR), 
      .GO_ID_REG_SEL(GO_ID_REG_SEL), .BIST_COLLAR_EN(BIST_COLLAR_EN21), .FROM_BISR_All_SCOL0_FUSE_REG(ram_row_29_col_0_bisr_inst_Q[6:1]), 
      .FROM_BISR_All_SCOL0_ALLOC_REG(ram_row_29_col_0_bisr_inst_Q[0]), .BIST_SHIFT_BIRA_COLLAR(BIST_SHIFT_BIRA_COLLAR), 
      .RESET_REG_SETUP2(MBISTPG_RESET_REG_SETUP2), .ERROR_CNT_ZERO(ERROR_CNT_ZERO), 
      .WREN_P0(WREN_P0_ts21), .WREN_P1(WREN_P1_ts21), .RDEN_P0(RDEN_P0_ts21), .RDEN_P1(RDEN_P1_ts21), 
      .ADRRD_P0(ADRRD_P0_ts21), .ADRRD_P1(ADRRD_P1_ts21), .ADRWR_P0(ADRWR_P0_ts21), 
      .ADRWR_P1(ADRWR_P1_ts21), .DIN_P0(DIN_P0_ts21), .DIN_P1(DIN_P1_ts21), .BIST_SO(BIST_SO_ts21), 
      .BIST_GO(BIST_GO_ts21), .All_SCOL0_FUSE_REG(All_SCOL0_FUSE_REG_ts21[5:0]), 
      .All_SCOL0_ALLOC_REG(All_SCOL0_ALLOC_REG_ts21), .REPAIR_STATUS(), .fscan_clkungate(fscan_clkungate)
  );

  hlp_sched_apr_rtl_tessent_mbist_RF_c3_interface_MEM23 ram_row_2_col_0_interface_inst(
      .BIST_SHADOW_READENABLE(BIST_SHADOW_READENABLE), .BIST_SHADOW_READADDRESS(BIST_SHADOW_READADDRESS), 
      .BIST_CONREAD_ROWADDRESS(BIST_CONREAD_ROWADDRESS), .BIST_CONREAD_ENABLE(BIST_CONREAD_ENABLE), 
      .BIST_CONWRITE_ROWADDRESS(BIST_CONWRITE_ROWADDRESS), .BIST_CONWRITE_ENABLE(BIST_CONWRITE_ENABLE), 
      .BIST_CLEAR_BIRA(BIST_CLEAR_BIRA), .WREN_P0_IN(ram_row_2_col_0_wr_en_a), 
      .WREN_P1_IN(ram_row_2_col_0_wr_en_b), .RDEN_P0_IN(ram_row_2_col_0_rd_en_a), 
      .RDEN_P1_IN(ram_row_2_col_0_rd_en_b), .ADRRD_P0_IN(ram_row_2_col_0_rd_adr_a[7:0]), 
      .ADRRD_P1_IN(ram_row_2_col_0_rd_adr_b[7:0]), .ADRWR_P0_IN(ram_row_2_col_0_wr_adr_a[7:0]), 
      .ADRWR_P1_IN(ram_row_2_col_0_wr_adr_b[7:0]), .QOUT_P0(ram_row_2_col_0_data_out_a), 
      .QOUT_P1(ram_row_2_col_0_data_out_b), .DIN_P0_IN(ram_row_2_col_0_data_in_a[33:0]), 
      .DIN_P1_IN(ram_row_2_col_0_data_in_b[33:0]), .TCK(to_interfaces_tck), .BIST_CMP(BIST_CMP), 
      .INCLUDE_MEM_RESULTS_REG(INCLUDE_MEM_RESULTS_REG), .BIST_READENABLE(BIST_READENABLE), 
      .BIST_WRITEENABLE(BIST_WRITEENABLE), .BIST_ROW_ADD({BIST_ROW_ADD_ts3, 
      BIST_ROW_ADD_ts2, BIST_ROW_ADD_ts1, BIST_ROW_ADD}), .BIST_BANK_ADD({
      BIST_BANK_ADD_ts3, BIST_BANK_ADD_ts2, BIST_BANK_ADD_ts1, BIST_BANK_ADD}), .BIST_TEST_PORT(BIST_TEST_PORT), 
      .BIST_WRITE_DATA({BIST_WRITE_DATA_ts7, BIST_WRITE_DATA_ts6, 
      BIST_WRITE_DATA_ts5, BIST_WRITE_DATA_ts4, BIST_WRITE_DATA_ts3, 
      BIST_WRITE_DATA_ts2, BIST_WRITE_DATA_ts1, BIST_WRITE_DATA}), .BIST_TESTDATA_SELECT_TO_COLLAR(BIST_TESTDATA_SELECT_TO_COLLAR), 
      .MEM_BYPASS_EN(memory_bypass_to_en), .SCAN_SHIFT_EN(scan_to_en), .MCP_BOUNDING_EN(mcp_bounding_to_en), 
      .BIST_ON(BIST_ON_TO_COLLAR), .BIST_RUN(BIST_RUN_TO_COLLAR22), .BIST_ASYNC_RESETN(BIST_ASYNC_RESET), 
      .BIST_CLK(clk_a), .BIST_SHIFT_COLLAR(BIST_SHIFT_COLLAR), .BIST_EXPECT_DATA({
      BIST_EXPECT_DATA_ts7, BIST_EXPECT_DATA_ts6, BIST_EXPECT_DATA_ts5, 
      BIST_EXPECT_DATA_ts4, BIST_EXPECT_DATA_ts3, BIST_EXPECT_DATA_ts2, 
      BIST_EXPECT_DATA_ts1, BIST_EXPECT_DATA}), .BIST_SI(MEM22_BIST_COLLAR_SI), .BIST_COLLAR_SETUP(BIST_COLLAR_SETUP), 
      .BIST_COLLAR_OPSET_SELECT(BIST_COLLAR_OPSET_SELECT), .BIST_COLLAR_HOLD(BIST_COLLAR_HOLD), 
      .BIST_BIRA_EN(BIST_COLLAR_BIRA_EN), .CHECK_REPAIR_NEEDED(CHECK_REPAIR_NEEDED), 
      .BIST_DIAG_EN(BIST_COLLAR_DIAG_EN), .BIST_CLEAR_DEFAULT(BIST_CLEAR_DEFAULT), 
      .BIST_CLEAR(BIST_CLEAR), .BIST_SETUP2(BIST_SETUP_ts2), .BIST_SETUP1(BIST_SETUP_ts1), 
      .BIST_SETUP0(BIST_SETUP), .LV_TM(ltest_to_en), .FREEZE_STOP_ERROR(FREEZE_STOP_ERROR), 
      .GO_ID_REG_SEL(GO_ID_REG_SEL), .BIST_COLLAR_EN(BIST_COLLAR_EN22), .FROM_BISR_All_SCOL0_FUSE_REG(ram_row_2_col_0_bisr_inst_Q[6:1]), 
      .FROM_BISR_All_SCOL0_ALLOC_REG(ram_row_2_col_0_bisr_inst_Q[0]), .BIST_SHIFT_BIRA_COLLAR(BIST_SHIFT_BIRA_COLLAR), 
      .RESET_REG_SETUP2(MBISTPG_RESET_REG_SETUP2), .ERROR_CNT_ZERO(ERROR_CNT_ZERO), 
      .WREN_P0(WREN_P0_ts22), .WREN_P1(WREN_P1_ts22), .RDEN_P0(RDEN_P0_ts22), .RDEN_P1(RDEN_P1_ts22), 
      .ADRRD_P0(ADRRD_P0_ts22), .ADRRD_P1(ADRRD_P1_ts22), .ADRWR_P0(ADRWR_P0_ts22), 
      .ADRWR_P1(ADRWR_P1_ts22), .DIN_P0(DIN_P0_ts22), .DIN_P1(DIN_P1_ts22), .BIST_SO(BIST_SO_ts22), 
      .BIST_GO(BIST_GO_ts22), .All_SCOL0_FUSE_REG(All_SCOL0_FUSE_REG_ts22[5:0]), 
      .All_SCOL0_ALLOC_REG(All_SCOL0_ALLOC_REG_ts22), .REPAIR_STATUS(), .fscan_clkungate(fscan_clkungate)
  );

  hlp_sched_apr_rtl_tessent_mbist_RF_c3_interface_MEM24 ram_row_30_col_0_interface_inst(
      .BIST_SHADOW_READENABLE(BIST_SHADOW_READENABLE), .BIST_SHADOW_READADDRESS(BIST_SHADOW_READADDRESS), 
      .BIST_CONREAD_ROWADDRESS(BIST_CONREAD_ROWADDRESS), .BIST_CONREAD_ENABLE(BIST_CONREAD_ENABLE), 
      .BIST_CONWRITE_ROWADDRESS(BIST_CONWRITE_ROWADDRESS), .BIST_CONWRITE_ENABLE(BIST_CONWRITE_ENABLE), 
      .BIST_CLEAR_BIRA(BIST_CLEAR_BIRA), .WREN_P0_IN(ram_row_30_col_0_wr_en_a), 
      .WREN_P1_IN(ram_row_30_col_0_wr_en_b), .RDEN_P0_IN(ram_row_30_col_0_rd_en_a), 
      .RDEN_P1_IN(ram_row_30_col_0_rd_en_b), .ADRRD_P0_IN(ram_row_30_col_0_rd_adr_a[7:0]), 
      .ADRRD_P1_IN(ram_row_30_col_0_rd_adr_b[7:0]), .ADRWR_P0_IN(ram_row_30_col_0_wr_adr_a[7:0]), 
      .ADRWR_P1_IN(ram_row_30_col_0_wr_adr_b[7:0]), .QOUT_P0(ram_row_30_col_0_data_out_a), 
      .QOUT_P1(ram_row_30_col_0_data_out_b), .DIN_P0_IN(ram_row_30_col_0_data_in_a[33:0]), 
      .DIN_P1_IN(ram_row_30_col_0_data_in_b[33:0]), .TCK(to_interfaces_tck), .BIST_CMP(BIST_CMP), 
      .INCLUDE_MEM_RESULTS_REG(INCLUDE_MEM_RESULTS_REG), .BIST_READENABLE(BIST_READENABLE), 
      .BIST_WRITEENABLE(BIST_WRITEENABLE), .BIST_ROW_ADD({BIST_ROW_ADD_ts3, 
      BIST_ROW_ADD_ts2, BIST_ROW_ADD_ts1, BIST_ROW_ADD}), .BIST_BANK_ADD({
      BIST_BANK_ADD_ts3, BIST_BANK_ADD_ts2, BIST_BANK_ADD_ts1, BIST_BANK_ADD}), .BIST_TEST_PORT(BIST_TEST_PORT), 
      .BIST_WRITE_DATA({BIST_WRITE_DATA_ts7, BIST_WRITE_DATA_ts6, 
      BIST_WRITE_DATA_ts5, BIST_WRITE_DATA_ts4, BIST_WRITE_DATA_ts3, 
      BIST_WRITE_DATA_ts2, BIST_WRITE_DATA_ts1, BIST_WRITE_DATA}), .BIST_TESTDATA_SELECT_TO_COLLAR(BIST_TESTDATA_SELECT_TO_COLLAR), 
      .MEM_BYPASS_EN(memory_bypass_to_en), .SCAN_SHIFT_EN(scan_to_en), .MCP_BOUNDING_EN(mcp_bounding_to_en), 
      .BIST_ON(BIST_ON_TO_COLLAR), .BIST_RUN(BIST_RUN_TO_COLLAR23), .BIST_ASYNC_RESETN(BIST_ASYNC_RESET), 
      .BIST_CLK(clk_a), .BIST_SHIFT_COLLAR(BIST_SHIFT_COLLAR), .BIST_EXPECT_DATA({
      BIST_EXPECT_DATA_ts7, BIST_EXPECT_DATA_ts6, BIST_EXPECT_DATA_ts5, 
      BIST_EXPECT_DATA_ts4, BIST_EXPECT_DATA_ts3, BIST_EXPECT_DATA_ts2, 
      BIST_EXPECT_DATA_ts1, BIST_EXPECT_DATA}), .BIST_SI(MEM23_BIST_COLLAR_SI), .BIST_COLLAR_SETUP(BIST_COLLAR_SETUP), 
      .BIST_COLLAR_OPSET_SELECT(BIST_COLLAR_OPSET_SELECT), .BIST_COLLAR_HOLD(BIST_COLLAR_HOLD), 
      .BIST_BIRA_EN(BIST_COLLAR_BIRA_EN), .CHECK_REPAIR_NEEDED(CHECK_REPAIR_NEEDED), 
      .BIST_DIAG_EN(BIST_COLLAR_DIAG_EN), .BIST_CLEAR_DEFAULT(BIST_CLEAR_DEFAULT), 
      .BIST_CLEAR(BIST_CLEAR), .BIST_SETUP2(BIST_SETUP_ts2), .BIST_SETUP1(BIST_SETUP_ts1), 
      .BIST_SETUP0(BIST_SETUP), .LV_TM(ltest_to_en), .FREEZE_STOP_ERROR(FREEZE_STOP_ERROR), 
      .GO_ID_REG_SEL(GO_ID_REG_SEL), .BIST_COLLAR_EN(BIST_COLLAR_EN23), .FROM_BISR_All_SCOL0_FUSE_REG(ram_row_30_col_0_bisr_inst_Q[6:1]), 
      .FROM_BISR_All_SCOL0_ALLOC_REG(ram_row_30_col_0_bisr_inst_Q[0]), .BIST_SHIFT_BIRA_COLLAR(BIST_SHIFT_BIRA_COLLAR), 
      .RESET_REG_SETUP2(MBISTPG_RESET_REG_SETUP2), .ERROR_CNT_ZERO(ERROR_CNT_ZERO), 
      .WREN_P0(WREN_P0_ts23), .WREN_P1(WREN_P1_ts23), .RDEN_P0(RDEN_P0_ts23), .RDEN_P1(RDEN_P1_ts23), 
      .ADRRD_P0(ADRRD_P0_ts23), .ADRRD_P1(ADRRD_P1_ts23), .ADRWR_P0(ADRWR_P0_ts23), 
      .ADRWR_P1(ADRWR_P1_ts23), .DIN_P0(DIN_P0_ts23), .DIN_P1(DIN_P1_ts23), .BIST_SO(BIST_SO_ts23), 
      .BIST_GO(BIST_GO_ts23), .All_SCOL0_FUSE_REG(All_SCOL0_FUSE_REG_ts23[5:0]), 
      .All_SCOL0_ALLOC_REG(All_SCOL0_ALLOC_REG_ts23), .REPAIR_STATUS(), .fscan_clkungate(fscan_clkungate)
  );

  hlp_sched_apr_rtl_tessent_mbist_RF_c3_interface_MEM25 ram_row_31_col_0_interface_inst(
      .BIST_SHADOW_READENABLE(BIST_SHADOW_READENABLE), .BIST_SHADOW_READADDRESS(BIST_SHADOW_READADDRESS), 
      .BIST_CONREAD_ROWADDRESS(BIST_CONREAD_ROWADDRESS), .BIST_CONREAD_ENABLE(BIST_CONREAD_ENABLE), 
      .BIST_CONWRITE_ROWADDRESS(BIST_CONWRITE_ROWADDRESS), .BIST_CONWRITE_ENABLE(BIST_CONWRITE_ENABLE), 
      .BIST_CLEAR_BIRA(BIST_CLEAR_BIRA), .WREN_P0_IN(ram_row_31_col_0_wr_en_a), 
      .WREN_P1_IN(ram_row_31_col_0_wr_en_b), .RDEN_P0_IN(ram_row_31_col_0_rd_en_a), 
      .RDEN_P1_IN(ram_row_31_col_0_rd_en_b), .ADRRD_P0_IN(ram_row_31_col_0_rd_adr_a[7:0]), 
      .ADRRD_P1_IN(ram_row_31_col_0_rd_adr_b[7:0]), .ADRWR_P0_IN(ram_row_31_col_0_wr_adr_a[7:0]), 
      .ADRWR_P1_IN(ram_row_31_col_0_wr_adr_b[7:0]), .QOUT_P0(ram_row_31_col_0_data_out_a), 
      .QOUT_P1(ram_row_31_col_0_data_out_b), .DIN_P0_IN(ram_row_31_col_0_data_in_a[33:0]), 
      .DIN_P1_IN(ram_row_31_col_0_data_in_b[33:0]), .TCK(to_interfaces_tck), .BIST_CMP(BIST_CMP), 
      .INCLUDE_MEM_RESULTS_REG(INCLUDE_MEM_RESULTS_REG), .BIST_READENABLE(BIST_READENABLE), 
      .BIST_WRITEENABLE(BIST_WRITEENABLE), .BIST_ROW_ADD({BIST_ROW_ADD_ts3, 
      BIST_ROW_ADD_ts2, BIST_ROW_ADD_ts1, BIST_ROW_ADD}), .BIST_BANK_ADD({
      BIST_BANK_ADD_ts3, BIST_BANK_ADD_ts2, BIST_BANK_ADD_ts1, BIST_BANK_ADD}), .BIST_TEST_PORT(BIST_TEST_PORT), 
      .BIST_WRITE_DATA({BIST_WRITE_DATA_ts7, BIST_WRITE_DATA_ts6, 
      BIST_WRITE_DATA_ts5, BIST_WRITE_DATA_ts4, BIST_WRITE_DATA_ts3, 
      BIST_WRITE_DATA_ts2, BIST_WRITE_DATA_ts1, BIST_WRITE_DATA}), .BIST_TESTDATA_SELECT_TO_COLLAR(BIST_TESTDATA_SELECT_TO_COLLAR), 
      .MEM_BYPASS_EN(memory_bypass_to_en), .SCAN_SHIFT_EN(scan_to_en), .MCP_BOUNDING_EN(mcp_bounding_to_en), 
      .BIST_ON(BIST_ON_TO_COLLAR), .BIST_RUN(BIST_RUN_TO_COLLAR24), .BIST_ASYNC_RESETN(BIST_ASYNC_RESET), 
      .BIST_CLK(clk_a), .BIST_SHIFT_COLLAR(BIST_SHIFT_COLLAR), .BIST_EXPECT_DATA({
      BIST_EXPECT_DATA_ts7, BIST_EXPECT_DATA_ts6, BIST_EXPECT_DATA_ts5, 
      BIST_EXPECT_DATA_ts4, BIST_EXPECT_DATA_ts3, BIST_EXPECT_DATA_ts2, 
      BIST_EXPECT_DATA_ts1, BIST_EXPECT_DATA}), .BIST_SI(MEM24_BIST_COLLAR_SI), .BIST_COLLAR_SETUP(BIST_COLLAR_SETUP), 
      .BIST_COLLAR_OPSET_SELECT(BIST_COLLAR_OPSET_SELECT), .BIST_COLLAR_HOLD(BIST_COLLAR_HOLD), 
      .BIST_BIRA_EN(BIST_COLLAR_BIRA_EN), .CHECK_REPAIR_NEEDED(CHECK_REPAIR_NEEDED), 
      .BIST_DIAG_EN(BIST_COLLAR_DIAG_EN), .BIST_CLEAR_DEFAULT(BIST_CLEAR_DEFAULT), 
      .BIST_CLEAR(BIST_CLEAR), .BIST_SETUP2(BIST_SETUP_ts2), .BIST_SETUP1(BIST_SETUP_ts1), 
      .BIST_SETUP0(BIST_SETUP), .LV_TM(ltest_to_en), .FREEZE_STOP_ERROR(FREEZE_STOP_ERROR), 
      .GO_ID_REG_SEL(GO_ID_REG_SEL), .BIST_COLLAR_EN(BIST_COLLAR_EN24), .FROM_BISR_All_SCOL0_FUSE_REG(ram_row_31_col_0_bisr_inst_Q[6:1]), 
      .FROM_BISR_All_SCOL0_ALLOC_REG(ram_row_31_col_0_bisr_inst_Q[0]), .BIST_SHIFT_BIRA_COLLAR(BIST_SHIFT_BIRA_COLLAR), 
      .RESET_REG_SETUP2(MBISTPG_RESET_REG_SETUP2), .ERROR_CNT_ZERO(ERROR_CNT_ZERO), 
      .WREN_P0(WREN_P0_ts24), .WREN_P1(WREN_P1_ts24), .RDEN_P0(RDEN_P0_ts24), .RDEN_P1(RDEN_P1_ts24), 
      .ADRRD_P0(ADRRD_P0_ts24), .ADRRD_P1(ADRRD_P1_ts24), .ADRWR_P0(ADRWR_P0_ts24), 
      .ADRWR_P1(ADRWR_P1_ts24), .DIN_P0(DIN_P0_ts24), .DIN_P1(DIN_P1_ts24), .BIST_SO(BIST_SO_ts24), 
      .BIST_GO(BIST_GO_ts24), .All_SCOL0_FUSE_REG(All_SCOL0_FUSE_REG_ts24[5:0]), 
      .All_SCOL0_ALLOC_REG(All_SCOL0_ALLOC_REG_ts24), .REPAIR_STATUS(), .fscan_clkungate(fscan_clkungate)
  );

  hlp_sched_apr_rtl_tessent_mbist_RF_c3_interface_MEM26 ram_row_32_col_0_interface_inst(
      .BIST_SHADOW_READENABLE(BIST_SHADOW_READENABLE), .BIST_SHADOW_READADDRESS(BIST_SHADOW_READADDRESS), 
      .BIST_CONREAD_ROWADDRESS(BIST_CONREAD_ROWADDRESS), .BIST_CONREAD_ENABLE(BIST_CONREAD_ENABLE), 
      .BIST_CONWRITE_ROWADDRESS(BIST_CONWRITE_ROWADDRESS), .BIST_CONWRITE_ENABLE(BIST_CONWRITE_ENABLE), 
      .BIST_CLEAR_BIRA(BIST_CLEAR_BIRA), .WREN_P0_IN(ram_row_32_col_0_wr_en_a), 
      .WREN_P1_IN(ram_row_32_col_0_wr_en_b), .RDEN_P0_IN(ram_row_32_col_0_rd_en_a), 
      .RDEN_P1_IN(ram_row_32_col_0_rd_en_b), .ADRRD_P0_IN(ram_row_32_col_0_rd_adr_a[7:0]), 
      .ADRRD_P1_IN(ram_row_32_col_0_rd_adr_b[7:0]), .ADRWR_P0_IN(ram_row_32_col_0_wr_adr_a[7:0]), 
      .ADRWR_P1_IN(ram_row_32_col_0_wr_adr_b[7:0]), .QOUT_P0(ram_row_32_col_0_data_out_a), 
      .QOUT_P1(ram_row_32_col_0_data_out_b), .DIN_P0_IN(ram_row_32_col_0_data_in_a[33:0]), 
      .DIN_P1_IN(ram_row_32_col_0_data_in_b[33:0]), .TCK(to_interfaces_tck), .BIST_CMP(BIST_CMP), 
      .INCLUDE_MEM_RESULTS_REG(INCLUDE_MEM_RESULTS_REG), .BIST_READENABLE(BIST_READENABLE), 
      .BIST_WRITEENABLE(BIST_WRITEENABLE), .BIST_ROW_ADD({BIST_ROW_ADD_ts3, 
      BIST_ROW_ADD_ts2, BIST_ROW_ADD_ts1, BIST_ROW_ADD}), .BIST_BANK_ADD({
      BIST_BANK_ADD_ts3, BIST_BANK_ADD_ts2, BIST_BANK_ADD_ts1, BIST_BANK_ADD}), .BIST_TEST_PORT(BIST_TEST_PORT), 
      .BIST_WRITE_DATA({BIST_WRITE_DATA_ts7, BIST_WRITE_DATA_ts6, 
      BIST_WRITE_DATA_ts5, BIST_WRITE_DATA_ts4, BIST_WRITE_DATA_ts3, 
      BIST_WRITE_DATA_ts2, BIST_WRITE_DATA_ts1, BIST_WRITE_DATA}), .BIST_TESTDATA_SELECT_TO_COLLAR(BIST_TESTDATA_SELECT_TO_COLLAR), 
      .MEM_BYPASS_EN(memory_bypass_to_en), .SCAN_SHIFT_EN(scan_to_en), .MCP_BOUNDING_EN(mcp_bounding_to_en), 
      .BIST_ON(BIST_ON_TO_COLLAR), .BIST_RUN(BIST_RUN_TO_COLLAR25), .BIST_ASYNC_RESETN(BIST_ASYNC_RESET), 
      .BIST_CLK(clk_a), .BIST_SHIFT_COLLAR(BIST_SHIFT_COLLAR), .BIST_EXPECT_DATA({
      BIST_EXPECT_DATA_ts7, BIST_EXPECT_DATA_ts6, BIST_EXPECT_DATA_ts5, 
      BIST_EXPECT_DATA_ts4, BIST_EXPECT_DATA_ts3, BIST_EXPECT_DATA_ts2, 
      BIST_EXPECT_DATA_ts1, BIST_EXPECT_DATA}), .BIST_SI(MEM25_BIST_COLLAR_SI), .BIST_COLLAR_SETUP(BIST_COLLAR_SETUP), 
      .BIST_COLLAR_OPSET_SELECT(BIST_COLLAR_OPSET_SELECT), .BIST_COLLAR_HOLD(BIST_COLLAR_HOLD), 
      .BIST_BIRA_EN(BIST_COLLAR_BIRA_EN), .CHECK_REPAIR_NEEDED(CHECK_REPAIR_NEEDED), 
      .BIST_DIAG_EN(BIST_COLLAR_DIAG_EN), .BIST_CLEAR_DEFAULT(BIST_CLEAR_DEFAULT), 
      .BIST_CLEAR(BIST_CLEAR), .BIST_SETUP2(BIST_SETUP_ts2), .BIST_SETUP1(BIST_SETUP_ts1), 
      .BIST_SETUP0(BIST_SETUP), .LV_TM(ltest_to_en), .FREEZE_STOP_ERROR(FREEZE_STOP_ERROR), 
      .GO_ID_REG_SEL(GO_ID_REG_SEL), .BIST_COLLAR_EN(BIST_COLLAR_EN25), .FROM_BISR_All_SCOL0_FUSE_REG(ram_row_32_col_0_bisr_inst_Q[6:1]), 
      .FROM_BISR_All_SCOL0_ALLOC_REG(ram_row_32_col_0_bisr_inst_Q[0]), .BIST_SHIFT_BIRA_COLLAR(BIST_SHIFT_BIRA_COLLAR), 
      .RESET_REG_SETUP2(MBISTPG_RESET_REG_SETUP2), .ERROR_CNT_ZERO(ERROR_CNT_ZERO), 
      .WREN_P0(WREN_P0_ts25), .WREN_P1(WREN_P1_ts25), .RDEN_P0(RDEN_P0_ts25), .RDEN_P1(RDEN_P1_ts25), 
      .ADRRD_P0(ADRRD_P0_ts25), .ADRRD_P1(ADRRD_P1_ts25), .ADRWR_P0(ADRWR_P0_ts25), 
      .ADRWR_P1(ADRWR_P1_ts25), .DIN_P0(DIN_P0_ts25), .DIN_P1(DIN_P1_ts25), .BIST_SO(BIST_SO_ts25), 
      .BIST_GO(BIST_GO_ts25), .All_SCOL0_FUSE_REG(All_SCOL0_FUSE_REG_ts25[5:0]), 
      .All_SCOL0_ALLOC_REG(All_SCOL0_ALLOC_REG_ts25), .REPAIR_STATUS(), .fscan_clkungate(fscan_clkungate)
  );

  hlp_sched_apr_rtl_tessent_mbist_RF_c3_interface_MEM27 ram_row_33_col_0_interface_inst(
      .BIST_SHADOW_READENABLE(BIST_SHADOW_READENABLE), .BIST_SHADOW_READADDRESS(BIST_SHADOW_READADDRESS), 
      .BIST_CONREAD_ROWADDRESS(BIST_CONREAD_ROWADDRESS), .BIST_CONREAD_ENABLE(BIST_CONREAD_ENABLE), 
      .BIST_CONWRITE_ROWADDRESS(BIST_CONWRITE_ROWADDRESS), .BIST_CONWRITE_ENABLE(BIST_CONWRITE_ENABLE), 
      .BIST_CLEAR_BIRA(BIST_CLEAR_BIRA), .WREN_P0_IN(ram_row_33_col_0_wr_en_a), 
      .WREN_P1_IN(ram_row_33_col_0_wr_en_b), .RDEN_P0_IN(ram_row_33_col_0_rd_en_a), 
      .RDEN_P1_IN(ram_row_33_col_0_rd_en_b), .ADRRD_P0_IN(ram_row_33_col_0_rd_adr_a[7:0]), 
      .ADRRD_P1_IN(ram_row_33_col_0_rd_adr_b[7:0]), .ADRWR_P0_IN(ram_row_33_col_0_wr_adr_a[7:0]), 
      .ADRWR_P1_IN(ram_row_33_col_0_wr_adr_b[7:0]), .QOUT_P0(ram_row_33_col_0_data_out_a), 
      .QOUT_P1(ram_row_33_col_0_data_out_b), .DIN_P0_IN(ram_row_33_col_0_data_in_a[33:0]), 
      .DIN_P1_IN(ram_row_33_col_0_data_in_b[33:0]), .TCK(to_interfaces_tck), .BIST_CMP(BIST_CMP), 
      .INCLUDE_MEM_RESULTS_REG(INCLUDE_MEM_RESULTS_REG), .BIST_READENABLE(BIST_READENABLE), 
      .BIST_WRITEENABLE(BIST_WRITEENABLE), .BIST_ROW_ADD({BIST_ROW_ADD_ts3, 
      BIST_ROW_ADD_ts2, BIST_ROW_ADD_ts1, BIST_ROW_ADD}), .BIST_BANK_ADD({
      BIST_BANK_ADD_ts3, BIST_BANK_ADD_ts2, BIST_BANK_ADD_ts1, BIST_BANK_ADD}), .BIST_TEST_PORT(BIST_TEST_PORT), 
      .BIST_WRITE_DATA({BIST_WRITE_DATA_ts7, BIST_WRITE_DATA_ts6, 
      BIST_WRITE_DATA_ts5, BIST_WRITE_DATA_ts4, BIST_WRITE_DATA_ts3, 
      BIST_WRITE_DATA_ts2, BIST_WRITE_DATA_ts1, BIST_WRITE_DATA}), .BIST_TESTDATA_SELECT_TO_COLLAR(BIST_TESTDATA_SELECT_TO_COLLAR), 
      .MEM_BYPASS_EN(memory_bypass_to_en), .SCAN_SHIFT_EN(scan_to_en), .MCP_BOUNDING_EN(mcp_bounding_to_en), 
      .BIST_ON(BIST_ON_TO_COLLAR), .BIST_RUN(BIST_RUN_TO_COLLAR26), .BIST_ASYNC_RESETN(BIST_ASYNC_RESET), 
      .BIST_CLK(clk_a), .BIST_SHIFT_COLLAR(BIST_SHIFT_COLLAR), .BIST_EXPECT_DATA({
      BIST_EXPECT_DATA_ts7, BIST_EXPECT_DATA_ts6, BIST_EXPECT_DATA_ts5, 
      BIST_EXPECT_DATA_ts4, BIST_EXPECT_DATA_ts3, BIST_EXPECT_DATA_ts2, 
      BIST_EXPECT_DATA_ts1, BIST_EXPECT_DATA}), .BIST_SI(MEM26_BIST_COLLAR_SI), .BIST_COLLAR_SETUP(BIST_COLLAR_SETUP), 
      .BIST_COLLAR_OPSET_SELECT(BIST_COLLAR_OPSET_SELECT), .BIST_COLLAR_HOLD(BIST_COLLAR_HOLD), 
      .BIST_BIRA_EN(BIST_COLLAR_BIRA_EN), .CHECK_REPAIR_NEEDED(CHECK_REPAIR_NEEDED), 
      .BIST_DIAG_EN(BIST_COLLAR_DIAG_EN), .BIST_CLEAR_DEFAULT(BIST_CLEAR_DEFAULT), 
      .BIST_CLEAR(BIST_CLEAR), .BIST_SETUP2(BIST_SETUP_ts2), .BIST_SETUP1(BIST_SETUP_ts1), 
      .BIST_SETUP0(BIST_SETUP), .LV_TM(ltest_to_en), .FREEZE_STOP_ERROR(FREEZE_STOP_ERROR), 
      .GO_ID_REG_SEL(GO_ID_REG_SEL), .BIST_COLLAR_EN(BIST_COLLAR_EN26), .FROM_BISR_All_SCOL0_FUSE_REG(ram_row_33_col_0_bisr_inst_Q[6:1]), 
      .FROM_BISR_All_SCOL0_ALLOC_REG(ram_row_33_col_0_bisr_inst_Q[0]), .BIST_SHIFT_BIRA_COLLAR(BIST_SHIFT_BIRA_COLLAR), 
      .RESET_REG_SETUP2(MBISTPG_RESET_REG_SETUP2), .ERROR_CNT_ZERO(ERROR_CNT_ZERO), 
      .WREN_P0(WREN_P0_ts26), .WREN_P1(WREN_P1_ts26), .RDEN_P0(RDEN_P0_ts26), .RDEN_P1(RDEN_P1_ts26), 
      .ADRRD_P0(ADRRD_P0_ts26), .ADRRD_P1(ADRRD_P1_ts26), .ADRWR_P0(ADRWR_P0_ts26), 
      .ADRWR_P1(ADRWR_P1_ts26), .DIN_P0(DIN_P0_ts26), .DIN_P1(DIN_P1_ts26), .BIST_SO(BIST_SO_ts26), 
      .BIST_GO(BIST_GO_ts26), .All_SCOL0_FUSE_REG(All_SCOL0_FUSE_REG_ts26[5:0]), 
      .All_SCOL0_ALLOC_REG(All_SCOL0_ALLOC_REG_ts26), .REPAIR_STATUS(), .fscan_clkungate(fscan_clkungate)
  );

  hlp_sched_apr_rtl_tessent_mbist_RF_c3_interface_MEM28 ram_row_34_col_0_interface_inst(
      .BIST_SHADOW_READENABLE(BIST_SHADOW_READENABLE), .BIST_SHADOW_READADDRESS(BIST_SHADOW_READADDRESS), 
      .BIST_CONREAD_ROWADDRESS(BIST_CONREAD_ROWADDRESS), .BIST_CONREAD_ENABLE(BIST_CONREAD_ENABLE), 
      .BIST_CONWRITE_ROWADDRESS(BIST_CONWRITE_ROWADDRESS), .BIST_CONWRITE_ENABLE(BIST_CONWRITE_ENABLE), 
      .BIST_CLEAR_BIRA(BIST_CLEAR_BIRA), .WREN_P0_IN(ram_row_34_col_0_wr_en_a), 
      .WREN_P1_IN(ram_row_34_col_0_wr_en_b), .RDEN_P0_IN(ram_row_34_col_0_rd_en_a), 
      .RDEN_P1_IN(ram_row_34_col_0_rd_en_b), .ADRRD_P0_IN(ram_row_34_col_0_rd_adr_a[7:0]), 
      .ADRRD_P1_IN(ram_row_34_col_0_rd_adr_b[7:0]), .ADRWR_P0_IN(ram_row_34_col_0_wr_adr_a[7:0]), 
      .ADRWR_P1_IN(ram_row_34_col_0_wr_adr_b[7:0]), .QOUT_P0(ram_row_34_col_0_data_out_a), 
      .QOUT_P1(ram_row_34_col_0_data_out_b), .DIN_P0_IN(ram_row_34_col_0_data_in_a[33:0]), 
      .DIN_P1_IN(ram_row_34_col_0_data_in_b[33:0]), .TCK(to_interfaces_tck), .BIST_CMP(BIST_CMP), 
      .INCLUDE_MEM_RESULTS_REG(INCLUDE_MEM_RESULTS_REG), .BIST_READENABLE(BIST_READENABLE), 
      .BIST_WRITEENABLE(BIST_WRITEENABLE), .BIST_ROW_ADD({BIST_ROW_ADD_ts3, 
      BIST_ROW_ADD_ts2, BIST_ROW_ADD_ts1, BIST_ROW_ADD}), .BIST_BANK_ADD({
      BIST_BANK_ADD_ts3, BIST_BANK_ADD_ts2, BIST_BANK_ADD_ts1, BIST_BANK_ADD}), .BIST_TEST_PORT(BIST_TEST_PORT), 
      .BIST_WRITE_DATA({BIST_WRITE_DATA_ts7, BIST_WRITE_DATA_ts6, 
      BIST_WRITE_DATA_ts5, BIST_WRITE_DATA_ts4, BIST_WRITE_DATA_ts3, 
      BIST_WRITE_DATA_ts2, BIST_WRITE_DATA_ts1, BIST_WRITE_DATA}), .BIST_TESTDATA_SELECT_TO_COLLAR(BIST_TESTDATA_SELECT_TO_COLLAR), 
      .MEM_BYPASS_EN(memory_bypass_to_en), .SCAN_SHIFT_EN(scan_to_en), .MCP_BOUNDING_EN(mcp_bounding_to_en), 
      .BIST_ON(BIST_ON_TO_COLLAR), .BIST_RUN(BIST_RUN_TO_COLLAR27), .BIST_ASYNC_RESETN(BIST_ASYNC_RESET), 
      .BIST_CLK(clk_a), .BIST_SHIFT_COLLAR(BIST_SHIFT_COLLAR), .BIST_EXPECT_DATA({
      BIST_EXPECT_DATA_ts7, BIST_EXPECT_DATA_ts6, BIST_EXPECT_DATA_ts5, 
      BIST_EXPECT_DATA_ts4, BIST_EXPECT_DATA_ts3, BIST_EXPECT_DATA_ts2, 
      BIST_EXPECT_DATA_ts1, BIST_EXPECT_DATA}), .BIST_SI(MEM27_BIST_COLLAR_SI), .BIST_COLLAR_SETUP(BIST_COLLAR_SETUP), 
      .BIST_COLLAR_OPSET_SELECT(BIST_COLLAR_OPSET_SELECT), .BIST_COLLAR_HOLD(BIST_COLLAR_HOLD), 
      .BIST_BIRA_EN(BIST_COLLAR_BIRA_EN), .CHECK_REPAIR_NEEDED(CHECK_REPAIR_NEEDED), 
      .BIST_DIAG_EN(BIST_COLLAR_DIAG_EN), .BIST_CLEAR_DEFAULT(BIST_CLEAR_DEFAULT), 
      .BIST_CLEAR(BIST_CLEAR), .BIST_SETUP2(BIST_SETUP_ts2), .BIST_SETUP1(BIST_SETUP_ts1), 
      .BIST_SETUP0(BIST_SETUP), .LV_TM(ltest_to_en), .FREEZE_STOP_ERROR(FREEZE_STOP_ERROR), 
      .GO_ID_REG_SEL(GO_ID_REG_SEL), .BIST_COLLAR_EN(BIST_COLLAR_EN27), .FROM_BISR_All_SCOL0_FUSE_REG(ram_row_34_col_0_bisr_inst_Q[6:1]), 
      .FROM_BISR_All_SCOL0_ALLOC_REG(ram_row_34_col_0_bisr_inst_Q[0]), .BIST_SHIFT_BIRA_COLLAR(BIST_SHIFT_BIRA_COLLAR), 
      .RESET_REG_SETUP2(MBISTPG_RESET_REG_SETUP2), .ERROR_CNT_ZERO(ERROR_CNT_ZERO), 
      .WREN_P0(WREN_P0_ts27), .WREN_P1(WREN_P1_ts27), .RDEN_P0(RDEN_P0_ts27), .RDEN_P1(RDEN_P1_ts27), 
      .ADRRD_P0(ADRRD_P0_ts27), .ADRRD_P1(ADRRD_P1_ts27), .ADRWR_P0(ADRWR_P0_ts27), 
      .ADRWR_P1(ADRWR_P1_ts27), .DIN_P0(DIN_P0_ts27), .DIN_P1(DIN_P1_ts27), .BIST_SO(BIST_SO_ts27), 
      .BIST_GO(BIST_GO_ts27), .All_SCOL0_FUSE_REG(All_SCOL0_FUSE_REG_ts27[5:0]), 
      .All_SCOL0_ALLOC_REG(All_SCOL0_ALLOC_REG_ts27), .REPAIR_STATUS(), .fscan_clkungate(fscan_clkungate)
  );

  hlp_sched_apr_rtl_tessent_mbist_RF_c3_interface_MEM29 ram_row_35_col_0_interface_inst(
      .BIST_SHADOW_READENABLE(BIST_SHADOW_READENABLE), .BIST_SHADOW_READADDRESS(BIST_SHADOW_READADDRESS), 
      .BIST_CONREAD_ROWADDRESS(BIST_CONREAD_ROWADDRESS), .BIST_CONREAD_ENABLE(BIST_CONREAD_ENABLE), 
      .BIST_CONWRITE_ROWADDRESS(BIST_CONWRITE_ROWADDRESS), .BIST_CONWRITE_ENABLE(BIST_CONWRITE_ENABLE), 
      .BIST_CLEAR_BIRA(BIST_CLEAR_BIRA), .WREN_P0_IN(ram_row_35_col_0_wr_en_a), 
      .WREN_P1_IN(ram_row_35_col_0_wr_en_b), .RDEN_P0_IN(ram_row_35_col_0_rd_en_a), 
      .RDEN_P1_IN(ram_row_35_col_0_rd_en_b), .ADRRD_P0_IN(ram_row_35_col_0_rd_adr_a[7:0]), 
      .ADRRD_P1_IN(ram_row_35_col_0_rd_adr_b[7:0]), .ADRWR_P0_IN(ram_row_35_col_0_wr_adr_a[7:0]), 
      .ADRWR_P1_IN(ram_row_35_col_0_wr_adr_b[7:0]), .QOUT_P0(ram_row_35_col_0_data_out_a), 
      .QOUT_P1(ram_row_35_col_0_data_out_b), .DIN_P0_IN(ram_row_35_col_0_data_in_a[33:0]), 
      .DIN_P1_IN(ram_row_35_col_0_data_in_b[33:0]), .TCK(to_interfaces_tck), .BIST_CMP(BIST_CMP), 
      .INCLUDE_MEM_RESULTS_REG(INCLUDE_MEM_RESULTS_REG), .BIST_READENABLE(BIST_READENABLE), 
      .BIST_WRITEENABLE(BIST_WRITEENABLE), .BIST_ROW_ADD({BIST_ROW_ADD_ts3, 
      BIST_ROW_ADD_ts2, BIST_ROW_ADD_ts1, BIST_ROW_ADD}), .BIST_BANK_ADD({
      BIST_BANK_ADD_ts3, BIST_BANK_ADD_ts2, BIST_BANK_ADD_ts1, BIST_BANK_ADD}), .BIST_TEST_PORT(BIST_TEST_PORT), 
      .BIST_WRITE_DATA({BIST_WRITE_DATA_ts7, BIST_WRITE_DATA_ts6, 
      BIST_WRITE_DATA_ts5, BIST_WRITE_DATA_ts4, BIST_WRITE_DATA_ts3, 
      BIST_WRITE_DATA_ts2, BIST_WRITE_DATA_ts1, BIST_WRITE_DATA}), .BIST_TESTDATA_SELECT_TO_COLLAR(BIST_TESTDATA_SELECT_TO_COLLAR), 
      .MEM_BYPASS_EN(memory_bypass_to_en), .SCAN_SHIFT_EN(scan_to_en), .MCP_BOUNDING_EN(mcp_bounding_to_en), 
      .BIST_ON(BIST_ON_TO_COLLAR), .BIST_RUN(BIST_RUN_TO_COLLAR28), .BIST_ASYNC_RESETN(BIST_ASYNC_RESET), 
      .BIST_CLK(clk_a), .BIST_SHIFT_COLLAR(BIST_SHIFT_COLLAR), .BIST_EXPECT_DATA({
      BIST_EXPECT_DATA_ts7, BIST_EXPECT_DATA_ts6, BIST_EXPECT_DATA_ts5, 
      BIST_EXPECT_DATA_ts4, BIST_EXPECT_DATA_ts3, BIST_EXPECT_DATA_ts2, 
      BIST_EXPECT_DATA_ts1, BIST_EXPECT_DATA}), .BIST_SI(MEM28_BIST_COLLAR_SI), .BIST_COLLAR_SETUP(BIST_COLLAR_SETUP), 
      .BIST_COLLAR_OPSET_SELECT(BIST_COLLAR_OPSET_SELECT), .BIST_COLLAR_HOLD(BIST_COLLAR_HOLD), 
      .BIST_BIRA_EN(BIST_COLLAR_BIRA_EN), .CHECK_REPAIR_NEEDED(CHECK_REPAIR_NEEDED), 
      .BIST_DIAG_EN(BIST_COLLAR_DIAG_EN), .BIST_CLEAR_DEFAULT(BIST_CLEAR_DEFAULT), 
      .BIST_CLEAR(BIST_CLEAR), .BIST_SETUP2(BIST_SETUP_ts2), .BIST_SETUP1(BIST_SETUP_ts1), 
      .BIST_SETUP0(BIST_SETUP), .LV_TM(ltest_to_en), .FREEZE_STOP_ERROR(FREEZE_STOP_ERROR), 
      .GO_ID_REG_SEL(GO_ID_REG_SEL), .BIST_COLLAR_EN(BIST_COLLAR_EN28), .FROM_BISR_All_SCOL0_FUSE_REG(ram_row_35_col_0_bisr_inst_Q[6:1]), 
      .FROM_BISR_All_SCOL0_ALLOC_REG(ram_row_35_col_0_bisr_inst_Q[0]), .BIST_SHIFT_BIRA_COLLAR(BIST_SHIFT_BIRA_COLLAR), 
      .RESET_REG_SETUP2(MBISTPG_RESET_REG_SETUP2), .ERROR_CNT_ZERO(ERROR_CNT_ZERO), 
      .WREN_P0(WREN_P0_ts28), .WREN_P1(WREN_P1_ts28), .RDEN_P0(RDEN_P0_ts28), .RDEN_P1(RDEN_P1_ts28), 
      .ADRRD_P0(ADRRD_P0_ts28), .ADRRD_P1(ADRRD_P1_ts28), .ADRWR_P0(ADRWR_P0_ts28), 
      .ADRWR_P1(ADRWR_P1_ts28), .DIN_P0(DIN_P0_ts28), .DIN_P1(DIN_P1_ts28), .BIST_SO(BIST_SO_ts28), 
      .BIST_GO(BIST_GO_ts28), .All_SCOL0_FUSE_REG(All_SCOL0_FUSE_REG_ts28[5:0]), 
      .All_SCOL0_ALLOC_REG(All_SCOL0_ALLOC_REG_ts28), .REPAIR_STATUS(), .fscan_clkungate(fscan_clkungate)
  );

  hlp_sched_apr_rtl_tessent_mbist_RF_c3_interface_MEM30 ram_row_36_col_0_interface_inst(
      .BIST_SHADOW_READENABLE(BIST_SHADOW_READENABLE), .BIST_SHADOW_READADDRESS(BIST_SHADOW_READADDRESS), 
      .BIST_CONREAD_ROWADDRESS(BIST_CONREAD_ROWADDRESS), .BIST_CONREAD_ENABLE(BIST_CONREAD_ENABLE), 
      .BIST_CONWRITE_ROWADDRESS(BIST_CONWRITE_ROWADDRESS), .BIST_CONWRITE_ENABLE(BIST_CONWRITE_ENABLE), 
      .BIST_CLEAR_BIRA(BIST_CLEAR_BIRA), .WREN_P0_IN(ram_row_36_col_0_wr_en_a), 
      .WREN_P1_IN(ram_row_36_col_0_wr_en_b), .RDEN_P0_IN(ram_row_36_col_0_rd_en_a), 
      .RDEN_P1_IN(ram_row_36_col_0_rd_en_b), .ADRRD_P0_IN(ram_row_36_col_0_rd_adr_a[7:0]), 
      .ADRRD_P1_IN(ram_row_36_col_0_rd_adr_b[7:0]), .ADRWR_P0_IN(ram_row_36_col_0_wr_adr_a[7:0]), 
      .ADRWR_P1_IN(ram_row_36_col_0_wr_adr_b[7:0]), .QOUT_P0(ram_row_36_col_0_data_out_a), 
      .QOUT_P1(ram_row_36_col_0_data_out_b), .DIN_P0_IN(ram_row_36_col_0_data_in_a[33:0]), 
      .DIN_P1_IN(ram_row_36_col_0_data_in_b[33:0]), .TCK(to_interfaces_tck), .BIST_CMP(BIST_CMP), 
      .INCLUDE_MEM_RESULTS_REG(INCLUDE_MEM_RESULTS_REG), .BIST_READENABLE(BIST_READENABLE), 
      .BIST_WRITEENABLE(BIST_WRITEENABLE), .BIST_ROW_ADD({BIST_ROW_ADD_ts3, 
      BIST_ROW_ADD_ts2, BIST_ROW_ADD_ts1, BIST_ROW_ADD}), .BIST_BANK_ADD({
      BIST_BANK_ADD_ts3, BIST_BANK_ADD_ts2, BIST_BANK_ADD_ts1, BIST_BANK_ADD}), .BIST_TEST_PORT(BIST_TEST_PORT), 
      .BIST_WRITE_DATA({BIST_WRITE_DATA_ts7, BIST_WRITE_DATA_ts6, 
      BIST_WRITE_DATA_ts5, BIST_WRITE_DATA_ts4, BIST_WRITE_DATA_ts3, 
      BIST_WRITE_DATA_ts2, BIST_WRITE_DATA_ts1, BIST_WRITE_DATA}), .BIST_TESTDATA_SELECT_TO_COLLAR(BIST_TESTDATA_SELECT_TO_COLLAR), 
      .MEM_BYPASS_EN(memory_bypass_to_en), .SCAN_SHIFT_EN(scan_to_en), .MCP_BOUNDING_EN(mcp_bounding_to_en), 
      .BIST_ON(BIST_ON_TO_COLLAR), .BIST_RUN(BIST_RUN_TO_COLLAR29), .BIST_ASYNC_RESETN(BIST_ASYNC_RESET), 
      .BIST_CLK(clk_a), .BIST_SHIFT_COLLAR(BIST_SHIFT_COLLAR), .BIST_EXPECT_DATA({
      BIST_EXPECT_DATA_ts7, BIST_EXPECT_DATA_ts6, BIST_EXPECT_DATA_ts5, 
      BIST_EXPECT_DATA_ts4, BIST_EXPECT_DATA_ts3, BIST_EXPECT_DATA_ts2, 
      BIST_EXPECT_DATA_ts1, BIST_EXPECT_DATA}), .BIST_SI(MEM29_BIST_COLLAR_SI), .BIST_COLLAR_SETUP(BIST_COLLAR_SETUP), 
      .BIST_COLLAR_OPSET_SELECT(BIST_COLLAR_OPSET_SELECT), .BIST_COLLAR_HOLD(BIST_COLLAR_HOLD), 
      .BIST_BIRA_EN(BIST_COLLAR_BIRA_EN), .CHECK_REPAIR_NEEDED(CHECK_REPAIR_NEEDED), 
      .BIST_DIAG_EN(BIST_COLLAR_DIAG_EN), .BIST_CLEAR_DEFAULT(BIST_CLEAR_DEFAULT), 
      .BIST_CLEAR(BIST_CLEAR), .BIST_SETUP2(BIST_SETUP_ts2), .BIST_SETUP1(BIST_SETUP_ts1), 
      .BIST_SETUP0(BIST_SETUP), .LV_TM(ltest_to_en), .FREEZE_STOP_ERROR(FREEZE_STOP_ERROR), 
      .GO_ID_REG_SEL(GO_ID_REG_SEL), .BIST_COLLAR_EN(BIST_COLLAR_EN29), .FROM_BISR_All_SCOL0_FUSE_REG(ram_row_36_col_0_bisr_inst_Q[6:1]), 
      .FROM_BISR_All_SCOL0_ALLOC_REG(ram_row_36_col_0_bisr_inst_Q[0]), .BIST_SHIFT_BIRA_COLLAR(BIST_SHIFT_BIRA_COLLAR), 
      .RESET_REG_SETUP2(MBISTPG_RESET_REG_SETUP2), .ERROR_CNT_ZERO(ERROR_CNT_ZERO), 
      .WREN_P0(WREN_P0_ts29), .WREN_P1(WREN_P1_ts29), .RDEN_P0(RDEN_P0_ts29), .RDEN_P1(RDEN_P1_ts29), 
      .ADRRD_P0(ADRRD_P0_ts29), .ADRRD_P1(ADRRD_P1_ts29), .ADRWR_P0(ADRWR_P0_ts29), 
      .ADRWR_P1(ADRWR_P1_ts29), .DIN_P0(DIN_P0_ts29), .DIN_P1(DIN_P1_ts29), .BIST_SO(BIST_SO_ts29), 
      .BIST_GO(BIST_GO_ts29), .All_SCOL0_FUSE_REG(All_SCOL0_FUSE_REG_ts29[5:0]), 
      .All_SCOL0_ALLOC_REG(All_SCOL0_ALLOC_REG_ts29), .REPAIR_STATUS(), .fscan_clkungate(fscan_clkungate)
  );

  hlp_sched_apr_rtl_tessent_mbist_RF_c3_interface_MEM31 ram_row_37_col_0_interface_inst(
      .BIST_SHADOW_READENABLE(BIST_SHADOW_READENABLE), .BIST_SHADOW_READADDRESS(BIST_SHADOW_READADDRESS), 
      .BIST_CONREAD_ROWADDRESS(BIST_CONREAD_ROWADDRESS), .BIST_CONREAD_ENABLE(BIST_CONREAD_ENABLE), 
      .BIST_CONWRITE_ROWADDRESS(BIST_CONWRITE_ROWADDRESS), .BIST_CONWRITE_ENABLE(BIST_CONWRITE_ENABLE), 
      .BIST_CLEAR_BIRA(BIST_CLEAR_BIRA), .WREN_P0_IN(ram_row_37_col_0_wr_en_a), 
      .WREN_P1_IN(ram_row_37_col_0_wr_en_b), .RDEN_P0_IN(ram_row_37_col_0_rd_en_a), 
      .RDEN_P1_IN(ram_row_37_col_0_rd_en_b), .ADRRD_P0_IN(ram_row_37_col_0_rd_adr_a[7:0]), 
      .ADRRD_P1_IN(ram_row_37_col_0_rd_adr_b[7:0]), .ADRWR_P0_IN(ram_row_37_col_0_wr_adr_a[7:0]), 
      .ADRWR_P1_IN(ram_row_37_col_0_wr_adr_b[7:0]), .QOUT_P0(ram_row_37_col_0_data_out_a), 
      .QOUT_P1(ram_row_37_col_0_data_out_b), .DIN_P0_IN(ram_row_37_col_0_data_in_a[33:0]), 
      .DIN_P1_IN(ram_row_37_col_0_data_in_b[33:0]), .TCK(to_interfaces_tck), .BIST_CMP(BIST_CMP), 
      .INCLUDE_MEM_RESULTS_REG(INCLUDE_MEM_RESULTS_REG), .BIST_READENABLE(BIST_READENABLE), 
      .BIST_WRITEENABLE(BIST_WRITEENABLE), .BIST_ROW_ADD({BIST_ROW_ADD_ts3, 
      BIST_ROW_ADD_ts2, BIST_ROW_ADD_ts1, BIST_ROW_ADD}), .BIST_BANK_ADD({
      BIST_BANK_ADD_ts3, BIST_BANK_ADD_ts2, BIST_BANK_ADD_ts1, BIST_BANK_ADD}), .BIST_TEST_PORT(BIST_TEST_PORT), 
      .BIST_WRITE_DATA({BIST_WRITE_DATA_ts7, BIST_WRITE_DATA_ts6, 
      BIST_WRITE_DATA_ts5, BIST_WRITE_DATA_ts4, BIST_WRITE_DATA_ts3, 
      BIST_WRITE_DATA_ts2, BIST_WRITE_DATA_ts1, BIST_WRITE_DATA}), .BIST_TESTDATA_SELECT_TO_COLLAR(BIST_TESTDATA_SELECT_TO_COLLAR), 
      .MEM_BYPASS_EN(memory_bypass_to_en), .SCAN_SHIFT_EN(scan_to_en), .MCP_BOUNDING_EN(mcp_bounding_to_en), 
      .BIST_ON(BIST_ON_TO_COLLAR), .BIST_RUN(BIST_RUN_TO_COLLAR30), .BIST_ASYNC_RESETN(BIST_ASYNC_RESET), 
      .BIST_CLK(clk_a), .BIST_SHIFT_COLLAR(BIST_SHIFT_COLLAR), .BIST_EXPECT_DATA({
      BIST_EXPECT_DATA_ts7, BIST_EXPECT_DATA_ts6, BIST_EXPECT_DATA_ts5, 
      BIST_EXPECT_DATA_ts4, BIST_EXPECT_DATA_ts3, BIST_EXPECT_DATA_ts2, 
      BIST_EXPECT_DATA_ts1, BIST_EXPECT_DATA}), .BIST_SI(MEM30_BIST_COLLAR_SI), .BIST_COLLAR_SETUP(BIST_COLLAR_SETUP), 
      .BIST_COLLAR_OPSET_SELECT(BIST_COLLAR_OPSET_SELECT), .BIST_COLLAR_HOLD(BIST_COLLAR_HOLD), 
      .BIST_BIRA_EN(BIST_COLLAR_BIRA_EN), .CHECK_REPAIR_NEEDED(CHECK_REPAIR_NEEDED), 
      .BIST_DIAG_EN(BIST_COLLAR_DIAG_EN), .BIST_CLEAR_DEFAULT(BIST_CLEAR_DEFAULT), 
      .BIST_CLEAR(BIST_CLEAR), .BIST_SETUP2(BIST_SETUP_ts2), .BIST_SETUP1(BIST_SETUP_ts1), 
      .BIST_SETUP0(BIST_SETUP), .LV_TM(ltest_to_en), .FREEZE_STOP_ERROR(FREEZE_STOP_ERROR), 
      .GO_ID_REG_SEL(GO_ID_REG_SEL), .BIST_COLLAR_EN(BIST_COLLAR_EN30), .FROM_BISR_All_SCOL0_FUSE_REG(ram_row_37_col_0_bisr_inst_Q[6:1]), 
      .FROM_BISR_All_SCOL0_ALLOC_REG(ram_row_37_col_0_bisr_inst_Q[0]), .BIST_SHIFT_BIRA_COLLAR(BIST_SHIFT_BIRA_COLLAR), 
      .RESET_REG_SETUP2(MBISTPG_RESET_REG_SETUP2), .ERROR_CNT_ZERO(ERROR_CNT_ZERO), 
      .WREN_P0(WREN_P0_ts30), .WREN_P1(WREN_P1_ts30), .RDEN_P0(RDEN_P0_ts30), .RDEN_P1(RDEN_P1_ts30), 
      .ADRRD_P0(ADRRD_P0_ts30), .ADRRD_P1(ADRRD_P1_ts30), .ADRWR_P0(ADRWR_P0_ts30), 
      .ADRWR_P1(ADRWR_P1_ts30), .DIN_P0(DIN_P0_ts30), .DIN_P1(DIN_P1_ts30), .BIST_SO(BIST_SO_ts30), 
      .BIST_GO(BIST_GO_ts30), .All_SCOL0_FUSE_REG(All_SCOL0_FUSE_REG_ts30[5:0]), 
      .All_SCOL0_ALLOC_REG(All_SCOL0_ALLOC_REG_ts30), .REPAIR_STATUS(), .fscan_clkungate(fscan_clkungate)
  );

  hlp_sched_apr_rtl_tessent_mbist_RF_c3_interface_MEM32 ram_row_38_col_0_interface_inst(
      .BIST_SHADOW_READENABLE(BIST_SHADOW_READENABLE), .BIST_SHADOW_READADDRESS(BIST_SHADOW_READADDRESS), 
      .BIST_CONREAD_ROWADDRESS(BIST_CONREAD_ROWADDRESS), .BIST_CONREAD_ENABLE(BIST_CONREAD_ENABLE), 
      .BIST_CONWRITE_ROWADDRESS(BIST_CONWRITE_ROWADDRESS), .BIST_CONWRITE_ENABLE(BIST_CONWRITE_ENABLE), 
      .BIST_CLEAR_BIRA(BIST_CLEAR_BIRA), .WREN_P0_IN(ram_row_38_col_0_wr_en_a), 
      .WREN_P1_IN(ram_row_38_col_0_wr_en_b), .RDEN_P0_IN(ram_row_38_col_0_rd_en_a), 
      .RDEN_P1_IN(ram_row_38_col_0_rd_en_b), .ADRRD_P0_IN(ram_row_38_col_0_rd_adr_a[7:0]), 
      .ADRRD_P1_IN(ram_row_38_col_0_rd_adr_b[7:0]), .ADRWR_P0_IN(ram_row_38_col_0_wr_adr_a[7:0]), 
      .ADRWR_P1_IN(ram_row_38_col_0_wr_adr_b[7:0]), .QOUT_P0(ram_row_38_col_0_data_out_a), 
      .QOUT_P1(ram_row_38_col_0_data_out_b), .DIN_P0_IN(ram_row_38_col_0_data_in_a[33:0]), 
      .DIN_P1_IN(ram_row_38_col_0_data_in_b[33:0]), .TCK(to_interfaces_tck), .BIST_CMP(BIST_CMP), 
      .INCLUDE_MEM_RESULTS_REG(INCLUDE_MEM_RESULTS_REG), .BIST_READENABLE(BIST_READENABLE), 
      .BIST_WRITEENABLE(BIST_WRITEENABLE), .BIST_ROW_ADD({BIST_ROW_ADD_ts3, 
      BIST_ROW_ADD_ts2, BIST_ROW_ADD_ts1, BIST_ROW_ADD}), .BIST_BANK_ADD({
      BIST_BANK_ADD_ts3, BIST_BANK_ADD_ts2, BIST_BANK_ADD_ts1, BIST_BANK_ADD}), .BIST_TEST_PORT(BIST_TEST_PORT), 
      .BIST_WRITE_DATA({BIST_WRITE_DATA_ts7, BIST_WRITE_DATA_ts6, 
      BIST_WRITE_DATA_ts5, BIST_WRITE_DATA_ts4, BIST_WRITE_DATA_ts3, 
      BIST_WRITE_DATA_ts2, BIST_WRITE_DATA_ts1, BIST_WRITE_DATA}), .BIST_TESTDATA_SELECT_TO_COLLAR(BIST_TESTDATA_SELECT_TO_COLLAR), 
      .MEM_BYPASS_EN(memory_bypass_to_en), .SCAN_SHIFT_EN(scan_to_en), .MCP_BOUNDING_EN(mcp_bounding_to_en), 
      .BIST_ON(BIST_ON_TO_COLLAR), .BIST_RUN(BIST_RUN_TO_COLLAR31), .BIST_ASYNC_RESETN(BIST_ASYNC_RESET), 
      .BIST_CLK(clk_a), .BIST_SHIFT_COLLAR(BIST_SHIFT_COLLAR), .BIST_EXPECT_DATA({
      BIST_EXPECT_DATA_ts7, BIST_EXPECT_DATA_ts6, BIST_EXPECT_DATA_ts5, 
      BIST_EXPECT_DATA_ts4, BIST_EXPECT_DATA_ts3, BIST_EXPECT_DATA_ts2, 
      BIST_EXPECT_DATA_ts1, BIST_EXPECT_DATA}), .BIST_SI(MEM31_BIST_COLLAR_SI), .BIST_COLLAR_SETUP(BIST_COLLAR_SETUP), 
      .BIST_COLLAR_OPSET_SELECT(BIST_COLLAR_OPSET_SELECT), .BIST_COLLAR_HOLD(BIST_COLLAR_HOLD), 
      .BIST_BIRA_EN(BIST_COLLAR_BIRA_EN), .CHECK_REPAIR_NEEDED(CHECK_REPAIR_NEEDED), 
      .BIST_DIAG_EN(BIST_COLLAR_DIAG_EN), .BIST_CLEAR_DEFAULT(BIST_CLEAR_DEFAULT), 
      .BIST_CLEAR(BIST_CLEAR), .BIST_SETUP2(BIST_SETUP_ts2), .BIST_SETUP1(BIST_SETUP_ts1), 
      .BIST_SETUP0(BIST_SETUP), .LV_TM(ltest_to_en), .FREEZE_STOP_ERROR(FREEZE_STOP_ERROR), 
      .GO_ID_REG_SEL(GO_ID_REG_SEL), .BIST_COLLAR_EN(BIST_COLLAR_EN31), .FROM_BISR_All_SCOL0_FUSE_REG(ram_row_38_col_0_bisr_inst_Q[6:1]), 
      .FROM_BISR_All_SCOL0_ALLOC_REG(ram_row_38_col_0_bisr_inst_Q[0]), .BIST_SHIFT_BIRA_COLLAR(BIST_SHIFT_BIRA_COLLAR), 
      .RESET_REG_SETUP2(MBISTPG_RESET_REG_SETUP2), .ERROR_CNT_ZERO(ERROR_CNT_ZERO), 
      .WREN_P0(WREN_P0_ts31), .WREN_P1(WREN_P1_ts31), .RDEN_P0(RDEN_P0_ts31), .RDEN_P1(RDEN_P1_ts31), 
      .ADRRD_P0(ADRRD_P0_ts31), .ADRRD_P1(ADRRD_P1_ts31), .ADRWR_P0(ADRWR_P0_ts31), 
      .ADRWR_P1(ADRWR_P1_ts31), .DIN_P0(DIN_P0_ts31), .DIN_P1(DIN_P1_ts31), .BIST_SO(BIST_SO_ts31), 
      .BIST_GO(BIST_GO_ts31), .All_SCOL0_FUSE_REG(All_SCOL0_FUSE_REG_ts31[5:0]), 
      .All_SCOL0_ALLOC_REG(All_SCOL0_ALLOC_REG_ts31), .REPAIR_STATUS(), .fscan_clkungate(fscan_clkungate)
  );

  hlp_sched_apr_rtl_tessent_mbist_RF_c4_interface_MEM1 ram_row_39_col_0_interface_inst(
      .BIST_SHADOW_READENABLE(BIST_SHADOW_READENABLE_ts1), .BIST_SHADOW_READADDRESS(BIST_SHADOW_READADDRESS_ts1), 
      .BIST_CONREAD_ROWADDRESS(BIST_CONREAD_ROWADDRESS_ts1), .BIST_CONREAD_ENABLE(BIST_CONREAD_ENABLE_ts1), 
      .BIST_CONWRITE_ROWADDRESS(BIST_CONWRITE_ROWADDRESS_ts1), .BIST_CONWRITE_ENABLE(BIST_CONWRITE_ENABLE_ts1), 
      .BIST_CLEAR_BIRA(BIST_CLEAR_BIRA_ts1), .WREN_P0_IN(ram_row_39_col_0_wr_en_a), 
      .WREN_P1_IN(ram_row_39_col_0_wr_en_b), .RDEN_P0_IN(ram_row_39_col_0_rd_en_a), 
      .RDEN_P1_IN(ram_row_39_col_0_rd_en_b), .ADRRD_P0_IN(ram_row_39_col_0_rd_adr_a[7:0]), 
      .ADRRD_P1_IN(ram_row_39_col_0_rd_adr_b[7:0]), .ADRWR_P0_IN(ram_row_39_col_0_wr_adr_a[7:0]), 
      .ADRWR_P1_IN(ram_row_39_col_0_wr_adr_b[7:0]), .QOUT_P0(ram_row_39_col_0_data_out_a), 
      .QOUT_P1(ram_row_39_col_0_data_out_b), .DIN_P0_IN(ram_row_39_col_0_data_in_a[33:0]), 
      .DIN_P1_IN(ram_row_39_col_0_data_in_b[33:0]), .TCK(to_interfaces_tck), .BIST_CMP(BIST_CMP_ts1), 
      .INCLUDE_MEM_RESULTS_REG(INCLUDE_MEM_RESULTS_REG), .BIST_READENABLE(BIST_READENABLE_ts1), 
      .BIST_WRITEENABLE(BIST_WRITEENABLE_ts1), .BIST_ROW_ADD({
      BIST_ROW_ADD_ts7, BIST_ROW_ADD_ts6, BIST_ROW_ADD_ts5, BIST_ROW_ADD_ts4}), .BIST_BANK_ADD({
      BIST_BANK_ADD_ts7, BIST_BANK_ADD_ts6, BIST_BANK_ADD_ts5, 
      BIST_BANK_ADD_ts4}), .BIST_TEST_PORT(BIST_TEST_PORT_ts1), .BIST_WRITE_DATA({
      BIST_WRITE_DATA_ts15, BIST_WRITE_DATA_ts14, BIST_WRITE_DATA_ts13, 
      BIST_WRITE_DATA_ts12, BIST_WRITE_DATA_ts11, BIST_WRITE_DATA_ts10, 
      BIST_WRITE_DATA_ts9, BIST_WRITE_DATA_ts8}), .BIST_TESTDATA_SELECT_TO_COLLAR(BIST_TESTDATA_SELECT_TO_COLLAR_ts1), 
      .MEM_BYPASS_EN(memory_bypass_to_en), .SCAN_SHIFT_EN(scan_to_en), .MCP_BOUNDING_EN(mcp_bounding_to_en), 
      .BIST_ON(BIST_ON_TO_COLLAR_ts1), .BIST_RUN(BIST_RUN_TO_COLLAR0_ts1), .BIST_ASYNC_RESETN(BIST_ASYNC_RESET), 
      .BIST_CLK(clk_a), .BIST_SHIFT_COLLAR(BIST_SHIFT_COLLAR_ts1), .BIST_EXPECT_DATA({
      BIST_EXPECT_DATA_ts15, BIST_EXPECT_DATA_ts14, BIST_EXPECT_DATA_ts13, 
      BIST_EXPECT_DATA_ts12, BIST_EXPECT_DATA_ts11, BIST_EXPECT_DATA_ts10, 
      BIST_EXPECT_DATA_ts9, BIST_EXPECT_DATA_ts8}), .BIST_SI(MEM0_BIST_COLLAR_SI_ts1), 
      .BIST_COLLAR_SETUP(BIST_COLLAR_SETUP_ts1), .BIST_COLLAR_OPSET_SELECT(BIST_COLLAR_OPSET_SELECT_ts1), 
      .BIST_COLLAR_HOLD(BIST_COLLAR_HOLD_ts1), .BIST_BIRA_EN(BIST_COLLAR_BIRA_EN_ts1), 
      .CHECK_REPAIR_NEEDED(CHECK_REPAIR_NEEDED), .BIST_DIAG_EN(BIST_COLLAR_DIAG_EN_ts1), 
      .BIST_CLEAR_DEFAULT(BIST_CLEAR_DEFAULT_ts1), .BIST_CLEAR(BIST_CLEAR_ts1), 
      .BIST_SETUP2(BIST_SETUP_ts2), .BIST_SETUP1(BIST_SETUP_ts1), .BIST_SETUP0(BIST_SETUP), 
      .LV_TM(ltest_to_en), .FREEZE_STOP_ERROR(FREEZE_STOP_ERROR_ts1), .GO_ID_REG_SEL(GO_ID_REG_SEL_ts1), 
      .BIST_COLLAR_EN(BIST_COLLAR_EN0_ts1), .FROM_BISR_All_SCOL0_FUSE_REG(ram_row_39_col_0_bisr_inst_Q[6:1]), 
      .FROM_BISR_All_SCOL0_ALLOC_REG(ram_row_39_col_0_bisr_inst_Q[0]), .BIST_SHIFT_BIRA_COLLAR(BIST_SHIFT_BIRA_COLLAR_ts1), 
      .RESET_REG_SETUP2(MBISTPG_RESET_REG_SETUP2_ts1), .ERROR_CNT_ZERO(ERROR_CNT_ZERO_ts1), 
      .WREN_P0(WREN_P0_ts32), .WREN_P1(WREN_P1_ts32), .RDEN_P0(RDEN_P0_ts32), .RDEN_P1(RDEN_P1_ts32), 
      .ADRRD_P0(ADRRD_P0_ts32), .ADRRD_P1(ADRRD_P1_ts32), .ADRWR_P0(ADRWR_P0_ts32), 
      .ADRWR_P1(ADRWR_P1_ts32), .DIN_P0(DIN_P0_ts32), .DIN_P1(DIN_P1_ts32), .BIST_SO(BIST_SO_ts32), 
      .BIST_GO(BIST_GO_ts32), .All_SCOL0_FUSE_REG(All_SCOL0_FUSE_REG_ts32[5:0]), 
      .All_SCOL0_ALLOC_REG(All_SCOL0_ALLOC_REG_ts32), .REPAIR_STATUS(), .fscan_clkungate(fscan_clkungate)
  );

  hlp_sched_apr_rtl_tessent_mbist_RF_c4_interface_MEM2 ram_row_3_col_0_interface_inst(
      .BIST_SHADOW_READENABLE(BIST_SHADOW_READENABLE_ts1), .BIST_SHADOW_READADDRESS(BIST_SHADOW_READADDRESS_ts1), 
      .BIST_CONREAD_ROWADDRESS(BIST_CONREAD_ROWADDRESS_ts1), .BIST_CONREAD_ENABLE(BIST_CONREAD_ENABLE_ts1), 
      .BIST_CONWRITE_ROWADDRESS(BIST_CONWRITE_ROWADDRESS_ts1), .BIST_CONWRITE_ENABLE(BIST_CONWRITE_ENABLE_ts1), 
      .BIST_CLEAR_BIRA(BIST_CLEAR_BIRA_ts1), .WREN_P0_IN(ram_row_3_col_0_wr_en_a), 
      .WREN_P1_IN(ram_row_3_col_0_wr_en_b), .RDEN_P0_IN(ram_row_3_col_0_rd_en_a), 
      .RDEN_P1_IN(ram_row_3_col_0_rd_en_b), .ADRRD_P0_IN(ram_row_3_col_0_rd_adr_a[7:0]), 
      .ADRRD_P1_IN(ram_row_3_col_0_rd_adr_b[7:0]), .ADRWR_P0_IN(ram_row_3_col_0_wr_adr_a[7:0]), 
      .ADRWR_P1_IN(ram_row_3_col_0_wr_adr_b[7:0]), .QOUT_P0(ram_row_3_col_0_data_out_a), 
      .QOUT_P1(ram_row_3_col_0_data_out_b), .DIN_P0_IN(ram_row_3_col_0_data_in_a[33:0]), 
      .DIN_P1_IN(ram_row_3_col_0_data_in_b[33:0]), .TCK(to_interfaces_tck), .BIST_CMP(BIST_CMP_ts1), 
      .INCLUDE_MEM_RESULTS_REG(INCLUDE_MEM_RESULTS_REG), .BIST_READENABLE(BIST_READENABLE_ts1), 
      .BIST_WRITEENABLE(BIST_WRITEENABLE_ts1), .BIST_ROW_ADD({
      BIST_ROW_ADD_ts7, BIST_ROW_ADD_ts6, BIST_ROW_ADD_ts5, BIST_ROW_ADD_ts4}), .BIST_BANK_ADD({
      BIST_BANK_ADD_ts7, BIST_BANK_ADD_ts6, BIST_BANK_ADD_ts5, 
      BIST_BANK_ADD_ts4}), .BIST_TEST_PORT(BIST_TEST_PORT_ts1), .BIST_WRITE_DATA({
      BIST_WRITE_DATA_ts15, BIST_WRITE_DATA_ts14, BIST_WRITE_DATA_ts13, 
      BIST_WRITE_DATA_ts12, BIST_WRITE_DATA_ts11, BIST_WRITE_DATA_ts10, 
      BIST_WRITE_DATA_ts9, BIST_WRITE_DATA_ts8}), .BIST_TESTDATA_SELECT_TO_COLLAR(BIST_TESTDATA_SELECT_TO_COLLAR_ts1), 
      .MEM_BYPASS_EN(memory_bypass_to_en), .SCAN_SHIFT_EN(scan_to_en), .MCP_BOUNDING_EN(mcp_bounding_to_en), 
      .BIST_ON(BIST_ON_TO_COLLAR_ts1), .BIST_RUN(BIST_RUN_TO_COLLAR1_ts1), .BIST_ASYNC_RESETN(BIST_ASYNC_RESET), 
      .BIST_CLK(clk_a), .BIST_SHIFT_COLLAR(BIST_SHIFT_COLLAR_ts1), .BIST_EXPECT_DATA({
      BIST_EXPECT_DATA_ts15, BIST_EXPECT_DATA_ts14, BIST_EXPECT_DATA_ts13, 
      BIST_EXPECT_DATA_ts12, BIST_EXPECT_DATA_ts11, BIST_EXPECT_DATA_ts10, 
      BIST_EXPECT_DATA_ts9, BIST_EXPECT_DATA_ts8}), .BIST_SI(MEM1_BIST_COLLAR_SI_ts1), 
      .BIST_COLLAR_SETUP(BIST_COLLAR_SETUP_ts1), .BIST_COLLAR_OPSET_SELECT(BIST_COLLAR_OPSET_SELECT_ts1), 
      .BIST_COLLAR_HOLD(BIST_COLLAR_HOLD_ts1), .BIST_BIRA_EN(BIST_COLLAR_BIRA_EN_ts1), 
      .CHECK_REPAIR_NEEDED(CHECK_REPAIR_NEEDED), .BIST_DIAG_EN(BIST_COLLAR_DIAG_EN_ts1), 
      .BIST_CLEAR_DEFAULT(BIST_CLEAR_DEFAULT_ts1), .BIST_CLEAR(BIST_CLEAR_ts1), 
      .BIST_SETUP2(BIST_SETUP_ts2), .BIST_SETUP1(BIST_SETUP_ts1), .BIST_SETUP0(BIST_SETUP), 
      .LV_TM(ltest_to_en), .FREEZE_STOP_ERROR(FREEZE_STOP_ERROR_ts1), .GO_ID_REG_SEL(GO_ID_REG_SEL_ts1), 
      .BIST_COLLAR_EN(BIST_COLLAR_EN1_ts1), .FROM_BISR_All_SCOL0_FUSE_REG(ram_row_3_col_0_bisr_inst_Q[6:1]), 
      .FROM_BISR_All_SCOL0_ALLOC_REG(ram_row_3_col_0_bisr_inst_Q[0]), .BIST_SHIFT_BIRA_COLLAR(BIST_SHIFT_BIRA_COLLAR_ts1), 
      .RESET_REG_SETUP2(MBISTPG_RESET_REG_SETUP2_ts1), .ERROR_CNT_ZERO(ERROR_CNT_ZERO_ts1), 
      .WREN_P0(WREN_P0_ts33), .WREN_P1(WREN_P1_ts33), .RDEN_P0(RDEN_P0_ts33), .RDEN_P1(RDEN_P1_ts33), 
      .ADRRD_P0(ADRRD_P0_ts33), .ADRRD_P1(ADRRD_P1_ts33), .ADRWR_P0(ADRWR_P0_ts33), 
      .ADRWR_P1(ADRWR_P1_ts33), .DIN_P0(DIN_P0_ts33), .DIN_P1(DIN_P1_ts33), .BIST_SO(BIST_SO_ts33), 
      .BIST_GO(BIST_GO_ts33), .All_SCOL0_FUSE_REG(All_SCOL0_FUSE_REG_ts33[5:0]), 
      .All_SCOL0_ALLOC_REG(All_SCOL0_ALLOC_REG_ts33), .REPAIR_STATUS(), .fscan_clkungate(fscan_clkungate)
  );

  hlp_sched_apr_rtl_tessent_mbist_RF_c4_interface_MEM3 ram_row_40_col_0_interface_inst(
      .BIST_SHADOW_READENABLE(BIST_SHADOW_READENABLE_ts1), .BIST_SHADOW_READADDRESS(BIST_SHADOW_READADDRESS_ts1), 
      .BIST_CONREAD_ROWADDRESS(BIST_CONREAD_ROWADDRESS_ts1), .BIST_CONREAD_ENABLE(BIST_CONREAD_ENABLE_ts1), 
      .BIST_CONWRITE_ROWADDRESS(BIST_CONWRITE_ROWADDRESS_ts1), .BIST_CONWRITE_ENABLE(BIST_CONWRITE_ENABLE_ts1), 
      .BIST_CLEAR_BIRA(BIST_CLEAR_BIRA_ts1), .WREN_P0_IN(ram_row_40_col_0_wr_en_a), 
      .WREN_P1_IN(ram_row_40_col_0_wr_en_b), .RDEN_P0_IN(ram_row_40_col_0_rd_en_a), 
      .RDEN_P1_IN(ram_row_40_col_0_rd_en_b), .ADRRD_P0_IN(ram_row_40_col_0_rd_adr_a[7:0]), 
      .ADRRD_P1_IN(ram_row_40_col_0_rd_adr_b[7:0]), .ADRWR_P0_IN(ram_row_40_col_0_wr_adr_a[7:0]), 
      .ADRWR_P1_IN(ram_row_40_col_0_wr_adr_b[7:0]), .QOUT_P0(ram_row_40_col_0_data_out_a), 
      .QOUT_P1(ram_row_40_col_0_data_out_b), .DIN_P0_IN(ram_row_40_col_0_data_in_a[33:0]), 
      .DIN_P1_IN(ram_row_40_col_0_data_in_b[33:0]), .TCK(to_interfaces_tck), .BIST_CMP(BIST_CMP_ts1), 
      .INCLUDE_MEM_RESULTS_REG(INCLUDE_MEM_RESULTS_REG), .BIST_READENABLE(BIST_READENABLE_ts1), 
      .BIST_WRITEENABLE(BIST_WRITEENABLE_ts1), .BIST_ROW_ADD({
      BIST_ROW_ADD_ts7, BIST_ROW_ADD_ts6, BIST_ROW_ADD_ts5, BIST_ROW_ADD_ts4}), .BIST_BANK_ADD({
      BIST_BANK_ADD_ts7, BIST_BANK_ADD_ts6, BIST_BANK_ADD_ts5, 
      BIST_BANK_ADD_ts4}), .BIST_TEST_PORT(BIST_TEST_PORT_ts1), .BIST_WRITE_DATA({
      BIST_WRITE_DATA_ts15, BIST_WRITE_DATA_ts14, BIST_WRITE_DATA_ts13, 
      BIST_WRITE_DATA_ts12, BIST_WRITE_DATA_ts11, BIST_WRITE_DATA_ts10, 
      BIST_WRITE_DATA_ts9, BIST_WRITE_DATA_ts8}), .BIST_TESTDATA_SELECT_TO_COLLAR(BIST_TESTDATA_SELECT_TO_COLLAR_ts1), 
      .MEM_BYPASS_EN(memory_bypass_to_en), .SCAN_SHIFT_EN(scan_to_en), .MCP_BOUNDING_EN(mcp_bounding_to_en), 
      .BIST_ON(BIST_ON_TO_COLLAR_ts1), .BIST_RUN(BIST_RUN_TO_COLLAR2_ts1), .BIST_ASYNC_RESETN(BIST_ASYNC_RESET), 
      .BIST_CLK(clk_a), .BIST_SHIFT_COLLAR(BIST_SHIFT_COLLAR_ts1), .BIST_EXPECT_DATA({
      BIST_EXPECT_DATA_ts15, BIST_EXPECT_DATA_ts14, BIST_EXPECT_DATA_ts13, 
      BIST_EXPECT_DATA_ts12, BIST_EXPECT_DATA_ts11, BIST_EXPECT_DATA_ts10, 
      BIST_EXPECT_DATA_ts9, BIST_EXPECT_DATA_ts8}), .BIST_SI(MEM2_BIST_COLLAR_SI_ts1), 
      .BIST_COLLAR_SETUP(BIST_COLLAR_SETUP_ts1), .BIST_COLLAR_OPSET_SELECT(BIST_COLLAR_OPSET_SELECT_ts1), 
      .BIST_COLLAR_HOLD(BIST_COLLAR_HOLD_ts1), .BIST_BIRA_EN(BIST_COLLAR_BIRA_EN_ts1), 
      .CHECK_REPAIR_NEEDED(CHECK_REPAIR_NEEDED), .BIST_DIAG_EN(BIST_COLLAR_DIAG_EN_ts1), 
      .BIST_CLEAR_DEFAULT(BIST_CLEAR_DEFAULT_ts1), .BIST_CLEAR(BIST_CLEAR_ts1), 
      .BIST_SETUP2(BIST_SETUP_ts2), .BIST_SETUP1(BIST_SETUP_ts1), .BIST_SETUP0(BIST_SETUP), 
      .LV_TM(ltest_to_en), .FREEZE_STOP_ERROR(FREEZE_STOP_ERROR_ts1), .GO_ID_REG_SEL(GO_ID_REG_SEL_ts1), 
      .BIST_COLLAR_EN(BIST_COLLAR_EN2_ts1), .FROM_BISR_All_SCOL0_FUSE_REG(ram_row_40_col_0_bisr_inst_Q[6:1]), 
      .FROM_BISR_All_SCOL0_ALLOC_REG(ram_row_40_col_0_bisr_inst_Q[0]), .BIST_SHIFT_BIRA_COLLAR(BIST_SHIFT_BIRA_COLLAR_ts1), 
      .RESET_REG_SETUP2(MBISTPG_RESET_REG_SETUP2_ts1), .ERROR_CNT_ZERO(ERROR_CNT_ZERO_ts1), 
      .WREN_P0(WREN_P0_ts34), .WREN_P1(WREN_P1_ts34), .RDEN_P0(RDEN_P0_ts34), .RDEN_P1(RDEN_P1_ts34), 
      .ADRRD_P0(ADRRD_P0_ts34), .ADRRD_P1(ADRRD_P1_ts34), .ADRWR_P0(ADRWR_P0_ts34), 
      .ADRWR_P1(ADRWR_P1_ts34), .DIN_P0(DIN_P0_ts34), .DIN_P1(DIN_P1_ts34), .BIST_SO(BIST_SO_ts34), 
      .BIST_GO(BIST_GO_ts34), .All_SCOL0_FUSE_REG(All_SCOL0_FUSE_REG_ts34[5:0]), 
      .All_SCOL0_ALLOC_REG(All_SCOL0_ALLOC_REG_ts34), .REPAIR_STATUS(), .fscan_clkungate(fscan_clkungate)
  );

  hlp_sched_apr_rtl_tessent_mbist_RF_c4_interface_MEM4 ram_row_41_col_0_interface_inst(
      .BIST_SHADOW_READENABLE(BIST_SHADOW_READENABLE_ts1), .BIST_SHADOW_READADDRESS(BIST_SHADOW_READADDRESS_ts1), 
      .BIST_CONREAD_ROWADDRESS(BIST_CONREAD_ROWADDRESS_ts1), .BIST_CONREAD_ENABLE(BIST_CONREAD_ENABLE_ts1), 
      .BIST_CONWRITE_ROWADDRESS(BIST_CONWRITE_ROWADDRESS_ts1), .BIST_CONWRITE_ENABLE(BIST_CONWRITE_ENABLE_ts1), 
      .BIST_CLEAR_BIRA(BIST_CLEAR_BIRA_ts1), .WREN_P0_IN(ram_row_41_col_0_wr_en_a), 
      .WREN_P1_IN(ram_row_41_col_0_wr_en_b), .RDEN_P0_IN(ram_row_41_col_0_rd_en_a), 
      .RDEN_P1_IN(ram_row_41_col_0_rd_en_b), .ADRRD_P0_IN(ram_row_41_col_0_rd_adr_a[7:0]), 
      .ADRRD_P1_IN(ram_row_41_col_0_rd_adr_b[7:0]), .ADRWR_P0_IN(ram_row_41_col_0_wr_adr_a[7:0]), 
      .ADRWR_P1_IN(ram_row_41_col_0_wr_adr_b[7:0]), .QOUT_P0(ram_row_41_col_0_data_out_a), 
      .QOUT_P1(ram_row_41_col_0_data_out_b), .DIN_P0_IN(ram_row_41_col_0_data_in_a[33:0]), 
      .DIN_P1_IN(ram_row_41_col_0_data_in_b[33:0]), .TCK(to_interfaces_tck), .BIST_CMP(BIST_CMP_ts1), 
      .INCLUDE_MEM_RESULTS_REG(INCLUDE_MEM_RESULTS_REG), .BIST_READENABLE(BIST_READENABLE_ts1), 
      .BIST_WRITEENABLE(BIST_WRITEENABLE_ts1), .BIST_ROW_ADD({
      BIST_ROW_ADD_ts7, BIST_ROW_ADD_ts6, BIST_ROW_ADD_ts5, BIST_ROW_ADD_ts4}), .BIST_BANK_ADD({
      BIST_BANK_ADD_ts7, BIST_BANK_ADD_ts6, BIST_BANK_ADD_ts5, 
      BIST_BANK_ADD_ts4}), .BIST_TEST_PORT(BIST_TEST_PORT_ts1), .BIST_WRITE_DATA({
      BIST_WRITE_DATA_ts15, BIST_WRITE_DATA_ts14, BIST_WRITE_DATA_ts13, 
      BIST_WRITE_DATA_ts12, BIST_WRITE_DATA_ts11, BIST_WRITE_DATA_ts10, 
      BIST_WRITE_DATA_ts9, BIST_WRITE_DATA_ts8}), .BIST_TESTDATA_SELECT_TO_COLLAR(BIST_TESTDATA_SELECT_TO_COLLAR_ts1), 
      .MEM_BYPASS_EN(memory_bypass_to_en), .SCAN_SHIFT_EN(scan_to_en), .MCP_BOUNDING_EN(mcp_bounding_to_en), 
      .BIST_ON(BIST_ON_TO_COLLAR_ts1), .BIST_RUN(BIST_RUN_TO_COLLAR3_ts1), .BIST_ASYNC_RESETN(BIST_ASYNC_RESET), 
      .BIST_CLK(clk_a), .BIST_SHIFT_COLLAR(BIST_SHIFT_COLLAR_ts1), .BIST_EXPECT_DATA({
      BIST_EXPECT_DATA_ts15, BIST_EXPECT_DATA_ts14, BIST_EXPECT_DATA_ts13, 
      BIST_EXPECT_DATA_ts12, BIST_EXPECT_DATA_ts11, BIST_EXPECT_DATA_ts10, 
      BIST_EXPECT_DATA_ts9, BIST_EXPECT_DATA_ts8}), .BIST_SI(MEM3_BIST_COLLAR_SI_ts1), 
      .BIST_COLLAR_SETUP(BIST_COLLAR_SETUP_ts1), .BIST_COLLAR_OPSET_SELECT(BIST_COLLAR_OPSET_SELECT_ts1), 
      .BIST_COLLAR_HOLD(BIST_COLLAR_HOLD_ts1), .BIST_BIRA_EN(BIST_COLLAR_BIRA_EN_ts1), 
      .CHECK_REPAIR_NEEDED(CHECK_REPAIR_NEEDED), .BIST_DIAG_EN(BIST_COLLAR_DIAG_EN_ts1), 
      .BIST_CLEAR_DEFAULT(BIST_CLEAR_DEFAULT_ts1), .BIST_CLEAR(BIST_CLEAR_ts1), 
      .BIST_SETUP2(BIST_SETUP_ts2), .BIST_SETUP1(BIST_SETUP_ts1), .BIST_SETUP0(BIST_SETUP), 
      .LV_TM(ltest_to_en), .FREEZE_STOP_ERROR(FREEZE_STOP_ERROR_ts1), .GO_ID_REG_SEL(GO_ID_REG_SEL_ts1), 
      .BIST_COLLAR_EN(BIST_COLLAR_EN3_ts1), .FROM_BISR_All_SCOL0_FUSE_REG(ram_row_41_col_0_bisr_inst_Q[6:1]), 
      .FROM_BISR_All_SCOL0_ALLOC_REG(ram_row_41_col_0_bisr_inst_Q[0]), .BIST_SHIFT_BIRA_COLLAR(BIST_SHIFT_BIRA_COLLAR_ts1), 
      .RESET_REG_SETUP2(MBISTPG_RESET_REG_SETUP2_ts1), .ERROR_CNT_ZERO(ERROR_CNT_ZERO_ts1), 
      .WREN_P0(WREN_P0_ts35), .WREN_P1(WREN_P1_ts35), .RDEN_P0(RDEN_P0_ts35), .RDEN_P1(RDEN_P1_ts35), 
      .ADRRD_P0(ADRRD_P0_ts35), .ADRRD_P1(ADRRD_P1_ts35), .ADRWR_P0(ADRWR_P0_ts35), 
      .ADRWR_P1(ADRWR_P1_ts35), .DIN_P0(DIN_P0_ts35), .DIN_P1(DIN_P1_ts35), .BIST_SO(BIST_SO_ts35), 
      .BIST_GO(BIST_GO_ts35), .All_SCOL0_FUSE_REG(All_SCOL0_FUSE_REG_ts35[5:0]), 
      .All_SCOL0_ALLOC_REG(All_SCOL0_ALLOC_REG_ts35), .REPAIR_STATUS(), .fscan_clkungate(fscan_clkungate)
  );

  hlp_sched_apr_rtl_tessent_mbist_RF_c4_interface_MEM5 ram_row_42_col_0_interface_inst(
      .BIST_SHADOW_READENABLE(BIST_SHADOW_READENABLE_ts1), .BIST_SHADOW_READADDRESS(BIST_SHADOW_READADDRESS_ts1), 
      .BIST_CONREAD_ROWADDRESS(BIST_CONREAD_ROWADDRESS_ts1), .BIST_CONREAD_ENABLE(BIST_CONREAD_ENABLE_ts1), 
      .BIST_CONWRITE_ROWADDRESS(BIST_CONWRITE_ROWADDRESS_ts1), .BIST_CONWRITE_ENABLE(BIST_CONWRITE_ENABLE_ts1), 
      .BIST_CLEAR_BIRA(BIST_CLEAR_BIRA_ts1), .WREN_P0_IN(ram_row_42_col_0_wr_en_a), 
      .WREN_P1_IN(ram_row_42_col_0_wr_en_b), .RDEN_P0_IN(ram_row_42_col_0_rd_en_a), 
      .RDEN_P1_IN(ram_row_42_col_0_rd_en_b), .ADRRD_P0_IN(ram_row_42_col_0_rd_adr_a[7:0]), 
      .ADRRD_P1_IN(ram_row_42_col_0_rd_adr_b[7:0]), .ADRWR_P0_IN(ram_row_42_col_0_wr_adr_a[7:0]), 
      .ADRWR_P1_IN(ram_row_42_col_0_wr_adr_b[7:0]), .QOUT_P0(ram_row_42_col_0_data_out_a), 
      .QOUT_P1(ram_row_42_col_0_data_out_b), .DIN_P0_IN(ram_row_42_col_0_data_in_a[33:0]), 
      .DIN_P1_IN(ram_row_42_col_0_data_in_b[33:0]), .TCK(to_interfaces_tck), .BIST_CMP(BIST_CMP_ts1), 
      .INCLUDE_MEM_RESULTS_REG(INCLUDE_MEM_RESULTS_REG), .BIST_READENABLE(BIST_READENABLE_ts1), 
      .BIST_WRITEENABLE(BIST_WRITEENABLE_ts1), .BIST_ROW_ADD({
      BIST_ROW_ADD_ts7, BIST_ROW_ADD_ts6, BIST_ROW_ADD_ts5, BIST_ROW_ADD_ts4}), .BIST_BANK_ADD({
      BIST_BANK_ADD_ts7, BIST_BANK_ADD_ts6, BIST_BANK_ADD_ts5, 
      BIST_BANK_ADD_ts4}), .BIST_TEST_PORT(BIST_TEST_PORT_ts1), .BIST_WRITE_DATA({
      BIST_WRITE_DATA_ts15, BIST_WRITE_DATA_ts14, BIST_WRITE_DATA_ts13, 
      BIST_WRITE_DATA_ts12, BIST_WRITE_DATA_ts11, BIST_WRITE_DATA_ts10, 
      BIST_WRITE_DATA_ts9, BIST_WRITE_DATA_ts8}), .BIST_TESTDATA_SELECT_TO_COLLAR(BIST_TESTDATA_SELECT_TO_COLLAR_ts1), 
      .MEM_BYPASS_EN(memory_bypass_to_en), .SCAN_SHIFT_EN(scan_to_en), .MCP_BOUNDING_EN(mcp_bounding_to_en), 
      .BIST_ON(BIST_ON_TO_COLLAR_ts1), .BIST_RUN(BIST_RUN_TO_COLLAR4_ts1), .BIST_ASYNC_RESETN(BIST_ASYNC_RESET), 
      .BIST_CLK(clk_a), .BIST_SHIFT_COLLAR(BIST_SHIFT_COLLAR_ts1), .BIST_EXPECT_DATA({
      BIST_EXPECT_DATA_ts15, BIST_EXPECT_DATA_ts14, BIST_EXPECT_DATA_ts13, 
      BIST_EXPECT_DATA_ts12, BIST_EXPECT_DATA_ts11, BIST_EXPECT_DATA_ts10, 
      BIST_EXPECT_DATA_ts9, BIST_EXPECT_DATA_ts8}), .BIST_SI(MEM4_BIST_COLLAR_SI_ts1), 
      .BIST_COLLAR_SETUP(BIST_COLLAR_SETUP_ts1), .BIST_COLLAR_OPSET_SELECT(BIST_COLLAR_OPSET_SELECT_ts1), 
      .BIST_COLLAR_HOLD(BIST_COLLAR_HOLD_ts1), .BIST_BIRA_EN(BIST_COLLAR_BIRA_EN_ts1), 
      .CHECK_REPAIR_NEEDED(CHECK_REPAIR_NEEDED), .BIST_DIAG_EN(BIST_COLLAR_DIAG_EN_ts1), 
      .BIST_CLEAR_DEFAULT(BIST_CLEAR_DEFAULT_ts1), .BIST_CLEAR(BIST_CLEAR_ts1), 
      .BIST_SETUP2(BIST_SETUP_ts2), .BIST_SETUP1(BIST_SETUP_ts1), .BIST_SETUP0(BIST_SETUP), 
      .LV_TM(ltest_to_en), .FREEZE_STOP_ERROR(FREEZE_STOP_ERROR_ts1), .GO_ID_REG_SEL(GO_ID_REG_SEL_ts1), 
      .BIST_COLLAR_EN(BIST_COLLAR_EN4_ts1), .FROM_BISR_All_SCOL0_FUSE_REG(ram_row_42_col_0_bisr_inst_Q[6:1]), 
      .FROM_BISR_All_SCOL0_ALLOC_REG(ram_row_42_col_0_bisr_inst_Q[0]), .BIST_SHIFT_BIRA_COLLAR(BIST_SHIFT_BIRA_COLLAR_ts1), 
      .RESET_REG_SETUP2(MBISTPG_RESET_REG_SETUP2_ts1), .ERROR_CNT_ZERO(ERROR_CNT_ZERO_ts1), 
      .WREN_P0(WREN_P0_ts36), .WREN_P1(WREN_P1_ts36), .RDEN_P0(RDEN_P0_ts36), .RDEN_P1(RDEN_P1_ts36), 
      .ADRRD_P0(ADRRD_P0_ts36), .ADRRD_P1(ADRRD_P1_ts36), .ADRWR_P0(ADRWR_P0_ts36), 
      .ADRWR_P1(ADRWR_P1_ts36), .DIN_P0(DIN_P0_ts36), .DIN_P1(DIN_P1_ts36), .BIST_SO(BIST_SO_ts36), 
      .BIST_GO(BIST_GO_ts36), .All_SCOL0_FUSE_REG(All_SCOL0_FUSE_REG_ts36[5:0]), 
      .All_SCOL0_ALLOC_REG(All_SCOL0_ALLOC_REG_ts36), .REPAIR_STATUS(), .fscan_clkungate(fscan_clkungate)
  );

  hlp_sched_apr_rtl_tessent_mbist_RF_c4_interface_MEM6 ram_row_43_col_0_interface_inst(
      .BIST_SHADOW_READENABLE(BIST_SHADOW_READENABLE_ts1), .BIST_SHADOW_READADDRESS(BIST_SHADOW_READADDRESS_ts1), 
      .BIST_CONREAD_ROWADDRESS(BIST_CONREAD_ROWADDRESS_ts1), .BIST_CONREAD_ENABLE(BIST_CONREAD_ENABLE_ts1), 
      .BIST_CONWRITE_ROWADDRESS(BIST_CONWRITE_ROWADDRESS_ts1), .BIST_CONWRITE_ENABLE(BIST_CONWRITE_ENABLE_ts1), 
      .BIST_CLEAR_BIRA(BIST_CLEAR_BIRA_ts1), .WREN_P0_IN(ram_row_43_col_0_wr_en_a), 
      .WREN_P1_IN(ram_row_43_col_0_wr_en_b), .RDEN_P0_IN(ram_row_43_col_0_rd_en_a), 
      .RDEN_P1_IN(ram_row_43_col_0_rd_en_b), .ADRRD_P0_IN(ram_row_43_col_0_rd_adr_a[7:0]), 
      .ADRRD_P1_IN(ram_row_43_col_0_rd_adr_b[7:0]), .ADRWR_P0_IN(ram_row_43_col_0_wr_adr_a[7:0]), 
      .ADRWR_P1_IN(ram_row_43_col_0_wr_adr_b[7:0]), .QOUT_P0(ram_row_43_col_0_data_out_a), 
      .QOUT_P1(ram_row_43_col_0_data_out_b), .DIN_P0_IN(ram_row_43_col_0_data_in_a[33:0]), 
      .DIN_P1_IN(ram_row_43_col_0_data_in_b[33:0]), .TCK(to_interfaces_tck), .BIST_CMP(BIST_CMP_ts1), 
      .INCLUDE_MEM_RESULTS_REG(INCLUDE_MEM_RESULTS_REG), .BIST_READENABLE(BIST_READENABLE_ts1), 
      .BIST_WRITEENABLE(BIST_WRITEENABLE_ts1), .BIST_ROW_ADD({
      BIST_ROW_ADD_ts7, BIST_ROW_ADD_ts6, BIST_ROW_ADD_ts5, BIST_ROW_ADD_ts4}), .BIST_BANK_ADD({
      BIST_BANK_ADD_ts7, BIST_BANK_ADD_ts6, BIST_BANK_ADD_ts5, 
      BIST_BANK_ADD_ts4}), .BIST_TEST_PORT(BIST_TEST_PORT_ts1), .BIST_WRITE_DATA({
      BIST_WRITE_DATA_ts15, BIST_WRITE_DATA_ts14, BIST_WRITE_DATA_ts13, 
      BIST_WRITE_DATA_ts12, BIST_WRITE_DATA_ts11, BIST_WRITE_DATA_ts10, 
      BIST_WRITE_DATA_ts9, BIST_WRITE_DATA_ts8}), .BIST_TESTDATA_SELECT_TO_COLLAR(BIST_TESTDATA_SELECT_TO_COLLAR_ts1), 
      .MEM_BYPASS_EN(memory_bypass_to_en), .SCAN_SHIFT_EN(scan_to_en), .MCP_BOUNDING_EN(mcp_bounding_to_en), 
      .BIST_ON(BIST_ON_TO_COLLAR_ts1), .BIST_RUN(BIST_RUN_TO_COLLAR5_ts1), .BIST_ASYNC_RESETN(BIST_ASYNC_RESET), 
      .BIST_CLK(clk_a), .BIST_SHIFT_COLLAR(BIST_SHIFT_COLLAR_ts1), .BIST_EXPECT_DATA({
      BIST_EXPECT_DATA_ts15, BIST_EXPECT_DATA_ts14, BIST_EXPECT_DATA_ts13, 
      BIST_EXPECT_DATA_ts12, BIST_EXPECT_DATA_ts11, BIST_EXPECT_DATA_ts10, 
      BIST_EXPECT_DATA_ts9, BIST_EXPECT_DATA_ts8}), .BIST_SI(MEM5_BIST_COLLAR_SI_ts1), 
      .BIST_COLLAR_SETUP(BIST_COLLAR_SETUP_ts1), .BIST_COLLAR_OPSET_SELECT(BIST_COLLAR_OPSET_SELECT_ts1), 
      .BIST_COLLAR_HOLD(BIST_COLLAR_HOLD_ts1), .BIST_BIRA_EN(BIST_COLLAR_BIRA_EN_ts1), 
      .CHECK_REPAIR_NEEDED(CHECK_REPAIR_NEEDED), .BIST_DIAG_EN(BIST_COLLAR_DIAG_EN_ts1), 
      .BIST_CLEAR_DEFAULT(BIST_CLEAR_DEFAULT_ts1), .BIST_CLEAR(BIST_CLEAR_ts1), 
      .BIST_SETUP2(BIST_SETUP_ts2), .BIST_SETUP1(BIST_SETUP_ts1), .BIST_SETUP0(BIST_SETUP), 
      .LV_TM(ltest_to_en), .FREEZE_STOP_ERROR(FREEZE_STOP_ERROR_ts1), .GO_ID_REG_SEL(GO_ID_REG_SEL_ts1), 
      .BIST_COLLAR_EN(BIST_COLLAR_EN5_ts1), .FROM_BISR_All_SCOL0_FUSE_REG(ram_row_43_col_0_bisr_inst_Q[6:1]), 
      .FROM_BISR_All_SCOL0_ALLOC_REG(ram_row_43_col_0_bisr_inst_Q[0]), .BIST_SHIFT_BIRA_COLLAR(BIST_SHIFT_BIRA_COLLAR_ts1), 
      .RESET_REG_SETUP2(MBISTPG_RESET_REG_SETUP2_ts1), .ERROR_CNT_ZERO(ERROR_CNT_ZERO_ts1), 
      .WREN_P0(WREN_P0_ts37), .WREN_P1(WREN_P1_ts37), .RDEN_P0(RDEN_P0_ts37), .RDEN_P1(RDEN_P1_ts37), 
      .ADRRD_P0(ADRRD_P0_ts37), .ADRRD_P1(ADRRD_P1_ts37), .ADRWR_P0(ADRWR_P0_ts37), 
      .ADRWR_P1(ADRWR_P1_ts37), .DIN_P0(DIN_P0_ts37), .DIN_P1(DIN_P1_ts37), .BIST_SO(BIST_SO_ts37), 
      .BIST_GO(BIST_GO_ts37), .All_SCOL0_FUSE_REG(All_SCOL0_FUSE_REG_ts37[5:0]), 
      .All_SCOL0_ALLOC_REG(All_SCOL0_ALLOC_REG_ts37), .REPAIR_STATUS(), .fscan_clkungate(fscan_clkungate)
  );

  hlp_sched_apr_rtl_tessent_mbist_RF_c4_interface_MEM7 ram_row_44_col_0_interface_inst(
      .BIST_SHADOW_READENABLE(BIST_SHADOW_READENABLE_ts1), .BIST_SHADOW_READADDRESS(BIST_SHADOW_READADDRESS_ts1), 
      .BIST_CONREAD_ROWADDRESS(BIST_CONREAD_ROWADDRESS_ts1), .BIST_CONREAD_ENABLE(BIST_CONREAD_ENABLE_ts1), 
      .BIST_CONWRITE_ROWADDRESS(BIST_CONWRITE_ROWADDRESS_ts1), .BIST_CONWRITE_ENABLE(BIST_CONWRITE_ENABLE_ts1), 
      .BIST_CLEAR_BIRA(BIST_CLEAR_BIRA_ts1), .WREN_P0_IN(ram_row_44_col_0_wr_en_a), 
      .WREN_P1_IN(ram_row_44_col_0_wr_en_b), .RDEN_P0_IN(ram_row_44_col_0_rd_en_a), 
      .RDEN_P1_IN(ram_row_44_col_0_rd_en_b), .ADRRD_P0_IN(ram_row_44_col_0_rd_adr_a[7:0]), 
      .ADRRD_P1_IN(ram_row_44_col_0_rd_adr_b[7:0]), .ADRWR_P0_IN(ram_row_44_col_0_wr_adr_a[7:0]), 
      .ADRWR_P1_IN(ram_row_44_col_0_wr_adr_b[7:0]), .QOUT_P0(ram_row_44_col_0_data_out_a), 
      .QOUT_P1(ram_row_44_col_0_data_out_b), .DIN_P0_IN(ram_row_44_col_0_data_in_a[33:0]), 
      .DIN_P1_IN(ram_row_44_col_0_data_in_b[33:0]), .TCK(to_interfaces_tck), .BIST_CMP(BIST_CMP_ts1), 
      .INCLUDE_MEM_RESULTS_REG(INCLUDE_MEM_RESULTS_REG), .BIST_READENABLE(BIST_READENABLE_ts1), 
      .BIST_WRITEENABLE(BIST_WRITEENABLE_ts1), .BIST_ROW_ADD({
      BIST_ROW_ADD_ts7, BIST_ROW_ADD_ts6, BIST_ROW_ADD_ts5, BIST_ROW_ADD_ts4}), .BIST_BANK_ADD({
      BIST_BANK_ADD_ts7, BIST_BANK_ADD_ts6, BIST_BANK_ADD_ts5, 
      BIST_BANK_ADD_ts4}), .BIST_TEST_PORT(BIST_TEST_PORT_ts1), .BIST_WRITE_DATA({
      BIST_WRITE_DATA_ts15, BIST_WRITE_DATA_ts14, BIST_WRITE_DATA_ts13, 
      BIST_WRITE_DATA_ts12, BIST_WRITE_DATA_ts11, BIST_WRITE_DATA_ts10, 
      BIST_WRITE_DATA_ts9, BIST_WRITE_DATA_ts8}), .BIST_TESTDATA_SELECT_TO_COLLAR(BIST_TESTDATA_SELECT_TO_COLLAR_ts1), 
      .MEM_BYPASS_EN(memory_bypass_to_en), .SCAN_SHIFT_EN(scan_to_en), .MCP_BOUNDING_EN(mcp_bounding_to_en), 
      .BIST_ON(BIST_ON_TO_COLLAR_ts1), .BIST_RUN(BIST_RUN_TO_COLLAR6_ts1), .BIST_ASYNC_RESETN(BIST_ASYNC_RESET), 
      .BIST_CLK(clk_a), .BIST_SHIFT_COLLAR(BIST_SHIFT_COLLAR_ts1), .BIST_EXPECT_DATA({
      BIST_EXPECT_DATA_ts15, BIST_EXPECT_DATA_ts14, BIST_EXPECT_DATA_ts13, 
      BIST_EXPECT_DATA_ts12, BIST_EXPECT_DATA_ts11, BIST_EXPECT_DATA_ts10, 
      BIST_EXPECT_DATA_ts9, BIST_EXPECT_DATA_ts8}), .BIST_SI(MEM6_BIST_COLLAR_SI_ts1), 
      .BIST_COLLAR_SETUP(BIST_COLLAR_SETUP_ts1), .BIST_COLLAR_OPSET_SELECT(BIST_COLLAR_OPSET_SELECT_ts1), 
      .BIST_COLLAR_HOLD(BIST_COLLAR_HOLD_ts1), .BIST_BIRA_EN(BIST_COLLAR_BIRA_EN_ts1), 
      .CHECK_REPAIR_NEEDED(CHECK_REPAIR_NEEDED), .BIST_DIAG_EN(BIST_COLLAR_DIAG_EN_ts1), 
      .BIST_CLEAR_DEFAULT(BIST_CLEAR_DEFAULT_ts1), .BIST_CLEAR(BIST_CLEAR_ts1), 
      .BIST_SETUP2(BIST_SETUP_ts2), .BIST_SETUP1(BIST_SETUP_ts1), .BIST_SETUP0(BIST_SETUP), 
      .LV_TM(ltest_to_en), .FREEZE_STOP_ERROR(FREEZE_STOP_ERROR_ts1), .GO_ID_REG_SEL(GO_ID_REG_SEL_ts1), 
      .BIST_COLLAR_EN(BIST_COLLAR_EN6_ts1), .FROM_BISR_All_SCOL0_FUSE_REG(ram_row_44_col_0_bisr_inst_Q[6:1]), 
      .FROM_BISR_All_SCOL0_ALLOC_REG(ram_row_44_col_0_bisr_inst_Q[0]), .BIST_SHIFT_BIRA_COLLAR(BIST_SHIFT_BIRA_COLLAR_ts1), 
      .RESET_REG_SETUP2(MBISTPG_RESET_REG_SETUP2_ts1), .ERROR_CNT_ZERO(ERROR_CNT_ZERO_ts1), 
      .WREN_P0(WREN_P0_ts38), .WREN_P1(WREN_P1_ts38), .RDEN_P0(RDEN_P0_ts38), .RDEN_P1(RDEN_P1_ts38), 
      .ADRRD_P0(ADRRD_P0_ts38), .ADRRD_P1(ADRRD_P1_ts38), .ADRWR_P0(ADRWR_P0_ts38), 
      .ADRWR_P1(ADRWR_P1_ts38), .DIN_P0(DIN_P0_ts38), .DIN_P1(DIN_P1_ts38), .BIST_SO(BIST_SO_ts38), 
      .BIST_GO(BIST_GO_ts38), .All_SCOL0_FUSE_REG(All_SCOL0_FUSE_REG_ts38[5:0]), 
      .All_SCOL0_ALLOC_REG(All_SCOL0_ALLOC_REG_ts38), .REPAIR_STATUS(), .fscan_clkungate(fscan_clkungate)
  );

  hlp_sched_apr_rtl_tessent_mbist_RF_c4_interface_MEM8 ram_row_45_col_0_interface_inst(
      .BIST_SHADOW_READENABLE(BIST_SHADOW_READENABLE_ts1), .BIST_SHADOW_READADDRESS(BIST_SHADOW_READADDRESS_ts1), 
      .BIST_CONREAD_ROWADDRESS(BIST_CONREAD_ROWADDRESS_ts1), .BIST_CONREAD_ENABLE(BIST_CONREAD_ENABLE_ts1), 
      .BIST_CONWRITE_ROWADDRESS(BIST_CONWRITE_ROWADDRESS_ts1), .BIST_CONWRITE_ENABLE(BIST_CONWRITE_ENABLE_ts1), 
      .BIST_CLEAR_BIRA(BIST_CLEAR_BIRA_ts1), .WREN_P0_IN(ram_row_45_col_0_wr_en_a), 
      .WREN_P1_IN(ram_row_45_col_0_wr_en_b), .RDEN_P0_IN(ram_row_45_col_0_rd_en_a), 
      .RDEN_P1_IN(ram_row_45_col_0_rd_en_b), .ADRRD_P0_IN(ram_row_45_col_0_rd_adr_a[7:0]), 
      .ADRRD_P1_IN(ram_row_45_col_0_rd_adr_b[7:0]), .ADRWR_P0_IN(ram_row_45_col_0_wr_adr_a[7:0]), 
      .ADRWR_P1_IN(ram_row_45_col_0_wr_adr_b[7:0]), .QOUT_P0(ram_row_45_col_0_data_out_a), 
      .QOUT_P1(ram_row_45_col_0_data_out_b), .DIN_P0_IN(ram_row_45_col_0_data_in_a[33:0]), 
      .DIN_P1_IN(ram_row_45_col_0_data_in_b[33:0]), .TCK(to_interfaces_tck), .BIST_CMP(BIST_CMP_ts1), 
      .INCLUDE_MEM_RESULTS_REG(INCLUDE_MEM_RESULTS_REG), .BIST_READENABLE(BIST_READENABLE_ts1), 
      .BIST_WRITEENABLE(BIST_WRITEENABLE_ts1), .BIST_ROW_ADD({
      BIST_ROW_ADD_ts7, BIST_ROW_ADD_ts6, BIST_ROW_ADD_ts5, BIST_ROW_ADD_ts4}), .BIST_BANK_ADD({
      BIST_BANK_ADD_ts7, BIST_BANK_ADD_ts6, BIST_BANK_ADD_ts5, 
      BIST_BANK_ADD_ts4}), .BIST_TEST_PORT(BIST_TEST_PORT_ts1), .BIST_WRITE_DATA({
      BIST_WRITE_DATA_ts15, BIST_WRITE_DATA_ts14, BIST_WRITE_DATA_ts13, 
      BIST_WRITE_DATA_ts12, BIST_WRITE_DATA_ts11, BIST_WRITE_DATA_ts10, 
      BIST_WRITE_DATA_ts9, BIST_WRITE_DATA_ts8}), .BIST_TESTDATA_SELECT_TO_COLLAR(BIST_TESTDATA_SELECT_TO_COLLAR_ts1), 
      .MEM_BYPASS_EN(memory_bypass_to_en), .SCAN_SHIFT_EN(scan_to_en), .MCP_BOUNDING_EN(mcp_bounding_to_en), 
      .BIST_ON(BIST_ON_TO_COLLAR_ts1), .BIST_RUN(BIST_RUN_TO_COLLAR7_ts1), .BIST_ASYNC_RESETN(BIST_ASYNC_RESET), 
      .BIST_CLK(clk_a), .BIST_SHIFT_COLLAR(BIST_SHIFT_COLLAR_ts1), .BIST_EXPECT_DATA({
      BIST_EXPECT_DATA_ts15, BIST_EXPECT_DATA_ts14, BIST_EXPECT_DATA_ts13, 
      BIST_EXPECT_DATA_ts12, BIST_EXPECT_DATA_ts11, BIST_EXPECT_DATA_ts10, 
      BIST_EXPECT_DATA_ts9, BIST_EXPECT_DATA_ts8}), .BIST_SI(MEM7_BIST_COLLAR_SI_ts1), 
      .BIST_COLLAR_SETUP(BIST_COLLAR_SETUP_ts1), .BIST_COLLAR_OPSET_SELECT(BIST_COLLAR_OPSET_SELECT_ts1), 
      .BIST_COLLAR_HOLD(BIST_COLLAR_HOLD_ts1), .BIST_BIRA_EN(BIST_COLLAR_BIRA_EN_ts1), 
      .CHECK_REPAIR_NEEDED(CHECK_REPAIR_NEEDED), .BIST_DIAG_EN(BIST_COLLAR_DIAG_EN_ts1), 
      .BIST_CLEAR_DEFAULT(BIST_CLEAR_DEFAULT_ts1), .BIST_CLEAR(BIST_CLEAR_ts1), 
      .BIST_SETUP2(BIST_SETUP_ts2), .BIST_SETUP1(BIST_SETUP_ts1), .BIST_SETUP0(BIST_SETUP), 
      .LV_TM(ltest_to_en), .FREEZE_STOP_ERROR(FREEZE_STOP_ERROR_ts1), .GO_ID_REG_SEL(GO_ID_REG_SEL_ts1), 
      .BIST_COLLAR_EN(BIST_COLLAR_EN7_ts1), .FROM_BISR_All_SCOL0_FUSE_REG(ram_row_45_col_0_bisr_inst_Q[6:1]), 
      .FROM_BISR_All_SCOL0_ALLOC_REG(ram_row_45_col_0_bisr_inst_Q[0]), .BIST_SHIFT_BIRA_COLLAR(BIST_SHIFT_BIRA_COLLAR_ts1), 
      .RESET_REG_SETUP2(MBISTPG_RESET_REG_SETUP2_ts1), .ERROR_CNT_ZERO(ERROR_CNT_ZERO_ts1), 
      .WREN_P0(WREN_P0_ts39), .WREN_P1(WREN_P1_ts39), .RDEN_P0(RDEN_P0_ts39), .RDEN_P1(RDEN_P1_ts39), 
      .ADRRD_P0(ADRRD_P0_ts39), .ADRRD_P1(ADRRD_P1_ts39), .ADRWR_P0(ADRWR_P0_ts39), 
      .ADRWR_P1(ADRWR_P1_ts39), .DIN_P0(DIN_P0_ts39), .DIN_P1(DIN_P1_ts39), .BIST_SO(BIST_SO_ts39), 
      .BIST_GO(BIST_GO_ts39), .All_SCOL0_FUSE_REG(All_SCOL0_FUSE_REG_ts39[5:0]), 
      .All_SCOL0_ALLOC_REG(All_SCOL0_ALLOC_REG_ts39), .REPAIR_STATUS(), .fscan_clkungate(fscan_clkungate)
  );

  hlp_sched_apr_rtl_tessent_mbist_RF_c4_interface_MEM9 ram_row_46_col_0_interface_inst(
      .BIST_SHADOW_READENABLE(BIST_SHADOW_READENABLE_ts1), .BIST_SHADOW_READADDRESS(BIST_SHADOW_READADDRESS_ts1), 
      .BIST_CONREAD_ROWADDRESS(BIST_CONREAD_ROWADDRESS_ts1), .BIST_CONREAD_ENABLE(BIST_CONREAD_ENABLE_ts1), 
      .BIST_CONWRITE_ROWADDRESS(BIST_CONWRITE_ROWADDRESS_ts1), .BIST_CONWRITE_ENABLE(BIST_CONWRITE_ENABLE_ts1), 
      .BIST_CLEAR_BIRA(BIST_CLEAR_BIRA_ts1), .WREN_P0_IN(ram_row_46_col_0_wr_en_a), 
      .WREN_P1_IN(ram_row_46_col_0_wr_en_b), .RDEN_P0_IN(ram_row_46_col_0_rd_en_a), 
      .RDEN_P1_IN(ram_row_46_col_0_rd_en_b), .ADRRD_P0_IN(ram_row_46_col_0_rd_adr_a[7:0]), 
      .ADRRD_P1_IN(ram_row_46_col_0_rd_adr_b[7:0]), .ADRWR_P0_IN(ram_row_46_col_0_wr_adr_a[7:0]), 
      .ADRWR_P1_IN(ram_row_46_col_0_wr_adr_b[7:0]), .QOUT_P0(ram_row_46_col_0_data_out_a), 
      .QOUT_P1(ram_row_46_col_0_data_out_b), .DIN_P0_IN(ram_row_46_col_0_data_in_a[33:0]), 
      .DIN_P1_IN(ram_row_46_col_0_data_in_b[33:0]), .TCK(to_interfaces_tck), .BIST_CMP(BIST_CMP_ts1), 
      .INCLUDE_MEM_RESULTS_REG(INCLUDE_MEM_RESULTS_REG), .BIST_READENABLE(BIST_READENABLE_ts1), 
      .BIST_WRITEENABLE(BIST_WRITEENABLE_ts1), .BIST_ROW_ADD({
      BIST_ROW_ADD_ts7, BIST_ROW_ADD_ts6, BIST_ROW_ADD_ts5, BIST_ROW_ADD_ts4}), .BIST_BANK_ADD({
      BIST_BANK_ADD_ts7, BIST_BANK_ADD_ts6, BIST_BANK_ADD_ts5, 
      BIST_BANK_ADD_ts4}), .BIST_TEST_PORT(BIST_TEST_PORT_ts1), .BIST_WRITE_DATA({
      BIST_WRITE_DATA_ts15, BIST_WRITE_DATA_ts14, BIST_WRITE_DATA_ts13, 
      BIST_WRITE_DATA_ts12, BIST_WRITE_DATA_ts11, BIST_WRITE_DATA_ts10, 
      BIST_WRITE_DATA_ts9, BIST_WRITE_DATA_ts8}), .BIST_TESTDATA_SELECT_TO_COLLAR(BIST_TESTDATA_SELECT_TO_COLLAR_ts1), 
      .MEM_BYPASS_EN(memory_bypass_to_en), .SCAN_SHIFT_EN(scan_to_en), .MCP_BOUNDING_EN(mcp_bounding_to_en), 
      .BIST_ON(BIST_ON_TO_COLLAR_ts1), .BIST_RUN(BIST_RUN_TO_COLLAR8_ts1), .BIST_ASYNC_RESETN(BIST_ASYNC_RESET), 
      .BIST_CLK(clk_a), .BIST_SHIFT_COLLAR(BIST_SHIFT_COLLAR_ts1), .BIST_EXPECT_DATA({
      BIST_EXPECT_DATA_ts15, BIST_EXPECT_DATA_ts14, BIST_EXPECT_DATA_ts13, 
      BIST_EXPECT_DATA_ts12, BIST_EXPECT_DATA_ts11, BIST_EXPECT_DATA_ts10, 
      BIST_EXPECT_DATA_ts9, BIST_EXPECT_DATA_ts8}), .BIST_SI(MEM8_BIST_COLLAR_SI_ts1), 
      .BIST_COLLAR_SETUP(BIST_COLLAR_SETUP_ts1), .BIST_COLLAR_OPSET_SELECT(BIST_COLLAR_OPSET_SELECT_ts1), 
      .BIST_COLLAR_HOLD(BIST_COLLAR_HOLD_ts1), .BIST_BIRA_EN(BIST_COLLAR_BIRA_EN_ts1), 
      .CHECK_REPAIR_NEEDED(CHECK_REPAIR_NEEDED), .BIST_DIAG_EN(BIST_COLLAR_DIAG_EN_ts1), 
      .BIST_CLEAR_DEFAULT(BIST_CLEAR_DEFAULT_ts1), .BIST_CLEAR(BIST_CLEAR_ts1), 
      .BIST_SETUP2(BIST_SETUP_ts2), .BIST_SETUP1(BIST_SETUP_ts1), .BIST_SETUP0(BIST_SETUP), 
      .LV_TM(ltest_to_en), .FREEZE_STOP_ERROR(FREEZE_STOP_ERROR_ts1), .GO_ID_REG_SEL(GO_ID_REG_SEL_ts1), 
      .BIST_COLLAR_EN(BIST_COLLAR_EN8_ts1), .FROM_BISR_All_SCOL0_FUSE_REG(ram_row_46_col_0_bisr_inst_Q[6:1]), 
      .FROM_BISR_All_SCOL0_ALLOC_REG(ram_row_46_col_0_bisr_inst_Q[0]), .BIST_SHIFT_BIRA_COLLAR(BIST_SHIFT_BIRA_COLLAR_ts1), 
      .RESET_REG_SETUP2(MBISTPG_RESET_REG_SETUP2_ts1), .ERROR_CNT_ZERO(ERROR_CNT_ZERO_ts1), 
      .WREN_P0(WREN_P0_ts40), .WREN_P1(WREN_P1_ts40), .RDEN_P0(RDEN_P0_ts40), .RDEN_P1(RDEN_P1_ts40), 
      .ADRRD_P0(ADRRD_P0_ts40), .ADRRD_P1(ADRRD_P1_ts40), .ADRWR_P0(ADRWR_P0_ts40), 
      .ADRWR_P1(ADRWR_P1_ts40), .DIN_P0(DIN_P0_ts40), .DIN_P1(DIN_P1_ts40), .BIST_SO(BIST_SO_ts40), 
      .BIST_GO(BIST_GO_ts40), .All_SCOL0_FUSE_REG(All_SCOL0_FUSE_REG_ts40[5:0]), 
      .All_SCOL0_ALLOC_REG(All_SCOL0_ALLOC_REG_ts40), .REPAIR_STATUS(), .fscan_clkungate(fscan_clkungate)
  );

  hlp_sched_apr_rtl_tessent_mbist_RF_c4_interface_MEM10 ram_row_47_col_0_interface_inst(
      .BIST_SHADOW_READENABLE(BIST_SHADOW_READENABLE_ts1), .BIST_SHADOW_READADDRESS(BIST_SHADOW_READADDRESS_ts1), 
      .BIST_CONREAD_ROWADDRESS(BIST_CONREAD_ROWADDRESS_ts1), .BIST_CONREAD_ENABLE(BIST_CONREAD_ENABLE_ts1), 
      .BIST_CONWRITE_ROWADDRESS(BIST_CONWRITE_ROWADDRESS_ts1), .BIST_CONWRITE_ENABLE(BIST_CONWRITE_ENABLE_ts1), 
      .BIST_CLEAR_BIRA(BIST_CLEAR_BIRA_ts1), .WREN_P0_IN(ram_row_47_col_0_wr_en_a), 
      .WREN_P1_IN(ram_row_47_col_0_wr_en_b), .RDEN_P0_IN(ram_row_47_col_0_rd_en_a), 
      .RDEN_P1_IN(ram_row_47_col_0_rd_en_b), .ADRRD_P0_IN(ram_row_47_col_0_rd_adr_a[7:0]), 
      .ADRRD_P1_IN(ram_row_47_col_0_rd_adr_b[7:0]), .ADRWR_P0_IN(ram_row_47_col_0_wr_adr_a[7:0]), 
      .ADRWR_P1_IN(ram_row_47_col_0_wr_adr_b[7:0]), .QOUT_P0(ram_row_47_col_0_data_out_a), 
      .QOUT_P1(ram_row_47_col_0_data_out_b), .DIN_P0_IN(ram_row_47_col_0_data_in_a[33:0]), 
      .DIN_P1_IN(ram_row_47_col_0_data_in_b[33:0]), .TCK(to_interfaces_tck), .BIST_CMP(BIST_CMP_ts1), 
      .INCLUDE_MEM_RESULTS_REG(INCLUDE_MEM_RESULTS_REG), .BIST_READENABLE(BIST_READENABLE_ts1), 
      .BIST_WRITEENABLE(BIST_WRITEENABLE_ts1), .BIST_ROW_ADD({
      BIST_ROW_ADD_ts7, BIST_ROW_ADD_ts6, BIST_ROW_ADD_ts5, BIST_ROW_ADD_ts4}), .BIST_BANK_ADD({
      BIST_BANK_ADD_ts7, BIST_BANK_ADD_ts6, BIST_BANK_ADD_ts5, 
      BIST_BANK_ADD_ts4}), .BIST_TEST_PORT(BIST_TEST_PORT_ts1), .BIST_WRITE_DATA({
      BIST_WRITE_DATA_ts15, BIST_WRITE_DATA_ts14, BIST_WRITE_DATA_ts13, 
      BIST_WRITE_DATA_ts12, BIST_WRITE_DATA_ts11, BIST_WRITE_DATA_ts10, 
      BIST_WRITE_DATA_ts9, BIST_WRITE_DATA_ts8}), .BIST_TESTDATA_SELECT_TO_COLLAR(BIST_TESTDATA_SELECT_TO_COLLAR_ts1), 
      .MEM_BYPASS_EN(memory_bypass_to_en), .SCAN_SHIFT_EN(scan_to_en), .MCP_BOUNDING_EN(mcp_bounding_to_en), 
      .BIST_ON(BIST_ON_TO_COLLAR_ts1), .BIST_RUN(BIST_RUN_TO_COLLAR9_ts1), .BIST_ASYNC_RESETN(BIST_ASYNC_RESET), 
      .BIST_CLK(clk_a), .BIST_SHIFT_COLLAR(BIST_SHIFT_COLLAR_ts1), .BIST_EXPECT_DATA({
      BIST_EXPECT_DATA_ts15, BIST_EXPECT_DATA_ts14, BIST_EXPECT_DATA_ts13, 
      BIST_EXPECT_DATA_ts12, BIST_EXPECT_DATA_ts11, BIST_EXPECT_DATA_ts10, 
      BIST_EXPECT_DATA_ts9, BIST_EXPECT_DATA_ts8}), .BIST_SI(MEM9_BIST_COLLAR_SI_ts1), 
      .BIST_COLLAR_SETUP(BIST_COLLAR_SETUP_ts1), .BIST_COLLAR_OPSET_SELECT(BIST_COLLAR_OPSET_SELECT_ts1), 
      .BIST_COLLAR_HOLD(BIST_COLLAR_HOLD_ts1), .BIST_BIRA_EN(BIST_COLLAR_BIRA_EN_ts1), 
      .CHECK_REPAIR_NEEDED(CHECK_REPAIR_NEEDED), .BIST_DIAG_EN(BIST_COLLAR_DIAG_EN_ts1), 
      .BIST_CLEAR_DEFAULT(BIST_CLEAR_DEFAULT_ts1), .BIST_CLEAR(BIST_CLEAR_ts1), 
      .BIST_SETUP2(BIST_SETUP_ts2), .BIST_SETUP1(BIST_SETUP_ts1), .BIST_SETUP0(BIST_SETUP), 
      .LV_TM(ltest_to_en), .FREEZE_STOP_ERROR(FREEZE_STOP_ERROR_ts1), .GO_ID_REG_SEL(GO_ID_REG_SEL_ts1), 
      .BIST_COLLAR_EN(BIST_COLLAR_EN9_ts1), .FROM_BISR_All_SCOL0_FUSE_REG(ram_row_47_col_0_bisr_inst_Q[6:1]), 
      .FROM_BISR_All_SCOL0_ALLOC_REG(ram_row_47_col_0_bisr_inst_Q[0]), .BIST_SHIFT_BIRA_COLLAR(BIST_SHIFT_BIRA_COLLAR_ts1), 
      .RESET_REG_SETUP2(MBISTPG_RESET_REG_SETUP2_ts1), .ERROR_CNT_ZERO(ERROR_CNT_ZERO_ts1), 
      .WREN_P0(WREN_P0_ts41), .WREN_P1(WREN_P1_ts41), .RDEN_P0(RDEN_P0_ts41), .RDEN_P1(RDEN_P1_ts41), 
      .ADRRD_P0(ADRRD_P0_ts41), .ADRRD_P1(ADRRD_P1_ts41), .ADRWR_P0(ADRWR_P0_ts41), 
      .ADRWR_P1(ADRWR_P1_ts41), .DIN_P0(DIN_P0_ts41), .DIN_P1(DIN_P1_ts41), .BIST_SO(BIST_SO_ts41), 
      .BIST_GO(BIST_GO_ts41), .All_SCOL0_FUSE_REG(All_SCOL0_FUSE_REG_ts41[5:0]), 
      .All_SCOL0_ALLOC_REG(All_SCOL0_ALLOC_REG_ts41), .REPAIR_STATUS(), .fscan_clkungate(fscan_clkungate)
  );

  hlp_sched_apr_rtl_tessent_mbist_RF_c4_interface_MEM11 ram_row_48_col_0_interface_inst(
      .BIST_SHADOW_READENABLE(BIST_SHADOW_READENABLE_ts1), .BIST_SHADOW_READADDRESS(BIST_SHADOW_READADDRESS_ts1), 
      .BIST_CONREAD_ROWADDRESS(BIST_CONREAD_ROWADDRESS_ts1), .BIST_CONREAD_ENABLE(BIST_CONREAD_ENABLE_ts1), 
      .BIST_CONWRITE_ROWADDRESS(BIST_CONWRITE_ROWADDRESS_ts1), .BIST_CONWRITE_ENABLE(BIST_CONWRITE_ENABLE_ts1), 
      .BIST_CLEAR_BIRA(BIST_CLEAR_BIRA_ts1), .WREN_P0_IN(ram_row_48_col_0_wr_en_a), 
      .WREN_P1_IN(ram_row_48_col_0_wr_en_b), .RDEN_P0_IN(ram_row_48_col_0_rd_en_a), 
      .RDEN_P1_IN(ram_row_48_col_0_rd_en_b), .ADRRD_P0_IN(ram_row_48_col_0_rd_adr_a[7:0]), 
      .ADRRD_P1_IN(ram_row_48_col_0_rd_adr_b[7:0]), .ADRWR_P0_IN(ram_row_48_col_0_wr_adr_a[7:0]), 
      .ADRWR_P1_IN(ram_row_48_col_0_wr_adr_b[7:0]), .QOUT_P0(ram_row_48_col_0_data_out_a), 
      .QOUT_P1(ram_row_48_col_0_data_out_b), .DIN_P0_IN(ram_row_48_col_0_data_in_a[33:0]), 
      .DIN_P1_IN(ram_row_48_col_0_data_in_b[33:0]), .TCK(to_interfaces_tck), .BIST_CMP(BIST_CMP_ts1), 
      .INCLUDE_MEM_RESULTS_REG(INCLUDE_MEM_RESULTS_REG), .BIST_READENABLE(BIST_READENABLE_ts1), 
      .BIST_WRITEENABLE(BIST_WRITEENABLE_ts1), .BIST_ROW_ADD({
      BIST_ROW_ADD_ts7, BIST_ROW_ADD_ts6, BIST_ROW_ADD_ts5, BIST_ROW_ADD_ts4}), .BIST_BANK_ADD({
      BIST_BANK_ADD_ts7, BIST_BANK_ADD_ts6, BIST_BANK_ADD_ts5, 
      BIST_BANK_ADD_ts4}), .BIST_TEST_PORT(BIST_TEST_PORT_ts1), .BIST_WRITE_DATA({
      BIST_WRITE_DATA_ts15, BIST_WRITE_DATA_ts14, BIST_WRITE_DATA_ts13, 
      BIST_WRITE_DATA_ts12, BIST_WRITE_DATA_ts11, BIST_WRITE_DATA_ts10, 
      BIST_WRITE_DATA_ts9, BIST_WRITE_DATA_ts8}), .BIST_TESTDATA_SELECT_TO_COLLAR(BIST_TESTDATA_SELECT_TO_COLLAR_ts1), 
      .MEM_BYPASS_EN(memory_bypass_to_en), .SCAN_SHIFT_EN(scan_to_en), .MCP_BOUNDING_EN(mcp_bounding_to_en), 
      .BIST_ON(BIST_ON_TO_COLLAR_ts1), .BIST_RUN(BIST_RUN_TO_COLLAR10_ts1), .BIST_ASYNC_RESETN(BIST_ASYNC_RESET), 
      .BIST_CLK(clk_a), .BIST_SHIFT_COLLAR(BIST_SHIFT_COLLAR_ts1), .BIST_EXPECT_DATA({
      BIST_EXPECT_DATA_ts15, BIST_EXPECT_DATA_ts14, BIST_EXPECT_DATA_ts13, 
      BIST_EXPECT_DATA_ts12, BIST_EXPECT_DATA_ts11, BIST_EXPECT_DATA_ts10, 
      BIST_EXPECT_DATA_ts9, BIST_EXPECT_DATA_ts8}), .BIST_SI(MEM10_BIST_COLLAR_SI_ts1), 
      .BIST_COLLAR_SETUP(BIST_COLLAR_SETUP_ts1), .BIST_COLLAR_OPSET_SELECT(BIST_COLLAR_OPSET_SELECT_ts1), 
      .BIST_COLLAR_HOLD(BIST_COLLAR_HOLD_ts1), .BIST_BIRA_EN(BIST_COLLAR_BIRA_EN_ts1), 
      .CHECK_REPAIR_NEEDED(CHECK_REPAIR_NEEDED), .BIST_DIAG_EN(BIST_COLLAR_DIAG_EN_ts1), 
      .BIST_CLEAR_DEFAULT(BIST_CLEAR_DEFAULT_ts1), .BIST_CLEAR(BIST_CLEAR_ts1), 
      .BIST_SETUP2(BIST_SETUP_ts2), .BIST_SETUP1(BIST_SETUP_ts1), .BIST_SETUP0(BIST_SETUP), 
      .LV_TM(ltest_to_en), .FREEZE_STOP_ERROR(FREEZE_STOP_ERROR_ts1), .GO_ID_REG_SEL(GO_ID_REG_SEL_ts1), 
      .BIST_COLLAR_EN(BIST_COLLAR_EN10_ts1), .FROM_BISR_All_SCOL0_FUSE_REG(ram_row_48_col_0_bisr_inst_Q[6:1]), 
      .FROM_BISR_All_SCOL0_ALLOC_REG(ram_row_48_col_0_bisr_inst_Q[0]), .BIST_SHIFT_BIRA_COLLAR(BIST_SHIFT_BIRA_COLLAR_ts1), 
      .RESET_REG_SETUP2(MBISTPG_RESET_REG_SETUP2_ts1), .ERROR_CNT_ZERO(ERROR_CNT_ZERO_ts1), 
      .WREN_P0(WREN_P0_ts42), .WREN_P1(WREN_P1_ts42), .RDEN_P0(RDEN_P0_ts42), .RDEN_P1(RDEN_P1_ts42), 
      .ADRRD_P0(ADRRD_P0_ts42), .ADRRD_P1(ADRRD_P1_ts42), .ADRWR_P0(ADRWR_P0_ts42), 
      .ADRWR_P1(ADRWR_P1_ts42), .DIN_P0(DIN_P0_ts42), .DIN_P1(DIN_P1_ts42), .BIST_SO(BIST_SO_ts42), 
      .BIST_GO(BIST_GO_ts42), .All_SCOL0_FUSE_REG(All_SCOL0_FUSE_REG_ts42[5:0]), 
      .All_SCOL0_ALLOC_REG(All_SCOL0_ALLOC_REG_ts42), .REPAIR_STATUS(), .fscan_clkungate(fscan_clkungate)
  );

  hlp_sched_apr_rtl_tessent_mbist_RF_c4_interface_MEM12 ram_row_49_col_0_interface_inst(
      .BIST_SHADOW_READENABLE(BIST_SHADOW_READENABLE_ts1), .BIST_SHADOW_READADDRESS(BIST_SHADOW_READADDRESS_ts1), 
      .BIST_CONREAD_ROWADDRESS(BIST_CONREAD_ROWADDRESS_ts1), .BIST_CONREAD_ENABLE(BIST_CONREAD_ENABLE_ts1), 
      .BIST_CONWRITE_ROWADDRESS(BIST_CONWRITE_ROWADDRESS_ts1), .BIST_CONWRITE_ENABLE(BIST_CONWRITE_ENABLE_ts1), 
      .BIST_CLEAR_BIRA(BIST_CLEAR_BIRA_ts1), .WREN_P0_IN(ram_row_49_col_0_wr_en_a), 
      .WREN_P1_IN(ram_row_49_col_0_wr_en_b), .RDEN_P0_IN(ram_row_49_col_0_rd_en_a), 
      .RDEN_P1_IN(ram_row_49_col_0_rd_en_b), .ADRRD_P0_IN(ram_row_49_col_0_rd_adr_a[7:0]), 
      .ADRRD_P1_IN(ram_row_49_col_0_rd_adr_b[7:0]), .ADRWR_P0_IN(ram_row_49_col_0_wr_adr_a[7:0]), 
      .ADRWR_P1_IN(ram_row_49_col_0_wr_adr_b[7:0]), .QOUT_P0(ram_row_49_col_0_data_out_a), 
      .QOUT_P1(ram_row_49_col_0_data_out_b), .DIN_P0_IN(ram_row_49_col_0_data_in_a[33:0]), 
      .DIN_P1_IN(ram_row_49_col_0_data_in_b[33:0]), .TCK(to_interfaces_tck), .BIST_CMP(BIST_CMP_ts1), 
      .INCLUDE_MEM_RESULTS_REG(INCLUDE_MEM_RESULTS_REG), .BIST_READENABLE(BIST_READENABLE_ts1), 
      .BIST_WRITEENABLE(BIST_WRITEENABLE_ts1), .BIST_ROW_ADD({
      BIST_ROW_ADD_ts7, BIST_ROW_ADD_ts6, BIST_ROW_ADD_ts5, BIST_ROW_ADD_ts4}), .BIST_BANK_ADD({
      BIST_BANK_ADD_ts7, BIST_BANK_ADD_ts6, BIST_BANK_ADD_ts5, 
      BIST_BANK_ADD_ts4}), .BIST_TEST_PORT(BIST_TEST_PORT_ts1), .BIST_WRITE_DATA({
      BIST_WRITE_DATA_ts15, BIST_WRITE_DATA_ts14, BIST_WRITE_DATA_ts13, 
      BIST_WRITE_DATA_ts12, BIST_WRITE_DATA_ts11, BIST_WRITE_DATA_ts10, 
      BIST_WRITE_DATA_ts9, BIST_WRITE_DATA_ts8}), .BIST_TESTDATA_SELECT_TO_COLLAR(BIST_TESTDATA_SELECT_TO_COLLAR_ts1), 
      .MEM_BYPASS_EN(memory_bypass_to_en), .SCAN_SHIFT_EN(scan_to_en), .MCP_BOUNDING_EN(mcp_bounding_to_en), 
      .BIST_ON(BIST_ON_TO_COLLAR_ts1), .BIST_RUN(BIST_RUN_TO_COLLAR11_ts1), .BIST_ASYNC_RESETN(BIST_ASYNC_RESET), 
      .BIST_CLK(clk_a), .BIST_SHIFT_COLLAR(BIST_SHIFT_COLLAR_ts1), .BIST_EXPECT_DATA({
      BIST_EXPECT_DATA_ts15, BIST_EXPECT_DATA_ts14, BIST_EXPECT_DATA_ts13, 
      BIST_EXPECT_DATA_ts12, BIST_EXPECT_DATA_ts11, BIST_EXPECT_DATA_ts10, 
      BIST_EXPECT_DATA_ts9, BIST_EXPECT_DATA_ts8}), .BIST_SI(MEM11_BIST_COLLAR_SI_ts1), 
      .BIST_COLLAR_SETUP(BIST_COLLAR_SETUP_ts1), .BIST_COLLAR_OPSET_SELECT(BIST_COLLAR_OPSET_SELECT_ts1), 
      .BIST_COLLAR_HOLD(BIST_COLLAR_HOLD_ts1), .BIST_BIRA_EN(BIST_COLLAR_BIRA_EN_ts1), 
      .CHECK_REPAIR_NEEDED(CHECK_REPAIR_NEEDED), .BIST_DIAG_EN(BIST_COLLAR_DIAG_EN_ts1), 
      .BIST_CLEAR_DEFAULT(BIST_CLEAR_DEFAULT_ts1), .BIST_CLEAR(BIST_CLEAR_ts1), 
      .BIST_SETUP2(BIST_SETUP_ts2), .BIST_SETUP1(BIST_SETUP_ts1), .BIST_SETUP0(BIST_SETUP), 
      .LV_TM(ltest_to_en), .FREEZE_STOP_ERROR(FREEZE_STOP_ERROR_ts1), .GO_ID_REG_SEL(GO_ID_REG_SEL_ts1), 
      .BIST_COLLAR_EN(BIST_COLLAR_EN11_ts1), .FROM_BISR_All_SCOL0_FUSE_REG(ram_row_49_col_0_bisr_inst_Q[6:1]), 
      .FROM_BISR_All_SCOL0_ALLOC_REG(ram_row_49_col_0_bisr_inst_Q[0]), .BIST_SHIFT_BIRA_COLLAR(BIST_SHIFT_BIRA_COLLAR_ts1), 
      .RESET_REG_SETUP2(MBISTPG_RESET_REG_SETUP2_ts1), .ERROR_CNT_ZERO(ERROR_CNT_ZERO_ts1), 
      .WREN_P0(WREN_P0_ts43), .WREN_P1(WREN_P1_ts43), .RDEN_P0(RDEN_P0_ts43), .RDEN_P1(RDEN_P1_ts43), 
      .ADRRD_P0(ADRRD_P0_ts43), .ADRRD_P1(ADRRD_P1_ts43), .ADRWR_P0(ADRWR_P0_ts43), 
      .ADRWR_P1(ADRWR_P1_ts43), .DIN_P0(DIN_P0_ts43), .DIN_P1(DIN_P1_ts43), .BIST_SO(BIST_SO_ts43), 
      .BIST_GO(BIST_GO_ts43), .All_SCOL0_FUSE_REG(All_SCOL0_FUSE_REG_ts43[5:0]), 
      .All_SCOL0_ALLOC_REG(All_SCOL0_ALLOC_REG_ts43), .REPAIR_STATUS(), .fscan_clkungate(fscan_clkungate)
  );

  hlp_sched_apr_rtl_tessent_mbist_RF_c4_interface_MEM13 ram_row_4_col_0_interface_inst(
      .BIST_SHADOW_READENABLE(BIST_SHADOW_READENABLE_ts1), .BIST_SHADOW_READADDRESS(BIST_SHADOW_READADDRESS_ts1), 
      .BIST_CONREAD_ROWADDRESS(BIST_CONREAD_ROWADDRESS_ts1), .BIST_CONREAD_ENABLE(BIST_CONREAD_ENABLE_ts1), 
      .BIST_CONWRITE_ROWADDRESS(BIST_CONWRITE_ROWADDRESS_ts1), .BIST_CONWRITE_ENABLE(BIST_CONWRITE_ENABLE_ts1), 
      .BIST_CLEAR_BIRA(BIST_CLEAR_BIRA_ts1), .WREN_P0_IN(ram_row_4_col_0_wr_en_a), 
      .WREN_P1_IN(ram_row_4_col_0_wr_en_b), .RDEN_P0_IN(ram_row_4_col_0_rd_en_a), 
      .RDEN_P1_IN(ram_row_4_col_0_rd_en_b), .ADRRD_P0_IN(ram_row_4_col_0_rd_adr_a[7:0]), 
      .ADRRD_P1_IN(ram_row_4_col_0_rd_adr_b[7:0]), .ADRWR_P0_IN(ram_row_4_col_0_wr_adr_a[7:0]), 
      .ADRWR_P1_IN(ram_row_4_col_0_wr_adr_b[7:0]), .QOUT_P0(ram_row_4_col_0_data_out_a), 
      .QOUT_P1(ram_row_4_col_0_data_out_b), .DIN_P0_IN(ram_row_4_col_0_data_in_a[33:0]), 
      .DIN_P1_IN(ram_row_4_col_0_data_in_b[33:0]), .TCK(to_interfaces_tck), .BIST_CMP(BIST_CMP_ts1), 
      .INCLUDE_MEM_RESULTS_REG(INCLUDE_MEM_RESULTS_REG), .BIST_READENABLE(BIST_READENABLE_ts1), 
      .BIST_WRITEENABLE(BIST_WRITEENABLE_ts1), .BIST_ROW_ADD({
      BIST_ROW_ADD_ts7, BIST_ROW_ADD_ts6, BIST_ROW_ADD_ts5, BIST_ROW_ADD_ts4}), .BIST_BANK_ADD({
      BIST_BANK_ADD_ts7, BIST_BANK_ADD_ts6, BIST_BANK_ADD_ts5, 
      BIST_BANK_ADD_ts4}), .BIST_TEST_PORT(BIST_TEST_PORT_ts1), .BIST_WRITE_DATA({
      BIST_WRITE_DATA_ts15, BIST_WRITE_DATA_ts14, BIST_WRITE_DATA_ts13, 
      BIST_WRITE_DATA_ts12, BIST_WRITE_DATA_ts11, BIST_WRITE_DATA_ts10, 
      BIST_WRITE_DATA_ts9, BIST_WRITE_DATA_ts8}), .BIST_TESTDATA_SELECT_TO_COLLAR(BIST_TESTDATA_SELECT_TO_COLLAR_ts1), 
      .MEM_BYPASS_EN(memory_bypass_to_en), .SCAN_SHIFT_EN(scan_to_en), .MCP_BOUNDING_EN(mcp_bounding_to_en), 
      .BIST_ON(BIST_ON_TO_COLLAR_ts1), .BIST_RUN(BIST_RUN_TO_COLLAR12_ts1), .BIST_ASYNC_RESETN(BIST_ASYNC_RESET), 
      .BIST_CLK(clk_a), .BIST_SHIFT_COLLAR(BIST_SHIFT_COLLAR_ts1), .BIST_EXPECT_DATA({
      BIST_EXPECT_DATA_ts15, BIST_EXPECT_DATA_ts14, BIST_EXPECT_DATA_ts13, 
      BIST_EXPECT_DATA_ts12, BIST_EXPECT_DATA_ts11, BIST_EXPECT_DATA_ts10, 
      BIST_EXPECT_DATA_ts9, BIST_EXPECT_DATA_ts8}), .BIST_SI(MEM12_BIST_COLLAR_SI_ts1), 
      .BIST_COLLAR_SETUP(BIST_COLLAR_SETUP_ts1), .BIST_COLLAR_OPSET_SELECT(BIST_COLLAR_OPSET_SELECT_ts1), 
      .BIST_COLLAR_HOLD(BIST_COLLAR_HOLD_ts1), .BIST_BIRA_EN(BIST_COLLAR_BIRA_EN_ts1), 
      .CHECK_REPAIR_NEEDED(CHECK_REPAIR_NEEDED), .BIST_DIAG_EN(BIST_COLLAR_DIAG_EN_ts1), 
      .BIST_CLEAR_DEFAULT(BIST_CLEAR_DEFAULT_ts1), .BIST_CLEAR(BIST_CLEAR_ts1), 
      .BIST_SETUP2(BIST_SETUP_ts2), .BIST_SETUP1(BIST_SETUP_ts1), .BIST_SETUP0(BIST_SETUP), 
      .LV_TM(ltest_to_en), .FREEZE_STOP_ERROR(FREEZE_STOP_ERROR_ts1), .GO_ID_REG_SEL(GO_ID_REG_SEL_ts1), 
      .BIST_COLLAR_EN(BIST_COLLAR_EN12_ts1), .FROM_BISR_All_SCOL0_FUSE_REG(ram_row_4_col_0_bisr_inst_Q[6:1]), 
      .FROM_BISR_All_SCOL0_ALLOC_REG(ram_row_4_col_0_bisr_inst_Q[0]), .BIST_SHIFT_BIRA_COLLAR(BIST_SHIFT_BIRA_COLLAR_ts1), 
      .RESET_REG_SETUP2(MBISTPG_RESET_REG_SETUP2_ts1), .ERROR_CNT_ZERO(ERROR_CNT_ZERO_ts1), 
      .WREN_P0(WREN_P0_ts44), .WREN_P1(WREN_P1_ts44), .RDEN_P0(RDEN_P0_ts44), .RDEN_P1(RDEN_P1_ts44), 
      .ADRRD_P0(ADRRD_P0_ts44), .ADRRD_P1(ADRRD_P1_ts44), .ADRWR_P0(ADRWR_P0_ts44), 
      .ADRWR_P1(ADRWR_P1_ts44), .DIN_P0(DIN_P0_ts44), .DIN_P1(DIN_P1_ts44), .BIST_SO(BIST_SO_ts44), 
      .BIST_GO(BIST_GO_ts44), .All_SCOL0_FUSE_REG(All_SCOL0_FUSE_REG_ts44[5:0]), 
      .All_SCOL0_ALLOC_REG(All_SCOL0_ALLOC_REG_ts44), .REPAIR_STATUS(), .fscan_clkungate(fscan_clkungate)
  );

  hlp_sched_apr_rtl_tessent_mbist_RF_c4_interface_MEM14 ram_row_50_col_0_interface_inst(
      .BIST_SHADOW_READENABLE(BIST_SHADOW_READENABLE_ts1), .BIST_SHADOW_READADDRESS(BIST_SHADOW_READADDRESS_ts1), 
      .BIST_CONREAD_ROWADDRESS(BIST_CONREAD_ROWADDRESS_ts1), .BIST_CONREAD_ENABLE(BIST_CONREAD_ENABLE_ts1), 
      .BIST_CONWRITE_ROWADDRESS(BIST_CONWRITE_ROWADDRESS_ts1), .BIST_CONWRITE_ENABLE(BIST_CONWRITE_ENABLE_ts1), 
      .BIST_CLEAR_BIRA(BIST_CLEAR_BIRA_ts1), .WREN_P0_IN(ram_row_50_col_0_wr_en_a), 
      .WREN_P1_IN(ram_row_50_col_0_wr_en_b), .RDEN_P0_IN(ram_row_50_col_0_rd_en_a), 
      .RDEN_P1_IN(ram_row_50_col_0_rd_en_b), .ADRRD_P0_IN(ram_row_50_col_0_rd_adr_a[7:0]), 
      .ADRRD_P1_IN(ram_row_50_col_0_rd_adr_b[7:0]), .ADRWR_P0_IN(ram_row_50_col_0_wr_adr_a[7:0]), 
      .ADRWR_P1_IN(ram_row_50_col_0_wr_adr_b[7:0]), .QOUT_P0(ram_row_50_col_0_data_out_a), 
      .QOUT_P1(ram_row_50_col_0_data_out_b), .DIN_P0_IN(ram_row_50_col_0_data_in_a[33:0]), 
      .DIN_P1_IN(ram_row_50_col_0_data_in_b[33:0]), .TCK(to_interfaces_tck), .BIST_CMP(BIST_CMP_ts1), 
      .INCLUDE_MEM_RESULTS_REG(INCLUDE_MEM_RESULTS_REG), .BIST_READENABLE(BIST_READENABLE_ts1), 
      .BIST_WRITEENABLE(BIST_WRITEENABLE_ts1), .BIST_ROW_ADD({
      BIST_ROW_ADD_ts7, BIST_ROW_ADD_ts6, BIST_ROW_ADD_ts5, BIST_ROW_ADD_ts4}), .BIST_BANK_ADD({
      BIST_BANK_ADD_ts7, BIST_BANK_ADD_ts6, BIST_BANK_ADD_ts5, 
      BIST_BANK_ADD_ts4}), .BIST_TEST_PORT(BIST_TEST_PORT_ts1), .BIST_WRITE_DATA({
      BIST_WRITE_DATA_ts15, BIST_WRITE_DATA_ts14, BIST_WRITE_DATA_ts13, 
      BIST_WRITE_DATA_ts12, BIST_WRITE_DATA_ts11, BIST_WRITE_DATA_ts10, 
      BIST_WRITE_DATA_ts9, BIST_WRITE_DATA_ts8}), .BIST_TESTDATA_SELECT_TO_COLLAR(BIST_TESTDATA_SELECT_TO_COLLAR_ts1), 
      .MEM_BYPASS_EN(memory_bypass_to_en), .SCAN_SHIFT_EN(scan_to_en), .MCP_BOUNDING_EN(mcp_bounding_to_en), 
      .BIST_ON(BIST_ON_TO_COLLAR_ts1), .BIST_RUN(BIST_RUN_TO_COLLAR13_ts1), .BIST_ASYNC_RESETN(BIST_ASYNC_RESET), 
      .BIST_CLK(clk_a), .BIST_SHIFT_COLLAR(BIST_SHIFT_COLLAR_ts1), .BIST_EXPECT_DATA({
      BIST_EXPECT_DATA_ts15, BIST_EXPECT_DATA_ts14, BIST_EXPECT_DATA_ts13, 
      BIST_EXPECT_DATA_ts12, BIST_EXPECT_DATA_ts11, BIST_EXPECT_DATA_ts10, 
      BIST_EXPECT_DATA_ts9, BIST_EXPECT_DATA_ts8}), .BIST_SI(MEM13_BIST_COLLAR_SI_ts1), 
      .BIST_COLLAR_SETUP(BIST_COLLAR_SETUP_ts1), .BIST_COLLAR_OPSET_SELECT(BIST_COLLAR_OPSET_SELECT_ts1), 
      .BIST_COLLAR_HOLD(BIST_COLLAR_HOLD_ts1), .BIST_BIRA_EN(BIST_COLLAR_BIRA_EN_ts1), 
      .CHECK_REPAIR_NEEDED(CHECK_REPAIR_NEEDED), .BIST_DIAG_EN(BIST_COLLAR_DIAG_EN_ts1), 
      .BIST_CLEAR_DEFAULT(BIST_CLEAR_DEFAULT_ts1), .BIST_CLEAR(BIST_CLEAR_ts1), 
      .BIST_SETUP2(BIST_SETUP_ts2), .BIST_SETUP1(BIST_SETUP_ts1), .BIST_SETUP0(BIST_SETUP), 
      .LV_TM(ltest_to_en), .FREEZE_STOP_ERROR(FREEZE_STOP_ERROR_ts1), .GO_ID_REG_SEL(GO_ID_REG_SEL_ts1), 
      .BIST_COLLAR_EN(BIST_COLLAR_EN13_ts1), .FROM_BISR_All_SCOL0_FUSE_REG(ram_row_50_col_0_bisr_inst_Q[6:1]), 
      .FROM_BISR_All_SCOL0_ALLOC_REG(ram_row_50_col_0_bisr_inst_Q[0]), .BIST_SHIFT_BIRA_COLLAR(BIST_SHIFT_BIRA_COLLAR_ts1), 
      .RESET_REG_SETUP2(MBISTPG_RESET_REG_SETUP2_ts1), .ERROR_CNT_ZERO(ERROR_CNT_ZERO_ts1), 
      .WREN_P0(WREN_P0_ts45), .WREN_P1(WREN_P1_ts45), .RDEN_P0(RDEN_P0_ts45), .RDEN_P1(RDEN_P1_ts45), 
      .ADRRD_P0(ADRRD_P0_ts45), .ADRRD_P1(ADRRD_P1_ts45), .ADRWR_P0(ADRWR_P0_ts45), 
      .ADRWR_P1(ADRWR_P1_ts45), .DIN_P0(DIN_P0_ts45), .DIN_P1(DIN_P1_ts45), .BIST_SO(BIST_SO_ts45), 
      .BIST_GO(BIST_GO_ts45), .All_SCOL0_FUSE_REG(All_SCOL0_FUSE_REG_ts45[5:0]), 
      .All_SCOL0_ALLOC_REG(All_SCOL0_ALLOC_REG_ts45), .REPAIR_STATUS(), .fscan_clkungate(fscan_clkungate)
  );

  hlp_sched_apr_rtl_tessent_mbist_RF_c4_interface_MEM15 ram_row_51_col_0_interface_inst(
      .BIST_SHADOW_READENABLE(BIST_SHADOW_READENABLE_ts1), .BIST_SHADOW_READADDRESS(BIST_SHADOW_READADDRESS_ts1), 
      .BIST_CONREAD_ROWADDRESS(BIST_CONREAD_ROWADDRESS_ts1), .BIST_CONREAD_ENABLE(BIST_CONREAD_ENABLE_ts1), 
      .BIST_CONWRITE_ROWADDRESS(BIST_CONWRITE_ROWADDRESS_ts1), .BIST_CONWRITE_ENABLE(BIST_CONWRITE_ENABLE_ts1), 
      .BIST_CLEAR_BIRA(BIST_CLEAR_BIRA_ts1), .WREN_P0_IN(ram_row_51_col_0_wr_en_a), 
      .WREN_P1_IN(ram_row_51_col_0_wr_en_b), .RDEN_P0_IN(ram_row_51_col_0_rd_en_a), 
      .RDEN_P1_IN(ram_row_51_col_0_rd_en_b), .ADRRD_P0_IN(ram_row_51_col_0_rd_adr_a[7:0]), 
      .ADRRD_P1_IN(ram_row_51_col_0_rd_adr_b[7:0]), .ADRWR_P0_IN(ram_row_51_col_0_wr_adr_a[7:0]), 
      .ADRWR_P1_IN(ram_row_51_col_0_wr_adr_b[7:0]), .QOUT_P0(ram_row_51_col_0_data_out_a), 
      .QOUT_P1(ram_row_51_col_0_data_out_b), .DIN_P0_IN(ram_row_51_col_0_data_in_a[33:0]), 
      .DIN_P1_IN(ram_row_51_col_0_data_in_b[33:0]), .TCK(to_interfaces_tck), .BIST_CMP(BIST_CMP_ts1), 
      .INCLUDE_MEM_RESULTS_REG(INCLUDE_MEM_RESULTS_REG), .BIST_READENABLE(BIST_READENABLE_ts1), 
      .BIST_WRITEENABLE(BIST_WRITEENABLE_ts1), .BIST_ROW_ADD({
      BIST_ROW_ADD_ts7, BIST_ROW_ADD_ts6, BIST_ROW_ADD_ts5, BIST_ROW_ADD_ts4}), .BIST_BANK_ADD({
      BIST_BANK_ADD_ts7, BIST_BANK_ADD_ts6, BIST_BANK_ADD_ts5, 
      BIST_BANK_ADD_ts4}), .BIST_TEST_PORT(BIST_TEST_PORT_ts1), .BIST_WRITE_DATA({
      BIST_WRITE_DATA_ts15, BIST_WRITE_DATA_ts14, BIST_WRITE_DATA_ts13, 
      BIST_WRITE_DATA_ts12, BIST_WRITE_DATA_ts11, BIST_WRITE_DATA_ts10, 
      BIST_WRITE_DATA_ts9, BIST_WRITE_DATA_ts8}), .BIST_TESTDATA_SELECT_TO_COLLAR(BIST_TESTDATA_SELECT_TO_COLLAR_ts1), 
      .MEM_BYPASS_EN(memory_bypass_to_en), .SCAN_SHIFT_EN(scan_to_en), .MCP_BOUNDING_EN(mcp_bounding_to_en), 
      .BIST_ON(BIST_ON_TO_COLLAR_ts1), .BIST_RUN(BIST_RUN_TO_COLLAR14_ts1), .BIST_ASYNC_RESETN(BIST_ASYNC_RESET), 
      .BIST_CLK(clk_a), .BIST_SHIFT_COLLAR(BIST_SHIFT_COLLAR_ts1), .BIST_EXPECT_DATA({
      BIST_EXPECT_DATA_ts15, BIST_EXPECT_DATA_ts14, BIST_EXPECT_DATA_ts13, 
      BIST_EXPECT_DATA_ts12, BIST_EXPECT_DATA_ts11, BIST_EXPECT_DATA_ts10, 
      BIST_EXPECT_DATA_ts9, BIST_EXPECT_DATA_ts8}), .BIST_SI(MEM14_BIST_COLLAR_SI_ts1), 
      .BIST_COLLAR_SETUP(BIST_COLLAR_SETUP_ts1), .BIST_COLLAR_OPSET_SELECT(BIST_COLLAR_OPSET_SELECT_ts1), 
      .BIST_COLLAR_HOLD(BIST_COLLAR_HOLD_ts1), .BIST_BIRA_EN(BIST_COLLAR_BIRA_EN_ts1), 
      .CHECK_REPAIR_NEEDED(CHECK_REPAIR_NEEDED), .BIST_DIAG_EN(BIST_COLLAR_DIAG_EN_ts1), 
      .BIST_CLEAR_DEFAULT(BIST_CLEAR_DEFAULT_ts1), .BIST_CLEAR(BIST_CLEAR_ts1), 
      .BIST_SETUP2(BIST_SETUP_ts2), .BIST_SETUP1(BIST_SETUP_ts1), .BIST_SETUP0(BIST_SETUP), 
      .LV_TM(ltest_to_en), .FREEZE_STOP_ERROR(FREEZE_STOP_ERROR_ts1), .GO_ID_REG_SEL(GO_ID_REG_SEL_ts1), 
      .BIST_COLLAR_EN(BIST_COLLAR_EN14_ts1), .FROM_BISR_All_SCOL0_FUSE_REG(ram_row_51_col_0_bisr_inst_Q[6:1]), 
      .FROM_BISR_All_SCOL0_ALLOC_REG(ram_row_51_col_0_bisr_inst_Q[0]), .BIST_SHIFT_BIRA_COLLAR(BIST_SHIFT_BIRA_COLLAR_ts1), 
      .RESET_REG_SETUP2(MBISTPG_RESET_REG_SETUP2_ts1), .ERROR_CNT_ZERO(ERROR_CNT_ZERO_ts1), 
      .WREN_P0(WREN_P0_ts46), .WREN_P1(WREN_P1_ts46), .RDEN_P0(RDEN_P0_ts46), .RDEN_P1(RDEN_P1_ts46), 
      .ADRRD_P0(ADRRD_P0_ts46), .ADRRD_P1(ADRRD_P1_ts46), .ADRWR_P0(ADRWR_P0_ts46), 
      .ADRWR_P1(ADRWR_P1_ts46), .DIN_P0(DIN_P0_ts46), .DIN_P1(DIN_P1_ts46), .BIST_SO(BIST_SO_ts46), 
      .BIST_GO(BIST_GO_ts46), .All_SCOL0_FUSE_REG(All_SCOL0_FUSE_REG_ts46[5:0]), 
      .All_SCOL0_ALLOC_REG(All_SCOL0_ALLOC_REG_ts46), .REPAIR_STATUS(), .fscan_clkungate(fscan_clkungate)
  );

  hlp_sched_apr_rtl_tessent_mbist_RF_c4_interface_MEM16 ram_row_52_col_0_interface_inst(
      .BIST_SHADOW_READENABLE(BIST_SHADOW_READENABLE_ts1), .BIST_SHADOW_READADDRESS(BIST_SHADOW_READADDRESS_ts1), 
      .BIST_CONREAD_ROWADDRESS(BIST_CONREAD_ROWADDRESS_ts1), .BIST_CONREAD_ENABLE(BIST_CONREAD_ENABLE_ts1), 
      .BIST_CONWRITE_ROWADDRESS(BIST_CONWRITE_ROWADDRESS_ts1), .BIST_CONWRITE_ENABLE(BIST_CONWRITE_ENABLE_ts1), 
      .BIST_CLEAR_BIRA(BIST_CLEAR_BIRA_ts1), .WREN_P0_IN(ram_row_52_col_0_wr_en_a), 
      .WREN_P1_IN(ram_row_52_col_0_wr_en_b), .RDEN_P0_IN(ram_row_52_col_0_rd_en_a), 
      .RDEN_P1_IN(ram_row_52_col_0_rd_en_b), .ADRRD_P0_IN(ram_row_52_col_0_rd_adr_a[7:0]), 
      .ADRRD_P1_IN(ram_row_52_col_0_rd_adr_b[7:0]), .ADRWR_P0_IN(ram_row_52_col_0_wr_adr_a[7:0]), 
      .ADRWR_P1_IN(ram_row_52_col_0_wr_adr_b[7:0]), .QOUT_P0(ram_row_52_col_0_data_out_a), 
      .QOUT_P1(ram_row_52_col_0_data_out_b), .DIN_P0_IN(ram_row_52_col_0_data_in_a[33:0]), 
      .DIN_P1_IN(ram_row_52_col_0_data_in_b[33:0]), .TCK(to_interfaces_tck), .BIST_CMP(BIST_CMP_ts1), 
      .INCLUDE_MEM_RESULTS_REG(INCLUDE_MEM_RESULTS_REG), .BIST_READENABLE(BIST_READENABLE_ts1), 
      .BIST_WRITEENABLE(BIST_WRITEENABLE_ts1), .BIST_ROW_ADD({
      BIST_ROW_ADD_ts7, BIST_ROW_ADD_ts6, BIST_ROW_ADD_ts5, BIST_ROW_ADD_ts4}), .BIST_BANK_ADD({
      BIST_BANK_ADD_ts7, BIST_BANK_ADD_ts6, BIST_BANK_ADD_ts5, 
      BIST_BANK_ADD_ts4}), .BIST_TEST_PORT(BIST_TEST_PORT_ts1), .BIST_WRITE_DATA({
      BIST_WRITE_DATA_ts15, BIST_WRITE_DATA_ts14, BIST_WRITE_DATA_ts13, 
      BIST_WRITE_DATA_ts12, BIST_WRITE_DATA_ts11, BIST_WRITE_DATA_ts10, 
      BIST_WRITE_DATA_ts9, BIST_WRITE_DATA_ts8}), .BIST_TESTDATA_SELECT_TO_COLLAR(BIST_TESTDATA_SELECT_TO_COLLAR_ts1), 
      .MEM_BYPASS_EN(memory_bypass_to_en), .SCAN_SHIFT_EN(scan_to_en), .MCP_BOUNDING_EN(mcp_bounding_to_en), 
      .BIST_ON(BIST_ON_TO_COLLAR_ts1), .BIST_RUN(BIST_RUN_TO_COLLAR15_ts1), .BIST_ASYNC_RESETN(BIST_ASYNC_RESET), 
      .BIST_CLK(clk_a), .BIST_SHIFT_COLLAR(BIST_SHIFT_COLLAR_ts1), .BIST_EXPECT_DATA({
      BIST_EXPECT_DATA_ts15, BIST_EXPECT_DATA_ts14, BIST_EXPECT_DATA_ts13, 
      BIST_EXPECT_DATA_ts12, BIST_EXPECT_DATA_ts11, BIST_EXPECT_DATA_ts10, 
      BIST_EXPECT_DATA_ts9, BIST_EXPECT_DATA_ts8}), .BIST_SI(MEM15_BIST_COLLAR_SI_ts1), 
      .BIST_COLLAR_SETUP(BIST_COLLAR_SETUP_ts1), .BIST_COLLAR_OPSET_SELECT(BIST_COLLAR_OPSET_SELECT_ts1), 
      .BIST_COLLAR_HOLD(BIST_COLLAR_HOLD_ts1), .BIST_BIRA_EN(BIST_COLLAR_BIRA_EN_ts1), 
      .CHECK_REPAIR_NEEDED(CHECK_REPAIR_NEEDED), .BIST_DIAG_EN(BIST_COLLAR_DIAG_EN_ts1), 
      .BIST_CLEAR_DEFAULT(BIST_CLEAR_DEFAULT_ts1), .BIST_CLEAR(BIST_CLEAR_ts1), 
      .BIST_SETUP2(BIST_SETUP_ts2), .BIST_SETUP1(BIST_SETUP_ts1), .BIST_SETUP0(BIST_SETUP), 
      .LV_TM(ltest_to_en), .FREEZE_STOP_ERROR(FREEZE_STOP_ERROR_ts1), .GO_ID_REG_SEL(GO_ID_REG_SEL_ts1), 
      .BIST_COLLAR_EN(BIST_COLLAR_EN15_ts1), .FROM_BISR_All_SCOL0_FUSE_REG(ram_row_52_col_0_bisr_inst_Q[6:1]), 
      .FROM_BISR_All_SCOL0_ALLOC_REG(ram_row_52_col_0_bisr_inst_Q[0]), .BIST_SHIFT_BIRA_COLLAR(BIST_SHIFT_BIRA_COLLAR_ts1), 
      .RESET_REG_SETUP2(MBISTPG_RESET_REG_SETUP2_ts1), .ERROR_CNT_ZERO(ERROR_CNT_ZERO_ts1), 
      .WREN_P0(WREN_P0_ts47), .WREN_P1(WREN_P1_ts47), .RDEN_P0(RDEN_P0_ts47), .RDEN_P1(RDEN_P1_ts47), 
      .ADRRD_P0(ADRRD_P0_ts47), .ADRRD_P1(ADRRD_P1_ts47), .ADRWR_P0(ADRWR_P0_ts47), 
      .ADRWR_P1(ADRWR_P1_ts47), .DIN_P0(DIN_P0_ts47), .DIN_P1(DIN_P1_ts47), .BIST_SO(BIST_SO_ts47), 
      .BIST_GO(BIST_GO_ts47), .All_SCOL0_FUSE_REG(All_SCOL0_FUSE_REG_ts47[5:0]), 
      .All_SCOL0_ALLOC_REG(All_SCOL0_ALLOC_REG_ts47), .REPAIR_STATUS(), .fscan_clkungate(fscan_clkungate)
  );

  hlp_sched_apr_rtl_tessent_mbist_RF_c4_interface_MEM17 ram_row_53_col_0_interface_inst(
      .BIST_SHADOW_READENABLE(BIST_SHADOW_READENABLE_ts1), .BIST_SHADOW_READADDRESS(BIST_SHADOW_READADDRESS_ts1), 
      .BIST_CONREAD_ROWADDRESS(BIST_CONREAD_ROWADDRESS_ts1), .BIST_CONREAD_ENABLE(BIST_CONREAD_ENABLE_ts1), 
      .BIST_CONWRITE_ROWADDRESS(BIST_CONWRITE_ROWADDRESS_ts1), .BIST_CONWRITE_ENABLE(BIST_CONWRITE_ENABLE_ts1), 
      .BIST_CLEAR_BIRA(BIST_CLEAR_BIRA_ts1), .WREN_P0_IN(ram_row_53_col_0_wr_en_a), 
      .WREN_P1_IN(ram_row_53_col_0_wr_en_b), .RDEN_P0_IN(ram_row_53_col_0_rd_en_a), 
      .RDEN_P1_IN(ram_row_53_col_0_rd_en_b), .ADRRD_P0_IN(ram_row_53_col_0_rd_adr_a[7:0]), 
      .ADRRD_P1_IN(ram_row_53_col_0_rd_adr_b[7:0]), .ADRWR_P0_IN(ram_row_53_col_0_wr_adr_a[7:0]), 
      .ADRWR_P1_IN(ram_row_53_col_0_wr_adr_b[7:0]), .QOUT_P0(ram_row_53_col_0_data_out_a), 
      .QOUT_P1(ram_row_53_col_0_data_out_b), .DIN_P0_IN(ram_row_53_col_0_data_in_a[33:0]), 
      .DIN_P1_IN(ram_row_53_col_0_data_in_b[33:0]), .TCK(to_interfaces_tck), .BIST_CMP(BIST_CMP_ts1), 
      .INCLUDE_MEM_RESULTS_REG(INCLUDE_MEM_RESULTS_REG), .BIST_READENABLE(BIST_READENABLE_ts1), 
      .BIST_WRITEENABLE(BIST_WRITEENABLE_ts1), .BIST_ROW_ADD({
      BIST_ROW_ADD_ts7, BIST_ROW_ADD_ts6, BIST_ROW_ADD_ts5, BIST_ROW_ADD_ts4}), .BIST_BANK_ADD({
      BIST_BANK_ADD_ts7, BIST_BANK_ADD_ts6, BIST_BANK_ADD_ts5, 
      BIST_BANK_ADD_ts4}), .BIST_TEST_PORT(BIST_TEST_PORT_ts1), .BIST_WRITE_DATA({
      BIST_WRITE_DATA_ts15, BIST_WRITE_DATA_ts14, BIST_WRITE_DATA_ts13, 
      BIST_WRITE_DATA_ts12, BIST_WRITE_DATA_ts11, BIST_WRITE_DATA_ts10, 
      BIST_WRITE_DATA_ts9, BIST_WRITE_DATA_ts8}), .BIST_TESTDATA_SELECT_TO_COLLAR(BIST_TESTDATA_SELECT_TO_COLLAR_ts1), 
      .MEM_BYPASS_EN(memory_bypass_to_en), .SCAN_SHIFT_EN(scan_to_en), .MCP_BOUNDING_EN(mcp_bounding_to_en), 
      .BIST_ON(BIST_ON_TO_COLLAR_ts1), .BIST_RUN(BIST_RUN_TO_COLLAR16_ts1), .BIST_ASYNC_RESETN(BIST_ASYNC_RESET), 
      .BIST_CLK(clk_a), .BIST_SHIFT_COLLAR(BIST_SHIFT_COLLAR_ts1), .BIST_EXPECT_DATA({
      BIST_EXPECT_DATA_ts15, BIST_EXPECT_DATA_ts14, BIST_EXPECT_DATA_ts13, 
      BIST_EXPECT_DATA_ts12, BIST_EXPECT_DATA_ts11, BIST_EXPECT_DATA_ts10, 
      BIST_EXPECT_DATA_ts9, BIST_EXPECT_DATA_ts8}), .BIST_SI(MEM16_BIST_COLLAR_SI_ts1), 
      .BIST_COLLAR_SETUP(BIST_COLLAR_SETUP_ts1), .BIST_COLLAR_OPSET_SELECT(BIST_COLLAR_OPSET_SELECT_ts1), 
      .BIST_COLLAR_HOLD(BIST_COLLAR_HOLD_ts1), .BIST_BIRA_EN(BIST_COLLAR_BIRA_EN_ts1), 
      .CHECK_REPAIR_NEEDED(CHECK_REPAIR_NEEDED), .BIST_DIAG_EN(BIST_COLLAR_DIAG_EN_ts1), 
      .BIST_CLEAR_DEFAULT(BIST_CLEAR_DEFAULT_ts1), .BIST_CLEAR(BIST_CLEAR_ts1), 
      .BIST_SETUP2(BIST_SETUP_ts2), .BIST_SETUP1(BIST_SETUP_ts1), .BIST_SETUP0(BIST_SETUP), 
      .LV_TM(ltest_to_en), .FREEZE_STOP_ERROR(FREEZE_STOP_ERROR_ts1), .GO_ID_REG_SEL(GO_ID_REG_SEL_ts1), 
      .BIST_COLLAR_EN(BIST_COLLAR_EN16_ts1), .FROM_BISR_All_SCOL0_FUSE_REG(ram_row_53_col_0_bisr_inst_Q[6:1]), 
      .FROM_BISR_All_SCOL0_ALLOC_REG(ram_row_53_col_0_bisr_inst_Q[0]), .BIST_SHIFT_BIRA_COLLAR(BIST_SHIFT_BIRA_COLLAR_ts1), 
      .RESET_REG_SETUP2(MBISTPG_RESET_REG_SETUP2_ts1), .ERROR_CNT_ZERO(ERROR_CNT_ZERO_ts1), 
      .WREN_P0(WREN_P0_ts48), .WREN_P1(WREN_P1_ts48), .RDEN_P0(RDEN_P0_ts48), .RDEN_P1(RDEN_P1_ts48), 
      .ADRRD_P0(ADRRD_P0_ts48), .ADRRD_P1(ADRRD_P1_ts48), .ADRWR_P0(ADRWR_P0_ts48), 
      .ADRWR_P1(ADRWR_P1_ts48), .DIN_P0(DIN_P0_ts48), .DIN_P1(DIN_P1_ts48), .BIST_SO(BIST_SO_ts48), 
      .BIST_GO(BIST_GO_ts48), .All_SCOL0_FUSE_REG(All_SCOL0_FUSE_REG_ts48[5:0]), 
      .All_SCOL0_ALLOC_REG(All_SCOL0_ALLOC_REG_ts48), .REPAIR_STATUS(), .fscan_clkungate(fscan_clkungate)
  );

  hlp_sched_apr_rtl_tessent_mbist_RF_c4_interface_MEM18 ram_row_54_col_0_interface_inst(
      .BIST_SHADOW_READENABLE(BIST_SHADOW_READENABLE_ts1), .BIST_SHADOW_READADDRESS(BIST_SHADOW_READADDRESS_ts1), 
      .BIST_CONREAD_ROWADDRESS(BIST_CONREAD_ROWADDRESS_ts1), .BIST_CONREAD_ENABLE(BIST_CONREAD_ENABLE_ts1), 
      .BIST_CONWRITE_ROWADDRESS(BIST_CONWRITE_ROWADDRESS_ts1), .BIST_CONWRITE_ENABLE(BIST_CONWRITE_ENABLE_ts1), 
      .BIST_CLEAR_BIRA(BIST_CLEAR_BIRA_ts1), .WREN_P0_IN(ram_row_54_col_0_wr_en_a), 
      .WREN_P1_IN(ram_row_54_col_0_wr_en_b), .RDEN_P0_IN(ram_row_54_col_0_rd_en_a), 
      .RDEN_P1_IN(ram_row_54_col_0_rd_en_b), .ADRRD_P0_IN(ram_row_54_col_0_rd_adr_a[7:0]), 
      .ADRRD_P1_IN(ram_row_54_col_0_rd_adr_b[7:0]), .ADRWR_P0_IN(ram_row_54_col_0_wr_adr_a[7:0]), 
      .ADRWR_P1_IN(ram_row_54_col_0_wr_adr_b[7:0]), .QOUT_P0(ram_row_54_col_0_data_out_a), 
      .QOUT_P1(ram_row_54_col_0_data_out_b), .DIN_P0_IN(ram_row_54_col_0_data_in_a[33:0]), 
      .DIN_P1_IN(ram_row_54_col_0_data_in_b[33:0]), .TCK(to_interfaces_tck), .BIST_CMP(BIST_CMP_ts1), 
      .INCLUDE_MEM_RESULTS_REG(INCLUDE_MEM_RESULTS_REG), .BIST_READENABLE(BIST_READENABLE_ts1), 
      .BIST_WRITEENABLE(BIST_WRITEENABLE_ts1), .BIST_ROW_ADD({
      BIST_ROW_ADD_ts7, BIST_ROW_ADD_ts6, BIST_ROW_ADD_ts5, BIST_ROW_ADD_ts4}), .BIST_BANK_ADD({
      BIST_BANK_ADD_ts7, BIST_BANK_ADD_ts6, BIST_BANK_ADD_ts5, 
      BIST_BANK_ADD_ts4}), .BIST_TEST_PORT(BIST_TEST_PORT_ts1), .BIST_WRITE_DATA({
      BIST_WRITE_DATA_ts15, BIST_WRITE_DATA_ts14, BIST_WRITE_DATA_ts13, 
      BIST_WRITE_DATA_ts12, BIST_WRITE_DATA_ts11, BIST_WRITE_DATA_ts10, 
      BIST_WRITE_DATA_ts9, BIST_WRITE_DATA_ts8}), .BIST_TESTDATA_SELECT_TO_COLLAR(BIST_TESTDATA_SELECT_TO_COLLAR_ts1), 
      .MEM_BYPASS_EN(memory_bypass_to_en), .SCAN_SHIFT_EN(scan_to_en), .MCP_BOUNDING_EN(mcp_bounding_to_en), 
      .BIST_ON(BIST_ON_TO_COLLAR_ts1), .BIST_RUN(BIST_RUN_TO_COLLAR17_ts1), .BIST_ASYNC_RESETN(BIST_ASYNC_RESET), 
      .BIST_CLK(clk_a), .BIST_SHIFT_COLLAR(BIST_SHIFT_COLLAR_ts1), .BIST_EXPECT_DATA({
      BIST_EXPECT_DATA_ts15, BIST_EXPECT_DATA_ts14, BIST_EXPECT_DATA_ts13, 
      BIST_EXPECT_DATA_ts12, BIST_EXPECT_DATA_ts11, BIST_EXPECT_DATA_ts10, 
      BIST_EXPECT_DATA_ts9, BIST_EXPECT_DATA_ts8}), .BIST_SI(MEM17_BIST_COLLAR_SI_ts1), 
      .BIST_COLLAR_SETUP(BIST_COLLAR_SETUP_ts1), .BIST_COLLAR_OPSET_SELECT(BIST_COLLAR_OPSET_SELECT_ts1), 
      .BIST_COLLAR_HOLD(BIST_COLLAR_HOLD_ts1), .BIST_BIRA_EN(BIST_COLLAR_BIRA_EN_ts1), 
      .CHECK_REPAIR_NEEDED(CHECK_REPAIR_NEEDED), .BIST_DIAG_EN(BIST_COLLAR_DIAG_EN_ts1), 
      .BIST_CLEAR_DEFAULT(BIST_CLEAR_DEFAULT_ts1), .BIST_CLEAR(BIST_CLEAR_ts1), 
      .BIST_SETUP2(BIST_SETUP_ts2), .BIST_SETUP1(BIST_SETUP_ts1), .BIST_SETUP0(BIST_SETUP), 
      .LV_TM(ltest_to_en), .FREEZE_STOP_ERROR(FREEZE_STOP_ERROR_ts1), .GO_ID_REG_SEL(GO_ID_REG_SEL_ts1), 
      .BIST_COLLAR_EN(BIST_COLLAR_EN17_ts1), .FROM_BISR_All_SCOL0_FUSE_REG(ram_row_54_col_0_bisr_inst_Q[6:1]), 
      .FROM_BISR_All_SCOL0_ALLOC_REG(ram_row_54_col_0_bisr_inst_Q[0]), .BIST_SHIFT_BIRA_COLLAR(BIST_SHIFT_BIRA_COLLAR_ts1), 
      .RESET_REG_SETUP2(MBISTPG_RESET_REG_SETUP2_ts1), .ERROR_CNT_ZERO(ERROR_CNT_ZERO_ts1), 
      .WREN_P0(WREN_P0_ts49), .WREN_P1(WREN_P1_ts49), .RDEN_P0(RDEN_P0_ts49), .RDEN_P1(RDEN_P1_ts49), 
      .ADRRD_P0(ADRRD_P0_ts49), .ADRRD_P1(ADRRD_P1_ts49), .ADRWR_P0(ADRWR_P0_ts49), 
      .ADRWR_P1(ADRWR_P1_ts49), .DIN_P0(DIN_P0_ts49), .DIN_P1(DIN_P1_ts49), .BIST_SO(BIST_SO_ts49), 
      .BIST_GO(BIST_GO_ts49), .All_SCOL0_FUSE_REG(All_SCOL0_FUSE_REG_ts49[5:0]), 
      .All_SCOL0_ALLOC_REG(All_SCOL0_ALLOC_REG_ts49), .REPAIR_STATUS(), .fscan_clkungate(fscan_clkungate)
  );

  hlp_sched_apr_rtl_tessent_mbist_RF_c4_interface_MEM19 ram_row_55_col_0_interface_inst(
      .BIST_SHADOW_READENABLE(BIST_SHADOW_READENABLE_ts1), .BIST_SHADOW_READADDRESS(BIST_SHADOW_READADDRESS_ts1), 
      .BIST_CONREAD_ROWADDRESS(BIST_CONREAD_ROWADDRESS_ts1), .BIST_CONREAD_ENABLE(BIST_CONREAD_ENABLE_ts1), 
      .BIST_CONWRITE_ROWADDRESS(BIST_CONWRITE_ROWADDRESS_ts1), .BIST_CONWRITE_ENABLE(BIST_CONWRITE_ENABLE_ts1), 
      .BIST_CLEAR_BIRA(BIST_CLEAR_BIRA_ts1), .WREN_P0_IN(ram_row_55_col_0_wr_en_a), 
      .WREN_P1_IN(ram_row_55_col_0_wr_en_b), .RDEN_P0_IN(ram_row_55_col_0_rd_en_a), 
      .RDEN_P1_IN(ram_row_55_col_0_rd_en_b), .ADRRD_P0_IN(ram_row_55_col_0_rd_adr_a[7:0]), 
      .ADRRD_P1_IN(ram_row_55_col_0_rd_adr_b[7:0]), .ADRWR_P0_IN(ram_row_55_col_0_wr_adr_a[7:0]), 
      .ADRWR_P1_IN(ram_row_55_col_0_wr_adr_b[7:0]), .QOUT_P0(ram_row_55_col_0_data_out_a), 
      .QOUT_P1(ram_row_55_col_0_data_out_b), .DIN_P0_IN(ram_row_55_col_0_data_in_a[33:0]), 
      .DIN_P1_IN(ram_row_55_col_0_data_in_b[33:0]), .TCK(to_interfaces_tck), .BIST_CMP(BIST_CMP_ts1), 
      .INCLUDE_MEM_RESULTS_REG(INCLUDE_MEM_RESULTS_REG), .BIST_READENABLE(BIST_READENABLE_ts1), 
      .BIST_WRITEENABLE(BIST_WRITEENABLE_ts1), .BIST_ROW_ADD({
      BIST_ROW_ADD_ts7, BIST_ROW_ADD_ts6, BIST_ROW_ADD_ts5, BIST_ROW_ADD_ts4}), .BIST_BANK_ADD({
      BIST_BANK_ADD_ts7, BIST_BANK_ADD_ts6, BIST_BANK_ADD_ts5, 
      BIST_BANK_ADD_ts4}), .BIST_TEST_PORT(BIST_TEST_PORT_ts1), .BIST_WRITE_DATA({
      BIST_WRITE_DATA_ts15, BIST_WRITE_DATA_ts14, BIST_WRITE_DATA_ts13, 
      BIST_WRITE_DATA_ts12, BIST_WRITE_DATA_ts11, BIST_WRITE_DATA_ts10, 
      BIST_WRITE_DATA_ts9, BIST_WRITE_DATA_ts8}), .BIST_TESTDATA_SELECT_TO_COLLAR(BIST_TESTDATA_SELECT_TO_COLLAR_ts1), 
      .MEM_BYPASS_EN(memory_bypass_to_en), .SCAN_SHIFT_EN(scan_to_en), .MCP_BOUNDING_EN(mcp_bounding_to_en), 
      .BIST_ON(BIST_ON_TO_COLLAR_ts1), .BIST_RUN(BIST_RUN_TO_COLLAR18_ts1), .BIST_ASYNC_RESETN(BIST_ASYNC_RESET), 
      .BIST_CLK(clk_a), .BIST_SHIFT_COLLAR(BIST_SHIFT_COLLAR_ts1), .BIST_EXPECT_DATA({
      BIST_EXPECT_DATA_ts15, BIST_EXPECT_DATA_ts14, BIST_EXPECT_DATA_ts13, 
      BIST_EXPECT_DATA_ts12, BIST_EXPECT_DATA_ts11, BIST_EXPECT_DATA_ts10, 
      BIST_EXPECT_DATA_ts9, BIST_EXPECT_DATA_ts8}), .BIST_SI(MEM18_BIST_COLLAR_SI_ts1), 
      .BIST_COLLAR_SETUP(BIST_COLLAR_SETUP_ts1), .BIST_COLLAR_OPSET_SELECT(BIST_COLLAR_OPSET_SELECT_ts1), 
      .BIST_COLLAR_HOLD(BIST_COLLAR_HOLD_ts1), .BIST_BIRA_EN(BIST_COLLAR_BIRA_EN_ts1), 
      .CHECK_REPAIR_NEEDED(CHECK_REPAIR_NEEDED), .BIST_DIAG_EN(BIST_COLLAR_DIAG_EN_ts1), 
      .BIST_CLEAR_DEFAULT(BIST_CLEAR_DEFAULT_ts1), .BIST_CLEAR(BIST_CLEAR_ts1), 
      .BIST_SETUP2(BIST_SETUP_ts2), .BIST_SETUP1(BIST_SETUP_ts1), .BIST_SETUP0(BIST_SETUP), 
      .LV_TM(ltest_to_en), .FREEZE_STOP_ERROR(FREEZE_STOP_ERROR_ts1), .GO_ID_REG_SEL(GO_ID_REG_SEL_ts1), 
      .BIST_COLLAR_EN(BIST_COLLAR_EN18_ts1), .FROM_BISR_All_SCOL0_FUSE_REG(ram_row_55_col_0_bisr_inst_Q[6:1]), 
      .FROM_BISR_All_SCOL0_ALLOC_REG(ram_row_55_col_0_bisr_inst_Q[0]), .BIST_SHIFT_BIRA_COLLAR(BIST_SHIFT_BIRA_COLLAR_ts1), 
      .RESET_REG_SETUP2(MBISTPG_RESET_REG_SETUP2_ts1), .ERROR_CNT_ZERO(ERROR_CNT_ZERO_ts1), 
      .WREN_P0(WREN_P0_ts50), .WREN_P1(WREN_P1_ts50), .RDEN_P0(RDEN_P0_ts50), .RDEN_P1(RDEN_P1_ts50), 
      .ADRRD_P0(ADRRD_P0_ts50), .ADRRD_P1(ADRRD_P1_ts50), .ADRWR_P0(ADRWR_P0_ts50), 
      .ADRWR_P1(ADRWR_P1_ts50), .DIN_P0(DIN_P0_ts50), .DIN_P1(DIN_P1_ts50), .BIST_SO(BIST_SO_ts50), 
      .BIST_GO(BIST_GO_ts50), .All_SCOL0_FUSE_REG(All_SCOL0_FUSE_REG_ts50[5:0]), 
      .All_SCOL0_ALLOC_REG(All_SCOL0_ALLOC_REG_ts50), .REPAIR_STATUS(), .fscan_clkungate(fscan_clkungate)
  );

  hlp_sched_apr_rtl_tessent_mbist_RF_c4_interface_MEM20 ram_row_56_col_0_interface_inst(
      .BIST_SHADOW_READENABLE(BIST_SHADOW_READENABLE_ts1), .BIST_SHADOW_READADDRESS(BIST_SHADOW_READADDRESS_ts1), 
      .BIST_CONREAD_ROWADDRESS(BIST_CONREAD_ROWADDRESS_ts1), .BIST_CONREAD_ENABLE(BIST_CONREAD_ENABLE_ts1), 
      .BIST_CONWRITE_ROWADDRESS(BIST_CONWRITE_ROWADDRESS_ts1), .BIST_CONWRITE_ENABLE(BIST_CONWRITE_ENABLE_ts1), 
      .BIST_CLEAR_BIRA(BIST_CLEAR_BIRA_ts1), .WREN_P0_IN(ram_row_56_col_0_wr_en_a), 
      .WREN_P1_IN(ram_row_56_col_0_wr_en_b), .RDEN_P0_IN(ram_row_56_col_0_rd_en_a), 
      .RDEN_P1_IN(ram_row_56_col_0_rd_en_b), .ADRRD_P0_IN(ram_row_56_col_0_rd_adr_a[7:0]), 
      .ADRRD_P1_IN(ram_row_56_col_0_rd_adr_b[7:0]), .ADRWR_P0_IN(ram_row_56_col_0_wr_adr_a[7:0]), 
      .ADRWR_P1_IN(ram_row_56_col_0_wr_adr_b[7:0]), .QOUT_P0(ram_row_56_col_0_data_out_a), 
      .QOUT_P1(ram_row_56_col_0_data_out_b), .DIN_P0_IN(ram_row_56_col_0_data_in_a[33:0]), 
      .DIN_P1_IN(ram_row_56_col_0_data_in_b[33:0]), .TCK(to_interfaces_tck), .BIST_CMP(BIST_CMP_ts1), 
      .INCLUDE_MEM_RESULTS_REG(INCLUDE_MEM_RESULTS_REG), .BIST_READENABLE(BIST_READENABLE_ts1), 
      .BIST_WRITEENABLE(BIST_WRITEENABLE_ts1), .BIST_ROW_ADD({
      BIST_ROW_ADD_ts7, BIST_ROW_ADD_ts6, BIST_ROW_ADD_ts5, BIST_ROW_ADD_ts4}), .BIST_BANK_ADD({
      BIST_BANK_ADD_ts7, BIST_BANK_ADD_ts6, BIST_BANK_ADD_ts5, 
      BIST_BANK_ADD_ts4}), .BIST_TEST_PORT(BIST_TEST_PORT_ts1), .BIST_WRITE_DATA({
      BIST_WRITE_DATA_ts15, BIST_WRITE_DATA_ts14, BIST_WRITE_DATA_ts13, 
      BIST_WRITE_DATA_ts12, BIST_WRITE_DATA_ts11, BIST_WRITE_DATA_ts10, 
      BIST_WRITE_DATA_ts9, BIST_WRITE_DATA_ts8}), .BIST_TESTDATA_SELECT_TO_COLLAR(BIST_TESTDATA_SELECT_TO_COLLAR_ts1), 
      .MEM_BYPASS_EN(memory_bypass_to_en), .SCAN_SHIFT_EN(scan_to_en), .MCP_BOUNDING_EN(mcp_bounding_to_en), 
      .BIST_ON(BIST_ON_TO_COLLAR_ts1), .BIST_RUN(BIST_RUN_TO_COLLAR19_ts1), .BIST_ASYNC_RESETN(BIST_ASYNC_RESET), 
      .BIST_CLK(clk_a), .BIST_SHIFT_COLLAR(BIST_SHIFT_COLLAR_ts1), .BIST_EXPECT_DATA({
      BIST_EXPECT_DATA_ts15, BIST_EXPECT_DATA_ts14, BIST_EXPECT_DATA_ts13, 
      BIST_EXPECT_DATA_ts12, BIST_EXPECT_DATA_ts11, BIST_EXPECT_DATA_ts10, 
      BIST_EXPECT_DATA_ts9, BIST_EXPECT_DATA_ts8}), .BIST_SI(MEM19_BIST_COLLAR_SI_ts1), 
      .BIST_COLLAR_SETUP(BIST_COLLAR_SETUP_ts1), .BIST_COLLAR_OPSET_SELECT(BIST_COLLAR_OPSET_SELECT_ts1), 
      .BIST_COLLAR_HOLD(BIST_COLLAR_HOLD_ts1), .BIST_BIRA_EN(BIST_COLLAR_BIRA_EN_ts1), 
      .CHECK_REPAIR_NEEDED(CHECK_REPAIR_NEEDED), .BIST_DIAG_EN(BIST_COLLAR_DIAG_EN_ts1), 
      .BIST_CLEAR_DEFAULT(BIST_CLEAR_DEFAULT_ts1), .BIST_CLEAR(BIST_CLEAR_ts1), 
      .BIST_SETUP2(BIST_SETUP_ts2), .BIST_SETUP1(BIST_SETUP_ts1), .BIST_SETUP0(BIST_SETUP), 
      .LV_TM(ltest_to_en), .FREEZE_STOP_ERROR(FREEZE_STOP_ERROR_ts1), .GO_ID_REG_SEL(GO_ID_REG_SEL_ts1), 
      .BIST_COLLAR_EN(BIST_COLLAR_EN19_ts1), .FROM_BISR_All_SCOL0_FUSE_REG(ram_row_56_col_0_bisr_inst_Q[6:1]), 
      .FROM_BISR_All_SCOL0_ALLOC_REG(ram_row_56_col_0_bisr_inst_Q[0]), .BIST_SHIFT_BIRA_COLLAR(BIST_SHIFT_BIRA_COLLAR_ts1), 
      .RESET_REG_SETUP2(MBISTPG_RESET_REG_SETUP2_ts1), .ERROR_CNT_ZERO(ERROR_CNT_ZERO_ts1), 
      .WREN_P0(WREN_P0_ts51), .WREN_P1(WREN_P1_ts51), .RDEN_P0(RDEN_P0_ts51), .RDEN_P1(RDEN_P1_ts51), 
      .ADRRD_P0(ADRRD_P0_ts51), .ADRRD_P1(ADRRD_P1_ts51), .ADRWR_P0(ADRWR_P0_ts51), 
      .ADRWR_P1(ADRWR_P1_ts51), .DIN_P0(DIN_P0_ts51), .DIN_P1(DIN_P1_ts51), .BIST_SO(BIST_SO_ts51), 
      .BIST_GO(BIST_GO_ts51), .All_SCOL0_FUSE_REG(All_SCOL0_FUSE_REG_ts51[5:0]), 
      .All_SCOL0_ALLOC_REG(All_SCOL0_ALLOC_REG_ts51), .REPAIR_STATUS(), .fscan_clkungate(fscan_clkungate)
  );

  hlp_sched_apr_rtl_tessent_mbist_RF_c4_interface_MEM21 ram_row_57_col_0_interface_inst(
      .BIST_SHADOW_READENABLE(BIST_SHADOW_READENABLE_ts1), .BIST_SHADOW_READADDRESS(BIST_SHADOW_READADDRESS_ts1), 
      .BIST_CONREAD_ROWADDRESS(BIST_CONREAD_ROWADDRESS_ts1), .BIST_CONREAD_ENABLE(BIST_CONREAD_ENABLE_ts1), 
      .BIST_CONWRITE_ROWADDRESS(BIST_CONWRITE_ROWADDRESS_ts1), .BIST_CONWRITE_ENABLE(BIST_CONWRITE_ENABLE_ts1), 
      .BIST_CLEAR_BIRA(BIST_CLEAR_BIRA_ts1), .WREN_P0_IN(ram_row_57_col_0_wr_en_a), 
      .WREN_P1_IN(ram_row_57_col_0_wr_en_b), .RDEN_P0_IN(ram_row_57_col_0_rd_en_a), 
      .RDEN_P1_IN(ram_row_57_col_0_rd_en_b), .ADRRD_P0_IN(ram_row_57_col_0_rd_adr_a[7:0]), 
      .ADRRD_P1_IN(ram_row_57_col_0_rd_adr_b[7:0]), .ADRWR_P0_IN(ram_row_57_col_0_wr_adr_a[7:0]), 
      .ADRWR_P1_IN(ram_row_57_col_0_wr_adr_b[7:0]), .QOUT_P0(ram_row_57_col_0_data_out_a), 
      .QOUT_P1(ram_row_57_col_0_data_out_b), .DIN_P0_IN(ram_row_57_col_0_data_in_a[33:0]), 
      .DIN_P1_IN(ram_row_57_col_0_data_in_b[33:0]), .TCK(to_interfaces_tck), .BIST_CMP(BIST_CMP_ts1), 
      .INCLUDE_MEM_RESULTS_REG(INCLUDE_MEM_RESULTS_REG), .BIST_READENABLE(BIST_READENABLE_ts1), 
      .BIST_WRITEENABLE(BIST_WRITEENABLE_ts1), .BIST_ROW_ADD({
      BIST_ROW_ADD_ts7, BIST_ROW_ADD_ts6, BIST_ROW_ADD_ts5, BIST_ROW_ADD_ts4}), .BIST_BANK_ADD({
      BIST_BANK_ADD_ts7, BIST_BANK_ADD_ts6, BIST_BANK_ADD_ts5, 
      BIST_BANK_ADD_ts4}), .BIST_TEST_PORT(BIST_TEST_PORT_ts1), .BIST_WRITE_DATA({
      BIST_WRITE_DATA_ts15, BIST_WRITE_DATA_ts14, BIST_WRITE_DATA_ts13, 
      BIST_WRITE_DATA_ts12, BIST_WRITE_DATA_ts11, BIST_WRITE_DATA_ts10, 
      BIST_WRITE_DATA_ts9, BIST_WRITE_DATA_ts8}), .BIST_TESTDATA_SELECT_TO_COLLAR(BIST_TESTDATA_SELECT_TO_COLLAR_ts1), 
      .MEM_BYPASS_EN(memory_bypass_to_en), .SCAN_SHIFT_EN(scan_to_en), .MCP_BOUNDING_EN(mcp_bounding_to_en), 
      .BIST_ON(BIST_ON_TO_COLLAR_ts1), .BIST_RUN(BIST_RUN_TO_COLLAR20_ts1), .BIST_ASYNC_RESETN(BIST_ASYNC_RESET), 
      .BIST_CLK(clk_a), .BIST_SHIFT_COLLAR(BIST_SHIFT_COLLAR_ts1), .BIST_EXPECT_DATA({
      BIST_EXPECT_DATA_ts15, BIST_EXPECT_DATA_ts14, BIST_EXPECT_DATA_ts13, 
      BIST_EXPECT_DATA_ts12, BIST_EXPECT_DATA_ts11, BIST_EXPECT_DATA_ts10, 
      BIST_EXPECT_DATA_ts9, BIST_EXPECT_DATA_ts8}), .BIST_SI(MEM20_BIST_COLLAR_SI_ts1), 
      .BIST_COLLAR_SETUP(BIST_COLLAR_SETUP_ts1), .BIST_COLLAR_OPSET_SELECT(BIST_COLLAR_OPSET_SELECT_ts1), 
      .BIST_COLLAR_HOLD(BIST_COLLAR_HOLD_ts1), .BIST_BIRA_EN(BIST_COLLAR_BIRA_EN_ts1), 
      .CHECK_REPAIR_NEEDED(CHECK_REPAIR_NEEDED), .BIST_DIAG_EN(BIST_COLLAR_DIAG_EN_ts1), 
      .BIST_CLEAR_DEFAULT(BIST_CLEAR_DEFAULT_ts1), .BIST_CLEAR(BIST_CLEAR_ts1), 
      .BIST_SETUP2(BIST_SETUP_ts2), .BIST_SETUP1(BIST_SETUP_ts1), .BIST_SETUP0(BIST_SETUP), 
      .LV_TM(ltest_to_en), .FREEZE_STOP_ERROR(FREEZE_STOP_ERROR_ts1), .GO_ID_REG_SEL(GO_ID_REG_SEL_ts1), 
      .BIST_COLLAR_EN(BIST_COLLAR_EN20_ts1), .FROM_BISR_All_SCOL0_FUSE_REG(ram_row_57_col_0_bisr_inst_Q[6:1]), 
      .FROM_BISR_All_SCOL0_ALLOC_REG(ram_row_57_col_0_bisr_inst_Q[0]), .BIST_SHIFT_BIRA_COLLAR(BIST_SHIFT_BIRA_COLLAR_ts1), 
      .RESET_REG_SETUP2(MBISTPG_RESET_REG_SETUP2_ts1), .ERROR_CNT_ZERO(ERROR_CNT_ZERO_ts1), 
      .WREN_P0(WREN_P0_ts52), .WREN_P1(WREN_P1_ts52), .RDEN_P0(RDEN_P0_ts52), .RDEN_P1(RDEN_P1_ts52), 
      .ADRRD_P0(ADRRD_P0_ts52), .ADRRD_P1(ADRRD_P1_ts52), .ADRWR_P0(ADRWR_P0_ts52), 
      .ADRWR_P1(ADRWR_P1_ts52), .DIN_P0(DIN_P0_ts52), .DIN_P1(DIN_P1_ts52), .BIST_SO(BIST_SO_ts52), 
      .BIST_GO(BIST_GO_ts52), .All_SCOL0_FUSE_REG(All_SCOL0_FUSE_REG_ts52[5:0]), 
      .All_SCOL0_ALLOC_REG(All_SCOL0_ALLOC_REG_ts52), .REPAIR_STATUS(), .fscan_clkungate(fscan_clkungate)
  );

  hlp_sched_apr_rtl_tessent_mbist_RF_c4_interface_MEM22 ram_row_58_col_0_interface_inst(
      .BIST_SHADOW_READENABLE(BIST_SHADOW_READENABLE_ts1), .BIST_SHADOW_READADDRESS(BIST_SHADOW_READADDRESS_ts1), 
      .BIST_CONREAD_ROWADDRESS(BIST_CONREAD_ROWADDRESS_ts1), .BIST_CONREAD_ENABLE(BIST_CONREAD_ENABLE_ts1), 
      .BIST_CONWRITE_ROWADDRESS(BIST_CONWRITE_ROWADDRESS_ts1), .BIST_CONWRITE_ENABLE(BIST_CONWRITE_ENABLE_ts1), 
      .BIST_CLEAR_BIRA(BIST_CLEAR_BIRA_ts1), .WREN_P0_IN(ram_row_58_col_0_wr_en_a), 
      .WREN_P1_IN(ram_row_58_col_0_wr_en_b), .RDEN_P0_IN(ram_row_58_col_0_rd_en_a), 
      .RDEN_P1_IN(ram_row_58_col_0_rd_en_b), .ADRRD_P0_IN(ram_row_58_col_0_rd_adr_a[7:0]), 
      .ADRRD_P1_IN(ram_row_58_col_0_rd_adr_b[7:0]), .ADRWR_P0_IN(ram_row_58_col_0_wr_adr_a[7:0]), 
      .ADRWR_P1_IN(ram_row_58_col_0_wr_adr_b[7:0]), .QOUT_P0(ram_row_58_col_0_data_out_a), 
      .QOUT_P1(ram_row_58_col_0_data_out_b), .DIN_P0_IN(ram_row_58_col_0_data_in_a[33:0]), 
      .DIN_P1_IN(ram_row_58_col_0_data_in_b[33:0]), .TCK(to_interfaces_tck), .BIST_CMP(BIST_CMP_ts1), 
      .INCLUDE_MEM_RESULTS_REG(INCLUDE_MEM_RESULTS_REG), .BIST_READENABLE(BIST_READENABLE_ts1), 
      .BIST_WRITEENABLE(BIST_WRITEENABLE_ts1), .BIST_ROW_ADD({
      BIST_ROW_ADD_ts7, BIST_ROW_ADD_ts6, BIST_ROW_ADD_ts5, BIST_ROW_ADD_ts4}), .BIST_BANK_ADD({
      BIST_BANK_ADD_ts7, BIST_BANK_ADD_ts6, BIST_BANK_ADD_ts5, 
      BIST_BANK_ADD_ts4}), .BIST_TEST_PORT(BIST_TEST_PORT_ts1), .BIST_WRITE_DATA({
      BIST_WRITE_DATA_ts15, BIST_WRITE_DATA_ts14, BIST_WRITE_DATA_ts13, 
      BIST_WRITE_DATA_ts12, BIST_WRITE_DATA_ts11, BIST_WRITE_DATA_ts10, 
      BIST_WRITE_DATA_ts9, BIST_WRITE_DATA_ts8}), .BIST_TESTDATA_SELECT_TO_COLLAR(BIST_TESTDATA_SELECT_TO_COLLAR_ts1), 
      .MEM_BYPASS_EN(memory_bypass_to_en), .SCAN_SHIFT_EN(scan_to_en), .MCP_BOUNDING_EN(mcp_bounding_to_en), 
      .BIST_ON(BIST_ON_TO_COLLAR_ts1), .BIST_RUN(BIST_RUN_TO_COLLAR21_ts1), .BIST_ASYNC_RESETN(BIST_ASYNC_RESET), 
      .BIST_CLK(clk_a), .BIST_SHIFT_COLLAR(BIST_SHIFT_COLLAR_ts1), .BIST_EXPECT_DATA({
      BIST_EXPECT_DATA_ts15, BIST_EXPECT_DATA_ts14, BIST_EXPECT_DATA_ts13, 
      BIST_EXPECT_DATA_ts12, BIST_EXPECT_DATA_ts11, BIST_EXPECT_DATA_ts10, 
      BIST_EXPECT_DATA_ts9, BIST_EXPECT_DATA_ts8}), .BIST_SI(MEM21_BIST_COLLAR_SI_ts1), 
      .BIST_COLLAR_SETUP(BIST_COLLAR_SETUP_ts1), .BIST_COLLAR_OPSET_SELECT(BIST_COLLAR_OPSET_SELECT_ts1), 
      .BIST_COLLAR_HOLD(BIST_COLLAR_HOLD_ts1), .BIST_BIRA_EN(BIST_COLLAR_BIRA_EN_ts1), 
      .CHECK_REPAIR_NEEDED(CHECK_REPAIR_NEEDED), .BIST_DIAG_EN(BIST_COLLAR_DIAG_EN_ts1), 
      .BIST_CLEAR_DEFAULT(BIST_CLEAR_DEFAULT_ts1), .BIST_CLEAR(BIST_CLEAR_ts1), 
      .BIST_SETUP2(BIST_SETUP_ts2), .BIST_SETUP1(BIST_SETUP_ts1), .BIST_SETUP0(BIST_SETUP), 
      .LV_TM(ltest_to_en), .FREEZE_STOP_ERROR(FREEZE_STOP_ERROR_ts1), .GO_ID_REG_SEL(GO_ID_REG_SEL_ts1), 
      .BIST_COLLAR_EN(BIST_COLLAR_EN21_ts1), .FROM_BISR_All_SCOL0_FUSE_REG(ram_row_58_col_0_bisr_inst_Q[6:1]), 
      .FROM_BISR_All_SCOL0_ALLOC_REG(ram_row_58_col_0_bisr_inst_Q[0]), .BIST_SHIFT_BIRA_COLLAR(BIST_SHIFT_BIRA_COLLAR_ts1), 
      .RESET_REG_SETUP2(MBISTPG_RESET_REG_SETUP2_ts1), .ERROR_CNT_ZERO(ERROR_CNT_ZERO_ts1), 
      .WREN_P0(WREN_P0_ts53), .WREN_P1(WREN_P1_ts53), .RDEN_P0(RDEN_P0_ts53), .RDEN_P1(RDEN_P1_ts53), 
      .ADRRD_P0(ADRRD_P0_ts53), .ADRRD_P1(ADRRD_P1_ts53), .ADRWR_P0(ADRWR_P0_ts53), 
      .ADRWR_P1(ADRWR_P1_ts53), .DIN_P0(DIN_P0_ts53), .DIN_P1(DIN_P1_ts53), .BIST_SO(BIST_SO_ts53), 
      .BIST_GO(BIST_GO_ts53), .All_SCOL0_FUSE_REG(All_SCOL0_FUSE_REG_ts53[5:0]), 
      .All_SCOL0_ALLOC_REG(All_SCOL0_ALLOC_REG_ts53), .REPAIR_STATUS(), .fscan_clkungate(fscan_clkungate)
  );

  hlp_sched_apr_rtl_tessent_mbist_RF_c4_interface_MEM23 ram_row_59_col_0_interface_inst(
      .BIST_SHADOW_READENABLE(BIST_SHADOW_READENABLE_ts1), .BIST_SHADOW_READADDRESS(BIST_SHADOW_READADDRESS_ts1), 
      .BIST_CONREAD_ROWADDRESS(BIST_CONREAD_ROWADDRESS_ts1), .BIST_CONREAD_ENABLE(BIST_CONREAD_ENABLE_ts1), 
      .BIST_CONWRITE_ROWADDRESS(BIST_CONWRITE_ROWADDRESS_ts1), .BIST_CONWRITE_ENABLE(BIST_CONWRITE_ENABLE_ts1), 
      .BIST_CLEAR_BIRA(BIST_CLEAR_BIRA_ts1), .WREN_P0_IN(ram_row_59_col_0_wr_en_a), 
      .WREN_P1_IN(ram_row_59_col_0_wr_en_b), .RDEN_P0_IN(ram_row_59_col_0_rd_en_a), 
      .RDEN_P1_IN(ram_row_59_col_0_rd_en_b), .ADRRD_P0_IN(ram_row_59_col_0_rd_adr_a[7:0]), 
      .ADRRD_P1_IN(ram_row_59_col_0_rd_adr_b[7:0]), .ADRWR_P0_IN(ram_row_59_col_0_wr_adr_a[7:0]), 
      .ADRWR_P1_IN(ram_row_59_col_0_wr_adr_b[7:0]), .QOUT_P0(ram_row_59_col_0_data_out_a), 
      .QOUT_P1(ram_row_59_col_0_data_out_b), .DIN_P0_IN(ram_row_59_col_0_data_in_a[33:0]), 
      .DIN_P1_IN(ram_row_59_col_0_data_in_b[33:0]), .TCK(to_interfaces_tck), .BIST_CMP(BIST_CMP_ts1), 
      .INCLUDE_MEM_RESULTS_REG(INCLUDE_MEM_RESULTS_REG), .BIST_READENABLE(BIST_READENABLE_ts1), 
      .BIST_WRITEENABLE(BIST_WRITEENABLE_ts1), .BIST_ROW_ADD({
      BIST_ROW_ADD_ts7, BIST_ROW_ADD_ts6, BIST_ROW_ADD_ts5, BIST_ROW_ADD_ts4}), .BIST_BANK_ADD({
      BIST_BANK_ADD_ts7, BIST_BANK_ADD_ts6, BIST_BANK_ADD_ts5, 
      BIST_BANK_ADD_ts4}), .BIST_TEST_PORT(BIST_TEST_PORT_ts1), .BIST_WRITE_DATA({
      BIST_WRITE_DATA_ts15, BIST_WRITE_DATA_ts14, BIST_WRITE_DATA_ts13, 
      BIST_WRITE_DATA_ts12, BIST_WRITE_DATA_ts11, BIST_WRITE_DATA_ts10, 
      BIST_WRITE_DATA_ts9, BIST_WRITE_DATA_ts8}), .BIST_TESTDATA_SELECT_TO_COLLAR(BIST_TESTDATA_SELECT_TO_COLLAR_ts1), 
      .MEM_BYPASS_EN(memory_bypass_to_en), .SCAN_SHIFT_EN(scan_to_en), .MCP_BOUNDING_EN(mcp_bounding_to_en), 
      .BIST_ON(BIST_ON_TO_COLLAR_ts1), .BIST_RUN(BIST_RUN_TO_COLLAR22_ts1), .BIST_ASYNC_RESETN(BIST_ASYNC_RESET), 
      .BIST_CLK(clk_a), .BIST_SHIFT_COLLAR(BIST_SHIFT_COLLAR_ts1), .BIST_EXPECT_DATA({
      BIST_EXPECT_DATA_ts15, BIST_EXPECT_DATA_ts14, BIST_EXPECT_DATA_ts13, 
      BIST_EXPECT_DATA_ts12, BIST_EXPECT_DATA_ts11, BIST_EXPECT_DATA_ts10, 
      BIST_EXPECT_DATA_ts9, BIST_EXPECT_DATA_ts8}), .BIST_SI(MEM22_BIST_COLLAR_SI_ts1), 
      .BIST_COLLAR_SETUP(BIST_COLLAR_SETUP_ts1), .BIST_COLLAR_OPSET_SELECT(BIST_COLLAR_OPSET_SELECT_ts1), 
      .BIST_COLLAR_HOLD(BIST_COLLAR_HOLD_ts1), .BIST_BIRA_EN(BIST_COLLAR_BIRA_EN_ts1), 
      .CHECK_REPAIR_NEEDED(CHECK_REPAIR_NEEDED), .BIST_DIAG_EN(BIST_COLLAR_DIAG_EN_ts1), 
      .BIST_CLEAR_DEFAULT(BIST_CLEAR_DEFAULT_ts1), .BIST_CLEAR(BIST_CLEAR_ts1), 
      .BIST_SETUP2(BIST_SETUP_ts2), .BIST_SETUP1(BIST_SETUP_ts1), .BIST_SETUP0(BIST_SETUP), 
      .LV_TM(ltest_to_en), .FREEZE_STOP_ERROR(FREEZE_STOP_ERROR_ts1), .GO_ID_REG_SEL(GO_ID_REG_SEL_ts1), 
      .BIST_COLLAR_EN(BIST_COLLAR_EN22_ts1), .FROM_BISR_All_SCOL0_FUSE_REG(ram_row_59_col_0_bisr_inst_Q[6:1]), 
      .FROM_BISR_All_SCOL0_ALLOC_REG(ram_row_59_col_0_bisr_inst_Q[0]), .BIST_SHIFT_BIRA_COLLAR(BIST_SHIFT_BIRA_COLLAR_ts1), 
      .RESET_REG_SETUP2(MBISTPG_RESET_REG_SETUP2_ts1), .ERROR_CNT_ZERO(ERROR_CNT_ZERO_ts1), 
      .WREN_P0(WREN_P0_ts54), .WREN_P1(WREN_P1_ts54), .RDEN_P0(RDEN_P0_ts54), .RDEN_P1(RDEN_P1_ts54), 
      .ADRRD_P0(ADRRD_P0_ts54), .ADRRD_P1(ADRRD_P1_ts54), .ADRWR_P0(ADRWR_P0_ts54), 
      .ADRWR_P1(ADRWR_P1_ts54), .DIN_P0(DIN_P0_ts54), .DIN_P1(DIN_P1_ts54), .BIST_SO(BIST_SO_ts54), 
      .BIST_GO(BIST_GO_ts54), .All_SCOL0_FUSE_REG(All_SCOL0_FUSE_REG_ts54[5:0]), 
      .All_SCOL0_ALLOC_REG(All_SCOL0_ALLOC_REG_ts54), .REPAIR_STATUS(), .fscan_clkungate(fscan_clkungate)
  );

  hlp_sched_apr_rtl_tessent_mbist_RF_c4_interface_MEM24 ram_row_5_col_0_interface_inst(
      .BIST_SHADOW_READENABLE(BIST_SHADOW_READENABLE_ts1), .BIST_SHADOW_READADDRESS(BIST_SHADOW_READADDRESS_ts1), 
      .BIST_CONREAD_ROWADDRESS(BIST_CONREAD_ROWADDRESS_ts1), .BIST_CONREAD_ENABLE(BIST_CONREAD_ENABLE_ts1), 
      .BIST_CONWRITE_ROWADDRESS(BIST_CONWRITE_ROWADDRESS_ts1), .BIST_CONWRITE_ENABLE(BIST_CONWRITE_ENABLE_ts1), 
      .BIST_CLEAR_BIRA(BIST_CLEAR_BIRA_ts1), .WREN_P0_IN(ram_row_5_col_0_wr_en_a), 
      .WREN_P1_IN(ram_row_5_col_0_wr_en_b), .RDEN_P0_IN(ram_row_5_col_0_rd_en_a), 
      .RDEN_P1_IN(ram_row_5_col_0_rd_en_b), .ADRRD_P0_IN(ram_row_5_col_0_rd_adr_a[7:0]), 
      .ADRRD_P1_IN(ram_row_5_col_0_rd_adr_b[7:0]), .ADRWR_P0_IN(ram_row_5_col_0_wr_adr_a[7:0]), 
      .ADRWR_P1_IN(ram_row_5_col_0_wr_adr_b[7:0]), .QOUT_P0(ram_row_5_col_0_data_out_a), 
      .QOUT_P1(ram_row_5_col_0_data_out_b), .DIN_P0_IN(ram_row_5_col_0_data_in_a[33:0]), 
      .DIN_P1_IN(ram_row_5_col_0_data_in_b[33:0]), .TCK(to_interfaces_tck), .BIST_CMP(BIST_CMP_ts1), 
      .INCLUDE_MEM_RESULTS_REG(INCLUDE_MEM_RESULTS_REG), .BIST_READENABLE(BIST_READENABLE_ts1), 
      .BIST_WRITEENABLE(BIST_WRITEENABLE_ts1), .BIST_ROW_ADD({
      BIST_ROW_ADD_ts7, BIST_ROW_ADD_ts6, BIST_ROW_ADD_ts5, BIST_ROW_ADD_ts4}), .BIST_BANK_ADD({
      BIST_BANK_ADD_ts7, BIST_BANK_ADD_ts6, BIST_BANK_ADD_ts5, 
      BIST_BANK_ADD_ts4}), .BIST_TEST_PORT(BIST_TEST_PORT_ts1), .BIST_WRITE_DATA({
      BIST_WRITE_DATA_ts15, BIST_WRITE_DATA_ts14, BIST_WRITE_DATA_ts13, 
      BIST_WRITE_DATA_ts12, BIST_WRITE_DATA_ts11, BIST_WRITE_DATA_ts10, 
      BIST_WRITE_DATA_ts9, BIST_WRITE_DATA_ts8}), .BIST_TESTDATA_SELECT_TO_COLLAR(BIST_TESTDATA_SELECT_TO_COLLAR_ts1), 
      .MEM_BYPASS_EN(memory_bypass_to_en), .SCAN_SHIFT_EN(scan_to_en), .MCP_BOUNDING_EN(mcp_bounding_to_en), 
      .BIST_ON(BIST_ON_TO_COLLAR_ts1), .BIST_RUN(BIST_RUN_TO_COLLAR23_ts1), .BIST_ASYNC_RESETN(BIST_ASYNC_RESET), 
      .BIST_CLK(clk_a), .BIST_SHIFT_COLLAR(BIST_SHIFT_COLLAR_ts1), .BIST_EXPECT_DATA({
      BIST_EXPECT_DATA_ts15, BIST_EXPECT_DATA_ts14, BIST_EXPECT_DATA_ts13, 
      BIST_EXPECT_DATA_ts12, BIST_EXPECT_DATA_ts11, BIST_EXPECT_DATA_ts10, 
      BIST_EXPECT_DATA_ts9, BIST_EXPECT_DATA_ts8}), .BIST_SI(MEM23_BIST_COLLAR_SI_ts1), 
      .BIST_COLLAR_SETUP(BIST_COLLAR_SETUP_ts1), .BIST_COLLAR_OPSET_SELECT(BIST_COLLAR_OPSET_SELECT_ts1), 
      .BIST_COLLAR_HOLD(BIST_COLLAR_HOLD_ts1), .BIST_BIRA_EN(BIST_COLLAR_BIRA_EN_ts1), 
      .CHECK_REPAIR_NEEDED(CHECK_REPAIR_NEEDED), .BIST_DIAG_EN(BIST_COLLAR_DIAG_EN_ts1), 
      .BIST_CLEAR_DEFAULT(BIST_CLEAR_DEFAULT_ts1), .BIST_CLEAR(BIST_CLEAR_ts1), 
      .BIST_SETUP2(BIST_SETUP_ts2), .BIST_SETUP1(BIST_SETUP_ts1), .BIST_SETUP0(BIST_SETUP), 
      .LV_TM(ltest_to_en), .FREEZE_STOP_ERROR(FREEZE_STOP_ERROR_ts1), .GO_ID_REG_SEL(GO_ID_REG_SEL_ts1), 
      .BIST_COLLAR_EN(BIST_COLLAR_EN23_ts1), .FROM_BISR_All_SCOL0_FUSE_REG(ram_row_5_col_0_bisr_inst_Q[6:1]), 
      .FROM_BISR_All_SCOL0_ALLOC_REG(ram_row_5_col_0_bisr_inst_Q[0]), .BIST_SHIFT_BIRA_COLLAR(BIST_SHIFT_BIRA_COLLAR_ts1), 
      .RESET_REG_SETUP2(MBISTPG_RESET_REG_SETUP2_ts1), .ERROR_CNT_ZERO(ERROR_CNT_ZERO_ts1), 
      .WREN_P0(WREN_P0_ts55), .WREN_P1(WREN_P1_ts55), .RDEN_P0(RDEN_P0_ts55), .RDEN_P1(RDEN_P1_ts55), 
      .ADRRD_P0(ADRRD_P0_ts55), .ADRRD_P1(ADRRD_P1_ts55), .ADRWR_P0(ADRWR_P0_ts55), 
      .ADRWR_P1(ADRWR_P1_ts55), .DIN_P0(DIN_P0_ts55), .DIN_P1(DIN_P1_ts55), .BIST_SO(BIST_SO_ts55), 
      .BIST_GO(BIST_GO_ts55), .All_SCOL0_FUSE_REG(All_SCOL0_FUSE_REG_ts55[5:0]), 
      .All_SCOL0_ALLOC_REG(All_SCOL0_ALLOC_REG_ts55), .REPAIR_STATUS(), .fscan_clkungate(fscan_clkungate)
  );

  hlp_sched_apr_rtl_tessent_mbist_RF_c4_interface_MEM25 ram_row_60_col_0_interface_inst(
      .BIST_SHADOW_READENABLE(BIST_SHADOW_READENABLE_ts1), .BIST_SHADOW_READADDRESS(BIST_SHADOW_READADDRESS_ts1), 
      .BIST_CONREAD_ROWADDRESS(BIST_CONREAD_ROWADDRESS_ts1), .BIST_CONREAD_ENABLE(BIST_CONREAD_ENABLE_ts1), 
      .BIST_CONWRITE_ROWADDRESS(BIST_CONWRITE_ROWADDRESS_ts1), .BIST_CONWRITE_ENABLE(BIST_CONWRITE_ENABLE_ts1), 
      .BIST_CLEAR_BIRA(BIST_CLEAR_BIRA_ts1), .WREN_P0_IN(ram_row_60_col_0_wr_en_a), 
      .WREN_P1_IN(ram_row_60_col_0_wr_en_b), .RDEN_P0_IN(ram_row_60_col_0_rd_en_a), 
      .RDEN_P1_IN(ram_row_60_col_0_rd_en_b), .ADRRD_P0_IN(ram_row_60_col_0_rd_adr_a[7:0]), 
      .ADRRD_P1_IN(ram_row_60_col_0_rd_adr_b[7:0]), .ADRWR_P0_IN(ram_row_60_col_0_wr_adr_a[7:0]), 
      .ADRWR_P1_IN(ram_row_60_col_0_wr_adr_b[7:0]), .QOUT_P0(ram_row_60_col_0_data_out_a), 
      .QOUT_P1(ram_row_60_col_0_data_out_b), .DIN_P0_IN(ram_row_60_col_0_data_in_a[33:0]), 
      .DIN_P1_IN(ram_row_60_col_0_data_in_b[33:0]), .TCK(to_interfaces_tck), .BIST_CMP(BIST_CMP_ts1), 
      .INCLUDE_MEM_RESULTS_REG(INCLUDE_MEM_RESULTS_REG), .BIST_READENABLE(BIST_READENABLE_ts1), 
      .BIST_WRITEENABLE(BIST_WRITEENABLE_ts1), .BIST_ROW_ADD({
      BIST_ROW_ADD_ts7, BIST_ROW_ADD_ts6, BIST_ROW_ADD_ts5, BIST_ROW_ADD_ts4}), .BIST_BANK_ADD({
      BIST_BANK_ADD_ts7, BIST_BANK_ADD_ts6, BIST_BANK_ADD_ts5, 
      BIST_BANK_ADD_ts4}), .BIST_TEST_PORT(BIST_TEST_PORT_ts1), .BIST_WRITE_DATA({
      BIST_WRITE_DATA_ts15, BIST_WRITE_DATA_ts14, BIST_WRITE_DATA_ts13, 
      BIST_WRITE_DATA_ts12, BIST_WRITE_DATA_ts11, BIST_WRITE_DATA_ts10, 
      BIST_WRITE_DATA_ts9, BIST_WRITE_DATA_ts8}), .BIST_TESTDATA_SELECT_TO_COLLAR(BIST_TESTDATA_SELECT_TO_COLLAR_ts1), 
      .MEM_BYPASS_EN(memory_bypass_to_en), .SCAN_SHIFT_EN(scan_to_en), .MCP_BOUNDING_EN(mcp_bounding_to_en), 
      .BIST_ON(BIST_ON_TO_COLLAR_ts1), .BIST_RUN(BIST_RUN_TO_COLLAR24_ts1), .BIST_ASYNC_RESETN(BIST_ASYNC_RESET), 
      .BIST_CLK(clk_a), .BIST_SHIFT_COLLAR(BIST_SHIFT_COLLAR_ts1), .BIST_EXPECT_DATA({
      BIST_EXPECT_DATA_ts15, BIST_EXPECT_DATA_ts14, BIST_EXPECT_DATA_ts13, 
      BIST_EXPECT_DATA_ts12, BIST_EXPECT_DATA_ts11, BIST_EXPECT_DATA_ts10, 
      BIST_EXPECT_DATA_ts9, BIST_EXPECT_DATA_ts8}), .BIST_SI(MEM24_BIST_COLLAR_SI_ts1), 
      .BIST_COLLAR_SETUP(BIST_COLLAR_SETUP_ts1), .BIST_COLLAR_OPSET_SELECT(BIST_COLLAR_OPSET_SELECT_ts1), 
      .BIST_COLLAR_HOLD(BIST_COLLAR_HOLD_ts1), .BIST_BIRA_EN(BIST_COLLAR_BIRA_EN_ts1), 
      .CHECK_REPAIR_NEEDED(CHECK_REPAIR_NEEDED), .BIST_DIAG_EN(BIST_COLLAR_DIAG_EN_ts1), 
      .BIST_CLEAR_DEFAULT(BIST_CLEAR_DEFAULT_ts1), .BIST_CLEAR(BIST_CLEAR_ts1), 
      .BIST_SETUP2(BIST_SETUP_ts2), .BIST_SETUP1(BIST_SETUP_ts1), .BIST_SETUP0(BIST_SETUP), 
      .LV_TM(ltest_to_en), .FREEZE_STOP_ERROR(FREEZE_STOP_ERROR_ts1), .GO_ID_REG_SEL(GO_ID_REG_SEL_ts1), 
      .BIST_COLLAR_EN(BIST_COLLAR_EN24_ts1), .FROM_BISR_All_SCOL0_FUSE_REG(ram_row_60_col_0_bisr_inst_Q[6:1]), 
      .FROM_BISR_All_SCOL0_ALLOC_REG(ram_row_60_col_0_bisr_inst_Q[0]), .BIST_SHIFT_BIRA_COLLAR(BIST_SHIFT_BIRA_COLLAR_ts1), 
      .RESET_REG_SETUP2(MBISTPG_RESET_REG_SETUP2_ts1), .ERROR_CNT_ZERO(ERROR_CNT_ZERO_ts1), 
      .WREN_P0(WREN_P0_ts56), .WREN_P1(WREN_P1_ts56), .RDEN_P0(RDEN_P0_ts56), .RDEN_P1(RDEN_P1_ts56), 
      .ADRRD_P0(ADRRD_P0_ts56), .ADRRD_P1(ADRRD_P1_ts56), .ADRWR_P0(ADRWR_P0_ts56), 
      .ADRWR_P1(ADRWR_P1_ts56), .DIN_P0(DIN_P0_ts56), .DIN_P1(DIN_P1_ts56), .BIST_SO(BIST_SO_ts56), 
      .BIST_GO(BIST_GO_ts56), .All_SCOL0_FUSE_REG(All_SCOL0_FUSE_REG_ts56[5:0]), 
      .All_SCOL0_ALLOC_REG(All_SCOL0_ALLOC_REG_ts56), .REPAIR_STATUS(), .fscan_clkungate(fscan_clkungate)
  );

  hlp_sched_apr_rtl_tessent_mbist_RF_c4_interface_MEM26 ram_row_61_col_0_interface_inst(
      .BIST_SHADOW_READENABLE(BIST_SHADOW_READENABLE_ts1), .BIST_SHADOW_READADDRESS(BIST_SHADOW_READADDRESS_ts1), 
      .BIST_CONREAD_ROWADDRESS(BIST_CONREAD_ROWADDRESS_ts1), .BIST_CONREAD_ENABLE(BIST_CONREAD_ENABLE_ts1), 
      .BIST_CONWRITE_ROWADDRESS(BIST_CONWRITE_ROWADDRESS_ts1), .BIST_CONWRITE_ENABLE(BIST_CONWRITE_ENABLE_ts1), 
      .BIST_CLEAR_BIRA(BIST_CLEAR_BIRA_ts1), .WREN_P0_IN(ram_row_61_col_0_wr_en_a), 
      .WREN_P1_IN(ram_row_61_col_0_wr_en_b), .RDEN_P0_IN(ram_row_61_col_0_rd_en_a), 
      .RDEN_P1_IN(ram_row_61_col_0_rd_en_b), .ADRRD_P0_IN(ram_row_61_col_0_rd_adr_a[7:0]), 
      .ADRRD_P1_IN(ram_row_61_col_0_rd_adr_b[7:0]), .ADRWR_P0_IN(ram_row_61_col_0_wr_adr_a[7:0]), 
      .ADRWR_P1_IN(ram_row_61_col_0_wr_adr_b[7:0]), .QOUT_P0(ram_row_61_col_0_data_out_a), 
      .QOUT_P1(ram_row_61_col_0_data_out_b), .DIN_P0_IN(ram_row_61_col_0_data_in_a[33:0]), 
      .DIN_P1_IN(ram_row_61_col_0_data_in_b[33:0]), .TCK(to_interfaces_tck), .BIST_CMP(BIST_CMP_ts1), 
      .INCLUDE_MEM_RESULTS_REG(INCLUDE_MEM_RESULTS_REG), .BIST_READENABLE(BIST_READENABLE_ts1), 
      .BIST_WRITEENABLE(BIST_WRITEENABLE_ts1), .BIST_ROW_ADD({
      BIST_ROW_ADD_ts7, BIST_ROW_ADD_ts6, BIST_ROW_ADD_ts5, BIST_ROW_ADD_ts4}), .BIST_BANK_ADD({
      BIST_BANK_ADD_ts7, BIST_BANK_ADD_ts6, BIST_BANK_ADD_ts5, 
      BIST_BANK_ADD_ts4}), .BIST_TEST_PORT(BIST_TEST_PORT_ts1), .BIST_WRITE_DATA({
      BIST_WRITE_DATA_ts15, BIST_WRITE_DATA_ts14, BIST_WRITE_DATA_ts13, 
      BIST_WRITE_DATA_ts12, BIST_WRITE_DATA_ts11, BIST_WRITE_DATA_ts10, 
      BIST_WRITE_DATA_ts9, BIST_WRITE_DATA_ts8}), .BIST_TESTDATA_SELECT_TO_COLLAR(BIST_TESTDATA_SELECT_TO_COLLAR_ts1), 
      .MEM_BYPASS_EN(memory_bypass_to_en), .SCAN_SHIFT_EN(scan_to_en), .MCP_BOUNDING_EN(mcp_bounding_to_en), 
      .BIST_ON(BIST_ON_TO_COLLAR_ts1), .BIST_RUN(BIST_RUN_TO_COLLAR25_ts1), .BIST_ASYNC_RESETN(BIST_ASYNC_RESET), 
      .BIST_CLK(clk_a), .BIST_SHIFT_COLLAR(BIST_SHIFT_COLLAR_ts1), .BIST_EXPECT_DATA({
      BIST_EXPECT_DATA_ts15, BIST_EXPECT_DATA_ts14, BIST_EXPECT_DATA_ts13, 
      BIST_EXPECT_DATA_ts12, BIST_EXPECT_DATA_ts11, BIST_EXPECT_DATA_ts10, 
      BIST_EXPECT_DATA_ts9, BIST_EXPECT_DATA_ts8}), .BIST_SI(MEM25_BIST_COLLAR_SI_ts1), 
      .BIST_COLLAR_SETUP(BIST_COLLAR_SETUP_ts1), .BIST_COLLAR_OPSET_SELECT(BIST_COLLAR_OPSET_SELECT_ts1), 
      .BIST_COLLAR_HOLD(BIST_COLLAR_HOLD_ts1), .BIST_BIRA_EN(BIST_COLLAR_BIRA_EN_ts1), 
      .CHECK_REPAIR_NEEDED(CHECK_REPAIR_NEEDED), .BIST_DIAG_EN(BIST_COLLAR_DIAG_EN_ts1), 
      .BIST_CLEAR_DEFAULT(BIST_CLEAR_DEFAULT_ts1), .BIST_CLEAR(BIST_CLEAR_ts1), 
      .BIST_SETUP2(BIST_SETUP_ts2), .BIST_SETUP1(BIST_SETUP_ts1), .BIST_SETUP0(BIST_SETUP), 
      .LV_TM(ltest_to_en), .FREEZE_STOP_ERROR(FREEZE_STOP_ERROR_ts1), .GO_ID_REG_SEL(GO_ID_REG_SEL_ts1), 
      .BIST_COLLAR_EN(BIST_COLLAR_EN25_ts1), .FROM_BISR_All_SCOL0_FUSE_REG(ram_row_61_col_0_bisr_inst_Q[6:1]), 
      .FROM_BISR_All_SCOL0_ALLOC_REG(ram_row_61_col_0_bisr_inst_Q[0]), .BIST_SHIFT_BIRA_COLLAR(BIST_SHIFT_BIRA_COLLAR_ts1), 
      .RESET_REG_SETUP2(MBISTPG_RESET_REG_SETUP2_ts1), .ERROR_CNT_ZERO(ERROR_CNT_ZERO_ts1), 
      .WREN_P0(WREN_P0_ts57), .WREN_P1(WREN_P1_ts57), .RDEN_P0(RDEN_P0_ts57), .RDEN_P1(RDEN_P1_ts57), 
      .ADRRD_P0(ADRRD_P0_ts57), .ADRRD_P1(ADRRD_P1_ts57), .ADRWR_P0(ADRWR_P0_ts57), 
      .ADRWR_P1(ADRWR_P1_ts57), .DIN_P0(DIN_P0_ts57), .DIN_P1(DIN_P1_ts57), .BIST_SO(BIST_SO_ts57), 
      .BIST_GO(BIST_GO_ts57), .All_SCOL0_FUSE_REG(All_SCOL0_FUSE_REG_ts57[5:0]), 
      .All_SCOL0_ALLOC_REG(All_SCOL0_ALLOC_REG_ts57), .REPAIR_STATUS(), .fscan_clkungate(fscan_clkungate)
  );

  hlp_sched_apr_rtl_tessent_mbist_RF_c4_interface_MEM27 ram_row_62_col_0_interface_inst(
      .BIST_SHADOW_READENABLE(BIST_SHADOW_READENABLE_ts1), .BIST_SHADOW_READADDRESS(BIST_SHADOW_READADDRESS_ts1), 
      .BIST_CONREAD_ROWADDRESS(BIST_CONREAD_ROWADDRESS_ts1), .BIST_CONREAD_ENABLE(BIST_CONREAD_ENABLE_ts1), 
      .BIST_CONWRITE_ROWADDRESS(BIST_CONWRITE_ROWADDRESS_ts1), .BIST_CONWRITE_ENABLE(BIST_CONWRITE_ENABLE_ts1), 
      .BIST_CLEAR_BIRA(BIST_CLEAR_BIRA_ts1), .WREN_P0_IN(ram_row_62_col_0_wr_en_a), 
      .WREN_P1_IN(ram_row_62_col_0_wr_en_b), .RDEN_P0_IN(ram_row_62_col_0_rd_en_a), 
      .RDEN_P1_IN(ram_row_62_col_0_rd_en_b), .ADRRD_P0_IN(ram_row_62_col_0_rd_adr_a[7:0]), 
      .ADRRD_P1_IN(ram_row_62_col_0_rd_adr_b[7:0]), .ADRWR_P0_IN(ram_row_62_col_0_wr_adr_a[7:0]), 
      .ADRWR_P1_IN(ram_row_62_col_0_wr_adr_b[7:0]), .QOUT_P0(ram_row_62_col_0_data_out_a), 
      .QOUT_P1(ram_row_62_col_0_data_out_b), .DIN_P0_IN(ram_row_62_col_0_data_in_a[33:0]), 
      .DIN_P1_IN(ram_row_62_col_0_data_in_b[33:0]), .TCK(to_interfaces_tck), .BIST_CMP(BIST_CMP_ts1), 
      .INCLUDE_MEM_RESULTS_REG(INCLUDE_MEM_RESULTS_REG), .BIST_READENABLE(BIST_READENABLE_ts1), 
      .BIST_WRITEENABLE(BIST_WRITEENABLE_ts1), .BIST_ROW_ADD({
      BIST_ROW_ADD_ts7, BIST_ROW_ADD_ts6, BIST_ROW_ADD_ts5, BIST_ROW_ADD_ts4}), .BIST_BANK_ADD({
      BIST_BANK_ADD_ts7, BIST_BANK_ADD_ts6, BIST_BANK_ADD_ts5, 
      BIST_BANK_ADD_ts4}), .BIST_TEST_PORT(BIST_TEST_PORT_ts1), .BIST_WRITE_DATA({
      BIST_WRITE_DATA_ts15, BIST_WRITE_DATA_ts14, BIST_WRITE_DATA_ts13, 
      BIST_WRITE_DATA_ts12, BIST_WRITE_DATA_ts11, BIST_WRITE_DATA_ts10, 
      BIST_WRITE_DATA_ts9, BIST_WRITE_DATA_ts8}), .BIST_TESTDATA_SELECT_TO_COLLAR(BIST_TESTDATA_SELECT_TO_COLLAR_ts1), 
      .MEM_BYPASS_EN(memory_bypass_to_en), .SCAN_SHIFT_EN(scan_to_en), .MCP_BOUNDING_EN(mcp_bounding_to_en), 
      .BIST_ON(BIST_ON_TO_COLLAR_ts1), .BIST_RUN(BIST_RUN_TO_COLLAR26_ts1), .BIST_ASYNC_RESETN(BIST_ASYNC_RESET), 
      .BIST_CLK(clk_a), .BIST_SHIFT_COLLAR(BIST_SHIFT_COLLAR_ts1), .BIST_EXPECT_DATA({
      BIST_EXPECT_DATA_ts15, BIST_EXPECT_DATA_ts14, BIST_EXPECT_DATA_ts13, 
      BIST_EXPECT_DATA_ts12, BIST_EXPECT_DATA_ts11, BIST_EXPECT_DATA_ts10, 
      BIST_EXPECT_DATA_ts9, BIST_EXPECT_DATA_ts8}), .BIST_SI(MEM26_BIST_COLLAR_SI_ts1), 
      .BIST_COLLAR_SETUP(BIST_COLLAR_SETUP_ts1), .BIST_COLLAR_OPSET_SELECT(BIST_COLLAR_OPSET_SELECT_ts1), 
      .BIST_COLLAR_HOLD(BIST_COLLAR_HOLD_ts1), .BIST_BIRA_EN(BIST_COLLAR_BIRA_EN_ts1), 
      .CHECK_REPAIR_NEEDED(CHECK_REPAIR_NEEDED), .BIST_DIAG_EN(BIST_COLLAR_DIAG_EN_ts1), 
      .BIST_CLEAR_DEFAULT(BIST_CLEAR_DEFAULT_ts1), .BIST_CLEAR(BIST_CLEAR_ts1), 
      .BIST_SETUP2(BIST_SETUP_ts2), .BIST_SETUP1(BIST_SETUP_ts1), .BIST_SETUP0(BIST_SETUP), 
      .LV_TM(ltest_to_en), .FREEZE_STOP_ERROR(FREEZE_STOP_ERROR_ts1), .GO_ID_REG_SEL(GO_ID_REG_SEL_ts1), 
      .BIST_COLLAR_EN(BIST_COLLAR_EN26_ts1), .FROM_BISR_All_SCOL0_FUSE_REG(ram_row_62_col_0_bisr_inst_Q[6:1]), 
      .FROM_BISR_All_SCOL0_ALLOC_REG(ram_row_62_col_0_bisr_inst_Q[0]), .BIST_SHIFT_BIRA_COLLAR(BIST_SHIFT_BIRA_COLLAR_ts1), 
      .RESET_REG_SETUP2(MBISTPG_RESET_REG_SETUP2_ts1), .ERROR_CNT_ZERO(ERROR_CNT_ZERO_ts1), 
      .WREN_P0(WREN_P0_ts58), .WREN_P1(WREN_P1_ts58), .RDEN_P0(RDEN_P0_ts58), .RDEN_P1(RDEN_P1_ts58), 
      .ADRRD_P0(ADRRD_P0_ts58), .ADRRD_P1(ADRRD_P1_ts58), .ADRWR_P0(ADRWR_P0_ts58), 
      .ADRWR_P1(ADRWR_P1_ts58), .DIN_P0(DIN_P0_ts58), .DIN_P1(DIN_P1_ts58), .BIST_SO(BIST_SO_ts58), 
      .BIST_GO(BIST_GO_ts58), .All_SCOL0_FUSE_REG(All_SCOL0_FUSE_REG_ts58[5:0]), 
      .All_SCOL0_ALLOC_REG(All_SCOL0_ALLOC_REG_ts58), .REPAIR_STATUS(), .fscan_clkungate(fscan_clkungate)
  );

  hlp_sched_apr_rtl_tessent_mbist_RF_c4_interface_MEM28 ram_row_63_col_0_interface_inst(
      .BIST_SHADOW_READENABLE(BIST_SHADOW_READENABLE_ts1), .BIST_SHADOW_READADDRESS(BIST_SHADOW_READADDRESS_ts1), 
      .BIST_CONREAD_ROWADDRESS(BIST_CONREAD_ROWADDRESS_ts1), .BIST_CONREAD_ENABLE(BIST_CONREAD_ENABLE_ts1), 
      .BIST_CONWRITE_ROWADDRESS(BIST_CONWRITE_ROWADDRESS_ts1), .BIST_CONWRITE_ENABLE(BIST_CONWRITE_ENABLE_ts1), 
      .BIST_CLEAR_BIRA(BIST_CLEAR_BIRA_ts1), .WREN_P0_IN(ram_row_63_col_0_wr_en_a), 
      .WREN_P1_IN(ram_row_63_col_0_wr_en_b), .RDEN_P0_IN(ram_row_63_col_0_rd_en_a), 
      .RDEN_P1_IN(ram_row_63_col_0_rd_en_b), .ADRRD_P0_IN(ram_row_63_col_0_rd_adr_a[7:0]), 
      .ADRRD_P1_IN(ram_row_63_col_0_rd_adr_b[7:0]), .ADRWR_P0_IN(ram_row_63_col_0_wr_adr_a[7:0]), 
      .ADRWR_P1_IN(ram_row_63_col_0_wr_adr_b[7:0]), .QOUT_P0(ram_row_63_col_0_data_out_a), 
      .QOUT_P1(ram_row_63_col_0_data_out_b), .DIN_P0_IN(ram_row_63_col_0_data_in_a[33:0]), 
      .DIN_P1_IN(ram_row_63_col_0_data_in_b[33:0]), .TCK(to_interfaces_tck), .BIST_CMP(BIST_CMP_ts1), 
      .INCLUDE_MEM_RESULTS_REG(INCLUDE_MEM_RESULTS_REG), .BIST_READENABLE(BIST_READENABLE_ts1), 
      .BIST_WRITEENABLE(BIST_WRITEENABLE_ts1), .BIST_ROW_ADD({
      BIST_ROW_ADD_ts7, BIST_ROW_ADD_ts6, BIST_ROW_ADD_ts5, BIST_ROW_ADD_ts4}), .BIST_BANK_ADD({
      BIST_BANK_ADD_ts7, BIST_BANK_ADD_ts6, BIST_BANK_ADD_ts5, 
      BIST_BANK_ADD_ts4}), .BIST_TEST_PORT(BIST_TEST_PORT_ts1), .BIST_WRITE_DATA({
      BIST_WRITE_DATA_ts15, BIST_WRITE_DATA_ts14, BIST_WRITE_DATA_ts13, 
      BIST_WRITE_DATA_ts12, BIST_WRITE_DATA_ts11, BIST_WRITE_DATA_ts10, 
      BIST_WRITE_DATA_ts9, BIST_WRITE_DATA_ts8}), .BIST_TESTDATA_SELECT_TO_COLLAR(BIST_TESTDATA_SELECT_TO_COLLAR_ts1), 
      .MEM_BYPASS_EN(memory_bypass_to_en), .SCAN_SHIFT_EN(scan_to_en), .MCP_BOUNDING_EN(mcp_bounding_to_en), 
      .BIST_ON(BIST_ON_TO_COLLAR_ts1), .BIST_RUN(BIST_RUN_TO_COLLAR27_ts1), .BIST_ASYNC_RESETN(BIST_ASYNC_RESET), 
      .BIST_CLK(clk_a), .BIST_SHIFT_COLLAR(BIST_SHIFT_COLLAR_ts1), .BIST_EXPECT_DATA({
      BIST_EXPECT_DATA_ts15, BIST_EXPECT_DATA_ts14, BIST_EXPECT_DATA_ts13, 
      BIST_EXPECT_DATA_ts12, BIST_EXPECT_DATA_ts11, BIST_EXPECT_DATA_ts10, 
      BIST_EXPECT_DATA_ts9, BIST_EXPECT_DATA_ts8}), .BIST_SI(MEM27_BIST_COLLAR_SI_ts1), 
      .BIST_COLLAR_SETUP(BIST_COLLAR_SETUP_ts1), .BIST_COLLAR_OPSET_SELECT(BIST_COLLAR_OPSET_SELECT_ts1), 
      .BIST_COLLAR_HOLD(BIST_COLLAR_HOLD_ts1), .BIST_BIRA_EN(BIST_COLLAR_BIRA_EN_ts1), 
      .CHECK_REPAIR_NEEDED(CHECK_REPAIR_NEEDED), .BIST_DIAG_EN(BIST_COLLAR_DIAG_EN_ts1), 
      .BIST_CLEAR_DEFAULT(BIST_CLEAR_DEFAULT_ts1), .BIST_CLEAR(BIST_CLEAR_ts1), 
      .BIST_SETUP2(BIST_SETUP_ts2), .BIST_SETUP1(BIST_SETUP_ts1), .BIST_SETUP0(BIST_SETUP), 
      .LV_TM(ltest_to_en), .FREEZE_STOP_ERROR(FREEZE_STOP_ERROR_ts1), .GO_ID_REG_SEL(GO_ID_REG_SEL_ts1), 
      .BIST_COLLAR_EN(BIST_COLLAR_EN27_ts1), .FROM_BISR_All_SCOL0_FUSE_REG(ram_row_63_col_0_bisr_inst_Q[6:1]), 
      .FROM_BISR_All_SCOL0_ALLOC_REG(ram_row_63_col_0_bisr_inst_Q[0]), .BIST_SHIFT_BIRA_COLLAR(BIST_SHIFT_BIRA_COLLAR_ts1), 
      .RESET_REG_SETUP2(MBISTPG_RESET_REG_SETUP2_ts1), .ERROR_CNT_ZERO(ERROR_CNT_ZERO_ts1), 
      .WREN_P0(WREN_P0_ts59), .WREN_P1(WREN_P1_ts59), .RDEN_P0(RDEN_P0_ts59), .RDEN_P1(RDEN_P1_ts59), 
      .ADRRD_P0(ADRRD_P0_ts59), .ADRRD_P1(ADRRD_P1_ts59), .ADRWR_P0(ADRWR_P0_ts59), 
      .ADRWR_P1(ADRWR_P1_ts59), .DIN_P0(DIN_P0_ts59), .DIN_P1(DIN_P1_ts59), .BIST_SO(BIST_SO_ts59), 
      .BIST_GO(BIST_GO_ts59), .All_SCOL0_FUSE_REG(All_SCOL0_FUSE_REG_ts59[5:0]), 
      .All_SCOL0_ALLOC_REG(All_SCOL0_ALLOC_REG_ts59), .REPAIR_STATUS(), .fscan_clkungate(fscan_clkungate)
  );

  hlp_sched_apr_rtl_tessent_mbist_RF_c4_interface_MEM29 ram_row_6_col_0_interface_inst(
      .BIST_SHADOW_READENABLE(BIST_SHADOW_READENABLE_ts1), .BIST_SHADOW_READADDRESS(BIST_SHADOW_READADDRESS_ts1), 
      .BIST_CONREAD_ROWADDRESS(BIST_CONREAD_ROWADDRESS_ts1), .BIST_CONREAD_ENABLE(BIST_CONREAD_ENABLE_ts1), 
      .BIST_CONWRITE_ROWADDRESS(BIST_CONWRITE_ROWADDRESS_ts1), .BIST_CONWRITE_ENABLE(BIST_CONWRITE_ENABLE_ts1), 
      .BIST_CLEAR_BIRA(BIST_CLEAR_BIRA_ts1), .WREN_P0_IN(ram_row_6_col_0_wr_en_a), 
      .WREN_P1_IN(ram_row_6_col_0_wr_en_b), .RDEN_P0_IN(ram_row_6_col_0_rd_en_a), 
      .RDEN_P1_IN(ram_row_6_col_0_rd_en_b), .ADRRD_P0_IN(ram_row_6_col_0_rd_adr_a[7:0]), 
      .ADRRD_P1_IN(ram_row_6_col_0_rd_adr_b[7:0]), .ADRWR_P0_IN(ram_row_6_col_0_wr_adr_a[7:0]), 
      .ADRWR_P1_IN(ram_row_6_col_0_wr_adr_b[7:0]), .QOUT_P0(ram_row_6_col_0_data_out_a), 
      .QOUT_P1(ram_row_6_col_0_data_out_b), .DIN_P0_IN(ram_row_6_col_0_data_in_a[33:0]), 
      .DIN_P1_IN(ram_row_6_col_0_data_in_b[33:0]), .TCK(to_interfaces_tck), .BIST_CMP(BIST_CMP_ts1), 
      .INCLUDE_MEM_RESULTS_REG(INCLUDE_MEM_RESULTS_REG), .BIST_READENABLE(BIST_READENABLE_ts1), 
      .BIST_WRITEENABLE(BIST_WRITEENABLE_ts1), .BIST_ROW_ADD({
      BIST_ROW_ADD_ts7, BIST_ROW_ADD_ts6, BIST_ROW_ADD_ts5, BIST_ROW_ADD_ts4}), .BIST_BANK_ADD({
      BIST_BANK_ADD_ts7, BIST_BANK_ADD_ts6, BIST_BANK_ADD_ts5, 
      BIST_BANK_ADD_ts4}), .BIST_TEST_PORT(BIST_TEST_PORT_ts1), .BIST_WRITE_DATA({
      BIST_WRITE_DATA_ts15, BIST_WRITE_DATA_ts14, BIST_WRITE_DATA_ts13, 
      BIST_WRITE_DATA_ts12, BIST_WRITE_DATA_ts11, BIST_WRITE_DATA_ts10, 
      BIST_WRITE_DATA_ts9, BIST_WRITE_DATA_ts8}), .BIST_TESTDATA_SELECT_TO_COLLAR(BIST_TESTDATA_SELECT_TO_COLLAR_ts1), 
      .MEM_BYPASS_EN(memory_bypass_to_en), .SCAN_SHIFT_EN(scan_to_en), .MCP_BOUNDING_EN(mcp_bounding_to_en), 
      .BIST_ON(BIST_ON_TO_COLLAR_ts1), .BIST_RUN(BIST_RUN_TO_COLLAR28_ts1), .BIST_ASYNC_RESETN(BIST_ASYNC_RESET), 
      .BIST_CLK(clk_a), .BIST_SHIFT_COLLAR(BIST_SHIFT_COLLAR_ts1), .BIST_EXPECT_DATA({
      BIST_EXPECT_DATA_ts15, BIST_EXPECT_DATA_ts14, BIST_EXPECT_DATA_ts13, 
      BIST_EXPECT_DATA_ts12, BIST_EXPECT_DATA_ts11, BIST_EXPECT_DATA_ts10, 
      BIST_EXPECT_DATA_ts9, BIST_EXPECT_DATA_ts8}), .BIST_SI(MEM28_BIST_COLLAR_SI_ts1), 
      .BIST_COLLAR_SETUP(BIST_COLLAR_SETUP_ts1), .BIST_COLLAR_OPSET_SELECT(BIST_COLLAR_OPSET_SELECT_ts1), 
      .BIST_COLLAR_HOLD(BIST_COLLAR_HOLD_ts1), .BIST_BIRA_EN(BIST_COLLAR_BIRA_EN_ts1), 
      .CHECK_REPAIR_NEEDED(CHECK_REPAIR_NEEDED), .BIST_DIAG_EN(BIST_COLLAR_DIAG_EN_ts1), 
      .BIST_CLEAR_DEFAULT(BIST_CLEAR_DEFAULT_ts1), .BIST_CLEAR(BIST_CLEAR_ts1), 
      .BIST_SETUP2(BIST_SETUP_ts2), .BIST_SETUP1(BIST_SETUP_ts1), .BIST_SETUP0(BIST_SETUP), 
      .LV_TM(ltest_to_en), .FREEZE_STOP_ERROR(FREEZE_STOP_ERROR_ts1), .GO_ID_REG_SEL(GO_ID_REG_SEL_ts1), 
      .BIST_COLLAR_EN(BIST_COLLAR_EN28_ts1), .FROM_BISR_All_SCOL0_FUSE_REG(ram_row_6_col_0_bisr_inst_Q[6:1]), 
      .FROM_BISR_All_SCOL0_ALLOC_REG(ram_row_6_col_0_bisr_inst_Q[0]), .BIST_SHIFT_BIRA_COLLAR(BIST_SHIFT_BIRA_COLLAR_ts1), 
      .RESET_REG_SETUP2(MBISTPG_RESET_REG_SETUP2_ts1), .ERROR_CNT_ZERO(ERROR_CNT_ZERO_ts1), 
      .WREN_P0(WREN_P0_ts60), .WREN_P1(WREN_P1_ts60), .RDEN_P0(RDEN_P0_ts60), .RDEN_P1(RDEN_P1_ts60), 
      .ADRRD_P0(ADRRD_P0_ts60), .ADRRD_P1(ADRRD_P1_ts60), .ADRWR_P0(ADRWR_P0_ts60), 
      .ADRWR_P1(ADRWR_P1_ts60), .DIN_P0(DIN_P0_ts60), .DIN_P1(DIN_P1_ts60), .BIST_SO(BIST_SO_ts60), 
      .BIST_GO(BIST_GO_ts60), .All_SCOL0_FUSE_REG(All_SCOL0_FUSE_REG_ts60[5:0]), 
      .All_SCOL0_ALLOC_REG(All_SCOL0_ALLOC_REG_ts60), .REPAIR_STATUS(), .fscan_clkungate(fscan_clkungate)
  );

  hlp_sched_apr_rtl_tessent_mbist_RF_c4_interface_MEM30 ram_row_7_col_0_interface_inst(
      .BIST_SHADOW_READENABLE(BIST_SHADOW_READENABLE_ts1), .BIST_SHADOW_READADDRESS(BIST_SHADOW_READADDRESS_ts1), 
      .BIST_CONREAD_ROWADDRESS(BIST_CONREAD_ROWADDRESS_ts1), .BIST_CONREAD_ENABLE(BIST_CONREAD_ENABLE_ts1), 
      .BIST_CONWRITE_ROWADDRESS(BIST_CONWRITE_ROWADDRESS_ts1), .BIST_CONWRITE_ENABLE(BIST_CONWRITE_ENABLE_ts1), 
      .BIST_CLEAR_BIRA(BIST_CLEAR_BIRA_ts1), .WREN_P0_IN(ram_row_7_col_0_wr_en_a), 
      .WREN_P1_IN(ram_row_7_col_0_wr_en_b), .RDEN_P0_IN(ram_row_7_col_0_rd_en_a), 
      .RDEN_P1_IN(ram_row_7_col_0_rd_en_b), .ADRRD_P0_IN(ram_row_7_col_0_rd_adr_a[7:0]), 
      .ADRRD_P1_IN(ram_row_7_col_0_rd_adr_b[7:0]), .ADRWR_P0_IN(ram_row_7_col_0_wr_adr_a[7:0]), 
      .ADRWR_P1_IN(ram_row_7_col_0_wr_adr_b[7:0]), .QOUT_P0(ram_row_7_col_0_data_out_a), 
      .QOUT_P1(ram_row_7_col_0_data_out_b), .DIN_P0_IN(ram_row_7_col_0_data_in_a[33:0]), 
      .DIN_P1_IN(ram_row_7_col_0_data_in_b[33:0]), .TCK(to_interfaces_tck), .BIST_CMP(BIST_CMP_ts1), 
      .INCLUDE_MEM_RESULTS_REG(INCLUDE_MEM_RESULTS_REG), .BIST_READENABLE(BIST_READENABLE_ts1), 
      .BIST_WRITEENABLE(BIST_WRITEENABLE_ts1), .BIST_ROW_ADD({
      BIST_ROW_ADD_ts7, BIST_ROW_ADD_ts6, BIST_ROW_ADD_ts5, BIST_ROW_ADD_ts4}), .BIST_BANK_ADD({
      BIST_BANK_ADD_ts7, BIST_BANK_ADD_ts6, BIST_BANK_ADD_ts5, 
      BIST_BANK_ADD_ts4}), .BIST_TEST_PORT(BIST_TEST_PORT_ts1), .BIST_WRITE_DATA({
      BIST_WRITE_DATA_ts15, BIST_WRITE_DATA_ts14, BIST_WRITE_DATA_ts13, 
      BIST_WRITE_DATA_ts12, BIST_WRITE_DATA_ts11, BIST_WRITE_DATA_ts10, 
      BIST_WRITE_DATA_ts9, BIST_WRITE_DATA_ts8}), .BIST_TESTDATA_SELECT_TO_COLLAR(BIST_TESTDATA_SELECT_TO_COLLAR_ts1), 
      .MEM_BYPASS_EN(memory_bypass_to_en), .SCAN_SHIFT_EN(scan_to_en), .MCP_BOUNDING_EN(mcp_bounding_to_en), 
      .BIST_ON(BIST_ON_TO_COLLAR_ts1), .BIST_RUN(BIST_RUN_TO_COLLAR29_ts1), .BIST_ASYNC_RESETN(BIST_ASYNC_RESET), 
      .BIST_CLK(clk_a), .BIST_SHIFT_COLLAR(BIST_SHIFT_COLLAR_ts1), .BIST_EXPECT_DATA({
      BIST_EXPECT_DATA_ts15, BIST_EXPECT_DATA_ts14, BIST_EXPECT_DATA_ts13, 
      BIST_EXPECT_DATA_ts12, BIST_EXPECT_DATA_ts11, BIST_EXPECT_DATA_ts10, 
      BIST_EXPECT_DATA_ts9, BIST_EXPECT_DATA_ts8}), .BIST_SI(MEM29_BIST_COLLAR_SI_ts1), 
      .BIST_COLLAR_SETUP(BIST_COLLAR_SETUP_ts1), .BIST_COLLAR_OPSET_SELECT(BIST_COLLAR_OPSET_SELECT_ts1), 
      .BIST_COLLAR_HOLD(BIST_COLLAR_HOLD_ts1), .BIST_BIRA_EN(BIST_COLLAR_BIRA_EN_ts1), 
      .CHECK_REPAIR_NEEDED(CHECK_REPAIR_NEEDED), .BIST_DIAG_EN(BIST_COLLAR_DIAG_EN_ts1), 
      .BIST_CLEAR_DEFAULT(BIST_CLEAR_DEFAULT_ts1), .BIST_CLEAR(BIST_CLEAR_ts1), 
      .BIST_SETUP2(BIST_SETUP_ts2), .BIST_SETUP1(BIST_SETUP_ts1), .BIST_SETUP0(BIST_SETUP), 
      .LV_TM(ltest_to_en), .FREEZE_STOP_ERROR(FREEZE_STOP_ERROR_ts1), .GO_ID_REG_SEL(GO_ID_REG_SEL_ts1), 
      .BIST_COLLAR_EN(BIST_COLLAR_EN29_ts1), .FROM_BISR_All_SCOL0_FUSE_REG(ram_row_7_col_0_bisr_inst_Q[6:1]), 
      .FROM_BISR_All_SCOL0_ALLOC_REG(ram_row_7_col_0_bisr_inst_Q[0]), .BIST_SHIFT_BIRA_COLLAR(BIST_SHIFT_BIRA_COLLAR_ts1), 
      .RESET_REG_SETUP2(MBISTPG_RESET_REG_SETUP2_ts1), .ERROR_CNT_ZERO(ERROR_CNT_ZERO_ts1), 
      .WREN_P0(WREN_P0_ts61), .WREN_P1(WREN_P1_ts61), .RDEN_P0(RDEN_P0_ts61), .RDEN_P1(RDEN_P1_ts61), 
      .ADRRD_P0(ADRRD_P0_ts61), .ADRRD_P1(ADRRD_P1_ts61), .ADRWR_P0(ADRWR_P0_ts61), 
      .ADRWR_P1(ADRWR_P1_ts61), .DIN_P0(DIN_P0_ts61), .DIN_P1(DIN_P1_ts61), .BIST_SO(BIST_SO_ts61), 
      .BIST_GO(BIST_GO_ts61), .All_SCOL0_FUSE_REG(All_SCOL0_FUSE_REG_ts61[5:0]), 
      .All_SCOL0_ALLOC_REG(All_SCOL0_ALLOC_REG_ts61), .REPAIR_STATUS(), .fscan_clkungate(fscan_clkungate)
  );

  hlp_sched_apr_rtl_tessent_mbist_RF_c4_interface_MEM31 ram_row_8_col_0_interface_inst(
      .BIST_SHADOW_READENABLE(BIST_SHADOW_READENABLE_ts1), .BIST_SHADOW_READADDRESS(BIST_SHADOW_READADDRESS_ts1), 
      .BIST_CONREAD_ROWADDRESS(BIST_CONREAD_ROWADDRESS_ts1), .BIST_CONREAD_ENABLE(BIST_CONREAD_ENABLE_ts1), 
      .BIST_CONWRITE_ROWADDRESS(BIST_CONWRITE_ROWADDRESS_ts1), .BIST_CONWRITE_ENABLE(BIST_CONWRITE_ENABLE_ts1), 
      .BIST_CLEAR_BIRA(BIST_CLEAR_BIRA_ts1), .WREN_P0_IN(ram_row_8_col_0_wr_en_a), 
      .WREN_P1_IN(ram_row_8_col_0_wr_en_b), .RDEN_P0_IN(ram_row_8_col_0_rd_en_a), 
      .RDEN_P1_IN(ram_row_8_col_0_rd_en_b), .ADRRD_P0_IN(ram_row_8_col_0_rd_adr_a[7:0]), 
      .ADRRD_P1_IN(ram_row_8_col_0_rd_adr_b[7:0]), .ADRWR_P0_IN(ram_row_8_col_0_wr_adr_a[7:0]), 
      .ADRWR_P1_IN(ram_row_8_col_0_wr_adr_b[7:0]), .QOUT_P0(ram_row_8_col_0_data_out_a), 
      .QOUT_P1(ram_row_8_col_0_data_out_b), .DIN_P0_IN(ram_row_8_col_0_data_in_a[33:0]), 
      .DIN_P1_IN(ram_row_8_col_0_data_in_b[33:0]), .TCK(to_interfaces_tck), .BIST_CMP(BIST_CMP_ts1), 
      .INCLUDE_MEM_RESULTS_REG(INCLUDE_MEM_RESULTS_REG), .BIST_READENABLE(BIST_READENABLE_ts1), 
      .BIST_WRITEENABLE(BIST_WRITEENABLE_ts1), .BIST_ROW_ADD({
      BIST_ROW_ADD_ts7, BIST_ROW_ADD_ts6, BIST_ROW_ADD_ts5, BIST_ROW_ADD_ts4}), .BIST_BANK_ADD({
      BIST_BANK_ADD_ts7, BIST_BANK_ADD_ts6, BIST_BANK_ADD_ts5, 
      BIST_BANK_ADD_ts4}), .BIST_TEST_PORT(BIST_TEST_PORT_ts1), .BIST_WRITE_DATA({
      BIST_WRITE_DATA_ts15, BIST_WRITE_DATA_ts14, BIST_WRITE_DATA_ts13, 
      BIST_WRITE_DATA_ts12, BIST_WRITE_DATA_ts11, BIST_WRITE_DATA_ts10, 
      BIST_WRITE_DATA_ts9, BIST_WRITE_DATA_ts8}), .BIST_TESTDATA_SELECT_TO_COLLAR(BIST_TESTDATA_SELECT_TO_COLLAR_ts1), 
      .MEM_BYPASS_EN(memory_bypass_to_en), .SCAN_SHIFT_EN(scan_to_en), .MCP_BOUNDING_EN(mcp_bounding_to_en), 
      .BIST_ON(BIST_ON_TO_COLLAR_ts1), .BIST_RUN(BIST_RUN_TO_COLLAR30_ts1), .BIST_ASYNC_RESETN(BIST_ASYNC_RESET), 
      .BIST_CLK(clk_a), .BIST_SHIFT_COLLAR(BIST_SHIFT_COLLAR_ts1), .BIST_EXPECT_DATA({
      BIST_EXPECT_DATA_ts15, BIST_EXPECT_DATA_ts14, BIST_EXPECT_DATA_ts13, 
      BIST_EXPECT_DATA_ts12, BIST_EXPECT_DATA_ts11, BIST_EXPECT_DATA_ts10, 
      BIST_EXPECT_DATA_ts9, BIST_EXPECT_DATA_ts8}), .BIST_SI(MEM30_BIST_COLLAR_SI_ts1), 
      .BIST_COLLAR_SETUP(BIST_COLLAR_SETUP_ts1), .BIST_COLLAR_OPSET_SELECT(BIST_COLLAR_OPSET_SELECT_ts1), 
      .BIST_COLLAR_HOLD(BIST_COLLAR_HOLD_ts1), .BIST_BIRA_EN(BIST_COLLAR_BIRA_EN_ts1), 
      .CHECK_REPAIR_NEEDED(CHECK_REPAIR_NEEDED), .BIST_DIAG_EN(BIST_COLLAR_DIAG_EN_ts1), 
      .BIST_CLEAR_DEFAULT(BIST_CLEAR_DEFAULT_ts1), .BIST_CLEAR(BIST_CLEAR_ts1), 
      .BIST_SETUP2(BIST_SETUP_ts2), .BIST_SETUP1(BIST_SETUP_ts1), .BIST_SETUP0(BIST_SETUP), 
      .LV_TM(ltest_to_en), .FREEZE_STOP_ERROR(FREEZE_STOP_ERROR_ts1), .GO_ID_REG_SEL(GO_ID_REG_SEL_ts1), 
      .BIST_COLLAR_EN(BIST_COLLAR_EN30_ts1), .FROM_BISR_All_SCOL0_FUSE_REG(ram_row_8_col_0_bisr_inst_Q[6:1]), 
      .FROM_BISR_All_SCOL0_ALLOC_REG(ram_row_8_col_0_bisr_inst_Q[0]), .BIST_SHIFT_BIRA_COLLAR(BIST_SHIFT_BIRA_COLLAR_ts1), 
      .RESET_REG_SETUP2(MBISTPG_RESET_REG_SETUP2_ts1), .ERROR_CNT_ZERO(ERROR_CNT_ZERO_ts1), 
      .WREN_P0(WREN_P0_ts62), .WREN_P1(WREN_P1_ts62), .RDEN_P0(RDEN_P0_ts62), .RDEN_P1(RDEN_P1_ts62), 
      .ADRRD_P0(ADRRD_P0_ts62), .ADRRD_P1(ADRRD_P1_ts62), .ADRWR_P0(ADRWR_P0_ts62), 
      .ADRWR_P1(ADRWR_P1_ts62), .DIN_P0(DIN_P0_ts62), .DIN_P1(DIN_P1_ts62), .BIST_SO(BIST_SO_ts62), 
      .BIST_GO(BIST_GO_ts62), .All_SCOL0_FUSE_REG(All_SCOL0_FUSE_REG_ts62[5:0]), 
      .All_SCOL0_ALLOC_REG(All_SCOL0_ALLOC_REG_ts62), .REPAIR_STATUS(), .fscan_clkungate(fscan_clkungate)
  );

  hlp_sched_apr_rtl_tessent_mbist_RF_c4_interface_MEM32 ram_row_9_col_0_interface_inst(
      .BIST_SHADOW_READENABLE(BIST_SHADOW_READENABLE_ts1), .BIST_SHADOW_READADDRESS(BIST_SHADOW_READADDRESS_ts1), 
      .BIST_CONREAD_ROWADDRESS(BIST_CONREAD_ROWADDRESS_ts1), .BIST_CONREAD_ENABLE(BIST_CONREAD_ENABLE_ts1), 
      .BIST_CONWRITE_ROWADDRESS(BIST_CONWRITE_ROWADDRESS_ts1), .BIST_CONWRITE_ENABLE(BIST_CONWRITE_ENABLE_ts1), 
      .BIST_CLEAR_BIRA(BIST_CLEAR_BIRA_ts1), .WREN_P0_IN(ram_row_9_col_0_wr_en_a), 
      .WREN_P1_IN(ram_row_9_col_0_wr_en_b), .RDEN_P0_IN(ram_row_9_col_0_rd_en_a), 
      .RDEN_P1_IN(ram_row_9_col_0_rd_en_b), .ADRRD_P0_IN(ram_row_9_col_0_rd_adr_a[7:0]), 
      .ADRRD_P1_IN(ram_row_9_col_0_rd_adr_b[7:0]), .ADRWR_P0_IN(ram_row_9_col_0_wr_adr_a[7:0]), 
      .ADRWR_P1_IN(ram_row_9_col_0_wr_adr_b[7:0]), .QOUT_P0(ram_row_9_col_0_data_out_a), 
      .QOUT_P1(ram_row_9_col_0_data_out_b), .DIN_P0_IN(ram_row_9_col_0_data_in_a[33:0]), 
      .DIN_P1_IN(ram_row_9_col_0_data_in_b[33:0]), .TCK(to_interfaces_tck), .BIST_CMP(BIST_CMP_ts1), 
      .INCLUDE_MEM_RESULTS_REG(INCLUDE_MEM_RESULTS_REG), .BIST_READENABLE(BIST_READENABLE_ts1), 
      .BIST_WRITEENABLE(BIST_WRITEENABLE_ts1), .BIST_ROW_ADD({
      BIST_ROW_ADD_ts7, BIST_ROW_ADD_ts6, BIST_ROW_ADD_ts5, BIST_ROW_ADD_ts4}), .BIST_BANK_ADD({
      BIST_BANK_ADD_ts7, BIST_BANK_ADD_ts6, BIST_BANK_ADD_ts5, 
      BIST_BANK_ADD_ts4}), .BIST_TEST_PORT(BIST_TEST_PORT_ts1), .BIST_WRITE_DATA({
      BIST_WRITE_DATA_ts15, BIST_WRITE_DATA_ts14, BIST_WRITE_DATA_ts13, 
      BIST_WRITE_DATA_ts12, BIST_WRITE_DATA_ts11, BIST_WRITE_DATA_ts10, 
      BIST_WRITE_DATA_ts9, BIST_WRITE_DATA_ts8}), .BIST_TESTDATA_SELECT_TO_COLLAR(BIST_TESTDATA_SELECT_TO_COLLAR_ts1), 
      .MEM_BYPASS_EN(memory_bypass_to_en), .SCAN_SHIFT_EN(scan_to_en), .MCP_BOUNDING_EN(mcp_bounding_to_en), 
      .BIST_ON(BIST_ON_TO_COLLAR_ts1), .BIST_RUN(BIST_RUN_TO_COLLAR31_ts1), .BIST_ASYNC_RESETN(BIST_ASYNC_RESET), 
      .BIST_CLK(clk_a), .BIST_SHIFT_COLLAR(BIST_SHIFT_COLLAR_ts1), .BIST_EXPECT_DATA({
      BIST_EXPECT_DATA_ts15, BIST_EXPECT_DATA_ts14, BIST_EXPECT_DATA_ts13, 
      BIST_EXPECT_DATA_ts12, BIST_EXPECT_DATA_ts11, BIST_EXPECT_DATA_ts10, 
      BIST_EXPECT_DATA_ts9, BIST_EXPECT_DATA_ts8}), .BIST_SI(MEM31_BIST_COLLAR_SI_ts1), 
      .BIST_COLLAR_SETUP(BIST_COLLAR_SETUP_ts1), .BIST_COLLAR_OPSET_SELECT(BIST_COLLAR_OPSET_SELECT_ts1), 
      .BIST_COLLAR_HOLD(BIST_COLLAR_HOLD_ts1), .BIST_BIRA_EN(BIST_COLLAR_BIRA_EN_ts1), 
      .CHECK_REPAIR_NEEDED(CHECK_REPAIR_NEEDED), .BIST_DIAG_EN(BIST_COLLAR_DIAG_EN_ts1), 
      .BIST_CLEAR_DEFAULT(BIST_CLEAR_DEFAULT_ts1), .BIST_CLEAR(BIST_CLEAR_ts1), 
      .BIST_SETUP2(BIST_SETUP_ts2), .BIST_SETUP1(BIST_SETUP_ts1), .BIST_SETUP0(BIST_SETUP), 
      .LV_TM(ltest_to_en), .FREEZE_STOP_ERROR(FREEZE_STOP_ERROR_ts1), .GO_ID_REG_SEL(GO_ID_REG_SEL_ts1), 
      .BIST_COLLAR_EN(BIST_COLLAR_EN31_ts1), .FROM_BISR_All_SCOL0_FUSE_REG(ram_row_9_col_0_bisr_inst_Q[6:1]), 
      .FROM_BISR_All_SCOL0_ALLOC_REG(ram_row_9_col_0_bisr_inst_Q[0]), .BIST_SHIFT_BIRA_COLLAR(BIST_SHIFT_BIRA_COLLAR_ts1), 
      .RESET_REG_SETUP2(MBISTPG_RESET_REG_SETUP2_ts1), .ERROR_CNT_ZERO(ERROR_CNT_ZERO_ts1), 
      .WREN_P0(WREN_P0_ts63), .WREN_P1(WREN_P1_ts63), .RDEN_P0(RDEN_P0_ts63), .RDEN_P1(RDEN_P1_ts63), 
      .ADRRD_P0(ADRRD_P0_ts63), .ADRRD_P1(ADRRD_P1_ts63), .ADRWR_P0(ADRWR_P0_ts63), 
      .ADRWR_P1(ADRWR_P1_ts63), .DIN_P0(DIN_P0_ts63), .DIN_P1(DIN_P1_ts63), .BIST_SO(BIST_SO_ts63), 
      .BIST_GO(BIST_GO_ts63), .All_SCOL0_FUSE_REG(All_SCOL0_FUSE_REG_ts63[5:0]), 
      .All_SCOL0_ALLOC_REG(All_SCOL0_ALLOC_REG_ts63), .REPAIR_STATUS(), .fscan_clkungate(fscan_clkungate)
  );

  hlp_sched_apr_rtl_tessent_mbisr_register_ip783rfhs2r2w256x34s0c1p1d0_dft_wrp ram_row_0_col_0_bisr_inst(
      .CLK(bisr_clk_pd_vinf), .RSTB(bisr_reset_pd_vinf), .SI(ram_row_0_col_0_bisr_inst_SO), 
      .SO(ram_row_0_col_0_bisr_inst_SO_ts1), .SE(bisr_shift_en_pd_vinf), .D({
      All_SCOL0_FUSE_REG[5:0], All_SCOL0_ALLOC_REG}), .MSO(1'b0), .MSEL(1'b0), .Q(ram_row_0_col_0_bisr_inst_Q)
  );

  hlp_sched_apr_rtl_tessent_mbisr_register_ip783rfhs2r2w256x34s0c1p1d0_dft_wrp ram_row_10_col_0_bisr_inst(
      .CLK(bisr_clk_pd_vinf), .RSTB(bisr_reset_pd_vinf), .SI(ram_row_0_col_0_bisr_inst_SO_ts1), 
      .SO(ram_row_10_col_0_bisr_inst_SO), .SE(bisr_shift_en_pd_vinf), .D({
      All_SCOL0_FUSE_REG_ts1[5:0], All_SCOL0_ALLOC_REG_ts1}), .MSO(1'b0), .MSEL(1'b0), 
      .Q(ram_row_10_col_0_bisr_inst_Q)
  );

  hlp_sched_apr_rtl_tessent_mbisr_register_ip783rfhs2r2w256x34s0c1p1d0_dft_wrp ram_row_11_col_0_bisr_inst(
      .CLK(bisr_clk_pd_vinf), .RSTB(bisr_reset_pd_vinf), .SI(ram_row_10_col_0_bisr_inst_SO), 
      .SO(ram_row_11_col_0_bisr_inst_SO), .SE(bisr_shift_en_pd_vinf), .D({
      All_SCOL0_FUSE_REG_ts2[5:0], All_SCOL0_ALLOC_REG_ts2}), .MSO(1'b0), .MSEL(1'b0), 
      .Q(ram_row_11_col_0_bisr_inst_Q)
  );

  hlp_sched_apr_rtl_tessent_mbisr_register_ip783rfhs2r2w256x34s0c1p1d0_dft_wrp ram_row_12_col_0_bisr_inst(
      .CLK(bisr_clk_pd_vinf), .RSTB(bisr_reset_pd_vinf), .SI(ram_row_11_col_0_bisr_inst_SO), 
      .SO(ram_row_12_col_0_bisr_inst_SO), .SE(bisr_shift_en_pd_vinf), .D({
      All_SCOL0_FUSE_REG_ts3[5:0], All_SCOL0_ALLOC_REG_ts3}), .MSO(1'b0), .MSEL(1'b0), 
      .Q(ram_row_12_col_0_bisr_inst_Q)
  );

  hlp_sched_apr_rtl_tessent_mbisr_register_ip783rfhs2r2w256x34s0c1p1d0_dft_wrp ram_row_13_col_0_bisr_inst(
      .CLK(bisr_clk_pd_vinf), .RSTB(bisr_reset_pd_vinf), .SI(ram_row_12_col_0_bisr_inst_SO), 
      .SO(ram_row_13_col_0_bisr_inst_SO), .SE(bisr_shift_en_pd_vinf), .D({
      All_SCOL0_FUSE_REG_ts4[5:0], All_SCOL0_ALLOC_REG_ts4}), .MSO(1'b0), .MSEL(1'b0), 
      .Q(ram_row_13_col_0_bisr_inst_Q)
  );

  hlp_sched_apr_rtl_tessent_mbisr_register_ip783rfhs2r2w256x34s0c1p1d0_dft_wrp ram_row_14_col_0_bisr_inst(
      .CLK(bisr_clk_pd_vinf), .RSTB(bisr_reset_pd_vinf), .SI(ram_row_13_col_0_bisr_inst_SO), 
      .SO(ram_row_14_col_0_bisr_inst_SO), .SE(bisr_shift_en_pd_vinf), .D({
      All_SCOL0_FUSE_REG_ts5[5:0], All_SCOL0_ALLOC_REG_ts5}), .MSO(1'b0), .MSEL(1'b0), 
      .Q(ram_row_14_col_0_bisr_inst_Q)
  );

  hlp_sched_apr_rtl_tessent_mbisr_register_ip783rfhs2r2w256x34s0c1p1d0_dft_wrp ram_row_15_col_0_bisr_inst(
      .CLK(bisr_clk_pd_vinf), .RSTB(bisr_reset_pd_vinf), .SI(ram_row_14_col_0_bisr_inst_SO), 
      .SO(ram_row_15_col_0_bisr_inst_SO), .SE(bisr_shift_en_pd_vinf), .D({
      All_SCOL0_FUSE_REG_ts6[5:0], All_SCOL0_ALLOC_REG_ts6}), .MSO(1'b0), .MSEL(1'b0), 
      .Q(ram_row_15_col_0_bisr_inst_Q)
  );

  hlp_sched_apr_rtl_tessent_mbisr_register_ip783rfhs2r2w256x34s0c1p1d0_dft_wrp ram_row_16_col_0_bisr_inst(
      .CLK(bisr_clk_pd_vinf), .RSTB(bisr_reset_pd_vinf), .SI(ram_row_15_col_0_bisr_inst_SO), 
      .SO(ram_row_16_col_0_bisr_inst_SO), .SE(bisr_shift_en_pd_vinf), .D({
      All_SCOL0_FUSE_REG_ts7[5:0], All_SCOL0_ALLOC_REG_ts7}), .MSO(1'b0), .MSEL(1'b0), 
      .Q(ram_row_16_col_0_bisr_inst_Q)
  );

  hlp_sched_apr_rtl_tessent_mbisr_register_ip783rfhs2r2w256x34s0c1p1d0_dft_wrp ram_row_17_col_0_bisr_inst(
      .CLK(bisr_clk_pd_vinf), .RSTB(bisr_reset_pd_vinf), .SI(ram_row_16_col_0_bisr_inst_SO), 
      .SO(ram_row_17_col_0_bisr_inst_SO), .SE(bisr_shift_en_pd_vinf), .D({
      All_SCOL0_FUSE_REG_ts8[5:0], All_SCOL0_ALLOC_REG_ts8}), .MSO(1'b0), .MSEL(1'b0), 
      .Q(ram_row_17_col_0_bisr_inst_Q)
  );

  hlp_sched_apr_rtl_tessent_mbisr_register_ip783rfhs2r2w256x34s0c1p1d0_dft_wrp ram_row_18_col_0_bisr_inst(
      .CLK(bisr_clk_pd_vinf), .RSTB(bisr_reset_pd_vinf), .SI(ram_row_17_col_0_bisr_inst_SO), 
      .SO(ram_row_18_col_0_bisr_inst_SO), .SE(bisr_shift_en_pd_vinf), .D({
      All_SCOL0_FUSE_REG_ts9[5:0], All_SCOL0_ALLOC_REG_ts9}), .MSO(1'b0), .MSEL(1'b0), 
      .Q(ram_row_18_col_0_bisr_inst_Q)
  );

  hlp_sched_apr_rtl_tessent_mbisr_register_ip783rfhs2r2w256x34s0c1p1d0_dft_wrp ram_row_19_col_0_bisr_inst(
      .CLK(bisr_clk_pd_vinf), .RSTB(bisr_reset_pd_vinf), .SI(ram_row_18_col_0_bisr_inst_SO), 
      .SO(ram_row_19_col_0_bisr_inst_SO), .SE(bisr_shift_en_pd_vinf), .D({
      All_SCOL0_FUSE_REG_ts10[5:0], All_SCOL0_ALLOC_REG_ts10}), .MSO(1'b0), .MSEL(1'b0), 
      .Q(ram_row_19_col_0_bisr_inst_Q)
  );

  hlp_sched_apr_rtl_tessent_mbisr_register_ip783rfhs2r2w256x34s0c1p1d0_dft_wrp ram_row_1_col_0_bisr_inst(
      .CLK(bisr_clk_pd_vinf), .RSTB(bisr_reset_pd_vinf), .SI(ram_row_19_col_0_bisr_inst_SO), 
      .SO(ram_row_1_col_0_bisr_inst_SO), .SE(bisr_shift_en_pd_vinf), .D({
      All_SCOL0_FUSE_REG_ts11[5:0], All_SCOL0_ALLOC_REG_ts11}), .MSO(1'b0), .MSEL(1'b0), 
      .Q(ram_row_1_col_0_bisr_inst_Q)
  );

  hlp_sched_apr_rtl_tessent_mbisr_register_ip783rfhs2r2w256x34s0c1p1d0_dft_wrp ram_row_20_col_0_bisr_inst(
      .CLK(bisr_clk_pd_vinf), .RSTB(bisr_reset_pd_vinf), .SI(ram_row_1_col_0_bisr_inst_SO), 
      .SO(ram_row_20_col_0_bisr_inst_SO), .SE(bisr_shift_en_pd_vinf), .D({
      All_SCOL0_FUSE_REG_ts12[5:0], All_SCOL0_ALLOC_REG_ts12}), .MSO(1'b0), .MSEL(1'b0), 
      .Q(ram_row_20_col_0_bisr_inst_Q)
  );

  hlp_sched_apr_rtl_tessent_mbisr_register_ip783rfhs2r2w256x34s0c1p1d0_dft_wrp ram_row_21_col_0_bisr_inst(
      .CLK(bisr_clk_pd_vinf), .RSTB(bisr_reset_pd_vinf), .SI(ram_row_20_col_0_bisr_inst_SO), 
      .SO(ram_row_21_col_0_bisr_inst_SO), .SE(bisr_shift_en_pd_vinf), .D({
      All_SCOL0_FUSE_REG_ts13[5:0], All_SCOL0_ALLOC_REG_ts13}), .MSO(1'b0), .MSEL(1'b0), 
      .Q(ram_row_21_col_0_bisr_inst_Q)
  );

  hlp_sched_apr_rtl_tessent_mbisr_register_ip783rfhs2r2w256x34s0c1p1d0_dft_wrp ram_row_22_col_0_bisr_inst(
      .CLK(bisr_clk_pd_vinf), .RSTB(bisr_reset_pd_vinf), .SI(ram_row_21_col_0_bisr_inst_SO), 
      .SO(ram_row_22_col_0_bisr_inst_SO), .SE(bisr_shift_en_pd_vinf), .D({
      All_SCOL0_FUSE_REG_ts14[5:0], All_SCOL0_ALLOC_REG_ts14}), .MSO(1'b0), .MSEL(1'b0), 
      .Q(ram_row_22_col_0_bisr_inst_Q)
  );

  hlp_sched_apr_rtl_tessent_mbisr_register_ip783rfhs2r2w256x34s0c1p1d0_dft_wrp ram_row_23_col_0_bisr_inst(
      .CLK(bisr_clk_pd_vinf), .RSTB(bisr_reset_pd_vinf), .SI(ram_row_22_col_0_bisr_inst_SO), 
      .SO(ram_row_23_col_0_bisr_inst_SO), .SE(bisr_shift_en_pd_vinf), .D({
      All_SCOL0_FUSE_REG_ts15[5:0], All_SCOL0_ALLOC_REG_ts15}), .MSO(1'b0), .MSEL(1'b0), 
      .Q(ram_row_23_col_0_bisr_inst_Q)
  );

  hlp_sched_apr_rtl_tessent_mbisr_register_ip783rfhs2r2w256x34s0c1p1d0_dft_wrp ram_row_24_col_0_bisr_inst(
      .CLK(bisr_clk_pd_vinf), .RSTB(bisr_reset_pd_vinf), .SI(ram_row_23_col_0_bisr_inst_SO), 
      .SO(ram_row_24_col_0_bisr_inst_SO), .SE(bisr_shift_en_pd_vinf), .D({
      All_SCOL0_FUSE_REG_ts16[5:0], All_SCOL0_ALLOC_REG_ts16}), .MSO(1'b0), .MSEL(1'b0), 
      .Q(ram_row_24_col_0_bisr_inst_Q)
  );

  hlp_sched_apr_rtl_tessent_mbisr_register_ip783rfhs2r2w256x34s0c1p1d0_dft_wrp ram_row_25_col_0_bisr_inst(
      .CLK(bisr_clk_pd_vinf), .RSTB(bisr_reset_pd_vinf), .SI(ram_row_24_col_0_bisr_inst_SO), 
      .SO(ram_row_25_col_0_bisr_inst_SO), .SE(bisr_shift_en_pd_vinf), .D({
      All_SCOL0_FUSE_REG_ts17[5:0], All_SCOL0_ALLOC_REG_ts17}), .MSO(1'b0), .MSEL(1'b0), 
      .Q(ram_row_25_col_0_bisr_inst_Q)
  );

  hlp_sched_apr_rtl_tessent_mbisr_register_ip783rfhs2r2w256x34s0c1p1d0_dft_wrp ram_row_26_col_0_bisr_inst(
      .CLK(bisr_clk_pd_vinf), .RSTB(bisr_reset_pd_vinf), .SI(ram_row_25_col_0_bisr_inst_SO), 
      .SO(ram_row_26_col_0_bisr_inst_SO), .SE(bisr_shift_en_pd_vinf), .D({
      All_SCOL0_FUSE_REG_ts18[5:0], All_SCOL0_ALLOC_REG_ts18}), .MSO(1'b0), .MSEL(1'b0), 
      .Q(ram_row_26_col_0_bisr_inst_Q)
  );

  hlp_sched_apr_rtl_tessent_mbisr_register_ip783rfhs2r2w256x34s0c1p1d0_dft_wrp ram_row_27_col_0_bisr_inst(
      .CLK(bisr_clk_pd_vinf), .RSTB(bisr_reset_pd_vinf), .SI(ram_row_26_col_0_bisr_inst_SO), 
      .SO(ram_row_27_col_0_bisr_inst_SO), .SE(bisr_shift_en_pd_vinf), .D({
      All_SCOL0_FUSE_REG_ts19[5:0], All_SCOL0_ALLOC_REG_ts19}), .MSO(1'b0), .MSEL(1'b0), 
      .Q(ram_row_27_col_0_bisr_inst_Q)
  );

  hlp_sched_apr_rtl_tessent_mbisr_register_ip783rfhs2r2w256x34s0c1p1d0_dft_wrp ram_row_28_col_0_bisr_inst(
      .CLK(bisr_clk_pd_vinf), .RSTB(bisr_reset_pd_vinf), .SI(ram_row_27_col_0_bisr_inst_SO), 
      .SO(ram_row_28_col_0_bisr_inst_SO), .SE(bisr_shift_en_pd_vinf), .D({
      All_SCOL0_FUSE_REG_ts20[5:0], All_SCOL0_ALLOC_REG_ts20}), .MSO(1'b0), .MSEL(1'b0), 
      .Q(ram_row_28_col_0_bisr_inst_Q)
  );

  hlp_sched_apr_rtl_tessent_mbisr_register_ip783rfhs2r2w256x34s0c1p1d0_dft_wrp ram_row_29_col_0_bisr_inst(
      .CLK(bisr_clk_pd_vinf), .RSTB(bisr_reset_pd_vinf), .SI(ram_row_28_col_0_bisr_inst_SO), 
      .SO(ram_row_29_col_0_bisr_inst_SO), .SE(bisr_shift_en_pd_vinf), .D({
      All_SCOL0_FUSE_REG_ts21[5:0], All_SCOL0_ALLOC_REG_ts21}), .MSO(1'b0), .MSEL(1'b0), 
      .Q(ram_row_29_col_0_bisr_inst_Q)
  );

  hlp_sched_apr_rtl_tessent_mbisr_register_ip783rfhs2r2w256x34s0c1p1d0_dft_wrp ram_row_2_col_0_bisr_inst(
      .CLK(bisr_clk_pd_vinf), .RSTB(bisr_reset_pd_vinf), .SI(ram_row_29_col_0_bisr_inst_SO), 
      .SO(ram_row_2_col_0_bisr_inst_SO), .SE(bisr_shift_en_pd_vinf), .D({
      All_SCOL0_FUSE_REG_ts22[5:0], All_SCOL0_ALLOC_REG_ts22}), .MSO(1'b0), .MSEL(1'b0), 
      .Q(ram_row_2_col_0_bisr_inst_Q)
  );

  hlp_sched_apr_rtl_tessent_mbisr_register_ip783rfhs2r2w256x34s0c1p1d0_dft_wrp ram_row_30_col_0_bisr_inst(
      .CLK(bisr_clk_pd_vinf), .RSTB(bisr_reset_pd_vinf), .SI(ram_row_2_col_0_bisr_inst_SO), 
      .SO(ram_row_30_col_0_bisr_inst_SO), .SE(bisr_shift_en_pd_vinf), .D({
      All_SCOL0_FUSE_REG_ts23[5:0], All_SCOL0_ALLOC_REG_ts23}), .MSO(1'b0), .MSEL(1'b0), 
      .Q(ram_row_30_col_0_bisr_inst_Q)
  );

  hlp_sched_apr_rtl_tessent_mbisr_register_ip783rfhs2r2w256x34s0c1p1d0_dft_wrp ram_row_31_col_0_bisr_inst(
      .CLK(bisr_clk_pd_vinf), .RSTB(bisr_reset_pd_vinf), .SI(ram_row_30_col_0_bisr_inst_SO), 
      .SO(ram_row_31_col_0_bisr_inst_SO), .SE(bisr_shift_en_pd_vinf), .D({
      All_SCOL0_FUSE_REG_ts24[5:0], All_SCOL0_ALLOC_REG_ts24}), .MSO(1'b0), .MSEL(1'b0), 
      .Q(ram_row_31_col_0_bisr_inst_Q)
  );

  hlp_sched_apr_rtl_tessent_mbisr_register_ip783rfhs2r2w256x34s0c1p1d0_dft_wrp ram_row_32_col_0_bisr_inst(
      .CLK(bisr_clk_pd_vinf), .RSTB(bisr_reset_pd_vinf), .SI(ram_row_31_col_0_bisr_inst_SO), 
      .SO(ram_row_32_col_0_bisr_inst_SO), .SE(bisr_shift_en_pd_vinf), .D({
      All_SCOL0_FUSE_REG_ts25[5:0], All_SCOL0_ALLOC_REG_ts25}), .MSO(1'b0), .MSEL(1'b0), 
      .Q(ram_row_32_col_0_bisr_inst_Q)
  );

  hlp_sched_apr_rtl_tessent_mbisr_register_ip783rfhs2r2w256x34s0c1p1d0_dft_wrp ram_row_33_col_0_bisr_inst(
      .CLK(bisr_clk_pd_vinf), .RSTB(bisr_reset_pd_vinf), .SI(ram_row_32_col_0_bisr_inst_SO), 
      .SO(ram_row_33_col_0_bisr_inst_SO), .SE(bisr_shift_en_pd_vinf), .D({
      All_SCOL0_FUSE_REG_ts26[5:0], All_SCOL0_ALLOC_REG_ts26}), .MSO(1'b0), .MSEL(1'b0), 
      .Q(ram_row_33_col_0_bisr_inst_Q)
  );

  hlp_sched_apr_rtl_tessent_mbisr_register_ip783rfhs2r2w256x34s0c1p1d0_dft_wrp ram_row_34_col_0_bisr_inst(
      .CLK(bisr_clk_pd_vinf), .RSTB(bisr_reset_pd_vinf), .SI(ram_row_33_col_0_bisr_inst_SO), 
      .SO(ram_row_34_col_0_bisr_inst_SO), .SE(bisr_shift_en_pd_vinf), .D({
      All_SCOL0_FUSE_REG_ts27[5:0], All_SCOL0_ALLOC_REG_ts27}), .MSO(1'b0), .MSEL(1'b0), 
      .Q(ram_row_34_col_0_bisr_inst_Q)
  );

  hlp_sched_apr_rtl_tessent_mbisr_register_ip783rfhs2r2w256x34s0c1p1d0_dft_wrp ram_row_35_col_0_bisr_inst(
      .CLK(bisr_clk_pd_vinf), .RSTB(bisr_reset_pd_vinf), .SI(ram_row_34_col_0_bisr_inst_SO), 
      .SO(ram_row_35_col_0_bisr_inst_SO), .SE(bisr_shift_en_pd_vinf), .D({
      All_SCOL0_FUSE_REG_ts28[5:0], All_SCOL0_ALLOC_REG_ts28}), .MSO(1'b0), .MSEL(1'b0), 
      .Q(ram_row_35_col_0_bisr_inst_Q)
  );

  hlp_sched_apr_rtl_tessent_mbisr_register_ip783rfhs2r2w256x34s0c1p1d0_dft_wrp ram_row_36_col_0_bisr_inst(
      .CLK(bisr_clk_pd_vinf), .RSTB(bisr_reset_pd_vinf), .SI(ram_row_35_col_0_bisr_inst_SO), 
      .SO(ram_row_36_col_0_bisr_inst_SO), .SE(bisr_shift_en_pd_vinf), .D({
      All_SCOL0_FUSE_REG_ts29[5:0], All_SCOL0_ALLOC_REG_ts29}), .MSO(1'b0), .MSEL(1'b0), 
      .Q(ram_row_36_col_0_bisr_inst_Q)
  );

  hlp_sched_apr_rtl_tessent_mbisr_register_ip783rfhs2r2w256x34s0c1p1d0_dft_wrp ram_row_37_col_0_bisr_inst(
      .CLK(bisr_clk_pd_vinf), .RSTB(bisr_reset_pd_vinf), .SI(ram_row_36_col_0_bisr_inst_SO), 
      .SO(ram_row_37_col_0_bisr_inst_SO), .SE(bisr_shift_en_pd_vinf), .D({
      All_SCOL0_FUSE_REG_ts30[5:0], All_SCOL0_ALLOC_REG_ts30}), .MSO(1'b0), .MSEL(1'b0), 
      .Q(ram_row_37_col_0_bisr_inst_Q)
  );

  hlp_sched_apr_rtl_tessent_mbisr_register_ip783rfhs2r2w256x34s0c1p1d0_dft_wrp ram_row_38_col_0_bisr_inst(
      .CLK(bisr_clk_pd_vinf), .RSTB(bisr_reset_pd_vinf), .SI(ram_row_37_col_0_bisr_inst_SO), 
      .SO(ram_row_38_col_0_bisr_inst_SO), .SE(bisr_shift_en_pd_vinf), .D({
      All_SCOL0_FUSE_REG_ts31[5:0], All_SCOL0_ALLOC_REG_ts31}), .MSO(1'b0), .MSEL(1'b0), 
      .Q(ram_row_38_col_0_bisr_inst_Q)
  );

  hlp_sched_apr_rtl_tessent_mbisr_register_ip783rfhs2r2w256x34s0c1p1d0_dft_wrp ram_row_39_col_0_bisr_inst(
      .CLK(bisr_clk_pd_vinf), .RSTB(bisr_reset_pd_vinf), .SI(ram_row_38_col_0_bisr_inst_SO), 
      .SO(ram_row_39_col_0_bisr_inst_SO), .SE(bisr_shift_en_pd_vinf), .D({
      All_SCOL0_FUSE_REG_ts32[5:0], All_SCOL0_ALLOC_REG_ts32}), .MSO(1'b0), .MSEL(1'b0), 
      .Q(ram_row_39_col_0_bisr_inst_Q)
  );

  hlp_sched_apr_rtl_tessent_mbisr_register_ip783rfhs2r2w256x34s0c1p1d0_dft_wrp ram_row_3_col_0_bisr_inst(
      .CLK(bisr_clk_pd_vinf), .RSTB(bisr_reset_pd_vinf), .SI(ram_row_39_col_0_bisr_inst_SO), 
      .SO(ram_row_3_col_0_bisr_inst_SO), .SE(bisr_shift_en_pd_vinf), .D({
      All_SCOL0_FUSE_REG_ts33[5:0], All_SCOL0_ALLOC_REG_ts33}), .MSO(1'b0), .MSEL(1'b0), 
      .Q(ram_row_3_col_0_bisr_inst_Q)
  );

  hlp_sched_apr_rtl_tessent_mbisr_register_ip783rfhs2r2w256x34s0c1p1d0_dft_wrp ram_row_40_col_0_bisr_inst(
      .CLK(bisr_clk_pd_vinf), .RSTB(bisr_reset_pd_vinf), .SI(ram_row_3_col_0_bisr_inst_SO), 
      .SO(ram_row_40_col_0_bisr_inst_SO), .SE(bisr_shift_en_pd_vinf), .D({
      All_SCOL0_FUSE_REG_ts34[5:0], All_SCOL0_ALLOC_REG_ts34}), .MSO(1'b0), .MSEL(1'b0), 
      .Q(ram_row_40_col_0_bisr_inst_Q)
  );

  hlp_sched_apr_rtl_tessent_mbisr_register_ip783rfhs2r2w256x34s0c1p1d0_dft_wrp ram_row_41_col_0_bisr_inst(
      .CLK(bisr_clk_pd_vinf), .RSTB(bisr_reset_pd_vinf), .SI(ram_row_40_col_0_bisr_inst_SO), 
      .SO(ram_row_41_col_0_bisr_inst_SO), .SE(bisr_shift_en_pd_vinf), .D({
      All_SCOL0_FUSE_REG_ts35[5:0], All_SCOL0_ALLOC_REG_ts35}), .MSO(1'b0), .MSEL(1'b0), 
      .Q(ram_row_41_col_0_bisr_inst_Q)
  );

  hlp_sched_apr_rtl_tessent_mbisr_register_ip783rfhs2r2w256x34s0c1p1d0_dft_wrp ram_row_42_col_0_bisr_inst(
      .CLK(bisr_clk_pd_vinf), .RSTB(bisr_reset_pd_vinf), .SI(ram_row_41_col_0_bisr_inst_SO), 
      .SO(ram_row_42_col_0_bisr_inst_SO), .SE(bisr_shift_en_pd_vinf), .D({
      All_SCOL0_FUSE_REG_ts36[5:0], All_SCOL0_ALLOC_REG_ts36}), .MSO(1'b0), .MSEL(1'b0), 
      .Q(ram_row_42_col_0_bisr_inst_Q)
  );

  hlp_sched_apr_rtl_tessent_mbisr_register_ip783rfhs2r2w256x34s0c1p1d0_dft_wrp ram_row_43_col_0_bisr_inst(
      .CLK(bisr_clk_pd_vinf), .RSTB(bisr_reset_pd_vinf), .SI(ram_row_42_col_0_bisr_inst_SO), 
      .SO(ram_row_43_col_0_bisr_inst_SO), .SE(bisr_shift_en_pd_vinf), .D({
      All_SCOL0_FUSE_REG_ts37[5:0], All_SCOL0_ALLOC_REG_ts37}), .MSO(1'b0), .MSEL(1'b0), 
      .Q(ram_row_43_col_0_bisr_inst_Q)
  );

  hlp_sched_apr_rtl_tessent_mbisr_register_ip783rfhs2r2w256x34s0c1p1d0_dft_wrp ram_row_44_col_0_bisr_inst(
      .CLK(bisr_clk_pd_vinf), .RSTB(bisr_reset_pd_vinf), .SI(ram_row_43_col_0_bisr_inst_SO), 
      .SO(ram_row_44_col_0_bisr_inst_SO), .SE(bisr_shift_en_pd_vinf), .D({
      All_SCOL0_FUSE_REG_ts38[5:0], All_SCOL0_ALLOC_REG_ts38}), .MSO(1'b0), .MSEL(1'b0), 
      .Q(ram_row_44_col_0_bisr_inst_Q)
  );

  hlp_sched_apr_rtl_tessent_mbisr_register_ip783rfhs2r2w256x34s0c1p1d0_dft_wrp ram_row_45_col_0_bisr_inst(
      .CLK(bisr_clk_pd_vinf), .RSTB(bisr_reset_pd_vinf), .SI(ram_row_44_col_0_bisr_inst_SO), 
      .SO(ram_row_45_col_0_bisr_inst_SO), .SE(bisr_shift_en_pd_vinf), .D({
      All_SCOL0_FUSE_REG_ts39[5:0], All_SCOL0_ALLOC_REG_ts39}), .MSO(1'b0), .MSEL(1'b0), 
      .Q(ram_row_45_col_0_bisr_inst_Q)
  );

  hlp_sched_apr_rtl_tessent_mbisr_register_ip783rfhs2r2w256x34s0c1p1d0_dft_wrp ram_row_46_col_0_bisr_inst(
      .CLK(bisr_clk_pd_vinf), .RSTB(bisr_reset_pd_vinf), .SI(ram_row_45_col_0_bisr_inst_SO), 
      .SO(ram_row_46_col_0_bisr_inst_SO), .SE(bisr_shift_en_pd_vinf), .D({
      All_SCOL0_FUSE_REG_ts40[5:0], All_SCOL0_ALLOC_REG_ts40}), .MSO(1'b0), .MSEL(1'b0), 
      .Q(ram_row_46_col_0_bisr_inst_Q)
  );

  hlp_sched_apr_rtl_tessent_mbisr_register_ip783rfhs2r2w256x34s0c1p1d0_dft_wrp ram_row_47_col_0_bisr_inst(
      .CLK(bisr_clk_pd_vinf), .RSTB(bisr_reset_pd_vinf), .SI(ram_row_46_col_0_bisr_inst_SO), 
      .SO(ram_row_47_col_0_bisr_inst_SO), .SE(bisr_shift_en_pd_vinf), .D({
      All_SCOL0_FUSE_REG_ts41[5:0], All_SCOL0_ALLOC_REG_ts41}), .MSO(1'b0), .MSEL(1'b0), 
      .Q(ram_row_47_col_0_bisr_inst_Q)
  );

  hlp_sched_apr_rtl_tessent_mbisr_register_ip783rfhs2r2w256x34s0c1p1d0_dft_wrp ram_row_48_col_0_bisr_inst(
      .CLK(bisr_clk_pd_vinf), .RSTB(bisr_reset_pd_vinf), .SI(ram_row_47_col_0_bisr_inst_SO), 
      .SO(ram_row_48_col_0_bisr_inst_SO), .SE(bisr_shift_en_pd_vinf), .D({
      All_SCOL0_FUSE_REG_ts42[5:0], All_SCOL0_ALLOC_REG_ts42}), .MSO(1'b0), .MSEL(1'b0), 
      .Q(ram_row_48_col_0_bisr_inst_Q)
  );

  hlp_sched_apr_rtl_tessent_mbisr_register_ip783rfhs2r2w256x34s0c1p1d0_dft_wrp ram_row_49_col_0_bisr_inst(
      .CLK(bisr_clk_pd_vinf), .RSTB(bisr_reset_pd_vinf), .SI(ram_row_48_col_0_bisr_inst_SO), 
      .SO(ram_row_49_col_0_bisr_inst_SO), .SE(bisr_shift_en_pd_vinf), .D({
      All_SCOL0_FUSE_REG_ts43[5:0], All_SCOL0_ALLOC_REG_ts43}), .MSO(1'b0), .MSEL(1'b0), 
      .Q(ram_row_49_col_0_bisr_inst_Q)
  );

  hlp_sched_apr_rtl_tessent_mbisr_register_ip783rfhs2r2w256x34s0c1p1d0_dft_wrp ram_row_4_col_0_bisr_inst(
      .CLK(bisr_clk_pd_vinf), .RSTB(bisr_reset_pd_vinf), .SI(ram_row_49_col_0_bisr_inst_SO), 
      .SO(ram_row_4_col_0_bisr_inst_SO), .SE(bisr_shift_en_pd_vinf), .D({
      All_SCOL0_FUSE_REG_ts44[5:0], All_SCOL0_ALLOC_REG_ts44}), .MSO(1'b0), .MSEL(1'b0), 
      .Q(ram_row_4_col_0_bisr_inst_Q)
  );

  hlp_sched_apr_rtl_tessent_mbisr_register_ip783rfhs2r2w256x34s0c1p1d0_dft_wrp ram_row_50_col_0_bisr_inst(
      .CLK(bisr_clk_pd_vinf), .RSTB(bisr_reset_pd_vinf), .SI(ram_row_4_col_0_bisr_inst_SO), 
      .SO(ram_row_50_col_0_bisr_inst_SO), .SE(bisr_shift_en_pd_vinf), .D({
      All_SCOL0_FUSE_REG_ts45[5:0], All_SCOL0_ALLOC_REG_ts45}), .MSO(1'b0), .MSEL(1'b0), 
      .Q(ram_row_50_col_0_bisr_inst_Q)
  );

  hlp_sched_apr_rtl_tessent_mbisr_register_ip783rfhs2r2w256x34s0c1p1d0_dft_wrp ram_row_51_col_0_bisr_inst(
      .CLK(bisr_clk_pd_vinf), .RSTB(bisr_reset_pd_vinf), .SI(ram_row_50_col_0_bisr_inst_SO), 
      .SO(ram_row_51_col_0_bisr_inst_SO), .SE(bisr_shift_en_pd_vinf), .D({
      All_SCOL0_FUSE_REG_ts46[5:0], All_SCOL0_ALLOC_REG_ts46}), .MSO(1'b0), .MSEL(1'b0), 
      .Q(ram_row_51_col_0_bisr_inst_Q)
  );

  hlp_sched_apr_rtl_tessent_mbisr_register_ip783rfhs2r2w256x34s0c1p1d0_dft_wrp ram_row_52_col_0_bisr_inst(
      .CLK(bisr_clk_pd_vinf), .RSTB(bisr_reset_pd_vinf), .SI(ram_row_51_col_0_bisr_inst_SO), 
      .SO(ram_row_52_col_0_bisr_inst_SO), .SE(bisr_shift_en_pd_vinf), .D({
      All_SCOL0_FUSE_REG_ts47[5:0], All_SCOL0_ALLOC_REG_ts47}), .MSO(1'b0), .MSEL(1'b0), 
      .Q(ram_row_52_col_0_bisr_inst_Q)
  );

  hlp_sched_apr_rtl_tessent_mbisr_register_ip783rfhs2r2w256x34s0c1p1d0_dft_wrp ram_row_53_col_0_bisr_inst(
      .CLK(bisr_clk_pd_vinf), .RSTB(bisr_reset_pd_vinf), .SI(ram_row_52_col_0_bisr_inst_SO), 
      .SO(ram_row_53_col_0_bisr_inst_SO), .SE(bisr_shift_en_pd_vinf), .D({
      All_SCOL0_FUSE_REG_ts48[5:0], All_SCOL0_ALLOC_REG_ts48}), .MSO(1'b0), .MSEL(1'b0), 
      .Q(ram_row_53_col_0_bisr_inst_Q)
  );

  hlp_sched_apr_rtl_tessent_mbisr_register_ip783rfhs2r2w256x34s0c1p1d0_dft_wrp ram_row_54_col_0_bisr_inst(
      .CLK(bisr_clk_pd_vinf), .RSTB(bisr_reset_pd_vinf), .SI(ram_row_53_col_0_bisr_inst_SO), 
      .SO(ram_row_54_col_0_bisr_inst_SO), .SE(bisr_shift_en_pd_vinf), .D({
      All_SCOL0_FUSE_REG_ts49[5:0], All_SCOL0_ALLOC_REG_ts49}), .MSO(1'b0), .MSEL(1'b0), 
      .Q(ram_row_54_col_0_bisr_inst_Q)
  );

  hlp_sched_apr_rtl_tessent_mbisr_register_ip783rfhs2r2w256x34s0c1p1d0_dft_wrp ram_row_55_col_0_bisr_inst(
      .CLK(bisr_clk_pd_vinf), .RSTB(bisr_reset_pd_vinf), .SI(ram_row_54_col_0_bisr_inst_SO), 
      .SO(ram_row_55_col_0_bisr_inst_SO), .SE(bisr_shift_en_pd_vinf), .D({
      All_SCOL0_FUSE_REG_ts50[5:0], All_SCOL0_ALLOC_REG_ts50}), .MSO(1'b0), .MSEL(1'b0), 
      .Q(ram_row_55_col_0_bisr_inst_Q)
  );

  hlp_sched_apr_rtl_tessent_mbisr_register_ip783rfhs2r2w256x34s0c1p1d0_dft_wrp ram_row_56_col_0_bisr_inst(
      .CLK(bisr_clk_pd_vinf), .RSTB(bisr_reset_pd_vinf), .SI(ram_row_55_col_0_bisr_inst_SO), 
      .SO(ram_row_56_col_0_bisr_inst_SO), .SE(bisr_shift_en_pd_vinf), .D({
      All_SCOL0_FUSE_REG_ts51[5:0], All_SCOL0_ALLOC_REG_ts51}), .MSO(1'b0), .MSEL(1'b0), 
      .Q(ram_row_56_col_0_bisr_inst_Q)
  );

  hlp_sched_apr_rtl_tessent_mbisr_register_ip783rfhs2r2w256x34s0c1p1d0_dft_wrp ram_row_57_col_0_bisr_inst(
      .CLK(bisr_clk_pd_vinf), .RSTB(bisr_reset_pd_vinf), .SI(ram_row_56_col_0_bisr_inst_SO), 
      .SO(ram_row_57_col_0_bisr_inst_SO), .SE(bisr_shift_en_pd_vinf), .D({
      All_SCOL0_FUSE_REG_ts52[5:0], All_SCOL0_ALLOC_REG_ts52}), .MSO(1'b0), .MSEL(1'b0), 
      .Q(ram_row_57_col_0_bisr_inst_Q)
  );

  hlp_sched_apr_rtl_tessent_mbisr_register_ip783rfhs2r2w256x34s0c1p1d0_dft_wrp ram_row_58_col_0_bisr_inst(
      .CLK(bisr_clk_pd_vinf), .RSTB(bisr_reset_pd_vinf), .SI(ram_row_57_col_0_bisr_inst_SO), 
      .SO(ram_row_58_col_0_bisr_inst_SO), .SE(bisr_shift_en_pd_vinf), .D({
      All_SCOL0_FUSE_REG_ts53[5:0], All_SCOL0_ALLOC_REG_ts53}), .MSO(1'b0), .MSEL(1'b0), 
      .Q(ram_row_58_col_0_bisr_inst_Q)
  );

  hlp_sched_apr_rtl_tessent_mbisr_register_ip783rfhs2r2w256x34s0c1p1d0_dft_wrp ram_row_59_col_0_bisr_inst(
      .CLK(bisr_clk_pd_vinf), .RSTB(bisr_reset_pd_vinf), .SI(ram_row_58_col_0_bisr_inst_SO), 
      .SO(ram_row_59_col_0_bisr_inst_SO), .SE(bisr_shift_en_pd_vinf), .D({
      All_SCOL0_FUSE_REG_ts54[5:0], All_SCOL0_ALLOC_REG_ts54}), .MSO(1'b0), .MSEL(1'b0), 
      .Q(ram_row_59_col_0_bisr_inst_Q)
  );

  hlp_sched_apr_rtl_tessent_mbisr_register_ip783rfhs2r2w256x34s0c1p1d0_dft_wrp ram_row_5_col_0_bisr_inst(
      .CLK(bisr_clk_pd_vinf), .RSTB(bisr_reset_pd_vinf), .SI(ram_row_59_col_0_bisr_inst_SO), 
      .SO(ram_row_5_col_0_bisr_inst_SO), .SE(bisr_shift_en_pd_vinf), .D({
      All_SCOL0_FUSE_REG_ts55[5:0], All_SCOL0_ALLOC_REG_ts55}), .MSO(1'b0), .MSEL(1'b0), 
      .Q(ram_row_5_col_0_bisr_inst_Q)
  );

  hlp_sched_apr_rtl_tessent_mbisr_register_ip783rfhs2r2w256x34s0c1p1d0_dft_wrp ram_row_60_col_0_bisr_inst(
      .CLK(bisr_clk_pd_vinf), .RSTB(bisr_reset_pd_vinf), .SI(ram_row_5_col_0_bisr_inst_SO), 
      .SO(ram_row_60_col_0_bisr_inst_SO), .SE(bisr_shift_en_pd_vinf), .D({
      All_SCOL0_FUSE_REG_ts56[5:0], All_SCOL0_ALLOC_REG_ts56}), .MSO(1'b0), .MSEL(1'b0), 
      .Q(ram_row_60_col_0_bisr_inst_Q)
  );

  hlp_sched_apr_rtl_tessent_mbisr_register_ip783rfhs2r2w256x34s0c1p1d0_dft_wrp ram_row_61_col_0_bisr_inst(
      .CLK(bisr_clk_pd_vinf), .RSTB(bisr_reset_pd_vinf), .SI(ram_row_60_col_0_bisr_inst_SO), 
      .SO(ram_row_61_col_0_bisr_inst_SO), .SE(bisr_shift_en_pd_vinf), .D({
      All_SCOL0_FUSE_REG_ts57[5:0], All_SCOL0_ALLOC_REG_ts57}), .MSO(1'b0), .MSEL(1'b0), 
      .Q(ram_row_61_col_0_bisr_inst_Q)
  );

  hlp_sched_apr_rtl_tessent_mbisr_register_ip783rfhs2r2w256x34s0c1p1d0_dft_wrp ram_row_62_col_0_bisr_inst(
      .CLK(bisr_clk_pd_vinf), .RSTB(bisr_reset_pd_vinf), .SI(ram_row_61_col_0_bisr_inst_SO), 
      .SO(ram_row_62_col_0_bisr_inst_SO), .SE(bisr_shift_en_pd_vinf), .D({
      All_SCOL0_FUSE_REG_ts58[5:0], All_SCOL0_ALLOC_REG_ts58}), .MSO(1'b0), .MSEL(1'b0), 
      .Q(ram_row_62_col_0_bisr_inst_Q)
  );

  hlp_sched_apr_rtl_tessent_mbisr_register_ip783rfhs2r2w256x34s0c1p1d0_dft_wrp ram_row_63_col_0_bisr_inst(
      .CLK(bisr_clk_pd_vinf), .RSTB(bisr_reset_pd_vinf), .SI(ram_row_62_col_0_bisr_inst_SO), 
      .SO(ram_row_63_col_0_bisr_inst_SO), .SE(bisr_shift_en_pd_vinf), .D({
      All_SCOL0_FUSE_REG_ts59[5:0], All_SCOL0_ALLOC_REG_ts59}), .MSO(1'b0), .MSEL(1'b0), 
      .Q(ram_row_63_col_0_bisr_inst_Q)
  );

  hlp_sched_apr_rtl_tessent_mbisr_register_ip783rfhs2r2w256x34s0c1p1d0_dft_wrp ram_row_6_col_0_bisr_inst(
      .CLK(bisr_clk_pd_vinf), .RSTB(bisr_reset_pd_vinf), .SI(ram_row_63_col_0_bisr_inst_SO), 
      .SO(ram_row_6_col_0_bisr_inst_SO), .SE(bisr_shift_en_pd_vinf), .D({
      All_SCOL0_FUSE_REG_ts60[5:0], All_SCOL0_ALLOC_REG_ts60}), .MSO(1'b0), .MSEL(1'b0), 
      .Q(ram_row_6_col_0_bisr_inst_Q)
  );

  hlp_sched_apr_rtl_tessent_mbisr_register_ip783rfhs2r2w256x34s0c1p1d0_dft_wrp ram_row_7_col_0_bisr_inst(
      .CLK(bisr_clk_pd_vinf), .RSTB(bisr_reset_pd_vinf), .SI(ram_row_6_col_0_bisr_inst_SO), 
      .SO(ram_row_7_col_0_bisr_inst_SO), .SE(bisr_shift_en_pd_vinf), .D({
      All_SCOL0_FUSE_REG_ts61[5:0], All_SCOL0_ALLOC_REG_ts61}), .MSO(1'b0), .MSEL(1'b0), 
      .Q(ram_row_7_col_0_bisr_inst_Q)
  );

  hlp_sched_apr_rtl_tessent_mbisr_register_ip783rfhs2r2w256x34s0c1p1d0_dft_wrp ram_row_8_col_0_bisr_inst(
      .CLK(bisr_clk_pd_vinf), .RSTB(bisr_reset_pd_vinf), .SI(ram_row_7_col_0_bisr_inst_SO), 
      .SO(ram_row_8_col_0_bisr_inst_SO), .SE(bisr_shift_en_pd_vinf), .D({
      All_SCOL0_FUSE_REG_ts62[5:0], All_SCOL0_ALLOC_REG_ts62}), .MSO(1'b0), .MSEL(1'b0), 
      .Q(ram_row_8_col_0_bisr_inst_Q)
  );

  hlp_sched_apr_rtl_tessent_mbisr_register_ip783rfhs2r2w256x34s0c1p1d0_dft_wrp ram_row_9_col_0_bisr_inst(
      .CLK(bisr_clk_pd_vinf), .RSTB(bisr_reset_pd_vinf), .SI(ram_row_8_col_0_bisr_inst_SO), 
      .SO(ram_row_9_col_0_bisr_inst_SO), .SE(bisr_shift_en_pd_vinf), .D({
      All_SCOL0_FUSE_REG_ts63[5:0], All_SCOL0_ALLOC_REG_ts63}), .MSO(1'b0), .MSEL(1'b0), 
      .Q(ram_row_9_col_0_bisr_inst_Q)
  );
endmodule
