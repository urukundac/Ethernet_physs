// Loop back connection for SA simulation and Synthesis
`define 	AXIM_MASTER_0 				`FPGA_TRANSACTORS_TOP       // example:  fpga_tcss_top.tcss_val_rtl.tcss.par_iom
`define 	AXIM_SLAVE_0 					`FPGA_TRANSACTORS_TOP       // example:  fpga_tcss_top.tcss_val_rtl.tcss.par_iom

// AXIM Addreaa Write port
assign s_awvalid_0    = m_awvalid_0;    
assign s_awid_0       = m_awid_0;       
assign s_awaddr_0     = m_awaddr_0;     
assign s_awlen_0      = m_awlen_0;      
assign s_awsize_0     = m_awsize_0;     
assign s_awburst_0    = m_awburst_0;    
assign s_awlock_0     = m_awlock_0;     
assign s_awcache_0    = m_awcache_0;    
assign s_awprot_0     = m_awprot_0;     
assign s_awqos_0      = m_awqos_0;      
assign s_awregion_0   = m_awregion_0;    
assign s_awuser_0     = m_awuser_0;     
assign m_awready_0   = s_awready_0;

// AXIM Write port
assign s_wvalid_0     = m_wvalid_0;    
assign s_wid_0        = m_wid_0;       
assign s_wdata_0      = m_wdata_0;     
assign s_wstrb_0      = m_wstrb_0;     
assign s_wlast_0      = m_wlast_0;     
assign s_wuser_0      = m_wuser_0;     
assign m_wready_0    = s_wready_0;

// AXIM Addreaa Read port
assign s_arvalid_0    = m_arvalid_0; 
assign s_arid_0       = m_arid_0;    
assign s_araddr_0     = m_araddr_0;  
assign s_arlen_0      = m_arlen_0;   
assign s_arsize_0     = m_arsize_0;  
assign s_arburst_0    = m_arburst_0; 
assign s_arlock_0     = m_arlock_0;  
assign s_arcache_0    = m_arcache_0; 
assign s_arprot_0     = m_arprot_0;  
assign s_arqos_0      = m_arqos_0;   
assign s_arregion_0   = m_arregion_0; 
assign s_aruser_0     = m_aruser_0;  
assign m_arready_0   = s_arready_0;

// AXIM Read port  
assign m_rvalid_0 	  = s_rvalid_0; 	   
assign m_rid_0       = s_rid_0;        
assign m_rdata_0 		= s_rdata_0; 		 
assign m_rresp_0 		= s_rresp_0; 		 
assign m_rlast_0     = s_rlast_0;      
assign m_ruser_0 		= s_ruser_0; 		 
assign s_rready_0     = m_rready_0;

// AXIM Response port
assign m_bvalid_0    = s_bvalid_0;     
assign m_bid_0			  = s_bid_0;			   
assign m_bresp_0     = s_bresp_0;      
assign m_buser_0     = s_buser_0;      
assign s_bready_0     = m_bready_0;
