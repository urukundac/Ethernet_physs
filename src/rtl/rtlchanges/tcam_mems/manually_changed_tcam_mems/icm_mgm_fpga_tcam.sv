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
//    FILENAME          : mgm_fpga_tcam.sv
//    DESIGNER          : Morag Tohamy
//    DATE              : 20/06/16
//    REVISION NUMBER   : 1.0
//    DESCRIPTION       :
//
//         FPGA Model of the TCAM. Uses the availability of the fast clock in FPGA to imitated the TCAM's check mechanism in slow clock
//         with multiple reads and consequent compare of memories entries in a fast clock.
//
//---------------------------------------------------------------------------//
// --------------------------------------------------------------------------//
//      LAST MODIFICATION:      10/01/17
//      RECENT AUTHORS:         yevgeny.yankilevich@intel.com
//      PREVIOUS RELEASES:      
//                              20/06/16: First version.
//				10/01/17: Sampling the Data-in and Mask-in to help for FPGA convergance and prevent fucnctional bug.
//				1/02/17: Remove - Sampling the Data-in and Mask-in to help for FPGA convergance and prevent fucnctional bug.
// --------------------------------------------------------------------------//
module icm_mgm_fpga_tcam #(


        parameter BCAM_N7       = 0                             , // BCAM Mode ( must be in conjunction w/ N7_MODE
        parameter TSMC_N7       = 0                             ,  // TSMC N7 Mode

        parameter CLOCKS_RATIO          = 100                                                                                                                   , // Number of cycles that fast clock makes during one slow clock cycle 
        parameter MARGIN                = 0                                                                                                                     , // safety margin between the number of fast clock cycles needed and the end of one slow clock cycle
        parameter FPGA_MEM_DELAY        = 1                                                                                                                     , // the number of cycles till rd_data is valid in the fpga device. 
        parameter TOTAL_RULES_NUM       = 64                                                                                                                    , // depth requested by designer
        parameter CLK_SYNC_DELAY        = 4                                                                                                                     , // depth requested by designer
        parameter SEGMENT_RULES         = (CLOCKS_RATIO-MARGIN-FPGA_MEM_DELAY-CLK_SYNC_DELAY > TOTAL_RULES_NUM) ? TOTAL_RULES_NUM :     CLOCKS_RATIO-MARGIN-FPGA_MEM_DELAY-CLK_SYNC_DELAY       , // parametric depth (in rules) available for tcam. Taken into account: FPGA memory delay of one cycle, and 2 cycles for synchronizing to fast clock.
        parameter SEGMENT_DEPTH         = SEGMENT_RULES * (2  - BCAM_N7)                                                                                        , // parametric depth (in lines) available for tcam
        parameter DATA_WIDTH            = 40                                                                                                                    , // key width
        parameter TCAM_ADDR_WIDTH            = $clog2(TOTAL_RULES_NUM* (2  - BCAM_N7)  )                                                                             , // Address Width (considering 2 entries per 1 rule)
        parameter SEG_ADDR_WIDTH        = $clog2(SEGMENT_DEPTH)                                                                                                 , // Address Width (considering 2 entries per 1 rule)
        parameter INSTANCES             = (TOTAL_RULES_NUM % SEGMENT_RULES > 0) ? TOTAL_RULES_NUM/SEGMENT_RULES+1 : TOTAL_RULES_NUM/SEGMENT_RULES                  // Number of inner tcam instances


)(
        input   logic                           clk                     , // Clock
        input   logic                           fast_clk                , // fast clock for fpga tcam inner units       
        input   logic                           reset_n                 , // Asynchronous Active-Low Reset
        input   logic                           rd_en                   , // Read Enable
        input   logic                           wr_en                   , // Write Enable
        input   logic                           chk_en                  , // Control Enable
        input   logic   [TCAM_ADDR_WIDTH-1:0]        addr                    , // Input Address
        input   logic   [DATA_WIDTH-1:0]        data_in                 , // Input Data
        input   logic   [DATA_WIDTH-1:0]        skey_in                 , // Input Key
        input   logic   [DATA_WIDTH-1:0]        chk_mask                , // Input Mask
        input   logic   [TOTAL_RULES_NUM-1:0]   raw_hit_in              , // Raw Hit Input
        input   logic   [TOTAL_RULES_NUM-1:0]   match_in                , // Raw Match Input
        input   logic                           vbi_in                  , // Valid Bit Input
        
        input   logic                           flush_in                ,
        
        output  logic   [DATA_WIDTH-1:0]        rd_data                 , // Output Data
        output  logic   [TOTAL_RULES_NUM-1:0]   raw_hit_out               // Raw Hit Output
);
  wire                          is_bcam =  BCAM_N7; 
  wire                          is_tsmc =  TSMC_N7; 


  logic [DATA_WIDTH-1:0]              tcam_data_in ; 
  assign                              tcam_data_in                    = (wr_en | is_bcam) ? data_in : skey_in  ;

  logic   [DATA_WIDTH-1:0]        rd_data_pre_delay                ;  // Output Data, prior delay
  // Reassigne input with slow clk

