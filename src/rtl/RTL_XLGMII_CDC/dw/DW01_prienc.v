module DW01_prienc #(
  parameter A_width = 8,
  parameter INDEX_width = 3
)(
A, INDEX);

  // port list declaration in order 
  input [A_width-1:0] A;
   
  output [INDEX_width-1:0] INDEX;
       
   assign INDEX = DWF_prienc(A);

function[INDEX_width-1:0] DWF_prienc;

  input [A_width-1:0] A;
  reg [INDEX_width-1:0] temp;
  reg flag;
  integer i;

  begin
    temp = 0;
    flag = 0;
    for (i=A_width-1; flag == 0 && i>=0; i=i-1) begin
      if (A[i] === 1'b1) begin
        flag = 1;
        temp = i+1;
      end
    end
    DWF_prienc = temp;
  end
endfunction

endmodule
