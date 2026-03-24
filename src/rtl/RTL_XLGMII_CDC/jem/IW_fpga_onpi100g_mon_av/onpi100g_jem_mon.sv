// -- onpi100g_jem_mon.sv
//  Implements a synthesizable ONPI monitor module with a single ONPI input interface.

//`include "sla_rtl_tlm_macros.svh"
`include "onpi100g_jem_mon.vh"

module onpi100g_jem_mon #(
  parameter IDLE_CAPTURE_CNT = 3 //Number of idle packets beyond which idle packets are not captured
  ) (
    // ONPI Interface
    input logic        clk,
    input logic [31:0] data0,
    input logic [31:0] data1,
    input logic [31:0] data2,
    input logic [31:0] data3,
    input logic [3:0]  ctl0,
    input logic [3:0]  ctl1,
    input logic [3:0]  ctl2,
    input logic [3:0]  ctl3,
    input logic [7:0]  mdata0,
    input logic [7:0]  mdata1,
    input logic [7:0]  mdata2,
    input logic [7:0]  mdata3,
    input logic [7:0]  mdata4,
    input logic [7:0]  mdata5,
    input logic [7:0]  mdata6,
    input logic [7:0]  mdata7,
    input logic        msdata,
    input logic        linkup,
    input logic        lp_linkup,
    input logic [7:0]  speed,
    input logic [7:0]  xoff,

    output onpi100g_xctn_t  onpi_data,
    output                                    onpi_data_valid
    );

   //import onpi100g_jem_pkg::*;

   // state variables
   bit linkup1d;
   bit lp_linkup1d;
   bit [7:0] speed_mode;

   onpi100g_xctn_t xctn;
   logic xctn_valid;

   // -- building blocks
   logic [31:0] d32;
   logic [3:0] c4;
   logic [64:0] d64 [2];
   logic [7:0] c8 [2];

   always_ff @(posedge clk) begin
      linkup1d <= linkup;
      lp_linkup1d <= lp_linkup;
      if ((linkup === 1'b1) && (linkup1d === 1'b0))
	speed_mode <= speed;
      else if (linkup !== 1'b1)
	speed_mode <= 8'd15;
   end

   assign d32 = data0;
   assign c4 = ctl0;
   assign d64[0] = {data1, data0};
   assign d64[1] = {data3, data2};
   assign c8[0] = {ctl1, ctl0};
   assign c8[1] = {ctl3, ctl2};

   //
   // populate a struct and send out through a synthesizable analysis port
   //
   always_comb begin : narrow_typ_c
      xctn.narrow_typ = UNDEF;
      if ((d32 === D32_LF) && (c4 === C4_SEQ))
	xctn.narrow_typ = LF;
      else if ((d32 === D32_RF) && (c4 === C4_SEQ))
	xctn.narrow_typ = RF;
      else if ((d32 === D32_LI) && (c4 === C4_SEQ))
	xctn.narrow_typ = LI;
      else if (((d32 & D32_SEQ_MASK) === D32_SEQ) && (c4 === C4_SEQ))
	xctn.narrow_typ = SEQ;
      else if ((d32 === D32_I) && (c4 === C4_CTRL))
	xctn.narrow_typ = I;
      else if ((d32 === D32_LPI) && (c4 === C4_CTRL))
	xctn.narrow_typ = LPI;
      else if (((d32 & D32_S_MASK) === D32_S) && (c4 === C4_S))
	xctn.narrow_typ = S;
      else if (c4 === C4_DATA)
	xctn.narrow_typ = D;
      else if (((d32 & D32_T0_MASK) === D32_T0) && (c4 === C4_T0))
	xctn.narrow_typ = T0;
      else if (((d32 & D32_T1_MASK) === D32_T1) && (c4 === C4_T1))
	xctn.narrow_typ = T1;
      else if (((d32 & D32_T2_MASK) === D32_T2) && (c4 === C4_T2))
	xctn.narrow_typ = T2;
      else if (((d32 & D32_T3_MASK) === D32_T3) && (c4 === C4_T3))
	xctn.narrow_typ = T3;
   end

   always_comb begin :wide_typ0_c
      xctn.wide_typ0 = UNDEF;
      if ((d64[0] === D64_LF) && (c8[0] === C8_SEQ))
	xctn.wide_typ0 = LF;
      else if ((d64[0] === D64_RF) && (c8[0] === C8_SEQ))
	xctn.wide_typ0 = RF;
      else if ((d64[0] === D64_LI) && (c8[0] === C8_SEQ))
	xctn.wide_typ0 = LI;
      else if (((d64[0] & D64_SEQ_MASK) === D64_SEQ) &&
	       (c8[0] === C8_SEQ))
	xctn.wide_typ0 = SEQ;
      else if ((d64[0] === D64_I) && (c8[0] === C8_CTRL))
	xctn.wide_typ0 = I;
      else if ((d64[0] === D64_LPI) && (c8[0] === C8_CTRL))
	xctn.wide_typ0 = LPI;
      else if (((d64[0] & D64_S_MASK) === D64_S) &&
	       (c8[0] === C8_S))
	xctn.wide_typ0 = S;
      else if (c8[0] === C8_DATA)
	xctn.wide_typ0 = D;
      else if (((d64[0] & D64_T0_MASK) === D64_T0) &&
	       (c8[0] === C8_T0))
	xctn.wide_typ0 = T0;
      else if (((d64[0] & D64_T1_MASK) === D64_T1) &&
	       (c8[0] === C8_T1))
	xctn.wide_typ0 = T1;
      else if (((d64[0] & D64_T2_MASK) === D64_T2) &&
	       (c8[0] === C8_T2))
	xctn.wide_typ0 = T2;
      else if (((d64[0] & D64_T3_MASK) === D64_T3) &&
	       (c8[0] === C8_T3))
	xctn.wide_typ0 = T3;
      else if (((d64[0] & D64_T4_MASK) === D64_T4) &&
	       (c8[0] === C8_T4))
	xctn.wide_typ0 = T4;
      else if (((d64[0] & D64_T5_MASK) === D64_T5) &&
	       (c8[0] === C8_T5))
	xctn.wide_typ0 = T5;
      else if (((d64[0] & D64_T6_MASK) === D64_T6) &&
	       (c8[0] === C8_T6))
	xctn.wide_typ0 = T6;
      else if (((d64[0] & D64_T7_MASK) === D64_T7) &&
	       (c8[0] === C8_T7))
	xctn.wide_typ0 = T7;
   end

   always_comb begin : wide_typ1_c
      xctn.wide_typ1 = UNDEF;
      if ((d64[1] === D64_LF) && (c8[1] === C8_SEQ))
	xctn.wide_typ1 = LF;
      else if ((d64[1] === D64_RF) && (c8[1] === C8_SEQ))
	xctn.wide_typ1 = RF;
      else if ((d64[1] === D64_LI) && (c8[1] === C8_SEQ))
	xctn.wide_typ1 = LI;
      else if (((d64[1] & D64_SEQ_MASK) === D64_SEQ) &&
	       (c8[1] === C8_SEQ))
	xctn.wide_typ1 = SEQ;
      else if ((d64[1] === D64_I) && (c8[1] === C8_CTRL))
	xctn.wide_typ1 = I;
      else if ((d64[1] === D64_LPI) && (c8[1] === C8_CTRL))
	xctn.wide_typ1 = LPI;
      else if (((d64[1] & D64_S_MASK) === D64_S) &&
	       (c8[1] === C8_S))
	xctn.wide_typ1 = S;
      else if (c8[1] === C8_DATA)
	xctn.wide_typ1 = D;
      else if (((d64[1] & D64_T0_MASK) === D64_T0) &&
	       (c8[1] === C8_T0))
	xctn.wide_typ1 = T0;
      else if (((d64[1] & D64_T1_MASK) === D64_T1) &&
	       (c8[1] === C8_T1))
	xctn.wide_typ1 = T1;
      else if (((d64[1] & D64_T2_MASK) === D64_T2) &&
	       (c8[1] === C8_T2))
	xctn.wide_typ1 = T2;
      else if (((d64[1] & D64_T3_MASK) === D64_T3) &&
	       (c8[1] === C8_T3))
	xctn.wide_typ1 = T3;
      else if (((d64[1] & D64_T4_MASK) === D64_T4) &&
	       (c8[1] === C8_T4))
	xctn.wide_typ1 = T4;
      else if (((d64[1] & D64_T5_MASK) === D64_T5) &&
	       (c8[1] === C8_T5))
	xctn.wide_typ1 = T5;
      else if (((d64[1] & D64_T6_MASK) === D64_T6) &&
	       (c8[1] === C8_T6))
	xctn.wide_typ1 = T6;
      else if (((d64[1] & D64_T7_MASK) === D64_T7) &&
	       (c8[1] === C8_T7))
	xctn.wide_typ1 = T7;
   end

   always_comb begin : xctn_others_c
      xctn.data0 = data0;
      xctn.data1 = data1;
      xctn.data2 = data2;
      xctn.data3 = data3;
      xctn.ctl0 = ctl0;
      xctn.ctl1 = ctl1;
      xctn.ctl2 = ctl2;
      xctn.ctl3 = ctl3;
      xctn.mdata0 = mdata0;
      xctn.mdata1 = mdata1;
      xctn.mdata2 = mdata2;
      xctn.mdata3 = mdata3;
      xctn.mdata4 = mdata4;
      xctn.mdata5 = mdata5;
      xctn.mdata6 = mdata6;
      xctn.mdata7 = mdata7;
      xctn.msdata = msdata;
      xctn.linkup = linkup;
      xctn.lp_linkup = lp_linkup;
      xctn.speed = speed;
      xctn.xoff = xoff;
   end

   //assign xctn_valid = 1'b1;

   reg [3:0] idleCnt;
   always @(posedge clk) begin
     if ((xctn.narrow_typ == I) & (xctn.wide_typ0 == I) & (xctn.wide_typ1 == I)) begin
       idleCnt <= (idleCnt <= IDLE_CAPTURE_CNT)? idleCnt + 1: idleCnt;
     end
     else begin
       idleCnt <= 0;
     end
   end

   assign xctn_valid = ((xctn.narrow_typ == I) & (xctn.wide_typ0 == I) & (xctn.wide_typ1 == I) &&  (idleCnt > IDLE_CAPTURE_CNT) )?1'b0:1'b1;
   assign onpi_data = xctn;
   assign onpi_data_valid = xctn_valid & linkup;


   //`SLA_RTL_ANALYSIS_PORT_BRIDGE(xctn_out_port, onpi100g_xctn_t, xctn, posedge, clk, xctn_valid)

endmodule : onpi100g_jem_mon
