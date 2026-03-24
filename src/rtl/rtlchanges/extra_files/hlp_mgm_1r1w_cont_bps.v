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
//    FILENAME          : mgm_1r1w_cont_bps.v
//    DESIGNER          : Yevgeny Yankilevich
//    DATE              : 16/02/16
//    REVISION NUMBER   : 1.0
//    DESCRIPTION       :
//
//          1r1w Read Write to the same address contention resolving bypass mux:
//              
//          0 - No MUX
//          1 - Read Data will get New Data
//          2 - Read Data will get Old Data
//---------------------------------------------------------------------------//
// --------------------------------------------------------------------------//
//      LAST MODIFICATION:      16/02/16
//      RECENT AUTHORS:         yevgeny.yankilevich@intel.com
//      PREVIOUS RELEASES:      
//                              16/02/16: First version.
// --------------------------------------------------------------------------//
module hlp_mgm_1r1w_cont_bps #(
                parameter       MEM_CONT_BPS_MUX_TYPE                   = 0                                                                     , // 0 - No MUX, 1 - New Data, 2 - Old Data
                parameter       MEM_WIDTH                               = 42                                                                    , // Number of Memory lines.
                parameter       MEM_DEPTH                               = 3072                                                                  , // Memory line width in bits.
                parameter       MEM_WR_RESOLUTION                       = MEM_WIDTH                                                             , // Write Resolution to the Memory: Should be a divisor of the MEM_WIDTH.
                parameter       MEM_WR_EN_WIDTH                         = (MEM_WIDTH/MEM_WR_RESOLUTION)                                         , // Memory Write enable width. 
                parameter       MEM_ADR_WIDTH                           = (MEM_DEPTH>1) ? $clog2(MEM_DEPTH) : 1                                   // Memory Address bus width.
)(
                //------------------- clock and reset -------------------
                input  logic                            clk                     ,
                input  logic                            reset_n                 ,
                //---------------- Functional Interface In --------------
                input  logic    [  MEM_ADR_WIDTH-1:0]   rd_adr_pre              ,
                input  logic    [  MEM_ADR_WIDTH-1:0]   wr_adr_pre              ,
                input  logic                            rd_en_pre               ,
                input  logic    [MEM_WR_EN_WIDTH-1:0]   wr_en_pre               ,
                input  logic    [      MEM_WIDTH-1:0]   wr_data_pre             ,
                input  logic    [      MEM_WIDTH-1:0]   rd_data_pre             ,
                input  logic                            rd_valid_pre            ,
                //--------------- Functional Interface Out --------------
                output  logic [  MEM_ADR_WIDTH-1:0]     rd_adr_pst              ,
                output  logic [  MEM_ADR_WIDTH-1:0]     wr_adr_pst              ,
                output  logic                           rd_en_pst               ,
                output  logic [MEM_WR_EN_WIDTH-1:0]     wr_en_pst               ,
                output  logic [      MEM_WIDTH-1:0]     wr_data_pst             ,
                output  logic [      MEM_WIDTH-1:0]     rd_data_pst             ,
                output  logic                           rd_valid_pst            ,
                output  logic                           rd_valid_int
);

        generate
                if (MEM_CONT_BPS_MUX_TYPE == 1) begin: NEW_DATA
                        logic                           rd_wr_same_addr_evnt                                            ;
                        logic                           rd_wr_same_addr_evnt_s                                          ;
                        logic   [MEM_WR_EN_WIDTH-1:0]   rd_wr_same_addr_evnt_wr_en_s                                    ;
                        logic   [MEM_WIDTH-1:0]         rd_wr_same_addr_new_data                                        ;
                        
                        assign                  rd_wr_same_addr_evnt = rd_en_pre && (|wr_en_pre[MEM_WR_EN_WIDTH-1:0]) && (rd_adr_pre[MEM_ADR_WIDTH-1:0] == wr_adr_pre[MEM_ADR_WIDTH-1:0])       ;
                        always_ff  @(posedge clk or negedge reset_n)
                                if (!reset_n) begin
                                        rd_wr_same_addr_evnt_wr_en_s[MEM_WR_EN_WIDTH-1:0]                                       <= {MEM_WR_EN_WIDTH{1'b0}}                              ;
                                        rd_wr_same_addr_new_data[MEM_WIDTH-1:0]                                                 <= {MEM_WIDTH{1'b0}}                                    ;
                                end
                                else if (rd_wr_same_addr_evnt) begin
                                        rd_wr_same_addr_evnt_wr_en_s[MEM_WR_EN_WIDTH-1:0]                                       <= wr_en_pre[MEM_WR_EN_WIDTH-1:0]                       ;
                                        for (int i=0; i<MEM_WR_EN_WIDTH; i=i+1) begin
                                                if (wr_en_pre[i]) begin
                                                        rd_wr_same_addr_new_data[i*MEM_WR_RESOLUTION+:MEM_WR_RESOLUTION]        <= wr_data_pre[i*MEM_WR_RESOLUTION+:MEM_WR_RESOLUTION]  ;
                                                end
                                        end
                                end
                                else if (|rd_wr_same_addr_evnt_wr_en_s[MEM_WR_EN_WIDTH-1:0]) begin
                                        rd_wr_same_addr_evnt_wr_en_s[MEM_WR_EN_WIDTH-1:0]                                       <= {MEM_WR_EN_WIDTH{1'b0}}                                              ;
                                        for (int i=0; i<MEM_WR_EN_WIDTH; i=i+1) begin
                                                if (!rd_wr_same_addr_evnt_wr_en_s[i]) begin
                                                        rd_wr_same_addr_new_data[i*MEM_WR_RESOLUTION+:MEM_WR_RESOLUTION]        <= rd_data_pre[i*MEM_WR_RESOLUTION+:MEM_WR_RESOLUTION]                  ;
                                                end
                                        end
                                end

                        always_ff  @(posedge clk or negedge reset_n)
                                if (!reset_n) begin
                                        rd_wr_same_addr_evnt_s          <= 1'b0;
                                end
                                else if (rd_wr_same_addr_evnt) begin
                                        rd_wr_same_addr_evnt_s          <= 1'b1;
                                end
                                else if (rd_en_pre) begin
                                        rd_wr_same_addr_evnt_s          <= 1'b0;
                                end

                        always_ff  @(posedge clk or negedge reset_n)
                                if (!reset_n) begin
                                        rd_valid_int                    <= 1'b0                                                 ;
                                end
                                else begin
                                        rd_valid_int                    <= (&wr_en_pre[MEM_WR_EN_WIDTH-1:0]) && rd_en_pre       ;
                                end
                
                        always_comb begin
                                rd_adr_pst[MEM_ADR_WIDTH-1:0]   = rd_adr_pre[MEM_ADR_WIDTH-1:0]                                                                 ;
                                wr_adr_pst[MEM_ADR_WIDTH-1:0]   = wr_adr_pre[MEM_ADR_WIDTH-1:0]                                                                 ;
                                rd_en_pst                       = rd_wr_same_addr_evnt ? !(&wr_en_pre[MEM_WR_EN_WIDTH-1:0]) && rd_en_pre : rd_en_pre            ;
                                wr_en_pst[MEM_WR_EN_WIDTH-1:0]  = wr_en_pre[MEM_WR_EN_WIDTH-1:0]                                                                ;
                                wr_data_pst[MEM_WIDTH-1:0]      = wr_data_pre[MEM_WIDTH-1:0]                                                                    ;
                                rd_valid_pst                    = rd_valid_pre                                                                                  ;
                        end

                        always_comb begin
                                rd_data_pst[MEM_WIDTH-1:0]                                                              = rd_data_pre[MEM_WIDTH-1:0]                                            ;                                               
                                if (rd_wr_same_addr_evnt_s) begin
                                        if (rd_valid_pre) begin
                                                for (int i=0; i<MEM_WR_EN_WIDTH; i=i+1) begin
                                                        if (rd_wr_same_addr_evnt_wr_en_s[i]) begin
                                                                rd_data_pst[i*MEM_WR_RESOLUTION+:MEM_WR_RESOLUTION]     = rd_wr_same_addr_new_data[i*MEM_WR_RESOLUTION+:MEM_WR_RESOLUTION]      ;
                                                        end
                                                end
                                        end
                                        else begin
                                                rd_data_pst[MEM_WIDTH-1:0]                                              = rd_wr_same_addr_new_data[MEM_WIDTH-1:0]                               ;                                                       
                                        end
                                end
                        end
                end
                else if (MEM_CONT_BPS_MUX_TYPE == 2) begin: OLD_DATA
                        
                        logic   [MEM_WR_EN_WIDTH-1:0]   wr_en_s                                                         ;
                        logic   [MEM_ADR_WIDTH-1:0]     wr_adr_s                                                        ;
                        logic   [MEM_WIDTH-1:0]         wr_data_s                                                       ;
                        always_ff  @(posedge clk or negedge reset_n)
                                if (!reset_n) begin
                                        wr_en_s[MEM_WR_EN_WIDTH-1:0]    <= {MEM_WR_EN_WIDTH{1'b0}}                      ;
                                        wr_adr_s[MEM_ADR_WIDTH-1:0]     <= {MEM_ADR_WIDTH{1'b0}}                        ;
                                        wr_data_s[MEM_WIDTH-1:0]        <= {MEM_WIDTH{1'b0}}                            ;
                                end
                                else if (|wr_en_pre[MEM_WR_EN_WIDTH-1:0]) begin
                                        wr_en_s[MEM_WR_EN_WIDTH-1:0]    <= wr_en_pre[MEM_WR_EN_WIDTH-1:0]               ;
                                        wr_adr_s[MEM_ADR_WIDTH-1:0]     <= wr_adr_pre[MEM_ADR_WIDTH-1:0]                ;
                                        wr_data_s[MEM_WIDTH-1:0]        <= wr_data_pre[MEM_WIDTH-1:0]                   ;
                                end
                                else if (|wr_en_s[MEM_WR_EN_WIDTH-1:0]) begin
                                        wr_en_s[MEM_WR_EN_WIDTH-1:0]    <= {MEM_WR_EN_WIDTH{1'b0}}                      ;
                                end
                        
                        logic                           rd_wr_same_addr_evnt                                            ;
                        logic                           rd_wr_same_addr_evnt_s                                          ;
                        logic   [MEM_WR_EN_WIDTH-1:0]   rd_wr_same_addr_evnt_wr_en_s                                    ;
                        logic   [MEM_WIDTH-1:0]         rd_wr_same_addr_old_data                                        ;
                        
                        assign                          rd_wr_same_addr_evnt    = rd_en_pre && (|wr_en_s[MEM_WR_EN_WIDTH-1:0]) && (rd_adr_pre[MEM_ADR_WIDTH-1:0] == wr_adr_s[MEM_ADR_WIDTH-1:0])        ;
                        always_ff  @(posedge clk or negedge reset_n)
                                if (!reset_n) begin
                                        rd_wr_same_addr_evnt_wr_en_s[MEM_WR_EN_WIDTH-1:0]                                       <= {MEM_WR_EN_WIDTH{1'b0}}                                              ;
                                        rd_wr_same_addr_old_data[MEM_WIDTH-1:0]                                                 <= {MEM_WIDTH{1'b0}}                                                    ;
                                end
                                else if (rd_wr_same_addr_evnt) begin
                                        rd_wr_same_addr_evnt_wr_en_s[MEM_WR_EN_WIDTH-1:0]                                       <= wr_en_s[MEM_WR_EN_WIDTH-1:0]                                         ;
                                        for (int i=0; i<MEM_WR_EN_WIDTH; i=i+1) begin
                                                if (wr_en_s[i]) begin
                                                        rd_wr_same_addr_old_data[i*MEM_WR_RESOLUTION+:MEM_WR_RESOLUTION]        <= wr_data_s[i*MEM_WR_RESOLUTION+:MEM_WR_RESOLUTION]                    ;
                                                end
                                        end
                                end
                                else if (|rd_wr_same_addr_evnt_wr_en_s[MEM_WR_EN_WIDTH-1:0]) begin
                                        rd_wr_same_addr_evnt_wr_en_s[MEM_WR_EN_WIDTH-1:0]                                       <= {MEM_WR_EN_WIDTH{1'b0}}                                              ;
                                        for (int i=0; i<MEM_WR_EN_WIDTH; i=i+1) begin
                                                if (!rd_wr_same_addr_evnt_wr_en_s[i]) begin
                                                        rd_wr_same_addr_old_data[i*MEM_WR_RESOLUTION+:MEM_WR_RESOLUTION]        <= rd_data_pre[i*MEM_WR_RESOLUTION+:MEM_WR_RESOLUTION]                  ;
                                                end
                                        end
                                end

                        always_ff  @(posedge clk or negedge reset_n)
                                if (!reset_n) begin
                                        rd_wr_same_addr_evnt_s          <= 1'b0;
                                end
                                else if (rd_wr_same_addr_evnt) begin
                                        rd_wr_same_addr_evnt_s          <= 1'b1;
                                end
                                else if (rd_en_pre) begin
                                        rd_wr_same_addr_evnt_s          <= 1'b0;
                                end

                        always_ff  @(posedge clk or negedge reset_n)
                                if (!reset_n) begin
                                        rd_valid_int                    <= 1'b0                                                 ;
                                end
                                else begin
                                        rd_valid_int                    <= (&wr_en_s[MEM_WR_EN_WIDTH-1:0]) && rd_en_pre         ;
                                end
                                
                        always_comb begin
                                rd_adr_pst[MEM_ADR_WIDTH-1:0]   = rd_adr_pre[MEM_ADR_WIDTH-1:0]                                                                         ;
                                wr_adr_pst[MEM_ADR_WIDTH-1:0]   = wr_adr_s[MEM_ADR_WIDTH-1:0]                                                                           ;
                                rd_en_pst                       = rd_wr_same_addr_evnt ? !(&wr_en_s[MEM_WR_EN_WIDTH-1:0]) && rd_en_pre : rd_en_pre                      ;
                                wr_en_pst[MEM_WR_EN_WIDTH-1:0]  = wr_en_s[MEM_WR_EN_WIDTH-1:0]                                                                          ;
                                wr_data_pst[MEM_WIDTH-1:0]      = wr_data_s[MEM_WIDTH-1:0]                                                                              ;
                                rd_valid_pst                    = rd_valid_pre                                                                                          ;       
                        end

                        always_comb begin
                                rd_data_pst[MEM_WIDTH-1:0]                                                              = rd_data_pre[MEM_WIDTH-1:0]                                            ;                                               
                                if (rd_wr_same_addr_evnt_s) begin
                                        if (rd_valid_pre) begin
                                                for (int i=0; i<MEM_WR_EN_WIDTH; i=i+1) begin
                                                        if (rd_wr_same_addr_evnt_wr_en_s[i]) begin
                                                                rd_data_pst[i*MEM_WR_RESOLUTION+:MEM_WR_RESOLUTION]     = rd_wr_same_addr_old_data[i*MEM_WR_RESOLUTION+:MEM_WR_RESOLUTION]      ;
                                                        end
                                                end
                                        end
                                        else begin
                                                rd_data_pst[MEM_WIDTH-1:0]                                              = rd_wr_same_addr_old_data[MEM_WIDTH-1:0]                               ;                                                       
                                        end
                                end
                        end
                end
                else begin: NO_BPS_MUX
                        always_comb begin
                                rd_adr_pst[MEM_ADR_WIDTH-1:0]   = rd_adr_pre[MEM_ADR_WIDTH-1:0]         ;
                                wr_adr_pst[MEM_ADR_WIDTH-1:0]   = wr_adr_pre[MEM_ADR_WIDTH-1:0]         ;
                                rd_en_pst                       = rd_en_pre                             ;
                                wr_en_pst[MEM_WR_EN_WIDTH-1:0]  = wr_en_pre[MEM_WR_EN_WIDTH-1:0]        ;
                                wr_data_pst[MEM_WIDTH-1:0]      = wr_data_pre[MEM_WIDTH-1:0]            ;
                                rd_data_pst[MEM_WIDTH-1:0]      = rd_data_pre[MEM_WIDTH-1:0]            ;
                                rd_valid_pst                    = rd_valid_pre                          ;  
                                rd_valid_int                    = 1'b0                                  ;
                        end
                end
        endgenerate

endmodule//mgm_1r1w_cont_bps
