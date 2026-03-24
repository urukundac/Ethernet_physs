// ***********************************************************************
// * AGERE CONFIDENTIAL                                                  *
// *                         PROPRIETARY NOTE                            *
// *                                                                     *
// *  This software contains information confidential and proprietary    *
// *  to Agere Corporation.  It shall not be reproduced in whole or in   *
// *  part, or transferred to other documents, or disclosed to third     *
// *  parties, or used for any purpose other than that for which it was  *
// *  obtained, without the prior written consent of Agere Corporation.  *
// *  (c) 1999, Agere Corporation.  All rights reserved.                 *
// *                                                                     *
// ***********************************************************************
// ***********************************************************************
// *               Verilog Behavioral Model File                         *
// ***********************************************************************
// ***********************************************************************
// * File:      $RCSfile: IW_fpga_demux.sv.rca $
// * Version:   $Revision: 1.3.1.3 $
// * Engineer:  Dave Brown
// * Date:      $Date: Wed Apr 24 07:29:44 2013 $
// *
// * Description:
// *    This module contains demuxing logic for signals going between
// *    fpga partitions of a chip.
// *
// verilint 396 off  // A flipflop without an asynchronous reset
// verilint 530 off  // A flipflop is inferred
// verilint 549 off  // Asynchronous flipflop is inferred
// verilint 446 off  // Reading from an output port
// verilint 594 off  // Not all cases covered in case, but default case exists
// verilint 551 off  // full_case has a default clause
// verilint 488 off  // Bus variable in sensitivity list but not all bits used
// verilint 631 off  // Assigning to self. This is harmless can reduce sim speed
// verilint 498 off  // Not all the bits of the vector are used

// *
// *
// ***********************************************************************
// ***********************************************************************
// * Revision Log (see bottom of file)
// ***********************************************************************
// `include "timescale.v"


module IW_fpga_demux   #(
    parameter NUMBER_OF_INPUTS     = 16
  , parameter MULTIPLEX_RATIO      = 6
  , parameter CLOCK_RATIO          = 4
  , parameter FPGA_FAMILY          = "S5"
  , parameter INFRA_AVST_CHNNL_W   = 8
  , parameter INFRA_AVST_DATA_W    = 8
  , parameter INFRA_AVST_CHNNL_ID  = 8

  , parameter CSR_ADDR_WIDTH       = 3*INFRA_AVST_DATA_W
  , parameter CSR_DATA_WIDTH       = 4*INFRA_AVST_DATA_W

  , parameter INSTANCE_NAME        = "u_fpga_demux"  //Can hold upto 16 ASCII characters
)(
  // inputs from the other FPGA
    inout                     [NUMBER_OF_INPUTS-1:0] inbus
  , input                                            clk_demux
  , input                                            rst_demux_n
  // demuxed outbus 
  , output  [(NUMBER_OF_INPUTS*MULTIPLEX_RATIO)-1:0] outbus
  // Infra-Avst Ports
  , input                                 clk_avst
  , input                                 rst_avst_n
  , output                                avst_ingr_ready
  , input                                 avst_ingr_valid
  , input                                 avst_ingr_startofpacket
  , input                                 avst_ingr_endofpacket
  , input  [INFRA_AVST_CHNNL_W-1:0]       avst_ingr_channel
  , input  [INFRA_AVST_DATA_W-1:0]        avst_ingr_data

  , input                                 avst_egr_ready
  , output                                avst_egr_valid
  , output                                avst_egr_startofpacket
  , output                                avst_egr_endofpacket
  , output [INFRA_AVST_CHNNL_W-1:0]       avst_egr_channel
  , output [INFRA_AVST_DATA_W-1:0]        avst_egr_data

);

    wire                                                   clk_to_ddr;
    wire                            [NUMBER_OF_INPUTS-1:0] q1_data;
    wire                            [NUMBER_OF_INPUTS-1:0] q2_data;
    reg                            [NUMBER_OF_INPUTS-1:0] q1_data_extra_Q;
    reg                            [NUMBER_OF_INPUTS-1:0] q2_data_extra_Q;
    reg [((NUMBER_OF_INPUTS*((MULTIPLEX_RATIO-2)/2))-1):0] q1_data_Q;
    reg [((NUMBER_OF_INPUTS*((MULTIPLEX_RATIO-2)/2))-1):0] q2_data_Q;

  genvar        s;
  localparam  STRATIX10_DEVICE_FAMILY  = "S10";
  wire                               csr_write;
  wire                               csr_read;
  wire [(3*INFRA_AVST_CHNNL_W)-1:0]  csr_addr;
  wire [(4*INFRA_AVST_DATA_W)-1:0]   csr_wr_data;
  reg  [(4*INFRA_AVST_DATA_W)-1:0]   csr_rd_data;
  reg                                csr_rd_valid;
  wire [31:0]                        params0_reg;
  integer n;
  reg  [0:15][7:0]                   inst_name_str = INSTANCE_NAME;


