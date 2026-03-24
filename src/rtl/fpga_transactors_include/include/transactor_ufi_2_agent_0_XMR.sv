//=================================================================================================================================
// UFI_2_AGENT connections - USER MUST EDIT THE RIGHT HAND SIDE OF THE FOLLOWING ASSIGNMENTS AND DEFINE - WHEN NEEDED
//=================================================================================================================================
// UFI_2_AGENT   connection #0

			`define 	UFI_2_FABRIC_0 					`FPGA_TRANSACTORS_TOP       // example:  fpga_tcss_top.tcss_val_rtl.tcss.par_iom

assign 		`TRANSACTORS_PATH.ufi_2_agent_clk[0] 				  = `UFI_2_FABRIC_0.ufi_2_agent_clock_0; 
assign 		`TRANSACTORS_PATH.ufi_2_agent_rstn[0] 			  	= `UFI_2_FABRIC_0.ufi_2_agent_rst_n_0; 
      
// A2F Request connections
   assign   `UFI_2_FABRIC_0.ufi_agent_a2f_2_req_is_valid_0          	= `TRANSACTORS_PATH.a2f_2_req_is_valid[0];
   assign   `UFI_2_FABRIC_0.ufi_agent_a2f_2_req_early_valid_0        = `TRANSACTORS_PATH.a2f_2_req_early_valid[0];  
   assign   `UFI_2_FABRIC_0.ufi_agent_a2f_2_req_protocol_id_0       	= `TRANSACTORS_PATH.a2f_2_req_protocol_id[0];
   assign   `UFI_2_FABRIC_0.ufi_agent_a2f_2_req_vc_id_0            	= `TRANSACTORS_PATH.a2f_2_req_vc_id[0];
   assign   `UFI_2_FABRIC_0.ufi_agent_a2f_2_req_header_0            	= `TRANSACTORS_PATH.a2f_2_req_header[0];
   assign   `UFI_2_FABRIC_0.ufi_agent_a2f_2_req_shared_credit_0      = `TRANSACTORS_PATH.a2f_2_req_shared_credit[0];   
   assign   `UFI_2_FABRIC_0.ufi_agent_a2f_2_req_txflow_crd_block_0   = `TRANSACTORS_PATH.a2f_2_req_txflow_crd_block[0];

     
// A2F Response connections
   assign   `UFI_2_FABRIC_0.ufi_agent_a2f_2_rsp_is_valid_0         	= `TRANSACTORS_PATH.a2f_2_rsp_is_valid[0];
   assign   `UFI_2_FABRIC_0.ufi_agent_a2f_2_rsp_early_valid_0        = `TRANSACTORS_PATH.a2f_2_rsp_early_valid[0]; 
   assign   `UFI_2_FABRIC_0.ufi_agent_a2f_2_rsp_protocol_id_0      	= `TRANSACTORS_PATH.a2f_2_rsp_protocol_id[0];
   assign   `UFI_2_FABRIC_0.ufi_agent_a2f_2_rsp_vc_id_0            	= `TRANSACTORS_PATH.a2f_2_rsp_vc_id[0];
   assign   `UFI_2_FABRIC_0.ufi_agent_a2f_2_rsp_header_0           	= `TRANSACTORS_PATH.a2f_2_rsp_header[0];
   assign   `UFI_2_FABRIC_0.ufi_agent_a2f_2_rsp_shared_credit_0      = `TRANSACTORS_PATH.a2f_2_rsp_shared_credit[0];    
   assign   `UFI_2_FABRIC_0.ufi_agent_a2f_2_rsp_txflow_crd_block_0   = `TRANSACTORS_PATH.a2f_2_rsp_txflow_crd_block[0];
   
