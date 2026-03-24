//=================================================================================================================================
// UFI_FABRIC connections - USER MUST EDIT THE RIGHT HAND SIDE OF THE FOLLOWING ASSIGNMENTS AND DEFINE - WHEN NEEDED
//=================================================================================================================================
// UFI_FABRIC   connection #0
//vvvarma 4/26
   `define 	UFI_AGENT_1 					pc5_fpga_wrap_top.pi5//vvvarma fpga_transactors_top_inst   // example:  fpga_tcss_top.tcss_val_rtl.tcss.par_iom

  //Shrikant: 07/15/2021: following clock driven in fabric_0
  //Shrikant: 07/15/2021: assign `TRANSACTORS_PATH.ufi_fabric_clk[1] 	= pc5_fpga_wrap_top.pi5.ck_bclk1_clock_in; //`UFI_AGENT_1.ufi_agent_clock_1;
//  assign  	`TRANSACTORS_PATH.ufi_gnr1_clk 		= `UFI_AGENT_1.ufi_agent_clock_1;
   assign 	`TRANSACTORS_PATH.ufi_fabric_rstn[1] 				= pc5_fpga_wrap_top.reset_n; // `UFI_AGENT_1.ufi_agent_rst_n_1;
//assign   	`TRANSACTORS_PATH.ufi_gnr1_rstn             = `UFI_AGENT_1.ufi_agent_rst_n_1;  
      
