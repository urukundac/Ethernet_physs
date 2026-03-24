//=================================================================================================================================
// APB connections - USER MUST EDIT THE RIGHT HAND SIDE OF THE FOLLOWING ASSIGNMENTS AND DEFINE - WHEN NEEDED
//=================================================================================================================================
// APB MASTER   connection #0

	  `define 	APB_SLAVE_0 				fpga_transactors_top_inst          // example:  fpga_tcss_top.tcss_val_rtl.tcss.par_iom
       
   assign 	`TRANSACTORS_PATH.m_pclk[0] 	 		= `APB_SLAVE_0.m_pclk_0; 
   assign 	`TRANSACTORS_PATH.m_prst_n[0]     = `APB_SLAVE_0.m_prstn_0;
  
   assign   `APB_SLAVE_0.m_pwdata_0        = `TRANSACTORS_PATH.m_pwdata[0];
   assign   `APB_SLAVE_0.m_psel_0          = `TRANSACTORS_PATH.m_psel[0];
   assign   `APB_SLAVE_0.m_penable_0       = `TRANSACTORS_PATH.m_penable[0];
   assign   `APB_SLAVE_0.m_pwrite_0        = `TRANSACTORS_PATH.m_pwrite[0];
   assign   `APB_SLAVE_0.m_paddr_0         = `TRANSACTORS_PATH.m_paddr[0];
   assign 	`TRANSACTORS_PATH.m_pready[0]   = `APB_SLAVE_0.m_pready_0;
   assign 	`TRANSACTORS_PATH.m_prdata[0]   = `APB_SLAVE_0.m_prdata_0;

   
