//=================================================================================================================================
// SFI connections - USER MUST EDIT THE RIGHT HAND SIDE OF THE FOLLOWING ASSIGNMENTS AND DEFINE - WHEN THIS TRANSACTOR IS USED
//=================================================================================================================================
// SFI   connection #0


							`define 	SFI_2 					`FPGA_TRANSACTORS_TOP   // example:  fpga_tcss_top.tcss_val_rtl.tcss.par_iom    //HERE USER SHOULD SET THE PATH TO HIS SIDE OF THE SFI INTEFACE
						
assign 				  		`TRANSACTORS_PATH.sfi_clk[2] 									= `SFI_2.sfi_clk_2;
assign 				  		`TRANSACTORS_PATH.rst_sfi_n[2] 									= `SFI_2.rst_sfi_n_2;



//inputs to FGT
assign                  	`TRANSACTORS_PATH.sfi_rx_txcon_req[2]     						= `SFI_2.sfi_rx_txcon_req_2;

assign                  	`TRANSACTORS_PATH.sfi_tx_rxcon_ack[2]     						= `SFI_2.sfi_tx_rxcon_ack_2;
assign                  	`TRANSACTORS_PATH.sfi_tx_rxdiscon_nack[2]   					= `SFI_2.sfi_tx_rxdiscon_nack_2;
assign                  	`TRANSACTORS_PATH.sfi_tx_rx_empty[2]     						= `SFI_2.sfi_tx_rx_empty_2;

assign                  	`TRANSACTORS_PATH.sfi_rx_hdr_valid[2]     						= `SFI_2.sfi_rx_hdr_valid_2;
assign                  	`TRANSACTORS_PATH.sfi_rx_hdr_early_valid[2]     				= `SFI_2.sfi_rx_hdr_early_valid_2;
assign                  	`TRANSACTORS_PATH.sfi_rx_header[2]     							= `SFI_2.sfi_rx_header_2;
assign                  	`TRANSACTORS_PATH.sfi_rx_hdr_info_bytes[2]     					= `SFI_2.sfi_rx_hdr_info_bytes_2;
assign                  	`TRANSACTORS_PATH.sfi_rx_hdr_crd_rtn_block[2]     				= `SFI_2.sfi_rx_hdr_crd_rtn_block_2;

assign                  	`TRANSACTORS_PATH.sfi_rx_data_valid[2]     						= `SFI_2.sfi_rx_data_valid_2;
assign                  	`TRANSACTORS_PATH.sfi_rx_data_early_valid[2]     				= `SFI_2.sfi_rx_data_early_valid_2;
assign                  	`TRANSACTORS_PATH.sfi_rx_data[2][SFI_D_SRC_2*8-1:0]     			= `SFI_2.sfi_rx_data_2;
assign                  	`TRANSACTORS_PATH.sfi_rx_data_parity[2][SFI_D_SRC_2/8-1:0]   		= `SFI_2.sfi_rx_data_parity_2;
assign                  	`TRANSACTORS_PATH.sfi_rx_data_start[2]     						= `SFI_2.sfi_rx_data_start_2;
assign                  	`TRANSACTORS_PATH.sfi_rx_data_info_byte[2]     					= `SFI_2.sfi_rx_data_info_byte_2;
assign                  	`TRANSACTORS_PATH.sfi_rx_data_end[2][SFI_D_SRC_2/4-1:0]     		= `SFI_2.sfi_rx_data_end_2;
assign                  	`TRANSACTORS_PATH.sfi_rx_data_poison[2][SFI_D_SRC_2/4-1:0]     	= `SFI_2.sfi_rx_data_poison_2;
assign                  	`TRANSACTORS_PATH.sfi_rx_data_edb[2][SFI_D_SRC_2/4-1:0]     		= `SFI_2.sfi_rx_data_edb_2;
assign                  	`TRANSACTORS_PATH.sfi_rx_data_aux_parity[2]     				= `SFI_2.sfi_rx_data_aux_parity_2;
assign                  	`TRANSACTORS_PATH.sfi_rx_data_crd_rtn_block[2]     				= `SFI_2.sfi_rx_data_crd_rtn_block_2;

