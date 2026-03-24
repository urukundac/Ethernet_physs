
			//`define 	UFI_2_FABRIC_0 					`FPGA_TRANSACTORS_TOP 
			//`define 	UFI_2_AGENT_0 					`FPGA_TRANSACTORS_TOP       // example:  fpga_tcss_top.tcss_val_rtl.tcss.par_iom

      
// A2F Request connections
   assign   a2f_2_req_is_valid_0          			= ufi_agent_a2f_2_req_is_valid_0;
   assign   a2f_2_req_early_valid_0        			= ufi_agent_a2f_2_req_early_valid_0;  
   assign   a2f_2_req_protocol_id_0       			= ufi_agent_a2f_2_req_protocol_id_0;
   assign   a2f_2_req_vc_id_0            			= ufi_agent_a2f_2_req_vc_id_0;
   assign   a2f_2_req_header_0            			= ufi_agent_a2f_2_req_header_0;
   assign   a2f_2_req_shared_credit_0      			= ufi_agent_a2f_2_req_shared_credit_0;   
   assign   a2f_2_req_txflow_crd_block_0   			= ufi_agent_a2f_2_req_txflow_crd_block_0;

     
// A2F Response connections
   assign   a2f_2_rsp_is_valid_0         			= ufi_agent_a2f_2_rsp_is_valid_0;
   assign   a2f_2_rsp_early_valid_0        			= ufi_agent_a2f_2_rsp_early_valid_0; 
   assign   a2f_2_rsp_protocol_id_0      			= ufi_agent_a2f_2_rsp_protocol_id_0;
   assign   a2f_2_rsp_vc_id_0            			= ufi_agent_a2f_2_rsp_vc_id_0;
   assign   a2f_2_rsp_header_0           			= ufi_agent_a2f_2_rsp_header_0;
   assign   a2f_2_rsp_shared_credit_0      			= ufi_agent_a2f_2_rsp_shared_credit_0;    
   assign   a2f_2_rsp_txflow_crd_block_0   			= ufi_agent_a2f_2_rsp_txflow_crd_block_0;
   
// A2F Data connections 
   assign   a2f_2_data_is_valid_0       			= ufi_agent_a2f_2_data_is_valid_0;
   assign   a2f_2_data_early_valid_0     			= ufi_agent_a2f_2_data_early_valid_0;   
   assign   a2f_2_data_protocol_id_0    			= ufi_agent_a2f_2_data_protocol_id_0;
   assign   a2f_2_data_vc_id_0         				= ufi_agent_a2f_2_data_vc_id_0;
   assign   a2f_2_data_header_0         			= ufi_agent_a2f_2_data_header_0; 
   assign   a2f_2_data_eop_0            			= ufi_agent_a2f_2_data_eop_0; 
   assign   a2f_2_data_payload_0        			= ufi_agent_a2f_2_data_payload_0;
   assign   a2f_2_data_shared_credit_0   			= ufi_agent_a2f_2_data_shared_credit_0; 
   assign   a2f_2_data_txflow_crd_block_0  			= ufi_agent_a2f_2_data_txflow_crd_block_0;
   
// F2A Request connections 
   assign   f2a_2_req_rxcrd_0             			= ufi_agent_f2a_2_req_rxcrd_0;            
   assign   f2a_2_req_rxcrd_protocol_id_0 			= ufi_agent_f2a_2_req_rxcrd_protocol_id_0;
   assign   f2a_2_req_rxcrd_vc_id_0      			= ufi_agent_f2a_2_req_rxcrd_vc_id_0;
   assign   f2a_2_req_rxcrd_shared_0       			= ufi_agent_f2a_2_req_rxcrd_shared_0;  
   assign   f2a_2_req_block_0              			= ufi_agent_f2a_2_req_block_0;
   
// F2A Response connections 
   assign   f2a_2_rsp_rxcrd_0             			= ufi_agent_f2a_2_rsp_rxcrd_0;            
   assign   f2a_2_rsp_rxcrd_protocol_id_0 			= ufi_agent_f2a_2_rsp_rxcrd_protocol_id_0;
   assign   f2a_2_rsp_rxcrd_vc_id_0      			= ufi_agent_f2a_2_rsp_rxcrd_vc_id_0;
   assign   f2a_2_rsp_rxcrd_shared_0       			= ufi_agent_f2a_2_rsp_rxcrd_shared_0;
   assign   f2a_2_rsp_block_0              			= ufi_agent_f2a_2_rsp_block_0;

// F2A Data connections 
   assign   f2a_2_data_rxcrd_0             			= ufi_agent_f2a_2_data_rxcrd_0;             
   assign   f2a_2_data_rxcrd_protocol_id_0 			= ufi_agent_f2a_2_data_rxcrd_protocol_id_0;
   assign   f2a_2_data_rxcrd_vc_id_0       			= ufi_agent_f2a_2_data_rxcrd_vc_id_0;
   assign   f2a_2_data_rxcrd_shared_0      			= ufi_agent_f2a_2_data_rxcrd_shared_0;
   assign   f2a_2_data_block_0             			= ufi_agent_f2a_2_data_block_0;

// A2F Global connections
   assign   a2f_2_txcon_req_0    					= ufi_agent_a2f_2_txcon_req_0; 
   
