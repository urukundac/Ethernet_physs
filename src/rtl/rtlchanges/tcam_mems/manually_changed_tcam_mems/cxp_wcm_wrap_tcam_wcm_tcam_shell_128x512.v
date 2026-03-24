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
//      Created by pallabpr with create_memories script version 25.01.005 on NA
//                                      & 
// Physical file /nfs/site/disks/zsc7.xne_cnic.nss.dftrtl.integ02/pallabpr/cxp_r16_mbist/flows/mgm/cxp/cxp_physical_params.csv
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
`include        "cxp_wcm_mem.def"
module  cxp_wcm_wrap_tcam_wcm_tcam_shell_128x512 #(
        parameter       TCAM_WIDTH                              = 40                                                , //
        parameter       TCAM_RULES_NUM                          = 512                                               , //
        parameter       TCAM_RD_DELAY                           = 2                                                 , //
        parameter       TCAM_WR_DELAY                           = 1                                                 , //
        parameter       TCAM_CHK_DELAY                          = 2                                                 , //    
        parameter       TCAM_RD_WAIT_UNTIL_RDY                  = 1                                                 , //
        parameter       TCAM_WR_WAIT_UNTIL_RDY                  = 1                                                 , //
        parameter       TCAM_SLICE_SIZE                         = 64                                                , //
        parameter       TCAM_SLICE_EN_WIDTH                     = TCAM_RULES_NUM/TCAM_SLICE_SIZE                    , //
        parameter       BCAM_RELIEF                             = 0                                                 , //
        parameter       TSMC_N7                                 = 0                                                 , //
        parameter       BCAM_N7                                 = 0                                                 , //
        parameter       TCAM_18A                                = 1                                                , //
        parameter       TCAM_DEPTH                              = TCAM_RULES_NUM                                  , //
        parameter       TCAM_ADDR_WIDTH                          = $clog2(TCAM_DEPTH*2)                                , //
        parameter       TCAM_INIT_TYPE                          = 0                                                 , //
        `ifdef CXP_FPGA_TCAM_MEMS 
            parameter       FPGA_CLOCKS_RATIO                   = 8                                                 , //
        `else
            parameter       FPGA_CLOCKS_RATIO                   = 100                                               , //
        `endif
        parameter       FPGA_MARGIN                             = 0                                                 , //
        parameter       TCAM_PROTECTION_TYPE                    = 0                                                 , //
        parameter       TCAM_PATRN0_EXP_RESET_VALUE             = 0                                                 , //
        parameter       TCAM_PATRN1_EXP_RESET_VALUE             = 0                                                 , //
        parameter       TCAM_E0_INIT_VALUE                      = ~(TCAM_WIDTH'(0))                                 , //
        parameter       TCAM_E1_INIT_VALUE                      = ~(TCAM_WIDTH'(0))                                 , //
        parameter       TCAM_ANALOG_TUNE_CONFG_WIDTH            = `CXP_TCAM_ANALOG_TUNE_CONFG_WIDTH             , //
        parameter       FROM_TCAM_WIDTH                         = TCAM_WIDTH + TCAM_RULES_NUM + 1 + 1 + 1 + 1 + 1 + 1      , //
        parameter       TO_TCAM_WIDTH                           = TCAM_SLICE_EN_WIDTH + 1 + TCAM_ANALOG_TUNE_CONFG_WIDTH + 3 + 1 + 1 + 1 + TCAM_ADDR_WIDTH + TCAM_WIDTH + 1 + 2*TCAM_WIDTH + TCAM_RULES_NUM  ,      //
        parameter       TCAM_NO_DELAY                           = 1     //
                // DFx Memory Parameters
                ,
                parameter MSWT_MODE                     = 0                                                                             ,
                parameter BYPASS_CLK_MUX                = 1                                                                             ,
                parameter BYPASS_MBIST_EN_SYNC          = 0                                                                             ,
                parameter WRAPPER_REDROW_ENABLE         = 0                                                                             ,
                parameter WRAPPER_COL_REPAIR            = 1                                                                             ,
                parameter NFUSERED_TCAM                 = $clog2(TCAM_WIDTH) + 1                                                        ,
                parameter TOTAL_MEMORY_INSTANCE         = 1                                                       
)(
        // Memory General Interface
        input  logic                                                 clk                             ,
        input  logic                                                 car_raw_lan_power_good          ,
        `ifdef CXP_FPGA_TCAM_MEMS
        input  logic                                                 fpga_fast_clk                   ,
        `endif
        input  logic         [  TO_TCAM_WIDTH-1:0]                   wrap_shell_to_tcam              ,
        output  wire         [FROM_TCAM_WIDTH-1:0]                   wrap_shell_from_tcam    
        // Memory DFx Interface 
       ,
          input     logic      [15:0]                                  fuse_tcam ,
        input    logic                                               dftshiften                 , 
        input    logic                                               dftmask                    , 
        input    logic                                               dft_array_freeze           ,
        input    logic                                               dft_afd_reset_b
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
        output wire BIST_SO_ts1, output wire BIST_SO_ts2, 
        output wire BIST_SO_ts3, output wire BIST_SO_ts4, 
        output wire BIST_SO_ts5, output wire BIST_SO_ts6, 
        output wire BIST_SO_ts7, output wire BIST_SO_ts8, 
        output wire BIST_SO_ts9, output wire BIST_SO_ts10, 
        output wire BIST_SO_ts11, output wire BIST_SO_ts12, 
        output wire BIST_SO_ts13, output wire BIST_SO_ts14, 
        output wire BIST_SO_ts15, output wire BIST_GO, output wire BIST_GO_ts1, 
        output wire BIST_GO_ts2, output wire BIST_GO_ts3, 
        output wire BIST_GO_ts4, output wire BIST_GO_ts5, 
        output wire BIST_GO_ts6, output wire BIST_GO_ts7, 
        output wire BIST_GO_ts8, output wire BIST_GO_ts9, 
        output wire BIST_GO_ts10, output wire BIST_GO_ts11, 
        output wire BIST_GO_ts12, output wire BIST_GO_ts13, 
        output wire BIST_GO_ts14, output wire BIST_GO_ts15, 
        input wire ltest_to_en, input wire BIST_USER9, input wire BIST_USER10, 
        input wire BIST_USER11, input wire BIST_USER0, input wire BIST_USER1, 
        input wire BIST_USER2, input wire BIST_USER3, input wire BIST_USER4, 
        input wire BIST_USER5, input wire BIST_USER6, input wire BIST_USER7, 
        input wire BIST_USER8, input wire BIST_EVEN_GROUPWRITEENABLE, 
        input wire BIST_ODD_GROUPWRITEENABLE, input wire BIST_WRITEENABLE, 
        input wire BIST_READENABLE, input wire BIST_SELECT, 
        input wire BIST_CMP, input wire INCLUDE_MEM_RESULTS_REG, 
        input wire [0:0] BIST_COL_ADD, input wire [5:0] BIST_ROW_ADD, 
        input wire BIST_COLLAR_EN0, input wire BIST_COLLAR_EN1, 
        input wire BIST_COLLAR_EN2, input wire BIST_COLLAR_EN3, 
        input wire BIST_COLLAR_EN4, input wire BIST_COLLAR_EN5, 
        input wire BIST_COLLAR_EN6, input wire BIST_COLLAR_EN7, 
        input wire BIST_COLLAR_EN8, input wire BIST_COLLAR_EN9, 
        input wire BIST_COLLAR_EN10, input wire BIST_COLLAR_EN11, 
        input wire BIST_COLLAR_EN12, input wire BIST_COLLAR_EN13, 
        input wire BIST_COLLAR_EN14, input wire BIST_COLLAR_EN15, 
        input wire BIST_RUN_TO_COLLAR0, input wire BIST_RUN_TO_COLLAR1, 
        input wire BIST_RUN_TO_COLLAR2, input wire BIST_RUN_TO_COLLAR3, 
        input wire BIST_RUN_TO_COLLAR4, input wire BIST_RUN_TO_COLLAR5, 
        input wire BIST_RUN_TO_COLLAR6, input wire BIST_RUN_TO_COLLAR7, 
        input wire BIST_RUN_TO_COLLAR8, input wire BIST_RUN_TO_COLLAR9, 
        input wire BIST_RUN_TO_COLLAR10, input wire BIST_RUN_TO_COLLAR11, 
        input wire BIST_RUN_TO_COLLAR12, input wire BIST_RUN_TO_COLLAR13, 
        input wire BIST_RUN_TO_COLLAR14, input wire BIST_RUN_TO_COLLAR15, 
        input wire BIST_ASYNC_RESET, input wire BIST_TESTDATA_SELECT_TO_COLLAR, 
        input wire BIST_ON_TO_COLLAR, input wire [31:0] BIST_WRITE_DATA, 
        input wire [31:0] BIST_EXPECT_DATA, input wire BIST_SHIFT_COLLAR, 
        input wire BIST_COLLAR_SETUP, input wire BIST_CLEAR_DEFAULT, 
        input wire BIST_CLEAR, input wire [1:0] BIST_COLLAR_OPSET_SELECT, 
        input wire BIST_COLLAR_HOLD, input wire FREEZE_STOP_ERROR, 
        input wire ERROR_CNT_ZERO, input wire MBISTPG_RESET_REG_SETUP2, 
        input wire [0:0] BIST_BANK_ADD, input wire bisr_shift_en_pd_vinf, 
        input wire bisr_clk_pd_vinf, input wire bisr_reset_pd_vinf, 
        input wire ram_row_0_col_6_bisr_inst_SO, 
        output wire tcam_row_0_col_9_bisr_inst_SO, input wire fscan_clkungate);

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
        logic   [                      TCAM_ADDR_WIDTH-1:0]      adr                     ;
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

localparam PHYSICAL_ROW_WIDTH = TCAM_WIDTH + BCAM_N7*(16*32 - TCAM_WIDTH);
 wire tcam_row_0_col_0_bisr_inst_SO, tcam_row_0_col_10_bisr_inst_SO, 
      tcam_row_0_col_11_bisr_inst_SO, tcam_row_0_col_12_bisr_inst_SO, 
      tcam_row_0_col_13_bisr_inst_SO, tcam_row_0_col_14_bisr_inst_SO, 
      tcam_row_0_col_15_bisr_inst_SO, tcam_row_0_col_1_bisr_inst_SO, 
      tcam_row_0_col_2_bisr_inst_SO, tcam_row_0_col_3_bisr_inst_SO, 
      tcam_row_0_col_4_bisr_inst_SO, tcam_row_0_col_5_bisr_inst_SO, 
      tcam_row_0_col_6_bisr_inst_SO, tcam_row_0_col_7_bisr_inst_SO, 
      tcam_row_0_col_8_bisr_inst_SO;
 
// Disassembling the to_tcam bus
 `ifndef CXP_FPGA_TCAM_MEMS
        wire     fpga_fast_clk ; 
        assign   fpga_fast_clk   = clk; // Dummy assignment for 
 `endif

`ifdef CXP_FPGA_TCAM_MEMS
        `define CXP_TCAM_FPGA_MEMS
`else
        `define CXP_TCAM_BEHAVE_FPGA_MEMS
`endif

assign                                                  to_tcam_bus             = wrap_shell_to_tcam            ;
wire                                                    reset_n                 = to_tcam_bus.reset_n           ;
wire    [        TCAM_ANALOG_TUNE_CONFG_WIDTH-1:0]      analog_tune_confg       = to_tcam_bus.analog_tune_confg ;
wire                                                    tcam_init_done_int      = to_tcam_bus.init_done         ;
wire                                                    tcam_ecc_en             = to_tcam_bus.ecc_en            ;
wire                                                    tcam_ecc_invert_1       = to_tcam_bus.ecc_invert_1      ;
wire                                                    tcam_ecc_invert_2       = to_tcam_bus.ecc_invert_2      ;
wire    [                      TCAM_ADDR_WIDTH-1:0]      adr_pre                 = to_tcam_bus.adr               ;
wire                                                    rd_en_pre               = to_tcam_bus.rd_en             ;
wire                                                    wr_en_pre               = to_tcam_bus.wr_en             ;
wire    [                  PHYSICAL_ROW_WIDTH-1:0]      wr_data_pre             = {{(BCAM_N7*(PHYSICAL_ROW_WIDTH-TCAM_WIDTH)){1'b1}},to_tcam_bus.wr_data};
wire                                                    chk_en_pre              = to_tcam_bus.chk_en;
wire    [                  PHYSICAL_ROW_WIDTH-1:0]      chk_key_pre             = {{(BCAM_N7*(PHYSICAL_ROW_WIDTH-TCAM_WIDTH)){1'b1}},to_tcam_bus.chk_key};
wire    [                  PHYSICAL_ROW_WIDTH-1:0]      chk_mask_pre            = {{(BCAM_N7*(PHYSICAL_ROW_WIDTH-TCAM_WIDTH)){1'b0}},to_tcam_bus.chk_mask};
wire                                                    flush_pre               = to_tcam_bus.flush             ;
wire    [                 TCAM_SLICE_EN_WIDTH-1:0]      slice_en_pre            = to_tcam_bus.slice_en          ;
wire    [                      TCAM_RULES_NUM-1:0]      raw_hit_in_pre          = to_tcam_bus.raw_hit_in        ;
wire                                                    chk_err_dis             = to_tcam_bus.tcam_check_err_dis;
wire                                                    update_dis              = to_tcam_bus.tcam_update_dis   ;

wire    [                      TCAM_ADDR_WIDTH-1:0]      adr                                                     ;      
logic                                                   ce                                                      ;
wire                                                    rd_en                                                   ;
wire                                                    wr_en                                                   ;
wire    [                  PHYSICAL_ROW_WIDTH-1:0]      wr_data                                                 ;
wire                                                    chk_en                                                  ;
wire    [                  PHYSICAL_ROW_WIDTH-1:0]      chk_key                                                 ;
wire    [                  PHYSICAL_ROW_WIDTH-1:0]      chk_mask                                                ;
wire                                                    flush                                                   ;
wire    [                  PHYSICAL_ROW_WIDTH-1:0]      chk_mask_int                                            ;
wire    [                 TCAM_SLICE_EN_WIDTH-1:0]      slice_en                                                ;
wire    [                      TCAM_RULES_NUM-1:0]      raw_hit_in                                              ;


// Assembling the from_tcam bus

logic   [                  PHYSICAL_ROW_WIDTH-1:0]      rd_data_pre             ;
logic                                                   tcam_rd_valid_pre       ;       
logic                                                   tcam_wr_ack_pre         ;
logic                                                   tcam_chk_valid_pre      ;
logic                                                   tcam_rdwr_rdy_pre       ;
logic                                                   tcam_chk_rdy_pre        ;
logic   [                      TCAM_RULES_NUM-1:0]      raw_hit_out_pre         ;

logic   [                  PHYSICAL_ROW_WIDTH-1:0]      rd_data                 ;
logic                                                   tcam_rd_valid           ;
logic                                                   tcam_wr_ack             ;
logic                                                   tcam_chk_valid          ;
logic                                                   tcam_rdwr_rdy           ;
logic                                                   tcam_chk_rdy            ;
logic   [                      TCAM_RULES_NUM-1:0]      raw_hit_out             ;
logic   [                      TCAM_RULES_NUM-1:0]      raw_hit_out_fpga        ;
logic   [                      TCAM_RULES_NUM-1:0]      raw_hit_out_behave        ;

logic                                                   ecc_err_det             ;

assign                                                  wrap_shell_from_tcam            = from_tcam_bus                 ;
assign                                                  from_tcam_bus.tcam_rd_valid     = tcam_rd_valid_pre             ;
assign                                                  from_tcam_bus.tcam_wr_ack       = tcam_wr_ack_pre               ;
assign                                                  from_tcam_bus.tcam_chk_valid    = tcam_chk_valid_pre            ;
assign                                                  from_tcam_bus.tcam_rdwr_rdy     = tcam_rdwr_rdy_pre             ;
assign                                                  from_tcam_bus.tcam_chk_rdy      = tcam_chk_rdy_pre              ;
assign                                                  from_tcam_bus.rd_data           = rd_data_pre[TCAM_WIDTH-1:0]   ;
assign                                                  from_tcam_bus.raw_hit_out       = raw_hit_out_pre               ;
assign                                                  from_tcam_bus.ecc_err_det       = ecc_err_det                   ;
logic                             tcam_init_done; 
logic   [PHYSICAL_ROW_WIDTH-1:0]          wr_data_mux; 
logic   [TCAM_ADDR_WIDTH-1:0]      adr_mux; 
logic                             wr_en_mux ; 

`ifdef INTEL_EMULATION

logic                             init_done_tcam_emu; 
logic   [PHYSICAL_ROW_WIDTH-1:0]  rd_data_init  ;
logic                             wr_en_emu, wr_en_emu_d;   
logic   [TCAM_ADDR_WIDTH-1:0]      aux_adr; 



logic   mgm_emu_avoid_hw_init;
logic   mgm_emu_avoid_hw_init_d;

logic   mgm_emu_load_acc_done; 

assign  mgm_emu_load_acc_done = mgm_emu_avoid_hw_init ? (init_done_tcam_emu & tcam_init_done_int) : 1 ;  
assign  wr_en_mux       = mgm_emu_load_acc_done   ? wr_en_pre     : wr_en_emu   ;
assign  adr_mux         = (!mgm_emu_load_acc_done) ? aux_adr : adr_pre             ;
assign  wr_data_mux     = mgm_emu_load_acc_done    ? wr_data_pre : rd_data_init  ;

assign tcam_init_done = tcam_init_done_int & mgm_emu_load_acc_done ; 



always_ff  @(posedge clk or negedge reset_n)
        if (!reset_n) begin
                aux_adr         <= TCAM_ADDR_WIDTH'(TCAM_DEPTH - 1);
                init_done_tcam_emu           <= 1'b0;  
                mgm_emu_avoid_hw_init        <= 0;
                mgm_emu_avoid_hw_init_d      <= 0;
                wr_en_emu <= 0;  
                wr_en_emu_d <= 0;
        end
        else 
          
          begin
            mgm_emu_avoid_hw_init_d <= mgm_emu_avoid_hw_init;
            wr_en_emu_d <= wr_en_emu;
            if ( ~init_done_tcam_emu) begin 
                if (~mgm_emu_avoid_hw_init_d & mgm_emu_avoid_hw_init)  begin // start loading data
                    wr_en_emu <= 1; 
                end else if (wr_en_emu) begin
                    wr_en_emu          <= (aux_adr == {(TCAM_ADDR_WIDTH){1'b0}}) ? 0 : 1;
                    aux_adr            <= (aux_adr == {(TCAM_ADDR_WIDTH){1'b0}}) ? 0 : aux_adr - 1;
                    init_done_tcam_emu <= (aux_adr == {(TCAM_ADDR_WIDTH){1'b0}}) || init_done_tcam_emu;
                end else //    (tcam_wr_ack_pre)
                    begin                                                 
                        wr_en_emu <= 0; 
                    end
              end // ~init_done_tcam_emu
          end
          




 cxp_mgm_1rw_behave #(
         .MEM_WIDTH              (PHYSICAL_ROW_WIDTH)        ,
         .MEM_DEPTH              (2*TCAM_DEPTH) 
         )
 tcam_mem_acc (
         .clk                    (clk)              ,
         .address                (aux_adr)          ,
         .rd_en                  (~init_done_tcam_emu)    ,
         .wr_en                  ('0)               ,
         .data_in                ('0)               ,
         .data_out               (rd_data_init)

         );


 `else
       assign wr_data_mux = wr_data_pre; 
       assign adr_mux      = adr_pre; 
       assign wr_en_mux    = wr_en_pre; 

      assign tcam_init_done = tcam_init_done_int ;  


`endif                
generate
    if (BCAM_N7 == 0)
        begin : gen_tcam_col_sweeper
        
        assign flush = flush_pre;

cxp_mgm_tcam_col_sweeper #(
        .TCAM_CHK_DELAY                 (TCAM_CHK_DELAY)                        ,
        .TCAM_RULES_NUM                 (TCAM_RULES_NUM)                        ,
        .TCAM_WIDTH                     (TCAM_WIDTH)                            ,
        .TCAM_SLICE_EN_WIDTH            (TCAM_SLICE_EN_WIDTH)                   ,
        .BCAM_RELIEF                    (BCAM_RELIEF)                           ,
        .TCAM_PROTECTION_TYPE           (TCAM_PROTECTION_TYPE)                  ,
        .TCAM_PATRN0_EXP_RESET_VALUE    (TCAM_PATRN0_EXP_RESET_VALUE)           ,
        .TCAM_PATRN1_EXP_RESET_VALUE    (TCAM_PATRN1_EXP_RESET_VALUE)
) tcam_col_sweeper (
        // General
        .clk                            (clk)                                   ,
        .rst_n                          (reset_n)                               ,
        // Functional I/F From Shell
        .adr_pre                        (adr_mux[TCAM_ADDR_WIDTH-1:0])           ,
        .rd_en_pre                      (rd_en_pre)                             ,
        .wr_en_pre                      (wr_en_mux)                             ,       
        .wr_data_pre                    (wr_data_mux[TCAM_WIDTH-1:0])           ,
        .rd_data_pre                    (rd_data_pre[TCAM_WIDTH-1:0])           ,
        .chk_en_pre                     (chk_en_pre)                            ,
        .slice_en_pre                   (slice_en_pre[TCAM_SLICE_EN_WIDTH-1:0]) ,
        .hit_arr_in_pre                 (raw_hit_in_pre[TCAM_RULES_NUM-1:0])    ,
        .chk_key_pre                    (chk_key_pre[TCAM_WIDTH-1:0])           ,
        .chk_mask_pre                   (chk_mask_pre[TCAM_WIDTH-1:0])          ,
        .hit_arr_out_pre                (raw_hit_out_pre[TCAM_RULES_NUM-1:0])   ,
        .tcam_rd_valid_pre              (tcam_rd_valid_pre)                     ,
        .tcam_wr_ack_pre                (tcam_wr_ack_pre)                       ,
        .tcam_chk_valid_pre             (tcam_chk_valid_pre)                    ,
        .tcam_rdwr_rdy_pre              (tcam_rdwr_rdy_pre)                     ,
        .tcam_chk_rdy_pre               (tcam_chk_rdy_pre)                      ,
        // Functional I/F To Shell
        .adr_pst                        (adr[TCAM_ADDR_WIDTH-1:0])               ,
        .ce_pst                         (ce)                                 ,
        .rd_en_pst                      (rd_en)                                 ,
        .wr_en_pst                      (wr_en)                                 ,
        .wr_data_pst                    (wr_data[TCAM_WIDTH-1:0])               ,
        .rd_data_pst                    (rd_data[TCAM_WIDTH-1:0])               ,
        .chk_en_pst                     (chk_en)                                ,
        .slice_en_pst                   (slice_en[TCAM_SLICE_EN_WIDTH-1:0])     ,
        .hit_arr_in_pst                 (raw_hit_in[TCAM_RULES_NUM-1:0])        ,
        .chk_key_pst                    (chk_key[TCAM_WIDTH-1:0])               ,
        .chk_mask_pst                   (chk_mask_int[TCAM_WIDTH-1:0])          ,
        .flush_pre                      (flush_pre)                                           ,
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

        end
    else
        begin : gen_bcam_row_sweeper

localparam PROTECTION_CHUNK_SIZE = (26-2)/2;

cxp_mgm_bcam_row_sweeper #(
        .BCAM_RD_DELAY                  (TCAM_RD_DELAY)                                       ,
        .BCAM_RULES_NUM                 (TCAM_RULES_NUM)                                      ,
        .BCAM_WIDTH                     (PHYSICAL_ROW_WIDTH)                                  ,
        .BCAM_SLICE_EN_WIDTH            (TCAM_SLICE_EN_WIDTH)                                 ,
        .BCAM_PROT_WIDTH                (16*2)                                                 ,
        .BCAM_PROTECTION_CHUNK_SIZE     (PROTECTION_CHUNK_SIZE)                               ,
        .BCAM_PROTECTION_TYPE           (TCAM_PROTECTION_TYPE)                                
) mgm_bcam_row_sweeper (
        // General
        .clk                            (clk)                                                 ,
        .rst_n                          (reset_n)                                             ,
        // Functional I/F From Shell
        .adr_pre                        (adr_mux[TCAM_ADDR_WIDTH-1:0])                         ,
        .rd_en_pre                      (rd_en_pre)                                           ,
        .wr_en_pre                      (wr_en_mux)                                           ,       
        .wr_data_pre                    (wr_data_mux[PHYSICAL_ROW_WIDTH-1:0])                 ,
        .rd_data_pre                    (rd_data_pre[PHYSICAL_ROW_WIDTH-1:0])                 ,
        .chk_en_pre                     (chk_en_pre)                                          ,
        .flush_pre                      (flush_pre)                                           ,
        .slice_en_pre                   (slice_en_pre[TCAM_SLICE_EN_WIDTH-1:0])               ,
        .hit_arr_in_pre                 (raw_hit_in_pre[TCAM_RULES_NUM-1:0])                  ,
        .chk_key_pre                    (chk_key_pre[PHYSICAL_ROW_WIDTH-1:0])                 ,
        .chk_mask_pre                   (chk_mask_pre[PHYSICAL_ROW_WIDTH-1:0])                ,
        .hit_arr_out_pre                (raw_hit_out_pre[TCAM_RULES_NUM-1:0])                 ,
        .bcam_rd_valid_pre              (tcam_rd_valid_pre)                                   ,
        .bcam_wr_ack_pre                (tcam_wr_ack_pre)                                     ,
        .bcam_chk_valid_pre             (tcam_chk_valid_pre)                                  ,
        .bcam_rdwr_rdy_pre              (tcam_rdwr_rdy_pre)                                   ,
        .bcam_chk_rdy_pre               (tcam_chk_rdy_pre)                                    ,
        // Functional I/F To Shell
        .adr_pst                        (adr[TCAM_ADDR_WIDTH-1:0])                             ,
        .ce_pst                         (ce)                                                  ,
        .rd_en_pst                      (rd_en)                                               ,
        .wr_en_pst                      (wr_en)                                               ,
        .wr_data_pst                    (wr_data[PHYSICAL_ROW_WIDTH-1:0])                     ,
        .rd_data_pst                    (rd_data[PHYSICAL_ROW_WIDTH-1:0])                     ,
        .chk_en_pst                     (chk_en)                                              ,
        .slice_en_pst                   (slice_en[TCAM_SLICE_EN_WIDTH-1:0])                   ,
        .hit_arr_in_pst                 (raw_hit_in[TCAM_RULES_NUM-1:0])                      ,
        .chk_key_pst                    (chk_key[PHYSICAL_ROW_WIDTH-1:0])                     ,
        .chk_mask_pst                   (chk_mask_int[PHYSICAL_ROW_WIDTH-1:0])                ,
        .flush_pst                      (flush)                                               ,
        .hit_arr_out_pst                (raw_hit_out[TCAM_RULES_NUM-1:0])                     ,
        .bcam_rd_valid_pst              (tcam_rd_valid)                                       ,
        .bcam_wr_ack_pst                (tcam_wr_ack)                                         ,
        .bcam_chk_valid_pst             (tcam_chk_valid)                                      ,
        .bcam_rdwr_rdy_pst              (tcam_rdwr_rdy)                                       ,
        .bcam_chk_rdy_pst               (tcam_chk_rdy)                                        ,       
        // Protection related I/F
        .bcam_check_err_dis             (chk_err_dis)                                         ,
        .bcam_update_dis                (update_dis)                                          ,
        .bcam_init_done                 (tcam_init_done)                                      ,
        .bcam_prot_en                   (tcam_ecc_en)                                         ,
        .bcam_invert_0                  (tcam_ecc_invert_1)                                   ,
        .bcam_invert_1                  (tcam_ecc_invert_2)                                   ,
        .bcam_ecc_err_det               (ecc_err_det)                                         
);


        end
endgenerate
  // Match In Array 

         logic    [TCAM_RULES_NUM-1:0]      tcam_match_in;
         always_comb begin 
                tcam_match_in = raw_hit_in;
                if (wr_en) begin 
                    tcam_match_in[adr[TCAM_ADDR_WIDTH-1:1]] = 1'b0;
                end
        end



        // Memories Implementation
`ifndef CXP_WCM_TCAM_BEHAVE_MEMS
    `define CXP_WCM_ASIC_MEMS
`endif

`ifdef  CXP_WCM_ASIC_MEMS

////////////////////////////////////////////////////////////////////////
//
//                              ASIC MEMORIES                                                                                                                   
//
////////////////////////////////////////////////////////////////////////

localparam TCAM_SLICE_EN_FACT = 128/64;
localparam TCAM_SLICE_EN_MIN = ((TCAM_SLICE_EN_FACT < TCAM_SLICE_EN_WIDTH ) ? TCAM_SLICE_EN_FACT : TCAM_SLICE_EN_WIDTH);



    // TCAM Row Select

    wire    [1-1:0]                tcam_row_sel;
    assign                    tcam_row_sel[0]        = 1'b1;


    // TCAM Address Decoder

    wire    [8-1:0]        tcam_row_adr[1-1:0];
    assign                    tcam_row_adr[0][8-1:0]    =  tcam_row_sel[0] ? adr - 8'd0 : 8'd0;


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

    logic    [512-1:0]    tcam_row_wr_data;
    always_comb begin
            tcam_row_wr_data        = wr_data;
    end
    logic    [32-1:0]    tcam_wr_data_col[16-1:0];
    always_comb begin
        for (int i = 0; i < 16; i = i + 1) begin
            tcam_wr_data_col[i][32-1:0]        = tcam_row_wr_data[i*32+:32];
        end
    end


    // Check Key

    logic    [512-1:0]    tcam_chk_key;
    always_comb begin
            tcam_chk_key        = chk_key;
    end
    logic    [32-1:0]    tcam_chk_key_col[16-1:0];
    always_comb begin
        for (int i = 0; i < 16; i = i + 1) begin
            tcam_chk_key_col[i][32-1:0]        = tcam_chk_key[i*32+:32];
        end
    end


    // Check Mask

    logic    [512-1:0]    tcam_chk_mask;
    always_comb begin
            tcam_chk_mask        = '0;
            tcam_chk_mask        = wr_en ? '1 : chk_mask_int;
    end
    logic    [32-1:0]    tcam_chk_mask_col[16-1:0];
    always_comb begin
        for (int i = 0; i < 16; i = i + 1) begin
            tcam_chk_mask_col[i][32-1:0]        = tcam_chk_mask[i*32+:32];
        end
    end


    // Hit In

    logic    [128-1:0]    tcam_hit_in;
    always_comb begin
        tcam_hit_in                = {128{1'b1}};
        tcam_hit_in[TCAM_RULES_NUM-1:0]    = raw_hit_in[TCAM_RULES_NUM-1:0];
    end
    logic    [128-1:0]    tcam_raw_hit_in[1-1:0];
    always_comb begin
        for (int i = 0; i < 1; i = i + 1) begin
            tcam_raw_hit_in[i][128-1:0]        = tcam_hit_in[i*128+:128];
        end
    end


    // Read Data

    logic    [32-1:0]    tcam_rd_data_col[1-1:0][16-1:0];
    logic    [512-1:0]    tcam_rd_data_row;
    always_comb begin
        for (int i = 0; i < 16; i = i + 1) begin
            tcam_rd_data_row[i*(32)+:32]        = tcam_rd_data_col[tcam_row_num_rd_en_delay[1-1:0]][i][32-1:0];
        end
    end
    logic    [PHYSICAL_ROW_WIDTH-1:0]    tcam_rd_data;
    always_comb begin
        tcam_rd_data    = tcam_rd_data_row[0+:PHYSICAL_ROW_WIDTH];
    end
    assign    rd_data    = tcam_rd_data;


    // Hit Array

    logic    [128-1:0]    tcam_col_hit_out[1-1:0][16-1:0];
    logic    [128-1:0]    tcam_hit_out;
    always_comb begin
        for (int i = 0; i < 1; i = i + 1) begin
                tcam_hit_out[i*128+:128]    =  tcam_col_hit_out[i][0]   & tcam_col_hit_out[i][1] & tcam_col_hit_out[i][2] & tcam_col_hit_out[i][3] & tcam_col_hit_out[i][4] & tcam_col_hit_out[i][5] & tcam_col_hit_out[i][6] & tcam_col_hit_out[i][7] & tcam_col_hit_out[i][8] & tcam_col_hit_out[i][9] & tcam_col_hit_out[i][10] & tcam_col_hit_out[i][11] & tcam_col_hit_out[i][12] & tcam_col_hit_out[i][13] & tcam_col_hit_out[i][14] & tcam_col_hit_out[i][15];
        end
    end
    assign    raw_hit_out = tcam_hit_out[TCAM_RULES_NUM-1:0];
// Match In Array 

        logic    [128-1:0]      tcam_row_match_in[1-1:0];
        always_comb begin 
                for (int i = 0; i < 1; i = i + 1) begin
                    tcam_row_match_in[i] = tcam_match_in[i*128+:128]; 
                end
        end


    // EBBs Instantiation

        // this is new template - tcam_asic_template
        
        wire                                            tcam_row_0_col_0_clk         = clk;
        
        wire    [TCAM_SLICE_EN_FACT-1:0]                tcam_row_0_col_0_slice_en = TCAM_SLICE_EN_FACT'(slice_en[(0 * TCAM_SLICE_EN_FACT)+:TCAM_SLICE_EN_MIN]);
        
        wire                                            tcam_row_0_col_0_rd_en       = tcam_row_rd_en[0];
        wire                                            tcam_row_0_col_0_wr_en       = tcam_row_wr_en[0];
        wire                                            tcam_row_0_col_0_chk_en      = chk_en;
        wire                                            tcam_row_0_col_0_reset_n = reset_n;
        wire    [8-1:0]                       tcam_row_0_col_0_adr  = tcam_row_adr[0][8-1:0];
        wire    [32-1:0]                      tcam_row_0_col_0_data_in = tcam_row_wr_en[0] ? tcam_wr_data_col[0][32-1:0] : tcam_chk_key_col[0][32-1:0];
        wire    [32-1:0]                      tcam_row_0_col_0_data_in_pre = tcam_wr_data_col[0][32-1:0] ;
        wire    [32-1:0]                      tcam_row_0_col_0_key_in =  tcam_chk_key_col[0][32-1:0];
        wire    [32-1:0]                      tcam_row_0_col_0_mask_in = tcam_chk_mask_col[0][32-1:0];
        wire    [128-1:0]                       tcam_row_0_col_0_hit_in = tcam_raw_hit_in[0];
        wire    [128-1:0]                       tcam_row_0_col_0_tcam_match_in = tcam_row_match_in[0];
        wire    [32-1:0]                      tcam_row_0_col_0_data_out_inv;
        logic   [128-1:0]                     tcam_row_0_col_0_hit_out_int;
        logic   [128-1:0]                     tcam_row_0_col_0_hit_out_latch;
        logic   [128-1:0]                     tcam_row_0_col_0_hit_out;
        
        `ifdef CXP_DFX_DISABLE
        wire                          tcam_row_0_col_0_biste = 'b0; 
        wire     [5-1:0]                  tcam_row_0_col_0_fca = 'b0;
        wire                            tcam_row_0_col_0_cre = 'b0;
        wire                            tcam_row_0_col_0_dftshiften = 'b0;
        wire                            tcam_row_0_col_0_dftmask = 'b0;
        wire                            tcam_row_0_col_0_dft_array_freeze = 'b0;
        wire                            tcam_row_0_col_0_dft_afd_reset_b = 'b0;
        wire      [32-1:0]    tcam_row_0_col_0_tdin = 'b0;
        wire      [8-1:0]     tcam_row_0_col_0_tadr = 'b0;
        wire                            tcam_row_0_col_0_tvbe = 'b0;
        wire                            tcam_row_0_col_0_tvbi = 'b0;
        wire      [32-1:0]    tcam_row_0_col_0_tmask = 'b0;
        wire                            tcam_row_0_col_0_twe = 'b0;
        wire                            tcam_row_0_col_0_tre = 'b0;
        wire                            tcam_row_0_col_0_tme = 'b0;
        wire                            tcam_row_0_col_0_bist_rotate_sr = 'b0;
        wire                            tcam_row_0_col_0_bist_en_sr_mask_b = 'b0;
        wire                            tcam_row_0_col_0_bist_all_mask = 'b0;
        wire                            tcam_row_0_col_0_bist_en_sr_data_b = 'b0;
        wire                            tcam_row_0_col_0_bist_cm_mode = 'b0;
        wire                            tcam_row_0_col_0_bist_cm_en_in = 'b0;
        wire                            tcam_row_0_col_0_bist_cm_match_sel0 = 'b0;
        wire                            tcam_row_0_col_0_bist_cm_match_sel1 = 'b0;
        wire                            tcam_row_0_col_0_bist_matchin_in = 'b0;
        wire                            tcam_row_0_col_0_bist_fls = 'b0;
        
        `else
        wire                            tcam_row_0_col_0_biste = 'b0;
        wire     [5-1:0]                  tcam_row_0_col_0_fca = 'b0;
        wire                            tcam_row_0_col_0_cre = 'b0;
        wire                            tcam_row_0_col_0_dftshiften = dftshiften;
        wire                            tcam_row_0_col_0_dftmask = dftmask;
        wire                            tcam_row_0_col_0_dft_array_freeze = dft_array_freeze;
        wire                            tcam_row_0_col_0_dft_afd_reset_b = dft_afd_reset_b;
        wire      [32-1:0]    tcam_row_0_col_0_tdin = 'b0;
        wire      [8-1:0]     tcam_row_0_col_0_tadr = 'b0;
        wire                            tcam_row_0_col_0_tvbe = 'b0;
        wire                            tcam_row_0_col_0_tvbi = 'b0;
        wire      [32-1:0]    tcam_row_0_col_0_tmask = 'b0;
        wire                            tcam_row_0_col_0_twe = 'b0;
        wire                            tcam_row_0_col_0_tre = 'b0;
        wire                            tcam_row_0_col_0_tme = 'b0;
        wire                            tcam_row_0_col_0_bist_rotate_sr = 'b0;
        wire                            tcam_row_0_col_0_bist_en_sr_mask_b = 'b0;
        wire                            tcam_row_0_col_0_bist_all_mask = 'b0;
        wire                            tcam_row_0_col_0_bist_en_sr_data_b = 'b0;
        wire                            tcam_row_0_col_0_bist_cm_mode = 'b0;
        wire                            tcam_row_0_col_0_bist_cm_en_in = 'b0;
        wire                            tcam_row_0_col_0_bist_cm_match_sel0 = 'b0;
        wire                            tcam_row_0_col_0_bist_cm_match_sel1 = 'b0;
        wire                            tcam_row_0_col_0_bist_matchin_in = 'b0;
        wire                            tcam_row_0_col_0_bist_fls = 'b0;
        `endif
        
        // Outputs
        logic                           tcam_row_0_col_0_wr_bira_fail;
        logic                           tcam_row_0_col_0_wr_so;
        logic                           tcam_row_0_col_0_curerrout;
        logic                           tcam_row_0_col_0_rscout;
        
        
        
        logic   [TCAM_SLICE_EN_FACT-1:0]                  tcam_row_0_col_0_slice_en_s0; 
        logic   [TCAM_SLICE_EN_FACT-1:0]                  tcam_row_0_col_0_slice_en_s1; 
        
        
        
             wire    [32-1:0]                     tcam_row_0_col_0_data_out ;
        
        
        
         generate
            if (BCAM_N7 == 0) 
              begin : gen_tcam_row_0_col_0_tcam
        
        
        // slice_en kept for TCAM only for backward compatability with Intel process
                always_comb 
                begin
                  for (int i = 0; i < TCAM_SLICE_EN_FACT; i++)
                      if (tcam_row_0_col_0_slice_en_s1[i])
                           tcam_row_0_col_0_hit_out[ i*64 +: 64]  = tcam_row_0_col_0_hit_out_int  [ i*64 +: 64]; 
                      else
                           tcam_row_0_col_0_hit_out[ i*64 +: 64]  = tcam_row_0_col_0_hit_out_latch[ i*64 +: 64]; 
                end
        
        
        
                always_ff  @(posedge tcam_row_0_col_0_clk)
                begin
                  tcam_row_0_col_0_slice_en_s0 <= tcam_row_0_col_0_slice_en; 
                  tcam_row_0_col_0_slice_en_s1 <= tcam_row_0_col_0_slice_en_s0; 
        
                  for (int i = 0; i < TCAM_SLICE_EN_FACT; i++)
                    begin
                      if (tcam_row_0_col_0_slice_en_s1[i])
                         tcam_row_0_col_0_hit_out_latch[ i*64 +: 64] <=  tcam_row_0_col_0_hit_out_int[ i*64 +: 64];
                    end
                end
        
        
        
        // NEW TCAM symbol 
        //                              _____________________________
        //                             |                             |
        //                         ----|ADRi                         |
        //                         ----|Di                           |
        //                         ----|RE                           |
        //                         ----|WE                           |
        //                         ----|ME                           |
        //                         ----|MASKi                        |
        //                         ----|DSEL                         |
        //                         ----|VBE                          |
        //                         ----|VBI                          |
        //                         ----|CMP                          |
        //                         ----|RVLDi                        |
        //                         ----|RST                          |
        //                         ----|FLS                          |
        //                         ----|CLK                          |
        //                         ----|FAF_EN                       |
        //                         ----|FAFi                         |
        //                             |                           Qi|---
        //                             |                         QVLD|---
        //                             |                         QHIT|---
        //                         ----|MDST_tcam                    |
        //                             |                         QHRi|---
        //                         ----|DFTSHIFTEN                   |
        //                         ----|DFTMASK                      |
        //                         ----|DFT_ARRAY_FREEZE             |
        //                         ----|DFT_AFD_RESET_B              |
        //                             |_____________________________|
        
                     
                         assign tcam_row_0_col_0_data_out  = ~tcam_row_0_col_0_data_out_inv;
                         wcm_ip783tcam128x32s0c1_0_0_wrap #(        
                                 )               
        
                                 ip783tcam128x32s0c1_wrap_tcam_row_0_col_0 (
                   //-------------------------------------------------------------
                   // Power Management Interfaces
                   //-------------------------------------------------------------   
                      `ifndef INTEL_NO_PWR_PINS
                      `ifdef INTC_ADD_VSS
                        .vss              (1'b0),
                      `endif
                        .vddp             (1'b1),
                      `endif
                         .ADR               (tcam_row_0_col_0_adr[8-1:1]), //Input adr_intess
                         .ME                (ce),  
        
                         .CLK               (tcam_row_0_col_0_clk), //Clock
                         .CMP               (tcam_row_0_col_0_chk_en), //Control Enable
                         .DIN               (~tcam_row_0_col_0_data_in), 
                         .DSEL              (~tcam_row_0_col_0_adr[0]), //dncen enables access of the TCAM Arrays adr_intessed
                         .FLS               (flush), //flush initiates a Flush operation that resets all Valid
                         .RVLD              (tcam_row_0_col_0_hit_in ), //Row validation bus. Each match_in input controls 1
                         .MASK              (tcam_row_0_col_0_mask_in), //Input msk
                         .QOUT              (tcam_row_0_col_0_data_out_inv), //Output vben
                         .QHR               (tcam_row_0_col_0_hit_out_int),
                         .QVLD              (), 
                         .RE                (tcam_row_0_col_0_rd_en), //Read Enable
                         .RST               (tcam_row_0_col_0_reset_n), //Asynchronous Active-High Reset
                         .VBE               (1'b1), //vben enables the Valid Bit addressed by adr[a-1:0] to
                         .VBI               (1'b0),//  Valid Bit Input
                         .WE                (tcam_row_0_col_0_wr_en), //Write Enable
                         .FAF               (tcam_row_0_col_0_fca),
                         .FAF_EN            (tcam_row_0_col_0_cre),
                         .DFTSHIFTEN        (tcam_row_0_col_0_dftshiften),
                         .DFTMASK           (tcam_row_0_col_0_dftmask),
                         .DFT_ARRAY_FREEZE  (tcam_row_0_col_0_dft_array_freeze),
                         .DFT_AFD_RESET_B   (tcam_row_0_col_0_dft_afd_reset_b),
                         .BISTE           (tcam_row_0_col_0_biste),
                         .TDIN (tcam_row_0_col_0_tdin),
                         .TADR (tcam_row_0_col_0_tadr),
                         .TVBE (tcam_row_0_col_0_tvbe),
                         .TVBI (tcam_row_0_col_0_tvbi),
                         .TMASK (tcam_row_0_col_0_tmask),
                         .TWE (tcam_row_0_col_0_twe),
                         .TRE (tcam_row_0_col_0_tre),
                         .TME (tcam_row_0_col_0_tme),
                         .BIST_ROTATE_SR (tcam_row_0_col_0_bist_rotate_sr),
                         .BIST_EN_SR_MASK_B (tcam_row_0_col_0_bist_en_sr_mask_b),
                         .BIST_ALL_MASK (tcam_row_0_col_0_bist_all_mask),
                         .BIST_EN_SR_DATA_B (tcam_row_0_col_0_bist_en_sr_data_b),
                         .BIST_CM_MODE (tcam_row_0_col_0_bist_cm_mode),
                         .BIST_CM_EN_IN (tcam_row_0_col_0_bist_cm_en_in),
                         .BIST_CM_MATCH_SEL0 (tcam_row_0_col_0_bist_cm_match_sel0),
                         .BIST_CM_MATCH_SEL1 (tcam_row_0_col_0_bist_cm_match_sel1),
                         .BIST_MATCHIN_IN (tcam_row_0_col_0_bist_matchin_in),
                         .BIST_FLS (tcam_row_0_col_0_bist_fls),
                         .MDST_tcam (fuse_tcam), .BIST_SETUP(BIST_SETUP), .BIST_SETUP_ts1(BIST_SETUP_ts1), 
                        .BIST_SETUP_ts2(BIST_SETUP_ts2), .to_interfaces_tck(to_interfaces_tck), 
                        .mcp_bounding_to_en(mcp_bounding_to_en), .scan_to_en(scan_to_en), 
                        .memory_bypass_to_en(memory_bypass_to_en), 
                        .GO_ID_REG_SEL(GO_ID_REG_SEL), .BIST_CLEAR_BIRA(BIST_CLEAR_BIRA), 
                        .BIST_COLLAR_DIAG_EN(BIST_COLLAR_DIAG_EN), 
                        .BIST_COLLAR_BIRA_EN(BIST_COLLAR_BIRA_EN), 
                        .BIST_SHIFT_BIRA_COLLAR(BIST_SHIFT_BIRA_COLLAR), 
                        .CHECK_REPAIR_NEEDED(CHECK_REPAIR_NEEDED), 
                        .MEM0_BIST_COLLAR_SI(MEM0_BIST_COLLAR_SI), .BIST_SO(BIST_SO), 
                        .BIST_GO(BIST_GO), .ltest_to_en(ltest_to_en), 
                        .BIST_USER9(BIST_USER9), .BIST_USER10(BIST_USER10), 
                        .BIST_USER11(BIST_USER11), .BIST_USER0(BIST_USER0), 
                        .BIST_USER1(BIST_USER1), .BIST_USER2(BIST_USER2), 
                        .BIST_USER3(BIST_USER3), .BIST_USER4(BIST_USER4), 
                        .BIST_USER5(BIST_USER5), .BIST_USER6(BIST_USER6), 
                        .BIST_USER7(BIST_USER7), .BIST_USER8(BIST_USER8), 
                        .BIST_EVEN_GROUPWRITEENABLE(BIST_EVEN_GROUPWRITEENABLE), 
                        .BIST_ODD_GROUPWRITEENABLE(BIST_ODD_GROUPWRITEENABLE), 
                        .BIST_WRITEENABLE(BIST_WRITEENABLE), .BIST_READENABLE(BIST_READENABLE), 
                        .BIST_SELECT(BIST_SELECT), .BIST_CMP(BIST_CMP), 
                        .INCLUDE_MEM_RESULTS_REG(INCLUDE_MEM_RESULTS_REG), 
                        .BIST_COL_ADD(BIST_COL_ADD), .BIST_ROW_ADD(BIST_ROW_ADD[5:0]), 
                        .BIST_COLLAR_EN0(BIST_COLLAR_EN0), 
                        .BIST_RUN_TO_COLLAR0(BIST_RUN_TO_COLLAR0), 
                        .BIST_ASYNC_RESET(BIST_ASYNC_RESET), 
                        .BIST_TESTDATA_SELECT_TO_COLLAR(BIST_TESTDATA_SELECT_TO_COLLAR), 
                        .BIST_ON_TO_COLLAR(BIST_ON_TO_COLLAR), 
                        .BIST_WRITE_DATA(BIST_WRITE_DATA[31:0]), 
                        .BIST_EXPECT_DATA(BIST_EXPECT_DATA[31:0]), 
                        .BIST_SHIFT_COLLAR(BIST_SHIFT_COLLAR), 
                        .BIST_COLLAR_SETUP(BIST_COLLAR_SETUP), 
                        .BIST_CLEAR_DEFAULT(BIST_CLEAR_DEFAULT), .BIST_CLEAR(BIST_CLEAR), 
                        .BIST_COLLAR_OPSET_SELECT(BIST_COLLAR_OPSET_SELECT[1:0]), 
                        .BIST_COLLAR_HOLD(BIST_COLLAR_HOLD), 
                        .FREEZE_STOP_ERROR(FREEZE_STOP_ERROR), 
                        .ERROR_CNT_ZERO(ERROR_CNT_ZERO), 
                        .MBISTPG_RESET_REG_SETUP2(MBISTPG_RESET_REG_SETUP2), 
                        .BIST_BANK_ADD(BIST_BANK_ADD), .bisr_shift_en_pd_vinf(bisr_shift_en_pd_vinf), 
                        .bisr_clk_pd_vinf(bisr_clk_pd_vinf), 
                        .bisr_reset_pd_vinf(bisr_reset_pd_vinf), 
                        .ram_row_0_col_6_bisr_inst_SO(ram_row_0_col_6_bisr_inst_SO), 
                        .tcam_row_0_col_0_bisr_inst_SO(tcam_row_0_col_0_bisr_inst_SO), 
                        .fscan_clkungate(fscan_clkungate)
                     );
        
              end

              
            else
              begin : gen_tcam_row_0_col_0_bcam
              end
              
        
        
        endgenerate
        
        always_ff @(posedge clk) begin
                   tcam_rd_data_col[0][0]      <= tcam_row_0_col_0_data_out;
                   tcam_col_hit_out[0][0]       <= tcam_row_0_col_0_hit_out;
        end
        

        // this is new template - tcam_asic_template
        
        wire                                            tcam_row_0_col_1_clk         = clk;
        
        wire    [TCAM_SLICE_EN_FACT-1:0]                tcam_row_0_col_1_slice_en = TCAM_SLICE_EN_FACT'(slice_en[(0 * TCAM_SLICE_EN_FACT)+:TCAM_SLICE_EN_MIN]);
        
        wire                                            tcam_row_0_col_1_rd_en       = tcam_row_rd_en[0];
        wire                                            tcam_row_0_col_1_wr_en       = tcam_row_wr_en[0];
        wire                                            tcam_row_0_col_1_chk_en      = chk_en;
        wire                                            tcam_row_0_col_1_reset_n = reset_n;
        wire    [8-1:0]                       tcam_row_0_col_1_adr  = tcam_row_adr[0][8-1:0];
        wire    [32-1:0]                      tcam_row_0_col_1_data_in = tcam_row_wr_en[0] ? tcam_wr_data_col[1][32-1:0] : tcam_chk_key_col[1][32-1:0];
        wire    [32-1:0]                      tcam_row_0_col_1_data_in_pre = tcam_wr_data_col[1][32-1:0] ;
        wire    [32-1:0]                      tcam_row_0_col_1_key_in =  tcam_chk_key_col[1][32-1:0];
        wire    [32-1:0]                      tcam_row_0_col_1_mask_in = tcam_chk_mask_col[1][32-1:0];
        wire    [128-1:0]                       tcam_row_0_col_1_hit_in = tcam_raw_hit_in[0];
        wire    [128-1:0]                       tcam_row_0_col_1_tcam_match_in = tcam_row_match_in[0];
        wire    [32-1:0]                      tcam_row_0_col_1_data_out_inv;
        logic   [128-1:0]                     tcam_row_0_col_1_hit_out_int;
        logic   [128-1:0]                     tcam_row_0_col_1_hit_out_latch;
        logic   [128-1:0]                     tcam_row_0_col_1_hit_out;
        
        `ifdef CXP_DFX_DISABLE
        wire                          tcam_row_0_col_1_biste = 'b0; 
        wire     [5-1:0]                  tcam_row_0_col_1_fca = 'b0;
        wire                            tcam_row_0_col_1_cre = 'b0;
        wire                            tcam_row_0_col_1_dftshiften = 'b0;
        wire                            tcam_row_0_col_1_dftmask = 'b0;
        wire                            tcam_row_0_col_1_dft_array_freeze = 'b0;
        wire                            tcam_row_0_col_1_dft_afd_reset_b = 'b0;
        wire      [32-1:0]    tcam_row_0_col_1_tdin = 'b0;
        wire      [8-1:0]     tcam_row_0_col_1_tadr = 'b0;
        wire                            tcam_row_0_col_1_tvbe = 'b0;
        wire                            tcam_row_0_col_1_tvbi = 'b0;
        wire      [32-1:0]    tcam_row_0_col_1_tmask = 'b0;
        wire                            tcam_row_0_col_1_twe = 'b0;
        wire                            tcam_row_0_col_1_tre = 'b0;
        wire                            tcam_row_0_col_1_tme = 'b0;
        wire                            tcam_row_0_col_1_bist_rotate_sr = 'b0;
        wire                            tcam_row_0_col_1_bist_en_sr_mask_b = 'b0;
        wire                            tcam_row_0_col_1_bist_all_mask = 'b0;
        wire                            tcam_row_0_col_1_bist_en_sr_data_b = 'b0;
        wire                            tcam_row_0_col_1_bist_cm_mode = 'b0;
        wire                            tcam_row_0_col_1_bist_cm_en_in = 'b0;
        wire                            tcam_row_0_col_1_bist_cm_match_sel0 = 'b0;
        wire                            tcam_row_0_col_1_bist_cm_match_sel1 = 'b0;
        wire                            tcam_row_0_col_1_bist_matchin_in = 'b0;
        wire                            tcam_row_0_col_1_bist_fls = 'b0;
        
        `else
        wire                            tcam_row_0_col_1_biste = 'b0;
        wire     [5-1:0]                  tcam_row_0_col_1_fca = 'b0;
        wire                            tcam_row_0_col_1_cre = 'b0;
        wire                            tcam_row_0_col_1_dftshiften = dftshiften;
        wire                            tcam_row_0_col_1_dftmask = dftmask;
        wire                            tcam_row_0_col_1_dft_array_freeze = dft_array_freeze;
        wire                            tcam_row_0_col_1_dft_afd_reset_b = dft_afd_reset_b;
        wire      [32-1:0]    tcam_row_0_col_1_tdin = 'b0;
        wire      [8-1:0]     tcam_row_0_col_1_tadr = 'b0;
        wire                            tcam_row_0_col_1_tvbe = 'b0;
        wire                            tcam_row_0_col_1_tvbi = 'b0;
        wire      [32-1:0]    tcam_row_0_col_1_tmask = 'b0;
        wire                            tcam_row_0_col_1_twe = 'b0;
        wire                            tcam_row_0_col_1_tre = 'b0;
        wire                            tcam_row_0_col_1_tme = 'b0;
        wire                            tcam_row_0_col_1_bist_rotate_sr = 'b0;
        wire                            tcam_row_0_col_1_bist_en_sr_mask_b = 'b0;
        wire                            tcam_row_0_col_1_bist_all_mask = 'b0;
        wire                            tcam_row_0_col_1_bist_en_sr_data_b = 'b0;
        wire                            tcam_row_0_col_1_bist_cm_mode = 'b0;
        wire                            tcam_row_0_col_1_bist_cm_en_in = 'b0;
        wire                            tcam_row_0_col_1_bist_cm_match_sel0 = 'b0;
        wire                            tcam_row_0_col_1_bist_cm_match_sel1 = 'b0;
        wire                            tcam_row_0_col_1_bist_matchin_in = 'b0;
        wire                            tcam_row_0_col_1_bist_fls = 'b0;
        `endif
        
        // Outputs
        logic                           tcam_row_0_col_1_wr_bira_fail;
        logic                           tcam_row_0_col_1_wr_so;
        logic                           tcam_row_0_col_1_curerrout;
        logic                           tcam_row_0_col_1_rscout;
        
        
        
        logic   [TCAM_SLICE_EN_FACT-1:0]                  tcam_row_0_col_1_slice_en_s0; 
        logic   [TCAM_SLICE_EN_FACT-1:0]                  tcam_row_0_col_1_slice_en_s1; 
        
        
        
             wire    [32-1:0]                     tcam_row_0_col_1_data_out ;
        
        
        
         generate
            if (BCAM_N7 == 0) 
              begin : gen_tcam_row_0_col_1_tcam
        
        
        // slice_en kept for TCAM only for backward compatability with Intel process
                always_comb 
                begin
                  for (int i = 0; i < TCAM_SLICE_EN_FACT; i++)
                      if (tcam_row_0_col_1_slice_en_s1[i])
                           tcam_row_0_col_1_hit_out[ i*64 +: 64]  = tcam_row_0_col_1_hit_out_int  [ i*64 +: 64]; 
                      else
                           tcam_row_0_col_1_hit_out[ i*64 +: 64]  = tcam_row_0_col_1_hit_out_latch[ i*64 +: 64]; 
                end
        
        
        
                always_ff  @(posedge tcam_row_0_col_1_clk)
                begin
                  tcam_row_0_col_1_slice_en_s0 <= tcam_row_0_col_1_slice_en; 
                  tcam_row_0_col_1_slice_en_s1 <= tcam_row_0_col_1_slice_en_s0; 
        
                  for (int i = 0; i < TCAM_SLICE_EN_FACT; i++)
                    begin
                      if (tcam_row_0_col_1_slice_en_s1[i])
                         tcam_row_0_col_1_hit_out_latch[ i*64 +: 64] <=  tcam_row_0_col_1_hit_out_int[ i*64 +: 64];
                    end
                end
        
        
        
        // NEW TCAM symbol 
        //                              _____________________________
        //                             |                             |
        //                         ----|ADRi                         |
        //                         ----|Di                           |
        //                         ----|RE                           |
        //                         ----|WE                           |
        //                         ----|ME                           |
        //                         ----|MASKi                        |
        //                         ----|DSEL                         |
        //                         ----|VBE                          |
        //                         ----|VBI                          |
        //                         ----|CMP                          |
        //                         ----|RVLDi                        |
        //                         ----|RST                          |
        //                         ----|FLS                          |
        //                         ----|CLK                          |
        //                         ----|FAF_EN                       |
        //                         ----|FAFi                         |
        //                             |                           Qi|---
        //                             |                         QVLD|---
        //                             |                         QHIT|---
        //                         ----|MDST_tcam                    |
        //                             |                         QHRi|---
        //                         ----|DFTSHIFTEN                   |
        //                         ----|DFTMASK                      |
        //                         ----|DFT_ARRAY_FREEZE             |
        //                         ----|DFT_AFD_RESET_B              |
        //                             |_____________________________|
        
                     
                         assign tcam_row_0_col_1_data_out  = ~tcam_row_0_col_1_data_out_inv;
                         wcm_ip783tcam128x32s0c1_0_1_wrap #(        
                                 )               
        
                                 ip783tcam128x32s0c1_wrap_tcam_row_0_col_1 (
                   //-------------------------------------------------------------
                   // Power Management Interfaces
                   //-------------------------------------------------------------   
                      `ifndef INTEL_NO_PWR_PINS
                      `ifdef INTC_ADD_VSS
                        .vss              (1'b0),
                      `endif
                        .vddp             (1'b1),
                      `endif
                         .ADR               (tcam_row_0_col_1_adr[8-1:1]), //Input adr_intess
                         .ME                (ce),  
        
                         .CLK               (tcam_row_0_col_1_clk), //Clock
                         .CMP               (tcam_row_0_col_1_chk_en), //Control Enable
                         .DIN               (~tcam_row_0_col_1_data_in), 
                         .DSEL              (~tcam_row_0_col_1_adr[0]), //dncen enables access of the TCAM Arrays adr_intessed
                         .FLS               (flush), //flush initiates a Flush operation that resets all Valid
                         .RVLD              (tcam_row_0_col_1_hit_in ), //Row validation bus. Each match_in input controls 1
                         .MASK              (tcam_row_0_col_1_mask_in), //Input msk
                         .QOUT              (tcam_row_0_col_1_data_out_inv), //Output vben
                         .QHR               (tcam_row_0_col_1_hit_out_int),
                         .QVLD              (), 
                         .RE                (tcam_row_0_col_1_rd_en), //Read Enable
                         .RST               (tcam_row_0_col_1_reset_n), //Asynchronous Active-High Reset
                         .VBE               (1'b1), //vben enables the Valid Bit addressed by adr[a-1:0] to
                         .VBI               (1'b0),//  Valid Bit Input
                         .WE                (tcam_row_0_col_1_wr_en), //Write Enable
                         .FAF               (tcam_row_0_col_1_fca),
                         .FAF_EN            (tcam_row_0_col_1_cre),
                         .DFTSHIFTEN        (tcam_row_0_col_1_dftshiften),
                         .DFTMASK           (tcam_row_0_col_1_dftmask),
                         .DFT_ARRAY_FREEZE  (tcam_row_0_col_1_dft_array_freeze),
                         .DFT_AFD_RESET_B   (tcam_row_0_col_1_dft_afd_reset_b),
                         .BISTE           (tcam_row_0_col_1_biste),
                         .TDIN (tcam_row_0_col_1_tdin),
                         .TADR (tcam_row_0_col_1_tadr),
                         .TVBE (tcam_row_0_col_1_tvbe),
                         .TVBI (tcam_row_0_col_1_tvbi),
                         .TMASK (tcam_row_0_col_1_tmask),
                         .TWE (tcam_row_0_col_1_twe),
                         .TRE (tcam_row_0_col_1_tre),
                         .TME (tcam_row_0_col_1_tme),
                         .BIST_ROTATE_SR (tcam_row_0_col_1_bist_rotate_sr),
                         .BIST_EN_SR_MASK_B (tcam_row_0_col_1_bist_en_sr_mask_b),
                         .BIST_ALL_MASK (tcam_row_0_col_1_bist_all_mask),
                         .BIST_EN_SR_DATA_B (tcam_row_0_col_1_bist_en_sr_data_b),
                         .BIST_CM_MODE (tcam_row_0_col_1_bist_cm_mode),
                         .BIST_CM_EN_IN (tcam_row_0_col_1_bist_cm_en_in),
                         .BIST_CM_MATCH_SEL0 (tcam_row_0_col_1_bist_cm_match_sel0),
                         .BIST_CM_MATCH_SEL1 (tcam_row_0_col_1_bist_cm_match_sel1),
                         .BIST_MATCHIN_IN (tcam_row_0_col_1_bist_matchin_in),
                         .BIST_FLS (tcam_row_0_col_1_bist_fls),
                         .MDST_tcam (fuse_tcam), .BIST_SETUP(BIST_SETUP), .BIST_SETUP_ts1(BIST_SETUP_ts1), 
                        .BIST_SETUP_ts2(BIST_SETUP_ts2), .to_interfaces_tck(to_interfaces_tck), 
                        .mcp_bounding_to_en(mcp_bounding_to_en), .scan_to_en(scan_to_en), 
                        .memory_bypass_to_en(memory_bypass_to_en), 
                        .GO_ID_REG_SEL(GO_ID_REG_SEL), .BIST_CLEAR_BIRA(BIST_CLEAR_BIRA), 
                        .BIST_COLLAR_DIAG_EN(BIST_COLLAR_DIAG_EN), 
                        .BIST_COLLAR_BIRA_EN(BIST_COLLAR_BIRA_EN), 
                        .BIST_SHIFT_BIRA_COLLAR(BIST_SHIFT_BIRA_COLLAR), 
                        .CHECK_REPAIR_NEEDED(CHECK_REPAIR_NEEDED), 
                        .MEM7_BIST_COLLAR_SI(MEM7_BIST_COLLAR_SI), .BIST_SO(BIST_SO_ts7), 
                        .BIST_GO(BIST_GO_ts7), .ltest_to_en(ltest_to_en), 
                        .BIST_USER9(BIST_USER9), .BIST_USER10(BIST_USER10), 
                        .BIST_USER11(BIST_USER11), .BIST_USER0(BIST_USER0), 
                        .BIST_USER1(BIST_USER1), .BIST_USER2(BIST_USER2), 
                        .BIST_USER3(BIST_USER3), .BIST_USER4(BIST_USER4), 
                        .BIST_USER5(BIST_USER5), .BIST_USER6(BIST_USER6), 
                        .BIST_USER7(BIST_USER7), .BIST_USER8(BIST_USER8), 
                        .BIST_EVEN_GROUPWRITEENABLE(BIST_EVEN_GROUPWRITEENABLE), 
                        .BIST_ODD_GROUPWRITEENABLE(BIST_ODD_GROUPWRITEENABLE), 
                        .BIST_WRITEENABLE(BIST_WRITEENABLE), .BIST_READENABLE(BIST_READENABLE), 
                        .BIST_SELECT(BIST_SELECT), .BIST_CMP(BIST_CMP), 
                        .INCLUDE_MEM_RESULTS_REG(INCLUDE_MEM_RESULTS_REG), 
                        .BIST_COL_ADD(BIST_COL_ADD), .BIST_ROW_ADD(BIST_ROW_ADD[5:0]), 
                        .BIST_COLLAR_EN7(BIST_COLLAR_EN7), 
                        .BIST_RUN_TO_COLLAR7(BIST_RUN_TO_COLLAR7), 
                        .BIST_ASYNC_RESET(BIST_ASYNC_RESET), 
                        .BIST_TESTDATA_SELECT_TO_COLLAR(BIST_TESTDATA_SELECT_TO_COLLAR), 
                        .BIST_ON_TO_COLLAR(BIST_ON_TO_COLLAR), 
                        .BIST_WRITE_DATA(BIST_WRITE_DATA[31:0]), 
                        .BIST_EXPECT_DATA(BIST_EXPECT_DATA[31:0]), 
                        .BIST_SHIFT_COLLAR(BIST_SHIFT_COLLAR), 
                        .BIST_COLLAR_SETUP(BIST_COLLAR_SETUP), 
                        .BIST_CLEAR_DEFAULT(BIST_CLEAR_DEFAULT), .BIST_CLEAR(BIST_CLEAR), 
                        .BIST_COLLAR_OPSET_SELECT(BIST_COLLAR_OPSET_SELECT[1:0]), 
                        .BIST_COLLAR_HOLD(BIST_COLLAR_HOLD), 
                        .FREEZE_STOP_ERROR(FREEZE_STOP_ERROR), 
                        .ERROR_CNT_ZERO(ERROR_CNT_ZERO), 
                        .MBISTPG_RESET_REG_SETUP2(MBISTPG_RESET_REG_SETUP2), 
                        .BIST_BANK_ADD(BIST_BANK_ADD), .bisr_shift_en_pd_vinf(bisr_shift_en_pd_vinf), 
                        .bisr_clk_pd_vinf(bisr_clk_pd_vinf), 
                        .bisr_reset_pd_vinf(bisr_reset_pd_vinf), 
                        .tcam_row_0_col_15_bisr_inst_SO(tcam_row_0_col_15_bisr_inst_SO), 
                        .tcam_row_0_col_1_bisr_inst_SO(tcam_row_0_col_1_bisr_inst_SO), 
                        .fscan_clkungate(fscan_clkungate)
                     );
        
              end

              
            else
              begin : gen_tcam_row_0_col_1_bcam
              end
              
        
        
        endgenerate
        
        always_ff @(posedge clk) begin
                   tcam_rd_data_col[0][1]      <= tcam_row_0_col_1_data_out;
                   tcam_col_hit_out[0][1]       <= tcam_row_0_col_1_hit_out;
        end
        

        // this is new template - tcam_asic_template
        
        wire                                            tcam_row_0_col_2_clk         = clk;
        
        wire    [TCAM_SLICE_EN_FACT-1:0]                tcam_row_0_col_2_slice_en = TCAM_SLICE_EN_FACT'(slice_en[(0 * TCAM_SLICE_EN_FACT)+:TCAM_SLICE_EN_MIN]);
        
        wire                                            tcam_row_0_col_2_rd_en       = tcam_row_rd_en[0];
        wire                                            tcam_row_0_col_2_wr_en       = tcam_row_wr_en[0];
        wire                                            tcam_row_0_col_2_chk_en      = chk_en;
        wire                                            tcam_row_0_col_2_reset_n = reset_n;
        wire    [8-1:0]                       tcam_row_0_col_2_adr  = tcam_row_adr[0][8-1:0];
        wire    [32-1:0]                      tcam_row_0_col_2_data_in = tcam_row_wr_en[0] ? tcam_wr_data_col[2][32-1:0] : tcam_chk_key_col[2][32-1:0];
        wire    [32-1:0]                      tcam_row_0_col_2_data_in_pre = tcam_wr_data_col[2][32-1:0] ;
        wire    [32-1:0]                      tcam_row_0_col_2_key_in =  tcam_chk_key_col[2][32-1:0];
        wire    [32-1:0]                      tcam_row_0_col_2_mask_in = tcam_chk_mask_col[2][32-1:0];
        wire    [128-1:0]                       tcam_row_0_col_2_hit_in = tcam_raw_hit_in[0];
        wire    [128-1:0]                       tcam_row_0_col_2_tcam_match_in = tcam_row_match_in[0];
        wire    [32-1:0]                      tcam_row_0_col_2_data_out_inv;
        logic   [128-1:0]                     tcam_row_0_col_2_hit_out_int;
        logic   [128-1:0]                     tcam_row_0_col_2_hit_out_latch;
        logic   [128-1:0]                     tcam_row_0_col_2_hit_out;
        
        `ifdef CXP_DFX_DISABLE
        wire                          tcam_row_0_col_2_biste = 'b0; 
        wire     [5-1:0]                  tcam_row_0_col_2_fca = 'b0;
        wire                            tcam_row_0_col_2_cre = 'b0;
        wire                            tcam_row_0_col_2_dftshiften = 'b0;
        wire                            tcam_row_0_col_2_dftmask = 'b0;
        wire                            tcam_row_0_col_2_dft_array_freeze = 'b0;
        wire                            tcam_row_0_col_2_dft_afd_reset_b = 'b0;
        wire      [32-1:0]    tcam_row_0_col_2_tdin = 'b0;
        wire      [8-1:0]     tcam_row_0_col_2_tadr = 'b0;
        wire                            tcam_row_0_col_2_tvbe = 'b0;
        wire                            tcam_row_0_col_2_tvbi = 'b0;
        wire      [32-1:0]    tcam_row_0_col_2_tmask = 'b0;
        wire                            tcam_row_0_col_2_twe = 'b0;
        wire                            tcam_row_0_col_2_tre = 'b0;
        wire                            tcam_row_0_col_2_tme = 'b0;
        wire                            tcam_row_0_col_2_bist_rotate_sr = 'b0;
        wire                            tcam_row_0_col_2_bist_en_sr_mask_b = 'b0;
        wire                            tcam_row_0_col_2_bist_all_mask = 'b0;
        wire                            tcam_row_0_col_2_bist_en_sr_data_b = 'b0;
        wire                            tcam_row_0_col_2_bist_cm_mode = 'b0;
        wire                            tcam_row_0_col_2_bist_cm_en_in = 'b0;
        wire                            tcam_row_0_col_2_bist_cm_match_sel0 = 'b0;
        wire                            tcam_row_0_col_2_bist_cm_match_sel1 = 'b0;
        wire                            tcam_row_0_col_2_bist_matchin_in = 'b0;
        wire                            tcam_row_0_col_2_bist_fls = 'b0;
        
        `else
        wire                            tcam_row_0_col_2_biste = 'b0;
        wire     [5-1:0]                  tcam_row_0_col_2_fca = 'b0;
        wire                            tcam_row_0_col_2_cre = 'b0;
        wire                            tcam_row_0_col_2_dftshiften = dftshiften;
        wire                            tcam_row_0_col_2_dftmask = dftmask;
        wire                            tcam_row_0_col_2_dft_array_freeze = dft_array_freeze;
        wire                            tcam_row_0_col_2_dft_afd_reset_b = dft_afd_reset_b;
        wire      [32-1:0]    tcam_row_0_col_2_tdin = 'b0;
        wire      [8-1:0]     tcam_row_0_col_2_tadr = 'b0;
        wire                            tcam_row_0_col_2_tvbe = 'b0;
        wire                            tcam_row_0_col_2_tvbi = 'b0;
        wire      [32-1:0]    tcam_row_0_col_2_tmask = 'b0;
        wire                            tcam_row_0_col_2_twe = 'b0;
        wire                            tcam_row_0_col_2_tre = 'b0;
        wire                            tcam_row_0_col_2_tme = 'b0;
        wire                            tcam_row_0_col_2_bist_rotate_sr = 'b0;
        wire                            tcam_row_0_col_2_bist_en_sr_mask_b = 'b0;
        wire                            tcam_row_0_col_2_bist_all_mask = 'b0;
        wire                            tcam_row_0_col_2_bist_en_sr_data_b = 'b0;
        wire                            tcam_row_0_col_2_bist_cm_mode = 'b0;
        wire                            tcam_row_0_col_2_bist_cm_en_in = 'b0;
        wire                            tcam_row_0_col_2_bist_cm_match_sel0 = 'b0;
        wire                            tcam_row_0_col_2_bist_cm_match_sel1 = 'b0;
        wire                            tcam_row_0_col_2_bist_matchin_in = 'b0;
        wire                            tcam_row_0_col_2_bist_fls = 'b0;
        `endif
        
        // Outputs
        logic                           tcam_row_0_col_2_wr_bira_fail;
        logic                           tcam_row_0_col_2_wr_so;
        logic                           tcam_row_0_col_2_curerrout;
        logic                           tcam_row_0_col_2_rscout;
        
        
        
        logic   [TCAM_SLICE_EN_FACT-1:0]                  tcam_row_0_col_2_slice_en_s0; 
        logic   [TCAM_SLICE_EN_FACT-1:0]                  tcam_row_0_col_2_slice_en_s1; 
        
        
        
             wire    [32-1:0]                     tcam_row_0_col_2_data_out ;
        
        
        
         generate
            if (BCAM_N7 == 0) 
              begin : gen_tcam_row_0_col_2_tcam
        
        
        // slice_en kept for TCAM only for backward compatability with Intel process
                always_comb 
                begin
                  for (int i = 0; i < TCAM_SLICE_EN_FACT; i++)
                      if (tcam_row_0_col_2_slice_en_s1[i])
                           tcam_row_0_col_2_hit_out[ i*64 +: 64]  = tcam_row_0_col_2_hit_out_int  [ i*64 +: 64]; 
                      else
                           tcam_row_0_col_2_hit_out[ i*64 +: 64]  = tcam_row_0_col_2_hit_out_latch[ i*64 +: 64]; 
                end
        
        
        
                always_ff  @(posedge tcam_row_0_col_2_clk)
                begin
                  tcam_row_0_col_2_slice_en_s0 <= tcam_row_0_col_2_slice_en; 
                  tcam_row_0_col_2_slice_en_s1 <= tcam_row_0_col_2_slice_en_s0; 
        
                  for (int i = 0; i < TCAM_SLICE_EN_FACT; i++)
                    begin
                      if (tcam_row_0_col_2_slice_en_s1[i])
                         tcam_row_0_col_2_hit_out_latch[ i*64 +: 64] <=  tcam_row_0_col_2_hit_out_int[ i*64 +: 64];
                    end
                end
        
        
        
        // NEW TCAM symbol 
        //                              _____________________________
        //                             |                             |
        //                         ----|ADRi                         |
        //                         ----|Di                           |
        //                         ----|RE                           |
        //                         ----|WE                           |
        //                         ----|ME                           |
        //                         ----|MASKi                        |
        //                         ----|DSEL                         |
        //                         ----|VBE                          |
        //                         ----|VBI                          |
        //                         ----|CMP                          |
        //                         ----|RVLDi                        |
        //                         ----|RST                          |
        //                         ----|FLS                          |
        //                         ----|CLK                          |
        //                         ----|FAF_EN                       |
        //                         ----|FAFi                         |
        //                             |                           Qi|---
        //                             |                         QVLD|---
        //                             |                         QHIT|---
        //                         ----|MDST_tcam                    |
        //                             |                         QHRi|---
        //                         ----|DFTSHIFTEN                   |
        //                         ----|DFTMASK                      |
        //                         ----|DFT_ARRAY_FREEZE             |
        //                         ----|DFT_AFD_RESET_B              |
        //                             |_____________________________|
        
                     
                         assign tcam_row_0_col_2_data_out  = ~tcam_row_0_col_2_data_out_inv;
                         wcm_ip783tcam128x32s0c1_0_2_wrap #(        
                                 )               
        
                                 ip783tcam128x32s0c1_wrap_tcam_row_0_col_2 (
                   //-------------------------------------------------------------
                   // Power Management Interfaces
                   //-------------------------------------------------------------   
                      `ifndef INTEL_NO_PWR_PINS
                      `ifdef INTC_ADD_VSS
                        .vss              (1'b0),
                      `endif
                        .vddp             (1'b1),
                      `endif
                         .ADR               (tcam_row_0_col_2_adr[8-1:1]), //Input adr_intess
                         .ME                (ce),  
        
                         .CLK               (tcam_row_0_col_2_clk), //Clock
                         .CMP               (tcam_row_0_col_2_chk_en), //Control Enable
                         .DIN               (~tcam_row_0_col_2_data_in), 
                         .DSEL              (~tcam_row_0_col_2_adr[0]), //dncen enables access of the TCAM Arrays adr_intessed
                         .FLS               (flush), //flush initiates a Flush operation that resets all Valid
                         .RVLD              (tcam_row_0_col_2_hit_in ), //Row validation bus. Each match_in input controls 1
                         .MASK              (tcam_row_0_col_2_mask_in), //Input msk
                         .QOUT              (tcam_row_0_col_2_data_out_inv), //Output vben
                         .QHR               (tcam_row_0_col_2_hit_out_int),
                         .QVLD              (), 
                         .RE                (tcam_row_0_col_2_rd_en), //Read Enable
                         .RST               (tcam_row_0_col_2_reset_n), //Asynchronous Active-High Reset
                         .VBE               (1'b1), //vben enables the Valid Bit addressed by adr[a-1:0] to
                         .VBI               (1'b0),//  Valid Bit Input
                         .WE                (tcam_row_0_col_2_wr_en), //Write Enable
                         .FAF               (tcam_row_0_col_2_fca),
                         .FAF_EN            (tcam_row_0_col_2_cre),
                         .DFTSHIFTEN        (tcam_row_0_col_2_dftshiften),
                         .DFTMASK           (tcam_row_0_col_2_dftmask),
                         .DFT_ARRAY_FREEZE  (tcam_row_0_col_2_dft_array_freeze),
                         .DFT_AFD_RESET_B   (tcam_row_0_col_2_dft_afd_reset_b),
                         .BISTE           (tcam_row_0_col_2_biste),
                         .TDIN (tcam_row_0_col_2_tdin),
                         .TADR (tcam_row_0_col_2_tadr),
                         .TVBE (tcam_row_0_col_2_tvbe),
                         .TVBI (tcam_row_0_col_2_tvbi),
                         .TMASK (tcam_row_0_col_2_tmask),
                         .TWE (tcam_row_0_col_2_twe),
                         .TRE (tcam_row_0_col_2_tre),
                         .TME (tcam_row_0_col_2_tme),
                         .BIST_ROTATE_SR (tcam_row_0_col_2_bist_rotate_sr),
                         .BIST_EN_SR_MASK_B (tcam_row_0_col_2_bist_en_sr_mask_b),
                         .BIST_ALL_MASK (tcam_row_0_col_2_bist_all_mask),
                         .BIST_EN_SR_DATA_B (tcam_row_0_col_2_bist_en_sr_data_b),
                         .BIST_CM_MODE (tcam_row_0_col_2_bist_cm_mode),
                         .BIST_CM_EN_IN (tcam_row_0_col_2_bist_cm_en_in),
                         .BIST_CM_MATCH_SEL0 (tcam_row_0_col_2_bist_cm_match_sel0),
                         .BIST_CM_MATCH_SEL1 (tcam_row_0_col_2_bist_cm_match_sel1),
                         .BIST_MATCHIN_IN (tcam_row_0_col_2_bist_matchin_in),
                         .BIST_FLS (tcam_row_0_col_2_bist_fls),
                         .MDST_tcam (fuse_tcam), .BIST_SETUP(BIST_SETUP), .BIST_SETUP_ts1(BIST_SETUP_ts1), 
                        .BIST_SETUP_ts2(BIST_SETUP_ts2), .to_interfaces_tck(to_interfaces_tck), 
                        .mcp_bounding_to_en(mcp_bounding_to_en), .scan_to_en(scan_to_en), 
                        .memory_bypass_to_en(memory_bypass_to_en), 
                        .GO_ID_REG_SEL(GO_ID_REG_SEL), .BIST_CLEAR_BIRA(BIST_CLEAR_BIRA), 
                        .BIST_COLLAR_DIAG_EN(BIST_COLLAR_DIAG_EN), 
                        .BIST_COLLAR_BIRA_EN(BIST_COLLAR_BIRA_EN), 
                        .BIST_SHIFT_BIRA_COLLAR(BIST_SHIFT_BIRA_COLLAR), 
                        .CHECK_REPAIR_NEEDED(CHECK_REPAIR_NEEDED), 
                        .MEM8_BIST_COLLAR_SI(MEM8_BIST_COLLAR_SI), .BIST_SO(BIST_SO_ts8), 
                        .BIST_GO(BIST_GO_ts8), .ltest_to_en(ltest_to_en), 
                        .BIST_USER9(BIST_USER9), .BIST_USER10(BIST_USER10), 
                        .BIST_USER11(BIST_USER11), .BIST_USER0(BIST_USER0), 
                        .BIST_USER1(BIST_USER1), .BIST_USER2(BIST_USER2), 
                        .BIST_USER3(BIST_USER3), .BIST_USER4(BIST_USER4), 
                        .BIST_USER5(BIST_USER5), .BIST_USER6(BIST_USER6), 
                        .BIST_USER7(BIST_USER7), .BIST_USER8(BIST_USER8), 
                        .BIST_EVEN_GROUPWRITEENABLE(BIST_EVEN_GROUPWRITEENABLE), 
                        .BIST_ODD_GROUPWRITEENABLE(BIST_ODD_GROUPWRITEENABLE), 
                        .BIST_WRITEENABLE(BIST_WRITEENABLE), .BIST_READENABLE(BIST_READENABLE), 
                        .BIST_SELECT(BIST_SELECT), .BIST_CMP(BIST_CMP), 
                        .INCLUDE_MEM_RESULTS_REG(INCLUDE_MEM_RESULTS_REG), 
                        .BIST_COL_ADD(BIST_COL_ADD), .BIST_ROW_ADD(BIST_ROW_ADD[5:0]), 
                        .BIST_COLLAR_EN8(BIST_COLLAR_EN8), 
                        .BIST_RUN_TO_COLLAR8(BIST_RUN_TO_COLLAR8), 
                        .BIST_ASYNC_RESET(BIST_ASYNC_RESET), 
                        .BIST_TESTDATA_SELECT_TO_COLLAR(BIST_TESTDATA_SELECT_TO_COLLAR), 
                        .BIST_ON_TO_COLLAR(BIST_ON_TO_COLLAR), 
                        .BIST_WRITE_DATA(BIST_WRITE_DATA[31:0]), 
                        .BIST_EXPECT_DATA(BIST_EXPECT_DATA[31:0]), 
                        .BIST_SHIFT_COLLAR(BIST_SHIFT_COLLAR), 
                        .BIST_COLLAR_SETUP(BIST_COLLAR_SETUP), 
                        .BIST_CLEAR_DEFAULT(BIST_CLEAR_DEFAULT), .BIST_CLEAR(BIST_CLEAR), 
                        .BIST_COLLAR_OPSET_SELECT(BIST_COLLAR_OPSET_SELECT[1:0]), 
                        .BIST_COLLAR_HOLD(BIST_COLLAR_HOLD), 
                        .FREEZE_STOP_ERROR(FREEZE_STOP_ERROR), 
                        .ERROR_CNT_ZERO(ERROR_CNT_ZERO), 
                        .MBISTPG_RESET_REG_SETUP2(MBISTPG_RESET_REG_SETUP2), 
                        .BIST_BANK_ADD(BIST_BANK_ADD), .bisr_shift_en_pd_vinf(bisr_shift_en_pd_vinf), 
                        .bisr_clk_pd_vinf(bisr_clk_pd_vinf), 
                        .bisr_reset_pd_vinf(bisr_reset_pd_vinf), 
                        .tcam_row_0_col_1_bisr_inst_SO(tcam_row_0_col_1_bisr_inst_SO), 
                        .tcam_row_0_col_2_bisr_inst_SO(tcam_row_0_col_2_bisr_inst_SO), 
                        .fscan_clkungate(fscan_clkungate)
                     );
        
              end

              
            else
              begin : gen_tcam_row_0_col_2_bcam
              end
              
        
        
        endgenerate
        
        always_ff @(posedge clk) begin
                   tcam_rd_data_col[0][2]      <= tcam_row_0_col_2_data_out;
                   tcam_col_hit_out[0][2]       <= tcam_row_0_col_2_hit_out;
        end
        

        // this is new template - tcam_asic_template
        
        wire                                            tcam_row_0_col_3_clk         = clk;
        
        wire    [TCAM_SLICE_EN_FACT-1:0]                tcam_row_0_col_3_slice_en = TCAM_SLICE_EN_FACT'(slice_en[(0 * TCAM_SLICE_EN_FACT)+:TCAM_SLICE_EN_MIN]);
        
        wire                                            tcam_row_0_col_3_rd_en       = tcam_row_rd_en[0];
        wire                                            tcam_row_0_col_3_wr_en       = tcam_row_wr_en[0];
        wire                                            tcam_row_0_col_3_chk_en      = chk_en;
        wire                                            tcam_row_0_col_3_reset_n = reset_n;
        wire    [8-1:0]                       tcam_row_0_col_3_adr  = tcam_row_adr[0][8-1:0];
        wire    [32-1:0]                      tcam_row_0_col_3_data_in = tcam_row_wr_en[0] ? tcam_wr_data_col[3][32-1:0] : tcam_chk_key_col[3][32-1:0];
        wire    [32-1:0]                      tcam_row_0_col_3_data_in_pre = tcam_wr_data_col[3][32-1:0] ;
        wire    [32-1:0]                      tcam_row_0_col_3_key_in =  tcam_chk_key_col[3][32-1:0];
        wire    [32-1:0]                      tcam_row_0_col_3_mask_in = tcam_chk_mask_col[3][32-1:0];
        wire    [128-1:0]                       tcam_row_0_col_3_hit_in = tcam_raw_hit_in[0];
        wire    [128-1:0]                       tcam_row_0_col_3_tcam_match_in = tcam_row_match_in[0];
        wire    [32-1:0]                      tcam_row_0_col_3_data_out_inv;
        logic   [128-1:0]                     tcam_row_0_col_3_hit_out_int;
        logic   [128-1:0]                     tcam_row_0_col_3_hit_out_latch;
        logic   [128-1:0]                     tcam_row_0_col_3_hit_out;
        
        `ifdef CXP_DFX_DISABLE
        wire                          tcam_row_0_col_3_biste = 'b0; 
        wire     [5-1:0]                  tcam_row_0_col_3_fca = 'b0;
        wire                            tcam_row_0_col_3_cre = 'b0;
        wire                            tcam_row_0_col_3_dftshiften = 'b0;
        wire                            tcam_row_0_col_3_dftmask = 'b0;
        wire                            tcam_row_0_col_3_dft_array_freeze = 'b0;
        wire                            tcam_row_0_col_3_dft_afd_reset_b = 'b0;
        wire      [32-1:0]    tcam_row_0_col_3_tdin = 'b0;
        wire      [8-1:0]     tcam_row_0_col_3_tadr = 'b0;
        wire                            tcam_row_0_col_3_tvbe = 'b0;
        wire                            tcam_row_0_col_3_tvbi = 'b0;
        wire      [32-1:0]    tcam_row_0_col_3_tmask = 'b0;
        wire                            tcam_row_0_col_3_twe = 'b0;
        wire                            tcam_row_0_col_3_tre = 'b0;
        wire                            tcam_row_0_col_3_tme = 'b0;
        wire                            tcam_row_0_col_3_bist_rotate_sr = 'b0;
        wire                            tcam_row_0_col_3_bist_en_sr_mask_b = 'b0;
        wire                            tcam_row_0_col_3_bist_all_mask = 'b0;
        wire                            tcam_row_0_col_3_bist_en_sr_data_b = 'b0;
        wire                            tcam_row_0_col_3_bist_cm_mode = 'b0;
        wire                            tcam_row_0_col_3_bist_cm_en_in = 'b0;
        wire                            tcam_row_0_col_3_bist_cm_match_sel0 = 'b0;
        wire                            tcam_row_0_col_3_bist_cm_match_sel1 = 'b0;
        wire                            tcam_row_0_col_3_bist_matchin_in = 'b0;
        wire                            tcam_row_0_col_3_bist_fls = 'b0;
        
        `else
        wire                            tcam_row_0_col_3_biste = 'b0;
        wire     [5-1:0]                  tcam_row_0_col_3_fca = 'b0;
        wire                            tcam_row_0_col_3_cre = 'b0;
        wire                            tcam_row_0_col_3_dftshiften = dftshiften;
        wire                            tcam_row_0_col_3_dftmask = dftmask;
        wire                            tcam_row_0_col_3_dft_array_freeze = dft_array_freeze;
        wire                            tcam_row_0_col_3_dft_afd_reset_b = dft_afd_reset_b;
        wire      [32-1:0]    tcam_row_0_col_3_tdin = 'b0;
        wire      [8-1:0]     tcam_row_0_col_3_tadr = 'b0;
        wire                            tcam_row_0_col_3_tvbe = 'b0;
        wire                            tcam_row_0_col_3_tvbi = 'b0;
        wire      [32-1:0]    tcam_row_0_col_3_tmask = 'b0;
        wire                            tcam_row_0_col_3_twe = 'b0;
        wire                            tcam_row_0_col_3_tre = 'b0;
        wire                            tcam_row_0_col_3_tme = 'b0;
        wire                            tcam_row_0_col_3_bist_rotate_sr = 'b0;
        wire                            tcam_row_0_col_3_bist_en_sr_mask_b = 'b0;
        wire                            tcam_row_0_col_3_bist_all_mask = 'b0;
        wire                            tcam_row_0_col_3_bist_en_sr_data_b = 'b0;
        wire                            tcam_row_0_col_3_bist_cm_mode = 'b0;
        wire                            tcam_row_0_col_3_bist_cm_en_in = 'b0;
        wire                            tcam_row_0_col_3_bist_cm_match_sel0 = 'b0;
        wire                            tcam_row_0_col_3_bist_cm_match_sel1 = 'b0;
        wire                            tcam_row_0_col_3_bist_matchin_in = 'b0;
        wire                            tcam_row_0_col_3_bist_fls = 'b0;
        `endif
        
        // Outputs
        logic                           tcam_row_0_col_3_wr_bira_fail;
        logic                           tcam_row_0_col_3_wr_so;
        logic                           tcam_row_0_col_3_curerrout;
        logic                           tcam_row_0_col_3_rscout;
        
        
        
        logic   [TCAM_SLICE_EN_FACT-1:0]                  tcam_row_0_col_3_slice_en_s0; 
        logic   [TCAM_SLICE_EN_FACT-1:0]                  tcam_row_0_col_3_slice_en_s1; 
        
        
        
             wire    [32-1:0]                     tcam_row_0_col_3_data_out ;
        
        
        
         generate
            if (BCAM_N7 == 0) 
              begin : gen_tcam_row_0_col_3_tcam
        
        
        // slice_en kept for TCAM only for backward compatability with Intel process
                always_comb 
                begin
                  for (int i = 0; i < TCAM_SLICE_EN_FACT; i++)
                      if (tcam_row_0_col_3_slice_en_s1[i])
                           tcam_row_0_col_3_hit_out[ i*64 +: 64]  = tcam_row_0_col_3_hit_out_int  [ i*64 +: 64]; 
                      else
                           tcam_row_0_col_3_hit_out[ i*64 +: 64]  = tcam_row_0_col_3_hit_out_latch[ i*64 +: 64]; 
                end
        
        
        
                always_ff  @(posedge tcam_row_0_col_3_clk)
                begin
                  tcam_row_0_col_3_slice_en_s0 <= tcam_row_0_col_3_slice_en; 
                  tcam_row_0_col_3_slice_en_s1 <= tcam_row_0_col_3_slice_en_s0; 
        
                  for (int i = 0; i < TCAM_SLICE_EN_FACT; i++)
                    begin
                      if (tcam_row_0_col_3_slice_en_s1[i])
                         tcam_row_0_col_3_hit_out_latch[ i*64 +: 64] <=  tcam_row_0_col_3_hit_out_int[ i*64 +: 64];
                    end
                end
        
        
        
        // NEW TCAM symbol 
        //                              _____________________________
        //                             |                             |
        //                         ----|ADRi                         |
        //                         ----|Di                           |
        //                         ----|RE                           |
        //                         ----|WE                           |
        //                         ----|ME                           |
        //                         ----|MASKi                        |
        //                         ----|DSEL                         |
        //                         ----|VBE                          |
        //                         ----|VBI                          |
        //                         ----|CMP                          |
        //                         ----|RVLDi                        |
        //                         ----|RST                          |
        //                         ----|FLS                          |
        //                         ----|CLK                          |
        //                         ----|FAF_EN                       |
        //                         ----|FAFi                         |
        //                             |                           Qi|---
        //                             |                         QVLD|---
        //                             |                         QHIT|---
        //                         ----|MDST_tcam                    |
        //                             |                         QHRi|---
        //                         ----|DFTSHIFTEN                   |
        //                         ----|DFTMASK                      |
        //                         ----|DFT_ARRAY_FREEZE             |
        //                         ----|DFT_AFD_RESET_B              |
        //                             |_____________________________|
        
                     
                         assign tcam_row_0_col_3_data_out  = ~tcam_row_0_col_3_data_out_inv;
                         wcm_ip783tcam128x32s0c1_0_3_wrap #(        
                                 )               
        
                                 ip783tcam128x32s0c1_wrap_tcam_row_0_col_3 (
                   //-------------------------------------------------------------
                   // Power Management Interfaces
                   //-------------------------------------------------------------   
                      `ifndef INTEL_NO_PWR_PINS
                      `ifdef INTC_ADD_VSS
                        .vss              (1'b0),
                      `endif
                        .vddp             (1'b1),
                      `endif
                         .ADR               (tcam_row_0_col_3_adr[8-1:1]), //Input adr_intess
                         .ME                (ce),  
        
                         .CLK               (tcam_row_0_col_3_clk), //Clock
                         .CMP               (tcam_row_0_col_3_chk_en), //Control Enable
                         .DIN               (~tcam_row_0_col_3_data_in), 
                         .DSEL              (~tcam_row_0_col_3_adr[0]), //dncen enables access of the TCAM Arrays adr_intessed
                         .FLS               (flush), //flush initiates a Flush operation that resets all Valid
                         .RVLD              (tcam_row_0_col_3_hit_in ), //Row validation bus. Each match_in input controls 1
                         .MASK              (tcam_row_0_col_3_mask_in), //Input msk
                         .QOUT              (tcam_row_0_col_3_data_out_inv), //Output vben
                         .QHR               (tcam_row_0_col_3_hit_out_int),
                         .QVLD              (), 
                         .RE                (tcam_row_0_col_3_rd_en), //Read Enable
                         .RST               (tcam_row_0_col_3_reset_n), //Asynchronous Active-High Reset
                         .VBE               (1'b1), //vben enables the Valid Bit addressed by adr[a-1:0] to
                         .VBI               (1'b0),//  Valid Bit Input
                         .WE                (tcam_row_0_col_3_wr_en), //Write Enable
                         .FAF               (tcam_row_0_col_3_fca),
                         .FAF_EN            (tcam_row_0_col_3_cre),
                         .DFTSHIFTEN        (tcam_row_0_col_3_dftshiften),
                         .DFTMASK           (tcam_row_0_col_3_dftmask),
                         .DFT_ARRAY_FREEZE  (tcam_row_0_col_3_dft_array_freeze),
                         .DFT_AFD_RESET_B   (tcam_row_0_col_3_dft_afd_reset_b),
                         .BISTE           (tcam_row_0_col_3_biste),
                         .TDIN (tcam_row_0_col_3_tdin),
                         .TADR (tcam_row_0_col_3_tadr),
                         .TVBE (tcam_row_0_col_3_tvbe),
                         .TVBI (tcam_row_0_col_3_tvbi),
                         .TMASK (tcam_row_0_col_3_tmask),
                         .TWE (tcam_row_0_col_3_twe),
                         .TRE (tcam_row_0_col_3_tre),
                         .TME (tcam_row_0_col_3_tme),
                         .BIST_ROTATE_SR (tcam_row_0_col_3_bist_rotate_sr),
                         .BIST_EN_SR_MASK_B (tcam_row_0_col_3_bist_en_sr_mask_b),
                         .BIST_ALL_MASK (tcam_row_0_col_3_bist_all_mask),
                         .BIST_EN_SR_DATA_B (tcam_row_0_col_3_bist_en_sr_data_b),
                         .BIST_CM_MODE (tcam_row_0_col_3_bist_cm_mode),
                         .BIST_CM_EN_IN (tcam_row_0_col_3_bist_cm_en_in),
                         .BIST_CM_MATCH_SEL0 (tcam_row_0_col_3_bist_cm_match_sel0),
                         .BIST_CM_MATCH_SEL1 (tcam_row_0_col_3_bist_cm_match_sel1),
                         .BIST_MATCHIN_IN (tcam_row_0_col_3_bist_matchin_in),
                         .BIST_FLS (tcam_row_0_col_3_bist_fls),
                         .MDST_tcam (fuse_tcam), .BIST_SETUP(BIST_SETUP), .BIST_SETUP_ts1(BIST_SETUP_ts1), 
                        .BIST_SETUP_ts2(BIST_SETUP_ts2), .to_interfaces_tck(to_interfaces_tck), 
                        .mcp_bounding_to_en(mcp_bounding_to_en), .scan_to_en(scan_to_en), 
                        .memory_bypass_to_en(memory_bypass_to_en), 
                        .GO_ID_REG_SEL(GO_ID_REG_SEL), .BIST_CLEAR_BIRA(BIST_CLEAR_BIRA), 
                        .BIST_COLLAR_DIAG_EN(BIST_COLLAR_DIAG_EN), 
                        .BIST_COLLAR_BIRA_EN(BIST_COLLAR_BIRA_EN), 
                        .BIST_SHIFT_BIRA_COLLAR(BIST_SHIFT_BIRA_COLLAR), 
                        .CHECK_REPAIR_NEEDED(CHECK_REPAIR_NEEDED), 
                        .MEM9_BIST_COLLAR_SI(MEM9_BIST_COLLAR_SI), .BIST_SO(BIST_SO_ts9), 
                        .BIST_GO(BIST_GO_ts9), .ltest_to_en(ltest_to_en), 
                        .BIST_USER9(BIST_USER9), .BIST_USER10(BIST_USER10), 
                        .BIST_USER11(BIST_USER11), .BIST_USER0(BIST_USER0), 
                        .BIST_USER1(BIST_USER1), .BIST_USER2(BIST_USER2), 
                        .BIST_USER3(BIST_USER3), .BIST_USER4(BIST_USER4), 
                        .BIST_USER5(BIST_USER5), .BIST_USER6(BIST_USER6), 
                        .BIST_USER7(BIST_USER7), .BIST_USER8(BIST_USER8), 
                        .BIST_EVEN_GROUPWRITEENABLE(BIST_EVEN_GROUPWRITEENABLE), 
                        .BIST_ODD_GROUPWRITEENABLE(BIST_ODD_GROUPWRITEENABLE), 
                        .BIST_WRITEENABLE(BIST_WRITEENABLE), .BIST_READENABLE(BIST_READENABLE), 
                        .BIST_SELECT(BIST_SELECT), .BIST_CMP(BIST_CMP), 
                        .INCLUDE_MEM_RESULTS_REG(INCLUDE_MEM_RESULTS_REG), 
                        .BIST_COL_ADD(BIST_COL_ADD), .BIST_ROW_ADD(BIST_ROW_ADD[5:0]), 
                        .BIST_COLLAR_EN9(BIST_COLLAR_EN9), 
                        .BIST_RUN_TO_COLLAR9(BIST_RUN_TO_COLLAR9), 
                        .BIST_ASYNC_RESET(BIST_ASYNC_RESET), 
                        .BIST_TESTDATA_SELECT_TO_COLLAR(BIST_TESTDATA_SELECT_TO_COLLAR), 
                        .BIST_ON_TO_COLLAR(BIST_ON_TO_COLLAR), 
                        .BIST_WRITE_DATA(BIST_WRITE_DATA[31:0]), 
                        .BIST_EXPECT_DATA(BIST_EXPECT_DATA[31:0]), 
                        .BIST_SHIFT_COLLAR(BIST_SHIFT_COLLAR), 
                        .BIST_COLLAR_SETUP(BIST_COLLAR_SETUP), 
                        .BIST_CLEAR_DEFAULT(BIST_CLEAR_DEFAULT), .BIST_CLEAR(BIST_CLEAR), 
                        .BIST_COLLAR_OPSET_SELECT(BIST_COLLAR_OPSET_SELECT[1:0]), 
                        .BIST_COLLAR_HOLD(BIST_COLLAR_HOLD), 
                        .FREEZE_STOP_ERROR(FREEZE_STOP_ERROR), 
                        .ERROR_CNT_ZERO(ERROR_CNT_ZERO), 
                        .MBISTPG_RESET_REG_SETUP2(MBISTPG_RESET_REG_SETUP2), 
                        .BIST_BANK_ADD(BIST_BANK_ADD), .bisr_shift_en_pd_vinf(bisr_shift_en_pd_vinf), 
                        .bisr_clk_pd_vinf(bisr_clk_pd_vinf), 
                        .bisr_reset_pd_vinf(bisr_reset_pd_vinf), 
                        .tcam_row_0_col_2_bisr_inst_SO(tcam_row_0_col_2_bisr_inst_SO), 
                        .tcam_row_0_col_3_bisr_inst_SO(tcam_row_0_col_3_bisr_inst_SO), 
                        .fscan_clkungate(fscan_clkungate)
                     );
        
              end

              
            else
              begin : gen_tcam_row_0_col_3_bcam
              end
              
        
        
        endgenerate
        
        always_ff @(posedge clk) begin
                   tcam_rd_data_col[0][3]      <= tcam_row_0_col_3_data_out;
                   tcam_col_hit_out[0][3]       <= tcam_row_0_col_3_hit_out;
        end
        

        // this is new template - tcam_asic_template
        
        wire                                            tcam_row_0_col_4_clk         = clk;
        
        wire    [TCAM_SLICE_EN_FACT-1:0]                tcam_row_0_col_4_slice_en = TCAM_SLICE_EN_FACT'(slice_en[(0 * TCAM_SLICE_EN_FACT)+:TCAM_SLICE_EN_MIN]);
        
        wire                                            tcam_row_0_col_4_rd_en       = tcam_row_rd_en[0];
        wire                                            tcam_row_0_col_4_wr_en       = tcam_row_wr_en[0];
        wire                                            tcam_row_0_col_4_chk_en      = chk_en;
        wire                                            tcam_row_0_col_4_reset_n = reset_n;
        wire    [8-1:0]                       tcam_row_0_col_4_adr  = tcam_row_adr[0][8-1:0];
        wire    [32-1:0]                      tcam_row_0_col_4_data_in = tcam_row_wr_en[0] ? tcam_wr_data_col[4][32-1:0] : tcam_chk_key_col[4][32-1:0];
        wire    [32-1:0]                      tcam_row_0_col_4_data_in_pre = tcam_wr_data_col[4][32-1:0] ;
        wire    [32-1:0]                      tcam_row_0_col_4_key_in =  tcam_chk_key_col[4][32-1:0];
        wire    [32-1:0]                      tcam_row_0_col_4_mask_in = tcam_chk_mask_col[4][32-1:0];
        wire    [128-1:0]                       tcam_row_0_col_4_hit_in = tcam_raw_hit_in[0];
        wire    [128-1:0]                       tcam_row_0_col_4_tcam_match_in = tcam_row_match_in[0];
        wire    [32-1:0]                      tcam_row_0_col_4_data_out_inv;
        logic   [128-1:0]                     tcam_row_0_col_4_hit_out_int;
        logic   [128-1:0]                     tcam_row_0_col_4_hit_out_latch;
        logic   [128-1:0]                     tcam_row_0_col_4_hit_out;
        
        `ifdef CXP_DFX_DISABLE
        wire                          tcam_row_0_col_4_biste = 'b0; 
        wire     [5-1:0]                  tcam_row_0_col_4_fca = 'b0;
        wire                            tcam_row_0_col_4_cre = 'b0;
        wire                            tcam_row_0_col_4_dftshiften = 'b0;
        wire                            tcam_row_0_col_4_dftmask = 'b0;
        wire                            tcam_row_0_col_4_dft_array_freeze = 'b0;
        wire                            tcam_row_0_col_4_dft_afd_reset_b = 'b0;
        wire      [32-1:0]    tcam_row_0_col_4_tdin = 'b0;
        wire      [8-1:0]     tcam_row_0_col_4_tadr = 'b0;
        wire                            tcam_row_0_col_4_tvbe = 'b0;
        wire                            tcam_row_0_col_4_tvbi = 'b0;
        wire      [32-1:0]    tcam_row_0_col_4_tmask = 'b0;
        wire                            tcam_row_0_col_4_twe = 'b0;
        wire                            tcam_row_0_col_4_tre = 'b0;
        wire                            tcam_row_0_col_4_tme = 'b0;
        wire                            tcam_row_0_col_4_bist_rotate_sr = 'b0;
        wire                            tcam_row_0_col_4_bist_en_sr_mask_b = 'b0;
        wire                            tcam_row_0_col_4_bist_all_mask = 'b0;
        wire                            tcam_row_0_col_4_bist_en_sr_data_b = 'b0;
        wire                            tcam_row_0_col_4_bist_cm_mode = 'b0;
        wire                            tcam_row_0_col_4_bist_cm_en_in = 'b0;
        wire                            tcam_row_0_col_4_bist_cm_match_sel0 = 'b0;
        wire                            tcam_row_0_col_4_bist_cm_match_sel1 = 'b0;
        wire                            tcam_row_0_col_4_bist_matchin_in = 'b0;
        wire                            tcam_row_0_col_4_bist_fls = 'b0;
        
        `else
        wire                            tcam_row_0_col_4_biste = 'b0;
        wire     [5-1:0]                  tcam_row_0_col_4_fca = 'b0;
        wire                            tcam_row_0_col_4_cre = 'b0;
        wire                            tcam_row_0_col_4_dftshiften = dftshiften;
        wire                            tcam_row_0_col_4_dftmask = dftmask;
        wire                            tcam_row_0_col_4_dft_array_freeze = dft_array_freeze;
        wire                            tcam_row_0_col_4_dft_afd_reset_b = dft_afd_reset_b;
        wire      [32-1:0]    tcam_row_0_col_4_tdin = 'b0;
        wire      [8-1:0]     tcam_row_0_col_4_tadr = 'b0;
        wire                            tcam_row_0_col_4_tvbe = 'b0;
        wire                            tcam_row_0_col_4_tvbi = 'b0;
        wire      [32-1:0]    tcam_row_0_col_4_tmask = 'b0;
        wire                            tcam_row_0_col_4_twe = 'b0;
        wire                            tcam_row_0_col_4_tre = 'b0;
        wire                            tcam_row_0_col_4_tme = 'b0;
        wire                            tcam_row_0_col_4_bist_rotate_sr = 'b0;
        wire                            tcam_row_0_col_4_bist_en_sr_mask_b = 'b0;
        wire                            tcam_row_0_col_4_bist_all_mask = 'b0;
        wire                            tcam_row_0_col_4_bist_en_sr_data_b = 'b0;
        wire                            tcam_row_0_col_4_bist_cm_mode = 'b0;
        wire                            tcam_row_0_col_4_bist_cm_en_in = 'b0;
        wire                            tcam_row_0_col_4_bist_cm_match_sel0 = 'b0;
        wire                            tcam_row_0_col_4_bist_cm_match_sel1 = 'b0;
        wire                            tcam_row_0_col_4_bist_matchin_in = 'b0;
        wire                            tcam_row_0_col_4_bist_fls = 'b0;
        `endif
        
        // Outputs
        logic                           tcam_row_0_col_4_wr_bira_fail;
        logic                           tcam_row_0_col_4_wr_so;
        logic                           tcam_row_0_col_4_curerrout;
        logic                           tcam_row_0_col_4_rscout;
        
        
        
        logic   [TCAM_SLICE_EN_FACT-1:0]                  tcam_row_0_col_4_slice_en_s0; 
        logic   [TCAM_SLICE_EN_FACT-1:0]                  tcam_row_0_col_4_slice_en_s1; 
        
        
        
             wire    [32-1:0]                     tcam_row_0_col_4_data_out ;
        
        
        
         generate
            if (BCAM_N7 == 0) 
              begin : gen_tcam_row_0_col_4_tcam
        
        
        // slice_en kept for TCAM only for backward compatability with Intel process
                always_comb 
                begin
                  for (int i = 0; i < TCAM_SLICE_EN_FACT; i++)
                      if (tcam_row_0_col_4_slice_en_s1[i])
                           tcam_row_0_col_4_hit_out[ i*64 +: 64]  = tcam_row_0_col_4_hit_out_int  [ i*64 +: 64]; 
                      else
                           tcam_row_0_col_4_hit_out[ i*64 +: 64]  = tcam_row_0_col_4_hit_out_latch[ i*64 +: 64]; 
                end
        
        
        
                always_ff  @(posedge tcam_row_0_col_4_clk)
                begin
                  tcam_row_0_col_4_slice_en_s0 <= tcam_row_0_col_4_slice_en; 
                  tcam_row_0_col_4_slice_en_s1 <= tcam_row_0_col_4_slice_en_s0; 
        
                  for (int i = 0; i < TCAM_SLICE_EN_FACT; i++)
                    begin
                      if (tcam_row_0_col_4_slice_en_s1[i])
                         tcam_row_0_col_4_hit_out_latch[ i*64 +: 64] <=  tcam_row_0_col_4_hit_out_int[ i*64 +: 64];
                    end
                end
        
        
        
        // NEW TCAM symbol 
        //                              _____________________________
        //                             |                             |
        //                         ----|ADRi                         |
        //                         ----|Di                           |
        //                         ----|RE                           |
        //                         ----|WE                           |
        //                         ----|ME                           |
        //                         ----|MASKi                        |
        //                         ----|DSEL                         |
        //                         ----|VBE                          |
        //                         ----|VBI                          |
        //                         ----|CMP                          |
        //                         ----|RVLDi                        |
        //                         ----|RST                          |
        //                         ----|FLS                          |
        //                         ----|CLK                          |
        //                         ----|FAF_EN                       |
        //                         ----|FAFi                         |
        //                             |                           Qi|---
        //                             |                         QVLD|---
        //                             |                         QHIT|---
        //                         ----|MDST_tcam                    |
        //                             |                         QHRi|---
        //                         ----|DFTSHIFTEN                   |
        //                         ----|DFTMASK                      |
        //                         ----|DFT_ARRAY_FREEZE             |
        //                         ----|DFT_AFD_RESET_B              |
        //                             |_____________________________|
        
                     
                         assign tcam_row_0_col_4_data_out  = ~tcam_row_0_col_4_data_out_inv;
                         wcm_ip783tcam128x32s0c1_0_4_wrap #(        
                                 )               
        
                                 ip783tcam128x32s0c1_wrap_tcam_row_0_col_4 (
                   //-------------------------------------------------------------
                   // Power Management Interfaces
                   //-------------------------------------------------------------   
                      `ifndef INTEL_NO_PWR_PINS
                      `ifdef INTC_ADD_VSS
                        .vss              (1'b0),
                      `endif
                        .vddp             (1'b1),
                      `endif
                         .ADR               (tcam_row_0_col_4_adr[8-1:1]), //Input adr_intess
                         .ME                (ce),  
        
                         .CLK               (tcam_row_0_col_4_clk), //Clock
                         .CMP               (tcam_row_0_col_4_chk_en), //Control Enable
                         .DIN               (~tcam_row_0_col_4_data_in), 
                         .DSEL              (~tcam_row_0_col_4_adr[0]), //dncen enables access of the TCAM Arrays adr_intessed
                         .FLS               (flush), //flush initiates a Flush operation that resets all Valid
                         .RVLD              (tcam_row_0_col_4_hit_in ), //Row validation bus. Each match_in input controls 1
                         .MASK              (tcam_row_0_col_4_mask_in), //Input msk
                         .QOUT              (tcam_row_0_col_4_data_out_inv), //Output vben
                         .QHR               (tcam_row_0_col_4_hit_out_int),
                         .QVLD              (), 
                         .RE                (tcam_row_0_col_4_rd_en), //Read Enable
                         .RST               (tcam_row_0_col_4_reset_n), //Asynchronous Active-High Reset
                         .VBE               (1'b1), //vben enables the Valid Bit addressed by adr[a-1:0] to
                         .VBI               (1'b0),//  Valid Bit Input
                         .WE                (tcam_row_0_col_4_wr_en), //Write Enable
                         .FAF               (tcam_row_0_col_4_fca),
                         .FAF_EN            (tcam_row_0_col_4_cre),
                         .DFTSHIFTEN        (tcam_row_0_col_4_dftshiften),
                         .DFTMASK           (tcam_row_0_col_4_dftmask),
                         .DFT_ARRAY_FREEZE  (tcam_row_0_col_4_dft_array_freeze),
                         .DFT_AFD_RESET_B   (tcam_row_0_col_4_dft_afd_reset_b),
                         .BISTE           (tcam_row_0_col_4_biste),
                         .TDIN (tcam_row_0_col_4_tdin),
                         .TADR (tcam_row_0_col_4_tadr),
                         .TVBE (tcam_row_0_col_4_tvbe),
                         .TVBI (tcam_row_0_col_4_tvbi),
                         .TMASK (tcam_row_0_col_4_tmask),
                         .TWE (tcam_row_0_col_4_twe),
                         .TRE (tcam_row_0_col_4_tre),
                         .TME (tcam_row_0_col_4_tme),
                         .BIST_ROTATE_SR (tcam_row_0_col_4_bist_rotate_sr),
                         .BIST_EN_SR_MASK_B (tcam_row_0_col_4_bist_en_sr_mask_b),
                         .BIST_ALL_MASK (tcam_row_0_col_4_bist_all_mask),
                         .BIST_EN_SR_DATA_B (tcam_row_0_col_4_bist_en_sr_data_b),
                         .BIST_CM_MODE (tcam_row_0_col_4_bist_cm_mode),
                         .BIST_CM_EN_IN (tcam_row_0_col_4_bist_cm_en_in),
                         .BIST_CM_MATCH_SEL0 (tcam_row_0_col_4_bist_cm_match_sel0),
                         .BIST_CM_MATCH_SEL1 (tcam_row_0_col_4_bist_cm_match_sel1),
                         .BIST_MATCHIN_IN (tcam_row_0_col_4_bist_matchin_in),
                         .BIST_FLS (tcam_row_0_col_4_bist_fls),
                         .MDST_tcam (fuse_tcam), .BIST_SETUP(BIST_SETUP), .BIST_SETUP_ts1(BIST_SETUP_ts1), 
                        .BIST_SETUP_ts2(BIST_SETUP_ts2), .to_interfaces_tck(to_interfaces_tck), 
                        .mcp_bounding_to_en(mcp_bounding_to_en), .scan_to_en(scan_to_en), 
                        .memory_bypass_to_en(memory_bypass_to_en), 
                        .GO_ID_REG_SEL(GO_ID_REG_SEL), .BIST_CLEAR_BIRA(BIST_CLEAR_BIRA), 
                        .BIST_COLLAR_DIAG_EN(BIST_COLLAR_DIAG_EN), 
                        .BIST_COLLAR_BIRA_EN(BIST_COLLAR_BIRA_EN), 
                        .BIST_SHIFT_BIRA_COLLAR(BIST_SHIFT_BIRA_COLLAR), 
                        .CHECK_REPAIR_NEEDED(CHECK_REPAIR_NEEDED), 
                        .MEM10_BIST_COLLAR_SI(MEM10_BIST_COLLAR_SI), .BIST_SO(BIST_SO_ts10), 
                        .BIST_GO(BIST_GO_ts10), .ltest_to_en(ltest_to_en), 
                        .BIST_USER9(BIST_USER9), .BIST_USER10(BIST_USER10), 
                        .BIST_USER11(BIST_USER11), .BIST_USER0(BIST_USER0), 
                        .BIST_USER1(BIST_USER1), .BIST_USER2(BIST_USER2), 
                        .BIST_USER3(BIST_USER3), .BIST_USER4(BIST_USER4), 
                        .BIST_USER5(BIST_USER5), .BIST_USER6(BIST_USER6), 
                        .BIST_USER7(BIST_USER7), .BIST_USER8(BIST_USER8), 
                        .BIST_EVEN_GROUPWRITEENABLE(BIST_EVEN_GROUPWRITEENABLE), 
                        .BIST_ODD_GROUPWRITEENABLE(BIST_ODD_GROUPWRITEENABLE), 
                        .BIST_WRITEENABLE(BIST_WRITEENABLE), .BIST_READENABLE(BIST_READENABLE), 
                        .BIST_SELECT(BIST_SELECT), .BIST_CMP(BIST_CMP), 
                        .INCLUDE_MEM_RESULTS_REG(INCLUDE_MEM_RESULTS_REG), 
                        .BIST_COL_ADD(BIST_COL_ADD), .BIST_ROW_ADD(BIST_ROW_ADD[5:0]), 
                        .BIST_COLLAR_EN10(BIST_COLLAR_EN10), 
                        .BIST_RUN_TO_COLLAR10(BIST_RUN_TO_COLLAR10), 
                        .BIST_ASYNC_RESET(BIST_ASYNC_RESET), 
                        .BIST_TESTDATA_SELECT_TO_COLLAR(BIST_TESTDATA_SELECT_TO_COLLAR), 
                        .BIST_ON_TO_COLLAR(BIST_ON_TO_COLLAR), 
                        .BIST_WRITE_DATA(BIST_WRITE_DATA[31:0]), 
                        .BIST_EXPECT_DATA(BIST_EXPECT_DATA[31:0]), 
                        .BIST_SHIFT_COLLAR(BIST_SHIFT_COLLAR), 
                        .BIST_COLLAR_SETUP(BIST_COLLAR_SETUP), 
                        .BIST_CLEAR_DEFAULT(BIST_CLEAR_DEFAULT), .BIST_CLEAR(BIST_CLEAR), 
                        .BIST_COLLAR_OPSET_SELECT(BIST_COLLAR_OPSET_SELECT[1:0]), 
                        .BIST_COLLAR_HOLD(BIST_COLLAR_HOLD), 
                        .FREEZE_STOP_ERROR(FREEZE_STOP_ERROR), 
                        .ERROR_CNT_ZERO(ERROR_CNT_ZERO), 
                        .MBISTPG_RESET_REG_SETUP2(MBISTPG_RESET_REG_SETUP2), 
                        .BIST_BANK_ADD(BIST_BANK_ADD), .bisr_shift_en_pd_vinf(bisr_shift_en_pd_vinf), 
                        .bisr_clk_pd_vinf(bisr_clk_pd_vinf), 
                        .bisr_reset_pd_vinf(bisr_reset_pd_vinf), 
                        .tcam_row_0_col_3_bisr_inst_SO(tcam_row_0_col_3_bisr_inst_SO), 
                        .tcam_row_0_col_4_bisr_inst_SO(tcam_row_0_col_4_bisr_inst_SO), 
                        .fscan_clkungate(fscan_clkungate)
                     );
        
              end

              
            else
              begin : gen_tcam_row_0_col_4_bcam
              end
              
        
        
        endgenerate
        
        always_ff @(posedge clk) begin
                   tcam_rd_data_col[0][4]      <= tcam_row_0_col_4_data_out;
                   tcam_col_hit_out[0][4]       <= tcam_row_0_col_4_hit_out;
        end
        

        // this is new template - tcam_asic_template
        
        wire                                            tcam_row_0_col_5_clk         = clk;
        
        wire    [TCAM_SLICE_EN_FACT-1:0]                tcam_row_0_col_5_slice_en = TCAM_SLICE_EN_FACT'(slice_en[(0 * TCAM_SLICE_EN_FACT)+:TCAM_SLICE_EN_MIN]);
        
        wire                                            tcam_row_0_col_5_rd_en       = tcam_row_rd_en[0];
        wire                                            tcam_row_0_col_5_wr_en       = tcam_row_wr_en[0];
        wire                                            tcam_row_0_col_5_chk_en      = chk_en;
        wire                                            tcam_row_0_col_5_reset_n = reset_n;
        wire    [8-1:0]                       tcam_row_0_col_5_adr  = tcam_row_adr[0][8-1:0];
        wire    [32-1:0]                      tcam_row_0_col_5_data_in = tcam_row_wr_en[0] ? tcam_wr_data_col[5][32-1:0] : tcam_chk_key_col[5][32-1:0];
        wire    [32-1:0]                      tcam_row_0_col_5_data_in_pre = tcam_wr_data_col[5][32-1:0] ;
        wire    [32-1:0]                      tcam_row_0_col_5_key_in =  tcam_chk_key_col[5][32-1:0];
        wire    [32-1:0]                      tcam_row_0_col_5_mask_in = tcam_chk_mask_col[5][32-1:0];
        wire    [128-1:0]                       tcam_row_0_col_5_hit_in = tcam_raw_hit_in[0];
        wire    [128-1:0]                       tcam_row_0_col_5_tcam_match_in = tcam_row_match_in[0];
        wire    [32-1:0]                      tcam_row_0_col_5_data_out_inv;
        logic   [128-1:0]                     tcam_row_0_col_5_hit_out_int;
        logic   [128-1:0]                     tcam_row_0_col_5_hit_out_latch;
        logic   [128-1:0]                     tcam_row_0_col_5_hit_out;
        
        `ifdef CXP_DFX_DISABLE
        wire                          tcam_row_0_col_5_biste = 'b0; 
        wire     [5-1:0]                  tcam_row_0_col_5_fca = 'b0;
        wire                            tcam_row_0_col_5_cre = 'b0;
        wire                            tcam_row_0_col_5_dftshiften = 'b0;
        wire                            tcam_row_0_col_5_dftmask = 'b0;
        wire                            tcam_row_0_col_5_dft_array_freeze = 'b0;
        wire                            tcam_row_0_col_5_dft_afd_reset_b = 'b0;
        wire      [32-1:0]    tcam_row_0_col_5_tdin = 'b0;
        wire      [8-1:0]     tcam_row_0_col_5_tadr = 'b0;
        wire                            tcam_row_0_col_5_tvbe = 'b0;
        wire                            tcam_row_0_col_5_tvbi = 'b0;
        wire      [32-1:0]    tcam_row_0_col_5_tmask = 'b0;
        wire                            tcam_row_0_col_5_twe = 'b0;
        wire                            tcam_row_0_col_5_tre = 'b0;
        wire                            tcam_row_0_col_5_tme = 'b0;
        wire                            tcam_row_0_col_5_bist_rotate_sr = 'b0;
        wire                            tcam_row_0_col_5_bist_en_sr_mask_b = 'b0;
        wire                            tcam_row_0_col_5_bist_all_mask = 'b0;
        wire                            tcam_row_0_col_5_bist_en_sr_data_b = 'b0;
        wire                            tcam_row_0_col_5_bist_cm_mode = 'b0;
        wire                            tcam_row_0_col_5_bist_cm_en_in = 'b0;
        wire                            tcam_row_0_col_5_bist_cm_match_sel0 = 'b0;
        wire                            tcam_row_0_col_5_bist_cm_match_sel1 = 'b0;
        wire                            tcam_row_0_col_5_bist_matchin_in = 'b0;
        wire                            tcam_row_0_col_5_bist_fls = 'b0;
        
        `else
        wire                            tcam_row_0_col_5_biste = 'b0;
        wire     [5-1:0]                  tcam_row_0_col_5_fca = 'b0;
        wire                            tcam_row_0_col_5_cre = 'b0;
        wire                            tcam_row_0_col_5_dftshiften = dftshiften;
        wire                            tcam_row_0_col_5_dftmask = dftmask;
        wire                            tcam_row_0_col_5_dft_array_freeze = dft_array_freeze;
        wire                            tcam_row_0_col_5_dft_afd_reset_b = dft_afd_reset_b;
        wire      [32-1:0]    tcam_row_0_col_5_tdin = 'b0;
        wire      [8-1:0]     tcam_row_0_col_5_tadr = 'b0;
        wire                            tcam_row_0_col_5_tvbe = 'b0;
        wire                            tcam_row_0_col_5_tvbi = 'b0;
        wire      [32-1:0]    tcam_row_0_col_5_tmask = 'b0;
        wire                            tcam_row_0_col_5_twe = 'b0;
        wire                            tcam_row_0_col_5_tre = 'b0;
        wire                            tcam_row_0_col_5_tme = 'b0;
        wire                            tcam_row_0_col_5_bist_rotate_sr = 'b0;
        wire                            tcam_row_0_col_5_bist_en_sr_mask_b = 'b0;
        wire                            tcam_row_0_col_5_bist_all_mask = 'b0;
        wire                            tcam_row_0_col_5_bist_en_sr_data_b = 'b0;
        wire                            tcam_row_0_col_5_bist_cm_mode = 'b0;
        wire                            tcam_row_0_col_5_bist_cm_en_in = 'b0;
        wire                            tcam_row_0_col_5_bist_cm_match_sel0 = 'b0;
        wire                            tcam_row_0_col_5_bist_cm_match_sel1 = 'b0;
        wire                            tcam_row_0_col_5_bist_matchin_in = 'b0;
        wire                            tcam_row_0_col_5_bist_fls = 'b0;
        `endif
        
        // Outputs
        logic                           tcam_row_0_col_5_wr_bira_fail;
        logic                           tcam_row_0_col_5_wr_so;
        logic                           tcam_row_0_col_5_curerrout;
        logic                           tcam_row_0_col_5_rscout;
        
        
        
        logic   [TCAM_SLICE_EN_FACT-1:0]                  tcam_row_0_col_5_slice_en_s0; 
        logic   [TCAM_SLICE_EN_FACT-1:0]                  tcam_row_0_col_5_slice_en_s1; 
        
        
        
             wire    [32-1:0]                     tcam_row_0_col_5_data_out ;
        
        
        
         generate
            if (BCAM_N7 == 0) 
              begin : gen_tcam_row_0_col_5_tcam
        
        
        // slice_en kept for TCAM only for backward compatability with Intel process
                always_comb 
                begin
                  for (int i = 0; i < TCAM_SLICE_EN_FACT; i++)
                      if (tcam_row_0_col_5_slice_en_s1[i])
                           tcam_row_0_col_5_hit_out[ i*64 +: 64]  = tcam_row_0_col_5_hit_out_int  [ i*64 +: 64]; 
                      else
                           tcam_row_0_col_5_hit_out[ i*64 +: 64]  = tcam_row_0_col_5_hit_out_latch[ i*64 +: 64]; 
                end
        
        
        
                always_ff  @(posedge tcam_row_0_col_5_clk)
                begin
                  tcam_row_0_col_5_slice_en_s0 <= tcam_row_0_col_5_slice_en; 
                  tcam_row_0_col_5_slice_en_s1 <= tcam_row_0_col_5_slice_en_s0; 
        
                  for (int i = 0; i < TCAM_SLICE_EN_FACT; i++)
                    begin
                      if (tcam_row_0_col_5_slice_en_s1[i])
                         tcam_row_0_col_5_hit_out_latch[ i*64 +: 64] <=  tcam_row_0_col_5_hit_out_int[ i*64 +: 64];
                    end
                end
        
        
        
        // NEW TCAM symbol 
        //                              _____________________________
        //                             |                             |
        //                         ----|ADRi                         |
        //                         ----|Di                           |
        //                         ----|RE                           |
        //                         ----|WE                           |
        //                         ----|ME                           |
        //                         ----|MASKi                        |
        //                         ----|DSEL                         |
        //                         ----|VBE                          |
        //                         ----|VBI                          |
        //                         ----|CMP                          |
        //                         ----|RVLDi                        |
        //                         ----|RST                          |
        //                         ----|FLS                          |
        //                         ----|CLK                          |
        //                         ----|FAF_EN                       |
        //                         ----|FAFi                         |
        //                             |                           Qi|---
        //                             |                         QVLD|---
        //                             |                         QHIT|---
        //                         ----|MDST_tcam                    |
        //                             |                         QHRi|---
        //                         ----|DFTSHIFTEN                   |
        //                         ----|DFTMASK                      |
        //                         ----|DFT_ARRAY_FREEZE             |
        //                         ----|DFT_AFD_RESET_B              |
        //                             |_____________________________|
        
                     
                         assign tcam_row_0_col_5_data_out  = ~tcam_row_0_col_5_data_out_inv;
                         wcm_ip783tcam128x32s0c1_0_5_wrap #(        
                                 )               
        
                                 ip783tcam128x32s0c1_wrap_tcam_row_0_col_5 (
                   //-------------------------------------------------------------
                   // Power Management Interfaces
                   //-------------------------------------------------------------   
                      `ifndef INTEL_NO_PWR_PINS
                      `ifdef INTC_ADD_VSS
                        .vss              (1'b0),
                      `endif
                        .vddp             (1'b1),
                      `endif
                         .ADR               (tcam_row_0_col_5_adr[8-1:1]), //Input adr_intess
                         .ME                (ce),  
        
                         .CLK               (tcam_row_0_col_5_clk), //Clock
                         .CMP               (tcam_row_0_col_5_chk_en), //Control Enable
                         .DIN               (~tcam_row_0_col_5_data_in), 
                         .DSEL              (~tcam_row_0_col_5_adr[0]), //dncen enables access of the TCAM Arrays adr_intessed
                         .FLS               (flush), //flush initiates a Flush operation that resets all Valid
                         .RVLD              (tcam_row_0_col_5_hit_in ), //Row validation bus. Each match_in input controls 1
                         .MASK              (tcam_row_0_col_5_mask_in), //Input msk
                         .QOUT              (tcam_row_0_col_5_data_out_inv), //Output vben
                         .QHR               (tcam_row_0_col_5_hit_out_int),
                         .QVLD              (), 
                         .RE                (tcam_row_0_col_5_rd_en), //Read Enable
                         .RST               (tcam_row_0_col_5_reset_n), //Asynchronous Active-High Reset
                         .VBE               (1'b1), //vben enables the Valid Bit addressed by adr[a-1:0] to
                         .VBI               (1'b0),//  Valid Bit Input
                         .WE                (tcam_row_0_col_5_wr_en), //Write Enable
                         .FAF               (tcam_row_0_col_5_fca),
                         .FAF_EN            (tcam_row_0_col_5_cre),
                         .DFTSHIFTEN        (tcam_row_0_col_5_dftshiften),
                         .DFTMASK           (tcam_row_0_col_5_dftmask),
                         .DFT_ARRAY_FREEZE  (tcam_row_0_col_5_dft_array_freeze),
                         .DFT_AFD_RESET_B   (tcam_row_0_col_5_dft_afd_reset_b),
                         .BISTE           (tcam_row_0_col_5_biste),
                         .TDIN (tcam_row_0_col_5_tdin),
                         .TADR (tcam_row_0_col_5_tadr),
                         .TVBE (tcam_row_0_col_5_tvbe),
                         .TVBI (tcam_row_0_col_5_tvbi),
                         .TMASK (tcam_row_0_col_5_tmask),
                         .TWE (tcam_row_0_col_5_twe),
                         .TRE (tcam_row_0_col_5_tre),
                         .TME (tcam_row_0_col_5_tme),
                         .BIST_ROTATE_SR (tcam_row_0_col_5_bist_rotate_sr),
                         .BIST_EN_SR_MASK_B (tcam_row_0_col_5_bist_en_sr_mask_b),
                         .BIST_ALL_MASK (tcam_row_0_col_5_bist_all_mask),
                         .BIST_EN_SR_DATA_B (tcam_row_0_col_5_bist_en_sr_data_b),
                         .BIST_CM_MODE (tcam_row_0_col_5_bist_cm_mode),
                         .BIST_CM_EN_IN (tcam_row_0_col_5_bist_cm_en_in),
                         .BIST_CM_MATCH_SEL0 (tcam_row_0_col_5_bist_cm_match_sel0),
                         .BIST_CM_MATCH_SEL1 (tcam_row_0_col_5_bist_cm_match_sel1),
                         .BIST_MATCHIN_IN (tcam_row_0_col_5_bist_matchin_in),
                         .BIST_FLS (tcam_row_0_col_5_bist_fls),
                         .MDST_tcam (fuse_tcam), .BIST_SETUP(BIST_SETUP), .BIST_SETUP_ts1(BIST_SETUP_ts1), 
                        .BIST_SETUP_ts2(BIST_SETUP_ts2), .to_interfaces_tck(to_interfaces_tck), 
                        .mcp_bounding_to_en(mcp_bounding_to_en), .scan_to_en(scan_to_en), 
                        .memory_bypass_to_en(memory_bypass_to_en), 
                        .GO_ID_REG_SEL(GO_ID_REG_SEL), .BIST_CLEAR_BIRA(BIST_CLEAR_BIRA), 
                        .BIST_COLLAR_DIAG_EN(BIST_COLLAR_DIAG_EN), 
                        .BIST_COLLAR_BIRA_EN(BIST_COLLAR_BIRA_EN), 
                        .BIST_SHIFT_BIRA_COLLAR(BIST_SHIFT_BIRA_COLLAR), 
                        .CHECK_REPAIR_NEEDED(CHECK_REPAIR_NEEDED), 
                        .MEM11_BIST_COLLAR_SI(MEM11_BIST_COLLAR_SI), .BIST_SO(BIST_SO_ts11), 
                        .BIST_GO(BIST_GO_ts11), .ltest_to_en(ltest_to_en), 
                        .BIST_USER9(BIST_USER9), .BIST_USER10(BIST_USER10), 
                        .BIST_USER11(BIST_USER11), .BIST_USER0(BIST_USER0), 
                        .BIST_USER1(BIST_USER1), .BIST_USER2(BIST_USER2), 
                        .BIST_USER3(BIST_USER3), .BIST_USER4(BIST_USER4), 
                        .BIST_USER5(BIST_USER5), .BIST_USER6(BIST_USER6), 
                        .BIST_USER7(BIST_USER7), .BIST_USER8(BIST_USER8), 
                        .BIST_EVEN_GROUPWRITEENABLE(BIST_EVEN_GROUPWRITEENABLE), 
                        .BIST_ODD_GROUPWRITEENABLE(BIST_ODD_GROUPWRITEENABLE), 
                        .BIST_WRITEENABLE(BIST_WRITEENABLE), .BIST_READENABLE(BIST_READENABLE), 
                        .BIST_SELECT(BIST_SELECT), .BIST_CMP(BIST_CMP), 
                        .INCLUDE_MEM_RESULTS_REG(INCLUDE_MEM_RESULTS_REG), 
                        .BIST_COL_ADD(BIST_COL_ADD), .BIST_ROW_ADD(BIST_ROW_ADD[5:0]), 
                        .BIST_COLLAR_EN11(BIST_COLLAR_EN11), 
                        .BIST_RUN_TO_COLLAR11(BIST_RUN_TO_COLLAR11), 
                        .BIST_ASYNC_RESET(BIST_ASYNC_RESET), 
                        .BIST_TESTDATA_SELECT_TO_COLLAR(BIST_TESTDATA_SELECT_TO_COLLAR), 
                        .BIST_ON_TO_COLLAR(BIST_ON_TO_COLLAR), 
                        .BIST_WRITE_DATA(BIST_WRITE_DATA[31:0]), 
                        .BIST_EXPECT_DATA(BIST_EXPECT_DATA[31:0]), 
                        .BIST_SHIFT_COLLAR(BIST_SHIFT_COLLAR), 
                        .BIST_COLLAR_SETUP(BIST_COLLAR_SETUP), 
                        .BIST_CLEAR_DEFAULT(BIST_CLEAR_DEFAULT), .BIST_CLEAR(BIST_CLEAR), 
                        .BIST_COLLAR_OPSET_SELECT(BIST_COLLAR_OPSET_SELECT[1:0]), 
                        .BIST_COLLAR_HOLD(BIST_COLLAR_HOLD), 
                        .FREEZE_STOP_ERROR(FREEZE_STOP_ERROR), 
                        .ERROR_CNT_ZERO(ERROR_CNT_ZERO), 
                        .MBISTPG_RESET_REG_SETUP2(MBISTPG_RESET_REG_SETUP2), 
                        .BIST_BANK_ADD(BIST_BANK_ADD), .bisr_shift_en_pd_vinf(bisr_shift_en_pd_vinf), 
                        .bisr_clk_pd_vinf(bisr_clk_pd_vinf), 
                        .bisr_reset_pd_vinf(bisr_reset_pd_vinf), 
                        .tcam_row_0_col_4_bisr_inst_SO(tcam_row_0_col_4_bisr_inst_SO), 
                        .tcam_row_0_col_5_bisr_inst_SO(tcam_row_0_col_5_bisr_inst_SO), 
                        .fscan_clkungate(fscan_clkungate)
                     );
        
              end

              
            else
              begin : gen_tcam_row_0_col_5_bcam
              end
              
        
        
        endgenerate
        
        always_ff @(posedge clk) begin
                   tcam_rd_data_col[0][5]      <= tcam_row_0_col_5_data_out;
                   tcam_col_hit_out[0][5]       <= tcam_row_0_col_5_hit_out;
        end
        

        // this is new template - tcam_asic_template
        
        wire                                            tcam_row_0_col_6_clk         = clk;
        
        wire    [TCAM_SLICE_EN_FACT-1:0]                tcam_row_0_col_6_slice_en = TCAM_SLICE_EN_FACT'(slice_en[(0 * TCAM_SLICE_EN_FACT)+:TCAM_SLICE_EN_MIN]);
        
        wire                                            tcam_row_0_col_6_rd_en       = tcam_row_rd_en[0];
        wire                                            tcam_row_0_col_6_wr_en       = tcam_row_wr_en[0];
        wire                                            tcam_row_0_col_6_chk_en      = chk_en;
        wire                                            tcam_row_0_col_6_reset_n = reset_n;
        wire    [8-1:0]                       tcam_row_0_col_6_adr  = tcam_row_adr[0][8-1:0];
        wire    [32-1:0]                      tcam_row_0_col_6_data_in = tcam_row_wr_en[0] ? tcam_wr_data_col[6][32-1:0] : tcam_chk_key_col[6][32-1:0];
        wire    [32-1:0]                      tcam_row_0_col_6_data_in_pre = tcam_wr_data_col[6][32-1:0] ;
        wire    [32-1:0]                      tcam_row_0_col_6_key_in =  tcam_chk_key_col[6][32-1:0];
        wire    [32-1:0]                      tcam_row_0_col_6_mask_in = tcam_chk_mask_col[6][32-1:0];
        wire    [128-1:0]                       tcam_row_0_col_6_hit_in = tcam_raw_hit_in[0];
        wire    [128-1:0]                       tcam_row_0_col_6_tcam_match_in = tcam_row_match_in[0];
        wire    [32-1:0]                      tcam_row_0_col_6_data_out_inv;
        logic   [128-1:0]                     tcam_row_0_col_6_hit_out_int;
        logic   [128-1:0]                     tcam_row_0_col_6_hit_out_latch;
        logic   [128-1:0]                     tcam_row_0_col_6_hit_out;
        
        `ifdef CXP_DFX_DISABLE
        wire                          tcam_row_0_col_6_biste = 'b0; 
        wire     [5-1:0]                  tcam_row_0_col_6_fca = 'b0;
        wire                            tcam_row_0_col_6_cre = 'b0;
        wire                            tcam_row_0_col_6_dftshiften = 'b0;
        wire                            tcam_row_0_col_6_dftmask = 'b0;
        wire                            tcam_row_0_col_6_dft_array_freeze = 'b0;
        wire                            tcam_row_0_col_6_dft_afd_reset_b = 'b0;
        wire      [32-1:0]    tcam_row_0_col_6_tdin = 'b0;
        wire      [8-1:0]     tcam_row_0_col_6_tadr = 'b0;
        wire                            tcam_row_0_col_6_tvbe = 'b0;
        wire                            tcam_row_0_col_6_tvbi = 'b0;
        wire      [32-1:0]    tcam_row_0_col_6_tmask = 'b0;
        wire                            tcam_row_0_col_6_twe = 'b0;
        wire                            tcam_row_0_col_6_tre = 'b0;
        wire                            tcam_row_0_col_6_tme = 'b0;
        wire                            tcam_row_0_col_6_bist_rotate_sr = 'b0;
        wire                            tcam_row_0_col_6_bist_en_sr_mask_b = 'b0;
        wire                            tcam_row_0_col_6_bist_all_mask = 'b0;
        wire                            tcam_row_0_col_6_bist_en_sr_data_b = 'b0;
        wire                            tcam_row_0_col_6_bist_cm_mode = 'b0;
        wire                            tcam_row_0_col_6_bist_cm_en_in = 'b0;
        wire                            tcam_row_0_col_6_bist_cm_match_sel0 = 'b0;
        wire                            tcam_row_0_col_6_bist_cm_match_sel1 = 'b0;
        wire                            tcam_row_0_col_6_bist_matchin_in = 'b0;
        wire                            tcam_row_0_col_6_bist_fls = 'b0;
        
        `else
        wire                            tcam_row_0_col_6_biste = 'b0;
        wire     [5-1:0]                  tcam_row_0_col_6_fca = 'b0;
        wire                            tcam_row_0_col_6_cre = 'b0;
        wire                            tcam_row_0_col_6_dftshiften = dftshiften;
        wire                            tcam_row_0_col_6_dftmask = dftmask;
        wire                            tcam_row_0_col_6_dft_array_freeze = dft_array_freeze;
        wire                            tcam_row_0_col_6_dft_afd_reset_b = dft_afd_reset_b;
        wire      [32-1:0]    tcam_row_0_col_6_tdin = 'b0;
        wire      [8-1:0]     tcam_row_0_col_6_tadr = 'b0;
        wire                            tcam_row_0_col_6_tvbe = 'b0;
        wire                            tcam_row_0_col_6_tvbi = 'b0;
        wire      [32-1:0]    tcam_row_0_col_6_tmask = 'b0;
        wire                            tcam_row_0_col_6_twe = 'b0;
        wire                            tcam_row_0_col_6_tre = 'b0;
        wire                            tcam_row_0_col_6_tme = 'b0;
        wire                            tcam_row_0_col_6_bist_rotate_sr = 'b0;
        wire                            tcam_row_0_col_6_bist_en_sr_mask_b = 'b0;
        wire                            tcam_row_0_col_6_bist_all_mask = 'b0;
        wire                            tcam_row_0_col_6_bist_en_sr_data_b = 'b0;
        wire                            tcam_row_0_col_6_bist_cm_mode = 'b0;
        wire                            tcam_row_0_col_6_bist_cm_en_in = 'b0;
        wire                            tcam_row_0_col_6_bist_cm_match_sel0 = 'b0;
        wire                            tcam_row_0_col_6_bist_cm_match_sel1 = 'b0;
        wire                            tcam_row_0_col_6_bist_matchin_in = 'b0;
        wire                            tcam_row_0_col_6_bist_fls = 'b0;
        `endif
        
        // Outputs
        logic                           tcam_row_0_col_6_wr_bira_fail;
        logic                           tcam_row_0_col_6_wr_so;
        logic                           tcam_row_0_col_6_curerrout;
        logic                           tcam_row_0_col_6_rscout;
        
        
        
        logic   [TCAM_SLICE_EN_FACT-1:0]                  tcam_row_0_col_6_slice_en_s0; 
        logic   [TCAM_SLICE_EN_FACT-1:0]                  tcam_row_0_col_6_slice_en_s1; 
        
        
        
             wire    [32-1:0]                     tcam_row_0_col_6_data_out ;
        
        
        
         generate
            if (BCAM_N7 == 0) 
              begin : gen_tcam_row_0_col_6_tcam
        
        
        // slice_en kept for TCAM only for backward compatability with Intel process
                always_comb 
                begin
                  for (int i = 0; i < TCAM_SLICE_EN_FACT; i++)
                      if (tcam_row_0_col_6_slice_en_s1[i])
                           tcam_row_0_col_6_hit_out[ i*64 +: 64]  = tcam_row_0_col_6_hit_out_int  [ i*64 +: 64]; 
                      else
                           tcam_row_0_col_6_hit_out[ i*64 +: 64]  = tcam_row_0_col_6_hit_out_latch[ i*64 +: 64]; 
                end
        
        
        
                always_ff  @(posedge tcam_row_0_col_6_clk)
                begin
                  tcam_row_0_col_6_slice_en_s0 <= tcam_row_0_col_6_slice_en; 
                  tcam_row_0_col_6_slice_en_s1 <= tcam_row_0_col_6_slice_en_s0; 
        
                  for (int i = 0; i < TCAM_SLICE_EN_FACT; i++)
                    begin
                      if (tcam_row_0_col_6_slice_en_s1[i])
                         tcam_row_0_col_6_hit_out_latch[ i*64 +: 64] <=  tcam_row_0_col_6_hit_out_int[ i*64 +: 64];
                    end
                end
        
        
        
        // NEW TCAM symbol 
        //                              _____________________________
        //                             |                             |
        //                         ----|ADRi                         |
        //                         ----|Di                           |
        //                         ----|RE                           |
        //                         ----|WE                           |
        //                         ----|ME                           |
        //                         ----|MASKi                        |
        //                         ----|DSEL                         |
        //                         ----|VBE                          |
        //                         ----|VBI                          |
        //                         ----|CMP                          |
        //                         ----|RVLDi                        |
        //                         ----|RST                          |
        //                         ----|FLS                          |
        //                         ----|CLK                          |
        //                         ----|FAF_EN                       |
        //                         ----|FAFi                         |
        //                             |                           Qi|---
        //                             |                         QVLD|---
        //                             |                         QHIT|---
        //                         ----|MDST_tcam                    |
        //                             |                         QHRi|---
        //                         ----|DFTSHIFTEN                   |
        //                         ----|DFTMASK                      |
        //                         ----|DFT_ARRAY_FREEZE             |
        //                         ----|DFT_AFD_RESET_B              |
        //                             |_____________________________|
        
                     
                         assign tcam_row_0_col_6_data_out  = ~tcam_row_0_col_6_data_out_inv;
                         wcm_ip783tcam128x32s0c1_0_6_wrap #(        
                                 )               
        
                                 ip783tcam128x32s0c1_wrap_tcam_row_0_col_6 (
                   //-------------------------------------------------------------
                   // Power Management Interfaces
                   //-------------------------------------------------------------   
                      `ifndef INTEL_NO_PWR_PINS
                      `ifdef INTC_ADD_VSS
                        .vss              (1'b0),
                      `endif
                        .vddp             (1'b1),
                      `endif
                         .ADR               (tcam_row_0_col_6_adr[8-1:1]), //Input adr_intess
                         .ME                (ce),  
        
                         .CLK               (tcam_row_0_col_6_clk), //Clock
                         .CMP               (tcam_row_0_col_6_chk_en), //Control Enable
                         .DIN               (~tcam_row_0_col_6_data_in), 
                         .DSEL              (~tcam_row_0_col_6_adr[0]), //dncen enables access of the TCAM Arrays adr_intessed
                         .FLS               (flush), //flush initiates a Flush operation that resets all Valid
                         .RVLD              (tcam_row_0_col_6_hit_in ), //Row validation bus. Each match_in input controls 1
                         .MASK              (tcam_row_0_col_6_mask_in), //Input msk
                         .QOUT              (tcam_row_0_col_6_data_out_inv), //Output vben
                         .QHR               (tcam_row_0_col_6_hit_out_int),
                         .QVLD              (), 
                         .RE                (tcam_row_0_col_6_rd_en), //Read Enable
                         .RST               (tcam_row_0_col_6_reset_n), //Asynchronous Active-High Reset
                         .VBE               (1'b1), //vben enables the Valid Bit addressed by adr[a-1:0] to
                         .VBI               (1'b0),//  Valid Bit Input
                         .WE                (tcam_row_0_col_6_wr_en), //Write Enable
                         .FAF               (tcam_row_0_col_6_fca),
                         .FAF_EN            (tcam_row_0_col_6_cre),
                         .DFTSHIFTEN        (tcam_row_0_col_6_dftshiften),
                         .DFTMASK           (tcam_row_0_col_6_dftmask),
                         .DFT_ARRAY_FREEZE  (tcam_row_0_col_6_dft_array_freeze),
                         .DFT_AFD_RESET_B   (tcam_row_0_col_6_dft_afd_reset_b),
                         .BISTE           (tcam_row_0_col_6_biste),
                         .TDIN (tcam_row_0_col_6_tdin),
                         .TADR (tcam_row_0_col_6_tadr),
                         .TVBE (tcam_row_0_col_6_tvbe),
                         .TVBI (tcam_row_0_col_6_tvbi),
                         .TMASK (tcam_row_0_col_6_tmask),
                         .TWE (tcam_row_0_col_6_twe),
                         .TRE (tcam_row_0_col_6_tre),
                         .TME (tcam_row_0_col_6_tme),
                         .BIST_ROTATE_SR (tcam_row_0_col_6_bist_rotate_sr),
                         .BIST_EN_SR_MASK_B (tcam_row_0_col_6_bist_en_sr_mask_b),
                         .BIST_ALL_MASK (tcam_row_0_col_6_bist_all_mask),
                         .BIST_EN_SR_DATA_B (tcam_row_0_col_6_bist_en_sr_data_b),
                         .BIST_CM_MODE (tcam_row_0_col_6_bist_cm_mode),
                         .BIST_CM_EN_IN (tcam_row_0_col_6_bist_cm_en_in),
                         .BIST_CM_MATCH_SEL0 (tcam_row_0_col_6_bist_cm_match_sel0),
                         .BIST_CM_MATCH_SEL1 (tcam_row_0_col_6_bist_cm_match_sel1),
                         .BIST_MATCHIN_IN (tcam_row_0_col_6_bist_matchin_in),
                         .BIST_FLS (tcam_row_0_col_6_bist_fls),
                         .MDST_tcam (fuse_tcam), .BIST_SETUP(BIST_SETUP), .BIST_SETUP_ts1(BIST_SETUP_ts1), 
                        .BIST_SETUP_ts2(BIST_SETUP_ts2), .to_interfaces_tck(to_interfaces_tck), 
                        .mcp_bounding_to_en(mcp_bounding_to_en), .scan_to_en(scan_to_en), 
                        .memory_bypass_to_en(memory_bypass_to_en), 
                        .GO_ID_REG_SEL(GO_ID_REG_SEL), .BIST_CLEAR_BIRA(BIST_CLEAR_BIRA), 
                        .BIST_COLLAR_DIAG_EN(BIST_COLLAR_DIAG_EN), 
                        .BIST_COLLAR_BIRA_EN(BIST_COLLAR_BIRA_EN), 
                        .BIST_SHIFT_BIRA_COLLAR(BIST_SHIFT_BIRA_COLLAR), 
                        .CHECK_REPAIR_NEEDED(CHECK_REPAIR_NEEDED), 
                        .MEM12_BIST_COLLAR_SI(MEM12_BIST_COLLAR_SI), .BIST_SO(BIST_SO_ts12), 
                        .BIST_GO(BIST_GO_ts12), .ltest_to_en(ltest_to_en), 
                        .BIST_USER9(BIST_USER9), .BIST_USER10(BIST_USER10), 
                        .BIST_USER11(BIST_USER11), .BIST_USER0(BIST_USER0), 
                        .BIST_USER1(BIST_USER1), .BIST_USER2(BIST_USER2), 
                        .BIST_USER3(BIST_USER3), .BIST_USER4(BIST_USER4), 
                        .BIST_USER5(BIST_USER5), .BIST_USER6(BIST_USER6), 
                        .BIST_USER7(BIST_USER7), .BIST_USER8(BIST_USER8), 
                        .BIST_EVEN_GROUPWRITEENABLE(BIST_EVEN_GROUPWRITEENABLE), 
                        .BIST_ODD_GROUPWRITEENABLE(BIST_ODD_GROUPWRITEENABLE), 
                        .BIST_WRITEENABLE(BIST_WRITEENABLE), .BIST_READENABLE(BIST_READENABLE), 
                        .BIST_SELECT(BIST_SELECT), .BIST_CMP(BIST_CMP), 
                        .INCLUDE_MEM_RESULTS_REG(INCLUDE_MEM_RESULTS_REG), 
                        .BIST_COL_ADD(BIST_COL_ADD), .BIST_ROW_ADD(BIST_ROW_ADD[5:0]), 
                        .BIST_COLLAR_EN12(BIST_COLLAR_EN12), 
                        .BIST_RUN_TO_COLLAR12(BIST_RUN_TO_COLLAR12), 
                        .BIST_ASYNC_RESET(BIST_ASYNC_RESET), 
                        .BIST_TESTDATA_SELECT_TO_COLLAR(BIST_TESTDATA_SELECT_TO_COLLAR), 
                        .BIST_ON_TO_COLLAR(BIST_ON_TO_COLLAR), 
                        .BIST_WRITE_DATA(BIST_WRITE_DATA[31:0]), 
                        .BIST_EXPECT_DATA(BIST_EXPECT_DATA[31:0]), 
                        .BIST_SHIFT_COLLAR(BIST_SHIFT_COLLAR), 
                        .BIST_COLLAR_SETUP(BIST_COLLAR_SETUP), 
                        .BIST_CLEAR_DEFAULT(BIST_CLEAR_DEFAULT), .BIST_CLEAR(BIST_CLEAR), 
                        .BIST_COLLAR_OPSET_SELECT(BIST_COLLAR_OPSET_SELECT[1:0]), 
                        .BIST_COLLAR_HOLD(BIST_COLLAR_HOLD), 
                        .FREEZE_STOP_ERROR(FREEZE_STOP_ERROR), 
                        .ERROR_CNT_ZERO(ERROR_CNT_ZERO), 
                        .MBISTPG_RESET_REG_SETUP2(MBISTPG_RESET_REG_SETUP2), 
                        .BIST_BANK_ADD(BIST_BANK_ADD), .bisr_shift_en_pd_vinf(bisr_shift_en_pd_vinf), 
                        .bisr_clk_pd_vinf(bisr_clk_pd_vinf), 
                        .bisr_reset_pd_vinf(bisr_reset_pd_vinf), 
                        .tcam_row_0_col_5_bisr_inst_SO(tcam_row_0_col_5_bisr_inst_SO), 
                        .tcam_row_0_col_6_bisr_inst_SO(tcam_row_0_col_6_bisr_inst_SO), 
                        .fscan_clkungate(fscan_clkungate)
                     );
        
              end

              
            else
              begin : gen_tcam_row_0_col_6_bcam
              end
              
        
        
        endgenerate
        
        always_ff @(posedge clk) begin
                   tcam_rd_data_col[0][6]      <= tcam_row_0_col_6_data_out;
                   tcam_col_hit_out[0][6]       <= tcam_row_0_col_6_hit_out;
        end
        

        // this is new template - tcam_asic_template
        
        wire                                            tcam_row_0_col_7_clk         = clk;
        
        wire    [TCAM_SLICE_EN_FACT-1:0]                tcam_row_0_col_7_slice_en = TCAM_SLICE_EN_FACT'(slice_en[(0 * TCAM_SLICE_EN_FACT)+:TCAM_SLICE_EN_MIN]);
        
        wire                                            tcam_row_0_col_7_rd_en       = tcam_row_rd_en[0];
        wire                                            tcam_row_0_col_7_wr_en       = tcam_row_wr_en[0];
        wire                                            tcam_row_0_col_7_chk_en      = chk_en;
        wire                                            tcam_row_0_col_7_reset_n = reset_n;
        wire    [8-1:0]                       tcam_row_0_col_7_adr  = tcam_row_adr[0][8-1:0];
        wire    [32-1:0]                      tcam_row_0_col_7_data_in = tcam_row_wr_en[0] ? tcam_wr_data_col[7][32-1:0] : tcam_chk_key_col[7][32-1:0];
        wire    [32-1:0]                      tcam_row_0_col_7_data_in_pre = tcam_wr_data_col[7][32-1:0] ;
        wire    [32-1:0]                      tcam_row_0_col_7_key_in =  tcam_chk_key_col[7][32-1:0];
        wire    [32-1:0]                      tcam_row_0_col_7_mask_in = tcam_chk_mask_col[7][32-1:0];
        wire    [128-1:0]                       tcam_row_0_col_7_hit_in = tcam_raw_hit_in[0];
        wire    [128-1:0]                       tcam_row_0_col_7_tcam_match_in = tcam_row_match_in[0];
        wire    [32-1:0]                      tcam_row_0_col_7_data_out_inv;
        logic   [128-1:0]                     tcam_row_0_col_7_hit_out_int;
        logic   [128-1:0]                     tcam_row_0_col_7_hit_out_latch;
        logic   [128-1:0]                     tcam_row_0_col_7_hit_out;
        
        `ifdef CXP_DFX_DISABLE
        wire                          tcam_row_0_col_7_biste = 'b0; 
        wire     [5-1:0]                  tcam_row_0_col_7_fca = 'b0;
        wire                            tcam_row_0_col_7_cre = 'b0;
        wire                            tcam_row_0_col_7_dftshiften = 'b0;
        wire                            tcam_row_0_col_7_dftmask = 'b0;
        wire                            tcam_row_0_col_7_dft_array_freeze = 'b0;
        wire                            tcam_row_0_col_7_dft_afd_reset_b = 'b0;
        wire      [32-1:0]    tcam_row_0_col_7_tdin = 'b0;
        wire      [8-1:0]     tcam_row_0_col_7_tadr = 'b0;
        wire                            tcam_row_0_col_7_tvbe = 'b0;
        wire                            tcam_row_0_col_7_tvbi = 'b0;
        wire      [32-1:0]    tcam_row_0_col_7_tmask = 'b0;
        wire                            tcam_row_0_col_7_twe = 'b0;
        wire                            tcam_row_0_col_7_tre = 'b0;
        wire                            tcam_row_0_col_7_tme = 'b0;
        wire                            tcam_row_0_col_7_bist_rotate_sr = 'b0;
        wire                            tcam_row_0_col_7_bist_en_sr_mask_b = 'b0;
        wire                            tcam_row_0_col_7_bist_all_mask = 'b0;
        wire                            tcam_row_0_col_7_bist_en_sr_data_b = 'b0;
        wire                            tcam_row_0_col_7_bist_cm_mode = 'b0;
        wire                            tcam_row_0_col_7_bist_cm_en_in = 'b0;
        wire                            tcam_row_0_col_7_bist_cm_match_sel0 = 'b0;
        wire                            tcam_row_0_col_7_bist_cm_match_sel1 = 'b0;
        wire                            tcam_row_0_col_7_bist_matchin_in = 'b0;
        wire                            tcam_row_0_col_7_bist_fls = 'b0;
        
        `else
        wire                            tcam_row_0_col_7_biste = 'b0;
        wire     [5-1:0]                  tcam_row_0_col_7_fca = 'b0;
        wire                            tcam_row_0_col_7_cre = 'b0;
        wire                            tcam_row_0_col_7_dftshiften = dftshiften;
        wire                            tcam_row_0_col_7_dftmask = dftmask;
        wire                            tcam_row_0_col_7_dft_array_freeze = dft_array_freeze;
        wire                            tcam_row_0_col_7_dft_afd_reset_b = dft_afd_reset_b;
        wire      [32-1:0]    tcam_row_0_col_7_tdin = 'b0;
        wire      [8-1:0]     tcam_row_0_col_7_tadr = 'b0;
        wire                            tcam_row_0_col_7_tvbe = 'b0;
        wire                            tcam_row_0_col_7_tvbi = 'b0;
        wire      [32-1:0]    tcam_row_0_col_7_tmask = 'b0;
        wire                            tcam_row_0_col_7_twe = 'b0;
        wire                            tcam_row_0_col_7_tre = 'b0;
        wire                            tcam_row_0_col_7_tme = 'b0;
        wire                            tcam_row_0_col_7_bist_rotate_sr = 'b0;
        wire                            tcam_row_0_col_7_bist_en_sr_mask_b = 'b0;
        wire                            tcam_row_0_col_7_bist_all_mask = 'b0;
        wire                            tcam_row_0_col_7_bist_en_sr_data_b = 'b0;
        wire                            tcam_row_0_col_7_bist_cm_mode = 'b0;
        wire                            tcam_row_0_col_7_bist_cm_en_in = 'b0;
        wire                            tcam_row_0_col_7_bist_cm_match_sel0 = 'b0;
        wire                            tcam_row_0_col_7_bist_cm_match_sel1 = 'b0;
        wire                            tcam_row_0_col_7_bist_matchin_in = 'b0;
        wire                            tcam_row_0_col_7_bist_fls = 'b0;
        `endif
        
        // Outputs
        logic                           tcam_row_0_col_7_wr_bira_fail;
        logic                           tcam_row_0_col_7_wr_so;
        logic                           tcam_row_0_col_7_curerrout;
        logic                           tcam_row_0_col_7_rscout;
        
        
        
        logic   [TCAM_SLICE_EN_FACT-1:0]                  tcam_row_0_col_7_slice_en_s0; 
        logic   [TCAM_SLICE_EN_FACT-1:0]                  tcam_row_0_col_7_slice_en_s1; 
        
        
        
             wire    [32-1:0]                     tcam_row_0_col_7_data_out ;
        
        
        
         generate
            if (BCAM_N7 == 0) 
              begin : gen_tcam_row_0_col_7_tcam
        
        
        // slice_en kept for TCAM only for backward compatability with Intel process
                always_comb 
                begin
                  for (int i = 0; i < TCAM_SLICE_EN_FACT; i++)
                      if (tcam_row_0_col_7_slice_en_s1[i])
                           tcam_row_0_col_7_hit_out[ i*64 +: 64]  = tcam_row_0_col_7_hit_out_int  [ i*64 +: 64]; 
                      else
                           tcam_row_0_col_7_hit_out[ i*64 +: 64]  = tcam_row_0_col_7_hit_out_latch[ i*64 +: 64]; 
                end
        
        
        
                always_ff  @(posedge tcam_row_0_col_7_clk)
                begin
                  tcam_row_0_col_7_slice_en_s0 <= tcam_row_0_col_7_slice_en; 
                  tcam_row_0_col_7_slice_en_s1 <= tcam_row_0_col_7_slice_en_s0; 
        
                  for (int i = 0; i < TCAM_SLICE_EN_FACT; i++)
                    begin
                      if (tcam_row_0_col_7_slice_en_s1[i])
                         tcam_row_0_col_7_hit_out_latch[ i*64 +: 64] <=  tcam_row_0_col_7_hit_out_int[ i*64 +: 64];
                    end
                end
        
        
        
        // NEW TCAM symbol 
        //                              _____________________________
        //                             |                             |
        //                         ----|ADRi                         |
        //                         ----|Di                           |
        //                         ----|RE                           |
        //                         ----|WE                           |
        //                         ----|ME                           |
        //                         ----|MASKi                        |
        //                         ----|DSEL                         |
        //                         ----|VBE                          |
        //                         ----|VBI                          |
        //                         ----|CMP                          |
        //                         ----|RVLDi                        |
        //                         ----|RST                          |
        //                         ----|FLS                          |
        //                         ----|CLK                          |
        //                         ----|FAF_EN                       |
        //                         ----|FAFi                         |
        //                             |                           Qi|---
        //                             |                         QVLD|---
        //                             |                         QHIT|---
        //                         ----|MDST_tcam                    |
        //                             |                         QHRi|---
        //                         ----|DFTSHIFTEN                   |
        //                         ----|DFTMASK                      |
        //                         ----|DFT_ARRAY_FREEZE             |
        //                         ----|DFT_AFD_RESET_B              |
        //                             |_____________________________|
        
                     
                         assign tcam_row_0_col_7_data_out  = ~tcam_row_0_col_7_data_out_inv;
                         wcm_ip783tcam128x32s0c1_0_7_wrap #(        
                                 )               
        
                                 ip783tcam128x32s0c1_wrap_tcam_row_0_col_7 (
                   //-------------------------------------------------------------
                   // Power Management Interfaces
                   //-------------------------------------------------------------   
                      `ifndef INTEL_NO_PWR_PINS
                      `ifdef INTC_ADD_VSS
                        .vss              (1'b0),
                      `endif
                        .vddp             (1'b1),
                      `endif
                         .ADR               (tcam_row_0_col_7_adr[8-1:1]), //Input adr_intess
                         .ME                (ce),  
        
                         .CLK               (tcam_row_0_col_7_clk), //Clock
                         .CMP               (tcam_row_0_col_7_chk_en), //Control Enable
                         .DIN               (~tcam_row_0_col_7_data_in), 
                         .DSEL              (~tcam_row_0_col_7_adr[0]), //dncen enables access of the TCAM Arrays adr_intessed
                         .FLS               (flush), //flush initiates a Flush operation that resets all Valid
                         .RVLD              (tcam_row_0_col_7_hit_in ), //Row validation bus. Each match_in input controls 1
                         .MASK              (tcam_row_0_col_7_mask_in), //Input msk
                         .QOUT              (tcam_row_0_col_7_data_out_inv), //Output vben
                         .QHR               (tcam_row_0_col_7_hit_out_int),
                         .QVLD              (), 
                         .RE                (tcam_row_0_col_7_rd_en), //Read Enable
                         .RST               (tcam_row_0_col_7_reset_n), //Asynchronous Active-High Reset
                         .VBE               (1'b1), //vben enables the Valid Bit addressed by adr[a-1:0] to
                         .VBI               (1'b0),//  Valid Bit Input
                         .WE                (tcam_row_0_col_7_wr_en), //Write Enable
                         .FAF               (tcam_row_0_col_7_fca),
                         .FAF_EN            (tcam_row_0_col_7_cre),
                         .DFTSHIFTEN        (tcam_row_0_col_7_dftshiften),
                         .DFTMASK           (tcam_row_0_col_7_dftmask),
                         .DFT_ARRAY_FREEZE  (tcam_row_0_col_7_dft_array_freeze),
                         .DFT_AFD_RESET_B   (tcam_row_0_col_7_dft_afd_reset_b),
                         .BISTE           (tcam_row_0_col_7_biste),
                         .TDIN (tcam_row_0_col_7_tdin),
                         .TADR (tcam_row_0_col_7_tadr),
                         .TVBE (tcam_row_0_col_7_tvbe),
                         .TVBI (tcam_row_0_col_7_tvbi),
                         .TMASK (tcam_row_0_col_7_tmask),
                         .TWE (tcam_row_0_col_7_twe),
                         .TRE (tcam_row_0_col_7_tre),
                         .TME (tcam_row_0_col_7_tme),
                         .BIST_ROTATE_SR (tcam_row_0_col_7_bist_rotate_sr),
                         .BIST_EN_SR_MASK_B (tcam_row_0_col_7_bist_en_sr_mask_b),
                         .BIST_ALL_MASK (tcam_row_0_col_7_bist_all_mask),
                         .BIST_EN_SR_DATA_B (tcam_row_0_col_7_bist_en_sr_data_b),
                         .BIST_CM_MODE (tcam_row_0_col_7_bist_cm_mode),
                         .BIST_CM_EN_IN (tcam_row_0_col_7_bist_cm_en_in),
                         .BIST_CM_MATCH_SEL0 (tcam_row_0_col_7_bist_cm_match_sel0),
                         .BIST_CM_MATCH_SEL1 (tcam_row_0_col_7_bist_cm_match_sel1),
                         .BIST_MATCHIN_IN (tcam_row_0_col_7_bist_matchin_in),
                         .BIST_FLS (tcam_row_0_col_7_bist_fls),
                         .MDST_tcam (fuse_tcam), .BIST_SETUP(BIST_SETUP), .BIST_SETUP_ts1(BIST_SETUP_ts1), 
                        .BIST_SETUP_ts2(BIST_SETUP_ts2), .to_interfaces_tck(to_interfaces_tck), 
                        .mcp_bounding_to_en(mcp_bounding_to_en), .scan_to_en(scan_to_en), 
                        .memory_bypass_to_en(memory_bypass_to_en), 
                        .GO_ID_REG_SEL(GO_ID_REG_SEL), .BIST_CLEAR_BIRA(BIST_CLEAR_BIRA), 
                        .BIST_COLLAR_DIAG_EN(BIST_COLLAR_DIAG_EN), 
                        .BIST_COLLAR_BIRA_EN(BIST_COLLAR_BIRA_EN), 
                        .BIST_SHIFT_BIRA_COLLAR(BIST_SHIFT_BIRA_COLLAR), 
                        .CHECK_REPAIR_NEEDED(CHECK_REPAIR_NEEDED), 
                        .MEM13_BIST_COLLAR_SI(MEM13_BIST_COLLAR_SI), .BIST_SO(BIST_SO_ts13), 
                        .BIST_GO(BIST_GO_ts13), .ltest_to_en(ltest_to_en), 
                        .BIST_USER9(BIST_USER9), .BIST_USER10(BIST_USER10), 
                        .BIST_USER11(BIST_USER11), .BIST_USER0(BIST_USER0), 
                        .BIST_USER1(BIST_USER1), .BIST_USER2(BIST_USER2), 
                        .BIST_USER3(BIST_USER3), .BIST_USER4(BIST_USER4), 
                        .BIST_USER5(BIST_USER5), .BIST_USER6(BIST_USER6), 
                        .BIST_USER7(BIST_USER7), .BIST_USER8(BIST_USER8), 
                        .BIST_EVEN_GROUPWRITEENABLE(BIST_EVEN_GROUPWRITEENABLE), 
                        .BIST_ODD_GROUPWRITEENABLE(BIST_ODD_GROUPWRITEENABLE), 
                        .BIST_WRITEENABLE(BIST_WRITEENABLE), .BIST_READENABLE(BIST_READENABLE), 
                        .BIST_SELECT(BIST_SELECT), .BIST_CMP(BIST_CMP), 
                        .INCLUDE_MEM_RESULTS_REG(INCLUDE_MEM_RESULTS_REG), 
                        .BIST_COL_ADD(BIST_COL_ADD), .BIST_ROW_ADD(BIST_ROW_ADD[5:0]), 
                        .BIST_COLLAR_EN13(BIST_COLLAR_EN13), 
                        .BIST_RUN_TO_COLLAR13(BIST_RUN_TO_COLLAR13), 
                        .BIST_ASYNC_RESET(BIST_ASYNC_RESET), 
                        .BIST_TESTDATA_SELECT_TO_COLLAR(BIST_TESTDATA_SELECT_TO_COLLAR), 
                        .BIST_ON_TO_COLLAR(BIST_ON_TO_COLLAR), 
                        .BIST_WRITE_DATA(BIST_WRITE_DATA[31:0]), 
                        .BIST_EXPECT_DATA(BIST_EXPECT_DATA[31:0]), 
                        .BIST_SHIFT_COLLAR(BIST_SHIFT_COLLAR), 
                        .BIST_COLLAR_SETUP(BIST_COLLAR_SETUP), 
                        .BIST_CLEAR_DEFAULT(BIST_CLEAR_DEFAULT), .BIST_CLEAR(BIST_CLEAR), 
                        .BIST_COLLAR_OPSET_SELECT(BIST_COLLAR_OPSET_SELECT[1:0]), 
                        .BIST_COLLAR_HOLD(BIST_COLLAR_HOLD), 
                        .FREEZE_STOP_ERROR(FREEZE_STOP_ERROR), 
                        .ERROR_CNT_ZERO(ERROR_CNT_ZERO), 
                        .MBISTPG_RESET_REG_SETUP2(MBISTPG_RESET_REG_SETUP2), 
                        .BIST_BANK_ADD(BIST_BANK_ADD), .bisr_shift_en_pd_vinf(bisr_shift_en_pd_vinf), 
                        .bisr_clk_pd_vinf(bisr_clk_pd_vinf), 
                        .bisr_reset_pd_vinf(bisr_reset_pd_vinf), 
                        .tcam_row_0_col_6_bisr_inst_SO(tcam_row_0_col_6_bisr_inst_SO), 
                        .tcam_row_0_col_7_bisr_inst_SO(tcam_row_0_col_7_bisr_inst_SO), 
                        .fscan_clkungate(fscan_clkungate)
                     );
        
              end

              
            else
              begin : gen_tcam_row_0_col_7_bcam
              end
              
        
        
        endgenerate
        
        always_ff @(posedge clk) begin
                   tcam_rd_data_col[0][7]      <= tcam_row_0_col_7_data_out;
                   tcam_col_hit_out[0][7]       <= tcam_row_0_col_7_hit_out;
        end
        

        // this is new template - tcam_asic_template
        
        wire                                            tcam_row_0_col_8_clk         = clk;
        
        wire    [TCAM_SLICE_EN_FACT-1:0]                tcam_row_0_col_8_slice_en = TCAM_SLICE_EN_FACT'(slice_en[(0 * TCAM_SLICE_EN_FACT)+:TCAM_SLICE_EN_MIN]);
        
        wire                                            tcam_row_0_col_8_rd_en       = tcam_row_rd_en[0];
        wire                                            tcam_row_0_col_8_wr_en       = tcam_row_wr_en[0];
        wire                                            tcam_row_0_col_8_chk_en      = chk_en;
        wire                                            tcam_row_0_col_8_reset_n = reset_n;
        wire    [8-1:0]                       tcam_row_0_col_8_adr  = tcam_row_adr[0][8-1:0];
        wire    [32-1:0]                      tcam_row_0_col_8_data_in = tcam_row_wr_en[0] ? tcam_wr_data_col[8][32-1:0] : tcam_chk_key_col[8][32-1:0];
        wire    [32-1:0]                      tcam_row_0_col_8_data_in_pre = tcam_wr_data_col[8][32-1:0] ;
        wire    [32-1:0]                      tcam_row_0_col_8_key_in =  tcam_chk_key_col[8][32-1:0];
        wire    [32-1:0]                      tcam_row_0_col_8_mask_in = tcam_chk_mask_col[8][32-1:0];
        wire    [128-1:0]                       tcam_row_0_col_8_hit_in = tcam_raw_hit_in[0];
        wire    [128-1:0]                       tcam_row_0_col_8_tcam_match_in = tcam_row_match_in[0];
        wire    [32-1:0]                      tcam_row_0_col_8_data_out_inv;
        logic   [128-1:0]                     tcam_row_0_col_8_hit_out_int;
        logic   [128-1:0]                     tcam_row_0_col_8_hit_out_latch;
        logic   [128-1:0]                     tcam_row_0_col_8_hit_out;
        
        `ifdef CXP_DFX_DISABLE
        wire                          tcam_row_0_col_8_biste = 'b0; 
        wire     [5-1:0]                  tcam_row_0_col_8_fca = 'b0;
        wire                            tcam_row_0_col_8_cre = 'b0;
        wire                            tcam_row_0_col_8_dftshiften = 'b0;
        wire                            tcam_row_0_col_8_dftmask = 'b0;
        wire                            tcam_row_0_col_8_dft_array_freeze = 'b0;
        wire                            tcam_row_0_col_8_dft_afd_reset_b = 'b0;
        wire      [32-1:0]    tcam_row_0_col_8_tdin = 'b0;
        wire      [8-1:0]     tcam_row_0_col_8_tadr = 'b0;
        wire                            tcam_row_0_col_8_tvbe = 'b0;
        wire                            tcam_row_0_col_8_tvbi = 'b0;
        wire      [32-1:0]    tcam_row_0_col_8_tmask = 'b0;
        wire                            tcam_row_0_col_8_twe = 'b0;
        wire                            tcam_row_0_col_8_tre = 'b0;
        wire                            tcam_row_0_col_8_tme = 'b0;
        wire                            tcam_row_0_col_8_bist_rotate_sr = 'b0;
        wire                            tcam_row_0_col_8_bist_en_sr_mask_b = 'b0;
        wire                            tcam_row_0_col_8_bist_all_mask = 'b0;
        wire                            tcam_row_0_col_8_bist_en_sr_data_b = 'b0;
        wire                            tcam_row_0_col_8_bist_cm_mode = 'b0;
        wire                            tcam_row_0_col_8_bist_cm_en_in = 'b0;
        wire                            tcam_row_0_col_8_bist_cm_match_sel0 = 'b0;
        wire                            tcam_row_0_col_8_bist_cm_match_sel1 = 'b0;
        wire                            tcam_row_0_col_8_bist_matchin_in = 'b0;
        wire                            tcam_row_0_col_8_bist_fls = 'b0;
        
        `else
        wire                            tcam_row_0_col_8_biste = 'b0;
        wire     [5-1:0]                  tcam_row_0_col_8_fca = 'b0;
        wire                            tcam_row_0_col_8_cre = 'b0;
        wire                            tcam_row_0_col_8_dftshiften = dftshiften;
        wire                            tcam_row_0_col_8_dftmask = dftmask;
        wire                            tcam_row_0_col_8_dft_array_freeze = dft_array_freeze;
        wire                            tcam_row_0_col_8_dft_afd_reset_b = dft_afd_reset_b;
        wire      [32-1:0]    tcam_row_0_col_8_tdin = 'b0;
        wire      [8-1:0]     tcam_row_0_col_8_tadr = 'b0;
        wire                            tcam_row_0_col_8_tvbe = 'b0;
        wire                            tcam_row_0_col_8_tvbi = 'b0;
        wire      [32-1:0]    tcam_row_0_col_8_tmask = 'b0;
        wire                            tcam_row_0_col_8_twe = 'b0;
        wire                            tcam_row_0_col_8_tre = 'b0;
        wire                            tcam_row_0_col_8_tme = 'b0;
        wire                            tcam_row_0_col_8_bist_rotate_sr = 'b0;
        wire                            tcam_row_0_col_8_bist_en_sr_mask_b = 'b0;
        wire                            tcam_row_0_col_8_bist_all_mask = 'b0;
        wire                            tcam_row_0_col_8_bist_en_sr_data_b = 'b0;
        wire                            tcam_row_0_col_8_bist_cm_mode = 'b0;
        wire                            tcam_row_0_col_8_bist_cm_en_in = 'b0;
        wire                            tcam_row_0_col_8_bist_cm_match_sel0 = 'b0;
        wire                            tcam_row_0_col_8_bist_cm_match_sel1 = 'b0;
        wire                            tcam_row_0_col_8_bist_matchin_in = 'b0;
        wire                            tcam_row_0_col_8_bist_fls = 'b0;
        `endif
        
        // Outputs
        logic                           tcam_row_0_col_8_wr_bira_fail;
        logic                           tcam_row_0_col_8_wr_so;
        logic                           tcam_row_0_col_8_curerrout;
        logic                           tcam_row_0_col_8_rscout;
        
        
        
        logic   [TCAM_SLICE_EN_FACT-1:0]                  tcam_row_0_col_8_slice_en_s0; 
        logic   [TCAM_SLICE_EN_FACT-1:0]                  tcam_row_0_col_8_slice_en_s1; 
        
        
        
             wire    [32-1:0]                     tcam_row_0_col_8_data_out ;
        
        
        
         generate
            if (BCAM_N7 == 0) 
              begin : gen_tcam_row_0_col_8_tcam
        
        
        // slice_en kept for TCAM only for backward compatability with Intel process
                always_comb 
                begin
                  for (int i = 0; i < TCAM_SLICE_EN_FACT; i++)
                      if (tcam_row_0_col_8_slice_en_s1[i])
                           tcam_row_0_col_8_hit_out[ i*64 +: 64]  = tcam_row_0_col_8_hit_out_int  [ i*64 +: 64]; 
                      else
                           tcam_row_0_col_8_hit_out[ i*64 +: 64]  = tcam_row_0_col_8_hit_out_latch[ i*64 +: 64]; 
                end
        
        
        
                always_ff  @(posedge tcam_row_0_col_8_clk)
                begin
                  tcam_row_0_col_8_slice_en_s0 <= tcam_row_0_col_8_slice_en; 
                  tcam_row_0_col_8_slice_en_s1 <= tcam_row_0_col_8_slice_en_s0; 
        
                  for (int i = 0; i < TCAM_SLICE_EN_FACT; i++)
                    begin
                      if (tcam_row_0_col_8_slice_en_s1[i])
                         tcam_row_0_col_8_hit_out_latch[ i*64 +: 64] <=  tcam_row_0_col_8_hit_out_int[ i*64 +: 64];
                    end
                end
        
        
        
        // NEW TCAM symbol 
        //                              _____________________________
        //                             |                             |
        //                         ----|ADRi                         |
        //                         ----|Di                           |
        //                         ----|RE                           |
        //                         ----|WE                           |
        //                         ----|ME                           |
        //                         ----|MASKi                        |
        //                         ----|DSEL                         |
        //                         ----|VBE                          |
        //                         ----|VBI                          |
        //                         ----|CMP                          |
        //                         ----|RVLDi                        |
        //                         ----|RST                          |
        //                         ----|FLS                          |
        //                         ----|CLK                          |
        //                         ----|FAF_EN                       |
        //                         ----|FAFi                         |
        //                             |                           Qi|---
        //                             |                         QVLD|---
        //                             |                         QHIT|---
        //                         ----|MDST_tcam                    |
        //                             |                         QHRi|---
        //                         ----|DFTSHIFTEN                   |
        //                         ----|DFTMASK                      |
        //                         ----|DFT_ARRAY_FREEZE             |
        //                         ----|DFT_AFD_RESET_B              |
        //                             |_____________________________|
        
                     
                         assign tcam_row_0_col_8_data_out  = ~tcam_row_0_col_8_data_out_inv;
                         wcm_ip783tcam128x32s0c1_0_8_wrap #(        
                                 )               
        
                                 ip783tcam128x32s0c1_wrap_tcam_row_0_col_8 (
                   //-------------------------------------------------------------
                   // Power Management Interfaces
                   //-------------------------------------------------------------   
                      `ifndef INTEL_NO_PWR_PINS
                      `ifdef INTC_ADD_VSS
                        .vss              (1'b0),
                      `endif
                        .vddp             (1'b1),
                      `endif
                         .ADR               (tcam_row_0_col_8_adr[8-1:1]), //Input adr_intess
                         .ME                (ce),  
        
                         .CLK               (tcam_row_0_col_8_clk), //Clock
                         .CMP               (tcam_row_0_col_8_chk_en), //Control Enable
                         .DIN               (~tcam_row_0_col_8_data_in), 
                         .DSEL              (~tcam_row_0_col_8_adr[0]), //dncen enables access of the TCAM Arrays adr_intessed
                         .FLS               (flush), //flush initiates a Flush operation that resets all Valid
                         .RVLD              (tcam_row_0_col_8_hit_in ), //Row validation bus. Each match_in input controls 1
                         .MASK              (tcam_row_0_col_8_mask_in), //Input msk
                         .QOUT              (tcam_row_0_col_8_data_out_inv), //Output vben
                         .QHR               (tcam_row_0_col_8_hit_out_int),
                         .QVLD              (), 
                         .RE                (tcam_row_0_col_8_rd_en), //Read Enable
                         .RST               (tcam_row_0_col_8_reset_n), //Asynchronous Active-High Reset
                         .VBE               (1'b1), //vben enables the Valid Bit addressed by adr[a-1:0] to
                         .VBI               (1'b0),//  Valid Bit Input
                         .WE                (tcam_row_0_col_8_wr_en), //Write Enable
                         .FAF               (tcam_row_0_col_8_fca),
                         .FAF_EN            (tcam_row_0_col_8_cre),
                         .DFTSHIFTEN        (tcam_row_0_col_8_dftshiften),
                         .DFTMASK           (tcam_row_0_col_8_dftmask),
                         .DFT_ARRAY_FREEZE  (tcam_row_0_col_8_dft_array_freeze),
                         .DFT_AFD_RESET_B   (tcam_row_0_col_8_dft_afd_reset_b),
                         .BISTE           (tcam_row_0_col_8_biste),
                         .TDIN (tcam_row_0_col_8_tdin),
                         .TADR (tcam_row_0_col_8_tadr),
                         .TVBE (tcam_row_0_col_8_tvbe),
                         .TVBI (tcam_row_0_col_8_tvbi),
                         .TMASK (tcam_row_0_col_8_tmask),
                         .TWE (tcam_row_0_col_8_twe),
                         .TRE (tcam_row_0_col_8_tre),
                         .TME (tcam_row_0_col_8_tme),
                         .BIST_ROTATE_SR (tcam_row_0_col_8_bist_rotate_sr),
                         .BIST_EN_SR_MASK_B (tcam_row_0_col_8_bist_en_sr_mask_b),
                         .BIST_ALL_MASK (tcam_row_0_col_8_bist_all_mask),
                         .BIST_EN_SR_DATA_B (tcam_row_0_col_8_bist_en_sr_data_b),
                         .BIST_CM_MODE (tcam_row_0_col_8_bist_cm_mode),
                         .BIST_CM_EN_IN (tcam_row_0_col_8_bist_cm_en_in),
                         .BIST_CM_MATCH_SEL0 (tcam_row_0_col_8_bist_cm_match_sel0),
                         .BIST_CM_MATCH_SEL1 (tcam_row_0_col_8_bist_cm_match_sel1),
                         .BIST_MATCHIN_IN (tcam_row_0_col_8_bist_matchin_in),
                         .BIST_FLS (tcam_row_0_col_8_bist_fls),
                         .MDST_tcam (fuse_tcam), .BIST_SETUP(BIST_SETUP), .BIST_SETUP_ts1(BIST_SETUP_ts1), 
                        .BIST_SETUP_ts2(BIST_SETUP_ts2), .to_interfaces_tck(to_interfaces_tck), 
                        .mcp_bounding_to_en(mcp_bounding_to_en), .scan_to_en(scan_to_en), 
                        .memory_bypass_to_en(memory_bypass_to_en), 
                        .GO_ID_REG_SEL(GO_ID_REG_SEL), .BIST_CLEAR_BIRA(BIST_CLEAR_BIRA), 
                        .BIST_COLLAR_DIAG_EN(BIST_COLLAR_DIAG_EN), 
                        .BIST_COLLAR_BIRA_EN(BIST_COLLAR_BIRA_EN), 
                        .BIST_SHIFT_BIRA_COLLAR(BIST_SHIFT_BIRA_COLLAR), 
                        .CHECK_REPAIR_NEEDED(CHECK_REPAIR_NEEDED), 
                        .MEM14_BIST_COLLAR_SI(MEM14_BIST_COLLAR_SI), .BIST_SO(BIST_SO_ts14), 
                        .BIST_GO(BIST_GO_ts14), .ltest_to_en(ltest_to_en), 
                        .BIST_USER9(BIST_USER9), .BIST_USER10(BIST_USER10), 
                        .BIST_USER11(BIST_USER11), .BIST_USER0(BIST_USER0), 
                        .BIST_USER1(BIST_USER1), .BIST_USER2(BIST_USER2), 
                        .BIST_USER3(BIST_USER3), .BIST_USER4(BIST_USER4), 
                        .BIST_USER5(BIST_USER5), .BIST_USER6(BIST_USER6), 
                        .BIST_USER7(BIST_USER7), .BIST_USER8(BIST_USER8), 
                        .BIST_EVEN_GROUPWRITEENABLE(BIST_EVEN_GROUPWRITEENABLE), 
                        .BIST_ODD_GROUPWRITEENABLE(BIST_ODD_GROUPWRITEENABLE), 
                        .BIST_WRITEENABLE(BIST_WRITEENABLE), .BIST_READENABLE(BIST_READENABLE), 
                        .BIST_SELECT(BIST_SELECT), .BIST_CMP(BIST_CMP), 
                        .INCLUDE_MEM_RESULTS_REG(INCLUDE_MEM_RESULTS_REG), 
                        .BIST_COL_ADD(BIST_COL_ADD), .BIST_ROW_ADD(BIST_ROW_ADD[5:0]), 
                        .BIST_COLLAR_EN14(BIST_COLLAR_EN14), 
                        .BIST_RUN_TO_COLLAR14(BIST_RUN_TO_COLLAR14), 
                        .BIST_ASYNC_RESET(BIST_ASYNC_RESET), 
                        .BIST_TESTDATA_SELECT_TO_COLLAR(BIST_TESTDATA_SELECT_TO_COLLAR), 
                        .BIST_ON_TO_COLLAR(BIST_ON_TO_COLLAR), 
                        .BIST_WRITE_DATA(BIST_WRITE_DATA[31:0]), 
                        .BIST_EXPECT_DATA(BIST_EXPECT_DATA[31:0]), 
                        .BIST_SHIFT_COLLAR(BIST_SHIFT_COLLAR), 
                        .BIST_COLLAR_SETUP(BIST_COLLAR_SETUP), 
                        .BIST_CLEAR_DEFAULT(BIST_CLEAR_DEFAULT), .BIST_CLEAR(BIST_CLEAR), 
                        .BIST_COLLAR_OPSET_SELECT(BIST_COLLAR_OPSET_SELECT[1:0]), 
                        .BIST_COLLAR_HOLD(BIST_COLLAR_HOLD), 
                        .FREEZE_STOP_ERROR(FREEZE_STOP_ERROR), 
                        .ERROR_CNT_ZERO(ERROR_CNT_ZERO), 
                        .MBISTPG_RESET_REG_SETUP2(MBISTPG_RESET_REG_SETUP2), 
                        .BIST_BANK_ADD(BIST_BANK_ADD), .bisr_shift_en_pd_vinf(bisr_shift_en_pd_vinf), 
                        .bisr_clk_pd_vinf(bisr_clk_pd_vinf), 
                        .bisr_reset_pd_vinf(bisr_reset_pd_vinf), 
                        .tcam_row_0_col_7_bisr_inst_SO(tcam_row_0_col_7_bisr_inst_SO), 
                        .tcam_row_0_col_8_bisr_inst_SO(tcam_row_0_col_8_bisr_inst_SO), 
                        .fscan_clkungate(fscan_clkungate)
                     );
        
              end

              
            else
              begin : gen_tcam_row_0_col_8_bcam
              end
              
        
        
        endgenerate
        
        always_ff @(posedge clk) begin
                   tcam_rd_data_col[0][8]      <= tcam_row_0_col_8_data_out;
                   tcam_col_hit_out[0][8]       <= tcam_row_0_col_8_hit_out;
        end
        

        // this is new template - tcam_asic_template
        
        wire                                            tcam_row_0_col_9_clk         = clk;
        
        wire    [TCAM_SLICE_EN_FACT-1:0]                tcam_row_0_col_9_slice_en = TCAM_SLICE_EN_FACT'(slice_en[(0 * TCAM_SLICE_EN_FACT)+:TCAM_SLICE_EN_MIN]);
        
        wire                                            tcam_row_0_col_9_rd_en       = tcam_row_rd_en[0];
        wire                                            tcam_row_0_col_9_wr_en       = tcam_row_wr_en[0];
        wire                                            tcam_row_0_col_9_chk_en      = chk_en;
        wire                                            tcam_row_0_col_9_reset_n = reset_n;
        wire    [8-1:0]                       tcam_row_0_col_9_adr  = tcam_row_adr[0][8-1:0];
        wire    [32-1:0]                      tcam_row_0_col_9_data_in = tcam_row_wr_en[0] ? tcam_wr_data_col[9][32-1:0] : tcam_chk_key_col[9][32-1:0];
        wire    [32-1:0]                      tcam_row_0_col_9_data_in_pre = tcam_wr_data_col[9][32-1:0] ;
        wire    [32-1:0]                      tcam_row_0_col_9_key_in =  tcam_chk_key_col[9][32-1:0];
        wire    [32-1:0]                      tcam_row_0_col_9_mask_in = tcam_chk_mask_col[9][32-1:0];
        wire    [128-1:0]                       tcam_row_0_col_9_hit_in = tcam_raw_hit_in[0];
        wire    [128-1:0]                       tcam_row_0_col_9_tcam_match_in = tcam_row_match_in[0];
        wire    [32-1:0]                      tcam_row_0_col_9_data_out_inv;
        logic   [128-1:0]                     tcam_row_0_col_9_hit_out_int;
        logic   [128-1:0]                     tcam_row_0_col_9_hit_out_latch;
        logic   [128-1:0]                     tcam_row_0_col_9_hit_out;
        
        `ifdef CXP_DFX_DISABLE
        wire                          tcam_row_0_col_9_biste = 'b0; 
        wire     [5-1:0]                  tcam_row_0_col_9_fca = 'b0;
        wire                            tcam_row_0_col_9_cre = 'b0;
        wire                            tcam_row_0_col_9_dftshiften = 'b0;
        wire                            tcam_row_0_col_9_dftmask = 'b0;
        wire                            tcam_row_0_col_9_dft_array_freeze = 'b0;
        wire                            tcam_row_0_col_9_dft_afd_reset_b = 'b0;
        wire      [32-1:0]    tcam_row_0_col_9_tdin = 'b0;
        wire      [8-1:0]     tcam_row_0_col_9_tadr = 'b0;
        wire                            tcam_row_0_col_9_tvbe = 'b0;
        wire                            tcam_row_0_col_9_tvbi = 'b0;
        wire      [32-1:0]    tcam_row_0_col_9_tmask = 'b0;
        wire                            tcam_row_0_col_9_twe = 'b0;
        wire                            tcam_row_0_col_9_tre = 'b0;
        wire                            tcam_row_0_col_9_tme = 'b0;
        wire                            tcam_row_0_col_9_bist_rotate_sr = 'b0;
        wire                            tcam_row_0_col_9_bist_en_sr_mask_b = 'b0;
        wire                            tcam_row_0_col_9_bist_all_mask = 'b0;
        wire                            tcam_row_0_col_9_bist_en_sr_data_b = 'b0;
        wire                            tcam_row_0_col_9_bist_cm_mode = 'b0;
        wire                            tcam_row_0_col_9_bist_cm_en_in = 'b0;
        wire                            tcam_row_0_col_9_bist_cm_match_sel0 = 'b0;
        wire                            tcam_row_0_col_9_bist_cm_match_sel1 = 'b0;
        wire                            tcam_row_0_col_9_bist_matchin_in = 'b0;
        wire                            tcam_row_0_col_9_bist_fls = 'b0;
        
        `else
        wire                            tcam_row_0_col_9_biste = 'b0;
        wire     [5-1:0]                  tcam_row_0_col_9_fca = 'b0;
        wire                            tcam_row_0_col_9_cre = 'b0;
        wire                            tcam_row_0_col_9_dftshiften = dftshiften;
        wire                            tcam_row_0_col_9_dftmask = dftmask;
        wire                            tcam_row_0_col_9_dft_array_freeze = dft_array_freeze;
        wire                            tcam_row_0_col_9_dft_afd_reset_b = dft_afd_reset_b;
        wire      [32-1:0]    tcam_row_0_col_9_tdin = 'b0;
        wire      [8-1:0]     tcam_row_0_col_9_tadr = 'b0;
        wire                            tcam_row_0_col_9_tvbe = 'b0;
        wire                            tcam_row_0_col_9_tvbi = 'b0;
        wire      [32-1:0]    tcam_row_0_col_9_tmask = 'b0;
        wire                            tcam_row_0_col_9_twe = 'b0;
        wire                            tcam_row_0_col_9_tre = 'b0;
        wire                            tcam_row_0_col_9_tme = 'b0;
        wire                            tcam_row_0_col_9_bist_rotate_sr = 'b0;
        wire                            tcam_row_0_col_9_bist_en_sr_mask_b = 'b0;
        wire                            tcam_row_0_col_9_bist_all_mask = 'b0;
        wire                            tcam_row_0_col_9_bist_en_sr_data_b = 'b0;
        wire                            tcam_row_0_col_9_bist_cm_mode = 'b0;
        wire                            tcam_row_0_col_9_bist_cm_en_in = 'b0;
        wire                            tcam_row_0_col_9_bist_cm_match_sel0 = 'b0;
        wire                            tcam_row_0_col_9_bist_cm_match_sel1 = 'b0;
        wire                            tcam_row_0_col_9_bist_matchin_in = 'b0;
        wire                            tcam_row_0_col_9_bist_fls = 'b0;
        `endif
        
        // Outputs
        logic                           tcam_row_0_col_9_wr_bira_fail;
        logic                           tcam_row_0_col_9_wr_so;
        logic                           tcam_row_0_col_9_curerrout;
        logic                           tcam_row_0_col_9_rscout;
        
        
        
        logic   [TCAM_SLICE_EN_FACT-1:0]                  tcam_row_0_col_9_slice_en_s0; 
        logic   [TCAM_SLICE_EN_FACT-1:0]                  tcam_row_0_col_9_slice_en_s1; 
        
        
        
             wire    [32-1:0]                     tcam_row_0_col_9_data_out ;
        
        
        
         generate
            if (BCAM_N7 == 0) 
              begin : gen_tcam_row_0_col_9_tcam
        
        
        // slice_en kept for TCAM only for backward compatability with Intel process
                always_comb 
                begin
                  for (int i = 0; i < TCAM_SLICE_EN_FACT; i++)
                      if (tcam_row_0_col_9_slice_en_s1[i])
                           tcam_row_0_col_9_hit_out[ i*64 +: 64]  = tcam_row_0_col_9_hit_out_int  [ i*64 +: 64]; 
                      else
                           tcam_row_0_col_9_hit_out[ i*64 +: 64]  = tcam_row_0_col_9_hit_out_latch[ i*64 +: 64]; 
                end
        
        
        
                always_ff  @(posedge tcam_row_0_col_9_clk)
                begin
                  tcam_row_0_col_9_slice_en_s0 <= tcam_row_0_col_9_slice_en; 
                  tcam_row_0_col_9_slice_en_s1 <= tcam_row_0_col_9_slice_en_s0; 
        
                  for (int i = 0; i < TCAM_SLICE_EN_FACT; i++)
                    begin
                      if (tcam_row_0_col_9_slice_en_s1[i])
                         tcam_row_0_col_9_hit_out_latch[ i*64 +: 64] <=  tcam_row_0_col_9_hit_out_int[ i*64 +: 64];
                    end
                end
        
        
        
        // NEW TCAM symbol 
        //                              _____________________________
        //                             |                             |
        //                         ----|ADRi                         |
        //                         ----|Di                           |
        //                         ----|RE                           |
        //                         ----|WE                           |
        //                         ----|ME                           |
        //                         ----|MASKi                        |
        //                         ----|DSEL                         |
        //                         ----|VBE                          |
        //                         ----|VBI                          |
        //                         ----|CMP                          |
        //                         ----|RVLDi                        |
        //                         ----|RST                          |
        //                         ----|FLS                          |
        //                         ----|CLK                          |
        //                         ----|FAF_EN                       |
        //                         ----|FAFi                         |
        //                             |                           Qi|---
        //                             |                         QVLD|---
        //                             |                         QHIT|---
        //                         ----|MDST_tcam                    |
        //                             |                         QHRi|---
        //                         ----|DFTSHIFTEN                   |
        //                         ----|DFTMASK                      |
        //                         ----|DFT_ARRAY_FREEZE             |
        //                         ----|DFT_AFD_RESET_B              |
        //                             |_____________________________|
        
                     
                         assign tcam_row_0_col_9_data_out  = ~tcam_row_0_col_9_data_out_inv;
                         wcm_ip783tcam128x32s0c1_0_9_wrap #(        
                                 )               
        
                                 ip783tcam128x32s0c1_wrap_tcam_row_0_col_9 (
                   //-------------------------------------------------------------
                   // Power Management Interfaces
                   //-------------------------------------------------------------   
                      `ifndef INTEL_NO_PWR_PINS
                      `ifdef INTC_ADD_VSS
                        .vss              (1'b0),
                      `endif
                        .vddp             (1'b1),
                      `endif
                         .ADR               (tcam_row_0_col_9_adr[8-1:1]), //Input adr_intess
                         .ME                (ce),  
        
                         .CLK               (tcam_row_0_col_9_clk), //Clock
                         .CMP               (tcam_row_0_col_9_chk_en), //Control Enable
                         .DIN               (~tcam_row_0_col_9_data_in), 
                         .DSEL              (~tcam_row_0_col_9_adr[0]), //dncen enables access of the TCAM Arrays adr_intessed
                         .FLS               (flush), //flush initiates a Flush operation that resets all Valid
                         .RVLD              (tcam_row_0_col_9_hit_in ), //Row validation bus. Each match_in input controls 1
                         .MASK              (tcam_row_0_col_9_mask_in), //Input msk
                         .QOUT              (tcam_row_0_col_9_data_out_inv), //Output vben
                         .QHR               (tcam_row_0_col_9_hit_out_int),
                         .QVLD              (), 
                         .RE                (tcam_row_0_col_9_rd_en), //Read Enable
                         .RST               (tcam_row_0_col_9_reset_n), //Asynchronous Active-High Reset
                         .VBE               (1'b1), //vben enables the Valid Bit addressed by adr[a-1:0] to
                         .VBI               (1'b0),//  Valid Bit Input
                         .WE                (tcam_row_0_col_9_wr_en), //Write Enable
                         .FAF               (tcam_row_0_col_9_fca),
                         .FAF_EN            (tcam_row_0_col_9_cre),
                         .DFTSHIFTEN        (tcam_row_0_col_9_dftshiften),
                         .DFTMASK           (tcam_row_0_col_9_dftmask),
                         .DFT_ARRAY_FREEZE  (tcam_row_0_col_9_dft_array_freeze),
                         .DFT_AFD_RESET_B   (tcam_row_0_col_9_dft_afd_reset_b),
                         .BISTE           (tcam_row_0_col_9_biste),
                         .TDIN (tcam_row_0_col_9_tdin),
                         .TADR (tcam_row_0_col_9_tadr),
                         .TVBE (tcam_row_0_col_9_tvbe),
                         .TVBI (tcam_row_0_col_9_tvbi),
                         .TMASK (tcam_row_0_col_9_tmask),
                         .TWE (tcam_row_0_col_9_twe),
                         .TRE (tcam_row_0_col_9_tre),
                         .TME (tcam_row_0_col_9_tme),
                         .BIST_ROTATE_SR (tcam_row_0_col_9_bist_rotate_sr),
                         .BIST_EN_SR_MASK_B (tcam_row_0_col_9_bist_en_sr_mask_b),
                         .BIST_ALL_MASK (tcam_row_0_col_9_bist_all_mask),
                         .BIST_EN_SR_DATA_B (tcam_row_0_col_9_bist_en_sr_data_b),
                         .BIST_CM_MODE (tcam_row_0_col_9_bist_cm_mode),
                         .BIST_CM_EN_IN (tcam_row_0_col_9_bist_cm_en_in),
                         .BIST_CM_MATCH_SEL0 (tcam_row_0_col_9_bist_cm_match_sel0),
                         .BIST_CM_MATCH_SEL1 (tcam_row_0_col_9_bist_cm_match_sel1),
                         .BIST_MATCHIN_IN (tcam_row_0_col_9_bist_matchin_in),
                         .BIST_FLS (tcam_row_0_col_9_bist_fls),
                         .MDST_tcam (fuse_tcam), .BIST_SETUP(BIST_SETUP), .BIST_SETUP_ts1(BIST_SETUP_ts1), 
                        .BIST_SETUP_ts2(BIST_SETUP_ts2), .to_interfaces_tck(to_interfaces_tck), 
                        .mcp_bounding_to_en(mcp_bounding_to_en), .scan_to_en(scan_to_en), 
                        .memory_bypass_to_en(memory_bypass_to_en), 
                        .GO_ID_REG_SEL(GO_ID_REG_SEL), .BIST_CLEAR_BIRA(BIST_CLEAR_BIRA), 
                        .BIST_COLLAR_DIAG_EN(BIST_COLLAR_DIAG_EN), 
                        .BIST_COLLAR_BIRA_EN(BIST_COLLAR_BIRA_EN), 
                        .BIST_SHIFT_BIRA_COLLAR(BIST_SHIFT_BIRA_COLLAR), 
                        .CHECK_REPAIR_NEEDED(CHECK_REPAIR_NEEDED), 
                        .MEM15_BIST_COLLAR_SI(MEM15_BIST_COLLAR_SI), .BIST_SO(BIST_SO_ts15), 
                        .BIST_GO(BIST_GO_ts15), .ltest_to_en(ltest_to_en), 
                        .BIST_USER9(BIST_USER9), .BIST_USER10(BIST_USER10), 
                        .BIST_USER11(BIST_USER11), .BIST_USER0(BIST_USER0), 
                        .BIST_USER1(BIST_USER1), .BIST_USER2(BIST_USER2), 
                        .BIST_USER3(BIST_USER3), .BIST_USER4(BIST_USER4), 
                        .BIST_USER5(BIST_USER5), .BIST_USER6(BIST_USER6), 
                        .BIST_USER7(BIST_USER7), .BIST_USER8(BIST_USER8), 
                        .BIST_EVEN_GROUPWRITEENABLE(BIST_EVEN_GROUPWRITEENABLE), 
                        .BIST_ODD_GROUPWRITEENABLE(BIST_ODD_GROUPWRITEENABLE), 
                        .BIST_WRITEENABLE(BIST_WRITEENABLE), .BIST_READENABLE(BIST_READENABLE), 
                        .BIST_SELECT(BIST_SELECT), .BIST_CMP(BIST_CMP), 
                        .INCLUDE_MEM_RESULTS_REG(INCLUDE_MEM_RESULTS_REG), 
                        .BIST_COL_ADD(BIST_COL_ADD), .BIST_ROW_ADD(BIST_ROW_ADD[5:0]), 
                        .BIST_COLLAR_EN15(BIST_COLLAR_EN15), 
                        .BIST_RUN_TO_COLLAR15(BIST_RUN_TO_COLLAR15), 
                        .BIST_ASYNC_RESET(BIST_ASYNC_RESET), 
                        .BIST_TESTDATA_SELECT_TO_COLLAR(BIST_TESTDATA_SELECT_TO_COLLAR), 
                        .BIST_ON_TO_COLLAR(BIST_ON_TO_COLLAR), 
                        .BIST_WRITE_DATA(BIST_WRITE_DATA[31:0]), 
                        .BIST_EXPECT_DATA(BIST_EXPECT_DATA[31:0]), 
                        .BIST_SHIFT_COLLAR(BIST_SHIFT_COLLAR), 
                        .BIST_COLLAR_SETUP(BIST_COLLAR_SETUP), 
                        .BIST_CLEAR_DEFAULT(BIST_CLEAR_DEFAULT), .BIST_CLEAR(BIST_CLEAR), 
                        .BIST_COLLAR_OPSET_SELECT(BIST_COLLAR_OPSET_SELECT[1:0]), 
                        .BIST_COLLAR_HOLD(BIST_COLLAR_HOLD), 
                        .FREEZE_STOP_ERROR(FREEZE_STOP_ERROR), 
                        .ERROR_CNT_ZERO(ERROR_CNT_ZERO), 
                        .MBISTPG_RESET_REG_SETUP2(MBISTPG_RESET_REG_SETUP2), 
                        .BIST_BANK_ADD(BIST_BANK_ADD), .bisr_shift_en_pd_vinf(bisr_shift_en_pd_vinf), 
                        .bisr_clk_pd_vinf(bisr_clk_pd_vinf), 
                        .bisr_reset_pd_vinf(bisr_reset_pd_vinf), 
                        .tcam_row_0_col_8_bisr_inst_SO(tcam_row_0_col_8_bisr_inst_SO), 
                        .tcam_row_0_col_9_bisr_inst_SO(tcam_row_0_col_9_bisr_inst_SO), 
                        .fscan_clkungate(fscan_clkungate)
                     );
        
              end

              
            else
              begin : gen_tcam_row_0_col_9_bcam
              end
              
        
        
        endgenerate
        
        always_ff @(posedge clk) begin
                   tcam_rd_data_col[0][9]      <= tcam_row_0_col_9_data_out;
                   tcam_col_hit_out[0][9]       <= tcam_row_0_col_9_hit_out;
        end
        

        // this is new template - tcam_asic_template
        
        wire                                            tcam_row_0_col_10_clk         = clk;
        
        wire    [TCAM_SLICE_EN_FACT-1:0]                tcam_row_0_col_10_slice_en = TCAM_SLICE_EN_FACT'(slice_en[(0 * TCAM_SLICE_EN_FACT)+:TCAM_SLICE_EN_MIN]);
        
        wire                                            tcam_row_0_col_10_rd_en       = tcam_row_rd_en[0];
        wire                                            tcam_row_0_col_10_wr_en       = tcam_row_wr_en[0];
        wire                                            tcam_row_0_col_10_chk_en      = chk_en;
        wire                                            tcam_row_0_col_10_reset_n = reset_n;
        wire    [8-1:0]                       tcam_row_0_col_10_adr  = tcam_row_adr[0][8-1:0];
        wire    [32-1:0]                      tcam_row_0_col_10_data_in = tcam_row_wr_en[0] ? tcam_wr_data_col[10][32-1:0] : tcam_chk_key_col[10][32-1:0];
        wire    [32-1:0]                      tcam_row_0_col_10_data_in_pre = tcam_wr_data_col[10][32-1:0] ;
        wire    [32-1:0]                      tcam_row_0_col_10_key_in =  tcam_chk_key_col[10][32-1:0];
        wire    [32-1:0]                      tcam_row_0_col_10_mask_in = tcam_chk_mask_col[10][32-1:0];
        wire    [128-1:0]                       tcam_row_0_col_10_hit_in = tcam_raw_hit_in[0];
        wire    [128-1:0]                       tcam_row_0_col_10_tcam_match_in = tcam_row_match_in[0];
        wire    [32-1:0]                      tcam_row_0_col_10_data_out_inv;
        logic   [128-1:0]                     tcam_row_0_col_10_hit_out_int;
        logic   [128-1:0]                     tcam_row_0_col_10_hit_out_latch;
        logic   [128-1:0]                     tcam_row_0_col_10_hit_out;
        
        `ifdef CXP_DFX_DISABLE
        wire                          tcam_row_0_col_10_biste = 'b0; 
        wire     [5-1:0]                  tcam_row_0_col_10_fca = 'b0;
        wire                            tcam_row_0_col_10_cre = 'b0;
        wire                            tcam_row_0_col_10_dftshiften = 'b0;
        wire                            tcam_row_0_col_10_dftmask = 'b0;
        wire                            tcam_row_0_col_10_dft_array_freeze = 'b0;
        wire                            tcam_row_0_col_10_dft_afd_reset_b = 'b0;
        wire      [32-1:0]    tcam_row_0_col_10_tdin = 'b0;
        wire      [8-1:0]     tcam_row_0_col_10_tadr = 'b0;
        wire                            tcam_row_0_col_10_tvbe = 'b0;
        wire                            tcam_row_0_col_10_tvbi = 'b0;
        wire      [32-1:0]    tcam_row_0_col_10_tmask = 'b0;
        wire                            tcam_row_0_col_10_twe = 'b0;
        wire                            tcam_row_0_col_10_tre = 'b0;
        wire                            tcam_row_0_col_10_tme = 'b0;
        wire                            tcam_row_0_col_10_bist_rotate_sr = 'b0;
        wire                            tcam_row_0_col_10_bist_en_sr_mask_b = 'b0;
        wire                            tcam_row_0_col_10_bist_all_mask = 'b0;
        wire                            tcam_row_0_col_10_bist_en_sr_data_b = 'b0;
        wire                            tcam_row_0_col_10_bist_cm_mode = 'b0;
        wire                            tcam_row_0_col_10_bist_cm_en_in = 'b0;
        wire                            tcam_row_0_col_10_bist_cm_match_sel0 = 'b0;
        wire                            tcam_row_0_col_10_bist_cm_match_sel1 = 'b0;
        wire                            tcam_row_0_col_10_bist_matchin_in = 'b0;
        wire                            tcam_row_0_col_10_bist_fls = 'b0;
        
        `else
        wire                            tcam_row_0_col_10_biste = 'b0;
        wire     [5-1:0]                  tcam_row_0_col_10_fca = 'b0;
        wire                            tcam_row_0_col_10_cre = 'b0;
        wire                            tcam_row_0_col_10_dftshiften = dftshiften;
        wire                            tcam_row_0_col_10_dftmask = dftmask;
        wire                            tcam_row_0_col_10_dft_array_freeze = dft_array_freeze;
        wire                            tcam_row_0_col_10_dft_afd_reset_b = dft_afd_reset_b;
        wire      [32-1:0]    tcam_row_0_col_10_tdin = 'b0;
        wire      [8-1:0]     tcam_row_0_col_10_tadr = 'b0;
        wire                            tcam_row_0_col_10_tvbe = 'b0;
        wire                            tcam_row_0_col_10_tvbi = 'b0;
        wire      [32-1:0]    tcam_row_0_col_10_tmask = 'b0;
        wire                            tcam_row_0_col_10_twe = 'b0;
        wire                            tcam_row_0_col_10_tre = 'b0;
        wire                            tcam_row_0_col_10_tme = 'b0;
        wire                            tcam_row_0_col_10_bist_rotate_sr = 'b0;
        wire                            tcam_row_0_col_10_bist_en_sr_mask_b = 'b0;
        wire                            tcam_row_0_col_10_bist_all_mask = 'b0;
        wire                            tcam_row_0_col_10_bist_en_sr_data_b = 'b0;
        wire                            tcam_row_0_col_10_bist_cm_mode = 'b0;
        wire                            tcam_row_0_col_10_bist_cm_en_in = 'b0;
        wire                            tcam_row_0_col_10_bist_cm_match_sel0 = 'b0;
        wire                            tcam_row_0_col_10_bist_cm_match_sel1 = 'b0;
        wire                            tcam_row_0_col_10_bist_matchin_in = 'b0;
        wire                            tcam_row_0_col_10_bist_fls = 'b0;
        `endif
        
        // Outputs
        logic                           tcam_row_0_col_10_wr_bira_fail;
        logic                           tcam_row_0_col_10_wr_so;
        logic                           tcam_row_0_col_10_curerrout;
        logic                           tcam_row_0_col_10_rscout;
        
        
        
        logic   [TCAM_SLICE_EN_FACT-1:0]                  tcam_row_0_col_10_slice_en_s0; 
        logic   [TCAM_SLICE_EN_FACT-1:0]                  tcam_row_0_col_10_slice_en_s1; 
        
        
        
             wire    [32-1:0]                     tcam_row_0_col_10_data_out ;
        
        
        
         generate
            if (BCAM_N7 == 0) 
              begin : gen_tcam_row_0_col_10_tcam
        
        
        // slice_en kept for TCAM only for backward compatability with Intel process
                always_comb 
                begin
                  for (int i = 0; i < TCAM_SLICE_EN_FACT; i++)
                      if (tcam_row_0_col_10_slice_en_s1[i])
                           tcam_row_0_col_10_hit_out[ i*64 +: 64]  = tcam_row_0_col_10_hit_out_int  [ i*64 +: 64]; 
                      else
                           tcam_row_0_col_10_hit_out[ i*64 +: 64]  = tcam_row_0_col_10_hit_out_latch[ i*64 +: 64]; 
                end
        
        
        
                always_ff  @(posedge tcam_row_0_col_10_clk)
                begin
                  tcam_row_0_col_10_slice_en_s0 <= tcam_row_0_col_10_slice_en; 
                  tcam_row_0_col_10_slice_en_s1 <= tcam_row_0_col_10_slice_en_s0; 
        
                  for (int i = 0; i < TCAM_SLICE_EN_FACT; i++)
                    begin
                      if (tcam_row_0_col_10_slice_en_s1[i])
                         tcam_row_0_col_10_hit_out_latch[ i*64 +: 64] <=  tcam_row_0_col_10_hit_out_int[ i*64 +: 64];
                    end
                end
        
        
        
        // NEW TCAM symbol 
        //                              _____________________________
        //                             |                             |
        //                         ----|ADRi                         |
        //                         ----|Di                           |
        //                         ----|RE                           |
        //                         ----|WE                           |
        //                         ----|ME                           |
        //                         ----|MASKi                        |
        //                         ----|DSEL                         |
        //                         ----|VBE                          |
        //                         ----|VBI                          |
        //                         ----|CMP                          |
        //                         ----|RVLDi                        |
        //                         ----|RST                          |
        //                         ----|FLS                          |
        //                         ----|CLK                          |
        //                         ----|FAF_EN                       |
        //                         ----|FAFi                         |
        //                             |                           Qi|---
        //                             |                         QVLD|---
        //                             |                         QHIT|---
        //                         ----|MDST_tcam                    |
        //                             |                         QHRi|---
        //                         ----|DFTSHIFTEN                   |
        //                         ----|DFTMASK                      |
        //                         ----|DFT_ARRAY_FREEZE             |
        //                         ----|DFT_AFD_RESET_B              |
        //                             |_____________________________|
        
                     
                         assign tcam_row_0_col_10_data_out  = ~tcam_row_0_col_10_data_out_inv;
                         wcm_ip783tcam128x32s0c1_0_10_wrap #(        
                                 )               
        
                                 ip783tcam128x32s0c1_wrap_tcam_row_0_col_10 (
                   //-------------------------------------------------------------
                   // Power Management Interfaces
                   //-------------------------------------------------------------   
                      `ifndef INTEL_NO_PWR_PINS
                      `ifdef INTC_ADD_VSS
                        .vss              (1'b0),
                      `endif
                        .vddp             (1'b1),
                      `endif
                         .ADR               (tcam_row_0_col_10_adr[8-1:1]), //Input adr_intess
                         .ME                (ce),  
        
                         .CLK               (tcam_row_0_col_10_clk), //Clock
                         .CMP               (tcam_row_0_col_10_chk_en), //Control Enable
                         .DIN               (~tcam_row_0_col_10_data_in), 
                         .DSEL              (~tcam_row_0_col_10_adr[0]), //dncen enables access of the TCAM Arrays adr_intessed
                         .FLS               (flush), //flush initiates a Flush operation that resets all Valid
                         .RVLD              (tcam_row_0_col_10_hit_in ), //Row validation bus. Each match_in input controls 1
                         .MASK              (tcam_row_0_col_10_mask_in), //Input msk
                         .QOUT              (tcam_row_0_col_10_data_out_inv), //Output vben
                         .QHR               (tcam_row_0_col_10_hit_out_int),
                         .QVLD              (), 
                         .RE                (tcam_row_0_col_10_rd_en), //Read Enable
                         .RST               (tcam_row_0_col_10_reset_n), //Asynchronous Active-High Reset
                         .VBE               (1'b1), //vben enables the Valid Bit addressed by adr[a-1:0] to
                         .VBI               (1'b0),//  Valid Bit Input
                         .WE                (tcam_row_0_col_10_wr_en), //Write Enable
                         .FAF               (tcam_row_0_col_10_fca),
                         .FAF_EN            (tcam_row_0_col_10_cre),
                         .DFTSHIFTEN        (tcam_row_0_col_10_dftshiften),
                         .DFTMASK           (tcam_row_0_col_10_dftmask),
                         .DFT_ARRAY_FREEZE  (tcam_row_0_col_10_dft_array_freeze),
                         .DFT_AFD_RESET_B   (tcam_row_0_col_10_dft_afd_reset_b),
                         .BISTE           (tcam_row_0_col_10_biste),
                         .TDIN (tcam_row_0_col_10_tdin),
                         .TADR (tcam_row_0_col_10_tadr),
                         .TVBE (tcam_row_0_col_10_tvbe),
                         .TVBI (tcam_row_0_col_10_tvbi),
                         .TMASK (tcam_row_0_col_10_tmask),
                         .TWE (tcam_row_0_col_10_twe),
                         .TRE (tcam_row_0_col_10_tre),
                         .TME (tcam_row_0_col_10_tme),
                         .BIST_ROTATE_SR (tcam_row_0_col_10_bist_rotate_sr),
                         .BIST_EN_SR_MASK_B (tcam_row_0_col_10_bist_en_sr_mask_b),
                         .BIST_ALL_MASK (tcam_row_0_col_10_bist_all_mask),
                         .BIST_EN_SR_DATA_B (tcam_row_0_col_10_bist_en_sr_data_b),
                         .BIST_CM_MODE (tcam_row_0_col_10_bist_cm_mode),
                         .BIST_CM_EN_IN (tcam_row_0_col_10_bist_cm_en_in),
                         .BIST_CM_MATCH_SEL0 (tcam_row_0_col_10_bist_cm_match_sel0),
                         .BIST_CM_MATCH_SEL1 (tcam_row_0_col_10_bist_cm_match_sel1),
                         .BIST_MATCHIN_IN (tcam_row_0_col_10_bist_matchin_in),
                         .BIST_FLS (tcam_row_0_col_10_bist_fls),
                         .MDST_tcam (fuse_tcam), .BIST_SETUP(BIST_SETUP), .BIST_SETUP_ts1(BIST_SETUP_ts1), 
                        .BIST_SETUP_ts2(BIST_SETUP_ts2), .to_interfaces_tck(to_interfaces_tck), 
                        .mcp_bounding_to_en(mcp_bounding_to_en), .scan_to_en(scan_to_en), 
                        .memory_bypass_to_en(memory_bypass_to_en), 
                        .GO_ID_REG_SEL(GO_ID_REG_SEL), .BIST_CLEAR_BIRA(BIST_CLEAR_BIRA), 
                        .BIST_COLLAR_DIAG_EN(BIST_COLLAR_DIAG_EN), 
                        .BIST_COLLAR_BIRA_EN(BIST_COLLAR_BIRA_EN), 
                        .BIST_SHIFT_BIRA_COLLAR(BIST_SHIFT_BIRA_COLLAR), 
                        .CHECK_REPAIR_NEEDED(CHECK_REPAIR_NEEDED), 
                        .MEM1_BIST_COLLAR_SI(MEM1_BIST_COLLAR_SI), .BIST_SO(BIST_SO_ts1), 
                        .BIST_GO(BIST_GO_ts1), .ltest_to_en(ltest_to_en), 
                        .BIST_USER9(BIST_USER9), .BIST_USER10(BIST_USER10), 
                        .BIST_USER11(BIST_USER11), .BIST_USER0(BIST_USER0), 
                        .BIST_USER1(BIST_USER1), .BIST_USER2(BIST_USER2), 
                        .BIST_USER3(BIST_USER3), .BIST_USER4(BIST_USER4), 
                        .BIST_USER5(BIST_USER5), .BIST_USER6(BIST_USER6), 
                        .BIST_USER7(BIST_USER7), .BIST_USER8(BIST_USER8), 
                        .BIST_EVEN_GROUPWRITEENABLE(BIST_EVEN_GROUPWRITEENABLE), 
                        .BIST_ODD_GROUPWRITEENABLE(BIST_ODD_GROUPWRITEENABLE), 
                        .BIST_WRITEENABLE(BIST_WRITEENABLE), .BIST_READENABLE(BIST_READENABLE), 
                        .BIST_SELECT(BIST_SELECT), .BIST_CMP(BIST_CMP), 
                        .INCLUDE_MEM_RESULTS_REG(INCLUDE_MEM_RESULTS_REG), 
                        .BIST_COL_ADD(BIST_COL_ADD), .BIST_ROW_ADD(BIST_ROW_ADD[5:0]), 
                        .BIST_COLLAR_EN1(BIST_COLLAR_EN1), 
                        .BIST_RUN_TO_COLLAR1(BIST_RUN_TO_COLLAR1), 
                        .BIST_ASYNC_RESET(BIST_ASYNC_RESET), 
                        .BIST_TESTDATA_SELECT_TO_COLLAR(BIST_TESTDATA_SELECT_TO_COLLAR), 
                        .BIST_ON_TO_COLLAR(BIST_ON_TO_COLLAR), 
                        .BIST_WRITE_DATA(BIST_WRITE_DATA[31:0]), 
                        .BIST_EXPECT_DATA(BIST_EXPECT_DATA[31:0]), 
                        .BIST_SHIFT_COLLAR(BIST_SHIFT_COLLAR), 
                        .BIST_COLLAR_SETUP(BIST_COLLAR_SETUP), 
                        .BIST_CLEAR_DEFAULT(BIST_CLEAR_DEFAULT), .BIST_CLEAR(BIST_CLEAR), 
                        .BIST_COLLAR_OPSET_SELECT(BIST_COLLAR_OPSET_SELECT[1:0]), 
                        .BIST_COLLAR_HOLD(BIST_COLLAR_HOLD), 
                        .FREEZE_STOP_ERROR(FREEZE_STOP_ERROR), 
                        .ERROR_CNT_ZERO(ERROR_CNT_ZERO), 
                        .MBISTPG_RESET_REG_SETUP2(MBISTPG_RESET_REG_SETUP2), 
                        .BIST_BANK_ADD(BIST_BANK_ADD), .bisr_shift_en_pd_vinf(bisr_shift_en_pd_vinf), 
                        .bisr_clk_pd_vinf(bisr_clk_pd_vinf), 
                        .bisr_reset_pd_vinf(bisr_reset_pd_vinf), 
                        .tcam_row_0_col_0_bisr_inst_SO(tcam_row_0_col_0_bisr_inst_SO), 
                        .tcam_row_0_col_10_bisr_inst_SO(tcam_row_0_col_10_bisr_inst_SO), 
                        .fscan_clkungate(fscan_clkungate)
                     );
        
              end

              
            else
              begin : gen_tcam_row_0_col_10_bcam
              end
              
        
        
        endgenerate
        
        always_ff @(posedge clk) begin
                   tcam_rd_data_col[0][10]      <= tcam_row_0_col_10_data_out;
                   tcam_col_hit_out[0][10]       <= tcam_row_0_col_10_hit_out;
        end
        

        // this is new template - tcam_asic_template
        
        wire                                            tcam_row_0_col_11_clk         = clk;
        
        wire    [TCAM_SLICE_EN_FACT-1:0]                tcam_row_0_col_11_slice_en = TCAM_SLICE_EN_FACT'(slice_en[(0 * TCAM_SLICE_EN_FACT)+:TCAM_SLICE_EN_MIN]);
        
        wire                                            tcam_row_0_col_11_rd_en       = tcam_row_rd_en[0];
        wire                                            tcam_row_0_col_11_wr_en       = tcam_row_wr_en[0];
        wire                                            tcam_row_0_col_11_chk_en      = chk_en;
        wire                                            tcam_row_0_col_11_reset_n = reset_n;
        wire    [8-1:0]                       tcam_row_0_col_11_adr  = tcam_row_adr[0][8-1:0];
        wire    [32-1:0]                      tcam_row_0_col_11_data_in = tcam_row_wr_en[0] ? tcam_wr_data_col[11][32-1:0] : tcam_chk_key_col[11][32-1:0];
        wire    [32-1:0]                      tcam_row_0_col_11_data_in_pre = tcam_wr_data_col[11][32-1:0] ;
        wire    [32-1:0]                      tcam_row_0_col_11_key_in =  tcam_chk_key_col[11][32-1:0];
        wire    [32-1:0]                      tcam_row_0_col_11_mask_in = tcam_chk_mask_col[11][32-1:0];
        wire    [128-1:0]                       tcam_row_0_col_11_hit_in = tcam_raw_hit_in[0];
        wire    [128-1:0]                       tcam_row_0_col_11_tcam_match_in = tcam_row_match_in[0];
        wire    [32-1:0]                      tcam_row_0_col_11_data_out_inv;
        logic   [128-1:0]                     tcam_row_0_col_11_hit_out_int;
        logic   [128-1:0]                     tcam_row_0_col_11_hit_out_latch;
        logic   [128-1:0]                     tcam_row_0_col_11_hit_out;
        
        `ifdef CXP_DFX_DISABLE
        wire                          tcam_row_0_col_11_biste = 'b0; 
        wire     [5-1:0]                  tcam_row_0_col_11_fca = 'b0;
        wire                            tcam_row_0_col_11_cre = 'b0;
        wire                            tcam_row_0_col_11_dftshiften = 'b0;
        wire                            tcam_row_0_col_11_dftmask = 'b0;
        wire                            tcam_row_0_col_11_dft_array_freeze = 'b0;
        wire                            tcam_row_0_col_11_dft_afd_reset_b = 'b0;
        wire      [32-1:0]    tcam_row_0_col_11_tdin = 'b0;
        wire      [8-1:0]     tcam_row_0_col_11_tadr = 'b0;
        wire                            tcam_row_0_col_11_tvbe = 'b0;
        wire                            tcam_row_0_col_11_tvbi = 'b0;
        wire      [32-1:0]    tcam_row_0_col_11_tmask = 'b0;
        wire                            tcam_row_0_col_11_twe = 'b0;
        wire                            tcam_row_0_col_11_tre = 'b0;
        wire                            tcam_row_0_col_11_tme = 'b0;
        wire                            tcam_row_0_col_11_bist_rotate_sr = 'b0;
        wire                            tcam_row_0_col_11_bist_en_sr_mask_b = 'b0;
        wire                            tcam_row_0_col_11_bist_all_mask = 'b0;
        wire                            tcam_row_0_col_11_bist_en_sr_data_b = 'b0;
        wire                            tcam_row_0_col_11_bist_cm_mode = 'b0;
        wire                            tcam_row_0_col_11_bist_cm_en_in = 'b0;
        wire                            tcam_row_0_col_11_bist_cm_match_sel0 = 'b0;
        wire                            tcam_row_0_col_11_bist_cm_match_sel1 = 'b0;
        wire                            tcam_row_0_col_11_bist_matchin_in = 'b0;
        wire                            tcam_row_0_col_11_bist_fls = 'b0;
        
        `else
        wire                            tcam_row_0_col_11_biste = 'b0;
        wire     [5-1:0]                  tcam_row_0_col_11_fca = 'b0;
        wire                            tcam_row_0_col_11_cre = 'b0;
        wire                            tcam_row_0_col_11_dftshiften = dftshiften;
        wire                            tcam_row_0_col_11_dftmask = dftmask;
        wire                            tcam_row_0_col_11_dft_array_freeze = dft_array_freeze;
        wire                            tcam_row_0_col_11_dft_afd_reset_b = dft_afd_reset_b;
        wire      [32-1:0]    tcam_row_0_col_11_tdin = 'b0;
        wire      [8-1:0]     tcam_row_0_col_11_tadr = 'b0;
        wire                            tcam_row_0_col_11_tvbe = 'b0;
        wire                            tcam_row_0_col_11_tvbi = 'b0;
        wire      [32-1:0]    tcam_row_0_col_11_tmask = 'b0;
        wire                            tcam_row_0_col_11_twe = 'b0;
        wire                            tcam_row_0_col_11_tre = 'b0;
        wire                            tcam_row_0_col_11_tme = 'b0;
        wire                            tcam_row_0_col_11_bist_rotate_sr = 'b0;
        wire                            tcam_row_0_col_11_bist_en_sr_mask_b = 'b0;
        wire                            tcam_row_0_col_11_bist_all_mask = 'b0;
        wire                            tcam_row_0_col_11_bist_en_sr_data_b = 'b0;
        wire                            tcam_row_0_col_11_bist_cm_mode = 'b0;
        wire                            tcam_row_0_col_11_bist_cm_en_in = 'b0;
        wire                            tcam_row_0_col_11_bist_cm_match_sel0 = 'b0;
        wire                            tcam_row_0_col_11_bist_cm_match_sel1 = 'b0;
        wire                            tcam_row_0_col_11_bist_matchin_in = 'b0;
        wire                            tcam_row_0_col_11_bist_fls = 'b0;
        `endif
        
        // Outputs
        logic                           tcam_row_0_col_11_wr_bira_fail;
        logic                           tcam_row_0_col_11_wr_so;
        logic                           tcam_row_0_col_11_curerrout;
        logic                           tcam_row_0_col_11_rscout;
        
        
        
        logic   [TCAM_SLICE_EN_FACT-1:0]                  tcam_row_0_col_11_slice_en_s0; 
        logic   [TCAM_SLICE_EN_FACT-1:0]                  tcam_row_0_col_11_slice_en_s1; 
        
        
        
             wire    [32-1:0]                     tcam_row_0_col_11_data_out ;
        
        
        
         generate
            if (BCAM_N7 == 0) 
              begin : gen_tcam_row_0_col_11_tcam
        
        
        // slice_en kept for TCAM only for backward compatability with Intel process
                always_comb 
                begin
                  for (int i = 0; i < TCAM_SLICE_EN_FACT; i++)
                      if (tcam_row_0_col_11_slice_en_s1[i])
                           tcam_row_0_col_11_hit_out[ i*64 +: 64]  = tcam_row_0_col_11_hit_out_int  [ i*64 +: 64]; 
                      else
                           tcam_row_0_col_11_hit_out[ i*64 +: 64]  = tcam_row_0_col_11_hit_out_latch[ i*64 +: 64]; 
                end
        
        
        
                always_ff  @(posedge tcam_row_0_col_11_clk)
                begin
                  tcam_row_0_col_11_slice_en_s0 <= tcam_row_0_col_11_slice_en; 
                  tcam_row_0_col_11_slice_en_s1 <= tcam_row_0_col_11_slice_en_s0; 
        
                  for (int i = 0; i < TCAM_SLICE_EN_FACT; i++)
                    begin
                      if (tcam_row_0_col_11_slice_en_s1[i])
                         tcam_row_0_col_11_hit_out_latch[ i*64 +: 64] <=  tcam_row_0_col_11_hit_out_int[ i*64 +: 64];
                    end
                end
        
        
        
        // NEW TCAM symbol 
        //                              _____________________________
        //                             |                             |
        //                         ----|ADRi                         |
        //                         ----|Di                           |
        //                         ----|RE                           |
        //                         ----|WE                           |
        //                         ----|ME                           |
        //                         ----|MASKi                        |
        //                         ----|DSEL                         |
        //                         ----|VBE                          |
        //                         ----|VBI                          |
        //                         ----|CMP                          |
        //                         ----|RVLDi                        |
        //                         ----|RST                          |
        //                         ----|FLS                          |
        //                         ----|CLK                          |
        //                         ----|FAF_EN                       |
        //                         ----|FAFi                         |
        //                             |                           Qi|---
        //                             |                         QVLD|---
        //                             |                         QHIT|---
        //                         ----|MDST_tcam                    |
        //                             |                         QHRi|---
        //                         ----|DFTSHIFTEN                   |
        //                         ----|DFTMASK                      |
        //                         ----|DFT_ARRAY_FREEZE             |
        //                         ----|DFT_AFD_RESET_B              |
        //                             |_____________________________|
        
                     
                         assign tcam_row_0_col_11_data_out  = ~tcam_row_0_col_11_data_out_inv;
                         wcm_ip783tcam128x32s0c1_0_11_wrap #(        
                                 )               
        
                                 ip783tcam128x32s0c1_wrap_tcam_row_0_col_11 (
                   //-------------------------------------------------------------
                   // Power Management Interfaces
                   //-------------------------------------------------------------   
                      `ifndef INTEL_NO_PWR_PINS
                      `ifdef INTC_ADD_VSS
                        .vss              (1'b0),
                      `endif
                        .vddp             (1'b1),
                      `endif
                         .ADR               (tcam_row_0_col_11_adr[8-1:1]), //Input adr_intess
                         .ME                (ce),  
        
                         .CLK               (tcam_row_0_col_11_clk), //Clock
                         .CMP               (tcam_row_0_col_11_chk_en), //Control Enable
                         .DIN               (~tcam_row_0_col_11_data_in), 
                         .DSEL              (~tcam_row_0_col_11_adr[0]), //dncen enables access of the TCAM Arrays adr_intessed
                         .FLS               (flush), //flush initiates a Flush operation that resets all Valid
                         .RVLD              (tcam_row_0_col_11_hit_in ), //Row validation bus. Each match_in input controls 1
                         .MASK              (tcam_row_0_col_11_mask_in), //Input msk
                         .QOUT              (tcam_row_0_col_11_data_out_inv), //Output vben
                         .QHR               (tcam_row_0_col_11_hit_out_int),
                         .QVLD              (), 
                         .RE                (tcam_row_0_col_11_rd_en), //Read Enable
                         .RST               (tcam_row_0_col_11_reset_n), //Asynchronous Active-High Reset
                         .VBE               (1'b1), //vben enables the Valid Bit addressed by adr[a-1:0] to
                         .VBI               (1'b0),//  Valid Bit Input
                         .WE                (tcam_row_0_col_11_wr_en), //Write Enable
                         .FAF               (tcam_row_0_col_11_fca),
                         .FAF_EN            (tcam_row_0_col_11_cre),
                         .DFTSHIFTEN        (tcam_row_0_col_11_dftshiften),
                         .DFTMASK           (tcam_row_0_col_11_dftmask),
                         .DFT_ARRAY_FREEZE  (tcam_row_0_col_11_dft_array_freeze),
                         .DFT_AFD_RESET_B   (tcam_row_0_col_11_dft_afd_reset_b),
                         .BISTE           (tcam_row_0_col_11_biste),
                         .TDIN (tcam_row_0_col_11_tdin),
                         .TADR (tcam_row_0_col_11_tadr),
                         .TVBE (tcam_row_0_col_11_tvbe),
                         .TVBI (tcam_row_0_col_11_tvbi),
                         .TMASK (tcam_row_0_col_11_tmask),
                         .TWE (tcam_row_0_col_11_twe),
                         .TRE (tcam_row_0_col_11_tre),
                         .TME (tcam_row_0_col_11_tme),
                         .BIST_ROTATE_SR (tcam_row_0_col_11_bist_rotate_sr),
                         .BIST_EN_SR_MASK_B (tcam_row_0_col_11_bist_en_sr_mask_b),
                         .BIST_ALL_MASK (tcam_row_0_col_11_bist_all_mask),
                         .BIST_EN_SR_DATA_B (tcam_row_0_col_11_bist_en_sr_data_b),
                         .BIST_CM_MODE (tcam_row_0_col_11_bist_cm_mode),
                         .BIST_CM_EN_IN (tcam_row_0_col_11_bist_cm_en_in),
                         .BIST_CM_MATCH_SEL0 (tcam_row_0_col_11_bist_cm_match_sel0),
                         .BIST_CM_MATCH_SEL1 (tcam_row_0_col_11_bist_cm_match_sel1),
                         .BIST_MATCHIN_IN (tcam_row_0_col_11_bist_matchin_in),
                         .BIST_FLS (tcam_row_0_col_11_bist_fls),
                         .MDST_tcam (fuse_tcam), .BIST_SETUP(BIST_SETUP), .BIST_SETUP_ts1(BIST_SETUP_ts1), 
                        .BIST_SETUP_ts2(BIST_SETUP_ts2), .to_interfaces_tck(to_interfaces_tck), 
                        .mcp_bounding_to_en(mcp_bounding_to_en), .scan_to_en(scan_to_en), 
                        .memory_bypass_to_en(memory_bypass_to_en), 
                        .GO_ID_REG_SEL(GO_ID_REG_SEL), .BIST_CLEAR_BIRA(BIST_CLEAR_BIRA), 
                        .BIST_COLLAR_DIAG_EN(BIST_COLLAR_DIAG_EN), 
                        .BIST_COLLAR_BIRA_EN(BIST_COLLAR_BIRA_EN), 
                        .BIST_SHIFT_BIRA_COLLAR(BIST_SHIFT_BIRA_COLLAR), 
                        .CHECK_REPAIR_NEEDED(CHECK_REPAIR_NEEDED), 
                        .MEM2_BIST_COLLAR_SI(MEM2_BIST_COLLAR_SI), .BIST_SO(BIST_SO_ts2), 
                        .BIST_GO(BIST_GO_ts2), .ltest_to_en(ltest_to_en), 
                        .BIST_USER9(BIST_USER9), .BIST_USER10(BIST_USER10), 
                        .BIST_USER11(BIST_USER11), .BIST_USER0(BIST_USER0), 
                        .BIST_USER1(BIST_USER1), .BIST_USER2(BIST_USER2), 
                        .BIST_USER3(BIST_USER3), .BIST_USER4(BIST_USER4), 
                        .BIST_USER5(BIST_USER5), .BIST_USER6(BIST_USER6), 
                        .BIST_USER7(BIST_USER7), .BIST_USER8(BIST_USER8), 
                        .BIST_EVEN_GROUPWRITEENABLE(BIST_EVEN_GROUPWRITEENABLE), 
                        .BIST_ODD_GROUPWRITEENABLE(BIST_ODD_GROUPWRITEENABLE), 
                        .BIST_WRITEENABLE(BIST_WRITEENABLE), .BIST_READENABLE(BIST_READENABLE), 
                        .BIST_SELECT(BIST_SELECT), .BIST_CMP(BIST_CMP), 
                        .INCLUDE_MEM_RESULTS_REG(INCLUDE_MEM_RESULTS_REG), 
                        .BIST_COL_ADD(BIST_COL_ADD), .BIST_ROW_ADD(BIST_ROW_ADD[5:0]), 
                        .BIST_COLLAR_EN2(BIST_COLLAR_EN2), 
                        .BIST_RUN_TO_COLLAR2(BIST_RUN_TO_COLLAR2), 
                        .BIST_ASYNC_RESET(BIST_ASYNC_RESET), 
                        .BIST_TESTDATA_SELECT_TO_COLLAR(BIST_TESTDATA_SELECT_TO_COLLAR), 
                        .BIST_ON_TO_COLLAR(BIST_ON_TO_COLLAR), 
                        .BIST_WRITE_DATA(BIST_WRITE_DATA[31:0]), 
                        .BIST_EXPECT_DATA(BIST_EXPECT_DATA[31:0]), 
                        .BIST_SHIFT_COLLAR(BIST_SHIFT_COLLAR), 
                        .BIST_COLLAR_SETUP(BIST_COLLAR_SETUP), 
                        .BIST_CLEAR_DEFAULT(BIST_CLEAR_DEFAULT), .BIST_CLEAR(BIST_CLEAR), 
                        .BIST_COLLAR_OPSET_SELECT(BIST_COLLAR_OPSET_SELECT[1:0]), 
                        .BIST_COLLAR_HOLD(BIST_COLLAR_HOLD), 
                        .FREEZE_STOP_ERROR(FREEZE_STOP_ERROR), 
                        .ERROR_CNT_ZERO(ERROR_CNT_ZERO), 
                        .MBISTPG_RESET_REG_SETUP2(MBISTPG_RESET_REG_SETUP2), 
                        .BIST_BANK_ADD(BIST_BANK_ADD), .bisr_shift_en_pd_vinf(bisr_shift_en_pd_vinf), 
                        .bisr_clk_pd_vinf(bisr_clk_pd_vinf), 
                        .bisr_reset_pd_vinf(bisr_reset_pd_vinf), 
                        .tcam_row_0_col_10_bisr_inst_SO(tcam_row_0_col_10_bisr_inst_SO), 
                        .tcam_row_0_col_11_bisr_inst_SO(tcam_row_0_col_11_bisr_inst_SO), 
                        .fscan_clkungate(fscan_clkungate)
                     );
        
              end

              
            else
              begin : gen_tcam_row_0_col_11_bcam
              end
              
        
        
        endgenerate
        
        always_ff @(posedge clk) begin
                   tcam_rd_data_col[0][11]      <= tcam_row_0_col_11_data_out;
                   tcam_col_hit_out[0][11]       <= tcam_row_0_col_11_hit_out;
        end
        

        // this is new template - tcam_asic_template
        
        wire                                            tcam_row_0_col_12_clk         = clk;
        
        wire    [TCAM_SLICE_EN_FACT-1:0]                tcam_row_0_col_12_slice_en = TCAM_SLICE_EN_FACT'(slice_en[(0 * TCAM_SLICE_EN_FACT)+:TCAM_SLICE_EN_MIN]);
        
        wire                                            tcam_row_0_col_12_rd_en       = tcam_row_rd_en[0];
        wire                                            tcam_row_0_col_12_wr_en       = tcam_row_wr_en[0];
        wire                                            tcam_row_0_col_12_chk_en      = chk_en;
        wire                                            tcam_row_0_col_12_reset_n = reset_n;
        wire    [8-1:0]                       tcam_row_0_col_12_adr  = tcam_row_adr[0][8-1:0];
        wire    [32-1:0]                      tcam_row_0_col_12_data_in = tcam_row_wr_en[0] ? tcam_wr_data_col[12][32-1:0] : tcam_chk_key_col[12][32-1:0];
        wire    [32-1:0]                      tcam_row_0_col_12_data_in_pre = tcam_wr_data_col[12][32-1:0] ;
        wire    [32-1:0]                      tcam_row_0_col_12_key_in =  tcam_chk_key_col[12][32-1:0];
        wire    [32-1:0]                      tcam_row_0_col_12_mask_in = tcam_chk_mask_col[12][32-1:0];
        wire    [128-1:0]                       tcam_row_0_col_12_hit_in = tcam_raw_hit_in[0];
        wire    [128-1:0]                       tcam_row_0_col_12_tcam_match_in = tcam_row_match_in[0];
        wire    [32-1:0]                      tcam_row_0_col_12_data_out_inv;
        logic   [128-1:0]                     tcam_row_0_col_12_hit_out_int;
        logic   [128-1:0]                     tcam_row_0_col_12_hit_out_latch;
        logic   [128-1:0]                     tcam_row_0_col_12_hit_out;
        
        `ifdef CXP_DFX_DISABLE
        wire                          tcam_row_0_col_12_biste = 'b0; 
        wire     [5-1:0]                  tcam_row_0_col_12_fca = 'b0;
        wire                            tcam_row_0_col_12_cre = 'b0;
        wire                            tcam_row_0_col_12_dftshiften = 'b0;
        wire                            tcam_row_0_col_12_dftmask = 'b0;
        wire                            tcam_row_0_col_12_dft_array_freeze = 'b0;
        wire                            tcam_row_0_col_12_dft_afd_reset_b = 'b0;
        wire      [32-1:0]    tcam_row_0_col_12_tdin = 'b0;
        wire      [8-1:0]     tcam_row_0_col_12_tadr = 'b0;
        wire                            tcam_row_0_col_12_tvbe = 'b0;
        wire                            tcam_row_0_col_12_tvbi = 'b0;
        wire      [32-1:0]    tcam_row_0_col_12_tmask = 'b0;
        wire                            tcam_row_0_col_12_twe = 'b0;
        wire                            tcam_row_0_col_12_tre = 'b0;
        wire                            tcam_row_0_col_12_tme = 'b0;
        wire                            tcam_row_0_col_12_bist_rotate_sr = 'b0;
        wire                            tcam_row_0_col_12_bist_en_sr_mask_b = 'b0;
        wire                            tcam_row_0_col_12_bist_all_mask = 'b0;
        wire                            tcam_row_0_col_12_bist_en_sr_data_b = 'b0;
        wire                            tcam_row_0_col_12_bist_cm_mode = 'b0;
        wire                            tcam_row_0_col_12_bist_cm_en_in = 'b0;
        wire                            tcam_row_0_col_12_bist_cm_match_sel0 = 'b0;
        wire                            tcam_row_0_col_12_bist_cm_match_sel1 = 'b0;
        wire                            tcam_row_0_col_12_bist_matchin_in = 'b0;
        wire                            tcam_row_0_col_12_bist_fls = 'b0;
        
        `else
        wire                            tcam_row_0_col_12_biste = 'b0;
        wire     [5-1:0]                  tcam_row_0_col_12_fca = 'b0;
        wire                            tcam_row_0_col_12_cre = 'b0;
        wire                            tcam_row_0_col_12_dftshiften = dftshiften;
        wire                            tcam_row_0_col_12_dftmask = dftmask;
        wire                            tcam_row_0_col_12_dft_array_freeze = dft_array_freeze;
        wire                            tcam_row_0_col_12_dft_afd_reset_b = dft_afd_reset_b;
        wire      [32-1:0]    tcam_row_0_col_12_tdin = 'b0;
        wire      [8-1:0]     tcam_row_0_col_12_tadr = 'b0;
        wire                            tcam_row_0_col_12_tvbe = 'b0;
        wire                            tcam_row_0_col_12_tvbi = 'b0;
        wire      [32-1:0]    tcam_row_0_col_12_tmask = 'b0;
        wire                            tcam_row_0_col_12_twe = 'b0;
        wire                            tcam_row_0_col_12_tre = 'b0;
        wire                            tcam_row_0_col_12_tme = 'b0;
        wire                            tcam_row_0_col_12_bist_rotate_sr = 'b0;
        wire                            tcam_row_0_col_12_bist_en_sr_mask_b = 'b0;
        wire                            tcam_row_0_col_12_bist_all_mask = 'b0;
        wire                            tcam_row_0_col_12_bist_en_sr_data_b = 'b0;
        wire                            tcam_row_0_col_12_bist_cm_mode = 'b0;
        wire                            tcam_row_0_col_12_bist_cm_en_in = 'b0;
        wire                            tcam_row_0_col_12_bist_cm_match_sel0 = 'b0;
        wire                            tcam_row_0_col_12_bist_cm_match_sel1 = 'b0;
        wire                            tcam_row_0_col_12_bist_matchin_in = 'b0;
        wire                            tcam_row_0_col_12_bist_fls = 'b0;
        `endif
        
        // Outputs
        logic                           tcam_row_0_col_12_wr_bira_fail;
        logic                           tcam_row_0_col_12_wr_so;
        logic                           tcam_row_0_col_12_curerrout;
        logic                           tcam_row_0_col_12_rscout;
        
        
        
        logic   [TCAM_SLICE_EN_FACT-1:0]                  tcam_row_0_col_12_slice_en_s0; 
        logic   [TCAM_SLICE_EN_FACT-1:0]                  tcam_row_0_col_12_slice_en_s1; 
        
        
        
             wire    [32-1:0]                     tcam_row_0_col_12_data_out ;
        
        
        
         generate
            if (BCAM_N7 == 0) 
              begin : gen_tcam_row_0_col_12_tcam
        
        
        // slice_en kept for TCAM only for backward compatability with Intel process
                always_comb 
                begin
                  for (int i = 0; i < TCAM_SLICE_EN_FACT; i++)
                      if (tcam_row_0_col_12_slice_en_s1[i])
                           tcam_row_0_col_12_hit_out[ i*64 +: 64]  = tcam_row_0_col_12_hit_out_int  [ i*64 +: 64]; 
                      else
                           tcam_row_0_col_12_hit_out[ i*64 +: 64]  = tcam_row_0_col_12_hit_out_latch[ i*64 +: 64]; 
                end
        
        
        
                always_ff  @(posedge tcam_row_0_col_12_clk)
                begin
                  tcam_row_0_col_12_slice_en_s0 <= tcam_row_0_col_12_slice_en; 
                  tcam_row_0_col_12_slice_en_s1 <= tcam_row_0_col_12_slice_en_s0; 
        
                  for (int i = 0; i < TCAM_SLICE_EN_FACT; i++)
                    begin
                      if (tcam_row_0_col_12_slice_en_s1[i])
                         tcam_row_0_col_12_hit_out_latch[ i*64 +: 64] <=  tcam_row_0_col_12_hit_out_int[ i*64 +: 64];
                    end
                end
        
        
        
        // NEW TCAM symbol 
        //                              _____________________________
        //                             |                             |
        //                         ----|ADRi                         |
        //                         ----|Di                           |
        //                         ----|RE                           |
        //                         ----|WE                           |
        //                         ----|ME                           |
        //                         ----|MASKi                        |
        //                         ----|DSEL                         |
        //                         ----|VBE                          |
        //                         ----|VBI                          |
        //                         ----|CMP                          |
        //                         ----|RVLDi                        |
        //                         ----|RST                          |
        //                         ----|FLS                          |
        //                         ----|CLK                          |
        //                         ----|FAF_EN                       |
        //                         ----|FAFi                         |
        //                             |                           Qi|---
        //                             |                         QVLD|---
        //                             |                         QHIT|---
        //                         ----|MDST_tcam                    |
        //                             |                         QHRi|---
        //                         ----|DFTSHIFTEN                   |
        //                         ----|DFTMASK                      |
        //                         ----|DFT_ARRAY_FREEZE             |
        //                         ----|DFT_AFD_RESET_B              |
        //                             |_____________________________|
        
                     
                         assign tcam_row_0_col_12_data_out  = ~tcam_row_0_col_12_data_out_inv;
                         wcm_ip783tcam128x32s0c1_0_12_wrap #(        
                                 )               
        
                                 ip783tcam128x32s0c1_wrap_tcam_row_0_col_12 (
                   //-------------------------------------------------------------
                   // Power Management Interfaces
                   //-------------------------------------------------------------   
                      `ifndef INTEL_NO_PWR_PINS
                      `ifdef INTC_ADD_VSS
                        .vss              (1'b0),
                      `endif
                        .vddp             (1'b1),
                      `endif
                         .ADR               (tcam_row_0_col_12_adr[8-1:1]), //Input adr_intess
                         .ME                (ce),  
        
                         .CLK               (tcam_row_0_col_12_clk), //Clock
                         .CMP               (tcam_row_0_col_12_chk_en), //Control Enable
                         .DIN               (~tcam_row_0_col_12_data_in), 
                         .DSEL              (~tcam_row_0_col_12_adr[0]), //dncen enables access of the TCAM Arrays adr_intessed
                         .FLS               (flush), //flush initiates a Flush operation that resets all Valid
                         .RVLD              (tcam_row_0_col_12_hit_in ), //Row validation bus. Each match_in input controls 1
                         .MASK              (tcam_row_0_col_12_mask_in), //Input msk
                         .QOUT              (tcam_row_0_col_12_data_out_inv), //Output vben
                         .QHR               (tcam_row_0_col_12_hit_out_int),
                         .QVLD              (), 
                         .RE                (tcam_row_0_col_12_rd_en), //Read Enable
                         .RST               (tcam_row_0_col_12_reset_n), //Asynchronous Active-High Reset
                         .VBE               (1'b1), //vben enables the Valid Bit addressed by adr[a-1:0] to
                         .VBI               (1'b0),//  Valid Bit Input
                         .WE                (tcam_row_0_col_12_wr_en), //Write Enable
                         .FAF               (tcam_row_0_col_12_fca),
                         .FAF_EN            (tcam_row_0_col_12_cre),
                         .DFTSHIFTEN        (tcam_row_0_col_12_dftshiften),
                         .DFTMASK           (tcam_row_0_col_12_dftmask),
                         .DFT_ARRAY_FREEZE  (tcam_row_0_col_12_dft_array_freeze),
                         .DFT_AFD_RESET_B   (tcam_row_0_col_12_dft_afd_reset_b),
                         .BISTE           (tcam_row_0_col_12_biste),
                         .TDIN (tcam_row_0_col_12_tdin),
                         .TADR (tcam_row_0_col_12_tadr),
                         .TVBE (tcam_row_0_col_12_tvbe),
                         .TVBI (tcam_row_0_col_12_tvbi),
                         .TMASK (tcam_row_0_col_12_tmask),
                         .TWE (tcam_row_0_col_12_twe),
                         .TRE (tcam_row_0_col_12_tre),
                         .TME (tcam_row_0_col_12_tme),
                         .BIST_ROTATE_SR (tcam_row_0_col_12_bist_rotate_sr),
                         .BIST_EN_SR_MASK_B (tcam_row_0_col_12_bist_en_sr_mask_b),
                         .BIST_ALL_MASK (tcam_row_0_col_12_bist_all_mask),
                         .BIST_EN_SR_DATA_B (tcam_row_0_col_12_bist_en_sr_data_b),
                         .BIST_CM_MODE (tcam_row_0_col_12_bist_cm_mode),
                         .BIST_CM_EN_IN (tcam_row_0_col_12_bist_cm_en_in),
                         .BIST_CM_MATCH_SEL0 (tcam_row_0_col_12_bist_cm_match_sel0),
                         .BIST_CM_MATCH_SEL1 (tcam_row_0_col_12_bist_cm_match_sel1),
                         .BIST_MATCHIN_IN (tcam_row_0_col_12_bist_matchin_in),
                         .BIST_FLS (tcam_row_0_col_12_bist_fls),
                         .MDST_tcam (fuse_tcam), .BIST_SETUP(BIST_SETUP), .BIST_SETUP_ts1(BIST_SETUP_ts1), 
                        .BIST_SETUP_ts2(BIST_SETUP_ts2), .to_interfaces_tck(to_interfaces_tck), 
                        .mcp_bounding_to_en(mcp_bounding_to_en), .scan_to_en(scan_to_en), 
                        .memory_bypass_to_en(memory_bypass_to_en), 
                        .GO_ID_REG_SEL(GO_ID_REG_SEL), .BIST_CLEAR_BIRA(BIST_CLEAR_BIRA), 
                        .BIST_COLLAR_DIAG_EN(BIST_COLLAR_DIAG_EN), 
                        .BIST_COLLAR_BIRA_EN(BIST_COLLAR_BIRA_EN), 
                        .BIST_SHIFT_BIRA_COLLAR(BIST_SHIFT_BIRA_COLLAR), 
                        .CHECK_REPAIR_NEEDED(CHECK_REPAIR_NEEDED), 
                        .MEM3_BIST_COLLAR_SI(MEM3_BIST_COLLAR_SI), .BIST_SO(BIST_SO_ts3), 
                        .BIST_GO(BIST_GO_ts3), .ltest_to_en(ltest_to_en), 
                        .BIST_USER9(BIST_USER9), .BIST_USER10(BIST_USER10), 
                        .BIST_USER11(BIST_USER11), .BIST_USER0(BIST_USER0), 
                        .BIST_USER1(BIST_USER1), .BIST_USER2(BIST_USER2), 
                        .BIST_USER3(BIST_USER3), .BIST_USER4(BIST_USER4), 
                        .BIST_USER5(BIST_USER5), .BIST_USER6(BIST_USER6), 
                        .BIST_USER7(BIST_USER7), .BIST_USER8(BIST_USER8), 
                        .BIST_EVEN_GROUPWRITEENABLE(BIST_EVEN_GROUPWRITEENABLE), 
                        .BIST_ODD_GROUPWRITEENABLE(BIST_ODD_GROUPWRITEENABLE), 
                        .BIST_WRITEENABLE(BIST_WRITEENABLE), .BIST_READENABLE(BIST_READENABLE), 
                        .BIST_SELECT(BIST_SELECT), .BIST_CMP(BIST_CMP), 
                        .INCLUDE_MEM_RESULTS_REG(INCLUDE_MEM_RESULTS_REG), 
                        .BIST_COL_ADD(BIST_COL_ADD), .BIST_ROW_ADD(BIST_ROW_ADD[5:0]), 
                        .BIST_COLLAR_EN3(BIST_COLLAR_EN3), 
                        .BIST_RUN_TO_COLLAR3(BIST_RUN_TO_COLLAR3), 
                        .BIST_ASYNC_RESET(BIST_ASYNC_RESET), 
                        .BIST_TESTDATA_SELECT_TO_COLLAR(BIST_TESTDATA_SELECT_TO_COLLAR), 
                        .BIST_ON_TO_COLLAR(BIST_ON_TO_COLLAR), 
                        .BIST_WRITE_DATA(BIST_WRITE_DATA[31:0]), 
                        .BIST_EXPECT_DATA(BIST_EXPECT_DATA[31:0]), 
                        .BIST_SHIFT_COLLAR(BIST_SHIFT_COLLAR), 
                        .BIST_COLLAR_SETUP(BIST_COLLAR_SETUP), 
                        .BIST_CLEAR_DEFAULT(BIST_CLEAR_DEFAULT), .BIST_CLEAR(BIST_CLEAR), 
                        .BIST_COLLAR_OPSET_SELECT(BIST_COLLAR_OPSET_SELECT[1:0]), 
                        .BIST_COLLAR_HOLD(BIST_COLLAR_HOLD), 
                        .FREEZE_STOP_ERROR(FREEZE_STOP_ERROR), 
                        .ERROR_CNT_ZERO(ERROR_CNT_ZERO), 
                        .MBISTPG_RESET_REG_SETUP2(MBISTPG_RESET_REG_SETUP2), 
                        .BIST_BANK_ADD(BIST_BANK_ADD), .bisr_shift_en_pd_vinf(bisr_shift_en_pd_vinf), 
                        .bisr_clk_pd_vinf(bisr_clk_pd_vinf), 
                        .bisr_reset_pd_vinf(bisr_reset_pd_vinf), 
                        .tcam_row_0_col_11_bisr_inst_SO(tcam_row_0_col_11_bisr_inst_SO), 
                        .tcam_row_0_col_12_bisr_inst_SO(tcam_row_0_col_12_bisr_inst_SO), 
                        .fscan_clkungate(fscan_clkungate)
                     );
        
              end

              
            else
              begin : gen_tcam_row_0_col_12_bcam
              end
              
        
        
        endgenerate
        
        always_ff @(posedge clk) begin
                   tcam_rd_data_col[0][12]      <= tcam_row_0_col_12_data_out;
                   tcam_col_hit_out[0][12]       <= tcam_row_0_col_12_hit_out;
        end
        

        // this is new template - tcam_asic_template
        
        wire                                            tcam_row_0_col_13_clk         = clk;
        
        wire    [TCAM_SLICE_EN_FACT-1:0]                tcam_row_0_col_13_slice_en = TCAM_SLICE_EN_FACT'(slice_en[(0 * TCAM_SLICE_EN_FACT)+:TCAM_SLICE_EN_MIN]);
        
        wire                                            tcam_row_0_col_13_rd_en       = tcam_row_rd_en[0];
        wire                                            tcam_row_0_col_13_wr_en       = tcam_row_wr_en[0];
        wire                                            tcam_row_0_col_13_chk_en      = chk_en;
        wire                                            tcam_row_0_col_13_reset_n = reset_n;
        wire    [8-1:0]                       tcam_row_0_col_13_adr  = tcam_row_adr[0][8-1:0];
        wire    [32-1:0]                      tcam_row_0_col_13_data_in = tcam_row_wr_en[0] ? tcam_wr_data_col[13][32-1:0] : tcam_chk_key_col[13][32-1:0];
        wire    [32-1:0]                      tcam_row_0_col_13_data_in_pre = tcam_wr_data_col[13][32-1:0] ;
        wire    [32-1:0]                      tcam_row_0_col_13_key_in =  tcam_chk_key_col[13][32-1:0];
        wire    [32-1:0]                      tcam_row_0_col_13_mask_in = tcam_chk_mask_col[13][32-1:0];
        wire    [128-1:0]                       tcam_row_0_col_13_hit_in = tcam_raw_hit_in[0];
        wire    [128-1:0]                       tcam_row_0_col_13_tcam_match_in = tcam_row_match_in[0];
        wire    [32-1:0]                      tcam_row_0_col_13_data_out_inv;
        logic   [128-1:0]                     tcam_row_0_col_13_hit_out_int;
        logic   [128-1:0]                     tcam_row_0_col_13_hit_out_latch;
        logic   [128-1:0]                     tcam_row_0_col_13_hit_out;
        
        `ifdef CXP_DFX_DISABLE
        wire                          tcam_row_0_col_13_biste = 'b0; 
        wire     [5-1:0]                  tcam_row_0_col_13_fca = 'b0;
        wire                            tcam_row_0_col_13_cre = 'b0;
        wire                            tcam_row_0_col_13_dftshiften = 'b0;
        wire                            tcam_row_0_col_13_dftmask = 'b0;
        wire                            tcam_row_0_col_13_dft_array_freeze = 'b0;
        wire                            tcam_row_0_col_13_dft_afd_reset_b = 'b0;
        wire      [32-1:0]    tcam_row_0_col_13_tdin = 'b0;
        wire      [8-1:0]     tcam_row_0_col_13_tadr = 'b0;
        wire                            tcam_row_0_col_13_tvbe = 'b0;
        wire                            tcam_row_0_col_13_tvbi = 'b0;
        wire      [32-1:0]    tcam_row_0_col_13_tmask = 'b0;
        wire                            tcam_row_0_col_13_twe = 'b0;
        wire                            tcam_row_0_col_13_tre = 'b0;
        wire                            tcam_row_0_col_13_tme = 'b0;
        wire                            tcam_row_0_col_13_bist_rotate_sr = 'b0;
        wire                            tcam_row_0_col_13_bist_en_sr_mask_b = 'b0;
        wire                            tcam_row_0_col_13_bist_all_mask = 'b0;
        wire                            tcam_row_0_col_13_bist_en_sr_data_b = 'b0;
        wire                            tcam_row_0_col_13_bist_cm_mode = 'b0;
        wire                            tcam_row_0_col_13_bist_cm_en_in = 'b0;
        wire                            tcam_row_0_col_13_bist_cm_match_sel0 = 'b0;
        wire                            tcam_row_0_col_13_bist_cm_match_sel1 = 'b0;
        wire                            tcam_row_0_col_13_bist_matchin_in = 'b0;
        wire                            tcam_row_0_col_13_bist_fls = 'b0;
        
        `else
        wire                            tcam_row_0_col_13_biste = 'b0;
        wire     [5-1:0]                  tcam_row_0_col_13_fca = 'b0;
        wire                            tcam_row_0_col_13_cre = 'b0;
        wire                            tcam_row_0_col_13_dftshiften = dftshiften;
        wire                            tcam_row_0_col_13_dftmask = dftmask;
        wire                            tcam_row_0_col_13_dft_array_freeze = dft_array_freeze;
        wire                            tcam_row_0_col_13_dft_afd_reset_b = dft_afd_reset_b;
        wire      [32-1:0]    tcam_row_0_col_13_tdin = 'b0;
        wire      [8-1:0]     tcam_row_0_col_13_tadr = 'b0;
        wire                            tcam_row_0_col_13_tvbe = 'b0;
        wire                            tcam_row_0_col_13_tvbi = 'b0;
        wire      [32-1:0]    tcam_row_0_col_13_tmask = 'b0;
        wire                            tcam_row_0_col_13_twe = 'b0;
        wire                            tcam_row_0_col_13_tre = 'b0;
        wire                            tcam_row_0_col_13_tme = 'b0;
        wire                            tcam_row_0_col_13_bist_rotate_sr = 'b0;
        wire                            tcam_row_0_col_13_bist_en_sr_mask_b = 'b0;
        wire                            tcam_row_0_col_13_bist_all_mask = 'b0;
        wire                            tcam_row_0_col_13_bist_en_sr_data_b = 'b0;
        wire                            tcam_row_0_col_13_bist_cm_mode = 'b0;
        wire                            tcam_row_0_col_13_bist_cm_en_in = 'b0;
        wire                            tcam_row_0_col_13_bist_cm_match_sel0 = 'b0;
        wire                            tcam_row_0_col_13_bist_cm_match_sel1 = 'b0;
        wire                            tcam_row_0_col_13_bist_matchin_in = 'b0;
        wire                            tcam_row_0_col_13_bist_fls = 'b0;
        `endif
        
        // Outputs
        logic                           tcam_row_0_col_13_wr_bira_fail;
        logic                           tcam_row_0_col_13_wr_so;
        logic                           tcam_row_0_col_13_curerrout;
        logic                           tcam_row_0_col_13_rscout;
        
        
        
        logic   [TCAM_SLICE_EN_FACT-1:0]                  tcam_row_0_col_13_slice_en_s0; 
        logic   [TCAM_SLICE_EN_FACT-1:0]                  tcam_row_0_col_13_slice_en_s1; 
        
        
        
             wire    [32-1:0]                     tcam_row_0_col_13_data_out ;
        
        
        
         generate
            if (BCAM_N7 == 0) 
              begin : gen_tcam_row_0_col_13_tcam
        
        
        // slice_en kept for TCAM only for backward compatability with Intel process
                always_comb 
                begin
                  for (int i = 0; i < TCAM_SLICE_EN_FACT; i++)
                      if (tcam_row_0_col_13_slice_en_s1[i])
                           tcam_row_0_col_13_hit_out[ i*64 +: 64]  = tcam_row_0_col_13_hit_out_int  [ i*64 +: 64]; 
                      else
                           tcam_row_0_col_13_hit_out[ i*64 +: 64]  = tcam_row_0_col_13_hit_out_latch[ i*64 +: 64]; 
                end
        
        
        
                always_ff  @(posedge tcam_row_0_col_13_clk)
                begin
                  tcam_row_0_col_13_slice_en_s0 <= tcam_row_0_col_13_slice_en; 
                  tcam_row_0_col_13_slice_en_s1 <= tcam_row_0_col_13_slice_en_s0; 
        
                  for (int i = 0; i < TCAM_SLICE_EN_FACT; i++)
                    begin
                      if (tcam_row_0_col_13_slice_en_s1[i])
                         tcam_row_0_col_13_hit_out_latch[ i*64 +: 64] <=  tcam_row_0_col_13_hit_out_int[ i*64 +: 64];
                    end
                end
        
        
        
        // NEW TCAM symbol 
        //                              _____________________________
        //                             |                             |
        //                         ----|ADRi                         |
        //                         ----|Di                           |
        //                         ----|RE                           |
        //                         ----|WE                           |
        //                         ----|ME                           |
        //                         ----|MASKi                        |
        //                         ----|DSEL                         |
        //                         ----|VBE                          |
        //                         ----|VBI                          |
        //                         ----|CMP                          |
        //                         ----|RVLDi                        |
        //                         ----|RST                          |
        //                         ----|FLS                          |
        //                         ----|CLK                          |
        //                         ----|FAF_EN                       |
        //                         ----|FAFi                         |
        //                             |                           Qi|---
        //                             |                         QVLD|---
        //                             |                         QHIT|---
        //                         ----|MDST_tcam                    |
        //                             |                         QHRi|---
        //                         ----|DFTSHIFTEN                   |
        //                         ----|DFTMASK                      |
        //                         ----|DFT_ARRAY_FREEZE             |
        //                         ----|DFT_AFD_RESET_B              |
        //                             |_____________________________|
        
                     
                         assign tcam_row_0_col_13_data_out  = ~tcam_row_0_col_13_data_out_inv;
                         wcm_ip783tcam128x32s0c1_0_13_wrap #(        
                                 )               
        
                                 ip783tcam128x32s0c1_wrap_tcam_row_0_col_13 (
                   //-------------------------------------------------------------
                   // Power Management Interfaces
                   //-------------------------------------------------------------   
                      `ifndef INTEL_NO_PWR_PINS
                      `ifdef INTC_ADD_VSS
                        .vss              (1'b0),
                      `endif
                        .vddp             (1'b1),
                      `endif
                         .ADR               (tcam_row_0_col_13_adr[8-1:1]), //Input adr_intess
                         .ME                (ce),  
        
                         .CLK               (tcam_row_0_col_13_clk), //Clock
                         .CMP               (tcam_row_0_col_13_chk_en), //Control Enable
                         .DIN               (~tcam_row_0_col_13_data_in), 
                         .DSEL              (~tcam_row_0_col_13_adr[0]), //dncen enables access of the TCAM Arrays adr_intessed
                         .FLS               (flush), //flush initiates a Flush operation that resets all Valid
                         .RVLD              (tcam_row_0_col_13_hit_in ), //Row validation bus. Each match_in input controls 1
                         .MASK              (tcam_row_0_col_13_mask_in), //Input msk
                         .QOUT              (tcam_row_0_col_13_data_out_inv), //Output vben
                         .QHR               (tcam_row_0_col_13_hit_out_int),
                         .QVLD              (), 
                         .RE                (tcam_row_0_col_13_rd_en), //Read Enable
                         .RST               (tcam_row_0_col_13_reset_n), //Asynchronous Active-High Reset
                         .VBE               (1'b1), //vben enables the Valid Bit addressed by adr[a-1:0] to
                         .VBI               (1'b0),//  Valid Bit Input
                         .WE                (tcam_row_0_col_13_wr_en), //Write Enable
                         .FAF               (tcam_row_0_col_13_fca),
                         .FAF_EN            (tcam_row_0_col_13_cre),
                         .DFTSHIFTEN        (tcam_row_0_col_13_dftshiften),
                         .DFTMASK           (tcam_row_0_col_13_dftmask),
                         .DFT_ARRAY_FREEZE  (tcam_row_0_col_13_dft_array_freeze),
                         .DFT_AFD_RESET_B   (tcam_row_0_col_13_dft_afd_reset_b),
                         .BISTE           (tcam_row_0_col_13_biste),
                         .TDIN (tcam_row_0_col_13_tdin),
                         .TADR (tcam_row_0_col_13_tadr),
                         .TVBE (tcam_row_0_col_13_tvbe),
                         .TVBI (tcam_row_0_col_13_tvbi),
                         .TMASK (tcam_row_0_col_13_tmask),
                         .TWE (tcam_row_0_col_13_twe),
                         .TRE (tcam_row_0_col_13_tre),
                         .TME (tcam_row_0_col_13_tme),
                         .BIST_ROTATE_SR (tcam_row_0_col_13_bist_rotate_sr),
                         .BIST_EN_SR_MASK_B (tcam_row_0_col_13_bist_en_sr_mask_b),
                         .BIST_ALL_MASK (tcam_row_0_col_13_bist_all_mask),
                         .BIST_EN_SR_DATA_B (tcam_row_0_col_13_bist_en_sr_data_b),
                         .BIST_CM_MODE (tcam_row_0_col_13_bist_cm_mode),
                         .BIST_CM_EN_IN (tcam_row_0_col_13_bist_cm_en_in),
                         .BIST_CM_MATCH_SEL0 (tcam_row_0_col_13_bist_cm_match_sel0),
                         .BIST_CM_MATCH_SEL1 (tcam_row_0_col_13_bist_cm_match_sel1),
                         .BIST_MATCHIN_IN (tcam_row_0_col_13_bist_matchin_in),
                         .BIST_FLS (tcam_row_0_col_13_bist_fls),
                         .MDST_tcam (fuse_tcam), .BIST_SETUP(BIST_SETUP), .BIST_SETUP_ts1(BIST_SETUP_ts1), 
                        .BIST_SETUP_ts2(BIST_SETUP_ts2), .to_interfaces_tck(to_interfaces_tck), 
                        .mcp_bounding_to_en(mcp_bounding_to_en), .scan_to_en(scan_to_en), 
                        .memory_bypass_to_en(memory_bypass_to_en), 
                        .GO_ID_REG_SEL(GO_ID_REG_SEL), .BIST_CLEAR_BIRA(BIST_CLEAR_BIRA), 
                        .BIST_COLLAR_DIAG_EN(BIST_COLLAR_DIAG_EN), 
                        .BIST_COLLAR_BIRA_EN(BIST_COLLAR_BIRA_EN), 
                        .BIST_SHIFT_BIRA_COLLAR(BIST_SHIFT_BIRA_COLLAR), 
                        .CHECK_REPAIR_NEEDED(CHECK_REPAIR_NEEDED), 
                        .MEM4_BIST_COLLAR_SI(MEM4_BIST_COLLAR_SI), .BIST_SO(BIST_SO_ts4), 
                        .BIST_GO(BIST_GO_ts4), .ltest_to_en(ltest_to_en), 
                        .BIST_USER9(BIST_USER9), .BIST_USER10(BIST_USER10), 
                        .BIST_USER11(BIST_USER11), .BIST_USER0(BIST_USER0), 
                        .BIST_USER1(BIST_USER1), .BIST_USER2(BIST_USER2), 
                        .BIST_USER3(BIST_USER3), .BIST_USER4(BIST_USER4), 
                        .BIST_USER5(BIST_USER5), .BIST_USER6(BIST_USER6), 
                        .BIST_USER7(BIST_USER7), .BIST_USER8(BIST_USER8), 
                        .BIST_EVEN_GROUPWRITEENABLE(BIST_EVEN_GROUPWRITEENABLE), 
                        .BIST_ODD_GROUPWRITEENABLE(BIST_ODD_GROUPWRITEENABLE), 
                        .BIST_WRITEENABLE(BIST_WRITEENABLE), .BIST_READENABLE(BIST_READENABLE), 
                        .BIST_SELECT(BIST_SELECT), .BIST_CMP(BIST_CMP), 
                        .INCLUDE_MEM_RESULTS_REG(INCLUDE_MEM_RESULTS_REG), 
                        .BIST_COL_ADD(BIST_COL_ADD), .BIST_ROW_ADD(BIST_ROW_ADD[5:0]), 
                        .BIST_COLLAR_EN4(BIST_COLLAR_EN4), 
                        .BIST_RUN_TO_COLLAR4(BIST_RUN_TO_COLLAR4), 
                        .BIST_ASYNC_RESET(BIST_ASYNC_RESET), 
                        .BIST_TESTDATA_SELECT_TO_COLLAR(BIST_TESTDATA_SELECT_TO_COLLAR), 
                        .BIST_ON_TO_COLLAR(BIST_ON_TO_COLLAR), 
                        .BIST_WRITE_DATA(BIST_WRITE_DATA[31:0]), 
                        .BIST_EXPECT_DATA(BIST_EXPECT_DATA[31:0]), 
                        .BIST_SHIFT_COLLAR(BIST_SHIFT_COLLAR), 
                        .BIST_COLLAR_SETUP(BIST_COLLAR_SETUP), 
                        .BIST_CLEAR_DEFAULT(BIST_CLEAR_DEFAULT), .BIST_CLEAR(BIST_CLEAR), 
                        .BIST_COLLAR_OPSET_SELECT(BIST_COLLAR_OPSET_SELECT[1:0]), 
                        .BIST_COLLAR_HOLD(BIST_COLLAR_HOLD), 
                        .FREEZE_STOP_ERROR(FREEZE_STOP_ERROR), 
                        .ERROR_CNT_ZERO(ERROR_CNT_ZERO), 
                        .MBISTPG_RESET_REG_SETUP2(MBISTPG_RESET_REG_SETUP2), 
                        .BIST_BANK_ADD(BIST_BANK_ADD), .bisr_shift_en_pd_vinf(bisr_shift_en_pd_vinf), 
                        .bisr_clk_pd_vinf(bisr_clk_pd_vinf), 
                        .bisr_reset_pd_vinf(bisr_reset_pd_vinf), 
                        .tcam_row_0_col_12_bisr_inst_SO(tcam_row_0_col_12_bisr_inst_SO), 
                        .tcam_row_0_col_13_bisr_inst_SO(tcam_row_0_col_13_bisr_inst_SO), 
                        .fscan_clkungate(fscan_clkungate)
                     );
        
              end

              
            else
              begin : gen_tcam_row_0_col_13_bcam
              end
              
        
        
        endgenerate
        
        always_ff @(posedge clk) begin
                   tcam_rd_data_col[0][13]      <= tcam_row_0_col_13_data_out;
                   tcam_col_hit_out[0][13]       <= tcam_row_0_col_13_hit_out;
        end
        

        // this is new template - tcam_asic_template
        
        wire                                            tcam_row_0_col_14_clk         = clk;
        
        wire    [TCAM_SLICE_EN_FACT-1:0]                tcam_row_0_col_14_slice_en = TCAM_SLICE_EN_FACT'(slice_en[(0 * TCAM_SLICE_EN_FACT)+:TCAM_SLICE_EN_MIN]);
        
        wire                                            tcam_row_0_col_14_rd_en       = tcam_row_rd_en[0];
        wire                                            tcam_row_0_col_14_wr_en       = tcam_row_wr_en[0];
        wire                                            tcam_row_0_col_14_chk_en      = chk_en;
        wire                                            tcam_row_0_col_14_reset_n = reset_n;
        wire    [8-1:0]                       tcam_row_0_col_14_adr  = tcam_row_adr[0][8-1:0];
        wire    [32-1:0]                      tcam_row_0_col_14_data_in = tcam_row_wr_en[0] ? tcam_wr_data_col[14][32-1:0] : tcam_chk_key_col[14][32-1:0];
        wire    [32-1:0]                      tcam_row_0_col_14_data_in_pre = tcam_wr_data_col[14][32-1:0] ;
        wire    [32-1:0]                      tcam_row_0_col_14_key_in =  tcam_chk_key_col[14][32-1:0];
        wire    [32-1:0]                      tcam_row_0_col_14_mask_in = tcam_chk_mask_col[14][32-1:0];
        wire    [128-1:0]                       tcam_row_0_col_14_hit_in = tcam_raw_hit_in[0];
        wire    [128-1:0]                       tcam_row_0_col_14_tcam_match_in = tcam_row_match_in[0];
        wire    [32-1:0]                      tcam_row_0_col_14_data_out_inv;
        logic   [128-1:0]                     tcam_row_0_col_14_hit_out_int;
        logic   [128-1:0]                     tcam_row_0_col_14_hit_out_latch;
        logic   [128-1:0]                     tcam_row_0_col_14_hit_out;
        
        `ifdef CXP_DFX_DISABLE
        wire                          tcam_row_0_col_14_biste = 'b0; 
        wire     [5-1:0]                  tcam_row_0_col_14_fca = 'b0;
        wire                            tcam_row_0_col_14_cre = 'b0;
        wire                            tcam_row_0_col_14_dftshiften = 'b0;
        wire                            tcam_row_0_col_14_dftmask = 'b0;
        wire                            tcam_row_0_col_14_dft_array_freeze = 'b0;
        wire                            tcam_row_0_col_14_dft_afd_reset_b = 'b0;
        wire      [32-1:0]    tcam_row_0_col_14_tdin = 'b0;
        wire      [8-1:0]     tcam_row_0_col_14_tadr = 'b0;
        wire                            tcam_row_0_col_14_tvbe = 'b0;
        wire                            tcam_row_0_col_14_tvbi = 'b0;
        wire      [32-1:0]    tcam_row_0_col_14_tmask = 'b0;
        wire                            tcam_row_0_col_14_twe = 'b0;
        wire                            tcam_row_0_col_14_tre = 'b0;
        wire                            tcam_row_0_col_14_tme = 'b0;
        wire                            tcam_row_0_col_14_bist_rotate_sr = 'b0;
        wire                            tcam_row_0_col_14_bist_en_sr_mask_b = 'b0;
        wire                            tcam_row_0_col_14_bist_all_mask = 'b0;
        wire                            tcam_row_0_col_14_bist_en_sr_data_b = 'b0;
        wire                            tcam_row_0_col_14_bist_cm_mode = 'b0;
        wire                            tcam_row_0_col_14_bist_cm_en_in = 'b0;
        wire                            tcam_row_0_col_14_bist_cm_match_sel0 = 'b0;
        wire                            tcam_row_0_col_14_bist_cm_match_sel1 = 'b0;
        wire                            tcam_row_0_col_14_bist_matchin_in = 'b0;
        wire                            tcam_row_0_col_14_bist_fls = 'b0;
        
        `else
        wire                            tcam_row_0_col_14_biste = 'b0;
        wire     [5-1:0]                  tcam_row_0_col_14_fca = 'b0;
        wire                            tcam_row_0_col_14_cre = 'b0;
        wire                            tcam_row_0_col_14_dftshiften = dftshiften;
        wire                            tcam_row_0_col_14_dftmask = dftmask;
        wire                            tcam_row_0_col_14_dft_array_freeze = dft_array_freeze;
        wire                            tcam_row_0_col_14_dft_afd_reset_b = dft_afd_reset_b;
        wire      [32-1:0]    tcam_row_0_col_14_tdin = 'b0;
        wire      [8-1:0]     tcam_row_0_col_14_tadr = 'b0;
        wire                            tcam_row_0_col_14_tvbe = 'b0;
        wire                            tcam_row_0_col_14_tvbi = 'b0;
        wire      [32-1:0]    tcam_row_0_col_14_tmask = 'b0;
        wire                            tcam_row_0_col_14_twe = 'b0;
        wire                            tcam_row_0_col_14_tre = 'b0;
        wire                            tcam_row_0_col_14_tme = 'b0;
        wire                            tcam_row_0_col_14_bist_rotate_sr = 'b0;
        wire                            tcam_row_0_col_14_bist_en_sr_mask_b = 'b0;
        wire                            tcam_row_0_col_14_bist_all_mask = 'b0;
        wire                            tcam_row_0_col_14_bist_en_sr_data_b = 'b0;
        wire                            tcam_row_0_col_14_bist_cm_mode = 'b0;
        wire                            tcam_row_0_col_14_bist_cm_en_in = 'b0;
        wire                            tcam_row_0_col_14_bist_cm_match_sel0 = 'b0;
        wire                            tcam_row_0_col_14_bist_cm_match_sel1 = 'b0;
        wire                            tcam_row_0_col_14_bist_matchin_in = 'b0;
        wire                            tcam_row_0_col_14_bist_fls = 'b0;
        `endif
        
        // Outputs
        logic                           tcam_row_0_col_14_wr_bira_fail;
        logic                           tcam_row_0_col_14_wr_so;
        logic                           tcam_row_0_col_14_curerrout;
        logic                           tcam_row_0_col_14_rscout;
        
        
        
        logic   [TCAM_SLICE_EN_FACT-1:0]                  tcam_row_0_col_14_slice_en_s0; 
        logic   [TCAM_SLICE_EN_FACT-1:0]                  tcam_row_0_col_14_slice_en_s1; 
        
        
        
             wire    [32-1:0]                     tcam_row_0_col_14_data_out ;
        
        
        
         generate
            if (BCAM_N7 == 0) 
              begin : gen_tcam_row_0_col_14_tcam
        
        
        // slice_en kept for TCAM only for backward compatability with Intel process
                always_comb 
                begin
                  for (int i = 0; i < TCAM_SLICE_EN_FACT; i++)
                      if (tcam_row_0_col_14_slice_en_s1[i])
                           tcam_row_0_col_14_hit_out[ i*64 +: 64]  = tcam_row_0_col_14_hit_out_int  [ i*64 +: 64]; 
                      else
                           tcam_row_0_col_14_hit_out[ i*64 +: 64]  = tcam_row_0_col_14_hit_out_latch[ i*64 +: 64]; 
                end
        
        
        
                always_ff  @(posedge tcam_row_0_col_14_clk)
                begin
                  tcam_row_0_col_14_slice_en_s0 <= tcam_row_0_col_14_slice_en; 
                  tcam_row_0_col_14_slice_en_s1 <= tcam_row_0_col_14_slice_en_s0; 
        
                  for (int i = 0; i < TCAM_SLICE_EN_FACT; i++)
                    begin
                      if (tcam_row_0_col_14_slice_en_s1[i])
                         tcam_row_0_col_14_hit_out_latch[ i*64 +: 64] <=  tcam_row_0_col_14_hit_out_int[ i*64 +: 64];
                    end
                end
        
        
        
        // NEW TCAM symbol 
        //                              _____________________________
        //                             |                             |
        //                         ----|ADRi                         |
        //                         ----|Di                           |
        //                         ----|RE                           |
        //                         ----|WE                           |
        //                         ----|ME                           |
        //                         ----|MASKi                        |
        //                         ----|DSEL                         |
        //                         ----|VBE                          |
        //                         ----|VBI                          |
        //                         ----|CMP                          |
        //                         ----|RVLDi                        |
        //                         ----|RST                          |
        //                         ----|FLS                          |
        //                         ----|CLK                          |
        //                         ----|FAF_EN                       |
        //                         ----|FAFi                         |
        //                             |                           Qi|---
        //                             |                         QVLD|---
        //                             |                         QHIT|---
        //                         ----|MDST_tcam                    |
        //                             |                         QHRi|---
        //                         ----|DFTSHIFTEN                   |
        //                         ----|DFTMASK                      |
        //                         ----|DFT_ARRAY_FREEZE             |
        //                         ----|DFT_AFD_RESET_B              |
        //                             |_____________________________|
        
                     
                         assign tcam_row_0_col_14_data_out  = ~tcam_row_0_col_14_data_out_inv;
                         wcm_ip783tcam128x32s0c1_0_14_wrap #(        
                                 )               
        
                                 ip783tcam128x32s0c1_wrap_tcam_row_0_col_14 (
                   //-------------------------------------------------------------
                   // Power Management Interfaces
                   //-------------------------------------------------------------   
                      `ifndef INTEL_NO_PWR_PINS
                      `ifdef INTC_ADD_VSS
                        .vss              (1'b0),
                      `endif
                        .vddp             (1'b1),
                      `endif
                         .ADR               (tcam_row_0_col_14_adr[8-1:1]), //Input adr_intess
                         .ME                (ce),  
        
                         .CLK               (tcam_row_0_col_14_clk), //Clock
                         .CMP               (tcam_row_0_col_14_chk_en), //Control Enable
                         .DIN               (~tcam_row_0_col_14_data_in), 
                         .DSEL              (~tcam_row_0_col_14_adr[0]), //dncen enables access of the TCAM Arrays adr_intessed
                         .FLS               (flush), //flush initiates a Flush operation that resets all Valid
                         .RVLD              (tcam_row_0_col_14_hit_in ), //Row validation bus. Each match_in input controls 1
                         .MASK              (tcam_row_0_col_14_mask_in), //Input msk
                         .QOUT              (tcam_row_0_col_14_data_out_inv), //Output vben
                         .QHR               (tcam_row_0_col_14_hit_out_int),
                         .QVLD              (), 
                         .RE                (tcam_row_0_col_14_rd_en), //Read Enable
                         .RST               (tcam_row_0_col_14_reset_n), //Asynchronous Active-High Reset
                         .VBE               (1'b1), //vben enables the Valid Bit addressed by adr[a-1:0] to
                         .VBI               (1'b0),//  Valid Bit Input
                         .WE                (tcam_row_0_col_14_wr_en), //Write Enable
                         .FAF               (tcam_row_0_col_14_fca),
                         .FAF_EN            (tcam_row_0_col_14_cre),
                         .DFTSHIFTEN        (tcam_row_0_col_14_dftshiften),
                         .DFTMASK           (tcam_row_0_col_14_dftmask),
                         .DFT_ARRAY_FREEZE  (tcam_row_0_col_14_dft_array_freeze),
                         .DFT_AFD_RESET_B   (tcam_row_0_col_14_dft_afd_reset_b),
                         .BISTE           (tcam_row_0_col_14_biste),
                         .TDIN (tcam_row_0_col_14_tdin),
                         .TADR (tcam_row_0_col_14_tadr),
                         .TVBE (tcam_row_0_col_14_tvbe),
                         .TVBI (tcam_row_0_col_14_tvbi),
                         .TMASK (tcam_row_0_col_14_tmask),
                         .TWE (tcam_row_0_col_14_twe),
                         .TRE (tcam_row_0_col_14_tre),
                         .TME (tcam_row_0_col_14_tme),
                         .BIST_ROTATE_SR (tcam_row_0_col_14_bist_rotate_sr),
                         .BIST_EN_SR_MASK_B (tcam_row_0_col_14_bist_en_sr_mask_b),
                         .BIST_ALL_MASK (tcam_row_0_col_14_bist_all_mask),
                         .BIST_EN_SR_DATA_B (tcam_row_0_col_14_bist_en_sr_data_b),
                         .BIST_CM_MODE (tcam_row_0_col_14_bist_cm_mode),
                         .BIST_CM_EN_IN (tcam_row_0_col_14_bist_cm_en_in),
                         .BIST_CM_MATCH_SEL0 (tcam_row_0_col_14_bist_cm_match_sel0),
                         .BIST_CM_MATCH_SEL1 (tcam_row_0_col_14_bist_cm_match_sel1),
                         .BIST_MATCHIN_IN (tcam_row_0_col_14_bist_matchin_in),
                         .BIST_FLS (tcam_row_0_col_14_bist_fls),
                         .MDST_tcam (fuse_tcam), .BIST_SETUP(BIST_SETUP), .BIST_SETUP_ts1(BIST_SETUP_ts1), 
                        .BIST_SETUP_ts2(BIST_SETUP_ts2), .to_interfaces_tck(to_interfaces_tck), 
                        .mcp_bounding_to_en(mcp_bounding_to_en), .scan_to_en(scan_to_en), 
                        .memory_bypass_to_en(memory_bypass_to_en), 
                        .GO_ID_REG_SEL(GO_ID_REG_SEL), .BIST_CLEAR_BIRA(BIST_CLEAR_BIRA), 
                        .BIST_COLLAR_DIAG_EN(BIST_COLLAR_DIAG_EN), 
                        .BIST_COLLAR_BIRA_EN(BIST_COLLAR_BIRA_EN), 
                        .BIST_SHIFT_BIRA_COLLAR(BIST_SHIFT_BIRA_COLLAR), 
                        .CHECK_REPAIR_NEEDED(CHECK_REPAIR_NEEDED), 
                        .MEM5_BIST_COLLAR_SI(MEM5_BIST_COLLAR_SI), .BIST_SO(BIST_SO_ts5), 
                        .BIST_GO(BIST_GO_ts5), .ltest_to_en(ltest_to_en), 
                        .BIST_USER9(BIST_USER9), .BIST_USER10(BIST_USER10), 
                        .BIST_USER11(BIST_USER11), .BIST_USER0(BIST_USER0), 
                        .BIST_USER1(BIST_USER1), .BIST_USER2(BIST_USER2), 
                        .BIST_USER3(BIST_USER3), .BIST_USER4(BIST_USER4), 
                        .BIST_USER5(BIST_USER5), .BIST_USER6(BIST_USER6), 
                        .BIST_USER7(BIST_USER7), .BIST_USER8(BIST_USER8), 
                        .BIST_EVEN_GROUPWRITEENABLE(BIST_EVEN_GROUPWRITEENABLE), 
                        .BIST_ODD_GROUPWRITEENABLE(BIST_ODD_GROUPWRITEENABLE), 
                        .BIST_WRITEENABLE(BIST_WRITEENABLE), .BIST_READENABLE(BIST_READENABLE), 
                        .BIST_SELECT(BIST_SELECT), .BIST_CMP(BIST_CMP), 
                        .INCLUDE_MEM_RESULTS_REG(INCLUDE_MEM_RESULTS_REG), 
                        .BIST_COL_ADD(BIST_COL_ADD), .BIST_ROW_ADD(BIST_ROW_ADD[5:0]), 
                        .BIST_COLLAR_EN5(BIST_COLLAR_EN5), 
                        .BIST_RUN_TO_COLLAR5(BIST_RUN_TO_COLLAR5), 
                        .BIST_ASYNC_RESET(BIST_ASYNC_RESET), 
                        .BIST_TESTDATA_SELECT_TO_COLLAR(BIST_TESTDATA_SELECT_TO_COLLAR), 
                        .BIST_ON_TO_COLLAR(BIST_ON_TO_COLLAR), 
                        .BIST_WRITE_DATA(BIST_WRITE_DATA[31:0]), 
                        .BIST_EXPECT_DATA(BIST_EXPECT_DATA[31:0]), 
                        .BIST_SHIFT_COLLAR(BIST_SHIFT_COLLAR), 
                        .BIST_COLLAR_SETUP(BIST_COLLAR_SETUP), 
                        .BIST_CLEAR_DEFAULT(BIST_CLEAR_DEFAULT), .BIST_CLEAR(BIST_CLEAR), 
                        .BIST_COLLAR_OPSET_SELECT(BIST_COLLAR_OPSET_SELECT[1:0]), 
                        .BIST_COLLAR_HOLD(BIST_COLLAR_HOLD), 
                        .FREEZE_STOP_ERROR(FREEZE_STOP_ERROR), 
                        .ERROR_CNT_ZERO(ERROR_CNT_ZERO), 
                        .MBISTPG_RESET_REG_SETUP2(MBISTPG_RESET_REG_SETUP2), 
                        .BIST_BANK_ADD(BIST_BANK_ADD), .bisr_shift_en_pd_vinf(bisr_shift_en_pd_vinf), 
                        .bisr_clk_pd_vinf(bisr_clk_pd_vinf), 
                        .bisr_reset_pd_vinf(bisr_reset_pd_vinf), 
                        .tcam_row_0_col_13_bisr_inst_SO(tcam_row_0_col_13_bisr_inst_SO), 
                        .tcam_row_0_col_14_bisr_inst_SO(tcam_row_0_col_14_bisr_inst_SO), 
                        .fscan_clkungate(fscan_clkungate)
                     );
        
              end

              
            else
              begin : gen_tcam_row_0_col_14_bcam
              end
              
        
        
        endgenerate
        
        always_ff @(posedge clk) begin
                   tcam_rd_data_col[0][14]      <= tcam_row_0_col_14_data_out;
                   tcam_col_hit_out[0][14]       <= tcam_row_0_col_14_hit_out;
        end
        

        // this is new template - tcam_asic_template
        
        wire                                            tcam_row_0_col_15_clk         = clk;
        
        wire    [TCAM_SLICE_EN_FACT-1:0]                tcam_row_0_col_15_slice_en = TCAM_SLICE_EN_FACT'(slice_en[(0 * TCAM_SLICE_EN_FACT)+:TCAM_SLICE_EN_MIN]);
        
        wire                                            tcam_row_0_col_15_rd_en       = tcam_row_rd_en[0];
        wire                                            tcam_row_0_col_15_wr_en       = tcam_row_wr_en[0];
        wire                                            tcam_row_0_col_15_chk_en      = chk_en;
        wire                                            tcam_row_0_col_15_reset_n = reset_n;
        wire    [8-1:0]                       tcam_row_0_col_15_adr  = tcam_row_adr[0][8-1:0];
        wire    [32-1:0]                      tcam_row_0_col_15_data_in = tcam_row_wr_en[0] ? tcam_wr_data_col[15][32-1:0] : tcam_chk_key_col[15][32-1:0];
        wire    [32-1:0]                      tcam_row_0_col_15_data_in_pre = tcam_wr_data_col[15][32-1:0] ;
        wire    [32-1:0]                      tcam_row_0_col_15_key_in =  tcam_chk_key_col[15][32-1:0];
        wire    [32-1:0]                      tcam_row_0_col_15_mask_in = tcam_chk_mask_col[15][32-1:0];
        wire    [128-1:0]                       tcam_row_0_col_15_hit_in = tcam_raw_hit_in[0];
        wire    [128-1:0]                       tcam_row_0_col_15_tcam_match_in = tcam_row_match_in[0];
        wire    [32-1:0]                      tcam_row_0_col_15_data_out_inv;
        logic   [128-1:0]                     tcam_row_0_col_15_hit_out_int;
        logic   [128-1:0]                     tcam_row_0_col_15_hit_out_latch;
        logic   [128-1:0]                     tcam_row_0_col_15_hit_out;
        
        `ifdef CXP_DFX_DISABLE
        wire                          tcam_row_0_col_15_biste = 'b0; 
        wire     [5-1:0]                  tcam_row_0_col_15_fca = 'b0;
        wire                            tcam_row_0_col_15_cre = 'b0;
        wire                            tcam_row_0_col_15_dftshiften = 'b0;
        wire                            tcam_row_0_col_15_dftmask = 'b0;
        wire                            tcam_row_0_col_15_dft_array_freeze = 'b0;
        wire                            tcam_row_0_col_15_dft_afd_reset_b = 'b0;
        wire      [32-1:0]    tcam_row_0_col_15_tdin = 'b0;
        wire      [8-1:0]     tcam_row_0_col_15_tadr = 'b0;
        wire                            tcam_row_0_col_15_tvbe = 'b0;
        wire                            tcam_row_0_col_15_tvbi = 'b0;
        wire      [32-1:0]    tcam_row_0_col_15_tmask = 'b0;
        wire                            tcam_row_0_col_15_twe = 'b0;
        wire                            tcam_row_0_col_15_tre = 'b0;
        wire                            tcam_row_0_col_15_tme = 'b0;
        wire                            tcam_row_0_col_15_bist_rotate_sr = 'b0;
        wire                            tcam_row_0_col_15_bist_en_sr_mask_b = 'b0;
        wire                            tcam_row_0_col_15_bist_all_mask = 'b0;
        wire                            tcam_row_0_col_15_bist_en_sr_data_b = 'b0;
        wire                            tcam_row_0_col_15_bist_cm_mode = 'b0;
        wire                            tcam_row_0_col_15_bist_cm_en_in = 'b0;
        wire                            tcam_row_0_col_15_bist_cm_match_sel0 = 'b0;
        wire                            tcam_row_0_col_15_bist_cm_match_sel1 = 'b0;
        wire                            tcam_row_0_col_15_bist_matchin_in = 'b0;
        wire                            tcam_row_0_col_15_bist_fls = 'b0;
        
        `else
        wire                            tcam_row_0_col_15_biste = 'b0;
        wire     [5-1:0]                  tcam_row_0_col_15_fca = 'b0;
        wire                            tcam_row_0_col_15_cre = 'b0;
        wire                            tcam_row_0_col_15_dftshiften = dftshiften;
        wire                            tcam_row_0_col_15_dftmask = dftmask;
        wire                            tcam_row_0_col_15_dft_array_freeze = dft_array_freeze;
        wire                            tcam_row_0_col_15_dft_afd_reset_b = dft_afd_reset_b;
        wire      [32-1:0]    tcam_row_0_col_15_tdin = 'b0;
        wire      [8-1:0]     tcam_row_0_col_15_tadr = 'b0;
        wire                            tcam_row_0_col_15_tvbe = 'b0;
        wire                            tcam_row_0_col_15_tvbi = 'b0;
        wire      [32-1:0]    tcam_row_0_col_15_tmask = 'b0;
        wire                            tcam_row_0_col_15_twe = 'b0;
        wire                            tcam_row_0_col_15_tre = 'b0;
        wire                            tcam_row_0_col_15_tme = 'b0;
        wire                            tcam_row_0_col_15_bist_rotate_sr = 'b0;
        wire                            tcam_row_0_col_15_bist_en_sr_mask_b = 'b0;
        wire                            tcam_row_0_col_15_bist_all_mask = 'b0;
        wire                            tcam_row_0_col_15_bist_en_sr_data_b = 'b0;
        wire                            tcam_row_0_col_15_bist_cm_mode = 'b0;
        wire                            tcam_row_0_col_15_bist_cm_en_in = 'b0;
        wire                            tcam_row_0_col_15_bist_cm_match_sel0 = 'b0;
        wire                            tcam_row_0_col_15_bist_cm_match_sel1 = 'b0;
        wire                            tcam_row_0_col_15_bist_matchin_in = 'b0;
        wire                            tcam_row_0_col_15_bist_fls = 'b0;
        `endif
        
        // Outputs
        logic                           tcam_row_0_col_15_wr_bira_fail;
        logic                           tcam_row_0_col_15_wr_so;
        logic                           tcam_row_0_col_15_curerrout;
        logic                           tcam_row_0_col_15_rscout;
        
        
        
        logic   [TCAM_SLICE_EN_FACT-1:0]                  tcam_row_0_col_15_slice_en_s0; 
        logic   [TCAM_SLICE_EN_FACT-1:0]                  tcam_row_0_col_15_slice_en_s1; 
        
        
        
             wire    [32-1:0]                     tcam_row_0_col_15_data_out ;
        
        
        
         generate
            if (BCAM_N7 == 0) 
              begin : gen_tcam_row_0_col_15_tcam
        
        
        // slice_en kept for TCAM only for backward compatability with Intel process
                always_comb 
                begin
                  for (int i = 0; i < TCAM_SLICE_EN_FACT; i++)
                      if (tcam_row_0_col_15_slice_en_s1[i])
                           tcam_row_0_col_15_hit_out[ i*64 +: 64]  = tcam_row_0_col_15_hit_out_int  [ i*64 +: 64]; 
                      else
                           tcam_row_0_col_15_hit_out[ i*64 +: 64]  = tcam_row_0_col_15_hit_out_latch[ i*64 +: 64]; 
                end
        
        
        
                always_ff  @(posedge tcam_row_0_col_15_clk)
                begin
                  tcam_row_0_col_15_slice_en_s0 <= tcam_row_0_col_15_slice_en; 
                  tcam_row_0_col_15_slice_en_s1 <= tcam_row_0_col_15_slice_en_s0; 
        
                  for (int i = 0; i < TCAM_SLICE_EN_FACT; i++)
                    begin
                      if (tcam_row_0_col_15_slice_en_s1[i])
                         tcam_row_0_col_15_hit_out_latch[ i*64 +: 64] <=  tcam_row_0_col_15_hit_out_int[ i*64 +: 64];
                    end
                end
        
        
        
        // NEW TCAM symbol 
        //                              _____________________________
        //                             |                             |
        //                         ----|ADRi                         |
        //                         ----|Di                           |
        //                         ----|RE                           |
        //                         ----|WE                           |
        //                         ----|ME                           |
        //                         ----|MASKi                        |
        //                         ----|DSEL                         |
        //                         ----|VBE                          |
        //                         ----|VBI                          |
        //                         ----|CMP                          |
        //                         ----|RVLDi                        |
        //                         ----|RST                          |
        //                         ----|FLS                          |
        //                         ----|CLK                          |
        //                         ----|FAF_EN                       |
        //                         ----|FAFi                         |
        //                             |                           Qi|---
        //                             |                         QVLD|---
        //                             |                         QHIT|---
        //                         ----|MDST_tcam                    |
        //                             |                         QHRi|---
        //                         ----|DFTSHIFTEN                   |
        //                         ----|DFTMASK                      |
        //                         ----|DFT_ARRAY_FREEZE             |
        //                         ----|DFT_AFD_RESET_B              |
        //                             |_____________________________|
        
                     
                         assign tcam_row_0_col_15_data_out  = ~tcam_row_0_col_15_data_out_inv;
                         wcm_ip783tcam128x32s0c1_0_15_wrap #(        
                                 )               
        
                                 ip783tcam128x32s0c1_wrap_tcam_row_0_col_15 (
                   //-------------------------------------------------------------
                   // Power Management Interfaces
                   //-------------------------------------------------------------   
                      `ifndef INTEL_NO_PWR_PINS
                      `ifdef INTC_ADD_VSS
                        .vss              (1'b0),
                      `endif
                        .vddp             (1'b1),
                      `endif
                         .ADR               (tcam_row_0_col_15_adr[8-1:1]), //Input adr_intess
                         .ME                (ce),  
        
                         .CLK               (tcam_row_0_col_15_clk), //Clock
                         .CMP               (tcam_row_0_col_15_chk_en), //Control Enable
                         .DIN               (~tcam_row_0_col_15_data_in), 
                         .DSEL              (~tcam_row_0_col_15_adr[0]), //dncen enables access of the TCAM Arrays adr_intessed
                         .FLS               (flush), //flush initiates a Flush operation that resets all Valid
                         .RVLD              (tcam_row_0_col_15_hit_in ), //Row validation bus. Each match_in input controls 1
                         .MASK              (tcam_row_0_col_15_mask_in), //Input msk
                         .QOUT              (tcam_row_0_col_15_data_out_inv), //Output vben
                         .QHR               (tcam_row_0_col_15_hit_out_int),
                         .QVLD              (), 
                         .RE                (tcam_row_0_col_15_rd_en), //Read Enable
                         .RST               (tcam_row_0_col_15_reset_n), //Asynchronous Active-High Reset
                         .VBE               (1'b1), //vben enables the Valid Bit addressed by adr[a-1:0] to
                         .VBI               (1'b0),//  Valid Bit Input
                         .WE                (tcam_row_0_col_15_wr_en), //Write Enable
                         .FAF               (tcam_row_0_col_15_fca),
                         .FAF_EN            (tcam_row_0_col_15_cre),
                         .DFTSHIFTEN        (tcam_row_0_col_15_dftshiften),
                         .DFTMASK           (tcam_row_0_col_15_dftmask),
                         .DFT_ARRAY_FREEZE  (tcam_row_0_col_15_dft_array_freeze),
                         .DFT_AFD_RESET_B   (tcam_row_0_col_15_dft_afd_reset_b),
                         .BISTE           (tcam_row_0_col_15_biste),
                         .TDIN (tcam_row_0_col_15_tdin),
                         .TADR (tcam_row_0_col_15_tadr),
                         .TVBE (tcam_row_0_col_15_tvbe),
                         .TVBI (tcam_row_0_col_15_tvbi),
                         .TMASK (tcam_row_0_col_15_tmask),
                         .TWE (tcam_row_0_col_15_twe),
                         .TRE (tcam_row_0_col_15_tre),
                         .TME (tcam_row_0_col_15_tme),
                         .BIST_ROTATE_SR (tcam_row_0_col_15_bist_rotate_sr),
                         .BIST_EN_SR_MASK_B (tcam_row_0_col_15_bist_en_sr_mask_b),
                         .BIST_ALL_MASK (tcam_row_0_col_15_bist_all_mask),
                         .BIST_EN_SR_DATA_B (tcam_row_0_col_15_bist_en_sr_data_b),
                         .BIST_CM_MODE (tcam_row_0_col_15_bist_cm_mode),
                         .BIST_CM_EN_IN (tcam_row_0_col_15_bist_cm_en_in),
                         .BIST_CM_MATCH_SEL0 (tcam_row_0_col_15_bist_cm_match_sel0),
                         .BIST_CM_MATCH_SEL1 (tcam_row_0_col_15_bist_cm_match_sel1),
                         .BIST_MATCHIN_IN (tcam_row_0_col_15_bist_matchin_in),
                         .BIST_FLS (tcam_row_0_col_15_bist_fls),
                         .MDST_tcam (fuse_tcam), .BIST_SETUP(BIST_SETUP), .BIST_SETUP_ts1(BIST_SETUP_ts1), 
                        .BIST_SETUP_ts2(BIST_SETUP_ts2), .to_interfaces_tck(to_interfaces_tck), 
                        .mcp_bounding_to_en(mcp_bounding_to_en), .scan_to_en(scan_to_en), 
                        .memory_bypass_to_en(memory_bypass_to_en), 
                        .GO_ID_REG_SEL(GO_ID_REG_SEL), .BIST_CLEAR_BIRA(BIST_CLEAR_BIRA), 
                        .BIST_COLLAR_DIAG_EN(BIST_COLLAR_DIAG_EN), 
                        .BIST_COLLAR_BIRA_EN(BIST_COLLAR_BIRA_EN), 
                        .BIST_SHIFT_BIRA_COLLAR(BIST_SHIFT_BIRA_COLLAR), 
                        .CHECK_REPAIR_NEEDED(CHECK_REPAIR_NEEDED), 
                        .MEM6_BIST_COLLAR_SI(MEM6_BIST_COLLAR_SI), .BIST_SO(BIST_SO_ts6), 
                        .BIST_GO(BIST_GO_ts6), .ltest_to_en(ltest_to_en), 
                        .BIST_USER9(BIST_USER9), .BIST_USER10(BIST_USER10), 
                        .BIST_USER11(BIST_USER11), .BIST_USER0(BIST_USER0), 
                        .BIST_USER1(BIST_USER1), .BIST_USER2(BIST_USER2), 
                        .BIST_USER3(BIST_USER3), .BIST_USER4(BIST_USER4), 
                        .BIST_USER5(BIST_USER5), .BIST_USER6(BIST_USER6), 
                        .BIST_USER7(BIST_USER7), .BIST_USER8(BIST_USER8), 
                        .BIST_EVEN_GROUPWRITEENABLE(BIST_EVEN_GROUPWRITEENABLE), 
                        .BIST_ODD_GROUPWRITEENABLE(BIST_ODD_GROUPWRITEENABLE), 
                        .BIST_WRITEENABLE(BIST_WRITEENABLE), .BIST_READENABLE(BIST_READENABLE), 
                        .BIST_SELECT(BIST_SELECT), .BIST_CMP(BIST_CMP), 
                        .INCLUDE_MEM_RESULTS_REG(INCLUDE_MEM_RESULTS_REG), 
                        .BIST_COL_ADD(BIST_COL_ADD), .BIST_ROW_ADD(BIST_ROW_ADD[5:0]), 
                        .BIST_COLLAR_EN6(BIST_COLLAR_EN6), 
                        .BIST_RUN_TO_COLLAR6(BIST_RUN_TO_COLLAR6), 
                        .BIST_ASYNC_RESET(BIST_ASYNC_RESET), 
                        .BIST_TESTDATA_SELECT_TO_COLLAR(BIST_TESTDATA_SELECT_TO_COLLAR), 
                        .BIST_ON_TO_COLLAR(BIST_ON_TO_COLLAR), 
                        .BIST_WRITE_DATA(BIST_WRITE_DATA[31:0]), 
                        .BIST_EXPECT_DATA(BIST_EXPECT_DATA[31:0]), 
                        .BIST_SHIFT_COLLAR(BIST_SHIFT_COLLAR), 
                        .BIST_COLLAR_SETUP(BIST_COLLAR_SETUP), 
                        .BIST_CLEAR_DEFAULT(BIST_CLEAR_DEFAULT), .BIST_CLEAR(BIST_CLEAR), 
                        .BIST_COLLAR_OPSET_SELECT(BIST_COLLAR_OPSET_SELECT[1:0]), 
                        .BIST_COLLAR_HOLD(BIST_COLLAR_HOLD), 
                        .FREEZE_STOP_ERROR(FREEZE_STOP_ERROR), 
                        .ERROR_CNT_ZERO(ERROR_CNT_ZERO), 
                        .MBISTPG_RESET_REG_SETUP2(MBISTPG_RESET_REG_SETUP2), 
                        .BIST_BANK_ADD(BIST_BANK_ADD), .bisr_shift_en_pd_vinf(bisr_shift_en_pd_vinf), 
                        .bisr_clk_pd_vinf(bisr_clk_pd_vinf), 
                        .bisr_reset_pd_vinf(bisr_reset_pd_vinf), 
                        .tcam_row_0_col_14_bisr_inst_SO(tcam_row_0_col_14_bisr_inst_SO), 
                        .tcam_row_0_col_15_bisr_inst_SO(tcam_row_0_col_15_bisr_inst_SO), 
                        .fscan_clkungate(fscan_clkungate)
                     );
        
              end

              
            else
              begin : gen_tcam_row_0_col_15_bcam
              end
              
        
        
        endgenerate
        
        always_ff @(posedge clk) begin
                   tcam_rd_data_col[0][15]      <= tcam_row_0_col_15_data_out;
                   tcam_col_hit_out[0][15]       <= tcam_row_0_col_15_hit_out;
        end
        

    assign    tcam_rd_valid      = rd_en_delay[TCAM_RD_DELAY];
    assign    tcam_wr_ack      = wr_en_delay[TCAM_WR_DELAY];
    assign    tcam_chk_valid      = chk_en_delay[TCAM_CHK_DELAY];
    assign    tcam_rdwr_rdy      = rd_en_nope_done && wr_en_nope_done;
    assign    tcam_chk_rdy      = chk_en_nope_done && !wr_en && !rd_en;
// DFX output concatination 

                 
         
        `ifdef INTEL_SIMONLY
           `ifndef CXP_FEV_APPROVE_SIM_ONLY
                generate
                        if ((TCAM_INIT_TYPE == 1) & (BCAM_N7 == 0)) begin : CONST_TCAM_INIT                           
                            initial begin
                                backdoor_loading();
                            end
                            
                            task backdoor_loading();
                                forever begin
                                    @(posedge reset_n);         
                                    @(posedge clk);
                                   // force ce = 1;
                                    @(posedge clk);
                                   // release ce;
                                    #1; 
                                    if ($test$plusargs("CXP_FAST_CONFIG")) begin
                                        for (int i = 0; i < TCAM_DEPTH; i = i + 1) begin
                                            write_tcam_raw_line(TCAM_E0_INIT_VALUE,TCAM_E1_INIT_VALUE,i);
                                        end
                                    end                               
                                end
                            endtask
                        end else if ((TCAM_INIT_TYPE == 1) & (BCAM_N7 == 1)) begin :  CONST_BCAM_INIT
                            initial begin
                                backdoor_loading();
                            end
                            
                            task backdoor_loading();
                                forever begin
                                    @(posedge reset_n);         
                                    @(posedge clk);
                                    //force ce = 1;
                                    @(posedge clk);
                                    // release ce;
                                    #1; 
                                    if ($test$plusargs("CXP_FAST_CONFIG")) begin
                                        for (int i = 0; i < TCAM_DEPTH; i = i + 1) begin
                                            write_tcam_raw_inv_key(TCAM_E1_INIT_VALUE,i);
                                        end
                                    end
                                end    
                            endtask
                        end
                endgenerate
            `endif
        `endif

`else

////////////////////////////////////////////////////////////////////////
//
//                              BEHAVE MEMORIES                                                                                                                                         
//
////////////////////////////////////////////////////////////////////////

//logic   [TCAM_WIDTH-1:0]        tcam_data_in                                                                                    ;
//assign                          tcam_data_in                    = wr_en ? wr_data : chk_key                                     ;
assign                          chk_mask[PHYSICAL_ROW_WIDTH-1:0]        = wr_en ? {PHYSICAL_ROW_WIDTH{1'b1}} : chk_mask_int[PHYSICAL_ROW_WIDTH-1:0]     ;

logic [PHYSICAL_ROW_WIDTH-1:0]  rd_data_before_prot_calc;
logic [PHYSICAL_ROW_WIDTH-1:0]  rd_data_before_prot_calc_fpga;
logic [PHYSICAL_ROW_WIDTH-1:0]  rd_data_before_prot_calc_behave;

generate
    if (BCAM_N7 == 1) 
        begin : bacm_prot_calc
            always_comb begin
                rd_data = rd_data_before_prot_calc;
                for (int i = 0; i < 16; i = i + 1) begin
                    rd_data[PHYSICAL_ROW_WIDTH-((16-i-1)*2)-2] = ^rd_data_before_prot_calc[(i*(32-2))+:((32-2)/2)];
                    rd_data[PHYSICAL_ROW_WIDTH-((16-i-1)*2)-1] = ^rd_data_before_prot_calc[(i*(32-2))+((32-2)/2)+:((32-2)/2)];
                end
            end
        end
    else
        begin : tcam_no_prot_calc
            assign rd_data = rd_data_before_prot_calc;
        end
endgenerate

   `ifdef CXP_TCAM_FPGA_MEMS



       cxp_mgm_fpga_tcam #(
                .CLOCKS_RATIO           (FPGA_CLOCKS_RATIO)                     , // Number of cycles that fast clock makes during one slow clock cycle 
                .MARGIN                 (FPGA_MARGIN)                           , // safety margin between the number of fast clock cycles needed and the end of one slow clock cycle
                .TOTAL_RULES_NUM        (TCAM_RULES_NUM)                        , // depth requested by designer
                .DATA_WIDTH             (PHYSICAL_ROW_WIDTH)                    ,  // key width
                .TSMC_N7                (TSMC_N7)                               ,  // TSMC mode, affects read and write sequence timint            
                .BCAM_N7                (BCAM_N7)                                  // BCAM mode
        )
        fpga_tcam (
                .clk                    (clk)                                 , // Clock
                .fast_clk               (fpga_fast_clk)                       , // fast clock for fpga tcam inner units       
                .reset_n                (reset_n)                             , // Asynchronous Active-Low Reset
                .rd_en                  (rd_en)                               , // Read Enable
                .wr_en                  (wr_en)                               , // Write Enable
                .chk_en                 (chk_en)                              , // Control Enable
                .addr                   (adr[TCAM_ADDR_WIDTH - 1:BCAM_N7])     , // Input Address
                .data_in                (wr_data)                             , // Input Data
                .skey_in                (chk_key)                             , // Input Key
                .chk_mask               (chk_mask )                           , // Input Mask
                .raw_hit_in             (raw_hit_in)                          , // Raw Hit Input 
                .match_in               (tcam_match_in)                       , // Raw Match Input
                .vbi_in                 (~adr[0] & tcam_init_done)            , 
                .flush_in               (flush)                               ,
                .rd_data                (rd_data_before_prot_calc_fpga)            , // Output Data
                .raw_hit_out            (raw_hit_out_fpga)         // Raw Hit Output
        );
    
        //`ifndef CXP_FPGA_TCAM_MEMS_TCAM_BEHAVE_EN
                assign raw_hit_out              = raw_hit_out_fpga;  
                assign rd_data_before_prot_calc = rd_data_before_prot_calc_fpga;  

        //`endif

    `endif
    `ifdef CXP_TCAM_BEHAVE_FPGA_MEMS
        cxp_mgm_tcam_behave #(
                .RULES_NUM              (TCAM_RULES_NUM)                        ,       // Number of Rules
                .DATA_WIDTH             (PHYSICAL_ROW_WIDTH)                    ,       // Word Width
                .TSMC_N7                (TSMC_N7),  // TSMC mode, affects read and write sequence timint            
                .BCAM_N7                (BCAM_N7)                                       // BCAM mode
        )
        behave_tcam (
                .CLK                    (clk)                                   ,       // Clock
                .RESET_N                (reset_n)                               ,       // Asynchronous Active-Low Reset
                .REN                    (rd_en)                                 ,       // Read Enable
                .WEN                    (wr_en)                                 ,       // Write Enable
                .KEN                    (chk_en)                                ,       // Control Enable
                .MATCH_IN               (tcam_match_in)                         ,       // Match In Lines for BCAM
                .VBI                    (~adr[0] & tcam_init_done)              ,       // In/Validate bit for BCAM
                .FLUSH                  (flush)                            ,       // flush for BCAM
                .ADDR                   (adr[TCAM_ADDR_WIDTH - 1:BCAM_N7])       ,       // Input Address
                .DATA                   (wr_data)                               ,       // Input Data
                .SKEY                   (chk_key)                               ,       // Input KEY
                .MASK                   (chk_mask)                              ,       // Input Mask
                .LHIT                   (raw_hit_in)                            ,       // Raw Hit Input
                .READ_DATA              (rd_data_before_prot_calc_behave)              ,       // Output Data
                .RHIT                   (raw_hit_out_behave)                                   // Raw Hit Output
        );


        `ifndef CXP_TCAM_FPGA_MEMS
                assign raw_hit_out              = raw_hit_out_behave;  
                assign rd_data_before_prot_calc = rd_data_before_prot_calc_behave;  

        `endif


    `endif


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
         
         
        `ifdef INTEL_SIMONLY
         `ifndef CXP_FEV_APPROVE_SIM_ONLY
                generate
                        if (TCAM_INIT_TYPE == 1)
                                begin:  CONST_TCAM_INIT

                                        reg [TCAM_WIDTH-1:0] init_word[2*TCAM_DEPTH-1:0];
                                                
                                        initial begin

                                                for (int i = 0; i < TCAM_DEPTH; i = i + 1) begin
                                                        init_word[2*i]          = TCAM_E0_INIT_VALUE;
                                                        init_word[2*i+1]        = TCAM_E1_INIT_VALUE;
                                                end
                                                
                                        end
                                    
                                     `ifndef CXP_FPGA_TCAM_MEMS
                                        always @(posedge reset_n)
                                                if ($test$plusargs("CXP_FAST_CONFIG")) begin
                                                        for (int i = 0; i < (TCAM_DEPTH*2); i = i + 1)
                                                                behave_tcam.state[i]    = init_word[i];
                                                end
                                      `endif                                                                 
                                end
                endgenerate
          `endif
        `endif

        assign wr_bira_fail = 'b0;
        assign wr_so = 'b0;
        assign curerrout = 'b0;
        assign rscout = 'b0;

`endif

parameter       MEM_SEG_PADDING_W = 0 ; 
    `ifdef INTEL_SIMONLY
      `ifndef FEV_APPROVE_SIM_ONLY
    generate if (BCAM_N7==0 && TCAM_PROTECTION_TYPE==1 && BCAM_RELIEF==0) begin : protect    
        logic           [TCAM_WIDTH-1:0] local_tcam_back_door_update_val[2-1:0];
    
        initial begin
            clear_backdoor_ind();        
        end
       
        always @(posedge clk or negedge reset_n) begin
            if (!reset_n) begin
                            local_tcam_back_door_update_val[0]         <= 'b0;
                        local_tcam_back_door_update_val[1]         <= 'b0;
                end             
        end 
         
        always @(*) begin
            force gen_tcam_col_sweeper.tcam_col_sweeper.DETECT_ONLY.tcam_back_door_update_val = local_tcam_back_door_update_val;
        end
        
        task automatic clear_backdoor_ind();
            forever begin       
            @(posedge clk);
            if (gen_tcam_col_sweeper.tcam_col_sweeper.DETECT_ONLY.tcam_back_door_loading_indication[0]===1'b1 ||
                gen_tcam_col_sweeper.tcam_col_sweeper.DETECT_ONLY.tcam_back_door_loading_indication[1]===1'b1) begin
                    #1;
                @(posedge clk);
                    release gen_tcam_col_sweeper.tcam_col_sweeper.DETECT_ONLY.tcam_back_door_loading_indication[0]; // return to 0
                    release gen_tcam_col_sweeper.tcam_col_sweeper.DETECT_ONLY.tcam_back_door_loading_indication[1]; // return to 0
                    release gen_tcam_col_sweeper.tcam_col_sweeper.DETECT_ONLY.chk_en_swpr;
                    release gen_tcam_col_sweeper.tcam_col_sweeper.DETECT_ONLY.chk_en_swpr_prev;
                    release gen_tcam_col_sweeper.tcam_col_sweeper.DETECT_ONLY.chk_en_swpr_cycle_done;
                end
            end // END forever
        endtask
        
       task automatic update_col_sweeper(input bit pattern, input logic[512-1:0] old_val, input logic[512-1:0] new_val);
           logic [512-1:0] temp;
           if  (gen_tcam_col_sweeper.tcam_col_sweeper.tcam_init_done===1'b1) begin
                   temp = local_tcam_back_door_update_val[pattern];
               if (!($isunknown(old_val))) begin
                   temp ^= old_val;
               end
               temp ^= new_val;
               local_tcam_back_door_update_val[pattern] = temp;
               if (pattern==0)
                   force gen_tcam_col_sweeper.tcam_col_sweeper.DETECT_ONLY.tcam_back_door_loading_indication[0] = 1;
               else
                   force gen_tcam_col_sweeper.tcam_col_sweeper.DETECT_ONLY.tcam_back_door_loading_indication[1] = 1;
               force gen_tcam_col_sweeper.tcam_col_sweeper.DETECT_ONLY.chk_en_swpr_prev = 1'b0;
               force gen_tcam_col_sweeper.tcam_col_sweeper.DETECT_ONLY.chk_en_swpr = 1'b0;
               force gen_tcam_col_sweeper.tcam_col_sweeper.DETECT_ONLY.chk_en_swpr_cycle_done = 1'b1;
           end
       endtask // END update_col_sweeper
    end else begin : protect
       task automatic update_col_sweeper(input bit pattern, input logic[512-1:0] old_val, input logic[512-1:0] new_val);
       endtask // END update_col_sweeper
    end
    endgenerate
    
    // ********** backdoor MASK ***********
    // ********** this task is valid for TCAM only *****
      task automatic write_tcam_raw_key (input logic[512-1:0] key, input int row_idx);
          reg temp1,temp2;
          logic [(16 * 32) - 1:0] local_key = '1;
          logic [(16 * 32) - 1:0] prev_key_data;
          local_key[512-1:0] = TCAM_18A ? ~key : ~key;
         
          // check size out-of-bounds
          if (row_idx >= TCAM_RULES_NUM) begin
             $error("Cannot write key to idx ", row_idx, ". It exceeds logical value depth ", TCAM_RULES_NUM);
             return;         
          end
          // a. read previous data, for sweepeing purposes
          read_tcam_raw_key(prev_key_data, row_idx);
          // b. write the new key to TCAM
          `ifdef CXP_WCM_TCAM_BEHAVE_MEMS
             `ifndef CXP_FPGA_TCAM_MEMS
                  behave_tcam.state[2*row_idx] = key;
             `endif
           `else
              case (row_idx/128)
         0 :begin
         for (int j = 0;j < 16 ; j = j + 1) 
             case (j)
                                    0: begin
                                            //write_mask
                                             gen_tcam_row_0_col_0_tcam.ip783tcam128x32s0c1_wrap_tcam_row_0_col_0.tcam_row_0_col_0.ip783tcam128x32s0c1_gen_wrp_inst.ip783tcam128x32s0c1_inst.ip783tcam128x32s0c1_array.array_x[row_idx % 128] = local_key[0*(32 -2*BCAM_N7) +: 32-2*BCAM_N7];
                                             gen_tcam_row_0_col_0_tcam.ip783tcam128x32s0c1_wrap_tcam_row_0_col_0.tcam_row_0_col_0.ip783tcam128x32s0c1_gen_wrp_inst.ip783tcam128x32s0c1_inst.ip783tcam128x32s0c1_array.array_v[row_idx % 128] = 1'b1;
                                    end
                                    1: begin
                                            //write_mask
                                             gen_tcam_row_0_col_1_tcam.ip783tcam128x32s0c1_wrap_tcam_row_0_col_1.tcam_row_0_col_1.ip783tcam128x32s0c1_gen_wrp_inst.ip783tcam128x32s0c1_inst.ip783tcam128x32s0c1_array.array_x[row_idx % 128] = local_key[1*(32 -2*BCAM_N7) +: 32-2*BCAM_N7];
                                             gen_tcam_row_0_col_1_tcam.ip783tcam128x32s0c1_wrap_tcam_row_0_col_1.tcam_row_0_col_1.ip783tcam128x32s0c1_gen_wrp_inst.ip783tcam128x32s0c1_inst.ip783tcam128x32s0c1_array.array_v[row_idx % 128] = 1'b1;
                                    end
                                    2: begin
                                            //write_mask
                                             gen_tcam_row_0_col_2_tcam.ip783tcam128x32s0c1_wrap_tcam_row_0_col_2.tcam_row_0_col_2.ip783tcam128x32s0c1_gen_wrp_inst.ip783tcam128x32s0c1_inst.ip783tcam128x32s0c1_array.array_x[row_idx % 128] = local_key[2*(32 -2*BCAM_N7) +: 32-2*BCAM_N7];
                                             gen_tcam_row_0_col_2_tcam.ip783tcam128x32s0c1_wrap_tcam_row_0_col_2.tcam_row_0_col_2.ip783tcam128x32s0c1_gen_wrp_inst.ip783tcam128x32s0c1_inst.ip783tcam128x32s0c1_array.array_v[row_idx % 128] = 1'b1;
                                    end
                                    3: begin
                                            //write_mask
                                             gen_tcam_row_0_col_3_tcam.ip783tcam128x32s0c1_wrap_tcam_row_0_col_3.tcam_row_0_col_3.ip783tcam128x32s0c1_gen_wrp_inst.ip783tcam128x32s0c1_inst.ip783tcam128x32s0c1_array.array_x[row_idx % 128] = local_key[3*(32 -2*BCAM_N7) +: 32-2*BCAM_N7];
                                             gen_tcam_row_0_col_3_tcam.ip783tcam128x32s0c1_wrap_tcam_row_0_col_3.tcam_row_0_col_3.ip783tcam128x32s0c1_gen_wrp_inst.ip783tcam128x32s0c1_inst.ip783tcam128x32s0c1_array.array_v[row_idx % 128] = 1'b1;
                                    end
                                    4: begin
                                            //write_mask
                                             gen_tcam_row_0_col_4_tcam.ip783tcam128x32s0c1_wrap_tcam_row_0_col_4.tcam_row_0_col_4.ip783tcam128x32s0c1_gen_wrp_inst.ip783tcam128x32s0c1_inst.ip783tcam128x32s0c1_array.array_x[row_idx % 128] = local_key[4*(32 -2*BCAM_N7) +: 32-2*BCAM_N7];
                                             gen_tcam_row_0_col_4_tcam.ip783tcam128x32s0c1_wrap_tcam_row_0_col_4.tcam_row_0_col_4.ip783tcam128x32s0c1_gen_wrp_inst.ip783tcam128x32s0c1_inst.ip783tcam128x32s0c1_array.array_v[row_idx % 128] = 1'b1;
                                    end
                                    5: begin
                                            //write_mask
                                             gen_tcam_row_0_col_5_tcam.ip783tcam128x32s0c1_wrap_tcam_row_0_col_5.tcam_row_0_col_5.ip783tcam128x32s0c1_gen_wrp_inst.ip783tcam128x32s0c1_inst.ip783tcam128x32s0c1_array.array_x[row_idx % 128] = local_key[5*(32 -2*BCAM_N7) +: 32-2*BCAM_N7];
                                             gen_tcam_row_0_col_5_tcam.ip783tcam128x32s0c1_wrap_tcam_row_0_col_5.tcam_row_0_col_5.ip783tcam128x32s0c1_gen_wrp_inst.ip783tcam128x32s0c1_inst.ip783tcam128x32s0c1_array.array_v[row_idx % 128] = 1'b1;
                                    end
                                    6: begin
                                            //write_mask
                                             gen_tcam_row_0_col_6_tcam.ip783tcam128x32s0c1_wrap_tcam_row_0_col_6.tcam_row_0_col_6.ip783tcam128x32s0c1_gen_wrp_inst.ip783tcam128x32s0c1_inst.ip783tcam128x32s0c1_array.array_x[row_idx % 128] = local_key[6*(32 -2*BCAM_N7) +: 32-2*BCAM_N7];
                                             gen_tcam_row_0_col_6_tcam.ip783tcam128x32s0c1_wrap_tcam_row_0_col_6.tcam_row_0_col_6.ip783tcam128x32s0c1_gen_wrp_inst.ip783tcam128x32s0c1_inst.ip783tcam128x32s0c1_array.array_v[row_idx % 128] = 1'b1;
                                    end
                                    7: begin
                                            //write_mask
                                             gen_tcam_row_0_col_7_tcam.ip783tcam128x32s0c1_wrap_tcam_row_0_col_7.tcam_row_0_col_7.ip783tcam128x32s0c1_gen_wrp_inst.ip783tcam128x32s0c1_inst.ip783tcam128x32s0c1_array.array_x[row_idx % 128] = local_key[7*(32 -2*BCAM_N7) +: 32-2*BCAM_N7];
                                             gen_tcam_row_0_col_7_tcam.ip783tcam128x32s0c1_wrap_tcam_row_0_col_7.tcam_row_0_col_7.ip783tcam128x32s0c1_gen_wrp_inst.ip783tcam128x32s0c1_inst.ip783tcam128x32s0c1_array.array_v[row_idx % 128] = 1'b1;
                                    end
                                    8: begin
                                            //write_mask
                                             gen_tcam_row_0_col_8_tcam.ip783tcam128x32s0c1_wrap_tcam_row_0_col_8.tcam_row_0_col_8.ip783tcam128x32s0c1_gen_wrp_inst.ip783tcam128x32s0c1_inst.ip783tcam128x32s0c1_array.array_x[row_idx % 128] = local_key[8*(32 -2*BCAM_N7) +: 32-2*BCAM_N7];
                                             gen_tcam_row_0_col_8_tcam.ip783tcam128x32s0c1_wrap_tcam_row_0_col_8.tcam_row_0_col_8.ip783tcam128x32s0c1_gen_wrp_inst.ip783tcam128x32s0c1_inst.ip783tcam128x32s0c1_array.array_v[row_idx % 128] = 1'b1;
                                    end
                                    9: begin
                                            //write_mask
                                             gen_tcam_row_0_col_9_tcam.ip783tcam128x32s0c1_wrap_tcam_row_0_col_9.tcam_row_0_col_9.ip783tcam128x32s0c1_gen_wrp_inst.ip783tcam128x32s0c1_inst.ip783tcam128x32s0c1_array.array_x[row_idx % 128] = local_key[9*(32 -2*BCAM_N7) +: 32-2*BCAM_N7];
                                             gen_tcam_row_0_col_9_tcam.ip783tcam128x32s0c1_wrap_tcam_row_0_col_9.tcam_row_0_col_9.ip783tcam128x32s0c1_gen_wrp_inst.ip783tcam128x32s0c1_inst.ip783tcam128x32s0c1_array.array_v[row_idx % 128] = 1'b1;
                                    end
                                    10: begin
                                            //write_mask
                                             gen_tcam_row_0_col_10_tcam.ip783tcam128x32s0c1_wrap_tcam_row_0_col_10.tcam_row_0_col_10.ip783tcam128x32s0c1_gen_wrp_inst.ip783tcam128x32s0c1_inst.ip783tcam128x32s0c1_array.array_x[row_idx % 128] = local_key[10*(32 -2*BCAM_N7) +: 32-2*BCAM_N7];
                                             gen_tcam_row_0_col_10_tcam.ip783tcam128x32s0c1_wrap_tcam_row_0_col_10.tcam_row_0_col_10.ip783tcam128x32s0c1_gen_wrp_inst.ip783tcam128x32s0c1_inst.ip783tcam128x32s0c1_array.array_v[row_idx % 128] = 1'b1;
                                    end
                                    11: begin
                                            //write_mask
                                             gen_tcam_row_0_col_11_tcam.ip783tcam128x32s0c1_wrap_tcam_row_0_col_11.tcam_row_0_col_11.ip783tcam128x32s0c1_gen_wrp_inst.ip783tcam128x32s0c1_inst.ip783tcam128x32s0c1_array.array_x[row_idx % 128] = local_key[11*(32 -2*BCAM_N7) +: 32-2*BCAM_N7];
                                             gen_tcam_row_0_col_11_tcam.ip783tcam128x32s0c1_wrap_tcam_row_0_col_11.tcam_row_0_col_11.ip783tcam128x32s0c1_gen_wrp_inst.ip783tcam128x32s0c1_inst.ip783tcam128x32s0c1_array.array_v[row_idx % 128] = 1'b1;
                                    end
                                    12: begin
                                            //write_mask
                                             gen_tcam_row_0_col_12_tcam.ip783tcam128x32s0c1_wrap_tcam_row_0_col_12.tcam_row_0_col_12.ip783tcam128x32s0c1_gen_wrp_inst.ip783tcam128x32s0c1_inst.ip783tcam128x32s0c1_array.array_x[row_idx % 128] = local_key[12*(32 -2*BCAM_N7) +: 32-2*BCAM_N7];
                                             gen_tcam_row_0_col_12_tcam.ip783tcam128x32s0c1_wrap_tcam_row_0_col_12.tcam_row_0_col_12.ip783tcam128x32s0c1_gen_wrp_inst.ip783tcam128x32s0c1_inst.ip783tcam128x32s0c1_array.array_v[row_idx % 128] = 1'b1;
                                    end
                                    13: begin
                                            //write_mask
                                             gen_tcam_row_0_col_13_tcam.ip783tcam128x32s0c1_wrap_tcam_row_0_col_13.tcam_row_0_col_13.ip783tcam128x32s0c1_gen_wrp_inst.ip783tcam128x32s0c1_inst.ip783tcam128x32s0c1_array.array_x[row_idx % 128] = local_key[13*(32 -2*BCAM_N7) +: 32-2*BCAM_N7];
                                             gen_tcam_row_0_col_13_tcam.ip783tcam128x32s0c1_wrap_tcam_row_0_col_13.tcam_row_0_col_13.ip783tcam128x32s0c1_gen_wrp_inst.ip783tcam128x32s0c1_inst.ip783tcam128x32s0c1_array.array_v[row_idx % 128] = 1'b1;
                                    end
                                    14: begin
                                            //write_mask
                                             gen_tcam_row_0_col_14_tcam.ip783tcam128x32s0c1_wrap_tcam_row_0_col_14.tcam_row_0_col_14.ip783tcam128x32s0c1_gen_wrp_inst.ip783tcam128x32s0c1_inst.ip783tcam128x32s0c1_array.array_x[row_idx % 128] = local_key[14*(32 -2*BCAM_N7) +: 32-2*BCAM_N7];
                                             gen_tcam_row_0_col_14_tcam.ip783tcam128x32s0c1_wrap_tcam_row_0_col_14.tcam_row_0_col_14.ip783tcam128x32s0c1_gen_wrp_inst.ip783tcam128x32s0c1_inst.ip783tcam128x32s0c1_array.array_v[row_idx % 128] = 1'b1;
                                    end
                                    15: begin
                                            //write_mask
                                             gen_tcam_row_0_col_15_tcam.ip783tcam128x32s0c1_wrap_tcam_row_0_col_15.tcam_row_0_col_15.ip783tcam128x32s0c1_gen_wrp_inst.ip783tcam128x32s0c1_inst.ip783tcam128x32s0c1_array.array_x[row_idx % 128] = local_key[15*(32 -2*BCAM_N7) +: 32-2*BCAM_N7];
                                             gen_tcam_row_0_col_15_tcam.ip783tcam128x32s0c1_wrap_tcam_row_0_col_15.tcam_row_0_col_15.ip783tcam128x32s0c1_gen_wrp_inst.ip783tcam128x32s0c1_inst.ip783tcam128x32s0c1_array.array_v[row_idx % 128] = 1'b1;
                                    end
                                    default : begin
                                       $error("SOMTING IS wrong with parameters given for col number %d ",j);
                                     end
              endcase
                      
        end // 0 
              endcase //(row_idx/128)
            `endif
         // c. update sweeper with new data    
         protect.update_col_sweeper(0, prev_key_data, key);
       endtask // END write_tcam_raw_key
    
    
       // ********** backdoor DATA ***********
        task automatic write_tcam_raw_inv_key (input logic[512-1:0] inv_key, input int row_idx);
          reg temp1,temp2;
          logic [(16 * 32) - 1:0] local_inv_key = '0;
          logic [(16 * 32) - 1:0] prev_inv_key_data;
          local_inv_key[512-1:0] = TCAM_18A ? ~inv_key : ~inv_key;
                                 
          // check size out-of-bounds
          if (row_idx >= TCAM_RULES_NUM) begin
             $error("Cannot write inv_key to idx ", row_idx, ", It exceeds logical value depth ", TCAM_RULES_NUM);
             return;         
          end
          // a. read previous data, for sweepeing purposes
          read_tcam_raw_inv_key(prev_inv_key_data, row_idx);
          // b. write the new inv_key to TCAM
          `ifdef CXP_WCM_TCAM_BEHAVE_MEMS
               `ifndef CXP_FPGA_TCAM_MEMS
                  behave_tcam.state[2*row_idx+1] = inv_key;
               `endif
          `else
              case (row_idx/128)
         0 :begin
         for (int j = 0;j < 16 ; j = j + 1) 
             case (j)
                                    0: begin
                                            //write_DATA
                                             gen_tcam_row_0_col_0_tcam.ip783tcam128x32s0c1_wrap_tcam_row_0_col_0.tcam_row_0_col_0.ip783tcam128x32s0c1_gen_wrp_inst.ip783tcam128x32s0c1_inst.ip783tcam128x32s0c1_array.array_y[row_idx % 128] = local_inv_key[0*(32 -2*BCAM_N7) +: 32-2*BCAM_N7];
                                             gen_tcam_row_0_col_0_tcam.ip783tcam128x32s0c1_wrap_tcam_row_0_col_0.tcam_row_0_col_0.ip783tcam128x32s0c1_gen_wrp_inst.ip783tcam128x32s0c1_inst.ip783tcam128x32s0c1_array.array_v[row_idx % 128] = 1'b1;
                                    end
                                    1: begin
                                            //write_DATA
                                             gen_tcam_row_0_col_1_tcam.ip783tcam128x32s0c1_wrap_tcam_row_0_col_1.tcam_row_0_col_1.ip783tcam128x32s0c1_gen_wrp_inst.ip783tcam128x32s0c1_inst.ip783tcam128x32s0c1_array.array_y[row_idx % 128] = local_inv_key[1*(32 -2*BCAM_N7) +: 32-2*BCAM_N7];
                                             gen_tcam_row_0_col_1_tcam.ip783tcam128x32s0c1_wrap_tcam_row_0_col_1.tcam_row_0_col_1.ip783tcam128x32s0c1_gen_wrp_inst.ip783tcam128x32s0c1_inst.ip783tcam128x32s0c1_array.array_v[row_idx % 128] = 1'b1;
                                    end
                                    2: begin
                                            //write_DATA
                                             gen_tcam_row_0_col_2_tcam.ip783tcam128x32s0c1_wrap_tcam_row_0_col_2.tcam_row_0_col_2.ip783tcam128x32s0c1_gen_wrp_inst.ip783tcam128x32s0c1_inst.ip783tcam128x32s0c1_array.array_y[row_idx % 128] = local_inv_key[2*(32 -2*BCAM_N7) +: 32-2*BCAM_N7];
                                             gen_tcam_row_0_col_2_tcam.ip783tcam128x32s0c1_wrap_tcam_row_0_col_2.tcam_row_0_col_2.ip783tcam128x32s0c1_gen_wrp_inst.ip783tcam128x32s0c1_inst.ip783tcam128x32s0c1_array.array_v[row_idx % 128] = 1'b1;
                                    end
                                    3: begin
                                            //write_DATA
                                             gen_tcam_row_0_col_3_tcam.ip783tcam128x32s0c1_wrap_tcam_row_0_col_3.tcam_row_0_col_3.ip783tcam128x32s0c1_gen_wrp_inst.ip783tcam128x32s0c1_inst.ip783tcam128x32s0c1_array.array_y[row_idx % 128] = local_inv_key[3*(32 -2*BCAM_N7) +: 32-2*BCAM_N7];
                                             gen_tcam_row_0_col_3_tcam.ip783tcam128x32s0c1_wrap_tcam_row_0_col_3.tcam_row_0_col_3.ip783tcam128x32s0c1_gen_wrp_inst.ip783tcam128x32s0c1_inst.ip783tcam128x32s0c1_array.array_v[row_idx % 128] = 1'b1;
                                    end
                                    4: begin
                                            //write_DATA
                                             gen_tcam_row_0_col_4_tcam.ip783tcam128x32s0c1_wrap_tcam_row_0_col_4.tcam_row_0_col_4.ip783tcam128x32s0c1_gen_wrp_inst.ip783tcam128x32s0c1_inst.ip783tcam128x32s0c1_array.array_y[row_idx % 128] = local_inv_key[4*(32 -2*BCAM_N7) +: 32-2*BCAM_N7];
                                             gen_tcam_row_0_col_4_tcam.ip783tcam128x32s0c1_wrap_tcam_row_0_col_4.tcam_row_0_col_4.ip783tcam128x32s0c1_gen_wrp_inst.ip783tcam128x32s0c1_inst.ip783tcam128x32s0c1_array.array_v[row_idx % 128] = 1'b1;
                                    end
                                    5: begin
                                            //write_DATA
                                             gen_tcam_row_0_col_5_tcam.ip783tcam128x32s0c1_wrap_tcam_row_0_col_5.tcam_row_0_col_5.ip783tcam128x32s0c1_gen_wrp_inst.ip783tcam128x32s0c1_inst.ip783tcam128x32s0c1_array.array_y[row_idx % 128] = local_inv_key[5*(32 -2*BCAM_N7) +: 32-2*BCAM_N7];
                                             gen_tcam_row_0_col_5_tcam.ip783tcam128x32s0c1_wrap_tcam_row_0_col_5.tcam_row_0_col_5.ip783tcam128x32s0c1_gen_wrp_inst.ip783tcam128x32s0c1_inst.ip783tcam128x32s0c1_array.array_v[row_idx % 128] = 1'b1;
                                    end
                                    6: begin
                                            //write_DATA
                                             gen_tcam_row_0_col_6_tcam.ip783tcam128x32s0c1_wrap_tcam_row_0_col_6.tcam_row_0_col_6.ip783tcam128x32s0c1_gen_wrp_inst.ip783tcam128x32s0c1_inst.ip783tcam128x32s0c1_array.array_y[row_idx % 128] = local_inv_key[6*(32 -2*BCAM_N7) +: 32-2*BCAM_N7];
                                             gen_tcam_row_0_col_6_tcam.ip783tcam128x32s0c1_wrap_tcam_row_0_col_6.tcam_row_0_col_6.ip783tcam128x32s0c1_gen_wrp_inst.ip783tcam128x32s0c1_inst.ip783tcam128x32s0c1_array.array_v[row_idx % 128] = 1'b1;
                                    end
                                    7: begin
                                            //write_DATA
                                             gen_tcam_row_0_col_7_tcam.ip783tcam128x32s0c1_wrap_tcam_row_0_col_7.tcam_row_0_col_7.ip783tcam128x32s0c1_gen_wrp_inst.ip783tcam128x32s0c1_inst.ip783tcam128x32s0c1_array.array_y[row_idx % 128] = local_inv_key[7*(32 -2*BCAM_N7) +: 32-2*BCAM_N7];
                                             gen_tcam_row_0_col_7_tcam.ip783tcam128x32s0c1_wrap_tcam_row_0_col_7.tcam_row_0_col_7.ip783tcam128x32s0c1_gen_wrp_inst.ip783tcam128x32s0c1_inst.ip783tcam128x32s0c1_array.array_v[row_idx % 128] = 1'b1;
                                    end
                                    8: begin
                                            //write_DATA
                                             gen_tcam_row_0_col_8_tcam.ip783tcam128x32s0c1_wrap_tcam_row_0_col_8.tcam_row_0_col_8.ip783tcam128x32s0c1_gen_wrp_inst.ip783tcam128x32s0c1_inst.ip783tcam128x32s0c1_array.array_y[row_idx % 128] = local_inv_key[8*(32 -2*BCAM_N7) +: 32-2*BCAM_N7];
                                             gen_tcam_row_0_col_8_tcam.ip783tcam128x32s0c1_wrap_tcam_row_0_col_8.tcam_row_0_col_8.ip783tcam128x32s0c1_gen_wrp_inst.ip783tcam128x32s0c1_inst.ip783tcam128x32s0c1_array.array_v[row_idx % 128] = 1'b1;
                                    end
                                    9: begin
                                            //write_DATA
                                             gen_tcam_row_0_col_9_tcam.ip783tcam128x32s0c1_wrap_tcam_row_0_col_9.tcam_row_0_col_9.ip783tcam128x32s0c1_gen_wrp_inst.ip783tcam128x32s0c1_inst.ip783tcam128x32s0c1_array.array_y[row_idx % 128] = local_inv_key[9*(32 -2*BCAM_N7) +: 32-2*BCAM_N7];
                                             gen_tcam_row_0_col_9_tcam.ip783tcam128x32s0c1_wrap_tcam_row_0_col_9.tcam_row_0_col_9.ip783tcam128x32s0c1_gen_wrp_inst.ip783tcam128x32s0c1_inst.ip783tcam128x32s0c1_array.array_v[row_idx % 128] = 1'b1;
                                    end
                                    10: begin
                                            //write_DATA
                                             gen_tcam_row_0_col_10_tcam.ip783tcam128x32s0c1_wrap_tcam_row_0_col_10.tcam_row_0_col_10.ip783tcam128x32s0c1_gen_wrp_inst.ip783tcam128x32s0c1_inst.ip783tcam128x32s0c1_array.array_y[row_idx % 128] = local_inv_key[10*(32 -2*BCAM_N7) +: 32-2*BCAM_N7];
                                             gen_tcam_row_0_col_10_tcam.ip783tcam128x32s0c1_wrap_tcam_row_0_col_10.tcam_row_0_col_10.ip783tcam128x32s0c1_gen_wrp_inst.ip783tcam128x32s0c1_inst.ip783tcam128x32s0c1_array.array_v[row_idx % 128] = 1'b1;
                                    end
                                    11: begin
                                            //write_DATA
                                             gen_tcam_row_0_col_11_tcam.ip783tcam128x32s0c1_wrap_tcam_row_0_col_11.tcam_row_0_col_11.ip783tcam128x32s0c1_gen_wrp_inst.ip783tcam128x32s0c1_inst.ip783tcam128x32s0c1_array.array_y[row_idx % 128] = local_inv_key[11*(32 -2*BCAM_N7) +: 32-2*BCAM_N7];
                                             gen_tcam_row_0_col_11_tcam.ip783tcam128x32s0c1_wrap_tcam_row_0_col_11.tcam_row_0_col_11.ip783tcam128x32s0c1_gen_wrp_inst.ip783tcam128x32s0c1_inst.ip783tcam128x32s0c1_array.array_v[row_idx % 128] = 1'b1;
                                    end
                                    12: begin
                                            //write_DATA
                                             gen_tcam_row_0_col_12_tcam.ip783tcam128x32s0c1_wrap_tcam_row_0_col_12.tcam_row_0_col_12.ip783tcam128x32s0c1_gen_wrp_inst.ip783tcam128x32s0c1_inst.ip783tcam128x32s0c1_array.array_y[row_idx % 128] = local_inv_key[12*(32 -2*BCAM_N7) +: 32-2*BCAM_N7];
                                             gen_tcam_row_0_col_12_tcam.ip783tcam128x32s0c1_wrap_tcam_row_0_col_12.tcam_row_0_col_12.ip783tcam128x32s0c1_gen_wrp_inst.ip783tcam128x32s0c1_inst.ip783tcam128x32s0c1_array.array_v[row_idx % 128] = 1'b1;
                                    end
                                    13: begin
                                            //write_DATA
                                             gen_tcam_row_0_col_13_tcam.ip783tcam128x32s0c1_wrap_tcam_row_0_col_13.tcam_row_0_col_13.ip783tcam128x32s0c1_gen_wrp_inst.ip783tcam128x32s0c1_inst.ip783tcam128x32s0c1_array.array_y[row_idx % 128] = local_inv_key[13*(32 -2*BCAM_N7) +: 32-2*BCAM_N7];
                                             gen_tcam_row_0_col_13_tcam.ip783tcam128x32s0c1_wrap_tcam_row_0_col_13.tcam_row_0_col_13.ip783tcam128x32s0c1_gen_wrp_inst.ip783tcam128x32s0c1_inst.ip783tcam128x32s0c1_array.array_v[row_idx % 128] = 1'b1;
                                    end
                                    14: begin
                                            //write_DATA
                                             gen_tcam_row_0_col_14_tcam.ip783tcam128x32s0c1_wrap_tcam_row_0_col_14.tcam_row_0_col_14.ip783tcam128x32s0c1_gen_wrp_inst.ip783tcam128x32s0c1_inst.ip783tcam128x32s0c1_array.array_y[row_idx % 128] = local_inv_key[14*(32 -2*BCAM_N7) +: 32-2*BCAM_N7];
                                             gen_tcam_row_0_col_14_tcam.ip783tcam128x32s0c1_wrap_tcam_row_0_col_14.tcam_row_0_col_14.ip783tcam128x32s0c1_gen_wrp_inst.ip783tcam128x32s0c1_inst.ip783tcam128x32s0c1_array.array_v[row_idx % 128] = 1'b1;
                                    end
                                    15: begin
                                            //write_DATA
                                             gen_tcam_row_0_col_15_tcam.ip783tcam128x32s0c1_wrap_tcam_row_0_col_15.tcam_row_0_col_15.ip783tcam128x32s0c1_gen_wrp_inst.ip783tcam128x32s0c1_inst.ip783tcam128x32s0c1_array.array_y[row_idx % 128] = local_inv_key[15*(32 -2*BCAM_N7) +: 32-2*BCAM_N7];
                                             gen_tcam_row_0_col_15_tcam.ip783tcam128x32s0c1_wrap_tcam_row_0_col_15.tcam_row_0_col_15.ip783tcam128x32s0c1_gen_wrp_inst.ip783tcam128x32s0c1_inst.ip783tcam128x32s0c1_array.array_v[row_idx % 128] = 1'b1;
                                    end
                                    default : begin
                                       $error("SOMTING IS wrong with parameters given for col number %d ",j);
                                     end
              endcase
                      
        end // 0 
              endcase //(row_idx/128)
          `endif
          // c. update sweeper with new data
          protect.update_col_sweeper(1, prev_inv_key_data, inv_key);
       endtask // END write_tcam_raw_inv_key
       
       task automatic write_tcam_raw_line (input logic[512-1:0] key, input logic [512-1:0] inv_key, input int row_idx);
              write_tcam_raw_key(key, row_idx);
              write_tcam_raw_inv_key(inv_key, row_idx);
              // set the vbit of a row
              `ifndef CXP_WCM_TCAM_BEHAVE_MEMS
                   case (row_idx/128)
         0 :begin
         for (int j = 0;j < 16 ; j = j + 1) 
             case (j)
                                    0: begin
                                    end
                                    1: begin
                                    end
                                    2: begin
                                    end
                                    3: begin
                                    end
                                    4: begin
                                    end
                                    5: begin
                                    end
                                    6: begin
                                    end
                                    7: begin
                                    end
                                    8: begin
                                    end
                                    9: begin
                                    end
                                    10: begin
                                    end
                                    11: begin
                                    end
                                    12: begin
                                    end
                                    13: begin
                                    end
                                    14: begin
                                    end
                                    15: begin
                                    end
                                    default : begin
                                       $error("SOMTING IS wrong with parameters given for col number %d ",j);
                                     end
              endcase
                      
        end // 0 
                   endcase //(row_idx/128)
              `endif      
       endtask // END write_tcam_raw_line
    
     
       // ********** backdoor MASK ***********
       //****this task is valid for TCAM only*****
       task automatic read_tcam_raw_key (output logic[512-1:0] key, input int row_idx);
           reg temp1,valid_word;
           logic [(16 * 32) - 1:0] local_key;
           // check size out-of-bounds
           if (row_idx >= TCAM_RULES_NUM) begin
               $error("Cannot read key from idx ", row_idx, ". It exceeds logical value depth ", TCAM_RULES_NUM);
               return;                                  
           end
             `ifdef CXP_WCM_TCAM_BEHAVE_MEMS
                `ifndef CXP_FPGA_TCAM_MEMS
                   key = behave_tcam.state[2*row_idx];
                 `endif
             `else
                 case (row_idx/128)
         0 :begin
         for (int j = 0;j < 16 ; j = j + 1) 
             case (j)
                                    0: begin
                                            //READ_mask
                                             local_key[0*32 +: 32] = gen_tcam_row_0_col_0_tcam.ip783tcam128x32s0c1_wrap_tcam_row_0_col_0.tcam_row_0_col_0.ip783tcam128x32s0c1_gen_wrp_inst.ip783tcam128x32s0c1_inst.ip783tcam128x32s0c1_array.array_x[row_idx % 128];
                                    end
                                    1: begin
                                            //READ_mask
                                             local_key[1*32 +: 32] = gen_tcam_row_0_col_1_tcam.ip783tcam128x32s0c1_wrap_tcam_row_0_col_1.tcam_row_0_col_1.ip783tcam128x32s0c1_gen_wrp_inst.ip783tcam128x32s0c1_inst.ip783tcam128x32s0c1_array.array_x[row_idx % 128];
                                    end
                                    2: begin
                                            //READ_mask
                                             local_key[2*32 +: 32] = gen_tcam_row_0_col_2_tcam.ip783tcam128x32s0c1_wrap_tcam_row_0_col_2.tcam_row_0_col_2.ip783tcam128x32s0c1_gen_wrp_inst.ip783tcam128x32s0c1_inst.ip783tcam128x32s0c1_array.array_x[row_idx % 128];
                                    end
                                    3: begin
                                            //READ_mask
                                             local_key[3*32 +: 32] = gen_tcam_row_0_col_3_tcam.ip783tcam128x32s0c1_wrap_tcam_row_0_col_3.tcam_row_0_col_3.ip783tcam128x32s0c1_gen_wrp_inst.ip783tcam128x32s0c1_inst.ip783tcam128x32s0c1_array.array_x[row_idx % 128];
                                    end
                                    4: begin
                                            //READ_mask
                                             local_key[4*32 +: 32] = gen_tcam_row_0_col_4_tcam.ip783tcam128x32s0c1_wrap_tcam_row_0_col_4.tcam_row_0_col_4.ip783tcam128x32s0c1_gen_wrp_inst.ip783tcam128x32s0c1_inst.ip783tcam128x32s0c1_array.array_x[row_idx % 128];
                                    end
                                    5: begin
                                            //READ_mask
                                             local_key[5*32 +: 32] = gen_tcam_row_0_col_5_tcam.ip783tcam128x32s0c1_wrap_tcam_row_0_col_5.tcam_row_0_col_5.ip783tcam128x32s0c1_gen_wrp_inst.ip783tcam128x32s0c1_inst.ip783tcam128x32s0c1_array.array_x[row_idx % 128];
                                    end
                                    6: begin
                                            //READ_mask
                                             local_key[6*32 +: 32] = gen_tcam_row_0_col_6_tcam.ip783tcam128x32s0c1_wrap_tcam_row_0_col_6.tcam_row_0_col_6.ip783tcam128x32s0c1_gen_wrp_inst.ip783tcam128x32s0c1_inst.ip783tcam128x32s0c1_array.array_x[row_idx % 128];
                                    end
                                    7: begin
                                            //READ_mask
                                             local_key[7*32 +: 32] = gen_tcam_row_0_col_7_tcam.ip783tcam128x32s0c1_wrap_tcam_row_0_col_7.tcam_row_0_col_7.ip783tcam128x32s0c1_gen_wrp_inst.ip783tcam128x32s0c1_inst.ip783tcam128x32s0c1_array.array_x[row_idx % 128];
                                    end
                                    8: begin
                                            //READ_mask
                                             local_key[8*32 +: 32] = gen_tcam_row_0_col_8_tcam.ip783tcam128x32s0c1_wrap_tcam_row_0_col_8.tcam_row_0_col_8.ip783tcam128x32s0c1_gen_wrp_inst.ip783tcam128x32s0c1_inst.ip783tcam128x32s0c1_array.array_x[row_idx % 128];
                                    end
                                    9: begin
                                            //READ_mask
                                             local_key[9*32 +: 32] = gen_tcam_row_0_col_9_tcam.ip783tcam128x32s0c1_wrap_tcam_row_0_col_9.tcam_row_0_col_9.ip783tcam128x32s0c1_gen_wrp_inst.ip783tcam128x32s0c1_inst.ip783tcam128x32s0c1_array.array_x[row_idx % 128];
                                    end
                                    10: begin
                                            //READ_mask
                                             local_key[10*32 +: 32] = gen_tcam_row_0_col_10_tcam.ip783tcam128x32s0c1_wrap_tcam_row_0_col_10.tcam_row_0_col_10.ip783tcam128x32s0c1_gen_wrp_inst.ip783tcam128x32s0c1_inst.ip783tcam128x32s0c1_array.array_x[row_idx % 128];
                                    end
                                    11: begin
                                            //READ_mask
                                             local_key[11*32 +: 32] = gen_tcam_row_0_col_11_tcam.ip783tcam128x32s0c1_wrap_tcam_row_0_col_11.tcam_row_0_col_11.ip783tcam128x32s0c1_gen_wrp_inst.ip783tcam128x32s0c1_inst.ip783tcam128x32s0c1_array.array_x[row_idx % 128];
                                    end
                                    12: begin
                                            //READ_mask
                                             local_key[12*32 +: 32] = gen_tcam_row_0_col_12_tcam.ip783tcam128x32s0c1_wrap_tcam_row_0_col_12.tcam_row_0_col_12.ip783tcam128x32s0c1_gen_wrp_inst.ip783tcam128x32s0c1_inst.ip783tcam128x32s0c1_array.array_x[row_idx % 128];
                                    end
                                    13: begin
                                            //READ_mask
                                             local_key[13*32 +: 32] = gen_tcam_row_0_col_13_tcam.ip783tcam128x32s0c1_wrap_tcam_row_0_col_13.tcam_row_0_col_13.ip783tcam128x32s0c1_gen_wrp_inst.ip783tcam128x32s0c1_inst.ip783tcam128x32s0c1_array.array_x[row_idx % 128];
                                    end
                                    14: begin
                                            //READ_mask
                                             local_key[14*32 +: 32] = gen_tcam_row_0_col_14_tcam.ip783tcam128x32s0c1_wrap_tcam_row_0_col_14.tcam_row_0_col_14.ip783tcam128x32s0c1_gen_wrp_inst.ip783tcam128x32s0c1_inst.ip783tcam128x32s0c1_array.array_x[row_idx % 128];
                                    end
                                    15: begin
                                            //READ_mask
                                             local_key[15*32 +: 32] = gen_tcam_row_0_col_15_tcam.ip783tcam128x32s0c1_wrap_tcam_row_0_col_15.tcam_row_0_col_15.ip783tcam128x32s0c1_gen_wrp_inst.ip783tcam128x32s0c1_inst.ip783tcam128x32s0c1_array.array_x[row_idx % 128];
                                    end
                                    default : begin
                                       $error("SOMTING IS wrong with parameters given for col number %d ",j);
                                     end
              endcase
                      
        end // 0 
                 endcase //(row_idx/128)
                 key = TCAM_18A ? ~local_key : ~local_key;
             `endif
       endtask // END read_tcam_raw_key
    
    
     // ********** backdoor DATA ***********
       task automatic read_tcam_raw_inv_key (output logic[512-1:0] inv_key, input int row_idx);
           reg temp1,valid_word;
           logic [(16 * 32) - 1:0] local_inv_key;
           // check size out-of-bounds
           if (row_idx >= TCAM_RULES_NUM) begin
               $error("Cannot read inv_key from idx ", row_idx, ". It exceeds logical value depth ", TCAM_RULES_NUM);
               return;                                  
           end
    
             `ifdef CXP_WCM_TCAM_BEHAVE_MEMS
                  `ifndef CXP_FPGA_TCAM_MEMS
                     inv_key = behave_tcam.state[2*row_idx+1];
                  `endif
             `else
                 case (row_idx/128)
         0 :begin
         for (int j = 0;j < 16 ; j = j + 1) 
             case (j)
                                    0: begin
                                            //READ_data
                                             local_inv_key[0*32 +: 32] = gen_tcam_row_0_col_0_tcam.ip783tcam128x32s0c1_wrap_tcam_row_0_col_0.tcam_row_0_col_0.ip783tcam128x32s0c1_gen_wrp_inst.ip783tcam128x32s0c1_inst.ip783tcam128x32s0c1_array.array_y[row_idx % 128];
                                    end
                                    1: begin
                                            //READ_data
                                             local_inv_key[1*32 +: 32] = gen_tcam_row_0_col_1_tcam.ip783tcam128x32s0c1_wrap_tcam_row_0_col_1.tcam_row_0_col_1.ip783tcam128x32s0c1_gen_wrp_inst.ip783tcam128x32s0c1_inst.ip783tcam128x32s0c1_array.array_y[row_idx % 128];
                                    end
                                    2: begin
                                            //READ_data
                                             local_inv_key[2*32 +: 32] = gen_tcam_row_0_col_2_tcam.ip783tcam128x32s0c1_wrap_tcam_row_0_col_2.tcam_row_0_col_2.ip783tcam128x32s0c1_gen_wrp_inst.ip783tcam128x32s0c1_inst.ip783tcam128x32s0c1_array.array_y[row_idx % 128];
                                    end
                                    3: begin
                                            //READ_data
                                             local_inv_key[3*32 +: 32] = gen_tcam_row_0_col_3_tcam.ip783tcam128x32s0c1_wrap_tcam_row_0_col_3.tcam_row_0_col_3.ip783tcam128x32s0c1_gen_wrp_inst.ip783tcam128x32s0c1_inst.ip783tcam128x32s0c1_array.array_y[row_idx % 128];
                                    end
                                    4: begin
                                            //READ_data
                                             local_inv_key[4*32 +: 32] = gen_tcam_row_0_col_4_tcam.ip783tcam128x32s0c1_wrap_tcam_row_0_col_4.tcam_row_0_col_4.ip783tcam128x32s0c1_gen_wrp_inst.ip783tcam128x32s0c1_inst.ip783tcam128x32s0c1_array.array_y[row_idx % 128];
                                    end
                                    5: begin
                                            //READ_data
                                             local_inv_key[5*32 +: 32] = gen_tcam_row_0_col_5_tcam.ip783tcam128x32s0c1_wrap_tcam_row_0_col_5.tcam_row_0_col_5.ip783tcam128x32s0c1_gen_wrp_inst.ip783tcam128x32s0c1_inst.ip783tcam128x32s0c1_array.array_y[row_idx % 128];
                                    end
                                    6: begin
                                            //READ_data
                                             local_inv_key[6*32 +: 32] = gen_tcam_row_0_col_6_tcam.ip783tcam128x32s0c1_wrap_tcam_row_0_col_6.tcam_row_0_col_6.ip783tcam128x32s0c1_gen_wrp_inst.ip783tcam128x32s0c1_inst.ip783tcam128x32s0c1_array.array_y[row_idx % 128];
                                    end
                                    7: begin
                                            //READ_data
                                             local_inv_key[7*32 +: 32] = gen_tcam_row_0_col_7_tcam.ip783tcam128x32s0c1_wrap_tcam_row_0_col_7.tcam_row_0_col_7.ip783tcam128x32s0c1_gen_wrp_inst.ip783tcam128x32s0c1_inst.ip783tcam128x32s0c1_array.array_y[row_idx % 128];
                                    end
                                    8: begin
                                            //READ_data
                                             local_inv_key[8*32 +: 32] = gen_tcam_row_0_col_8_tcam.ip783tcam128x32s0c1_wrap_tcam_row_0_col_8.tcam_row_0_col_8.ip783tcam128x32s0c1_gen_wrp_inst.ip783tcam128x32s0c1_inst.ip783tcam128x32s0c1_array.array_y[row_idx % 128];
                                    end
                                    9: begin
                                            //READ_data
                                             local_inv_key[9*32 +: 32] = gen_tcam_row_0_col_9_tcam.ip783tcam128x32s0c1_wrap_tcam_row_0_col_9.tcam_row_0_col_9.ip783tcam128x32s0c1_gen_wrp_inst.ip783tcam128x32s0c1_inst.ip783tcam128x32s0c1_array.array_y[row_idx % 128];
                                    end
                                    10: begin
                                            //READ_data
                                             local_inv_key[10*32 +: 32] = gen_tcam_row_0_col_10_tcam.ip783tcam128x32s0c1_wrap_tcam_row_0_col_10.tcam_row_0_col_10.ip783tcam128x32s0c1_gen_wrp_inst.ip783tcam128x32s0c1_inst.ip783tcam128x32s0c1_array.array_y[row_idx % 128];
                                    end
                                    11: begin
                                            //READ_data
                                             local_inv_key[11*32 +: 32] = gen_tcam_row_0_col_11_tcam.ip783tcam128x32s0c1_wrap_tcam_row_0_col_11.tcam_row_0_col_11.ip783tcam128x32s0c1_gen_wrp_inst.ip783tcam128x32s0c1_inst.ip783tcam128x32s0c1_array.array_y[row_idx % 128];
                                    end
                                    12: begin
                                            //READ_data
                                             local_inv_key[12*32 +: 32] = gen_tcam_row_0_col_12_tcam.ip783tcam128x32s0c1_wrap_tcam_row_0_col_12.tcam_row_0_col_12.ip783tcam128x32s0c1_gen_wrp_inst.ip783tcam128x32s0c1_inst.ip783tcam128x32s0c1_array.array_y[row_idx % 128];
                                    end
                                    13: begin
                                            //READ_data
                                             local_inv_key[13*32 +: 32] = gen_tcam_row_0_col_13_tcam.ip783tcam128x32s0c1_wrap_tcam_row_0_col_13.tcam_row_0_col_13.ip783tcam128x32s0c1_gen_wrp_inst.ip783tcam128x32s0c1_inst.ip783tcam128x32s0c1_array.array_y[row_idx % 128];
                                    end
                                    14: begin
                                            //READ_data
                                             local_inv_key[14*32 +: 32] = gen_tcam_row_0_col_14_tcam.ip783tcam128x32s0c1_wrap_tcam_row_0_col_14.tcam_row_0_col_14.ip783tcam128x32s0c1_gen_wrp_inst.ip783tcam128x32s0c1_inst.ip783tcam128x32s0c1_array.array_y[row_idx % 128];
                                    end
                                    15: begin
                                            //READ_data
                                             local_inv_key[15*32 +: 32] = gen_tcam_row_0_col_15_tcam.ip783tcam128x32s0c1_wrap_tcam_row_0_col_15.tcam_row_0_col_15.ip783tcam128x32s0c1_gen_wrp_inst.ip783tcam128x32s0c1_inst.ip783tcam128x32s0c1_array.array_y[row_idx % 128];
                                    end
                                    default : begin
                                       $error("SOMTING IS wrong with parameters given for col number %d ",j);
                                     end
              endcase
                      
        end // 0 
                 endcase //(row_idx/128)
                 inv_key = TCAM_18A ? ~local_inv_key : ~local_inv_key; 
             `endif
       endtask // END read_tcam_raw_inv_key
       
       task automatic read_tcam_raw_line (output logic[512-1:0] key, output logic [512-1:0] inv_key, input int row_idx);
          read_tcam_raw_key(key, row_idx);
          read_tcam_raw_inv_key(inv_key, row_idx);
       endtask // END write_tcam_raw_line
       
       `endif //FEV_APPROVE_SIM_ONLY
    `endif  //INTEL_SIMONLY
    

endmodule