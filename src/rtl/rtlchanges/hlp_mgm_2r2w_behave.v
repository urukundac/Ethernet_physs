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
//    FILENAME          : mgm_2r2w_behave.v
//    DESIGNER          : Avi Costo
//    DATE              : Mar-1st-2017
//    REVISION NUMBER   : 1.0
//    DESCRIPTION       :
//
//          Generic 2r2w port model
//
//---------------------------------------------------------------------------//
// --------------------------------------------------------------------------//
//      LAST MODIFICATION:      Mar-1st-2017
//      RECENT AUTHORS:         avi.costo@intel.com
//      PREVIOUS RELEASES:      
//                              Mar-1st-2017: First version.
// --------------------------------------------------------------------------//
module hlp_mgm_2r2w_behave #(
        parameter       MEM_WIDTH                               = 2                                                                                                                     ,
        parameter       MEM_DEPTH                               = 3                                                                                                                     ,
        parameter       MEM_WR_RESOLUTION                       = MEM_WIDTH                                                                                                             ,
        parameter       MEM_WR_EN_WIDTH                         = (MEM_WIDTH/MEM_WR_RESOLUTION)                                                                                         ,
        parameter       MEM_ADR_WIDTH                           = (MEM_DEPTH>1) ? $clog2(MEM_DEPTH) : 1  , 
        parameter       MEM_ADDR_COLL_X                         = 1
)(
        input   logic                           clk_a                   ,
        input   logic                           clk_b                   ,
        input   logic   [MEM_ADR_WIDTH-1:0]     rd_add_a                ,
        input   logic   [MEM_ADR_WIDTH-1:0]     rd_add_b                ,
        input   logic   [MEM_ADR_WIDTH-1:0]     wr_add_a                ,
        input   logic   [MEM_ADR_WIDTH-1:0]     wr_add_b                ,
        input   logic                           rd_en_a                 ,
        input   logic                           rd_en_b                 ,
        input   logic   [MEM_WR_EN_WIDTH-1:0]   wr_en_a                 ,
        input   logic   [MEM_WR_EN_WIDTH-1:0]   wr_en_b                 ,
        input   logic   [      MEM_WIDTH-1:0]   data_in_a               ,
        input   logic   [      MEM_WIDTH-1:0]   data_in_b               ,
        output  logic   [      MEM_WIDTH-1:0]   data_out_a              ,
        output  logic   [      MEM_WIDTH-1:0]   data_out_b
);

`ifndef HLP_MGM_EMU_FPGA
  `ifdef INTEL_FPGA
     `define HLP_MGM_EMU_FPGA
  `else 
     `ifdef INTEL_EMULATION
        `define HLP_MGM_EMU_FPGA     
     `endif 
  `endif 
