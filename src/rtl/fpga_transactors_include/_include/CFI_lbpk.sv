//=================================================================================================================================
// CFI_FABRIC connections - USER MUST EDIT THE RIGHT HAND SIDE OF THE FOLLOWING ASSIGNMENTS AND DEFINE - WHEN NEEDED
//=================================================================================================================================
// CFI_FABRIC   connection #0
// CFI_AGENT    connection #1


	 // `define 	TRANSACTORS_PATH 					fpga_transactors_top_inst       // example:  fpga_tcss_top.tcss_val_rtl.tcss.par_iom
   
// RX Request connections
   assign   rx_req_header_0          	 = tx_req_header_1; 
   assign   rx_req_dstid_or_crd_0      = tx_req_dstid_1;
   assign   rx_req_rctrl_0             = tx_req_rctrl_1;
   assign   rx_req_vc_id_0      	     = tx_req_vc_id_1;
   assign   rx_req_protocol_id_0       = tx_req_protocol_id_1;  
   assign   rx_req_early_valid_0       = tx_req_early_valid_1; 
   assign   rx_req_is_valid_0          = tx_req_is_valid_1; 
   assign   rx_req_null_packet_0       = tx_req_null_packet_1; 
   assign   rx_req_shared_credit_0     = tx_req_shared_credit_1; 
   assign   rx_req_trace_packet_0      = tx_req_trace_packet_1; 
   assign   rx_req_txblock_crd_flow_0  = tx_req_txblock_crd_flow_1; 
   assign   tx_req_block_1             = rx_req_block_0; 
   assign   tx_req_rxcrd_null_credit_1 = rx_req_rxcrd_null_credit_0;
   assign   tx_req_rxcrd_shared_1      = rx_req_rxcrd_shared_0;
   assign   tx_req_rxcrd_valid_1       = rx_req_rxcrd_valid_0; 
   assign   tx_req_rxcrd_protocol_id_1 = rx_req_rxcrd_protocol_id_0;
   assign   tx_req_rxcrd_vc_id_1       = rx_req_rxcrd_vc_id_0;
   
// RX Response connections
   assign   rx_rsp_is_valid_0          = tx_rsp_is_valid_1;  
   assign   rx_rsp_early_valid_0       = tx_rsp_early_valid_1; 
   assign   rx_rsp_null_packet_0       = tx_rsp_null_packet_1;
   assign   rx_rsp_protocol_id_0       = tx_rsp_protocol_id_1;   
   assign   rx_rsp_vc_id_0             = tx_rsp_vc_id_1;
   assign   rx_rsp_header_0            = tx_rsp_header_1; 
   assign   rx_rsp_dstid_or_crd_0      = tx_rsp_dstid_1;
   assign   rx_rsp_rctrl_0             = tx_rsp_rctrl_1;
   assign   rx_rsp_shared_credit_0     = tx_rsp_shared_credit_1; 
   assign   rx_rsp_trace_packet_0      = tx_rsp_trace_packet_1; 
   assign   rx_rsp_txblock_crd_flow_0  = tx_rsp_txblock_crd_flow_1;
   assign   tx_rsp_block_1             = rx_rsp_block_0; 
   assign   tx_rsp_rxcrd_null_credit_1 = rx_rsp_rxcrd_null_credit_0; 
   assign   tx_rsp_rxcrd_shared_1      = rx_rsp_rxcrd_shared_0; 
   assign   tx_rsp_rxcrd_valid_1       = rx_rsp_rxcrd_valid_0;
   assign   tx_rsp_rxcrd_protocol_id_1 = rx_rsp_rxcrd_protocol_id_0;
   assign   tx_rsp_rxcrd_vc_id_1       = rx_rsp_rxcrd_vc_id_0;

// RX Data connections 
   assign   rx_data_is_valid_0         = tx_data_is_valid_1;  
   assign   rx_data_early_valid_0      = tx_data_early_valid_1;
   assign   rx_data_null_packet_0      = tx_data_null_packet_1; 
   assign   rx_data_vc_id_0            = tx_data_vc_id_1;
   assign   rx_data_protocol_id_0      = tx_data_protocol_id_1;    
   assign   rx_data_header_0           = tx_data_header_1; 
   assign   rx_data_dstid_or_crd_0     = tx_data_dstid_1;
   assign   rx_data_rctrl_0            = tx_data_rctrl_1;
   assign   rx_data_payload_0          = tx_data_payload_1; 
   assign   rx_data_payload_par_0      = tx_data_payload_par_1; 
   assign   rx_data_poison_0           = tx_data_poison_1; 
   assign   rx_data_eop_0              = tx_data_eop_1;  
   assign   rx_data_shared_credit_0    = tx_data_shared_credit_1; 
   assign   rx_data_trace_packet_0     = tx_data_trace_packet_1; 
   assign   rx_data_txblock_crd_flow_0 = tx_data_txblock_crd_flow_1;
   assign   tx_data_block_1            = rx_data_block_0; 
   assign   tx_data_rxcrd_vc_id_1      = rx_data_rxcrd_vc_id_0; 
   assign   tx_data_rxcrd_protocol_id_1= rx_data_rxcrd_protocol_id_0;
   assign   tx_data_rxcrd_null_credit_1= rx_data_rxcrd_null_credit_0; 
   assign   tx_data_rxcrd_shared_1     = rx_data_rxcrd_shared_0;
   assign   tx_data_rxcrd_valid_1      = rx_data_rxcrd_valid_0;    

