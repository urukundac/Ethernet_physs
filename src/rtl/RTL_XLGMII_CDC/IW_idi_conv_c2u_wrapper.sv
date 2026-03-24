module IW_idi_conv_c2u_wrapper (
    idi_data_if_C2U_DATA_BYTE_ENABLE,
    idi_data_if_C2U_DATA_BYTE_ENABLE_PARITY,
    idi_data_if_C2U_DATA_DATA,
    idi_data_if_C2U_DATA_ECC,
    idi_data_if_C2U_DATA_ECC_VALID,
    idi_data_if_C2U_DATA_PARITY,
    idi_data_if_C2U_DATA_POISON,
    idi_data_if_U2C_DATA_DATA,
    idi_data_if_U2C_DATA_ECC,
    idi_data_if_U2C_DATA_ECC_VALID,
    idi_data_if_U2C_DATA_PARITY,
    idi_data_if_U2C_DATA_POISON,
    idi_pld_if_C2U_DATA_BOGUS,
    idi_pld_if_C2U_DATA_CHUNKVALID,
    idi_pld_if_C2U_DATA_SPARE,
    idi_pld_if_C2U_DATA_UQID,
    idi_pld_if_C2U_DATA_VALID,
    idi_pld_if_C2U_REQ_ADDRESS,
    idi_pld_if_C2U_REQ_ADDRPARITY,
    idi_pld_if_C2U_REQ_CACHELOCALLY,
    idi_pld_if_C2U_REQ_CACHEREMOTELY,
    idi_pld_if_C2U_REQ_CLOS,
    idi_pld_if_C2U_REQ_CQID,
    idi_pld_if_C2U_REQ_HASH,
    idi_pld_if_C2U_REQ_LENGTH,
    idi_pld_if_C2U_REQ_LPID,
    idi_pld_if_C2U_REQ_NONTEMPORAL,
    idi_pld_if_C2U_REQ_OPCODE,
    idi_pld_if_C2U_REQ_OPGROUP,
    idi_pld_if_C2U_REQ_SAI,
    idi_pld_if_C2U_REQ_SLFSNP,
    idi_pld_if_C2U_REQ_SPARE,
    idi_pld_if_C2U_REQ_TOPOLOGY,
    idi_pld_if_C2U_REQ_VALID,
    idi_pld_if_C2U_RSP_HLEABORT,
    idi_pld_if_C2U_RSP_MONEXIST,
    idi_pld_if_C2U_RSP_OPCODE,
    idi_pld_if_C2U_RSP_SPARE,
    idi_pld_if_C2U_RSP_UQID,
    idi_pld_if_C2U_RSP_VALID,
    idi_pld_if_U2C_DATA_CREDIT_RETURN,
    idi_pld_if_U2C_REQ_CREDIT_RETURN,
    idi_pld_if_U2C_RSP_CREDIT_RETURN,
    idi_pld_if_C2U_DATA_CREDIT_RETURN,
    idi_pld_if_C2U_REQ_CREDIT_RETURN,
    idi_pld_if_C2U_RSP_CREDIT_RETURN,
    idi_pld_if_U2C_DATA_CHUNKVALID,
    idi_pld_if_U2C_DATA_CQID,
    idi_pld_if_U2C_DATA_PRE,
    idi_pld_if_U2C_DATA_SPARE,
    idi_pld_if_U2C_DATA_VALID,
    idi_pld_if_U2C_REQ_ADDRESS,
    idi_pld_if_U2C_REQ_ADDRPARITY,
    idi_pld_if_U2C_REQ_OPCODE,
    idi_pld_if_U2C_REQ_REQDATA,
    idi_pld_if_U2C_REQ_SPARE,
    idi_pld_if_U2C_REQ_VALID,
    idi_pld_if_U2C_RSP_CQID,
    idi_pld_if_U2C_RSP_OPCODE,
    idi_pld_if_U2C_RSP_PRE,
    idi_pld_if_U2C_RSP_RSPDATA,
    idi_pld_if_U2C_RSP_SPARE,
    idi_pld_if_U2C_RSP_VALID,
    idi_ras_if_C2U_StickyFatalErr,
    idi_strap_if_C2U_STRAP_STRAP,
    idi_strap_if_C2U_STRAP_VERSION,
    idi_strap_if_U2C_STRAP_STRAP,
    idi_strap_if_U2C_STRAP_VERSION,
    idi_conv_in_mux,
    idi_conv_out_demux
);