// F2A Global connections
   assign   f2a_2_rx_ack_0            				= ufi_agent_f2a_2_rx_ack_0; 
   assign   f2a_2_rx_empty_0          				= ufi_agent_f2a_2_rx_empty_0; 
   assign   f2a_2_rxdiscon_nack_0 	    			= ufi_agent_f2a_2_rxdiscon_nack_0;

/////////////////
/////////////////

// A2F Request connections
   assign   ufi_agent_a2f_2_req_rxcrd_0            	= a2f_2_req_rxcrd_0; 
   assign   ufi_agent_a2f_2_req_rxcrd_protocol_id_0	= a2f_2_req_rxcrd_protocol_id_0;
   assign   ufi_agent_a2f_2_req_rxcrd_vc_id_0  		= a2f_2_req_rxcrd_vc_id_0;
   assign   ufi_agent_a2f_2_req_rxcrd_shared_0       = a2f_2_req_rxcrd_shared_0;
   assign   ufi_agent_a2f_2_req_block_0              = a2f_2_req_block_0; 
    
// A2F Response connections
   assign   ufi_agent_a2f_2_rsp_rxcrd_0              = a2f_2_rsp_rxcrd_0; 
   assign   ufi_agent_a2f_2_rsp_rxcrd_protocol_id_0  = a2f_2_rsp_rxcrd_protocol_id_0; 
   assign   ufi_agent_a2f_2_rsp_rxcrd_vc_id_0  		= a2f_2_rsp_rxcrd_vc_id_0;
   assign   ufi_agent_a2f_2_rsp_rxcrd_shared_0       = a2f_2_rsp_rxcrd_shared_0;
   assign   ufi_agent_a2f_2_rsp_block_0              = a2f_2_rsp_block_0; 

// A2F Data connections 
   assign   ufi_agent_a2f_2_data_rxcrd_0             = a2f_2_data_rxcrd_0; 
   assign   ufi_agent_a2f_2_data_rxcrd_protocol_id_0 = a2f_2_data_rxcrd_protocol_id_0; 
   assign   ufi_agent_a2f_2_data_rxcrd_vc_id_0  		= a2f_2_data_rxcrd_vc_id_0;
   assign   ufi_agent_a2f_2_data_rxcrd_shared_0      = a2f_2_data_rxcrd_shared_0;
   assign   ufi_agent_a2f_2_data_block_0             = a2f_2_data_block_0; 

// F2A Request connections 
   assign   ufi_agent_f2a_2_req_is_valid_0       	= f2a_2_req_is_valid_0;
   assign   ufi_agent_f2a_2_req_early_valid_0        = f2a_2_req_early_valid_0;
   assign   ufi_agent_f2a_2_req_protocol_id_0    	= f2a_2_req_protocol_id_0;
   assign   ufi_agent_f2a_2_req_vc_id_0    			= f2a_2_req_vc_id_0;
   assign   ufi_agent_f2a_2_req_header_0         	= f2a_2_req_header_0;
   assign   ufi_agent_f2a_2_req_shared_credit_0      = f2a_2_req_shared_credit_0;  
   assign   ufi_agent_f2a_2_req_txflow_crd_block_0   = f2a_2_req_txflow_crd_block_0;
    
// F2A Response connections 
   assign   ufi_agent_f2a_2_rsp_is_valid_0       	= f2a_2_rsp_is_valid_0;
   assign   ufi_agent_f2a_2_rsp_early_valid_0        = f2a_2_rsp_early_valid_0;
   assign   ufi_agent_f2a_2_rsp_protocol_id_0    	= f2a_2_rsp_protocol_id_0;
   assign   ufi_agent_f2a_2_rsp_vc_id_0    		    = f2a_2_rsp_vc_id_0;
   assign   ufi_agent_f2a_2_rsp_header_0         	= f2a_2_rsp_header_0;
   assign   ufi_agent_f2a_2_rsp_shared_credit_0      = f2a_2_rsp_shared_credit_0;
   assign   ufi_agent_f2a_2_rsp_txflow_crd_block_0   = f2a_2_rsp_txflow_crd_block_0;
    
// F2A Data connections 
   assign   ufi_agent_f2a_2_data_is_valid_0     		= f2a_2_data_is_valid_0; 
   assign   ufi_agent_f2a_2_data_early_valid_0       = f2a_2_data_early_valid_0;
   assign   ufi_agent_f2a_2_data_protocol_id_0 		= f2a_2_data_protocol_id_0;
   assign   ufi_agent_f2a_2_data_vc_id_0 			= f2a_2_data_vc_id_0;
   assign   ufi_agent_f2a_2_data_header_0       		= f2a_2_data_header_0; 
   assign   ufi_agent_f2a_2_data_eop_0          		= f2a_2_data_eop_0; 
   assign   ufi_agent_f2a_2_data_payload_0      		= f2a_2_data_payload_0;
   assign   ufi_agent_f2a_2_data_shared_credit_0     = f2a_2_data_shared_credit_0; 
   assign   ufi_agent_f2a_2_data_txflow_crd_block_0  = f2a_2_data_txflow_crd_block_0;


// A2F Global connections
   assign   ufi_agent_a2f_2_rx_ack_0            		= a2f_2_rx_ack_0; 
   assign   ufi_agent_a2f_2_rx_empty_0          		= a2f_2_rx_empty_0; 
   assign   ufi_agent_a2f_2_rxdiscon_nack_0 			= a2f_2_rxdiscon_nack_0; 
   
// F2A Global connections
   assign   ufi_agent_f2a_2_txcon_req_0    			= f2a_2_txcon_req_0; 

