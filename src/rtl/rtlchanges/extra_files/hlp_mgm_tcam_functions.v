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
//    FILENAME          : mgm_functions.v
//    DESIGNER          : Yevgeny Yankilevich
//    DATE              : 16/02/16
//    REVISION NUMBER   : 1.0
//    DESCRIPTION       :
//
//          gen_ecc and protection word calc  Function
//
//---------------------------------------------------------------------------//
// --------------------------------------------------------------------------//
//      LAST MODIFICATION:      08/18
//      RECENT AUTHORS:         Avi Costo
//      PREVIOUS RELEASES:      
//                              16/02/16: First version.
// --------------------------------------------------------------------------//
module hlp_mgm_tcam_functions #(



        parameter       TCAM_WIDTH                               = 40        
 

  
  )
  
  ();



  function automatic chk0_chng;
      // INPUTS
      input                      rd_line_e0_bit ;
      input                      rd_line_e1_bit ;
      input                      wr_line_bit    ;
      input                      wr_line_num    ;

        casez ({rd_line_e0_bit, rd_line_e1_bit, wr_line_bit})
              3'b000: begin
                      chk0_chng = 1'b0                          ;
              end
              3'b001: begin
                      chk0_chng = (!wr_line_num) ? 1'b1 : 1'b0  ;
              end
              3'b010: begin
                      chk0_chng = 1'b0                          ;
              end
              3'b011: begin
                      chk0_chng = (!wr_line_num) ? 1'b1 : 1'b0  ;
              end
              3'b100: begin
                      chk0_chng = (!wr_line_num) ? 1'b1 : 1'b0  ;
              end
              3'b101: begin
                      chk0_chng = 1'b0                          ;
              end             
              3'b110: begin
                      chk0_chng = (!wr_line_num) ? 1'b1 : 1'b0  ;
              end
              3'b111: begin
                      chk0_chng = 1'b0                          ;
              end
              default: begin
                      chk0_chng = 1'b0                          ;               
              end
        endcase
        
   endfunction

   function automatic chk1_chng;
      // INPUTS
      input                      rd_line_e0_bit ;
      input                      rd_line_e1_bit ;
      input                      wr_line_bit    ;
      input                      wr_line_num    ;

        casez ({rd_line_e0_bit, rd_line_e1_bit, wr_line_bit})
              3'b000: begin
                      chk1_chng = 1'b0                          ;
              end
              3'b001: begin
                      chk1_chng = (wr_line_num) ? 1'b1 : 1'b0   ;
              end
              3'b010: begin
                      chk1_chng = (wr_line_num) ? 1'b1 : 1'b0   ;
              end
              3'b011: begin
                      chk1_chng = 1'b0                          ;
              end
              3'b100: begin
                      chk1_chng = 1'b0                          ;
              end
              3'b101: begin
                      chk1_chng = (wr_line_num) ? 1'b1 : 1'b0   ;
              end             
              3'b110: begin
                      chk1_chng = (wr_line_num) ? 1'b1 : 1'b0   ;
              end
              3'b111: begin
                      chk1_chng = 1'b0                          ;
              end
              default: begin
                      chk1_chng = 1'b0                          ;               
              end
        endcase
        
   endfunction

   function automatic [TCAM_WIDTH-1:0]   exp_patrn_update_val_0 ;
      // INPUTS
    input [TCAM_WIDTH-1:0] exp_patrn_0; 
    input [TCAM_WIDTH-1:0] wr_data; 
    input [TCAM_WIDTH-1:0] e0_rd_data; 
    input [TCAM_WIDTH-1:0] e1_rd_data;
    input                  adr_lsb; 

    for (int i=0; i<TCAM_WIDTH; i=i+1) begin                                                        
            exp_patrn_update_val_0[i]   = (chk0_chng(e0_rd_data[i], e1_rd_data[i], wr_data[i], adr_lsb)) ^ (exp_patrn_0[i])  ;
    end
   endfunction


   function automatic [TCAM_WIDTH-1:0]   exp_patrn_update_val_1 ;
      // INPUTS
    input [TCAM_WIDTH-1:0] exp_patrn_1; 
    input [TCAM_WIDTH-1:0] wr_data; 
    input [TCAM_WIDTH-1:0] e0_rd_data; 
    input [TCAM_WIDTH-1:0] e1_rd_data; 
    input                  adr_lsb; 

    for (int i=0; i<TCAM_WIDTH; i=i+1) begin                                                        
            exp_patrn_update_val_1[i] = (chk1_chng(e0_rd_data[i], e1_rd_data[i], wr_data[i], adr_lsb)) ^ (exp_patrn_1[i])  ;
    end
   endfunction
 
   
endmodule // mgm_functions
