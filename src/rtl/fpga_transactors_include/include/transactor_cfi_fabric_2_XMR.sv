//=================================================================================================================================
// CFI_FABRIC connections - USER MUST EDIT THE RIGHT HAND SIDE OF THE FOLLOWING ASSIGNMENTS AND DEFINE - WHEN NEEDED
//=================================================================================================================================
// CFI_FABRIC   connection #2

			`define 	CFI_AGENT_2 					`FPGA_TRANSACTORS_TOP       // example:  fpga_tcss_top.tcss_val_rtl.tcss.par_iom

   assign 		`TRANSACTORS_PATH.cfi_clk[2] 			   	= `CFI_AGENT_2.cfi_agent_clock_2; 
   assign 		`TRANSACTORS_PATH.cfi_rst_n[2] 				= `CFI_AGENT_2.cfi_agent_rst_n_2; 
      
// RX Request connections
   assign   `TRANSACTORS_PATH.rx_req_header[2]          	= `CFI_AGENT_2.rx_req_header_2; 
   assign   `TRANSACTORS_PATH.rx_req_dstid_or_crd[2]      = `CFI_AGENT_2.rx_req_dstid_or_crd_2;
   assign   `TRANSACTORS_PATH.rx_req_rctrl[2]             = `CFI_AGENT_2.rx_req_rctrl_2;
   assign   `TRANSACTORS_PATH.rx_req_vc_id[2]      	      = `CFI_AGENT_2.rx_req_vc_id_2;
   assign   `TRANSACTORS_PATH.rx_req_protocol_id[2]       = `CFI_AGENT_2.rx_req_protocol_id_2;  
   assign   `TRANSACTORS_PATH.rx_req_early_valid[2]       = `CFI_AGENT_2.rx_req_early_valid_2; 
   assign   `TRANSACTORS_PATH.rx_req_is_valid[2]          = `CFI_AGENT_2.rx_req_is_valid_2; 
   assign   `TRANSACTORS_PATH.rx_req_null_packet[2]       = `CFI_AGENT_2.rx_req_null_packet_2; 
   assign   `TRANSACTORS_PATH.rx_req_shared_credit[2]     = `CFI_AGENT_2.rx_req_shared_credit_2; 
   assign   `TRANSACTORS_PATH.rx_req_trace_packet[2]      = `CFI_AGENT_2.rx_req_trace_packet_2; 
   assign   `TRANSACTORS_PATH.rx_req_txblock_crd_flow[2]  = `CFI_AGENT_2.rx_req_txblock_crd_flow_2; 
   assign   `CFI_AGENT_2.rx_req_block_2                   = `TRANSACTORS_PATH.rx_req_block[2]; 
   assign   `CFI_AGENT_2.rx_req_rxcrd_null_credit_2       = `TRANSACTORS_PATH.rx_req_rxcrd_null_credit[2];
   assign   `CFI_AGENT_2.rx_req_rxcrd_shared_2            = `TRANSACTORS_PATH.rx_req_rxcrd_shared[2];
   assign   `CFI_AGENT_2.rx_req_rxcrd_valid_2             = `TRANSACTORS_PATH.rx_req_rxcrd_valid[2]; 
   assign   `CFI_AGENT_2.rx_req_rxcrd_protocol_id_2       = `TRANSACTORS_PATH.rx_req_rxcrd_protocol_id[2];
   assign   `CFI_AGENT_2.rx_req_rxcrd_vc_id_2             = `TRANSACTORS_PATH.rx_req_rxcrd_vc_id[2];
   
