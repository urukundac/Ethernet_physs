//=================================================================================================================================
// ICXL_HOST connections - USER MUST EDIT THE RIGHT HAND SIDE OF THE FOLLOWING ASSIGNMENTS AND DEFINE - WHEN THIS TRANSACTOR IS USED
//=================================================================================================================================
// ICXL_HOST   connection #0


							`define 	ICXL_DEVICE_0 					`FPGA_TRANSACTORS_TOP   // example:  fpga_tcss_top.tcss_val_rtl.tcss.par_iom    //HERE USER SHOULD SET THE PATH TO HIS SIDE OF THE ICXL INTEFACE, THE DEVICE (=CORE) SIDE
						
assign 				  		`TRANSACTORS_PATH.ICXL_host_clk[0] 			= `ICXL_DEVICE_0.ICXL_device_clk_0;
assign 				  		`TRANSACTORS_PATH.ICXL_host_rstn[0] 		= `ICXL_DEVICE_0.ICXL_device_rstn_0;



//inputs to FGT
 //D2H request channel
assign                  	`TRANSACTORS_PATH.ICXL_D2H_REQ_PROTOCOL[0]     				= `ICXL_DEVICE_0.icxl_D2H_REQ_PROTOCOL_0;
assign                  	`TRANSACTORS_PATH.ICXL_D2H_REQ_VALID[0]     				= `ICXL_DEVICE_0.icxl_D2H_REQ_VALID_0;
assign                  	`TRANSACTORS_PATH.ICXL_D2H_REQ_OPCODE[0]   					= `ICXL_DEVICE_0.icxl_D2H_REQ_OPCODE_0;
assign                  	`TRANSACTORS_PATH.ICXL_D2H_REQ_ADDRESS[0]     				= `ICXL_DEVICE_0.icxl_D2H_REQ_ADDRESS_0;
assign                  	`TRANSACTORS_PATH.ICXL_D2H_REQ_CQID[0]     					= `ICXL_DEVICE_0.icxl_D2H_REQ_CQID_0;
assign                  	`TRANSACTORS_PATH.ICXL_D2H_REQ_NT[0]     					= `ICXL_DEVICE_0.icxl_D2H_REQ_NT_0;
assign                  	`TRANSACTORS_PATH.ICXL_D2H_REQ_PARITY[0]     				= `ICXL_DEVICE_0.icxl_D2H_REQ_PARITY_0;
assign                  	`TRANSACTORS_PATH.ICXL_D2H_REQ_SAI[0]     					= `ICXL_DEVICE_0.icxl_D2H_REQ_SAI_0;
assign                  	`TRANSACTORS_PATH.ICXL_D2H_REQ_ADDR_PARITY[0]     			= `ICXL_DEVICE_0.icxl_D2H_REQ_ADDR_PARITY_0;
assign                  	`TRANSACTORS_PATH.ICXL_D2H_REQ_LENGTH[0]     				= `ICXL_DEVICE_0.icxl_D2H_REQ_LENGTH_0;
assign                  	`TRANSACTORS_PATH.ICXL_D2H_REQ_CHID[0]     					= `ICXL_DEVICE_0.icxl_D2H_REQ_CHID_0;
assign                  	`TRANSACTORS_PATH.ICXL_D2H_REQ_PCIE_HEADER[0]     			= `ICXL_DEVICE_0.icxl_D2H_REQ_PCIE_HEADER_0;
//D2H data channel
assign                  	`TRANSACTORS_PATH.ICXL_D2H_DATA_PROTOCOL[0]     			= `ICXL_DEVICE_0.icxl_D2H_DATA_PROTOCOL_0;
assign                  	`TRANSACTORS_PATH.ICXL_D2H_DATA_VALID[0]     				= `ICXL_DEVICE_0.icxl_D2H_DATA_VALID_0;
assign                  	`TRANSACTORS_PATH.ICXL_D2H_DATA_UQID[0]     				= `ICXL_DEVICE_0.icxl_D2H_DATA_UQID_0;
assign                  	`TRANSACTORS_PATH.ICXL_D2H_DATA_CHUNKVALID[0]     			= `ICXL_DEVICE_0.icxl_D2H_DATA_CHUNKVALID_0;
assign                  	`TRANSACTORS_PATH.ICXL_D2H_DATA_BOGUS[0]     				= `ICXL_DEVICE_0.icxl_D2H_DATA_BOGUS_0;
assign                  	`TRANSACTORS_PATH.ICXL_D2H_DATA_POISON[0]     				= `ICXL_DEVICE_0.icxl_D2H_DATA_POISON_0;
assign                  	`TRANSACTORS_PATH.ICXL_D2H_DATA_DATA[0]     				= `ICXL_DEVICE_0.icxl_D2H_DATA_DATA_0;
assign                  	`TRANSACTORS_PATH.ICXL_D2H_DATA_PARITY[0]     				= `ICXL_DEVICE_0.icxl_D2H_DATA_PARITY_0;
assign                  	`TRANSACTORS_PATH.ICXL_D2H_DATA_BE[0]     					= `ICXL_DEVICE_0.icxl_D2H_DATA_BE_0;
assign                  	`TRANSACTORS_PATH.ICXL_D2H_DATA_CHID[0]     				= `ICXL_DEVICE_0.icxl_D2H_DATA_CHID_0;
//D2H response channel
assign                  	`TRANSACTORS_PATH.ICXL_D2H_RSP_PROTOCOL[0]     				= `ICXL_DEVICE_0.icxl_D2H_RSP_PROTOCOL_0;
assign                  	`TRANSACTORS_PATH.ICXL_D2H_RSP_VALID[0]     				= `ICXL_DEVICE_0.icxl_D2H_RSP_VALID_0;
assign                  	`TRANSACTORS_PATH.ICXL_D2H_RSP_OPCODE[0]     				= `ICXL_DEVICE_0.icxl_D2H_RSP_OPCODE_0;
assign                  	`TRANSACTORS_PATH.ICXL_D2H_RSP_UQID[0]     					= `ICXL_DEVICE_0.icxl_D2H_RSP_UQID_0;
//FLOW CONTROL & GLOBAL channel
assign                  	`TRANSACTORS_PATH.ICXL_HOST_CONNECT_ACK[0]     				= `ICXL_DEVICE_0.icxl_HOST_CONNECT_ACK_0;
assign                  	`TRANSACTORS_PATH.ICXL_DEVICE_CONNECT_REQ[0]     			= `ICXL_DEVICE_0.icxl_DEVICE_CONNECT_REQ_0;
//assign                  	`TRANSACTORS_PATH.ICXL_H2D_CREDIT_RETURN_PROTOCOL_ID[0]		=  `ICXL_DEVICE_0.icxl_H2D_CREDIT_RETURN_PROTOCOL_ID_0;
assign                  	`TRANSACTORS_PATH.ICXL_H2D_REQ_CREDIT_RETURN_PROTOCOL_ID[0]		= `ICXL_DEVICE_0.icxl_H2D_REQ_CREDIT_RETURN_PROTOCOL_ID_0;
assign                  	`TRANSACTORS_PATH.ICXL_H2D_DATA_CREDIT_RETURN_PROTOCOL_ID[0]		= `ICXL_DEVICE_0.icxl_H2D_DATA_CREDIT_RETURN_PROTOCOL_ID_0;
assign                  	`TRANSACTORS_PATH.ICXL_H2D_RSP_CREDIT_RETURN_PROTOCOL_ID[0]		= `ICXL_DEVICE_0.icxl_H2D_RSP_CREDIT_RETURN_PROTOCOL_ID_0;
assign                  	`TRANSACTORS_PATH.ICXL_H2D_REQ_CREDIT_RETURN_VALID[0]     	= `ICXL_DEVICE_0.icxl_H2D_REQ_CREDIT_RETURN_VALID_0;
assign                  	`TRANSACTORS_PATH.ICXL_H2D_REQ_PROT_CHID_CREDIT_RETURN[0]   = `ICXL_DEVICE_0.icxl_H2D_REQ_PROT_CHID_CREDIT_RETURN_0;
assign                  	`TRANSACTORS_PATH.ICXL_H2D_REQ_PROT1_RTYPE[0]     			= `ICXL_DEVICE_0.icxl_H2D_REQ_PROT1_RTYPE_0;
assign                  	`TRANSACTORS_PATH.ICXL_H2D_DATA_CREDIT_RETURN_VALID[0]     	= `ICXL_DEVICE_0.icxl_H2D_DATA_CREDIT_RETURN_VALID_0;
assign                  	`TRANSACTORS_PATH.ICXL_H2D_DATA_PROT_CHID_CREDIT_RETURN[0]  = `ICXL_DEVICE_0.icxl_H2D_DATA_PROT_CHID_CREDIT_RETURN_0;
assign                  	`TRANSACTORS_PATH.ICXL_H2D_DATA_PROT1_RTYPE[0]     			= `ICXL_DEVICE_0.icxl_H2D_DATA_PROT1_RTYPE_0;
assign                  	`TRANSACTORS_PATH.ICXL_H2D_RSP_CREDIT_RETURN_VALID[0]     	= `ICXL_DEVICE_0.icxl_H2D_RSP_CREDIT_RETURN_VALID_0;

