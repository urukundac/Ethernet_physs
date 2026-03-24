// ===========================================================================
// INTEL TOP SECRET
// 
// Copyright 2018 Intel Corporation All Rights Reserved.
// 
// The source code contained or described herein and all documents related
// to the source code ("Material") are owned by Intel Corporation or its
// suppliers or licensors. Title to the Material remains with Intel
// Corporation or its suppliers and licensors. The Material contains trade
// secrets and proprietary and confidential information of Intel or its
// suppliers and licensors. The Material is protected by worldwide copyright
// and trade secret laws and treaty provisions. No part of the Material may
// be used, copied, reproduced, modified, published, uploaded, posted,
// transmitted, distributed, or disclosed in any way without Intel's prior
// express written permission.
// 
// No license under any patent, copyright, trade secret or other intellectual
// property right is granted to or conferred upon you by disclosure or
// delivery of the Materials, either expressly, by implication, inducement,
// estoppel or otherwise. Any license under such intellectual property rights
// must be express and approved by Intel in writing.
// ---------------------------------------------------------------------------
//
// FILE information:
// Version       : 3.0
// Written by    : Omri Afek
// Last Update by: <Name>
// Last Update   : <Date>
//
// Module Description:
// --------------------
// Generic linked list module for dynamically sharing the same memory across
// a parametric number of lists. Module allows to add & remove an item 
// every cycle, without latency, giving each list the behavior of a 
// FF based FIFO.
// This module uses excess resources to achieve performance, consider if this
// is indeed necessary for you.
// 
// List requires 2 external dual port memories of the same depth and latency:
// -Data memory
// -List pointers memory
// 
// Memory latency is parametric, it is assumed the memory read data is valid after
// the specified amount of clock cycles.
// Memories require no initialization, the "list_mem" is initialized by this 
// module, and no access should be made before this is done.
// Memory initialization is not required for this module.
//
// For the module to work, the data memory must support read & write to
// the same address - providing the old data on the read interface.
// ===========================================================================

