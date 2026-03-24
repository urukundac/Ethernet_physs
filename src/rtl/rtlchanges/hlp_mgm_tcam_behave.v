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
//    FILENAME          : mgm_tcam_behave.v
//    DESIGNER          : Yevgeny Yankilevich
//    DATE              : 16/02/16
//    REVISION NUMBER   : 1.0
//    DESCRIPTION       :
//
//          Generic TCAM model
//
//---------------------------------------------------------------------------//
// --------------------------------------------------------------------------//
//      LAST MODIFICATION:      10/08/16
//      RECENT AUTHORS:         gal.malchi@intel.com
//      PREVIOUS RELEASES:      
//                              16/02/16: First version.
//                              10/08/16: Fix for Simulation time improving.
//                              12/09/16: Additional sampling on the data and hit array.
// --------------------------------------------------------------------------//
module hlp_mgm_tcam_behave #(
        parameter BCAM_N7       = 0                             , // BCAM Mode ( must be in conjunction w/ N7_MODE
        parameter RULES_NUM     = 512                           , // Number of Rules
        parameter TCAM_DEPTH    = (2 - BCAM_N7) *RULES_NUM      , // Number of Entries
        parameter TCAM_ADDR_WIDTH    = $clog2(TCAM_DEPTH)            , // Address Width
        parameter DATA_WIDTH    = 40                            , // Word Width
        parameter TSMC_N7       = 0                               // TSMC N7 Mode
        
)(
        input logic                             CLK             , // Clock
        input logic                             RESET_N         , // Asynchronous Active-Low Reset
        input logic                             REN             , // Read Enable
        input logic                             WEN             , // Write Enable
        input logic                             KEN             , // Control Enable
        input logic    [RULES_NUM-1:0]          MATCH_IN        , // Match In Lines for BCAM
        input logic                             VBI             , // In/Validate Bit for BCAM
        input logic                             FLUSH           , // FLUSH for BCAM
        input logic   [TCAM_ADDR_WIDTH-1:0]          ADDR            , // Input Address
        input logic   [DATA_WIDTH-1:0]          DATA            , // Input Data
        input logic   [DATA_WIDTH-1:0]          SKEY            , // Input KEY
        input logic   [DATA_WIDTH-1:0]          MASK            , // Input Mask
        input logic    [RULES_NUM-1:0]          LHIT            , // Raw Hit Input
        output logic  [DATA_WIDTH-1:0]          READ_DATA       , // Output Data
        output logic   [RULES_NUM-1:0]          RHIT              // Raw Hit Output
);

