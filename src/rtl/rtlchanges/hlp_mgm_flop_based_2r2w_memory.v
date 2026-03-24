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
//    FILENAME          : mgm_flop_based_2r2w_memory.v
//    DESIGNER          : Avi Costo
//    DATE              : 16/02/17
//    REVISION NUMBER   : 1.0
//    DESCRIPTION       :
//
//          Flop Based 1r1w Memory
//
//---------------------------------------------------------------------------//
// --------------------------------------------------------------------------//
//      LAST MODIFICATION:      16/02/17
//      RECENT AUTHORS:         yevgeny.yankilevich@intel.com
//      PREVIOUS RELEASES:      
//                              16/02/17: First version.
//                              March 23rd 2017: 
// --------------------------------------------------------------------------//
module hlp_mgm_flop_based_2r2w_memory #(
        parameter       MEM_WIDTH                               = 2                                                                                                                     ,
        parameter       MEM_DEPTH                               = 3                                                                                                                     ,
        parameter       MEM_WR_RESOLUTION                       = MEM_WIDTH                                                                                                             ,
        parameter       MEM_WR_EN_WIDTH                         = (MEM_WIDTH/MEM_WR_RESOLUTION)                                                                                         ,
        parameter       MEM_ADR_WIDTH                           = (MEM_DEPTH>1) ? $clog2(MEM_DEPTH) : 1
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

        logic [MEM_WIDTH-1:0]   mem_array[MEM_DEPTH-1:0];
        logic clk_ab ; 

 		`ifdef INTEL_SIMONLY
        assign clk_ab = clk_a | clk_b; 
		`else
           assign clk_ab = clk_a;
        `endif

        // do not replace to always_ff to enable fast init. See bug 1305062263
        always   @(posedge clk_ab) begin     // lintra s-50000
                for (int i=0; i<MEM_WR_EN_WIDTH; i=i+1) begin

                        if (wr_en_a[i]) 
                                mem_array[wr_add_a][i*MEM_WR_RESOLUTION+:MEM_WR_RESOLUTION]             <= data_in_a[i*MEM_WR_RESOLUTION+:MEM_WR_RESOLUTION]    ;
                        if (wr_en_b[i]) 
                                mem_array[wr_add_b][i*MEM_WR_RESOLUTION+:MEM_WR_RESOLUTION]             <= data_in_b[i*MEM_WR_RESOLUTION+:MEM_WR_RESOLUTION]    ;
                end
        end

        always_ff   @(posedge clk_ab) begin
                
             if (rd_en_a) 
                        data_out_a[MEM_WIDTH-1:0]        <= mem_array[rd_add_a][MEM_WIDTH-1:0];



               if (rd_en_b) 
                        data_out_b[MEM_WIDTH-1:0]        <= mem_array[rd_add_b][MEM_WIDTH-1:0];
        end 
        

          
endmodule 
