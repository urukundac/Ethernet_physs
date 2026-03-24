module generic_clk_div #(
   parameter integer DIVISOR = 2,
   parameter integer NUM_OUTPUTS = 1,
   parameter START_POLARITY = 1'b1

) (
   input    logic                   clkin,
   input    logic                   rst_n,
   output   logic [NUM_OUTPUTS-1:0] clkout
);


// Parameters
localparam COUNT_WIDTH = $clog2(DIVISOR) + 1;
localparam COUNT_RESET = (DIVISOR - 1);

localparam COUNT_NEGEDGE = (DIVISOR == 1) ? 1 : DIVISOR/2 - 1;


// registers
logic [COUNT_WIDTH-1:0]    count;
logic [NUM_OUTPUTS-1:0]    clkdiv;
logic                      first_edge;

`ifdef FPGA_FAST_SIM // new mode to accelerate slim sim
reg clkdiv_tmp;

longint period = (1000000*DIVISOR/9600)/2;


  initial begin
#1     clkdiv_tmp = 1;
    forever #(period) clkdiv_tmp = ~clkdiv_tmp;

  end
    assign clkdiv = clkdiv_tmp;


assign clkout = (DIVISOR == 1) ? {NUM_OUTPUTS{clkin}} : clkdiv;

`else // SYNTH and regular sim
// Divider
always_ff @(posedge clkin or negedge rst_n) begin
   if (rst_n == 1'b0) begin
      count       <= 'd0;
      clkdiv      <= 'd0;
      first_edge  <= 1'b1;
   end else begin

      if (first_edge == 1'b1) begin
         first_edge  <= 1'b0;
         count       <= 'd0;
         clkdiv      <= {NUM_OUTPUTS{START_POLARITY}};
      end else if (count == COUNT_RESET) begin
         count    <= 'd0;
         clkdiv   <= {NUM_OUTPUTS{1'b1}};
      end else begin
         count <= count + 'd1;
         if (count == COUNT_NEGEDGE) begin
            clkdiv <= 'd0;
         end
      end

   end
end


// Output assignment (accounting for div by 1)
assign clkout = (DIVISOR == 1) ? {NUM_OUTPUTS{clkin}} : clkdiv;
`endif


endmodule

