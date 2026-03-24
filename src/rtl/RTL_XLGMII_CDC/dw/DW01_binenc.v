module DW01_binenc #(
  parameter A_width = 8,
  parameter ADDR_width = 3
)(A, ADDR);

  // port list declaration in order 
  input [A_width-1:0] A;
   
  output [ADDR_width-1:0] ADDR;

  
  assign ADDR = DWF_binenc(A);

function[ADDR_width-1:0] DWF_binenc;
  
    input [A_width-1:0] A;
    reg [ADDR_width-1:0] temp;
    integer flag,i;
  begin
    temp = -1;
    flag = 0;
    for (i=0;  (!flag) && i<=A_width-1; i=i+1) begin
      if (A[i] === 1'b1) begin
	 flag = 1;
         temp = i;
      end
    end
    DWF_binenc = temp;
  end
endfunction

endmodule
