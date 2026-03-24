//=================================================================================================================================
// UFI_2_FABRIC connections - USER MUST EDIT THE RIGHT HAND SIDE OF THE FOLLOWING ASSIGNMENTS AND DEFINE - WHEN NEEDED
//=================================================================================================================================
// UFI_2_FABRIC   connection #0

			`define 	UFI_2_AGENT_2 					`FPGA_TRANSACTORS_TOP       // example:  fpga_tcss_top.tcss_val_rtl.tcss.par_iom

assign 		`TRANSACTORS_PATH.ufi_2_fabric_clk[2] 				= `UFI_2_AGENT_2.ufi_2_agent_clock_2; 
assign 		`TRANSACTORS_PATH.ufi_2_fabric_rstn[2] 				= `UFI_2_AGENT_2.ufi_2_agent_rst_n_2; 
      
// A2F Request connections
   assign   `TRANSACTORS_PATH.ufi_2_a2f_req_is_valid[2]          	= `UFI_2_AGENT_2.a2f_2_req_is_valid_2;
   assign   `TRANSACTORS_PATH.ufi_2_a2f_req_early_valid[2]        = `UFI_2_AGENT_2.a2f_2_req_early_valid_2;  
   assign   `TRANSACTORS_PATH.ufi_2_a2f_req_protocol_id[2]       	= `UFI_2_AGENT_2.a2f_2_req_protocol_id_2;
   assign   `TRANSACTORS_PATH.ufi_2_a2f_req_vc_id[2]            	= `UFI_2_AGENT_2.a2f_2_req_vc_id_2;
   assign   `TRANSACTORS_PATH.ufi_2_a2f_req_header[2]            	= `UFI_2_AGENT_2.a2f_2_req_header_2;
   assign   `TRANSACTORS_PATH.ufi_2_a2f_req_shared_credit[2]      = `UFI_2_AGENT_2.a2f_2_req_shared_credit_2;   
   assign   `TRANSACTORS_PATH.ufi_2_a2f_req_txflow_crd_block[2]   = `UFI_2_AGENT_2.a2f_2_req_txflow_crd_block_2;

     
// A2F Response connections
   assign   `TRANSACTORS_PATH.ufi_2_a2f_rsp_is_valid[2]         	= `UFI_2_AGENT_2.a2f_2_rsp_is_valid_2;
   assign   `TRANSACTORS_PATH.ufi_2_a2f_rsp_early_valid[2]        = `UFI_2_AGENT_2.a2f_2_rsp_early_valid_2; 
   assign   `TRANSACTORS_PATH.ufi_2_a2f_rsp_protocol_id[2]      	= `UFI_2_AGENT_2.a2f_2_rsp_protocol_id_2;
   assign   `TRANSACTORS_PATH.ufi_2_a2f_rsp_vc_id[2]            	= `UFI_2_AGENT_2.a2f_2_rsp_vc_id_2;
   assign   `TRANSACTORS_PATH.ufi_2_a2f_rsp_header[2]           	= `UFI_2_AGENT_2.a2f_2_rsp_header_2;
   assign   `TRANSACTORS_PATH.ufi_2_a2f_rsp_shared_credit[2]      = `UFI_2_AGENT_2.a2f_2_rsp_shared_credit_2;    
   assign   `TRANSACTORS_PATH.ufi_2_a2f_rsp_txflow_crd_block[2]   = `UFI_2_AGENT_2.a2f_2_rsp_txflow_crd_block_2;
   
