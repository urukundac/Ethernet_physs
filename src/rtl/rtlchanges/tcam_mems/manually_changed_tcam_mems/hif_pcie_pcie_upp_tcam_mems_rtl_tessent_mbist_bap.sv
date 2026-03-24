//--------------------------------------------------------------------------
//
//  Unpublished work. Copyright 2025 Siemens
//
//  This material contains trade secrets or otherwise confidential 
//  information owned by Siemens Industry Software Inc. or its affiliates 
//  (collectively, SISW), or its licensors. Access to and use of this 
//  information is strictly limited as set forth in the Customer's 
//  applicable agreements with SISW.
//
//--------------------------------------------------------------------------
//  File created by: Tessent Shell
//          Version: 2025.1
//       Created on: Thu Jun 19 03:09:48 PDT 2025
//--------------------------------------------------------------------------

module hif_pcie_pcie_upp_tcam_mems_rtl_tessent_mbist_bap (
// hif_pcie_pcie_upp_tcam_mems_rtl_tessent_mbist_bap {{{
  input wire reset,
  input wire ijtag_select,
  input wire si,
  input wire capture_en,
  input wire shift_en,
  output wire shift_en_R,
  input wire update_en,
  input wire tck,
  output wire to_controllers_tck_retime,
  output wire to_controllers_tck,
  input wire mcp_bounding_en,
  output wire mcp_bounding_to_en,
  input wire scan_en,
  output wire scan_to_en,
  input wire memory_bypass_en,
  output wire memory_bypass_to_en,
  input wire ltest_en,
  output wire ltest_to_en,
  output wire BIST_HOLD,
  input wire [0:0] sys_ctrl_select,
  input wire [6:0] sys_algo_select,
  input wire sys_select_common_algo,
  input wire sys_test_start_nss_hif_clk,
  input wire sys_test_init_nss_hif_clk,
  input wire sys_reset_nss_hif_clk,
  input wire sys_clock_nss_hif_clk,
  output wire sys_test_pass_nss_hif_clk,
  output wire sys_test_done_nss_hif_clk,
  output wire [0:0] sys_ctrl_pass,
  output wire [0:0] sys_ctrl_done,
  output wire ENABLE_MEM_RESET,
  output wire REDUCED_ADDRESS_COUNT,
  output wire BIST_SELECT_TEST_DATA,
  output wire BIST_ALGO_MODE0,
  output wire BIST_ALGO_MODE1,
  input wire sys_incremental_test_mode,
  output wire MEM_ARRAY_DUMP_MODE,
  output wire BIRA_EN,
  output wire BIST_DIAG_EN,
  output wire PRESERVE_FUSE_REGISTER,
  output wire CHECK_REPAIR_NEEDED,
  output wire BIST_ASYNC_RESET,
  output wire FL_CNT_MODE0,
  output wire FL_CNT_MODE1,
  output wire INCLUDE_MEM_RESULTS_REG,
  output wire [2:0] BIST_SETUP,
  output wire [6:0] BIST_ALGO_SEL,
  output wire BIST_SELECT_COMMON_ALGO,
  output wire BIST_OPSET_SEL,
  output wire BIST_SELECT_COMMON_OPSET,
  output wire BIST_DATA_INV_COL_ADD_BIT_SEL,
  output wire BIST_DATA_INV_COL_ADD_BIT_SELECT_EN,
  output wire BIST_DATA_INV_ROW_ADD_BIT_SEL,
  output wire BIST_DATA_INV_ROW_ADD_BIT_SELECT_EN,
  input wire [0:0] MBISTPG_GO,
  input wire [0:0] MBISTPG_DONE,
  output wire [0:0] bistEn,
  output reg [0:0] toBist,
  input wire [0:0] fromBist,
  output wire so
  , input wire fscan_clkungate);
wire [0:0] sib_scan_out;
wire [0:0] sib_bist_en;
wire [0:0] sib_bist_en_reg;
wire [0:0] sib_bist_en_latch;
wire tdr_so;
wire [0:0] serial_access_bist_en;
wire [0:0] parallel_access_bist_en;
wire [0:0] bistEn_int;
wire ENABLE_MEM_RESET_int;
wire REDUCED_ADDRESS_COUNT_int;
wire BIST_SELECT_TEST_DATA_int;
wire BIST_ALGO_MODE0_int;
wire BIST_ALGO_MODE1_int;
wire MEM_ARRAY_DUMP_MODE_int;
wire BIRA_EN_int;
wire BIST_DIAG_EN_int;
wire PRESERVE_FUSE_REGISTER_int;
wire CHECK_REPAIR_NEEDED_int;
wire BIST_ASYNC_RESET_int;
wire FL_CNT_MODE0_int;
wire FL_CNT_MODE1_int;
wire INCLUDE_MEM_RESULTS_REG_int;
wire CHAIN_BYPASS_EN;
wire CHAIN_BYPASS_EN_int;
wire CHAIN_BYPASS_EN_reg;
wire [2:0] BIST_SETUP_int;
wire [2:0] BIST_SETUP_reg;
wire [6:0] BIST_ALGO_SEL_int;
wire BIST_SELECT_COMMON_ALGO_int;
wire BIST_OPSET_SEL_int;
wire BIST_SELECT_COMMON_OPSET_int;
wire BIST_DATA_INV_COL_ADD_BIT_SEL_int;
wire BIST_DATA_INV_COL_ADD_BIT_SELECT_EN_int;
wire BIST_DATA_INV_ROW_ADD_BIT_SEL_int;
wire BIST_DATA_INV_ROW_ADD_BIT_SELECT_EN_int;

  wire clock_gating_qualifier_and_o, clock_gating_qualifier_and_1_o;
assign ltest_to_en         = ltest_en;
assign memory_bypass_to_en = memory_bypass_en;
assign scan_to_en          = scan_en;
assign mcp_bounding_to_en  = mcp_bounding_en;
 
