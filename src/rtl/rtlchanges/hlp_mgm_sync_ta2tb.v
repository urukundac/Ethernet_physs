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
//    FILENAME          : mgm_master_1rw_shell.v
//    DESIGNER          : Omri Afek
//    DATE              : 16/02/16
//    REVISION NUMBER   : 1.0
//    DESCRIPTION       :
//
//          The module sync. signal from domain A to domain B
//
//---------------------------------------------------------------------------//
// --------------------------------------------------------------------------//
//      LAST MODIFICATION:      16/02/16
//      RECENT AUTHORS:         yevgeny.yankilevich@intel.com
//      PREVIOUS RELEASES:      
//                              16/02/16: First version.
// --------------------------------------------------------------------------//
module hlp_mgm_sync_ta2tb #(

        parameter                       BUS_WIDTH       = 1                     ,
        parameter       [BUS_WIDTH-1:0] RST_VALUE       = {BUS_WIDTH{1'b0}}     ,
        parameter                       SYN_SEED        = 1                     , 
        parameter                       SYN_RND_ENABLE  = 1                     , 
        parameter                       SYN_MS_DELAY    = 1000

)(

        input   logic   [BUS_WIDTH-1:0] toggle_in       ,
        input   logic                   clkb            ,
        input   logic                   rst_n_b         ,
        output  logic   [BUS_WIDTH-1:0] toggle_out      

); 
   


  wire [BUS_WIDTH-1:0]          out;

  wire [BUS_WIDTH-1:0]          in =  RST_VALUE ^ toggle_in;
  assign                        toggle_out = RST_VALUE ^ out;
  wire [BUS_WIDTH-1:0]          in_1;
  
//  `ifdef HLP_RTL
  `ifdef  INTEL_SIMONLY  
`ifndef EMULATION

  //`ifdef HLP_FPGA_ALL
  //assign in_1 = in;
  //`else

  wire [BUS_WIDTH-1:0]          in_random_delayed;

  hlp_mgm_random_delay #(.BUS_WIDTH  (BUS_WIDTH))
  u_random_delay
    (
     // Outputs
     .din_delayed       (in_random_delayed),
     // Inputs
     .clk               (clkb),             
     .din               (in));
  
  assign in_1 = (SYN_RND_ENABLE) ? in_random_delayed : in;
  //`endif

`else //!`ifndef EMULATION

  assign in_1 = in;
  
`endif // EMULATION
 `else // !`ifdef INTEL_SIMONLY

  assign in_1 = in;
 `endif   // !`ifdef INTEL_SIMONLY



  hlp_mgm_sync_cell u_sync_cell [BUS_WIDTH-1:0] (
                                                                           .clk    (clkb),
                                                                           .d      (in_1),
                                                                           .rst_b  (rst_n_b),
                                                                           .out    (out));


endmodule//mgm_sync_ta2tb
