`ifndef __fpga_mport_mem
`define __fpga_mport_mem

module fpga_mport_mem#(
   parameter RD_PORTS      = 1,
   parameter WR_PORTS      = 1,
   parameter WR_SEGS       = 1,
   parameter WR_SEGSZ      = 1,
   parameter RD_SEGS       = 1,
   parameter WORDS         = 2,
   parameter RW_MPORT_CONFLICT = 0
)
(
   ckwr,  // write clock
   ckrd,  // read clock

   // Read port0
   arp0,      // Read address
   renp0,     // Global enable for read
   odoutp0,    // Read data

   // Read port1
   arp1,      // Read address
   renp1,     // Global enable for read
   odoutp1,    // Read data

   // Read port2
   arp2,      // Read address
   renp2,     // Global enable for read
   odoutp2,    // Read data

   // Read port3
   arp3,      // Read address
   renp3,     // Global enable for read
   odoutp3,    // Read data

   // Read port4
   arp4,      // Read address
   renp4,     // Global enable for read
   odoutp4,    // Read data

   // Read port5
   arp5,      // Read address
   renp5,     // Global enable for read
   odoutp5,    // Read data

   // Read port6
   arp6,      // Read address
   renp6,     // Global enable for read
   odoutp6,    // Read data
   
   // Read port7
   arp7,      // Read address
   renp7,     // Global enable for read
   odoutp7,    // Read data
   
   // Read port8
   arp8,      // Read address
   renp8,     // Global enable for read
   odoutp8,    // Read data
   
   // Read port9
   arp9,      // Read address
   renp9,     // Global enable for read
   odoutp9,    // Read data
   
   // Read port10
   arp10,      // Read address
   renp10,     // Global enable for read
   odoutp10,    // Read data
   
   // Read port11
   arp11,      // Read address
   renp11,     // Global enable for read
   odoutp11,    // Read data
   
   // Write port0
   awp0,      // Write address
   idinp0,     // Write data
   wenp0,     // enable for write

   // Write port1
   awp1,      // Write address
   idinp1,     // Write data
   wenp1,     // Global enable for write

   // Write port2
   awp2,      // Write address
   idinp2,     // Write data
   wenp2,     // Global enable for write

   // Write port3
   awp3,      // Write address
   idinp3,     // Write data
   wenp3,     // Global enable for write

   // Write port4
   awp4,      // Write address
   idinp4,     // Write data
   wenp4,      // Global enable for write
   
   // Write port5
   awp5,      // Write address
   idinp5,     // Write data
   wenp5,      // Global enable for write
   
   // Write port6
   awp6,      // Write address
   idinp6,     // Write data
   wenp6,      // Global enable for write
   
   // Write port7
   awp7,      // Write address
   idinp7,     // Write data
   wenp7      // Global enable for write
   
   
);

localparam WIDTH 	= WR_SEGS*WR_SEGSZ;
localparam RD_SEGSZ 	= (WR_SEGS*WR_SEGSZ)/RD_SEGS;
localparam WORDLOG2     = $clog2(WORDS);
localparam ADDR_WDTH    = WORDLOG2;
localparam ROM_FILE_TYPE = "HEX";
localparam ROM_LOAD_FILE = "null";

/////////////////////////////////
///////// INTERFACE /////////////
/////////////////////////////////

input  logic ckwr;
input  logic ckrd;

// read port0
input  logic [RD_SEGS-1:0] renp0;
input  logic [ADDR_WDTH-1:0] arp0;
output logic [RD_SEGS-1:0][RD_SEGSZ-1:0] odoutp0;

// read port1
input  logic [RD_SEGS-1:0] renp1;
input  logic [ADDR_WDTH-1:0] arp1;
output logic [RD_SEGS-1:0][RD_SEGSZ-1:0] odoutp1;

// read port2
input  logic [RD_SEGS-1:0] renp2;
input  logic [ADDR_WDTH-1:0] arp2;
output logic [RD_SEGS-1:0][RD_SEGSZ-1:0] odoutp2;

// read port3
input  logic [RD_SEGS-1:0] renp3;
input  logic [ADDR_WDTH-1:0] arp3;
output logic [RD_SEGS-1:0][RD_SEGSZ-1:0] odoutp3;

// read port4
input  logic [RD_SEGS-1:0] renp4;
input  logic [ADDR_WDTH-1:0] arp4;
output logic [RD_SEGS-1:0][RD_SEGSZ-1:0] odoutp4;

// read port5
input  logic [RD_SEGS-1:0] renp5;
input  logic [ADDR_WDTH-1:0] arp5;
output logic [RD_SEGS-1:0][RD_SEGSZ-1:0] odoutp5;

// read port6
input  logic [RD_SEGS-1:0] renp6;
input  logic [ADDR_WDTH-1:0] arp6;
output logic [RD_SEGS-1:0][RD_SEGSZ-1:0] odoutp6;