// A2F Data connections 
   assign   `UFI_2_FABRIC_0.ufi_agent_a2f_2_data_is_valid_0       	= `TRANSACTORS_PATH.a2f_2_data_is_valid[0];
   assign   `UFI_2_FABRIC_0.ufi_agent_a2f_2_data_early_valid_0     = `TRANSACTORS_PATH.a2f_2_data_early_valid[0];   
   assign   `UFI_2_FABRIC_0.ufi_agent_a2f_2_data_protocol_id_0    	= `TRANSACTORS_PATH.a2f_2_data_protocol_id[0];
   assign   `UFI_2_FABRIC_0.ufi_agent_a2f_2_data_vc_id_0         	= `TRANSACTORS_PATH.a2f_2_data_vc_id[0];
   assign   `UFI_2_FABRIC_0.ufi_agent_a2f_2_data_header_0         	= `TRANSACTORS_PATH.a2f_2_data_header[0]; 
   assign   `UFI_2_FABRIC_0.ufi_agent_a2f_2_data_eop_0            	= `TRANSACTORS_PATH.a2f_2_data_eop[0]; 
   assign   `UFI_2_FABRIC_0.ufi_agent_a2f_2_data_payload_0        	= `TRANSACTORS_PATH.a2f_2_data_payload[0];
   assign   `UFI_2_FABRIC_0.ufi_agent_a2f_2_data_shared_credit_0   = `TRANSACTORS_PATH.a2f_2_data_shared_credit[0]; 
   assign   `UFI_2_FABRIC_0.ufi_agent_a2f_2_data_txflow_crd_block_0  = `TRANSACTORS_PATH.a2f_2_data_txflow_crd_block[0];
  // assign   `UFI_2_FABRIC_0.ufi_agent_a2f_2_data_half_line_valid_0  = 0;
   
// F2A Request connections 
   assign   `UFI_2_FABRIC_0.ufi_agent_f2a_2_req_rxcrd_0             	= `TRANSACTORS_PATH.f2a_2_req_rxcrd[0];            
   assign   `UFI_2_FABRIC_0.ufi_agent_f2a_2_req_rxcrd_protocol_id_0 	= `TRANSACTORS_PATH.f2a_2_req_rxcrd_protocol_id[0];
   assign   `UFI_2_FABRIC_0.ufi_agent_f2a_2_req_rxcrd_vc_id_0      	= `TRANSACTORS_PATH.f2a_2_req_rxcrd_vc_id[0];
   assign   `UFI_2_FABRIC_0.ufi_agent_f2a_2_req_rxcrd_shared_0       = `TRANSACTORS_PATH.f2a_2_req_rxcrd_shared[0];  
   assign   `UFI_2_FABRIC_0.ufi_agent_f2a_2_req_block_0              = `TRANSACTORS_PATH.f2a_2_req_block[0];
   
// F2A Response connections 
   assign   `UFI_2_FABRIC_0.ufi_agent_f2a_2_rsp_rxcrd_0             	= `TRANSACTORS_PATH.f2a_2_rsp_rxcrd[0];            
   assign   `UFI_2_FABRIC_0.ufi_agent_f2a_2_rsp_rxcrd_protocol_id_0 	= `TRANSACTORS_PATH.f2a_2_rsp_rxcrd_protocol_id[0];
   assign   `UFI_2_FABRIC_0.ufi_agent_f2a_2_rsp_rxcrd_vc_id_0      	= `TRANSACTORS_PATH.f2a_2_rsp_rxcrd_vc_id[0];
   assign   `UFI_2_FABRIC_0.ufi_agent_f2a_2_rsp_rxcrd_shared_0       = `TRANSACTORS_PATH.f2a_2_rsp_rxcrd_shared[0];
   assign   `UFI_2_FABRIC_0.ufi_agent_f2a_2_rsp_block_0              = `TRANSACTORS_PATH.f2a_2_rsp_block[0];

// F2A Data connections 
   assign   `UFI_2_FABRIC_0.ufi_agent_f2a_2_data_rxcrd_0             = `TRANSACTORS_PATH.f2a_2_data_rxcrd[0];             
   assign   `UFI_2_FABRIC_0.ufi_agent_f2a_2_data_rxcrd_protocol_id_0 = `TRANSACTORS_PATH.f2a_2_data_rxcrd_protocol_id[0];
   assign   `UFI_2_FABRIC_0.ufi_agent_f2a_2_data_rxcrd_vc_id_0       = `TRANSACTORS_PATH.f2a_2_data_rxcrd_vc_id[0];
   assign   `UFI_2_FABRIC_0.ufi_agent_f2a_2_data_rxcrd_shared_0      = `TRANSACTORS_PATH.f2a_2_data_rxcrd_shared[0];
   assign   `UFI_2_FABRIC_0.ufi_agent_f2a_2_data_block_0             = `TRANSACTORS_PATH.f2a_2_data_block[0];

// A2F Global connections
   assign   `UFI_2_FABRIC_0.ufi_agent_a2f_2_txcon_req_0    			= `TRANSACTORS_PATH.a2f_2_txcon_req[0]; 
   
