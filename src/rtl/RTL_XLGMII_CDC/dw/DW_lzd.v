module DW_lzd #(
  parameter a_width  = 8,
  parameter addr_width = (IW_logb2(a_width-1)+1)
) (
    a,
    dec,
    enc
);
`include "IW_logb2.svh"


  input  [a_width-1:0]    a;
  output [a_width-1:0]    dec;
  output [addr_width:0]   enc;

  assign dec = DWF_lzd(a);
  assign enc = DWF_lzd_enc(a);

function [addr_width:0] DWF_lzd_enc;

  input [a_width-1:0]  A;
  reg [addr_width:0]   temp;
  reg done;
  integer i;

  begin
    done = 0;
    temp = {addr_width+1{1'b1}};   // set default to all 1's assuming "A" is all zeros
    for (i=0; (done == 0) && (i < a_width); i=i+1) begin
      if (A[a_width-1-i] == 1'b1) begin
        temp = i;
        done = 1;  // when found first "1", then stop looking
      end // if
    end // for
  
    DWF_lzd_enc = temp;
  end
endfunction // DWF_lzd_enc


//-----------------------------------------------------------------------------------
//
// ABSTRACT:  Leading Zeroes Detector with decoded output
//
// MODIFIED: Doug Lee: Converted module to function 07/07/05
//--------------------------------------------------------------------------
function [a_width-1:0] DWF_lzd;

  input [a_width-1:0]  A;
  reg [addr_width:0]   temp_enc;
  reg [a_width-1:0]    temp_dec;

  begin
    temp_enc = DWF_lzd_enc(A);
    temp_dec = {a_width{1'b0}};

    if (temp_enc[addr_width] === 1'b0)
      temp_dec[(a_width-1) - temp_enc] = 1'b1;

    DWF_lzd = temp_dec;
  end
endfunction // DWF_lzd

endmodule