// RX Response connections
   assign   `TRANSACTORS_PATH.rx_rsp_is_valid[2]          = `CFI_AGENT_2.rx_rsp_is_valid_2;  
   assign   `TRANSACTORS_PATH.rx_rsp_early_valid[2]       = `CFI_AGENT_2.rx_rsp_early_valid_2; 
   assign   `TRANSACTORS_PATH.rx_rsp_null_packet[2]       = `CFI_AGENT_2.rx_rsp_null_packet_2;
   assign   `TRANSACTORS_PATH.rx_rsp_protocol_id[2]       = `CFI_AGENT_2.rx_rsp_protocol_id_2;   
   assign   `TRANSACTORS_PATH.rx_rsp_vc_id[2]             = `CFI_AGENT_2.rx_rsp_vc_id_2;
   assign   `TRANSACTORS_PATH.rx_rsp_header[2]            = `CFI_AGENT_2.rx_rsp_header_2; 
   assign   `TRANSACTORS_PATH.rx_rsp_dstid_or_crd[2]      = `CFI_AGENT_2.rx_rsp_dstid_or_crd_2;
   assign   `TRANSACTORS_PATH.rx_rsp_rctrl[2]             = `CFI_AGENT_2.rx_rsp_rctrl_2;
   assign   `TRANSACTORS_PATH.rx_rsp_shared_credit[2]     = `CFI_AGENT_2.rx_rsp_shared_credit_2; 
   assign   `TRANSACTORS_PATH.rx_rsp_trace_packet[2]      = `CFI_AGENT_2.rx_rsp_trace_packet_2; 
   assign   `TRANSACTORS_PATH.rx_rsp_txblock_crd_flow[2]  = `CFI_AGENT_2.rx_rsp_txblock_crd_flow_2;
   assign   `CFI_AGENT_2.rx_rsp_block_2                   = `TRANSACTORS_PATH.rx_rsp_block[2]; 
   assign   `CFI_AGENT_2.rx_rsp_rxcrd_null_credit_2       = `TRANSACTORS_PATH.rx_rsp_rxcrd_null_credit[2]; 
   assign   `CFI_AGENT_2.rx_rsp_rxcrd_shared_2            = `TRANSACTORS_PATH.rx_rsp_rxcrd_shared[2]; 
   assign   `CFI_AGENT_2.rx_rsp_rxcrd_valid_2             = `TRANSACTORS_PATH.rx_rsp_rxcrd_valid[2];
   assign   `CFI_AGENT_2.rx_rsp_rxcrd_protocol_id_2       = `TRANSACTORS_PATH.rx_rsp_rxcrd_protocol_id[2];
   assign   `CFI_AGENT_2.rx_rsp_rxcrd_vc_id_2             = `TRANSACTORS_PATH.rx_rsp_rxcrd_vc_id[2];

