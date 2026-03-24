/*
 * idi_v2_tracker.sv
 *
 * Original Author: Joshua Louie
 *
 * Ports are marked as follows:
 * IA signal - Only needed in IA core and/or IA atom
 * GT signal - Only needed in GT form only
 * SoC signal - Only needed in SoC model (e.g. BXT)
 * Server signal - Only needed in server models (e.g. SKX)
 *
 * Tie unneeded signals to 0.
 */
`define CLK_TICK posedge clk

`include "idi_v2_type.vh"

/* An idi tracker
 */
module idi_v2_tracker (
    C2U_Req_Valid,
    C2U_Req_OpGroup,
    C2U_Req_Opcode,
    C2U_Req_Address,
    C2U_Req_AddrParity,
    C2U_Req_SelfSnp,
    C2U_Req_CQid,
    C2U_Req_Length,
    C2U_Req_LPid,
    C2U_Req_CLoS,
    C2U_Req_SAI,
    C2U_Req_NonTemporal,
    C2U_Req_CacheNear,
    C2U_Req_CacheFar,
    C2U_Req_Hash,
    C2U_Req_Topology,
    C2U_Req_Spare,
    C2U_Rsp_Valid,
    C2U_Rsp_Opcode,
    C2U_Rsp_UQid,
    C2U_Rsp_MonitorExist,
    C2U_Rsp_HLEAbort,
    C2U_Rsp_Spare,
    C2U_Data_Valid,
    C2U_Data_UQid,
    C2U_Data_ChunkValid,
    C2U_Data_Data,
    C2U_Data_ByteEnable,
    C2U_Data_Bogus,
    C2U_Data_Poison,
    C2U_Data_DataParity,
    C2U_Data_BEParity,
    C2U_Data_ECC,
    C2U_Data_ECCValid,
    C2U_Data_Spare,
    U2C_Req_Valid,
    U2C_Req_Opcode,
    U2C_Req_Address,
    U2C_Req_AddrParity,
    U2C_Req_ReqData,
    U2C_Req_Spare,
    U2C_Rsp_Valid,
    U2C_Rsp_Opcode,
    U2C_Rsp_RspData,
    U2C_Rsp_PRE,
    U2C_Rsp_CQid,
    U2C_Rsp_Spare,
    U2C_Data_Valid,
    U2C_Data_CQid,
    U2C_Data_ChunkValid,
    U2C_Data_Data,
    U2C_Data_Poison,
    U2C_Data_Err,
    U2C_Data_PRE,
    U2C_Data_DataParity,
    U2C_Data_ECC,
    U2C_Data_ECCValid,
    U2C_Data_Spare,
    clk,
    enable,
    id,
    C2U_Req,
    C2U_Rsp, 
    C2U_Data,
    
    U2C_Req,
    U2C_Rsp, 
    U2C_Data,

    valid
);
// pragma attribute idi_v2_tracker partition_module_xrtl

    parameter  C2U_ADDR_WIDTH=52;
    parameter  C2U_DATA_WIDTH=256;
    parameter  U2C_ADDR_WIDTH=49;
    parameter  U2C_DATA_WIDTH=256;
    parameter  IS_GT=1'b0;
    localparam C2U_DATA_PACKETS=(512 / C2U_DATA_WIDTH);
    localparam C2U_BE_WIDTH=(C2U_DATA_WIDTH / 8);
    localparam C2U_DATA_PARITY_WIDTH=(C2U_DATA_WIDTH / 64);
    localparam C2U_ECC_WIDTH=((512 / C2U_DATA_WIDTH) * 5);
    localparam U2C_DATA_PARITY_WIDTH=(U2C_DATA_WIDTH / 64);
    localparam U2C_ECC_WIDTH=((512 / U2C_DATA_WIDTH) * 5);

    /*** C2U Request fields ***/
    input wire C2U_Req_Valid;
    input wire [1:0] C2U_Req_OpGroup;
    input wire [5:0] C2U_Req_Opcode;
    input wire [(C2U_ADDR_WIDTH - 1):0] C2U_Req_Address;
    input wire C2U_Req_AddrParity;         /* Optional field */
    input wire C2U_Req_SelfSnp;
    input wire [11:0] C2U_Req_CQid;
    input wire [5:0] C2U_Req_Length;
    input wire [2:0] C2U_Req_LPid;
    input wire [4:0] C2U_Req_CLoS;
    input wire [7:0] C2U_Req_SAI;
    input wire [1:0] C2U_Req_NonTemporal;
    input wire C2U_Req_CacheNear;
    input wire C2U_Req_CacheFar;
    input wire [5:0] C2U_Req_Hash;         /* Optional field */
    input wire [3:0] C2U_Req_Topology;     /* Optional field */
    input wire [9:0] C2U_Req_Spare;

    /*** C2U Response fields ***/
    input wire C2U_Rsp_Valid;
    input wire [4:0] C2U_Rsp_Opcode;
    input wire [12:0] C2U_Rsp_UQid;
    input wire C2U_Rsp_MonitorExist;
    input wire C2U_Rsp_HLEAbort;
    input wire [1:0] C2U_Rsp_Spare;

    /*** C2U Data fields ***/
    input wire C2U_Data_Valid;
    input wire [12:0] C2U_Data_UQid;
    input wire [3:0] C2U_Data_ChunkValid;
    input wire [(C2U_DATA_WIDTH - 1):0] C2U_Data_Data;
    input wire [(C2U_BE_WIDTH - 1):0] C2U_Data_ByteEnable;
    input wire C2U_Data_Bogus;
    input wire C2U_Data_Poison;
    input wire [(C2U_DATA_PARITY_WIDTH - 1):0] C2U_Data_DataParity;  /* Optional field */
    input wire C2U_Data_BEParity;          /* Optional field */
    input wire [(C2U_ECC_WIDTH - 1):0] C2U_Data_ECC;         /* Optional field */
    input wire C2U_Data_ECCValid;          /* Optional field */
    input wire [1:0] C2U_Data_Spare;

    /*** U2C Request fields ***/
    input wire U2C_Req_Valid;
    input wire [4:0] U2C_Req_Opcode;
    input wire [(U2C_ADDR_WIDTH - 1):0] U2C_Req_Address;
    input wire U2C_Req_AddrParity;              /* Optional field */
    input wire [15:0] U2C_Req_ReqData;
    input wire [1:0] U2C_Req_Spare;

    /*** U2C Response fields ***/
    input wire U2C_Rsp_Valid;
    input wire [3:0] U2C_Rsp_Opcode;
    input wire [12:0] U2C_Rsp_RspData;
    input wire [1:0] U2C_Rsp_PRE;
    input wire [11:0] U2C_Rsp_CQid;
    input wire [9:0] U2C_Rsp_Spare;

    /*** U2C Data fields ***/
    input wire U2C_Data_Valid;
    input wire [11:0] U2C_Data_CQid;
    input wire [3:0] U2C_Data_ChunkValid;
    input wire [(U2C_DATA_WIDTH - 1):0] U2C_Data_Data;
    input wire U2C_Data_Poison;
    input wire U2C_Data_Err;
    input wire [6:0] U2C_Data_PRE;
    input wire [(U2C_DATA_PARITY_WIDTH - 1):0] U2C_Data_DataParity;       /* Optional field */
    input wire [(U2C_ECC_WIDTH - 1):0] U2C_Data_ECC;              /* Optional field */
    input wire U2C_Data_ECCValid;    /* Optional field */
    input wire U2C_Data_Spare;

    /*** Clock; enable; and id ***/
    input wire clk;
    input wire enable;
    input wire [31:0] id;
    output  C2URequest_t    C2U_Req;
    output  C2UResponse_t   C2U_Rsp; 
    output  C2UData_t       C2U_Data;
    
    output  U2CRequest_t    U2C_Req;
    output  U2CResponse_t   U2C_Rsp; 
    output  U2CData_t       U2C_Data;

    output                  valid;


    /************************************************************************
     * Local Variable Declarations
     ************************************************************************/
    reg [63:0] clk_count;
    bit any_valid;

    /* U2C_Data Staggered fields arrays - Received 3 IDI cycles early */
    reg Stagger_U2C_Data_Valid [2:0];
    reg [11:0] Stagger_U2C_Data_CQid [2:0];
    reg [3:0] Stagger_U2C_Data_ChunkValid [2:0];
    reg [6:0] Stagger_U2C_Data_PRE [2:0];