// read port7
input  logic [RD_SEGS-1:0] renp7;
input  logic [ADDR_WDTH-1:0] arp7;
output logic [RD_SEGS-1:0][RD_SEGSZ-1:0] odoutp7;

// read port8
input  logic [RD_SEGS-1:0] renp8;
input  logic [ADDR_WDTH-1:0] arp8;
output logic [RD_SEGS-1:0][RD_SEGSZ-1:0] odoutp8;

// read port9
input  logic [RD_SEGS-1:0] renp9;
input  logic [ADDR_WDTH-1:0] arp9;
output logic [RD_SEGS-1:0][RD_SEGSZ-1:0] odoutp9;

// read port10
input  logic [RD_SEGS-1:0] renp10;
input  logic [ADDR_WDTH-1:0] arp10;
output logic [RD_SEGS-1:0][RD_SEGSZ-1:0] odoutp10;

// read port11
input  logic [RD_SEGS-1:0] renp11;
input  logic [ADDR_WDTH-1:0] arp11;
output logic [RD_SEGS-1:0][RD_SEGSZ-1:0] odoutp11;

// write port0
input  logic [WR_SEGS-1:0] wenp0;
input  logic [ADDR_WDTH-1:0] awp0;
input  logic [WR_SEGS-1:0][WR_SEGSZ-1:0] idinp0;

// write port1
input  logic [WR_SEGS-1:0] wenp1;
input  logic [ADDR_WDTH-1:0] awp1;
input  logic [WR_SEGS-1:0][WR_SEGSZ-1:0] idinp1;

// write port2
input  logic [WR_SEGS-1:0] wenp2;
input  logic [ADDR_WDTH-1:0] awp2;
input  logic [WR_SEGS-1:0][WR_SEGSZ-1:0] idinp2;

// write port3
input  logic [WR_SEGS-1:0] wenp3;
input  logic [ADDR_WDTH-1:0] awp3;
input  logic [WR_SEGS-1:0][WR_SEGSZ-1:0] idinp3;

// write port4
input  logic [WR_SEGS-1:0] wenp4;
input  logic [ADDR_WDTH-1:0] awp4;
input  logic [WR_SEGS-1:0][WR_SEGSZ-1:0] idinp4;

// write port5
input  logic [WR_SEGS-1:0] wenp5;
input  logic [ADDR_WDTH-1:0] awp5;
input  logic [WR_SEGS-1:0][WR_SEGSZ-1:0] idinp5;

// write port6
input  logic [WR_SEGS-1:0] wenp6;
input  logic [ADDR_WDTH-1:0] awp6;
input  logic [WR_SEGS-1:0][WR_SEGSZ-1:0] idinp6;

// write port7
input  logic [WR_SEGS-1:0] wenp7;
input  logic [ADDR_WDTH-1:0] awp7;
input  logic [WR_SEGS-1:0][WR_SEGSZ-1:0] idinp7;

/////////////////////////////////
///////// CODE   ////////////////
/////////////////////////////////
logic [RD_SEGS-1:0][RD_SEGSZ-1:0] s_odoutp0;
logic [RD_SEGS-1:0][RD_SEGSZ-1:0] s_odoutp1;
logic [RD_SEGS-1:0][RD_SEGSZ-1:0] s_odoutp2;
logic [RD_SEGS-1:0][RD_SEGSZ-1:0] s_odoutp3;
logic [RD_SEGS-1:0][RD_SEGSZ-1:0] s_odoutp4;
logic [RD_SEGS-1:0][RD_SEGSZ-1:0] s_odoutp5;
logic [RD_SEGS-1:0][RD_SEGSZ-1:0] s_odoutp6;
logic [RD_SEGS-1:0][RD_SEGSZ-1:0] s_odoutp7;
logic [RD_SEGS-1:0][RD_SEGSZ-1:0] s_odoutp8;
logic [RD_SEGS-1:0][RD_SEGSZ-1:0] s_odoutp9;
logic [RD_SEGS-1:0][RD_SEGSZ-1:0] s_odoutp10;
logic [RD_SEGS-1:0][RD_SEGSZ-1:0] s_odoutp11;