// A2F Data connections 
   assign   `TRANSACTORS_PATH.ufi_2_a2f_data_is_valid[2]       	= `UFI_2_AGENT_2.a2f_2_data_is_valid_2;
   assign   `TRANSACTORS_PATH.ufi_2_a2f_data_early_valid[2]     = `UFI_2_AGENT_2.a2f_2_data_early_valid_2;   
   assign   `TRANSACTORS_PATH.ufi_2_a2f_data_protocol_id[2]    	= `UFI_2_AGENT_2.a2f_2_data_protocol_id_2;
   assign   `TRANSACTORS_PATH.ufi_2_a2f_data_vc_id[2]         	= `UFI_2_AGENT_2.a2f_2_data_vc_id_2;
   assign   `TRANSACTORS_PATH.ufi_2_a2f_data_header[2]         	= `UFI_2_AGENT_2.a2f_2_data_header_2; 
   assign   `TRANSACTORS_PATH.ufi_2_a2f_data_eop[2]            	= `UFI_2_AGENT_2.a2f_2_data_eop_2; 
   assign   `TRANSACTORS_PATH.ufi_2_a2f_data_payload[2]        	= `UFI_2_AGENT_2.a2f_2_data_payload_2;
   assign   `TRANSACTORS_PATH.ufi_2_a2f_data_shared_credit[2]   = `UFI_2_AGENT_2.a2f_2_data_shared_credit_2; 
   assign   `TRANSACTORS_PATH.ufi_2_a2f_data_txflow_crd_block[2]  = `UFI_2_AGENT_2.a2f_2_data_txflow_crd_block_2;
   
// F2A Request connections 
   assign   `TRANSACTORS_PATH.ufi_2_f2a_req_rxcrd[2]             	= `UFI_2_AGENT_2.f2a_2_req_rxcrd_2;            
   assign   `TRANSACTORS_PATH.ufi_2_f2a_req_rxcrd_protocol_id[2] 	= `UFI_2_AGENT_2.f2a_2_req_rxcrd_protocol_id_2;
   assign   `TRANSACTORS_PATH.ufi_2_f2a_req_rxcrd_vc_id[2]      	= `UFI_2_AGENT_2.f2a_2_req_rxcrd_vc_id_2;
   assign   `TRANSACTORS_PATH.ufi_2_f2a_req_rxcrd_shared[2]       = `UFI_2_AGENT_2.f2a_2_req_rxcrd_shared_2;  
   assign   `TRANSACTORS_PATH.ufi_2_f2a_req_block[2]              = `UFI_2_AGENT_2.f2a_2_req_block_2;
   
// F2A Response connections 
   assign   `TRANSACTORS_PATH.ufi_2_f2a_rsp_rxcrd[2]             	= `UFI_2_AGENT_2.f2a_2_rsp_rxcrd_2;            
   assign   `TRANSACTORS_PATH.ufi_2_f2a_rsp_rxcrd_protocol_id[2] 	= `UFI_2_AGENT_2.f2a_2_rsp_rxcrd_protocol_id_2;
   assign   `TRANSACTORS_PATH.ufi_2_f2a_rsp_rxcrd_vc_id[2]      	= `UFI_2_AGENT_2.f2a_2_rsp_rxcrd_vc_id_2;
   assign   `TRANSACTORS_PATH.ufi_2_f2a_rsp_rxcrd_shared[2]       = `UFI_2_AGENT_2.f2a_2_rsp_rxcrd_shared_2;
   assign   `TRANSACTORS_PATH.ufi_2_f2a_rsp_block[2]              = `UFI_2_AGENT_2.f2a_2_rsp_block_2;

// F2A Data connections 
   assign   `TRANSACTORS_PATH.ufi_2_f2a_data_rxcrd[2]             = `UFI_2_AGENT_2.f2a_2_data_rxcrd_2;             
   assign   `TRANSACTORS_PATH.ufi_2_f2a_data_rxcrd_protocol_id[2] = `UFI_2_AGENT_2.f2a_2_data_rxcrd_protocol_id_2;
   assign   `TRANSACTORS_PATH.ufi_2_f2a_data_rxcrd_vc_id[2]       = `UFI_2_AGENT_2.f2a_2_data_rxcrd_vc_id_2;
   assign   `TRANSACTORS_PATH.ufi_2_f2a_data_rxcrd_shared[2]      = `UFI_2_AGENT_2.f2a_2_data_rxcrd_shared_2;
   assign   `TRANSACTORS_PATH.ufi_2_f2a_data_block[2]             = `UFI_2_AGENT_2.f2a_2_data_block_2;

// A2F Global connections
   assign   `TRANSACTORS_PATH.ufi_2_a2f_txcon_req[2]    			= `UFI_2_AGENT_2.a2f_2_txcon_req_2; 
   
