module DW01_addsub (A,B,CI,ADD_SUB,SUM,CO);

  parameter width = 4;

  // port list declaration in order
  input   [width-1 : 0]     A, B;
  input                     CI, ADD_SUB;
   
  output  [width-1 : 0]     SUM;
  output                    CO;
   
  wire [width : 0]      tmp_out;   

  assign tmp_out = ADD_SUB ? A-B-CI : A+B+CI;
  assign CO = tmp_out[width];
  assign SUM = tmp_out[width-1 : 0];
   
endmodule
