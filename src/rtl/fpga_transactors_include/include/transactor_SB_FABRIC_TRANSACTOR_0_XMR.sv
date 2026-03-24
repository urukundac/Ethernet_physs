//=================================================================================================================================
// SB_FABRIC connections - USER MUST EDIT THE RIGHT HAND SIDE OF THE FOLLOWING ASSIGNMENTS AND DEFINE - WHEN THIS TRANSACTOR IS USED
//=================================================================================================================================
// SB_FABRIC   connection #0

`define 	SB_AGENT_PATH_0  					`FPGA_TRANSACTORS_TOP   // example:  fpga_tcss_top.tcss_val_rtl.tcss.par_iom    //HERE USER SHOULD SET THE PATH TO HIS SIDE OF THE SB INTEFACE - THE AGENT SIDE
						

//input
assign `TRANSACTORS_PATH.sb_fabric_clk[0]   								= `SB_AGENT_PATH_0.sb_fabric_clock;
assign `TRANSACTORS_PATH.rst_sb_fabric_n[0] 								= `SB_AGENT_PATH_0.reset_sb_fabric_n;

//Egress Port Interface SB
assign `TRANSACTORS_PATH.fabric_tpccup[0] 									= `SB_AGENT_PATH_0.tpccup_0;
assign `TRANSACTORS_PATH.fabric_tnpcup[0] 									= `SB_AGENT_PATH_0.tnpcup_0;

//Ingress
assign `TRANSACTORS_PATH.fabric_mpcput[0] 									= `SB_AGENT_PATH_0.mpcput_0;
assign `TRANSACTORS_PATH.fabric_mnpput[0] 									= `SB_AGENT_PATH_0.mnpput_0;
assign `TRANSACTORS_PATH.fabric_meom[0] 									= `SB_AGENT_PATH_0.meom_0;
assign `TRANSACTORS_PATH.fabric_mpayload[0][SB_FABRIC_MAXPLDBIT_SRC_0:0] 	= `SB_AGENT_PATH_0.mpayload_0; /////*[SB_FABRIC_MAXPLDBIT_SRC_0:0]*/;

assign `TRANSACTORS_PATH.fabric_side_ism_agent[0] 							= `SB_AGENT_PATH_0.side_ism_agent_0;
assign `TRANSACTORS_PATH.fabric_side_clkreq[0] 								= `SB_AGENT_PATH_0.side_clkreq_0;

//=================================================================================================================================
// SB_FABRIC connections - USER MUST EDIT THE LEFT HAND SIDE OF THE FOLLOWING ASSIGNMENTS  - WHEN THIS TRANSACTOR IS USED
//=================================================================================================================================


//Egress Port Interface SB
assign `SB_AGENT_PATH_0.tpcput_0 											= `TRANSACTORS_PATH.fabric_tpcput[0];
assign `SB_AGENT_PATH_0.tnpput_0 											= `TRANSACTORS_PATH.fabric_tnpput[0];
assign `SB_AGENT_PATH_0.teom_0   											= `TRANSACTORS_PATH.fabric_teom[0];
assign `SB_AGENT_PATH_0.tpayload_0/*[SB_FABRIC_MAXPLDBIT_SRC_0:0]*/ 		= `TRANSACTORS_PATH.fabric_tpayload[0][SB_FABRIC_MAXPLDBIT_SRC_0:0];

//Ingress
assign `SB_AGENT_PATH_0.mpccup_0 											= `TRANSACTORS_PATH.fabric_mpccup[0];
assign `SB_AGENT_PATH_0.mnpcup_0 											= `TRANSACTORS_PATH.fabric_mnpcup[0];

assign `SB_AGENT_PATH_0.side_ism_fabric_0 									= `TRANSACTORS_PATH.fabric_side_ism_fabric[0];
assign `SB_AGENT_PATH_0.side_clkack_0 										= `TRANSACTORS_PATH.fabric_side_clkack[0];
						
//=================================================================================================================================