`ifndef INTEL_DC

   // internal registers
   reg                                          wen_int;                              // was WEN true last cycle
   reg                                          ren_int;                              // was REN true last cycle
   reg                                          ken_int;                              // was KEN true last cycle 
   reg [DATA_WIDTH-1:0]                         state[(2-BCAM_N7)*RULES_NUM-1:0];     // tcam state
   reg [(2-BCAM_N7)*RULES_NUM-1:0]              state_v;                              // valid entry state
   reg [DATA_WIDTH-1:0]                         state_wr_comp[2*RULES_NUM-1:0];       // tcam state
   reg [DATA_WIDTH-1:0]                         read_data_int_delay;                  // read output last cycle
   reg [DATA_WIDTH-1:0]                         read_data_int;                        // latched read output
   logic [RULES_NUM-1:0]                        hit;                                  // latched hit output
   logic [DATA_WIDTH-1:0]                       tcam_data_in ; 
   logic                                        write_op;
   logic                                        read_op;
   
   
   wire                                         is_bcam =  BCAM_N7; 
   wire                                         is_tsmc =  TSMC_N7; 
   
   assign                          tcam_data_in                    = (WEN | is_bcam) ? DATA : SKEY  ;
   // lookup
   
      
   //   // initial conditions
   //   initial begin
   //     wen_int = 0;
   //     ren_int = 0;
   //   end
   
   
   
   // asynchronous reset of wen_int, ren_int, ken_int state only
   always_ff @ (posedge CLK or negedge RESET_N) begin
      if (~RESET_N)
        begin
           wen_int <= 0;
           ren_int <= 0;
           ken_int <= 0;
        end
      else
        begin
           wen_int <= WEN;
           ren_int <= REN;
           ken_int <= KEN;
           
        end
   end
   
   // TODO: Pendign EFFM issue:    
   // File /hif_mgm_tcam_behave.v, Line 60: The built-in hardware memory core inferred for signal/variable '.hif_mgm_tcam_behave.state' has large number of read ports (1025) 
   //   which is not supported for backend compile.    Please set the attribute 'logic_block' on the signal to compile it as a register array.
   //      Syntax: "// pragma attribute state logic_block 1"
   
   // read or write
   // lintra s-0202
   
   
   always  @ (posedge CLK or negedge RESET_N) begin  // lintra s-50000
      if (~RESET_N)
        begin
           state_v <= {((2-BCAM_N7)*RULES_NUM){1'b0}};
        end
      else if (RESET_N && WEN && is_bcam && (~wen_int | is_tsmc)) // write
        begin
           if (ADDR<((2-BCAM_N7)*RULES_NUM)) 
             begin
                state_v[ADDR] <= VBI;
             end
        end
      else if (FLUSH) 
        begin
           state_v <= {((2-BCAM_N7)*RULES_NUM){1'b0}};
        end
   end
   
   assign write_op =  RESET_N && WEN && (~wen_int | is_tsmc);
   assign read_op =  ((~write_op ) && RESET_N && REN && (~ren_int |is_tsmc));
   
   always  @ (posedge CLK) begin  // lintra s-50000
      if (RESET_N && WEN && (~wen_int | is_tsmc)) // write
        begin
           if (ADDR<((2-BCAM_N7)*RULES_NUM)) begin
              state[ADDR] <= tcam_data_in;
           end
        end
      else if (RESET_N && REN && (~ren_int |is_tsmc)) // read
        begin
           if (~is_bcam)
             begin
                if (ADDR<(2*RULES_NUM)) read_data_int_delay <= state[ADDR];
             end               
           else // is_bcam
             begin
                if (ADDR<(RULES_NUM)) read_data_int_delay <= state[ADDR];
             end
        end
   end
   
   always_comb
   begin   
      state_wr_set_loop: for (int i=0; i<RULES_NUM; i=i+1) state_wr_comp[i] = state[i];       

      if (WEN)  
        state_wr_comp[ADDR] = DATA;
      else
        state_wr_comp[ADDR] = state[ADDR];
   end
   

   always_ff  @ (posedge CLK) 
     begin
        if (KEN)
          hit_set_loop: for (int i=0; i<RULES_NUM; i=i+1) 
            begin
               if (~is_bcam)
                 // BCAM_N7 parmeter usage below helps prevention of exceeding access to state array
                 hit[i] <= ((~state[2*i*(1-BCAM_N7)+0] & ~tcam_data_in & MASK) == {DATA_WIDTH {1'b0}} ) &&
                   ((~state[2*i*(1-BCAM_N7)+1] &  tcam_data_in & MASK) == {DATA_WIDTH {1'b0}} ) & 
                     (is_tsmc &LHIT[i] | ~is_tsmc);
               else
 `ifdef INTEL_SIMONLY
                 hit[i] <= ((WEN & (ADDR == i) ? 1'bx : (state[i] == SKEY) & state_v[i])) & MATCH_IN[i];
 `else
                 hit[i] <= ((WEN & (ADDR == i) ? 1'b0 : (state[i] == SKEY) & state_v[i])) & MATCH_IN[i];
 `endif
            end
     end // always_ff  @ (posedge CLK)
   
   always_ff @ (posedge CLK ) 
     begin
        READ_DATA <= read_data_int_delay;
     end
   
   // drive outputs with combinational logic
   always_ff @ (posedge CLK or negedge RESET_N) 
     if (~RESET_N)
       RHIT <= {(RULES_NUM) { 1'b0}}; 
     else  
       begin     
          read_hit_set_loop: for (int i=0; i<RULES_NUM; i=i+1) 
            begin
               if (ken_int)
                 begin                    
                    RHIT[i] <= (LHIT[i] | is_tsmc) & hit[i];   
                 end
            end          
       end 
     
`else 
     assign  RHIT   = 0; 
     assign  READ_DATA   = 0; 
`endif
     
endmodule //mgm_tcam_behave
