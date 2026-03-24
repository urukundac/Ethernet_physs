//------------------------------------------------------------------------------
//  INTEL TOP SECRET
//
//  Copyright 2018 Intel Corporation All Rights Reserved.
//
//  The source code contained or described herein and all documents related
//  to the source code ("Material") are owned by Intel Corporation or its
//  suppliers or licensors. Title to the Material remains with Intel
//  Corporation or its suppliers and licensors. The Material contains trade
//  secrets and proprietary and confidential information of Intel or its
//  suppliers and licensors. The Material is protected by worldwide copyright
//  and trade secret laws and treaty provisions. No part of the Material may
//  be used, copied, reproduced, modified, published, uploaded, posted,
//  transmitted, distributed, or disclosed in any way without Intel's prior
//  express written permission.
//
//  No license under any patent, copyright, trade secret or other intellectual
//  property right is granted to or conferred upon you by disclosure or
//  delivery of the Materials, either expressly, by implication, inducement,
//  estoppel or otherwise. Any license under such intellectual property rights
//  must be express and approved by Intel in writing.
//  Inserted by Intel DSD.
//
//------------------------------------------------------------------------------
//----------------------------------------------------------------------------//
//    Copyright 2018 Intel Corporation All Rights Reserved.
//    Intel Communication Group/ Platform Network Group / ICGh
//    Intel Proprietary
//
//       *               *     
//     (  `    (       (  `    
//     )\))(   )\ )    )\))(   
//    ((_)()\ (()/(   ((_)()\  
//    (_()((_) /(_))_ (_()((_) 
//    |  \/  |(_)) __||  \/  | 
//    | |\/| |  | (_ || |\/| | 
//    |_|  |_|   \___||_|  |_|
//
//    FILENAME  : mgm_master_tcam_shell.v
//    DESIGNER  : Yevgeny Yankilevich
//    DATE      : 16/02/16
//    REVISION NUMBER   : 1.0
//    DESCRIPTION       :
//
//          Master Shell for TCAM
//
//---------------------------------------------------------------------------//
// --------------------------------------------------------------------------//
//      LAST MODIFICATION:      Feb 9th 2017
//      RECENT AUTHORS:        avi.costo@intel.com
//      PREVIOUS RELEASES:      
//                              16/02/16: First version.
//                              22/08/16: ACK and RDY I/F changes 
//                              Feb 9th 2017: fix sync issue of uncor_err indication  
// --------------------------------------------------------------------------//
`include        "hlp_mgm_mems.def"
module  hlp_mgm_master_tcam_shell #(
        parameter       TCAM_WIDTH                              = 40                                                                                                            , //
        parameter       TCAM_RULES_NUM                          = 512                                                                                                           , //
        parameter       TCAM_SLICE_SIZE                         = 64                                                                                                            , //
        parameter       TCAM_SLICE_EN_WIDTH                     = TCAM_RULES_NUM/TCAM_SLICE_SIZE                                                                                , //
        parameter       TCAM_RULES_NUM_WIDTH                    = (TCAM_RULES_NUM>1) ? $clog2(TCAM_RULES_NUM) : 1                                                               , //
        parameter       TCAM_DEPTH                              = 2*TCAM_RULES_NUM                                                                                              , //
        parameter       TCAM_ADDR_WIDTH                          = $clog2(TCAM_DEPTH)                                                                                            , //
        parameter       TCAM_INIT_TYPE                          = 0                                                                                                             , //
        parameter       TCAM_E0_INIT_VALUE                      = ~(TCAM_WIDTH'(0))                                                                                             , //
        parameter       TCAM_E1_INIT_VALUE                      = ~(TCAM_WIDTH'(0))                                                                                             , //
        parameter       TCAM_RD_DEBUG                           = 0                                                                                                             , //
        parameter       TCAM_PRIORITY_ENCDR                     = 0                                                                                                             , //
        parameter       TCAM_PRIORITY_ENCDR_ORDER               = 1                                                                                                             , //
        parameter       TCAM_INGRESS_SAMPLE                     = 0                                                                                                             , //
        parameter       TCAM_EGRESS_SAMPLE                      = 0                                                                                                             , //
        parameter       TCAM_DBG_DW_SEL_WIDTH                   = `HLP_TCAM_DBG_DW_SEL_WIDTH                                                                                        , //
        parameter       TCAM_DBG_RD_ADR_WIDTH                   = `HLP_TCAM_DBG_RD_ADR_WIDTH                                                                                        , //
        parameter       TCAM_ANALOG_TUNE_CONFG_WIDTH            = `HLP_TCAM_ANALOG_TUNE_CONFG_WIDTH                                                                         , //
        parameter       TCAM_CTL_SYNC                           = 0  ,
        parameter       BCAM_N7                                 = 0                                                                          , //
        parameter       FROM_CTL_WIDTH                          = TCAM_DBG_DW_SEL_WIDTH + TCAM_DBG_RD_ADR_WIDTH + TCAM_ANALOG_TUNE_CONFG_WIDTH + 9 + 2 + 1                       , //
        parameter       TO_CTL_WIDTH                            = 54                                                                                                            , //
        parameter       FROM_TCAM_WIDTH                         = TCAM_WIDTH + TCAM_RULES_NUM + 1 + 1 + 1 + 1 + 1 + 1 +1                                                       , //
        parameter       TO_TCAM_WIDTH                           = TCAM_SLICE_EN_WIDTH + 1 + TCAM_ANALOG_TUNE_CONFG_WIDTH + 3 + 1 + 1 + 1 + TCAM_ADDR_WIDTH + TCAM_WIDTH + 1 + 2*TCAM_WIDTH + TCAM_RULES_NUM  +2   //
)(
        //------------------- clock and reset -------------------
        input   logic                                   clk                     ,
        input   logic                                   reset_n                 ,
        input   logic                                   sync_reset_n            ,
        //----------------- Functional Interface ----------------
        input   logic   [      TCAM_ADDR_WIDTH-1:0]      adr                     ,
        input   logic                                   wr_en                   ,
        input   logic   [          TCAM_WIDTH-1:0]      wr_data                 ,
        input   logic                                   chk_en                  ,
        input   logic   [          TCAM_WIDTH-1:0]      chk_key                 ,
        input   logic   [          TCAM_WIDTH-1:0]      chk_mask                ,
        input   logic                                   flush                   ,
        input   logic   [ TCAM_SLICE_EN_WIDTH-1:0]      slice_en                ,       
        input   logic   [      TCAM_RULES_NUM-1:0]      raw_hit_in              ,
        output  logic   [      TCAM_RULES_NUM-1:0]      raw_hit_out             ,
        output  logic   [TCAM_RULES_NUM_WIDTH-1:0]      rule_hit_num            ,
        output  logic                                   rule_hit_num_vld        ,
        input   logic                                   rd_en                   ,
        output  logic   [          TCAM_WIDTH-1:0]      rd_data                 ,
        output  logic                                   tcam_rd_valid           ,
        output  logic                                   tcam_chk_valid          ,
        output  logic                                   tcam_rdwr_rdy           ,
        output  logic                                   tcam_chk_rdy            ,
        output  logic                                   init_done               ,
        //--------------------- ECC Interface -------------------
        input   logic                                   chk_for_err_trig        ,
        output  logic                                   ecc_uncor_err           ,
        //----------------- TCAM Wrap Interface -----------------
        input   logic   [      FROM_TCAM_WIDTH-1:0]     wrap_shell_from_tcam    ,
        output  logic   [        TO_TCAM_WIDTH-1:0]     wrap_shell_to_tcam      ,
        //------------------- Gen CTR Interface -----------------
        input   logic   [      FROM_CTL_WIDTH-1:0]      ctl_shell_to_tcam       ,
        output  logic   [        TO_CTL_WIDTH-1:0]      ctl_shell_from_tcam     
);

