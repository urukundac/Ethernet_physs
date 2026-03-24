//=================================================================================================================================
// SB_AGENT connections - USER MUST EDIT THE RIGHT HAND SIDE OF THE FOLLOWING ASSIGNMENTS AND DEFINE - WHEN THIS TRANSACTOR IS USED
//=================================================================================================================================
// SB_AGENT   connection #2


`define 	SB_FABRIC_PATH_2  					fpga_transactors_top_inst   // example:  fpga_tcss_top.tcss_val_rtl.tcss.par_iom    //HERE USER SHOULD SET THE PATH TO HIS SIDE OF THE SB INTEFACE - THE AGENT SIDE
						

//input
assign `TRANSACTORS_PATH.sb_agent_clk[2] 							= `SB_FABRIC_PATH_2.sb_agent_clock;
assign `TRANSACTORS_PATH.rst_sb_agent_n[2] 							= `SB_FABRIC_PATH_2.reset_sb_agent_n;

//Egress Port Interface SB
assign `TRANSACTORS_PATH.mpccup[2] 									= `SB_FABRIC_PATH_2.mpccup_2;
assign `TRANSACTORS_PATH.mnpcup[2] 									= `SB_FABRIC_PATH_2.mnpcup_2;

//Ingress
assign `TRANSACTORS_PATH.tpcput[2] 									= `SB_FABRIC_PATH_2.tpcput_2;
assign `TRANSACTORS_PATH.tnpput[2] 									= `SB_FABRIC_PATH_2.tnpput_2;
assign `TRANSACTORS_PATH.teom[2] 									= `SB_FABRIC_PATH_2.teom_2;
assign `TRANSACTORS_PATH.tpayload[2][SB_AGENT_MAXPLDBIT_SRC_2:0] 	= `SB_FABRIC_PATH_2.tpayload_2;  ///*[SB_AGENT_MAXPLDBIT_SRC_2:0]*/;

assign `TRANSACTORS_PATH.side_ism_fabric[2] 						= `SB_FABRIC_PATH_2.side_ism_fabric_2;
assign `TRANSACTORS_PATH.side_clkack[2] 							= `SB_FABRIC_PATH_2.side_clkack_2;

//=================================================================================================================================
// SB_AGENT connections - USER MUST EDIT THE LEFT HAND SIDE OF THE FOLLOWING ASSIGNMENTS  - WHEN THIS TRANSACTOR IS USED
//=================================================================================================================================

//Egress Port Interface SB
assign `SB_FABRIC_PATH_2.mpcput_2 									= `TRANSACTORS_PATH.mpcput[2];
assign `SB_FABRIC_PATH_2.mnpput_2 									= `TRANSACTORS_PATH.mnpput[2];
assign `SB_FABRIC_PATH_2.meom_2 										= `TRANSACTORS_PATH.meom[2];
assign `SB_FABRIC_PATH_2.mpayload_2/*[SB_AGENT_MAXPLDBIT_SRC_2:0]*/  = `TRANSACTORS_PATH.mpayload[2][SB_AGENT_MAXPLDBIT_SRC_2:0];

//Ingress
assign `SB_FABRIC_PATH_2.tpccup_2 									= `TRANSACTORS_PATH.tpccup[2];
assign `SB_FABRIC_PATH_2.tnpcup_2 									= `TRANSACTORS_PATH.tnpcup[2];

assign `SB_FABRIC_PATH_2.side_ism_agent_2 							= `TRANSACTORS_PATH.side_ism_agent[2];
assign `SB_FABRIC_PATH_2.side_clkreq_2 								= `TRANSACTORS_PATH.side_clkreq[2];

//=================================================================================================================================

