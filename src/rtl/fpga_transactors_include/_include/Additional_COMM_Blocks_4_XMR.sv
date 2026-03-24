//`ifndef FPGA_SYNTH
`define TRANSACTORS_PATH fpga_transactors_top_inst
//`endif
//====================================================================================================================================================
// Additional COMM Block connections - USER MUST EDIT THE RIGHT HAND SIDE OF THE FOLLOWING ASSIGNMENTS AND DEFINE - WHEN THIS FEATURE IS USED     	==
//                                                        ---------------																			==
//																																					==
//====================================================================================================================================================
// Additional COMM Block   connection #4


			`define 	ADDITIONAL_COMM_BLOCK_4 					fpga_transactors_top_inst   // example:  fpga_tcss_top.tcss_val_rtl.tcss.par_iom    //HERE USER SHOULD SET THE PATH TO HIS SIDE OF THE ADDITIONAL COMM BLOCK FIFO INTERFACE
						

//inputs to FGT - to the Additional COMM Block
assign                  	`TRANSACTORS_PATH.rd_rx_fifo[START_OF_ADDITIONAL_COMM_BLOCKS+4][(NUM_OF_RX_FIFO[START_OF_ADDITIONAL_COMM_BLOCKS+4]-1):0]     		= `ADDITIONAL_COMM_BLOCK_4.rd_rx_fifo_0;
assign                  	`TRANSACTORS_PATH.wr_tx_fifo[START_OF_ADDITIONAL_COMM_BLOCKS+4][(NUM_OF_TX_FIFO[START_OF_ADDITIONAL_COMM_BLOCKS+4]-1):0]     		= `ADDITIONAL_COMM_BLOCK_4.wr_tx_fifo_0;
assign   /*[127:0]*/       	`TRANSACTORS_PATH.din_tx_fifo[START_OF_ADDITIONAL_COMM_BLOCKS+4][(NUM_OF_TX_FIFO[START_OF_ADDITIONAL_COMM_BLOCKS+4]-1):0]     		= `ADDITIONAL_COMM_BLOCK_4.din_tx_fifo_0;

//USER CAN USE THIS AXI-MM INTERFACE IF HE WANTS. IF NOT - JUST KEEP IT TIED TO 0
assign                  	`TRANSACTORS_PATH.client_aximm_awready[START_OF_ADDITIONAL_COMM_BLOCKS+4]		=	'b0;  //`ADDITIONAL_COMM_BLOCK_4.client_aximm_awready;
assign                  	`TRANSACTORS_PATH.client_aximm_wready[START_OF_ADDITIONAL_COMM_BLOCKS+4]		=	'b0;  //`ADDITIONAL_COMM_BLOCK_4.client_aximm_wready;
assign                  	`TRANSACTORS_PATH.client_aximm_bvalid[START_OF_ADDITIONAL_COMM_BLOCKS+4]		=	'b0;  //`ADDITIONAL_COMM_BLOCK_4.client_aximm_bvalid;
assign   /*[7:0]*/         	`TRANSACTORS_PATH.client_aximm_bid[START_OF_ADDITIONAL_COMM_BLOCKS+4]			=	'b0;  //`ADDITIONAL_COMM_BLOCK_4.client_aximm_bid;
assign   /*[1:0]*/         	`TRANSACTORS_PATH.client_aximm_bresp[START_OF_ADDITIONAL_COMM_BLOCKS+4]			=	'b0;  //`ADDITIONAL_COMM_BLOCK_4.client_aximm_bresp;
assign                  	`TRANSACTORS_PATH.client_aximm_arready[START_OF_ADDITIONAL_COMM_BLOCKS+4]		=	'b0;  //`ADDITIONAL_COMM_BLOCK_4.client_aximm_arready;
assign                  	`TRANSACTORS_PATH.client_aximm_rvalid[START_OF_ADDITIONAL_COMM_BLOCKS+4]		=	'b0;  //`ADDITIONAL_COMM_BLOCK_4.client_aximm_rvalid;
assign   /*[7:0]*/         	`TRANSACTORS_PATH.client_aximm_rid[START_OF_ADDITIONAL_COMM_BLOCKS+4]			=	'b0;  //`ADDITIONAL_COMM_BLOCK_4.client_aximm_rid;
assign   /*[127:0]*/       	`TRANSACTORS_PATH.client_aximm_rdata[START_OF_ADDITIONAL_COMM_BLOCKS+4]			=	'b0;  //`ADDITIONAL_COMM_BLOCK_4.client_aximm_rdata;
assign   /*[1:0]*/         	`TRANSACTORS_PATH.client_aximm_rresp[START_OF_ADDITIONAL_COMM_BLOCKS+4]			=	'b0;  //`ADDITIONAL_COMM_BLOCK_4.client_aximm_rresp;
assign                  	`TRANSACTORS_PATH.client_aximm_rlast[START_OF_ADDITIONAL_COMM_BLOCKS+4]			=	'b0;  //`ADDITIONAL_COMM_BLOCK_4.client_aximm_rlast;

