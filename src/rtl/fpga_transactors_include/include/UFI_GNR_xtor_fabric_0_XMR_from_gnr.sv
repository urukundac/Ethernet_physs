//=================================================================================================================================
// UFI_FABRIC connections - USER MUST EDIT THE RIGHT HAND SIDE OF THE FOLLOWING ASSIGNMENTS AND DEFINE - WHEN NEEDED
//=================================================================================================================================
// This file include connections 2 transactors as defined in GNR UFI design

// connection of transactor #0
// This transactor is includes 2 sub-protocols : IDI, CXL_MEM.
// it shared the same data- channel and multiplexed Req and RSP buses.
//vvvarma  4/26
//`ifdef FPGA_SYNTH
//    `define 	UFI_AGENT_0 					`FPGA_TRANSACTORS_TOP
    `define 	UFI_AGENT_0 					pc5_fpga_wrap_top.pi5//vvvarma `FPGA_TRANSACTORS_TOP
    `define 	UFI_AGENT_1 					pc5_fpga_wrap_top.pi5//vvvarma
//    `define 	TRANSACTORS_PATH      `FPGA_TRANSACTORS_TOP 
/*`else
    `define 	UFI_AGENT_0 					fpga_transactors_tb.`FPGA_TRANSACTORS_TOP       // example:  fpga_tcss_top.tcss_val_rtl.tcss.par_iom
    `define 	TRANSACTORS_PATH      fpga_transactors_tb.`FPGA_TRANSACTORS_TOP 
`endif  */  
`ifdef SLIM_SIM
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
// A2F Request connections
   assign   `TRANSACTORS_PATH.ufi_a2f_req_is_valid[0]          	= `UFI_AGENT_0.cxlcm_ufi_idi0_a2f_req_A2F_req_is_valid;;
   assign   `TRANSACTORS_PATH.ufi_a2f_req_protocol_id[0]       	= 2'b0;
   assign   `TRANSACTORS_PATH.ufi_a2f_req_vc_id[0]            	= `UFI_AGENT_0.cxlcm_ufi_idi0_a2f_req_A2F_req_vc_id;
   assign   `TRANSACTORS_PATH.ufi_a2f_req_header[0]            	= {13'b0,`UFI_AGENT_1.cxlcm_ufi_idi0_a2f_req_A2F_req_header}; 
// A2F Response connections
   assign   `TRANSACTORS_PATH.a2f_idi0_rsp_is_valid0            = `UFI_AGENT_0.cxlcm_ufi_idi0_a2f_rsp_A2F_rsp_is_valid;
   assign   `TRANSACTORS_PATH.a2f_mem_rsp_is_valid0             = `UFI_AGENT_0.cxlcm_ufi_mem0_a2f_rsp_A2F_rsp_is_valid;
   //assign   `TRANSACTORS_PATH.a2f_rsp_protocol_id0              = `UFI_AGENT_0.a2f_rsp_protocol_id_0;
   assign   `TRANSACTORS_PATH.a2f_idi0_rsp_vc_id0            	= `UFI_AGENT_0.cxlcm_ufi_idi0_a2f_rsp_A2F_rsp_vc_id;
   assign   `TRANSACTORS_PATH.a2f_mem_rsp_vc_id0                = `UFI_AGENT_0.cxlcm_ufi_mem0_a2f_rsp_A2F_rsp_vc_id;
   assign   `TRANSACTORS_PATH.a2f_idi0_rsp_header0              = {8'b0,`UFI_AGENT_0.cxlcm_ufi_idi0_a2f_rsp_A2F_rsp_header}; 
   assign   `TRANSACTORS_PATH.a2f_mem_rsp_header0               = {5'b0,`UFI_AGENT_0.cxlcm_ufi_mem0_a2f_rsp_A2F_rsp_header};

   assign   `TRANSACTORS_PATH.f2a_idi0_req_rxcrd0               = `UFI_AGENT_0.cxlcm_ufi_idi0_f2a_req_F2A_req_rxcrd_valid;            
   //assign   `TRANSACTORS_PATH.f2a_idi0_req_rxcrd_protocol_id0   =  2'b0;
   assign   `TRANSACTORS_PATH.f2a_idi0_req_rxcrd_vc_id0         = `UFI_AGENT_0.cxlcm_ufi_idi0_f2a_req_F2A_req_rxcrd_vc_id;
   assign   `TRANSACTORS_PATH.f2a_mem_req_rxcrd0                = `UFI_AGENT_0.cxlcm_ufi_mem0_f2a_req_F2A_req_rxcrd_valid;             
   //assign   `TRANSACTORS_PATH.f2a_mem_req_rxcrd_protocol_id0        =  2'b10;
   assign   `TRANSACTORS_PATH.f2a_mem_req_rxcrd_vc_id0              = `UFI_AGENT_0.cxlcm_ufi_mem0_f2a_req_F2A_req_rxcrd_vc_id;
   assign   `TRANSACTORS_PATH.ufi_f2a_req_rxcrd[0]              = `TRANSACTORS_PATH.f2a_req_rxcrd0;
   assign   `TRANSACTORS_PATH.ufi_f2a_req_rxcrd_protocol_id[0] 	= `TRANSACTORS_PATH.f2a_req_rxcrd_protocol_id0;
   assign   `TRANSACTORS_PATH.ufi_f2a_req_rxcrd_vc_id[0]      	= `TRANSACTORS_PATH.f2a_req_rxcrd_vc_id0;
    

   assign   `TRANSACTORS_PATH.ufi_a2f_rsp_is_valid[0]         	=  `TRANSACTORS_PATH.a2f_rsp_is_valid0;
   assign   `TRANSACTORS_PATH.ufi_a2f_rsp_protocol_id[0]      	=  `TRANSACTORS_PATH.a2f_rsp_protocol_id0;
   assign   `TRANSACTORS_PATH.ufi_a2f_rsp_vc_id[0]            	=  `TRANSACTORS_PATH.a2f_rsp_vc_id0;
   assign   `TRANSACTORS_PATH.ufi_a2f_rsp_header[0]           	=  `TRANSACTORS_PATH.a2f_rsp_header0; 
   

