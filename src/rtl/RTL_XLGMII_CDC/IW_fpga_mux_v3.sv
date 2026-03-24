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
// Parallel mux with adjustable sync clock version to take care of undeterministic delay between clock sync across fpgas
//------------------------------------------------------------------------------


`timescale 10fs/10fs

module IW_fpga_mux_v3 #(
    parameter NUMBER_OF_OUTPUTS    = 5
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

  , parameter INSTANCE_NAME        = "u_mux_v3"  //Can hold upto 16 ASCII characters
 ) (
    input                                            rst_mux_n
  , input                                            clk_mux    // Mux clock sync to clk
  , input  [(NUMBER_OF_OUTPUTS*MULTIPLEX_RATIO)-1:0] inbus
  , inout  [NUMBER_OF_OUTPUTS-1:0]                   outbus
  // Infra-Avst Ports
  , input                                            clk_avst
  , input                                            rst_avst_n
  , output                                           avst_ingr_ready
  , input                                            avst_ingr_valid
  , input                                            avst_ingr_startofpacket
  , input                                            avst_ingr_endofpacket
  , input  [INFRA_AVST_CHNNL_W-1:0]                  avst_ingr_channel
  , input  [INFRA_AVST_DATA_W-1:0]                   avst_ingr_data

  , input                                            avst_egr_ready
  , output                                           avst_egr_valid
  , output                                           avst_egr_startofpacket
  , output                                           avst_egr_endofpacket
  , output [INFRA_AVST_CHNNL_W-1:0]                  avst_egr_channel
  , output [INFRA_AVST_DATA_W-1:0]                   avst_egr_data

);

    `include "IW_logb2.svh"

    reg   [IW_logb2(CLOCK_RATIO) : 0]                fast_cnt;
    reg   [IW_logb2(CLOCK_RATIO) : 0]                end_cnt;
    reg   [IW_logb2(CLOCK_RATIO) : 0]                xmt_cnt;
    reg   [IW_logb2(CLOCK_RATIO) : 0]                first_cnt;
    reg   [IW_logb2(CLOCK_RATIO) : 0]                last_cnt;
