`ifndef __T_IOSF_SB_JEM_REQ
`define __T_IOSF_SB_JEM_REQ

// this entire structure will be visible on SW side
typedef struct packed{
   // posted flag
   logic posted;
   // indicates whether this packet is an end of transaction
   logic eom;
   // indicates whether this packet is a new pkt or a tail
   logic start;
   // how many bytes transmitted in the packet
   logic [15:0] cnt;
   // payload
   logic [159:0] data;

   // in vs out, master vs target, etc
   logic direction;
   //logic [31:0] timens0;  // adding in a timer in ns, because fastclks are useless
   //logic [31:0] timens1;  // adding in a timer in ns, because fastclks are useless
} t_iosf_sb_jem_req;

`endif  //__T_IOSF_SB_JEM_REQ