// A2F Data connections 
   assign   `TRANSACTORS_PATH.ufi_a2f_data_is_valid[0]       	= `UFI_AGENT_0.cxlcm_ufi_a2f_data_A2F_data_is_valid; 
   assign   `TRANSACTORS_PATH.ufi_a2f_data_protocol_id[0]    	= `UFI_AGENT_0.cxlcm_ufi_a2f_data_A2F_data_protocol_id;
   assign   `TRANSACTORS_PATH.ufi_a2f_data_vc_id[0]         	= `UFI_AGENT_0.cxlcm_ufi_a2f_data_A2F_data_vc_id;
   assign   `TRANSACTORS_PATH.ufi_a2f_data_header[0]         	= `UFI_AGENT_0.cxlcm_ufi_a2f_data_A2F_data_header[14:0]; 
   assign   `TRANSACTORS_PATH.ufi_a2f_data_eop[0]            	= `UFI_AGENT_0.cxlcm_ufi_a2f_data_A2F_data_eop; 
   assign   `TRANSACTORS_PATH.ufi_a2f_data_payload[0]        	= `UFI_AGENT_0.cxlcm_ufi_a2f_data_A2F_data_payload; 

   
// F2A Request connections 
//   assign   `TRANSACTORS_PATH.ufi_f2a_req_rxcrd[0]             	= `UFI_AGENT_0.f2a_req_rxcrd0;             
//   assign   `TRANSACTORS_PATH.ufi_f2a_req_rxcrd_protocol_id[0] 	= `UFI_AGENT_0.f2a_req_rxcrd_protocol_id0;
   
