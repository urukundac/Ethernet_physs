//=================================================================================================================================
// CFI_FABRIC connections - USER MUST EDIT THE RIGHT HAND SIDE OF THE FOLLOWING ASSIGNMENTS AND DEFINE - WHEN NEEDED
//=================================================================================================================================
// CFI_FABRIC   connection #3

			`define 	CFI_AGENT_3 					`FPGA_TRANSACTORS_TOP       // example:  fpga_tcss_top.tcss_val_rtl.tcss.par_iom

   assign 		`TRANSACTORS_PATH.cfi_clk[3] 			   	= `CFI_AGENT_3.cfi_agent_clock_3; 
   assign 		`TRANSACTORS_PATH.cfi_rst_n[3] 				= `CFI_AGENT_3.cfi_agent_rst_n_3; 
      
// RX Request connections
   assign   `TRANSACTORS_PATH.rx_req_header[3]          	= `CFI_AGENT_3.rx_req_header_3; 
   assign   `TRANSACTORS_PATH.rx_req_dstid_or_crd[3]      = `CFI_AGENT_3.rx_req_dstid_or_crd_3;
   assign   `TRANSACTORS_PATH.rx_req_rctrl[3]             = `CFI_AGENT_3.rx_req_rctrl_3;
   assign   `TRANSACTORS_PATH.rx_req_vc_id[3]      	      = `CFI_AGENT_3.rx_req_vc_id_3;
   assign   `TRANSACTORS_PATH.rx_req_protocol_id[3]       = `CFI_AGENT_3.rx_req_protocol_id_3;  
   assign   `TRANSACTORS_PATH.rx_req_early_valid[3]       = `CFI_AGENT_3.rx_req_early_valid_3; 
   assign   `TRANSACTORS_PATH.rx_req_is_valid[3]          = `CFI_AGENT_3.rx_req_is_valid_3; 
   assign   `TRANSACTORS_PATH.rx_req_null_packet[3]       = `CFI_AGENT_3.rx_req_null_packet_3; 
   assign   `TRANSACTORS_PATH.rx_req_shared_credit[3]     = `CFI_AGENT_3.rx_req_shared_credit_3; 
   assign   `TRANSACTORS_PATH.rx_req_trace_packet[3]      = `CFI_AGENT_3.rx_req_trace_packet_3; 
   assign   `TRANSACTORS_PATH.rx_req_txblock_crd_flow[3]  = `CFI_AGENT_3.rx_req_txblock_crd_flow_3; 
   assign   `CFI_AGENT_3.rx_req_block_3                   = `TRANSACTORS_PATH.rx_req_block[3]; 
   assign   `CFI_AGENT_3.rx_req_rxcrd_null_credit_3       = `TRANSACTORS_PATH.rx_req_rxcrd_null_credit[3];
   assign   `CFI_AGENT_3.rx_req_rxcrd_shared_3            = `TRANSACTORS_PATH.rx_req_rxcrd_shared[3];
   assign   `CFI_AGENT_3.rx_req_rxcrd_valid_3             = `TRANSACTORS_PATH.rx_req_rxcrd_valid[3]; 
   assign   `CFI_AGENT_3.rx_req_rxcrd_protocol_id_3       = `TRANSACTORS_PATH.rx_req_rxcrd_protocol_id[3];
   assign   `CFI_AGENT_3.rx_req_rxcrd_vc_id_3             = `TRANSACTORS_PATH.rx_req_rxcrd_vc_id[3];
   