// RX Data connections 
   assign   `TRANSACTORS_PATH.rx_data_is_valid[2]         = `CFI_AGENT_2.rx_data_is_valid_2;  
   assign   `TRANSACTORS_PATH.rx_data_early_valid[2]      = `CFI_AGENT_2.rx_data_early_valid_2;
   assign   `TRANSACTORS_PATH.rx_data_null_packet[2]      = `CFI_AGENT_2.rx_data_null_packet_2; 
   assign   `TRANSACTORS_PATH.rx_data_vc_id[2]            = `CFI_AGENT_2.rx_data_vc_id_2;
   assign   `TRANSACTORS_PATH.rx_data_protocol_id[2]      = `CFI_AGENT_2.rx_data_protocol_id_2;    
   assign   `TRANSACTORS_PATH.rx_data_header[2]           = `CFI_AGENT_2.rx_data_header_2;
   assign   `TRANSACTORS_PATH.rx_data_header_parity[2]    = `CFI_AGENT_2.rx_data_header_parity_2;  
   assign   `TRANSACTORS_PATH.rx_data_dstid_or_crd[2]     = `CFI_AGENT_2.rx_data_dstid_or_crd_2;
   assign   `TRANSACTORS_PATH.rx_data_rctrl[2]            = `CFI_AGENT_2.rx_data_rctrl_2;
   assign   `TRANSACTORS_PATH.rx_data_payload[2]          = `CFI_AGENT_2.rx_data_payload_2; 
   assign   `TRANSACTORS_PATH.rx_data_payload_par[2]      = `CFI_AGENT_2.rx_data_payload_par_2; 
   assign   `TRANSACTORS_PATH.rx_data_poison[2]           = `CFI_AGENT_2.rx_data_poison_2; 
   assign   `TRANSACTORS_PATH.rx_data_eop[2]              = `CFI_AGENT_2.rx_data_eop_2;  
   assign   `TRANSACTORS_PATH.rx_data_shared_credit[2]    = `CFI_AGENT_2.rx_data_shared_credit_2; 
   assign   `TRANSACTORS_PATH.rx_data_trace_packet[2]     = `CFI_AGENT_2.rx_data_trace_packet_2; 
   assign   `TRANSACTORS_PATH.rx_data_txblock_crd_flow[2] = `CFI_AGENT_2.rx_data_txblock_crd_flow_2;
   assign   `CFI_AGENT_2.rx_data_rxcrd_vc_id_2            = `TRANSACTORS_PATH.rx_data_rxcrd_vc_id[2]; 
   assign   `CFI_AGENT_2.rx_data_rxcrd_protocol_id_2      = `TRANSACTORS_PATH.rx_data_rxcrd_protocol_id[2];
   assign   `CFI_AGENT_2.rx_data_block_2                  = `TRANSACTORS_PATH.rx_data_block[2]; 
   assign   `CFI_AGENT_2.rx_data_rxcrd_null_credit_2      = `TRANSACTORS_PATH.rx_data_rxcrd_null_credit[2]; 
   assign   `CFI_AGENT_2.rx_data_rxcrd_shared_2           = `TRANSACTORS_PATH.rx_data_rxcrd_shared[2];
   assign   `CFI_AGENT_2.rx_data_rxcrd_valid_2            = `TRANSACTORS_PATH.rx_data_rxcrd_valid[2];    

// TX Request connections 
   assign   `CFI_AGENT_2.tx_req_is_valid_2                = `TRANSACTORS_PATH.tx_req_is_valid[2]; 
   assign   `CFI_AGENT_2.tx_req_early_valid_2             = `TRANSACTORS_PATH.tx_req_early_valid[2]; 
   assign   `CFI_AGENT_2.tx_req_vc_id_2                   = `TRANSACTORS_PATH.tx_req_vc_id[2];
   assign   `CFI_AGENT_2.tx_req_protocol_id_2             = `TRANSACTORS_PATH.tx_req_protocol_id[2]; 
   assign   `CFI_AGENT_2.tx_req_header_2                  = `TRANSACTORS_PATH.tx_req_header[2];
   assign   `CFI_AGENT_2.tx_req_dstid_2                   = `TRANSACTORS_PATH.tx_req_dstid[2];
   assign   `CFI_AGENT_2.tx_req_rctrl_2                   = `TRANSACTORS_PATH.tx_req_rctrl[2];
   assign   `CFI_AGENT_2.tx_req_null_packet_2             = `TRANSACTORS_PATH.tx_req_null_packet[2]; 
   assign   `CFI_AGENT_2.tx_req_shared_credit_2           = `TRANSACTORS_PATH.tx_req_shared_credit[2]; 
   assign   `CFI_AGENT_2.tx_req_trace_packet_2            = `TRANSACTORS_PATH.tx_req_trace_packet[2]; 
   assign   `CFI_AGENT_2.tx_req_txblock_crd_flow_2        = `TRANSACTORS_PATH.tx_req_txblock_crd_flow[2];
   assign   `TRANSACTORS_PATH.tx_req_block[2]             = `CFI_AGENT_2.tx_req_block_2; 
   assign   `TRANSACTORS_PATH.tx_req_rxcrd_null_credit[2] = `CFI_AGENT_2.tx_req_rxcrd_null_credit_2; 
   assign   `TRANSACTORS_PATH.tx_req_rxcrd_shared[2]      = `CFI_AGENT_2.tx_req_rxcrd_shared_2; 
   assign   `TRANSACTORS_PATH.tx_req_rxcrd_valid[2]       = `CFI_AGENT_2.tx_req_rxcrd_valid_2;
   assign   `TRANSACTORS_PATH.tx_req_rxcrd_protocol_id[2] = `CFI_AGENT_2.tx_req_rxcrd_protocol_id_2;
   assign   `TRANSACTORS_PATH.tx_req_rxcrd_vc_id[2]       = `CFI_AGENT_2.tx_req_rxcrd_vc_id_2;
 
