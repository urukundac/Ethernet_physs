//=================================================================================================================================
// CFI_FABRIC connections - USER MUST EDIT THE RIGHT HAND SIDE OF THE FOLLOWING ASSIGNMENTS AND DEFINE - WHEN NEEDED
//=================================================================================================================================
// CFI_FABRIC   connection #0

			`define 	CFI_AGENT_0 					`FPGA_TRANSACTORS_TOP       // example:  fpga_tcss_top.tcss_val_rtl.tcss.par_iom

   assign 		`TRANSACTORS_PATH.cfi_clk[0] 			   	= `CFI_AGENT_0.cfi_agent_clock_0; 
   assign 		`TRANSACTORS_PATH.cfi_rst_n[0] 				= `CFI_AGENT_0.cfi_agent_rst_n_0; 
      
// RX Request connections
   assign   `TRANSACTORS_PATH.rx_req_header[0]          	= `CFI_AGENT_0.rx_req_header_0; 
   assign   `TRANSACTORS_PATH.rx_req_dstid_or_crd[0]      = `CFI_AGENT_0.rx_req_dstid_or_crd_0;
   assign   `TRANSACTORS_PATH.rx_req_rctrl[0]             = `CFI_AGENT_0.rx_req_rctrl_0;
   assign   `TRANSACTORS_PATH.rx_req_vc_id[0]      	      = `CFI_AGENT_0.rx_req_vc_id_0;
   assign   `TRANSACTORS_PATH.rx_req_protocol_id[0]       = `CFI_AGENT_0.rx_req_protocol_id_0;  
   assign   `TRANSACTORS_PATH.rx_req_early_valid[0]       = `CFI_AGENT_0.rx_req_early_valid_0; 
   assign   `TRANSACTORS_PATH.rx_req_is_valid[0]          = `CFI_AGENT_0.rx_req_is_valid_0; 
   assign   `TRANSACTORS_PATH.rx_req_null_packet[0]       = `CFI_AGENT_0.rx_req_null_packet_0; 
   assign   `TRANSACTORS_PATH.rx_req_shared_credit[0]     = `CFI_AGENT_0.rx_req_shared_credit_0; 
   assign   `TRANSACTORS_PATH.rx_req_trace_packet[0]      = `CFI_AGENT_0.rx_req_trace_packet_0; 
   assign   `TRANSACTORS_PATH.rx_req_txblock_crd_flow[0]  = `CFI_AGENT_0.rx_req_txblock_crd_flow_0; 
   assign   `CFI_AGENT_0.rx_req_block_0                   = `TRANSACTORS_PATH.rx_req_block[0]; 
   assign   `CFI_AGENT_0.rx_req_rxcrd_null_credit_0       = `TRANSACTORS_PATH.rx_req_rxcrd_null_credit[0];
   assign   `CFI_AGENT_0.rx_req_rxcrd_shared_0            = `TRANSACTORS_PATH.rx_req_rxcrd_shared[0];
   assign   `CFI_AGENT_0.rx_req_rxcrd_valid_0             = `TRANSACTORS_PATH.rx_req_rxcrd_valid[0]; 
   assign   `CFI_AGENT_0.rx_req_rxcrd_protocol_id_0       = `TRANSACTORS_PATH.rx_req_rxcrd_protocol_id[0];
   assign   `CFI_AGENT_0.rx_req_rxcrd_vc_id_0             = `TRANSACTORS_PATH.rx_req_rxcrd_vc_id[0];
   
