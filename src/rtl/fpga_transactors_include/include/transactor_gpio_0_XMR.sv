//=================================================================================================================================
// UFI_FABRIC connections - USER MUST EDIT THE RIGHT HAND SIDE OF THE FOLLOWING ASSIGNMENTS AND DEFINE - WHEN NEEDED
//=================================================================================================================================
// UFI_FABRIC   connection #0
 `ifdef F2F_BRIDGE
    `define 	  GPIO_0				fpga_transactors_PAR_top	
`else
    `define 	 GPIO_0 			`FPGA_TRANSACTORS_TOP		
 `endif // example:  fpga_tcss_top.tcss_val_rtl.tcss.par_iom    //HERE USER SHOULD SET THE PATH TO HIS SIDE OF THE SB INTEFACE - THE AGENT SIDE

						

	   assign 	`TRANSACTORS_PATH.gp_clk[0] 	      	 = `GPIO_0.gp_clock_0; 
   assign 	`TRANSACTORS_PATH.gp_rst_n[0]          = `GPIO_0.gp_rstn_0; 
      
   assign   `GPIO_0.gpio_out_bus_0                 = `TRANSACTORS_PATH.gpio_out_bus[0];
   assign   `TRANSACTORS_PATH.gpio_in_bus[0]      	= `GPIO_0.gpio_in_bus_0;

