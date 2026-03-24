//=================================================================================================================================
// SB_AGENT connections - USER MUST EDIT THE RIGHT HAND SIDE OF THE FOLLOWING ASSIGNMENTS AND DEFINE - WHEN THIS TRANSACTOR IS USED
//=================================================================================================================================
// SB_AGENT   connection #4


`define 	SB_FABRIC_PATH_4  					fpga_transactors_top_inst   // example:  fpga_tcss_top.tcss_val_rtl.tcss.par_iom    //HERE USER SHOULD SET THE PATH TO HIS SIDE OF THE SB INTEFACE - THE AGENT SIDE
						

//input
assign `TRANSACTORS_PATH.sb_agent_clk[4] 							= `SB_FABRIC_PATH_4.sb_agent_clock;
assign `TRANSACTORS_PATH.rst_sb_agent_n[4] 							= `SB_FABRIC_PATH_4.reset_sb_agent_n;

//Egress Port Interface SB
assign `TRANSACTORS_PATH.mpccup[4] 									= `SB_FABRIC_PATH_4.mpccup_4;
assign `TRANSACTORS_PATH.mnpcup[4] 									= `SB_FABRIC_PATH_4.mnpcup_4;

//Ingress
assign `TRANSACTORS_PATH.tpcput[4] 									= `SB_FABRIC_PATH_4.tpcput_4;
assign `TRANSACTORS_PATH.tnpput[4] 									= `SB_FABRIC_PATH_4.tnpput_4;
assign `TRANSACTORS_PATH.teom[4] 									= `SB_FABRIC_PATH_4.teom_4;
assign `TRANSACTORS_PATH.tpayload[4][SB_AGENT_MAXPLDBIT_SRC_4:0] 	= `SB_FABRIC_PATH_4.tpayload_4;   ///*[SB_AGENT_MAXPLDBIT_SRC_4:0]*/;

assign `TRANSACTORS_PATH.side_ism_fabric[4] 						= `SB_FABRIC_PATH_4.side_ism_fabric_4;
assign `TRANSACTORS_PATH.side_clkack[4] 							= `SB_FABRIC_PATH_4.side_clkack_4;

//=================================================================================================================================
// SB_AGENT connections - USER MUST EDIT THE LEFT HAND SIDE OF THE FOLLOWING ASSIGNMENTS  - WHEN THIS TRANSACTOR IS USED
//=================================================================================================================================

//Egress Port Interface SB
assign `SB_FABRIC_PATH_4.mpcput_4 									= `TRANSACTORS_PATH.mpcput[4];
assign `SB_FABRIC_PATH_4.mnpput_4 									= `TRANSACTORS_PATH.mnpput[4];
assign `SB_FABRIC_PATH_4.meom_4 										= `TRANSACTORS_PATH.meom[4];
assign `SB_FABRIC_PATH_4.mpayload_4/*[SB_AGENT_MAXPLDBIT_SRC_4:0]*/ 	= `TRANSACTORS_PATH.mpayload[4][SB_AGENT_MAXPLDBIT_SRC_4:0];

//Ingress
assign `SB_FABRIC_PATH_4.tpccup_4 									= `TRANSACTORS_PATH.tpccup[4];
assign `SB_FABRIC_PATH_4.tnpcup_4 									= `TRANSACTORS_PATH.tnpcup[4];

assign `SB_FABRIC_PATH_4.side_ism_agent_4 							= `TRANSACTORS_PATH.side_ism_agent[4];
assign `SB_FABRIC_PATH_4.side_clkreq_4 								= `TRANSACTORS_PATH.side_clkreq[4];

//=================================================================================================================================