// F2A Global connections
   assign   `UFI_2_FABRIC_0.ufi_agent_f2a_2_rx_ack_0            		= `TRANSACTORS_PATH.f2a_2_rx_ack[0]; 
   assign   `UFI_2_FABRIC_0.ufi_agent_f2a_2_rx_empty_0          		= `TRANSACTORS_PATH.f2a_2_rx_empty[0]; 
   assign   `UFI_2_FABRIC_0.ufi_agent_f2a_2_rxdiscon_nack_0 	    	= `TRANSACTORS_PATH.f2a_2_rxdiscon_nack[0];



//=================================================================================================================================
// UFI_2_AGENT connections - USER MUST EDIT THE LEFT HAND SIDE OF THE FOLLOWING ASSIGNMENTS 
//=================================================================================================================================
// A2F Request connections
   assign   `TRANSACTORS_PATH.a2f_2_req_rxcrd[0]              			= `UFI_2_FABRIC_0.ufi_agent_a2f_2_req_rxcrd_0; 
   assign   `TRANSACTORS_PATH.a2f_2_req_rxcrd_protocol_id[0]  			= `UFI_2_FABRIC_0.ufi_agent_a2f_2_req_rxcrd_protocol_id_0;
   assign   `TRANSACTORS_PATH.a2f_2_req_rxcrd_vc_id[0]  		       	= `UFI_2_FABRIC_0.ufi_agent_a2f_2_req_rxcrd_vc_id_0;
   assign   `TRANSACTORS_PATH.a2f_2_req_rxcrd_shared[0]             = `UFI_2_FABRIC_0.ufi_agent_a2f_2_req_rxcrd_shared_0;
   assign   `TRANSACTORS_PATH.a2f_2_req_block[0]                    = `UFI_2_FABRIC_0.ufi_agent_a2f_2_req_block_0; 
    
// A2F Response connections
   assign   `TRANSACTORS_PATH.a2f_2_rsp_rxcrd[0]              			= `UFI_2_FABRIC_0.ufi_agent_a2f_2_rsp_rxcrd_0; 
   assign   `TRANSACTORS_PATH.a2f_2_rsp_rxcrd_protocol_id[0]  			= `UFI_2_FABRIC_0.ufi_agent_a2f_2_rsp_rxcrd_protocol_id_0; 
   assign   `TRANSACTORS_PATH.a2f_2_rsp_rxcrd_vc_id[0]  		      	= `UFI_2_FABRIC_0.ufi_agent_a2f_2_rsp_rxcrd_vc_id_0;
   assign   `TRANSACTORS_PATH.a2f_2_rsp_rxcrd_shared[0]             = `UFI_2_FABRIC_0.ufi_agent_a2f_2_rsp_rxcrd_shared_0;
   assign   `TRANSACTORS_PATH.a2f_2_rsp_block[0]                    = `UFI_2_FABRIC_0.ufi_agent_a2f_2_rsp_block_0; 

// A2F Data connections 
   assign   `TRANSACTORS_PATH.a2f_2_data_rxcrd[0]             		 	= `UFI_2_FABRIC_0.ufi_agent_a2f_2_data_rxcrd_0; 
   assign   `TRANSACTORS_PATH.a2f_2_data_rxcrd_protocol_id[0]  			= `UFI_2_FABRIC_0.ufi_agent_a2f_2_data_rxcrd_protocol_id_0; 
   assign   `TRANSACTORS_PATH.a2f_2_data_rxcrd_vc_id[0]  		      	= `UFI_2_FABRIC_0.ufi_agent_a2f_2_data_rxcrd_vc_id_0;
   assign   `TRANSACTORS_PATH.a2f_2_data_rxcrd_shared[0]            = `UFI_2_FABRIC_0.ufi_agent_a2f_2_data_rxcrd_shared_0;
   assign   `TRANSACTORS_PATH.a2f_2_data_block[0]                   = `UFI_2_FABRIC_0.ufi_agent_a2f_2_data_block_0; 

// F2A Request connections 
   assign   `TRANSACTORS_PATH.f2a_2_req_is_valid[0]       				= `UFI_2_FABRIC_0.ufi_agent_f2a_2_req_is_valid_0;
   assign   `TRANSACTORS_PATH.f2a_2_req_early_valid[0]            = `UFI_2_FABRIC_0.ufi_agent_f2a_2_req_early_valid_0;
   assign   `TRANSACTORS_PATH.f2a_2_req_protocol_id[0]    				= `UFI_2_FABRIC_0.ufi_agent_f2a_2_req_protocol_id_0;
   assign   `TRANSACTORS_PATH.f2a_2_req_vc_id[0]    			      	= `UFI_2_FABRIC_0.ufi_agent_f2a_2_req_vc_id_0;
   assign   `TRANSACTORS_PATH.f2a_2_req_header[0]         				= `UFI_2_FABRIC_0.ufi_agent_f2a_2_req_header_0;
   assign   `TRANSACTORS_PATH.f2a_2_req_shared_credit[0]          = `UFI_2_FABRIC_0.ufi_agent_f2a_2_req_shared_credit_0;  
   assign   `TRANSACTORS_PATH.f2a_2_req_txflow_crd_block[0]       = `UFI_2_FABRIC_0.ufi_agent_f2a_2_req_txflow_crd_block_0;
    
