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
//       Created on: Thu Jun 19 03:09:55 PDT 2025
//--------------------------------------------------------------------------

module hif_pcie_pcie_upp_tcam_mems_rtl_tessent_mbisr_register_ip783tcam128x36s0c1_dft_wrp (
  input wire CLK,
  input wire RSTB,
  input wire SI,
  output wire SO,
  input wire SE,
  input wire [6:0] D,
  input wire MSO,
  input wire MSEL,
  output wire [6:0] Q
);
reg [6:0] ShiftReg;
reg       retime;
// synopsys async_set_reset "RSTB"
always_ff @ ( posedge CLK or negedge RSTB) begin
 if (~RSTB) begin
   ShiftReg <= 0;
 end else begin
   if (SE) begin
     ShiftReg <= {SI,ShiftReg[6:1]};
   end else begin
     ShiftReg <= D;
   end
 end
end
// synopsys async_set_reset "RSTB"
always_ff @ (negedge CLK or negedge RSTB) begin
 if (~RSTB) begin
   retime <= 0;
 end else begin
   if (MSEL) 
      retime <= MSO;
   else
      retime <= ShiftReg[0];
 end
end
assign SO = retime;
assign Q  = ShiftReg[6:0];
 
 
endmodule
