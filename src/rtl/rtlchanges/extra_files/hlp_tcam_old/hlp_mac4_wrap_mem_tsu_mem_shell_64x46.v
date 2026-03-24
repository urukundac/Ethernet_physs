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
`include        "hlp_mac4_mem.def"
module  hlp_mac4_wrap_mem_tsu_mem_shell_64x46 #(
                // Memory General Parameters
                parameter MEM_WIDTH                     = 42                                                                                                                            ,
                parameter MEM_DEPTH                     = 3086                                                                                                                          ,
                parameter MEM_WR_RESOLUTION             = MEM_WIDTH                                                                                                                     ,
                parameter MEM_WR_EN_WIDTH               = (MEM_WIDTH/MEM_WR_RESOLUTION)                                                                                                 ,
                parameter MEM_DELAY                     = 1                                                                                                                             ,
                parameter MEM_PST_EBB_SAMPLE            = 0                                                                                                                             ,
                parameter MEM_ADR_WIDTH                 = (MEM_DEPTH>1) ? $clog2(MEM_DEPTH) : 1                                                                                         ,
                parameter MEM_RM_WIDTH                  = `HLP_MEM_RM_WIDTH                                                                                                         ,
                parameter FROM_MEM_WIDTH                = MEM_WIDTH + 1                                                                                                                 ,
                parameter TO_MEM_WIDTH                  = 0+1+MEM_RM_WIDTH+1+1+MEM_WR_EN_WIDTH+ (2 * MEM_ADR_WIDTH) +MEM_WIDTH                                                                  ,                                       
                // FAST_CONFIG Parameters
                parameter MEM_INIT_TYPE                 = 1                                                                                                                             , // 1 - Const. Val. Init., 2 - LL, Other - No Init.
                parameter LL_INIT_OFFSET                = 1                                                                                                                             ,
                parameter LL_IS_LAST                    = 1                                                                                                                             ,
                parameter MEM_INIT_VALUE                = 0                                                                                                                             ,
                parameter MEM_INIT_VALUE_WIDTH          = $bits(MEM_INIT_VALUE)                                                                                                         ,
                parameter MEM_PROT_TYPE                 = 0                                                                                                                             ,
                parameter MEM_PROT_RESOLUTION           = MEM_WR_RESOLUTION                                                                                                             ,
                parameter MEM_PROT_INST_WIDTH           = (MEM_PROT_TYPE == 0) ? $clog2(MEM_PROT_RESOLUTION+$clog2(MEM_PROT_RESOLUTION)+1)+1 : 1                                        ,                                                                                                                               
                parameter MEM_INIT_PROT_INST_NUM        = MEM_INIT_VALUE_WIDTH/MEM_PROT_RESOLUTION                                                                                      ,

                parameter       MEM_WIDTH_NO_SIG                        = MEM_INIT_VALUE_WIDTH                                                                                                  ,
                parameter       MEM_WR_RESOLUTION_NO_SIG                = MEM_WIDTH_NO_SIG                                                                                                      ,
                parameter       MEM_WR_RES_PROT_FRAGM                   = 1                                                                                                                     , // Memory Write Resolution Fragmentation for Protection.      
                parameter       MEM_WR_RESOLUTION_ZERO_PADDING          = (MEM_PROT_RESOLUTION * MEM_WR_RES_PROT_FRAGM) - MEM_WR_RESOLUTION_NO_SIG                                       , // Memory Write Resolution Zero Padding.
                parameter       MEM_PROT_INTERLV_LEVEL                  = 1                                                                                                                     , // Memory Protection Bits Interleaving Level: 1 - No Interleaving, 2 - Every 2 bits (grouping of even and odd bits), 3 - Every 3 bits and Etc.
                parameter       MEM_PROT_PER_GEN_INST                   = (MEM_PROT_RESOLUTION % MEM_PROT_INTERLV_LEVEL) ? ((MEM_PROT_RESOLUTION-(MEM_PROT_RESOLUTION % MEM_PROT_INTERLV_LEVEL))/MEM_PROT_INTERLV_LEVEL) + 1 : (MEM_PROT_RESOLUTION/MEM_PROT_INTERLV_LEVEL)     , // Memory Width per protection module.
                parameter       MEM_PROT_RESOLUTION_ZERO_PADDING        = (MEM_PROT_PER_GEN_INST * MEM_PROT_INTERLV_LEVEL) - MEM_PROT_RESOLUTION                                         , // Memory Protection Resolution Zero Padding.
                parameter       MEM_TOTAL_ZERO_PADDING                  = ((MEM_PROT_RESOLUTION_ZERO_PADDING * MEM_WR_RES_PROT_FRAGM) + MEM_WR_RESOLUTION_ZERO_PADDING) * MEM_WR_EN_WIDTH       , // Memory Total Zero Padding. 
                parameter       MEM_PROT_TOTAL_GEN_INST                 = MEM_PROT_INTERLV_LEVEL * MEM_WR_RES_PROT_FRAGM * MEM_WR_EN_WIDTH                                                      ,
                parameter       MEM_PROT_INST_WIDTH_NO_SIG              = (MEM_PROT_TYPE == 0) ? $clog2(MEM_PROT_PER_GEN_INST+$clog2(MEM_PROT_PER_GEN_INST)+1)+1 : (MEM_PROT_TYPE == 1) ? 1 : 0 , // Data Integrity signature width for a single chunk of protected data
                parameter       MEM_PROT_TOTAL_WIDTH                    = MEM_PROT_TOTAL_GEN_INST * MEM_PROT_INST_WIDTH_NO_SIG                                                                         , // Total width of the Data Integrity signatures in Memory line.




                // FPGA Memory Parameters
                parameter FPGA_MEM_ZERO_PADDING         = (8 - (MEM_WR_RESOLUTION % 8)) % 8                                                                                             ,
                parameter FPGA_MEM_WR_RESOLUTION        = MEM_WR_RESOLUTION + FPGA_MEM_ZERO_PADDING                                                                                     ,
                parameter FPGA_MEM_WIDTH                = MEM_WR_EN_WIDTH*(FPGA_MEM_WR_RESOLUTION)                                                                                      ,
                parameter FPGA_MEM_WR_EN_WIDTH          = FPGA_MEM_WIDTH/8                                                                                                              
                // DFx Memory Parameters
               ,
                parameter MSWT_MODE                             = 0                                                                     ,
                parameter BYPASS_RD_CLK_MUX                     = 0                                                                     ,
                parameter BYPASS_WR_CLK_MUX                     = 0                                                                     ,
                parameter BYPASS_AFD_SYNC                       = 1                                                                     ,
                parameter BYPASS_RST_B_SYNC                     = 1                                                                     ,
                parameter BYPASS_MBIST_EN_SYNC                  = 0                                                                     ,
                parameter NFUSE_RF                              = 7                                                                     ,
                parameter PWR_MGMT_IN_SIZE                      = 5                                                                     ,
                parameter NFUSERED_RF                           = $clog2(MEM_WIDTH) + 1                                                 ,
                parameter TOTAL_MEMORY_INSTANCE                 = 1                                               ,
                parameter TOTAL_WRITEABLE_MEMORY_INSTANCE       = 1                                     
)(
        // Memory General Interface
        input                                                   clk_a                           ,
        input                                                   clk_b                           ,
        input           [  TO_MEM_WIDTH-1:0]                    wrap_shell_to_mem               ,
        output  wire    [FROM_MEM_WIDTH-1:0]                    wrap_shell_from_mem             
        // Memory DFx Interface 
       ,
        input                                                   fary_output_reset               ,
        input                                                   fary_isolation_control_in       ,
        input                                 [1:0]             fary_ffuse_rf_sleep             ,        
        input                                                   fsta_dfxact_afd                 ,        
        input                                                   ip_reset_b                      ,  
        input                                                   post_mux_ctrl                   ,
        input                                                   fscan_clkungate                 ,                        
        input                                                   fscan_ram_bypsel_rf             ,
        input                                                   fscan_ram_init_en               ,
        input                                                   fscan_ram_init_val              ,
        input                                                   fscan_ram_rdis_b                ,
        input                                                   fscan_ram_wdis_b                ,
        input           [PWR_MGMT_IN_SIZE-1:0]                  pwr_mgmt_in_rf                  ,
        input           [10-1:0]                             fary_ffuse_rfhs2r2w_trim        , 
        input                                                   fary_pwren_b_rf                 ,
        input                                                   DFTSHIFTEN                      ,
        input                                                   DFTMASK                         ,
        input                                                   DFT_ARRAY_FREEZE                ,
        input                                                   DFT_AFD_RESET_B                 ,
        input                                                   fary_trigger_post_rf            ,
        output                                                  aary_post_pass_rf               ,
        output                                                  aary_post_complete_rf           ,
        output                                                  aary_pwren_b_rf         







        , input wire BIST_SETUP2, input wire BIST_SETUP1_clk, 
        input wire BIST_SETUP0, input wire to_interfaces_tck, 
        input wire mcp_bounding_to_en, input wire scan_to_en, 
        input wire memory_bypass_to_en, input wire GO_ID_REG_SEL, 
        input wire BIST_CLEAR_BIRA, input wire BIST_COLLAR_DIAG_EN, 
        input wire BIST_COLLAR_BIRA_EN, input wire BIST_SHIFT_BIRA_COLLAR, 
        input wire CHECK_REPAIR_NEEDED, input wire MEM0_BIST_COLLAR_SI, 
        output wire BIST_SO, output wire BIST_GO, input wire ltest_to_en, 
        input wire BIST_READENABLE, input wire BIST_WRITEENABLE, 
        input wire BIST_CMP, input wire INCLUDE_MEM_RESULTS_REG, 
        input wire [3:0] BIST_ROW_ADD, input wire [1:0] BIST_BANK_ADD, 
        input wire BIST_COLLAR_EN0, input wire BIST_RUN_TO_COLLAR0, 
        input wire BIST_ASYNC_RESET_clk, input wire BIST_SHADOW_READENABLE, 
        input wire BIST_SHADOW_READADDRESS, 
        input wire BIST_CONWRITE_ROWADDRESS, input wire BIST_CONWRITE_ENABLE, 
        input wire BIST_CONREAD_ROWADDRESS, input wire BIST_CONREAD_ENABLE, 
        input wire BIST_TESTDATA_SELECT_TO_COLLAR, 
        input wire BIST_ON_TO_COLLAR, input wire [7:0] BIST_WRITE_DATA, 
        input wire [7:0] BIST_EXPECT_DATA, input wire BIST_SHIFT_COLLAR, 
        input wire BIST_COLLAR_SETUP, input wire BIST_CLEAR_DEFAULT, 
        input wire BIST_CLEAR, input wire BIST_COLLAR_OPSET_SELECT, 
        input wire BIST_COLLAR_HOLD, input wire FREEZE_STOP_ERROR, 
        input wire ERROR_CNT_ZERO, input wire MBISTPG_RESET_REG_SETUP2, 
        input wire [0:0] BIST_TEST_PORT, input wire bisr_shift_en_pd_vinf, 
        input wire bisr_clk_pd_vinf, input wire bisr_reset_pd_vinf, 
        input wire ram_row_0_col_0_bisr_inst_SO, 
        output wire ram_row_0_col_0_bisr_inst_SO_ts1);


        wire    [TO_MEM_WIDTH/2-1:0]    wrap_shell_to_mem_b, wrap_shell_to_mem_a                                ;
        
        wire [5:0] ADRRD_P0, ADRRD_P1, ADRWR_P0, ADRWR_P1;
        wire [45:0] DIN_P0, DIN_P1;
        wire [6:0] ram_row_0_col_0_bisr_inst_Q;
        wire WREN_P0, WREN_P1, RDEN_P0, RDEN_P1, All_SCOL0_ALLOC_REG;
        wire [5:0] All_SCOL0_FUSE_REG;
        assign                         {wrap_shell_to_mem_b, wrap_shell_to_mem_a}       = wrap_shell_to_mem     ;

        // Disassembling the to_mem bus
        wire                            reset_n         = wrap_shell_to_mem_a[2*MEM_WIDTH-MEM_PROT_TOTAL_WIDTH+(2*MEM_ADR_WIDTH)+MEM_WR_EN_WIDTH+MEM_RM_WIDTH+2 +:1                     ];
        wire                            mem_rm_e        = wrap_shell_to_mem_a[2*MEM_WIDTH-MEM_PROT_TOTAL_WIDTH+(2*MEM_ADR_WIDTH)+MEM_WR_EN_WIDTH+MEM_RM_WIDTH+1             +:1                     ];
        wire    [   MEM_RM_WIDTH-1:0]   mem_rm          = wrap_shell_to_mem_a[2*MEM_WIDTH-MEM_PROT_TOTAL_WIDTH+(2*MEM_ADR_WIDTH)+MEM_WR_EN_WIDTH+1             +:MEM_RM_WIDTH          ];

        wire                            rd_en_a         = wrap_shell_to_mem_a[2*MEM_WIDTH-MEM_PROT_TOTAL_WIDTH+(2*MEM_ADR_WIDTH)+MEM_WR_EN_WIDTH               +:1                     ];
        wire    [MEM_WR_EN_WIDTH-1:0]   wr_en_a         = wrap_shell_to_mem_a[2*MEM_WIDTH-MEM_PROT_TOTAL_WIDTH+(2*MEM_ADR_WIDTH)                               +:MEM_WR_EN_WIDTH       ];
        wire    [  MEM_ADR_WIDTH-1:0]   rd_adr_a        = wrap_shell_to_mem_a[2*MEM_WIDTH-MEM_PROT_TOTAL_WIDTH+MEM_ADR_WIDTH                                  +:MEM_ADR_WIDTH         ];
        wire    [  MEM_ADR_WIDTH-1:0]   wr_adr_a        = wrap_shell_to_mem_a[2*MEM_WIDTH - MEM_PROT_TOTAL_WIDTH                                                 +:MEM_ADR_WIDTH         ];
        //Next line added by SIVAKUMA for wr_data_orig
        wire    [      MEM_WIDTH-MEM_PROT_TOTAL_WIDTH-1:0]   wr_data_orig_a    = wrap_shell_to_mem_a[MEM_WIDTH                                                   +:MEM_WIDTH - MEM_PROT_TOTAL_WIDTH             ];
        wire    [      MEM_WIDTH-1:0]   wr_data_a       = wrap_shell_to_mem_a[0                                                         +:MEM_WIDTH             ];


        wire                            rd_en_b         = wrap_shell_to_mem_b[2*MEM_WIDTH-MEM_PROT_TOTAL_WIDTH+(2*MEM_ADR_WIDTH)+MEM_WR_EN_WIDTH               +:1                     ];
        wire    [MEM_WR_EN_WIDTH-1:0]   wr_en_b         = wrap_shell_to_mem_b[2*MEM_WIDTH-MEM_PROT_TOTAL_WIDTH+(2*MEM_ADR_WIDTH)                               +:MEM_WR_EN_WIDTH       ];
        wire    [  MEM_ADR_WIDTH-1:0]   rd_adr_b        = wrap_shell_to_mem_b[2*MEM_WIDTH-MEM_PROT_TOTAL_WIDTH+MEM_ADR_WIDTH                                  +:MEM_ADR_WIDTH         ];
        wire    [  MEM_ADR_WIDTH-1:0]   wr_adr_b        = wrap_shell_to_mem_b[2*MEM_WIDTH - MEM_PROT_TOTAL_WIDTH                                                 +:MEM_ADR_WIDTH         ];
        //Next line added by SIVAKUMA for wr_data_orig
        wire    [      MEM_WIDTH-MEM_PROT_TOTAL_WIDTH-1:0]   wr_data_orig_b    = wrap_shell_to_mem_b[MEM_WIDTH                                                   +:MEM_WIDTH - MEM_PROT_TOTAL_WIDTH             ];
        wire    [      MEM_WIDTH-1:0]   wr_data_b       = wrap_shell_to_mem_b[0                                                         +:MEM_WIDTH             ];


        // Assembling the from_mem bus
        wire    [FROM_MEM_WIDTH/2-1:0]  wrap_shell_from_mem_b, wrap_shell_from_mem_a                                                    ;
        wire                            rd_valid_a                                                                                      ;
        wire    [      MEM_WIDTH-1:0]   rd_data_a                                                                                       ;
        wire                            rd_valid_b                                                                                      ;
        wire    [      MEM_WIDTH-1:0]   rd_data_b                                                                                       ;
        assign                          wrap_shell_from_mem_a[0]                = rd_valid_a                                            ;
        assign                          wrap_shell_from_mem_a[1+:MEM_WIDTH]     = rd_data_a                                             ;
        assign                          wrap_shell_from_mem_b[0]                = rd_valid_b                                            ;
        assign                          wrap_shell_from_mem_b[1+:MEM_WIDTH]     = rd_data_b                                             ;
        assign                          wrap_shell_from_mem                     = {wrap_shell_from_mem_b, wrap_shell_from_mem_a}        ;

