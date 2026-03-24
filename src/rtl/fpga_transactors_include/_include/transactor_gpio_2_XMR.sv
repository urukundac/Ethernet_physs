//=================================================================================================================================
// UFI_FABRIC connections - USER MUST EDIT THE RIGHT HAND SIDE OF THE FOLLOWING ASSIGNMENTS AND DEFINE - WHEN NEEDED
//=================================================================================================================================
// UFI_FABRIC   connection #0

		     // example:  fpga_tcss_top.tcss_val_rtl.tcss.par_iom
	  `define 	GPIO_2 					fpga_transactors_top_inst       // example:  fpga_tcss_top.tcss_val_rtl.tcss.par_iom
  
   assign 	`TRANSACTORS_PATH.gp_clk[2] 	      	 = `GPIO_2.gp_clock_2; 
   assign 	`TRANSACTORS_PATH.gp_rst_n[2]          = `GPIO_2.gp_rstn_2; 
      
   assign   `GPIO_2.gpio_out_bus_2                  = `TRANSACTORS_PATH.gpio_out_bus[2];
   assign   `TRANSACTORS_PATH.gpio_in_bus[2]      	= `GPIO_2.gpio_in_bus_2;

