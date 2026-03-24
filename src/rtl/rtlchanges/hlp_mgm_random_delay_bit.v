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
//    FILENAME          : mgm_random_delay_bit.v
//    DESIGNER          : Amnon Israel
//    DATE              : 16/02/16
//    REVISION NUMBER   : 1.0
//    DESCRIPTION       :
//
//          This module will delay input signal with random delay that is distributed randomly between 0 and window size
//
//---------------------------------------------------------------------------//
// --------------------------------------------------------------------------//
//      LAST MODIFICATION:      11/06/17
//      RECENT AUTHORS:         avi.costo@intel.com
//      PREVIOUS RELEASES:      
//                              16/02/16: First version.
// --------------------------------------------------------------------------//
`timescale 100ps/100ps

module hlp_mgm_random_delay_bit
  (
   input        logic   [31:0]  window  ,
   input        logic           din     ,
   output       logic           din_delayed
   );
 

`ifdef EMULATION
  `define NO_RANDOM
`elsif HLP_FEV_APPROVE_SIM_ONLY
  `define NO_RANDOM
`elsif INTEL_SIMONLY
`else
  `define NO_RANDOM
`endif
 
`ifndef  NO_RANDOM
  reg       din_d;
  reg [7:0] delay;
  integer   seed, window_int;
  
  always @(*)
	begin
      window_int = window;
	  seed = $random();
      if (!$isunknown(window_int))
	    delay = $dist_uniform(seed,0,window_int);
      else
        delay = 0;
      
	  #delay  din_d = din;
	end

  assign  din_delayed = din_d;
  `else // 
  assign  din_delayed = din  ;

`endif    // 


endmodule//mgm_random_delay_bit