//===================================================================================================================================
// Additional COMM Block connections - USER MUST EDIT THE LEFT HAND SIDE OF THE FOLLOWING ASSIGNMENTS  - WHEN THIS FEATURE IS USED ==
//                                                      --------------															   ==
//																																   ==
//===================================================================================================================================

//outputs from FGT - from the Additional COMM Block
assign   /*[127:0]*/ 	 	`ADDITIONAL_COMM_BLOCK_4.dout_rx_fifo_0			= `TRANSACTORS_PATH.dout_rx_fifo[START_OF_ADDITIONAL_COMM_BLOCKS+4][(NUM_OF_RX_FIFO[START_OF_ADDITIONAL_COMM_BLOCKS+4]-1):0];
assign  				 	`ADDITIONAL_COMM_BLOCK_4.empty_rx_fifo_0		= `TRANSACTORS_PATH.empty_rx_fifo[START_OF_ADDITIONAL_COMM_BLOCKS+4][(NUM_OF_RX_FIFO[START_OF_ADDITIONAL_COMM_BLOCKS+4]-1):0];
assign  				 	`ADDITIONAL_COMM_BLOCK_4.full_tx_fifo_0			= `TRANSACTORS_PATH.full_tx_fifo[START_OF_ADDITIONAL_COMM_BLOCKS+4][(NUM_OF_TX_FIFO[START_OF_ADDITIONAL_COMM_BLOCKS+4]-1):0];