// TX Response connections 
   assign   `CFI_AGENT_2.tx_rsp_is_valid_2                = `TRANSACTORS_PATH.tx_rsp_is_valid[2]; 
   assign   `CFI_AGENT_2.tx_rsp_early_valid_2             = `TRANSACTORS_PATH.tx_rsp_early_valid[2]; 
   assign   `CFI_AGENT_2.tx_rsp_null_packet_2             = `TRANSACTORS_PATH.tx_rsp_null_packet[2]; 
   assign   `CFI_AGENT_2.tx_rsp_shared_credit_2           = `TRANSACTORS_PATH.tx_rsp_shared_credit[2];
   assign   `CFI_AGENT_2.tx_rsp_trace_packet_2            = `TRANSACTORS_PATH.tx_rsp_trace_packet[2]; 
   assign   `CFI_AGENT_2.tx_rsp_txblock_crd_flow_2        = `TRANSACTORS_PATH.tx_rsp_txblock_crd_flow[2];
   assign   `CFI_AGENT_2.tx_rsp_vc_id_2                   = `TRANSACTORS_PATH.tx_rsp_vc_id[2];
   assign   `CFI_AGENT_2.tx_rsp_protocol_id_2             = `TRANSACTORS_PATH.tx_rsp_protocol_id[2]; 
   assign   `CFI_AGENT_2.tx_rsp_header_2                  = `TRANSACTORS_PATH.tx_rsp_header[2];
   assign   `CFI_AGENT_2.tx_rsp_dstid_2                   = `TRANSACTORS_PATH.tx_rsp_dstid[2];
   assign   `CFI_AGENT_2.tx_rsp_rctrl_2                   = `TRANSACTORS_PATH.tx_rsp_rctrl[2];
   assign   `TRANSACTORS_PATH.tx_rsp_block[2]             = `CFI_AGENT_2.tx_rsp_block_2; 
   assign   `TRANSACTORS_PATH.tx_rsp_rxcrd_null_credit[2] = `CFI_AGENT_2.tx_rsp_rxcrd_null_credit_2; 
   assign   `TRANSACTORS_PATH.tx_rsp_rxcrd_shared[2]      = `CFI_AGENT_2.tx_rsp_rxcrd_shared_2; 
   assign   `TRANSACTORS_PATH.tx_rsp_rxcrd_valid[2]       = `CFI_AGENT_2.tx_rsp_rxcrd_valid_2;
   assign   `TRANSACTORS_PATH.tx_rsp_rxcrd_protocol_id[2] = `CFI_AGENT_2.tx_rsp_rxcrd_protocol_id_2;
   assign   `TRANSACTORS_PATH.tx_rsp_rxcrd_vc_id[2]       = `CFI_AGENT_2.tx_rsp_rxcrd_vc_id_2;

