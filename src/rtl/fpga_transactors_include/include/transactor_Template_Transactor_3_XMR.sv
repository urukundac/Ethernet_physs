//==================================================================================================================================================
// Teamplate Transactor connections - USER MUST EDIT THE RIGHT HAND SIDE OF THE FOLLOWING ASSIGNMENTS AND DEFINE - WHEN THIS TRANSACTOR IS USED   ==
//==================================================================================================================================================
// Template Transactor   connection #3


							`define 	TEMPLATE_TRANSACOR_3 					`FPGA_TRANSACTORS_TOP   // example:  fpga_tcss_top.tcss_val_rtl.tcss.par_iom    //HERE USER SHOULD SET THE PATH TO HIS SIDE OF THE TEAMPLATE TRANSACTOR
						
assign 				  		`TRANSACTORS_PATH.Template_Transactor_clk[3] 								= `TEMPLATE_TRANSACOR_3.TEMPLATE_Transactor_clk_3;
assign 				  		`TRANSACTORS_PATH.Template_Transactor_rstn[3] 								= `TEMPLATE_TRANSACOR_3.TEMPLATE_Transactor_rstn_3;



//inputs to FGT - to Template Transactor
assign                  	`TRANSACTORS_PATH.Template_Transactor_input_port[3]     					= `TEMPLATE_TRANSACOR_3.TEMPLATE_Transactor_opposite_side_output_port_3;
//   USER CAN CONTINUE AND ADD LINES HERE ACCORING TO HIS NEEDS. FOR EXAMPLE:
//assign                  	`TRANSACTORS_PATH.Template_input_port[3][4:0]  								= `TEMPLATE_TRANSACOR_3.address;
//assign                  	`TRANSACTORS_PATH.Template_input_port[3][131:5] 							= `TEMPLATE_TRANSACOR_3.data;


//=================================================================================================================================
// Template Transactor connections - USER MUST EDIT THE LEFT HAND SIDE OF THE FOLLOWING ASSIGNMENTS  - WHEN THIS TRANSACTOR IS USED
//=================================================================================================================================


//outputs from FGT - from Template Transactor
assign  				 	`TEMPLATE_TRANSACOR_3.TEMPLATE_Transactor_opposite_side_input_port_3		= `TRANSACTORS_PATH.Template_Transactor_output_port[3];
//   USER CAN CONTINUE AND ADD LINES HERE ACCORING TO HIS NEEDS. FOR EXAMPLE:
//assign                  	`TEMPLATE_TRANSACOR_3.config_addr											= `TRANSACTORS_PATH.Template_output_port[3][63:0];
//assign                  	`TEMPLATE_TRANSACOR_3.address_low											= `TRANSACTORS_PATH.Template_output_port[3][69:64];

//=================================================================================================================================


	
