//=================================================================================================================================
// APB connections - USER MUST EDIT THE RIGHT HAND SIDE OF THE FOLLOWING ASSIGNMENTS AND DEFINE - WHEN NEEDED
//=================================================================================================================================
// APB MASTER   connection #1

	  `define 	APB_MASTER_2				`FPGA_TRANSACTORS_TOP          // example:  fpga_tcss_top.tcss_val_rtl.tcss.par_iom
       
   assign 	`TRANSACTORS_PATH.m_pclk[2] 	 		= `APB_MASTER_2.m_pclk_2; 
   assign 	`TRANSACTORS_PATH.m_prst_n[2]     = `APB_MASTER_2.m_prstn_2;
  
   assign   `APB_MASTER_2.m_pwdata_2        = `TRANSACTORS_PATH.m_pwdata[2];
   assign   `APB_MASTER_2.m_psel_2          = `TRANSACTORS_PATH.m_psel[2];
   assign   `APB_MASTER_2.m_penable_2       = `TRANSACTORS_PATH.m_penable[2];
   assign   `APB_MASTER_2.m_pwrite_2        = `TRANSACTORS_PATH.m_pwrite[2];
   assign   `APB_MASTER_2.m_paddr_2         = `TRANSACTORS_PATH.m_paddr[2];
   assign 	`TRANSACTORS_PATH.m_pready[2]   = `APB_MASTER_2.m_pready_2;
   assign 	`TRANSACTORS_PATH.m_prdata[2]   = `APB_MASTER_2.m_prdata_2;

   


