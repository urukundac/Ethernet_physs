//=================================================================================================================================
// SFI connections - USER MUST EDIT THE RIGHT HAND SIDE OF THE FOLLOWING ASSIGNMENTS AND DEFINE - WHEN THIS TRANSACTOR IS USED
//=================================================================================================================================
// SFI   connection #0


							`define 	SFI_3 					`FPGA_TRANSACTORS_TOP   // example:  fpga_tcss_top.tcss_val_rtl.tcss.par_iom    //HERE USER SHOULD SET THE PATH TO HIS SIDE OF THE SFI INTEFACE
						
assign 				  		`TRANSACTORS_PATH.sfi_clk[3] 									= `SFI_3.sfi_clk_3;
assign 				  		`TRANSACTORS_PATH.rst_sfi_n[3] 									= `SFI_3.rst_sfi_n_3;



//inputs to FGT
assign                  	`TRANSACTORS_PATH.sfi_rx_txcon_req[3]     						= `SFI_3.sfi_rx_txcon_req_3;

assign                  	`TRANSACTORS_PATH.sfi_tx_rxcon_ack[3]     						= `SFI_3.sfi_tx_rxcon_ack_3;
assign                  	`TRANSACTORS_PATH.sfi_tx_rxdiscon_nack[3]   					= `SFI_3.sfi_tx_rxdiscon_nack_3;
assign                  	`TRANSACTORS_PATH.sfi_tx_rx_empty[3]     						= `SFI_3.sfi_tx_rx_empty_3;

assign                  	`TRANSACTORS_PATH.sfi_rx_hdr_valid[3]     						= `SFI_3.sfi_rx_hdr_valid_3;
assign                  	`TRANSACTORS_PATH.sfi_rx_hdr_early_valid[3]     				= `SFI_3.sfi_rx_hdr_early_valid_3;
assign                  	`TRANSACTORS_PATH.sfi_rx_header[3]     							= `SFI_3.sfi_rx_header_3;
assign                  	`TRANSACTORS_PATH.sfi_rx_hdr_info_bytes[3]     					= `SFI_3.sfi_rx_hdr_info_bytes_3;
assign                  	`TRANSACTORS_PATH.sfi_rx_hdr_crd_rtn_block[3]     				= `SFI_3.sfi_rx_hdr_crd_rtn_block_3;

assign                  	`TRANSACTORS_PATH.sfi_rx_data_valid[3]     						= `SFI_3.sfi_rx_data_valid_3;
assign                  	`TRANSACTORS_PATH.sfi_rx_data_early_valid[3]     				= `SFI_3.sfi_rx_data_early_valid_3;
assign                  	`TRANSACTORS_PATH.sfi_rx_data[3][SFI_D_SRC_3*8-1:0]     			= `SFI_3.sfi_rx_data_3;
assign                  	`TRANSACTORS_PATH.sfi_rx_data_parity[3][SFI_D_SRC_3/8-1:0]   		= `SFI_3.sfi_rx_data_parity_3;
assign                  	`TRANSACTORS_PATH.sfi_rx_data_start[3]     						= `SFI_3.sfi_rx_data_start_3;
assign                  	`TRANSACTORS_PATH.sfi_rx_data_info_byte[3]     					= `SFI_3.sfi_rx_data_info_byte_3;
assign                  	`TRANSACTORS_PATH.sfi_rx_data_end[3][SFI_D_SRC_3/4-1:0]     		= `SFI_3.sfi_rx_data_end_3;
assign                  	`TRANSACTORS_PATH.sfi_rx_data_poison[3][SFI_D_SRC_3/4-1:0]     	= `SFI_3.sfi_rx_data_poison_3;
assign                  	`TRANSACTORS_PATH.sfi_rx_data_edb[3][SFI_D_SRC_3/4-1:0]     		= `SFI_3.sfi_rx_data_edb_3;
assign                  	`TRANSACTORS_PATH.sfi_rx_data_aux_parity[3]     				= `SFI_3.sfi_rx_data_aux_parity_3;
assign                  	`TRANSACTORS_PATH.sfi_rx_data_crd_rtn_block[3]     				= `SFI_3.sfi_rx_data_crd_rtn_block_3;

