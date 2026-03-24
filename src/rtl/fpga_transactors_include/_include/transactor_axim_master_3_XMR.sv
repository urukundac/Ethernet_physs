//=================================================================================================================================
// AXI MEMORY connections - USER MUST EDIT THE RIGHT HAND SIDE OF THE FOLLOWING ASSIGNMENTS AND DEFINE - WHEN NEEDED
//=================================================================================================================================
// AXI MEMORY MASTER   connection #0

	  `define 	AXIM_MASTER_3 				fpga_transactors_top_inst          // example:  fpga_tcss_top.tcss_val_rtl.tcss.par_iom
  

 
`ifndef AXIM_EXTEND_DIRECT  // Indirect mode connection
     
   assign 	`TRANSACTORS_PATH.m_clk[3] 	 		= `AXIM_MASTER_3.m_clock_3; 
   assign 	`TRANSACTORS_PATH.m_rst_n[3]    = `AXIM_MASTER_3.m_rstn_3; 

// AXIM Address Write port
   assign   `AXIM_MASTER_3.m_awvalid_3     =  `TRANSACTORS_PATH.m_awvalid[3];
   assign   `AXIM_MASTER_3.m_awid_3        =  `TRANSACTORS_PATH.m_awid[3];   
   assign   `AXIM_MASTER_3.m_awaddr_3      =  `TRANSACTORS_PATH.m_awaddr[3]; 
   assign   `AXIM_MASTER_3.m_awlen_3       =  `TRANSACTORS_PATH.m_awlen[3];  
   assign   `AXIM_MASTER_3.m_awsize_3      =  `TRANSACTORS_PATH.m_awsize[3]; 
   assign   `AXIM_MASTER_3.m_awburst_3     =  `TRANSACTORS_PATH.m_awburst[3];
   assign   `AXIM_MASTER_3.m_awlock_3      =  `TRANSACTORS_PATH.m_awlock[3]; 
   assign   `AXIM_MASTER_3.m_awcache_3     =  `TRANSACTORS_PATH.m_awcache[3];
   assign   `AXIM_MASTER_3.m_awprot_3      =  `TRANSACTORS_PATH.m_awprot[3]; 
   assign   `AXIM_MASTER_3.m_awqos_3       =  `TRANSACTORS_PATH.m_awqos[3];  
   assign   `AXIM_MASTER_3.m_awregion_3    =  `TRANSACTORS_PATH.m_awregion[3];
   assign   `AXIM_MASTER_3.m_awuser_3      =  `TRANSACTORS_PATH.m_awuser[3]; 
   assign   `TRANSACTORS_PATH.m_awready[3] =  `AXIM_MASTER_3.m_awready_3;    

// AXIM  Write port 
   assign   `AXIM_MASTER_3.m_wvalid_3     =   `TRANSACTORS_PATH.m_wvalid[3]; 
   assign   `AXIM_MASTER_3.m_wid_3        =   `TRANSACTORS_PATH.m_wid[3];    
   assign   `AXIM_MASTER_3.m_wdata_3      =   `TRANSACTORS_PATH.m_wdata[2047:1536];	
   assign   `AXIM_MASTER_3.m_wstrb_3      =   `TRANSACTORS_PATH.m_wstrb[255:192];	
   assign   `AXIM_MASTER_3.m_wlast_3      =   `TRANSACTORS_PATH.m_wlast[3];  
   assign   `AXIM_MASTER_3.m_wuser_3      =   `TRANSACTORS_PATH.m_wuser[3];  
   assign   `TRANSACTORS_PATH.m_wready[3] =   `AXIM_MASTER_3.m_wready_3;     

// AXIM Address Read port
   assign   `AXIM_MASTER_3.m_arvalid_3     =   `TRANSACTORS_PATH.m_arvalid[3]; 
   assign   `AXIM_MASTER_3.m_arid_3        =   `TRANSACTORS_PATH.m_arid[3];    
   assign   `AXIM_MASTER_3.m_araddr_3      =   `TRANSACTORS_PATH.m_araddr[3];  
   assign   `AXIM_MASTER_3.m_arlen_3       =   `TRANSACTORS_PATH.m_arlen[3];   
   assign   `AXIM_MASTER_3.m_arsize_3      =   `TRANSACTORS_PATH.m_arsize[3];  
   assign   `AXIM_MASTER_3.m_arburst_3     =   `TRANSACTORS_PATH.m_arburst[3]; 
   assign   `AXIM_MASTER_3.m_arlock_3      =   `TRANSACTORS_PATH.m_arlock[3];  
   assign   `AXIM_MASTER_3.m_arcache_3     =   `TRANSACTORS_PATH.m_arcache[3]; 
   assign   `AXIM_MASTER_3.m_arprot_3      =   `TRANSACTORS_PATH.m_arprot[3];  
   assign   `AXIM_MASTER_3.m_arqos_3       =   `TRANSACTORS_PATH.m_arqos[3];   
   assign   `AXIM_MASTER_3.m_arregion_3     =  `TRANSACTORS_PATH.m_arregion[3]; 
   assign   `AXIM_MASTER_3.m_aruser_3      =   `TRANSACTORS_PATH.m_aruser[3];  
   assign   `TRANSACTORS_PATH.m_arready[3] =   `AXIM_MASTER_3.m_arready_3;     