/////////////////

			//`define 	UFI_2_FABRIC_1 					`FPGA_TRANSACTORS_TOP 
			//`define 	UFI_2_AGENT_1 					`FPGA_TRANSACTORS_TOP       // example:  fpga_tcss_top.tcss_val_rtl.tcss.par_iom

      
// A2F Request connections
   assign   a2f_2_req_is_valid_1          			= ufi_agent_a2f_2_req_is_valid_1;
   assign   a2f_2_req_early_valid_1        			= ufi_agent_a2f_2_req_early_valid_1;  
   assign   a2f_2_req_protocol_id_1       			= ufi_agent_a2f_2_req_protocol_id_1;
   assign   a2f_2_req_vc_id_1            			= ufi_agent_a2f_2_req_vc_id_1;
   assign   a2f_2_req_header_1            			= ufi_agent_a2f_2_req_header_1;
   assign   a2f_2_req_shared_credit_1      			= ufi_agent_a2f_2_req_shared_credit_1;   
   assign   a2f_2_req_txflow_crd_block_1   			= ufi_agent_a2f_2_req_txflow_crd_block_1;

     
// A2F Response connections
   assign   a2f_2_rsp_is_valid_1         			= ufi_agent_a2f_2_rsp_is_valid_1;
   assign   a2f_2_rsp_early_valid_1        			= ufi_agent_a2f_2_rsp_early_valid_1; 
   assign   a2f_2_rsp_protocol_id_1      			= ufi_agent_a2f_2_rsp_protocol_id_1;
   assign   a2f_2_rsp_vc_id_1            			= ufi_agent_a2f_2_rsp_vc_id_1;
   assign   a2f_2_rsp_header_1           			= ufi_agent_a2f_2_rsp_header_1;
   assign   a2f_2_rsp_shared_credit_1      			= ufi_agent_a2f_2_rsp_shared_credit_1;    
   assign   a2f_2_rsp_txflow_crd_block_1   			= ufi_agent_a2f_2_rsp_txflow_crd_block_1;
   
// A2F Data connections 
   assign   a2f_2_data_is_valid_1       			= ufi_agent_a2f_2_data_is_valid_1;
   assign   a2f_2_data_early_valid_1     			= ufi_agent_a2f_2_data_early_valid_1;   
   assign   a2f_2_data_protocol_id_1    			= ufi_agent_a2f_2_data_protocol_id_1;
   assign   a2f_2_data_vc_id_1         				= ufi_agent_a2f_2_data_vc_id_1;
   assign   a2f_2_data_header_1         			= ufi_agent_a2f_2_data_header_1; 
   assign   a2f_2_data_eop_1            			= ufi_agent_a2f_2_data_eop_1; 
   assign   a2f_2_data_payload_1        			= ufi_agent_a2f_2_data_payload_1;
   assign   a2f_2_data_shared_credit_1   			= ufi_agent_a2f_2_data_shared_credit_1; 
   assign   a2f_2_data_txflow_crd_block_1  			= ufi_agent_a2f_2_data_txflow_crd_block_1;
   
// F2A Request connections 
   assign   f2a_2_req_rxcrd_1             			= ufi_agent_f2a_2_req_rxcrd_1;            
   assign   f2a_2_req_rxcrd_protocol_id_1 			= ufi_agent_f2a_2_req_rxcrd_protocol_id_1;
   assign   f2a_2_req_rxcrd_vc_id_1      			= ufi_agent_f2a_2_req_rxcrd_vc_id_1;
   assign   f2a_2_req_rxcrd_shared_1       			= ufi_agent_f2a_2_req_rxcrd_shared_1;  
   assign   f2a_2_req_block_1              			= ufi_agent_f2a_2_req_block_1;
   
// F2A Response connections 
   assign   f2a_2_rsp_rxcrd_1             			= ufi_agent_f2a_2_rsp_rxcrd_1;            
   assign   f2a_2_rsp_rxcrd_protocol_id_1 			= ufi_agent_f2a_2_rsp_rxcrd_protocol_id_1;
   assign   f2a_2_rsp_rxcrd_vc_id_1      			= ufi_agent_f2a_2_rsp_rxcrd_vc_id_1;
   assign   f2a_2_rsp_rxcrd_shared_1       			= ufi_agent_f2a_2_rsp_rxcrd_shared_1;
   assign   f2a_2_rsp_block_1              			= ufi_agent_f2a_2_rsp_block_1;

// F2A Data connections 
   assign   f2a_2_data_rxcrd_1             			= ufi_agent_f2a_2_data_rxcrd_1;             
   assign   f2a_2_data_rxcrd_protocol_id_1 			= ufi_agent_f2a_2_data_rxcrd_protocol_id_1;
   assign   f2a_2_data_rxcrd_vc_id_1       			= ufi_agent_f2a_2_data_rxcrd_vc_id_1;
   assign   f2a_2_data_rxcrd_shared_1      			= ufi_agent_f2a_2_data_rxcrd_shared_1;
   assign   f2a_2_data_block_1             			= ufi_agent_f2a_2_data_block_1;

// A2F Global connections
   assign   a2f_2_txcon_req_1    					= ufi_agent_a2f_2_txcon_req_1; 
   
