//=================================================================================================================================
// ICXL_HOST connections - USER MUST EDIT THE RIGHT HAND SIDE OF THE FOLLOWING ASSIGNMENTS AND DEFINE - WHEN NEEDED
//=================================================================================================================================
// ICXL_HOST   connection #0


							`define 	ICXL_DEVICE_3 					fpga_transactors_top_inst   // example:  fpga_tcss_top.tcss_val_rtl.tcss.par_iom    //HERE USER SHOULD SET THE PATH TO HIS SIDE OF THE ICXL INTEFACE, THE DEVICE (=CORE) SIDE
						
assign 				  		`TRANSACTORS_PATH.ICXL_host_clk[3] 			= `ICXL_DEVICE_3.ICXL_device_clk_3;
assign 				  		`TRANSACTORS_PATH.ICXL_host_rstn[3] 		= `ICXL_DEVICE_3.ICXL_device_rstn_3;



//inputs to FGT
 //D2H request channel
assign                  	`TRANSACTORS_PATH.ICXL_D2H_REQ_PROTOCOL[3]     				= `ICXL_DEVICE_3.icxl_D2H_REQ_PROTOCOL_3;
assign                  	`TRANSACTORS_PATH.ICXL_D2H_REQ_VALID[3]     				= `ICXL_DEVICE_3.icxl_D2H_REQ_VALID_3;
assign                  	`TRANSACTORS_PATH.ICXL_D2H_REQ_OPCODE[3]   					= `ICXL_DEVICE_3.icxl_D2H_REQ_OPCODE_3;
assign                  	`TRANSACTORS_PATH.ICXL_D2H_REQ_ADDRESS[3]     				= `ICXL_DEVICE_3.icxl_D2H_REQ_ADDRESS_3;
assign                  	`TRANSACTORS_PATH.ICXL_D2H_REQ_CQID[3]     					= `ICXL_DEVICE_3.icxl_D2H_REQ_CQID_3;
assign                  	`TRANSACTORS_PATH.ICXL_D2H_REQ_NT[3]     					= `ICXL_DEVICE_3.icxl_D2H_REQ_NT_3;
assign                  	`TRANSACTORS_PATH.ICXL_D2H_REQ_PARITY[3]     				= `ICXL_DEVICE_3.icxl_D2H_REQ_PARITY_3;
assign                  	`TRANSACTORS_PATH.ICXL_D2H_REQ_SAI[3]     					= `ICXL_DEVICE_3.icxl_D2H_REQ_SAI_3;
assign                  	`TRANSACTORS_PATH.ICXL_D2H_REQ_ADDR_PARITY[3]     			= `ICXL_DEVICE_3.icxl_D2H_REQ_ADDR_PARITY_3;
assign                  	`TRANSACTORS_PATH.ICXL_D2H_REQ_LENGTH[3]     				= `ICXL_DEVICE_3.icxl_D2H_REQ_LENGTH_3;
assign                  	`TRANSACTORS_PATH.ICXL_D2H_REQ_CHID[3]     					= `ICXL_DEVICE_3.icxl_D2H_REQ_CHID_3;
assign                  	`TRANSACTORS_PATH.ICXL_D2H_REQ_PCIE_HEADER[3]     			= `ICXL_DEVICE_3.icxl_D2H_REQ_PCIE_HEADER_3;
//D2H data channel
assign                  	`TRANSACTORS_PATH.ICXL_D2H_DATA_PROTOCOL[3]     			= `ICXL_DEVICE_3.icxl_D2H_DATA_PROTOCOL_3;
assign                  	`TRANSACTORS_PATH.ICXL_D2H_DATA_VALID[3]     				= `ICXL_DEVICE_3.icxl_D2H_DATA_VALID_3;
assign                  	`TRANSACTORS_PATH.ICXL_D2H_DATA_UQID[3]     				= `ICXL_DEVICE_3.icxl_D2H_DATA_UQID_3;
assign                  	`TRANSACTORS_PATH.ICXL_D2H_DATA_CHUNKVALID[3]     			= `ICXL_DEVICE_3.icxl_D2H_DATA_CHUNKVALID_3;
assign                  	`TRANSACTORS_PATH.ICXL_D2H_DATA_BOGUS[3]     				= `ICXL_DEVICE_3.icxl_D2H_DATA_BOGUS_3;
assign                  	`TRANSACTORS_PATH.ICXL_D2H_DATA_POISON[3]     				= `ICXL_DEVICE_3.icxl_D2H_DATA_POISON_3;
assign                  	`TRANSACTORS_PATH.ICXL_D2H_DATA_DATA[3]     				= `ICXL_DEVICE_3.icxl_D2H_DATA_DATA_3;
assign                  	`TRANSACTORS_PATH.ICXL_D2H_DATA_PARITY[3]     				= `ICXL_DEVICE_3.icxl_D2H_DATA_PARITY_3;
assign                  	`TRANSACTORS_PATH.ICXL_D2H_DATA_BE[3]     					= `ICXL_DEVICE_3.icxl_D2H_DATA_BE_3;
assign                  	`TRANSACTORS_PATH.ICXL_D2H_DATA_CHID[3]     				= `ICXL_DEVICE_3.icxl_D2H_DATA_CHID_3;
//D2H response channel
assign                  	`TRANSACTORS_PATH.ICXL_D2H_RSP_PROTOCOL[3]     				= `ICXL_DEVICE_3.icxl_D2H_RSP_PROTOCOL_3;
assign                  	`TRANSACTORS_PATH.ICXL_D2H_RSP_VALID[3]     				= `ICXL_DEVICE_3.icxl_D2H_RSP_VALID_3;
assign                  	`TRANSACTORS_PATH.ICXL_D2H_RSP_OPCODE[3]     				= `ICXL_DEVICE_3.icxl_D2H_RSP_OPCODE_3;
assign                  	`TRANSACTORS_PATH.ICXL_D2H_RSP_UQID[3]     					= `ICXL_DEVICE_3.icxl_D2H_RSP_UQID_3;
//FLOW CONTROL & GLOBAL channel
assign                  	`TRANSACTORS_PATH.ICXL_HOST_CONNECT_ACK[3]     				= `ICXL_DEVICE_3.icxl_HOST_CONNECT_ACK_3;
assign                  	`TRANSACTORS_PATH.ICXL_DEVICE_CONNECT_REQ[3]     			= `ICXL_DEVICE_3.icxl_DEVICE_CONNECT_REQ_3;
//assign                  	`TRANSACTORS_PATH.ICXL_H2D_CREDIT_RETURN_PROTOCOL_ID[3]		=  `ICXL_DEVICE_3.icxl_H2D_CREDIT_RETURN_PROTOCOL_ID_3;
assign                  	`TRANSACTORS_PATH.ICXL_H2D_REQ_CREDIT_RETURN_PROTOCOL_ID[3]		= `ICXL_DEVICE_3.icxl_H2D_REQ_CREDIT_RETURN_PROTOCOL_ID_3;
assign                  	`TRANSACTORS_PATH.ICXL_H2D_DATA_CREDIT_RETURN_PROTOCOL_ID[3]		= `ICXL_DEVICE_3.icxl_H2D_DATA_CREDIT_RETURN_PROTOCOL_ID_3;
assign                  	`TRANSACTORS_PATH.ICXL_H2D_RSP_CREDIT_RETURN_PROTOCOL_ID[3]		= `ICXL_DEVICE_3.icxl_H2D_RSP_CREDIT_RETURN_PROTOCOL_ID_3;
assign                  	`TRANSACTORS_PATH.ICXL_H2D_REQ_CREDIT_RETURN_VALID[3]     	= `ICXL_DEVICE_3.icxl_H2D_REQ_CREDIT_RETURN_VALID_3;
assign                  	`TRANSACTORS_PATH.ICXL_H2D_REQ_PROT_CHID_CREDIT_RETURN[3]   = `ICXL_DEVICE_3.icxl_H2D_REQ_PROT_CHID_CREDIT_RETURN_3;
assign                  	`TRANSACTORS_PATH.ICXL_H2D_REQ_PROT1_RTYPE[3]     			= `ICXL_DEVICE_3.icxl_H2D_REQ_PROT1_RTYPE_3;
assign                  	`TRANSACTORS_PATH.ICXL_H2D_DATA_CREDIT_RETURN_VALID[3]     	= `ICXL_DEVICE_3.icxl_H2D_DATA_CREDIT_RETURN_VALID_3;
assign                  	`TRANSACTORS_PATH.ICXL_H2D_DATA_PROT_CHID_CREDIT_RETURN[3]  = `ICXL_DEVICE_3.icxl_H2D_DATA_PROT_CHID_CREDIT_RETURN_3;
assign                  	`TRANSACTORS_PATH.ICXL_H2D_DATA_PROT1_RTYPE[3]     			= `ICXL_DEVICE_3.icxl_H2D_DATA_PROT1_RTYPE_3;
assign                  	`TRANSACTORS_PATH.ICXL_H2D_RSP_CREDIT_RETURN_VALID[3]     	= `ICXL_DEVICE_3.icxl_H2D_RSP_CREDIT_RETURN_VALID_3;

//=================================================================================================================================
// CXL_CACHE_HOST connections - USER MUST EDIT THE LEFT HAND SIDE OF THE FOLLOWING ASSIGNMENTS 
//=================================================================================================================================


//outputs from FGT
//H2D request channel
assign  				 	`ICXL_DEVICE_3.icxl_H2D_REQ_PROTOCOL_3						=	`TRANSACTORS_PATH.ICXL_H2D_REQ_PROTOCOL[3]     	;
assign  				 	`ICXL_DEVICE_3.icxl_H2D_REQ_VALID_3							=	`TRANSACTORS_PATH.ICXL_H2D_REQ_VALID[3]     		;
assign  				 	`ICXL_DEVICE_3.icxl_H2D_REQ_OPCODE_3							=	`TRANSACTORS_PATH.ICXL_H2D_REQ_OPCODE[3]     		;
assign  				 	`ICXL_DEVICE_3.icxl_H2D_REQ_ADDRESS_3							=	`TRANSACTORS_PATH.ICXL_H2D_REQ_ADDRESS[3]     		;
assign  				 	`ICXL_DEVICE_3.icxl_H2D_REQ_UQID_3							=	`TRANSACTORS_PATH.ICXL_H2D_REQ_UQID[3]     				;
assign  				 	`ICXL_DEVICE_3.icxl_H2D_REQ_PARITY_3							=	`TRANSACTORS_PATH.ICXL_H2D_REQ_PARITY[3]     				;
assign  				 	`ICXL_DEVICE_3.icxl_H2D_REQ_SAI_3								=	`TRANSACTORS_PATH.ICXL_H2D_REQ_SAI[3]     				;
assign  				 	`ICXL_DEVICE_3.icxl_H2D_REQ_ADDR_PARITY_3						=	`TRANSACTORS_PATH.ICXL_H2D_REQ_ADDR_PARITY[3]     		;
assign  				 	`ICXL_DEVICE_3.icxl_H2D_REQ_LENGTH_3							=	`TRANSACTORS_PATH.ICXL_H2D_REQ_LENGTH[3]     			;
assign						`ICXL_DEVICE_3.icxl_H2D_REQ_CHID_3							=	`TRANSACTORS_PATH.ICXL_H2D_REQ_CHID[3]				;
assign  				 	`ICXL_DEVICE_3.icxl_H2D_REQ_PCIE_HEADER_3						=	`TRANSACTORS_PATH.ICXL_H2D_REQ_PCIE_HEADER[3]     			;
//H2D data channel
assign  				 	`ICXL_DEVICE_3.icxl_H2D_DATA_PROTOCOL_3						=	`TRANSACTORS_PATH.ICXL_H2D_DATA_PROTOCOL[3]     				;
assign  				 	`ICXL_DEVICE_3.icxl_H2D_DATA_VALID_3							=	`TRANSACTORS_PATH.ICXL_H2D_DATA_VALID[3]     			;
assign  				 	`ICXL_DEVICE_3.icxl_H2D_DATA_CQID_3							=	`TRANSACTORS_PATH.ICXL_H2D_DATA_CQID[3]     			;
assign  				 	`ICXL_DEVICE_3.icxl_H2D_DATA_CHUNKVALID_3						=	`TRANSACTORS_PATH.ICXL_H2D_DATA_CHUNKVALID[3]    		 	;//this is equivalent to h2d_data_misc[2]
assign  				 	`ICXL_DEVICE_3.icxl_H2D_DATA_GOERR_3							=	`TRANSACTORS_PATH.ICXL_H2D_DATA_GOERR[3]     				;//this is equivalent to h2d_data_misc[0]
assign  				 	`ICXL_DEVICE_3.icxl_H2D_DATA_POISON_3							=	`TRANSACTORS_PATH.ICXL_H2D_DATA_POISON[3]     		;//this is equivalent to h2d_data_misc[1]
assign  				 	`ICXL_DEVICE_3.icxl_H2D_DATA_DATA_3							=	`TRANSACTORS_PATH.ICXL_H2D_DATA_DATA[3]     			;
assign  				 	`ICXL_DEVICE_3.icxl_H2D_DATA_PARITY_3							=	`TRANSACTORS_PATH.ICXL_H2D_DATA_PARITY[3]     			;
assign  				 	`ICXL_DEVICE_3.icxl_H2D_DATA_HALFLINEONLY_3					=	`TRANSACTORS_PATH.ICXL_H2D_DATA_HALFLINEONLY[3]     				;
//H2D response channel
assign  				 	`ICXL_DEVICE_3.icxl_H2D_RSP_PROTOCOL_3						=	`TRANSACTORS_PATH.ICXL_H2D_RSP_PROTOCOL[3]     				;
assign  				 	`ICXL_DEVICE_3.icxl_H2D_RSP_VALID_3							=	`TRANSACTORS_PATH.ICXL_H2D_RSP_VALID[3]     				;
assign  				 	`ICXL_DEVICE_3.icxl_H2D_RSP_OPCODE_3							=	`TRANSACTORS_PATH.ICXL_H2D_RSP_OPCODE[3]     			;
assign  				 	`ICXL_DEVICE_3.icxl_H2D_RSP_CQID_3							=	`TRANSACTORS_PATH.ICXL_H2D_RSP_CQID[3]     				;
assign  				 	`ICXL_DEVICE_3.icxl_H2D_RSP_RSPDATA_3							=	`TRANSACTORS_PATH.ICXL_H2D_RSP_RSPDATA[3]   		 	 	;
assign  				 	`ICXL_DEVICE_3.icxl_H2D_RSP_RSP_PRE_3							=	`TRANSACTORS_PATH.ICXL_H2D_RSP_RSP_PRE[3]     				;
 //FLOW CONTROL & GLOBAL channel
assign  				 	`ICXL_DEVICE_3.icxl_HOST_CONNECT_REQ_3						=	`TRANSACTORS_PATH.ICXL_HOST_CONNECT_REQ[3]     	;
assign  				 	`ICXL_DEVICE_3.icxl_DEVICE_CONNECT_ACK_3						=	`TRANSACTORS_PATH.ICXL_DEVICE_CONNECT_ACK[3]     	;
//assign  				 	`ICXL_DEVICE_3.icxl_D2H_CREDIT_RETURN_PROTOCOL_ID_3			=	`TRANSACTORS_PATH.ICXL_D2H_CREDIT_RETURN_PROTOCOL_ID[3]     	;
assign  				 	`ICXL_DEVICE_3.icxl_D2H_REQ_CREDIT_RETURN_PROTOCOL_ID_3			=	`TRANSACTORS_PATH.ICXL_D2H_REQ_CREDIT_RETURN_PROTOCOL_ID[3]     	;
assign  				 	`ICXL_DEVICE_3.icxl_D2H_DATA_CREDIT_RETURN_PROTOCOL_ID_3			=	`TRANSACTORS_PATH.ICXL_D2H_DATA_CREDIT_RETURN_PROTOCOL_ID[3]     	;
assign  				 	`ICXL_DEVICE_3.icxl_D2H_RSP_CREDIT_RETURN_PROTOCOL_ID_3			=	`TRANSACTORS_PATH.ICXL_D2H_RSP_CREDIT_RETURN_PROTOCOL_ID[3]     	;
assign  				 	`ICXL_DEVICE_3.icxl_D2H_REQ_CREDIT_RETURN_VALID_3				=	`TRANSACTORS_PATH.ICXL_D2H_REQ_CREDIT_RETURN_VALID[3]     	;
assign  				 	`ICXL_DEVICE_3.icxl_D2H_REQ_PROT_CHID_CREDIT_RETURN_3			=	`TRANSACTORS_PATH.ICXL_D2H_REQ_PROT_CHID_CREDIT_RETURN[3]     	;
assign  				 	`ICXL_DEVICE_3.icxl_D2H_REQ_PROT1_RTYPE_3						=	`TRANSACTORS_PATH.ICXL_D2H_REQ_PROT1_RTYPE[3]     	;
assign  				 	`ICXL_DEVICE_3.icxl_D2H_DATA_CREDIT_RETURN_VALID_3			=	`TRANSACTORS_PATH.ICXL_D2H_DATA_CREDIT_RETURN_VALID[3]     	;
assign  				 	`ICXL_DEVICE_3.icxl_D2H_DATA_PROT_CHID_CREDIT_RETURN_3		=	`TRANSACTORS_PATH.ICXL_D2H_DATA_PROT_CHID_CREDIT_RETURN[3]     	;
assign  				 	`ICXL_DEVICE_3.icxl_D2H_DATA_PROT1_RTYPE_3					=	`TRANSACTORS_PATH.ICXL_D2H_DATA_PROT1_RTYPE[3]     	;
assign  				 	`ICXL_DEVICE_3.icxl_D2H_RSP_CREDIT_RETURN_VALID_3				=	`TRANSACTORS_PATH.ICXL_D2H_RSP_CREDIT_RETURN_VALID[3]     	;

//=================================================================================================================================


	
