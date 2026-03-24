  parameter IOSF_FIP_IS_ENCAPSULATED 						= 0; //what is done with the descriptor.  0=pcie to host, 1=encapsulated as data on some other protocol (indirect/FPGA2FPGA)
  //parameter IOSF_FIP_IS_FABRIC = 1;  //0 = FIP is agent, 1 = FIP is fabric
  parameter IOSF_UHFI_TTIF_PORT_EN 							= 0;  //0 =TTIF is disabled, 1=TTIF is enabled 
  parameter IOSF_DATA_WIDTH 								= 128; //32,64,128,256,512
  parameter IOSF_DATA_TARGET_WIDTH 							= IOSF_DATA_WIDTH; //32,64,128,256,512
  parameter IOSF_DATA_MASTER_WIDTH 							= IOSF_DATA_WIDTH; //32,64,128,256,512
  parameter IOSF_MAX_DATA_LEN 								= 6;
  parameter IOSF_DATA_PARITY_WIDTH 							= 1; //bits of data parity
  parameter [15:0] FABRIC_PSFPORT_MAX_NUMCHAN 				= 10; 	// maximum for all ports.  .//E.C: AS FAR AS WE UNDERSTAND - the value of this parameter should be the same value as the next parameter (but in the next parameter it appears twice)
  parameter [1:0][0:0][15:0] FABRIC_PSFPORT_NUMCHAN 		= 'h000A000A;	//E.C: AS FAR AS WE UNDERSTAND - the value of this parameter should be the same value as the previous parameter (but twice)
  parameter [15:0] FABRIC_PSFPORT_NUMCHANL2 				= 3;  	//E.C: AS FAR AS WE UNDERSTAND - the value of this parameter should be the result of the following calculation: Roundup(log2(MAX_NUMCHAN + 1)) – 1. 
  parameter IOSF_CHID_WIDTH 								= 3;	//E.C: AS FAR AS WE UNDERSTAND - the value of this parameter should be the same value as the previous parameter (or AGENT_PSFPORT_NUMCHANL2 if relavent)
  parameter [15:0] AGENT_PSFPORT_MAX_NUMCHAN 				= 10;	//E.C: AS FAR AS WE UNDERSTAND - the value of this parameter should be the same value as the next parameter (but in the next parameter it appears twice)
  parameter [1:0][0:0][15:0] AGENT_PSFPORT_NUMCHAN 			= 'h000A000A;	//E.C: AS FAR AS WE UNDERSTAND - the value of this parameter should be the same value as the previous parameter (but twice)
  parameter [15:0] AGENT_PSFPORT_NUMCHANL2 					= 3;	//E.C: AS FAR AS WE UNDERSTAND - the value of this parameter should be the result of the following calculation: Roundup(log2(MAX_NUMCHAN + 1)) – 1.
  parameter [15:0] FABRIC_PSFPORT_NUM_EXTERNAL_PIPE_STAGES 	= 0;	//E.C:  this represents the clocks between the gnt and the cmd signals (on the master port)
																	//E.C:  when the cmd is on the clock right after the gnt (clock after clock) - this should be set to 0	
  parameter [15:0] IOSF_PRI_TC_EN 							= 16'b1111111111111111; //traffic classes enabled
  parameter [15:0] IOSF_PRI_CHNL_EN 						= 16'b1111111111111111; //traffic classes enabled
  parameter ONE_FIFO_USE 									= "TRUE";
  parameter EXPANSION_MODE 									= 0;
  parameter IOSF_SRC_ID_WIDTH 								= 14;
  parameter ORDERED_COMPL_EN 								= 0;
  parameter PASSTHRU_BUS_NUM 								= 0;
  parameter IM_DS_DMA_BUFFER_TAG_80_TO_FF 					= 0;
  parameter DESC_NUM_OF_QWORDS								= 4;
  parameter [15:0]                   SHARED_CREDITS_EN           = '0;
  parameter [15:0]                   INT_SHARED_CREDITS_EN       = '0;
  parameter [15:0]                   SHARED_CMD_CREDITS_DIS      = '0;
  parameter [15:0]                   SHARED_DATA_CREDITS_DIS     = '0;


