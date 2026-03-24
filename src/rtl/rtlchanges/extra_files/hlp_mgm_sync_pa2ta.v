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
//    FILENAME          : mgm_sync_pa2ta.v
//    DESIGNER          : Anatoly Uskach
//    DATE              : 16/02/16
//    REVISION NUMBER   : 1.0
//    DESCRIPTION       :
//
//          The module turns pulse to toggle on the same domain (A)
//          It is the initial module of the pulse(A) to pulse(B) & pulse(A) to toggle(B) synchronizations.
//          The toggle signal change its state on each pulse.
//
//---------------------------------------------------------------------------//
// --------------------------------------------------------------------------//
//      LAST MODIFICATION:      16/02/16
//      RECENT AUTHORS:         yevgeny.yankilevich@intel.com
//      PREVIOUS RELEASES:      
//                              16/02/16: First version.
// --------------------------------------------------------------------------//
module hlp_mgm_sync_pa2ta #(

        parameter BUS_WIDTH = 1

)(      

        input   logic                   clka            ,
        input   logic                   rst_n_a         ,       
        input   logic   [BUS_WIDTH-1:0] pulse_in        ,
        output  logic   [BUS_WIDTH-1:0] toggle_out
);

       
    
    always_ff @(posedge clka or negedge rst_n_a)
      begin 
        if (~rst_n_a) 
          toggle_out <= {(BUS_WIDTH){1'b0}}; 
        else 
          toggle_out <= toggle_out ^ pulse_in;
      end    
    
endmodule//mgm_sync_pa2ta