//[m//barzows]
	//	logic   [SE_WIDTH-1:0]          slice_en_x                ; 
        logic                           rd_en_x                   ;   
        logic                           wr_en_x                   ; 
        logic                           chk_en_x                  ; 
        logic   [TCAM_ADDR_WIDTH-1:0]        addr_x                    ; 
        logic   [DATA_WIDTH-1:0]        data_in_x                 ; 
        logic   [DATA_WIDTH-1:0]        chk_mask_x                ; 
        logic   [TOTAL_RULES_NUM-1:0]   raw_hit_in_x    		  ;
        logic   [DATA_WIDTH-1:0]        skey_in_x;
        logic vbi_in_x;
        logic flush_in_x;
        logic tcam_data_in_x;
        logic [TOTAL_RULES_NUM-1:0]   match_in_x;
		 always_ff @(posedge clk or negedge reset_n)
                begin
						if (!reset_n) begin
							//slice_en_x  	<= 1'b0	              ; 
						    rd_en_x 		<= 1'b0	              ;   
                            wr_en_x     	<= 1'b0	              ; 
							chk_en_x    	<= 1'b0	              ; 
							addr_x      	<= 1'b0	              ; 
							tcam_data_in_x   	<= 1'b0	              ; 
							chk_mask_x  	<= 1'b0	              ; 
							raw_hit_in_x    <= 1'b0				  ;
                     skey_in_x    <= 1'b0;
                     vbi_in_x      <= 1'b0;
                     flush_in_x    <= 1'b0;
                     match_in_x    <= 1'b0;
                        end
                        else begin 
                           // slice_en_x  	<= slice_en	          ; 
						    rd_en_x 		<= rd_en              ;   
                            wr_en_x     	<= wr_en 	          ; 
							chk_en_x    	<= chk_en             ; 
							addr_x      	<= addr	              ; 
							tcam_data_in_x   	<= tcam_data_in            ; 
							chk_mask_x  	<= chk_mask           ; 
							raw_hit_in_x    <= raw_hit_in  		  ; 
                    skey_in_x    <=  skey_in;
                   vbi_in_x     <= vbi_in ;
                   flush_in_x   <= flush_in ;
                match_in_x    <= match_in;   
                        end
        end 

// Create a pulse when slow clock rises:

// create slow clock toggle

        logic                   slow_clk_toggle, slow_clk_toggle_not    ;

        always_ff @(posedge clk or negedge reset_n)
                begin
                        if (!reset_n) begin
                                 slow_clk_toggle <= 1'b0        ;
                        end
                        else begin 
                                slow_clk_toggle <= slow_clk_toggle_not  ;  
                        end
        end     
        always_comb
                begin
                        slow_clk_toggle_not = ~slow_clk_toggle  ;
        end     


// Sync the slow clock toggle

        logic   [1:0]                   slow_clk_tgl_sync       ;
        always_ff @(posedge fast_clk or negedge reset_n)
                begin
                        if (!reset_n) begin
                                slow_clk_tgl_sync <= 2'b0;
                        end
                        else begin
                                slow_clk_tgl_sync[0] <= slow_clk_toggle;
                                slow_clk_tgl_sync[1] <= slow_clk_tgl_sync[0];
                        end
        end     

        
// derive the synced toggle and create a fast clock cycle wide pulse

        logic           slow_clk_toggle_del, slow_clk_pulse;

        always_ff @ (posedge fast_clk or negedge reset_n)
                begin
                        if (!reset_n) begin
                                slow_clk_toggle_del <= 1'b0             ;
                        end
                        else begin
                                slow_clk_toggle_del <= slow_clk_tgl_sync[1]     ;
                        end
        end

        always_comb
                begin
                        slow_clk_pulse = slow_clk_toggle_del ^ slow_clk_tgl_sync[1];
        end

// creating signals for inner TCAM units: 

logic   [DATA_WIDTH-1:0]                                units_rd_data[INSTANCES-1:0]            ; // two dimensional array, dim1 for the rd_data in each unit, dim2 is for specifying which unit.
logic   [INSTANCES-1:0]                                 unit_sel                                ; // TCAM inner unit select
logic   [SEG_ADDR_WIDTH-1:0]                            unit_addr[INSTANCES-1:0]                ; // relevant address of each TCAM inner unit
logic   [INSTANCES-1:0]                                 unit_rd_en                              ; // read enable for each inner unit
logic   [INSTANCES-1:0]                                 unit_wr_en                              ; // write enable for each inner unit
        
// determining relative address for each TCAM inner unit

logic           [SEG_ADDR_WIDTH-1:0]                    rel_addr[INSTANCES-1:0] ;
logic           [TCAM_ADDR_WIDTH-1:0]                        temp_addr                       ;