//-------------------------------
//      Gen MEM Interface
//-------------------------------

 `ifndef INTEL_SVA_OFF
    import intel_checkers_pkg::*;   
 `endif
    


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
        logic                                                   tcam_check_err_dis       ;
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

//-------------------------------
//      Gen CTL Interface
//-------------------------------

//typedef struct packed{
//      logic                                                   cfg_wr_ind              ;
//      logic   [        TCAM_ANALOG_TUNE_CONFG_WIDTH-1:0]      analog_tune_confg       ;
//      logic                                                   dbg_wr_ind              ;
//      logic                                                   dbg_rd_en               ;
//      logic   [               TCAM_DBG_RD_ADR_WIDTH-1:0]      dbg_adr                 ;
//      logic   [               TCAM_DBG_DW_SEL_WIDTH-1:0]      dbg_dw_sel              ;
//} from_ctl_t;

typedef struct packed{                                                          
        logic                                                   cfg_wr_ind      ;
        logic                                                   stat_rd_ind     ;               
        logic                                                   ecc_en          ;
        logic                                                   ecc_invert_1    ;
        logic                                                   ecc_invert_2    ;
        logic   [                                    7-1:0]     gen_ecc_inst_num;
        // logic                                                   pwren_b         ; 
        logic                                                   rm_e            ;
        logic   [                                    4-1:0]     rm              ;
        logic                                                   ls_bypass       ;
        logic                                                   ls_force        ;
        logic                                                   dbg_wr_ind      ;
        logic                                                   dbg_rd_en       ;
        logic   [                 TCAM_DBG_RD_ADR_WIDTH-1:0]    dbg_adr         ;
        logic   [                 TCAM_DBG_DW_SEL_WIDTH-1:0]    dbg_dw_sel      ;
        logic                                                   tcam_check_err_dis   ;
        logic                                                   tcam_update_dis ;


} from_ctl_t;

typedef struct packed{
        logic                                                   ecc_uncor_err   ;
        logic                                                   ecc_cor_err     ;
        logic                                                   init_done       ;
        logic   [                                   32-1:0]     dbg_rd_data     ;
        logic                                                   dbg_done        ;
        logic   [                 TCAM_DBG_RD_ADR_WIDTH-1:0]    ecc_err_adr     ;
} to_ctl_t;

from_ctl_t      from_ctl_bus    ;
to_ctl_t        to_ctl_bus      ;

// Debug Read

logic                                           dbg_flow                        ;
logic                                           dbg_rd_en                       ;
logic    [TCAM_DBG_DW_SEL_WIDTH-1:0]            dbg_dw_sel                      ;
logic    [32-1:0]                               dbg_rd_data                     ;
logic                                           dbg_done                        ;
logic                                           dbg_done_s                      ;
wire                                            dbg_rd_valid                    ;
logic                                           tcam_rd_valid_int               ;
logic                                           tcam_chk_valid_int              ;
logic                                           tcam_rdwr_rdy_int               ;
logic                                           tcam_chk_rdy_int                ;
logic   [TCAM_WIDTH-1:0]                        rd_data_int                     ;

// From CTL

