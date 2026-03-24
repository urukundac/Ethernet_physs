module DW_lod #(
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

function [addr_width:0] DWF_lod_enc;

  input [a_width-1:0]  A;
  reg [addr_width:0] temp;
  reg done;
  integer i;

  begin
    done = 0;
    temp = {addr_width+1{1'b1}};
    for (i=0; (done == 0) && (i < a_width); i=i+1) begin
      if (A[a_width-1-i] == 1'b0) begin
	 temp = i;
	 done = 1;
      end
    end

    DWF_lod_enc = temp;
  end
endfunction

function [a_width-1:0] DWF_lod;

  input [a_width-1:0]  A;
  reg [addr_width:0]   temp_enc;
  reg [a_width-1:0]    temp_dec;

  begin
    temp_enc = DWF_lod_enc(A);
    temp_dec = {a_width{1'b0}};

    if (temp_enc[addr_width] == 1'b0)
      temp_dec[(a_width-1) - temp_enc] = 1'b1;

    DWF_lod = temp_dec;
  end
endfunction

  assign dec = DWF_lod(a);
  assign enc = DWF_lod_enc(a);

endmodule