//////    /************************************************************************
//////     * Tracker function declaration
//////     ************************************************************************/
//////    // pragma tbx one_way_caller_opt it_TrackPacket on
//////`ifndef IDI_UHFI_GMT
//////    import "DPI-C" context function void it_TrackPacket(
//////	input u64 cycle,
//////
//////	input bit isCore,
//////	input bit isGT,
//////	input bit [15:0] widthC2UData,
//////	input bit [15:0] widthU2CData,
//////	input bit [15:0] widthC2UAddr,
//////	input bit [15:0] widthU2CAddr,
//////	input bit [15:0] widthC2UBE,
//////	input bit [15:0] widthC2UDataParity,
//////	input bit [15:0] widthU2CDataParity,
//////	input bit [15:0] widthC2UECC,
//////	input bit [15:0] widthU2CECC,
//////	input bit isStandalone,
//////	input u32 id,
//////
//////	/*** C2U Request fields ***/
//////	input bit C2U_Req_Valid,
//////	input bit [1:0] C2U_Req_OpGroup,
//////	input bit [5:0] C2U_Req_Opcode,
//////	input bit [(C2U_ADDR_WIDTH - 1):0] C2U_Req_Address,
//////	input bit C2U_Req_AddrParity,         /* Optional field */
//////	input bit C2U_Req_SelfSnp,
//////	input bit [11:0] C2U_Req_CQid,
//////	input bit [5:0] C2U_Req_Length,
//////	input bit [2:0] C2U_Req_LPid,
//////	input bit [4:0] C2U_Req_CLoS,
//////	input bit [7:0] C2U_Req_SAI,
//////	input bit [1:0] C2U_Req_NonTemporal,
//////	input bit C2U_Req_CacheNear,
//////	input bit C2U_Req_CacheFar,
//////	input bit [5:0] C2U_Req_Hash,         /* Optional field */
//////	input bit [5:0] C2U_Req_Topology,     /* Optional field */
//////	input bit [9:0] C2U_Req_Spare,
//////
//////	/*** C2U Response fields ***/
//////	input bit C2U_Rsp_Valid,
//////	input bit [4:0] C2U_Rsp_Opcode,
//////	input bit [12:0] C2U_Rsp_UQid,
//////	input bit C2U_Rsp_MonitorExist,
//////	input bit C2U_Rsp_HLEAbort,
//////	input bit [1:0] C2U_Rsp_Spare,
//////
//////	/*** C2U Data fields ***/
//////	input bit C2U_Data_Valid,
//////	input bit [12:0] C2U_Data_UQid,
//////	input bit [3:0] C2U_Data_ChunkValid,
//////	input bit [(C2U_DATA_WIDTH - 1):0] C2U_Data_Data,
//////	input bit [(C2U_BE_WIDTH - 1):0] C2U_Data_ByteEnable,
//////	input bit C2U_Data_Bogus,
//////	input bit C2U_Data_Poison,
//////	input bit [(C2U_DATA_PARITY_WIDTH - 1):0] C2U_Data_DataParity,  /* Optional field */
//////	input bit C2U_Data_BEParity,          /* Optional field */
//////	input bit [(C2U_ECC_WIDTH - 1):0] C2U_Data_ECC,         /* Optional field */
//////	input bit [1:0] C2U_Data_Spare,
//////
//////	/*** U2C Request fields ***/
//////	input bit U2C_Req_Valid,
//////	input bit [4:0] U2C_Req_Opcode,
//////	input bit [(U2C_ADDR_WIDTH - 1):0] U2C_Req_Address,
//////	input bit U2C_Req_AddrParity,              /* Optional field */
//////	input bit [15:0] U2C_Req_ReqData,
//////	input bit [1:0] U2C_Req_Spare,
//////
//////	/*** U2C Response fields ***/
//////	input bit U2C_Rsp_Valid,
//////	input bit [3:0] U2C_Rsp_Opcode,
//////	input bit [12:0] U2C_Rsp_RspData,
//////	input bit [1:0] U2C_Rsp_PRE,
//////	input bit [11:0] U2C_Rsp_CQid,
//////	input bit [9:0] U2C_Rsp_Spare,
//////
//////	/*** U2C Data fields ***/
//////	input bit U2C_Data_Valid,
//////	input bit [11:0] U2C_Data_CQid,
//////	input bit [3:0] U2C_Data_ChunkValid,
//////	input bit [(U2C_DATA_WIDTH - 1):0] U2C_Data_Data,
//////	input bit U2C_Data_Poison,
//////	input bit U2C_Data_Err,
//////	input bit [6:0] U2C_Data_PRE,
//////	input bit [(U2C_DATA_PARITY_WIDTH - 1):0] U2C_Data_DataParity,       /* Optional field */
//////	input bit [(U2C_ECC_WIDTH - 1):0] U2C_Data_ECC,              /* Optional field */
//////	input bit U2C_Data_Spare
//////    );
//////`endif
//////
    /************************************************************************
     * Initialization
     ************************************************************************/
    reg [63:0] advance_size;
    initial begin
	clk_count <=    0;
    end

    /************************************************************************
     * Advance time standalone
     ************************************************************************/
    always @(`CLK_TICK) begin
	clk_count <= clk_count + 1;
    end

    always_comb begin
	any_valid <= ((C2U_Req_Valid | C2U_Rsp_Valid | C2U_Data_Valid)
	    | (U2C_Req_Valid | U2C_Rsp_Valid | Stagger_U2C_Data_Valid[0]));
    end

    /********************************************************************
     * Delay non-staggered values from input pins
     ********************************************************************/
    always @(`CLK_TICK) begin
	Stagger_U2C_Data_Valid[0] <=      Stagger_U2C_Data_Valid[1];
	Stagger_U2C_Data_CQid[0] <=       Stagger_U2C_Data_CQid[1];
	Stagger_U2C_Data_ChunkValid[0] <= Stagger_U2C_Data_ChunkValid[1];
	Stagger_U2C_Data_PRE[0] <=        Stagger_U2C_Data_PRE[1];

	Stagger_U2C_Data_Valid[1] <=      Stagger_U2C_Data_Valid[2];
	Stagger_U2C_Data_CQid[1] <=       Stagger_U2C_Data_CQid[2];
	Stagger_U2C_Data_ChunkValid[1] <= Stagger_U2C_Data_ChunkValid[2];
	Stagger_U2C_Data_PRE[1] <=        Stagger_U2C_Data_PRE[2];

	Stagger_U2C_Data_Valid[2] <=      U2C_Data_Valid;
	Stagger_U2C_Data_CQid[2] <=       U2C_Data_CQid;
	Stagger_U2C_Data_ChunkValid[2] <= U2C_Data_ChunkValid;
	Stagger_U2C_Data_PRE[2] <=        U2C_Data_PRE;
    end

    /************************************************************************
     * Push signals to tracker from HW
     ************************************************************************/
    always @(`CLK_TICK) begin
	if (enable && any_valid) begin
//////	    it_TrackPacket(
//////		clk_count,
//////
//////		1'b1,
//////		IS_GT,
//////		C2U_DATA_WIDTH,
//////		U2C_DATA_WIDTH,
//////		C2U_ADDR_WIDTH,
//////		U2C_ADDR_WIDTH,
//////		C2U_BE_WIDTH,
//////		C2U_DATA_PARITY_WIDTH,
//////		U2C_DATA_PARITY_WIDTH,
//////		C2U_ECC_WIDTH,
//////		U2C_ECC_WIDTH,
//////		1'b1,
//////		id,
//////
	  C2U_Req.Valid          <=	C2U_Req_Valid;
	  C2U_Req.OpGroup        <=	C2U_Req_OpGroup;
	  C2U_Req.Opcode         <=	C2U_Req_Opcode;
	  C2U_Req.Address        <=	C2U_Req_Address;
	  C2U_Req.AddrParity     <=	C2U_Req_AddrParity;
	  C2U_Req.SelfSnp        <=	C2U_Req_SelfSnp;
	  C2U_Req.CQid           <=	C2U_Req_CQid;
	  C2U_Req.Length         <=	C2U_Req_Length;
	  C2U_Req.LPid           <=	C2U_Req_LPid;
	  C2U_Req.CLoS           <=	C2U_Req_CLoS;
	  C2U_Req.SAI            <=	C2U_Req_SAI;
	  C2U_Req.NonTemporal    <=	C2U_Req_NonTemporal;
	  C2U_Req.CacheNear      <=	C2U_Req_CacheNear;
	  C2U_Req.CacheFar       <=	C2U_Req_CacheFar;
	  C2U_Req.Hash           <=	C2U_Req_Hash;
	  C2U_Req.Topology       <=	C2U_Req_Topology;
	  C2U_Req.Spare          <=	C2U_Req_Spare;
                                      
	  C2U_Rsp.Valid          <=	C2U_Rsp_Valid;
	  C2U_Rsp.Opcode         <=	C2U_Rsp_Opcode;
	  C2U_Rsp.UQid           <=	C2U_Rsp_UQid;
	  C2U_Rsp.MonitorExist   <=	C2U_Rsp_MonitorExist;
	  C2U_Rsp.HLEAbort       <=	C2U_Rsp_HLEAbort;
	  C2U_Rsp.Spare          <=	C2U_Rsp_Spare;
                                       
	  C2U_Data.Valid         <=	C2U_Data_Valid;
	  C2U_Data.UQid          <=	C2U_Data_UQid;
	  C2U_Data.ChunkValid    <=	C2U_Data_ChunkValid;
	  C2U_Data.Data          <=	C2U_Data_Data;
	  C2U_Data.ByteEnable    <=	C2U_Data_ByteEnable;
	  C2U_Data.Bogus         <=	C2U_Data_Bogus;
	  C2U_Data.Poison        <=	C2U_Data_Poison;
	  C2U_Data.DataParity    <=	C2U_Data_DataParity;
	  C2U_Data.BEParity      <=	C2U_Data_BEParity;
	  C2U_Data.ECC           <=	C2U_Data_ECC;
	  C2U_Data.Spare         <=	C2U_Data_Spare;
                                                        
	  U2C_Req.Valid          <=	U2C_Req_Valid;
	  U2C_Req.Opcode         <=	U2C_Req_Opcode;
	  U2C_Req.Address        <=	U2C_Req_Address;
	  U2C_Req.AddrParity     <=	U2C_Req_AddrParity;
	  U2C_Req.ReqData        <=	U2C_Req_ReqData;
	  U2C_Req.Spare          <=	U2C_Req_Spare;
                                        
	  U2C_Rsp.Valid          <=	U2C_Rsp_Valid;
	  U2C_Rsp.Opcode         <=	U2C_Rsp_Opcode;
	  U2C_Rsp.RspData        <=	U2C_Rsp_RspData;
	  U2C_Rsp.PRE            <=	U2C_Rsp_PRE;
	  U2C_Rsp.CQid           <=	U2C_Rsp_CQid;
	  U2C_Rsp.Spare          <=	U2C_Rsp_Spare;

	  U2C_Data.Valid         <=	Stagger_U2C_Data_Valid[0];
	  U2C_Data.CQid          <=	Stagger_U2C_Data_CQid[0];
	  U2C_Data.ChunkValid    <=	Stagger_U2C_Data_ChunkValid[0];
	  U2C_Data.Data          <=     U2C_Data_Data;
	  U2C_Data.Poison        <=     U2C_Data_Poison;
	  U2C_Data.Err           <=     U2C_Data_Err;
	  U2C_Data.PRE           <=	Stagger_U2C_Data_PRE[0];
	  U2C_Data.DataParity    <=     U2C_Data_DataParity;
	  U2C_Data.ECC           <=     U2C_Data_ECC;
	  U2C_Data.Spare         <=     U2C_Data_Spare;
	end
    end

assign valid = any_valid & enable;

endmodule

`undef CLK_TICK
