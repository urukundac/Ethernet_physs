//////////////////////////////////////////////////////////////////////
//
//                      Automated Memory Wrappers Creator
//
//                                      & 
//
//////////////////////////////////////////////////////////////////////
`include        "hlp_mod_mem.def"
module hlp_mod_apr_tcam_mems (

input fary_ijtag_tck,
input fary_ijtag_rst_b,
input fary_ijtag_select,
input fary_ijtag_shift,
input fary_ijtag_capture,
input fary_ijtag_update,
input fary_ijtag_si,
output aary_ijtag_so,
input bisr_clk_pd_vinf,
input bisr_shift_en_pd_vinf,
input bisr_reset_pd_vinf,
input bisr_si_pd_vinf,
output bisr_so_pd_vinf,






input logic             fscan_byprst_b,         // To u_mod_apr_func_logic of hlp_mod_apr_func_logic.v
input logic [hlp_dfx_pkg::MOD_NUM_CLKGENCTRL-1:0] fscan_clkgenctrl,// To u_mod_apr_func_logic of hlp_mod_apr_func_logic.v
input logic [hlp_dfx_pkg::MOD_NUM_CLKGENCTRLEN-1:0] fscan_clkgenctrlen,// To u_mod_apr_func_logic of hlp_mod_apr_func_logic.v
input logic             fscan_clkungate,        // To u_mod_apr_sram_mems of hlp_mod_apr_sram_mems.v, ...
input logic             fscan_clkungate_syn,    // To u_mod_apr_func_logic of hlp_mod_apr_func_logic.v
input logic             fscan_latchclosed_b,    // To u_mod_apr_func_logic of hlp_mod_apr_func_logic.v
input logic             fscan_latchopen,        // To u_mod_apr_func_logic of hlp_mod_apr_func_logic.v
input logic             fscan_mode,             // To u_mod_apr_tcam_mems of hlp_mod_apr_tcam_mems.v, ...
input logic             fscan_mode_atspeed,     // To u_mod_apr_func_logic of hlp_mod_apr_func_logic.v
input logic             fscan_ram_bypsel_rf,    // To u_mod_apr_rf_mems of hlp_mod_apr_rf_mems.v
input logic             fscan_ram_bypsel_sram,  // To u_mod_apr_sram_mems of hlp_mod_apr_sram_mems.v
input logic             fscan_ram_bypsel_tcam,  // To u_mod_apr_tcam_mems of hlp_mod_apr_tcam_mems.v
input logic             fscan_ram_init_en,      // To u_mod_apr_sram_mems of hlp_mod_apr_sram_mems.v, ...
input logic             fscan_ram_init_val,     // To u_mod_apr_sram_mems of hlp_mod_apr_sram_mems.v, ...
input logic             fscan_ram_rdis_b,       // To u_mod_apr_sram_mems of hlp_mod_apr_sram_mems.v, ...
input logic             fscan_ram_wdis_b,       // To u_mod_apr_sram_mems of hlp_mod_apr_sram_mems.v, ...
input logic             fscan_ret_ctrl,         // To u_mod_apr_func_logic of hlp_mod_apr_func_logic.v
input logic             fscan_rstbypen,         // To u_mod_apr_func_logic of hlp_mod_apr_func_logic.v
input logic [hlp_dfx_pkg::MOD_NUM_SDI-1:0] fscan_sdi,// To u_mod_apr_func_logic of hlp_mod_apr_func_logic.v
input logic             fscan_shiften,          // To u_mod_apr_tcam_mems of hlp_mod_apr_tcam_mems.v, ...
// Module inputs
output mbist_diag_done,
input fsta_afd_en,
input clk_rscclk,

   input                                          DFTMASK                                 ,   
   input                                          DFTSHIFTEN                              ,   
   input                                          DFT_AFD_RESET_B                         ,   
   input                                          DFT_ARRAY_FREEZE                        ,   
   input                                          clk                                     ,   
   input                                          fary_ffuse_tcam_sleep                   ,   
   input                                   [15:0] fary_ffuse_tune_tcam                    ,   
   input                                          fary_isolation_control_in               ,   
   input                                          fary_output_reset                       ,   
   input                                          fary_pwren_b_tcam                       ,   
`ifdef HLP_FPGA_TCAM_MEMS
   input                                          fpga_fast_clk                           ,   
