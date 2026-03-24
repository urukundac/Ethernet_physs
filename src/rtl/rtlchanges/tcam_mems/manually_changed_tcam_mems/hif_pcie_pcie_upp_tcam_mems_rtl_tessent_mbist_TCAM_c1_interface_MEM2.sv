/*
----------------------------------------------------------------------------------
-                                                                                -
-  Unpublished work. Copyright 2025 Siemens                                      -
-                                                                                -
-  This material contains trade secrets or otherwise confidential                -
-  information owned by Siemens Industry Software Inc. or its affiliates         -
-  (collectively, SISW), or its licensors. Access to and use of this             -
-  information is strictly limited as set forth in the Customer's                -
-  applicable agreements with SISW.                                              -
-                                                                                -
----------------------------------------------------------------------------------
-  File created by: Tessent Shell                                                -
-          Version: 2025.1                                                       -
-       Created on: Thu Jun 19 03:09:37 PDT 2025                                 -
----------------------------------------------------------------------------------


*/
`ifdef ip783tcam128x36s0c1_dft_wrp_MIN_HOLD_NS
    `define MIN_HOLD_DELAY #(`ip783tcam128x36s0c1_dft_wrp_MIN_HOLD_NS*10)
`elsif GLOBAL_MIN_HOLD_NS
    `define MIN_HOLD_DELAY #(`GLOBAL_MIN_HOLD_NS*10)
`else
    `define MIN_HOLD_DELAY 
`endif

/*------------------------------------------------------------------------------
     Module      :  hif_pcie_pcie_upp_tcam_mems_rtl_tessent_mbist_TCAM_c1_interface_MEM2
 
     Description :  This module contains the interface logic for the memory
                    module ip783tcam128x36s0c1_dft_wrp
 
--------------------------------------------------------------------------------
     Interface Options in Effect
 
     BistDataPipelineStages                       : 0;
     BitGrouping                                  : 1;
     BitSliceWidth                                : 1;
     ConcurrentWrite                              : OFF
     ConcurrentRead                               : OFF
     ControllerType                               : PROG;
     DataOutStage                                 : NONE;
     DefaultAlgorithm                             : INTELLVPMOVIFASTX;
     DefaultOperationSet                          : SYNCCUSTOM;
     InternalScanLogic                            : ON;
     LocalComparators                             : OFF;
     DataHoldWithInactiveReadEnable               : ON
     MemoryHoldWithInactiveSelect                 : ON
     MemoryType                                   : RAM;
     ObservationLogic                             : OFF;
     OutputEnableControl                          : ALWAYSON;
     PipelineSerialDataOut                        : OFF;
     ScanWriteThru                                : OFF;
     ShadowRead                                   : OFF;
     ShadowWrite                                  : OFF;
     Stop-On-Error Limit                          : 65536;
     TransparentMode                              : NONE;
     RedundancyAnalysisType                       : COL;
 
---------------------------------------------------------------------------- */

module hif_pcie_pcie_upp_tcam_mems_rtl_tessent_mbist_TCAM_c1_interface_MEM2 (
  input  wire        FLS_IN,
  input  wire        TVBE_IN,
  input  wire        TVBI_IN,
  input  wire        BIST_CM_MODE_IN,
  input  wire        BIST_CM_EN_IN_IN,
  input  wire        BIST_CM_MATCH_SEL0_IN,
  input  wire        BIST_CM_MATCH_SEL1_IN,
  input  wire        BIST_ROTATE_SR_IN,
  input  wire        BIST_ALL_MASK_IN,
  input  wire        BIST_EN_SR_DATA_B_IN,
  input  wire        BIST_EN_SR_MASK_B_IN,
  input  wire        BIST_MATCHIN_IN_IN,
  input  wire        BIST_FLS_IN,
  input  wire        WE_IN,
  input  wire        RE_IN,
  input  wire        ME_IN,
  input  wire [35:0] QOUT,
  input  wire [35:0] DIN_IN,
  input  wire        BIST_USER9,
  input  wire        BIST_USER10,
  input  wire        BIST_USER11,
  input  wire        BIST_USER0,
  input  wire        BIST_USER1,
  input  wire        BIST_USER2,
  input  wire        BIST_USER3,
  input  wire        BIST_USER4,
  input  wire        BIST_USER5,
  input  wire        BIST_USER6,
  input  wire        BIST_USER7,
  input  wire        BIST_USER8,
  input  wire        BIST_EVEN_GROUPWRITEENABLE,
  input  wire        BIST_ODD_GROUPWRITEENABLE,
  input  wire        BIST_WRITEENABLE,
  input  wire        BIST_READENABLE,
  input  wire        BIST_SELECT,
  input  wire [0:0]  BIST_COL_ADD,
  input  wire [5:0]  BIST_ROW_ADD,
  input  wire [0:0]  BIST_BANK_ADD,
  input  wire [31:0] BIST_WRITE_DATA,
  input  wire        BIST_TESTDATA_SELECT_TO_COLLAR,
  input  wire        MEM_BYPASS_EN,
  input  wire        SCAN_SHIFT_EN,
  input  wire        MCP_BOUNDING_EN,
  input  wire        BIST_ON,
  input  wire        BIST_RUN,
  input  wire        BIST_ASYNC_RESETN,
  input  wire        BIST_CLK,
  input  wire        BIST_SHIFT_COLLAR,
  input  wire        BIST_COLLAR_SETUP,
  input  wire        BIST_COLLAR_HOLD,
  input  wire        BIST_CLEAR_DEFAULT,
  input  wire        BIST_CLEAR,
  input  wire        BIST_SETUP0,
  input  wire        LV_TM,
  input  wire        BIST_COLLAR_EN,
  input  wire        RESET_REG_SETUP2,
  output wire        FLS,
  output wire        TVBE,
  output wire        TVBI,
  output wire        BISTE,
  output wire        BIST_CM_MODE,
  output wire        BIST_CM_EN_IN,
  output wire        BIST_CM_MATCH_SEL0,
  output wire        BIST_CM_MATCH_SEL1,
  output wire        BIST_ROTATE_SR,
  output wire        BIST_ALL_MASK,
  output wire        BIST_EN_SR_DATA_B,
  output wire        BIST_EN_SR_MASK_B,
  output wire        BIST_MATCHIN_IN,
  output wire        BIST_FLS,
  output wire [35:0] TMASK,
  output wire        WE,
  output wire        TWE,
  output wire        RE,
  output wire        TRE,
  output wire        ME,
  output wire        TME,
  output wire [7:0]  TADR,
  output wire [35:0] DIN,
  output wire [35:0] TDIN,
  output wire [35:0] BIST_DATA_FROM_MEM
  , input wire fscan_clkungate);
  wire clock_gating_qualifier_and_o;

`ifdef ip783tcam128x36s0c1_dft_wrp_MIN_HOLD_NS
    `define ADD_TIMEUNIT_TIMEPRECISION
`elsif GLOBAL_MIN_HOLD_NS
    `define ADD_TIMEUNIT_TIMEPRECISION
`endif
`ifdef ADD_TIMEUNIT_TIMEPRECISION
    timeunit 100ps;
    timeprecision 10ps;
`endif


