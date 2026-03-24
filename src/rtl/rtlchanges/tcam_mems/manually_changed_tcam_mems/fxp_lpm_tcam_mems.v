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
//
//------------------------------------------------------------------------------
//////////////////////////////////////////////////////////////////////
//
//                      Automated Memory Wrappers Creator
//
//      Created by pthotaku with create_memories script version 25.01.005 on NA
//                                      & 
// Physical file /nfs/site/disks/zsc7.xne_cnic.nss.dftrtl.integ01/pthotaku/fxp_r16_post_dft_May_22/flows/mgm/fxp/fxp_physical_params.csv
//
//////////////////////////////////////////////////////////////////////
`include        "fxp_lpm_mem.def"
module fxp_lpm_tcam_mems 
// Interface
(

// Module inputs

   input                                          dft_afd_reset_b                         ,   
   input                                          dft_array_freeze                        ,   
   input                                          dftmask                                 ,   
   input                                          dftshiften                              ,   
`ifdef FXP_FPGA_TCAM_MEMS
   input                                          fpga_fast_clk                           ,   
`endif
   input                                   [15:0] fuse_tcam                               ,   
   input [`FXP_FXP_LPM_FXP_LPM_ROOT_TCAM_TO_TCAM_WIDTH-1:0] fxp_lpm_fxp_lpm_root_tcam_to_tcam       ,   
   input                                          nss_fxp_clk                             ,   
   input                                          scon_fxp_powergood                      ,

