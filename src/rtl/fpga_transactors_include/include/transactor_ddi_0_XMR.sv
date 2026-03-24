//=================================================================================================================================
// DDI_TRANSACTOR connections - USER MUST EDIT THE RIGHT HAND SIDE OF THE FOLLOWING ASSIGNMENTS AND DEFINE - WHEN NEEDED
//=================================================================================================================================
// DDI_TRANSACTOR   connection #0

			`define 	DDI_TRANSACTOR 					`FPGA_TRANSACTORS_TOP       // example:  fpga_tcss_top.tcss_val_rtl.tcss.par_iom

assign 		`TRANSACTORS_PATH.ddi_clock[0] 				     = `DDI_TRANSACTOR.ddi_clock_0; 
assign 		`TRANSACTORS_PATH.ddi_rstn[0] 			       = `DDI_TRANSACTOR.ddi_rstn_0; 
                                                                                      

