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
//    FILENAME          : mgm_tcam_col_sweeper.v
//    DESIGNER          : Yevgeny Yankilevich
//    DATE              : 16/02/16
//    REVISION NUMBER   : 1.0
//    DESCRIPTION       :
//
//          This module serves as a Soft Errors Column Sweeper in TCAMs
//
//---------------------------------------------------------------------------//
// --------------------------------------------------------------------------//
//      LAST MODIFICATION:      10/01/17
//      RECENT AUTHORS:         yevgeny.yankilevich@intel.com
//      PREVIOUS RELEASES:      
//                              11/07/16: First version.
//                              08/08/16: BCAM Support added.
//                              25/08/16: Alignment to the new TCAM delays.
//                              30/10/16: Rate Limiting for sweeper.
//                              10/01/17: Functional fix.
// --------------------------------------------------------------------------//
`include        "hlp_mgm_mems.def"
module hlp_mgm_tcam_col_sweeper #(
        parameter TCAM_CHK_DELAY                = 2                             ,
        parameter TCAM_RULES_NUM                = 512                           ,
        parameter TCAM_DEPTH                    = 2*TCAM_RULES_NUM              ,
        parameter TCAM_ADDR_WIDTH               = $clog2(TCAM_DEPTH)            ,
        parameter TCAM_WIDTH                    = 40                            ,
        parameter TCAM_WIDTH_LOG                = $clog2(TCAM_WIDTH)            ,
        parameter TCAM_SLICE_EN_WIDTH           = 8                             ,
        parameter BCAM_RELIEF                   = 0                             ,
        parameter TCAM_PROTECTION_RL            = 4096                          ,
        parameter TCAM_PROTECTION_RL_WIDTH      = (2**($clog2(TCAM_PROTECTION_RL)) == TCAM_PROTECTION_RL) ? ($clog2(TCAM_PROTECTION_RL) + 1) : $clog2(TCAM_PROTECTION_RL),
        parameter TCAM_PROTECTION_TYPE          = 0                             ,
        parameter TCAM_PATRN0_EXP_RESET_VALUE   = TCAM_WIDTH'(0)                ,
        parameter TCAM_PATRN1_EXP_RESET_VALUE   = TCAM_WIDTH'(0)                ,
        parameter       TSMC_N7                 = 1                             , //
        parameter RESET_DALAY                   = 2                             ,
        parameter CE_DELAY                      = 4
)(
        // General
        input   logic                                   clk                     ,
        input   logic                                   rst_n                   ,
        // Functional I/F From Shell
        input   logic   [     TCAM_ADDR_WIDTH-1:0]      adr_pre                 ,
        input   logic                                   rd_en_pre               ,
        input   logic                                   wr_en_pre               ,       
        input   logic   [         TCAM_WIDTH-1:0]       wr_data_pre             ,
        output  logic   [         TCAM_WIDTH-1:0]       rd_data_pre             ,
        input   logic                                   chk_en_pre              ,
        input   logic   [TCAM_SLICE_EN_WIDTH-1:0]       slice_en_pre            ,
        input   logic   [     TCAM_RULES_NUM-1:0]       hit_arr_in_pre          ,
        input   logic   [         TCAM_WIDTH-1:0]       chk_key_pre             ,
        input   logic   [         TCAM_WIDTH-1:0]       chk_mask_pre            ,
        input   logic                                   flush_pre               ,
        output  logic   [     TCAM_RULES_NUM-1:0]       hit_arr_out_pre         ,
        output  logic                                   tcam_rd_valid_pre       ,       
        output  logic                                   tcam_wr_ack_pre         ,
        output  logic                                   tcam_chk_valid_pre      ,       
        output  logic                                   tcam_rdwr_rdy_pre       ,       
        output  logic                                   tcam_chk_rdy_pre        ,       
        // Functional I/F To Shell
        output  logic   [     TCAM_ADDR_WIDTH-1:0]      adr_pst                 ,
        output  logic                                   ce_pst                  ,
        output  logic                                   rd_en_pst               ,
        output  logic                                   wr_en_pst               ,
        output  logic   [         TCAM_WIDTH-1:0]       wr_data_pst             ,
        input   logic   [         TCAM_WIDTH-1:0]       rd_data_pst             ,
        output  logic                                   chk_en_pst              ,
        output  logic   [TCAM_SLICE_EN_WIDTH-1:0]       slice_en_pst            ,
        output  logic   [     TCAM_RULES_NUM-1:0]       hit_arr_in_pst          ,
        output  logic   [         TCAM_WIDTH-1:0]       chk_key_pst             ,
        output  logic   [         TCAM_WIDTH-1:0]       chk_mask_pst            ,
        input   logic   [     TCAM_RULES_NUM-1:0]       hit_arr_out_pst         ,
        input   logic                                   tcam_rd_valid_pst       ,       
        input   logic                                   tcam_wr_ack_pst         ,
        input   logic                                   tcam_chk_valid_pst      ,       
        input   logic                                   tcam_rdwr_rdy_pst       ,       
        input   logic                                   tcam_chk_rdy_pst        ,       
        // Protection related I/F
        
        input   logic                                   tcam_check_err_dis      , 
        input   logic                                   tcam_update_dis         , 
        input   logic                                   tcam_init_done          ,
        input   logic                                   tcam_prot_en            ,
        input   logic                                   tcam_invert_0           ,
        input   logic                                   tcam_invert_1           ,
        output  logic                                   tcam_ecc_err_det        
);




 `ifndef INTEL_SVA_OFF
    import intel_checkers_pkg::*;   
 `endif
    

 `ifndef INTEL_SVA_OFF

    `ASSERTS_TRIGGER (illegal_wen_ren, rd_en_pst , ~wr_en_pst, posedge clk, ~rst_n, 
        `ERR_MSG ( "Error message REN and WEN are both asserted" ) ) ;
    `ASSERTS_TRIGGER (illegal_ren_ken, rd_en_pst , ~chk_en_pst, posedge clk, ~rst_n, 
        `ERR_MSG ( "Error message REN and KEN are both asserted" ) ) ;
//---------------- 
    
    `ASSERTS_TRIGGER (illegal_ren_wen, wr_en_pst , ~rd_en_pst, posedge clk, ~rst_n, 
        `ERR_MSG ( "Error message WEN and REN are both asserted" ) ) ;
    `ASSERTS_TRIGGER (illegal_wen_ken, wr_en_pst , ~chk_en_pst, posedge clk, ~rst_n, 
        `ERR_MSG ( "Error message WEN and KEN are both asserted" ) ) ;

    `ASSERTS_TRIGGER (illegal_ken_ren, chk_en_pst , ~rd_en_pst, posedge clk, ~rst_n, 
        `ERR_MSG ( "Error message KEN and REN are both asserted" ) ) ;
    `ASSERTS_TRIGGER (illegal_ken_wen, chk_en_pst , ~wr_en_pst, posedge clk, ~rst_n, 
        `ERR_MSG ( "Error message KEN and WEN are both asserted" ) ) ;
//----------------
    `ASSERTS_TRIGGER (illegal_wen_rdy, wr_en_pre , tcam_rdwr_rdy_pre, posedge clk, ~rst_n, 
        `ERR_MSG ( "Error message WEN and RDY are both asserted" ) ) ;
    `ASSERTS_TRIGGER (illegal_ren_rdy, rd_en_pre , tcam_rdwr_rdy_pre, posedge clk, ~rst_n, 
        `ERR_MSG ( "Error message REN and RDY are both asserted" ) ) ;
    `ASSERTS_TRIGGER (illegal_cmp_chk, chk_en_pre ,  tcam_chk_rdy_pre, posedge clk, ~rst_n, 
        `ERR_MSG ( "Error message CMP and CHK are both asserted" ) ) ;    
