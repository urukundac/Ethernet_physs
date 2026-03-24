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
//    FILENAME          : mgm_sync_pa2tb.v
//    DESIGNER          : Anatoly Uskach
//    DATE              : 16/02/16
//    REVISION NUMBER   : 1.0
//    DESCRIPTION       :
//
//          The module sync pulse from domain A into toggle on domain B.
//
//---------------------------------------------------------------------------//
// --------------------------------------------------------------------------//
//      LAST MODIFICATION:      16/02/16
//      RECENT AUTHORS:         yevgeny.yankilevich@intel.com
//      PREVIOUS RELEASES:      
//                              16/02/16: First version.
// --------------------------------------------------------------------------//

module hlp_mgm_sync_pa2tb #(

        parameter       BUS_WIDTH       = 1,
        parameter       SYN_RND_ENABLE  = 1 

)(

input   logic                   clka    ,
input   logic                   clkb    , 
input   logic                   rst_n_a , 
input   logic                   rst_n_b , 
input   logic [BUS_WIDTH-1:0]   pulse_in, 
output  logic [BUS_WIDTH-1:0]   toggle_out
);



//internal signals
wire [BUS_WIDTH-1:0] pa2ta_siga2sigb; //toggled signal from domain A toward domain B


hlp_mgm_sync_pa2ta #(.BUS_WIDTH(BUS_WIDTH)) gen_sync_pa2tb_pa2ta (
            .clka       (clka),
            .rst_n_a    (rst_n_a),
            .pulse_in   (pulse_in),
            .toggle_out (pa2ta_siga2sigb)
             );

hlp_mgm_sync_ta2tb #(.BUS_WIDTH      (BUS_WIDTH),
                         .RST_VALUE      ({BUS_WIDTH{1'b0}}),
                         .SYN_RND_ENABLE (SYN_RND_ENABLE)) 
gen_sync_pa2tb_ta2tb (
                  .toggle_in (pa2ta_siga2sigb),
                          .clkb (clkb),
                          .rst_n_b (rst_n_b),
                          .toggle_out (toggle_out)
                           );


endmodule//mgm_sync_pa2tb
