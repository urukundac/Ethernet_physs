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
//    FILENAME          : mgm_sync_pa2pb.v
//    DESIGNER          : Omri Afek
//    DATE              : 16/02/16
//    REVISION NUMBER   : 1.0
//    DESCRIPTION       :
//
//          The module sync pulse from domain A to pulse on domain B.
//
//---------------------------------------------------------------------------//
// --------------------------------------------------------------------------//
//      LAST MODIFICATION:      16/02/16
//      RECENT AUTHORS:         yevgeny.yankilevich@intel.com
//      PREVIOUS RELEASES:      
//                              16/02/16: First version.
// --------------------------------------------------------------------------//
module hlp_mgm_sync_pa2pb #(
        parameter BUS_WIDTH             = 1,
        parameter SYN_SEED              = 1,
        parameter SYN_RND_ENABLE        = 1
)(
        input   logic                   clka            ,
        input   logic                   clkb            ,
        input   logic                   rst_n_a         ,
        input   logic                   rst_n_b         ,
        input   logic   [BUS_WIDTH-1:0] pulse_in        , 
        output  logic   [BUS_WIDTH-1:0] pulse_out
);


//internal signals
wire [BUS_WIDTH-1:0] pa2ta_ta2pb; //toggled signal from domain A toward domain B


hlp_mgm_sync_pa2ta #(.BUS_WIDTH(BUS_WIDTH)) u_sync_pa2pb_pa2ta (
            .clka (clka),
            .rst_n_a (rst_n_a),
            .pulse_in (pulse_in),
            .toggle_out (pa2ta_ta2pb)
             );

hlp_mgm_sync_ta2pb #(.BUS_WIDTH(BUS_WIDTH), .SYN_RND_ENABLE(SYN_RND_ENABLE)) u_sync_pa2pb_ta2pb (
                        .clkb (clkb), 
                        .rst_n_b (rst_n_b), 
                        .toggle_in (pa2ta_ta2pb),
                        .pulse_out (pulse_out)
                         );                     
endmodule//mgm_sync_pa2pb