//----------------

   
  `endif
`ifdef INTEL_SIMONLY
    `ifndef INTEL_SVA_OFF


        logic sva_err_check_en ; 
        logic sva_err_occurred_x ; 

        always @(posedge rst_n)
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
        always_comb  sva_err_occurred_x = (tcam_ecc_err_det !== 0) ; 
              
        `ASSERTS_NEVER (ecc_err_occurred_assert, sva_err_occurred_x & sva_err_check_en , posedge clk, ~rst_n,
                `ERR_MSG ("Error: Sweeper Error occurred when not expected"));

     `endif
`endif




   function automatic chk0_chng;
      // INPUTS
      input                      rd_line_e0_bit ;
      input                      rd_line_e1_bit ;
      input                      wr_line_bit    ;
      input                      wr_line_num    ;

        casez ({rd_line_e0_bit, rd_line_e1_bit, wr_line_bit})
              3'b000: begin
                      chk0_chng = 1'b0                          ;
              end
              3'b001: begin
                      chk0_chng = (!wr_line_num) ? 1'b1 : 1'b0  ;
              end
              3'b010: begin
                      chk0_chng = 1'b0                          ;
              end
              3'b011: begin
                      chk0_chng = (!wr_line_num) ? 1'b1 : 1'b0  ;
              end
              3'b100: begin
                      chk0_chng = (!wr_line_num) ? 1'b1 : 1'b0  ;
              end
              3'b101: begin
                      chk0_chng = 1'b0                          ;
              end             
              3'b110: begin
                      chk0_chng = (!wr_line_num) ? 1'b1 : 1'b0  ;
              end
              3'b111: begin
                      chk0_chng = 1'b0                          ;
              end
              default: begin
                      chk0_chng = 1'b0                          ;               
              end
        endcase
        
   endfunction

   function automatic chk1_chng;
      // INPUTS
      input                      rd_line_e0_bit ;
      input                      rd_line_e1_bit ;
      input                      wr_line_bit    ;
      input                      wr_line_num    ;

        casez ({rd_line_e0_bit, rd_line_e1_bit, wr_line_bit})
              3'b000: begin
                      chk1_chng = 1'b0                          ;
              end
              3'b001: begin
                      chk1_chng = (wr_line_num) ? 1'b1 : 1'b0   ;
              end
              3'b010: begin
                      chk1_chng = (wr_line_num) ? 1'b1 : 1'b0   ;
              end
              3'b011: begin
                      chk1_chng = 1'b0                          ;
              end
              3'b100: begin
                      chk1_chng = 1'b0                          ;
              end
              3'b101: begin
                      chk1_chng = (wr_line_num) ? 1'b1 : 1'b0   ;
              end             
              3'b110: begin
                      chk1_chng = (wr_line_num) ? 1'b1 : 1'b0   ;
              end
              3'b111: begin
                      chk1_chng = 1'b0                          ;
              end
              default: begin
                      chk1_chng = 1'b0                          ;               
              end
        endcase
        
   endfunction

generate
        if (TCAM_PROTECTION_TYPE == 0) begin: NO_PROT
         
                
                logic                                           tcam_invert_ff_en               ;
                logic           [                  2-1:0]       tcam_invert_ff                  ;

                always_ff @(posedge clk or negedge rst_n)
                        if (!rst_n) begin
                                tcam_invert_ff_en       <= 1'b1                                 ;
                                tcam_invert_ff[2-1:0]   <= {2{1'b0}}                            ;
                        end
                        else if (!(tcam_invert_0 || tcam_invert_1)) begin
                                tcam_invert_ff_en       <= 1'b1                                 ;
                                tcam_invert_ff[2-1:0]   <= {2{1'b0}}                            ;
                        end
                        else if (tcam_invert_ff_en) begin
                                tcam_invert_ff_en       <= 1'b0                                 ;
                                tcam_invert_ff[2-1:0]   <= {tcam_invert_1, tcam_invert_0}       ;
                        end
                        else if (wr_en_pst) begin
                                tcam_invert_ff[2-1:0]   <= {2{1'b0}}                            ;
                        end
                
                always_comb begin
                        adr_pst[TCAM_ADDR_WIDTH-1:0]            = adr_pre[TCAM_ADDR_WIDTH-1:0]                                  ; 
                        // ce_pst                                  = rd_en_pre |  wr_en_pre | chk_en_pre                           ;
                        // assert ce while reset to get TCAM outputs cleared properly regardless of TCAM init directive in logical
                        ce_pst                                  = rd_en_pre |  wr_en_pre | chk_en_pre  | ~tcam_init_done | flush_pre;
                        rd_en_pst                               = rd_en_pre                                                     ;       
                        wr_en_pst                               = wr_en_pre                                                     ;       
                        wr_data_pst[TCAM_WIDTH-1:0]             = {wr_data_pre[TCAM_WIDTH-1:2], (wr_data_pre[1] ^ tcam_invert_ff[1]), (wr_data_pre[0] ^ tcam_invert_ff[0])};
                        rd_data_pre[TCAM_WIDTH-1:0]             = rd_data_pst[TCAM_WIDTH-1:0]                                   ;
                        chk_en_pst                              = chk_en_pre                                                    ;       
                        slice_en_pst[TCAM_SLICE_EN_WIDTH-1:0]   = slice_en_pre[TCAM_SLICE_EN_WIDTH-1:0]                         ;
                        hit_arr_in_pst[TCAM_RULES_NUM-1:0]      = hit_arr_in_pre[TCAM_RULES_NUM-1:0]                            ;  
                        chk_key_pst[TCAM_WIDTH-1:0]             = chk_key_pre[TCAM_WIDTH-1:0]                                   ;
                        chk_mask_pst[TCAM_WIDTH-1:0]            = chk_mask_pre[TCAM_WIDTH-1:0]                                  ;
                        hit_arr_out_pre[TCAM_RULES_NUM-1:0]     = hit_arr_out_pst[TCAM_RULES_NUM-1:0]                           ;  
                        tcam_rd_valid_pre                       = tcam_rd_valid_pst                                             ;       
                        tcam_wr_ack_pre                         = tcam_wr_ack_pst                                               ;
                        tcam_chk_valid_pre                      = tcam_chk_valid_pst                                            ;
                        tcam_rdwr_rdy_pre                       = tcam_rdwr_rdy_pst                                             ;
                        tcam_chk_rdy_pre                        = tcam_chk_rdy_pst                                              ;
                        tcam_ecc_err_det                        = 1'b0                                                          ;
                end
        end
        else if ((TCAM_PROTECTION_TYPE == 1) && (BCAM_RELIEF == 0)) begin: DETECT_ONLY
          
                //
                // Backdoor overloadin Arrays - used for verification purposes only!
                //
                logic                            tcam_back_door_loading_indication[2-1:0]               ;
                logic           [TCAM_WIDTH-1:0] tcam_back_door_update_val[2-1:0]                       ;
                
                assign tcam_back_door_loading_indication[0] = 0;
                assign tcam_back_door_loading_indication[1] = 0;
                assign tcam_back_door_update_val[0] = TCAM_WIDTH'(0);
                assign tcam_back_door_update_val[1] = TCAM_WIDTH'(0);           
                
                //
                // Expected Pattern Arrays
                //
                logic           [TCAM_WIDTH-1:0] tcam_exp_patrn[2-1:0]                                  ;
                logic                            tcam_exp_patrn_update_en                               ;
                logic           [TCAM_WIDTH-1:0] tcam_exp_patrn_update_val[2-1:0]                       ;
                
                always_ff @(posedge clk or negedge rst_n)
                        if (!rst_n) begin
                                tcam_exp_patrn[0][TCAM_WIDTH-1:0]       <= TCAM_WIDTH'(TCAM_PATRN0_EXP_RESET_VALUE)     ;
                                tcam_exp_patrn[1][TCAM_WIDTH-1:0]       <= TCAM_WIDTH'(TCAM_PATRN1_EXP_RESET_VALUE)     ;
                        end
                        else if (tcam_exp_patrn_update_en) begin
                                tcam_exp_patrn[0][TCAM_WIDTH-1:0]       <= tcam_exp_patrn_update_val[0][TCAM_WIDTH-1:0] ;
                                tcam_exp_patrn[1][TCAM_WIDTH-1:0]       <= tcam_exp_patrn_update_val[1][TCAM_WIDTH-1:0] ;
                        end else begin // for verification purpose only!
                            if (tcam_back_door_loading_indication[0]==1)
                                tcam_exp_patrn[0][TCAM_WIDTH-1:0]       <= tcam_back_door_update_val[0][TCAM_WIDTH-1:0] ;
                            if (tcam_back_door_loading_indication[1]==1)
                                tcam_exp_patrn[1][TCAM_WIDTH-1:0]       <= tcam_back_door_update_val[1][TCAM_WIDTH-1:0] ;
                        end

                //
                // Read Modify Write FSM
                //
                logic           [2-1:0]                 tcam_rd_mod_wr_ps, tcam_rd_mod_wr_ns                            ;
                logic           [TCAM_ADDR_WIDTH-1:0]   adr_s                                                           ;
                logic           [TCAM_WIDTH-1:0]        wr_data_s                                                       ;
                logic                                   tcam_e0_rd_occured, tcam_e1_rd_occured                          ;
                logic           [TCAM_WIDTH-1:0]        tcam_e0_rd_data, tcam_e1_rd_data                                ;
                always_ff @(posedge clk or negedge rst_n)
                        if (!rst_n) begin
                                tcam_rd_mod_wr_ps[2-1:0]        <= `HLP_TCAM_SWPR_IDLE                     ;
                                adr_s[TCAM_ADDR_WIDTH-1:0]      <= 0        ;
                                wr_data_s[TCAM_WIDTH-1:0]       <= 0        ;  // lintra s-02056
                        end
                        else begin
                                tcam_rd_mod_wr_ps[2-1:0]                         <= tcam_rd_mod_wr_ns[2-1:0]            ;
                                if (tcam_rd_mod_wr_ps[2-1:0] == `HLP_TCAM_SWPR_IDLE) begin
                                         if (wr_en_pre && tcam_init_done && tcam_prot_en && tcam_rdwr_rdy_pst) begin
                                                 adr_s[TCAM_ADDR_WIDTH-1:0]      <= adr_pre[TCAM_ADDR_WIDTH-1:0]        ;
                                                 wr_data_s[TCAM_WIDTH-1:0]       <= wr_data_pre[TCAM_WIDTH-1:0]         ;
                                         end
                                end
                        end

                logic                                                   chk_en_swpr                                             ;
                logic           [     TCAM_SLICE_EN_WIDTH-1:0]          slice_en_swpr                                           ;
                logic           [          TCAM_RULES_NUM-1:0]          hit_arr_in_swpr                                         ;
                logic           [              TCAM_WIDTH-1:0]          chk_key_swpr                                            ;
                logic           [              TCAM_WIDTH-1:0]          chk_mask_swpr                                           ;
                logic                                                   chk_en_swpr_cycle_done                                  ;
                logic           [TCAM_PROTECTION_RL_WIDTH-1:0]          swpr_rl_count                                           ;
                logic                                                   swpr_rl_count_done                                      ;
                logic                                                   chk_en_swpr_prev                                        ;
                logic                                                   chk_ptrn_1_prev                                         ;
                logic           [          TCAM_WIDTH_LOG-1:0]          chk_ptrn_num_prev, chk_ptrn_num_prev_int                ;
                logic                                                   chk_ptrn_exp_val                                        ;
                logic                                                   chk_ptrn_hit_arr_val                                    ;
                logic                                                   tcam_invert_ff_en                                       ;
                logic           [                       2-1:0]          tcam_invert_ff                                          ;

                always_ff @(posedge clk or negedge rst_n)
                        if (!rst_n) begin
                                tcam_invert_ff_en       <= 1'b1                                 ;
                                tcam_invert_ff[2-1:0]   <= {2{1'b0}}                            ;
                        end
                        else if (!(tcam_invert_0 || tcam_invert_1)) begin
                                tcam_invert_ff_en       <= 1'b1                                 ;
                                tcam_invert_ff[2-1:0]   <= {2{1'b0}}                            ;
                        end
                        else if (tcam_invert_ff_en) begin
                                tcam_invert_ff_en       <= 1'b0                                 ;
                                tcam_invert_ff[2-1:0]   <= {tcam_invert_1, tcam_invert_0}       ;
                        end
                        else if (wr_en_pst) begin
                                tcam_invert_ff[2-1:0]   <= {2{1'b0}}                            ;
                        end
                logic   [TCAM_CHK_DELAY:0]              chk_en_swpr_delay;
                logic   [TCAM_CHK_DELAY:0]              chk_ptrn_1_delay;
                logic   [TCAM_WIDTH_LOG-1:0]            chk_ptrn_num_delay[TCAM_CHK_DELAY:0]; 

                assign ce_pst = rd_en_pst |  wr_en_pst | chk_en_pst | ~tcam_init_done | flush_pre;

                always_comb begin
                        adr_pst[TCAM_ADDR_WIDTH-1:0]                    = adr_pre[TCAM_ADDR_WIDTH-1:0]                  ; 
                        rd_en_pst                                       = rd_en_pre                                     ;       
                        wr_en_pst                                       = wr_en_pre                                     ;       
                        wr_data_pst[TCAM_WIDTH-1:0]                     = wr_data_pre[TCAM_WIDTH-1:0]                   ;
                        rd_data_pre[TCAM_WIDTH-1:0]                     = rd_data_pst[TCAM_WIDTH-1:0]                   ;
                        chk_en_pst                                      = chk_en_pre || chk_en_swpr                     ; 
                        slice_en_pst[TCAM_SLICE_EN_WIDTH-1:0]           = (chk_en_pre)          ? slice_en_pre[TCAM_SLICE_EN_WIDTH-1:0] : slice_en_swpr[TCAM_SLICE_EN_WIDTH-1:0];
                        
                        if (TSMC_N7)
                            hit_arr_in_pst[TCAM_RULES_NUM-1:0]              = (!chk_en_swpr_delay[0])? hit_arr_in_pre[TCAM_RULES_NUM-1:0]   : hit_arr_in_swpr[TCAM_RULES_NUM-1:0]   ;
                        else
                            hit_arr_in_pst[TCAM_RULES_NUM-1:0]              = (!chk_en_swpr_delay[1])? hit_arr_in_pre[TCAM_RULES_NUM-1:0]   : hit_arr_in_swpr[TCAM_RULES_NUM-1:0]   ;
                          
                        chk_key_pst[TCAM_WIDTH-1:0]                     = (chk_en_pre)          ? chk_key_pre[TCAM_WIDTH-1:0]           : chk_key_swpr[TCAM_WIDTH-1:0]          ;
                        chk_mask_pst[TCAM_WIDTH-1:0]                    = (chk_en_pre)          ? chk_mask_pre[TCAM_WIDTH-1:0]          : chk_mask_swpr[TCAM_WIDTH-1:0]         ;
                        hit_arr_out_pre[TCAM_RULES_NUM-1:0]             = (!chk_en_swpr_prev)   ? hit_arr_out_pst[TCAM_RULES_NUM-1:0]   : {TCAM_RULES_NUM{1'b0}}                ;
                        tcam_rd_valid_pre                               = tcam_rd_valid_pst && (tcam_rd_mod_wr_ps == `HLP_TCAM_SWPR_IDLE) ; 
                        tcam_wr_ack_pre                                 = tcam_wr_ack_pst                                                                                       ;
                        tcam_chk_valid_pre                              = (!chk_en_swpr_prev)   ? tcam_chk_valid_pst                    : 1'b0                                  ;
                        tcam_rdwr_rdy_pre                               = tcam_rdwr_rdy_pst                                                                                     ;
                        tcam_chk_rdy_pre                                = tcam_chk_rdy_pst                                                                                      ;
                        tcam_exp_patrn_update_en                        = 1'b0                                          ;
                        tcam_rd_mod_wr_ns                               = `HLP_TCAM_SWPR_IDLE                               ;
                        case (tcam_rd_mod_wr_ps[2-1:0])
                                `HLP_TCAM_SWPR_IDLE: begin
                                        if (wr_en_pre && tcam_init_done && tcam_prot_en && tcam_rdwr_rdy_pst && ~tcam_update_dis) begin
                                                adr_pst[TCAM_ADDR_WIDTH-1:0]    = {adr_pre[TCAM_ADDR_WIDTH-1:1], 1'b0}  ;
                                                rd_en_pst                       = 1'b1                                  ;
                                                wr_en_pst                       = 1'b0                                  ;
                                                tcam_wr_ack_pre                 = 1'b0                                  ;
                                                tcam_chk_rdy_pre                = 1'b0                                  ;
                                                tcam_rd_mod_wr_ns               = `HLP_TCAM_SWPR_RD_E0                      ;
                                        end
                                        else begin
                                                adr_pst[TCAM_ADDR_WIDTH-1:0]    = adr_pre[TCAM_ADDR_WIDTH-1:0]          ;
                                                rd_en_pst                       = rd_en_pre                             ;
                                                wr_en_pst                       = wr_en_pre                             ;
                                                tcam_rd_mod_wr_ns               = `HLP_TCAM_SWPR_IDLE                       ;
                                        end
                                end
                                `HLP_TCAM_SWPR_RD_E0: begin
                                        if (tcam_rdwr_rdy_pst) begin
                                                adr_pst[TCAM_ADDR_WIDTH-1:0]    = {adr_s[TCAM_ADDR_WIDTH-1:1], 1'b1}    ;
                                                rd_en_pst                       = 1'b1                                  ;
                                                wr_en_pst                       = 1'b0                                  ;
                                                tcam_rd_valid_pre               = tcam_rd_valid_pst                     ;
                                                tcam_wr_ack_pre                 = 1'b0                                  ;
                                                tcam_rdwr_rdy_pre               = 1'b0                                  ;
                                                tcam_chk_rdy_pre                = 1'b0                                  ;
                                                tcam_rd_mod_wr_ns               = `HLP_TCAM_SWPR_RD_E1                      ;                                               
                                        end
                                        else begin
                                                adr_pst[TCAM_ADDR_WIDTH-1:0]    = {adr_pre[TCAM_ADDR_WIDTH-1:1], 1'b0}  ;
                                                rd_en_pst                       = 1'b0                                  ;
                                                wr_en_pst                       = 1'b0                                  ;
                                                tcam_rd_valid_pre               = 1'b0                                  ;
                                                tcam_wr_ack_pre                 = 1'b0                                  ;
                                                tcam_rdwr_rdy_pre               = 1'b0                                  ;
                                                tcam_chk_rdy_pre                = 1'b0                                  ;
                                                tcam_rd_mod_wr_ns               = `HLP_TCAM_SWPR_RD_E0                      ;
                                        end
                                end
                                `HLP_TCAM_SWPR_RD_E1: begin
                                        if (tcam_rdwr_rdy_pst) begin
                                                adr_pst[TCAM_ADDR_WIDTH-1:0]    = adr_s[TCAM_ADDR_WIDTH-1:0]            ;
                                                rd_en_pst                       = 1'b0                                  ;
                                                wr_en_pst                       = 1'b1                                  ;
                                                wr_data_pst[TCAM_WIDTH-1:0]     = {wr_data_s[TCAM_WIDTH-1:2], (wr_data_s[1] ^ tcam_invert_ff[1]), (wr_data_s[0] ^ tcam_invert_ff[0])}           ;
                                                tcam_rd_valid_pre               = 1'b0                                  ;
                                                if ((tcam_e0_rd_occured && tcam_e1_rd_occured) || (tcam_e0_rd_occured && tcam_rd_valid_pst)) begin
                                                        tcam_exp_patrn_update_en= 1'b1                                  ;
                                                        tcam_wr_ack_pre         = 1'b1                                  ;
                                                        tcam_rdwr_rdy_pre       = tcam_rdwr_rdy_pst                     ;
                                                        tcam_chk_rdy_pre        = tcam_chk_rdy_pst                      ;                                                       
                                                        tcam_rd_mod_wr_ns       = `HLP_TCAM_SWPR_IDLE                       ;
                                                end
                                                else begin
                                                        tcam_exp_patrn_update_en= 1'b0                                  ;
                                                        tcam_wr_ack_pre         = 1'b0                                  ;
                                                        tcam_rdwr_rdy_pre       = 1'b0                                  ;
                                                        tcam_chk_rdy_pre        = 1'b0                                  ;                                                       
                                                        tcam_rd_mod_wr_ns       = `HLP_TCAM_SWPR_WR                         ;
                                                end
                                        end
                                        else begin
                                                adr_pst[TCAM_ADDR_WIDTH-1:0]    = {adr_s[TCAM_ADDR_WIDTH-1:1], 1'b1}    ;
                                                rd_en_pst                       = 1'b0                                  ;
                                                wr_en_pst                       = 1'b0                                  ;
                                                tcam_rd_valid_pre               = 1'b0                                  ;
                                                tcam_wr_ack_pre                 = 1'b0                                  ;
                                                tcam_rdwr_rdy_pre               = 1'b0                                  ;
                                                tcam_chk_rdy_pre                = 1'b0                                  ;
                                                tcam_rd_mod_wr_ns               = `HLP_TCAM_SWPR_RD_E1                      ;
                                        end
                                end
                                `HLP_TCAM_SWPR_WR: begin
                                        if ((tcam_e0_rd_occured && tcam_e1_rd_occured) || (tcam_e0_rd_occured && tcam_rd_valid_pst)) begin
                                                tcam_exp_patrn_update_en        = 1'b1                                  ;
                                                tcam_wr_ack_pre                 = 1'b1                                  ;
                                                tcam_rdwr_rdy_pre               = 1'b0                                  ;
                                                tcam_chk_rdy_pre                = 1'b0                                ;                                               
                                                tcam_rd_mod_wr_ns               = `HLP_TCAM_SWPR_IDLE                       ;
                                        end
                                        else begin
                                                tcam_exp_patrn_update_en        = 1'b0                                  ;
                                                tcam_wr_ack_pre                 = 1'b0                                  ;
                                                tcam_rdwr_rdy_pre               = 1'b0                                  ;
                                                tcam_chk_rdy_pre                = 1'b0                        ;                                                       
                                                tcam_rd_mod_wr_ns               = `HLP_TCAM_SWPR_WR                         ;
                                        end
                                end
                                default: begin
                                        adr_pst[TCAM_ADDR_WIDTH-1:0]            = adr_pre[TCAM_ADDR_WIDTH-1:0]          ;
                                        rd_en_pst                               = rd_en_pre                             ;       
                                        wr_en_pst                               = wr_en_pre                             ;
                                        wr_data_pst[TCAM_WIDTH-1:0]             = wr_data_pre[TCAM_WIDTH-1:0]           ;
                                        rd_data_pre[TCAM_WIDTH-1:0]             = rd_data_pst[TCAM_WIDTH-1:0]           ;
                                        chk_en_pst                              = chk_en_pre || chk_en_swpr             ;
                                        slice_en_pst[TCAM_SLICE_EN_WIDTH-1:0]   = (chk_en_pre)          ? slice_en_pre[TCAM_SLICE_EN_WIDTH-1:0] : slice_en_swpr[TCAM_SLICE_EN_WIDTH-1:0];
                                        if (TSMC_N7)
                                            // In TSMC No need to add delay on hit in
                                            hit_arr_in_pst[TCAM_RULES_NUM-1:0]      = (!chk_en_swpr_delay[0])? hit_arr_in_pre[TCAM_RULES_NUM-1:0]   : hit_arr_in_swpr[TCAM_RULES_NUM-1:0]   ;
                                        else
                                            hit_arr_in_pst[TCAM_RULES_NUM-1:0]      = (!chk_en_swpr_delay[1])? hit_arr_in_pre[TCAM_RULES_NUM-1:0]   : hit_arr_in_swpr[TCAM_RULES_NUM-1:0]   ;
                                        chk_key_pst[TCAM_WIDTH-1:0]             = (chk_en_pre)          ? chk_key_pre[TCAM_WIDTH-1:0]           : chk_key_swpr[TCAM_WIDTH-1:0]          ;
                                        chk_mask_pst[TCAM_WIDTH-1:0]            = (chk_en_pre)          ? chk_mask_pre[TCAM_WIDTH-1:0]          : chk_mask_swpr[TCAM_WIDTH-1:0]         ;
                                        hit_arr_out_pre[TCAM_RULES_NUM-1:0]     = (!chk_en_swpr_prev)   ? hit_arr_out_pst[TCAM_RULES_NUM-1:0]   : {TCAM_RULES_NUM{1'b0}}                ;
                                        tcam_rd_valid_pre                       = tcam_rd_valid_pst &&  (tcam_rd_mod_wr_ps[2-1:0] == `HLP_TCAM_SWPR_IDLE)                           ;
                                        tcam_wr_ack_pre                         = tcam_wr_ack_pst                                                                                       ;
                                        tcam_chk_valid_pre                      = (!chk_en_swpr_prev)   ? tcam_chk_valid_pst                    : 1'b0                                  ;
                                        tcam_rdwr_rdy_pre                       = tcam_rdwr_rdy_pst                     ;
                                        tcam_chk_rdy_pre                        = tcam_chk_rdy_pst                      ;
                                        tcam_exp_patrn_update_en                = 1'b0                                  ;
                                        tcam_rd_mod_wr_ns                       = `HLP_TCAM_SWPR_IDLE                       ;
                                end
                        endcase
                end

                // Checking and Patterns

                always_ff @(posedge clk)
                        if (tcam_rd_valid_pst && !tcam_e0_rd_occured) begin
                                tcam_e0_rd_data[TCAM_WIDTH-1:0]         <= rd_data_pst[TCAM_WIDTH-1:0]                                                                          ;
                        end

                always_comb begin
                                tcam_e1_rd_data[TCAM_WIDTH-1:0]         = rd_data_pst[TCAM_WIDTH-1:0]                                                                           ;
                                for (int i=0; i<TCAM_WIDTH; i=i+1) begin                                                        
                                        tcam_exp_patrn_update_val[0][i] = (chk0_chng(tcam_e0_rd_data[i], tcam_e1_rd_data[i], wr_data_s[i], adr_s[0])) ^ (tcam_exp_patrn[0][i])  ;
                                        tcam_exp_patrn_update_val[1][i] = (chk1_chng(tcam_e0_rd_data[i], tcam_e1_rd_data[i], wr_data_s[i], adr_s[0])) ^ (tcam_exp_patrn[1][i])  ;
                                end




                end
                
                always_ff @(posedge clk or negedge rst_n)
                        if (!rst_n) begin
                                tcam_e0_rd_occured      <= 1'b0 ;
                                tcam_e1_rd_occured      <= 1'b0 ;
                        end
                        else if (tcam_exp_patrn_update_en) begin
                                tcam_e0_rd_occured      <= 1'b0 ;
                                tcam_e1_rd_occured      <= 1'b0 ;
                        end
                        else if (tcam_rd_valid_pst && ((tcam_rd_mod_wr_ps[2-1:0] == `HLP_TCAM_SWPR_RD_E1) || (tcam_rd_mod_wr_ps[2-1:0] == `HLP_TCAM_SWPR_WR) )) begin
                                tcam_e0_rd_occured      <= (!tcam_e0_rd_occured) ? 1'b1 : tcam_e0_rd_occured    ;
                                tcam_e1_rd_occured      <= (tcam_e0_rd_occured)  ? 1'b1 : tcam_e1_rd_occured    ;
                        end
                        
                logic                                           tcam_func_access                ;
                logic                                           chk_ptrn_1                      ;
                
                assign                                          tcam_func_access        = (rd_en_pst || wr_en_pst || chk_en_pre)                                ;

                assign                                          chk_en_swpr                             = tcam_prot_en && !tcam_func_access && tcam_init_done && tcam_chk_rdy_pst && swpr_rl_count_done && !chk_en_swpr_cycle_done;
                assign                                          slice_en_swpr[TCAM_SLICE_EN_WIDTH-1:0]  = {TCAM_SLICE_EN_WIDTH{1'b1}}                           ;
                assign                                          hit_arr_in_swpr[TCAM_RULES_NUM-1:0]     = {TCAM_RULES_NUM{1'b1}}                                ;
                // Patterns Generation
                always_ff @(posedge clk or negedge rst_n)
                        if (!rst_n) begin
                                chk_ptrn_1                              <= 1'b1                                                                 ;
                                chk_key_swpr[TCAM_WIDTH-1:0]            <= {{(TCAM_WIDTH-1){1'b0}}, 1'b1}                                       ;
                                chk_mask_swpr[TCAM_WIDTH-1:0]           <= {{(TCAM_WIDTH-1){1'b0}}, 1'b1}                                       ;
                                chk_en_swpr_cycle_done                  <= 1'b0                                                                 ;
                        end
                        else if (chk_en_swpr) begin
                                if (chk_ptrn_1) begin
                                // Pattern 1
                                        chk_ptrn_1                                      <= 1'b0                                                                 ;
                                        chk_key_swpr[TCAM_WIDTH-1:0]                    <= chk_key_swpr[TCAM_WIDTH-1:0] & (~chk_mask_swpr[TCAM_WIDTH-1:0])      ;
                                        chk_en_swpr_cycle_done                          <= 1'b0                                                                 ;
                                end
                                else begin
                                // Pattern 0
                                        chk_ptrn_1                                      <= 1'b1                                                                 ;
                                        if (chk_mask_swpr[TCAM_WIDTH-1:0] == {1'b1, {(TCAM_WIDTH-1){1'b0}}}) begin
                                        // Overlap
                                                chk_key_swpr[TCAM_WIDTH-1:0]            <= {{(TCAM_WIDTH-1){1'b0}}, 1'b1}                                       ;
                                                chk_mask_swpr[TCAM_WIDTH-1:0]           <= {{(TCAM_WIDTH-1){1'b0}}, 1'b1}                                       ;
                                                chk_en_swpr_cycle_done                  <= 1'b1                                                                 ;
                                        end
                                        else begin
                                        // Shift Left
                                                chk_key_swpr[TCAM_WIDTH-1:0]            <= (chk_key_swpr[TCAM_WIDTH-1:0] | chk_mask_swpr[TCAM_WIDTH-1:0]) << 1  ;
                                                chk_mask_swpr[TCAM_WIDTH-1:0]           <= chk_mask_swpr[TCAM_WIDTH-1:0] << 1                                   ;
                                                chk_en_swpr_cycle_done                  <= 1'b0                                                                 ;
                                        end
                                end
                        end
                        else begin  // no check_en_swpr
                              chk_en_swpr_cycle_done                                    <= 1'b0                                                                 ;
                        end


                        
                always_ff @(posedge clk or negedge rst_n)
                        if (!rst_n) begin
                                swpr_rl_count[TCAM_PROTECTION_RL_WIDTH-1:0]     <= {TCAM_PROTECTION_RL_WIDTH{1'b0}}                                                     ;
                        end
                        else if (chk_en_swpr_cycle_done) begin
                                swpr_rl_count[TCAM_PROTECTION_RL_WIDTH-1:0]     <= TCAM_PROTECTION_RL_WIDTH'(TCAM_PROTECTION_RL)                                        ;
                        end
                        else if (|swpr_rl_count[TCAM_PROTECTION_RL_WIDTH-1:0]) begin
                                swpr_rl_count[TCAM_PROTECTION_RL_WIDTH-1:0]     <= swpr_rl_count[TCAM_PROTECTION_RL_WIDTH-1:0] - {{(TCAM_PROTECTION_RL_WIDTH-1){1'b0}}, 1'b1};
                        end
                assign          swpr_rl_count_done                              = (swpr_rl_count[TCAM_PROTECTION_RL_WIDTH-1:0] == {TCAM_PROTECTION_RL_WIDTH{1'b0}})     ;
                // Actual Checking

                hlp_mgm_gen_ffs #(
                        .INP_WDTH       (TCAM_WIDTH)
                ) gen_ffs (
                        .inp_vect       (chk_mask_swpr[TCAM_WIDTH-1:0])                 ,
                        .fs_idx         (chk_ptrn_num_prev_int[TCAM_WIDTH_LOG-1:0])     ,
                        .fs_vld         ()
                );

                always_comb begin
                        chk_en_swpr_delay[0]                                                    = chk_en_swpr                                   ;
                        chk_ptrn_1_delay[0]                                                     = chk_ptrn_1                                    ;
                        chk_ptrn_num_delay[0][TCAM_WIDTH_LOG-1:0]                               = chk_ptrn_num_prev_int[TCAM_WIDTH_LOG-1:0]     ;
                        chk_en_swpr_prev                                                        = chk_en_swpr_delay[TCAM_CHK_DELAY]             ;
                        chk_ptrn_1_prev                                                         = chk_ptrn_1_delay[TCAM_CHK_DELAY]              ;
                        chk_ptrn_num_prev[TCAM_WIDTH_LOG-1:0]                                   = chk_ptrn_num_delay[TCAM_CHK_DELAY][TCAM_WIDTH_LOG-1:0]        ;                       
                end
                always_ff @(posedge clk or negedge rst_n) begin
                        if (!rst_n) begin
                                chk_en_swpr_delay[TCAM_CHK_DELAY:1] <= 0;
                                chk_ptrn_1_delay [TCAM_CHK_DELAY:1] <= 0;
                                for (int i=1; i<=TCAM_CHK_DELAY; i=i+1) begin                                        
                                    chk_ptrn_num_delay[i][TCAM_WIDTH_LOG-1:0]       <=  0 ;
                                end
                        end
                        else begin
                                for (int i=1; i<=TCAM_CHK_DELAY; i=i+1) begin
                                        chk_en_swpr_delay[i]                                    <= chk_en_swpr_delay[i-1]                       ;
                                        if (chk_en_swpr_delay[i-1]) begin
                                                chk_ptrn_1_delay[i]                             <= chk_ptrn_1_delay[i-1]                        ;
                                                chk_ptrn_num_delay[i][TCAM_WIDTH_LOG-1:0]       <= chk_ptrn_num_delay[i-1][TCAM_WIDTH_LOG-1:0]  ;
                                        end
                                end
                        end                     
                end                     
                                
                assign          chk_ptrn_exp_val        = chk_ptrn_1_prev ? tcam_exp_patrn[1][chk_ptrn_num_prev[TCAM_WIDTH_LOG-1:0]] : tcam_exp_patrn[0][chk_ptrn_num_prev[TCAM_WIDTH_LOG-1:0]] ;
                assign          chk_ptrn_hit_arr_val    = ^hit_arr_out_pst[TCAM_RULES_NUM-1:0]                                                                                                  ;
                assign          tcam_ecc_err_det        = chk_en_swpr_prev && tcam_chk_valid_pst && !(chk_ptrn_exp_val == chk_ptrn_hit_arr_val) && ~tcam_check_err_dis;

                `ifndef INTEL_SVA_OFF

                  `ASSERTS_TRIGGER (illegal_wen_ken, wr_en_pst , ~chk_en_pst, posedge clk, ~rst_n, 
                     `ERR_MSG ( "Error message KEN and WEN are both asserted" ) ) ;

                  `ASSERTS_NEVER (frontdoor_and_backdoor_simultaneous_write, (tcam_back_door_loading_indication[0] | tcam_back_door_loading_indication[1]) & tcam_exp_patrn_update_en, posedge clk, ~rst_n,
                     `ERR_MSG ("Error: not supported simultaneous frontdoor and backdoor write to TCAM"));
                `endif

        end
        else if ((TCAM_PROTECTION_TYPE == 1) && (BCAM_RELIEF == 1)) begin: BCAM_DETECT

                //
                // Expected Pattern Arrays
                //
                logic           [TCAM_WIDTH-1:0] tcam_exp_patrn[2-1:0]                                  ;
                logic                            tcam_exp_patrn_update_en                               ;
                logic           [TCAM_WIDTH-1:0] tcam_exp_patrn_update_val[2-1:0]                       ;
                
                always_ff @(posedge clk or negedge rst_n)
                        if (!rst_n) begin
                                tcam_exp_patrn[0][TCAM_WIDTH-1:0]       <= TCAM_WIDTH'(TCAM_PATRN0_EXP_RESET_VALUE)     ;
                                tcam_exp_patrn[1][TCAM_WIDTH-1:0]       <= TCAM_WIDTH'(TCAM_PATRN1_EXP_RESET_VALUE)     ;
                        end
                        else if (tcam_exp_patrn_update_en && tcam_prot_en) begin
                                tcam_exp_patrn[0][TCAM_WIDTH-1:0]       <= tcam_exp_patrn_update_val[0][TCAM_WIDTH-1:0] ;
                                tcam_exp_patrn[1][TCAM_WIDTH-1:0]       <= tcam_exp_patrn_update_val[1][TCAM_WIDTH-1:0] ;
                        end

                //
                // Read Modify Write FSM
                //
                logic           [2-1:0]                 tcam_rd_mod_wr_ps, tcam_rd_mod_wr_ns                            ;
                logic           [TCAM_ADDR_WIDTH-1:0]   adr_s                                                           ;
                logic           [TCAM_WIDTH-1:0]        wr_data_s                                                       ;
                logic           [TCAM_WIDTH-1:0]        tcam_e0_rd_data, tcam_e1_rd_data                                ;
                always_ff @(posedge clk or negedge rst_n)
                        if (!rst_n) begin
                                tcam_rd_mod_wr_ps[2-1:0]                <= `HLP_BCAM_SWPR_IDLE                              ;
                        end
                        else begin
                                tcam_rd_mod_wr_ps[2-1:0]                <= tcam_rd_mod_wr_ns[2-1:0]                     ;
                                if (tcam_rd_mod_wr_ps[2-1:0] == `HLP_BCAM_SWPR_IDLE) begin
                                        if (wr_en_pre && tcam_init_done && tcam_rdwr_rdy_pst) begin
                                                adr_s[TCAM_ADDR_WIDTH-1:0]      <= adr_pre[TCAM_ADDR_WIDTH-1:0]         ;
                                                wr_data_s[TCAM_WIDTH-1:0]       <= wr_data_pre[TCAM_WIDTH-1:0]          ;
                                        end
                                end
                                else if (tcam_rd_mod_wr_ps[2-1:0] == `HLP_BCAM_SWPR_RD) begin
                                        if (tcam_rd_valid_pst) begin
                                                tcam_e0_rd_data[TCAM_WIDTH-1:0] <= rd_data_pst[TCAM_WIDTH-1:0]          ;
                                        end
                                end
                        end

                logic                                                   chk_en_swpr                                             ;
                logic           [     TCAM_SLICE_EN_WIDTH-1:0]          slice_en_swpr                                           ;
                logic           [          TCAM_RULES_NUM-1:0]          hit_arr_in_swpr                                         ;
                logic           [              TCAM_WIDTH-1:0]          chk_key_swpr                                            ;
                logic           [              TCAM_WIDTH-1:0]          chk_mask_swpr                                           ;
                logic                                                   chk_en_swpr_cycle_done                                  ;
                logic           [TCAM_PROTECTION_RL_WIDTH-1:0]          swpr_rl_count                                           ;
                logic                                                   swpr_rl_count_done                                      ;                               
                logic                                                   chk_en_swpr_prev                                        ;
                logic                                                   chk_ptrn_1_prev                                         ;
                logic           [          TCAM_WIDTH_LOG-1:0]          chk_ptrn_num_prev, chk_ptrn_num_prev_int                ;
                logic                                                   chk_ptrn_exp_val                                        ;
                logic                                                   chk_ptrn_hit_arr_val                                    ;
                logic                                                   tcam_invert_ff_en                                       ;
                logic           [                       2-1:0]          tcam_invert_ff                                          ;

                always_ff @(posedge clk or negedge rst_n)
                        if (!rst_n) begin
                                tcam_invert_ff_en       <= 1'b1                                 ;
                                tcam_invert_ff[2-1:0]   <= {2{1'b0}}                            ;
                        end
                        else if (!(tcam_invert_0 || tcam_invert_1)) begin
                                tcam_invert_ff_en       <= 1'b1                                 ;
                                tcam_invert_ff[2-1:0]   <= {2{1'b0}}                            ;
                        end
                        else if (tcam_invert_ff_en) begin
                                tcam_invert_ff_en       <= 1'b0                                 ;
                                tcam_invert_ff[2-1:0]   <= {tcam_invert_1, tcam_invert_0}       ;
                        end
                        else if (wr_en_pst) begin
                                tcam_invert_ff[2-1:0]   <= {2{1'b0}}                            ;
                        end

                logic   [TCAM_CHK_DELAY:0]              chk_en_swpr_delay;
                logic   [TCAM_CHK_DELAY:0]              chk_ptrn_1_delay;
                logic   [TCAM_WIDTH_LOG-1:0]            chk_ptrn_num_delay[TCAM_CHK_DELAY:0];           

                assign ce_pst = rd_en_pst |  wr_en_pst | chk_en_pst | ~tcam_init_done | flush_pre;

                always_comb begin
                        adr_pst[TCAM_ADDR_WIDTH-1:0]                    = adr_pre[TCAM_ADDR_WIDTH-1:0]                  ;                               
                        rd_en_pst                                       = rd_en_pre                                     ;       
                        wr_en_pst                                       = wr_en_pre                                     ;       
                        wr_data_pst[TCAM_WIDTH-1:0]                     = wr_data_pre[TCAM_WIDTH-1:0]                   ;
                        rd_data_pre[TCAM_WIDTH-1:0]                     = rd_data_pst[TCAM_WIDTH-1:0]                   ;
                        chk_en_pst                                      = chk_en_pre || chk_en_swpr                     ;
                        slice_en_pst[TCAM_SLICE_EN_WIDTH-1:0]           = (chk_en_pre)          ? slice_en_pre[TCAM_SLICE_EN_WIDTH-1:0] : slice_en_swpr[TCAM_SLICE_EN_WIDTH-1:0];
                        hit_arr_in_pst[TCAM_RULES_NUM-1:0]              = (!chk_en_swpr_delay[1])? hit_arr_in_pre[TCAM_RULES_NUM-1:0]   : hit_arr_in_swpr[TCAM_RULES_NUM-1:0]   ;
                        chk_key_pst[TCAM_WIDTH-1:0]                     = (chk_en_pre)          ? chk_key_pre[TCAM_WIDTH-1:0]           : chk_key_swpr[TCAM_WIDTH-1:0]          ;
                        chk_mask_pst[TCAM_WIDTH-1:0]                    = (chk_en_pre)          ? chk_mask_pre[TCAM_WIDTH-1:0]          : chk_mask_swpr[TCAM_WIDTH-1:0]         ;
                        hit_arr_out_pre[TCAM_RULES_NUM-1:0]             = (!chk_en_swpr_prev)   ? hit_arr_out_pst[TCAM_RULES_NUM-1:0]   : {TCAM_RULES_NUM{1'b0}}                ;
                        tcam_rd_valid_pre                               = tcam_rd_valid_pst && (tcam_rd_mod_wr_ps[2-1:0] == `HLP_BCAM_SWPR_IDLE)                                    ;
                        tcam_wr_ack_pre                                 = tcam_wr_ack_pst                                                                                       ;
                        tcam_chk_valid_pre                              = (!chk_en_swpr_prev)   ? tcam_chk_valid_pst                    : 1'b0                                  ;
                        tcam_rdwr_rdy_pre                               = tcam_rdwr_rdy_pst                                                                                     ;
                        tcam_chk_rdy_pre                                = tcam_chk_rdy_pst                                                                                      ;
                        tcam_e1_rd_data[TCAM_WIDTH-1:0]                 = ~tcam_e0_rd_data[TCAM_WIDTH-1:0]              ;
                        tcam_exp_patrn_update_en                        = 1'b0                                          ;
                        tcam_rd_mod_wr_ns                               = `HLP_BCAM_SWPR_IDLE                               ;               
                        for (int i=0; i<TCAM_WIDTH; i=i+1) begin                                                        
                                tcam_exp_patrn_update_val[0][i] = (chk0_chng(tcam_e0_rd_data[i], tcam_e1_rd_data[i], wr_data_s[i], adr_s[0])) ^ (tcam_exp_patrn[0][i])  ;
                                tcam_exp_patrn_update_val[1][i] = (chk1_chng(tcam_e0_rd_data[i], tcam_e1_rd_data[i], wr_data_s[i], adr_s[0])) ^ (tcam_exp_patrn[1][i])  ;
                        end
                        case (tcam_rd_mod_wr_ps[2-1:0])
                                `HLP_BCAM_SWPR_IDLE: begin
                                        if (wr_en_pre && tcam_init_done && tcam_rdwr_rdy_pst && ~tcam_update_dis) begin
                                                adr_pst[TCAM_ADDR_WIDTH-1:0]    = {adr_pre[TCAM_ADDR_WIDTH-1:1], 1'b0}  ;
                                                rd_en_pst                       = 1'b1                                  ;
                                                wr_en_pst                       = 1'b0                                  ;
                                                tcam_rd_valid_pre               = 1'b0                                  ;
                                                tcam_wr_ack_pre                 = 1'b0                                  ;
                                                tcam_chk_valid_pre              = 1'b0                                  ;
                                                tcam_chk_rdy_pre                = 1'b0                                  ;
                                                tcam_rd_mod_wr_ns               = `HLP_BCAM_SWPR_RD                         ;
                                        end
                                        else begin
                                                adr_pst[TCAM_ADDR_WIDTH-1:0]    = adr_pre[TCAM_ADDR_WIDTH-1:0]          ;
                                                rd_en_pst                       = rd_en_pre                             ;
                                                wr_en_pst                       = wr_en_pre                             ;
                                                tcam_rd_mod_wr_ns               = `HLP_BCAM_SWPR_IDLE                       ;
                                        end
                                end
                                `HLP_BCAM_SWPR_RD: begin
                                        if (tcam_rd_valid_pst) begin
                                                adr_pst[TCAM_ADDR_WIDTH-1:0]    = adr_s[TCAM_ADDR_WIDTH-1:0]            ;
                                                rd_en_pst                       = 1'b0                                  ;
                                                wr_en_pst                       = 1'b1                                  ;
                                                wr_data_pst[TCAM_WIDTH-1:0]     = {wr_data_s[TCAM_WIDTH-1:2], (wr_data_s[1] ^ tcam_invert_ff[1]), (wr_data_s[0] ^ tcam_invert_ff[0])}           ;
                                                tcam_exp_patrn_update_en        = 1'b1                                  ;
                                                for (int i=0; i<TCAM_WIDTH; i=i+1) begin                                                        
                                                        tcam_exp_patrn_update_val[0][i] = (chk0_chng(rd_data_pst[i], !rd_data_pst[i], wr_data_s[i], adr_s[0])) ^ (tcam_exp_patrn[0][i]) ;
                                                        tcam_exp_patrn_update_val[1][i] = (chk1_chng(rd_data_pst[i], !rd_data_pst[i], wr_data_s[i], adr_s[0])) ^ (tcam_exp_patrn[1][i]) ;
                                                end
                                                tcam_rd_valid_pre               = 1'b0                                  ;
                                                tcam_wr_ack_pre                 = 1'b0                                  ;
                                                tcam_chk_valid_pre              = 1'b0                                  ;
                                                tcam_rdwr_rdy_pre               = 1'b0                                  ;
                                                tcam_chk_rdy_pre                = 1'b0                                  ;
                                                tcam_rd_mod_wr_ns               = `HLP_BCAM_SWPR_WR                         ;
                                        end
                                        else begin
                                                adr_pst[TCAM_ADDR_WIDTH-1:0]    = {adr_s[TCAM_ADDR_WIDTH-1:1], 1'b0}    ;
                                                rd_en_pst                       = 1'b0                                  ;
                                                wr_en_pst                       = 1'b0                                  ;
                                                tcam_rd_valid_pre               = 1'b0                                  ;
                                                tcam_wr_ack_pre                 = 1'b0                                  ;
                                                tcam_chk_valid_pre              = 1'b0                                  ;
                                                tcam_rdwr_rdy_pre               = 1'b0                                  ;
                                                tcam_chk_rdy_pre                = 1'b0                                  ;
                                                tcam_rd_mod_wr_ns               = `HLP_BCAM_SWPR_RD                         ;
                                        end
                                end
                                `HLP_BCAM_SWPR_WR: begin
                                        if (tcam_rdwr_rdy_pst) begin
                                                adr_pst[TCAM_ADDR_WIDTH-1:0]    = {adr_s[TCAM_ADDR_WIDTH-1:1], !adr_s[0]};
                                                rd_en_pst                       = 1'b0                                  ;
                                                wr_en_pst                       = 1'b1                                  ;
                                                wr_data_pst[TCAM_WIDTH-1:0]     = ~wr_data_s[TCAM_WIDTH-1:0]            ;
                                                tcam_exp_patrn_update_en        = 1'b1                                  ;
                                                for (int i=0; i<TCAM_WIDTH; i=i+1) begin                                                        
                                                        tcam_exp_patrn_update_val[0][i] = (chk0_chng(((adr_s[0]) ? tcam_e0_rd_data[i] : wr_data_s[i]), ((adr_s[0]) ? wr_data_s[i] : tcam_e1_rd_data[i]), !wr_data_s[i], !adr_s[0])) ^ (tcam_exp_patrn[0][i])    ;
                                                        tcam_exp_patrn_update_val[1][i] = (chk1_chng(((adr_s[0]) ? tcam_e0_rd_data[i] : wr_data_s[i]), ((adr_s[0]) ? wr_data_s[i] : tcam_e1_rd_data[i]), !wr_data_s[i], !adr_s[0])) ^ (tcam_exp_patrn[1][i])    ;
                                                end
                                                tcam_rd_valid_pre               = 1'b0                                  ;
                                                tcam_wr_ack_pre                 = 1'b1                                  ;
                                                tcam_chk_valid_pre              = 1'b0                                  ;
                                                tcam_rdwr_rdy_pre               = 1'b0                                  ;
                                                tcam_chk_rdy_pre                = 1'b0                                  ;
                                                tcam_rd_mod_wr_ns               = `HLP_BCAM_SWPR_IDLE                       ;
                                        end
                                        else begin
                                                adr_pst[TCAM_ADDR_WIDTH-1:0]    = adr_s[TCAM_ADDR_WIDTH-1:0]            ;
                                                rd_en_pst                       = 1'b0                                  ;
                                                wr_en_pst                       = 1'b0                                  ;
                                                wr_data_pst[TCAM_WIDTH-1:0]     = wr_data_s[TCAM_WIDTH-1:0]             ;
                                                tcam_rd_valid_pre               = 1'b0                                  ;
                                                tcam_wr_ack_pre                 = 1'b0                                  ;
                                                tcam_chk_valid_pre              = 1'b0                                  ;
                                                tcam_rdwr_rdy_pre               = 1'b0                                  ;
                                                tcam_chk_rdy_pre                = 1'b0                                  ;
                                                tcam_rd_mod_wr_ns               = `HLP_BCAM_SWPR_WR                         ;
                                        end
                                end                             
                                default: begin
                                        adr_pst[TCAM_ADDR_WIDTH-1:0]            = adr_pre[TCAM_ADDR_WIDTH-1:0]          ;                               
                                        rd_en_pst                               = rd_en_pre                             ;       
                                        wr_en_pst                               = wr_en_pre                             ;       
                                        wr_data_pst[TCAM_WIDTH-1:0]             = wr_data_pre[TCAM_WIDTH-1:0]           ;
                                        rd_data_pre[TCAM_WIDTH-1:0]             = rd_data_pst[TCAM_WIDTH-1:0]           ;
                                        chk_en_pst                              = chk_en_pre || chk_en_swpr                                                                             ;
                                        slice_en_pst[TCAM_SLICE_EN_WIDTH-1:0]   = (chk_en_pre)          ? slice_en_pre[TCAM_SLICE_EN_WIDTH-1:0] : slice_en_swpr[TCAM_SLICE_EN_WIDTH-1:0];
                                        hit_arr_in_pst[TCAM_RULES_NUM-1:0]      = (!chk_en_swpr_delay[1])? hit_arr_in_pre[TCAM_RULES_NUM-1:0]   : hit_arr_in_swpr[TCAM_RULES_NUM-1:0]   ;
                                        chk_key_pst[TCAM_WIDTH-1:0]             = (chk_en_pre)          ? chk_key_pre[TCAM_WIDTH-1:0]           : chk_key_swpr[TCAM_WIDTH-1:0]          ;
                                        chk_mask_pst[TCAM_WIDTH-1:0]            = (chk_en_pre)          ? chk_mask_pre[TCAM_WIDTH-1:0]          : chk_mask_swpr[TCAM_WIDTH-1:0]         ;
                                        hit_arr_out_pre[TCAM_RULES_NUM-1:0]     = (!chk_en_swpr_prev)   ? hit_arr_out_pst[TCAM_RULES_NUM-1:0]   : {TCAM_RULES_NUM{1'b0}}                ;
                                        tcam_rd_valid_pre                       = tcam_rd_valid_pst &&  (tcam_rd_mod_wr_ps[2-1:0] == `HLP_BCAM_SWPR_IDLE)                                   ;
                                        tcam_wr_ack_pre                         = tcam_wr_ack_pst                                                                                       ;
                                        tcam_chk_valid_pre                      = (!chk_en_swpr_prev)   ? tcam_chk_valid_pst                    : 1'b0                                  ;
                                        tcam_rdwr_rdy_pre                       = tcam_rdwr_rdy_pst                     ;
                                        tcam_chk_rdy_pre                        = tcam_chk_rdy_pst                      ;
                                        tcam_e1_rd_data[TCAM_WIDTH-1:0]         = ~tcam_e0_rd_data[TCAM_WIDTH-1:0]      ;
                                        tcam_exp_patrn_update_en                = 1'b0                                  ;
                                        for (int i=0; i<TCAM_WIDTH; i=i+1) begin                                                        
                                                tcam_exp_patrn_update_val[0][i] = (chk0_chng(tcam_e0_rd_data[i], tcam_e1_rd_data[i], wr_data_s[i], adr_s[0])) ^ (tcam_exp_patrn[0][i])  ;
                                                tcam_exp_patrn_update_val[1][i] = (chk1_chng(tcam_e0_rd_data[i], tcam_e1_rd_data[i], wr_data_s[i], adr_s[0])) ^ (tcam_exp_patrn[1][i])  ;
                                        end
                                        tcam_rd_mod_wr_ns                       = `HLP_BCAM_SWPR_IDLE                       ;                                       
                                end
                        endcase
                end

                // Checking and Patterns
                logic                                           tcam_func_access                ;
                logic                                           chk_ptrn_1                      ;
                
                assign                                          tcam_func_access        = (rd_en_pst || wr_en_pst || chk_en_pre)                                ;

                assign                                          chk_en_swpr                             = tcam_prot_en && !tcam_func_access && tcam_init_done && tcam_chk_rdy_pst && (tcam_rd_mod_wr_ps[2-1:0] == `HLP_BCAM_SWPR_IDLE) && swpr_rl_count_done  && !chk_en_swpr_cycle_done;
                assign                                          slice_en_swpr[TCAM_SLICE_EN_WIDTH-1:0]  = {TCAM_SLICE_EN_WIDTH{1'b1}}                           ;
                assign                                          hit_arr_in_swpr[TCAM_RULES_NUM-1:0]     = {TCAM_RULES_NUM{1'b1}}                                ;
                // Patterns Generation
                always_ff @(posedge clk or negedge rst_n)
                        if (!rst_n) begin
                                chk_ptrn_1                              <= 1'b1                                                                 ;
                                chk_key_swpr[TCAM_WIDTH-1:0]            <= {{(TCAM_WIDTH-1){1'b0}}, 1'b1}                                       ;
                                chk_mask_swpr[TCAM_WIDTH-1:0]           <= {{(TCAM_WIDTH-1){1'b0}}, 1'b1}                                       ;
                                chk_en_swpr_cycle_done                  <= 1'b0                                                                 ;                        
                        end
                        else if (chk_en_swpr) begin
                                if (chk_ptrn_1) begin
                                // Pattern 1
                                        chk_ptrn_1                                      <= 1'b0                                                                 ;
                                        chk_key_swpr[TCAM_WIDTH-1:0]                    <= chk_key_swpr[TCAM_WIDTH-1:0] & (~chk_mask_swpr[TCAM_WIDTH-1:0])      ;
                                        chk_en_swpr_cycle_done                          <= 1'b0                                                                 ;                                
                                end
                                else begin
                                // Pattern 0
                                        chk_ptrn_1                                      <= 1'b1                                                                 ;
                                        if (chk_mask_swpr[TCAM_WIDTH-1:0] == {1'b1, {(TCAM_WIDTH-1){1'b0}}}) begin
                                        // Overlap
                                                chk_key_swpr[TCAM_WIDTH-1:0]            <= {{(TCAM_WIDTH-1){1'b0}}, 1'b1}                                       ;
                                                chk_mask_swpr[TCAM_WIDTH-1:0]           <= {{(TCAM_WIDTH-1){1'b0}}, 1'b1}                                       ;
                                                chk_en_swpr_cycle_done                  <= 1'b1                                                                 ;                                        
                                        end
                                        else begin
                                        // Shift Left
                                                chk_key_swpr[TCAM_WIDTH-1:0]            <= (chk_key_swpr[TCAM_WIDTH-1:0] | chk_mask_swpr[TCAM_WIDTH-1:0]) << 1  ;
                                                chk_mask_swpr[TCAM_WIDTH-1:0]           <= chk_mask_swpr[TCAM_WIDTH-1:0] << 1                                   ;
                                                chk_en_swpr_cycle_done                  <= 1'b0                                                                 ;                                        
                                        end
                                end
                        end
                        else begin  // no check_en_swpr
                              chk_en_swpr_cycle_done                                    <= 1'b0                                                                 ;
                        end

                always_ff @(posedge clk or negedge rst_n)
                        if (!rst_n) begin
                                swpr_rl_count[TCAM_PROTECTION_RL_WIDTH-1:0]     <= {TCAM_PROTECTION_RL_WIDTH{1'b0}}                                                     ;
                        end
                        else if (chk_en_swpr_cycle_done) begin
                                swpr_rl_count[TCAM_PROTECTION_RL_WIDTH-1:0]     <= TCAM_PROTECTION_RL_WIDTH'(TCAM_PROTECTION_RL)                                        ;
                        end
                        else if (|swpr_rl_count[TCAM_PROTECTION_RL_WIDTH-1:0]) begin
                                swpr_rl_count[TCAM_PROTECTION_RL_WIDTH-1:0]     <= swpr_rl_count[TCAM_PROTECTION_RL_WIDTH-1:0] - {{(TCAM_PROTECTION_RL_WIDTH-1){1'b0}}, 1'b1};
                        end
                assign          swpr_rl_count_done                              = (swpr_rl_count[TCAM_PROTECTION_RL_WIDTH-1:0] == {TCAM_PROTECTION_RL_WIDTH{1'b0}})     ;                       
                // Actual Checking

                hlp_mgm_gen_ffs #(
                        .INP_WDTH       (TCAM_WIDTH)
                ) gen_ffs (
                        .inp_vect       (chk_mask_swpr[TCAM_WIDTH-1:0])                 ,
                        .fs_idx         (chk_ptrn_num_prev_int[TCAM_WIDTH_LOG-1:0])     ,
                        .fs_vld         ()
                );              

                always_comb begin
                        chk_en_swpr_delay[0]                                                    = chk_en_swpr                                   ;
                        chk_ptrn_1_delay[0]                                                     = chk_ptrn_1                                    ;
                        chk_ptrn_num_delay[0][TCAM_WIDTH_LOG-1:0]                               = chk_ptrn_num_prev_int[TCAM_WIDTH_LOG-1:0]     ;
                        chk_en_swpr_prev                                                        = chk_en_swpr_delay[TCAM_CHK_DELAY]             ;
                        chk_ptrn_1_prev                                                         = chk_ptrn_1_delay[TCAM_CHK_DELAY]              ;
                        chk_ptrn_num_prev[TCAM_WIDTH_LOG-1:0]                                   = chk_ptrn_num_delay[TCAM_CHK_DELAY][TCAM_WIDTH_LOG-1:0]        ;                       
                end
                always_ff @(posedge clk or negedge rst_n) begin
                        if (!rst_n) begin
                                for (int i=1; i<=TCAM_CHK_DELAY; i=i+1) begin
                                        chk_en_swpr_delay[i]                                    <= 1'b0                                         ;
                                end
                        end
                        else begin
                                for (int i=1; i<=TCAM_CHK_DELAY; i=i+1) begin
                                        chk_en_swpr_delay[i]                                    <= chk_en_swpr_delay[i-1]                       ;
                                        if (chk_en_swpr_delay[i-1]) begin
                                                chk_ptrn_1_delay[i]                             <= chk_ptrn_1_delay[i-1]                        ;
                                                chk_ptrn_num_delay[i][TCAM_WIDTH_LOG-1:0]       <= chk_ptrn_num_delay[i-1][TCAM_WIDTH_LOG-1:0]  ;
                                        end
                                end
                        end                     
                end
                
                assign          chk_ptrn_exp_val        = chk_ptrn_1_prev ? tcam_exp_patrn[1][chk_ptrn_num_prev[TCAM_WIDTH_LOG-1:0]] : tcam_exp_patrn[0][chk_ptrn_num_prev[TCAM_WIDTH_LOG-1:0]] ;
                assign          chk_ptrn_hit_arr_val    = ^hit_arr_out_pst[TCAM_RULES_NUM-1:0]                                                                                                  ;
                assign          tcam_ecc_err_det        = chk_en_swpr_prev && tcam_chk_valid_pst && !(chk_ptrn_exp_val == chk_ptrn_hit_arr_val) && ~ tcam_check_err_dis ;
        end
endgenerate

endmodule
