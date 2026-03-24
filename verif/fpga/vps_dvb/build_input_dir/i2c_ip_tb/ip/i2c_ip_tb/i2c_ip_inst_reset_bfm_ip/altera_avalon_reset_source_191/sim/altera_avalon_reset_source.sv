// (C) 2001-2024 Intel Corporation. All rights reserved.
// Your use of Intel Corporation's design tools, logic functions and other 
// software and tools, and its AMPP partner logic functions, and any output 
// files from any of the foregoing (including device programming or simulation 
// files), and any associated documentation or information are expressly subject 
// to the terms and conditions of the Intel Program License Subscription 
// Agreement, Intel FPGA IP License Agreement, or other applicable 
// license agreement, including, without limitation, that your use is for the 
// sole purpose of programming logic devices manufactured by Intel and sold by 
// Intel or its authorized distributors.  Please refer to the applicable 
// agreement for further details.


// $File: //acds/rel/24.1/ip/iconnect/verification/altera_avalon_reset_source/altera_avalon_reset_source.sv $
// $Revision: #1 $
// $Date: 2024/02/01 $
// $Author: psgswbuild $
//------------------------------------------------------------------------------
// Reset generator

`timescale 1ps / 1ps

module altera_avalon_reset_source (
				   clk,
				   reset
				   );
   input  clk;
   output reset;

   parameter ASSERT_HIGH_RESET = 1;    // reset assertion level is high by default
   parameter INITIAL_RESET_CYCLES = 0; // deassert after number of clk cycles
   
// synthesis translate_off
   import verbosity_pkg::*;
   
   logic reset    = ASSERT_HIGH_RESET ? 1'b0 : 1'b1; 
  
   string message = "*uninitialized*";

   int 	  clk_ctr = 0;
   
   always @(posedge clk) begin
      clk_ctr <= clk_ctr + 1;
   end

   always @(*) 
     if (clk_ctr == INITIAL_RESET_CYCLES)
       reset_deassert();

   
   function automatic void __hello();
      $sformat(message, "%m: - Hello from altera_reset_source");
      print(VERBOSITY_INFO, message);            
      $sformat(message, "%m: -   $Revision: #1 $");
      print(VERBOSITY_INFO, message);            
      $sformat(message, "%m: -   $Date: 2024/02/01 $");
      print(VERBOSITY_INFO, message);
      $sformat(message, "%m: -   ASSERT_HIGH_RESET = %0d", ASSERT_HIGH_RESET);      
      print(VERBOSITY_INFO, message);
      $sformat(message, "%m: -   INITIAL_RESET_CYCLES = %0d", INITIAL_RESET_CYCLES);      
      print(VERBOSITY_INFO, message);      
      print_divider(VERBOSITY_INFO);      
   endfunction

   function automatic string get_version();  // public
      // Return BFM version as a string of three integers separated by periods.
      // For example, version 9.1 sp1 is encoded as "9.1.1".      
      string ret_version = "19.1";
      return ret_version;
   endfunction
   
   task automatic reset_assert();  // public
      $sformat(message, "%m: Reset asserted");
      print(VERBOSITY_INFO, message);       
     
      if (ASSERT_HIGH_RESET > 0) begin
	 reset = 1'b1;
      end else begin
	 reset = 1'b0;
      end
   endtask

   task automatic reset_deassert();  // public
      $sformat(message, "%m: Reset deasserted");
      print(VERBOSITY_INFO, message);       
      
      if (ASSERT_HIGH_RESET > 0) begin      
	 reset = 1'b0;
      end else begin
	 reset = 1'b1;
      end
   endtask
   
   initial begin
      __hello();
      if (INITIAL_RESET_CYCLES > 0) 
	reset_assert();
   end
// synthesis translate_on

endmodule

`ifdef QUESTA_INTEL_OEM
`pragma questa_oem_00 "iTdrjeNt7hn/aDHNKrrwYoB9DZnCnTPjecrJN48xw9lhjpn1u34R0vCDT+o9bTyF5Gq0u7itNCAVeM9bS1CWmsZz51JVethfusBe9ViPq6vv2nbHvSkUhC/w2J6qAWaiBcY5RvsE4lEgMkk8r9/FVduNwT68+xR8jBRQmAYBlYSYAVmorIRzx/yt1Q+JTcvWYb8KLu7SjDPE60v/jpBIGqLUcxZ6ToNBk7yV0fVl527O+MyjIIkrxrm+JGQwWRlniTr4GCkO8I5/nR5e5CRR+JE+z+iz+HdyrZdlnjdniH4YqDTFcWEi8f3nwzG4N2l90gcjw43xZXIGRgu0KDGImQ4n91TecnDWoObnnakFrAHGGERtWATVB95eEfvt8R/J/KGQGBJcJsQBCc6Z27XniBsPERKiOpL7gzQsz50OCdClvwMqDFEMOtFLH3DYdPSLRuCzNJ9NW8iwOJ0p/AsLtb/Hm4gCowvnyMPDUDe1Pq7pAegzK5J7LzaefxEZsdd3qSDVVMKMnU1rPrCwZhPM6FNLO5QDJL0ztlKZaT2BYi4soL+oIH/ioMW6N0NxwR4I6+xUBTPCdJ5saHjX4gm9PWD9sq9TZe5LibLn3oL34pomgNA8TtonumIcLdoDx8TbzQLKTEWCbCr57CtYSOdkexyEK1P7GtDB450z1ROCdj07TX6XQvrn+55TXznFm5wt9aH+VLipXHuUeTd64OgARg5Q6Ik8JYQnENxPKFa+vDYAouvAQYpBY2ieXBpeNBQjdA7mr9mF1rXbd35z70y6cez5OXKGpS4Xwpx2mIs3/Oh+XPVqp8C/nV66movwr0sla5YgVuN1dxqZqkH8CbYFTuQCjj53iSXg/LuYZiyWbz1Tyq9N0mfX5TMR0hpvlmFbBBOyp6jeKvm2D5RkvIER17+UIm6vid78WqRlkQqPIcspm9vWEAtwnudHRkvkFaVqRGwGdSFR4bDJV4nOnjJqjW8zAGTCMwUEKBwC5DQMTzCrcjhJOw2fQhskGtiIJsQZ"
`endif