// F2A Global connections
   assign   f2a_2_rx_ack_1            				= ufi_agent_f2a_2_rx_ack_1; 
   assign   f2a_2_rx_empty_1          				= ufi_agent_f2a_2_rx_empty_1; 
   assign   f2a_2_rxdiscon_nack_1 	    			= ufi_agent_f2a_2_rxdiscon_nack_1;

/////////////////
/////////////////

// A2F Request connections
   assign   ufi_agent_a2f_2_req_rxcrd_1            	= a2f_2_req_rxcrd_1; 
   assign   ufi_agent_a2f_2_req_rxcrd_protocol_id_1	= a2f_2_req_rxcrd_protocol_id_1;
   assign   ufi_agent_a2f_2_req_rxcrd_vc_id_1  		= a2f_2_req_rxcrd_vc_id_1;
   assign   ufi_agent_a2f_2_req_rxcrd_shared_1       = a2f_2_req_rxcrd_shared_1;
   assign   ufi_agent_a2f_2_req_block_1              = a2f_2_req_block_1; 
    
// A2F Response connections
   assign   ufi_agent_a2f_2_rsp_rxcrd_1              = a2f_2_rsp_rxcrd_1; 
   assign   ufi_agent_a2f_2_rsp_rxcrd_protocol_id_1  = a2f_2_rsp_rxcrd_protocol_id_1; 
   assign   ufi_agent_a2f_2_rsp_rxcrd_vc_id_1  		= a2f_2_rsp_rxcrd_vc_id_1;
   assign   ufi_agent_a2f_2_rsp_rxcrd_shared_1       = a2f_2_rsp_rxcrd_shared_1;
   assign   ufi_agent_a2f_2_rsp_block_1              = a2f_2_rsp_block_1; 

// A2F Data connections 
   assign   ufi_agent_a2f_2_data_rxcrd_1             = a2f_2_data_rxcrd_1; 
   assign   ufi_agent_a2f_2_data_rxcrd_protocol_id_1 = a2f_2_data_rxcrd_protocol_id_1; 
   assign   ufi_agent_a2f_2_data_rxcrd_vc_id_1  		= a2f_2_data_rxcrd_vc_id_1;
   assign   ufi_agent_a2f_2_data_rxcrd_shared_1      = a2f_2_data_rxcrd_shared_1;
   assign   ufi_agent_a2f_2_data_block_1             = a2f_2_data_block_1; 

// F2A Request connections 
   assign   ufi_agent_f2a_2_req_is_valid_1       	= f2a_2_req_is_valid_1;
   assign   ufi_agent_f2a_2_req_early_valid_1        = f2a_2_req_early_valid_1;
   assign   ufi_agent_f2a_2_req_protocol_id_1    	= f2a_2_req_protocol_id_1;
   assign   ufi_agent_f2a_2_req_vc_id_1    			= f2a_2_req_vc_id_1;
   assign   ufi_agent_f2a_2_req_header_1         	= f2a_2_req_header_1;
   assign   ufi_agent_f2a_2_req_shared_credit_1      = f2a_2_req_shared_credit_1;  
   assign   ufi_agent_f2a_2_req_txflow_crd_block_1   = f2a_2_req_txflow_crd_block_1;
    
// F2A Response connections 
   assign   ufi_agent_f2a_2_rsp_is_valid_1       	= f2a_2_rsp_is_valid_1;
   assign   ufi_agent_f2a_2_rsp_early_valid_1        = f2a_2_rsp_early_valid_1;
   assign   ufi_agent_f2a_2_rsp_protocol_id_1    	= f2a_2_rsp_protocol_id_1;
   assign   ufi_agent_f2a_2_rsp_vc_id_1    		    = f2a_2_rsp_vc_id_1;
   assign   ufi_agent_f2a_2_rsp_header_1         	= f2a_2_rsp_header_1;
   assign   ufi_agent_f2a_2_rsp_shared_credit_1      = f2a_2_rsp_shared_credit_1;
   assign   ufi_agent_f2a_2_rsp_txflow_crd_block_1   = f2a_2_rsp_txflow_crd_block_1;
    
// F2A Data connections 
   assign   ufi_agent_f2a_2_data_is_valid_1     		= f2a_2_data_is_valid_1; 
   assign   ufi_agent_f2a_2_data_early_valid_1       = f2a_2_data_early_valid_1;
   assign   ufi_agent_f2a_2_data_protocol_id_1 		= f2a_2_data_protocol_id_1;
   assign   ufi_agent_f2a_2_data_vc_id_1 			= f2a_2_data_vc_id_1;
   assign   ufi_agent_f2a_2_data_header_1       		= f2a_2_data_header_1; 
   assign   ufi_agent_f2a_2_data_eop_1          		= f2a_2_data_eop_1; 
   assign   ufi_agent_f2a_2_data_payload_1      		= f2a_2_data_payload_1;
   assign   ufi_agent_f2a_2_data_shared_credit_1     = f2a_2_data_shared_credit_1; 
   assign   ufi_agent_f2a_2_data_txflow_crd_block_1  = f2a_2_data_txflow_crd_block_1;


// A2F Global connections
   assign   ufi_agent_a2f_2_rx_ack_1            		= a2f_2_rx_ack_1; 
   assign   ufi_agent_a2f_2_rx_empty_1          		= a2f_2_rx_empty_1; 
   assign   ufi_agent_a2f_2_rxdiscon_nack_1 			= a2f_2_rxdiscon_nack_1; 
   
// F2A Global connections
   assign   ufi_agent_f2a_2_txcon_req_1    			= f2a_2_txcon_req_1; 

