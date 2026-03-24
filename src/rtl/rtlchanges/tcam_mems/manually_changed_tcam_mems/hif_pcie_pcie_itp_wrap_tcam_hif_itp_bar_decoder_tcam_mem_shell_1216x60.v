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
//      Created by npgadmin with create_memories script version 25.01.005 on NA
//                                      & 
// Physical file /nfs/site/disks/nhdk.zsc7.mmg800.ipr.207/hif/hif_r16_post_dft-mmg800-a0-25ww28b-drop.0/flows/mgm/hif/hif_physical_params.csv
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
`include        "hif_pcie_pcie_itp_mem.def"
module  hif_pcie_pcie_itp_wrap_tcam_hif_itp_bar_decoder_tcam_mem_shell_1216x60 #(
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
        `ifdef HIF_PCIE_FPGA_TCAM_MEMS 
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
        parameter       TCAM_ANALOG_TUNE_CONFG_WIDTH            = `HIF_PCIE_TCAM_ANALOG_TUNE_CONFG_WIDTH             , //
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
        `ifdef HIF_PCIE_FPGA_TCAM_MEMS
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
);

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

localparam PHYSICAL_ROW_WIDTH = TCAM_WIDTH + BCAM_N7*(2*32 - TCAM_WIDTH);
// Disassembling the to_tcam bus
 `ifndef HIF_PCIE_FPGA_TCAM_MEMS
        wire     fpga_fast_clk ; 
        assign   fpga_fast_clk   = clk; // Dummy assignment for 
 `endif

`ifdef HIF_PCIE_FPGA_TCAM_MEMS
        `define HIF_PCIE_TCAM_FPGA_MEMS
`else
        `define HIF_PCIE_TCAM_BEHAVE_FPGA_MEMS
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
          




 hif_pcie_mgm_1rw_behave #(
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

hif_pcie_mgm_tcam_col_sweeper #(
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

hif_pcie_mgm_bcam_row_sweeper #(
        .BCAM_RD_DELAY                  (TCAM_RD_DELAY)                                       ,
        .BCAM_RULES_NUM                 (TCAM_RULES_NUM)                                      ,
        .BCAM_WIDTH                     (PHYSICAL_ROW_WIDTH)                                  ,
        .BCAM_SLICE_EN_WIDTH            (TCAM_SLICE_EN_WIDTH)                                 ,
        .BCAM_PROT_WIDTH                (2*2)                                                 ,
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
`ifndef HIF_PCIE_PCIE_ITP_TCAM_BEHAVE_MEMS
    `define HIF_PCIE_PCIE_ITP_ASIC_MEMS
`endif

`ifdef  HIF_PCIE_PCIE_ITP_ASIC_MEMS

////////////////////////////////////////////////////////////////////////
//
//                              ASIC MEMORIES                                                                                                                   
//
////////////////////////////////////////////////////////////////////////

localparam TCAM_SLICE_EN_FACT = 64/64;
localparam TCAM_SLICE_EN_MIN = ((TCAM_SLICE_EN_FACT < TCAM_SLICE_EN_WIDTH ) ? TCAM_SLICE_EN_FACT : TCAM_SLICE_EN_WIDTH);



    // TCAM Row Select

    wire    [19-1:0]                tcam_row_sel;
    assign                    tcam_row_sel[0]        = ((adr>=12'd0) && (adr<12'd128));
    assign                    tcam_row_sel[1]        = ((adr>=12'd128) && (adr<12'd256));
    assign                    tcam_row_sel[2]        = ((adr>=12'd256) && (adr<12'd384));
    assign                    tcam_row_sel[3]        = ((adr>=12'd384) && (adr<12'd512));
    assign                    tcam_row_sel[4]        = ((adr>=12'd512) && (adr<12'd640));
    assign                    tcam_row_sel[5]        = ((adr>=12'd640) && (adr<12'd768));
    assign                    tcam_row_sel[6]        = ((adr>=12'd768) && (adr<12'd896));
    assign                    tcam_row_sel[7]        = ((adr>=12'd896) && (adr<12'd1024));
    assign                    tcam_row_sel[8]        = ((adr>=12'd1024) && (adr<12'd1152));
    assign                    tcam_row_sel[9]        = ((adr>=12'd1152) && (adr<12'd1280));
    assign                    tcam_row_sel[10]        = ((adr>=12'd1280) && (adr<12'd1408));
    assign                    tcam_row_sel[11]        = ((adr>=12'd1408) && (adr<12'd1536));
    assign                    tcam_row_sel[12]        = ((adr>=12'd1536) && (adr<12'd1664));
    assign                    tcam_row_sel[13]        = ((adr>=12'd1664) && (adr<12'd1792));
    assign                    tcam_row_sel[14]        = ((adr>=12'd1792) && (adr<12'd1920));
    assign                    tcam_row_sel[15]        = ((adr>=12'd1920) && (adr<12'd2048));
    assign                    tcam_row_sel[16]        = ((adr>=12'd2048) && (adr<12'd2176));
    assign                    tcam_row_sel[17]        = ((adr>=12'd2176) && (adr<12'd2304));
    assign                    tcam_row_sel[18]        = (adr>=12'd2304);


    // TCAM Address Decoder

    wire    [7-1:0]        tcam_row_adr[19-1:0];
    assign                    tcam_row_adr[0][7-1:0]    =  tcam_row_sel[0] ? adr - 7'd0 : 7'd0;
    assign                    tcam_row_adr[1][7-1:0]    =  tcam_row_sel[1] ? adr - 7'd128 : 7'd0;
    assign                    tcam_row_adr[2][7-1:0]    =  tcam_row_sel[2] ? adr - 7'd256 : 7'd0;
    assign                    tcam_row_adr[3][7-1:0]    =  tcam_row_sel[3] ? adr - 7'd384 : 7'd0;
    assign                    tcam_row_adr[4][7-1:0]    =  tcam_row_sel[4] ? adr - 7'd512 : 7'd0;
    assign                    tcam_row_adr[5][7-1:0]    =  tcam_row_sel[5] ? adr - 7'd640 : 7'd0;
    assign                    tcam_row_adr[6][7-1:0]    =  tcam_row_sel[6] ? adr - 7'd768 : 7'd0;
    assign                    tcam_row_adr[7][7-1:0]    =  tcam_row_sel[7] ? adr - 7'd896 : 7'd0;
    assign                    tcam_row_adr[8][7-1:0]    =  tcam_row_sel[8] ? adr - 7'd1024 : 7'd0;
    assign                    tcam_row_adr[9][7-1:0]    =  tcam_row_sel[9] ? adr - 7'd1152 : 7'd0;
    assign                    tcam_row_adr[10][7-1:0]    =  tcam_row_sel[10] ? adr - 7'd1280 : 7'd0;
    assign                    tcam_row_adr[11][7-1:0]    =  tcam_row_sel[11] ? adr - 7'd1408 : 7'd0;
    assign                    tcam_row_adr[12][7-1:0]    =  tcam_row_sel[12] ? adr - 7'd1536 : 7'd0;
    assign                    tcam_row_adr[13][7-1:0]    =  tcam_row_sel[13] ? adr - 7'd1664 : 7'd0;
    assign                    tcam_row_adr[14][7-1:0]    =  tcam_row_sel[14] ? adr - 7'd1792 : 7'd0;
    assign                    tcam_row_adr[15][7-1:0]    =  tcam_row_sel[15] ? adr - 7'd1920 : 7'd0;
    assign                    tcam_row_adr[16][7-1:0]    =  tcam_row_sel[16] ? adr - 7'd2048 : 7'd0;
    assign                    tcam_row_adr[17][7-1:0]    =  tcam_row_sel[17] ? adr - 7'd2176 : 7'd0;
    assign                    tcam_row_adr[18][7-1:0]    =  tcam_row_sel[18] ? adr - 7'd2304 : 7'd0;


    // TCAM Read Enable Decoder

    wire    [19-1:0]        tcam_row_rd_en;
    assign            tcam_row_rd_en[0]        = tcam_row_sel[0] ? rd_en : 1'b0;
    assign            tcam_row_rd_en[1]        = tcam_row_sel[1] ? rd_en : 1'b0;
    assign            tcam_row_rd_en[2]        = tcam_row_sel[2] ? rd_en : 1'b0;
    assign            tcam_row_rd_en[3]        = tcam_row_sel[3] ? rd_en : 1'b0;
    assign            tcam_row_rd_en[4]        = tcam_row_sel[4] ? rd_en : 1'b0;
    assign            tcam_row_rd_en[5]        = tcam_row_sel[5] ? rd_en : 1'b0;
    assign            tcam_row_rd_en[6]        = tcam_row_sel[6] ? rd_en : 1'b0;
    assign            tcam_row_rd_en[7]        = tcam_row_sel[7] ? rd_en : 1'b0;
    assign            tcam_row_rd_en[8]        = tcam_row_sel[8] ? rd_en : 1'b0;
    assign            tcam_row_rd_en[9]        = tcam_row_sel[9] ? rd_en : 1'b0;
    assign            tcam_row_rd_en[10]        = tcam_row_sel[10] ? rd_en : 1'b0;
    assign            tcam_row_rd_en[11]        = tcam_row_sel[11] ? rd_en : 1'b0;
    assign            tcam_row_rd_en[12]        = tcam_row_sel[12] ? rd_en : 1'b0;
    assign            tcam_row_rd_en[13]        = tcam_row_sel[13] ? rd_en : 1'b0;
    assign            tcam_row_rd_en[14]        = tcam_row_sel[14] ? rd_en : 1'b0;
    assign            tcam_row_rd_en[15]        = tcam_row_sel[15] ? rd_en : 1'b0;
    assign            tcam_row_rd_en[16]        = tcam_row_sel[16] ? rd_en : 1'b0;
    assign            tcam_row_rd_en[17]        = tcam_row_sel[17] ? rd_en : 1'b0;
    assign            tcam_row_rd_en[18]        = tcam_row_sel[18] ? rd_en : 1'b0;


    // TCAM Write Enable Decoder

    wire    [19-1:0]        tcam_row_wr_en;
    assign            tcam_row_wr_en[0]        = tcam_row_sel[0] ? wr_en : 1'b0;
    assign            tcam_row_wr_en[1]        = tcam_row_sel[1] ? wr_en : 1'b0;
    assign            tcam_row_wr_en[2]        = tcam_row_sel[2] ? wr_en : 1'b0;
    assign            tcam_row_wr_en[3]        = tcam_row_sel[3] ? wr_en : 1'b0;
    assign            tcam_row_wr_en[4]        = tcam_row_sel[4] ? wr_en : 1'b0;
    assign            tcam_row_wr_en[5]        = tcam_row_sel[5] ? wr_en : 1'b0;
    assign            tcam_row_wr_en[6]        = tcam_row_sel[6] ? wr_en : 1'b0;
    assign            tcam_row_wr_en[7]        = tcam_row_sel[7] ? wr_en : 1'b0;
    assign            tcam_row_wr_en[8]        = tcam_row_sel[8] ? wr_en : 1'b0;
    assign            tcam_row_wr_en[9]        = tcam_row_sel[9] ? wr_en : 1'b0;
    assign            tcam_row_wr_en[10]        = tcam_row_sel[10] ? wr_en : 1'b0;
    assign            tcam_row_wr_en[11]        = tcam_row_sel[11] ? wr_en : 1'b0;
    assign            tcam_row_wr_en[12]        = tcam_row_sel[12] ? wr_en : 1'b0;
    assign            tcam_row_wr_en[13]        = tcam_row_sel[13] ? wr_en : 1'b0;
    assign            tcam_row_wr_en[14]        = tcam_row_sel[14] ? wr_en : 1'b0;
    assign            tcam_row_wr_en[15]        = tcam_row_sel[15] ? wr_en : 1'b0;
    assign            tcam_row_wr_en[16]        = tcam_row_sel[16] ? wr_en : 1'b0;
    assign            tcam_row_wr_en[17]        = tcam_row_sel[17] ? wr_en : 1'b0;
    assign            tcam_row_wr_en[18]        = tcam_row_sel[18] ? wr_en : 1'b0;


    // Read Delay

    reg            rd_en_nope_done;
    reg    [19-1:0]    rd_en_delay_inst[TCAM_RD_DELAY:0];
    logic   [TCAM_RD_DELAY:0]               rd_en_delay;
    always_comb
         begin
        rd_en_delay_inst[0][19-1:0]        = tcam_row_rd_en[19-1:0];
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
    reg    [19-1:0]    wr_en_delay_inst[TCAM_WR_DELAY:0];
    logic    [TCAM_WR_DELAY:0]               wr_en_delay;
    always_comb
         begin
        wr_en_delay_inst[0][19-1:0]        = tcam_row_wr_en[19-1:0];
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

    logic    [5-1:0]        tcam_row_num_rd_en_delay;
    always_ff @(posedge clk) begin
        if (|rd_en_delay_inst[TCAM_RD_DELAY-1]) begin
            for (int i = 0; i < 19; i = i + 1) begin
                if (rd_en_delay_inst[TCAM_RD_DELAY-1][i]) begin
                    tcam_row_num_rd_en_delay[5-1:0]    <= i;
                end
            end
        end
    end


    // Write Data

    logic    [64-1:0]    tcam_row_wr_data;
    always_comb begin
            tcam_row_wr_data = '1;
            tcam_row_wr_data[0+:PHYSICAL_ROW_WIDTH]    = wr_data;
    end
    logic    [32-1:0]    tcam_wr_data_col[2-1:0];
    always_comb begin
        for (int i = 0; i < 2; i = i + 1) begin
            tcam_wr_data_col[i][32-1:0]        = tcam_row_wr_data[i*32+:32];
        end
    end


    // Check Key

    logic    [64-1:0]    tcam_chk_key;
    always_comb begin
            tcam_chk_key = '1;
            tcam_chk_key[0+:PHYSICAL_ROW_WIDTH]    = chk_key;
    end
    logic    [32-1:0]    tcam_chk_key_col[2-1:0];
    always_comb begin
        for (int i = 0; i < 2; i = i + 1) begin
            tcam_chk_key_col[i][32-1:0]        = tcam_chk_key[i*32+:32];
        end
    end


    // Check Mask

    logic    [64-1:0]    tcam_chk_mask;
    always_comb begin
            tcam_chk_mask        = '0;
            tcam_chk_mask        = wr_en ? '1 : chk_mask_int;
    end
    logic    [32-1:0]    tcam_chk_mask_col[2-1:0];
    always_comb begin
        for (int i = 0; i < 2; i = i + 1) begin
            tcam_chk_mask_col[i][32-1:0]        = tcam_chk_mask[i*32+:32];
        end
    end


    // Hit In

    logic    [1216-1:0]    tcam_hit_in;
    always_comb begin
        tcam_hit_in                = {1216{1'b1}};
        tcam_hit_in[TCAM_RULES_NUM-1:0]    = raw_hit_in[TCAM_RULES_NUM-1:0];
    end
    logic    [64-1:0]    tcam_raw_hit_in[19-1:0];
    always_comb begin
        for (int i = 0; i < 19; i = i + 1) begin
            tcam_raw_hit_in[i][64-1:0]        = tcam_hit_in[i*64+:64];
        end
    end


    // Read Data

    logic    [32-1:0]    tcam_rd_data_col[19-1:0][2-1:0];
    logic    [64-1:0]    tcam_rd_data_row;
    always_comb begin
        for (int i = 0; i < 2; i = i + 1) begin
            tcam_rd_data_row[i*(32)+:32]        = tcam_rd_data_col[tcam_row_num_rd_en_delay[5-1:0]][i][32-1:0];
        end
    end
    logic    [PHYSICAL_ROW_WIDTH-1:0]    tcam_rd_data;
    always_comb begin
        tcam_rd_data    = tcam_rd_data_row[0+:PHYSICAL_ROW_WIDTH];
    end
    assign    rd_data    = tcam_rd_data;


    // Hit Array

    logic    [64-1:0]    tcam_col_hit_out[19-1:0][2-1:0];
    logic    [1216-1:0]    tcam_hit_out;
    always_comb begin
        for (int i = 0; i < 19; i = i + 1) begin
                tcam_hit_out[i*64+:64]    =  tcam_col_hit_out[i][0]   & tcam_col_hit_out[i][1];
        end
    end
    assign    raw_hit_out = tcam_hit_out[TCAM_RULES_NUM-1:0];
// Match In Array 

        logic    [64-1:0]      tcam_row_match_in[19-1:0];
        always_comb begin 
                for (int i = 0; i < 19; i = i + 1) begin
                    tcam_row_match_in[i] = tcam_match_in[i*64+:64]; 
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
        wire    [7-1:0]                       tcam_row_0_col_0_adr  = tcam_row_adr[0][7-1:0];
        wire    [32-1:0]                      tcam_row_0_col_0_data_in = tcam_row_wr_en[0] ? tcam_wr_data_col[0][32-1:0] : tcam_chk_key_col[0][32-1:0];
        wire    [32-1:0]                      tcam_row_0_col_0_data_in_pre = tcam_wr_data_col[0][32-1:0] ;
        wire    [32-1:0]                      tcam_row_0_col_0_key_in =  tcam_chk_key_col[0][32-1:0];
        wire    [32-1:0]                      tcam_row_0_col_0_mask_in = tcam_chk_mask_col[0][32-1:0];
        wire    [64-1:0]                       tcam_row_0_col_0_hit_in = tcam_raw_hit_in[0];
        wire    [64-1:0]                       tcam_row_0_col_0_tcam_match_in = tcam_row_match_in[0];
        wire    [32-1:0]                      tcam_row_0_col_0_data_out_inv;
        logic   [64-1:0]                     tcam_row_0_col_0_hit_out_int;
        logic   [64-1:0]                     tcam_row_0_col_0_hit_out_latch;
        logic   [64-1:0]                     tcam_row_0_col_0_hit_out;
        
        `ifdef HIF_PCIE_DFX_DISABLE
        wire                          tcam_row_0_col_0_biste = 'b0; 
        wire     [5-1:0]                  tcam_row_0_col_0_fca = 'b0;
        wire                            tcam_row_0_col_0_cre = 'b0;
        wire                            tcam_row_0_col_0_dftshiften = 'b0;
        wire                            tcam_row_0_col_0_dftmask = 'b0;
        wire                            tcam_row_0_col_0_dft_array_freeze = 'b0;
        wire                            tcam_row_0_col_0_dft_afd_reset_b = 'b0;
        wire      [32-1:0]    tcam_row_0_col_0_tdin = 'b0;
        wire      [7-1:0]     tcam_row_0_col_0_tadr = 'b0;
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
        wire      [7-1:0]     tcam_row_0_col_0_tadr = 'b0;
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
                         pcie_itp_ip783tcam64x32s0c1_0_0_wrap #(        
                                 )               
        
                                 ip783tcam64x32s0c1_wrap_tcam_row_0_col_0 (
                   //-------------------------------------------------------------
                   // Power Management Interfaces
                   //-------------------------------------------------------------   
                      `ifndef INTEL_NO_PWR_PINS
                      `ifdef INTC_ADD_VSS
                        .vss              (1'b0),
                      `endif
                        .vddp             (1'b1),
                      `endif
                         .ADR               (tcam_row_0_col_0_adr[7-1:1]), //Input adr_intess
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
                         .MDST_tcam (fuse_tcam)
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
        wire    [7-1:0]                       tcam_row_0_col_1_adr  = tcam_row_adr[0][7-1:0];
        wire    [32-1:0]                      tcam_row_0_col_1_data_in = tcam_row_wr_en[0] ? tcam_wr_data_col[1][32-1:0] : tcam_chk_key_col[1][32-1:0];
        wire    [32-1:0]                      tcam_row_0_col_1_data_in_pre = tcam_wr_data_col[1][32-1:0] ;
        wire    [32-1:0]                      tcam_row_0_col_1_key_in =  tcam_chk_key_col[1][32-1:0];
        wire    [32-1:0]                      tcam_row_0_col_1_mask_in = tcam_chk_mask_col[1][32-1:0];
        wire    [64-1:0]                       tcam_row_0_col_1_hit_in = tcam_raw_hit_in[0];
        wire    [64-1:0]                       tcam_row_0_col_1_tcam_match_in = tcam_row_match_in[0];
        wire    [32-1:0]                      tcam_row_0_col_1_data_out_inv;
        logic   [64-1:0]                     tcam_row_0_col_1_hit_out_int;
        logic   [64-1:0]                     tcam_row_0_col_1_hit_out_latch;
        logic   [64-1:0]                     tcam_row_0_col_1_hit_out;
        
        `ifdef HIF_PCIE_DFX_DISABLE
        wire                          tcam_row_0_col_1_biste = 'b0; 
        wire     [5-1:0]                  tcam_row_0_col_1_fca = 'b0;
        wire                            tcam_row_0_col_1_cre = 'b0;
        wire                            tcam_row_0_col_1_dftshiften = 'b0;
        wire                            tcam_row_0_col_1_dftmask = 'b0;
        wire                            tcam_row_0_col_1_dft_array_freeze = 'b0;
        wire                            tcam_row_0_col_1_dft_afd_reset_b = 'b0;
        wire      [32-1:0]    tcam_row_0_col_1_tdin = 'b0;
        wire      [7-1:0]     tcam_row_0_col_1_tadr = 'b0;
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
        wire      [7-1:0]     tcam_row_0_col_1_tadr = 'b0;
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
                         pcie_itp_ip783tcam64x32s0c1_0_1_wrap #(        
                                 )               
        
                                 ip783tcam64x32s0c1_wrap_tcam_row_0_col_1 (
                   //-------------------------------------------------------------
                   // Power Management Interfaces
                   //-------------------------------------------------------------   
                      `ifndef INTEL_NO_PWR_PINS
                      `ifdef INTC_ADD_VSS
                        .vss              (1'b0),
                      `endif
                        .vddp             (1'b1),
                      `endif
                         .ADR               (tcam_row_0_col_1_adr[7-1:1]), //Input adr_intess
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
                         .MDST_tcam (fuse_tcam)
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
        
        wire                                            tcam_row_1_col_0_clk         = clk;
        
        wire    [TCAM_SLICE_EN_FACT-1:0]                tcam_row_1_col_0_slice_en = TCAM_SLICE_EN_FACT'(slice_en[(1 * TCAM_SLICE_EN_FACT)+:TCAM_SLICE_EN_MIN]);
        
        wire                                            tcam_row_1_col_0_rd_en       = tcam_row_rd_en[1];
        wire                                            tcam_row_1_col_0_wr_en       = tcam_row_wr_en[1];
        wire                                            tcam_row_1_col_0_chk_en      = chk_en;
        wire                                            tcam_row_1_col_0_reset_n = reset_n;
        wire    [7-1:0]                       tcam_row_1_col_0_adr  = tcam_row_adr[1][7-1:0];
        wire    [32-1:0]                      tcam_row_1_col_0_data_in = tcam_row_wr_en[1] ? tcam_wr_data_col[0][32-1:0] : tcam_chk_key_col[0][32-1:0];
        wire    [32-1:0]                      tcam_row_1_col_0_data_in_pre = tcam_wr_data_col[0][32-1:0] ;
        wire    [32-1:0]                      tcam_row_1_col_0_key_in =  tcam_chk_key_col[0][32-1:0];
        wire    [32-1:0]                      tcam_row_1_col_0_mask_in = tcam_chk_mask_col[0][32-1:0];
        wire    [64-1:0]                       tcam_row_1_col_0_hit_in = tcam_raw_hit_in[1];
        wire    [64-1:0]                       tcam_row_1_col_0_tcam_match_in = tcam_row_match_in[1];
        wire    [32-1:0]                      tcam_row_1_col_0_data_out_inv;
        logic   [64-1:0]                     tcam_row_1_col_0_hit_out_int;
        logic   [64-1:0]                     tcam_row_1_col_0_hit_out_latch;
        logic   [64-1:0]                     tcam_row_1_col_0_hit_out;
        
        `ifdef HIF_PCIE_DFX_DISABLE
        wire                          tcam_row_1_col_0_biste = 'b0; 
        wire     [5-1:0]                  tcam_row_1_col_0_fca = 'b0;
        wire                            tcam_row_1_col_0_cre = 'b0;
        wire                            tcam_row_1_col_0_dftshiften = 'b0;
        wire                            tcam_row_1_col_0_dftmask = 'b0;
        wire                            tcam_row_1_col_0_dft_array_freeze = 'b0;
        wire                            tcam_row_1_col_0_dft_afd_reset_b = 'b0;
        wire      [32-1:0]    tcam_row_1_col_0_tdin = 'b0;
        wire      [7-1:0]     tcam_row_1_col_0_tadr = 'b0;
        wire                            tcam_row_1_col_0_tvbe = 'b0;
        wire                            tcam_row_1_col_0_tvbi = 'b0;
        wire      [32-1:0]    tcam_row_1_col_0_tmask = 'b0;
        wire                            tcam_row_1_col_0_twe = 'b0;
        wire                            tcam_row_1_col_0_tre = 'b0;
        wire                            tcam_row_1_col_0_tme = 'b0;
        wire                            tcam_row_1_col_0_bist_rotate_sr = 'b0;
        wire                            tcam_row_1_col_0_bist_en_sr_mask_b = 'b0;
        wire                            tcam_row_1_col_0_bist_all_mask = 'b0;
        wire                            tcam_row_1_col_0_bist_en_sr_data_b = 'b0;
        wire                            tcam_row_1_col_0_bist_cm_mode = 'b0;
        wire                            tcam_row_1_col_0_bist_cm_en_in = 'b0;
        wire                            tcam_row_1_col_0_bist_cm_match_sel0 = 'b0;
        wire                            tcam_row_1_col_0_bist_cm_match_sel1 = 'b0;
        wire                            tcam_row_1_col_0_bist_matchin_in = 'b0;
        wire                            tcam_row_1_col_0_bist_fls = 'b0;
        
        `else
        wire                            tcam_row_1_col_0_biste = 'b0;
        wire     [5-1:0]                  tcam_row_1_col_0_fca = 'b0;
        wire                            tcam_row_1_col_0_cre = 'b0;
        wire                            tcam_row_1_col_0_dftshiften = dftshiften;
        wire                            tcam_row_1_col_0_dftmask = dftmask;
        wire                            tcam_row_1_col_0_dft_array_freeze = dft_array_freeze;
        wire                            tcam_row_1_col_0_dft_afd_reset_b = dft_afd_reset_b;
        wire      [32-1:0]    tcam_row_1_col_0_tdin = 'b0;
        wire      [7-1:0]     tcam_row_1_col_0_tadr = 'b0;
        wire                            tcam_row_1_col_0_tvbe = 'b0;
        wire                            tcam_row_1_col_0_tvbi = 'b0;
        wire      [32-1:0]    tcam_row_1_col_0_tmask = 'b0;
        wire                            tcam_row_1_col_0_twe = 'b0;
        wire                            tcam_row_1_col_0_tre = 'b0;
        wire                            tcam_row_1_col_0_tme = 'b0;
        wire                            tcam_row_1_col_0_bist_rotate_sr = 'b0;
        wire                            tcam_row_1_col_0_bist_en_sr_mask_b = 'b0;
        wire                            tcam_row_1_col_0_bist_all_mask = 'b0;
        wire                            tcam_row_1_col_0_bist_en_sr_data_b = 'b0;
        wire                            tcam_row_1_col_0_bist_cm_mode = 'b0;
        wire                            tcam_row_1_col_0_bist_cm_en_in = 'b0;
        wire                            tcam_row_1_col_0_bist_cm_match_sel0 = 'b0;
        wire                            tcam_row_1_col_0_bist_cm_match_sel1 = 'b0;
        wire                            tcam_row_1_col_0_bist_matchin_in = 'b0;
        wire                            tcam_row_1_col_0_bist_fls = 'b0;
        `endif
        
        // Outputs
        logic                           tcam_row_1_col_0_wr_bira_fail;
        logic                           tcam_row_1_col_0_wr_so;
        logic                           tcam_row_1_col_0_curerrout;
        logic                           tcam_row_1_col_0_rscout;
        
        
        
        logic   [TCAM_SLICE_EN_FACT-1:0]                  tcam_row_1_col_0_slice_en_s0; 
        logic   [TCAM_SLICE_EN_FACT-1:0]                  tcam_row_1_col_0_slice_en_s1; 
        
        
        
             wire    [32-1:0]                     tcam_row_1_col_0_data_out ;
        
        
        
         generate
            if (BCAM_N7 == 0) 
              begin : gen_tcam_row_1_col_0_tcam
        
        
        // slice_en kept for TCAM only for backward compatability with Intel process
                always_comb 
                begin
                  for (int i = 0; i < TCAM_SLICE_EN_FACT; i++)
                      if (tcam_row_1_col_0_slice_en_s1[i])
                           tcam_row_1_col_0_hit_out[ i*64 +: 64]  = tcam_row_1_col_0_hit_out_int  [ i*64 +: 64]; 
                      else
                           tcam_row_1_col_0_hit_out[ i*64 +: 64]  = tcam_row_1_col_0_hit_out_latch[ i*64 +: 64]; 
                end
        
        
        
                always_ff  @(posedge tcam_row_1_col_0_clk)
                begin
                  tcam_row_1_col_0_slice_en_s0 <= tcam_row_1_col_0_slice_en; 
                  tcam_row_1_col_0_slice_en_s1 <= tcam_row_1_col_0_slice_en_s0; 
        
                  for (int i = 0; i < TCAM_SLICE_EN_FACT; i++)
                    begin
                      if (tcam_row_1_col_0_slice_en_s1[i])
                         tcam_row_1_col_0_hit_out_latch[ i*64 +: 64] <=  tcam_row_1_col_0_hit_out_int[ i*64 +: 64];
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
        
                     
                         assign tcam_row_1_col_0_data_out  = ~tcam_row_1_col_0_data_out_inv;
                         pcie_itp_ip783tcam64x32s0c1_1_0_wrap #(        
                                 )               
        
                                 ip783tcam64x32s0c1_wrap_tcam_row_1_col_0 (
                   //-------------------------------------------------------------
                   // Power Management Interfaces
                   //-------------------------------------------------------------   
                      `ifndef INTEL_NO_PWR_PINS
                      `ifdef INTC_ADD_VSS
                        .vss              (1'b0),
                      `endif
                        .vddp             (1'b1),
                      `endif
                         .ADR               (tcam_row_1_col_0_adr[7-1:1]), //Input adr_intess
                         .ME                (ce),  
        
                         .CLK               (tcam_row_1_col_0_clk), //Clock
                         .CMP               (tcam_row_1_col_0_chk_en), //Control Enable
                         .DIN               (~tcam_row_1_col_0_data_in), 
                         .DSEL              (~tcam_row_1_col_0_adr[0]), //dncen enables access of the TCAM Arrays adr_intessed
                         .FLS               (flush), //flush initiates a Flush operation that resets all Valid
                         .RVLD              (tcam_row_1_col_0_hit_in ), //Row validation bus. Each match_in input controls 1
                         .MASK              (tcam_row_1_col_0_mask_in), //Input msk
                         .QOUT              (tcam_row_1_col_0_data_out_inv), //Output vben
                         .QHR               (tcam_row_1_col_0_hit_out_int),
                         .QVLD              (), 
                         .RE                (tcam_row_1_col_0_rd_en), //Read Enable
                         .RST               (tcam_row_1_col_0_reset_n), //Asynchronous Active-High Reset
                         .VBE               (1'b1), //vben enables the Valid Bit addressed by adr[a-1:0] to
                         .VBI               (1'b0),//  Valid Bit Input
                         .WE                (tcam_row_1_col_0_wr_en), //Write Enable
                         .FAF               (tcam_row_1_col_0_fca),
                         .FAF_EN            (tcam_row_1_col_0_cre),
                         .DFTSHIFTEN        (tcam_row_1_col_0_dftshiften),
                         .DFTMASK           (tcam_row_1_col_0_dftmask),
                         .DFT_ARRAY_FREEZE  (tcam_row_1_col_0_dft_array_freeze),
                         .DFT_AFD_RESET_B   (tcam_row_1_col_0_dft_afd_reset_b),
                         .BISTE           (tcam_row_1_col_0_biste),
                         .TDIN (tcam_row_1_col_0_tdin),
                         .TADR (tcam_row_1_col_0_tadr),
                         .TVBE (tcam_row_1_col_0_tvbe),
                         .TVBI (tcam_row_1_col_0_tvbi),
                         .TMASK (tcam_row_1_col_0_tmask),
                         .TWE (tcam_row_1_col_0_twe),
                         .TRE (tcam_row_1_col_0_tre),
                         .TME (tcam_row_1_col_0_tme),
                         .BIST_ROTATE_SR (tcam_row_1_col_0_bist_rotate_sr),
                         .BIST_EN_SR_MASK_B (tcam_row_1_col_0_bist_en_sr_mask_b),
                         .BIST_ALL_MASK (tcam_row_1_col_0_bist_all_mask),
                         .BIST_EN_SR_DATA_B (tcam_row_1_col_0_bist_en_sr_data_b),
                         .BIST_CM_MODE (tcam_row_1_col_0_bist_cm_mode),
                         .BIST_CM_EN_IN (tcam_row_1_col_0_bist_cm_en_in),
                         .BIST_CM_MATCH_SEL0 (tcam_row_1_col_0_bist_cm_match_sel0),
                         .BIST_CM_MATCH_SEL1 (tcam_row_1_col_0_bist_cm_match_sel1),
                         .BIST_MATCHIN_IN (tcam_row_1_col_0_bist_matchin_in),
                         .BIST_FLS (tcam_row_1_col_0_bist_fls),
                         .MDST_tcam (fuse_tcam)
                     );
        
              end
              
            else
              begin : gen_tcam_row_1_col_0_bcam
              end
              
        
        
        endgenerate
        
        always_ff @(posedge clk) begin
                   tcam_rd_data_col[1][0]      <= tcam_row_1_col_0_data_out;
                   tcam_col_hit_out[1][0]       <= tcam_row_1_col_0_hit_out;
        end
        

        // this is new template - tcam_asic_template
        
        wire                                            tcam_row_1_col_1_clk         = clk;
        
        wire    [TCAM_SLICE_EN_FACT-1:0]                tcam_row_1_col_1_slice_en = TCAM_SLICE_EN_FACT'(slice_en[(1 * TCAM_SLICE_EN_FACT)+:TCAM_SLICE_EN_MIN]);
        
        wire                                            tcam_row_1_col_1_rd_en       = tcam_row_rd_en[1];
        wire                                            tcam_row_1_col_1_wr_en       = tcam_row_wr_en[1];
        wire                                            tcam_row_1_col_1_chk_en      = chk_en;
        wire                                            tcam_row_1_col_1_reset_n = reset_n;
        wire    [7-1:0]                       tcam_row_1_col_1_adr  = tcam_row_adr[1][7-1:0];
        wire    [32-1:0]                      tcam_row_1_col_1_data_in = tcam_row_wr_en[1] ? tcam_wr_data_col[1][32-1:0] : tcam_chk_key_col[1][32-1:0];
        wire    [32-1:0]                      tcam_row_1_col_1_data_in_pre = tcam_wr_data_col[1][32-1:0] ;
        wire    [32-1:0]                      tcam_row_1_col_1_key_in =  tcam_chk_key_col[1][32-1:0];
        wire    [32-1:0]                      tcam_row_1_col_1_mask_in = tcam_chk_mask_col[1][32-1:0];
        wire    [64-1:0]                       tcam_row_1_col_1_hit_in = tcam_raw_hit_in[1];
        wire    [64-1:0]                       tcam_row_1_col_1_tcam_match_in = tcam_row_match_in[1];
        wire    [32-1:0]                      tcam_row_1_col_1_data_out_inv;
        logic   [64-1:0]                     tcam_row_1_col_1_hit_out_int;
        logic   [64-1:0]                     tcam_row_1_col_1_hit_out_latch;
        logic   [64-1:0]                     tcam_row_1_col_1_hit_out;
        
        `ifdef HIF_PCIE_DFX_DISABLE
        wire                          tcam_row_1_col_1_biste = 'b0; 
        wire     [5-1:0]                  tcam_row_1_col_1_fca = 'b0;
        wire                            tcam_row_1_col_1_cre = 'b0;
        wire                            tcam_row_1_col_1_dftshiften = 'b0;
        wire                            tcam_row_1_col_1_dftmask = 'b0;
        wire                            tcam_row_1_col_1_dft_array_freeze = 'b0;
        wire                            tcam_row_1_col_1_dft_afd_reset_b = 'b0;
        wire      [32-1:0]    tcam_row_1_col_1_tdin = 'b0;
        wire      [7-1:0]     tcam_row_1_col_1_tadr = 'b0;
        wire                            tcam_row_1_col_1_tvbe = 'b0;
        wire                            tcam_row_1_col_1_tvbi = 'b0;
        wire      [32-1:0]    tcam_row_1_col_1_tmask = 'b0;
        wire                            tcam_row_1_col_1_twe = 'b0;
        wire                            tcam_row_1_col_1_tre = 'b0;
        wire                            tcam_row_1_col_1_tme = 'b0;
        wire                            tcam_row_1_col_1_bist_rotate_sr = 'b0;
        wire                            tcam_row_1_col_1_bist_en_sr_mask_b = 'b0;
        wire                            tcam_row_1_col_1_bist_all_mask = 'b0;
        wire                            tcam_row_1_col_1_bist_en_sr_data_b = 'b0;
        wire                            tcam_row_1_col_1_bist_cm_mode = 'b0;
        wire                            tcam_row_1_col_1_bist_cm_en_in = 'b0;
        wire                            tcam_row_1_col_1_bist_cm_match_sel0 = 'b0;
        wire                            tcam_row_1_col_1_bist_cm_match_sel1 = 'b0;
        wire                            tcam_row_1_col_1_bist_matchin_in = 'b0;
        wire                            tcam_row_1_col_1_bist_fls = 'b0;
        
        `else
        wire                            tcam_row_1_col_1_biste = 'b0;
        wire     [5-1:0]                  tcam_row_1_col_1_fca = 'b0;
        wire                            tcam_row_1_col_1_cre = 'b0;
        wire                            tcam_row_1_col_1_dftshiften = dftshiften;
        wire                            tcam_row_1_col_1_dftmask = dftmask;
        wire                            tcam_row_1_col_1_dft_array_freeze = dft_array_freeze;
        wire                            tcam_row_1_col_1_dft_afd_reset_b = dft_afd_reset_b;
        wire      [32-1:0]    tcam_row_1_col_1_tdin = 'b0;
        wire      [7-1:0]     tcam_row_1_col_1_tadr = 'b0;
        wire                            tcam_row_1_col_1_tvbe = 'b0;
        wire                            tcam_row_1_col_1_tvbi = 'b0;
        wire      [32-1:0]    tcam_row_1_col_1_tmask = 'b0;
        wire                            tcam_row_1_col_1_twe = 'b0;
        wire                            tcam_row_1_col_1_tre = 'b0;
        wire                            tcam_row_1_col_1_tme = 'b0;
        wire                            tcam_row_1_col_1_bist_rotate_sr = 'b0;
        wire                            tcam_row_1_col_1_bist_en_sr_mask_b = 'b0;
        wire                            tcam_row_1_col_1_bist_all_mask = 'b0;
        wire                            tcam_row_1_col_1_bist_en_sr_data_b = 'b0;
        wire                            tcam_row_1_col_1_bist_cm_mode = 'b0;
        wire                            tcam_row_1_col_1_bist_cm_en_in = 'b0;
        wire                            tcam_row_1_col_1_bist_cm_match_sel0 = 'b0;
        wire                            tcam_row_1_col_1_bist_cm_match_sel1 = 'b0;
        wire                            tcam_row_1_col_1_bist_matchin_in = 'b0;
        wire                            tcam_row_1_col_1_bist_fls = 'b0;
        `endif
        
        // Outputs
        logic                           tcam_row_1_col_1_wr_bira_fail;
        logic                           tcam_row_1_col_1_wr_so;
        logic                           tcam_row_1_col_1_curerrout;
        logic                           tcam_row_1_col_1_rscout;
        
        
        
        logic   [TCAM_SLICE_EN_FACT-1:0]                  tcam_row_1_col_1_slice_en_s0; 
        logic   [TCAM_SLICE_EN_FACT-1:0]                  tcam_row_1_col_1_slice_en_s1; 
        
        
        
             wire    [32-1:0]                     tcam_row_1_col_1_data_out ;
        
        
        
         generate
            if (BCAM_N7 == 0) 
              begin : gen_tcam_row_1_col_1_tcam
        
        
        // slice_en kept for TCAM only for backward compatability with Intel process
                always_comb 
                begin
                  for (int i = 0; i < TCAM_SLICE_EN_FACT; i++)
                      if (tcam_row_1_col_1_slice_en_s1[i])
                           tcam_row_1_col_1_hit_out[ i*64 +: 64]  = tcam_row_1_col_1_hit_out_int  [ i*64 +: 64]; 
                      else
                           tcam_row_1_col_1_hit_out[ i*64 +: 64]  = tcam_row_1_col_1_hit_out_latch[ i*64 +: 64]; 
                end
        
        
        
                always_ff  @(posedge tcam_row_1_col_1_clk)
                begin
                  tcam_row_1_col_1_slice_en_s0 <= tcam_row_1_col_1_slice_en; 
                  tcam_row_1_col_1_slice_en_s1 <= tcam_row_1_col_1_slice_en_s0; 
        
                  for (int i = 0; i < TCAM_SLICE_EN_FACT; i++)
                    begin
                      if (tcam_row_1_col_1_slice_en_s1[i])
                         tcam_row_1_col_1_hit_out_latch[ i*64 +: 64] <=  tcam_row_1_col_1_hit_out_int[ i*64 +: 64];
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
        
                     
                         assign tcam_row_1_col_1_data_out  = ~tcam_row_1_col_1_data_out_inv;
                         pcie_itp_ip783tcam64x32s0c1_1_1_wrap #(        
                                 )               
        
                                 ip783tcam64x32s0c1_wrap_tcam_row_1_col_1 (
                   //-------------------------------------------------------------
                   // Power Management Interfaces
                   //-------------------------------------------------------------   
                      `ifndef INTEL_NO_PWR_PINS
                      `ifdef INTC_ADD_VSS
                        .vss              (1'b0),
                      `endif
                        .vddp             (1'b1),
                      `endif
                         .ADR               (tcam_row_1_col_1_adr[7-1:1]), //Input adr_intess
                         .ME                (ce),  
        
                         .CLK               (tcam_row_1_col_1_clk), //Clock
                         .CMP               (tcam_row_1_col_1_chk_en), //Control Enable
                         .DIN               (~tcam_row_1_col_1_data_in), 
                         .DSEL              (~tcam_row_1_col_1_adr[0]), //dncen enables access of the TCAM Arrays adr_intessed
                         .FLS               (flush), //flush initiates a Flush operation that resets all Valid
                         .RVLD              (tcam_row_1_col_1_hit_in ), //Row validation bus. Each match_in input controls 1
                         .MASK              (tcam_row_1_col_1_mask_in), //Input msk
                         .QOUT              (tcam_row_1_col_1_data_out_inv), //Output vben
                         .QHR               (tcam_row_1_col_1_hit_out_int),
                         .QVLD              (), 
                         .RE                (tcam_row_1_col_1_rd_en), //Read Enable
                         .RST               (tcam_row_1_col_1_reset_n), //Asynchronous Active-High Reset
                         .VBE               (1'b1), //vben enables the Valid Bit addressed by adr[a-1:0] to
                         .VBI               (1'b0),//  Valid Bit Input
                         .WE                (tcam_row_1_col_1_wr_en), //Write Enable
                         .FAF               (tcam_row_1_col_1_fca),
                         .FAF_EN            (tcam_row_1_col_1_cre),
                         .DFTSHIFTEN        (tcam_row_1_col_1_dftshiften),
                         .DFTMASK           (tcam_row_1_col_1_dftmask),
                         .DFT_ARRAY_FREEZE  (tcam_row_1_col_1_dft_array_freeze),
                         .DFT_AFD_RESET_B   (tcam_row_1_col_1_dft_afd_reset_b),
                         .BISTE           (tcam_row_1_col_1_biste),
                         .TDIN (tcam_row_1_col_1_tdin),
                         .TADR (tcam_row_1_col_1_tadr),
                         .TVBE (tcam_row_1_col_1_tvbe),
                         .TVBI (tcam_row_1_col_1_tvbi),
                         .TMASK (tcam_row_1_col_1_tmask),
                         .TWE (tcam_row_1_col_1_twe),
                         .TRE (tcam_row_1_col_1_tre),
                         .TME (tcam_row_1_col_1_tme),
                         .BIST_ROTATE_SR (tcam_row_1_col_1_bist_rotate_sr),
                         .BIST_EN_SR_MASK_B (tcam_row_1_col_1_bist_en_sr_mask_b),
                         .BIST_ALL_MASK (tcam_row_1_col_1_bist_all_mask),
                         .BIST_EN_SR_DATA_B (tcam_row_1_col_1_bist_en_sr_data_b),
                         .BIST_CM_MODE (tcam_row_1_col_1_bist_cm_mode),
                         .BIST_CM_EN_IN (tcam_row_1_col_1_bist_cm_en_in),
                         .BIST_CM_MATCH_SEL0 (tcam_row_1_col_1_bist_cm_match_sel0),
                         .BIST_CM_MATCH_SEL1 (tcam_row_1_col_1_bist_cm_match_sel1),
                         .BIST_MATCHIN_IN (tcam_row_1_col_1_bist_matchin_in),
                         .BIST_FLS (tcam_row_1_col_1_bist_fls),
                         .MDST_tcam (fuse_tcam)
                     );
        
              end
              
            else
              begin : gen_tcam_row_1_col_1_bcam
              end
              
        
        
        endgenerate
        
        always_ff @(posedge clk) begin
                   tcam_rd_data_col[1][1]      <= tcam_row_1_col_1_data_out;
                   tcam_col_hit_out[1][1]       <= tcam_row_1_col_1_hit_out;
        end
        

        // this is new template - tcam_asic_template
        
        wire                                            tcam_row_2_col_0_clk         = clk;
        
        wire    [TCAM_SLICE_EN_FACT-1:0]                tcam_row_2_col_0_slice_en = TCAM_SLICE_EN_FACT'(slice_en[(2 * TCAM_SLICE_EN_FACT)+:TCAM_SLICE_EN_MIN]);
        
        wire                                            tcam_row_2_col_0_rd_en       = tcam_row_rd_en[2];
        wire                                            tcam_row_2_col_0_wr_en       = tcam_row_wr_en[2];
        wire                                            tcam_row_2_col_0_chk_en      = chk_en;
        wire                                            tcam_row_2_col_0_reset_n = reset_n;
        wire    [7-1:0]                       tcam_row_2_col_0_adr  = tcam_row_adr[2][7-1:0];
        wire    [32-1:0]                      tcam_row_2_col_0_data_in = tcam_row_wr_en[2] ? tcam_wr_data_col[0][32-1:0] : tcam_chk_key_col[0][32-1:0];
        wire    [32-1:0]                      tcam_row_2_col_0_data_in_pre = tcam_wr_data_col[0][32-1:0] ;
        wire    [32-1:0]                      tcam_row_2_col_0_key_in =  tcam_chk_key_col[0][32-1:0];
        wire    [32-1:0]                      tcam_row_2_col_0_mask_in = tcam_chk_mask_col[0][32-1:0];
        wire    [64-1:0]                       tcam_row_2_col_0_hit_in = tcam_raw_hit_in[2];
        wire    [64-1:0]                       tcam_row_2_col_0_tcam_match_in = tcam_row_match_in[2];
        wire    [32-1:0]                      tcam_row_2_col_0_data_out_inv;
        logic   [64-1:0]                     tcam_row_2_col_0_hit_out_int;
        logic   [64-1:0]                     tcam_row_2_col_0_hit_out_latch;
        logic   [64-1:0]                     tcam_row_2_col_0_hit_out;
        
        `ifdef HIF_PCIE_DFX_DISABLE
        wire                          tcam_row_2_col_0_biste = 'b0; 
        wire     [5-1:0]                  tcam_row_2_col_0_fca = 'b0;
        wire                            tcam_row_2_col_0_cre = 'b0;
        wire                            tcam_row_2_col_0_dftshiften = 'b0;
        wire                            tcam_row_2_col_0_dftmask = 'b0;
        wire                            tcam_row_2_col_0_dft_array_freeze = 'b0;
        wire                            tcam_row_2_col_0_dft_afd_reset_b = 'b0;
        wire      [32-1:0]    tcam_row_2_col_0_tdin = 'b0;
        wire      [7-1:0]     tcam_row_2_col_0_tadr = 'b0;
        wire                            tcam_row_2_col_0_tvbe = 'b0;
        wire                            tcam_row_2_col_0_tvbi = 'b0;
        wire      [32-1:0]    tcam_row_2_col_0_tmask = 'b0;
        wire                            tcam_row_2_col_0_twe = 'b0;
        wire                            tcam_row_2_col_0_tre = 'b0;
        wire                            tcam_row_2_col_0_tme = 'b0;
        wire                            tcam_row_2_col_0_bist_rotate_sr = 'b0;
        wire                            tcam_row_2_col_0_bist_en_sr_mask_b = 'b0;
        wire                            tcam_row_2_col_0_bist_all_mask = 'b0;
        wire                            tcam_row_2_col_0_bist_en_sr_data_b = 'b0;
        wire                            tcam_row_2_col_0_bist_cm_mode = 'b0;
        wire                            tcam_row_2_col_0_bist_cm_en_in = 'b0;
        wire                            tcam_row_2_col_0_bist_cm_match_sel0 = 'b0;
        wire                            tcam_row_2_col_0_bist_cm_match_sel1 = 'b0;
        wire                            tcam_row_2_col_0_bist_matchin_in = 'b0;
        wire                            tcam_row_2_col_0_bist_fls = 'b0;
        
        `else
        wire                            tcam_row_2_col_0_biste = 'b0;
        wire     [5-1:0]                  tcam_row_2_col_0_fca = 'b0;
        wire                            tcam_row_2_col_0_cre = 'b0;
        wire                            tcam_row_2_col_0_dftshiften = dftshiften;
        wire                            tcam_row_2_col_0_dftmask = dftmask;
        wire                            tcam_row_2_col_0_dft_array_freeze = dft_array_freeze;
        wire                            tcam_row_2_col_0_dft_afd_reset_b = dft_afd_reset_b;
        wire      [32-1:0]    tcam_row_2_col_0_tdin = 'b0;
        wire      [7-1:0]     tcam_row_2_col_0_tadr = 'b0;
        wire                            tcam_row_2_col_0_tvbe = 'b0;
        wire                            tcam_row_2_col_0_tvbi = 'b0;
        wire      [32-1:0]    tcam_row_2_col_0_tmask = 'b0;
        wire                            tcam_row_2_col_0_twe = 'b0;
        wire                            tcam_row_2_col_0_tre = 'b0;
        wire                            tcam_row_2_col_0_tme = 'b0;
        wire                            tcam_row_2_col_0_bist_rotate_sr = 'b0;
        wire                            tcam_row_2_col_0_bist_en_sr_mask_b = 'b0;
        wire                            tcam_row_2_col_0_bist_all_mask = 'b0;
        wire                            tcam_row_2_col_0_bist_en_sr_data_b = 'b0;
        wire                            tcam_row_2_col_0_bist_cm_mode = 'b0;
        wire                            tcam_row_2_col_0_bist_cm_en_in = 'b0;
        wire                            tcam_row_2_col_0_bist_cm_match_sel0 = 'b0;
        wire                            tcam_row_2_col_0_bist_cm_match_sel1 = 'b0;
        wire                            tcam_row_2_col_0_bist_matchin_in = 'b0;
        wire                            tcam_row_2_col_0_bist_fls = 'b0;
        `endif
        
        // Outputs
        logic                           tcam_row_2_col_0_wr_bira_fail;
        logic                           tcam_row_2_col_0_wr_so;
        logic                           tcam_row_2_col_0_curerrout;
        logic                           tcam_row_2_col_0_rscout;
        
        
        
        logic   [TCAM_SLICE_EN_FACT-1:0]                  tcam_row_2_col_0_slice_en_s0; 
        logic   [TCAM_SLICE_EN_FACT-1:0]                  tcam_row_2_col_0_slice_en_s1; 
        
        
        
             wire    [32-1:0]                     tcam_row_2_col_0_data_out ;
        
        
        
         generate
            if (BCAM_N7 == 0) 
              begin : gen_tcam_row_2_col_0_tcam
        
        
        // slice_en kept for TCAM only for backward compatability with Intel process
                always_comb 
                begin
                  for (int i = 0; i < TCAM_SLICE_EN_FACT; i++)
                      if (tcam_row_2_col_0_slice_en_s1[i])
                           tcam_row_2_col_0_hit_out[ i*64 +: 64]  = tcam_row_2_col_0_hit_out_int  [ i*64 +: 64]; 
                      else
                           tcam_row_2_col_0_hit_out[ i*64 +: 64]  = tcam_row_2_col_0_hit_out_latch[ i*64 +: 64]; 
                end
        
        
        
                always_ff  @(posedge tcam_row_2_col_0_clk)
                begin
                  tcam_row_2_col_0_slice_en_s0 <= tcam_row_2_col_0_slice_en; 
                  tcam_row_2_col_0_slice_en_s1 <= tcam_row_2_col_0_slice_en_s0; 
        
                  for (int i = 0; i < TCAM_SLICE_EN_FACT; i++)
                    begin
                      if (tcam_row_2_col_0_slice_en_s1[i])
                         tcam_row_2_col_0_hit_out_latch[ i*64 +: 64] <=  tcam_row_2_col_0_hit_out_int[ i*64 +: 64];
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
        
                     
                         assign tcam_row_2_col_0_data_out  = ~tcam_row_2_col_0_data_out_inv;
                         pcie_itp_ip783tcam64x32s0c1_2_0_wrap #(        
                                 )               
        
                                 ip783tcam64x32s0c1_wrap_tcam_row_2_col_0 (
                   //-------------------------------------------------------------
                   // Power Management Interfaces
                   //-------------------------------------------------------------   
                      `ifndef INTEL_NO_PWR_PINS
                      `ifdef INTC_ADD_VSS
                        .vss              (1'b0),
                      `endif
                        .vddp             (1'b1),
                      `endif
                         .ADR               (tcam_row_2_col_0_adr[7-1:1]), //Input adr_intess
                         .ME                (ce),  
        
                         .CLK               (tcam_row_2_col_0_clk), //Clock
                         .CMP               (tcam_row_2_col_0_chk_en), //Control Enable
                         .DIN               (~tcam_row_2_col_0_data_in), 
                         .DSEL              (~tcam_row_2_col_0_adr[0]), //dncen enables access of the TCAM Arrays adr_intessed
                         .FLS               (flush), //flush initiates a Flush operation that resets all Valid
                         .RVLD              (tcam_row_2_col_0_hit_in ), //Row validation bus. Each match_in input controls 1
                         .MASK              (tcam_row_2_col_0_mask_in), //Input msk
                         .QOUT              (tcam_row_2_col_0_data_out_inv), //Output vben
                         .QHR               (tcam_row_2_col_0_hit_out_int),
                         .QVLD              (), 
                         .RE                (tcam_row_2_col_0_rd_en), //Read Enable
                         .RST               (tcam_row_2_col_0_reset_n), //Asynchronous Active-High Reset
                         .VBE               (1'b1), //vben enables the Valid Bit addressed by adr[a-1:0] to
                         .VBI               (1'b0),//  Valid Bit Input
                         .WE                (tcam_row_2_col_0_wr_en), //Write Enable
                         .FAF               (tcam_row_2_col_0_fca),
                         .FAF_EN            (tcam_row_2_col_0_cre),
                         .DFTSHIFTEN        (tcam_row_2_col_0_dftshiften),
                         .DFTMASK           (tcam_row_2_col_0_dftmask),
                         .DFT_ARRAY_FREEZE  (tcam_row_2_col_0_dft_array_freeze),
                         .DFT_AFD_RESET_B   (tcam_row_2_col_0_dft_afd_reset_b),
                         .BISTE           (tcam_row_2_col_0_biste),
                         .TDIN (tcam_row_2_col_0_tdin),
                         .TADR (tcam_row_2_col_0_tadr),
                         .TVBE (tcam_row_2_col_0_tvbe),
                         .TVBI (tcam_row_2_col_0_tvbi),
                         .TMASK (tcam_row_2_col_0_tmask),
                         .TWE (tcam_row_2_col_0_twe),
                         .TRE (tcam_row_2_col_0_tre),
                         .TME (tcam_row_2_col_0_tme),
                         .BIST_ROTATE_SR (tcam_row_2_col_0_bist_rotate_sr),
                         .BIST_EN_SR_MASK_B (tcam_row_2_col_0_bist_en_sr_mask_b),
                         .BIST_ALL_MASK (tcam_row_2_col_0_bist_all_mask),
                         .BIST_EN_SR_DATA_B (tcam_row_2_col_0_bist_en_sr_data_b),
                         .BIST_CM_MODE (tcam_row_2_col_0_bist_cm_mode),
                         .BIST_CM_EN_IN (tcam_row_2_col_0_bist_cm_en_in),
                         .BIST_CM_MATCH_SEL0 (tcam_row_2_col_0_bist_cm_match_sel0),
                         .BIST_CM_MATCH_SEL1 (tcam_row_2_col_0_bist_cm_match_sel1),
                         .BIST_MATCHIN_IN (tcam_row_2_col_0_bist_matchin_in),
                         .BIST_FLS (tcam_row_2_col_0_bist_fls),
                         .MDST_tcam (fuse_tcam)
                     );
        
              end
              
            else
              begin : gen_tcam_row_2_col_0_bcam
              end
              
        
        
        endgenerate
        
        always_ff @(posedge clk) begin
                   tcam_rd_data_col[2][0]      <= tcam_row_2_col_0_data_out;
                   tcam_col_hit_out[2][0]       <= tcam_row_2_col_0_hit_out;
        end
        

        // this is new template - tcam_asic_template
        
        wire                                            tcam_row_2_col_1_clk         = clk;
        
        wire    [TCAM_SLICE_EN_FACT-1:0]                tcam_row_2_col_1_slice_en = TCAM_SLICE_EN_FACT'(slice_en[(2 * TCAM_SLICE_EN_FACT)+:TCAM_SLICE_EN_MIN]);
        
        wire                                            tcam_row_2_col_1_rd_en       = tcam_row_rd_en[2];
        wire                                            tcam_row_2_col_1_wr_en       = tcam_row_wr_en[2];
        wire                                            tcam_row_2_col_1_chk_en      = chk_en;
        wire                                            tcam_row_2_col_1_reset_n = reset_n;
        wire    [7-1:0]                       tcam_row_2_col_1_adr  = tcam_row_adr[2][7-1:0];
        wire    [32-1:0]                      tcam_row_2_col_1_data_in = tcam_row_wr_en[2] ? tcam_wr_data_col[1][32-1:0] : tcam_chk_key_col[1][32-1:0];
        wire    [32-1:0]                      tcam_row_2_col_1_data_in_pre = tcam_wr_data_col[1][32-1:0] ;
        wire    [32-1:0]                      tcam_row_2_col_1_key_in =  tcam_chk_key_col[1][32-1:0];
        wire    [32-1:0]                      tcam_row_2_col_1_mask_in = tcam_chk_mask_col[1][32-1:0];
        wire    [64-1:0]                       tcam_row_2_col_1_hit_in = tcam_raw_hit_in[2];
        wire    [64-1:0]                       tcam_row_2_col_1_tcam_match_in = tcam_row_match_in[2];
        wire    [32-1:0]                      tcam_row_2_col_1_data_out_inv;
        logic   [64-1:0]                     tcam_row_2_col_1_hit_out_int;
        logic   [64-1:0]                     tcam_row_2_col_1_hit_out_latch;
        logic   [64-1:0]                     tcam_row_2_col_1_hit_out;
        
        `ifdef HIF_PCIE_DFX_DISABLE
        wire                          tcam_row_2_col_1_biste = 'b0; 
        wire     [5-1:0]                  tcam_row_2_col_1_fca = 'b0;
        wire                            tcam_row_2_col_1_cre = 'b0;
        wire                            tcam_row_2_col_1_dftshiften = 'b0;
        wire                            tcam_row_2_col_1_dftmask = 'b0;
        wire                            tcam_row_2_col_1_dft_array_freeze = 'b0;
        wire                            tcam_row_2_col_1_dft_afd_reset_b = 'b0;
        wire      [32-1:0]    tcam_row_2_col_1_tdin = 'b0;
        wire      [7-1:0]     tcam_row_2_col_1_tadr = 'b0;
        wire                            tcam_row_2_col_1_tvbe = 'b0;
        wire                            tcam_row_2_col_1_tvbi = 'b0;
        wire      [32-1:0]    tcam_row_2_col_1_tmask = 'b0;
        wire                            tcam_row_2_col_1_twe = 'b0;
        wire                            tcam_row_2_col_1_tre = 'b0;
        wire                            tcam_row_2_col_1_tme = 'b0;
        wire                            tcam_row_2_col_1_bist_rotate_sr = 'b0;
        wire                            tcam_row_2_col_1_bist_en_sr_mask_b = 'b0;
        wire                            tcam_row_2_col_1_bist_all_mask = 'b0;
        wire                            tcam_row_2_col_1_bist_en_sr_data_b = 'b0;
        wire                            tcam_row_2_col_1_bist_cm_mode = 'b0;
        wire                            tcam_row_2_col_1_bist_cm_en_in = 'b0;
        wire                            tcam_row_2_col_1_bist_cm_match_sel0 = 'b0;
        wire                            tcam_row_2_col_1_bist_cm_match_sel1 = 'b0;
        wire                            tcam_row_2_col_1_bist_matchin_in = 'b0;
        wire                            tcam_row_2_col_1_bist_fls = 'b0;
        
        `else
        wire                            tcam_row_2_col_1_biste = 'b0;
        wire     [5-1:0]                  tcam_row_2_col_1_fca = 'b0;
        wire                            tcam_row_2_col_1_cre = 'b0;
        wire                            tcam_row_2_col_1_dftshiften = dftshiften;
        wire                            tcam_row_2_col_1_dftmask = dftmask;
        wire                            tcam_row_2_col_1_dft_array_freeze = dft_array_freeze;
        wire                            tcam_row_2_col_1_dft_afd_reset_b = dft_afd_reset_b;
        wire      [32-1:0]    tcam_row_2_col_1_tdin = 'b0;
        wire      [7-1:0]     tcam_row_2_col_1_tadr = 'b0;
        wire                            tcam_row_2_col_1_tvbe = 'b0;
        wire                            tcam_row_2_col_1_tvbi = 'b0;
        wire      [32-1:0]    tcam_row_2_col_1_tmask = 'b0;
        wire                            tcam_row_2_col_1_twe = 'b0;
        wire                            tcam_row_2_col_1_tre = 'b0;
        wire                            tcam_row_2_col_1_tme = 'b0;
        wire                            tcam_row_2_col_1_bist_rotate_sr = 'b0;
        wire                            tcam_row_2_col_1_bist_en_sr_mask_b = 'b0;
        wire                            tcam_row_2_col_1_bist_all_mask = 'b0;
        wire                            tcam_row_2_col_1_bist_en_sr_data_b = 'b0;
        wire                            tcam_row_2_col_1_bist_cm_mode = 'b0;
        wire                            tcam_row_2_col_1_bist_cm_en_in = 'b0;
        wire                            tcam_row_2_col_1_bist_cm_match_sel0 = 'b0;
        wire                            tcam_row_2_col_1_bist_cm_match_sel1 = 'b0;
        wire                            tcam_row_2_col_1_bist_matchin_in = 'b0;
        wire                            tcam_row_2_col_1_bist_fls = 'b0;
        `endif
        
        // Outputs
        logic                           tcam_row_2_col_1_wr_bira_fail;
        logic                           tcam_row_2_col_1_wr_so;
        logic                           tcam_row_2_col_1_curerrout;
        logic                           tcam_row_2_col_1_rscout;
        
        
        
        logic   [TCAM_SLICE_EN_FACT-1:0]                  tcam_row_2_col_1_slice_en_s0; 
        logic   [TCAM_SLICE_EN_FACT-1:0]                  tcam_row_2_col_1_slice_en_s1; 
        
        
        
             wire    [32-1:0]                     tcam_row_2_col_1_data_out ;
        
        
        
         generate
            if (BCAM_N7 == 0) 
              begin : gen_tcam_row_2_col_1_tcam
        
        
        // slice_en kept for TCAM only for backward compatability with Intel process
                always_comb 
                begin
                  for (int i = 0; i < TCAM_SLICE_EN_FACT; i++)
                      if (tcam_row_2_col_1_slice_en_s1[i])
                           tcam_row_2_col_1_hit_out[ i*64 +: 64]  = tcam_row_2_col_1_hit_out_int  [ i*64 +: 64]; 
                      else
                           tcam_row_2_col_1_hit_out[ i*64 +: 64]  = tcam_row_2_col_1_hit_out_latch[ i*64 +: 64]; 
                end
        
        
        
                always_ff  @(posedge tcam_row_2_col_1_clk)
                begin
                  tcam_row_2_col_1_slice_en_s0 <= tcam_row_2_col_1_slice_en; 
                  tcam_row_2_col_1_slice_en_s1 <= tcam_row_2_col_1_slice_en_s0; 
        
                  for (int i = 0; i < TCAM_SLICE_EN_FACT; i++)
                    begin
                      if (tcam_row_2_col_1_slice_en_s1[i])
                         tcam_row_2_col_1_hit_out_latch[ i*64 +: 64] <=  tcam_row_2_col_1_hit_out_int[ i*64 +: 64];
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
        
                     
                         assign tcam_row_2_col_1_data_out  = ~tcam_row_2_col_1_data_out_inv;
                         pcie_itp_ip783tcam64x32s0c1_2_1_wrap #(        
                                 )               
        
                                 ip783tcam64x32s0c1_wrap_tcam_row_2_col_1 (
                   //-------------------------------------------------------------
                   // Power Management Interfaces
                   //-------------------------------------------------------------   
                      `ifndef INTEL_NO_PWR_PINS
                      `ifdef INTC_ADD_VSS
                        .vss              (1'b0),
                      `endif
                        .vddp             (1'b1),
                      `endif
                         .ADR               (tcam_row_2_col_1_adr[7-1:1]), //Input adr_intess
                         .ME                (ce),  
        
                         .CLK               (tcam_row_2_col_1_clk), //Clock
                         .CMP               (tcam_row_2_col_1_chk_en), //Control Enable
                         .DIN               (~tcam_row_2_col_1_data_in), 
                         .DSEL              (~tcam_row_2_col_1_adr[0]), //dncen enables access of the TCAM Arrays adr_intessed
                         .FLS               (flush), //flush initiates a Flush operation that resets all Valid
                         .RVLD              (tcam_row_2_col_1_hit_in ), //Row validation bus. Each match_in input controls 1
                         .MASK              (tcam_row_2_col_1_mask_in), //Input msk
                         .QOUT              (tcam_row_2_col_1_data_out_inv), //Output vben
                         .QHR               (tcam_row_2_col_1_hit_out_int),
                         .QVLD              (), 
                         .RE                (tcam_row_2_col_1_rd_en), //Read Enable
                         .RST               (tcam_row_2_col_1_reset_n), //Asynchronous Active-High Reset
                         .VBE               (1'b1), //vben enables the Valid Bit addressed by adr[a-1:0] to
                         .VBI               (1'b0),//  Valid Bit Input
                         .WE                (tcam_row_2_col_1_wr_en), //Write Enable
                         .FAF               (tcam_row_2_col_1_fca),
                         .FAF_EN            (tcam_row_2_col_1_cre),
                         .DFTSHIFTEN        (tcam_row_2_col_1_dftshiften),
                         .DFTMASK           (tcam_row_2_col_1_dftmask),
                         .DFT_ARRAY_FREEZE  (tcam_row_2_col_1_dft_array_freeze),
                         .DFT_AFD_RESET_B   (tcam_row_2_col_1_dft_afd_reset_b),
                         .BISTE           (tcam_row_2_col_1_biste),
                         .TDIN (tcam_row_2_col_1_tdin),
                         .TADR (tcam_row_2_col_1_tadr),
                         .TVBE (tcam_row_2_col_1_tvbe),
                         .TVBI (tcam_row_2_col_1_tvbi),
                         .TMASK (tcam_row_2_col_1_tmask),
                         .TWE (tcam_row_2_col_1_twe),
                         .TRE (tcam_row_2_col_1_tre),
                         .TME (tcam_row_2_col_1_tme),
                         .BIST_ROTATE_SR (tcam_row_2_col_1_bist_rotate_sr),
                         .BIST_EN_SR_MASK_B (tcam_row_2_col_1_bist_en_sr_mask_b),
                         .BIST_ALL_MASK (tcam_row_2_col_1_bist_all_mask),
                         .BIST_EN_SR_DATA_B (tcam_row_2_col_1_bist_en_sr_data_b),
                         .BIST_CM_MODE (tcam_row_2_col_1_bist_cm_mode),
                         .BIST_CM_EN_IN (tcam_row_2_col_1_bist_cm_en_in),
                         .BIST_CM_MATCH_SEL0 (tcam_row_2_col_1_bist_cm_match_sel0),
                         .BIST_CM_MATCH_SEL1 (tcam_row_2_col_1_bist_cm_match_sel1),
                         .BIST_MATCHIN_IN (tcam_row_2_col_1_bist_matchin_in),
                         .BIST_FLS (tcam_row_2_col_1_bist_fls),
                         .MDST_tcam (fuse_tcam)
                     );
        
              end
              
            else
              begin : gen_tcam_row_2_col_1_bcam
              end
              
        
        
        endgenerate
        
        always_ff @(posedge clk) begin
                   tcam_rd_data_col[2][1]      <= tcam_row_2_col_1_data_out;
                   tcam_col_hit_out[2][1]       <= tcam_row_2_col_1_hit_out;
        end
        

        // this is new template - tcam_asic_template
        
        wire                                            tcam_row_3_col_0_clk         = clk;
        
        wire    [TCAM_SLICE_EN_FACT-1:0]                tcam_row_3_col_0_slice_en = TCAM_SLICE_EN_FACT'(slice_en[(3 * TCAM_SLICE_EN_FACT)+:TCAM_SLICE_EN_MIN]);
        
        wire                                            tcam_row_3_col_0_rd_en       = tcam_row_rd_en[3];
        wire                                            tcam_row_3_col_0_wr_en       = tcam_row_wr_en[3];
        wire                                            tcam_row_3_col_0_chk_en      = chk_en;
        wire                                            tcam_row_3_col_0_reset_n = reset_n;
        wire    [7-1:0]                       tcam_row_3_col_0_adr  = tcam_row_adr[3][7-1:0];
        wire    [32-1:0]                      tcam_row_3_col_0_data_in = tcam_row_wr_en[3] ? tcam_wr_data_col[0][32-1:0] : tcam_chk_key_col[0][32-1:0];
        wire    [32-1:0]                      tcam_row_3_col_0_data_in_pre = tcam_wr_data_col[0][32-1:0] ;
        wire    [32-1:0]                      tcam_row_3_col_0_key_in =  tcam_chk_key_col[0][32-1:0];
        wire    [32-1:0]                      tcam_row_3_col_0_mask_in = tcam_chk_mask_col[0][32-1:0];
        wire    [64-1:0]                       tcam_row_3_col_0_hit_in = tcam_raw_hit_in[3];
        wire    [64-1:0]                       tcam_row_3_col_0_tcam_match_in = tcam_row_match_in[3];
        wire    [32-1:0]                      tcam_row_3_col_0_data_out_inv;
        logic   [64-1:0]                     tcam_row_3_col_0_hit_out_int;
        logic   [64-1:0]                     tcam_row_3_col_0_hit_out_latch;
        logic   [64-1:0]                     tcam_row_3_col_0_hit_out;
        
        `ifdef HIF_PCIE_DFX_DISABLE
        wire                          tcam_row_3_col_0_biste = 'b0; 
        wire     [5-1:0]                  tcam_row_3_col_0_fca = 'b0;
        wire                            tcam_row_3_col_0_cre = 'b0;
        wire                            tcam_row_3_col_0_dftshiften = 'b0;
        wire                            tcam_row_3_col_0_dftmask = 'b0;
        wire                            tcam_row_3_col_0_dft_array_freeze = 'b0;
        wire                            tcam_row_3_col_0_dft_afd_reset_b = 'b0;
        wire      [32-1:0]    tcam_row_3_col_0_tdin = 'b0;
        wire      [7-1:0]     tcam_row_3_col_0_tadr = 'b0;
        wire                            tcam_row_3_col_0_tvbe = 'b0;
        wire                            tcam_row_3_col_0_tvbi = 'b0;
        wire      [32-1:0]    tcam_row_3_col_0_tmask = 'b0;
        wire                            tcam_row_3_col_0_twe = 'b0;
        wire                            tcam_row_3_col_0_tre = 'b0;
        wire                            tcam_row_3_col_0_tme = 'b0;
        wire                            tcam_row_3_col_0_bist_rotate_sr = 'b0;
        wire                            tcam_row_3_col_0_bist_en_sr_mask_b = 'b0;
        wire                            tcam_row_3_col_0_bist_all_mask = 'b0;
        wire                            tcam_row_3_col_0_bist_en_sr_data_b = 'b0;
        wire                            tcam_row_3_col_0_bist_cm_mode = 'b0;
        wire                            tcam_row_3_col_0_bist_cm_en_in = 'b0;
        wire                            tcam_row_3_col_0_bist_cm_match_sel0 = 'b0;
        wire                            tcam_row_3_col_0_bist_cm_match_sel1 = 'b0;
        wire                            tcam_row_3_col_0_bist_matchin_in = 'b0;
        wire                            tcam_row_3_col_0_bist_fls = 'b0;
        
        `else
        wire                            tcam_row_3_col_0_biste = 'b0;
        wire     [5-1:0]                  tcam_row_3_col_0_fca = 'b0;
        wire                            tcam_row_3_col_0_cre = 'b0;
        wire                            tcam_row_3_col_0_dftshiften = dftshiften;
        wire                            tcam_row_3_col_0_dftmask = dftmask;
        wire                            tcam_row_3_col_0_dft_array_freeze = dft_array_freeze;
        wire                            tcam_row_3_col_0_dft_afd_reset_b = dft_afd_reset_b;
        wire      [32-1:0]    tcam_row_3_col_0_tdin = 'b0;
        wire      [7-1:0]     tcam_row_3_col_0_tadr = 'b0;
        wire                            tcam_row_3_col_0_tvbe = 'b0;
        wire                            tcam_row_3_col_0_tvbi = 'b0;
        wire      [32-1:0]    tcam_row_3_col_0_tmask = 'b0;
        wire                            tcam_row_3_col_0_twe = 'b0;
        wire                            tcam_row_3_col_0_tre = 'b0;
        wire                            tcam_row_3_col_0_tme = 'b0;
        wire                            tcam_row_3_col_0_bist_rotate_sr = 'b0;
        wire                            tcam_row_3_col_0_bist_en_sr_mask_b = 'b0;
        wire                            tcam_row_3_col_0_bist_all_mask = 'b0;
        wire                            tcam_row_3_col_0_bist_en_sr_data_b = 'b0;
        wire                            tcam_row_3_col_0_bist_cm_mode = 'b0;
        wire                            tcam_row_3_col_0_bist_cm_en_in = 'b0;
        wire                            tcam_row_3_col_0_bist_cm_match_sel0 = 'b0;
        wire                            tcam_row_3_col_0_bist_cm_match_sel1 = 'b0;
        wire                            tcam_row_3_col_0_bist_matchin_in = 'b0;
        wire                            tcam_row_3_col_0_bist_fls = 'b0;
        `endif
        
        // Outputs
        logic                           tcam_row_3_col_0_wr_bira_fail;
        logic                           tcam_row_3_col_0_wr_so;
        logic                           tcam_row_3_col_0_curerrout;
        logic                           tcam_row_3_col_0_rscout;
        
        
        
        logic   [TCAM_SLICE_EN_FACT-1:0]                  tcam_row_3_col_0_slice_en_s0; 
        logic   [TCAM_SLICE_EN_FACT-1:0]                  tcam_row_3_col_0_slice_en_s1; 
        
        
        
             wire    [32-1:0]                     tcam_row_3_col_0_data_out ;
        
        
        
         generate
            if (BCAM_N7 == 0) 
              begin : gen_tcam_row_3_col_0_tcam
        
        
        // slice_en kept for TCAM only for backward compatability with Intel process
                always_comb 
                begin
                  for (int i = 0; i < TCAM_SLICE_EN_FACT; i++)
                      if (tcam_row_3_col_0_slice_en_s1[i])
                           tcam_row_3_col_0_hit_out[ i*64 +: 64]  = tcam_row_3_col_0_hit_out_int  [ i*64 +: 64]; 
                      else
                           tcam_row_3_col_0_hit_out[ i*64 +: 64]  = tcam_row_3_col_0_hit_out_latch[ i*64 +: 64]; 
                end
        
        
        
                always_ff  @(posedge tcam_row_3_col_0_clk)
                begin
                  tcam_row_3_col_0_slice_en_s0 <= tcam_row_3_col_0_slice_en; 
                  tcam_row_3_col_0_slice_en_s1 <= tcam_row_3_col_0_slice_en_s0; 
        
                  for (int i = 0; i < TCAM_SLICE_EN_FACT; i++)
                    begin
                      if (tcam_row_3_col_0_slice_en_s1[i])
                         tcam_row_3_col_0_hit_out_latch[ i*64 +: 64] <=  tcam_row_3_col_0_hit_out_int[ i*64 +: 64];
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
        
                     
                         assign tcam_row_3_col_0_data_out  = ~tcam_row_3_col_0_data_out_inv;
                         pcie_itp_ip783tcam64x32s0c1_3_0_wrap #(        
                                 )               
        
                                 ip783tcam64x32s0c1_wrap_tcam_row_3_col_0 (
                   //-------------------------------------------------------------
                   // Power Management Interfaces
                   //-------------------------------------------------------------   
                      `ifndef INTEL_NO_PWR_PINS
                      `ifdef INTC_ADD_VSS
                        .vss              (1'b0),
                      `endif
                        .vddp             (1'b1),
                      `endif
                         .ADR               (tcam_row_3_col_0_adr[7-1:1]), //Input adr_intess
                         .ME                (ce),  
        
                         .CLK               (tcam_row_3_col_0_clk), //Clock
                         .CMP               (tcam_row_3_col_0_chk_en), //Control Enable
                         .DIN               (~tcam_row_3_col_0_data_in), 
                         .DSEL              (~tcam_row_3_col_0_adr[0]), //dncen enables access of the TCAM Arrays adr_intessed
                         .FLS               (flush), //flush initiates a Flush operation that resets all Valid
                         .RVLD              (tcam_row_3_col_0_hit_in ), //Row validation bus. Each match_in input controls 1
                         .MASK              (tcam_row_3_col_0_mask_in), //Input msk
                         .QOUT              (tcam_row_3_col_0_data_out_inv), //Output vben
                         .QHR               (tcam_row_3_col_0_hit_out_int),
                         .QVLD              (), 
                         .RE                (tcam_row_3_col_0_rd_en), //Read Enable
                         .RST               (tcam_row_3_col_0_reset_n), //Asynchronous Active-High Reset
                         .VBE               (1'b1), //vben enables the Valid Bit addressed by adr[a-1:0] to
                         .VBI               (1'b0),//  Valid Bit Input
                         .WE                (tcam_row_3_col_0_wr_en), //Write Enable
                         .FAF               (tcam_row_3_col_0_fca),
                         .FAF_EN            (tcam_row_3_col_0_cre),
                         .DFTSHIFTEN        (tcam_row_3_col_0_dftshiften),
                         .DFTMASK           (tcam_row_3_col_0_dftmask),
                         .DFT_ARRAY_FREEZE  (tcam_row_3_col_0_dft_array_freeze),
                         .DFT_AFD_RESET_B   (tcam_row_3_col_0_dft_afd_reset_b),
                         .BISTE           (tcam_row_3_col_0_biste),
                         .TDIN (tcam_row_3_col_0_tdin),
                         .TADR (tcam_row_3_col_0_tadr),
                         .TVBE (tcam_row_3_col_0_tvbe),
                         .TVBI (tcam_row_3_col_0_tvbi),
                         .TMASK (tcam_row_3_col_0_tmask),
                         .TWE (tcam_row_3_col_0_twe),
                         .TRE (tcam_row_3_col_0_tre),
                         .TME (tcam_row_3_col_0_tme),
                         .BIST_ROTATE_SR (tcam_row_3_col_0_bist_rotate_sr),
                         .BIST_EN_SR_MASK_B (tcam_row_3_col_0_bist_en_sr_mask_b),
                         .BIST_ALL_MASK (tcam_row_3_col_0_bist_all_mask),
                         .BIST_EN_SR_DATA_B (tcam_row_3_col_0_bist_en_sr_data_b),
                         .BIST_CM_MODE (tcam_row_3_col_0_bist_cm_mode),
                         .BIST_CM_EN_IN (tcam_row_3_col_0_bist_cm_en_in),
                         .BIST_CM_MATCH_SEL0 (tcam_row_3_col_0_bist_cm_match_sel0),
                         .BIST_CM_MATCH_SEL1 (tcam_row_3_col_0_bist_cm_match_sel1),
                         .BIST_MATCHIN_IN (tcam_row_3_col_0_bist_matchin_in),
                         .BIST_FLS (tcam_row_3_col_0_bist_fls),
                         .MDST_tcam (fuse_tcam)
                     );
        
              end
              
            else
              begin : gen_tcam_row_3_col_0_bcam
              end
              
        
        
        endgenerate
        
        always_ff @(posedge clk) begin
                   tcam_rd_data_col[3][0]      <= tcam_row_3_col_0_data_out;
                   tcam_col_hit_out[3][0]       <= tcam_row_3_col_0_hit_out;
        end
        

        // this is new template - tcam_asic_template
        
        wire                                            tcam_row_3_col_1_clk         = clk;
        
        wire    [TCAM_SLICE_EN_FACT-1:0]                tcam_row_3_col_1_slice_en = TCAM_SLICE_EN_FACT'(slice_en[(3 * TCAM_SLICE_EN_FACT)+:TCAM_SLICE_EN_MIN]);
        
        wire                                            tcam_row_3_col_1_rd_en       = tcam_row_rd_en[3];
        wire                                            tcam_row_3_col_1_wr_en       = tcam_row_wr_en[3];
        wire                                            tcam_row_3_col_1_chk_en      = chk_en;
        wire                                            tcam_row_3_col_1_reset_n = reset_n;
        wire    [7-1:0]                       tcam_row_3_col_1_adr  = tcam_row_adr[3][7-1:0];
        wire    [32-1:0]                      tcam_row_3_col_1_data_in = tcam_row_wr_en[3] ? tcam_wr_data_col[1][32-1:0] : tcam_chk_key_col[1][32-1:0];
        wire    [32-1:0]                      tcam_row_3_col_1_data_in_pre = tcam_wr_data_col[1][32-1:0] ;
        wire    [32-1:0]                      tcam_row_3_col_1_key_in =  tcam_chk_key_col[1][32-1:0];
        wire    [32-1:0]                      tcam_row_3_col_1_mask_in = tcam_chk_mask_col[1][32-1:0];
        wire    [64-1:0]                       tcam_row_3_col_1_hit_in = tcam_raw_hit_in[3];
        wire    [64-1:0]                       tcam_row_3_col_1_tcam_match_in = tcam_row_match_in[3];
        wire    [32-1:0]                      tcam_row_3_col_1_data_out_inv;
        logic   [64-1:0]                     tcam_row_3_col_1_hit_out_int;
        logic   [64-1:0]                     tcam_row_3_col_1_hit_out_latch;
        logic   [64-1:0]                     tcam_row_3_col_1_hit_out;
        
        `ifdef HIF_PCIE_DFX_DISABLE
        wire                          tcam_row_3_col_1_biste = 'b0; 
        wire     [5-1:0]                  tcam_row_3_col_1_fca = 'b0;
        wire                            tcam_row_3_col_1_cre = 'b0;
        wire                            tcam_row_3_col_1_dftshiften = 'b0;
        wire                            tcam_row_3_col_1_dftmask = 'b0;
        wire                            tcam_row_3_col_1_dft_array_freeze = 'b0;
        wire                            tcam_row_3_col_1_dft_afd_reset_b = 'b0;
        wire      [32-1:0]    tcam_row_3_col_1_tdin = 'b0;
        wire      [7-1:0]     tcam_row_3_col_1_tadr = 'b0;
        wire                            tcam_row_3_col_1_tvbe = 'b0;
        wire                            tcam_row_3_col_1_tvbi = 'b0;
        wire      [32-1:0]    tcam_row_3_col_1_tmask = 'b0;
        wire                            tcam_row_3_col_1_twe = 'b0;
        wire                            tcam_row_3_col_1_tre = 'b0;
        wire                            tcam_row_3_col_1_tme = 'b0;
        wire                            tcam_row_3_col_1_bist_rotate_sr = 'b0;
        wire                            tcam_row_3_col_1_bist_en_sr_mask_b = 'b0;
        wire                            tcam_row_3_col_1_bist_all_mask = 'b0;
        wire                            tcam_row_3_col_1_bist_en_sr_data_b = 'b0;
        wire                            tcam_row_3_col_1_bist_cm_mode = 'b0;
        wire                            tcam_row_3_col_1_bist_cm_en_in = 'b0;
        wire                            tcam_row_3_col_1_bist_cm_match_sel0 = 'b0;
        wire                            tcam_row_3_col_1_bist_cm_match_sel1 = 'b0;
        wire                            tcam_row_3_col_1_bist_matchin_in = 'b0;
        wire                            tcam_row_3_col_1_bist_fls = 'b0;
        
        `else
        wire                            tcam_row_3_col_1_biste = 'b0;
        wire     [5-1:0]                  tcam_row_3_col_1_fca = 'b0;
        wire                            tcam_row_3_col_1_cre = 'b0;
        wire                            tcam_row_3_col_1_dftshiften = dftshiften;
        wire                            tcam_row_3_col_1_dftmask = dftmask;
        wire                            tcam_row_3_col_1_dft_array_freeze = dft_array_freeze;
        wire                            tcam_row_3_col_1_dft_afd_reset_b = dft_afd_reset_b;
        wire      [32-1:0]    tcam_row_3_col_1_tdin = 'b0;
        wire      [7-1:0]     tcam_row_3_col_1_tadr = 'b0;
        wire                            tcam_row_3_col_1_tvbe = 'b0;
        wire                            tcam_row_3_col_1_tvbi = 'b0;
        wire      [32-1:0]    tcam_row_3_col_1_tmask = 'b0;
        wire                            tcam_row_3_col_1_twe = 'b0;
        wire                            tcam_row_3_col_1_tre = 'b0;
        wire                            tcam_row_3_col_1_tme = 'b0;
        wire                            tcam_row_3_col_1_bist_rotate_sr = 'b0;
        wire                            tcam_row_3_col_1_bist_en_sr_mask_b = 'b0;
        wire                            tcam_row_3_col_1_bist_all_mask = 'b0;
        wire                            tcam_row_3_col_1_bist_en_sr_data_b = 'b0;
        wire                            tcam_row_3_col_1_bist_cm_mode = 'b0;
        wire                            tcam_row_3_col_1_bist_cm_en_in = 'b0;
        wire                            tcam_row_3_col_1_bist_cm_match_sel0 = 'b0;
        wire                            tcam_row_3_col_1_bist_cm_match_sel1 = 'b0;
        wire                            tcam_row_3_col_1_bist_matchin_in = 'b0;
        wire                            tcam_row_3_col_1_bist_fls = 'b0;
        `endif
        
        // Outputs
        logic                           tcam_row_3_col_1_wr_bira_fail;
        logic                           tcam_row_3_col_1_wr_so;
        logic                           tcam_row_3_col_1_curerrout;
        logic                           tcam_row_3_col_1_rscout;
        
        
        
        logic   [TCAM_SLICE_EN_FACT-1:0]                  tcam_row_3_col_1_slice_en_s0; 
        logic   [TCAM_SLICE_EN_FACT-1:0]                  tcam_row_3_col_1_slice_en_s1; 
        
        
        
             wire    [32-1:0]                     tcam_row_3_col_1_data_out ;
        
        
        
         generate
            if (BCAM_N7 == 0) 
              begin : gen_tcam_row_3_col_1_tcam
        
        
        // slice_en kept for TCAM only for backward compatability with Intel process
                always_comb 
                begin
                  for (int i = 0; i < TCAM_SLICE_EN_FACT; i++)
                      if (tcam_row_3_col_1_slice_en_s1[i])
                           tcam_row_3_col_1_hit_out[ i*64 +: 64]  = tcam_row_3_col_1_hit_out_int  [ i*64 +: 64]; 
                      else
                           tcam_row_3_col_1_hit_out[ i*64 +: 64]  = tcam_row_3_col_1_hit_out_latch[ i*64 +: 64]; 
                end
        
        
        
                always_ff  @(posedge tcam_row_3_col_1_clk)
                begin
                  tcam_row_3_col_1_slice_en_s0 <= tcam_row_3_col_1_slice_en; 
                  tcam_row_3_col_1_slice_en_s1 <= tcam_row_3_col_1_slice_en_s0; 
        
                  for (int i = 0; i < TCAM_SLICE_EN_FACT; i++)
                    begin
                      if (tcam_row_3_col_1_slice_en_s1[i])
                         tcam_row_3_col_1_hit_out_latch[ i*64 +: 64] <=  tcam_row_3_col_1_hit_out_int[ i*64 +: 64];
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
        
                     
                         assign tcam_row_3_col_1_data_out  = ~tcam_row_3_col_1_data_out_inv;
                         pcie_itp_ip783tcam64x32s0c1_3_1_wrap #(        
                                 )               
        
                                 ip783tcam64x32s0c1_wrap_tcam_row_3_col_1 (
                   //-------------------------------------------------------------
                   // Power Management Interfaces
                   //-------------------------------------------------------------   
                      `ifndef INTEL_NO_PWR_PINS
                      `ifdef INTC_ADD_VSS
                        .vss              (1'b0),
                      `endif
                        .vddp             (1'b1),
                      `endif
                         .ADR               (tcam_row_3_col_1_adr[7-1:1]), //Input adr_intess
                         .ME                (ce),  
        
                         .CLK               (tcam_row_3_col_1_clk), //Clock
                         .CMP               (tcam_row_3_col_1_chk_en), //Control Enable
                         .DIN               (~tcam_row_3_col_1_data_in), 
                         .DSEL              (~tcam_row_3_col_1_adr[0]), //dncen enables access of the TCAM Arrays adr_intessed
                         .FLS               (flush), //flush initiates a Flush operation that resets all Valid
                         .RVLD              (tcam_row_3_col_1_hit_in ), //Row validation bus. Each match_in input controls 1
                         .MASK              (tcam_row_3_col_1_mask_in), //Input msk
                         .QOUT              (tcam_row_3_col_1_data_out_inv), //Output vben
                         .QHR               (tcam_row_3_col_1_hit_out_int),
                         .QVLD              (), 
                         .RE                (tcam_row_3_col_1_rd_en), //Read Enable
                         .RST               (tcam_row_3_col_1_reset_n), //Asynchronous Active-High Reset
                         .VBE               (1'b1), //vben enables the Valid Bit addressed by adr[a-1:0] to
                         .VBI               (1'b0),//  Valid Bit Input
                         .WE                (tcam_row_3_col_1_wr_en), //Write Enable
                         .FAF               (tcam_row_3_col_1_fca),
                         .FAF_EN            (tcam_row_3_col_1_cre),
                         .DFTSHIFTEN        (tcam_row_3_col_1_dftshiften),
                         .DFTMASK           (tcam_row_3_col_1_dftmask),
                         .DFT_ARRAY_FREEZE  (tcam_row_3_col_1_dft_array_freeze),
                         .DFT_AFD_RESET_B   (tcam_row_3_col_1_dft_afd_reset_b),
                         .BISTE           (tcam_row_3_col_1_biste),
                         .TDIN (tcam_row_3_col_1_tdin),
                         .TADR (tcam_row_3_col_1_tadr),
                         .TVBE (tcam_row_3_col_1_tvbe),
                         .TVBI (tcam_row_3_col_1_tvbi),
                         .TMASK (tcam_row_3_col_1_tmask),
                         .TWE (tcam_row_3_col_1_twe),
                         .TRE (tcam_row_3_col_1_tre),
                         .TME (tcam_row_3_col_1_tme),
                         .BIST_ROTATE_SR (tcam_row_3_col_1_bist_rotate_sr),
                         .BIST_EN_SR_MASK_B (tcam_row_3_col_1_bist_en_sr_mask_b),
                         .BIST_ALL_MASK (tcam_row_3_col_1_bist_all_mask),
                         .BIST_EN_SR_DATA_B (tcam_row_3_col_1_bist_en_sr_data_b),
                         .BIST_CM_MODE (tcam_row_3_col_1_bist_cm_mode),
                         .BIST_CM_EN_IN (tcam_row_3_col_1_bist_cm_en_in),
                         .BIST_CM_MATCH_SEL0 (tcam_row_3_col_1_bist_cm_match_sel0),
                         .BIST_CM_MATCH_SEL1 (tcam_row_3_col_1_bist_cm_match_sel1),
                         .BIST_MATCHIN_IN (tcam_row_3_col_1_bist_matchin_in),
                         .BIST_FLS (tcam_row_3_col_1_bist_fls),
                         .MDST_tcam (fuse_tcam)
                     );
        
              end
              
            else
              begin : gen_tcam_row_3_col_1_bcam
              end
              
        
        
        endgenerate
        
        always_ff @(posedge clk) begin
                   tcam_rd_data_col[3][1]      <= tcam_row_3_col_1_data_out;
                   tcam_col_hit_out[3][1]       <= tcam_row_3_col_1_hit_out;
        end
        

        // this is new template - tcam_asic_template
        
        wire                                            tcam_row_4_col_0_clk         = clk;
        
        wire    [TCAM_SLICE_EN_FACT-1:0]                tcam_row_4_col_0_slice_en = TCAM_SLICE_EN_FACT'(slice_en[(4 * TCAM_SLICE_EN_FACT)+:TCAM_SLICE_EN_MIN]);
        
        wire                                            tcam_row_4_col_0_rd_en       = tcam_row_rd_en[4];
        wire                                            tcam_row_4_col_0_wr_en       = tcam_row_wr_en[4];
        wire                                            tcam_row_4_col_0_chk_en      = chk_en;
        wire                                            tcam_row_4_col_0_reset_n = reset_n;
        wire    [7-1:0]                       tcam_row_4_col_0_adr  = tcam_row_adr[4][7-1:0];
        wire    [32-1:0]                      tcam_row_4_col_0_data_in = tcam_row_wr_en[4] ? tcam_wr_data_col[0][32-1:0] : tcam_chk_key_col[0][32-1:0];
        wire    [32-1:0]                      tcam_row_4_col_0_data_in_pre = tcam_wr_data_col[0][32-1:0] ;
        wire    [32-1:0]                      tcam_row_4_col_0_key_in =  tcam_chk_key_col[0][32-1:0];
        wire    [32-1:0]                      tcam_row_4_col_0_mask_in = tcam_chk_mask_col[0][32-1:0];
        wire    [64-1:0]                       tcam_row_4_col_0_hit_in = tcam_raw_hit_in[4];
        wire    [64-1:0]                       tcam_row_4_col_0_tcam_match_in = tcam_row_match_in[4];
        wire    [32-1:0]                      tcam_row_4_col_0_data_out_inv;
        logic   [64-1:0]                     tcam_row_4_col_0_hit_out_int;
        logic   [64-1:0]                     tcam_row_4_col_0_hit_out_latch;
        logic   [64-1:0]                     tcam_row_4_col_0_hit_out;
        
        `ifdef HIF_PCIE_DFX_DISABLE
        wire                          tcam_row_4_col_0_biste = 'b0; 
        wire     [5-1:0]                  tcam_row_4_col_0_fca = 'b0;
        wire                            tcam_row_4_col_0_cre = 'b0;
        wire                            tcam_row_4_col_0_dftshiften = 'b0;
        wire                            tcam_row_4_col_0_dftmask = 'b0;
        wire                            tcam_row_4_col_0_dft_array_freeze = 'b0;
        wire                            tcam_row_4_col_0_dft_afd_reset_b = 'b0;
        wire      [32-1:0]    tcam_row_4_col_0_tdin = 'b0;
        wire      [7-1:0]     tcam_row_4_col_0_tadr = 'b0;
        wire                            tcam_row_4_col_0_tvbe = 'b0;
        wire                            tcam_row_4_col_0_tvbi = 'b0;
        wire      [32-1:0]    tcam_row_4_col_0_tmask = 'b0;
        wire                            tcam_row_4_col_0_twe = 'b0;
        wire                            tcam_row_4_col_0_tre = 'b0;
        wire                            tcam_row_4_col_0_tme = 'b0;
        wire                            tcam_row_4_col_0_bist_rotate_sr = 'b0;
        wire                            tcam_row_4_col_0_bist_en_sr_mask_b = 'b0;
        wire                            tcam_row_4_col_0_bist_all_mask = 'b0;
        wire                            tcam_row_4_col_0_bist_en_sr_data_b = 'b0;
        wire                            tcam_row_4_col_0_bist_cm_mode = 'b0;
        wire                            tcam_row_4_col_0_bist_cm_en_in = 'b0;
        wire                            tcam_row_4_col_0_bist_cm_match_sel0 = 'b0;
        wire                            tcam_row_4_col_0_bist_cm_match_sel1 = 'b0;
        wire                            tcam_row_4_col_0_bist_matchin_in = 'b0;
        wire                            tcam_row_4_col_0_bist_fls = 'b0;
        
        `else
        wire                            tcam_row_4_col_0_biste = 'b0;
        wire     [5-1:0]                  tcam_row_4_col_0_fca = 'b0;
        wire                            tcam_row_4_col_0_cre = 'b0;
        wire                            tcam_row_4_col_0_dftshiften = dftshiften;
        wire                            tcam_row_4_col_0_dftmask = dftmask;
        wire                            tcam_row_4_col_0_dft_array_freeze = dft_array_freeze;
        wire                            tcam_row_4_col_0_dft_afd_reset_b = dft_afd_reset_b;
        wire      [32-1:0]    tcam_row_4_col_0_tdin = 'b0;
        wire      [7-1:0]     tcam_row_4_col_0_tadr = 'b0;
        wire                            tcam_row_4_col_0_tvbe = 'b0;
        wire                            tcam_row_4_col_0_tvbi = 'b0;
        wire      [32-1:0]    tcam_row_4_col_0_tmask = 'b0;
        wire                            tcam_row_4_col_0_twe = 'b0;
        wire                            tcam_row_4_col_0_tre = 'b0;
        wire                            tcam_row_4_col_0_tme = 'b0;
        wire                            tcam_row_4_col_0_bist_rotate_sr = 'b0;
        wire                            tcam_row_4_col_0_bist_en_sr_mask_b = 'b0;
        wire                            tcam_row_4_col_0_bist_all_mask = 'b0;
        wire                            tcam_row_4_col_0_bist_en_sr_data_b = 'b0;
        wire                            tcam_row_4_col_0_bist_cm_mode = 'b0;
        wire                            tcam_row_4_col_0_bist_cm_en_in = 'b0;
        wire                            tcam_row_4_col_0_bist_cm_match_sel0 = 'b0;
        wire                            tcam_row_4_col_0_bist_cm_match_sel1 = 'b0;
        wire                            tcam_row_4_col_0_bist_matchin_in = 'b0;
        wire                            tcam_row_4_col_0_bist_fls = 'b0;
        `endif
        
        // Outputs
        logic                           tcam_row_4_col_0_wr_bira_fail;
        logic                           tcam_row_4_col_0_wr_so;
        logic                           tcam_row_4_col_0_curerrout;
        logic                           tcam_row_4_col_0_rscout;
        
        
        
        logic   [TCAM_SLICE_EN_FACT-1:0]                  tcam_row_4_col_0_slice_en_s0; 
        logic   [TCAM_SLICE_EN_FACT-1:0]                  tcam_row_4_col_0_slice_en_s1; 
        
        
        
             wire    [32-1:0]                     tcam_row_4_col_0_data_out ;
        
        
        
         generate
            if (BCAM_N7 == 0) 
              begin : gen_tcam_row_4_col_0_tcam
        
        
        // slice_en kept for TCAM only for backward compatability with Intel process
                always_comb 
                begin
                  for (int i = 0; i < TCAM_SLICE_EN_FACT; i++)
                      if (tcam_row_4_col_0_slice_en_s1[i])
                           tcam_row_4_col_0_hit_out[ i*64 +: 64]  = tcam_row_4_col_0_hit_out_int  [ i*64 +: 64]; 
                      else
                           tcam_row_4_col_0_hit_out[ i*64 +: 64]  = tcam_row_4_col_0_hit_out_latch[ i*64 +: 64]; 
                end
        
        
        
                always_ff  @(posedge tcam_row_4_col_0_clk)
                begin
                  tcam_row_4_col_0_slice_en_s0 <= tcam_row_4_col_0_slice_en; 
                  tcam_row_4_col_0_slice_en_s1 <= tcam_row_4_col_0_slice_en_s0; 
        
                  for (int i = 0; i < TCAM_SLICE_EN_FACT; i++)
                    begin
                      if (tcam_row_4_col_0_slice_en_s1[i])
                         tcam_row_4_col_0_hit_out_latch[ i*64 +: 64] <=  tcam_row_4_col_0_hit_out_int[ i*64 +: 64];
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
        
                     
                         assign tcam_row_4_col_0_data_out  = ~tcam_row_4_col_0_data_out_inv;
                         pcie_itp_ip783tcam64x32s0c1_4_0_wrap #(        
                                 )               
        
                                 ip783tcam64x32s0c1_wrap_tcam_row_4_col_0 (
                   //-------------------------------------------------------------
                   // Power Management Interfaces
                   //-------------------------------------------------------------   
                      `ifndef INTEL_NO_PWR_PINS
                      `ifdef INTC_ADD_VSS
                        .vss              (1'b0),
                      `endif
                        .vddp             (1'b1),
                      `endif
                         .ADR               (tcam_row_4_col_0_adr[7-1:1]), //Input adr_intess
                         .ME                (ce),  
        
                         .CLK               (tcam_row_4_col_0_clk), //Clock
                         .CMP               (tcam_row_4_col_0_chk_en), //Control Enable
                         .DIN               (~tcam_row_4_col_0_data_in), 
                         .DSEL              (~tcam_row_4_col_0_adr[0]), //dncen enables access of the TCAM Arrays adr_intessed
                         .FLS               (flush), //flush initiates a Flush operation that resets all Valid
                         .RVLD              (tcam_row_4_col_0_hit_in ), //Row validation bus. Each match_in input controls 1
                         .MASK              (tcam_row_4_col_0_mask_in), //Input msk
                         .QOUT              (tcam_row_4_col_0_data_out_inv), //Output vben
                         .QHR               (tcam_row_4_col_0_hit_out_int),
                         .QVLD              (), 
                         .RE                (tcam_row_4_col_0_rd_en), //Read Enable
                         .RST               (tcam_row_4_col_0_reset_n), //Asynchronous Active-High Reset
                         .VBE               (1'b1), //vben enables the Valid Bit addressed by adr[a-1:0] to
                         .VBI               (1'b0),//  Valid Bit Input
                         .WE                (tcam_row_4_col_0_wr_en), //Write Enable
                         .FAF               (tcam_row_4_col_0_fca),
                         .FAF_EN            (tcam_row_4_col_0_cre),
                         .DFTSHIFTEN        (tcam_row_4_col_0_dftshiften),
                         .DFTMASK           (tcam_row_4_col_0_dftmask),
                         .DFT_ARRAY_FREEZE  (tcam_row_4_col_0_dft_array_freeze),
                         .DFT_AFD_RESET_B   (tcam_row_4_col_0_dft_afd_reset_b),
                         .BISTE           (tcam_row_4_col_0_biste),
                         .TDIN (tcam_row_4_col_0_tdin),
                         .TADR (tcam_row_4_col_0_tadr),
                         .TVBE (tcam_row_4_col_0_tvbe),
                         .TVBI (tcam_row_4_col_0_tvbi),
                         .TMASK (tcam_row_4_col_0_tmask),
                         .TWE (tcam_row_4_col_0_twe),
                         .TRE (tcam_row_4_col_0_tre),
                         .TME (tcam_row_4_col_0_tme),
                         .BIST_ROTATE_SR (tcam_row_4_col_0_bist_rotate_sr),
                         .BIST_EN_SR_MASK_B (tcam_row_4_col_0_bist_en_sr_mask_b),
                         .BIST_ALL_MASK (tcam_row_4_col_0_bist_all_mask),
                         .BIST_EN_SR_DATA_B (tcam_row_4_col_0_bist_en_sr_data_b),
                         .BIST_CM_MODE (tcam_row_4_col_0_bist_cm_mode),
                         .BIST_CM_EN_IN (tcam_row_4_col_0_bist_cm_en_in),
                         .BIST_CM_MATCH_SEL0 (tcam_row_4_col_0_bist_cm_match_sel0),
                         .BIST_CM_MATCH_SEL1 (tcam_row_4_col_0_bist_cm_match_sel1),
                         .BIST_MATCHIN_IN (tcam_row_4_col_0_bist_matchin_in),
                         .BIST_FLS (tcam_row_4_col_0_bist_fls),
                         .MDST_tcam (fuse_tcam)
                     );
        
              end
              
            else
              begin : gen_tcam_row_4_col_0_bcam
              end
              
        
        
        endgenerate
        
        always_ff @(posedge clk) begin
                   tcam_rd_data_col[4][0]      <= tcam_row_4_col_0_data_out;
                   tcam_col_hit_out[4][0]       <= tcam_row_4_col_0_hit_out;
        end
        

        // this is new template - tcam_asic_template
        
        wire                                            tcam_row_4_col_1_clk         = clk;
        
        wire    [TCAM_SLICE_EN_FACT-1:0]                tcam_row_4_col_1_slice_en = TCAM_SLICE_EN_FACT'(slice_en[(4 * TCAM_SLICE_EN_FACT)+:TCAM_SLICE_EN_MIN]);
        
        wire                                            tcam_row_4_col_1_rd_en       = tcam_row_rd_en[4];
        wire                                            tcam_row_4_col_1_wr_en       = tcam_row_wr_en[4];
        wire                                            tcam_row_4_col_1_chk_en      = chk_en;
        wire                                            tcam_row_4_col_1_reset_n = reset_n;
        wire    [7-1:0]                       tcam_row_4_col_1_adr  = tcam_row_adr[4][7-1:0];
        wire    [32-1:0]                      tcam_row_4_col_1_data_in = tcam_row_wr_en[4] ? tcam_wr_data_col[1][32-1:0] : tcam_chk_key_col[1][32-1:0];
        wire    [32-1:0]                      tcam_row_4_col_1_data_in_pre = tcam_wr_data_col[1][32-1:0] ;
        wire    [32-1:0]                      tcam_row_4_col_1_key_in =  tcam_chk_key_col[1][32-1:0];
        wire    [32-1:0]                      tcam_row_4_col_1_mask_in = tcam_chk_mask_col[1][32-1:0];
        wire    [64-1:0]                       tcam_row_4_col_1_hit_in = tcam_raw_hit_in[4];
        wire    [64-1:0]                       tcam_row_4_col_1_tcam_match_in = tcam_row_match_in[4];
        wire    [32-1:0]                      tcam_row_4_col_1_data_out_inv;
        logic   [64-1:0]                     tcam_row_4_col_1_hit_out_int;
        logic   [64-1:0]                     tcam_row_4_col_1_hit_out_latch;
        logic   [64-1:0]                     tcam_row_4_col_1_hit_out;
        
        `ifdef HIF_PCIE_DFX_DISABLE
        wire                          tcam_row_4_col_1_biste = 'b0; 
        wire     [5-1:0]                  tcam_row_4_col_1_fca = 'b0;
        wire                            tcam_row_4_col_1_cre = 'b0;
        wire                            tcam_row_4_col_1_dftshiften = 'b0;
        wire                            tcam_row_4_col_1_dftmask = 'b0;
        wire                            tcam_row_4_col_1_dft_array_freeze = 'b0;
        wire                            tcam_row_4_col_1_dft_afd_reset_b = 'b0;
        wire      [32-1:0]    tcam_row_4_col_1_tdin = 'b0;
        wire      [7-1:0]     tcam_row_4_col_1_tadr = 'b0;
        wire                            tcam_row_4_col_1_tvbe = 'b0;
        wire                            tcam_row_4_col_1_tvbi = 'b0;
        wire      [32-1:0]    tcam_row_4_col_1_tmask = 'b0;
        wire                            tcam_row_4_col_1_twe = 'b0;
        wire                            tcam_row_4_col_1_tre = 'b0;
        wire                            tcam_row_4_col_1_tme = 'b0;
        wire                            tcam_row_4_col_1_bist_rotate_sr = 'b0;
        wire                            tcam_row_4_col_1_bist_en_sr_mask_b = 'b0;
        wire                            tcam_row_4_col_1_bist_all_mask = 'b0;
        wire                            tcam_row_4_col_1_bist_en_sr_data_b = 'b0;
        wire                            tcam_row_4_col_1_bist_cm_mode = 'b0;
        wire                            tcam_row_4_col_1_bist_cm_en_in = 'b0;
        wire                            tcam_row_4_col_1_bist_cm_match_sel0 = 'b0;
        wire                            tcam_row_4_col_1_bist_cm_match_sel1 = 'b0;
        wire                            tcam_row_4_col_1_bist_matchin_in = 'b0;
        wire                            tcam_row_4_col_1_bist_fls = 'b0;
        
        `else
        wire                            tcam_row_4_col_1_biste = 'b0;
        wire     [5-1:0]                  tcam_row_4_col_1_fca = 'b0;
        wire                            tcam_row_4_col_1_cre = 'b0;
        wire                            tcam_row_4_col_1_dftshiften = dftshiften;
        wire                            tcam_row_4_col_1_dftmask = dftmask;
        wire                            tcam_row_4_col_1_dft_array_freeze = dft_array_freeze;
        wire                            tcam_row_4_col_1_dft_afd_reset_b = dft_afd_reset_b;
        wire      [32-1:0]    tcam_row_4_col_1_tdin = 'b0;
        wire      [7-1:0]     tcam_row_4_col_1_tadr = 'b0;
        wire                            tcam_row_4_col_1_tvbe = 'b0;
        wire                            tcam_row_4_col_1_tvbi = 'b0;
        wire      [32-1:0]    tcam_row_4_col_1_tmask = 'b0;
        wire                            tcam_row_4_col_1_twe = 'b0;
        wire                            tcam_row_4_col_1_tre = 'b0;
        wire                            tcam_row_4_col_1_tme = 'b0;
        wire                            tcam_row_4_col_1_bist_rotate_sr = 'b0;
        wire                            tcam_row_4_col_1_bist_en_sr_mask_b = 'b0;
        wire                            tcam_row_4_col_1_bist_all_mask = 'b0;
        wire                            tcam_row_4_col_1_bist_en_sr_data_b = 'b0;
        wire                            tcam_row_4_col_1_bist_cm_mode = 'b0;
        wire                            tcam_row_4_col_1_bist_cm_en_in = 'b0;
        wire                            tcam_row_4_col_1_bist_cm_match_sel0 = 'b0;
        wire                            tcam_row_4_col_1_bist_cm_match_sel1 = 'b0;
        wire                            tcam_row_4_col_1_bist_matchin_in = 'b0;
        wire                            tcam_row_4_col_1_bist_fls = 'b0;
        `endif
        
        // Outputs
        logic                           tcam_row_4_col_1_wr_bira_fail;
        logic                           tcam_row_4_col_1_wr_so;
        logic                           tcam_row_4_col_1_curerrout;
        logic                           tcam_row_4_col_1_rscout;
        
        
        
        logic   [TCAM_SLICE_EN_FACT-1:0]                  tcam_row_4_col_1_slice_en_s0; 
        logic   [TCAM_SLICE_EN_FACT-1:0]                  tcam_row_4_col_1_slice_en_s1; 
        
        
        
             wire    [32-1:0]                     tcam_row_4_col_1_data_out ;
        
        
        
         generate
            if (BCAM_N7 == 0) 
              begin : gen_tcam_row_4_col_1_tcam
        
        
        // slice_en kept for TCAM only for backward compatability with Intel process
                always_comb 
                begin
                  for (int i = 0; i < TCAM_SLICE_EN_FACT; i++)
                      if (tcam_row_4_col_1_slice_en_s1[i])
                           tcam_row_4_col_1_hit_out[ i*64 +: 64]  = tcam_row_4_col_1_hit_out_int  [ i*64 +: 64]; 
                      else
                           tcam_row_4_col_1_hit_out[ i*64 +: 64]  = tcam_row_4_col_1_hit_out_latch[ i*64 +: 64]; 
                end
        
        
        
                always_ff  @(posedge tcam_row_4_col_1_clk)
                begin
                  tcam_row_4_col_1_slice_en_s0 <= tcam_row_4_col_1_slice_en; 
                  tcam_row_4_col_1_slice_en_s1 <= tcam_row_4_col_1_slice_en_s0; 
        
                  for (int i = 0; i < TCAM_SLICE_EN_FACT; i++)
                    begin
                      if (tcam_row_4_col_1_slice_en_s1[i])
                         tcam_row_4_col_1_hit_out_latch[ i*64 +: 64] <=  tcam_row_4_col_1_hit_out_int[ i*64 +: 64];
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
        
                     
                         assign tcam_row_4_col_1_data_out  = ~tcam_row_4_col_1_data_out_inv;
                         pcie_itp_ip783tcam64x32s0c1_4_1_wrap #(        
                                 )               
        
                                 ip783tcam64x32s0c1_wrap_tcam_row_4_col_1 (
                   //-------------------------------------------------------------
                   // Power Management Interfaces
                   //-------------------------------------------------------------   
                      `ifndef INTEL_NO_PWR_PINS
                      `ifdef INTC_ADD_VSS
                        .vss              (1'b0),
                      `endif
                        .vddp             (1'b1),
                      `endif
                         .ADR               (tcam_row_4_col_1_adr[7-1:1]), //Input adr_intess
                         .ME                (ce),  
        
                         .CLK               (tcam_row_4_col_1_clk), //Clock
                         .CMP               (tcam_row_4_col_1_chk_en), //Control Enable
                         .DIN               (~tcam_row_4_col_1_data_in), 
                         .DSEL              (~tcam_row_4_col_1_adr[0]), //dncen enables access of the TCAM Arrays adr_intessed
                         .FLS               (flush), //flush initiates a Flush operation that resets all Valid
                         .RVLD              (tcam_row_4_col_1_hit_in ), //Row validation bus. Each match_in input controls 1
                         .MASK              (tcam_row_4_col_1_mask_in), //Input msk
                         .QOUT              (tcam_row_4_col_1_data_out_inv), //Output vben
                         .QHR               (tcam_row_4_col_1_hit_out_int),
                         .QVLD              (), 
                         .RE                (tcam_row_4_col_1_rd_en), //Read Enable
                         .RST               (tcam_row_4_col_1_reset_n), //Asynchronous Active-High Reset
                         .VBE               (1'b1), //vben enables the Valid Bit addressed by adr[a-1:0] to
                         .VBI               (1'b0),//  Valid Bit Input
                         .WE                (tcam_row_4_col_1_wr_en), //Write Enable
                         .FAF               (tcam_row_4_col_1_fca),
                         .FAF_EN            (tcam_row_4_col_1_cre),
                         .DFTSHIFTEN        (tcam_row_4_col_1_dftshiften),
                         .DFTMASK           (tcam_row_4_col_1_dftmask),
                         .DFT_ARRAY_FREEZE  (tcam_row_4_col_1_dft_array_freeze),
                         .DFT_AFD_RESET_B   (tcam_row_4_col_1_dft_afd_reset_b),
                         .BISTE           (tcam_row_4_col_1_biste),
                         .TDIN (tcam_row_4_col_1_tdin),
                         .TADR (tcam_row_4_col_1_tadr),
                         .TVBE (tcam_row_4_col_1_tvbe),
                         .TVBI (tcam_row_4_col_1_tvbi),
                         .TMASK (tcam_row_4_col_1_tmask),
                         .TWE (tcam_row_4_col_1_twe),
                         .TRE (tcam_row_4_col_1_tre),
                         .TME (tcam_row_4_col_1_tme),
                         .BIST_ROTATE_SR (tcam_row_4_col_1_bist_rotate_sr),
                         .BIST_EN_SR_MASK_B (tcam_row_4_col_1_bist_en_sr_mask_b),
                         .BIST_ALL_MASK (tcam_row_4_col_1_bist_all_mask),
                         .BIST_EN_SR_DATA_B (tcam_row_4_col_1_bist_en_sr_data_b),
                         .BIST_CM_MODE (tcam_row_4_col_1_bist_cm_mode),
                         .BIST_CM_EN_IN (tcam_row_4_col_1_bist_cm_en_in),
                         .BIST_CM_MATCH_SEL0 (tcam_row_4_col_1_bist_cm_match_sel0),
                         .BIST_CM_MATCH_SEL1 (tcam_row_4_col_1_bist_cm_match_sel1),
                         .BIST_MATCHIN_IN (tcam_row_4_col_1_bist_matchin_in),
                         .BIST_FLS (tcam_row_4_col_1_bist_fls),
                         .MDST_tcam (fuse_tcam)
                     );
        
              end
              
            else
              begin : gen_tcam_row_4_col_1_bcam
              end
              
        
        
        endgenerate
        
        always_ff @(posedge clk) begin
                   tcam_rd_data_col[4][1]      <= tcam_row_4_col_1_data_out;
                   tcam_col_hit_out[4][1]       <= tcam_row_4_col_1_hit_out;
        end
        

        // this is new template - tcam_asic_template
        
        wire                                            tcam_row_5_col_0_clk         = clk;
        
        wire    [TCAM_SLICE_EN_FACT-1:0]                tcam_row_5_col_0_slice_en = TCAM_SLICE_EN_FACT'(slice_en[(5 * TCAM_SLICE_EN_FACT)+:TCAM_SLICE_EN_MIN]);
        
        wire                                            tcam_row_5_col_0_rd_en       = tcam_row_rd_en[5];
        wire                                            tcam_row_5_col_0_wr_en       = tcam_row_wr_en[5];
        wire                                            tcam_row_5_col_0_chk_en      = chk_en;
        wire                                            tcam_row_5_col_0_reset_n = reset_n;
        wire    [7-1:0]                       tcam_row_5_col_0_adr  = tcam_row_adr[5][7-1:0];
        wire    [32-1:0]                      tcam_row_5_col_0_data_in = tcam_row_wr_en[5] ? tcam_wr_data_col[0][32-1:0] : tcam_chk_key_col[0][32-1:0];
        wire    [32-1:0]                      tcam_row_5_col_0_data_in_pre = tcam_wr_data_col[0][32-1:0] ;
        wire    [32-1:0]                      tcam_row_5_col_0_key_in =  tcam_chk_key_col[0][32-1:0];
        wire    [32-1:0]                      tcam_row_5_col_0_mask_in = tcam_chk_mask_col[0][32-1:0];
        wire    [64-1:0]                       tcam_row_5_col_0_hit_in = tcam_raw_hit_in[5];
        wire    [64-1:0]                       tcam_row_5_col_0_tcam_match_in = tcam_row_match_in[5];
        wire    [32-1:0]                      tcam_row_5_col_0_data_out_inv;
        logic   [64-1:0]                     tcam_row_5_col_0_hit_out_int;
        logic   [64-1:0]                     tcam_row_5_col_0_hit_out_latch;
        logic   [64-1:0]                     tcam_row_5_col_0_hit_out;
        
        `ifdef HIF_PCIE_DFX_DISABLE
        wire                          tcam_row_5_col_0_biste = 'b0; 
        wire     [5-1:0]                  tcam_row_5_col_0_fca = 'b0;
        wire                            tcam_row_5_col_0_cre = 'b0;
        wire                            tcam_row_5_col_0_dftshiften = 'b0;
        wire                            tcam_row_5_col_0_dftmask = 'b0;
        wire                            tcam_row_5_col_0_dft_array_freeze = 'b0;
        wire                            tcam_row_5_col_0_dft_afd_reset_b = 'b0;
        wire      [32-1:0]    tcam_row_5_col_0_tdin = 'b0;
        wire      [7-1:0]     tcam_row_5_col_0_tadr = 'b0;
        wire                            tcam_row_5_col_0_tvbe = 'b0;
        wire                            tcam_row_5_col_0_tvbi = 'b0;
        wire      [32-1:0]    tcam_row_5_col_0_tmask = 'b0;
        wire                            tcam_row_5_col_0_twe = 'b0;
        wire                            tcam_row_5_col_0_tre = 'b0;
        wire                            tcam_row_5_col_0_tme = 'b0;
        wire                            tcam_row_5_col_0_bist_rotate_sr = 'b0;
        wire                            tcam_row_5_col_0_bist_en_sr_mask_b = 'b0;
        wire                            tcam_row_5_col_0_bist_all_mask = 'b0;
        wire                            tcam_row_5_col_0_bist_en_sr_data_b = 'b0;
        wire                            tcam_row_5_col_0_bist_cm_mode = 'b0;
        wire                            tcam_row_5_col_0_bist_cm_en_in = 'b0;
        wire                            tcam_row_5_col_0_bist_cm_match_sel0 = 'b0;
        wire                            tcam_row_5_col_0_bist_cm_match_sel1 = 'b0;
        wire                            tcam_row_5_col_0_bist_matchin_in = 'b0;
        wire                            tcam_row_5_col_0_bist_fls = 'b0;
        
        `else
        wire                            tcam_row_5_col_0_biste = 'b0;
        wire     [5-1:0]                  tcam_row_5_col_0_fca = 'b0;
        wire                            tcam_row_5_col_0_cre = 'b0;
        wire                            tcam_row_5_col_0_dftshiften = dftshiften;
        wire                            tcam_row_5_col_0_dftmask = dftmask;
        wire                            tcam_row_5_col_0_dft_array_freeze = dft_array_freeze;
        wire                            tcam_row_5_col_0_dft_afd_reset_b = dft_afd_reset_b;
        wire      [32-1:0]    tcam_row_5_col_0_tdin = 'b0;
        wire      [7-1:0]     tcam_row_5_col_0_tadr = 'b0;
        wire                            tcam_row_5_col_0_tvbe = 'b0;
        wire                            tcam_row_5_col_0_tvbi = 'b0;
        wire      [32-1:0]    tcam_row_5_col_0_tmask = 'b0;
        wire                            tcam_row_5_col_0_twe = 'b0;
        wire                            tcam_row_5_col_0_tre = 'b0;
        wire                            tcam_row_5_col_0_tme = 'b0;
        wire                            tcam_row_5_col_0_bist_rotate_sr = 'b0;
        wire                            tcam_row_5_col_0_bist_en_sr_mask_b = 'b0;
        wire                            tcam_row_5_col_0_bist_all_mask = 'b0;
        wire                            tcam_row_5_col_0_bist_en_sr_data_b = 'b0;
        wire                            tcam_row_5_col_0_bist_cm_mode = 'b0;
        wire                            tcam_row_5_col_0_bist_cm_en_in = 'b0;
        wire                            tcam_row_5_col_0_bist_cm_match_sel0 = 'b0;
        wire                            tcam_row_5_col_0_bist_cm_match_sel1 = 'b0;
        wire                            tcam_row_5_col_0_bist_matchin_in = 'b0;
        wire                            tcam_row_5_col_0_bist_fls = 'b0;
        `endif
        
        // Outputs
        logic                           tcam_row_5_col_0_wr_bira_fail;
        logic                           tcam_row_5_col_0_wr_so;
        logic                           tcam_row_5_col_0_curerrout;
        logic                           tcam_row_5_col_0_rscout;
        
        
        
        logic   [TCAM_SLICE_EN_FACT-1:0]                  tcam_row_5_col_0_slice_en_s0; 
        logic   [TCAM_SLICE_EN_FACT-1:0]                  tcam_row_5_col_0_slice_en_s1; 
        
        
        
             wire    [32-1:0]                     tcam_row_5_col_0_data_out ;
        
        
        
         generate
            if (BCAM_N7 == 0) 
              begin : gen_tcam_row_5_col_0_tcam
        
        
        // slice_en kept for TCAM only for backward compatability with Intel process
                always_comb 
                begin
                  for (int i = 0; i < TCAM_SLICE_EN_FACT; i++)
                      if (tcam_row_5_col_0_slice_en_s1[i])
                           tcam_row_5_col_0_hit_out[ i*64 +: 64]  = tcam_row_5_col_0_hit_out_int  [ i*64 +: 64]; 
                      else
                           tcam_row_5_col_0_hit_out[ i*64 +: 64]  = tcam_row_5_col_0_hit_out_latch[ i*64 +: 64]; 
                end
        
        
        
                always_ff  @(posedge tcam_row_5_col_0_clk)
                begin
                  tcam_row_5_col_0_slice_en_s0 <= tcam_row_5_col_0_slice_en; 
                  tcam_row_5_col_0_slice_en_s1 <= tcam_row_5_col_0_slice_en_s0; 
        
                  for (int i = 0; i < TCAM_SLICE_EN_FACT; i++)
                    begin
                      if (tcam_row_5_col_0_slice_en_s1[i])
                         tcam_row_5_col_0_hit_out_latch[ i*64 +: 64] <=  tcam_row_5_col_0_hit_out_int[ i*64 +: 64];
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
        
                     
                         assign tcam_row_5_col_0_data_out  = ~tcam_row_5_col_0_data_out_inv;
                         pcie_itp_ip783tcam64x32s0c1_5_0_wrap #(        
                                 )               
        
                                 ip783tcam64x32s0c1_wrap_tcam_row_5_col_0 (
                   //-------------------------------------------------------------
                   // Power Management Interfaces
                   //-------------------------------------------------------------   
                      `ifndef INTEL_NO_PWR_PINS
                      `ifdef INTC_ADD_VSS
                        .vss              (1'b0),
                      `endif
                        .vddp             (1'b1),
                      `endif
                         .ADR               (tcam_row_5_col_0_adr[7-1:1]), //Input adr_intess
                         .ME                (ce),  
        
                         .CLK               (tcam_row_5_col_0_clk), //Clock
                         .CMP               (tcam_row_5_col_0_chk_en), //Control Enable
                         .DIN               (~tcam_row_5_col_0_data_in), 
                         .DSEL              (~tcam_row_5_col_0_adr[0]), //dncen enables access of the TCAM Arrays adr_intessed
                         .FLS               (flush), //flush initiates a Flush operation that resets all Valid
                         .RVLD              (tcam_row_5_col_0_hit_in ), //Row validation bus. Each match_in input controls 1
                         .MASK              (tcam_row_5_col_0_mask_in), //Input msk
                         .QOUT              (tcam_row_5_col_0_data_out_inv), //Output vben
                         .QHR               (tcam_row_5_col_0_hit_out_int),
                         .QVLD              (), 
                         .RE                (tcam_row_5_col_0_rd_en), //Read Enable
                         .RST               (tcam_row_5_col_0_reset_n), //Asynchronous Active-High Reset
                         .VBE               (1'b1), //vben enables the Valid Bit addressed by adr[a-1:0] to
                         .VBI               (1'b0),//  Valid Bit Input
                         .WE                (tcam_row_5_col_0_wr_en), //Write Enable
                         .FAF               (tcam_row_5_col_0_fca),
                         .FAF_EN            (tcam_row_5_col_0_cre),
                         .DFTSHIFTEN        (tcam_row_5_col_0_dftshiften),
                         .DFTMASK           (tcam_row_5_col_0_dftmask),
                         .DFT_ARRAY_FREEZE  (tcam_row_5_col_0_dft_array_freeze),
                         .DFT_AFD_RESET_B   (tcam_row_5_col_0_dft_afd_reset_b),
                         .BISTE           (tcam_row_5_col_0_biste),
                         .TDIN (tcam_row_5_col_0_tdin),
                         .TADR (tcam_row_5_col_0_tadr),
                         .TVBE (tcam_row_5_col_0_tvbe),
                         .TVBI (tcam_row_5_col_0_tvbi),
                         .TMASK (tcam_row_5_col_0_tmask),
                         .TWE (tcam_row_5_col_0_twe),
                         .TRE (tcam_row_5_col_0_tre),
                         .TME (tcam_row_5_col_0_tme),
                         .BIST_ROTATE_SR (tcam_row_5_col_0_bist_rotate_sr),
                         .BIST_EN_SR_MASK_B (tcam_row_5_col_0_bist_en_sr_mask_b),
                         .BIST_ALL_MASK (tcam_row_5_col_0_bist_all_mask),
                         .BIST_EN_SR_DATA_B (tcam_row_5_col_0_bist_en_sr_data_b),
                         .BIST_CM_MODE (tcam_row_5_col_0_bist_cm_mode),
                         .BIST_CM_EN_IN (tcam_row_5_col_0_bist_cm_en_in),
                         .BIST_CM_MATCH_SEL0 (tcam_row_5_col_0_bist_cm_match_sel0),
                         .BIST_CM_MATCH_SEL1 (tcam_row_5_col_0_bist_cm_match_sel1),
                         .BIST_MATCHIN_IN (tcam_row_5_col_0_bist_matchin_in),
                         .BIST_FLS (tcam_row_5_col_0_bist_fls),
                         .MDST_tcam (fuse_tcam)
                     );
        
              end
              
            else
              begin : gen_tcam_row_5_col_0_bcam
              end
              
        
        
        endgenerate
        
        always_ff @(posedge clk) begin
                   tcam_rd_data_col[5][0]      <= tcam_row_5_col_0_data_out;
                   tcam_col_hit_out[5][0]       <= tcam_row_5_col_0_hit_out;
        end
        

        // this is new template - tcam_asic_template
        
        wire                                            tcam_row_5_col_1_clk         = clk;
        
        wire    [TCAM_SLICE_EN_FACT-1:0]                tcam_row_5_col_1_slice_en = TCAM_SLICE_EN_FACT'(slice_en[(5 * TCAM_SLICE_EN_FACT)+:TCAM_SLICE_EN_MIN]);
        
        wire                                            tcam_row_5_col_1_rd_en       = tcam_row_rd_en[5];
        wire                                            tcam_row_5_col_1_wr_en       = tcam_row_wr_en[5];
        wire                                            tcam_row_5_col_1_chk_en      = chk_en;
        wire                                            tcam_row_5_col_1_reset_n = reset_n;
        wire    [7-1:0]                       tcam_row_5_col_1_adr  = tcam_row_adr[5][7-1:0];
        wire    [32-1:0]                      tcam_row_5_col_1_data_in = tcam_row_wr_en[5] ? tcam_wr_data_col[1][32-1:0] : tcam_chk_key_col[1][32-1:0];
        wire    [32-1:0]                      tcam_row_5_col_1_data_in_pre = tcam_wr_data_col[1][32-1:0] ;
        wire    [32-1:0]                      tcam_row_5_col_1_key_in =  tcam_chk_key_col[1][32-1:0];
        wire    [32-1:0]                      tcam_row_5_col_1_mask_in = tcam_chk_mask_col[1][32-1:0];
        wire    [64-1:0]                       tcam_row_5_col_1_hit_in = tcam_raw_hit_in[5];
        wire    [64-1:0]                       tcam_row_5_col_1_tcam_match_in = tcam_row_match_in[5];
        wire    [32-1:0]                      tcam_row_5_col_1_data_out_inv;
        logic   [64-1:0]                     tcam_row_5_col_1_hit_out_int;
        logic   [64-1:0]                     tcam_row_5_col_1_hit_out_latch;
        logic   [64-1:0]                     tcam_row_5_col_1_hit_out;
        
        `ifdef HIF_PCIE_DFX_DISABLE
        wire                          tcam_row_5_col_1_biste = 'b0; 
        wire     [5-1:0]                  tcam_row_5_col_1_fca = 'b0;
        wire                            tcam_row_5_col_1_cre = 'b0;
        wire                            tcam_row_5_col_1_dftshiften = 'b0;
        wire                            tcam_row_5_col_1_dftmask = 'b0;
        wire                            tcam_row_5_col_1_dft_array_freeze = 'b0;
        wire                            tcam_row_5_col_1_dft_afd_reset_b = 'b0;
        wire      [32-1:0]    tcam_row_5_col_1_tdin = 'b0;
        wire      [7-1:0]     tcam_row_5_col_1_tadr = 'b0;
        wire                            tcam_row_5_col_1_tvbe = 'b0;
        wire                            tcam_row_5_col_1_tvbi = 'b0;
        wire      [32-1:0]    tcam_row_5_col_1_tmask = 'b0;
        wire                            tcam_row_5_col_1_twe = 'b0;
        wire                            tcam_row_5_col_1_tre = 'b0;
        wire                            tcam_row_5_col_1_tme = 'b0;
        wire                            tcam_row_5_col_1_bist_rotate_sr = 'b0;
        wire                            tcam_row_5_col_1_bist_en_sr_mask_b = 'b0;
        wire                            tcam_row_5_col_1_bist_all_mask = 'b0;
        wire                            tcam_row_5_col_1_bist_en_sr_data_b = 'b0;
        wire                            tcam_row_5_col_1_bist_cm_mode = 'b0;
        wire                            tcam_row_5_col_1_bist_cm_en_in = 'b0;
        wire                            tcam_row_5_col_1_bist_cm_match_sel0 = 'b0;
        wire                            tcam_row_5_col_1_bist_cm_match_sel1 = 'b0;
        wire                            tcam_row_5_col_1_bist_matchin_in = 'b0;
        wire                            tcam_row_5_col_1_bist_fls = 'b0;
        
        `else
        wire                            tcam_row_5_col_1_biste = 'b0;
        wire     [5-1:0]                  tcam_row_5_col_1_fca = 'b0;
        wire                            tcam_row_5_col_1_cre = 'b0;
        wire                            tcam_row_5_col_1_dftshiften = dftshiften;
        wire                            tcam_row_5_col_1_dftmask = dftmask;
        wire                            tcam_row_5_col_1_dft_array_freeze = dft_array_freeze;
        wire                            tcam_row_5_col_1_dft_afd_reset_b = dft_afd_reset_b;
        wire      [32-1:0]    tcam_row_5_col_1_tdin = 'b0;
        wire      [7-1:0]     tcam_row_5_col_1_tadr = 'b0;
        wire                            tcam_row_5_col_1_tvbe = 'b0;
        wire                            tcam_row_5_col_1_tvbi = 'b0;
        wire      [32-1:0]    tcam_row_5_col_1_tmask = 'b0;
        wire                            tcam_row_5_col_1_twe = 'b0;
        wire                            tcam_row_5_col_1_tre = 'b0;
        wire                            tcam_row_5_col_1_tme = 'b0;
        wire                            tcam_row_5_col_1_bist_rotate_sr = 'b0;
        wire                            tcam_row_5_col_1_bist_en_sr_mask_b = 'b0;
        wire                            tcam_row_5_col_1_bist_all_mask = 'b0;
        wire                            tcam_row_5_col_1_bist_en_sr_data_b = 'b0;
        wire                            tcam_row_5_col_1_bist_cm_mode = 'b0;
        wire                            tcam_row_5_col_1_bist_cm_en_in = 'b0;
        wire                            tcam_row_5_col_1_bist_cm_match_sel0 = 'b0;
        wire                            tcam_row_5_col_1_bist_cm_match_sel1 = 'b0;
        wire                            tcam_row_5_col_1_bist_matchin_in = 'b0;
        wire                            tcam_row_5_col_1_bist_fls = 'b0;
        `endif
        
        // Outputs
        logic                           tcam_row_5_col_1_wr_bira_fail;
        logic                           tcam_row_5_col_1_wr_so;
        logic                           tcam_row_5_col_1_curerrout;
        logic                           tcam_row_5_col_1_rscout;
        
        
        
        logic   [TCAM_SLICE_EN_FACT-1:0]                  tcam_row_5_col_1_slice_en_s0; 
        logic   [TCAM_SLICE_EN_FACT-1:0]                  tcam_row_5_col_1_slice_en_s1; 
        
        
        
             wire    [32-1:0]                     tcam_row_5_col_1_data_out ;
        
        
        
         generate
            if (BCAM_N7 == 0) 
              begin : gen_tcam_row_5_col_1_tcam
        
        
        // slice_en kept for TCAM only for backward compatability with Intel process
                always_comb 
                begin
                  for (int i = 0; i < TCAM_SLICE_EN_FACT; i++)
                      if (tcam_row_5_col_1_slice_en_s1[i])
                           tcam_row_5_col_1_hit_out[ i*64 +: 64]  = tcam_row_5_col_1_hit_out_int  [ i*64 +: 64]; 
                      else
                           tcam_row_5_col_1_hit_out[ i*64 +: 64]  = tcam_row_5_col_1_hit_out_latch[ i*64 +: 64]; 
                end
        
        
        
                always_ff  @(posedge tcam_row_5_col_1_clk)
                begin
                  tcam_row_5_col_1_slice_en_s0 <= tcam_row_5_col_1_slice_en; 
                  tcam_row_5_col_1_slice_en_s1 <= tcam_row_5_col_1_slice_en_s0; 
        
                  for (int i = 0; i < TCAM_SLICE_EN_FACT; i++)
                    begin
                      if (tcam_row_5_col_1_slice_en_s1[i])
                         tcam_row_5_col_1_hit_out_latch[ i*64 +: 64] <=  tcam_row_5_col_1_hit_out_int[ i*64 +: 64];
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
        
                     
                         assign tcam_row_5_col_1_data_out  = ~tcam_row_5_col_1_data_out_inv;
                         pcie_itp_ip783tcam64x32s0c1_5_1_wrap #(        
                                 )               
        
                                 ip783tcam64x32s0c1_wrap_tcam_row_5_col_1 (
                   //-------------------------------------------------------------
                   // Power Management Interfaces
                   //-------------------------------------------------------------   
                      `ifndef INTEL_NO_PWR_PINS
                      `ifdef INTC_ADD_VSS
                        .vss              (1'b0),
                      `endif
                        .vddp             (1'b1),
                      `endif
                         .ADR               (tcam_row_5_col_1_adr[7-1:1]), //Input adr_intess
                         .ME                (ce),  
        
                         .CLK               (tcam_row_5_col_1_clk), //Clock
                         .CMP               (tcam_row_5_col_1_chk_en), //Control Enable
                         .DIN               (~tcam_row_5_col_1_data_in), 
                         .DSEL              (~tcam_row_5_col_1_adr[0]), //dncen enables access of the TCAM Arrays adr_intessed
                         .FLS               (flush), //flush initiates a Flush operation that resets all Valid
                         .RVLD              (tcam_row_5_col_1_hit_in ), //Row validation bus. Each match_in input controls 1
                         .MASK              (tcam_row_5_col_1_mask_in), //Input msk
                         .QOUT              (tcam_row_5_col_1_data_out_inv), //Output vben
                         .QHR               (tcam_row_5_col_1_hit_out_int),
                         .QVLD              (), 
                         .RE                (tcam_row_5_col_1_rd_en), //Read Enable
                         .RST               (tcam_row_5_col_1_reset_n), //Asynchronous Active-High Reset
                         .VBE               (1'b1), //vben enables the Valid Bit addressed by adr[a-1:0] to
                         .VBI               (1'b0),//  Valid Bit Input
                         .WE                (tcam_row_5_col_1_wr_en), //Write Enable
                         .FAF               (tcam_row_5_col_1_fca),
                         .FAF_EN            (tcam_row_5_col_1_cre),
                         .DFTSHIFTEN        (tcam_row_5_col_1_dftshiften),
                         .DFTMASK           (tcam_row_5_col_1_dftmask),
                         .DFT_ARRAY_FREEZE  (tcam_row_5_col_1_dft_array_freeze),
                         .DFT_AFD_RESET_B   (tcam_row_5_col_1_dft_afd_reset_b),
                         .BISTE           (tcam_row_5_col_1_biste),
                         .TDIN (tcam_row_5_col_1_tdin),
                         .TADR (tcam_row_5_col_1_tadr),
                         .TVBE (tcam_row_5_col_1_tvbe),
                         .TVBI (tcam_row_5_col_1_tvbi),
                         .TMASK (tcam_row_5_col_1_tmask),
                         .TWE (tcam_row_5_col_1_twe),
                         .TRE (tcam_row_5_col_1_tre),
                         .TME (tcam_row_5_col_1_tme),
                         .BIST_ROTATE_SR (tcam_row_5_col_1_bist_rotate_sr),
                         .BIST_EN_SR_MASK_B (tcam_row_5_col_1_bist_en_sr_mask_b),
                         .BIST_ALL_MASK (tcam_row_5_col_1_bist_all_mask),
                         .BIST_EN_SR_DATA_B (tcam_row_5_col_1_bist_en_sr_data_b),
                         .BIST_CM_MODE (tcam_row_5_col_1_bist_cm_mode),
                         .BIST_CM_EN_IN (tcam_row_5_col_1_bist_cm_en_in),
                         .BIST_CM_MATCH_SEL0 (tcam_row_5_col_1_bist_cm_match_sel0),
                         .BIST_CM_MATCH_SEL1 (tcam_row_5_col_1_bist_cm_match_sel1),
                         .BIST_MATCHIN_IN (tcam_row_5_col_1_bist_matchin_in),
                         .BIST_FLS (tcam_row_5_col_1_bist_fls),
                         .MDST_tcam (fuse_tcam)
                     );
        
              end
              
            else
              begin : gen_tcam_row_5_col_1_bcam
              end
              
        
        
        endgenerate
        
        always_ff @(posedge clk) begin
                   tcam_rd_data_col[5][1]      <= tcam_row_5_col_1_data_out;
                   tcam_col_hit_out[5][1]       <= tcam_row_5_col_1_hit_out;
        end
        

        // this is new template - tcam_asic_template
        
        wire                                            tcam_row_6_col_0_clk         = clk;
        
        wire    [TCAM_SLICE_EN_FACT-1:0]                tcam_row_6_col_0_slice_en = TCAM_SLICE_EN_FACT'(slice_en[(6 * TCAM_SLICE_EN_FACT)+:TCAM_SLICE_EN_MIN]);
        
        wire                                            tcam_row_6_col_0_rd_en       = tcam_row_rd_en[6];
        wire                                            tcam_row_6_col_0_wr_en       = tcam_row_wr_en[6];
        wire                                            tcam_row_6_col_0_chk_en      = chk_en;
        wire                                            tcam_row_6_col_0_reset_n = reset_n;
        wire    [7-1:0]                       tcam_row_6_col_0_adr  = tcam_row_adr[6][7-1:0];
        wire    [32-1:0]                      tcam_row_6_col_0_data_in = tcam_row_wr_en[6] ? tcam_wr_data_col[0][32-1:0] : tcam_chk_key_col[0][32-1:0];
        wire    [32-1:0]                      tcam_row_6_col_0_data_in_pre = tcam_wr_data_col[0][32-1:0] ;
        wire    [32-1:0]                      tcam_row_6_col_0_key_in =  tcam_chk_key_col[0][32-1:0];
        wire    [32-1:0]                      tcam_row_6_col_0_mask_in = tcam_chk_mask_col[0][32-1:0];
        wire    [64-1:0]                       tcam_row_6_col_0_hit_in = tcam_raw_hit_in[6];
        wire    [64-1:0]                       tcam_row_6_col_0_tcam_match_in = tcam_row_match_in[6];
        wire    [32-1:0]                      tcam_row_6_col_0_data_out_inv;
        logic   [64-1:0]                     tcam_row_6_col_0_hit_out_int;
        logic   [64-1:0]                     tcam_row_6_col_0_hit_out_latch;
        logic   [64-1:0]                     tcam_row_6_col_0_hit_out;
        
        `ifdef HIF_PCIE_DFX_DISABLE
        wire                          tcam_row_6_col_0_biste = 'b0; 
        wire     [5-1:0]                  tcam_row_6_col_0_fca = 'b0;
        wire                            tcam_row_6_col_0_cre = 'b0;
        wire                            tcam_row_6_col_0_dftshiften = 'b0;
        wire                            tcam_row_6_col_0_dftmask = 'b0;
        wire                            tcam_row_6_col_0_dft_array_freeze = 'b0;
        wire                            tcam_row_6_col_0_dft_afd_reset_b = 'b0;
        wire      [32-1:0]    tcam_row_6_col_0_tdin = 'b0;
        wire      [7-1:0]     tcam_row_6_col_0_tadr = 'b0;
        wire                            tcam_row_6_col_0_tvbe = 'b0;
        wire                            tcam_row_6_col_0_tvbi = 'b0;
        wire      [32-1:0]    tcam_row_6_col_0_tmask = 'b0;
        wire                            tcam_row_6_col_0_twe = 'b0;
        wire                            tcam_row_6_col_0_tre = 'b0;
        wire                            tcam_row_6_col_0_tme = 'b0;
        wire                            tcam_row_6_col_0_bist_rotate_sr = 'b0;
        wire                            tcam_row_6_col_0_bist_en_sr_mask_b = 'b0;
        wire                            tcam_row_6_col_0_bist_all_mask = 'b0;
        wire                            tcam_row_6_col_0_bist_en_sr_data_b = 'b0;
        wire                            tcam_row_6_col_0_bist_cm_mode = 'b0;
        wire                            tcam_row_6_col_0_bist_cm_en_in = 'b0;
        wire                            tcam_row_6_col_0_bist_cm_match_sel0 = 'b0;
        wire                            tcam_row_6_col_0_bist_cm_match_sel1 = 'b0;
        wire                            tcam_row_6_col_0_bist_matchin_in = 'b0;
        wire                            tcam_row_6_col_0_bist_fls = 'b0;
        
        `else
        wire                            tcam_row_6_col_0_biste = 'b0;
        wire     [5-1:0]                  tcam_row_6_col_0_fca = 'b0;
        wire                            tcam_row_6_col_0_cre = 'b0;
        wire                            tcam_row_6_col_0_dftshiften = dftshiften;
        wire                            tcam_row_6_col_0_dftmask = dftmask;
        wire                            tcam_row_6_col_0_dft_array_freeze = dft_array_freeze;
        wire                            tcam_row_6_col_0_dft_afd_reset_b = dft_afd_reset_b;
        wire      [32-1:0]    tcam_row_6_col_0_tdin = 'b0;
        wire      [7-1:0]     tcam_row_6_col_0_tadr = 'b0;
        wire                            tcam_row_6_col_0_tvbe = 'b0;
        wire                            tcam_row_6_col_0_tvbi = 'b0;
        wire      [32-1:0]    tcam_row_6_col_0_tmask = 'b0;
        wire                            tcam_row_6_col_0_twe = 'b0;
        wire                            tcam_row_6_col_0_tre = 'b0;
        wire                            tcam_row_6_col_0_tme = 'b0;
        wire                            tcam_row_6_col_0_bist_rotate_sr = 'b0;
        wire                            tcam_row_6_col_0_bist_en_sr_mask_b = 'b0;
        wire                            tcam_row_6_col_0_bist_all_mask = 'b0;
        wire                            tcam_row_6_col_0_bist_en_sr_data_b = 'b0;
        wire                            tcam_row_6_col_0_bist_cm_mode = 'b0;
        wire                            tcam_row_6_col_0_bist_cm_en_in = 'b0;
        wire                            tcam_row_6_col_0_bist_cm_match_sel0 = 'b0;
        wire                            tcam_row_6_col_0_bist_cm_match_sel1 = 'b0;
        wire                            tcam_row_6_col_0_bist_matchin_in = 'b0;
        wire                            tcam_row_6_col_0_bist_fls = 'b0;
        `endif
        
        // Outputs
        logic                           tcam_row_6_col_0_wr_bira_fail;
        logic                           tcam_row_6_col_0_wr_so;
        logic                           tcam_row_6_col_0_curerrout;
        logic                           tcam_row_6_col_0_rscout;
        
        
        
        logic   [TCAM_SLICE_EN_FACT-1:0]                  tcam_row_6_col_0_slice_en_s0; 
        logic   [TCAM_SLICE_EN_FACT-1:0]                  tcam_row_6_col_0_slice_en_s1; 
        
        
        
             wire    [32-1:0]                     tcam_row_6_col_0_data_out ;
        
        
        
         generate
            if (BCAM_N7 == 0) 
              begin : gen_tcam_row_6_col_0_tcam
        
        
        // slice_en kept for TCAM only for backward compatability with Intel process
                always_comb 
                begin
                  for (int i = 0; i < TCAM_SLICE_EN_FACT; i++)
                      if (tcam_row_6_col_0_slice_en_s1[i])
                           tcam_row_6_col_0_hit_out[ i*64 +: 64]  = tcam_row_6_col_0_hit_out_int  [ i*64 +: 64]; 
                      else
                           tcam_row_6_col_0_hit_out[ i*64 +: 64]  = tcam_row_6_col_0_hit_out_latch[ i*64 +: 64]; 
                end
        
        
        
                always_ff  @(posedge tcam_row_6_col_0_clk)
                begin
                  tcam_row_6_col_0_slice_en_s0 <= tcam_row_6_col_0_slice_en; 
                  tcam_row_6_col_0_slice_en_s1 <= tcam_row_6_col_0_slice_en_s0; 
        
                  for (int i = 0; i < TCAM_SLICE_EN_FACT; i++)
                    begin
                      if (tcam_row_6_col_0_slice_en_s1[i])
                         tcam_row_6_col_0_hit_out_latch[ i*64 +: 64] <=  tcam_row_6_col_0_hit_out_int[ i*64 +: 64];
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
        
                     
                         assign tcam_row_6_col_0_data_out  = ~tcam_row_6_col_0_data_out_inv;
                         pcie_itp_ip783tcam64x32s0c1_6_0_wrap #(        
                                 )               
        
                                 ip783tcam64x32s0c1_wrap_tcam_row_6_col_0 (
                   //-------------------------------------------------------------
                   // Power Management Interfaces
                   //-------------------------------------------------------------   
                      `ifndef INTEL_NO_PWR_PINS
                      `ifdef INTC_ADD_VSS
                        .vss              (1'b0),
                      `endif
                        .vddp             (1'b1),
                      `endif
                         .ADR               (tcam_row_6_col_0_adr[7-1:1]), //Input adr_intess
                         .ME                (ce),  
        
                         .CLK               (tcam_row_6_col_0_clk), //Clock
                         .CMP               (tcam_row_6_col_0_chk_en), //Control Enable
                         .DIN               (~tcam_row_6_col_0_data_in), 
                         .DSEL              (~tcam_row_6_col_0_adr[0]), //dncen enables access of the TCAM Arrays adr_intessed
                         .FLS               (flush), //flush initiates a Flush operation that resets all Valid
                         .RVLD              (tcam_row_6_col_0_hit_in ), //Row validation bus. Each match_in input controls 1
                         .MASK              (tcam_row_6_col_0_mask_in), //Input msk
                         .QOUT              (tcam_row_6_col_0_data_out_inv), //Output vben
                         .QHR               (tcam_row_6_col_0_hit_out_int),
                         .QVLD              (), 
                         .RE                (tcam_row_6_col_0_rd_en), //Read Enable
                         .RST               (tcam_row_6_col_0_reset_n), //Asynchronous Active-High Reset
                         .VBE               (1'b1), //vben enables the Valid Bit addressed by adr[a-1:0] to
                         .VBI               (1'b0),//  Valid Bit Input
                         .WE                (tcam_row_6_col_0_wr_en), //Write Enable
                         .FAF               (tcam_row_6_col_0_fca),
                         .FAF_EN            (tcam_row_6_col_0_cre),
                         .DFTSHIFTEN        (tcam_row_6_col_0_dftshiften),
                         .DFTMASK           (tcam_row_6_col_0_dftmask),
                         .DFT_ARRAY_FREEZE  (tcam_row_6_col_0_dft_array_freeze),
                         .DFT_AFD_RESET_B   (tcam_row_6_col_0_dft_afd_reset_b),
                         .BISTE           (tcam_row_6_col_0_biste),
                         .TDIN (tcam_row_6_col_0_tdin),
                         .TADR (tcam_row_6_col_0_tadr),
                         .TVBE (tcam_row_6_col_0_tvbe),
                         .TVBI (tcam_row_6_col_0_tvbi),
                         .TMASK (tcam_row_6_col_0_tmask),
                         .TWE (tcam_row_6_col_0_twe),
                         .TRE (tcam_row_6_col_0_tre),
                         .TME (tcam_row_6_col_0_tme),
                         .BIST_ROTATE_SR (tcam_row_6_col_0_bist_rotate_sr),
                         .BIST_EN_SR_MASK_B (tcam_row_6_col_0_bist_en_sr_mask_b),
                         .BIST_ALL_MASK (tcam_row_6_col_0_bist_all_mask),
                         .BIST_EN_SR_DATA_B (tcam_row_6_col_0_bist_en_sr_data_b),
                         .BIST_CM_MODE (tcam_row_6_col_0_bist_cm_mode),
                         .BIST_CM_EN_IN (tcam_row_6_col_0_bist_cm_en_in),
                         .BIST_CM_MATCH_SEL0 (tcam_row_6_col_0_bist_cm_match_sel0),
                         .BIST_CM_MATCH_SEL1 (tcam_row_6_col_0_bist_cm_match_sel1),
                         .BIST_MATCHIN_IN (tcam_row_6_col_0_bist_matchin_in),
                         .BIST_FLS (tcam_row_6_col_0_bist_fls),
                         .MDST_tcam (fuse_tcam)
                     );
        
              end
              
            else
              begin : gen_tcam_row_6_col_0_bcam
              end
              
        
        
        endgenerate
        
        always_ff @(posedge clk) begin
                   tcam_rd_data_col[6][0]      <= tcam_row_6_col_0_data_out;
                   tcam_col_hit_out[6][0]       <= tcam_row_6_col_0_hit_out;
        end
        

        // this is new template - tcam_asic_template
        
        wire                                            tcam_row_6_col_1_clk         = clk;
        
        wire    [TCAM_SLICE_EN_FACT-1:0]                tcam_row_6_col_1_slice_en = TCAM_SLICE_EN_FACT'(slice_en[(6 * TCAM_SLICE_EN_FACT)+:TCAM_SLICE_EN_MIN]);
        
        wire                                            tcam_row_6_col_1_rd_en       = tcam_row_rd_en[6];
        wire                                            tcam_row_6_col_1_wr_en       = tcam_row_wr_en[6];
        wire                                            tcam_row_6_col_1_chk_en      = chk_en;
        wire                                            tcam_row_6_col_1_reset_n = reset_n;
        wire    [7-1:0]                       tcam_row_6_col_1_adr  = tcam_row_adr[6][7-1:0];
        wire    [32-1:0]                      tcam_row_6_col_1_data_in = tcam_row_wr_en[6] ? tcam_wr_data_col[1][32-1:0] : tcam_chk_key_col[1][32-1:0];
        wire    [32-1:0]                      tcam_row_6_col_1_data_in_pre = tcam_wr_data_col[1][32-1:0] ;
        wire    [32-1:0]                      tcam_row_6_col_1_key_in =  tcam_chk_key_col[1][32-1:0];
        wire    [32-1:0]                      tcam_row_6_col_1_mask_in = tcam_chk_mask_col[1][32-1:0];
        wire    [64-1:0]                       tcam_row_6_col_1_hit_in = tcam_raw_hit_in[6];
        wire    [64-1:0]                       tcam_row_6_col_1_tcam_match_in = tcam_row_match_in[6];
        wire    [32-1:0]                      tcam_row_6_col_1_data_out_inv;
        logic   [64-1:0]                     tcam_row_6_col_1_hit_out_int;
        logic   [64-1:0]                     tcam_row_6_col_1_hit_out_latch;
        logic   [64-1:0]                     tcam_row_6_col_1_hit_out;
        
        `ifdef HIF_PCIE_DFX_DISABLE
        wire                          tcam_row_6_col_1_biste = 'b0; 
        wire     [5-1:0]                  tcam_row_6_col_1_fca = 'b0;
        wire                            tcam_row_6_col_1_cre = 'b0;
        wire                            tcam_row_6_col_1_dftshiften = 'b0;
        wire                            tcam_row_6_col_1_dftmask = 'b0;
        wire                            tcam_row_6_col_1_dft_array_freeze = 'b0;
        wire                            tcam_row_6_col_1_dft_afd_reset_b = 'b0;
        wire      [32-1:0]    tcam_row_6_col_1_tdin = 'b0;
        wire      [7-1:0]     tcam_row_6_col_1_tadr = 'b0;
        wire                            tcam_row_6_col_1_tvbe = 'b0;
        wire                            tcam_row_6_col_1_tvbi = 'b0;
        wire      [32-1:0]    tcam_row_6_col_1_tmask = 'b0;
        wire                            tcam_row_6_col_1_twe = 'b0;
        wire                            tcam_row_6_col_1_tre = 'b0;
        wire                            tcam_row_6_col_1_tme = 'b0;
        wire                            tcam_row_6_col_1_bist_rotate_sr = 'b0;
        wire                            tcam_row_6_col_1_bist_en_sr_mask_b = 'b0;
        wire                            tcam_row_6_col_1_bist_all_mask = 'b0;
        wire                            tcam_row_6_col_1_bist_en_sr_data_b = 'b0;
        wire                            tcam_row_6_col_1_bist_cm_mode = 'b0;
        wire                            tcam_row_6_col_1_bist_cm_en_in = 'b0;
        wire                            tcam_row_6_col_1_bist_cm_match_sel0 = 'b0;
        wire                            tcam_row_6_col_1_bist_cm_match_sel1 = 'b0;
        wire                            tcam_row_6_col_1_bist_matchin_in = 'b0;
        wire                            tcam_row_6_col_1_bist_fls = 'b0;
        
        `else
        wire                            tcam_row_6_col_1_biste = 'b0;
        wire     [5-1:0]                  tcam_row_6_col_1_fca = 'b0;
        wire                            tcam_row_6_col_1_cre = 'b0;
        wire                            tcam_row_6_col_1_dftshiften = dftshiften;
        wire                            tcam_row_6_col_1_dftmask = dftmask;
        wire                            tcam_row_6_col_1_dft_array_freeze = dft_array_freeze;
        wire                            tcam_row_6_col_1_dft_afd_reset_b = dft_afd_reset_b;
        wire      [32-1:0]    tcam_row_6_col_1_tdin = 'b0;
        wire      [7-1:0]     tcam_row_6_col_1_tadr = 'b0;
        wire                            tcam_row_6_col_1_tvbe = 'b0;
        wire                            tcam_row_6_col_1_tvbi = 'b0;
        wire      [32-1:0]    tcam_row_6_col_1_tmask = 'b0;
        wire                            tcam_row_6_col_1_twe = 'b0;
        wire                            tcam_row_6_col_1_tre = 'b0;
        wire                            tcam_row_6_col_1_tme = 'b0;
        wire                            tcam_row_6_col_1_bist_rotate_sr = 'b0;
        wire                            tcam_row_6_col_1_bist_en_sr_mask_b = 'b0;
        wire                            tcam_row_6_col_1_bist_all_mask = 'b0;
        wire                            tcam_row_6_col_1_bist_en_sr_data_b = 'b0;
        wire                            tcam_row_6_col_1_bist_cm_mode = 'b0;
        wire                            tcam_row_6_col_1_bist_cm_en_in = 'b0;
        wire                            tcam_row_6_col_1_bist_cm_match_sel0 = 'b0;
        wire                            tcam_row_6_col_1_bist_cm_match_sel1 = 'b0;
        wire                            tcam_row_6_col_1_bist_matchin_in = 'b0;
        wire                            tcam_row_6_col_1_bist_fls = 'b0;
        `endif
        
        // Outputs
        logic                           tcam_row_6_col_1_wr_bira_fail;
        logic                           tcam_row_6_col_1_wr_so;
        logic                           tcam_row_6_col_1_curerrout;
        logic                           tcam_row_6_col_1_rscout;
        
        
        
        logic   [TCAM_SLICE_EN_FACT-1:0]                  tcam_row_6_col_1_slice_en_s0; 
        logic   [TCAM_SLICE_EN_FACT-1:0]                  tcam_row_6_col_1_slice_en_s1; 
        
        
        
             wire    [32-1:0]                     tcam_row_6_col_1_data_out ;
        
        
        
         generate
            if (BCAM_N7 == 0) 
              begin : gen_tcam_row_6_col_1_tcam
        
        
        // slice_en kept for TCAM only for backward compatability with Intel process
                always_comb 
                begin
                  for (int i = 0; i < TCAM_SLICE_EN_FACT; i++)
                      if (tcam_row_6_col_1_slice_en_s1[i])
                           tcam_row_6_col_1_hit_out[ i*64 +: 64]  = tcam_row_6_col_1_hit_out_int  [ i*64 +: 64]; 
                      else
                           tcam_row_6_col_1_hit_out[ i*64 +: 64]  = tcam_row_6_col_1_hit_out_latch[ i*64 +: 64]; 
                end
        
        
        
                always_ff  @(posedge tcam_row_6_col_1_clk)
                begin
                  tcam_row_6_col_1_slice_en_s0 <= tcam_row_6_col_1_slice_en; 
                  tcam_row_6_col_1_slice_en_s1 <= tcam_row_6_col_1_slice_en_s0; 
        
                  for (int i = 0; i < TCAM_SLICE_EN_FACT; i++)
                    begin
                      if (tcam_row_6_col_1_slice_en_s1[i])
                         tcam_row_6_col_1_hit_out_latch[ i*64 +: 64] <=  tcam_row_6_col_1_hit_out_int[ i*64 +: 64];
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
        
                     
                         assign tcam_row_6_col_1_data_out  = ~tcam_row_6_col_1_data_out_inv;
                         pcie_itp_ip783tcam64x32s0c1_6_1_wrap #(        
                                 )               
        
                                 ip783tcam64x32s0c1_wrap_tcam_row_6_col_1 (
                   //-------------------------------------------------------------
                   // Power Management Interfaces
                   //-------------------------------------------------------------   
                      `ifndef INTEL_NO_PWR_PINS
                      `ifdef INTC_ADD_VSS
                        .vss              (1'b0),
                      `endif
                        .vddp             (1'b1),
                      `endif
                         .ADR               (tcam_row_6_col_1_adr[7-1:1]), //Input adr_intess
                         .ME                (ce),  
        
                         .CLK               (tcam_row_6_col_1_clk), //Clock
                         .CMP               (tcam_row_6_col_1_chk_en), //Control Enable
                         .DIN               (~tcam_row_6_col_1_data_in), 
                         .DSEL              (~tcam_row_6_col_1_adr[0]), //dncen enables access of the TCAM Arrays adr_intessed
                         .FLS               (flush), //flush initiates a Flush operation that resets all Valid
                         .RVLD              (tcam_row_6_col_1_hit_in ), //Row validation bus. Each match_in input controls 1
                         .MASK              (tcam_row_6_col_1_mask_in), //Input msk
                         .QOUT              (tcam_row_6_col_1_data_out_inv), //Output vben
                         .QHR               (tcam_row_6_col_1_hit_out_int),
                         .QVLD              (), 
                         .RE                (tcam_row_6_col_1_rd_en), //Read Enable
                         .RST               (tcam_row_6_col_1_reset_n), //Asynchronous Active-High Reset
                         .VBE               (1'b1), //vben enables the Valid Bit addressed by adr[a-1:0] to
                         .VBI               (1'b0),//  Valid Bit Input
                         .WE                (tcam_row_6_col_1_wr_en), //Write Enable
                         .FAF               (tcam_row_6_col_1_fca),
                         .FAF_EN            (tcam_row_6_col_1_cre),
                         .DFTSHIFTEN        (tcam_row_6_col_1_dftshiften),
                         .DFTMASK           (tcam_row_6_col_1_dftmask),
                         .DFT_ARRAY_FREEZE  (tcam_row_6_col_1_dft_array_freeze),
                         .DFT_AFD_RESET_B   (tcam_row_6_col_1_dft_afd_reset_b),
                         .BISTE           (tcam_row_6_col_1_biste),
                         .TDIN (tcam_row_6_col_1_tdin),
                         .TADR (tcam_row_6_col_1_tadr),
                         .TVBE (tcam_row_6_col_1_tvbe),
                         .TVBI (tcam_row_6_col_1_tvbi),
                         .TMASK (tcam_row_6_col_1_tmask),
                         .TWE (tcam_row_6_col_1_twe),
                         .TRE (tcam_row_6_col_1_tre),
                         .TME (tcam_row_6_col_1_tme),
                         .BIST_ROTATE_SR (tcam_row_6_col_1_bist_rotate_sr),
                         .BIST_EN_SR_MASK_B (tcam_row_6_col_1_bist_en_sr_mask_b),
                         .BIST_ALL_MASK (tcam_row_6_col_1_bist_all_mask),
                         .BIST_EN_SR_DATA_B (tcam_row_6_col_1_bist_en_sr_data_b),
                         .BIST_CM_MODE (tcam_row_6_col_1_bist_cm_mode),
                         .BIST_CM_EN_IN (tcam_row_6_col_1_bist_cm_en_in),
                         .BIST_CM_MATCH_SEL0 (tcam_row_6_col_1_bist_cm_match_sel0),
                         .BIST_CM_MATCH_SEL1 (tcam_row_6_col_1_bist_cm_match_sel1),
                         .BIST_MATCHIN_IN (tcam_row_6_col_1_bist_matchin_in),
                         .BIST_FLS (tcam_row_6_col_1_bist_fls),
                         .MDST_tcam (fuse_tcam)
                     );
        
              end
              
            else
              begin : gen_tcam_row_6_col_1_bcam
              end
              
        
        
        endgenerate
        
        always_ff @(posedge clk) begin
                   tcam_rd_data_col[6][1]      <= tcam_row_6_col_1_data_out;
                   tcam_col_hit_out[6][1]       <= tcam_row_6_col_1_hit_out;
        end
        

        // this is new template - tcam_asic_template
        
        wire                                            tcam_row_7_col_0_clk         = clk;
        
        wire    [TCAM_SLICE_EN_FACT-1:0]                tcam_row_7_col_0_slice_en = TCAM_SLICE_EN_FACT'(slice_en[(7 * TCAM_SLICE_EN_FACT)+:TCAM_SLICE_EN_MIN]);
        
        wire                                            tcam_row_7_col_0_rd_en       = tcam_row_rd_en[7];
        wire                                            tcam_row_7_col_0_wr_en       = tcam_row_wr_en[7];
        wire                                            tcam_row_7_col_0_chk_en      = chk_en;
        wire                                            tcam_row_7_col_0_reset_n = reset_n;
        wire    [7-1:0]                       tcam_row_7_col_0_adr  = tcam_row_adr[7][7-1:0];
        wire    [32-1:0]                      tcam_row_7_col_0_data_in = tcam_row_wr_en[7] ? tcam_wr_data_col[0][32-1:0] : tcam_chk_key_col[0][32-1:0];
        wire    [32-1:0]                      tcam_row_7_col_0_data_in_pre = tcam_wr_data_col[0][32-1:0] ;
        wire    [32-1:0]                      tcam_row_7_col_0_key_in =  tcam_chk_key_col[0][32-1:0];
        wire    [32-1:0]                      tcam_row_7_col_0_mask_in = tcam_chk_mask_col[0][32-1:0];
        wire    [64-1:0]                       tcam_row_7_col_0_hit_in = tcam_raw_hit_in[7];
        wire    [64-1:0]                       tcam_row_7_col_0_tcam_match_in = tcam_row_match_in[7];
        wire    [32-1:0]                      tcam_row_7_col_0_data_out_inv;
        logic   [64-1:0]                     tcam_row_7_col_0_hit_out_int;
        logic   [64-1:0]                     tcam_row_7_col_0_hit_out_latch;
        logic   [64-1:0]                     tcam_row_7_col_0_hit_out;
        
        `ifdef HIF_PCIE_DFX_DISABLE
        wire                          tcam_row_7_col_0_biste = 'b0; 
        wire     [5-1:0]                  tcam_row_7_col_0_fca = 'b0;
        wire                            tcam_row_7_col_0_cre = 'b0;
        wire                            tcam_row_7_col_0_dftshiften = 'b0;
        wire                            tcam_row_7_col_0_dftmask = 'b0;
        wire                            tcam_row_7_col_0_dft_array_freeze = 'b0;
        wire                            tcam_row_7_col_0_dft_afd_reset_b = 'b0;
        wire      [32-1:0]    tcam_row_7_col_0_tdin = 'b0;
        wire      [7-1:0]     tcam_row_7_col_0_tadr = 'b0;
        wire                            tcam_row_7_col_0_tvbe = 'b0;
        wire                            tcam_row_7_col_0_tvbi = 'b0;
        wire      [32-1:0]    tcam_row_7_col_0_tmask = 'b0;
        wire                            tcam_row_7_col_0_twe = 'b0;
        wire                            tcam_row_7_col_0_tre = 'b0;
        wire                            tcam_row_7_col_0_tme = 'b0;
        wire                            tcam_row_7_col_0_bist_rotate_sr = 'b0;
        wire                            tcam_row_7_col_0_bist_en_sr_mask_b = 'b0;
        wire                            tcam_row_7_col_0_bist_all_mask = 'b0;
        wire                            tcam_row_7_col_0_bist_en_sr_data_b = 'b0;
        wire                            tcam_row_7_col_0_bist_cm_mode = 'b0;
        wire                            tcam_row_7_col_0_bist_cm_en_in = 'b0;
        wire                            tcam_row_7_col_0_bist_cm_match_sel0 = 'b0;
        wire                            tcam_row_7_col_0_bist_cm_match_sel1 = 'b0;
        wire                            tcam_row_7_col_0_bist_matchin_in = 'b0;
        wire                            tcam_row_7_col_0_bist_fls = 'b0;
        
        `else
        wire                            tcam_row_7_col_0_biste = 'b0;
        wire     [5-1:0]                  tcam_row_7_col_0_fca = 'b0;
        wire                            tcam_row_7_col_0_cre = 'b0;
        wire                            tcam_row_7_col_0_dftshiften = dftshiften;
        wire                            tcam_row_7_col_0_dftmask = dftmask;
        wire                            tcam_row_7_col_0_dft_array_freeze = dft_array_freeze;
        wire                            tcam_row_7_col_0_dft_afd_reset_b = dft_afd_reset_b;
        wire      [32-1:0]    tcam_row_7_col_0_tdin = 'b0;
        wire      [7-1:0]     tcam_row_7_col_0_tadr = 'b0;
        wire                            tcam_row_7_col_0_tvbe = 'b0;
        wire                            tcam_row_7_col_0_tvbi = 'b0;
        wire      [32-1:0]    tcam_row_7_col_0_tmask = 'b0;
        wire                            tcam_row_7_col_0_twe = 'b0;
        wire                            tcam_row_7_col_0_tre = 'b0;
        wire                            tcam_row_7_col_0_tme = 'b0;
        wire                            tcam_row_7_col_0_bist_rotate_sr = 'b0;
        wire                            tcam_row_7_col_0_bist_en_sr_mask_b = 'b0;
        wire                            tcam_row_7_col_0_bist_all_mask = 'b0;
        wire                            tcam_row_7_col_0_bist_en_sr_data_b = 'b0;
        wire                            tcam_row_7_col_0_bist_cm_mode = 'b0;
        wire                            tcam_row_7_col_0_bist_cm_en_in = 'b0;
        wire                            tcam_row_7_col_0_bist_cm_match_sel0 = 'b0;
        wire                            tcam_row_7_col_0_bist_cm_match_sel1 = 'b0;
        wire                            tcam_row_7_col_0_bist_matchin_in = 'b0;
        wire                            tcam_row_7_col_0_bist_fls = 'b0;
        `endif
        
        // Outputs
        logic                           tcam_row_7_col_0_wr_bira_fail;
        logic                           tcam_row_7_col_0_wr_so;
        logic                           tcam_row_7_col_0_curerrout;
        logic                           tcam_row_7_col_0_rscout;
        
        
        
        logic   [TCAM_SLICE_EN_FACT-1:0]                  tcam_row_7_col_0_slice_en_s0; 
        logic   [TCAM_SLICE_EN_FACT-1:0]                  tcam_row_7_col_0_slice_en_s1; 
        
        
        
             wire    [32-1:0]                     tcam_row_7_col_0_data_out ;
        
        
        
         generate
            if (BCAM_N7 == 0) 
              begin : gen_tcam_row_7_col_0_tcam
        
        
        // slice_en kept for TCAM only for backward compatability with Intel process
                always_comb 
                begin
                  for (int i = 0; i < TCAM_SLICE_EN_FACT; i++)
                      if (tcam_row_7_col_0_slice_en_s1[i])
                           tcam_row_7_col_0_hit_out[ i*64 +: 64]  = tcam_row_7_col_0_hit_out_int  [ i*64 +: 64]; 
                      else
                           tcam_row_7_col_0_hit_out[ i*64 +: 64]  = tcam_row_7_col_0_hit_out_latch[ i*64 +: 64]; 
                end
        
        
        
                always_ff  @(posedge tcam_row_7_col_0_clk)
                begin
                  tcam_row_7_col_0_slice_en_s0 <= tcam_row_7_col_0_slice_en; 
                  tcam_row_7_col_0_slice_en_s1 <= tcam_row_7_col_0_slice_en_s0; 
        
                  for (int i = 0; i < TCAM_SLICE_EN_FACT; i++)
                    begin
                      if (tcam_row_7_col_0_slice_en_s1[i])
                         tcam_row_7_col_0_hit_out_latch[ i*64 +: 64] <=  tcam_row_7_col_0_hit_out_int[ i*64 +: 64];
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
        
                     
                         assign tcam_row_7_col_0_data_out  = ~tcam_row_7_col_0_data_out_inv;
                         pcie_itp_ip783tcam64x32s0c1_7_0_wrap #(        
                                 )               
        
                                 ip783tcam64x32s0c1_wrap_tcam_row_7_col_0 (
                   //-------------------------------------------------------------
                   // Power Management Interfaces
                   //-------------------------------------------------------------   
                      `ifndef INTEL_NO_PWR_PINS
                      `ifdef INTC_ADD_VSS
                        .vss              (1'b0),
                      `endif
                        .vddp             (1'b1),
                      `endif
                         .ADR               (tcam_row_7_col_0_adr[7-1:1]), //Input adr_intess
                         .ME                (ce),  
        
                         .CLK               (tcam_row_7_col_0_clk), //Clock
                         .CMP               (tcam_row_7_col_0_chk_en), //Control Enable
                         .DIN               (~tcam_row_7_col_0_data_in), 
                         .DSEL              (~tcam_row_7_col_0_adr[0]), //dncen enables access of the TCAM Arrays adr_intessed
                         .FLS               (flush), //flush initiates a Flush operation that resets all Valid
                         .RVLD              (tcam_row_7_col_0_hit_in ), //Row validation bus. Each match_in input controls 1
                         .MASK              (tcam_row_7_col_0_mask_in), //Input msk
                         .QOUT              (tcam_row_7_col_0_data_out_inv), //Output vben
                         .QHR               (tcam_row_7_col_0_hit_out_int),
                         .QVLD              (), 
                         .RE                (tcam_row_7_col_0_rd_en), //Read Enable
                         .RST               (tcam_row_7_col_0_reset_n), //Asynchronous Active-High Reset
                         .VBE               (1'b1), //vben enables the Valid Bit addressed by adr[a-1:0] to
                         .VBI               (1'b0),//  Valid Bit Input
                         .WE                (tcam_row_7_col_0_wr_en), //Write Enable
                         .FAF               (tcam_row_7_col_0_fca),
                         .FAF_EN            (tcam_row_7_col_0_cre),
                         .DFTSHIFTEN        (tcam_row_7_col_0_dftshiften),
                         .DFTMASK           (tcam_row_7_col_0_dftmask),
                         .DFT_ARRAY_FREEZE  (tcam_row_7_col_0_dft_array_freeze),
                         .DFT_AFD_RESET_B   (tcam_row_7_col_0_dft_afd_reset_b),
                         .BISTE           (tcam_row_7_col_0_biste),
                         .TDIN (tcam_row_7_col_0_tdin),
                         .TADR (tcam_row_7_col_0_tadr),
                         .TVBE (tcam_row_7_col_0_tvbe),
                         .TVBI (tcam_row_7_col_0_tvbi),
                         .TMASK (tcam_row_7_col_0_tmask),
                         .TWE (tcam_row_7_col_0_twe),
                         .TRE (tcam_row_7_col_0_tre),
                         .TME (tcam_row_7_col_0_tme),
                         .BIST_ROTATE_SR (tcam_row_7_col_0_bist_rotate_sr),
                         .BIST_EN_SR_MASK_B (tcam_row_7_col_0_bist_en_sr_mask_b),
                         .BIST_ALL_MASK (tcam_row_7_col_0_bist_all_mask),
                         .BIST_EN_SR_DATA_B (tcam_row_7_col_0_bist_en_sr_data_b),
                         .BIST_CM_MODE (tcam_row_7_col_0_bist_cm_mode),
                         .BIST_CM_EN_IN (tcam_row_7_col_0_bist_cm_en_in),
                         .BIST_CM_MATCH_SEL0 (tcam_row_7_col_0_bist_cm_match_sel0),
                         .BIST_CM_MATCH_SEL1 (tcam_row_7_col_0_bist_cm_match_sel1),
                         .BIST_MATCHIN_IN (tcam_row_7_col_0_bist_matchin_in),
                         .BIST_FLS (tcam_row_7_col_0_bist_fls),
                         .MDST_tcam (fuse_tcam)
                     );
        
              end
              
            else
              begin : gen_tcam_row_7_col_0_bcam
              end
              
        
        
        endgenerate
        
        always_ff @(posedge clk) begin
                   tcam_rd_data_col[7][0]      <= tcam_row_7_col_0_data_out;
                   tcam_col_hit_out[7][0]       <= tcam_row_7_col_0_hit_out;
        end
        

        // this is new template - tcam_asic_template
        
        wire                                            tcam_row_7_col_1_clk         = clk;
        
        wire    [TCAM_SLICE_EN_FACT-1:0]                tcam_row_7_col_1_slice_en = TCAM_SLICE_EN_FACT'(slice_en[(7 * TCAM_SLICE_EN_FACT)+:TCAM_SLICE_EN_MIN]);
        
        wire                                            tcam_row_7_col_1_rd_en       = tcam_row_rd_en[7];
        wire                                            tcam_row_7_col_1_wr_en       = tcam_row_wr_en[7];
        wire                                            tcam_row_7_col_1_chk_en      = chk_en;
        wire                                            tcam_row_7_col_1_reset_n = reset_n;
        wire    [7-1:0]                       tcam_row_7_col_1_adr  = tcam_row_adr[7][7-1:0];
        wire    [32-1:0]                      tcam_row_7_col_1_data_in = tcam_row_wr_en[7] ? tcam_wr_data_col[1][32-1:0] : tcam_chk_key_col[1][32-1:0];
        wire    [32-1:0]                      tcam_row_7_col_1_data_in_pre = tcam_wr_data_col[1][32-1:0] ;
        wire    [32-1:0]                      tcam_row_7_col_1_key_in =  tcam_chk_key_col[1][32-1:0];
        wire    [32-1:0]                      tcam_row_7_col_1_mask_in = tcam_chk_mask_col[1][32-1:0];
        wire    [64-1:0]                       tcam_row_7_col_1_hit_in = tcam_raw_hit_in[7];
        wire    [64-1:0]                       tcam_row_7_col_1_tcam_match_in = tcam_row_match_in[7];
        wire    [32-1:0]                      tcam_row_7_col_1_data_out_inv;
        logic   [64-1:0]                     tcam_row_7_col_1_hit_out_int;
        logic   [64-1:0]                     tcam_row_7_col_1_hit_out_latch;
        logic   [64-1:0]                     tcam_row_7_col_1_hit_out;
        
        `ifdef HIF_PCIE_DFX_DISABLE
        wire                          tcam_row_7_col_1_biste = 'b0; 
        wire     [5-1:0]                  tcam_row_7_col_1_fca = 'b0;
        wire                            tcam_row_7_col_1_cre = 'b0;
        wire                            tcam_row_7_col_1_dftshiften = 'b0;
        wire                            tcam_row_7_col_1_dftmask = 'b0;
        wire                            tcam_row_7_col_1_dft_array_freeze = 'b0;
        wire                            tcam_row_7_col_1_dft_afd_reset_b = 'b0;
        wire      [32-1:0]    tcam_row_7_col_1_tdin = 'b0;
        wire      [7-1:0]     tcam_row_7_col_1_tadr = 'b0;
        wire                            tcam_row_7_col_1_tvbe = 'b0;
        wire                            tcam_row_7_col_1_tvbi = 'b0;
        wire      [32-1:0]    tcam_row_7_col_1_tmask = 'b0;
        wire                            tcam_row_7_col_1_twe = 'b0;
        wire                            tcam_row_7_col_1_tre = 'b0;
        wire                            tcam_row_7_col_1_tme = 'b0;
        wire                            tcam_row_7_col_1_bist_rotate_sr = 'b0;
        wire                            tcam_row_7_col_1_bist_en_sr_mask_b = 'b0;
        wire                            tcam_row_7_col_1_bist_all_mask = 'b0;
        wire                            tcam_row_7_col_1_bist_en_sr_data_b = 'b0;
        wire                            tcam_row_7_col_1_bist_cm_mode = 'b0;
        wire                            tcam_row_7_col_1_bist_cm_en_in = 'b0;
        wire                            tcam_row_7_col_1_bist_cm_match_sel0 = 'b0;
        wire                            tcam_row_7_col_1_bist_cm_match_sel1 = 'b0;
        wire                            tcam_row_7_col_1_bist_matchin_in = 'b0;
        wire                            tcam_row_7_col_1_bist_fls = 'b0;
        
        `else
        wire                            tcam_row_7_col_1_biste = 'b0;
        wire     [5-1:0]                  tcam_row_7_col_1_fca = 'b0;
        wire                            tcam_row_7_col_1_cre = 'b0;
        wire                            tcam_row_7_col_1_dftshiften = dftshiften;
        wire                            tcam_row_7_col_1_dftmask = dftmask;
        wire                            tcam_row_7_col_1_dft_array_freeze = dft_array_freeze;
        wire                            tcam_row_7_col_1_dft_afd_reset_b = dft_afd_reset_b;
        wire      [32-1:0]    tcam_row_7_col_1_tdin = 'b0;
        wire      [7-1:0]     tcam_row_7_col_1_tadr = 'b0;
        wire                            tcam_row_7_col_1_tvbe = 'b0;
        wire                            tcam_row_7_col_1_tvbi = 'b0;
        wire      [32-1:0]    tcam_row_7_col_1_tmask = 'b0;
        wire                            tcam_row_7_col_1_twe = 'b0;
        wire                            tcam_row_7_col_1_tre = 'b0;
        wire                            tcam_row_7_col_1_tme = 'b0;
        wire                            tcam_row_7_col_1_bist_rotate_sr = 'b0;
        wire                            tcam_row_7_col_1_bist_en_sr_mask_b = 'b0;
        wire                            tcam_row_7_col_1_bist_all_mask = 'b0;
        wire                            tcam_row_7_col_1_bist_en_sr_data_b = 'b0;
        wire                            tcam_row_7_col_1_bist_cm_mode = 'b0;
        wire                            tcam_row_7_col_1_bist_cm_en_in = 'b0;
        wire                            tcam_row_7_col_1_bist_cm_match_sel0 = 'b0;
        wire                            tcam_row_7_col_1_bist_cm_match_sel1 = 'b0;
        wire                            tcam_row_7_col_1_bist_matchin_in = 'b0;
        wire                            tcam_row_7_col_1_bist_fls = 'b0;
        `endif
        
        // Outputs
        logic                           tcam_row_7_col_1_wr_bira_fail;
        logic                           tcam_row_7_col_1_wr_so;
        logic                           tcam_row_7_col_1_curerrout;
        logic                           tcam_row_7_col_1_rscout;
        
        
        
        logic   [TCAM_SLICE_EN_FACT-1:0]                  tcam_row_7_col_1_slice_en_s0; 
        logic   [TCAM_SLICE_EN_FACT-1:0]                  tcam_row_7_col_1_slice_en_s1; 
        
        
        
             wire    [32-1:0]                     tcam_row_7_col_1_data_out ;
        
        
        
         generate
            if (BCAM_N7 == 0) 
              begin : gen_tcam_row_7_col_1_tcam
        
        
        // slice_en kept for TCAM only for backward compatability with Intel process
                always_comb 
                begin
                  for (int i = 0; i < TCAM_SLICE_EN_FACT; i++)
                      if (tcam_row_7_col_1_slice_en_s1[i])
                           tcam_row_7_col_1_hit_out[ i*64 +: 64]  = tcam_row_7_col_1_hit_out_int  [ i*64 +: 64]; 
                      else
                           tcam_row_7_col_1_hit_out[ i*64 +: 64]  = tcam_row_7_col_1_hit_out_latch[ i*64 +: 64]; 
                end
        
        
        
                always_ff  @(posedge tcam_row_7_col_1_clk)
                begin
                  tcam_row_7_col_1_slice_en_s0 <= tcam_row_7_col_1_slice_en; 
                  tcam_row_7_col_1_slice_en_s1 <= tcam_row_7_col_1_slice_en_s0; 
        
                  for (int i = 0; i < TCAM_SLICE_EN_FACT; i++)
                    begin
                      if (tcam_row_7_col_1_slice_en_s1[i])
                         tcam_row_7_col_1_hit_out_latch[ i*64 +: 64] <=  tcam_row_7_col_1_hit_out_int[ i*64 +: 64];
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
        
                     
                         assign tcam_row_7_col_1_data_out  = ~tcam_row_7_col_1_data_out_inv;
                         pcie_itp_ip783tcam64x32s0c1_7_1_wrap #(        
                                 )               
        
                                 ip783tcam64x32s0c1_wrap_tcam_row_7_col_1 (
                   //-------------------------------------------------------------
                   // Power Management Interfaces
                   //-------------------------------------------------------------   
                      `ifndef INTEL_NO_PWR_PINS
                      `ifdef INTC_ADD_VSS
                        .vss              (1'b0),
                      `endif
                        .vddp             (1'b1),
                      `endif
                         .ADR               (tcam_row_7_col_1_adr[7-1:1]), //Input adr_intess
                         .ME                (ce),  
        
                         .CLK               (tcam_row_7_col_1_clk), //Clock
                         .CMP               (tcam_row_7_col_1_chk_en), //Control Enable
                         .DIN               (~tcam_row_7_col_1_data_in), 
                         .DSEL              (~tcam_row_7_col_1_adr[0]), //dncen enables access of the TCAM Arrays adr_intessed
                         .FLS               (flush), //flush initiates a Flush operation that resets all Valid
                         .RVLD              (tcam_row_7_col_1_hit_in ), //Row validation bus. Each match_in input controls 1
                         .MASK              (tcam_row_7_col_1_mask_in), //Input msk
                         .QOUT              (tcam_row_7_col_1_data_out_inv), //Output vben
                         .QHR               (tcam_row_7_col_1_hit_out_int),
                         .QVLD              (), 
                         .RE                (tcam_row_7_col_1_rd_en), //Read Enable
                         .RST               (tcam_row_7_col_1_reset_n), //Asynchronous Active-High Reset
                         .VBE               (1'b1), //vben enables the Valid Bit addressed by adr[a-1:0] to
                         .VBI               (1'b0),//  Valid Bit Input
                         .WE                (tcam_row_7_col_1_wr_en), //Write Enable
                         .FAF               (tcam_row_7_col_1_fca),
                         .FAF_EN            (tcam_row_7_col_1_cre),
                         .DFTSHIFTEN        (tcam_row_7_col_1_dftshiften),
                         .DFTMASK           (tcam_row_7_col_1_dftmask),
                         .DFT_ARRAY_FREEZE  (tcam_row_7_col_1_dft_array_freeze),
                         .DFT_AFD_RESET_B   (tcam_row_7_col_1_dft_afd_reset_b),
                         .BISTE           (tcam_row_7_col_1_biste),
                         .TDIN (tcam_row_7_col_1_tdin),
                         .TADR (tcam_row_7_col_1_tadr),
                         .TVBE (tcam_row_7_col_1_tvbe),
                         .TVBI (tcam_row_7_col_1_tvbi),
                         .TMASK (tcam_row_7_col_1_tmask),
                         .TWE (tcam_row_7_col_1_twe),
                         .TRE (tcam_row_7_col_1_tre),
                         .TME (tcam_row_7_col_1_tme),
                         .BIST_ROTATE_SR (tcam_row_7_col_1_bist_rotate_sr),
                         .BIST_EN_SR_MASK_B (tcam_row_7_col_1_bist_en_sr_mask_b),
                         .BIST_ALL_MASK (tcam_row_7_col_1_bist_all_mask),
                         .BIST_EN_SR_DATA_B (tcam_row_7_col_1_bist_en_sr_data_b),
                         .BIST_CM_MODE (tcam_row_7_col_1_bist_cm_mode),
                         .BIST_CM_EN_IN (tcam_row_7_col_1_bist_cm_en_in),
                         .BIST_CM_MATCH_SEL0 (tcam_row_7_col_1_bist_cm_match_sel0),
                         .BIST_CM_MATCH_SEL1 (tcam_row_7_col_1_bist_cm_match_sel1),
                         .BIST_MATCHIN_IN (tcam_row_7_col_1_bist_matchin_in),
                         .BIST_FLS (tcam_row_7_col_1_bist_fls),
                         .MDST_tcam (fuse_tcam)
                     );
        
              end
              
            else
              begin : gen_tcam_row_7_col_1_bcam
              end
              
        
        
        endgenerate
        
        always_ff @(posedge clk) begin
                   tcam_rd_data_col[7][1]      <= tcam_row_7_col_1_data_out;
                   tcam_col_hit_out[7][1]       <= tcam_row_7_col_1_hit_out;
        end
        

        // this is new template - tcam_asic_template
        
        wire                                            tcam_row_8_col_0_clk         = clk;
        
        wire    [TCAM_SLICE_EN_FACT-1:0]                tcam_row_8_col_0_slice_en = TCAM_SLICE_EN_FACT'(slice_en[(8 * TCAM_SLICE_EN_FACT)+:TCAM_SLICE_EN_MIN]);
        
        wire                                            tcam_row_8_col_0_rd_en       = tcam_row_rd_en[8];
        wire                                            tcam_row_8_col_0_wr_en       = tcam_row_wr_en[8];
        wire                                            tcam_row_8_col_0_chk_en      = chk_en;
        wire                                            tcam_row_8_col_0_reset_n = reset_n;
        wire    [7-1:0]                       tcam_row_8_col_0_adr  = tcam_row_adr[8][7-1:0];
        wire    [32-1:0]                      tcam_row_8_col_0_data_in = tcam_row_wr_en[8] ? tcam_wr_data_col[0][32-1:0] : tcam_chk_key_col[0][32-1:0];
        wire    [32-1:0]                      tcam_row_8_col_0_data_in_pre = tcam_wr_data_col[0][32-1:0] ;
        wire    [32-1:0]                      tcam_row_8_col_0_key_in =  tcam_chk_key_col[0][32-1:0];
        wire    [32-1:0]                      tcam_row_8_col_0_mask_in = tcam_chk_mask_col[0][32-1:0];
        wire    [64-1:0]                       tcam_row_8_col_0_hit_in = tcam_raw_hit_in[8];
        wire    [64-1:0]                       tcam_row_8_col_0_tcam_match_in = tcam_row_match_in[8];
        wire    [32-1:0]                      tcam_row_8_col_0_data_out_inv;
        logic   [64-1:0]                     tcam_row_8_col_0_hit_out_int;
        logic   [64-1:0]                     tcam_row_8_col_0_hit_out_latch;
        logic   [64-1:0]                     tcam_row_8_col_0_hit_out;
        
        `ifdef HIF_PCIE_DFX_DISABLE
        wire                          tcam_row_8_col_0_biste = 'b0; 
        wire     [5-1:0]                  tcam_row_8_col_0_fca = 'b0;
        wire                            tcam_row_8_col_0_cre = 'b0;
        wire                            tcam_row_8_col_0_dftshiften = 'b0;
        wire                            tcam_row_8_col_0_dftmask = 'b0;
        wire                            tcam_row_8_col_0_dft_array_freeze = 'b0;
        wire                            tcam_row_8_col_0_dft_afd_reset_b = 'b0;
        wire      [32-1:0]    tcam_row_8_col_0_tdin = 'b0;
        wire      [7-1:0]     tcam_row_8_col_0_tadr = 'b0;
        wire                            tcam_row_8_col_0_tvbe = 'b0;
        wire                            tcam_row_8_col_0_tvbi = 'b0;
        wire      [32-1:0]    tcam_row_8_col_0_tmask = 'b0;
        wire                            tcam_row_8_col_0_twe = 'b0;
        wire                            tcam_row_8_col_0_tre = 'b0;
        wire                            tcam_row_8_col_0_tme = 'b0;
        wire                            tcam_row_8_col_0_bist_rotate_sr = 'b0;
        wire                            tcam_row_8_col_0_bist_en_sr_mask_b = 'b0;
        wire                            tcam_row_8_col_0_bist_all_mask = 'b0;
        wire                            tcam_row_8_col_0_bist_en_sr_data_b = 'b0;
        wire                            tcam_row_8_col_0_bist_cm_mode = 'b0;
        wire                            tcam_row_8_col_0_bist_cm_en_in = 'b0;
        wire                            tcam_row_8_col_0_bist_cm_match_sel0 = 'b0;
        wire                            tcam_row_8_col_0_bist_cm_match_sel1 = 'b0;
        wire                            tcam_row_8_col_0_bist_matchin_in = 'b0;
        wire                            tcam_row_8_col_0_bist_fls = 'b0;
        
        `else
        wire                            tcam_row_8_col_0_biste = 'b0;
        wire     [5-1:0]                  tcam_row_8_col_0_fca = 'b0;
        wire                            tcam_row_8_col_0_cre = 'b0;
        wire                            tcam_row_8_col_0_dftshiften = dftshiften;
        wire                            tcam_row_8_col_0_dftmask = dftmask;
        wire                            tcam_row_8_col_0_dft_array_freeze = dft_array_freeze;
        wire                            tcam_row_8_col_0_dft_afd_reset_b = dft_afd_reset_b;
        wire      [32-1:0]    tcam_row_8_col_0_tdin = 'b0;
        wire      [7-1:0]     tcam_row_8_col_0_tadr = 'b0;
        wire                            tcam_row_8_col_0_tvbe = 'b0;
        wire                            tcam_row_8_col_0_tvbi = 'b0;
        wire      [32-1:0]    tcam_row_8_col_0_tmask = 'b0;
        wire                            tcam_row_8_col_0_twe = 'b0;
        wire                            tcam_row_8_col_0_tre = 'b0;
        wire                            tcam_row_8_col_0_tme = 'b0;
        wire                            tcam_row_8_col_0_bist_rotate_sr = 'b0;
        wire                            tcam_row_8_col_0_bist_en_sr_mask_b = 'b0;
        wire                            tcam_row_8_col_0_bist_all_mask = 'b0;
        wire                            tcam_row_8_col_0_bist_en_sr_data_b = 'b0;
        wire                            tcam_row_8_col_0_bist_cm_mode = 'b0;
        wire                            tcam_row_8_col_0_bist_cm_en_in = 'b0;
        wire                            tcam_row_8_col_0_bist_cm_match_sel0 = 'b0;
        wire                            tcam_row_8_col_0_bist_cm_match_sel1 = 'b0;
        wire                            tcam_row_8_col_0_bist_matchin_in = 'b0;
        wire                            tcam_row_8_col_0_bist_fls = 'b0;
        `endif
        
        // Outputs
        logic                           tcam_row_8_col_0_wr_bira_fail;
        logic                           tcam_row_8_col_0_wr_so;
        logic                           tcam_row_8_col_0_curerrout;
        logic                           tcam_row_8_col_0_rscout;
        
        
        
        logic   [TCAM_SLICE_EN_FACT-1:0]                  tcam_row_8_col_0_slice_en_s0; 
        logic   [TCAM_SLICE_EN_FACT-1:0]                  tcam_row_8_col_0_slice_en_s1; 
        
        
        
             wire    [32-1:0]                     tcam_row_8_col_0_data_out ;
        
        
        
         generate
            if (BCAM_N7 == 0) 
              begin : gen_tcam_row_8_col_0_tcam
        
        
        // slice_en kept for TCAM only for backward compatability with Intel process
                always_comb 
                begin
                  for (int i = 0; i < TCAM_SLICE_EN_FACT; i++)
                      if (tcam_row_8_col_0_slice_en_s1[i])
                           tcam_row_8_col_0_hit_out[ i*64 +: 64]  = tcam_row_8_col_0_hit_out_int  [ i*64 +: 64]; 
                      else
                           tcam_row_8_col_0_hit_out[ i*64 +: 64]  = tcam_row_8_col_0_hit_out_latch[ i*64 +: 64]; 
                end
        
        
        
                always_ff  @(posedge tcam_row_8_col_0_clk)
                begin
                  tcam_row_8_col_0_slice_en_s0 <= tcam_row_8_col_0_slice_en; 
                  tcam_row_8_col_0_slice_en_s1 <= tcam_row_8_col_0_slice_en_s0; 
        
                  for (int i = 0; i < TCAM_SLICE_EN_FACT; i++)
                    begin
                      if (tcam_row_8_col_0_slice_en_s1[i])
                         tcam_row_8_col_0_hit_out_latch[ i*64 +: 64] <=  tcam_row_8_col_0_hit_out_int[ i*64 +: 64];
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
        
                     
                         assign tcam_row_8_col_0_data_out  = ~tcam_row_8_col_0_data_out_inv;
                         pcie_itp_ip783tcam64x32s0c1_8_0_wrap #(        
                                 )               
        
                                 ip783tcam64x32s0c1_wrap_tcam_row_8_col_0 (
                   //-------------------------------------------------------------
                   // Power Management Interfaces
                   //-------------------------------------------------------------   
                      `ifndef INTEL_NO_PWR_PINS
                      `ifdef INTC_ADD_VSS
                        .vss              (1'b0),
                      `endif
                        .vddp             (1'b1),
                      `endif
                         .ADR               (tcam_row_8_col_0_adr[7-1:1]), //Input adr_intess
                         .ME                (ce),  
        
                         .CLK               (tcam_row_8_col_0_clk), //Clock
                         .CMP               (tcam_row_8_col_0_chk_en), //Control Enable
                         .DIN               (~tcam_row_8_col_0_data_in), 
                         .DSEL              (~tcam_row_8_col_0_adr[0]), //dncen enables access of the TCAM Arrays adr_intessed
                         .FLS               (flush), //flush initiates a Flush operation that resets all Valid
                         .RVLD              (tcam_row_8_col_0_hit_in ), //Row validation bus. Each match_in input controls 1
                         .MASK              (tcam_row_8_col_0_mask_in), //Input msk
                         .QOUT              (tcam_row_8_col_0_data_out_inv), //Output vben
                         .QHR               (tcam_row_8_col_0_hit_out_int),
                         .QVLD              (), 
                         .RE                (tcam_row_8_col_0_rd_en), //Read Enable
                         .RST               (tcam_row_8_col_0_reset_n), //Asynchronous Active-High Reset
                         .VBE               (1'b1), //vben enables the Valid Bit addressed by adr[a-1:0] to
                         .VBI               (1'b0),//  Valid Bit Input
                         .WE                (tcam_row_8_col_0_wr_en), //Write Enable
                         .FAF               (tcam_row_8_col_0_fca),
                         .FAF_EN            (tcam_row_8_col_0_cre),
                         .DFTSHIFTEN        (tcam_row_8_col_0_dftshiften),
                         .DFTMASK           (tcam_row_8_col_0_dftmask),
                         .DFT_ARRAY_FREEZE  (tcam_row_8_col_0_dft_array_freeze),
                         .DFT_AFD_RESET_B   (tcam_row_8_col_0_dft_afd_reset_b),
                         .BISTE           (tcam_row_8_col_0_biste),
                         .TDIN (tcam_row_8_col_0_tdin),
                         .TADR (tcam_row_8_col_0_tadr),
                         .TVBE (tcam_row_8_col_0_tvbe),
                         .TVBI (tcam_row_8_col_0_tvbi),
                         .TMASK (tcam_row_8_col_0_tmask),
                         .TWE (tcam_row_8_col_0_twe),
                         .TRE (tcam_row_8_col_0_tre),
                         .TME (tcam_row_8_col_0_tme),
                         .BIST_ROTATE_SR (tcam_row_8_col_0_bist_rotate_sr),
                         .BIST_EN_SR_MASK_B (tcam_row_8_col_0_bist_en_sr_mask_b),
                         .BIST_ALL_MASK (tcam_row_8_col_0_bist_all_mask),
                         .BIST_EN_SR_DATA_B (tcam_row_8_col_0_bist_en_sr_data_b),
                         .BIST_CM_MODE (tcam_row_8_col_0_bist_cm_mode),
                         .BIST_CM_EN_IN (tcam_row_8_col_0_bist_cm_en_in),
                         .BIST_CM_MATCH_SEL0 (tcam_row_8_col_0_bist_cm_match_sel0),
                         .BIST_CM_MATCH_SEL1 (tcam_row_8_col_0_bist_cm_match_sel1),
                         .BIST_MATCHIN_IN (tcam_row_8_col_0_bist_matchin_in),
                         .BIST_FLS (tcam_row_8_col_0_bist_fls),
                         .MDST_tcam (fuse_tcam)
                     );
        
              end
              
            else
              begin : gen_tcam_row_8_col_0_bcam
              end
              
        
        
        endgenerate
        
        always_ff @(posedge clk) begin
                   tcam_rd_data_col[8][0]      <= tcam_row_8_col_0_data_out;
                   tcam_col_hit_out[8][0]       <= tcam_row_8_col_0_hit_out;
        end
        

        // this is new template - tcam_asic_template
        
        wire                                            tcam_row_8_col_1_clk         = clk;
        
        wire    [TCAM_SLICE_EN_FACT-1:0]                tcam_row_8_col_1_slice_en = TCAM_SLICE_EN_FACT'(slice_en[(8 * TCAM_SLICE_EN_FACT)+:TCAM_SLICE_EN_MIN]);
        
        wire                                            tcam_row_8_col_1_rd_en       = tcam_row_rd_en[8];
        wire                                            tcam_row_8_col_1_wr_en       = tcam_row_wr_en[8];
        wire                                            tcam_row_8_col_1_chk_en      = chk_en;
        wire                                            tcam_row_8_col_1_reset_n = reset_n;
        wire    [7-1:0]                       tcam_row_8_col_1_adr  = tcam_row_adr[8][7-1:0];
        wire    [32-1:0]                      tcam_row_8_col_1_data_in = tcam_row_wr_en[8] ? tcam_wr_data_col[1][32-1:0] : tcam_chk_key_col[1][32-1:0];
        wire    [32-1:0]                      tcam_row_8_col_1_data_in_pre = tcam_wr_data_col[1][32-1:0] ;
        wire    [32-1:0]                      tcam_row_8_col_1_key_in =  tcam_chk_key_col[1][32-1:0];
        wire    [32-1:0]                      tcam_row_8_col_1_mask_in = tcam_chk_mask_col[1][32-1:0];
        wire    [64-1:0]                       tcam_row_8_col_1_hit_in = tcam_raw_hit_in[8];
        wire    [64-1:0]                       tcam_row_8_col_1_tcam_match_in = tcam_row_match_in[8];
        wire    [32-1:0]                      tcam_row_8_col_1_data_out_inv;
        logic   [64-1:0]                     tcam_row_8_col_1_hit_out_int;
        logic   [64-1:0]                     tcam_row_8_col_1_hit_out_latch;
        logic   [64-1:0]                     tcam_row_8_col_1_hit_out;
        
        `ifdef HIF_PCIE_DFX_DISABLE
        wire                          tcam_row_8_col_1_biste = 'b0; 
        wire     [5-1:0]                  tcam_row_8_col_1_fca = 'b0;
        wire                            tcam_row_8_col_1_cre = 'b0;
        wire                            tcam_row_8_col_1_dftshiften = 'b0;
        wire                            tcam_row_8_col_1_dftmask = 'b0;
        wire                            tcam_row_8_col_1_dft_array_freeze = 'b0;
        wire                            tcam_row_8_col_1_dft_afd_reset_b = 'b0;
        wire      [32-1:0]    tcam_row_8_col_1_tdin = 'b0;
        wire      [7-1:0]     tcam_row_8_col_1_tadr = 'b0;
        wire                            tcam_row_8_col_1_tvbe = 'b0;
        wire                            tcam_row_8_col_1_tvbi = 'b0;
        wire      [32-1:0]    tcam_row_8_col_1_tmask = 'b0;
        wire                            tcam_row_8_col_1_twe = 'b0;
        wire                            tcam_row_8_col_1_tre = 'b0;
        wire                            tcam_row_8_col_1_tme = 'b0;
        wire                            tcam_row_8_col_1_bist_rotate_sr = 'b0;
        wire                            tcam_row_8_col_1_bist_en_sr_mask_b = 'b0;
        wire                            tcam_row_8_col_1_bist_all_mask = 'b0;
        wire                            tcam_row_8_col_1_bist_en_sr_data_b = 'b0;
        wire                            tcam_row_8_col_1_bist_cm_mode = 'b0;
        wire                            tcam_row_8_col_1_bist_cm_en_in = 'b0;
        wire                            tcam_row_8_col_1_bist_cm_match_sel0 = 'b0;
        wire                            tcam_row_8_col_1_bist_cm_match_sel1 = 'b0;
        wire                            tcam_row_8_col_1_bist_matchin_in = 'b0;
        wire                            tcam_row_8_col_1_bist_fls = 'b0;
        
        `else
        wire                            tcam_row_8_col_1_biste = 'b0;
        wire     [5-1:0]                  tcam_row_8_col_1_fca = 'b0;
        wire                            tcam_row_8_col_1_cre = 'b0;
        wire                            tcam_row_8_col_1_dftshiften = dftshiften;
        wire                            tcam_row_8_col_1_dftmask = dftmask;
        wire                            tcam_row_8_col_1_dft_array_freeze = dft_array_freeze;
        wire                            tcam_row_8_col_1_dft_afd_reset_b = dft_afd_reset_b;
        wire      [32-1:0]    tcam_row_8_col_1_tdin = 'b0;
        wire      [7-1:0]     tcam_row_8_col_1_tadr = 'b0;
        wire                            tcam_row_8_col_1_tvbe = 'b0;
        wire                            tcam_row_8_col_1_tvbi = 'b0;
        wire      [32-1:0]    tcam_row_8_col_1_tmask = 'b0;
        wire                            tcam_row_8_col_1_twe = 'b0;
        wire                            tcam_row_8_col_1_tre = 'b0;
        wire                            tcam_row_8_col_1_tme = 'b0;
        wire                            tcam_row_8_col_1_bist_rotate_sr = 'b0;
        wire                            tcam_row_8_col_1_bist_en_sr_mask_b = 'b0;
        wire                            tcam_row_8_col_1_bist_all_mask = 'b0;
        wire                            tcam_row_8_col_1_bist_en_sr_data_b = 'b0;
        wire                            tcam_row_8_col_1_bist_cm_mode = 'b0;
        wire                            tcam_row_8_col_1_bist_cm_en_in = 'b0;
        wire                            tcam_row_8_col_1_bist_cm_match_sel0 = 'b0;
        wire                            tcam_row_8_col_1_bist_cm_match_sel1 = 'b0;
        wire                            tcam_row_8_col_1_bist_matchin_in = 'b0;
        wire                            tcam_row_8_col_1_bist_fls = 'b0;
        `endif
        
        // Outputs
        logic                           tcam_row_8_col_1_wr_bira_fail;
        logic                           tcam_row_8_col_1_wr_so;
        logic                           tcam_row_8_col_1_curerrout;
        logic                           tcam_row_8_col_1_rscout;
        
        
        
        logic   [TCAM_SLICE_EN_FACT-1:0]                  tcam_row_8_col_1_slice_en_s0; 
        logic   [TCAM_SLICE_EN_FACT-1:0]                  tcam_row_8_col_1_slice_en_s1; 
        
        
        
             wire    [32-1:0]                     tcam_row_8_col_1_data_out ;
        
        
        
         generate
            if (BCAM_N7 == 0) 
              begin : gen_tcam_row_8_col_1_tcam
        
        
        // slice_en kept for TCAM only for backward compatability with Intel process
                always_comb 
                begin
                  for (int i = 0; i < TCAM_SLICE_EN_FACT; i++)
                      if (tcam_row_8_col_1_slice_en_s1[i])
                           tcam_row_8_col_1_hit_out[ i*64 +: 64]  = tcam_row_8_col_1_hit_out_int  [ i*64 +: 64]; 
                      else
                           tcam_row_8_col_1_hit_out[ i*64 +: 64]  = tcam_row_8_col_1_hit_out_latch[ i*64 +: 64]; 
                end
        
        
        
                always_ff  @(posedge tcam_row_8_col_1_clk)
                begin
                  tcam_row_8_col_1_slice_en_s0 <= tcam_row_8_col_1_slice_en; 
                  tcam_row_8_col_1_slice_en_s1 <= tcam_row_8_col_1_slice_en_s0; 
        
                  for (int i = 0; i < TCAM_SLICE_EN_FACT; i++)
                    begin
                      if (tcam_row_8_col_1_slice_en_s1[i])
                         tcam_row_8_col_1_hit_out_latch[ i*64 +: 64] <=  tcam_row_8_col_1_hit_out_int[ i*64 +: 64];
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
        
                     
                         assign tcam_row_8_col_1_data_out  = ~tcam_row_8_col_1_data_out_inv;
                         pcie_itp_ip783tcam64x32s0c1_8_1_wrap #(        
                                 )               
        
                                 ip783tcam64x32s0c1_wrap_tcam_row_8_col_1 (
                   //-------------------------------------------------------------
                   // Power Management Interfaces
                   //-------------------------------------------------------------   
                      `ifndef INTEL_NO_PWR_PINS
                      `ifdef INTC_ADD_VSS
                        .vss              (1'b0),
                      `endif
                        .vddp             (1'b1),
                      `endif
                         .ADR               (tcam_row_8_col_1_adr[7-1:1]), //Input adr_intess
                         .ME                (ce),  
        
                         .CLK               (tcam_row_8_col_1_clk), //Clock
                         .CMP               (tcam_row_8_col_1_chk_en), //Control Enable
                         .DIN               (~tcam_row_8_col_1_data_in), 
                         .DSEL              (~tcam_row_8_col_1_adr[0]), //dncen enables access of the TCAM Arrays adr_intessed
                         .FLS               (flush), //flush initiates a Flush operation that resets all Valid
                         .RVLD              (tcam_row_8_col_1_hit_in ), //Row validation bus. Each match_in input controls 1
                         .MASK              (tcam_row_8_col_1_mask_in), //Input msk
                         .QOUT              (tcam_row_8_col_1_data_out_inv), //Output vben
                         .QHR               (tcam_row_8_col_1_hit_out_int),
                         .QVLD              (), 
                         .RE                (tcam_row_8_col_1_rd_en), //Read Enable
                         .RST               (tcam_row_8_col_1_reset_n), //Asynchronous Active-High Reset
                         .VBE               (1'b1), //vben enables the Valid Bit addressed by adr[a-1:0] to
                         .VBI               (1'b0),//  Valid Bit Input
                         .WE                (tcam_row_8_col_1_wr_en), //Write Enable
                         .FAF               (tcam_row_8_col_1_fca),
                         .FAF_EN            (tcam_row_8_col_1_cre),
                         .DFTSHIFTEN        (tcam_row_8_col_1_dftshiften),
                         .DFTMASK           (tcam_row_8_col_1_dftmask),
                         .DFT_ARRAY_FREEZE  (tcam_row_8_col_1_dft_array_freeze),
                         .DFT_AFD_RESET_B   (tcam_row_8_col_1_dft_afd_reset_b),
                         .BISTE           (tcam_row_8_col_1_biste),
                         .TDIN (tcam_row_8_col_1_tdin),
                         .TADR (tcam_row_8_col_1_tadr),
                         .TVBE (tcam_row_8_col_1_tvbe),
                         .TVBI (tcam_row_8_col_1_tvbi),
                         .TMASK (tcam_row_8_col_1_tmask),
                         .TWE (tcam_row_8_col_1_twe),
                         .TRE (tcam_row_8_col_1_tre),
                         .TME (tcam_row_8_col_1_tme),
                         .BIST_ROTATE_SR (tcam_row_8_col_1_bist_rotate_sr),
                         .BIST_EN_SR_MASK_B (tcam_row_8_col_1_bist_en_sr_mask_b),
                         .BIST_ALL_MASK (tcam_row_8_col_1_bist_all_mask),
                         .BIST_EN_SR_DATA_B (tcam_row_8_col_1_bist_en_sr_data_b),
                         .BIST_CM_MODE (tcam_row_8_col_1_bist_cm_mode),
                         .BIST_CM_EN_IN (tcam_row_8_col_1_bist_cm_en_in),
                         .BIST_CM_MATCH_SEL0 (tcam_row_8_col_1_bist_cm_match_sel0),
                         .BIST_CM_MATCH_SEL1 (tcam_row_8_col_1_bist_cm_match_sel1),
                         .BIST_MATCHIN_IN (tcam_row_8_col_1_bist_matchin_in),
                         .BIST_FLS (tcam_row_8_col_1_bist_fls),
                         .MDST_tcam (fuse_tcam)
                     );
        
              end
              
            else
              begin : gen_tcam_row_8_col_1_bcam
              end
              
        
        
        endgenerate
        
        always_ff @(posedge clk) begin
                   tcam_rd_data_col[8][1]      <= tcam_row_8_col_1_data_out;
                   tcam_col_hit_out[8][1]       <= tcam_row_8_col_1_hit_out;
        end
        

        // this is new template - tcam_asic_template
        
        wire                                            tcam_row_9_col_0_clk         = clk;
        
        wire    [TCAM_SLICE_EN_FACT-1:0]                tcam_row_9_col_0_slice_en = TCAM_SLICE_EN_FACT'(slice_en[(9 * TCAM_SLICE_EN_FACT)+:TCAM_SLICE_EN_MIN]);
        
        wire                                            tcam_row_9_col_0_rd_en       = tcam_row_rd_en[9];
        wire                                            tcam_row_9_col_0_wr_en       = tcam_row_wr_en[9];
        wire                                            tcam_row_9_col_0_chk_en      = chk_en;
        wire                                            tcam_row_9_col_0_reset_n = reset_n;
        wire    [7-1:0]                       tcam_row_9_col_0_adr  = tcam_row_adr[9][7-1:0];
        wire    [32-1:0]                      tcam_row_9_col_0_data_in = tcam_row_wr_en[9] ? tcam_wr_data_col[0][32-1:0] : tcam_chk_key_col[0][32-1:0];
        wire    [32-1:0]                      tcam_row_9_col_0_data_in_pre = tcam_wr_data_col[0][32-1:0] ;
        wire    [32-1:0]                      tcam_row_9_col_0_key_in =  tcam_chk_key_col[0][32-1:0];
        wire    [32-1:0]                      tcam_row_9_col_0_mask_in = tcam_chk_mask_col[0][32-1:0];
        wire    [64-1:0]                       tcam_row_9_col_0_hit_in = tcam_raw_hit_in[9];
        wire    [64-1:0]                       tcam_row_9_col_0_tcam_match_in = tcam_row_match_in[9];
        wire    [32-1:0]                      tcam_row_9_col_0_data_out_inv;
        logic   [64-1:0]                     tcam_row_9_col_0_hit_out_int;
        logic   [64-1:0]                     tcam_row_9_col_0_hit_out_latch;
        logic   [64-1:0]                     tcam_row_9_col_0_hit_out;
        
        `ifdef HIF_PCIE_DFX_DISABLE
        wire                          tcam_row_9_col_0_biste = 'b0; 
        wire     [5-1:0]                  tcam_row_9_col_0_fca = 'b0;
        wire                            tcam_row_9_col_0_cre = 'b0;
        wire                            tcam_row_9_col_0_dftshiften = 'b0;
        wire                            tcam_row_9_col_0_dftmask = 'b0;
        wire                            tcam_row_9_col_0_dft_array_freeze = 'b0;
        wire                            tcam_row_9_col_0_dft_afd_reset_b = 'b0;
        wire      [32-1:0]    tcam_row_9_col_0_tdin = 'b0;
        wire      [7-1:0]     tcam_row_9_col_0_tadr = 'b0;
        wire                            tcam_row_9_col_0_tvbe = 'b0;
        wire                            tcam_row_9_col_0_tvbi = 'b0;
        wire      [32-1:0]    tcam_row_9_col_0_tmask = 'b0;
        wire                            tcam_row_9_col_0_twe = 'b0;
        wire                            tcam_row_9_col_0_tre = 'b0;
        wire                            tcam_row_9_col_0_tme = 'b0;
        wire                            tcam_row_9_col_0_bist_rotate_sr = 'b0;
        wire                            tcam_row_9_col_0_bist_en_sr_mask_b = 'b0;
        wire                            tcam_row_9_col_0_bist_all_mask = 'b0;
        wire                            tcam_row_9_col_0_bist_en_sr_data_b = 'b0;
        wire                            tcam_row_9_col_0_bist_cm_mode = 'b0;
        wire                            tcam_row_9_col_0_bist_cm_en_in = 'b0;
        wire                            tcam_row_9_col_0_bist_cm_match_sel0 = 'b0;
        wire                            tcam_row_9_col_0_bist_cm_match_sel1 = 'b0;
        wire                            tcam_row_9_col_0_bist_matchin_in = 'b0;
        wire                            tcam_row_9_col_0_bist_fls = 'b0;
        
        `else
        wire                            tcam_row_9_col_0_biste = 'b0;
        wire     [5-1:0]                  tcam_row_9_col_0_fca = 'b0;
        wire                            tcam_row_9_col_0_cre = 'b0;
        wire                            tcam_row_9_col_0_dftshiften = dftshiften;
        wire                            tcam_row_9_col_0_dftmask = dftmask;
        wire                            tcam_row_9_col_0_dft_array_freeze = dft_array_freeze;
        wire                            tcam_row_9_col_0_dft_afd_reset_b = dft_afd_reset_b;
        wire      [32-1:0]    tcam_row_9_col_0_tdin = 'b0;
        wire      [7-1:0]     tcam_row_9_col_0_tadr = 'b0;
        wire                            tcam_row_9_col_0_tvbe = 'b0;
        wire                            tcam_row_9_col_0_tvbi = 'b0;
        wire      [32-1:0]    tcam_row_9_col_0_tmask = 'b0;
        wire                            tcam_row_9_col_0_twe = 'b0;
        wire                            tcam_row_9_col_0_tre = 'b0;
        wire                            tcam_row_9_col_0_tme = 'b0;
        wire                            tcam_row_9_col_0_bist_rotate_sr = 'b0;
        wire                            tcam_row_9_col_0_bist_en_sr_mask_b = 'b0;
        wire                            tcam_row_9_col_0_bist_all_mask = 'b0;
        wire                            tcam_row_9_col_0_bist_en_sr_data_b = 'b0;
        wire                            tcam_row_9_col_0_bist_cm_mode = 'b0;
        wire                            tcam_row_9_col_0_bist_cm_en_in = 'b0;
        wire                            tcam_row_9_col_0_bist_cm_match_sel0 = 'b0;
        wire                            tcam_row_9_col_0_bist_cm_match_sel1 = 'b0;
        wire                            tcam_row_9_col_0_bist_matchin_in = 'b0;
        wire                            tcam_row_9_col_0_bist_fls = 'b0;
        `endif
        
        // Outputs
        logic                           tcam_row_9_col_0_wr_bira_fail;
        logic                           tcam_row_9_col_0_wr_so;
        logic                           tcam_row_9_col_0_curerrout;
        logic                           tcam_row_9_col_0_rscout;
        
        
        
        logic   [TCAM_SLICE_EN_FACT-1:0]                  tcam_row_9_col_0_slice_en_s0; 
        logic   [TCAM_SLICE_EN_FACT-1:0]                  tcam_row_9_col_0_slice_en_s1; 
        
        
        
             wire    [32-1:0]                     tcam_row_9_col_0_data_out ;
        
        
        
         generate
            if (BCAM_N7 == 0) 
              begin : gen_tcam_row_9_col_0_tcam
        
        
        // slice_en kept for TCAM only for backward compatability with Intel process
                always_comb 
                begin
                  for (int i = 0; i < TCAM_SLICE_EN_FACT; i++)
                      if (tcam_row_9_col_0_slice_en_s1[i])
                           tcam_row_9_col_0_hit_out[ i*64 +: 64]  = tcam_row_9_col_0_hit_out_int  [ i*64 +: 64]; 
                      else
                           tcam_row_9_col_0_hit_out[ i*64 +: 64]  = tcam_row_9_col_0_hit_out_latch[ i*64 +: 64]; 
                end
        
        
        
                always_ff  @(posedge tcam_row_9_col_0_clk)
                begin
                  tcam_row_9_col_0_slice_en_s0 <= tcam_row_9_col_0_slice_en; 
                  tcam_row_9_col_0_slice_en_s1 <= tcam_row_9_col_0_slice_en_s0; 
        
                  for (int i = 0; i < TCAM_SLICE_EN_FACT; i++)
                    begin
                      if (tcam_row_9_col_0_slice_en_s1[i])
                         tcam_row_9_col_0_hit_out_latch[ i*64 +: 64] <=  tcam_row_9_col_0_hit_out_int[ i*64 +: 64];
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
        
                     
                         assign tcam_row_9_col_0_data_out  = ~tcam_row_9_col_0_data_out_inv;
                         pcie_itp_ip783tcam64x32s0c1_9_0_wrap #(        
                                 )               
        
                                 ip783tcam64x32s0c1_wrap_tcam_row_9_col_0 (
                   //-------------------------------------------------------------
                   // Power Management Interfaces
                   //-------------------------------------------------------------   
                      `ifndef INTEL_NO_PWR_PINS
                      `ifdef INTC_ADD_VSS
                        .vss              (1'b0),
                      `endif
                        .vddp             (1'b1),
                      `endif
                         .ADR               (tcam_row_9_col_0_adr[7-1:1]), //Input adr_intess
                         .ME                (ce),  
        
                         .CLK               (tcam_row_9_col_0_clk), //Clock
                         .CMP               (tcam_row_9_col_0_chk_en), //Control Enable
                         .DIN               (~tcam_row_9_col_0_data_in), 
                         .DSEL              (~tcam_row_9_col_0_adr[0]), //dncen enables access of the TCAM Arrays adr_intessed
                         .FLS               (flush), //flush initiates a Flush operation that resets all Valid
                         .RVLD              (tcam_row_9_col_0_hit_in ), //Row validation bus. Each match_in input controls 1
                         .MASK              (tcam_row_9_col_0_mask_in), //Input msk
                         .QOUT              (tcam_row_9_col_0_data_out_inv), //Output vben
                         .QHR               (tcam_row_9_col_0_hit_out_int),
                         .QVLD              (), 
                         .RE                (tcam_row_9_col_0_rd_en), //Read Enable
                         .RST               (tcam_row_9_col_0_reset_n), //Asynchronous Active-High Reset
                         .VBE               (1'b1), //vben enables the Valid Bit addressed by adr[a-1:0] to
                         .VBI               (1'b0),//  Valid Bit Input
                         .WE                (tcam_row_9_col_0_wr_en), //Write Enable
                         .FAF               (tcam_row_9_col_0_fca),
                         .FAF_EN            (tcam_row_9_col_0_cre),
                         .DFTSHIFTEN        (tcam_row_9_col_0_dftshiften),
                         .DFTMASK           (tcam_row_9_col_0_dftmask),
                         .DFT_ARRAY_FREEZE  (tcam_row_9_col_0_dft_array_freeze),
                         .DFT_AFD_RESET_B   (tcam_row_9_col_0_dft_afd_reset_b),
                         .BISTE           (tcam_row_9_col_0_biste),
                         .TDIN (tcam_row_9_col_0_tdin),
                         .TADR (tcam_row_9_col_0_tadr),
                         .TVBE (tcam_row_9_col_0_tvbe),
                         .TVBI (tcam_row_9_col_0_tvbi),
                         .TMASK (tcam_row_9_col_0_tmask),
                         .TWE (tcam_row_9_col_0_twe),
                         .TRE (tcam_row_9_col_0_tre),
                         .TME (tcam_row_9_col_0_tme),
                         .BIST_ROTATE_SR (tcam_row_9_col_0_bist_rotate_sr),
                         .BIST_EN_SR_MASK_B (tcam_row_9_col_0_bist_en_sr_mask_b),
                         .BIST_ALL_MASK (tcam_row_9_col_0_bist_all_mask),
                         .BIST_EN_SR_DATA_B (tcam_row_9_col_0_bist_en_sr_data_b),
                         .BIST_CM_MODE (tcam_row_9_col_0_bist_cm_mode),
                         .BIST_CM_EN_IN (tcam_row_9_col_0_bist_cm_en_in),
                         .BIST_CM_MATCH_SEL0 (tcam_row_9_col_0_bist_cm_match_sel0),
                         .BIST_CM_MATCH_SEL1 (tcam_row_9_col_0_bist_cm_match_sel1),
                         .BIST_MATCHIN_IN (tcam_row_9_col_0_bist_matchin_in),
                         .BIST_FLS (tcam_row_9_col_0_bist_fls),
                         .MDST_tcam (fuse_tcam)
                     );
        
              end
              
            else
              begin : gen_tcam_row_9_col_0_bcam
              end
              
        
        
        endgenerate
        
        always_ff @(posedge clk) begin
                   tcam_rd_data_col[9][0]      <= tcam_row_9_col_0_data_out;
                   tcam_col_hit_out[9][0]       <= tcam_row_9_col_0_hit_out;
        end
        

        // this is new template - tcam_asic_template
        
        wire                                            tcam_row_9_col_1_clk         = clk;
        
        wire    [TCAM_SLICE_EN_FACT-1:0]                tcam_row_9_col_1_slice_en = TCAM_SLICE_EN_FACT'(slice_en[(9 * TCAM_SLICE_EN_FACT)+:TCAM_SLICE_EN_MIN]);
        
        wire                                            tcam_row_9_col_1_rd_en       = tcam_row_rd_en[9];
        wire                                            tcam_row_9_col_1_wr_en       = tcam_row_wr_en[9];
        wire                                            tcam_row_9_col_1_chk_en      = chk_en;
        wire                                            tcam_row_9_col_1_reset_n = reset_n;
        wire    [7-1:0]                       tcam_row_9_col_1_adr  = tcam_row_adr[9][7-1:0];
        wire    [32-1:0]                      tcam_row_9_col_1_data_in = tcam_row_wr_en[9] ? tcam_wr_data_col[1][32-1:0] : tcam_chk_key_col[1][32-1:0];
        wire    [32-1:0]                      tcam_row_9_col_1_data_in_pre = tcam_wr_data_col[1][32-1:0] ;
        wire    [32-1:0]                      tcam_row_9_col_1_key_in =  tcam_chk_key_col[1][32-1:0];
        wire    [32-1:0]                      tcam_row_9_col_1_mask_in = tcam_chk_mask_col[1][32-1:0];
        wire    [64-1:0]                       tcam_row_9_col_1_hit_in = tcam_raw_hit_in[9];
        wire    [64-1:0]                       tcam_row_9_col_1_tcam_match_in = tcam_row_match_in[9];
        wire    [32-1:0]                      tcam_row_9_col_1_data_out_inv;
        logic   [64-1:0]                     tcam_row_9_col_1_hit_out_int;
        logic   [64-1:0]                     tcam_row_9_col_1_hit_out_latch;
        logic   [64-1:0]                     tcam_row_9_col_1_hit_out;
        
        `ifdef HIF_PCIE_DFX_DISABLE
        wire                          tcam_row_9_col_1_biste = 'b0; 
        wire     [5-1:0]                  tcam_row_9_col_1_fca = 'b0;
        wire                            tcam_row_9_col_1_cre = 'b0;
        wire                            tcam_row_9_col_1_dftshiften = 'b0;
        wire                            tcam_row_9_col_1_dftmask = 'b0;
        wire                            tcam_row_9_col_1_dft_array_freeze = 'b0;
        wire                            tcam_row_9_col_1_dft_afd_reset_b = 'b0;
        wire      [32-1:0]    tcam_row_9_col_1_tdin = 'b0;
        wire      [7-1:0]     tcam_row_9_col_1_tadr = 'b0;
        wire                            tcam_row_9_col_1_tvbe = 'b0;
        wire                            tcam_row_9_col_1_tvbi = 'b0;
        wire      [32-1:0]    tcam_row_9_col_1_tmask = 'b0;
        wire                            tcam_row_9_col_1_twe = 'b0;
        wire                            tcam_row_9_col_1_tre = 'b0;
        wire                            tcam_row_9_col_1_tme = 'b0;
        wire                            tcam_row_9_col_1_bist_rotate_sr = 'b0;
        wire                            tcam_row_9_col_1_bist_en_sr_mask_b = 'b0;
        wire                            tcam_row_9_col_1_bist_all_mask = 'b0;
        wire                            tcam_row_9_col_1_bist_en_sr_data_b = 'b0;
        wire                            tcam_row_9_col_1_bist_cm_mode = 'b0;
        wire                            tcam_row_9_col_1_bist_cm_en_in = 'b0;
        wire                            tcam_row_9_col_1_bist_cm_match_sel0 = 'b0;
        wire                            tcam_row_9_col_1_bist_cm_match_sel1 = 'b0;
        wire                            tcam_row_9_col_1_bist_matchin_in = 'b0;
        wire                            tcam_row_9_col_1_bist_fls = 'b0;
        
        `else
        wire                            tcam_row_9_col_1_biste = 'b0;
        wire     [5-1:0]                  tcam_row_9_col_1_fca = 'b0;
        wire                            tcam_row_9_col_1_cre = 'b0;
        wire                            tcam_row_9_col_1_dftshiften = dftshiften;
        wire                            tcam_row_9_col_1_dftmask = dftmask;
        wire                            tcam_row_9_col_1_dft_array_freeze = dft_array_freeze;
        wire                            tcam_row_9_col_1_dft_afd_reset_b = dft_afd_reset_b;
        wire      [32-1:0]    tcam_row_9_col_1_tdin = 'b0;
        wire      [7-1:0]     tcam_row_9_col_1_tadr = 'b0;
        wire                            tcam_row_9_col_1_tvbe = 'b0;
        wire                            tcam_row_9_col_1_tvbi = 'b0;
        wire      [32-1:0]    tcam_row_9_col_1_tmask = 'b0;
        wire                            tcam_row_9_col_1_twe = 'b0;
        wire                            tcam_row_9_col_1_tre = 'b0;
        wire                            tcam_row_9_col_1_tme = 'b0;
        wire                            tcam_row_9_col_1_bist_rotate_sr = 'b0;
        wire                            tcam_row_9_col_1_bist_en_sr_mask_b = 'b0;
        wire                            tcam_row_9_col_1_bist_all_mask = 'b0;
        wire                            tcam_row_9_col_1_bist_en_sr_data_b = 'b0;
        wire                            tcam_row_9_col_1_bist_cm_mode = 'b0;
        wire                            tcam_row_9_col_1_bist_cm_en_in = 'b0;
        wire                            tcam_row_9_col_1_bist_cm_match_sel0 = 'b0;
        wire                            tcam_row_9_col_1_bist_cm_match_sel1 = 'b0;
        wire                            tcam_row_9_col_1_bist_matchin_in = 'b0;
        wire                            tcam_row_9_col_1_bist_fls = 'b0;
        `endif
        
        // Outputs
        logic                           tcam_row_9_col_1_wr_bira_fail;
        logic                           tcam_row_9_col_1_wr_so;
        logic                           tcam_row_9_col_1_curerrout;
        logic                           tcam_row_9_col_1_rscout;
        
        
        
        logic   [TCAM_SLICE_EN_FACT-1:0]                  tcam_row_9_col_1_slice_en_s0; 
        logic   [TCAM_SLICE_EN_FACT-1:0]                  tcam_row_9_col_1_slice_en_s1; 
        
        
        
             wire    [32-1:0]                     tcam_row_9_col_1_data_out ;
        
        
        
         generate
            if (BCAM_N7 == 0) 
              begin : gen_tcam_row_9_col_1_tcam
        
        
        // slice_en kept for TCAM only for backward compatability with Intel process
                always_comb 
                begin
                  for (int i = 0; i < TCAM_SLICE_EN_FACT; i++)
                      if (tcam_row_9_col_1_slice_en_s1[i])
                           tcam_row_9_col_1_hit_out[ i*64 +: 64]  = tcam_row_9_col_1_hit_out_int  [ i*64 +: 64]; 
                      else
                           tcam_row_9_col_1_hit_out[ i*64 +: 64]  = tcam_row_9_col_1_hit_out_latch[ i*64 +: 64]; 
                end
        
        
        
                always_ff  @(posedge tcam_row_9_col_1_clk)
                begin
                  tcam_row_9_col_1_slice_en_s0 <= tcam_row_9_col_1_slice_en; 
                  tcam_row_9_col_1_slice_en_s1 <= tcam_row_9_col_1_slice_en_s0; 
        
                  for (int i = 0; i < TCAM_SLICE_EN_FACT; i++)
                    begin
                      if (tcam_row_9_col_1_slice_en_s1[i])
                         tcam_row_9_col_1_hit_out_latch[ i*64 +: 64] <=  tcam_row_9_col_1_hit_out_int[ i*64 +: 64];
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
        
                     
                         assign tcam_row_9_col_1_data_out  = ~tcam_row_9_col_1_data_out_inv;
                         pcie_itp_ip783tcam64x32s0c1_9_1_wrap #(        
                                 )               
        
                                 ip783tcam64x32s0c1_wrap_tcam_row_9_col_1 (
                   //-------------------------------------------------------------
                   // Power Management Interfaces
                   //-------------------------------------------------------------   
                      `ifndef INTEL_NO_PWR_PINS
                      `ifdef INTC_ADD_VSS
                        .vss              (1'b0),
                      `endif
                        .vddp             (1'b1),
                      `endif
                         .ADR               (tcam_row_9_col_1_adr[7-1:1]), //Input adr_intess
                         .ME                (ce),  
        
                         .CLK               (tcam_row_9_col_1_clk), //Clock
                         .CMP               (tcam_row_9_col_1_chk_en), //Control Enable
                         .DIN               (~tcam_row_9_col_1_data_in), 
                         .DSEL              (~tcam_row_9_col_1_adr[0]), //dncen enables access of the TCAM Arrays adr_intessed
                         .FLS               (flush), //flush initiates a Flush operation that resets all Valid
                         .RVLD              (tcam_row_9_col_1_hit_in ), //Row validation bus. Each match_in input controls 1
                         .MASK              (tcam_row_9_col_1_mask_in), //Input msk
                         .QOUT              (tcam_row_9_col_1_data_out_inv), //Output vben
                         .QHR               (tcam_row_9_col_1_hit_out_int),
                         .QVLD              (), 
                         .RE                (tcam_row_9_col_1_rd_en), //Read Enable
                         .RST               (tcam_row_9_col_1_reset_n), //Asynchronous Active-High Reset
                         .VBE               (1'b1), //vben enables the Valid Bit addressed by adr[a-1:0] to
                         .VBI               (1'b0),//  Valid Bit Input
                         .WE                (tcam_row_9_col_1_wr_en), //Write Enable
                         .FAF               (tcam_row_9_col_1_fca),
                         .FAF_EN            (tcam_row_9_col_1_cre),
                         .DFTSHIFTEN        (tcam_row_9_col_1_dftshiften),
                         .DFTMASK           (tcam_row_9_col_1_dftmask),
                         .DFT_ARRAY_FREEZE  (tcam_row_9_col_1_dft_array_freeze),
                         .DFT_AFD_RESET_B   (tcam_row_9_col_1_dft_afd_reset_b),
                         .BISTE           (tcam_row_9_col_1_biste),
                         .TDIN (tcam_row_9_col_1_tdin),
                         .TADR (tcam_row_9_col_1_tadr),
                         .TVBE (tcam_row_9_col_1_tvbe),
                         .TVBI (tcam_row_9_col_1_tvbi),
                         .TMASK (tcam_row_9_col_1_tmask),
                         .TWE (tcam_row_9_col_1_twe),
                         .TRE (tcam_row_9_col_1_tre),
                         .TME (tcam_row_9_col_1_tme),
                         .BIST_ROTATE_SR (tcam_row_9_col_1_bist_rotate_sr),
                         .BIST_EN_SR_MASK_B (tcam_row_9_col_1_bist_en_sr_mask_b),
                         .BIST_ALL_MASK (tcam_row_9_col_1_bist_all_mask),
                         .BIST_EN_SR_DATA_B (tcam_row_9_col_1_bist_en_sr_data_b),
                         .BIST_CM_MODE (tcam_row_9_col_1_bist_cm_mode),
                         .BIST_CM_EN_IN (tcam_row_9_col_1_bist_cm_en_in),
                         .BIST_CM_MATCH_SEL0 (tcam_row_9_col_1_bist_cm_match_sel0),
                         .BIST_CM_MATCH_SEL1 (tcam_row_9_col_1_bist_cm_match_sel1),
                         .BIST_MATCHIN_IN (tcam_row_9_col_1_bist_matchin_in),
                         .BIST_FLS (tcam_row_9_col_1_bist_fls),
                         .MDST_tcam (fuse_tcam)
                     );
        
              end
              
            else
              begin : gen_tcam_row_9_col_1_bcam
              end
              
        
        
        endgenerate
        
        always_ff @(posedge clk) begin
                   tcam_rd_data_col[9][1]      <= tcam_row_9_col_1_data_out;
                   tcam_col_hit_out[9][1]       <= tcam_row_9_col_1_hit_out;
        end
        

        // this is new template - tcam_asic_template
        
        wire                                            tcam_row_10_col_0_clk         = clk;
        
        wire    [TCAM_SLICE_EN_FACT-1:0]                tcam_row_10_col_0_slice_en = TCAM_SLICE_EN_FACT'(slice_en[(10 * TCAM_SLICE_EN_FACT)+:TCAM_SLICE_EN_MIN]);
        
        wire                                            tcam_row_10_col_0_rd_en       = tcam_row_rd_en[10];
        wire                                            tcam_row_10_col_0_wr_en       = tcam_row_wr_en[10];
        wire                                            tcam_row_10_col_0_chk_en      = chk_en;
        wire                                            tcam_row_10_col_0_reset_n = reset_n;
        wire    [7-1:0]                       tcam_row_10_col_0_adr  = tcam_row_adr[10][7-1:0];
        wire    [32-1:0]                      tcam_row_10_col_0_data_in = tcam_row_wr_en[10] ? tcam_wr_data_col[0][32-1:0] : tcam_chk_key_col[0][32-1:0];
        wire    [32-1:0]                      tcam_row_10_col_0_data_in_pre = tcam_wr_data_col[0][32-1:0] ;
        wire    [32-1:0]                      tcam_row_10_col_0_key_in =  tcam_chk_key_col[0][32-1:0];
        wire    [32-1:0]                      tcam_row_10_col_0_mask_in = tcam_chk_mask_col[0][32-1:0];
        wire    [64-1:0]                       tcam_row_10_col_0_hit_in = tcam_raw_hit_in[10];
        wire    [64-1:0]                       tcam_row_10_col_0_tcam_match_in = tcam_row_match_in[10];
        wire    [32-1:0]                      tcam_row_10_col_0_data_out_inv;
        logic   [64-1:0]                     tcam_row_10_col_0_hit_out_int;
        logic   [64-1:0]                     tcam_row_10_col_0_hit_out_latch;
        logic   [64-1:0]                     tcam_row_10_col_0_hit_out;
        
        `ifdef HIF_PCIE_DFX_DISABLE
        wire                          tcam_row_10_col_0_biste = 'b0; 
        wire     [5-1:0]                  tcam_row_10_col_0_fca = 'b0;
        wire                            tcam_row_10_col_0_cre = 'b0;
        wire                            tcam_row_10_col_0_dftshiften = 'b0;
        wire                            tcam_row_10_col_0_dftmask = 'b0;
        wire                            tcam_row_10_col_0_dft_array_freeze = 'b0;
        wire                            tcam_row_10_col_0_dft_afd_reset_b = 'b0;
        wire      [32-1:0]    tcam_row_10_col_0_tdin = 'b0;
        wire      [7-1:0]     tcam_row_10_col_0_tadr = 'b0;
        wire                            tcam_row_10_col_0_tvbe = 'b0;
        wire                            tcam_row_10_col_0_tvbi = 'b0;
        wire      [32-1:0]    tcam_row_10_col_0_tmask = 'b0;
        wire                            tcam_row_10_col_0_twe = 'b0;
        wire                            tcam_row_10_col_0_tre = 'b0;
        wire                            tcam_row_10_col_0_tme = 'b0;
        wire                            tcam_row_10_col_0_bist_rotate_sr = 'b0;
        wire                            tcam_row_10_col_0_bist_en_sr_mask_b = 'b0;
        wire                            tcam_row_10_col_0_bist_all_mask = 'b0;
        wire                            tcam_row_10_col_0_bist_en_sr_data_b = 'b0;
        wire                            tcam_row_10_col_0_bist_cm_mode = 'b0;
        wire                            tcam_row_10_col_0_bist_cm_en_in = 'b0;
        wire                            tcam_row_10_col_0_bist_cm_match_sel0 = 'b0;
        wire                            tcam_row_10_col_0_bist_cm_match_sel1 = 'b0;
        wire                            tcam_row_10_col_0_bist_matchin_in = 'b0;
        wire                            tcam_row_10_col_0_bist_fls = 'b0;
        
        `else
        wire                            tcam_row_10_col_0_biste = 'b0;
        wire     [5-1:0]                  tcam_row_10_col_0_fca = 'b0;
        wire                            tcam_row_10_col_0_cre = 'b0;
        wire                            tcam_row_10_col_0_dftshiften = dftshiften;
        wire                            tcam_row_10_col_0_dftmask = dftmask;
        wire                            tcam_row_10_col_0_dft_array_freeze = dft_array_freeze;
        wire                            tcam_row_10_col_0_dft_afd_reset_b = dft_afd_reset_b;
        wire      [32-1:0]    tcam_row_10_col_0_tdin = 'b0;
        wire      [7-1:0]     tcam_row_10_col_0_tadr = 'b0;
        wire                            tcam_row_10_col_0_tvbe = 'b0;
        wire                            tcam_row_10_col_0_tvbi = 'b0;
        wire      [32-1:0]    tcam_row_10_col_0_tmask = 'b0;
        wire                            tcam_row_10_col_0_twe = 'b0;
        wire                            tcam_row_10_col_0_tre = 'b0;
        wire                            tcam_row_10_col_0_tme = 'b0;
        wire                            tcam_row_10_col_0_bist_rotate_sr = 'b0;
        wire                            tcam_row_10_col_0_bist_en_sr_mask_b = 'b0;
        wire                            tcam_row_10_col_0_bist_all_mask = 'b0;
        wire                            tcam_row_10_col_0_bist_en_sr_data_b = 'b0;
        wire                            tcam_row_10_col_0_bist_cm_mode = 'b0;
        wire                            tcam_row_10_col_0_bist_cm_en_in = 'b0;
        wire                            tcam_row_10_col_0_bist_cm_match_sel0 = 'b0;
        wire                            tcam_row_10_col_0_bist_cm_match_sel1 = 'b0;
        wire                            tcam_row_10_col_0_bist_matchin_in = 'b0;
        wire                            tcam_row_10_col_0_bist_fls = 'b0;
        `endif
        
        // Outputs
        logic                           tcam_row_10_col_0_wr_bira_fail;
        logic                           tcam_row_10_col_0_wr_so;
        logic                           tcam_row_10_col_0_curerrout;
        logic                           tcam_row_10_col_0_rscout;
        
        
        
        logic   [TCAM_SLICE_EN_FACT-1:0]                  tcam_row_10_col_0_slice_en_s0; 
        logic   [TCAM_SLICE_EN_FACT-1:0]                  tcam_row_10_col_0_slice_en_s1; 
        
        
        
             wire    [32-1:0]                     tcam_row_10_col_0_data_out ;
        
        
        
         generate
            if (BCAM_N7 == 0) 
              begin : gen_tcam_row_10_col_0_tcam
        
        
        // slice_en kept for TCAM only for backward compatability with Intel process
                always_comb 
                begin
                  for (int i = 0; i < TCAM_SLICE_EN_FACT; i++)
                      if (tcam_row_10_col_0_slice_en_s1[i])
                           tcam_row_10_col_0_hit_out[ i*64 +: 64]  = tcam_row_10_col_0_hit_out_int  [ i*64 +: 64]; 
                      else
                           tcam_row_10_col_0_hit_out[ i*64 +: 64]  = tcam_row_10_col_0_hit_out_latch[ i*64 +: 64]; 
                end
        
        
        
                always_ff  @(posedge tcam_row_10_col_0_clk)
                begin
                  tcam_row_10_col_0_slice_en_s0 <= tcam_row_10_col_0_slice_en; 
                  tcam_row_10_col_0_slice_en_s1 <= tcam_row_10_col_0_slice_en_s0; 
        
                  for (int i = 0; i < TCAM_SLICE_EN_FACT; i++)
                    begin
                      if (tcam_row_10_col_0_slice_en_s1[i])
                         tcam_row_10_col_0_hit_out_latch[ i*64 +: 64] <=  tcam_row_10_col_0_hit_out_int[ i*64 +: 64];
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
        
                     
                         assign tcam_row_10_col_0_data_out  = ~tcam_row_10_col_0_data_out_inv;
                         pcie_itp_ip783tcam64x32s0c1_10_0_wrap #(        
                                 )               
        
                                 ip783tcam64x32s0c1_wrap_tcam_row_10_col_0 (
                   //-------------------------------------------------------------
                   // Power Management Interfaces
                   //-------------------------------------------------------------   
                      `ifndef INTEL_NO_PWR_PINS
                      `ifdef INTC_ADD_VSS
                        .vss              (1'b0),
                      `endif
                        .vddp             (1'b1),
                      `endif
                         .ADR               (tcam_row_10_col_0_adr[7-1:1]), //Input adr_intess
                         .ME                (ce),  
        
                         .CLK               (tcam_row_10_col_0_clk), //Clock
                         .CMP               (tcam_row_10_col_0_chk_en), //Control Enable
                         .DIN               (~tcam_row_10_col_0_data_in), 
                         .DSEL              (~tcam_row_10_col_0_adr[0]), //dncen enables access of the TCAM Arrays adr_intessed
                         .FLS               (flush), //flush initiates a Flush operation that resets all Valid
                         .RVLD              (tcam_row_10_col_0_hit_in ), //Row validation bus. Each match_in input controls 1
                         .MASK              (tcam_row_10_col_0_mask_in), //Input msk
                         .QOUT              (tcam_row_10_col_0_data_out_inv), //Output vben
                         .QHR               (tcam_row_10_col_0_hit_out_int),
                         .QVLD              (), 
                         .RE                (tcam_row_10_col_0_rd_en), //Read Enable
                         .RST               (tcam_row_10_col_0_reset_n), //Asynchronous Active-High Reset
                         .VBE               (1'b1), //vben enables the Valid Bit addressed by adr[a-1:0] to
                         .VBI               (1'b0),//  Valid Bit Input
                         .WE                (tcam_row_10_col_0_wr_en), //Write Enable
                         .FAF               (tcam_row_10_col_0_fca),
                         .FAF_EN            (tcam_row_10_col_0_cre),
                         .DFTSHIFTEN        (tcam_row_10_col_0_dftshiften),
                         .DFTMASK           (tcam_row_10_col_0_dftmask),
                         .DFT_ARRAY_FREEZE  (tcam_row_10_col_0_dft_array_freeze),
                         .DFT_AFD_RESET_B   (tcam_row_10_col_0_dft_afd_reset_b),
                         .BISTE           (tcam_row_10_col_0_biste),
                         .TDIN (tcam_row_10_col_0_tdin),
                         .TADR (tcam_row_10_col_0_tadr),
                         .TVBE (tcam_row_10_col_0_tvbe),
                         .TVBI (tcam_row_10_col_0_tvbi),
                         .TMASK (tcam_row_10_col_0_tmask),
                         .TWE (tcam_row_10_col_0_twe),
                         .TRE (tcam_row_10_col_0_tre),
                         .TME (tcam_row_10_col_0_tme),
                         .BIST_ROTATE_SR (tcam_row_10_col_0_bist_rotate_sr),
                         .BIST_EN_SR_MASK_B (tcam_row_10_col_0_bist_en_sr_mask_b),
                         .BIST_ALL_MASK (tcam_row_10_col_0_bist_all_mask),
                         .BIST_EN_SR_DATA_B (tcam_row_10_col_0_bist_en_sr_data_b),
                         .BIST_CM_MODE (tcam_row_10_col_0_bist_cm_mode),
                         .BIST_CM_EN_IN (tcam_row_10_col_0_bist_cm_en_in),
                         .BIST_CM_MATCH_SEL0 (tcam_row_10_col_0_bist_cm_match_sel0),
                         .BIST_CM_MATCH_SEL1 (tcam_row_10_col_0_bist_cm_match_sel1),
                         .BIST_MATCHIN_IN (tcam_row_10_col_0_bist_matchin_in),
                         .BIST_FLS (tcam_row_10_col_0_bist_fls),
                         .MDST_tcam (fuse_tcam)
                     );
        
              end
              
            else
              begin : gen_tcam_row_10_col_0_bcam
              end
              
        
        
        endgenerate
        
        always_ff @(posedge clk) begin
                   tcam_rd_data_col[10][0]      <= tcam_row_10_col_0_data_out;
                   tcam_col_hit_out[10][0]       <= tcam_row_10_col_0_hit_out;
        end
        

        // this is new template - tcam_asic_template
        
        wire                                            tcam_row_10_col_1_clk         = clk;
        
        wire    [TCAM_SLICE_EN_FACT-1:0]                tcam_row_10_col_1_slice_en = TCAM_SLICE_EN_FACT'(slice_en[(10 * TCAM_SLICE_EN_FACT)+:TCAM_SLICE_EN_MIN]);
        
        wire                                            tcam_row_10_col_1_rd_en       = tcam_row_rd_en[10];
        wire                                            tcam_row_10_col_1_wr_en       = tcam_row_wr_en[10];
        wire                                            tcam_row_10_col_1_chk_en      = chk_en;
        wire                                            tcam_row_10_col_1_reset_n = reset_n;
        wire    [7-1:0]                       tcam_row_10_col_1_adr  = tcam_row_adr[10][7-1:0];
        wire    [32-1:0]                      tcam_row_10_col_1_data_in = tcam_row_wr_en[10] ? tcam_wr_data_col[1][32-1:0] : tcam_chk_key_col[1][32-1:0];
        wire    [32-1:0]                      tcam_row_10_col_1_data_in_pre = tcam_wr_data_col[1][32-1:0] ;
        wire    [32-1:0]                      tcam_row_10_col_1_key_in =  tcam_chk_key_col[1][32-1:0];
        wire    [32-1:0]                      tcam_row_10_col_1_mask_in = tcam_chk_mask_col[1][32-1:0];
        wire    [64-1:0]                       tcam_row_10_col_1_hit_in = tcam_raw_hit_in[10];
        wire    [64-1:0]                       tcam_row_10_col_1_tcam_match_in = tcam_row_match_in[10];
        wire    [32-1:0]                      tcam_row_10_col_1_data_out_inv;
        logic   [64-1:0]                     tcam_row_10_col_1_hit_out_int;
        logic   [64-1:0]                     tcam_row_10_col_1_hit_out_latch;
        logic   [64-1:0]                     tcam_row_10_col_1_hit_out;
        
        `ifdef HIF_PCIE_DFX_DISABLE
        wire                          tcam_row_10_col_1_biste = 'b0; 
        wire     [5-1:0]                  tcam_row_10_col_1_fca = 'b0;
        wire                            tcam_row_10_col_1_cre = 'b0;
        wire                            tcam_row_10_col_1_dftshiften = 'b0;
        wire                            tcam_row_10_col_1_dftmask = 'b0;
        wire                            tcam_row_10_col_1_dft_array_freeze = 'b0;
        wire                            tcam_row_10_col_1_dft_afd_reset_b = 'b0;
        wire      [32-1:0]    tcam_row_10_col_1_tdin = 'b0;
        wire      [7-1:0]     tcam_row_10_col_1_tadr = 'b0;
        wire                            tcam_row_10_col_1_tvbe = 'b0;
        wire                            tcam_row_10_col_1_tvbi = 'b0;
        wire      [32-1:0]    tcam_row_10_col_1_tmask = 'b0;
        wire                            tcam_row_10_col_1_twe = 'b0;
        wire                            tcam_row_10_col_1_tre = 'b0;
        wire                            tcam_row_10_col_1_tme = 'b0;
        wire                            tcam_row_10_col_1_bist_rotate_sr = 'b0;
        wire                            tcam_row_10_col_1_bist_en_sr_mask_b = 'b0;
        wire                            tcam_row_10_col_1_bist_all_mask = 'b0;
        wire                            tcam_row_10_col_1_bist_en_sr_data_b = 'b0;
        wire                            tcam_row_10_col_1_bist_cm_mode = 'b0;
        wire                            tcam_row_10_col_1_bist_cm_en_in = 'b0;
        wire                            tcam_row_10_col_1_bist_cm_match_sel0 = 'b0;
        wire                            tcam_row_10_col_1_bist_cm_match_sel1 = 'b0;
        wire                            tcam_row_10_col_1_bist_matchin_in = 'b0;
        wire                            tcam_row_10_col_1_bist_fls = 'b0;
        
        `else
        wire                            tcam_row_10_col_1_biste = 'b0;
        wire     [5-1:0]                  tcam_row_10_col_1_fca = 'b0;
        wire                            tcam_row_10_col_1_cre = 'b0;
        wire                            tcam_row_10_col_1_dftshiften = dftshiften;
        wire                            tcam_row_10_col_1_dftmask = dftmask;
        wire                            tcam_row_10_col_1_dft_array_freeze = dft_array_freeze;
        wire                            tcam_row_10_col_1_dft_afd_reset_b = dft_afd_reset_b;
        wire      [32-1:0]    tcam_row_10_col_1_tdin = 'b0;
        wire      [7-1:0]     tcam_row_10_col_1_tadr = 'b0;
        wire                            tcam_row_10_col_1_tvbe = 'b0;
        wire                            tcam_row_10_col_1_tvbi = 'b0;
        wire      [32-1:0]    tcam_row_10_col_1_tmask = 'b0;
        wire                            tcam_row_10_col_1_twe = 'b0;
        wire                            tcam_row_10_col_1_tre = 'b0;
        wire                            tcam_row_10_col_1_tme = 'b0;
        wire                            tcam_row_10_col_1_bist_rotate_sr = 'b0;
        wire                            tcam_row_10_col_1_bist_en_sr_mask_b = 'b0;
        wire                            tcam_row_10_col_1_bist_all_mask = 'b0;
        wire                            tcam_row_10_col_1_bist_en_sr_data_b = 'b0;
        wire                            tcam_row_10_col_1_bist_cm_mode = 'b0;
        wire                            tcam_row_10_col_1_bist_cm_en_in = 'b0;
        wire                            tcam_row_10_col_1_bist_cm_match_sel0 = 'b0;
        wire                            tcam_row_10_col_1_bist_cm_match_sel1 = 'b0;
        wire                            tcam_row_10_col_1_bist_matchin_in = 'b0;
        wire                            tcam_row_10_col_1_bist_fls = 'b0;
        `endif
        
        // Outputs
        logic                           tcam_row_10_col_1_wr_bira_fail;
        logic                           tcam_row_10_col_1_wr_so;
        logic                           tcam_row_10_col_1_curerrout;
        logic                           tcam_row_10_col_1_rscout;
        
        
        
        logic   [TCAM_SLICE_EN_FACT-1:0]                  tcam_row_10_col_1_slice_en_s0; 
        logic   [TCAM_SLICE_EN_FACT-1:0]                  tcam_row_10_col_1_slice_en_s1; 
        
        
        
             wire    [32-1:0]                     tcam_row_10_col_1_data_out ;
        
        
        
         generate
            if (BCAM_N7 == 0) 
              begin : gen_tcam_row_10_col_1_tcam
        
        
        // slice_en kept for TCAM only for backward compatability with Intel process
                always_comb 
                begin
                  for (int i = 0; i < TCAM_SLICE_EN_FACT; i++)
                      if (tcam_row_10_col_1_slice_en_s1[i])
                           tcam_row_10_col_1_hit_out[ i*64 +: 64]  = tcam_row_10_col_1_hit_out_int  [ i*64 +: 64]; 
                      else
                           tcam_row_10_col_1_hit_out[ i*64 +: 64]  = tcam_row_10_col_1_hit_out_latch[ i*64 +: 64]; 
                end
        
        
        
                always_ff  @(posedge tcam_row_10_col_1_clk)
                begin
                  tcam_row_10_col_1_slice_en_s0 <= tcam_row_10_col_1_slice_en; 
                  tcam_row_10_col_1_slice_en_s1 <= tcam_row_10_col_1_slice_en_s0; 
        
                  for (int i = 0; i < TCAM_SLICE_EN_FACT; i++)
                    begin
                      if (tcam_row_10_col_1_slice_en_s1[i])
                         tcam_row_10_col_1_hit_out_latch[ i*64 +: 64] <=  tcam_row_10_col_1_hit_out_int[ i*64 +: 64];
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
        
                     
                         assign tcam_row_10_col_1_data_out  = ~tcam_row_10_col_1_data_out_inv;
                         pcie_itp_ip783tcam64x32s0c1_10_1_wrap #(        
                                 )               
        
                                 ip783tcam64x32s0c1_wrap_tcam_row_10_col_1 (
                   //-------------------------------------------------------------
                   // Power Management Interfaces
                   //-------------------------------------------------------------   
                      `ifndef INTEL_NO_PWR_PINS
                      `ifdef INTC_ADD_VSS
                        .vss              (1'b0),
                      `endif
                        .vddp             (1'b1),
                      `endif
                         .ADR               (tcam_row_10_col_1_adr[7-1:1]), //Input adr_intess
                         .ME                (ce),  
        
                         .CLK               (tcam_row_10_col_1_clk), //Clock
                         .CMP               (tcam_row_10_col_1_chk_en), //Control Enable
                         .DIN               (~tcam_row_10_col_1_data_in), 
                         .DSEL              (~tcam_row_10_col_1_adr[0]), //dncen enables access of the TCAM Arrays adr_intessed
                         .FLS               (flush), //flush initiates a Flush operation that resets all Valid
                         .RVLD              (tcam_row_10_col_1_hit_in ), //Row validation bus. Each match_in input controls 1
                         .MASK              (tcam_row_10_col_1_mask_in), //Input msk
                         .QOUT              (tcam_row_10_col_1_data_out_inv), //Output vben
                         .QHR               (tcam_row_10_col_1_hit_out_int),
                         .QVLD              (), 
                         .RE                (tcam_row_10_col_1_rd_en), //Read Enable
                         .RST               (tcam_row_10_col_1_reset_n), //Asynchronous Active-High Reset
                         .VBE               (1'b1), //vben enables the Valid Bit addressed by adr[a-1:0] to
                         .VBI               (1'b0),//  Valid Bit Input
                         .WE                (tcam_row_10_col_1_wr_en), //Write Enable
                         .FAF               (tcam_row_10_col_1_fca),
                         .FAF_EN            (tcam_row_10_col_1_cre),
                         .DFTSHIFTEN        (tcam_row_10_col_1_dftshiften),
                         .DFTMASK           (tcam_row_10_col_1_dftmask),
                         .DFT_ARRAY_FREEZE  (tcam_row_10_col_1_dft_array_freeze),
                         .DFT_AFD_RESET_B   (tcam_row_10_col_1_dft_afd_reset_b),
                         .BISTE           (tcam_row_10_col_1_biste),
                         .TDIN (tcam_row_10_col_1_tdin),
                         .TADR (tcam_row_10_col_1_tadr),
                         .TVBE (tcam_row_10_col_1_tvbe),
                         .TVBI (tcam_row_10_col_1_tvbi),
                         .TMASK (tcam_row_10_col_1_tmask),
                         .TWE (tcam_row_10_col_1_twe),
                         .TRE (tcam_row_10_col_1_tre),
                         .TME (tcam_row_10_col_1_tme),
                         .BIST_ROTATE_SR (tcam_row_10_col_1_bist_rotate_sr),
                         .BIST_EN_SR_MASK_B (tcam_row_10_col_1_bist_en_sr_mask_b),
                         .BIST_ALL_MASK (tcam_row_10_col_1_bist_all_mask),
                         .BIST_EN_SR_DATA_B (tcam_row_10_col_1_bist_en_sr_data_b),
                         .BIST_CM_MODE (tcam_row_10_col_1_bist_cm_mode),
                         .BIST_CM_EN_IN (tcam_row_10_col_1_bist_cm_en_in),
                         .BIST_CM_MATCH_SEL0 (tcam_row_10_col_1_bist_cm_match_sel0),
                         .BIST_CM_MATCH_SEL1 (tcam_row_10_col_1_bist_cm_match_sel1),
                         .BIST_MATCHIN_IN (tcam_row_10_col_1_bist_matchin_in),
                         .BIST_FLS (tcam_row_10_col_1_bist_fls),
                         .MDST_tcam (fuse_tcam)
                     );
        
              end
              
            else
              begin : gen_tcam_row_10_col_1_bcam
              end
              
        
        
        endgenerate
        
        always_ff @(posedge clk) begin
                   tcam_rd_data_col[10][1]      <= tcam_row_10_col_1_data_out;
                   tcam_col_hit_out[10][1]       <= tcam_row_10_col_1_hit_out;
        end
        

        // this is new template - tcam_asic_template
        
        wire                                            tcam_row_11_col_0_clk         = clk;
        
        wire    [TCAM_SLICE_EN_FACT-1:0]                tcam_row_11_col_0_slice_en = TCAM_SLICE_EN_FACT'(slice_en[(11 * TCAM_SLICE_EN_FACT)+:TCAM_SLICE_EN_MIN]);
        
        wire                                            tcam_row_11_col_0_rd_en       = tcam_row_rd_en[11];
        wire                                            tcam_row_11_col_0_wr_en       = tcam_row_wr_en[11];
        wire                                            tcam_row_11_col_0_chk_en      = chk_en;
        wire                                            tcam_row_11_col_0_reset_n = reset_n;
        wire    [7-1:0]                       tcam_row_11_col_0_adr  = tcam_row_adr[11][7-1:0];
        wire    [32-1:0]                      tcam_row_11_col_0_data_in = tcam_row_wr_en[11] ? tcam_wr_data_col[0][32-1:0] : tcam_chk_key_col[0][32-1:0];
        wire    [32-1:0]                      tcam_row_11_col_0_data_in_pre = tcam_wr_data_col[0][32-1:0] ;
        wire    [32-1:0]                      tcam_row_11_col_0_key_in =  tcam_chk_key_col[0][32-1:0];
        wire    [32-1:0]                      tcam_row_11_col_0_mask_in = tcam_chk_mask_col[0][32-1:0];
        wire    [64-1:0]                       tcam_row_11_col_0_hit_in = tcam_raw_hit_in[11];
        wire    [64-1:0]                       tcam_row_11_col_0_tcam_match_in = tcam_row_match_in[11];
        wire    [32-1:0]                      tcam_row_11_col_0_data_out_inv;
        logic   [64-1:0]                     tcam_row_11_col_0_hit_out_int;
        logic   [64-1:0]                     tcam_row_11_col_0_hit_out_latch;
        logic   [64-1:0]                     tcam_row_11_col_0_hit_out;
        
        `ifdef HIF_PCIE_DFX_DISABLE
        wire                          tcam_row_11_col_0_biste = 'b0; 
        wire     [5-1:0]                  tcam_row_11_col_0_fca = 'b0;
        wire                            tcam_row_11_col_0_cre = 'b0;
        wire                            tcam_row_11_col_0_dftshiften = 'b0;
        wire                            tcam_row_11_col_0_dftmask = 'b0;
        wire                            tcam_row_11_col_0_dft_array_freeze = 'b0;
        wire                            tcam_row_11_col_0_dft_afd_reset_b = 'b0;
        wire      [32-1:0]    tcam_row_11_col_0_tdin = 'b0;
        wire      [7-1:0]     tcam_row_11_col_0_tadr = 'b0;
        wire                            tcam_row_11_col_0_tvbe = 'b0;
        wire                            tcam_row_11_col_0_tvbi = 'b0;
        wire      [32-1:0]    tcam_row_11_col_0_tmask = 'b0;
        wire                            tcam_row_11_col_0_twe = 'b0;
        wire                            tcam_row_11_col_0_tre = 'b0;
        wire                            tcam_row_11_col_0_tme = 'b0;
        wire                            tcam_row_11_col_0_bist_rotate_sr = 'b0;
        wire                            tcam_row_11_col_0_bist_en_sr_mask_b = 'b0;
        wire                            tcam_row_11_col_0_bist_all_mask = 'b0;
        wire                            tcam_row_11_col_0_bist_en_sr_data_b = 'b0;
        wire                            tcam_row_11_col_0_bist_cm_mode = 'b0;
        wire                            tcam_row_11_col_0_bist_cm_en_in = 'b0;
        wire                            tcam_row_11_col_0_bist_cm_match_sel0 = 'b0;
        wire                            tcam_row_11_col_0_bist_cm_match_sel1 = 'b0;
        wire                            tcam_row_11_col_0_bist_matchin_in = 'b0;
        wire                            tcam_row_11_col_0_bist_fls = 'b0;
        
        `else
        wire                            tcam_row_11_col_0_biste = 'b0;
        wire     [5-1:0]                  tcam_row_11_col_0_fca = 'b0;
        wire                            tcam_row_11_col_0_cre = 'b0;
        wire                            tcam_row_11_col_0_dftshiften = dftshiften;
        wire                            tcam_row_11_col_0_dftmask = dftmask;
        wire                            tcam_row_11_col_0_dft_array_freeze = dft_array_freeze;
        wire                            tcam_row_11_col_0_dft_afd_reset_b = dft_afd_reset_b;
        wire      [32-1:0]    tcam_row_11_col_0_tdin = 'b0;
        wire      [7-1:0]     tcam_row_11_col_0_tadr = 'b0;
        wire                            tcam_row_11_col_0_tvbe = 'b0;
        wire                            tcam_row_11_col_0_tvbi = 'b0;
        wire      [32-1:0]    tcam_row_11_col_0_tmask = 'b0;
        wire                            tcam_row_11_col_0_twe = 'b0;
        wire                            tcam_row_11_col_0_tre = 'b0;
        wire                            tcam_row_11_col_0_tme = 'b0;
        wire                            tcam_row_11_col_0_bist_rotate_sr = 'b0;
        wire                            tcam_row_11_col_0_bist_en_sr_mask_b = 'b0;
        wire                            tcam_row_11_col_0_bist_all_mask = 'b0;
        wire                            tcam_row_11_col_0_bist_en_sr_data_b = 'b0;
        wire                            tcam_row_11_col_0_bist_cm_mode = 'b0;
        wire                            tcam_row_11_col_0_bist_cm_en_in = 'b0;
        wire                            tcam_row_11_col_0_bist_cm_match_sel0 = 'b0;
        wire                            tcam_row_11_col_0_bist_cm_match_sel1 = 'b0;
        wire                            tcam_row_11_col_0_bist_matchin_in = 'b0;
        wire                            tcam_row_11_col_0_bist_fls = 'b0;
        `endif
        
        // Outputs
        logic                           tcam_row_11_col_0_wr_bira_fail;
        logic                           tcam_row_11_col_0_wr_so;
        logic                           tcam_row_11_col_0_curerrout;
        logic                           tcam_row_11_col_0_rscout;
        
        
        
        logic   [TCAM_SLICE_EN_FACT-1:0]                  tcam_row_11_col_0_slice_en_s0; 
        logic   [TCAM_SLICE_EN_FACT-1:0]                  tcam_row_11_col_0_slice_en_s1; 
        
        
        
             wire    [32-1:0]                     tcam_row_11_col_0_data_out ;
        
        
        
         generate
            if (BCAM_N7 == 0) 
              begin : gen_tcam_row_11_col_0_tcam
        
        
        // slice_en kept for TCAM only for backward compatability with Intel process
                always_comb 
                begin
                  for (int i = 0; i < TCAM_SLICE_EN_FACT; i++)
                      if (tcam_row_11_col_0_slice_en_s1[i])
                           tcam_row_11_col_0_hit_out[ i*64 +: 64]  = tcam_row_11_col_0_hit_out_int  [ i*64 +: 64]; 
                      else
                           tcam_row_11_col_0_hit_out[ i*64 +: 64]  = tcam_row_11_col_0_hit_out_latch[ i*64 +: 64]; 
                end
        
        
        
                always_ff  @(posedge tcam_row_11_col_0_clk)
                begin
                  tcam_row_11_col_0_slice_en_s0 <= tcam_row_11_col_0_slice_en; 
                  tcam_row_11_col_0_slice_en_s1 <= tcam_row_11_col_0_slice_en_s0; 
        
                  for (int i = 0; i < TCAM_SLICE_EN_FACT; i++)
                    begin
                      if (tcam_row_11_col_0_slice_en_s1[i])
                         tcam_row_11_col_0_hit_out_latch[ i*64 +: 64] <=  tcam_row_11_col_0_hit_out_int[ i*64 +: 64];
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
        
                     
                         assign tcam_row_11_col_0_data_out  = ~tcam_row_11_col_0_data_out_inv;
                         pcie_itp_ip783tcam64x32s0c1_11_0_wrap #(        
                                 )               
        
                                 ip783tcam64x32s0c1_wrap_tcam_row_11_col_0 (
                   //-------------------------------------------------------------
                   // Power Management Interfaces
                   //-------------------------------------------------------------   
                      `ifndef INTEL_NO_PWR_PINS
                      `ifdef INTC_ADD_VSS
                        .vss              (1'b0),
                      `endif
                        .vddp             (1'b1),
                      `endif
                         .ADR               (tcam_row_11_col_0_adr[7-1:1]), //Input adr_intess
                         .ME                (ce),  
        
                         .CLK               (tcam_row_11_col_0_clk), //Clock
                         .CMP               (tcam_row_11_col_0_chk_en), //Control Enable
                         .DIN               (~tcam_row_11_col_0_data_in), 
                         .DSEL              (~tcam_row_11_col_0_adr[0]), //dncen enables access of the TCAM Arrays adr_intessed
                         .FLS               (flush), //flush initiates a Flush operation that resets all Valid
                         .RVLD              (tcam_row_11_col_0_hit_in ), //Row validation bus. Each match_in input controls 1
                         .MASK              (tcam_row_11_col_0_mask_in), //Input msk
                         .QOUT              (tcam_row_11_col_0_data_out_inv), //Output vben
                         .QHR               (tcam_row_11_col_0_hit_out_int),
                         .QVLD              (), 
                         .RE                (tcam_row_11_col_0_rd_en), //Read Enable
                         .RST               (tcam_row_11_col_0_reset_n), //Asynchronous Active-High Reset
                         .VBE               (1'b1), //vben enables the Valid Bit addressed by adr[a-1:0] to
                         .VBI               (1'b0),//  Valid Bit Input
                         .WE                (tcam_row_11_col_0_wr_en), //Write Enable
                         .FAF               (tcam_row_11_col_0_fca),
                         .FAF_EN            (tcam_row_11_col_0_cre),
                         .DFTSHIFTEN        (tcam_row_11_col_0_dftshiften),
                         .DFTMASK           (tcam_row_11_col_0_dftmask),
                         .DFT_ARRAY_FREEZE  (tcam_row_11_col_0_dft_array_freeze),
                         .DFT_AFD_RESET_B   (tcam_row_11_col_0_dft_afd_reset_b),
                         .BISTE           (tcam_row_11_col_0_biste),
                         .TDIN (tcam_row_11_col_0_tdin),
                         .TADR (tcam_row_11_col_0_tadr),
                         .TVBE (tcam_row_11_col_0_tvbe),
                         .TVBI (tcam_row_11_col_0_tvbi),
                         .TMASK (tcam_row_11_col_0_tmask),
                         .TWE (tcam_row_11_col_0_twe),
                         .TRE (tcam_row_11_col_0_tre),
                         .TME (tcam_row_11_col_0_tme),
                         .BIST_ROTATE_SR (tcam_row_11_col_0_bist_rotate_sr),
                         .BIST_EN_SR_MASK_B (tcam_row_11_col_0_bist_en_sr_mask_b),
                         .BIST_ALL_MASK (tcam_row_11_col_0_bist_all_mask),
                         .BIST_EN_SR_DATA_B (tcam_row_11_col_0_bist_en_sr_data_b),
                         .BIST_CM_MODE (tcam_row_11_col_0_bist_cm_mode),
                         .BIST_CM_EN_IN (tcam_row_11_col_0_bist_cm_en_in),
                         .BIST_CM_MATCH_SEL0 (tcam_row_11_col_0_bist_cm_match_sel0),
                         .BIST_CM_MATCH_SEL1 (tcam_row_11_col_0_bist_cm_match_sel1),
                         .BIST_MATCHIN_IN (tcam_row_11_col_0_bist_matchin_in),
                         .BIST_FLS (tcam_row_11_col_0_bist_fls),
                         .MDST_tcam (fuse_tcam)
                     );
        
              end
              
            else
              begin : gen_tcam_row_11_col_0_bcam
              end
              
        
        
        endgenerate
        
        always_ff @(posedge clk) begin
                   tcam_rd_data_col[11][0]      <= tcam_row_11_col_0_data_out;
                   tcam_col_hit_out[11][0]       <= tcam_row_11_col_0_hit_out;
        end
        

        // this is new template - tcam_asic_template
        
        wire                                            tcam_row_11_col_1_clk         = clk;
        
        wire    [TCAM_SLICE_EN_FACT-1:0]                tcam_row_11_col_1_slice_en = TCAM_SLICE_EN_FACT'(slice_en[(11 * TCAM_SLICE_EN_FACT)+:TCAM_SLICE_EN_MIN]);
        
        wire                                            tcam_row_11_col_1_rd_en       = tcam_row_rd_en[11];
        wire                                            tcam_row_11_col_1_wr_en       = tcam_row_wr_en[11];
        wire                                            tcam_row_11_col_1_chk_en      = chk_en;
        wire                                            tcam_row_11_col_1_reset_n = reset_n;
        wire    [7-1:0]                       tcam_row_11_col_1_adr  = tcam_row_adr[11][7-1:0];
        wire    [32-1:0]                      tcam_row_11_col_1_data_in = tcam_row_wr_en[11] ? tcam_wr_data_col[1][32-1:0] : tcam_chk_key_col[1][32-1:0];
        wire    [32-1:0]                      tcam_row_11_col_1_data_in_pre = tcam_wr_data_col[1][32-1:0] ;
        wire    [32-1:0]                      tcam_row_11_col_1_key_in =  tcam_chk_key_col[1][32-1:0];
        wire    [32-1:0]                      tcam_row_11_col_1_mask_in = tcam_chk_mask_col[1][32-1:0];
        wire    [64-1:0]                       tcam_row_11_col_1_hit_in = tcam_raw_hit_in[11];
        wire    [64-1:0]                       tcam_row_11_col_1_tcam_match_in = tcam_row_match_in[11];
        wire    [32-1:0]                      tcam_row_11_col_1_data_out_inv;
        logic   [64-1:0]                     tcam_row_11_col_1_hit_out_int;
        logic   [64-1:0]                     tcam_row_11_col_1_hit_out_latch;
        logic   [64-1:0]                     tcam_row_11_col_1_hit_out;
        
        `ifdef HIF_PCIE_DFX_DISABLE
        wire                          tcam_row_11_col_1_biste = 'b0; 
        wire     [5-1:0]                  tcam_row_11_col_1_fca = 'b0;
        wire                            tcam_row_11_col_1_cre = 'b0;
        wire                            tcam_row_11_col_1_dftshiften = 'b0;
        wire                            tcam_row_11_col_1_dftmask = 'b0;
        wire                            tcam_row_11_col_1_dft_array_freeze = 'b0;
        wire                            tcam_row_11_col_1_dft_afd_reset_b = 'b0;
        wire      [32-1:0]    tcam_row_11_col_1_tdin = 'b0;
        wire      [7-1:0]     tcam_row_11_col_1_tadr = 'b0;
        wire                            tcam_row_11_col_1_tvbe = 'b0;
        wire                            tcam_row_11_col_1_tvbi = 'b0;
        wire      [32-1:0]    tcam_row_11_col_1_tmask = 'b0;
        wire                            tcam_row_11_col_1_twe = 'b0;
        wire                            tcam_row_11_col_1_tre = 'b0;
        wire                            tcam_row_11_col_1_tme = 'b0;
        wire                            tcam_row_11_col_1_bist_rotate_sr = 'b0;
        wire                            tcam_row_11_col_1_bist_en_sr_mask_b = 'b0;
        wire                            tcam_row_11_col_1_bist_all_mask = 'b0;
        wire                            tcam_row_11_col_1_bist_en_sr_data_b = 'b0;
        wire                            tcam_row_11_col_1_bist_cm_mode = 'b0;
        wire                            tcam_row_11_col_1_bist_cm_en_in = 'b0;
        wire                            tcam_row_11_col_1_bist_cm_match_sel0 = 'b0;
        wire                            tcam_row_11_col_1_bist_cm_match_sel1 = 'b0;
        wire                            tcam_row_11_col_1_bist_matchin_in = 'b0;
        wire                            tcam_row_11_col_1_bist_fls = 'b0;
        
        `else
        wire                            tcam_row_11_col_1_biste = 'b0;
        wire     [5-1:0]                  tcam_row_11_col_1_fca = 'b0;
        wire                            tcam_row_11_col_1_cre = 'b0;
        wire                            tcam_row_11_col_1_dftshiften = dftshiften;
        wire                            tcam_row_11_col_1_dftmask = dftmask;
        wire                            tcam_row_11_col_1_dft_array_freeze = dft_array_freeze;
        wire                            tcam_row_11_col_1_dft_afd_reset_b = dft_afd_reset_b;
        wire      [32-1:0]    tcam_row_11_col_1_tdin = 'b0;
        wire      [7-1:0]     tcam_row_11_col_1_tadr = 'b0;
        wire                            tcam_row_11_col_1_tvbe = 'b0;
        wire                            tcam_row_11_col_1_tvbi = 'b0;
        wire      [32-1:0]    tcam_row_11_col_1_tmask = 'b0;
        wire                            tcam_row_11_col_1_twe = 'b0;
        wire                            tcam_row_11_col_1_tre = 'b0;
        wire                            tcam_row_11_col_1_tme = 'b0;
        wire                            tcam_row_11_col_1_bist_rotate_sr = 'b0;
        wire                            tcam_row_11_col_1_bist_en_sr_mask_b = 'b0;
        wire                            tcam_row_11_col_1_bist_all_mask = 'b0;
        wire                            tcam_row_11_col_1_bist_en_sr_data_b = 'b0;
        wire                            tcam_row_11_col_1_bist_cm_mode = 'b0;
        wire                            tcam_row_11_col_1_bist_cm_en_in = 'b0;
        wire                            tcam_row_11_col_1_bist_cm_match_sel0 = 'b0;
        wire                            tcam_row_11_col_1_bist_cm_match_sel1 = 'b0;
        wire                            tcam_row_11_col_1_bist_matchin_in = 'b0;
        wire                            tcam_row_11_col_1_bist_fls = 'b0;
        `endif
        
        // Outputs
        logic                           tcam_row_11_col_1_wr_bira_fail;
        logic                           tcam_row_11_col_1_wr_so;
        logic                           tcam_row_11_col_1_curerrout;
        logic                           tcam_row_11_col_1_rscout;
        
        
        
        logic   [TCAM_SLICE_EN_FACT-1:0]                  tcam_row_11_col_1_slice_en_s0; 
        logic   [TCAM_SLICE_EN_FACT-1:0]                  tcam_row_11_col_1_slice_en_s1; 
        
        
        
             wire    [32-1:0]                     tcam_row_11_col_1_data_out ;
        
        
        
         generate
            if (BCAM_N7 == 0) 
              begin : gen_tcam_row_11_col_1_tcam
        
        
        // slice_en kept for TCAM only for backward compatability with Intel process
                always_comb 
                begin
                  for (int i = 0; i < TCAM_SLICE_EN_FACT; i++)
                      if (tcam_row_11_col_1_slice_en_s1[i])
                           tcam_row_11_col_1_hit_out[ i*64 +: 64]  = tcam_row_11_col_1_hit_out_int  [ i*64 +: 64]; 
                      else
                           tcam_row_11_col_1_hit_out[ i*64 +: 64]  = tcam_row_11_col_1_hit_out_latch[ i*64 +: 64]; 
                end
        
        
        
                always_ff  @(posedge tcam_row_11_col_1_clk)
                begin
                  tcam_row_11_col_1_slice_en_s0 <= tcam_row_11_col_1_slice_en; 
                  tcam_row_11_col_1_slice_en_s1 <= tcam_row_11_col_1_slice_en_s0; 
        
                  for (int i = 0; i < TCAM_SLICE_EN_FACT; i++)
                    begin
                      if (tcam_row_11_col_1_slice_en_s1[i])
                         tcam_row_11_col_1_hit_out_latch[ i*64 +: 64] <=  tcam_row_11_col_1_hit_out_int[ i*64 +: 64];
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
        
                     
                         assign tcam_row_11_col_1_data_out  = ~tcam_row_11_col_1_data_out_inv;
                         pcie_itp_ip783tcam64x32s0c1_11_1_wrap #(        
                                 )               
        
                                 ip783tcam64x32s0c1_wrap_tcam_row_11_col_1 (
                   //-------------------------------------------------------------
                   // Power Management Interfaces
                   //-------------------------------------------------------------   
                      `ifndef INTEL_NO_PWR_PINS
                      `ifdef INTC_ADD_VSS
                        .vss              (1'b0),
                      `endif
                        .vddp             (1'b1),
                      `endif
                         .ADR               (tcam_row_11_col_1_adr[7-1:1]), //Input adr_intess
                         .ME                (ce),  
        
                         .CLK               (tcam_row_11_col_1_clk), //Clock
                         .CMP               (tcam_row_11_col_1_chk_en), //Control Enable
                         .DIN               (~tcam_row_11_col_1_data_in), 
                         .DSEL              (~tcam_row_11_col_1_adr[0]), //dncen enables access of the TCAM Arrays adr_intessed
                         .FLS               (flush), //flush initiates a Flush operation that resets all Valid
                         .RVLD              (tcam_row_11_col_1_hit_in ), //Row validation bus. Each match_in input controls 1
                         .MASK              (tcam_row_11_col_1_mask_in), //Input msk
                         .QOUT              (tcam_row_11_col_1_data_out_inv), //Output vben
                         .QHR               (tcam_row_11_col_1_hit_out_int),
                         .QVLD              (), 
                         .RE                (tcam_row_11_col_1_rd_en), //Read Enable
                         .RST               (tcam_row_11_col_1_reset_n), //Asynchronous Active-High Reset
                         .VBE               (1'b1), //vben enables the Valid Bit addressed by adr[a-1:0] to
                         .VBI               (1'b0),//  Valid Bit Input
                         .WE                (tcam_row_11_col_1_wr_en), //Write Enable
                         .FAF               (tcam_row_11_col_1_fca),
                         .FAF_EN            (tcam_row_11_col_1_cre),
                         .DFTSHIFTEN        (tcam_row_11_col_1_dftshiften),
                         .DFTMASK           (tcam_row_11_col_1_dftmask),
                         .DFT_ARRAY_FREEZE  (tcam_row_11_col_1_dft_array_freeze),
                         .DFT_AFD_RESET_B   (tcam_row_11_col_1_dft_afd_reset_b),
                         .BISTE           (tcam_row_11_col_1_biste),
                         .TDIN (tcam_row_11_col_1_tdin),
                         .TADR (tcam_row_11_col_1_tadr),
                         .TVBE (tcam_row_11_col_1_tvbe),
                         .TVBI (tcam_row_11_col_1_tvbi),
                         .TMASK (tcam_row_11_col_1_tmask),
                         .TWE (tcam_row_11_col_1_twe),
                         .TRE (tcam_row_11_col_1_tre),
                         .TME (tcam_row_11_col_1_tme),
                         .BIST_ROTATE_SR (tcam_row_11_col_1_bist_rotate_sr),
                         .BIST_EN_SR_MASK_B (tcam_row_11_col_1_bist_en_sr_mask_b),
                         .BIST_ALL_MASK (tcam_row_11_col_1_bist_all_mask),
                         .BIST_EN_SR_DATA_B (tcam_row_11_col_1_bist_en_sr_data_b),
                         .BIST_CM_MODE (tcam_row_11_col_1_bist_cm_mode),
                         .BIST_CM_EN_IN (tcam_row_11_col_1_bist_cm_en_in),
                         .BIST_CM_MATCH_SEL0 (tcam_row_11_col_1_bist_cm_match_sel0),
                         .BIST_CM_MATCH_SEL1 (tcam_row_11_col_1_bist_cm_match_sel1),
                         .BIST_MATCHIN_IN (tcam_row_11_col_1_bist_matchin_in),
                         .BIST_FLS (tcam_row_11_col_1_bist_fls),
                         .MDST_tcam (fuse_tcam)
                     );
        
              end
              
            else
              begin : gen_tcam_row_11_col_1_bcam
              end
              
        
        
        endgenerate
        
        always_ff @(posedge clk) begin
                   tcam_rd_data_col[11][1]      <= tcam_row_11_col_1_data_out;
                   tcam_col_hit_out[11][1]       <= tcam_row_11_col_1_hit_out;
        end
        

        // this is new template - tcam_asic_template
        
        wire                                            tcam_row_12_col_0_clk         = clk;
        
        wire    [TCAM_SLICE_EN_FACT-1:0]                tcam_row_12_col_0_slice_en = TCAM_SLICE_EN_FACT'(slice_en[(12 * TCAM_SLICE_EN_FACT)+:TCAM_SLICE_EN_MIN]);
        
        wire                                            tcam_row_12_col_0_rd_en       = tcam_row_rd_en[12];
        wire                                            tcam_row_12_col_0_wr_en       = tcam_row_wr_en[12];
        wire                                            tcam_row_12_col_0_chk_en      = chk_en;
        wire                                            tcam_row_12_col_0_reset_n = reset_n;
        wire    [7-1:0]                       tcam_row_12_col_0_adr  = tcam_row_adr[12][7-1:0];
        wire    [32-1:0]                      tcam_row_12_col_0_data_in = tcam_row_wr_en[12] ? tcam_wr_data_col[0][32-1:0] : tcam_chk_key_col[0][32-1:0];
        wire    [32-1:0]                      tcam_row_12_col_0_data_in_pre = tcam_wr_data_col[0][32-1:0] ;
        wire    [32-1:0]                      tcam_row_12_col_0_key_in =  tcam_chk_key_col[0][32-1:0];
        wire    [32-1:0]                      tcam_row_12_col_0_mask_in = tcam_chk_mask_col[0][32-1:0];
        wire    [64-1:0]                       tcam_row_12_col_0_hit_in = tcam_raw_hit_in[12];
        wire    [64-1:0]                       tcam_row_12_col_0_tcam_match_in = tcam_row_match_in[12];
        wire    [32-1:0]                      tcam_row_12_col_0_data_out_inv;
        logic   [64-1:0]                     tcam_row_12_col_0_hit_out_int;
        logic   [64-1:0]                     tcam_row_12_col_0_hit_out_latch;
        logic   [64-1:0]                     tcam_row_12_col_0_hit_out;
        
        `ifdef HIF_PCIE_DFX_DISABLE
        wire                          tcam_row_12_col_0_biste = 'b0; 
        wire     [5-1:0]                  tcam_row_12_col_0_fca = 'b0;
        wire                            tcam_row_12_col_0_cre = 'b0;
        wire                            tcam_row_12_col_0_dftshiften = 'b0;
        wire                            tcam_row_12_col_0_dftmask = 'b0;
        wire                            tcam_row_12_col_0_dft_array_freeze = 'b0;
        wire                            tcam_row_12_col_0_dft_afd_reset_b = 'b0;
        wire      [32-1:0]    tcam_row_12_col_0_tdin = 'b0;
        wire      [7-1:0]     tcam_row_12_col_0_tadr = 'b0;
        wire                            tcam_row_12_col_0_tvbe = 'b0;
        wire                            tcam_row_12_col_0_tvbi = 'b0;
        wire      [32-1:0]    tcam_row_12_col_0_tmask = 'b0;
        wire                            tcam_row_12_col_0_twe = 'b0;
        wire                            tcam_row_12_col_0_tre = 'b0;
        wire                            tcam_row_12_col_0_tme = 'b0;
        wire                            tcam_row_12_col_0_bist_rotate_sr = 'b0;
        wire                            tcam_row_12_col_0_bist_en_sr_mask_b = 'b0;
        wire                            tcam_row_12_col_0_bist_all_mask = 'b0;
        wire                            tcam_row_12_col_0_bist_en_sr_data_b = 'b0;
        wire                            tcam_row_12_col_0_bist_cm_mode = 'b0;
        wire                            tcam_row_12_col_0_bist_cm_en_in = 'b0;
        wire                            tcam_row_12_col_0_bist_cm_match_sel0 = 'b0;
        wire                            tcam_row_12_col_0_bist_cm_match_sel1 = 'b0;
        wire                            tcam_row_12_col_0_bist_matchin_in = 'b0;
        wire                            tcam_row_12_col_0_bist_fls = 'b0;
        
        `else
        wire                            tcam_row_12_col_0_biste = 'b0;
        wire     [5-1:0]                  tcam_row_12_col_0_fca = 'b0;
        wire                            tcam_row_12_col_0_cre = 'b0;
        wire                            tcam_row_12_col_0_dftshiften = dftshiften;
        wire                            tcam_row_12_col_0_dftmask = dftmask;
        wire                            tcam_row_12_col_0_dft_array_freeze = dft_array_freeze;
        wire                            tcam_row_12_col_0_dft_afd_reset_b = dft_afd_reset_b;
        wire      [32-1:0]    tcam_row_12_col_0_tdin = 'b0;
        wire      [7-1:0]     tcam_row_12_col_0_tadr = 'b0;
        wire                            tcam_row_12_col_0_tvbe = 'b0;
        wire                            tcam_row_12_col_0_tvbi = 'b0;
        wire      [32-1:0]    tcam_row_12_col_0_tmask = 'b0;
        wire                            tcam_row_12_col_0_twe = 'b0;
        wire                            tcam_row_12_col_0_tre = 'b0;
        wire                            tcam_row_12_col_0_tme = 'b0;
        wire                            tcam_row_12_col_0_bist_rotate_sr = 'b0;
        wire                            tcam_row_12_col_0_bist_en_sr_mask_b = 'b0;
        wire                            tcam_row_12_col_0_bist_all_mask = 'b0;
        wire                            tcam_row_12_col_0_bist_en_sr_data_b = 'b0;
        wire                            tcam_row_12_col_0_bist_cm_mode = 'b0;
        wire                            tcam_row_12_col_0_bist_cm_en_in = 'b0;
        wire                            tcam_row_12_col_0_bist_cm_match_sel0 = 'b0;
        wire                            tcam_row_12_col_0_bist_cm_match_sel1 = 'b0;
        wire                            tcam_row_12_col_0_bist_matchin_in = 'b0;
        wire                            tcam_row_12_col_0_bist_fls = 'b0;
        `endif
        
        // Outputs
        logic                           tcam_row_12_col_0_wr_bira_fail;
        logic                           tcam_row_12_col_0_wr_so;
        logic                           tcam_row_12_col_0_curerrout;
        logic                           tcam_row_12_col_0_rscout;
        
        
        
        logic   [TCAM_SLICE_EN_FACT-1:0]                  tcam_row_12_col_0_slice_en_s0; 
        logic   [TCAM_SLICE_EN_FACT-1:0]                  tcam_row_12_col_0_slice_en_s1; 
        
        
        
             wire    [32-1:0]                     tcam_row_12_col_0_data_out ;
        
        
        
         generate
            if (BCAM_N7 == 0) 
              begin : gen_tcam_row_12_col_0_tcam
        
        
        // slice_en kept for TCAM only for backward compatability with Intel process
                always_comb 
                begin
                  for (int i = 0; i < TCAM_SLICE_EN_FACT; i++)
                      if (tcam_row_12_col_0_slice_en_s1[i])
                           tcam_row_12_col_0_hit_out[ i*64 +: 64]  = tcam_row_12_col_0_hit_out_int  [ i*64 +: 64]; 
                      else
                           tcam_row_12_col_0_hit_out[ i*64 +: 64]  = tcam_row_12_col_0_hit_out_latch[ i*64 +: 64]; 
                end
        
        
        
                always_ff  @(posedge tcam_row_12_col_0_clk)
                begin
                  tcam_row_12_col_0_slice_en_s0 <= tcam_row_12_col_0_slice_en; 
                  tcam_row_12_col_0_slice_en_s1 <= tcam_row_12_col_0_slice_en_s0; 
        
                  for (int i = 0; i < TCAM_SLICE_EN_FACT; i++)
                    begin
                      if (tcam_row_12_col_0_slice_en_s1[i])
                         tcam_row_12_col_0_hit_out_latch[ i*64 +: 64] <=  tcam_row_12_col_0_hit_out_int[ i*64 +: 64];
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
        
                     
                         assign tcam_row_12_col_0_data_out  = ~tcam_row_12_col_0_data_out_inv;
                         pcie_itp_ip783tcam64x32s0c1_12_0_wrap #(        
                                 )               
        
                                 ip783tcam64x32s0c1_wrap_tcam_row_12_col_0 (
                   //-------------------------------------------------------------
                   // Power Management Interfaces
                   //-------------------------------------------------------------   
                      `ifndef INTEL_NO_PWR_PINS
                      `ifdef INTC_ADD_VSS
                        .vss              (1'b0),
                      `endif
                        .vddp             (1'b1),
                      `endif
                         .ADR               (tcam_row_12_col_0_adr[7-1:1]), //Input adr_intess
                         .ME                (ce),  
        
                         .CLK               (tcam_row_12_col_0_clk), //Clock
                         .CMP               (tcam_row_12_col_0_chk_en), //Control Enable
                         .DIN               (~tcam_row_12_col_0_data_in), 
                         .DSEL              (~tcam_row_12_col_0_adr[0]), //dncen enables access of the TCAM Arrays adr_intessed
                         .FLS               (flush), //flush initiates a Flush operation that resets all Valid
                         .RVLD              (tcam_row_12_col_0_hit_in ), //Row validation bus. Each match_in input controls 1
                         .MASK              (tcam_row_12_col_0_mask_in), //Input msk
                         .QOUT              (tcam_row_12_col_0_data_out_inv), //Output vben
                         .QHR               (tcam_row_12_col_0_hit_out_int),
                         .QVLD              (), 
                         .RE                (tcam_row_12_col_0_rd_en), //Read Enable
                         .RST               (tcam_row_12_col_0_reset_n), //Asynchronous Active-High Reset
                         .VBE               (1'b1), //vben enables the Valid Bit addressed by adr[a-1:0] to
                         .VBI               (1'b0),//  Valid Bit Input
                         .WE                (tcam_row_12_col_0_wr_en), //Write Enable
                         .FAF               (tcam_row_12_col_0_fca),
                         .FAF_EN            (tcam_row_12_col_0_cre),
                         .DFTSHIFTEN        (tcam_row_12_col_0_dftshiften),
                         .DFTMASK           (tcam_row_12_col_0_dftmask),
                         .DFT_ARRAY_FREEZE  (tcam_row_12_col_0_dft_array_freeze),
                         .DFT_AFD_RESET_B   (tcam_row_12_col_0_dft_afd_reset_b),
                         .BISTE           (tcam_row_12_col_0_biste),
                         .TDIN (tcam_row_12_col_0_tdin),
                         .TADR (tcam_row_12_col_0_tadr),
                         .TVBE (tcam_row_12_col_0_tvbe),
                         .TVBI (tcam_row_12_col_0_tvbi),
                         .TMASK (tcam_row_12_col_0_tmask),
                         .TWE (tcam_row_12_col_0_twe),
                         .TRE (tcam_row_12_col_0_tre),
                         .TME (tcam_row_12_col_0_tme),
                         .BIST_ROTATE_SR (tcam_row_12_col_0_bist_rotate_sr),
                         .BIST_EN_SR_MASK_B (tcam_row_12_col_0_bist_en_sr_mask_b),
                         .BIST_ALL_MASK (tcam_row_12_col_0_bist_all_mask),
                         .BIST_EN_SR_DATA_B (tcam_row_12_col_0_bist_en_sr_data_b),
                         .BIST_CM_MODE (tcam_row_12_col_0_bist_cm_mode),
                         .BIST_CM_EN_IN (tcam_row_12_col_0_bist_cm_en_in),
                         .BIST_CM_MATCH_SEL0 (tcam_row_12_col_0_bist_cm_match_sel0),
                         .BIST_CM_MATCH_SEL1 (tcam_row_12_col_0_bist_cm_match_sel1),
                         .BIST_MATCHIN_IN (tcam_row_12_col_0_bist_matchin_in),
                         .BIST_FLS (tcam_row_12_col_0_bist_fls),
                         .MDST_tcam (fuse_tcam)
                     );
        
              end
              
            else
              begin : gen_tcam_row_12_col_0_bcam
              end
              
        
        
        endgenerate
        
        always_ff @(posedge clk) begin
                   tcam_rd_data_col[12][0]      <= tcam_row_12_col_0_data_out;
                   tcam_col_hit_out[12][0]       <= tcam_row_12_col_0_hit_out;
        end
        

        // this is new template - tcam_asic_template
        
        wire                                            tcam_row_12_col_1_clk         = clk;
        
        wire    [TCAM_SLICE_EN_FACT-1:0]                tcam_row_12_col_1_slice_en = TCAM_SLICE_EN_FACT'(slice_en[(12 * TCAM_SLICE_EN_FACT)+:TCAM_SLICE_EN_MIN]);
        
        wire                                            tcam_row_12_col_1_rd_en       = tcam_row_rd_en[12];
        wire                                            tcam_row_12_col_1_wr_en       = tcam_row_wr_en[12];
        wire                                            tcam_row_12_col_1_chk_en      = chk_en;
        wire                                            tcam_row_12_col_1_reset_n = reset_n;
        wire    [7-1:0]                       tcam_row_12_col_1_adr  = tcam_row_adr[12][7-1:0];
        wire    [32-1:0]                      tcam_row_12_col_1_data_in = tcam_row_wr_en[12] ? tcam_wr_data_col[1][32-1:0] : tcam_chk_key_col[1][32-1:0];
        wire    [32-1:0]                      tcam_row_12_col_1_data_in_pre = tcam_wr_data_col[1][32-1:0] ;
        wire    [32-1:0]                      tcam_row_12_col_1_key_in =  tcam_chk_key_col[1][32-1:0];
        wire    [32-1:0]                      tcam_row_12_col_1_mask_in = tcam_chk_mask_col[1][32-1:0];
        wire    [64-1:0]                       tcam_row_12_col_1_hit_in = tcam_raw_hit_in[12];
        wire    [64-1:0]                       tcam_row_12_col_1_tcam_match_in = tcam_row_match_in[12];
        wire    [32-1:0]                      tcam_row_12_col_1_data_out_inv;
        logic   [64-1:0]                     tcam_row_12_col_1_hit_out_int;
        logic   [64-1:0]                     tcam_row_12_col_1_hit_out_latch;
        logic   [64-1:0]                     tcam_row_12_col_1_hit_out;
        
        `ifdef HIF_PCIE_DFX_DISABLE
        wire                          tcam_row_12_col_1_biste = 'b0; 
        wire     [5-1:0]                  tcam_row_12_col_1_fca = 'b0;
        wire                            tcam_row_12_col_1_cre = 'b0;
        wire                            tcam_row_12_col_1_dftshiften = 'b0;
        wire                            tcam_row_12_col_1_dftmask = 'b0;
        wire                            tcam_row_12_col_1_dft_array_freeze = 'b0;
        wire                            tcam_row_12_col_1_dft_afd_reset_b = 'b0;
        wire      [32-1:0]    tcam_row_12_col_1_tdin = 'b0;
        wire      [7-1:0]     tcam_row_12_col_1_tadr = 'b0;
        wire                            tcam_row_12_col_1_tvbe = 'b0;
        wire                            tcam_row_12_col_1_tvbi = 'b0;
        wire      [32-1:0]    tcam_row_12_col_1_tmask = 'b0;
        wire                            tcam_row_12_col_1_twe = 'b0;
        wire                            tcam_row_12_col_1_tre = 'b0;
        wire                            tcam_row_12_col_1_tme = 'b0;
        wire                            tcam_row_12_col_1_bist_rotate_sr = 'b0;
        wire                            tcam_row_12_col_1_bist_en_sr_mask_b = 'b0;
        wire                            tcam_row_12_col_1_bist_all_mask = 'b0;
        wire                            tcam_row_12_col_1_bist_en_sr_data_b = 'b0;
        wire                            tcam_row_12_col_1_bist_cm_mode = 'b0;
        wire                            tcam_row_12_col_1_bist_cm_en_in = 'b0;
        wire                            tcam_row_12_col_1_bist_cm_match_sel0 = 'b0;
        wire                            tcam_row_12_col_1_bist_cm_match_sel1 = 'b0;
        wire                            tcam_row_12_col_1_bist_matchin_in = 'b0;
        wire                            tcam_row_12_col_1_bist_fls = 'b0;
        
        `else
        wire                            tcam_row_12_col_1_biste = 'b0;
        wire     [5-1:0]                  tcam_row_12_col_1_fca = 'b0;
        wire                            tcam_row_12_col_1_cre = 'b0;
        wire                            tcam_row_12_col_1_dftshiften = dftshiften;
        wire                            tcam_row_12_col_1_dftmask = dftmask;
        wire                            tcam_row_12_col_1_dft_array_freeze = dft_array_freeze;
        wire                            tcam_row_12_col_1_dft_afd_reset_b = dft_afd_reset_b;
        wire      [32-1:0]    tcam_row_12_col_1_tdin = 'b0;
        wire      [7-1:0]     tcam_row_12_col_1_tadr = 'b0;
        wire                            tcam_row_12_col_1_tvbe = 'b0;
        wire                            tcam_row_12_col_1_tvbi = 'b0;
        wire      [32-1:0]    tcam_row_12_col_1_tmask = 'b0;
        wire                            tcam_row_12_col_1_twe = 'b0;
        wire                            tcam_row_12_col_1_tre = 'b0;
        wire                            tcam_row_12_col_1_tme = 'b0;
        wire                            tcam_row_12_col_1_bist_rotate_sr = 'b0;
        wire                            tcam_row_12_col_1_bist_en_sr_mask_b = 'b0;
        wire                            tcam_row_12_col_1_bist_all_mask = 'b0;
        wire                            tcam_row_12_col_1_bist_en_sr_data_b = 'b0;
        wire                            tcam_row_12_col_1_bist_cm_mode = 'b0;
        wire                            tcam_row_12_col_1_bist_cm_en_in = 'b0;
        wire                            tcam_row_12_col_1_bist_cm_match_sel0 = 'b0;
        wire                            tcam_row_12_col_1_bist_cm_match_sel1 = 'b0;
        wire                            tcam_row_12_col_1_bist_matchin_in = 'b0;
        wire                            tcam_row_12_col_1_bist_fls = 'b0;
        `endif
        
        // Outputs
        logic                           tcam_row_12_col_1_wr_bira_fail;
        logic                           tcam_row_12_col_1_wr_so;
        logic                           tcam_row_12_col_1_curerrout;
        logic                           tcam_row_12_col_1_rscout;
        
        
        
        logic   [TCAM_SLICE_EN_FACT-1:0]                  tcam_row_12_col_1_slice_en_s0; 
        logic   [TCAM_SLICE_EN_FACT-1:0]                  tcam_row_12_col_1_slice_en_s1; 
        
        
        
             wire    [32-1:0]                     tcam_row_12_col_1_data_out ;
        
        
        
         generate
            if (BCAM_N7 == 0) 
              begin : gen_tcam_row_12_col_1_tcam
        
        
        // slice_en kept for TCAM only for backward compatability with Intel process
                always_comb 
                begin
                  for (int i = 0; i < TCAM_SLICE_EN_FACT; i++)
                      if (tcam_row_12_col_1_slice_en_s1[i])
                           tcam_row_12_col_1_hit_out[ i*64 +: 64]  = tcam_row_12_col_1_hit_out_int  [ i*64 +: 64]; 
                      else
                           tcam_row_12_col_1_hit_out[ i*64 +: 64]  = tcam_row_12_col_1_hit_out_latch[ i*64 +: 64]; 
                end
        
        
        
                always_ff  @(posedge tcam_row_12_col_1_clk)
                begin
                  tcam_row_12_col_1_slice_en_s0 <= tcam_row_12_col_1_slice_en; 
                  tcam_row_12_col_1_slice_en_s1 <= tcam_row_12_col_1_slice_en_s0; 
        
                  for (int i = 0; i < TCAM_SLICE_EN_FACT; i++)
                    begin
                      if (tcam_row_12_col_1_slice_en_s1[i])
                         tcam_row_12_col_1_hit_out_latch[ i*64 +: 64] <=  tcam_row_12_col_1_hit_out_int[ i*64 +: 64];
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
        
                     
                         assign tcam_row_12_col_1_data_out  = ~tcam_row_12_col_1_data_out_inv;
                         pcie_itp_ip783tcam64x32s0c1_12_1_wrap #(        
                                 )               
        
                                 ip783tcam64x32s0c1_wrap_tcam_row_12_col_1 (
                   //-------------------------------------------------------------
                   // Power Management Interfaces
                   //-------------------------------------------------------------   
                      `ifndef INTEL_NO_PWR_PINS
                      `ifdef INTC_ADD_VSS
                        .vss              (1'b0),
                      `endif
                        .vddp             (1'b1),
                      `endif
                         .ADR               (tcam_row_12_col_1_adr[7-1:1]), //Input adr_intess
                         .ME                (ce),  
        
                         .CLK               (tcam_row_12_col_1_clk), //Clock
                         .CMP               (tcam_row_12_col_1_chk_en), //Control Enable
                         .DIN               (~tcam_row_12_col_1_data_in), 
                         .DSEL              (~tcam_row_12_col_1_adr[0]), //dncen enables access of the TCAM Arrays adr_intessed
                         .FLS               (flush), //flush initiates a Flush operation that resets all Valid
                         .RVLD              (tcam_row_12_col_1_hit_in ), //Row validation bus. Each match_in input controls 1
                         .MASK              (tcam_row_12_col_1_mask_in), //Input msk
                         .QOUT              (tcam_row_12_col_1_data_out_inv), //Output vben
                         .QHR               (tcam_row_12_col_1_hit_out_int),
                         .QVLD              (), 
                         .RE                (tcam_row_12_col_1_rd_en), //Read Enable
                         .RST               (tcam_row_12_col_1_reset_n), //Asynchronous Active-High Reset
                         .VBE               (1'b1), //vben enables the Valid Bit addressed by adr[a-1:0] to
                         .VBI               (1'b0),//  Valid Bit Input
                         .WE                (tcam_row_12_col_1_wr_en), //Write Enable
                         .FAF               (tcam_row_12_col_1_fca),
                         .FAF_EN            (tcam_row_12_col_1_cre),
                         .DFTSHIFTEN        (tcam_row_12_col_1_dftshiften),
                         .DFTMASK           (tcam_row_12_col_1_dftmask),
                         .DFT_ARRAY_FREEZE  (tcam_row_12_col_1_dft_array_freeze),
                         .DFT_AFD_RESET_B   (tcam_row_12_col_1_dft_afd_reset_b),
                         .BISTE           (tcam_row_12_col_1_biste),
                         .TDIN (tcam_row_12_col_1_tdin),
                         .TADR (tcam_row_12_col_1_tadr),
                         .TVBE (tcam_row_12_col_1_tvbe),
                         .TVBI (tcam_row_12_col_1_tvbi),
                         .TMASK (tcam_row_12_col_1_tmask),
                         .TWE (tcam_row_12_col_1_twe),
                         .TRE (tcam_row_12_col_1_tre),
                         .TME (tcam_row_12_col_1_tme),
                         .BIST_ROTATE_SR (tcam_row_12_col_1_bist_rotate_sr),
                         .BIST_EN_SR_MASK_B (tcam_row_12_col_1_bist_en_sr_mask_b),
                         .BIST_ALL_MASK (tcam_row_12_col_1_bist_all_mask),
                         .BIST_EN_SR_DATA_B (tcam_row_12_col_1_bist_en_sr_data_b),
                         .BIST_CM_MODE (tcam_row_12_col_1_bist_cm_mode),
                         .BIST_CM_EN_IN (tcam_row_12_col_1_bist_cm_en_in),
                         .BIST_CM_MATCH_SEL0 (tcam_row_12_col_1_bist_cm_match_sel0),
                         .BIST_CM_MATCH_SEL1 (tcam_row_12_col_1_bist_cm_match_sel1),
                         .BIST_MATCHIN_IN (tcam_row_12_col_1_bist_matchin_in),
                         .BIST_FLS (tcam_row_12_col_1_bist_fls),
                         .MDST_tcam (fuse_tcam)
                     );
        
              end
              
            else
              begin : gen_tcam_row_12_col_1_bcam
              end
              
        
        
        endgenerate
        
        always_ff @(posedge clk) begin
                   tcam_rd_data_col[12][1]      <= tcam_row_12_col_1_data_out;
                   tcam_col_hit_out[12][1]       <= tcam_row_12_col_1_hit_out;
        end
        

        // this is new template - tcam_asic_template
        
        wire                                            tcam_row_13_col_0_clk         = clk;
        
        wire    [TCAM_SLICE_EN_FACT-1:0]                tcam_row_13_col_0_slice_en = TCAM_SLICE_EN_FACT'(slice_en[(13 * TCAM_SLICE_EN_FACT)+:TCAM_SLICE_EN_MIN]);
        
        wire                                            tcam_row_13_col_0_rd_en       = tcam_row_rd_en[13];
        wire                                            tcam_row_13_col_0_wr_en       = tcam_row_wr_en[13];
        wire                                            tcam_row_13_col_0_chk_en      = chk_en;
        wire                                            tcam_row_13_col_0_reset_n = reset_n;
        wire    [7-1:0]                       tcam_row_13_col_0_adr  = tcam_row_adr[13][7-1:0];
        wire    [32-1:0]                      tcam_row_13_col_0_data_in = tcam_row_wr_en[13] ? tcam_wr_data_col[0][32-1:0] : tcam_chk_key_col[0][32-1:0];
        wire    [32-1:0]                      tcam_row_13_col_0_data_in_pre = tcam_wr_data_col[0][32-1:0] ;
        wire    [32-1:0]                      tcam_row_13_col_0_key_in =  tcam_chk_key_col[0][32-1:0];
        wire    [32-1:0]                      tcam_row_13_col_0_mask_in = tcam_chk_mask_col[0][32-1:0];
        wire    [64-1:0]                       tcam_row_13_col_0_hit_in = tcam_raw_hit_in[13];
        wire    [64-1:0]                       tcam_row_13_col_0_tcam_match_in = tcam_row_match_in[13];
        wire    [32-1:0]                      tcam_row_13_col_0_data_out_inv;
        logic   [64-1:0]                     tcam_row_13_col_0_hit_out_int;
        logic   [64-1:0]                     tcam_row_13_col_0_hit_out_latch;
        logic   [64-1:0]                     tcam_row_13_col_0_hit_out;
        
        `ifdef HIF_PCIE_DFX_DISABLE
        wire                          tcam_row_13_col_0_biste = 'b0; 
        wire     [5-1:0]                  tcam_row_13_col_0_fca = 'b0;
        wire                            tcam_row_13_col_0_cre = 'b0;
        wire                            tcam_row_13_col_0_dftshiften = 'b0;
        wire                            tcam_row_13_col_0_dftmask = 'b0;
        wire                            tcam_row_13_col_0_dft_array_freeze = 'b0;
        wire                            tcam_row_13_col_0_dft_afd_reset_b = 'b0;
        wire      [32-1:0]    tcam_row_13_col_0_tdin = 'b0;
        wire      [7-1:0]     tcam_row_13_col_0_tadr = 'b0;
        wire                            tcam_row_13_col_0_tvbe = 'b0;
        wire                            tcam_row_13_col_0_tvbi = 'b0;
        wire      [32-1:0]    tcam_row_13_col_0_tmask = 'b0;
        wire                            tcam_row_13_col_0_twe = 'b0;
        wire                            tcam_row_13_col_0_tre = 'b0;
        wire                            tcam_row_13_col_0_tme = 'b0;
        wire                            tcam_row_13_col_0_bist_rotate_sr = 'b0;
        wire                            tcam_row_13_col_0_bist_en_sr_mask_b = 'b0;
        wire                            tcam_row_13_col_0_bist_all_mask = 'b0;
        wire                            tcam_row_13_col_0_bist_en_sr_data_b = 'b0;
        wire                            tcam_row_13_col_0_bist_cm_mode = 'b0;
        wire                            tcam_row_13_col_0_bist_cm_en_in = 'b0;
        wire                            tcam_row_13_col_0_bist_cm_match_sel0 = 'b0;
        wire                            tcam_row_13_col_0_bist_cm_match_sel1 = 'b0;
        wire                            tcam_row_13_col_0_bist_matchin_in = 'b0;
        wire                            tcam_row_13_col_0_bist_fls = 'b0;
        
        `else
        wire                            tcam_row_13_col_0_biste = 'b0;
        wire     [5-1:0]                  tcam_row_13_col_0_fca = 'b0;
        wire                            tcam_row_13_col_0_cre = 'b0;
        wire                            tcam_row_13_col_0_dftshiften = dftshiften;
        wire                            tcam_row_13_col_0_dftmask = dftmask;
        wire                            tcam_row_13_col_0_dft_array_freeze = dft_array_freeze;
        wire                            tcam_row_13_col_0_dft_afd_reset_b = dft_afd_reset_b;
        wire      [32-1:0]    tcam_row_13_col_0_tdin = 'b0;
        wire      [7-1:0]     tcam_row_13_col_0_tadr = 'b0;
        wire                            tcam_row_13_col_0_tvbe = 'b0;
        wire                            tcam_row_13_col_0_tvbi = 'b0;
        wire      [32-1:0]    tcam_row_13_col_0_tmask = 'b0;
        wire                            tcam_row_13_col_0_twe = 'b0;
        wire                            tcam_row_13_col_0_tre = 'b0;
        wire                            tcam_row_13_col_0_tme = 'b0;
        wire                            tcam_row_13_col_0_bist_rotate_sr = 'b0;
        wire                            tcam_row_13_col_0_bist_en_sr_mask_b = 'b0;
        wire                            tcam_row_13_col_0_bist_all_mask = 'b0;
        wire                            tcam_row_13_col_0_bist_en_sr_data_b = 'b0;
        wire                            tcam_row_13_col_0_bist_cm_mode = 'b0;
        wire                            tcam_row_13_col_0_bist_cm_en_in = 'b0;
        wire                            tcam_row_13_col_0_bist_cm_match_sel0 = 'b0;
        wire                            tcam_row_13_col_0_bist_cm_match_sel1 = 'b0;
        wire                            tcam_row_13_col_0_bist_matchin_in = 'b0;
        wire                            tcam_row_13_col_0_bist_fls = 'b0;
        `endif
        
        // Outputs
        logic                           tcam_row_13_col_0_wr_bira_fail;
        logic                           tcam_row_13_col_0_wr_so;
        logic                           tcam_row_13_col_0_curerrout;
        logic                           tcam_row_13_col_0_rscout;
        
        
        
        logic   [TCAM_SLICE_EN_FACT-1:0]                  tcam_row_13_col_0_slice_en_s0; 
        logic   [TCAM_SLICE_EN_FACT-1:0]                  tcam_row_13_col_0_slice_en_s1; 
        
        
        
             wire    [32-1:0]                     tcam_row_13_col_0_data_out ;
        
        
        
         generate
            if (BCAM_N7 == 0) 
              begin : gen_tcam_row_13_col_0_tcam
        
        
        // slice_en kept for TCAM only for backward compatability with Intel process
                always_comb 
                begin
                  for (int i = 0; i < TCAM_SLICE_EN_FACT; i++)
                      if (tcam_row_13_col_0_slice_en_s1[i])
                           tcam_row_13_col_0_hit_out[ i*64 +: 64]  = tcam_row_13_col_0_hit_out_int  [ i*64 +: 64]; 
                      else
                           tcam_row_13_col_0_hit_out[ i*64 +: 64]  = tcam_row_13_col_0_hit_out_latch[ i*64 +: 64]; 
                end
        
        
        
                always_ff  @(posedge tcam_row_13_col_0_clk)
                begin
                  tcam_row_13_col_0_slice_en_s0 <= tcam_row_13_col_0_slice_en; 
                  tcam_row_13_col_0_slice_en_s1 <= tcam_row_13_col_0_slice_en_s0; 
        
                  for (int i = 0; i < TCAM_SLICE_EN_FACT; i++)
                    begin
                      if (tcam_row_13_col_0_slice_en_s1[i])
                         tcam_row_13_col_0_hit_out_latch[ i*64 +: 64] <=  tcam_row_13_col_0_hit_out_int[ i*64 +: 64];
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
        
                     
                         assign tcam_row_13_col_0_data_out  = ~tcam_row_13_col_0_data_out_inv;
                         pcie_itp_ip783tcam64x32s0c1_13_0_wrap #(        
                                 )               
        
                                 ip783tcam64x32s0c1_wrap_tcam_row_13_col_0 (
                   //-------------------------------------------------------------
                   // Power Management Interfaces
                   //-------------------------------------------------------------   
                      `ifndef INTEL_NO_PWR_PINS
                      `ifdef INTC_ADD_VSS
                        .vss              (1'b0),
                      `endif
                        .vddp             (1'b1),
                      `endif
                         .ADR               (tcam_row_13_col_0_adr[7-1:1]), //Input adr_intess
                         .ME                (ce),  
        
                         .CLK               (tcam_row_13_col_0_clk), //Clock
                         .CMP               (tcam_row_13_col_0_chk_en), //Control Enable
                         .DIN               (~tcam_row_13_col_0_data_in), 
                         .DSEL              (~tcam_row_13_col_0_adr[0]), //dncen enables access of the TCAM Arrays adr_intessed
                         .FLS               (flush), //flush initiates a Flush operation that resets all Valid
                         .RVLD              (tcam_row_13_col_0_hit_in ), //Row validation bus. Each match_in input controls 1
                         .MASK              (tcam_row_13_col_0_mask_in), //Input msk
                         .QOUT              (tcam_row_13_col_0_data_out_inv), //Output vben
                         .QHR               (tcam_row_13_col_0_hit_out_int),
                         .QVLD              (), 
                         .RE                (tcam_row_13_col_0_rd_en), //Read Enable
                         .RST               (tcam_row_13_col_0_reset_n), //Asynchronous Active-High Reset
                         .VBE               (1'b1), //vben enables the Valid Bit addressed by adr[a-1:0] to
                         .VBI               (1'b0),//  Valid Bit Input
                         .WE                (tcam_row_13_col_0_wr_en), //Write Enable
                         .FAF               (tcam_row_13_col_0_fca),
                         .FAF_EN            (tcam_row_13_col_0_cre),
                         .DFTSHIFTEN        (tcam_row_13_col_0_dftshiften),
                         .DFTMASK           (tcam_row_13_col_0_dftmask),
                         .DFT_ARRAY_FREEZE  (tcam_row_13_col_0_dft_array_freeze),
                         .DFT_AFD_RESET_B   (tcam_row_13_col_0_dft_afd_reset_b),
                         .BISTE           (tcam_row_13_col_0_biste),
                         .TDIN (tcam_row_13_col_0_tdin),
                         .TADR (tcam_row_13_col_0_tadr),
                         .TVBE (tcam_row_13_col_0_tvbe),
                         .TVBI (tcam_row_13_col_0_tvbi),
                         .TMASK (tcam_row_13_col_0_tmask),
                         .TWE (tcam_row_13_col_0_twe),
                         .TRE (tcam_row_13_col_0_tre),
                         .TME (tcam_row_13_col_0_tme),
                         .BIST_ROTATE_SR (tcam_row_13_col_0_bist_rotate_sr),
                         .BIST_EN_SR_MASK_B (tcam_row_13_col_0_bist_en_sr_mask_b),
                         .BIST_ALL_MASK (tcam_row_13_col_0_bist_all_mask),
                         .BIST_EN_SR_DATA_B (tcam_row_13_col_0_bist_en_sr_data_b),
                         .BIST_CM_MODE (tcam_row_13_col_0_bist_cm_mode),
                         .BIST_CM_EN_IN (tcam_row_13_col_0_bist_cm_en_in),
                         .BIST_CM_MATCH_SEL0 (tcam_row_13_col_0_bist_cm_match_sel0),
                         .BIST_CM_MATCH_SEL1 (tcam_row_13_col_0_bist_cm_match_sel1),
                         .BIST_MATCHIN_IN (tcam_row_13_col_0_bist_matchin_in),
                         .BIST_FLS (tcam_row_13_col_0_bist_fls),
                         .MDST_tcam (fuse_tcam)
                     );
        
              end
              
            else
              begin : gen_tcam_row_13_col_0_bcam
              end
              
        
        
        endgenerate
        
        always_ff @(posedge clk) begin
                   tcam_rd_data_col[13][0]      <= tcam_row_13_col_0_data_out;
                   tcam_col_hit_out[13][0]       <= tcam_row_13_col_0_hit_out;
        end
        

        // this is new template - tcam_asic_template
        
        wire                                            tcam_row_13_col_1_clk         = clk;
        
        wire    [TCAM_SLICE_EN_FACT-1:0]                tcam_row_13_col_1_slice_en = TCAM_SLICE_EN_FACT'(slice_en[(13 * TCAM_SLICE_EN_FACT)+:TCAM_SLICE_EN_MIN]);
        
        wire                                            tcam_row_13_col_1_rd_en       = tcam_row_rd_en[13];
        wire                                            tcam_row_13_col_1_wr_en       = tcam_row_wr_en[13];
        wire                                            tcam_row_13_col_1_chk_en      = chk_en;
        wire                                            tcam_row_13_col_1_reset_n = reset_n;
        wire    [7-1:0]                       tcam_row_13_col_1_adr  = tcam_row_adr[13][7-1:0];
        wire    [32-1:0]                      tcam_row_13_col_1_data_in = tcam_row_wr_en[13] ? tcam_wr_data_col[1][32-1:0] : tcam_chk_key_col[1][32-1:0];
        wire    [32-1:0]                      tcam_row_13_col_1_data_in_pre = tcam_wr_data_col[1][32-1:0] ;
        wire    [32-1:0]                      tcam_row_13_col_1_key_in =  tcam_chk_key_col[1][32-1:0];
        wire    [32-1:0]                      tcam_row_13_col_1_mask_in = tcam_chk_mask_col[1][32-1:0];
        wire    [64-1:0]                       tcam_row_13_col_1_hit_in = tcam_raw_hit_in[13];
        wire    [64-1:0]                       tcam_row_13_col_1_tcam_match_in = tcam_row_match_in[13];
        wire    [32-1:0]                      tcam_row_13_col_1_data_out_inv;
        logic   [64-1:0]                     tcam_row_13_col_1_hit_out_int;
        logic   [64-1:0]                     tcam_row_13_col_1_hit_out_latch;
        logic   [64-1:0]                     tcam_row_13_col_1_hit_out;
        
        `ifdef HIF_PCIE_DFX_DISABLE
        wire                          tcam_row_13_col_1_biste = 'b0; 
        wire     [5-1:0]                  tcam_row_13_col_1_fca = 'b0;
        wire                            tcam_row_13_col_1_cre = 'b0;
        wire                            tcam_row_13_col_1_dftshiften = 'b0;
        wire                            tcam_row_13_col_1_dftmask = 'b0;
        wire                            tcam_row_13_col_1_dft_array_freeze = 'b0;
        wire                            tcam_row_13_col_1_dft_afd_reset_b = 'b0;
        wire      [32-1:0]    tcam_row_13_col_1_tdin = 'b0;
        wire      [7-1:0]     tcam_row_13_col_1_tadr = 'b0;
        wire                            tcam_row_13_col_1_tvbe = 'b0;
        wire                            tcam_row_13_col_1_tvbi = 'b0;
        wire      [32-1:0]    tcam_row_13_col_1_tmask = 'b0;
        wire                            tcam_row_13_col_1_twe = 'b0;
        wire                            tcam_row_13_col_1_tre = 'b0;
        wire                            tcam_row_13_col_1_tme = 'b0;
        wire                            tcam_row_13_col_1_bist_rotate_sr = 'b0;
        wire                            tcam_row_13_col_1_bist_en_sr_mask_b = 'b0;
        wire                            tcam_row_13_col_1_bist_all_mask = 'b0;
        wire                            tcam_row_13_col_1_bist_en_sr_data_b = 'b0;
        wire                            tcam_row_13_col_1_bist_cm_mode = 'b0;
        wire                            tcam_row_13_col_1_bist_cm_en_in = 'b0;
        wire                            tcam_row_13_col_1_bist_cm_match_sel0 = 'b0;
        wire                            tcam_row_13_col_1_bist_cm_match_sel1 = 'b0;
        wire                            tcam_row_13_col_1_bist_matchin_in = 'b0;
        wire                            tcam_row_13_col_1_bist_fls = 'b0;
        
        `else
        wire                            tcam_row_13_col_1_biste = 'b0;
        wire     [5-1:0]                  tcam_row_13_col_1_fca = 'b0;
        wire                            tcam_row_13_col_1_cre = 'b0;
        wire                            tcam_row_13_col_1_dftshiften = dftshiften;
        wire                            tcam_row_13_col_1_dftmask = dftmask;
        wire                            tcam_row_13_col_1_dft_array_freeze = dft_array_freeze;
        wire                            tcam_row_13_col_1_dft_afd_reset_b = dft_afd_reset_b;
        wire      [32-1:0]    tcam_row_13_col_1_tdin = 'b0;
        wire      [7-1:0]     tcam_row_13_col_1_tadr = 'b0;
        wire                            tcam_row_13_col_1_tvbe = 'b0;
        wire                            tcam_row_13_col_1_tvbi = 'b0;
        wire      [32-1:0]    tcam_row_13_col_1_tmask = 'b0;
        wire                            tcam_row_13_col_1_twe = 'b0;
        wire                            tcam_row_13_col_1_tre = 'b0;
        wire                            tcam_row_13_col_1_tme = 'b0;
        wire                            tcam_row_13_col_1_bist_rotate_sr = 'b0;
        wire                            tcam_row_13_col_1_bist_en_sr_mask_b = 'b0;
        wire                            tcam_row_13_col_1_bist_all_mask = 'b0;
        wire                            tcam_row_13_col_1_bist_en_sr_data_b = 'b0;
        wire                            tcam_row_13_col_1_bist_cm_mode = 'b0;
        wire                            tcam_row_13_col_1_bist_cm_en_in = 'b0;
        wire                            tcam_row_13_col_1_bist_cm_match_sel0 = 'b0;
        wire                            tcam_row_13_col_1_bist_cm_match_sel1 = 'b0;
        wire                            tcam_row_13_col_1_bist_matchin_in = 'b0;
        wire                            tcam_row_13_col_1_bist_fls = 'b0;
        `endif
        
        // Outputs
        logic                           tcam_row_13_col_1_wr_bira_fail;
        logic                           tcam_row_13_col_1_wr_so;
        logic                           tcam_row_13_col_1_curerrout;
        logic                           tcam_row_13_col_1_rscout;
        
        
        
        logic   [TCAM_SLICE_EN_FACT-1:0]                  tcam_row_13_col_1_slice_en_s0; 
        logic   [TCAM_SLICE_EN_FACT-1:0]                  tcam_row_13_col_1_slice_en_s1; 
        
        
        
             wire    [32-1:0]                     tcam_row_13_col_1_data_out ;
        
        
        
         generate
            if (BCAM_N7 == 0) 
              begin : gen_tcam_row_13_col_1_tcam
        
        
        // slice_en kept for TCAM only for backward compatability with Intel process
                always_comb 
                begin
                  for (int i = 0; i < TCAM_SLICE_EN_FACT; i++)
                      if (tcam_row_13_col_1_slice_en_s1[i])
                           tcam_row_13_col_1_hit_out[ i*64 +: 64]  = tcam_row_13_col_1_hit_out_int  [ i*64 +: 64]; 
                      else
                           tcam_row_13_col_1_hit_out[ i*64 +: 64]  = tcam_row_13_col_1_hit_out_latch[ i*64 +: 64]; 
                end
        
        
        
                always_ff  @(posedge tcam_row_13_col_1_clk)
                begin
                  tcam_row_13_col_1_slice_en_s0 <= tcam_row_13_col_1_slice_en; 
                  tcam_row_13_col_1_slice_en_s1 <= tcam_row_13_col_1_slice_en_s0; 
        
                  for (int i = 0; i < TCAM_SLICE_EN_FACT; i++)
                    begin
                      if (tcam_row_13_col_1_slice_en_s1[i])
                         tcam_row_13_col_1_hit_out_latch[ i*64 +: 64] <=  tcam_row_13_col_1_hit_out_int[ i*64 +: 64];
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
        
                     
                         assign tcam_row_13_col_1_data_out  = ~tcam_row_13_col_1_data_out_inv;
                         pcie_itp_ip783tcam64x32s0c1_13_1_wrap #(        
                                 )               
        
                                 ip783tcam64x32s0c1_wrap_tcam_row_13_col_1 (
                   //-------------------------------------------------------------
                   // Power Management Interfaces
                   //-------------------------------------------------------------   
                      `ifndef INTEL_NO_PWR_PINS
                      `ifdef INTC_ADD_VSS
                        .vss              (1'b0),
                      `endif
                        .vddp             (1'b1),
                      `endif
                         .ADR               (tcam_row_13_col_1_adr[7-1:1]), //Input adr_intess
                         .ME                (ce),  
        
                         .CLK               (tcam_row_13_col_1_clk), //Clock
                         .CMP               (tcam_row_13_col_1_chk_en), //Control Enable
                         .DIN               (~tcam_row_13_col_1_data_in), 
                         .DSEL              (~tcam_row_13_col_1_adr[0]), //dncen enables access of the TCAM Arrays adr_intessed
                         .FLS               (flush), //flush initiates a Flush operation that resets all Valid
                         .RVLD              (tcam_row_13_col_1_hit_in ), //Row validation bus. Each match_in input controls 1
                         .MASK              (tcam_row_13_col_1_mask_in), //Input msk
                         .QOUT              (tcam_row_13_col_1_data_out_inv), //Output vben
                         .QHR               (tcam_row_13_col_1_hit_out_int),
                         .QVLD              (), 
                         .RE                (tcam_row_13_col_1_rd_en), //Read Enable
                         .RST               (tcam_row_13_col_1_reset_n), //Asynchronous Active-High Reset
                         .VBE               (1'b1), //vben enables the Valid Bit addressed by adr[a-1:0] to
                         .VBI               (1'b0),//  Valid Bit Input
                         .WE                (tcam_row_13_col_1_wr_en), //Write Enable
                         .FAF               (tcam_row_13_col_1_fca),
                         .FAF_EN            (tcam_row_13_col_1_cre),
                         .DFTSHIFTEN        (tcam_row_13_col_1_dftshiften),
                         .DFTMASK           (tcam_row_13_col_1_dftmask),
                         .DFT_ARRAY_FREEZE  (tcam_row_13_col_1_dft_array_freeze),
                         .DFT_AFD_RESET_B   (tcam_row_13_col_1_dft_afd_reset_b),
                         .BISTE           (tcam_row_13_col_1_biste),
                         .TDIN (tcam_row_13_col_1_tdin),
                         .TADR (tcam_row_13_col_1_tadr),
                         .TVBE (tcam_row_13_col_1_tvbe),
                         .TVBI (tcam_row_13_col_1_tvbi),
                         .TMASK (tcam_row_13_col_1_tmask),
                         .TWE (tcam_row_13_col_1_twe),
                         .TRE (tcam_row_13_col_1_tre),
                         .TME (tcam_row_13_col_1_tme),
                         .BIST_ROTATE_SR (tcam_row_13_col_1_bist_rotate_sr),
                         .BIST_EN_SR_MASK_B (tcam_row_13_col_1_bist_en_sr_mask_b),
                         .BIST_ALL_MASK (tcam_row_13_col_1_bist_all_mask),
                         .BIST_EN_SR_DATA_B (tcam_row_13_col_1_bist_en_sr_data_b),
                         .BIST_CM_MODE (tcam_row_13_col_1_bist_cm_mode),
                         .BIST_CM_EN_IN (tcam_row_13_col_1_bist_cm_en_in),
                         .BIST_CM_MATCH_SEL0 (tcam_row_13_col_1_bist_cm_match_sel0),
                         .BIST_CM_MATCH_SEL1 (tcam_row_13_col_1_bist_cm_match_sel1),
                         .BIST_MATCHIN_IN (tcam_row_13_col_1_bist_matchin_in),
                         .BIST_FLS (tcam_row_13_col_1_bist_fls),
                         .MDST_tcam (fuse_tcam)
                     );
        
              end
              
            else
              begin : gen_tcam_row_13_col_1_bcam
              end
              
        
        
        endgenerate
        
        always_ff @(posedge clk) begin
                   tcam_rd_data_col[13][1]      <= tcam_row_13_col_1_data_out;
                   tcam_col_hit_out[13][1]       <= tcam_row_13_col_1_hit_out;
        end
        

        // this is new template - tcam_asic_template
        
        wire                                            tcam_row_14_col_0_clk         = clk;
        
        wire    [TCAM_SLICE_EN_FACT-1:0]                tcam_row_14_col_0_slice_en = TCAM_SLICE_EN_FACT'(slice_en[(14 * TCAM_SLICE_EN_FACT)+:TCAM_SLICE_EN_MIN]);
        
        wire                                            tcam_row_14_col_0_rd_en       = tcam_row_rd_en[14];
        wire                                            tcam_row_14_col_0_wr_en       = tcam_row_wr_en[14];
        wire                                            tcam_row_14_col_0_chk_en      = chk_en;
        wire                                            tcam_row_14_col_0_reset_n = reset_n;
        wire    [7-1:0]                       tcam_row_14_col_0_adr  = tcam_row_adr[14][7-1:0];
        wire    [32-1:0]                      tcam_row_14_col_0_data_in = tcam_row_wr_en[14] ? tcam_wr_data_col[0][32-1:0] : tcam_chk_key_col[0][32-1:0];
        wire    [32-1:0]                      tcam_row_14_col_0_data_in_pre = tcam_wr_data_col[0][32-1:0] ;
        wire    [32-1:0]                      tcam_row_14_col_0_key_in =  tcam_chk_key_col[0][32-1:0];
        wire    [32-1:0]                      tcam_row_14_col_0_mask_in = tcam_chk_mask_col[0][32-1:0];
        wire    [64-1:0]                       tcam_row_14_col_0_hit_in = tcam_raw_hit_in[14];
        wire    [64-1:0]                       tcam_row_14_col_0_tcam_match_in = tcam_row_match_in[14];
        wire    [32-1:0]                      tcam_row_14_col_0_data_out_inv;
        logic   [64-1:0]                     tcam_row_14_col_0_hit_out_int;
        logic   [64-1:0]                     tcam_row_14_col_0_hit_out_latch;
        logic   [64-1:0]                     tcam_row_14_col_0_hit_out;
        
        `ifdef HIF_PCIE_DFX_DISABLE
        wire                          tcam_row_14_col_0_biste = 'b0; 
        wire     [5-1:0]                  tcam_row_14_col_0_fca = 'b0;
        wire                            tcam_row_14_col_0_cre = 'b0;
        wire                            tcam_row_14_col_0_dftshiften = 'b0;
        wire                            tcam_row_14_col_0_dftmask = 'b0;
        wire                            tcam_row_14_col_0_dft_array_freeze = 'b0;
        wire                            tcam_row_14_col_0_dft_afd_reset_b = 'b0;
        wire      [32-1:0]    tcam_row_14_col_0_tdin = 'b0;
        wire      [7-1:0]     tcam_row_14_col_0_tadr = 'b0;
        wire                            tcam_row_14_col_0_tvbe = 'b0;
        wire                            tcam_row_14_col_0_tvbi = 'b0;
        wire      [32-1:0]    tcam_row_14_col_0_tmask = 'b0;
        wire                            tcam_row_14_col_0_twe = 'b0;
        wire                            tcam_row_14_col_0_tre = 'b0;
        wire                            tcam_row_14_col_0_tme = 'b0;
        wire                            tcam_row_14_col_0_bist_rotate_sr = 'b0;
        wire                            tcam_row_14_col_0_bist_en_sr_mask_b = 'b0;
        wire                            tcam_row_14_col_0_bist_all_mask = 'b0;
        wire                            tcam_row_14_col_0_bist_en_sr_data_b = 'b0;
        wire                            tcam_row_14_col_0_bist_cm_mode = 'b0;
        wire                            tcam_row_14_col_0_bist_cm_en_in = 'b0;
        wire                            tcam_row_14_col_0_bist_cm_match_sel0 = 'b0;
        wire                            tcam_row_14_col_0_bist_cm_match_sel1 = 'b0;
        wire                            tcam_row_14_col_0_bist_matchin_in = 'b0;
        wire                            tcam_row_14_col_0_bist_fls = 'b0;
        
        `else
        wire                            tcam_row_14_col_0_biste = 'b0;
        wire     [5-1:0]                  tcam_row_14_col_0_fca = 'b0;
        wire                            tcam_row_14_col_0_cre = 'b0;
        wire                            tcam_row_14_col_0_dftshiften = dftshiften;
        wire                            tcam_row_14_col_0_dftmask = dftmask;
        wire                            tcam_row_14_col_0_dft_array_freeze = dft_array_freeze;
        wire                            tcam_row_14_col_0_dft_afd_reset_b = dft_afd_reset_b;
        wire      [32-1:0]    tcam_row_14_col_0_tdin = 'b0;
        wire      [7-1:0]     tcam_row_14_col_0_tadr = 'b0;
        wire                            tcam_row_14_col_0_tvbe = 'b0;
        wire                            tcam_row_14_col_0_tvbi = 'b0;
        wire      [32-1:0]    tcam_row_14_col_0_tmask = 'b0;
        wire                            tcam_row_14_col_0_twe = 'b0;
        wire                            tcam_row_14_col_0_tre = 'b0;
        wire                            tcam_row_14_col_0_tme = 'b0;
        wire                            tcam_row_14_col_0_bist_rotate_sr = 'b0;
        wire                            tcam_row_14_col_0_bist_en_sr_mask_b = 'b0;
        wire                            tcam_row_14_col_0_bist_all_mask = 'b0;
        wire                            tcam_row_14_col_0_bist_en_sr_data_b = 'b0;
        wire                            tcam_row_14_col_0_bist_cm_mode = 'b0;
        wire                            tcam_row_14_col_0_bist_cm_en_in = 'b0;
        wire                            tcam_row_14_col_0_bist_cm_match_sel0 = 'b0;
        wire                            tcam_row_14_col_0_bist_cm_match_sel1 = 'b0;
        wire                            tcam_row_14_col_0_bist_matchin_in = 'b0;
        wire                            tcam_row_14_col_0_bist_fls = 'b0;
        `endif
        
        // Outputs
        logic                           tcam_row_14_col_0_wr_bira_fail;
        logic                           tcam_row_14_col_0_wr_so;
        logic                           tcam_row_14_col_0_curerrout;
        logic                           tcam_row_14_col_0_rscout;
        
        
        
        logic   [TCAM_SLICE_EN_FACT-1:0]                  tcam_row_14_col_0_slice_en_s0; 
        logic   [TCAM_SLICE_EN_FACT-1:0]                  tcam_row_14_col_0_slice_en_s1; 
        
        
        
             wire    [32-1:0]                     tcam_row_14_col_0_data_out ;
        
        
        
         generate
            if (BCAM_N7 == 0) 
              begin : gen_tcam_row_14_col_0_tcam
        
        
        // slice_en kept for TCAM only for backward compatability with Intel process
                always_comb 
                begin
                  for (int i = 0; i < TCAM_SLICE_EN_FACT; i++)
                      if (tcam_row_14_col_0_slice_en_s1[i])
                           tcam_row_14_col_0_hit_out[ i*64 +: 64]  = tcam_row_14_col_0_hit_out_int  [ i*64 +: 64]; 
                      else
                           tcam_row_14_col_0_hit_out[ i*64 +: 64]  = tcam_row_14_col_0_hit_out_latch[ i*64 +: 64]; 
                end
        
        
        
                always_ff  @(posedge tcam_row_14_col_0_clk)
                begin
                  tcam_row_14_col_0_slice_en_s0 <= tcam_row_14_col_0_slice_en; 
                  tcam_row_14_col_0_slice_en_s1 <= tcam_row_14_col_0_slice_en_s0; 
        
                  for (int i = 0; i < TCAM_SLICE_EN_FACT; i++)
                    begin
                      if (tcam_row_14_col_0_slice_en_s1[i])
                         tcam_row_14_col_0_hit_out_latch[ i*64 +: 64] <=  tcam_row_14_col_0_hit_out_int[ i*64 +: 64];
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
        
                     
                         assign tcam_row_14_col_0_data_out  = ~tcam_row_14_col_0_data_out_inv;
                         pcie_itp_ip783tcam64x32s0c1_14_0_wrap #(        
                                 )               
        
                                 ip783tcam64x32s0c1_wrap_tcam_row_14_col_0 (
                   //-------------------------------------------------------------
                   // Power Management Interfaces
                   //-------------------------------------------------------------   
                      `ifndef INTEL_NO_PWR_PINS
                      `ifdef INTC_ADD_VSS
                        .vss              (1'b0),
                      `endif
                        .vddp             (1'b1),
                      `endif
                         .ADR               (tcam_row_14_col_0_adr[7-1:1]), //Input adr_intess
                         .ME                (ce),  
        
                         .CLK               (tcam_row_14_col_0_clk), //Clock
                         .CMP               (tcam_row_14_col_0_chk_en), //Control Enable
                         .DIN               (~tcam_row_14_col_0_data_in), 
                         .DSEL              (~tcam_row_14_col_0_adr[0]), //dncen enables access of the TCAM Arrays adr_intessed
                         .FLS               (flush), //flush initiates a Flush operation that resets all Valid
                         .RVLD              (tcam_row_14_col_0_hit_in ), //Row validation bus. Each match_in input controls 1
                         .MASK              (tcam_row_14_col_0_mask_in), //Input msk
                         .QOUT              (tcam_row_14_col_0_data_out_inv), //Output vben
                         .QHR               (tcam_row_14_col_0_hit_out_int),
                         .QVLD              (), 
                         .RE                (tcam_row_14_col_0_rd_en), //Read Enable
                         .RST               (tcam_row_14_col_0_reset_n), //Asynchronous Active-High Reset
                         .VBE               (1'b1), //vben enables the Valid Bit addressed by adr[a-1:0] to
                         .VBI               (1'b0),//  Valid Bit Input
                         .WE                (tcam_row_14_col_0_wr_en), //Write Enable
                         .FAF               (tcam_row_14_col_0_fca),
                         .FAF_EN            (tcam_row_14_col_0_cre),
                         .DFTSHIFTEN        (tcam_row_14_col_0_dftshiften),
                         .DFTMASK           (tcam_row_14_col_0_dftmask),
                         .DFT_ARRAY_FREEZE  (tcam_row_14_col_0_dft_array_freeze),
                         .DFT_AFD_RESET_B   (tcam_row_14_col_0_dft_afd_reset_b),
                         .BISTE           (tcam_row_14_col_0_biste),
                         .TDIN (tcam_row_14_col_0_tdin),
                         .TADR (tcam_row_14_col_0_tadr),
                         .TVBE (tcam_row_14_col_0_tvbe),
                         .TVBI (tcam_row_14_col_0_tvbi),
                         .TMASK (tcam_row_14_col_0_tmask),
                         .TWE (tcam_row_14_col_0_twe),
                         .TRE (tcam_row_14_col_0_tre),
                         .TME (tcam_row_14_col_0_tme),
                         .BIST_ROTATE_SR (tcam_row_14_col_0_bist_rotate_sr),
                         .BIST_EN_SR_MASK_B (tcam_row_14_col_0_bist_en_sr_mask_b),
                         .BIST_ALL_MASK (tcam_row_14_col_0_bist_all_mask),
                         .BIST_EN_SR_DATA_B (tcam_row_14_col_0_bist_en_sr_data_b),
                         .BIST_CM_MODE (tcam_row_14_col_0_bist_cm_mode),
                         .BIST_CM_EN_IN (tcam_row_14_col_0_bist_cm_en_in),
                         .BIST_CM_MATCH_SEL0 (tcam_row_14_col_0_bist_cm_match_sel0),
                         .BIST_CM_MATCH_SEL1 (tcam_row_14_col_0_bist_cm_match_sel1),
                         .BIST_MATCHIN_IN (tcam_row_14_col_0_bist_matchin_in),
                         .BIST_FLS (tcam_row_14_col_0_bist_fls),
                         .MDST_tcam (fuse_tcam)
                     );
        
              end
              
            else
              begin : gen_tcam_row_14_col_0_bcam
              end
              
        
        
        endgenerate
        
        always_ff @(posedge clk) begin
                   tcam_rd_data_col[14][0]      <= tcam_row_14_col_0_data_out;
                   tcam_col_hit_out[14][0]       <= tcam_row_14_col_0_hit_out;
        end
        

        // this is new template - tcam_asic_template
        
        wire                                            tcam_row_14_col_1_clk         = clk;
        
        wire    [TCAM_SLICE_EN_FACT-1:0]                tcam_row_14_col_1_slice_en = TCAM_SLICE_EN_FACT'(slice_en[(14 * TCAM_SLICE_EN_FACT)+:TCAM_SLICE_EN_MIN]);
        
        wire                                            tcam_row_14_col_1_rd_en       = tcam_row_rd_en[14];
        wire                                            tcam_row_14_col_1_wr_en       = tcam_row_wr_en[14];
        wire                                            tcam_row_14_col_1_chk_en      = chk_en;
        wire                                            tcam_row_14_col_1_reset_n = reset_n;
        wire    [7-1:0]                       tcam_row_14_col_1_adr  = tcam_row_adr[14][7-1:0];
        wire    [32-1:0]                      tcam_row_14_col_1_data_in = tcam_row_wr_en[14] ? tcam_wr_data_col[1][32-1:0] : tcam_chk_key_col[1][32-1:0];
        wire    [32-1:0]                      tcam_row_14_col_1_data_in_pre = tcam_wr_data_col[1][32-1:0] ;
        wire    [32-1:0]                      tcam_row_14_col_1_key_in =  tcam_chk_key_col[1][32-1:0];
        wire    [32-1:0]                      tcam_row_14_col_1_mask_in = tcam_chk_mask_col[1][32-1:0];
        wire    [64-1:0]                       tcam_row_14_col_1_hit_in = tcam_raw_hit_in[14];
        wire    [64-1:0]                       tcam_row_14_col_1_tcam_match_in = tcam_row_match_in[14];
        wire    [32-1:0]                      tcam_row_14_col_1_data_out_inv;
        logic   [64-1:0]                     tcam_row_14_col_1_hit_out_int;
        logic   [64-1:0]                     tcam_row_14_col_1_hit_out_latch;
        logic   [64-1:0]                     tcam_row_14_col_1_hit_out;
        
        `ifdef HIF_PCIE_DFX_DISABLE
        wire                          tcam_row_14_col_1_biste = 'b0; 
        wire     [5-1:0]                  tcam_row_14_col_1_fca = 'b0;
        wire                            tcam_row_14_col_1_cre = 'b0;
        wire                            tcam_row_14_col_1_dftshiften = 'b0;
        wire                            tcam_row_14_col_1_dftmask = 'b0;
        wire                            tcam_row_14_col_1_dft_array_freeze = 'b0;
        wire                            tcam_row_14_col_1_dft_afd_reset_b = 'b0;
        wire      [32-1:0]    tcam_row_14_col_1_tdin = 'b0;
        wire      [7-1:0]     tcam_row_14_col_1_tadr = 'b0;
        wire                            tcam_row_14_col_1_tvbe = 'b0;
        wire                            tcam_row_14_col_1_tvbi = 'b0;
        wire      [32-1:0]    tcam_row_14_col_1_tmask = 'b0;
        wire                            tcam_row_14_col_1_twe = 'b0;
        wire                            tcam_row_14_col_1_tre = 'b0;
        wire                            tcam_row_14_col_1_tme = 'b0;
        wire                            tcam_row_14_col_1_bist_rotate_sr = 'b0;
        wire                            tcam_row_14_col_1_bist_en_sr_mask_b = 'b0;
        wire                            tcam_row_14_col_1_bist_all_mask = 'b0;
        wire                            tcam_row_14_col_1_bist_en_sr_data_b = 'b0;
        wire                            tcam_row_14_col_1_bist_cm_mode = 'b0;
        wire                            tcam_row_14_col_1_bist_cm_en_in = 'b0;
        wire                            tcam_row_14_col_1_bist_cm_match_sel0 = 'b0;
        wire                            tcam_row_14_col_1_bist_cm_match_sel1 = 'b0;
        wire                            tcam_row_14_col_1_bist_matchin_in = 'b0;
        wire                            tcam_row_14_col_1_bist_fls = 'b0;
        
        `else
        wire                            tcam_row_14_col_1_biste = 'b0;
        wire     [5-1:0]                  tcam_row_14_col_1_fca = 'b0;
        wire                            tcam_row_14_col_1_cre = 'b0;
        wire                            tcam_row_14_col_1_dftshiften = dftshiften;
        wire                            tcam_row_14_col_1_dftmask = dftmask;
        wire                            tcam_row_14_col_1_dft_array_freeze = dft_array_freeze;
        wire                            tcam_row_14_col_1_dft_afd_reset_b = dft_afd_reset_b;
        wire      [32-1:0]    tcam_row_14_col_1_tdin = 'b0;
        wire      [7-1:0]     tcam_row_14_col_1_tadr = 'b0;
        wire                            tcam_row_14_col_1_tvbe = 'b0;
        wire                            tcam_row_14_col_1_tvbi = 'b0;
        wire      [32-1:0]    tcam_row_14_col_1_tmask = 'b0;
        wire                            tcam_row_14_col_1_twe = 'b0;
        wire                            tcam_row_14_col_1_tre = 'b0;
        wire                            tcam_row_14_col_1_tme = 'b0;
        wire                            tcam_row_14_col_1_bist_rotate_sr = 'b0;
        wire                            tcam_row_14_col_1_bist_en_sr_mask_b = 'b0;
        wire                            tcam_row_14_col_1_bist_all_mask = 'b0;
        wire                            tcam_row_14_col_1_bist_en_sr_data_b = 'b0;
        wire                            tcam_row_14_col_1_bist_cm_mode = 'b0;
        wire                            tcam_row_14_col_1_bist_cm_en_in = 'b0;
        wire                            tcam_row_14_col_1_bist_cm_match_sel0 = 'b0;
        wire                            tcam_row_14_col_1_bist_cm_match_sel1 = 'b0;
        wire                            tcam_row_14_col_1_bist_matchin_in = 'b0;
        wire                            tcam_row_14_col_1_bist_fls = 'b0;
        `endif
        
        // Outputs
        logic                           tcam_row_14_col_1_wr_bira_fail;
        logic                           tcam_row_14_col_1_wr_so;
        logic                           tcam_row_14_col_1_curerrout;
        logic                           tcam_row_14_col_1_rscout;
        
        
        
        logic   [TCAM_SLICE_EN_FACT-1:0]                  tcam_row_14_col_1_slice_en_s0; 
        logic   [TCAM_SLICE_EN_FACT-1:0]                  tcam_row_14_col_1_slice_en_s1; 
        
        
        
             wire    [32-1:0]                     tcam_row_14_col_1_data_out ;
        
        
        
         generate
            if (BCAM_N7 == 0) 
              begin : gen_tcam_row_14_col_1_tcam
        
        
        // slice_en kept for TCAM only for backward compatability with Intel process
                always_comb 
                begin
                  for (int i = 0; i < TCAM_SLICE_EN_FACT; i++)
                      if (tcam_row_14_col_1_slice_en_s1[i])
                           tcam_row_14_col_1_hit_out[ i*64 +: 64]  = tcam_row_14_col_1_hit_out_int  [ i*64 +: 64]; 
                      else
                           tcam_row_14_col_1_hit_out[ i*64 +: 64]  = tcam_row_14_col_1_hit_out_latch[ i*64 +: 64]; 
                end
        
        
        
                always_ff  @(posedge tcam_row_14_col_1_clk)
                begin
                  tcam_row_14_col_1_slice_en_s0 <= tcam_row_14_col_1_slice_en; 
                  tcam_row_14_col_1_slice_en_s1 <= tcam_row_14_col_1_slice_en_s0; 
        
                  for (int i = 0; i < TCAM_SLICE_EN_FACT; i++)
                    begin
                      if (tcam_row_14_col_1_slice_en_s1[i])
                         tcam_row_14_col_1_hit_out_latch[ i*64 +: 64] <=  tcam_row_14_col_1_hit_out_int[ i*64 +: 64];
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
        
                     
                         assign tcam_row_14_col_1_data_out  = ~tcam_row_14_col_1_data_out_inv;
                         pcie_itp_ip783tcam64x32s0c1_14_1_wrap #(        
                                 )               
        
                                 ip783tcam64x32s0c1_wrap_tcam_row_14_col_1 (
                   //-------------------------------------------------------------
                   // Power Management Interfaces
                   //-------------------------------------------------------------   
                      `ifndef INTEL_NO_PWR_PINS
                      `ifdef INTC_ADD_VSS
                        .vss              (1'b0),
                      `endif
                        .vddp             (1'b1),
                      `endif
                         .ADR               (tcam_row_14_col_1_adr[7-1:1]), //Input adr_intess
                         .ME                (ce),  
        
                         .CLK               (tcam_row_14_col_1_clk), //Clock
                         .CMP               (tcam_row_14_col_1_chk_en), //Control Enable
                         .DIN               (~tcam_row_14_col_1_data_in), 
                         .DSEL              (~tcam_row_14_col_1_adr[0]), //dncen enables access of the TCAM Arrays adr_intessed
                         .FLS               (flush), //flush initiates a Flush operation that resets all Valid
                         .RVLD              (tcam_row_14_col_1_hit_in ), //Row validation bus. Each match_in input controls 1
                         .MASK              (tcam_row_14_col_1_mask_in), //Input msk
                         .QOUT              (tcam_row_14_col_1_data_out_inv), //Output vben
                         .QHR               (tcam_row_14_col_1_hit_out_int),
                         .QVLD              (), 
                         .RE                (tcam_row_14_col_1_rd_en), //Read Enable
                         .RST               (tcam_row_14_col_1_reset_n), //Asynchronous Active-High Reset
                         .VBE               (1'b1), //vben enables the Valid Bit addressed by adr[a-1:0] to
                         .VBI               (1'b0),//  Valid Bit Input
                         .WE                (tcam_row_14_col_1_wr_en), //Write Enable
                         .FAF               (tcam_row_14_col_1_fca),
                         .FAF_EN            (tcam_row_14_col_1_cre),
                         .DFTSHIFTEN        (tcam_row_14_col_1_dftshiften),
                         .DFTMASK           (tcam_row_14_col_1_dftmask),
                         .DFT_ARRAY_FREEZE  (tcam_row_14_col_1_dft_array_freeze),
                         .DFT_AFD_RESET_B   (tcam_row_14_col_1_dft_afd_reset_b),
                         .BISTE           (tcam_row_14_col_1_biste),
                         .TDIN (tcam_row_14_col_1_tdin),
                         .TADR (tcam_row_14_col_1_tadr),
                         .TVBE (tcam_row_14_col_1_tvbe),
                         .TVBI (tcam_row_14_col_1_tvbi),
                         .TMASK (tcam_row_14_col_1_tmask),
                         .TWE (tcam_row_14_col_1_twe),
                         .TRE (tcam_row_14_col_1_tre),
                         .TME (tcam_row_14_col_1_tme),
                         .BIST_ROTATE_SR (tcam_row_14_col_1_bist_rotate_sr),
                         .BIST_EN_SR_MASK_B (tcam_row_14_col_1_bist_en_sr_mask_b),
                         .BIST_ALL_MASK (tcam_row_14_col_1_bist_all_mask),
                         .BIST_EN_SR_DATA_B (tcam_row_14_col_1_bist_en_sr_data_b),
                         .BIST_CM_MODE (tcam_row_14_col_1_bist_cm_mode),
                         .BIST_CM_EN_IN (tcam_row_14_col_1_bist_cm_en_in),
                         .BIST_CM_MATCH_SEL0 (tcam_row_14_col_1_bist_cm_match_sel0),
                         .BIST_CM_MATCH_SEL1 (tcam_row_14_col_1_bist_cm_match_sel1),
                         .BIST_MATCHIN_IN (tcam_row_14_col_1_bist_matchin_in),
                         .BIST_FLS (tcam_row_14_col_1_bist_fls),
                         .MDST_tcam (fuse_tcam)
                     );
        
              end
              
            else
              begin : gen_tcam_row_14_col_1_bcam
              end
              
        
        
        endgenerate
        
        always_ff @(posedge clk) begin
                   tcam_rd_data_col[14][1]      <= tcam_row_14_col_1_data_out;
                   tcam_col_hit_out[14][1]       <= tcam_row_14_col_1_hit_out;
        end
        

        // this is new template - tcam_asic_template
        
        wire                                            tcam_row_15_col_0_clk         = clk;
        
        wire    [TCAM_SLICE_EN_FACT-1:0]                tcam_row_15_col_0_slice_en = TCAM_SLICE_EN_FACT'(slice_en[(15 * TCAM_SLICE_EN_FACT)+:TCAM_SLICE_EN_MIN]);
        
        wire                                            tcam_row_15_col_0_rd_en       = tcam_row_rd_en[15];
        wire                                            tcam_row_15_col_0_wr_en       = tcam_row_wr_en[15];
        wire                                            tcam_row_15_col_0_chk_en      = chk_en;
        wire                                            tcam_row_15_col_0_reset_n = reset_n;
        wire    [7-1:0]                       tcam_row_15_col_0_adr  = tcam_row_adr[15][7-1:0];
        wire    [32-1:0]                      tcam_row_15_col_0_data_in = tcam_row_wr_en[15] ? tcam_wr_data_col[0][32-1:0] : tcam_chk_key_col[0][32-1:0];
        wire    [32-1:0]                      tcam_row_15_col_0_data_in_pre = tcam_wr_data_col[0][32-1:0] ;
        wire    [32-1:0]                      tcam_row_15_col_0_key_in =  tcam_chk_key_col[0][32-1:0];
        wire    [32-1:0]                      tcam_row_15_col_0_mask_in = tcam_chk_mask_col[0][32-1:0];
        wire    [64-1:0]                       tcam_row_15_col_0_hit_in = tcam_raw_hit_in[15];
        wire    [64-1:0]                       tcam_row_15_col_0_tcam_match_in = tcam_row_match_in[15];
        wire    [32-1:0]                      tcam_row_15_col_0_data_out_inv;
        logic   [64-1:0]                     tcam_row_15_col_0_hit_out_int;
        logic   [64-1:0]                     tcam_row_15_col_0_hit_out_latch;
        logic   [64-1:0]                     tcam_row_15_col_0_hit_out;
        
        `ifdef HIF_PCIE_DFX_DISABLE
        wire                          tcam_row_15_col_0_biste = 'b0; 
        wire     [5-1:0]                  tcam_row_15_col_0_fca = 'b0;
        wire                            tcam_row_15_col_0_cre = 'b0;
        wire                            tcam_row_15_col_0_dftshiften = 'b0;
        wire                            tcam_row_15_col_0_dftmask = 'b0;
        wire                            tcam_row_15_col_0_dft_array_freeze = 'b0;
        wire                            tcam_row_15_col_0_dft_afd_reset_b = 'b0;
        wire      [32-1:0]    tcam_row_15_col_0_tdin = 'b0;
        wire      [7-1:0]     tcam_row_15_col_0_tadr = 'b0;
        wire                            tcam_row_15_col_0_tvbe = 'b0;
        wire                            tcam_row_15_col_0_tvbi = 'b0;
        wire      [32-1:0]    tcam_row_15_col_0_tmask = 'b0;
        wire                            tcam_row_15_col_0_twe = 'b0;
        wire                            tcam_row_15_col_0_tre = 'b0;
        wire                            tcam_row_15_col_0_tme = 'b0;
        wire                            tcam_row_15_col_0_bist_rotate_sr = 'b0;
        wire                            tcam_row_15_col_0_bist_en_sr_mask_b = 'b0;
        wire                            tcam_row_15_col_0_bist_all_mask = 'b0;
        wire                            tcam_row_15_col_0_bist_en_sr_data_b = 'b0;
        wire                            tcam_row_15_col_0_bist_cm_mode = 'b0;
        wire                            tcam_row_15_col_0_bist_cm_en_in = 'b0;
        wire                            tcam_row_15_col_0_bist_cm_match_sel0 = 'b0;
        wire                            tcam_row_15_col_0_bist_cm_match_sel1 = 'b0;
        wire                            tcam_row_15_col_0_bist_matchin_in = 'b0;
        wire                            tcam_row_15_col_0_bist_fls = 'b0;
        
        `else
        wire                            tcam_row_15_col_0_biste = 'b0;
        wire     [5-1:0]                  tcam_row_15_col_0_fca = 'b0;
        wire                            tcam_row_15_col_0_cre = 'b0;
        wire                            tcam_row_15_col_0_dftshiften = dftshiften;
        wire                            tcam_row_15_col_0_dftmask = dftmask;
        wire                            tcam_row_15_col_0_dft_array_freeze = dft_array_freeze;
        wire                            tcam_row_15_col_0_dft_afd_reset_b = dft_afd_reset_b;
        wire      [32-1:0]    tcam_row_15_col_0_tdin = 'b0;
        wire      [7-1:0]     tcam_row_15_col_0_tadr = 'b0;
        wire                            tcam_row_15_col_0_tvbe = 'b0;
        wire                            tcam_row_15_col_0_tvbi = 'b0;
        wire      [32-1:0]    tcam_row_15_col_0_tmask = 'b0;
        wire                            tcam_row_15_col_0_twe = 'b0;
        wire                            tcam_row_15_col_0_tre = 'b0;
        wire                            tcam_row_15_col_0_tme = 'b0;
        wire                            tcam_row_15_col_0_bist_rotate_sr = 'b0;
        wire                            tcam_row_15_col_0_bist_en_sr_mask_b = 'b0;
        wire                            tcam_row_15_col_0_bist_all_mask = 'b0;
        wire                            tcam_row_15_col_0_bist_en_sr_data_b = 'b0;
        wire                            tcam_row_15_col_0_bist_cm_mode = 'b0;
        wire                            tcam_row_15_col_0_bist_cm_en_in = 'b0;
        wire                            tcam_row_15_col_0_bist_cm_match_sel0 = 'b0;
        wire                            tcam_row_15_col_0_bist_cm_match_sel1 = 'b0;
        wire                            tcam_row_15_col_0_bist_matchin_in = 'b0;
        wire                            tcam_row_15_col_0_bist_fls = 'b0;
        `endif
        
        // Outputs
        logic                           tcam_row_15_col_0_wr_bira_fail;
        logic                           tcam_row_15_col_0_wr_so;
        logic                           tcam_row_15_col_0_curerrout;
        logic                           tcam_row_15_col_0_rscout;
        
        
        
        logic   [TCAM_SLICE_EN_FACT-1:0]                  tcam_row_15_col_0_slice_en_s0; 
        logic   [TCAM_SLICE_EN_FACT-1:0]                  tcam_row_15_col_0_slice_en_s1; 
        
        
        
             wire    [32-1:0]                     tcam_row_15_col_0_data_out ;
        
        
        
         generate
            if (BCAM_N7 == 0) 
              begin : gen_tcam_row_15_col_0_tcam
        
        
        // slice_en kept for TCAM only for backward compatability with Intel process
                always_comb 
                begin
                  for (int i = 0; i < TCAM_SLICE_EN_FACT; i++)
                      if (tcam_row_15_col_0_slice_en_s1[i])
                           tcam_row_15_col_0_hit_out[ i*64 +: 64]  = tcam_row_15_col_0_hit_out_int  [ i*64 +: 64]; 
                      else
                           tcam_row_15_col_0_hit_out[ i*64 +: 64]  = tcam_row_15_col_0_hit_out_latch[ i*64 +: 64]; 
                end
        
        
        
                always_ff  @(posedge tcam_row_15_col_0_clk)
                begin
                  tcam_row_15_col_0_slice_en_s0 <= tcam_row_15_col_0_slice_en; 
                  tcam_row_15_col_0_slice_en_s1 <= tcam_row_15_col_0_slice_en_s0; 
        
                  for (int i = 0; i < TCAM_SLICE_EN_FACT; i++)
                    begin
                      if (tcam_row_15_col_0_slice_en_s1[i])
                         tcam_row_15_col_0_hit_out_latch[ i*64 +: 64] <=  tcam_row_15_col_0_hit_out_int[ i*64 +: 64];
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
        
                     
                         assign tcam_row_15_col_0_data_out  = ~tcam_row_15_col_0_data_out_inv;
                         pcie_itp_ip783tcam64x32s0c1_15_0_wrap #(        
                                 )               
        
                                 ip783tcam64x32s0c1_wrap_tcam_row_15_col_0 (
                   //-------------------------------------------------------------
                   // Power Management Interfaces
                   //-------------------------------------------------------------   
                      `ifndef INTEL_NO_PWR_PINS
                      `ifdef INTC_ADD_VSS
                        .vss              (1'b0),
                      `endif
                        .vddp             (1'b1),
                      `endif
                         .ADR               (tcam_row_15_col_0_adr[7-1:1]), //Input adr_intess
                         .ME                (ce),  
        
                         .CLK               (tcam_row_15_col_0_clk), //Clock
                         .CMP               (tcam_row_15_col_0_chk_en), //Control Enable
                         .DIN               (~tcam_row_15_col_0_data_in), 
                         .DSEL              (~tcam_row_15_col_0_adr[0]), //dncen enables access of the TCAM Arrays adr_intessed
                         .FLS               (flush), //flush initiates a Flush operation that resets all Valid
                         .RVLD              (tcam_row_15_col_0_hit_in ), //Row validation bus. Each match_in input controls 1
                         .MASK              (tcam_row_15_col_0_mask_in), //Input msk
                         .QOUT              (tcam_row_15_col_0_data_out_inv), //Output vben
                         .QHR               (tcam_row_15_col_0_hit_out_int),
                         .QVLD              (), 
                         .RE                (tcam_row_15_col_0_rd_en), //Read Enable
                         .RST               (tcam_row_15_col_0_reset_n), //Asynchronous Active-High Reset
                         .VBE               (1'b1), //vben enables the Valid Bit addressed by adr[a-1:0] to
                         .VBI               (1'b0),//  Valid Bit Input
                         .WE                (tcam_row_15_col_0_wr_en), //Write Enable
                         .FAF               (tcam_row_15_col_0_fca),
                         .FAF_EN            (tcam_row_15_col_0_cre),
                         .DFTSHIFTEN        (tcam_row_15_col_0_dftshiften),
                         .DFTMASK           (tcam_row_15_col_0_dftmask),
                         .DFT_ARRAY_FREEZE  (tcam_row_15_col_0_dft_array_freeze),
                         .DFT_AFD_RESET_B   (tcam_row_15_col_0_dft_afd_reset_b),
                         .BISTE           (tcam_row_15_col_0_biste),
                         .TDIN (tcam_row_15_col_0_tdin),
                         .TADR (tcam_row_15_col_0_tadr),
                         .TVBE (tcam_row_15_col_0_tvbe),
                         .TVBI (tcam_row_15_col_0_tvbi),
                         .TMASK (tcam_row_15_col_0_tmask),
                         .TWE (tcam_row_15_col_0_twe),
                         .TRE (tcam_row_15_col_0_tre),
                         .TME (tcam_row_15_col_0_tme),
                         .BIST_ROTATE_SR (tcam_row_15_col_0_bist_rotate_sr),
                         .BIST_EN_SR_MASK_B (tcam_row_15_col_0_bist_en_sr_mask_b),
                         .BIST_ALL_MASK (tcam_row_15_col_0_bist_all_mask),
                         .BIST_EN_SR_DATA_B (tcam_row_15_col_0_bist_en_sr_data_b),
                         .BIST_CM_MODE (tcam_row_15_col_0_bist_cm_mode),
                         .BIST_CM_EN_IN (tcam_row_15_col_0_bist_cm_en_in),
                         .BIST_CM_MATCH_SEL0 (tcam_row_15_col_0_bist_cm_match_sel0),
                         .BIST_CM_MATCH_SEL1 (tcam_row_15_col_0_bist_cm_match_sel1),
                         .BIST_MATCHIN_IN (tcam_row_15_col_0_bist_matchin_in),
                         .BIST_FLS (tcam_row_15_col_0_bist_fls),
                         .MDST_tcam (fuse_tcam)
                     );
        
              end
              
            else
              begin : gen_tcam_row_15_col_0_bcam
              end
              
        
        
        endgenerate
        
        always_ff @(posedge clk) begin
                   tcam_rd_data_col[15][0]      <= tcam_row_15_col_0_data_out;
                   tcam_col_hit_out[15][0]       <= tcam_row_15_col_0_hit_out;
        end
        

        // this is new template - tcam_asic_template
        
        wire                                            tcam_row_15_col_1_clk         = clk;
        
        wire    [TCAM_SLICE_EN_FACT-1:0]                tcam_row_15_col_1_slice_en = TCAM_SLICE_EN_FACT'(slice_en[(15 * TCAM_SLICE_EN_FACT)+:TCAM_SLICE_EN_MIN]);
        
        wire                                            tcam_row_15_col_1_rd_en       = tcam_row_rd_en[15];
        wire                                            tcam_row_15_col_1_wr_en       = tcam_row_wr_en[15];
        wire                                            tcam_row_15_col_1_chk_en      = chk_en;
        wire                                            tcam_row_15_col_1_reset_n = reset_n;
        wire    [7-1:0]                       tcam_row_15_col_1_adr  = tcam_row_adr[15][7-1:0];
        wire    [32-1:0]                      tcam_row_15_col_1_data_in = tcam_row_wr_en[15] ? tcam_wr_data_col[1][32-1:0] : tcam_chk_key_col[1][32-1:0];
        wire    [32-1:0]                      tcam_row_15_col_1_data_in_pre = tcam_wr_data_col[1][32-1:0] ;
        wire    [32-1:0]                      tcam_row_15_col_1_key_in =  tcam_chk_key_col[1][32-1:0];
        wire    [32-1:0]                      tcam_row_15_col_1_mask_in = tcam_chk_mask_col[1][32-1:0];
        wire    [64-1:0]                       tcam_row_15_col_1_hit_in = tcam_raw_hit_in[15];
        wire    [64-1:0]                       tcam_row_15_col_1_tcam_match_in = tcam_row_match_in[15];
        wire    [32-1:0]                      tcam_row_15_col_1_data_out_inv;
        logic   [64-1:0]                     tcam_row_15_col_1_hit_out_int;
        logic   [64-1:0]                     tcam_row_15_col_1_hit_out_latch;
        logic   [64-1:0]                     tcam_row_15_col_1_hit_out;
        
        `ifdef HIF_PCIE_DFX_DISABLE
        wire                          tcam_row_15_col_1_biste = 'b0; 
        wire     [5-1:0]                  tcam_row_15_col_1_fca = 'b0;
        wire                            tcam_row_15_col_1_cre = 'b0;
        wire                            tcam_row_15_col_1_dftshiften = 'b0;
        wire                            tcam_row_15_col_1_dftmask = 'b0;
        wire                            tcam_row_15_col_1_dft_array_freeze = 'b0;
        wire                            tcam_row_15_col_1_dft_afd_reset_b = 'b0;
        wire      [32-1:0]    tcam_row_15_col_1_tdin = 'b0;
        wire      [7-1:0]     tcam_row_15_col_1_tadr = 'b0;
        wire                            tcam_row_15_col_1_tvbe = 'b0;
        wire                            tcam_row_15_col_1_tvbi = 'b0;
        wire      [32-1:0]    tcam_row_15_col_1_tmask = 'b0;
        wire                            tcam_row_15_col_1_twe = 'b0;
        wire                            tcam_row_15_col_1_tre = 'b0;
        wire                            tcam_row_15_col_1_tme = 'b0;
        wire                            tcam_row_15_col_1_bist_rotate_sr = 'b0;
        wire                            tcam_row_15_col_1_bist_en_sr_mask_b = 'b0;
        wire                            tcam_row_15_col_1_bist_all_mask = 'b0;
        wire                            tcam_row_15_col_1_bist_en_sr_data_b = 'b0;
        wire                            tcam_row_15_col_1_bist_cm_mode = 'b0;
        wire                            tcam_row_15_col_1_bist_cm_en_in = 'b0;
        wire                            tcam_row_15_col_1_bist_cm_match_sel0 = 'b0;
        wire                            tcam_row_15_col_1_bist_cm_match_sel1 = 'b0;
        wire                            tcam_row_15_col_1_bist_matchin_in = 'b0;
        wire                            tcam_row_15_col_1_bist_fls = 'b0;
        
        `else
        wire                            tcam_row_15_col_1_biste = 'b0;
        wire     [5-1:0]                  tcam_row_15_col_1_fca = 'b0;
        wire                            tcam_row_15_col_1_cre = 'b0;
        wire                            tcam_row_15_col_1_dftshiften = dftshiften;
        wire                            tcam_row_15_col_1_dftmask = dftmask;
        wire                            tcam_row_15_col_1_dft_array_freeze = dft_array_freeze;
        wire                            tcam_row_15_col_1_dft_afd_reset_b = dft_afd_reset_b;
        wire      [32-1:0]    tcam_row_15_col_1_tdin = 'b0;
        wire      [7-1:0]     tcam_row_15_col_1_tadr = 'b0;
        wire                            tcam_row_15_col_1_tvbe = 'b0;
        wire                            tcam_row_15_col_1_tvbi = 'b0;
        wire      [32-1:0]    tcam_row_15_col_1_tmask = 'b0;
        wire                            tcam_row_15_col_1_twe = 'b0;
        wire                            tcam_row_15_col_1_tre = 'b0;
        wire                            tcam_row_15_col_1_tme = 'b0;
        wire                            tcam_row_15_col_1_bist_rotate_sr = 'b0;
        wire                            tcam_row_15_col_1_bist_en_sr_mask_b = 'b0;
        wire                            tcam_row_15_col_1_bist_all_mask = 'b0;
        wire                            tcam_row_15_col_1_bist_en_sr_data_b = 'b0;
        wire                            tcam_row_15_col_1_bist_cm_mode = 'b0;
        wire                            tcam_row_15_col_1_bist_cm_en_in = 'b0;
        wire                            tcam_row_15_col_1_bist_cm_match_sel0 = 'b0;
        wire                            tcam_row_15_col_1_bist_cm_match_sel1 = 'b0;
        wire                            tcam_row_15_col_1_bist_matchin_in = 'b0;
        wire                            tcam_row_15_col_1_bist_fls = 'b0;
        `endif
        
        // Outputs
        logic                           tcam_row_15_col_1_wr_bira_fail;
        logic                           tcam_row_15_col_1_wr_so;
        logic                           tcam_row_15_col_1_curerrout;
        logic                           tcam_row_15_col_1_rscout;
        
        
        
        logic   [TCAM_SLICE_EN_FACT-1:0]                  tcam_row_15_col_1_slice_en_s0; 
        logic   [TCAM_SLICE_EN_FACT-1:0]                  tcam_row_15_col_1_slice_en_s1; 
        
        
        
             wire    [32-1:0]                     tcam_row_15_col_1_data_out ;
        
        
        
         generate
            if (BCAM_N7 == 0) 
              begin : gen_tcam_row_15_col_1_tcam
        
        
        // slice_en kept for TCAM only for backward compatability with Intel process
                always_comb 
                begin
                  for (int i = 0; i < TCAM_SLICE_EN_FACT; i++)
                      if (tcam_row_15_col_1_slice_en_s1[i])
                           tcam_row_15_col_1_hit_out[ i*64 +: 64]  = tcam_row_15_col_1_hit_out_int  [ i*64 +: 64]; 
                      else
                           tcam_row_15_col_1_hit_out[ i*64 +: 64]  = tcam_row_15_col_1_hit_out_latch[ i*64 +: 64]; 
                end
        
        
        
                always_ff  @(posedge tcam_row_15_col_1_clk)
                begin
                  tcam_row_15_col_1_slice_en_s0 <= tcam_row_15_col_1_slice_en; 
                  tcam_row_15_col_1_slice_en_s1 <= tcam_row_15_col_1_slice_en_s0; 
        
                  for (int i = 0; i < TCAM_SLICE_EN_FACT; i++)
                    begin
                      if (tcam_row_15_col_1_slice_en_s1[i])
                         tcam_row_15_col_1_hit_out_latch[ i*64 +: 64] <=  tcam_row_15_col_1_hit_out_int[ i*64 +: 64];
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
        
                     
                         assign tcam_row_15_col_1_data_out  = ~tcam_row_15_col_1_data_out_inv;
                         pcie_itp_ip783tcam64x32s0c1_15_1_wrap #(        
                                 )               
        
                                 ip783tcam64x32s0c1_wrap_tcam_row_15_col_1 (
                   //-------------------------------------------------------------
                   // Power Management Interfaces
                   //-------------------------------------------------------------   
                      `ifndef INTEL_NO_PWR_PINS
                      `ifdef INTC_ADD_VSS
                        .vss              (1'b0),
                      `endif
                        .vddp             (1'b1),
                      `endif
                         .ADR               (tcam_row_15_col_1_adr[7-1:1]), //Input adr_intess
                         .ME                (ce),  
        
                         .CLK               (tcam_row_15_col_1_clk), //Clock
                         .CMP               (tcam_row_15_col_1_chk_en), //Control Enable
                         .DIN               (~tcam_row_15_col_1_data_in), 
                         .DSEL              (~tcam_row_15_col_1_adr[0]), //dncen enables access of the TCAM Arrays adr_intessed
                         .FLS               (flush), //flush initiates a Flush operation that resets all Valid
                         .RVLD              (tcam_row_15_col_1_hit_in ), //Row validation bus. Each match_in input controls 1
                         .MASK              (tcam_row_15_col_1_mask_in), //Input msk
                         .QOUT              (tcam_row_15_col_1_data_out_inv), //Output vben
                         .QHR               (tcam_row_15_col_1_hit_out_int),
                         .QVLD              (), 
                         .RE                (tcam_row_15_col_1_rd_en), //Read Enable
                         .RST               (tcam_row_15_col_1_reset_n), //Asynchronous Active-High Reset
                         .VBE               (1'b1), //vben enables the Valid Bit addressed by adr[a-1:0] to
                         .VBI               (1'b0),//  Valid Bit Input
                         .WE                (tcam_row_15_col_1_wr_en), //Write Enable
                         .FAF               (tcam_row_15_col_1_fca),
                         .FAF_EN            (tcam_row_15_col_1_cre),
                         .DFTSHIFTEN        (tcam_row_15_col_1_dftshiften),
                         .DFTMASK           (tcam_row_15_col_1_dftmask),
                         .DFT_ARRAY_FREEZE  (tcam_row_15_col_1_dft_array_freeze),
                         .DFT_AFD_RESET_B   (tcam_row_15_col_1_dft_afd_reset_b),
                         .BISTE           (tcam_row_15_col_1_biste),
                         .TDIN (tcam_row_15_col_1_tdin),
                         .TADR (tcam_row_15_col_1_tadr),
                         .TVBE (tcam_row_15_col_1_tvbe),
                         .TVBI (tcam_row_15_col_1_tvbi),
                         .TMASK (tcam_row_15_col_1_tmask),
                         .TWE (tcam_row_15_col_1_twe),
                         .TRE (tcam_row_15_col_1_tre),
                         .TME (tcam_row_15_col_1_tme),
                         .BIST_ROTATE_SR (tcam_row_15_col_1_bist_rotate_sr),
                         .BIST_EN_SR_MASK_B (tcam_row_15_col_1_bist_en_sr_mask_b),
                         .BIST_ALL_MASK (tcam_row_15_col_1_bist_all_mask),
                         .BIST_EN_SR_DATA_B (tcam_row_15_col_1_bist_en_sr_data_b),
                         .BIST_CM_MODE (tcam_row_15_col_1_bist_cm_mode),
                         .BIST_CM_EN_IN (tcam_row_15_col_1_bist_cm_en_in),
                         .BIST_CM_MATCH_SEL0 (tcam_row_15_col_1_bist_cm_match_sel0),
                         .BIST_CM_MATCH_SEL1 (tcam_row_15_col_1_bist_cm_match_sel1),
                         .BIST_MATCHIN_IN (tcam_row_15_col_1_bist_matchin_in),
                         .BIST_FLS (tcam_row_15_col_1_bist_fls),
                         .MDST_tcam (fuse_tcam)
                     );
        
              end
              
            else
              begin : gen_tcam_row_15_col_1_bcam
              end
              
        
        
        endgenerate
        
        always_ff @(posedge clk) begin
                   tcam_rd_data_col[15][1]      <= tcam_row_15_col_1_data_out;
                   tcam_col_hit_out[15][1]       <= tcam_row_15_col_1_hit_out;
        end
        

        // this is new template - tcam_asic_template
        
        wire                                            tcam_row_16_col_0_clk         = clk;
        
        wire    [TCAM_SLICE_EN_FACT-1:0]                tcam_row_16_col_0_slice_en = TCAM_SLICE_EN_FACT'(slice_en[(16 * TCAM_SLICE_EN_FACT)+:TCAM_SLICE_EN_MIN]);
        
        wire                                            tcam_row_16_col_0_rd_en       = tcam_row_rd_en[16];
        wire                                            tcam_row_16_col_0_wr_en       = tcam_row_wr_en[16];
        wire                                            tcam_row_16_col_0_chk_en      = chk_en;
        wire                                            tcam_row_16_col_0_reset_n = reset_n;
        wire    [7-1:0]                       tcam_row_16_col_0_adr  = tcam_row_adr[16][7-1:0];
        wire    [32-1:0]                      tcam_row_16_col_0_data_in = tcam_row_wr_en[16] ? tcam_wr_data_col[0][32-1:0] : tcam_chk_key_col[0][32-1:0];
        wire    [32-1:0]                      tcam_row_16_col_0_data_in_pre = tcam_wr_data_col[0][32-1:0] ;
        wire    [32-1:0]                      tcam_row_16_col_0_key_in =  tcam_chk_key_col[0][32-1:0];
        wire    [32-1:0]                      tcam_row_16_col_0_mask_in = tcam_chk_mask_col[0][32-1:0];
        wire    [64-1:0]                       tcam_row_16_col_0_hit_in = tcam_raw_hit_in[16];
        wire    [64-1:0]                       tcam_row_16_col_0_tcam_match_in = tcam_row_match_in[16];
        wire    [32-1:0]                      tcam_row_16_col_0_data_out_inv;
        logic   [64-1:0]                     tcam_row_16_col_0_hit_out_int;
        logic   [64-1:0]                     tcam_row_16_col_0_hit_out_latch;
        logic   [64-1:0]                     tcam_row_16_col_0_hit_out;
        
        `ifdef HIF_PCIE_DFX_DISABLE
        wire                          tcam_row_16_col_0_biste = 'b0; 
        wire     [5-1:0]                  tcam_row_16_col_0_fca = 'b0;
        wire                            tcam_row_16_col_0_cre = 'b0;
        wire                            tcam_row_16_col_0_dftshiften = 'b0;
        wire                            tcam_row_16_col_0_dftmask = 'b0;
        wire                            tcam_row_16_col_0_dft_array_freeze = 'b0;
        wire                            tcam_row_16_col_0_dft_afd_reset_b = 'b0;
        wire      [32-1:0]    tcam_row_16_col_0_tdin = 'b0;
        wire      [7-1:0]     tcam_row_16_col_0_tadr = 'b0;
        wire                            tcam_row_16_col_0_tvbe = 'b0;
        wire                            tcam_row_16_col_0_tvbi = 'b0;
        wire      [32-1:0]    tcam_row_16_col_0_tmask = 'b0;
        wire                            tcam_row_16_col_0_twe = 'b0;
        wire                            tcam_row_16_col_0_tre = 'b0;
        wire                            tcam_row_16_col_0_tme = 'b0;
        wire                            tcam_row_16_col_0_bist_rotate_sr = 'b0;
        wire                            tcam_row_16_col_0_bist_en_sr_mask_b = 'b0;
        wire                            tcam_row_16_col_0_bist_all_mask = 'b0;
        wire                            tcam_row_16_col_0_bist_en_sr_data_b = 'b0;
        wire                            tcam_row_16_col_0_bist_cm_mode = 'b0;
        wire                            tcam_row_16_col_0_bist_cm_en_in = 'b0;
        wire                            tcam_row_16_col_0_bist_cm_match_sel0 = 'b0;
        wire                            tcam_row_16_col_0_bist_cm_match_sel1 = 'b0;
        wire                            tcam_row_16_col_0_bist_matchin_in = 'b0;
        wire                            tcam_row_16_col_0_bist_fls = 'b0;
        
        `else
        wire                            tcam_row_16_col_0_biste = 'b0;
        wire     [5-1:0]                  tcam_row_16_col_0_fca = 'b0;
        wire                            tcam_row_16_col_0_cre = 'b0;
        wire                            tcam_row_16_col_0_dftshiften = dftshiften;
        wire                            tcam_row_16_col_0_dftmask = dftmask;
        wire                            tcam_row_16_col_0_dft_array_freeze = dft_array_freeze;
        wire                            tcam_row_16_col_0_dft_afd_reset_b = dft_afd_reset_b;
        wire      [32-1:0]    tcam_row_16_col_0_tdin = 'b0;
        wire      [7-1:0]     tcam_row_16_col_0_tadr = 'b0;
        wire                            tcam_row_16_col_0_tvbe = 'b0;
        wire                            tcam_row_16_col_0_tvbi = 'b0;
        wire      [32-1:0]    tcam_row_16_col_0_tmask = 'b0;
        wire                            tcam_row_16_col_0_twe = 'b0;
        wire                            tcam_row_16_col_0_tre = 'b0;
        wire                            tcam_row_16_col_0_tme = 'b0;
        wire                            tcam_row_16_col_0_bist_rotate_sr = 'b0;
        wire                            tcam_row_16_col_0_bist_en_sr_mask_b = 'b0;
        wire                            tcam_row_16_col_0_bist_all_mask = 'b0;
        wire                            tcam_row_16_col_0_bist_en_sr_data_b = 'b0;
        wire                            tcam_row_16_col_0_bist_cm_mode = 'b0;
        wire                            tcam_row_16_col_0_bist_cm_en_in = 'b0;
        wire                            tcam_row_16_col_0_bist_cm_match_sel0 = 'b0;
        wire                            tcam_row_16_col_0_bist_cm_match_sel1 = 'b0;
        wire                            tcam_row_16_col_0_bist_matchin_in = 'b0;
        wire                            tcam_row_16_col_0_bist_fls = 'b0;
        `endif
        
        // Outputs
        logic                           tcam_row_16_col_0_wr_bira_fail;
        logic                           tcam_row_16_col_0_wr_so;
        logic                           tcam_row_16_col_0_curerrout;
        logic                           tcam_row_16_col_0_rscout;
        
        
        
        logic   [TCAM_SLICE_EN_FACT-1:0]                  tcam_row_16_col_0_slice_en_s0; 
        logic   [TCAM_SLICE_EN_FACT-1:0]                  tcam_row_16_col_0_slice_en_s1; 
        
        
        
             wire    [32-1:0]                     tcam_row_16_col_0_data_out ;
        
        
        
         generate
            if (BCAM_N7 == 0) 
              begin : gen_tcam_row_16_col_0_tcam
        
        
        // slice_en kept for TCAM only for backward compatability with Intel process
                always_comb 
                begin
                  for (int i = 0; i < TCAM_SLICE_EN_FACT; i++)
                      if (tcam_row_16_col_0_slice_en_s1[i])
                           tcam_row_16_col_0_hit_out[ i*64 +: 64]  = tcam_row_16_col_0_hit_out_int  [ i*64 +: 64]; 
                      else
                           tcam_row_16_col_0_hit_out[ i*64 +: 64]  = tcam_row_16_col_0_hit_out_latch[ i*64 +: 64]; 
                end
        
        
        
                always_ff  @(posedge tcam_row_16_col_0_clk)
                begin
                  tcam_row_16_col_0_slice_en_s0 <= tcam_row_16_col_0_slice_en; 
                  tcam_row_16_col_0_slice_en_s1 <= tcam_row_16_col_0_slice_en_s0; 
        
                  for (int i = 0; i < TCAM_SLICE_EN_FACT; i++)
                    begin
                      if (tcam_row_16_col_0_slice_en_s1[i])
                         tcam_row_16_col_0_hit_out_latch[ i*64 +: 64] <=  tcam_row_16_col_0_hit_out_int[ i*64 +: 64];
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
        
                     
                         assign tcam_row_16_col_0_data_out  = ~tcam_row_16_col_0_data_out_inv;
                         pcie_itp_ip783tcam64x32s0c1_16_0_wrap #(        
                                 )               
        
                                 ip783tcam64x32s0c1_wrap_tcam_row_16_col_0 (
                   //-------------------------------------------------------------
                   // Power Management Interfaces
                   //-------------------------------------------------------------   
                      `ifndef INTEL_NO_PWR_PINS
                      `ifdef INTC_ADD_VSS
                        .vss              (1'b0),
                      `endif
                        .vddp             (1'b1),
                      `endif
                         .ADR               (tcam_row_16_col_0_adr[7-1:1]), //Input adr_intess
                         .ME                (ce),  
        
                         .CLK               (tcam_row_16_col_0_clk), //Clock
                         .CMP               (tcam_row_16_col_0_chk_en), //Control Enable
                         .DIN               (~tcam_row_16_col_0_data_in), 
                         .DSEL              (~tcam_row_16_col_0_adr[0]), //dncen enables access of the TCAM Arrays adr_intessed
                         .FLS               (flush), //flush initiates a Flush operation that resets all Valid
                         .RVLD              (tcam_row_16_col_0_hit_in ), //Row validation bus. Each match_in input controls 1
                         .MASK              (tcam_row_16_col_0_mask_in), //Input msk
                         .QOUT              (tcam_row_16_col_0_data_out_inv), //Output vben
                         .QHR               (tcam_row_16_col_0_hit_out_int),
                         .QVLD              (), 
                         .RE                (tcam_row_16_col_0_rd_en), //Read Enable
                         .RST               (tcam_row_16_col_0_reset_n), //Asynchronous Active-High Reset
                         .VBE               (1'b1), //vben enables the Valid Bit addressed by adr[a-1:0] to
                         .VBI               (1'b0),//  Valid Bit Input
                         .WE                (tcam_row_16_col_0_wr_en), //Write Enable
                         .FAF               (tcam_row_16_col_0_fca),
                         .FAF_EN            (tcam_row_16_col_0_cre),
                         .DFTSHIFTEN        (tcam_row_16_col_0_dftshiften),
                         .DFTMASK           (tcam_row_16_col_0_dftmask),
                         .DFT_ARRAY_FREEZE  (tcam_row_16_col_0_dft_array_freeze),
                         .DFT_AFD_RESET_B   (tcam_row_16_col_0_dft_afd_reset_b),
                         .BISTE           (tcam_row_16_col_0_biste),
                         .TDIN (tcam_row_16_col_0_tdin),
                         .TADR (tcam_row_16_col_0_tadr),
                         .TVBE (tcam_row_16_col_0_tvbe),
                         .TVBI (tcam_row_16_col_0_tvbi),
                         .TMASK (tcam_row_16_col_0_tmask),
                         .TWE (tcam_row_16_col_0_twe),
                         .TRE (tcam_row_16_col_0_tre),
                         .TME (tcam_row_16_col_0_tme),
                         .BIST_ROTATE_SR (tcam_row_16_col_0_bist_rotate_sr),
                         .BIST_EN_SR_MASK_B (tcam_row_16_col_0_bist_en_sr_mask_b),
                         .BIST_ALL_MASK (tcam_row_16_col_0_bist_all_mask),
                         .BIST_EN_SR_DATA_B (tcam_row_16_col_0_bist_en_sr_data_b),
                         .BIST_CM_MODE (tcam_row_16_col_0_bist_cm_mode),
                         .BIST_CM_EN_IN (tcam_row_16_col_0_bist_cm_en_in),
                         .BIST_CM_MATCH_SEL0 (tcam_row_16_col_0_bist_cm_match_sel0),
                         .BIST_CM_MATCH_SEL1 (tcam_row_16_col_0_bist_cm_match_sel1),
                         .BIST_MATCHIN_IN (tcam_row_16_col_0_bist_matchin_in),
                         .BIST_FLS (tcam_row_16_col_0_bist_fls),
                         .MDST_tcam (fuse_tcam)
                     );
        
              end
              
            else
              begin : gen_tcam_row_16_col_0_bcam
              end
              
        
        
        endgenerate
        
        always_ff @(posedge clk) begin
                   tcam_rd_data_col[16][0]      <= tcam_row_16_col_0_data_out;
                   tcam_col_hit_out[16][0]       <= tcam_row_16_col_0_hit_out;
        end
        

        // this is new template - tcam_asic_template
        
        wire                                            tcam_row_16_col_1_clk         = clk;
        
        wire    [TCAM_SLICE_EN_FACT-1:0]                tcam_row_16_col_1_slice_en = TCAM_SLICE_EN_FACT'(slice_en[(16 * TCAM_SLICE_EN_FACT)+:TCAM_SLICE_EN_MIN]);
        
        wire                                            tcam_row_16_col_1_rd_en       = tcam_row_rd_en[16];
        wire                                            tcam_row_16_col_1_wr_en       = tcam_row_wr_en[16];
        wire                                            tcam_row_16_col_1_chk_en      = chk_en;
        wire                                            tcam_row_16_col_1_reset_n = reset_n;
        wire    [7-1:0]                       tcam_row_16_col_1_adr  = tcam_row_adr[16][7-1:0];
        wire    [32-1:0]                      tcam_row_16_col_1_data_in = tcam_row_wr_en[16] ? tcam_wr_data_col[1][32-1:0] : tcam_chk_key_col[1][32-1:0];
        wire    [32-1:0]                      tcam_row_16_col_1_data_in_pre = tcam_wr_data_col[1][32-1:0] ;
        wire    [32-1:0]                      tcam_row_16_col_1_key_in =  tcam_chk_key_col[1][32-1:0];
        wire    [32-1:0]                      tcam_row_16_col_1_mask_in = tcam_chk_mask_col[1][32-1:0];
        wire    [64-1:0]                       tcam_row_16_col_1_hit_in = tcam_raw_hit_in[16];
        wire    [64-1:0]                       tcam_row_16_col_1_tcam_match_in = tcam_row_match_in[16];
        wire    [32-1:0]                      tcam_row_16_col_1_data_out_inv;
        logic   [64-1:0]                     tcam_row_16_col_1_hit_out_int;
        logic   [64-1:0]                     tcam_row_16_col_1_hit_out_latch;
        logic   [64-1:0]                     tcam_row_16_col_1_hit_out;
        
        `ifdef HIF_PCIE_DFX_DISABLE
        wire                          tcam_row_16_col_1_biste = 'b0; 
        wire     [5-1:0]                  tcam_row_16_col_1_fca = 'b0;
        wire                            tcam_row_16_col_1_cre = 'b0;
        wire                            tcam_row_16_col_1_dftshiften = 'b0;
        wire                            tcam_row_16_col_1_dftmask = 'b0;
        wire                            tcam_row_16_col_1_dft_array_freeze = 'b0;
        wire                            tcam_row_16_col_1_dft_afd_reset_b = 'b0;
        wire      [32-1:0]    tcam_row_16_col_1_tdin = 'b0;
        wire      [7-1:0]     tcam_row_16_col_1_tadr = 'b0;
        wire                            tcam_row_16_col_1_tvbe = 'b0;
        wire                            tcam_row_16_col_1_tvbi = 'b0;
        wire      [32-1:0]    tcam_row_16_col_1_tmask = 'b0;
        wire                            tcam_row_16_col_1_twe = 'b0;
        wire                            tcam_row_16_col_1_tre = 'b0;
        wire                            tcam_row_16_col_1_tme = 'b0;
        wire                            tcam_row_16_col_1_bist_rotate_sr = 'b0;
        wire                            tcam_row_16_col_1_bist_en_sr_mask_b = 'b0;
        wire                            tcam_row_16_col_1_bist_all_mask = 'b0;
        wire                            tcam_row_16_col_1_bist_en_sr_data_b = 'b0;
        wire                            tcam_row_16_col_1_bist_cm_mode = 'b0;
        wire                            tcam_row_16_col_1_bist_cm_en_in = 'b0;
        wire                            tcam_row_16_col_1_bist_cm_match_sel0 = 'b0;
        wire                            tcam_row_16_col_1_bist_cm_match_sel1 = 'b0;
        wire                            tcam_row_16_col_1_bist_matchin_in = 'b0;
        wire                            tcam_row_16_col_1_bist_fls = 'b0;
        
        `else
        wire                            tcam_row_16_col_1_biste = 'b0;
        wire     [5-1:0]                  tcam_row_16_col_1_fca = 'b0;
        wire                            tcam_row_16_col_1_cre = 'b0;
        wire                            tcam_row_16_col_1_dftshiften = dftshiften;
        wire                            tcam_row_16_col_1_dftmask = dftmask;
        wire                            tcam_row_16_col_1_dft_array_freeze = dft_array_freeze;
        wire                            tcam_row_16_col_1_dft_afd_reset_b = dft_afd_reset_b;
        wire      [32-1:0]    tcam_row_16_col_1_tdin = 'b0;
        wire      [7-1:0]     tcam_row_16_col_1_tadr = 'b0;
        wire                            tcam_row_16_col_1_tvbe = 'b0;
        wire                            tcam_row_16_col_1_tvbi = 'b0;
        wire      [32-1:0]    tcam_row_16_col_1_tmask = 'b0;
        wire                            tcam_row_16_col_1_twe = 'b0;
        wire                            tcam_row_16_col_1_tre = 'b0;
        wire                            tcam_row_16_col_1_tme = 'b0;
        wire                            tcam_row_16_col_1_bist_rotate_sr = 'b0;
        wire                            tcam_row_16_col_1_bist_en_sr_mask_b = 'b0;
        wire                            tcam_row_16_col_1_bist_all_mask = 'b0;
        wire                            tcam_row_16_col_1_bist_en_sr_data_b = 'b0;
        wire                            tcam_row_16_col_1_bist_cm_mode = 'b0;
        wire                            tcam_row_16_col_1_bist_cm_en_in = 'b0;
        wire                            tcam_row_16_col_1_bist_cm_match_sel0 = 'b0;
        wire                            tcam_row_16_col_1_bist_cm_match_sel1 = 'b0;
        wire                            tcam_row_16_col_1_bist_matchin_in = 'b0;
        wire                            tcam_row_16_col_1_bist_fls = 'b0;
        `endif
        
        // Outputs
        logic                           tcam_row_16_col_1_wr_bira_fail;
        logic                           tcam_row_16_col_1_wr_so;
        logic                           tcam_row_16_col_1_curerrout;
        logic                           tcam_row_16_col_1_rscout;
        
        
        
        logic   [TCAM_SLICE_EN_FACT-1:0]                  tcam_row_16_col_1_slice_en_s0; 
        logic   [TCAM_SLICE_EN_FACT-1:0]                  tcam_row_16_col_1_slice_en_s1; 
        
        
        
             wire    [32-1:0]                     tcam_row_16_col_1_data_out ;
        
        
        
         generate
            if (BCAM_N7 == 0) 
              begin : gen_tcam_row_16_col_1_tcam
        
        
        // slice_en kept for TCAM only for backward compatability with Intel process
                always_comb 
                begin
                  for (int i = 0; i < TCAM_SLICE_EN_FACT; i++)
                      if (tcam_row_16_col_1_slice_en_s1[i])
                           tcam_row_16_col_1_hit_out[ i*64 +: 64]  = tcam_row_16_col_1_hit_out_int  [ i*64 +: 64]; 
                      else
                           tcam_row_16_col_1_hit_out[ i*64 +: 64]  = tcam_row_16_col_1_hit_out_latch[ i*64 +: 64]; 
                end
        
        
        
                always_ff  @(posedge tcam_row_16_col_1_clk)
                begin
                  tcam_row_16_col_1_slice_en_s0 <= tcam_row_16_col_1_slice_en; 
                  tcam_row_16_col_1_slice_en_s1 <= tcam_row_16_col_1_slice_en_s0; 
        
                  for (int i = 0; i < TCAM_SLICE_EN_FACT; i++)
                    begin
                      if (tcam_row_16_col_1_slice_en_s1[i])
                         tcam_row_16_col_1_hit_out_latch[ i*64 +: 64] <=  tcam_row_16_col_1_hit_out_int[ i*64 +: 64];
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
        
                     
                         assign tcam_row_16_col_1_data_out  = ~tcam_row_16_col_1_data_out_inv;
                         pcie_itp_ip783tcam64x32s0c1_16_1_wrap #(        
                                 )               
        
                                 ip783tcam64x32s0c1_wrap_tcam_row_16_col_1 (
                   //-------------------------------------------------------------
                   // Power Management Interfaces
                   //-------------------------------------------------------------   
                      `ifndef INTEL_NO_PWR_PINS
                      `ifdef INTC_ADD_VSS
                        .vss              (1'b0),
                      `endif
                        .vddp             (1'b1),
                      `endif
                         .ADR               (tcam_row_16_col_1_adr[7-1:1]), //Input adr_intess
                         .ME                (ce),  
        
                         .CLK               (tcam_row_16_col_1_clk), //Clock
                         .CMP               (tcam_row_16_col_1_chk_en), //Control Enable
                         .DIN               (~tcam_row_16_col_1_data_in), 
                         .DSEL              (~tcam_row_16_col_1_adr[0]), //dncen enables access of the TCAM Arrays adr_intessed
                         .FLS               (flush), //flush initiates a Flush operation that resets all Valid
                         .RVLD              (tcam_row_16_col_1_hit_in ), //Row validation bus. Each match_in input controls 1
                         .MASK              (tcam_row_16_col_1_mask_in), //Input msk
                         .QOUT              (tcam_row_16_col_1_data_out_inv), //Output vben
                         .QHR               (tcam_row_16_col_1_hit_out_int),
                         .QVLD              (), 
                         .RE                (tcam_row_16_col_1_rd_en), //Read Enable
                         .RST               (tcam_row_16_col_1_reset_n), //Asynchronous Active-High Reset
                         .VBE               (1'b1), //vben enables the Valid Bit addressed by adr[a-1:0] to
                         .VBI               (1'b0),//  Valid Bit Input
                         .WE                (tcam_row_16_col_1_wr_en), //Write Enable
                         .FAF               (tcam_row_16_col_1_fca),
                         .FAF_EN            (tcam_row_16_col_1_cre),
                         .DFTSHIFTEN        (tcam_row_16_col_1_dftshiften),
                         .DFTMASK           (tcam_row_16_col_1_dftmask),
                         .DFT_ARRAY_FREEZE  (tcam_row_16_col_1_dft_array_freeze),
                         .DFT_AFD_RESET_B   (tcam_row_16_col_1_dft_afd_reset_b),
                         .BISTE           (tcam_row_16_col_1_biste),
                         .TDIN (tcam_row_16_col_1_tdin),
                         .TADR (tcam_row_16_col_1_tadr),
                         .TVBE (tcam_row_16_col_1_tvbe),
                         .TVBI (tcam_row_16_col_1_tvbi),
                         .TMASK (tcam_row_16_col_1_tmask),
                         .TWE (tcam_row_16_col_1_twe),
                         .TRE (tcam_row_16_col_1_tre),
                         .TME (tcam_row_16_col_1_tme),
                         .BIST_ROTATE_SR (tcam_row_16_col_1_bist_rotate_sr),
                         .BIST_EN_SR_MASK_B (tcam_row_16_col_1_bist_en_sr_mask_b),
                         .BIST_ALL_MASK (tcam_row_16_col_1_bist_all_mask),
                         .BIST_EN_SR_DATA_B (tcam_row_16_col_1_bist_en_sr_data_b),
                         .BIST_CM_MODE (tcam_row_16_col_1_bist_cm_mode),
                         .BIST_CM_EN_IN (tcam_row_16_col_1_bist_cm_en_in),
                         .BIST_CM_MATCH_SEL0 (tcam_row_16_col_1_bist_cm_match_sel0),
                         .BIST_CM_MATCH_SEL1 (tcam_row_16_col_1_bist_cm_match_sel1),
                         .BIST_MATCHIN_IN (tcam_row_16_col_1_bist_matchin_in),
                         .BIST_FLS (tcam_row_16_col_1_bist_fls),
                         .MDST_tcam (fuse_tcam)
                     );
        
              end
              
            else
              begin : gen_tcam_row_16_col_1_bcam
              end
              
        
        
        endgenerate
        
        always_ff @(posedge clk) begin
                   tcam_rd_data_col[16][1]      <= tcam_row_16_col_1_data_out;
                   tcam_col_hit_out[16][1]       <= tcam_row_16_col_1_hit_out;
        end
        

        // this is new template - tcam_asic_template
        
        wire                                            tcam_row_17_col_0_clk         = clk;
        
        wire    [TCAM_SLICE_EN_FACT-1:0]                tcam_row_17_col_0_slice_en = TCAM_SLICE_EN_FACT'(slice_en[(17 * TCAM_SLICE_EN_FACT)+:TCAM_SLICE_EN_MIN]);
        
        wire                                            tcam_row_17_col_0_rd_en       = tcam_row_rd_en[17];
        wire                                            tcam_row_17_col_0_wr_en       = tcam_row_wr_en[17];
        wire                                            tcam_row_17_col_0_chk_en      = chk_en;
        wire                                            tcam_row_17_col_0_reset_n = reset_n;
        wire    [7-1:0]                       tcam_row_17_col_0_adr  = tcam_row_adr[17][7-1:0];
        wire    [32-1:0]                      tcam_row_17_col_0_data_in = tcam_row_wr_en[17] ? tcam_wr_data_col[0][32-1:0] : tcam_chk_key_col[0][32-1:0];
        wire    [32-1:0]                      tcam_row_17_col_0_data_in_pre = tcam_wr_data_col[0][32-1:0] ;
        wire    [32-1:0]                      tcam_row_17_col_0_key_in =  tcam_chk_key_col[0][32-1:0];
        wire    [32-1:0]                      tcam_row_17_col_0_mask_in = tcam_chk_mask_col[0][32-1:0];
        wire    [64-1:0]                       tcam_row_17_col_0_hit_in = tcam_raw_hit_in[17];
        wire    [64-1:0]                       tcam_row_17_col_0_tcam_match_in = tcam_row_match_in[17];
        wire    [32-1:0]                      tcam_row_17_col_0_data_out_inv;
        logic   [64-1:0]                     tcam_row_17_col_0_hit_out_int;
        logic   [64-1:0]                     tcam_row_17_col_0_hit_out_latch;
        logic   [64-1:0]                     tcam_row_17_col_0_hit_out;
        
        `ifdef HIF_PCIE_DFX_DISABLE
        wire                          tcam_row_17_col_0_biste = 'b0; 
        wire     [5-1:0]                  tcam_row_17_col_0_fca = 'b0;
        wire                            tcam_row_17_col_0_cre = 'b0;
        wire                            tcam_row_17_col_0_dftshiften = 'b0;
        wire                            tcam_row_17_col_0_dftmask = 'b0;
        wire                            tcam_row_17_col_0_dft_array_freeze = 'b0;
        wire                            tcam_row_17_col_0_dft_afd_reset_b = 'b0;
        wire      [32-1:0]    tcam_row_17_col_0_tdin = 'b0;
        wire      [7-1:0]     tcam_row_17_col_0_tadr = 'b0;
        wire                            tcam_row_17_col_0_tvbe = 'b0;
        wire                            tcam_row_17_col_0_tvbi = 'b0;
        wire      [32-1:0]    tcam_row_17_col_0_tmask = 'b0;
        wire                            tcam_row_17_col_0_twe = 'b0;
        wire                            tcam_row_17_col_0_tre = 'b0;
        wire                            tcam_row_17_col_0_tme = 'b0;
        wire                            tcam_row_17_col_0_bist_rotate_sr = 'b0;
        wire                            tcam_row_17_col_0_bist_en_sr_mask_b = 'b0;
        wire                            tcam_row_17_col_0_bist_all_mask = 'b0;
        wire                            tcam_row_17_col_0_bist_en_sr_data_b = 'b0;
        wire                            tcam_row_17_col_0_bist_cm_mode = 'b0;
        wire                            tcam_row_17_col_0_bist_cm_en_in = 'b0;
        wire                            tcam_row_17_col_0_bist_cm_match_sel0 = 'b0;
        wire                            tcam_row_17_col_0_bist_cm_match_sel1 = 'b0;
        wire                            tcam_row_17_col_0_bist_matchin_in = 'b0;
        wire                            tcam_row_17_col_0_bist_fls = 'b0;
        
        `else
        wire                            tcam_row_17_col_0_biste = 'b0;
        wire     [5-1:0]                  tcam_row_17_col_0_fca = 'b0;
        wire                            tcam_row_17_col_0_cre = 'b0;
        wire                            tcam_row_17_col_0_dftshiften = dftshiften;
        wire                            tcam_row_17_col_0_dftmask = dftmask;
        wire                            tcam_row_17_col_0_dft_array_freeze = dft_array_freeze;
        wire                            tcam_row_17_col_0_dft_afd_reset_b = dft_afd_reset_b;
        wire      [32-1:0]    tcam_row_17_col_0_tdin = 'b0;
        wire      [7-1:0]     tcam_row_17_col_0_tadr = 'b0;
        wire                            tcam_row_17_col_0_tvbe = 'b0;
        wire                            tcam_row_17_col_0_tvbi = 'b0;
        wire      [32-1:0]    tcam_row_17_col_0_tmask = 'b0;
        wire                            tcam_row_17_col_0_twe = 'b0;
        wire                            tcam_row_17_col_0_tre = 'b0;
        wire                            tcam_row_17_col_0_tme = 'b0;
        wire                            tcam_row_17_col_0_bist_rotate_sr = 'b0;
        wire                            tcam_row_17_col_0_bist_en_sr_mask_b = 'b0;
        wire                            tcam_row_17_col_0_bist_all_mask = 'b0;
        wire                            tcam_row_17_col_0_bist_en_sr_data_b = 'b0;
        wire                            tcam_row_17_col_0_bist_cm_mode = 'b0;
        wire                            tcam_row_17_col_0_bist_cm_en_in = 'b0;
        wire                            tcam_row_17_col_0_bist_cm_match_sel0 = 'b0;
        wire                            tcam_row_17_col_0_bist_cm_match_sel1 = 'b0;
        wire                            tcam_row_17_col_0_bist_matchin_in = 'b0;
        wire                            tcam_row_17_col_0_bist_fls = 'b0;
        `endif
        
        // Outputs
        logic                           tcam_row_17_col_0_wr_bira_fail;
        logic                           tcam_row_17_col_0_wr_so;
        logic                           tcam_row_17_col_0_curerrout;
        logic                           tcam_row_17_col_0_rscout;
        
        
        
        logic   [TCAM_SLICE_EN_FACT-1:0]                  tcam_row_17_col_0_slice_en_s0; 
        logic   [TCAM_SLICE_EN_FACT-1:0]                  tcam_row_17_col_0_slice_en_s1; 
        
        
        
             wire    [32-1:0]                     tcam_row_17_col_0_data_out ;
        
        
        
         generate
            if (BCAM_N7 == 0) 
              begin : gen_tcam_row_17_col_0_tcam
        
        
        // slice_en kept for TCAM only for backward compatability with Intel process
                always_comb 
                begin
                  for (int i = 0; i < TCAM_SLICE_EN_FACT; i++)
                      if (tcam_row_17_col_0_slice_en_s1[i])
                           tcam_row_17_col_0_hit_out[ i*64 +: 64]  = tcam_row_17_col_0_hit_out_int  [ i*64 +: 64]; 
                      else
                           tcam_row_17_col_0_hit_out[ i*64 +: 64]  = tcam_row_17_col_0_hit_out_latch[ i*64 +: 64]; 
                end
        
        
        
                always_ff  @(posedge tcam_row_17_col_0_clk)
                begin
                  tcam_row_17_col_0_slice_en_s0 <= tcam_row_17_col_0_slice_en; 
                  tcam_row_17_col_0_slice_en_s1 <= tcam_row_17_col_0_slice_en_s0; 
        
                  for (int i = 0; i < TCAM_SLICE_EN_FACT; i++)
                    begin
                      if (tcam_row_17_col_0_slice_en_s1[i])
                         tcam_row_17_col_0_hit_out_latch[ i*64 +: 64] <=  tcam_row_17_col_0_hit_out_int[ i*64 +: 64];
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
        
                     
                         assign tcam_row_17_col_0_data_out  = ~tcam_row_17_col_0_data_out_inv;
                         pcie_itp_ip783tcam64x32s0c1_17_0_wrap #(        
                                 )               
        
                                 ip783tcam64x32s0c1_wrap_tcam_row_17_col_0 (
                   //-------------------------------------------------------------
                   // Power Management Interfaces
                   //-------------------------------------------------------------   
                      `ifndef INTEL_NO_PWR_PINS
                      `ifdef INTC_ADD_VSS
                        .vss              (1'b0),
                      `endif
                        .vddp             (1'b1),
                      `endif
                         .ADR               (tcam_row_17_col_0_adr[7-1:1]), //Input adr_intess
                         .ME                (ce),  
        
                         .CLK               (tcam_row_17_col_0_clk), //Clock
                         .CMP               (tcam_row_17_col_0_chk_en), //Control Enable
                         .DIN               (~tcam_row_17_col_0_data_in), 
                         .DSEL              (~tcam_row_17_col_0_adr[0]), //dncen enables access of the TCAM Arrays adr_intessed
                         .FLS               (flush), //flush initiates a Flush operation that resets all Valid
                         .RVLD              (tcam_row_17_col_0_hit_in ), //Row validation bus. Each match_in input controls 1
                         .MASK              (tcam_row_17_col_0_mask_in), //Input msk
                         .QOUT              (tcam_row_17_col_0_data_out_inv), //Output vben
                         .QHR               (tcam_row_17_col_0_hit_out_int),
                         .QVLD              (), 
                         .RE                (tcam_row_17_col_0_rd_en), //Read Enable
                         .RST               (tcam_row_17_col_0_reset_n), //Asynchronous Active-High Reset
                         .VBE               (1'b1), //vben enables the Valid Bit addressed by adr[a-1:0] to
                         .VBI               (1'b0),//  Valid Bit Input
                         .WE                (tcam_row_17_col_0_wr_en), //Write Enable
                         .FAF               (tcam_row_17_col_0_fca),
                         .FAF_EN            (tcam_row_17_col_0_cre),
                         .DFTSHIFTEN        (tcam_row_17_col_0_dftshiften),
                         .DFTMASK           (tcam_row_17_col_0_dftmask),
                         .DFT_ARRAY_FREEZE  (tcam_row_17_col_0_dft_array_freeze),
                         .DFT_AFD_RESET_B   (tcam_row_17_col_0_dft_afd_reset_b),
                         .BISTE           (tcam_row_17_col_0_biste),
                         .TDIN (tcam_row_17_col_0_tdin),
                         .TADR (tcam_row_17_col_0_tadr),
                         .TVBE (tcam_row_17_col_0_tvbe),
                         .TVBI (tcam_row_17_col_0_tvbi),
                         .TMASK (tcam_row_17_col_0_tmask),
                         .TWE (tcam_row_17_col_0_twe),
                         .TRE (tcam_row_17_col_0_tre),
                         .TME (tcam_row_17_col_0_tme),
                         .BIST_ROTATE_SR (tcam_row_17_col_0_bist_rotate_sr),
                         .BIST_EN_SR_MASK_B (tcam_row_17_col_0_bist_en_sr_mask_b),
                         .BIST_ALL_MASK (tcam_row_17_col_0_bist_all_mask),
                         .BIST_EN_SR_DATA_B (tcam_row_17_col_0_bist_en_sr_data_b),
                         .BIST_CM_MODE (tcam_row_17_col_0_bist_cm_mode),
                         .BIST_CM_EN_IN (tcam_row_17_col_0_bist_cm_en_in),
                         .BIST_CM_MATCH_SEL0 (tcam_row_17_col_0_bist_cm_match_sel0),
                         .BIST_CM_MATCH_SEL1 (tcam_row_17_col_0_bist_cm_match_sel1),
                         .BIST_MATCHIN_IN (tcam_row_17_col_0_bist_matchin_in),
                         .BIST_FLS (tcam_row_17_col_0_bist_fls),
                         .MDST_tcam (fuse_tcam)
                     );
        
              end
              
            else
              begin : gen_tcam_row_17_col_0_bcam
              end
              
        
        
        endgenerate
        
        always_ff @(posedge clk) begin
                   tcam_rd_data_col[17][0]      <= tcam_row_17_col_0_data_out;
                   tcam_col_hit_out[17][0]       <= tcam_row_17_col_0_hit_out;
        end
        

        // this is new template - tcam_asic_template
        
        wire                                            tcam_row_17_col_1_clk         = clk;
        
        wire    [TCAM_SLICE_EN_FACT-1:0]                tcam_row_17_col_1_slice_en = TCAM_SLICE_EN_FACT'(slice_en[(17 * TCAM_SLICE_EN_FACT)+:TCAM_SLICE_EN_MIN]);
        
        wire                                            tcam_row_17_col_1_rd_en       = tcam_row_rd_en[17];
        wire                                            tcam_row_17_col_1_wr_en       = tcam_row_wr_en[17];
        wire                                            tcam_row_17_col_1_chk_en      = chk_en;
        wire                                            tcam_row_17_col_1_reset_n = reset_n;
        wire    [7-1:0]                       tcam_row_17_col_1_adr  = tcam_row_adr[17][7-1:0];
        wire    [32-1:0]                      tcam_row_17_col_1_data_in = tcam_row_wr_en[17] ? tcam_wr_data_col[1][32-1:0] : tcam_chk_key_col[1][32-1:0];
        wire    [32-1:0]                      tcam_row_17_col_1_data_in_pre = tcam_wr_data_col[1][32-1:0] ;
        wire    [32-1:0]                      tcam_row_17_col_1_key_in =  tcam_chk_key_col[1][32-1:0];
        wire    [32-1:0]                      tcam_row_17_col_1_mask_in = tcam_chk_mask_col[1][32-1:0];
        wire    [64-1:0]                       tcam_row_17_col_1_hit_in = tcam_raw_hit_in[17];
        wire    [64-1:0]                       tcam_row_17_col_1_tcam_match_in = tcam_row_match_in[17];
        wire    [32-1:0]                      tcam_row_17_col_1_data_out_inv;
        logic   [64-1:0]                     tcam_row_17_col_1_hit_out_int;
        logic   [64-1:0]                     tcam_row_17_col_1_hit_out_latch;
        logic   [64-1:0]                     tcam_row_17_col_1_hit_out;
        
        `ifdef HIF_PCIE_DFX_DISABLE
        wire                          tcam_row_17_col_1_biste = 'b0; 
        wire     [5-1:0]                  tcam_row_17_col_1_fca = 'b0;
        wire                            tcam_row_17_col_1_cre = 'b0;
        wire                            tcam_row_17_col_1_dftshiften = 'b0;
        wire                            tcam_row_17_col_1_dftmask = 'b0;
        wire                            tcam_row_17_col_1_dft_array_freeze = 'b0;
        wire                            tcam_row_17_col_1_dft_afd_reset_b = 'b0;
        wire      [32-1:0]    tcam_row_17_col_1_tdin = 'b0;
        wire      [7-1:0]     tcam_row_17_col_1_tadr = 'b0;
        wire                            tcam_row_17_col_1_tvbe = 'b0;
        wire                            tcam_row_17_col_1_tvbi = 'b0;
        wire      [32-1:0]    tcam_row_17_col_1_tmask = 'b0;
        wire                            tcam_row_17_col_1_twe = 'b0;
        wire                            tcam_row_17_col_1_tre = 'b0;
        wire                            tcam_row_17_col_1_tme = 'b0;
        wire                            tcam_row_17_col_1_bist_rotate_sr = 'b0;
        wire                            tcam_row_17_col_1_bist_en_sr_mask_b = 'b0;
        wire                            tcam_row_17_col_1_bist_all_mask = 'b0;
        wire                            tcam_row_17_col_1_bist_en_sr_data_b = 'b0;
        wire                            tcam_row_17_col_1_bist_cm_mode = 'b0;
        wire                            tcam_row_17_col_1_bist_cm_en_in = 'b0;
        wire                            tcam_row_17_col_1_bist_cm_match_sel0 = 'b0;
        wire                            tcam_row_17_col_1_bist_cm_match_sel1 = 'b0;
        wire                            tcam_row_17_col_1_bist_matchin_in = 'b0;
        wire                            tcam_row_17_col_1_bist_fls = 'b0;
        
        `else
        wire                            tcam_row_17_col_1_biste = 'b0;
        wire     [5-1:0]                  tcam_row_17_col_1_fca = 'b0;
        wire                            tcam_row_17_col_1_cre = 'b0;
        wire                            tcam_row_17_col_1_dftshiften = dftshiften;
        wire                            tcam_row_17_col_1_dftmask = dftmask;
        wire                            tcam_row_17_col_1_dft_array_freeze = dft_array_freeze;
        wire                            tcam_row_17_col_1_dft_afd_reset_b = dft_afd_reset_b;
        wire      [32-1:0]    tcam_row_17_col_1_tdin = 'b0;
        wire      [7-1:0]     tcam_row_17_col_1_tadr = 'b0;
        wire                            tcam_row_17_col_1_tvbe = 'b0;
        wire                            tcam_row_17_col_1_tvbi = 'b0;
        wire      [32-1:0]    tcam_row_17_col_1_tmask = 'b0;
        wire                            tcam_row_17_col_1_twe = 'b0;
        wire                            tcam_row_17_col_1_tre = 'b0;
        wire                            tcam_row_17_col_1_tme = 'b0;
        wire                            tcam_row_17_col_1_bist_rotate_sr = 'b0;
        wire                            tcam_row_17_col_1_bist_en_sr_mask_b = 'b0;
        wire                            tcam_row_17_col_1_bist_all_mask = 'b0;
        wire                            tcam_row_17_col_1_bist_en_sr_data_b = 'b0;
        wire                            tcam_row_17_col_1_bist_cm_mode = 'b0;
        wire                            tcam_row_17_col_1_bist_cm_en_in = 'b0;
        wire                            tcam_row_17_col_1_bist_cm_match_sel0 = 'b0;
        wire                            tcam_row_17_col_1_bist_cm_match_sel1 = 'b0;
        wire                            tcam_row_17_col_1_bist_matchin_in = 'b0;
        wire                            tcam_row_17_col_1_bist_fls = 'b0;
        `endif
        
        // Outputs
        logic                           tcam_row_17_col_1_wr_bira_fail;
        logic                           tcam_row_17_col_1_wr_so;
        logic                           tcam_row_17_col_1_curerrout;
        logic                           tcam_row_17_col_1_rscout;
        
        
        
        logic   [TCAM_SLICE_EN_FACT-1:0]                  tcam_row_17_col_1_slice_en_s0; 
        logic   [TCAM_SLICE_EN_FACT-1:0]                  tcam_row_17_col_1_slice_en_s1; 
        
        
        
             wire    [32-1:0]                     tcam_row_17_col_1_data_out ;
        
        
        
         generate
            if (BCAM_N7 == 0) 
              begin : gen_tcam_row_17_col_1_tcam
        
        
        // slice_en kept for TCAM only for backward compatability with Intel process
                always_comb 
                begin
                  for (int i = 0; i < TCAM_SLICE_EN_FACT; i++)
                      if (tcam_row_17_col_1_slice_en_s1[i])
                           tcam_row_17_col_1_hit_out[ i*64 +: 64]  = tcam_row_17_col_1_hit_out_int  [ i*64 +: 64]; 
                      else
                           tcam_row_17_col_1_hit_out[ i*64 +: 64]  = tcam_row_17_col_1_hit_out_latch[ i*64 +: 64]; 
                end
        
        
        
                always_ff  @(posedge tcam_row_17_col_1_clk)
                begin
                  tcam_row_17_col_1_slice_en_s0 <= tcam_row_17_col_1_slice_en; 
                  tcam_row_17_col_1_slice_en_s1 <= tcam_row_17_col_1_slice_en_s0; 
        
                  for (int i = 0; i < TCAM_SLICE_EN_FACT; i++)
                    begin
                      if (tcam_row_17_col_1_slice_en_s1[i])
                         tcam_row_17_col_1_hit_out_latch[ i*64 +: 64] <=  tcam_row_17_col_1_hit_out_int[ i*64 +: 64];
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
        
                     
                         assign tcam_row_17_col_1_data_out  = ~tcam_row_17_col_1_data_out_inv;
                         pcie_itp_ip783tcam64x32s0c1_17_1_wrap #(        
                                 )               
        
                                 ip783tcam64x32s0c1_wrap_tcam_row_17_col_1 (
                   //-------------------------------------------------------------
                   // Power Management Interfaces
                   //-------------------------------------------------------------   
                      `ifndef INTEL_NO_PWR_PINS
                      `ifdef INTC_ADD_VSS
                        .vss              (1'b0),
                      `endif
                        .vddp             (1'b1),
                      `endif
                         .ADR               (tcam_row_17_col_1_adr[7-1:1]), //Input adr_intess
                         .ME                (ce),  
        
                         .CLK               (tcam_row_17_col_1_clk), //Clock
                         .CMP               (tcam_row_17_col_1_chk_en), //Control Enable
                         .DIN               (~tcam_row_17_col_1_data_in), 
                         .DSEL              (~tcam_row_17_col_1_adr[0]), //dncen enables access of the TCAM Arrays adr_intessed
                         .FLS               (flush), //flush initiates a Flush operation that resets all Valid
                         .RVLD              (tcam_row_17_col_1_hit_in ), //Row validation bus. Each match_in input controls 1
                         .MASK              (tcam_row_17_col_1_mask_in), //Input msk
                         .QOUT              (tcam_row_17_col_1_data_out_inv), //Output vben
                         .QHR               (tcam_row_17_col_1_hit_out_int),
                         .QVLD              (), 
                         .RE                (tcam_row_17_col_1_rd_en), //Read Enable
                         .RST               (tcam_row_17_col_1_reset_n), //Asynchronous Active-High Reset
                         .VBE               (1'b1), //vben enables the Valid Bit addressed by adr[a-1:0] to
                         .VBI               (1'b0),//  Valid Bit Input
                         .WE                (tcam_row_17_col_1_wr_en), //Write Enable
                         .FAF               (tcam_row_17_col_1_fca),
                         .FAF_EN            (tcam_row_17_col_1_cre),
                         .DFTSHIFTEN        (tcam_row_17_col_1_dftshiften),
                         .DFTMASK           (tcam_row_17_col_1_dftmask),
                         .DFT_ARRAY_FREEZE  (tcam_row_17_col_1_dft_array_freeze),
                         .DFT_AFD_RESET_B   (tcam_row_17_col_1_dft_afd_reset_b),
                         .BISTE           (tcam_row_17_col_1_biste),
                         .TDIN (tcam_row_17_col_1_tdin),
                         .TADR (tcam_row_17_col_1_tadr),
                         .TVBE (tcam_row_17_col_1_tvbe),
                         .TVBI (tcam_row_17_col_1_tvbi),
                         .TMASK (tcam_row_17_col_1_tmask),
                         .TWE (tcam_row_17_col_1_twe),
                         .TRE (tcam_row_17_col_1_tre),
                         .TME (tcam_row_17_col_1_tme),
                         .BIST_ROTATE_SR (tcam_row_17_col_1_bist_rotate_sr),
                         .BIST_EN_SR_MASK_B (tcam_row_17_col_1_bist_en_sr_mask_b),
                         .BIST_ALL_MASK (tcam_row_17_col_1_bist_all_mask),
                         .BIST_EN_SR_DATA_B (tcam_row_17_col_1_bist_en_sr_data_b),
                         .BIST_CM_MODE (tcam_row_17_col_1_bist_cm_mode),
                         .BIST_CM_EN_IN (tcam_row_17_col_1_bist_cm_en_in),
                         .BIST_CM_MATCH_SEL0 (tcam_row_17_col_1_bist_cm_match_sel0),
                         .BIST_CM_MATCH_SEL1 (tcam_row_17_col_1_bist_cm_match_sel1),
                         .BIST_MATCHIN_IN (tcam_row_17_col_1_bist_matchin_in),
                         .BIST_FLS (tcam_row_17_col_1_bist_fls),
                         .MDST_tcam (fuse_tcam)
                     );
        
              end
              
            else
              begin : gen_tcam_row_17_col_1_bcam
              end
              
        
        
        endgenerate
        
        always_ff @(posedge clk) begin
                   tcam_rd_data_col[17][1]      <= tcam_row_17_col_1_data_out;
                   tcam_col_hit_out[17][1]       <= tcam_row_17_col_1_hit_out;
        end
        

        // this is new template - tcam_asic_template
        
        wire                                            tcam_row_18_col_0_clk         = clk;
        
        wire    [TCAM_SLICE_EN_FACT-1:0]                tcam_row_18_col_0_slice_en = TCAM_SLICE_EN_FACT'(slice_en[(18 * TCAM_SLICE_EN_FACT)+:TCAM_SLICE_EN_MIN]);
        
        wire                                            tcam_row_18_col_0_rd_en       = tcam_row_rd_en[18];
        wire                                            tcam_row_18_col_0_wr_en       = tcam_row_wr_en[18];
        wire                                            tcam_row_18_col_0_chk_en      = chk_en;
        wire                                            tcam_row_18_col_0_reset_n = reset_n;
        wire    [7-1:0]                       tcam_row_18_col_0_adr  = tcam_row_adr[18][7-1:0];
        wire    [32-1:0]                      tcam_row_18_col_0_data_in = tcam_row_wr_en[18] ? tcam_wr_data_col[0][32-1:0] : tcam_chk_key_col[0][32-1:0];
        wire    [32-1:0]                      tcam_row_18_col_0_data_in_pre = tcam_wr_data_col[0][32-1:0] ;
        wire    [32-1:0]                      tcam_row_18_col_0_key_in =  tcam_chk_key_col[0][32-1:0];
        wire    [32-1:0]                      tcam_row_18_col_0_mask_in = tcam_chk_mask_col[0][32-1:0];
        wire    [64-1:0]                       tcam_row_18_col_0_hit_in = tcam_raw_hit_in[18];
        wire    [64-1:0]                       tcam_row_18_col_0_tcam_match_in = tcam_row_match_in[18];
        wire    [32-1:0]                      tcam_row_18_col_0_data_out_inv;
        logic   [64-1:0]                     tcam_row_18_col_0_hit_out_int;
        logic   [64-1:0]                     tcam_row_18_col_0_hit_out_latch;
        logic   [64-1:0]                     tcam_row_18_col_0_hit_out;
        
        `ifdef HIF_PCIE_DFX_DISABLE
        wire                          tcam_row_18_col_0_biste = 'b0; 
        wire     [5-1:0]                  tcam_row_18_col_0_fca = 'b0;
        wire                            tcam_row_18_col_0_cre = 'b0;
        wire                            tcam_row_18_col_0_dftshiften = 'b0;
        wire                            tcam_row_18_col_0_dftmask = 'b0;
        wire                            tcam_row_18_col_0_dft_array_freeze = 'b0;
        wire                            tcam_row_18_col_0_dft_afd_reset_b = 'b0;
        wire      [32-1:0]    tcam_row_18_col_0_tdin = 'b0;
        wire      [7-1:0]     tcam_row_18_col_0_tadr = 'b0;
        wire                            tcam_row_18_col_0_tvbe = 'b0;
        wire                            tcam_row_18_col_0_tvbi = 'b0;
        wire      [32-1:0]    tcam_row_18_col_0_tmask = 'b0;
        wire                            tcam_row_18_col_0_twe = 'b0;
        wire                            tcam_row_18_col_0_tre = 'b0;
        wire                            tcam_row_18_col_0_tme = 'b0;
        wire                            tcam_row_18_col_0_bist_rotate_sr = 'b0;
        wire                            tcam_row_18_col_0_bist_en_sr_mask_b = 'b0;
        wire                            tcam_row_18_col_0_bist_all_mask = 'b0;
        wire                            tcam_row_18_col_0_bist_en_sr_data_b = 'b0;
        wire                            tcam_row_18_col_0_bist_cm_mode = 'b0;
        wire                            tcam_row_18_col_0_bist_cm_en_in = 'b0;
        wire                            tcam_row_18_col_0_bist_cm_match_sel0 = 'b0;
        wire                            tcam_row_18_col_0_bist_cm_match_sel1 = 'b0;
        wire                            tcam_row_18_col_0_bist_matchin_in = 'b0;
        wire                            tcam_row_18_col_0_bist_fls = 'b0;
        
        `else
        wire                            tcam_row_18_col_0_biste = 'b0;
        wire     [5-1:0]                  tcam_row_18_col_0_fca = 'b0;
        wire                            tcam_row_18_col_0_cre = 'b0;
        wire                            tcam_row_18_col_0_dftshiften = dftshiften;
        wire                            tcam_row_18_col_0_dftmask = dftmask;
        wire                            tcam_row_18_col_0_dft_array_freeze = dft_array_freeze;
        wire                            tcam_row_18_col_0_dft_afd_reset_b = dft_afd_reset_b;
        wire      [32-1:0]    tcam_row_18_col_0_tdin = 'b0;
        wire      [7-1:0]     tcam_row_18_col_0_tadr = 'b0;
        wire                            tcam_row_18_col_0_tvbe = 'b0;
        wire                            tcam_row_18_col_0_tvbi = 'b0;
        wire      [32-1:0]    tcam_row_18_col_0_tmask = 'b0;
        wire                            tcam_row_18_col_0_twe = 'b0;
        wire                            tcam_row_18_col_0_tre = 'b0;
        wire                            tcam_row_18_col_0_tme = 'b0;
        wire                            tcam_row_18_col_0_bist_rotate_sr = 'b0;
        wire                            tcam_row_18_col_0_bist_en_sr_mask_b = 'b0;
        wire                            tcam_row_18_col_0_bist_all_mask = 'b0;
        wire                            tcam_row_18_col_0_bist_en_sr_data_b = 'b0;
        wire                            tcam_row_18_col_0_bist_cm_mode = 'b0;
        wire                            tcam_row_18_col_0_bist_cm_en_in = 'b0;
        wire                            tcam_row_18_col_0_bist_cm_match_sel0 = 'b0;
        wire                            tcam_row_18_col_0_bist_cm_match_sel1 = 'b0;
        wire                            tcam_row_18_col_0_bist_matchin_in = 'b0;
        wire                            tcam_row_18_col_0_bist_fls = 'b0;
        `endif
        
        // Outputs
        logic                           tcam_row_18_col_0_wr_bira_fail;
        logic                           tcam_row_18_col_0_wr_so;
        logic                           tcam_row_18_col_0_curerrout;
        logic                           tcam_row_18_col_0_rscout;
        
        
        
        logic   [TCAM_SLICE_EN_FACT-1:0]                  tcam_row_18_col_0_slice_en_s0; 
        logic   [TCAM_SLICE_EN_FACT-1:0]                  tcam_row_18_col_0_slice_en_s1; 
        
        
        
             wire    [32-1:0]                     tcam_row_18_col_0_data_out ;
        
        
        
         generate
            if (BCAM_N7 == 0) 
              begin : gen_tcam_row_18_col_0_tcam
        
        
        // slice_en kept for TCAM only for backward compatability with Intel process
                always_comb 
                begin
                  for (int i = 0; i < TCAM_SLICE_EN_FACT; i++)
                      if (tcam_row_18_col_0_slice_en_s1[i])
                           tcam_row_18_col_0_hit_out[ i*64 +: 64]  = tcam_row_18_col_0_hit_out_int  [ i*64 +: 64]; 
                      else
                           tcam_row_18_col_0_hit_out[ i*64 +: 64]  = tcam_row_18_col_0_hit_out_latch[ i*64 +: 64]; 
                end
        
        
        
                always_ff  @(posedge tcam_row_18_col_0_clk)
                begin
                  tcam_row_18_col_0_slice_en_s0 <= tcam_row_18_col_0_slice_en; 
                  tcam_row_18_col_0_slice_en_s1 <= tcam_row_18_col_0_slice_en_s0; 
        
                  for (int i = 0; i < TCAM_SLICE_EN_FACT; i++)
                    begin
                      if (tcam_row_18_col_0_slice_en_s1[i])
                         tcam_row_18_col_0_hit_out_latch[ i*64 +: 64] <=  tcam_row_18_col_0_hit_out_int[ i*64 +: 64];
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
        
                     
                         assign tcam_row_18_col_0_data_out  = ~tcam_row_18_col_0_data_out_inv;
                         pcie_itp_ip783tcam64x32s0c1_18_0_wrap #(        
                                 )               
        
                                 ip783tcam64x32s0c1_wrap_tcam_row_18_col_0 (
                   //-------------------------------------------------------------
                   // Power Management Interfaces
                   //-------------------------------------------------------------   
                      `ifndef INTEL_NO_PWR_PINS
                      `ifdef INTC_ADD_VSS
                        .vss              (1'b0),
                      `endif
                        .vddp             (1'b1),
                      `endif
                         .ADR               (tcam_row_18_col_0_adr[7-1:1]), //Input adr_intess
                         .ME                (ce),  
        
                         .CLK               (tcam_row_18_col_0_clk), //Clock
                         .CMP               (tcam_row_18_col_0_chk_en), //Control Enable
                         .DIN               (~tcam_row_18_col_0_data_in), 
                         .DSEL              (~tcam_row_18_col_0_adr[0]), //dncen enables access of the TCAM Arrays adr_intessed
                         .FLS               (flush), //flush initiates a Flush operation that resets all Valid
                         .RVLD              (tcam_row_18_col_0_hit_in ), //Row validation bus. Each match_in input controls 1
                         .MASK              (tcam_row_18_col_0_mask_in), //Input msk
                         .QOUT              (tcam_row_18_col_0_data_out_inv), //Output vben
                         .QHR               (tcam_row_18_col_0_hit_out_int),
                         .QVLD              (), 
                         .RE                (tcam_row_18_col_0_rd_en), //Read Enable
                         .RST               (tcam_row_18_col_0_reset_n), //Asynchronous Active-High Reset
                         .VBE               (1'b1), //vben enables the Valid Bit addressed by adr[a-1:0] to
                         .VBI               (1'b0),//  Valid Bit Input
                         .WE                (tcam_row_18_col_0_wr_en), //Write Enable
                         .FAF               (tcam_row_18_col_0_fca),
                         .FAF_EN            (tcam_row_18_col_0_cre),
                         .DFTSHIFTEN        (tcam_row_18_col_0_dftshiften),
                         .DFTMASK           (tcam_row_18_col_0_dftmask),
                         .DFT_ARRAY_FREEZE  (tcam_row_18_col_0_dft_array_freeze),
                         .DFT_AFD_RESET_B   (tcam_row_18_col_0_dft_afd_reset_b),
                         .BISTE           (tcam_row_18_col_0_biste),
                         .TDIN (tcam_row_18_col_0_tdin),
                         .TADR (tcam_row_18_col_0_tadr),
                         .TVBE (tcam_row_18_col_0_tvbe),
                         .TVBI (tcam_row_18_col_0_tvbi),
                         .TMASK (tcam_row_18_col_0_tmask),
                         .TWE (tcam_row_18_col_0_twe),
                         .TRE (tcam_row_18_col_0_tre),
                         .TME (tcam_row_18_col_0_tme),
                         .BIST_ROTATE_SR (tcam_row_18_col_0_bist_rotate_sr),
                         .BIST_EN_SR_MASK_B (tcam_row_18_col_0_bist_en_sr_mask_b),
                         .BIST_ALL_MASK (tcam_row_18_col_0_bist_all_mask),
                         .BIST_EN_SR_DATA_B (tcam_row_18_col_0_bist_en_sr_data_b),
                         .BIST_CM_MODE (tcam_row_18_col_0_bist_cm_mode),
                         .BIST_CM_EN_IN (tcam_row_18_col_0_bist_cm_en_in),
                         .BIST_CM_MATCH_SEL0 (tcam_row_18_col_0_bist_cm_match_sel0),
                         .BIST_CM_MATCH_SEL1 (tcam_row_18_col_0_bist_cm_match_sel1),
                         .BIST_MATCHIN_IN (tcam_row_18_col_0_bist_matchin_in),
                         .BIST_FLS (tcam_row_18_col_0_bist_fls),
                         .MDST_tcam (fuse_tcam)
                     );
        
              end
              
            else
              begin : gen_tcam_row_18_col_0_bcam
              end
              
        
        
        endgenerate
        
        always_ff @(posedge clk) begin
                   tcam_rd_data_col[18][0]      <= tcam_row_18_col_0_data_out;
                   tcam_col_hit_out[18][0]       <= tcam_row_18_col_0_hit_out;
        end
        

        // this is new template - tcam_asic_template
        
        wire                                            tcam_row_18_col_1_clk         = clk;
        
        wire    [TCAM_SLICE_EN_FACT-1:0]                tcam_row_18_col_1_slice_en = TCAM_SLICE_EN_FACT'(slice_en[(18 * TCAM_SLICE_EN_FACT)+:TCAM_SLICE_EN_MIN]);
        
        wire                                            tcam_row_18_col_1_rd_en       = tcam_row_rd_en[18];
        wire                                            tcam_row_18_col_1_wr_en       = tcam_row_wr_en[18];
        wire                                            tcam_row_18_col_1_chk_en      = chk_en;
        wire                                            tcam_row_18_col_1_reset_n = reset_n;
        wire    [7-1:0]                       tcam_row_18_col_1_adr  = tcam_row_adr[18][7-1:0];
        wire    [32-1:0]                      tcam_row_18_col_1_data_in = tcam_row_wr_en[18] ? tcam_wr_data_col[1][32-1:0] : tcam_chk_key_col[1][32-1:0];
        wire    [32-1:0]                      tcam_row_18_col_1_data_in_pre = tcam_wr_data_col[1][32-1:0] ;
        wire    [32-1:0]                      tcam_row_18_col_1_key_in =  tcam_chk_key_col[1][32-1:0];
        wire    [32-1:0]                      tcam_row_18_col_1_mask_in = tcam_chk_mask_col[1][32-1:0];
        wire    [64-1:0]                       tcam_row_18_col_1_hit_in = tcam_raw_hit_in[18];
        wire    [64-1:0]                       tcam_row_18_col_1_tcam_match_in = tcam_row_match_in[18];
        wire    [32-1:0]                      tcam_row_18_col_1_data_out_inv;
        logic   [64-1:0]                     tcam_row_18_col_1_hit_out_int;
        logic   [64-1:0]                     tcam_row_18_col_1_hit_out_latch;
        logic   [64-1:0]                     tcam_row_18_col_1_hit_out;
        
        `ifdef HIF_PCIE_DFX_DISABLE
        wire                          tcam_row_18_col_1_biste = 'b0; 
        wire     [5-1:0]                  tcam_row_18_col_1_fca = 'b0;
        wire                            tcam_row_18_col_1_cre = 'b0;
        wire                            tcam_row_18_col_1_dftshiften = 'b0;
        wire                            tcam_row_18_col_1_dftmask = 'b0;
        wire                            tcam_row_18_col_1_dft_array_freeze = 'b0;
        wire                            tcam_row_18_col_1_dft_afd_reset_b = 'b0;
        wire      [32-1:0]    tcam_row_18_col_1_tdin = 'b0;
        wire      [7-1:0]     tcam_row_18_col_1_tadr = 'b0;
        wire                            tcam_row_18_col_1_tvbe = 'b0;
        wire                            tcam_row_18_col_1_tvbi = 'b0;
        wire      [32-1:0]    tcam_row_18_col_1_tmask = 'b0;
        wire                            tcam_row_18_col_1_twe = 'b0;
        wire                            tcam_row_18_col_1_tre = 'b0;
        wire                            tcam_row_18_col_1_tme = 'b0;
        wire                            tcam_row_18_col_1_bist_rotate_sr = 'b0;
        wire                            tcam_row_18_col_1_bist_en_sr_mask_b = 'b0;
        wire                            tcam_row_18_col_1_bist_all_mask = 'b0;
        wire                            tcam_row_18_col_1_bist_en_sr_data_b = 'b0;
        wire                            tcam_row_18_col_1_bist_cm_mode = 'b0;
        wire                            tcam_row_18_col_1_bist_cm_en_in = 'b0;
        wire                            tcam_row_18_col_1_bist_cm_match_sel0 = 'b0;
        wire                            tcam_row_18_col_1_bist_cm_match_sel1 = 'b0;
        wire                            tcam_row_18_col_1_bist_matchin_in = 'b0;
        wire                            tcam_row_18_col_1_bist_fls = 'b0;
        
        `else
        wire                            tcam_row_18_col_1_biste = 'b0;
        wire     [5-1:0]                  tcam_row_18_col_1_fca = 'b0;
        wire                            tcam_row_18_col_1_cre = 'b0;
        wire                            tcam_row_18_col_1_dftshiften = dftshiften;
        wire                            tcam_row_18_col_1_dftmask = dftmask;
        wire                            tcam_row_18_col_1_dft_array_freeze = dft_array_freeze;
        wire                            tcam_row_18_col_1_dft_afd_reset_b = dft_afd_reset_b;
        wire      [32-1:0]    tcam_row_18_col_1_tdin = 'b0;
        wire      [7-1:0]     tcam_row_18_col_1_tadr = 'b0;
        wire                            tcam_row_18_col_1_tvbe = 'b0;
        wire                            tcam_row_18_col_1_tvbi = 'b0;
        wire      [32-1:0]    tcam_row_18_col_1_tmask = 'b0;
        wire                            tcam_row_18_col_1_twe = 'b0;
        wire                            tcam_row_18_col_1_tre = 'b0;
        wire                            tcam_row_18_col_1_tme = 'b0;
        wire                            tcam_row_18_col_1_bist_rotate_sr = 'b0;
        wire                            tcam_row_18_col_1_bist_en_sr_mask_b = 'b0;
        wire                            tcam_row_18_col_1_bist_all_mask = 'b0;
        wire                            tcam_row_18_col_1_bist_en_sr_data_b = 'b0;
        wire                            tcam_row_18_col_1_bist_cm_mode = 'b0;
        wire                            tcam_row_18_col_1_bist_cm_en_in = 'b0;
        wire                            tcam_row_18_col_1_bist_cm_match_sel0 = 'b0;
        wire                            tcam_row_18_col_1_bist_cm_match_sel1 = 'b0;
        wire                            tcam_row_18_col_1_bist_matchin_in = 'b0;
        wire                            tcam_row_18_col_1_bist_fls = 'b0;
        `endif
        
        // Outputs
        logic                           tcam_row_18_col_1_wr_bira_fail;
        logic                           tcam_row_18_col_1_wr_so;
        logic                           tcam_row_18_col_1_curerrout;
        logic                           tcam_row_18_col_1_rscout;
        
        
        
        logic   [TCAM_SLICE_EN_FACT-1:0]                  tcam_row_18_col_1_slice_en_s0; 
        logic   [TCAM_SLICE_EN_FACT-1:0]                  tcam_row_18_col_1_slice_en_s1; 
        
        
        
             wire    [32-1:0]                     tcam_row_18_col_1_data_out ;
        
        
        
         generate
            if (BCAM_N7 == 0) 
              begin : gen_tcam_row_18_col_1_tcam
        
        
        // slice_en kept for TCAM only for backward compatability with Intel process
                always_comb 
                begin
                  for (int i = 0; i < TCAM_SLICE_EN_FACT; i++)
                      if (tcam_row_18_col_1_slice_en_s1[i])
                           tcam_row_18_col_1_hit_out[ i*64 +: 64]  = tcam_row_18_col_1_hit_out_int  [ i*64 +: 64]; 
                      else
                           tcam_row_18_col_1_hit_out[ i*64 +: 64]  = tcam_row_18_col_1_hit_out_latch[ i*64 +: 64]; 
                end
        
        
        
                always_ff  @(posedge tcam_row_18_col_1_clk)
                begin
                  tcam_row_18_col_1_slice_en_s0 <= tcam_row_18_col_1_slice_en; 
                  tcam_row_18_col_1_slice_en_s1 <= tcam_row_18_col_1_slice_en_s0; 
        
                  for (int i = 0; i < TCAM_SLICE_EN_FACT; i++)
                    begin
                      if (tcam_row_18_col_1_slice_en_s1[i])
                         tcam_row_18_col_1_hit_out_latch[ i*64 +: 64] <=  tcam_row_18_col_1_hit_out_int[ i*64 +: 64];
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
        
                     
                         assign tcam_row_18_col_1_data_out  = ~tcam_row_18_col_1_data_out_inv;
                         pcie_itp_ip783tcam64x32s0c1_18_1_wrap #(        
                                 )               
        
                                 ip783tcam64x32s0c1_wrap_tcam_row_18_col_1 (
                   //-------------------------------------------------------------
                   // Power Management Interfaces
                   //-------------------------------------------------------------   
                      `ifndef INTEL_NO_PWR_PINS
                      `ifdef INTC_ADD_VSS
                        .vss              (1'b0),
                      `endif
                        .vddp             (1'b1),
                      `endif
                         .ADR               (tcam_row_18_col_1_adr[7-1:1]), //Input adr_intess
                         .ME                (ce),  
        
                         .CLK               (tcam_row_18_col_1_clk), //Clock
                         .CMP               (tcam_row_18_col_1_chk_en), //Control Enable
                         .DIN               (~tcam_row_18_col_1_data_in), 
                         .DSEL              (~tcam_row_18_col_1_adr[0]), //dncen enables access of the TCAM Arrays adr_intessed
                         .FLS               (flush), //flush initiates a Flush operation that resets all Valid
                         .RVLD              (tcam_row_18_col_1_hit_in ), //Row validation bus. Each match_in input controls 1
                         .MASK              (tcam_row_18_col_1_mask_in), //Input msk
                         .QOUT              (tcam_row_18_col_1_data_out_inv), //Output vben
                         .QHR               (tcam_row_18_col_1_hit_out_int),
                         .QVLD              (), 
                         .RE                (tcam_row_18_col_1_rd_en), //Read Enable
                         .RST               (tcam_row_18_col_1_reset_n), //Asynchronous Active-High Reset
                         .VBE               (1'b1), //vben enables the Valid Bit addressed by adr[a-1:0] to
                         .VBI               (1'b0),//  Valid Bit Input
                         .WE                (tcam_row_18_col_1_wr_en), //Write Enable
                         .FAF               (tcam_row_18_col_1_fca),
                         .FAF_EN            (tcam_row_18_col_1_cre),
                         .DFTSHIFTEN        (tcam_row_18_col_1_dftshiften),
                         .DFTMASK           (tcam_row_18_col_1_dftmask),
                         .DFT_ARRAY_FREEZE  (tcam_row_18_col_1_dft_array_freeze),
                         .DFT_AFD_RESET_B   (tcam_row_18_col_1_dft_afd_reset_b),
                         .BISTE           (tcam_row_18_col_1_biste),
                         .TDIN (tcam_row_18_col_1_tdin),
                         .TADR (tcam_row_18_col_1_tadr),
                         .TVBE (tcam_row_18_col_1_tvbe),
                         .TVBI (tcam_row_18_col_1_tvbi),
                         .TMASK (tcam_row_18_col_1_tmask),
                         .TWE (tcam_row_18_col_1_twe),
                         .TRE (tcam_row_18_col_1_tre),
                         .TME (tcam_row_18_col_1_tme),
                         .BIST_ROTATE_SR (tcam_row_18_col_1_bist_rotate_sr),
                         .BIST_EN_SR_MASK_B (tcam_row_18_col_1_bist_en_sr_mask_b),
                         .BIST_ALL_MASK (tcam_row_18_col_1_bist_all_mask),
                         .BIST_EN_SR_DATA_B (tcam_row_18_col_1_bist_en_sr_data_b),
                         .BIST_CM_MODE (tcam_row_18_col_1_bist_cm_mode),
                         .BIST_CM_EN_IN (tcam_row_18_col_1_bist_cm_en_in),
                         .BIST_CM_MATCH_SEL0 (tcam_row_18_col_1_bist_cm_match_sel0),
                         .BIST_CM_MATCH_SEL1 (tcam_row_18_col_1_bist_cm_match_sel1),
                         .BIST_MATCHIN_IN (tcam_row_18_col_1_bist_matchin_in),
                         .BIST_FLS (tcam_row_18_col_1_bist_fls),
                         .MDST_tcam (fuse_tcam)
                     );
        
              end
              
            else
              begin : gen_tcam_row_18_col_1_bcam
              end
              
        
        
        endgenerate
        
        always_ff @(posedge clk) begin
                   tcam_rd_data_col[18][1]      <= tcam_row_18_col_1_data_out;
                   tcam_col_hit_out[18][1]       <= tcam_row_18_col_1_hit_out;
        end
        

    assign    tcam_rd_valid      = rd_en_delay[TCAM_RD_DELAY];
    assign    tcam_wr_ack      = wr_en_delay[TCAM_WR_DELAY];
    assign    tcam_chk_valid      = chk_en_delay[TCAM_CHK_DELAY];
    assign    tcam_rdwr_rdy      = rd_en_nope_done && wr_en_nope_done;
    assign    tcam_chk_rdy      = chk_en_nope_done && !wr_en && !rd_en;
// DFX output concatination 

                 
         
        `ifdef INTEL_SIMONLY
           `ifndef HIF_PCIE_FEV_APPROVE_SIM_ONLY
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
                                    if ($test$plusargs("HIF_PCIE_FAST_CONFIG")) begin
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
                                    if ($test$plusargs("HIF_PCIE_FAST_CONFIG")) begin
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
                for (int i = 0; i < 2; i = i + 1) begin
                    rd_data[PHYSICAL_ROW_WIDTH-((2-i-1)*2)-2] = ^rd_data_before_prot_calc[(i*(32-2))+:((32-2)/2)];
                    rd_data[PHYSICAL_ROW_WIDTH-((2-i-1)*2)-1] = ^rd_data_before_prot_calc[(i*(32-2))+((32-2)/2)+:((32-2)/2)];
                end
            end
        end
    else
        begin : tcam_no_prot_calc
            assign rd_data = rd_data_before_prot_calc;
        end
endgenerate

   `ifdef HIF_PCIE_TCAM_FPGA_MEMS



       hif_pcie_mgm_fpga_tcam #(
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
    
        //`ifndef HIF_PCIE_FPGA_TCAM_MEMS_TCAM_BEHAVE_EN
                assign raw_hit_out              = raw_hit_out_fpga;  
                assign rd_data_before_prot_calc = rd_data_before_prot_calc_fpga;  

        //`endif

    `endif
    `ifdef HIF_PCIE_TCAM_BEHAVE_FPGA_MEMS
        hif_pcie_mgm_tcam_behave #(
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


        `ifndef HIF_PCIE_TCAM_FPGA_MEMS
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
         `ifndef HIF_PCIE_FEV_APPROVE_SIM_ONLY
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
                                    
                                     `ifndef HIF_PCIE_FPGA_TCAM_MEMS
                                        always @(posedge reset_n)
                                                if ($test$plusargs("HIF_PCIE_FAST_CONFIG")) begin
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

parameter       MEM_SEG_PADDING_W = 4 ; 
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
        
       task automatic update_col_sweeper(input bit pattern, input logic[60-1:0] old_val, input logic[60-1:0] new_val);
           logic [60-1:0] temp;
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
       task automatic update_col_sweeper(input bit pattern, input logic[60-1:0] old_val, input logic[60-1:0] new_val);
       endtask // END update_col_sweeper
    end
    endgenerate
    
    // ********** backdoor MASK ***********
    // ********** this task is valid for TCAM only *****
      task automatic write_tcam_raw_key (input logic[60-1:0] key, input int row_idx);
          reg temp1,temp2;
          logic [(2 * 32) - 1:0] local_key = '1;
          logic [(2 * 32) - 1:0] prev_key_data;
          local_key[60-1:0] = TCAM_18A ? ~key : ~key;
         
          // check size out-of-bounds
          if (row_idx >= TCAM_RULES_NUM) begin
             $error("Cannot write key to idx ", row_idx, ". It exceeds logical value depth ", TCAM_RULES_NUM);
             return;         
          end
          // a. read previous data, for sweepeing purposes
          read_tcam_raw_key(prev_key_data, row_idx);
          // b. write the new key to TCAM
          `ifdef HIF_PCIE_PCIE_ITP_TCAM_BEHAVE_MEMS
             `ifndef HIF_PCIE_FPGA_TCAM_MEMS
                  behave_tcam.state[2*row_idx] = key;
             `endif
           `else
              case (row_idx/64)
         0 :begin
         for (int j = 0;j < 2 ; j = j + 1) 
             case (j)
                                    0: begin
                                            //write_mask
                                             gen_tcam_row_0_col_0_tcam.ip783tcam64x32s0c1_wrap_tcam_row_0_col_0.tcam_row_0_col_0.ip783tcam64x32s0c1_gen_wrp_inst.ip783tcam64x32s0c1_inst.ip783tcam64x32s0c1_array.array_x[row_idx % 64] = local_key[0*(32 -2*BCAM_N7) +: 32-2*BCAM_N7];
                                             gen_tcam_row_0_col_0_tcam.ip783tcam64x32s0c1_wrap_tcam_row_0_col_0.tcam_row_0_col_0.ip783tcam64x32s0c1_gen_wrp_inst.ip783tcam64x32s0c1_inst.ip783tcam64x32s0c1_array.array_v[row_idx % 64] = 1'b1;
                                    end
                                    1: begin
                                            //write_mask
                                             gen_tcam_row_0_col_1_tcam.ip783tcam64x32s0c1_wrap_tcam_row_0_col_1.tcam_row_0_col_1.ip783tcam64x32s0c1_gen_wrp_inst.ip783tcam64x32s0c1_inst.ip783tcam64x32s0c1_array.array_x[row_idx % 64] = local_key[1*(32 -2*BCAM_N7) +: 32-2*BCAM_N7];
                                             gen_tcam_row_0_col_1_tcam.ip783tcam64x32s0c1_wrap_tcam_row_0_col_1.tcam_row_0_col_1.ip783tcam64x32s0c1_gen_wrp_inst.ip783tcam64x32s0c1_inst.ip783tcam64x32s0c1_array.array_v[row_idx % 64] = 1'b1;
                                    end
                                    default : begin
                                       $error("SOMTING IS wrong with parameters given for col number %d ",j);
                                     end
              endcase
                      
        end // 0 
         1 :begin
         for (int j = 0;j < 2 ; j = j + 1) 
             case (j)
                                    0: begin
                                            //write_mask
                                             gen_tcam_row_1_col_0_tcam.ip783tcam64x32s0c1_wrap_tcam_row_1_col_0.tcam_row_1_col_0.ip783tcam64x32s0c1_gen_wrp_inst.ip783tcam64x32s0c1_inst.ip783tcam64x32s0c1_array.array_x[row_idx % 64] = local_key[0*(32 -2*BCAM_N7) +: 32-2*BCAM_N7];
                                             gen_tcam_row_1_col_0_tcam.ip783tcam64x32s0c1_wrap_tcam_row_1_col_0.tcam_row_1_col_0.ip783tcam64x32s0c1_gen_wrp_inst.ip783tcam64x32s0c1_inst.ip783tcam64x32s0c1_array.array_v[row_idx % 64] = 1'b1;
                                    end
                                    1: begin
                                            //write_mask
                                             gen_tcam_row_1_col_1_tcam.ip783tcam64x32s0c1_wrap_tcam_row_1_col_1.tcam_row_1_col_1.ip783tcam64x32s0c1_gen_wrp_inst.ip783tcam64x32s0c1_inst.ip783tcam64x32s0c1_array.array_x[row_idx % 64] = local_key[1*(32 -2*BCAM_N7) +: 32-2*BCAM_N7];
                                             gen_tcam_row_1_col_1_tcam.ip783tcam64x32s0c1_wrap_tcam_row_1_col_1.tcam_row_1_col_1.ip783tcam64x32s0c1_gen_wrp_inst.ip783tcam64x32s0c1_inst.ip783tcam64x32s0c1_array.array_v[row_idx % 64] = 1'b1;
                                    end
                                    default : begin
                                       $error("SOMTING IS wrong with parameters given for col number %d ",j);
                                     end
              endcase
                      
        end // 1 
         2 :begin
         for (int j = 0;j < 2 ; j = j + 1) 
             case (j)
                                    0: begin
                                            //write_mask
                                             gen_tcam_row_2_col_0_tcam.ip783tcam64x32s0c1_wrap_tcam_row_2_col_0.tcam_row_2_col_0.ip783tcam64x32s0c1_gen_wrp_inst.ip783tcam64x32s0c1_inst.ip783tcam64x32s0c1_array.array_x[row_idx % 64] = local_key[0*(32 -2*BCAM_N7) +: 32-2*BCAM_N7];
                                             gen_tcam_row_2_col_0_tcam.ip783tcam64x32s0c1_wrap_tcam_row_2_col_0.tcam_row_2_col_0.ip783tcam64x32s0c1_gen_wrp_inst.ip783tcam64x32s0c1_inst.ip783tcam64x32s0c1_array.array_v[row_idx % 64] = 1'b1;
                                    end
                                    1: begin
                                            //write_mask
                                             gen_tcam_row_2_col_1_tcam.ip783tcam64x32s0c1_wrap_tcam_row_2_col_1.tcam_row_2_col_1.ip783tcam64x32s0c1_gen_wrp_inst.ip783tcam64x32s0c1_inst.ip783tcam64x32s0c1_array.array_x[row_idx % 64] = local_key[1*(32 -2*BCAM_N7) +: 32-2*BCAM_N7];
                                             gen_tcam_row_2_col_1_tcam.ip783tcam64x32s0c1_wrap_tcam_row_2_col_1.tcam_row_2_col_1.ip783tcam64x32s0c1_gen_wrp_inst.ip783tcam64x32s0c1_inst.ip783tcam64x32s0c1_array.array_v[row_idx % 64] = 1'b1;
                                    end
                                    default : begin
                                       $error("SOMTING IS wrong with parameters given for col number %d ",j);
                                     end
              endcase
                      
        end // 2 
         3 :begin
         for (int j = 0;j < 2 ; j = j + 1) 
             case (j)
                                    0: begin
                                            //write_mask
                                             gen_tcam_row_3_col_0_tcam.ip783tcam64x32s0c1_wrap_tcam_row_3_col_0.tcam_row_3_col_0.ip783tcam64x32s0c1_gen_wrp_inst.ip783tcam64x32s0c1_inst.ip783tcam64x32s0c1_array.array_x[row_idx % 64] = local_key[0*(32 -2*BCAM_N7) +: 32-2*BCAM_N7];
                                             gen_tcam_row_3_col_0_tcam.ip783tcam64x32s0c1_wrap_tcam_row_3_col_0.tcam_row_3_col_0.ip783tcam64x32s0c1_gen_wrp_inst.ip783tcam64x32s0c1_inst.ip783tcam64x32s0c1_array.array_v[row_idx % 64] = 1'b1;
                                    end
                                    1: begin
                                            //write_mask
                                             gen_tcam_row_3_col_1_tcam.ip783tcam64x32s0c1_wrap_tcam_row_3_col_1.tcam_row_3_col_1.ip783tcam64x32s0c1_gen_wrp_inst.ip783tcam64x32s0c1_inst.ip783tcam64x32s0c1_array.array_x[row_idx % 64] = local_key[1*(32 -2*BCAM_N7) +: 32-2*BCAM_N7];
                                             gen_tcam_row_3_col_1_tcam.ip783tcam64x32s0c1_wrap_tcam_row_3_col_1.tcam_row_3_col_1.ip783tcam64x32s0c1_gen_wrp_inst.ip783tcam64x32s0c1_inst.ip783tcam64x32s0c1_array.array_v[row_idx % 64] = 1'b1;
                                    end
                                    default : begin
                                       $error("SOMTING IS wrong with parameters given for col number %d ",j);
                                     end
              endcase
                      
        end // 3 
         4 :begin
         for (int j = 0;j < 2 ; j = j + 1) 
             case (j)
                                    0: begin
                                            //write_mask
                                             gen_tcam_row_4_col_0_tcam.ip783tcam64x32s0c1_wrap_tcam_row_4_col_0.tcam_row_4_col_0.ip783tcam64x32s0c1_gen_wrp_inst.ip783tcam64x32s0c1_inst.ip783tcam64x32s0c1_array.array_x[row_idx % 64] = local_key[0*(32 -2*BCAM_N7) +: 32-2*BCAM_N7];
                                             gen_tcam_row_4_col_0_tcam.ip783tcam64x32s0c1_wrap_tcam_row_4_col_0.tcam_row_4_col_0.ip783tcam64x32s0c1_gen_wrp_inst.ip783tcam64x32s0c1_inst.ip783tcam64x32s0c1_array.array_v[row_idx % 64] = 1'b1;
                                    end
                                    1: begin
                                            //write_mask
                                             gen_tcam_row_4_col_1_tcam.ip783tcam64x32s0c1_wrap_tcam_row_4_col_1.tcam_row_4_col_1.ip783tcam64x32s0c1_gen_wrp_inst.ip783tcam64x32s0c1_inst.ip783tcam64x32s0c1_array.array_x[row_idx % 64] = local_key[1*(32 -2*BCAM_N7) +: 32-2*BCAM_N7];
                                             gen_tcam_row_4_col_1_tcam.ip783tcam64x32s0c1_wrap_tcam_row_4_col_1.tcam_row_4_col_1.ip783tcam64x32s0c1_gen_wrp_inst.ip783tcam64x32s0c1_inst.ip783tcam64x32s0c1_array.array_v[row_idx % 64] = 1'b1;
                                    end
                                    default : begin
                                       $error("SOMTING IS wrong with parameters given for col number %d ",j);
                                     end
              endcase
                      
        end // 4 
         5 :begin
         for (int j = 0;j < 2 ; j = j + 1) 
             case (j)
                                    0: begin
                                            //write_mask
                                             gen_tcam_row_5_col_0_tcam.ip783tcam64x32s0c1_wrap_tcam_row_5_col_0.tcam_row_5_col_0.ip783tcam64x32s0c1_gen_wrp_inst.ip783tcam64x32s0c1_inst.ip783tcam64x32s0c1_array.array_x[row_idx % 64] = local_key[0*(32 -2*BCAM_N7) +: 32-2*BCAM_N7];
                                             gen_tcam_row_5_col_0_tcam.ip783tcam64x32s0c1_wrap_tcam_row_5_col_0.tcam_row_5_col_0.ip783tcam64x32s0c1_gen_wrp_inst.ip783tcam64x32s0c1_inst.ip783tcam64x32s0c1_array.array_v[row_idx % 64] = 1'b1;
                                    end
                                    1: begin
                                            //write_mask
                                             gen_tcam_row_5_col_1_tcam.ip783tcam64x32s0c1_wrap_tcam_row_5_col_1.tcam_row_5_col_1.ip783tcam64x32s0c1_gen_wrp_inst.ip783tcam64x32s0c1_inst.ip783tcam64x32s0c1_array.array_x[row_idx % 64] = local_key[1*(32 -2*BCAM_N7) +: 32-2*BCAM_N7];
                                             gen_tcam_row_5_col_1_tcam.ip783tcam64x32s0c1_wrap_tcam_row_5_col_1.tcam_row_5_col_1.ip783tcam64x32s0c1_gen_wrp_inst.ip783tcam64x32s0c1_inst.ip783tcam64x32s0c1_array.array_v[row_idx % 64] = 1'b1;
                                    end
                                    default : begin
                                       $error("SOMTING IS wrong with parameters given for col number %d ",j);
                                     end
              endcase
                      
        end // 5 
         6 :begin
         for (int j = 0;j < 2 ; j = j + 1) 
             case (j)
                                    0: begin
                                            //write_mask
                                             gen_tcam_row_6_col_0_tcam.ip783tcam64x32s0c1_wrap_tcam_row_6_col_0.tcam_row_6_col_0.ip783tcam64x32s0c1_gen_wrp_inst.ip783tcam64x32s0c1_inst.ip783tcam64x32s0c1_array.array_x[row_idx % 64] = local_key[0*(32 -2*BCAM_N7) +: 32-2*BCAM_N7];
                                             gen_tcam_row_6_col_0_tcam.ip783tcam64x32s0c1_wrap_tcam_row_6_col_0.tcam_row_6_col_0.ip783tcam64x32s0c1_gen_wrp_inst.ip783tcam64x32s0c1_inst.ip783tcam64x32s0c1_array.array_v[row_idx % 64] = 1'b1;
                                    end
                                    1: begin
                                            //write_mask
                                             gen_tcam_row_6_col_1_tcam.ip783tcam64x32s0c1_wrap_tcam_row_6_col_1.tcam_row_6_col_1.ip783tcam64x32s0c1_gen_wrp_inst.ip783tcam64x32s0c1_inst.ip783tcam64x32s0c1_array.array_x[row_idx % 64] = local_key[1*(32 -2*BCAM_N7) +: 32-2*BCAM_N7];
                                             gen_tcam_row_6_col_1_tcam.ip783tcam64x32s0c1_wrap_tcam_row_6_col_1.tcam_row_6_col_1.ip783tcam64x32s0c1_gen_wrp_inst.ip783tcam64x32s0c1_inst.ip783tcam64x32s0c1_array.array_v[row_idx % 64] = 1'b1;
                                    end
                                    default : begin
                                       $error("SOMTING IS wrong with parameters given for col number %d ",j);
                                     end
              endcase
                      
        end // 6 
         7 :begin
         for (int j = 0;j < 2 ; j = j + 1) 
             case (j)
                                    0: begin
                                            //write_mask
                                             gen_tcam_row_7_col_0_tcam.ip783tcam64x32s0c1_wrap_tcam_row_7_col_0.tcam_row_7_col_0.ip783tcam64x32s0c1_gen_wrp_inst.ip783tcam64x32s0c1_inst.ip783tcam64x32s0c1_array.array_x[row_idx % 64] = local_key[0*(32 -2*BCAM_N7) +: 32-2*BCAM_N7];
                                             gen_tcam_row_7_col_0_tcam.ip783tcam64x32s0c1_wrap_tcam_row_7_col_0.tcam_row_7_col_0.ip783tcam64x32s0c1_gen_wrp_inst.ip783tcam64x32s0c1_inst.ip783tcam64x32s0c1_array.array_v[row_idx % 64] = 1'b1;
                                    end
                                    1: begin
                                            //write_mask
                                             gen_tcam_row_7_col_1_tcam.ip783tcam64x32s0c1_wrap_tcam_row_7_col_1.tcam_row_7_col_1.ip783tcam64x32s0c1_gen_wrp_inst.ip783tcam64x32s0c1_inst.ip783tcam64x32s0c1_array.array_x[row_idx % 64] = local_key[1*(32 -2*BCAM_N7) +: 32-2*BCAM_N7];
                                             gen_tcam_row_7_col_1_tcam.ip783tcam64x32s0c1_wrap_tcam_row_7_col_1.tcam_row_7_col_1.ip783tcam64x32s0c1_gen_wrp_inst.ip783tcam64x32s0c1_inst.ip783tcam64x32s0c1_array.array_v[row_idx % 64] = 1'b1;
                                    end
                                    default : begin
                                       $error("SOMTING IS wrong with parameters given for col number %d ",j);
                                     end
              endcase
                      
        end // 7 
         8 :begin
         for (int j = 0;j < 2 ; j = j + 1) 
             case (j)
                                    0: begin
                                            //write_mask
                                             gen_tcam_row_8_col_0_tcam.ip783tcam64x32s0c1_wrap_tcam_row_8_col_0.tcam_row_8_col_0.ip783tcam64x32s0c1_gen_wrp_inst.ip783tcam64x32s0c1_inst.ip783tcam64x32s0c1_array.array_x[row_idx % 64] = local_key[0*(32 -2*BCAM_N7) +: 32-2*BCAM_N7];
                                             gen_tcam_row_8_col_0_tcam.ip783tcam64x32s0c1_wrap_tcam_row_8_col_0.tcam_row_8_col_0.ip783tcam64x32s0c1_gen_wrp_inst.ip783tcam64x32s0c1_inst.ip783tcam64x32s0c1_array.array_v[row_idx % 64] = 1'b1;
                                    end
                                    1: begin
                                            //write_mask
                                             gen_tcam_row_8_col_1_tcam.ip783tcam64x32s0c1_wrap_tcam_row_8_col_1.tcam_row_8_col_1.ip783tcam64x32s0c1_gen_wrp_inst.ip783tcam64x32s0c1_inst.ip783tcam64x32s0c1_array.array_x[row_idx % 64] = local_key[1*(32 -2*BCAM_N7) +: 32-2*BCAM_N7];
                                             gen_tcam_row_8_col_1_tcam.ip783tcam64x32s0c1_wrap_tcam_row_8_col_1.tcam_row_8_col_1.ip783tcam64x32s0c1_gen_wrp_inst.ip783tcam64x32s0c1_inst.ip783tcam64x32s0c1_array.array_v[row_idx % 64] = 1'b1;
                                    end
                                    default : begin
                                       $error("SOMTING IS wrong with parameters given for col number %d ",j);
                                     end
              endcase
                      
        end // 8 
         9 :begin
         for (int j = 0;j < 2 ; j = j + 1) 
             case (j)
                                    0: begin
                                            //write_mask
                                             gen_tcam_row_9_col_0_tcam.ip783tcam64x32s0c1_wrap_tcam_row_9_col_0.tcam_row_9_col_0.ip783tcam64x32s0c1_gen_wrp_inst.ip783tcam64x32s0c1_inst.ip783tcam64x32s0c1_array.array_x[row_idx % 64] = local_key[0*(32 -2*BCAM_N7) +: 32-2*BCAM_N7];
                                             gen_tcam_row_9_col_0_tcam.ip783tcam64x32s0c1_wrap_tcam_row_9_col_0.tcam_row_9_col_0.ip783tcam64x32s0c1_gen_wrp_inst.ip783tcam64x32s0c1_inst.ip783tcam64x32s0c1_array.array_v[row_idx % 64] = 1'b1;
                                    end
                                    1: begin
                                            //write_mask
                                             gen_tcam_row_9_col_1_tcam.ip783tcam64x32s0c1_wrap_tcam_row_9_col_1.tcam_row_9_col_1.ip783tcam64x32s0c1_gen_wrp_inst.ip783tcam64x32s0c1_inst.ip783tcam64x32s0c1_array.array_x[row_idx % 64] = local_key[1*(32 -2*BCAM_N7) +: 32-2*BCAM_N7];
                                             gen_tcam_row_9_col_1_tcam.ip783tcam64x32s0c1_wrap_tcam_row_9_col_1.tcam_row_9_col_1.ip783tcam64x32s0c1_gen_wrp_inst.ip783tcam64x32s0c1_inst.ip783tcam64x32s0c1_array.array_v[row_idx % 64] = 1'b1;
                                    end
                                    default : begin
                                       $error("SOMTING IS wrong with parameters given for col number %d ",j);
                                     end
              endcase
                      
        end // 9 
         10 :begin
         for (int j = 0;j < 2 ; j = j + 1) 
             case (j)
                                    0: begin
                                            //write_mask
                                             gen_tcam_row_10_col_0_tcam.ip783tcam64x32s0c1_wrap_tcam_row_10_col_0.tcam_row_10_col_0.ip783tcam64x32s0c1_gen_wrp_inst.ip783tcam64x32s0c1_inst.ip783tcam64x32s0c1_array.array_x[row_idx % 64] = local_key[0*(32 -2*BCAM_N7) +: 32-2*BCAM_N7];
                                             gen_tcam_row_10_col_0_tcam.ip783tcam64x32s0c1_wrap_tcam_row_10_col_0.tcam_row_10_col_0.ip783tcam64x32s0c1_gen_wrp_inst.ip783tcam64x32s0c1_inst.ip783tcam64x32s0c1_array.array_v[row_idx % 64] = 1'b1;
                                    end
                                    1: begin
                                            //write_mask
                                             gen_tcam_row_10_col_1_tcam.ip783tcam64x32s0c1_wrap_tcam_row_10_col_1.tcam_row_10_col_1.ip783tcam64x32s0c1_gen_wrp_inst.ip783tcam64x32s0c1_inst.ip783tcam64x32s0c1_array.array_x[row_idx % 64] = local_key[1*(32 -2*BCAM_N7) +: 32-2*BCAM_N7];
                                             gen_tcam_row_10_col_1_tcam.ip783tcam64x32s0c1_wrap_tcam_row_10_col_1.tcam_row_10_col_1.ip783tcam64x32s0c1_gen_wrp_inst.ip783tcam64x32s0c1_inst.ip783tcam64x32s0c1_array.array_v[row_idx % 64] = 1'b1;
                                    end
                                    default : begin
                                       $error("SOMTING IS wrong with parameters given for col number %d ",j);
                                     end
              endcase
                      
        end // 10 
         11 :begin
         for (int j = 0;j < 2 ; j = j + 1) 
             case (j)
                                    0: begin
                                            //write_mask
                                             gen_tcam_row_11_col_0_tcam.ip783tcam64x32s0c1_wrap_tcam_row_11_col_0.tcam_row_11_col_0.ip783tcam64x32s0c1_gen_wrp_inst.ip783tcam64x32s0c1_inst.ip783tcam64x32s0c1_array.array_x[row_idx % 64] = local_key[0*(32 -2*BCAM_N7) +: 32-2*BCAM_N7];
                                             gen_tcam_row_11_col_0_tcam.ip783tcam64x32s0c1_wrap_tcam_row_11_col_0.tcam_row_11_col_0.ip783tcam64x32s0c1_gen_wrp_inst.ip783tcam64x32s0c1_inst.ip783tcam64x32s0c1_array.array_v[row_idx % 64] = 1'b1;
                                    end
                                    1: begin
                                            //write_mask
                                             gen_tcam_row_11_col_1_tcam.ip783tcam64x32s0c1_wrap_tcam_row_11_col_1.tcam_row_11_col_1.ip783tcam64x32s0c1_gen_wrp_inst.ip783tcam64x32s0c1_inst.ip783tcam64x32s0c1_array.array_x[row_idx % 64] = local_key[1*(32 -2*BCAM_N7) +: 32-2*BCAM_N7];
                                             gen_tcam_row_11_col_1_tcam.ip783tcam64x32s0c1_wrap_tcam_row_11_col_1.tcam_row_11_col_1.ip783tcam64x32s0c1_gen_wrp_inst.ip783tcam64x32s0c1_inst.ip783tcam64x32s0c1_array.array_v[row_idx % 64] = 1'b1;
                                    end
                                    default : begin
                                       $error("SOMTING IS wrong with parameters given for col number %d ",j);
                                     end
              endcase
                      
        end // 11 
         12 :begin
         for (int j = 0;j < 2 ; j = j + 1) 
             case (j)
                                    0: begin
                                            //write_mask
                                             gen_tcam_row_12_col_0_tcam.ip783tcam64x32s0c1_wrap_tcam_row_12_col_0.tcam_row_12_col_0.ip783tcam64x32s0c1_gen_wrp_inst.ip783tcam64x32s0c1_inst.ip783tcam64x32s0c1_array.array_x[row_idx % 64] = local_key[0*(32 -2*BCAM_N7) +: 32-2*BCAM_N7];
                                             gen_tcam_row_12_col_0_tcam.ip783tcam64x32s0c1_wrap_tcam_row_12_col_0.tcam_row_12_col_0.ip783tcam64x32s0c1_gen_wrp_inst.ip783tcam64x32s0c1_inst.ip783tcam64x32s0c1_array.array_v[row_idx % 64] = 1'b1;
                                    end
                                    1: begin
                                            //write_mask
                                             gen_tcam_row_12_col_1_tcam.ip783tcam64x32s0c1_wrap_tcam_row_12_col_1.tcam_row_12_col_1.ip783tcam64x32s0c1_gen_wrp_inst.ip783tcam64x32s0c1_inst.ip783tcam64x32s0c1_array.array_x[row_idx % 64] = local_key[1*(32 -2*BCAM_N7) +: 32-2*BCAM_N7];
                                             gen_tcam_row_12_col_1_tcam.ip783tcam64x32s0c1_wrap_tcam_row_12_col_1.tcam_row_12_col_1.ip783tcam64x32s0c1_gen_wrp_inst.ip783tcam64x32s0c1_inst.ip783tcam64x32s0c1_array.array_v[row_idx % 64] = 1'b1;
                                    end
                                    default : begin
                                       $error("SOMTING IS wrong with parameters given for col number %d ",j);
                                     end
              endcase
                      
        end // 12 
         13 :begin
         for (int j = 0;j < 2 ; j = j + 1) 
             case (j)
                                    0: begin
                                            //write_mask
                                             gen_tcam_row_13_col_0_tcam.ip783tcam64x32s0c1_wrap_tcam_row_13_col_0.tcam_row_13_col_0.ip783tcam64x32s0c1_gen_wrp_inst.ip783tcam64x32s0c1_inst.ip783tcam64x32s0c1_array.array_x[row_idx % 64] = local_key[0*(32 -2*BCAM_N7) +: 32-2*BCAM_N7];
                                             gen_tcam_row_13_col_0_tcam.ip783tcam64x32s0c1_wrap_tcam_row_13_col_0.tcam_row_13_col_0.ip783tcam64x32s0c1_gen_wrp_inst.ip783tcam64x32s0c1_inst.ip783tcam64x32s0c1_array.array_v[row_idx % 64] = 1'b1;
                                    end
                                    1: begin
                                            //write_mask
                                             gen_tcam_row_13_col_1_tcam.ip783tcam64x32s0c1_wrap_tcam_row_13_col_1.tcam_row_13_col_1.ip783tcam64x32s0c1_gen_wrp_inst.ip783tcam64x32s0c1_inst.ip783tcam64x32s0c1_array.array_x[row_idx % 64] = local_key[1*(32 -2*BCAM_N7) +: 32-2*BCAM_N7];
                                             gen_tcam_row_13_col_1_tcam.ip783tcam64x32s0c1_wrap_tcam_row_13_col_1.tcam_row_13_col_1.ip783tcam64x32s0c1_gen_wrp_inst.ip783tcam64x32s0c1_inst.ip783tcam64x32s0c1_array.array_v[row_idx % 64] = 1'b1;
                                    end
                                    default : begin
                                       $error("SOMTING IS wrong with parameters given for col number %d ",j);
                                     end
              endcase
                      
        end // 13 
         14 :begin
         for (int j = 0;j < 2 ; j = j + 1) 
             case (j)
                                    0: begin
                                            //write_mask
                                             gen_tcam_row_14_col_0_tcam.ip783tcam64x32s0c1_wrap_tcam_row_14_col_0.tcam_row_14_col_0.ip783tcam64x32s0c1_gen_wrp_inst.ip783tcam64x32s0c1_inst.ip783tcam64x32s0c1_array.array_x[row_idx % 64] = local_key[0*(32 -2*BCAM_N7) +: 32-2*BCAM_N7];
                                             gen_tcam_row_14_col_0_tcam.ip783tcam64x32s0c1_wrap_tcam_row_14_col_0.tcam_row_14_col_0.ip783tcam64x32s0c1_gen_wrp_inst.ip783tcam64x32s0c1_inst.ip783tcam64x32s0c1_array.array_v[row_idx % 64] = 1'b1;
                                    end
                                    1: begin
                                            //write_mask
                                             gen_tcam_row_14_col_1_tcam.ip783tcam64x32s0c1_wrap_tcam_row_14_col_1.tcam_row_14_col_1.ip783tcam64x32s0c1_gen_wrp_inst.ip783tcam64x32s0c1_inst.ip783tcam64x32s0c1_array.array_x[row_idx % 64] = local_key[1*(32 -2*BCAM_N7) +: 32-2*BCAM_N7];
                                             gen_tcam_row_14_col_1_tcam.ip783tcam64x32s0c1_wrap_tcam_row_14_col_1.tcam_row_14_col_1.ip783tcam64x32s0c1_gen_wrp_inst.ip783tcam64x32s0c1_inst.ip783tcam64x32s0c1_array.array_v[row_idx % 64] = 1'b1;
                                    end
                                    default : begin
                                       $error("SOMTING IS wrong with parameters given for col number %d ",j);
                                     end
              endcase
                      
        end // 14 
         15 :begin
         for (int j = 0;j < 2 ; j = j + 1) 
             case (j)
                                    0: begin
                                            //write_mask
                                             gen_tcam_row_15_col_0_tcam.ip783tcam64x32s0c1_wrap_tcam_row_15_col_0.tcam_row_15_col_0.ip783tcam64x32s0c1_gen_wrp_inst.ip783tcam64x32s0c1_inst.ip783tcam64x32s0c1_array.array_x[row_idx % 64] = local_key[0*(32 -2*BCAM_N7) +: 32-2*BCAM_N7];
                                             gen_tcam_row_15_col_0_tcam.ip783tcam64x32s0c1_wrap_tcam_row_15_col_0.tcam_row_15_col_0.ip783tcam64x32s0c1_gen_wrp_inst.ip783tcam64x32s0c1_inst.ip783tcam64x32s0c1_array.array_v[row_idx % 64] = 1'b1;
                                    end
                                    1: begin
                                            //write_mask
                                             gen_tcam_row_15_col_1_tcam.ip783tcam64x32s0c1_wrap_tcam_row_15_col_1.tcam_row_15_col_1.ip783tcam64x32s0c1_gen_wrp_inst.ip783tcam64x32s0c1_inst.ip783tcam64x32s0c1_array.array_x[row_idx % 64] = local_key[1*(32 -2*BCAM_N7) +: 32-2*BCAM_N7];
                                             gen_tcam_row_15_col_1_tcam.ip783tcam64x32s0c1_wrap_tcam_row_15_col_1.tcam_row_15_col_1.ip783tcam64x32s0c1_gen_wrp_inst.ip783tcam64x32s0c1_inst.ip783tcam64x32s0c1_array.array_v[row_idx % 64] = 1'b1;
                                    end
                                    default : begin
                                       $error("SOMTING IS wrong with parameters given for col number %d ",j);
                                     end
              endcase
                      
        end // 15 
         16 :begin
         for (int j = 0;j < 2 ; j = j + 1) 
             case (j)
                                    0: begin
                                            //write_mask
                                             gen_tcam_row_16_col_0_tcam.ip783tcam64x32s0c1_wrap_tcam_row_16_col_0.tcam_row_16_col_0.ip783tcam64x32s0c1_gen_wrp_inst.ip783tcam64x32s0c1_inst.ip783tcam64x32s0c1_array.array_x[row_idx % 64] = local_key[0*(32 -2*BCAM_N7) +: 32-2*BCAM_N7];
                                             gen_tcam_row_16_col_0_tcam.ip783tcam64x32s0c1_wrap_tcam_row_16_col_0.tcam_row_16_col_0.ip783tcam64x32s0c1_gen_wrp_inst.ip783tcam64x32s0c1_inst.ip783tcam64x32s0c1_array.array_v[row_idx % 64] = 1'b1;
                                    end
                                    1: begin
                                            //write_mask
                                             gen_tcam_row_16_col_1_tcam.ip783tcam64x32s0c1_wrap_tcam_row_16_col_1.tcam_row_16_col_1.ip783tcam64x32s0c1_gen_wrp_inst.ip783tcam64x32s0c1_inst.ip783tcam64x32s0c1_array.array_x[row_idx % 64] = local_key[1*(32 -2*BCAM_N7) +: 32-2*BCAM_N7];
                                             gen_tcam_row_16_col_1_tcam.ip783tcam64x32s0c1_wrap_tcam_row_16_col_1.tcam_row_16_col_1.ip783tcam64x32s0c1_gen_wrp_inst.ip783tcam64x32s0c1_inst.ip783tcam64x32s0c1_array.array_v[row_idx % 64] = 1'b1;
                                    end
                                    default : begin
                                       $error("SOMTING IS wrong with parameters given for col number %d ",j);
                                     end
              endcase
                      
        end // 16 
         17 :begin
         for (int j = 0;j < 2 ; j = j + 1) 
             case (j)
                                    0: begin
                                            //write_mask
                                             gen_tcam_row_17_col_0_tcam.ip783tcam64x32s0c1_wrap_tcam_row_17_col_0.tcam_row_17_col_0.ip783tcam64x32s0c1_gen_wrp_inst.ip783tcam64x32s0c1_inst.ip783tcam64x32s0c1_array.array_x[row_idx % 64] = local_key[0*(32 -2*BCAM_N7) +: 32-2*BCAM_N7];
                                             gen_tcam_row_17_col_0_tcam.ip783tcam64x32s0c1_wrap_tcam_row_17_col_0.tcam_row_17_col_0.ip783tcam64x32s0c1_gen_wrp_inst.ip783tcam64x32s0c1_inst.ip783tcam64x32s0c1_array.array_v[row_idx % 64] = 1'b1;
                                    end
                                    1: begin
                                            //write_mask
                                             gen_tcam_row_17_col_1_tcam.ip783tcam64x32s0c1_wrap_tcam_row_17_col_1.tcam_row_17_col_1.ip783tcam64x32s0c1_gen_wrp_inst.ip783tcam64x32s0c1_inst.ip783tcam64x32s0c1_array.array_x[row_idx % 64] = local_key[1*(32 -2*BCAM_N7) +: 32-2*BCAM_N7];
                                             gen_tcam_row_17_col_1_tcam.ip783tcam64x32s0c1_wrap_tcam_row_17_col_1.tcam_row_17_col_1.ip783tcam64x32s0c1_gen_wrp_inst.ip783tcam64x32s0c1_inst.ip783tcam64x32s0c1_array.array_v[row_idx % 64] = 1'b1;
                                    end
                                    default : begin
                                       $error("SOMTING IS wrong with parameters given for col number %d ",j);
                                     end
              endcase
                      
        end // 17 
         18 :begin
         for (int j = 0;j < 2 ; j = j + 1) 
             case (j)
                                    0: begin
                                            //write_mask
                                             gen_tcam_row_18_col_0_tcam.ip783tcam64x32s0c1_wrap_tcam_row_18_col_0.tcam_row_18_col_0.ip783tcam64x32s0c1_gen_wrp_inst.ip783tcam64x32s0c1_inst.ip783tcam64x32s0c1_array.array_x[row_idx % 64] = local_key[0*(32 -2*BCAM_N7) +: 32-2*BCAM_N7];
                                             gen_tcam_row_18_col_0_tcam.ip783tcam64x32s0c1_wrap_tcam_row_18_col_0.tcam_row_18_col_0.ip783tcam64x32s0c1_gen_wrp_inst.ip783tcam64x32s0c1_inst.ip783tcam64x32s0c1_array.array_v[row_idx % 64] = 1'b1;
                                    end
                                    1: begin
                                            //write_mask
                                             gen_tcam_row_18_col_1_tcam.ip783tcam64x32s0c1_wrap_tcam_row_18_col_1.tcam_row_18_col_1.ip783tcam64x32s0c1_gen_wrp_inst.ip783tcam64x32s0c1_inst.ip783tcam64x32s0c1_array.array_x[row_idx % 64] = local_key[1*(32 -2*BCAM_N7) +: 32-2*BCAM_N7];
                                             gen_tcam_row_18_col_1_tcam.ip783tcam64x32s0c1_wrap_tcam_row_18_col_1.tcam_row_18_col_1.ip783tcam64x32s0c1_gen_wrp_inst.ip783tcam64x32s0c1_inst.ip783tcam64x32s0c1_array.array_v[row_idx % 64] = 1'b1;
                                    end
                                    default : begin
                                       $error("SOMTING IS wrong with parameters given for col number %d ",j);
                                     end
              endcase
                      
        end // 18 
              endcase //(row_idx/64)
            `endif
         // c. update sweeper with new data    
         protect.update_col_sweeper(0, prev_key_data, key);
       endtask // END write_tcam_raw_key
    
    
       // ********** backdoor DATA ***********
        task automatic write_tcam_raw_inv_key (input logic[60-1:0] inv_key, input int row_idx);
          reg temp1,temp2;
          logic [(2 * 32) - 1:0] local_inv_key = '0;
          logic [(2 * 32) - 1:0] prev_inv_key_data;
          local_inv_key[60-1:0] = TCAM_18A ? ~inv_key : ~inv_key;
                                 
          // check size out-of-bounds
          if (row_idx >= TCAM_RULES_NUM) begin
             $error("Cannot write inv_key to idx ", row_idx, ", It exceeds logical value depth ", TCAM_RULES_NUM);
             return;         
          end
          // a. read previous data, for sweepeing purposes
          read_tcam_raw_inv_key(prev_inv_key_data, row_idx);
          // b. write the new inv_key to TCAM
          `ifdef HIF_PCIE_PCIE_ITP_TCAM_BEHAVE_MEMS
               `ifndef HIF_PCIE_FPGA_TCAM_MEMS
                  behave_tcam.state[2*row_idx+1] = inv_key;
               `endif
          `else
              case (row_idx/64)
         0 :begin
         for (int j = 0;j < 2 ; j = j + 1) 
             case (j)
                                    0: begin
                                            //write_DATA
                                             gen_tcam_row_0_col_0_tcam.ip783tcam64x32s0c1_wrap_tcam_row_0_col_0.tcam_row_0_col_0.ip783tcam64x32s0c1_gen_wrp_inst.ip783tcam64x32s0c1_inst.ip783tcam64x32s0c1_array.array_y[row_idx % 64] = local_inv_key[0*(32 -2*BCAM_N7) +: 32-2*BCAM_N7];
                                             gen_tcam_row_0_col_0_tcam.ip783tcam64x32s0c1_wrap_tcam_row_0_col_0.tcam_row_0_col_0.ip783tcam64x32s0c1_gen_wrp_inst.ip783tcam64x32s0c1_inst.ip783tcam64x32s0c1_array.array_v[row_idx % 64] = 1'b1;
                                    end
                                    1: begin
                                            //write_DATA
                                             gen_tcam_row_0_col_1_tcam.ip783tcam64x32s0c1_wrap_tcam_row_0_col_1.tcam_row_0_col_1.ip783tcam64x32s0c1_gen_wrp_inst.ip783tcam64x32s0c1_inst.ip783tcam64x32s0c1_array.array_y[row_idx % 64] = local_inv_key[1*(32 -2*BCAM_N7) +: 32-2*BCAM_N7];
                                             gen_tcam_row_0_col_1_tcam.ip783tcam64x32s0c1_wrap_tcam_row_0_col_1.tcam_row_0_col_1.ip783tcam64x32s0c1_gen_wrp_inst.ip783tcam64x32s0c1_inst.ip783tcam64x32s0c1_array.array_v[row_idx % 64] = 1'b1;
                                    end
                                    default : begin
                                       $error("SOMTING IS wrong with parameters given for col number %d ",j);
                                     end
              endcase
                      
        end // 0 
         1 :begin
         for (int j = 0;j < 2 ; j = j + 1) 
             case (j)
                                    0: begin
                                            //write_DATA
                                             gen_tcam_row_1_col_0_tcam.ip783tcam64x32s0c1_wrap_tcam_row_1_col_0.tcam_row_1_col_0.ip783tcam64x32s0c1_gen_wrp_inst.ip783tcam64x32s0c1_inst.ip783tcam64x32s0c1_array.array_y[row_idx % 64] = local_inv_key[0*(32 -2*BCAM_N7) +: 32-2*BCAM_N7];
                                             gen_tcam_row_1_col_0_tcam.ip783tcam64x32s0c1_wrap_tcam_row_1_col_0.tcam_row_1_col_0.ip783tcam64x32s0c1_gen_wrp_inst.ip783tcam64x32s0c1_inst.ip783tcam64x32s0c1_array.array_v[row_idx % 64] = 1'b1;
                                    end
                                    1: begin
                                            //write_DATA
                                             gen_tcam_row_1_col_1_tcam.ip783tcam64x32s0c1_wrap_tcam_row_1_col_1.tcam_row_1_col_1.ip783tcam64x32s0c1_gen_wrp_inst.ip783tcam64x32s0c1_inst.ip783tcam64x32s0c1_array.array_y[row_idx % 64] = local_inv_key[1*(32 -2*BCAM_N7) +: 32-2*BCAM_N7];
                                             gen_tcam_row_1_col_1_tcam.ip783tcam64x32s0c1_wrap_tcam_row_1_col_1.tcam_row_1_col_1.ip783tcam64x32s0c1_gen_wrp_inst.ip783tcam64x32s0c1_inst.ip783tcam64x32s0c1_array.array_v[row_idx % 64] = 1'b1;
                                    end
                                    default : begin
                                       $error("SOMTING IS wrong with parameters given for col number %d ",j);
                                     end
              endcase
                      
        end // 1 
         2 :begin
         for (int j = 0;j < 2 ; j = j + 1) 
             case (j)
                                    0: begin
                                            //write_DATA
                                             gen_tcam_row_2_col_0_tcam.ip783tcam64x32s0c1_wrap_tcam_row_2_col_0.tcam_row_2_col_0.ip783tcam64x32s0c1_gen_wrp_inst.ip783tcam64x32s0c1_inst.ip783tcam64x32s0c1_array.array_y[row_idx % 64] = local_inv_key[0*(32 -2*BCAM_N7) +: 32-2*BCAM_N7];
                                             gen_tcam_row_2_col_0_tcam.ip783tcam64x32s0c1_wrap_tcam_row_2_col_0.tcam_row_2_col_0.ip783tcam64x32s0c1_gen_wrp_inst.ip783tcam64x32s0c1_inst.ip783tcam64x32s0c1_array.array_v[row_idx % 64] = 1'b1;
                                    end
                                    1: begin
                                            //write_DATA
                                             gen_tcam_row_2_col_1_tcam.ip783tcam64x32s0c1_wrap_tcam_row_2_col_1.tcam_row_2_col_1.ip783tcam64x32s0c1_gen_wrp_inst.ip783tcam64x32s0c1_inst.ip783tcam64x32s0c1_array.array_y[row_idx % 64] = local_inv_key[1*(32 -2*BCAM_N7) +: 32-2*BCAM_N7];
                                             gen_tcam_row_2_col_1_tcam.ip783tcam64x32s0c1_wrap_tcam_row_2_col_1.tcam_row_2_col_1.ip783tcam64x32s0c1_gen_wrp_inst.ip783tcam64x32s0c1_inst.ip783tcam64x32s0c1_array.array_v[row_idx % 64] = 1'b1;
                                    end
                                    default : begin
                                       $error("SOMTING IS wrong with parameters given for col number %d ",j);
                                     end
              endcase
                      
        end // 2 
         3 :begin
         for (int j = 0;j < 2 ; j = j + 1) 
             case (j)
                                    0: begin
                                            //write_DATA
                                             gen_tcam_row_3_col_0_tcam.ip783tcam64x32s0c1_wrap_tcam_row_3_col_0.tcam_row_3_col_0.ip783tcam64x32s0c1_gen_wrp_inst.ip783tcam64x32s0c1_inst.ip783tcam64x32s0c1_array.array_y[row_idx % 64] = local_inv_key[0*(32 -2*BCAM_N7) +: 32-2*BCAM_N7];
                                             gen_tcam_row_3_col_0_tcam.ip783tcam64x32s0c1_wrap_tcam_row_3_col_0.tcam_row_3_col_0.ip783tcam64x32s0c1_gen_wrp_inst.ip783tcam64x32s0c1_inst.ip783tcam64x32s0c1_array.array_v[row_idx % 64] = 1'b1;
                                    end
                                    1: begin
                                            //write_DATA
                                             gen_tcam_row_3_col_1_tcam.ip783tcam64x32s0c1_wrap_tcam_row_3_col_1.tcam_row_3_col_1.ip783tcam64x32s0c1_gen_wrp_inst.ip783tcam64x32s0c1_inst.ip783tcam64x32s0c1_array.array_y[row_idx % 64] = local_inv_key[1*(32 -2*BCAM_N7) +: 32-2*BCAM_N7];
                                             gen_tcam_row_3_col_1_tcam.ip783tcam64x32s0c1_wrap_tcam_row_3_col_1.tcam_row_3_col_1.ip783tcam64x32s0c1_gen_wrp_inst.ip783tcam64x32s0c1_inst.ip783tcam64x32s0c1_array.array_v[row_idx % 64] = 1'b1;
                                    end
                                    default : begin
                                       $error("SOMTING IS wrong with parameters given for col number %d ",j);
                                     end
              endcase
                      
        end // 3 
         4 :begin
         for (int j = 0;j < 2 ; j = j + 1) 
             case (j)
                                    0: begin
                                            //write_DATA
                                             gen_tcam_row_4_col_0_tcam.ip783tcam64x32s0c1_wrap_tcam_row_4_col_0.tcam_row_4_col_0.ip783tcam64x32s0c1_gen_wrp_inst.ip783tcam64x32s0c1_inst.ip783tcam64x32s0c1_array.array_y[row_idx % 64] = local_inv_key[0*(32 -2*BCAM_N7) +: 32-2*BCAM_N7];
                                             gen_tcam_row_4_col_0_tcam.ip783tcam64x32s0c1_wrap_tcam_row_4_col_0.tcam_row_4_col_0.ip783tcam64x32s0c1_gen_wrp_inst.ip783tcam64x32s0c1_inst.ip783tcam64x32s0c1_array.array_v[row_idx % 64] = 1'b1;
                                    end
                                    1: begin
                                            //write_DATA
                                             gen_tcam_row_4_col_1_tcam.ip783tcam64x32s0c1_wrap_tcam_row_4_col_1.tcam_row_4_col_1.ip783tcam64x32s0c1_gen_wrp_inst.ip783tcam64x32s0c1_inst.ip783tcam64x32s0c1_array.array_y[row_idx % 64] = local_inv_key[1*(32 -2*BCAM_N7) +: 32-2*BCAM_N7];
                                             gen_tcam_row_4_col_1_tcam.ip783tcam64x32s0c1_wrap_tcam_row_4_col_1.tcam_row_4_col_1.ip783tcam64x32s0c1_gen_wrp_inst.ip783tcam64x32s0c1_inst.ip783tcam64x32s0c1_array.array_v[row_idx % 64] = 1'b1;
                                    end
                                    default : begin
                                       $error("SOMTING IS wrong with parameters given for col number %d ",j);
                                     end
              endcase
                      
        end // 4 
         5 :begin
         for (int j = 0;j < 2 ; j = j + 1) 
             case (j)
                                    0: begin
                                            //write_DATA
                                             gen_tcam_row_5_col_0_tcam.ip783tcam64x32s0c1_wrap_tcam_row_5_col_0.tcam_row_5_col_0.ip783tcam64x32s0c1_gen_wrp_inst.ip783tcam64x32s0c1_inst.ip783tcam64x32s0c1_array.array_y[row_idx % 64] = local_inv_key[0*(32 -2*BCAM_N7) +: 32-2*BCAM_N7];
                                             gen_tcam_row_5_col_0_tcam.ip783tcam64x32s0c1_wrap_tcam_row_5_col_0.tcam_row_5_col_0.ip783tcam64x32s0c1_gen_wrp_inst.ip783tcam64x32s0c1_inst.ip783tcam64x32s0c1_array.array_v[row_idx % 64] = 1'b1;
                                    end
                                    1: begin
                                            //write_DATA
                                             gen_tcam_row_5_col_1_tcam.ip783tcam64x32s0c1_wrap_tcam_row_5_col_1.tcam_row_5_col_1.ip783tcam64x32s0c1_gen_wrp_inst.ip783tcam64x32s0c1_inst.ip783tcam64x32s0c1_array.array_y[row_idx % 64] = local_inv_key[1*(32 -2*BCAM_N7) +: 32-2*BCAM_N7];
                                             gen_tcam_row_5_col_1_tcam.ip783tcam64x32s0c1_wrap_tcam_row_5_col_1.tcam_row_5_col_1.ip783tcam64x32s0c1_gen_wrp_inst.ip783tcam64x32s0c1_inst.ip783tcam64x32s0c1_array.array_v[row_idx % 64] = 1'b1;
                                    end
                                    default : begin
                                       $error("SOMTING IS wrong with parameters given for col number %d ",j);
                                     end
              endcase
                      
        end // 5 
         6 :begin
         for (int j = 0;j < 2 ; j = j + 1) 
             case (j)
                                    0: begin
                                            //write_DATA
                                             gen_tcam_row_6_col_0_tcam.ip783tcam64x32s0c1_wrap_tcam_row_6_col_0.tcam_row_6_col_0.ip783tcam64x32s0c1_gen_wrp_inst.ip783tcam64x32s0c1_inst.ip783tcam64x32s0c1_array.array_y[row_idx % 64] = local_inv_key[0*(32 -2*BCAM_N7) +: 32-2*BCAM_N7];
                                             gen_tcam_row_6_col_0_tcam.ip783tcam64x32s0c1_wrap_tcam_row_6_col_0.tcam_row_6_col_0.ip783tcam64x32s0c1_gen_wrp_inst.ip783tcam64x32s0c1_inst.ip783tcam64x32s0c1_array.array_v[row_idx % 64] = 1'b1;
                                    end
                                    1: begin
                                            //write_DATA
                                             gen_tcam_row_6_col_1_tcam.ip783tcam64x32s0c1_wrap_tcam_row_6_col_1.tcam_row_6_col_1.ip783tcam64x32s0c1_gen_wrp_inst.ip783tcam64x32s0c1_inst.ip783tcam64x32s0c1_array.array_y[row_idx % 64] = local_inv_key[1*(32 -2*BCAM_N7) +: 32-2*BCAM_N7];
                                             gen_tcam_row_6_col_1_tcam.ip783tcam64x32s0c1_wrap_tcam_row_6_col_1.tcam_row_6_col_1.ip783tcam64x32s0c1_gen_wrp_inst.ip783tcam64x32s0c1_inst.ip783tcam64x32s0c1_array.array_v[row_idx % 64] = 1'b1;
                                    end
                                    default : begin
                                       $error("SOMTING IS wrong with parameters given for col number %d ",j);
                                     end
              endcase
                      
        end // 6 
         7 :begin
         for (int j = 0;j < 2 ; j = j + 1) 
             case (j)
                                    0: begin
                                            //write_DATA
                                             gen_tcam_row_7_col_0_tcam.ip783tcam64x32s0c1_wrap_tcam_row_7_col_0.tcam_row_7_col_0.ip783tcam64x32s0c1_gen_wrp_inst.ip783tcam64x32s0c1_inst.ip783tcam64x32s0c1_array.array_y[row_idx % 64] = local_inv_key[0*(32 -2*BCAM_N7) +: 32-2*BCAM_N7];
                                             gen_tcam_row_7_col_0_tcam.ip783tcam64x32s0c1_wrap_tcam_row_7_col_0.tcam_row_7_col_0.ip783tcam64x32s0c1_gen_wrp_inst.ip783tcam64x32s0c1_inst.ip783tcam64x32s0c1_array.array_v[row_idx % 64] = 1'b1;
                                    end
                                    1: begin
                                            //write_DATA
                                             gen_tcam_row_7_col_1_tcam.ip783tcam64x32s0c1_wrap_tcam_row_7_col_1.tcam_row_7_col_1.ip783tcam64x32s0c1_gen_wrp_inst.ip783tcam64x32s0c1_inst.ip783tcam64x32s0c1_array.array_y[row_idx % 64] = local_inv_key[1*(32 -2*BCAM_N7) +: 32-2*BCAM_N7];
                                             gen_tcam_row_7_col_1_tcam.ip783tcam64x32s0c1_wrap_tcam_row_7_col_1.tcam_row_7_col_1.ip783tcam64x32s0c1_gen_wrp_inst.ip783tcam64x32s0c1_inst.ip783tcam64x32s0c1_array.array_v[row_idx % 64] = 1'b1;
                                    end
                                    default : begin
                                       $error("SOMTING IS wrong with parameters given for col number %d ",j);
                                     end
              endcase
                      
        end // 7 
         8 :begin
         for (int j = 0;j < 2 ; j = j + 1) 
             case (j)
                                    0: begin
                                            //write_DATA
                                             gen_tcam_row_8_col_0_tcam.ip783tcam64x32s0c1_wrap_tcam_row_8_col_0.tcam_row_8_col_0.ip783tcam64x32s0c1_gen_wrp_inst.ip783tcam64x32s0c1_inst.ip783tcam64x32s0c1_array.array_y[row_idx % 64] = local_inv_key[0*(32 -2*BCAM_N7) +: 32-2*BCAM_N7];
                                             gen_tcam_row_8_col_0_tcam.ip783tcam64x32s0c1_wrap_tcam_row_8_col_0.tcam_row_8_col_0.ip783tcam64x32s0c1_gen_wrp_inst.ip783tcam64x32s0c1_inst.ip783tcam64x32s0c1_array.array_v[row_idx % 64] = 1'b1;
                                    end
                                    1: begin
                                            //write_DATA
                                             gen_tcam_row_8_col_1_tcam.ip783tcam64x32s0c1_wrap_tcam_row_8_col_1.tcam_row_8_col_1.ip783tcam64x32s0c1_gen_wrp_inst.ip783tcam64x32s0c1_inst.ip783tcam64x32s0c1_array.array_y[row_idx % 64] = local_inv_key[1*(32 -2*BCAM_N7) +: 32-2*BCAM_N7];
                                             gen_tcam_row_8_col_1_tcam.ip783tcam64x32s0c1_wrap_tcam_row_8_col_1.tcam_row_8_col_1.ip783tcam64x32s0c1_gen_wrp_inst.ip783tcam64x32s0c1_inst.ip783tcam64x32s0c1_array.array_v[row_idx % 64] = 1'b1;
                                    end
                                    default : begin
                                       $error("SOMTING IS wrong with parameters given for col number %d ",j);
                                     end
              endcase
                      
        end // 8 
         9 :begin
         for (int j = 0;j < 2 ; j = j + 1) 
             case (j)
                                    0: begin
                                            //write_DATA
                                             gen_tcam_row_9_col_0_tcam.ip783tcam64x32s0c1_wrap_tcam_row_9_col_0.tcam_row_9_col_0.ip783tcam64x32s0c1_gen_wrp_inst.ip783tcam64x32s0c1_inst.ip783tcam64x32s0c1_array.array_y[row_idx % 64] = local_inv_key[0*(32 -2*BCAM_N7) +: 32-2*BCAM_N7];
                                             gen_tcam_row_9_col_0_tcam.ip783tcam64x32s0c1_wrap_tcam_row_9_col_0.tcam_row_9_col_0.ip783tcam64x32s0c1_gen_wrp_inst.ip783tcam64x32s0c1_inst.ip783tcam64x32s0c1_array.array_v[row_idx % 64] = 1'b1;
                                    end
                                    1: begin
                                            //write_DATA
                                             gen_tcam_row_9_col_1_tcam.ip783tcam64x32s0c1_wrap_tcam_row_9_col_1.tcam_row_9_col_1.ip783tcam64x32s0c1_gen_wrp_inst.ip783tcam64x32s0c1_inst.ip783tcam64x32s0c1_array.array_y[row_idx % 64] = local_inv_key[1*(32 -2*BCAM_N7) +: 32-2*BCAM_N7];
                                             gen_tcam_row_9_col_1_tcam.ip783tcam64x32s0c1_wrap_tcam_row_9_col_1.tcam_row_9_col_1.ip783tcam64x32s0c1_gen_wrp_inst.ip783tcam64x32s0c1_inst.ip783tcam64x32s0c1_array.array_v[row_idx % 64] = 1'b1;
                                    end
                                    default : begin
                                       $error("SOMTING IS wrong with parameters given for col number %d ",j);
                                     end
              endcase
                      
        end // 9 
         10 :begin
         for (int j = 0;j < 2 ; j = j + 1) 
             case (j)
                                    0: begin
                                            //write_DATA
                                             gen_tcam_row_10_col_0_tcam.ip783tcam64x32s0c1_wrap_tcam_row_10_col_0.tcam_row_10_col_0.ip783tcam64x32s0c1_gen_wrp_inst.ip783tcam64x32s0c1_inst.ip783tcam64x32s0c1_array.array_y[row_idx % 64] = local_inv_key[0*(32 -2*BCAM_N7) +: 32-2*BCAM_N7];
                                             gen_tcam_row_10_col_0_tcam.ip783tcam64x32s0c1_wrap_tcam_row_10_col_0.tcam_row_10_col_0.ip783tcam64x32s0c1_gen_wrp_inst.ip783tcam64x32s0c1_inst.ip783tcam64x32s0c1_array.array_v[row_idx % 64] = 1'b1;
                                    end
                                    1: begin
                                            //write_DATA
                                             gen_tcam_row_10_col_1_tcam.ip783tcam64x32s0c1_wrap_tcam_row_10_col_1.tcam_row_10_col_1.ip783tcam64x32s0c1_gen_wrp_inst.ip783tcam64x32s0c1_inst.ip783tcam64x32s0c1_array.array_y[row_idx % 64] = local_inv_key[1*(32 -2*BCAM_N7) +: 32-2*BCAM_N7];
                                             gen_tcam_row_10_col_1_tcam.ip783tcam64x32s0c1_wrap_tcam_row_10_col_1.tcam_row_10_col_1.ip783tcam64x32s0c1_gen_wrp_inst.ip783tcam64x32s0c1_inst.ip783tcam64x32s0c1_array.array_v[row_idx % 64] = 1'b1;
                                    end
                                    default : begin
                                       $error("SOMTING IS wrong with parameters given for col number %d ",j);
                                     end
              endcase
                      
        end // 10 
         11 :begin
         for (int j = 0;j < 2 ; j = j + 1) 
             case (j)
                                    0: begin
                                            //write_DATA
                                             gen_tcam_row_11_col_0_tcam.ip783tcam64x32s0c1_wrap_tcam_row_11_col_0.tcam_row_11_col_0.ip783tcam64x32s0c1_gen_wrp_inst.ip783tcam64x32s0c1_inst.ip783tcam64x32s0c1_array.array_y[row_idx % 64] = local_inv_key[0*(32 -2*BCAM_N7) +: 32-2*BCAM_N7];
                                             gen_tcam_row_11_col_0_tcam.ip783tcam64x32s0c1_wrap_tcam_row_11_col_0.tcam_row_11_col_0.ip783tcam64x32s0c1_gen_wrp_inst.ip783tcam64x32s0c1_inst.ip783tcam64x32s0c1_array.array_v[row_idx % 64] = 1'b1;
                                    end
                                    1: begin
                                            //write_DATA
                                             gen_tcam_row_11_col_1_tcam.ip783tcam64x32s0c1_wrap_tcam_row_11_col_1.tcam_row_11_col_1.ip783tcam64x32s0c1_gen_wrp_inst.ip783tcam64x32s0c1_inst.ip783tcam64x32s0c1_array.array_y[row_idx % 64] = local_inv_key[1*(32 -2*BCAM_N7) +: 32-2*BCAM_N7];
                                             gen_tcam_row_11_col_1_tcam.ip783tcam64x32s0c1_wrap_tcam_row_11_col_1.tcam_row_11_col_1.ip783tcam64x32s0c1_gen_wrp_inst.ip783tcam64x32s0c1_inst.ip783tcam64x32s0c1_array.array_v[row_idx % 64] = 1'b1;
                                    end
                                    default : begin
                                       $error("SOMTING IS wrong with parameters given for col number %d ",j);
                                     end
              endcase
                      
        end // 11 
         12 :begin
         for (int j = 0;j < 2 ; j = j + 1) 
             case (j)
                                    0: begin
                                            //write_DATA
                                             gen_tcam_row_12_col_0_tcam.ip783tcam64x32s0c1_wrap_tcam_row_12_col_0.tcam_row_12_col_0.ip783tcam64x32s0c1_gen_wrp_inst.ip783tcam64x32s0c1_inst.ip783tcam64x32s0c1_array.array_y[row_idx % 64] = local_inv_key[0*(32 -2*BCAM_N7) +: 32-2*BCAM_N7];
                                             gen_tcam_row_12_col_0_tcam.ip783tcam64x32s0c1_wrap_tcam_row_12_col_0.tcam_row_12_col_0.ip783tcam64x32s0c1_gen_wrp_inst.ip783tcam64x32s0c1_inst.ip783tcam64x32s0c1_array.array_v[row_idx % 64] = 1'b1;
                                    end
                                    1: begin
                                            //write_DATA
                                             gen_tcam_row_12_col_1_tcam.ip783tcam64x32s0c1_wrap_tcam_row_12_col_1.tcam_row_12_col_1.ip783tcam64x32s0c1_gen_wrp_inst.ip783tcam64x32s0c1_inst.ip783tcam64x32s0c1_array.array_y[row_idx % 64] = local_inv_key[1*(32 -2*BCAM_N7) +: 32-2*BCAM_N7];
                                             gen_tcam_row_12_col_1_tcam.ip783tcam64x32s0c1_wrap_tcam_row_12_col_1.tcam_row_12_col_1.ip783tcam64x32s0c1_gen_wrp_inst.ip783tcam64x32s0c1_inst.ip783tcam64x32s0c1_array.array_v[row_idx % 64] = 1'b1;
                                    end
                                    default : begin
                                       $error("SOMTING IS wrong with parameters given for col number %d ",j);
                                     end
              endcase
                      
        end // 12 
         13 :begin
         for (int j = 0;j < 2 ; j = j + 1) 
             case (j)
                                    0: begin
                                            //write_DATA
                                             gen_tcam_row_13_col_0_tcam.ip783tcam64x32s0c1_wrap_tcam_row_13_col_0.tcam_row_13_col_0.ip783tcam64x32s0c1_gen_wrp_inst.ip783tcam64x32s0c1_inst.ip783tcam64x32s0c1_array.array_y[row_idx % 64] = local_inv_key[0*(32 -2*BCAM_N7) +: 32-2*BCAM_N7];
                                             gen_tcam_row_13_col_0_tcam.ip783tcam64x32s0c1_wrap_tcam_row_13_col_0.tcam_row_13_col_0.ip783tcam64x32s0c1_gen_wrp_inst.ip783tcam64x32s0c1_inst.ip783tcam64x32s0c1_array.array_v[row_idx % 64] = 1'b1;
                                    end
                                    1: begin
                                            //write_DATA
                                             gen_tcam_row_13_col_1_tcam.ip783tcam64x32s0c1_wrap_tcam_row_13_col_1.tcam_row_13_col_1.ip783tcam64x32s0c1_gen_wrp_inst.ip783tcam64x32s0c1_inst.ip783tcam64x32s0c1_array.array_y[row_idx % 64] = local_inv_key[1*(32 -2*BCAM_N7) +: 32-2*BCAM_N7];
                                             gen_tcam_row_13_col_1_tcam.ip783tcam64x32s0c1_wrap_tcam_row_13_col_1.tcam_row_13_col_1.ip783tcam64x32s0c1_gen_wrp_inst.ip783tcam64x32s0c1_inst.ip783tcam64x32s0c1_array.array_v[row_idx % 64] = 1'b1;
                                    end
                                    default : begin
                                       $error("SOMTING IS wrong with parameters given for col number %d ",j);
                                     end
              endcase
                      
        end // 13 
         14 :begin
         for (int j = 0;j < 2 ; j = j + 1) 
             case (j)
                                    0: begin
                                            //write_DATA
                                             gen_tcam_row_14_col_0_tcam.ip783tcam64x32s0c1_wrap_tcam_row_14_col_0.tcam_row_14_col_0.ip783tcam64x32s0c1_gen_wrp_inst.ip783tcam64x32s0c1_inst.ip783tcam64x32s0c1_array.array_y[row_idx % 64] = local_inv_key[0*(32 -2*BCAM_N7) +: 32-2*BCAM_N7];
                                             gen_tcam_row_14_col_0_tcam.ip783tcam64x32s0c1_wrap_tcam_row_14_col_0.tcam_row_14_col_0.ip783tcam64x32s0c1_gen_wrp_inst.ip783tcam64x32s0c1_inst.ip783tcam64x32s0c1_array.array_v[row_idx % 64] = 1'b1;
                                    end
                                    1: begin
                                            //write_DATA
                                             gen_tcam_row_14_col_1_tcam.ip783tcam64x32s0c1_wrap_tcam_row_14_col_1.tcam_row_14_col_1.ip783tcam64x32s0c1_gen_wrp_inst.ip783tcam64x32s0c1_inst.ip783tcam64x32s0c1_array.array_y[row_idx % 64] = local_inv_key[1*(32 -2*BCAM_N7) +: 32-2*BCAM_N7];
                                             gen_tcam_row_14_col_1_tcam.ip783tcam64x32s0c1_wrap_tcam_row_14_col_1.tcam_row_14_col_1.ip783tcam64x32s0c1_gen_wrp_inst.ip783tcam64x32s0c1_inst.ip783tcam64x32s0c1_array.array_v[row_idx % 64] = 1'b1;
                                    end
                                    default : begin
                                       $error("SOMTING IS wrong with parameters given for col number %d ",j);
                                     end
              endcase
                      
        end // 14 
         15 :begin
         for (int j = 0;j < 2 ; j = j + 1) 
             case (j)
                                    0: begin
                                            //write_DATA
                                             gen_tcam_row_15_col_0_tcam.ip783tcam64x32s0c1_wrap_tcam_row_15_col_0.tcam_row_15_col_0.ip783tcam64x32s0c1_gen_wrp_inst.ip783tcam64x32s0c1_inst.ip783tcam64x32s0c1_array.array_y[row_idx % 64] = local_inv_key[0*(32 -2*BCAM_N7) +: 32-2*BCAM_N7];
                                             gen_tcam_row_15_col_0_tcam.ip783tcam64x32s0c1_wrap_tcam_row_15_col_0.tcam_row_15_col_0.ip783tcam64x32s0c1_gen_wrp_inst.ip783tcam64x32s0c1_inst.ip783tcam64x32s0c1_array.array_v[row_idx % 64] = 1'b1;
                                    end
                                    1: begin
                                            //write_DATA
                                             gen_tcam_row_15_col_1_tcam.ip783tcam64x32s0c1_wrap_tcam_row_15_col_1.tcam_row_15_col_1.ip783tcam64x32s0c1_gen_wrp_inst.ip783tcam64x32s0c1_inst.ip783tcam64x32s0c1_array.array_y[row_idx % 64] = local_inv_key[1*(32 -2*BCAM_N7) +: 32-2*BCAM_N7];
                                             gen_tcam_row_15_col_1_tcam.ip783tcam64x32s0c1_wrap_tcam_row_15_col_1.tcam_row_15_col_1.ip783tcam64x32s0c1_gen_wrp_inst.ip783tcam64x32s0c1_inst.ip783tcam64x32s0c1_array.array_v[row_idx % 64] = 1'b1;
                                    end
                                    default : begin
                                       $error("SOMTING IS wrong with parameters given for col number %d ",j);
                                     end
              endcase
                      
        end // 15 
         16 :begin
         for (int j = 0;j < 2 ; j = j + 1) 
             case (j)
                                    0: begin
                                            //write_DATA
                                             gen_tcam_row_16_col_0_tcam.ip783tcam64x32s0c1_wrap_tcam_row_16_col_0.tcam_row_16_col_0.ip783tcam64x32s0c1_gen_wrp_inst.ip783tcam64x32s0c1_inst.ip783tcam64x32s0c1_array.array_y[row_idx % 64] = local_inv_key[0*(32 -2*BCAM_N7) +: 32-2*BCAM_N7];
                                             gen_tcam_row_16_col_0_tcam.ip783tcam64x32s0c1_wrap_tcam_row_16_col_0.tcam_row_16_col_0.ip783tcam64x32s0c1_gen_wrp_inst.ip783tcam64x32s0c1_inst.ip783tcam64x32s0c1_array.array_v[row_idx % 64] = 1'b1;
                                    end
                                    1: begin
                                            //write_DATA
                                             gen_tcam_row_16_col_1_tcam.ip783tcam64x32s0c1_wrap_tcam_row_16_col_1.tcam_row_16_col_1.ip783tcam64x32s0c1_gen_wrp_inst.ip783tcam64x32s0c1_inst.ip783tcam64x32s0c1_array.array_y[row_idx % 64] = local_inv_key[1*(32 -2*BCAM_N7) +: 32-2*BCAM_N7];
                                             gen_tcam_row_16_col_1_tcam.ip783tcam64x32s0c1_wrap_tcam_row_16_col_1.tcam_row_16_col_1.ip783tcam64x32s0c1_gen_wrp_inst.ip783tcam64x32s0c1_inst.ip783tcam64x32s0c1_array.array_v[row_idx % 64] = 1'b1;
                                    end
                                    default : begin
                                       $error("SOMTING IS wrong with parameters given for col number %d ",j);
                                     end
              endcase
                      
        end // 16 
         17 :begin
         for (int j = 0;j < 2 ; j = j + 1) 
             case (j)
                                    0: begin
                                            //write_DATA
                                             gen_tcam_row_17_col_0_tcam.ip783tcam64x32s0c1_wrap_tcam_row_17_col_0.tcam_row_17_col_0.ip783tcam64x32s0c1_gen_wrp_inst.ip783tcam64x32s0c1_inst.ip783tcam64x32s0c1_array.array_y[row_idx % 64] = local_inv_key[0*(32 -2*BCAM_N7) +: 32-2*BCAM_N7];
                                             gen_tcam_row_17_col_0_tcam.ip783tcam64x32s0c1_wrap_tcam_row_17_col_0.tcam_row_17_col_0.ip783tcam64x32s0c1_gen_wrp_inst.ip783tcam64x32s0c1_inst.ip783tcam64x32s0c1_array.array_v[row_idx % 64] = 1'b1;
                                    end
                                    1: begin
                                            //write_DATA
                                             gen_tcam_row_17_col_1_tcam.ip783tcam64x32s0c1_wrap_tcam_row_17_col_1.tcam_row_17_col_1.ip783tcam64x32s0c1_gen_wrp_inst.ip783tcam64x32s0c1_inst.ip783tcam64x32s0c1_array.array_y[row_idx % 64] = local_inv_key[1*(32 -2*BCAM_N7) +: 32-2*BCAM_N7];
                                             gen_tcam_row_17_col_1_tcam.ip783tcam64x32s0c1_wrap_tcam_row_17_col_1.tcam_row_17_col_1.ip783tcam64x32s0c1_gen_wrp_inst.ip783tcam64x32s0c1_inst.ip783tcam64x32s0c1_array.array_v[row_idx % 64] = 1'b1;
                                    end
                                    default : begin
                                       $error("SOMTING IS wrong with parameters given for col number %d ",j);
                                     end
              endcase
                      
        end // 17 
         18 :begin
         for (int j = 0;j < 2 ; j = j + 1) 
             case (j)
                                    0: begin
                                            //write_DATA
                                             gen_tcam_row_18_col_0_tcam.ip783tcam64x32s0c1_wrap_tcam_row_18_col_0.tcam_row_18_col_0.ip783tcam64x32s0c1_gen_wrp_inst.ip783tcam64x32s0c1_inst.ip783tcam64x32s0c1_array.array_y[row_idx % 64] = local_inv_key[0*(32 -2*BCAM_N7) +: 32-2*BCAM_N7];
                                             gen_tcam_row_18_col_0_tcam.ip783tcam64x32s0c1_wrap_tcam_row_18_col_0.tcam_row_18_col_0.ip783tcam64x32s0c1_gen_wrp_inst.ip783tcam64x32s0c1_inst.ip783tcam64x32s0c1_array.array_v[row_idx % 64] = 1'b1;
                                    end
                                    1: begin
                                            //write_DATA
                                             gen_tcam_row_18_col_1_tcam.ip783tcam64x32s0c1_wrap_tcam_row_18_col_1.tcam_row_18_col_1.ip783tcam64x32s0c1_gen_wrp_inst.ip783tcam64x32s0c1_inst.ip783tcam64x32s0c1_array.array_y[row_idx % 64] = local_inv_key[1*(32 -2*BCAM_N7) +: 32-2*BCAM_N7];
                                             gen_tcam_row_18_col_1_tcam.ip783tcam64x32s0c1_wrap_tcam_row_18_col_1.tcam_row_18_col_1.ip783tcam64x32s0c1_gen_wrp_inst.ip783tcam64x32s0c1_inst.ip783tcam64x32s0c1_array.array_v[row_idx % 64] = 1'b1;
                                    end
                                    default : begin
                                       $error("SOMTING IS wrong with parameters given for col number %d ",j);
                                     end
              endcase
                      
        end // 18 
              endcase //(row_idx/64)
          `endif
          // c. update sweeper with new data
          protect.update_col_sweeper(1, prev_inv_key_data, inv_key);
       endtask // END write_tcam_raw_inv_key
       
       task automatic write_tcam_raw_line (input logic[60-1:0] key, input logic [60-1:0] inv_key, input int row_idx);
              write_tcam_raw_key(key, row_idx);
              write_tcam_raw_inv_key(inv_key, row_idx);
              // set the vbit of a row
              `ifndef HIF_PCIE_PCIE_ITP_TCAM_BEHAVE_MEMS
                   case (row_idx/64)
         0 :begin
         for (int j = 0;j < 2 ; j = j + 1) 
             case (j)
                                    0: begin
                                    end
                                    1: begin
                                    end
                                    default : begin
                                       $error("SOMTING IS wrong with parameters given for col number %d ",j);
                                     end
              endcase
                      
        end // 0 
         1 :begin
         for (int j = 0;j < 2 ; j = j + 1) 
             case (j)
                                    0: begin
                                    end
                                    1: begin
                                    end
                                    default : begin
                                       $error("SOMTING IS wrong with parameters given for col number %d ",j);
                                     end
              endcase
                      
        end // 1 
         2 :begin
         for (int j = 0;j < 2 ; j = j + 1) 
             case (j)
                                    0: begin
                                    end
                                    1: begin
                                    end
                                    default : begin
                                       $error("SOMTING IS wrong with parameters given for col number %d ",j);
                                     end
              endcase
                      
        end // 2 
         3 :begin
         for (int j = 0;j < 2 ; j = j + 1) 
             case (j)
                                    0: begin
                                    end
                                    1: begin
                                    end
                                    default : begin
                                       $error("SOMTING IS wrong with parameters given for col number %d ",j);
                                     end
              endcase
                      
        end // 3 
         4 :begin
         for (int j = 0;j < 2 ; j = j + 1) 
             case (j)
                                    0: begin
                                    end
                                    1: begin
                                    end
                                    default : begin
                                       $error("SOMTING IS wrong with parameters given for col number %d ",j);
                                     end
              endcase
                      
        end // 4 
         5 :begin
         for (int j = 0;j < 2 ; j = j + 1) 
             case (j)
                                    0: begin
                                    end
                                    1: begin
                                    end
                                    default : begin
                                       $error("SOMTING IS wrong with parameters given for col number %d ",j);
                                     end
              endcase
                      
        end // 5 
         6 :begin
         for (int j = 0;j < 2 ; j = j + 1) 
             case (j)
                                    0: begin
                                    end
                                    1: begin
                                    end
                                    default : begin
                                       $error("SOMTING IS wrong with parameters given for col number %d ",j);
                                     end
              endcase
                      
        end // 6 
         7 :begin
         for (int j = 0;j < 2 ; j = j + 1) 
             case (j)
                                    0: begin
                                    end
                                    1: begin
                                    end
                                    default : begin
                                       $error("SOMTING IS wrong with parameters given for col number %d ",j);
                                     end
              endcase
                      
        end // 7 
         8 :begin
         for (int j = 0;j < 2 ; j = j + 1) 
             case (j)
                                    0: begin
                                    end
                                    1: begin
                                    end
                                    default : begin
                                       $error("SOMTING IS wrong with parameters given for col number %d ",j);
                                     end
              endcase
                      
        end // 8 
         9 :begin
         for (int j = 0;j < 2 ; j = j + 1) 
             case (j)
                                    0: begin
                                    end
                                    1: begin
                                    end
                                    default : begin
                                       $error("SOMTING IS wrong with parameters given for col number %d ",j);
                                     end
              endcase
                      
        end // 9 
         10 :begin
         for (int j = 0;j < 2 ; j = j + 1) 
             case (j)
                                    0: begin
                                    end
                                    1: begin
                                    end
                                    default : begin
                                       $error("SOMTING IS wrong with parameters given for col number %d ",j);
                                     end
              endcase
                      
        end // 10 
         11 :begin
         for (int j = 0;j < 2 ; j = j + 1) 
             case (j)
                                    0: begin
                                    end
                                    1: begin
                                    end
                                    default : begin
                                       $error("SOMTING IS wrong with parameters given for col number %d ",j);
                                     end
              endcase
                      
        end // 11 
         12 :begin
         for (int j = 0;j < 2 ; j = j + 1) 
             case (j)
                                    0: begin
                                    end
                                    1: begin
                                    end
                                    default : begin
                                       $error("SOMTING IS wrong with parameters given for col number %d ",j);
                                     end
              endcase
                      
        end // 12 
         13 :begin
         for (int j = 0;j < 2 ; j = j + 1) 
             case (j)
                                    0: begin
                                    end
                                    1: begin
                                    end
                                    default : begin
                                       $error("SOMTING IS wrong with parameters given for col number %d ",j);
                                     end
              endcase
                      
        end // 13 
         14 :begin
         for (int j = 0;j < 2 ; j = j + 1) 
             case (j)
                                    0: begin
                                    end
                                    1: begin
                                    end
                                    default : begin
                                       $error("SOMTING IS wrong with parameters given for col number %d ",j);
                                     end
              endcase
                      
        end // 14 
         15 :begin
         for (int j = 0;j < 2 ; j = j + 1) 
             case (j)
                                    0: begin
                                    end
                                    1: begin
                                    end
                                    default : begin
                                       $error("SOMTING IS wrong with parameters given for col number %d ",j);
                                     end
              endcase
                      
        end // 15 
         16 :begin
         for (int j = 0;j < 2 ; j = j + 1) 
             case (j)
                                    0: begin
                                    end
                                    1: begin
                                    end
                                    default : begin
                                       $error("SOMTING IS wrong with parameters given for col number %d ",j);
                                     end
              endcase
                      
        end // 16 
         17 :begin
         for (int j = 0;j < 2 ; j = j + 1) 
             case (j)
                                    0: begin
                                    end
                                    1: begin
                                    end
                                    default : begin
                                       $error("SOMTING IS wrong with parameters given for col number %d ",j);
                                     end
              endcase
                      
        end // 17 
         18 :begin
         for (int j = 0;j < 2 ; j = j + 1) 
             case (j)
                                    0: begin
                                    end
                                    1: begin
                                    end
                                    default : begin
                                       $error("SOMTING IS wrong with parameters given for col number %d ",j);
                                     end
              endcase
                      
        end // 18 
                   endcase //(row_idx/64)
              `endif      
       endtask // END write_tcam_raw_line
    
     
       // ********** backdoor MASK ***********
       //****this task is valid for TCAM only*****
       task automatic read_tcam_raw_key (output logic[60-1:0] key, input int row_idx);
           reg temp1,valid_word;
           logic [(2 * 32) - 1:0] local_key;
           // check size out-of-bounds
           if (row_idx >= TCAM_RULES_NUM) begin
               $error("Cannot read key from idx ", row_idx, ". It exceeds logical value depth ", TCAM_RULES_NUM);
               return;                                  
           end
             `ifdef HIF_PCIE_PCIE_ITP_TCAM_BEHAVE_MEMS
                `ifndef HIF_PCIE_FPGA_TCAM_MEMS
                   key = behave_tcam.state[2*row_idx];
                 `endif
             `else
                 case (row_idx/64)
         0 :begin
         for (int j = 0;j < 2 ; j = j + 1) 
             case (j)
                                    0: begin
                                            //READ_mask
                                             local_key[0*32 +: 32] = gen_tcam_row_0_col_0_tcam.ip783tcam64x32s0c1_wrap_tcam_row_0_col_0.tcam_row_0_col_0.ip783tcam64x32s0c1_gen_wrp_inst.ip783tcam64x32s0c1_inst.ip783tcam64x32s0c1_array.array_x[row_idx % 64];
                                    end
                                    1: begin
                                            //READ_mask
                                             local_key[1*32 +: 32] = gen_tcam_row_0_col_1_tcam.ip783tcam64x32s0c1_wrap_tcam_row_0_col_1.tcam_row_0_col_1.ip783tcam64x32s0c1_gen_wrp_inst.ip783tcam64x32s0c1_inst.ip783tcam64x32s0c1_array.array_x[row_idx % 64];
                                    end
                                    default : begin
                                       $error("SOMTING IS wrong with parameters given for col number %d ",j);
                                     end
              endcase
                      
        end // 0 
         1 :begin
         for (int j = 0;j < 2 ; j = j + 1) 
             case (j)
                                    0: begin
                                            //READ_mask
                                             local_key[0*32 +: 32] = gen_tcam_row_1_col_0_tcam.ip783tcam64x32s0c1_wrap_tcam_row_1_col_0.tcam_row_1_col_0.ip783tcam64x32s0c1_gen_wrp_inst.ip783tcam64x32s0c1_inst.ip783tcam64x32s0c1_array.array_x[row_idx % 64];
                                    end
                                    1: begin
                                            //READ_mask
                                             local_key[1*32 +: 32] = gen_tcam_row_1_col_1_tcam.ip783tcam64x32s0c1_wrap_tcam_row_1_col_1.tcam_row_1_col_1.ip783tcam64x32s0c1_gen_wrp_inst.ip783tcam64x32s0c1_inst.ip783tcam64x32s0c1_array.array_x[row_idx % 64];
                                    end
                                    default : begin
                                       $error("SOMTING IS wrong with parameters given for col number %d ",j);
                                     end
              endcase
                      
        end // 1 
         2 :begin
         for (int j = 0;j < 2 ; j = j + 1) 
             case (j)
                                    0: begin
                                            //READ_mask
                                             local_key[0*32 +: 32] = gen_tcam_row_2_col_0_tcam.ip783tcam64x32s0c1_wrap_tcam_row_2_col_0.tcam_row_2_col_0.ip783tcam64x32s0c1_gen_wrp_inst.ip783tcam64x32s0c1_inst.ip783tcam64x32s0c1_array.array_x[row_idx % 64];
                                    end
                                    1: begin
                                            //READ_mask
                                             local_key[1*32 +: 32] = gen_tcam_row_2_col_1_tcam.ip783tcam64x32s0c1_wrap_tcam_row_2_col_1.tcam_row_2_col_1.ip783tcam64x32s0c1_gen_wrp_inst.ip783tcam64x32s0c1_inst.ip783tcam64x32s0c1_array.array_x[row_idx % 64];
                                    end
                                    default : begin
                                       $error("SOMTING IS wrong with parameters given for col number %d ",j);
                                     end
              endcase
                      
        end // 2 
         3 :begin
         for (int j = 0;j < 2 ; j = j + 1) 
             case (j)
                                    0: begin
                                            //READ_mask
                                             local_key[0*32 +: 32] = gen_tcam_row_3_col_0_tcam.ip783tcam64x32s0c1_wrap_tcam_row_3_col_0.tcam_row_3_col_0.ip783tcam64x32s0c1_gen_wrp_inst.ip783tcam64x32s0c1_inst.ip783tcam64x32s0c1_array.array_x[row_idx % 64];
                                    end
                                    1: begin
                                            //READ_mask
                                             local_key[1*32 +: 32] = gen_tcam_row_3_col_1_tcam.ip783tcam64x32s0c1_wrap_tcam_row_3_col_1.tcam_row_3_col_1.ip783tcam64x32s0c1_gen_wrp_inst.ip783tcam64x32s0c1_inst.ip783tcam64x32s0c1_array.array_x[row_idx % 64];
                                    end
                                    default : begin
                                       $error("SOMTING IS wrong with parameters given for col number %d ",j);
                                     end
              endcase
                      
        end // 3 
         4 :begin
         for (int j = 0;j < 2 ; j = j + 1) 
             case (j)
                                    0: begin
                                            //READ_mask
                                             local_key[0*32 +: 32] = gen_tcam_row_4_col_0_tcam.ip783tcam64x32s0c1_wrap_tcam_row_4_col_0.tcam_row_4_col_0.ip783tcam64x32s0c1_gen_wrp_inst.ip783tcam64x32s0c1_inst.ip783tcam64x32s0c1_array.array_x[row_idx % 64];
                                    end
                                    1: begin
                                            //READ_mask
                                             local_key[1*32 +: 32] = gen_tcam_row_4_col_1_tcam.ip783tcam64x32s0c1_wrap_tcam_row_4_col_1.tcam_row_4_col_1.ip783tcam64x32s0c1_gen_wrp_inst.ip783tcam64x32s0c1_inst.ip783tcam64x32s0c1_array.array_x[row_idx % 64];
                                    end
                                    default : begin
                                       $error("SOMTING IS wrong with parameters given for col number %d ",j);
                                     end
              endcase
                      
        end // 4 
         5 :begin
         for (int j = 0;j < 2 ; j = j + 1) 
             case (j)
                                    0: begin
                                            //READ_mask
                                             local_key[0*32 +: 32] = gen_tcam_row_5_col_0_tcam.ip783tcam64x32s0c1_wrap_tcam_row_5_col_0.tcam_row_5_col_0.ip783tcam64x32s0c1_gen_wrp_inst.ip783tcam64x32s0c1_inst.ip783tcam64x32s0c1_array.array_x[row_idx % 64];
                                    end
                                    1: begin
                                            //READ_mask
                                             local_key[1*32 +: 32] = gen_tcam_row_5_col_1_tcam.ip783tcam64x32s0c1_wrap_tcam_row_5_col_1.tcam_row_5_col_1.ip783tcam64x32s0c1_gen_wrp_inst.ip783tcam64x32s0c1_inst.ip783tcam64x32s0c1_array.array_x[row_idx % 64];
                                    end
                                    default : begin
                                       $error("SOMTING IS wrong with parameters given for col number %d ",j);
                                     end
              endcase
                      
        end // 5 
         6 :begin
         for (int j = 0;j < 2 ; j = j + 1) 
             case (j)
                                    0: begin
                                            //READ_mask
                                             local_key[0*32 +: 32] = gen_tcam_row_6_col_0_tcam.ip783tcam64x32s0c1_wrap_tcam_row_6_col_0.tcam_row_6_col_0.ip783tcam64x32s0c1_gen_wrp_inst.ip783tcam64x32s0c1_inst.ip783tcam64x32s0c1_array.array_x[row_idx % 64];
                                    end
                                    1: begin
                                            //READ_mask
                                             local_key[1*32 +: 32] = gen_tcam_row_6_col_1_tcam.ip783tcam64x32s0c1_wrap_tcam_row_6_col_1.tcam_row_6_col_1.ip783tcam64x32s0c1_gen_wrp_inst.ip783tcam64x32s0c1_inst.ip783tcam64x32s0c1_array.array_x[row_idx % 64];
                                    end
                                    default : begin
                                       $error("SOMTING IS wrong with parameters given for col number %d ",j);
                                     end
              endcase
                      
        end // 6 
         7 :begin
         for (int j = 0;j < 2 ; j = j + 1) 
             case (j)
                                    0: begin
                                            //READ_mask
                                             local_key[0*32 +: 32] = gen_tcam_row_7_col_0_tcam.ip783tcam64x32s0c1_wrap_tcam_row_7_col_0.tcam_row_7_col_0.ip783tcam64x32s0c1_gen_wrp_inst.ip783tcam64x32s0c1_inst.ip783tcam64x32s0c1_array.array_x[row_idx % 64];
                                    end
                                    1: begin
                                            //READ_mask
                                             local_key[1*32 +: 32] = gen_tcam_row_7_col_1_tcam.ip783tcam64x32s0c1_wrap_tcam_row_7_col_1.tcam_row_7_col_1.ip783tcam64x32s0c1_gen_wrp_inst.ip783tcam64x32s0c1_inst.ip783tcam64x32s0c1_array.array_x[row_idx % 64];
                                    end
                                    default : begin
                                       $error("SOMTING IS wrong with parameters given for col number %d ",j);
                                     end
              endcase
                      
        end // 7 
         8 :begin
         for (int j = 0;j < 2 ; j = j + 1) 
             case (j)
                                    0: begin
                                            //READ_mask
                                             local_key[0*32 +: 32] = gen_tcam_row_8_col_0_tcam.ip783tcam64x32s0c1_wrap_tcam_row_8_col_0.tcam_row_8_col_0.ip783tcam64x32s0c1_gen_wrp_inst.ip783tcam64x32s0c1_inst.ip783tcam64x32s0c1_array.array_x[row_idx % 64];
                                    end
                                    1: begin
                                            //READ_mask
                                             local_key[1*32 +: 32] = gen_tcam_row_8_col_1_tcam.ip783tcam64x32s0c1_wrap_tcam_row_8_col_1.tcam_row_8_col_1.ip783tcam64x32s0c1_gen_wrp_inst.ip783tcam64x32s0c1_inst.ip783tcam64x32s0c1_array.array_x[row_idx % 64];
                                    end
                                    default : begin
                                       $error("SOMTING IS wrong with parameters given for col number %d ",j);
                                     end
              endcase
                      
        end // 8 
         9 :begin
         for (int j = 0;j < 2 ; j = j + 1) 
             case (j)
                                    0: begin
                                            //READ_mask
                                             local_key[0*32 +: 32] = gen_tcam_row_9_col_0_tcam.ip783tcam64x32s0c1_wrap_tcam_row_9_col_0.tcam_row_9_col_0.ip783tcam64x32s0c1_gen_wrp_inst.ip783tcam64x32s0c1_inst.ip783tcam64x32s0c1_array.array_x[row_idx % 64];
                                    end
                                    1: begin
                                            //READ_mask
                                             local_key[1*32 +: 32] = gen_tcam_row_9_col_1_tcam.ip783tcam64x32s0c1_wrap_tcam_row_9_col_1.tcam_row_9_col_1.ip783tcam64x32s0c1_gen_wrp_inst.ip783tcam64x32s0c1_inst.ip783tcam64x32s0c1_array.array_x[row_idx % 64];
                                    end
                                    default : begin
                                       $error("SOMTING IS wrong with parameters given for col number %d ",j);
                                     end
              endcase
                      
        end // 9 
         10 :begin
         for (int j = 0;j < 2 ; j = j + 1) 
             case (j)
                                    0: begin
                                            //READ_mask
                                             local_key[0*32 +: 32] = gen_tcam_row_10_col_0_tcam.ip783tcam64x32s0c1_wrap_tcam_row_10_col_0.tcam_row_10_col_0.ip783tcam64x32s0c1_gen_wrp_inst.ip783tcam64x32s0c1_inst.ip783tcam64x32s0c1_array.array_x[row_idx % 64];
                                    end
                                    1: begin
                                            //READ_mask
                                             local_key[1*32 +: 32] = gen_tcam_row_10_col_1_tcam.ip783tcam64x32s0c1_wrap_tcam_row_10_col_1.tcam_row_10_col_1.ip783tcam64x32s0c1_gen_wrp_inst.ip783tcam64x32s0c1_inst.ip783tcam64x32s0c1_array.array_x[row_idx % 64];
                                    end
                                    default : begin
                                       $error("SOMTING IS wrong with parameters given for col number %d ",j);
                                     end
              endcase
                      
        end // 10 
         11 :begin
         for (int j = 0;j < 2 ; j = j + 1) 
             case (j)
                                    0: begin
                                            //READ_mask
                                             local_key[0*32 +: 32] = gen_tcam_row_11_col_0_tcam.ip783tcam64x32s0c1_wrap_tcam_row_11_col_0.tcam_row_11_col_0.ip783tcam64x32s0c1_gen_wrp_inst.ip783tcam64x32s0c1_inst.ip783tcam64x32s0c1_array.array_x[row_idx % 64];
                                    end
                                    1: begin
                                            //READ_mask
                                             local_key[1*32 +: 32] = gen_tcam_row_11_col_1_tcam.ip783tcam64x32s0c1_wrap_tcam_row_11_col_1.tcam_row_11_col_1.ip783tcam64x32s0c1_gen_wrp_inst.ip783tcam64x32s0c1_inst.ip783tcam64x32s0c1_array.array_x[row_idx % 64];
                                    end
                                    default : begin
                                       $error("SOMTING IS wrong with parameters given for col number %d ",j);
                                     end
              endcase
                      
        end // 11 
         12 :begin
         for (int j = 0;j < 2 ; j = j + 1) 
             case (j)
                                    0: begin
                                            //READ_mask
                                             local_key[0*32 +: 32] = gen_tcam_row_12_col_0_tcam.ip783tcam64x32s0c1_wrap_tcam_row_12_col_0.tcam_row_12_col_0.ip783tcam64x32s0c1_gen_wrp_inst.ip783tcam64x32s0c1_inst.ip783tcam64x32s0c1_array.array_x[row_idx % 64];
                                    end
                                    1: begin
                                            //READ_mask
                                             local_key[1*32 +: 32] = gen_tcam_row_12_col_1_tcam.ip783tcam64x32s0c1_wrap_tcam_row_12_col_1.tcam_row_12_col_1.ip783tcam64x32s0c1_gen_wrp_inst.ip783tcam64x32s0c1_inst.ip783tcam64x32s0c1_array.array_x[row_idx % 64];
                                    end
                                    default : begin
                                       $error("SOMTING IS wrong with parameters given for col number %d ",j);
                                     end
              endcase
                      
        end // 12 
         13 :begin
         for (int j = 0;j < 2 ; j = j + 1) 
             case (j)
                                    0: begin
                                            //READ_mask
                                             local_key[0*32 +: 32] = gen_tcam_row_13_col_0_tcam.ip783tcam64x32s0c1_wrap_tcam_row_13_col_0.tcam_row_13_col_0.ip783tcam64x32s0c1_gen_wrp_inst.ip783tcam64x32s0c1_inst.ip783tcam64x32s0c1_array.array_x[row_idx % 64];
                                    end
                                    1: begin
                                            //READ_mask
                                             local_key[1*32 +: 32] = gen_tcam_row_13_col_1_tcam.ip783tcam64x32s0c1_wrap_tcam_row_13_col_1.tcam_row_13_col_1.ip783tcam64x32s0c1_gen_wrp_inst.ip783tcam64x32s0c1_inst.ip783tcam64x32s0c1_array.array_x[row_idx % 64];
                                    end
                                    default : begin
                                       $error("SOMTING IS wrong with parameters given for col number %d ",j);
                                     end
              endcase
                      
        end // 13 
         14 :begin
         for (int j = 0;j < 2 ; j = j + 1) 
             case (j)
                                    0: begin
                                            //READ_mask
                                             local_key[0*32 +: 32] = gen_tcam_row_14_col_0_tcam.ip783tcam64x32s0c1_wrap_tcam_row_14_col_0.tcam_row_14_col_0.ip783tcam64x32s0c1_gen_wrp_inst.ip783tcam64x32s0c1_inst.ip783tcam64x32s0c1_array.array_x[row_idx % 64];
                                    end
                                    1: begin
                                            //READ_mask
                                             local_key[1*32 +: 32] = gen_tcam_row_14_col_1_tcam.ip783tcam64x32s0c1_wrap_tcam_row_14_col_1.tcam_row_14_col_1.ip783tcam64x32s0c1_gen_wrp_inst.ip783tcam64x32s0c1_inst.ip783tcam64x32s0c1_array.array_x[row_idx % 64];
                                    end
                                    default : begin
                                       $error("SOMTING IS wrong with parameters given for col number %d ",j);
                                     end
              endcase
                      
        end // 14 
         15 :begin
         for (int j = 0;j < 2 ; j = j + 1) 
             case (j)
                                    0: begin
                                            //READ_mask
                                             local_key[0*32 +: 32] = gen_tcam_row_15_col_0_tcam.ip783tcam64x32s0c1_wrap_tcam_row_15_col_0.tcam_row_15_col_0.ip783tcam64x32s0c1_gen_wrp_inst.ip783tcam64x32s0c1_inst.ip783tcam64x32s0c1_array.array_x[row_idx % 64];
                                    end
                                    1: begin
                                            //READ_mask
                                             local_key[1*32 +: 32] = gen_tcam_row_15_col_1_tcam.ip783tcam64x32s0c1_wrap_tcam_row_15_col_1.tcam_row_15_col_1.ip783tcam64x32s0c1_gen_wrp_inst.ip783tcam64x32s0c1_inst.ip783tcam64x32s0c1_array.array_x[row_idx % 64];
                                    end
                                    default : begin
                                       $error("SOMTING IS wrong with parameters given for col number %d ",j);
                                     end
              endcase
                      
        end // 15 
         16 :begin
         for (int j = 0;j < 2 ; j = j + 1) 
             case (j)
                                    0: begin
                                            //READ_mask
                                             local_key[0*32 +: 32] = gen_tcam_row_16_col_0_tcam.ip783tcam64x32s0c1_wrap_tcam_row_16_col_0.tcam_row_16_col_0.ip783tcam64x32s0c1_gen_wrp_inst.ip783tcam64x32s0c1_inst.ip783tcam64x32s0c1_array.array_x[row_idx % 64];
                                    end
                                    1: begin
                                            //READ_mask
                                             local_key[1*32 +: 32] = gen_tcam_row_16_col_1_tcam.ip783tcam64x32s0c1_wrap_tcam_row_16_col_1.tcam_row_16_col_1.ip783tcam64x32s0c1_gen_wrp_inst.ip783tcam64x32s0c1_inst.ip783tcam64x32s0c1_array.array_x[row_idx % 64];
                                    end
                                    default : begin
                                       $error("SOMTING IS wrong with parameters given for col number %d ",j);
                                     end
              endcase
                      
        end // 16 
         17 :begin
         for (int j = 0;j < 2 ; j = j + 1) 
             case (j)
                                    0: begin
                                            //READ_mask
                                             local_key[0*32 +: 32] = gen_tcam_row_17_col_0_tcam.ip783tcam64x32s0c1_wrap_tcam_row_17_col_0.tcam_row_17_col_0.ip783tcam64x32s0c1_gen_wrp_inst.ip783tcam64x32s0c1_inst.ip783tcam64x32s0c1_array.array_x[row_idx % 64];
                                    end
                                    1: begin
                                            //READ_mask
                                             local_key[1*32 +: 32] = gen_tcam_row_17_col_1_tcam.ip783tcam64x32s0c1_wrap_tcam_row_17_col_1.tcam_row_17_col_1.ip783tcam64x32s0c1_gen_wrp_inst.ip783tcam64x32s0c1_inst.ip783tcam64x32s0c1_array.array_x[row_idx % 64];
                                    end
                                    default : begin
                                       $error("SOMTING IS wrong with parameters given for col number %d ",j);
                                     end
              endcase
                      
        end // 17 
         18 :begin
         for (int j = 0;j < 2 ; j = j + 1) 
             case (j)
                                    0: begin
                                            //READ_mask
                                             local_key[0*32 +: 32] = gen_tcam_row_18_col_0_tcam.ip783tcam64x32s0c1_wrap_tcam_row_18_col_0.tcam_row_18_col_0.ip783tcam64x32s0c1_gen_wrp_inst.ip783tcam64x32s0c1_inst.ip783tcam64x32s0c1_array.array_x[row_idx % 64];
                                    end
                                    1: begin
                                            //READ_mask
                                             local_key[1*32 +: 32] = gen_tcam_row_18_col_1_tcam.ip783tcam64x32s0c1_wrap_tcam_row_18_col_1.tcam_row_18_col_1.ip783tcam64x32s0c1_gen_wrp_inst.ip783tcam64x32s0c1_inst.ip783tcam64x32s0c1_array.array_x[row_idx % 64];
                                    end
                                    default : begin
                                       $error("SOMTING IS wrong with parameters given for col number %d ",j);
                                     end
              endcase
                      
        end // 18 
                 endcase //(row_idx/64)
                 key = TCAM_18A ? ~local_key : ~local_key;
             `endif
       endtask // END read_tcam_raw_key
    
    
     // ********** backdoor DATA ***********
       task automatic read_tcam_raw_inv_key (output logic[60-1:0] inv_key, input int row_idx);
           reg temp1,valid_word;
           logic [(2 * 32) - 1:0] local_inv_key;
           // check size out-of-bounds
           if (row_idx >= TCAM_RULES_NUM) begin
               $error("Cannot read inv_key from idx ", row_idx, ". It exceeds logical value depth ", TCAM_RULES_NUM);
               return;                                  
           end
    
             `ifdef HIF_PCIE_PCIE_ITP_TCAM_BEHAVE_MEMS
                  `ifndef HIF_PCIE_FPGA_TCAM_MEMS
                     inv_key = behave_tcam.state[2*row_idx+1];
                  `endif
             `else
                 case (row_idx/64)
         0 :begin
         for (int j = 0;j < 2 ; j = j + 1) 
             case (j)
                                    0: begin
                                            //READ_data
                                             local_inv_key[0*32 +: 32] = gen_tcam_row_0_col_0_tcam.ip783tcam64x32s0c1_wrap_tcam_row_0_col_0.tcam_row_0_col_0.ip783tcam64x32s0c1_gen_wrp_inst.ip783tcam64x32s0c1_inst.ip783tcam64x32s0c1_array.array_y[row_idx % 64];
                                    end
                                    1: begin
                                            //READ_data
                                             local_inv_key[1*32 +: 32] = gen_tcam_row_0_col_1_tcam.ip783tcam64x32s0c1_wrap_tcam_row_0_col_1.tcam_row_0_col_1.ip783tcam64x32s0c1_gen_wrp_inst.ip783tcam64x32s0c1_inst.ip783tcam64x32s0c1_array.array_y[row_idx % 64];
                                    end
                                    default : begin
                                       $error("SOMTING IS wrong with parameters given for col number %d ",j);
                                     end
              endcase
                      
        end // 0 
         1 :begin
         for (int j = 0;j < 2 ; j = j + 1) 
             case (j)
                                    0: begin
                                            //READ_data
                                             local_inv_key[0*32 +: 32] = gen_tcam_row_1_col_0_tcam.ip783tcam64x32s0c1_wrap_tcam_row_1_col_0.tcam_row_1_col_0.ip783tcam64x32s0c1_gen_wrp_inst.ip783tcam64x32s0c1_inst.ip783tcam64x32s0c1_array.array_y[row_idx % 64];
                                    end
                                    1: begin
                                            //READ_data
                                             local_inv_key[1*32 +: 32] = gen_tcam_row_1_col_1_tcam.ip783tcam64x32s0c1_wrap_tcam_row_1_col_1.tcam_row_1_col_1.ip783tcam64x32s0c1_gen_wrp_inst.ip783tcam64x32s0c1_inst.ip783tcam64x32s0c1_array.array_y[row_idx % 64];
                                    end
                                    default : begin
                                       $error("SOMTING IS wrong with parameters given for col number %d ",j);
                                     end
              endcase
                      
        end // 1 
         2 :begin
         for (int j = 0;j < 2 ; j = j + 1) 
             case (j)
                                    0: begin
                                            //READ_data
                                             local_inv_key[0*32 +: 32] = gen_tcam_row_2_col_0_tcam.ip783tcam64x32s0c1_wrap_tcam_row_2_col_0.tcam_row_2_col_0.ip783tcam64x32s0c1_gen_wrp_inst.ip783tcam64x32s0c1_inst.ip783tcam64x32s0c1_array.array_y[row_idx % 64];
                                    end
                                    1: begin
                                            //READ_data
                                             local_inv_key[1*32 +: 32] = gen_tcam_row_2_col_1_tcam.ip783tcam64x32s0c1_wrap_tcam_row_2_col_1.tcam_row_2_col_1.ip783tcam64x32s0c1_gen_wrp_inst.ip783tcam64x32s0c1_inst.ip783tcam64x32s0c1_array.array_y[row_idx % 64];
                                    end
                                    default : begin
                                       $error("SOMTING IS wrong with parameters given for col number %d ",j);
                                     end
              endcase
                      
        end // 2 
         3 :begin
         for (int j = 0;j < 2 ; j = j + 1) 
             case (j)
                                    0: begin
                                            //READ_data
                                             local_inv_key[0*32 +: 32] = gen_tcam_row_3_col_0_tcam.ip783tcam64x32s0c1_wrap_tcam_row_3_col_0.tcam_row_3_col_0.ip783tcam64x32s0c1_gen_wrp_inst.ip783tcam64x32s0c1_inst.ip783tcam64x32s0c1_array.array_y[row_idx % 64];
                                    end
                                    1: begin
                                            //READ_data
                                             local_inv_key[1*32 +: 32] = gen_tcam_row_3_col_1_tcam.ip783tcam64x32s0c1_wrap_tcam_row_3_col_1.tcam_row_3_col_1.ip783tcam64x32s0c1_gen_wrp_inst.ip783tcam64x32s0c1_inst.ip783tcam64x32s0c1_array.array_y[row_idx % 64];
                                    end
                                    default : begin
                                       $error("SOMTING IS wrong with parameters given for col number %d ",j);
                                     end
              endcase
                      
        end // 3 
         4 :begin
         for (int j = 0;j < 2 ; j = j + 1) 
             case (j)
                                    0: begin
                                            //READ_data
                                             local_inv_key[0*32 +: 32] = gen_tcam_row_4_col_0_tcam.ip783tcam64x32s0c1_wrap_tcam_row_4_col_0.tcam_row_4_col_0.ip783tcam64x32s0c1_gen_wrp_inst.ip783tcam64x32s0c1_inst.ip783tcam64x32s0c1_array.array_y[row_idx % 64];
                                    end
                                    1: begin
                                            //READ_data
                                             local_inv_key[1*32 +: 32] = gen_tcam_row_4_col_1_tcam.ip783tcam64x32s0c1_wrap_tcam_row_4_col_1.tcam_row_4_col_1.ip783tcam64x32s0c1_gen_wrp_inst.ip783tcam64x32s0c1_inst.ip783tcam64x32s0c1_array.array_y[row_idx % 64];
                                    end
                                    default : begin
                                       $error("SOMTING IS wrong with parameters given for col number %d ",j);
                                     end
              endcase
                      
        end // 4 
         5 :begin
         for (int j = 0;j < 2 ; j = j + 1) 
             case (j)
                                    0: begin
                                            //READ_data
                                             local_inv_key[0*32 +: 32] = gen_tcam_row_5_col_0_tcam.ip783tcam64x32s0c1_wrap_tcam_row_5_col_0.tcam_row_5_col_0.ip783tcam64x32s0c1_gen_wrp_inst.ip783tcam64x32s0c1_inst.ip783tcam64x32s0c1_array.array_y[row_idx % 64];
                                    end
                                    1: begin
                                            //READ_data
                                             local_inv_key[1*32 +: 32] = gen_tcam_row_5_col_1_tcam.ip783tcam64x32s0c1_wrap_tcam_row_5_col_1.tcam_row_5_col_1.ip783tcam64x32s0c1_gen_wrp_inst.ip783tcam64x32s0c1_inst.ip783tcam64x32s0c1_array.array_y[row_idx % 64];
                                    end
                                    default : begin
                                       $error("SOMTING IS wrong with parameters given for col number %d ",j);
                                     end
              endcase
                      
        end // 5 
         6 :begin
         for (int j = 0;j < 2 ; j = j + 1) 
             case (j)
                                    0: begin
                                            //READ_data
                                             local_inv_key[0*32 +: 32] = gen_tcam_row_6_col_0_tcam.ip783tcam64x32s0c1_wrap_tcam_row_6_col_0.tcam_row_6_col_0.ip783tcam64x32s0c1_gen_wrp_inst.ip783tcam64x32s0c1_inst.ip783tcam64x32s0c1_array.array_y[row_idx % 64];
                                    end
                                    1: begin
                                            //READ_data
                                             local_inv_key[1*32 +: 32] = gen_tcam_row_6_col_1_tcam.ip783tcam64x32s0c1_wrap_tcam_row_6_col_1.tcam_row_6_col_1.ip783tcam64x32s0c1_gen_wrp_inst.ip783tcam64x32s0c1_inst.ip783tcam64x32s0c1_array.array_y[row_idx % 64];
                                    end
                                    default : begin
                                       $error("SOMTING IS wrong with parameters given for col number %d ",j);
                                     end
              endcase
                      
        end // 6 
         7 :begin
         for (int j = 0;j < 2 ; j = j + 1) 
             case (j)
                                    0: begin
                                            //READ_data
                                             local_inv_key[0*32 +: 32] = gen_tcam_row_7_col_0_tcam.ip783tcam64x32s0c1_wrap_tcam_row_7_col_0.tcam_row_7_col_0.ip783tcam64x32s0c1_gen_wrp_inst.ip783tcam64x32s0c1_inst.ip783tcam64x32s0c1_array.array_y[row_idx % 64];
                                    end
                                    1: begin
                                            //READ_data
                                             local_inv_key[1*32 +: 32] = gen_tcam_row_7_col_1_tcam.ip783tcam64x32s0c1_wrap_tcam_row_7_col_1.tcam_row_7_col_1.ip783tcam64x32s0c1_gen_wrp_inst.ip783tcam64x32s0c1_inst.ip783tcam64x32s0c1_array.array_y[row_idx % 64];
                                    end
                                    default : begin
                                       $error("SOMTING IS wrong with parameters given for col number %d ",j);
                                     end
              endcase
                      
        end // 7 
         8 :begin
         for (int j = 0;j < 2 ; j = j + 1) 
             case (j)
                                    0: begin
                                            //READ_data
                                             local_inv_key[0*32 +: 32] = gen_tcam_row_8_col_0_tcam.ip783tcam64x32s0c1_wrap_tcam_row_8_col_0.tcam_row_8_col_0.ip783tcam64x32s0c1_gen_wrp_inst.ip783tcam64x32s0c1_inst.ip783tcam64x32s0c1_array.array_y[row_idx % 64];
                                    end
                                    1: begin
                                            //READ_data
                                             local_inv_key[1*32 +: 32] = gen_tcam_row_8_col_1_tcam.ip783tcam64x32s0c1_wrap_tcam_row_8_col_1.tcam_row_8_col_1.ip783tcam64x32s0c1_gen_wrp_inst.ip783tcam64x32s0c1_inst.ip783tcam64x32s0c1_array.array_y[row_idx % 64];
                                    end
                                    default : begin
                                       $error("SOMTING IS wrong with parameters given for col number %d ",j);
                                     end
              endcase
                      
        end // 8 
         9 :begin
         for (int j = 0;j < 2 ; j = j + 1) 
             case (j)
                                    0: begin
                                            //READ_data
                                             local_inv_key[0*32 +: 32] = gen_tcam_row_9_col_0_tcam.ip783tcam64x32s0c1_wrap_tcam_row_9_col_0.tcam_row_9_col_0.ip783tcam64x32s0c1_gen_wrp_inst.ip783tcam64x32s0c1_inst.ip783tcam64x32s0c1_array.array_y[row_idx % 64];
                                    end
                                    1: begin
                                            //READ_data
                                             local_inv_key[1*32 +: 32] = gen_tcam_row_9_col_1_tcam.ip783tcam64x32s0c1_wrap_tcam_row_9_col_1.tcam_row_9_col_1.ip783tcam64x32s0c1_gen_wrp_inst.ip783tcam64x32s0c1_inst.ip783tcam64x32s0c1_array.array_y[row_idx % 64];
                                    end
                                    default : begin
                                       $error("SOMTING IS wrong with parameters given for col number %d ",j);
                                     end
              endcase
                      
        end // 9 
         10 :begin
         for (int j = 0;j < 2 ; j = j + 1) 
             case (j)
                                    0: begin
                                            //READ_data
                                             local_inv_key[0*32 +: 32] = gen_tcam_row_10_col_0_tcam.ip783tcam64x32s0c1_wrap_tcam_row_10_col_0.tcam_row_10_col_0.ip783tcam64x32s0c1_gen_wrp_inst.ip783tcam64x32s0c1_inst.ip783tcam64x32s0c1_array.array_y[row_idx % 64];
                                    end
                                    1: begin
                                            //READ_data
                                             local_inv_key[1*32 +: 32] = gen_tcam_row_10_col_1_tcam.ip783tcam64x32s0c1_wrap_tcam_row_10_col_1.tcam_row_10_col_1.ip783tcam64x32s0c1_gen_wrp_inst.ip783tcam64x32s0c1_inst.ip783tcam64x32s0c1_array.array_y[row_idx % 64];
                                    end
                                    default : begin
                                       $error("SOMTING IS wrong with parameters given for col number %d ",j);
                                     end
              endcase
                      
        end // 10 
         11 :begin
         for (int j = 0;j < 2 ; j = j + 1) 
             case (j)
                                    0: begin
                                            //READ_data
                                             local_inv_key[0*32 +: 32] = gen_tcam_row_11_col_0_tcam.ip783tcam64x32s0c1_wrap_tcam_row_11_col_0.tcam_row_11_col_0.ip783tcam64x32s0c1_gen_wrp_inst.ip783tcam64x32s0c1_inst.ip783tcam64x32s0c1_array.array_y[row_idx % 64];
                                    end
                                    1: begin
                                            //READ_data
                                             local_inv_key[1*32 +: 32] = gen_tcam_row_11_col_1_tcam.ip783tcam64x32s0c1_wrap_tcam_row_11_col_1.tcam_row_11_col_1.ip783tcam64x32s0c1_gen_wrp_inst.ip783tcam64x32s0c1_inst.ip783tcam64x32s0c1_array.array_y[row_idx % 64];
                                    end
                                    default : begin
                                       $error("SOMTING IS wrong with parameters given for col number %d ",j);
                                     end
              endcase
                      
        end // 11 
         12 :begin
         for (int j = 0;j < 2 ; j = j + 1) 
             case (j)
                                    0: begin
                                            //READ_data
                                             local_inv_key[0*32 +: 32] = gen_tcam_row_12_col_0_tcam.ip783tcam64x32s0c1_wrap_tcam_row_12_col_0.tcam_row_12_col_0.ip783tcam64x32s0c1_gen_wrp_inst.ip783tcam64x32s0c1_inst.ip783tcam64x32s0c1_array.array_y[row_idx % 64];
                                    end
                                    1: begin
                                            //READ_data
                                             local_inv_key[1*32 +: 32] = gen_tcam_row_12_col_1_tcam.ip783tcam64x32s0c1_wrap_tcam_row_12_col_1.tcam_row_12_col_1.ip783tcam64x32s0c1_gen_wrp_inst.ip783tcam64x32s0c1_inst.ip783tcam64x32s0c1_array.array_y[row_idx % 64];
                                    end
                                    default : begin
                                       $error("SOMTING IS wrong with parameters given for col number %d ",j);
                                     end
              endcase
                      
        end // 12 
         13 :begin
         for (int j = 0;j < 2 ; j = j + 1) 
             case (j)
                                    0: begin
                                            //READ_data
                                             local_inv_key[0*32 +: 32] = gen_tcam_row_13_col_0_tcam.ip783tcam64x32s0c1_wrap_tcam_row_13_col_0.tcam_row_13_col_0.ip783tcam64x32s0c1_gen_wrp_inst.ip783tcam64x32s0c1_inst.ip783tcam64x32s0c1_array.array_y[row_idx % 64];
                                    end
                                    1: begin
                                            //READ_data
                                             local_inv_key[1*32 +: 32] = gen_tcam_row_13_col_1_tcam.ip783tcam64x32s0c1_wrap_tcam_row_13_col_1.tcam_row_13_col_1.ip783tcam64x32s0c1_gen_wrp_inst.ip783tcam64x32s0c1_inst.ip783tcam64x32s0c1_array.array_y[row_idx % 64];
                                    end
                                    default : begin
                                       $error("SOMTING IS wrong with parameters given for col number %d ",j);
                                     end
              endcase
                      
        end // 13 
         14 :begin
         for (int j = 0;j < 2 ; j = j + 1) 
             case (j)
                                    0: begin
                                            //READ_data
                                             local_inv_key[0*32 +: 32] = gen_tcam_row_14_col_0_tcam.ip783tcam64x32s0c1_wrap_tcam_row_14_col_0.tcam_row_14_col_0.ip783tcam64x32s0c1_gen_wrp_inst.ip783tcam64x32s0c1_inst.ip783tcam64x32s0c1_array.array_y[row_idx % 64];
                                    end
                                    1: begin
                                            //READ_data
                                             local_inv_key[1*32 +: 32] = gen_tcam_row_14_col_1_tcam.ip783tcam64x32s0c1_wrap_tcam_row_14_col_1.tcam_row_14_col_1.ip783tcam64x32s0c1_gen_wrp_inst.ip783tcam64x32s0c1_inst.ip783tcam64x32s0c1_array.array_y[row_idx % 64];
                                    end
                                    default : begin
                                       $error("SOMTING IS wrong with parameters given for col number %d ",j);
                                     end
              endcase
                      
        end // 14 
         15 :begin
         for (int j = 0;j < 2 ; j = j + 1) 
             case (j)
                                    0: begin
                                            //READ_data
                                             local_inv_key[0*32 +: 32] = gen_tcam_row_15_col_0_tcam.ip783tcam64x32s0c1_wrap_tcam_row_15_col_0.tcam_row_15_col_0.ip783tcam64x32s0c1_gen_wrp_inst.ip783tcam64x32s0c1_inst.ip783tcam64x32s0c1_array.array_y[row_idx % 64];
                                    end
                                    1: begin
                                            //READ_data
                                             local_inv_key[1*32 +: 32] = gen_tcam_row_15_col_1_tcam.ip783tcam64x32s0c1_wrap_tcam_row_15_col_1.tcam_row_15_col_1.ip783tcam64x32s0c1_gen_wrp_inst.ip783tcam64x32s0c1_inst.ip783tcam64x32s0c1_array.array_y[row_idx % 64];
                                    end
                                    default : begin
                                       $error("SOMTING IS wrong with parameters given for col number %d ",j);
                                     end
              endcase
                      
        end // 15 
         16 :begin
         for (int j = 0;j < 2 ; j = j + 1) 
             case (j)
                                    0: begin
                                            //READ_data
                                             local_inv_key[0*32 +: 32] = gen_tcam_row_16_col_0_tcam.ip783tcam64x32s0c1_wrap_tcam_row_16_col_0.tcam_row_16_col_0.ip783tcam64x32s0c1_gen_wrp_inst.ip783tcam64x32s0c1_inst.ip783tcam64x32s0c1_array.array_y[row_idx % 64];
                                    end
                                    1: begin
                                            //READ_data
                                             local_inv_key[1*32 +: 32] = gen_tcam_row_16_col_1_tcam.ip783tcam64x32s0c1_wrap_tcam_row_16_col_1.tcam_row_16_col_1.ip783tcam64x32s0c1_gen_wrp_inst.ip783tcam64x32s0c1_inst.ip783tcam64x32s0c1_array.array_y[row_idx % 64];
                                    end
                                    default : begin
                                       $error("SOMTING IS wrong with parameters given for col number %d ",j);
                                     end
              endcase
                      
        end // 16 
         17 :begin
         for (int j = 0;j < 2 ; j = j + 1) 
             case (j)
                                    0: begin
                                            //READ_data
                                             local_inv_key[0*32 +: 32] = gen_tcam_row_17_col_0_tcam.ip783tcam64x32s0c1_wrap_tcam_row_17_col_0.tcam_row_17_col_0.ip783tcam64x32s0c1_gen_wrp_inst.ip783tcam64x32s0c1_inst.ip783tcam64x32s0c1_array.array_y[row_idx % 64];
                                    end
                                    1: begin
                                            //READ_data
                                             local_inv_key[1*32 +: 32] = gen_tcam_row_17_col_1_tcam.ip783tcam64x32s0c1_wrap_tcam_row_17_col_1.tcam_row_17_col_1.ip783tcam64x32s0c1_gen_wrp_inst.ip783tcam64x32s0c1_inst.ip783tcam64x32s0c1_array.array_y[row_idx % 64];
                                    end
                                    default : begin
                                       $error("SOMTING IS wrong with parameters given for col number %d ",j);
                                     end
              endcase
                      
        end // 17 
         18 :begin
         for (int j = 0;j < 2 ; j = j + 1) 
             case (j)
                                    0: begin
                                            //READ_data
                                             local_inv_key[0*32 +: 32] = gen_tcam_row_18_col_0_tcam.ip783tcam64x32s0c1_wrap_tcam_row_18_col_0.tcam_row_18_col_0.ip783tcam64x32s0c1_gen_wrp_inst.ip783tcam64x32s0c1_inst.ip783tcam64x32s0c1_array.array_y[row_idx % 64];
                                    end
                                    1: begin
                                            //READ_data
                                             local_inv_key[1*32 +: 32] = gen_tcam_row_18_col_1_tcam.ip783tcam64x32s0c1_wrap_tcam_row_18_col_1.tcam_row_18_col_1.ip783tcam64x32s0c1_gen_wrp_inst.ip783tcam64x32s0c1_inst.ip783tcam64x32s0c1_array.array_y[row_idx % 64];
                                    end
                                    default : begin
                                       $error("SOMTING IS wrong with parameters given for col number %d ",j);
                                     end
              endcase
                      
        end // 18 
                 endcase //(row_idx/64)
                 inv_key = TCAM_18A ? ~local_inv_key : ~local_inv_key; 
             `endif
       endtask // END read_tcam_raw_inv_key
       
       task automatic read_tcam_raw_line (output logic[60-1:0] key, output logic [60-1:0] inv_key, input int row_idx);
          read_tcam_raw_key(key, row_idx);
          read_tcam_raw_inv_key(inv_key, row_idx);
       endtask // END write_tcam_raw_line
       
       `endif //FEV_APPROVE_SIM_ONLY
    `endif  //INTEL_SIMONLY
    

endmodule
