//=================================================================================================================================
// UFI_2_FABRIC connections - USER MUST EDIT THE RIGHT HAND SIDE OF THE FOLLOWING ASSIGNMENTS AND DEFINE - WHEN NEEDED
//=================================================================================================================================
// UFI_2_FABRIC   connection #0

			`define 	UFI_2_AGENT_1 					`FPGA_TRANSACTORS_TOP       // example:  fpga_tcss_top.tcss_val_rtl.tcss.par_iom

assign 		`TRANSACTORS_PATH.ufi_2_fabric_clk[1] 				= `UFI_2_AGENT_1.ufi_2_agent_clock_1; 
assign 		`TRANSACTORS_PATH.ufi_2_fabric_rstn[1] 				= `UFI_2_AGENT_1.ufi_2_agent_rst_n_1; 
      
// A2F Request connections
   assign   `TRANSACTORS_PATH.ufi_2_a2f_req_is_valid[1]          	= `UFI_2_AGENT_1.a2f_2_req_is_valid_1;
   assign   `TRANSACTORS_PATH.ufi_2_a2f_req_early_valid[1]        = `UFI_2_AGENT_1.a2f_2_req_early_valid_1;  
   assign   `TRANSACTORS_PATH.ufi_2_a2f_req_protocol_id[1]       	= `UFI_2_AGENT_1.a2f_2_req_protocol_id_1;
   assign   `TRANSACTORS_PATH.ufi_2_a2f_req_vc_id[1]            	= `UFI_2_AGENT_1.a2f_2_req_vc_id_1;
   assign   `TRANSACTORS_PATH.ufi_2_a2f_req_header[1]            	= `UFI_2_AGENT_1.a2f_2_req_header_1;
   assign   `TRANSACTORS_PATH.ufi_2_a2f_req_shared_credit[1]      = `UFI_2_AGENT_1.a2f_2_req_shared_credit_1;   
   assign   `TRANSACTORS_PATH.ufi_2_a2f_req_txflow_crd_block[1]   = `UFI_2_AGENT_1.a2f_2_req_txflow_crd_block_1;

     
// A2F Response connections
   assign   `TRANSACTORS_PATH.ufi_2_a2f_rsp_is_valid[1]         	= `UFI_2_AGENT_1.a2f_2_rsp_is_valid_1;
   assign   `TRANSACTORS_PATH.ufi_2_a2f_rsp_early_valid[1]        = `UFI_2_AGENT_1.a2f_2_rsp_early_valid_1; 
   assign   `TRANSACTORS_PATH.ufi_2_a2f_rsp_protocol_id[1]      	= `UFI_2_AGENT_1.a2f_2_rsp_protocol_id_1;
   assign   `TRANSACTORS_PATH.ufi_2_a2f_rsp_vc_id[1]            	= `UFI_2_AGENT_1.a2f_2_rsp_vc_id_1;
   assign   `TRANSACTORS_PATH.ufi_2_a2f_rsp_header[1]           	= `UFI_2_AGENT_1.a2f_2_rsp_header_1;
   assign   `TRANSACTORS_PATH.ufi_2_a2f_rsp_shared_credit[1]      = `UFI_2_AGENT_1.a2f_2_rsp_shared_credit_1;    
   assign   `TRANSACTORS_PATH.ufi_2_a2f_rsp_txflow_crd_block[1]   = `UFI_2_AGENT_1.a2f_2_rsp_txflow_crd_block_1;
   
// A2F Data connections 
   assign   `TRANSACTORS_PATH.ufi_2_a2f_data_is_valid[1]       	= `UFI_2_AGENT_1.a2f_2_data_is_valid_1;
   assign   `TRANSACTORS_PATH.ufi_2_a2f_data_early_valid[1]     = `UFI_2_AGENT_1.a2f_2_data_early_valid_1;   
   assign   `TRANSACTORS_PATH.ufi_2_a2f_data_protocol_id[1]    	= `UFI_2_AGENT_1.a2f_2_data_protocol_id_1;
   assign   `TRANSACTORS_PATH.ufi_2_a2f_data_vc_id[1]         	= `UFI_2_AGENT_1.a2f_2_data_vc_id_1;
   assign   `TRANSACTORS_PATH.ufi_2_a2f_data_header[1]         	= `UFI_2_AGENT_1.a2f_2_data_header_1; 
   assign   `TRANSACTORS_PATH.ufi_2_a2f_data_eop[1]            	= `UFI_2_AGENT_1.a2f_2_data_eop_1; 
   assign   `TRANSACTORS_PATH.ufi_2_a2f_data_payload[1]        	= `UFI_2_AGENT_1.a2f_2_data_payload_1;
   assign   `TRANSACTORS_PATH.ufi_2_a2f_data_shared_credit[1]   = `UFI_2_AGENT_1.a2f_2_data_shared_credit_1; 
   assign   `TRANSACTORS_PATH.ufi_2_a2f_data_txflow_crd_block[1]  = `UFI_2_AGENT_1.a2f_2_data_txflow_crd_block_1;
   
