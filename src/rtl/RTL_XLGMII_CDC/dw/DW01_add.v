module DW01_add #(
        parameter width = 5 )
( A,
  B,
  CI,
  SUM,
  CO );

input  [width-1:0] A;
input  [width-1:0] B;
input              CI;
output [width-1:0] SUM;
output             CO;


    wire [width:0] sum_total;
    assign sum_total = {1'b0,A} +
                       {1'b0,B} +
                       {{width{1'b0}},CI};
    assign CO  = sum_total[width];
    assign SUM = sum_total[(width-1):0];

endmodule
