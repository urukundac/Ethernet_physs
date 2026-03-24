//=================================================================================================================================
// AXI MEMORY connections - USER MUST EDIT THE RIGHT HAND SIDE OF THE FOLLOWING ASSIGNMENTS AND DEFINE - WHEN NEEDED
//=================================================================================================================================
// AXI MEMORY MASTER   connection #0

	  `define 	AXIM_MASTER_1 				`FPGA_TRANSACTORS_TOP          // example:  fpga_tcss_top.tcss_val_rtl.tcss.par_iom
  

 
`ifndef AXIM_EXTEND_DIRECT  // Indirect mode connection
     
   assign 	`TRANSACTORS_PATH.m_clk[1] 	 		= `AXIM_MASTER_1.m_clock_1; 
   assign 	`TRANSACTORS_PATH.m_rst_n[1]    = `AXIM_MASTER_1.m_rstn_1; 

// AXIM Address Write port
   assign   `AXIM_MASTER_1.m_awvalid_1     =  `TRANSACTORS_PATH.m_awvalid[1];
   assign   `AXIM_MASTER_1.m_awid_1        =  `TRANSACTORS_PATH.m_awid[1];   
   assign   `AXIM_MASTER_1.m_awaddr_1      =  `TRANSACTORS_PATH.m_awaddr[1]; 
   assign   `AXIM_MASTER_1.m_awlen_1       =  `TRANSACTORS_PATH.m_awlen[1];  
   assign   `AXIM_MASTER_1.m_awsize_1      =  `TRANSACTORS_PATH.m_awsize[1]; 
   assign   `AXIM_MASTER_1.m_awburst_1     =  `TRANSACTORS_PATH.m_awburst[1];
   assign   `AXIM_MASTER_1.m_awlock_1      =  `TRANSACTORS_PATH.m_awlock[1]; 
   assign   `AXIM_MASTER_1.m_awcache_1     =  `TRANSACTORS_PATH.m_awcache[1];
   assign   `AXIM_MASTER_1.m_awprot_1      =  `TRANSACTORS_PATH.m_awprot[1]; 
   assign   `AXIM_MASTER_1.m_awqos_1       =  `TRANSACTORS_PATH.m_awqos[1];  
   assign   `AXIM_MASTER_1.m_awregion_1    =  `TRANSACTORS_PATH.m_awregion[1];
   assign   `AXIM_MASTER_1.m_awuser_1      =  `TRANSACTORS_PATH.m_awuser[1]; 
   assign   `TRANSACTORS_PATH.m_awready[1] =  `AXIM_MASTER_1.m_awready_1;    

// AXIM  Write port 
   assign   `AXIM_MASTER_1.m_wvalid_1     =   `TRANSACTORS_PATH.m_wvalid[1]; 
   assign   `AXIM_MASTER_1.m_wid_1        =   `TRANSACTORS_PATH.m_wid[1];    
   assign   `AXIM_MASTER_1.m_wdata_1      =   `TRANSACTORS_PATH.m_wdata[2047:1024];	
   assign   `AXIM_MASTER_1.m_wstrb_1      =   `TRANSACTORS_PATH.m_wstrb[255:128];	
   assign   `AXIM_MASTER_1.m_wlast_1      =   `TRANSACTORS_PATH.m_wlast[1];  
   assign   `AXIM_MASTER_1.m_wuser_1      =   `TRANSACTORS_PATH.m_wuser[1];  
   assign   `TRANSACTORS_PATH.m_wready[1] =   `AXIM_MASTER_1.m_wready_1;     

// AXIM Address Read port
   assign   `AXIM_MASTER_1.m_arvalid_1     =   `TRANSACTORS_PATH.m_arvalid[1]; 
   assign   `AXIM_MASTER_1.m_arid_1        =   `TRANSACTORS_PATH.m_arid[1];    
   assign   `AXIM_MASTER_1.m_araddr_1      =   `TRANSACTORS_PATH.m_araddr[1];  
   assign   `AXIM_MASTER_1.m_arlen_1       =   `TRANSACTORS_PATH.m_arlen[1];   
   assign   `AXIM_MASTER_1.m_arsize_1      =   `TRANSACTORS_PATH.m_arsize[1];  
   assign   `AXIM_MASTER_1.m_arburst_1     =   `TRANSACTORS_PATH.m_arburst[1]; 
   assign   `AXIM_MASTER_1.m_arlock_1      =   `TRANSACTORS_PATH.m_arlock[1];  
   assign   `AXIM_MASTER_1.m_arcache_1     =   `TRANSACTORS_PATH.m_arcache[1]; 
   assign   `AXIM_MASTER_1.m_arprot_1      =   `TRANSACTORS_PATH.m_arprot[1];  
   assign   `AXIM_MASTER_1.m_arqos_1       =   `TRANSACTORS_PATH.m_arqos[1];   
   assign   `AXIM_MASTER_1.m_arregion_1     =  `TRANSACTORS_PATH.m_arregion[1]; 
   assign   `AXIM_MASTER_1.m_aruser_1      =   `TRANSACTORS_PATH.m_aruser[1];  
   assign   `TRANSACTORS_PATH.m_arready[1] =   `AXIM_MASTER_1.m_arready_1;     

// AXIM Read port    
   assign   `TRANSACTORS_PATH.m_rvalid[1]     =   `AXIM_MASTER_1.m_rvalid_1; 	    
   assign   `TRANSACTORS_PATH.m_rid[1]        =   `AXIM_MASTER_1.m_rid_1;          
   assign   `TRANSACTORS_PATH.m_rdata[2047:1024]      =   `AXIM_MASTER_1.m_rdata_1; 		    
   assign   `TRANSACTORS_PATH.m_rresp[1]      =   `AXIM_MASTER_1.m_rresp_1; 			  
   assign   `TRANSACTORS_PATH.m_rlast[1]      =   `AXIM_MASTER_1.m_rlast_1;     	  
   assign   `TRANSACTORS_PATH.m_ruser[1]      =   `AXIM_MASTER_1.m_ruser_1; 		 	  
   assign   `AXIM_MASTER_1.m_rready_1         =   `TRANSACTORS_PATH.m_rready[1]; 

//  AXIM Response port
   assign   `TRANSACTORS_PATH.m_bvalid[1] =  `AXIM_MASTER_1.m_bvalid_1;     
   assign   `TRANSACTORS_PATH.m_bid[1]    =  `AXIM_MASTER_1.m_bid_1;			  
   assign  	`TRANSACTORS_PATH.m_bresp[1]  =  `AXIM_MASTER_1.m_bresp_1;      
   assign   `TRANSACTORS_PATH.m_buser[1]  =  `AXIM_MASTER_1.m_buser_1;      
   assign   `AXIM_MASTER_1.m_bready_1     =  `TRANSACTORS_PATH.m_bready[1]; 

   `else  // Direct mode connection
          //------------------------------
   assign 	`TRANSACTORS_PATH.m_axi_clk 	 		= `AXIM_MASTER_1.m_axi_clk;
   assign 	`TRANSACTORS_PATH.m_axi_resetn    = `AXIM_MASTER_1.m_rstn_1; 
   
   // AXIM Address Write port
   assign   `AXIM_MASTER_1.m_awvalid_1     =  `TRANSACTORS_PATH.m_extend_axim_awvalid;
   assign   `AXIM_MASTER_1.m_awid_1        =  `TRANSACTORS_PATH.m_extend_axim_awid[3:0];
   assign   `AXIM_MASTER_1.m_awaddr_1      =  {4'b0,`TRANSACTORS_PATH.m_extend_axim_awaddr[27:0]};
   assign   `AXIM_MASTER_1.m_awlen_1       =  `TRANSACTORS_PATH.m_extend_axim_awlen;
   assign   `AXIM_MASTER_1.m_awsize_1      =  `TRANSACTORS_PATH.m_extend_axim_awsize;
   assign   `AXIM_MASTER_1.m_awburst_1     =  `TRANSACTORS_PATH.m_extend_axim_awburst;
   assign   `AXIM_MASTER_1.m_awlock_1      =  `TRANSACTORS_PATH.m_extend_axim_awlock;
   assign   `AXIM_MASTER_1.m_awcache_1     =  `TRANSACTORS_PATH.m_extend_axim_awcache;
   assign   `AXIM_MASTER_1.m_awprot_1      =  `TRANSACTORS_PATH.m_extend_axim_awprot;
   assign   `AXIM_MASTER_1.m_awqos_1       =  `TRANSACTORS_PATH.m_extend_axim_awqos;  
   assign   `AXIM_MASTER_1.m_awregion_1    =  `TRANSACTORS_PATH.m_extend_axim_awregion;
   assign   `AXIM_MASTER_1.m_awuser_1      =  'b0; 
   assign   `TRANSACTORS_PATH.m_extend_axim_awready =  `AXIM_MASTER_1.m_awready_1;  

// AXIM  Write port 
   assign   `AXIM_MASTER_1.m_wvalid_1     =   `TRANSACTORS_PATH.m_extend_axim_wvalid; 
  // assign   `AXIM_MASTER_1.m_wid_1        =   `TRANSACTORS_PATH.m_wid[1];    
   assign   `AXIM_MASTER_1.m_wdata_1      =   `TRANSACTORS_PATH.m_extend_axim_wdata;	
   assign   `AXIM_MASTER_1.m_wstrb_1      =   `TRANSACTORS_PATH.m_extend_axim_wstrb;	
   assign   `AXIM_MASTER_1.m_wlast_1      =   `TRANSACTORS_PATH.m_extend_axim_wlast;  
 //  assign   `AXIM_MASTER_1.m_wuser_1      =   `TRANSACTORS_PATH.m_wuser[1];  
   assign   `TRANSACTORS_PATH.m_extend_axim_wready =   `AXIM_MASTER_1.m_wready_1;     

// AXIM Address Read port
   assign   `AXIM_MASTER_1.m_arvalid_1     =   `TRANSACTORS_PATH.m_extend_axim_arvalid; 
   assign   `AXIM_MASTER_1.m_arid_1        =   `TRANSACTORS_PATH.m_extend_axim_arid[3:0];
   assign   `AXIM_MASTER_1.m_araddr_1      =   {4'b0,`TRANSACTORS_PATH.m_extend_axim_araddr[27:0]};
   assign   `AXIM_MASTER_1.m_arlen_1       =   `TRANSACTORS_PATH.m_extend_axim_arlen;
   assign   `AXIM_MASTER_1.m_arsize_1      =   `TRANSACTORS_PATH.m_extend_axim_arsize;
   assign   `AXIM_MASTER_1.m_arburst_1     =   `TRANSACTORS_PATH.m_extend_axim_arburst;
   assign   `AXIM_MASTER_1.m_arlock_1      =   `TRANSACTORS_PATH.m_extend_axim_arlock;
   assign   `AXIM_MASTER_1.m_arcache_1     =   `TRANSACTORS_PATH.m_extend_axim_arcache;
   assign   `AXIM_MASTER_1.m_arprot_1      =   `TRANSACTORS_PATH.m_extend_axim_arprot;
   assign   `AXIM_MASTER_1.m_arqos_1       =   `TRANSACTORS_PATH.m_extend_axim_arqos;
   assign   `AXIM_MASTER_1.m_arregion_1    =   `TRANSACTORS_PATH.m_extend_axim_arregion; 
   assign   `AXIM_MASTER_1.m_aruser_1      =   'b0;  
   assign   `TRANSACTORS_PATH.m_extend_axim_arready =   `AXIM_MASTER_1.m_arready_1;     

// AXIM Read port    
   assign   `TRANSACTORS_PATH.m_extend_axim_rvalid     =   `AXIM_MASTER_1.m_rvalid_1; 	    
   assign   `TRANSACTORS_PATH.m_extend_axim_rid        =   `AXIM_MASTER_1.m_rid_1;          
   assign   `TRANSACTORS_PATH.m_extend_axim_rdata      =   `AXIM_MASTER_1.m_rdata_1; 		    
   assign   `TRANSACTORS_PATH.m_extend_axim_rresp      =   `AXIM_MASTER_1.m_rresp_1; 			  
   assign   `TRANSACTORS_PATH.m_extend_axim_rlast      =   `AXIM_MASTER_1.m_rlast_1;     	  
   //assign   `TRANSACTORS_PATH.m_ruser[1]      =   `AXIM_MASTER_1.m_ruser_1; 		 	  
   assign   `AXIM_MASTER_1.m_rready_1         =   `TRANSACTORS_PATH.m_extend_axim_rready; 
 
 //  AXIM Response port
   assign   `TRANSACTORS_PATH.m_extend_axim_bvalid =  `AXIM_MASTER_1.m_bvalid_1;     
   assign   `TRANSACTORS_PATH.m_extend_axim_bid    =  `AXIM_MASTER_1.m_bid_1[3:0];			  
   assign  	`TRANSACTORS_PATH.m_extend_axim_bresp  =  `AXIM_MASTER_1.m_bresp_1;      
   assign   `AXIM_MASTER_1.m_bready_1              =  `TRANSACTORS_PATH.m_extend_axim_bready; 
  
   `endif