logic    [TCAM_ANALOG_TUNE_CONFG_WIDTH-1:0]     tcam_analog_tune_confg          ;
logic                                           tcam_ecc_en                     ;
logic                                           tcam_ecc_invert_1               ;
logic                                           tcam_ecc_invert_2               ;
logic                                           tcam_ls_bypass                  ;
logic                                           tcam_ls_force                   ;
logic                                           tcam_tcam_check_err_dis         ;
logic                                           tcam_tcam_update_dis            ;
logic                                           dbg_rd_en_int                   ;
logic   [TCAM_DBG_RD_ADR_WIDTH-1:0]             dbg_adr_int                     ;
logic   [TCAM_DBG_DW_SEL_WIDTH-1:0]             dbg_dw_sel_int                  ;
logic                                           dbg_flow_no_func_acc            ;
assign                                          dbg_flow_no_func_acc    = dbg_flow && !(rd_en || wr_en || chk_en)       ;
assign                                          from_ctl_bus            = ctl_shell_to_tcam                             ;




logic                                                           ecc_uncor_err_pulse  ;
logic                                                           ecc_uncor_err_ltch  ;

logic                                   init_done_int                           ;
logic   [     TCAM_ADDR_WIDTH-1:0]       adr_mux, aux_adr                        ;
logic   [         TCAM_WIDTH-1:0]       chk_key_mux, chk_mask_mux               ;
logic   [TCAM_SLICE_EN_WIDTH-1:0]       slice_en_mux                            ;
logic   [     TCAM_RULES_NUM-1:0]       raw_hit_in_mux                          ;
logic                                   rd_en_mux, wr_en_mux, chk_en_mux,flush_mux  ;
logic   [         TCAM_WIDTH-1:0]       wr_data_mux                             ;

logic                           tcam_rd_in_prcs                         ;
logic                           tcam_wr_in_prcs                         ;
logic                           tcam_chk_in_prcs                        ;
logic                           tcam_init_wr_en                         ;




