//=================================================================================================================================
// SB_AGENT connections - USER MUST EDIT THE RIGHT HAND SIDE OF THE FOLLOWING ASSIGNMENTS AND DEFINE - WHEN THIS TRANSACTOR IS USED
//=================================================================================================================================
// SB_FABRIC   connection #0


`define 	SB_FABRIC_PATH_0  					fpga_transactors_top_inst   // example:  fpga_tcss_top.tcss_val_rtl.tcss.par_iom    //HERE USER SHOULD SET THE PATH TO HIS SIDE OF THE SB INTEFACE - THE AGENT SIDE
						

//input
assign `TRANSACTORS_PATH.sb_agent_clk[0] 							= `SB_FABRIC_PATH_0.sb_agent_clock;
assign `TRANSACTORS_PATH.rst_sb_agent_n[0] 							= `SB_FABRIC_PATH_0.reset_sb_agent_n;

//Egress Port Interface SB
assign `TRANSACTORS_PATH.mpccup[0] 									= `SB_FABRIC_PATH_0.mpccup_0;
assign `TRANSACTORS_PATH.mnpcup[0] 									= `SB_FABRIC_PATH_0.mnpcup_0;

//Ingress
assign `TRANSACTORS_PATH.tpcput[0] 									= `SB_FABRIC_PATH_0.tpcput_0;
assign `TRANSACTORS_PATH.tnpput[0] 									= `SB_FABRIC_PATH_0.tnpput_0;
assign `TRANSACTORS_PATH.teom[0] 									= `SB_FABRIC_PATH_0.teom_0;
assign `TRANSACTORS_PATH.tpayload[0][SB_AGENT_MAXPLDBIT_SRC_0:0] 	= `SB_FABRIC_PATH_0.tpayload_0;  ///*[SB_AGENT_MAXPLDBIT_SRC_0:0]*/;

assign `TRANSACTORS_PATH.side_ism_fabric[0] 						= `SB_FABRIC_PATH_0.side_ism_fabric_0;
assign `TRANSACTORS_PATH.side_clkack[0] 							= `SB_FABRIC_PATH_0.side_clkack_0;

//=================================================================================================================================
// SB_FABRIC connections - USER MUST EDIT THE LEFT HAND SIDE OF THE FOLLOWING ASSIGNMENTS  - WHEN THIS TRANSACTOR IS USED
//=================================================================================================================================

//Egress Port Interface SB
assign `SB_FABRIC_PATH_0.mpcput_0 									= `TRANSACTORS_PATH.mpcput[0];
assign `SB_FABRIC_PATH_0.mnpput_0 									= `TRANSACTORS_PATH.mnpput[0];
assign `SB_FABRIC_PATH_0.meom_0 										= `TRANSACTORS_PATH.meom[0];
assign `SB_FABRIC_PATH_0.mpayload_0/*[SB_AGENT_MAXPLDBIT_SRC_0:0]*/ 	= `TRANSACTORS_PATH.mpayload[0][SB_AGENT_MAXPLDBIT_SRC_0:0];

//Ingress
assign `SB_FABRIC_PATH_0.tpccup_0 									= `TRANSACTORS_PATH.tpccup[0];
assign `SB_FABRIC_PATH_0.tnpcup_0 									= `TRANSACTORS_PATH.tnpcup[0];

assign `SB_FABRIC_PATH_0.side_ism_agent_0 							= `TRANSACTORS_PATH.side_ism_agent[0];
assign `SB_FABRIC_PATH_0.side_clkreq_0 								= `TRANSACTORS_PATH.side_clkreq[0];

//=================================================================================================================================

