//=================================================================================================================================
// AXI MEMORY connections - USER MUST EDIT THE RIGHT HAND SIDE OF THE FOLLOWING ASSIGNMENTS AND DEFINE - WHEN NEEDED
//=================================================================================================================================
// AXI MEMORY MASTER   connection #0

	  `define 	AXIM_SLAVE_0 				`FPGA_TRANSACTORS_TOP          // example:  fpga_tcss_top.tcss_val_rtl.tcss.par_iom
  

 
`ifndef AXIM_EXTEND_DIRECT  // Indirect mode connection
     
   assign 	`TRANSACTORS_PATH.m_clk[0] 	 		= `AXIM_SLAVE_0.m_clock_0; 
   assign 	`TRANSACTORS_PATH.m_rst_n[0]    = `AXIM_SLAVE_0.m_rstn_0; 

// AXIM Address Write port
   assign   `AXIM_SLAVE_0.m_awvalid_0     =  `TRANSACTORS_PATH.m_awvalid[0];
   assign   `AXIM_SLAVE_0.m_awid_0        =  `TRANSACTORS_PATH.m_awid[0];   
   assign   `AXIM_SLAVE_0.m_awaddr_0      =  `TRANSACTORS_PATH.m_awaddr[0]; 
   assign   `AXIM_SLAVE_0.m_awlen_0       =  `TRANSACTORS_PATH.m_awlen[0];  
   assign   `AXIM_SLAVE_0.m_awsize_0      =  `TRANSACTORS_PATH.m_awsize[0]; 
   assign   `AXIM_SLAVE_0.m_awburst_0     =  `TRANSACTORS_PATH.m_awburst[0];
   assign   `AXIM_SLAVE_0.m_awlock_0      =  `TRANSACTORS_PATH.m_awlock[0]; 
   assign   `AXIM_SLAVE_0.m_awcache_0     =  `TRANSACTORS_PATH.m_awcache[0];
   assign   `AXIM_SLAVE_0.m_awprot_0      =  `TRANSACTORS_PATH.m_awprot[0]; 
   assign   `AXIM_SLAVE_0.m_awqos_0       =  `TRANSACTORS_PATH.m_awqos[0];  
   assign   `AXIM_SLAVE_0.m_awregion_0    =  `TRANSACTORS_PATH.m_awregion[0];
   assign   `AXIM_SLAVE_0.m_awuser_0      =  `TRANSACTORS_PATH.m_awuser[0]; 
   assign   `TRANSACTORS_PATH.m_awready[0] =  `AXIM_SLAVE_0.m_awready_0;    

// AXIM  Write port 
   assign   `AXIM_SLAVE_0.m_wvalid_0     =   `TRANSACTORS_PATH.m_wvalid[0]; 
   assign   `AXIM_SLAVE_0.m_wid_0        =   `TRANSACTORS_PATH.m_wid[0];    
   assign   `AXIM_SLAVE_0.m_wdata_0      =   `TRANSACTORS_PATH.m_wdata[1023:0];	
   assign   `AXIM_SLAVE_0.m_wstrb_0      =   `TRANSACTORS_PATH.m_wstrb[127:0];	
   assign   `AXIM_SLAVE_0.m_wlast_0      =   `TRANSACTORS_PATH.m_wlast[0];  
   assign   `AXIM_SLAVE_0.m_wuser_0      =   `TRANSACTORS_PATH.m_wuser[0];  
   assign   `TRANSACTORS_PATH.m_wready[0] =   `AXIM_SLAVE_0.m_wready_0;     

// AXIM Address Read port
   assign   `AXIM_SLAVE_0.m_arvalid_0     =   `TRANSACTORS_PATH.m_arvalid[0]; 
   assign   `AXIM_SLAVE_0.m_arid_0        =   `TRANSACTORS_PATH.m_arid[0];    
   assign   `AXIM_SLAVE_0.m_araddr_0      =   `TRANSACTORS_PATH.m_araddr[0];  
   assign   `AXIM_SLAVE_0.m_arlen_0       =   `TRANSACTORS_PATH.m_arlen[0];   
   assign   `AXIM_SLAVE_0.m_arsize_0      =   `TRANSACTORS_PATH.m_arsize[0];  
   assign   `AXIM_SLAVE_0.m_arburst_0     =   `TRANSACTORS_PATH.m_arburst[0]; 
   assign   `AXIM_SLAVE_0.m_arlock_0      =   `TRANSACTORS_PATH.m_arlock[0];  
   assign   `AXIM_SLAVE_0.m_arcache_0     =   `TRANSACTORS_PATH.m_arcache[0]; 
   assign   `AXIM_SLAVE_0.m_arprot_0      =   `TRANSACTORS_PATH.m_arprot[0];  
   assign   `AXIM_SLAVE_0.m_arqos_0       =   `TRANSACTORS_PATH.m_arqos[0];   
   assign   `AXIM_SLAVE_0.m_arregion_0     =  `TRANSACTORS_PATH.m_arregion[0]; 
   assign   `AXIM_SLAVE_0.m_aruser_0      =   `TRANSACTORS_PATH.m_aruser[0];  
   assign   `TRANSACTORS_PATH.m_arready[0] =   `AXIM_SLAVE_0.m_arready_0;     

// AXIM Read port    
   assign   `TRANSACTORS_PATH.m_rvalid[0]     =   `AXIM_SLAVE_0.m_rvalid_0; 	    
   assign   `TRANSACTORS_PATH.m_rid[0]        =   `AXIM_SLAVE_0.m_rid_0;          
   assign   `TRANSACTORS_PATH.m_rdata[1023:0]      =   `AXIM_SLAVE_0.m_rdata_0; 		    
   assign   `TRANSACTORS_PATH.m_rresp[0]      =   `AXIM_SLAVE_0.m_rresp_0; 			  
   assign   `TRANSACTORS_PATH.m_rlast[0]      =   `AXIM_SLAVE_0.m_rlast_0;     	  
   assign   `TRANSACTORS_PATH.m_ruser[0]      =   `AXIM_SLAVE_0.m_ruser_0; 		 	  
   assign   `AXIM_SLAVE_0.m_rready_0         =   `TRANSACTORS_PATH.m_rready[0]; 

//  AXIM Response port
   assign   `TRANSACTORS_PATH.m_bvalid[0] =  `AXIM_SLAVE_0.m_bvalid_0;     
   assign   `TRANSACTORS_PATH.m_bid[0]    =  `AXIM_SLAVE_0.m_bid_0;			  
   assign  	`TRANSACTORS_PATH.m_bresp[0]  =  `AXIM_SLAVE_0.m_bresp_0;      
   assign   `TRANSACTORS_PATH.m_buser[0]  =  `AXIM_SLAVE_0.m_buser_0;      
   assign   `AXIM_SLAVE_0.m_bready_0     =  `TRANSACTORS_PATH.m_bready[0]; 

   `else  // Direct mode connection
          //------------------------------
   assign 	`TRANSACTORS_PATH.m_axi_clk 	 		= `AXIM_SLAVE_0.m_axi_clk;
   assign 	`TRANSACTORS_PATH.m_axi_resetn    = `AXIM_SLAVE_0.m_rstn_0; 
   
   // AXIM Address Write port
   assign   `AXIM_SLAVE_0.m_awvalid_0     =  `TRANSACTORS_PATH.m_extend_axim_awvalid;
   assign   `AXIM_SLAVE_0.m_awid_0        =  `TRANSACTORS_PATH.m_extend_axim_awid[3:0];
   assign   `AXIM_SLAVE_0.m_awaddr_0      =  {4'b0,`TRANSACTORS_PATH.m_extend_axim_awaddr[27:0]};
   assign   `AXIM_SLAVE_0.m_awlen_0       =  `TRANSACTORS_PATH.m_extend_axim_awlen;
   assign   `AXIM_SLAVE_0.m_awsize_0      =  `TRANSACTORS_PATH.m_extend_axim_awsize;
   assign   `AXIM_SLAVE_0.m_awburst_0     =  `TRANSACTORS_PATH.m_extend_axim_awburst;
   assign   `AXIM_SLAVE_0.m_awlock_0      =  `TRANSACTORS_PATH.m_extend_axim_awlock;
   assign   `AXIM_SLAVE_0.m_awcache_0     =  `TRANSACTORS_PATH.m_extend_axim_awcache;
   assign   `AXIM_SLAVE_0.m_awprot_0      =  `TRANSACTORS_PATH.m_extend_axim_awprot;
   assign   `AXIM_SLAVE_0.m_awqos_0       =  `TRANSACTORS_PATH.m_extend_axim_awqos;  
   assign   `AXIM_SLAVE_0.m_awregion_0    =  `TRANSACTORS_PATH.m_extend_axim_awregion;
   assign   `AXIM_SLAVE_0.m_awuser_0      =  'b0; 
   assign   `TRANSACTORS_PATH.m_extend_axim_awready =  `AXIM_SLAVE_0.m_awready_0;  

// AXIM  Write port 
   assign   `AXIM_SLAVE_0.m_wvalid_0     =   `TRANSACTORS_PATH.m_extend_axim_wvalid; 
  // assign   `AXIM_SLAVE_0.m_wid_0        =   `TRANSACTORS_PATH.m_wid[0];    
   assign   `AXIM_SLAVE_0.m_wdata_0      =   `TRANSACTORS_PATH.m_extend_axim_wdata;	
   assign   `AXIM_SLAVE_0.m_wstrb_0      =   `TRANSACTORS_PATH.m_extend_axim_wstrb;	
   assign   `AXIM_SLAVE_0.m_wlast_0      =   `TRANSACTORS_PATH.m_extend_axim_wlast;  
 //  assign   `AXIM_SLAVE_0.m_wuser_0      =   `TRANSACTORS_PATH.m_wuser[0];  
   assign   `TRANSACTORS_PATH.m_extend_axim_wready =   `AXIM_SLAVE_0.m_wready_0;     

// AXIM Address Read port
   assign   `AXIM_SLAVE_0.m_arvalid_0     =   `TRANSACTORS_PATH.m_extend_axim_arvalid; 
   assign   `AXIM_SLAVE_0.m_arid_0        =   `TRANSACTORS_PATH.m_extend_axim_arid[3:0];
   assign   `AXIM_SLAVE_0.m_araddr_0      =   {4'b0,`TRANSACTORS_PATH.m_extend_axim_araddr[27:0]};
   assign   `AXIM_SLAVE_0.m_arlen_0       =   `TRANSACTORS_PATH.m_extend_axim_arlen;
   assign   `AXIM_SLAVE_0.m_arsize_0      =   `TRANSACTORS_PATH.m_extend_axim_arsize;
   assign   `AXIM_SLAVE_0.m_arburst_0     =   `TRANSACTORS_PATH.m_extend_axim_arburst;
   assign   `AXIM_SLAVE_0.m_arlock_0      =   `TRANSACTORS_PATH.m_extend_axim_arlock;
   assign   `AXIM_SLAVE_0.m_arcache_0     =   `TRANSACTORS_PATH.m_extend_axim_arcache;
   assign   `AXIM_SLAVE_0.m_arprot_0      =   `TRANSACTORS_PATH.m_extend_axim_arprot;
   assign   `AXIM_SLAVE_0.m_arqos_0       =   `TRANSACTORS_PATH.m_extend_axim_arqos;
   assign   `AXIM_SLAVE_0.m_arregion_0    =   `TRANSACTORS_PATH.m_extend_axim_arregion; 
   assign   `AXIM_SLAVE_0.m_aruser_0      =   'b0;  
   assign   `TRANSACTORS_PATH.m_extend_axim_arready =   `AXIM_SLAVE_0.m_arready_0;     

// AXIM Read port    
   assign   `TRANSACTORS_PATH.m_extend_axim_rvalid     =   `AXIM_SLAVE_0.m_rvalid_0; 	    
   assign   `TRANSACTORS_PATH.m_extend_axim_rid        =   `AXIM_SLAVE_0.m_rid_0;          
   assign   `TRANSACTORS_PATH.m_extend_axim_rdata      =   `AXIM_SLAVE_0.m_rdata_0; 		    
   assign   `TRANSACTORS_PATH.m_extend_axim_rresp      =   `AXIM_SLAVE_0.m_rresp_0; 			  
   assign   `TRANSACTORS_PATH.m_extend_axim_rlast      =   `AXIM_SLAVE_0.m_rlast_0;     	  
   //assign   `TRANSACTORS_PATH.m_ruser[0]      =   `AXIM_SLAVE_0.m_ruser_0; 		 	  
   assign   `AXIM_SLAVE_0.m_rready_0         =   `TRANSACTORS_PATH.m_extend_axim_rready; 
 
 //  AXIM Response port
   assign   `TRANSACTORS_PATH.m_extend_axim_bvalid =  `AXIM_SLAVE_0.m_bvalid_0;     
   assign   `TRANSACTORS_PATH.m_extend_axim_bid    =  `AXIM_SLAVE_0.m_bid_0[3:0];			  
   assign  	`TRANSACTORS_PATH.m_extend_axim_bresp  =  `AXIM_SLAVE_0.m_bresp_0;      
   assign   `AXIM_SLAVE_0.m_bready_0              =  `TRANSACTORS_PATH.m_extend_axim_bready; 
  
   `endif
