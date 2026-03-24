// Loop back connection for SA simulation and Synthesis
`define 	AXIM_MASTER_2 				fpga_transactors_top_inst       // example:  fpga_tcss_top.tcss_val_rtl.tcss.par_iom
`define 	AXIM_SLAVE_2 					fpga_transactors_top_inst       // example:  fpga_tcss_top.tcss_val_rtl.tcss.par_iom

// AXIM Addreaa Write port
assign s_awvalid_2    = m_awvalid_2;    
assign s_awid_2       = m_awid_2;       
assign s_awaddr_2     = m_awaddr_2;     
assign s_awlen_2      = m_awlen_2;      
assign s_awsize_2     = m_awsize_2;     
assign s_awburst_2    = m_awburst_2;    
assign s_awlock_2     = m_awlock_2;     
assign s_awcache_2    = m_awcache_2;    
assign s_awprot_2     = m_awprot_2;     
assign s_awqos_2      = m_awqos_2;      
assign s_awregion_2   = m_awregion_2;    
assign s_awuser_2     = m_awuser_2;     
assign m_awready_2   = s_awready_2;

// AXIM Write port
assign s_wvalid_2     = m_wvalid_2;    
assign s_wid_2        = m_wid_2;       
assign s_wdata_2      = m_wdata_2;     
assign s_wstrb_2      = m_wstrb_2;     
assign s_wlast_2      = m_wlast_2;     
assign s_wuser_2      = m_wuser_2;     
assign m_wready_2    = s_wready_2;

// AXIM Addreaa Read port
assign s_arvalid_2    = m_arvalid_2; 
assign s_arid_2       = m_arid_2;    
assign s_araddr_2     = m_araddr_2;  
assign s_arlen_2      = m_arlen_2;   
assign s_arsize_2     = m_arsize_2;  
assign s_arburst_2    = m_arburst_2; 
assign s_arlock_2     = m_arlock_2;  
assign s_arcache_2    = m_arcache_2; 
assign s_arprot_2     = m_arprot_2;  
assign s_arqos_2      = m_arqos_2;   
assign s_arregion_2   = m_arregion_2; 
assign s_aruser_2     = m_aruser_2;  
assign m_arready_2   = s_arready_2;

// AXIM Read port  
assign m_rvalid_2 	  = s_rvalid_2; 	   
assign m_rid_2       = s_rid_2;        
assign m_rdata_2 		= s_rdata_2; 		 
assign m_rresp_2 		= s_rresp_2; 		 
assign m_rlast_2     = s_rlast_2;      
assign m_ruser_2 		= s_ruser_2; 		 
assign s_rready_2     = m_rready_2;

// AXIM Response port
assign m_bvalid_2    = s_bvalid_2;     
assign m_bid_2			  = s_bid_2;			   
assign m_bresp_2     = s_bresp_2;      
assign m_buser_2     = s_buser_2;      
assign s_bready_2     = m_bready_2;
