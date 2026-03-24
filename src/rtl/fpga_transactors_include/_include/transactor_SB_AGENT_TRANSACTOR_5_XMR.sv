//=================================================================================================================================
// SB_AGENT connections - USER MUST EDIT THE RIGHT HAND SIDE OF THE FOLLOWING ASSIGNMENTS AND DEFINE - WHEN THIS TRANSACTOR IS USED
//=================================================================================================================================
// SB_AGENT   connection #5


`define 	SB_FABRIC_PATH_5  					fpga_transactors_top_inst   // example:  fpga_tcss_top.tcss_val_rtl.tcss.par_iom    //HERE USER SHOULD SET THE PATH TO HIS SIDE OF THE SB INTEFACE - THE AGENT SIDE
						

//input
assign `TRANSACTORS_PATH.sb_agent_clk[5] 							= `SB_FABRIC_PATH_5.sb_agent_clock;
assign `TRANSACTORS_PATH.rst_sb_agent_n[5] 							= `SB_FABRIC_PATH_5.reset_sb_agent_n;

//Egress Port Interface SB
assign `TRANSACTORS_PATH.mpccup[5] 									= `SB_FABRIC_PATH_5.mpccup_5;
assign `TRANSACTORS_PATH.mnpcup[5] 									= `SB_FABRIC_PATH_5.mnpcup_5;

//Ingress
assign `TRANSACTORS_PATH.tpcput[5] 									= `SB_FABRIC_PATH_5.tpcput_5;
assign `TRANSACTORS_PATH.tnpput[5] 									= `SB_FABRIC_PATH_5.tnpput_5;
assign `TRANSACTORS_PATH.teom[5] 									= `SB_FABRIC_PATH_5.teom_5;
assign `TRANSACTORS_PATH.tpayload[5][SB_AGENT_MAXPLDBIT_SRC_5:0] 	= `SB_FABRIC_PATH_5.tpayload_5;  ///*[SB_AGENT_MAXPLDBIT_SRC_5:0]*/;

assign `TRANSACTORS_PATH.side_ism_fabric[5] 						= `SB_FABRIC_PATH_5.side_ism_fabric_5;
assign `TRANSACTORS_PATH.side_clkack[5] 							= `SB_FABRIC_PATH_5.side_clkack_5;

//=================================================================================================================================
// SB_AGENT connections - USER MUST EDIT THE LEFT HAND SIDE OF THE FOLLOWING ASSIGNMENTS  - WHEN THIS TRANSACTOR IS USED
//=================================================================================================================================

//Egress Port Interface SB
assign `SB_FABRIC_PATH_5.mpcput_5 									= `TRANSACTORS_PATH.mpcput[5];
assign `SB_FABRIC_PATH_5.mnpput_5 									= `TRANSACTORS_PATH.mnpput[5];
assign `SB_FABRIC_PATH_5.meom_5 										= `TRANSACTORS_PATH.meom[5];
assign `SB_FABRIC_PATH_5.mpayload_5/*[SB_AGENT_MAXPLDBIT_SRC_5:0]*/	= `TRANSACTORS_PATH.mpayload[5][SB_AGENT_MAXPLDBIT_SRC_5:0];

//Ingress
assign `SB_FABRIC_PATH_5.tpccup_5 									= `TRANSACTORS_PATH.tpccup[5];
assign `SB_FABRIC_PATH_5.tnpcup_5 									= `TRANSACTORS_PATH.tnpcup[5];

assign `SB_FABRIC_PATH_5.side_ism_agent_5 							= `TRANSACTORS_PATH.side_ism_agent[5];
assign `SB_FABRIC_PATH_5.side_clkreq_5 								= `TRANSACTORS_PATH.side_clkreq[5];

//=================================================================================================================================