parameter IDI_ADDRESS_WIDTH 		= 52;
parameter IDI_C2U_DATA_WIDTH 		= 256;
parameter IDI_U2C_DATA_WIDTH 		= 256;
parameter IDI_LPID_WIDTH 		= 3;
parameter IDI_CQID_WIDTH 		= 12;
parameter IDI_NONTEMPORAL_WIDTH 	= 2;
parameter IDI_CLOS_WIDTH 		= 5;
parameter IDI_UQID_WIDTH 		= 13;
parameter IDI_C2U_ECC_WIDTH 		= 10;
parameter IDI_U2C_ECC_WIDTH 		= 10;
parameter C2U_STRAP_VERSION_WIDTH 	= 5;
parameter C2U_STRAP_STRAP_WIDTH   	= 11;
parameter U2C_STRAP_VERSION_WIDTH 	= 5;
parameter U2C_STRAP_STRAP_WIDTH   	= 11;
parameter DEMUX_DATA_WIDTH 		= 424;
//parameter DEMUX_DATA_WIDTH 		= {
//IDI_U2C_DATA_WIDTH
//+ IDI_U2C_ECC_WIDTH	
//+ 1
//+ (IDI_U2C_DATA_WIDTH/64)
//+ 1
//+ 1
//+ 1
//+ 1
//+ 4
//+ IDI_CQID_WIDTH
//+ 7
//+ 1
//+ 1
//+ (IDI_ADDRESS_WIDTH-3)
//+ 1
//+ 5
//+ 16
//+ 2
//+ 1
//+ IDI_CQID_WIDTH
//+ 4
//+ 2
//+ 13
//+ 2
//+ 1
//+ U2C_STRAP_STRAP_WIDTH
//+ U2C_STRAP_VERSION_WIDTH
//};