assign                  	`TRANSACTORS_PATH.sfi_tx_hdr_block[3]     						= `SFI_3.sfi_tx_hdr_block_3;
assign                  	`TRANSACTORS_PATH.sfi_tx_hdr_crd_rtn_valid[3]     				= `SFI_3.sfi_tx_hdr_crd_rtn_valid_3;
assign                  	`TRANSACTORS_PATH.sfi_tx_hdr_crd_rtn_ded[3]     				= `SFI_3.sfi_tx_hdr_crd_rtn_ded_3;
assign                  	`TRANSACTORS_PATH.sfi_tx_hdr_crd_rtn_fc_id[3]     				= `SFI_3.sfi_tx_hdr_crd_rtn_fc_id_3;
assign                  	`TRANSACTORS_PATH.sfi_tx_hdr_crd_rtn_vc_id[3]     				= `SFI_3.sfi_tx_hdr_crd_rtn_vc_id_3;
assign                  	`TRANSACTORS_PATH.sfi_tx_hdr_crd_rtn_value[3]     				= `SFI_3.sfi_tx_hdr_crd_rtn_value_3;

assign                  	`TRANSACTORS_PATH.sfi_tx_data_block[3]     						= `SFI_3.sfi_tx_data_block_3;
assign                  	`TRANSACTORS_PATH.sfi_tx_data_crd_rtn_valid[3]					= `SFI_3.sfi_tx_data_crd_rtn_valid_3;
assign                  	`TRANSACTORS_PATH.sfi_tx_data_crd_rtn_ded[3]					= `SFI_3.sfi_tx_data_crd_rtn_ded_3;
assign                  	`TRANSACTORS_PATH.sfi_tx_data_crd_rtn_fc_id[3]     				= `SFI_3.sfi_tx_data_crd_rtn_fc_id_3;
assign                  	`TRANSACTORS_PATH.sfi_tx_data_crd_rtn_vc_id[3]	    			= `SFI_3.sfi_tx_data_crd_rtn_vc_id_3;
assign                  	`TRANSACTORS_PATH.sfi_tx_data_crd_rtn_value[3]     				= `SFI_3.sfi_tx_data_crd_rtn_value_3;

//=================================================================================================================================
// SFI connections - USER MUST EDIT THE LEFT HAND SIDE OF THE FOLLOWING ASSIGNMENTS  - WHEN THIS TRANSACTOR IS USED
//=================================================================================================================================


//outputs from FGT
assign  				 	`SFI_3.sfi_rx_rxcon_ack_3										=	`TRANSACTORS_PATH.sfi_rx_rxcon_ack[3]     	;
assign  				 	`SFI_3.sfi_rx_rxdiscon_nack_3									=	`TRANSACTORS_PATH.sfi_rx_rxdiscon_nack[3]     		;
assign  				 	`SFI_3.sfi_rx_rx_empty_3										=	`TRANSACTORS_PATH.sfi_rx_rx_empty[3]     		;
			
assign  				 	`SFI_3.sfi_tx_txcon_req_3										=	`TRANSACTORS_PATH.sfi_tx_txcon_req[3]     		;

assign  				 	`SFI_3.sfi_rx_hdr_block_3										=	`TRANSACTORS_PATH.sfi_rx_hdr_block[3]     				;
assign  				 	`SFI_3.sfi_rx_hdr_crd_rtn_valid_3								=	`TRANSACTORS_PATH.sfi_rx_hdr_crd_rtn_valid[3]     				;
assign  				 	`SFI_3.sfi_rx_hdr_crd_rtn_ded_3									=	`TRANSACTORS_PATH.sfi_rx_hdr_crd_rtn_ded[3]     				;
assign  				 	`SFI_3.sfi_rx_hdr_crd_rtn_fc_id_3								=	`TRANSACTORS_PATH.sfi_rx_hdr_crd_rtn_fc_id[3]     		;
assign  				 	`SFI_3.sfi_rx_hdr_crd_rtn_vc_id_3								=	`TRANSACTORS_PATH.sfi_rx_hdr_crd_rtn_vc_id[3]     			;
assign						`SFI_3.sfi_rx_hdr_crd_rtn_value_3								=	`TRANSACTORS_PATH.sfi_rx_hdr_crd_rtn_value[3]				;

