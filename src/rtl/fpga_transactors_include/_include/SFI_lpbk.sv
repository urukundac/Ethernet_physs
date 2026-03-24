
	`define 	SFI_0 		  fpga_transactors_top_inst  
	`define 	SFI_1 		  fpga_transactors_top_inst  

//connecting outputs from SFI_1 to inputs of SFI_0

assign `SFI_0.sfi_rx_txcon_req_0 			= `SFI_1.sfi_tx_txcon_req[1];

assign `SFI_0.sfi_tx_rxcon_ack_0 			= `SFI_1.sfi_rx_rxcon_ack[1];
assign `SFI_0.sfi_tx_rxdiscon_nack_0 		= `SFI_1.sfi_rx_rxdiscon_nack[1];
assign `SFI_0.sfi_tx_rx_empty_0 			= `SFI_1.sfi_rx_rx_empty[1];

assign `SFI_0.sfi_rx_hdr_valid_0 			= `SFI_1.sfi_tx_hdr_valid[1];
assign `SFI_0.sfi_rx_hdr_early_valid_0 		= `SFI_1.sfi_tx_hdr_early_valid[1];
assign `SFI_0.sfi_rx_header_0 				= `SFI_1.sfi_tx_header[1];
assign `SFI_0.sfi_rx_hdr_info_bytes_0 		= `SFI_1.sfi_tx_hdr_info_bytes[1];
assign `SFI_0.sfi_rx_hdr_crd_rtn_block_0 	= `SFI_1.sfi_tx_hdr_crd_rtn_block[1];

assign `SFI_0.sfi_rx_data_valid_0 			= `SFI_1.sfi_tx_data_valid[1];
assign `SFI_0.sfi_rx_data_early_valid_0 	= `SFI_1.sfi_tx_data_early_valid[1];
assign `SFI_0.sfi_rx_data_0 				= `SFI_1.sfi_tx_data[1];
assign `SFI_0.sfi_rx_data_parity_0 			= `SFI_1.sfi_tx_data_parity[1];
assign `SFI_0.sfi_rx_data_start_0 			= `SFI_1.sfi_tx_data_start[1];
assign `SFI_0.sfi_rx_data_info_byte_0 		= `SFI_1.sfi_tx_data_info_byte[1];
assign `SFI_0.sfi_rx_data_end_0 			= `SFI_1.sfi_tx_data_end[1];
assign `SFI_0.sfi_rx_data_poison_0 			= `SFI_1.sfi_tx_data_poison[1];
assign `SFI_0.sfi_rx_data_edb_0 			= `SFI_1.sfi_tx_data_edb[1];
assign `SFI_0.sfi_rx_data_aux_parity_0 		= `SFI_1.sfi_tx_data_aux_parity[1];
assign `SFI_0.sfi_rx_data_crd_rtn_block_0 	= `SFI_1.sfi_tx_data_crd_rtn_block[1];

assign `SFI_0.sfi_tx_hdr_block_0 			= `SFI_1.sfi_rx_hdr_block[1];
assign `SFI_0.sfi_tx_hdr_crd_rtn_valid_0 	= `SFI_1.sfi_rx_hdr_crd_rtn_valid[1];
assign `SFI_0.sfi_tx_hdr_crd_rtn_ded_0 		= `SFI_1.sfi_rx_hdr_crd_rtn_ded[1];
assign `SFI_0.sfi_tx_hdr_crd_rtn_fc_id_0 	= `SFI_1.sfi_rx_hdr_crd_rtn_fc_id[1];
assign `SFI_0.sfi_tx_hdr_crd_rtn_vc_id_0 	= `SFI_1.sfi_rx_hdr_crd_rtn_vc_id[1];
assign `SFI_0.sfi_tx_hdr_crd_rtn_value_0 	= `SFI_1.sfi_rx_hdr_crd_rtn_value[1];

assign `SFI_0.sfi_tx_data_block_0 			= `SFI_1.sfi_rx_data_block[1];
assign `SFI_0.sfi_tx_data_crd_rtn_valid_0 	= `SFI_1.sfi_rx_data_crd_rtn_valid[1];
assign `SFI_0.sfi_tx_data_crd_rtn_ded_0 	= `SFI_1.sfi_rx_data_crd_rtn_ded[1];
assign `SFI_0.sfi_tx_data_crd_rtn_fc_id_0 	= `SFI_1.sfi_rx_data_crd_rtn_fc_id[1];
assign `SFI_0.sfi_tx_data_crd_rtn_vc_id_0 	= `SFI_1.sfi_rx_data_crd_rtn_vc_id[1];
assign `SFI_0.sfi_tx_data_crd_rtn_value_0 	= `SFI_1.sfi_rx_data_crd_rtn_value[1];

