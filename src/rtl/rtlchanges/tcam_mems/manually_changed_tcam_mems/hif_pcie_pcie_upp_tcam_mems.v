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
//      Created by mkeertha with create_memories script version 25.01.005 on NA
//                                      & 
// Physical file /nfs/site/disks/zsc7.xne_cnic.nss.dftrtl.integ02/mkeertha/HIF_CORE/repos/r16_post/flows/mgm/hif/hif_physical_params.csv
//
//////////////////////////////////////////////////////////////////////
`include        "hif_pcie_pcie_upp_mem.def"
module hif_pcie_pcie_upp_tcam_mems 
// Interface
(
    // Ports Manually added by DFT
    input		fscan_mode, 
    input		fscan_clock, 
    input		fscan_shiften, 
    input		fscan_ram_bypsel, 
    input   fscan_byprst_b,
    input   fscan_clkungate,
    input   fscan_rstbypen,


// Module inputs

   input                                          dft_afd_reset_b                         ,   
   input                                          dft_array_freeze                        ,   
   input                                          dftmask                                 ,   
   input                                          dftshiften                              ,   
`ifdef HIF_PCIE_FPGA_TCAM_MEMS
   input                                          fpga_fast_clk                           ,   
`endif
   input                                   [15:0] fuse_tcam                               ,   
   input                                          nss_hif_clk                             ,   
   input [`HIF_PCIE_PCIE_UPP_HIF_KEEPOUT_TCAM_TO_TCAM_WIDTH-1:0] pcie_upp_hif_keepout_tcam_to_tcam       ,   
   input                                          scon_hif_powergood                      ,