// RX Response connections
   assign   `TRANSACTORS_PATH.rx_rsp_is_valid[3]          = `CFI_AGENT_3.rx_rsp_is_valid_3;  
   assign   `TRANSACTORS_PATH.rx_rsp_early_valid[3]       = `CFI_AGENT_3.rx_rsp_early_valid_3; 
   assign   `TRANSACTORS_PATH.rx_rsp_null_packet[3]       = `CFI_AGENT_3.rx_rsp_null_packet_3;
   assign   `TRANSACTORS_PATH.rx_rsp_protocol_id[3]       = `CFI_AGENT_3.rx_rsp_protocol_id_3;   
   assign   `TRANSACTORS_PATH.rx_rsp_vc_id[3]             = `CFI_AGENT_3.rx_rsp_vc_id_3;
   assign   `TRANSACTORS_PATH.rx_rsp_header[3]            = `CFI_AGENT_3.rx_rsp_header_3; 
   assign   `TRANSACTORS_PATH.rx_rsp_dstid_or_crd[3]      = `CFI_AGENT_3.rx_rsp_dstid_or_crd_3;
   assign   `TRANSACTORS_PATH.rx_rsp_rctrl[3]             = `CFI_AGENT_3.rx_rsp_rctrl_3;
   assign   `TRANSACTORS_PATH.rx_rsp_shared_credit[3]     = `CFI_AGENT_3.rx_rsp_shared_credit_3; 
   assign   `TRANSACTORS_PATH.rx_rsp_trace_packet[3]      = `CFI_AGENT_3.rx_rsp_trace_packet_3; 
   assign   `TRANSACTORS_PATH.rx_rsp_txblock_crd_flow[3]  = `CFI_AGENT_3.rx_rsp_txblock_crd_flow_3;
   assign   `CFI_AGENT_3.rx_rsp_block_3                   = `TRANSACTORS_PATH.rx_rsp_block[3]; 
   assign   `CFI_AGENT_3.rx_rsp_rxcrd_null_credit_3       = `TRANSACTORS_PATH.rx_rsp_rxcrd_null_credit[3]; 
   assign   `CFI_AGENT_3.rx_rsp_rxcrd_shared_3            = `TRANSACTORS_PATH.rx_rsp_rxcrd_shared[3]; 
   assign   `CFI_AGENT_3.rx_rsp_rxcrd_valid_3             = `TRANSACTORS_PATH.rx_rsp_rxcrd_valid[3];
   assign   `CFI_AGENT_3.rx_rsp_rxcrd_protocol_id_3       = `TRANSACTORS_PATH.rx_rsp_rxcrd_protocol_id[3];
   assign   `CFI_AGENT_3.rx_rsp_rxcrd_vc_id_3             = `TRANSACTORS_PATH.rx_rsp_rxcrd_vc_id[3];

// RX Data connections 
   assign   `TRANSACTORS_PATH.rx_data_is_valid[3]         = `CFI_AGENT_3.rx_data_is_valid_3;  
   assign   `TRANSACTORS_PATH.rx_data_early_valid[3]      = `CFI_AGENT_3.rx_data_early_valid_3;
   assign   `TRANSACTORS_PATH.rx_data_null_packet[3]      = `CFI_AGENT_3.rx_data_null_packet_3; 
   assign   `TRANSACTORS_PATH.rx_data_vc_id[3]            = `CFI_AGENT_3.rx_data_vc_id_3;
   assign   `TRANSACTORS_PATH.rx_data_protocol_id[3]      = `CFI_AGENT_3.rx_data_protocol_id_3;    
   assign   `TRANSACTORS_PATH.rx_data_header[3]           = `CFI_AGENT_3.rx_data_header_3;
   assign   `TRANSACTORS_PATH.rx_data_header_parity[3]    = `CFI_AGENT_3.rx_data_header_parity_3;  
   assign   `TRANSACTORS_PATH.rx_data_dstid_or_crd[3]     = `CFI_AGENT_3.rx_data_dstid_or_crd_3;
   assign   `TRANSACTORS_PATH.rx_data_rctrl[3]            = `CFI_AGENT_3.rx_data_rctrl_3;
   assign   `TRANSACTORS_PATH.rx_data_payload[3]          = `CFI_AGENT_3.rx_data_payload_3; 
   assign   `TRANSACTORS_PATH.rx_data_payload_par[3]      = `CFI_AGENT_3.rx_data_payload_par_3; 
   assign   `TRANSACTORS_PATH.rx_data_poison[3]           = `CFI_AGENT_3.rx_data_poison_3; 
   assign   `TRANSACTORS_PATH.rx_data_eop[3]              = `CFI_AGENT_3.rx_data_eop_3;  
   assign   `TRANSACTORS_PATH.rx_data_shared_credit[3]    = `CFI_AGENT_3.rx_data_shared_credit_3; 
   assign   `TRANSACTORS_PATH.rx_data_trace_packet[3]     = `CFI_AGENT_3.rx_data_trace_packet_3; 
   assign   `TRANSACTORS_PATH.rx_data_txblock_crd_flow[3] = `CFI_AGENT_3.rx_data_txblock_crd_flow_3;
   assign   `CFI_AGENT_3.rx_data_rxcrd_vc_id_3            = `TRANSACTORS_PATH.rx_data_rxcrd_vc_id[3]; 
   assign   `CFI_AGENT_3.rx_data_rxcrd_protocol_id_3      = `TRANSACTORS_PATH.rx_data_rxcrd_protocol_id[3];
   assign   `CFI_AGENT_3.rx_data_block_3                  = `TRANSACTORS_PATH.rx_data_block[3]; 
   assign   `CFI_AGENT_3.rx_data_rxcrd_null_credit_3      = `TRANSACTORS_PATH.rx_data_rxcrd_null_credit[3]; 
   assign   `CFI_AGENT_3.rx_data_rxcrd_shared_3           = `TRANSACTORS_PATH.rx_data_rxcrd_shared[3];
   assign   `CFI_AGENT_3.rx_data_rxcrd_valid_3            = `TRANSACTORS_PATH.rx_data_rxcrd_valid[3];    

