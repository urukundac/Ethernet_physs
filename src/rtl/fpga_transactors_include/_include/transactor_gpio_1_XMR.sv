//=================================================================================================================================
// UFI_FABRIC connections - USER MUST EDIT THE RIGHT HAND SIDE OF THE FOLLOWING ASSIGNMENTS AND DEFINE - WHEN NEEDED
//=================================================================================================================================
// UFI_FABRIC   connection #0

		     // example:  fpga_tcss_top.tcss_val_rtl.tcss.par_iom
	  `define 	GPIO_1 					fpga_transactors_top_inst       // example:  fpga_tcss_top.tcss_val_rtl.tcss.par_iom
  
   assign 	`TRANSACTORS_PATH.gp_clk[1] 	      	 = `GPIO_1.gp_clock_1; 
   assign 	`TRANSACTORS_PATH.gp_rst_n[1]          = `GPIO_1.gp_rstn_1; 
      
   assign   `GPIO_1.gpio_out_bus_1                  = `TRANSACTORS_PATH.gpio_out_bus[1];
   assign   `TRANSACTORS_PATH.gpio_in_bus[1]      	= `GPIO_1.gpio_in_bus_1;

