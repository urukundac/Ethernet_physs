module IOBUF_w_pullup (
IO,
T,
I,
O);

input  I;
output O;
inout IO;
input  T;

alt_iobuf #(.weak_pull_up_resistor("on")) u_alt_iobuf (

       .i  (I),
       .oe (!T),
       .io (IO),
       .o  (O));

//     generic(
//         io_standard           : string  := "NONE";
//         current_strength      : string  := "NONE";
//         current_strength_new  : string  := "NONE";
//         slew_rate             : integer := -1;
//         slow_slew_rate        : string  := "NONE";
//         location              : string  := "NONE";
//         enable_bus_hold       : string  := "NONE";
//         weak_pull_up_resistor : string  := "ON";
//         termination           : string  := "NONE";
//         input_termination     : string  := "NONE";
//         output_termination    : string  := "NONE";
//         lpm_type              : string := "alt_iobuf" );

endmodule 