parameter MUX_DATA_WIDTH 		= 490; 
//parameter MUX_DATA_WIDTH 		= { 
//(IDI_C2U_DATA_WIDTH/8)
//+ 1 
//+ IDI_C2U_DATA_WIDTH
//+ IDI_C2U_ECC_WIDTH
//+ 1
//+ (IDI_C2U_DATA_WIDTH/64)	
//+ 1
//+ 1
//+ 4
//+ 2
//+ IDI_UQID_WIDTH
//+ 1
//+ IDI_ADDRESS_WIDTH
//+ 1
//+ 1
//+ 1
//+ IDI_CLOS_WIDTH
//+ IDI_CQID_WIDTH
//+ 6
//+ 6
//+ IDI_LPID_WIDTH
//+ IDI_NONTEMPORAL_WIDTH
//+ 6
//+ 2
//+ 8
//+ 1
//+ 10
//+ 4
//+ 1
//+ 1
//+ 1
//+ 5
//+ 2
//+ IDI_UQID_WIDTH
//+ 1
//+ 1
//+ 1
//+ 1
//+ 1
//+ C2U_STRAP_STRAP_WIDTH
//+ C2U_STRAP_VERSION_WIDTH
//}; 

   // Ports for Interface idi_data_if
   output   [(IDI_C2U_DATA_WIDTH/8)-1:0]  	idi_data_if_C2U_DATA_BYTE_ENABLE;
   output           				idi_data_if_C2U_DATA_BYTE_ENABLE_PARITY;
   output   [IDI_C2U_DATA_WIDTH-1:0] 		idi_data_if_C2U_DATA_DATA;
   output   [IDI_C2U_ECC_WIDTH-1:0]   		idi_data_if_C2U_DATA_ECC;
   output           				idi_data_if_C2U_DATA_ECC_VALID;
   output   [(IDI_C2U_DATA_WIDTH/64)-1:0]   	idi_data_if_C2U_DATA_PARITY;
   output           				idi_data_if_C2U_DATA_POISON;
   input  [IDI_U2C_DATA_WIDTH-1:0] 		idi_data_if_U2C_DATA_DATA;
   input  [IDI_U2C_ECC_WIDTH-1:0]   		idi_data_if_U2C_DATA_ECC;
   input          				idi_data_if_U2C_DATA_ECC_VALID;
   input  [(IDI_U2C_DATA_WIDTH/64)-1:0]   	idi_data_if_U2C_DATA_PARITY;
   input          				idi_data_if_U2C_DATA_POISON;
   // Ports for Interface idi_pld_if
   output           				idi_pld_if_C2U_DATA_BOGUS;
   output   [3:0]   				idi_pld_if_C2U_DATA_CHUNKVALID;
   output   [1:0]   				idi_pld_if_C2U_DATA_SPARE;
   output   [IDI_UQID_WIDTH-1:0]  		idi_pld_if_C2U_DATA_UQID;
   output           				idi_pld_if_C2U_DATA_VALID;
   output   [IDI_ADDRESS_WIDTH-1:0]  		idi_pld_if_C2U_REQ_ADDRESS;
   output           				idi_pld_if_C2U_REQ_ADDRPARITY;
   output           				idi_pld_if_C2U_REQ_CACHELOCALLY;
   output           				idi_pld_if_C2U_REQ_CACHEREMOTELY;
   output   [IDI_CLOS_WIDTH-1:0]  		idi_pld_if_C2U_REQ_CLOS;
   output   [IDI_CQID_WIDTH-1:0]  		idi_pld_if_C2U_REQ_CQID;
   output   [5:0]   				idi_pld_if_C2U_REQ_HASH;
   output   [5:0]   				idi_pld_if_C2U_REQ_LENGTH;
   output   [IDI_LPID_WIDTH-1:0]   		idi_pld_if_C2U_REQ_LPID;
   output   [IDI_NONTEMPORAL_WIDTH-1:0]   	idi_pld_if_C2U_REQ_NONTEMPORAL;
   output   [5:0]   				idi_pld_if_C2U_REQ_OPCODE;
   output   [1:0]   				idi_pld_if_C2U_REQ_OPGROUP;
   output   [7:0]   				idi_pld_if_C2U_REQ_SAI;
   output           				idi_pld_if_C2U_REQ_SLFSNP;
   output   [9:0]   				idi_pld_if_C2U_REQ_SPARE;
   output   [3:0]   				idi_pld_if_C2U_REQ_TOPOLOGY;
   output           				idi_pld_if_C2U_REQ_VALID;
   output           				idi_pld_if_C2U_RSP_HLEABORT;
   output           				idi_pld_if_C2U_RSP_MONEXIST;
   output   [4:0]   				idi_pld_if_C2U_RSP_OPCODE;
   output   [1:0]   				idi_pld_if_C2U_RSP_SPARE;
   output   [IDI_UQID_WIDTH-1:0]  		idi_pld_if_C2U_RSP_UQID;
   output           				idi_pld_if_C2U_RSP_VALID;
   output           				idi_pld_if_U2C_DATA_CREDIT_RETURN;
   output           				idi_pld_if_U2C_REQ_CREDIT_RETURN;
   output           				idi_pld_if_U2C_RSP_CREDIT_RETURN;
   input          				idi_pld_if_C2U_DATA_CREDIT_RETURN;
   input          				idi_pld_if_C2U_REQ_CREDIT_RETURN;
   input          				idi_pld_if_C2U_RSP_CREDIT_RETURN;
   input  [3:0]   				idi_pld_if_U2C_DATA_CHUNKVALID;
   input  [IDI_CQID_WIDTH-1:0]  		idi_pld_if_U2C_DATA_CQID;
   input  [6:0]   				idi_pld_if_U2C_DATA_PRE;
   input          				idi_pld_if_U2C_DATA_SPARE;
   input          				idi_pld_if_U2C_DATA_VALID;
   input  [(IDI_ADDRESS_WIDTH-3)-1:0]  		idi_pld_if_U2C_REQ_ADDRESS;
   input          				idi_pld_if_U2C_REQ_ADDRPARITY;
   input  [4:0]   				idi_pld_if_U2C_REQ_OPCODE;
   input  [15:0]  				idi_pld_if_U2C_REQ_REQDATA;
   input  [1:0]   				idi_pld_if_U2C_REQ_SPARE;
   input          				idi_pld_if_U2C_REQ_VALID;
   input  [IDI_CQID_WIDTH-1:0]  		idi_pld_if_U2C_RSP_CQID;
   input  [3:0]   				idi_pld_if_U2C_RSP_OPCODE;
   input  [1:0]   				idi_pld_if_U2C_RSP_PRE;
   input  [12:0]  				idi_pld_if_U2C_RSP_RSPDATA;
   input  [1:0]   				idi_pld_if_U2C_RSP_SPARE;
   input          				idi_pld_if_U2C_RSP_VALID;
   // Ports for Interface idi_ras_if
   output           				idi_ras_if_C2U_StickyFatalErr;
   // Ports for Interface idi_strap_if
   output [C2U_STRAP_STRAP_WIDTH-1:0]  		idi_strap_if_C2U_STRAP_STRAP;
   output [C2U_STRAP_VERSION_WIDTH-1:0]   	idi_strap_if_C2U_STRAP_VERSION;
   input  [U2C_STRAP_STRAP_WIDTH-1:0]  	 	idi_strap_if_U2C_STRAP_STRAP;
   input  [U2C_STRAP_VERSION_WIDTH-1:0]   	idi_strap_if_U2C_STRAP_VERSION;

   /****************************************************************************************
   * Bundelled signals for mux/demux
   ****************************************************************************************/
    output  [MUX_DATA_WIDTH-1:0]        	idi_conv_in_mux;
    input   [DEMUX_DATA_WIDTH-1:0]        	idi_conv_out_demux;
   
   /****************************************************************************************/
    logic  [MUX_DATA_WIDTH-1:0]        		idi_conv_in_mux;
    logic  [DEMUX_DATA_WIDTH-1:0]       	idi_conv_out_demux;

