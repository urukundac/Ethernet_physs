//=================================================================================================================================
// UFI_FABRIC connections - USER MUST EDIT THE RIGHT HAND SIDE OF THE FOLLOWING ASSIGNMENTS AND DEFINE - WHEN NEEDED
//=================================================================================================================================
// UFI_FABRIC   connection #0

			`define 	UFI_AGENT_5 					`FPGA_TRANSACTORS_TOP       // example:  fpga_tcss_top.tcss_val_rtl.tcss.par_iom

assign 		`TRANSACTORS_PATH.ufi_fabric_clk[5] 				= `UFI_AGENT_5.ufi_agent_clock_5; 
assign 		`TRANSACTORS_PATH.ufi_fabric_rstn[5] 				= `UFI_AGENT_5.ufi_agent_rst_n_5; 
      
// A2F Request connections
   assign   `TRANSACTORS_PATH.ufi_a2f_req_is_valid[5]          	= `UFI_AGENT_5.a2f_req_is_valid_5;
   assign   `TRANSACTORS_PATH.ufi_a2f_req_protocol_id[5]       	= `UFI_AGENT_5.a2f_req_protocol_id_5;
   assign   `TRANSACTORS_PATH.ufi_a2f_req_vc_id[5]            	= `UFI_AGENT_5.a2f_req_vc_id_5;
   assign   `TRANSACTORS_PATH.ufi_a2f_req_header[5]            	= `UFI_AGENT_5.a2f_req_header_5; 
   
// A2F Response connections
   assign   `TRANSACTORS_PATH.ufi_a2f_rsp_is_valid[5]         	= `UFI_AGENT_5.a2f_rsp_is_valid_5;
   assign   `TRANSACTORS_PATH.ufi_a2f_rsp_protocol_id[5]      	= `UFI_AGENT_5.a2f_rsp_protocol_id_5;
   assign   `TRANSACTORS_PATH.ufi_a2f_rsp_vc_id[5]      	      = `UFI_AGENT_5.a2f_rsp_vc_id_5;
   assign   `TRANSACTORS_PATH.ufi_a2f_rsp_header[5]           	= `UFI_AGENT_5.a2f_rsp_header_5; 
   
// A2F Data connections 
   assign   `TRANSACTORS_PATH.ufi_a2f_data_is_valid[5]       	= `UFI_AGENT_5.a2f_data_is_valid_5; 
   assign   `TRANSACTORS_PATH.ufi_a2f_data_protocol_id[5]    	= `UFI_AGENT_5.a2f_data_protocol_id_5;
   assign   `TRANSACTORS_PATH.ufi_a2f_data_vc_id[5]    	      = `UFI_AGENT_5.a2f_data_vc_id_5;
   assign   `TRANSACTORS_PATH.ufi_a2f_data_header[5]         	= `UFI_AGENT_5.a2f_data_header_5; 
   assign   `TRANSACTORS_PATH.ufi_a2f_data_eop[5]            	= `UFI_AGENT_5.a2f_data_eop_5; 
   assign   `TRANSACTORS_PATH.ufi_a2f_data_payload[5]        	= `UFI_AGENT_5.a2f_data_payload_5; 
   
// F2A Request connections 
   assign   `TRANSACTORS_PATH.ufi_f2a_req_rxcrd[5]             	= `UFI_AGENT_5.f2a_req_rxcrd_5;             
   assign   `TRANSACTORS_PATH.ufi_f2a_req_rxcrd_protocol_id[5] 	= `UFI_AGENT_5.f2a_req_rxcrd_protocol_id_5;
   assign   `TRANSACTORS_PATH.ufi_f2a_req_rxcrd_vc_id[5]      	= `UFI_AGENT_5.f2a_req_rxcrd_vc_id_5;

// F2A Response connections 
   assign   `TRANSACTORS_PATH.ufi_f2a_rsp_rxcrd[5]             	= `UFI_AGENT_5.f2a_rsp_rxcrd_5;             
   assign   `TRANSACTORS_PATH.ufi_f2a_rsp_rxcrd_protocol_id[5] 	= `UFI_AGENT_5.f2a_rsp_rxcrd_protocol_id_5;
   assign   `TRANSACTORS_PATH.ufi_f2a_rsp_rxcrd_vc_id[5] 	      = `UFI_AGENT_5.f2a_rsp_rxcrd_vc_id_5;

// F2A Data connections 
   assign   `TRANSACTORS_PATH.ufi_f2a_data_rxcrd[5]             = `UFI_AGENT_5.f2a_data_rxcrd_5;             
   assign   `TRANSACTORS_PATH.ufi_f2a_data_rxcrd_protocol_id[5] = `UFI_AGENT_5.f2a_data_rxcrd_protocol_id_5;
   assign   `TRANSACTORS_PATH.ufi_f2a_data_rxcrd_vc_id[5]       = `UFI_AGENT_5.f2a_data_rxcrd_vc_id_5;
// A2F Global connections
   assign   `TRANSACTORS_PATH.ufi_a2f_txcon_req[5]    			= `UFI_AGENT_5.a2f_txcon_req_5; 
   