`endif
`ifndef INTEL_DC
        logic [MEM_WIDTH-1:0]   sram[MEM_DEPTH-1:0];

        logic [MEM_WIDTH-1:0]   mask_vec_a ; 
        logic [MEM_WIDTH-1:0]   mask_vec_b ; 
        logic [MEM_WIDTH-1:0]   mask_vec_a_d ; 
        logic [MEM_WIDTH-1:0]   mask_vec_b_d ; 
        

        // mask_vec would set 'Xs to the matching wr_en data bits
        always_comb 
        begin
          mask_vec_a = 0; 
          mask_vec_b = 0; 
          for (int i=0; i<MEM_WR_EN_WIDTH; i=i+1) begin
                   if (wr_en_a[i]) begin
                        // for emulation - driving corrupted non-zero value 
                       `ifdef INTEL_SIMONLY                                        
                           mask_vec_a[i*MEM_WR_RESOLUTION+:MEM_WR_RESOLUTION]  =   {MEM_WR_RESOLUTION{1'bx}};   // lintra s-50002
                       `else
                           mask_vec_a[i*MEM_WR_RESOLUTION+:MEM_WR_RESOLUTION]  =   {MEM_WR_RESOLUTION{1'b1}};   
                       `endif 
                   end
                   if (wr_en_b[i]) begin
                       `ifdef INTEL_SIMONLY                                        
                           mask_vec_b[i*MEM_WR_RESOLUTION+:MEM_WR_RESOLUTION]  =   {MEM_WR_RESOLUTION{1'bx}};   // lintra s-50002
                       `else
                           mask_vec_b[i*MEM_WR_RESOLUTION+:MEM_WR_RESOLUTION]  =   {MEM_WR_RESOLUTION{1'b1}};    
                       `endif 
                   end
          end
        end



        logic clk_ab ; 

        `ifdef INTEL_SIMONLY
        assign clk_ab = clk_a | clk_b; 
        `else
           assign clk_ab = clk_a;
        `endif

        always @(posedge clk_ab) begin          // lintra s-50000
                for (int i=0; i<MEM_WR_EN_WIDTH; i=i+1) begin

                        if (wr_en_a[i]) 
                                sram[wr_add_a][i*MEM_WR_RESOLUTION+:MEM_WR_RESOLUTION]             <= data_in_a[i*MEM_WR_RESOLUTION+:MEM_WR_RESOLUTION]    ;
                        if (wr_en_b[i]) 
                                sram[wr_add_b][i*MEM_WR_RESOLUTION+:MEM_WR_RESOLUTION]             <= data_in_b[i*MEM_WR_RESOLUTION+:MEM_WR_RESOLUTION]    ;
                end
        end

     `ifdef HLP_MGM_EMU_FPGA
            logic   [MEM_WIDTH-1:0]         data_out_a_int; 
            logic   [MEM_WIDTH-1:0]         data_out_b_int; 
            logic   apply_mask_a; 
            logic   apply_mask_b; 
            always_ff  @(posedge clk_ab) begin
              apply_mask_a <=  MEM_ADDR_COLL_X & rd_en_a & (|wr_en_a) & (rd_add_a == wr_add_a) ; 
              apply_mask_b <=  MEM_ADDR_COLL_X & rd_en_b & (|wr_en_b) & (rd_add_b == wr_add_b) ; 

            end



              always_comb
              begin
                  if ( apply_mask_a)
                          data_out_a[MEM_WIDTH-1:0]   =  data_out_a_int ^ mask_vec_a_d;
                  else 
                          data_out_a[MEM_WIDTH-1:0]   =  data_out_a_int ;
              end

              always_comb
              begin
                  if (apply_mask_b)
                          data_out_b[MEM_WIDTH-1:0]   =  data_out_b_int ^ mask_vec_b_d;
                  else 
                          data_out_b[MEM_WIDTH-1:0]   =  data_out_b_int ;
              end





              always_ff @(posedge clk_ab) begin


                       if ( MEM_ADDR_COLL_X &  
                           ((rd_en_a & (|wr_en_a) & (rd_add_a == wr_add_a))  |
                            (rd_en_a & (|wr_en_b) & (rd_add_a == wr_add_b))     
                            )
                           )
                               data_out_a_int[MEM_WIDTH-1:0]         <= sram[rd_add_a][MEM_WIDTH-1:0] ;
                       else if (rd_en_a) 
                         begin
                               mask_vec_a_d  <=   mask_vec_a; 
    
                               if ( rd_add_a >= MEM_DEPTH)             // lintra s-2034

                                 // for emulation - driving corrupted non-zero value 
                                  `ifdef INTEL_SIMONLY                                        
                                     data_out_a_int[MEM_WIDTH-1:0]         <= {MEM_WIDTH{1'bx}};  // lintra s-50002
                                  `else
                                     data_out_a_int[MEM_WIDTH-1:0]         <= sram[rd_add_a][MEM_WIDTH-1:0];
                                  `endif
                                 else
                                     data_out_a_int[MEM_WIDTH-1:0]         <= sram[rd_add_a][MEM_WIDTH-1:0];

                         end
                         


                       if ( MEM_ADDR_COLL_X &
                           ((rd_en_b & (|wr_en_b) & (rd_add_b == wr_add_b))  |
                            (rd_en_b & (|wr_en_a) & (rd_add_b == wr_add_a))     

                           )
                           )
                               data_out_b_int[MEM_WIDTH-1:0]          <= sram[rd_add_b][MEM_WIDTH-1:0];
                       else if (rd_en_b)
                         begin 
                            mask_vec_b_d  <=   mask_vec_b; 
                            if ( rd_add_b >= MEM_DEPTH)                    // lintra s-2034
                                 // for emulation - driving corrupted non-zero value 
                                  `ifdef INTEL_SIMONLY                                        
                                     data_out_b_int[MEM_WIDTH-1:0]         <= {MEM_WIDTH{1'bx}};  // lintra s-50002 
                                  `else
                                     data_out_b_int[MEM_WIDTH-1:0]          <= sram[rd_add_b][MEM_WIDTH-1:0];
                                  `endif
                                 else
                                     data_out_b_int[MEM_WIDTH-1:0]          <= sram[rd_add_b][MEM_WIDTH-1:0];

                         end
                         
               end 
      `else 
              always_ff @(posedge clk_ab) begin

                     `ifdef INTEL_SIMONLY
                   
                       if ( MEM_ADDR_COLL_X &  
                           ((rd_en_a & (|wr_en_a) & (rd_add_a == wr_add_a))  |
                            (rd_en_a & (|wr_en_b) & (rd_add_a == wr_add_b))     
                            )
                           )
                               data_out_a[MEM_WIDTH-1:0]         <= sram[rd_add_a][MEM_WIDTH-1:0] ^ mask_vec_a;
                       else
                      `endif
                          if (rd_en_a) 
                               if ( rd_add_a >= MEM_DEPTH)             // lintra s-2034

                                 // for emulation - driving corrupted non-zero value 
                                  `ifdef INTEL_SIMONLY                                        
                                     data_out_a[MEM_WIDTH-1:0]         <= {MEM_WIDTH{1'bx}};  // lintra s-50002
                                  `else
                                     data_out_a[MEM_WIDTH-1:0]         <= sram[rd_add_a][MEM_WIDTH-1:0];
                                  `endif
                                 else
                                     data_out_a[MEM_WIDTH-1:0]         <= sram[rd_add_a][MEM_WIDTH-1:0];


                     `ifdef INTEL_SIMONLY


                       if ( MEM_ADDR_COLL_X &
                           ((rd_en_b & (|wr_en_b) & (rd_add_b == wr_add_b))  |
                            (rd_en_b & (|wr_en_a) & (rd_add_b == wr_add_a))     

                           )
                           )
                               data_out_b[MEM_WIDTH-1:0]          <= sram[rd_add_b][MEM_WIDTH-1:0] ^ mask_vec_b;
                        else 
                          
                      `endif
                          if (rd_en_b) 
                            if ( rd_add_b >= MEM_DEPTH)                    // lintra s-2034
                                 // for emulation - driving corrupted non-zero value 
                                  `ifdef INTEL_SIMONLY                                        
                                     data_out_b[MEM_WIDTH-1:0]         <= {MEM_WIDTH{1'bx}};  // lintra s-50002 
                                  `else
                                     data_out_b[MEM_WIDTH-1:0]          <= sram[rd_add_b][MEM_WIDTH-1:0];
                                  `endif
                                 else
                                     data_out_b[MEM_WIDTH-1:0]          <= sram[rd_add_b][MEM_WIDTH-1:0];


               end 



      `endif
        
`else 
   assign   data_out_a   = 0; 
   assign   data_out_b   = 0; 
`endif
        


endmodule//mgm_2rw_behave
