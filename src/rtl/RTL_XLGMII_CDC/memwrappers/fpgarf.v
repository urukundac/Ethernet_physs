module fpgarf #(parameter ADDR_WD = 4,
                 parameter DATA_WD = 8
                 )
       (
input ckwr,
input wr,
input [ADDR_WD-1 :0] wrptr,
input [DATA_WD-1 :0] datain,
input rd,
input [ADDR_WD-1 :0] rdptr,
output [DATA_WD-1:0] dataout
);


reg [DATA_WD-1:0] ram[0:(2**ADDR_WD)-1]/*synthesis syn_ramstyle="MLAB"*/;
reg [ADDR_WD-1 :0] rdptr_int;


always @(posedge ckwr ) begin
  if ( wr )
    ram[wrptr] <= datain;
end

assign dataout = ram[rdptr];

endmodule