///////////////////


			//`define 	UFI_2_FABRIC_2 					`FPGA_TRANSACTORS_TOP 
			//`define 	UFI_2_AGENT_2 					`FPGA_TRANSACTORS_TOP       // example:  fpga_tcss_top.tcss_val_rtl.tcss.par_iom

      
// A2F Request connections
   assign   a2f_2_req_is_valid_2          			= ufi_agent_a2f_2_req_is_valid_2;
   assign   a2f_2_req_early_valid_2        			= ufi_agent_a2f_2_req_early_valid_2;  
   assign   a2f_2_req_protocol_id_2       			= ufi_agent_a2f_2_req_protocol_id_2;
   assign   a2f_2_req_vc_id_2            			= ufi_agent_a2f_2_req_vc_id_2;
   assign   a2f_2_req_header_2            			= ufi_agent_a2f_2_req_header_2;
   assign   a2f_2_req_shared_credit_2      			= ufi_agent_a2f_2_req_shared_credit_2;   
   assign   a2f_2_req_txflow_crd_block_2   			= ufi_agent_a2f_2_req_txflow_crd_block_2;

     
// A2F Response connections
   assign   a2f_2_rsp_is_valid_2         			= ufi_agent_a2f_2_rsp_is_valid_2;
   assign   a2f_2_rsp_early_valid_2        			= ufi_agent_a2f_2_rsp_early_valid_2; 
   assign   a2f_2_rsp_protocol_id_2      			= ufi_agent_a2f_2_rsp_protocol_id_2;
   assign   a2f_2_rsp_vc_id_2            			= ufi_agent_a2f_2_rsp_vc_id_2;
   assign   a2f_2_rsp_header_2           			= ufi_agent_a2f_2_rsp_header_2;
   assign   a2f_2_rsp_shared_credit_2      			= ufi_agent_a2f_2_rsp_shared_credit_2;    
   assign   a2f_2_rsp_txflow_crd_block_2   			= ufi_agent_a2f_2_rsp_txflow_crd_block_2;
   
// A2F Data connections 
   assign   a2f_2_data_is_valid_2       			= ufi_agent_a2f_2_data_is_valid_2;
   assign   a2f_2_data_early_valid_2     			= ufi_agent_a2f_2_data_early_valid_2;   
   assign   a2f_2_data_protocol_id_2    			= ufi_agent_a2f_2_data_protocol_id_2;
   assign   a2f_2_data_vc_id_2         				= ufi_agent_a2f_2_data_vc_id_2;
   assign   a2f_2_data_header_2         			= ufi_agent_a2f_2_data_header_2; 
   assign   a2f_2_data_eop_2            			= ufi_agent_a2f_2_data_eop_2; 
   assign   a2f_2_data_payload_2        			= ufi_agent_a2f_2_data_payload_2;
   assign   a2f_2_data_shared_credit_2   			= ufi_agent_a2f_2_data_shared_credit_2; 
   assign   a2f_2_data_txflow_crd_block_2  			= ufi_agent_a2f_2_data_txflow_crd_block_2;
   
// F2A Request connections 
   assign   f2a_2_req_rxcrd_2             			= ufi_agent_f2a_2_req_rxcrd_2;            
   assign   f2a_2_req_rxcrd_protocol_id_2 			= ufi_agent_f2a_2_req_rxcrd_protocol_id_2;
   assign   f2a_2_req_rxcrd_vc_id_2      			= ufi_agent_f2a_2_req_rxcrd_vc_id_2;
   assign   f2a_2_req_rxcrd_shared_2       			= ufi_agent_f2a_2_req_rxcrd_shared_2;  
   assign   f2a_2_req_block_2              			= ufi_agent_f2a_2_req_block_2;
   
// F2A Response connections 
   assign   f2a_2_rsp_rxcrd_2             			= ufi_agent_f2a_2_rsp_rxcrd_2;            
   assign   f2a_2_rsp_rxcrd_protocol_id_2 			= ufi_agent_f2a_2_rsp_rxcrd_protocol_id_2;
   assign   f2a_2_rsp_rxcrd_vc_id_2      			= ufi_agent_f2a_2_rsp_rxcrd_vc_id_2;
   assign   f2a_2_rsp_rxcrd_shared_2       			= ufi_agent_f2a_2_rsp_rxcrd_shared_2;
   assign   f2a_2_rsp_block_2              			= ufi_agent_f2a_2_rsp_block_2;

// F2A Data connections 
   assign   f2a_2_data_rxcrd_2             			= ufi_agent_f2a_2_data_rxcrd_2;             
   assign   f2a_2_data_rxcrd_protocol_id_2 			= ufi_agent_f2a_2_data_rxcrd_protocol_id_2;
   assign   f2a_2_data_rxcrd_vc_id_2       			= ufi_agent_f2a_2_data_rxcrd_vc_id_2;
   assign   f2a_2_data_rxcrd_shared_2      			= ufi_agent_f2a_2_data_rxcrd_shared_2;
   assign   f2a_2_data_block_2             			= ufi_agent_f2a_2_data_block_2;

// A2F Global connections
   assign   a2f_2_txcon_req_2    					= ufi_agent_a2f_2_txcon_req_2; 
   
// F2A Global connections
   assign   f2a_2_rx_ack_2            				= ufi_agent_f2a_2_rx_ack_2; 
   assign   f2a_2_rx_empty_2          				= ufi_agent_f2a_2_rx_empty_2; 
   assign   f2a_2_rxdiscon_nack_2 	    			= ufi_agent_f2a_2_rxdiscon_nack_2;

