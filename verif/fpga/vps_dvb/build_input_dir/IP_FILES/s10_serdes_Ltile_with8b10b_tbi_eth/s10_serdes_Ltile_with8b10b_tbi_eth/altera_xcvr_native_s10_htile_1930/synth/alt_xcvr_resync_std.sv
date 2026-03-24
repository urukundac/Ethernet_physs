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


// Module: alt_xcvr_resync_std
//
// Description:
//  A general purpose resynchronization module that uses the recommended altera_std_synchronizer 
//  and altera_std_synchronizer_nocut synchronizer
//  
//  Parameters:
//    SYNC_CHAIN_LENGTH
//      - Specifies the length of the synchronizer chain for metastability
//        retiming.
//    WIDTH
//      - Specifies the number of bits you want to synchronize. Controls the width of the
//        d and q ports.
//    SLOW_CLOCK - USE WITH CAUTION. 
//      - Leaving this setting at its default will create a standard resynch circuit that
//        merely passes the input data through a chain of flip-flops. This setting assumes
//        that the input data has a pulse width longer than one clock cycle sufficient to
//        satisfy setup and hold requirements on at least one clock edge.
//      - By setting this to 1 (USE CAUTION) you are creating an asynchronous
//        circuit that will capture the input data regardless of the pulse width and 
//        its relationship to the clock. However it is more difficult to apply static
//        timing constraints as it ties the data input to the clock input of the flop.
//        This implementation assumes the data rate is slow enough
//    INIT_VALUE
//      - Specifies the initial values of the synchronization registers.
//	  NO_CUT
//		- Specifies whether to apply embedded false path timing constraint. 
//		  0: Apply the constraint 1: Not applying the constraint
//

`timescale 1ps/1ps 

module alt_xcvr_resync_std #(
    parameter SYNC_CHAIN_LENGTH = 2,  // Number of flip-flops for retiming. Must be >1
    parameter WIDTH             = 1,  // Number of bits to resync
    parameter SLOW_CLOCK        = 0,  // See description above
    parameter INIT_VALUE        = 0,
    parameter NO_CUT		= 1	  // See description above
  ) (
  input   wire              clk,
  input   wire              reset,
  input   wire  [WIDTH-1:0] d,
  output  wire  [WIDTH-1:0] q
  );

localparam  INT_LEN       = (SYNC_CHAIN_LENGTH > 1) ? SYNC_CHAIN_LENGTH : 2;
localparam  L_INIT_VALUE  = (INIT_VALUE == 1) ? 1'b1 : 1'b0;

genvar ig;

// Generate a synchronizer chain for each bit
generate for(ig=0;ig<WIDTH;ig=ig+1) begin : resync_chains
	wire                d_in;   // Input to sychronization chain.
	wire				sync_d_in;
	wire		        sync_q_out;
	
	// Adding inverter to the input of first sync register and output of the last sync register to implement power-up high for INIT_VALUE=1
	assign sync_d_in = (INIT_VALUE == 1) ? ~d_in : d_in;
	assign q[ig] = (INIT_VALUE == 1)  ? ~sync_q_out : sync_q_out;
	
	if (NO_CUT == 0) begin		
		altera_std_synchronizer #(
			.depth(INT_LEN)				
		) synchronizer (
			.clk		(clk),
			.reset_n	(~reset),
			.din		(sync_d_in),
			.dout		(sync_q_out)
		);
		
		//synthesis translate_off			
		initial begin
			synchronizer.dreg = {(INT_LEN-1){1'b0}};
			synchronizer.din_s1 = 1'b0;
		end
		//synthesis translate_on
				
	end else begin
		altera_std_synchronizer_nocut #(
			.depth(INT_LEN)				
		) synchronizer_nocut (
			.clk		(clk),
			.reset_n	(~reset),
			.din		(sync_d_in),
			.dout		(sync_q_out)
		);
				
		//synthesis translate_off
		initial begin
			synchronizer_nocut.dreg = {(INT_LEN-1){1'b0}};
			synchronizer_nocut.din_s1 = 1'b0;
		end
		//synthesis translate_on	
	end
	
    // Generate asynchronous capture circuit if specified.
    if(SLOW_CLOCK == 0) begin
      assign  d_in = d[ig];
    end else begin
      wire  d_clk;
      reg   d_r = L_INIT_VALUE;
      wire  clr_n;

      assign  d_clk = d[ig];
      assign  d_in  = d_r;
      assign  clr_n = ~q[ig] | d_clk; // Clear when output is logic 1 and input is logic 0

      // Asynchronously latch the input signal.
      always @(posedge d_clk or negedge clr_n)
        if(!clr_n)      d_r <= 1'b0;
        else if(d_clk)  d_r <= 1'b1;
    end // SLOW_CLOCK
  end // for loop
endgenerate

endmodule
`ifdef QUESTA_INTEL_OEM
`pragma questa_oem_00 "A7gcksxmS5gG6Zv4HK4Yv59hk2voL2uzeMa6Hm3vc4Hq6WnudvJal2T6aPWc5qTkcY9Q1ziLJRE/ik1macGjS/hbMt2B5sgqBKSOAIFoYHgmMIP2fXAGSAU+Mb43TwMSEvZZ/w6ZPlaVcLZDEujMGeh2+GX4Xp67kDOL/nNlwtmehLWG5TvirU3eok0v1NW74xqZAaRIB/Xeel0kdRGA9dufXQ4smXEJnEndBLG6GlZFxjoZvSOFaZVhriZvymVaIOBQgic3JatL158lETBPPqXVH219RtNbx4H4FzTTKeOP9Jq+/wQkJKDPBJXOQWchWnKPO8eMYdBrOFDt8xMQMHtLh9bYLBrT3WiuX3ix2mZB8IU/+3W1sK5Io2Nn39TLuHo+Lts4IRgdwmMgKN/oVraWpl6POS5u1Ft6WH0FR3K1p2Sndf7L8GkYkvfiw5rV3RDAJc20hHqIBdMB7a7iYgE/BWdGwxLEPwRLwLojw9eIQi2LcAT0Uu6AEbxuCIAB2plyfTC+2zKY5kBbOzrJoT8wxh7htvT/dq49wTCsFFj8MF2WN2KeyGNAV7PThGAwDt//3wJsJWb8i7wHHkXpqe0S/AkkPW+sagj0g+d8oHhA8ElPLI5DAgw3Gw1dGOHjOvhixb5Mhgvz+ikIi0qcr14bd6W44S54zrykXohjxqWX9vyIylT5SNtUm21Zx7zLq1u/gpjb+QsuKwyQGs5bUO1OXf/NE3u/WgF2temOjX21dDA3XXlVuLGLtsQp9ZrE8y7tqqwFglgm+AmVI14uqIYQIoCSsEDKk+CzFnF2mzMHEy+k75dkGCBLEJ+wpPKEg5xotw754cCeRI9i+d1awIgeU4BC08ZphK+/AfJyhGkkIib1+ofyV+FYkncwkCcUeUoSosSh3Nb1oMLAW6yiMmfdBw5oEwYaak395liMqUdi+yuyhTs8jBl4xxj0swPMaUwiGljGZABiDdShlnUKN1+UUHU9ybk3vfhe6W5QaqSyGxSCAGlXM5V8EjvHsKnN"
`endif