`ifndef __T_IDI_JEM
`define __T_IDI_JEM

typedef struct packed {
    bit                  Valid;
    bit[1:0]             OpGroup;
    bit[5:0]             Opcode;
    bit[51:0]            Address;
    bit                  AddrParity;         /* Optional field */
    bit                  SelfSnp;
    bit[11:0]            CQid;
    bit[5:0]             Length;
    bit[2:0]             LPid;
    bit[4:0]             CLoS;
    bit[7:0]             SAI;
    bit[1:0]             NonTemporal;
    bit                  CacheNear;
    bit                  CacheFar;
    bit[5:0]             Hash;               /* Optional field */
    bit[3:0]             Topology;           /* Optional field */
    bit[9:0]             Spare;
    bit[63:0]            delay;              /* Relative number of cycles to wait before sending next packet */
} C2URequest_t;

typedef struct packed {
    bit                  Valid;
    bit[4:0]             Opcode;
    bit[12:0]            UQid;
    bit                  MonitorExist;
    bit                  HLEAbort;
    bit[1:0]             Spare;
} C2UResponse_t;

typedef struct packed {
    bit                  Valid;
    bit[12:0]            UQid;
    bit[3:0]             ChunkValid;
    bit[255:0]           Data;
    bit[31:0]            ByteEnable;    
    bit                  Bogus;
    bit                  Poison;
    bit[3:0]             DataParity;         /* Optional field */
    bit                  BEParity;           /* Optional field */
    bit[9:0]             ECC;                /* Optional field */
    bit                  ECCValid;           /* Optional field */
    bit[1:0]             Spare;
} C2UData_t;

typedef struct packed {
    bit                  Valid;
    bit[4:0]             Opcode;
    bit[49:0]            Address;
    bit                  AddrParity;         /* Optional field */
    bit[15:0]            ReqData;
    bit[1:0]             Spare;
} U2CRequest_t;

typedef struct packed {
    bit                  Valid;
    bit[3:0]             Opcode;
    bit[12:0]            RspData;
    bit[1:0]             PRE;
    bit[11:0]            CQid;
    bit[9:0]             Spare;
} U2CResponse_t;

typedef struct packed {
    bit                  Valid;
    bit[11:0]            CQid;
    bit[3:0]             ChunkValid;
    bit[255:0]           Data;
    bit                  Poison;
    bit                  Err;
    bit[6:0]             PRE;
    bit[3:0]             DataParity;         /* Optional field */
    bit[9:0]             ECC;                /* Optional field */
    bit                  ECCValid;         /* Optional field */
    bit                  Spare;
} U2CData_t;

`endif  //__T_IDI_JEM
