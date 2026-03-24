module DW_div (a, b, quotient, remainder, divide_by_0);

  parameter a_width  = 8;
  parameter b_width  = 8;
  parameter tc_mode  = 0;
  parameter rem_mode = 1;

  input  [a_width-1:0] a;
  input  [b_width-1:0] b;
  output [a_width-1:0] quotient;
  output [b_width-1:0] remainder;
  output                  divide_by_0;
  
  wire [a_width-1:0] a;
  wire [b_width-1:0] b;
  reg  [a_width-1:0] quotient;
  reg  [b_width-1:0] remainder;
  reg                     divide_by_0;

  function [a_width-1:0] DWF_div_uns;
    // Function to compute the unsigned quotient
    
    input [a_width-1:0] A;
    input [b_width-1:0] B;

    reg [a_width-1:0] QUOTIENT_v;

    `define DW_DIV_max_uns {a_width{1'b1}}

    begin
        if (B == 0) begin
          QUOTIENT_v = `DW_DIV_max_uns;
        end
        else begin
          QUOTIENT_v = A/B;
        end
      DWF_div_uns = QUOTIENT_v;
    end
  endfunction

  
  function [a_width-1:0] DWF_div_tc;
    // Function to compute the signed quotient
    
    input [a_width-1:0] A;
    input [b_width-1:0] B;

    reg [a_width-1:0] A_v;
    reg [b_width-1:0] B_v;
    reg [a_width-1:0] QUOTIENT_v;

    `define DW_DIV_min_sgn {1'b1, {a_width{1'b0}}}
    `define DW_DIV_max_sgn {1'b0, {a_width{1'b1}}}

    begin
        if (B == 0) begin
          if (A[a_width-1] == 1'b0)
            QUOTIENT_v = `DW_DIV_max_sgn >> 1;
          else
            QUOTIENT_v = `DW_DIV_min_sgn >> 1;
        end
        else begin
          if (A[a_width-1] == 1'b1) A_v = ~A + 1'b1;
          else A_v = A;
          if (B[b_width-1] == 1'b1) B_v = ~B + 1'b1;
          else B_v = B;
          QUOTIENT_v = A_v/B_v;
          if (A[a_width-1] != B[b_width-1])
            QUOTIENT_v = ~QUOTIENT_v + 1'b1;
        end
      DWF_div_tc = QUOTIENT_v;
    end
  endfunction

  
  function [b_width-1:0] DWF_rem_uns;
    // Function to compute the unsigned remainder
    
    input [a_width-1:0] A;
    input [b_width-1:0] B;

    reg [b_width-1:0] REMAINDER_v;

    begin
        if (B == 0) begin
          REMAINDER_v = A;
        end
        else begin
          REMAINDER_v = A % B;
        end
      DWF_rem_uns = REMAINDER_v;
    end
  endfunction

  
  function [b_width-1:0] DWF_rem_tc;
    // Function to compute the signed remainder
    
    input [a_width-1:0] A;
    input [b_width-1:0] B;

    reg [a_width-1:0] A_v;
    reg [b_width-1:0] B_v;
    reg [b_width-1:0] REMAINDER_v;

    `define DW_DIV_1_ones ({(b_width % a_width)+1{1'b1}})

    begin
        if (B == 0) begin
          if ((b_width > a_width) && (A[a_width-1] == 1'b1))
            REMAINDER_v = {`DW_DIV_1_ones, A};
          else
            REMAINDER_v = A;
        end
        else begin
          if (A[a_width-1] == 1'b1) A_v = ~A + 1'b1;
          else A_v = A;
          if (B[b_width-1] == 1'b1) B_v = ~B + 1'b1;
          else B_v = B;
          REMAINDER_v = A_v % B_v;
          if (A[a_width-1] == 1'b1)
            REMAINDER_v = ~REMAINDER_v + 1'b1;
        end
      DWF_rem_tc = REMAINDER_v;
    end
  endfunction

  
  function [b_width-1:0] DWF_mod_uns;
    // Function to compute the unsigned modulus
    
    input [a_width-1:0] A;
    input [b_width-1:0] B;

    reg [b_width-1:0] MODULUS_v;

    begin
        if (B == 0) begin
          MODULUS_v = A;
        end
        else begin
          MODULUS_v = A % B;
        end
      DWF_mod_uns = MODULUS_v;
    end
  endfunction

  
  function [b_width-1:0] DWF_mod_tc;
    // Function to compute the signed modulus
    
    input [a_width-1:0] A;
    input [b_width-1:0] B;

    reg [a_width-1:0] A_v;
    reg [b_width-1:0] B_v;
    reg [b_width-1:0] REMAINDER_v;
    reg [b_width-1:0] MODULUS_v;

    `define DW_DIV_2_ones ({(b_width % a_width)+1{1'b1}})

    begin
        if (B == 0) begin
          if ((b_width > a_width) && (A[a_width-1] == 1'b1))
            MODULUS_v = {`DW_DIV_2_ones, A};
          else
            MODULUS_v = A;
        end
        else begin
          if (A[a_width-1] == 1'b1) A_v = ~A + 1'b1;
          else A_v = A;
          if (B[b_width-1] == 1'b1) B_v = ~B + 1'b1;
          else B_v = B;
          REMAINDER_v = A_v % B_v;
          if (REMAINDER_v == {b_width{1'b0}})
            MODULUS_v = REMAINDER_v;
          else begin
            if (A[a_width-1] == 1'b0)
              MODULUS_v = REMAINDER_v;
            else
              MODULUS_v = ~REMAINDER_v + 1'b1;
            if (A[a_width-1] != B[b_width-1])
              MODULUS_v = B + MODULUS_v;
          end
        end
      DWF_mod_tc = MODULUS_v;
    end
  endfunction

  always @(a or b) begin
    if (tc_mode == 0) begin
      quotient = DWF_div_uns (a, b);
      if (rem_mode == 1)
        remainder = DWF_rem_uns (a, b);
      else
        remainder = DWF_mod_uns (a, b);
    end
    else begin
      quotient = DWF_div_tc (a, b);
      if (rem_mode == 1)
        remainder = DWF_rem_tc (a, b);
      else
        remainder = DWF_mod_tc (a, b);
    end
    if (b == {b_width{1'b0}})
      divide_by_0 = 1'b1;
    else
      divide_by_0 = 1'b0;
  end 

endmodule
