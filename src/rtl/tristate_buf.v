module tristate_buf (in, oe, out, pad);

    input   in, oe;
    output  out;
    inout     pad;

    //bufif1  b1(out, in, oe);
assign pad = oe? in : 1'bz;
assign out = pad ;

endmodule