// F2A Global connections
   assign   `TRANSACTORS_PATH.ufi_f2a_rx_ack[5]            		= `UFI_AGENT_5.f2a_rx_ack_5; 
   assign   `TRANSACTORS_PATH.ufi_f2a_rx_empty[5]          		= `UFI_AGENT_5.f2a_rx_empty_5; 
   assign   `TRANSACTORS_PATH.ufi_f2a_rxdiscon_nack[5] 	    	= `UFI_AGENT_5.f2a_rxdiscon_nack_5;



//=================================================================================================================================
// UFI_FABRIC connections - USER MUST EDIT THE LEFT HAND SIDE OF THE FOLLOWING ASSIGNMENTS 
//=================================================================================================================================


// A2F Request connections
   assign   `UFI_AGENT_5.a2f_req_rxcrd_5              			= `TRANSACTORS_PATH.ufi_a2f_req_rxcrd[5]; 
   assign   `UFI_AGENT_5.a2f_req_rxcrd_protocol_id_5  			= `TRANSACTORS_PATH.ufi_a2f_req_rxcrd_protocol_id[5]; 
   assign   `UFI_AGENT_5.a2f_req_rxcrd_vc_id_5  		      	= `TRANSACTORS_PATH.ufi_a2f_req_rxcrd_vc_id[5];

// A2F Response connections
   assign   `UFI_AGENT_5.a2f_rsp_rxcrd_5              			= `TRANSACTORS_PATH.ufi_a2f_rsp_rxcrd[5]; 
   assign   `UFI_AGENT_5.a2f_rsp_rxcrd_protocol_id_5  			= `TRANSACTORS_PATH.ufi_a2f_rsp_rxcrd_protocol_id[5]; 
   assign   `UFI_AGENT_5.a2f_rsp_rxcrd_vc_id_5  			      = `TRANSACTORS_PATH.ufi_a2f_rsp_rxcrd_vc_id[5]; 

// A2F Data connections 
   assign   `UFI_AGENT_5.a2f_data_rxcrd_5             		 	= `TRANSACTORS_PATH.ufi_a2f_data_rxcrd[5]; 
   assign   `UFI_AGENT_5.a2f_data_rxcrd_protocol_id_5  			= `TRANSACTORS_PATH.ufi_a2f_data_rxcrd_protocol_id[5]; 
   assign   `UFI_AGENT_5.a2f_data_rxcrd_vc_id_5  		      	= `TRANSACTORS_PATH.ufi_a2f_data_rxcrd_vc_id[5];
// F2A Request connections 
   assign   `UFI_AGENT_5.f2a_req_is_valid_5       				= `TRANSACTORS_PATH.ufi_f2a_req_is_valid[5];
   assign   `UFI_AGENT_5.f2a_req_protocol_id_5    				= `TRANSACTORS_PATH.ufi_f2a_req_protocol_id[5];
   assign   `UFI_AGENT_5.f2a_req_vc_id_5    	      			= `TRANSACTORS_PATH.ufi_f2a_req_vc_id[5];
   assign   `UFI_AGENT_5.f2a_req_header_5         				= `TRANSACTORS_PATH.ufi_f2a_req_header[5]; 
   
// F2A Response connections 
   assign   `UFI_AGENT_5.f2a_rsp_is_valid_5       				= `TRANSACTORS_PATH.ufi_f2a_rsp_is_valid[5];
   assign   `UFI_AGENT_5.f2a_rsp_protocol_id_5    				= `TRANSACTORS_PATH.ufi_f2a_rsp_protocol_id[5];
   assign   `UFI_AGENT_5.f2a_rsp_vc_id_5    				      = `TRANSACTORS_PATH.ufi_f2a_rsp_vc_id[5];
   assign   `UFI_AGENT_5.f2a_rsp_header_5         				= `TRANSACTORS_PATH.ufi_f2a_rsp_header[5]; 
   
// F2A Data connections 
   assign   `UFI_AGENT_5.f2a_data_is_valid_5     				= `TRANSACTORS_PATH.ufi_f2a_data_is_valid[5]; 
   assign   `UFI_AGENT_5.f2a_data_protocol_id_5 				= `TRANSACTORS_PATH.ufi_f2a_data_protocol_id[5];
   assign   `UFI_AGENT_5.f2a_data_vc_id_5 	      			= `TRANSACTORS_PATH.ufi_f2a_data_vc_id[5];
   assign   `UFI_AGENT_5.f2a_data_header_5       				= `TRANSACTORS_PATH.ufi_f2a_data_header[5]; 
   assign   `UFI_AGENT_5.f2a_data_eop_5          				= `TRANSACTORS_PATH.ufi_f2a_data_eop[5]; 
   assign   `UFI_AGENT_5.f2a_data_payload_5      				= `TRANSACTORS_PATH.ufi_f2a_data_payload[5]; 

// A2F Global connections
   assign   `UFI_AGENT_5.a2f_rx_ack_5            				= `TRANSACTORS_PATH.ufi_a2f_rx_ack[5]; 
   assign   `UFI_AGENT_5.a2f_rx_empty_5          				= `TRANSACTORS_PATH.ufi_a2f_rx_empty[5]; 
   assign   `UFI_AGENT_5.a2f_rxdiscon_nack_5 			    	= `TRANSACTORS_PATH.ufi_a2f_rxdiscon_nack[5]; 
   
// F2A Global connections
   assign   `UFI_AGENT_5.f2a_txcon_req_5    					= `TRANSACTORS_PATH.ufi_f2a_txcon_req[5]; 

