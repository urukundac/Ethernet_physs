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
//    FILENAME          : mgm_random_delay.v
//    DESIGNER          : Amnon Israel
//    DATE              : 16/02/16
//    REVISION NUMBER   : 1.0
//    DESCRIPTION       :
//
//          This module was created in order to simulate timing of real signals in silicon. It can be used on any bus to simulate different routing delays for each bit in the bus.
//          It is most effective to use it on buses (single bits) that are crossing clock domains. when using it it can catch asynchronous bugs that whould have missed in "regular" logic simulations.
//          
//          How It works
//          ------------
//          This module calculate an effective window that will limit the maximum propagation delay of thew bus. The module will randomize delay smaller than the window.
//          The window is derived from the sampling clock, and from the input signal. The fastest transition between the two will determine the window
//         
//          Known Limitations
//          -----------------
//          Since in most cases the receiving synchronizer don't have the source clock, clk input will be connected to the destination clock.
//          In case that the input signal is derived from a faster clock than the destination clock, but the input signal doesn't change every cycle of the source clock, the effective window will be bigger than
//          the source clock. In this case, if the input signal will than change cycle after cycle, at this first change (only), bits may have propegation delay bigger than the source clock. In case of gray code 
//          syncronization this may cause simulation false error.
//          If one would like to prevent such cases in 100% he must connect the source clock (and not destination) to the sample_clock_period.  
//
//---------------------------------------------------------------------------//
// --------------------------------------------------------------------------//
//      LAST MODIFICATION:      16/02/16
//      RECENT AUTHORS:         yevgeny.yankilevich@intel.com
//      PREVIOUS RELEASES:      
//                              16/02/16: First version.
// --------------------------------------------------------------------------//
`timescale 100ps/100ps

module hlp_mgm_random_delay
  #(parameter 
        BUS_WIDTH = 1'h1)
        (
         input logic                                         clk,
         input logic[BUS_WIDTH-1:0]          din,           
         output logic [BUS_WIDTH-1:0]         din_delayed    
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
  integer       i, seed;
  real          t1,t2;
  real          s1,s2; 
  integer       input_clock_period;
  integer       sample_clock_period;
  integer       window;
`endif // 

  wire [BUS_WIDTH-1:0] din_d;

`ifndef NO_RANDOM
 
  initial
    begin
      t1 = 0;
      t2 = 0;
      s1 = 0;
      s2 = 0;
          window = 40;
          input_clock_period = 200;
          sample_clock_period = 200;
        end

  always 
        begin
      @(posedge clk);
      s1 = $realtime;
      
      @(posedge clk);
      s2 = $realtime;

          sample_clock_period = s2-s1;
        end // always begin

  always 
        begin
      @(din);
      t1 = $realtime;
       
      @(din);
      t2 = $realtime;

          input_clock_period = t2-t1;
        end // always begin


  always @(*)
        begin
          if (((sample_clock_period < window) | (input_clock_period < window)) & (sample_clock_period != 0) & (input_clock_period != 0))
                window = (input_clock_period < sample_clock_period) ? input_clock_period : sample_clock_period;
        end

  hlp_mgm_random_delay_bit u_random_delay_bit[BUS_WIDTH-1:0] (.window (window/2), .din (din), .din_delayed (din_d));
  
  assign din_delayed = ($test$plusargs("SYNC_NO_DELAY")) ? din : din_d;
  `else 
     assign din_delayed = din;
`endif 
 
endmodule//mgm_random_delay 
