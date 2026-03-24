module DW_minmax (a ,tc ,min_max ,value ,index);

  parameter width = 8;
  parameter num_inputs = 2;

`define DW_n (num_inputs)
`define DW_ind_width ((`DW_n>4096)? ((`DW_n>262144)? ((`DW_n>2097152)? ((`DW_n>8388608)? 24 : ((`DW_n> 4194304)? 23 : 22)) : ((`DW_n>1048576)? 21 : ((`DW_n>524288)? 20 : 19))) : ((`DW_n>32768)? ((`DW_n>131072)?  18 : ((`DW_n>65536)? 17 : 16)) : ((`DW_n>16384)? 15 : ((`DW_n>8192)? 14 : 13)))) : ((`DW_n>64)? ((`DW_n>512)?  ((`DW_n>2048)? 12 : ((`DW_n>1024)? 11 : 10)) : ((`DW_n>256)? 9 : ((`DW_n>128)? 8 : 7))) : ((`DW_n>8)? ((`DW_n> 32)? 6 : ((`DW_n>16)? 5 : 4)) : ((`DW_n>4)? 3 : ((`DW_n>2)? 2 : 1)))))
   
  input [num_inputs*width-1 : 0] a;
  input tc;
  input min_max;
  output [width-1 : 0] value;
  output [`DW_ind_width-1 : 0] index;
   
  wire [num_inputs*width-1 : 0] a;
  wire tc;
  wire min_max;
  reg [width-1 : 0] value;
  reg [`DW_ind_width-1 : 0] index;


  task min_unsigned;
    input [num_inputs*width-1 : 0] a;
    output [width-1 : 0] value;
    output [`DW_ind_width-1 : 0] index;
    reg [width-1 : 0] a_v;
    reg [width-1 : 0] value_v;
    reg [`DW_ind_width-1 : 0] index_v;
    integer k;
    begin
	value_v = {width{1'b1}};
	index_v = {`DW_ind_width{1'b0}};
	for (k = 0; k < num_inputs; k = k+1) begin 
	  a_v = a[width-1 : 0];
	  a = a >> width;
	  if (a_v < value_v) begin 
	    value_v = a_v;
	    index_v = k;
	  end 
	end
	value = value_v;
	index = index_v;
    end
  endtask

  task min_signed;
    input [num_inputs*width-1 : 0] a;
    output [width-1 : 0] value;
    output [`DW_ind_width-1 : 0] index;
    reg [width-1 : 0] a_v;
    reg [width-1 : 0] value_v;
    reg [`DW_ind_width-1 : 0] index_v;
    integer k;
    begin
	value_v = {width{1'b1}};
	index_v = {`DW_ind_width{1'b0}};
	for (k = 0; k < num_inputs; k = k+1) begin 
	  a_v = a[width-1 : 0];
	  a_v[width-1] = ! a[width-1];
	  a = a >> width;
	  if (a_v < value_v) begin 
	    value_v = a_v;
	    index_v = k;
	  end 
	end
	value_v[width-1] = ! value_v[width-1];
	value = value_v;
	index = index_v;
    end
  endtask

  task max_unsigned;
    input [num_inputs*width-1 : 0] a;
    output [width-1 : 0] value;
    output [`DW_ind_width-1 : 0] index;
    reg [width-1 : 0] a_v;
    reg [width-1 : 0] value_v;
    reg [`DW_ind_width-1 : 0] index_v;
    integer k;
    begin
	value_v = {width{1'b0}};
	index_v = {`DW_ind_width{1'b0}};
	for (k = 0; k < num_inputs; k = k+1) begin 
	  a_v = a[width-1 : 0];
	  a = a >> width;
	  if (a_v >= value_v) begin 
	    value_v = a_v;
	    index_v = k;
	  end 
	end
	value = value_v;
	index = index_v;
    end
  endtask

  task max_signed;
    input [num_inputs*width-1 : 0] a;
    output [width-1 : 0] value;
    output [`DW_ind_width-1 : 0] index;
    reg [width-1 : 0] a_v;
    reg [width-1 : 0] value_v;
    reg [`DW_ind_width-1 : 0] index_v;
    integer k;
    begin
	value_v = {width{1'b0}};
	index_v = {`DW_ind_width{1'b0}};
	for (k = 0; k < num_inputs; k = k+1) begin 
	  a_v = a[width-1 : 0];
	  a_v[width-1] = ! a[width-1];
	  a = a >> width;
	  if (a_v >= value_v) begin 
	    value_v = a_v;
	    index_v = k;
	  end 
	end
	value_v[width-1] = ! value_v[width-1];
	value = value_v;
	index = index_v;
    end
  endtask

 
  always @(a or tc or min_max)
    begin
      if (tc == 1'b0) begin 
	if (min_max == 1'b0) begin 
	  min_unsigned (a, value, index);
	end
	else begin 
	  max_unsigned (a, value, index);
	end
      end 
      else begin
	if (min_max == 1'b0) begin 
	  min_signed (a, value, index);
	end
	else begin
	  max_signed (a, value, index);
	end
      end
    end 
`undef DW_DW_n
`undef DW_ind_width

endmodule