always_comb
        begin
                for(int k=0; k<INSTANCES; k=k+1) begin
                        temp_addr[TCAM_ADDR_WIDTH-1:0] = addr_x - k*SEGMENT_DEPTH[TCAM_ADDR_WIDTH-1:0]      ;
                        rel_addr[k][SEG_ADDR_WIDTH-1:0]  = temp_addr[SEG_ADDR_WIDTH-1:0]        ;
                end
end


// Unit select
        
always_comb
        begin
                for(int k=0; k<INSTANCES; k=k+1) begin
                
                // determine TCAM unit select
                
                        unit_sel[k]                             = ((addr_x>=(k*SEGMENT_DEPTH)) && (addr_x<((k+1)*SEGMENT_DEPTH)))                   ;
                        
                // determine address for each TCAM unit
                
                        unit_addr[k][SEG_ADDR_WIDTH-1:0]        = unit_sel[k] ? rel_addr[k][SEG_ADDR_WIDTH-1:0] : {SEG_ADDR_WIDTH{1'b0}}        ;       
                        
                // determine read enable for each TCAM unit
                
                        unit_rd_en[k]                           = unit_sel[k] && rd_en_x                                                          ;

                // determine write enable for each TCAM unit
                
                        unit_wr_en[k]                           = unit_sel[k] && wr_en_x                                                          ;
                                                                                                                
                        
                end
end     

        
// Instantiation of the inner TCAM units:

logic   [TOTAL_RULES_NUM-1:0]   new_hit_out;
logic   [TOTAL_RULES_NUM-1:0]   raw_hit_out_del;
logic   [INSTANCES*SEGMENT_RULES-1:0] raw_hit_in_temp;
logic   [INSTANCES*SEGMENT_RULES-1:0] match_in_temp;
logic   [INSTANCES*SEGMENT_RULES-1:0] new_hit_out_temp;
always_comb begin
        raw_hit_in_temp = 0;
        match_in_temp = 0; 
        for (int i=0;i<TOTAL_RULES_NUM;i=i+1) begin
                raw_hit_in_temp[i] = raw_hit_in_x[i];
                match_in_temp[i]   = match_in_x[i];
        end
        new_hit_out[TOTAL_RULES_NUM-1:0] = new_hit_out_temp[TOTAL_RULES_NUM-1:0];
end
genvar i;


generate 

        for(i=0; i<INSTANCES; i=i+1) begin: fpga_inner
        
                icm_mgm_fpga_tcam_inner_unit #(
                        .TSMC_N7                (TSMC_N7),  // TSMC mode, affects read and write sequence timint            
                        .BCAM_N7                (BCAM_N7),                                       // BCAM mode
                        .SEGMENT_RULES          (SEGMENT_RULES)                                 , // parametric depth available for tcam
                        .DATA_WIDTH             (DATA_WIDTH)                                      // Word Width
                )
                tcam_unit(
                        .fast_clk               (fast_clk)                                      , // Clock
                        .reset_n                (reset_n)                                       , // Asynchronous Active-Low Reset
                        .slow_clk_en            (slow_clk_pulse)                                , // Enable Pulse (in fast_clock) from the general tcam clock (slower clock)
                        .ext_rd_en              (unit_rd_en[i])                                 , // Read Enable
                        .ext_wr_en              (unit_wr_en[i])                                 , // Write Enable
                        .chk_en                 (chk_en_x)                                        , // Control Enable
                        .addr                   (unit_addr[i][SEG_ADDR_WIDTH-1:0])              , // Input Address
                        .data_in                (tcam_data_in_x)                                       , // Input Data
                        .skey_in                (skey_in_x)                                       , //  
                        .match_in               (match_in_temp[i*SEGMENT_RULES+:SEGMENT_RULES]) , //  
                        .vbi_in                 (vbi_in_x)                                        , // Input Data
                        .chk_mask               (chk_mask_x)                                      , // Input Mask
                        .flush_in               (flush_in_x), 
                        .raw_hit_in             (raw_hit_in_temp[i*SEGMENT_RULES+:SEGMENT_RULES]), // Raw hit input
                        .rd_data                (units_rd_data[i][DATA_WIDTH-1:0])              , // Output Data
                        .raw_hit_out            (new_hit_out_temp[i*SEGMENT_RULES+:SEGMENT_RULES])        // Raw Hit Output
                );
                end
endgenerate

        
// determine READ DATA

always_ff @ (posedge clk)
        begin
                for (int k=0; k<INSTANCES; k=k+1) begin
                        if (rd_en_x && unit_sel[k]) begin
                                rd_data_pre_delay[DATA_WIDTH-1:0] <= units_rd_data[k][DATA_WIDTH-1:0];
                        end 
                end 
        end



always_ff @(posedge clk)// or negedge reset_n)
        begin   
            rd_data <= rd_data_pre_delay;
            raw_hit_out <= new_hit_out;
end

endmodule
