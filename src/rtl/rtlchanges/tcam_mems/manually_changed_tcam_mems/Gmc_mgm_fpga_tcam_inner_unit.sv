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
//    FILENAME          : mgm_fpga_tcam_inner_unit.sv
//    DESIGNER          : Morag Tohamy
//    DATE              : 20/06/16
//    REVISION NUMBER   : 1.0
//    DESCRIPTION       :
//
//         The inner unit of the FPGA TCAM model. Based on two memories each for E0 and E1 entries of the TCAM Array.
//
//---------------------------------------------------------------------------//
// --------------------------------------------------------------------------//
//      LAST MODIFICATION:      27/06/16
//      RECENT AUTHORS:         yevgeny.yankilevich@intel.com
//      PREVIOUS RELEASES:      
//                              20/06/16: First version.
// --------------------------------------------------------------------------//
module Gmc_mgm_fpga_tcam_inner_unit #(


        parameter BCAM_N7       = 0                                                                             , // BCAM Mode ( must be in conjunction w/ N7_MODE
        parameter TSMC_N7       = 0                              , // TSMC N7 Mode


        parameter FPGA_MEM_DELAY                        = 1                                                     , // altsyncram memory read delay - the number of cycles till rd_data is valid
        parameter SEGMENT_RULES                         = 64                                                    , // parametric depth (in Rules) of the inner unit, with respect to clocks ratio
        parameter SEGMENT_DEPTH                         = SEGMENT_RULES* (2  - BCAM_N7)                         , // parametric depth (in lines) 
        parameter DATA_WIDTH                            = 40                                                    , // Word Width
        parameter TCAM_ADDR_WIDTH                            = $clog2(SEGMENT_DEPTH)                                 , // Address Width (considering 2 entries per 1 rule)
        parameter AUX_ADDR_WIDTH                        = $clog2(SEGMENT_RULES)+1                                    // Aux address width per altsyncram


)(
        input   logic                           fast_clk                , // Clock
        input   logic                           reset_n                 , // Asynchronous Active-Low Reset
        input   logic                           slow_clk_en             , // Enable from the general tcam clock (slower clock)
        input   logic                           ext_rd_en               , // Read Enable
        input   logic                           ext_wr_en               , // Write Enable
        input   logic                           chk_en                  , // Control Enable
        input   logic   [TCAM_ADDR_WIDTH-1:0]        addr                    , // Input Address
        input   logic   [DATA_WIDTH-1:0]        data_in                 , // Input Data
        input   logic   [DATA_WIDTH-1:0]        skey_in                 , // Input Key
        input   logic   [SEGMENT_RULES-1:0]     match_in                , // Input Match
        input                                   vbi_in                  , 
        input                                   flush_in                , 
        
        input   logic   [DATA_WIDTH-1:0]        chk_mask                , // Input Mask
        input   logic   [SEGMENT_RULES-1:0]     raw_hit_in              , // Raw Hit Input 
        output  logic   [DATA_WIDTH-1:0]        rd_data                 , // Output Data
        output  logic   [SEGMENT_RULES-1:0]     raw_hit_out               // Raw Hit Output
);

//declaring signals
//logic [FPGA_TCAM_WIDTH-1:0]           fpga_data_in            ; // data in configured for fpga
logic                                   rd_en0,rd_en1           ; // read enables for entry0 and entry1
logic                                   wr_en0,wr_en1           ; // write enables for entry0 and entry1
logic [AUX_ADDR_WIDTH-1:0]              aux_addr                ; // aux address - the address for each altsyncram instantiation        
logic [SEGMENT_RULES-1:0]               temp_hit                ; // temporary hit to store the results of the check, before concatenation with the left hit array
//logic [SEGMENT_RULES-1:0]               temp_hit_old            ; // temporary hit to store the results of the check, before concatenation with the left hit array
logic                                   lookup             ; // high when in lookup mode
logic                                   counting              ; // indicates when it is okay to increment address 
logic [DATA_WIDTH-1:0]                  rd_data0, rd_data1      ; // read data for entry0 

  wire                          is_bcam =  BCAM_N7; 
  wire                          is_tsmc =  TSMC_N7; 