// TX Request connections 
   assign   rx_req_is_valid_1          = tx_req_is_valid_0; 
   assign   rx_req_early_valid_1       = tx_req_early_valid_0; 
   assign   rx_req_vc_id_1             = tx_req_vc_id_0;
   assign   rx_req_protocol_id_1       = tx_req_protocol_id_0; 
   assign   rx_req_header_1            = tx_req_header_0;
   assign   rx_req_dstid_or_crd_1      = tx_req_dstid_0;
   assign   rx_req_rctrl_1             = tx_req_rctrl_0;
   assign   rx_req_null_packet_1       = tx_req_null_packet_0; 
   assign   rx_req_shared_credit_1     = tx_req_shared_credit_0; 
   assign   rx_req_trace_packet_1      = tx_req_trace_packet_0; 
   assign   rx_req_txblock_crd_flow_1  = tx_req_txblock_crd_flow_0;
   assign   tx_req_block_0             = rx_req_block_1; 
   assign   tx_req_rxcrd_null_credit_0 = rx_req_rxcrd_null_credit_1; 
   assign   tx_req_rxcrd_shared_0      = rx_req_rxcrd_shared_1; 
   assign   tx_req_rxcrd_valid_0       = rx_req_rxcrd_valid_1;
   assign   tx_req_rxcrd_protocol_id_0 = rx_req_rxcrd_protocol_id_1;
   assign   tx_req_rxcrd_vc_id_0       = rx_req_rxcrd_vc_id_1;
 
// TX Response connections 
   assign   rx_rsp_is_valid_1          = tx_rsp_is_valid_0; 
   assign   rx_rsp_early_valid_1       = tx_rsp_early_valid_0; 
   assign   rx_rsp_null_packet_1       = tx_rsp_null_packet_0; 
   assign   rx_rsp_shared_credit_1     = tx_rsp_shared_credit_0;
   assign   rx_rsp_trace_packet_1      = tx_rsp_trace_packet_0; 
   assign   rx_rsp_txblock_crd_flow_1  = tx_rsp_txblock_crd_flow_0;
   assign   rx_rsp_vc_id_1             = tx_rsp_vc_id_0;
   assign   rx_rsp_protocol_id_1       = tx_rsp_protocol_id_0; 
   assign   rx_rsp_header_1            = tx_rsp_header_0;
   assign   rx_rsp_dstid_or_crd_1      = tx_rsp_dstid_0;
   assign   rx_rsp_rctrl_1             = tx_rsp_rctrl_0;
   assign   tx_rsp_block_0             = rx_rsp_block_1; 
   assign   tx_rsp_rxcrd_null_credit_0 = rx_rsp_rxcrd_null_credit_1; 
   assign   tx_rsp_rxcrd_shared_0      = rx_rsp_rxcrd_shared_1; 
   assign   tx_rsp_rxcrd_valid_0       = rx_rsp_rxcrd_valid_1;
   assign   tx_rsp_rxcrd_protocol_id_0 = rx_rsp_rxcrd_protocol_id_1;
   assign   tx_rsp_rxcrd_vc_id_0       = rx_rsp_rxcrd_vc_id_1;

// TX Data connections 
   assign   rx_data_is_valid_1           = tx_data_is_valid_0;  
   assign   rx_data_early_valid_1        = tx_data_early_valid_0; 
   assign   rx_data_null_packet_1        = tx_data_null_packet_0; 
   assign   rx_data_shared_credit_1      = tx_data_shared_credit_0; 
   assign   rx_data_trace_packet_1       = tx_data_trace_packet_0; 
   assign   rx_data_protocol_id_1        = tx_data_protocol_id_0;  
   assign   rx_data_vc_id_1              = tx_data_vc_id_0; 
   assign   rx_data_header_1             = tx_data_header_0;
   assign   rx_data_eop_1                = tx_data_eop_0; 
   assign   rx_data_payload_1            = tx_data_payload_0; 
   assign   rx_data_dstid_or_crd_1       = tx_data_dstid_0;
   assign   rx_data_rctrl_1              = tx_data_rctrl_0;
   assign   rx_data_txblock_crd_flow_1   = tx_data_txblock_crd_flow_0;
   assign   rx_data_poison_1             = tx_data_poison_0;
   assign   rx_data_payload_par_1        = tx_data_payload_par_0;    
   assign   tx_data_block_0              = rx_data_block_1;      
   assign   tx_data_rxcrd_null_credit_0  = rx_data_rxcrd_null_credit;
   assign   tx_data_rxcrd_shared_0       = rx_data_rxcrd_shared_1; 
   assign   tx_data_rxcrd_valid_0        = rx_data_rxcrd_valid_1; 
   assign   tx_data_rxcrd_protocol_id_0  = rx_data_rxcrd_protocol_id_1;
   assign   tx_data_rxcrd_vc_id_0        = rx_data_rxcrd_vc_id_1;

   assign   rx_con_req_1              = tx_con_req_0;
   assign   tx_con_ack_0              = rx_con_ack_1;
   assign   rx_con_req_0              = tx_con_req_1;
   assign   tx_con_ack_1              = rx_con_ack_0;

   assign   cfi_peer_clkack_0         =  1'b0;
   assign   cfi_rsp_peer_clkack_0     =  1'b0;
   assign   rx_ipc_read_high_0        =  1'b0;
   assign   rx_ipc_write_high_0       =  1'b0;
   assign   cfi_peer_clkack_1         =  1'b0;
   assign   cfi_rsp_peer_clkack_1     =  1'b0;
   assign   rx_ipc_read_high_1        =  1'b0;
   assign   rx_ipc_write_high_1       =  1'b0;

