//----------------------------------------------------------------------------------------------------------------
//                               INTEL CONFIDENTIAL
//           Copyright 2013-2021 Intel Corporation All Rights Reserved. 
// 
// The source code contained or described herein and all documents related to the source code ("Material")
// are owned by Intel Corporation or its suppliers or licensors. Title to the Material remains with Intel
// Corporation or its suppliers and licensors. The Material contains trade secrets and proprietary and confidential
// information of Intel or its suppliers and licensors. The Material is protected by worldwide copyright and trade
// secret laws and treaty provisions. No part of the Material may be used, copied, reproduced, modified, published,
// uploaded, posted, transmitted, distributed, or disclosed in any way without Intel's prior express written
// permission.
// 
// No license under any patent, copyright, trade secret or other intellectual property right is granted to or
// conferred upon you by disclosure or delivery of the Materials, either expressly, by implication, inducement,
// estoppel or otherwise. Any license under such intellectual property rights must be express and approved by
// Intel in writing.
//----------------------------------------------------------------------------------------------------------------
// Version and Release Control Information:
//
// File Name:$RCSfile:$
// File Revision:$
// Created by:    Balaji G
// Updated by:    $Author:$ $Date:$
//------------------------------------------------------------------------------
// Parallel demux with adjustable sync clock version to take care of undeterministic delay between clock sync across fpgas
//------------------------------------------------------------------------------