// TDR_short instance {{{
wire tdr_short_so;
wire memory_mfg_test;
hif_pcie_pcie_upp_tcam_mems_rtl_tessent_mbist_bap_tdr_short tdr_inst_short (
  .reset            (reset),
  .ijtag_select     (ijtag_select),
  .si               (si),
  .capture_en       (capture_en),
  .shift_en         (shift_en),
  .update_en        (update_en),
  .tck              (tck),
  .memory_mfg_test  (memory_mfg_test),
  .so               (tdr_short_so)
);
// TDR_short instance }}}
// TDR instance {{{
wire ijtag_select_bap_tdr;
hif_pcie_pcie_upp_tcam_mems_rtl_tessent_mbist_bap_tdr tdr_inst (
  .reset            (reset),
  .ijtag_select     (ijtag_select_bap_tdr),
  .si               (tdr_short_so),
  .capture_en       (capture_en),
  .shift_en         (shift_en),
  .update_en        (update_en),
  .tck              (tck),
  .ltest_en         (ltest_en),
  .ENABLE_MEM_RESET ( ENABLE_MEM_RESET_int ),
  .REDUCED_ADDRESS_COUNT( REDUCED_ADDRESS_COUNT_int ),
  .BIST_SELECT_TEST_DATA( BIST_SELECT_TEST_DATA_int ),
  .BIST_ALGO_MODE0  ( BIST_ALGO_MODE0_int ),
  .BIST_ALGO_MODE1  ( BIST_ALGO_MODE1_int ),
  .MEM_ARRAY_DUMP_MODE( MEM_ARRAY_DUMP_MODE_int ),
  .BIRA_EN          ( BIRA_EN_int ),
  .BIST_DIAG_EN     ( BIST_DIAG_EN_int ),
  .PRESERVE_FUSE_REGISTER( PRESERVE_FUSE_REGISTER_int ),
  .CHECK_REPAIR_NEEDED( CHECK_REPAIR_NEEDED_int ),
  .BIST_ASYNC_RESET ( BIST_ASYNC_RESET_int ),
  .FL_CNT_MODE0     ( FL_CNT_MODE0_int ),
  .FL_CNT_MODE1     ( FL_CNT_MODE1_int ),
  .INCLUDE_MEM_RESULTS_REG( INCLUDE_MEM_RESULTS_REG_int ),
  .CHAIN_BYPASS_EN  ( CHAIN_BYPASS_EN_int ),
  .CHAIN_BYPASS_EN_reg( CHAIN_BYPASS_EN_reg ),
  .BIST_SETUP       ( BIST_SETUP_int ),
  .BIST_SETUP_reg   ( BIST_SETUP_reg ),
  .BIST_ALGO_SEL    ( BIST_ALGO_SEL_int ),
  .BIST_SELECT_COMMON_ALGO( BIST_SELECT_COMMON_ALGO_int ),
  .BIST_OPSET_SEL   ( BIST_OPSET_SEL_int ),
  .BIST_SELECT_COMMON_OPSET( BIST_SELECT_COMMON_OPSET_int ),
  .BIST_DATA_INV_COL_ADD_BIT_SEL( BIST_DATA_INV_COL_ADD_BIT_SEL_int ),
  .BIST_DATA_INV_COL_ADD_BIT_SELECT_EN( BIST_DATA_INV_COL_ADD_BIT_SELECT_EN_int ),
  .BIST_DATA_INV_ROW_ADD_BIT_SEL( BIST_DATA_INV_ROW_ADD_BIT_SEL_int ),
  .BIST_DATA_INV_ROW_ADD_BIT_SELECT_EN( BIST_DATA_INV_ROW_ADD_BIT_SELECT_EN_int ),
  .so               (tdr_so)
);
// TDR instance }}}
wire serial_access_bist_async_reset;
assign  serial_access_bist_async_reset =  BIST_ASYNC_RESET_int;
wire serial_access_bist_setup;
assign  serial_access_bist_setup = BIST_SETUP_int[1];
// SIB hif_pcie_pcie_upp_tcam_mems_rtl_tessent_mbist_controller_sib_tdr_bypass_inst instance {{{
wire tdr_bypass_so;
hif_pcie_pcie_upp_tcam_mems_rtl_tessent_mbist_bap_sib hif_pcie_pcie_upp_tcam_mems_rtl_tessent_mbist_controller_sib_tdr_bypass_inst (
  .reset             (reset),
  .si                (tdr_short_so),
  .capture_en        (capture_en),
  .shift_en          (shift_en),
  .update_en         (update_en),
  .tck               (tck),
  .ijtag_select      (ijtag_select),
  .ijtag_to_select   (ijtag_select_bap_tdr),
  .ijtag_to_select_reg  ( ),
  .from_scan_out     (tdr_so),
  .so                (tdr_bypass_so)); 
// SIB hif_pcie_pcie_upp_tcam_mems_rtl_tessent_mbist_controller_sib_tdr_bypass_inst instance }}}
wire ChainBypassMode_int;
assign ChainBypassMode_int = CHAIN_BYPASS_EN | serial_access_bist_setup;
reg [0:0] fromBist_retime;
wire ijtag_select_ctl_sib;
wire ijtag_select_ctl_sib_reg;
// SIB 0 instance {{{
hif_pcie_pcie_upp_tcam_mems_rtl_tessent_mbist_bap_ctl_sib hif_pcie_pcie_upp_tcam_mems_rtl_tessent_mbist_controller_sib_inst0 (
  .reset             (reset),
  .si                (tdr_bypass_so),
  .capture_en        (capture_en),
  .shift_en          (shift_en),
  .update_en         (update_en),
  .tck               (tck),
  .bist_go           (MBISTPG_GO[0]), 
  .bist_done         (MBISTPG_DONE[0]), 
  .ijtag_select      (ijtag_select_ctl_sib),
  .bistEn            (sib_bist_en[0]),
  .bistEn_reg        (sib_bist_en_reg[0]),
  .bistEn_latch      (sib_bist_en_latch[0]),
  .from_scan_out     (fromBist_retime[0]),
  .ChainBypassMode   (ChainBypassMode_int),
  .so                (sib_scan_out[0])); 
 
// SIB 0 instance }}}
assign serial_access_bist_en[0] = sib_bist_en[0]; 
// SIB hif_pcie_pcie_upp_tcam_mems_rtl_tessent_mbist_controller_sib_ctl_bypass_inst instance {{{
wire sib_ctl_bypass_so;
hif_pcie_pcie_upp_tcam_mems_rtl_tessent_mbist_bap_sib hif_pcie_pcie_upp_tcam_mems_rtl_tessent_mbist_controller_sib_ctl_bypass_inst (
  .reset             (reset),
  .si                (tdr_bypass_so),
  .capture_en        (capture_en),
  .shift_en          (shift_en),
  .update_en         (update_en),
  .tck               (tck),
  .ijtag_select      (ijtag_select),
  .ijtag_to_select   (ijtag_select_ctl_sib ),
  .ijtag_to_select_reg  (ijtag_select_ctl_sib_reg ),
  .from_scan_out     (sib_scan_out[0]),
  .so                (sib_ctl_bypass_so)); 
 
// SIB hif_pcie_pcie_upp_tcam_mems_rtl_tessent_mbist_controller_sib_ctl_bypass_inst instance }}}
// --------- Bist hold  ---------
// [start] : BistHold pipeline {{{
wire BIST_HOLD_to_latch;
reg BIST_HOLD_latch;
assign BIST_HOLD_to_latch = ijtag_select_ctl_sib_reg & (~BIST_SETUP_reg[1]) & (~CHAIN_BYPASS_EN_reg) & (|sib_bist_en_reg) & memory_mfg_test ;
always_ff @ (negedge tck or negedge reset) begin
  if (~reset) begin
    BIST_HOLD_latch     <= 1'b0;
  end else if (update_en & ijtag_select) begin
    BIST_HOLD_latch     <= BIST_HOLD_to_latch;
  end
