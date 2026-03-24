//=================================================================================================================================
// UFI_FABRIC connections - USER MUST EDIT THE RIGHT HAND SIDE OF THE FOLLOWING ASSIGNMENTS AND DEFINE - WHEN NEEDED
//=================================================================================================================================
// UFI_FABRIC   connection #0

			`define 	UFI_AGENT_0 					`FPGA_TRANSACTORS_TOP       // example:  fpga_tcss_top.tcss_val_rtl.tcss.par_iom

assign 		`TRANSACTORS_PATH.ufi_fabric_clk[0] 				= `UFI_AGENT_0.ufi_agent_clock_0; 
assign 		`TRANSACTORS_PATH.ufi_fabric_rstn[0] 				= `UFI_AGENT_0.ufi_agent_rst_n_0; 
      
// A2F Request connections
   assign   `TRANSACTORS_PATH.ufi_a2f_req_is_valid[0]          	= `UFI_AGENT_0.a2f_req_is_valid_0;
   assign   `TRANSACTORS_PATH.ufi_a2f_req_protocol_id[0]       	= `UFI_AGENT_0.a2f_req_protocol_id_0;
   assign   `TRANSACTORS_PATH.ufi_a2f_req_vc_id[0]            	= `UFI_AGENT_0.a2f_req_vc_id_0;
   assign   `TRANSACTORS_PATH.ufi_a2f_req_header[0]            	= `UFI_AGENT_0.a2f_req_header_0; 
   
// A2F Response connections
   assign   `TRANSACTORS_PATH.ufi_a2f_rsp_is_valid[0]         	= `UFI_AGENT_0.a2f_rsp_is_valid_0;
   assign   `TRANSACTORS_PATH.ufi_a2f_rsp_protocol_id[0]      	= `UFI_AGENT_0.a2f_rsp_protocol_id_0;
   assign   `TRANSACTORS_PATH.ufi_a2f_rsp_vc_id[0]            	= `UFI_AGENT_0.a2f_rsp_vc_id_0;
   assign   `TRANSACTORS_PATH.ufi_a2f_rsp_header[0]           	= `UFI_AGENT_0.a2f_rsp_header_0; 
   
// A2F Data connections 
   assign   `TRANSACTORS_PATH.ufi_a2f_data_is_valid[0]       	= `UFI_AGENT_0.a2f_data_is_valid_0; 
   assign   `TRANSACTORS_PATH.ufi_a2f_data_protocol_id[0]    	= `UFI_AGENT_0.a2f_data_protocol_id_0;
   assign   `TRANSACTORS_PATH.ufi_a2f_data_vc_id[0]         	= `UFI_AGENT_0.a2f_data_vc_id_0;
   assign   `TRANSACTORS_PATH.ufi_a2f_data_header[0]         	= `UFI_AGENT_0.a2f_data_header_0; 
   assign   `TRANSACTORS_PATH.ufi_a2f_data_eop[0]            	= `UFI_AGENT_0.a2f_data_eop_0; 
   assign   `TRANSACTORS_PATH.ufi_a2f_data_payload[0]        	= `UFI_AGENT_0.a2f_data_payload_0; 
   
// F2A Request connections 
   assign   `TRANSACTORS_PATH.ufi_f2a_req_rxcrd[0]             	= `UFI_AGENT_0.f2a_req_rxcrd_0;             
   assign   `TRANSACTORS_PATH.ufi_f2a_req_rxcrd_protocol_id[0] 	= `UFI_AGENT_0.f2a_req_rxcrd_protocol_id_0;
   assign   `TRANSACTORS_PATH.ufi_f2a_req_rxcrd_vc_id[0]      	= `UFI_AGENT_0.f2a_req_rxcrd_vc_id_0;
   
// F2A Response connections 
   assign   `TRANSACTORS_PATH.ufi_f2a_rsp_rxcrd[0]             	= `UFI_AGENT_0.f2a_rsp_rxcrd_0;             
   assign   `TRANSACTORS_PATH.ufi_f2a_rsp_rxcrd_protocol_id[0] 	= `UFI_AGENT_0.f2a_rsp_rxcrd_protocol_id_0;
   assign   `TRANSACTORS_PATH.ufi_f2a_rsp_rxcrd_vc_id[0]      	= `UFI_AGENT_0.f2a_rsp_rxcrd_vc_id_0;

// F2A Data connections 
   assign   `TRANSACTORS_PATH.ufi_f2a_data_rxcrd[0]             = `UFI_AGENT_0.f2a_data_rxcrd_0;             
   assign   `TRANSACTORS_PATH.ufi_f2a_data_rxcrd_protocol_id[0] = `UFI_AGENT_0.f2a_data_rxcrd_protocol_id_0;
   assign   `TRANSACTORS_PATH.ufi_f2a_data_rxcrd_vc_id[0]       = `UFI_AGENT_0.f2a_data_rxcrd_vc_id_0;
// A2F Global connections
   assign   `TRANSACTORS_PATH.ufi_a2f_txcon_req[0]    			= `UFI_AGENT_0.a2f_txcon_req_0; 
   
