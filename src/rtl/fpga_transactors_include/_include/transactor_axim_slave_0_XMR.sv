//=================================================================================================================================
// UFI_FABRIC connections - USER MUST EDIT THE RIGHT HAND SIDE OF THE FOLLOWING ASSIGNMENTS AND DEFINE - WHEN NEEDED
//=================================================================================================================================
// UFI_FABRIC   connection #0

		     // example:  fpga_tcss_top.tcss_val_rtl.tcss.par_iom
	  `define 	AXIM_SLAVE_0 					fpga_transactors_top_inst       // example:  fpga_tcss_top.tcss_val_rtl.tcss.par_iom
  

   assign 	`TRANSACTORS_PATH.s_clk[0] 	      		= `AXIM_SLAVE_0.s_clock_0; 
   assign 	`TRANSACTORS_PATH.s_rst_n[0]          = `AXIM_SLAVE_0.s_rstn_0; 
      
// AXIM Addreaa Write port
   assign   `TRANSACTORS_PATH.s_awvalid[0]      	= `AXIM_SLAVE_0.s_awvalid_0;
   assign   `TRANSACTORS_PATH.s_awid[0]         	= `AXIM_SLAVE_0.s_awid_0;
   assign   `TRANSACTORS_PATH.s_awaddr[0]       	= `AXIM_SLAVE_0.s_awaddr_0;    
   assign   `TRANSACTORS_PATH.s_awlen[0]        	= `AXIM_SLAVE_0.s_awlen_0;
   assign   `TRANSACTORS_PATH.s_awsize[0]       	= `AXIM_SLAVE_0.s_awsize_0;
   assign   `TRANSACTORS_PATH.s_awburst[0]      	= `AXIM_SLAVE_0.s_awburst_0;
   assign   `TRANSACTORS_PATH.s_awlock[0]       	= `AXIM_SLAVE_0.s_awlock_0;    
   assign   `TRANSACTORS_PATH.s_awcache[0]      	= `AXIM_SLAVE_0.s_awcache_0; 
   assign   `TRANSACTORS_PATH.s_awprot[0]       	= `AXIM_SLAVE_0.s_awprot_0;
   assign   `TRANSACTORS_PATH.s_awqos[0]        	= `AXIM_SLAVE_0.s_awqos_0;
   assign   `TRANSACTORS_PATH.s_awregion[0]      	= `AXIM_SLAVE_0.s_awregion_0; 
   assign   `TRANSACTORS_PATH.s_awuser[0]       	= `AXIM_SLAVE_0.s_awuser_0;
   assign   `AXIM_SLAVE_0.s_awready_0             = `TRANSACTORS_PATH.s_awready[0];  

// AXIM Addreaa Write port 
   assign   `TRANSACTORS_PATH.s_wvalid[0]  	= `AXIM_SLAVE_0.s_wvalid_0; 
   assign   `TRANSACTORS_PATH.s_wid[0]      = `AXIM_SLAVE_0.s_wid_0;
   assign   `TRANSACTORS_PATH.s_wdata[511:0] = `AXIM_SLAVE_0.s_wdata_0; 
   assign   `TRANSACTORS_PATH.s_wstrb[63:0]	  = `AXIM_SLAVE_0.s_wstrb_0;
   assign   `TRANSACTORS_PATH.s_wlast[0]    = `AXIM_SLAVE_0.s_wlast_0;
   assign   `TRANSACTORS_PATH.s_wuser[0]    = `AXIM_SLAVE_0.s_wuser_0;  
   assign   `AXIM_SLAVE_0.s_wready_0         = `TRANSACTORS_PATH.s_wready[0];

// AXIM Addreaa Read port
   assign   `TRANSACTORS_PATH.s_arvalid[0]      	= `AXIM_SLAVE_0.s_arvalid_0;
   assign   `TRANSACTORS_PATH.s_arid[0]         	= `AXIM_SLAVE_0.s_arid_0;
   assign   `TRANSACTORS_PATH.s_araddr[0]       	= `AXIM_SLAVE_0.s_araddr_0;    
   assign   `TRANSACTORS_PATH.s_arlen[0]        	= `AXIM_SLAVE_0.s_arlen_0;
   assign   `TRANSACTORS_PATH.s_arsize[0]       	= `AXIM_SLAVE_0.s_arsize_0;
   assign   `TRANSACTORS_PATH.s_arburst[0]      	= `AXIM_SLAVE_0.s_arburst_0;
   assign   `TRANSACTORS_PATH.s_arlock[0]       	= `AXIM_SLAVE_0.s_arlock_0;    
   assign   `TRANSACTORS_PATH.s_arcache[0]      	= `AXIM_SLAVE_0.s_arcache_0; 
   assign   `TRANSACTORS_PATH.s_arprot[0]       	= `AXIM_SLAVE_0.s_arprot_0;
   assign   `TRANSACTORS_PATH.s_arqos[0]        	= `AXIM_SLAVE_0.s_arqos_0;
   assign   `TRANSACTORS_PATH.s_arregion[0]      	= `AXIM_SLAVE_0.s_arregion_0; 
   assign   `TRANSACTORS_PATH.s_aruser[0]       	= `AXIM_SLAVE_0.s_aruser_0;
   assign   `AXIM_SLAVE_0.s_arready_0             = `TRANSACTORS_PATH.s_arready[0];  

// AXIM Read port    
   assign   `AXIM_SLAVE_0.s_rvalid_0 	    	 	= `TRANSACTORS_PATH.s_rvalid[0];
   assign   `AXIM_SLAVE_0.s_rid_0            	= `TRANSACTORS_PATH.s_rid[0]; 
   assign   `AXIM_SLAVE_0.s_rdata_0 		     	= `TRANSACTORS_PATH.s_rdata[511:0];
   assign   `AXIM_SLAVE_0.s_rresp_0 			    = `TRANSACTORS_PATH.s_rresp[0]; 
   assign   `AXIM_SLAVE_0.s_rlast_0     	    = `TRANSACTORS_PATH.s_rlast[0];
   assign   `AXIM_SLAVE_0.s_ruser_0 		 	    = `TRANSACTORS_PATH.s_ruser[0];
   assign   `TRANSACTORS_PATH.s_rready[0]     = `AXIM_SLAVE_0.s_rready_0;

//  AXIM Response port
   assign   `AXIM_SLAVE_0.s_bvalid_0      		= `TRANSACTORS_PATH.s_bvalid[0];
   assign   `AXIM_SLAVE_0.s_bid_0			      	= `TRANSACTORS_PATH.s_bid[0];
   assign   `AXIM_SLAVE_0.s_bresp_0      			= `TRANSACTORS_PATH.s_bresp[0]; 
   assign   `AXIM_SLAVE_0.s_buser_0      	  	= `TRANSACTORS_PATH.s_buser[0];
   assign   `TRANSACTORS_PATH.s_bready[0]     = `AXIM_SLAVE_0.s_bready_0;