// F2A Request connections 
   assign   `TRANSACTORS_PATH.ufi_2_f2a_req_rxcrd[1]             	= `UFI_2_AGENT_1.f2a_2_req_rxcrd_1;            
   assign   `TRANSACTORS_PATH.ufi_2_f2a_req_rxcrd_protocol_id[1] 	= `UFI_2_AGENT_1.f2a_2_req_rxcrd_protocol_id_1;
   assign   `TRANSACTORS_PATH.ufi_2_f2a_req_rxcrd_vc_id[1]      	= `UFI_2_AGENT_1.f2a_2_req_rxcrd_vc_id_1;
   assign   `TRANSACTORS_PATH.ufi_2_f2a_req_rxcrd_shared[1]       = `UFI_2_AGENT_1.f2a_2_req_rxcrd_shared_1;  
   assign   `TRANSACTORS_PATH.ufi_2_f2a_req_block[1]              = `UFI_2_AGENT_1.f2a_2_req_block_1;
   
// F2A Response connections 
   assign   `TRANSACTORS_PATH.ufi_2_f2a_rsp_rxcrd[1]             	= `UFI_2_AGENT_1.f2a_2_rsp_rxcrd_1;            
   assign   `TRANSACTORS_PATH.ufi_2_f2a_rsp_rxcrd_protocol_id[1] 	= `UFI_2_AGENT_1.f2a_2_rsp_rxcrd_protocol_id_1;
   assign   `TRANSACTORS_PATH.ufi_2_f2a_rsp_rxcrd_vc_id[1]      	= `UFI_2_AGENT_1.f2a_2_rsp_rxcrd_vc_id_1;
   assign   `TRANSACTORS_PATH.ufi_2_f2a_rsp_rxcrd_shared[1]       = `UFI_2_AGENT_1.f2a_2_rsp_rxcrd_shared_1;
   assign   `TRANSACTORS_PATH.ufi_2_f2a_rsp_block[1]              = `UFI_2_AGENT_1.f2a_2_rsp_block_1;

// F2A Data connections 
   assign   `TRANSACTORS_PATH.ufi_2_f2a_data_rxcrd[1]             = `UFI_2_AGENT_1.f2a_2_data_rxcrd_1;             
   assign   `TRANSACTORS_PATH.ufi_2_f2a_data_rxcrd_protocol_id[1] = `UFI_2_AGENT_1.f2a_2_data_rxcrd_protocol_id_1;
   assign   `TRANSACTORS_PATH.ufi_2_f2a_data_rxcrd_vc_id[1]       = `UFI_2_AGENT_1.f2a_2_data_rxcrd_vc_id_1;
   assign   `TRANSACTORS_PATH.ufi_2_f2a_data_rxcrd_shared[1]      = `UFI_2_AGENT_1.f2a_2_data_rxcrd_shared_1;
   assign   `TRANSACTORS_PATH.ufi_2_f2a_data_block[1]             = `UFI_2_AGENT_1.f2a_2_data_block_1;

// A2F Global connections
   assign   `TRANSACTORS_PATH.ufi_2_a2f_txcon_req[1]    			= `UFI_2_AGENT_1.a2f_2_txcon_req_1; 
   