// F2A Global connections
   assign   `TRANSACTORS_PATH.ufi_f2a_rx_ack[0]            		= `UFI_AGENT_0.f2a_rx_ack_0; 
   assign   `TRANSACTORS_PATH.ufi_f2a_rx_empty[0]          		= `UFI_AGENT_0.f2a_rx_empty_0; 
   assign   `TRANSACTORS_PATH.ufi_f2a_rxdiscon_nack[0] 	    	= `UFI_AGENT_0.f2a_rxdiscon_nack_0;



//=================================================================================================================================
// UFI_FABRIC connections - USER MUST EDIT THE LEFT HAND SIDE OF THE FOLLOWING ASSIGNMENTS 
//=================================================================================================================================
// A2F Request connections
   assign   `UFI_AGENT_0.a2f_req_rxcrd_0              			= `TRANSACTORS_PATH.ufi_a2f_req_rxcrd[0]; 
   assign   `UFI_AGENT_0.a2f_req_rxcrd_protocol_id_0  			= `TRANSACTORS_PATH.ufi_a2f_req_rxcrd_protocol_id[0];
   assign   `UFI_AGENT_0.a2f_req_rxcrd_vc_id_0  		       	= `TRANSACTORS_PATH.ufi_a2f_req_rxcrd_vc_id[0]; 
 
   
// A2F Response connections
   assign   `UFI_AGENT_0.a2f_rsp_rxcrd_0              			= `TRANSACTORS_PATH.ufi_a2f_rsp_rxcrd[0]; 
   assign   `UFI_AGENT_0.a2f_rsp_rxcrd_protocol_id_0  			= `TRANSACTORS_PATH.ufi_a2f_rsp_rxcrd_protocol_id[0]; 
   assign   `UFI_AGENT_0.a2f_rsp_rxcrd_vc_id_0  		      	= `TRANSACTORS_PATH.ufi_a2f_rsp_rxcrd_vc_id[0];

// A2F Data connections 
   assign   `UFI_AGENT_0.a2f_data_rxcrd_0             		 	= `TRANSACTORS_PATH.ufi_a2f_data_rxcrd[0]; 
   assign   `UFI_AGENT_0.a2f_data_rxcrd_protocol_id_0  			= `TRANSACTORS_PATH.ufi_a2f_data_rxcrd_protocol_id[0]; 
   assign   `UFI_AGENT_0.a2f_data_rxcrd_vc_id_0  		      	= `TRANSACTORS_PATH.ufi_a2f_data_rxcrd_vc_id[0];
// F2A Request connections 
   assign   `UFI_AGENT_0.f2a_req_is_valid_0       				= `TRANSACTORS_PATH.ufi_f2a_req_is_valid[0];
   assign   `UFI_AGENT_0.f2a_req_protocol_id_0    				= `TRANSACTORS_PATH.ufi_f2a_req_protocol_id[0];
   assign   `UFI_AGENT_0.f2a_req_vc_id_0    			      	= `TRANSACTORS_PATH.ufi_f2a_req_vc_id[0];
   assign   `UFI_AGENT_0.f2a_req_header_0         				= `TRANSACTORS_PATH.ufi_f2a_req_header[0]; 
   
// F2A Response connections 
   assign   `UFI_AGENT_0.f2a_rsp_is_valid_0       				= `TRANSACTORS_PATH.ufi_f2a_rsp_is_valid[0];
   assign   `UFI_AGENT_0.f2a_rsp_protocol_id_0    				= `TRANSACTORS_PATH.ufi_f2a_rsp_protocol_id[0];
   assign   `UFI_AGENT_0.f2a_rsp_vc_id_0    		      		= `TRANSACTORS_PATH.ufi_f2a_rsp_vc_id[0];
   assign   `UFI_AGENT_0.f2a_rsp_header_0         				= `TRANSACTORS_PATH.ufi_f2a_rsp_header[0]; 
   
// F2A Data connections 
   assign   `UFI_AGENT_0.f2a_data_is_valid_0     				= `TRANSACTORS_PATH.ufi_f2a_data_is_valid[0]; 
   assign   `UFI_AGENT_0.f2a_data_protocol_id_0 				= `TRANSACTORS_PATH.ufi_f2a_data_protocol_id[0];
   assign   `UFI_AGENT_0.f2a_data_vc_id_0 			      	= `TRANSACTORS_PATH.ufi_f2a_data_vc_id[0];
   assign   `UFI_AGENT_0.f2a_data_header_0       				= `TRANSACTORS_PATH.ufi_f2a_data_header[0]; 
   assign   `UFI_AGENT_0.f2a_data_eop_0          				= `TRANSACTORS_PATH.ufi_f2a_data_eop[0]; 
   assign   `UFI_AGENT_0.f2a_data_payload_0      				= `TRANSACTORS_PATH.ufi_f2a_data_payload[0]; 

// A2F Global connections
   assign   `UFI_AGENT_0.a2f_rx_ack_0            				= `TRANSACTORS_PATH.ufi_a2f_rx_ack[0]; 
   assign   `UFI_AGENT_0.a2f_rx_empty_0          				= `TRANSACTORS_PATH.ufi_a2f_rx_empty[0]; 
   assign   `UFI_AGENT_0.a2f_rxdiscon_nack_0 			    	= `TRANSACTORS_PATH.ufi_a2f_rxdiscon_nack[0]; 
   
// F2A Global connections
   assign   `UFI_AGENT_0.f2a_txcon_req_0    					= `TRANSACTORS_PATH.ufi_f2a_txcon_req[0]; 

