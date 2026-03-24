//
// Module SFI_fifo_to_TXDESC_direct
//
// Created:
//          by - Ehud Cohn
//          at - 20/5/25 
//
//


`timescale 1ns/10ps
module SFI_fifo_to_TXDESC_direct #(
		parameter D = 64  //supported values: 64, 128
                    )( 
   // Port Declarations
   
   //Transactor CLK and Reset wires:
	input  	wire    				SFI_clk, 
	input 	wire    				SFI_rst_n, 
  
   //Generic chassis CLK and Reset wires:
   
	input   wire            		generic_chassis_clk, 
	input   wire            		generic_chassis_rst,
   
   //DESC Interface
      
	output	wire [127:0] 			tx_cmd_desc,
	output	wire [63:0]  			tx_data_desc,
	output	wire       				tx_req,
	output	wire       				tx_dfr,
	input	wire 					tx_ack,
	input	wire 					tx_ws, 
	output	wire       				tx_req_arbiter,
	input	wire 					tx_ack_arbiter,
      
   //the signals that connect to the FIFO's within the SFI xtor
	input 	wire   [3:0]          	direct_wr_tx_fifo,
	input 	wire   [3:0]  [127:0] 	direct_din_tx_fifo,
	output  wire   [3:0]          	direct_full_tx_fifo
   
   );


// Internal signal declarations
	wire			wr_cmd_fifo;			
	wire	[127:0]	din_cmd_fifo;		
	wire			full_cmd_fifo;		
			
	wire			wr_data_fifo;		
	wire	[63:0]	din_data_fifo;
	wire			full_data_fifo;


    fifo_to_TXDESC_ctrl 
		fifo_to_TXDESC_ctrl_inst
( 
	.FGC_clk 					(generic_chassis_clk), 
	.FGC_rst_n 					(~generic_chassis_rst), 
	
	.xtor_clk 					(SFI_clk), 
	.xtor_rst_n 				(SFI_rst_n),
	  
	   //TX DESC
	   
	.tx_cmd_desc				(tx_cmd_desc),
	.tx_data_desc				(tx_data_desc),
	.tx_req						(tx_req),
	.tx_dfr						(tx_dfr),
	.tx_ack						(tx_ack),
	.tx_ws						(tx_ws), 
	.tx_req_arbiter				(tx_req_arbiter),
	.tx_ack_arbiter				(tx_ack_arbiter),
	
	
   //the signals that connect between the FIFO's within fifo_to_TXDESC_ctrl and sfi_fifo_to_txdesc_converter
 
	.wr_cmd_fifo				(wr_cmd_fifo),
	.din_cmd_fifo				(din_cmd_fifo),
	.full_cmd_fifo				(full_cmd_fifo),
			
	.wr_data_fifo				(wr_data_fifo),
	.din_data_fifo				(din_data_fifo),
	.full_data_fifo				(full_data_fifo) 
		
);

 sfi_fifo_to_txdesc_converter # (
				.D (D)
          )    
		sfi_fifo_to_txdesc_converter_inst
( 
	.clk 						(SFI_clk), 
	.rst_n 						(SFI_rst_n),
	  
	//the signals that connect between rxdesc_to_sfi_converter and the FIFO's within SFI xtor
	.wr_tx_fifo			(direct_wr_tx_fifo),
	.din_tx_fifo			(direct_din_tx_fifo),
	.full_tx_fifo		(direct_full_tx_fifo),
		
   //the signals that connect between the FIFO's within fifo_to_TXDESC_ctrl and sfi_fifo_to_txdesc_converter
 
	.wr_cmd_fifo				(wr_cmd_fifo),
	.din_cmd_fifo				(din_cmd_fifo),
	.full_cmd_fifo				(full_cmd_fifo),
			
	.wr_data_fifo				(wr_data_fifo),
	.din_data_fifo				(din_data_fifo),
	.full_data_fifo				(full_data_fifo)  
 
);


endmodule 

