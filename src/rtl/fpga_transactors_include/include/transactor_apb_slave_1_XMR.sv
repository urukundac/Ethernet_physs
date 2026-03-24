//=================================================================================================================================
// APB connections - USER MUST EDIT THE RIGHT HAND SIDE OF THE FOLLOWING ASSIGNMENTS AND DEFINE - WHEN NEEDED
//=================================================================================================================================
// APB SLAVE   connection #1

	  `define 	APB_SLAVE_1 				`FPGA_TRANSACTORS_TOP          // example:  fpga_tcss_top.tcss_val_rtl.tcss.par_iom
       
   assign 	`TRANSACTORS_PATH.s_pclk[1] 	 		= `APB_SLAVE_1.s_pclk_1; 
   assign 	`TRANSACTORS_PATH.s_prst_n[1]     = `APB_SLAVE_1.s_prstn_1;
  
   assign  `TRANSACTORS_PATH.s_pwdata[1]    =  `APB_SLAVE_1.s_pwdata_1;       
   assign  `TRANSACTORS_PATH.s_psel[1]      =  `APB_SLAVE_1.s_psel_1;         
   assign  `TRANSACTORS_PATH.s_penable[1]   =  `APB_SLAVE_1.s_penable_1;      
   assign  `TRANSACTORS_PATH.s_pwrite[1]    =  `APB_SLAVE_1.s_pwrite_1;       
   assign  `TRANSACTORS_PATH.s_paddr[1]     =  `APB_SLAVE_1.s_paddr_1;        
   assign  `APB_SLAVE_1.s_pready_1         =  `TRANSACTORS_PATH.s_pready[1];  
   assign  `APB_SLAVE_1.s_prdata_1         =  `TRANSACTORS_PATH.s_prdata[1];  

  


