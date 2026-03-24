`ifndef __T_ONPI100G_JEM_MON
`define __T_ONPI100G_JEM_MON

   // ---------------------------------------------------------------------------
   // Elaboration-time parameter to enable hw-monitor instances
   // in (all the instances of) the IP. 
   // ---------------------------------------------------------------------------
   parameter ONPI100G_HW_MON_ENABLE = 1;

   // -- onpi100g_typ_t   : used to communicate the type of column
   //  to the C-side, mostly so that the C can format output appropriately
   typedef enum bit [7:0] {
     UNDEF   = 8'd0,  // -- undefined column
     LF      = 8'd1,  // -- Local Fault (/LF)
     RF      = 8'd2,  // -- Remote Fault (/RF)
     LI      = 8'd3,  // -- Link Interruption (/LI)
     SEQ     = 8'd4,  // -- Other Sequence ordered_set (/SEQ)
     I       = 8'd5,  // -- Idle (/I)
     LPI     = 8'd6,  // -- Low Power Idle (/LPI)
     S       = 8'd7,  // -- Start of Frame (/S)
     D       = 8'd8,  // -- Data (/D)
     T0      = 8'd9,  // -- End of Frame (/T) in lane-0
     T1      = 8'd10, // -- End of Frame (/T) in lane-1
     T2      = 8'd11, // -- End of Frame (/T) in lane-2
     T3      = 8'd12, // -- End of Frame (/T) in lane-3
     T4      = 8'd13, // -- End of Frame (/T) in lane-4
     T5      = 8'd14, // -- End of Frame (/T) in lane-5
     T6      = 8'd15, // -- End of Frame (/T) in lane-6
     T7      = 8'd16  // -- End of Frame (/T) in lane-7
   } onpi100g_typ_t;

   parameter D32_LF       = 32'h0100009c;
   parameter D32_RF       = 32'h0200009c;
   parameter D32_LI       = 32'h0300009c;
   parameter D32_SEQ      = 32'h0000009c;
   parameter D32_SEQ_MASK = 32'h000000ff;
   parameter D32_I        = 32'h07070707;
   parameter D32_LPI      = 32'h06060606;
   parameter D32_S        = 32'h000000fb;
   parameter D32_S_MASK   = 32'h000000ff;
   parameter D32_T0       = 32'h070707fd;
   parameter D32_T0_MASK  = 32'hffffffff;
   parameter D32_T1       = 32'h0707fd00;
   parameter D32_T1_MASK  = 32'hffffff00;
   parameter D32_T2       = 32'h07fd0000;
   parameter D32_T2_MASK  = 32'hffff0000;
   parameter D32_T3       = 32'hfd000000;
   parameter D32_T3_MASK  = 32'hff000000;

   parameter C4_SEQ       = 4'b0001;
   parameter C4_CTRL      = 4'b1111;
   parameter C4_S         = 4'b0001;
   parameter C4_T0        = 4'b1111;
   parameter C4_T1        = 4'b1110;
   parameter C4_T2        = 4'b1100;
   parameter C4_T3        = 4'b1000;
   parameter C4_DATA      = 4'b0000;

   parameter D64_LF       = 64'h000000000100009c;
   parameter D64_RF       = 64'h000000000200009c;
   parameter D64_LI       = 64'h000000000300009c;
   parameter D64_SEQ      = 64'h000000000000009c;
   parameter D64_SEQ_MASK = 64'h00000000000000ff;
   parameter D64_I        = 64'h0707070707070707;
   parameter D64_LPI      = 64'h0606060606060606;
   parameter D64_S        = 64'h00000000000000fb;
   parameter D64_S_MASK   = 64'h00000000000000ff;
   parameter D64_T0       = 64'h07070707070707fd;
   parameter D64_T0_MASK  = 64'hffffffffffffffff;
   parameter D64_T1       = 64'h070707070707fd00;
   parameter D64_T1_MASK  = 64'hffffffffffffff00;
   parameter D64_T2       = 64'h0707070707fd0000;
   parameter D64_T2_MASK  = 64'hffffffffffff0000;
   parameter D64_T3       = 64'h07070707fd000000;
   parameter D64_T3_MASK  = 64'hffffffffff000000;
   parameter D64_T4       = 64'h070707fd00000000;
   parameter D64_T4_MASK  = 64'hffffffff00000000;
   parameter D64_T5       = 64'h0707fd0000000000;
   parameter D64_T5_MASK  = 64'hffffff0000000000;
   parameter D64_T6       = 64'h07fd000000000000;
   parameter D64_T6_MASK  = 64'hffff000000000000;
   parameter D64_T7       = 64'hfd00000000000000;
   parameter D64_T7_MASK  = 64'hff00000000000000;

   parameter C8_SEQ       = 8'b00000001;
   parameter C8_CTRL      = 8'b11111111;
   parameter C8_S         = 8'b00000001;
   parameter C8_T0        = 8'b11111111;
   parameter C8_T1        = 8'b11111110;
   parameter C8_T2        = 8'b11111100;
   parameter C8_T3        = 8'b11111000;
   parameter C8_T4        = 8'b11110000;
   parameter C8_T5        = 8'b11100000;
   parameter C8_T6        = 8'b11000000;
   parameter C8_T7        = 8'b10000000;
   parameter C8_DATA      = 8'b00000000;

   // ---------------------------------------------------------------------------
   // Payload struct sent from hw-monitor to the SW side
   // ---------------------------------------------------------------------------
   typedef struct packed {

      onpi100g_typ_t narrow_typ;
      onpi100g_typ_t wide_typ0;
      onpi100g_typ_t wide_typ1;
      logic [31:0] data0;
      logic [31:0] data1;
      logic [31:0] data2;
      logic [31:0] data3;
      logic [3:0] ctl0;
      logic [3:0] ctl1;
      logic [3:0] ctl2;
      logic [3:0] ctl3;
      logic [7:0] mdata0;
      logic [7:0] mdata1;
      logic [7:0] mdata2;
      logic [7:0] mdata3;
      logic [7:0] mdata4;
      logic [7:0] mdata5;
      logic [7:0] mdata6;
      logic [7:0] mdata7;
      bit msdata;
      bit linkup;
      bit lp_linkup;
      bit [7:0] speed;
      bit [7:0] xoff;
} onpi100g_xctn_t;

`endif  //__T_ONPI100G_JEM_MON