// Instantiating two fpga memories to represent Entry0 and Entry1 of the TCAM Memory
/*
 // FPGA configuration
always_comb
        begin
                fpga_mem_bwe    = {FPGA_TCAM_WR_EN_WIDTH{1'b1}};
                fpga_data_in    = {{FPGA_TCAM_ZERO_PADDING{1'b0}},{data_in}};
end
*/


//Entry0
        Gmc_mgm_1rw_behave #(
                .MEM_WIDTH              (DATA_WIDTH)                    ,
                .MEM_DEPTH              (SEGMENT_RULES)                 ,
                .MEM_WR_RESOLUTION      (DATA_WIDTH))
        tcam_entry0 (
                .clk                    (fast_clk)                      ,
                .address                (aux_addr[AUX_ADDR_WIDTH-(2  - BCAM_N7):0])                      ,
                .rd_en                  (rd_en0)                        ,
                .wr_en                  (wr_en0)                        ,
                .data_in                (data_in)                       ,
                .data_out               (rd_data0))                     ;


//Entry1
        Gmc_mgm_1rw_behave #(
                .MEM_WIDTH              (DATA_WIDTH)                    ,
                .MEM_DEPTH              (SEGMENT_RULES)                 ,
                .MEM_WR_RESOLUTION      (DATA_WIDTH))
        tcam_entry1 (
                .clk                    (fast_clk)                      ,
                .address                (aux_addr[AUX_ADDR_WIDTH-2:0])                      ,
                .rd_en                  (rd_en1)                        ,
                .wr_en                  (wr_en1)                        ,
                .data_in                (data_in)                       ,
                .data_out               (rd_data1))                     ;




// ------------------------ Read ------------------------ //



        // Read Delay
        logic   [FPGA_MEM_DELAY:0]              rd_en0_delay    ;
        logic   [FPGA_MEM_DELAY:0]              rd_en1_delay    ;
        logic                                   rd_valid0       ;
        logic                                   rd_valid1       ;       
        
	// Using a delay for rd_en to create a rd_valid signal
        always_comb
                begin
                        rd_en0_delay[0]         = rd_en0;
                        rd_en1_delay[0]         = rd_en1;
        end 
        
        always_ff @(posedge fast_clk) begin
                rd_en0_delay[FPGA_MEM_DELAY:1]  <= rd_en0_delay[FPGA_MEM_DELAY-1:0];
                rd_en1_delay[FPGA_MEM_DELAY:1]  <= rd_en1_delay[FPGA_MEM_DELAY-1:0];
        end

        assign  rd_valid0       = rd_en0_delay[FPGA_MEM_DELAY];
        assign  rd_valid1       = rd_en1_delay[FPGA_MEM_DELAY];

        // Read Data Delay
        logic   [DATA_WIDTH-1:0]                rd_data0_delay[FPGA_MEM_DELAY:0];
        logic   [DATA_WIDTH-1:0]                rd_data1_delay[FPGA_MEM_DELAY:0];
        logic   [DATA_WIDTH-1:0]                rd_data_aux0                    ;
        logic   [DATA_WIDTH-1:0]                rd_data_aux1                    ;
        logic   [DATA_WIDTH-1:0]                rd_data_prev                    ;
        
 
        always_comb
                begin
                        rd_data0_delay[0][DATA_WIDTH-1:0]       = rd_data0[DATA_WIDTH-1:0];
                        rd_data1_delay[0][DATA_WIDTH-1:0]       = rd_data1[DATA_WIDTH-1:0];
        end


        always_ff  @(posedge fast_clk) begin
                for (int i = 1; i <= FPGA_MEM_DELAY; i = i + 1) begin
                        if (rd_en0_delay[i]) begin
                                rd_data0_delay[i]       <= rd_data0_delay[i-1];
                        end
                        if (rd_en1_delay[i]) begin
                                rd_data1_delay[i]       <= rd_data1_delay[i-1];
                        end
                end
        end

        assign  rd_data_aux0[DATA_WIDTH-1:0]    = rd_en0_delay[FPGA_MEM_DELAY] ? rd_data0_delay[FPGA_MEM_DELAY-1][DATA_WIDTH-1:0] : rd_data0_delay[FPGA_MEM_DELAY][DATA_WIDTH-1:0];
        assign  rd_data_aux1[DATA_WIDTH-1:0]    = rd_en1_delay[FPGA_MEM_DELAY] ? rd_data1_delay[FPGA_MEM_DELAY-1][DATA_WIDTH-1:0] : rd_data1_delay[FPGA_MEM_DELAY][DATA_WIDTH-1:0];
        
        
        //choosing the data output of the relevant memory for the main data output:

        assign  rd_data = ((rd_valid0 || rd_valid1) && !chk_en) ? ((addr[0] & ~is_bcam)? rd_data_aux1 : rd_data_aux0) : rd_data_prev        ;

        always_ff  @(posedge fast_clk) begin
                if ((rd_valid0 || rd_valid1) && !chk_en) begin 
                        rd_data_prev <= rd_data;
                end
        end


