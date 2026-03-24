//=================================================================================================================================
// APB connections - USER MUST EDIT THE RIGHT HAND SIDE OF THE FOLLOWING ASSIGNMENTS AND DEFINE - WHEN NEEDED
//=================================================================================================================================
// APB MASTER   connection #1

	  `define 	APB_MASTER_3				fpga_transactors_top_inst          // example:  fpga_tcss_top.tcss_val_rtl.tcss.par_iom
       
   assign 	`TRANSACTORS_PATH.m_pclk[3] 	 		= `APB_MASTER_3.m_pclk_3; 
   assign 	`TRANSACTORS_PATH.m_prst_n[3]     = `APB_MASTER_3.m_prstn_3;
  
   assign   `APB_MASTER_3.m_pwdata_3        = `TRANSACTORS_PATH.m_pwdata[3];
   assign   `APB_MASTER_3.m_psel_3          = `TRANSACTORS_PATH.m_psel[3];
   assign   `APB_MASTER_3.m_penable_3       = `TRANSACTORS_PATH.m_penable[3];
   assign   `APB_MASTER_3.m_pwrite_3        = `TRANSACTORS_PATH.m_pwrite[3];
   assign   `APB_MASTER_3.m_paddr_3         = `TRANSACTORS_PATH.m_paddr[3];
   assign 	`TRANSACTORS_PATH.m_pready[3]   = `APB_MASTER_3.m_pready_3;
   assign 	`TRANSACTORS_PATH.m_prdata[3]   = `APB_MASTER_3.m_prdata_3;

   



