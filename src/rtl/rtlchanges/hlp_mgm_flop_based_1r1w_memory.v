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
//    FILENAME          : mgm_flop_based_1r1w_memory.v
//    DESIGNER          : Yevgeny Yankilevich
//    DATE              : 16/02/16
//    REVISION NUMBER   : 1.0
//    DESCRIPTION       :
//
//          Flop Based 1r1w Memory
//
//---------------------------------------------------------------------------//
// --------------------------------------------------------------------------//
//      LAST MODIFICATION:      16/02/16
//      RECENT AUTHORS:         yevgeny.yankilevich@intel.com
//      PREVIOUS RELEASES:      
//                              16/02/16: First version.
//                              31/08/16: Change in the parameters order.
// --------------------------------------------------------------------------//
module hlp_mgm_flop_based_1r1w_memory #(
        parameter       MEM_WIDTH                               = 2                                                                                                                     ,
        parameter       MEM_DEPTH                               = 3                                                                                                                     ,
        parameter       MEM_WR_EN_WIDTH                         = 1                                                                                                                     ,        
        parameter       MEM_WR_RESOLUTION                       = (MEM_WIDTH/MEM_WR_EN_WIDTH)                                                                                           ,
        parameter       MEM_ADR_WIDTH                           = (MEM_DEPTH>1) ? $clog2(MEM_DEPTH) : 1
)(
        input   logic                           rd_clk                  ,
        input   logic                           wr_clk                  ,       
        input   logic   [MEM_ADR_WIDTH-1:0]     rd_add                  ,
        input   logic   [MEM_ADR_WIDTH-1:0]     wr_add                  ,
        input   logic                           rd_en                   ,
        input   logic   [MEM_WR_EN_WIDTH-1:0]   wr_en                   ,
        input   logic   [      MEM_WIDTH-1:0]   data_in                 ,
        output  logic   [      MEM_WIDTH-1:0]   data_out
);

        logic [MEM_WIDTH-1:0]   mem_array[MEM_DEPTH-1:0]; 
        logic [MEM_WIDTH-1:0]   data_out_pre;

        // do not replace to always_ff to enable fast init. See bug 1305062263
        always  @(posedge wr_clk) begin    // lintra s-50000
                for (int i=0; i<MEM_WR_EN_WIDTH; i=i+1) begin
                        if (wr_en[i]) begin
                                mem_array[wr_add][i*MEM_WR_RESOLUTION+:MEM_WR_RESOLUTION]               <= data_in[i*MEM_WR_RESOLUTION+:MEM_WR_RESOLUTION]      ;
                        end
                end
        end
// https://hsdes.intel.com/appstore/article/#/1306210856
//1r1w_2c flops implementation to use infered mux


         always_ff    @(posedge rd_clk) begin
                 if (rd_en) begin
                         data_out[MEM_WIDTH-1:0]                                                         <= data_out_pre;
                 end
         end  


      // Implementation meant to avoid data dependent mux taken from ecip_gen_dual_port_ram_v1
        logic [2**(MEM_ADR_WIDTH+1)-1:1] tmp_wire [MEM_WIDTH-1:0];

        genvar l,w,m,i;

        generate
            for (w=MEM_WIDTH-1; w>=0; w--) begin : fifo_width
                for (i=0; i<2**MEM_ADR_WIDTH; i++) begin : init_values
                    if (i>=MEM_DEPTH) begin : out_of_wdth
                        assign tmp_wire[w][2**MEM_ADR_WIDTH+i] = 1'b0;
                    end else begin: in_wdth
                        assign tmp_wire[w][2**MEM_ADR_WIDTH+i] = mem_array[i][w];
                    end
                end

                for (l=MEM_ADR_WIDTH; l>0; l--) begin : mux_level
                    for (m=(2**(l-1))-1; m>=0; m--) begin : mux_inst_in_row
//                         ctech_lib_mux_2to1 ctech_lib_mux_2to1 (
//                             .d1  (tmp_wire[w][2**l+2*m  ]),
//                             .d2  (tmp_wire[w][2**l+2*m+1]),
//                             .s   (~rd_add   [MEM_ADR_WIDTH-l]      ),
//                             .o   (tmp_wire[w][2**(l-1)+m])
//                         );
                    
                        always_comb
                        case (~rd_add   [MEM_ADR_WIDTH-l])  //synopsys infer_mux_override
                          1'b1: tmp_wire[w][2**(l-1)+m] = tmp_wire[w][2**l+2*m  ]; 
                          1'b0: tmp_wire[w][2**(l-1)+m] = tmp_wire[w][2**l+2*m+1]; 
                        endcase
                     
                    end
                end
                assign data_out_pre[w] = tmp_wire[w][1];
            end
        endgenerate


  
endmodule//mgm_flop_based_1r1w_memory
