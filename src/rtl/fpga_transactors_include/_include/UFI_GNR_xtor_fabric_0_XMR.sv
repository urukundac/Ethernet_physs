//=================================================================================================================================
// UFI_FABRIC connections - USER MUST EDIT THE RIGHT HAND SIDE OF THE FOLLOWING ASSIGNMENTS AND DEFINE - WHEN NEEDED
//=================================================================================================================================
// This file include connections 2 transactors as defined in GNR UFI design

// connection of transactor #0
// This transactor is includes 2 sub-protocols : IDI, CXL_MEM.
// it shared the same data- channel and multiplexed Req and RSP buses.
`ifdef FPGA_SYNTH
    `define 	UFI_AGENT_0 					fpga_transactors_top_inst
    `define 	TRANSACTORS_PATH      fpga_transactors_top_inst 
`else
    `define 	UFI_AGENT_0 					fpga_transactors_tb.fpga_transactors_top_inst       // example:  fpga_tcss_top.tcss_val_rtl.tcss.par_iom
    `define 	TRANSACTORS_PATH      fpga_transactors_tb.fpga_transactors_top_inst 
`endif   
/*`ifdef SLIM_SIM
   assign    `TRANSACTORS_PATH.ufi_fabric_clk[0] 	        = pc5_fpga_wrap_top.dut_tb_inst_sb_seq.clk_100mhz;
   assign    `TRANSACTORS_PATH.ufi_fabric_clk[1] 		= pc5_fpga_wrap_top.dut_tb_inst_sb_seq.clk_100mhz;
   assign    `TRANSACTORS_PATH.ufi_gnr0_clk 		        = pc5_fpga_wrap_top.dut_tb_inst_sb_seq.clk_100mhz;
`else
   assign    `TRANSACTORS_PATH.ufi_fabric_clk[0] 	        = pc5_fpga_wrap_top.gclk3; //`UFI_AGENT_0.ufi_agent_clock_0; // Shrikant: 7/16
   assign    `TRANSACTORS_PATH.ufi_fabric_clk[1] 		= pc5_fpga_wrap_top.gclk3; //`UFI_AGENT_0.ufi_agent_clock_0; // Shrikant: 7/16
   assign    `TRANSACTORS_PATH.ufi_gnr0_clk 		        = pc5_fpga_wrap_top.gclk3; // Shrikant: 7/16
`endif

   assign    `TRANSACTORS_PATH.ufi_fabric_rstn[0]               = pc5_fpga_wrap_top.reset_n; //`UFI_AGENT_0.ufi_agent_rst_n_0; 
   assign    `TRANSACTORS_PATH.ufi_fabric_rstn[1]               = pc5_fpga_wrap_top.reset_n; //`UFI_AGENT_0.ufi_agent_rst_n_0; 
   assign    `TRANSACTORS_PATH.ufi_gnr0_rstn                    = pc5_fpga_wrap_top.reset_n; //`UFI_AGENT_0.ufi_agent_rst_n_0;      
*/


   assign 	`TRANSACTORS_PATH.ufi_fabric_clk[0] 			 	= `UFI_AGENT_0.ufi_agent_clock_0; 
   assign 	`TRANSACTORS_PATH.ufi_gnr0_clk 		          = `UFI_AGENT_0.ufi_agent_clock_0;
   assign 	`TRANSACTORS_PATH.ufi_fabric_rstn[0] 				= `UFI_AGENT_0.ufi_agent_rst_n_0; 
   assign 	`TRANSACTORS_PATH.ufi_gnr0_rstn             = `UFI_AGENT_0.ufi_agent_rst_n_0;      

// A2F Request connections
   assign   `TRANSACTORS_PATH.ufi_a2f_req_is_valid[0]          	= `UFI_AGENT_0.a2f_req_is_valid_0;
   assign   `TRANSACTORS_PATH.ufi_a2f_req_protocol_id[0]       	= `UFI_AGENT_0.a2f_req_protocol_id_0;
   assign   `TRANSACTORS_PATH.ufi_a2f_req_vc_id[0]            	= `UFI_AGENT_0.a2f_req_vc_id_0;
   assign   `TRANSACTORS_PATH.ufi_a2f_req_header[0]            	= `UFI_AGENT_0.a2f_req_header_0; 
