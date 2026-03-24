// this model only supports rst_mode = 0; stall_mode = 0; num_stages = 2
module DW_div_pipe (
    clk,
    rst_n,
    en,
    a,
    b,
    quotient,
    remainder,
    divide_by_0);
   
    parameter a_width     = 2;
    parameter b_width     = 2;
    parameter tc_mode     = 0;
    parameter rem_mode    = 1;
    parameter num_stages  = 2;
    parameter stall_mode  = 0;
    parameter rst_mode    = 0;
    parameter op_iso_mode = 0;
 
    input                clk;
    input                rst_n;
    input  [a_width-1:0] a;
    input  [b_width-1:0] b;
    input                en;
    
    output [a_width-1:0] quotient;
    output [b_width-1:0] remainder;
    output               divide_by_0;
   

    reg [a_width-1:0] a_Q;
    reg [b_width-1:0] b_Q;

    always @(posedge clk) begin: pipe_reg_PROC
        a_Q <= a;
        b_Q <= b;
        end


   DW_div #(a_width, b_width, tc_mode, rem_mode)
      U1 (.a               (a_Q),
          .b               (b_Q),
          .quotient        (quotient),
          .remainder       (remainder),
          .divide_by_0     (divide_by_0));
    
endmodule