// TX Data connections 
   assign   `CFI_AGENT_2.tx_data_is_valid_2               = `TRANSACTORS_PATH.tx_data_is_valid[2];  
   assign   `CFI_AGENT_2.tx_data_early_valid_2            = `TRANSACTORS_PATH.tx_data_early_valid[2]; 
   assign   `CFI_AGENT_2.tx_data_null_packet_2            = `TRANSACTORS_PATH.tx_data_null_packet[2]; 
   assign   `CFI_AGENT_2.tx_data_shared_credit_2          = `TRANSACTORS_PATH.tx_data_shared_credit[2]; 
   assign   `CFI_AGENT_2.tx_data_trace_packet_2           = `TRANSACTORS_PATH.tx_data_trace_packet[2]; 
   assign   `CFI_AGENT_2.tx_data_protocol_id_2            = `TRANSACTORS_PATH.tx_data_protocol_id[2];  
   assign   `CFI_AGENT_2.tx_data_vc_id_2                  = `TRANSACTORS_PATH.tx_data_vc_id[2]; 
   assign   `CFI_AGENT_2.tx_data_header_2                 = `TRANSACTORS_PATH.tx_data_header[2];
   assign   `CFI_AGENT_2.tx_data_header_parity_2          = `TRANSACTORS_PATH.tx_data_header_parity[2];
   assign   `CFI_AGENT_2.tx_data_eop_2                    = `TRANSACTORS_PATH.tx_data_eop[2]; 
   assign   `CFI_AGENT_2.tx_data_payload_2                = `TRANSACTORS_PATH.tx_data_payload[2]; 
   assign   `CFI_AGENT_2.tx_data_dstid_2                  = `TRANSACTORS_PATH.tx_data_dstid[2];
   assign   `CFI_AGENT_2.tx_data_rctrl_2                  = `TRANSACTORS_PATH.tx_data_rctrl[2];
   assign   `CFI_AGENT_2.tx_data_txblock_crd_flow_2       = `TRANSACTORS_PATH.tx_data_txblock_crd_flow[2];
   assign   `CFI_AGENT_2.tx_data_poison_2                 = `TRANSACTORS_PATH.tx_data_poison[2];
   assign   `CFI_AGENT_2.tx_data_payload_par_2            = `TRANSACTORS_PATH.tx_data_payload_par[2];    
   assign   `TRANSACTORS_PATH.tx_data_block[2]              = `CFI_AGENT_2.tx_data_block_2;      
   assign   `TRANSACTORS_PATH.tx_data_rxcrd_null_credit[2]  = `CFI_AGENT_2.tx_data_rxcrd_null_credit_2;
   assign   `TRANSACTORS_PATH.tx_data_rxcrd_shared[2]       = `CFI_AGENT_2.tx_data_rxcrd_shared_2; 
   assign   `TRANSACTORS_PATH.tx_data_rxcrd_valid[2]        = `CFI_AGENT_2.tx_data_rxcrd_valid_2; 
   assign   `TRANSACTORS_PATH.tx_data_rxcrd_protocol_id[2]  = `CFI_AGENT_2.tx_data_rxcrd_protocol_id_2;
   assign   `TRANSACTORS_PATH.tx_data_rxcrd_vc_id[2]        = `CFI_AGENT_2.tx_data_rxcrd_vc_id_2;

   assign   `TRANSACTORS_PATH.rx_con_req[2]               = `CFI_AGENT_2.rx_con_req_2;
   assign   `CFI_AGENT_2.rx_con_ack_2                     = `TRANSACTORS_PATH.rx_con_ack[2];
   assign   `CFI_AGENT_2.tx_con_req_2                     = `TRANSACTORS_PATH.tx_con_req[2];
   assign   `TRANSACTORS_PATH.tx_con_ack[2]               = `CFI_AGENT_2.tx_con_ack_2;

   //assign   `TRANSACTORS_PATH.cfi_peer_clkack[2]         =  1'b0;
   //assign   `TRANSACTORS_PATH.cfi_rsp_peer_clkack[2]     =  1'b0;
   //assign   `TRANSACTORS_PATH.rx_ipc_read_high[2]        =  1'b0;
   //assign   `TRANSACTORS_PATH.rx_ipc_write_high[2]       =  1'b0;