// RX Response connections
   assign   `TRANSACTORS_PATH.rx_rsp_is_valid[0]          = `CFI_AGENT_0.rx_rsp_is_valid_0;  
   assign   `TRANSACTORS_PATH.rx_rsp_early_valid[0]       = `CFI_AGENT_0.rx_rsp_early_valid_0; 
   assign   `TRANSACTORS_PATH.rx_rsp_null_packet[0]       = `CFI_AGENT_0.rx_rsp_null_packet_0;
   assign   `TRANSACTORS_PATH.rx_rsp_protocol_id[0]       = `CFI_AGENT_0.rx_rsp_protocol_id_0;   
   assign   `TRANSACTORS_PATH.rx_rsp_vc_id[0]             = `CFI_AGENT_0.rx_rsp_vc_id_0;
   assign   `TRANSACTORS_PATH.rx_rsp_header[0]            = `CFI_AGENT_0.rx_rsp_header_0; 
   assign   `TRANSACTORS_PATH.rx_rsp_dstid_or_crd[0]      = `CFI_AGENT_0.rx_rsp_dstid_or_crd_0;
   assign   `TRANSACTORS_PATH.rx_rsp_rctrl[0]             = `CFI_AGENT_0.rx_rsp_rctrl_0;
   assign   `TRANSACTORS_PATH.rx_rsp_shared_credit[0]     = `CFI_AGENT_0.rx_rsp_shared_credit_0; 
   assign   `TRANSACTORS_PATH.rx_rsp_trace_packet[0]      = `CFI_AGENT_0.rx_rsp_trace_packet_0; 
   assign   `TRANSACTORS_PATH.rx_rsp_txblock_crd_flow[0]  = `CFI_AGENT_0.rx_rsp_txblock_crd_flow_0;
   assign   `CFI_AGENT_0.rx_rsp_block_0                   = `TRANSACTORS_PATH.rx_rsp_block[0]; 
   assign   `CFI_AGENT_0.rx_rsp_rxcrd_null_credit_0       = `TRANSACTORS_PATH.rx_rsp_rxcrd_null_credit[0]; 
   assign   `CFI_AGENT_0.rx_rsp_rxcrd_shared_0            = `TRANSACTORS_PATH.rx_rsp_rxcrd_shared[0]; 
   assign   `CFI_AGENT_0.rx_rsp_rxcrd_valid_0             = `TRANSACTORS_PATH.rx_rsp_rxcrd_valid[0];
   assign   `CFI_AGENT_0.rx_rsp_rxcrd_protocol_id_0       = `TRANSACTORS_PATH.rx_rsp_rxcrd_protocol_id[0];
   assign   `CFI_AGENT_0.rx_rsp_rxcrd_vc_id_0             = `TRANSACTORS_PATH.rx_rsp_rxcrd_vc_id[0];

// RX Data connections 
   assign   `TRANSACTORS_PATH.rx_data_is_valid[0]         = `CFI_AGENT_0.rx_data_is_valid_0;  
   assign   `TRANSACTORS_PATH.rx_data_early_valid[0]      = `CFI_AGENT_0.rx_data_early_valid_0;
   assign   `TRANSACTORS_PATH.rx_data_null_packet[0]      = `CFI_AGENT_0.rx_data_null_packet_0; 
   assign   `TRANSACTORS_PATH.rx_data_vc_id[0]            = `CFI_AGENT_0.rx_data_vc_id_0;
   assign   `TRANSACTORS_PATH.rx_data_protocol_id[0]      = `CFI_AGENT_0.rx_data_protocol_id_0;    
   assign   `TRANSACTORS_PATH.rx_data_header[0]           = `CFI_AGENT_0.rx_data_header_0;
   assign   `TRANSACTORS_PATH.rx_data_header_parity[0]    = `CFI_AGENT_0.rx_data_header_parity_0;  
   assign   `TRANSACTORS_PATH.rx_data_dstid_or_crd[0]     = `CFI_AGENT_0.rx_data_dstid_or_crd_0;
   assign   `TRANSACTORS_PATH.rx_data_rctrl[0]            = `CFI_AGENT_0.rx_data_rctrl_0;
   assign   `TRANSACTORS_PATH.rx_data_payload[0]          = `CFI_AGENT_0.rx_data_payload_0; 
   assign   `TRANSACTORS_PATH.rx_data_payload_par[0]      = `CFI_AGENT_0.rx_data_payload_par_0; 
   assign   `TRANSACTORS_PATH.rx_data_poison[0]           = `CFI_AGENT_0.rx_data_poison_0; 
   assign   `TRANSACTORS_PATH.rx_data_eop[0]              = `CFI_AGENT_0.rx_data_eop_0;  
   assign   `TRANSACTORS_PATH.rx_data_shared_credit[0]    = `CFI_AGENT_0.rx_data_shared_credit_0; 
   assign   `TRANSACTORS_PATH.rx_data_trace_packet[0]     = `CFI_AGENT_0.rx_data_trace_packet_0; 
   assign   `TRANSACTORS_PATH.rx_data_txblock_crd_flow[0] = `CFI_AGENT_0.rx_data_txblock_crd_flow_0;
   assign   `CFI_AGENT_0.rx_data_rxcrd_vc_id_0            = `TRANSACTORS_PATH.rx_data_rxcrd_vc_id[0]; 
   assign   `CFI_AGENT_0.rx_data_rxcrd_protocol_id_0      = `TRANSACTORS_PATH.rx_data_rxcrd_protocol_id[0];
   assign   `CFI_AGENT_0.rx_data_block_0                  = `TRANSACTORS_PATH.rx_data_block[0]; 
   assign   `CFI_AGENT_0.rx_data_rxcrd_null_credit_0      = `TRANSACTORS_PATH.rx_data_rxcrd_null_credit[0]; 
   assign   `CFI_AGENT_0.rx_data_rxcrd_shared_0           = `TRANSACTORS_PATH.rx_data_rxcrd_shared[0];
   assign   `CFI_AGENT_0.rx_data_rxcrd_valid_0            = `TRANSACTORS_PATH.rx_data_rxcrd_valid[0];    

