
	`define 	SFI_0 		  `FPGA_TRANSACTORS_TOP  
	`define 	SFI_1 		  `FPGA_TRANSACTORS_TOP  

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

assign `SFI_1.sfi_rx_txcon_req_1 			= `SFI_0.sfi_tx_txcon_req[0];

assign `SFI_1.sfi_tx_rxcon_ack_1 			= `SFI_0.sfi_rx_rxcon_ack[0];
assign `SFI_1.sfi_tx_rxdiscon_nack_1 		= `SFI_0.sfi_rx_rxdiscon_nack[0];
assign `SFI_1.sfi_tx_rx_empty_1 			= `SFI_0.sfi_rx_rx_empty[0];

assign `SFI_1.sfi_rx_hdr_valid_1 			= `SFI_0.sfi_tx_hdr_valid[0];
assign `SFI_1.sfi_rx_hdr_early_valid_1 		= `SFI_0.sfi_tx_hdr_early_valid[0];
assign `SFI_1.sfi_rx_header_1 				= `SFI_0.sfi_tx_header[0];
assign `SFI_1.sfi_rx_hdr_info_bytes_1 		= `SFI_0.sfi_tx_hdr_info_bytes[0];
assign `SFI_1.sfi_rx_hdr_crd_rtn_block_1 	= `SFI_0.sfi_tx_hdr_crd_rtn_block[0];

assign `SFI_1.sfi_rx_data_valid_1 			= `SFI_0.sfi_tx_data_valid[0];
assign `SFI_1.sfi_rx_data_early_valid_1 	= `SFI_0.sfi_tx_data_early_valid[0];
assign `SFI_1.sfi_rx_data_1 				= `SFI_0.sfi_tx_data[0];
assign `SFI_1.sfi_rx_data_parity_1 			= `SFI_0.sfi_tx_data_parity[0];
assign `SFI_1.sfi_rx_data_start_1 			= `SFI_0.sfi_tx_data_start[0];
assign `SFI_1.sfi_rx_data_info_byte_1 		= `SFI_0.sfi_tx_data_info_byte[0];
assign `SFI_1.sfi_rx_data_end_1 			= `SFI_0.sfi_tx_data_end[0];
assign `SFI_1.sfi_rx_data_poison_1 			= `SFI_0.sfi_tx_data_poison[0];
assign `SFI_1.sfi_rx_data_edb_1 			= `SFI_0.sfi_tx_data_edb[0];
assign `SFI_1.sfi_rx_data_aux_parity_1 		= `SFI_0.sfi_tx_data_aux_parity[0];
assign `SFI_1.sfi_rx_data_crd_rtn_block_1 	= `SFI_0.sfi_tx_data_crd_rtn_block[0];

assign `SFI_1.sfi_tx_hdr_block_1 			= `SFI_0.sfi_rx_hdr_block[0];
assign `SFI_1.sfi_tx_hdr_crd_rtn_valid_1 	= `SFI_0.sfi_rx_hdr_crd_rtn_valid[0];
assign `SFI_1.sfi_tx_hdr_crd_rtn_ded_1 		= `SFI_0.sfi_rx_hdr_crd_rtn_ded[0];
assign `SFI_1.sfi_tx_hdr_crd_rtn_fc_id_1 	= `SFI_0.sfi_rx_hdr_crd_rtn_fc_id[0];
assign `SFI_1.sfi_tx_hdr_crd_rtn_vc_id_1 	= `SFI_0.sfi_rx_hdr_crd_rtn_vc_id[0];
assign `SFI_1.sfi_tx_hdr_crd_rtn_value_1 	= `SFI_0.sfi_rx_hdr_crd_rtn_value[0];

assign `SFI_1.sfi_tx_data_block_1 			= `SFI_0.sfi_rx_data_block[0];
assign `SFI_1.sfi_tx_data_crd_rtn_valid_1 	= `SFI_0.sfi_rx_data_crd_rtn_valid[0];
assign `SFI_1.sfi_tx_data_crd_rtn_ded_1 	= `SFI_0.sfi_rx_data_crd_rtn_ded[0];
assign `SFI_1.sfi_tx_data_crd_rtn_fc_id_1 	= `SFI_0.sfi_rx_data_crd_rtn_fc_id[0];
assign `SFI_1.sfi_tx_data_crd_rtn_vc_id_1 	= `SFI_0.sfi_rx_data_crd_rtn_vc_id[0];
assign `SFI_1.sfi_tx_data_crd_rtn_value_1 	= `SFI_0.sfi_rx_data_crd_rtn_value[0];




	`define 	SFI_2 		  `FPGA_TRANSACTORS_TOP  
	`define 	SFI_3 		  `FPGA_TRANSACTORS_TOP  