/////////////////
/////////////////

// A2F Request connections
   assign   ufi_agent_a2f_2_req_rxcrd_2            	= a2f_2_req_rxcrd_2; 
   assign   ufi_agent_a2f_2_req_rxcrd_protocol_id_2	= a2f_2_req_rxcrd_protocol_id_2;
   assign   ufi_agent_a2f_2_req_rxcrd_vc_id_2  		= a2f_2_req_rxcrd_vc_id_2;
   assign   ufi_agent_a2f_2_req_rxcrd_shared_2       = a2f_2_req_rxcrd_shared_2;
   assign   ufi_agent_a2f_2_req_block_2              = a2f_2_req_block_2; 
    
// A2F Response connections
   assign   ufi_agent_a2f_2_rsp_rxcrd_2              = a2f_2_rsp_rxcrd_2; 
   assign   ufi_agent_a2f_2_rsp_rxcrd_protocol_id_2  = a2f_2_rsp_rxcrd_protocol_id_2; 
   assign   ufi_agent_a2f_2_rsp_rxcrd_vc_id_2  		= a2f_2_rsp_rxcrd_vc_id_2;
   assign   ufi_agent_a2f_2_rsp_rxcrd_shared_2       = a2f_2_rsp_rxcrd_shared_2;
   assign   ufi_agent_a2f_2_rsp_block_2              = a2f_2_rsp_block_2; 

// A2F Data connections 
   assign   ufi_agent_a2f_2_data_rxcrd_2             = a2f_2_data_rxcrd_2; 
   assign   ufi_agent_a2f_2_data_rxcrd_protocol_id_2 = a2f_2_data_rxcrd_protocol_id_2; 
   assign   ufi_agent_a2f_2_data_rxcrd_vc_id_2  		= a2f_2_data_rxcrd_vc_id_2;
   assign   ufi_agent_a2f_2_data_rxcrd_shared_2      = a2f_2_data_rxcrd_shared_2;
   assign   ufi_agent_a2f_2_data_block_2             = a2f_2_data_block_2; 

// F2A Request connections 
   assign   ufi_agent_f2a_2_req_is_valid_2       	= f2a_2_req_is_valid_2;
   assign   ufi_agent_f2a_2_req_early_valid_2        = f2a_2_req_early_valid_2;
   assign   ufi_agent_f2a_2_req_protocol_id_2    	= f2a_2_req_protocol_id_2;
   assign   ufi_agent_f2a_2_req_vc_id_2    			= f2a_2_req_vc_id_2;
   assign   ufi_agent_f2a_2_req_header_2         	= f2a_2_req_header_2;
   assign   ufi_agent_f2a_2_req_shared_credit_2      = f2a_2_req_shared_credit_2;  
   assign   ufi_agent_f2a_2_req_txflow_crd_block_2   = f2a_2_req_txflow_crd_block_2;
    
// F2A Response connections 
   assign   ufi_agent_f2a_2_rsp_is_valid_2       	= f2a_2_rsp_is_valid_2;
   assign   ufi_agent_f2a_2_rsp_early_valid_2        = f2a_2_rsp_early_valid_2;
   assign   ufi_agent_f2a_2_rsp_protocol_id_2    	= f2a_2_rsp_protocol_id_2;
   assign   ufi_agent_f2a_2_rsp_vc_id_2    		    = f2a_2_rsp_vc_id_2;
   assign   ufi_agent_f2a_2_rsp_header_2         	= f2a_2_rsp_header_2;
   assign   ufi_agent_f2a_2_rsp_shared_credit_2      = f2a_2_rsp_shared_credit_2;
   assign   ufi_agent_f2a_2_rsp_txflow_crd_block_2   = f2a_2_rsp_txflow_crd_block_2;
    
// F2A Data connections 
   assign   ufi_agent_f2a_2_data_is_valid_2     		= f2a_2_data_is_valid_2; 
   assign   ufi_agent_f2a_2_data_early_valid_2       = f2a_2_data_early_valid_2;
   assign   ufi_agent_f2a_2_data_protocol_id_2 		= f2a_2_data_protocol_id_2;
   assign   ufi_agent_f2a_2_data_vc_id_2 			= f2a_2_data_vc_id_2;
   assign   ufi_agent_f2a_2_data_header_2       		= f2a_2_data_header_2; 
   assign   ufi_agent_f2a_2_data_eop_2          		= f2a_2_data_eop_2; 
   assign   ufi_agent_f2a_2_data_payload_2      		= f2a_2_data_payload_2;
   assign   ufi_agent_f2a_2_data_shared_credit_2     = f2a_2_data_shared_credit_2; 
   assign   ufi_agent_f2a_2_data_txflow_crd_block_2  = f2a_2_data_txflow_crd_block_2;


// A2F Global connections
   assign   ufi_agent_a2f_2_rx_ack_2            		= a2f_2_rx_ack_2; 
   assign   ufi_agent_a2f_2_rx_empty_2          		= a2f_2_rx_empty_2; 
   assign   ufi_agent_a2f_2_rxdiscon_nack_2 			= a2f_2_rxdiscon_nack_2; 
   
// F2A Global connections
   assign   ufi_agent_f2a_2_txcon_req_2    			= f2a_2_txcon_req_2; 

