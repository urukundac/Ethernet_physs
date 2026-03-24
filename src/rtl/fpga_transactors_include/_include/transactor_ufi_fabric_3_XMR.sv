//=================================================================================================================================
// UFI_FABRIC connections - USER MUST EDIT THE RIGHT HAND SIDE OF THE FOLLOWING ASSIGNMENTS AND DEFINE - WHEN NEEDED
//=================================================================================================================================
// UFI_FABRIC   connection #0

			`define 	UFI_AGENT_3 					fpga_transactors_top_inst       // example:  fpga_tcss_top.tcss_val_rtl.tcss.par_iom

assign 		`TRANSACTORS_PATH.ufi_fabric_clk[3] 				= `UFI_AGENT_3.ufi_agent_clock_3; 
assign 		`TRANSACTORS_PATH.ufi_fabric_rstn[3] 				= `UFI_AGENT_3.ufi_agent_rst_n_3; 
      
// A2F Request connections
   assign   `TRANSACTORS_PATH.ufi_a2f_req_is_valid[3]          	= `UFI_AGENT_3.a2f_req_is_valid_3;
   assign   `TRANSACTORS_PATH.ufi_a2f_req_protocol_id[3]       	= `UFI_AGENT_3.a2f_req_protocol_id_3;
   assign   `TRANSACTORS_PATH.ufi_a2f_req_vc_id[3]            	= `UFI_AGENT_3.a2f_req_vc_id_3;
   assign   `TRANSACTORS_PATH.ufi_a2f_req_header[3]            	= `UFI_AGENT_3.a2f_req_header_3; 
   
// A2F Response connections
   assign   `TRANSACTORS_PATH.ufi_a2f_rsp_is_valid[3]         	= `UFI_AGENT_3.a2f_rsp_is_valid_3;
   assign   `TRANSACTORS_PATH.ufi_a2f_rsp_protocol_id[3]      	= `UFI_AGENT_3.a2f_rsp_protocol_id_3;
   assign   `TRANSACTORS_PATH.ufi_a2f_rsp_vc_id[3]            	= `UFI_AGENT_3.a2f_rsp_vc_id_3;
   assign   `TRANSACTORS_PATH.ufi_a2f_rsp_header[3]           	= `UFI_AGENT_3.a2f_rsp_header_3; 
   
// A2F Data connections 
   assign   `TRANSACTORS_PATH.ufi_a2f_data_is_valid[3]       	= `UFI_AGENT_3.a2f_data_is_valid_3; 
   assign   `TRANSACTORS_PATH.ufi_a2f_data_protocol_id[3]    	= `UFI_AGENT_3.a2f_data_protocol_id_3;
   assign   `TRANSACTORS_PATH.ufi_a2f_data_vc_id[3]         	= `UFI_AGENT_3.a2f_data_vc_id_3;
   assign   `TRANSACTORS_PATH.ufi_a2f_data_header[3]         	= `UFI_AGENT_3.a2f_data_header_3; 
   assign   `TRANSACTORS_PATH.ufi_a2f_data_eop[3]            	= `UFI_AGENT_3.a2f_data_eop_3; 
   assign   `TRANSACTORS_PATH.ufi_a2f_data_payload[3]        	= `UFI_AGENT_3.a2f_data_payload_3; 
   
// F2A Request connections 
   assign   `TRANSACTORS_PATH.ufi_f2a_req_rxcrd[3]             	= `UFI_AGENT_3.f2a_req_rxcrd_3;             
   assign   `TRANSACTORS_PATH.ufi_f2a_req_rxcrd_protocol_id[3] 	= `UFI_AGENT_3.f2a_req_rxcrd_protocol_id_3;
   assign   `TRANSACTORS_PATH.ufi_f2a_req_rxcrd_vc_id[3] 	      = `UFI_AGENT_3.f2a_req_rxcrd_vc_id_3;
// F2A Response connections 
   assign   `TRANSACTORS_PATH.ufi_f2a_rsp_rxcrd[3]             	= `UFI_AGENT_3.f2a_rsp_rxcrd_3;             
   assign   `TRANSACTORS_PATH.ufi_f2a_rsp_rxcrd_protocol_id[3] 	= `UFI_AGENT_3.f2a_rsp_rxcrd_protocol_id_3;
   assign   `TRANSACTORS_PATH.ufi_f2a_rsp_rxcrd_vc_id[3]      	= `UFI_AGENT_3.f2a_rsp_rxcrd_vc_id_3;
   
// F2A Data connections 
   assign   `TRANSACTORS_PATH.ufi_f2a_data_rxcrd[3]             = `UFI_AGENT_3.f2a_data_rxcrd_3;             
   assign   `TRANSACTORS_PATH.ufi_f2a_data_rxcrd_protocol_id[3] = `UFI_AGENT_3.f2a_data_rxcrd_protocol_id_3;
   assign   `TRANSACTORS_PATH.ufi_f2a_data_rxcrd_vc_id[3]       = `UFI_AGENT_3.f2a_data_rxcrd_vc_id_3;


// A2F Global connections
   assign   `TRANSACTORS_PATH.ufi_a2f_txcon_req[3]    			= `UFI_AGENT_3.a2f_txcon_req_3; 
   
// F2A Global connections
   assign   `TRANSACTORS_PATH.ufi_f2a_rx_ack[3]            		= `UFI_AGENT_3.f2a_rx_ack_3; 
   assign   `TRANSACTORS_PATH.ufi_f2a_rx_empty[3]          		= `UFI_AGENT_3.f2a_rx_empty_3; 
   assign   `TRANSACTORS_PATH.ufi_f2a_rxdiscon_nack[3] 		    = `UFI_AGENT_3.f2a_rxdiscon_nack_3;



//=================================================================================================================================
// UFI_FABRIC connections - USER MUST EDIT THE LEFT HAND SIDE OF THE FOLLOWING ASSIGNMENTS 
//=================================================================================================================================


// A2F Request connections
   assign   `UFI_AGENT_3.a2f_req_rxcrd_3              			= `TRANSACTORS_PATH.ufi_a2f_req_rxcrd[3]; 
   assign   `UFI_AGENT_3.a2f_req_rxcrd_protocol_id_3  			= `TRANSACTORS_PATH.ufi_a2f_req_rxcrd_protocol_id[3]; 
   assign   `UFI_AGENT_3.a2f_req_rxcrd_vc_id_3  		       	= `TRANSACTORS_PATH.ufi_a2f_req_rxcrd_vc_id[3];

// A2F Response connections
   assign   `UFI_AGENT_3.a2f_rsp_rxcrd_3              			= `TRANSACTORS_PATH.ufi_a2f_rsp_rxcrd[3]; 
   assign   `UFI_AGENT_3.a2f_rsp_rxcrd_protocol_id_3  			= `TRANSACTORS_PATH.ufi_a2f_rsp_rxcrd_protocol_id[3]; 
   assign   `UFI_AGENT_3.a2f_rsp_rxcrd_vc_id_3  	       		= `TRANSACTORS_PATH.ufi_a2f_rsp_rxcrd_vc_id[3];

// A2F Data connections 
   assign   `UFI_AGENT_3.a2f_data_rxcrd_3             		 	= `TRANSACTORS_PATH.ufi_a2f_data_rxcrd[3]; 
   assign   `UFI_AGENT_3.a2f_data_rxcrd_protocol_id_3  			= `TRANSACTORS_PATH.ufi_a2f_data_rxcrd_protocol_id[3]; 
   assign   `UFI_AGENT_3.a2f_data_rxcrd_vc_id_3  	      		= `TRANSACTORS_PATH.ufi_a2f_data_rxcrd_vc_id[3];

// F2A Request connections 
   assign   `UFI_AGENT_3.f2a_req_is_valid_3       				= `TRANSACTORS_PATH.ufi_f2a_req_is_valid[3];
   assign   `UFI_AGENT_3.f2a_req_protocol_id_3    				= `TRANSACTORS_PATH.ufi_f2a_req_protocol_id[3];
   assign   `UFI_AGENT_3.f2a_req_vc_id_3    			      	= `TRANSACTORS_PATH.ufi_f2a_req_vc_id[3];
   assign   `UFI_AGENT_3.f2a_req_header_3         				= `TRANSACTORS_PATH.ufi_f2a_req_header[3]; 
   
// F2A Response connections 
   assign   `UFI_AGENT_3.f2a_rsp_is_valid_3       				= `TRANSACTORS_PATH.ufi_f2a_rsp_is_valid[3];
   assign   `UFI_AGENT_3.f2a_rsp_protocol_id_3    				= `TRANSACTORS_PATH.ufi_f2a_rsp_protocol_id[3];
   assign   `UFI_AGENT_3.f2a_rsp_vc_id_3    				      = `TRANSACTORS_PATH.ufi_f2a_rsp_vc_id[3];
   assign   `UFI_AGENT_3.f2a_rsp_header_3         				= `TRANSACTORS_PATH.ufi_f2a_rsp_header[3]; 
   
// F2A Data connections 
   assign   `UFI_AGENT_3.f2a_data_is_valid_3     				= `TRANSACTORS_PATH.ufi_f2a_data_is_valid[3]; 
   assign   `UFI_AGENT_3.f2a_data_protocol_id_3 				= `TRANSACTORS_PATH.ufi_f2a_data_protocol_id[3];
   assign   `UFI_AGENT_3.f2a_data_vc_id_3 		       		= `TRANSACTORS_PATH.ufi_f2a_data_vc_id[3];
   assign   `UFI_AGENT_3.f2a_data_header_3       				= `TRANSACTORS_PATH.ufi_f2a_data_header[3]; 
   assign   `UFI_AGENT_3.f2a_data_eop_3          				= `TRANSACTORS_PATH.ufi_f2a_data_eop[3]; 
   assign   `UFI_AGENT_3.f2a_data_payload_3      				= `TRANSACTORS_PATH.ufi_f2a_data_payload[3]; 

// A2F Global connections
   assign   `UFI_AGENT_3.a2f_rx_ack_3            				= `TRANSACTORS_PATH.ufi_a2f_rx_ack[3]; 
   assign   `UFI_AGENT_3.a2f_rx_empty_3          				= `TRANSACTORS_PATH.ufi_a2f_rx_empty[3]; 
   assign   `UFI_AGENT_3.a2f_rxdiscon_nack_3 		    		= `TRANSACTORS_PATH.ufi_a2f_rxdiscon_nack[3]; 
   
// F2A Global connections
   assign   `UFI_AGENT_3.f2a_txcon_req_3    					= `TRANSACTORS_PATH.ufi_f2a_txcon_req[3]; 

