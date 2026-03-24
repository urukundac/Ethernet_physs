//=================================================================================================================================
// ICXL_HOST connections - USER MUST EDIT THE RIGHT HAND SIDE OF THE FOLLOWING ASSIGNMENTS AND DEFINE - WHEN NEEDED
//=================================================================================================================================
// ICXL_HOST   connection #0


							`define 	ICXL_DEVICE_5 					`FPGA_TRANSACTORS_TOP   // example:  fpga_tcss_top.tcss_val_rtl.tcss.par_iom    //HERE USER SHOULD SET THE PATH TO HIS SIDE OF THE ICXL INTEFACE, THE DEVICE (=CORE) SIDE
						
assign 				  		`TRANSACTORS_PATH.ICXL_host_clk[5] 			= `ICXL_DEVICE_5.ICXL_device_clk_5;
assign 				  		`TRANSACTORS_PATH.ICXL_host_rstn[5] 		= `ICXL_DEVICE_5.ICXL_device_rstn_5;



//inputs to FGT
 //D2H request channel
assign                  	`TRANSACTORS_PATH.ICXL_D2H_REQ_PROTOCOL[5]     				= `ICXL_DEVICE_5.icxl_D2H_REQ_PROTOCOL_5;
assign                  	`TRANSACTORS_PATH.ICXL_D2H_REQ_VALID[5]     				= `ICXL_DEVICE_5.icxl_D2H_REQ_VALID_5;
assign                  	`TRANSACTORS_PATH.ICXL_D2H_REQ_OPCODE[5]   					= `ICXL_DEVICE_5.icxl_D2H_REQ_OPCODE_5;
assign                  	`TRANSACTORS_PATH.ICXL_D2H_REQ_ADDRESS[5]     				= `ICXL_DEVICE_5.icxl_D2H_REQ_ADDRESS_5;
assign                  	`TRANSACTORS_PATH.ICXL_D2H_REQ_CQID[5]     					= `ICXL_DEVICE_5.icxl_D2H_REQ_CQID_5;
assign                  	`TRANSACTORS_PATH.ICXL_D2H_REQ_NT[5]     					= `ICXL_DEVICE_5.icxl_D2H_REQ_NT_5;
assign                  	`TRANSACTORS_PATH.ICXL_D2H_REQ_PARITY[5]     				= `ICXL_DEVICE_5.icxl_D2H_REQ_PARITY_5;
assign                  	`TRANSACTORS_PATH.ICXL_D2H_REQ_SAI[5]     					= `ICXL_DEVICE_5.icxl_D2H_REQ_SAI_5;
assign                  	`TRANSACTORS_PATH.ICXL_D2H_REQ_ADDR_PARITY[5]     			= `ICXL_DEVICE_5.icxl_D2H_REQ_ADDR_PARITY_5;
assign                  	`TRANSACTORS_PATH.ICXL_D2H_REQ_LENGTH[5]     				= `ICXL_DEVICE_5.icxl_D2H_REQ_LENGTH_5;
assign                  	`TRANSACTORS_PATH.ICXL_D2H_REQ_CHID[5]     					= `ICXL_DEVICE_5.icxl_D2H_REQ_CHID_5;
assign                  	`TRANSACTORS_PATH.ICXL_D2H_REQ_PCIE_HEADER[5]     			= `ICXL_DEVICE_5.icxl_D2H_REQ_PCIE_HEADER_5;
//D2H data channel
assign                  	`TRANSACTORS_PATH.ICXL_D2H_DATA_PROTOCOL[5]     			= `ICXL_DEVICE_5.icxl_D2H_DATA_PROTOCOL_5;
assign                  	`TRANSACTORS_PATH.ICXL_D2H_DATA_VALID[5]     				= `ICXL_DEVICE_5.icxl_D2H_DATA_VALID_5;
assign                  	`TRANSACTORS_PATH.ICXL_D2H_DATA_UQID[5]     				= `ICXL_DEVICE_5.icxl_D2H_DATA_UQID_5;
assign                  	`TRANSACTORS_PATH.ICXL_D2H_DATA_CHUNKVALID[5]     			= `ICXL_DEVICE_5.icxl_D2H_DATA_CHUNKVALID_5;
assign                  	`TRANSACTORS_PATH.ICXL_D2H_DATA_BOGUS[5]     				= `ICXL_DEVICE_5.icxl_D2H_DATA_BOGUS_5;
assign                  	`TRANSACTORS_PATH.ICXL_D2H_DATA_POISON[5]     				= `ICXL_DEVICE_5.icxl_D2H_DATA_POISON_5;
assign                  	`TRANSACTORS_PATH.ICXL_D2H_DATA_DATA[5]     				= `ICXL_DEVICE_5.icxl_D2H_DATA_DATA_5;
assign                  	`TRANSACTORS_PATH.ICXL_D2H_DATA_PARITY[5]     				= `ICXL_DEVICE_5.icxl_D2H_DATA_PARITY_5;
assign                  	`TRANSACTORS_PATH.ICXL_D2H_DATA_BE[5]     					= `ICXL_DEVICE_5.icxl_D2H_DATA_BE_5;
assign                  	`TRANSACTORS_PATH.ICXL_D2H_DATA_CHID[5]     				= `ICXL_DEVICE_5.icxl_D2H_DATA_CHID_5;
//D2H response channel
assign                  	`TRANSACTORS_PATH.ICXL_D2H_RSP_PROTOCOL[5]     				= `ICXL_DEVICE_5.icxl_D2H_RSP_PROTOCOL_5;
assign                  	`TRANSACTORS_PATH.ICXL_D2H_RSP_VALID[5]     				= `ICXL_DEVICE_5.icxl_D2H_RSP_VALID_5;
assign                  	`TRANSACTORS_PATH.ICXL_D2H_RSP_OPCODE[5]     				= `ICXL_DEVICE_5.icxl_D2H_RSP_OPCODE_5;
assign                  	`TRANSACTORS_PATH.ICXL_D2H_RSP_UQID[5]     					= `ICXL_DEVICE_5.icxl_D2H_RSP_UQID_5;
//FLOW CONTROL & GLOBAL channel
assign                  	`TRANSACTORS_PATH.ICXL_HOST_CONNECT_ACK[5]     				= `ICXL_DEVICE_5.icxl_HOST_CONNECT_ACK_5;
assign                  	`TRANSACTORS_PATH.ICXL_DEVICE_CONNECT_REQ[5]     			= `ICXL_DEVICE_5.icxl_DEVICE_CONNECT_REQ_5;
//assign                  	`TRANSACTORS_PATH.ICXL_H2D_CREDIT_RETURN_PROTOCOL_ID[5]		=  `ICXL_DEVICE_5.icxl_H2D_CREDIT_RETURN_PROTOCOL_ID_5;
assign                  	`TRANSACTORS_PATH.ICXL_H2D_REQ_CREDIT_RETURN_PROTOCOL_ID[5]		= `ICXL_DEVICE_5.icxl_H2D_REQ_CREDIT_RETURN_PROTOCOL_ID_5;
assign                  	`TRANSACTORS_PATH.ICXL_H2D_DATA_CREDIT_RETURN_PROTOCOL_ID[5]		= `ICXL_DEVICE_5.icxl_H2D_DATA_CREDIT_RETURN_PROTOCOL_ID_5;
assign                  	`TRANSACTORS_PATH.ICXL_H2D_RSP_CREDIT_RETURN_PROTOCOL_ID[5]		= `ICXL_DEVICE_5.icxl_H2D_RSP_CREDIT_RETURN_PROTOCOL_ID_5;
assign                  	`TRANSACTORS_PATH.ICXL_H2D_REQ_CREDIT_RETURN_VALID[5]     	= `ICXL_DEVICE_5.icxl_H2D_REQ_CREDIT_RETURN_VALID_5;
assign                  	`TRANSACTORS_PATH.ICXL_H2D_REQ_PROT_CHID_CREDIT_RETURN[5]   = `ICXL_DEVICE_5.icxl_H2D_REQ_PROT_CHID_CREDIT_RETURN_5;
assign                  	`TRANSACTORS_PATH.ICXL_H2D_REQ_PROT1_RTYPE[5]     			= `ICXL_DEVICE_5.icxl_H2D_REQ_PROT1_RTYPE_5;
assign                  	`TRANSACTORS_PATH.ICXL_H2D_DATA_CREDIT_RETURN_VALID[5]     	= `ICXL_DEVICE_5.icxl_H2D_DATA_CREDIT_RETURN_VALID_5;
assign                  	`TRANSACTORS_PATH.ICXL_H2D_DATA_PROT_CHID_CREDIT_RETURN[5]  = `ICXL_DEVICE_5.icxl_H2D_DATA_PROT_CHID_CREDIT_RETURN_5;
assign                  	`TRANSACTORS_PATH.ICXL_H2D_DATA_PROT1_RTYPE[5]     			= `ICXL_DEVICE_5.icxl_H2D_DATA_PROT1_RTYPE_5;
assign                  	`TRANSACTORS_PATH.ICXL_H2D_RSP_CREDIT_RETURN_VALID[5]     	= `ICXL_DEVICE_5.icxl_H2D_RSP_CREDIT_RETURN_VALID_5;