//connecting outputs from SFI_3 to inputs of SFI_2

assign `SFI_2.sfi_rx_txcon_req_2 			= `SFI_3.sfi_tx_txcon_req[3];

assign `SFI_2.sfi_tx_rxcon_ack_2 			= `SFI_3.sfi_rx_rxcon_ack[3];
assign `SFI_2.sfi_tx_rxdiscon_nack_2 		= `SFI_3.sfi_rx_rxdiscon_nack[3];
assign `SFI_2.sfi_tx_rx_empty_2 			= `SFI_3.sfi_rx_rx_empty[3];

assign `SFI_2.sfi_rx_hdr_valid_2 			= `SFI_3.sfi_tx_hdr_valid[3];
assign `SFI_2.sfi_rx_hdr_early_valid_2 		= `SFI_3.sfi_tx_hdr_early_valid[3];
assign `SFI_2.sfi_rx_header_2 				= `SFI_3.sfi_tx_header[3];
assign `SFI_2.sfi_rx_hdr_info_bytes_2 		= `SFI_3.sfi_tx_hdr_info_bytes[3];
assign `SFI_2.sfi_rx_hdr_crd_rtn_block_2 	= `SFI_3.sfi_tx_hdr_crd_rtn_block[3];

assign `SFI_2.sfi_rx_data_valid_2 			= `SFI_3.sfi_tx_data_valid[3];
assign `SFI_2.sfi_rx_data_early_valid_2 	= `SFI_3.sfi_tx_data_early_valid[3];
assign `SFI_2.sfi_rx_data_2 				= `SFI_3.sfi_tx_data[3];
assign `SFI_2.sfi_rx_data_parity_2 			= `SFI_3.sfi_tx_data_parity[3];
assign `SFI_2.sfi_rx_data_start_2 			= `SFI_3.sfi_tx_data_start[3];
assign `SFI_2.sfi_rx_data_info_byte_2 		= `SFI_3.sfi_tx_data_info_byte[3];
assign `SFI_2.sfi_rx_data_end_2 			= `SFI_3.sfi_tx_data_end[3];
assign `SFI_2.sfi_rx_data_poison_2 			= `SFI_3.sfi_tx_data_poison[3];
assign `SFI_2.sfi_rx_data_edb_2 			= `SFI_3.sfi_tx_data_edb[3];
assign `SFI_2.sfi_rx_data_aux_parity_2 		= `SFI_3.sfi_tx_data_aux_parity[3];
assign `SFI_2.sfi_rx_data_crd_rtn_block_2 	= `SFI_3.sfi_tx_data_crd_rtn_block[3];

assign `SFI_2.sfi_tx_hdr_block_2 			= `SFI_3.sfi_rx_hdr_block[3];
assign `SFI_2.sfi_tx_hdr_crd_rtn_valid_2 	= `SFI_3.sfi_rx_hdr_crd_rtn_valid[3];
assign `SFI_2.sfi_tx_hdr_crd_rtn_ded_2 		= `SFI_3.sfi_rx_hdr_crd_rtn_ded[3];
assign `SFI_2.sfi_tx_hdr_crd_rtn_fc_id_2 	= `SFI_3.sfi_rx_hdr_crd_rtn_fc_id[3];
assign `SFI_2.sfi_tx_hdr_crd_rtn_vc_id_2 	= `SFI_3.sfi_rx_hdr_crd_rtn_vc_id[3];
assign `SFI_2.sfi_tx_hdr_crd_rtn_value_2 	= `SFI_3.sfi_rx_hdr_crd_rtn_value[3];

assign `SFI_2.sfi_tx_data_block_2 			= `SFI_3.sfi_rx_data_block[3];
assign `SFI_2.sfi_tx_data_crd_rtn_valid_2 	= `SFI_3.sfi_rx_data_crd_rtn_valid[3];
assign `SFI_2.sfi_tx_data_crd_rtn_ded_2 	= `SFI_3.sfi_rx_data_crd_rtn_ded[3];
assign `SFI_2.sfi_tx_data_crd_rtn_fc_id_2 	= `SFI_3.sfi_rx_data_crd_rtn_fc_id[3];
assign `SFI_2.sfi_tx_data_crd_rtn_vc_id_2 	= `SFI_3.sfi_rx_data_crd_rtn_vc_id[3];
assign `SFI_2.sfi_tx_data_crd_rtn_value_2 	= `SFI_3.sfi_rx_data_crd_rtn_value[3];