module lanpe_tclan_tpro_sll 
    import lanpe_tclan_package::*;
    #(
    parameter WIDTH        = 8,  // Data width
    parameter DEPTH        = 15, // Total memory depth            
    parameter LISTS        = 3,  // Number of linked lists
    parameter PREF_DATA    = 1,  // Enables data pre-fetch, removes memory latency at cost of FFs
    parameter DMEM_LATENCY = 1,  // Data memory latency
    parameter PMEM_LATENCY = 1,  // Pointer (list/free) memory latency
    parameter FULL_TYPE    = 1,  // 0 - Full on DEPTH entries, 1 - Full on empty free list (behaves differently in case of PREF_DATA = 1)
    // No need to override below parameters
    parameter ADDR_W       = $clog2(DEPTH),                  
    parameter CNT_W        = FULL_TYPE ? $clog2(DEPTH+1+PREF_DATA*LISTS*(DMEM_LATENCY+1)) : $clog2(DEPTH+1),
    parameter LISTS_CNT    = LISTS > 1 ? $clog2(LISTS) : 1
    )(
    input  logic                                         clk,
    input  logic                                         rst_n,                                  
    // Write                                             
    input  logic                                         wr_en,
    input  logic [LISTS_CNT-1:0]                         wr_idx,
    input  logic [WIDTH-1:0]                             wr_data,
    input  logic                                         wr_marker,
    output logic                                         wr_rdy,
    output logic                                         wr_full,
    // Read                                              
    input  logic                                         rd_en,
    input  logic [LISTS_CNT-1:0]                         rd_idx,
    output logic [LISTS-1:0][WIDTH-1:0]                  rd_data,             // Read data array, in case of no pre-fetch all indexes equal memory read data
    output logic [LISTS-1:0]                             rd_marker, 
    output logic                                         rd_data_vld,         // Read data valid, only relevant when not using pre-fetch
    output logic [LISTS-1:0]                             rd_empty,
    // Data memory                                       
    output logic                                         data_mem_wr_en,
    output logic [ADDR_W-1:0]                            data_mem_wr_addr,
    output logic [WIDTH-1:0]                             data_mem_wr_data,
    output logic                                         data_mem_rd_en,
    output logic [ADDR_W-1:0]                            data_mem_rd_addr,
    input  logic [WIDTH-1:0]                             data_mem_rd_data,
    input  logic                                         data_mem_rd_vld,     // Not used when pre-fetch is enabled
    // List pointers memory                              
    output logic                                         list_mem_wr_en,
    output logic [ADDR_W-1:0]                            list_mem_wr_addr,
    output logic [ADDR_W:0]                              list_mem_wr_data,
    output logic                                         list_mem_rd_en,
    output logic [ADDR_W-1:0]                            list_mem_rd_addr,
    input  logic [ADDR_W:0]                              list_mem_rd_data,
    // LL lists heads
    output logic [LISTS-1:0][PMEM_LATENCY:0][ADDR_W-1:0] ll_heads,
    output logic [LISTS-1:0][PMEM_LATENCY:0]             ll_heads_vld,
    // Status
    output logic            [CNT_W-1:0]                  used_space,          // Number of used entries across all sub-lists
    output logic            [CNT_W-1:0]                  free_length,         // Length of the free list
    output logic [LISTS-1:0][CNT_W-1:0]                  lists_length         // Length of all sub-lists
    ); 

    //-------------------------------------------------
    //               Lists Management
    //-------------------------------------------------
    // List head/tail pointers
    logic                 [LISTS-1:0][ADDR_W:0]   list_head;
    // pragma attribute list_tail logic_block 1
    logic [PMEM_LATENCY:0][LISTS-1:0][ADDR_W-1:0] list_tail; // Need to keep enough tail pointers to compensate for memory latency
    logic                            [ADDR_W-1:0] free_head;
    logic [PMEM_LATENCY:0]           [ADDR_W-1:0] free_tail; // Need to keep enough tail pointers to compensate for memory latency
    logic                            [ADDR_W:0]   next_free;
    // List rd/wr access
    logic [LISTS-1:0]                             data_mem_wr;
    logic [LISTS-1:0]                             data_mem_rd;
    logic [LISTS-1:0]                             list_mem_wr;
    logic [LISTS-1:0]                             list_mem_rd;
    
    logic                                         wr_en_int;
    logic                                         rd_en_int;
    
    always_comb begin
        wr_en_int = wr_en & ~wr_full;
        rd_en_int = rd_en & ~rd_empty[rd_idx];
        wr_rdy    = ~wr_full;
        next_free = data_mem_rd_en ? {wr_marker, ADDR_W'(list_head[rd_idx])} : {wr_marker, free_head};
    end 
    
    generate // Generate pre-fetch FFs per list to compensate for memory latency
        genvar l;        
        for (l=0; l<LISTS; l++) begin : gen_list
            // Buffer first entries of list to mask memory latency
            logic              list_wr;
            logic              list_rd;
            logic              list_rd_vld;
            logic [CNT_W-1:0]  head_used;
            logic              head_vld;
            
            assign list_wr = wr_en_int & (wr_idx == l[LISTS_CNT-1:0]);
            assign list_rd = rd_en_int & (rd_idx == l[LISTS_CNT-1:0]);
            
            if (PREF_DATA) begin : pref_data
                logic [WIDTH-1:0]  list_wr_data;
                
                ecip_gen_latency_comp_v1 #(
                    .DATA_W (WIDTH),
                    .CNT_W  (CNT_W),
                    .LATENCY(DMEM_LATENCY)
                )
                list_data_latency_comp (
                    .clk        (clk             ),
                    .rst_n      (rst_n           ),
                    .clear      (1'b0            ),
                    .used_cnt   (lists_length[l] ),
                    //Write                      
                    .wr_in      (list_wr         ),
                    .wr_out     (data_mem_wr [l] ),
                    .wr_data_in (wr_data         ),
                    .wr_data_out(list_wr_data    ),
                    //Read                       
                    .rd_in      (list_rd         ),
                    .rd_out     (data_mem_rd [l] ),
                    .rd_data_in (data_mem_rd_data),
                    .rd_data_out(rd_data     [l] ), 
                    .rd_vld_out (list_rd_vld     )
                );

            end else begin : no_pref // Don't pre-fetch data
                assign data_mem_wr [l] = list_wr;
                assign data_mem_rd [l] = list_rd;
                assign rd_data     [l] = data_mem_rd_data;
                assign lists_length[l] = head_used;
                assign list_rd_vld     = head_vld;
            end 
            
            assign rd_empty[l] = ~list_rd_vld;
            
            // Buffer first pointers of list to mask memory latency
            logic [ADDR_W:0] head_wr_data;
            
            lanpe_tclan_tpro_latency_comp #(
                .DATA_W (ADDR_W+1),
                .CNT_W  (CNT_W),
                .LATENCY(PMEM_LATENCY)
            )
            list_pntr_latency_comp (
                .clk          (clk             ),
                .rst_n        (rst_n           ),
                .clear        (1'b0            ),
                .used_cnt     (head_used       ),
                //Write                        
                .wr_in        (data_mem_wr[l]  ),
                .wr_out       (list_mem_wr[l]  ),
                .wr_data_in   (next_free       ),
                .wr_data_out  (head_wr_data    ),
                //Read                         
                .rd_in        (data_mem_rd[l]  ),
                .rd_out       (list_mem_rd[l]  ),
                .rd_data_in   (list_mem_rd_data),
                .rd_data_out  (list_head  [l]  ), 
                .rd_vld_out   (head_vld        ),
                // Pre fetched heads
            	.samp_data_aux(ll_heads    [l] ),
            	.samp_vld_aux (ll_heads_vld[l] )
            	);
            
            // Set list's tail pointer
            always_ff @(posedge clk)
                if (data_mem_wr[l]) begin 
                    for (int i=0; i<=PMEM_LATENCY; i++)
                        list_tail[i][l] <= ~|i ? ADDR_W'(next_free) : list_tail[i-1][l];
                end
                
            assign rd_marker[l] = list_head[l][ADDR_W];
        end 
    endgenerate
    
    // Set data memory access
    assign data_mem_wr_en   = |data_mem_wr;
    assign data_mem_wr_addr = ADDR_W'(next_free);            
    assign data_mem_wr_data = wr_data;              
     
    assign data_mem_rd_en   = |data_mem_rd;
    assign data_mem_rd_addr = ADDR_W'(list_head[rd_idx]);
    
    assign rd_data_vld = PREF_DATA ? ~rd_empty[rd_idx] : data_mem_rd_vld;

    //-------------------------------------------------
    //             Free Entries List
    //-------------------------------------------------
    // First round initialization
    logic              free_vld_pre;
    logic              free_vld;
    logic              free_head_taken;
    logic [ADDR_W:0]   free_head_pre;
    logic              free_first_round;
    logic [ADDR_W-1:0] free_first_cnt;
    logic              free_first_done;
    // Free list memory access
    logic              free_mem_wr_pre;
    logic              free_mem_rd_pre;
    logic              free_mem_wr;
    logic [ADDR_W:0]   free_mem_wr_data;
    logic              free_mem_rd;
    
    always_comb begin
        free_head_taken = ~data_mem_rd_en &  data_mem_wr_en;
        free_mem_wr_pre =  data_mem_rd_en & ~data_mem_wr_en;
        free_mem_rd_pre = free_head_taken & ~free_first_round;
        // First round init - generate consecutive pointers
        free_first_done = free_head_taken & free_first_round & (free_first_cnt == ADDR_W'({DEPTH-1}));
        free_vld        = free_first_round | free_vld_pre;
        free_head       = free_first_round ? free_first_cnt : ADDR_W'(free_head_pre);
    end 

    always_ff @(posedge clk or negedge rst_n)
        if      (~rst_n)          free_first_round <= 1'b1;
        else if (free_first_done) free_first_round <= 1'b0;
        
    always_ff @(posedge clk or negedge rst_n)
        if      (~rst_n)                             free_first_cnt <= '0;
        else if (free_head_taken & free_first_round) free_first_cnt <= ADDR_W'(free_first_cnt + 1'b1);
        

    lanpe_tclan_tpro_latency_comp #(
        .DATA_W (ADDR_W+1),
        .CNT_W  (CNT_W),
        .LATENCY(PMEM_LATENCY)
    )
    free_pntr_latency_comp (
        .clk          (clk              ),
        .rst_n        (rst_n            ),
        .clear        (1'b0             ),
        .used_cnt     (free_length      ),
        //Write                         
        .wr_in        (free_mem_wr_pre  ),
        .wr_out       (free_mem_wr      ),
        .wr_data_in   (list_head[rd_idx]),
        .wr_data_out  (free_mem_wr_data ),
        //Read        
        .rd_in        (free_mem_rd_pre  ),
        .rd_out       (free_mem_rd      ),
        .rd_data_in   (list_mem_rd_data ),
        .rd_data_out  (free_head_pre    ),
        .rd_vld_out   (free_vld_pre     ), 
        // Pre fetched heads
    	.samp_data_aux(                 ),
    	.samp_vld_aux (                 )
    	);

    always_ff @(posedge clk or negedge rst_n)
        if (~rst_n)         
            for (int i=0; i<=PMEM_LATENCY; i++)
                free_tail[i] <= ADDR_W'((DEPTH-1)-ADDR_W'(i));
        else if (data_mem_rd_en & ~data_mem_wr_en) begin
            for (int i=0; i<=PMEM_LATENCY; i++)
                free_tail[i] <= ~|i ? ADDR_W'(list_head[rd_idx]) : free_tail[i-1];
        end 
    
    // Set list memory access
    assign list_mem_wr_en   = free_mem_wr | (|list_mem_wr);
    assign list_mem_wr_addr = free_mem_wr ? free_tail[PMEM_LATENCY] : list_tail[PMEM_LATENCY][wr_idx];
    assign list_mem_wr_data = free_mem_wr ? free_mem_wr_data : next_free;

    assign list_mem_rd_en   = free_mem_rd | (|list_mem_rd);
    assign list_mem_rd_addr = free_mem_rd ? free_head : ADDR_W'(list_head[rd_idx]);

    // Track amount of used entries
    logic [CNT_W-1:0] used_space_next;
    assign            used_space_next = used_space + CNT_W'(wr_en_int) - CNT_W'(rd_en_int);
    
    always_ff @(posedge clk or negedge rst_n)
        if      (~rst_n)                used_space <= '0;
        else if (wr_en_int ^ rd_en_int) used_space <= used_space_next;
    
    generate
        if (FULL_TYPE) begin
            assign wr_full = ~free_vld;
        end else begin 
            always_ff @(posedge clk or negedge rst_n)
                if      (~rst_n)                wr_full <= 1'b0;
                else if (wr_en_int ^ rd_en_int) wr_full <= (used_space_next == DEPTH);
        end 
    endgenerate
       
    //-----Assertions-----
    `ifndef INTEL_SVA_OFF
        import intel_checkers_pkg::*;
        `ASSERTS_NEVER (illegal_wr_idx, (wr_idx>=LISTS) & wr_en, posedge clk, ~rst_n, 
            `ERR_MSG ("Linked list write index out of bounds"));
        `ASSERTS_NEVER (illegal_rd_idx, (rd_idx>=LISTS) & rd_en, posedge clk, ~rst_n, 
            `ERR_MSG ("Linked list read index out of bounds"));  
        `ASSERTS_NEVER (wr_on_full, wr_en & ~wr_en_int, posedge clk, ~rst_n, 
            `ERR_MSG ("Linked list write on full")); 
        `ASSERTS_NEVER (rd_on_empty, rd_en & ~rd_en_int, posedge clk, ~rst_n, 
            `ERR_MSG ("Linked list read on empty")); 
    `endif
    
    //-----Coverage-----
    `ifdef LANPE_SVCOV_ON
        logic [$clog2(LISTS+1)-1:0] rd_vld_cnt_cov;
        logic [LISTS-1:0]           rd_vld;
        
        assign rd_vld = ~rd_empty;
        
        ecip_gen_count_ones_v1 #(
            .IN_W(LISTS         )
        )
        u_ecip_sl_rd_opr_count_ones (
            .in  (rd_vld        ),
            .out (rd_vld_cnt_cov)
        );
    
        `ifdef QC_LEAF                                                       
            `ifndef QC_DISABLE_tclan_sll_coverage
                //LAN_TCLAN_NODES_NUM
                localparam MEM_ADDR_FIFTH  = 1 * DEPTH / LAN_TCLAN_NODES_NUM;
                localparam MEM_ADDR_2FIFTH = 2 * DEPTH / LAN_TCLAN_NODES_NUM;
                localparam MEM_ADDR_3FIFTH = 3 * DEPTH / LAN_TCLAN_NODES_NUM;
                localparam MEM_ADDR_4FIFTH = 4 * DEPTH / LAN_TCLAN_NODES_NUM;
                localparam LISTS_FIFTH     = 1 * LISTS / LAN_TCLAN_NODES_NUM; 
                localparam LISTS_2FIFTH    = 2 * LISTS / LAN_TCLAN_NODES_NUM; 
                localparam LISTS_3FIFTH    = 3 * LISTS / LAN_TCLAN_NODES_NUM; 
                localparam LISTS_4FIFTH    = 4 * LISTS / LAN_TCLAN_NODES_NUM;
          
                covergroup tclan_sll_list_memory_wr @(list_mem_wr_en);                               
                    type_option.comment = "TCLAN SLL list memory write coverage";                           
                    sll_list_memory_wr_addr    : coverpoint  (list_mem_wr_addr) {
                        bins h0 = {[0              :MEM_ADDR_FIFTH-1 ]};
                        bins h1 = {[MEM_ADDR_FIFTH :MEM_ADDR_2FIFTH-1]};
                        bins h2 = {[MEM_ADDR_2FIFTH:MEM_ADDR_3FIFTH-1]};
                        bins h3 = {[MEM_ADDR_3FIFTH:MEM_ADDR_4FIFTH-1]};
                        bins h4 = {[MEM_ADDR_4FIFTH:DEPTH-1          ]};
                    }
                endgroup 
                tclan_sll_list_memory_wr  tclan_sll_list_memory_wr_cov = new;
          
                covergroup tclan_sll_list_memory_rd @(list_mem_rd_en);                               
                    type_option.comment = "TCLAN SLL list memory read coverage";                           
                    sll_list_memory_rd_addr    : coverpoint  (list_mem_rd_addr) {
                        bins h0 = {[0              :MEM_ADDR_FIFTH-1 ]};
                        bins h1 = {[MEM_ADDR_FIFTH :MEM_ADDR_2FIFTH-1]};
                        bins h2 = {[MEM_ADDR_2FIFTH:MEM_ADDR_3FIFTH-1]};
                        bins h3 = {[MEM_ADDR_3FIFTH:MEM_ADDR_4FIFTH-1]};
                        bins h4 = {[MEM_ADDR_4FIFTH:DEPTH-1          ]};
                    }
                endgroup 
                tclan_sll_list_memory_rd  tclan_sll_list_memory_rd_cov = new;
          
                covergroup tclan_sll_accsess_cont @(wr_en & rd_en & (rd_idx == wr_idx));                               
                    type_option.comment = "TCLAN SLL rd and wr to the same idx contention ";                           
                    tclan_sll_rd_wr_cont_s  : coverpoint  (rd_idx) {
                        bins idx_range = {[0:LISTS-1]};
                    }
                endgroup 
                tclan_sll_accsess_cont  tclan_sll_accsess_cont_cov = new;
          
                covergroup tclan_sll_read_req_interface @(rd_en_int);  
                    type_option.comment = "TCLAN SLL read interface coverage";                           
                    sll_rd_idx    : coverpoint  (rd_idx) {
                        bins h0 = {[0           :LISTS_FIFTH-1 ]};
                        bins h1 = {[LISTS_FIFTH :LISTS_2FIFTH-1]};
                        bins h2 = {[LISTS_2FIFTH:LISTS_3FIFTH-1]};
                        bins h3 = {[LISTS_3FIFTH:LISTS_4FIFTH-1]};
                        bins h4 = {[LISTS_4FIFTH:LISTS-1       ]};
                    }
                endgroup 
                tclan_sll_read_req_interface  tclan_sll_read_req_interface_cov = new;
    
                covergroup tclan_sll_write_req_interface @(wr_en_int);  
                    type_option.comment = "TCLAN SLL write interface coverage";                           
                    sll_wr_idx    : coverpoint  (wr_idx) {
                        bins h0 = {[0           :LISTS_FIFTH-1 ]};
                        bins h1 = {[LISTS_FIFTH :LISTS_2FIFTH-1]};
                        bins h2 = {[LISTS_2FIFTH:LISTS_3FIFTH-1]};
                        bins h3 = {[LISTS_3FIFTH:LISTS_4FIFTH-1]};
                        bins h4 = {[LISTS_4FIFTH:LISTS-1       ]};
                    }
                endgroup 
                tclan_sll_write_req_interface  tclan_sll_write_req_interface_cov = new;
                
                covergroup tclan_sll_memory_used_space @(wr_en_int | rd_en_int);                               
                    type_option.comment = "TCLAN SLL memory used space coverage and cross ";                           
                    sll_used_space_full : coverpoint  (used_space){
                        bins full    = {[(DEPTH   -1000 ) :  DEPTH    ]};
                        bins half    = {[(DEPTH/2 -500  ) : (DEPTH/2 )]};
                        bins quarter = {[(DEPTH/4 -100  ) : (DEPTH/4 )]};
                        bins tenth   = {[(DEPTH/10-10 ) : (DEPTH/10)]}; 
                    }
                    sll_valid_lists     : coverpoint  (rd_vld_cnt_cov) {
                        bins one          = { 1                           };
                        bins fifth        = {[2           :LISTS_FIFTH-1 ]};
                        bins two_fifths   = {[LISTS_FIFTH :LISTS_2FIFTH-1]};
                        bins three_fifths = {[LISTS_2FIFTH:LISTS_3FIFTH-1]};
                        bins four_fifths  = {[LISTS_3FIFTH:LISTS_4FIFTH-1]};
                        bins almost_full  = {[LISTS_4FIFTH:LISTS-1       ]};
                        bins all          = { LISTS                       };
                    }
                    sll_used_space_cross : cross  sll_used_space_full, sll_valid_lists 
                    {
                        ignore_bins ignr_few_lists  = sll_used_space_cross with (sll_valid_lists < LISTS/10);
                        ignore_bins ignr_full_cache = sll_used_space_cross with (sll_used_space_full > DEPTH - 1000);
                    }
                endgroup 
                tclan_sll_memory_used_space  tclan_sll_memory_used_space_cov = new;  
        `endif                                                        
      `endif
    `endif    
endmodule