// AXIM Read port    
   assign   `TRANSACTORS_PATH.m_rvalid[3]     =   `AXIM_MASTER_3.m_rvalid_3; 	    
   assign   `TRANSACTORS_PATH.m_rid[3]        =   `AXIM_MASTER_3.m_rid_3;          
   assign   `TRANSACTORS_PATH.m_rdata[2047:1536]      =   `AXIM_MASTER_3.m_rdata_3; 		    
   assign   `TRANSACTORS_PATH.m_rresp[3]      =   `AXIM_MASTER_3.m_rresp_3; 			  
   assign   `TRANSACTORS_PATH.m_rlast[3]      =   `AXIM_MASTER_3.m_rlast_3;     	  
   assign   `TRANSACTORS_PATH.m_ruser[3]      =   `AXIM_MASTER_3.m_ruser_3; 		 	  
   assign   `AXIM_MASTER_3.m_rready_3         =   `TRANSACTORS_PATH.m_rready[3]; 

//  AXIM Response port
   assign   `TRANSACTORS_PATH.m_bvalid[3] =  `AXIM_MASTER_3.m_bvalid_3;     
   assign   `TRANSACTORS_PATH.m_bid[3]    =  `AXIM_MASTER_3.m_bid_3;			  
   assign  	`TRANSACTORS_PATH.m_bresp[3]  =  `AXIM_MASTER_3.m_bresp_3;      
   assign   `TRANSACTORS_PATH.m_buser[3]  =  `AXIM_MASTER_3.m_buser_3;      
   assign   `AXIM_MASTER_3.m_bready_3     =  `TRANSACTORS_PATH.m_bready[3]; 

   `else  // Direct mode connection
          //------------------------------
   assign 	`TRANSACTORS_PATH.m_axi_clk 	 		= `AXIM_MASTER_3.m_axi_clk;
   assign 	`TRANSACTORS_PATH.m_axi_resetn    = `AXIM_MASTER_3.m_rstn_3; 
   
   // AXIM Address Write port
   assign   `AXIM_MASTER_3.m_awvalid_3     =  `TRANSACTORS_PATH.m_extend_axim_awvalid;
   assign   `AXIM_MASTER_3.m_awid_3        =  `TRANSACTORS_PATH.m_extend_axim_awid[3:0];
   assign   `AXIM_MASTER_3.m_awaddr_3      =  {4'b0,`TRANSACTORS_PATH.m_extend_axim_awaddr[27:0]};
   assign   `AXIM_MASTER_3.m_awlen_3       =  `TRANSACTORS_PATH.m_extend_axim_awlen;
   assign   `AXIM_MASTER_3.m_awsize_3      =  `TRANSACTORS_PATH.m_extend_axim_awsize;
   assign   `AXIM_MASTER_3.m_awburst_3     =  `TRANSACTORS_PATH.m_extend_axim_awburst;
   assign   `AXIM_MASTER_3.m_awlock_3      =  `TRANSACTORS_PATH.m_extend_axim_awlock;
   assign   `AXIM_MASTER_3.m_awcache_3     =  `TRANSACTORS_PATH.m_extend_axim_awcache;
   assign   `AXIM_MASTER_3.m_awprot_3      =  `TRANSACTORS_PATH.m_extend_axim_awprot;
   assign   `AXIM_MASTER_3.m_awqos_3       =  `TRANSACTORS_PATH.m_extend_axim_awqos;  
   assign   `AXIM_MASTER_3.m_awregion_3    =  `TRANSACTORS_PATH.m_extend_axim_awregion;
   assign   `AXIM_MASTER_3.m_awuser_3      =  'b0; 
   assign   `TRANSACTORS_PATH.m_extend_axim_awready =  `AXIM_MASTER_3.m_awready_3;  

// AXIM  Write port 
   assign   `AXIM_MASTER_3.m_wvalid_3     =   `TRANSACTORS_PATH.m_extend_axim_wvalid; 
  // assign   `AXIM_MASTER_3.m_wid_3        =   `TRANSACTORS_PATH.m_wid[3];    
   assign   `AXIM_MASTER_3.m_wdata_3      =   `TRANSACTORS_PATH.m_extend_axim_wdata;	
   assign   `AXIM_MASTER_3.m_wstrb_3      =   `TRANSACTORS_PATH.m_extend_axim_wstrb;	
   assign   `AXIM_MASTER_3.m_wlast_3      =   `TRANSACTORS_PATH.m_extend_axim_wlast;  
 //  assign   `AXIM_MASTER_3.m_wuser_3      =   `TRANSACTORS_PATH.m_wuser[3];  
   assign   `TRANSACTORS_PATH.m_extend_axim_wready =   `AXIM_MASTER_3.m_wready_3;     

// AXIM Address Read port
   assign   `AXIM_MASTER_3.m_arvalid_3     =   `TRANSACTORS_PATH.m_extend_axim_arvalid; 
   assign   `AXIM_MASTER_3.m_arid_3        =   `TRANSACTORS_PATH.m_extend_axim_arid[3:0];
   assign   `AXIM_MASTER_3.m_araddr_3      =   {4'b0,`TRANSACTORS_PATH.m_extend_axim_araddr[27:0]};
   assign   `AXIM_MASTER_3.m_arlen_3       =   `TRANSACTORS_PATH.m_extend_axim_arlen;
   assign   `AXIM_MASTER_3.m_arsize_3      =   `TRANSACTORS_PATH.m_extend_axim_arsize;
   assign   `AXIM_MASTER_3.m_arburst_3     =   `TRANSACTORS_PATH.m_extend_axim_arburst;
   assign   `AXIM_MASTER_3.m_arlock_3      =   `TRANSACTORS_PATH.m_extend_axim_arlock;
   assign   `AXIM_MASTER_3.m_arcache_3     =   `TRANSACTORS_PATH.m_extend_axim_arcache;
   assign   `AXIM_MASTER_3.m_arprot_3      =   `TRANSACTORS_PATH.m_extend_axim_arprot;
   assign   `AXIM_MASTER_3.m_arqos_3       =   `TRANSACTORS_PATH.m_extend_axim_arqos;
   assign   `AXIM_MASTER_3.m_arregion_3    =   `TRANSACTORS_PATH.m_extend_axim_arregion; 
   assign   `AXIM_MASTER_3.m_aruser_3      =   'b0;  
   assign   `TRANSACTORS_PATH.m_extend_axim_arready =   `AXIM_MASTER_3.m_arready_3;     

// AXIM Read port    
   assign   `TRANSACTORS_PATH.m_extend_axim_rvalid     =   `AXIM_MASTER_3.m_rvalid_3; 	    
   assign   `TRANSACTORS_PATH.m_extend_axim_rid        =   `AXIM_MASTER_3.m_rid_3;          
   assign   `TRANSACTORS_PATH.m_extend_axim_rdata      =   `AXIM_MASTER_3.m_rdata_3; 		    
   assign   `TRANSACTORS_PATH.m_extend_axim_rresp      =   `AXIM_MASTER_3.m_rresp_3; 			  
   assign   `TRANSACTORS_PATH.m_extend_axim_rlast      =   `AXIM_MASTER_3.m_rlast_3;     	  
   //assign   `TRANSACTORS_PATH.m_ruser[3]      =   `AXIM_MASTER_3.m_ruser_3; 		 	  
   assign   `AXIM_MASTER_3.m_rready_3         =   `TRANSACTORS_PATH.m_extend_axim_rready; 
 
 //  AXIM Response port
   assign   `TRANSACTORS_PATH.m_extend_axim_bvalid =  `AXIM_MASTER_3.m_bvalid_3;     
   assign   `TRANSACTORS_PATH.m_extend_axim_bid    =  `AXIM_MASTER_3.m_bid_3[3:0];			  
   assign  	`TRANSACTORS_PATH.m_extend_axim_bresp  =  `AXIM_MASTER_3.m_bresp_3;      
   assign   `AXIM_MASTER_3.m_bready_3              =  `TRANSACTORS_PATH.m_extend_axim_bready; 
  
   `endif
