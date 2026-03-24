// Loop back connection for SA simulation and Synthesis
`define 	AXIM_MASTER_1 				fpga_transactors_top_inst       // example:  fpga_tcss_top.tcss_val_rtl.tcss.par_iom
`define 	AXIM_SLAVE_1 					fpga_transactors_top_inst       // example:  fpga_tcss_top.tcss_val_rtl.tcss.par_iom

// AXIM Addreaa Write port
assign s_awvalid_1    = m_awvalid_1;    
assign s_awid_1       = m_awid_1;       
assign s_awaddr_1     = m_awaddr_1;     
assign s_awlen_1      = m_awlen_1;      
assign s_awsize_1     = m_awsize_1;     
assign s_awburst_1    = m_awburst_1;    
assign s_awlock_1     = m_awlock_1;     
assign s_awcache_1    = m_awcache_1;    
assign s_awprot_1     = m_awprot_1;     
assign s_awqos_1      = m_awqos_1;      
assign s_awregion_1   = m_awregion_1;    
assign s_awuser_1     = m_awuser_1;     
assign m_awready_1   = s_awready_1;

// AXIM Write port
assign s_wvalid_1     = m_wvalid_1;    
assign s_wid_1        = m_wid_1;       
assign s_wdata_1      = m_wdata_1;     
assign s_wstrb_1      = m_wstrb_1;     
assign s_wlast_1      = m_wlast_1;     
assign s_wuser_1      = m_wuser_1;     
assign m_wready_1    = s_wready_1;

// AXIM Addreaa Read port
assign s_arvalid_1    = m_arvalid_1; 
assign s_arid_1       = m_arid_1;    
assign s_araddr_1     = m_araddr_1;  
assign s_arlen_1      = m_arlen_1;   
assign s_arsize_1     = m_arsize_1;  
assign s_arburst_1    = m_arburst_1; 
assign s_arlock_1     = m_arlock_1;  
assign s_arcache_1    = m_arcache_1; 
assign s_arprot_1     = m_arprot_1;  
assign s_arqos_1      = m_arqos_1;   
assign s_arregion_1   = m_arregion_1; 
assign s_aruser_1     = m_aruser_1;  
assign m_arready_1   = s_arready_1;

// AXIM Read port  
assign m_rvalid_1 	  = s_rvalid_1; 	   
assign m_rid_1       = s_rid_1;        
assign m_rdata_1 		= s_rdata_1; 		 
assign m_rresp_1 		= s_rresp_1; 		 
assign m_rlast_1     = s_rlast_1;      
assign m_ruser_1 		= s_ruser_1; 		 
assign s_rready_1     = m_rready_1;

// AXIM Response port
assign m_bvalid_1    = s_bvalid_1;     
assign m_bid_1			  = s_bid_1;			   
assign m_bresp_1     = s_bresp_1;      
assign m_buser_1     = s_buser_1;      
assign s_bready_1     = m_bready_1;
