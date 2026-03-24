//=================================================================================================================================
// UFI_FABRIC connections - USER MUST EDIT THE RIGHT HAND SIDE OF THE FOLLOWING ASSIGNMENTS AND DEFINE - WHEN NEEDED
//=================================================================================================================================
// UFI_FABRIC   connection #0

		     // example:  fpga_tcss_top.tcss_val_rtl.tcss.par_iom
	  `define 	AXIM_SLAVE_2 					fpga_transactors_top_inst       // example:  fpga_tcss_top.tcss_val_rtl.tcss.par_iom
  

   assign 	`TRANSACTORS_PATH.s_clk[2] 	      		= `AXIM_SLAVE_2.s_clock_2; 
   assign 	`TRANSACTORS_PATH.s_rst_n[2]          = `AXIM_SLAVE_2.s_rstn_2; 
      
// AXIM Addreaa Write port
   assign   `TRANSACTORS_PATH.s_awvalid[2]      	= `AXIM_SLAVE_2.s_awvalid_2;
   assign   `TRANSACTORS_PATH.s_awid[2]         	= `AXIM_SLAVE_2.s_awid_2;
   assign   `TRANSACTORS_PATH.s_awaddr[2]       	= `AXIM_SLAVE_2.s_awaddr_2;    
   assign   `TRANSACTORS_PATH.s_awlen[2]        	= `AXIM_SLAVE_2.s_awlen_2;
   assign   `TRANSACTORS_PATH.s_awsize[2]       	= `AXIM_SLAVE_2.s_awsize_2;
   assign   `TRANSACTORS_PATH.s_awburst[2]      	= `AXIM_SLAVE_2.s_awburst_2;
   assign   `TRANSACTORS_PATH.s_awlock[2]       	= `AXIM_SLAVE_2.s_awlock_2;    
   assign   `TRANSACTORS_PATH.s_awcache[2]      	= `AXIM_SLAVE_2.s_awcache_2; 
   assign   `TRANSACTORS_PATH.s_awprot[2]       	= `AXIM_SLAVE_2.s_awprot_2;
   assign   `TRANSACTORS_PATH.s_awqos[2]        	= `AXIM_SLAVE_2.s_awqos_2;
   assign   `TRANSACTORS_PATH.s_awregion[2]      	= `AXIM_SLAVE_2.s_awregion_2; 
   assign   `TRANSACTORS_PATH.s_awuser[2]       	= `AXIM_SLAVE_2.s_awuser_2;
   assign   `AXIM_SLAVE_2.s_awready_2             = `TRANSACTORS_PATH.s_awready[2];  

// AXIM Addreaa Write port 
   assign   `TRANSACTORS_PATH.s_wvalid[2]  	= `AXIM_SLAVE_2.s_wvalid_2; 
   assign   `TRANSACTORS_PATH.s_wid[2]      = `AXIM_SLAVE_2.s_wid_2;
   assign   `TRANSACTORS_PATH.s_wdata[1535:1024] = `AXIM_SLAVE_2.s_wdata_2; 
   assign   `TRANSACTORS_PATH.s_wstrb[191:128]	  = `AXIM_SLAVE_2.s_wstrb_2;
   assign   `TRANSACTORS_PATH.s_wlast[2]    = `AXIM_SLAVE_2.s_wlast_2;
   assign   `TRANSACTORS_PATH.s_wuser[2]    = `AXIM_SLAVE_2.s_wuser_2;  
   assign   `AXIM_SLAVE_2.s_wready_2         = `TRANSACTORS_PATH.s_wready[2];

// AXIM Addreaa Read port
   assign   `TRANSACTORS_PATH.s_arvalid[2]      	= `AXIM_SLAVE_2.s_arvalid_2;
   assign   `TRANSACTORS_PATH.s_arid[2]         	= `AXIM_SLAVE_2.s_arid_2;
   assign   `TRANSACTORS_PATH.s_araddr[2]       	= `AXIM_SLAVE_2.s_araddr_2;    
   assign   `TRANSACTORS_PATH.s_arlen[2]        	= `AXIM_SLAVE_2.s_arlen_2;
   assign   `TRANSACTORS_PATH.s_arsize[2]       	= `AXIM_SLAVE_2.s_arsize_2;
   assign   `TRANSACTORS_PATH.s_arburst[2]      	= `AXIM_SLAVE_2.s_arburst_2;
   assign   `TRANSACTORS_PATH.s_arlock[2]       	= `AXIM_SLAVE_2.s_arlock_2;    
   assign   `TRANSACTORS_PATH.s_arcache[2]      	= `AXIM_SLAVE_2.s_arcache_2; 
   assign   `TRANSACTORS_PATH.s_arprot[2]       	= `AXIM_SLAVE_2.s_arprot_2;
   assign   `TRANSACTORS_PATH.s_arqos[2]        	= `AXIM_SLAVE_2.s_arqos_2;
   assign   `TRANSACTORS_PATH.s_arregion[2]      	= `AXIM_SLAVE_2.s_arregion_2; 
   assign   `TRANSACTORS_PATH.s_aruser[2]       	= `AXIM_SLAVE_2.s_aruser_2;
   assign   `AXIM_SLAVE_2.s_arready_2             = `TRANSACTORS_PATH.s_arready[2];  

// AXIM Read port    
   assign   `AXIM_SLAVE_2.s_rvalid_2 	    	 	= `TRANSACTORS_PATH.s_rvalid[2];
   assign   `AXIM_SLAVE_2.s_rid_2            	= `TRANSACTORS_PATH.s_rid[2]; 
   assign   `AXIM_SLAVE_2.s_rdata_2 		     	= `TRANSACTORS_PATH.s_rdata[1535:1024];
   assign   `AXIM_SLAVE_2.s_rresp_2 			    = `TRANSACTORS_PATH.s_rresp[2]; 
   assign   `AXIM_SLAVE_2.s_rlast_2     	    = `TRANSACTORS_PATH.s_rlast[2];
   assign   `AXIM_SLAVE_2.s_ruser_2 		 	    = `TRANSACTORS_PATH.s_ruser[2];
   assign   `TRANSACTORS_PATH.s_rready[2]     = `AXIM_SLAVE_2.s_rready_2;

//  AXIM Response port
   assign   `AXIM_SLAVE_2.s_bvalid_2      		= `TRANSACTORS_PATH.s_bvalid[2];
   assign   `AXIM_SLAVE_2.s_bid_2			      	= `TRANSACTORS_PATH.s_bid[2];
   assign   `AXIM_SLAVE_2.s_bresp_2      			= `TRANSACTORS_PATH.s_bresp[2]; 
   assign   `AXIM_SLAVE_2.s_buser_2      	  	= `TRANSACTORS_PATH.s_buser[2];
   assign   `TRANSACTORS_PATH.s_bready[2]     = `AXIM_SLAVE_2.s_bready_2;

