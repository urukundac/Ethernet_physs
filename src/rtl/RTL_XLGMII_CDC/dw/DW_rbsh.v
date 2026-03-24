module DW_rbsh #(

   parameter A_width  = 8,
   parameter SH_width = 3
)(
A, SH, SH_TC, B);


   // port list declaration in order
   input [ A_width- 1: 0] A;
   input [ SH_width- 1: 0] SH;
   input SH_TC;
   
   output [ A_width- 1: 0] B;
   
      
   assign B = ((SH_TC === 1'b0) | (SH[SH_width-1] === 1'b0)) ? DWF_rbsh_uns(A, SH) :
              DWF_rbsh_tc(A,SH);
   
   
function[A_width-1:0] DWF_rbsh_uns;

  input [A_width-1:0] A;
  input [SH_width-1:0] SH;
  reg   [SH_width-1:0] SHMIN;
  begin 

    SHMIN = SH;                                          // compute minimum rotat distance
    while (SHMIN > A_width) SHMIN = SHMIN-A_width;
    DWF_rbsh_uns = (($unsigned(A) >> SHMIN) | ($unsigned(A) << (A_width-SHMIN)));
     
  end
endfunction

function[A_width-1:0] DWF_rbsh_tc;
   
   input [A_width-1:0] A;
   input [SH_width-1:0] SH;
   reg   [SH_width-1:0] SHMIN;
   reg [SH_width : 0] sh_abs;
   reg [A_width-1 : 0] 	data_out;
   
   begin 
      
      sh_abs = SH[SH_width-1] ? (~{SH[SH_width-1],SH})+1 : {SH[SH_width-1],SH};
      SHMIN = sh_abs;                                     // compute minimum rotat distance
      while (SHMIN > A_width) SHMIN = SHMIN-A_width;
      if(SH[SH_width-1] == 1'b0)           
         data_out = ($unsigned(A) >> SHMIN) | ($unsigned(A) << (A_width-SHMIN));
      else  
        data_out = ($unsigned(A) << SHMIN) | ($unsigned(A) >> (A_width-SHMIN));
      
      DWF_rbsh_tc = data_out; 
    
   end
endfunction

endmodule // DW_rbsh

