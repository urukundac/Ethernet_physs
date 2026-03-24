//=================================================================================================================================
// APB connections - USER MUST EDIT THE RIGHT HAND SIDE OF THE FOLLOWING ASSIGNMENTS AND DEFINE - WHEN NEEDED
//=================================================================================================================================
// APB SLAVE   connection #2

	  `define 	APB_SLAVE_2 				fpga_transactors_top_inst          // example:  fpga_tcss_top.tcss_val_rtl.tcss.par_iom
       
   assign 	`TRANSACTORS_PATH.s_pclk[2] 	 		= `APB_SLAVE_2.s_pclk_2; 
   assign 	`TRANSACTORS_PATH.s_prst_n[2]     = `APB_SLAVE_2.s_prstn_2;
  
   assign  `TRANSACTORS_PATH.s_pwdata[2]    =  `APB_SLAVE_2.s_pwdata_2;       
   assign  `TRANSACTORS_PATH.s_psel[2]      =  `APB_SLAVE_2.s_psel_2;         
   assign  `TRANSACTORS_PATH.s_penable[2]   =  `APB_SLAVE_2.s_penable_2;      
   assign  `TRANSACTORS_PATH.s_pwrite[2]    =  `APB_SLAVE_2.s_pwrite_2;       
   assign  `TRANSACTORS_PATH.s_paddr[2]     =  `APB_SLAVE_2.s_paddr_2;        
   assign  `APB_SLAVE_2.s_pready_2         =  `TRANSACTORS_PATH.s_pready[2];  
   assign  `APB_SLAVE_2.s_prdata_2         =  `TRANSACTORS_PATH.s_prdata[2];  

  



