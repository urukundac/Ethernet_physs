//=================================================================================================================================
// SB_FABRIC connections - USER MUST EDIT THE RIGHT HAND SIDE OF THE FOLLOWING ASSIGNMENTS AND DEFINE - WHEN THIS TRANSACTOR IS USED
//=================================================================================================================================
// SB_FABRIC   connection #3

`define 	SB_AGENT_PATH_3  					`FPGA_TRANSACTORS_TOP   // example:  fpga_tcss_top.tcss_val_rtl.tcss.par_iom    //HERE USER SHOULD SET THE PATH TO HIS SIDE OF THE SB INTEFACE - THE AGENT SIDE
						

//input
assign `TRANSACTORS_PATH.sb_fabric_clk[3]   								= `SB_AGENT_PATH_3.sb_fabric_clock;
assign `TRANSACTORS_PATH.rst_sb_fabric_n[3] 								= `SB_AGENT_PATH_3.reset_sb_fabric_n;

//Egress Port Interface SB
assign `TRANSACTORS_PATH.fabric_tpccup[3] 									= `SB_AGENT_PATH_3.tpccup_3;
assign `TRANSACTORS_PATH.fabric_tnpcup[3] 									= `SB_AGENT_PATH_3.tnpcup_3;

//Ingress
assign `TRANSACTORS_PATH.fabric_mpcput[3] 									= `SB_AGENT_PATH_3.mpcput_3;
assign `TRANSACTORS_PATH.fabric_mnpput[3] 									= `SB_AGENT_PATH_3.mnpput_3;
assign `TRANSACTORS_PATH.fabric_meom[3] 									= `SB_AGENT_PATH_3.meom_3;
assign `TRANSACTORS_PATH.fabric_mpayload[3][SB_FABRIC_MAXPLDBIT_SRC_3:0]	= `SB_AGENT_PATH_3.mpayload_3;  ///*[SB_FABRIC_MAXPLDBIT_SRC_3:0]*/;

assign `TRANSACTORS_PATH.fabric_side_ism_agent[3] 							= `SB_AGENT_PATH_3.side_ism_agent_3;
assign `TRANSACTORS_PATH.fabric_side_clkreq[3] 								= `SB_AGENT_PATH_3.side_clkreq_3;

//=================================================================================================================================
// SB_FABRIC connections - USER MUST EDIT THE LEFT HAND SIDE OF THE FOLLOWING ASSIGNMENTS  - WHEN THIS TRANSACTOR IS USED
//=================================================================================================================================


//Egress Port Interface SB
assign `SB_AGENT_PATH_3.tpcput_3 											= `TRANSACTORS_PATH.fabric_tpcput[3];
assign `SB_AGENT_PATH_3.tnpput_3 											= `TRANSACTORS_PATH.fabric_tnpput[3];
assign `SB_AGENT_PATH_3.teom_3   											= `TRANSACTORS_PATH.fabric_teom[3];
assign `SB_AGENT_PATH_3.tpayload_3/*[SB_FABRIC_MAXPLDBIT_SRC_3:0]*/ 		= `TRANSACTORS_PATH.fabric_tpayload[3][SB_FABRIC_MAXPLDBIT_SRC_3:0];

//Ingress
assign `SB_AGENT_PATH_3.mpccup_3 											= `TRANSACTORS_PATH.fabric_mpccup[3];
assign `SB_AGENT_PATH_3.mnpcup_3 											= `TRANSACTORS_PATH.fabric_mnpcup[3];

assign `SB_AGENT_PATH_3.side_ism_fabric_3 									= `TRANSACTORS_PATH.fabric_side_ism_fabric[3];
assign `SB_AGENT_PATH_3.side_clkack_3 										= `TRANSACTORS_PATH.fabric_side_clkack[3];

//=================================================================================================================================
