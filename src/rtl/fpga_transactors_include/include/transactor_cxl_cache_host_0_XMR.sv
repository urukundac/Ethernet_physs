//=================================================================================================================================
// CXL_CACHE_HOST connections - USER MUST EDIT THE RIGHT HAND SIDE OF THE FOLLOWING ASSIGNMENTS AND DEFINE - WHEN NEEDED
//=================================================================================================================================
// CXL_CACHE_HOST   connection #0


							`define 	CXL_CACHE_DEVICE_0 					`FPGA_TRANSACTORS_TOP   // example:  fpga_tcss_top.tcss_val_rtl.tcss.par_iom    //HERE USER SHOULD SET THE PATH TO HIS SIDE OF THE CXL.CACHE INTEFACE, THE DEVICE (=CORE) SIDE
						
assign 				  		`TRANSACTORS_PATH.cxl_cache_host_clk[0] 			= `CXL_CACHE_DEVICE_0.cxl_cache_device_clock;
assign 				  		`TRANSACTORS_PATH.cxl_cache_host_rstn[0] 			= `CXL_CACHE_DEVICE_0.cxl_cache_device_rst_n;

//inputs to FGT
assign                  	`TRANSACTORS_PATH.CXL_CACHE_C2U_DATA_BOGUS[0]     			= `CXL_CACHE_DEVICE_0.cxl_cache_C2U_DATA_BOGUS;
assign                  	`TRANSACTORS_PATH.CXL_CACHE_C2U_DATA_BYTE_ENABLE[0]     		= `CXL_CACHE_DEVICE_0.cxl_cache_C2U_DATA_BYTE_ENABLE;
assign                  	`TRANSACTORS_PATH.CXL_CACHE_C2U_DATA_BYTE_ENABLE_PARITY[0]    = `CXL_CACHE_DEVICE_0.cxl_cache_C2U_DATA_BYTE_ENABLE_PARITY;
assign                  	`TRANSACTORS_PATH.CXL_CACHE_C2U_DATA_CHUNKVALID[0]     		= `CXL_CACHE_DEVICE_0.cxl_cache_C2U_DATA_CHUNKVALID;
assign                  	`TRANSACTORS_PATH.CXL_CACHE_C2U_DATA_DATA[0]     				= `CXL_CACHE_DEVICE_0.cxl_cache_C2U_DATA_DATA;
assign                  	`TRANSACTORS_PATH.CXL_CACHE_C2U_DATA_ECC[0]     				= `CXL_CACHE_DEVICE_0.cxl_cache_C2U_DATA_ECC;
assign                  	`TRANSACTORS_PATH.CXL_CACHE_C2U_DATA_ECC_VALID[0]     		= `CXL_CACHE_DEVICE_0.cxl_cache_C2U_DATA_ECC_VALID;
assign                  	`TRANSACTORS_PATH.CXL_CACHE_C2U_DATA_FULL_LINE[0]     		= `CXL_CACHE_DEVICE_0.cxl_cache_C2U_DATA_FULL_LINE;
assign                  	`TRANSACTORS_PATH.CXL_CACHE_C2U_DATA_PARITY[0]     			= `CXL_CACHE_DEVICE_0.cxl_cache_C2U_DATA_PARITY;
assign                  	`TRANSACTORS_PATH.CXL_CACHE_C2U_DATA_POISON[0]     			= `CXL_CACHE_DEVICE_0.cxl_cache_C2U_DATA_POISON;
assign                  	`TRANSACTORS_PATH.CXL_CACHE_C2U_DATA_SPARE[0]     			= `CXL_CACHE_DEVICE_0.cxl_cache_C2U_DATA_SPARE;
assign                  	`TRANSACTORS_PATH.CXL_CACHE_C2U_DATA_UQID[0]     				= `CXL_CACHE_DEVICE_0.cxl_cache_C2U_DATA_UQID;
assign                  	`TRANSACTORS_PATH.CXL_CACHE_C2U_DATA_VALID[0]     			= `CXL_CACHE_DEVICE_0.cxl_cache_C2U_DATA_VALID;
assign                  	`TRANSACTORS_PATH.CXL_CACHE_C2U_REQ_ADDRESS[0]     			= `CXL_CACHE_DEVICE_0.cxl_cache_C2U_REQ_ADDRESS;
assign                  	`TRANSACTORS_PATH.CXL_CACHE_C2U_REQ_ADDRPARITY[0]     		= `CXL_CACHE_DEVICE_0.cxl_cache_C2U_REQ_ADDRPARITY;
assign                  	`TRANSACTORS_PATH.CXL_CACHE_C2U_REQ_CACHELOCALLY[0]     		= `CXL_CACHE_DEVICE_0.cxl_cache_C2U_REQ_CACHELOCALLY;
assign                  	`TRANSACTORS_PATH.CXL_CACHE_C2U_REQ_CACHEREMOTELY[0]     		= `CXL_CACHE_DEVICE_0.cxl_cache_C2U_REQ_CACHEREMOTELY;
assign                  	`TRANSACTORS_PATH.CXL_CACHE_C2U_REQ_CLOS[0]     				= `CXL_CACHE_DEVICE_0.cxl_cache_C2U_REQ_CLOS;
assign                  	`TRANSACTORS_PATH.CXL_CACHE_C2U_REQ_CQID[0]     				= `CXL_CACHE_DEVICE_0.cxl_cache_C2U_REQ_CQID;
assign                  	`TRANSACTORS_PATH.CXL_CACHE_C2U_REQ_NT[0]     				= `CXL_CACHE_DEVICE_0.cxl_cache_C2U_REQ_NT;
assign                  	`TRANSACTORS_PATH.CXL_CACHE_C2U_REQ_HASH[0]     				= `CXL_CACHE_DEVICE_0.cxl_cache_C2U_REQ_HASH;
assign                  	`TRANSACTORS_PATH.CXL_CACHE_C2U_REQ_LENGTH[0]     			= `CXL_CACHE_DEVICE_0.cxl_cache_C2U_REQ_LENGTH;
assign                  	`TRANSACTORS_PATH.CXL_CACHE_C2U_REQ_LPID[0]     				= `CXL_CACHE_DEVICE_0.cxl_cache_C2U_REQ_LPID;
assign                  	`TRANSACTORS_PATH.CXL_CACHE_C2U_REQ_NONTEMPORAL[0]     		= `CXL_CACHE_DEVICE_0.cxl_cache_C2U_REQ_NONTEMPORAL;
assign                  	`TRANSACTORS_PATH.CXL_CACHE_C2U_REQ_OPCODE[0]     			= `CXL_CACHE_DEVICE_0.cxl_cache_C2U_REQ_OPCODE;
assign                  	`TRANSACTORS_PATH.CXL_CACHE_C2U_REQ_OPGROUP[0]     			= `CXL_CACHE_DEVICE_0.cxl_cache_C2U_REQ_OPGROUP;
assign                  	`TRANSACTORS_PATH.CXL_CACHE_C2U_REQ_RMID[0]     				= `CXL_CACHE_DEVICE_0.cxl_cache_C2U_REQ_RMID;
assign                  	`TRANSACTORS_PATH.CXL_CACHE_C2U_REQ_SAI[0]     				= `CXL_CACHE_DEVICE_0.cxl_cache_C2U_REQ_SAI;
assign                  	`TRANSACTORS_PATH.CXL_CACHE_C2U_REQ_SLFSNP[0]     			= `CXL_CACHE_DEVICE_0.cxl_cache_C2U_REQ_SLFSNP;
assign                  	`TRANSACTORS_PATH.CXL_CACHE_C2U_REQ_SPARE[0]     				= `CXL_CACHE_DEVICE_0.cxl_cache_C2U_REQ_SPARE;
assign                  	`TRANSACTORS_PATH.CXL_CACHE_C2U_REQ_TOPOLOGY[0]     			= `CXL_CACHE_DEVICE_0.cxl_cache_C2U_REQ_TOPOLOGY;
assign                  	`TRANSACTORS_PATH.CXL_CACHE_C2U_REQ_VALID[0]     				= `CXL_CACHE_DEVICE_0.cxl_cache_C2U_REQ_VALID;
assign                  	`TRANSACTORS_PATH.CXL_CACHE_C2U_RSP_HLEABORT[0]     			= `CXL_CACHE_DEVICE_0.cxl_cache_C2U_RSP_HLEABORT;
assign                  	`TRANSACTORS_PATH.CXL_CACHE_C2U_RSP_MONEXIST[0]     			= `CXL_CACHE_DEVICE_0.cxl_cache_C2U_RSP_MONEXIST;
assign                  	`TRANSACTORS_PATH.CXL_CACHE_C2U_RSP_OPCODE[0]     			= `CXL_CACHE_DEVICE_0.cxl_cache_C2U_RSP_OPCODE;
assign                  	`TRANSACTORS_PATH.CXL_CACHE_C2U_RSP_SPARE[0]     				= `CXL_CACHE_DEVICE_0.cxl_cache_C2U_RSP_SPARE;
assign                  	`TRANSACTORS_PATH.CXL_CACHE_C2U_RSP_UQID[0]     				= `CXL_CACHE_DEVICE_0.cxl_cache_C2U_RSP_UQID;
assign                  	`TRANSACTORS_PATH.CXL_CACHE_C2U_RSP_VALID[0]     				= `CXL_CACHE_DEVICE_0.cxl_cache_C2U_RSP_VALID;
assign                  	`TRANSACTORS_PATH.CXL_CACHE_U2C_DATA_CREDIT_RETURN[0]     	= `CXL_CACHE_DEVICE_0.cxl_cache_U2C_DATA_CREDIT_RETURN;
assign                  	`TRANSACTORS_PATH.CXL_CACHE_U2C_REQ_CREDIT_RETURN[0]     		= `CXL_CACHE_DEVICE_0.cxl_cache_U2C_REQ_CREDIT_RETURN;
assign                  	`TRANSACTORS_PATH.CXL_CACHE_U2C_RSP_CREDIT_RETURN[0]     		= `CXL_CACHE_DEVICE_0.cxl_cache_U2C_RSP_CREDIT_RETURN;
assign                  	`TRANSACTORS_PATH.CXL_CACHE_C2U_REQ_ADDRESS_opt[0]     		= `CXL_CACHE_DEVICE_0.cxl_cache_C2U_REQ_ADDRESS_opt;
assign                  	`TRANSACTORS_PATH.CXL_CACHE_C2U_REQ_ADDRPARITY_opt[0]     	= `CXL_CACHE_DEVICE_0.cxl_cache_C2U_REQ_ADDRPARITY_opt;
assign                  	`TRANSACTORS_PATH.CXL_CACHE_C2U_REQ_CACHELOCALLY_opt[0]     	= `CXL_CACHE_DEVICE_0.cxl_cache_C2U_REQ_CACHELOCALLY_opt;
assign                  	`TRANSACTORS_PATH.CXL_CACHE_C2U_REQ_CACHEREMOTELY_opt[0]     	= `CXL_CACHE_DEVICE_0.cxl_cache_C2U_REQ_CACHEREMOTELY_opt;
assign                  	`TRANSACTORS_PATH.CXL_CACHE_C2U_REQ_CLOS_opt[0]     			= `CXL_CACHE_DEVICE_0.cxl_cache_C2U_REQ_CLOS_opt;
assign                  	`TRANSACTORS_PATH.CXL_CACHE_C2U_REQ_CQID_opt[0]     			= `CXL_CACHE_DEVICE_0.cxl_cache_C2U_REQ_CQID_opt;
assign                  	`TRANSACTORS_PATH.CXL_CACHE_C2U_REQ_NT_opt[0]     			= `CXL_CACHE_DEVICE_0.cxl_cache_C2U_REQ_NT_opt;
assign                  	`TRANSACTORS_PATH.CXL_CACHE_C2U_REQ_HASH_opt[0]     			= `CXL_CACHE_DEVICE_0.cxl_cache_C2U_REQ_HASH_opt;
assign                  	`TRANSACTORS_PATH.CXL_CACHE_C2U_REQ_LENGTH_opt[0]     		= `CXL_CACHE_DEVICE_0.cxl_cache_C2U_REQ_LENGTH_opt;
assign                  	`TRANSACTORS_PATH.CXL_CACHE_C2U_REQ_LPID_opt[0]     			= `CXL_CACHE_DEVICE_0.cxl_cache_C2U_REQ_LPID_opt;
assign                  	`TRANSACTORS_PATH.CXL_CACHE_C2U_REQ_NONTEMPORAL_opt[0]     	= `CXL_CACHE_DEVICE_0.cxl_cache_C2U_REQ_NONTEMPORAL_opt;
assign                  	`TRANSACTORS_PATH.CXL_CACHE_C2U_REQ_OPCODE_opt[0]     		= `CXL_CACHE_DEVICE_0.cxl_cache_C2U_REQ_OPCODE_opt;
assign                  	`TRANSACTORS_PATH.CXL_CACHE_C2U_REQ_OPGROUP_opt[0]     		= `CXL_CACHE_DEVICE_0.cxl_cache_C2U_REQ_OPGROUP_opt;
assign                  	`TRANSACTORS_PATH.CXL_CACHE_C2U_REQ_RMID_opt[0]     			= `CXL_CACHE_DEVICE_0.cxl_cache_C2U_REQ_RMID_opt;
assign                  	`TRANSACTORS_PATH.CXL_CACHE_C2U_REQ_SAI_opt[0]     			= `CXL_CACHE_DEVICE_0.cxl_cache_C2U_REQ_SAI_opt;
assign                  	`TRANSACTORS_PATH.CXL_CACHE_C2U_REQ_SLFSNP_opt[0]     		= `CXL_CACHE_DEVICE_0.cxl_cache_C2U_REQ_SLFSNP_opt;
assign                  	`TRANSACTORS_PATH.CXL_CACHE_C2U_REQ_SPARE_opt[0]     			= `CXL_CACHE_DEVICE_0.cxl_cache_C2U_REQ_SPARE_opt;
assign                  	`TRANSACTORS_PATH.CXL_CACHE_C2U_REQ_TOPOLOGY_opt[0]     		= `CXL_CACHE_DEVICE_0.cxl_cache_C2U_REQ_TOPOLOGY_opt;
assign                  	`TRANSACTORS_PATH.CXL_CACHE_C2U_REQ_VALID_opt[0]     			= `CXL_CACHE_DEVICE_0.cxl_cache_C2U_REQ_VALID_opt;
assign                  	`TRANSACTORS_PATH.CXL_CACHE_U2C_RSP_CREDIT_RETURN_opt[0]     	= `CXL_CACHE_DEVICE_0.cxl_cache_U2C_RSP_CREDIT_RETURN_opt;


