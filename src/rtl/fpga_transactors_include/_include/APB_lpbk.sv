// Loop back connection for SA simulation and Synthesis
`define 	APB_MASTER_0 				fpga_transactors_top_inst       // example:  fpga_tcss_top.tcss_val_rtl.tcss.par_iom
`define 	APB_SLAVE_0 					fpga_transactors_top_inst       // example:  fpga_tcss_top.tcss_val_rtl.tcss.par_iom

//APB loopback between master and slave 

assign s_pwdata_0       = m_pwdata_0;
assign s_psel_0         = m_psel_0;
assign s_penable_0      = m_penable_0;
assign s_pwrite_0       = m_pwrite_0;
assign s_paddr_0        = m_paddr_0;

assign m_pready_0       = s_pready_0;
assign m_prdata_0       = s_prdata_0;

