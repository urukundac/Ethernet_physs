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


// Clocked priority encoder with state
//
// On each clock cycle, updates state to show which request is granted.
// Most recent grant holder is always the highest priority.
// If current grant holder is not making a request, while others are, 
// then new grant holder is always the requester with lowest bit number.
// If no requests, current grant holder retains grant state

// $Header$

`timescale 1 ns / 1 ns
//altera message_off 16753
module alt_xcvr_arbiter #(
	parameter width = 2
) (
	input  wire clock,
	input  wire [width-1:0] req,	// req[n] requests for this cycle
	output reg  [width-1:0] grant	// grant[n] means requester n is grantee in this cycle
);

	wire idle;	// idle when no requests
	wire [width-1:0] keep;	// keep[n] means requester n is requesting, and already has the grant
							// Note: current grantee is always highest priority for next grant
	wire [width-1:0] take;	// take[n] means requester n is requesting, and there are no higher-priority requests

	assign keep = req & grant;	// current grantee is always highest priority for next grant
	assign idle = ~| req;		// idle when no requests

	initial begin
		grant = 0;
	end

	// grant next state depends on current grant and take priority
	always @(posedge clock) begin
		grant <= 
// synthesis translate_off
                    (grant === {width{1'bx}})? {width{1'b0}} :
// synthesis translate_on
				keep				// if current grantee is requesting, gets to keep grant
				 | ({width{idle}} & grant)	// if no requests, grant state remains unchanged
				 | take;			// take applies only if current grantee is not requesting
	end

	// 'take' bus encodes priority.  Request with lowest bit number wins when current grantee not requesting
	assign take[0] = req[0]
					 & (~| (keep & ({width{1'b1}} << 1)));	// no 'keep' from lower-priority inputs
	genvar i;
	generate
	for (i=1; i < width; i = i + 1) begin : arb
		assign take[i] = req[i]
						 & (~| (keep & ({width{1'b1}} << (i+1))))	// no 'keep' from lower-priority inputs
						 & (~| (req & {i{1'b1}}));	// no 'req' from higher-priority inputs
	end
	endgenerate
endmodule
`ifdef QUESTA_INTEL_OEM
`pragma questa_oem_00 "wiTMQclvpkBeX0dIXfyzJjZQ+WXKuVhJb/bdd+lnR5UH/TPpbBm5jW+MAV668sOlRW6aUOBhDsTBXOcReH1VDqlLgeOFikp1tVFLKec0KZRImrt08HNk7mN9sgJ7V9jbBPhVQswaMBfnkb4qA5ojPJ2229mxbkMIkw4J2CRk5+rV/wVE5kR3y9taYGwJMWBLso51HtSxTbmqw3MSMqkq9m9FySE5tOszuAaZkJShIMpxzHwKt+TyVP/zm4NblxrzZibbFGwHgHidZ6gs+8W0lFNkuNlI5vyhObAtDldPFTmd+PzIox+0uilyB0ujQq5spFjLKKQ/g05m5exJiqZLZWb/QfkXiX150y0vgAkvXMB4k2orehD7N04zMiSks8UqQFpkzxVjI7nYIgx4/Y9OVeZExt374FniQsxcTm7il1hezIXDVlhpyayNmWWMWC69obeauSd35z7be+tqa3DzxoH5NdzFFPdxdBFzBqk5c2ZU3UQCRR9nGFs9+pmRFnqmyvIrU2pTF4f7YNEUR3kHkokiR6fryTt8DqeBZ2kK/f10nfIY0PZ3iNr95AUWclkX9oFLXun9Xv8FYa2Tq1E/opKCVFWGZvrqQ9BL/IKHEyzbyUEvms6ZnkLDwGIWJOPnux5nHeNIq8VvXEotiN3komlVHaDdqi4hdtx0/TskyULfL8CFa+dqnznq0EaTmVg4E/4VVB7SHf3VgdWJci349dF4IIiiH9JZyqyRU5R383gm3TNyD3q+61LDhQ0DlkkVQDgZr0t3jRX0waMVL8loE5ZDr79zbTSbmGEVv367FRGdpMQ9rvlD6r++8oVkHfKlkqYBI8pENizYwGt/e9rzZ7UmudItolPkQl62OtJa3Qo/rSo73AnY4otLahkJZjnHHGDwmINVaS0uSK+l5cq/lMJS9UNv5G0aEwJqwOL5g6ebTTfBW/oD2fpUM/MhdKgzcKvnc5+b3NMrQPqNK3WtTTOXwPqymAOPGXGGeIsmOonM9wnEiwuVqiIQgFW4+rId"
`endif