///////////////////////


			//`define 	UFI_2_FABRIC_3 					`FPGA_TRANSACTORS_TOP 
			//`define 	UFI_2_AGENT_3 					`FPGA_TRANSACTORS_TOP       // example:  fpga_tcss_top.tcss_val_rtl.tcss.par_iom

      
// A2F Request connections
   assign   a2f_2_req_is_valid_3          			= ufi_agent_a2f_2_req_is_valid_3;
   assign   a2f_2_req_early_valid_3        			= ufi_agent_a2f_2_req_early_valid_3;  
   assign   a2f_2_req_protocol_id_3       			= ufi_agent_a2f_2_req_protocol_id_3;
   assign   a2f_2_req_vc_id_3            			= ufi_agent_a2f_2_req_vc_id_3;
   assign   a2f_2_req_header_3            			= ufi_agent_a2f_2_req_header_3;
   assign   a2f_2_req_shared_credit_3      			= ufi_agent_a2f_2_req_shared_credit_3;   
   assign   a2f_2_req_txflow_crd_block_3   			= ufi_agent_a2f_2_req_txflow_crd_block_3;

     
// A2F Response connections
   assign   a2f_2_rsp_is_valid_3         			= ufi_agent_a2f_2_rsp_is_valid_3;
   assign   a2f_2_rsp_early_valid_3        			= ufi_agent_a2f_2_rsp_early_valid_3; 
   assign   a2f_2_rsp_protocol_id_3      			= ufi_agent_a2f_2_rsp_protocol_id_3;
   assign   a2f_2_rsp_vc_id_3            			= ufi_agent_a2f_2_rsp_vc_id_3;
   assign   a2f_2_rsp_header_3           			= ufi_agent_a2f_2_rsp_header_3;
   assign   a2f_2_rsp_shared_credit_3      			= ufi_agent_a2f_2_rsp_shared_credit_3;    
   assign   a2f_2_rsp_txflow_crd_block_3   			= ufi_agent_a2f_2_rsp_txflow_crd_block_3;
   
// A2F Data connections 
   assign   a2f_2_data_is_valid_3       			= ufi_agent_a2f_2_data_is_valid_3;
   assign   a2f_2_data_early_valid_3     			= ufi_agent_a2f_2_data_early_valid_3;   
   assign   a2f_2_data_protocol_id_3    			= ufi_agent_a2f_2_data_protocol_id_3;
   assign   a2f_2_data_vc_id_3         				= ufi_agent_a2f_2_data_vc_id_3;
   assign   a2f_2_data_header_3         			= ufi_agent_a2f_2_data_header_3; 
   assign   a2f_2_data_eop_3            			= ufi_agent_a2f_2_data_eop_3; 
   assign   a2f_2_data_payload_3        			= ufi_agent_a2f_2_data_payload_3;
   assign   a2f_2_data_shared_credit_3   			= ufi_agent_a2f_2_data_shared_credit_3; 
   assign   a2f_2_data_txflow_crd_block_3  			= ufi_agent_a2f_2_data_txflow_crd_block_3;
   
// F2A Request connections 
   assign   f2a_2_req_rxcrd_3             			= ufi_agent_f2a_2_req_rxcrd_3;            
   assign   f2a_2_req_rxcrd_protocol_id_3 			= ufi_agent_f2a_2_req_rxcrd_protocol_id_3;
   assign   f2a_2_req_rxcrd_vc_id_3      			= ufi_agent_f2a_2_req_rxcrd_vc_id_3;
   assign   f2a_2_req_rxcrd_shared_3       			= ufi_agent_f2a_2_req_rxcrd_shared_3;  
   assign   f2a_2_req_block_3              			= ufi_agent_f2a_2_req_block_3;
   
// F2A Response connections 
   assign   f2a_2_rsp_rxcrd_3             			= ufi_agent_f2a_2_rsp_rxcrd_3;            
   assign   f2a_2_rsp_rxcrd_protocol_id_3 			= ufi_agent_f2a_2_rsp_rxcrd_protocol_id_3;
   assign   f2a_2_rsp_rxcrd_vc_id_3      			= ufi_agent_f2a_2_rsp_rxcrd_vc_id_3;
   assign   f2a_2_rsp_rxcrd_shared_3       			= ufi_agent_f2a_2_rsp_rxcrd_shared_3;
   assign   f2a_2_rsp_block_3              			= ufi_agent_f2a_2_rsp_block_3;

// F2A Data connections 
   assign   f2a_2_data_rxcrd_3             			= ufi_agent_f2a_2_data_rxcrd_3;             
   assign   f2a_2_data_rxcrd_protocol_id_3 			= ufi_agent_f2a_2_data_rxcrd_protocol_id_3;
   assign   f2a_2_data_rxcrd_vc_id_3       			= ufi_agent_f2a_2_data_rxcrd_vc_id_3;
   assign   f2a_2_data_rxcrd_shared_3      			= ufi_agent_f2a_2_data_rxcrd_shared_3;
   assign   f2a_2_data_block_3             			= ufi_agent_f2a_2_data_block_3;

// A2F Global connections
   assign   a2f_2_txcon_req_3    					= ufi_agent_a2f_2_txcon_req_3; 
   
// F2A Global connections
   assign   f2a_2_rx_ack_3            				= ufi_agent_f2a_2_rx_ack_3; 
   assign   f2a_2_rx_empty_3          				= ufi_agent_f2a_2_rx_empty_3; 
   assign   f2a_2_rxdiscon_nack_3 	    			= ufi_agent_f2a_2_rxdiscon_nack_3;

