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
//    FILENAME          : mgm_sync_ta2pb.v
//    DESIGNER          : Anatoly Uskach
//    DATE              : 16/02/16
//    REVISION NUMBER   : 1.0
//    DESCRIPTION       :
//
//          The module turns toggle from domain A into pulse on domain B.
//          This module is the end module of the pulse(A) to pulse(B) synchronization.
//          A pulse is asserted every time the toggle change its state.
//
//---------------------------------------------------------------------------//
// --------------------------------------------------------------------------//
//      LAST MODIFICATION:      16/02/16
//      RECENT AUTHORS:         yevgeny.yankilevich@intel.com
//      PREVIOUS RELEASES:      
//                              16/02/16: First version.
// --------------------------------------------------------------------------//
module hlp_mgm_sync_ta2pb #(

        parameter BUS_WIDTH      = 1,
        parameter SYN_RND_ENABLE = 1

)(

        input   logic                   clkb,
        input   logic                   rst_n_b,
        input   logic   [BUS_WIDTH-1:0] toggle_in,
        output  logic   [BUS_WIDTH-1:0] pulse_out

);
    
    
    //internal signals
    wire [BUS_WIDTH-1:0] synced_toggle_in; 
    reg  [BUS_WIDTH-1:0] last_toggle_in; //toggle in from previous clk 
        
    assign pulse_out = last_toggle_in ^ synced_toggle_in;    
    
    always_ff @(posedge clkb or negedge rst_n_b)
      begin 
        if (~rst_n_b)  
          last_toggle_in <= {BUS_WIDTH{1'b0}}; 
        else 
          last_toggle_in <= synced_toggle_in;
      end 
     
    hlp_mgm_sync_ta2tb #(.BUS_WIDTH      (BUS_WIDTH),
                             .RST_VALUE      ({BUS_WIDTH{1'b0}}),
                             .SYN_RND_ENABLE (SYN_RND_ENABLE)) 
    gen_sync_ta2pb_ta2tb ( 
                          .clkb       (clkb),
                          .rst_n_b    (rst_n_b), 
                          .toggle_in  (toggle_in), 
                          .toggle_out (synced_toggle_in)
                                    ) ;  
    
endmodule//mgm_sync_ta2pb