// Module outputs

  output [`FXP_FXP_LPM_FXP_LPM_ROOT_TCAM_FROM_TCAM_WIDTH-1:0] fxp_lpm_fxp_lpm_root_tcam_from_tcam       
   , input wire BIST_SETUP, input wire mcp_bounding_to_en, 
   input wire scan_to_en, input wire memory_bypass_to_en, 
   input wire ltest_to_en, input wire BIST_USER9, input wire BIST_USER10, 
   input wire BIST_USER11, input wire BIST_USER0, input wire BIST_USER1, 
   input wire BIST_USER2, input wire BIST_USER3, input wire BIST_USER4, 
   input wire BIST_USER5, input wire BIST_USER6, input wire BIST_USER7, 
   input wire BIST_USER8, input wire BIST_EVEN_GROUPWRITEENABLE, 
   input wire BIST_ODD_GROUPWRITEENABLE, input wire BIST_WRITEENABLE, 
   input wire BIST_READENABLE, input wire BIST_SELECT, 
   input wire [0:0] BIST_COL_ADD, input wire [6:0] BIST_ROW_ADD, 
   input wire BIST_COLLAR_EN0, input wire BIST_COLLAR_EN1, 
   input wire BIST_COLLAR_EN2, input wire BIST_COLLAR_EN3, 
   input wire BIST_RUN_TO_COLLAR0, input wire BIST_RUN_TO_COLLAR1, 
   input wire BIST_RUN_TO_COLLAR2, input wire BIST_RUN_TO_COLLAR3, 
   input wire BIST_ASYNC_RESET, input wire BIST_TESTDATA_SELECT_TO_COLLAR, 
   input wire BIST_ON_TO_COLLAR, input wire [31:0] BIST_WRITE_DATA, 
   input wire BIST_SHIFT_COLLAR, input wire BIST_COLLAR_SETUP, 
   input wire BIST_CLEAR_DEFAULT, input wire BIST_CLEAR, 
   input wire BIST_COLLAR_HOLD, output wire [35:0] BIST_DATA_FROM_MEM, 
   output wire [35:0] BIST_DATA_FROM_MEM_ts1, 
   output wire [35:0] BIST_DATA_FROM_MEM_ts2, 
   output wire [35:0] BIST_DATA_FROM_MEM_ts3, 
   input wire MBISTPG_RESET_REG_SETUP2, input wire [1:0] BIST_BANK_ADD, 
   input wire bisr_shift_en_pd_vinf, input wire bisr_clk_pd_vinf, 
   input wire bisr_reset_pd_vinf, input wire ram_row_0_col_3_bisr_inst_SO, 
   output wire tcam_row_3_col_0_bisr_inst_SO, 
   input wire [6:0] MEM1_All_SCOL0_FUSE_REG, 
   input wire [6:0] MEM2_All_SCOL0_FUSE_REG, 
   input wire [6:0] MEM3_All_SCOL0_FUSE_REG, 
   input wire [6:0] MEM4_All_SCOL0_FUSE_REG, 
   output wire [6:0] tcam_row_0_col_0_bisr_inst_Q, 
   output wire [6:0] tcam_row_1_col_0_bisr_inst_Q, 
   output wire [6:0] tcam_row_2_col_0_bisr_inst_Q, 
   output wire [6:0] tcam_row_3_col_0_bisr_inst_Q, input wire fscan_clkungate);

genvar iter;


// Instances

fxp_lpm_wrap_tcam_fxp_lpm_root_tcam_shell_2048x33  #( // Parameters
    .FROM_TCAM_WIDTH(`FXP_FXP_LPM_FXP_LPM_ROOT_TCAM_FROM_TCAM_WIDTH),
    .TCAM_E0_INIT_VALUE(33'h0),
    .TCAM_PATRN1_EXP_RESET_VALUE(0),
    .FPGA_CLOCKS_RATIO(100),
    .BCAM_RELIEF(0),
    .TCAM_INIT_TYPE(1),
    .TCAM_PROTECTION_TYPE(1),
    .TCAM_E1_INIT_VALUE(33'h0),
    .TSMC_N7(1),
    .TOTAL_MEMORY_INSTANCE(4),
    .NFUSERED_TCAM(7),
    .TCAM_RULES_NUM(2048),
    .TCAM_SLICE_SIZE(64),
    .TO_TCAM_WIDTH(`FXP_FXP_LPM_FXP_LPM_ROOT_TCAM_TO_TCAM_WIDTH),
    .FPGA_MARGIN(0),
    .BCAM_N7(0),
    .WRAPPER_COL_REPAIR(1),
    .TCAM_PATRN0_EXP_RESET_VALUE(0),
    .TCAM_WIDTH(33)
) fxp_lpm_wrap_tcam_fxp_lpm_root_tcam_shell_2048x33(
        .clk(nss_fxp_clk),
        .car_raw_lan_power_good(scon_fxp_powergood),
`ifdef FXP_FPGA_TCAM_MEMS
        .fpga_fast_clk(fpga_fast_clk),
`endif
        .wrap_shell_to_tcam(fxp_lpm_fxp_lpm_root_tcam_to_tcam),
        .wrap_shell_from_tcam(fxp_lpm_fxp_lpm_root_tcam_from_tcam),
        .fuse_tcam(fuse_tcam),
        .dftshiften(dftshiften),
        .dftmask(dftmask),
        .dft_array_freeze(dft_array_freeze),
        .dft_afd_reset_b(dft_afd_reset_b), .BIST_SETUP(BIST_SETUP), 
                        .mcp_bounding_to_en(mcp_bounding_to_en), .scan_to_en(scan_to_en), 
                        .memory_bypass_to_en(memory_bypass_to_en), 
                        .ltest_to_en(ltest_to_en), .BIST_USER9(BIST_USER9), 
                        .BIST_USER10(BIST_USER10), .BIST_USER11(BIST_USER11), 
                        .BIST_USER0(BIST_USER0), .BIST_USER1(BIST_USER1), 
                        .BIST_USER2(BIST_USER2), .BIST_USER3(BIST_USER3), 
                        .BIST_USER4(BIST_USER4), .BIST_USER5(BIST_USER5), 
                        .BIST_USER6(BIST_USER6), .BIST_USER7(BIST_USER7), 
                        .BIST_USER8(BIST_USER8), .BIST_EVEN_GROUPWRITEENABLE(BIST_EVEN_GROUPWRITEENABLE), 
                        .BIST_ODD_GROUPWRITEENABLE(BIST_ODD_GROUPWRITEENABLE), 
                        .BIST_WRITEENABLE(BIST_WRITEENABLE), .BIST_READENABLE(BIST_READENABLE), 
                        .BIST_SELECT(BIST_SELECT), .BIST_COL_ADD(BIST_COL_ADD), 
                        .BIST_ROW_ADD(BIST_ROW_ADD[6:0]), .BIST_COLLAR_EN0(BIST_COLLAR_EN0), 
                        .BIST_COLLAR_EN1(BIST_COLLAR_EN1), .BIST_COLLAR_EN2(BIST_COLLAR_EN2), 
                        .BIST_COLLAR_EN3(BIST_COLLAR_EN3), 
                        .BIST_RUN_TO_COLLAR0(BIST_RUN_TO_COLLAR0), 
                        .BIST_RUN_TO_COLLAR1(BIST_RUN_TO_COLLAR1), 
                        .BIST_RUN_TO_COLLAR2(BIST_RUN_TO_COLLAR2), 
                        .BIST_RUN_TO_COLLAR3(BIST_RUN_TO_COLLAR3), 
                        .BIST_ASYNC_RESET(BIST_ASYNC_RESET), 
                        .BIST_TESTDATA_SELECT_TO_COLLAR(BIST_TESTDATA_SELECT_TO_COLLAR), 
                        .BIST_ON_TO_COLLAR(BIST_ON_TO_COLLAR), 
                        .BIST_WRITE_DATA(BIST_WRITE_DATA[31:0]), 
                        .BIST_SHIFT_COLLAR(BIST_SHIFT_COLLAR), 
                        .BIST_COLLAR_SETUP(BIST_COLLAR_SETUP), 
                        .BIST_CLEAR_DEFAULT(BIST_CLEAR_DEFAULT), .BIST_CLEAR(BIST_CLEAR), 
                        .BIST_COLLAR_HOLD(BIST_COLLAR_HOLD), 
                        .BIST_DATA_FROM_MEM(BIST_DATA_FROM_MEM[35:0]), 
                        .BIST_DATA_FROM_MEM_ts1(BIST_DATA_FROM_MEM_ts1[35:0]), 
                        .BIST_DATA_FROM_MEM_ts2(BIST_DATA_FROM_MEM_ts2[35:0]), 
                        .BIST_DATA_FROM_MEM_ts3(BIST_DATA_FROM_MEM_ts3[35:0]), 
                        .MBISTPG_RESET_REG_SETUP2(MBISTPG_RESET_REG_SETUP2), 
                        .BIST_BANK_ADD(BIST_BANK_ADD[1:0]), 
                        .bisr_shift_en_pd_vinf(bisr_shift_en_pd_vinf), 
                        .bisr_clk_pd_vinf(bisr_clk_pd_vinf), 
                        .bisr_reset_pd_vinf(bisr_reset_pd_vinf), 
                        .ram_row_0_col_3_bisr_inst_SO(ram_row_0_col_3_bisr_inst_SO), 
                        .tcam_row_3_col_0_bisr_inst_SO(tcam_row_3_col_0_bisr_inst_SO), 
                        .MEM1_All_SCOL0_FUSE_REG(MEM1_All_SCOL0_FUSE_REG[6:0]), 
                        .MEM2_All_SCOL0_FUSE_REG(MEM2_All_SCOL0_FUSE_REG[6:0]), 
                        .MEM3_All_SCOL0_FUSE_REG(MEM3_All_SCOL0_FUSE_REG[6:0]), 
                        .MEM4_All_SCOL0_FUSE_REG(MEM4_All_SCOL0_FUSE_REG[6:0]), 
                        .tcam_row_0_col_0_bisr_inst_Q(tcam_row_0_col_0_bisr_inst_Q[6:0]), 
                        .tcam_row_1_col_0_bisr_inst_Q(tcam_row_1_col_0_bisr_inst_Q[6:0]), 
                        .tcam_row_2_col_0_bisr_inst_Q(tcam_row_2_col_0_bisr_inst_Q[6:0]), 
                        .tcam_row_3_col_0_bisr_inst_Q(tcam_row_3_col_0_bisr_inst_Q[6:0]), 
                        .fscan_clkungate(fscan_clkungate)
);


// BEGIN_BOTTOM_LOGIC


// END_BOTTOM_LOGIC


endmodule

