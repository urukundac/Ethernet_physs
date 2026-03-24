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
//    FILENAME          : mgm_gen_ffs.v
//    DESIGNER          : Anatoly Uskach
//    DATE              : 16/02/16
//    REVISION NUMBER   : 1.0
//    DESCRIPTION       :
//
//         Find First Set. Searches in 0 -> (INP_WDTH-1) (or inverse) direction & returns the index of first bit that eq 1.
//         The timing path is of LOG2(INP_WDTH) depth.
//
//---------------------------------------------------------------------------//
// --------------------------------------------------------------------------//
//      LAST MODIFICATION:      16/02/16
//      RECENT AUTHORS:         yevgeny.yankilevich@intel.com
//      PREVIOUS RELEASES:      
//                              16/02/16: First version.
// --------------------------------------------------------------------------//
module hlp_mgm_gen_ffs #(
        parameter       INP_WDTH        = 6                     ,
        parameter       INP_WDTH_LOG    = (INP_WDTH>1) ? $clog2(INP_WDTH) : 1     ,
        parameter       SRCH_DIR        = 1                     , // 1 - from 0 to MSB, 0 - from MSB to 0
        parameter       INP_FUL_WDTH    = 2**INP_WDTH_LOG       ,
        parameter       CONST1          = 1
)( /*AUTOARG*/
        output  logic                           fs_vld  ,
        output  logic   [INP_WDTH_LOG-1:0]      fs_idx  , 

        input   logic   [INP_WDTH-1:0]          inp_vect
  );

  
  

  genvar i;
  genvar j;
  
  reg  [INP_FUL_WDTH  :1] inp_vect_fxd                                             ;
  wire [INP_WDTH_LOG-1:0] tmp_result [2*INP_FUL_WDTH:2]                            ;
  wire [2*INP_FUL_WDTH:2] tmp_result_vld                                           ;

  always_comb
    begin
      inp_vect_fxd = {INP_FUL_WDTH{1'b0}};
      inp_vect_fxd[INP_WDTH:1] = inp_vect;
    end
  

  generate 
    for (i=INP_WDTH_LOG; i>=0; i=i-1) begin: level_i // synthesis loop_limit 4000
      for (j=2**i; j>0; j=j-1) begin: bit_j 
        if (i==INP_WDTH_LOG) begin: first_level
          assign tmp_result_vld[(2**i)+j] = inp_vect_fxd[j]                          ;
          assign tmp_result[(2**i)+j] = j[INP_WDTH_LOG-1:0] - CONST1[0+:INP_WDTH_LOG];
        end else begin: non_first_level
          assign tmp_result_vld[(2**i)+j] = |tmp_result_vld[(2**(i+1))+(j*2)-:2]         ;
          assign tmp_result    [(2**i)+j] =  tmp_result_vld[(2**(i+1))+(j*2)-SRCH_DIR  ] ?
                                           tmp_result    [(2**(i+1))+(j*2)-SRCH_DIR  ] :
                                           tmp_result    [(2**(i+1))+(j*2)-1+SRCH_DIR] ;
        end
      end // block: bit
    end // block: level       
  endgenerate  
  
  assign         fs_vld = tmp_result_vld[2]                                        ;
  assign         fs_idx = tmp_result    [2]                                        ;
  
endmodule // mgm_gen_ffs
