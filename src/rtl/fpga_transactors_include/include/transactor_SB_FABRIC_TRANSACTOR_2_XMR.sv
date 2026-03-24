//=================================================================================================================================
// SB_FABRIC connections - USER MUST EDIT THE RIGHT HAND SIDE OF THE FOLLOWING ASSIGNMENTS AND DEFINE - WHEN THIS TRANSACTOR IS USED
//=================================================================================================================================
// SB_FABRIC   connection #2

`define 	SB_AGENT_PATH_2  					`FPGA_TRANSACTORS_TOP   // example:  fpga_tcss_top.tcss_val_rtl.tcss.par_iom    //HERE USER SHOULD SET THE PATH TO HIS SIDE OF THE SB INTEFACE - THE AGENT SIDE
						

//input
assign `TRANSACTORS_PATH.sb_fabric_clk[2]   									= `SB_AGENT_PATH_2.sb_fabric_clock;
assign `TRANSACTORS_PATH.rst_sb_fabric_n[2] 									= `SB_AGENT_PATH_2.reset_sb_fabric_n;

//Egress Port Interface SB
assign `TRANSACTORS_PATH.fabric_tpccup[2] 										= `SB_AGENT_PATH_2.tpccup_2;
assign `TRANSACTORS_PATH.fabric_tnpcup[2] 										= `SB_AGENT_PATH_2.tnpcup_2;

//Ingress
assign `TRANSACTORS_PATH.fabric_mpcput[2] 										= `SB_AGENT_PATH_2.mpcput_2;
assign `TRANSACTORS_PATH.fabric_mnpput[2] 										= `SB_AGENT_PATH_2.mnpput_2;
assign `TRANSACTORS_PATH.fabric_meom[2] 										= `SB_AGENT_PATH_2.meom_2;
assign `TRANSACTORS_PATH.fabric_mpayload[2][SB_FABRIC_MAXPLDBIT_SRC_2:0]	 	= `SB_AGENT_PATH_2.mpayload_2;   ///*[SB_FABRIC_MAXPLDBIT_SRC_2:0]*/;

assign `TRANSACTORS_PATH.fabric_side_ism_agent[2] 								= `SB_AGENT_PATH_2.side_ism_agent_2;
assign `TRANSACTORS_PATH.fabric_side_clkreq[2] 									= `SB_AGENT_PATH_2.side_clkreq_2;

//=================================================================================================================================
// SB_FABRIC connections - USER MUST EDIT THE LEFT HAND SIDE OF THE FOLLOWING ASSIGNMENTS  - WHEN THIS TRANSACTOR IS USED
//=================================================================================================================================


//Egress Port Interface SB
assign `SB_AGENT_PATH_2.tpcput_2 												= `TRANSACTORS_PATH.fabric_tpcput[2];
assign `SB_AGENT_PATH_2.tnpput_2 												= `TRANSACTORS_PATH.fabric_tnpput[2];
assign `SB_AGENT_PATH_2.teom_2   												= `TRANSACTORS_PATH.fabric_teom[2];
assign `SB_AGENT_PATH_2.tpayload_2/*[SB_FABRIC_MAXPLDBIT_SRC_2:0]*/ 			= `TRANSACTORS_PATH.fabric_tpayload[2][SB_FABRIC_MAXPLDBIT_SRC_2:0];

//Ingress
assign `SB_AGENT_PATH_2.mpccup_2 												= `TRANSACTORS_PATH.fabric_mpccup[2];
assign `SB_AGENT_PATH_2.mnpcup_2 												= `TRANSACTORS_PATH.fabric_mnpcup[2];

assign `SB_AGENT_PATH_2.side_ism_fabric_2 										= `TRANSACTORS_PATH.fabric_side_ism_fabric[2];
assign `SB_AGENT_PATH_2.side_clkack_2 											= `TRANSACTORS_PATH.fabric_side_clkack[2];

//=================================================================================================================================
