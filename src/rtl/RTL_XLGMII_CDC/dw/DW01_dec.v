module DW01_dec (A,SUM);

  parameter width=4;
   
  input   [ width-1: 0]     A;
  output  [ width-1: 0]     SUM;

   assign SUM = A+{width{1'b1}};
   
endmodule
