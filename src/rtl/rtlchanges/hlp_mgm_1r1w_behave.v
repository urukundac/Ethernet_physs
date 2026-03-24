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
//    FILENAME          : mgm_1r1w_behave.v
//    DESIGNER          : Yevgeny Yankilevich
//    DATE              : 16/02/16
//    REVISION NUMBER   : 1.0
//    DESCRIPTION       :
//
//          Generic 1r1w port model
//
//---------------------------------------------------------------------------//
// --------------------------------------------------------------------------//
//      LAST MODIFICATION:      16/02/16
//      RECENT AUTHORS:         yevgeny.yankilevich@intel.com
//      PREVIOUS RELEASES:      
//                              16/02/16: First version.
// --------------------------------------------------------------------------//
module hlp_mgm_1r1w_behave #(
        parameter       MEM_WIDTH               = 2                                                                                                                                                          ,
        parameter       MEM_DEPTH               = 3                                                                                                                                                          ,
        parameter       MEM_WR_RESOLUTION       = MEM_WIDTH                                                                                                                                ,
        parameter       MEM_WR_EN_WIDTH         = (MEM_WIDTH/MEM_WR_RESOLUTION)                                                                                            ,
        parameter       MEM_ADR_WIDTH           = (MEM_DEPTH>1) ? $clog2(MEM_DEPTH) : 1    , 
        parameter       MEM_ADDR_COLL_X         = 1
)(
        input   logic                           rd_clk  ,
        input   logic                           wr_clk  ,
        input   logic   [MEM_ADR_WIDTH-1:0]     rd_add  ,
        input   logic   [MEM_ADR_WIDTH-1:0]     wr_add  ,
        input   logic                           rd_en   ,
        input   logic   [MEM_WR_EN_WIDTH-1:0]   wr_en   ,
        input   logic   [MEM_WIDTH-1:0]         data_in ,
        output  logic   [MEM_WIDTH-1:0]         data_out
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
        logic [MEM_WIDTH-1:0]   mask_vec ; 
        logic [MEM_WIDTH-1:0]   mask_vec_d ; 
        
        always  @(posedge wr_clk) begin             // lintra s-50000    
                for (int i=0; i<MEM_WR_EN_WIDTH; i=i+1) begin
                        if (wr_en[i]) begin
                                sram[wr_add][i*MEM_WR_RESOLUTION+:MEM_WR_RESOLUTION]            <= data_in[i*MEM_WR_RESOLUTION+:MEM_WR_RESOLUTION]      ;
                        end
                end
        end
        
        
        
        // mask_vec would set 'Xs to the matching wr_en data bits
        always_comb 
        begin
          mask_vec = 0; 

             for (int i=0; i<MEM_WR_EN_WIDTH; i=i+1) begin
                      if (wr_en[i]) begin
                      // for emulation - inverting outputs instead of driving 'x
                      `ifdef INTEL_SIMONLY
                              mask_vec[i*MEM_WR_RESOLUTION+:MEM_WR_RESOLUTION]  =   {MEM_WR_RESOLUTION{1'bx}};         // lintra s-50002
                      `else  
                              mask_vec[i*MEM_WR_RESOLUTION+:MEM_WR_RESOLUTION]  =   {MEM_WR_RESOLUTION{1'b1}};         
                      `endif  
                      end
             end
        end
        
        
    `ifdef   HLP_MGM_EMU_FPGA
    
       logic   [MEM_WIDTH-1:0]         data_out_int; 
       logic   apply_mask; 
       always_ff  @(posedge rd_clk) begin
         apply_mask <= MEM_ADDR_COLL_X & rd_en & (|wr_en) & (rd_add == wr_add) ; 
       
       end
       
       
       
       always_comb
       begin
           if (apply_mask)
                   data_out[MEM_WIDTH-1:0]   =  data_out_int ^ mask_vec_d;
           else 
                   data_out[MEM_WIDTH-1:0]   =  data_out_int ;
       end
       
       always_ff  @(posedge rd_clk) begin
                  if (rd_en) begin 
                     mask_vec_d  <=   mask_vec; 
                     
                                       
                     if ( rd_add >= MEM_DEPTH)                                             // lintra s-2034
                    // for emulation - driving corrupted non-zero value in case reading while writing 
                      `ifdef INTEL_SIMONLY                                        
                           data_out_int                  <=   {MEM_WIDTH{1'bx}};                 // lintra s-50002
                      `else                    
                              data_out_int[MEM_WIDTH-1:0]   <= sram[rd_add][MEM_WIDTH-1:0];
                      `endif                     
                         else
                              data_out_int[MEM_WIDTH-1:0]   <= sram[rd_add][MEM_WIDTH-1:0];
                  end
        end  

    `else 
        always_ff  @(posedge rd_clk) begin

               `ifdef INTEL_SIMONLY
                if ( MEM_ADDR_COLL_X & rd_en & (|wr_en) & (rd_add == wr_add))
                        data_out[MEM_WIDTH-1:0]   <=  sram[rd_add][MEM_WIDTH-1:0] ^ mask_vec;
                else 
                  
                `endif  
                  if (rd_en) begin                      
                            if ( rd_add >= MEM_DEPTH)                                             // lintra s-2034
                          // for emulation - driving corrupted non-zero value in case reading while writing 
                          `ifdef INTEL_SIMONLY                                        
                                data_out                  <=   {MEM_WIDTH{1'bx}};                 // lintra s-50002
                          `else                    
                              data_out[MEM_WIDTH-1:0]   <= sram[rd_add][MEM_WIDTH-1:0];
                          `endif                     
                            else
                              data_out[MEM_WIDTH-1:0]   <= sram[rd_add][MEM_WIDTH-1:0];
                  end
        end  

     `endif    // INTEL_FPGA


 `else 
   assign   data_out    = 0; 
 `endif
                     
endmodule//mgm_1r1w_behave