// F2A Response connections - should be connected to IDI0 
   assign   `TRANSACTORS_PATH.ufi_f2a_rsp_rxcrd[0]             	= `UFI_AGENT_0.cxlcm_ufi_idi0_f2a_rsp_F2A_rsp_rxcrd_valid;             
   assign   `TRANSACTORS_PATH.ufi_f2a_rsp_rxcrd_protocol_id[0] 	= 2'b0;
   assign   `TRANSACTORS_PATH.ufi_f2a_rsp_rxcrd_vc_id[0] 	= `UFI_AGENT_0.cxlcm_ufi_idi0_f2a_rsp_F2A_rsp_rxcrd_vc_id;
   
// F2A Data connections 
   assign   `TRANSACTORS_PATH.ufi_f2a_data_rxcrd[0]             = `UFI_AGENT_0.cxlcm_ufi_f2a_data_F2A_data_rxcrd_valid;             
   assign   `TRANSACTORS_PATH.ufi_f2a_data_rxcrd_protocol_id[0] = `UFI_AGENT_0.cxlcm_ufi_f2a_data_F2A_data_rxcrd_protocol_id;
   assign   `TRANSACTORS_PATH.ufi_f2a_data_rxcrd_vc_id[0]       = `UFI_AGENT_0.cxlcm_ufi_f2a_data_F2A_data_rxcrd_vc_id;

// A2F Global connections
   assign   `TRANSACTORS_PATH.ufi_a2f_txcon_req[0]                      = `UFI_AGENT_0.cxlcm_ufi_globals_if_A2F_txcon_req; 
   
// F2A Global connections
   assign   `TRANSACTORS_PATH.ufi_f2a_rx_ack[0]            		= `UFI_AGENT_0.cxlcm_ufi_globals_if_F2A_rxcon_ack; 
   assign   `TRANSACTORS_PATH.ufi_f2a_rx_empty[0]          		= `UFI_AGENT_0.cxlcm_ufi_globals_if_F2A_rx_empty; 
   assign   `TRANSACTORS_PATH.ufi_f2a_rxcon_nack_req[0] 	  	= 1'b0;



//=================================================================================================================================
// UFI_FABRIC connections - USER MUST EDIT THE LEFT HAND SIDE OF THE FOLLOWING ASSIGNMENTS 
//=================================================================================================================================