// F2A Global connections
   assign   `TRANSACTORS_PATH.ufi_2_f2a_rx_ack[1]            		= `UFI_2_AGENT_1.f2a_2_rx_ack_1; 
   assign   `TRANSACTORS_PATH.ufi_2_f2a_rx_empty[1]          		= `UFI_2_AGENT_1.f2a_2_rx_empty_1; 
   assign   `TRANSACTORS_PATH.ufi_2_f2a_rxdiscon_nack[1] 	    	= `UFI_2_AGENT_1.f2a_2_rxdiscon_nack_1;



//=================================================================================================================================
// UFI_2_FABRIC connections - USER MUST EDIT THE LEFT HAND SIDE OF THE FOLLOWING ASSIGNMENTS 
//=================================================================================================================================
// A2F Request connections
   assign   `UFI_2_AGENT_1.a2f_2_req_rxcrd_1              			= `TRANSACTORS_PATH.ufi_2_a2f_req_rxcrd[1]; 
   assign   `UFI_2_AGENT_1.a2f_2_req_rxcrd_protocol_id_1  			= `TRANSACTORS_PATH.ufi_2_a2f_req_rxcrd_protocol_id[1];
   assign   `UFI_2_AGENT_1.a2f_2_req_rxcrd_vc_id_1  		       	= `TRANSACTORS_PATH.ufi_2_a2f_req_rxcrd_vc_id[1];
   assign   `UFI_2_AGENT_1.a2f_2_req_rxcrd_shared_1             = `TRANSACTORS_PATH.ufi_2_a2f_req_rxcrd_shared[1];
   assign   `UFI_2_AGENT_1.a2f_2_req_block_1                    = `TRANSACTORS_PATH.ufi_2_a2f_req_block[1]; 
    
// A2F Response connections
   assign   `UFI_2_AGENT_1.a2f_2_rsp_rxcrd_1              			= `TRANSACTORS_PATH.ufi_2_a2f_rsp_rxcrd[1]; 
   assign   `UFI_2_AGENT_1.a2f_2_rsp_rxcrd_protocol_id_1  			= `TRANSACTORS_PATH.ufi_2_a2f_rsp_rxcrd_protocol_id[1]; 
   assign   `UFI_2_AGENT_1.a2f_2_rsp_rxcrd_vc_id_1  		      	= `TRANSACTORS_PATH.ufi_2_a2f_rsp_rxcrd_vc_id[1];
   assign   `UFI_2_AGENT_1.a2f_2_rsp_rxcrd_shared_1             = `TRANSACTORS_PATH.ufi_2_a2f_rsp_rxcrd_shared[1];
   assign   `UFI_2_AGENT_1.a2f_2_rsp_block_1                    = `TRANSACTORS_PATH.ufi_2_a2f_rsp_block[1]; 

// A2F Data connections 
   assign   `UFI_2_AGENT_1.a2f_2_data_rxcrd_1             		 	= `TRANSACTORS_PATH.ufi_2_a2f_data_rxcrd[1]; 
   assign   `UFI_2_AGENT_1.a2f_2_data_rxcrd_protocol_id_1  			= `TRANSACTORS_PATH.ufi_2_a2f_data_rxcrd_protocol_id[1]; 
   assign   `UFI_2_AGENT_1.a2f_2_data_rxcrd_vc_id_1  		      	= `TRANSACTORS_PATH.ufi_2_a2f_data_rxcrd_vc_id[1];
   assign   `UFI_2_AGENT_1.a2f_2_data_rxcrd_shared_1            = `TRANSACTORS_PATH.ufi_2_a2f_data_rxcrd_shared[1];
   assign   `UFI_2_AGENT_1.a2f_2_data_block_1                   = `TRANSACTORS_PATH.ufi_2_a2f_data_block[1]; 

// F2A Request connections 
   assign   `UFI_2_AGENT_1.f2a_2_req_is_valid_1       				= `TRANSACTORS_PATH.ufi_2_f2a_req_is_valid[1];
   assign   `UFI_2_AGENT_1.f2a_2_req_early_valid_1            = `TRANSACTORS_PATH.ufi_2_f2a_req_early_valid[1];
   assign   `UFI_2_AGENT_1.f2a_2_req_protocol_id_1    				= `TRANSACTORS_PATH.ufi_2_f2a_req_protocol_id[1];
   assign   `UFI_2_AGENT_1.f2a_2_req_vc_id_1    			      	= `TRANSACTORS_PATH.ufi_2_f2a_req_vc_id[1];
   assign   `UFI_2_AGENT_1.f2a_2_req_header_1         				= `TRANSACTORS_PATH.ufi_2_f2a_req_header[1];
   assign   `UFI_2_AGENT_1.f2a_2_req_shared_credit_1          = `TRANSACTORS_PATH.ufi_2_f2a_req_shared_credit[1];  
   assign   `UFI_2_AGENT_1.f2a_2_req_txflow_crd_block_1       = `TRANSACTORS_PATH.ufi_2_f2a_req_txflow_crd_block[1];
    
