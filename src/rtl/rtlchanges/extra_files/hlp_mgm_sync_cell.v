//----------------------------------------------------------------------------//
//    Copyright (c) 2006 Intel Corporation
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
//    FILENAME          : mgm_sync_cell.v
//    DESIGNER          : Omri Afek
//    DATE              : 16/02/16
//    REVISION NUMBER   : 1.0
//    DESCRIPTION       :
//
//          Two FF syncrinizer of 1 bit
//
//---------------------------------------------------------------------------//
// --------------------------------------------------------------------------//
//      LAST MODIFICATION:      08/22/17
//      RECENT AUTHORS:         ynizri
//      PREVIOUS RELEASES:      
//                              16/02/16: First version.
// --------------------------------------------------------------------------// 
module hlp_mgm_sync_cell
   #(
     parameter             META_EN    =  1
    )
    (

        output logic    out     , 

        input logic     clk     ,
        input logic     rst_b   ,
        input logic     d       
  );


  ctech_lib_doublesync_rstb #(.METASTABILITY_EN(META_EN), 
                              .TX_MODE          (1)
//                                ,
//                               .ENABLE_3TO1(0)
                              )
  u_sync_cell
              (.rstb (rst_b),
               .clk  (clk),
               .d    (d),
               .o    (out));
                          
endmodule//mgm_sync_cell