// --------------------- lookup --------------------- //        
        
always_comb
        begin
                lookup = (rd_valid0 && (rd_valid1 | is_bcam) && chk_en) ? 1'b1 : 1'b0 ; // start updating the hit array only after the first delay is done.
end


// -------------------------------------------------- //

logic  invalid_val_0; 
logic [AUX_ADDR_WIDTH-1:0]  aux_addr_delay; 

assign  aux_addr_delay = aux_addr-FPGA_MEM_DELAY[AUX_ADDR_WIDTH-1:0]; 

`ifdef INTEL_SIMONLY
    assign      invalid_val_0 = 1'bx; 
`else

    assign      invalid_val_0 = 1'b0; 


`endif

  logic  [SEGMENT_RULES -1:0]    state_v;                              // valid entry state





// Determine the operation coming up:

always_ff  @(posedge fast_clk or negedge reset_n)
        begin
        
                if (!reset_n) begin
                
                // reseting read enables and write enables of entry0 and entry1 
                
                        aux_addr        <= {AUX_ADDR_WIDTH{1'b0}}       ;
                        rd_en0          <= 1'b0                         ;
                        wr_en0          <= 1'b0                         ;
                        rd_en1          <= 1'b0                         ;
                        wr_en1          <= 1'b0                         ;
                        counting         <= 1'b0                         ;
                        raw_hit_out     <= 0        ;
                        temp_hit        <= 0       ;
                        state_v         <= 0; 
                        // temp_hit_old    <= {SEGMENT_RULES{1'b0}}        ;
                end
                
		else begin
			if (slow_clk_en) begin
			
                 
                                    

                        // LOOKUP: starting the lookup process; initializing aux_addr to be incrememnted by 1 each cycle.
			
				if (chk_en) begin // lookup mode
					aux_addr <= {AUX_ADDR_WIDTH{1'b0}}              ;
					counting <= 1'b1                              ;
					rd_en0 <= 1'b1                                  ;
					rd_en1 <= ~is_bcam                              ;
					wr_en0 <= 1'b0                                  ;
					wr_en1 <= 1'b0                                  ;
				end
				
			// READ: assigning ext_rd_en to the relevant fpga memory (entry0 or entry1), based on the odd-even feature of the addres:       
				
				if (ext_rd_en) begin // read mode
				    if (~is_bcam)
                                       begin
					aux_addr <= addr>>1                             ;
					rd_en0 <= ~addr[0] ? ext_rd_en : 1'b0           ;
					rd_en1 <= addr[0] ? ext_rd_en : 1'b0            ;
					wr_en0 <= 1'b0                                  ;
					wr_en1 <= 1'b0                                  ;
                                       end
				    else // BCAM, use only lower bank
                                       begin
					aux_addr <= addr          ;
					rd_en0 <= ext_rd_en       ;
					rd_en1 <= 1'b0            ;
					wr_en0 <= 1'b0                                  ;
					wr_en1 <= 1'b0                                  ;
                                       end
          
					
				end

			// WRITE: assigning ext_wr_en to the relevant fpga memory (entry0 or entry1), based on the odd-even feature of the addres:

     			        if (flush_in)
                
                                    state_v  <= 0;
                                else if (ext_wr_en) begin // write mode
					
				    if (~is_bcam)
                                       begin
					aux_addr <= addr>>1                             ;
					wr_en0 <= ~addr[0] ? ext_wr_en : 1'b0           ;
					wr_en1 <= addr[0] ? ext_wr_en : 1'b0            ;
					rd_en0 <= 1'b0                                  ;
					rd_en1 <= 1'b0                                  ;
                                       end
                                       else
                                       begin
					aux_addr <= addr                                ;
					wr_en0 <= ext_wr_en                             ;
					wr_en1 <= 1'b0                                  ;
					rd_en0 <= 1'b0                                  ;
					rd_en1 <= 1'b0                                  ;
                                        state_v [addr] <= vbi_in;
                                       end
                                       
				end

			end

			
			else begin 
				if (!chk_en) begin

				// Limiting the read enables to only one clock cycle
				 
					if (rd_en0) begin
						rd_en0 <= 1'b0;
					end

					if (rd_en1) begin
						rd_en1 <= 1'b0;
					end

				// Limiting the write enables to only one clock cycle

					if (wr_en0) begin
						wr_en0 <= 1'b0;
					end

					if (wr_en1) begin
						wr_en1 <= 1'b0;
					end
				end

				// LOOKUP       

				else if (chk_en) begin
					if (counting) begin
						if (aux_addr<(SEGMENT_RULES-1+FPGA_MEM_DELAY)) begin
							aux_addr <= aux_addr+1; // increment aux_addr untill it reaches the last address
						end
						else begin
							counting <= 1'b0; // done incrementing the address
						end
					end // if (counting) begin

					if (lookup) begin
                         if (~is_bcam)
                                temp_hit[aux_addr_delay] <= ((~rd_data_aux0 & ~data_in & chk_mask) == {DATA_WIDTH{1'b0}}) & 
                                                            ((~rd_data_aux1 &  data_in & chk_mask) == {DATA_WIDTH{1'b0}}) & 
                                                               ( (is_tsmc & raw_hit_in[aux_addr_delay]) | ~is_tsmc) ;

                          else // BCAM
 
                                temp_hit[aux_addr_delay] <= ( wr_en0 & (addr ==  aux_addr_delay) ? 
                                                                        invalid_val_0 : 
                                                                        (rd_data_aux0 == skey_in) & state_v [aux_addr_delay] ) & 
                                                             match_in[aux_addr_delay];
			 if (aux_addr < (SEGMENT_RULES-1)) begin 
			 //	temp_hit_old[aux_addr-FPGA_MEM_DELAY[AUX_ADDR_WIDTH-1:0]] <= ((~rd_data_aux0&~data_in&chk_mask) == {DATA_WIDTH{1'b0}}) && ((~rd_data_aux1&data_in&chk_mask) == {DATA_WIDTH{1'b0}});




				  rd_en0 <= 1'b1;
				  rd_en1 <= 1'b1;
			 end
			 else if (aux_addr>=(SEGMENT_RULES -1)) begin // look up mode should end by the time comparing is done, thus when aux_addr is maximized-1, read enable turns low, so that rd_valid will be low 1 cycle after.
			 //	temp_hit_old[aux_addr-FPGA_MEM_DELAY[AUX_ADDR_WIDTH-1:0]] <= ((~rd_data_aux0 & ~data_in & chk_mask) == {DATA_WIDTH {1'b0}} ) &&
			 //					((~rd_data_aux1 & data_in & chk_mask) == {DATA_WIDTH {1'b0}} );



				 rd_en0 <= 1'b0;
				  rd_en1 <= 1'b0;
			 end
					end




                end // if (chk_en) begin
                
			end

		//	if (!lookup && slow_clk_en) begin
                               // HIT[i]      <= (LHIT[i] | is_tsmc) & hit[i];   
		//	       raw_hit_out <=    (raw_hit_in | is_tsmc) & temp_hit;

                end
		
        end

assign raw_hit_out =  (raw_hit_in | is_tsmc) & temp_hit;
    `ifndef INTEL_SVA_OFF
         import intel_checkers_pkg::*;   

//        `ASSERTS_TRIGGER (hit_mismatch, chk_en,  (temp_hit === temp_hit_old) , posedge fast_clk, 1'b0,
///            `ERR_MSG ( "hit vectors are not equivalent " ) ) ;

    `endif
endmodule       



  