// A2F Response connections
   assign   `TRANSACTORS_PATH.a2f_idi0_rsp_is_valid0            = `UFI_AGENT_0.a2f_idi0_rsp_is_valid_0;
   assign   `TRANSACTORS_PATH.a2f_mem_rsp_is_valid0             = `UFI_AGENT_0.a2f_mem_rsp_is_valid_0;
   assign   `TRANSACTORS_PATH.a2f_rsp_protocol_id0              = `UFI_AGENT_0.a2f_rsp_protocol_id_0;
   assign   `TRANSACTORS_PATH.a2f_idi0_rsp_vc_id0            	  = `UFI_AGENT_0.a2f_idi0_rsp_vc_id_0;
   assign   `TRANSACTORS_PATH.a2f_mem_rsp_vc_id0                = `UFI_AGENT_0.a2f_mem_rsp_vc_id_0;
   assign   `TRANSACTORS_PATH.a2f_idi0_rsp_header0              = {8'b0,`UFI_AGENT_0.a2f_idi0_rsp_header_0}; 
   assign   `TRANSACTORS_PATH.a2f_mem_rsp_header0               = {5'b0,`UFI_AGENT_0.a2f_mem_rsp_header_0};

   assign   `TRANSACTORS_PATH.f2a_idi0_req_rxcrd0               = `UFI_AGENT_0.f2a_idi0_req_rxcrd_0;            
   //assign   `TRANSACTORS_PATH.f2a_idi0_req_rxcrd_protocol_id0   =  2'b0;
   assign   `TRANSACTORS_PATH.f2a_idi0_req_rxcrd_vc_id0         = `UFI_AGENT_0.f2a_idi0_req_rxcrd_vc_id_0;
   assign   `TRANSACTORS_PATH.f2a_mem_req_rxcrd0                = `UFI_AGENT_0.f2a_mem_req_rxcrd_0;             
   //assign   `TRANSACTORS_PATH.f2a_mem_req_rxcrd_protocol_id0        =  2'b10;
   assign   `TRANSACTORS_PATH.f2a_mem_req_rxcrd_vc_id0          = `UFI_AGENT_0.f2a_mem_req_rxcrd_vc_id_0;
   assign   `TRANSACTORS_PATH.ufi_f2a_req_rxcrd[0]              = `TRANSACTORS_PATH.f2a_req_rxcrd0;
   assign   `TRANSACTORS_PATH.ufi_f2a_req_rxcrd_protocol_id[0] 	= `TRANSACTORS_PATH.f2a_req_rxcrd_protocol_id0;
   assign   `TRANSACTORS_PATH.ufi_f2a_req_rxcrd_vc_id[0]      	= `TRANSACTORS_PATH.f2a_req_rxcrd_vc_id0;
    

   assign   `TRANSACTORS_PATH.ufi_a2f_rsp_is_valid[0]         	=  `TRANSACTORS_PATH.a2f_rsp_is_valid0;
   assign   `TRANSACTORS_PATH.ufi_a2f_rsp_protocol_id[0]      	=  `TRANSACTORS_PATH.a2f_rsp_protocol_id0;
   assign   `TRANSACTORS_PATH.ufi_a2f_rsp_vc_id[0]            	=  `TRANSACTORS_PATH.a2f_rsp_vc_id0;
   assign   `TRANSACTORS_PATH.ufi_a2f_rsp_header[0]           	=  `TRANSACTORS_PATH.a2f_rsp_header0; 
   