// F2A Response connections 
   assign   `UFI_2_AGENT_1.f2a_2_rsp_is_valid_1       				= `TRANSACTORS_PATH.ufi_2_f2a_rsp_is_valid[1];
   assign   `UFI_2_AGENT_1.f2a_2_rsp_early_valid_1            = `TRANSACTORS_PATH.ufi_2_f2a_rsp_early_valid[1];
   assign   `UFI_2_AGENT_1.f2a_2_rsp_protocol_id_1    				= `TRANSACTORS_PATH.ufi_2_f2a_rsp_protocol_id[1];
   assign   `UFI_2_AGENT_1.f2a_2_rsp_vc_id_1    		      		= `TRANSACTORS_PATH.ufi_2_f2a_rsp_vc_id[1];
   assign   `UFI_2_AGENT_1.f2a_2_rsp_header_1         				= `TRANSACTORS_PATH.ufi_2_f2a_rsp_header[1];
   assign   `UFI_2_AGENT_1.f2a_2_rsp_shared_credit_1          = `TRANSACTORS_PATH.ufi_2_f2a_rsp_shared_credit[1];
   assign   `UFI_2_AGENT_1.f2a_2_rsp_txflow_crd_block_1       = `TRANSACTORS_PATH.ufi_2_f2a_rsp_txflow_crd_block[1];
    
// F2A Data connections 
   assign   `UFI_2_AGENT_1.f2a_2_data_is_valid_1     				= `TRANSACTORS_PATH.ufi_2_f2a_data_is_valid[1]; 
   assign   `UFI_2_AGENT_1.f2a_2_data_early_valid_1         = `TRANSACTORS_PATH.ufi_2_f2a_data_early_valid[1];
   assign   `UFI_2_AGENT_1.f2a_2_data_protocol_id_1 				= `TRANSACTORS_PATH.ufi_2_f2a_data_protocol_id[1];
   assign   `UFI_2_AGENT_1.f2a_2_data_vc_id_1 			      	= `TRANSACTORS_PATH.ufi_2_f2a_data_vc_id[1];
   assign   `UFI_2_AGENT_1.f2a_2_data_header_1       				= `TRANSACTORS_PATH.ufi_2_f2a_data_header[1]; 
   assign   `UFI_2_AGENT_1.f2a_2_data_eop_1          				= `TRANSACTORS_PATH.ufi_2_f2a_data_eop[1]; 
   assign   `UFI_2_AGENT_1.f2a_2_data_payload_1      				= `TRANSACTORS_PATH.ufi_2_f2a_data_payload[1];
   assign   `UFI_2_AGENT_1.f2a_2_data_shared_credit_1       = `TRANSACTORS_PATH.ufi_2_f2a_data_shared_credit[1]; 
   assign   `UFI_2_AGENT_1.f2a_2_data_txflow_crd_block_1    = `TRANSACTORS_PATH.ufi_2_f2a_data_txflow_crd_block[1];


// A2F Global connections
   assign   `UFI_2_AGENT_1.a2f_2_rx_ack_1            				= `TRANSACTORS_PATH.ufi_2_a2f_rx_ack[1]; 
   assign   `UFI_2_AGENT_1.a2f_2_rx_empty_1          				= `TRANSACTORS_PATH.ufi_2_a2f_rx_empty[1]; 
   assign   `UFI_2_AGENT_1.a2f_2_rxdiscon_nack_1 			    	= `TRANSACTORS_PATH.ufi_2_a2f_rxdiscon_nack[1]; 
   
// F2A Global connections
   assign   `UFI_2_AGENT_1.f2a_2_txcon_req_1    					= `TRANSACTORS_PATH.ufi_2_f2a_txcon_req[1]; 