//USER CAN USE THIS AXI-MM INTERFACE IF HE WANTS. IF NOT - JUST KEEP IT IN COMMENT
//assign                  	`ADDITIONAL_COMM_BLOCK_4.client_aximm_awvalid	= `TRANSACTORS_PATH.client_aximm_awvalid[START_OF_ADDITIONAL_COMM_BLOCKS+4];
//assign   /*[7:0]*/       	`ADDITIONAL_COMM_BLOCK_4.client_aximm_awid		= `TRANSACTORS_PATH.client_aximm_awid[START_OF_ADDITIONAL_COMM_BLOCKS+4];
//assign   /*[15:0]*/      	`ADDITIONAL_COMM_BLOCK_4.client_aximm_awaddr	= `TRANSACTORS_PATH.client_aximm_awaddr[START_OF_ADDITIONAL_COMM_BLOCKS+4];
//assign   /*[7:0]*/       	`ADDITIONAL_COMM_BLOCK_4.client_aximm_awlen		= `TRANSACTORS_PATH.client_aximm_awlen[START_OF_ADDITIONAL_COMM_BLOCKS+4];
//assign   /*[2:0]*/       	`ADDITIONAL_COMM_BLOCK_4.client_aximm_awsize	= `TRANSACTORS_PATH.client_aximm_awsize[START_OF_ADDITIONAL_COMM_BLOCKS+4];
//assign   /*[1:0]*/       	`ADDITIONAL_COMM_BLOCK_4.client_aximm_awburst	= `TRANSACTORS_PATH.client_aximm_awburst[START_OF_ADDITIONAL_COMM_BLOCKS+4];
//assign                  	`ADDITIONAL_COMM_BLOCK_4.client_aximm_awlock	= `TRANSACTORS_PATH.client_aximm_awlock[START_OF_ADDITIONAL_COMM_BLOCKS+4];
//assign   /*[3:0]*/       	`ADDITIONAL_COMM_BLOCK_4.client_aximm_awcache	= `TRANSACTORS_PATH.client_aximm_awcache[START_OF_ADDITIONAL_COMM_BLOCKS+4];
//assign   /*[2:0]*/       	`ADDITIONAL_COMM_BLOCK_4.client_aximm_awprot	= `TRANSACTORS_PATH.client_aximm_awprot[START_OF_ADDITIONAL_COMM_BLOCKS+4];
//assign   /*[3:0]*/       	`ADDITIONAL_COMM_BLOCK_4.client_aximm_awqos		= `TRANSACTORS_PATH.client_aximm_awqos[START_OF_ADDITIONAL_COMM_BLOCKS+4];
//assign                  	`ADDITIONAL_COMM_BLOCK_4.client_aximm_wvalid	= `TRANSACTORS_PATH.client_aximm_wvalid[START_OF_ADDITIONAL_COMM_BLOCKS+4];
//assign                  	`ADDITIONAL_COMM_BLOCK_4.client_aximm_wlast		= `TRANSACTORS_PATH.client_aximm_wlast[START_OF_ADDITIONAL_COMM_BLOCKS+4];
//assign   /*[127:0]*/     	`ADDITIONAL_COMM_BLOCK_4.client_aximm_wdata		= `TRANSACTORS_PATH.client_aximm_wdata[START_OF_ADDITIONAL_COMM_BLOCKS+4];
//assign   /*[15:0]*/      	`ADDITIONAL_COMM_BLOCK_4.client_aximm_wstrb		= `TRANSACTORS_PATH.client_aximm_wstrb[START_OF_ADDITIONAL_COMM_BLOCKS+4];
//assign          			`ADDITIONAL_COMM_BLOCK_4.client_aximm_bready	= `TRANSACTORS_PATH.client_aximm_bready[START_OF_ADDITIONAL_COMM_BLOCKS+4];
//assign            		`ADDITIONAL_COMM_BLOCK_4.client_aximm_arvalid	= `TRANSACTORS_PATH.client_aximm_arvalid[START_OF_ADDITIONAL_COMM_BLOCKS+4];
//assign   /*[7:0]*/       	`ADDITIONAL_COMM_BLOCK_4.client_aximm_arid		= `TRANSACTORS_PATH.client_aximm_arid[START_OF_ADDITIONAL_COMM_BLOCKS+4];
//assign   /*[15:0]*/      	`ADDITIONAL_COMM_BLOCK_4.client_aximm_araddr	= `TRANSACTORS_PATH.client_aximm_araddr[START_OF_ADDITIONAL_COMM_BLOCKS+4];
//assign   /*[7:0]*/       	`ADDITIONAL_COMM_BLOCK_4.client_aximm_arlen		= `TRANSACTORS_PATH.client_aximm_arlen[START_OF_ADDITIONAL_COMM_BLOCKS+4];
//assign   /*[2:0]*/       	`ADDITIONAL_COMM_BLOCK_4.client_aximm_arsize	= `TRANSACTORS_PATH.client_aximm_arsize[START_OF_ADDITIONAL_COMM_BLOCKS+4];
//assign   /*[1:0]*/       	`ADDITIONAL_COMM_BLOCK_4.client_aximm_arburst	= `TRANSACTORS_PATH.client_aximm_arburst[START_OF_ADDITIONAL_COMM_BLOCKS+4];
//assign            		`ADDITIONAL_COMM_BLOCK_4.client_aximm_arlock	= `TRANSACTORS_PATH.client_aximm_arlock[START_OF_ADDITIONAL_COMM_BLOCKS+4];
//assign   /*[3:0]*/       	`ADDITIONAL_COMM_BLOCK_4.client_aximm_arcache	= `TRANSACTORS_PATH.client_aximm_arcache[START_OF_ADDITIONAL_COMM_BLOCKS+4];
//assign   /*[2:0]*/       	`ADDITIONAL_COMM_BLOCK_4.client_aximm_arprot	= `TRANSACTORS_PATH.client_aximm_arprot[START_OF_ADDITIONAL_COMM_BLOCKS+4];
//assign   /*[3:0]*/       	`ADDITIONAL_COMM_BLOCK_4.client_aximm_arqos		= `TRANSACTORS_PATH.client_aximm_arqos[START_OF_ADDITIONAL_COMM_BLOCKS+4];
//assign          			`ADDITIONAL_COMM_BLOCK_4.client_aximm_rready	= `TRANSACTORS_PATH.client_aximm_rready[START_OF_ADDITIONAL_COMM_BLOCKS+4];


