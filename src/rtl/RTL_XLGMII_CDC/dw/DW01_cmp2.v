module DW01_cmp2
  (A, B, LEQ, TC, LT_LE, GE_GT);

  parameter width = 8; 

  input [width-1:0] A;
  input [width-1:0] B;
  input             LEQ; // 1 => LEQ/GT 0=> LT/GEQ
  input             TC; // 1 => 2's complement numbers
   
  output            LT_LE;
  output            GE_GT;

function is_less;
      parameter sign = width - 1;
      input [width-1:0] A;
      input [width-1:0] B;
      input             TC; //Flag of Signed
      reg   a_is_0;
      reg   b_is_1;
      reg   result;
      integer   i;
      begin
         if (TC == 1'b0) begin  // unsigned numbers
            result = 0;
            for (i = 0; i <= sign; i = i + 1) begin
               a_is_0 = A[i] == 1'b0;
               b_is_1 = B[i] == 1'b1;
               result = (a_is_0 & b_is_1) |
                        (a_is_0 & result) |
                        (b_is_1 & result);
            end
         end
         else begin  // signed numbers
            if (A[sign] !== B[sign]) begin
               result = A[sign] == 1'b1;
            end 
            else begin
               result = 0;
               for (i = 0; i <= sign-1; i = i + 1) begin
                  a_is_0 = (A[i] == 1'b0);
                  b_is_1 = (B[i] == 1'b1);
                  result = (a_is_0 & b_is_1) |
                           (a_is_0 & result) |
                           (b_is_1 & result);
               end
            end
         end
         is_less = result;
      end
endfunction
   
  assign GE_GT = (LEQ == 1'b1) ? ((is_less(A,B,TC) || A == B) ? 1'b0 : 1'b1) :
                 ((is_less(B,A,TC) || A == B) ? 1'b1 : 1'b0);
   
  assign LT_LE = (LEQ == 1'b1) ? ((is_less(A,B,TC) || A == B) ? 1'b1 : 1'b0) :
                 ((is_less(B,A,TC) || A == B) ? 1'b0 : 1'b1); 
   
endmodule