//connecting outputs from SFI_0 to inputs of SFI_1

assign `SFI_1.sfi_rx_txcon_req_1 			= `SFI_1.sfi_tx_txcon_req[0];

assign `SFI_1.sfi_tx_rxcon_ack_1 			= `SFI_1.sfi_rx_rxcon_ack[0];
assign `SFI_1.sfi_tx_rxdiscon_nack_1 		= `SFI_1.sfi_rx_rxdiscon_nack[0];
assign `SFI_1.sfi_tx_rx_empty_1 			= `SFI_1.sfi_rx_rx_empty[0];

assign `SFI_1.sfi_rx_hdr_valid_1 			= `SFI_1.sfi_tx_hdr_valid[0];
assign `SFI_1.sfi_rx_hdr_early_valid_1 		= `SFI_1.sfi_tx_hdr_early_valid[0];
assign `SFI_1.sfi_rx_header_1 				= `SFI_1.sfi_tx_header[0];
assign `SFI_1.sfi_rx_hdr_info_bytes_1 		= `SFI_1.sfi_tx_hdr_info_bytes[0];
assign `SFI_1.sfi_rx_hdr_crd_rtn_block_1 	= `SFI_1.sfi_tx_hdr_crd_rtn_block[0];

assign `SFI_1.sfi_rx_data_valid_1 			= `SFI_1.sfi_tx_data_valid[0];
assign `SFI_1.sfi_rx_data_early_valid_1 	= `SFI_1.sfi_tx_data_early_valid[0];
assign `SFI_1.sfi_rx_data_1 				= `SFI_1.sfi_tx_data[0];
assign `SFI_1.sfi_rx_data_parity_1 			= `SFI_1.sfi_tx_data_parity[0];
assign `SFI_1.sfi_rx_data_start_1 			= `SFI_1.sfi_tx_data_start[0];
assign `SFI_1.sfi_rx_data_info_byte_1 		= `SFI_1.sfi_tx_data_info_byte[0];
assign `SFI_1.sfi_rx_data_end_1 			= `SFI_1.sfi_tx_data_end[0];
assign `SFI_1.sfi_rx_data_poison_1 			= `SFI_1.sfi_tx_data_poison[0];
assign `SFI_1.sfi_rx_data_edb_1 			= `SFI_1.sfi_tx_data_edb[0];
assign `SFI_1.sfi_rx_data_aux_parity_1 		= `SFI_1.sfi_tx_data_aux_parity[0];
assign `SFI_1.sfi_rx_data_crd_rtn_block_1 	= `SFI_1.sfi_tx_data_crd_rtn_block[0];

assign `SFI_1.sfi_tx_hdr_block_1 			= `SFI_1.sfi_rx_hdr_block[0];
assign `SFI_1.sfi_tx_hdr_crd_rtn_valid_1 	= `SFI_1.sfi_rx_hdr_crd_rtn_valid[0];
assign `SFI_1.sfi_tx_hdr_crd_rtn_ded_1 		= `SFI_1.sfi_rx_hdr_crd_rtn_ded[0];
assign `SFI_1.sfi_tx_hdr_crd_rtn_fc_id_1 	= `SFI_1.sfi_rx_hdr_crd_rtn_fc_id[0];
assign `SFI_1.sfi_tx_hdr_crd_rtn_vc_id_1 	= `SFI_1.sfi_rx_hdr_crd_rtn_vc_id[0];
assign `SFI_1.sfi_tx_hdr_crd_rtn_value_1 	= `SFI_1.sfi_rx_hdr_crd_rtn_value[0];

assign `SFI_1.sfi_tx_data_block_1 			= `SFI_1.sfi_rx_data_block[0];
assign `SFI_1.sfi_tx_data_crd_rtn_valid_1 	= `SFI_1.sfi_rx_data_crd_rtn_valid[0];
assign `SFI_1.sfi_tx_data_crd_rtn_ded_1 	= `SFI_1.sfi_rx_data_crd_rtn_ded[0];
assign `SFI_1.sfi_tx_data_crd_rtn_fc_id_1 	= `SFI_1.sfi_rx_data_crd_rtn_fc_id[0];
assign `SFI_1.sfi_tx_data_crd_rtn_vc_id_1 	= `SFI_1.sfi_rx_data_crd_rtn_vc_id[0];
assign `SFI_1.sfi_tx_data_crd_rtn_value_1 	= `SFI_1.sfi_rx_data_crd_rtn_value[0];