assign idi_conv_in_mux = {
idi_data_if_U2C_DATA_DATA,		//IDI_U2C_DATA_WIDTH
idi_data_if_U2C_DATA_ECC,		//IDI_U2C_ECC_WIDTH	
idi_data_if_U2C_DATA_ECC_VALID,
idi_data_if_U2C_DATA_PARITY,		//(IDI_U2C_DATA_WIDTH/64)
idi_data_if_U2C_DATA_POISON,
idi_pld_if_C2U_DATA_CREDIT_RETURN,
idi_pld_if_C2U_REQ_CREDIT_RETURN,
idi_pld_if_C2U_RSP_CREDIT_RETURN,
idi_pld_if_U2C_DATA_CHUNKVALID,		//4
idi_pld_if_U2C_DATA_CQID,		//IDI_CQID_WIDTH
idi_pld_if_U2C_DATA_PRE,		//7
idi_pld_if_U2C_DATA_SPARE,
idi_pld_if_U2C_DATA_VALID,
idi_pld_if_U2C_REQ_ADDRESS,		//(IDI_ADDRESS_WIDTH-3)
idi_pld_if_U2C_REQ_ADDRPARITY,
idi_pld_if_U2C_REQ_OPCODE,		//5
idi_pld_if_U2C_REQ_REQDATA,		//16
idi_pld_if_U2C_REQ_SPARE,		//2
idi_pld_if_U2C_REQ_VALID,
idi_pld_if_U2C_RSP_CQID,		//IDI_CQID_WIDTH
idi_pld_if_U2C_RSP_OPCODE,		//4
idi_pld_if_U2C_RSP_PRE,			//2
idi_pld_if_U2C_RSP_RSPDATA,		//13
idi_pld_if_U2C_RSP_SPARE,		//2
idi_pld_if_U2C_RSP_VALID,	
idi_strap_if_U2C_STRAP_STRAP,		//11
idi_strap_if_U2C_STRAP_VERSION		//5
};
 
