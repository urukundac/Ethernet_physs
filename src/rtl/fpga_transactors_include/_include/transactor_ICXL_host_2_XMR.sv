//=================================================================================================================================
// ICXL_HOST connections - USER MUST EDIT THE RIGHT HAND SIDE OF THE FOLLOWING ASSIGNMENTS AND DEFINE - WHEN NEEDED
//=================================================================================================================================
// ICXL_HOST   connection #0


							`define 	ICXL_DEVICE_2 					fpga_transactors_top_inst   // example:  fpga_tcss_top.tcss_val_rtl.tcss.par_iom    //HERE USER SHOULD SET THE PATH TO HIS SIDE OF THE ICXL INTEFACE, THE DEVICE (=CORE) SIDE
						
assign 				  		`TRANSACTORS_PATH.ICXL_host_clk[2] 			= `ICXL_DEVICE_2.ICXL_device_clk_2;
assign 				  		`TRANSACTORS_PATH.ICXL_host_rstn[2] 		= `ICXL_DEVICE_2.ICXL_device_rstn_2;



//inputs to FGT
 //D2H request channel
assign                  	`TRANSACTORS_PATH.ICXL_D2H_REQ_PROTOCOL[2]     				= `ICXL_DEVICE_2.icxl_D2H_REQ_PROTOCOL_2;
assign                  	`TRANSACTORS_PATH.ICXL_D2H_REQ_VALID[2]     				= `ICXL_DEVICE_2.icxl_D2H_REQ_VALID_2;
assign                  	`TRANSACTORS_PATH.ICXL_D2H_REQ_OPCODE[2]   					= `ICXL_DEVICE_2.icxl_D2H_REQ_OPCODE_2;
assign                  	`TRANSACTORS_PATH.ICXL_D2H_REQ_ADDRESS[2]     				= `ICXL_DEVICE_2.icxl_D2H_REQ_ADDRESS_2;
assign                  	`TRANSACTORS_PATH.ICXL_D2H_REQ_CQID[2]     					= `ICXL_DEVICE_2.icxl_D2H_REQ_CQID_2;
assign                  	`TRANSACTORS_PATH.ICXL_D2H_REQ_NT[2]     					= `ICXL_DEVICE_2.icxl_D2H_REQ_NT_2;
assign                  	`TRANSACTORS_PATH.ICXL_D2H_REQ_PARITY[2]     				= `ICXL_DEVICE_2.icxl_D2H_REQ_PARITY_2;
assign                  	`TRANSACTORS_PATH.ICXL_D2H_REQ_SAI[2]     					= `ICXL_DEVICE_2.icxl_D2H_REQ_SAI_2;
assign                  	`TRANSACTORS_PATH.ICXL_D2H_REQ_ADDR_PARITY[2]     			= `ICXL_DEVICE_2.icxl_D2H_REQ_ADDR_PARITY_2;
assign                  	`TRANSACTORS_PATH.ICXL_D2H_REQ_LENGTH[2]     				= `ICXL_DEVICE_2.icxl_D2H_REQ_LENGTH_2;
assign                  	`TRANSACTORS_PATH.ICXL_D2H_REQ_CHID[2]     					= `ICXL_DEVICE_2.icxl_D2H_REQ_CHID_2;
assign                  	`TRANSACTORS_PATH.ICXL_D2H_REQ_PCIE_HEADER[2]     			= `ICXL_DEVICE_2.icxl_D2H_REQ_PCIE_HEADER_2;
//D2H data channel
assign                  	`TRANSACTORS_PATH.ICXL_D2H_DATA_PROTOCOL[2]     			= `ICXL_DEVICE_2.icxl_D2H_DATA_PROTOCOL_2;
assign                  	`TRANSACTORS_PATH.ICXL_D2H_DATA_VALID[2]     				= `ICXL_DEVICE_2.icxl_D2H_DATA_VALID_2;
assign                  	`TRANSACTORS_PATH.ICXL_D2H_DATA_UQID[2]     				= `ICXL_DEVICE_2.icxl_D2H_DATA_UQID_2;
assign                  	`TRANSACTORS_PATH.ICXL_D2H_DATA_CHUNKVALID[2]     			= `ICXL_DEVICE_2.icxl_D2H_DATA_CHUNKVALID_2;
assign                  	`TRANSACTORS_PATH.ICXL_D2H_DATA_BOGUS[2]     				= `ICXL_DEVICE_2.icxl_D2H_DATA_BOGUS_2;
assign                  	`TRANSACTORS_PATH.ICXL_D2H_DATA_POISON[2]     				= `ICXL_DEVICE_2.icxl_D2H_DATA_POISON_2;
assign                  	`TRANSACTORS_PATH.ICXL_D2H_DATA_DATA[2]     				= `ICXL_DEVICE_2.icxl_D2H_DATA_DATA_2;
assign                  	`TRANSACTORS_PATH.ICXL_D2H_DATA_PARITY[2]     				= `ICXL_DEVICE_2.icxl_D2H_DATA_PARITY_2;
assign                  	`TRANSACTORS_PATH.ICXL_D2H_DATA_BE[2]     					= `ICXL_DEVICE_2.icxl_D2H_DATA_BE_2;
assign                  	`TRANSACTORS_PATH.ICXL_D2H_DATA_CHID[2]     				= `ICXL_DEVICE_2.icxl_D2H_DATA_CHID_2;
//D2H response channel
assign                  	`TRANSACTORS_PATH.ICXL_D2H_RSP_PROTOCOL[2]     				= `ICXL_DEVICE_2.icxl_D2H_RSP_PROTOCOL_2;
assign                  	`TRANSACTORS_PATH.ICXL_D2H_RSP_VALID[2]     				= `ICXL_DEVICE_2.icxl_D2H_RSP_VALID_2;
assign                  	`TRANSACTORS_PATH.ICXL_D2H_RSP_OPCODE[2]     				= `ICXL_DEVICE_2.icxl_D2H_RSP_OPCODE_2;
assign                  	`TRANSACTORS_PATH.ICXL_D2H_RSP_UQID[2]     					= `ICXL_DEVICE_2.icxl_D2H_RSP_UQID_2;
//FLOW CONTROL & GLOBAL channel
assign                  	`TRANSACTORS_PATH.ICXL_HOST_CONNECT_ACK[2]     				= `ICXL_DEVICE_2.icxl_HOST_CONNECT_ACK_2;
assign                  	`TRANSACTORS_PATH.ICXL_DEVICE_CONNECT_REQ[2]     			= `ICXL_DEVICE_2.icxl_DEVICE_CONNECT_REQ_2;
//assign                  	`TRANSACTORS_PATH.ICXL_H2D_CREDIT_RETURN_PROTOCOL_ID[2]		=  `ICXL_DEVICE_2.icxl_H2D_CREDIT_RETURN_PROTOCOL_ID_2;
assign                  	`TRANSACTORS_PATH.ICXL_H2D_REQ_CREDIT_RETURN_PROTOCOL_ID[2]		= `ICXL_DEVICE_2.icxl_H2D_REQ_CREDIT_RETURN_PROTOCOL_ID_2;
assign                  	`TRANSACTORS_PATH.ICXL_H2D_DATA_CREDIT_RETURN_PROTOCOL_ID[2]		= `ICXL_DEVICE_2.icxl_H2D_DATA_CREDIT_RETURN_PROTOCOL_ID_2;
assign                  	`TRANSACTORS_PATH.ICXL_H2D_RSP_CREDIT_RETURN_PROTOCOL_ID[2]		= `ICXL_DEVICE_2.icxl_H2D_RSP_CREDIT_RETURN_PROTOCOL_ID_2;
assign                  	`TRANSACTORS_PATH.ICXL_H2D_REQ_CREDIT_RETURN_VALID[2]     	= `ICXL_DEVICE_2.icxl_H2D_REQ_CREDIT_RETURN_VALID_2;
assign                  	`TRANSACTORS_PATH.ICXL_H2D_REQ_PROT_CHID_CREDIT_RETURN[2]   = `ICXL_DEVICE_2.icxl_H2D_REQ_PROT_CHID_CREDIT_RETURN_2;
assign                  	`TRANSACTORS_PATH.ICXL_H2D_REQ_PROT1_RTYPE[2]     			= `ICXL_DEVICE_2.icxl_H2D_REQ_PROT1_RTYPE_2;
assign                  	`TRANSACTORS_PATH.ICXL_H2D_DATA_CREDIT_RETURN_VALID[2]     	= `ICXL_DEVICE_2.icxl_H2D_DATA_CREDIT_RETURN_VALID_2;
assign                  	`TRANSACTORS_PATH.ICXL_H2D_DATA_PROT_CHID_CREDIT_RETURN[2]  = `ICXL_DEVICE_2.icxl_H2D_DATA_PROT_CHID_CREDIT_RETURN_2;
assign                  	`TRANSACTORS_PATH.ICXL_H2D_DATA_PROT1_RTYPE[2]     			= `ICXL_DEVICE_2.icxl_H2D_DATA_PROT1_RTYPE_2;
assign                  	`TRANSACTORS_PATH.ICXL_H2D_RSP_CREDIT_RETURN_VALID[2]     	= `ICXL_DEVICE_2.icxl_H2D_RSP_CREDIT_RETURN_VALID_2;

//=================================================================================================================================
// CXL_CACHE_HOST connections - USER MUST EDIT THE LEFT HAND SIDE OF THE FOLLOWING ASSIGNMENTS 
//=================================================================================================================================


//outputs from FGT
//H2D request channel
assign  				 	`ICXL_DEVICE_2.icxl_H2D_REQ_PROTOCOL_2						=	`TRANSACTORS_PATH.ICXL_H2D_REQ_PROTOCOL[2]     	;
assign  				 	`ICXL_DEVICE_2.icxl_H2D_REQ_VALID_2							=	`TRANSACTORS_PATH.ICXL_H2D_REQ_VALID[2]     		;
assign  				 	`ICXL_DEVICE_2.icxl_H2D_REQ_OPCODE_2							=	`TRANSACTORS_PATH.ICXL_H2D_REQ_OPCODE[2]     		;
assign  				 	`ICXL_DEVICE_2.icxl_H2D_REQ_ADDRESS_2							=	`TRANSACTORS_PATH.ICXL_H2D_REQ_ADDRESS[2]     		;
assign  				 	`ICXL_DEVICE_2.icxl_H2D_REQ_UQID_2							=	`TRANSACTORS_PATH.ICXL_H2D_REQ_UQID[2]     				;
assign  				 	`ICXL_DEVICE_2.icxl_H2D_REQ_PARITY_2							=	`TRANSACTORS_PATH.ICXL_H2D_REQ_PARITY[2]     				;
assign  				 	`ICXL_DEVICE_2.icxl_H2D_REQ_SAI_2								=	`TRANSACTORS_PATH.ICXL_H2D_REQ_SAI[2]     				;
assign  				 	`ICXL_DEVICE_2.icxl_H2D_REQ_ADDR_PARITY_2						=	`TRANSACTORS_PATH.ICXL_H2D_REQ_ADDR_PARITY[2]     		;
assign  				 	`ICXL_DEVICE_2.icxl_H2D_REQ_LENGTH_2							=	`TRANSACTORS_PATH.ICXL_H2D_REQ_LENGTH[2]     			;
assign						`ICXL_DEVICE_2.icxl_H2D_REQ_CHID_2							=	`TRANSACTORS_PATH.ICXL_H2D_REQ_CHID[2]				;
assign  				 	`ICXL_DEVICE_2.icxl_H2D_REQ_PCIE_HEADER_2						=	`TRANSACTORS_PATH.ICXL_H2D_REQ_PCIE_HEADER[2]     			;
//H2D data channel
assign  				 	`ICXL_DEVICE_2.icxl_H2D_DATA_PROTOCOL_2						=	`TRANSACTORS_PATH.ICXL_H2D_DATA_PROTOCOL[2]     				;
assign  				 	`ICXL_DEVICE_2.icxl_H2D_DATA_VALID_2							=	`TRANSACTORS_PATH.ICXL_H2D_DATA_VALID[2]     			;
assign  				 	`ICXL_DEVICE_2.icxl_H2D_DATA_CQID_2							=	`TRANSACTORS_PATH.ICXL_H2D_DATA_CQID[2]     			;
assign  				 	`ICXL_DEVICE_2.icxl_H2D_DATA_CHUNKVALID_2						=	`TRANSACTORS_PATH.ICXL_H2D_DATA_CHUNKVALID[2]    		 	;//this is equivalent to h2d_data_misc[2]
assign  				 	`ICXL_DEVICE_2.icxl_H2D_DATA_GOERR_2							=	`TRANSACTORS_PATH.ICXL_H2D_DATA_GOERR[2]     				;//this is equivalent to h2d_data_misc[0]
assign  				 	`ICXL_DEVICE_2.icxl_H2D_DATA_POISON_2							=	`TRANSACTORS_PATH.ICXL_H2D_DATA_POISON[2]     		;//this is equivalent to h2d_data_misc[1]
assign  				 	`ICXL_DEVICE_2.icxl_H2D_DATA_DATA_2							=	`TRANSACTORS_PATH.ICXL_H2D_DATA_DATA[2]     			;
assign  				 	`ICXL_DEVICE_2.icxl_H2D_DATA_PARITY_2							=	`TRANSACTORS_PATH.ICXL_H2D_DATA_PARITY[2]     			;
assign  				 	`ICXL_DEVICE_2.icxl_H2D_DATA_HALFLINEONLY_2					=	`TRANSACTORS_PATH.ICXL_H2D_DATA_HALFLINEONLY[2]     				;
//H2D response channel
assign  				 	`ICXL_DEVICE_2.icxl_H2D_RSP_PROTOCOL_2						=	`TRANSACTORS_PATH.ICXL_H2D_RSP_PROTOCOL[2]     				;
assign  				 	`ICXL_DEVICE_2.icxl_H2D_RSP_VALID_2							=	`TRANSACTORS_PATH.ICXL_H2D_RSP_VALID[2]     				;
assign  				 	`ICXL_DEVICE_2.icxl_H2D_RSP_OPCODE_2							=	`TRANSACTORS_PATH.ICXL_H2D_RSP_OPCODE[2]     			;
assign  				 	`ICXL_DEVICE_2.icxl_H2D_RSP_CQID_2							=	`TRANSACTORS_PATH.ICXL_H2D_RSP_CQID[2]     				;
assign  				 	`ICXL_DEVICE_2.icxl_H2D_RSP_RSPDATA_2							=	`TRANSACTORS_PATH.ICXL_H2D_RSP_RSPDATA[2]   		 	 	;
assign  				 	`ICXL_DEVICE_2.icxl_H2D_RSP_RSP_PRE_2							=	`TRANSACTORS_PATH.ICXL_H2D_RSP_RSP_PRE[2]     				;
 //FLOW CONTROL & GLOBAL channel
assign  				 	`ICXL_DEVICE_2.icxl_HOST_CONNECT_REQ_2						=	`TRANSACTORS_PATH.ICXL_HOST_CONNECT_REQ[2]     	;
assign  				 	`ICXL_DEVICE_2.icxl_DEVICE_CONNECT_ACK_2						=	`TRANSACTORS_PATH.ICXL_DEVICE_CONNECT_ACK[2]     	;
//assign  				 	`ICXL_DEVICE_2.icxl_D2H_CREDIT_RETURN_PROTOCOL_ID_2			=	`TRANSACTORS_PATH.ICXL_D2H_CREDIT_RETURN_PROTOCOL_ID[2]     	;
assign  				 	`ICXL_DEVICE_2.icxl_D2H_REQ_CREDIT_RETURN_PROTOCOL_ID_2			=	`TRANSACTORS_PATH.ICXL_D2H_REQ_CREDIT_RETURN_PROTOCOL_ID[2]     	;
assign  				 	`ICXL_DEVICE_2.icxl_D2H_DATA_CREDIT_RETURN_PROTOCOL_ID_2			=	`TRANSACTORS_PATH.ICXL_D2H_DATA_CREDIT_RETURN_PROTOCOL_ID[2]     	;
assign  				 	`ICXL_DEVICE_2.icxl_D2H_RSP_CREDIT_RETURN_PROTOCOL_ID_2			=	`TRANSACTORS_PATH.ICXL_D2H_RSP_CREDIT_RETURN_PROTOCOL_ID[2]     	;
assign  				 	`ICXL_DEVICE_2.icxl_D2H_REQ_CREDIT_RETURN_VALID_2				=	`TRANSACTORS_PATH.ICXL_D2H_REQ_CREDIT_RETURN_VALID[2]     	;
assign  				 	`ICXL_DEVICE_2.icxl_D2H_REQ_PROT_CHID_CREDIT_RETURN_2			=	`TRANSACTORS_PATH.ICXL_D2H_REQ_PROT_CHID_CREDIT_RETURN[2]     	;
assign  				 	`ICXL_DEVICE_2.icxl_D2H_REQ_PROT1_RTYPE_2						=	`TRANSACTORS_PATH.ICXL_D2H_REQ_PROT1_RTYPE[2]     	;
assign  				 	`ICXL_DEVICE_2.icxl_D2H_DATA_CREDIT_RETURN_VALID_2			=	`TRANSACTORS_PATH.ICXL_D2H_DATA_CREDIT_RETURN_VALID[2]     	;
assign  				 	`ICXL_DEVICE_2.icxl_D2H_DATA_PROT_CHID_CREDIT_RETURN_2		=	`TRANSACTORS_PATH.ICXL_D2H_DATA_PROT_CHID_CREDIT_RETURN[2]     	;
assign  				 	`ICXL_DEVICE_2.icxl_D2H_DATA_PROT1_RTYPE_2					=	`TRANSACTORS_PATH.ICXL_D2H_DATA_PROT1_RTYPE[2]     	;
assign  				 	`ICXL_DEVICE_2.icxl_D2H_RSP_CREDIT_RETURN_VALID_2				=	`TRANSACTORS_PATH.ICXL_D2H_RSP_CREDIT_RETURN_VALID[2]     	;

//=================================================================================================================================


	