`ifdef DC
        `ifndef HLP_MAC4_ASIC_MEMS_EXCLUDE
                `define HLP_MAC4_ASIC_MEMS
        `endif
`endif

        // Memories Implementation
`ifdef HLP_MAC4_ASIC_MEMS

////////////////////////////////////////////////////////////////////////
//
//                              ASIC MEMORIES                                                                                                                   
//
////////////////////////////////////////////////////////////////////////
        


    // RAM Row Select

    wire    [1-1:0]                wr_ram_row_sel_a;
    wire    [1-1:0]                wr_ram_row_sel_b;
    wire    [1-1:0]                rd_ram_row_sel_a;
    wire    [1-1:0]                rd_ram_row_sel_b;
    assign                    wr_ram_row_sel_a[0]        = 1'b1;
    assign                    wr_ram_row_sel_b[0]        = 1'b1;
    assign                    rd_ram_row_sel_a[0]        = 1'b1;
    assign                    rd_ram_row_sel_b[0]        = 1'b1;


    // RAM Address Decoder

    wire    [6-1:0]        ram_row_wr_adr_a[1-1:0];
    wire    [6-1:0]        ram_row_wr_adr_b[1-1:0];
    wire    [6-1:0]        ram_row_rd_adr_a[1-1:0];
    wire    [6-1:0]        ram_row_rd_adr_b[1-1:0];
    assign                    ram_row_wr_adr_a[0][6-1:0]    = wr_ram_row_sel_a[0] ? wr_adr_a - 6'd0 : 6'd0;
    assign                    ram_row_wr_adr_b[0][6-1:0]    = wr_ram_row_sel_b[0] ? wr_adr_b - 6'd0 : 6'd0;
    assign                    ram_row_rd_adr_a[0][6-1:0]    = rd_ram_row_sel_a[0] ? rd_adr_a - 6'd0 : 6'd0;
    assign                    ram_row_rd_adr_b[0][6-1:0]    = rd_ram_row_sel_b[0] ? rd_adr_b - 6'd0 : 6'd0;


    // RAM Read Enable Decoder

    wire    [1-1:0]        ram_row_rd_en_a;
    assign            ram_row_rd_en_a[0]        = rd_ram_row_sel_a[0] ? rd_en_a : 1'b0;
    wire    [1-1:0]        ram_row_rd_en_b;
    assign            ram_row_rd_en_b[0]        = rd_ram_row_sel_b[0] ? rd_en_b : 1'b0;


    // Read Delay

    reg    [1-1:0]    rd_en_a_delay[MEM_DELAY:0];
    reg    [1-1:0]    rd_en_b_delay[MEM_DELAY:0];
    generate
            if (MEM_PST_EBB_SAMPLE == 1) begin: PST_EBB_SAMPLE_RD_EN_DELAY

                  logic [1-1:0]        ram_row_rd_en_a_s;
                  always_ff @(posedge clk_a) begin
                      ram_row_rd_en_a_s <= ram_row_rd_en_a;
                  end
                  assign  rd_en_a_delay[0][1-1:0] = ram_row_rd_en_a_s[1-1:0];

                  logic [1-1:0]        ram_row_rd_en_b_s;
                  always_ff @(posedge clk_b) begin
                      ram_row_rd_en_b_s <= ram_row_rd_en_b;
                  end
                  assign  rd_en_b_delay[0][1-1:0] = ram_row_rd_en_b_s[1-1:0];
              end
              else begin: NO_PST_EBB_SAMPLE_RD_EN_DELAY
                  assign  rd_en_a_delay[0][1-1:0] = ram_row_rd_en_a[1-1:0];
                  assign  rd_en_b_delay[0][1-1:0] = ram_row_rd_en_b[1-1:0];
              end
    endgenerate
    always_ff @(posedge clk_a)
            for (int i = 0; i <= (MEM_DELAY - 1); i = i + 1) begin
                rd_en_a_delay[i+1]        <= rd_en_a_delay[i];
            end
    always_ff @(posedge clk_b)
            for (int i = 0; i <= (MEM_DELAY - 1); i = i + 1) begin
                rd_en_b_delay[i+1]        <= rd_en_b_delay[i];
            end
    logic    [1-1:0]        ram_row_num_rd_en_a_delay;
    always_ff @(posedge clk_a) begin
        if (|rd_en_a_delay[MEM_DELAY-1]) begin
            for (int i = 0; i < 1; i = i + 1) begin
                if (rd_en_a_delay[MEM_DELAY-1][i]) begin
                    ram_row_num_rd_en_a_delay[1-1:0]    <= i;
                end
            end
        end
    end
    logic    [1-1:0]        ram_row_num_rd_en_b_delay;
    always_ff @(posedge clk_b) begin
        if (|rd_en_b_delay[MEM_DELAY-1]) begin
            for (int i = 0; i < 1; i = i + 1) begin
                if (rd_en_b_delay[MEM_DELAY-1][i]) begin
                    ram_row_num_rd_en_b_delay[1-1:0]    <= i;
                end
            end
        end
    end


    // Write Data

    logic    [46-1:0]    wr_data_a_full;
    assign            wr_data_a_full    = wr_data_a;
    logic    [46-1:0]    wr_data_b_full;
    assign            wr_data_b_full    = wr_data_b;
    logic    [46-1:0]    ram_row_wr_data_a;
    always_comb begin
        for (int i = 0; i < MEM_WR_EN_WIDTH; i = i + 1) begin
            ram_row_wr_data_a[i*(MEM_WR_RESOLUTION)+:MEM_WR_RESOLUTION]    = wr_data_a_full[i*MEM_WR_RESOLUTION+:MEM_WR_RESOLUTION];
        end
    end
    logic    [46-1:0]    ram_row_wr_data_b;
    always_comb begin
        for (int i = 0; i < MEM_WR_EN_WIDTH; i = i + 1) begin
            ram_row_wr_data_b[i*(MEM_WR_RESOLUTION)+:MEM_WR_RESOLUTION]    = wr_data_b_full[i*MEM_WR_RESOLUTION+:MEM_WR_RESOLUTION];
        end
    end
    logic    [46-1:0]    ram_wr_data_a_col[1-1:0];
    logic    [46-1:0]    ram_wr_data_b_col[1-1:0];
    always_comb begin
        for (int i = 0; i < 1; i = i + 1) begin
            ram_wr_data_a_col[i][46-1:0]        = ram_row_wr_data_a[i*46+:46];
            ram_wr_data_b_col[i][46-1:0]        = ram_row_wr_data_b[i*46+:46];
        end
    end


    // Write Enable

    logic    [MEM_WR_EN_WIDTH-1:0]    wr_en_a_full;
    assign            wr_en_a_full    = wr_en_a;
    logic    [MEM_WR_EN_WIDTH-1:0]    wr_en_b_full;
    assign            wr_en_b_full    = wr_en_b;
    logic    [1-1:0]    ram_row_wr_en_a[1-1:0];
    logic    [1-1:0]    ram_row_wr_en_b[1-1:0];
    always_comb begin
        ram_row_wr_en_a[0] = {1{1'b0}};
        ram_row_wr_en_a[0][1-1:0]    =  wr_ram_row_sel_a[0] ? {{1{wr_en_a_full[0]}}} : 1'd0;
    end
    always_comb begin
        ram_row_wr_en_b[0] = {1{1'b0}};
        ram_row_wr_en_b[0][1-1:0]    =  wr_ram_row_sel_b[0] ? {{1{wr_en_b_full[0]}}} : 1'd0;
    end
    logic    [1-1:0]        ram_col_wr_en_a[1-1:0][1-1:0];
    assign        ram_col_wr_en_a[0][0]    = ram_row_wr_en_a[0][0*(1)+:1];
    logic    [1-1:0]        ram_col_wr_en_b[1-1:0][1-1:0];
    assign        ram_col_wr_en_b[0][0]    = ram_row_wr_en_b[0][0*(1)+:1];


    // Read Data

    logic    [46-1:0]    ram_rd_data_a_col[1-1:0][1-1:0];
    logic    [46-1:0]    ram_rd_data_b_col[1-1:0][1-1:0];
    logic    [46-1:0]    ram_rd_data_a_row;
    logic    [46-1:0]    ram_rd_data_b_row;
    always_comb begin
        for (int i = 0; i < 1; i = i + 1) begin
            ram_rd_data_a_row[i*(46)+:46]        = ram_rd_data_a_col[ram_row_num_rd_en_a_delay[1-1:0]][i][46-1:0];
        end
    end
    always_comb begin
        for (int i = 0; i < 1; i = i + 1) begin
            ram_rd_data_b_row[i*(46)+:46]        = ram_rd_data_b_col[ram_row_num_rd_en_b_delay[1-1:0]][i][46-1:0];
        end
    end
    logic    [1*MEM_WIDTH-1:0]    ram_rd_data_a_full;
    logic    [1*MEM_WIDTH-1:0]    ram_rd_data_b_full;
    always_comb begin
        for (int i = 0; i < (MEM_WIDTH / MEM_WR_RESOLUTION); i = i + 1) begin
            ram_rd_data_a_full[i*MEM_WR_RESOLUTION+:MEM_WR_RESOLUTION]        = ram_rd_data_a_row[i*(MEM_WR_RESOLUTION+0)+:MEM_WR_RESOLUTION];
        end
    end
    always_comb begin
        for (int i = 0; i < (MEM_WIDTH / MEM_WR_RESOLUTION); i = i + 1) begin
            ram_rd_data_b_full[i*MEM_WR_RESOLUTION+:MEM_WR_RESOLUTION]        = ram_rd_data_b_row[i*(MEM_WR_RESOLUTION+0)+:MEM_WR_RESOLUTION];
        end
    end
    logic    [MEM_WIDTH-1:0]    rd_data_a_int;
    always_comb begin
        rd_data_a_int[MEM_WIDTH-1:0]    =    ram_rd_data_a_full[MEM_WIDTH-1:0];
    end
    logic    [MEM_WIDTH-1:0]    rd_data_b_int;
    always_comb begin
        rd_data_b_int[MEM_WIDTH-1:0]    =    ram_rd_data_b_full[MEM_WIDTH-1:0];
    end
    assign        rd_data_a    = rd_data_a_int;
    assign        rd_valid_a    = |rd_en_a_delay[MEM_DELAY];
    assign        rd_data_b    = rd_data_b_int;
    assign        rd_valid_b    = |rd_en_b_delay[MEM_DELAY];


    // EBBs Instantiation

        wire                            ram_row_0_col_0_clk_a       = clk_a;
        wire                            ram_row_0_col_0_clk_b       = clk_b;
        wire    [6-1:0]       ram_row_0_col_0_wr_adr_a    = ram_row_wr_adr_a[0][6-1:0];
        wire    [6-1:0]       ram_row_0_col_0_wr_adr_b    = ram_row_wr_adr_b[0][6-1:0];
        wire    [6-1:0]       ram_row_0_col_0_rd_adr_a    = ram_row_rd_adr_a[0][6-1:0];
        wire    [6-1:0]       ram_row_0_col_0_rd_adr_b    = ram_row_rd_adr_b[0][6-1:0];
        wire                            ram_row_0_col_0_rd_en_a     = ram_row_rd_en_a[0];
        wire                            ram_row_0_col_0_rd_en_b     = ram_row_rd_en_b[0];
        wire                            ram_row_0_col_0_wr_en_a     = |ram_col_wr_en_a[0][0];
        wire                            ram_row_0_col_0_wr_en_b     = |ram_col_wr_en_b[0][0];
        wire    [46-1:0]              ram_row_0_col_0_data_in_a   = ram_wr_data_a_col[0][46-1:0];
        wire    [46-1:0]              ram_row_0_col_0_data_in_b   = ram_wr_data_b_col[0][46-1:0];
        wire    [46-1:0]              ram_row_0_col_0_data_out_a;
        wire    [46-1:0]              ram_row_0_col_0_data_out_b;
        wire    [2:0]                   ram_row_0_col_0_aary_pwren_b;
        wire                            ram_row_0_col_0_vcc = 1'b1;
        
        
        ip783rfhs2r2w64x46s0c1p0d0_dft_wrp #(
                    )
        ram_row_0_col_0 (
                    //------------------------------------------------------------
                    // Functional Interfaces
                    //------------------------------------------------------------      
        
                     .CLKWR_P0                (ram_row_0_col_0_clk_a),
                     .ADRWR_P0                (ADRWR_P0),
                     .WREN_P0                 (WREN_P0),
                     .DIN_P0                  (DIN_P0),
        
                     .CLKWR_P1                (ram_row_0_col_0_clk_b),
                     .ADRWR_P1                (ADRWR_P1),
                     .WREN_P1                 (WREN_P1),
                     .DIN_P1                  (DIN_P1),
        
                     .CLKRD_P0                (ram_row_0_col_0_clk_a),
                     .ADRRD_P0                (ADRRD_P0),
                     .RDEN_P0                 (RDEN_P0),
                     .QOUT_P0                 (ram_row_0_col_0_data_out_a),
                         
                     .CLKRD_P1                (ram_row_0_col_0_clk_b),
                     .ADRRD_P1                (ADRRD_P1),
                     .RDEN_P1                 (RDEN_P1),
                     .QOUT_P1                 (ram_row_0_col_0_data_out_b),                
                                                     
                    
                   //-------------------------------------------------------------
                   // Power Management Interfaces
                   //-------------------------------------------------------------
                  //   .PWR_MGMT_IN                        ({pwr_mgmt_in_rf[PWR_MGMT_IN_SIZE-1:1],ram_fary_pwren_b[0]}), // MSB changed from 3'b100
                  //   .PWR_MGMT_OUT                       (ram_aary_pwren_b[0]),  
                
                       
                     `ifndef INTEL_NO_PWR_PINS
                        .vddp                            (ram_row_0_col_0_vcc),
                        `ifdef INTC_ADD_VSS
                        .vss                            (1'b0),
                        `endif  
                     `endif
               
        
        
        
                      //REPAIR INPUTS
        
                    .FCA           (ram_row_0_col_0_bisr_inst_Q[6:1]), // column repair addres --- > F means faulty
                    .CRE          (ram_row_0_col_0_bisr_inst_Q[0]), //Column repair enable
                    
        
                    // POWER MGMT inputs
                    //.ROP_SD             (), // shutoffout
                    //.ROP_DS             (), //dpslp_or_shutoffout
                    //TEMPCOMMENT1.MPMS              (1'b0), // {shutoff,deepsleep,fastsleep}
        
                    //TIMING and TRIM
                    // MDST = {async_reset0,async_reset1,wmce,mce,stbyp,rmce}
                    .MDST_hs2r2w       ({fary_ffuse_rfhs2r2w_trim[9],fary_ffuse_rfhs2r2w_trim[8],fary_ffuse_rfhs2r2w_trim[7:5],fary_ffuse_rfhs2r2w_trim[4],fary_ffuse_rfhs2r2w_trim[3],fary_ffuse_rfhs2r2w_trim[2:0]}),
                                        
        
                    //DFT inputs
                    .DFTSHIFTEN        (DFTSHIFTEN),
                    .DFTMASK           (DFTMASK),
                    .DFT_ARRAY_FREEZE    (DFT_ARRAY_FREEZE),
                    
                    .DFT_AFD_RESET_B    (DFT_AFD_RESET_B)
        
        
        
        );//ip783rfhs2r2w64x46s0c1p0d0_dft_wrp
        
        assign          ram_rd_data_a_col[0][0]    = ram_row_0_col_0_data_out_a;
        assign          ram_rd_data_b_col[0][0]    = ram_row_0_col_0_data_out_b;
        
             

// DFX output concatination 
                
`elsif HLP_FPGA_MEMS
/*
////////////////////////////////////////////////////////////////////////
//
//                              FPGA MEMORIES                                                                                                                   
//
////////////////////////////////////////////////////////////////////////



// per coordination with FPGA team - 2R2W would be implemented using Flops



        wire    [      MEM_WIDTH-1:0]   rd_data_a_int;
        wire    [      MEM_WIDTH-1:0]   rd_data_b_int;

    ecip_mgm_flop_based_2r2w_memory #(
        .MEM_WIDTH        (MEM_WIDTH),
        .MEM_DEPTH        (MEM_DEPTH),
        .MEM_WR_RESOLUTION(MEM_WR_RESOLUTION),
        .MEM_WR_EN_WIDTH  (MEM_WR_EN_WIDTH),
        .MEM_ADR_WIDTH    (MEM_ADR_WIDTH)
    )

    fpga_mem (
        .clk_a     (clk_a),
        .clk_b     (clk_b),
        .rd_add_a  (rd_adr_a),
        .rd_add_b  (rd_adr_b),
        .wr_add_a  (wr_adr_a),
        .wr_add_b  (wr_adr_b),
        .rd_en_a   (rd_en_a),
        .rd_en_b   (rd_en_b),
        .wr_en_a   (wr_en_a),
        .wr_en_b   (wr_en_b),
        .data_in_a (wr_data_a),
        .data_in_b (wr_data_b),
        .data_out_a(rd_data_a_int),
        .data_out_b(rd_data_b_int)
    );




        // Read Delay A
        logic   [MEM_DELAY:0]           rd_en_a_delay;
        always_comb
                rd_en_a_delay[0]                        = rd_en_a;
        always @(posedge clk_a) begin
                rd_en_a_delay[MEM_DELAY:1]      <= rd_en_a_delay[MEM_DELAY-1:0];
        end
        assign          rd_valid_a                      = rd_en_a_delay[MEM_DELAY];

        // Read Data Delay A
        logic   [MEM_WIDTH-1:0]         rd_data_a_delay[MEM_DELAY:0];
        always_comb
                rd_data_a_delay[0]                      = rd_data_a_int;
        always @(posedge clk_a) begin
                for (int i = 1; i <= MEM_DELAY; i = i + 1) begin
                        if (rd_en_a_delay[i])
                                rd_data_a_delay[i]      <= rd_data_a_delay[i-1];
                end
        end
        assign          rd_data_a[MEM_WIDTH-1:0]        = rd_en_a_delay[MEM_DELAY] ? rd_data_a_delay[MEM_DELAY-1][MEM_WIDTH-1:0] : rd_data_a_delay[MEM_DELAY][MEM_WIDTH-1:0];

        // Read Delay B
        logic   [MEM_DELAY:0]           rd_en_b_delay;
        always_comb
                rd_en_b_delay[0]                        = rd_en_b;
        always @(posedge clk_b) begin
                rd_en_b_delay[MEM_DELAY:1]      <= rd_en_b_delay[MEM_DELAY-1:0];
        end
        assign          rd_valid_b                      = rd_en_b_delay[MEM_DELAY];

        // Read Data Delay B
        logic   [MEM_WIDTH-1:0]         rd_data_b_delay[MEM_DELAY:0];
        always_comb
                rd_data_b_delay[0]                      = rd_data_b_int;
        always @(posedge clk_b) begin
                for (int i = 1; i <= MEM_DELAY; i = i + 1) begin
                        if (rd_en_b_delay[i])
                                rd_data_b_delay[i]      <= rd_data_b_delay[i-1];
                end
        end
        assign          rd_data_b[MEM_WIDTH-1:0]        = rd_en_b_delay[MEM_DELAY] ? rd_data_b_delay[MEM_DELAY-1][MEM_WIDTH-1:0] : rd_data_b_delay[MEM_DELAY][MEM_WIDTH-1:0];

        `ifdef HLP_RTL
                generate
                        if (MEM_INIT_TYPE == 1)
                                begin:  CONST_MEM_INIT

                                        reg [MEM_WIDTH-1:0] init_word[MEM_DEPTH-1:0];

                                        hlp_mgm_functions mem_func();

                                        if (MEM_PROT_TYPE < 2) begin    
                                                
                                                initial begin
                                                
                                                        for (int i = 0; i < MEM_DEPTH; i = i + 1) begin
                                                                for (int j = 0; j < MEM_INIT_PROT_INST_NUM; j = j + 1) begin
                                                                        init_word[i][j*(MEM_INIT_VALUE_WIDTH/MEM_INIT_PROT_INST_NUM) +: MEM_INIT_VALUE_WIDTH/MEM_INIT_PROT_INST_NUM]    = MEM_INIT_VALUE[j*(MEM_INIT_VALUE_WIDTH/MEM_INIT_PROT_INST_NUM)+:(MEM_INIT_VALUE_WIDTH/MEM_INIT_PROT_INST_NUM)];
                                                                        init_word[i][MEM_INIT_VALUE_WIDTH + j*(MEM_PROT_INST_WIDTH)  +: MEM_PROT_INST_WIDTH]                            = mem_func.gen_ecc(MEM_INIT_VALUE[j*(MEM_INIT_VALUE_WIDTH/MEM_INIT_PROT_INST_NUM)+:(MEM_INIT_VALUE_WIDTH/MEM_INIT_PROT_INST_NUM)], MEM_PROT_TYPE);
                                                                end
                                                        end
                                                        
                                                end
                                                
                                        end
                                        else begin
                                        
                                                initial begin

                                                        for (int i = 0; i < MEM_DEPTH; i = i + 1) begin
                                                                init_word[i] = MEM_INIT_VALUE;
                                                        end
                                                
                                                end
                                        
                                        end

                                        if (FPGA_MEM_ZERO_PADDING > 0) begin
                                                always @(posedge reset_n)
                                                        if ($test$plusargs("HLP_FAST_CONFIG")) begin
                                                                for (int i = 0; i < MEM_DEPTH; i = i + 1)
                                                                        for(int j = 0; j < MEM_WR_EN_WIDTH; j = j + 1)
                                                                                fpga_mem.sram[i][j*FPGA_MEM_WR_RESOLUTION+:FPGA_MEM_WR_RESOLUTION]  = {{(FPGA_MEM_ZERO_PADDING){1'b0}},init_word[i][j*MEM_WR_RESOLUTION+:MEM_WR_RESOLUTION]};
                                                        end
                                        end
                                        else begin
                                                always @(posedge reset_n)
                                                        if ($test$plusargs("HLP_FAST_CONFIG")) begin
                                                                for (int i = 0; i < MEM_DEPTH; i = i + 1)
                                                                        for(int j = 0; j < MEM_WR_EN_WIDTH; j = j + 1)
                                                                                fpga_mem.sram[i][j*FPGA_MEM_WR_RESOLUTION+:FPGA_MEM_WR_RESOLUTION]  = {init_word[i][j*MEM_WR_RESOLUTION+:MEM_WR_RESOLUTION]};
                                                        end
                                        end
                                                                                                                                
                                end
                        else if (MEM_INIT_TYPE == 2)
                                begin:  LL_MEM_INIT
                                
                                        reg [MEM_WIDTH-1:0] init_word[MEM_DEPTH-1:0];

                                        hlp_mgm_functions mem_func();

                                        if (MEM_PROT_TYPE < 2) begin    
                                                
                                                initial begin
                                                        init_word[MEM_DEPTH-1]={(MEM_INIT_VALUE_WIDTH){1'b0}};
                                                        for (int i = 0; i < MEM_DEPTH-1; i = i + 1) begin
                                                                for (int j = 0; j < MEM_INIT_PROT_INST_NUM; j = j + 1) begin
                                                                        init_word[i][j*(MEM_INIT_VALUE_WIDTH/MEM_INIT_PROT_INST_NUM) +: MEM_INIT_VALUE_WIDTH/MEM_INIT_PROT_INST_NUM]    = i+1;
                                                                        init_word[i][MEM_INIT_VALUE_WIDTH + j*(MEM_PROT_INST_WIDTH)  +: MEM_PROT_INST_WIDTH]                            = mem_func.gen_ecc(i+1, MEM_PROT_TYPE);
                                                                end
                                                        end
                                                        
                                                end
                                                
                                        end
                                        else begin
                                        
                                                initial begin
                                                        init_word[MEM_DEPTH-1]={(MEM_INIT_VALUE_WIDTH){1'b0}};
                                                        for (int i = 0; i < MEM_DEPTH-1; i = i + 1) begin
                                                                init_word[i] = i;
                                                        end
                                                
                                                end
                                        
                                        end

                                        if (FPGA_MEM_ZERO_PADDING > 0) begin
                                                always @(posedge reset_n)
                                                        if ($test$plusargs("HLP_FAST_CONFIG")) begin
                                                                for (int i = 0; i < MEM_DEPTH; i = i + 1)
                                                                        for(int j = 0; j < MEM_WR_EN_WIDTH; j = j + 1)
                                                                                fpga_mem.sram[i][j*FPGA_MEM_WR_RESOLUTION+:FPGA_MEM_WR_RESOLUTION]  = {{(FPGA_MEM_ZERO_PADDING){1'b0}},init_word[i][j*MEM_WR_RESOLUTION+:MEM_WR_RESOLUTION]};
                                                        end
                                        end
                                        else begin
                                                always @(posedge reset_n)
                                                        if ($test$plusargs("HLP_FAST_CONFIG")) begin
                                                                for (int i = 0; i < MEM_DEPTH; i = i + 1)
                                                                        for(int j = 0; j < MEM_WR_EN_WIDTH; j = j + 1)
                                                                                fpga_mem.sram[i][j*FPGA_MEM_WR_RESOLUTION+:FPGA_MEM_WR_RESOLUTION]  = {init_word[i][j*MEM_WR_RESOLUTION+:MEM_WR_RESOLUTION]};
                                                        end
                                        end

                                end
                endgenerate
        `endif

`else
*/
////////////////////////////////////////////////////////////////////////
//
//                              BEHAVE MEMORIES                                                                                                                                         
//
////////////////////////////////////////////////////////////////////////
        
        wire    [MEM_WIDTH-1:0]         behave_mem_rd_data_a;
        wire    [MEM_WIDTH-1:0]         behave_mem_rd_data_b;
        wire    [MEM_WIDTH-1:0]         rd_data_a_int, rd_data_b_int;
        assign                          rd_data_a_int   = behave_mem_rd_data_a;
        assign                          rd_data_b_int   = behave_mem_rd_data_b;

        hlp_mgm_2r2w_behave #(
                .MEM_WIDTH              (MEM_WIDTH)                     ,
                .MEM_DEPTH              (MEM_DEPTH)                     ,
                .MEM_WR_RESOLUTION      (MEM_WR_RESOLUTION), 
                .MEM_ADDR_COLL_X        (1)) // Apply 'X on data output in case rd/wr addressing collide (SAME RD_WR ADDR COLLISION IND  <YES, NO>)
        behave_mem (
                .clk_a                  (clk_a)                         ,
                .clk_b                  (clk_b)                         ,
                .rd_add_a               (rd_adr_a)                      ,
                .rd_add_b               (rd_adr_b)                      ,
                .wr_add_a               (wr_adr_a)                      ,
                .wr_add_b               (wr_adr_b)                      ,
                .rd_en_a                (rd_en_a)                       ,
                .rd_en_b                (rd_en_b)                       ,
                .wr_en_a                (wr_en_a)                       ,
                .wr_en_b                (wr_en_b)                       ,
                .data_in_a              (wr_data_a)                     ,
                .data_in_b              (wr_data_b)                     ,
                .data_out_a             (behave_mem_rd_data_a)          ,
                .data_out_b             (behave_mem_rd_data_b));

        // Read Delay A
        logic   [MEM_DELAY:0]           rd_en_a_delay;
        always_comb
                rd_en_a_delay[0]                        = rd_en_a;
        always @(posedge clk_a) begin
                rd_en_a_delay[MEM_DELAY:1]      <= rd_en_a_delay[MEM_DELAY-1:0];
        end
        assign          rd_valid_a                      = rd_en_a_delay[MEM_DELAY];

        // Read Data Delay A
        logic   [MEM_WIDTH-1:0]         rd_data_a_delay[MEM_DELAY:0];
        always_comb
                rd_data_a_delay[0]                      = rd_data_a_int;
        always @(posedge clk_a) begin
                for (int i = 1; i <= MEM_DELAY; i = i + 1) begin
                        if (rd_en_a_delay[i])
                                rd_data_a_delay[i]      <= rd_data_a_delay[i-1];
                end
        end
        assign          rd_data_a[MEM_WIDTH-1:0]        = rd_en_a_delay[MEM_DELAY] ? rd_data_a_delay[MEM_DELAY-1][MEM_WIDTH-1:0] : rd_data_a_delay[MEM_DELAY][MEM_WIDTH-1:0];

        // Read Delay B
        logic   [MEM_DELAY:0]           rd_en_b_delay;
        always_comb
                rd_en_b_delay[0]                        = rd_en_b;
        always @(posedge clk_b) begin
                rd_en_b_delay[MEM_DELAY:1]      <= rd_en_b_delay[MEM_DELAY-1:0];
        end
        assign          rd_valid_b                      = rd_en_b_delay[MEM_DELAY];

        // Read Data Delay B
        logic   [MEM_WIDTH-1:0]         rd_data_b_delay[MEM_DELAY:0];
        always_comb
                rd_data_b_delay[0]                      = rd_data_b_int;
        always @(posedge clk_b) begin
                for (int i = 1; i <= MEM_DELAY; i = i + 1) begin
                        if (rd_en_b_delay[i])
                                rd_data_b_delay[i]      <= rd_data_b_delay[i-1];
                end
        end
        assign          rd_data_b[MEM_WIDTH-1:0]        = rd_en_b_delay[MEM_DELAY] ? rd_data_b_delay[MEM_DELAY-1][MEM_WIDTH-1:0] : rd_data_b_delay[MEM_DELAY][MEM_WIDTH-1:0];

        `ifdef HLP_RTL
                generate

                        logic   [MEM_WIDTH_NO_SIG + (MEM_WR_RESOLUTION_ZERO_PADDING * MEM_WR_EN_WIDTH) - 1:0]  wr_data_for_prot_full_int                          ;
                        logic   [MEM_WIDTH_NO_SIG + MEM_TOTAL_ZERO_PADDING - 1:0]                              wr_data_for_prot_full                              ;
                        logic   [MEM_PROT_PER_GEN_INST-1:0]                                             wr_data_for_prot_interlv[MEM_PROT_TOTAL_GEN_INST-1:0]     ;
                        logic   [MEM_PROT_TOTAL_WIDTH-1:0]              signature_full;
                        logic   [MEM_WIDTH-1:0]                 prot_wr_data_out;


                        if (MEM_INIT_TYPE == 1)
                                begin:  CONST_MEM_INIT

                                        logic [MEM_WIDTH-1:0] init_word[MEM_DEPTH-1:0];
                                        logic [MEM_INIT_VALUE_WIDTH-1:0] init_value = MEM_INIT_VALUE[MEM_INIT_VALUE_WIDTH-1:0];                                                                 

                                        hlp_mgm_functions mem_func();

                                        if (MEM_PROT_TYPE < 2) begin    
                                                
                                                initial begin
                                                
                
                                                // Zero Padding before protection
                                                        wr_data_for_prot_full_int[MEM_WIDTH_NO_SIG + (MEM_WR_RESOLUTION_ZERO_PADDING * MEM_WR_EN_WIDTH) - 1:0]                 = {(MEM_WIDTH_NO_SIG + (MEM_WR_RESOLUTION_ZERO_PADDING * MEM_WR_EN_WIDTH)){1'b0}}      ;
                                                        for (int i=0; i<MEM_WR_EN_WIDTH; i=i+1) begin
                                                                wr_data_for_prot_full_int[i*(MEM_WR_RESOLUTION_NO_SIG + MEM_WR_RESOLUTION_ZERO_PADDING)+:MEM_WR_RESOLUTION_NO_SIG]    = init_value[i*(MEM_WR_RESOLUTION_NO_SIG)+:MEM_WR_RESOLUTION_NO_SIG]                         ;
                                                        end

                                                        wr_data_for_prot_full[MEM_WIDTH_NO_SIG + MEM_TOTAL_ZERO_PADDING - 1:0]                                                 = {(MEM_WIDTH_NO_SIG + MEM_TOTAL_ZERO_PADDING){1'b0}}                                  ;
                                                        for (int i=0; i<MEM_WR_RES_PROT_FRAGM*MEM_WR_EN_WIDTH; i=i+1) begin
                                                                wr_data_for_prot_full[i*(MEM_PROT_RESOLUTION + MEM_PROT_RESOLUTION_ZERO_PADDING)+:MEM_PROT_RESOLUTION]  = wr_data_for_prot_full_int[i*(MEM_PROT_RESOLUTION)+:MEM_PROT_RESOLUTION]       ;
                                                        end

                                                // Interleaving
                                                        for (int i=0; i<MEM_WR_EN_WIDTH*MEM_WR_RES_PROT_FRAGM; i=i+1) begin
                                                                for (int j=0; j<MEM_PROT_INTERLV_LEVEL; j=j+1) begin
                                                                        for (int k=0; k<MEM_PROT_PER_GEN_INST; k=k+1) begin
                                                                                wr_data_for_prot_interlv[i*(MEM_PROT_INTERLV_LEVEL)+j][k]       = wr_data_for_prot_full[i*(MEM_PROT_RESOLUTION+MEM_PROT_RESOLUTION_ZERO_PADDING)+k*(MEM_PROT_INTERLV_LEVEL)+j]                          ;
                                                                        end
                                                                end
                                                        end

                                                // Combining all signatures into one 
           
                                                        for (int i=0; i<MEM_PROT_TOTAL_GEN_INST; i=i+1) begin
                                                                signature_full[i*MEM_PROT_INST_WIDTH_NO_SIG+:MEM_PROT_INST_WIDTH_NO_SIG] =mem_func.gen_ecc(wr_data_for_prot_interlv[i][MEM_PROT_PER_GEN_INST-1:0], MEM_PROT_TYPE);                

                                                        end
                                                

                                                // Combining the write data together with the signature
                                                
                                                        for (int i=0; i<MEM_WR_EN_WIDTH; i=i+1) begin
                                                                prot_wr_data_out[i*MEM_WR_RESOLUTION+:MEM_WR_RESOLUTION]={signature_full[i*MEM_PROT_TOTAL_WIDTH/MEM_WR_EN_WIDTH+:MEM_PROT_TOTAL_WIDTH/MEM_WR_EN_WIDTH],MEM_INIT_VALUE[i*MEM_WR_RESOLUTION_NO_SIG+:MEM_WR_RESOLUTION_NO_SIG]};
                                                        end
                                    
                                                        for (int i = 0; i < MEM_DEPTH; i = i + 1) begin
                                                                        init_word[i][MEM_WIDTH-1:0]    = prot_wr_data_out[MEM_WIDTH-1:0];
                                                        end
                                                        
                                                        
                                                end
                                        end        
                                        else begin
                                        
                                                initial begin

                                                        for (int i = 0; i < MEM_DEPTH; i = i + 1) begin
                                                                init_word[i] = MEM_INIT_VALUE;
                                                        end
                                                
                                                end
                                        
                                        end

                                        always @(posedge reset_n) 
                                                if ($test$plusargs("HLP_FAST_CONFIG")) begin
                                                        for (int i = 0; i < MEM_DEPTH; i = i + 1)
                                                                behave_mem.sram[i]      = init_word[i];
                                                end
                                                                                                        
                                end
                        else if (MEM_INIT_TYPE == 2)
                                begin:  LL_MEM_INIT

                                        logic [MEM_WIDTH-1:0] init_word[MEM_DEPTH-1:0]    ;
                                        logic [MEM_INIT_VALUE_WIDTH-1:0] init_value       ;                                     

                                        hlp_mgm_functions mem_func();

                                        if (MEM_PROT_TYPE < 2) begin    
                                                
                                                initial begin

                                                        init_word[MEM_DEPTH-1]={(MEM_INIT_VALUE_WIDTH){1'b0}};
                                                        for (int i = 0; i < MEM_DEPTH-1; i = i + 1) begin
                                                                init_value=i+1    ;                                                                     
 
                                                        // Zero Padding before protection
                                                        
                                                                wr_data_for_prot_full_int[MEM_WIDTH_NO_SIG + (MEM_WR_RESOLUTION_ZERO_PADDING * MEM_WR_EN_WIDTH) - 1:0]                 = {(MEM_WIDTH_NO_SIG + (MEM_WR_RESOLUTION_ZERO_PADDING * MEM_WR_EN_WIDTH)){1'b0}}      ;
                                                                for (int i=0; i<MEM_WR_EN_WIDTH; i=i+1) begin
                                                                        wr_data_for_prot_full_int[i*(MEM_WR_RESOLUTION_NO_SIG + MEM_WR_RESOLUTION_ZERO_PADDING)+:MEM_WR_RESOLUTION_NO_SIG]    = init_value[i*(MEM_WR_RESOLUTION_NO_SIG)+:MEM_WR_RESOLUTION_NO_SIG]                         ;
                                                                end

                                                                wr_data_for_prot_full[MEM_WIDTH_NO_SIG + MEM_TOTAL_ZERO_PADDING - 1:0]                                                 = {(MEM_WIDTH_NO_SIG + MEM_TOTAL_ZERO_PADDING){1'b0}}                                  ;
                                                                for (int i=0; i<MEM_WR_RES_PROT_FRAGM*MEM_WR_EN_WIDTH; i=i+1) begin
                                                                        wr_data_for_prot_full[i*(MEM_PROT_RESOLUTION + MEM_PROT_RESOLUTION_ZERO_PADDING)+:MEM_PROT_RESOLUTION]  = wr_data_for_prot_full_int[i*(MEM_PROT_RESOLUTION)+:MEM_PROT_RESOLUTION]       ;
                                                                end

                                                        // Interleaving

                                                                for (int i=0; i<MEM_WR_EN_WIDTH*MEM_WR_RES_PROT_FRAGM; i=i+1) begin
                                                                        for (int j=0; j<MEM_PROT_INTERLV_LEVEL; j=j+1) begin
                                                                                for (int k=0; k<MEM_PROT_PER_GEN_INST; k=k+1) begin
                                                                                        wr_data_for_prot_interlv[i*(MEM_PROT_INTERLV_LEVEL)+j][k]       = wr_data_for_prot_full[i*(MEM_PROT_RESOLUTION+MEM_PROT_RESOLUTION_ZERO_PADDING)+k*(MEM_PROT_INTERLV_LEVEL)+j]                          ;
                                                                                end
                                                                        end
                                                                end

                                                        // Combining all signatures into one 
           
                                                                for (int i=0; i<MEM_PROT_TOTAL_GEN_INST; i=i+1) begin
                                                                        signature_full[i*MEM_PROT_INST_WIDTH_NO_SIG+:MEM_PROT_INST_WIDTH_NO_SIG] =mem_func.gen_ecc(wr_data_for_prot_interlv[i][MEM_PROT_PER_GEN_INST-1:0], MEM_PROT_TYPE);                
        
                                                                end
                                                        

                                                        // Combining the write data together with the signature

                                                                for (int i=0; i<MEM_WR_EN_WIDTH; i=i+1) begin
                                                                        prot_wr_data_out[i*MEM_WR_RESOLUTION+:MEM_WR_RESOLUTION]={signature_full[i*MEM_PROT_TOTAL_WIDTH/MEM_WR_EN_WIDTH+:MEM_PROT_TOTAL_WIDTH/MEM_WR_EN_WIDTH],init_value[i*MEM_WR_RESOLUTION_NO_SIG+:MEM_WR_RESOLUTION_NO_SIG]};
                                                                end
                                                        



                                                        // put a protected word back                    
                                                                init_word[i][MEM_WIDTH-1:0]    = prot_wr_data_out[MEM_WIDTH-1:0];
                                                       
                                                       end 
                                                end
                                        end        
                                        else begin
                                        
                                                initial begin
                                                        init_word[MEM_DEPTH-1]={(MEM_INIT_VALUE_WIDTH){1'b0}};
                                                        for (int i = 0; i < MEM_DEPTH-1; i = i + 1) begin
                                                                init_word[i] = i+1;
                                                        end
                                                
                                                end
                                        
                                        end

                                        always @(posedge reset_n) begin
                                                if ($test$plusargs("HLP_FAST_CONFIG"))
                                                        for (int i = 0; i < MEM_DEPTH; i = i + 1)
                                                                behave_mem.sram[i]      = init_word[i];
                                                end

                                end
                endgenerate     
        `endif
        
`endif


  hlp_port4_apr_rtl_tessent_mbist_RF_c2_interface_MEM1 ram_row_0_col_0_interface_inst(
      .BIST_SHADOW_READENABLE(BIST_SHADOW_READENABLE), .BIST_SHADOW_READADDRESS(BIST_SHADOW_READADDRESS), 
      .BIST_CONREAD_ROWADDRESS(BIST_CONREAD_ROWADDRESS), .BIST_CONREAD_ENABLE(BIST_CONREAD_ENABLE), 
      .BIST_CONWRITE_ROWADDRESS(BIST_CONWRITE_ROWADDRESS), .BIST_CONWRITE_ENABLE(BIST_CONWRITE_ENABLE), 
      .BIST_CLEAR_BIRA(BIST_CLEAR_BIRA), .WREN_P0_IN(ram_row_0_col_0_wr_en_a), 
      .WREN_P1_IN(ram_row_0_col_0_wr_en_b), .RDEN_P0_IN(ram_row_0_col_0_rd_en_a), 
      .RDEN_P1_IN(ram_row_0_col_0_rd_en_b), .ADRRD_P0_IN(ram_row_0_col_0_rd_adr_a[5:0]), 
      .ADRRD_P1_IN(ram_row_0_col_0_rd_adr_b[5:0]), .ADRWR_P0_IN(ram_row_0_col_0_wr_adr_a[5:0]), 
      .ADRWR_P1_IN(ram_row_0_col_0_wr_adr_b[5:0]), .QOUT_P0(ram_row_0_col_0_data_out_a), 
      .QOUT_P1(ram_row_0_col_0_data_out_b), .DIN_P0_IN(ram_row_0_col_0_data_in_a[45:0]), 
      .DIN_P1_IN(ram_row_0_col_0_data_in_b[45:0]), .TCK(to_interfaces_tck), .BIST_CMP(BIST_CMP), 
      .INCLUDE_MEM_RESULTS_REG(INCLUDE_MEM_RESULTS_REG), .BIST_READENABLE(BIST_READENABLE), 
      .BIST_WRITEENABLE(BIST_WRITEENABLE), .BIST_ROW_ADD(BIST_ROW_ADD), .BIST_BANK_ADD(BIST_BANK_ADD), 
      .BIST_TEST_PORT(BIST_TEST_PORT), .BIST_WRITE_DATA(BIST_WRITE_DATA), .BIST_TESTDATA_SELECT_TO_COLLAR(BIST_TESTDATA_SELECT_TO_COLLAR), 
      .MEM_BYPASS_EN(memory_bypass_to_en), .SCAN_SHIFT_EN(scan_to_en), .MCP_BOUNDING_EN(mcp_bounding_to_en), 
      .BIST_ON(BIST_ON_TO_COLLAR), .BIST_RUN(BIST_RUN_TO_COLLAR0), .BIST_ASYNC_RESETN(BIST_ASYNC_RESET_clk), 
      .BIST_CLK(clk_a), .BIST_SHIFT_COLLAR(BIST_SHIFT_COLLAR), .BIST_EXPECT_DATA(BIST_EXPECT_DATA), 
      .BIST_SI(MEM0_BIST_COLLAR_SI), .BIST_COLLAR_SETUP(BIST_COLLAR_SETUP), .BIST_COLLAR_OPSET_SELECT(BIST_COLLAR_OPSET_SELECT), 
      .BIST_COLLAR_HOLD(BIST_COLLAR_HOLD), .BIST_BIRA_EN(BIST_COLLAR_BIRA_EN), 
      .CHECK_REPAIR_NEEDED(CHECK_REPAIR_NEEDED), .BIST_DIAG_EN(BIST_COLLAR_DIAG_EN), 
      .BIST_CLEAR_DEFAULT(BIST_CLEAR_DEFAULT), .BIST_CLEAR(BIST_CLEAR), .BIST_SETUP2(BIST_SETUP2), 
      .BIST_SETUP1(BIST_SETUP1_clk), .BIST_SETUP0(BIST_SETUP0), .LV_TM(ltest_to_en), 
      .FREEZE_STOP_ERROR(FREEZE_STOP_ERROR), .GO_ID_REG_SEL(GO_ID_REG_SEL), .BIST_COLLAR_EN(BIST_COLLAR_EN0), 
      .FROM_BISR_All_SCOL0_FUSE_REG(ram_row_0_col_0_bisr_inst_Q[6:1]), .FROM_BISR_All_SCOL0_ALLOC_REG(ram_row_0_col_0_bisr_inst_Q[0]), 
      .BIST_SHIFT_BIRA_COLLAR(BIST_SHIFT_BIRA_COLLAR), .RESET_REG_SETUP2(MBISTPG_RESET_REG_SETUP2), 
      .ERROR_CNT_ZERO(ERROR_CNT_ZERO), .WREN_P0(WREN_P0), .WREN_P1(WREN_P1), .RDEN_P0(RDEN_P0), 
      .RDEN_P1(RDEN_P1), .ADRRD_P0(ADRRD_P0), .ADRRD_P1(ADRRD_P1), .ADRWR_P0(ADRWR_P0), 
      .ADRWR_P1(ADRWR_P1), .DIN_P0(DIN_P0), .DIN_P1(DIN_P1), .BIST_SO(BIST_SO), 
      .BIST_GO(BIST_GO), .All_SCOL0_FUSE_REG(All_SCOL0_FUSE_REG[5:0]), .All_SCOL0_ALLOC_REG(All_SCOL0_ALLOC_REG), 
      .REPAIR_STATUS(), .fscan_clkungate(fscan_clkungate)
  );

  hlp_port4_apr_rtl_tessent_mbisr_register_ip783rfhs2r2w64x46s0c1p0d0_dft_wrp ram_row_0_col_0_bisr_inst(
      .CLK(bisr_clk_pd_vinf), .RSTB(bisr_reset_pd_vinf), .SI(ram_row_0_col_0_bisr_inst_SO), 
      .SO(ram_row_0_col_0_bisr_inst_SO_ts1), .SE(bisr_shift_en_pd_vinf), .D({
      All_SCOL0_FUSE_REG[5:0], All_SCOL0_ALLOC_REG}), .MSO(1'b0), .MSEL(1'b0), .Q(ram_row_0_col_0_bisr_inst_Q)
  );
endmodule
