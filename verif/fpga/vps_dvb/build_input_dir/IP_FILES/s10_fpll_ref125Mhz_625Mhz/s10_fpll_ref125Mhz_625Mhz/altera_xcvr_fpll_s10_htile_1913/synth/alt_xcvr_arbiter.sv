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
`pragma questa_oem_00 "StGUMi07csum3+BxyW1k51h7do0MpYgWqpl8gtxl7X8kEAjZmAGcCd9azqHhCSGiVC9wj/8FcB6dKx6ZsBjoi0qIR8zPG5/FmKs79hHSSmUB2VCu59kznpUXIxlUYIoT2nQz7Yd8LM4jYgflmzhagEz6GL7Bo0pvwgqi1JcRZkwMiYTttcEVQ+pb57EJOfZ8yv4FWg9en8Iu7dx+qjkgartcEdjDTdHNrE5nqXqoikVOlZ/o9Gzo77/fVBucIwryIHwr+NTBV1sMVZNUTj1ujJrbFOrOaDojk9qHPskqa8orThxao6WUlAUBIW85u9pFuhrQ7dehb/F1xIh9oW9G5wH4hVoL2DQjbg7OoHpt0luGWiLO1K88JreqWWQjs6eoo7sWQsHrCNsKpdPfbI1ZUxuRE8SWFBpCv2Yliw9bALMsJSAYwWHg8tAW4BjWgjS+54T0Ow9DdGYj36o96/u0YKdY22++gHwxOlLpfRpzkE9EinjWtEyAjbiDWZWIkHkR7zwjEnCLUEKMn1R8SX2hp3v8S0D8didaObCjrvuggIMaqcm2IgC2YEvzJt39cRlXXwO4PvH5Lkgj4S48Q4xXq3McNpET48rfpNfIL2tbs1REdZ67goU4KgYrQo2A4FjotGztCUyDR8kHYLw4ABMgIsx5lIKuyMUNz0QwEjw6jFk58yS0YxEdq69S6WWf5d3XGeynaGtybqijQrZJlXGbGsiKL2bAcz/5t6DUTLXOS1CyoARcWRGzo5kGgGJ67nDtzVGv8lRt8utsVz1g5jKff4dFjp4EdZkIRv/++od6eGyEC8tcD1qZhZ/Fzh24+kgOMpOe3c5IXTkwxkGqjCYJcHLEIg0nLLWlaDb1E0VB/7vslDM75vJPgO5zvwSv+C4xBzSjeq6ym5EOwjDP9ZCFtDRSawKlKFNmXKLJCpVUKe2ZrepAHbHDrvb1jWJNpnQA2P2KSg1pIzeI8h6J5/f99K+QqmL0rBF4g9ZMBxo3viEGeG03XMZRbLDP7fdncelw"
`endif