//=================================================================================================================================
// CXL_CACHE_HOST connections - USER MUST EDIT THE LEFT HAND SIDE OF THE FOLLOWING ASSIGNMENTS 
//=================================================================================================================================


//outputs from FGT
//H2D request channel
assign  				 	`ICXL_DEVICE_5.icxl_H2D_REQ_PROTOCOL_5						=	`TRANSACTORS_PATH.ICXL_H2D_REQ_PROTOCOL[5]     	;
assign  				 	`ICXL_DEVICE_5.icxl_H2D_REQ_VALID_5							=	`TRANSACTORS_PATH.ICXL_H2D_REQ_VALID[5]     		;
assign  				 	`ICXL_DEVICE_5.icxl_H2D_REQ_OPCODE_5							=	`TRANSACTORS_PATH.ICXL_H2D_REQ_OPCODE[5]     		;
assign  				 	`ICXL_DEVICE_5.icxl_H2D_REQ_ADDRESS_5							=	`TRANSACTORS_PATH.ICXL_H2D_REQ_ADDRESS[5]     		;
assign  				 	`ICXL_DEVICE_5.icxl_H2D_REQ_UQID_5							=	`TRANSACTORS_PATH.ICXL_H2D_REQ_UQID[5]     				;
assign  				 	`ICXL_DEVICE_5.icxl_H2D_REQ_PARITY_5							=	`TRANSACTORS_PATH.ICXL_H2D_REQ_PARITY[5]     				;
assign  				 	`ICXL_DEVICE_5.icxl_H2D_REQ_SAI_5								=	`TRANSACTORS_PATH.ICXL_H2D_REQ_SAI[5]     				;
assign  				 	`ICXL_DEVICE_5.icxl_H2D_REQ_ADDR_PARITY_5						=	`TRANSACTORS_PATH.ICXL_H2D_REQ_ADDR_PARITY[5]     		;
assign  				 	`ICXL_DEVICE_5.icxl_H2D_REQ_LENGTH_5							=	`TRANSACTORS_PATH.ICXL_H2D_REQ_LENGTH[5]     			;
assign						`ICXL_DEVICE_5.icxl_H2D_REQ_CHID_5							=	`TRANSACTORS_PATH.ICXL_H2D_REQ_CHID[5]				;
assign  				 	`ICXL_DEVICE_5.icxl_H2D_REQ_PCIE_HEADER_5						=	`TRANSACTORS_PATH.ICXL_H2D_REQ_PCIE_HEADER[5]     			;
//H2D data channel
assign  				 	`ICXL_DEVICE_5.icxl_H2D_DATA_PROTOCOL_5						=	`TRANSACTORS_PATH.ICXL_H2D_DATA_PROTOCOL[5]     				;
assign  				 	`ICXL_DEVICE_5.icxl_H2D_DATA_VALID_5							=	`TRANSACTORS_PATH.ICXL_H2D_DATA_VALID[5]     			;
assign  				 	`ICXL_DEVICE_5.icxl_H2D_DATA_CQID_5							=	`TRANSACTORS_PATH.ICXL_H2D_DATA_CQID[5]     			;
assign  				 	`ICXL_DEVICE_5.icxl_H2D_DATA_CHUNKVALID_5						=	`TRANSACTORS_PATH.ICXL_H2D_DATA_CHUNKVALID[5]    		 	;//this is equivalent to h2d_data_misc[2]
assign  				 	`ICXL_DEVICE_5.icxl_H2D_DATA_GOERR_5							=	`TRANSACTORS_PATH.ICXL_H2D_DATA_GOERR[5]     				;//this is equivalent to h2d_data_misc[0]
assign  				 	`ICXL_DEVICE_5.icxl_H2D_DATA_POISON_5							=	`TRANSACTORS_PATH.ICXL_H2D_DATA_POISON[5]     		;//this is equivalent to h2d_data_misc[1]
assign  				 	`ICXL_DEVICE_5.icxl_H2D_DATA_DATA_5							=	`TRANSACTORS_PATH.ICXL_H2D_DATA_DATA[5]     			;
assign  				 	`ICXL_DEVICE_5.icxl_H2D_DATA_PARITY_5							=	`TRANSACTORS_PATH.ICXL_H2D_DATA_PARITY[5]     			;
assign  				 	`ICXL_DEVICE_5.icxl_H2D_DATA_HALFLINEONLY_5					=	`TRANSACTORS_PATH.ICXL_H2D_DATA_HALFLINEONLY[5]     				;
//H2D response channel
assign  				 	`ICXL_DEVICE_5.icxl_H2D_RSP_PROTOCOL_5						=	`TRANSACTORS_PATH.ICXL_H2D_RSP_PROTOCOL[5]     				;
assign  				 	`ICXL_DEVICE_5.icxl_H2D_RSP_VALID_5							=	`TRANSACTORS_PATH.ICXL_H2D_RSP_VALID[5]     				;
assign  				 	`ICXL_DEVICE_5.icxl_H2D_RSP_OPCODE_5							=	`TRANSACTORS_PATH.ICXL_H2D_RSP_OPCODE[5]     			;
assign  				 	`ICXL_DEVICE_5.icxl_H2D_RSP_CQID_5							=	`TRANSACTORS_PATH.ICXL_H2D_RSP_CQID[5]     				;
assign  				 	`ICXL_DEVICE_5.icxl_H2D_RSP_RSPDATA_5							=	`TRANSACTORS_PATH.ICXL_H2D_RSP_RSPDATA[5]   		 	 	;
assign  				 	`ICXL_DEVICE_5.icxl_H2D_RSP_RSP_PRE_5							=	`TRANSACTORS_PATH.ICXL_H2D_RSP_RSP_PRE[5]     				;
 //FLOW CONTROL & GLOBAL channel