// F2A Response connections 
   assign   `TRANSACTORS_PATH.f2a_2_rsp_is_valid[0]       				= `UFI_2_FABRIC_0.ufi_agent_f2a_2_rsp_is_valid_0;
   assign   `TRANSACTORS_PATH.f2a_2_rsp_early_valid[0]            = `UFI_2_FABRIC_0.ufi_agent_f2a_2_rsp_early_valid_0;
   assign   `TRANSACTORS_PATH.f2a_2_rsp_protocol_id[0]    				= `UFI_2_FABRIC_0.ufi_agent_f2a_2_rsp_protocol_id_0;
   assign   `TRANSACTORS_PATH.f2a_2_rsp_vc_id[0]    		      		= `UFI_2_FABRIC_0.ufi_agent_f2a_2_rsp_vc_id_0;
   assign   `TRANSACTORS_PATH.f2a_2_rsp_header[0]         				= `UFI_2_FABRIC_0.ufi_agent_f2a_2_rsp_header_0;
   assign   `TRANSACTORS_PATH.f2a_2_rsp_shared_credit[0]          = `UFI_2_FABRIC_0.ufi_agent_f2a_2_rsp_shared_credit_0;
   assign   `TRANSACTORS_PATH.f2a_2_rsp_txflow_crd_block[0]       = `UFI_2_FABRIC_0.ufi_agent_f2a_2_rsp_txflow_crd_block_0;
    
// F2A Data connections 
   assign   `TRANSACTORS_PATH.f2a_2_data_is_valid[0]     				= `UFI_2_FABRIC_0.ufi_agent_f2a_2_data_is_valid_0; 
   assign   `TRANSACTORS_PATH.f2a_2_data_early_valid[0]         = `UFI_2_FABRIC_0.ufi_agent_f2a_2_data_early_valid_0;
   assign   `TRANSACTORS_PATH.f2a_2_data_protocol_id[0] 				= `UFI_2_FABRIC_0.ufi_agent_f2a_2_data_protocol_id_0;
   assign   `TRANSACTORS_PATH.f2a_2_data_vc_id[0] 			      	= `UFI_2_FABRIC_0.ufi_agent_f2a_2_data_vc_id_0;
   assign   `TRANSACTORS_PATH.f2a_2_data_header[0]       				= `UFI_2_FABRIC_0.ufi_agent_f2a_2_data_header_0; 
   assign   `TRANSACTORS_PATH.f2a_2_data_eop[0]          				= `UFI_2_FABRIC_0.ufi_agent_f2a_2_data_eop_0; 
   assign   `TRANSACTORS_PATH.f2a_2_data_payload[0]      				= `UFI_2_FABRIC_0.ufi_agent_f2a_2_data_payload_0;
   assign   `TRANSACTORS_PATH.f2a_2_data_shared_credit[0]       = `UFI_2_FABRIC_0.ufi_agent_f2a_2_data_shared_credit_0; 
   assign   `TRANSACTORS_PATH.f2a_2_data_txflow_crd_block[0]    = `UFI_2_FABRIC_0.ufi_agent_f2a_2_data_txflow_crd_block_0;


// A2F Global connections
   assign   `TRANSACTORS_PATH.a2f_2_rx_ack[0]            				= `UFI_2_FABRIC_0.ufi_agent_a2f_2_rx_ack_0; 
   assign   `TRANSACTORS_PATH.a2f_2_rx_empty[0]          				= `UFI_2_FABRIC_0.ufi_agent_a2f_2_rx_empty_0; 
   assign   `TRANSACTORS_PATH.a2f_2_rxdiscon_nack[0] 			    	= `UFI_2_FABRIC_0.ufi_agent_a2f_2_rxdiscon_nack_0; 
   
// F2A Global connections
   assign   `TRANSACTORS_PATH.f2a_2_txcon_req[0]    					= `UFI_2_FABRIC_0.ufi_agent_f2a_2_txcon_req_0; 