generate
     if (MULTIPLEX_RATIO == 4) begin
       
         assign clk_to_ddr = clk_demux;
         end

     else if ((MULTIPLEX_RATIO == 6) && (CLOCK_RATIO == 5)) begin  //   2 registers for each IO per D1/D2
       
         assign clk_to_ddr = clk_demux;
         end

     else if ((MULTIPLEX_RATIO == 6) && (CLOCK_RATIO == 4)) begin  //   2 registers for each IO per D1/D2
       
         assign clk_to_ddr = ~clk_demux;
         end

     else if ((MULTIPLEX_RATIO == 8) && (CLOCK_RATIO == 6)) begin  //   3 registers for each IO per D1/D2
       
         assign clk_to_ddr = clk_demux;
         end

     else if ((MULTIPLEX_RATIO == 14) && (CLOCK_RATIO == 8)) begin  //   6 registers for each IO per D1/D2
       
         assign clk_to_ddr = clk_demux;
         end

     else if ((MULTIPLEX_RATIO == 12) && (CLOCK_RATIO == 8)) begin  //   6 registers for each IO per D1/D2
       
         assign clk_to_ddr = clk_demux;
         end

     else if ((MULTIPLEX_RATIO == 20) && (CLOCK_RATIO == 12)) begin  // 10 registers for each IO per D1/D2
       
         assign clk_to_ddr = clk_demux;
         end

     else if ((MULTIPLEX_RATIO == 28) && (CLOCK_RATIO == 16)) begin  //  14 registers for each IO per D1/D2
       
         assign clk_to_ddr = clk_demux;
         end

     else if ((MULTIPLEX_RATIO == 36) && (CLOCK_RATIO == 20)) begin  //  18 registers for each IO per D1/D2
       
         assign clk_to_ddr = clk_demux;
         end

     else if ((MULTIPLEX_RATIO == 44) && (CLOCK_RATIO == 24)) begin  //  22 registers for each IO per D1/D2
       
         assign clk_to_ddr = clk_demux;
         end

     else if ((MULTIPLEX_RATIO == 52) && (CLOCK_RATIO == 28)) begin  // 26 registers for each IO per D1/D2
       
         assign clk_to_ddr = clk_demux;
         end

     else if ((MULTIPLEX_RATIO == 60) && (CLOCK_RATIO == 32)) begin  // 30 registers for each IO per D1/D2
       
         assign clk_to_ddr = clk_demux;
         end

     else if ((MULTIPLEX_RATIO == 68) && (CLOCK_RATIO == 36)) begin  // 34 registers for each IO per D1/D2
       
         assign clk_to_ddr = clk_demux;
         end

     else begin  // (MULTIPLEX_RATIO == 8)  4 registers for each IO per D1/D2
       
         assign clk_to_ddr = clk_demux;
         end
endgenerate


generate
 for (s=0; s < NUMBER_OF_INPUTS; s=s+1) begin: g_buffers
   
     if (MULTIPLEX_RATIO == 4) begin
       
         always @(posedge clk_demux) begin
             q1_data_Q[s] <= q1_data[s];
             q2_data_Q[s] <= q2_data[s];
             end

         assign outbus[(((s+1)*MULTIPLEX_RATIO)-1):(s*MULTIPLEX_RATIO)] = 
                    {q2_data_Q[s],
                     q1_data_Q[s],
                     q2_data[s],
                     q1_data[s]};
         end

     else if ((MULTIPLEX_RATIO == 6) && (CLOCK_RATIO == 5)) begin  //   2 registers for each IO per D1/D2
       
         always @(posedge clk_demux) begin
             q1_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-1):(s*((MULTIPLEX_RATIO-2)/2))] <=
               {q1_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-2):(s*((MULTIPLEX_RATIO-2)/2))],q1_data[s]};
             q2_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-1):(s*((MULTIPLEX_RATIO-2)/2))] <=
               {q2_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-2):(s*((MULTIPLEX_RATIO-2)/2))],q2_data[s]};
             end

         assign outbus[(((s+1)*MULTIPLEX_RATIO)-1):(s*MULTIPLEX_RATIO)] = 
                    {q2_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-1)],
                     q1_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-1)],
                     q2_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-2)],
                     q1_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-2)],
                     q2_data[s],
                     q1_data[s]};

         end

     else if ((MULTIPLEX_RATIO == 6) && (CLOCK_RATIO == 4)) begin  //   2 registers for each IO per D1/D2
       
         always @(posedge clk_demux) begin
             q1_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-1):(s*((MULTIPLEX_RATIO-2)/2))] <=
               // {q1_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-2):(s*((MULTIPLEX_RATIO-2)/2))],q1_data_extra_Q[s]};
               {q1_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-2):(s*((MULTIPLEX_RATIO-2)/2))],q1_data[s]};
             end

         always @(negedge clk_demux) begin
             q2_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-1):(s*((MULTIPLEX_RATIO-2)/2))] <=
               {q2_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-2):(s*((MULTIPLEX_RATIO-2)/2))],q2_data[s]};
             // q1_data_extra_Q[s] <= q1_data[s];
             end