assign                  	`TRANSACTORS_PATH.sfi_tx_hdr_block[2]     						= `SFI_2.sfi_tx_hdr_block_2;
assign                  	`TRANSACTORS_PATH.sfi_tx_hdr_crd_rtn_valid[2]     				= `SFI_2.sfi_tx_hdr_crd_rtn_valid_2;
assign                  	`TRANSACTORS_PATH.sfi_tx_hdr_crd_rtn_ded[2]     				= `SFI_2.sfi_tx_hdr_crd_rtn_ded_2;
assign                  	`TRANSACTORS_PATH.sfi_tx_hdr_crd_rtn_fc_id[2]     				= `SFI_2.sfi_tx_hdr_crd_rtn_fc_id_2;
assign                  	`TRANSACTORS_PATH.sfi_tx_hdr_crd_rtn_vc_id[2]     				= `SFI_2.sfi_tx_hdr_crd_rtn_vc_id_2;
assign                  	`TRANSACTORS_PATH.sfi_tx_hdr_crd_rtn_value[2]     				= `SFI_2.sfi_tx_hdr_crd_rtn_value_2;

assign                  	`TRANSACTORS_PATH.sfi_tx_data_block[2]     						= `SFI_2.sfi_tx_data_block_2;
assign                  	`TRANSACTORS_PATH.sfi_tx_data_crd_rtn_valid[2]					= `SFI_2.sfi_tx_data_crd_rtn_valid_2;
assign                  	`TRANSACTORS_PATH.sfi_tx_data_crd_rtn_ded[2]					= `SFI_2.sfi_tx_data_crd_rtn_ded_2;
assign                  	`TRANSACTORS_PATH.sfi_tx_data_crd_rtn_fc_id[2]     				= `SFI_2.sfi_tx_data_crd_rtn_fc_id_2;
assign                  	`TRANSACTORS_PATH.sfi_tx_data_crd_rtn_vc_id[2]	    			= `SFI_2.sfi_tx_data_crd_rtn_vc_id_2;
assign                  	`TRANSACTORS_PATH.sfi_tx_data_crd_rtn_value[2]     				= `SFI_2.sfi_tx_data_crd_rtn_value_2;

//=================================================================================================================================
// SFI connections - USER MUST EDIT THE LEFT HAND SIDE OF THE FOLLOWING ASSIGNMENTS  - WHEN THIS TRANSACTOR IS USED
//=================================================================================================================================


//outputs from FGT
assign  				 	`SFI_2.sfi_rx_rxcon_ack_2										=	`TRANSACTORS_PATH.sfi_rx_rxcon_ack[2]     	;
assign  				 	`SFI_2.sfi_rx_rxdiscon_nack_2									=	`TRANSACTORS_PATH.sfi_rx_rxdiscon_nack[2]     		;
assign  				 	`SFI_2.sfi_rx_rx_empty_2										=	`TRANSACTORS_PATH.sfi_rx_rx_empty[2]     		;
			
assign  				 	`SFI_2.sfi_tx_txcon_req_2										=	`TRANSACTORS_PATH.sfi_tx_txcon_req[2]     		;

assign  				 	`SFI_2.sfi_rx_hdr_block_2										=	`TRANSACTORS_PATH.sfi_rx_hdr_block[2]     				;
assign  				 	`SFI_2.sfi_rx_hdr_crd_rtn_valid_2								=	`TRANSACTORS_PATH.sfi_rx_hdr_crd_rtn_valid[2]     				;
assign  				 	`SFI_2.sfi_rx_hdr_crd_rtn_ded_2									=	`TRANSACTORS_PATH.sfi_rx_hdr_crd_rtn_ded[2]     				;
assign  				 	`SFI_2.sfi_rx_hdr_crd_rtn_fc_id_2								=	`TRANSACTORS_PATH.sfi_rx_hdr_crd_rtn_fc_id[2]     		;
assign  				 	`SFI_2.sfi_rx_hdr_crd_rtn_vc_id_2								=	`TRANSACTORS_PATH.sfi_rx_hdr_crd_rtn_vc_id[2]     			;
assign						`SFI_2.sfi_rx_hdr_crd_rtn_value_2								=	`TRANSACTORS_PATH.sfi_rx_hdr_crd_rtn_value[2]				;

