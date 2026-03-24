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
//      Created by pallabpr with create_memories script version 25.01.005 on NA
//                                      & 
// Physical file /nfs/site/disks/zsc7.xne_cnic.nss.dftrtl.integ02/pallabpr/cxp_r16_mbist/flows/mgm/cxp/cxp_physical_params.csv
//
//////////////////////////////////////////////////////////////////////
`include        "cxp_wcm_mem.def"
module cxp_wcm_tcam_mems 
// Interface
(

// Module inputs

   input                                          dft_afd_reset_b                         ,   
   input                                          dft_array_freeze                        ,   
   input                                          dftmask                                 ,   
   input                                          dftshiften                              ,   
`ifdef CXP_FPGA_TCAM_MEMS
   input                                          fpga_fast_clk                           ,   
`endif
   input                                   [15:0] fuse_tcam                               ,   
   input                                          nss_core_clk                            ,   
   input                                          scon_cxp_powergood_nss_core_rst_n       ,   
   input    [`CXP_WCM_WCM_TCAM_TO_TCAM_WIDTH-1:0] wcm_wcm_tcam_to_tcam                    ,

// Module outputs

  output  [`CXP_WCM_WCM_TCAM_FROM_TCAM_WIDTH-1:0] wcm_wcm_tcam_from_tcam                        
   , input wire BIST_SETUP, input wire BIST_SETUP_ts1, 
   input wire BIST_SETUP_ts2, input wire to_interfaces_tck, 
   input wire mcp_bounding_to_en, input wire scan_to_en, 
   input wire memory_bypass_to_en, input wire GO_ID_REG_SEL, 
   input wire BIST_CLEAR_BIRA, input wire BIST_COLLAR_DIAG_EN, 
   input wire BIST_COLLAR_BIRA_EN, input wire BIST_SHIFT_BIRA_COLLAR, 
   input wire CHECK_REPAIR_NEEDED, input wire MEM0_BIST_COLLAR_SI, 
   input wire MEM1_BIST_COLLAR_SI, input wire MEM2_BIST_COLLAR_SI, 
   input wire MEM3_BIST_COLLAR_SI, input wire MEM4_BIST_COLLAR_SI, 
   input wire MEM5_BIST_COLLAR_SI, input wire MEM6_BIST_COLLAR_SI, 
   input wire MEM7_BIST_COLLAR_SI, input wire MEM8_BIST_COLLAR_SI, 
   input wire MEM9_BIST_COLLAR_SI, input wire MEM10_BIST_COLLAR_SI, 
   input wire MEM11_BIST_COLLAR_SI, input wire MEM12_BIST_COLLAR_SI, 
   input wire MEM13_BIST_COLLAR_SI, input wire MEM14_BIST_COLLAR_SI, 
   input wire MEM15_BIST_COLLAR_SI, output wire BIST_SO, 
   output wire BIST_SO_ts1, output wire BIST_SO_ts2, output wire BIST_SO_ts3, 
   output wire BIST_SO_ts4, output wire BIST_SO_ts5, output wire BIST_SO_ts6, 
   output wire BIST_SO_ts7, output wire BIST_SO_ts8, output wire BIST_SO_ts9, 
   output wire BIST_SO_ts10, output wire BIST_SO_ts11, 
   output wire BIST_SO_ts12, output wire BIST_SO_ts13, 
   output wire BIST_SO_ts14, output wire BIST_SO_ts15, output wire BIST_GO, 
   output wire BIST_GO_ts1, output wire BIST_GO_ts2, output wire BIST_GO_ts3, 
   output wire BIST_GO_ts4, output wire BIST_GO_ts5, output wire BIST_GO_ts6, 
   output wire BIST_GO_ts7, output wire BIST_GO_ts8, output wire BIST_GO_ts9, 
   output wire BIST_GO_ts10, output wire BIST_GO_ts11, 
   output wire BIST_GO_ts12, output wire BIST_GO_ts13, 
   output wire BIST_GO_ts14, output wire BIST_GO_ts15, input wire ltest_to_en, 
   input wire BIST_USER9, input wire BIST_USER10, input wire BIST_USER11, 
   input wire BIST_USER0, input wire BIST_USER1, input wire BIST_USER2, 
   input wire BIST_USER3, input wire BIST_USER4, input wire BIST_USER5, 
   input wire BIST_USER6, input wire BIST_USER7, input wire BIST_USER8, 
   input wire BIST_EVEN_GROUPWRITEENABLE, input wire BIST_ODD_GROUPWRITEENABLE, 
   input wire BIST_WRITEENABLE, input wire BIST_READENABLE, 
   input wire BIST_SELECT, input wire BIST_CMP, 
   input wire INCLUDE_MEM_RESULTS_REG, input wire [0:0] BIST_COL_ADD, 
   input wire [5:0] BIST_ROW_ADD, input wire BIST_COLLAR_EN0, 
   input wire BIST_COLLAR_EN1, input wire BIST_COLLAR_EN2, 
   input wire BIST_COLLAR_EN3, input wire BIST_COLLAR_EN4, 
   input wire BIST_COLLAR_EN5, input wire BIST_COLLAR_EN6, 
   input wire BIST_COLLAR_EN7, input wire BIST_COLLAR_EN8, 
   input wire BIST_COLLAR_EN9, input wire BIST_COLLAR_EN10, 
   input wire BIST_COLLAR_EN11, input wire BIST_COLLAR_EN12, 
   input wire BIST_COLLAR_EN13, input wire BIST_COLLAR_EN14, 
   input wire BIST_COLLAR_EN15, input wire BIST_RUN_TO_COLLAR0, 
   input wire BIST_RUN_TO_COLLAR1, input wire BIST_RUN_TO_COLLAR2, 
   input wire BIST_RUN_TO_COLLAR3, input wire BIST_RUN_TO_COLLAR4, 
   input wire BIST_RUN_TO_COLLAR5, input wire BIST_RUN_TO_COLLAR6, 
   input wire BIST_RUN_TO_COLLAR7, input wire BIST_RUN_TO_COLLAR8, 
   input wire BIST_RUN_TO_COLLAR9, input wire BIST_RUN_TO_COLLAR10, 
   input wire BIST_RUN_TO_COLLAR11, input wire BIST_RUN_TO_COLLAR12, 
   input wire BIST_RUN_TO_COLLAR13, input wire BIST_RUN_TO_COLLAR14, 
   input wire BIST_RUN_TO_COLLAR15, input wire BIST_ASYNC_RESET, 
   input wire BIST_TESTDATA_SELECT_TO_COLLAR, input wire BIST_ON_TO_COLLAR, 
   input wire [31:0] BIST_WRITE_DATA, input wire [31:0] BIST_EXPECT_DATA, 
   input wire BIST_SHIFT_COLLAR, input wire BIST_COLLAR_SETUP, 
   input wire BIST_CLEAR_DEFAULT, input wire BIST_CLEAR, 
   input wire [1:0] BIST_COLLAR_OPSET_SELECT, input wire BIST_COLLAR_HOLD, 
   input wire FREEZE_STOP_ERROR, input wire ERROR_CNT_ZERO, 
   input wire MBISTPG_RESET_REG_SETUP2, input wire [0:0] BIST_BANK_ADD, 
   input wire bisr_shift_en_pd_vinf, input wire bisr_clk_pd_vinf, 
   input wire bisr_reset_pd_vinf, input wire ram_row_0_col_6_bisr_inst_SO, 
   output wire tcam_row_0_col_9_bisr_inst_SO, input wire fscan_clkungate);

genvar iter;


// Instances

cxp_wcm_wrap_tcam_wcm_tcam_shell_128x512  #( // Parameters
    .TOTAL_MEMORY_INSTANCE(16),
    .TCAM_RULES_NUM(128),
    .TCAM_E1_INIT_VALUE(512'h0),
    .BCAM_N7(0),
    .BCAM_RELIEF(0),
    .TCAM_PATRN1_EXP_RESET_VALUE(0),
    .TCAM_PATRN0_EXP_RESET_VALUE(0),
    .TSMC_N7(1),
    .TO_TCAM_WIDTH(`CXP_WCM_WCM_TCAM_TO_TCAM_WIDTH),
    .WRAPPER_COL_REPAIR(1),
    .TCAM_INIT_TYPE(1),
    .FPGA_MARGIN(0),
    .TCAM_WIDTH(512),
    .FROM_TCAM_WIDTH(`CXP_WCM_WCM_TCAM_FROM_TCAM_WIDTH),
    .TCAM_SLICE_SIZE(64),
    .TCAM_E0_INIT_VALUE(512'h0),
    .TCAM_PROTECTION_TYPE(1),
    .NFUSERED_TCAM(6),
    .FPGA_CLOCKS_RATIO(100)
) wcm_wrap_tcam_wcm_tcam_shell_128x512(
        .clk(nss_core_clk),
        .car_raw_lan_power_good(scon_cxp_powergood_nss_core_rst_n),
`ifdef CXP_FPGA_TCAM_MEMS
        .fpga_fast_clk(fpga_fast_clk),
`endif
        .wrap_shell_to_tcam(wcm_wcm_tcam_to_tcam),
        .wrap_shell_from_tcam(wcm_wcm_tcam_from_tcam),
        .fuse_tcam(fuse_tcam),
        .dftshiften(dftshiften),
        .dftmask(dftmask),
        .dft_array_freeze(dft_array_freeze),
        .dft_afd_reset_b(dft_afd_reset_b), .BIST_SETUP(BIST_SETUP), 
                                       .BIST_SETUP_ts1(BIST_SETUP_ts1), 
                                       .BIST_SETUP_ts2(BIST_SETUP_ts2), 
                                       .to_interfaces_tck(to_interfaces_tck), 
                                       .mcp_bounding_to_en(mcp_bounding_to_en), 
                                       .scan_to_en(scan_to_en), 
                                       .memory_bypass_to_en(memory_bypass_to_en), 
                                       .GO_ID_REG_SEL(GO_ID_REG_SEL), 
                                       .BIST_CLEAR_BIRA(BIST_CLEAR_BIRA), 
                                       .BIST_COLLAR_DIAG_EN(BIST_COLLAR_DIAG_EN), 
                                       .BIST_COLLAR_BIRA_EN(BIST_COLLAR_BIRA_EN), 
                                       .BIST_SHIFT_BIRA_COLLAR(BIST_SHIFT_BIRA_COLLAR), 
                                       .CHECK_REPAIR_NEEDED(CHECK_REPAIR_NEEDED), 
                                       .MEM0_BIST_COLLAR_SI(MEM0_BIST_COLLAR_SI), 
                                       .MEM1_BIST_COLLAR_SI(MEM1_BIST_COLLAR_SI), 
                                       .MEM2_BIST_COLLAR_SI(MEM2_BIST_COLLAR_SI), 
                                       .MEM3_BIST_COLLAR_SI(MEM3_BIST_COLLAR_SI), 
                                       .MEM4_BIST_COLLAR_SI(MEM4_BIST_COLLAR_SI), 
                                       .MEM5_BIST_COLLAR_SI(MEM5_BIST_COLLAR_SI), 
                                       .MEM6_BIST_COLLAR_SI(MEM6_BIST_COLLAR_SI), 
                                       .MEM7_BIST_COLLAR_SI(MEM7_BIST_COLLAR_SI), 
                                       .MEM8_BIST_COLLAR_SI(MEM8_BIST_COLLAR_SI), 
                                       .MEM9_BIST_COLLAR_SI(MEM9_BIST_COLLAR_SI), 
                                       .MEM10_BIST_COLLAR_SI(MEM10_BIST_COLLAR_SI), 
                                       .MEM11_BIST_COLLAR_SI(MEM11_BIST_COLLAR_SI), 
                                       .MEM12_BIST_COLLAR_SI(MEM12_BIST_COLLAR_SI), 
                                       .MEM13_BIST_COLLAR_SI(MEM13_BIST_COLLAR_SI), 
                                       .MEM14_BIST_COLLAR_SI(MEM14_BIST_COLLAR_SI), 
                                       .MEM15_BIST_COLLAR_SI(MEM15_BIST_COLLAR_SI), 
                                       .BIST_SO(BIST_SO), .BIST_SO_ts1(BIST_SO_ts1), 
                                       .BIST_SO_ts2(BIST_SO_ts2), 
                                       .BIST_SO_ts3(BIST_SO_ts3), 
                                       .BIST_SO_ts4(BIST_SO_ts4), 
                                       .BIST_SO_ts5(BIST_SO_ts5), 
                                       .BIST_SO_ts6(BIST_SO_ts6), 
                                       .BIST_SO_ts7(BIST_SO_ts7), 
                                       .BIST_SO_ts8(BIST_SO_ts8), 
                                       .BIST_SO_ts9(BIST_SO_ts9), 
                                       .BIST_SO_ts10(BIST_SO_ts10), 
                                       .BIST_SO_ts11(BIST_SO_ts11), 
                                       .BIST_SO_ts12(BIST_SO_ts12), 
                                       .BIST_SO_ts13(BIST_SO_ts13), 
                                       .BIST_SO_ts14(BIST_SO_ts14), 
                                       .BIST_SO_ts15(BIST_SO_ts15), .BIST_GO(BIST_GO), 
                                       .BIST_GO_ts1(BIST_GO_ts1), 
                                       .BIST_GO_ts2(BIST_GO_ts2), 
                                       .BIST_GO_ts3(BIST_GO_ts3), 
                                       .BIST_GO_ts4(BIST_GO_ts4), 
                                       .BIST_GO_ts5(BIST_GO_ts5), 
                                       .BIST_GO_ts6(BIST_GO_ts6), 
                                       .BIST_GO_ts7(BIST_GO_ts7), 
                                       .BIST_GO_ts8(BIST_GO_ts8), 
                                       .BIST_GO_ts9(BIST_GO_ts9), 
                                       .BIST_GO_ts10(BIST_GO_ts10), 
                                       .BIST_GO_ts11(BIST_GO_ts11), 
                                       .BIST_GO_ts12(BIST_GO_ts12), 
                                       .BIST_GO_ts13(BIST_GO_ts13), 
                                       .BIST_GO_ts14(BIST_GO_ts14), 
                                       .BIST_GO_ts15(BIST_GO_ts15), 
                                       .ltest_to_en(ltest_to_en), .BIST_USER9(BIST_USER9), 
                                       .BIST_USER10(BIST_USER10), 
                                       .BIST_USER11(BIST_USER11), .BIST_USER0(BIST_USER0), 
                                       .BIST_USER1(BIST_USER1), .BIST_USER2(BIST_USER2), 
                                       .BIST_USER3(BIST_USER3), .BIST_USER4(BIST_USER4), 
                                       .BIST_USER5(BIST_USER5), .BIST_USER6(BIST_USER6), 
                                       .BIST_USER7(BIST_USER7), .BIST_USER8(BIST_USER8), 
                                       .BIST_EVEN_GROUPWRITEENABLE(BIST_EVEN_GROUPWRITEENABLE), 
                                       .BIST_ODD_GROUPWRITEENABLE(BIST_ODD_GROUPWRITEENABLE), 
                                       .BIST_WRITEENABLE(BIST_WRITEENABLE), 
                                       .BIST_READENABLE(BIST_READENABLE), 
                                       .BIST_SELECT(BIST_SELECT), .BIST_CMP(BIST_CMP), 
                                       .INCLUDE_MEM_RESULTS_REG(INCLUDE_MEM_RESULTS_REG), 
                                       .BIST_COL_ADD(BIST_COL_ADD), 
                                       .BIST_ROW_ADD(BIST_ROW_ADD[5:0]), 
                                       .BIST_COLLAR_EN0(BIST_COLLAR_EN0), 
                                       .BIST_COLLAR_EN1(BIST_COLLAR_EN1), 
                                       .BIST_COLLAR_EN2(BIST_COLLAR_EN2), 
                                       .BIST_COLLAR_EN3(BIST_COLLAR_EN3), 
                                       .BIST_COLLAR_EN4(BIST_COLLAR_EN4), 
                                       .BIST_COLLAR_EN5(BIST_COLLAR_EN5), 
                                       .BIST_COLLAR_EN6(BIST_COLLAR_EN6), 
                                       .BIST_COLLAR_EN7(BIST_COLLAR_EN7), 
                                       .BIST_COLLAR_EN8(BIST_COLLAR_EN8), 
                                       .BIST_COLLAR_EN9(BIST_COLLAR_EN9), 
                                       .BIST_COLLAR_EN10(BIST_COLLAR_EN10), 
                                       .BIST_COLLAR_EN11(BIST_COLLAR_EN11), 
                                       .BIST_COLLAR_EN12(BIST_COLLAR_EN12), 
                                       .BIST_COLLAR_EN13(BIST_COLLAR_EN13), 
                                       .BIST_COLLAR_EN14(BIST_COLLAR_EN14), 
                                       .BIST_COLLAR_EN15(BIST_COLLAR_EN15), 
                                       .BIST_RUN_TO_COLLAR0(BIST_RUN_TO_COLLAR0), 
                                       .BIST_RUN_TO_COLLAR1(BIST_RUN_TO_COLLAR1), 
                                       .BIST_RUN_TO_COLLAR2(BIST_RUN_TO_COLLAR2), 
                                       .BIST_RUN_TO_COLLAR3(BIST_RUN_TO_COLLAR3), 
                                       .BIST_RUN_TO_COLLAR4(BIST_RUN_TO_COLLAR4), 
                                       .BIST_RUN_TO_COLLAR5(BIST_RUN_TO_COLLAR5), 
                                       .BIST_RUN_TO_COLLAR6(BIST_RUN_TO_COLLAR6), 
                                       .BIST_RUN_TO_COLLAR7(BIST_RUN_TO_COLLAR7), 
                                       .BIST_RUN_TO_COLLAR8(BIST_RUN_TO_COLLAR8), 
                                       .BIST_RUN_TO_COLLAR9(BIST_RUN_TO_COLLAR9), 
                                       .BIST_RUN_TO_COLLAR10(BIST_RUN_TO_COLLAR10), 
                                       .BIST_RUN_TO_COLLAR11(BIST_RUN_TO_COLLAR11), 
                                       .BIST_RUN_TO_COLLAR12(BIST_RUN_TO_COLLAR12), 
                                       .BIST_RUN_TO_COLLAR13(BIST_RUN_TO_COLLAR13), 
                                       .BIST_RUN_TO_COLLAR14(BIST_RUN_TO_COLLAR14), 
                                       .BIST_RUN_TO_COLLAR15(BIST_RUN_TO_COLLAR15), 
                                       .BIST_ASYNC_RESET(BIST_ASYNC_RESET), 
                                       .BIST_TESTDATA_SELECT_TO_COLLAR(BIST_TESTDATA_SELECT_TO_COLLAR), 
                                       .BIST_ON_TO_COLLAR(BIST_ON_TO_COLLAR), 
                                       .BIST_WRITE_DATA(BIST_WRITE_DATA[31:0]), 
                                       .BIST_EXPECT_DATA(BIST_EXPECT_DATA[31:0]), 
                                       .BIST_SHIFT_COLLAR(BIST_SHIFT_COLLAR), 
                                       .BIST_COLLAR_SETUP(BIST_COLLAR_SETUP), 
                                       .BIST_CLEAR_DEFAULT(BIST_CLEAR_DEFAULT), 
                                       .BIST_CLEAR(BIST_CLEAR), 
                                       .BIST_COLLAR_OPSET_SELECT(BIST_COLLAR_OPSET_SELECT[1:0]), 
                                       .BIST_COLLAR_HOLD(BIST_COLLAR_HOLD), 
                                       .FREEZE_STOP_ERROR(FREEZE_STOP_ERROR), 
                                       .ERROR_CNT_ZERO(ERROR_CNT_ZERO), 
                                       .MBISTPG_RESET_REG_SETUP2(MBISTPG_RESET_REG_SETUP2), 
                                       .BIST_BANK_ADD(BIST_BANK_ADD), 
                                       .bisr_shift_en_pd_vinf(bisr_shift_en_pd_vinf), 
                                       .bisr_clk_pd_vinf(bisr_clk_pd_vinf), 
                                       .bisr_reset_pd_vinf(bisr_reset_pd_vinf), 
                                       .ram_row_0_col_6_bisr_inst_SO(ram_row_0_col_6_bisr_inst_SO), 
                                       .tcam_row_0_col_9_bisr_inst_SO(tcam_row_0_col_9_bisr_inst_SO), 
                                       .fscan_clkungate(fscan_clkungate)
);


// BEGIN_BOTTOM_LOGIC


// END_BOTTOM_LOGIC


endmodule