/////////////////
/////////////////

// A2F Request connections
   assign   ufi_agent_a2f_2_req_rxcrd_3            	= a2f_2_req_rxcrd_3; 
   assign   ufi_agent_a2f_2_req_rxcrd_protocol_id_3	= a2f_2_req_rxcrd_protocol_id_3;
   assign   ufi_agent_a2f_2_req_rxcrd_vc_id_3  		= a2f_2_req_rxcrd_vc_id_3;
   assign   ufi_agent_a2f_2_req_rxcrd_shared_3       = a2f_2_req_rxcrd_shared_3;
   assign   ufi_agent_a2f_2_req_block_3              = a2f_2_req_block_3; 
    
// A2F Response connections
   assign   ufi_agent_a2f_2_rsp_rxcrd_3              = a2f_2_rsp_rxcrd_3; 
   assign   ufi_agent_a2f_2_rsp_rxcrd_protocol_id_3  = a2f_2_rsp_rxcrd_protocol_id_3; 
   assign   ufi_agent_a2f_2_rsp_rxcrd_vc_id_3  		= a2f_2_rsp_rxcrd_vc_id_3;
   assign   ufi_agent_a2f_2_rsp_rxcrd_shared_3       = a2f_2_rsp_rxcrd_shared_3;
   assign   ufi_agent_a2f_2_rsp_block_3              = a2f_2_rsp_block_3; 

// A2F Data connections 
   assign   ufi_agent_a2f_2_data_rxcrd_3             = a2f_2_data_rxcrd_3; 
   assign   ufi_agent_a2f_2_data_rxcrd_protocol_id_3 = a2f_2_data_rxcrd_protocol_id_3; 
   assign   ufi_agent_a2f_2_data_rxcrd_vc_id_3  		= a2f_2_data_rxcrd_vc_id_3;
   assign   ufi_agent_a2f_2_data_rxcrd_shared_3      = a2f_2_data_rxcrd_shared_3;
   assign   ufi_agent_a2f_2_data_block_3             = a2f_2_data_block_3; 

// F2A Request connections 
   assign   ufi_agent_f2a_2_req_is_valid_3       	= f2a_2_req_is_valid_3;
   assign   ufi_agent_f2a_2_req_early_valid_3        = f2a_2_req_early_valid_3;
   assign   ufi_agent_f2a_2_req_protocol_id_3    	= f2a_2_req_protocol_id_3;
   assign   ufi_agent_f2a_2_req_vc_id_3    			= f2a_2_req_vc_id_3;
   assign   ufi_agent_f2a_2_req_header_3         	= f2a_2_req_header_3;
   assign   ufi_agent_f2a_2_req_shared_credit_3      = f2a_2_req_shared_credit_3;  
   assign   ufi_agent_f2a_2_req_txflow_crd_block_3   = f2a_2_req_txflow_crd_block_3;
    
// F2A Response connections 
   assign   ufi_agent_f2a_2_rsp_is_valid_3       	= f2a_2_rsp_is_valid_3;
   assign   ufi_agent_f2a_2_rsp_early_valid_3        = f2a_2_rsp_early_valid_3;
   assign   ufi_agent_f2a_2_rsp_protocol_id_3    	= f2a_2_rsp_protocol_id_3;
   assign   ufi_agent_f2a_2_rsp_vc_id_3    		    = f2a_2_rsp_vc_id_3;
   assign   ufi_agent_f2a_2_rsp_header_3         	= f2a_2_rsp_header_3;
   assign   ufi_agent_f2a_2_rsp_shared_credit_3      = f2a_2_rsp_shared_credit_3;
   assign   ufi_agent_f2a_2_rsp_txflow_crd_block_3   = f2a_2_rsp_txflow_crd_block_3;
    
// F2A Data connections 
   assign   ufi_agent_f2a_2_data_is_valid_3     		= f2a_2_data_is_valid_3; 
   assign   ufi_agent_f2a_2_data_early_valid_3       = f2a_2_data_early_valid_3;
   assign   ufi_agent_f2a_2_data_protocol_id_3 		= f2a_2_data_protocol_id_3;
   assign   ufi_agent_f2a_2_data_vc_id_3 			= f2a_2_data_vc_id_3;
   assign   ufi_agent_f2a_2_data_header_3       		= f2a_2_data_header_3; 
   assign   ufi_agent_f2a_2_data_eop_3          		= f2a_2_data_eop_3; 
   assign   ufi_agent_f2a_2_data_payload_3      		= f2a_2_data_payload_3;
   assign   ufi_agent_f2a_2_data_shared_credit_3     = f2a_2_data_shared_credit_3; 
   assign   ufi_agent_f2a_2_data_txflow_crd_block_3  = f2a_2_data_txflow_crd_block_3;


// A2F Global connections
   assign   ufi_agent_a2f_2_rx_ack_3            		= a2f_2_rx_ack_3; 
   assign   ufi_agent_a2f_2_rx_empty_3          		= a2f_2_rx_empty_3; 
   assign   ufi_agent_a2f_2_rxdiscon_nack_3 			= a2f_2_rxdiscon_nack_3; 
   
// F2A Global connections
   assign   ufi_agent_f2a_2_txcon_req_3    			= f2a_2_txcon_req_3; 
   
   
