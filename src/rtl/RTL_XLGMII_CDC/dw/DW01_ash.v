module DW01_ash(A, DATA_TC, SH, SH_TC, B);
  parameter A_width=4;
  parameter SH_width=2;

  input [A_width-1:0] A;
  input [SH_width-1:0] SH;
  input DATA_TC, SH_TC;
   
  output [A_width-1:0] B;

function[A_width-1:0] DWF_ash_uns_uns;
 
  input [A_width-1:0] A;
  input [SH_width-1:0] SH;

  begin 
     
    DWF_ash_uns_uns = A << SH;
     
  end
endfunction

function[A_width-1:0] DWF_ash_tc_uns;
   
   input [A_width-1:0] A;
   input [SH_width-1:0] SH;
   
   begin 
      
      DWF_ash_tc_uns = A << SH; 
    
   end
endfunction

function[A_width-1:0] DWF_ash_uns_tc;
   
   input [A_width-1:0] A;
   input [SH_width-1:0] SH;
   
   begin
      
      DWF_ash_uns_tc = (SH[SH_width-1] == 1'b0) ? A << SH :
		       A >> (-SH);
      
   end
endfunction

function[A_width-1:0] DWF_ash_tc_tc;
   
   input [A_width-1:0] A;
   input [SH_width-1:0] SH;
   integer 		i;
   reg [A_width-1:0] 	data_out;
   reg [SH_width-1:0] 	sh_abs;
   reg 			data_sign;
   
   begin
      
      DWF_ash_tc_tc = signed_shift(A, SH);
      
   end
endfunction

function [A_width-1 : 0] signed_shift;
   input [A_width-1 : 0] a;
   input [SH_width-1 : 0] sh;
   
   reg [A_width-1 : 0] 	  a_out;
   reg 			  sign;
   reg [SH_width-1 : 0]   sh_abs;
   reg [A_width-1 : 0] 	  data_out;
   integer 		  i;
   
   begin
      if(sh[SH_width-1] == 1'b0)           
	 data_out = a << sh;
      else begin  
	 sign = a[A_width-1];
	 sh_abs = sh[SH_width-1] ? (~sh)+1 : sh;
	 a_out = a >> sh_abs;
	 for (i = 0; i < A_width; i = i+1) begin
	    if ((i > A_width-sh_abs-1)||(sh_abs >= A_width))
	       data_out[i] = sign;
	    else
	       data_out[i] = a_out[i];
	 end // for (i = 0; i < A_width; i = i+1)
      end 
      signed_shift = data_out;
      
   end
endfunction // signed_shift

function[A_width-1:0] DW_ash_uns_uns;
 
  input [A_width-1:0] A;
  input [SH_width-1:0] SH;
 
  begin
    DW_ash_uns_uns = DWF_ash_uns_uns(A,SH);
  end
endfunction

function[A_width-1:0] DW_ash_tc_uns;
 
  input [A_width-1:0] A;
  input [SH_width-1:0] SH;
 
  begin
    DW_ash_tc_uns = DWF_ash_tc_uns(A,SH);
  end
endfunction
 
function[A_width-1:0] DW_ash_uns_tc;
 
  input [A_width-1:0] A;
  input [SH_width-1:0] SH;
 
  begin
    DW_ash_uns_tc = DWF_ash_uns_tc(A,SH);
  end
endfunction
 
function[A_width-1:0] DW_ash_tc_tc;

  input [A_width-1:0] A;
  input [SH_width-1:0] SH;
 
  begin
    DW_ash_tc_tc = DWF_ash_tc_tc(A,SH);   
  end
endfunction
 

   assign B = ((SH_TC == 1'b0) | (SH[SH_width-1] == 1'b0) ) ? DWF_ash_uns_uns(A, SH) :
              ((SH_TC == 1'b1) & (DATA_TC == 1'b0) ) ? DWF_ash_uns_tc(A,SH) :
              DWF_ash_tc_tc(A,SH);

endmodule