// F2A Global connections
   assign   `TRANSACTORS_PATH.ufi_2_f2a_rx_ack[2]            		= `UFI_2_AGENT_2.f2a_2_rx_ack_2; 
   assign   `TRANSACTORS_PATH.ufi_2_f2a_rx_empty[2]          		= `UFI_2_AGENT_2.f2a_2_rx_empty_2; 
   assign   `TRANSACTORS_PATH.ufi_2_f2a_rxdiscon_nack[2] 	    	= `UFI_2_AGENT_2.f2a_2_rxdiscon_nack_2;



//=================================================================================================================================
// UFI_2_FABRIC connections - USER MUST EDIT THE LEFT HAND SIDE OF THE FOLLOWING ASSIGNMENTS 
//=================================================================================================================================
// A2F Request connections
   assign   `UFI_2_AGENT_2.a2f_2_req_rxcrd_2              			= `TRANSACTORS_PATH.ufi_2_a2f_req_rxcrd[2]; 
   assign   `UFI_2_AGENT_2.a2f_2_req_rxcrd_protocol_id_2  			= `TRANSACTORS_PATH.ufi_2_a2f_req_rxcrd_protocol_id[2];
   assign   `UFI_2_AGENT_2.a2f_2_req_rxcrd_vc_id_2  		       	= `TRANSACTORS_PATH.ufi_2_a2f_req_rxcrd_vc_id[2];
   assign   `UFI_2_AGENT_2.a2f_2_req_rxcrd_shared_2             = `TRANSACTORS_PATH.ufi_2_a2f_req_rxcrd_shared[2];
   assign   `UFI_2_AGENT_2.a2f_2_req_block_2                    = `TRANSACTORS_PATH.ufi_2_a2f_req_block[2]; 
    
// A2F Response connections
   assign   `UFI_2_AGENT_2.a2f_2_rsp_rxcrd_2              			= `TRANSACTORS_PATH.ufi_2_a2f_rsp_rxcrd[2]; 
   assign   `UFI_2_AGENT_2.a2f_2_rsp_rxcrd_protocol_id_2  			= `TRANSACTORS_PATH.ufi_2_a2f_rsp_rxcrd_protocol_id[2]; 
   assign   `UFI_2_AGENT_2.a2f_2_rsp_rxcrd_vc_id_2  		      	= `TRANSACTORS_PATH.ufi_2_a2f_rsp_rxcrd_vc_id[2];
   assign   `UFI_2_AGENT_2.a2f_2_rsp_rxcrd_shared_2             = `TRANSACTORS_PATH.ufi_2_a2f_rsp_rxcrd_shared[2];
   assign   `UFI_2_AGENT_2.a2f_2_rsp_block_2                    = `TRANSACTORS_PATH.ufi_2_a2f_rsp_block[2]; 

// A2F Data connections 
   assign   `UFI_2_AGENT_2.a2f_2_data_rxcrd_2             		 	= `TRANSACTORS_PATH.ufi_2_a2f_data_rxcrd[2]; 
   assign   `UFI_2_AGENT_2.a2f_2_data_rxcrd_protocol_id_2  			= `TRANSACTORS_PATH.ufi_2_a2f_data_rxcrd_protocol_id[2]; 
   assign   `UFI_2_AGENT_2.a2f_2_data_rxcrd_vc_id_2  		      	= `TRANSACTORS_PATH.ufi_2_a2f_data_rxcrd_vc_id[2];
   assign   `UFI_2_AGENT_2.a2f_2_data_rxcrd_shared_2            = `TRANSACTORS_PATH.ufi_2_a2f_data_rxcrd_shared[2];
   assign   `UFI_2_AGENT_2.a2f_2_data_block_2                   = `TRANSACTORS_PATH.ufi_2_a2f_data_block[2]; 

// F2A Request connections 
   assign   `UFI_2_AGENT_2.f2a_2_req_is_valid_2       				= `TRANSACTORS_PATH.ufi_2_f2a_req_is_valid[2];
   assign   `UFI_2_AGENT_2.f2a_2_req_early_valid_2            = `TRANSACTORS_PATH.ufi_2_f2a_req_early_valid[2];
   assign   `UFI_2_AGENT_2.f2a_2_req_protocol_id_2    				= `TRANSACTORS_PATH.ufi_2_f2a_req_protocol_id[2];
   assign   `UFI_2_AGENT_2.f2a_2_req_vc_id_2    			      	= `TRANSACTORS_PATH.ufi_2_f2a_req_vc_id[2];
   assign   `UFI_2_AGENT_2.f2a_2_req_header_2         				= `TRANSACTORS_PATH.ufi_2_f2a_req_header[2];
   assign   `UFI_2_AGENT_2.f2a_2_req_shared_credit_2          = `TRANSACTORS_PATH.ufi_2_f2a_req_shared_credit[2];  
   assign   `UFI_2_AGENT_2.f2a_2_req_txflow_crd_block_2       = `TRANSACTORS_PATH.ufi_2_f2a_req_txflow_crd_block[2];
    
