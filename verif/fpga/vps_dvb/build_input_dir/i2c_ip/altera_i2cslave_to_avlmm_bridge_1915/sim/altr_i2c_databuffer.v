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


//
// Parameterizable width data buffer
// Meant to be used for THR & RB
// Conceptually a 1-deep FIFO
//
`timescale 1 ps / 1 ps
module altr_i2c_databuffer #(
   parameter DSIZE = 8
) (
   input  clk,
   input  rst_n,
   input  s_rst,  //Sync Reset - when Mode is disabled
   input  put,
   input  get,
   output reg empty,
   input  [DSIZE-1:0] wdata,
   output reg [DSIZE-1:0] rdata
);

//BUFFER storage
always @(posedge clk or negedge rst_n) begin
  if (!rst_n) begin
	  rdata <= {DSIZE{1'b0}};
  end
  else if (put) begin
	  rdata <= wdata; 
  end
end

//EMPTY Indicator
always @(posedge clk or negedge rst_n) begin
   if (!rst_n)
      empty <= 1;
   else begin
      empty <= s_rst ? 1 :
               put   ? 0 :
               get   ? 1 :
               empty;
   end
   
end

endmodule
`ifdef QUESTA_INTEL_OEM
`pragma questa_oem_00 "GdrtC8041f37ha52Ko+Jde808iDyKA+ht5m5AuKQCsm3cRPQscDvF+wBgbawWOxUtCRI9a/tnC6AChwO+BxfmEV2UK9ncMFAL//YMEMfhylNbbg+DkYNRltJ3oLac/x0CKLYUz0kP213IDPHPJdDrn2XWjqkg2d8WjL/DUsL13IJgiL6ltB1LI/UYnSBUYY+yK6OwicfHT3EuyorZ8lWql/zzL2Fl1behLT6A47M1qhHlV/UgRuheN8CyMnaNSp+g65u67cpwP4NRCwYhgDw8ALppcX8Yj/Cv/6E3BFxxq3nLmSwWyBDbN3gx5gme5kiI4eiP6+JKrn7SsA7FKo4KAU6cW6q/Saz3RFClx+gEuAddWiwWOd4SIiCs+dT4Gw3yWEbow/SwTD/PgyUBNIXwaG76ju58L9auZE7ri55JRJSdRzDoEbKfxw9/veILPHubGWSKpl2gZmVXgRe4vfGjWK7fkLAMFcc3z5AQ+hC5Qnznk/nb7sof0CfHf/ekvVsTGn1DQdmXWtKLtyRM8kEWQdSiFI1OP6jQEvwQyyGxgdgLiWgHuKvB+Jt+zu+Y6YOxEWf+4b44WiyD6twGmfEkZDyBP/pPbwBBy0cM1L0G+kVQLbTcffr1RRnL/eL52/5QiN8wtwkOkfQMlUbmU2cWmLotEnwxFeew5UIk1lJrZq1ZGMTgkGIqaFHCH6JO/lh7+3eF6YdrA3FM0XKG2kCH+rHdGap1TWBkZmAPm/JSUWpvhPBQjTLToHzMJArVQ4fDHlorbCc9PwgMQmVfRMdAVTL/q2hcuZol65dtJdvnUmR1+HQ7qlNdZbLo5TLOjTeSlvEXL8UvPBG6y/XmgEg1oQVavMuhVq2NYBZaTpzEO1IZLpHOEaKyYqQOPxOlrB/GODdwlseEviNjJ/AjHvgMrUmW0m9QKWUdfHUs3fVtq1qjEyBs40yCqF0kJwQX01pzy6v59luXvg7Fh+9rqsKonDemQg+5wR3JdSKGUjfYmzuLbB2IY2/2DRkKB07TKyW"
`endif