//    wire                                             local_clk_mux_int;
//    reg                                              slow_edge_d;
    reg  [(NUMBER_OF_OUTPUTS*2)-1:0]                 mux_data;

    reg   [3 : 0]                                    cstate;
    reg   [3 : 0]                                    nstate;

    wire                                             csr_write;
    wire                                             csr_read;
    wire [(3*INFRA_AVST_CHNNL_W)-1:0]                csr_addr;
    wire [(4*INFRA_AVST_DATA_W)-1:0]                 csr_wr_data;
    reg  [(4*INFRA_AVST_DATA_W)-1:0]                 csr_rd_data;
    reg                                              csr_rd_valid;
    wire [31:0]                                      params0_reg;
    wire [31:0]                                      params1_reg;
    integer n;
    reg  [0:15][7:0]                                 inst_name_str = INSTANCE_NAME;

    parameter                      IDLE_ST      = 3'h0;
    parameter                      SYNC1_ST     = 3'h1;
    parameter                      SYNC2_ST     = 3'h2;
    parameter                      XMT_ST       = 3'h3;


    parameter    MUX_LATENCY      =  2;  // Design latency due to mux pipeline. nullfied in START_SYNC calc
    parameter    SYNC_DELAY_MIN   =  SYNC_DELAY>2 ? SYNC_DELAY : MUX_LATENCY;
    parameter    SYNC_PATTERN1    = {NUMBER_OF_OUTPUTS{2'b01}};
    parameter    SYNC_PATTERN2    = {NUMBER_OF_OUTPUTS{2'b10}};
    parameter    START_SYNC       = (SYNC_DELAY_MIN>=INPUT_BUDGET) ? (SYNC_DELAY_MIN-INPUT_BUDGET) : (INPUT_BUDGET-MUX_LATENCY);
    parameter    TRANSMIT_CNT     = MULTIPLEX_RATIO/2;

//assign slow_edge = local_clk_mux_int & ~slow_edge_d;

//// enable signal generation which is equal to clk but a signal
//  IW_fpga_clk_derive  u_IW_fpga_clk_derive
//  (
//      .clk_in         (clk)
//     ,.rst_in_n       (rst_logic_n)
//     ,.clk_derive_out (local_clk_mux_int)
//  );
//
//assign local_clk_mux_int = clk_logic_derive;

// Sequence count starting from rising edge of system clk
always @(posedge clk_mux or negedge rst_mux_n ) begin
  if ( !rst_mux_n ) begin
//    slow_edge_d  <= 1'b1;
    fast_cnt     <= 'h0;
    end_cnt      <= CLOCK_RATIO-1;
    first_cnt    <= '0;
    last_cnt     <= '0;
  end
  else begin
//    slow_edge_d  <= local_clk_mux_int;
    // simple counter to determine the fast count on the slow clock
    if ( (end_cnt == (CLOCK_RATIO-1)) ) end_cnt <= 'h0;
    else end_cnt <= end_cnt + 1'b1;
    
    // Move ahead the count so that the design delay like FSM, first flop stage gets neutralized
    if ( end_cnt == ((CLOCK_RATIO-1)-2) ) fast_cnt <= 'h0;
    else fast_cnt <= fast_cnt + 1'b1;

    if ( nstate[IDLE_ST] &  cstate[XMT_ST] )  last_cnt  <= fast_cnt;
    if ( nstate[XMT_ST]  &  cstate[SYNC2_ST] )  first_cnt <= fast_cnt;
  end
end

// SM to send sync and then data
always @(*) begin
  nstate = 0;
  case (1'b1) // synopsys full_case parallel_case
    // wait to reach time for transmitting sync
    cstate[IDLE_ST  ] : 
    begin
      if ( fast_cnt == START_SYNC )  nstate[SYNC1_ST] = 1'b1;
      else nstate[IDLE_ST] = 1'b1;
    end
    // transmit sync1 pattern. receiver checks and locks 
    cstate[SYNC1_ST ] : 
    begin
      nstate[SYNC2_ST] = 1'b1;
    end
    // transmit sync2 pattern. Ensure its sync. 
    cstate[SYNC2_ST ] : 
    begin
      nstate[XMT_ST] = 1'b1;
    end
    // Transmit data immediately after sync.
    cstate[XMT_ST   ] : 
    begin
      if ( fast_cnt == TRANSMIT_CNT+SYNC_DELAY_MIN+START_SYNC )  nstate[IDLE_ST] = 1'b1;
      else nstate[XMT_ST] = 1'b1;
    end
  endcase
end

always @(posedge clk_mux or negedge rst_mux_n ) begin
  if ( !rst_mux_n ) begin
    cstate[IDLE_ST]   <= 1'b1;
    cstate[SYNC1_ST]  <= 1'b0;
    cstate[SYNC2_ST]  <= 1'b0;
    cstate[XMT_ST  ]  <= 1'b0;
    mux_data          <= {NUMBER_OF_OUTPUTS*2{1'b0}};
    xmt_cnt           <= 'h0;
  end
  else begin
    cstate            <= nstate;
    xmt_cnt           <= 'h0;
  case (1'b1) // synopsys full_case parallel_case
    // wait to reach time for transmitting sync
    nstate[IDLE_ST  ] : 
    begin
      mux_data          <= {NUMBER_OF_OUTPUTS*2{1'b0}};
    end
    // transmit sync1 pattern. receiver checks and locks 
    nstate[SYNC1_ST ] : 
    begin
      mux_data          <= SYNC_PATTERN1;
    end
    // transmit sync2 pattern. Ensure its sync. 
    nstate[SYNC2_ST ] : 
    begin
      mux_data          <= SYNC_PATTERN2;
    end
    // Transmit data
    nstate[XMT_ST   ] : 
    begin
      xmt_cnt  <= xmt_cnt + 1;
      mux_data <= inbus[ (NUMBER_OF_OUTPUTS*2)*xmt_cnt +: NUMBER_OF_OUTPUTS*2];
    end
  endcase
  end
end

genvar  s;

generate
 for (s=0; s < NUMBER_OF_OUTPUTS; s=s+1) begin: g_buffers
   IW_ddr_obuf_combo #(
     .FPGA_FAMILY(FPGA_FAMILY)
   ) u_ddr_obuf_combo (
     .IO_DATA_OUT(outbus[s]),
     .D1(mux_data[2*s+0]),
     .D2(mux_data[2*s+1]),
     .rst(1'b0),
     .clk(clk_mux));

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

  // assigning parameters to registers for user access
  assign params0_reg = {NUMBER_OF_OUTPUTS[7:0],SRC_SYNC_DELAY[3:0],SYNC_DELAY[3:0],OUTPUT_BUDGET[3:0],INPUT_BUDGET[3:0],4'b0,4'b0011/*V3*/};
  assign params1_reg = {MULTIPLEX_RATIO[15:0],CLOCK_RATIO[15:0]};

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