//       assign outbus[(((s+1)*MULTIPLEX_RATIO)-1):(s*MULTIPLEX_RATIO)] = 
//                  {q1_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-1)],
//                   q2_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-1)],
//                   q1_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-2)],
//                   q2_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-2)],
//                   q1_data_extra_Q[s],
//                   q2_data[s]};

         assign outbus[(((s+1)*MULTIPLEX_RATIO)-1):(s*MULTIPLEX_RATIO)] = 
                    {q2_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-1)],
                     q1_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-1)],
                     q2_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-2)],
                     q1_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-2)],
                     q2_data[s],
                     q1_data[s]};

         end

     else if ((MULTIPLEX_RATIO == 14) && (CLOCK_RATIO == 8)) begin  //   6 registers for each IO per D1/D2
       
         always @(posedge clk_demux) begin
             q1_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-1):(s*((MULTIPLEX_RATIO-2)/2))] <=
               {q1_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-2):(s*((MULTIPLEX_RATIO-2)/2))],q1_data_extra_Q[s]};
             end

         always @(negedge clk_demux) begin
             q2_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-1):(s*((MULTIPLEX_RATIO-2)/2))] <=
               {q2_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-2):(s*((MULTIPLEX_RATIO-2)/2))],q2_data[s]};
             q1_data_extra_Q[s] <= q1_data[s];
             end

         assign outbus[(((s+1)*MULTIPLEX_RATIO)-1):(s*MULTIPLEX_RATIO)] = 
                    {q1_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-1)],
                     q2_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-1)],
                     q1_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-2)],
                     q2_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-2)],
                     q1_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-3)],
                     q2_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-3)],
                     q1_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-4)],
                     q2_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-4)],
                     q1_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-5)],
                     q2_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-5)],
                     q1_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-6)],
                     q2_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-6)],
                     q1_data_extra_Q[s],
                     q2_data[s]};

         end

     else if ((MULTIPLEX_RATIO == 12) && (CLOCK_RATIO == 8)) begin  //   6 registers for each IO per D1/D2
       
         // The first data is sent on the rising edge of the clock and captured on the
         // falling edge - so the order of returned data is with the q2 output being the
         // most significant:
         // edge  action
         //  0r    data output from functional flops
         //  1n    data captured in shift register
         //  2r    D0 tx
         //  3n    D1 tx   D0 rx
         //  4r    D2 tx   D1 rx    D0 in q2  D1 in q1
         //  5n    D3 tx   D2 rx    D0 in q2  D1 in q1   D1 put in q2 extra D0 put in q1 extra
         //  6r    D4 tx   D3 rx    D2 in q2  D3 in q1  
         //  7n    D5 tx   D4 rx    D2 in q2  D3 in q1   D3 put in q2 extra D2 put in q1 extra
         //  8r    D6 tx   D5 rx    D4 in q2  D5 in q1
         //  9n    D7 tx   D6 rx    D4 in q2  D5 in q1   D5 put in q2 extra D4 put in q1 extra
         // 10r    D8 tx   D7 rx    D6 in q2  D7 in q1
         // 11n    D9 tx   D8 rx    D6 in q2  D7 in q1   D7 put in q2 extra D6 put in q1 extra
         // 12r   D10 tx   D9 rx    D8 in q2  D9 in q1
         // 13n   D11 tx  D10 rx    D8 in q2  D9 in q1   D9 put in q2 extra D8 put in q1 extra
         // 14r     D tx  D11 rx    Da in q2  Db in q1
         // 15n     D tx   D2 rx    Da in q2  Db in q1   Db put in q2 extra Da put in q1 extra
         // 16r     D tx   D2 rx    D0 in q2  D1 in q1
         // change to update on the negative edge
         always @(negedge clk_demux) begin
             q1_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-1):(s*((MULTIPLEX_RATIO-2)/2))] <=
               {q1_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-2):(s*((MULTIPLEX_RATIO-2)/2))],q1_data_extra_Q[s]};
             q1_data_extra_Q[s] <= q2_data[s];
             end

         always @(negedge clk_demux) begin
             q2_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-1):(s*((MULTIPLEX_RATIO-2)/2))] <=
               {q2_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-2):(s*((MULTIPLEX_RATIO-2)/2))],q2_data_extra_Q[s]};
             q2_data_extra_Q[s] <= q1_data[s];
             end

         assign outbus[(((s+1)*MULTIPLEX_RATIO)-1):(s*MULTIPLEX_RATIO)] = 
                    {q1_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-1)],
                     q2_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-1)],
                     q1_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-2)],
                     q2_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-2)],
                     q1_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-3)],
                     q2_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-3)],
                     q1_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-4)],
                     q2_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-4)],
                     q1_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-5)],
                     q2_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-5)],
                     q1_data_extra_Q[s],
                     q2_data_extra_Q[s]};

         // OLD always @(posedge clk_demux) begin
         // OLD     q1_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-1):(s*((MULTIPLEX_RATIO-2)/2))] <=
         // OLD       {q1_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-2):(s*((MULTIPLEX_RATIO-2)/2))],q1_data_extra_Q[s]};
         // OLD     q1_data_extra_Q[s] <= q2_data[s];
         // OLD     end

         // OLD always @(negedge clk_demux) begin
         // OLD     q2_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-1):(s*((MULTIPLEX_RATIO-2)/2))] <=
         // OLD       {q2_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-2):(s*((MULTIPLEX_RATIO-2)/2))],q2_data_extra_Q[s]};
         // OLD     q2_data_extra_Q[s] <= q1_data[s];
         // OLD     end

         // OLD assign outbus[(((s+1)*MULTIPLEX_RATIO)-1):(s*MULTIPLEX_RATIO)] = 
         // OLD            {q1_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-1)],
         // OLD             q2_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-1)],
         // OLD             q1_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-2)],
         // OLD             q2_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-2)],
         // OLD             q1_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-3)],
         // OLD             q2_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-3)],
         // OLD             q1_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-4)],
         // OLD             q2_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-4)],
         // OLD             q1_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-5)],
         // OLD             q2_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-5)],
         // OLD             q1_data_extra_Q[s],
         // OLD             q2_data_extra_Q[s]};

         end

     else if ((MULTIPLEX_RATIO == 20) && (CLOCK_RATIO == 12)) begin  //   10 registers for each IO per D1/D2
         // Clock in data from DDR on falling edge, shift into other registers on rising edge
         // This was, application logic gets a full clock time of setup except for bits 1:0
         always @(posedge clk_demux) begin
             q1_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-1):(s*((MULTIPLEX_RATIO-2)/2))] <=
               {q1_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-2):(s*((MULTIPLEX_RATIO-2)/2))],q1_data_extra_Q[s]};
             q2_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-1):(s*((MULTIPLEX_RATIO-2)/2))] <=
               {q2_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-2):(s*((MULTIPLEX_RATIO-2)/2))],q2_data_extra_Q[s]};
             end

         always @(negedge clk_demux) begin
             q2_data_extra_Q[s] <= q1_data[s];
             q1_data_extra_Q[s] <= q2_data[s];
             end

         assign outbus[(((s+1)*MULTIPLEX_RATIO)-1):(s*MULTIPLEX_RATIO)] = 
                    {q1_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-1)],
                     q2_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-1)],
                     q1_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-2)],
                     q2_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-2)],
                     q1_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-3)],
                     q2_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-3)],
                     q1_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-4)],
                     q2_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-4)],
                     q1_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-5)],
                     q2_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-5)],
                     q1_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-6)],
                     q2_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-6)],
                     q1_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-7)],
                     q2_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-7)],
                     q1_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-8)],
                     q2_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-8)],
                     q1_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-9)],
                     q2_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-9)],
                     q1_data_extra_Q[s],
                     q2_data_extra_Q[s]};

         end

     else if ((MULTIPLEX_RATIO == 28) && (CLOCK_RATIO == 16)) begin  //   14 registers for each IO per D1/D2
         // Clock in data from DDR on falling edge, shift into other registers on rising edge
         // This was, application logic gets a full clock time of setup except for bits 1:0
         always @(posedge clk_demux) begin
             q1_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-1):(s*((MULTIPLEX_RATIO-2)/2))] <=
               {q1_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-2):(s*((MULTIPLEX_RATIO-2)/2))],q1_data_extra_Q[s]};
             q2_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-1):(s*((MULTIPLEX_RATIO-2)/2))] <=
               {q2_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-2):(s*((MULTIPLEX_RATIO-2)/2))],q2_data_extra_Q[s]};
             end

         always @(negedge clk_demux) begin
             q2_data_extra_Q[s] <= q1_data[s];
             q1_data_extra_Q[s] <= q2_data[s];
             end

         assign outbus[(((s+1)*MULTIPLEX_RATIO)-1):(s*MULTIPLEX_RATIO)] = 
                    {q1_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-1)],
                     q2_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-1)],
                     q1_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-2)],
                     q2_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-2)],
                     q1_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-3)],
                     q2_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-3)],
                     q1_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-4)],
                     q2_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-4)],
                     q1_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-5)],
                     q2_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-5)],
                     q1_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-6)],
                     q2_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-6)],
                     q1_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-7)],
                     q2_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-7)],
                     q1_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-8)],
                     q2_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-8)],
                     q1_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-9)],
                     q2_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-9)],
                     q1_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-10)],
                     q2_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-10)],
                     q1_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-11)],
                     q2_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-11)],
                     q1_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-12)],
                     q2_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-12)],
                     q1_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-13)],
                     q2_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-13)],
                     q1_data_extra_Q[s],
                     q2_data_extra_Q[s]};

         end

     else if ((MULTIPLEX_RATIO == 36) && (CLOCK_RATIO == 20)) begin  //   18 registers for each IO per D1/D2
         // Clock in data from DDR on falling edge, shift into other registers on rising edge
         // This was, application logic gets a full clock time of setup except for bits 1:0
         always @(posedge clk_demux) begin
             q1_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-1):(s*((MULTIPLEX_RATIO-2)/2))] <=
               {q1_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-2):(s*((MULTIPLEX_RATIO-2)/2))],q1_data_extra_Q[s]};
             q2_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-1):(s*((MULTIPLEX_RATIO-2)/2))] <=
               {q2_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-2):(s*((MULTIPLEX_RATIO-2)/2))],q2_data_extra_Q[s]};
             end

         always @(negedge clk_demux) begin
             q2_data_extra_Q[s] <= q1_data[s];
             q1_data_extra_Q[s] <= q2_data[s];
             end

         assign outbus[(((s+1)*MULTIPLEX_RATIO)-1):(s*MULTIPLEX_RATIO)] = 
                    {q1_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-1)],
                     q2_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-1)],
                     q1_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-2)],
                     q2_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-2)],
                     q1_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-3)],
                     q2_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-3)],
                     q1_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-4)],
                     q2_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-4)],
                     q1_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-5)],
                     q2_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-5)],
                     q1_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-6)],
                     q2_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-6)],
                     q1_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-7)],
                     q2_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-7)],
                     q1_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-8)],
                     q2_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-8)],
                     q1_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-9)],
                     q2_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-9)],
                     q1_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-10)],
                     q2_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-10)],
                     q1_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-11)],
                     q2_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-11)],
                     q1_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-12)],
                     q2_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-12)],
                     q1_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-13)],
                     q2_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-13)],
                     q1_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-14)],
                     q2_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-14)],
                     q1_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-15)],
                     q2_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-15)],
                     q1_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-16)],
                     q2_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-16)],
                     q1_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-17)],
                     q2_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-17)],
                     q1_data_extra_Q[s],
                     q2_data_extra_Q[s]};

         end

     else if ((MULTIPLEX_RATIO == 44) && (CLOCK_RATIO == 24)) begin  //   22 registers for each IO per D1/D2
         // Clock in data from DDR on falling edge, shift into other registers on rising edge
         // This was, application logic gets a full clock time of setup except for bits 1:0
         always @(posedge clk_demux) begin
             q1_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-1):(s*((MULTIPLEX_RATIO-2)/2))] <=
               {q1_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-2):(s*((MULTIPLEX_RATIO-2)/2))],q1_data_extra_Q[s]};
             q2_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-1):(s*((MULTIPLEX_RATIO-2)/2))] <=
               {q2_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-2):(s*((MULTIPLEX_RATIO-2)/2))],q2_data_extra_Q[s]};
             end

         always @(negedge clk_demux) begin
             q2_data_extra_Q[s] <= q1_data[s];
             q1_data_extra_Q[s] <= q2_data[s];
             end

         assign outbus[(((s+1)*MULTIPLEX_RATIO)-1):(s*MULTIPLEX_RATIO)] = 
                    {q1_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-1)],
                     q2_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-1)],
                     q1_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-2)],
                     q2_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-2)],
                     q1_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-3)],
                     q2_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-3)],
                     q1_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-4)],
                     q2_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-4)],
                     q1_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-5)],
                     q2_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-5)],
                     q1_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-6)],
                     q2_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-6)],
                     q1_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-7)],
                     q2_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-7)],
                     q1_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-8)],
                     q2_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-8)],
                     q1_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-9)],
                     q2_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-9)],
                     q1_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-10)],
                     q2_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-10)],
                     q1_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-11)],
                     q2_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-11)],
                     q1_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-12)],
                     q2_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-12)],
                     q1_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-13)],
                     q2_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-13)],
                     q1_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-14)],
                     q2_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-14)],
                     q1_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-15)],
                     q2_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-15)],
                     q1_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-16)],
                     q2_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-16)],
                     q1_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-17)],
                     q2_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-17)],
                     q1_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-18)],
                     q2_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-18)],
                     q1_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-19)],
                     q2_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-19)],
                     q1_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-20)],
                     q2_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-20)],
                     q1_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-21)],
                     q2_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-21)],
                     q1_data_extra_Q[s],
                     q2_data_extra_Q[s]};

         end

     else if ((MULTIPLEX_RATIO == 52) && (CLOCK_RATIO == 28)) begin  //   26 registers for each IO per D1/D2
         // Clock in data from DDR on falling edge, shift into other registers on rising edge
         // This was, application logic gets a full clock time of setup except for bits 1:0
         always @(posedge clk_demux) begin
             q1_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-1):(s*((MULTIPLEX_RATIO-2)/2))] <=
               {q1_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-2):(s*((MULTIPLEX_RATIO-2)/2))],q1_data_extra_Q[s]};
             q2_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-1):(s*((MULTIPLEX_RATIO-2)/2))] <=
               {q2_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-2):(s*((MULTIPLEX_RATIO-2)/2))],q2_data_extra_Q[s]};
             end

         always @(negedge clk_demux) begin
             q2_data_extra_Q[s] <= q1_data[s];
             q1_data_extra_Q[s] <= q2_data[s];
             end

         assign outbus[(((s+1)*MULTIPLEX_RATIO)-1):(s*MULTIPLEX_RATIO)] = 
                    {q1_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-1)],
                     q2_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-1)],
                     q1_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-2)],
                     q2_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-2)],
                     q1_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-3)],
                     q2_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-3)],
                     q1_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-4)],
                     q2_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-4)],
                     q1_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-5)],
                     q2_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-5)],
                     q1_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-6)],
                     q2_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-6)],
                     q1_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-7)],
                     q2_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-7)],
                     q1_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-8)],
                     q2_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-8)],
                     q1_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-9)],
                     q2_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-9)],
                     q1_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-10)],
                     q2_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-10)],
                     q1_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-11)],
                     q2_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-11)],
                     q1_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-12)],
                     q2_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-12)],
                     q1_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-13)],
                     q2_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-13)],
                     q1_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-14)],
                     q2_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-14)],
                     q1_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-15)],
                     q2_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-15)],
                     q1_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-16)],
                     q2_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-16)],
                     q1_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-17)],
                     q2_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-17)],
                     q1_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-18)],
                     q2_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-18)],
                     q1_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-19)],
                     q2_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-19)],
                     q1_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-20)],
                     q2_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-20)],
                     q1_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-21)],
                     q2_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-21)],
                     q1_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-22)],
                     q2_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-22)],
                     q1_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-23)],
                     q2_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-23)],
                     q1_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-24)],
                     q2_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-24)],
                     q1_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-25)],
                     q2_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-25)],
                     q1_data_extra_Q[s],
                     q2_data_extra_Q[s]};

         end

     else if ((MULTIPLEX_RATIO == 60) && (CLOCK_RATIO == 32)) begin  //   30 registers for each IO per D1/D2
         // Clock in data from DDR on falling edge, shift into other registers on rising edge
         // This was, application logic gets a full clock time of setup except for bits 1:0
         always @(posedge clk_demux) begin
             q1_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-1):(s*((MULTIPLEX_RATIO-2)/2))] <=
               {q1_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-2):(s*((MULTIPLEX_RATIO-2)/2))],q1_data_extra_Q[s]};
             q2_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-1):(s*((MULTIPLEX_RATIO-2)/2))] <=
               {q2_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-2):(s*((MULTIPLEX_RATIO-2)/2))],q2_data_extra_Q[s]};
             end

         always @(negedge clk_demux) begin
             q2_data_extra_Q[s] <= q1_data[s];
             q1_data_extra_Q[s] <= q2_data[s];
             end

         assign outbus[(((s+1)*MULTIPLEX_RATIO)-1):(s*MULTIPLEX_RATIO)] = 
                    {q1_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-1)],
                     q2_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-1)],
                     q1_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-2)],
                     q2_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-2)],
                     q1_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-3)],
                     q2_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-3)],
                     q1_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-4)],
                     q2_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-4)],
                     q1_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-5)],
                     q2_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-5)],
                     q1_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-6)],
                     q2_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-6)],
                     q1_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-7)],
                     q2_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-7)],
                     q1_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-8)],
                     q2_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-8)],
                     q1_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-9)],
                     q2_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-9)],
                     q1_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-10)],
                     q2_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-10)],
                     q1_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-11)],
                     q2_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-11)],
                     q1_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-12)],
                     q2_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-12)],
                     q1_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-13)],
                     q2_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-13)],
                     q1_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-14)],
                     q2_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-14)],
                     q1_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-15)],
                     q2_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-15)],
                     q1_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-16)],
                     q2_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-16)],
                     q1_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-17)],
                     q2_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-17)],
                     q1_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-18)],
                     q2_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-18)],
                     q1_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-19)],
                     q2_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-19)],
                     q1_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-20)],
                     q2_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-20)],
                     q1_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-21)],
                     q2_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-21)],
                     q1_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-22)],
                     q2_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-22)],
                     q1_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-23)],
                     q2_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-23)],
                     q1_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-24)],
                     q2_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-24)],
                     q1_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-25)],
                     q2_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-25)],
                     q1_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-26)],
                     q2_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-26)],
                     q1_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-27)],
                     q2_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-27)],
                     q1_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-28)],
                     q2_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-28)],
                     q1_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-29)],
                     q2_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-29)],
                     q1_data_extra_Q[s],
                     q2_data_extra_Q[s]};

         end

     else if ((MULTIPLEX_RATIO == 68) && (CLOCK_RATIO == 36)) begin  //   34 registers for each IO per D1/D2
         // Clock in data from DDR on falling edge, shift into other registers on rising edge
         // This was, application logic gets a full clock time of setup except for bits 1:0
         always @(posedge clk_demux) begin
             q1_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-1):(s*((MULTIPLEX_RATIO-2)/2))] <=
               {q1_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-2):(s*((MULTIPLEX_RATIO-2)/2))],q1_data_extra_Q[s]};
             q2_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-1):(s*((MULTIPLEX_RATIO-2)/2))] <=
               {q2_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-2):(s*((MULTIPLEX_RATIO-2)/2))],q2_data_extra_Q[s]};
             end

         always @(negedge clk_demux) begin
             q2_data_extra_Q[s] <= q1_data[s];
             q1_data_extra_Q[s] <= q2_data[s];
             end

         assign outbus[(((s+1)*MULTIPLEX_RATIO)-1):(s*MULTIPLEX_RATIO)] = 
                    {q1_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-1)],
                     q2_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-1)],
                     q1_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-2)],
                     q2_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-2)],
                     q1_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-3)],
                     q2_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-3)],
                     q1_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-4)],
                     q2_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-4)],
                     q1_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-5)],
                     q2_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-5)],
                     q1_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-6)],
                     q2_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-6)],
                     q1_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-7)],
                     q2_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-7)],
                     q1_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-8)],
                     q2_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-8)],
                     q1_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-9)],
                     q2_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-9)],
                     q1_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-10)],
                     q2_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-10)],
                     q1_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-11)],
                     q2_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-11)],
                     q1_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-12)],
                     q2_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-12)],
                     q1_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-13)],
                     q2_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-13)],
                     q1_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-14)],
                     q2_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-14)],
                     q1_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-15)],
                     q2_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-15)],
                     q1_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-16)],
                     q2_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-16)],
                     q1_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-17)],
                     q2_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-17)],
                     q1_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-18)],
                     q2_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-18)],
                     q1_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-19)],
                     q2_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-19)],
                     q1_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-20)],
                     q2_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-20)],
                     q1_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-21)],
                     q2_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-21)],
                     q1_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-22)],
                     q2_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-22)],
                     q1_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-23)],
                     q2_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-23)],
                     q1_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-24)],
                     q2_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-24)],
                     q1_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-25)],
                     q2_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-25)],
                     q1_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-26)],
                     q2_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-26)],
                     q1_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-27)],
                     q2_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-27)],
                     q1_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-28)],
                     q2_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-28)],
                     q1_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-29)],
                     q2_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-29)],
                     q1_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-30)],
                     q2_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-30)],
                     q1_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-31)],
                     q2_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-31)],
                     q1_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-32)],
                     q2_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-32)],
                     q1_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-33)],
                     q2_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-33)],
                     q1_data_extra_Q[s],
                     q2_data_extra_Q[s]};

         end

     else if ((MULTIPLEX_RATIO == 28) && (CLOCK_RATIO == 16)) begin  //  14 registers for each IO per D1/D2
       
         always @(posedge clk_demux) begin
             q1_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-1):(s*((MULTIPLEX_RATIO-2)/2))] <=
               {q1_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-2):(s*((MULTIPLEX_RATIO-2)/2))],q1_data_extra_Q[s]};
             q1_data_extra_Q[s] <= q2_data[s];
             end

         always @(negedge clk_demux) begin
             q2_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-1):(s*((MULTIPLEX_RATIO-2)/2))] <=
               {q2_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-2):(s*((MULTIPLEX_RATIO-2)/2))],q2_data_extra_Q[s]};
             q2_data_extra_Q[s] <= q1_data[s];
             end

         assign outbus[(((s+1)*MULTIPLEX_RATIO)-1):(s*MULTIPLEX_RATIO)] = 
                    {q1_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-1)],
                     q2_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-1)],
                     q1_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-2)],
                     q2_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-2)],
                     q1_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-3)],
                     q2_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-3)],
                     q1_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-4)],
                     q2_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-4)],
                     q1_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-5)],
                     q2_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-5)],
                     q1_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-6)],
                     q2_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-6)],
                     q1_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-7)],
                     q2_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-7)],
                     q1_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-8)],
                     q2_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-8)],
                     q1_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-9)],
                     q2_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-9)],
                     q1_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-10)],
                     q2_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-10)],
                     q1_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-11)],
                     q2_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-11)],
                     q1_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-12)],
                     q2_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-12)],
                     q1_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-13)],
                     q2_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-13)],
                     q1_data_extra_Q[s],
                     q2_data_extra_Q[s]};

         end

     else begin  // (MULTIPLEX_RATIO == 8)  3 registers for each IO per D1/D2
       
         always @(posedge clk_demux) begin
             q1_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-1):(s*((MULTIPLEX_RATIO-2)/2))] <=
               {q1_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-2):(s*((MULTIPLEX_RATIO-2)/2))],q1_data[s]};
             q2_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-1):(s*((MULTIPLEX_RATIO-2)/2))] <=
               {q2_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-2):(s*((MULTIPLEX_RATIO-2)/2))],q2_data[s]};
             end

         assign outbus[(((s+1)*MULTIPLEX_RATIO)-1):(s*MULTIPLEX_RATIO)] = 
                    {q2_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-1)],
                     q1_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-1)],
                     q2_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-2)],
                     q1_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-2)],
                     q2_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-3)],
                     q1_data_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-3)],
                     q2_data[s],
                     q1_data[s]};

         end

