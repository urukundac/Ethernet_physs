module IOBUF (
IO,
T,
I,
O);

input  I;
output O;
inout IO;
input  T;

assign IO = T ? I : 1'bz;
assign O = IO;
//alt_iobuf #(.weak_pull_up_resistor("on")) u_alt_iobuf (
//
//       .i  (I),
//       .oe (!T),
//       .io (IO),
//       .o  (O));

endmodule 
