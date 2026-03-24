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

module hif_pcie_pcie_upp_tcam_mems_rtl_tessent_tdr_sri_ctrl (
  input wire ijtag_reset,
  input wire ijtag_sel,
  input wire ijtag_si,
  input wire ijtag_ce,
  input wire ijtag_se,
  input wire ijtag_ue,
  input wire ijtag_tck,
  output wire tck_select,
  output wire all_test,
  output wire ijtag_so
);
wire                tck_select_to_buf;
wire                all_test_to_buf;
reg    [1:0]        tdr;
reg                 retiming_so ;
reg                 tck_select_latch;
reg                 all_test_latch;
 
 
TS_BUF tessent_persistent_cell_tck_select ( .a (tck_select_latch), .o (tck_select) );
TS_BUF tessent_persistent_cell_all_test ( .a (all_test_latch), .o (all_test) );
 
// --------- ShiftRegister ---------
 
always_ff @ (posedge ijtag_tck) begin
  if (ijtag_ce & ijtag_sel) begin
    tdr <= { 2'b00};
  end else if (ijtag_se & ijtag_sel) begin
    tdr <= {ijtag_si,tdr[1:1]};
  end
end
 
assign ijtag_so = retiming_so;
always_latch begin
  if (~ijtag_tck) begin
    retiming_so <= tdr[0];
  end
end
 
// --------- DataOutPort 1 ---------
always_ff @ (negedge ijtag_tck or negedge ijtag_reset) begin
  if (~ijtag_reset) begin
    tck_select_latch <= 1'b0;
  end else begin
    if (ijtag_ue & ijtag_sel) begin
      tck_select_latch <= tdr[1];
    end
  end
end
 
// --------- DataOutPort 0 ---------
always_ff @ (negedge ijtag_tck or negedge ijtag_reset) begin
  if (~ijtag_reset) begin
    all_test_latch <= 1'b0;
  end else begin
    if (ijtag_ue & ijtag_sel) begin
      all_test_latch <= tdr[0];
    end
  end
end
 
endmodule