end
// [end]   : BistHold pipeline }}}
wire to_mbist_tck_en;
wire to_mbist_tck_retime_en;
wire mbist_setup_en;
assign mbist_setup_en = ijtag_select_ctl_sib & (~ChainBypassMode_int) & (|sib_bist_en_latch) & memory_mfg_test;
assign to_mbist_tck_en = shift_en & mbist_setup_en;
assign to_mbist_tck_retime_en = (shift_en | capture_en) & mbist_setup_en;
assign shift_en_R = ijtag_select_ctl_sib & shift_en & (~ChainBypassMode_int) & (|sib_bist_en_latch) & memory_mfg_test;
reg                 retiming_so ;
always_ff @ (negedge tck) begin 
  retiming_so <= sib_ctl_bypass_so;
end
always_ff @ (negedge tck) begin 
  fromBist_retime <= fromBist;
end
assign so = retiming_so;
always_ff @ (negedge tck) begin 
  toBist[0] <= tdr_bypass_so;
end
// --------- to_controllers_tck (inversion) -----------
wire tck_out_gated;
wire tck_retime_out_gated;
TS_CLK_GATING_AND tessent_persistent_cell_GATING_TCK (
  .clk              (tck),
  .ten              (clock_gating_qualifier_and_o),
  .fen              (to_mbist_tck_en),
  .clkcg            (tck_out_gated)
);
TS_CLK_GATING_AND tessent_persistent_cell_GATING_TCK_RETIME (
  .clk              (tck),
  .ten              (clock_gating_qualifier_and_1_o),
  .fen              (to_mbist_tck_retime_en),
  .clkcg            (tck_retime_out_gated)
);
  TS_CLK_BUF tessent_persistent_cell_BUF_C_TCK (
    .clk             (tck_out_gated),
    .o               (to_controllers_tck)
  );
  TS_CLK_BUF tessent_persistent_cell_BUF_C_TCK_RETIME (
    .clk             (tck_retime_out_gated),
    .o               (to_controllers_tck_retime)
  );
//direct access sequencer instance {{{
wire pas_bist_async_reset,pas_bist_setup,pas_bist_en, pas_bist_en_pipe, pas_bist_clk_en;
hif_pcie_pcie_upp_tcam_mems_rtl_tessent_mbist_bap_start_stop_sequencer parallel_access_start_stop_sequencer (
  .reset(sys_reset_nss_hif_clk),
  .clk(sys_clock_nss_hif_clk),
  .test_start(sys_test_start_nss_hif_clk),  
  .test_init(sys_test_init_nss_hif_clk),
  .mcp_bounding_en(mcp_bounding_en),
  .bist_async_reset(pas_bist_async_reset),
  .bist_setup(pas_bist_setup),
  .bist_clk_en(pas_bist_clk_en),
  .bist_en(pas_bist_en),  
  .bist_en_pipe(pas_bist_en_pipe)  
);
//direct access sequencer instance }}}
// direct access  muxes for bist_async_reset bist_clk_en  {{{ 
wire BIST_ASYNC_RESET_to_buf;
TS_MX tessent_persistent_cell_bist_async_reset_mux (
  .sa               (memory_mfg_test|ltest_en ),
  .a                (serial_access_bist_async_reset),
  .b                (pas_bist_async_reset),
  .o                (BIST_ASYNC_RESET_to_buf));
TS_BUF tessent_persistent_cell_BIST_ASYNC_RESET (.a(BIST_ASYNC_RESET_to_buf),.o(BIST_ASYNC_RESET));
// direct access  muxes for bist_async_reset bist_clk_en  }}} 
 