assign  				 	`ICXL_DEVICE_5.icxl_HOST_CONNECT_REQ_5						=	`TRANSACTORS_PATH.ICXL_HOST_CONNECT_REQ[5]     	;
assign  				 	`ICXL_DEVICE_5.icxl_DEVICE_CONNECT_ACK_5						=	`TRANSACTORS_PATH.ICXL_DEVICE_CONNECT_ACK[5]     	;
//assign  				 	`ICXL_DEVICE_5.icxl_D2H_CREDIT_RETURN_PROTOCOL_ID_5			=	`TRANSACTORS_PATH.ICXL_D2H_CREDIT_RETURN_PROTOCOL_ID[5]     	;
assign  				 	`ICXL_DEVICE_5.icxl_D2H_REQ_CREDIT_RETURN_PROTOCOL_ID_5			=	`TRANSACTORS_PATH.ICXL_D2H_REQ_CREDIT_RETURN_PROTOCOL_ID[5]     	;
assign  				 	`ICXL_DEVICE_5.icxl_D2H_DATA_CREDIT_RETURN_PROTOCOL_ID_5			=	`TRANSACTORS_PATH.ICXL_D2H_DATA_CREDIT_RETURN_PROTOCOL_ID[5]     	;
assign  				 	`ICXL_DEVICE_5.icxl_D2H_RSP_CREDIT_RETURN_PROTOCOL_ID_5			=	`TRANSACTORS_PATH.ICXL_D2H_RSP_CREDIT_RETURN_PROTOCOL_ID[5]     	;
assign  				 	`ICXL_DEVICE_5.icxl_D2H_REQ_CREDIT_RETURN_VALID_5				=	`TRANSACTORS_PATH.ICXL_D2H_REQ_CREDIT_RETURN_VALID[5]     	;
assign  				 	`ICXL_DEVICE_5.icxl_D2H_REQ_PROT_CHID_CREDIT_RETURN_5			=	`TRANSACTORS_PATH.ICXL_D2H_REQ_PROT_CHID_CREDIT_RETURN[5]     	;
assign  				 	`ICXL_DEVICE_5.icxl_D2H_REQ_PROT1_RTYPE_5						=	`TRANSACTORS_PATH.ICXL_D2H_REQ_PROT1_RTYPE[5]     	;
assign  				 	`ICXL_DEVICE_5.icxl_D2H_DATA_CREDIT_RETURN_VALID_5			=	`TRANSACTORS_PATH.ICXL_D2H_DATA_CREDIT_RETURN_VALID[5]     	;
assign  				 	`ICXL_DEVICE_5.icxl_D2H_DATA_PROT_CHID_CREDIT_RETURN_5		=	`TRANSACTORS_PATH.ICXL_D2H_DATA_PROT_CHID_CREDIT_RETURN[5]     	;
assign  				 	`ICXL_DEVICE_5.icxl_D2H_DATA_PROT1_RTYPE_5					=	`TRANSACTORS_PATH.ICXL_D2H_DATA_PROT1_RTYPE[5]     	;
assign  				 	`ICXL_DEVICE_5.icxl_D2H_RSP_CREDIT_RETURN_VALID_5				=	`TRANSACTORS_PATH.ICXL_D2H_RSP_CREDIT_RETURN_VALID[5]     	;

//=================================================================================================================================


	
