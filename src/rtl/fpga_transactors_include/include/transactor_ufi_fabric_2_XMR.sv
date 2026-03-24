//=================================================================================================================================
// UFI_FABRIC connections - USER MUST EDIT THE RIGHT HAND SIDE OF THE FOLLOWING ASSIGNMENTS AND DEFINE - WHEN NEEDED
//=================================================================================================================================
// UFI_FABRIC   connection #0

			`define 	UFI_AGENT_2 					`FPGA_TRANSACTORS_TOP       // example:  fpga_tcss_top.tcss_val_rtl.tcss.par_iom

assign 		`TRANSACTORS_PATH.ufi_fabric_clk[2] 				= `UFI_AGENT_2.ufi_agent_clock_2; 
assign 		`TRANSACTORS_PATH.ufi_fabric_rstn[2] 				= `UFI_AGENT_2.ufi_agent_rst_n_2; 
      
// A2F Request connections
   assign   `TRANSACTORS_PATH.ufi_a2f_req_is_valid[2]          	= `UFI_AGENT_2.a2f_req_is_valid_2;
   assign   `TRANSACTORS_PATH.ufi_a2f_req_protocol_id[2]       	= `UFI_AGENT_2.a2f_req_protocol_id_2;
   assign   `TRANSACTORS_PATH.ufi_a2f_req_vc_id[2]            	= `UFI_AGENT_2.a2f_req_vc_id_2;
   assign   `TRANSACTORS_PATH.ufi_a2f_req_header[2]            	= `UFI_AGENT_2.a2f_req_header_2; 
   
// A2F Response connections
   assign   `TRANSACTORS_PATH.ufi_a2f_rsp_is_valid[2]         	= `UFI_AGENT_2.a2f_rsp_is_valid_2;
   assign   `TRANSACTORS_PATH.ufi_a2f_rsp_protocol_id[2]      	= `UFI_AGENT_2.a2f_rsp_protocol_id_2;
   assign   `TRANSACTORS_PATH.ufi_a2f_rsp_vc_id[2]             	= `UFI_AGENT_2.a2f_rsp_vc_id_2;
   assign   `TRANSACTORS_PATH.ufi_a2f_rsp_header[2]           	= `UFI_AGENT_2.a2f_rsp_header_2; 
   
// A2F Data connections 
   assign   `TRANSACTORS_PATH.ufi_a2f_data_is_valid[2]       	= `UFI_AGENT_2.a2f_data_is_valid_2; 
   assign   `TRANSACTORS_PATH.ufi_a2f_data_protocol_id[2]    	= `UFI_AGENT_2.a2f_data_protocol_id_2;
   assign   `TRANSACTORS_PATH.ufi_a2f_data_vc_id[2]         	= `UFI_AGENT_2.a2f_data_vc_id_2;
   assign   `TRANSACTORS_PATH.ufi_a2f_data_header[2]         	= `UFI_AGENT_2.a2f_data_header_2; 
   assign   `TRANSACTORS_PATH.ufi_a2f_data_eop[2]            	= `UFI_AGENT_2.a2f_data_eop_2; 
   assign   `TRANSACTORS_PATH.ufi_a2f_data_payload[2]        	= `UFI_AGENT_2.a2f_data_payload_2; 
   
// F2A Request connections 
   assign   `TRANSACTORS_PATH.ufi_f2a_req_rxcrd[2]             	= `UFI_AGENT_2.f2a_req_rxcrd_2;             
   assign   `TRANSACTORS_PATH.ufi_f2a_req_rxcrd_protocol_id[2] 	= `UFI_AGENT_2.f2a_req_rxcrd_protocol_id_2;
   assign   `TRANSACTORS_PATH.ufi_f2a_req_rxcrd_vc_id[2]      	= `UFI_AGENT_2.f2a_req_rxcrd_vc_id_2;

   
// F2A Response connections 
   assign   `TRANSACTORS_PATH.ufi_f2a_rsp_rxcrd[2]             	= `UFI_AGENT_2.f2a_rsp_rxcrd_2;             
   assign   `TRANSACTORS_PATH.ufi_f2a_rsp_rxcrd_protocol_id[2] 	= `UFI_AGENT_2.f2a_rsp_rxcrd_protocol_id_2;
   assign   `TRANSACTORS_PATH.ufi_f2a_rsp_rxcrd_vc_id[2]      	= `UFI_AGENT_2.f2a_rsp_rxcrd_vc_id_2;
   
// F2A Data connections 
   assign   `TRANSACTORS_PATH.ufi_f2a_data_rxcrd[2]             = `UFI_AGENT_2.f2a_data_rxcrd_2;             
   assign   `TRANSACTORS_PATH.ufi_f2a_data_rxcrd_protocol_id[2] = `UFI_AGENT_2.f2a_data_rxcrd_protocol_id_2;
   assign   `TRANSACTORS_PATH.ufi_f2a_data_rxcrd_vc_id[2]       = `UFI_AGENT_2.f2a_data_rxcrd_vc_id_2;

// A2F Global connections
   assign   `TRANSACTORS_PATH.ufi_a2f_txcon_req[2]    			= `UFI_AGENT_2.a2f_txcon_req_2; 
   