// direct access muxes for control signals {{{
TS_BUF tessent_persistent_cell_ENABLE_MEM_RESET_buf (.a(ENABLE_MEM_RESET_int),.o(ENABLE_MEM_RESET));
TS_BUF tessent_persistent_cell_REDUCED_ADDRESS_COUNT_buf (.a(REDUCED_ADDRESS_COUNT_int),.o(REDUCED_ADDRESS_COUNT));
wire BIST_SELECT_TEST_DATA_to_buf;
TS_BUF tessent_persistent_cell_BIST_SELECT_TEST_DATA_buf (.a(BIST_SELECT_TEST_DATA_to_buf),.o(BIST_SELECT_TEST_DATA));
TS_MX tessent_persistent_cell_bist_select_test_data_mux (
  .sa               (memory_mfg_test),
  .a                (BIST_SELECT_TEST_DATA_int),
  .b                (1'b0),
  .o                (BIST_SELECT_TEST_DATA_to_buf));

wire BIST_ALGO_MODE0_to_buf;
TS_BUF tessent_persistent_cell_BIST_ALGO_MODE0_buf (.a(BIST_ALGO_MODE0_to_buf),.o(BIST_ALGO_MODE0));
TS_MX tessent_persistent_cell_bist_algo_mode0_mux (
  .sa               (memory_mfg_test),
  .a                (BIST_ALGO_MODE0_int),
  .b                (1'b0),
  .o                (BIST_ALGO_MODE0_to_buf));

wire BIST_ALGO_MODE1_to_buf;
TS_BUF tessent_persistent_cell_BIST_ALGO_MODE1_buf (.a(BIST_ALGO_MODE1_to_buf),.o(BIST_ALGO_MODE1));
TS_MX tessent_persistent_cell_bist_algo_mode1_mux (
  .sa               (memory_mfg_test),
  .a                (BIST_ALGO_MODE1_int),
  .b                (1'b0),
  .o                (BIST_ALGO_MODE1_to_buf));

wire MEM_ARRAY_DUMP_MODE_to_buf;
TS_BUF tessent_persistent_cell_MEM_ARRAY_DUMP_MODE_buf (.a(MEM_ARRAY_DUMP_MODE_to_buf),.o(MEM_ARRAY_DUMP_MODE));
TS_MX tessent_persistent_cell_mem_array_dump_mode_mux (
  .sa               (memory_mfg_test),
  .a                (MEM_ARRAY_DUMP_MODE_int),
  .b                (sys_incremental_test_mode),
  .o                (MEM_ARRAY_DUMP_MODE_to_buf));

wire BIRA_EN_to_buf;
TS_BUF tessent_persistent_cell_BIRA_EN_buf (.a(BIRA_EN_to_buf),.o(BIRA_EN));
TS_MX tessent_persistent_cell_bira_en_mux (
  .sa               (memory_mfg_test),
  .a                (BIRA_EN_int),
  .b                (1'b0),
  .o                (BIRA_EN_to_buf));

TS_BUF tessent_persistent_cell_BIST_DIAG_EN_buf (.a(BIST_DIAG_EN_int),.o(BIST_DIAG_EN));
wire PRESERVE_FUSE_REGISTER_to_buf;
TS_BUF tessent_persistent_cell_PRESERVE_FUSE_REGISTER_buf (.a(PRESERVE_FUSE_REGISTER_to_buf),.o(PRESERVE_FUSE_REGISTER));
TS_MX tessent_persistent_cell_preserve_fuse_register_mux (
  .sa               (memory_mfg_test),
  .a                (PRESERVE_FUSE_REGISTER_int),
  .b                (1'b0),
  .o                (PRESERVE_FUSE_REGISTER_to_buf));

wire CHECK_REPAIR_NEEDED_to_buf;
TS_BUF tessent_persistent_cell_CHECK_REPAIR_NEEDED_buf (.a(CHECK_REPAIR_NEEDED_to_buf),.o(CHECK_REPAIR_NEEDED));
TS_MX tessent_persistent_cell_check_repair_needed_mux (
  .sa               (memory_mfg_test),
  .a                (CHECK_REPAIR_NEEDED_int),
  .b                (1'b0),
  .o                (CHECK_REPAIR_NEEDED_to_buf));

TS_BUF tessent_persistent_cell_FL_CNT_MODE0_buf (.a(FL_CNT_MODE0_int),.o(FL_CNT_MODE0));
TS_BUF tessent_persistent_cell_FL_CNT_MODE1_buf (.a(FL_CNT_MODE1_int),.o(FL_CNT_MODE1));
TS_BUF tessent_persistent_cell_INCLUDE_MEM_RESULTS_REG_buf (.a(INCLUDE_MEM_RESULTS_REG_int),.o(INCLUDE_MEM_RESULTS_REG));
TS_BUF tessent_persistent_cell_CHAIN_BYPASS_EN_buf (.a(CHAIN_BYPASS_EN_int),.o(CHAIN_BYPASS_EN));
TS_BUF tessent_persistent_cell_BIST_SETUP_2_buf (.a(BIST_SETUP_int[2]),.o(BIST_SETUP[2]));
wire    BIST_SETUP1_buf;
TS_MX tessent_persistent_cell_bist_setup_mux (
  .sa               (memory_mfg_test),
  .a                (serial_access_bist_setup),
  .b                (pas_bist_setup),
  .o                (BIST_SETUP1_buf));
TS_BUF tessent_persistent_cell_BIST_SETUP_1_buf (.a(BIST_SETUP1_buf),.o(BIST_SETUP[1]));
TS_BUF tessent_persistent_cell_BIST_SETUP_0_buf (.a(BIST_SETUP_int[0]),.o(BIST_SETUP[0]));
wire BIST_ALGO_SEL_0_to_buf;
TS_BUF tessent_persistent_cell_BIST_ALGO_SEL_0_buf (.a(BIST_ALGO_SEL_0_to_buf),.o(BIST_ALGO_SEL[0]));
TS_MX tessent_persistent_cell_bist_algo_sel0_mux (
  .sa               (memory_mfg_test),
  .a                (BIST_ALGO_SEL_int[0]),
  .b                (sys_algo_select[0]),
  .o                (BIST_ALGO_SEL_0_to_buf));
wire BIST_ALGO_SEL_1_to_buf;
TS_BUF tessent_persistent_cell_BIST_ALGO_SEL_1_buf (.a(BIST_ALGO_SEL_1_to_buf),.o(BIST_ALGO_SEL[1]));
TS_MX tessent_persistent_cell_bist_algo_sel1_mux (
  .sa               (memory_mfg_test),
  .a                (BIST_ALGO_SEL_int[1]),
  .b                (sys_algo_select[1]),
  .o                (BIST_ALGO_SEL_1_to_buf));
wire BIST_ALGO_SEL_2_to_buf;
TS_BUF tessent_persistent_cell_BIST_ALGO_SEL_2_buf (.a(BIST_ALGO_SEL_2_to_buf),.o(BIST_ALGO_SEL[2]));
TS_MX tessent_persistent_cell_bist_algo_sel2_mux (
  .sa               (memory_mfg_test),
  .a                (BIST_ALGO_SEL_int[2]),
  .b                (sys_algo_select[2]),
  .o                (BIST_ALGO_SEL_2_to_buf));
wire BIST_ALGO_SEL_3_to_buf;
TS_BUF tessent_persistent_cell_BIST_ALGO_SEL_3_buf (.a(BIST_ALGO_SEL_3_to_buf),.o(BIST_ALGO_SEL[3]));
TS_MX tessent_persistent_cell_bist_algo_sel3_mux (
  .sa               (memory_mfg_test),
  .a                (BIST_ALGO_SEL_int[3]),
  .b                (sys_algo_select[3]),
  .o                (BIST_ALGO_SEL_3_to_buf));
wire BIST_ALGO_SEL_4_to_buf;
TS_BUF tessent_persistent_cell_BIST_ALGO_SEL_4_buf (.a(BIST_ALGO_SEL_4_to_buf),.o(BIST_ALGO_SEL[4]));
TS_MX tessent_persistent_cell_bist_algo_sel4_mux (
  .sa               (memory_mfg_test),
  .a                (BIST_ALGO_SEL_int[4]),
  .b                (sys_algo_select[4]),
  .o                (BIST_ALGO_SEL_4_to_buf));
wire BIST_ALGO_SEL_5_to_buf;
TS_BUF tessent_persistent_cell_BIST_ALGO_SEL_5_buf (.a(BIST_ALGO_SEL_5_to_buf),.o(BIST_ALGO_SEL[5]));
TS_MX tessent_persistent_cell_bist_algo_sel5_mux (
  .sa               (memory_mfg_test),
  .a                (BIST_ALGO_SEL_int[5]),
  .b                (sys_algo_select[5]),
  .o                (BIST_ALGO_SEL_5_to_buf));
wire BIST_ALGO_SEL_6_to_buf;
TS_BUF tessent_persistent_cell_BIST_ALGO_SEL_6_buf (.a(BIST_ALGO_SEL_6_to_buf),.o(BIST_ALGO_SEL[6]));
TS_MX tessent_persistent_cell_bist_algo_sel6_mux (
  .sa               (memory_mfg_test),
  .a                (BIST_ALGO_SEL_int[6]),
  .b                (sys_algo_select[6]),
  .o                (BIST_ALGO_SEL_6_to_buf));

wire BIST_SELECT_COMMON_ALGO_to_buf;
TS_BUF tessent_persistent_cell_BIST_SELECT_COMMON_ALGO_buf (.a(BIST_SELECT_COMMON_ALGO_to_buf),.o(BIST_SELECT_COMMON_ALGO));
TS_MX tessent_persistent_cell_bist_select_common_algo_mux (
  .sa               (memory_mfg_test),
  .a                (BIST_SELECT_COMMON_ALGO_int),
  .b                (sys_select_common_algo),
  .o                (BIST_SELECT_COMMON_ALGO_to_buf));

wire BIST_OPSET_SEL_to_buf;
TS_BUF tessent_persistent_cell_BIST_OPSET_SEL_buf (.a(BIST_OPSET_SEL_to_buf),.o(BIST_OPSET_SEL));
TS_MX tessent_persistent_cell_bist_opset_sel_mux (
  .sa               (memory_mfg_test),
  .a                (BIST_OPSET_SEL_int),
  .b                (1'b0),
  .o                (BIST_OPSET_SEL_to_buf));

wire BIST_SELECT_COMMON_OPSET_to_buf;
TS_BUF tessent_persistent_cell_BIST_SELECT_COMMON_OPSET_buf (.a(BIST_SELECT_COMMON_OPSET_to_buf),.o(BIST_SELECT_COMMON_OPSET));
TS_MX tessent_persistent_cell_bist_select_common_opset_mux (
  .sa               (memory_mfg_test),
  .a                (BIST_SELECT_COMMON_OPSET_int),
  .b                (1'b0),
  .o                (BIST_SELECT_COMMON_OPSET_to_buf));

wire BIST_DATA_INV_COL_ADD_BIT_SEL_to_buf;
TS_BUF tessent_persistent_cell_BIST_DATA_INV_COL_ADD_BIT_SEL_buf (.a(BIST_DATA_INV_COL_ADD_BIT_SEL_to_buf),.o(BIST_DATA_INV_COL_ADD_BIT_SEL));
TS_MX tessent_persistent_cell_bist_data_inv_col_add_bit_sel_mux (
  .sa               (memory_mfg_test),
  .a                (BIST_DATA_INV_COL_ADD_BIT_SEL_int),
  .b                (1'b0),
  .o                (BIST_DATA_INV_COL_ADD_BIT_SEL_to_buf));

wire BIST_DATA_INV_COL_ADD_BIT_SELECT_EN_to_buf;
TS_BUF tessent_persistent_cell_BIST_DATA_INV_COL_ADD_BIT_SELECT_EN_buf (.a(BIST_DATA_INV_COL_ADD_BIT_SELECT_EN_to_buf),.o(BIST_DATA_INV_COL_ADD_BIT_SELECT_EN));
TS_MX tessent_persistent_cell_bist_data_inv_col_add_bit_select_en_mux (
  .sa               (memory_mfg_test),
  .a                (BIST_DATA_INV_COL_ADD_BIT_SELECT_EN_int),
  .b                (1'b0),
  .o                (BIST_DATA_INV_COL_ADD_BIT_SELECT_EN_to_buf));

wire BIST_DATA_INV_ROW_ADD_BIT_SEL_to_buf;
TS_BUF tessent_persistent_cell_BIST_DATA_INV_ROW_ADD_BIT_SEL_buf (.a(BIST_DATA_INV_ROW_ADD_BIT_SEL_to_buf),.o(BIST_DATA_INV_ROW_ADD_BIT_SEL));
TS_MX tessent_persistent_cell_bist_data_inv_row_add_bit_sel_mux (
  .sa               (memory_mfg_test),
  .a                (BIST_DATA_INV_ROW_ADD_BIT_SEL_int),
  .b                (1'b0),
  .o                (BIST_DATA_INV_ROW_ADD_BIT_SEL_to_buf));

wire BIST_DATA_INV_ROW_ADD_BIT_SELECT_EN_to_buf;
TS_BUF tessent_persistent_cell_BIST_DATA_INV_ROW_ADD_BIT_SELECT_EN_buf (.a(BIST_DATA_INV_ROW_ADD_BIT_SELECT_EN_to_buf),.o(BIST_DATA_INV_ROW_ADD_BIT_SELECT_EN));
TS_MX tessent_persistent_cell_bist_data_inv_row_add_bit_select_en_mux (
  .sa               (memory_mfg_test),
  .a                (BIST_DATA_INV_ROW_ADD_BIT_SELECT_EN_int),
  .b                (1'b0),
  .o                (BIST_DATA_INV_ROW_ADD_BIT_SELECT_EN_to_buf));

// direct access muxes for control signals }}} 
// direct access  bist_en mux  {{{
assign parallel_access_bist_en[0] = sys_ctrl_select[0] &pas_bist_en;
TS_MX tessent_persistent_cell_bist_en0_mux (
  .sa               (memory_mfg_test),
  .a                (serial_access_bist_en[0]),
  .b                (parallel_access_bist_en[0]),
  .o                (bistEn_int[0]));
// direct access bist_en mux }}} 
assign sys_ctrl_pass = MBISTPG_GO;
assign sys_ctrl_done = MBISTPG_DONE;
// global go and done  {{{
wire global_go_done_en;
assign global_go_done_en =~pas_bist_async_reset | pas_bist_en_pipe;
wire [0:0] controller_go_done_en;
assign controller_go_done_en[0] = ~(~pas_bist_async_reset | bistEn[0]); 
assign sys_test_pass_nss_hif_clk = global_go_done_en&(controller_go_done_en[0]|MBISTPG_GO[0]);
assign sys_test_done_nss_hif_clk = global_go_done_en&(controller_go_done_en[0]|MBISTPG_DONE[0]);
// global go and done }}} 
 
// --------- Persistent Buffers for SDC anchors -----------
TS_BUF tessent_persistent_cell_bistEn_0 (.a(bistEn_int[0]),.o(bistEn[0]));
TS_BUF tessent_persistent_cell_BIST_HOLD (.a(BIST_HOLD_latch),.o(BIST_HOLD));
// hif_pcie_pcie_upp_tcam_mems_rtl_tessent_mbist_bap }}}

  TS_AND clock_gating_qualifier_and(
      .a(fscan_clkungate), .b(ltest_en), .o(clock_gating_qualifier_and_o)
  );

  TS_AND clock_gating_qualifier_and_1(
      .a(fscan_clkungate), .b(ltest_en), .o(clock_gating_qualifier_and_1_o)
  );
endmodule
 
module hif_pcie_pcie_upp_tcam_mems_rtl_tessent_mbist_bap_tdr (
// hif_pcie_pcie_upp_tcam_mems_rtl_tessent_mbist_bap_tdr {{{
  input wire reset,
  input wire ijtag_select,
  input wire si,
  input wire capture_en,
  input wire shift_en,
  input wire update_en,
  input wire tck,
  input wire ltest_en,
  output wire ENABLE_MEM_RESET,
  output wire REDUCED_ADDRESS_COUNT,
  output wire BIST_SELECT_TEST_DATA,
  output wire BIST_ALGO_MODE0,
  output wire BIST_ALGO_MODE1,
  output wire MEM_ARRAY_DUMP_MODE,
  output wire BIRA_EN,
  output wire BIST_DIAG_EN,
  output wire PRESERVE_FUSE_REGISTER,
  output wire CHECK_REPAIR_NEEDED,
  output wire BIST_ASYNC_RESET,
  output wire FL_CNT_MODE0,
  output wire FL_CNT_MODE1,
  output wire INCLUDE_MEM_RESULTS_REG,
  output wire CHAIN_BYPASS_EN,
  output wire CHAIN_BYPASS_EN_reg,
  output wire [2:0] BIST_SETUP,
  output wire [2:0] BIST_SETUP_reg,
  output wire [6:0] BIST_ALGO_SEL,
  output wire BIST_SELECT_COMMON_ALGO,
  output wire BIST_OPSET_SEL,
  output wire BIST_SELECT_COMMON_OPSET,
  output wire BIST_DATA_INV_COL_ADD_BIT_SEL,
  output wire BIST_DATA_INV_COL_ADD_BIT_SELECT_EN,
  output wire BIST_DATA_INV_ROW_ADD_BIT_SEL,
  output wire BIST_DATA_INV_ROW_ADD_BIT_SELECT_EN,
  output wire so
);
// Shift Register {{{
reg    [31:0]       tdr;
reg                 tdr_latch31;
reg                 tdr_latch30;
reg                 tdr_latch29;
reg                 tdr_latch28;
reg                 tdr_latch27;
reg                 tdr_latch26;
reg                 tdr_latch25;
reg                 tdr_latch24;
reg                 tdr_latch23;
reg                 tdr_latch22;
reg                 tdr_latch21;
reg                 tdr_latch20;
reg                 tdr_latch19;
reg                 tdr_latch18;
reg                 tdr_latch17;
reg                 tdr_latch16;
reg                 tdr_latch15;
reg                 tdr_latch14;
reg                 tdr_latch13;
reg                 tdr_latch12;
reg                 tdr_latch11;
reg                 tdr_latch10;
reg                 tdr_latch9;
reg                 tdr_latch8;
reg                 tdr_latch7;
reg                 tdr_latch6;
reg                 tdr_latch5;
reg                 tdr_latch4;
reg                 tdr_latch3;
reg                 tdr_latch2;
reg                 tdr_latch1;
reg                 tdr_latch0;
always_ff @ (posedge tck) begin
  if (capture_en & ijtag_select) begin
    tdr <= { tdr_latch31,
             tdr_latch30,
             tdr_latch29,
             tdr_latch28,
             tdr_latch27,
             tdr_latch26,
             tdr_latch25,
             tdr_latch24,
             tdr_latch23,
             tdr_latch22,
             tdr_latch21,
             tdr_latch20,
             tdr_latch19,
             tdr_latch18,
             tdr_latch17,
             tdr_latch16,
             tdr_latch15,
             tdr_latch14,
             tdr_latch13,
             tdr_latch12,
             tdr_latch11,
             tdr_latch10,
             tdr_latch9,
             tdr_latch8,
             tdr_latch7,
             tdr_latch6,
             tdr_latch5,
             tdr_latch4,
             tdr_latch3,
             tdr_latch2,
             tdr_latch1,
             tdr_latch0};
  end else if (shift_en & ijtag_select) begin
    tdr <= {si,tdr[31:1]};
  end
end
// Shift Register }}}
// Update Latches {{{
// --------- DataOutPort 31 ---------
always_ff @ (negedge tck or negedge reset) begin
  if (~reset) begin
    tdr_latch31 <= 1'b0;
  end else begin
    if (update_en & ijtag_select) begin
      tdr_latch31 <= tdr[31];
    end
  end
end
// --------- DataOutPort 30 ---------
always_ff @ (negedge tck or negedge reset) begin
  if (~reset) begin
    tdr_latch30 <= 1'b0;
  end else begin
    if (update_en & ijtag_select) begin
      tdr_latch30 <= tdr[30];
    end
  end
end
// --------- DataOutPort 29 ---------
always_ff @ (negedge tck or negedge reset) begin
  if (~reset) begin
    tdr_latch29 <= 1'b0;
  end else begin
    if (update_en & ijtag_select) begin
      tdr_latch29 <= tdr[29];
    end
  end
end
// --------- DataOutPort 28 ---------
always_ff @ (negedge tck or negedge reset) begin
  if (~reset) begin
    tdr_latch28 <= 1'b0;
  end else begin
    if (update_en & ijtag_select) begin
      tdr_latch28 <= tdr[28];
    end
  end
end
// --------- DataOutPort 27 ---------
always_ff @ (negedge tck or negedge reset) begin
  if (~reset) begin
    tdr_latch27 <= 1'b0;
  end else begin
    if (update_en & ijtag_select) begin
      tdr_latch27 <= tdr[27];
    end
  end
end
// --------- DataOutPort 26 ---------
always_ff @ (negedge tck or negedge reset) begin
  if (~reset) begin
    tdr_latch26 <= 1'b0;
  end else begin
    if (update_en & ijtag_select) begin
      tdr_latch26 <= tdr[26];
    end
  end
end
// --------- DataOutPort 25 ---------
always_ff @ (negedge tck or negedge reset) begin
  if (~reset) begin
    tdr_latch25 <= 1'b0;
  end else begin
    if (update_en & ijtag_select) begin
      tdr_latch25 <= tdr[25];
    end
  end
end
// --------- DataOutPort 24 ---------
always_ff @ (negedge tck or negedge reset) begin
  if (~reset) begin
    tdr_latch24 <= 1'b0;
  end else begin
    if (update_en & ijtag_select) begin
      tdr_latch24 <= tdr[24];
    end
  end
end
// --------- DataOutPort 23 ---------
always_ff @ (negedge tck or negedge reset) begin
  if (~reset) begin
    tdr_latch23 <= 1'b0;
  end else begin
    if (update_en & ijtag_select) begin
      tdr_latch23 <= tdr[23];
    end
  end
end
// --------- DataOutPort 22 ---------
always_ff @ (negedge tck or negedge reset) begin
  if (~reset) begin
    tdr_latch22 <= 1'b0;
  end else begin
    if (update_en & ijtag_select) begin
      tdr_latch22 <= tdr[22];
    end
  end
end
// --------- DataOutPort 21 ---------
always_ff @ (negedge tck or negedge reset) begin
  if (~reset) begin
    tdr_latch21 <= 1'b0;
  end else begin
    if (update_en & ijtag_select) begin
      tdr_latch21 <= tdr[21];
    end
  end
end
// --------- DataOutPort 20 ---------
always_ff @ (negedge tck or negedge reset) begin
  if (~reset) begin
    tdr_latch20 <= 1'b0;
  end else begin
    if (update_en & ijtag_select) begin
      tdr_latch20 <= tdr[20];
    end
  end
end
// --------- DataOutPort 19 ---------
always_ff @ (negedge tck or negedge reset) begin
  if (~reset) begin
    tdr_latch19 <= 1'b0;
  end else begin
    if (update_en & ijtag_select) begin
      tdr_latch19 <= tdr[19];
    end
  end
end
// --------- DataOutPort 18 ---------
always_ff @ (negedge tck or negedge reset) begin
  if (~reset) begin
    tdr_latch18 <= 1'b0;
  end else begin
    if (update_en & ijtag_select) begin
      tdr_latch18 <= tdr[18];
    end
  end
end
// --------- DataOutPort 17 ---------
always_ff @ (negedge tck or negedge reset) begin
  if (~reset) begin
    tdr_latch17 <= 1'b0;
  end else begin
    if (update_en & ijtag_select) begin
      tdr_latch17 <= tdr[17];
    end
  end
end
// --------- DataOutPort 16 ---------
always_ff @ (negedge tck or negedge reset) begin
  if (~reset) begin
    tdr_latch16 <= 1'b0;
  end else begin
    if (update_en & ijtag_select) begin
      tdr_latch16 <= tdr[16];
    end
  end
end
// --------- DataOutPort 15 ---------
always_ff @ (negedge tck or negedge reset) begin
  if (~reset) begin
    tdr_latch15 <= 1'b0;
  end else begin
    if (update_en & ijtag_select) begin
      tdr_latch15 <= tdr[15];
    end
  end
end
// --------- DataOutPort 14 ---------
always_ff @ (negedge tck or negedge reset) begin
  if (~reset) begin
    tdr_latch14 <= 1'b1;
  end else begin
    if (update_en & ijtag_select) begin
      tdr_latch14 <= tdr[14];
    end
  end
end
// --------- DataOutPort 13 ---------
always_ff @ (negedge tck or negedge reset) begin
  if (~reset) begin
    tdr_latch13 <= 1'b0;
  end else begin
    if (update_en & ijtag_select) begin
      tdr_latch13 <= tdr[13];
    end
  end
end
// --------- DataOutPort 12 ---------
always_ff @ (negedge tck or negedge reset) begin
  if (~reset) begin
    tdr_latch12 <= 1'b0;
  end else begin
    if (update_en & ijtag_select) begin
      tdr_latch12 <= tdr[12];
    end
  end
end
// --------- DataOutPort 11 ---------
always_ff @ (negedge tck or negedge reset) begin
  if (~reset) begin
    tdr_latch11 <= 1'b0;
  end else begin
    if (update_en & ijtag_select) begin
      tdr_latch11 <= tdr[11];
    end
  end
end
// --------- DataOutPort 10 ---------
always_ff @ (negedge tck or negedge reset) begin
  if (~reset) begin
    tdr_latch10 <= 1'b0;
  end else begin
    if (update_en & ijtag_select) begin
      tdr_latch10 <= tdr[10];
    end
  end
end
// --------- DataOutPort 9 ---------
always_ff @ (negedge tck or negedge reset) begin
  if (~reset) begin
    tdr_latch9 <= 1'b0;
  end else begin
    if (update_en & ijtag_select) begin
      tdr_latch9 <= tdr[9];
    end
  end
end
// --------- DataOutPort 8 ---------
always_ff @ (negedge tck or negedge reset) begin
  if (~reset) begin
    tdr_latch8 <= 1'b0;
  end else begin
    if (update_en & ijtag_select) begin
      tdr_latch8 <= tdr[8];
    end
  end
end
// --------- DataOutPort 7 ---------
always_ff @ (negedge tck or negedge reset) begin
  if (~reset) begin
    tdr_latch7 <= 1'b0;
  end else begin
    if (update_en & ijtag_select) begin
      tdr_latch7 <= tdr[7];
    end
  end
end
// --------- DataOutPort 6 ---------
always_ff @ (negedge tck or negedge reset) begin
  if (~reset) begin
    tdr_latch6 <= 1'b0;
  end else begin
    if (update_en & ijtag_select) begin
      tdr_latch6 <= tdr[6];
    end
  end
end
// --------- DataOutPort 5 ---------
always_ff @ (negedge tck or negedge reset) begin
  if (~reset) begin
    tdr_latch5 <= 1'b0;
  end else begin
    if (update_en & ijtag_select) begin
      tdr_latch5 <= tdr[5];
    end
  end
end
// --------- DataOutPort 4 ---------
always_ff @ (negedge tck or negedge reset) begin
  if (~reset) begin
    tdr_latch4 <= 1'b0;
  end else begin
    if (update_en & ijtag_select) begin
      tdr_latch4 <= tdr[4];
    end
  end
end
// --------- DataOutPort 3 ---------
always_ff @ (negedge tck or negedge reset) begin
  if (~reset) begin
    tdr_latch3 <= 1'b0;
  end else begin
    if (update_en & ijtag_select) begin
      tdr_latch3 <= tdr[3];
    end
  end
end
// --------- DataOutPort 2 ---------
always_ff @ (negedge tck or negedge reset) begin
  if (~reset) begin
    tdr_latch2 <= 1'b0;
  end else begin
    if (update_en & ijtag_select) begin
      tdr_latch2 <= tdr[2];
    end
  end
end
// --------- DataOutPort 1 ---------
always_ff @ (negedge tck or negedge reset) begin
  if (~reset) begin
    tdr_latch1 <= 1'b0;
  end else begin
    if (update_en & ijtag_select) begin
      tdr_latch1 <= tdr[1];
    end
  end
end
// --------- DataOutPort 0 ---------
always_ff @ (negedge tck or negedge reset) begin
  if (~reset) begin
    tdr_latch0 <= 1'b0;
  end else begin
    if (update_en & ijtag_select) begin
      tdr_latch0 <= tdr[0];
    end
  end
end
// Update Latches }}}
// Data Output Ports {{{
assign BIST_DATA_INV_ROW_ADD_BIT_SELECT_EN = tdr_latch31;
assign BIST_DATA_INV_ROW_ADD_BIT_SEL = tdr_latch30;
assign BIST_DATA_INV_COL_ADD_BIT_SELECT_EN = tdr_latch29;
assign BIST_DATA_INV_COL_ADD_BIT_SEL = tdr_latch28;
assign BIST_SELECT_COMMON_OPSET = tdr_latch27;
assign BIST_OPSET_SEL = tdr_latch26;
assign BIST_SELECT_COMMON_ALGO = tdr_latch25;
assign BIST_ALGO_SEL[6] = tdr_latch24;
assign BIST_ALGO_SEL[5] = tdr_latch23;
assign BIST_ALGO_SEL[4] = tdr_latch22;
assign BIST_ALGO_SEL[3] = tdr_latch21;
assign BIST_ALGO_SEL[2] = tdr_latch20;
assign BIST_ALGO_SEL[1] = tdr_latch19;
assign BIST_ALGO_SEL[0] = tdr_latch18;
assign BIST_SETUP[2] = tdr_latch17;
assign BIST_SETUP_reg[2] = tdr[17];
assign BIST_SETUP[1] = tdr_latch16;
assign BIST_SETUP_reg[1] = tdr[16];
assign BIST_SETUP[0] = tdr_latch15;
assign BIST_SETUP_reg[0] = tdr[15];
assign CHAIN_BYPASS_EN = tdr_latch14;
assign CHAIN_BYPASS_EN_reg = tdr[14];
assign INCLUDE_MEM_RESULTS_REG = tdr_latch13;
assign FL_CNT_MODE1 = tdr_latch12;
assign FL_CNT_MODE0 = tdr_latch11;
TS_MX tessent_persistent_cell_BIST_ASYNC_RESET_mux (.b(tdr_latch10),.a(reset),.sa(ltest_en),.o(BIST_ASYNC_RESET));
assign CHECK_REPAIR_NEEDED = tdr_latch9;
assign PRESERVE_FUSE_REGISTER = tdr_latch8;
assign BIST_DIAG_EN = tdr_latch7;
assign BIRA_EN      = tdr_latch6;
assign MEM_ARRAY_DUMP_MODE = tdr_latch5;
assign BIST_ALGO_MODE1 = tdr_latch4;
assign BIST_ALGO_MODE0 = tdr_latch3;
assign BIST_SELECT_TEST_DATA = tdr_latch2;
assign REDUCED_ADDRESS_COUNT = tdr_latch1;
assign ENABLE_MEM_RESET = tdr_latch0;
// Data Output Ports }}}
  
assign so = tdr[0];
// hif_pcie_pcie_upp_tcam_mems_rtl_tessent_mbist_bap_tdr }}}
endmodule
 
module hif_pcie_pcie_upp_tcam_mems_rtl_tessent_mbist_bap_sib (
// hif_pcie_pcie_upp_tcam_mems_rtl_tessent_mbist_controller_sib {{{
   input wire reset,
   input wire ijtag_select,
   input wire si,
   input wire capture_en,
   input wire shift_en,
   input wire update_en,
   input wire tck,
   output wire so,
   input wire from_scan_out,
   output wire ijtag_to_select_reg,
   output wire ijtag_to_select
);
   reg            sib;
   reg            sib_latch;
   reg            to_enable_int;
   assign ijtag_to_select_reg = sib;
   assign ijtag_to_select = ijtag_select & to_enable_int;
   always_ff @ (negedge tck or negedge reset) begin
      if (~reset) begin
         sib_latch     <= 1'b0;
      end else if (update_en & ijtag_select) begin
         sib_latch     <= sib;
      end
   end
   always_ff @ (negedge tck or negedge reset) begin
      if (~reset) begin
         to_enable_int <= 1'b0;
      end else  begin
         to_enable_int <= sib_latch;
      end
   end
 
   assign so = sib;
 
   always_ff @ (posedge tck) begin
      if (capture_en & ijtag_select) begin
         sib <= 1'b0;
      end else if (shift_en & ijtag_select) begin
         if (sib_latch) begin
            sib <= from_scan_out;
         end else begin
            sib <= si;
         end
      end
   end
// hif_pcie_pcie_upp_tcam_mems_rtl_tessent_mbist_controller_sib }}}
endmodule
module hif_pcie_pcie_upp_tcam_mems_rtl_tessent_mbist_bap_ctl_sib (
// hif_pcie_pcie_upp_tcam_mems_rtl_tessent_mbist_controller_sib {{{
   input wire reset,
   input wire ijtag_select,
   input wire si,
   input wire capture_en,
   input wire shift_en,
   input wire update_en,
   input wire tck,
   output wire so,
   input wire from_scan_out,
   input wire ChainBypassMode,
   input wire bist_done,
   input wire bist_go,
   output wire bistEn_reg,
   output wire bistEn_latch,
   output wire bistEn
);
   reg            sib;
   reg            tdr;
   reg            sib_latch;
   reg            to_enable_int;
   assign bistEn = to_enable_int;
   assign bistEn_reg = sib;
   assign bistEn_latch = sib_latch;
   always_ff @ (negedge tck or negedge reset) begin
      if (~reset) begin
         sib_latch     <= 1'b0;
      end else if (update_en & ijtag_select) begin
         sib_latch     <= sib;
      end
   end
   always_ff @ (negedge tck or negedge reset) begin
      if (~reset) begin
         to_enable_int <= 1'b0;
      end else  begin
         to_enable_int <= sib_latch;
      end
   end
 
   assign so = sib;
 
   always_ff @ (posedge tck) begin
      if (capture_en & ijtag_select) begin
         tdr <= bist_done;
         sib <= bist_go;
      end else if (shift_en & ijtag_select) begin
         if (sib_latch & (ChainBypassMode==0)) begin
            tdr <= from_scan_out;
         end else begin
            tdr <= si;
         end
         sib <= tdr;
      end
   end
// hif_pcie_pcie_upp_tcam_mems_rtl_tessent_mbist_controller_sib }}}
endmodule
module hif_pcie_pcie_upp_tcam_mems_rtl_tessent_mbist_bap_tdr_short (
// hif_pcie_pcie_upp_tcam_mems_rtl_tessent_mbist_bap_tdr_short {{{
  input wire reset,
  input wire ijtag_select,
  input wire si,
  input wire capture_en,
  input wire shift_en,
  input wire update_en,
  input wire tck,
  output wire memory_mfg_test,
  output wire so
);
// Shift Register {{{
reg    [0:0]        tdr;
reg    [0:0]        tdr_latch;
always_ff @ (posedge tck) begin
  if (capture_en & ijtag_select) begin
    tdr <= tdr_latch;
  end else if (shift_en & ijtag_select) begin
    tdr <= si;
  end
end
// Shift Register }}}
// Update Latches {{{
always_ff @ (negedge tck or negedge reset) begin
  if (~reset) begin
    tdr_latch <= 1'b0;
  end else begin
    if (update_en & ijtag_select) begin
      tdr_latch <= tdr;
    end
  end
end
// Update Latches }}}
// Data Output Ports {{{
assign memory_mfg_test  = tdr_latch[0];
// Data Output Ports }}}
assign so = tdr[0];
// hif_pcie_pcie_upp_tcam_mems_rtl_tessent_mbist_bap_tdr }}}
endmodule
module hif_pcie_pcie_upp_tcam_mems_rtl_tessent_mbist_bap_start_stop_sequencer (
// hif_pcie_pcie_upp_tcam_mems_rtl_tessent_mbist_bap_start_stop_sequencer {{{
  input wire reset,
  input wire clk,
  input wire test_start,
  input wire test_init,
  input wire mcp_bounding_en, 
  output wire bist_setup,
  output wire bist_en,
  output reg bist_en_pipe,
  output wire bist_async_reset,
  output wire bist_clk_en
);
   reg [6:0] start_stop_sequencer;
   always_ff @ (posedge clk or negedge reset) begin
      if (~reset) begin
         start_stop_sequencer[6:3] <= 4'b0;
      end else begin
        if (test_start|test_init) begin
           start_stop_sequencer[5:3] <= start_stop_sequencer[6:4];
           start_stop_sequencer[6] <= test_start|test_init;
        end else begin
           start_stop_sequencer[6:4] <= start_stop_sequencer[5:3];
           start_stop_sequencer[3] <= start_stop_sequencer[2];
        end
      end 
   end
   always_ff @ (posedge clk or negedge reset) begin
      if (~reset) begin
         start_stop_sequencer[2:0] <= 3'b0;
      end else begin
       if (~mcp_bounding_en) 
         if (test_start) begin
            start_stop_sequencer[1:0] <= start_stop_sequencer[2:1];
            start_stop_sequencer[2] <= start_stop_sequencer[3];
         end else begin
            start_stop_sequencer[2:1] <= start_stop_sequencer[1:0];
            start_stop_sequencer[0] <= 1'b0;
         end
     end 
   end
   always_ff @ (posedge clk or negedge reset) begin
      if (~reset) begin
         bist_en_pipe <= 1'b0;
      end else begin
         bist_en_pipe <= bist_en;
      end
   end
   assign bist_async_reset = start_stop_sequencer[6];
   assign bist_clk_en = start_stop_sequencer[4];
   assign bist_setup = start_stop_sequencer[2];
   assign bist_en = start_stop_sequencer[0];
// hif_pcie_pcie_upp_tcam_mems_rtl_tessent_mbist_bap_start_stop_sequencer }}} 
endmodule