generate
        if (TCAM_CTL_SYNC) begin: FROM_CTL_SYNC
                logic   [2-1:0]                 from_ctl_bus_pre_sync;
                logic   [2-1:0]                 from_ctl_bus_pst_sync;
                assign                          from_ctl_bus_pre_sync[0]        = from_ctl_bus.cfg_wr_ind       ;
                assign                          from_ctl_bus_pre_sync[1]        = from_ctl_bus.dbg_wr_ind       ;               
                hlp_mgm_sync_ta2pb  #(
                        .BUS_WIDTH    (2)
                ) from_ctl_bus_sync(
                        .clkb           (clk)                           , 
                        .rst_n_b        (sync_reset_n)                  ,
                        .toggle_in      (from_ctl_bus_pre_sync)         ,        
                        .pulse_out      (from_ctl_bus_pst_sync)
                );
                logic                           cfg_wr_ind;
                logic                           dbg_wr_ind;
                assign                          cfg_wr_ind      = from_ctl_bus_pst_sync[0]      ;
                assign                          dbg_wr_ind      = from_ctl_bus_pst_sync[1]      ;
                
                assign                          tcam_analog_tune_confg[TCAM_ANALOG_TUNE_CONFG_WIDTH-1:0] = {{(TCAM_ANALOG_TUNE_CONFG_WIDTH-12){1'b0}}, 12'h9C4} ;
                always_ff  @(posedge clk or negedge reset_n)
                        if (!reset_n) begin
                                tcam_ecc_en             <= 1'b1                                 ;
                                tcam_ecc_invert_1       <= 1'b0                                 ;
                                tcam_ecc_invert_2       <= 1'b0                                 ;
                                tcam_ls_bypass          <= 1'b1                                 ;
                                tcam_ls_force           <= 1'b0                                 ;
                                tcam_tcam_check_err_dis <= 1'b0                                 ;
                                tcam_tcam_update_dis    <= 1'b0                                 ;
                        end
                        else if (cfg_wr_ind) begin
                                tcam_ecc_en             <= from_ctl_bus.ecc_en                  ;
                                tcam_ecc_invert_1       <= from_ctl_bus.ecc_invert_1            ;
                                tcam_ecc_invert_2       <= from_ctl_bus.ecc_invert_2            ;
                                tcam_ls_bypass          <= from_ctl_bus.ls_bypass               ;
                                tcam_ls_force           <= from_ctl_bus.ls_force                ;               

                                tcam_tcam_check_err_dis <= from_ctl_bus.tcam_check_err_dis      ;               
                                tcam_tcam_update_dis    <= from_ctl_bus.tcam_update_dis         ;               
                        end
                
                always_ff  @(posedge clk or negedge reset_n)
                        if (!reset_n) begin
                                dbg_rd_en_int           <= 1'b0                                 ;
                                dbg_adr_int             <= {(TCAM_DBG_RD_ADR_WIDTH){1'b0}}      ;
                                dbg_dw_sel_int          <= {(TCAM_DBG_DW_SEL_WIDTH){1'b0}}      ;       
                        end
                        else if (dbg_wr_ind) begin
                                dbg_rd_en_int           <= from_ctl_bus.dbg_rd_en               ;
                                dbg_adr_int             <= from_ctl_bus.dbg_adr                 ;
                                dbg_dw_sel_int          <= from_ctl_bus.dbg_dw_sel              ;
                        end
                        else begin
                                dbg_rd_en_int           <= 1'b0                                 ;
                        end
                
        end
        else begin: FROM_CTL_NO_SYNC
                assign          tcam_analog_tune_confg[TCAM_ANALOG_TUNE_CONFG_WIDTH-1:0]                = {{(TCAM_ANALOG_TUNE_CONFG_WIDTH-12){1'b0}}, 12'h9C4}  ;
                assign          tcam_ecc_en             = from_ctl_bus.ecc_en                   ;
                assign          tcam_ecc_invert_1       = from_ctl_bus.ecc_invert_1             ;
                assign          tcam_ecc_invert_2       = from_ctl_bus.ecc_invert_2             ;
                assign          tcam_ls_bypass          = from_ctl_bus.ls_bypass                ;
                assign          tcam_ls_force           = from_ctl_bus.ls_force                 ;
                assign          tcam_tcam_check_err_dis = from_ctl_bus.tcam_check_err_dis       ;               
                assign          tcam_tcam_update_dis    = from_ctl_bus.tcam_update_dis          ;               

                assign          dbg_rd_en_int                                   = from_ctl_bus.dbg_rd_en                ;
                assign          dbg_adr_int        [TCAM_DBG_RD_ADR_WIDTH-1:0]  = from_ctl_bus.dbg_adr                  ;
                assign          dbg_dw_sel_int     [TCAM_DBG_DW_SEL_WIDTH-1:0]  = from_ctl_bus.dbg_dw_sel               ;
        end
endgenerate

// To CTL

wire    [2-1:0]                 to_ctl_bus_pre_sync  ;
assign                          to_ctl_bus_pre_sync     = {dbg_done_s, ecc_uncor_err_pulse};
logic   [2-1:0]                 to_ctl_bus_pst_sync;
generate
       if (TCAM_CTL_SYNC) begin: TO_CTL_SYNC
                hlp_mgm_sync_pa2ta  #(
                        .BUS_WIDTH      (2)
                ) to_ctl_bus_sync(
                        .clka           (clk)                   ,
                        .rst_n_a        (sync_reset_n)          ,
                        .pulse_in       (to_ctl_bus_pre_sync)   ,
                        .toggle_out     (to_ctl_bus_pst_sync)   
                );
        end
        else begin: TO_CTL_NO_SYNC
           
            // MGM 1.35 - current control shell always get toggle indication. Temporarily adjsuting the master shell 
            //  assign  to_ctl_bus_pst_sync = to_ctl_bus_pre_sync;
            always_ff @(posedge clk or negedge reset_n)
             begin 
               if (~reset_n) 
                 to_ctl_bus_pst_sync <= {(2){1'b0}}; 
               else 
                 to_ctl_bus_pst_sync <= to_ctl_bus_pst_sync ^ to_ctl_bus_pre_sync ;
             end    
           
           
           
           
           
        end
endgenerate

assign                          to_ctl_bus.ecc_uncor_err        = to_ctl_bus_pst_sync[0]        ;
assign                          to_ctl_bus.ecc_err_adr          = {TCAM_DBG_RD_ADR_WIDTH{1'b0}} ;
assign                          to_ctl_bus.ecc_cor_err          = 1'b0                          ;
assign                          to_ctl_bus.init_done            = init_done                     ;
assign                          to_ctl_bus.dbg_rd_data          = dbg_rd_data                   ;
assign                          to_ctl_bus.dbg_done             = to_ctl_bus_pst_sync[1]        ;
assign                          ctl_shell_from_tcam             = to_ctl_bus                    ;

generate
        if (TCAM_RD_DEBUG == 1) begin: TCAM_RD_DEBUG_LOGIC
                always_ff  @(posedge clk or negedge reset_n)
                        if (!reset_n) begin
                                dbg_flow        <= 1'b0;
                                dbg_rd_en       <= 1'b0;
                                dbg_dw_sel      <= {(TCAM_DBG_DW_SEL_WIDTH){1'b0}};
                        end
                        else if (dbg_rd_en_int && !(rd_en || wr_en || chk_en) && !dbg_flow) begin
                                dbg_flow        <= 1'b1;
                                dbg_rd_en       <= 1'b1;
                                dbg_dw_sel      <= dbg_dw_sel_int;
                        end
                        else if (dbg_rd_en && (rd_en || |wr_en || chk_en)) begin
                                dbg_flow        <= 1'b0;
                                dbg_rd_en       <= 1'b0;                                        
                        end
                        else if (dbg_rd_en && dbg_flow) begin
                                dbg_rd_en       <= 1'b0;
                        end
                        else if (dbg_done) begin
                                dbg_flow        <= 1'b0;
                        end
                
                logic   [(32*(1 << TCAM_DBG_DW_SEL_WIDTH))-1:0] dbg_rd_data_dw_full                                     ;
                logic   [                            32 - 1:0] dbg_rd_data_dw_full_2d[(1 << TCAM_DBG_DW_SEL_WIDTH)-1:0] ;

                always_comb begin
                        dbg_rd_data_dw_full     = {{(32*(1 << TCAM_DBG_DW_SEL_WIDTH) - TCAM_WIDTH){1'b0}}, {rd_data_int}}       ;
                        for(int k = 0; k < (1 << TCAM_DBG_DW_SEL_WIDTH); k = k + 1)
                                dbg_rd_data_dw_full_2d[k]       = dbg_rd_data_dw_full[32*k+:32]                         ;
                end
                
                 hlp_mgm_fifo #(
                                .WIDTH  (1)         ,
                                .ADD_L  (2)                     
                            ) 
                        u_dbg_rd_fifo(
                                .clk            (clk)            ,
                                .rst_n          (reset_n)        ,
                                .d_out          (dbg_rd_valid)      ,
                                .d_in           (dbg_rd_en & !rd_en)         ,
                                .rd             (tcam_rd_valid_int) ,
                                .wr             (rd_en_mux)   ,
                                .empty          ()                  ,
                                .full           ()                  ,
                                .state_cnt      ()                      
                        );


                assign  dbg_done                = tcam_rd_valid_int && dbg_flow   && dbg_rd_valid               ;

                   always_ff   @(posedge clk or negedge reset_n)
                                if (!reset_n) begin
                                        dbg_rd_data        <= 0;
                                end
                                else if (dbg_done) begin
                                        dbg_rd_data        <= dbg_rd_data_dw_full_2d[dbg_dw_sel[TCAM_DBG_DW_SEL_WIDTH-1:0]]  ;
                                end    
        end
        else begin: TCAM_NO_RD_DEBUG_LOGIC
                always_comb
                                begin
                                        dbg_flow                        = 1'b0  ;
                                        dbg_rd_en                       = 1'b0  ;
                                        dbg_dw_sel                      = {(TCAM_DBG_DW_SEL_WIDTH){1'b0}};
                                end     

                        assign  dbg_done                = 1'b0                                                          ;
                        assign  dbg_rd_data             = 32'h0                                                         ;
                        assign  dbg_rd_valid            = 1'b0                                                          ;
        end
endgenerate

 
 
//-----------------------------------
//      Function Interface MUXs
//-----------------------------------



reg    [4:0]    inner_ls_delay;
always_ff @(posedge clk,negedge reset_n)
if (!reset_n)
       inner_ls_delay[4:0]   <= 5'h0;
else  
       inner_ls_delay[4:0]   <= (inner_ls_delay[4:0] == 5'h10) ? inner_ls_delay[4:0] : inner_ls_delay[4:0] + 5'h1;
logic            inner_ls_delay_comp;
assign           inner_ls_delay_comp    = inner_ls_delay[4];

always_ff   @(posedge clk or negedge reset_n)
   if (!reset_n) begin
            dbg_done_s          <= 1'b0;
   end
   else begin
            dbg_done_s          <= dbg_done;
   end


always_ff @(posedge clk or negedge reset_n)
   if (!reset_n)
      tcam_init_wr_en <= 1'b0;
   else if (tcam_init_wr_en)
      tcam_init_wr_en <= 1'b0;
   else if (!init_done && tcam_rdwr_rdy_int & inner_ls_delay_comp)
      tcam_init_wr_en <= 1'b1;

assign  wr_en_mux       = init_done                     ? wr_en         : tcam_init_wr_en                                       ;
assign  rd_en_mux       = (dbg_flow_no_func_acc)        ? dbg_rd_en     : rd_en                                                 ;

// Initialization & Debug Read




generate
        if (TCAM_INIT_TYPE == 1) begin: CONST_TCAM_INIT
                        assign  adr_mux         = (dbg_flow_no_func_acc || !init_done) ? aux_adr : adr                  ;
                        assign  wr_data_mux     = (init_done) ? wr_data : 
                                                  (!adr_mux[0])? TCAM_E0_INIT_VALUE : TCAM_E1_INIT_VALUE                 ;

                        always_ff  @(posedge clk or negedge reset_n)
                                if (!reset_n) begin
                                        aux_adr         <= TCAM_ADDR_WIDTH'(TCAM_DEPTH - 1);
                                        init_done_int   <= 1'b0;
                                end
                                else if (init_done) begin
                                        if (dbg_rd_en_int && !(rd_en || wr_en || chk_en) && !dbg_flow)
                                                aux_adr <= dbg_adr_int[TCAM_ADDR_WIDTH-1:0];
                                end
                                else if (tcam_init_wr_en) begin
                                        aux_adr         <= (aux_adr == {(TCAM_ADDR_WIDTH){1'b0}}) ? {(TCAM_ADDR_WIDTH){1'b0}} : aux_adr - {{(TCAM_ADDR_WIDTH-1){1'b0}},1'b1};
                                        init_done_int   <= (aux_adr == {(TCAM_ADDR_WIDTH){1'b0}}) || init_done_int;
                                end
        end
        else if (TCAM_RD_DEBUG == 1) begin: NO_TCAM_INIT_RD_DEBUG
                assign  adr_mux         = (dbg_flow_no_func_acc) ? aux_adr : adr        ;
                assign  wr_data_mux     = wr_data                                       ;

                always_ff  @(posedge clk or negedge reset_n)
                        if (!reset_n) begin
                                aux_adr <= {(TCAM_ADDR_WIDTH){1'b0}};
                        end
                        else if (dbg_rd_en_int && !(rd_en || wr_en || chk_en) && !dbg_flow) begin
                                aux_adr <= dbg_adr_int[TCAM_ADDR_WIDTH-1:0];
                        end

                assign  init_done_int   = inner_ls_delay_comp;
        end
        else begin: NO_TCAM_INIT_NO_RD_DEBUG
                assign  adr_mux         = adr                           ;
                assign  wr_data_mux     = wr_data                       ;
                assign  aux_adr         = {(TCAM_ADDR_WIDTH){1'b0}}      ;
                assign  init_done_int   = inner_ls_delay_comp                          ;
        end
endgenerate

`ifdef INTEL_SIMONLY
//         `ifdef INTEL_DC
//                 "ERROR, do not use this code for DC"
//         `endif
    `ifndef HLP_FEV_APPROVE_SIM_ONLY
        assign init_done = ($test$plusargs("HLP_FAST_CONFIG")) ? inner_ls_delay_comp : init_done_int;
    `else
        assign init_done = init_done_int;
    `endif

`else
        assign init_done = init_done_int;
`endif

// To TCAM Path Sample

logic                                           rd_en_to_tcam, wr_en_to_tcam, chk_en_to_tcam, flush_to_tcam;
logic   [               TCAM_ADDR_WIDTH-1:0]     adr_to_tcam                                     ;
logic   [                   TCAM_WIDTH-1:0]     chk_key_to_tcam, chk_mask_to_tcam               ;
logic   [          TCAM_SLICE_EN_WIDTH-1:0]     slice_en_to_tcam                                ;
logic   [                   TCAM_WIDTH-1:0]     wr_data_to_tcam                                 ;
logic   [               TCAM_RULES_NUM-1:0]     raw_hit_in_to_tcam                              ;

generate
        if (TCAM_INGRESS_SAMPLE == 1) begin: TCAM_INGRESS_SAMPLE_NO_CLKG
                always_ff  @(posedge clk or negedge reset_n)
                        if (!reset_n) begin
                                rd_en_to_tcam                   <= 1'b0                 ;
                                wr_en_to_tcam                   <= 1'b0                 ;
                                chk_en_to_tcam                  <= 1'b0                 ;
                                flush_to_tcam                   <= 1'b0                 ;
                        end
                        else begin
                                rd_en_to_tcam                   <= rd_en_mux            ;
                                wr_en_to_tcam                   <= wr_en_mux            ;
                                chk_en_to_tcam                  <= chk_en_mux           ;
                                flush_to_tcam                   <= flush_mux            ;
                        end

                        always_ff  @(posedge clk) begin
                                adr_to_tcam                     <= adr_mux              ;
                                chk_key_to_tcam                 <= chk_key_mux          ;
                                chk_mask_to_tcam                <= chk_mask_mux         ;
                                slice_en_to_tcam                <= slice_en_mux         ;
                                wr_data_to_tcam                 <= wr_data_mux          ;
                                raw_hit_in_to_tcam              <= raw_hit_in_mux       ;
                        end
        end
        else if (TCAM_INGRESS_SAMPLE == 2) begin: TCAM_INGRESS_SAMPLE_CLKG
                always_ff  @(posedge clk or negedge reset_n)
                        if (!reset_n) begin
                                rd_en_to_tcam                   <= 1'b0                 ;
                                wr_en_to_tcam                   <= 1'b0                 ;
                                chk_en_to_tcam                  <= 1'b0                 ;
                                flush_to_tcam                   <= 1'b0                 ;
                        end
                        else begin
                                rd_en_to_tcam                   <= rd_en_mux            ;
                                wr_en_to_tcam                   <= wr_en_mux            ;
                                chk_en_to_tcam                  <= chk_en_mux           ;
                                flush_to_tcam                   <= flush_mux            ;
                        end

                always_ff  @(posedge clk) begin
                        if (rd_en_mux || wr_en_mux) begin
                                adr_to_tcam                     <= adr_mux              ;                       
                        end
                        
                        if (wr_en_mux) begin
                                wr_data_to_tcam                 <= wr_data_mux          ;
                        end

                        if (chk_en_mux) begin
                                chk_key_to_tcam                 <= chk_key_mux          ;
                                chk_mask_to_tcam                <= chk_mask_mux         ;
                                slice_en_to_tcam                <= slice_en_mux         ;
                                raw_hit_in_to_tcam              <= raw_hit_in_mux       ;
                        end
                end
        end
        else begin: TCAM_INGRESS_NO_SAMPLE
                always_comb begin
                        rd_en_to_tcam           = rd_en_mux             ;
                        wr_en_to_tcam           = wr_en_mux             ;
                        chk_en_to_tcam          = chk_en_mux            ;
                        adr_to_tcam             = adr_mux               ;
                        wr_data_to_tcam         = wr_data_mux           ;
                        chk_key_to_tcam         = chk_key_mux           ;
                        chk_mask_to_tcam        = chk_mask_mux          ;
                        slice_en_to_tcam        = slice_en_mux          ;
                        raw_hit_in_to_tcam      = raw_hit_in_mux        ;
                        flush_to_tcam           = flush_mux             ;
                end
        end
endgenerate

//-------------------------------
//     TO_TCAM Bus Assembly
//-------------------------------
        assign  to_tcam_bus.reset_n             = reset_n               ;
        assign  to_tcam_bus.analog_tune_confg   = tcam_analog_tune_confg; 
        assign  to_tcam_bus.init_done           = init_done             ;
        assign  to_tcam_bus.ecc_en              = tcam_ecc_en           ;
        assign  to_tcam_bus.ecc_invert_1        = tcam_ecc_invert_1     ;
        assign  to_tcam_bus.ecc_invert_2        = tcam_ecc_invert_2     ;
        assign  to_tcam_bus.rd_en               = rd_en_to_tcam         ;
        assign  to_tcam_bus.wr_en               = wr_en_to_tcam         ;
        assign  to_tcam_bus.adr                 = adr_to_tcam           ;
        assign  to_tcam_bus.wr_data             = wr_data_to_tcam       ;
        assign  to_tcam_bus.chk_en              = chk_en_to_tcam        ;
        assign  to_tcam_bus.chk_key             = chk_key_to_tcam       ;  
        assign  to_tcam_bus.chk_mask            = chk_mask_to_tcam      ;
        assign  to_tcam_bus.flush               = flush_to_tcam         ;
        assign  to_tcam_bus.slice_en            = slice_en_to_tcam      ;
        assign  to_tcam_bus.raw_hit_in          = raw_hit_in_to_tcam    ; 
        assign  to_tcam_bus.tcam_check_err_dis  = tcam_tcam_check_err_dis; 
        assign  to_tcam_bus.tcam_update_dis     = tcam_tcam_update_dis  ; 
        assign  wrap_shell_to_tcam              = to_tcam_bus           ;

//-------------------------------
//   FROM_TCAM Bus Disassembly
//-------------------------------
logic                                           wrap_shell_rd_valid     ;
logic                                           wrap_shell_wr_ack       ;       // This should be used once dbg wr is implemented
logic                                           wrap_shell_chk_valid    ;
logic                                           wrap_shell_rdwr_rdy     ;
logic                                           wrap_shell_chk_rdy      ;
logic   [                    TCAM_WIDTH-1:0]    wrap_shell_rd_data      ;
logic   [                TCAM_RULES_NUM-1:0]    wrap_shell_raw_hit_out  ;
logic                                           wrap_shell_ecc_err_det  ;

assign                                          from_tcam_bus           = wrap_shell_from_tcam          ;
assign                                          wrap_shell_rd_valid     = from_tcam_bus.tcam_rd_valid   ;
assign                                          wrap_shell_wr_ack       = from_tcam_bus.tcam_wr_ack     ;
assign                                          wrap_shell_chk_valid    = from_tcam_bus.tcam_chk_valid  ;
assign                                          wrap_shell_rdwr_rdy     = from_tcam_bus.tcam_rdwr_rdy   ;
assign                                          wrap_shell_chk_rdy      = from_tcam_bus.tcam_chk_rdy    ;
assign                                          wrap_shell_rd_data      = from_tcam_bus.rd_data         ;
assign                                          wrap_shell_raw_hit_out  = from_tcam_bus.raw_hit_out     ;
assign                                          wrap_shell_ecc_err_det  = from_tcam_bus.ecc_err_det     ;
assign                                          ecc_uncor_err           = wrap_shell_ecc_err_det        ;

logic                                                           tcam_rd_ack_fw          ;
logic                                                           tcam_wr_ack_fw          ;
logic                                                           tcam_chk_ack_fw         ;
logic                                                           tcam_rd_ack_from_tcam   ;
logic                                                           tcam_chk_ack_from_tcam  ;
logic   [                    TCAM_WIDTH-1:0]                    rd_data_from_tcam       ;
logic   [                TCAM_RULES_NUM-1:0]                    raw_hit_out_from_tcam   ;



 `ifndef INTEL_SVA_OFF

    `ASSERTS_TRIGGER (illegal_wen_ren, rd_en_to_tcam , ~wr_en_to_tcam , posedge clk, ~reset_n, `ERR_MSG ( "Error message REN and WEN are both asserted" ) ) ;
    `ASSERTS_TRIGGER (illegal_ren_ken, rd_en_to_tcam , ~chk_en_to_tcam, posedge clk, ~reset_n, `ERR_MSG ( "Error message REN and KEN are both asserted" ) ) ;
    `ASSERTS_TRIGGER (illegal_wen_ken, wr_en_to_tcam & ~BCAM_N7 , ~chk_en_to_tcam, posedge clk, ~reset_n, `ERR_MSG ( "Error message KEN and WEN are both asserted" ) ) ;


  `endif

`ifdef INTEL_SIMONLY
    `ifndef INTEL_SVA_OFF

     logic sva_err_check_en ; 
     logic sva_err_occurred_x ; 


     always  @(posedge reset_n)
     begin
        `ifndef HLP_FEV_APPROVE_SIM_ONLY
         if ($test$plusargs("HLP_UNC_ECC_ASSERT_DIS")) 
             sva_err_check_en = 0; 
         else
             sva_err_check_en = 1; 
        `else
           sva_err_check_en = 1; 
       `endif
     end
     always_comb  sva_err_occurred_x = (ecc_uncor_err !== 0) ; 

     `ASSERTS_NEVER (ecc_err_occurred_assert, sva_err_occurred_x & sva_err_check_en , posedge clk, ~reset_n,
             `ERR_MSG ("Error: ECC Error occurred when not expected"));

    `endif
`endif

always_ff  @(posedge clk or negedge reset_n)
        if (!reset_n) begin
                tcam_rd_ack_fw  <= 1'b0                                         ;
                tcam_wr_ack_fw  <= 1'b0                                         ;
                tcam_chk_ack_fw <= 1'b0                                         ;
                
        end
        else begin
                tcam_rd_ack_fw  <= (rd_en_to_tcam) ? 1'b1 : tcam_rd_ack_fw      ;
                tcam_wr_ack_fw  <= (wr_en_to_tcam) ? 1'b1 : tcam_wr_ack_fw      ;
                tcam_chk_ack_fw <= (chk_en_to_tcam)? 1'b1 : tcam_chk_ack_fw     ;
        end


// Upon error from TCAM assert single pulse until the next time ECC_en is toggled ( or block reset)

always_ff  @(posedge clk or negedge reset_n)
        if (!reset_n) begin
              ecc_uncor_err_pulse  <= 1'b0  ; 
              ecc_uncor_err_ltch  <= 1'b0  ; 
        end
        else begin

             ecc_uncor_err_pulse  <= ecc_uncor_err & ~ecc_uncor_err_pulse & ~ecc_uncor_err_ltch; 

             if (~tcam_ecc_en)              
                 ecc_uncor_err_ltch  <= 1'b0 ; 
             else 
                 ecc_uncor_err_ltch  <= ecc_uncor_err_ltch | ecc_uncor_err ; 
                          
              
        end



always_ff  @(posedge clk or negedge reset_n)
        if (!reset_n) begin
                tcam_rd_in_prcs         <= 1'b0 ;
                tcam_chk_in_prcs        <= 1'b0 ;
                tcam_wr_in_prcs         <= 1'b0 ;
        end
        else begin
                if (rd_en_to_tcam)
                        tcam_rd_in_prcs         <= 1'b1 ;
                else if (wrap_shell_rd_valid && tcam_rd_ack_fw)
                        tcam_rd_in_prcs         <= 1'b0 ;

                if (wr_en_to_tcam)
                        tcam_wr_in_prcs         <= 1'b1 ;
                else if (wrap_shell_wr_ack && tcam_wr_ack_fw)
                        tcam_wr_in_prcs         <= 1'b0 ;

                if (chk_en_to_tcam)
                        tcam_chk_in_prcs        <= 1'b1 ;
                else if (wrap_shell_chk_valid && tcam_chk_ack_fw)
                        tcam_chk_in_prcs        <= 1'b0 ;
        end

generate 
        if (TCAM_EGRESS_SAMPLE == 1) begin: TCAM_EGRESS_SAMPLE_NO_CLKG
                always_ff  @(posedge clk or negedge reset_n)
                        if (!reset_n) begin
                                tcam_chk_ack_from_tcam  <= 1'b0                                         ;
                        end
                        else begin
                                tcam_chk_ack_from_tcam  <= wrap_shell_chk_valid && tcam_chk_ack_fw      ;
                        end

                always_ff  @(posedge clk) begin
                        raw_hit_out_from_tcam           <= wrap_shell_raw_hit_out               ;
                end

                // No need to sample read data - it is already sampled in DFx Wrapper
                assign  tcam_rd_ack_from_tcam           = wrap_shell_rd_valid && tcam_rd_ack_fw ;
                assign  rd_data_from_tcam               = wrap_shell_rd_data                    ;
        end
        else if (TCAM_EGRESS_SAMPLE == 2) begin: TCAM_EGRESS_SAMPLE_CLKG
                always_ff  @(posedge clk or negedge reset_n)
                        if (!reset_n) begin
                                tcam_chk_ack_from_tcam  <= 1'b0                                         ;
                        end
                        else begin
                                tcam_chk_ack_from_tcam  <= wrap_shell_chk_valid && tcam_chk_ack_fw      ;
                        end

                always_ff  @(posedge clk)
                        if (wrap_shell_chk_valid && tcam_chk_ack_fw)
                                raw_hit_out_from_tcam           <= wrap_shell_raw_hit_out       ;

                // No need to sample read data - it is already sampled in DFx Wrapper
                assign  tcam_rd_ack_from_tcam           = wrap_shell_rd_valid && tcam_rd_ack_fw ;
                assign  rd_data_from_tcam               = wrap_shell_rd_data                    ;

        end
        else begin: TCAM_EGRESS_NO_SAMPLE
                always_comb begin
                        tcam_chk_ack_from_tcam          = wrap_shell_chk_valid && tcam_chk_ack_fw       ;
                        raw_hit_out_from_tcam           = wrap_shell_raw_hit_out                        ;                       
                        tcam_rd_ack_from_tcam           = wrap_shell_rd_valid && tcam_rd_ack_fw         ;
                        rd_data_from_tcam               = wrap_shell_rd_data                            ;
                end
        end
endgenerate


assign  tcam_rd_valid_int       = tcam_rd_ack_from_tcam ;
assign  tcam_chk_valid_int      = tcam_chk_ack_from_tcam;
assign  tcam_rdwr_rdy_int       = wrap_shell_rdwr_rdy   ;
assign  tcam_chk_rdy_int        = wrap_shell_chk_rdy    ;
assign  rd_data_int             = rd_data_from_tcam     ;
assign  raw_hit_out             = raw_hit_out_from_tcam ;

assign  tcam_rd_valid   = tcam_rd_valid_int && !dbg_rd_valid    ;
assign  tcam_chk_valid  = tcam_chk_valid_int                    ;
assign  tcam_rdwr_rdy   = tcam_rdwr_rdy_int && init_done        ;
assign  tcam_chk_rdy    = tcam_chk_rdy_int && init_done         ;
assign  rd_data         = rd_data_int                           ;

//-------------------------------
//      Priority Encoder      
//-------------------------------

generate
        if (TCAM_PRIORITY_ENCDR == 1) begin: PRIORITY_ENCDR
                logic   rule_hit_num_vld_int                                    ;
                hlp_mgm_gen_ffs #(
                        .INP_WDTH               (TCAM_RULES_NUM)                ,
                        .SRCH_DIR               (TCAM_PRIORITY_ENCDR_ORDER))
                priority_encdr(
                        .inp_vect               (raw_hit_out_from_tcam)         ,
                        .fs_idx                 (rule_hit_num)                  ,
                        .fs_vld                 (rule_hit_num_vld_int)
                );

                assign  rule_hit_num_vld = rule_hit_num_vld_int && tcam_chk_valid;
        end
        else begin: NO_PRIORITY_ENCDR
                always_comb begin
                        rule_hit_num            = {TCAM_RULES_NUM_WIDTH{1'b1}}  ;
                        rule_hit_num_vld        = 1'b0                          ;
                end
        end
endgenerate

//-------------------------------
//      Error Detection Mechanism      
//-------------------------------

assign  chk_en_mux      = chk_en                                                                                                ;
assign  flush_mux       = flush                                                                                                 ; 

assign  chk_key_mux     = chk_key                                                                                               ;
assign  chk_mask_mux    = chk_mask                                                                                              ;
assign  slice_en_mux    = slice_en                                                                                              ;
assign  raw_hit_in_mux  = raw_hit_in                                                                                            ;

endmodule//mgm_master_tcam_shell