// A2F Data connections 
   assign   `TRANSACTORS_PATH.ufi_a2f_data_is_valid[0]       	= `UFI_AGENT_0.a2f_idi0mem_data_is_valid_0; 
   assign   `TRANSACTORS_PATH.ufi_a2f_data_protocol_id[0]    	= `UFI_AGENT_0.a2f_idi0mem_data_protocol_id_0;
   assign   `TRANSACTORS_PATH.ufi_a2f_data_vc_id[0]         	= `UFI_AGENT_0.a2f_idi0mem_data_vc_id_0;
   assign   `TRANSACTORS_PATH.ufi_a2f_data_header[0]         	= `UFI_AGENT_0.a2f_idi0mem_data_header_0; 
   assign   `TRANSACTORS_PATH.ufi_a2f_data_eop[0]            	= `UFI_AGENT_0.a2f_idi0mem_data_eop_0; 
   assign   `TRANSACTORS_PATH.ufi_a2f_data_payload[0]        	= `UFI_AGENT_0.a2f_idi0mem_data_payload_0; 

   
// F2A Request connections 
//   assign   `TRANSACTORS_PATH.ufi_f2a_req_rxcrd[0]             	= `UFI_AGENT_0.f2a_req_rxcrd0;             
//   assign   `TRANSACTORS_PATH.ufi_f2a_req_rxcrd_protocol_id[0] 	= `UFI_AGENT_0.f2a_req_rxcrd_protocol_id0;
   
// F2A Response connections - should be connected to IDI0 
   assign   `TRANSACTORS_PATH.ufi_f2a_rsp_rxcrd[0]             	= `UFI_AGENT_0.f2a_rsp_rxcrd_0;             
   assign   `TRANSACTORS_PATH.ufi_f2a_rsp_rxcrd_protocol_id[0] 	= `UFI_AGENT_0.f2a_req_rxcrd_protocol_id_0;

   assign   `TRANSACTORS_PATH.ufi_f2a_rsp_rxcrd_vc_id[0] 	      = `UFI_AGENT_0.f2a_rsp_rxcrd_vc_id_0;
   
// F2A Data connections 
   assign   `TRANSACTORS_PATH.ufi_f2a_data_rxcrd[0]             = `UFI_AGENT_0.f2a_idi0mem_data_rxcrd_0;                    
   assign   `TRANSACTORS_PATH.ufi_f2a_data_rxcrd_protocol_id[0] = `UFI_AGENT_0.f2a_idi0mem_data_rxcrd_protocol_id_0;
   assign   `TRANSACTORS_PATH.ufi_f2a_data_rxcrd_vc_id[0]       = `UFI_AGENT_0.f2a_idi0mem_data_rxcrd_vc_id_0;

// A2F Global connections
   assign   `TRANSACTORS_PATH.ufi_a2f_txcon_req[0]              = `UFI_AGENT_0.a2f_txcon_req_0; 
   