assign {
idi_data_if_C2U_DATA_BYTE_ENABLE,	//(IDI_C2U_DATA_WIDTH/8)
idi_data_if_C2U_DATA_BYTE_ENABLE_PARITY,
idi_data_if_C2U_DATA_DATA,		//IDI_C2U_DATA_WIDTH
idi_data_if_C2U_DATA_ECC,		//IDI_C2U_ECC_WIDTH
idi_data_if_C2U_DATA_ECC_VALID,
idi_data_if_C2U_DATA_PARITY,		//(IDI_C2U_DATA_WIDTH/64)	
idi_data_if_C2U_DATA_POISON,
idi_pld_if_C2U_DATA_BOGUS,
idi_pld_if_C2U_DATA_CHUNKVALID,		//4
idi_pld_if_C2U_DATA_SPARE,		//2
idi_pld_if_C2U_DATA_UQID,		//IDI_UQID_WIDTH
idi_pld_if_C2U_DATA_VALID,
idi_pld_if_C2U_REQ_ADDRESS,		//IDI_ADDRESS_WIDTH
idi_pld_if_C2U_REQ_ADDRPARITY,
idi_pld_if_C2U_REQ_CACHELOCALLY,
idi_pld_if_C2U_REQ_CACHEREMOTELY,
idi_pld_if_C2U_REQ_CLOS,		//IDI_CLOS_WIDTH
idi_pld_if_C2U_REQ_CQID,		//IDI_CQID_WIDTH
idi_pld_if_C2U_REQ_HASH,		//6
idi_pld_if_C2U_REQ_LENGTH,		//6
idi_pld_if_C2U_REQ_LPID,		//IDI_LPID_WIDTH
idi_pld_if_C2U_REQ_NONTEMPORAL,		//IDI_NONTEMPORAL_WIDTH
idi_pld_if_C2U_REQ_OPCODE,		//6
idi_pld_if_C2U_REQ_OPGROUP,		//2
idi_pld_if_C2U_REQ_SAI,			//8
idi_pld_if_C2U_REQ_SLFSNP,
idi_pld_if_C2U_REQ_SPARE,		//10
idi_pld_if_C2U_REQ_TOPOLOGY,		//4
idi_pld_if_C2U_REQ_VALID,
idi_pld_if_C2U_RSP_HLEABORT,
idi_pld_if_C2U_RSP_MONEXIST,
idi_pld_if_C2U_RSP_OPCODE,		//5
idi_pld_if_C2U_RSP_SPARE,		//2
idi_pld_if_C2U_RSP_UQID,		//IDI_UQID_WIDTH
idi_pld_if_C2U_RSP_VALID,
idi_pld_if_U2C_DATA_CREDIT_RETURN,
idi_pld_if_U2C_REQ_CREDIT_RETURN,
idi_pld_if_U2C_RSP_CREDIT_RETURN,
idi_ras_if_C2U_StickyFatalErr,
idi_strap_if_C2U_STRAP_STRAP,		//11
idi_strap_if_C2U_STRAP_VERSION		//5
} = idi_conv_out_demux;
 
endmodule