wire [35:0] BIST_WRITE_DATA_REP;
wire [35:0] BIST_WRITE_DATA_INT;
reg         BIST_INPUT_SELECT;
wire        BIST_EN_RST;
wire        BIST_CLK_INT;
wire        BIST_CLK_OR_TCK;
wire        BIST_CLK_EN;
wire        STATUS_SO;
wire        COLLAR_STATUS_SI;
wire        BIST_INPUT_SELECT_INT;
wire [0:0]  ERROR;
wire [35:0] DATA_TO_MEM;
wire [35:0] DATA_FROM_MEM;
wire [35:0] DATA_FROM_MEM_EXP;
wire        FLS_TEST_IN;
reg         FLS_NOT_GATED;
wire        FLS_TO_MUX;
wire        TVBE_TEST_IN;
reg         TVBE_NOT_GATED;
wire        TVBE_TO_MUX;
wire        TVBI_TEST_IN;
reg         TVBI_NOT_GATED;
wire        TVBI_TO_MUX;
wire        BIST_CM_MODE_TEST_IN;
reg         BIST_CM_MODE_NOT_GATED;
wire        BIST_CM_MODE_TO_MUX;
wire        BIST_CM_EN_IN_TEST_IN;
reg         BIST_CM_EN_IN_NOT_GATED;
wire        BIST_CM_EN_IN_TO_MUX;
wire        BIST_CM_MATCH_SEL0_TEST_IN;
reg         BIST_CM_MATCH_SEL0_NOT_GATED;
wire        BIST_CM_MATCH_SEL0_TO_MUX;
wire        BIST_CM_MATCH_SEL1_TEST_IN;
reg         BIST_CM_MATCH_SEL1_NOT_GATED;
wire        BIST_CM_MATCH_SEL1_TO_MUX;
wire        BIST_ROTATE_SR_TEST_IN;
reg         BIST_ROTATE_SR_NOT_GATED;
wire        BIST_ROTATE_SR_TO_MUX;
wire        BIST_ALL_MASK_TEST_IN;
reg         BIST_ALL_MASK_NOT_GATED;
wire        BIST_ALL_MASK_TO_MUX;
wire        BIST_EN_SR_DATA_B_TEST_IN;
reg         BIST_EN_SR_DATA_B_NOT_GATED;
wire        BIST_EN_SR_DATA_B_TO_MUX;
wire        BIST_EN_SR_MASK_B_TEST_IN;
reg         BIST_EN_SR_MASK_B_NOT_GATED;
wire        BIST_EN_SR_MASK_B_TO_MUX;
wire        BIST_MATCHIN_IN_TEST_IN;
reg         BIST_MATCHIN_IN_NOT_GATED;
wire        BIST_MATCHIN_IN_TO_MUX;
wire        BIST_FLS_TEST_IN;
reg         BIST_FLS_NOT_GATED;
wire        BIST_FLS_TO_MUX;
wire [35:0] MASK_TO_MUX;
wire        WE_NOT_GATED;
wire        TWE_NOT_GATED;
wire        WE_TO_MUX;
wire        RE_NOT_GATED;
wire        TRE_NOT_GATED;
wire        RE_TO_MUX;
wire        ME_NOT_GATED;
wire        TME_NOT_GATED;
wire        ME_TO_MUX;
wire        USE_DEFAULTS;
wire        BIST_COLLAR_HOLD_INT;
wire        BIST_SETUP0_SYNC;
wire        LOGIC_HIGH;

//---------------------------
// Memory Interface Main Code
//---------------------------
   assign LOGIC_HIGH = 1'b1;
