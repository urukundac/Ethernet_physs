//==================================================================================================================================================
// Teamplate Transactor connections - USER MUST EDIT THE RIGHT HAND SIDE OF THE FOLLOWING ASSIGNMENTS AND DEFINE - WHEN THIS TRANSACTOR IS USED   ==
//==================================================================================================================================================
// Template Transactor   connection #5


							`define 	TEMPLATE_TRANSACOR_5 					fpga_transactors_top_inst   // example:  fpga_tcss_top.tcss_val_rtl.tcss.par_iom    //HERE USER SHOULD SET THE PATH TO HIS SIDE OF THE TEAMPLATE TRANSACTOR
						
assign 				  		`TRANSACTORS_PATH.Template_Transactor_clk[5] 								= `TEMPLATE_TRANSACOR_5.TEMPLATE_Transactor_clk_5;
assign 				  		`TRANSACTORS_PATH.Template_Transactor_rstn[5] 								= `TEMPLATE_TRANSACOR_5.TEMPLATE_Transactor_rstn_5;



//inputs to FGT - to Template Transactor
assign                  	`TRANSACTORS_PATH.Template_Transactor_input_port[5]     					= `TEMPLATE_TRANSACOR_5.TEMPLATE_Transactor_opposite_side_output_port_5;
//   USER CAN CONTINUE AND ADD LINES HERE ACCORING TO HIS NEEDS. FOR EXAMPLE:
//assign                  	`TRANSACTORS_PATH.Template_input_port[5][4:0]  								= `TEMPLATE_TRANSACOR_5.address;
//assign                  	`TRANSACTORS_PATH.Template_input_port[5][131:5] 							= `TEMPLATE_TRANSACOR_5.data;


//=================================================================================================================================
// Template Transactor connections - USER MUST EDIT THE LEFT HAND SIDE OF THE FOLLOWING ASSIGNMENTS  - WHEN THIS TRANSACTOR IS USED
//=================================================================================================================================


//outputs from FGT - from Template Transactor
assign  				 	`TEMPLATE_TRANSACOR_5.TEMPLATE_Transactor_opposite_side_input_port_5		= `TRANSACTORS_PATH.Template_Transactor_output_port[5];
//   USER CAN CONTINUE AND ADD LINES HERE ACCORING TO HIS NEEDS. FOR EXAMPLE:
//assign                  	`TEMPLATE_TRANSACOR_5.config_addr											= `TRANSACTORS_PATH.Template_output_port[5][63:0];
//assign                  	`TEMPLATE_TRANSACOR_5.address_low											= `TRANSACTORS_PATH.Template_output_port[5][69:64];

//=================================================================================================================================


	
