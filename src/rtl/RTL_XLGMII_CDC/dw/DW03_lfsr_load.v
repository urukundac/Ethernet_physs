module DW03_lfsr_load
  (data, load, cen, clk, reset, count);

  parameter width = 8 ;
  input [width-1 : 0] data;
  input load, cen, clk, reset;
  output [width-1 : 0] count;

  reg right_xor, shift_right;
  reg [width-1 : 0] q, d, de, datax;
  wire [width-1 : 0] p;

  function [width-1 : 0] shr;
    input [width-1 : 0] a;
    input msb;
    reg [width-1 : 0] b;
    begin
      b = a >> 1;
      b[width-1] = msb;
      shr = b;
    end
  endfunction

  assign count = q;

generate
   if (width == 1) begin: case_is_1
        assign p = 1'b1;
        end
   else if ((width == 2) |
            (width == 3) |
            (width == 4) |
            (width == 6) |
            (width == 7) |
            (width == 15) |
            (width == 22)) begin: case_is_2
        assign p = 'b011;
        end
   else if ((width == 5) |
            (width == 11) |
            (width == 21) |
            (width == 29) |
            (width == 35)) begin: case_is_5
        assign p = 'b0101;
        end
   else if ((width == 10) |
            (width == 17) |
            (width == 20) |
            (width == 25) |
            (width == 28) |
            (width == 31) |
            (width == 41)) begin: case_is_10
        assign p = 'b01001;
        end
    else if ((width == 9) |
             (width == 39)) begin: case_is_9
        assign p = 'b010001;
        end
    else if ((width == 23) |
             (width == 47)) begin: case_is_23
        assign p = 'b0100001;
        end
    else if (width == 18) begin: case_is_18
        assign p = 'b010000001;
        end
    else if (width == 49) begin: case_is_49
        assign p = 'b01000000001;
        end
    else if (width == 36) begin: case_is_36
        assign p = 'b0100000000001;
        end
    else if (width == 33) begin: case_is_33
        assign p = 'b010000000000001;
        end
    else if ((width == 8) |
             (width == 38) |
             (width == 43)) begin: case_is_8
        assign p = 'b01100011;
        end
    else if (width == 12) begin: case_is_12
        assign p = 'b010011001;
        end
    else if ((width == 13) |
             (width == 45)) begin: case_is_13
        assign p = 'b011011;
        end
    else if (width == 14) begin: case_is_14
        assign p = 'b01100000000011;
        end
    else if (width == 16) begin: case_is_16
        assign p = 'b0101101;
        end
    else if (width == 19) begin: case_is_19
        assign p = 'b01100011;
        end
    else if (width == 24) begin: case_is_24
        assign p = 'b011011;
        end
    else if ((width == 26) |
             (width == 27)) begin: case_is_26
        assign p = 'b0110000011;
        end
    else if (width == 30) begin: case_is_30
        assign p = 'b011000000000000011;
        end
    else if ((width == 32) |
             (width == 48)) begin: case_is_32
        assign p = 'b011000000000000000000000000011;
        end
    else if (width == 34) begin: case_is_34
        assign p = 'b01100000000000011;
        end
    else if (width == 37) begin: case_is_37
        assign p = 'b01010000000101;
        end
    else if (width == 40) begin: case_is_40
        assign p = 'b01010000000000000000101;
        end
    else if (width == 42) begin: case_is_42
        assign p = 'b0110000000000000000000011;
        end
    else if ((width == 44) |
             (width == 50)) begin: case_is_44
        assign p = 'b01100000000000000000000000011;
        end
    // assume width is 46
    // else if (width == 46) begin: case_is_46
    else begin: case_is_46
        assign p = 'b01100000000000000000011;
        end

    endgenerate

  always @ (*) begin: proc_shr
      right_xor = (width == 1) ? ~ q[0] : ^ (q & p);
      shift_right = ~ right_xor;
      end

  always @(load or cen or shift_right or q or data) begin
      datax = data ^ shr(q,shift_right);
      de = load ? shr(q,shift_right) : datax;
      d = cen ? de : q;
      end

  always @(posedge clk or negedge reset) begin
      if (~reset) begin
          q <= 0;
          end
      else begin
          q <= d;
          end
      end

endmodule
