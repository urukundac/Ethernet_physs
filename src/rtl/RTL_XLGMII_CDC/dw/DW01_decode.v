module DW01_decode #(
   parameter width = 3
)(
A,B);

   
   // port list declaration in order
   input [width-1:0] A;
   
   output [(1 << width)-1:0] B;

      assign B = DWF_decode(A);

function[(1<<width)-1:0] DWF_decode;

 input[width-1:0]A;
 
 //process decoding
 begin
  DWF_decode = (1 << A);
 end
endfunction 

endmodule //dw01_decode