`endif
   input                                          fsta_dfxact_afd                         ,   
   input                                          ip_reset_b                              ,   
   input [`HLP_MOD_MOD_MS_SCI_TABLE_TCAM_TO_TCAM_WIDTH-1:0] mod_mod_ms_sci_table_tcam_0_to_tcam     ,   
   input [`HLP_MOD_MOD_MS_SCI_TABLE_TCAM_TO_TCAM_WIDTH-1:0] mod_mod_ms_sci_table_tcam_1_to_tcam     ,   
   input [`HLP_MOD_MOD_TX_STATS_VLAN_CNT_IDX_MAP_TCAM_TO_TCAM_WIDTH-1:0] mod_mod_tx_stats_vlan_cnt_idx_map_tcam_0_to_tcam     ,   
   input [`HLP_MOD_MOD_TX_STATS_VLAN_CNT_IDX_MAP_TCAM_TO_TCAM_WIDTH-1:0] mod_mod_tx_stats_vlan_cnt_idx_map_tcam_1_to_tcam     ,   
   input [`HLP_MOD_MOD_TX_STATS_VLAN_CNT_IDX_MAP_TCAM_TO_TCAM_WIDTH-1:0] mod_mod_tx_stats_vlan_cnt_idx_map_tcam_2_to_tcam     ,   
   input [`HLP_MOD_MOD_TX_STATS_VLAN_CNT_IDX_MAP_TCAM_TO_TCAM_WIDTH-1:0] mod_mod_tx_stats_vlan_cnt_idx_map_tcam_3_to_tcam     ,   
   input [`HLP_MOD_MOD_TX_STATS_VLAN_CNT_IDX_MAP_TCAM_TO_TCAM_WIDTH-1:0] mod_mod_tx_stats_vlan_cnt_idx_map_tcam_4_to_tcam     ,   
   input [`HLP_MOD_MOD_TX_STATS_VLAN_CNT_IDX_MAP_TCAM_TO_TCAM_WIDTH-1:0] mod_mod_tx_stats_vlan_cnt_idx_map_tcam_5_to_tcam     ,   
   input [`HLP_MOD_MOD_TX_STATS_VLAN_CNT_IDX_MAP_TCAM_TO_TCAM_WIDTH-1:0] mod_mod_tx_stats_vlan_cnt_idx_map_tcam_6_to_tcam     ,   
   input [`HLP_MOD_MOD_TX_STATS_VLAN_CNT_IDX_MAP_TCAM_TO_TCAM_WIDTH-1:0] mod_mod_tx_stats_vlan_cnt_idx_map_tcam_7_to_tcam     ,

// Module outputs

  output                                          aary_pwren_b_tcam                       ,   
  output [`HLP_MOD_MOD_MS_SCI_TABLE_TCAM_FROM_TCAM_WIDTH-1:0] mod_mod_ms_sci_table_tcam_0_from_tcam     ,   
  output [`HLP_MOD_MOD_MS_SCI_TABLE_TCAM_FROM_TCAM_WIDTH-1:0] mod_mod_ms_sci_table_tcam_1_from_tcam     ,   
  output [`HLP_MOD_MOD_TX_STATS_VLAN_CNT_IDX_MAP_TCAM_FROM_TCAM_WIDTH-1:0] mod_mod_tx_stats_vlan_cnt_idx_map_tcam_0_from_tcam     ,   
  output [`HLP_MOD_MOD_TX_STATS_VLAN_CNT_IDX_MAP_TCAM_FROM_TCAM_WIDTH-1:0] mod_mod_tx_stats_vlan_cnt_idx_map_tcam_1_from_tcam     ,   
  output [`HLP_MOD_MOD_TX_STATS_VLAN_CNT_IDX_MAP_TCAM_FROM_TCAM_WIDTH-1:0] mod_mod_tx_stats_vlan_cnt_idx_map_tcam_2_from_tcam     ,   
  output [`HLP_MOD_MOD_TX_STATS_VLAN_CNT_IDX_MAP_TCAM_FROM_TCAM_WIDTH-1:0] mod_mod_tx_stats_vlan_cnt_idx_map_tcam_3_from_tcam     ,   
  output [`HLP_MOD_MOD_TX_STATS_VLAN_CNT_IDX_MAP_TCAM_FROM_TCAM_WIDTH-1:0] mod_mod_tx_stats_vlan_cnt_idx_map_tcam_4_from_tcam     ,   
  output [`HLP_MOD_MOD_TX_STATS_VLAN_CNT_IDX_MAP_TCAM_FROM_TCAM_WIDTH-1:0] mod_mod_tx_stats_vlan_cnt_idx_map_tcam_5_from_tcam     ,   
  output [`HLP_MOD_MOD_TX_STATS_VLAN_CNT_IDX_MAP_TCAM_FROM_TCAM_WIDTH-1:0] mod_mod_tx_stats_vlan_cnt_idx_map_tcam_6_from_tcam     ,   
  output [`HLP_MOD_MOD_TX_STATS_VLAN_CNT_IDX_MAP_TCAM_FROM_TCAM_WIDTH-1:0] mod_mod_tx_stats_vlan_cnt_idx_map_tcam_7_from_tcam           
, input wire fary_trigger_post, output wire aary_post_pass, 
output wire aary_post_busy, output wire aary_post_complete, 
input wire fary_post_force_fail, input logic [5:0] fary_post_algo_select, 
input wire core_rst_b);
  wire [2:0] BIST_SETUP;
  wire [6:0] BIST_ALGO_SEL;
  wire [0:0] toBist, bistEn;
  wire [6:0] BIST_ROW_ADD;
  wire [1:0] BIST_BANK_ADD;
  wire [31:0] BIST_WRITE_DATA, BIST_EXPECT_DATA;
  wire hlp_mod_apr_tcam_mems_rtl_tessent_sib_mbist_inst_so, 
       hlp_mod_apr_tcam_mems_rtl_tessent_sib_sti_inst_so, 
       hlp_mod_apr_tcam_mems_rtl_tessent_sib_sri_ctrl_inst_so, 
       hlp_mod_apr_tcam_mems_rtl_tessent_tdr_sri_ctrl_inst_so, 
       hlp_mod_apr_tcam_mems_rtl_tessent_sib_sri_inst_to_select, 
       hlp_mod_apr_tcam_mems_rtl_tessent_sib_sti_inst_so_ts1, 
       hlp_mod_apr_tcam_mems_rtl_tessent_tdr_TCAM_c1_algo_select_tdr_inst_so, 
       hlp_mod_apr_tcam_mems_rtl_tessent_sib_sti_inst_to_select, 
       hlp_mod_apr_tcam_mems_rtl_tessent_sib_algo_select_sib_inst_so, 
       hlp_mod_apr_tcam_mems_rtl_tessent_sib_sri_ctrl_inst_to_select, 
       hlp_mod_apr_tcam_mems_rtl_tessent_sib_algo_select_sib_inst_to_select, 
       ijtag_to_se, ijtag_to_ce, ijtag_to_tck, ijtag_to_ue, ijtag_to_reset, 
       ijtag_to_sel, ltest_to_en, ltest_to_mem_bypass_en, ltest_to_scan_en, 
       ltest_to_mcp_bounding_en, BIRA_EN, PRESERVE_FUSE_REGISTER, 
       CHECK_REPAIR_NEEDED, BIST_HOLD, BIST_SELECT_TEST_DATA, 
       to_controllers_tck, to_interfaces_tck, to_controllers_tck_retime, 
       mcp_bounding_to_en, scan_to_en, memory_bypass_to_en, ltest_to_en_ts1, 
       BIST_SELECT_COMMON_ALGO, BIST_SELECT_COMMON_OPSET, BIST_OPSET_SEL, 
       BIST_DATA_INV_ROW_ADD_BIT_SELECT_EN, BIST_DATA_INV_ROW_ADD_BIT_SEL, 
       BIST_DATA_INV_COL_ADD_BIT_SEL, GO_ID_REG_SEL, 
       BIST_DATA_INV_COL_ADD_BIT_SELECT_EN, BIST_ALGO_MODE0, BIST_ALGO_MODE1, 
       ENABLE_MEM_RESET, REDUCED_ADDRESS_COUNT, BIST_CLEAR_BIRA, 
       BIST_COLLAR_DIAG_EN, BIST_COLLAR_BIRA_EN, BIST_SHIFT_BIRA_COLLAR, 
       MEM_ARRAY_DUMP_MODE, BIST_DIAG_EN, BIST_ASYNC_RESET, MEM0_BIST_COLLAR_SI, 
       MEM1_BIST_COLLAR_SI, MEM2_BIST_COLLAR_SI, MEM3_BIST_COLLAR_SI, 
       MEM4_BIST_COLLAR_SI, MEM5_BIST_COLLAR_SI, MEM6_BIST_COLLAR_SI, 
       MEM7_BIST_COLLAR_SI, MEM8_BIST_COLLAR_SI, MEM9_BIST_COLLAR_SI, 
       MEM10_BIST_COLLAR_SI, MEM11_BIST_COLLAR_SI, MBISTPG_SO, BIST_SO, 
       BIST_SO_ts1, BIST_SO_ts2, BIST_SO_ts3, BIST_SO_ts4, BIST_SO_ts5, 
       BIST_SO_ts6, BIST_SO_ts7, BIST_SO_ts8, BIST_SO_ts9, BIST_SO_ts10, 
       BIST_SO_ts11, MBISTPG_DONE, MBISTPG_GO, BIST_GO, BIST_GO_ts1, 
       BIST_GO_ts2, BIST_GO_ts3, BIST_GO_ts4, BIST_GO_ts5, BIST_GO_ts6, 
       BIST_GO_ts7, BIST_GO_ts8, BIST_GO_ts9, BIST_GO_ts10, BIST_GO_ts11, 
       FL_CNT_MODE0, FL_CNT_MODE1, BIST_USER9, BIST_USER10, BIST_USER11, 
       BIST_USER0, BIST_USER1, BIST_USER2, BIST_USER3, BIST_USER4, BIST_USER5, 
       BIST_USER6, BIST_USER7, BIST_USER8, BIST_EVEN_GROUPWRITEENABLE, 
       BIST_ODD_GROUPWRITEENABLE, BIST_WRITEENABLE, BIST_READENABLE, 
       BIST_SELECT, BIST_CMP, INCLUDE_MEM_RESULTS_REG, BIST_COL_ADD, 
       BIST_COLLAR_EN0, BIST_COLLAR_EN1, BIST_COLLAR_EN2, BIST_COLLAR_EN3, 
       BIST_COLLAR_EN4, BIST_COLLAR_EN5, BIST_COLLAR_EN6, BIST_COLLAR_EN7, 
       BIST_COLLAR_EN8, BIST_COLLAR_EN9, BIST_COLLAR_EN10, BIST_COLLAR_EN11, 
       BIST_RUN_TO_COLLAR0, BIST_RUN_TO_COLLAR1, BIST_RUN_TO_COLLAR2, 
       BIST_RUN_TO_COLLAR3, BIST_RUN_TO_COLLAR4, BIST_RUN_TO_COLLAR5, 
       BIST_RUN_TO_COLLAR6, BIST_RUN_TO_COLLAR7, BIST_RUN_TO_COLLAR8, 
       BIST_RUN_TO_COLLAR9, BIST_RUN_TO_COLLAR10, BIST_RUN_TO_COLLAR11, 
       BIST_TESTDATA_SELECT_TO_COLLAR, BIST_ON_TO_COLLAR, BIST_SHIFT_COLLAR, 
       BIST_COLLAR_SETUP, BIST_CLEAR_DEFAULT, BIST_CLEAR, 
       BIST_COLLAR_OPSET_SELECT, BIST_COLLAR_HOLD, FREEZE_STOP_ERROR, 
       ERROR_CNT_ZERO, MBISTPG_RESET_REG_SETUP2, 
       hlp_mod_apr_tcam_mems_rtl_tessent_mbist_bap_inst_so, clk_ts1, tck_select, 
       MBISTPG_STABLE, ijtag_so, bisr_so_pd_vinf_ts1, trigger_post, 
       trigger_array, mbistpg_select_common_algo_o, select_sram, pass, 
       sys_test_done_clk, sys_test_pass_clk, complete, busy, 
       sync_reset_clk_reset_bypass_mux_o, 
       Intel_reset_sync_polarity_clk_inverter_o1, sync_reset_clk_o, 
       sync_reset_clk_o_ts1;
  wire [6:0] mbistpg_algo_sel_o, ALGO_SEL_REG;


// BEGIN_TOP_LOGIC

`ifndef         HLP_ENVELOPE_ONLY

// END_TOP_LOGIC


genvar iter;


// Instances

hlp_mod_tcam_mems  mod_tcam_mems(
        .DFTMASK(DFTMASK),
        .DFTSHIFTEN(DFTSHIFTEN),
        .DFT_AFD_RESET_B(DFT_AFD_RESET_B),
        .DFT_ARRAY_FREEZE(DFT_ARRAY_FREEZE),
        .clk(clk_ts1),
        .fary_ffuse_tcam_sleep(fary_ffuse_tcam_sleep),
        .fary_ffuse_tune_tcam(fary_ffuse_tune_tcam),
        .fary_isolation_control_in(fary_isolation_control_in),
        .fary_output_reset(fary_output_reset),
        .fary_pwren_b_tcam(fary_pwren_b_tcam),
`ifdef HLP_FPGA_TCAM_MEMS
        .fpga_fast_clk(fpga_fast_clk),
`endif
        .fscan_clkungate(fscan_clkungate),
        .fscan_mode(fscan_mode),
        .fscan_ram_bypsel_tcam(fscan_ram_bypsel_tcam),
        .fscan_ram_init_en(fscan_ram_init_en),
        .fscan_ram_init_val(fscan_ram_init_val),
        .fscan_ram_rdis_b(fscan_ram_rdis_b),
        .fscan_ram_wdis_b(fscan_ram_wdis_b),
        .fscan_shiften(fscan_shiften),
        .fsta_dfxact_afd(fsta_dfxact_afd),
        .ip_reset_b(ip_reset_b),
        .mod_mod_ms_sci_table_tcam_0_to_tcam(mod_mod_ms_sci_table_tcam_0_to_tcam),
        .mod_mod_ms_sci_table_tcam_1_to_tcam(mod_mod_ms_sci_table_tcam_1_to_tcam),
        .mod_mod_tx_stats_vlan_cnt_idx_map_tcam_0_to_tcam(mod_mod_tx_stats_vlan_cnt_idx_map_tcam_0_to_tcam),
        .mod_mod_tx_stats_vlan_cnt_idx_map_tcam_1_to_tcam(mod_mod_tx_stats_vlan_cnt_idx_map_tcam_1_to_tcam),
        .mod_mod_tx_stats_vlan_cnt_idx_map_tcam_2_to_tcam(mod_mod_tx_stats_vlan_cnt_idx_map_tcam_2_to_tcam),
        .mod_mod_tx_stats_vlan_cnt_idx_map_tcam_3_to_tcam(mod_mod_tx_stats_vlan_cnt_idx_map_tcam_3_to_tcam),
        .mod_mod_tx_stats_vlan_cnt_idx_map_tcam_4_to_tcam(mod_mod_tx_stats_vlan_cnt_idx_map_tcam_4_to_tcam),
        .mod_mod_tx_stats_vlan_cnt_idx_map_tcam_5_to_tcam(mod_mod_tx_stats_vlan_cnt_idx_map_tcam_5_to_tcam),
        .mod_mod_tx_stats_vlan_cnt_idx_map_tcam_6_to_tcam(mod_mod_tx_stats_vlan_cnt_idx_map_tcam_6_to_tcam),
        .mod_mod_tx_stats_vlan_cnt_idx_map_tcam_7_to_tcam(mod_mod_tx_stats_vlan_cnt_idx_map_tcam_7_to_tcam),
        .aary_pwren_b_tcam(aary_pwren_b_tcam),
        .mod_mod_ms_sci_table_tcam_0_from_tcam(mod_mod_ms_sci_table_tcam_0_from_tcam),
        .mod_mod_ms_sci_table_tcam_1_from_tcam(mod_mod_ms_sci_table_tcam_1_from_tcam),
        .mod_mod_tx_stats_vlan_cnt_idx_map_tcam_0_from_tcam(mod_mod_tx_stats_vlan_cnt_idx_map_tcam_0_from_tcam),
        .mod_mod_tx_stats_vlan_cnt_idx_map_tcam_1_from_tcam(mod_mod_tx_stats_vlan_cnt_idx_map_tcam_1_from_tcam),
        .mod_mod_tx_stats_vlan_cnt_idx_map_tcam_2_from_tcam(mod_mod_tx_stats_vlan_cnt_idx_map_tcam_2_from_tcam),
        .mod_mod_tx_stats_vlan_cnt_idx_map_tcam_3_from_tcam(mod_mod_tx_stats_vlan_cnt_idx_map_tcam_3_from_tcam),
        .mod_mod_tx_stats_vlan_cnt_idx_map_tcam_4_from_tcam(mod_mod_tx_stats_vlan_cnt_idx_map_tcam_4_from_tcam),
        .mod_mod_tx_stats_vlan_cnt_idx_map_tcam_5_from_tcam(mod_mod_tx_stats_vlan_cnt_idx_map_tcam_5_from_tcam),
        .mod_mod_tx_stats_vlan_cnt_idx_map_tcam_6_from_tcam(mod_mod_tx_stats_vlan_cnt_idx_map_tcam_6_from_tcam),
        .mod_mod_tx_stats_vlan_cnt_idx_map_tcam_7_from_tcam(mod_mod_tx_stats_vlan_cnt_idx_map_tcam_7_from_tcam), 
                                 .BIST_SETUP(BIST_SETUP[0]), .BIST_SETUP_ts1(BIST_SETUP[1]), 
                                 .BIST_SETUP_ts2(BIST_SETUP[2]), 
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
                                 .BIST_SO(BIST_SO), .BIST_SO_ts1(BIST_SO_ts1), 
                                 .BIST_SO_ts2(BIST_SO_ts2), .BIST_SO_ts3(BIST_SO_ts3), 
                                 .BIST_SO_ts4(BIST_SO_ts4), .BIST_SO_ts5(BIST_SO_ts5), 
                                 .BIST_SO_ts6(BIST_SO_ts6), .BIST_SO_ts7(BIST_SO_ts7), 
                                 .BIST_SO_ts8(BIST_SO_ts8), .BIST_SO_ts9(BIST_SO_ts9), 
                                 .BIST_SO_ts10(BIST_SO_ts10), .BIST_SO_ts11(BIST_SO_ts11), 
                                 .BIST_GO(BIST_GO), .BIST_GO_ts1(BIST_GO_ts1), 
                                 .BIST_GO_ts2(BIST_GO_ts2), .BIST_GO_ts3(BIST_GO_ts3), 
                                 .BIST_GO_ts4(BIST_GO_ts4), .BIST_GO_ts5(BIST_GO_ts5), 
                                 .BIST_GO_ts6(BIST_GO_ts6), .BIST_GO_ts7(BIST_GO_ts7), 
                                 .BIST_GO_ts8(BIST_GO_ts8), .BIST_GO_ts9(BIST_GO_ts9), 
                                 .BIST_GO_ts10(BIST_GO_ts10), .BIST_GO_ts11(BIST_GO_ts11), 
                                 .ltest_to_en(ltest_to_en_ts1), .BIST_USER9(BIST_USER9), 
                                 .BIST_USER10(BIST_USER10), .BIST_USER11(BIST_USER11), 
                                 .BIST_USER0(BIST_USER0), .BIST_USER1(BIST_USER1), 
                                 .BIST_USER2(BIST_USER2), .BIST_USER3(BIST_USER3), 
                                 .BIST_USER4(BIST_USER4), .BIST_USER5(BIST_USER5), 
                                 .BIST_USER6(BIST_USER6), .BIST_USER7(BIST_USER7), 
                                 .BIST_USER8(BIST_USER8), 
                                 .BIST_EVEN_GROUPWRITEENABLE(BIST_EVEN_GROUPWRITEENABLE), 
                                 .BIST_ODD_GROUPWRITEENABLE(BIST_ODD_GROUPWRITEENABLE), 
                                 .BIST_WRITEENABLE(BIST_WRITEENABLE), 
                                 .BIST_READENABLE(BIST_READENABLE), 
                                 .BIST_SELECT(BIST_SELECT), .BIST_CMP(BIST_CMP), 
                                 .INCLUDE_MEM_RESULTS_REG(INCLUDE_MEM_RESULTS_REG), 
                                 .BIST_COL_ADD(BIST_COL_ADD), .BIST_ROW_ADD(BIST_ROW_ADD[0]), 
                                 .BIST_ROW_ADD_ts1(BIST_ROW_ADD[1]), 
                                 .BIST_ROW_ADD_ts2(BIST_ROW_ADD[2]), 
                                 .BIST_ROW_ADD_ts3(BIST_ROW_ADD[3]), 
                                 .BIST_ROW_ADD_ts4(BIST_ROW_ADD[4]), 
                                 .BIST_ROW_ADD_ts5(BIST_ROW_ADD[5]), 
                                 .BIST_ROW_ADD_ts6(BIST_ROW_ADD[6]), 
                                 .BIST_BANK_ADD(BIST_BANK_ADD[0]), 
                                 .BIST_BANK_ADD_ts1(BIST_BANK_ADD[1]), 
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
                                 .BIST_ASYNC_RESET(BIST_ASYNC_RESET), 
                                 .BIST_TESTDATA_SELECT_TO_COLLAR(BIST_TESTDATA_SELECT_TO_COLLAR), 
                                 .BIST_ON_TO_COLLAR(BIST_ON_TO_COLLAR), 
                                 .BIST_WRITE_DATA(BIST_WRITE_DATA[0]), 
                                 .BIST_WRITE_DATA_ts1(BIST_WRITE_DATA[1]), 
                                 .BIST_WRITE_DATA_ts2(BIST_WRITE_DATA[2]), 
                                 .BIST_WRITE_DATA_ts3(BIST_WRITE_DATA[3]), 
                                 .BIST_WRITE_DATA_ts4(BIST_WRITE_DATA[4]), 
                                 .BIST_WRITE_DATA_ts5(BIST_WRITE_DATA[5]), 
                                 .BIST_WRITE_DATA_ts6(BIST_WRITE_DATA[6]), 
                                 .BIST_WRITE_DATA_ts7(BIST_WRITE_DATA[7]), 
                                 .BIST_WRITE_DATA_ts8(BIST_WRITE_DATA[8]), 
                                 .BIST_WRITE_DATA_ts9(BIST_WRITE_DATA[9]), 
                                 .BIST_WRITE_DATA_ts10(BIST_WRITE_DATA[10]), 
                                 .BIST_WRITE_DATA_ts11(BIST_WRITE_DATA[11]), 
                                 .BIST_WRITE_DATA_ts12(BIST_WRITE_DATA[12]), 
                                 .BIST_WRITE_DATA_ts13(BIST_WRITE_DATA[13]), 
                                 .BIST_WRITE_DATA_ts14(BIST_WRITE_DATA[14]), 
                                 .BIST_WRITE_DATA_ts15(BIST_WRITE_DATA[15]), 
                                 .BIST_WRITE_DATA_ts16(BIST_WRITE_DATA[16]), 
                                 .BIST_WRITE_DATA_ts17(BIST_WRITE_DATA[17]), 
                                 .BIST_WRITE_DATA_ts18(BIST_WRITE_DATA[18]), 
                                 .BIST_WRITE_DATA_ts19(BIST_WRITE_DATA[19]), 
                                 .BIST_WRITE_DATA_ts20(BIST_WRITE_DATA[20]), 
                                 .BIST_WRITE_DATA_ts21(BIST_WRITE_DATA[21]), 
                                 .BIST_WRITE_DATA_ts22(BIST_WRITE_DATA[22]), 
                                 .BIST_WRITE_DATA_ts23(BIST_WRITE_DATA[23]), 
                                 .BIST_WRITE_DATA_ts24(BIST_WRITE_DATA[24]), 
                                 .BIST_WRITE_DATA_ts25(BIST_WRITE_DATA[25]), 
                                 .BIST_WRITE_DATA_ts26(BIST_WRITE_DATA[26]), 
                                 .BIST_WRITE_DATA_ts27(BIST_WRITE_DATA[27]), 
                                 .BIST_WRITE_DATA_ts28(BIST_WRITE_DATA[28]), 
                                 .BIST_WRITE_DATA_ts29(BIST_WRITE_DATA[29]), 
                                 .BIST_WRITE_DATA_ts30(BIST_WRITE_DATA[30]), 
                                 .BIST_WRITE_DATA_ts31(BIST_WRITE_DATA[31]), 
                                 .BIST_EXPECT_DATA(BIST_EXPECT_DATA[0]), 
                                 .BIST_EXPECT_DATA_ts1(BIST_EXPECT_DATA[1]), 
                                 .BIST_EXPECT_DATA_ts2(BIST_EXPECT_DATA[2]), 
                                 .BIST_EXPECT_DATA_ts3(BIST_EXPECT_DATA[3]), 
                                 .BIST_EXPECT_DATA_ts4(BIST_EXPECT_DATA[4]), 
                                 .BIST_EXPECT_DATA_ts5(BIST_EXPECT_DATA[5]), 
                                 .BIST_EXPECT_DATA_ts6(BIST_EXPECT_DATA[6]), 
                                 .BIST_EXPECT_DATA_ts7(BIST_EXPECT_DATA[7]), 
                                 .BIST_EXPECT_DATA_ts8(BIST_EXPECT_DATA[8]), 
                                 .BIST_EXPECT_DATA_ts9(BIST_EXPECT_DATA[9]), 
                                 .BIST_EXPECT_DATA_ts10(BIST_EXPECT_DATA[10]), 
                                 .BIST_EXPECT_DATA_ts11(BIST_EXPECT_DATA[11]), 
                                 .BIST_EXPECT_DATA_ts12(BIST_EXPECT_DATA[12]), 
                                 .BIST_EXPECT_DATA_ts13(BIST_EXPECT_DATA[13]), 
                                 .BIST_EXPECT_DATA_ts14(BIST_EXPECT_DATA[14]), 
                                 .BIST_EXPECT_DATA_ts15(BIST_EXPECT_DATA[15]), 
                                 .BIST_EXPECT_DATA_ts16(BIST_EXPECT_DATA[16]), 
                                 .BIST_EXPECT_DATA_ts17(BIST_EXPECT_DATA[17]), 
                                 .BIST_EXPECT_DATA_ts18(BIST_EXPECT_DATA[18]), 
                                 .BIST_EXPECT_DATA_ts19(BIST_EXPECT_DATA[19]), 
                                 .BIST_EXPECT_DATA_ts20(BIST_EXPECT_DATA[20]), 
                                 .BIST_EXPECT_DATA_ts21(BIST_EXPECT_DATA[21]), 
                                 .BIST_EXPECT_DATA_ts22(BIST_EXPECT_DATA[22]), 
                                 .BIST_EXPECT_DATA_ts23(BIST_EXPECT_DATA[23]), 
                                 .BIST_EXPECT_DATA_ts24(BIST_EXPECT_DATA[24]), 
                                 .BIST_EXPECT_DATA_ts25(BIST_EXPECT_DATA[25]), 
                                 .BIST_EXPECT_DATA_ts26(BIST_EXPECT_DATA[26]), 
                                 .BIST_EXPECT_DATA_ts27(BIST_EXPECT_DATA[27]), 
                                 .BIST_EXPECT_DATA_ts28(BIST_EXPECT_DATA[28]), 
                                 .BIST_EXPECT_DATA_ts29(BIST_EXPECT_DATA[29]), 
                                 .BIST_EXPECT_DATA_ts30(BIST_EXPECT_DATA[30]), 
                                 .BIST_EXPECT_DATA_ts31(BIST_EXPECT_DATA[31]), 
                                 .BIST_SHIFT_COLLAR(BIST_SHIFT_COLLAR), 
                                 .BIST_COLLAR_SETUP(BIST_COLLAR_SETUP), 
                                 .BIST_CLEAR_DEFAULT(BIST_CLEAR_DEFAULT), 
                                 .BIST_CLEAR(BIST_CLEAR), 
                                 .BIST_COLLAR_OPSET_SELECT(BIST_COLLAR_OPSET_SELECT), 
                                 .BIST_COLLAR_HOLD(BIST_COLLAR_HOLD), 
                                 .FREEZE_STOP_ERROR(FREEZE_STOP_ERROR), 
                                 .ERROR_CNT_ZERO(ERROR_CNT_ZERO), 
                                 .MBISTPG_RESET_REG_SETUP2(MBISTPG_RESET_REG_SETUP2), 
                                 .bisr_shift_en_pd_vinf(bisr_shift_en_pd_vinf), 
                                 .bisr_clk_pd_vinf(bisr_clk_pd_vinf), 
                                 .bisr_reset_pd_vinf(bisr_reset_pd_vinf), 
                                 .bisr_si_pd_vinf(bisr_si_pd_vinf), 
                                 .tcam_row_0_col_0_bisr_inst_SO_ts7(bisr_so_pd_vinf)
);


// BEGIN_BOTTOM_LOGIC
`endif

// END_BOTTOM_LOGIC



  hlp_mod_apr_tcam_mems_rtl_tessent_sib_1 hlp_mod_apr_tcam_mems_rtl_tessent_sib_sti_inst(
      .ijtag_reset(fary_ijtag_rst_b), .ijtag_sel(fary_ijtag_select), .ijtag_si(fary_ijtag_si), 
      .ijtag_ce(fary_ijtag_capture), .ijtag_se(fary_ijtag_shift), .ijtag_ue(fary_ijtag_update), 
      .ijtag_tck(fary_ijtag_tck), .ijtag_so(hlp_mod_apr_tcam_mems_rtl_tessent_sib_sti_inst_so), 
      .ijtag_from_so(hlp_mod_apr_tcam_mems_rtl_tessent_sib_mbist_inst_so), .ltest_si(1'b0), 
      .ltest_scan_en(DFTSHIFTEN), .ltest_en(DFTSHIFTEN), .ltest_clk(clk_rscclk), 
      .ltest_mem_bypass_en(DFTMASK), .ltest_mcp_bounding_en(1'b0), .ltest_async_set_reset_static_disable(fscan_byprst_b), 
      .ijtag_to_tck(ijtag_to_tck), .ijtag_to_reset(ijtag_to_reset), .ijtag_to_si(hlp_mod_apr_tcam_mems_rtl_tessent_sib_sti_inst_so_ts1), 
      .ijtag_to_ce(ijtag_to_ce), .ijtag_to_se(ijtag_to_se), .ijtag_to_ue(ijtag_to_ue), 
      .ltest_so(), .ltest_to_en(ltest_to_en), .ltest_to_mem_bypass_en(ltest_to_mem_bypass_en), 
      .ltest_to_mcp_bounding_en(ltest_to_mcp_bounding_en), .ltest_to_scan_en(ltest_to_scan_en), 
      .ijtag_to_sel(hlp_mod_apr_tcam_mems_rtl_tessent_sib_sti_inst_to_select)
  );

  hlp_mod_apr_tcam_mems_rtl_tessent_sib_2 hlp_mod_apr_tcam_mems_rtl_tessent_sib_sri_inst(
      .ijtag_reset(fary_ijtag_rst_b), .ijtag_sel(fary_ijtag_select), .ijtag_si(hlp_mod_apr_tcam_mems_rtl_tessent_sib_sti_inst_so), 
      .ijtag_ce(fary_ijtag_capture), .ijtag_se(fary_ijtag_shift), .ijtag_ue(fary_ijtag_update), 
      .ijtag_tck(fary_ijtag_tck), .ijtag_so(aary_ijtag_so), .ijtag_from_so(hlp_mod_apr_tcam_mems_rtl_tessent_sib_sri_ctrl_inst_so), 
      .ijtag_to_sel(hlp_mod_apr_tcam_mems_rtl_tessent_sib_sri_inst_to_select)
  );

  hlp_mod_apr_tcam_mems_rtl_tessent_sib_3 hlp_mod_apr_tcam_mems_rtl_tessent_sib_sri_ctrl_inst(
      .ijtag_reset(fary_ijtag_rst_b), .ijtag_sel(hlp_mod_apr_tcam_mems_rtl_tessent_sib_sri_inst_to_select), 
      .ijtag_si(hlp_mod_apr_tcam_mems_rtl_tessent_sib_sti_inst_so), .ijtag_ce(fary_ijtag_capture), 
      .ijtag_se(fary_ijtag_shift), .ijtag_ue(fary_ijtag_update), .ijtag_tck(fary_ijtag_tck), 
      .ijtag_so(hlp_mod_apr_tcam_mems_rtl_tessent_sib_sri_ctrl_inst_so), .ijtag_from_so(hlp_mod_apr_tcam_mems_rtl_tessent_tdr_sri_ctrl_inst_so), 
      .ijtag_to_sel(hlp_mod_apr_tcam_mems_rtl_tessent_sib_sri_ctrl_inst_to_select)
  );

  hlp_mod_apr_tcam_mems_rtl_tessent_tdr_sri_ctrl hlp_mod_apr_tcam_mems_rtl_tessent_tdr_sri_ctrl_inst(
      .ijtag_reset(fary_ijtag_rst_b), .ijtag_sel(hlp_mod_apr_tcam_mems_rtl_tessent_sib_sri_ctrl_inst_to_select), 
      .ijtag_si(hlp_mod_apr_tcam_mems_rtl_tessent_sib_sti_inst_so), .ijtag_ce(fary_ijtag_capture), 
      .ijtag_se(fary_ijtag_shift), .ijtag_ue(fary_ijtag_update), .ijtag_tck(fary_ijtag_tck), 
      .tck_select(tck_select), .all_test(), .ijtag_so(hlp_mod_apr_tcam_mems_rtl_tessent_tdr_sri_ctrl_inst_so)
  );

  hlp_mod_apr_tcam_mems_rtl_tessent_sib_4 hlp_mod_apr_tcam_mems_rtl_tessent_sib_algo_select_sib_inst(
      .ijtag_reset(ijtag_to_reset), .ijtag_sel(hlp_mod_apr_tcam_mems_rtl_tessent_sib_sti_inst_to_select), 
      .ijtag_si(hlp_mod_apr_tcam_mems_rtl_tessent_sib_sti_inst_so_ts1), .ijtag_ce(ijtag_to_ce), 
      .ijtag_se(ijtag_to_se), .ijtag_ue(ijtag_to_ue), .ijtag_tck(ijtag_to_tck), 
      .ijtag_so(hlp_mod_apr_tcam_mems_rtl_tessent_sib_algo_select_sib_inst_so), 
      .ijtag_from_so(hlp_mod_apr_tcam_mems_rtl_tessent_tdr_TCAM_c1_algo_select_tdr_inst_so), 
      .ijtag_to_sel(hlp_mod_apr_tcam_mems_rtl_tessent_sib_algo_select_sib_inst_to_select)
  );

  hlp_mod_apr_tcam_mems_rtl_tessent_sib_4 hlp_mod_apr_tcam_mems_rtl_tessent_sib_mbist_inst(
      .ijtag_reset(ijtag_to_reset), .ijtag_sel(hlp_mod_apr_tcam_mems_rtl_tessent_sib_sti_inst_to_select), 
      .ijtag_si(hlp_mod_apr_tcam_mems_rtl_tessent_sib_algo_select_sib_inst_so), 
      .ijtag_ce(ijtag_to_ce), .ijtag_se(ijtag_to_se), .ijtag_ue(ijtag_to_ue), .ijtag_tck(ijtag_to_tck), 
      .ijtag_so(hlp_mod_apr_tcam_mems_rtl_tessent_sib_mbist_inst_so), .ijtag_from_so(ijtag_so), 
      .ijtag_to_sel(ijtag_to_sel)
  );

  hlp_mod_apr_tcam_mems_rtl_tessent_tdr_TCAM_c1_algo_select_tdr hlp_mod_apr_tcam_mems_rtl_tessent_tdr_TCAM_c1_algo_select_tdr_inst(
      .ijtag_reset(ijtag_to_reset), .ijtag_sel(hlp_mod_apr_tcam_mems_rtl_tessent_sib_algo_select_sib_inst_to_select), 
      .ijtag_si(hlp_mod_apr_tcam_mems_rtl_tessent_sib_sti_inst_so_ts1), .ijtag_ce(ijtag_to_ce), 
      .ijtag_se(ijtag_to_se), .ijtag_ue(ijtag_to_ue), .ijtag_tck(ijtag_to_tck), 
      .ALGO_SEL_REG(ALGO_SEL_REG), .ijtag_so(hlp_mod_apr_tcam_mems_rtl_tessent_tdr_TCAM_c1_algo_select_tdr_inst_so)
  );

  hlp_mod_apr_tcam_mems_rtl_tessent_mbist_bap hlp_mod_apr_tcam_mems_rtl_tessent_mbist_bap_inst(
      .reset(ijtag_to_reset), .ijtag_select(ijtag_to_sel), .si(hlp_mod_apr_tcam_mems_rtl_tessent_sib_algo_select_sib_inst_so), 
      .capture_en(ijtag_to_ce), .shift_en(ijtag_to_se), .shift_en_R(), .update_en(ijtag_to_ue), 
      .tck(ijtag_to_tck), .to_interfaces_tck(to_interfaces_tck), .to_controllers_tck_retime(to_controllers_tck_retime), 
      .to_controllers_tck(to_controllers_tck), .mcp_bounding_en(ltest_to_mcp_bounding_en), 
      .mcp_bounding_to_en(mcp_bounding_to_en), .scan_en(ltest_to_scan_en), .scan_to_en(scan_to_en), 
      .memory_bypass_en(ltest_to_mem_bypass_en), .memory_bypass_to_en(memory_bypass_to_en), 
      .ltest_en(ltest_to_en), .ltest_to_en(ltest_to_en_ts1), .BIST_HOLD(BIST_HOLD), 
      .sys_ctrl_select(select_sram), .sys_algo_select(mbistpg_algo_sel_o[6:0]), 
      .sys_select_common_algo(mbistpg_select_common_algo_o), .sys_test_start_clk(trigger_post), 
      .sys_test_init_clk(1'b0), .sys_reset_clk(sync_reset_clk_o), .sys_clock_clk(clk_ts1), 
      .sys_test_pass_clk(sys_test_pass_clk), .sys_test_done_clk(sys_test_done_clk), 
      .sys_ctrl_pass(), .sys_ctrl_done(), .ENABLE_MEM_RESET(ENABLE_MEM_RESET), 
      .REDUCED_ADDRESS_COUNT(REDUCED_ADDRESS_COUNT), .BIST_SELECT_TEST_DATA(BIST_SELECT_TEST_DATA), 
      .BIST_ALGO_MODE0(BIST_ALGO_MODE0), .BIST_ALGO_MODE1(BIST_ALGO_MODE1), .sys_incremental_test_mode(1'b0), 
      .MEM_ARRAY_DUMP_MODE(MEM_ARRAY_DUMP_MODE), .BIRA_EN(BIRA_EN), .BIST_DIAG_EN(BIST_DIAG_EN), 
      .PRESERVE_FUSE_REGISTER(PRESERVE_FUSE_REGISTER), .CHECK_REPAIR_NEEDED(CHECK_REPAIR_NEEDED), 
      .BIST_ASYNC_RESET(BIST_ASYNC_RESET), .FL_CNT_MODE0(FL_CNT_MODE0), .FL_CNT_MODE1(FL_CNT_MODE1), 
      .INCLUDE_MEM_RESULTS_REG(INCLUDE_MEM_RESULTS_REG), .BIST_SETUP(BIST_SETUP[2:0]), 
      .BIST_ALGO_SEL(BIST_ALGO_SEL[6:0]), .BIST_SELECT_COMMON_ALGO(BIST_SELECT_COMMON_ALGO), 
      .BIST_OPSET_SEL(BIST_OPSET_SEL), .BIST_SELECT_COMMON_OPSET(BIST_SELECT_COMMON_OPSET), 
      .BIST_DATA_INV_COL_ADD_BIT_SEL(BIST_DATA_INV_COL_ADD_BIT_SEL), .BIST_DATA_INV_COL_ADD_BIT_SELECT_EN(BIST_DATA_INV_COL_ADD_BIT_SELECT_EN), 
      .BIST_DATA_INV_ROW_ADD_BIT_SEL(BIST_DATA_INV_ROW_ADD_BIT_SEL), .BIST_DATA_INV_ROW_ADD_BIT_SELECT_EN(BIST_DATA_INV_ROW_ADD_BIT_SELECT_EN), 
      .MBISTPG_GO(MBISTPG_GO), .MBISTPG_DONE(MBISTPG_DONE), .bistEn(bistEn), .toBist(toBist), 
      .fromBist(MBISTPG_SO), .so(hlp_mod_apr_tcam_mems_rtl_tessent_mbist_bap_inst_so), 
      .fscan_clkungate(fscan_clkungate)
  );

  hlp_mod_apr_tcam_mems_rtl_tessent_mbist_TCAM_c1_controller hlp_mod_apr_tcam_mems_rtl_tessent_mbist_TCAM_c1_controller_inst(
      .MBIST_RA_PRSRV_FUSE_VAL(PRESERVE_FUSE_REGISTER), .MBISTPG_ALGO_SEL(BIST_ALGO_SEL[6:0]), 
      .MBISTPG_SELECT_COMMON_ALGO(BIST_SELECT_COMMON_ALGO), .MBISTPG_OPSET_SELECT(BIST_OPSET_SEL), 
      .MBISTPG_SELECT_COMMON_OPSET(BIST_SELECT_COMMON_OPSET), .MBISTPG_DATA_INV_ROW_ADD_BIT_SELECT_EN(BIST_DATA_INV_ROW_ADD_BIT_SELECT_EN), 
      .MBISTPG_DATA_INV_ROW_ADD_BIT_SELECT(BIST_DATA_INV_ROW_ADD_BIT_SEL), .MBISTPG_DATA_INV_COL_ADD_BIT_SELECT_EN(BIST_DATA_INV_COL_ADD_BIT_SELECT_EN), 
      .MBISTPG_DATA_INV_COL_ADD_BIT_SELECT(BIST_DATA_INV_COL_ADD_BIT_SEL), .MBISTPG_ALGO_MODE({
      BIST_ALGO_MODE1, BIST_ALGO_MODE0}), .MBISTPG_MEM_RST(ENABLE_MEM_RESET), .MBISTPG_REDUCED_ADDR_CNT_EN(REDUCED_ADDRESS_COUNT), 
      .MEM_BYPASS_EN(memory_bypass_to_en), .MCP_BOUNDING_EN(mcp_bounding_to_en), 
      .MEM0_BIST_COLLAR_SO(BIST_SO), .MEM1_BIST_COLLAR_SO(BIST_SO_ts1), .MEM2_BIST_COLLAR_SO(BIST_SO_ts10), 
      .MEM3_BIST_COLLAR_SO(BIST_SO_ts11), .MEM4_BIST_COLLAR_SO(BIST_SO_ts2), .MEM5_BIST_COLLAR_SO(BIST_SO_ts3), 
      .MEM6_BIST_COLLAR_SO(BIST_SO_ts4), .MEM7_BIST_COLLAR_SO(BIST_SO_ts5), .MEM8_BIST_COLLAR_SO(BIST_SO_ts6), 
      .MEM9_BIST_COLLAR_SO(BIST_SO_ts7), .MEM10_BIST_COLLAR_SO(BIST_SO_ts8), .MEM11_BIST_COLLAR_SO(BIST_SO_ts9), 
      .FL_CNT_MODE({FL_CNT_MODE1, FL_CNT_MODE0}), .MBISTPG_BIRA_EN(BIRA_EN), .CHECK_REPAIR_NEEDED(CHECK_REPAIR_NEEDED), 
      .BIST_COLLAR_GO({BIST_GO_ts9, BIST_GO_ts8, BIST_GO_ts7, BIST_GO_ts6, 
      BIST_GO_ts5, BIST_GO_ts4, BIST_GO_ts3, BIST_GO_ts11, BIST_GO_ts1, 
      BIST_GO_ts2, BIST_GO_ts10, BIST_GO}), .MBISTPG_DIAG_EN(BIST_DIAG_EN), .BIST_CLK(clk_ts1), 
      .BIST_SI(toBist), .BIST_HOLD(BIST_HOLD), .BIST_SETUP2(BIST_SETUP[2]), .BIST_SETUP(BIST_SETUP[1:0]), 
      .MBISTPG_TESTDATA_SELECT(BIST_SELECT_TEST_DATA), .TCK(to_controllers_tck), 
      .TCK_RETIME(to_controllers_tck_retime), .MBISTPG_EN(bistEn), .MBISTPG_ASYNC_RESETN(BIST_ASYNC_RESET), 
      .LV_TM(ltest_to_en_ts1), .MBISTPG_MEM_ARRAY_DUMP_MODE(MEM_ARRAY_DUMP_MODE), 
      .BIST_CLEAR_BIRA(BIST_CLEAR_BIRA), .MBISTPG_RESET_REG_SETUP2(MBISTPG_RESET_REG_SETUP2), 
      .BIST_COL_ADD(BIST_COL_ADD), .BIST_ROW_ADD(BIST_ROW_ADD[6:0]), .BIST_BANK_ADD(BIST_BANK_ADD[1:0]), 
      .BIST_WRITE_DATA(BIST_WRITE_DATA[31:0]), .BIST_EXPECT_DATA(BIST_EXPECT_DATA[31:0]), 
      .BIST_SHIFT_COLLAR(BIST_SHIFT_COLLAR), .BIST_TESTDATA_SELECT_TO_COLLAR(BIST_TESTDATA_SELECT_TO_COLLAR), 
      .MEM0_BIST_COLLAR_SI(MEM0_BIST_COLLAR_SI), .MEM1_BIST_COLLAR_SI(MEM1_BIST_COLLAR_SI), 
      .MEM2_BIST_COLLAR_SI(MEM2_BIST_COLLAR_SI), .MEM3_BIST_COLLAR_SI(MEM3_BIST_COLLAR_SI), 
      .MEM4_BIST_COLLAR_SI(MEM4_BIST_COLLAR_SI), .MEM5_BIST_COLLAR_SI(MEM5_BIST_COLLAR_SI), 
      .MEM6_BIST_COLLAR_SI(MEM6_BIST_COLLAR_SI), .MEM7_BIST_COLLAR_SI(MEM7_BIST_COLLAR_SI), 
      .MEM8_BIST_COLLAR_SI(MEM8_BIST_COLLAR_SI), .MEM9_BIST_COLLAR_SI(MEM9_BIST_COLLAR_SI), 
      .MEM10_BIST_COLLAR_SI(MEM10_BIST_COLLAR_SI), .MEM11_BIST_COLLAR_SI(MEM11_BIST_COLLAR_SI), 
      .BIST_COLLAR_SETUP(BIST_COLLAR_SETUP), .BIST_COLLAR_OPSET_SELECT(BIST_COLLAR_OPSET_SELECT), 
      .BIST_COLLAR_HOLD(BIST_COLLAR_HOLD), .FREEZE_STOP_ERROR(FREEZE_STOP_ERROR), 
      .ERROR_CNT_ZERO(ERROR_CNT_ZERO), .BIST_COLLAR_DIAG_EN(BIST_COLLAR_DIAG_EN), 
      .BIST_COLLAR_BIRA_EN(BIST_COLLAR_BIRA_EN), .BIST_CLEAR_DEFAULT(BIST_CLEAR_DEFAULT), 
      .BIST_CLEAR(BIST_CLEAR), .MBISTPG_SO(MBISTPG_SO), .BIST_USER9(BIST_USER9), 
      .BIST_USER10(BIST_USER10), .BIST_USER11(BIST_USER11), .BIST_USER0(BIST_USER0), 
      .BIST_USER1(BIST_USER1), .BIST_USER2(BIST_USER2), .BIST_USER3(BIST_USER3), 
      .BIST_USER4(BIST_USER4), .BIST_USER5(BIST_USER5), .BIST_USER6(BIST_USER6), 
      .BIST_USER7(BIST_USER7), .BIST_USER8(BIST_USER8), .BIST_EVEN_GROUPWRITEENABLE(BIST_EVEN_GROUPWRITEENABLE), 
      .BIST_ODD_GROUPWRITEENABLE(BIST_ODD_GROUPWRITEENABLE), .BIST_WRITEENABLE(BIST_WRITEENABLE), 
      .BIST_READENABLE(BIST_READENABLE), .BIST_SELECT(BIST_SELECT), .BIST_CMP(BIST_CMP), 
      .BIST_COLLAR_EN0(BIST_COLLAR_EN0), .BIST_RUN_TO_COLLAR0(BIST_RUN_TO_COLLAR0), 
      .BIST_COLLAR_EN1(BIST_COLLAR_EN1), .BIST_RUN_TO_COLLAR1(BIST_RUN_TO_COLLAR1), 
      .BIST_COLLAR_EN2(BIST_COLLAR_EN2), .BIST_RUN_TO_COLLAR2(BIST_RUN_TO_COLLAR2), 
      .BIST_COLLAR_EN3(BIST_COLLAR_EN3), .BIST_RUN_TO_COLLAR3(BIST_RUN_TO_COLLAR3), 
      .BIST_COLLAR_EN4(BIST_COLLAR_EN4), .BIST_RUN_TO_COLLAR4(BIST_RUN_TO_COLLAR4), 
      .BIST_COLLAR_EN5(BIST_COLLAR_EN5), .BIST_RUN_TO_COLLAR5(BIST_RUN_TO_COLLAR5), 
      .BIST_COLLAR_EN6(BIST_COLLAR_EN6), .BIST_RUN_TO_COLLAR6(BIST_RUN_TO_COLLAR6), 
      .BIST_COLLAR_EN7(BIST_COLLAR_EN7), .BIST_RUN_TO_COLLAR7(BIST_RUN_TO_COLLAR7), 
      .BIST_COLLAR_EN8(BIST_COLLAR_EN8), .BIST_RUN_TO_COLLAR8(BIST_RUN_TO_COLLAR8), 
      .BIST_COLLAR_EN9(BIST_COLLAR_EN9), .BIST_RUN_TO_COLLAR9(BIST_RUN_TO_COLLAR9), 
      .BIST_COLLAR_EN10(BIST_COLLAR_EN10), .BIST_RUN_TO_COLLAR10(BIST_RUN_TO_COLLAR10), 
      .BIST_COLLAR_EN11(BIST_COLLAR_EN11), .BIST_RUN_TO_COLLAR11(BIST_RUN_TO_COLLAR11), 
      .MBISTPG_GO(MBISTPG_GO), .MBISTPG_STABLE(MBISTPG_STABLE), .MBISTPG_DONE(MBISTPG_DONE), 
      .BIST_ON_TO_COLLAR(BIST_ON_TO_COLLAR), .BIST_SHIFT_BIRA_COLLAR(BIST_SHIFT_BIRA_COLLAR), 
      .GO_ID_REG_SEL(GO_ID_REG_SEL), .ALGO_SEL_REG(ALGO_SEL_REG), .fscan_clkungate(fscan_clkungate)
  );

  TS_CLK_MUX tessent_persistent_cell_tck_mux_hlp_mod_apr_tcam_mems_rtl_clk_inst(
      .ck0(clk), .ck1(ijtag_to_tck), .s(tck_select), .o(clk_ts1)
  );

  hlp_mod_apr_tcam_mems_rtl_tessent_mbist_diagnosis_ready hlp_mod_apr_tcam_mems_rtl_tessent_mbist_diagnosis_ready_inst(
      .ijtag_reset(ijtag_to_reset), .ijtag_sel(ijtag_to_sel), .ijtag_si(hlp_mod_apr_tcam_mems_rtl_tessent_mbist_bap_inst_so), 
      .ijtag_ce(ijtag_to_ce), .ijtag_se(ijtag_to_se), .ijtag_ue(ijtag_to_ue), .ijtag_tck(ijtag_to_tck), 
      .ijtag_so(ijtag_so), .DiagnosisReady_ctl_in(MBISTPG_STABLE), .DiagnosisReady_aux_in(1'b1), 
      .StableBlock(mbist_diag_done)
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
      .reset(sync_reset_clk_o), .trigger(trigger_post), .BIST_CLK_IN(clk), .MBISTPG_DONE(sys_test_done_clk), 
      .MBISTPG_GO(sys_test_pass_clk), .busy(busy), .pass(pass), .complete(complete)
  );

  TS_SYNCHRONIZER sync_reset_clk(
      .clk(clk), .d(1'b1), .rst(Intel_reset_sync_polarity_clk_inverter_o1), .o(sync_reset_clk_o_ts1)
  );

  TS_MX sync_reset_clk_reset_bypass_mux(
      .a(fscan_byprst_b), .b(core_rst_b), .sa(fscan_rstbypen), .o(sync_reset_clk_reset_bypass_mux_o)
  );

  TS_INV Intel_reset_sync_polarity_clk_inverter(
      .a(sync_reset_clk_reset_bypass_mux_o), .o1(Intel_reset_sync_polarity_clk_inverter_o1)
  );

  TS_MX sync_reset_clk_reset_output_bypass_mux(
      .a(fscan_byprst_b), .b(sync_reset_clk_o_ts1), .sa(fscan_rstbypen), .o(sync_reset_clk_o)
  );
endmodule

