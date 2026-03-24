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
// * File:      $RCSfile: IW_fpga_mux.sv.rca $
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


module IW_fpga_mux   #(
    parameter NUMBER_OF_OUTPUTS    = 5
  , parameter MULTIPLEX_RATIO      = 6
  , parameter CLOCK_RATIO          = 4
  , parameter FPGA_FAMILY          = "S5"
  , parameter INFRA_AVST_CHNNL_W   = 8
  , parameter INFRA_AVST_DATA_W    = 8
  , parameter INFRA_AVST_CHNNL_ID  = 8

  , parameter CSR_ADDR_WIDTH       = 3*INFRA_AVST_DATA_W
  , parameter CSR_DATA_WIDTH       = 4*INFRA_AVST_DATA_W

  , parameter INSTANCE_NAME        = "u_fpga_mux"  //Can hold upto 16 ASCII characters
)
(
  // inputs from the other FPGA
    input                      rst_mux_n     // 100 MHz mux logic reset
  , input                      clk_mux
  , input  [(NUMBER_OF_OUTPUTS*MULTIPLEX_RATIO)-1:0] inbus
  // muxed outbus
  , inout  [NUMBER_OF_OUTPUTS-1:0]                   outbus

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

`include "IW_logb2.svh"

    wire                        clk_to_ddr;
    reg [NUMBER_OF_OUTPUTS-1:0] outbus_Q;
    reg [NUMBER_OF_OUTPUTS-1:0] d1_data_D;
    reg [NUMBER_OF_OUTPUTS-1:0] d2_data_D;
    reg [(NUMBER_OF_OUTPUTS-1):0] d1_holding_extra_reg_Q;
    reg [(NUMBER_OF_OUTPUTS-1):0] d2_holding_extra_reg_Q;
    reg [((NUMBER_OF_OUTPUTS*((MULTIPLEX_RATIO-2)/2))-1):0] d1_holding_reg_Q;
    reg [((NUMBER_OF_OUTPUTS*((MULTIPLEX_RATIO-2)/2))-1):0] d2_holding_reg_Q;

  localparam  STRATIX10_DEVICE_FAMILY  = "S10";
  integer n;
  reg  [0:15][7:0]                   inst_name_str = INSTANCE_NAME;
  wire                               csr_write;
  wire                               csr_read;
  wire [(3*INFRA_AVST_CHNNL_W)-1:0]  csr_addr;
  wire [(4*INFRA_AVST_DATA_W)-1:0]   csr_wr_data;
  reg  [(4*INFRA_AVST_DATA_W)-1:0]   csr_rd_data;
  reg                                csr_rd_valid;
  wire [31:0]                        params_reg;


localparam STATE_WIDTH = (IW_logb2((CLOCK_RATIO-3)) + 2); // used for offset into cache line
   // reg [((CLOCK_RATIO/2)-1):0] statereg;
    reg [STATE_WIDTH-1:0] statereg;
// clock ratio   state reg width    needed  (log (CR-3) +1) + 1
//     4              2               2            2
//     8              4               4            4
//    12              6               5            5
//    32             16               6            6
// 4 to 1 clock ratio

generate
    if (CLOCK_RATIO == 4) begin
        logic [STATE_WIDTH-1:0]  MUX_HIGHDATA1 = 2'b00;
        logic [STATE_WIDTH-1:0]  MUX_NEXTDATA1 = 2'b10;
        logic [STATE_WIDTH-1:0]  MUX_LOWDATA   = 2'b11;
        logic [STATE_WIDTH-1:0]  MUX_HIGHDATA2 = 2'b01;
        // always @(negedge clk_mux or negedge rst_mux_n) begin
        always @(negedge clk_mux) begin    // only negedge for DDR 6:1 at 100 MHz
            if (!rst_mux_n) begin
                statereg  <= MUX_HIGHDATA1;
                end
            else begin
                case (statereg)   // synopsys full_case parallel_case
                    MUX_HIGHDATA1: statereg  <= MUX_NEXTDATA1;   // parallel capture
                    MUX_NEXTDATA1: statereg  <= MUX_LOWDATA;   // shifting
                    MUX_LOWDATA:   statereg  <= MUX_HIGHDATA2;   // doesn't matter
                    MUX_HIGHDATA2: statereg  <= MUX_HIGHDATA1;   // doesn't matter
                    endcase
                end
            end
        end
    else if (CLOCK_RATIO == 6) begin
        logic [STATE_WIDTH-1:0]  MUX_HIGHDATA1 = 3'b000;
        logic [STATE_WIDTH-1:0]  MUX_NEXTDATA1 = 3'b100;
        logic [STATE_WIDTH-1:0]  MUX_NEXTDATA2 = 3'b101;
        logic [STATE_WIDTH-1:0]  MUX_NEXTDATA3 = 3'b111;
        logic [STATE_WIDTH-1:0]  MUX_LOWDATA   = 3'b110;
        logic [STATE_WIDTH-1:0]  MUX_HIGHDATA2 = 3'b001;
        // always @(negedge clk_mux or negedge rst_mux_n) begin
        always @(negedge clk_mux) begin    // only negedge for DDR 6:1 at 100 MHz
            if (!rst_mux_n) begin
                statereg  <= MUX_HIGHDATA1;
                end
            else begin
                case (statereg)   // synopsys full_case parallel_case
                    MUX_HIGHDATA1: statereg  <= MUX_NEXTDATA1;   // parallel capture
                    MUX_NEXTDATA1: statereg  <= MUX_NEXTDATA2;   // shifting
                    MUX_NEXTDATA2: statereg  <= MUX_NEXTDATA3;
                    MUX_NEXTDATA3: statereg  <= MUX_LOWDATA;
                    MUX_LOWDATA:   statereg  <= MUX_HIGHDATA2;   // doesn't matter
                    MUX_HIGHDATA2: statereg  <= MUX_HIGHDATA1;   // doesn't matter
                    endcase
                end
            end
        end
    else if (CLOCK_RATIO == 8) begin
        logic [STATE_WIDTH-1:0]  MUX_HIGHDATA1 = 4'b0000;
        logic [STATE_WIDTH-1:0]  MUX_NEXTDATA1 = 4'b1000;
        logic [STATE_WIDTH-1:0]  MUX_NEXTDATA2 = 4'b1001;
        logic [STATE_WIDTH-1:0]  MUX_NEXTDATA3 = 4'b1010;
        logic [STATE_WIDTH-1:0]  MUX_NEXTDATA4 = 4'b1011;
        logic [STATE_WIDTH-1:0]  MUX_NEXTDATA5 = 4'b1100;
        logic [STATE_WIDTH-1:0]  MUX_LOWDATA   = 4'b1101;
        logic [STATE_WIDTH-1:0]  MUX_HIGHDATA2 = 4'b0001;
        // always @(negedge clk_mux or negedge rst_mux_n) begin
        always @(negedge clk_mux) begin    // only negedge for DDR 6:1 at 100 MHz
            if (!rst_mux_n) begin
                statereg  <= MUX_HIGHDATA1;
                end
            else begin
                case (statereg)   // synopsys full_case parallel_case
                    MUX_HIGHDATA1: statereg  <= MUX_NEXTDATA1;   // parallel capture
                    MUX_NEXTDATA1: statereg  <= MUX_NEXTDATA2;   // shifting
                    MUX_NEXTDATA2: statereg  <= MUX_NEXTDATA3;
                    MUX_NEXTDATA3: statereg  <= MUX_NEXTDATA4;
                    MUX_NEXTDATA4: statereg  <= MUX_NEXTDATA5;
                    MUX_NEXTDATA5: statereg  <= MUX_LOWDATA;
                    MUX_LOWDATA:   statereg  <= MUX_HIGHDATA2;   // doesn't matter
                    MUX_HIGHDATA2: statereg  <= MUX_HIGHDATA1;   // doesn't matter
                    endcase
                end
            end
        end
    else if (CLOCK_RATIO == 12) begin
        logic [STATE_WIDTH-1:0]  MUX_HIGHDATA1 = 5'b00000;
        logic [STATE_WIDTH-1:0]  MUX_NEXTDATA1 = 5'b10000;
        logic [STATE_WIDTH-1:0]  MUX_NEXTDATA2 = 5'b10001;
        logic [STATE_WIDTH-1:0]  MUX_NEXTDATA3 = 5'b10010;
        logic [STATE_WIDTH-1:0]  MUX_NEXTDATA4 = 5'b10011;
        logic [STATE_WIDTH-1:0]  MUX_NEXTDATA5 = 5'b10100;
        logic [STATE_WIDTH-1:0]  MUX_NEXTDATA6 = 5'b10101;
        logic [STATE_WIDTH-1:0]  MUX_NEXTDATA7 = 5'b10110;
        logic [STATE_WIDTH-1:0]  MUX_NEXTDATA8 = 5'b10111;
        logic [STATE_WIDTH-1:0]  MUX_NEXTDATA9 = 5'b11000;
        logic [STATE_WIDTH-1:0]  MUX_LOWDATA   = 5'b11001;
        logic [STATE_WIDTH-1:0]  MUX_HIGHDATA2 = 5'b00001;
        // always @(negedge clk_mux or negedge rst_mux_n) begin
        always @(posedge clk_mux) begin    // need to change at posedge for better load timing
            if (!rst_mux_n) begin
                statereg  <= MUX_HIGHDATA1;
                end
            else begin
                case (statereg)   // synopsys full_case parallel_case
                    MUX_HIGHDATA1: statereg  <= MUX_NEXTDATA1;   // parallel capture
                    MUX_NEXTDATA1: statereg  <= MUX_NEXTDATA2;   // shifting
                    MUX_NEXTDATA2: statereg  <= MUX_NEXTDATA3;
                    MUX_NEXTDATA3: statereg  <= MUX_NEXTDATA4;
                    MUX_NEXTDATA4: statereg  <= MUX_NEXTDATA5;
                    MUX_NEXTDATA5: statereg  <= MUX_NEXTDATA6;
                    MUX_NEXTDATA6: statereg  <= MUX_NEXTDATA7;
                    MUX_NEXTDATA7: statereg  <= MUX_NEXTDATA8;
                    MUX_NEXTDATA8: statereg  <= MUX_NEXTDATA9;
                    MUX_NEXTDATA9: statereg  <= MUX_LOWDATA;
                    MUX_LOWDATA:   statereg  <= MUX_HIGHDATA2;   // doesn't matter
                    MUX_HIGHDATA2: statereg  <= MUX_HIGHDATA1;   // doesn't matter
                    endcase
                end
            end
        end
    else if (CLOCK_RATIO == 16) begin
        logic [STATE_WIDTH-1:0]  MUX_HIGHDATA1 = 5'b00000;
        logic [STATE_WIDTH-1:0]  MUX_NEXTDATA1 = 5'b10000;
        logic [STATE_WIDTH-1:0]  MUX_NEXTDATA2 = 5'b10001;
        logic [STATE_WIDTH-1:0]  MUX_NEXTDATA3 = 5'b10010;
        logic [STATE_WIDTH-1:0]  MUX_NEXTDATA4 = 5'b10011;
        logic [STATE_WIDTH-1:0]  MUX_NEXTDATA5 = 5'b10100;
        logic [STATE_WIDTH-1:0]  MUX_NEXTDATA6 = 5'b10101;
        logic [STATE_WIDTH-1:0]  MUX_NEXTDATA7 = 5'b10110;
        logic [STATE_WIDTH-1:0]  MUX_NEXTDATA8 = 5'b10111;
        logic [STATE_WIDTH-1:0]  MUX_NEXTDATA9 = 5'b11000;
        logic [STATE_WIDTH-1:0]  MUX_NEXTDATA10 = 5'b11001;
        logic [STATE_WIDTH-1:0]  MUX_NEXTDATA11 = 5'b11010;
        logic [STATE_WIDTH-1:0]  MUX_NEXTDATA12 = 5'b11011;
        logic [STATE_WIDTH-1:0]  MUX_NEXTDATA13 = 5'b11100;
        logic [STATE_WIDTH-1:0]  MUX_LOWDATA   = 5'b11101;
        logic [STATE_WIDTH-1:0]  MUX_HIGHDATA2 = 5'b00001;
        // always @(negedge clk_mux or negedge rst_mux_n) begin
        always @(posedge clk_mux) begin    // need to change at posedge for better load timing
            if (!rst_mux_n) begin
                statereg  <= MUX_HIGHDATA1;
                end
            else begin
                case (statereg)   // synopsys full_case parallel_case
                    MUX_HIGHDATA1: statereg  <= MUX_NEXTDATA1;   // parallel capture
                    MUX_NEXTDATA1: statereg  <= MUX_NEXTDATA2;   // shifting
                    MUX_NEXTDATA2: statereg  <= MUX_NEXTDATA3;
                    MUX_NEXTDATA3: statereg  <= MUX_NEXTDATA4;
                    MUX_NEXTDATA4: statereg  <= MUX_NEXTDATA5;
                    MUX_NEXTDATA5: statereg  <= MUX_NEXTDATA6;
                    MUX_NEXTDATA6: statereg  <= MUX_NEXTDATA7;
                    MUX_NEXTDATA7: statereg  <= MUX_NEXTDATA8;
                    MUX_NEXTDATA8: statereg  <= MUX_NEXTDATA9;
                    MUX_NEXTDATA9: statereg  <= MUX_NEXTDATA10;
                    MUX_NEXTDATA10: statereg  <= MUX_NEXTDATA11;
                    MUX_NEXTDATA11: statereg  <= MUX_NEXTDATA12;
                    MUX_NEXTDATA12: statereg  <= MUX_NEXTDATA13;
                    MUX_NEXTDATA13: statereg  <= MUX_LOWDATA;
                    MUX_LOWDATA:   statereg  <= MUX_HIGHDATA2;   // doesn't matter
                    MUX_HIGHDATA2: statereg  <= MUX_HIGHDATA1;   // doesn't matter
                    endcase
                end
            end
        end
    else if (CLOCK_RATIO == 20) begin
        logic [STATE_WIDTH-1:0]  MUX_HIGHDATA1  = 6'b000000;
        logic [STATE_WIDTH-1:0]  MUX_NEXTDATA1  = 6'b100000;
        logic [STATE_WIDTH-1:0]  MUX_NEXTDATA2  = 6'b100001;
        logic [STATE_WIDTH-1:0]  MUX_NEXTDATA3  = 6'b100010;
        logic [STATE_WIDTH-1:0]  MUX_NEXTDATA4  = 6'b100011;
        logic [STATE_WIDTH-1:0]  MUX_NEXTDATA5  = 6'b100100;
        logic [STATE_WIDTH-1:0]  MUX_NEXTDATA6  = 6'b100101;
        logic [STATE_WIDTH-1:0]  MUX_NEXTDATA7  = 6'b100110;
        logic [STATE_WIDTH-1:0]  MUX_NEXTDATA8  = 6'b100111;
        logic [STATE_WIDTH-1:0]  MUX_NEXTDATA9  = 6'b101000;
        logic [STATE_WIDTH-1:0]  MUX_NEXTDATA10 = 6'b101001;
        logic [STATE_WIDTH-1:0]  MUX_NEXTDATA11 = 6'b101010;
        logic [STATE_WIDTH-1:0]  MUX_NEXTDATA12 = 6'b101011;
        logic [STATE_WIDTH-1:0]  MUX_NEXTDATA13 = 6'b101100;
        logic [STATE_WIDTH-1:0]  MUX_NEXTDATA14 = 6'b101101;
        logic [STATE_WIDTH-1:0]  MUX_NEXTDATA15 = 6'b101110;
        logic [STATE_WIDTH-1:0]  MUX_NEXTDATA16 = 6'b101111;
        logic [STATE_WIDTH-1:0]  MUX_NEXTDATA17 = 6'b110000;
        logic [STATE_WIDTH-1:0]  MUX_LOWDATA    = 6'b110001;
        logic [STATE_WIDTH-1:0]  MUX_HIGHDATA2  = 6'b000001;
        // always @(negedge clk_mux or negedge rst_mux_n) begin
        always @(posedge clk_mux) begin    // need to change at posedge for better load timing
            if (!rst_mux_n) begin
                statereg  <= MUX_HIGHDATA1;
                end
            else begin
                case (statereg)   // synopsys full_case parallel_case
                    MUX_HIGHDATA1: statereg  <= MUX_NEXTDATA1;   // parallel capture
                    MUX_NEXTDATA1: statereg  <= MUX_NEXTDATA2;   // shifting
                    MUX_NEXTDATA2: statereg  <= MUX_NEXTDATA3;
                    MUX_NEXTDATA3: statereg  <= MUX_NEXTDATA4;
                    MUX_NEXTDATA4: statereg  <= MUX_NEXTDATA5;
                    MUX_NEXTDATA5: statereg  <= MUX_NEXTDATA6;
                    MUX_NEXTDATA6: statereg  <= MUX_NEXTDATA7;
                    MUX_NEXTDATA7: statereg  <= MUX_NEXTDATA8;
                    MUX_NEXTDATA8: statereg  <= MUX_NEXTDATA9;
                    MUX_NEXTDATA9: statereg  <= MUX_NEXTDATA10;
                    MUX_NEXTDATA10: statereg  <= MUX_NEXTDATA11;
                    MUX_NEXTDATA11: statereg  <= MUX_NEXTDATA12;
                    MUX_NEXTDATA12: statereg  <= MUX_NEXTDATA13;
                    MUX_NEXTDATA13: statereg  <= MUX_NEXTDATA14;
                    MUX_NEXTDATA14: statereg  <= MUX_NEXTDATA15;
                    MUX_NEXTDATA15: statereg  <= MUX_NEXTDATA16;
                    MUX_NEXTDATA16: statereg  <= MUX_NEXTDATA17;
                    MUX_NEXTDATA17: statereg  <= MUX_LOWDATA;
                    MUX_LOWDATA:   statereg  <= MUX_HIGHDATA2;   // doesn't matter
                    MUX_HIGHDATA2: statereg  <= MUX_HIGHDATA1;   // doesn't matter
                    endcase
                end
            end
        end
     else if (CLOCK_RATIO == 24) begin
        logic [STATE_WIDTH-1:0]  MUX_HIGHDATA1  = 6'b000000;
        logic [STATE_WIDTH-1:0]  MUX_NEXTDATA1  = 6'b100000;
        logic [STATE_WIDTH-1:0]  MUX_NEXTDATA2  = 6'b100001;
        logic [STATE_WIDTH-1:0]  MUX_NEXTDATA3  = 6'b100010;
        logic [STATE_WIDTH-1:0]  MUX_NEXTDATA4  = 6'b100011;
        logic [STATE_WIDTH-1:0]  MUX_NEXTDATA5  = 6'b100100;
        logic [STATE_WIDTH-1:0]  MUX_NEXTDATA6  = 6'b100101;
        logic [STATE_WIDTH-1:0]  MUX_NEXTDATA7  = 6'b100110;
        logic [STATE_WIDTH-1:0]  MUX_NEXTDATA8  = 6'b100111;
        logic [STATE_WIDTH-1:0]  MUX_NEXTDATA9  = 6'b101000;
        logic [STATE_WIDTH-1:0]  MUX_NEXTDATA10 = 6'b101001;
        logic [STATE_WIDTH-1:0]  MUX_NEXTDATA11 = 6'b101010;
        logic [STATE_WIDTH-1:0]  MUX_NEXTDATA12 = 6'b101011;
        logic [STATE_WIDTH-1:0]  MUX_NEXTDATA13 = 6'b101100;
        logic [STATE_WIDTH-1:0]  MUX_NEXTDATA14 = 6'b101101;
        logic [STATE_WIDTH-1:0]  MUX_NEXTDATA15 = 6'b101110;
        logic [STATE_WIDTH-1:0]  MUX_NEXTDATA16 = 6'b101111;
        logic [STATE_WIDTH-1:0]  MUX_NEXTDATA17 = 6'b110000;
        logic [STATE_WIDTH-1:0]  MUX_NEXTDATA18 = 6'b110001;
        logic [STATE_WIDTH-1:0]  MUX_NEXTDATA19 = 6'b110010;
        logic [STATE_WIDTH-1:0]  MUX_NEXTDATA20 = 6'b110011;
        logic [STATE_WIDTH-1:0]  MUX_NEXTDATA21 = 6'b110100;
        logic [STATE_WIDTH-1:0]  MUX_LOWDATA    = 6'b110101;
        logic [STATE_WIDTH-1:0]  MUX_HIGHDATA2  = 6'b000001;
        // always @(negedge clk_mux or negedge rst_mux_n) begin
        always @(posedge clk_mux) begin    // need to change at posedge for better load timing
            if (!rst_mux_n) begin
                statereg  <= MUX_HIGHDATA1;
                end
            else begin
                case (statereg)   // synopsys full_case parallel_case
                    MUX_HIGHDATA1: statereg  <= MUX_NEXTDATA1;   // parallel capture
                    MUX_NEXTDATA1: statereg  <= MUX_NEXTDATA2;   // shifting
                    MUX_NEXTDATA2: statereg  <= MUX_NEXTDATA3;
                    MUX_NEXTDATA3: statereg  <= MUX_NEXTDATA4;
                    MUX_NEXTDATA4: statereg  <= MUX_NEXTDATA5;
                    MUX_NEXTDATA5: statereg  <= MUX_NEXTDATA6;
                    MUX_NEXTDATA6: statereg  <= MUX_NEXTDATA7;
                    MUX_NEXTDATA7: statereg  <= MUX_NEXTDATA8;
                    MUX_NEXTDATA8: statereg  <= MUX_NEXTDATA9;
                    MUX_NEXTDATA9: statereg  <= MUX_NEXTDATA10;
                    MUX_NEXTDATA10: statereg  <= MUX_NEXTDATA11;
                    MUX_NEXTDATA11: statereg  <= MUX_NEXTDATA12;
                    MUX_NEXTDATA12: statereg  <= MUX_NEXTDATA13;
                    MUX_NEXTDATA13: statereg  <= MUX_NEXTDATA14;
                    MUX_NEXTDATA14: statereg  <= MUX_NEXTDATA15;
                    MUX_NEXTDATA15: statereg  <= MUX_NEXTDATA16;
                    MUX_NEXTDATA16: statereg  <= MUX_NEXTDATA17;
                    MUX_NEXTDATA17: statereg  <= MUX_NEXTDATA18;
                    MUX_NEXTDATA18: statereg  <= MUX_NEXTDATA19;
                    MUX_NEXTDATA19: statereg  <= MUX_NEXTDATA20;
                    MUX_NEXTDATA20: statereg  <= MUX_NEXTDATA21;
                    MUX_NEXTDATA21: statereg  <= MUX_LOWDATA;
                    MUX_LOWDATA:   statereg  <= MUX_HIGHDATA2;   // doesn't matter
                    MUX_HIGHDATA2: statereg  <= MUX_HIGHDATA1;   // doesn't matter
                    endcase
                end
            end
        end
    else if (CLOCK_RATIO == 28) begin
        logic [STATE_WIDTH-1:0]  MUX_HIGHDATA1  = 6'b000000;
        logic [STATE_WIDTH-1:0]  MUX_NEXTDATA1  = 6'b100000;
        logic [STATE_WIDTH-1:0]  MUX_NEXTDATA2  = 6'b100001;
        logic [STATE_WIDTH-1:0]  MUX_NEXTDATA3  = 6'b100010;
        logic [STATE_WIDTH-1:0]  MUX_NEXTDATA4  = 6'b100011;
        logic [STATE_WIDTH-1:0]  MUX_NEXTDATA5  = 6'b100100;
        logic [STATE_WIDTH-1:0]  MUX_NEXTDATA6  = 6'b100101;
        logic [STATE_WIDTH-1:0]  MUX_NEXTDATA7  = 6'b100110;
        logic [STATE_WIDTH-1:0]  MUX_NEXTDATA8  = 6'b100111;
        logic [STATE_WIDTH-1:0]  MUX_NEXTDATA9  = 6'b101000;
        logic [STATE_WIDTH-1:0]  MUX_NEXTDATA10 = 6'b101001;
        logic [STATE_WIDTH-1:0]  MUX_NEXTDATA11 = 6'b101010;
        logic [STATE_WIDTH-1:0]  MUX_NEXTDATA12 = 6'b101011;
        logic [STATE_WIDTH-1:0]  MUX_NEXTDATA13 = 6'b101100;
        logic [STATE_WIDTH-1:0]  MUX_NEXTDATA14 = 6'b101101;
        logic [STATE_WIDTH-1:0]  MUX_NEXTDATA15 = 6'b101110;
        logic [STATE_WIDTH-1:0]  MUX_NEXTDATA16 = 6'b101111;
        logic [STATE_WIDTH-1:0]  MUX_NEXTDATA17 = 6'b110000;
        logic [STATE_WIDTH-1:0]  MUX_NEXTDATA18 = 6'b110001;
        logic [STATE_WIDTH-1:0]  MUX_NEXTDATA19 = 6'b110010;
        logic [STATE_WIDTH-1:0]  MUX_NEXTDATA20 = 6'b110011;
        logic [STATE_WIDTH-1:0]  MUX_NEXTDATA21 = 6'b110100;
        logic [STATE_WIDTH-1:0]  MUX_NEXTDATA22 = 6'b110101;
        logic [STATE_WIDTH-1:0]  MUX_NEXTDATA23 = 6'b110110;
        logic [STATE_WIDTH-1:0]  MUX_NEXTDATA24 = 6'b110111;
        logic [STATE_WIDTH-1:0]  MUX_NEXTDATA25 = 6'b111000;
        logic [STATE_WIDTH-1:0]  MUX_LOWDATA    = 6'b111001;
        logic [STATE_WIDTH-1:0]  MUX_HIGHDATA2  = 6'b000001;
        // always @(negedge clk_mux or negedge rst_mux_n) begin
        always @(posedge clk_mux) begin    // need to change at posedge for better load timing
            if (!rst_mux_n) begin
                statereg  <= MUX_HIGHDATA1;
                end
            else begin
                case (statereg)   // synopsys full_case parallel_case
                    MUX_HIGHDATA1:  statereg  <= MUX_NEXTDATA1;   // parallel capture
                    MUX_NEXTDATA1:  statereg  <= MUX_NEXTDATA2;   // shifting
                    MUX_NEXTDATA2:  statereg  <= MUX_NEXTDATA3;
                    MUX_NEXTDATA3:  statereg  <= MUX_NEXTDATA4;
                    MUX_NEXTDATA4:  statereg  <= MUX_NEXTDATA5;
                    MUX_NEXTDATA5:  statereg  <= MUX_NEXTDATA6;
                    MUX_NEXTDATA6:  statereg  <= MUX_NEXTDATA7;
                    MUX_NEXTDATA7:  statereg  <= MUX_NEXTDATA8;
                    MUX_NEXTDATA8:  statereg  <= MUX_NEXTDATA9;
                    MUX_NEXTDATA9:  statereg  <= MUX_NEXTDATA10;
                    MUX_NEXTDATA10: statereg  <= MUX_NEXTDATA11;
                    MUX_NEXTDATA11: statereg  <= MUX_NEXTDATA12;
                    MUX_NEXTDATA12: statereg  <= MUX_NEXTDATA13;
                    MUX_NEXTDATA13: statereg  <= MUX_NEXTDATA14;
                    MUX_NEXTDATA14: statereg  <= MUX_NEXTDATA15;
                    MUX_NEXTDATA15: statereg  <= MUX_NEXTDATA16;
                    MUX_NEXTDATA16: statereg  <= MUX_NEXTDATA17;
                    MUX_NEXTDATA17: statereg  <= MUX_NEXTDATA18;
                    MUX_NEXTDATA18: statereg  <= MUX_NEXTDATA19;
                    MUX_NEXTDATA19: statereg  <= MUX_NEXTDATA20;
                    MUX_NEXTDATA20: statereg  <= MUX_NEXTDATA21;
                    MUX_NEXTDATA21: statereg  <= MUX_NEXTDATA22;
                    MUX_NEXTDATA22: statereg  <= MUX_NEXTDATA23;
                    MUX_NEXTDATA23: statereg  <= MUX_NEXTDATA24;
                    MUX_NEXTDATA24: statereg  <= MUX_NEXTDATA25;
                    MUX_NEXTDATA25: statereg  <= MUX_LOWDATA;
                    MUX_LOWDATA:    statereg  <= MUX_HIGHDATA2;   // doesn't matter
                    MUX_HIGHDATA2:  statereg  <= MUX_HIGHDATA1;   // doesn't matter
                    endcase
                end
            end
        end
    else if (CLOCK_RATIO == 32) begin
        logic [STATE_WIDTH-1:0]  MUX_HIGHDATA1  = 6'b000000;
        logic [STATE_WIDTH-1:0]  MUX_NEXTDATA1  = 6'b100000;
        logic [STATE_WIDTH-1:0]  MUX_NEXTDATA2  = 6'b100001;
        logic [STATE_WIDTH-1:0]  MUX_NEXTDATA3  = 6'b100010;
        logic [STATE_WIDTH-1:0]  MUX_NEXTDATA4  = 6'b100011;
        logic [STATE_WIDTH-1:0]  MUX_NEXTDATA5  = 6'b100100;
        logic [STATE_WIDTH-1:0]  MUX_NEXTDATA6  = 6'b100101;
        logic [STATE_WIDTH-1:0]  MUX_NEXTDATA7  = 6'b100110;
        logic [STATE_WIDTH-1:0]  MUX_NEXTDATA8  = 6'b100111;
        logic [STATE_WIDTH-1:0]  MUX_NEXTDATA9  = 6'b101000;
        logic [STATE_WIDTH-1:0]  MUX_NEXTDATA10 = 6'b101001;
        logic [STATE_WIDTH-1:0]  MUX_NEXTDATA11 = 6'b101010;
        logic [STATE_WIDTH-1:0]  MUX_NEXTDATA12 = 6'b101011;
        logic [STATE_WIDTH-1:0]  MUX_NEXTDATA13 = 6'b101100;
        logic [STATE_WIDTH-1:0]  MUX_NEXTDATA14 = 6'b101101;
        logic [STATE_WIDTH-1:0]  MUX_NEXTDATA15 = 6'b101110;
        logic [STATE_WIDTH-1:0]  MUX_NEXTDATA16 = 6'b101111;
        logic [STATE_WIDTH-1:0]  MUX_NEXTDATA17 = 6'b110000;
        logic [STATE_WIDTH-1:0]  MUX_NEXTDATA18 = 6'b110001;
        logic [STATE_WIDTH-1:0]  MUX_NEXTDATA19 = 6'b110010;
        logic [STATE_WIDTH-1:0]  MUX_NEXTDATA20 = 6'b110011;
        logic [STATE_WIDTH-1:0]  MUX_NEXTDATA21 = 6'b110100;
        logic [STATE_WIDTH-1:0]  MUX_NEXTDATA22 = 6'b110101;
        logic [STATE_WIDTH-1:0]  MUX_NEXTDATA23 = 6'b110110;
        logic [STATE_WIDTH-1:0]  MUX_NEXTDATA24 = 6'b110111;
        logic [STATE_WIDTH-1:0]  MUX_NEXTDATA25 = 6'b111000;
        logic [STATE_WIDTH-1:0]  MUX_NEXTDATA26 = 6'b111001;
        logic [STATE_WIDTH-1:0]  MUX_NEXTDATA27 = 6'b111010;
        logic [STATE_WIDTH-1:0]  MUX_NEXTDATA28 = 6'b111011;
        logic [STATE_WIDTH-1:0]  MUX_NEXTDATA29 = 6'b111100;
        logic [STATE_WIDTH-1:0]  MUX_LOWDATA    = 6'b111101;
        logic [STATE_WIDTH-1:0]  MUX_HIGHDATA2  = 6'b000001;
        // always @(negedge clk_mux or negedge rst_mux_n) begin
        always @(posedge clk_mux) begin    // need to change at posedge for better load timing
            if (!rst_mux_n) begin
                statereg  <= MUX_HIGHDATA1;
                end
            else begin
                case (statereg)   // synopsys full_case parallel_case
                    MUX_HIGHDATA1:  statereg  <= MUX_NEXTDATA1;   // parallel capture
                    MUX_NEXTDATA1:  statereg  <= MUX_NEXTDATA2;   // shifting
                    MUX_NEXTDATA2:  statereg  <= MUX_NEXTDATA3;
                    MUX_NEXTDATA3:  statereg  <= MUX_NEXTDATA4;
                    MUX_NEXTDATA4:  statereg  <= MUX_NEXTDATA5;
                    MUX_NEXTDATA5:  statereg  <= MUX_NEXTDATA6;
                    MUX_NEXTDATA6:  statereg  <= MUX_NEXTDATA7;
                    MUX_NEXTDATA7:  statereg  <= MUX_NEXTDATA8;
                    MUX_NEXTDATA8:  statereg  <= MUX_NEXTDATA9;
                    MUX_NEXTDATA9:  statereg  <= MUX_NEXTDATA10;
                    MUX_NEXTDATA10: statereg  <= MUX_NEXTDATA11;
                    MUX_NEXTDATA11: statereg  <= MUX_NEXTDATA12;
                    MUX_NEXTDATA12: statereg  <= MUX_NEXTDATA13;
                    MUX_NEXTDATA13: statereg  <= MUX_NEXTDATA14;
                    MUX_NEXTDATA14: statereg  <= MUX_NEXTDATA15;
                    MUX_NEXTDATA15: statereg  <= MUX_NEXTDATA16;
                    MUX_NEXTDATA16: statereg  <= MUX_NEXTDATA17;
                    MUX_NEXTDATA17: statereg  <= MUX_NEXTDATA18;
                    MUX_NEXTDATA18: statereg  <= MUX_NEXTDATA19;
                    MUX_NEXTDATA19: statereg  <= MUX_NEXTDATA20;
                    MUX_NEXTDATA20: statereg  <= MUX_NEXTDATA21;
                    MUX_NEXTDATA21: statereg  <= MUX_NEXTDATA22;
                    MUX_NEXTDATA22: statereg  <= MUX_NEXTDATA23;
                    MUX_NEXTDATA23: statereg  <= MUX_NEXTDATA24;
                    MUX_NEXTDATA24: statereg  <= MUX_NEXTDATA25;
                    MUX_NEXTDATA25: statereg  <= MUX_NEXTDATA26;
                    MUX_NEXTDATA26: statereg  <= MUX_NEXTDATA27;
                    MUX_NEXTDATA27: statereg  <= MUX_NEXTDATA28;
                    MUX_NEXTDATA28: statereg  <= MUX_NEXTDATA29;
                    MUX_NEXTDATA29: statereg  <= MUX_LOWDATA;
                    MUX_LOWDATA:    statereg  <= MUX_HIGHDATA2;   // doesn't matter
                    MUX_HIGHDATA2:  statereg  <= MUX_HIGHDATA1;   // doesn't matter
                    endcase
                end
            end
        end
    else begin  // assume clock ratio is 36
        logic [STATE_WIDTH-1:0]  MUX_HIGHDATA1  = 7'b0000000;
        logic [STATE_WIDTH-1:0]  MUX_NEXTDATA1  = 7'b1000000;
        logic [STATE_WIDTH-1:0]  MUX_NEXTDATA2  = 7'b1000001;
        logic [STATE_WIDTH-1:0]  MUX_NEXTDATA3  = 7'b1000010;
        logic [STATE_WIDTH-1:0]  MUX_NEXTDATA4  = 7'b1000011;
        logic [STATE_WIDTH-1:0]  MUX_NEXTDATA5  = 7'b1000100;
        logic [STATE_WIDTH-1:0]  MUX_NEXTDATA6  = 7'b1000101;
        logic [STATE_WIDTH-1:0]  MUX_NEXTDATA7  = 7'b1000110;
        logic [STATE_WIDTH-1:0]  MUX_NEXTDATA8  = 7'b1000111;
        logic [STATE_WIDTH-1:0]  MUX_NEXTDATA9  = 7'b1001000;
        logic [STATE_WIDTH-1:0]  MUX_NEXTDATA10 = 7'b1001001;
        logic [STATE_WIDTH-1:0]  MUX_NEXTDATA11 = 7'b1001010;
        logic [STATE_WIDTH-1:0]  MUX_NEXTDATA12 = 7'b1001011;
        logic [STATE_WIDTH-1:0]  MUX_NEXTDATA13 = 7'b1001100;
        logic [STATE_WIDTH-1:0]  MUX_NEXTDATA14 = 7'b1001101;
        logic [STATE_WIDTH-1:0]  MUX_NEXTDATA15 = 7'b1001110;
        logic [STATE_WIDTH-1:0]  MUX_NEXTDATA16 = 7'b1001111;
        logic [STATE_WIDTH-1:0]  MUX_NEXTDATA17 = 7'b1010000;
        logic [STATE_WIDTH-1:0]  MUX_NEXTDATA18 = 7'b1010001;
        logic [STATE_WIDTH-1:0]  MUX_NEXTDATA19 = 7'b1010010;
        logic [STATE_WIDTH-1:0]  MUX_NEXTDATA20 = 7'b1010011;
        logic [STATE_WIDTH-1:0]  MUX_NEXTDATA21 = 7'b1010100;
        logic [STATE_WIDTH-1:0]  MUX_NEXTDATA22 = 7'b1010101;
        logic [STATE_WIDTH-1:0]  MUX_NEXTDATA23 = 7'b1010110;
        logic [STATE_WIDTH-1:0]  MUX_NEXTDATA24 = 7'b1010111;
        logic [STATE_WIDTH-1:0]  MUX_NEXTDATA25 = 7'b1011000;
        logic [STATE_WIDTH-1:0]  MUX_NEXTDATA26 = 7'b1011001;
        logic [STATE_WIDTH-1:0]  MUX_NEXTDATA27 = 7'b1011010;
        logic [STATE_WIDTH-1:0]  MUX_NEXTDATA28 = 7'b1011011;
        logic [STATE_WIDTH-1:0]  MUX_NEXTDATA29 = 7'b1011100;
        logic [STATE_WIDTH-1:0]  MUX_NEXTDATA30 = 7'b1011101;
        logic [STATE_WIDTH-1:0]  MUX_NEXTDATA31 = 7'b1011110;
        logic [STATE_WIDTH-1:0]  MUX_NEXTDATA32 = 7'b1011111;
        logic [STATE_WIDTH-1:0]  MUX_NEXTDATA33 = 7'b1100000;
        logic [STATE_WIDTH-1:0]  MUX_LOWDATA    = 7'b1100001;
        logic [STATE_WIDTH-1:0]  MUX_HIGHDATA2  = 7'b0000001;
        // always @(negedge clk_mux or negedge rst_mux_n) begin
        always @(posedge clk_mux) begin    // need to change at posedge for better load timing
            if (!rst_mux_n) begin
                statereg  <= MUX_HIGHDATA1;
                end
            else begin
                case (statereg)   // synopsys full_case parallel_case
                    MUX_HIGHDATA1:  statereg  <= MUX_NEXTDATA1;   // parallel capture
                    MUX_NEXTDATA1:  statereg  <= MUX_NEXTDATA2;   // shifting
                    MUX_NEXTDATA2:  statereg  <= MUX_NEXTDATA3;
                    MUX_NEXTDATA3:  statereg  <= MUX_NEXTDATA4;
                    MUX_NEXTDATA4:  statereg  <= MUX_NEXTDATA5;
                    MUX_NEXTDATA5:  statereg  <= MUX_NEXTDATA6;
                    MUX_NEXTDATA6:  statereg  <= MUX_NEXTDATA7;
                    MUX_NEXTDATA7:  statereg  <= MUX_NEXTDATA8;
                    MUX_NEXTDATA8:  statereg  <= MUX_NEXTDATA9;
                    MUX_NEXTDATA9:  statereg  <= MUX_NEXTDATA10;
                    MUX_NEXTDATA10: statereg  <= MUX_NEXTDATA11;
                    MUX_NEXTDATA11: statereg  <= MUX_NEXTDATA12;
                    MUX_NEXTDATA12: statereg  <= MUX_NEXTDATA13;
                    MUX_NEXTDATA13: statereg  <= MUX_NEXTDATA14;
                    MUX_NEXTDATA14: statereg  <= MUX_NEXTDATA15;
                    MUX_NEXTDATA15: statereg  <= MUX_NEXTDATA16;
                    MUX_NEXTDATA16: statereg  <= MUX_NEXTDATA17;
                    MUX_NEXTDATA17: statereg  <= MUX_NEXTDATA18;
                    MUX_NEXTDATA18: statereg  <= MUX_NEXTDATA19;
                    MUX_NEXTDATA19: statereg  <= MUX_NEXTDATA20;
                    MUX_NEXTDATA20: statereg  <= MUX_NEXTDATA21;
                    MUX_NEXTDATA21: statereg  <= MUX_NEXTDATA22;
                    MUX_NEXTDATA22: statereg  <= MUX_NEXTDATA23;
                    MUX_NEXTDATA23: statereg  <= MUX_NEXTDATA24;
                    MUX_NEXTDATA24: statereg  <= MUX_NEXTDATA25;
                    MUX_NEXTDATA25: statereg  <= MUX_NEXTDATA26;
                    MUX_NEXTDATA26: statereg  <= MUX_NEXTDATA27;
                    MUX_NEXTDATA27: statereg  <= MUX_NEXTDATA28;
                    MUX_NEXTDATA28: statereg  <= MUX_NEXTDATA29;
                    MUX_NEXTDATA29: statereg  <= MUX_NEXTDATA30;
                    MUX_NEXTDATA30: statereg  <= MUX_NEXTDATA31;
                    MUX_NEXTDATA31: statereg  <= MUX_NEXTDATA32;
                    MUX_NEXTDATA32: statereg  <= MUX_NEXTDATA33;
                    MUX_NEXTDATA33: statereg  <= MUX_LOWDATA;
                    MUX_LOWDATA:    statereg  <= MUX_HIGHDATA2;   // doesn't matter
                    MUX_HIGHDATA2:  statereg  <= MUX_HIGHDATA1;   // doesn't matter
                    endcase
                end
            end
        end
endgenerate


genvar  s,c;

generate

     if (MULTIPLEX_RATIO == 4) begin
         assign clk_to_ddr = clk_mux;
         end

     else if ((MULTIPLEX_RATIO == 6) && (CLOCK_RATIO == 5)) begin  //   2 registers for each IO per D1/D2
         assign clk_to_ddr = clk_mux;
         end

     else if ((MULTIPLEX_RATIO == 6) && (CLOCK_RATIO == 4)) begin  //   2 registers for each IO per D1/D2
         assign clk_to_ddr = ~clk_mux;
         end
     else if ((MULTIPLEX_RATIO == 8) && (CLOCK_RATIO == 6)) begin  //   2 registers for each IO per D1/D2
         assign clk_to_ddr = clk_mux;
         end
     else if ((MULTIPLEX_RATIO == 14) && (CLOCK_RATIO == 8)) begin  //   6 registers for each IO per D1/D2
         assign clk_to_ddr = clk_mux;
         end
     else if ((MULTIPLEX_RATIO == 12) && (CLOCK_RATIO == 8)) begin  //   6 registers for each IO per D1/D2
         assign clk_to_ddr = clk_mux;
         end
     else if ((MULTIPLEX_RATIO == 20) && (CLOCK_RATIO == 12)) begin  //  10 registers for each IO per D1/D2
         assign clk_to_ddr = clk_mux;
         end
     else if ((MULTIPLEX_RATIO == 28) && (CLOCK_RATIO == 16)) begin  //  14 registers for each IO per D1/D2
         assign clk_to_ddr = clk_mux;
         end
     else if ((MULTIPLEX_RATIO == 36) && (CLOCK_RATIO == 20)) begin  //  18 registers for each IO per D1/D2
         assign clk_to_ddr = clk_mux;
         end
     else if ((MULTIPLEX_RATIO == 44) && (CLOCK_RATIO == 24)) begin  //  22 registers for each IO per D1/D2
         assign clk_to_ddr = clk_mux;
         end
     else if ((MULTIPLEX_RATIO == 52) && (CLOCK_RATIO == 28)) begin  //  26 registers for each IO per D1/D2
         assign clk_to_ddr = clk_mux;
         end
     else if ((MULTIPLEX_RATIO == 60) && (CLOCK_RATIO == 32)) begin  //  30 registers for each IO per D1/D2
         assign clk_to_ddr = clk_mux;
         end
     else if ((MULTIPLEX_RATIO == 68) && (CLOCK_RATIO == 36)) begin  //  34 registers for each IO per D1/D2
         assign clk_to_ddr = clk_mux;
         end
     else begin  // (MULTIPLEX_RATIO == 8)  3 registers for each IO per D1/D2
         assign clk_to_ddr = clk_mux;
         end
endgenerate



generate
 for (s=0; s < NUMBER_OF_OUTPUTS; s=s+1) begin: g_buffers

     if (MULTIPLEX_RATIO == 4) begin
         always @(posedge clk_mux) begin
             casex (statereg)     // synopsys parallel_case 
                 2'b0x: begin    // parallel load
                     d1_holding_reg_Q[s] <= inbus[((s+1)*MULTIPLEX_RATIO)-3];
                     d2_holding_reg_Q[s] <= inbus[((s+1)*MULTIPLEX_RATIO)-4];
                     end
                 default: begin  // left shift
                     d1_holding_reg_Q[s] <= 1'b0;
                     d2_holding_reg_Q[s] <= 1'b0;
                     end
                 endcase
             end

         always @ (*) begin
             casex (statereg)     // synopsys parallel_case 
                 2'b0x: begin    // first sample going out
                     d1_data_D[s] = inbus[((s+1)*MULTIPLEX_RATIO)-1];
                     d2_data_D[s] = inbus[((s+1)*MULTIPLEX_RATIO)-2];
                     end
                 default: begin  // left shift
                     d1_data_D[s] = d1_holding_reg_Q[s];
                     d2_data_D[s] = d2_holding_reg_Q[s];
                     end
                 endcase
             end

         end

     else if ((MULTIPLEX_RATIO == 6) && (CLOCK_RATIO == 4)) begin  //   2 registers for each IO per D1/D2
         // OLD always @(negedge clk_mux) begin
         // OLD     casex (statereg)     // synopsys parallel_case 
         // OLD         2'b0x: begin    // parallel load
         // OLD             d1_holding_reg_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-1):(s*((MULTIPLEX_RATIO-2)/2))] <=
         // OLD                    {inbus[((s+1)*MULTIPLEX_RATIO)-4],
         // OLD                     inbus[((s+1)*MULTIPLEX_RATIO)-6]};
         // OLD             d2_holding_reg_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-1):(s*((MULTIPLEX_RATIO-2)/2))] <=
         // OLD                    {inbus[((s+1)*MULTIPLEX_RATIO)-3],
         // OLD                     inbus[((s+1)*MULTIPLEX_RATIO)-5]};
         // OLD             d1_holding_extra_reg_Q[s] <= inbus[((s+1)*MULTIPLEX_RATIO)-2];
         // OLD             end
         // OLD         default: begin
         // OLD             d1_holding_reg_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-1):(s*((MULTIPLEX_RATIO-2)/2))] <=
         // OLD                 {d1_holding_reg_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-2):(s*((MULTIPLEX_RATIO-2)/2))],
         // OLD                  1'b0};
         // OLD             d2_holding_reg_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-1):(s*((MULTIPLEX_RATIO-2)/2))] <=
         // OLD                 {d2_holding_reg_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-2):(s*((MULTIPLEX_RATIO-2)/2))],
         // OLD                  1'b0};
         // OLD             d1_holding_extra_reg_Q[s] <= d1_holding_reg_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-1)];
         // OLD             end
         // OLD         endcase
         // OLD     end
         always @(negedge clk_mux) begin
             casex (statereg)     // synopsys parallel_case 
                 2'b0x: begin    // parallel load
                     d1_holding_reg_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-1):(s*((MULTIPLEX_RATIO-2)/2))] <=
                            {inbus[((s+1)*MULTIPLEX_RATIO)-3],
                             inbus[((s+1)*MULTIPLEX_RATIO)-5]};
                     d2_holding_reg_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-1):(s*((MULTIPLEX_RATIO-2)/2))] <=
                            {inbus[((s+1)*MULTIPLEX_RATIO)-4],
                             inbus[((s+1)*MULTIPLEX_RATIO)-6]};
                     end
                 default: begin  // left shift
                     d1_holding_reg_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-1):(s*((MULTIPLEX_RATIO-2)/2))] <=
                         {d1_holding_reg_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-2):(s*((MULTIPLEX_RATIO-2)/2))],
                          1'b0};
                     d2_holding_reg_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-1):(s*((MULTIPLEX_RATIO-2)/2))] <=
                         {d2_holding_reg_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-2):(s*((MULTIPLEX_RATIO-2)/2))],
                          1'b0};
                     end
                 endcase
             end

         // with altera ddio block, it captures both things it wants to send out on the
         // falling edge of the clock (normally rising edge, but I'm feeding in an
         // inverted clock).  So d1 and d2 have to get the two most significant
         // bits of the bus that is going out
         always @ (*) begin
             casex (statereg)     // synopsys parallel_case 
                 2'b0x: begin    // first sample going out
                     d1_data_D[s] = inbus[((s+1)*MULTIPLEX_RATIO)-1]; // send out 1st MSb
                     d2_data_D[s] = inbus[((s+1)*MULTIPLEX_RATIO)-2]; // send out 2nd MSb
                     end
                 default: begin  // left shift
                     d1_data_D[s] = d1_holding_reg_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-1)];  // next MSb
                     d2_data_D[s] = d2_holding_reg_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-1)];  // next MSb
                     end
                 endcase
             end
         end

         // OLD always @ (*) begin
         // OLD     casex (statereg)     // synopsys parallel_case 
         // OLD         2'b0x: begin    // first sample going out
         // OLD             d1_data_D[s] = d1_holding_extra_reg_Q[s];        // don't care on this
         // OLD             d2_data_D[s] = inbus[((s+1)*MULTIPLEX_RATIO)-1]; // send out MSb
         // OLD             end
         // OLD         default: begin  // left shift
         // OLD             d1_data_D[s] = d1_holding_extra_reg_Q[s];
         // OLD             d2_data_D[s] = d2_holding_reg_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-1)];
         // OLD             end
         // OLD         endcase
         // OLD     end
         // OLD end
     else if ((MULTIPLEX_RATIO == 14) && (CLOCK_RATIO == 8)) begin  //   6 registers for each IO per D1/D2
         always @(negedge clk_mux) begin
             casex (statereg)     // synopsys parallel_case 
                 4'b0xxx: begin    // parallel load
                     d1_holding_reg_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-1):(s*((MULTIPLEX_RATIO-2)/2))] <=
                            {inbus[((s+1)*MULTIPLEX_RATIO)-4],
                             inbus[((s+1)*MULTIPLEX_RATIO)-6],
                             inbus[((s+1)*MULTIPLEX_RATIO)-8],
                             inbus[((s+1)*MULTIPLEX_RATIO)-10],
                             inbus[((s+1)*MULTIPLEX_RATIO)-12],
                             inbus[((s+1)*MULTIPLEX_RATIO)-14]};
                     d2_holding_reg_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-1):(s*((MULTIPLEX_RATIO-2)/2))] <=
                            {inbus[((s+1)*MULTIPLEX_RATIO)-3],
                             inbus[((s+1)*MULTIPLEX_RATIO)-5],
                             inbus[((s+1)*MULTIPLEX_RATIO)-7],
                             inbus[((s+1)*MULTIPLEX_RATIO)-9],
                             inbus[((s+1)*MULTIPLEX_RATIO)-11],
                             inbus[((s+1)*MULTIPLEX_RATIO)-13]};
                     d1_holding_extra_reg_Q[s] <= inbus[((s+1)*MULTIPLEX_RATIO)-2];
                     end
                 default: begin
                     d1_holding_reg_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-1):(s*((MULTIPLEX_RATIO-2)/2))] <=
                         {d1_holding_reg_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-2):(s*((MULTIPLEX_RATIO-2)/2))],
                          1'b0};
                     d2_holding_reg_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-1):(s*((MULTIPLEX_RATIO-2)/2))] <=
                         {d2_holding_reg_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-2):(s*((MULTIPLEX_RATIO-2)/2))],
                          1'b0};
                     d1_holding_extra_reg_Q[s] <= d1_holding_reg_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-1)];
                     end
                 endcase
             end

         always @ (*) begin
             casex (statereg)     // synopsys parallel_case 
                 4'b0xxx: begin    // first sample going out
                     d1_data_D[s] = d1_holding_extra_reg_Q[s];        // don't care on this
                     d2_data_D[s] = inbus[((s+1)*MULTIPLEX_RATIO)-1]; // send out MSb
                     end
                 default: begin  // left shift
                     d1_data_D[s] = d1_holding_extra_reg_Q[s];
                     d2_data_D[s] = d2_holding_reg_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-1)];
                     end
                 endcase
             end
         end
     else if ((MULTIPLEX_RATIO == 12) && (CLOCK_RATIO == 8)) begin  //   6 registers for each IO per D1/D2
         always @(negedge clk_mux) begin
             casex (statereg)     // synopsys parallel_case 
                 4'b0xxx: begin    // parallel load
                     d1_holding_reg_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-1):(s*((MULTIPLEX_RATIO-2)/2))] <=
                            {inbus[((s+1)*MULTIPLEX_RATIO)-1],
                             inbus[((s+1)*MULTIPLEX_RATIO)-3],
                             inbus[((s+1)*MULTIPLEX_RATIO)-5],
                             inbus[((s+1)*MULTIPLEX_RATIO)-7],
                             inbus[((s+1)*MULTIPLEX_RATIO)-9]};
                             d1_holding_extra_reg_Q[s] <= inbus[((s+1)*MULTIPLEX_RATIO)-11];
                     d2_holding_reg_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-1):(s*((MULTIPLEX_RATIO-2)/2))] <=
                            {inbus[((s+1)*MULTIPLEX_RATIO)-2],
                             inbus[((s+1)*MULTIPLEX_RATIO)-4],
                             inbus[((s+1)*MULTIPLEX_RATIO)-6],
                             inbus[((s+1)*MULTIPLEX_RATIO)-8],
                             inbus[((s+1)*MULTIPLEX_RATIO)-10]};
                             d2_holding_extra_reg_Q[s] <= inbus[((s+1)*MULTIPLEX_RATIO)-12];
                     end
                 default: begin
                     d1_holding_reg_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-1):(s*((MULTIPLEX_RATIO-2)/2))] <=
                         {d1_holding_reg_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-2):(s*((MULTIPLEX_RATIO-2)/2))],
                          d1_holding_extra_reg_Q[s]};
                     d2_holding_reg_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-1):(s*((MULTIPLEX_RATIO-2)/2))] <=
                         {d2_holding_reg_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-2):(s*((MULTIPLEX_RATIO-2)/2))],
                          d2_holding_extra_reg_Q[s]};
                     end
                 endcase
             end

         always @ (*) begin
             d1_data_D[s] = d1_holding_reg_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-1)];
             d2_data_D[s] = d2_holding_reg_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-1)];
             end
         end
     else if ((MULTIPLEX_RATIO == 20) && (CLOCK_RATIO == 12)) begin  //   10 registers for each IO per D1/D2
         // only capture two MS bits on the neg edge, all others get a full clock cycle
         // this is reversed from other cases in this generate statement
         always @(negedge clk_mux) begin
             casex (statereg)     // synopsys parallel_case 
                 5'b0xxxx: begin    // parallel load
                     d1_holding_extra_reg_Q[s] <= inbus[((s+1)*MULTIPLEX_RATIO)-1];
                     d2_holding_extra_reg_Q[s] <= inbus[((s+1)*MULTIPLEX_RATIO)-2];
                     end
                 default: begin
                     d1_holding_extra_reg_Q[s] <= d1_holding_reg_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-1)];
                     d2_holding_extra_reg_Q[s] <= d2_holding_reg_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-1)];
                     end
                 endcase
             end

         // 9-bit wide register on each side for a total of 18 bits
         always @(posedge clk_mux) begin
             casex (statereg)     // synopsys parallel_case 
                 5'b0xxxx: begin    // parallel load
                     d1_holding_reg_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-1):(s*((MULTIPLEX_RATIO-2)/2))] <=
                            {inbus[((s+1)*MULTIPLEX_RATIO)-3],
                             inbus[((s+1)*MULTIPLEX_RATIO)-5],
                             inbus[((s+1)*MULTIPLEX_RATIO)-7],
                             inbus[((s+1)*MULTIPLEX_RATIO)-9],
                             inbus[((s+1)*MULTIPLEX_RATIO)-11],
                             inbus[((s+1)*MULTIPLEX_RATIO)-13],
                             inbus[((s+1)*MULTIPLEX_RATIO)-15],
                             inbus[((s+1)*MULTIPLEX_RATIO)-17],
                             inbus[((s+1)*MULTIPLEX_RATIO)-19]};
                     d2_holding_reg_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-1):(s*((MULTIPLEX_RATIO-2)/2))] <=
                            {inbus[((s+1)*MULTIPLEX_RATIO)-4],
                             inbus[((s+1)*MULTIPLEX_RATIO)-6],
                             inbus[((s+1)*MULTIPLEX_RATIO)-8],
                             inbus[((s+1)*MULTIPLEX_RATIO)-10],
                             inbus[((s+1)*MULTIPLEX_RATIO)-12],
                             inbus[((s+1)*MULTIPLEX_RATIO)-14],
                             inbus[((s+1)*MULTIPLEX_RATIO)-16],
                             inbus[((s+1)*MULTIPLEX_RATIO)-18],
                             inbus[((s+1)*MULTIPLEX_RATIO)-20]};
                     end
                 default: begin   // shift left
                     d1_holding_reg_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-1):(s*((MULTIPLEX_RATIO-2)/2))] <=
                         {d1_holding_reg_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-2):(s*((MULTIPLEX_RATIO-2)/2))],
                          inbus[((s+1)*MULTIPLEX_RATIO)-19]}; // just reload with data again - it doesn't matter
                     d2_holding_reg_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-1):(s*((MULTIPLEX_RATIO-2)/2))] <=
                         {d2_holding_reg_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-2):(s*((MULTIPLEX_RATIO-2)/2))],
                          inbus[((s+1)*MULTIPLEX_RATIO)-20]}; // just reload with data again - it doesn't matter
                     end
                 endcase
             end

         always @ (*) begin
             d1_data_D[s] = d1_holding_extra_reg_Q[s];  // most significant
             d2_data_D[s] = d2_holding_extra_reg_Q[s];  // one down from most significant
             end
         end
     else if ((MULTIPLEX_RATIO == 28) && (CLOCK_RATIO == 16)) begin  //   14 registers for each IO per D1/D2
         // only capture two MS bits on the neg edge, all others get a full clock cycle
         // this is reversed from other cases in this generate statement
         always @(negedge clk_mux) begin
             casex (statereg)     // synopsys parallel_case 
                 5'b0xxxx: begin    // parallel load
                     d1_holding_extra_reg_Q[s] <= inbus[((s+1)*MULTIPLEX_RATIO)-1];
                     d2_holding_extra_reg_Q[s] <= inbus[((s+1)*MULTIPLEX_RATIO)-2];
                     end
                 default: begin
                     d1_holding_extra_reg_Q[s] <= d1_holding_reg_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-1)];
                     d2_holding_extra_reg_Q[s] <= d2_holding_reg_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-1)];
                     end
                 endcase
             end

         // 9-bit wide register on each side for a total of 18 bits
         always @(posedge clk_mux) begin
             casex (statereg)     // synopsys parallel_case 
                 5'b0xxxx: begin    // parallel load
                     d1_holding_reg_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-1):(s*((MULTIPLEX_RATIO-2)/2))] <=
                            {inbus[((s+1)*MULTIPLEX_RATIO)-3],
                             inbus[((s+1)*MULTIPLEX_RATIO)-5],
                             inbus[((s+1)*MULTIPLEX_RATIO)-7],
                             inbus[((s+1)*MULTIPLEX_RATIO)-9],
                             inbus[((s+1)*MULTIPLEX_RATIO)-11],
                             inbus[((s+1)*MULTIPLEX_RATIO)-13],
                             inbus[((s+1)*MULTIPLEX_RATIO)-15],
                             inbus[((s+1)*MULTIPLEX_RATIO)-17],
                             inbus[((s+1)*MULTIPLEX_RATIO)-19],
                             inbus[((s+1)*MULTIPLEX_RATIO)-21],
                             inbus[((s+1)*MULTIPLEX_RATIO)-23],
                             inbus[((s+1)*MULTIPLEX_RATIO)-25],
                             inbus[((s+1)*MULTIPLEX_RATIO)-27]};
                     d2_holding_reg_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-1):(s*((MULTIPLEX_RATIO-2)/2))] <=
                            {inbus[((s+1)*MULTIPLEX_RATIO)-4],
                             inbus[((s+1)*MULTIPLEX_RATIO)-6],
                             inbus[((s+1)*MULTIPLEX_RATIO)-8],
                             inbus[((s+1)*MULTIPLEX_RATIO)-10],
                             inbus[((s+1)*MULTIPLEX_RATIO)-12],
                             inbus[((s+1)*MULTIPLEX_RATIO)-14],
                             inbus[((s+1)*MULTIPLEX_RATIO)-16],
                             inbus[((s+1)*MULTIPLEX_RATIO)-18],
                             inbus[((s+1)*MULTIPLEX_RATIO)-20],
                             inbus[((s+1)*MULTIPLEX_RATIO)-22],
                             inbus[((s+1)*MULTIPLEX_RATIO)-24],
                             inbus[((s+1)*MULTIPLEX_RATIO)-26],
                             inbus[((s+1)*MULTIPLEX_RATIO)-28]};
                     end
                 default: begin   // shift left
                     d1_holding_reg_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-1):(s*((MULTIPLEX_RATIO-2)/2))] <=
                         {d1_holding_reg_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-2):(s*((MULTIPLEX_RATIO-2)/2))],
                          inbus[((s+1)*MULTIPLEX_RATIO)-27]}; // just reload with data again - it doesn't matter
                     d2_holding_reg_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-1):(s*((MULTIPLEX_RATIO-2)/2))] <=
                         {d2_holding_reg_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-2):(s*((MULTIPLEX_RATIO-2)/2))],
                          inbus[((s+1)*MULTIPLEX_RATIO)-28]}; // just reload with data again - it doesn't matter
                     end
                 endcase
             end

         always @ (*) begin
             d1_data_D[s] = d1_holding_extra_reg_Q[s];  // most significant
             d2_data_D[s] = d2_holding_extra_reg_Q[s];  // one down from most significant
             end
         end
     else if ((MULTIPLEX_RATIO == 36) && (CLOCK_RATIO == 20)) begin  //   18 registers for each IO per D1/D2
         // only capture two MS bits on the neg edge, all others get a full clock cycle
         // this is reversed from other cases in this generate statement
         always @(negedge clk_mux) begin
             casex (statereg)     // synopsys parallel_case 
                 6'b0xxxxx: begin    // parallel load
                     d1_holding_extra_reg_Q[s] <= inbus[((s+1)*MULTIPLEX_RATIO)-1];
                     d2_holding_extra_reg_Q[s] <= inbus[((s+1)*MULTIPLEX_RATIO)-2];
                     end
                 default: begin
                     d1_holding_extra_reg_Q[s] <= d1_holding_reg_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-1)];
                     d2_holding_extra_reg_Q[s] <= d2_holding_reg_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-1)];
                     end
                 endcase
             end

         // 9-bit wide register on each side for a total of 18 bits
         always @(posedge clk_mux) begin
             casex (statereg)     // synopsys parallel_case 
                 6'b0xxxxx: begin    // parallel load
                     d1_holding_reg_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-1):(s*((MULTIPLEX_RATIO-2)/2))] <=
                            {inbus[((s+1)*MULTIPLEX_RATIO)-3],
                             inbus[((s+1)*MULTIPLEX_RATIO)-5],
                             inbus[((s+1)*MULTIPLEX_RATIO)-7],
                             inbus[((s+1)*MULTIPLEX_RATIO)-9],
                             inbus[((s+1)*MULTIPLEX_RATIO)-11],
                             inbus[((s+1)*MULTIPLEX_RATIO)-13],
                             inbus[((s+1)*MULTIPLEX_RATIO)-15],
                             inbus[((s+1)*MULTIPLEX_RATIO)-17],
                             inbus[((s+1)*MULTIPLEX_RATIO)-19],
                             inbus[((s+1)*MULTIPLEX_RATIO)-21],
                             inbus[((s+1)*MULTIPLEX_RATIO)-23],
                             inbus[((s+1)*MULTIPLEX_RATIO)-25],
                             inbus[((s+1)*MULTIPLEX_RATIO)-27],
                             inbus[((s+1)*MULTIPLEX_RATIO)-29],
                             inbus[((s+1)*MULTIPLEX_RATIO)-31],
                             inbus[((s+1)*MULTIPLEX_RATIO)-33],
                             inbus[((s+1)*MULTIPLEX_RATIO)-35]};
                     d2_holding_reg_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-1):(s*((MULTIPLEX_RATIO-2)/2))] <=
                            {inbus[((s+1)*MULTIPLEX_RATIO)-4],
                             inbus[((s+1)*MULTIPLEX_RATIO)-6],
                             inbus[((s+1)*MULTIPLEX_RATIO)-8],
                             inbus[((s+1)*MULTIPLEX_RATIO)-10],
                             inbus[((s+1)*MULTIPLEX_RATIO)-12],
                             inbus[((s+1)*MULTIPLEX_RATIO)-14],
                             inbus[((s+1)*MULTIPLEX_RATIO)-16],
                             inbus[((s+1)*MULTIPLEX_RATIO)-18],
                             inbus[((s+1)*MULTIPLEX_RATIO)-20],
                             inbus[((s+1)*MULTIPLEX_RATIO)-22],
                             inbus[((s+1)*MULTIPLEX_RATIO)-24],
                             inbus[((s+1)*MULTIPLEX_RATIO)-26],
                             inbus[((s+1)*MULTIPLEX_RATIO)-28],
                             inbus[((s+1)*MULTIPLEX_RATIO)-30],
                             inbus[((s+1)*MULTIPLEX_RATIO)-32],
                             inbus[((s+1)*MULTIPLEX_RATIO)-34],
                             inbus[((s+1)*MULTIPLEX_RATIO)-36]};
                     end
                 default: begin   // shift left
                     d1_holding_reg_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-1):(s*((MULTIPLEX_RATIO-2)/2))] <=
                         {d1_holding_reg_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-2):(s*((MULTIPLEX_RATIO-2)/2))],
                          inbus[((s+1)*MULTIPLEX_RATIO)-35]}; // just reload with data again - it doesn't matter
                     d2_holding_reg_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-1):(s*((MULTIPLEX_RATIO-2)/2))] <=
                         {d2_holding_reg_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-2):(s*((MULTIPLEX_RATIO-2)/2))],
                          inbus[((s+1)*MULTIPLEX_RATIO)-36]}; // just reload with data again - it doesn't matter
                     end
                 endcase
             end

         always @ (*) begin
             d1_data_D[s] = d1_holding_extra_reg_Q[s];  // most significant
             d2_data_D[s] = d2_holding_extra_reg_Q[s];  // one down from most significant
             end
         end
     else if ((MULTIPLEX_RATIO == 44) && (CLOCK_RATIO == 24)) begin  //   22 registers for each IO per D1/D2
         // only capture two MS bits on the neg edge, all others get a full clock cycle
         // this is reversed from other cases in this generate statement
         always @(negedge clk_mux) begin
             casex (statereg)     // synopsys parallel_case 
                 6'b0xxxxx: begin    // parallel load
                     d1_holding_extra_reg_Q[s] <= inbus[((s+1)*MULTIPLEX_RATIO)-1];
                     d2_holding_extra_reg_Q[s] <= inbus[((s+1)*MULTIPLEX_RATIO)-2];
                     end
                 default: begin
                     d1_holding_extra_reg_Q[s] <= d1_holding_reg_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-1)];
                     d2_holding_extra_reg_Q[s] <= d2_holding_reg_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-1)];
                     end
                 endcase
             end

         // 9-bit wide register on each side for a total of 18 bits
         always @(posedge clk_mux) begin
             casex (statereg)     // synopsys parallel_case 
                 6'b0xxxxx: begin    // parallel load
                     d1_holding_reg_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-1):(s*((MULTIPLEX_RATIO-2)/2))] <=
                            {inbus[((s+1)*MULTIPLEX_RATIO)-3],
                             inbus[((s+1)*MULTIPLEX_RATIO)-5],
                             inbus[((s+1)*MULTIPLEX_RATIO)-7],
                             inbus[((s+1)*MULTIPLEX_RATIO)-9],
                             inbus[((s+1)*MULTIPLEX_RATIO)-11],
                             inbus[((s+1)*MULTIPLEX_RATIO)-13],
                             inbus[((s+1)*MULTIPLEX_RATIO)-15],
                             inbus[((s+1)*MULTIPLEX_RATIO)-17],
                             inbus[((s+1)*MULTIPLEX_RATIO)-19],
                             inbus[((s+1)*MULTIPLEX_RATIO)-21],
                             inbus[((s+1)*MULTIPLEX_RATIO)-23],
                             inbus[((s+1)*MULTIPLEX_RATIO)-25],
                             inbus[((s+1)*MULTIPLEX_RATIO)-27],
                             inbus[((s+1)*MULTIPLEX_RATIO)-29],
                             inbus[((s+1)*MULTIPLEX_RATIO)-31],
                             inbus[((s+1)*MULTIPLEX_RATIO)-33],
                             inbus[((s+1)*MULTIPLEX_RATIO)-35],
                             inbus[((s+1)*MULTIPLEX_RATIO)-37],
                             inbus[((s+1)*MULTIPLEX_RATIO)-39],
                             inbus[((s+1)*MULTIPLEX_RATIO)-41],
                             inbus[((s+1)*MULTIPLEX_RATIO)-43]};
                     d2_holding_reg_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-1):(s*((MULTIPLEX_RATIO-2)/2))] <=
                            {inbus[((s+1)*MULTIPLEX_RATIO)-4],
                             inbus[((s+1)*MULTIPLEX_RATIO)-6],
                             inbus[((s+1)*MULTIPLEX_RATIO)-8],
                             inbus[((s+1)*MULTIPLEX_RATIO)-10],
                             inbus[((s+1)*MULTIPLEX_RATIO)-12],
                             inbus[((s+1)*MULTIPLEX_RATIO)-14],
                             inbus[((s+1)*MULTIPLEX_RATIO)-16],
                             inbus[((s+1)*MULTIPLEX_RATIO)-18],
                             inbus[((s+1)*MULTIPLEX_RATIO)-20],
                             inbus[((s+1)*MULTIPLEX_RATIO)-22],
                             inbus[((s+1)*MULTIPLEX_RATIO)-24],
                             inbus[((s+1)*MULTIPLEX_RATIO)-26],
                             inbus[((s+1)*MULTIPLEX_RATIO)-28],
                             inbus[((s+1)*MULTIPLEX_RATIO)-30],
                             inbus[((s+1)*MULTIPLEX_RATIO)-32],
                             inbus[((s+1)*MULTIPLEX_RATIO)-34],
                             inbus[((s+1)*MULTIPLEX_RATIO)-36],
                             inbus[((s+1)*MULTIPLEX_RATIO)-38],
                             inbus[((s+1)*MULTIPLEX_RATIO)-40],
                             inbus[((s+1)*MULTIPLEX_RATIO)-42],
                             inbus[((s+1)*MULTIPLEX_RATIO)-44]};
                     end
                 default: begin   // shift left
                     d1_holding_reg_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-1):(s*((MULTIPLEX_RATIO-2)/2))] <=
                         {d1_holding_reg_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-2):(s*((MULTIPLEX_RATIO-2)/2))],
                          inbus[((s+1)*MULTIPLEX_RATIO)-43]}; // just reload with data again - it doesn't matter
                     d2_holding_reg_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-1):(s*((MULTIPLEX_RATIO-2)/2))] <=
                         {d2_holding_reg_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-2):(s*((MULTIPLEX_RATIO-2)/2))],
                          inbus[((s+1)*MULTIPLEX_RATIO)-44]}; // just reload with data again - it doesn't matter
                     end
                 endcase
             end

         always @ (*) begin
             d1_data_D[s] = d1_holding_extra_reg_Q[s];  // most significant
             d2_data_D[s] = d2_holding_extra_reg_Q[s];  // one down from most significant
             end
         end
     else if ((MULTIPLEX_RATIO == 52) && (CLOCK_RATIO == 28)) begin  //   26 registers for each IO per D1/D2
         // only capture two MS bits on the neg edge, all others get a full clock cycle
         // this is reversed from other cases in this generate statement
         always @(negedge clk_mux) begin
             casex (statereg)     // synopsys parallel_case 
                 6'b0xxxxx: begin    // parallel load
                     d1_holding_extra_reg_Q[s] <= inbus[((s+1)*MULTIPLEX_RATIO)-1];
                     d2_holding_extra_reg_Q[s] <= inbus[((s+1)*MULTIPLEX_RATIO)-2];
                     end
                 default: begin
                     d1_holding_extra_reg_Q[s] <= d1_holding_reg_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-1)];
                     d2_holding_extra_reg_Q[s] <= d2_holding_reg_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-1)];
                     end
                 endcase
             end

         // 25-bit wide register on each side for a total of 50 bits
         always @(posedge clk_mux) begin
             casex (statereg)     // synopsys parallel_case 
                 6'b0xxxxx: begin    // parallel load
                     d1_holding_reg_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-1):(s*((MULTIPLEX_RATIO-2)/2))] <=
                            {inbus[((s+1)*MULTIPLEX_RATIO)-3],
                             inbus[((s+1)*MULTIPLEX_RATIO)-5],
                             inbus[((s+1)*MULTIPLEX_RATIO)-7],
                             inbus[((s+1)*MULTIPLEX_RATIO)-9],
                             inbus[((s+1)*MULTIPLEX_RATIO)-11],
                             inbus[((s+1)*MULTIPLEX_RATIO)-13],
                             inbus[((s+1)*MULTIPLEX_RATIO)-15],
                             inbus[((s+1)*MULTIPLEX_RATIO)-17],
                             inbus[((s+1)*MULTIPLEX_RATIO)-19],
                             inbus[((s+1)*MULTIPLEX_RATIO)-21],
                             inbus[((s+1)*MULTIPLEX_RATIO)-23],
                             inbus[((s+1)*MULTIPLEX_RATIO)-25],
                             inbus[((s+1)*MULTIPLEX_RATIO)-27],
                             inbus[((s+1)*MULTIPLEX_RATIO)-29],
                             inbus[((s+1)*MULTIPLEX_RATIO)-31],
                             inbus[((s+1)*MULTIPLEX_RATIO)-33],
                             inbus[((s+1)*MULTIPLEX_RATIO)-35],
                             inbus[((s+1)*MULTIPLEX_RATIO)-37],
                             inbus[((s+1)*MULTIPLEX_RATIO)-39],
                             inbus[((s+1)*MULTIPLEX_RATIO)-41],
                             inbus[((s+1)*MULTIPLEX_RATIO)-43],
                             inbus[((s+1)*MULTIPLEX_RATIO)-45],
                             inbus[((s+1)*MULTIPLEX_RATIO)-47],
                             inbus[((s+1)*MULTIPLEX_RATIO)-49],
                             inbus[((s+1)*MULTIPLEX_RATIO)-51]};
                     d2_holding_reg_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-1):(s*((MULTIPLEX_RATIO-2)/2))] <=
                            {inbus[((s+1)*MULTIPLEX_RATIO)-4],
                             inbus[((s+1)*MULTIPLEX_RATIO)-6],
                             inbus[((s+1)*MULTIPLEX_RATIO)-8],
                             inbus[((s+1)*MULTIPLEX_RATIO)-10],
                             inbus[((s+1)*MULTIPLEX_RATIO)-12],
                             inbus[((s+1)*MULTIPLEX_RATIO)-14],
                             inbus[((s+1)*MULTIPLEX_RATIO)-16],
                             inbus[((s+1)*MULTIPLEX_RATIO)-18],
                             inbus[((s+1)*MULTIPLEX_RATIO)-20],
                             inbus[((s+1)*MULTIPLEX_RATIO)-22],
                             inbus[((s+1)*MULTIPLEX_RATIO)-24],
                             inbus[((s+1)*MULTIPLEX_RATIO)-26],
                             inbus[((s+1)*MULTIPLEX_RATIO)-28],
                             inbus[((s+1)*MULTIPLEX_RATIO)-30],
                             inbus[((s+1)*MULTIPLEX_RATIO)-32],
                             inbus[((s+1)*MULTIPLEX_RATIO)-34],
                             inbus[((s+1)*MULTIPLEX_RATIO)-36],
                             inbus[((s+1)*MULTIPLEX_RATIO)-38],
                             inbus[((s+1)*MULTIPLEX_RATIO)-40],
                             inbus[((s+1)*MULTIPLEX_RATIO)-42],
                             inbus[((s+1)*MULTIPLEX_RATIO)-44],
                             inbus[((s+1)*MULTIPLEX_RATIO)-46],
                             inbus[((s+1)*MULTIPLEX_RATIO)-48],
                             inbus[((s+1)*MULTIPLEX_RATIO)-50],
                             inbus[((s+1)*MULTIPLEX_RATIO)-52]};
                     end
                 default: begin   // shift left
                     d1_holding_reg_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-1):(s*((MULTIPLEX_RATIO-2)/2))] <=
                         {d1_holding_reg_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-2):(s*((MULTIPLEX_RATIO-2)/2))],
                          inbus[((s+1)*MULTIPLEX_RATIO)-51]}; // just reload with data again - it doesn't matter
                     d2_holding_reg_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-1):(s*((MULTIPLEX_RATIO-2)/2))] <=
                         {d2_holding_reg_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-2):(s*((MULTIPLEX_RATIO-2)/2))],
                          inbus[((s+1)*MULTIPLEX_RATIO)-52]}; // just reload with data again - it doesn't matter
                     end
                 endcase
             end

         always @ (*) begin
             d1_data_D[s] = d1_holding_extra_reg_Q[s];  // most significant
             d2_data_D[s] = d2_holding_extra_reg_Q[s];  // one down from most significant
             end
         end
     else if ((MULTIPLEX_RATIO == 60) && (CLOCK_RATIO == 32)) begin  //   30 registers for each IO per D1/D2
         // only capture two MS bits on the neg edge, all others get a full clock cycle
         // this is reversed from other cases in this generate statement
         always @(negedge clk_mux) begin
             casex (statereg)     // synopsys parallel_case 
                 6'b0xxxxx: begin    // parallel load
                     d1_holding_extra_reg_Q[s] <= inbus[((s+1)*MULTIPLEX_RATIO)-1];
                     d2_holding_extra_reg_Q[s] <= inbus[((s+1)*MULTIPLEX_RATIO)-2];
                     end
                 default: begin
                     d1_holding_extra_reg_Q[s] <= d1_holding_reg_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-1)];
                     d2_holding_extra_reg_Q[s] <= d2_holding_reg_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-1)];
                     end
                 endcase
             end

         // 29-bit wide register on each side for a total of 58 bits
         always @(posedge clk_mux) begin
             casex (statereg)     // synopsys parallel_case 
                 6'b0xxxxx: begin    // parallel load
                     d1_holding_reg_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-1):(s*((MULTIPLEX_RATIO-2)/2))] <=
                            {inbus[((s+1)*MULTIPLEX_RATIO)-3],
                             inbus[((s+1)*MULTIPLEX_RATIO)-5],
                             inbus[((s+1)*MULTIPLEX_RATIO)-7],
                             inbus[((s+1)*MULTIPLEX_RATIO)-9],
                             inbus[((s+1)*MULTIPLEX_RATIO)-11],
                             inbus[((s+1)*MULTIPLEX_RATIO)-13],
                             inbus[((s+1)*MULTIPLEX_RATIO)-15],
                             inbus[((s+1)*MULTIPLEX_RATIO)-17],
                             inbus[((s+1)*MULTIPLEX_RATIO)-19],
                             inbus[((s+1)*MULTIPLEX_RATIO)-21],
                             inbus[((s+1)*MULTIPLEX_RATIO)-23],
                             inbus[((s+1)*MULTIPLEX_RATIO)-25],
                             inbus[((s+1)*MULTIPLEX_RATIO)-27],
                             inbus[((s+1)*MULTIPLEX_RATIO)-29],
                             inbus[((s+1)*MULTIPLEX_RATIO)-31],
                             inbus[((s+1)*MULTIPLEX_RATIO)-33],
                             inbus[((s+1)*MULTIPLEX_RATIO)-35],
                             inbus[((s+1)*MULTIPLEX_RATIO)-37],
                             inbus[((s+1)*MULTIPLEX_RATIO)-39],
                             inbus[((s+1)*MULTIPLEX_RATIO)-41],
                             inbus[((s+1)*MULTIPLEX_RATIO)-43],
                             inbus[((s+1)*MULTIPLEX_RATIO)-45],
                             inbus[((s+1)*MULTIPLEX_RATIO)-47],
                             inbus[((s+1)*MULTIPLEX_RATIO)-49],
                             inbus[((s+1)*MULTIPLEX_RATIO)-51],
                             inbus[((s+1)*MULTIPLEX_RATIO)-53],
                             inbus[((s+1)*MULTIPLEX_RATIO)-55],
                             inbus[((s+1)*MULTIPLEX_RATIO)-57],
                             inbus[((s+1)*MULTIPLEX_RATIO)-59]};
                     d2_holding_reg_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-1):(s*((MULTIPLEX_RATIO-2)/2))] <=
                            {inbus[((s+1)*MULTIPLEX_RATIO)-4],
                             inbus[((s+1)*MULTIPLEX_RATIO)-6],
                             inbus[((s+1)*MULTIPLEX_RATIO)-8],
                             inbus[((s+1)*MULTIPLEX_RATIO)-10],
                             inbus[((s+1)*MULTIPLEX_RATIO)-12],
                             inbus[((s+1)*MULTIPLEX_RATIO)-14],
                             inbus[((s+1)*MULTIPLEX_RATIO)-16],
                             inbus[((s+1)*MULTIPLEX_RATIO)-18],
                             inbus[((s+1)*MULTIPLEX_RATIO)-20],
                             inbus[((s+1)*MULTIPLEX_RATIO)-22],
                             inbus[((s+1)*MULTIPLEX_RATIO)-24],
                             inbus[((s+1)*MULTIPLEX_RATIO)-26],
                             inbus[((s+1)*MULTIPLEX_RATIO)-28],
                             inbus[((s+1)*MULTIPLEX_RATIO)-30],
                             inbus[((s+1)*MULTIPLEX_RATIO)-32],
                             inbus[((s+1)*MULTIPLEX_RATIO)-34],
                             inbus[((s+1)*MULTIPLEX_RATIO)-36],
                             inbus[((s+1)*MULTIPLEX_RATIO)-38],
                             inbus[((s+1)*MULTIPLEX_RATIO)-40],
                             inbus[((s+1)*MULTIPLEX_RATIO)-42],
                             inbus[((s+1)*MULTIPLEX_RATIO)-44],
                             inbus[((s+1)*MULTIPLEX_RATIO)-46],
                             inbus[((s+1)*MULTIPLEX_RATIO)-48],
                             inbus[((s+1)*MULTIPLEX_RATIO)-50],
                             inbus[((s+1)*MULTIPLEX_RATIO)-52],
                             inbus[((s+1)*MULTIPLEX_RATIO)-54],
                             inbus[((s+1)*MULTIPLEX_RATIO)-56],
                             inbus[((s+1)*MULTIPLEX_RATIO)-58],
                             inbus[((s+1)*MULTIPLEX_RATIO)-60]};
                     end
                 default: begin   // shift left
                     d1_holding_reg_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-1):(s*((MULTIPLEX_RATIO-2)/2))] <=
                         {d1_holding_reg_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-2):(s*((MULTIPLEX_RATIO-2)/2))],
                          inbus[((s+1)*MULTIPLEX_RATIO)-59]}; // just reload with data again - it doesn't matter
                     d2_holding_reg_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-1):(s*((MULTIPLEX_RATIO-2)/2))] <=
                         {d2_holding_reg_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-2):(s*((MULTIPLEX_RATIO-2)/2))],
                          inbus[((s+1)*MULTIPLEX_RATIO)-60]}; // just reload with data again - it doesn't matter
                     end
                 endcase
             end

         always @ (*) begin
             d1_data_D[s] = d1_holding_extra_reg_Q[s];  // most significant
             d2_data_D[s] = d2_holding_extra_reg_Q[s];  // one down from most significant
             end
         end
     else if ((MULTIPLEX_RATIO == 68) && (CLOCK_RATIO == 36)) begin  //   34 registers for each IO per D1/D2
         // only capture two MS bits on the neg edge, all others get a full clock cycle
         // this is reversed from other cases in this generate statement
         always @(negedge clk_mux) begin
             casex (statereg)     // synopsys parallel_case 
                 7'b0xxxxxx: begin    // parallel load
                     d1_holding_extra_reg_Q[s] <= inbus[((s+1)*MULTIPLEX_RATIO)-1];
                     d2_holding_extra_reg_Q[s] <= inbus[((s+1)*MULTIPLEX_RATIO)-2];
                     end
                 default: begin
                     d1_holding_extra_reg_Q[s] <= d1_holding_reg_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-1)];
                     d2_holding_extra_reg_Q[s] <= d2_holding_reg_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-1)];
                     end
                 endcase
             end

         // 33-bit wide register on each side for a total of 66 bits
         always @(posedge clk_mux) begin
             casex (statereg)     // synopsys parallel_case 
                 7'b0xxxxxx: begin    // parallel load
                     d1_holding_reg_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-1):(s*((MULTIPLEX_RATIO-2)/2))] <=
                            {inbus[((s+1)*MULTIPLEX_RATIO)-3],
                             inbus[((s+1)*MULTIPLEX_RATIO)-5],
                             inbus[((s+1)*MULTIPLEX_RATIO)-7],
                             inbus[((s+1)*MULTIPLEX_RATIO)-9],
                             inbus[((s+1)*MULTIPLEX_RATIO)-11],
                             inbus[((s+1)*MULTIPLEX_RATIO)-13],
                             inbus[((s+1)*MULTIPLEX_RATIO)-15],
                             inbus[((s+1)*MULTIPLEX_RATIO)-17],
                             inbus[((s+1)*MULTIPLEX_RATIO)-19],
                             inbus[((s+1)*MULTIPLEX_RATIO)-21],
                             inbus[((s+1)*MULTIPLEX_RATIO)-23],
                             inbus[((s+1)*MULTIPLEX_RATIO)-25],
                             inbus[((s+1)*MULTIPLEX_RATIO)-27],
                             inbus[((s+1)*MULTIPLEX_RATIO)-29],
                             inbus[((s+1)*MULTIPLEX_RATIO)-31],
                             inbus[((s+1)*MULTIPLEX_RATIO)-33],
                             inbus[((s+1)*MULTIPLEX_RATIO)-35],
                             inbus[((s+1)*MULTIPLEX_RATIO)-37],
                             inbus[((s+1)*MULTIPLEX_RATIO)-39],
                             inbus[((s+1)*MULTIPLEX_RATIO)-41],
                             inbus[((s+1)*MULTIPLEX_RATIO)-43],
                             inbus[((s+1)*MULTIPLEX_RATIO)-45],
                             inbus[((s+1)*MULTIPLEX_RATIO)-47],
                             inbus[((s+1)*MULTIPLEX_RATIO)-49],
                             inbus[((s+1)*MULTIPLEX_RATIO)-51],
                             inbus[((s+1)*MULTIPLEX_RATIO)-53],
                             inbus[((s+1)*MULTIPLEX_RATIO)-55],
                             inbus[((s+1)*MULTIPLEX_RATIO)-57],
                             inbus[((s+1)*MULTIPLEX_RATIO)-59],
                             inbus[((s+1)*MULTIPLEX_RATIO)-61],
                             inbus[((s+1)*MULTIPLEX_RATIO)-63],
                             inbus[((s+1)*MULTIPLEX_RATIO)-65],
                             inbus[((s+1)*MULTIPLEX_RATIO)-67]};
                     d2_holding_reg_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-1):(s*((MULTIPLEX_RATIO-2)/2))] <=
                            {inbus[((s+1)*MULTIPLEX_RATIO)-4],
                             inbus[((s+1)*MULTIPLEX_RATIO)-6],
                             inbus[((s+1)*MULTIPLEX_RATIO)-8],
                             inbus[((s+1)*MULTIPLEX_RATIO)-10],
                             inbus[((s+1)*MULTIPLEX_RATIO)-12],
                             inbus[((s+1)*MULTIPLEX_RATIO)-14],
                             inbus[((s+1)*MULTIPLEX_RATIO)-16],
                             inbus[((s+1)*MULTIPLEX_RATIO)-18],
                             inbus[((s+1)*MULTIPLEX_RATIO)-20],
                             inbus[((s+1)*MULTIPLEX_RATIO)-22],
                             inbus[((s+1)*MULTIPLEX_RATIO)-24],
                             inbus[((s+1)*MULTIPLEX_RATIO)-26],
                             inbus[((s+1)*MULTIPLEX_RATIO)-28],
                             inbus[((s+1)*MULTIPLEX_RATIO)-30],
                             inbus[((s+1)*MULTIPLEX_RATIO)-32],
                             inbus[((s+1)*MULTIPLEX_RATIO)-34],
                             inbus[((s+1)*MULTIPLEX_RATIO)-36],
                             inbus[((s+1)*MULTIPLEX_RATIO)-38],
                             inbus[((s+1)*MULTIPLEX_RATIO)-40],
                             inbus[((s+1)*MULTIPLEX_RATIO)-42],
                             inbus[((s+1)*MULTIPLEX_RATIO)-44],
                             inbus[((s+1)*MULTIPLEX_RATIO)-46],
                             inbus[((s+1)*MULTIPLEX_RATIO)-48],
                             inbus[((s+1)*MULTIPLEX_RATIO)-50],
                             inbus[((s+1)*MULTIPLEX_RATIO)-52],
                             inbus[((s+1)*MULTIPLEX_RATIO)-54],
                             inbus[((s+1)*MULTIPLEX_RATIO)-56],
                             inbus[((s+1)*MULTIPLEX_RATIO)-58],
                             inbus[((s+1)*MULTIPLEX_RATIO)-60],
                             inbus[((s+1)*MULTIPLEX_RATIO)-62],
                             inbus[((s+1)*MULTIPLEX_RATIO)-64],
                             inbus[((s+1)*MULTIPLEX_RATIO)-66],
                             inbus[((s+1)*MULTIPLEX_RATIO)-68]};
                     end
                 default: begin   // shift left
                     d1_holding_reg_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-1):(s*((MULTIPLEX_RATIO-2)/2))] <=
                         {d1_holding_reg_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-2):(s*((MULTIPLEX_RATIO-2)/2))],
                          inbus[((s+1)*MULTIPLEX_RATIO)-67]}; // just reload with data again - it doesn't matter
                     d2_holding_reg_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-1):(s*((MULTIPLEX_RATIO-2)/2))] <=
                         {d2_holding_reg_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-2):(s*((MULTIPLEX_RATIO-2)/2))],
                          inbus[((s+1)*MULTIPLEX_RATIO)-68]}; // just reload with data again - it doesn't matter
                     end
                 endcase
             end

         always @ (*) begin
             d1_data_D[s] = d1_holding_extra_reg_Q[s];  // most significant
             d2_data_D[s] = d2_holding_extra_reg_Q[s];  // one down from most significant
             end
         end
     else begin  // (MULTIPLEX_RATIO == 8)  3 registers for each IO per D1/D2
         always @(posedge clk_mux) begin
             casex (statereg)     // synopsys parallel_case 
                 3'b0x: begin    // parallel load
                     d1_holding_reg_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-1):(s*((MULTIPLEX_RATIO-2)/2))] <=
                            {inbus[((s+1)*MULTIPLEX_RATIO)-3],
                             inbus[((s+1)*MULTIPLEX_RATIO)-5],
                             inbus[((s+1)*MULTIPLEX_RATIO)-7]};
                     d2_holding_reg_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-1):(s*((MULTIPLEX_RATIO-2)/2))] <=
                            {inbus[((s+1)*MULTIPLEX_RATIO)-4],
                             inbus[((s+1)*MULTIPLEX_RATIO)-6],
                             inbus[((s+1)*MULTIPLEX_RATIO)-8]};
                     end
                 default: begin
                     d1_holding_reg_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-1):(s*((MULTIPLEX_RATIO-2)/2))] <=
                         {d1_holding_reg_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-2):(s*((MULTIPLEX_RATIO-2)/2))],
                          1'b0};
                     d2_holding_reg_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-1):(s*((MULTIPLEX_RATIO-2)/2))] <=
                         {d2_holding_reg_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-2):(s*((MULTIPLEX_RATIO-2)/2))],
                          1'b0};
                     end
                 endcase
             end

         always @ (*) begin
             casex (statereg)     // synopsys parallel_case 
                 2'b0x: begin    // first sample going out
                     d1_data_D[s] = inbus[((s+1)*MULTIPLEX_RATIO)-1];
                     d2_data_D[s] = inbus[((s+1)*MULTIPLEX_RATIO)-2];
                     end
                 default: begin  // left shift
                     d1_data_D[s] = d1_holding_reg_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-1)];
                     d2_data_D[s] = d2_holding_reg_Q[(((s+1)*((MULTIPLEX_RATIO-2)/2))-1)];
                     end
                 endcase
             end

         end

       
//begin: dd_io
      if(FPGA_FAMILY == STRATIX10_DEVICE_FAMILY)
      begin : s10
          fourteennm_ddio_out mux 
        (
           .clk(clk_to_ddr),
           .clkhi(1'b0),
           .clklo(1'b0),
           .muxsel(1'b0),
           .areset(1'b0),
           .sreset(1'b0),
           .ena(1'b1),
           .datainhi(d2_data_D[s]),
           .datainlo(d1_data_D[s]),
           .dataout(outbus[s])
          );
          defparam mux.power_up = "low";
          defparam mux.async_mode = "none";
          defparam mux.sync_mode = "none";
          defparam mux.half_rate_mode = "false";
      end
      else
      begin : s5
          altddio_out     ALTDDIO_OUT_component 
          (
            .aclr (1'b0),
            .datain_h (d1_data_D[s]),
            .datain_l (d2_data_D[s]),
            .outclock (clk_to_ddr),
            .dataout (outbus[s]),
            .aset (1'b0),
            .oe (1'b1),
            .oe_out (),
            .outclocken (1'b1),
            .sclr (1'b0),
            .sset (1'b0)
          );
          defparam
            ALTDDIO_OUT_component.extend_oe_disable = "OFF",
            ALTDDIO_OUT_component.intended_device_family = "Stratix IV",
            ALTDDIO_OUT_component.invert_output = "OFF",
            ALTDDIO_OUT_component.lpm_hint = "UNUSED",
            ALTDDIO_OUT_component.lpm_type = "altddio_out",
            ALTDDIO_OUT_component.oe_reg = "UNREGISTERED",
            ALTDDIO_OUT_component.power_up_high = "OFF",
            ALTDDIO_OUT_component.width = 1;
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
    ,.clk_csr               (clk_mux                 )
    ,.rst_csr_n             (rst_mux_n               )
    ,.csr_write             (csr_write               )
    ,.csr_read              (csr_read                )
    ,.csr_addr              (csr_addr                )
    ,.csr_wr_data           (csr_wr_data             )
    ,.csr_rd_data           (csr_rd_data             )
    ,.csr_rd_valid          (csr_rd_valid            )
   );



  // Assigning params to status reg
  assign params_reg       = {NUMBER_OF_OUTPUTS[15:0],MULTIPLEX_RATIO[7:0],CLOCK_RATIO[7:0]};

  /* CSR reg read logic */
  always@(posedge clk_mux,  negedge rst_mux_n)
  begin
    if(~rst_mux_n)
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
        16 : /*  Params Reg */
        begin
          csr_rd_data         <=  params_reg;
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