//begin: dd_io
      if(FPGA_FAMILY == STRATIX10_DEVICE_FAMILY)
      begin : s10
          fourteennm_ddio_in demux 
        (
            .clk(~clk_to_ddr),
            .areset(1'b0),
            .sreset(1'b0),
            .ena(1'b1),
            .datain(inbus[s]),
            .regouthi(q1_data[s]),
            .regoutlo(q2_data[s])
          );

          defparam demux.power_up = "low";
          defparam demux.async_mode = "none";
          defparam demux.sync_mode = "none";
          // this param change not working for clk inversion. clkn is also not connected.
          //defparam demux.use_clkn = "true";
          defparam demux.use_clkn = "false";
      end
      else
      begin : s5
       altddio_in      ALTDDIO_IN_component 
       (
          .aclr (1'b0),
          .datain (inbus[s]),
          .inclock (clk_to_ddr),
          .dataout_h (q1_data[s]),
          .dataout_l (q2_data[s]),
          .aset (1'b0),
          .inclocken (1'b1),
          .sclr (1'b0),
          .sset (1'b0)
      );
        defparam
                ALTDDIO_IN_component.intended_device_family = "Stratix IV",
                ALTDDIO_IN_component.invert_input_clocks = "OFF",
                ALTDDIO_IN_component.lpm_hint = "UNUSED",
                ALTDDIO_IN_component.lpm_type = "altddio_in",
                ALTDDIO_IN_component.power_up_high = "OFF",
                ALTDDIO_IN_component.width = 1;
      end

//end

   end // g_buffers

endgenerate

/* AVST2CSR instance  */
IW_fpga_avst2csr #(
      .AVST_CHANNEL_ID      (INFRA_AVST_CHNNL_ID)
     ,.AVST_CHANNEL_WIDTH   (INFRA_AVST_CHNNL_W)
     ,.AVST_DATA_WIDTH      (INFRA_AVST_DATA_W)
     ,.CSR_ADDR_WIDTH       (CSR_ADDR_WIDTH)
     ,.CSR_DATA_WIDTH       (CSR_DATA_WIDTH)
     ,.CMD_WIDTH            (1*INFRA_AVST_DATA_W)
   ) avst2csr (
     .clk_avst              (clk_avst                )
    ,.rst_avst_n            (rst_avst_n              )
    ,.avst_ingr_ready       (avst_ingr_ready         )
    ,.avst_ingr_valid       (avst_ingr_valid         )
    ,.avst_ingr_sop         (avst_ingr_startofpacket )
    ,.avst_ingr_eop         (avst_ingr_endofpacket   )
    ,.avst_ingr_channel     (avst_ingr_channel       )
    ,.avst_ingr_data        (avst_ingr_data          )
    ,.avst_egr_ready        (avst_egr_ready          )
    ,.avst_egr_valid        (avst_egr_valid          )
    ,.avst_egr_sop          (avst_egr_startofpacket  )
    ,.avst_egr_eop          (avst_egr_endofpacket    )
    ,.avst_egr_channel      (avst_egr_channel        )
    ,.avst_egr_data         (avst_egr_data           )
    ,.clk_csr               (clk_demux               )
    ,.rst_csr_n             (rst_demux_n             )
    ,.csr_write             (csr_write               )
    ,.csr_read              (csr_read                )
    ,.csr_addr              (csr_addr                )
    ,.csr_wr_data           (csr_wr_data             )
    ,.csr_rd_data           (csr_rd_data             )
    ,.csr_rd_valid          (csr_rd_valid            )
   );

  // Assigning params to register
  assign params0_reg = {NUMBER_OF_INPUTS[15:0],MULTIPLEX_RATIO[7:0],CLOCK_RATIO[7:0]};

  /* CSR reg read logic */
  always@(posedge clk_demux,  negedge rst_demux_n)
  begin
    if(~rst_demux_n)
    begin
      csr_rd_valid         <=  0;
      csr_rd_data          <=  0;
    end
    else
    begin
      /*  Read data Logic */
      case(csr_addr)
        0 : /* Instance name Reg0 */
        begin
          for (n=0;n<4;n++)
          begin
            csr_rd_data[(n*8) +: 8] <=  inst_name_str[15-n];
          end
        end
        4 : /*  Instance name Reg1 */
        begin
          for (n=0;n<4;n++)
          begin
            csr_rd_data[(n*8) +: 8] <=  inst_name_str[15-4-n];
          end
        end
        8 : /*  Instance name Reg2 */
        begin
          for (n=0;n<4;n++)
          begin
            csr_rd_data[(n*8) +: 8] <=  inst_name_str[15-8-n];
          end
        end
        12 : /*  Instance name Reg3 */
        begin
          for (n=0;n<4;n++)
          begin
            csr_rd_data[(n*8) +: 8] <=  inst_name_str[15-12-n];
          end
        end
        16 : /*  Params0 Reg */
        begin
          csr_rd_data         <=  params0_reg;
        end
        default :
        begin
          csr_rd_data         <=  'hdeadbabe;
        end
      endcase
      /*  Read data valid Logic */
      if(csr_read)
      begin
        csr_rd_valid       <=  1'b1;
      end
      else
      begin
        csr_rd_valid       <=  1'b0;
      end
    end
  end

endmodule
