//=================================================================================================================================
// UFI_FABRIC connections - USER MUST EDIT THE RIGHT HAND SIDE OF THE FOLLOWING ASSIGNMENTS AND DEFINE - WHEN NEEDED
//=================================================================================================================================
// UFI_FABRIC   connection #0

		     // example:  fpga_tcss_top.tcss_val_rtl.tcss.par_iom
	  `define 	AXIM_SLAVE_1 					`FPGA_TRANSACTORS_TOP       // example:  fpga_tcss_top.tcss_val_rtl.tcss.par_iom
  

   assign 	`TRANSACTORS_PATH.s_clk[1] 	      		= `AXIM_SLAVE_1.s_clock_1; 
   assign 	`TRANSACTORS_PATH.s_rst_n[1]          = `AXIM_SLAVE_1.s_rstn_1; 
      
// AXIM Addreaa Write port
   assign   `TRANSACTORS_PATH.s_awvalid[1]      	= `AXIM_SLAVE_1.s_awvalid_1;
   assign   `TRANSACTORS_PATH.s_awid[1]         	= `AXIM_SLAVE_1.s_awid_1;
   assign   `TRANSACTORS_PATH.s_awaddr[1]       	= `AXIM_SLAVE_1.s_awaddr_1;    
   assign   `TRANSACTORS_PATH.s_awlen[1]        	= `AXIM_SLAVE_1.s_awlen_1;
   assign   `TRANSACTORS_PATH.s_awsize[1]       	= `AXIM_SLAVE_1.s_awsize_1;
   assign   `TRANSACTORS_PATH.s_awburst[1]      	= `AXIM_SLAVE_1.s_awburst_1;
   assign   `TRANSACTORS_PATH.s_awlock[1]       	= `AXIM_SLAVE_1.s_awlock_1;    
   assign   `TRANSACTORS_PATH.s_awcache[1]      	= `AXIM_SLAVE_1.s_awcache_1; 
   assign   `TRANSACTORS_PATH.s_awprot[1]       	= `AXIM_SLAVE_1.s_awprot_1;
   assign   `TRANSACTORS_PATH.s_awqos[1]        	= `AXIM_SLAVE_1.s_awqos_1;
   assign   `TRANSACTORS_PATH.s_awregion[1]      	= `AXIM_SLAVE_1.s_awregion_1; 
   assign   `TRANSACTORS_PATH.s_awuser[1]       	= `AXIM_SLAVE_1.s_awuser_1;
   assign   `AXIM_SLAVE_1.s_awready_1             = `TRANSACTORS_PATH.s_awready[1];  

// AXIM Addreaa Write port 
   assign   `TRANSACTORS_PATH.s_wvalid[1]  	= `AXIM_SLAVE_1.s_wvalid_1; 
   assign   `TRANSACTORS_PATH.s_wid[1]      = `AXIM_SLAVE_1.s_wid_1;
   assign   `TRANSACTORS_PATH.s_wdata[2047:1024] = `AXIM_SLAVE_1.s_wdata_1; 
   assign   `TRANSACTORS_PATH.s_wstrb[255:128]	  = `AXIM_SLAVE_1.s_wstrb_1;
   assign   `TRANSACTORS_PATH.s_wlast[1]    = `AXIM_SLAVE_1.s_wlast_1;
   assign   `TRANSACTORS_PATH.s_wuser[1]    = `AXIM_SLAVE_1.s_wuser_1;  
   assign   `AXIM_SLAVE_1.s_wready_1         = `TRANSACTORS_PATH.s_wready[1];

// AXIM Addreaa Read port
   assign   `TRANSACTORS_PATH.s_arvalid[1]      	= `AXIM_SLAVE_1.s_arvalid_1;
   assign   `TRANSACTORS_PATH.s_arid[1]         	= `AXIM_SLAVE_1.s_arid_1;
   assign   `TRANSACTORS_PATH.s_araddr[1]       	= `AXIM_SLAVE_1.s_araddr_1;    
   assign   `TRANSACTORS_PATH.s_arlen[1]        	= `AXIM_SLAVE_1.s_arlen_1;
   assign   `TRANSACTORS_PATH.s_arsize[1]       	= `AXIM_SLAVE_1.s_arsize_1;
   assign   `TRANSACTORS_PATH.s_arburst[1]      	= `AXIM_SLAVE_1.s_arburst_1;
   assign   `TRANSACTORS_PATH.s_arlock[1]       	= `AXIM_SLAVE_1.s_arlock_1;    
   assign   `TRANSACTORS_PATH.s_arcache[1]      	= `AXIM_SLAVE_1.s_arcache_1; 
   assign   `TRANSACTORS_PATH.s_arprot[1]       	= `AXIM_SLAVE_1.s_arprot_1;
   assign   `TRANSACTORS_PATH.s_arqos[1]        	= `AXIM_SLAVE_1.s_arqos_1;
   assign   `TRANSACTORS_PATH.s_arregion[1]      	= `AXIM_SLAVE_1.s_arregion_1; 
   assign   `TRANSACTORS_PATH.s_aruser[1]       	= `AXIM_SLAVE_1.s_aruser_1;
   assign   `AXIM_SLAVE_1.s_arready_1             = `TRANSACTORS_PATH.s_arready[1];  

// AXIM Read port    
   assign   `AXIM_SLAVE_1.s_rvalid_1 	    	 	= `TRANSACTORS_PATH.s_rvalid[1];
   assign   `AXIM_SLAVE_1.s_rid_1            	= `TRANSACTORS_PATH.s_rid[1]; 
   assign   `AXIM_SLAVE_1.s_rdata_1 		     	= `TRANSACTORS_PATH.s_rdata[2047:1024];
   assign   `AXIM_SLAVE_1.s_rresp_1 			    = `TRANSACTORS_PATH.s_rresp[1]; 
   assign   `AXIM_SLAVE_1.s_rlast_1     	    = `TRANSACTORS_PATH.s_rlast[1];
   assign   `AXIM_SLAVE_1.s_ruser_1 		 	    = `TRANSACTORS_PATH.s_ruser[1];
   assign   `TRANSACTORS_PATH.s_rready[1]     = `AXIM_SLAVE_1.s_rready_1;

//  AXIM Response port
   assign   `AXIM_SLAVE_1.s_bvalid_1      		= `TRANSACTORS_PATH.s_bvalid[1];
   assign   `AXIM_SLAVE_1.s_bid_1			      	= `TRANSACTORS_PATH.s_bid[1];
   assign   `AXIM_SLAVE_1.s_bresp_1      			= `TRANSACTORS_PATH.s_bresp[1]; 
   assign   `AXIM_SLAVE_1.s_buser_1      	  	= `TRANSACTORS_PATH.s_buser[1];
   assign   `TRANSACTORS_PATH.s_bready[1]     = `AXIM_SLAVE_1.s_bready_1;