// A2F Request connections
   assign   `TRANSACTORS_PATH.ufi_a2f_req_is_valid[1]          	= `UFI_AGENT_1.cxlcm_ufi_idi1_a2f_req_A2F_req_is_valid;    /*ufi_a2f_idi1_req_is_valid*/  
   assign   `TRANSACTORS_PATH.ufi_a2f_req_protocol_id[1]       	= 'b0; /*ufi_a2f_idi1_req_protocol_id*/
   assign   `TRANSACTORS_PATH.ufi_a2f_req_vc_id[1]            	= `UFI_AGENT_1.cxlcm_ufi_idi1_a2f_req_A2F_req_vc_id;
   assign   `TRANSACTORS_PATH.ufi_a2f_req_header[1]            	= {13'b0,`UFI_AGENT_1.cxlcm_ufi_idi1_a2f_req_A2F_req_header};      /*ufi_a2f_idi1_req_header*/
   
// A2F Response connections
   assign   `TRANSACTORS_PATH.ufi_a2f_rsp_is_valid[1]         	= 'b0;
   assign   `TRANSACTORS_PATH.ufi_a2f_rsp_protocol_id[1]      	= 'b0;
   assign   `TRANSACTORS_PATH.ufi_a2f_rsp_vc_id[1]            	= 'b0;
   assign   `TRANSACTORS_PATH.ufi_a2f_rsp_header[1]           	= 'b0; 
   
// A2F Data connections 
   assign   `TRANSACTORS_PATH.ufi_a2f_data_is_valid[1]       	= 'b0;
   assign   `TRANSACTORS_PATH.ufi_a2f_data_protocol_id[1]    	= 'b0;
   assign   `TRANSACTORS_PATH.ufi_a2f_data_vc_id[1]         	= 'b0;
   assign   `TRANSACTORS_PATH.ufi_a2f_data_header[1]         	= 'b0; 
   assign   `TRANSACTORS_PATH.ufi_a2f_data_eop[1]            	= 'b0;
   assign   `TRANSACTORS_PATH.ufi_a2f_data_payload[1]        	= 'b0;
                                                                 
// F2A Request connections 
   assign   `TRANSACTORS_PATH.ufi_f2a_req_rxcrd[1]             	= 'b0;            
   assign   `TRANSACTORS_PATH.ufi_f2a_req_rxcrd_protocol_id[1] 	= 'b0;
   assign   `TRANSACTORS_PATH.ufi_f2a_req_rxcrd_vc_id[1]      	= 'b0;

// F2A Response connections 
   assign   `TRANSACTORS_PATH.ufi_f2a_rsp_rxcrd[1]             	= `UFI_AGENT_1.cxlcm_ufi_idi1_f2a_rsp_F2A_rsp_rxcrd_valid;    /*ufi_f2a_idi1_rsp_rxcrd*/         
   assign   `TRANSACTORS_PATH.ufi_f2a_rsp_rxcrd_protocol_id[1] 	= 'b0; /*ufi_f2a_idi1_rsp_rxcrd_protocol_id*/
   assign   `TRANSACTORS_PATH.ufi_f2a_rsp_rxcrd_vc_id[1]      	= `UFI_AGENT_1.cxlcm_ufi_idi1_f2a_rsp_F2A_rsp_rxcrd_vc_id;

// F2A Data connections 
   assign   `TRANSACTORS_PATH.ufi_f2a_data_rxcrd[1]             = 'b0;             
   assign   `TRANSACTORS_PATH.ufi_f2a_data_rxcrd_protocol_id[1] = 'b0;
   assign   `TRANSACTORS_PATH.ufi_f2a_data_rxcrd_vc_id[1]      	= 'b0;

// A2F Global connections
   assign   `TRANSACTORS_PATH.ufi_a2f_txcon_req[1]    			  = 'b1; 
                                                              
// F2A Global connections                                   
   assign   `TRANSACTORS_PATH.ufi_f2a_rx_ack[1]            		= 'b1;
   assign   `TRANSACTORS_PATH.ufi_f2a_rx_empty[1]          		= 'b0;
   assign   `TRANSACTORS_PATH.ufi_f2a_rxcon_nack_req[1] 		= 'b0;



//=================================================================================================================================
// UFI_FABRIC connections - USER MUST EDIT THE LEFT HAND SIDE OF THE FOLLOWING ASSIGNMENTS 
//=================================================================================================================================


// A2F Request connections
   assign   `UFI_AGENT_1.cxlcm_ufi_idi1_a2f_req_A2F_req_rxcrd_valid /*ufi_a2f_idi1_req_rxcrd*/	  = `TRANSACTORS_PATH.ufi_a2f_req_rxcrd[1]; 
//   assign   `UFI_AGENT_1.a2f_req_rxcrd_protocol_id_1/*ufi_a2f_idi1_req_rxcrd_protocol_id*/ = `TRANSACTORS_PATH.ufi_a2f_req_rxcrd_protocol_id[1];
   assign   `UFI_AGENT_1.cxlcm_ufi_idi1_a2f_req_A2F_req_rxcrd_vc_id       = `TRANSACTORS_PATH.ufi_a2f_req_rxcrd_vc_id[1];
   assign   `UFI_AGENT_1.cxlcm_ufi_idi1_a2f_req_A2F_req_rxcrd_shared      = 'b0;
// A2F Response connections
//   assign   `UFI_AGENT_1.a2f_rsp_rxcrd_1              			= 'b0;
//   assign   `UFI_AGENT_1.a2f_rsp_rxcrd_protocol_id_1  			= 'b0;
   
// A2F Data connections 
//   assign   `UFI_AGENT_1.a2f_data_rxcrd_1             		 	= 'b0;
//   assign   `UFI_AGENT_1.a2f_data_rxcrd_protocol_id_1  			= 'b0; 
   
// F2A Request connections 
//   assign   `UFI_AGENT_1.f2a_req_is_valid_1       				= 'b0; 
//   assign   `UFI_AGENT_1.f2a_req_protocol_id_1    				= 'b0;  
//   assign   `UFI_AGENT_1.f2a_req_header_1         				= 'b0; 
   
// F2A Response connections 
   assign   `UFI_AGENT_1.cxlcm_ufi_idi1_f2a_rsp_F2A_rsp_is_valid /*ufi_f2a_idi1_rsp_is_valid*/ = `TRANSACTORS_PATH.ufi_f2a_rsp_is_valid[1];
//   assign   `UFI_AGENT_1.f2a_rsp_protocol_id_1 /*ufi_f2a_idi1_rsp_protocol_id_1*/    	= `TRANSACTORS_PATH.ufi_f2a_rsp_protocol_id[1];
   assign   `UFI_AGENT_1.cxlcm_ufi_idi1_f2a_rsp_F2A_rsp_vc_id    		      		= `TRANSACTORS_PATH.ufi_f2a_rsp_vc_id[1];
   assign   `UFI_AGENT_1.cxlcm_ufi_idi1_f2a_rsp_F2A_rsp_header /*ufi_f2a_f2a_idi1_rsp_header*/  = `TRANSACTORS_PATH.ufi_f2a_rsp_header[1]; 
   assign   `UFI_AGENT_1.cxlcm_ufi_idi1_f2a_rsp_F2A_rsp_shared_credit             = 'b0;
   
// F2A Data connections 
//   assign   `UFI_AGENT_1.f2a_data_is_valid_1     				 = 'b0;
//   assign   `UFI_AGENT_1.f2a_data_protocol_id_1 				 = 'b0;
//   assign   `UFI_AGENT_1.f2a_data_header_1       				 = 'b0;
//   assign   `UFI_AGENT_1.f2a_data_eop_1          				 = 'b0;
//   assign   `UFI_AGENT_1.f2a_data_payload_1      				 = 'b0;
                                                        
// A2F Global connections
//   assign   `UFI_AGENT_1.a2f_rx_ack_1            				 = 'b1;
//   assign   `UFI_AGENT_1.a2f_rx_empty_1          				 = 'b0;
//   assign   `UFI_AGENT_1.a2f_rxcon_nack_req_1 	    		 = 'b0; 
   
// F2A Global connections
//   assign   `UFI_AGENT_1.f2a_txcon_req_1    				   	= 'b1; 

