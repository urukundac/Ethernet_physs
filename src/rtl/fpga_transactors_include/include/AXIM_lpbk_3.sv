// Loop back connection for SA simulation and Synthesis
`define 	AXIM_MASTER_3 				`FPGA_TRANSACTORS_TOP       // example:  fpga_tcss_top.tcss_val_rtl.tcss.par_iom
`define 	AXIM_SLAVE_3 					`FPGA_TRANSACTORS_TOP       // example:  fpga_tcss_top.tcss_val_rtl.tcss.par_iom

// AXIM Addreaa Write port
assign s_awvalid_3    = m_awvalid_3;    
assign s_awid_3       = m_awid_3;       
assign s_awaddr_3     = m_awaddr_3;     
assign s_awlen_3      = m_awlen_3;      
assign s_awsize_3     = m_awsize_3;     
assign s_awburst_3    = m_awburst_3;    
assign s_awlock_3     = m_awlock_3;     
assign s_awcache_3    = m_awcache_3;    
assign s_awprot_3     = m_awprot_3;     
assign s_awqos_3      = m_awqos_3;      
assign s_awregion_3   = m_awregion_3;    
assign s_awuser_3     = m_awuser_3;     
assign m_awready_3   = s_awready_3;

// AXIM Write port
assign s_wvalid_3     = m_wvalid_3;    
assign s_wid_3        = m_wid_3;       
assign s_wdata_3      = m_wdata_3;     
assign s_wstrb_3      = m_wstrb_3;     
assign s_wlast_3      = m_wlast_3;     
assign s_wuser_3      = m_wuser_3;     
assign m_wready_3    = s_wready_3;

// AXIM Addreaa Read port
assign s_arvalid_3    = m_arvalid_3; 
assign s_arid_3       = m_arid_3;    
assign s_araddr_3     = m_araddr_3;  
assign s_arlen_3      = m_arlen_3;   
assign s_arsize_3     = m_arsize_3;  
assign s_arburst_3    = m_arburst_3; 
assign s_arlock_3     = m_arlock_3;  
assign s_arcache_3    = m_arcache_3; 
assign s_arprot_3     = m_arprot_3;  
assign s_arqos_3      = m_arqos_3;   
assign s_arregion_3   = m_arregion_3; 
assign s_aruser_3     = m_aruser_3;  
assign m_arready_3   = s_arready_3;

// AXIM Read port  
assign m_rvalid_3 	  = s_rvalid_3; 	   
assign m_rid_3       = s_rid_3;        
assign m_rdata_3 		= s_rdata_3; 		 
assign m_rresp_3 		= s_rresp_3; 		 
assign m_rlast_3     = s_rlast_3;      
assign m_ruser_3 		= s_ruser_3; 		 
assign s_rready_3     = m_rready_3;

// AXIM Response port
assign m_bvalid_3    = s_bvalid_3;     
assign m_bid_3			  = s_bid_3;			   
assign m_bresp_3     = s_bresp_3;      
assign m_buser_3     = s_buser_3;      
assign s_bready_3     = m_bready_3;
