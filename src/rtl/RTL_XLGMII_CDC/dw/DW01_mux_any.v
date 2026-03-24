module DW01_mux_any #(
    parameter A_width    = 8,
    parameter SEL_width  = 2,
    parameter MUX_width  = 2 )
( A,
  SEL,
  MUX
);

input    [A_width-1:0] A;
input  [SEL_width-1:0] SEL;
output [MUX_width-1:0] MUX;


       function [MUX_width-1:0] DWF_mux;
	  input [A_width-1:0] a;
	  input [SEL_width-1:0] sel;

	  integer 		i,j;
	  reg [MUX_width-1:0] 	mux;
	  begin
	     for(i = 0;i < MUX_width;i = i+1) begin
		j = sel*MUX_width + i;
		if(j > A_width-1)
		   mux[i] = 1'b0;
		else
		   mux[i] = a[j];
	     end
	     DWF_mux = mux;
	  end
       endfunction

   assign  MUX[MUX_width-1:0] = DWF_mux(A,SEL);


endmodule
