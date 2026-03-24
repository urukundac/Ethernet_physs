module pcie_upp_ip783tcam128x36s0c1_0_0_wrap   (
             input logic  [8-2:0]             ADR,

              `ifndef INTEL_NO_PWR_PINS
              `ifdef INTC_ADD_VSS
            input logic  vss     ,
              `endif
            input logic vddp     ,
              `endif              
             input logic               CLK,
             input logic               CMP,
             input logic  [36-1:0]               DIN,
             input logic               DSEL,
             input logic               FLS,
             input logic  [36-1:0]              MASK,
             input logic               ME,
             output logic  [36-1:0]               QOUT,
             output logic  [128-1:0]              QHR,
             output logic               QVLD,
             input logic               RE,
             input logic               RST,
             input logic  [128-1:0]             RVLD,
             input logic              VBE,
             input logic              VBI,
             input logic              WE,
             input logic              DFTSHIFTEN,
             input logic              DFTMASK,
             input logic              DFT_ARRAY_FREEZE,
             input logic              DFT_AFD_RESET_B,
             input logic              BISTE,
             input logic   [6-1:0]         FAF,
             input logic              FAF_EN,

	     // added for MINT lvlib compatibility
             input wire [36-1 : 0] TDIN,
             input wire [8-1 : 0] TADR,
             input wire TVBE,
             input wire TVBI,
             input wire [36-1 : 0] TMASK,
             input wire TWE,
             input wire TRE,
             input wire TME,
             input logic BIST_ROTATE_SR,
             input logic BIST_EN_SR_MASK_B,
             input logic BIST_ALL_MASK,
             input logic BIST_EN_SR_DATA_B,
             input logic BIST_CM_MODE,
             input logic BIST_CM_MATCH_SEL0,
             input logic BIST_CM_MATCH_SEL1,
	     input logic BIST_CM_EN_IN,
	     input logic BIST_MATCHIN_IN,
	     input logic BIST_FLS,
             input logic     [15:0]         MDST_tcam

             , input wire BIST_SETUP, input wire mcp_bounding_to_en, 
             input wire scan_to_en, input wire memory_bypass_to_en, 
             input wire ltest_to_en, input wire BIST_USER9, 
             input wire BIST_USER10, input wire BIST_USER11, 
             input wire BIST_USER0, input wire BIST_USER1, 
             input wire BIST_USER2, input wire BIST_USER3, 
             input wire BIST_USER4, input wire BIST_USER5, 
             input wire BIST_USER6, input wire BIST_USER7, 
             input wire BIST_USER8, input wire BIST_EVEN_GROUPWRITEENABLE, 
             input wire BIST_ODD_GROUPWRITEENABLE, input wire BIST_WRITEENABLE, 
             input wire BIST_READENABLE, input wire BIST_SELECT, 
             input wire [0:0] BIST_COL_ADD, input wire [5:0] BIST_ROW_ADD, 
             input wire [0:0] BIST_BANK_ADD, input wire BIST_COLLAR_EN0, 
             input wire BIST_RUN_TO_COLLAR0, input wire BIST_ASYNC_RESET, 
             input wire BIST_TESTDATA_SELECT_TO_COLLAR, 
             input wire BIST_ON_TO_COLLAR, input wire [31:0] BIST_WRITE_DATA, 
             input wire BIST_SHIFT_COLLAR, input wire BIST_COLLAR_SETUP, 
             input wire BIST_CLEAR_DEFAULT, input wire BIST_CLEAR, 
             input wire BIST_COLLAR_HOLD, 
             output wire [35:0] BIST_DATA_FROM_MEM, 
             input wire MBISTPG_RESET_REG_SETUP2, 
             input wire bisr_shift_en_pd_vinf, input wire bisr_clk_pd_vinf, 
             input wire bisr_reset_pd_vinf, input wire bisr_si_pd_vinf, 
             output wire tcam_row_0_col_0_bisr_inst_SO, 
             input wire [6:0] MEM1_All_SCOL0_FUSE_REG, 
             output wire [6:0] tcam_row_0_col_0_bisr_inst_Q_ts1, 
             input wire fscan_clkungate);


                 
                 wire [35:0] TMASK_ts1;
                 wire [7:0] TADR_ts1;
                 wire [35:0] DIN_ts1, TDIN_ts1;
                 wire FLS_ts1, TVBE_ts1, TVBI_ts1, BISTE_ts1, BIST_CM_MODE_ts1, 
                      BIST_CM_EN_IN_ts1, BIST_CM_MATCH_SEL0_ts1, 
                      BIST_CM_MATCH_SEL1_ts1, BIST_ROTATE_SR_ts1, 
                      BIST_ALL_MASK_ts1, BIST_EN_SR_DATA_B_ts1, 
                      BIST_EN_SR_MASK_B_ts1, BIST_MATCHIN_IN_ts1, BIST_FLS_ts1, 
                      tcam_row_0_col_0_interface_inst_WE, TWE_ts1, 
                      tcam_row_0_col_0_interface_inst_RE, TRE_ts1, 
                      tcam_row_0_col_0_interface_inst_ME, TME_ts1;
                 wire [6:0] tcam_row_0_col_0_bisr_inst_Q;
                 ip783tcam128x36s0c1_dft_wrp #(        
                         )               

                         tcam_row_0_col_0 (
              `ifndef INTEL_NO_PWR_PINS
              `ifdef INTC_ADD_VSS
                .vss              (vss),
              `endif
                .vddp             (vddp),
              `endif    
                 .ADR               ({1'b0,ADR}), //input adr_intess
                 .ME                (tcam_row_0_col_0_interface_inst_ME),  

                 .CLK               (CLK), //Clock
                 .CMP               (CMP), //Control Enable
                 .DIN               (DIN_ts1), 
                 .DSEL              (DSEL), //dncen enables access of the TCAM Arrays adr_intessed
                 .FLS               (FLS_ts1), //flush initiates a Flush operation that resets all Valid
                 .RVLD              (RVLD ), //Row validation bus. Each match_in input controls 1
                 .MASK              (MASK), //logic msk
                 .QOUT              (QOUT), //output vben
                 .QHR               (QHR),
                 .QVLD              (), 
                 .RE                (tcam_row_0_col_0_interface_inst_RE), //Read Enable
                 .RST               (RST), //Asynchronous Active-High Reset
                 .VBE               (VBE), //vben enables the Valid Bit addressed by adr[a-1:0] to
                 .VBI               (VBI),//  Valid Bit input
                 .WE                (tcam_row_0_col_0_interface_inst_WE), //Write Enable
                 .FAF               (tcam_row_0_col_0_bisr_inst_Q[6:1]),
                 .FAF_EN            (tcam_row_0_col_0_bisr_inst_Q[0]),
                 .DFTSHIFTEN        (DFTSHIFTEN),
                 .DFTMASK           (DFTMASK),
                 .DFT_ARRAY_FREEZE  (DFT_ARRAY_FREEZE),
                 .DFT_AFD_RESET_B   (DFT_AFD_RESET_B),
                 .BISTE             (BISTE_ts1),
                 .TDIN (TDIN_ts1),
                 .TADR (TADR_ts1),
                 .TVBE (TVBE_ts1),
                 .TVBI (TVBI_ts1),
                 .TMASK (TMASK_ts1),
                 .TWE (TWE_ts1),
                 .TRE (TRE_ts1),
                 .TME (TME_ts1),
                 .BIST_ROTATE_SR (BIST_ROTATE_SR_ts1),
                 .BIST_EN_SR_MASK_B (BIST_EN_SR_MASK_B_ts1),
                 .BIST_ALL_MASK (BIST_ALL_MASK_ts1),
                 .BIST_EN_SR_DATA_B (BIST_EN_SR_DATA_B_ts1),
                 .BIST_CM_MODE (BIST_CM_MODE_ts1),
                 .BIST_CM_EN_IN (BIST_CM_EN_IN_ts1),
                 .BIST_CM_MATCH_SEL0 (BIST_CM_MATCH_SEL0_ts1),
                 .BIST_CM_MATCH_SEL1 (BIST_CM_MATCH_SEL1_ts1),
                 .BIST_MATCHIN_IN (BIST_MATCHIN_IN_ts1),
                 .BIST_FLS (BIST_FLS_ts1),
                 .MDST_tcam                (MDST_tcam)
             );


  hif_pcie_pcie_upp_tcam_mems_rtl_tessent_mbist_TCAM_c1_interface_MEM1 tcam_row_0_col_0_interface_inst(
      .FLS_IN(FLS), .TVBE_IN(TVBE), .TVBI_IN(TVBI), .BIST_CM_MODE_IN(BIST_CM_MODE), 
      .BIST_CM_EN_IN_IN(BIST_CM_EN_IN), .BIST_CM_MATCH_SEL0_IN(BIST_CM_MATCH_SEL0), 
      .BIST_CM_MATCH_SEL1_IN(BIST_CM_MATCH_SEL1), .BIST_ROTATE_SR_IN(BIST_ROTATE_SR), 
      .BIST_ALL_MASK_IN(BIST_ALL_MASK), .BIST_EN_SR_DATA_B_IN(BIST_EN_SR_DATA_B), 
      .BIST_EN_SR_MASK_B_IN(BIST_EN_SR_MASK_B), .BIST_MATCHIN_IN_IN(BIST_MATCHIN_IN), 
      .BIST_FLS_IN(BIST_FLS), .WE_IN(WE), .RE_IN(RE), .ME_IN(ME), .QOUT(QOUT), 
      .DIN_IN(DIN), .BIST_USER9(BIST_USER9), .BIST_USER10(BIST_USER10), .BIST_USER11(BIST_USER11), 
      .BIST_USER0(BIST_USER0), .BIST_USER1(BIST_USER1), .BIST_USER2(BIST_USER2), 
      .BIST_USER3(BIST_USER3), .BIST_USER4(BIST_USER4), .BIST_USER5(BIST_USER5), 
      .BIST_USER6(BIST_USER6), .BIST_USER7(BIST_USER7), .BIST_USER8(BIST_USER8), 
      .BIST_EVEN_GROUPWRITEENABLE(BIST_EVEN_GROUPWRITEENABLE), .BIST_ODD_GROUPWRITEENABLE(BIST_ODD_GROUPWRITEENABLE), 
      .BIST_WRITEENABLE(BIST_WRITEENABLE), .BIST_READENABLE(BIST_READENABLE), .BIST_SELECT(BIST_SELECT), 
      .BIST_COL_ADD(BIST_COL_ADD), .BIST_ROW_ADD(BIST_ROW_ADD[5:0]), .BIST_BANK_ADD(BIST_BANK_ADD), 
      .BIST_WRITE_DATA(BIST_WRITE_DATA[31:0]), .BIST_TESTDATA_SELECT_TO_COLLAR(BIST_TESTDATA_SELECT_TO_COLLAR), 
      .MEM_BYPASS_EN(memory_bypass_to_en), .SCAN_SHIFT_EN(scan_to_en), .MCP_BOUNDING_EN(mcp_bounding_to_en), 
      .BIST_ON(BIST_ON_TO_COLLAR), .BIST_RUN(BIST_RUN_TO_COLLAR0), .BIST_ASYNC_RESETN(BIST_ASYNC_RESET), 
      .BIST_CLK(CLK), .BIST_SHIFT_COLLAR(BIST_SHIFT_COLLAR), .BIST_COLLAR_SETUP(BIST_COLLAR_SETUP), 
      .BIST_COLLAR_HOLD(BIST_COLLAR_HOLD), .BIST_CLEAR_DEFAULT(BIST_CLEAR_DEFAULT), 
      .BIST_CLEAR(BIST_CLEAR), .BIST_SETUP0(BIST_SETUP), .LV_TM(ltest_to_en), .BIST_COLLAR_EN(BIST_COLLAR_EN0), 
      .RESET_REG_SETUP2(MBISTPG_RESET_REG_SETUP2), .FLS(FLS_ts1), .TVBE(TVBE_ts1), 
      .TVBI(TVBI_ts1), .BISTE(BISTE_ts1), .BIST_CM_MODE(BIST_CM_MODE_ts1), .BIST_CM_EN_IN(BIST_CM_EN_IN_ts1), 
      .BIST_CM_MATCH_SEL0(BIST_CM_MATCH_SEL0_ts1), .BIST_CM_MATCH_SEL1(BIST_CM_MATCH_SEL1_ts1), 
      .BIST_ROTATE_SR(BIST_ROTATE_SR_ts1), .BIST_ALL_MASK(BIST_ALL_MASK_ts1), .BIST_EN_SR_DATA_B(BIST_EN_SR_DATA_B_ts1), 
      .BIST_EN_SR_MASK_B(BIST_EN_SR_MASK_B_ts1), .BIST_MATCHIN_IN(BIST_MATCHIN_IN_ts1), 
      .BIST_FLS(BIST_FLS_ts1), .TMASK(TMASK_ts1), .WE(tcam_row_0_col_0_interface_inst_WE), 
      .TWE(TWE_ts1), .RE(tcam_row_0_col_0_interface_inst_RE), .TRE(TRE_ts1), .ME(tcam_row_0_col_0_interface_inst_ME), 
      .TME(TME_ts1), .TADR(TADR_ts1), .DIN(DIN_ts1), .TDIN(TDIN_ts1), .BIST_DATA_FROM_MEM(BIST_DATA_FROM_MEM[35:0]), 
      .fscan_clkungate(fscan_clkungate)
  );

  hif_pcie_pcie_upp_tcam_mems_rtl_tessent_mbisr_register_ip783tcam128x36s0c1_dft_wrp tcam_row_0_col_0_bisr_inst(
      .CLK(bisr_clk_pd_vinf), .RSTB(bisr_reset_pd_vinf), .SI(bisr_si_pd_vinf), 
      .SO(tcam_row_0_col_0_bisr_inst_SO), .SE(bisr_shift_en_pd_vinf), .D(MEM1_All_SCOL0_FUSE_REG[6:0]), 
      .MSO(1'b0), .MSEL(1'b0), .Q(tcam_row_0_col_0_bisr_inst_Q)
  );

  assign tcam_row_0_col_0_bisr_inst_Q_ts1[0] = tcam_row_0_col_0_bisr_inst_Q[0];

  assign tcam_row_0_col_0_bisr_inst_Q_ts1[1] = tcam_row_0_col_0_bisr_inst_Q[1];

  assign tcam_row_0_col_0_bisr_inst_Q_ts1[2] = tcam_row_0_col_0_bisr_inst_Q[2];

  assign tcam_row_0_col_0_bisr_inst_Q_ts1[3] = tcam_row_0_col_0_bisr_inst_Q[3];

  assign tcam_row_0_col_0_bisr_inst_Q_ts1[4] = tcam_row_0_col_0_bisr_inst_Q[4];

  assign tcam_row_0_col_0_bisr_inst_Q_ts1[5] = tcam_row_0_col_0_bisr_inst_Q[5];

  assign tcam_row_0_col_0_bisr_inst_Q_ts1[6] = tcam_row_0_col_0_bisr_inst_Q[6];
endmodule

