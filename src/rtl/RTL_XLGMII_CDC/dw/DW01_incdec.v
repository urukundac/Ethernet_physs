module DW01_incdec (A, INC_DEC, SUM );

   parameter width=4;
   
   input [ width-1 : 0] A; 
   input 		INC_DEC; 
   output [ width-1 : 0] SUM;
   
   assign SUM = INC_DEC ? A+{width{1'b1}} : A-{width{1'b1}};
    
endmodule