//=================================================================================================================================
// ICXL_HOST connections - USER MUST EDIT THE LEFT HAND SIDE OF THE FOLLOWING ASSIGNMENTS  - WHEN THIS TRANSACTOR IS USED
//=================================================================================================================================


//outputs from FGT
//H2D request channel
assign  				 	`ICXL_DEVICE_0.icxl_H2D_REQ_PROTOCOL_0						=	`TRANSACTORS_PATH.ICXL_H2D_REQ_PROTOCOL[0]     	;
assign  				 	`ICXL_DEVICE_0.icxl_H2D_REQ_VALID_0							=	`TRANSACTORS_PATH.ICXL_H2D_REQ_VALID[0]     		;
assign  				 	`ICXL_DEVICE_0.icxl_H2D_REQ_OPCODE_0						=	`TRANSACTORS_PATH.ICXL_H2D_REQ_OPCODE[0]     		;
assign  				 	`ICXL_DEVICE_0.icxl_H2D_REQ_ADDRESS_0						=	`TRANSACTORS_PATH.ICXL_H2D_REQ_ADDRESS[0]     		;
assign  				 	`ICXL_DEVICE_0.icxl_H2D_REQ_UQID_0							=	`TRANSACTORS_PATH.ICXL_H2D_REQ_UQID[0]     				;
assign  				 	`ICXL_DEVICE_0.icxl_H2D_REQ_PARITY_0						=	`TRANSACTORS_PATH.ICXL_H2D_REQ_PARITY[0]     				;
assign  				 	`ICXL_DEVICE_0.icxl_H2D_REQ_SAI_0							=	`TRANSACTORS_PATH.ICXL_H2D_REQ_SAI[0]     				;
assign  				 	`ICXL_DEVICE_0.icxl_H2D_REQ_ADDR_PARITY_0					=	`TRANSACTORS_PATH.ICXL_H2D_REQ_ADDR_PARITY[0]     		;
assign  				 	`ICXL_DEVICE_0.icxl_H2D_REQ_LENGTH_0						=	`TRANSACTORS_PATH.ICXL_H2D_REQ_LENGTH[0]     			;
assign						`ICXL_DEVICE_0.icxl_H2D_REQ_CHID_0							=	`TRANSACTORS_PATH.ICXL_H2D_REQ_CHID[0]				;
assign  				 	`ICXL_DEVICE_0.icxl_H2D_REQ_PCIE_HEADER_0					=	`TRANSACTORS_PATH.ICXL_H2D_REQ_PCIE_HEADER[0]     			;
//H2D data channel
assign  				 	`ICXL_DEVICE_0.icxl_H2D_DATA_PROTOCOL_0						=	`TRANSACTORS_PATH.ICXL_H2D_DATA_PROTOCOL[0]     				;
assign  				 	`ICXL_DEVICE_0.icxl_H2D_DATA_VALID_0						=	`TRANSACTORS_PATH.ICXL_H2D_DATA_VALID[0]     			;
assign  				 	`ICXL_DEVICE_0.icxl_H2D_DATA_CQID_0							=	`TRANSACTORS_PATH.ICXL_H2D_DATA_CQID[0]     			;
assign  				 	`ICXL_DEVICE_0.icxl_H2D_DATA_CHUNKVALID_0					=	`TRANSACTORS_PATH.ICXL_H2D_DATA_CHUNKVALID[0]    		 	;//this is equivalent to h2d_data_misc[2]
assign  				 	`ICXL_DEVICE_0.icxl_H2D_DATA_GOERR_0						=	`TRANSACTORS_PATH.ICXL_H2D_DATA_GOERR[0]     				;//this is equivalent to h2d_data_misc[0]
assign  				 	`ICXL_DEVICE_0.icxl_H2D_DATA_POISON_0						=	`TRANSACTORS_PATH.ICXL_H2D_DATA_POISON[0]     		;//this is equivalent to h2d_data_misc[1]
assign  				 	`ICXL_DEVICE_0.icxl_H2D_DATA_DATA_0							=	`TRANSACTORS_PATH.ICXL_H2D_DATA_DATA[0]     			;
assign  				 	`ICXL_DEVICE_0.icxl_H2D_DATA_PARITY_0						=	`TRANSACTORS_PATH.ICXL_H2D_DATA_PARITY[0]     			;
assign  				 	`ICXL_DEVICE_0.icxl_H2D_DATA_HALFLINEONLY_0					=	`TRANSACTORS_PATH.ICXL_H2D_DATA_HALFLINEONLY[0]     				;
//H2D response channel
assign  				 	`ICXL_DEVICE_0.icxl_H2D_RSP_PROTOCOL_0						=	`TRANSACTORS_PATH.ICXL_H2D_RSP_PROTOCOL[0]     				;
assign  				 	`ICXL_DEVICE_0.icxl_H2D_RSP_VALID_0							=	`TRANSACTORS_PATH.ICXL_H2D_RSP_VALID[0]     				;
assign  				 	`ICXL_DEVICE_0.icxl_H2D_RSP_OPCODE_0						=	`TRANSACTORS_PATH.ICXL_H2D_RSP_OPCODE[0]     			;
assign  				 	`ICXL_DEVICE_0.icxl_H2D_RSP_CQID_0							=	`TRANSACTORS_PATH.ICXL_H2D_RSP_CQID[0]     				;
assign  				 	`ICXL_DEVICE_0.icxl_H2D_RSP_RSPDATA_0						=	`TRANSACTORS_PATH.ICXL_H2D_RSP_RSPDATA[0]   		 	 	;
assign  				 	`ICXL_DEVICE_0.icxl_H2D_RSP_RSP_PRE_0						=	`TRANSACTORS_PATH.ICXL_H2D_RSP_RSP_PRE[0]     				;
 //FLOW CONTROL & GLOBAL channel