// F2A Response connections 
   assign   `UFI_2_AGENT_2.f2a_2_rsp_is_valid_2       				= `TRANSACTORS_PATH.ufi_2_f2a_rsp_is_valid[2];
   assign   `UFI_2_AGENT_2.f2a_2_rsp_early_valid_2            = `TRANSACTORS_PATH.ufi_2_f2a_rsp_early_valid[2];
   assign   `UFI_2_AGENT_2.f2a_2_rsp_protocol_id_2    				= `TRANSACTORS_PATH.ufi_2_f2a_rsp_protocol_id[2];
   assign   `UFI_2_AGENT_2.f2a_2_rsp_vc_id_2    		      		= `TRANSACTORS_PATH.ufi_2_f2a_rsp_vc_id[2];
   assign   `UFI_2_AGENT_2.f2a_2_rsp_header_2         				= `TRANSACTORS_PATH.ufi_2_f2a_rsp_header[2];
   assign   `UFI_2_AGENT_2.f2a_2_rsp_shared_credit_2          = `TRANSACTORS_PATH.ufi_2_f2a_rsp_shared_credit[2];
   assign   `UFI_2_AGENT_2.f2a_2_rsp_txflow_crd_block_2       = `TRANSACTORS_PATH.ufi_2_f2a_rsp_txflow_crd_block[2];
    
// F2A Data connections 
   assign   `UFI_2_AGENT_2.f2a_2_data_is_valid_2     				= `TRANSACTORS_PATH.ufi_2_f2a_data_is_valid[2]; 
   assign   `UFI_2_AGENT_2.f2a_2_data_early_valid_2         = `TRANSACTORS_PATH.ufi_2_f2a_data_early_valid[2];
   assign   `UFI_2_AGENT_2.f2a_2_data_protocol_id_2 				= `TRANSACTORS_PATH.ufi_2_f2a_data_protocol_id[2];
   assign   `UFI_2_AGENT_2.f2a_2_data_vc_id_2 			      	= `TRANSACTORS_PATH.ufi_2_f2a_data_vc_id[2];
   assign   `UFI_2_AGENT_2.f2a_2_data_header_2       				= `TRANSACTORS_PATH.ufi_2_f2a_data_header[2]; 
   assign   `UFI_2_AGENT_2.f2a_2_data_eop_2          				= `TRANSACTORS_PATH.ufi_2_f2a_data_eop[2]; 
   assign   `UFI_2_AGENT_2.f2a_2_data_payload_2      				= `TRANSACTORS_PATH.ufi_2_f2a_data_payload[2];
   assign   `UFI_2_AGENT_2.f2a_2_data_shared_credit_2       = `TRANSACTORS_PATH.ufi_2_f2a_data_shared_credit[2]; 
   assign   `UFI_2_AGENT_2.f2a_2_data_txflow_crd_block_2    = `TRANSACTORS_PATH.ufi_2_f2a_data_txflow_crd_block[2];


// A2F Global connections
   assign   `UFI_2_AGENT_2.a2f_2_rx_ack_2            				= `TRANSACTORS_PATH.ufi_2_a2f_rx_ack[2]; 
   assign   `UFI_2_AGENT_2.a2f_2_rx_empty_2          				= `TRANSACTORS_PATH.ufi_2_a2f_rx_empty[2]; 
   assign   `UFI_2_AGENT_2.a2f_2_rxdiscon_nack_2 			    	= `TRANSACTORS_PATH.ufi_2_a2f_rxdiscon_nack[2]; 
   
// F2A Global connections
   assign   `UFI_2_AGENT_2.f2a_2_txcon_req_2    					= `TRANSACTORS_PATH.ufi_2_f2a_txcon_req[2]; 