//connecting outputs from SFI_2 to inputs of SFI_3

assign `SFI_3.sfi_rx_txcon_req_3 			= `SFI_2.sfi_tx_txcon_req[2];

assign `SFI_3.sfi_tx_rxcon_ack_3 			= `SFI_2.sfi_rx_rxcon_ack[2];
assign `SFI_3.sfi_tx_rxdiscon_nack_3 		= `SFI_2.sfi_rx_rxdiscon_nack[2];
assign `SFI_3.sfi_tx_rx_empty_3 			= `SFI_2.sfi_rx_rx_empty[2];

assign `SFI_3.sfi_rx_hdr_valid_3 			= `SFI_2.sfi_tx_hdr_valid[2];
assign `SFI_3.sfi_rx_hdr_early_valid_3 		= `SFI_2.sfi_tx_hdr_early_valid[2];
assign `SFI_3.sfi_rx_header_3 				= `SFI_2.sfi_tx_header[2];
assign `SFI_3.sfi_rx_hdr_info_bytes_3 		= `SFI_2.sfi_tx_hdr_info_bytes[2];
assign `SFI_3.sfi_rx_hdr_crd_rtn_block_3 	= `SFI_2.sfi_tx_hdr_crd_rtn_block[2];

assign `SFI_3.sfi_rx_data_valid_3 			= `SFI_2.sfi_tx_data_valid[2];
assign `SFI_3.sfi_rx_data_early_valid_3 	= `SFI_2.sfi_tx_data_early_valid[2];
assign `SFI_3.sfi_rx_data_3 				= `SFI_2.sfi_tx_data[2];
assign `SFI_3.sfi_rx_data_parity_3 			= `SFI_2.sfi_tx_data_parity[2];
assign `SFI_3.sfi_rx_data_start_3 			= `SFI_2.sfi_tx_data_start[2];
assign `SFI_3.sfi_rx_data_info_byte_3 		= `SFI_2.sfi_tx_data_info_byte[2];
assign `SFI_3.sfi_rx_data_end_3 			= `SFI_2.sfi_tx_data_end[2];
assign `SFI_3.sfi_rx_data_poison_3 			= `SFI_2.sfi_tx_data_poison[2];
assign `SFI_3.sfi_rx_data_edb_3 			= `SFI_2.sfi_tx_data_edb[2];
assign `SFI_3.sfi_rx_data_aux_parity_3 		= `SFI_2.sfi_tx_data_aux_parity[2];
assign `SFI_3.sfi_rx_data_crd_rtn_block_3 	= `SFI_2.sfi_tx_data_crd_rtn_block[2];

assign `SFI_3.sfi_tx_hdr_block_3 			= `SFI_2.sfi_rx_hdr_block[2];
assign `SFI_3.sfi_tx_hdr_crd_rtn_valid_3 	= `SFI_2.sfi_rx_hdr_crd_rtn_valid[2];
assign `SFI_3.sfi_tx_hdr_crd_rtn_ded_3 		= `SFI_2.sfi_rx_hdr_crd_rtn_ded[2];
assign `SFI_3.sfi_tx_hdr_crd_rtn_fc_id_3 	= `SFI_2.sfi_rx_hdr_crd_rtn_fc_id[2];
assign `SFI_3.sfi_tx_hdr_crd_rtn_vc_id_3 	= `SFI_2.sfi_rx_hdr_crd_rtn_vc_id[2];
assign `SFI_3.sfi_tx_hdr_crd_rtn_value_3 	= `SFI_2.sfi_rx_hdr_crd_rtn_value[2];

assign `SFI_3.sfi_tx_data_block_3 			= `SFI_2.sfi_rx_data_block[2];
assign `SFI_3.sfi_tx_data_crd_rtn_valid_3 	= `SFI_2.sfi_rx_data_crd_rtn_valid[2];
assign `SFI_3.sfi_tx_data_crd_rtn_ded_3 	= `SFI_2.sfi_rx_data_crd_rtn_ded[2];
assign `SFI_3.sfi_tx_data_crd_rtn_fc_id_3 	= `SFI_2.sfi_rx_data_crd_rtn_fc_id[2];
assign `SFI_3.sfi_tx_data_crd_rtn_vc_id_3 	= `SFI_2.sfi_rx_data_crd_rtn_vc_id[2];
assign `SFI_3.sfi_tx_data_crd_rtn_value_3 	= `SFI_2.sfi_rx_data_crd_rtn_value[2];