// A2F Request connections - should be connected to IDI0 
//vvvarma yigal, changing for MD error 6/7
   assign   `UFI_AGENT_0.cxlcm_ufi_idi0_a2f_req_A2F_req_rxcrd_valid     = `TRANSACTORS_PATH.ufi_a2f_req_rxcrd[0]; 
   //assign   `UFI_AGENT_0.a2f_req_rxcrd_protocol_id_0  	  		= `TRANSACTORS_PATH.ufi_a2f_req_rxcrd_protocol_id[0]; 
   assign   `UFI_AGENT_0.cxlcm_ufi_idi0_a2f_req_A2F_req_rxcrd_vc_id  	= `TRANSACTORS_PATH.ufi_a2f_req_rxcrd_vc_id[0];
   assign   `UFI_AGENT_0.cxlcm_ufi_idi0_a2f_req_A2F_req_rxcrd_shared    = 'b0;
// A2F Response connections
   //assign   `UFI_AGENT_0.a2f_rsp_rxcrd_0              			= `TRANSACTORS_PATH.ufi_a2f_rsp_rxcrd[0]; 
   //assign   `UFI_AGENT_0.a2f_rsp_rxcrd_protocol_id_0  			= `TRANSACTORS_PATH.ufi_a2f_rsp_rxcrd_protocol_id[0]; 
   assign   `TRANSACTORS_PATH.a2f_rsp_rxcrd0              		= `TRANSACTORS_PATH.ufi_a2f_rsp_rxcrd[0]; 
   assign   `TRANSACTORS_PATH.a2f_rsp_rxcrd_protocol_id0  	  = `TRANSACTORS_PATH.ufi_a2f_rsp_rxcrd_protocol_id[0]; 
   assign   `TRANSACTORS_PATH.a2f_rsp_rxcrd_vc_id0  	        = `TRANSACTORS_PATH.ufi_a2f_rsp_rxcrd_vc_id[0];
  
   assign   `UFI_AGENT_0.cxlcm_ufi_idi0_a2f_rsp_A2F_rsp_rxcrd_valid = `TRANSACTORS_PATH.a2f_idi0_rsp_rxcrd0;
   assign   `UFI_AGENT_0.cxlcm_ufi_idi0_a2f_rsp_A2F_rsp_rxcrd_shared = 1'b0;
   assign   `UFI_AGENT_0.cxlcm_ufi_idi0_a2f_rsp_A2F_rsp_rxcrd_vc_id   = `TRANSACTORS_PATH.a2f_idi0_rsp_rxcrd_vc_id0;
   assign   `UFI_AGENT_0.cxlcm_ufi_mem0_a2f_rsp_A2F_rsp_rxcrd_valid = `TRANSACTORS_PATH.a2f_mem_rsp_rxcrd0;
   assign   `UFI_AGENT_0.cxlcm_ufi_mem0_a2f_rsp_A2F_rsp_rxcrd_shared = 1'b0;
   assign   `UFI_AGENT_0.cxlcm_ufi_mem0_a2f_rsp_A2F_rsp_rxcrd_vc_id = `TRANSACTORS_PATH.a2f_mem_rsp_rxcrd_vc_id0;

 
// A2F Data connections 
   assign   `UFI_AGENT_0.cxlcm_ufi_a2f_data_A2F_data_rxcrd_valid         = `TRANSACTORS_PATH.ufi_a2f_data_rxcrd[0]; 
   assign   `UFI_AGENT_0.cxlcm_ufi_a2f_data_A2F_data_rxcrd_protocol_id   = `TRANSACTORS_PATH.ufi_a2f_data_rxcrd_protocol_id[0]; 
   assign   `UFI_AGENT_0.cxlcm_ufi_a2f_data_A2F_data_rxcrd_vc_id       	= `TRANSACTORS_PATH.ufi_a2f_data_rxcrd_vc_id[0]; 
   assign   `UFI_AGENT_0.cxlcm_ufi_a2f_data_A2F_data_rxcrd_shared       = 'b0;