//=================================================================================================================================


//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//  																								   ///////////////////////////////////
//  USER SHOULD NOT TOUCH THE FOLLOWING LINES!!      USER SHOULD NOT TOUCH THE FOLLOWING LINES!!       ///////////////////////////////////
//  		    ---                                              ---     							   ///////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
																																	//////
																																	//////
        assign wr_tx_fifo  [START_OF_ADDITIONAL_COMM_BLOCKS+4][14:(NUM_OF_TX_FIFO[START_OF_ADDITIONAL_COMM_BLOCKS+4])] 		= 'b0;	//////
		assign din_tx_fifo [START_OF_ADDITIONAL_COMM_BLOCKS+4][14:(NUM_OF_TX_FIFO[START_OF_ADDITIONAL_COMM_BLOCKS+4])] 		= 'b0;	//////
        assign rd_rx_fifo  [START_OF_ADDITIONAL_COMM_BLOCKS+4][14:(NUM_OF_RX_FIFO[START_OF_ADDITIONAL_COMM_BLOCKS+4])] 		= 'b0;	//////
																																	//////
        assign axi_rq_tdata_client[START_OF_ADDITIONAL_COMM_BLOCKS+4]  														= 'b0;	//////
		assign axi_rq_tkeep_client[START_OF_ADDITIONAL_COMM_BLOCKS+4]  														= 'b0;	//////
		assign axi_rq_tlast_client[START_OF_ADDITIONAL_COMM_BLOCKS+4]  														= 'b0;	//////
		assign axi_rq_tuser_client[START_OF_ADDITIONAL_COMM_BLOCKS+4]  														= 'b0;	//////
		assign axi_rq_tvalid_client[START_OF_ADDITIONAL_COMM_BLOCKS+4] 														= 'b0;	//////
		assign axi_rc_tready_client[START_OF_ADDITIONAL_COMM_BLOCKS+4] 														= 'b0;	//////
																																	//////
		assign direct_axis_rx_tready_comm_block_to_client[START_OF_ADDITIONAL_COMM_BLOCKS+4] 								= 'b0;	//////
		assign direct_axis_tx_tdata_client_to_comm_block[START_OF_ADDITIONAL_COMM_BLOCKS+4] 								= 'b0;	//////
		assign direct_axis_tx_tkeep_client_to_comm_block[START_OF_ADDITIONAL_COMM_BLOCKS+4] 								= 'b0;	//////
		assign direct_axis_tx_tlast_client_to_comm_block[START_OF_ADDITIONAL_COMM_BLOCKS+4] 								= 'b0;	//////
		assign direct_axis_tx_tvalid_client_to_comm_block[START_OF_ADDITIONAL_COMM_BLOCKS+4] 								= 'b0;	//////
		assign direct_axis_tx_tuser_client_to_comm_block[START_OF_ADDITIONAL_COMM_BLOCKS+4] 								= 'b0;	//////
																																	//////
																																	//////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////		
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////			
		