logic [RD_SEGS-1:0][RD_SEGSZ-1:0] s_odoutp0_bp;
logic [RD_SEGS-1:0][RD_SEGSZ-1:0] s_odoutp1_bp;
logic [RD_SEGS-1:0][RD_SEGSZ-1:0] s_odoutp2_bp;
logic [RD_SEGS-1:0][RD_SEGSZ-1:0] s_odoutp3_bp;
logic [RD_SEGS-1:0][RD_SEGSZ-1:0] s_odoutp4_bp;
logic [RD_SEGS-1:0][RD_SEGSZ-1:0] s_odoutp5_bp;
logic [RD_SEGS-1:0][RD_SEGSZ-1:0] s_odoutp6_bp;
logic [RD_SEGS-1:0][RD_SEGSZ-1:0] s_odoutp7_bp;
logic [RD_SEGS-1:0][RD_SEGSZ-1:0] s_odoutp8_bp;
logic [RD_SEGS-1:0][RD_SEGSZ-1:0] s_odoutp9_bp;
logic [RD_SEGS-1:0][RD_SEGSZ-1:0] s_odoutp10_bp;
logic [RD_SEGS-1:0][RD_SEGSZ-1:0] s_odoutp11_bp;

logic [RD_SEGS-1:0] renp0_d1;
logic [RD_SEGS-1:0] renp1_d1;
logic [RD_SEGS-1:0] renp2_d1;
logic [RD_SEGS-1:0] renp3_d1;
logic [RD_SEGS-1:0] renp4_d1;
logic [RD_SEGS-1:0] renp5_d1;
logic [RD_SEGS-1:0] renp6_d1;
logic [RD_SEGS-1:0] renp7_d1;
logic [RD_SEGS-1:0] renp8_d1;
logic [RD_SEGS-1:0] renp9_d1;
logic [RD_SEGS-1:0] renp10_d1;
logic [RD_SEGS-1:0] renp11_d1;

logic [ADDR_WDTH-1:0] arp0_d1;
logic [ADDR_WDTH-1:0] arp1_d1;
logic [ADDR_WDTH-1:0] arp2_d1;
logic [ADDR_WDTH-1:0] arp3_d1;
logic [ADDR_WDTH-1:0] arp4_d1;
logic [ADDR_WDTH-1:0] arp5_d1;
logic [ADDR_WDTH-1:0] arp6_d1;
logic [ADDR_WDTH-1:0] arp7_d1;
logic [ADDR_WDTH-1:0] arp8_d1;
logic [ADDR_WDTH-1:0] arp9_d1;
logic [ADDR_WDTH-1:0] arp10_d1;
logic [ADDR_WDTH-1:0] arp11_d1;

logic [WR_SEGS-1:0] wenp0_d1;
logic [WR_SEGS-1:0] wenp1_d1;
logic [WR_SEGS-1:0] wenp2_d1;
logic [WR_SEGS-1:0] wenp3_d1;
logic [WR_SEGS-1:0] wenp4_d1;
logic [WR_SEGS-1:0] wenp5_d1;
logic [WR_SEGS-1:0] wenp6_d1;
logic [WR_SEGS-1:0] wenp7_d1;

logic [ADDR_WDTH-1:0] awp0_d1;
logic [ADDR_WDTH-1:0] awp1_d1;
logic [ADDR_WDTH-1:0] awp2_d1;
logic [ADDR_WDTH-1:0] awp3_d1;
logic [ADDR_WDTH-1:0] awp4_d1;
logic [ADDR_WDTH-1:0] awp5_d1;
logic [ADDR_WDTH-1:0] awp6_d1;
logic [ADDR_WDTH-1:0] awp7_d1;

logic [WR_SEGS-1:0][WR_SEGSZ-1:0] idinp0_d1;
logic [WR_SEGS-1:0][WR_SEGSZ-1:0] idinp1_d1;
logic [WR_SEGS-1:0][WR_SEGSZ-1:0] idinp2_d1;
logic [WR_SEGS-1:0][WR_SEGSZ-1:0] idinp3_d1;
logic [WR_SEGS-1:0][WR_SEGSZ-1:0] idinp4_d1;
logic [WR_SEGS-1:0][WR_SEGSZ-1:0] idinp5_d1;
logic [WR_SEGS-1:0][WR_SEGSZ-1:0] idinp6_d1;
logic [WR_SEGS-1:0][WR_SEGSZ-1:0] idinp7_d1;

///////////////////////////////////
/// ARRAY READ/WRITE OPERATIONS ///
///////////////////////////////////

   `include "fpga_mem_lib.vs"

endmodule

`endif 
//--------------------------------------------------------------------------------
// Modification History
// Date       Name of      Description
//            Engineer
//--------------------------------------------------------------------------------
// 12-Mar-'19 Sachin Jain  Support for more numbers of Read ports (+2) and Write
//                         ports(+1) added now. Corresponding code changes done in
//                         fpga_mem_lib.vs too.
// 14-May-'19 Vikas        Added parameter RW_MPORT_CONFLICT, initialized to
//                         0. When set to '1', a by-pass logic is enabled.
//                         Note that, by-pass logic works only when read and
//                         write clocks are same.
// 13-May-'20 Vikas        Added signals required for registering the inputs
//                         enables, and read/write addresses
// 19-Apr-'21 Sachin Jain  Added 4 read and 2 write ports additioanlly