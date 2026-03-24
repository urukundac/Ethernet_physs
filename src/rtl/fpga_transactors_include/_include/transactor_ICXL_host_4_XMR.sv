//=================================================================================================================================
// ICXL_HOST connections - USER MUST EDIT THE RIGHT HAND SIDE OF THE FOLLOWING ASSIGNMENTS AND DEFINE - WHEN NEEDED
//=================================================================================================================================
// ICXL_HOST   connection #0


							`define 	ICXL_DEVICE_4 					fpga_transactors_top_inst   // example:  fpga_tcss_top.tcss_val_rtl.tcss.par_iom    //HERE USER SHOULD SET THE PATH TO HIS SIDE OF THE ICXL INTEFACE, THE DEVICE (=CORE) SIDE
						
assign 				  		`TRANSACTORS_PATH.ICXL_host_clk[4] 			= `ICXL_DEVICE_4.ICXL_device_clk_4;
assign 				  		`TRANSACTORS_PATH.ICXL_host_rstn[4] 		= `ICXL_DEVICE_4.ICXL_device_rstn_4;



//inputs to FGT
 //D2H request channel
assign                  	`TRANSACTORS_PATH.ICXL_D2H_REQ_PROTOCOL[4]     				= `ICXL_DEVICE_4.icxl_D2H_REQ_PROTOCOL_4;
assign                  	`TRANSACTORS_PATH.ICXL_D2H_REQ_VALID[4]     				= `ICXL_DEVICE_4.icxl_D2H_REQ_VALID_4;
assign                  	`TRANSACTORS_PATH.ICXL_D2H_REQ_OPCODE[4]   					= `ICXL_DEVICE_4.icxl_D2H_REQ_OPCODE_4;
assign                  	`TRANSACTORS_PATH.ICXL_D2H_REQ_ADDRESS[4]     				= `ICXL_DEVICE_4.icxl_D2H_REQ_ADDRESS_4;
assign                  	`TRANSACTORS_PATH.ICXL_D2H_REQ_CQID[4]     					= `ICXL_DEVICE_4.icxl_D2H_REQ_CQID_4;
assign                  	`TRANSACTORS_PATH.ICXL_D2H_REQ_NT[4]     					= `ICXL_DEVICE_4.icxl_D2H_REQ_NT_4;
assign                  	`TRANSACTORS_PATH.ICXL_D2H_REQ_PARITY[4]     				= `ICXL_DEVICE_4.icxl_D2H_REQ_PARITY_4;
assign                  	`TRANSACTORS_PATH.ICXL_D2H_REQ_SAI[4]     					= `ICXL_DEVICE_4.icxl_D2H_REQ_SAI_4;
assign                  	`TRANSACTORS_PATH.ICXL_D2H_REQ_ADDR_PARITY[4]     			= `ICXL_DEVICE_4.icxl_D2H_REQ_ADDR_PARITY_4;
assign                  	`TRANSACTORS_PATH.ICXL_D2H_REQ_LENGTH[4]     				= `ICXL_DEVICE_4.icxl_D2H_REQ_LENGTH_4;
assign                  	`TRANSACTORS_PATH.ICXL_D2H_REQ_CHID[4]     					= `ICXL_DEVICE_4.icxl_D2H_REQ_CHID_4;
assign                  	`TRANSACTORS_PATH.ICXL_D2H_REQ_PCIE_HEADER[4]     			= `ICXL_DEVICE_4.icxl_D2H_REQ_PCIE_HEADER_4;
//D2H data channel
assign                  	`TRANSACTORS_PATH.ICXL_D2H_DATA_PROTOCOL[4]     			= `ICXL_DEVICE_4.icxl_D2H_DATA_PROTOCOL_4;
assign                  	`TRANSACTORS_PATH.ICXL_D2H_DATA_VALID[4]     				= `ICXL_DEVICE_4.icxl_D2H_DATA_VALID_4;
assign                  	`TRANSACTORS_PATH.ICXL_D2H_DATA_UQID[4]     				= `ICXL_DEVICE_4.icxl_D2H_DATA_UQID_4;
assign                  	`TRANSACTORS_PATH.ICXL_D2H_DATA_CHUNKVALID[4]     			= `ICXL_DEVICE_4.icxl_D2H_DATA_CHUNKVALID_4;
assign                  	`TRANSACTORS_PATH.ICXL_D2H_DATA_BOGUS[4]     				= `ICXL_DEVICE_4.icxl_D2H_DATA_BOGUS_4;
assign                  	`TRANSACTORS_PATH.ICXL_D2H_DATA_POISON[4]     				= `ICXL_DEVICE_4.icxl_D2H_DATA_POISON_4;
assign                  	`TRANSACTORS_PATH.ICXL_D2H_DATA_DATA[4]     				= `ICXL_DEVICE_4.icxl_D2H_DATA_DATA_4;
assign                  	`TRANSACTORS_PATH.ICXL_D2H_DATA_PARITY[4]     				= `ICXL_DEVICE_4.icxl_D2H_DATA_PARITY_4;
assign                  	`TRANSACTORS_PATH.ICXL_D2H_DATA_BE[4]     					= `ICXL_DEVICE_4.icxl_D2H_DATA_BE_4;
assign                  	`TRANSACTORS_PATH.ICXL_D2H_DATA_CHID[4]     				= `ICXL_DEVICE_4.icxl_D2H_DATA_CHID_4;
//D2H response channel
assign                  	`TRANSACTORS_PATH.ICXL_D2H_RSP_PROTOCOL[4]     				= `ICXL_DEVICE_4.icxl_D2H_RSP_PROTOCOL_4;
assign                  	`TRANSACTORS_PATH.ICXL_D2H_RSP_VALID[4]     				= `ICXL_DEVICE_4.icxl_D2H_RSP_VALID_4;
assign                  	`TRANSACTORS_PATH.ICXL_D2H_RSP_OPCODE[4]     				= `ICXL_DEVICE_4.icxl_D2H_RSP_OPCODE_4;
assign                  	`TRANSACTORS_PATH.ICXL_D2H_RSP_UQID[4]     					= `ICXL_DEVICE_4.icxl_D2H_RSP_UQID_4;
//FLOW CONTROL & GLOBAL channel
assign                  	`TRANSACTORS_PATH.ICXL_HOST_CONNECT_ACK[4]     				= `ICXL_DEVICE_4.icxl_HOST_CONNECT_ACK_4;
assign                  	`TRANSACTORS_PATH.ICXL_DEVICE_CONNECT_REQ[4]     			= `ICXL_DEVICE_4.icxl_DEVICE_CONNECT_REQ_4;
//assign                  	`TRANSACTORS_PATH.ICXL_H2D_CREDIT_RETURN_PROTOCOL_ID[4]		=  `ICXL_DEVICE_4.icxl_H2D_CREDIT_RETURN_PROTOCOL_ID_4;
assign                  	`TRANSACTORS_PATH.ICXL_H2D_REQ_CREDIT_RETURN_PROTOCOL_ID[4]		= `ICXL_DEVICE_4.icxl_H2D_REQ_CREDIT_RETURN_PROTOCOL_ID_4;
assign                  	`TRANSACTORS_PATH.ICXL_H2D_DATA_CREDIT_RETURN_PROTOCOL_ID[4]		= `ICXL_DEVICE_4.icxl_H2D_DATA_CREDIT_RETURN_PROTOCOL_ID_4;
assign                  	`TRANSACTORS_PATH.ICXL_H2D_RSP_CREDIT_RETURN_PROTOCOL_ID[4]		= `ICXL_DEVICE_4.icxl_H2D_RSP_CREDIT_RETURN_PROTOCOL_ID_4;
assign                  	`TRANSACTORS_PATH.ICXL_H2D_REQ_CREDIT_RETURN_VALID[4]     	= `ICXL_DEVICE_4.icxl_H2D_REQ_CREDIT_RETURN_VALID_4;
assign                  	`TRANSACTORS_PATH.ICXL_H2D_REQ_PROT_CHID_CREDIT_RETURN[4]   = `ICXL_DEVICE_4.icxl_H2D_REQ_PROT_CHID_CREDIT_RETURN_4;
assign                  	`TRANSACTORS_PATH.ICXL_H2D_REQ_PROT1_RTYPE[4]     			= `ICXL_DEVICE_4.icxl_H2D_REQ_PROT1_RTYPE_4;
assign                  	`TRANSACTORS_PATH.ICXL_H2D_DATA_CREDIT_RETURN_VALID[4]     	= `ICXL_DEVICE_4.icxl_H2D_DATA_CREDIT_RETURN_VALID_4;
assign                  	`TRANSACTORS_PATH.ICXL_H2D_DATA_PROT_CHID_CREDIT_RETURN[4]  = `ICXL_DEVICE_4.icxl_H2D_DATA_PROT_CHID_CREDIT_RETURN_4;
assign                  	`TRANSACTORS_PATH.ICXL_H2D_DATA_PROT1_RTYPE[4]     			= `ICXL_DEVICE_4.icxl_H2D_DATA_PROT1_RTYPE_4;
assign                  	`TRANSACTORS_PATH.ICXL_H2D_RSP_CREDIT_RETURN_VALID[4]     	= `ICXL_DEVICE_4.icxl_H2D_RSP_CREDIT_RETURN_VALID_4;

//=================================================================================================================================
// CXL_CACHE_HOST connections - USER MUST EDIT THE LEFT HAND SIDE OF THE FOLLOWING ASSIGNMENTS 
//=================================================================================================================================


//outputs from FGT
//H2D request channel
assign  				 	`ICXL_DEVICE_4.icxl_H2D_REQ_PROTOCOL_4						=	`TRANSACTORS_PATH.ICXL_H2D_REQ_PROTOCOL[4]     	;
assign  				 	`ICXL_DEVICE_4.icxl_H2D_REQ_VALID_4							=	`TRANSACTORS_PATH.ICXL_H2D_REQ_VALID[4]     		;
assign  				 	`ICXL_DEVICE_4.icxl_H2D_REQ_OPCODE_4							=	`TRANSACTORS_PATH.ICXL_H2D_REQ_OPCODE[4]     		;
assign  				 	`ICXL_DEVICE_4.icxl_H2D_REQ_ADDRESS_4							=	`TRANSACTORS_PATH.ICXL_H2D_REQ_ADDRESS[4]     		;
assign  				 	`ICXL_DEVICE_4.icxl_H2D_REQ_UQID_4							=	`TRANSACTORS_PATH.ICXL_H2D_REQ_UQID[4]     				;
assign  				 	`ICXL_DEVICE_4.icxl_H2D_REQ_PARITY_4							=	`TRANSACTORS_PATH.ICXL_H2D_REQ_PARITY[4]     				;
assign  				 	`ICXL_DEVICE_4.icxl_H2D_REQ_SAI_4								=	`TRANSACTORS_PATH.ICXL_H2D_REQ_SAI[4]     				;
assign  				 	`ICXL_DEVICE_4.icxl_H2D_REQ_ADDR_PARITY_4						=	`TRANSACTORS_PATH.ICXL_H2D_REQ_ADDR_PARITY[4]     		;
assign  				 	`ICXL_DEVICE_4.icxl_H2D_REQ_LENGTH_4							=	`TRANSACTORS_PATH.ICXL_H2D_REQ_LENGTH[4]     			;
assign						`ICXL_DEVICE_4.icxl_H2D_REQ_CHID_4							=	`TRANSACTORS_PATH.ICXL_H2D_REQ_CHID[4]				;
assign  				 	`ICXL_DEVICE_4.icxl_H2D_REQ_PCIE_HEADER_4						=	`TRANSACTORS_PATH.ICXL_H2D_REQ_PCIE_HEADER[4]     			;
//H2D data channel
assign  				 	`ICXL_DEVICE_4.icxl_H2D_DATA_PROTOCOL_4						=	`TRANSACTORS_PATH.ICXL_H2D_DATA_PROTOCOL[4]     				;
assign  				 	`ICXL_DEVICE_4.icxl_H2D_DATA_VALID_4							=	`TRANSACTORS_PATH.ICXL_H2D_DATA_VALID[4]     			;
assign  				 	`ICXL_DEVICE_4.icxl_H2D_DATA_CQID_4							=	`TRANSACTORS_PATH.ICXL_H2D_DATA_CQID[4]     			;
assign  				 	`ICXL_DEVICE_4.icxl_H2D_DATA_CHUNKVALID_4						=	`TRANSACTORS_PATH.ICXL_H2D_DATA_CHUNKVALID[4]    		 	;//this is equivalent to h2d_data_misc[2]
assign  				 	`ICXL_DEVICE_4.icxl_H2D_DATA_GOERR_4							=	`TRANSACTORS_PATH.ICXL_H2D_DATA_GOERR[4]     				;//this is equivalent to h2d_data_misc[0]
assign  				 	`ICXL_DEVICE_4.icxl_H2D_DATA_POISON_4							=	`TRANSACTORS_PATH.ICXL_H2D_DATA_POISON[4]     		;//this is equivalent to h2d_data_misc[1]
assign  				 	`ICXL_DEVICE_4.icxl_H2D_DATA_DATA_4							=	`TRANSACTORS_PATH.ICXL_H2D_DATA_DATA[4]     			;
assign  				 	`ICXL_DEVICE_4.icxl_H2D_DATA_PARITY_4							=	`TRANSACTORS_PATH.ICXL_H2D_DATA_PARITY[4]     			;
assign  				 	`ICXL_DEVICE_4.icxl_H2D_DATA_HALFLINEONLY_4					=	`TRANSACTORS_PATH.ICXL_H2D_DATA_HALFLINEONLY[4]     				;
//H2D response channel
assign  				 	`ICXL_DEVICE_4.icxl_H2D_RSP_PROTOCOL_4						=	`TRANSACTORS_PATH.ICXL_H2D_RSP_PROTOCOL[4]     				;
assign  				 	`ICXL_DEVICE_4.icxl_H2D_RSP_VALID_4							=	`TRANSACTORS_PATH.ICXL_H2D_RSP_VALID[4]     				;
assign  				 	`ICXL_DEVICE_4.icxl_H2D_RSP_OPCODE_4							=	`TRANSACTORS_PATH.ICXL_H2D_RSP_OPCODE[4]     			;
assign  				 	`ICXL_DEVICE_4.icxl_H2D_RSP_CQID_4							=	`TRANSACTORS_PATH.ICXL_H2D_RSP_CQID[4]     				;
assign  				 	`ICXL_DEVICE_4.icxl_H2D_RSP_RSPDATA_4							=	`TRANSACTORS_PATH.ICXL_H2D_RSP_RSPDATA[4]   		 	 	;
assign  				 	`ICXL_DEVICE_4.icxl_H2D_RSP_RSP_PRE_4							=	`TRANSACTORS_PATH.ICXL_H2D_RSP_RSP_PRE[4]     				;
 //FLOW CONTROL & GLOBAL channel
assign  				 	`ICXL_DEVICE_4.icxl_HOST_CONNECT_REQ_4						=	`TRANSACTORS_PATH.ICXL_HOST_CONNECT_REQ[4]     	;
assign  				 	`ICXL_DEVICE_4.icxl_DEVICE_CONNECT_ACK_4						=	`TRANSACTORS_PATH.ICXL_DEVICE_CONNECT_ACK[4]     	;
//assign  				 	`ICXL_DEVICE_4.icxl_D2H_CREDIT_RETURN_PROTOCOL_ID_4			=	`TRANSACTORS_PATH.ICXL_D2H_CREDIT_RETURN_PROTOCOL_ID[4]     	;
assign  				 	`ICXL_DEVICE_4.icxl_D2H_REQ_CREDIT_RETURN_PROTOCOL_ID_4			=	`TRANSACTORS_PATH.ICXL_D2H_REQ_CREDIT_RETURN_PROTOCOL_ID[4]     	;
assign  				 	`ICXL_DEVICE_4.icxl_D2H_DATA_CREDIT_RETURN_PROTOCOL_ID_4			=	`TRANSACTORS_PATH.ICXL_D2H_DATA_CREDIT_RETURN_PROTOCOL_ID[4]     	;
assign  				 	`ICXL_DEVICE_4.icxl_D2H_RSP_CREDIT_RETURN_PROTOCOL_ID_4			=	`TRANSACTORS_PATH.ICXL_D2H_RSP_CREDIT_RETURN_PROTOCOL_ID[4]     	;
assign  				 	`ICXL_DEVICE_4.icxl_D2H_REQ_CREDIT_RETURN_VALID_4				=	`TRANSACTORS_PATH.ICXL_D2H_REQ_CREDIT_RETURN_VALID[4]     	;
assign  				 	`ICXL_DEVICE_4.icxl_D2H_REQ_PROT_CHID_CREDIT_RETURN_4			=	`TRANSACTORS_PATH.ICXL_D2H_REQ_PROT_CHID_CREDIT_RETURN[4]     	;
assign  				 	`ICXL_DEVICE_4.icxl_D2H_REQ_PROT1_RTYPE_4						=	`TRANSACTORS_PATH.ICXL_D2H_REQ_PROT1_RTYPE[4]     	;
assign  				 	`ICXL_DEVICE_4.icxl_D2H_DATA_CREDIT_RETURN_VALID_4			=	`TRANSACTORS_PATH.ICXL_D2H_DATA_CREDIT_RETURN_VALID[4]     	;
assign  				 	`ICXL_DEVICE_4.icxl_D2H_DATA_PROT_CHID_CREDIT_RETURN_4		=	`TRANSACTORS_PATH.ICXL_D2H_DATA_PROT_CHID_CREDIT_RETURN[4]     	;
assign  				 	`ICXL_DEVICE_4.icxl_D2H_DATA_PROT1_RTYPE_4					=	`TRANSACTORS_PATH.ICXL_D2H_DATA_PROT1_RTYPE[4]     	;
assign  				 	`ICXL_DEVICE_4.icxl_D2H_RSP_CREDIT_RETURN_VALID_4				=	`TRANSACTORS_PATH.ICXL_D2H_RSP_CREDIT_RETURN_VALID[4]     	;

//=================================================================================================================================


	