assign  				 	`SFI_3.sfi_rx_data_block_3										=	`TRANSACTORS_PATH.sfi_rx_data_block[3]     			;
assign  				 	`SFI_3.sfi_rx_data_crd_rtn_valid_3								=	`TRANSACTORS_PATH.sfi_rx_data_crd_rtn_valid[3]     				;
assign  				 	`SFI_3.sfi_rx_data_crd_rtn_ded_3								=	`TRANSACTORS_PATH.sfi_rx_data_crd_rtn_ded[3]     			;
assign  				 	`SFI_3.sfi_rx_data_crd_rtn_fc_id_3								=	`TRANSACTORS_PATH.sfi_rx_data_crd_rtn_fc_id[3]     			;
assign  				 	`SFI_3.sfi_rx_data_crd_rtn_vc_id_3								=	`TRANSACTORS_PATH.sfi_rx_data_crd_rtn_vc_id[3]    		 	;
assign  				 	`SFI_3.sfi_rx_data_crd_rtn_value_3								=	`TRANSACTORS_PATH.sfi_rx_data_crd_rtn_value[3]     				;

assign  				 	`SFI_3.sfi_tx_hdr_valid_3										=	`TRANSACTORS_PATH.sfi_tx_hdr_valid[3]     		;
assign  				 	`SFI_3.sfi_tx_hdr_early_valid_3									=	`TRANSACTORS_PATH.sfi_tx_hdr_early_valid[3]     			;
assign  				 	`SFI_3.sfi_tx_header_3											=	`TRANSACTORS_PATH.sfi_tx_header[3]     			;
assign  				 	`SFI_3.sfi_tx_hdr_info_bytes_3									=	`TRANSACTORS_PATH.sfi_tx_hdr_info_bytes[3]     				;
assign  				 	`SFI_3.sfi_tx_hdr_crd_rtn_block_3								=	`TRANSACTORS_PATH.sfi_tx_hdr_crd_rtn_block[3]     				;

assign  				 	`SFI_3.sfi_tx_data_valid_3										=	`TRANSACTORS_PATH.sfi_tx_data_valid[3]     				;
assign  				 	`SFI_3.sfi_tx_data_early_valid_3								=	`TRANSACTORS_PATH.sfi_tx_data_early_valid[3]     			;
assign  				 	`SFI_3.sfi_tx_data_3											=	`TRANSACTORS_PATH.sfi_tx_data[3][SFI_D_SRC_3*8-1:0]     				;
assign  				 	`SFI_3.sfi_tx_data_parity_3										=	`TRANSACTORS_PATH.sfi_tx_data_parity[3][SFI_D_SRC_3/8-1:0]   		 	 	;
assign  				 	`SFI_3.sfi_tx_data_start_3										=	`TRANSACTORS_PATH.sfi_tx_data_start[3]     				;
assign  				 	`SFI_3.sfi_tx_data_info_byte_3									=	`TRANSACTORS_PATH.sfi_tx_data_info_byte[3]     	;
assign  				 	`SFI_3.sfi_tx_data_end_3										=	`TRANSACTORS_PATH.sfi_tx_data_end[3][SFI_D_SRC_3/4-1:0]     	;
assign  				 	`SFI_3.sfi_tx_data_poison_3										=	`TRANSACTORS_PATH.sfi_tx_data_poison[3][SFI_D_SRC_3/4-1:0]     	;
assign  				 	`SFI_3.sfi_tx_data_edb_3										=	`TRANSACTORS_PATH.sfi_tx_data_edb[3][SFI_D_SRC_3/4-1:0]     	;
assign  				 	`SFI_3.sfi_tx_data_aux_parity_3									=	`TRANSACTORS_PATH.sfi_tx_data_aux_parity[3]     	;
assign  				 	`SFI_3.sfi_tx_data_crd_rtn_block_3								=	`TRANSACTORS_PATH.sfi_tx_data_crd_rtn_block[3]     	;     	;

//=================================================================================================================================