//----------------------
//-- BIST_ON Sync-ing --
//----------------------
    TS_AND tessent_persistent_cell_AND_BIST_SETUP0_SYNC (
        .a          ( BIST_SETUP0                                ),
        .b          ( BIST_ON                                    ),
        .o          ( BIST_SETUP0_SYNC                           )
    );

//----------------------
//-- BIST_EN Retiming --
//----------------------
    assign BIST_EN_RST              = ~BIST_ASYNC_RESETN;
    always_ff @ (posedge BIST_CLK_INT or negedge BIST_ASYNC_RESETN) begin
       if (~BIST_ASYNC_RESETN)
          BIST_INPUT_SELECT <= 1'b0;
       else
       if (~MCP_BOUNDING_EN) begin
          BIST_INPUT_SELECT <= BIST_RUN | BIST_TESTDATA_SELECT_TO_COLLAR;
       end
   end

    wire BIST_INPUT_SELECT_INT_BUF;
    TS_BUF tessent_persistent_cell_BIST_INPUT_SELECT_INT (
        .a                          (BIST_INPUT_SELECT & ((~LV_TM)|MEM_BYPASS_EN)),
        .o                          (BIST_INPUT_SELECT_INT_BUF)
    );
    assign `MIN_HOLD_DELAY BIST_INPUT_SELECT_INT = BIST_INPUT_SELECT_INT_BUF;
    assign USE_DEFAULTS = ~BIST_SETUP0_SYNC;
    assign BIST_COLLAR_HOLD_INT = BIST_COLLAR_HOLD;
//--------------------------
//-- Replicate Write Data --
//--------------------------
   assign BIST_WRITE_DATA_REP      = {
                                       BIST_WRITE_DATA[3:0],
                                       BIST_WRITE_DATA
                                     };
 
//-----------------------
//-- Checkerboard Data --
//-----------------------
   assign BIST_WRITE_DATA_INT       = BIST_WRITE_DATA_REP;
   assign DATA_TO_MEM              = BIST_WRITE_DATA_INT;
 
 
 
 

//--------------------------
//-- Memory Control Ports --
//--------------------------

   // Port: FLS LogicalPort: ## Type: READWRITE {{{

   // Intercept functional signal with test mux
   always_comb begin
      case (BIST_INPUT_SELECT_INT) // synopsys infer_mux
      1'b0 : FLS_NOT_GATED = FLS_IN;
      1'b1 : FLS_NOT_GATED = FLS_TEST_IN;
      endcase
   end

   // Disable memory port during logic test
   assign FLS                       = FLS_NOT_GATED & ~(LV_TM & (MEM_BYPASS_EN | SCAN_SHIFT_EN));

   // Control logic during memory test
   assign `MIN_HOLD_DELAY FLS_TEST_IN                     = (BIST_COLLAR_EN & FLS_TO_MUX);
   assign FLS_TO_MUX                = BIST_USER9;

   // Port: FLS }}}

   // Port: TVBE LogicalPort: ## Type: READWRITE {{{

   // Intercept functional signal with test mux
   always_comb begin
      case (BIST_INPUT_SELECT_INT) // synopsys infer_mux
      1'b0 : TVBE_NOT_GATED = TVBE_IN;
      1'b1 : TVBE_NOT_GATED = TVBE_TEST_IN;
      endcase
   end

   // Disable memory port during logic test
   assign TVBE                      = TVBE_NOT_GATED | (LV_TM & (MEM_BYPASS_EN | SCAN_SHIFT_EN));

   // Control logic during memory test
   assign `MIN_HOLD_DELAY TVBE_TEST_IN                    = ~(BIST_COLLAR_EN & TVBE_TO_MUX);
   assign TVBE_TO_MUX               = BIST_USER10;

   // Port: TVBE }}}

   // Port: TVBI LogicalPort: ## Type: READWRITE {{{

   // Intercept functional signal with test mux
   always_comb begin
      case (BIST_INPUT_SELECT_INT) // synopsys infer_mux
      1'b0 : TVBI_NOT_GATED = TVBI_IN;
      1'b1 : TVBI_NOT_GATED = TVBI_TEST_IN;
      endcase
   end

   // Disable memory port during logic test
   assign TVBI                      = TVBI_NOT_GATED & ~(LV_TM & (MEM_BYPASS_EN | SCAN_SHIFT_EN));

   // Control logic during memory test
   assign `MIN_HOLD_DELAY TVBI_TEST_IN                    = (BIST_COLLAR_EN & TVBI_TO_MUX);
   assign TVBI_TO_MUX               = BIST_USER11;

   // Port: TVBI }}}

   // Port: BISTE LogicalPort: ## Type: READWRITE {{{

   // Control logic during memory test
   assign `MIN_HOLD_DELAY BISTE     = BIST_INPUT_SELECT_INT;

   // Port: BISTE }}}

   // Port: BIST_CM_MODE LogicalPort: ## Type: READWRITE {{{

   // Intercept functional signal with test mux
   always_comb begin
      case (BIST_INPUT_SELECT_INT) // synopsys infer_mux
      1'b0 : BIST_CM_MODE_NOT_GATED = BIST_CM_MODE_IN;
      1'b1 : BIST_CM_MODE_NOT_GATED = BIST_CM_MODE_TEST_IN;
      endcase
   end

   // Disable memory port during logic test
   assign BIST_CM_MODE              = BIST_CM_MODE_NOT_GATED & ~(LV_TM & (MEM_BYPASS_EN | SCAN_SHIFT_EN));

   // Control logic during memory test
   assign `MIN_HOLD_DELAY BIST_CM_MODE_TEST_IN            = (BIST_COLLAR_EN & BIST_CM_MODE_TO_MUX);
   assign BIST_CM_MODE_TO_MUX       = BIST_USER0;

   // Port: BIST_CM_MODE }}}

   // Port: BIST_CM_EN_IN LogicalPort: ## Type: READWRITE {{{

   // Intercept functional signal with test mux
   always_comb begin
      case (BIST_INPUT_SELECT_INT) // synopsys infer_mux
      1'b0 : BIST_CM_EN_IN_NOT_GATED = BIST_CM_EN_IN_IN;
      1'b1 : BIST_CM_EN_IN_NOT_GATED = BIST_CM_EN_IN_TEST_IN;
      endcase
   end

   // Disable memory port during logic test
   assign BIST_CM_EN_IN             = BIST_CM_EN_IN_NOT_GATED & ~(LV_TM & (MEM_BYPASS_EN | SCAN_SHIFT_EN));

   // Control logic during memory test
   assign `MIN_HOLD_DELAY BIST_CM_EN_IN_TEST_IN           = (BIST_COLLAR_EN & BIST_CM_EN_IN_TO_MUX);
   assign BIST_CM_EN_IN_TO_MUX      = BIST_USER1;

   // Port: BIST_CM_EN_IN }}}

   // Port: BIST_CM_MATCH_SEL0 LogicalPort: ## Type: READWRITE {{{

   // Intercept functional signal with test mux
   always_comb begin
      case (BIST_INPUT_SELECT_INT) // synopsys infer_mux
      1'b0 : BIST_CM_MATCH_SEL0_NOT_GATED = BIST_CM_MATCH_SEL0_IN;
      1'b1 : BIST_CM_MATCH_SEL0_NOT_GATED = BIST_CM_MATCH_SEL0_TEST_IN;
      endcase
   end

   // Disable memory port during logic test
   assign BIST_CM_MATCH_SEL0        = BIST_CM_MATCH_SEL0_NOT_GATED & ~(LV_TM & (MEM_BYPASS_EN | SCAN_SHIFT_EN));

   // Control logic during memory test
   assign `MIN_HOLD_DELAY BIST_CM_MATCH_SEL0_TEST_IN      = (BIST_COLLAR_EN & BIST_CM_MATCH_SEL0_TO_MUX);
   assign BIST_CM_MATCH_SEL0_TO_MUX                       = BIST_USER2;

   // Port: BIST_CM_MATCH_SEL0 }}}

   // Port: BIST_CM_MATCH_SEL1 LogicalPort: ## Type: READWRITE {{{

   // Intercept functional signal with test mux
   always_comb begin
      case (BIST_INPUT_SELECT_INT) // synopsys infer_mux
      1'b0 : BIST_CM_MATCH_SEL1_NOT_GATED = BIST_CM_MATCH_SEL1_IN;
      1'b1 : BIST_CM_MATCH_SEL1_NOT_GATED = BIST_CM_MATCH_SEL1_TEST_IN;
      endcase
   end

   // Disable memory port during logic test
   assign BIST_CM_MATCH_SEL1        = BIST_CM_MATCH_SEL1_NOT_GATED & ~(LV_TM & (MEM_BYPASS_EN | SCAN_SHIFT_EN));

   // Control logic during memory test
   assign `MIN_HOLD_DELAY BIST_CM_MATCH_SEL1_TEST_IN      = (BIST_COLLAR_EN & BIST_CM_MATCH_SEL1_TO_MUX);
   assign BIST_CM_MATCH_SEL1_TO_MUX                       = BIST_USER3;

   // Port: BIST_CM_MATCH_SEL1 }}}

   // Port: BIST_ROTATE_SR LogicalPort: ## Type: READWRITE {{{

   // Intercept functional signal with test mux
   always_comb begin
      case (BIST_INPUT_SELECT_INT) // synopsys infer_mux
      1'b0 : BIST_ROTATE_SR_NOT_GATED = BIST_ROTATE_SR_IN;
      1'b1 : BIST_ROTATE_SR_NOT_GATED = BIST_ROTATE_SR_TEST_IN;
      endcase
   end

   // Disable memory port during logic test
   assign BIST_ROTATE_SR            = BIST_ROTATE_SR_NOT_GATED & ~(LV_TM & (MEM_BYPASS_EN | SCAN_SHIFT_EN));

   // Control logic during memory test
   assign `MIN_HOLD_DELAY BIST_ROTATE_SR_TEST_IN          = (BIST_COLLAR_EN & BIST_ROTATE_SR_TO_MUX);
   assign BIST_ROTATE_SR_TO_MUX     = BIST_USER4;

   // Port: BIST_ROTATE_SR }}}

   // Port: BIST_ALL_MASK LogicalPort: ## Type: READWRITE {{{

   // Intercept functional signal with test mux
   always_comb begin
      case (BIST_INPUT_SELECT_INT) // synopsys infer_mux
      1'b0 : BIST_ALL_MASK_NOT_GATED = BIST_ALL_MASK_IN;
      1'b1 : BIST_ALL_MASK_NOT_GATED = BIST_ALL_MASK_TEST_IN;
      endcase
   end

   // Disable memory port during logic test
   assign BIST_ALL_MASK             = BIST_ALL_MASK_NOT_GATED & ~(LV_TM & (MEM_BYPASS_EN | SCAN_SHIFT_EN));

   // Control logic during memory test
   assign `MIN_HOLD_DELAY BIST_ALL_MASK_TEST_IN           = (BIST_COLLAR_EN & BIST_ALL_MASK_TO_MUX);
   assign BIST_ALL_MASK_TO_MUX      = BIST_USER5;

   // Port: BIST_ALL_MASK }}}

   // Port: BIST_EN_SR_DATA_B LogicalPort: ## Type: READWRITE {{{

   // Intercept functional signal with test mux
   always_comb begin
      case (BIST_INPUT_SELECT_INT) // synopsys infer_mux
      1'b0 : BIST_EN_SR_DATA_B_NOT_GATED = BIST_EN_SR_DATA_B_IN;
      1'b1 : BIST_EN_SR_DATA_B_NOT_GATED = BIST_EN_SR_DATA_B_TEST_IN;
      endcase
   end

   // Disable memory port during logic test
   assign BIST_EN_SR_DATA_B         = BIST_EN_SR_DATA_B_NOT_GATED & ~(LV_TM & (MEM_BYPASS_EN | SCAN_SHIFT_EN));

   // Control logic during memory test
   assign `MIN_HOLD_DELAY BIST_EN_SR_DATA_B_TEST_IN       = (BIST_COLLAR_EN & BIST_EN_SR_DATA_B_TO_MUX);
   assign BIST_EN_SR_DATA_B_TO_MUX                        = BIST_USER6;

   // Port: BIST_EN_SR_DATA_B }}}

   // Port: BIST_EN_SR_MASK_B LogicalPort: ## Type: READWRITE {{{

   // Intercept functional signal with test mux
   always_comb begin
      case (BIST_INPUT_SELECT_INT) // synopsys infer_mux
      1'b0 : BIST_EN_SR_MASK_B_NOT_GATED = BIST_EN_SR_MASK_B_IN;
      1'b1 : BIST_EN_SR_MASK_B_NOT_GATED = BIST_EN_SR_MASK_B_TEST_IN;
      endcase
   end

   // Disable memory port during logic test
   assign BIST_EN_SR_MASK_B         = BIST_EN_SR_MASK_B_NOT_GATED & ~(LV_TM & (MEM_BYPASS_EN | SCAN_SHIFT_EN));

   // Control logic during memory test
   assign `MIN_HOLD_DELAY BIST_EN_SR_MASK_B_TEST_IN       = (BIST_COLLAR_EN & BIST_EN_SR_MASK_B_TO_MUX);
   assign BIST_EN_SR_MASK_B_TO_MUX                        = BIST_USER7;

   // Port: BIST_EN_SR_MASK_B }}}

   // Port: BIST_MATCHIN_IN LogicalPort: ## Type: READWRITE {{{

   // Intercept functional signal with test mux
   always_comb begin
      case (BIST_INPUT_SELECT_INT) // synopsys infer_mux
      1'b0 : BIST_MATCHIN_IN_NOT_GATED = BIST_MATCHIN_IN_IN;
      1'b1 : BIST_MATCHIN_IN_NOT_GATED = BIST_MATCHIN_IN_TEST_IN;
      endcase
   end

   // Disable memory port during logic test
   assign BIST_MATCHIN_IN           = BIST_MATCHIN_IN_NOT_GATED | (LV_TM & (MEM_BYPASS_EN | SCAN_SHIFT_EN));

   // Control logic during memory test
   assign `MIN_HOLD_DELAY BIST_MATCHIN_IN_TEST_IN         = ~(BIST_COLLAR_EN & BIST_MATCHIN_IN_TO_MUX);
   assign BIST_MATCHIN_IN_TO_MUX    = BIST_USER8;

   // Port: BIST_MATCHIN_IN }}}

   // Port: BIST_FLS LogicalPort: ## Type: READWRITE {{{

   // Intercept functional signal with test mux
   always_comb begin
      case (BIST_INPUT_SELECT_INT) // synopsys infer_mux
      1'b0 : BIST_FLS_NOT_GATED = BIST_FLS_IN;
      1'b1 : BIST_FLS_NOT_GATED = BIST_FLS_TEST_IN;
      endcase
   end

   // Disable memory port during logic test
   assign BIST_FLS                  = BIST_FLS_NOT_GATED & ~(LV_TM & (MEM_BYPASS_EN | SCAN_SHIFT_EN));

   // Control logic during memory test
   assign `MIN_HOLD_DELAY BIST_FLS_TEST_IN                = (BIST_COLLAR_EN & BIST_FLS_TO_MUX);
   assign BIST_FLS_TO_MUX           = BIST_USER9;

   // Port: BIST_FLS }}}

   // Port: MASK LogicalPort: ## Type: READWRITE {{{

   // Control logic during memory test
   assign `MIN_HOLD_DELAY TMASK     = {
                                       (BIST_COLLAR_EN & MASK_TO_MUX[35]),
                                       (BIST_COLLAR_EN & MASK_TO_MUX[34]),
                                       (BIST_COLLAR_EN & MASK_TO_MUX[33]),
                                       (BIST_COLLAR_EN & MASK_TO_MUX[32]),
                                       (BIST_COLLAR_EN & MASK_TO_MUX[31]),
                                       (BIST_COLLAR_EN & MASK_TO_MUX[30]),
                                       (BIST_COLLAR_EN & MASK_TO_MUX[29]),
                                       (BIST_COLLAR_EN & MASK_TO_MUX[28]),
                                       (BIST_COLLAR_EN & MASK_TO_MUX[27]),
                                       (BIST_COLLAR_EN & MASK_TO_MUX[26]),
                                       (BIST_COLLAR_EN & MASK_TO_MUX[25]),
                                       (BIST_COLLAR_EN & MASK_TO_MUX[24]),
                                       (BIST_COLLAR_EN & MASK_TO_MUX[23]),
                                       (BIST_COLLAR_EN & MASK_TO_MUX[22]),
                                       (BIST_COLLAR_EN & MASK_TO_MUX[21]),
                                       (BIST_COLLAR_EN & MASK_TO_MUX[20]),
                                       (BIST_COLLAR_EN & MASK_TO_MUX[19]),
                                       (BIST_COLLAR_EN & MASK_TO_MUX[18]),
                                       (BIST_COLLAR_EN & MASK_TO_MUX[17]),
                                       (BIST_COLLAR_EN & MASK_TO_MUX[16]),
                                       (BIST_COLLAR_EN & MASK_TO_MUX[15]),
                                       (BIST_COLLAR_EN & MASK_TO_MUX[14]),
                                       (BIST_COLLAR_EN & MASK_TO_MUX[13]),
                                       (BIST_COLLAR_EN & MASK_TO_MUX[12]),
                                       (BIST_COLLAR_EN & MASK_TO_MUX[11]),
                                       (BIST_COLLAR_EN & MASK_TO_MUX[10]),
                                       (BIST_COLLAR_EN & MASK_TO_MUX[9]),
                                       (BIST_COLLAR_EN & MASK_TO_MUX[8]),
                                       (BIST_COLLAR_EN & MASK_TO_MUX[7]),
                                       (BIST_COLLAR_EN & MASK_TO_MUX[6]),
                                       (BIST_COLLAR_EN & MASK_TO_MUX[5]),
                                       (BIST_COLLAR_EN & MASK_TO_MUX[4]),
                                       (BIST_COLLAR_EN & MASK_TO_MUX[3]),
                                       (BIST_COLLAR_EN & MASK_TO_MUX[2]),
                                       (BIST_COLLAR_EN & MASK_TO_MUX[1]),
                                       (BIST_COLLAR_EN & MASK_TO_MUX[0]) 
                                      };
   assign MASK_TO_MUX               = {
                                       BIST_ODD_GROUPWRITEENABLE,
                                       BIST_EVEN_GROUPWRITEENABLE,
                                       BIST_ODD_GROUPWRITEENABLE,
                                       BIST_EVEN_GROUPWRITEENABLE,
                                       BIST_ODD_GROUPWRITEENABLE,
                                       BIST_EVEN_GROUPWRITEENABLE,
                                       BIST_ODD_GROUPWRITEENABLE,
                                       BIST_EVEN_GROUPWRITEENABLE,
                                       BIST_ODD_GROUPWRITEENABLE,
                                       BIST_EVEN_GROUPWRITEENABLE,
                                       BIST_ODD_GROUPWRITEENABLE,
                                       BIST_EVEN_GROUPWRITEENABLE,
                                       BIST_ODD_GROUPWRITEENABLE,
                                       BIST_EVEN_GROUPWRITEENABLE,
                                       BIST_ODD_GROUPWRITEENABLE,
                                       BIST_EVEN_GROUPWRITEENABLE,
                                       BIST_ODD_GROUPWRITEENABLE,
                                       BIST_EVEN_GROUPWRITEENABLE,
                                       BIST_ODD_GROUPWRITEENABLE,
                                       BIST_EVEN_GROUPWRITEENABLE,
                                       BIST_ODD_GROUPWRITEENABLE,
                                       BIST_EVEN_GROUPWRITEENABLE,
                                       BIST_ODD_GROUPWRITEENABLE,
                                       BIST_EVEN_GROUPWRITEENABLE,
                                       BIST_ODD_GROUPWRITEENABLE,
                                       BIST_EVEN_GROUPWRITEENABLE,
                                       BIST_ODD_GROUPWRITEENABLE,
                                       BIST_EVEN_GROUPWRITEENABLE,
                                       BIST_ODD_GROUPWRITEENABLE,
                                       BIST_EVEN_GROUPWRITEENABLE,
                                       BIST_ODD_GROUPWRITEENABLE,
                                       BIST_EVEN_GROUPWRITEENABLE,
                                       BIST_ODD_GROUPWRITEENABLE,
                                       BIST_EVEN_GROUPWRITEENABLE,
                                       BIST_ODD_GROUPWRITEENABLE,
                                       BIST_EVEN_GROUPWRITEENABLE 
                                      };

   // Port: MASK }}}

   // Port: WE LogicalPort: ## Type: READWRITE {{{

   // Functional memory control
   assign WE_NOT_GATED              = WE_IN;

   // Disable memory port during logic test
   assign WE                        = WE_NOT_GATED & ~(LV_TM & (MEM_BYPASS_EN | SCAN_SHIFT_EN));
   assign TWE                       = TWE_NOT_GATED & ~(LV_TM & (MEM_BYPASS_EN | SCAN_SHIFT_EN));

   // Control logic during memory test
   assign `MIN_HOLD_DELAY TWE_NOT_GATED                   = (BIST_COLLAR_EN & WE_TO_MUX);
   assign WE_TO_MUX                 = BIST_WRITEENABLE;

   // Port: WE }}}

   // Port: RE LogicalPort: ## Type: READWRITE {{{

   // Functional memory control
   assign RE_NOT_GATED              = RE_IN;

   // Disable memory port during logic test
   assign RE                        = RE_NOT_GATED & ~(LV_TM & (MEM_BYPASS_EN | SCAN_SHIFT_EN));
   assign TRE                       = TRE_NOT_GATED & ~(LV_TM & (MEM_BYPASS_EN | SCAN_SHIFT_EN));

   // Control logic during memory test
   assign `MIN_HOLD_DELAY TRE_NOT_GATED                   = (BIST_COLLAR_EN & RE_TO_MUX);
   assign RE_TO_MUX                 = BIST_READENABLE;

   // Port: RE }}}

   // Port: ME LogicalPort: ## Type: READWRITE {{{

   // Functional memory control
   assign ME_NOT_GATED              = ME_IN;

   // Disable memory port during logic test
   assign ME                        = ME_NOT_GATED & ~(LV_TM & (MEM_BYPASS_EN | SCAN_SHIFT_EN));
   assign TME                       = TME_NOT_GATED & ~(LV_TM & (MEM_BYPASS_EN | SCAN_SHIFT_EN));

   // Control logic during memory test
   assign `MIN_HOLD_DELAY TME_NOT_GATED                   = (BIST_COLLAR_EN & ME_TO_MUX);
   assign ME_TO_MUX                 = BIST_SELECT;

   // Port: ME }}}

//--------------------------
//-- Memory Address Ports --
//--------------------------

   // Port: ADR LogicalPort: ## Type: READWRITE {{{

   // Address logic during memory test
   wire   [0:0]                     BIST_COL_ADD_SHADOW;
   wire   [5:0]                     BIST_ROW_ADD_SHADOW;
   wire   [0:0]                     BIST_BANK_ADD_SHADOW;
   assign BIST_COL_ADD_SHADOW[0] = BIST_COL_ADD[0];
   assign BIST_BANK_ADD_SHADOW[0] = BIST_BANK_ADD[0];
   assign BIST_ROW_ADD_SHADOW[5] = BIST_ROW_ADD[5];
   assign BIST_ROW_ADD_SHADOW[4] = BIST_ROW_ADD[4];
   assign BIST_ROW_ADD_SHADOW[3] = BIST_ROW_ADD[3];
   assign BIST_ROW_ADD_SHADOW[2] = BIST_ROW_ADD[2];
   assign BIST_ROW_ADD_SHADOW[1] = BIST_ROW_ADD[1];
   assign BIST_ROW_ADD_SHADOW[0] = BIST_ROW_ADD[0];
   assign `MIN_HOLD_DELAY TADR      = {
                                         BIST_COL_ADD_SHADOW[0],
                                         BIST_BANK_ADD_SHADOW[0],
                                         BIST_ROW_ADD_SHADOW[5],
                                         BIST_ROW_ADD_SHADOW[4],
                                         BIST_ROW_ADD_SHADOW[3],
                                         BIST_ROW_ADD_SHADOW[2],
                                         BIST_ROW_ADD_SHADOW[1],
                                         BIST_ROW_ADD_SHADOW[0] 
                                      };

   // Port: ADR }}}

