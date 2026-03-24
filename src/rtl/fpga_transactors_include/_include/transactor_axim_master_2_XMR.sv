//=================================================================================================================================
// AXI MEMORY connections - USER MUST EDIT THE RIGHT HAND SIDE OF THE FOLLOWING ASSIGNMENTS AND DEFINE - WHEN NEEDED
//=================================================================================================================================
// AXI MEMORY MASTER   connection #0

	  `define 	AXIM_MASTER_2 				fpga_transactors_top_inst          // example:  fpga_tcss_top.tcss_val_rtl.tcss.par_iom
  

 
`ifndef AXIM_EXTEND_DIRECT  // Indirect mode connection
     
   assign 	`TRANSACTORS_PATH.m_clk[2] 	 		= `AXIM_MASTER_2.m_clock_2; 
   assign 	`TRANSACTORS_PATH.m_rst_n[2]    = `AXIM_MASTER_2.m_rstn_2; 

// AXIM Address Write port
   assign   `AXIM_MASTER_2.m_awvalid_2     =  `TRANSACTORS_PATH.m_awvalid[2];
   assign   `AXIM_MASTER_2.m_awid_2        =  `TRANSACTORS_PATH.m_awid[2];   
   assign   `AXIM_MASTER_2.m_awaddr_2      =  `TRANSACTORS_PATH.m_awaddr[2]; 
   assign   `AXIM_MASTER_2.m_awlen_2       =  `TRANSACTORS_PATH.m_awlen[2];  
   assign   `AXIM_MASTER_2.m_awsize_2      =  `TRANSACTORS_PATH.m_awsize[2]; 
   assign   `AXIM_MASTER_2.m_awburst_2     =  `TRANSACTORS_PATH.m_awburst[2];
   assign   `AXIM_MASTER_2.m_awlock_2      =  `TRANSACTORS_PATH.m_awlock[2]; 
   assign   `AXIM_MASTER_2.m_awcache_2     =  `TRANSACTORS_PATH.m_awcache[2];
   assign   `AXIM_MASTER_2.m_awprot_2      =  `TRANSACTORS_PATH.m_awprot[2]; 
   assign   `AXIM_MASTER_2.m_awqos_2       =  `TRANSACTORS_PATH.m_awqos[2];  
   assign   `AXIM_MASTER_2.m_awregion_2    =  `TRANSACTORS_PATH.m_awregion[2];
   assign   `AXIM_MASTER_2.m_awuser_2      =  `TRANSACTORS_PATH.m_awuser[2]; 
   assign   `TRANSACTORS_PATH.m_awready[2] =  `AXIM_MASTER_2.m_awready_2;    

// AXIM  Write port 
   assign   `AXIM_MASTER_2.m_wvalid_2     =   `TRANSACTORS_PATH.m_wvalid[2]; 
   assign   `AXIM_MASTER_2.m_wid_2        =   `TRANSACTORS_PATH.m_wid[2];    
   assign   `AXIM_MASTER_2.m_wdata_2      =   `TRANSACTORS_PATH.m_wdata[1535:1024];	
   assign   `AXIM_MASTER_2.m_wstrb_2      =   `TRANSACTORS_PATH.m_wstrb[191:128];	
   assign   `AXIM_MASTER_2.m_wlast_2      =   `TRANSACTORS_PATH.m_wlast[2];  
   assign   `AXIM_MASTER_2.m_wuser_2      =   `TRANSACTORS_PATH.m_wuser[2];  
   assign   `TRANSACTORS_PATH.m_wready[2] =   `AXIM_MASTER_2.m_wready_2;     

// AXIM Address Read port
   assign   `AXIM_MASTER_2.m_arvalid_2     =   `TRANSACTORS_PATH.m_arvalid[2]; 
   assign   `AXIM_MASTER_2.m_arid_2        =   `TRANSACTORS_PATH.m_arid[2];    
   assign   `AXIM_MASTER_2.m_araddr_2      =   `TRANSACTORS_PATH.m_araddr[2];  
   assign   `AXIM_MASTER_2.m_arlen_2       =   `TRANSACTORS_PATH.m_arlen[2];   
   assign   `AXIM_MASTER_2.m_arsize_2      =   `TRANSACTORS_PATH.m_arsize[2];  
   assign   `AXIM_MASTER_2.m_arburst_2     =   `TRANSACTORS_PATH.m_arburst[2]; 
   assign   `AXIM_MASTER_2.m_arlock_2      =   `TRANSACTORS_PATH.m_arlock[2];  
   assign   `AXIM_MASTER_2.m_arcache_2     =   `TRANSACTORS_PATH.m_arcache[2]; 
   assign   `AXIM_MASTER_2.m_arprot_2      =   `TRANSACTORS_PATH.m_arprot[2];  
   assign   `AXIM_MASTER_2.m_arqos_2       =   `TRANSACTORS_PATH.m_arqos[2];   
   assign   `AXIM_MASTER_2.m_arregion_2     =  `TRANSACTORS_PATH.m_arregion[2]; 
   assign   `AXIM_MASTER_2.m_aruser_2      =   `TRANSACTORS_PATH.m_aruser[2];  
   assign   `TRANSACTORS_PATH.m_arready[2] =   `AXIM_MASTER_2.m_arready_2;     