// TX Request connections 
   assign   `CFI_AGENT_3.tx_req_is_valid_3                = `TRANSACTORS_PATH.tx_req_is_valid[3]; 
   assign   `CFI_AGENT_3.tx_req_early_valid_3             = `TRANSACTORS_PATH.tx_req_early_valid[3]; 
   assign   `CFI_AGENT_3.tx_req_vc_id_3                   = `TRANSACTORS_PATH.tx_req_vc_id[3];
   assign   `CFI_AGENT_3.tx_req_protocol_id_3             = `TRANSACTORS_PATH.tx_req_protocol_id[3]; 
   assign   `CFI_AGENT_3.tx_req_header_3                  = `TRANSACTORS_PATH.tx_req_header[3];
   assign   `CFI_AGENT_3.tx_req_dstid_3                   = `TRANSACTORS_PATH.tx_req_dstid[3];
   assign   `CFI_AGENT_3.tx_req_rctrl_3                   = `TRANSACTORS_PATH.tx_req_rctrl[3];
   assign   `CFI_AGENT_3.tx_req_null_packet_3             = `TRANSACTORS_PATH.tx_req_null_packet[3]; 
   assign   `CFI_AGENT_3.tx_req_shared_credit_3           = `TRANSACTORS_PATH.tx_req_shared_credit[3]; 
   assign   `CFI_AGENT_3.tx_req_trace_packet_3            = `TRANSACTORS_PATH.tx_req_trace_packet[3]; 
   assign   `CFI_AGENT_3.tx_req_txblock_crd_flow_3        = `TRANSACTORS_PATH.tx_req_txblock_crd_flow[3];
   assign   `TRANSACTORS_PATH.tx_req_block[3]             = `CFI_AGENT_3.tx_req_block_3; 
   assign   `TRANSACTORS_PATH.tx_req_rxcrd_null_credit[3] = `CFI_AGENT_3.tx_req_rxcrd_null_credit_3; 
   assign   `TRANSACTORS_PATH.tx_req_rxcrd_shared[3]      = `CFI_AGENT_3.tx_req_rxcrd_shared_3; 
   assign   `TRANSACTORS_PATH.tx_req_rxcrd_valid[3]       = `CFI_AGENT_3.tx_req_rxcrd_valid_3;
   assign   `TRANSACTORS_PATH.tx_req_rxcrd_protocol_id[3] = `CFI_AGENT_3.tx_req_rxcrd_protocol_id_3;
   assign   `TRANSACTORS_PATH.tx_req_rxcrd_vc_id[3]       = `CFI_AGENT_3.tx_req_rxcrd_vc_id_3;
 
// TX Response connections 
   assign   `CFI_AGENT_3.tx_rsp_is_valid_3                = `TRANSACTORS_PATH.tx_rsp_is_valid[3]; 
   assign   `CFI_AGENT_3.tx_rsp_early_valid_3             = `TRANSACTORS_PATH.tx_rsp_early_valid[3]; 
   assign   `CFI_AGENT_3.tx_rsp_null_packet_3             = `TRANSACTORS_PATH.tx_rsp_null_packet[3]; 
   assign   `CFI_AGENT_3.tx_rsp_shared_credit_3           = `TRANSACTORS_PATH.tx_rsp_shared_credit[3];
   assign   `CFI_AGENT_3.tx_rsp_trace_packet_3            = `TRANSACTORS_PATH.tx_rsp_trace_packet[3]; 
   assign   `CFI_AGENT_3.tx_rsp_txblock_crd_flow_3        = `TRANSACTORS_PATH.tx_rsp_txblock_crd_flow[3];
   assign   `CFI_AGENT_3.tx_rsp_vc_id_3                   = `TRANSACTORS_PATH.tx_rsp_vc_id[3];
   assign   `CFI_AGENT_3.tx_rsp_protocol_id_3             = `TRANSACTORS_PATH.tx_rsp_protocol_id[3]; 
   assign   `CFI_AGENT_3.tx_rsp_header_3                  = `TRANSACTORS_PATH.tx_rsp_header[3];
   assign   `CFI_AGENT_3.tx_rsp_dstid_3                   = `TRANSACTORS_PATH.tx_rsp_dstid[3];
   assign   `CFI_AGENT_3.tx_rsp_rctrl_3                   = `TRANSACTORS_PATH.tx_rsp_rctrl[3];
   assign   `TRANSACTORS_PATH.tx_rsp_block[3]             = `CFI_AGENT_3.tx_rsp_block_3; 
   assign   `TRANSACTORS_PATH.tx_rsp_rxcrd_null_credit[3] = `CFI_AGENT_3.tx_rsp_rxcrd_null_credit_3; 
   assign   `TRANSACTORS_PATH.tx_rsp_rxcrd_shared[3]      = `CFI_AGENT_3.tx_rsp_rxcrd_shared_3; 
   assign   `TRANSACTORS_PATH.tx_rsp_rxcrd_valid[3]       = `CFI_AGENT_3.tx_rsp_rxcrd_valid_3;
   assign   `TRANSACTORS_PATH.tx_rsp_rxcrd_protocol_id[3] = `CFI_AGENT_3.tx_rsp_rxcrd_protocol_id_3;
   assign   `TRANSACTORS_PATH.tx_rsp_rxcrd_vc_id[3]       = `CFI_AGENT_3.tx_rsp_rxcrd_vc_id_3;

