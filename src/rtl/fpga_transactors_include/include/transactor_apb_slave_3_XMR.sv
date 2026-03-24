//=================================================================================================================================
// APB connections - USER MUST EDIT THE RIGHT HAND SIDE OF THE FOLLOWING ASSIGNMENTS AND DEFINE - WHEN NEEDED
//=================================================================================================================================
// APB SLAVE   connection #3

	  `define 	APB_SLAVE_3 				`FPGA_TRANSACTORS_TOP          // example:  fpga_tcss_top.tcss_val_rtl.tcss.par_iom
       
   assign 	`TRANSACTORS_PATH.s_pclk[3] 	 		= `APB_SLAVE_3.s_pclk_3; 
   assign 	`TRANSACTORS_PATH.s_prst_n[3]     = `APB_SLAVE_3.s_prstn_3;
  
   assign  `TRANSACTORS_PATH.s_pwdata[3]    =  `APB_SLAVE_3.s_pwdata_3;       
   assign  `TRANSACTORS_PATH.s_psel[3]      =  `APB_SLAVE_3.s_psel_3;         
   assign  `TRANSACTORS_PATH.s_penable[3]   =  `APB_SLAVE_3.s_penable_3;      
   assign  `TRANSACTORS_PATH.s_pwrite[3]    =  `APB_SLAVE_3.s_pwrite_3;       
   assign  `TRANSACTORS_PATH.s_paddr[3]     =  `APB_SLAVE_3.s_paddr_3;        
   assign  `APB_SLAVE_3.s_pready_3         =  `TRANSACTORS_PATH.s_pready[3];  
   assign  `APB_SLAVE_3.s_prdata_3         =  `TRANSACTORS_PATH.s_prdata[3];  

  