//=================================================================================================================================
// CXL_CACHE_HOST connections - USER MUST EDIT THE LEFT HAND SIDE OF THE FOLLOWING ASSIGNMENTS 
//=================================================================================================================================


//outputs from FGT
assign  				 	`CXL_CACHE_DEVICE_0.cxl_cache_C2U_DATA_CREDIT_RETURN	=	`TRANSACTORS_PATH.CXL_CACHE_C2U_DATA_CREDIT_RETURN[0]     	;
assign  				 	`CXL_CACHE_DEVICE_0.cxl_cache_C2U_REQ_CREDIT_RETURN		=	`TRANSACTORS_PATH.CXL_CACHE_C2U_REQ_CREDIT_RETURN[0]     		;
assign  				 	`CXL_CACHE_DEVICE_0.cxl_cache_C2U_RSP_CREDIT_RETURN		=	`TRANSACTORS_PATH.CXL_CACHE_C2U_RSP_CREDIT_RETURN[0]     		;
assign  				 	`CXL_CACHE_DEVICE_0.cxl_cache_U2C_DATA_CHUNKVALID		=	`TRANSACTORS_PATH.CXL_CACHE_U2C_DATA_CHUNKVALID[0]     		;
assign  				 	`CXL_CACHE_DEVICE_0.cxl_cache_U2C_DATA_CQID				=	`TRANSACTORS_PATH.CXL_CACHE_U2C_DATA_CQID[0]     				;
assign  				 	`CXL_CACHE_DEVICE_0.cxl_cache_U2C_DATA_DATA				=	`TRANSACTORS_PATH.CXL_CACHE_U2C_DATA_DATA[0]     				;
assign  				 	`CXL_CACHE_DEVICE_0.cxl_cache_U2C_DATA_ECC				=	`TRANSACTORS_PATH.CXL_CACHE_U2C_DATA_ECC[0]     				;
assign  				 	`CXL_CACHE_DEVICE_0.cxl_cache_U2C_DATA_ECC_VALID		=	`TRANSACTORS_PATH.CXL_CACHE_U2C_DATA_ECC_VALID[0]     		;
assign  				 	`CXL_CACHE_DEVICE_0.cxl_cache_U2C_DATA_GO_ERR			=	`TRANSACTORS_PATH.CXL_CACHE_U2C_DATA_GO_ERR[0]     			;
assign						`CXL_CACHE_DEVICE_0.cxl_cache_U2C_DATA_PARITY			=	`TRANSACTORS_PATH.CXL_CACHE_U2C_DATA_PARITY[0]				;
assign  				 	`CXL_CACHE_DEVICE_0.cxl_cache_U2C_DATA_POISON			=	`TRANSACTORS_PATH.CXL_CACHE_U2C_DATA_POISON[0]     			;
assign  				 	`CXL_CACHE_DEVICE_0.cxl_cache_U2C_DATA_PRE				=	`TRANSACTORS_PATH.CXL_CACHE_U2C_DATA_PRE[0]     				;
assign  				 	`CXL_CACHE_DEVICE_0.cxl_cache_U2C_DATA_SPARE			=	`TRANSACTORS_PATH.CXL_CACHE_U2C_DATA_SPARE[0]     			;
assign  				 	`CXL_CACHE_DEVICE_0.cxl_cache_U2C_DATA_VALID			=	`TRANSACTORS_PATH.CXL_CACHE_U2C_DATA_VALID[0]     			;
assign  				 	`CXL_CACHE_DEVICE_0.cxl_cache_U2C_REQ_ADDRESS			=	`TRANSACTORS_PATH.CXL_CACHE_U2C_REQ_ADDRESS[0]    		 	;
assign  				 	`CXL_CACHE_DEVICE_0.cxl_cache_U2C_REQ_UQID				=	`TRANSACTORS_PATH.CXL_CACHE_U2C_REQ_UQID[0]     				;
assign  				 	`CXL_CACHE_DEVICE_0.cxl_cache_U2C_REQ_ADDRPARITY		=	`TRANSACTORS_PATH.CXL_CACHE_U2C_REQ_ADDRPARITY[0]     		;
assign  				 	`CXL_CACHE_DEVICE_0.cxl_cache_U2C_REQ_OPCODE			=	`TRANSACTORS_PATH.CXL_CACHE_U2C_REQ_OPCODE[0]     			;
assign  				 	`CXL_CACHE_DEVICE_0.cxl_cache_U2C_REQ_REQDATA			=	`TRANSACTORS_PATH.CXL_CACHE_U2C_REQ_REQDATA[0]     			;
assign  				 	`CXL_CACHE_DEVICE_0.cxl_cache_U2C_REQ_SPARE				=	`TRANSACTORS_PATH.CXL_CACHE_U2C_REQ_SPARE[0]     				;
assign  				 	`CXL_CACHE_DEVICE_0.cxl_cache_U2C_REQ_VALID				=	`TRANSACTORS_PATH.CXL_CACHE_U2C_REQ_VALID[0]     				;
assign  				 	`CXL_CACHE_DEVICE_0.cxl_cache_U2C_RSP_CQID				=	`TRANSACTORS_PATH.CXL_CACHE_U2C_RSP_CQID[0]     				;
assign  				 	`CXL_CACHE_DEVICE_0.cxl_cache_U2C_RSP_OPCODE			=	`TRANSACTORS_PATH.CXL_CACHE_U2C_RSP_OPCODE[0]     			;
assign  				 	`CXL_CACHE_DEVICE_0.cxl_cache_U2C_RSP_PRE				=	`TRANSACTORS_PATH.CXL_CACHE_U2C_RSP_PRE[0]     				;
assign  				 	`CXL_CACHE_DEVICE_0.cxl_cache_U2C_RSP_RSPDATA			=	`TRANSACTORS_PATH.CXL_CACHE_U2C_RSP_RSPDATA[0]   		 	 	;
assign  				 	`CXL_CACHE_DEVICE_0.cxl_cache_U2C_RSP_SPARE				=	`TRANSACTORS_PATH.CXL_CACHE_U2C_RSP_SPARE[0]     				;
assign  				 	`CXL_CACHE_DEVICE_0.cxl_cache_U2C_RSP_VALID				=	`TRANSACTORS_PATH.CXL_CACHE_U2C_RSP_VALID[0]     				;
assign  				 	`CXL_CACHE_DEVICE_0.cxl_cache_C2U_REQ_CREDIT_RETURN_opt	=	`TRANSACTORS_PATH.CXL_CACHE_C2U_REQ_CREDIT_RETURN_opt[0]     	;
assign  				 	`CXL_CACHE_DEVICE_0.cxl_cache_U2C_RSP_CQID_opt			=	`TRANSACTORS_PATH.CXL_CACHE_U2C_RSP_CQID_opt[0]     			;
assign  				 	`CXL_CACHE_DEVICE_0.cxl_cache_U2C_RSP_OPCODE_opt		=	`TRANSACTORS_PATH.CXL_CACHE_U2C_RSP_OPCODE_opt[0]     		;
assign  				 	`CXL_CACHE_DEVICE_0.cxl_cache_U2C_RSP_PRE_opt			=	`TRANSACTORS_PATH.CXL_CACHE_U2C_RSP_PRE_opt[0]     			;
assign  				 	`CXL_CACHE_DEVICE_0.cxl_cache_U2C_RSP_RSPDATA_opt		=	`TRANSACTORS_PATH.CXL_CACHE_U2C_RSP_RSPDATA_opt[0]     		;
assign  				 	`CXL_CACHE_DEVICE_0.cxl_cache_U2C_RSP_SPARE_opt			=	`TRANSACTORS_PATH.CXL_CACHE_U2C_RSP_SPARE_opt[0]     			;
assign  				 	`CXL_CACHE_DEVICE_0.cxl_cache_U2C_RSP_VALID_opt			=	`TRANSACTORS_PATH.CXL_CACHE_U2C_RSP_VALID_opt[0]     			;
//=================================================================================================================================


