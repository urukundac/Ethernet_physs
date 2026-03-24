//=================================================================================================================================
// UFI_FABRIC connections - USER MUST EDIT THE RIGHT HAND SIDE OF THE FOLLOWING ASSIGNMENTS AND DEFINE - WHEN NEEDED
//=================================================================================================================================
// UFI_FABRIC   connection #0

		     // example:  fpga_tcss_top.tcss_val_rtl.tcss.par_iom
	  `define 	GPIO_3 					fpga_transactors_top_inst       // example:  fpga_tcss_top.tcss_val_rtl.tcss.par_iom
  
   assign 	`TRANSACTORS_PATH.gp_clk[3] 	      	 = `GPIO_3.gp_clock_3; 
   assign 	`TRANSACTORS_PATH.gp_rst_n[3]          = `GPIO_3.gp_rstn_3; 
      
   assign   `GPIO_3.gpio_out_bus_3                  = `TRANSACTORS_PATH.gpio_out_bus[3];
   assign   `TRANSACTORS_PATH.gpio_in_bus[3]      	= `GPIO_3.gpio_in_bus_3;

