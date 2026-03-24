//=================================================================================================================================
// APB connections - USER MUST EDIT THE RIGHT HAND SIDE OF THE FOLLOWING ASSIGNMENTS AND DEFINE - WHEN NEEDED
//=================================================================================================================================
// APB MASTER   connection #1

	  `define 	APB_MASTER_1 				fpga_transactors_top_inst          // example:  fpga_tcss_top.tcss_val_rtl.tcss.par_iom
       
   assign 	`TRANSACTORS_PATH.m_pclk[1] 	 		= `APB_MASTER_1.m_pclk_1; 
   assign 	`TRANSACTORS_PATH.m_prst_n[1]     = `APB_MASTER_1.m_prstn_1;
  
   assign   `APB_MASTER_1.m_pwdata_1        = `TRANSACTORS_PATH.m_pwdata[1];
   assign   `APB_MASTER_1.m_psel_1          = `TRANSACTORS_PATH.m_psel[1];
   assign   `APB_MASTER_1.m_penable_1       = `TRANSACTORS_PATH.m_penable[1];
   assign   `APB_MASTER_1.m_pwrite_1        = `TRANSACTORS_PATH.m_pwrite[1];
   assign   `APB_MASTER_1.m_paddr_1         = `TRANSACTORS_PATH.m_paddr[1];
   assign 	`TRANSACTORS_PATH.m_pready[1]   = `APB_MASTER_1.m_pready_1;
   assign 	`TRANSACTORS_PATH.m_prdata[1]   = `APB_MASTER_1.m_prdata_1;

   