// Module outputs

  output [`HIF_PCIE_PCIE_UPP_HIF_KEEPOUT_TCAM_FROM_TCAM_WIDTH-1:0] pcie_upp_hif_keepout_tcam_from_tcam          
    , input wire fary_ijtag_tck, input wire fary_ijtag_rst_b, 
    input wire fary_ijtag_capture, input wire fary_ijtag_shift, 
    input wire fary_ijtag_update, input wire fary_ijtag_select, 
    input wire fary_ijtag_si, output wire aary_ijtag_so, 
    output wire hif_pcie_pcie_upp_tcam_mems_mbist_diag_done, 
    output wire bisr_so_pd_vinf, input wire bisr_si_pd_vinf, 
    input wire bisr_shift_en_pd_vinf, input wire bisr_clk_pd_vinf, 
    input wire bisr_reset_pd_vinf, input wire fary_trigger_post, 
    output wire aary_post_pass, output wire aary_post_busy, 
    output wire aary_post_complete, input wire fary_post_force_fail, 
    input logic [5:0] fary_post_algo_select, input wire core_rst_b);

genvar iter;


// Instances


  wire [2:0] BIST_SETUP;
  wire [6:0] BIST_ALGO_SEL;
  wire [0:0] toBist, bistEn;
  wire [5:0] BIST_ROW_ADD;
  wire [31:0] BIST_WRITE_DATA;
  wire [35:0] BIST_DATA_FROM_MEM, BIST_DATA_FROM_MEM_ts1;
  wire [5:0] MEM1_All_SCOL0_FUSE_REG, MEM2_All_SCOL0_FUSE_REG;
  wire hif_pcie_pcie_upp_tcam_mems_rtl_tessent_sib_mbist_inst_so, 
       hif_pcie_pcie_upp_tcam_mems_rtl_tessent_sib_sti_inst_so, 
       hif_pcie_pcie_upp_tcam_mems_rtl_tessent_sib_sri_ctrl_inst_so, 
       hif_pcie_pcie_upp_tcam_mems_rtl_tessent_tdr_sri_ctrl_inst_so, 
       hif_pcie_pcie_upp_tcam_mems_rtl_tessent_sib_sri_inst_to_select, 
       hif_pcie_pcie_upp_tcam_mems_rtl_tessent_sib_sti_inst_so_ts1, 
       hif_pcie_pcie_upp_tcam_mems_rtl_tessent_tdr_TCAM_c1_algo_select_tdr_inst_so, 
       hif_pcie_pcie_upp_tcam_mems_rtl_tessent_sib_sti_inst_to_select, 
       hif_pcie_pcie_upp_tcam_mems_rtl_tessent_sib_algo_select_sib_inst_so, 
       hif_pcie_pcie_upp_tcam_mems_rtl_tessent_sib_sri_ctrl_inst_to_select, 
       hif_pcie_pcie_upp_tcam_mems_rtl_tessent_sib_algo_select_sib_inst_to_select, 
       ijtag_to_tck, ijtag_to_ue, ijtag_to_reset, ijtag_to_se, ijtag_to_ce, 
       ijtag_to_sel, ltest_to_en, ltest_to_mem_bypass_en, ltest_to_scan_en, 
       ltest_to_mcp_bounding_en, BIRA_EN, PRESERVE_FUSE_REGISTER, 
       CHECK_REPAIR_NEEDED, BIST_HOLD, BIST_SELECT_TEST_DATA, 
       to_controllers_tck, to_controllers_tck_retime, mcp_bounding_to_en, 
       scan_to_en, memory_bypass_to_en, ltest_to_en_ts1, 
       BIST_SELECT_COMMON_ALGO, BIST_SELECT_COMMON_OPSET, BIST_OPSET_SEL, 
       BIST_DATA_INV_ROW_ADD_BIT_SELECT_EN, BIST_DATA_INV_ROW_ADD_BIT_SEL, 
       BIST_DATA_INV_COL_ADD_BIT_SEL, BIST_DATA_INV_COL_ADD_BIT_SELECT_EN, 
       BIST_ALGO_MODE0, BIST_ALGO_MODE1, ENABLE_MEM_RESET, 
       REDUCED_ADDRESS_COUNT, MEM_ARRAY_DUMP_MODE, BIST_DIAG_EN, 
       BIST_ASYNC_RESET, MBISTPG_SO, MBISTPG_DONE, MBISTPG_GO, 
       INCLUDE_MEM_RESULTS_REG, FL_CNT_MODE0, FL_CNT_MODE1, BIST_USER9, 
       BIST_USER10, BIST_USER11, BIST_USER0, BIST_USER1, BIST_USER2, BIST_USER3, 
       BIST_USER4, BIST_USER5, BIST_USER6, BIST_USER7, BIST_USER8, 
       BIST_EVEN_GROUPWRITEENABLE, BIST_ODD_GROUPWRITEENABLE, BIST_WRITEENABLE, 
       BIST_READENABLE, BIST_SELECT, BIST_COL_ADD, BIST_BANK_ADD, 
       BIST_COLLAR_EN0, BIST_COLLAR_EN1, BIST_RUN_TO_COLLAR0, 
       BIST_RUN_TO_COLLAR1, BIST_TESTDATA_SELECT_TO_COLLAR, BIST_ON_TO_COLLAR, 
       BIST_SHIFT_COLLAR, BIST_COLLAR_SETUP, BIST_CLEAR_DEFAULT, BIST_CLEAR, 
       BIST_COLLAR_HOLD, MBISTPG_RESET_REG_SETUP2, 
       hif_pcie_pcie_upp_tcam_mems_rtl_tessent_mbist_bap_inst_so, 
       nss_hif_clk_ts1, tck_select, MBISTPG_STABLE, ijtag_so, 
       bisr_so_pd_vinf_ts1, MEM1_All_SCOL0_ALLOC_REG, MEM2_All_SCOL0_ALLOC_REG, 
       trigger_post, trigger_array, mbistpg_select_common_algo_o, select_sram, 
       pass, sys_test_done_nss_hif_clk, sys_test_pass_nss_hif_clk, complete, 
       busy, sync_reset_nss_hif_clk_reset_bypass_mux_o, 
       Intel_reset_sync_polarity_nss_hif_clk_inverter_o1, 
       sync_reset_nss_hif_clk_o, sync_reset_nss_hif_clk_o_ts1;
  wire [6:0] tcam_row_0_col_0_bisr_inst_Q, tcam_row_0_col_1_bisr_inst_Q, 
             mbistpg_algo_sel_o, ALGO_SEL_REG;
hif_pcie_pcie_upp_wrap_tcam_hif_keepout_tcam_shell_128x72  #( // Parameters
    .WRAPPER_COL_REPAIR(1),
    .TCAM_E0_INIT_VALUE(72'h0),
    .TCAM_SLICE_SIZE(64),
    .NFUSERED_TCAM(7),
    .TCAM_PROTECTION_TYPE(1),
    .TCAM_PATRN0_EXP_RESET_VALUE(0),
    .TOTAL_MEMORY_INSTANCE(2),
    .TCAM_WIDTH(72),
    .TCAM_E1_INIT_VALUE(72'h0),
    .FPGA_MARGIN(0),
    .TO_TCAM_WIDTH(`HIF_PCIE_PCIE_UPP_HIF_KEEPOUT_TCAM_TO_TCAM_WIDTH),
    .BCAM_N7(0),
    .FROM_TCAM_WIDTH(`HIF_PCIE_PCIE_UPP_HIF_KEEPOUT_TCAM_FROM_TCAM_WIDTH),
    .FPGA_CLOCKS_RATIO(100),
    .TCAM_INIT_TYPE(1),
    .BCAM_RELIEF(0),
    .TCAM_RULES_NUM(128),
    .TSMC_N7(1),
    .TCAM_PATRN1_EXP_RESET_VALUE(0)
) pcie_upp_wrap_tcam_hif_keepout_tcam_shell_128x72(
        .clk(nss_hif_clk_ts1),
        .car_raw_lan_power_good(scon_hif_powergood),
`ifdef HIF_PCIE_FPGA_TCAM_MEMS
        .fpga_fast_clk(fpga_fast_clk),
`endif
        .wrap_shell_to_tcam(pcie_upp_hif_keepout_tcam_to_tcam),
        .wrap_shell_from_tcam(pcie_upp_hif_keepout_tcam_from_tcam),
        .fuse_tcam(fuse_tcam),
        .dftshiften(dftshiften),
        .dftmask(dftmask),
        .dft_array_freeze(dft_array_freeze),
        .dft_afd_reset_b(dft_afd_reset_b), .BIST_SETUP(BIST_SETUP[0]), 
                        .mcp_bounding_to_en(mcp_bounding_to_en), .scan_to_en(scan_to_en), 
                        .memory_bypass_to_en(memory_bypass_to_en), 
                        .ltest_to_en(ltest_to_en_ts1), .BIST_USER9(BIST_USER9), 
                        .BIST_USER10(BIST_USER10), .BIST_USER11(BIST_USER11), 
                        .BIST_USER0(BIST_USER0), .BIST_USER1(BIST_USER1), 
                        .BIST_USER2(BIST_USER2), .BIST_USER3(BIST_USER3), 
                        .BIST_USER4(BIST_USER4), .BIST_USER5(BIST_USER5), 
                        .BIST_USER6(BIST_USER6), .BIST_USER7(BIST_USER7), 
                        .BIST_USER8(BIST_USER8), .BIST_EVEN_GROUPWRITEENABLE(BIST_EVEN_GROUPWRITEENABLE), 
                        .BIST_ODD_GROUPWRITEENABLE(BIST_ODD_GROUPWRITEENABLE), 
                        .BIST_WRITEENABLE(BIST_WRITEENABLE), .BIST_READENABLE(BIST_READENABLE), 
                        .BIST_SELECT(BIST_SELECT), .BIST_COL_ADD(BIST_COL_ADD), 
                        .BIST_ROW_ADD(BIST_ROW_ADD[5:0]), .BIST_BANK_ADD(BIST_BANK_ADD), 
                        .BIST_COLLAR_EN0(BIST_COLLAR_EN0), .BIST_COLLAR_EN1(BIST_COLLAR_EN1), 
                        .BIST_RUN_TO_COLLAR0(BIST_RUN_TO_COLLAR0), 
                        .BIST_RUN_TO_COLLAR1(BIST_RUN_TO_COLLAR1), 
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
                        .MBISTPG_RESET_REG_SETUP2(MBISTPG_RESET_REG_SETUP2), 
                        .bisr_shift_en_pd_vinf(bisr_shift_en_pd_vinf), 
                        .bisr_clk_pd_vinf(bisr_clk_pd_vinf), 
                        .bisr_reset_pd_vinf(bisr_reset_pd_vinf), 
                        .bisr_si_pd_vinf(bisr_si_pd_vinf), 
                        .tcam_row_0_col_1_bisr_inst_SO(bisr_so_pd_vinf), 
                        .MEM1_All_SCOL0_FUSE_REG({
                        MEM1_All_SCOL0_FUSE_REG[5:0], 
                        MEM1_All_SCOL0_ALLOC_REG}), .MEM2_All_SCOL0_FUSE_REG({
                        MEM2_All_SCOL0_FUSE_REG[5:0], 
                        MEM2_All_SCOL0_ALLOC_REG}), 
                        .tcam_row_0_col_0_bisr_inst_Q(tcam_row_0_col_0_bisr_inst_Q[6:0]), 
                        .tcam_row_0_col_1_bisr_inst_Q(tcam_row_0_col_1_bisr_inst_Q[6:0]), 
                        .fscan_clkungate(fscan_clkungate)
);


// BEGIN_BOTTOM_LOGIC


// END_BOTTOM_LOGIC



  hif_pcie_pcie_upp_tcam_mems_rtl_tessent_sib_1 hif_pcie_pcie_upp_tcam_mems_rtl_tessent_sib_sti_inst(
      .ijtag_reset(fary_ijtag_rst_b), .ijtag_sel(fary_ijtag_select), .ijtag_si(fary_ijtag_si), 
      .ijtag_ce(fary_ijtag_capture), .ijtag_se(fary_ijtag_shift), .ijtag_ue(fary_ijtag_update), 
      .ijtag_tck(fary_ijtag_tck), .ijtag_so(hif_pcie_pcie_upp_tcam_mems_rtl_tessent_sib_sti_inst_so), 
      .ijtag_from_so(hif_pcie_pcie_upp_tcam_mems_rtl_tessent_sib_mbist_inst_so), 
      .ltest_si(1'b0), .ltest_scan_en(fscan_shiften), .ltest_en(fscan_mode), .ltest_clk(fscan_clock), 
      .ltest_mem_bypass_en(fscan_ram_bypsel), .ltest_mcp_bounding_en(1'b0), .ltest_async_set_reset_static_disable(fscan_byprst_b), 
      .ijtag_to_tck(ijtag_to_tck), .ijtag_to_reset(ijtag_to_reset), .ijtag_to_si(hif_pcie_pcie_upp_tcam_mems_rtl_tessent_sib_sti_inst_so_ts1), 
      .ijtag_to_ce(ijtag_to_ce), .ijtag_to_se(ijtag_to_se), .ijtag_to_ue(ijtag_to_ue), 
      .ltest_so(), .ltest_to_en(ltest_to_en), .ltest_to_mem_bypass_en(ltest_to_mem_bypass_en), 
      .ltest_to_mcp_bounding_en(ltest_to_mcp_bounding_en), .ltest_to_scan_en(ltest_to_scan_en), 
      .ijtag_to_sel(hif_pcie_pcie_upp_tcam_mems_rtl_tessent_sib_sti_inst_to_select)
  );

  hif_pcie_pcie_upp_tcam_mems_rtl_tessent_sib_2 hif_pcie_pcie_upp_tcam_mems_rtl_tessent_sib_sri_inst(
      .ijtag_reset(fary_ijtag_rst_b), .ijtag_sel(fary_ijtag_select), .ijtag_si(hif_pcie_pcie_upp_tcam_mems_rtl_tessent_sib_sti_inst_so), 
      .ijtag_ce(fary_ijtag_capture), .ijtag_se(fary_ijtag_shift), .ijtag_ue(fary_ijtag_update), 
      .ijtag_tck(fary_ijtag_tck), .ijtag_so(aary_ijtag_so), .ijtag_from_so(hif_pcie_pcie_upp_tcam_mems_rtl_tessent_sib_sri_ctrl_inst_so), 
      .ijtag_to_sel(hif_pcie_pcie_upp_tcam_mems_rtl_tessent_sib_sri_inst_to_select)
  );

  hif_pcie_pcie_upp_tcam_mems_rtl_tessent_sib_3 hif_pcie_pcie_upp_tcam_mems_rtl_tessent_sib_sri_ctrl_inst(
      .ijtag_reset(fary_ijtag_rst_b), .ijtag_sel(hif_pcie_pcie_upp_tcam_mems_rtl_tessent_sib_sri_inst_to_select), 
      .ijtag_si(hif_pcie_pcie_upp_tcam_mems_rtl_tessent_sib_sti_inst_so), .ijtag_ce(fary_ijtag_capture), 
      .ijtag_se(fary_ijtag_shift), .ijtag_ue(fary_ijtag_update), .ijtag_tck(fary_ijtag_tck), 
      .ijtag_so(hif_pcie_pcie_upp_tcam_mems_rtl_tessent_sib_sri_ctrl_inst_so), 
      .ijtag_from_so(hif_pcie_pcie_upp_tcam_mems_rtl_tessent_tdr_sri_ctrl_inst_so), 
      .ijtag_to_sel(hif_pcie_pcie_upp_tcam_mems_rtl_tessent_sib_sri_ctrl_inst_to_select)
  );

  hif_pcie_pcie_upp_tcam_mems_rtl_tessent_tdr_sri_ctrl hif_pcie_pcie_upp_tcam_mems_rtl_tessent_tdr_sri_ctrl_inst(
      .ijtag_reset(fary_ijtag_rst_b), .ijtag_sel(hif_pcie_pcie_upp_tcam_mems_rtl_tessent_sib_sri_ctrl_inst_to_select), 
      .ijtag_si(hif_pcie_pcie_upp_tcam_mems_rtl_tessent_sib_sti_inst_so), .ijtag_ce(fary_ijtag_capture), 
      .ijtag_se(fary_ijtag_shift), .ijtag_ue(fary_ijtag_update), .ijtag_tck(fary_ijtag_tck), 
      .tck_select(tck_select), .all_test(), .ijtag_so(hif_pcie_pcie_upp_tcam_mems_rtl_tessent_tdr_sri_ctrl_inst_so)
  );

  hif_pcie_pcie_upp_tcam_mems_rtl_tessent_sib_4 hif_pcie_pcie_upp_tcam_mems_rtl_tessent_sib_algo_select_sib_inst(
      .ijtag_reset(ijtag_to_reset), .ijtag_sel(hif_pcie_pcie_upp_tcam_mems_rtl_tessent_sib_sti_inst_to_select), 
      .ijtag_si(hif_pcie_pcie_upp_tcam_mems_rtl_tessent_sib_sti_inst_so_ts1), .ijtag_ce(ijtag_to_ce), 
      .ijtag_se(ijtag_to_se), .ijtag_ue(ijtag_to_ue), .ijtag_tck(ijtag_to_tck), 
      .ijtag_so(hif_pcie_pcie_upp_tcam_mems_rtl_tessent_sib_algo_select_sib_inst_so), 
      .ijtag_from_so(hif_pcie_pcie_upp_tcam_mems_rtl_tessent_tdr_TCAM_c1_algo_select_tdr_inst_so), 
      .ijtag_to_sel(hif_pcie_pcie_upp_tcam_mems_rtl_tessent_sib_algo_select_sib_inst_to_select)
  );

  hif_pcie_pcie_upp_tcam_mems_rtl_tessent_sib_4 hif_pcie_pcie_upp_tcam_mems_rtl_tessent_sib_mbist_inst(
      .ijtag_reset(ijtag_to_reset), .ijtag_sel(hif_pcie_pcie_upp_tcam_mems_rtl_tessent_sib_sti_inst_to_select), 
      .ijtag_si(hif_pcie_pcie_upp_tcam_mems_rtl_tessent_sib_algo_select_sib_inst_so), 
      .ijtag_ce(ijtag_to_ce), .ijtag_se(ijtag_to_se), .ijtag_ue(ijtag_to_ue), .ijtag_tck(ijtag_to_tck), 
      .ijtag_so(hif_pcie_pcie_upp_tcam_mems_rtl_tessent_sib_mbist_inst_so), .ijtag_from_so(ijtag_so), 
      .ijtag_to_sel(ijtag_to_sel)
  );

  hif_pcie_pcie_upp_tcam_mems_rtl_tessent_tdr_TCAM_c1_algo_select_tdr hif_pcie_pcie_upp_tcam_mems_rtl_tessent_tdr_TCAM_c1_algo_select_tdr_inst(
      .ijtag_reset(ijtag_to_reset), .ijtag_sel(hif_pcie_pcie_upp_tcam_mems_rtl_tessent_sib_algo_select_sib_inst_to_select), 
      .ijtag_si(hif_pcie_pcie_upp_tcam_mems_rtl_tessent_sib_sti_inst_so_ts1), .ijtag_ce(ijtag_to_ce), 
      .ijtag_se(ijtag_to_se), .ijtag_ue(ijtag_to_ue), .ijtag_tck(ijtag_to_tck), 
      .ALGO_SEL_REG(ALGO_SEL_REG), .ijtag_so(hif_pcie_pcie_upp_tcam_mems_rtl_tessent_tdr_TCAM_c1_algo_select_tdr_inst_so)
  );

  hif_pcie_pcie_upp_tcam_mems_rtl_tessent_mbist_bap hif_pcie_pcie_upp_tcam_mems_rtl_tessent_mbist_bap_inst(
      .reset(ijtag_to_reset), .ijtag_select(ijtag_to_sel), .si(hif_pcie_pcie_upp_tcam_mems_rtl_tessent_sib_algo_select_sib_inst_so), 
      .capture_en(ijtag_to_ce), .shift_en(ijtag_to_se), .shift_en_R(), .update_en(ijtag_to_ue), 
      .tck(ijtag_to_tck), .to_controllers_tck_retime(to_controllers_tck_retime), 
      .to_controllers_tck(to_controllers_tck), .mcp_bounding_en(ltest_to_mcp_bounding_en), 
      .mcp_bounding_to_en(mcp_bounding_to_en), .scan_en(ltest_to_scan_en), .scan_to_en(scan_to_en), 
      .memory_bypass_en(ltest_to_mem_bypass_en), .memory_bypass_to_en(memory_bypass_to_en), 
      .ltest_en(ltest_to_en), .ltest_to_en(ltest_to_en_ts1), .BIST_HOLD(BIST_HOLD), 
      .sys_ctrl_select(select_sram), .sys_algo_select(mbistpg_algo_sel_o[6:0]), 
      .sys_select_common_algo(mbistpg_select_common_algo_o), .sys_test_start_nss_hif_clk(trigger_post), 
      .sys_test_init_nss_hif_clk(1'b0), .sys_reset_nss_hif_clk(sync_reset_nss_hif_clk_o), 
      .sys_clock_nss_hif_clk(nss_hif_clk_ts1), .sys_test_pass_nss_hif_clk(sys_test_pass_nss_hif_clk), 
      .sys_test_done_nss_hif_clk(sys_test_done_nss_hif_clk), .sys_ctrl_pass(), 
      .sys_ctrl_done(), .ENABLE_MEM_RESET(ENABLE_MEM_RESET), .REDUCED_ADDRESS_COUNT(REDUCED_ADDRESS_COUNT), 
      .BIST_SELECT_TEST_DATA(BIST_SELECT_TEST_DATA), .BIST_ALGO_MODE0(BIST_ALGO_MODE0), 
      .BIST_ALGO_MODE1(BIST_ALGO_MODE1), .sys_incremental_test_mode(1'b0), .MEM_ARRAY_DUMP_MODE(MEM_ARRAY_DUMP_MODE), 
      .BIRA_EN(BIRA_EN), .BIST_DIAG_EN(BIST_DIAG_EN), .PRESERVE_FUSE_REGISTER(PRESERVE_FUSE_REGISTER), 
      .CHECK_REPAIR_NEEDED(CHECK_REPAIR_NEEDED), .BIST_ASYNC_RESET(BIST_ASYNC_RESET), 
      .FL_CNT_MODE0(FL_CNT_MODE0), .FL_CNT_MODE1(FL_CNT_MODE1), .INCLUDE_MEM_RESULTS_REG(INCLUDE_MEM_RESULTS_REG), 
      .BIST_SETUP(BIST_SETUP[2:0]), .BIST_ALGO_SEL(BIST_ALGO_SEL[6:0]), .BIST_SELECT_COMMON_ALGO(BIST_SELECT_COMMON_ALGO), 
      .BIST_OPSET_SEL(BIST_OPSET_SEL), .BIST_SELECT_COMMON_OPSET(BIST_SELECT_COMMON_OPSET), 
      .BIST_DATA_INV_COL_ADD_BIT_SEL(BIST_DATA_INV_COL_ADD_BIT_SEL), .BIST_DATA_INV_COL_ADD_BIT_SELECT_EN(BIST_DATA_INV_COL_ADD_BIT_SELECT_EN), 
      .BIST_DATA_INV_ROW_ADD_BIT_SEL(BIST_DATA_INV_ROW_ADD_BIT_SEL), .BIST_DATA_INV_ROW_ADD_BIT_SELECT_EN(BIST_DATA_INV_ROW_ADD_BIT_SELECT_EN), 
      .MBISTPG_GO(MBISTPG_GO), .MBISTPG_DONE(MBISTPG_DONE), .bistEn(bistEn), .toBist(toBist), 
      .fromBist(MBISTPG_SO), .so(hif_pcie_pcie_upp_tcam_mems_rtl_tessent_mbist_bap_inst_so), 
      .fscan_clkungate(fscan_clkungate)
  );

  hif_pcie_pcie_upp_tcam_mems_rtl_tessent_mbist_TCAM_c1_controller hif_pcie_pcie_upp_tcam_mems_rtl_tessent_mbist_TCAM_c1_controller_inst(
      .FROM_BISR_MEM1_All_SCOL0_FUSE_REG(tcam_row_0_col_0_bisr_inst_Q[6:1]), .FROM_BISR_MEM1_All_SCOL0_ALLOC_REG(tcam_row_0_col_0_bisr_inst_Q[0]), 
      .FROM_BISR_MEM2_All_SCOL0_FUSE_REG(tcam_row_0_col_1_bisr_inst_Q[6:1]), .FROM_BISR_MEM2_All_SCOL0_ALLOC_REG(tcam_row_0_col_1_bisr_inst_Q[0]), 
      .MBIST_RA_PRSRV_FUSE_VAL(PRESERVE_FUSE_REGISTER), .MBISTPG_ALGO_SEL(BIST_ALGO_SEL[6:0]), 
      .MBISTPG_SELECT_COMMON_ALGO(BIST_SELECT_COMMON_ALGO), .MBISTPG_OPSET_SELECT(BIST_OPSET_SEL), 
      .MBISTPG_SELECT_COMMON_OPSET(BIST_SELECT_COMMON_OPSET), .MBISTPG_DATA_INV_ROW_ADD_BIT_SELECT_EN(BIST_DATA_INV_ROW_ADD_BIT_SELECT_EN), 
      .MBISTPG_DATA_INV_ROW_ADD_BIT_SELECT(BIST_DATA_INV_ROW_ADD_BIT_SEL), .MBISTPG_DATA_INV_COL_ADD_BIT_SELECT_EN(BIST_DATA_INV_COL_ADD_BIT_SELECT_EN), 
      .MBISTPG_DATA_INV_COL_ADD_BIT_SELECT(BIST_DATA_INV_COL_ADD_BIT_SEL), .MBISTPG_ALGO_MODE({
      BIST_ALGO_MODE1, BIST_ALGO_MODE0}), .MBISTPG_MEM_RST(ENABLE_MEM_RESET), .MBISTPG_REDUCED_ADDR_CNT_EN(REDUCED_ADDRESS_COUNT), 
      .MEM_BYPASS_EN(memory_bypass_to_en), .MCP_BOUNDING_EN(mcp_bounding_to_en), 
      .FL_CNT_MODE({FL_CNT_MODE1, FL_CNT_MODE0}), .MBISTPG_BIRA_EN(BIRA_EN), .CHECK_REPAIR_NEEDED(CHECK_REPAIR_NEEDED), 
      .BIST_DATA_FROM_MEM0({BIST_DATA_FROM_MEM_ts1[35:0], 
      BIST_DATA_FROM_MEM[35:0]}), .MBISTPG_DIAG_EN(BIST_DIAG_EN), .BIST_CLK(nss_hif_clk_ts1), 
      .BIST_SI(toBist), .BIST_HOLD(BIST_HOLD), .BIST_SETUP2(BIST_SETUP[2]), .BIST_SETUP(BIST_SETUP[1:0]), 
      .MBISTPG_TESTDATA_SELECT(BIST_SELECT_TEST_DATA), .TCK(to_controllers_tck), 
      .TCK_RETIME(to_controllers_tck_retime), .MBISTPG_EN(bistEn), .MBISTPG_ASYNC_RESETN(BIST_ASYNC_RESET), 
      .LV_TM(ltest_to_en_ts1), .INCLUDE_MEM_RESULTS_REG(INCLUDE_MEM_RESULTS_REG), 
      .MBISTPG_MEM_ARRAY_DUMP_MODE(MEM_ARRAY_DUMP_MODE), .MEM1_All_SCOL0_FUSE_REG(MEM1_All_SCOL0_FUSE_REG[5:0]), 
      .MEM1_All_SCOL0_ALLOC_REG(MEM1_All_SCOL0_ALLOC_REG), .MEM1_REPAIR_STATUS(), 
      .MEM2_All_SCOL0_FUSE_REG(MEM2_All_SCOL0_FUSE_REG[5:0]), .MEM2_All_SCOL0_ALLOC_REG(MEM2_All_SCOL0_ALLOC_REG), 
      .MEM2_REPAIR_STATUS(), .MBISTPG_RESET_REG_SETUP2(MBISTPG_RESET_REG_SETUP2), 
      .BIST_COL_ADD(BIST_COL_ADD), .BIST_ROW_ADD(BIST_ROW_ADD[5:0]), .BIST_BANK_ADD(BIST_BANK_ADD), 
      .BIST_WRITE_DATA(BIST_WRITE_DATA[31:0]), .BIST_EXPECT_DATA(), .BIST_SHIFT_COLLAR(BIST_SHIFT_COLLAR), 
      .BIST_TESTDATA_SELECT_TO_COLLAR(BIST_TESTDATA_SELECT_TO_COLLAR), .BIST_COLLAR_SETUP(BIST_COLLAR_SETUP), 
      .BIST_COLLAR_HOLD(BIST_COLLAR_HOLD), .BIST_CLEAR_DEFAULT(BIST_CLEAR_DEFAULT), 
      .BIST_CLEAR(BIST_CLEAR), .MBISTPG_SO(MBISTPG_SO), .BIST_USER9(BIST_USER9), 
      .BIST_USER10(BIST_USER10), .BIST_USER11(BIST_USER11), .BIST_USER0(BIST_USER0), 
      .BIST_USER1(BIST_USER1), .BIST_USER2(BIST_USER2), .BIST_USER3(BIST_USER3), 
      .BIST_USER4(BIST_USER4), .BIST_USER5(BIST_USER5), .BIST_USER6(BIST_USER6), 
      .BIST_USER7(BIST_USER7), .BIST_USER8(BIST_USER8), .BIST_EVEN_GROUPWRITEENABLE(BIST_EVEN_GROUPWRITEENABLE), 
      .BIST_ODD_GROUPWRITEENABLE(BIST_ODD_GROUPWRITEENABLE), .BIST_WRITEENABLE(BIST_WRITEENABLE), 
      .BIST_READENABLE(BIST_READENABLE), .BIST_SELECT(BIST_SELECT), .BIST_CMP(), 
      .BIST_COLLAR_EN0(BIST_COLLAR_EN0), .BIST_RUN_TO_COLLAR0(BIST_RUN_TO_COLLAR0), 
      .BIST_COLLAR_EN1(BIST_COLLAR_EN1), .BIST_RUN_TO_COLLAR1(BIST_RUN_TO_COLLAR1), 
      .MBISTPG_GO(MBISTPG_GO), .MBISTPG_STABLE(MBISTPG_STABLE), .MBISTPG_DONE(MBISTPG_DONE), 
      .BIST_ON_TO_COLLAR(BIST_ON_TO_COLLAR), .ALGO_SEL_REG(ALGO_SEL_REG), .fscan_clkungate(fscan_clkungate)
  );

  TS_CLK_MUX tessent_persistent_cell_tck_mux_hif_pcie_pcie_upp_tcam_mems_rtl_nss_hif_clk_inst(
      .ck0(nss_hif_clk), .ck1(ijtag_to_tck), .s(tck_select), .o(nss_hif_clk_ts1)
  );

  hif_pcie_pcie_upp_tcam_mems_rtl_tessent_mbist_diagnosis_ready hif_pcie_pcie_upp_tcam_mems_rtl_tessent_mbist_diagnosis_ready_inst(
      .ijtag_reset(ijtag_to_reset), .ijtag_sel(ijtag_to_sel), .ijtag_si(hif_pcie_pcie_upp_tcam_mems_rtl_tessent_mbist_bap_inst_so), 
      .ijtag_ce(ijtag_to_ce), .ijtag_se(ijtag_to_se), .ijtag_ue(ijtag_to_ue), .ijtag_tck(ijtag_to_tck), 
      .ijtag_so(ijtag_so), .DiagnosisReady_ctl_in(MBISTPG_STABLE), .DiagnosisReady_aux_in(1'b1), 
      .StableBlock(hif_pcie_pcie_upp_tcam_mems_mbist_diag_done)
  );

  assign bisr_so_pd_vinf_ts1 = bisr_si_pd_vinf;

  mbist_post_agg #(.NUM_OF_CNTRL(1)) post_aggregator(
      .post_complete(complete), .post_pass(pass), .post_busy(busy), .post_complete_agg(aary_post_complete), 
      .post_pass_agg(aary_post_pass), .post_busy_agg(aary_post_busy)
  );

  mbist_post_arrayinit_selection postArrayInitSelection(
      .post(fary_trigger_post), .arrayinit(1'b0), .arrayinit_done(1'b1), .trigger_post(trigger_post), 
      .trigger_array(trigger_array)
  );

  mbist_post_arrayinit_algo_selection #(.NUMBER_ALGO_BITS(7), .DEFAULT_POST_ALGO(7'b0000001), .FAILINJ_ALGO(7'b0000010), .DEFAULT_ARRAYINIT_ALGO(7'b0), .ALGO_SEL_WIDTH(6), .PADDING(2), .MAX_ALGO_OPCODE(5'b11111), .MAX_RF_ALGO_OPCODE(5'b01111)) algoSelection(
      .post_trigger(trigger_post), .arrayinit(trigger_array), .post_force_fail(fary_post_force_fail), 
      .mbistpg_algo_sel_i(fary_post_algo_select), .mbistpg_algo_sel_o(mbistpg_algo_sel_o[6:0]), 
      .mbistpg_select_common_algo_o(mbistpg_select_common_algo_o), .select_rf(), 
      .select_rom(), .select_sram(select_sram)
  );

  mbist_post_arrayinit_macro_parallel_bap parallel_bap_POST_macro_0(
      .reset(sync_reset_nss_hif_clk_o), .trigger(trigger_post), .BIST_CLK_IN(nss_hif_clk), 
      .MBISTPG_DONE(sys_test_done_nss_hif_clk), .MBISTPG_GO(sys_test_pass_nss_hif_clk), 
      .busy(busy), .pass(pass), .complete(complete)
  );

  TS_SYNCHRONIZER sync_reset_nss_hif_clk(
      .clk(nss_hif_clk), .d(1'b1), .rst(Intel_reset_sync_polarity_nss_hif_clk_inverter_o1), 
      .o(sync_reset_nss_hif_clk_o_ts1)
  );

  TS_MX sync_reset_nss_hif_clk_reset_bypass_mux(
      .a(fscan_byprst_b), .b(core_rst_b), .sa(fscan_rstbypen), .o(sync_reset_nss_hif_clk_reset_bypass_mux_o)
  );

  TS_INV Intel_reset_sync_polarity_nss_hif_clk_inverter(
      .a(sync_reset_nss_hif_clk_reset_bypass_mux_o), .o1(Intel_reset_sync_polarity_nss_hif_clk_inverter_o1)
  );

  TS_MX sync_reset_nss_hif_clk_reset_output_bypass_mux(
      .a(fscan_byprst_b), .b(sync_reset_nss_hif_clk_o_ts1), .sa(fscan_rstbypen), 
      .o(sync_reset_nss_hif_clk_o)
  );
endmodule