assign  				 	`SFI_2.sfi_rx_data_block_2										=	`TRANSACTORS_PATH.sfi_rx_data_block[2]     			;
assign  				 	`SFI_2.sfi_rx_data_crd_rtn_valid_2								=	`TRANSACTORS_PATH.sfi_rx_data_crd_rtn_valid[2]     				;
assign  				 	`SFI_2.sfi_rx_data_crd_rtn_ded_2								=	`TRANSACTORS_PATH.sfi_rx_data_crd_rtn_ded[2]     			;
assign  				 	`SFI_2.sfi_rx_data_crd_rtn_fc_id_2								=	`TRANSACTORS_PATH.sfi_rx_data_crd_rtn_fc_id[2]     			;
assign  				 	`SFI_2.sfi_rx_data_crd_rtn_vc_id_2								=	`TRANSACTORS_PATH.sfi_rx_data_crd_rtn_vc_id[2]    		 	;
assign  				 	`SFI_2.sfi_rx_data_crd_rtn_value_2								=	`TRANSACTORS_PATH.sfi_rx_data_crd_rtn_value[2]     				;

assign  				 	`SFI_2.sfi_tx_hdr_valid_2										=	`TRANSACTORS_PATH.sfi_tx_hdr_valid[2]     		;
assign  				 	`SFI_2.sfi_tx_hdr_early_valid_2									=	`TRANSACTORS_PATH.sfi_tx_hdr_early_valid[2]     			;
assign  				 	`SFI_2.sfi_tx_header_2											=	`TRANSACTORS_PATH.sfi_tx_header[2]     			;
assign  				 	`SFI_2.sfi_tx_hdr_info_bytes_2									=	`TRANSACTORS_PATH.sfi_tx_hdr_info_bytes[2]     				;
assign  				 	`SFI_2.sfi_tx_hdr_crd_rtn_block_2								=	`TRANSACTORS_PATH.sfi_tx_hdr_crd_rtn_block[2]     				;

assign  				 	`SFI_2.sfi_tx_data_valid_2										=	`TRANSACTORS_PATH.sfi_tx_data_valid[2]     				;
assign  				 	`SFI_2.sfi_tx_data_early_valid_2								=	`TRANSACTORS_PATH.sfi_tx_data_early_valid[2]     			;
assign  				 	`SFI_2.sfi_tx_data_2											=	`TRANSACTORS_PATH.sfi_tx_data[2][SFI_D_SRC_2*8-1:0]     				;
assign  				 	`SFI_2.sfi_tx_data_parity_2										=	`TRANSACTORS_PATH.sfi_tx_data_parity[2][SFI_D_SRC_2/8-1:0]   		 	 	;
assign  				 	`SFI_2.sfi_tx_data_start_2										=	`TRANSACTORS_PATH.sfi_tx_data_start[2]     				;
assign  				 	`SFI_2.sfi_tx_data_info_byte_2									=	`TRANSACTORS_PATH.sfi_tx_data_info_byte[2]     	;
assign  				 	`SFI_2.sfi_tx_data_end_2										=	`TRANSACTORS_PATH.sfi_tx_data_end[2][SFI_D_SRC_2/4-1:0]     	;
assign  				 	`SFI_2.sfi_tx_data_poison_2										=	`TRANSACTORS_PATH.sfi_tx_data_poison[2][SFI_D_SRC_2/4-1:0]     	;
assign  				 	`SFI_2.sfi_tx_data_edb_2										=	`TRANSACTORS_PATH.sfi_tx_data_edb[2][SFI_D_SRC_2/4-1:0]     	;
assign  				 	`SFI_2.sfi_tx_data_aux_parity_2									=	`TRANSACTORS_PATH.sfi_tx_data_aux_parity[2]     	;
assign  				 	`SFI_2.sfi_tx_data_crd_rtn_block_2								=	`TRANSACTORS_PATH.sfi_tx_data_crd_rtn_block[2]     	;     	;

//=================================================================================================================================