//--------------------
//-- Data To Memory --
//--------------------


   // Functional memory data
   assign DIN                       = DIN_IN;
   // Write data during memory test
   assign `MIN_HOLD_DELAY TDIN      = {
                                        DATA_TO_MEM[35],
                                        DATA_TO_MEM[34],
                                        DATA_TO_MEM[33],
                                        DATA_TO_MEM[32],
                                        DATA_TO_MEM[31],
                                        DATA_TO_MEM[30],
                                        DATA_TO_MEM[29],
                                        DATA_TO_MEM[28],
                                        DATA_TO_MEM[27],
                                        DATA_TO_MEM[26],
                                        DATA_TO_MEM[25],
                                        DATA_TO_MEM[24],
                                        DATA_TO_MEM[23],
                                        DATA_TO_MEM[22],
                                        DATA_TO_MEM[21],
                                        DATA_TO_MEM[20],
                                        DATA_TO_MEM[19],
                                        DATA_TO_MEM[18],
                                        DATA_TO_MEM[17],
                                        DATA_TO_MEM[16],
                                        DATA_TO_MEM[15],
                                        DATA_TO_MEM[14],
                                        DATA_TO_MEM[13],
                                        DATA_TO_MEM[12],
                                        DATA_TO_MEM[11],
                                        DATA_TO_MEM[10],
                                        DATA_TO_MEM[9],
                                        DATA_TO_MEM[8],
                                        DATA_TO_MEM[7],
                                        DATA_TO_MEM[6],
                                        DATA_TO_MEM[5],
                                        DATA_TO_MEM[4],
                                        DATA_TO_MEM[3],
                                        DATA_TO_MEM[2],
                                        DATA_TO_MEM[1],
                                        DATA_TO_MEM[0] 
                                      };

//----------------------
//-- Data From Memory --
//----------------------
 
   assign DATA_FROM_MEM             = {
                                       QOUT[35],
                                       QOUT[34],
                                       QOUT[33],
                                       QOUT[32],
                                       QOUT[31],
                                       QOUT[30],
                                       QOUT[29],
                                       QOUT[28],
                                       QOUT[27],
                                       QOUT[26],
                                       QOUT[25],
                                       QOUT[24],
                                       QOUT[23],
                                       QOUT[22],
                                       QOUT[21],
                                       QOUT[20],
                                       QOUT[19],
                                       QOUT[18],
                                       QOUT[17],
                                       QOUT[16],
                                       QOUT[15],
                                       QOUT[14],
                                       QOUT[13],
                                       QOUT[12],
                                       QOUT[11],
                                       QOUT[10],
                                       QOUT[9],
                                       QOUT[8],
                                       QOUT[7],
                                       QOUT[6],
                                       QOUT[5],
                                       QOUT[4],
                                       QOUT[3],
                                       QOUT[2],
                                       QOUT[1],
                                       QOUT[0] 
                                      };
 

//-----------------------
//-- Shared Comparator --
//-----------------------
 
   assign BIST_DATA_FROM_MEM[35]    = DATA_FROM_MEM[35];
   assign BIST_DATA_FROM_MEM[34]    = DATA_FROM_MEM[34];
   assign BIST_DATA_FROM_MEM[33]    = DATA_FROM_MEM[33];
   assign BIST_DATA_FROM_MEM[32]    = DATA_FROM_MEM[32];
   assign BIST_DATA_FROM_MEM[31]    = DATA_FROM_MEM[31];
   assign BIST_DATA_FROM_MEM[30]    = DATA_FROM_MEM[30];
   assign BIST_DATA_FROM_MEM[29]    = DATA_FROM_MEM[29];
   assign BIST_DATA_FROM_MEM[28]    = DATA_FROM_MEM[28];
   assign BIST_DATA_FROM_MEM[27]    = DATA_FROM_MEM[27];
   assign BIST_DATA_FROM_MEM[26]    = DATA_FROM_MEM[26];
   assign BIST_DATA_FROM_MEM[25]    = DATA_FROM_MEM[25];
   assign BIST_DATA_FROM_MEM[24]    = DATA_FROM_MEM[24];
   assign BIST_DATA_FROM_MEM[23]    = DATA_FROM_MEM[23];
   assign BIST_DATA_FROM_MEM[22]    = DATA_FROM_MEM[22];
   assign BIST_DATA_FROM_MEM[21]    = DATA_FROM_MEM[21];
   assign BIST_DATA_FROM_MEM[20]    = DATA_FROM_MEM[20];
   assign BIST_DATA_FROM_MEM[19]    = DATA_FROM_MEM[19];
   assign BIST_DATA_FROM_MEM[18]    = DATA_FROM_MEM[18];
   assign BIST_DATA_FROM_MEM[17]    = DATA_FROM_MEM[17];
   assign BIST_DATA_FROM_MEM[16]    = DATA_FROM_MEM[16];
   assign BIST_DATA_FROM_MEM[15]    = DATA_FROM_MEM[15];
   assign BIST_DATA_FROM_MEM[14]    = DATA_FROM_MEM[14];
   assign BIST_DATA_FROM_MEM[13]    = DATA_FROM_MEM[13];
   assign BIST_DATA_FROM_MEM[12]    = DATA_FROM_MEM[12];
   assign BIST_DATA_FROM_MEM[11]    = DATA_FROM_MEM[11];
   assign BIST_DATA_FROM_MEM[10]    = DATA_FROM_MEM[10];
   assign BIST_DATA_FROM_MEM[9]     = DATA_FROM_MEM[9];
   assign BIST_DATA_FROM_MEM[8]     = DATA_FROM_MEM[8];
   assign BIST_DATA_FROM_MEM[7]     = DATA_FROM_MEM[7];
   assign BIST_DATA_FROM_MEM[6]     = DATA_FROM_MEM[6];
   assign BIST_DATA_FROM_MEM[5]     = DATA_FROM_MEM[5];
   assign BIST_DATA_FROM_MEM[4]     = DATA_FROM_MEM[4];
   assign BIST_DATA_FROM_MEM[3]     = DATA_FROM_MEM[3];
   assign BIST_DATA_FROM_MEM[2]     = DATA_FROM_MEM[2];
   assign BIST_DATA_FROM_MEM[1]     = DATA_FROM_MEM[1];
   assign BIST_DATA_FROM_MEM[0]     = DATA_FROM_MEM[0];
  
 
 
 
 
    assign BIST_CLK_EN  = BIST_RUN | BIST_COLLAR_SETUP|BIST_CLEAR|BIST_CLEAR_DEFAULT|RESET_REG_SETUP2|(BIST_INPUT_SELECT ^ BIST_TESTDATA_SELECT_TO_COLLAR);
//---------------------
//-- BIST_CLK Gating --
//---------------------
wire   INJECT_TCK;      
    assign INJECT_TCK = BIST_SHIFT_COLLAR & ~LV_TM; 
    TS_CLK_GATING_AND tessent_persistent_cell_GATING_BIST_CLK (
        .clk        ( BIST_CLK                    ),
        .ten        ( clock_gating_qualifier_and_o         ),
        .fen        ( BIST_CLK_EN  ),
        .clkcg      ( BIST_CLK_INT                )
    );

  TS_AND clock_gating_qualifier_and(
      .a(fscan_clkungate), .b(LV_TM), .o(clock_gating_qualifier_and_o)
  );
endmodule // hif_pcie_pcie_upp_tcam_mems_rtl_tessent_mbist_TCAM_c1_interface_MEM2



`undef MIN_HOLD_DELAY
`ifdef ADD_TIMEUNIT_TIMEPRECISION
    `undef ADD_TIMEUNIT_TIMEPRECISION
`endif