// AXIM Read port    
   assign   `TRANSACTORS_PATH.m_rvalid[2]     =   `AXIM_MASTER_2.m_rvalid_2; 	    
   assign   `TRANSACTORS_PATH.m_rid[2]        =   `AXIM_MASTER_2.m_rid_2;          
   assign   `TRANSACTORS_PATH.m_rdata[1535:1024]      =   `AXIM_MASTER_2.m_rdata_2; 		    
   assign   `TRANSACTORS_PATH.m_rresp[2]      =   `AXIM_MASTER_2.m_rresp_2; 			  
   assign   `TRANSACTORS_PATH.m_rlast[2]      =   `AXIM_MASTER_2.m_rlast_2;     	  
   assign   `TRANSACTORS_PATH.m_ruser[2]      =   `AXIM_MASTER_2.m_ruser_2; 		 	  
   assign   `AXIM_MASTER_2.m_rready_2         =   `TRANSACTORS_PATH.m_rready[2]; 

//  AXIM Response port
   assign   `TRANSACTORS_PATH.m_bvalid[2] =  `AXIM_MASTER_2.m_bvalid_2;     
   assign   `TRANSACTORS_PATH.m_bid[2]    =  `AXIM_MASTER_2.m_bid_2;			  
   assign  	`TRANSACTORS_PATH.m_bresp[2]  =  `AXIM_MASTER_2.m_bresp_2;      
   assign   `TRANSACTORS_PATH.m_buser[2]  =  `AXIM_MASTER_2.m_buser_2;      
   assign   `AXIM_MASTER_2.m_bready_2     =  `TRANSACTORS_PATH.m_bready[2]; 

   `else  // Direct mode connection
          //------------------------------
   assign 	`TRANSACTORS_PATH.m_axi_clk 	 		= `AXIM_MASTER_2.m_axi_clk;
   assign 	`TRANSACTORS_PATH.m_axi_resetn    = `AXIM_MASTER_2.m_rstn_2; 
   
   // AXIM Address Write port
   assign   `AXIM_MASTER_2.m_awvalid_2     =  `TRANSACTORS_PATH.m_extend_axim_awvalid;
   assign   `AXIM_MASTER_2.m_awid_2        =  `TRANSACTORS_PATH.m_extend_axim_awid[3:0];
   assign   `AXIM_MASTER_2.m_awaddr_2      =  {4'b0,`TRANSACTORS_PATH.m_extend_axim_awaddr[27:0]};
   assign   `AXIM_MASTER_2.m_awlen_2       =  `TRANSACTORS_PATH.m_extend_axim_awlen;
   assign   `AXIM_MASTER_2.m_awsize_2      =  `TRANSACTORS_PATH.m_extend_axim_awsize;
   assign   `AXIM_MASTER_2.m_awburst_2     =  `TRANSACTORS_PATH.m_extend_axim_awburst;
   assign   `AXIM_MASTER_2.m_awlock_2      =  `TRANSACTORS_PATH.m_extend_axim_awlock;
   assign   `AXIM_MASTER_2.m_awcache_2     =  `TRANSACTORS_PATH.m_extend_axim_awcache;
   assign   `AXIM_MASTER_2.m_awprot_2      =  `TRANSACTORS_PATH.m_extend_axim_awprot;
   assign   `AXIM_MASTER_2.m_awqos_2       =  `TRANSACTORS_PATH.m_extend_axim_awqos;  
   assign   `AXIM_MASTER_2.m_awregion_2    =  `TRANSACTORS_PATH.m_extend_axim_awregion;
   assign   `AXIM_MASTER_2.m_awuser_2      =  'b0; 
   assign   `TRANSACTORS_PATH.m_extend_axim_awready =  `AXIM_MASTER_2.m_awready_2;  

// AXIM  Write port 
   assign   `AXIM_MASTER_2.m_wvalid_2     =   `TRANSACTORS_PATH.m_extend_axim_wvalid; 
  // assign   `AXIM_MASTER_2.m_wid_2        =   `TRANSACTORS_PATH.m_wid[2];    
   assign   `AXIM_MASTER_2.m_wdata_2      =   `TRANSACTORS_PATH.m_extend_axim_wdata;	
   assign   `AXIM_MASTER_2.m_wstrb_2      =   `TRANSACTORS_PATH.m_extend_axim_wstrb;	
   assign   `AXIM_MASTER_2.m_wlast_2      =   `TRANSACTORS_PATH.m_extend_axim_wlast;  
 //  assign   `AXIM_MASTER_2.m_wuser_2      =   `TRANSACTORS_PATH.m_wuser[2];  
   assign   `TRANSACTORS_PATH.m_extend_axim_wready =   `AXIM_MASTER_2.m_wready_2;     

// AXIM Address Read port
   assign   `AXIM_MASTER_2.m_arvalid_2     =   `TRANSACTORS_PATH.m_extend_axim_arvalid; 
   assign   `AXIM_MASTER_2.m_arid_2        =   `TRANSACTORS_PATH.m_extend_axim_arid[3:0];
   assign   `AXIM_MASTER_2.m_araddr_2      =   {4'b0,`TRANSACTORS_PATH.m_extend_axim_araddr[27:0]};
   assign   `AXIM_MASTER_2.m_arlen_2       =   `TRANSACTORS_PATH.m_extend_axim_arlen;
   assign   `AXIM_MASTER_2.m_arsize_2      =   `TRANSACTORS_PATH.m_extend_axim_arsize;
   assign   `AXIM_MASTER_2.m_arburst_2     =   `TRANSACTORS_PATH.m_extend_axim_arburst;
   assign   `AXIM_MASTER_2.m_arlock_2      =   `TRANSACTORS_PATH.m_extend_axim_arlock;
   assign   `AXIM_MASTER_2.m_arcache_2     =   `TRANSACTORS_PATH.m_extend_axim_arcache;
   assign   `AXIM_MASTER_2.m_arprot_2      =   `TRANSACTORS_PATH.m_extend_axim_arprot;
   assign   `AXIM_MASTER_2.m_arqos_2       =   `TRANSACTORS_PATH.m_extend_axim_arqos;
   assign   `AXIM_MASTER_2.m_arregion_2    =   `TRANSACTORS_PATH.m_extend_axim_arregion; 
   assign   `AXIM_MASTER_2.m_aruser_2      =   'b0;  
   assign   `TRANSACTORS_PATH.m_extend_axim_arready =   `AXIM_MASTER_2.m_arready_2;     

// AXIM Read port    
   assign   `TRANSACTORS_PATH.m_extend_axim_rvalid     =   `AXIM_MASTER_2.m_rvalid_2; 	    
   assign   `TRANSACTORS_PATH.m_extend_axim_rid        =   `AXIM_MASTER_2.m_rid_2;          
   assign   `TRANSACTORS_PATH.m_extend_axim_rdata      =   `AXIM_MASTER_2.m_rdata_2; 		    
   assign   `TRANSACTORS_PATH.m_extend_axim_rresp      =   `AXIM_MASTER_2.m_rresp_2; 			  
   assign   `TRANSACTORS_PATH.m_extend_axim_rlast      =   `AXIM_MASTER_2.m_rlast_2;     	  
   //assign   `TRANSACTORS_PATH.m_ruser[2]      =   `AXIM_MASTER_2.m_ruser_2; 		 	  
   assign   `AXIM_MASTER_2.m_rready_2         =   `TRANSACTORS_PATH.m_extend_axim_rready; 
 
 //  AXIM Response port
   assign   `TRANSACTORS_PATH.m_extend_axim_bvalid =  `AXIM_MASTER_2.m_bvalid_2;     
   assign   `TRANSACTORS_PATH.m_extend_axim_bid    =  `AXIM_MASTER_2.m_bid_2[3:0];			  
   assign  	`TRANSACTORS_PATH.m_extend_axim_bresp  =  `AXIM_MASTER_2.m_bresp_2;      
   assign   `AXIM_MASTER_2.m_bready_2              =  `TRANSACTORS_PATH.m_extend_axim_bready; 
  
   `endif
