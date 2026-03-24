//=================================================================================================================================
// APB connections - USER MUST EDIT THE RIGHT HAND SIDE OF THE FOLLOWING ASSIGNMENTS AND DEFINE - WHEN NEEDED
//=================================================================================================================================
// APB SLAVE   connection #0

	  `define 	APB_MASTER_0 				fpga_transactors_top_inst          // example:  fpga_tcss_top.tcss_val_rtl.tcss.par_iom
       
   assign 	`TRANSACTORS_PATH.s_pclk[0] 	 		= `APB_MASTER_0.s_pclk_0; 
   assign 	`TRANSACTORS_PATH.s_prst_n[0]     = `APB_MASTER_0.s_prstn_0;
  
   assign  `TRANSACTORS_PATH.s_pwdata[0]    =  `APB_MASTER_0.s_pwdata_0;       
   assign  `TRANSACTORS_PATH.s_psel[0]      =  `APB_MASTER_0.s_psel_0;         
   assign  `TRANSACTORS_PATH.s_penable[0]   =  `APB_MASTER_0.s_penable_0;      
   assign  `TRANSACTORS_PATH.s_pwrite[0]    =  `APB_MASTER_0.s_pwrite_0;       
   assign  `TRANSACTORS_PATH.s_paddr[0]     =  `APB_MASTER_0.s_paddr_0;        
   assign  `APB_MASTER_0.s_pready_0         =  `TRANSACTORS_PATH.s_pready[0];  
   assign  `APB_MASTER_0.s_prdata_0         =  `TRANSACTORS_PATH.s_prdata[0];  
   assign  `APB_MASTER_0.s_pslverr_0         =  0;//`TRANSACTORS_PATH.s_pslverr[0];  


  

