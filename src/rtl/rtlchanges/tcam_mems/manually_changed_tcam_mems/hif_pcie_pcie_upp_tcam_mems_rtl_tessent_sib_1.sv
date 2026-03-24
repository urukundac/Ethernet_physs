//--------------------------------------------------------------------------
//
//  Unpublished work. Copyright 2025 Siemens
//
//  This material contains trade secrets or otherwise confidential 
//  information owned by Siemens Industry Software Inc. or its affiliates 
//  (collectively, SISW), or its licensors. Access to and use of this 
//  information is strictly limited as set forth in the Customer's 
//  applicable agreements with SISW.
//
//--------------------------------------------------------------------------
//  File created by: Tessent Shell
//          Version: 2025.1
//       Created on: Thu Jun 19 03:09:03 PDT 2025
//--------------------------------------------------------------------------

module hif_pcie_pcie_upp_tcam_mems_rtl_tessent_sib_1 (
   input  wire         ijtag_reset,
   input  wire         ijtag_sel,
   input  wire         ijtag_si,
   input  wire         ijtag_ce,
   input  wire         ijtag_se,
   input  wire         ijtag_ue,
   input  wire         ijtag_tck,
   output wire         ijtag_so,
   input  wire         ijtag_from_so,
   input  wire         ltest_si,
   input  wire         ltest_scan_en,
   input  wire         ltest_en,
   input  wire         ltest_clk,
   input  wire         ltest_mem_bypass_en,
   input  wire         ltest_mcp_bounding_en,
   input  wire         ltest_async_set_reset_static_disable,
   output wire         ijtag_to_tck,
   output wire         ijtag_to_reset,
   output wire         ijtag_to_si,
   output wire         ijtag_to_ce,
   output wire         ijtag_to_se,
   output wire         ijtag_to_ue,
   output wire         ltest_so,
   output wire         ltest_to_en,
   output wire         ltest_to_mem_bypass_en,
   output wire         ltest_to_mcp_bounding_en,
   output wire         ltest_to_scan_en,
   output wire         ijtag_to_sel
);
   reg            sib;
   reg            sib_latch;
   reg            retiming_so;
   reg            to_enable_int;
   reg            ltest_to_si;
   reg            retiming_ltest_to_si;
   reg [1:0]      ltest_ce_se_ue;
   reg            retiming_ltest_to_ce;
   reg            retiming_ltest_to_se;
   reg            ltest_to_sel;
   reg            ltest_so_retiming;
   reg            ltest_to_reset;
   reg            retiming_ltest_to_sel;
   wire           ltest_to_reset_dynamic_enable;
   wire           ltest_reset_mux_i1;

   assign ltest_to_en = ltest_en;
   assign ltest_to_mem_bypass_en = ltest_en & ltest_mem_bypass_en;
   assign ltest_to_mcp_bounding_en = ltest_en & ltest_mcp_bounding_en;
   assign ltest_to_scan_en = ltest_en & ltest_scan_en;
   assign ijtag_to_sel = ltest_en ? ltest_to_sel : to_enable_int & ijtag_sel;
   always_ff @ (negedge ijtag_tck or negedge ijtag_reset) begin
      if (~ijtag_reset) begin
         sib_latch     <= 1'b0;
      end else if (ijtag_ue & ijtag_sel) begin
         sib_latch     <= sib;
      end
   end
   always_ff @ (negedge ijtag_tck or negedge ijtag_reset) begin
      if (~ijtag_reset) begin
         to_enable_int <= 1'b0;
      end else  begin
         to_enable_int <= sib_latch;
      end
   end
 
   assign ijtag_so = retiming_so;
    always_latch begin
      if (~ijtag_tck) begin
         retiming_so     <= sib;
      end
   end
 
   always_ff @ (posedge ijtag_tck) begin
      if (ijtag_ce & ijtag_sel) begin
         sib <= 1'b0;
      end else if (ijtag_se & ijtag_sel) begin
         if (sib_latch) begin
            sib <= ijtag_from_so;
         end else begin
            sib <= ijtag_si;
         end
      end
   end
 
   assign ltest_reset_mux_i1 = ltest_to_reset | (ltest_scan_en | ltest_async_set_reset_static_disable);
   TS_MX tessent_persistent_cell_ltest_reset_mux (
     .a                   (ltest_reset_mux_i1),
     .b                   (ijtag_reset),
     .sa                  (ltest_en),
     .o                   (ijtag_to_reset)
   );
   assign ijtag_to_si    =  ltest_en ? retiming_ltest_to_si : ijtag_si;
   assign ijtag_to_ce    = ltest_en ? ~ltest_ce_se_ue[1] &  ltest_ce_se_ue[0] : ijtag_ce;
   assign ijtag_to_se    = ltest_en ?  ltest_ce_se_ue[1] & ~ltest_ce_se_ue[0] : ijtag_se;
   assign ijtag_to_ue    = ltest_en ?  ltest_ce_se_ue[1] &  ltest_ce_se_ue[0] : ijtag_ue;
   assign ltest_so       = ltest_so_retiming;
   always_ff @ (posedge ijtag_to_tck) begin
     if (ltest_scan_en) begin
       ltest_to_sel <= ltest_ce_se_ue[1];
       ltest_ce_se_ue[1] <= ltest_ce_se_ue[0];
       ltest_ce_se_ue[0] <= retiming_ltest_to_si;
       ltest_to_si <= ltest_to_reset;
       ltest_to_reset <= ltest_si;
     end else begin
       ltest_to_si <= ijtag_from_so;
       ltest_ce_se_ue <= ltest_ce_se_ue;
       ltest_to_sel <= ltest_to_sel;
       ltest_to_reset <= ltest_to_reset;
     end
   end
 
   TS_CLK_MUX tessent_persistent_cell_ltest_clock_mux (
     .ck0                ( ijtag_tck ),
     .ck1                ( ltest_clk ),
     .s                  ( ltest_en ),
     .o                  ( ijtag_to_tck )
   );
 
    always_latch begin
     if (~ijtag_to_tck) begin
       retiming_ltest_to_si <= ltest_to_si;
     end
   end 
   always_latch begin
     if (~ijtag_to_tck) begin
       ltest_so_retiming <= ltest_to_sel;
     end
   end
endmodule