// F2A Global connections
   assign   `TRANSACTORS_PATH.ufi_f2a_rx_ack[0]            		= `UFI_AGENT_0.f2a_rx_ack_0; 
   assign   `TRANSACTORS_PATH.ufi_f2a_rx_empty[0]          		= `UFI_AGENT_0.f2a_rx_empty_0; 
   assign   `TRANSACTORS_PATH.ufi_f2a_rxcon_nack_req[0] 	  	= 1'b0;



//=================================================================================================================================
// UFI_FABRIC connections - USER MUST EDIT THE LEFT HAND SIDE OF THE FOLLOWING ASSIGNMENTS 
//=================================================================================================================================


// A2F Request connections - should be connected to IDI0 
   assign   `UFI_AGENT_0.a2f_req_rxcrd_0     = `TRANSACTORS_PATH.ufi_a2f_req_rxcrd[0]; 
   assign   `UFI_AGENT_0.a2f_req_rxcrd_protocol_id_0  	  		= `TRANSACTORS_PATH.ufi_a2f_req_rxcrd_protocol_id[0]; 
   assign   `UFI_AGENT_0.a2f_req_rxcrd_vc_id_0  	= `TRANSACTORS_PATH.ufi_a2f_req_rxcrd_vc_id[0];
// ** only in GNR   assign   `UFI_AGENT_0.a2f_req_rxcrd_shared    = 'b0;
// A2F Response connections
   //assign   `UFI_AGENT_0.a2f_rsp_rxcrd_0              			= `TRANSACTORS_PATH.ufi_a2f_rsp_rxcrd[0]; 
   //assign   `UFI_AGENT_0.a2f_rsp_rxcrd_protocol_id_0  			= `TRANSACTORS_PATH.ufi_a2f_rsp_rxcrd_protocol_id[0]; 
   assign   `TRANSACTORS_PATH.a2f_rsp_rxcrd0              		= `TRANSACTORS_PATH.ufi_a2f_rsp_rxcrd[0]; 
   assign   `TRANSACTORS_PATH.a2f_rsp_rxcrd_protocol_id0  	  = `TRANSACTORS_PATH.ufi_a2f_rsp_rxcrd_protocol_id[0]; 
   assign   `TRANSACTORS_PATH.a2f_rsp_rxcrd_vc_id0  	        = `TRANSACTORS_PATH.ufi_a2f_rsp_rxcrd_vc_id[0];
 
   /******* this should used in real connection ****
   assign   `UFI_AGENT_0.a2f_idi0_rsp_rxcrd_valid   = `TRANSACTORS_PATH.a2f_idi0_rsp_rxcrd0;
   assign   `UFI_AGENT_0.a2f_idi0_rsp_rxcrd_shared  = 1'b0;
   assign   `UFI_AGENT_0.a2f_idi0_rsp_rxcrd_vc_id   = `TRANSACTORS_PATH.a2f_idi0_rsp_rxcrd_vc_id0;
   assign   `UFI_AGENT_0.a2f_mem0_rsp_rxcrd_valid   = `TRANSACTORS_PATH.a2f_mem_rsp_rxcrd0;
   assign   `UFI_AGENT_0.a2f_mem0_rsp_rxcrd_shared  = 1'b0;
   assign   `UFI_AGENT_0.a2f_mem0_rsp_rxcrd_vc_id   = `TRANSACTORS_PATH.a2f_mem_rsp_rxcrd_vc_id0;
   */
 
// A2F Data connections 
   assign   `UFI_AGENT_0.a2f_idi0mem_data_rxcrd_0                = `TRANSACTORS_PATH.ufi_a2f_data_rxcrd[0]; 
   assign   `UFI_AGENT_0.a2f_idi0mem_data_rxcrd_protocol_id_0    = `TRANSACTORS_PATH.ufi_a2f_data_rxcrd_protocol_id[0]; 
   assign   `UFI_AGENT_0.a2f_idi0mem_data_rxcrd_vc_id_0  			   = `TRANSACTORS_PATH.ufi_a2f_data_rxcrd_vc_id[0]; 
// ** only in GNR   assign   `UFI_AGENT_0.a2f_idi0mem_data_rxcrd_shared           = 'b0;

// F2A Request connections 
// Connected through multiplexer into 2 Req IDI0 and CXL_MEM inputs
   assign   `TRANSACTORS_PATH.f2a_req_is_valid0               = `TRANSACTORS_PATH.ufi_f2a_req_is_valid[0];
   assign   `TRANSACTORS_PATH.f2a_req_protocol_id0    	      = `TRANSACTORS_PATH.ufi_f2a_req_protocol_id[0];
   assign   `TRANSACTORS_PATH.f2a_req_vc_id0    	            = `TRANSACTORS_PATH.ufi_f2a_req_vc_id[0];
   assign   `TRANSACTORS_PATH.f2a_req_header0                 = `TRANSACTORS_PATH.ufi_f2a_req_header[0]; 

   assign   `UFI_AGENT_0.f2a_idi0_req_is_valid_0       		= `TRANSACTORS_PATH.f2a_idi0_req_is_valid0;
   assign   `UFI_AGENT_0.f2a_mem_req_is_valid_0        		= `TRANSACTORS_PATH.f2a_mem_req_is_valid0;
   assign   `UFI_AGENT_0.f2a_req_protocol_id_0    				= `TRANSACTORS_PATH.ufi_f2a_req_protocol_id[0];
   assign   `UFI_AGENT_0.f2a_idi0_req_vc_id_0          = `TRANSACTORS_PATH.f2a_idi0_req_vc_id0;
   assign   `UFI_AGENT_0.f2a_mem_req_vc_id_0           = `TRANSACTORS_PATH.f2a_mem_req_vc_id0;
   assign   `UFI_AGENT_0.f2a_idi0_req_header_0           	= `TRANSACTORS_PATH.f2a_idi0_req_header0; 
   assign   `UFI_AGENT_0.f2a_mem_req_header_0             = `TRANSACTORS_PATH.f2a_mem_req_header0; 
