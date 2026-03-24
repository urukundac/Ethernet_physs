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
`include        "hlp_mod_mem.def"

`ifdef HLP_FPGA_TCAM_MEMS
        `ifndef HLP_FPGA_VELOCE_MEMS
                `define HLP_FPGA_NO_VELOCE_MEMS
        `endif
`endif

module  hlp_mod_wrap_tcam_mod_tx_stats_vlan_cnt_idx_map_tcam_shell_512x24 #(
        parameter       TCAM_WIDTH                              = 40                                                                                                            , //
        parameter       TCAM_RULES_NUM                          = 512                                                                                                           , //
        parameter       TCAM_RD_DELAY                           = 3                                                                                                             , //
        parameter       TCAM_WR_DELAY                           = 1                                                                                                             , //
        parameter       TCAM_CHK_DELAY                          = 2                                                                                                             , //    
        parameter       TCAM_RD_WAIT_UNTIL_RDY                  = 1                                                                                                             , //
        parameter       TCAM_WR_WAIT_UNTIL_RDY                  = 1                                                                                                             , //
        parameter       TCAM_SLICE_SIZE                         = 64                                                                                                            , //
        parameter       TCAM_SLICE_EN_WIDTH                     = TCAM_RULES_NUM/TCAM_SLICE_SIZE                                                                                , //
        parameter       BCAM_RELIEF                             = 0                                                                                                             , //
        parameter       TCAM_DEPTH                              = 2*TCAM_RULES_NUM                                                                                                , //
        parameter       TCAM_ADR_WIDTH                          = $clog2(TCAM_DEPTH)                                                                                            , //
        parameter       TCAM_INIT_TYPE                          = 0                                                                                                             , //
        parameter       FPGA_CLOCKS_RATIO                       = 100                                                                                                           , //
        parameter       FPGA_MARGIN                             = 0                                                                                                             , //
        parameter       TCAM_PROTECTION_TYPE                    = 0                                                                                                             , //
        parameter       TCAM_PATRN0_EXP_RESET_VALUE             = 0                                                                                                             , //
        parameter       TCAM_PATRN1_EXP_RESET_VALUE             = 0                                                                                                             , //
        parameter       TCAM_E0_INIT_VALUE                      = ~(TCAM_WIDTH'(0))                                                                                             , //
        parameter       TCAM_E1_INIT_VALUE                      = ~(TCAM_WIDTH'(0))                                                                                             , //
        parameter       TCAM_ANALOG_TUNE_CONFG_WIDTH            = `HLP_TCAM_ANALOG_TUNE_CONFG_WIDTH                                                                         , //
        parameter       FROM_TCAM_WIDTH                         = TCAM_WIDTH + TCAM_RULES_NUM + 1 + 1 + 1 + 1 + 1 + 1                                                           , //
        parameter       TO_TCAM_WIDTH                           = TCAM_SLICE_EN_WIDTH + 1 + TCAM_ANALOG_TUNE_CONFG_WIDTH + 3 + 1 + 1 + 1 + TCAM_ADR_WIDTH + TCAM_WIDTH + 1 + 2*TCAM_WIDTH + TCAM_RULES_NUM   ,     //
        parameter       TCAM_NO_DELAY                           = 1     //
                // DFx Memory Parameters
                ,
                parameter MSWT_MODE                     = 0                                                                             ,
                parameter BYPASS_CLK_MUX                = 0                                                                             ,                
                parameter BYPASS_AFD_SYNC               = 1                                                                             ,
                parameter BYPASS_RST_B_SYNC             = 1                                                                             ,
                parameter BYPASS_MBIST_EN_SYNC          = 0                                                                             ,
                parameter WRAPPER_REDROW_ENABLE         = 0                                                                             ,
                parameter WRAPPER_COL_REPAIR            = 1                                                                             ,
                parameter NFUSEMISC_SRAM                = 17                                                                            ,
                parameter PWR_MGMT_IN_SIZE              = 6                                                                             ,                
                parameter NFUSERED_TCAM                 = $clog2(TCAM_WIDTH) + 1                                                        ,
                parameter TOTAL_MEMORY_INSTANCE         = 1                                                       
)(
        // Memory General Interface
        input  logic                                                 clk                             ,
        `ifdef HLP_FPGA_TCAM_MEMS
        input  logic                                                 fpga_fast_clk                   ,
        `endif
        input  logic         [  TO_TCAM_WIDTH-1:0]                   wrap_shell_to_tcam              ,
        output  wire         [FROM_TCAM_WIDTH-1:0]                   wrap_shell_from_tcam    
        // Memory DFx Interface 
       , 
        input                                                   fscan_mode                      ,
        input                                                   fscan_clkungate                 ,
        input                                                   fscan_shiften                   ,
        input           [15:0]                                  fary_ffuse_tune_tcam            ,
        input                                                   fary_output_reset               ,
        input                                                   fary_isolation_control_in       ,
        input                                                   fary_ffuse_tcam_sleep           ,        
        input                                                   fsta_dfxact_afd                 ,        
        input                                                   ip_reset_b                      ,             
        input                                                   fscan_ram_bypsel_tcam           ,
        input                                                   fscan_ram_init_en               ,
        input                                                   fscan_ram_init_val              ,
        input                                                   fscan_ram_rdis_b                ,
        input                                                   fscan_ram_wdis_b                ,
        input                                                   DFTSHIFTEN                      ,
        input                                                   DFTMASK                         ,
        input                                                   DFT_ARRAY_FREEZE                ,
        input                                                   DFT_AFD_RESET_B                 ,
//clc - MGM tool not replacing *num_of_inst*
//clc        input         [*num_of_inst*-1:0]                      fscan_sin                       ,
        input                                                   fary_pwren_b_tcam               ,
        output                                                  aary_pwren_b_tcam               
//clc        output        [*num_of_inst*-1:0]                      fscan_sout
 

       
        , input wire BIST_SETUP, input wire BIST_SETUP_ts1, 
        input wire BIST_SETUP_ts2, input wire to_interfaces_tck, 
        input wire mcp_bounding_to_en, input wire scan_to_en, 
        input wire memory_bypass_to_en, input wire GO_ID_REG_SEL, 
        input wire BIST_CLEAR_BIRA, input wire BIST_COLLAR_DIAG_EN, 
        input wire BIST_COLLAR_BIRA_EN, input wire BIST_SHIFT_BIRA_COLLAR, 
        input wire CHECK_REPAIR_NEEDED, input wire MEM4_BIST_COLLAR_SI, 
        output wire BIST_SO, output wire BIST_GO, input wire ltest_to_en, 
        input wire BIST_USER9, input wire BIST_USER10, input wire BIST_USER11, 
        input wire BIST_USER0, input wire BIST_USER1, input wire BIST_USER2, 
        input wire BIST_USER3, input wire BIST_USER4, input wire BIST_USER5, 
        input wire BIST_USER6, input wire BIST_USER7, input wire BIST_USER8, 
        input wire BIST_EVEN_GROUPWRITEENABLE, 
        input wire BIST_ODD_GROUPWRITEENABLE, input wire BIST_WRITEENABLE, 
        input wire BIST_READENABLE, input wire BIST_SELECT, 
        input wire BIST_CMP, input wire INCLUDE_MEM_RESULTS_REG, 
        input wire [0:0] BIST_COL_ADD, input wire [5:0] BIST_ROW_ADD, 
        input wire [2:0] BIST_BANK_ADD, input wire BIST_COLLAR_EN4, 
        input wire BIST_RUN_TO_COLLAR4, input wire BIST_ASYNC_RESET, 
        input wire BIST_TESTDATA_SELECT_TO_COLLAR, 
        input wire BIST_ON_TO_COLLAR, input wire [23:0] BIST_WRITE_DATA, 
        input wire [23:0] BIST_EXPECT_DATA, input wire BIST_SHIFT_COLLAR, 
        input wire BIST_COLLAR_SETUP, input wire BIST_CLEAR_DEFAULT, 
        input wire BIST_CLEAR, input wire [1:0] BIST_COLLAR_OPSET_SELECT, 
        input wire BIST_COLLAR_HOLD, input wire FREEZE_STOP_ERROR, 
        input wire ERROR_CNT_ZERO, input wire MBISTPG_RESET_REG_SETUP2, 
        input wire bisr_shift_en_pd_vinf, input wire bisr_clk_pd_vinf, 
        input wire bisr_reset_pd_vinf, 
        input wire tcam_row_0_col_0_bisr_inst_SO, 
        output wire tcam_row_0_col_0_bisr_inst_SO_ts1, 
        input wire fscan_mode_ts1);

//-------------------------------
//      Gen MEM Interface
//-------------------------------

typedef struct packed{
        logic                                                   reset_n                 ;
        logic   [        TCAM_ANALOG_TUNE_CONFG_WIDTH-1:0]      analog_tune_confg       ;
        logic                                                   init_done               ;
        logic                                                   ecc_en                  ;
        logic                                                   ecc_invert_1            ;
        logic                                                   ecc_invert_2            ;       
        logic   [                      TCAM_ADR_WIDTH-1:0]      adr                     ;
        logic                                                   rd_en                   ;
        logic                                                   wr_en                   ;
        logic   [                          TCAM_WIDTH-1:0]      wr_data                 ;
        logic                                                   chk_en                  ;
        logic   [                          TCAM_WIDTH-1:0]      chk_key                 ;
        logic   [                          TCAM_WIDTH-1:0]      chk_mask                ;
        logic                                                   flush                   ;
        logic   [                 TCAM_SLICE_EN_WIDTH-1:0]      slice_en                ;
        logic   [                      TCAM_RULES_NUM-1:0]      raw_hit_in              ;       
        logic                                                   tcam_check_err_dis      ;
        logic                                                   tcam_update_dis         ;
//clc        logic                                                   x_ybar_sel              ;

} to_tcam_t;

typedef struct packed{
        logic   [                          TCAM_WIDTH-1:0]      rd_data                 ;
        logic                                                   tcam_rd_valid           ;
        logic                                                   tcam_wr_ack             ;
        logic                                                   tcam_chk_valid          ;
        logic                                                   tcam_rdwr_rdy           ;
        logic                                                   tcam_chk_rdy            ;       
        logic   [                      TCAM_RULES_NUM-1:0]      raw_hit_out             ;
        logic                                                   ecc_err_det             ;       
} from_tcam_t;

to_tcam_t       to_tcam_bus     ;
from_tcam_t     from_tcam_bus   ;

localparam PHYSICAL_ROW_WIDTH = TCAM_WIDTH;
// Disassembling the to_tcam bus


  wire [23:0] DIN, TMASK;
  wire [9:0] TADR;
  wire [23:0] TDIN;
  wire [5:0] tcam_row_0_col_0_bisr_inst_Q;
  wire tcam_row_0_col_0_interface_inst_WE, tcam_row_0_col_0_interface_inst_ME, 
       FLS, TVBE, TVBI, BISTE, BIST_CM_MODE, BIST_CM_EN_IN, BIST_CM_MATCH_SEL0, 
       BIST_CM_MATCH_SEL1, BIST_ROTATE_SR, BIST_ALL_MASK, BIST_EN_SR_DATA_B, 
       BIST_EN_SR_MASK_B, BIST_MATCHIN_IN, BIST_FLS, TWE, 
       tcam_row_0_col_0_interface_inst_RE, TRE, TME, All_SCOL0_ALLOC_REG;
  wire [4:0] All_SCOL0_FUSE_REG;
assign                                                  to_tcam_bus             = wrap_shell_to_tcam            ;
wire                                                    reset_n                 = to_tcam_bus.reset_n           ;
wire    [        TCAM_ANALOG_TUNE_CONFG_WIDTH-1:0]      analog_tune_confg       = to_tcam_bus.analog_tune_confg ;
wire                                                    tcam_init_done          = to_tcam_bus.init_done         ;
wire                                                    tcam_ecc_en             = to_tcam_bus.ecc_en            ;
wire                                                    tcam_ecc_invert_1       = to_tcam_bus.ecc_invert_1      ;
wire                                                    tcam_ecc_invert_2       = to_tcam_bus.ecc_invert_2      ;
wire    [                      TCAM_ADR_WIDTH-1:0]      adr_pre                 = to_tcam_bus.adr               ;
wire                                                    rd_en_pre               = to_tcam_bus.rd_en             ;
wire                                                    wr_en_pre               = to_tcam_bus.wr_en             ;
wire    [                          TCAM_WIDTH-1:0]      wr_data_pre             = to_tcam_bus.wr_data           ;
wire                                                    chk_en_pre              = to_tcam_bus.chk_en            ;
wire    [                          TCAM_WIDTH-1:0]      chk_key_pre             = to_tcam_bus.chk_key           ;
wire    [                          TCAM_WIDTH-1:0]      chk_mask_pre            = to_tcam_bus.chk_mask          ;
wire    [                 TCAM_SLICE_EN_WIDTH-1:0]      slice_en_pre            = to_tcam_bus.slice_en          ;
wire    [                      TCAM_RULES_NUM-1:0]      raw_hit_in_pre          = to_tcam_bus.raw_hit_in        ;
wire                                                    chk_err_dis             = to_tcam_bus.tcam_check_err_dis;
wire                                                    update_dis              = to_tcam_bus.tcam_update_dis   ;
//clc wire                                                    x_ybar_sel              = to_tcam_bus.x_ybar_sel   ;

wire    [                      TCAM_ADR_WIDTH-1:0]      adr                                                     ;               
wire                                                    rd_en                                                   ;
wire                                                    wr_en                                                   ;
wire    [                          TCAM_WIDTH-1:0]      wr_data                                                 ;
wire                                                    chk_en                                                  ;
wire    [                          TCAM_WIDTH-1:0]      chk_key                                                 ;
wire    [                          TCAM_WIDTH-1:0]      chk_mask                                                ;
wire    [                          TCAM_WIDTH-1:0]      chk_mask_int                                            ;
wire    [                 TCAM_SLICE_EN_WIDTH-1:0]      slice_en                                                ;
wire    [                      TCAM_RULES_NUM-1:0]      raw_hit_in                                              ;

// Assembling the from_tcam bus

logic   [                          TCAM_WIDTH-1:0]      rd_data_pre             ;
logic                                                   tcam_rd_valid_pre       ;       
logic                                                   tcam_wr_ack_pre         ;
logic                                                   tcam_chk_valid_pre      ;
logic                                                   tcam_rdwr_rdy_pre       ;
logic                                                   tcam_chk_rdy_pre        ;
logic   [                      TCAM_RULES_NUM-1:0]      raw_hit_out_pre         ;

logic   [                          TCAM_WIDTH-1:0]      rd_data                 ;
logic                                                   tcam_rd_valid           ;
logic                                                   tcam_wr_ack             ;
logic                                                   tcam_chk_valid          ;
logic                                                   tcam_rdwr_rdy           ;
logic                                                   tcam_chk_rdy            ;
logic   [                      TCAM_RULES_NUM-1:0]      raw_hit_out             ;

logic                                                   ecc_err_det             ;

assign                                                  wrap_shell_from_tcam            = from_tcam_bus                 ;
assign                                                  from_tcam_bus.tcam_rd_valid     = tcam_rd_valid_pre             ;
assign                                                  from_tcam_bus.tcam_wr_ack       = tcam_wr_ack_pre               ;
assign                                                  from_tcam_bus.tcam_chk_valid    = tcam_chk_valid_pre            ;
assign                                                  from_tcam_bus.tcam_rdwr_rdy     = tcam_rdwr_rdy_pre             ;
assign                                                  from_tcam_bus.tcam_chk_rdy      = tcam_chk_rdy_pre              ;
assign                                                  from_tcam_bus.rd_data           = rd_data_pre                   ;
assign                                                  from_tcam_bus.raw_hit_out       = raw_hit_out_pre               ;
assign                                                  from_tcam_bus.ecc_err_det       = ecc_err_det                   ;

hlp_mgm_tcam_col_sweeper #(
        .TCAM_CHK_DELAY                 (TCAM_CHK_DELAY)                        ,
        .TCAM_RULES_NUM                 (TCAM_RULES_NUM)                        ,
        .TCAM_WIDTH                     (TCAM_WIDTH)                            ,
        .TCAM_SLICE_EN_WIDTH            (TCAM_SLICE_EN_WIDTH)                   ,
        .BCAM_RELIEF                    (BCAM_RELIEF)                           ,
        .TCAM_PROTECTION_TYPE           (TCAM_PROTECTION_TYPE)                  ,
        .TCAM_PATRN0_EXP_RESET_VALUE    (TCAM_PATRN0_EXP_RESET_VALUE)           ,
        .TCAM_PATRN1_EXP_RESET_VALUE    (TCAM_PATRN1_EXP_RESET_VALUE)           ,
        .TSMC_N7                        (0)
) tcam_col_sweeper (
        // General
        .clk                            (clk)                                   ,
        .rst_n                          (reset_n)                               ,
        // Functional I/F From Shell
        .adr_pre                        (adr_pre[TCAM_ADR_WIDTH-1:0])           ,
        .rd_en_pre                      (rd_en_pre)                             ,
        .wr_en_pre                      (wr_en_pre)                             ,       
        .wr_data_pre                    (wr_data_pre[TCAM_WIDTH-1:0])           ,
        .rd_data_pre                    (rd_data_pre[TCAM_WIDTH-1:0])           ,
        .chk_en_pre                     (chk_en_pre)                            ,
        .slice_en_pre                   (slice_en_pre[TCAM_SLICE_EN_WIDTH-1:0]) ,
        .hit_arr_in_pre                 (raw_hit_in_pre[TCAM_RULES_NUM-1:0])    ,
        .chk_key_pre                    (chk_key_pre[TCAM_WIDTH-1:0])           ,
        .chk_mask_pre                   (chk_mask_pre[TCAM_WIDTH-1:0])          ,
        .flush_pre                      ('0)                                    ,
        .hit_arr_out_pre                (raw_hit_out_pre[TCAM_RULES_NUM-1:0])   ,
        .tcam_rd_valid_pre              (tcam_rd_valid_pre)                     ,
        .tcam_wr_ack_pre                (tcam_wr_ack_pre)                       ,
        .tcam_chk_valid_pre             (tcam_chk_valid_pre)                    ,
        .tcam_rdwr_rdy_pre              (tcam_rdwr_rdy_pre)                     ,
        .tcam_chk_rdy_pre               (tcam_chk_rdy_pre)                      ,
        // Functional I/F To Shell
        .adr_pst                        (adr[TCAM_ADR_WIDTH-1:0])               ,
        .ce_pst                         ()                                      ,
        .rd_en_pst                      (rd_en)                                 ,
        .wr_en_pst                      (wr_en)                                 ,
        .wr_data_pst                    (wr_data[TCAM_WIDTH-1:0])               ,
        .rd_data_pst                    (rd_data[TCAM_WIDTH-1:0])               ,
        .chk_en_pst                     (chk_en)                                ,
        .slice_en_pst                   (slice_en[TCAM_SLICE_EN_WIDTH-1:0])     ,
        .hit_arr_in_pst                 (raw_hit_in[TCAM_RULES_NUM-1:0])        ,
        .chk_key_pst                    (chk_key[TCAM_WIDTH-1:0])               ,
        .chk_mask_pst                   (chk_mask_int[TCAM_WIDTH-1:0])          ,
        .hit_arr_out_pst                (raw_hit_out[TCAM_RULES_NUM-1:0])       ,
        .tcam_rd_valid_pst              (tcam_rd_valid)                         ,
        .tcam_wr_ack_pst                (tcam_wr_ack)                           ,
        .tcam_chk_valid_pst             (tcam_chk_valid)                        ,
        .tcam_rdwr_rdy_pst              (tcam_rdwr_rdy)                         ,
        .tcam_chk_rdy_pst               (tcam_chk_rdy)                          ,       
        // Protection related I/F
        .tcam_check_err_dis             (chk_err_dis)                           ,
        .tcam_update_dis                (update_dis)                            ,
        .tcam_init_done                 (tcam_init_done)                        ,
        .tcam_prot_en                   (tcam_ecc_en)                           ,
        .tcam_invert_0                  (tcam_ecc_invert_1)                     ,
        .tcam_invert_1                  (tcam_ecc_invert_2)                     ,
        .tcam_ecc_err_det               (ecc_err_det)
);

     // Match In Array 

         logic    [TCAM_RULES_NUM-1:0]      tcam_match_in;
         always_comb begin 
                tcam_match_in = raw_hit_in;
                if (wr_en) begin 
                    tcam_match_in[adr[TCAM_ADR_WIDTH-1:1]] = 1'b0;
                end
        end

`ifdef INTEL_DC
        `ifndef HLP_MOD_ASIC_MEMS_EXCLUDE
                `define HLP_MOD_ASIC_MEMS
        `endif
`endif

        // Memories Implementation
`ifdef HLP_MOD_ASIC_MEMS      

////////////////////////////////////////////////////////////////////////
//
//                              ASIC MEMORIES                                                                                                                   
//
////////////////////////////////////////////////////////////////////////

localparam TCAM_SLICE_EN_FACT = 512/64;
localparam TCAM_SLICE_EN_MIN = TCAM_SLICE_EN_FACT < TCAM_SLICE_EN_WIDTH ? TCAM_SLICE_EN_FACT : TCAM_SLICE_EN_WIDTH;



    // TCAM Row Select

    wire    [1-1:0]                tcam_row_sel;
    assign                    tcam_row_sel[0]        = 1'b1;


    // TCAM Address Decoder

    wire    [10-1:0]        tcam_row_adr[1-1:0];
    assign                    tcam_row_adr[0][10-1:0]    =  tcam_row_sel[0] ? adr - 10'd0 : 10'd0;


    // TCAM Read Enable Decoder

    wire    [1-1:0]        tcam_row_rd_en;
    assign            tcam_row_rd_en[0]        = tcam_row_sel[0] ? rd_en : 1'b0;


    // TCAM Write Enable Decoder

    wire    [1-1:0]        tcam_row_wr_en;
    assign            tcam_row_wr_en[0]        = tcam_row_sel[0] ? wr_en : 1'b0;


    // Read Delay

    reg            rd_en_nope_done;
    reg    [1-1:0]    rd_en_delay_inst[TCAM_RD_DELAY:0];
    logic   [TCAM_RD_DELAY:0]               rd_en_delay;
    always_comb
         begin
        rd_en_delay_inst[0][1-1:0]        = tcam_row_rd_en[1-1:0];
        for (int i = 0; i <= TCAM_RD_DELAY; i = i + 1) begin
                rd_en_delay[i]    = | rd_en_delay_inst[i];
        end
    end
    always_ff @(posedge clk)
        for (int i = 0; i <= (TCAM_RD_DELAY - 1); i = i + 1) begin
                rd_en_delay_inst[i+1]        <= rd_en_delay_inst[i];
        end

    always_ff @(posedge clk or negedge reset_n) begin
        if (!reset_n)
            rd_en_nope_done        <= 1'b1;
        else if (rd_en && !rd_en_delay[TCAM_RD_WAIT_UNTIL_RDY])
            rd_en_nope_done        <= TCAM_NO_DELAY ? 1'b1 : 1'b0;
        else if (rd_en_delay[TCAM_RD_WAIT_UNTIL_RDY])
            rd_en_nope_done        <= 1'b1;
        end


    // Write Delay

    reg            wr_en_nope_done;
    reg    [1-1:0]    wr_en_delay_inst[TCAM_WR_DELAY:0];
    logic    [TCAM_WR_DELAY:0]               wr_en_delay;
    always_comb
         begin
        wr_en_delay_inst[0][1-1:0]        = tcam_row_wr_en[1-1:0];
        for (int i = 0; i <= TCAM_WR_DELAY; i = i + 1) begin
                wr_en_delay[i]    = | wr_en_delay_inst[i];
        end
    end
    always_ff @(posedge clk)
        for (int i = 0; i <= (TCAM_WR_DELAY - 1); i = i + 1) begin
                wr_en_delay_inst[i+1]        <= wr_en_delay_inst[i];
        end

    always_ff @(posedge clk or negedge reset_n) begin
        if (!reset_n)
            wr_en_nope_done        <= 1'b1;
        else if (wr_en && !wr_en_delay[TCAM_WR_WAIT_UNTIL_RDY])
            wr_en_nope_done        <= TCAM_NO_DELAY ? 1'b1 : 1'b0;
        else if (wr_en_delay[TCAM_WR_WAIT_UNTIL_RDY])
            wr_en_nope_done        <= 1'b1;
    end


    // Check Delay

    reg            chk_en_nope_done;
    reg            chk_en_delay[TCAM_CHK_DELAY:0];
    always_comb
        chk_en_delay[0]                = chk_en;
    always_ff @(posedge clk)
        for (int i = 0; i <= (TCAM_CHK_DELAY - 1); i = i + 1) begin
                chk_en_delay[i+1]        <= chk_en_delay[i];
        end

    assign    chk_en_nope_done    = 1'b1;


    // Address Delay

    logic    [1-1:0]        tcam_row_num_rd_en_delay;
    always_ff @(posedge clk) begin
        if (|rd_en_delay_inst[TCAM_RD_DELAY-1]) begin
            for (int i = 0; i < 1; i = i + 1) begin
                if (rd_en_delay_inst[TCAM_RD_DELAY-1][i]) begin
                    tcam_row_num_rd_en_delay[1-1:0]    <= i;
                end
            end
        end
    end


    // Write Data

    logic    [24-1:0]    tcam_row_wr_data;
    always_comb begin
            tcam_row_wr_data        = wr_data;
    end
    logic    [24-1:0]    tcam_wr_data_col[1-1:0];
    always_comb begin
        for (int i = 0; i < 1; i = i + 1) begin
            tcam_wr_data_col[i][24-1:0]        = tcam_row_wr_data[i*24+:24];
        end
    end


    // Check Key

    logic    [24-1:0]    tcam_chk_key;
    always_comb begin
            tcam_chk_key        = chk_key;
    end
    logic    [24-1:0]    tcam_chk_key_col[1-1:0];
    always_comb begin
        for (int i = 0; i < 1; i = i + 1) begin
            tcam_chk_key_col[i][24-1:0]        = tcam_chk_key[i*24+:24];
        end
    end


    // Check Mask

    logic    [24-1:0]    tcam_chk_mask;
    always_comb begin
            tcam_chk_mask        = '0;
            tcam_chk_mask        = wr_en ? '1 : chk_mask_int;
    end
    logic    [24-1:0]    tcam_chk_mask_col[1-1:0];
    always_comb begin
        for (int i = 0; i < 1; i = i + 1) begin
            tcam_chk_mask_col[i][24-1:0]        = tcam_chk_mask[i*24+:24];
        end
    end


    // Hit In

    logic    [512-1:0]    tcam_hit_in;
    always_comb begin
        tcam_hit_in                = {512{1'b1}};
        tcam_hit_in[TCAM_RULES_NUM-1:0]    = raw_hit_in[TCAM_RULES_NUM-1:0];
    end
    logic    [512-1:0]    tcam_raw_hit_in[1-1:0];
    always_comb begin
        for (int i = 0; i < 1; i = i + 1) begin
            tcam_raw_hit_in[i][512-1:0]        = tcam_hit_in[i*512+:512];
        end
    end


    // Read Data

    logic    [24-1:0]    tcam_rd_data_col[1-1:0][1-1:0];
    logic    [24-1:0]    tcam_rd_data_row;
    always_comb begin
        for (int i = 0; i < 1; i = i + 1) begin
            tcam_rd_data_row[i*(24)+:24]        = tcam_rd_data_col[tcam_row_num_rd_en_delay[1-1:0]][i][24-1:0];
        end
    end
    logic    [PHYSICAL_ROW_WIDTH-1:0]    tcam_rd_data;
    always_comb begin
        tcam_rd_data    = tcam_rd_data_row[0+:PHYSICAL_ROW_WIDTH];
    end
    assign    rd_data    = tcam_rd_data;


    // Hit Array

    logic    [512-1:0]    tcam_col_hit_out[1-1:0][1-1:0];
    logic    [512-1:0]    tcam_hit_out;
    always_comb begin
        for (int i = 0; i < 1; i = i + 1) begin
            tcam_hit_out[i*512+:512]    =  tcam_col_hit_out[i][1-1];
        end
    end
    assign    raw_hit_out = tcam_hit_out[TCAM_RULES_NUM-1:0];
// Match In Array 

        logic    [512-1:0]      tcam_row_match_in[1-1:0];
        always_comb begin 
                for (int i = 0; i < 1; i = i + 1) begin
                    tcam_row_match_in[i] = tcam_match_in[i*512+:512]; 
                end
        end


    // EBBs Instantiation

        wire                                            tcam_row_0_col_0_clk         = clk;
        wire    [TCAM_ANALOG_TUNE_CONFG_WIDTH-1:0]       tcam_row_0_col_0_cfg = analog_tune_confg;
        wire    [8-1:0]                                  tcam_row_0_col_0_slice_en = slice_en[0+:8];
        wire                                            tcam_row_0_col_0_rd_en       = tcam_row_rd_en[0];
        wire                                            tcam_row_0_col_0_wr_en       = tcam_row_wr_en[0];
        wire                                            tcam_row_0_col_0_chk_en      = chk_en;
        wire                                            tcam_row_0_col_0_reset_n = reset_n;
        wire    [10-1:0]                               tcam_row_0_col_0_adr  = tcam_row_adr[0][10-1:0];
        wire    [24-1:0]                              tcam_row_0_col_0_data_in = tcam_row_wr_en[0] ? tcam_wr_data_col[0][24-1:0] : tcam_chk_key_col[0][24-1:0];
        wire    [24-1:0]                              tcam_row_0_col_0_mask_in = tcam_chk_mask_col[0][24-1:0]; // must be inverted // inverted back in DFT wrapper
        wire    [512-1:0]                               tcam_row_0_col_0_hit_in = tcam_raw_hit_in[0];
        wire    [24-1:0]                              tcam_row_0_col_0_data_out;
        wire    [512-1:0]                               tcam_row_0_col_0_hit_out;
        
        //needed for intel18A TCAM
        logic    [24-1:0]                              tcam_row_0_col_0_data_out_ff; // must delay data_out 1 cycle due to 1 cycle read within intel18A TCAM
        logic                                                    tcam_row_0_col_0_x_ybar_sel;
        logic    [512-1:0]                               tcam_row_0_col_0_hit_out_ff;
        
        logic  [24-1:0]                              tcam_row_0_col_0_data_in_inv;
        
        wire tcam_row_0_col_0_memen;
        wire tcam_row_0_col_0_dft_wrp_rst;
        
        assign tcam_row_0_col_0_data_in_inv = ~tcam_row_0_col_0_data_in; // must be inverted
        
        assign tcam_row_0_col_0_x_ybar_sel = ~tcam_row_0_col_0_adr[0:0]; // must be inverted
        
        
        assign tcam_row_0_col_0_memen = tcam_row_0_col_0_wr_en ^ tcam_row_0_col_0_rd_en; // disable mem if ren = 1 and wen = 1 and also wen ren = 0 and wen = 0;
        assign tcam_row_0_col_0_dft_wrp_rst = ~fary_output_reset; // changed in DFT wrp
        
        ip783tcam512x24s0c1_dft_wrp #(     
                )
        tcam_row_0_col_0  (       
                     //------------------------------------------------------------
                     // Functional Interfaces
                     //------------------------------------------------------------
        
                       .CLK                             (tcam_row_0_col_0_clk),
                       .DIN                             (DIN),
                       .RE                              (tcam_row_0_col_0_interface_inst_RE),
                       .WE                              (tcam_row_0_col_0_interface_inst_WE),
                       .ME                              (tcam_row_0_col_0_interface_inst_ME),
                       .MASK                            (tcam_row_0_col_0_mask_in),
                       .CMP                             (tcam_row_0_col_0_chk_en), //srchen
                       .ADR                             ({tcam_row_0_col_0_x_ybar_sel,tcam_row_0_col_0_adr[10-1:1]}), //reorder this because that's how they implemented it in dft_wrp
        
                       .VBI                               (1'b0), // dinvalidmask
                       .VBE                               (1'b1), // dinvalid
                       .RST                               (tcam_row_0_col_0_dft_wrp_rst), //output_reset 
                       .RVLD                              ('1), //matchin
                       .QOUT                              (tcam_row_0_col_0_data_out),
                       .QHR                               (tcam_row_0_col_0_hit_out),
                       .DSEL                              (tcam_row_0_col_0_x_ybar_sel), //x_ybar_sel
                       .FLS                               (FLS), //glbvalidbitrst
                       .QVLD                            (),
                  
                       //.RESET_N                          (tcam_row_0_col_0_reset_n),
                      //.FUNC_CM_SLICE_EN                 (tcam_row_0_col_0_slice_en),
                       //Test inputs
                       .TADR (TADR),
                       .TVBE(TVBE),
                       .TVBI (TVBI),
                       .TMASK (TMASK),
                       .TWE (TWE),
                       .TRE(TRE),
                       .TME(TME),
                       .TDIN(TDIN),
                       .BISTE (BISTE), //TEST enable
        
                 //-------------------------------------------------------------
                 // Power Management Interfaces
                 //-------------------------------------------------------------      
                      //.PWR_MGMT_IN                      (tcam_fary_pwren_b[0]),
                      //.PWR_MGMT_OUT                     (tcam_aary_pwren_b[0]),
                      `ifndef INTEL_NO_PWR_PINS
                                     .vddp                            (1'b1),
                             `ifdef INTC_ADD_VSS
                                     .vss                              (1'b0),
                             `endif // INTC_ADD_VSS
                      `endif // INTEL_NO_PWR_PINS             
                 //-------------------------------------------------------------
                 // Analog Configuration - Fuses
                 //-------------------------------------------------------------      
                      //.TRIM_FUSE_IN                     (fary_ffuse_tune_tcam),//[11:0] in 1276.31; 1278 needs [15:0]
        
                    //REPAIR INPUTS
        
                    .FAF           (tcam_row_0_col_0_bisr_inst_Q[5:1]), // column repair addres? --- > F means faulty
                    .FAF_EN         (tcam_row_0_col_0_bisr_inst_Q[0]), //Column repair enable
                   
                  
                    //TIMING and TRIM
                    // MDST = {wpulse,ra,wa,mce,wmce,rmce,stbyp}
                    .MDST_tcam      ({fary_ffuse_tune_tcam[15:13],fary_ffuse_tune_tcam[8:7],fary_ffuse_tune_tcam[11:9],fary_ffuse_tune_tcam[0],fary_ffuse_tune_tcam[6:5],fary_ffuse_tune_tcam[4:1],fary_ffuse_tune_tcam[12]}),
        
                    //BIST ports
                       
                       .BIST_ROTATE_SR (BIST_ROTATE_SR),
                       .BIST_EN_SR_MASK_B (BIST_EN_SR_MASK_B),
                       .BIST_ALL_MASK (BIST_ALL_MASK),
                       .BIST_EN_SR_DATA_B (BIST_EN_SR_DATA_B),
                       .BIST_CM_MODE (BIST_CM_MODE),
                       .BIST_CM_EN_IN (BIST_CM_EN_IN),
                       .BIST_CM_MATCH_SEL0 (BIST_CM_MATCH_SEL0),
                       .BIST_CM_MATCH_SEL1(BIST_CM_MATCH_SEL1),
                       .BIST_MATCHIN_IN (BIST_MATCHIN_IN),
                       .BIST_FLS(BIST_FLS),
        
        
                   //DFT inputs
                    .DFTSHIFTEN        (DFTSHIFTEN),
                    .DFTMASK           (DFTMASK),
                    .DFT_ARRAY_FREEZE    (DFT_ARRAY_FREEZE),
                    
                    .DFT_AFD_RESET_B    (DFT_AFD_RESET_B)
        
             
        );//ip783tcam512x24s0c1
        
        always_ff @(posedge clk) begin
           tcam_row_0_col_0_data_out_ff <= tcam_row_0_col_0_data_out;
           tcam_row_0_col_0_hit_out_ff <= tcam_row_0_col_0_hit_out;
        end
        
        assign          tcam_rd_data_col[0][0]      = ~tcam_row_0_col_0_data_out_ff; // invert data_out before sending back to controller // 
        assign          tcam_col_hit_out[0][0]       = tcam_row_0_col_0_hit_out_ff; // DFT_WRP already delays this by one. 25ww35 - DFT_WRP removed delay. Adding back here.
        

    assign    tcam_rd_valid      = rd_en_delay[TCAM_RD_DELAY];
    assign    tcam_wr_ack      = wr_en_delay[TCAM_WR_DELAY];
    assign    tcam_chk_valid      = chk_en_delay[TCAM_CHK_DELAY];
    assign    tcam_rdwr_rdy      = rd_en_nope_done && wr_en_nope_done;
    assign    tcam_chk_rdy      = chk_en_nope_done && !wr_en && !rd_en;
// DFX output concatination 

`elsif HLP_FPGA_NO_VELOCE_MEMS

////////////////////////////////////////////////////////////////////////
//
//                              FPGA MEMORIES                                                                                                                   
//
////////////////////////////////////////////////////////////////////////
logic   [TCAM_WIDTH-1:0]        tcam_data_in                                                                                    ;
assign                          tcam_data_in                    = wr_en ? wr_data : chk_key                                     ;
assign                          chk_mask[TCAM_WIDTH-1:0]        = wr_en ? {TCAM_WIDTH{1'b1}} : chk_mask_int[TCAM_WIDTH-1:0]     ;

        hlp_mgm_fpga_tcam #(
                .CLOCKS_RATIO           (FPGA_CLOCKS_RATIO)                     , // Number of cycles that fast clock makes during one slow clock cycle 
                .MARGIN                 (FPGA_MARGIN)                           , // safety margin between the number of fast clock cycles needed and the end of one slow clock cycle
                .TOTAL_RULES_NUM        (TCAM_RULES_NUM)                        , // depth requested by designer
//clc                .SLICE_SIZE             (TCAM_SLICE_SIZE)                       , // number of rules in each slice -- RIGHT NOW, EACH SLICE SIZE IS SEGMENT DEPTH. If we add slice size I need to change it
                .DATA_WIDTH             (TCAM_WIDTH)                              // key width
        )
        fpga_tcam (
                .clk                    (clk)                                   , // Clock
                .fast_clk               (fpga_fast_clk)                         , // fast clock for fpga tcam inner units       
                .reset_n                (reset_n)                               , // Asynchronous Active-Low Reset
//clc                .slice_en               (slice_en[TCAM_SLICE_EN_WIDTH-1:0])     , // Enable Slices of TOTAL_RULES_NUM/SE_WIDTH Rules
                .rd_en                  (rd_en)                                 , // Read Enable
                .wr_en                  (wr_en)                                 , // Write Enable
                .chk_en                 (chk_en)                                , // Control Enable
                .addr                   (adr[TCAM_ADR_WIDTH-1:0])               , // Input Address
                .data_in                (tcam_data_in[TCAM_WIDTH-1:0])          , // Input Data
                .skey_in                ('0)                                    , // Input Key
                .chk_mask               (chk_mask[TCAM_WIDTH-1:0])              , // Input Mask
                .raw_hit_in             (raw_hit_in[TCAM_RULES_NUM-1:0])        , // Raw Hit Input 
                .match_in               ('0)                                    , // Raw Match Input 
                .vbi_in                 ('0)                                    , // Valid Bit Input 
                .flush_in               ('0)                                    , 
                .rd_data                (rd_data[TCAM_WIDTH-1:0])               , // Output Data
                .raw_hit_out            (raw_hit_out[TCAM_RULES_NUM-1:0])         // Raw Hit Output
        );


        // Read Delay
        logic                                   rd_en_nope_done;
        logic   [TCAM_RD_DELAY:0]               rd_en_delay;
        always_comb
                rd_en_delay[0]                          = rd_en;
        always @(posedge clk) begin
                rd_en_delay[TCAM_RD_DELAY:1]    <= rd_en_delay[TCAM_RD_DELAY-1:0];
        end

        always @(posedge clk or negedge reset_n) begin
                if (!reset_n)
                        rd_en_nope_done         <= 1'b1;
                else if (rd_en && !rd_en_delay[TCAM_RD_WAIT_UNTIL_RDY])
                        rd_en_nope_done         <= 1'b0;
                else if (rd_en_delay[TCAM_RD_WAIT_UNTIL_RDY])
                        rd_en_nope_done         <= 1'b1;
        end

        // Write Delay
        logic                                   wr_en_nope_done;
        logic   [TCAM_WR_DELAY:0]               wr_en_delay;
        always_comb
                wr_en_delay[0]                          = wr_en;
        always @(posedge clk) begin
                wr_en_delay[TCAM_WR_DELAY:1]    <= wr_en_delay[TCAM_WR_DELAY-1:0];
        end

        always @(posedge clk or negedge reset_n) begin
                if (!reset_n)
                        wr_en_nope_done         <= 1'b1;
                else if (wr_en && !wr_en_delay[TCAM_WR_WAIT_UNTIL_RDY])
                        wr_en_nope_done         <= 1'b0;
                else if (wr_en_delay[TCAM_WR_WAIT_UNTIL_RDY])
                        wr_en_nope_done         <= 1'b1;
        end


        // Check Delay
        logic                                   chk_en_nope_done;
        logic   [TCAM_CHK_DELAY:0]              chk_en_delay;
        always_comb
                chk_en_delay[0]                         = chk_en;
        always @(posedge clk) begin
                chk_en_delay[TCAM_CHK_DELAY:1]  <= chk_en_delay[TCAM_CHK_DELAY-1:0];
        end

        assign  chk_en_nope_done        = 1'b1;

        assign  tcam_rd_valid     = rd_en_delay[TCAM_RD_DELAY];
        assign  tcam_wr_ack       = wr_en_delay[TCAM_WR_DELAY];
        assign  tcam_chk_valid    = chk_en_delay[TCAM_CHK_DELAY];
        assign  tcam_rdwr_rdy     = rd_en_nope_done && wr_en_nope_done;
        assign  tcam_chk_rdy      = chk_en_nope_done && !wr_en && !rd_en;

`else

////////////////////////////////////////////////////////////////////////
//
//                              BEHAVE MEMORIES                                                                                                                                         
//
////////////////////////////////////////////////////////////////////////

logic   [TCAM_WIDTH-1:0]        tcam_data_in                                                                                    ;
assign                          tcam_data_in                    = wr_en ? wr_data : chk_key                                     ;
assign                          chk_mask[TCAM_WIDTH-1:0]        = wr_en ? {TCAM_WIDTH{1'b1}} : chk_mask_int[TCAM_WIDTH-1:0]     ;

        hlp_mgm_tcam_behave #(
                .RULES_NUM              (TCAM_RULES_NUM)                        ,       // Number of Rules
//clc                .SE_WIDTH               (TCAM_RULES_NUM/TCAM_SLICE_SIZE)        ,       // Slices Enable Width
                .DATA_WIDTH             (TCAM_WIDTH)                                    // Word Width
        )
        behave_tcam (
                .CLK                    (clk)                                   ,       // Clock
                .RESET_N                (reset_n)                               ,       // Asynchronous Active-Low Reset
//clc                .SLICE_EN               (slice_en)                              ,       // Enable Slices of RULES_NUM/SE_WIDTH Rules
                .REN                    (rd_en)                                 ,       // Read Enable
                .WEN                    (wr_en)                                 ,       // Write Enable
                .KEN                    (chk_en)                                ,       // Control Enable
                .MATCH_IN               ('0)                                    ,       // Match In Lines for BCAM
                .VBI                    ('0)                                    ,       // In/Validate Bit for BCAM
                .FLUSH                  ('0)                                    ,       // Flush for BCAM
                .ADDR                   (adr)                                   ,       // Input Address
                .DATA                   (tcam_data_in)                          ,       // Input Data
                .SKEY                   (tcam_data_in)                          ,       // Input Key
                .MASK                   (chk_mask)                              ,       // Input Mask
                .LHIT                   (raw_hit_in)                            ,       // Raw Hit Input
                .READ_DATA              (rd_data)                               ,       // Output Data
                .RHIT                   (raw_hit_out)                                   // Raw Hit Output
        );


        // Read Delay
        logic                                   rd_en_nope_done;
        logic   [TCAM_RD_DELAY:0]               rd_en_delay;
        always_comb
                rd_en_delay[0]                          = rd_en;
        always_ff @(posedge clk) begin
                rd_en_delay[TCAM_RD_DELAY:1]    <= rd_en_delay[TCAM_RD_DELAY-1:0];
        end

        always_ff @(posedge clk or negedge reset_n) begin
                if (!reset_n)
                        rd_en_nope_done         <= 1'b1;
                else if (rd_en && !rd_en_delay[TCAM_RD_WAIT_UNTIL_RDY])
                        rd_en_nope_done         <= TCAM_NO_DELAY ? 1'b1 : 1'b0;
                else if (rd_en_delay[TCAM_RD_WAIT_UNTIL_RDY])
                        rd_en_nope_done         <= 1'b1;
        end
      

        // Write Delay
        logic                                   wr_en_nope_done;
        logic   [TCAM_WR_DELAY:0]               wr_en_delay;
        always_comb
                wr_en_delay[0]                          = wr_en;
        always_ff @(posedge clk) begin
                wr_en_delay[TCAM_WR_DELAY:1]    <= wr_en_delay[TCAM_WR_DELAY-1:0];
        end

        always_ff @(posedge clk or negedge reset_n) begin
                if (!reset_n)
                        wr_en_nope_done         <= 1'b1;
                else if (wr_en && !wr_en_delay[TCAM_WR_WAIT_UNTIL_RDY])
                        wr_en_nope_done         <= TCAM_NO_DELAY ? 1'b1 : 1'b0;
                else if (wr_en_delay[TCAM_WR_WAIT_UNTIL_RDY])
                        wr_en_nope_done         <= 1'b1;
        end

        // Check Delay
        logic                                   chk_en_nope_done;
        logic   [TCAM_CHK_DELAY:0]              chk_en_delay;
        always_comb
                chk_en_delay[0]                         = chk_en;
        always_ff @(posedge clk) begin
                chk_en_delay[TCAM_CHK_DELAY:1]  <= chk_en_delay[TCAM_CHK_DELAY-1:0];
        end

        assign  chk_en_nope_done        = 1'b1;

        assign  tcam_rd_valid     = rd_en_delay[TCAM_RD_DELAY];
        assign  tcam_wr_ack       = wr_en_delay[TCAM_WR_DELAY];
        assign  tcam_chk_valid    = chk_en_delay[TCAM_CHK_DELAY];
        assign  tcam_rdwr_rdy     = rd_en_nope_done && wr_en_nope_done;
        assign  tcam_chk_rdy      = chk_en_nope_done && !wr_en && !rd_en;

        `ifdef HLP_RTL
                generate
                        if (TCAM_INIT_TYPE == 1)
                                begin:  CONST_TCAM_INIT

                                        reg [TCAM_WIDTH-1:0] init_word[TCAM_DEPTH-1:0];
                                                
                                        initial begin

                                                for (int i = 0; i < TCAM_DEPTH/2; i = i + 1) begin
                                                        init_word[2*i]          = TCAM_E0_INIT_VALUE;
                                                        init_word[2*i+1]        = TCAM_E1_INIT_VALUE;
                                                end
                                                
                                        end

                                        always @(posedge reset_n)
                                                if ($test$plusargs("HLP_FAST_CONFIG")) begin
                                                        for (int i = 0; i < TCAM_DEPTH; i = i + 1)
                                                                behave_tcam.state[i]    = init_word[i];
                                                end
                                                                                                        
                                end
                endgenerate
        `endif

`endif


  hlp_mod_apr_rtl_tessent_mbist_TCAM_c10_interface_MEM5 tcam_row_0_col_0_interface_inst(
      .BIST_CLEAR_BIRA(BIST_CLEAR_BIRA), .FLS_IN(1'b0), .TVBE_IN(1'b0), .TVBI_IN(1'b0), 
      .BIST_CM_MODE_IN(1'b0), .BIST_CM_EN_IN_IN(1'b0), .BIST_CM_MATCH_SEL0_IN(1'b0), 
      .BIST_CM_MATCH_SEL1_IN(1'b0), .BIST_ROTATE_SR_IN(1'b0), .BIST_ALL_MASK_IN(1'b0), 
      .BIST_EN_SR_DATA_B_IN(1'b0), .BIST_EN_SR_MASK_B_IN(1'b0), .BIST_MATCHIN_IN_IN(1'b0), 
      .BIST_FLS_IN(1'b0), .WE_IN(tcam_row_0_col_0_wr_en), .RE_IN(tcam_row_0_col_0_rd_en), 
      .ME_IN(tcam_row_0_col_0_memen), .QOUT(tcam_row_0_col_0_data_out), .DIN_IN(tcam_row_0_col_0_data_in_inv[23:0]), 
      .TCK(to_interfaces_tck), .BIST_CMP(BIST_CMP), .INCLUDE_MEM_RESULTS_REG(INCLUDE_MEM_RESULTS_REG), 
      .BIST_USER9(BIST_USER9), .BIST_USER10(BIST_USER10), .BIST_USER11(BIST_USER11), 
      .BIST_USER0(BIST_USER0), .BIST_USER1(BIST_USER1), .BIST_USER2(BIST_USER2), 
      .BIST_USER3(BIST_USER3), .BIST_USER4(BIST_USER4), .BIST_USER5(BIST_USER5), 
      .BIST_USER6(BIST_USER6), .BIST_USER7(BIST_USER7), .BIST_USER8(BIST_USER8), 
      .BIST_EVEN_GROUPWRITEENABLE(BIST_EVEN_GROUPWRITEENABLE), .BIST_ODD_GROUPWRITEENABLE(BIST_ODD_GROUPWRITEENABLE), 
      .BIST_WRITEENABLE(BIST_WRITEENABLE), .BIST_READENABLE(BIST_READENABLE), .BIST_SELECT(BIST_SELECT), 
      .BIST_COL_ADD(BIST_COL_ADD), .BIST_ROW_ADD(BIST_ROW_ADD[5:0]), .BIST_BANK_ADD(BIST_BANK_ADD[2:0]), 
      .BIST_WRITE_DATA(BIST_WRITE_DATA[23:0]), .BIST_TESTDATA_SELECT_TO_COLLAR(BIST_TESTDATA_SELECT_TO_COLLAR), 
      .MEM_BYPASS_EN(memory_bypass_to_en), .SCAN_SHIFT_EN(scan_to_en), .MCP_BOUNDING_EN(mcp_bounding_to_en), 
      .BIST_ON(BIST_ON_TO_COLLAR), .BIST_RUN(BIST_RUN_TO_COLLAR4), .BIST_ASYNC_RESETN(BIST_ASYNC_RESET), 
      .BIST_CLK(clk), .BIST_SHIFT_COLLAR(BIST_SHIFT_COLLAR), .BIST_EXPECT_DATA(BIST_EXPECT_DATA[23:0]), 
      .BIST_SI(MEM4_BIST_COLLAR_SI), .BIST_COLLAR_SETUP(BIST_COLLAR_SETUP), .BIST_COLLAR_OPSET_SELECT(BIST_COLLAR_OPSET_SELECT[1:0]), 
      .BIST_COLLAR_HOLD(BIST_COLLAR_HOLD), .BIST_BIRA_EN(BIST_COLLAR_BIRA_EN), 
      .CHECK_REPAIR_NEEDED(CHECK_REPAIR_NEEDED), .BIRA_SUSPEND(1'b0), .BIST_DIAG_EN(BIST_COLLAR_DIAG_EN), 
      .BIST_CLEAR_DEFAULT(BIST_CLEAR_DEFAULT), .BIST_CLEAR(BIST_CLEAR), .BIST_SETUP2(BIST_SETUP_ts2), 
      .BIST_SETUP1(BIST_SETUP_ts1), .BIST_SETUP0(BIST_SETUP), .LV_TM(ltest_to_en), 
      .FREEZE_STOP_ERROR(FREEZE_STOP_ERROR), .GO_ID_REG_SEL(GO_ID_REG_SEL), .BIST_COLLAR_EN(BIST_COLLAR_EN4), 
      .FROM_BISR_All_SCOL0_FUSE_REG(tcam_row_0_col_0_bisr_inst_Q[5:1]), .FROM_BISR_All_SCOL0_ALLOC_REG(tcam_row_0_col_0_bisr_inst_Q[0]), 
      .BIST_SHIFT_BIRA_COLLAR(BIST_SHIFT_BIRA_COLLAR), .RESET_REG_SETUP2(MBISTPG_RESET_REG_SETUP2), 
      .ERROR_CNT_ZERO(ERROR_CNT_ZERO), .FLS(FLS), .TVBE(TVBE), .TVBI(TVBI), .BISTE(BISTE), 
      .BIST_CM_MODE(BIST_CM_MODE), .BIST_CM_EN_IN(BIST_CM_EN_IN), .BIST_CM_MATCH_SEL0(BIST_CM_MATCH_SEL0), 
      .BIST_CM_MATCH_SEL1(BIST_CM_MATCH_SEL1), .BIST_ROTATE_SR(BIST_ROTATE_SR), 
      .BIST_ALL_MASK(BIST_ALL_MASK), .BIST_EN_SR_DATA_B(BIST_EN_SR_DATA_B), .BIST_EN_SR_MASK_B(BIST_EN_SR_MASK_B), 
      .BIST_MATCHIN_IN(BIST_MATCHIN_IN), .BIST_FLS(BIST_FLS), .TMASK(TMASK), .WE(tcam_row_0_col_0_interface_inst_WE), 
      .TWE(TWE), .RE(tcam_row_0_col_0_interface_inst_RE), .TRE(TRE), .ME(tcam_row_0_col_0_interface_inst_ME), 
      .TME(TME), .TADR(TADR), .DIN(DIN), .TDIN(TDIN), .BIST_SO(BIST_SO), .BIST_GO(BIST_GO), 
      .All_SCOL0_FUSE_REG(All_SCOL0_FUSE_REG[4:0]), .All_SCOL0_ALLOC_REG(All_SCOL0_ALLOC_REG), 
      .REPAIR_STATUS(), .fscan_clkungate(fscan_clkungate), .fscan_mode(fscan_mode_ts1)
  );

  hlp_mod_apr_rtl_tessent_mbisr_register_ip783tcam512x24s0c1_dft_wrp tcam_row_0_col_0_bisr_inst(
      .CLK(bisr_clk_pd_vinf), .RSTB(bisr_reset_pd_vinf), .SI(tcam_row_0_col_0_bisr_inst_SO), 
      .SO(tcam_row_0_col_0_bisr_inst_SO_ts1), .SE(bisr_shift_en_pd_vinf), .D({
      All_SCOL0_FUSE_REG[4:0], All_SCOL0_ALLOC_REG}), .MSO(1'b0), .MSEL(1'b0), .Q(tcam_row_0_col_0_bisr_inst_Q)
  );
endmodule
