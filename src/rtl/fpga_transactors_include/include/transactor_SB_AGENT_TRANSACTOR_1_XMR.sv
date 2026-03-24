//=================================================================================================================================
// SB_AGENT connections - USER MUST EDIT THE RIGHT HAND SIDE OF THE FOLLOWING ASSIGNMENTS AND DEFINE - WHEN THIS TRANSACTOR IS USED
//=================================================================================================================================
// SB_AGENT   connection #1


`define 	SB_FABRIC_PATH_1  					`FPGA_TRANSACTORS_TOP   // example:  fpga_tcss_top.tcss_val_rtl.tcss.par_iom    //HERE USER SHOULD SET THE PATH TO HIS SIDE OF THE SB INTEFACE - THE AGENT SIDE
						

//input
assign `TRANSACTORS_PATH.sb_agent_clk[1] 							= `SB_FABRIC_PATH_1.sb_agent_clock;
assign `TRANSACTORS_PATH.rst_sb_agent_n[1] 							= `SB_FABRIC_PATH_1.reset_sb_agent_n;

//Egress Port Interface SB
assign `TRANSACTORS_PATH.mpccup[1] 									= `SB_FABRIC_PATH_1.mpccup_1;
assign `TRANSACTORS_PATH.mnpcup[1] 									= `SB_FABRIC_PATH_1.mnpcup_1;

//Ingress
assign `TRANSACTORS_PATH.tpcput[1] 									= `SB_FABRIC_PATH_1.tpcput_1;
assign `TRANSACTORS_PATH.tnpput[1] 									= `SB_FABRIC_PATH_1.tnpput_1;
assign `TRANSACTORS_PATH.teom[1] 									= `SB_FABRIC_PATH_1.teom_1;
assign `TRANSACTORS_PATH.tpayload[1][SB_AGENT_MAXPLDBIT_SRC_1:0]    = `SB_FABRIC_PATH_1.tpayload_1; ///*[SB_AGENT_MAXPLDBIT_SRC_1:0]*/;

assign `TRANSACTORS_PATH.side_ism_fabric[1] 						= `SB_FABRIC_PATH_1.side_ism_fabric_1;
assign `TRANSACTORS_PATH.side_clkack[1] 							= `SB_FABRIC_PATH_1.side_clkack_1;

//=================================================================================================================================
// SB_AGENT connections - USER MUST EDIT THE LEFT HAND SIDE OF THE FOLLOWING ASSIGNMENTS  - WHEN THIS TRANSACTOR IS USED
//=================================================================================================================================

//Egress Port Interface SB
assign `SB_FABRIC_PATH_1.mpcput_1 									= `TRANSACTORS_PATH.mpcput[1];
assign `SB_FABRIC_PATH_1.mnpput_1 									= `TRANSACTORS_PATH.mnpput[1];
assign `SB_FABRIC_PATH_1.meom_1 										= `TRANSACTORS_PATH.meom[1];
assign `SB_FABRIC_PATH_1.mpayload_1/*[SB_AGENT_MAXPLDBIT_SRC_1:0]*/ 	= `TRANSACTORS_PATH.mpayload[1][SB_AGENT_MAXPLDBIT_SRC_1:0];

//Ingress
assign `SB_FABRIC_PATH_1.tpccup_1 									= `TRANSACTORS_PATH.tpccup[1];
assign `SB_FABRIC_PATH_1.tnpcup_1 									= `TRANSACTORS_PATH.tnpcup[1];

assign `SB_FABRIC_PATH_1.side_ism_agent_1 							= `TRANSACTORS_PATH.side_ism_agent[1];
assign `SB_FABRIC_PATH_1.side_clkreq_1 								= `TRANSACTORS_PATH.side_clkreq[1];

//=================================================================================================================================