// ** only in GNR   assign   `UFI_AGENT_0.f2a_idi0_req_shared_credit       = 'b0;
// ** only in GNR   assign   `UFI_AGENT_0.f2a_mem_req_shared_credit        = 'b0;

   // F2A Response connections - should be connected to IDI0 
   assign   `UFI_AGENT_0.f2a_rsp_is_valid_0          	= `TRANSACTORS_PATH.ufi_f2a_rsp_is_valid[0];
   assign   `UFI_AGENT_0.f2a_rsp_protocol_id_0    				= `TRANSACTORS_PATH.ufi_f2a_rsp_protocol_id[0];
   assign   `UFI_AGENT_0.f2a_rsp_vc_id_0    	        = `TRANSACTORS_PATH.ufi_f2a_rsp_vc_id[0];
   assign   `UFI_AGENT_0.f2a_rsp_header_0         		= `TRANSACTORS_PATH.ufi_f2a_rsp_header[0]; 
// ** only in GNR   assign   `UFI_AGENT_0.f2a_rsp_shared_credit        = 'b0;
// F2A Data connections 
   assign   `UFI_AGENT_0.f2a_idi0mem_data_is_valid_0    				= `TRANSACTORS_PATH.ufi_f2a_data_is_valid[0]; 
   assign   `UFI_AGENT_0.f2a_idi0mem_data_protocol_id_0			  	= `TRANSACTORS_PATH.ufi_f2a_data_protocol_id[0];
   assign   `UFI_AGENT_0.f2a_idi0mem_data_vc_id_0 	          	= `TRANSACTORS_PATH.ufi_f2a_data_vc_id[0];
   assign   `UFI_AGENT_0.f2a_idi0mem_data_header_0      				= `TRANSACTORS_PATH.ufi_f2a_data_header[0]; 
   assign   `UFI_AGENT_0.f2a_idi0mem_data_eop_0         				= `TRANSACTORS_PATH.ufi_f2a_data_eop[0]; 
   assign   `UFI_AGENT_0.f2a_idi0mem_data_payload_0     				= `TRANSACTORS_PATH.ufi_f2a_data_payload[0]; 
// ** only in GNR   assign   `UFI_AGENT_0.f2a_idi0mem_data_shared_credit         = 'b0;

// A2F Global connections - should be connected to IDI0 
   assign   `UFI_AGENT_0.a2f_rx_ack_0             				= `TRANSACTORS_PATH.ufi_a2f_rx_ack[0]; 
   assign   `UFI_AGENT_0.a2f_rx_empty_0        			    	= `TRANSACTORS_PATH.ufi_a2f_rx_empty[0]; 
//   assign   `UFI_AGENT_0.a2f_rxcon_nack_req_0 			  	        = `TRANSACTORS_PATH.ufi_a2f_rxcon_nack_req[0]; 
   
// F2A Global connections
   assign   `UFI_AGENT_0.f2a_txcon_req_0    					= `TRANSACTORS_PATH.ufi_f2a_txcon_req[0]; 


   

