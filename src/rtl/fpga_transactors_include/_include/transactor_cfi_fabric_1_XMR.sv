//=================================================================================================================================
// CFI_FABRIC connections - USER MUST EDIT THE RIGHT HAND SIDE OF THE FOLLOWING ASSIGNMENTS AND DEFINE - WHEN NEEDED
//=================================================================================================================================
// CFI_FABRIC   connection #0

			`define 	CFI_AGENT_1 					fpga_transactors_top_inst       // example:  fpga_tcss_top.tcss_val_rtl.tcss.par_iom

   assign 		`TRANSACTORS_PATH.cfi_clk[1] 			   	= `CFI_AGENT_1.cfi_agent_clock_1; 
   assign 		`TRANSACTORS_PATH.cfi_rst_n[1] 				= `CFI_AGENT_1.cfi_agent_rst_n_1; 
      
// RX Request connections
   assign   `TRANSACTORS_PATH.rx_req_header[1]          	= `CFI_AGENT_1.rx_req_header_1; 
   assign   `TRANSACTORS_PATH.rx_req_dstid_or_crd[1]      = `CFI_AGENT_1.rx_req_dstid_or_crd_1;
   assign   `TRANSACTORS_PATH.rx_req_rctrl[1]             = `CFI_AGENT_0.rx_req_rctrl_1;
   assign   `TRANSACTORS_PATH.rx_req_vc_id[1]      	      = `CFI_AGENT_1.rx_req_vc_id_1;
   assign   `TRANSACTORS_PATH.rx_req_protocol_id[1]       = `CFI_AGENT_1.rx_req_protocol_id_1;  
   assign   `TRANSACTORS_PATH.rx_req_early_valid[1]       = `CFI_AGENT_1.rx_req_early_valid_1; 
   assign   `TRANSACTORS_PATH.rx_req_is_valid[1]          = `CFI_AGENT_1.rx_req_is_valid_1; 
   assign   `TRANSACTORS_PATH.rx_req_null_packet[1]       = `CFI_AGENT_1.rx_req_null_packet_1; 
   assign   `TRANSACTORS_PATH.rx_req_shared_credit[1]     = `CFI_AGENT_1.rx_req_shared_credit_1; 
   assign   `TRANSACTORS_PATH.rx_req_trace_packet[1]      = `CFI_AGENT_1.rx_req_trace_packet_1; 
   assign   `TRANSACTORS_PATH.rx_req_txblock_crd_flow[1]  = `CFI_AGENT_1.rx_req_txblock_crd_flow_1; 
   assign   `CFI_AGENT_1.rx_req_block_1                   = `TRANSACTORS_PATH.rx_req_block[1]; 
   assign   `CFI_AGENT_1.rx_req_rxcrd_null_credit_1       = `TRANSACTORS_PATH.rx_req_rxcrd_null_credit[1];
   assign   `CFI_AGENT_1.rx_req_rxcrd_shared_1            = `TRANSACTORS_PATH.rx_req_rxcrd_shared[1];
   assign   `CFI_AGENT_1.rx_req_rxcrd_valid_1             = `TRANSACTORS_PATH.rx_req_rxcrd_valid[1]; 
   assign   `CFI_AGENT_1.rx_req_rxcrd_protocol_id_1       = `TRANSACTORS_PATH.rx_req_rxcrd_protocol_id[1];
   assign   `CFI_AGENT_1.rx_req_rxcrd_vc_id_1             = `TRANSACTORS_PATH.rx_req_rxcrd_vc_id[1];
   
// RX Response connections
   assign   `TRANSACTORS_PATH.rx_rsp_is_valid[1]          = `CFI_AGENT_1.rx_rsp_is_valid_1;  
   assign   `TRANSACTORS_PATH.rx_rsp_early_valid[1]       = `CFI_AGENT_1.rx_rsp_early_valid_1; 
   assign   `TRANSACTORS_PATH.rx_rsp_null_packet[1]       = `CFI_AGENT_1.rx_rsp_null_packet_1;
   assign   `TRANSACTORS_PATH.rx_rsp_protocol_id[1]       = `CFI_AGENT_1.rx_rsp_protocol_id_1;   
   assign   `TRANSACTORS_PATH.rx_rsp_vc_id[1]             = `CFI_AGENT_1.rx_rsp_vc_id_1;
   assign   `TRANSACTORS_PATH.rx_rsp_header[1]            = `CFI_AGENT_1.rx_rsp_header_1; 
   assign   `TRANSACTORS_PATH.rx_rsp_dstid_or_crd[1]      = `CFI_AGENT_1.rx_rsp_dstid_or_crd_1;
   assign   `TRANSACTORS_PATH.rx_rsp_rctrl[1]             = `CFI_AGENT_0.rx_rsp_rctrl_1;
   assign   `TRANSACTORS_PATH.rx_rsp_shared_credit[1]     = `CFI_AGENT_1.rx_rsp_shared_credit_1; 
   assign   `TRANSACTORS_PATH.rx_rsp_trace_packet[1]      = `CFI_AGENT_1.rx_rsp_trace_packet_1; 
   assign   `TRANSACTORS_PATH.rx_rsp_txblock_crd_flow[1]  = `CFI_AGENT_1.rx_rsp_txblock_crd_flow_1;
   assign   `CFI_AGENT_1.rx_rsp_block_1                   = `TRANSACTORS_PATH.rx_rsp_block[1]; 
   assign   `CFI_AGENT_1.rx_rsp_rxcrd_null_credit_1       = `TRANSACTORS_PATH.rx_rsp_rxcrd_null_credit[1]; 
   assign   `CFI_AGENT_1.rx_rsp_rxcrd_shared_1            = `TRANSACTORS_PATH.rx_rsp_rxcrd_shared[1]; 
   assign   `CFI_AGENT_1.rx_rsp_rxcrd_valid_1             = `TRANSACTORS_PATH.rx_rsp_rxcrd_valid[1];
   assign   `CFI_AGENT_1.rx_rsp_rxcrd_protocol_id_1       = `TRANSACTORS_PATH.rx_rsp_rxcrd_protocol_id[1];
   assign   `CFI_AGENT_1.rx_rsp_rxcrd_vc_id_1             = `TRANSACTORS_PATH.rx_rsp_rxcrd_vc_id[1];

// RX Data connections 
   assign   `TRANSACTORS_PATH.rx_data_is_valid[1]         = `CFI_AGENT_1.rx_data_is_valid_1;  
   assign   `TRANSACTORS_PATH.rx_data_early_valid[1]      = `CFI_AGENT_1.rx_data_early_valid_1;
   assign   `TRANSACTORS_PATH.rx_data_null_packet[1]      = `CFI_AGENT_1.rx_data_null_packet_1; 
   assign   `TRANSACTORS_PATH.rx_data_vc_id[1]            = `CFI_AGENT_1.rx_data_vc_id_1;
   assign   `TRANSACTORS_PATH.rx_data_protocol_id[1]      = `CFI_AGENT_1.rx_data_protocol_id_1;    
   assign   `TRANSACTORS_PATH.rx_data_header[1]           = `CFI_AGENT_1.rx_data_header_1; 
   assign   `TRANSACTORS_PATH.rx_data_dstid_or_crd[1]     = `CFI_AGENT_1.rx_data_dstid_or_crd_1;
   assign   `TRANSACTORS_PATH.rx_data_rctrl[1]            = `CFI_AGENT_0.rx_data_rctrl_1;
   assign   `TRANSACTORS_PATH.rx_data_payload[1]          = `CFI_AGENT_1.rx_data_payload_1; 
   assign   `TRANSACTORS_PATH.rx_data_payload_par[1]      = `CFI_AGENT_1.rx_data_payload_par_1; 
   assign   `TRANSACTORS_PATH.rx_data_poison[1]           = `CFI_AGENT_1.rx_data_poison_1; 
   assign   `TRANSACTORS_PATH.rx_data_eop[1]              = `CFI_AGENT_1.rx_data_eop_1;  
   assign   `TRANSACTORS_PATH.rx_data_shared_credit[1]    = `CFI_AGENT_1.rx_data_shared_credit_1; 
   assign   `TRANSACTORS_PATH.rx_data_trace_packet[1]     = `CFI_AGENT_1.rx_data_trace_packet_1; 
   assign   `TRANSACTORS_PATH.rx_data_txblock_crd_flow[1] = `CFI_AGENT_1.rx_data_txblock_crd_flow_1;
   assign   `CFI_AGENT_1.rx_data_rxcrd_vc_id_1            = `TRANSACTORS_PATH.rx_data_rxcrd_vc_id[1]; 
   assign   `CFI_AGENT_1.rx_data_rxcrd_protocol_id_1      = `TRANSACTORS_PATH.rx_data_rxcrd_protocol_id[1];
   assign   `CFI_AGENT_1.rx_data_block_1                  = `TRANSACTORS_PATH.rx_data_block[1]; 
   assign   `CFI_AGENT_1.rx_data_rxcrd_null_credit_1      = `TRANSACTORS_PATH.rx_data_rxcrd_null_credit[1]; 
   assign   `CFI_AGENT_1.rx_data_rxcrd_shared_1           = `TRANSACTORS_PATH.rx_data_rxcrd_shared[1];
   assign   `CFI_AGENT_1.rx_data_rxcrd_valid_1            = `TRANSACTORS_PATH.rx_data_rxcrd_valid[1];    

// TX Request connections 
   assign   `CFI_AGENT_1.tx_req_is_valid_1                = `TRANSACTORS_PATH.tx_req_is_valid[1]; 
   assign   `CFI_AGENT_1.tx_req_early_valid_1             = `TRANSACTORS_PATH.tx_req_early_valid[1]; 
   assign   `CFI_AGENT_1.tx_req_vc_id_1                   = `TRANSACTORS_PATH.tx_req_vc_id[1];
   assign   `CFI_AGENT_1.tx_req_protocol_id_1             = `TRANSACTORS_PATH.tx_req_protocol_id[1]; 
   assign   `CFI_AGENT_1.tx_req_header_1                  = `TRANSACTORS_PATH.tx_req_header[1];
   assign   `CFI_AGENT_1.tx_req_dstid_1                   = `TRANSACTORS_PATH.tx_req_dstid[1];
   assign   `CFI_AGENT_0.tx_req_rctrl_1                   = `TRANSACTORS_PATH.tx_req_rctrl[1];
   assign   `CFI_AGENT_1.tx_req_null_packet_1             = `TRANSACTORS_PATH.tx_req_null_packet[1]; 
   assign   `CFI_AGENT_1.tx_req_shared_credit_1           = `TRANSACTORS_PATH.tx_req_shared_credit[1]; 
   assign   `CFI_AGENT_1.tx_req_trace_packet_1            = `TRANSACTORS_PATH.tx_req_trace_packet[1]; 
   assign   `CFI_AGENT_1.tx_req_txblock_crd_flow_1        = `TRANSACTORS_PATH.tx_req_txblock_crd_flow[1];
   assign   `TRANSACTORS_PATH.tx_req_block[1]             = `CFI_AGENT_1.tx_req_block_1; 
   assign   `TRANSACTORS_PATH.tx_req_rxcrd_null_credit[1] = `CFI_AGENT_1.tx_req_rxcrd_null_credit_1; 
   assign   `TRANSACTORS_PATH.tx_req_rxcrd_shared[1]      = `CFI_AGENT_1.tx_req_rxcrd_shared_1; 
   assign   `TRANSACTORS_PATH.tx_req_rxcrd_valid[1]       = `CFI_AGENT_1.tx_req_rxcrd_valid_1;
   assign   `TRANSACTORS_PATH.tx_req_rxcrd_protocol_id[1] = `CFI_AGENT_1.tx_req_rxcrd_protocol_id_1;
   assign   `TRANSACTORS_PATH.tx_req_rxcrd_vc_id[1]       = `CFI_AGENT_1.tx_req_rxcrd_vc_id_1;
 
// TX Response connections 
   assign   `CFI_AGENT_1.tx_rsp_is_valid_1                = `TRANSACTORS_PATH.tx_rsp_is_valid[1]; 
   assign   `CFI_AGENT_1.tx_rsp_early_valid_1             = `TRANSACTORS_PATH.tx_rsp_early_valid[1]; 
   assign   `CFI_AGENT_1.tx_rsp_null_packet_1             = `TRANSACTORS_PATH.tx_rsp_null_packet[1]; 
   assign   `CFI_AGENT_1.tx_rsp_shared_credit_1           = `TRANSACTORS_PATH.tx_rsp_shared_credit[1];
   assign   `CFI_AGENT_1.tx_rsp_trace_packet_1            = `TRANSACTORS_PATH.tx_rsp_trace_packet[1]; 
   assign   `CFI_AGENT_1.tx_rsp_txblock_crd_flow_1        = `TRANSACTORS_PATH.tx_rsp_txblock_crd_flow[1];
   assign   `CFI_AGENT_1.tx_rsp_vc_id_1                   = `TRANSACTORS_PATH.tx_rsp_vc_id[1];
   assign   `CFI_AGENT_1.tx_rsp_protocol_id_1             = `TRANSACTORS_PATH.tx_rsp_protocol_id[1]; 
   assign   `CFI_AGENT_1.tx_rsp_header_1                  = `TRANSACTORS_PATH.tx_rsp_header[1];
   assign   `CFI_AGENT_1.tx_rsp_dstid_1                   = `TRANSACTORS_PATH.tx_rsp_dstid[1];
   assign   `CFI_AGENT_0.tx_rsp_rctrl_1                   = `TRANSACTORS_PATH.tx_rsp_rctrl[1];
   assign   `TRANSACTORS_PATH.tx_rsp_block[1]             = `CFI_AGENT_1.tx_rsp_block_1; 
   assign   `TRANSACTORS_PATH.tx_rsp_rxcrd_null_credit[1] = `CFI_AGENT_1.tx_rsp_rxcrd_null_credit_1; 
   assign   `TRANSACTORS_PATH.tx_rsp_rxcrd_shared[1]      = `CFI_AGENT_1.tx_rsp_rxcrd_shared_1; 
   assign   `TRANSACTORS_PATH.tx_rsp_rxcrd_valid[1]       = `CFI_AGENT_1.tx_rsp_rxcrd_valid_1;
   assign   `TRANSACTORS_PATH.tx_rsp_rxcrd_protocol_id[1] = `CFI_AGENT_1.tx_rsp_rxcrd_protocol_id_1;
   assign   `TRANSACTORS_PATH.tx_rsp_rxcrd_vc_id[1]       = `CFI_AGENT_1.tx_rsp_rxcrd_vc_id_1;

// TX Data connections 
   assign   `CFI_AGENT_1.tx_data_is_valid_1               = `TRANSACTORS_PATH.tx_data_is_valid[1];  
   assign   `CFI_AGENT_1.tx_data_early_valid_1            = `TRANSACTORS_PATH.tx_data_early_valid[1]; 
   assign   `CFI_AGENT_1.tx_data_null_packet_1            = `TRANSACTORS_PATH.tx_data_null_packet[1]; 
   assign   `CFI_AGENT_1.tx_data_shared_credit_1          = `TRANSACTORS_PATH.tx_data_shared_credit[1]; 
   assign   `CFI_AGENT_1.tx_data_trace_packet_1           = `TRANSACTORS_PATH.tx_data_trace_packet[1]; 
   assign   `CFI_AGENT_1.tx_data_protocol_id_1            = `TRANSACTORS_PATH.tx_data_protocol_id[1];  
   assign   `CFI_AGENT_1.tx_data_vc_id_1                  = `TRANSACTORS_PATH.tx_data_vc_id[1]; 
   assign   `CFI_AGENT_1.tx_data_header_1                 = `TRANSACTORS_PATH.tx_data_header[1];
   assign   `CFI_AGENT_1.tx_data_eop_1                    = `TRANSACTORS_PATH.tx_data_eop[1]; 
   assign   `CFI_AGENT_1.tx_data_payload_1                = `TRANSACTORS_PATH.tx_data_payload[1]; 
   assign   `CFI_AGENT_1.tx_data_payload_par_1            = `TRANSACTORS_PATH.tx_data_payload_par[1]; 
   assign   `CFI_AGENT_1.tx_data_poison_1                 = `TRANSACTORS_PATH.tx_data_poison[1]; 
   assign   `CFI_AGENT_1.tx_data_dstid_1                  = `TRANSACTORS_PATH.tx_data_dstid[1];
   assign   `CFI_AGENT_0.tx_data_rctrl_1                  = `TRANSACTORS_PATH.tx_data_rctrl[1];
   assign   `CFI_AGENT_1.tx_data_txblock_crd_flow_1       = `TRANSACTORS_PATH.tx_data_txblock_crd_flow[1];
   assign   `TRANSACTORS_PATH.tx_data_block[1]              = `CFI_AGENT_1.tx_data_block_1;      
   assign   `TRANSACTORS_PATH.tx_data_rxcrd_null_credit[1]  = `CFI_AGENT_1.tx_data_rxcrd_null_credit_1;
   assign   `TRANSACTORS_PATH.tx_data_rxcrd_shared[1]       = `CFI_AGENT_1.tx_data_rxcrd_shared_1; 
   assign   `TRANSACTORS_PATH.tx_data_rxcrd_valid[1]        = `CFI_AGENT_1.tx_data_rxcrd_valid_1; 
   assign   `TRANSACTORS_PATH.tx_data_rxcrd_protocol_id[1]  = `CFI_AGENT_1.tx_data_rxcrd_protocol_id_1;
   assign   `TRANSACTORS_PATH.tx_data_rxcrd_vc_id[1]        = `CFI_AGENT_1.tx_data_rxcrd_vc_id_1;

   assign   `TRANSACTORS_PATH.rx_con_req[1]               = `CFI_AGENT_1.rx_con_req_1;
   assign   `CFI_AGENT_1.rx_con_ack_1                     = `TRANSACTORS_PATH.rx_con_ack[1];
   assign   `CFI_AGENT_1.tx_con_req_1                     = `TRANSACTORS_PATH.tx_con_req[1];
   assign   `TRANSACTORS_PATH.tx_con_ack[1]               = `CFI_AGENT_1.tx_con_ack_1;

   //assign   `TRANSACTORS_PATH.cfi_peer_clkack[1]         =  1'b0;
   //assign   `TRANSACTORS_PATH.cfi_rsp_peer_clkack[1]     =  1'b0;
   //assign   `TRANSACTORS_PATH.rx_ipc_read_high[1]        =  1'b0;
   //assign   `TRANSACTORS_PATH.rx_ipc_write_high[1]       =  1'b0;