// F2A Request connections 
// Connected through multiplexer into 2 Req IDI0 and CXL_MEM inputs
   assign   `TRANSACTORS_PATH.f2a_req_is_valid0               = `TRANSACTORS_PATH.ufi_f2a_req_is_valid[0];
   assign   `TRANSACTORS_PATH.f2a_req_protocol_id0    	      = `TRANSACTORS_PATH.ufi_f2a_req_protocol_id[0];
   assign   `TRANSACTORS_PATH.f2a_req_vc_id0    	      = `TRANSACTORS_PATH.ufi_f2a_req_vc_id[0];
   assign   `TRANSACTORS_PATH.f2a_req_header0                 = `TRANSACTORS_PATH.ufi_f2a_req_header[0]; 

   assign   `UFI_AGENT_0.cxlcm_ufi_idi0_f2a_req_F2A_req_is_valid       		= `TRANSACTORS_PATH.f2a_idi0_req_is_valid0;
   assign   `UFI_AGENT_0.cxlcm_ufi_mem0_f2a_req_F2A_req_is_valid       		= `TRANSACTORS_PATH.f2a_mem_req_is_valid0;
   //assign   `UFI_AGENT_0.f2a_req_protocol_id_0    				= `TRANSACTORS_PATH.ufi_f2a_req_protocol_id[0];
   assign   `UFI_AGENT_0.cxlcm_ufi_idi0_f2a_req_F2A_req_vc_id           	= `TRANSACTORS_PATH.f2a_idi0_req_vc_id0;
   assign   `UFI_AGENT_0.cxlcm_ufi_mem0_f2a_req_F2A_req_vc_id                   = `TRANSACTORS_PATH.f2a_mem_req_vc_id0;
   assign   `UFI_AGENT_0.cxlcm_ufi_idi0_f2a_req_F2A_req_header           	= `TRANSACTORS_PATH.f2a_idi0_req_header0; 
   assign   `UFI_AGENT_0.cxlcm_ufi_mem0_f2a_req_F2A_req_header         	        = {4'b0,`TRANSACTORS_PATH.f2a_mem_req_header0}; 
   assign   `UFI_AGENT_0.cxlcm_ufi_idi0_f2a_req_F2A_req_shared_credit           = 'b0;
   assign   `UFI_AGENT_0.cxlcm_ufi_mem0_f2a_req_F2A_req_shared_credit           = 'b0;

   // F2A Response connections - should be connected to IDI0 
   assign   `UFI_AGENT_0.cxlcm_ufi_idi0_f2a_rsp_F2A_rsp_is_valid          	= `TRANSACTORS_PATH.ufi_f2a_rsp_is_valid[0];
   //assign   `UFI_AGENT_0.f2a_rsp_protocol_id_0    				= `TRANSACTORS_PATH.ufi_f2a_rsp_protocol_id[0];
   assign   `UFI_AGENT_0.cxlcm_ufi_idi0_f2a_rsp_F2A_rsp_vc_id    	        = `TRANSACTORS_PATH.ufi_f2a_rsp_vc_id[0];
   assign   `UFI_AGENT_0.cxlcm_ufi_idi0_f2a_rsp_F2A_rsp_header         		= `TRANSACTORS_PATH.ufi_f2a_rsp_header[0]; 
   assign   `UFI_AGENT_0.cxlcm_ufi_idi0_f2a_rsp_F2A_rsp_shared_credit           = 'b0;
// F2A Data connections 
   assign   `UFI_AGENT_0.cxlcm_ufi_f2a_data_F2A_data_is_valid    				= `TRANSACTORS_PATH.ufi_f2a_data_is_valid[0]; 
   assign   `UFI_AGENT_0.cxlcm_ufi_f2a_data_F2A_data_protocol_id				= `TRANSACTORS_PATH.ufi_f2a_data_protocol_id[0];
   assign   `UFI_AGENT_0.cxlcm_ufi_f2a_data_F2A_data_vc_id			      	= `TRANSACTORS_PATH.ufi_f2a_data_vc_id[0];
   assign   `UFI_AGENT_0.cxlcm_ufi_f2a_data_F2A_data_header      				= `TRANSACTORS_PATH.ufi_f2a_data_header[0]; 
   assign   `UFI_AGENT_0.cxlcm_ufi_f2a_data_F2A_data_eop         				= `TRANSACTORS_PATH.ufi_f2a_data_eop[0]; 
   assign   `UFI_AGENT_0.cxlcm_ufi_f2a_data_F2A_data_payload     				= `TRANSACTORS_PATH.ufi_f2a_data_payload[0]; 
   assign   `UFI_AGENT_0.cxlcm_ufi_f2a_data_F2A_data_shared_credit                               = 'b0;

// A2F Global connections - should be connected to IDI0 
   assign   `UFI_AGENT_0.cxlcm_ufi_globals_if_A2F_rxcon_ack            				= `TRANSACTORS_PATH.ufi_a2f_rx_ack[0]; 
   assign   `UFI_AGENT_0.cxlcm_ufi_globals_if_A2F_rx_empty          				= `TRANSACTORS_PATH.ufi_a2f_rx_empty[0]; 
//   assign   `UFI_AGENT_0.a2f_rxcon_nack_req_0 			  	        = `TRANSACTORS_PATH.ufi_a2f_rxcon_nack_req[0]; 
   
// F2A Global connections
   assign   `UFI_AGENT_0.cxlcm_ufi_globals_if_F2A_txcon_req    					= `TRANSACTORS_PATH.ufi_f2a_txcon_req[0]; 


   

