//
// Module SFI_Transactor_top
//
// Created:
//          by - Ehud Cohn
//          at - 20/1/23 (January)
//
//


`timescale 1ns/10ps
module SFI_Transactor_top #(
			parameter  	TRANSACTOR_TYPE 			= 0,
			parameter  	TRANSACTOR_VERSION			= 1,
			parameter	HPARITY						= 1,
			parameter	C_DATA_WIDTH				= 128,
			//parameter	DATA_CRD_GRAN				= 4,		I ASSUME THIS IS THE VALUE OF THIS PARAMETER
			parameter  	M							= 1,
			parameter  	H							= 32,
			parameter  	D							= 64, //supported values: 64, 128
			parameter  	DS							= 1,
			parameter  	NDCRD						= 4,
			parameter  	NHCRD						= 4

)( 
   // Port Declarations
   
   //Transactor CLK and Reset wires:
  input  	wire    				SFI_clk, 
  input 	wire    				SFI_rst_n, 
  
   //Generic chassis CLK and Reset wires:
   
  input   	wire            		generic_chassis_clk, 
  input   	wire            		generic_chassis_rst,
   
   //SFI Interface
   
   //global channel - RX
	input 	wire					sfi_rx_txcon_req,
	output 	wire					sfi_rx_rxcon_ack,
	output 	wire					sfi_rx_rxdiscon_nack,
	output 	wire					sfi_rx_rx_empty,
	
   //global channel - TX
	output 	wire					sfi_tx_txcon_req,
	input 	wire					sfi_tx_rxcon_ack,
	input 	wire					sfi_tx_rxdiscon_nack,
	input 	wire					sfi_tx_rx_empty, //TODO
	
   //header channel - RX
	input 	wire	[M-1:0]			sfi_rx_hdr_valid,
	input 	wire					sfi_rx_hdr_early_valid,
	output 	wire					sfi_rx_hdr_block,
	input 	wire	[H*8-1:0]		sfi_rx_header,
	input 	wire	[M*16-1:0]		sfi_rx_hdr_info_bytes,
	output 	wire					sfi_rx_hdr_crd_rtn_valid,
	output 	wire					sfi_rx_hdr_crd_rtn_ded,
	output 	wire	[1:0]			sfi_rx_hdr_crd_rtn_fc_id,
	output 	wire	[4:0]			sfi_rx_hdr_crd_rtn_vc_id,
	output 	wire	[NHCRD-1:0]		sfi_rx_hdr_crd_rtn_value,
	input 	wire					sfi_rx_hdr_crd_rtn_block,
	
   //data channel - RX
	input 	wire					sfi_rx_data_valid,
	input 	wire					sfi_rx_data_early_valid,
	output 	wire					sfi_rx_data_block,
	input 	wire	[D*8-1:0]		sfi_rx_data,
	input 	wire	[D/8-1:0]		sfi_rx_data_parity,
	input 	wire	[DS-1:0]		sfi_rx_data_start,
	input 	wire	[DS*8-1:0]		sfi_rx_data_info_byte,
	input 	wire	[D/4-1:0]		sfi_rx_data_end,
	input 	wire	[D/4-1:0]		sfi_rx_data_poison,
	input 	wire	[D/4-1:0]		sfi_rx_data_edb,
	input 	wire					sfi_rx_data_aux_parity,
	output 	wire					sfi_rx_data_crd_rtn_valid,
	output 	wire					sfi_rx_data_crd_rtn_ded,
	output 	wire	[1:0]			sfi_rx_data_crd_rtn_fc_id,
	output 	wire	[4:0]			sfi_rx_data_crd_rtn_vc_id,
	output 	wire	[NDCRD-1:0]		sfi_rx_data_crd_rtn_value,
	input 	wire					sfi_rx_data_crd_rtn_block,

   //header channel - TX
	output 	wire	[M-1:0]			sfi_tx_hdr_valid,
	output 	wire					sfi_tx_hdr_early_valid,
	input 	wire					sfi_tx_hdr_block,
	output 	wire	[H*8-1:0]		sfi_tx_header,
	output 	wire	[M*16-1:0]		sfi_tx_hdr_info_bytes,
	input 	wire					sfi_tx_hdr_crd_rtn_valid,
	input 	wire					sfi_tx_hdr_crd_rtn_ded,
	input 	wire	[1:0]			sfi_tx_hdr_crd_rtn_fc_id,
	input 	wire	[4:0]			sfi_tx_hdr_crd_rtn_vc_id,
	input 	wire	[NHCRD-1:0]		sfi_tx_hdr_crd_rtn_value,
	output 	wire					sfi_tx_hdr_crd_rtn_block,
	
   //data channel - TX
	output 	wire					sfi_tx_data_valid,
	output 	wire					sfi_tx_data_early_valid,
	input 	wire					sfi_tx_data_block,
	output 	wire	[D*8-1:0]		sfi_tx_data,
	output 	wire	[D/8-1:0]		sfi_tx_data_parity,
	output 	wire	[DS-1:0]		sfi_tx_data_start,
	output 	wire	[DS*8-1:0]		sfi_tx_data_info_byte,
	output 	wire	[D/4-1:0]		sfi_tx_data_end,
	output 	wire	[D/4-1:0]		sfi_tx_data_poison,
	output 	wire	[D/4-1:0]		sfi_tx_data_edb,
	output 	wire					sfi_tx_data_aux_parity,
	input 	wire					sfi_tx_data_crd_rtn_valid,
	input 	wire					sfi_tx_data_crd_rtn_ded,
	input 	wire	[1:0]			sfi_tx_data_crd_rtn_fc_id,
	input 	wire	[4:0]			sfi_tx_data_crd_rtn_vc_id,
	input 	wire	[NDCRD-1:0]		sfi_tx_data_crd_rtn_value,
	output 	wire					sfi_tx_data_crd_rtn_block,	

	
   //Here are the signals that connect to the FIFO's within the communication block - for indirect
//tx fifo interface with the communication block
  output    wire   [3:0]          rd_rx_fifo,		
  input  	wire   [3:0]  [127:0] dout_rx_fifo,
  input  	wire   [3:0]          empty_rx_fifo,

  //tx fifo level interface with the communication block
  output 	wire   [3:0]          wr_tx_fifo,
  output 	wire   [3:0]  [127:0] din_tx_fifo,
  input  	wire   [3:0]          full_tx_fifo, 
    
    
    `ifdef PCIE_BRIDGE 
  //DESC inerface
     //direct wires. DS direct  - desc interface
   	output  wire            		direct_desc_rx_ack,
	output  wire            		direct_desc_rx_ws,
	output  wire            		direct_desc_rx_eof, 
	input 	wire            		direct_desc_rx_req,
	input 	wire [135:0] 			direct_desc_rx_desc,
	input 	wire            		direct_desc_rx_dfr,
	input 	wire            		direct_desc_rx_dv,
	input 	wire [7:0] 				direct_desc_rx_be ,
	input 	wire [63:0] 			direct_desc_rx_data,  

	//direct wires. US direct  - desc interface
	output	wire [127:0] 			direct_desc_tx_cmd_desc,
	output	wire [63:0]  			direct_desc_tx_data_desc,
	output	wire       				direct_desc_tx_req,
	output	wire       				direct_desc_tx_dfr,
	input	wire 					direct_desc_tx_ack,
	input	wire 					direct_desc_tx_ws,
	output	wire       				direct_desc_tx_req_arbiter,
	input	wire       				direct_desc_tx_ack_arbiter, 
	`endif
   
   //AXIS Interface
   
 /*  //direct wires. DS direct (cq and cc)
  input 	wire                     	 	direct_axis_cq_tvalid,
  input 	wire                     	 	direct_axis_cq_tlast,
  input 	wire [84:0]   					direct_axis_cq_tuser,
  input 	wire [((C_DATA_WIDTH/32)-1):0] 	direct_axis_cq_tkeep,
  input 	wire [(C_DATA_WIDTH-1):0] 		direct_axis_cq_tdata,
  output  	wire                      		direct_axis_cq_tready,
  //input 	wire [15:0]               		direct_completer_id,

  output  	wire [C_DATA_WIDTH-1:0]  		direct_axis_cc_tdata,
  output  	wire [((C_DATA_WIDTH/32)-1):0]	direct_axis_cc_tkeep,
  output  	wire  			        		direct_axis_cc_tlast,
  output  	wire  			        		direct_axis_cc_tvalid,
  output  	wire [32:0] 					direct_axis_cc_tuser,
  input   	wire                     		direct_axis_cc_tready,*/

//aximm interface with the transactor
  input  	wire          aximm_awvalid,
  output   	wire          aximm_awready,
  input  	wire  [7:0]   aximm_awid,
  input  	wire  [15:0]  aximm_awaddr,
  input  	wire  [7:0]   aximm_awlen,
  input  	wire  [2:0]   aximm_awsize,
  input  	wire  [1:0]   aximm_awburst,
  input  	wire          aximm_awlock,
  input  	wire  [3:0]   aximm_awcache,
  input  	wire  [3:0]   aximm_awqos,
                
  input  	wire          aximm_wvalid,
  output   	wire          aximm_wready,
  input  	wire          aximm_wlast,
  input  	wire  [127:0] aximm_wdata,
  input  	wire  [15:0]  aximm_wstrb,
					
  output   	wire  	      aximm_bvalid,
  input  	wire          aximm_bready,
  output   	wire  [7:0]   aximm_bid,
  output   	wire  [1:0]   aximm_bresp,
					
  input  	wire          aximm_arvalid,
  output   	wire          aximm_arready,
  input  	wire  [7:0]   aximm_arid,
  input  	wire  [15:0]  aximm_araddr,
  input  	wire  [7:0]   aximm_arlen,
  input  	wire  [2:0]   aximm_arsize,
  input  	wire  [1:0]   aximm_arburst,
  input  	wire          aximm_arlock,
  input  	wire  [3:0]   aximm_arcache,
  input  	wire  [3:0]   aximm_arqos,
	
  output   	wire          aximm_rvalid,
  input  	wire          aximm_rready,
  output   	wire  [7:0]   aximm_rid,
  output   	wire  [127:0] aximm_rdata,
  output   	wire  [1:0]   aximm_rresp,
  output   	wire          aximm_rlast

//FGT DMA
//here I should put the signals that go to the transactor from the dma  
);

   parameter  HDR_CREDIT_VC0_FC0   		= 15;
   parameter  HDR_CREDIT_VC0_FC1      	= 15;
   parameter  HDR_CREDIT_VC0_FC2   		= 15;
   parameter  HDR_CREDIT_VC1_FC0       	= 15;
   parameter  HDR_CREDIT_VC1_FC1       	= 15;
   parameter  HDR_CREDIT_VC1_FC2       	= 15;
   parameter  HDR_CREDIT_VC2_FC0       	= 15;
   parameter  HDR_CREDIT_VC2_FC1       	= 15;
   parameter  HDR_CREDIT_VC2_FC2       	= 15;
   parameter  DATA_CREDIT_VC0_FC0   	= 256;
   parameter  DATA_CREDIT_VC0_FC1      	= 256;
   parameter  DATA_CREDIT_VC0_FC2   	= 256;
   parameter  DATA_CREDIT_VC1_FC0      	= 256;
   parameter  DATA_CREDIT_VC1_FC1      	= 256;
   parameter  DATA_CREDIT_VC1_FC2      	= 256;
   parameter  DATA_CREDIT_VC2_FC0      	= 256;
   parameter  DATA_CREDIT_VC2_FC1      	= 256;
   parameter  DATA_CREDIT_VC2_FC2      	= 256;
   

// Internal signal declarations

	wire					TX_connected;;
	wire 					RX_connected;


	wire	[11:0]			prog_full;
	wire	[11:0]			empty;
	wire	[9:0]			wr_en;
	wire	[7:0]			rd_en;
	wire	[8:0] 	[127:0]	dout;
	wire			[511:0]	dout_lsb_512;
	wire			[511:0]	dout_msb_512;
	wire			[511:0]	dout_lsb_512_r;
	wire			[511:0]	dout_msb_512_r;
	wire			[255:0]	dout_256;
	wire			[255:0]	dout_256_r;
	wire	[6:0] 	[127:0]	din;
	wire	     	[511:0]	din_lsb_512;
	wire	     	[511:0]	din_lsb_512_r;
	wire	     	[511:0]	din_msb_512;
	wire	     	[511:0]	din_msb_512_r;
	wire	    	[255:0]	din_256;
	wire	    	[255:0]	din_256_r;
	

     //user reg file 
    wire            		user_wr_en;
    wire   [127:0]  		user_wr_data;
    wire   [15:0]   		user_byte_en;
    wire   [15:0]   		user_wr_addr;
    wire            		user_wr_ws;
      

  //read 
    wire   [15:0]   		user_rd_addr;
    wire            		user_rd_en;
    wire            		user_rd_valid;
    wire   [127:0]  		user_rd_data; 
    
    
    wire					tx_hdr_vc0_fc0_infinite;
	wire					tx_hdr_vc0_fc1_infinite;
	wire					tx_hdr_vc0_fc2_infinite;
	wire					tx_hdr_vc1_fc0_infinite;
	wire					tx_hdr_vc1_fc1_infinite;
	wire					tx_hdr_vc1_fc2_infinite;
	wire					tx_hdr_vc2_fc0_infinite;
	wire					tx_hdr_vc2_fc1_infinite;
	wire					tx_hdr_vc2_fc2_infinite;
	
	wire					tx_data_vc0_fc0_infinite;
	wire					tx_data_vc0_fc1_infinite;
	wire					tx_data_vc0_fc2_infinite;
	wire					tx_data_vc1_fc0_infinite;
	wire					tx_data_vc1_fc1_infinite;
	wire					tx_data_vc1_fc2_infinite;
	wire					tx_data_vc2_fc0_infinite;
	wire					tx_data_vc2_fc1_infinite;
	wire					tx_data_vc2_fc2_infinite;	

	wire 	[7:0]			TX_DATA_rd_data_count_1;
	wire 	[7:0]			TX_DATA_MD_rd_data_count_1;
	wire 	[7:0]			TX_DATA_rd_data_count_2;
	wire 	[7:0]			TX_DATA_MD_rd_data_count_2;
	wire	[2:0]			sfi_tx_data_credit_value;
	
	reg		[2:0]			data_cntr;
	reg						hdr_cntr;
	wire					data_flag;
	wire					hdr_flag;
	
	wire					indirect_direct_select;	//0=direct	1=indirect
	wire   [3:0]          	direct_rd_rx_fifo;	
  	wire   [3:0]  [127:0] 	direct_dout_rx_fifo;
   	wire   [3:0]          	direct_empty_rx_fifo;
   	wire   [3:0]          	direct_wr_tx_fifo;
	wire   [3:0]  [127:0] 	direct_din_tx_fifo;
	wire   [3:0]          	direct_full_tx_fifo;

//TX FIFO's managment
assign din_tx_fifo[0] 	= rd_en[0] ? dout[0] : dout[6];
assign din_tx_fifo[1] 	= rd_en[1] ? dout[1] : dout[7];
assign din_tx_fifo[2] 	= dout[2];
assign din_tx_fifo[3] 	= dout[3];

assign direct_din_tx_fifo[0] 	= rd_en[0] ? dout[0] : dout[6];
assign direct_din_tx_fifo[1] 	= rd_en[1] ? dout[1] : dout[7];
assign direct_din_tx_fifo[2] 	= dout[2];
assign direct_din_tx_fifo[3] 	= dout[3];

assign wr_tx_fifo[0]		= ~indirect_direct_select ? 1'b0 : (rd_en[0] | rd_en[6]);
assign wr_tx_fifo[1]		= ~indirect_direct_select ? 1'b0 : (rd_en[1] | rd_en[7]);
assign wr_tx_fifo[2]		= ~indirect_direct_select ? 1'b0 : rd_en[2];
assign wr_tx_fifo[3]		= ~indirect_direct_select ? 1'b0 : rd_en[3];

assign direct_wr_tx_fifo[0]	= ~indirect_direct_select ? (rd_en[0] | rd_en[6]) : 1'b0;
assign direct_wr_tx_fifo[1]	= ~indirect_direct_select ? (rd_en[1] | rd_en[7]) : 1'b0;
assign direct_wr_tx_fifo[2]	= ~indirect_direct_select ? rd_en[2] : 1'b0;
assign direct_wr_tx_fifo[3]	= ~indirect_direct_select ? rd_en[3] : 1'b0;

//RX FIFO's managment
assign rd_rx_fifo[0] 			= ~indirect_direct_select ? 1'b0 : (~empty_rx_fifo[0] & ~prog_full[4]  & ~prog_full[10]);
assign direct_rd_rx_fifo[0] 	= ~indirect_direct_select ? (~direct_empty_rx_fifo[0] & ~prog_full[4]  & ~prog_full[10]) : 1'b0;
assign wr_en[4] 				= ~indirect_direct_select ? (~direct_empty_rx_fifo[0] & ~prog_full[4] & ~prog_full[10] & ~data_flag) : (~empty_rx_fifo[0] & ~prog_full[4] & ~prog_full[10] & ~data_flag);//rd_rx_fifo[0] & ~data_flag;
assign wr_en[8] 				= ~indirect_direct_select ? (~direct_empty_rx_fifo[0] & ~prog_full[4] & ~prog_full[10] & data_flag) : (~empty_rx_fifo[0] & ~prog_full[4] & ~prog_full[10] & data_flag);//rd_rx_fifo[0] & data_flag;
assign din[2] 					= ~indirect_direct_select ? direct_dout_rx_fifo[0]: dout_rx_fifo[0];

assign data_flag = (D==64) ? 1'b0 : data_cntr[2];

always @ (posedge SFI_clk or negedge SFI_rst_n)
   begin
      if (!SFI_rst_n) begin 
			data_cntr  	<= 3'h0;
		 end else begin 
			if (rd_rx_fifo[0] | direct_rd_rx_fifo[0])begin
			data_cntr <= data_cntr +1;
			end else begin
			data_cntr <= data_cntr;
		end
	end	
	end

assign rd_rx_fifo[1] 			= ~indirect_direct_select ? 1'b0 : (~empty_rx_fifo[1] & ~prog_full[5]  & ~prog_full[11]);
assign direct_rd_rx_fifo[1] 	= ~indirect_direct_select ? (~direct_empty_rx_fifo[1] & ~prog_full[5]  & ~prog_full[11]) : 1'b0;
assign wr_en[5] 				= ~indirect_direct_select ? (~direct_empty_rx_fifo[1] & ~prog_full[5]  & ~prog_full[11] & ~hdr_flag) : (~empty_rx_fifo[1] & ~prog_full[5]  & ~prog_full[11] & ~hdr_flag);//rd_rx_fifo[0] & ~data_flag;
assign wr_en[9] 				= ~indirect_direct_select ? (~direct_empty_rx_fifo[1] & ~prog_full[5]  & ~prog_full[11] & hdr_flag) : (~empty_rx_fifo[1] & ~prog_full[5]  & ~prog_full[11] & hdr_flag);//rd_rx_fifo[0] & data_flag;
assign din[3] 					= ~indirect_direct_select ? direct_dout_rx_fifo[1] : dout_rx_fifo[1];

assign hdr_flag = (D==64) ? 1'b0 : hdr_cntr;

always @ (posedge SFI_clk or negedge SFI_rst_n)
   begin
      if (!SFI_rst_n) begin 
			hdr_cntr  	<= 1'b0;
		 end else begin 
			if (rd_rx_fifo[1] | direct_rd_rx_fifo[1])begin
			hdr_cntr <= ~hdr_cntr;
			end else begin
			hdr_cntr <= hdr_cntr;
		end
	end	
	end

assign rd_rx_fifo[2] 			= ~indirect_direct_select ? 1'b0 : (~empty_rx_fifo[2] & ~prog_full[6]);
assign direct_rd_rx_fifo[2] 	= ~indirect_direct_select ? (~direct_empty_rx_fifo[2] & ~prog_full[6]) : 1'b0;
assign wr_en[6] 				= ~indirect_direct_select ? (~direct_empty_rx_fifo[2] & ~prog_full[6]) : (~empty_rx_fifo[2] & ~prog_full[6]);
assign din[4] 					= ~indirect_direct_select ? direct_dout_rx_fifo[2] : dout_rx_fifo[2];

assign rd_rx_fifo[3] 			= ~indirect_direct_select ? 1'b0 : (~empty_rx_fifo[3] & ~prog_full[7]);
assign direct_rd_rx_fifo[3] 	= ~indirect_direct_select ? (~direct_empty_rx_fifo[3] & ~prog_full[7]) : 1'b0;
assign wr_en[7] 				= ~indirect_direct_select ? (~direct_empty_rx_fifo[3] & ~prog_full[7]) : (~empty_rx_fifo[3] & ~prog_full[7]);
assign din[5] 					= ~indirect_direct_select ? direct_dout_rx_fifo[3] : dout_rx_fifo[3];

 generic_async_fifo # (      
             .WRITE_WIDTH (512),
             .READ_WIDTH  (128),
             .NUM_BITS    (512*512),
             .AFULL_THRESHOLD (512*500)//,

        
           ) fifo_tx_512_to_128_depth_1k_fwft_RX_DATA_0_1(
              

   .wr_clk        (SFI_clk),
   .wr_rst_n      (SFI_rst_n),
   .wr_en         (wr_en[0]),
   .wr_data       (din_lsb_512),
   .wr_full       (),
   .wr_afull      (prog_full[0]),
   .wr_occupancy  (),
   .wr_overflow   (),
   .rd_clk        (SFI_clk),
   .rd_rst_n      (SFI_rst_n),
   .rd_en         (rd_en[0]),
   .rd_data       (dout[0]),
   .rd_empty      (empty[0]),
   .rd_aempty     (),
   .rd_occupancy  (),
   .rd_underflow  ()
);

 generate if (D == 128)     
  begin: RX_DATA_0_2                                           
    
 generic_async_fifo # (      
             .WRITE_WIDTH (512),
             .READ_WIDTH  (128),
             .NUM_BITS    (512*512),
             .AFULL_THRESHOLD (512*500)//,

        
           ) fifo_tx_512_to_128_depth_1k_fwft_RX_DATA_0_2(
              

   .wr_clk        (SFI_clk),
   .wr_rst_n      (SFI_rst_n),
   .wr_en         (wr_en[0]),
   .wr_data       (din_msb_512),
   .wr_full       (),
   .wr_afull      (prog_full[8]),
   .wr_occupancy  (),
   .wr_overflow   (),
   .rd_clk        (SFI_clk),
   .rd_rst_n      (SFI_rst_n),
   .rd_en         (rd_en[6]),
   .rd_data       (dout[6]),
   .rd_empty      (empty[8]),
   .rd_aempty     (),
   .rd_occupancy  (),
   .rd_underflow  ()
);

end else begin

assign prog_full[8] = 1'b0;
assign empty[8] 	= 1'b1;
assign dout[6]		=  'b0;

end
endgenerate

 generic_async_fifo # (      
             .WRITE_WIDTH (128),
             .READ_WIDTH  (128),
             .NUM_BITS    (128*512),
             .AFULL_THRESHOLD (128*500)//,

         )fifo_tx_128_to_128_depth_1k_fwft_RX_DATA_MD_1_1      (

   .wr_clk        (SFI_clk),
   .wr_rst_n      (SFI_rst_n),
   .wr_en         (wr_en[1]),
   .wr_data       (din[0]),
   .wr_full       (),
   .wr_afull      (prog_full[1]),
   .wr_occupancy  (),
   .wr_overflow   (),
   .rd_clk        (SFI_clk),
   .rd_rst_n      (SFI_rst_n),
   .rd_en         (rd_en[1]),
   .rd_data       (dout[1]),
   .rd_empty      (empty[1]),
   .rd_aempty     (),
   .rd_occupancy  (),
   .rd_underflow  ()

);

 generate if (D == 128)     
  begin: RX_DATA_MD_1_2 
  
	assign 		din[6][7:0]				= 	sfi_rx_data_parity[15:8];
	assign 		din[6][23:8]			=   'b0;
	assign 		din[6][39:24]			=	sfi_rx_data_poison[31:16];
	assign 		din[6][55:40]			=	sfi_rx_data_edb[31:16];
	assign 		din[6][57:56]			=	'b0;
	assign 		din[6][73:58]			=	sfi_rx_data_end[31:16];
	assign 		din[6][127:74]			=	'b0;
  
  
generic_async_fifo # (      
             .WRITE_WIDTH (128),
             .READ_WIDTH  (128),
             .NUM_BITS    (128*512),
             .AFULL_THRESHOLD (128*500)//,

         )fifo_tx_128_to_128_depth_1k_fwft_RX_DATA_MD_1_2      (

   .wr_clk        (SFI_clk),
   .wr_rst_n      (SFI_rst_n),
   .wr_en         (wr_en[1]),
   .wr_data       (din[6]),
   .wr_full       (),
   .wr_afull      (prog_full[9]),
   .wr_occupancy  (),
   .wr_overflow   (),
   .rd_clk        (SFI_clk),
   .rd_rst_n      (SFI_rst_n),
   .rd_en         (rd_en[7]),
   .rd_data       (dout[7]),
   .rd_empty      (empty[9]),
   .rd_aempty     (),
   .rd_occupancy  (),
   .rd_underflow  ()

);

end else begin

assign prog_full[9] = 1'b0;
assign empty[9] 	= 1'b1;
assign din[6]		=  'b0;
assign dout[7]		=  'b0;

end
endgenerate


 generic_async_fifo # (      
             .WRITE_WIDTH (256),
             .READ_WIDTH  (128),
             .NUM_BITS    (256*64),
             .AFULL_THRESHOLD (256*56)//,
        
           )fifo_tx_256_to_128_depth_1k_fwft_RX_HDR_2 (
              

   .wr_clk        (SFI_clk),
   .wr_rst_n      (SFI_rst_n),
   .wr_en         (wr_en[2]),
   .wr_data       (din_256),
   .wr_full       (),
   .wr_afull      (prog_full[2]),
   .wr_occupancy  (),
   .wr_overflow   (),
   .rd_clk        (SFI_clk),
   .rd_rst_n      (SFI_rst_n),
   .rd_en         (rd_en[2]),
   .rd_data       (dout[2]),
   .rd_empty      (empty[2]),
   .rd_aempty     (),
   .rd_occupancy  (),
   .rd_underflow  ()

);

 generic_async_fifo # (      
             .WRITE_WIDTH (128),
             .READ_WIDTH  (128),
             .NUM_BITS    (128*128),
             .AFULL_THRESHOLD (128*120)//,

         )fifo_tx_128_to_128_depth_1k_fwft_RX_HDR_MD_3       (

   .wr_clk        (SFI_clk),
   .wr_rst_n      (SFI_rst_n),
   .wr_en         (wr_en[3]),
   .wr_data       (din[1]),
   .wr_full       (),
   .wr_afull      (prog_full[3]),
   .wr_occupancy  (),
   .wr_overflow   (),
   .rd_clk        (SFI_clk),
   .rd_rst_n      (SFI_rst_n),
   .rd_en         (rd_en[3]),
   .rd_data       (dout[3]),
   .rd_empty      (empty[3]),
   .rd_aempty     (),
   .rd_occupancy  (),
   .rd_underflow  ()

);


 generic_async_fifo # (      
             .WRITE_WIDTH (128),
             .READ_WIDTH  (512),
             .NUM_BITS    (512*128),
             .AFULL_THRESHOLD (512*124)//,

         )fifo_rx_128_to_512_depth_1k_fwft_TX_DATA_4_1     (

   .wr_clk        (SFI_clk),
   .wr_rst_n      (SFI_rst_n),
   .wr_en         (wr_en[4]),
   .wr_data       (din[2]),
   .wr_full       (),
   .wr_afull      (prog_full[4]),
   .wr_occupancy  (),
   .wr_overflow   (),
   .rd_clk        (SFI_clk),
   .rd_rst_n      (SFI_rst_n),
   .rd_en         (rd_en[4]),
   .rd_data       (dout_lsb_512_r),
   .rd_empty      (empty[4]),
   .rd_aempty     (),
   .rd_occupancy  (TX_DATA_rd_data_count_1),
   .rd_underflow  ()

);

 generate if (D == 128)     
  begin: TX_DATA_4_2 

generic_async_fifo # (      
             .WRITE_WIDTH (128),
             .READ_WIDTH  (512),
             .NUM_BITS    (512*128),
             .AFULL_THRESHOLD (512*124)//,

         )fifo_rx_128_to_512_depth_1k_fwft_TX_DATA_4_2     (

   .wr_clk        (SFI_clk),
   .wr_rst_n      (SFI_rst_n),
   .wr_en         (wr_en[8]),
   .wr_data       (din[2]),
   .wr_full       (),
   .wr_afull      (prog_full[10]),
   .wr_occupancy  (),
   .wr_overflow   (),
   .rd_clk        (SFI_clk),
   .rd_rst_n      (SFI_rst_n),
   .rd_en         (rd_en[4]),
   .rd_data       (dout_msb_512_r),
   .rd_empty      (empty[10]),
   .rd_aempty     (),
   .rd_occupancy  (TX_DATA_rd_data_count_2),
   .rd_underflow  ()

);



end else begin

assign prog_full[10] 	= 1'b0;
assign empty[10] 		= 1'b0;
assign dout_msb_512_r	=  'b0;

end
endgenerate

 generic_async_fifo # (      
             .WRITE_WIDTH (128),
             .READ_WIDTH  (128),
             .NUM_BITS    (128*128),
             .AFULL_THRESHOLD (128*126)//,

         )fifo_rx_128_to_128_depth_1k_fwft_TX_DATA_MD_5_1        (

   .wr_clk        (SFI_clk),
   .wr_rst_n      (SFI_rst_n),
   .wr_en         (wr_en[5]),
   .wr_data       (din[3]),
   .wr_full       (),
   .wr_afull      (prog_full[5]),
   .wr_occupancy  (),
   .wr_overflow   (),
   .rd_clk        (SFI_clk),
   .rd_rst_n      (SFI_rst_n),
   .rd_en         (rd_en[4]),
   .rd_data       (dout[4]),
   .rd_empty      (empty[5]),
   .rd_aempty     (),
   .rd_occupancy  (TX_DATA_MD_rd_data_count_1),
   .rd_underflow  ()

);


 generate if (D == 128)     
  begin: TX_DATA_MD_5_2 

 generic_async_fifo # (      
             .WRITE_WIDTH (128),
             .READ_WIDTH  (128),
             .NUM_BITS    (128*128),
             .AFULL_THRESHOLD (128*126)//,

         )fifo_rx_128_to_128_depth_1k_fwft_TX_DATA_MD_5_2        (

   .wr_clk        (SFI_clk),
   .wr_rst_n      (SFI_rst_n),
   .wr_en         (wr_en[9]),
   .wr_data       (din[3]),
   .wr_full       (),
   .wr_afull      (prog_full[11]),
   .wr_occupancy  (),
   .wr_overflow   (),
   .rd_clk        (SFI_clk),
   .rd_rst_n      (SFI_rst_n),
   .rd_en         (rd_en[4]),
   .rd_data       (dout[8]),
   .rd_empty      (empty[11]),
   .rd_aempty     (),
   .rd_occupancy  (TX_DATA_MD_rd_data_count_2),
   .rd_underflow  ()

);

end else begin

assign prog_full[11] 	= 1'b0;
assign empty[11] 		= 1'b0;
assign dout[8]			=  'b0;

end
endgenerate


 generic_async_fifo # (      
             .WRITE_WIDTH (128),
             .READ_WIDTH  (256),
             .NUM_BITS    (256*64),
             .AFULL_THRESHOLD (256*62)//,

         )fifo_rx_128_to_256_depth_1k_fwft_TX_HDR_6  (

   .wr_clk        (SFI_clk),
   .wr_rst_n      (SFI_rst_n),
   .wr_en         (wr_en[6]),
   .wr_data       (din[4]),
   .wr_full       (),
   .wr_afull      (prog_full[6]),
   .wr_occupancy  (),
   .wr_overflow   (),
   .rd_clk        (SFI_clk),
   .rd_rst_n      (SFI_rst_n),
   .rd_en         (rd_en[5]),
   .rd_data       (dout_256_r),
   .rd_empty      (empty[6]),
   .rd_aempty     (),
   .rd_occupancy  (),
   .rd_underflow  ()

);


 generic_async_fifo # (      
             .WRITE_WIDTH (128),
             .READ_WIDTH  (128),
             .NUM_BITS    (128*128),
             .AFULL_THRESHOLD (128*126)//,

         )fifo_rx_128_to_128_depth_1k_TX_HDR_MD_7 (

   .wr_clk        (SFI_clk),
   .wr_rst_n      (SFI_rst_n),
   .wr_en         (wr_en[7]),
   .wr_data       (din[5]),
   .wr_full       (),
   .wr_afull      (prog_full[7]),
   .wr_occupancy  (),
   .wr_overflow   (),
   .rd_clk        (SFI_clk),
   .rd_rst_n      (SFI_rst_n),
   .rd_en         (rd_en[5]),
   .rd_data       (dout[5]),
   .rd_empty      (empty[7]),
   .rd_aempty     (),
   .rd_occupancy  (),
   .rd_underflow  ()

);


SFI_connect_disconnect_controller SFI_connect_disconnect_controller_inst(

            .clk 					(SFI_clk),
            .rst_n 					(SFI_rst_n),
            
			.sfi_rx_txcon_req		(sfi_rx_txcon_req),
			.sfi_rx_rxcon_ack		(sfi_rx_rxcon_ack),
			.sfi_rx_rxdiscon_nack	(sfi_rx_rxdiscon_nack),
			.RX_connected			(RX_connected),
	
			.sfi_tx_txcon_req		(sfi_tx_txcon_req),
			.sfi_tx_rxcon_ack		(sfi_tx_rxcon_ack),
			.sfi_tx_rxdiscon_nack	(sfi_tx_rxdiscon_nack),
			.TX_connected			(TX_connected)
                );


aximm_controller #( 
              .TRANSACTOR_TYPE(TRANSACTOR_TYPE),
              .TRANSACTOR_VERSION(TRANSACTOR_VERSION)
                         )
aximm_controller_inst(
                                    
                                     .clk                (generic_chassis_clk),
                                     .rst_n              (~generic_chassis_rst),
                                       
                                     //write address channel
                                     .aximm_awid         (aximm_awid),
                                     .aximm_awaddr       (aximm_awaddr),
                                     .aximm_awlen        (aximm_awlen),
                                     .aximm_awsize       (aximm_awsize),
                                     .aximm_awburst      (aximm_awburst),
                                     .aximm_awlock       (aximm_awlock),
                                     .aximm_awcache      (aximm_awcache),
                                     .aximm_awqos        (aximm_awqos),
                                     .aximm_awvalid      (aximm_awvalid),
                                     .aximm_awready      (aximm_awready),

                                    //write data channel
                                     .aximm_wdata        (aximm_wdata),
                                     .aximm_wstrb        (aximm_wstrb),
                                     .aximm_wlast        (aximm_wlast),
                                     .aximm_wvalid       (aximm_wvalid),
                                     .aximm_wready       (aximm_wready),

                                     //write response channel  
                                     .aximm_bid          (aximm_bid),
                                     .aximm_bresp        (aximm_bresp),
                                     .aximm_bvalid       (aximm_bvalid),
                                     .aximm_bready       (aximm_bready),

                                    //Read Address (AR) Channel:
                                     .aximm_arid         (aximm_arid),
                                     .aximm_araddr       (aximm_araddr),
                                     .aximm_arlen        (aximm_arlen),
                                     .aximm_arsize       (aximm_arsize),
                                     .aximm_arburst      (aximm_arburst),
                                     .aximm_arlock       (aximm_arlock),
                                     .aximm_arcache      (aximm_arcache),
                                     .aximm_arqos        (aximm_arqos),
                                     .aximm_arvalid      (aximm_arvalid),
                                     .aximm_arready      (aximm_arready),

                                     //Read Data (R) Channel:
                                     .aximm_rid           (aximm_rid),
                                     .aximm_rdata         (aximm_rdata),
                                     .aximm_rresp         (aximm_rresp),
                                     .aximm_rlast         (aximm_rlast),
                                     .aximm_rvalid        (aximm_rvalid),
                                     .aximm_rready        (aximm_rready),

                                    .user_wr_en          (user_wr_en  ),
                                    .user_wr_data        (user_wr_data),
                                    .user_byte_en        (user_byte_en),
                                    .user_wr_addr        (user_wr_addr),
                                    .user_wr_ws          (user_wr_ws  ), 
                                                          
                                 
                                    .user_rd_addr        (user_rd_addr ),
                                    .user_rd_en          (user_rd_en   ),
                                    .user_rd_valid       (user_rd_valid),
                                    .user_rd_data        (user_rd_data )
                                   

                                   ); 
                                   
          SFI_register_file # (
				.D (D)
          )                      
  SFI_register_file_inst (

			//.SFI_clk              (SFI_clk),
           // .SFI_rst_n            (SFI_rst_n),

            .clk                   (generic_chassis_clk),
            .rst_n                 (~generic_chassis_rst),

            //for write controller
            .user_wr_en             (user_wr_en),
            .user_wr_data           (user_wr_data),
            .user_byte_en           (user_byte_en),
            .user_wr_addr           (user_wr_addr),
            .user_wr_ws             (user_wr_ws  ), 
                                                 
            //for read controll                  
            .user_rd_addr           (user_rd_addr ),
            .user_rd_en             (user_rd_en   ),
            .user_rd_valid          (user_rd_valid),
            .user_rd_data           (user_rd_data ),
            
            .indirect_direct_select	(indirect_direct_select)	//0=direct	1=indirect

                          );
                          
    
    assign 		sfi_tx_hdr_valid 		= rd_en[5];
	assign 		sfi_tx_hdr_early_valid 	= 1'b1;
	
	
	assign 		dout_256	 			= {dout_256_r[127:0],dout_256_r[255:128]};
	assign 		sfi_tx_header 			= sfi_tx_hdr_valid ? dout_256 		: 'b0;
	assign 		sfi_tx_hdr_info_bytes 	= sfi_tx_hdr_valid ? dout[5][15:0]  : 'b0;
	
   //data channel - TX
	assign 		sfi_tx_data_valid 		= rd_en[4];
	assign 		sfi_tx_data_early_valid = 1'b1;
	assign 		dout_lsb_512			= {dout_lsb_512_r[127:0],dout_lsb_512_r[255:128],dout_lsb_512_r[383:256],dout_lsb_512_r[511:384]};
	assign 		dout_msb_512			= {dout_msb_512_r[127:0],dout_msb_512_r[255:128],dout_msb_512_r[383:256],dout_msb_512_r[511:384]};
	assign 		sfi_tx_data 			= sfi_tx_data_valid ? ((D==128) ? {dout_msb_512,dout_lsb_512} : dout_lsb_512) : 'b0;
	assign 		sfi_tx_data_parity 		= sfi_tx_data_valid ? ((D==128) ? {dout[8][7:0],dout[4][7:0]} : dout[4][7:0]) : 'b0;
	assign 	 	sfi_tx_data_info_byte 	= sfi_tx_data_valid ? dout[4][15:8] 	: 'b0;
	assign 		sfi_tx_data_poison 		= sfi_tx_data_valid ? ((D==128) ? {dout[8][39:24],dout[4][39:24]} : dout[4][39:24]) : 'b0;  
	assign 		sfi_tx_data_edb 		= sfi_tx_data_valid ? ((D==128) ? {dout[8][55:40],dout[4][55:40]} : dout[4][55:40]) : 'b0;  
	assign 		sfi_tx_data_aux_parity 	= sfi_tx_data_valid ? dout[4][56] 		: 'b0;
    assign 		sfi_tx_data_start 		= sfi_tx_data_valid ? dout[4][57] 		: 'b0;
    assign 		sfi_tx_data_end 		= sfi_tx_data_valid ? ((D==128) ? {dout[8][73:58],dout[4][73:58]} : dout[4][73:58]) : 'b0;  
            
     //header channel - RX
	assign		sfi_rx_hdr_block		= 1'b0;
	assign 		din_256 	 			= 	din_256_r;
	assign 		din_256_r 	 			= 	{sfi_rx_header[127:0],sfi_rx_header[255:128]};
	assign 		din[1][15:0]			= 	sfi_rx_hdr_info_bytes;
	assign 		din[1][127:16]			= 	'b0;
	
   //data channel - RX
	assign		sfi_rx_data_block		= 1'b0;
	assign 		din_lsb_512 				= 	din_lsb_512_r;
	assign 		din_lsb_512_r 				= 	{sfi_rx_data[127:0],sfi_rx_data[255:128],sfi_rx_data[383:256],sfi_rx_data[511:384]};
	assign 		din_msb_512 				= 	din_msb_512_r;
	assign 		din_msb_512_r 				= 	(D==128) ? {sfi_rx_data[639:512],sfi_rx_data[767:640],sfi_rx_data[895:768],sfi_rx_data[1023:896]} : 'b0;
	assign 		din[0][7:0]				= 	sfi_rx_data_parity[7:0];
	assign 		din[0][15:8]			=   sfi_rx_data_info_byte;
	assign 		din[0][39:24]			=	sfi_rx_data_poison[15:0];
	assign 		din[0][55:40]			=	sfi_rx_data_edb[15:0];
	assign 		din[0][56]				=	sfi_rx_data_aux_parity;
	assign 		din[0][57]				=	sfi_rx_data_start;
	assign 		din[0][73:58]			=	sfi_rx_data_end[15:0];
	assign 		din[0][23:16]			=	'b0;
	assign 		din[0][127:74]			=	'b0;
  

    assign 	  wr_en[0] 				= sfi_rx_data_valid;
    assign	  wr_en[1] 				= sfi_rx_data_valid;
    assign	  wr_en[2]	 			= sfi_rx_hdr_valid;  
    assign	  wr_en[3]	 			= sfi_rx_hdr_valid;

//connect flow

	//global channel - RX
	assign 	sfi_rx_rx_empty			= 1'b1;
	
    //global channel - TX




//credit controller

		wire		[7:0]	hdr_credit_bus; 
		wire		[24:0]	data_credit_bus; 

		wire				operation_hdr_fifo_prog_full;
		wire				operation_data_fifo_prog_full;
		wire				rd_hdr_fifo;
		wire				rd_data_fifo;
		
		
		wire		[12:0]	tx_hdr_vc0_fc0_counter	;
		wire		[12:0]	tx_hdr_vc0_fc1_counter		;
		wire		[12:0]	tx_hdr_vc0_fc2_counter		;
		wire		[12:0]	tx_hdr_vc1_fc0_counter		;
		wire		[12:0]	tx_hdr_vc1_fc1_counter		;
		wire		[12:0]	tx_hdr_vc1_fc2_counter		;
		wire		[12:0]	tx_hdr_vc2_fc0_counter		;
		wire		[12:0]	tx_hdr_vc2_fc1_counter		;
		wire		[12:0]	tx_hdr_vc2_fc2_counter		;
	
		wire		[12:0]	tx_data_vc0_fc0_counter	;
		wire		[12:0]	tx_data_vc0_fc1_counter	;
		wire		[12:0]	tx_data_vc0_fc2_counter	;
		wire		[12:0]	tx_data_vc1_fc0_counter	;
		wire		[12:0]	tx_data_vc1_fc1_counter	;
		wire		[12:0]	tx_data_vc1_fc2_counter	;
		wire		[12:0]	tx_data_vc2_fc0_counter	;
		wire		[12:0]	tx_data_vc2_fc1_counter	;
		wire		[12:0]	tx_data_vc2_fc2_counter	;


		wire				hdr_vc0_fc0;
		wire				hdr_vc0_fc1;
		wire				hdr_vc0_fc2;
		wire				hdr_vc1_fc0;
		wire				hdr_vc1_fc1;
		wire				hdr_vc1_fc2;
		wire				hdr_vc2_fc0;
		wire				hdr_vc2_fc1;
		wire				hdr_vc2_fc2;
		
		assign	hdr_vc0_fc0 	= dout[5][1:0] == 2'b00 & dout[5][12:8] == 5'h00;
		assign	hdr_vc0_fc1 	= dout[5][1:0] == 2'b01 & dout[5][12:8] == 5'h00;
		assign	hdr_vc0_fc2 	= dout[5][1:0] == 2'b10 & dout[5][12:8] == 5'h00;
		assign	hdr_vc1_fc0 	= dout[5][1:0] == 2'b00 & dout[5][12:8] == 5'h01;
		assign	hdr_vc1_fc1 	= dout[5][1:0] == 2'b01 & dout[5][12:8] == 5'h01;
		assign	hdr_vc1_fc2 	= dout[5][1:0] == 2'b10 & dout[5][12:8] == 5'h01;
		assign	hdr_vc2_fc0 	= dout[5][1:0] == 2'b00 & dout[5][12:8] == 5'h02;
		assign	hdr_vc2_fc1 	= dout[5][1:0] == 2'b01 & dout[5][12:8] == 5'h02;
		assign	hdr_vc2_fc2 	= dout[5][1:0] == 2'b10 & dout[5][12:8] == 5'h02;
		

		wire				data_vc0_fc0;
		wire				data_vc0_fc1;
		wire				data_vc0_fc2;
		wire				data_vc1_fc0;
		wire				data_vc1_fc1;
		wire				data_vc1_fc2;
		wire				data_vc2_fc0;
		wire				data_vc2_fc1;
		wire				data_vc2_fc2;
			
		
		assign	data_vc0_fc0 	= dout[4][9:8] == 2'b00 & dout[4][15:11] == 5'h00;
		assign	data_vc0_fc1 	= dout[4][9:8] == 2'b01 & dout[4][15:11] == 5'h00;
		assign	data_vc0_fc2 	= dout[4][9:8] == 2'b10 & dout[4][15:11] == 5'h00;
		assign	data_vc1_fc0 	= dout[4][9:8] == 2'b00 & dout[4][15:11] == 5'h01;
		assign	data_vc1_fc1 	= dout[4][9:8] == 2'b01 & dout[4][15:11] == 5'h01;
		assign	data_vc1_fc2 	= dout[4][9:8] == 2'b10 & dout[4][15:11] == 5'h01;
		assign	data_vc2_fc0 	= dout[4][9:8] == 2'b00 & dout[4][15:11] == 5'h02;
		assign	data_vc2_fc1 	= dout[4][9:8] == 2'b01 & dout[4][15:11] == 5'h02;
		assign	data_vc2_fc2 	= dout[4][9:8] == 2'b10 & dout[4][15:11] == 5'h02;
		

 SFI_credit_ctrl #( 
	
	 .HDR_CREDIT_VC0_FC0   	(HDR_CREDIT_VC0_FC0),	
     .HDR_CREDIT_VC0_FC1    (HDR_CREDIT_VC0_FC1), 	
     .HDR_CREDIT_VC0_FC2   	(HDR_CREDIT_VC0_FC2),		
     .HDR_CREDIT_VC1_FC0    (HDR_CREDIT_VC1_FC0),	
     .HDR_CREDIT_VC1_FC1    (HDR_CREDIT_VC1_FC1), 
     .HDR_CREDIT_VC1_FC2    (HDR_CREDIT_VC1_FC2), 
     .HDR_CREDIT_VC2_FC0   	(HDR_CREDIT_VC2_FC0), 
     .HDR_CREDIT_VC2_FC1   	(HDR_CREDIT_VC2_FC1),    
     .HDR_CREDIT_VC2_FC2    (HDR_CREDIT_VC2_FC2), 
     .DATA_CREDIT_VC0_FC0  	(DATA_CREDIT_VC0_FC0), 	
     .DATA_CREDIT_VC0_FC1  	(DATA_CREDIT_VC0_FC1),  
     .DATA_CREDIT_VC0_FC2   (DATA_CREDIT_VC0_FC2),	
     .DATA_CREDIT_VC1_FC0   (DATA_CREDIT_VC1_FC0),
     .DATA_CREDIT_VC1_FC1   (DATA_CREDIT_VC1_FC1), 
     .DATA_CREDIT_VC1_FC2   (DATA_CREDIT_VC1_FC2),
     .DATA_CREDIT_VC2_FC0   (DATA_CREDIT_VC2_FC0),
     .DATA_CREDIT_VC2_FC1   (DATA_CREDIT_VC2_FC1),
     .DATA_CREDIT_VC2_FC2   (DATA_CREDIT_VC2_FC2),
     .M						(M),
	 .DS					(DS),
	 .NDCRD					(NDCRD),
	 .NHCRD					(NHCRD),
	 .D						(D)
)
 SFI_credit_ctrl_inst
( 
	 
	 //.fgc_clk      						(generic_chassis_clk), 
	 //.fgc_rst_n      					(~generic_chassis_rst), 
	 
	 .clk      						(SFI_clk), 
	 .rst_n      					(SFI_rst_n), 
	
	 .TX_connected      			(TX_connected),
	 //.RX_connected      			(RX_connected),
	
	 .hdr_credit_bus				(hdr_credit_bus),
	 .data_credit_bus				(data_credit_bus),
	 
	 .rx_hdr_fifo_prog_full				(prog_full[2]),
	 .rx_hdr_md_fifo_prog_full			(prog_full[3]),
	 .rx_data_1_fifo_prog_full			(prog_full[0]),
	 .rx_data_2_fifo_prog_full			(prog_full[8]),
	 .rx_data_md_1_fifo_prog_full			(prog_full[1]),
	 .rx_data_md_2_fifo_prog_full			(prog_full[9]),
		 
	// .link_layer_message_select				(link_layer_message_select),
	// .write_link_layer_message				(write_link_layer_message),
	 
	// .D2H_REQ_link_layer_message			(D2H_REQ_link_layer_message),
	// .D2H_RSP_link_layer_message			(D2H_RSP_link_layer_message),
	// .D2H_DATA_link_layer_message			(D2H_DATA_link_layer_message),
	 
	 
	.sfi_tx_hdr_valid				(sfi_tx_hdr_valid),
	.sfi_tx_hdr_info_bytes			(sfi_tx_hdr_info_bytes),
	
	.sfi_tx_data_valid				(sfi_tx_data_valid),
	.sfi_tx_data_info_byte			(sfi_tx_data_info_byte),
	.sfi_tx_data_credit_value		(sfi_tx_data_credit_value),
	
	.sfi_tx_hdr_crd_rtn_valid		(sfi_tx_hdr_crd_rtn_valid),
	.sfi_tx_hdr_crd_rtn_ded			(sfi_tx_hdr_crd_rtn_ded),
	.sfi_tx_hdr_crd_rtn_fc_id		(sfi_tx_hdr_crd_rtn_fc_id),
	.sfi_tx_hdr_crd_rtn_vc_id		(sfi_tx_hdr_crd_rtn_vc_id),
	.sfi_tx_hdr_crd_rtn_value		(sfi_tx_hdr_crd_rtn_value),
	.sfi_tx_hdr_crd_rtn_block		(sfi_tx_hdr_crd_rtn_block),
	
	.sfi_tx_data_crd_rtn_valid		(sfi_tx_data_crd_rtn_valid),
	.sfi_tx_data_crd_rtn_ded		(sfi_tx_data_crd_rtn_ded),
	.sfi_tx_data_crd_rtn_fc_id		(sfi_tx_data_crd_rtn_fc_id),
	.sfi_tx_data_crd_rtn_vc_id		(sfi_tx_data_crd_rtn_vc_id),
	.sfi_tx_data_crd_rtn_value		(sfi_tx_data_crd_rtn_value),
	.sfi_tx_data_crd_rtn_block		(sfi_tx_data_crd_rtn_block),	
	
	.sfi_rx_hdr_crd_rtn_valid		(sfi_rx_hdr_crd_rtn_valid),
	.sfi_rx_hdr_crd_rtn_ded			(sfi_rx_hdr_crd_rtn_ded),
	.sfi_rx_hdr_crd_rtn_fc_id		(sfi_rx_hdr_crd_rtn_fc_id),
	.sfi_rx_hdr_crd_rtn_vc_id		(sfi_rx_hdr_crd_rtn_vc_id),
	.sfi_rx_hdr_crd_rtn_value		(sfi_rx_hdr_crd_rtn_value),
	//.sfi_rx_hdr_crd_rtn_block		(sfi_rx_hdr_crd_rtn_block),
	
	.sfi_rx_data_crd_rtn_valid		(sfi_rx_data_crd_rtn_valid),
	.sfi_rx_data_crd_rtn_ded		(sfi_rx_data_crd_rtn_ded),
	.sfi_rx_data_crd_rtn_fc_id		(sfi_rx_data_crd_rtn_fc_id),
	.sfi_rx_data_crd_rtn_vc_id		(sfi_rx_data_crd_rtn_vc_id),
	.sfi_rx_data_crd_rtn_value		(sfi_rx_data_crd_rtn_value),
	//.sfi_rx_data_crd_rtn_block		(sfi_rx_data_crd_rtn_block),
	
	.tx_hdr_vc0_fc0_counter			(tx_hdr_vc0_fc0_counter),
	.tx_hdr_vc0_fc1_counter			(tx_hdr_vc0_fc1_counter),
	.tx_hdr_vc0_fc2_counter			(tx_hdr_vc0_fc2_counter),
	.tx_hdr_vc1_fc0_counter			(tx_hdr_vc1_fc0_counter),
	.tx_hdr_vc1_fc1_counter			(tx_hdr_vc1_fc1_counter),
	.tx_hdr_vc1_fc2_counter			(tx_hdr_vc1_fc2_counter),
	.tx_hdr_vc2_fc0_counter			(tx_hdr_vc2_fc0_counter),
	.tx_hdr_vc2_fc1_counter			(tx_hdr_vc2_fc1_counter),
	.tx_hdr_vc2_fc2_counter			(tx_hdr_vc2_fc2_counter),
	
	.tx_data_vc0_fc0_counter		(tx_data_vc0_fc0_counter),
	.tx_data_vc0_fc1_counter		(tx_data_vc0_fc1_counter),
	.tx_data_vc0_fc2_counter		(tx_data_vc0_fc2_counter),
	.tx_data_vc1_fc0_counter		(tx_data_vc1_fc0_counter),
	.tx_data_vc1_fc1_counter		(tx_data_vc1_fc1_counter),
	.tx_data_vc1_fc2_counter		(tx_data_vc1_fc2_counter),
	.tx_data_vc2_fc0_counter		(tx_data_vc2_fc0_counter),
	.tx_data_vc2_fc1_counter		(tx_data_vc2_fc1_counter),
	.tx_data_vc2_fc2_counter		(tx_data_vc2_fc2_counter),
	
	.tx_hdr_vc0_fc0_infinite		(tx_hdr_vc0_fc0_infinite),
	.tx_hdr_vc0_fc1_infinite		(tx_hdr_vc0_fc1_infinite),
	.tx_hdr_vc0_fc2_infinite		(tx_hdr_vc0_fc2_infinite),
	.tx_hdr_vc1_fc0_infinite		(tx_hdr_vc1_fc0_infinite),
	.tx_hdr_vc1_fc1_infinite		(tx_hdr_vc1_fc1_infinite),
	.tx_hdr_vc1_fc2_infinite		(tx_hdr_vc1_fc2_infinite),
	.tx_hdr_vc2_fc0_infinite		(tx_hdr_vc2_fc0_infinite),
	.tx_hdr_vc2_fc1_infinite		(tx_hdr_vc2_fc1_infinite),
	.tx_hdr_vc2_fc2_infinite		(tx_hdr_vc2_fc2_infinite),
	
	.tx_data_vc0_fc0_infinite		(tx_data_vc0_fc0_infinite),
	.tx_data_vc0_fc1_infinite		(tx_data_vc0_fc1_infinite),
	.tx_data_vc0_fc2_infinite		(tx_data_vc0_fc2_infinite),
	.tx_data_vc1_fc0_infinite		(tx_data_vc1_fc0_infinite),
	.tx_data_vc1_fc1_infinite		(tx_data_vc1_fc1_infinite),
	.tx_data_vc1_fc2_infinite		(tx_data_vc1_fc2_infinite),
	.tx_data_vc2_fc0_infinite		(tx_data_vc2_fc0_infinite),
	.tx_data_vc2_fc1_infinite		(tx_data_vc2_fc1_infinite),
	.tx_data_vc2_fc2_infinite		(tx_data_vc2_fc2_infinite),
	
	.sfi_rx_hdr_crd_rtn_block		(sfi_rx_hdr_crd_rtn_block),
	.sfi_rx_data_crd_rtn_block		(sfi_rx_data_crd_rtn_block),
	
	.operation_hdr_fifo_prog_full	(operation_hdr_fifo_prog_full),
	.operation_data_fifo_prog_full	(operation_data_fifo_prog_full)
	
);

    SFI_HDR_in_FIFO_ctrl 
     SFI_HDR_in_FIFO_ctrl_inst
( 

	
	.hdr_credit_bus						(hdr_credit_bus), 
	.operation_hdr_fifo_prog_full		(operation_hdr_fifo_prog_full),

	.dout								(dout[3]),
	.rd_en_hdr							(rd_en[2]),
	.rd_en_hdr_MD						(rd_en[3]),
	.empty_hdr 							(empty[2]),
	.empty_hdr_MD 						(empty[3]),
	.full_tx_fifo_hdr					(~indirect_direct_select ? direct_full_tx_fifo[2] : full_tx_fifo[2]),
	.full_tx_fifo_hdr_MD				(~indirect_direct_select ? direct_full_tx_fifo[3] : full_tx_fifo[3])
);

 SFI_DATA_in_FIFO_ctrl #( 
	
	 .D   	(D)	
     
)
     SFI_DATA_in_FIFO_ctrl_inst
( 
	.clk 								(SFI_clk), 
	.rst_n 								(SFI_rst_n), 
	
	
	.data_credit_bus					(data_credit_bus), 
	.operation_data_fifo_prog_full		(operation_data_fifo_prog_full),

	.dout_md_1							(dout[1]),
	.end_md_2							(dout[7][73:58]),	
	.rd_en_data_1						(rd_en[0]),
	.rd_en_data_2						(rd_en[6]),
	.rd_en_data_MD_1					(rd_en[1]),
	.rd_en_data_MD_2					(rd_en[7]),
	.empty_data_1 						(empty[0]),
	.empty_data_MD_1					(empty[1]),
	.empty_data_2 						(empty[8]),
	.empty_data_MD_2					(empty[9]),
	.full_tx_fifo_data					(~indirect_direct_select ? direct_full_tx_fifo[0] : full_tx_fifo[0]),
	.full_tx_fifo_data_MD				(~indirect_direct_select ? direct_full_tx_fifo[1] : full_tx_fifo[1])
);


SFI_HDR_DATA_out_FIFO_ctrl  #( 
	
	 .D   	(D)	
     
)  SFI_HDR_DATA_out_FIFO_ctrl_inst

( 
	.clk							(SFI_clk), 
	.rst_n							(SFI_rst_n), 
	
	.empty_hdr_fifo					(empty[6]),
	.empty_hdr_MD_fifo				(empty[7]),
	.empty_data_fifo_1				(empty[4]),
	.empty_data_MD_fifo_1			(empty[5]),
	.empty_data_fifo_2				(empty[10]),
	.empty_data_MD_fifo_2			(empty[11]),
	.TX_DATA_rd_data_count_1		(TX_DATA_rd_data_count_1),
	.TX_DATA_MD_rd_data_count_1		(TX_DATA_MD_rd_data_count_1),
	.TX_DATA_rd_data_count_2		(TX_DATA_rd_data_count_2),
	.TX_DATA_MD_rd_data_count_2		(TX_DATA_MD_rd_data_count_2),
	.header							(dout_256[63:0]),
	.header_has_data				(dout[5][14]),
	.tx_hdr_vc0_fc0_counter			(tx_hdr_vc0_fc0_counter),
	.tx_hdr_vc0_fc1_counter			(tx_hdr_vc0_fc1_counter),
	.tx_hdr_vc0_fc2_counter			(tx_hdr_vc0_fc2_counter),
	.tx_hdr_vc1_fc0_counter			(tx_hdr_vc1_fc0_counter),
	.tx_hdr_vc1_fc1_counter			(tx_hdr_vc1_fc1_counter),
	.tx_hdr_vc1_fc2_counter			(tx_hdr_vc1_fc2_counter),
	.tx_hdr_vc2_fc0_counter			(tx_hdr_vc2_fc0_counter),
	.tx_hdr_vc2_fc1_counter			(tx_hdr_vc2_fc1_counter),
	.tx_hdr_vc2_fc2_counter			(tx_hdr_vc2_fc2_counter),
	
	.tx_data_vc0_fc0_counter		(tx_data_vc0_fc0_counter),
	.tx_data_vc0_fc1_counter		(tx_data_vc0_fc1_counter),
	.tx_data_vc0_fc2_counter		(tx_data_vc0_fc2_counter),
	.tx_data_vc1_fc0_counter		(tx_data_vc1_fc0_counter),
	.tx_data_vc1_fc1_counter		(tx_data_vc1_fc1_counter),
	.tx_data_vc1_fc2_counter		(tx_data_vc1_fc2_counter),
	.tx_data_vc2_fc0_counter		(tx_data_vc2_fc0_counter),
	.tx_data_vc2_fc1_counter		(tx_data_vc2_fc1_counter),
	.tx_data_vc2_fc2_counter		(tx_data_vc2_fc2_counter),
	.hdr_vc0_fc0					(hdr_vc0_fc0),
	.hdr_vc0_fc1					(hdr_vc0_fc1),
	.hdr_vc0_fc2					(hdr_vc0_fc2),
	.hdr_vc1_fc0					(hdr_vc1_fc0),
	.hdr_vc1_fc1					(hdr_vc1_fc1),
	.hdr_vc1_fc2					(hdr_vc1_fc2),
	.hdr_vc2_fc0					(hdr_vc2_fc0),
	.hdr_vc2_fc1					(hdr_vc2_fc1),
	.hdr_vc2_fc2					(hdr_vc2_fc2),
	.data_vc0_fc0					(data_vc0_fc0),
	.data_vc0_fc1					(data_vc0_fc1),
	.data_vc0_fc2					(data_vc0_fc2),
	.data_vc1_fc0					(data_vc1_fc0),
	.data_vc1_fc1					(data_vc1_fc1),
	.data_vc1_fc2					(data_vc1_fc2),
	.data_vc2_fc0					(data_vc2_fc0),
	.data_vc2_fc1					(data_vc2_fc1),
	.data_vc2_fc2					(data_vc2_fc2),
	.tx_hdr_vc0_fc0_infinite		(tx_hdr_vc0_fc0_infinite),
	.tx_hdr_vc0_fc1_infinite		(tx_hdr_vc0_fc1_infinite),
	.tx_hdr_vc0_fc2_infinite		(tx_hdr_vc0_fc2_infinite),
	.tx_hdr_vc1_fc0_infinite		(tx_hdr_vc1_fc0_infinite),
	.tx_hdr_vc1_fc1_infinite		(tx_hdr_vc1_fc1_infinite),
	.tx_hdr_vc1_fc2_infinite		(tx_hdr_vc1_fc2_infinite),
	.tx_hdr_vc2_fc0_infinite		(tx_hdr_vc2_fc0_infinite),
	.tx_hdr_vc2_fc1_infinite		(tx_hdr_vc2_fc1_infinite),
	.tx_hdr_vc2_fc2_infinite		(tx_hdr_vc2_fc2_infinite),
	.tx_data_vc0_fc0_infinite		(tx_data_vc0_fc0_infinite),
	.tx_data_vc0_fc1_infinite		(tx_data_vc0_fc1_infinite),
	.tx_data_vc0_fc2_infinite		(tx_data_vc0_fc2_infinite),
	.tx_data_vc1_fc0_infinite		(tx_data_vc1_fc0_infinite),
	.tx_data_vc1_fc1_infinite		(tx_data_vc1_fc1_infinite),
	.tx_data_vc1_fc2_infinite		(tx_data_vc1_fc2_infinite),
	.tx_data_vc2_fc0_infinite		(tx_data_vc2_fc0_infinite),
	.tx_data_vc2_fc1_infinite		(tx_data_vc2_fc1_infinite),
	.tx_data_vc2_fc2_infinite		(tx_data_vc2_fc2_infinite),
		
	//.stop_sending_H2D_transactions				(stop_sending_H2D_transactions),
	
	//.H2D_idle									(H2D_idle),
	
	.sfi_tx_data_credit_value		(sfi_tx_data_credit_value),
	.sfi_tx_hdr_block				(sfi_tx_hdr_block),
	.sfi_tx_data_block				(sfi_tx_data_block),
	.rd_hdr_fifo					(rd_hdr_fifo),
	.rd_data_fifo					(rd_data_fifo)

);

  assign rd_en[4] = rd_data_fifo;// & ~sfi_tx_data_block_i;
  //assign rd_en[5] = rd_en[4];
  assign rd_en[5] = rd_hdr_fifo;//  & ~sfi_tx_hdr_block_i;
  //assign rd_en[7] = rd_en[6];
  
  
  RXDESC_to_SFI_fifo_direct   #(  
                          .HPARITY	(HPARITY),
                          .D		(D)                     
                         )
   RXDESC_to_SFI_fifo_direct_inst

( 
	.SFI_clk						(SFI_clk), 
	.SFI_rst_n						(SFI_rst_n), 
	
	.generic_chassis_clk			(generic_chassis_clk), 
	.generic_chassis_rst			(generic_chassis_rst), 
	
	.rx_ack							(direct_desc_rx_ack),
	.rx_ws							(direct_desc_rx_ws),
	.rx_eof							(direct_desc_rx_eof), 

	.rx_req							(direct_desc_rx_req),
	.rx_desc						(direct_desc_rx_desc),
	.rx_dfr							(direct_desc_rx_dfr),
	.rx_dv							(direct_desc_rx_dv),
	.rx_be 							(direct_desc_rx_be),
	.rx_data						(direct_desc_rx_data),  
   
   //the signals that connect to the FIFO's within the SFI xtor
	.direct_rd_rx_fifo				(direct_rd_rx_fifo),
	.direct_dout_rx_fifo			(direct_dout_rx_fifo),
	.direct_empty_rx_fifo			(direct_empty_rx_fifo)

);


SFI_fifo_to_TXDESC_direct  # (
				.D (D)
          )    
   SFI_fifo_to_TXDESC_direct_inst

( 
	.SFI_clk						(SFI_clk), 
	.SFI_rst_n						(SFI_rst_n), 
	
	.generic_chassis_clk			(generic_chassis_clk), 
	.generic_chassis_rst			(generic_chassis_rst), 
	
   //DESC Interface
    .tx_cmd_desc					(direct_desc_tx_cmd_desc),
	.tx_data_desc					(direct_desc_tx_data_desc),
	.tx_req							(direct_desc_tx_req), 
	.tx_dfr							(direct_desc_tx_dfr),
	.tx_ack							(direct_desc_tx_ack),
	.tx_ws							(direct_desc_tx_ws),
	.tx_req_arbiter					(direct_desc_tx_req_arbiter), 
	.tx_ack_arbiter					(direct_desc_tx_ack_arbiter), 
	   
   //the signals that connect to the FIFO's within the SFI xtor
	.direct_wr_tx_fifo				(direct_wr_tx_fifo),
	.direct_din_tx_fifo				(direct_din_tx_fifo),
	.direct_full_tx_fifo			(direct_full_tx_fifo)

);
  
  endmodule // SFI_Transactor_top

