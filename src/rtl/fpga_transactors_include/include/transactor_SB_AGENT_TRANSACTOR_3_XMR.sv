//=================================================================================================================================
// SB_AGENT connections - USER MUST EDIT THE RIGHT HAND SIDE OF THE FOLLOWING ASSIGNMENTS AND DEFINE - WHEN THIS TRANSACTOR IS USED
//=================================================================================================================================
// SB_AGENT   connection #3


`define 	SB_FABRIC_PATH_3  					`FPGA_TRANSACTORS_TOP   // example:  fpga_tcss_top.tcss_val_rtl.tcss.par_iom    //HERE USER SHOULD SET THE PATH TO HIS SIDE OF THE SB INTEFACE - THE AGENT SIDE
						

//input
assign `TRANSACTORS_PATH.sb_agent_clk[3] 							= `SB_FABRIC_PATH_3.sb_agent_clock;
assign `TRANSACTORS_PATH.rst_sb_agent_n[3] 							= `SB_FABRIC_PATH_3.reset_sb_agent_n;

//Egress Port Interface SB
assign `TRANSACTORS_PATH.mpccup[3] 									= `SB_FABRIC_PATH_3.mpccup_3;
assign `TRANSACTORS_PATH.mnpcup[3] 									= `SB_FABRIC_PATH_3.mnpcup_3;

//Ingress
assign `TRANSACTORS_PATH.tpcput[3] 									= `SB_FABRIC_PATH_3.tpcput_3;
assign `TRANSACTORS_PATH.tnpput[3] 									= `SB_FABRIC_PATH_3.tnpput_3;
assign `TRANSACTORS_PATH.teom[3] 									= `SB_FABRIC_PATH_3.teom_3;
assign `TRANSACTORS_PATH.tpayload[3][SB_AGENT_MAXPLDBIT_SRC_3:0] 	= `SB_FABRIC_PATH_3.tpayload_3;  ///*[SB_AGENT_MAXPLDBIT_SRC_3:0]*/;

assign `TRANSACTORS_PATH.side_ism_fabric[3] 						= `SB_FABRIC_PATH_3.side_ism_fabric_3;
assign `TRANSACTORS_PATH.side_clkack[3] 							= `SB_FABRIC_PATH_3.side_clkack_3;

//=================================================================================================================================
// SB_AGENT connections - USER MUST EDIT THE LEFT HAND SIDE OF THE FOLLOWING ASSIGNMENTS  - WHEN THIS TRANSACTOR IS USED
//=================================================================================================================================

//Egress Port Interface SB
assign `SB_FABRIC_PATH_3.mpcput_3 									= `TRANSACTORS_PATH.mpcput[3];
assign `SB_FABRIC_PATH_3.mnpput_3 									= `TRANSACTORS_PATH.mnpput[3];
assign `SB_FABRIC_PATH_3.meom_3 										= `TRANSACTORS_PATH.meom[3];
assign `SB_FABRIC_PATH_3.mpayload_3/*[SB_AGENT_MAXPLDBIT_SRC_3:0]*/ 	= `TRANSACTORS_PATH.mpayload[3][SB_AGENT_MAXPLDBIT_SRC_3:0];

//Ingress
assign `SB_FABRIC_PATH_3.tpccup_3 									= `TRANSACTORS_PATH.tpccup[3];
assign `SB_FABRIC_PATH_3.tnpcup_3 									= `TRANSACTORS_PATH.tnpcup[3];

assign `SB_FABRIC_PATH_3.side_ism_agent_3 							= `TRANSACTORS_PATH.side_ism_agent[3];
assign `SB_FABRIC_PATH_3.side_clkreq_3 								= `TRANSACTORS_PATH.side_clkreq[3];

//=================================================================================================================================

