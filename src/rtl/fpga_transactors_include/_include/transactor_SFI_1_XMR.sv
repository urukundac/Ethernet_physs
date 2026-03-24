//=================================================================================================================================
// SFI connections - USER MUST EDIT THE RIGHT HAND SIDE OF THE FOLLOWING ASSIGNMENTS AND DEFINE - WHEN THIS TRANSACTOR IS USED
//=================================================================================================================================
// SFI   connection #1


							`define 	SFI_1 									  fpga_transactors_top_inst   // example:  fpga_tcss_top.tcss_val_rtl.tcss.par_iom    //HERE USER SHOULD SET THE PATH TO HIS SIDE OF THE SFI INTEFACE
						
assign 				  		`TRANSACTORS_PATH.sfi_clk[1] 						= `SFI_1.sfi_clk_1;
assign 				  		`TRANSACTORS_PATH.rst_sfi_n[1] 						= `SFI_1.rst_sfi_n_1;



//inputs to FGT
assign                  	`TRANSACTORS_PATH.sfi_rx_txcon_req[1]     			= `SFI_1.sfi_rx_txcon_req_1;

assign                  	`TRANSACTORS_PATH.sfi_tx_rxcon_ack[1]     			= `SFI_1.sfi_tx_rxcon_ack_1;
assign                  	`TRANSACTORS_PATH.sfi_tx_rxdiscon_nack[1]   		= `SFI_1.sfi_tx_rxdiscon_nack_1;
assign                  	`TRANSACTORS_PATH.sfi_tx_rx_empty[1]     		  	= `SFI_1.sfi_tx_rx_empty_1;

assign                  	`TRANSACTORS_PATH.sfi_rx_hdr_valid[1]     			= `SFI_1.sfi_rx_hdr_valid_1;
assign                  	`TRANSACTORS_PATH.sfi_rx_hdr_early_valid[1]     = `SFI_1.sfi_rx_hdr_early_valid_1;
assign                  	`TRANSACTORS_PATH.sfi_rx_header[1]     				  = `SFI_1.sfi_rx_header_1;
assign                  	`TRANSACTORS_PATH.sfi_rx_hdr_info_bytes[1]     	= `SFI_1.sfi_rx_hdr_info_bytes_1;
assign                  	`TRANSACTORS_PATH.sfi_rx_hdr_crd_rtn_block[1]   = `SFI_1.sfi_rx_hdr_crd_rtn_block_1;

assign                  	`TRANSACTORS_PATH.sfi_rx_data_valid[1]     			= `SFI_1.sfi_rx_data_valid_1;
assign                  	`TRANSACTORS_PATH.sfi_rx_data_early_valid[1]    = `SFI_1.sfi_rx_data_early_valid_1;
assign                  	`TRANSACTORS_PATH.sfi_rx_data[1]     				    = `SFI_1.sfi_rx_data_1;
assign                  	`TRANSACTORS_PATH.sfi_rx_data_parity[1]     		= `SFI_1.sfi_rx_data_parity_1;
assign                  	`TRANSACTORS_PATH.sfi_rx_data_start[1]     			= `SFI_1.sfi_rx_data_start_1;
assign                  	`TRANSACTORS_PATH.sfi_rx_data_info_byte[1]     	= `SFI_1.sfi_rx_data_info_byte_1;
assign                  	`TRANSACTORS_PATH.sfi_rx_data_end[1]     			  = `SFI_1.sfi_rx_data_end_1;
assign                  	`TRANSACTORS_PATH.sfi_rx_data_poison[1]     		= `SFI_1.sfi_rx_data_poison_1;
assign                  	`TRANSACTORS_PATH.sfi_rx_data_edb[1]     			  = `SFI_1.sfi_rx_data_edb_1;
assign                  	`TRANSACTORS_PATH.sfi_rx_data_aux_parity[1]     = `SFI_1.sfi_rx_data_aux_parity_1;
assign                  	`TRANSACTORS_PATH.sfi_rx_data_crd_rtn_block[1]  = `SFI_1.sfi_rx_data_crd_rtn_block_1;

assign                  	`TRANSACTORS_PATH.sfi_tx_hdr_block[1]     			= `SFI_1.sfi_tx_hdr_block_1;
assign                  	`TRANSACTORS_PATH.sfi_tx_hdr_crd_rtn_valid[1]   = `SFI_1.sfi_tx_hdr_crd_rtn_valid_1;
assign                  	`TRANSACTORS_PATH.sfi_tx_hdr_crd_rtn_ded[1]     = `SFI_1.sfi_tx_hdr_crd_rtn_ded_1;
assign                  	`TRANSACTORS_PATH.sfi_tx_hdr_crd_rtn_fc_id[1]   = `SFI_1.sfi_tx_hdr_crd_rtn_fc_id_1;
assign                  	`TRANSACTORS_PATH.sfi_tx_hdr_crd_rtn_vc_id[1]   = `SFI_1.sfi_tx_hdr_crd_rtn_vc_id_1;
assign                  	`TRANSACTORS_PATH.sfi_tx_hdr_crd_rtn_value[1]   = `SFI_1.sfi_tx_hdr_crd_rtn_value_1;

assign                  	`TRANSACTORS_PATH.sfi_tx_data_block[1]     			= `SFI_1.sfi_tx_data_block_1;
assign                  	`TRANSACTORS_PATH.sfi_tx_data_crd_rtn_valid[1]	= `SFI_1.sfi_tx_data_crd_rtn_valid_1;
assign                  	`TRANSACTORS_PATH.sfi_tx_data_crd_rtn_ded[1]		= `SFI_1.sfi_tx_data_crd_rtn_ded_1;
assign                  	`TRANSACTORS_PATH.sfi_tx_data_crd_rtn_fc_id[1]  = `SFI_1.sfi_tx_data_crd_rtn_fc_id_1;
assign                  	`TRANSACTORS_PATH.sfi_tx_data_crd_rtn_vc_id[1]	= `SFI_1.sfi_tx_data_crd_rtn_vc_id_1;
assign                  	`TRANSACTORS_PATH.sfi_tx_data_crd_rtn_value[1]  = `SFI_1.sfi_tx_data_crd_rtn_value_1;

//=================================================================================================================================
// SFI connections - USER MUST EDIT THE LEFT HAND SIDE OF THE FOLLOWING ASSIGNMENTS  - WHEN THIS TRANSACTOR IS USED
//=================================================================================================================================


//outputs from FGT
assign  				 	`SFI_1.sfi_rx_rxcon_ack_1							=	`TRANSACTORS_PATH.sfi_rx_rxcon_ack[1];
assign  				 	`SFI_1.sfi_rx_rxdiscon_nack_1					=	`TRANSACTORS_PATH.sfi_rx_rxdiscon_nack[1];
assign  				 	`SFI_1.sfi_rx_rx_empty_1							=	`TRANSACTORS_PATH.sfi_rx_rx_empty[1];
assign  				 	`SFI_1.sfi_tx_txcon_req_1							=	`TRANSACTORS_PATH.sfi_tx_txcon_req[1];
assign  				 	`SFI_1.sfi_rx_hdr_block_1							=	`TRANSACTORS_PATH.sfi_rx_hdr_block[1];
assign  				 	`SFI_1.sfi_rx_hdr_crd_rtn_valid_1			=	`TRANSACTORS_PATH.sfi_rx_hdr_crd_rtn_valid[1];
assign  				 	`SFI_1.sfi_rx_hdr_crd_rtn_ded_1				=	`TRANSACTORS_PATH.sfi_rx_hdr_crd_rtn_ded[1];
assign  				 	`SFI_1.sfi_rx_hdr_crd_rtn_fc_id_1		  =	`TRANSACTORS_PATH.sfi_rx_hdr_crd_rtn_fc_id[1];
assign  				 	`SFI_1.sfi_rx_hdr_crd_rtn_vc_id_1			=	`TRANSACTORS_PATH.sfi_rx_hdr_crd_rtn_vc_id[1];
assign						`SFI_1.sfi_rx_hdr_crd_rtn_value_1			=	`TRANSACTORS_PATH.sfi_rx_hdr_crd_rtn_value[1];

assign  				 	`SFI_1.sfi_rx_data_block_1						=	`TRANSACTORS_PATH.sfi_rx_data_block[1];
assign  				 	`SFI_1.sfi_rx_data_crd_rtn_valid_1		=	`TRANSACTORS_PATH.sfi_rx_data_crd_rtn_valid[1];
assign  				 	`SFI_1.sfi_rx_data_crd_rtn_ded_1			=	`TRANSACTORS_PATH.sfi_rx_data_crd_rtn_ded[1];
assign  				 	`SFI_1.sfi_rx_data_crd_rtn_fc_id_1		=	`TRANSACTORS_PATH.sfi_rx_data_crd_rtn_fc_id[1];
assign  				 	`SFI_1.sfi_rx_data_crd_rtn_vc_id_1		=	`TRANSACTORS_PATH.sfi_rx_data_crd_rtn_vc_id[1];
assign  				 	`SFI_1.sfi_rx_data_crd_rtn_value_1		=	`TRANSACTORS_PATH.sfi_rx_data_crd_rtn_value[1];
assign  				 	`SFI_1.sfi_tx_hdr_valid_1							=	`TRANSACTORS_PATH.sfi_tx_hdr_valid[1];
assign  				 	`SFI_1.sfi_tx_hdr_early_valid_1				=	`TRANSACTORS_PATH.sfi_tx_hdr_early_valid[1];
assign  				 	`SFI_1.sfi_tx_header_1								=	`TRANSACTORS_PATH.sfi_tx_header[1];
assign  				 	`SFI_1.sfi_tx_hdr_info_bytes_1				=	`TRANSACTORS_PATH.sfi_tx_hdr_info_bytes[1];
assign  				 	`SFI_1.sfi_tx_hdr_crd_rtn_block_1			=	`TRANSACTORS_PATH.sfi_tx_hdr_crd_rtn_block[1];
assign  				 	`SFI_1.sfi_tx_data_valid_1						=	`TRANSACTORS_PATH.sfi_tx_data_valid[1];
assign  				 	`SFI_1.sfi_tx_data_early_valid_1			=	`TRANSACTORS_PATH.sfi_tx_data_early_valid[1];
assign  				 	`SFI_1.sfi_tx_data_1								  =	`TRANSACTORS_PATH.sfi_tx_data[1];
assign  				 	`SFI_1.sfi_tx_data_parity_1						=	`TRANSACTORS_PATH.sfi_tx_data_parity[1];
assign  				 	`SFI_1.sfi_tx_data_start_1						=	`TRANSACTORS_PATH.sfi_tx_data_start[1];
assign  				 	`SFI_1.sfi_tx_data_info_byte_1				=	`TRANSACTORS_PATH.sfi_tx_data_info_byte[1];
assign  				 	`SFI_1.sfi_tx_data_end_1							=	`TRANSACTORS_PATH.sfi_tx_data_end[1];
assign  				 	`SFI_1.sfi_tx_data_poison_1						=	`TRANSACTORS_PATH.sfi_tx_data_poison[1];
assign  				 	`SFI_1.sfi_tx_data_edb_1							=	`TRANSACTORS_PATH.sfi_tx_data_edb[1];
assign  				 	`SFI_1.sfi_tx_data_aux_parity_1				=	`TRANSACTORS_PATH.sfi_tx_data_aux_parity[1];
assign  				 	`SFI_1.sfi_tx_data_crd_rtn_block_1		=	`TRANSACTORS_PATH.sfi_tx_data_crd_rtn_block[1];

//=================================================================================================================================


	
