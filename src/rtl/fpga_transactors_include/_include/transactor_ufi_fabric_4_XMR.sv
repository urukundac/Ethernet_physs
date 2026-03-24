//=================================================================================================================================
// UFI_FABRIC connections - USER MUST EDIT THE RIGHT HAND SIDE OF THE FOLLOWING ASSIGNMENTS AND DEFINE - WHEN NEEDED
//=================================================================================================================================
// UFI_FABRIC   connection #0

			`define 	UFI_AGENT_4 					fpga_transactors_top_inst       // example:  fpga_tcss_top.tcss_val_rtl.tcss.par_iom

assign 		`TRANSACTORS_PATH.ufi_fabric_clk[4] 				= `UFI_AGENT_4.ufi_agent_clock_4; 
assign 		`TRANSACTORS_PATH.ufi_fabric_rstn[4] 				= `UFI_AGENT_4.ufi_agent_rst_n_4; 
      
// A2F Request connections
   assign   `TRANSACTORS_PATH.ufi_a2f_req_is_valid[4]          	= `UFI_AGENT_4.a2f_req_is_valid_4;
   assign   `TRANSACTORS_PATH.ufi_a2f_req_protocol_id[4]       	= `UFI_AGENT_4.a2f_req_protocol_id_4;
   assign   `TRANSACTORS_PATH.ufi_a2f_req_vc_id[4]            	= `UFI_AGENT_4.a2f_req_vc_id_4;
   assign   `TRANSACTORS_PATH.ufi_a2f_req_header[4]            	= `UFI_AGENT_4.a2f_req_header_4; 
   
// A2F Response connections
   assign   `TRANSACTORS_PATH.ufi_a2f_rsp_is_valid[4]         	= `UFI_AGENT_4.a2f_rsp_is_valid_4;
   assign   `TRANSACTORS_PATH.ufi_a2f_rsp_protocol_id[4]      	= `UFI_AGENT_4.a2f_rsp_protocol_id_4;
   assign   `TRANSACTORS_PATH.ufi_a2f_rsp_vc_id[4]            	= `UFI_AGENT_4.a2f_rsp_vc_id_4;
   assign   `TRANSACTORS_PATH.ufi_a2f_rsp_header[4]           	= `UFI_AGENT_4.a2f_rsp_header_4; 
   
// A2F Data connections 
   assign   `TRANSACTORS_PATH.ufi_a2f_data_is_valid[4]       	= `UFI_AGENT_4.a2f_data_is_valid_4; 
   assign   `TRANSACTORS_PATH.ufi_a2f_data_protocol_id[4]    	= `UFI_AGENT_4.a2f_data_protocol_id_4;
   assign   `TRANSACTORS_PATH.ufi_a2f_data_vc_id[4]         	= `UFI_AGENT_4.a2f_data_vc_id_4;
   assign   `TRANSACTORS_PATH.ufi_a2f_data_header[4]         	= `UFI_AGENT_4.a2f_data_header_4; 
   assign   `TRANSACTORS_PATH.ufi_a2f_data_eop[4]            	= `UFI_AGENT_4.a2f_data_eop_4; 
   assign   `TRANSACTORS_PATH.ufi_a2f_data_payload[4]        	= `UFI_AGENT_4.a2f_data_payload_4; 
   
// F2A Request connections 
   assign   `TRANSACTORS_PATH.ufi_f2a_req_rxcrd[4]             	= `UFI_AGENT_4.f2a_req_rxcrd_4;             
   assign   `TRANSACTORS_PATH.ufi_f2a_req_rxcrd_protocol_id[4] 	= `UFI_AGENT_4.f2a_req_rxcrd_protocol_id_4;
   assign   `TRANSACTORS_PATH.ufi_f2a_req_rxcrd_vc_id[4]       	= `UFI_AGENT_4.f2a_req_rxcrd_vc_id_4;

// F2A Response connections 
   assign   `TRANSACTORS_PATH.ufi_f2a_rsp_rxcrd[4]             	= `UFI_AGENT_4.f2a_rsp_rxcrd_4;             
   assign   `TRANSACTORS_PATH.ufi_f2a_rsp_rxcrd_protocol_id[4] 	= `UFI_AGENT_4.f2a_rsp_rxcrd_protocol_id_4;
   assign   `TRANSACTORS_PATH.ufi_f2a_rsp_rxcrd_vc_id[4]      	= `UFI_AGENT_4.f2a_rsp_rxcrd_vc_id_4;

// F2A Data connections 
   assign   `TRANSACTORS_PATH.ufi_f2a_data_rxcrd[4]             = `UFI_AGENT_4.f2a_data_rxcrd_4;             
   assign   `TRANSACTORS_PATH.ufi_f2a_data_rxcrd_protocol_id[4] = `UFI_AGENT_4.f2a_data_rxcrd_protocol_id_4;
   assign   `TRANSACTORS_PATH.ufi_f2a_data_rxcrd_vc_id[4]       = `UFI_AGENT_4.f2a_data_rxcrd_vc_id_4;

// A2F Global connections
   assign   `TRANSACTORS_PATH.ufi_a2f_txcon_req[4]    			= `UFI_AGENT_4.a2f_txcon_req_4; 
   
// F2A Global connections
   assign   `TRANSACTORS_PATH.ufi_f2a_rx_ack[4]            		= `UFI_AGENT_4.f2a_rx_ack_4; 
   assign   `TRANSACTORS_PATH.ufi_f2a_rx_empty[4]          		= `UFI_AGENT_4.f2a_rx_empty_4; 
   assign   `TRANSACTORS_PATH.ufi_f2a_rxdiscon_nack[4] 	    	= `UFI_AGENT_4.f2a_rxdiscon_nack_4;



//=================================================================================================================================
// UFI_FABRIC connections - USER MUST EDIT THE LEFT HAND SIDE OF THE FOLLOWING ASSIGNMENTS 
//=================================================================================================================================


// A2F Request connections
   assign   `UFI_AGENT_4.a2f_req_rxcrd_4              			= `TRANSACTORS_PATH.ufi_a2f_req_rxcrd[4]; 
   assign   `UFI_AGENT_4.a2f_req_rxcrd_protocol_id_4  			= `TRANSACTORS_PATH.ufi_a2f_req_rxcrd_protocol_id[4]; 
   assign   `UFI_AGENT_4.a2f_req_rxcrd_vc_id_4        			= `TRANSACTORS_PATH.ufi_a2f_req_rxcrd_vc_id[4]; 
   
// A2F Response connections
   assign   `UFI_AGENT_4.a2f_rsp_rxcrd_4              			= `TRANSACTORS_PATH.ufi_a2f_rsp_rxcrd[4]; 
   assign   `UFI_AGENT_4.a2f_rsp_rxcrd_protocol_id_4  			= `TRANSACTORS_PATH.ufi_a2f_rsp_rxcrd_protocol_id[4]; 
   assign   `UFI_AGENT_4.a2f_rsp_rxcrd_vc_id_4        			= `TRANSACTORS_PATH.ufi_a2f_rsp_rxcrd_vc_id[4];
// A2F Data connections 
   assign   `UFI_AGENT_4.a2f_data_rxcrd_4             		 	= `TRANSACTORS_PATH.ufi_a2f_data_rxcrd[4]; 
   assign   `UFI_AGENT_4.a2f_data_rxcrd_protocol_id_4  			= `TRANSACTORS_PATH.ufi_a2f_data_rxcrd_protocol_id[4]; 
   assign   `UFI_AGENT_4.a2f_data_rxcrd_vc_id_4  		       	= `TRANSACTORS_PATH.ufi_a2f_data_rxcrd_vc_id[4]; 
// F2A Request connections 
   assign   `UFI_AGENT_4.f2a_req_is_valid_4       				= `TRANSACTORS_PATH.ufi_f2a_req_is_valid[4];
   assign   `UFI_AGENT_4.f2a_req_protocol_id_4    				= `TRANSACTORS_PATH.ufi_f2a_req_protocol_id[4];
   assign   `UFI_AGENT_4.f2a_req_vc_id_4    		      		= `TRANSACTORS_PATH.ufi_f2a_req_vc_id[4];
   assign   `UFI_AGENT_4.f2a_req_header_4         				= `TRANSACTORS_PATH.ufi_f2a_req_header[4]; 
   
// F2A Response connections 
   assign   `UFI_AGENT_4.f2a_rsp_is_valid_4       				= `TRANSACTORS_PATH.ufi_f2a_rsp_is_valid[4];
   assign   `UFI_AGENT_4.f2a_rsp_protocol_id_4    				= `TRANSACTORS_PATH.ufi_f2a_rsp_protocol_id[4];
   assign   `UFI_AGENT_4.f2a_rsp_vc_id_4          				= `TRANSACTORS_PATH.ufi_f2a_rsp_vc_id[4];
   assign   `UFI_AGENT_4.f2a_rsp_header_4         				= `TRANSACTORS_PATH.ufi_f2a_rsp_header[4]; 
   
// F2A Data connections 
   assign   `UFI_AGENT_4.f2a_data_is_valid_4     				= `TRANSACTORS_PATH.ufi_f2a_data_is_valid[4]; 
   assign   `UFI_AGENT_4.f2a_data_protocol_id_4 				= `TRANSACTORS_PATH.ufi_f2a_data_protocol_id[4];
   assign   `UFI_AGENT_4.f2a_data_vc_id_4 			      	= `TRANSACTORS_PATH.ufi_f2a_data_vc_id[4];
   assign   `UFI_AGENT_4.f2a_data_header_4       				= `TRANSACTORS_PATH.ufi_f2a_data_header[4]; 
   assign   `UFI_AGENT_4.f2a_data_eop_4          				= `TRANSACTORS_PATH.ufi_f2a_data_eop[4]; 
   assign   `UFI_AGENT_4.f2a_data_payload_4      				= `TRANSACTORS_PATH.ufi_f2a_data_payload[4]; 

// A2F Global connections
   assign   `UFI_AGENT_4.a2f_rx_ack_4            				= `TRANSACTORS_PATH.ufi_a2f_rx_ack[4]; 
   assign   `UFI_AGENT_4.a2f_rx_empty_4          				= `TRANSACTORS_PATH.ufi_a2f_rx_empty[4]; 
   assign   `UFI_AGENT_4.a2f_rxdiscon_nack_4 		    		= `TRANSACTORS_PATH.ufi_a2f_rxdiscon_nack[4]; 
   
// F2A Global connections
   assign   `UFI_AGENT_4.f2a_txcon_req_4    					= `TRANSACTORS_PATH.ufi_f2a_txcon_req[4]; 

