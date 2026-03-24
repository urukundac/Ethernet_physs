//=================================================================================================================================
// ICXL_HOST connections - USER MUST EDIT THE RIGHT HAND SIDE OF THE FOLLOWING ASSIGNMENTS AND DEFINE - WHEN NEEDED
//=================================================================================================================================
// ICXL_HOST   connection #0


							`define 	ICXL_DEVICE_1 					fpga_transactors_top_inst   // example:  fpga_tcss_top.tcss_val_rtl.tcss.par_iom    //HERE USER SHOULD SET THE PATH TO HIS SIDE OF THE ICXL INTEFACE, THE DEVICE (=CORE) SIDE
						
assign 				  		`TRANSACTORS_PATH.ICXL_host_clk[1] 			= `ICXL_DEVICE_1.ICXL_device_clk_1;
assign 				  		`TRANSACTORS_PATH.ICXL_host_rstn[1] 		= `ICXL_DEVICE_1.ICXL_device_rstn_1;



//inputs to FGT
 //D2H request channel
assign                  	`TRANSACTORS_PATH.ICXL_D2H_REQ_PROTOCOL[1]     				= `ICXL_DEVICE_1.icxl_D2H_REQ_PROTOCOL_1;
assign                  	`TRANSACTORS_PATH.ICXL_D2H_REQ_VALID[1]     				= `ICXL_DEVICE_1.icxl_D2H_REQ_VALID_1;
assign                  	`TRANSACTORS_PATH.ICXL_D2H_REQ_OPCODE[1]   					= `ICXL_DEVICE_1.icxl_D2H_REQ_OPCODE_1;
assign                  	`TRANSACTORS_PATH.ICXL_D2H_REQ_ADDRESS[1]     				= `ICXL_DEVICE_1.icxl_D2H_REQ_ADDRESS_1;
assign                  	`TRANSACTORS_PATH.ICXL_D2H_REQ_CQID[1]     					= `ICXL_DEVICE_1.icxl_D2H_REQ_CQID_1;
assign                  	`TRANSACTORS_PATH.ICXL_D2H_REQ_NT[1]     					= `ICXL_DEVICE_1.icxl_D2H_REQ_NT_1;
assign                  	`TRANSACTORS_PATH.ICXL_D2H_REQ_PARITY[1]     				= `ICXL_DEVICE_1.icxl_D2H_REQ_PARITY_1;
assign                  	`TRANSACTORS_PATH.ICXL_D2H_REQ_SAI[1]     					= `ICXL_DEVICE_1.icxl_D2H_REQ_SAI_1;
assign                  	`TRANSACTORS_PATH.ICXL_D2H_REQ_ADDR_PARITY[1]     			= `ICXL_DEVICE_1.icxl_D2H_REQ_ADDR_PARITY_1;
assign                  	`TRANSACTORS_PATH.ICXL_D2H_REQ_LENGTH[1]     				= `ICXL_DEVICE_1.icxl_D2H_REQ_LENGTH_1;
assign                  	`TRANSACTORS_PATH.ICXL_D2H_REQ_CHID[1]     					= `ICXL_DEVICE_1.icxl_D2H_REQ_CHID_1;
assign                  	`TRANSACTORS_PATH.ICXL_D2H_REQ_PCIE_HEADER[1]     			= `ICXL_DEVICE_1.icxl_D2H_REQ_PCIE_HEADER_1;
//D2H data channel
assign                  	`TRANSACTORS_PATH.ICXL_D2H_DATA_PROTOCOL[1]     			= `ICXL_DEVICE_1.icxl_D2H_DATA_PROTOCOL_1;
assign                  	`TRANSACTORS_PATH.ICXL_D2H_DATA_VALID[1]     				= `ICXL_DEVICE_1.icxl_D2H_DATA_VALID_1;
assign                  	`TRANSACTORS_PATH.ICXL_D2H_DATA_UQID[1]     				= `ICXL_DEVICE_1.icxl_D2H_DATA_UQID_1;
assign                  	`TRANSACTORS_PATH.ICXL_D2H_DATA_CHUNKVALID[1]     			= `ICXL_DEVICE_1.icxl_D2H_DATA_CHUNKVALID_1;
assign                  	`TRANSACTORS_PATH.ICXL_D2H_DATA_BOGUS[1]     				= `ICXL_DEVICE_1.icxl_D2H_DATA_BOGUS_1;
assign                  	`TRANSACTORS_PATH.ICXL_D2H_DATA_POISON[1]     				= `ICXL_DEVICE_1.icxl_D2H_DATA_POISON_1;
assign                  	`TRANSACTORS_PATH.ICXL_D2H_DATA_DATA[1]     				= `ICXL_DEVICE_1.icxl_D2H_DATA_DATA_1;
assign                  	`TRANSACTORS_PATH.ICXL_D2H_DATA_PARITY[1]     				= `ICXL_DEVICE_1.icxl_D2H_DATA_PARITY_1;
assign                  	`TRANSACTORS_PATH.ICXL_D2H_DATA_BE[1]     					= `ICXL_DEVICE_1.icxl_D2H_DATA_BE_1;
assign                  	`TRANSACTORS_PATH.ICXL_D2H_DATA_CHID[1]     				= `ICXL_DEVICE_1.icxl_D2H_DATA_CHID_1;
//D2H response channel
assign                  	`TRANSACTORS_PATH.ICXL_D2H_RSP_PROTOCOL[1]     				= `ICXL_DEVICE_1.icxl_D2H_RSP_PROTOCOL_1;
assign                  	`TRANSACTORS_PATH.ICXL_D2H_RSP_VALID[1]     				= `ICXL_DEVICE_1.icxl_D2H_RSP_VALID_1;
assign                  	`TRANSACTORS_PATH.ICXL_D2H_RSP_OPCODE[1]     				= `ICXL_DEVICE_1.icxl_D2H_RSP_OPCODE_1;
assign                  	`TRANSACTORS_PATH.ICXL_D2H_RSP_UQID[1]     					= `ICXL_DEVICE_1.icxl_D2H_RSP_UQID_1;
//FLOW CONTROL & GLOBAL channel
assign                  	`TRANSACTORS_PATH.ICXL_HOST_CONNECT_ACK[1]     				= `ICXL_DEVICE_1.icxl_HOST_CONNECT_ACK_1;
assign                  	`TRANSACTORS_PATH.ICXL_DEVICE_CONNECT_REQ[1]     			= `ICXL_DEVICE_1.icxl_DEVICE_CONNECT_REQ_1;
//assign                  	`TRANSACTORS_PATH.ICXL_H2D_CREDIT_RETURN_PROTOCOL_ID[1]		=  `ICXL_DEVICE_1.icxl_H2D_CREDIT_RETURN_PROTOCOL_ID_1;
assign                  	`TRANSACTORS_PATH.ICXL_H2D_REQ_CREDIT_RETURN_PROTOCOL_ID[1]		= `ICXL_DEVICE_1.icxl_H2D_REQ_CREDIT_RETURN_PROTOCOL_ID_1;
assign                  	`TRANSACTORS_PATH.ICXL_H2D_DATA_CREDIT_RETURN_PROTOCOL_ID[1]		= `ICXL_DEVICE_1.icxl_H2D_DATA_CREDIT_RETURN_PROTOCOL_ID_1;
assign                  	`TRANSACTORS_PATH.ICXL_H2D_RSP_CREDIT_RETURN_PROTOCOL_ID[1]		= `ICXL_DEVICE_1.icxl_H2D_RSP_CREDIT_RETURN_PROTOCOL_ID_1;
assign                  	`TRANSACTORS_PATH.ICXL_H2D_REQ_CREDIT_RETURN_VALID[1]     	= `ICXL_DEVICE_1.icxl_H2D_REQ_CREDIT_RETURN_VALID_1;
assign                  	`TRANSACTORS_PATH.ICXL_H2D_REQ_PROT_CHID_CREDIT_RETURN[1]   = `ICXL_DEVICE_1.icxl_H2D_REQ_PROT_CHID_CREDIT_RETURN_1;
assign                  	`TRANSACTORS_PATH.ICXL_H2D_REQ_PROT1_RTYPE[1]     			= `ICXL_DEVICE_1.icxl_H2D_REQ_PROT1_RTYPE_1;
assign                  	`TRANSACTORS_PATH.ICXL_H2D_DATA_CREDIT_RETURN_VALID[1]     	= `ICXL_DEVICE_1.icxl_H2D_DATA_CREDIT_RETURN_VALID_1;
assign                  	`TRANSACTORS_PATH.ICXL_H2D_DATA_PROT_CHID_CREDIT_RETURN[1]  = `ICXL_DEVICE_1.icxl_H2D_DATA_PROT_CHID_CREDIT_RETURN_1;
assign                  	`TRANSACTORS_PATH.ICXL_H2D_DATA_PROT1_RTYPE[1]     			= `ICXL_DEVICE_1.icxl_H2D_DATA_PROT1_RTYPE_1;
assign                  	`TRANSACTORS_PATH.ICXL_H2D_RSP_CREDIT_RETURN_VALID[1]     	= `ICXL_DEVICE_1.icxl_H2D_RSP_CREDIT_RETURN_VALID_1;

//=================================================================================================================================
// CXL_CACHE_HOST connections - USER MUST EDIT THE LEFT HAND SIDE OF THE FOLLOWING ASSIGNMENTS 
//=================================================================================================================================


//outputs from FGT
//H2D request channel
assign  				 	`ICXL_DEVICE_1.icxl_H2D_REQ_PROTOCOL_1						=	`TRANSACTORS_PATH.ICXL_H2D_REQ_PROTOCOL[1]     	;
assign  				 	`ICXL_DEVICE_1.icxl_H2D_REQ_VALID_1							=	`TRANSACTORS_PATH.ICXL_H2D_REQ_VALID[1]     		;
assign  				 	`ICXL_DEVICE_1.icxl_H2D_REQ_OPCODE_1							=	`TRANSACTORS_PATH.ICXL_H2D_REQ_OPCODE[1]     		;
assign  				 	`ICXL_DEVICE_1.icxl_H2D_REQ_ADDRESS_1							=	`TRANSACTORS_PATH.ICXL_H2D_REQ_ADDRESS[1]     		;
assign  				 	`ICXL_DEVICE_1.icxl_H2D_REQ_UQID_1							=	`TRANSACTORS_PATH.ICXL_H2D_REQ_UQID[1]     				;
assign  				 	`ICXL_DEVICE_1.icxl_H2D_REQ_PARITY_1							=	`TRANSACTORS_PATH.ICXL_H2D_REQ_PARITY[1]     				;
assign  				 	`ICXL_DEVICE_1.icxl_H2D_REQ_SAI_1								=	`TRANSACTORS_PATH.ICXL_H2D_REQ_SAI[1]     				;
assign  				 	`ICXL_DEVICE_1.icxl_H2D_REQ_ADDR_PARITY_1						=	`TRANSACTORS_PATH.ICXL_H2D_REQ_ADDR_PARITY[1]     		;
assign  				 	`ICXL_DEVICE_1.icxl_H2D_REQ_LENGTH_1							=	`TRANSACTORS_PATH.ICXL_H2D_REQ_LENGTH[1]     			;
assign						`ICXL_DEVICE_1.icxl_H2D_REQ_CHID_1							=	`TRANSACTORS_PATH.ICXL_H2D_REQ_CHID[1]				;
assign  				 	`ICXL_DEVICE_1.icxl_H2D_REQ_PCIE_HEADER_1						=	`TRANSACTORS_PATH.ICXL_H2D_REQ_PCIE_HEADER[1]     			;
//H2D data channel
assign  				 	`ICXL_DEVICE_1.icxl_H2D_DATA_PROTOCOL_1						=	`TRANSACTORS_PATH.ICXL_H2D_DATA_PROTOCOL[1]     				;
assign  				 	`ICXL_DEVICE_1.icxl_H2D_DATA_VALID_1							=	`TRANSACTORS_PATH.ICXL_H2D_DATA_VALID[1]     			;
assign  				 	`ICXL_DEVICE_1.icxl_H2D_DATA_CQID_1							=	`TRANSACTORS_PATH.ICXL_H2D_DATA_CQID[1]     			;
assign  				 	`ICXL_DEVICE_1.icxl_H2D_DATA_CHUNKVALID_1						=	`TRANSACTORS_PATH.ICXL_H2D_DATA_CHUNKVALID[1]    		 	;//this is equivalent to h2d_data_misc[2]
assign  				 	`ICXL_DEVICE_1.icxl_H2D_DATA_GOERR_1							=	`TRANSACTORS_PATH.ICXL_H2D_DATA_GOERR[1]     				;//this is equivalent to h2d_data_misc[0]
assign  				 	`ICXL_DEVICE_1.icxl_H2D_DATA_POISON_1							=	`TRANSACTORS_PATH.ICXL_H2D_DATA_POISON[1]     		;//this is equivalent to h2d_data_misc[1]
assign  				 	`ICXL_DEVICE_1.icxl_H2D_DATA_DATA_1							=	`TRANSACTORS_PATH.ICXL_H2D_DATA_DATA[1]     			;
assign  				 	`ICXL_DEVICE_1.icxl_H2D_DATA_PARITY_1							=	`TRANSACTORS_PATH.ICXL_H2D_DATA_PARITY[1]     			;
assign  				 	`ICXL_DEVICE_1.icxl_H2D_DATA_HALFLINEONLY_1					=	`TRANSACTORS_PATH.ICXL_H2D_DATA_HALFLINEONLY[1]     				;
//H2D response channel
assign  				 	`ICXL_DEVICE_1.icxl_H2D_RSP_PROTOCOL_1						=	`TRANSACTORS_PATH.ICXL_H2D_RSP_PROTOCOL[1]     				;
assign  				 	`ICXL_DEVICE_1.icxl_H2D_RSP_VALID_1							=	`TRANSACTORS_PATH.ICXL_H2D_RSP_VALID[1]     				;
assign  				 	`ICXL_DEVICE_1.icxl_H2D_RSP_OPCODE_1							=	`TRANSACTORS_PATH.ICXL_H2D_RSP_OPCODE[1]     			;
assign  				 	`ICXL_DEVICE_1.icxl_H2D_RSP_CQID_1							=	`TRANSACTORS_PATH.ICXL_H2D_RSP_CQID[1]     				;
assign  				 	`ICXL_DEVICE_1.icxl_H2D_RSP_RSPDATA_1							=	`TRANSACTORS_PATH.ICXL_H2D_RSP_RSPDATA[1]   		 	 	;
assign  				 	`ICXL_DEVICE_1.icxl_H2D_RSP_RSP_PRE_1							=	`TRANSACTORS_PATH.ICXL_H2D_RSP_RSP_PRE[1]     				;
 //FLOW CONTROL & GLOBAL channel
assign  				 	`ICXL_DEVICE_1.icxl_HOST_CONNECT_REQ_1						=	`TRANSACTORS_PATH.ICXL_HOST_CONNECT_REQ[1]     	;
assign  				 	`ICXL_DEVICE_1.icxl_DEVICE_CONNECT_ACK_1						=	`TRANSACTORS_PATH.ICXL_DEVICE_CONNECT_ACK[1]     	;
//assign  				 	`ICXL_DEVICE_1.icxl_D2H_CREDIT_RETURN_PROTOCOL_ID_1			=	`TRANSACTORS_PATH.ICXL_D2H_CREDIT_RETURN_PROTOCOL_ID[1]     	;
assign  				 	`ICXL_DEVICE_1.icxl_D2H_REQ_CREDIT_RETURN_PROTOCOL_ID_1			=	`TRANSACTORS_PATH.ICXL_D2H_REQ_CREDIT_RETURN_PROTOCOL_ID[1]     	;
assign  				 	`ICXL_DEVICE_1.icxl_D2H_DATA_CREDIT_RETURN_PROTOCOL_ID_1			=	`TRANSACTORS_PATH.ICXL_D2H_DATA_CREDIT_RETURN_PROTOCOL_ID[1]     	;
assign  				 	`ICXL_DEVICE_1.icxl_D2H_RSP_CREDIT_RETURN_PROTOCOL_ID_1			=	`TRANSACTORS_PATH.ICXL_D2H_RSP_CREDIT_RETURN_PROTOCOL_ID[1]     	;
assign  				 	`ICXL_DEVICE_1.icxl_D2H_REQ_CREDIT_RETURN_VALID_1				=	`TRANSACTORS_PATH.ICXL_D2H_REQ_CREDIT_RETURN_VALID[1]     	;
assign  				 	`ICXL_DEVICE_1.icxl_D2H_REQ_PROT_CHID_CREDIT_RETURN_1			=	`TRANSACTORS_PATH.ICXL_D2H_REQ_PROT_CHID_CREDIT_RETURN[1]     	;
assign  				 	`ICXL_DEVICE_1.icxl_D2H_REQ_PROT1_RTYPE_1						=	`TRANSACTORS_PATH.ICXL_D2H_REQ_PROT1_RTYPE[1]     	;
assign  				 	`ICXL_DEVICE_1.icxl_D2H_DATA_CREDIT_RETURN_VALID_1			=	`TRANSACTORS_PATH.ICXL_D2H_DATA_CREDIT_RETURN_VALID[1]     	;
assign  				 	`ICXL_DEVICE_1.icxl_D2H_DATA_PROT_CHID_CREDIT_RETURN_1		=	`TRANSACTORS_PATH.ICXL_D2H_DATA_PROT_CHID_CREDIT_RETURN[1]     	;
assign  				 	`ICXL_DEVICE_1.icxl_D2H_DATA_PROT1_RTYPE_1					=	`TRANSACTORS_PATH.ICXL_D2H_DATA_PROT1_RTYPE[1]     	;
assign  				 	`ICXL_DEVICE_1.icxl_D2H_RSP_CREDIT_RETURN_VALID_1				=	`TRANSACTORS_PATH.ICXL_D2H_RSP_CREDIT_RETURN_VALID[1]     	;

//=================================================================================================================================


	
