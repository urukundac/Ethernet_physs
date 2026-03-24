//=================================================================================================================================
// SB_FABRIC connections - USER MUST EDIT THE RIGHT HAND SIDE OF THE FOLLOWING ASSIGNMENTS AND DEFINE - WHEN THIS TRANSACTOR IS USED
//=================================================================================================================================
// SB_FABRIC   connection #4

`define 	SB_AGENT_PATH_4  					`FPGA_TRANSACTORS_TOP   // example:  fpga_tcss_top.tcss_val_rtl.tcss.par_iom    //HERE USER SHOULD SET THE PATH TO HIS SIDE OF THE SB INTEFACE - THE AGENT SIDE
						

//input
assign `TRANSACTORS_PATH.sb_fabric_clk[4]   						= `SB_AGENT_PATH_4.sb_fabric_clock;
assign `TRANSACTORS_PATH.rst_sb_fabric_n[4] 						= `SB_AGENT_PATH_4.reset_sb_fabric_n;

//Egress Port Interface SB
assign `TRANSACTORS_PATH.fabric_tpccup[4] 									= `SB_AGENT_PATH_4.tpccup_4;
assign `TRANSACTORS_PATH.fabric_tnpcup[4] 									= `SB_AGENT_PATH_4.tnpcup_4;

//Ingress
assign `TRANSACTORS_PATH.fabric_mpcput[4] 									= `SB_AGENT_PATH_4.mpcput_4;
assign `TRANSACTORS_PATH.fabric_mnpput[4] 									= `SB_AGENT_PATH_4.mnpput_4;
assign `TRANSACTORS_PATH.fabric_meom[4] 									= `SB_AGENT_PATH_4.meom_4;
assign `TRANSACTORS_PATH.fabric_mpayload[4][SB_FABRIC_MAXPLDBIT_SRC_4:0] 	= `SB_AGENT_PATH_4.mpayload_4;  ///*[SB_FABRIC_MAXPLDBIT_SRC_4:0]*/;

assign `TRANSACTORS_PATH.fabric_side_ism_agent[4] 							= `SB_AGENT_PATH_4.side_ism_agent_4;
assign `TRANSACTORS_PATH.fabric_side_clkreq[4] 								= `SB_AGENT_PATH_4.side_clkreq_4;

//=================================================================================================================================
// SB_FABRIC connections - USER MUST EDIT THE LEFT HAND SIDE OF THE FOLLOWING ASSIGNMENTS  - WHEN THIS TRANSACTOR IS USED
//=================================================================================================================================


//Egress Port Interface SB
assign `SB_AGENT_PATH_4.tpcput_4 											= `TRANSACTORS_PATH.fabric_tpcput[4];
assign `SB_AGENT_PATH_4.tnpput_4 											= `TRANSACTORS_PATH.fabric_tnpput[4];
assign `SB_AGENT_PATH_4.teom_4   											= `TRANSACTORS_PATH.fabric_teom[4];
assign `SB_AGENT_PATH_4.tpayload_4/*[SB_FABRIC_MAXPLDBIT_SRC_4:0]*/ 		= `TRANSACTORS_PATH.fabric_tpayload[4][SB_FABRIC_MAXPLDBIT_SRC_4:0];

//Ingress
assign `SB_AGENT_PATH_4.mpccup_4 											= `TRANSACTORS_PATH.fabric_mpccup[4];
assign `SB_AGENT_PATH_4.mnpcup_4 											= `TRANSACTORS_PATH.fabric_mnpcup[4];

assign `SB_AGENT_PATH_4.side_ism_fabric_4 									= `TRANSACTORS_PATH.fabric_side_ism_fabric[4];
assign `SB_AGENT_PATH_4.side_clkack_4 										= `TRANSACTORS_PATH.fabric_side_clkack[4];

//=================================================================================================================================
