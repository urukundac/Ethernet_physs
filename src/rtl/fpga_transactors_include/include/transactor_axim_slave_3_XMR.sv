//=================================================================================================================================
// UFI_FABRIC connections - USER MUST EDIT THE RIGHT HAND SIDE OF THE FOLLOWING ASSIGNMENTS AND DEFINE - WHEN NEEDED
//=================================================================================================================================
// UFI_FABRIC   connection #0

		     // example:  fpga_tcss_top.tcss_val_rtl.tcss.par_iom
	  `define 	AXIM_SLAVE_3 					`FPGA_TRANSACTORS_TOP       // example:  fpga_tcss_top.tcss_val_rtl.tcss.par_iom
  

   assign 	`TRANSACTORS_PATH.s_clk[3] 	      		= `AXIM_SLAVE_3.s_clock_3; 
   assign 	`TRANSACTORS_PATH.s_rst_n[3]          = `AXIM_SLAVE_3.s_rstn_3; 
      
// AXIM Addreaa Write port
   assign   `TRANSACTORS_PATH.s_awvalid[3]      	= `AXIM_SLAVE_3.s_awvalid_3;
   assign   `TRANSACTORS_PATH.s_awid[3]         	= `AXIM_SLAVE_3.s_awid_3;
   assign   `TRANSACTORS_PATH.s_awaddr[3]       	= `AXIM_SLAVE_3.s_awaddr_3;    
   assign   `TRANSACTORS_PATH.s_awlen[3]        	= `AXIM_SLAVE_3.s_awlen_3;
   assign   `TRANSACTORS_PATH.s_awsize[3]       	= `AXIM_SLAVE_3.s_awsize_3;
   assign   `TRANSACTORS_PATH.s_awburst[3]      	= `AXIM_SLAVE_3.s_awburst_3;
   assign   `TRANSACTORS_PATH.s_awlock[3]       	= `AXIM_SLAVE_3.s_awlock_3;    
   assign   `TRANSACTORS_PATH.s_awcache[3]      	= `AXIM_SLAVE_3.s_awcache_3; 
   assign   `TRANSACTORS_PATH.s_awprot[3]       	= `AXIM_SLAVE_3.s_awprot_3;
   assign   `TRANSACTORS_PATH.s_awqos[3]        	= `AXIM_SLAVE_3.s_awqos_3;
   assign   `TRANSACTORS_PATH.s_awregion[3]      	= `AXIM_SLAVE_3.s_awregion_3; 
   assign   `TRANSACTORS_PATH.s_awuser[3]       	= `AXIM_SLAVE_3.s_awuser_3;
   assign   `AXIM_SLAVE_3.s_awready_3             = `TRANSACTORS_PATH.s_awready[3];  

// AXIM Addreaa Write port 
   assign   `TRANSACTORS_PATH.s_wvalid[3]  	= `AXIM_SLAVE_3.s_wvalid_3; 
   assign   `TRANSACTORS_PATH.s_wid[3]      = `AXIM_SLAVE_3.s_wid_3;
   assign   `TRANSACTORS_PATH.s_wdata[4095:3072] = `AXIM_SLAVE_3.s_wdata_3; 
   assign   `TRANSACTORS_PATH.s_wstrb[511:384]	  = `AXIM_SLAVE_3.s_wstrb_3;
   assign   `TRANSACTORS_PATH.s_wlast[3]    = `AXIM_SLAVE_3.s_wlast_3;
   assign   `TRANSACTORS_PATH.s_wuser[3]    = `AXIM_SLAVE_3.s_wuser_3;  
   assign   `AXIM_SLAVE_3.s_wready_3         = `TRANSACTORS_PATH.s_wready[3];

// AXIM Addreaa Read port
   assign   `TRANSACTORS_PATH.s_arvalid[3]      	= `AXIM_SLAVE_3.s_arvalid_3;
   assign   `TRANSACTORS_PATH.s_arid[3]         	= `AXIM_SLAVE_3.s_arid_3;
   assign   `TRANSACTORS_PATH.s_araddr[3]       	= `AXIM_SLAVE_3.s_araddr_3;    
   assign   `TRANSACTORS_PATH.s_arlen[3]        	= `AXIM_SLAVE_3.s_arlen_3;
   assign   `TRANSACTORS_PATH.s_arsize[3]       	= `AXIM_SLAVE_3.s_arsize_3;
   assign   `TRANSACTORS_PATH.s_arburst[3]      	= `AXIM_SLAVE_3.s_arburst_3;
   assign   `TRANSACTORS_PATH.s_arlock[3]       	= `AXIM_SLAVE_3.s_arlock_3;    
   assign   `TRANSACTORS_PATH.s_arcache[3]      	= `AXIM_SLAVE_3.s_arcache_3; 
   assign   `TRANSACTORS_PATH.s_arprot[3]       	= `AXIM_SLAVE_3.s_arprot_3;
   assign   `TRANSACTORS_PATH.s_arqos[3]        	= `AXIM_SLAVE_3.s_arqos_3;
   assign   `TRANSACTORS_PATH.s_arregion[3]      	= `AXIM_SLAVE_3.s_arregion_3; 
   assign   `TRANSACTORS_PATH.s_aruser[3]       	= `AXIM_SLAVE_3.s_aruser_3;
   assign   `AXIM_SLAVE_3.s_arready_3             = `TRANSACTORS_PATH.s_arready[3];  

// AXIM Read port    
   assign   `AXIM_SLAVE_3.s_rvalid_3 	    	 	= `TRANSACTORS_PATH.s_rvalid[3];
   assign   `AXIM_SLAVE_3.s_rid_3            	= `TRANSACTORS_PATH.s_rid[3]; 
   assign   `AXIM_SLAVE_3.s_rdata_3 		     	= `TRANSACTORS_PATH.s_rdata[4095:3072];
   assign   `AXIM_SLAVE_3.s_rresp_3 			    = `TRANSACTORS_PATH.s_rresp[3]; 
   assign   `AXIM_SLAVE_3.s_rlast_3     	    = `TRANSACTORS_PATH.s_rlast[3];
   assign   `AXIM_SLAVE_3.s_ruser_3 		 	    = `TRANSACTORS_PATH.s_ruser[3];
   assign   `TRANSACTORS_PATH.s_rready[3]     = `AXIM_SLAVE_3.s_rready_3;

//  AXIM Response port
   assign   `AXIM_SLAVE_3.s_bvalid_3      		= `TRANSACTORS_PATH.s_bvalid[3];
   assign   `AXIM_SLAVE_3.s_bid_3			      	= `TRANSACTORS_PATH.s_bid[3];
   assign   `AXIM_SLAVE_3.s_bresp_3      			= `TRANSACTORS_PATH.s_bresp[3]; 
   assign   `AXIM_SLAVE_3.s_buser_3      	  	= `TRANSACTORS_PATH.s_buser[3];
   assign   `TRANSACTORS_PATH.s_bready[3]     = `AXIM_SLAVE_3.s_bready_3;

