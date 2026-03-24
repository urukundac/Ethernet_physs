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

module hif_pcie_pcie_upp_tcam_mems_rtl_tessent_tdr_TCAM_c1_algo_select_tdr (
  input wire ijtag_reset,
  input wire ijtag_sel,
  input wire ijtag_si,
  input wire ijtag_ce,
  input wire ijtag_se,
  input wire ijtag_ue,
  input wire ijtag_tck,
  input wire [6:0] ALGO_SEL_REG,
  output wire ijtag_so
);
reg    [6:0]        tdr;
reg                 retiming_so ;
 
 
 
// --------- ShiftRegister ---------
 
always_ff @ (posedge ijtag_tck) begin
  if (ijtag_ce & ijtag_sel) begin
    tdr <= { ALGO_SEL_REG[6],
             ALGO_SEL_REG[5],
             ALGO_SEL_REG[4],
             ALGO_SEL_REG[3],
             ALGO_SEL_REG[2],
             ALGO_SEL_REG[1],
             ALGO_SEL_REG[0]};
  end else if (ijtag_se & ijtag_sel) begin
    tdr <= {ijtag_si,tdr[6:1]};
  end
end
 
assign ijtag_so = retiming_so;
always_latch begin
  if (~ijtag_tck) begin
    retiming_so <= tdr[0];
  end
end
 
endmodule