// TX Request connections 
   assign   `CFI_AGENT_0.tx_req_is_valid_0                = `TRANSACTORS_PATH.tx_req_is_valid[0]; 
   assign   `CFI_AGENT_0.tx_req_early_valid_0             = `TRANSACTORS_PATH.tx_req_early_valid[0]; 
   assign   `CFI_AGENT_0.tx_req_vc_id_0                   = `TRANSACTORS_PATH.tx_req_vc_id[0];
   assign   `CFI_AGENT_0.tx_req_protocol_id_0             = `TRANSACTORS_PATH.tx_req_protocol_id[0]; 
   assign   `CFI_AGENT_0.tx_req_header_0                  = `TRANSACTORS_PATH.tx_req_header[0];
   assign   `CFI_AGENT_0.tx_req_dstid_0                   = `TRANSACTORS_PATH.tx_req_dstid[0];
   assign   `CFI_AGENT_0.tx_req_rctrl_0                   = `TRANSACTORS_PATH.tx_req_rctrl[0];
   assign   `CFI_AGENT_0.tx_req_null_packet_0             = `TRANSACTORS_PATH.tx_req_null_packet[0]; 
   assign   `CFI_AGENT_0.tx_req_shared_credit_0           = `TRANSACTORS_PATH.tx_req_shared_credit[0]; 
   assign   `CFI_AGENT_0.tx_req_trace_packet_0            = `TRANSACTORS_PATH.tx_req_trace_packet[0]; 
   assign   `CFI_AGENT_0.tx_req_txblock_crd_flow_0        = `TRANSACTORS_PATH.tx_req_txblock_crd_flow[0];
   assign   `TRANSACTORS_PATH.tx_req_block[0]             = `CFI_AGENT_0.tx_req_block_0; 
   assign   `TRANSACTORS_PATH.tx_req_rxcrd_null_credit[0] = `CFI_AGENT_0.tx_req_rxcrd_null_credit_0; 
   assign   `TRANSACTORS_PATH.tx_req_rxcrd_shared[0]      = `CFI_AGENT_0.tx_req_rxcrd_shared_0; 
   assign   `TRANSACTORS_PATH.tx_req_rxcrd_valid[0]       = `CFI_AGENT_0.tx_req_rxcrd_valid_0;
   assign   `TRANSACTORS_PATH.tx_req_rxcrd_protocol_id[0] = `CFI_AGENT_0.tx_req_rxcrd_protocol_id_0;
   assign   `TRANSACTORS_PATH.tx_req_rxcrd_vc_id[0]       = `CFI_AGENT_0.tx_req_rxcrd_vc_id_0;
 
// TX Response connections 
   assign   `CFI_AGENT_0.tx_rsp_is_valid_0                = `TRANSACTORS_PATH.tx_rsp_is_valid[0]; 
   assign   `CFI_AGENT_0.tx_rsp_early_valid_0             = `TRANSACTORS_PATH.tx_rsp_early_valid[0]; 
   assign   `CFI_AGENT_0.tx_rsp_null_packet_0             = `TRANSACTORS_PATH.tx_rsp_null_packet[0]; 
   assign   `CFI_AGENT_0.tx_rsp_shared_credit_0           = `TRANSACTORS_PATH.tx_rsp_shared_credit[0];
   assign   `CFI_AGENT_0.tx_rsp_trace_packet_0            = `TRANSACTORS_PATH.tx_rsp_trace_packet[0]; 
   assign   `CFI_AGENT_0.tx_rsp_txblock_crd_flow_0        = `TRANSACTORS_PATH.tx_rsp_txblock_crd_flow[0];
   assign   `CFI_AGENT_0.tx_rsp_vc_id_0                   = `TRANSACTORS_PATH.tx_rsp_vc_id[0];
   assign   `CFI_AGENT_0.tx_rsp_protocol_id_0             = `TRANSACTORS_PATH.tx_rsp_protocol_id[0]; 
   assign   `CFI_AGENT_0.tx_rsp_header_0                  = `TRANSACTORS_PATH.tx_rsp_header[0];
   assign   `CFI_AGENT_0.tx_rsp_dstid_0                   = `TRANSACTORS_PATH.tx_rsp_dstid[0];
   assign   `CFI_AGENT_0.tx_rsp_rctrl_0                   = `TRANSACTORS_PATH.tx_rsp_rctrl[0];
   assign   `TRANSACTORS_PATH.tx_rsp_block[0]             = `CFI_AGENT_0.tx_rsp_block_0; 
   assign   `TRANSACTORS_PATH.tx_rsp_rxcrd_null_credit[0] = `CFI_AGENT_0.tx_rsp_rxcrd_null_credit_0; 
   assign   `TRANSACTORS_PATH.tx_rsp_rxcrd_shared[0]      = `CFI_AGENT_0.tx_rsp_rxcrd_shared_0; 
   assign   `TRANSACTORS_PATH.tx_rsp_rxcrd_valid[0]       = `CFI_AGENT_0.tx_rsp_rxcrd_valid_0;
   assign   `TRANSACTORS_PATH.tx_rsp_rxcrd_protocol_id[0] = `CFI_AGENT_0.tx_rsp_rxcrd_protocol_id_0;
   assign   `TRANSACTORS_PATH.tx_rsp_rxcrd_vc_id[0]       = `CFI_AGENT_0.tx_rsp_rxcrd_vc_id_0;