// F2A Global connections
   assign   `TRANSACTORS_PATH.ufi_f2a_rx_ack[2]            		= `UFI_AGENT_2.f2a_rx_ack_2; 
   assign   `TRANSACTORS_PATH.ufi_f2a_rx_empty[2]          		= `UFI_AGENT_2.f2a_rx_empty_2; 
   assign   `TRANSACTORS_PATH.ufi_f2a_rxdiscon_nack[2] 	    	= `UFI_AGENT_2.f2a_rxdiscon_nack_2;



//=================================================================================================================================
// UFI_FABRIC connections - USER MUST EDIT THE LEFT HAND SIDE OF THE FOLLOWING ASSIGNMENTS 
//=================================================================================================================================


// A2F Request connections
   assign   `UFI_AGENT_2.a2f_req_rxcrd_2              			= `TRANSACTORS_PATH.ufi_a2f_req_rxcrd[2]; 
   assign   `UFI_AGENT_2.a2f_req_rxcrd_protocol_id_2  			= `TRANSACTORS_PATH.ufi_a2f_req_rxcrd_protocol_id[2]; 
   assign   `UFI_AGENT_2.a2f_req_rxcrd_vc_id_2  		      	= `TRANSACTORS_PATH.ufi_a2f_req_rxcrd_vc_id[2];

// A2F Response connections
   assign   `UFI_AGENT_2.a2f_rsp_rxcrd_2              			= `TRANSACTORS_PATH.ufi_a2f_rsp_rxcrd[2]; 
   assign   `UFI_AGENT_2.a2f_rsp_rxcrd_protocol_id_2  			= `TRANSACTORS_PATH.ufi_a2f_rsp_rxcrd_protocol_id[2]; 
   assign   `UFI_AGENT_2.a2f_rsp_rxcrd_vc_id_2  	      		= `TRANSACTORS_PATH.ufi_a2f_rsp_rxcrd_vc_id[2];

// A2F Data connections 
   assign   `UFI_AGENT_2.a2f_data_rxcrd_2             		 	= `TRANSACTORS_PATH.ufi_a2f_data_rxcrd[2]; 
   assign   `UFI_AGENT_2.a2f_data_rxcrd_protocol_id_2  			= `TRANSACTORS_PATH.ufi_a2f_data_rxcrd_protocol_id[2];
   assign   `UFI_AGENT_2.a2f_data_rxcrd_vc_id_2  	      		= `TRANSACTORS_PATH.ufi_a2f_data_rxcrd_vc_id[2]; 
   
// F2A Request connections 
   assign   `UFI_AGENT_2.f2a_req_is_valid_2       				= `TRANSACTORS_PATH.ufi_f2a_req_is_valid[2];
   assign   `UFI_AGENT_2.f2a_req_protocol_id_2    				= `TRANSACTORS_PATH.ufi_f2a_req_protocol_id[2];
   assign   `UFI_AGENT_2.f2a_req_vc_id_2    		      		= `TRANSACTORS_PATH.ufi_f2a_req_vc_id[2];
   assign   `UFI_AGENT_2.f2a_req_header_2         				= `TRANSACTORS_PATH.ufi_f2a_req_header[2]; 
   
// F2A Response connections 
   assign   `UFI_AGENT_2.f2a_rsp_is_valid_2       				= `TRANSACTORS_PATH.ufi_f2a_rsp_is_valid[2];
   assign   `UFI_AGENT_2.f2a_rsp_protocol_id_2    				= `TRANSACTORS_PATH.ufi_f2a_rsp_protocol_id[2];
   assign   `UFI_AGENT_2.f2a_rsp_vc_id_2    		      		= `TRANSACTORS_PATH.ufi_f2a_rsp_vc_id[2];
   assign   `UFI_AGENT_2.f2a_rsp_header_2         				= `TRANSACTORS_PATH.ufi_f2a_rsp_header[2]; 
   
// F2A Data connections 
   assign   `UFI_AGENT_2.f2a_data_is_valid_2     				= `TRANSACTORS_PATH.ufi_f2a_data_is_valid[2]; 
   assign   `UFI_AGENT_2.f2a_data_protocol_id_2 				= `TRANSACTORS_PATH.ufi_f2a_data_protocol_id[2];
   assign   `UFI_AGENT_2.f2a_data_vc_id_2 			      	= `TRANSACTORS_PATH.ufi_f2a_data_vc_id[2];
   assign   `UFI_AGENT_2.f2a_data_header_2       				= `TRANSACTORS_PATH.ufi_f2a_data_header[2]; 
   assign   `UFI_AGENT_2.f2a_data_eop_2          				= `TRANSACTORS_PATH.ufi_f2a_data_eop[2]; 
   assign   `UFI_AGENT_2.f2a_data_payload_2      				= `TRANSACTORS_PATH.ufi_f2a_data_payload[2]; 

// A2F Global connections
   assign   `UFI_AGENT_2.a2f_rx_ack_2            				= `TRANSACTORS_PATH.ufi_a2f_rx_ack[2]; 
   assign   `UFI_AGENT_2.a2f_rx_empty_2          				= `TRANSACTORS_PATH.ufi_a2f_rx_empty[2]; 
   assign   `UFI_AGENT_2.a2f_rxdiscon_nack_2 		    		= `TRANSACTORS_PATH.ufi_a2f_rxdiscon_nack[2]; 
   
// F2A Global connections
   assign   `UFI_AGENT_2.f2a_txcon_req_2    					= `TRANSACTORS_PATH.ufi_f2a_txcon_req[2]; 

