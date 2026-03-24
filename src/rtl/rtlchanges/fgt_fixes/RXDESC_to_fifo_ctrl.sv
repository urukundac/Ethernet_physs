//
// Module RXDESC_to_fifo_ctrl
//
// Created:
//          by - Ehud Cohn
//          at - 20/5/25 
//
//


`timescale 1ns/10ps
module RXDESC_to_fifo_ctrl ( 
   // Port Declarations
   
   //Generic chassis CLK and Reset wires:
   
	input   wire            		FGC_clk, 
	input   wire            		FGC_rst_n,
	
	 //Transactor CLK and Reset wires:
	input  	wire    				xtor_clk, 
	input 	wire    				xtor_rst_n, 
  
   //DESC Interface
   
	output  wire            		rx_ack,
	output  wire            		rx_ws,
	output  wire            		rx_eof, 

	input 	wire            		rx_req,
	input 	wire [135:0] 			rx_desc,
	input 	wire            		rx_dfr,
	input 	wire            		rx_dv,
	input 	wire [7:0] 				rx_be ,
	input 	wire [63:0] 			rx_data,  
   
   //the signals that connect between the FIFO's within RXDESC_to_fifo_ctrl and rxdesc_to_sfi_converter
 
	input 	wire            		rd_cmd_fifo,				
	output 	wire [127:0] 			dout_cmd_fifo,				
	output  wire            		empty_cmd_fifo,				
			
	input 	wire            		rd_data_fifo,			
	output 	wire [63:0] 			dout_data_fifo,				
	output  wire            		empty_data_fifo,
	
	input	wire           			rd_length_fifo,
    output 	wire [9:0] 	  		  	dout_length_fifo,
    output	wire           			empty_length_fifo,
    
    input   wire           			rd_type_and_length_fifo,
    output 	wire [16:0] 			dout_type_and_length_fifo,
    output	wire           			empty_type_and_length_fifo

);


// Internal signal declarations
	wire			wr_cmd_fifo;			
	wire	[63:0]	din_cmd_fifo;		
	wire			full_cmd_fifo;		
			
	wire			wr_data_fifo;		
	wire	[63:0]	din_data_fifo;
	wire			full_data_fifo;

	wire 			tx_fifo_ws;
	wire			tx_fifo_wr;
	wire	[63:0]	tx_fifo_din;
	
	reg          	wr_length_fifo;
    reg 	[9:0] 	din_length_fifo;
    wire           	full_length_fifo;
    
    reg           	wr_type_and_length_fifo;
    reg 	[16:0] 	din_type_and_length_fifo;
    wire           	full_type_and_length_fifo;
    
    reg				half_flag;

rxdesc2fifo_sd2d_fgc rxdesc2fifo_sd2d_fgc_inst             
             (  .clk     			(FGC_clk),
                .rst     			(FGC_rst_n),
                .rx_req  			(rx_req),
				.rx_ack  			(rx_ack),
				.rx_dfr  			(rx_dfr),
				.rx_dv  			(rx_dv),     
				.rx_ws   			(rx_ws),
				.rx_data 			(rx_data),
				.rx_desc 			(rx_desc),
				.rx_be   			(rx_be),
                .rx_abort			(),  
                .tx_fifo_ws			(tx_fifo_ws),
                .tx_fifo_wr			(tx_fifo_wr),
                .tx_fifo_din		(tx_fifo_din),
                .wr_bar				(),
                .packet_length		(),
                .packet_length_wr	(),
                .end_of_transaction	(rx_eof)
            );  
 
 
 assign tx_fifo_ws 					= full_data_fifo | full_cmd_fifo | full_type_and_length_fifo | full_length_fifo;
 assign wr_cmd_fifo					= rxdesc2fifo_sd2d_fgc_inst.wr_cmd;
 assign wr_data_fifo 				= rxdesc2fifo_sd2d_fgc_inst.wr_data_64bit_aligned;	//TODO Ehud Cohn - need to understand the affect of the alignment on the data usage in the next phases of design
 assign din_data_fifo				= tx_fifo_din;
 assign din_cmd_fifo				= tx_fifo_din;

 
 
 always @ (posedge FGC_clk or negedge FGC_rst_n)
   begin
      if (!FGC_rst_n) begin 
			half_flag  					<= 1'b0;
			wr_length_fifo				<= 1'b0;
			wr_type_and_length_fifo		<= 1'b0;
			din_length_fifo				<= 10'h0;
			din_type_and_length_fifo	<= 17'h0;
	  end else begin 
	  if (wr_cmd_fifo & ~half_flag) begin
			half_flag  					<= ~half_flag;
			wr_length_fifo				<= din_data_fifo[62];
			wr_type_and_length_fifo		<= din_data_fifo[62];
			din_length_fifo				<= din_cmd_fifo[41:32];
			din_type_and_length_fifo	<= {din_cmd_fifo[62:56],din_cmd_fifo[41:32]};
	  end else if (wr_cmd_fifo & half_flag) begin
			half_flag  					<= ~half_flag;
			wr_length_fifo				<= 1'b0;
			wr_type_and_length_fifo		<= 1'b0;
			din_length_fifo				<= din_length_fifo;
			din_type_and_length_fifo	<= din_type_and_length_fifo;
	  end else begin
			half_flag  					<= half_flag;
			wr_length_fifo				<= 1'b0;
			wr_type_and_length_fifo		<= 1'b0;
			din_length_fifo				<= din_length_fifo;
			din_type_and_length_fifo	<= din_type_and_length_fifo;
	  end
	  end
	end
	
	

 generic_async_fifo # (      
             .WRITE_WIDTH (64),
             .READ_WIDTH  (64),
             .NUM_BITS    (512*64),
             .AFULL_THRESHOLD (500*64)//,

        
           ) fifo_64b_fwft_DS_DATA(
              

   .wr_clk        (FGC_clk),
   .wr_rst_n      (FGC_rst_n),
   .wr_en         (wr_data_fifo),
   .wr_data       (din_data_fifo),
   .wr_full       (),
   .wr_afull      (full_data_fifo),
   .wr_occupancy  (),
   .wr_overflow   (),
   .rd_clk        (xtor_clk),
   .rd_rst_n      (xtor_rst_n),
   .rd_en         (rd_data_fifo),
   .rd_data       (dout_data_fifo),
   .rd_empty      (empty_data_fifo),
   .rd_aempty     (),
   .rd_occupancy  (),
   .rd_underflow  ()
);


 generic_async_fifo # (      
             .WRITE_WIDTH (64),
             .READ_WIDTH  (128),
             .NUM_BITS    (512*64),
             .AFULL_THRESHOLD (500*64)//,

         )fifo_64_to_128_fwft_DS_CMD     (

   .wr_clk        (FGC_clk),
   .wr_rst_n      (FGC_rst_n),
   .wr_en         (wr_cmd_fifo),
   .wr_data       (din_cmd_fifo),
   .wr_full       (),
   .wr_afull      (full_cmd_fifo),
   .wr_occupancy  (),
   .wr_overflow   (),
   .rd_clk        (xtor_clk),
   .rd_rst_n      (xtor_rst_n),
   .rd_en         (rd_cmd_fifo),
   .rd_data       (dout_cmd_fifo),
   .rd_empty      (empty_cmd_fifo),
   .rd_aempty     (),
   .rd_occupancy  (),
   .rd_underflow  ()

);

generic_async_fifo # (      
             .WRITE_WIDTH (10),
             .READ_WIDTH  (10),
             .NUM_BITS    (128*10),
             .AFULL_THRESHOLD (120*10)//,

        
           ) fifo_64b_fwft_length(
              

   .wr_clk        (FGC_clk),
   .wr_rst_n      (FGC_rst_n),
   .wr_en         (wr_length_fifo),
   .wr_data       (din_length_fifo),
   .wr_full       (),
   .wr_afull      (full_length_fifo),
   .wr_occupancy  (),
   .wr_overflow   (),
   .rd_clk        (xtor_clk),
   .rd_rst_n      (xtor_rst_n),
   .rd_en         (rd_length_fifo),
   .rd_data       (dout_length_fifo),
   .rd_empty      (empty_length_fifo),
   .rd_aempty     (),
   .rd_occupancy  (),
   .rd_underflow  ()
);


generic_async_fifo # (      
             .WRITE_WIDTH (17),
             .READ_WIDTH  (17),
             .NUM_BITS    (512*17),
             .AFULL_THRESHOLD (500*17)//,

        
           ) fifo_64b_fwft_type_and_length(
              

   .wr_clk        (FGC_clk),
   .wr_rst_n      (FGC_rst_n),
   .wr_en         (wr_type_and_length_fifo),
   .wr_data       (din_type_and_length_fifo),
   .wr_full       (),
   .wr_afull      (full_type_and_length_fifo),
   .wr_occupancy  (),
   .wr_overflow   (),
   .rd_clk        (xtor_clk),
   .rd_rst_n      (xtor_rst_n),
   .rd_en         (rd_type_and_length_fifo),
   .rd_data       (dout_type_and_length_fifo),
   .rd_empty      (empty_type_and_length_fifo),
   .rd_aempty     (),
   .rd_occupancy  (),
   .rd_underflow  ()
);




endmodule 

