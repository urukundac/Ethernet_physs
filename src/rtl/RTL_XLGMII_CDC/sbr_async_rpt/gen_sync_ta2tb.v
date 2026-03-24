// The module sync. signal from domain A to domain B;

module gen_sync_ta2tb (toggle_in, clkb, rst_n_b, toggle_out); 

   parameter BUS_WIDTH = 1;
   parameter [BUS_WIDTH-1:0] RST_VALUE = {BUS_WIDTH{1'b0}};
   parameter SYN_SEED = 1; 
   parameter SYN_RND_ENABLE = 1; 
   
   parameter SYN_MS_DELAY = 1000; 


   input [BUS_WIDTH-1:0] toggle_in;
   input clkb;
   input rst_n_b;
   output [BUS_WIDTH-1:0] toggle_out;
   


  wire [BUS_WIDTH-1:0] 		out;

  wire [BUS_WIDTH-1:0] 		in =  RST_VALUE ^ toggle_in;
  wire [BUS_WIDTH-1:0] 		toggle_out = RST_VALUE ^ out;
  wire [BUS_WIDTH-1:0] 		in_1;
  

 `ifdef ECIP_RTL
  //`ifdef ECIP_FPGA_ALL
  //assign in_1 = in;
  //`else

  wire [BUS_WIDTH-1:0] 		in_random_delayed;

  gen_random_delay #(.BUS_WIDTH  (BUS_WIDTH))
  gen_random_delay
    (
     // Outputs
     .din_delayed	(in_random_delayed),
     // Inputs
     .clk               (clkb),             
     .din		(in));
  
  assign in_1 = (SYN_RND_ENABLE) ? in_random_delayed : in;
  //`endif

`else

  assign in_1 = in;
  
 `endif // !`ifdef RTL
  
  sync_cell sync_cell [BUS_WIDTH-1:0] (
									   .clk    (clkb),
									   .d      (in_1),
									   .rst_b  (rst_n_b),
									   .out    (out),
									   .si     (out),
									   .se     (1'b0));

  
  

endmodule 