assign  				 	`ICXL_DEVICE_0.icxl_HOST_CONNECT_REQ_0						=	`TRANSACTORS_PATH.ICXL_HOST_CONNECT_REQ[0]     	;
assign  				 	`ICXL_DEVICE_0.icxl_DEVICE_CONNECT_ACK_0					=	`TRANSACTORS_PATH.ICXL_DEVICE_CONNECT_ACK[0]     	;
//assign  				 	`ICXL_DEVICE_0.icxl_D2H_CREDIT_RETURN_PROTOCOL_ID_0			=	`TRANSACTORS_PATH.ICXL_D2H_CREDIT_RETURN_PROTOCOL_ID[0]     	;
assign  				 	`ICXL_DEVICE_0.icxl_D2H_REQ_CREDIT_RETURN_PROTOCOL_ID_0			=	`TRANSACTORS_PATH.ICXL_D2H_REQ_CREDIT_RETURN_PROTOCOL_ID[0]     	;
assign  				 	`ICXL_DEVICE_0.icxl_D2H_DATA_CREDIT_RETURN_PROTOCOL_ID_0			=	`TRANSACTORS_PATH.ICXL_D2H_DATA_CREDIT_RETURN_PROTOCOL_ID[0]     	;
assign  				 	`ICXL_DEVICE_0.icxl_D2H_RSP_CREDIT_RETURN_PROTOCOL_ID_0			=	`TRANSACTORS_PATH.ICXL_D2H_RSP_CREDIT_RETURN_PROTOCOL_ID[0]     	;
assign  				 	`ICXL_DEVICE_0.icxl_D2H_REQ_CREDIT_RETURN_VALID_0			=	`TRANSACTORS_PATH.ICXL_D2H_REQ_CREDIT_RETURN_VALID[0]     	;
assign  				 	`ICXL_DEVICE_0.icxl_D2H_REQ_PROT_CHID_CREDIT_RETURN_0		=	`TRANSACTORS_PATH.ICXL_D2H_REQ_PROT_CHID_CREDIT_RETURN[0]     	;
assign  				 	`ICXL_DEVICE_0.icxl_D2H_REQ_PROT1_RTYPE_0					=	`TRANSACTORS_PATH.ICXL_D2H_REQ_PROT1_RTYPE[0]     	;
assign  				 	`ICXL_DEVICE_0.icxl_D2H_DATA_CREDIT_RETURN_VALID_0			=	`TRANSACTORS_PATH.ICXL_D2H_DATA_CREDIT_RETURN_VALID[0]     	;
assign  				 	`ICXL_DEVICE_0.icxl_D2H_DATA_PROT_CHID_CREDIT_RETURN_0		=	`TRANSACTORS_PATH.ICXL_D2H_DATA_PROT_CHID_CREDIT_RETURN[0]     	;
assign  				 	`ICXL_DEVICE_0.icxl_D2H_DATA_PROT1_RTYPE_0					=	`TRANSACTORS_PATH.ICXL_D2H_DATA_PROT1_RTYPE[0]     	;
assign  				 	`ICXL_DEVICE_0.icxl_D2H_RSP_CREDIT_RETURN_VALID_0			=	`TRANSACTORS_PATH.ICXL_D2H_RSP_CREDIT_RETURN_VALID[0]     	;

//=================================================================================================================================


	
