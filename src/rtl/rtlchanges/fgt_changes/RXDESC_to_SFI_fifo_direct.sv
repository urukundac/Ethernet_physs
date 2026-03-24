//
// Module RXDESC_to_SFI_fifo_direct
//
// Created:
//          by - Ehud Cohn
//          at - 20/5/25 
//
//


`timescale 1ns/10ps
module RXDESC_to_SFI_fifo_direct #(
		parameter HPARITY 	= 1,  //supported values: 0, 1
		parameter D 		= 64  //supported values: 64, 128

                    )( 
   // Port Declarations
   
   //Transactor CLK and Reset wires:
	input  	wire    				SFI_clk, 
	input 	wire    				SFI_rst_n, 
  
   //Generic chassis CLK and Reset wires:
   
	input   wire            		generic_chassis_clk, 
	input   wire            		generic_chassis_rst,
   
   //DESC Interface
   
	output  wire            		rx_ack,
	output  wire            		rx_ws,
	output  wire            		rx_abort, 

	input 	wire            		rx_req,
	input 	wire [135:0] 			rx_desc,
	input 	wire            		rx_dfr,
	input 	wire            		rx_dv,
	input 	wire [7:0] 				rx_be ,
	input 	wire [63:0] 			rx_data,  
   
   //the signals that connect to the FIFO's within the SFI xtor
	input   wire [3:0]          	direct_rd_rx_fifo,
	output 	wire [3:0]  [127:0] 	direct_dout_rx_fifo,
	output	wire [3:0]          	direct_empty_rx_fifo

);


// Internal signal declarations
	wire			rd_cmd_fifo;			
	wire	[127:0]	dout_cmd_fifo;		
	wire			empty_cmd_fifo;		
			
	wire			rd_data_fifo;		
	wire	[63:0]	dout_data_fifo;
	wire			empty_data_fifo;
	
	wire           	rd_length_fifo;
    wire 	[9:0] 	dout_length_fifo;
    wire           	empty_length_fifo;
    
    wire           	rd_type_and_length_fifo;
    wire 	[16:0] 	dout_type_and_length_fifo;
    wire           	empty_type_and_length_fifo;


    RXDESC_to_fifo_ctrl 
		RXDESC_to_fifo_ctrl_inst
( 
	.FGC_clk 					(generic_chassis_clk), 
	.FGC_rst_n 					(~generic_chassis_rst), 
	
	.xtor_clk 					(SFI_clk), 
	.xtor_rst_n 				(SFI_rst_n),
	  
	   //RX DESC
	.rx_ack						(rx_ack),
	.rx_ws						(rx_ws),
	.rx_abort					(rx_abort), 

	.rx_req						(rx_req),
	.rx_desc					(rx_desc),
	.rx_dfr						(rx_dfr),
	.rx_dv						(rx_dv),
	.rx_be 						(rx_be),
	.rx_data					(rx_data),  
	
   //the signals that connect between the FIFO's within RXDESC_to_fifo_ctrl and rxdesc_to_sfi_fifo_converter
 
	.rd_cmd_fifo				(rd_cmd_fifo),
	.dout_cmd_fifo				(dout_cmd_fifo),
	.empty_cmd_fifo				(empty_cmd_fifo),
			
	.rd_data_fifo				(rd_data_fifo),
	.dout_data_fifo				(dout_data_fifo),
	.empty_data_fifo			(empty_data_fifo),
	
	.rd_length_fifo				(rd_length_fifo),
	.dout_length_fifo			(dout_length_fifo),
	.empty_length_fifo			(empty_length_fifo),
			
	.rd_type_and_length_fifo	(rd_type_and_length_fifo),
	.dout_type_and_length_fifo	(dout_type_and_length_fifo),
	.empty_type_and_length_fifo	(empty_type_and_length_fifo) 
	
);

 rxdesc_to_sfi_fifo_converter #(  
                          .HPARITY 	(HPARITY),
                          .D		(D)                         
                         )
		rxdesc_to_sfi_fifo_converter_inst
( 
	.clk 						(SFI_clk), 
	.rst_n 						(SFI_rst_n),
	  
	//the signals that connect between rxdesc_to_sfi_fifo_converter and the FIFO's within SFI xtor
	.rd_rx_fifo					(direct_rd_rx_fifo),
	.dout_rx_fifo				(direct_dout_rx_fifo),
	.empty_rx_fifo				(direct_empty_rx_fifo),
		
   //the signals that connect between the FIFO's within RXDESC_to_fifo_ctrl and rxdesc_to_sfi_converter
 
	.rd_cmd_fifo				(rd_cmd_fifo),
	.dout_cmd_fifo				(dout_cmd_fifo),
	.empty_cmd_fifo				(empty_cmd_fifo),
			
	.rd_data_fifo				(rd_data_fifo),
	.dout_data_fifo				(dout_data_fifo),
	.empty_data_fifo			(empty_data_fifo),
	
	.rd_length_fifo				(rd_length_fifo),
	.dout_length_fifo			(dout_length_fifo),
	.empty_length_fifo			(empty_length_fifo),
			
	.rd_type_and_length_fifo	(rd_type_and_length_fifo),
	.dout_type_and_length_fifo	(dout_type_and_length_fifo),
	.empty_type_and_length_fifo	(empty_type_and_length_fifo)  
 
);
	

endmodule 

