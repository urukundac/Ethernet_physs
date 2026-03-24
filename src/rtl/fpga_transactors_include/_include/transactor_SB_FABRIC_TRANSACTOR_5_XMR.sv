//=================================================================================================================================
// SB_FABRIC connections - USER MUST EDIT THE RIGHT HAND SIDE OF THE FOLLOWING ASSIGNMENTS AND DEFINE - WHEN THIS TRANSACTOR IS USED
//=================================================================================================================================
// SB_FABRIC   connection #5

`define 	SB_AGENT_PATH_5  					fpga_transactors_top_inst   // example:  fpga_tcss_top.tcss_val_rtl.tcss.par_iom    //HERE USER SHOULD SET THE PATH TO HIS SIDE OF THE SB INTEFACE - THE AGENT SIDE
						

//input
assign `TRANSACTORS_PATH.sb_fabric_clk[5]   								= `SB_AGENT_PATH_5.sb_fabric_clock;
assign `TRANSACTORS_PATH.rst_sb_fabric_n[5] 								= `SB_AGENT_PATH_5.reset_sb_fabric_n;

//Egress Port Interface SB
assign `TRANSACTORS_PATH.fabric_tpccup[5] 									= `SB_AGENT_PATH_5.tpccup_5;
assign `TRANSACTORS_PATH.fabric_tnpcup[5] 									= `SB_AGENT_PATH_5.tnpcup_5;

//Ingress
assign `TRANSACTORS_PATH.fabric_mpcput[5] 									= `SB_AGENT_PATH_5.mpcput_5;
assign `TRANSACTORS_PATH.fabric_mnpput[5] 									= `SB_AGENT_PATH_5.mnpput_5;
assign `TRANSACTORS_PATH.fabric_meom[5] 									= `SB_AGENT_PATH_5.meom_5;
assign `TRANSACTORS_PATH.fabric_mpayload[5][SB_FABRIC_MAXPLDBIT_SRC_5:0] 	= `SB_AGENT_PATH_5.mpayload_5;  ///*[SB_FABRIC_MAXPLDBIT_SRC_5:0]*/;

assign `TRANSACTORS_PATH.fabric_side_ism_agent[5] 							= `SB_AGENT_PATH_5.side_ism_agent_5;
assign `TRANSACTORS_PATH.fabric_side_clkreq[5] 								= `SB_AGENT_PATH_5.side_clkreq_5;

//=================================================================================================================================
// SB_FABRIC connections - USER MUST EDIT THE LEFT HAND SIDE OF THE FOLLOWING ASSIGNMENTS  - WHEN THIS TRANSACTOR IS USED
//=================================================================================================================================


//Egress Port Interface SB
assign `SB_AGENT_PATH_5.tpcput_5 											= `TRANSACTORS_PATH.fabric_tpcput[5];
assign `SB_AGENT_PATH_5.tnpput_5 											= `TRANSACTORS_PATH.fabric_tnpput[5];
assign `SB_AGENT_PATH_5.teom_5   											= `TRANSACTORS_PATH.fabric_teom[5];
assign `SB_AGENT_PATH_5.tpayload_5/*[SB_FABRIC_MAXPLDBIT_SRC_5:0]*/ 		= `TRANSACTORS_PATH.fabric_tpayload[5][SB_FABRIC_MAXPLDBIT_SRC_5:0];

//Ingress
assign `SB_AGENT_PATH_5.mpccup_5 											= `TRANSACTORS_PATH.fabric_mpccup[5];
assign `SB_AGENT_PATH_5.mnpcup_5 											= `TRANSACTORS_PATH.fabric_mnpcup[5];

assign `SB_AGENT_PATH_5.side_ism_fabric_5 									= `TRANSACTORS_PATH.fabric_side_ism_fabric[5];
assign `SB_AGENT_PATH_5.side_clkack_5 										= `TRANSACTORS_PATH.fabric_side_clkack[5];

//=================================================================================================================================