`timescale 10fs/10fs

module IW_fpga_demux_v3 #(
    parameter NUMBER_OF_INPUTS     = 5
  , parameter CLOCK_RATIO          = 56 // RATIO between fast clock and system clock
  , parameter INPUT_BUDGET         = 1  // Number of fast clock required for slow to fast clock path. set Mutlicycle in sdc accordingly. Min 2 required
  , parameter SYNC_DELAY           = 0  // Skew between 2 FPGA system clk. The SYNC ckt works on much lower mux clock ratio and its possible we have a skew between system clock.Min 2 required
  , parameter SRC_SYNC_DELAY       = 1  // Max number of fast clock  required for DATA to make it on the receiver. This does not come into data latching timing, but overall guaranteed single clock margin. This includes pad + routing + ddr conversion latency on either side
  , parameter OUTPUT_BUDGET        = 1  // Number of fast clock required for fast to slow path on receiver. Set MC in sdc.
  , parameter MULTIPLEX_RATIO      = ((CLOCK_RATIO - INPUT_BUDGET - SYNC_DELAY - SRC_SYNC_DELAY - OUTPUT_BUDGET)*2)
  , parameter FPGA_FAMILY          = "S10"
  , parameter INFRA_AVST_CHNNL_W   = 8
  , parameter INFRA_AVST_DATA_W    = 8
  , parameter INFRA_AVST_CHNNL_ID  = 8

  , parameter CSR_ADDR_WIDTH       = 3*INFRA_AVST_DATA_W
  , parameter CSR_DATA_WIDTH       = 4*INFRA_AVST_DATA_W

  , parameter INSTANCE_NAME        = "u_demux_v3"  //Can hold upto 16 ASCII characters

) (
    input                                 rst_demux_n
  , input                                 clk_demux    // deMux source sync clk
  , output reg [(NUMBER_OF_INPUTS*MULTIPLEX_RATIO)-1:0] outbus
  , inout  [NUMBER_OF_INPUTS-1:0]         inbus
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

    reg   [IW_logb2(CLOCK_RATIO) : 0]     rcv_cnt;
    reg   [IW_logb2(CLOCK_RATIO) : 0]     clk_cnt;
    reg   [IW_logb2(CLOCK_RATIO) : 0]     first_cnt;
    reg   [IW_logb2(CLOCK_RATIO) : 0]     last_cnt;
    reg                                   slow_edge_3d;
    reg                                   slow_edge_2d;
    reg                                   slow_edge_async;
    wire                                  slow_edge;
//    wire                                  local_clk_demux_int;
    reg  [(NUMBER_OF_INPUTS*2)-1:0]       demux_data;
    reg  [(NUMBER_OF_INPUTS*2)-1:0]       demux_data_d;
    wire [(NUMBER_OF_INPUTS*2)-1:0]       demux_data_swap1;
    wire [(NUMBER_OF_INPUTS*2)-1:0]       demux_data_swap2;
    wire [(NUMBER_OF_INPUTS*2)-1:0]       demux_data_swap3;
    reg  [(NUMBER_OF_INPUTS*2)-1:0]       demux_data_final;
    wire [1:0]                            sync_err_sticky;
    reg                                   sync_err_clr;
    reg                                   no_transition;
    reg  [3:1]                            swap;
    reg  [1:0]                            sync_err;

    reg   [3 : 0]                         cstate;
    reg   [3 : 0]                         nstate;

    wire                                  csr_write;
    wire                                  csr_read;
    wire [(3*INFRA_AVST_CHNNL_W)-1:0]     csr_addr;
    wire [(4*INFRA_AVST_DATA_W)-1:0]      csr_wr_data;
    reg  [(4*INFRA_AVST_DATA_W)-1:0]      csr_rd_data;
    reg                                   csr_rd_valid;
    wire [31:0]                           params0_reg;
    wire [31:0]                           params1_reg;
    integer n;
    reg  [0:15][7:0]                      inst_name_str = INSTANCE_NAME;

    parameter                      IDLE_ST      = 3'h0;
    parameter                      SYNC1_ST     = 3'h1;
    parameter                      SYNC2_ST     = 3'h2;
    parameter                      RCV_ST       = 3'h3;


    parameter    SYNC_PATTERN1    = {NUMBER_OF_INPUTS{2'b01}};
    parameter    SYNC_PATTERN2    = {NUMBER_OF_INPUTS{2'b10}};
    parameter    RECEIVE_CNT      = MULTIPLEX_RATIO/2;

assign slow_edge = slow_edge_2d & ~slow_edge_3d;

//// enable signal generation which is equal to clk but a signal
//  IW_fpga_clk_derive  u_IW_fpga_clk_derive
//  (
//      .clk_in         (clk)
//     ,.rst_in_n       (rst_logic_n)
//     ,.clk_derive_out (local_clk_demux_int)
//  );
//assign local_clk_demux_int = clk_logic_derive;


// Sequence count starting from rising edge of system clk
always @(posedge clk_demux or negedge rst_demux_n ) begin
  if ( !rst_demux_n ) begin
    slow_edge_async  <= 1'b1;
    slow_edge_2d <= 1'b1;
    slow_edge_3d <= 1'b1;
    clk_cnt      <= '0;
    first_cnt    <= '0;
    last_cnt     <= '0;
  end
  else begin
    slow_edge_async  <= (clk_cnt == 0);
    slow_edge_2d <= slow_edge_async;
    slow_edge_3d <= slow_edge_2d;
    // simple counter to determine the fast count on the slow clock
    if ( (clk_cnt == (CLOCK_RATIO-1)) ) clk_cnt <= 'h0;
    else clk_cnt <= clk_cnt + 1'b1;

    if ( nstate[IDLE_ST] &  cstate[RCV_ST] )  last_cnt  <= clk_cnt;
    if ( nstate[RCV_ST]  &  cstate[SYNC2_ST] )  first_cnt <= clk_cnt;
  end
end

// SM to send sync and then data
always @(*) begin
  nstate = 0;
  sync_err = 2'b0;
  case (1'b1) // synopsys full_case parallel_case
    // wait to reach time for transmitting sync
    cstate[IDLE_ST  ] : 
    begin
      if ( demux_data_d == SYNC_PATTERN1       || demux_data_swap1 == SYNC_PATTERN1  ||
           demux_data_swap2 == SYNC_PATTERN1   || demux_data_swap3 == SYNC_PATTERN1 )  
        nstate[SYNC1_ST] = 1'b1;
      else nstate[IDLE_ST] = 1'b1;
      if ( slow_edge & no_transition )  sync_err = 2'b11;
    end
    // transmit sync1 pattern. receiver checks and locks 
    cstate[SYNC1_ST ] : 
    begin
      if ( ( demux_data_d == SYNC_PATTERN2  && (swap[3:1] == 3'b0))   || ( demux_data_swap1 == SYNC_PATTERN2 & swap[1]) ||
           ( demux_data_swap2 == SYNC_PATTERN2 & swap[2]) || ( demux_data_swap3 == SYNC_PATTERN2 & swap[3]) ) 
        nstate[SYNC2_ST] = 1'b1;
      // if second pattern does not match, then its still misaligned. Check for first pattern in the same clock
      else if ( demux_data_d == SYNC_PATTERN1       || demux_data_swap1 == SYNC_PATTERN1  ||
           demux_data_swap2 == SYNC_PATTERN1   || demux_data_swap3 == SYNC_PATTERN1 )  
        nstate[SYNC1_ST] = 1'b1;
      else  begin
        nstate[IDLE_ST] = 1'b1;
         // error when it does not see seq of sync
        sync_err = 2'b01;
      end
    end
    // transmit sync2 pattern. Ensure its sync. 
    cstate[SYNC2_ST ] : 
    begin
      nstate[RCV_ST] = 1'b1;
    end
    // Transmit data immediately after sync.
    cstate[RCV_ST   ] : 
    begin
      if ( rcv_cnt == RECEIVE_CNT)  nstate[IDLE_ST] = 1'b1;
      else nstate[RCV_ST] = 1'b1;
      // assert sync error when its stuck at this state for next rising edge of slow clk
      if ( slow_edge )  sync_err = 2'b10;
    end
  endcase
end

always @(posedge clk_demux or negedge rst_demux_n ) begin
  if ( !rst_demux_n ) begin
    cstate[IDLE_ST]   <= 1'b1;
    cstate[SYNC1_ST]  <= 1'b0;
    cstate[SYNC2_ST]  <= 1'b0;
    cstate[RCV_ST  ]  <= 1'b0;
    rcv_cnt           <= 'h0;
    no_transition     <= 1'b1;
    swap[3:1]         <= 3'b0;
  end
  else begin
    cstate            <= nstate;

    rcv_cnt           <= 'h0;
    if ( cstate[RCV_ST] ) begin
      rcv_cnt  <= rcv_cnt + 1;
    end

    if ( cstate[IDLE_ST] || ( cstate[SYNC1_ST] & nstate[SYNC1_ST]) ) begin
      if ( demux_data_swap1 == SYNC_PATTERN1 )  swap[1] <= 1'b1;
      else swap[1] <= 1'b0;
      if ( demux_data_swap2 == SYNC_PATTERN1 )  swap[2] <= 1'b1;
      else swap[2] <= 1'b0;
      if ( demux_data_swap3 == SYNC_PATTERN1 )  swap[3] <= 1'b1;
      else swap[3] <= 1'b0;
    end
    else if ( cstate[SYNC1_ST] & !nstate[SYNC1_ST] ) begin
      if ( demux_data_swap1 == SYNC_PATTERN2 )  swap[1] <= 1'b1;
      else swap[1] <= 1'b0;
      if ( demux_data_swap2 == SYNC_PATTERN2 )  swap[2] <= 1'b1;
      else swap[2] <= 1'b0;
      if ( demux_data_swap3 == SYNC_PATTERN2 )  swap[3] <= 1'b1;
      else swap[3] <= 1'b0;
    end

  case (1'b1) // synopsys full_case parallel_case
    // wait to reach time for transmitting sync
    nstate[IDLE_ST  ] : 
    begin
      if ( slow_edge )  no_transition <= 1'b1;
    end
    // transmit sync1 pattern. receiver checks and locks 
    nstate[SYNC1_ST ] : 
    begin
      no_transition    <= 1'b0;
    end
    // transmit sync2 pattern. Ensure its sync. 
    nstate[SYNC2_ST ] : 
    begin
      no_transition    <= 1'b0;
    end
    // Transmit data
    nstate[RCV_ST   ] : 
    begin
      no_transition    <= 1'b0;
    end
  endcase
  end
end

// outbus datapath
always @(posedge clk_demux ) begin
  demux_data_final <= swap[1] ? demux_data_swap1 :
                      swap[2] ? demux_data_swap2 : 
                      swap[3] ? demux_data_swap3 : demux_data_d;

  if ( cstate[RCV_ST] ) begin
    outbus[ (NUMBER_OF_INPUTS*2)*rcv_cnt +: NUMBER_OF_INPUTS*2] <= demux_data_final ;
  end
end

genvar  s;

generate
 for (s=0; s < NUMBER_OF_INPUTS; s=s+1) begin: g_buffers
   IW_ddr_ibuf_combo #(
     .FPGA_FAMILY(FPGA_FAMILY)
   ) u_ddr_ibuf_combo (
     .IO_DATA_IN(inbus[s]),
     .Q1(demux_data[2*s+1]), // posedge data
     .Q2(demux_data[2*s+0]), // negedge data
     .rst(1'b0),
     .clk(clk_demux));

   assign demux_data_swap1[2*s+1] = demux_data[2*s+0];
   assign demux_data_swap1[2*s+0] = demux_data_d[2*s+1];
   assign demux_data_swap2[2*s+1] = 1'b0;
   assign demux_data_swap2[2*s+0] = 1'b0;
   assign demux_data_swap3[2*s+1] = 1'b0;
   assign demux_data_swap3[2*s+0] = 1'b0;


   end // g_buffers

endgenerate

// Delay demux data to check across higher and lower bytes with and without swap
always @(posedge clk_demux ) begin
  demux_data_d  <= demux_data;
end
  /*  Generate a sticky version of ECC Error  */
  IW_sticky_bit #(
    .WIDTH  (2)
  ) u_IW_sticky_bit_ecc_err (
     .clk     (clk_demux)
    ,.rst_n   (rst_demux_n)

    ,.diag    (1'b1)

    ,.d       (sync_err)
    ,.write   (sync_err_clr)
    ,.wdata   (2'b0)

    ,.q       (sync_err_sticky)
  );


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

  // assigning parameters to registers for user access
  assign params0_reg = {NUMBER_OF_INPUTS[7:0],SRC_SYNC_DELAY[3:0],SYNC_DELAY[3:0],OUTPUT_BUDGET[3:0],INPUT_BUDGET[3:0],4'b0,4'b0011/*V3*/};
  assign params1_reg = {MULTIPLEX_RATIO[15:0],CLOCK_RATIO[15:0]};

  /* CSR reg write logic */
  always@(posedge clk_demux,  negedge rst_demux_n)
  begin
    if(~rst_demux_n)
    begin
      sync_err_clr      <=  0;
    end
    else
    begin
      /*  Write Logic */
      if(csr_write)
      begin
        case(csr_addr)
          28 : //clr  err
          begin
            sync_err_clr      <=  csr_wr_data[0];
          end
        endcase
      end
    end
  end

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
        20 : /*  Params1 Reg */
        begin
          csr_rd_data         <=  params1_reg;
        end
        24 : /*  Status Reg */
        begin
          csr_rd_data         <=  {(16'h0|last_cnt),(16'h0|first_cnt)};
        end
        28 : /*  Status err Reg */
        begin
          csr_rd_data         <=  {{CSR_DATA_WIDTH-2{1'b0}},sync_err_sticky};
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

//------------------------------------------------------------------------------
// Change History:
//
// $Log:$
//
//------------------------------------------------------------------------------

