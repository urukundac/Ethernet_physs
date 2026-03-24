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
//    FILENAME          : mgm_1rw_behave.v
//    DESIGNER          : Yevgeny Yankilevich
//    DATE              : 16/02/16
//    REVISION NUMBER   : 1.0
//    DESCRIPTION       :
//
//          Generic single port SRAM model
//
//---------------------------------------------------------------------------//
// --------------------------------------------------------------------------//
//      LAST MODIFICATION:      16/02/16
//      RECENT AUTHORS:         yevgeny.yankilevich@intel.com
//      PREVIOUS RELEASES:      
//                              16/02/16: First version.
// --------------------------------------------------------------------------//

module hlp_mgm_1rw_behave #(
        parameter       MEM_WIDTH                               = 2                                                                                                                     ,
        parameter       MEM_DEPTH                               = 3                                                                                                                     ,
        parameter       MEM_WR_RESOLUTION                       = MEM_WIDTH                                                                                                             ,
        parameter       MEM_WR_EN_WIDTH                         = (MEM_WIDTH/MEM_WR_RESOLUTION)                                                                                         ,
        parameter       MEM_ADR_WIDTH                           = (MEM_DEPTH>1) ? $clog2(MEM_DEPTH) : 1
)(
        input   logic                           clk                     ,
        input   logic   [MEM_ADR_WIDTH-1:0]     address                 ,
        input   logic                           rd_en                   ,
        input   logic   [MEM_WR_EN_WIDTH-1:0]   wr_en                   ,
        input   logic   [      MEM_WIDTH-1:0]   data_in                 ,
        output  logic   [      MEM_WIDTH-1:0]   data_out
);

`ifndef INTEL_DC

     `ifndef INTEL_SVA_OFF
        import intel_checkers_pkg::*;   
     `endif

            logic [MEM_WIDTH-1:0]   sram[MEM_DEPTH-1:0];

            always  @(posedge clk) begin                                                            // lintra s-50000 
                    if (rd_en) begin
                              if (( address >=  MEM_DEPTH ) | (|wr_en))                                // lintra s-2034

                              // for emulation - driving corrupted non-zero value in case reading while writing 
                              `ifdef INTEL_SIMONLY                                        
                                  data_out                               <=   {MEM_WIDTH{1'bx}};    // lintra s-50002            
                              `else
                                  data_out                               <=    sram[address]   ;
                              `endif

                              else
                                  data_out                               <=    sram[address]   ;
                    end 

                    if (|wr_en) begin
                            for (int i=0; i<MEM_WR_EN_WIDTH; i=i+1) begin
                                    if (wr_en[i]) begin
                                            if (~rd_en)
                                                sram[address][i*MEM_WR_RESOLUTION+:MEM_WR_RESOLUTION]   <= data_in[i*MEM_WR_RESOLUTION+:MEM_WR_RESOLUTION]      ;
                                            else
                                           // for emulation - driving corrupted non-zero value in case reading while writing 
                                           `ifdef INTEL_SIMONLY                                        
                                                sram[address][i*MEM_WR_RESOLUTION+:MEM_WR_RESOLUTION]   <= {MEM_WR_RESOLUTION{1'bx}}     ; // lintra s-50002
                                           `else
                                                sram[address][i*MEM_WR_RESOLUTION+:MEM_WR_RESOLUTION]   <= {MEM_WR_RESOLUTION{1'b1}}     ;  
                                           `endif

                                    end
                            end
                    end
            end

    `ifndef INTEL_SVA_OFF
        `ASSERTS_TRIGGER (illegal_wen_ren, (|wr_en) , ~rd_en, posedge clk, 1'b0,
            `ERR_MSG ( "Error message WR_EN and RD_EN are both asserted" ) ) ;

    `endif
`else 
    assign  data_out   = 0; 
 `endif
        
endmodule//mgm_1rw_behave
