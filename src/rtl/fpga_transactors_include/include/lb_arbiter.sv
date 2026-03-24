module lb_arbiter(
  input 	wire     		  lb_clk,
  input   wire          lb_rst_n,
  input 	wire          lb_write,
  input 	wire 		   	  lb_read,
  input 	wire [23:0] 	lb_addr,
  input 	wire [63:0] 	lb_tx_data,  
  input 	wire [7:0] 		lb_tx_be, 
  output 	wire 			    lb_rx_data_valid,  
  output 	wire [63:0] 	lb_rx_data, 
  output 	wire 			    lb_wait,
  input   wire 				  lb_eof,


  output 	wire          f2f_lb_write,
  output 	wire 		   	  f2f_lb_read,
  output 	wire [23:0] 	f2f_lb_addr,
  output 	wire [63:0] 	f2f_lb_tx_data,  
  output 	wire [7:0] 		f2f_lb_tx_be, 
  input 	wire 			    f2f_lb_rx_data_valid,  
  input 	wire [63:0] 	f2f_lb_rx_data, 
  input 	wire 			    f2f_lb_wait, 
  output wire 				  f2f_lb_eof,

  output 	wire          f2f_confg_lb_write,
  output 	wire 		   	  f2f_confg_lb_read,
  output 	wire [23:0] 	f2f_confg_lb_addr,
  output 	wire [63:0] 	f2f_confg_lb_tx_data,  
  output 	wire [7:0] 		f2f_confg_lb_tx_be, 
  input 	wire 			    f2f_confg_lb_rx_data_valid,  
  input 	wire [63:0] 	f2f_confg_lb_rx_data, 
  input 	wire 			    f2f_confg_lb_wait, 
  output wire 				  f2f_confg_lb_eof                 

);

wire cs;

assign cs                   = (lb_addr[23]==1'b1) ? 1'b1 : 1'b0;

assign f2f_lb_addr          = lb_addr;
assign f2f_confg_lb_addr    = lb_addr;

assign f2f_lb_tx_data       = lb_tx_data;
assign f2f_confg_lb_tx_data = lb_tx_data;

assign f2f_lb_tx_be         = lb_tx_be;      
assign f2f_confg_lb_tx_be   = lb_tx_be;

assign f2f_lb_eof           = (cs == 1'b1) ? lb_eof : 'b0;
assign f2f_confg_lb_eof     = (cs == 1'b0) ? lb_eof : 'b0;

assign f2f_lb_write         = (cs == 1'b1) ? lb_write : 'b0;
assign f2f_confg_lb_write   = (cs == 1'b0) ? lb_write : 'b0;

assign f2f_lb_read          = (cs == 1'b1) ? lb_read : 'b0;
assign f2f_confg_lb_read    = (cs == 1'b0) ? lb_read : 'b0;

assign lb_rx_data_valid     = f2f_lb_rx_data_valid || f2f_confg_lb_rx_data_valid;
assign lb_wait              = f2f_lb_wait || f2f_confg_lb_wait;
assign lb_rx_data           = (f2f_lb_rx_data_valid == 1'b1) ? f2f_lb_rx_data : f2f_confg_lb_rx_data;


endmodule 