// TX Data connections 
   assign   `CFI_AGENT_0.tx_data_is_valid_0               = `TRANSACTORS_PATH.tx_data_is_valid[0];  
   assign   `CFI_AGENT_0.tx_data_early_valid_0            = `TRANSACTORS_PATH.tx_data_early_valid[0]; 
   assign   `CFI_AGENT_0.tx_data_null_packet_0            = `TRANSACTORS_PATH.tx_data_null_packet[0]; 
   assign   `CFI_AGENT_0.tx_data_shared_credit_0          = `TRANSACTORS_PATH.tx_data_shared_credit[0]; 
   assign   `CFI_AGENT_0.tx_data_trace_packet_0           = `TRANSACTORS_PATH.tx_data_trace_packet[0]; 
   assign   `CFI_AGENT_0.tx_data_protocol_id_0            = `TRANSACTORS_PATH.tx_data_protocol_id[0];  
   assign   `CFI_AGENT_0.tx_data_vc_id_0                  = `TRANSACTORS_PATH.tx_data_vc_id[0]; 
   assign   `CFI_AGENT_0.tx_data_header_0                 = `TRANSACTORS_PATH.tx_data_header[0];
   assign   `CFI_AGENT_0.tx_data_header_parity_0          = `TRANSACTORS_PATH.tx_data_header_parity[0];
   assign   `CFI_AGENT_0.tx_data_eop_0                    = `TRANSACTORS_PATH.tx_data_eop[0]; 
   assign   `CFI_AGENT_0.tx_data_payload_0                = `TRANSACTORS_PATH.tx_data_payload[0]; 
   assign   `CFI_AGENT_0.tx_data_dstid_0                  = `TRANSACTORS_PATH.tx_data_dstid[0];
   assign   `CFI_AGENT_0.tx_data_rctrl_0                  = `TRANSACTORS_PATH.tx_data_rctrl[0];
   assign   `CFI_AGENT_0.tx_data_txblock_crd_flow_0       = `TRANSACTORS_PATH.tx_data_txblock_crd_flow[0];
   assign   `CFI_AGENT_0.tx_data_poison_0                 = `TRANSACTORS_PATH.tx_data_poison[0];
   assign   `CFI_AGENT_0.tx_data_payload_par_0            = `TRANSACTORS_PATH.tx_data_payload_par[0];    
   assign   `TRANSACTORS_PATH.tx_data_block[0]              = `CFI_AGENT_0.tx_data_block_0;      
   assign   `TRANSACTORS_PATH.tx_data_rxcrd_null_credit[0]  = `CFI_AGENT_0.tx_data_rxcrd_null_credit_0;
   assign   `TRANSACTORS_PATH.tx_data_rxcrd_shared[0]       = `CFI_AGENT_0.tx_data_rxcrd_shared_0; 
   assign   `TRANSACTORS_PATH.tx_data_rxcrd_valid[0]        = `CFI_AGENT_0.tx_data_rxcrd_valid_0; 
   assign   `TRANSACTORS_PATH.tx_data_rxcrd_protocol_id[0]  = `CFI_AGENT_0.tx_data_rxcrd_protocol_id_0;
   assign   `TRANSACTORS_PATH.tx_data_rxcrd_vc_id[0]        = `CFI_AGENT_0.tx_data_rxcrd_vc_id_0;

   assign   `TRANSACTORS_PATH.rx_con_req[0]               = `CFI_AGENT_0.rx_con_req_0;
   assign   `CFI_AGENT_0.rx_con_ack_0                     = `TRANSACTORS_PATH.rx_con_ack[0];
   assign   `CFI_AGENT_0.tx_con_req_0                     = `TRANSACTORS_PATH.tx_con_req[0];
   assign   `TRANSACTORS_PATH.tx_con_ack[0]               = `CFI_AGENT_0.tx_con_ack_0;

   //assign   `TRANSACTORS_PATH.cfi_peer_clkack[0]         =  1'b0;
   //assign   `TRANSACTORS_PATH.cfi_rsp_peer_clkack[0]     =  1'b0;
   //assign   `TRANSACTORS_PATH.rx_ipc_read_high[0]        =  1'b0;
   //assign   `TRANSACTORS_PATH.rx_ipc_write_high[0]       =  1'b0;