// TX Data connections 
   assign   `CFI_AGENT_3.tx_data_is_valid_3               = `TRANSACTORS_PATH.tx_data_is_valid[3];  
   assign   `CFI_AGENT_3.tx_data_early_valid_3            = `TRANSACTORS_PATH.tx_data_early_valid[3]; 
   assign   `CFI_AGENT_3.tx_data_null_packet_3            = `TRANSACTORS_PATH.tx_data_null_packet[3]; 
   assign   `CFI_AGENT_3.tx_data_shared_credit_3          = `TRANSACTORS_PATH.tx_data_shared_credit[3]; 
   assign   `CFI_AGENT_3.tx_data_trace_packet_3           = `TRANSACTORS_PATH.tx_data_trace_packet[3]; 
   assign   `CFI_AGENT_3.tx_data_protocol_id_3            = `TRANSACTORS_PATH.tx_data_protocol_id[3];  
   assign   `CFI_AGENT_3.tx_data_vc_id_3                  = `TRANSACTORS_PATH.tx_data_vc_id[3]; 
   assign   `CFI_AGENT_3.tx_data_header_3                 = `TRANSACTORS_PATH.tx_data_header[3];
   assign   `CFI_AGENT_3.tx_data_header_parity_3          = `TRANSACTORS_PATH.tx_data_header_parity[3];
   assign   `CFI_AGENT_3.tx_data_eop_3                    = `TRANSACTORS_PATH.tx_data_eop[3]; 
   assign   `CFI_AGENT_3.tx_data_payload_3                = `TRANSACTORS_PATH.tx_data_payload[3]; 
   assign   `CFI_AGENT_3.tx_data_dstid_3                  = `TRANSACTORS_PATH.tx_data_dstid[3];
   assign   `CFI_AGENT_3.tx_data_rctrl_3                  = `TRANSACTORS_PATH.tx_data_rctrl[3];
   assign   `CFI_AGENT_3.tx_data_txblock_crd_flow_3       = `TRANSACTORS_PATH.tx_data_txblock_crd_flow[3];
   assign   `CFI_AGENT_3.tx_data_poison_3                 = `TRANSACTORS_PATH.tx_data_poison[3];
   assign   `CFI_AGENT_3.tx_data_payload_par_3            = `TRANSACTORS_PATH.tx_data_payload_par[3];    
   assign   `TRANSACTORS_PATH.tx_data_block[3]              = `CFI_AGENT_3.tx_data_block_3;      
   assign   `TRANSACTORS_PATH.tx_data_rxcrd_null_credit[3]  = `CFI_AGENT_3.tx_data_rxcrd_null_credit_3;
   assign   `TRANSACTORS_PATH.tx_data_rxcrd_shared[3]       = `CFI_AGENT_3.tx_data_rxcrd_shared_3; 
   assign   `TRANSACTORS_PATH.tx_data_rxcrd_valid[3]        = `CFI_AGENT_3.tx_data_rxcrd_valid_3; 
   assign   `TRANSACTORS_PATH.tx_data_rxcrd_protocol_id[3]  = `CFI_AGENT_3.tx_data_rxcrd_protocol_id_3;
   assign   `TRANSACTORS_PATH.tx_data_rxcrd_vc_id[3]        = `CFI_AGENT_3.tx_data_rxcrd_vc_id_3;

   assign   `TRANSACTORS_PATH.rx_con_req[3]               = `CFI_AGENT_3.rx_con_req_3;
   assign   `CFI_AGENT_3.rx_con_ack_3                     = `TRANSACTORS_PATH.rx_con_ack[3];
   assign   `CFI_AGENT_3.tx_con_req_3                     = `TRANSACTORS_PATH.tx_con_req[3];
   assign   `TRANSACTORS_PATH.tx_con_ack[3]               = `CFI_AGENT_3.tx_con_ack_3;

   //assign   `TRANSACTORS_PATH.cfi_peer_clkack[3]         =  1'b0;
   //assign   `TRANSACTORS_PATH.cfi_rsp_peer_clkack[3]     =  1'b0;
   //assign   `TRANSACTORS_PATH.rx_ipc_read_high[3]        =  1'b0;
   //assign   `TRANSACTORS_PATH.rx_ipc_write_high[3]       =  1'b0;
