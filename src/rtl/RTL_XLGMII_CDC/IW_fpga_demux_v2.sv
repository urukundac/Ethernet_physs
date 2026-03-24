//----------------------------------------------------------------------------------------------------------------
//                               INTEL CONFIDENTIAL
//           Copyright 2013-2014 Intel Corporation All Rights Reserved. 
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
// IW_fpga_demux_v2 rewritten from earlier version to support programmable clock ratio
//------------------------------------------------------------------------------


module IW_fpga_demux_v2   #(

    parameter NUMBER_OF_INPUTS     = 16
  , parameter MULTIPLEX_RATIO      =  6
  , parameter CLOCK_RATIO          =  4
  , parameter FPGA_FAMILY          = "S5"
  , parameter INFRA_AVST_CHNNL_W   = 8
  , parameter INFRA_AVST_DATA_W    = 8
  , parameter INFRA_AVST_CHNNL_ID  = 8
  , parameter INSTANCE_NAME        = "IW_fpga_demux_v2" //Can hold upto 16 ASCII characters
  , parameter AVST2CSR_BYPASS_EN   = 0
  , parameter CSR_ADDR_WIDTH       = 3*INFRA_AVST_DATA_W
  , parameter CSR_DATA_WIDTH       = 4*INFRA_AVST_DATA_W

  , parameter DEMUX_DATA_GRADUAL   = 1 // 1: demuxed data changes bit after bit
)

(
    inout                     [NUMBER_OF_INPUTS-1:0] inbus
  , input                                            clk_demux
  , input                                            rst_demux_n
  , output reg  [(NUMBER_OF_INPUTS*MULTIPLEX_RATIO)-1:0] outbus
  , output reg                                           ecc_err
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

  , input                                 ext_csr_write
  , input                                 ext_csr_read
  , input  [CSR_ADDR_WIDTH-1:0]           ext_csr_addr
  , input  [CSR_DATA_WIDTH-1:0]           ext_csr_wr_data
  , output [CSR_DATA_WIDTH-1:0]           ext_csr_rd_data
  , output                                ext_csr_rd_valid
  , output [15:0]                         la_debug
    );

    /*  Debug Data Parameters */
    localparam  DEBUG_REG_W       = 32;
    localparam  NUM_DEBUG_REGS    = 16;

    // Splitting the bus into multiple chunks to close timing. Split count is set to 10
    localparam  NUMBER_OF_SPLIT   = (NUMBER_OF_INPUTS>10) ? (NUMBER_OF_INPUTS/10)+1 : 2;

    `include "IW_logb2.svh"

    reg   [IW_logb2(CLOCK_RATIO) : 0]                    rcv_cnt /*synthesis dont_merge syn_maxfan=256*/;
    wire  [(NUMBER_OF_INPUTS*2)-1:0] demux_data;
    reg  [(NUMBER_OF_INPUTS*2)-1:0] debug_reg;
    reg  [(NUMBER_OF_INPUTS*2*CLOCK_RATIO)-1:0] outbus_reg;
    reg  [(NUMBER_OF_INPUTS*MULTIPLEX_RATIO)-1:0] outbus_prev_reg;
    reg  [(NUMBER_OF_INPUTS*MULTIPLEX_RATIO)-1:0] outbus_wire;
    reg   ecc_err_clr;
    wire  ecc_err_sticky;

// ECC generation and transmission over unutilized 4 edges of clock
    localparam NUMBER_OF_256PAIRS=  (((NUMBER_OF_INPUTS*MULTIPLEX_RATIO)/256)+
                                     (((NUMBER_OF_INPUTS*MULTIPLEX_RATIO)%256)!=0)); // Should be <= (MULTIPLEX_RATIO/10)
    localparam wdth = 256;
    localparam cbts = 10;

    //Check if enough bandwidth is available to receive atleast 10bits of ecc
    localparam  ECC_EN  = ((((NUMBER_OF_INPUTS*CLOCK_RATIO*2) - (NUMBER_OF_INPUTS*MULTIPLEX_RATIO)) >= (cbts*NUMBER_OF_256PAIRS)) && (CLOCK_RATIO>3)) ? 1 : 0;

    reg    [(wdth*NUMBER_OF_256PAIRS)-1 : 0 ]  data_in_reg;
    reg    [(cbts*NUMBER_OF_256PAIRS)-1 : 0 ]  ecc_gen;
    wire   [(NUMBER_OF_256PAIRS)-1 : 0 ]       ecc_err_detect;
    wire   [(NUMBER_OF_256PAIRS)-1 : 0 ]       ecc_err_multpl;
    integer                                    split_bus;

    wire                               csr_write;
    wire                               csr_read;
    wire [CSR_ADDR_WIDTH-1:0]          csr_addr;
    wire [CSR_DATA_WIDTH-1:0]          csr_wr_data;
    reg  [CSR_DATA_WIDTH-1:0]          csr_rd_data;
    reg                                csr_rd_valid;
    wire [31:0]                        params_reg;
    wire [31:0]                        status_reg;
    integer n;
    reg  [0:15][7:0]                   inst_name_str = INSTANCE_NAME;

// Sequence count starting from rising edge of system clk

always @(posedge clk_demux or negedge rst_demux_n ) begin
  if ( !rst_demux_n ) begin
      rcv_cnt   <= 0;
  end
  else begin
    // simple counter to determine the fast count on the slow clock
      if ( rcv_cnt == (CLOCK_RATIO-1) ) rcv_cnt<= 0;
      else rcv_cnt <= rcv_cnt + 1'b1;

  end
end

always @(*) begin
  // Shift data to right to remove the unwanted edges out of the valid data
  // keep only valid data at the rising edge
  
//  outbus   = (rcv_cnt == CLOCK_RATIO-1) ?  outbus_wire
//                                        : {NUMBER_OF_INPUTS*MULTIPLEX_RATIO{1'b0}};;
// Changed to keep the data valid for whole cycle. This will take care of asycn reset that is routed through
// mux. Looks more clean. 
    outbus_wire = outbus_reg[(NUMBER_OF_INPUTS*MULTIPLEX_RATIO)+(NUMBER_OF_INPUTS*4)-1:(NUMBER_OF_INPUTS*4)];

  if(DEMUX_DATA_GRADUAL)
    outbus      = outbus_wire;
  else
    outbus      = (rcv_cnt == CLOCK_RATIO-1) ?  outbus_wire
                                             :  outbus_prev_reg;
end

// Register the outbus_wire to improve timing
always @(posedge clk_demux ) begin
  if ( rcv_cnt == CLOCK_RATIO-1) outbus_prev_reg <= outbus_wire;
end

always @(negedge clk_demux ) begin
    outbus_reg[ (NUMBER_OF_INPUTS*2)*rcv_cnt +: NUMBER_OF_INPUTS*2] <= demux_data;
    //outbus_reg <= {demux_data,outbus_reg[(NUMBER_OF_INPUTS*2*CLOCK_RATIO)-1:(NUMBER_OF_INPUTS*2)]};
    debug_reg <= demux_data;
      
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

  end // g_buffers
endgenerate



//============================================================
// Added ECC Generators and Checkers. 
// this uses the Synopsys DW_ecc designware component. may need
// to tune parameters for better error detection depending on channel 
// Note : errors are only detected, NOT corrected
//============================================================

 // Pipeline to safely break timing and capture the previous data reg for ecc check
 always @(posedge clk_demux ) begin
   if ( rcv_cnt == (CLOCK_RATIO-1) )
     data_in_reg   <= outbus | {(wdth*NUMBER_OF_256PAIRS){1'b0}};
 end

 generate
  if(ECC_EN)
  begin
    // Previous cycle ecc data is captured at the begining of the new cycle
    always @(posedge clk_demux ) begin
      if ( rcv_cnt == 2) 
        ecc_gen   <= outbus_reg[(cbts*NUMBER_OF_256PAIRS)-1 : 0 ] ;
    end
  end
  else  //~ECC_EN
  begin
    always@(*)
      ecc_gen = {(cbts*NUMBER_OF_256PAIRS){1'b0}};
  end
 endgenerate

 // check error after data_in of previous cycle and the ecc of it is received on the new cycle
 always @(posedge clk_demux ) begin
  // disable ecc if we dont have enough bandwidth to receive atleast 10bits of ecc 
  if (ECC_EN) begin
   if ( rcv_cnt == 3) 
     ecc_err   <= (|ecc_err_multpl) | (|ecc_err_detect);
  end
  else ecc_err <= 1'b0;
 end

 
 genvar                  ecc_i;
 generate
 
   //---------------------------------
   // ECC Code generator
   //---------------------------------
   for (ecc_i=0; ecc_i<NUMBER_OF_256PAIRS; ecc_i=ecc_i+1) begin: ecc
     DW_ecc #(.width(wdth),.chkbits(cbts),.synd_sel(1)) u_eccrx (
          //--- Inputs ---
          .gen         ( 1'b0 ),
          .correct_n   ( 1'b1 ),
          .datain      ( data_in_reg[(ecc_i*wdth) +: wdth] ),
          .chkin       ( ecc_gen[(ecc_i*cbts) +: cbts] ),
          //--- Outputs ---
          .err_detect  ( ecc_err_detect[ecc_i] ),
          .err_multpl  ( ecc_err_multpl[ecc_i] ),
          .dataout     ( ),
          .chkout      ( ) );

   end
 endgenerate


  /*  Generate a sticky version of ECC Error  */
  IW_sticky_bit #(
    .WIDTH  (1)
  ) u_IW_sticky_bit_ecc_err (
     .clk     (clk_demux)
    ,.rst_n   (rst_demux_n)

    ,.diag    (1'b1)

    ,.d       (ecc_err)
    ,.write   (ecc_err_clr)
    ,.wdata   (1'b0)

    ,.q       (ecc_err_sticky)
  );

generate 
  if (AVST2CSR_BYPASS_EN== 0) begin  
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

    assign ext_csr_rd_data  = 'h0;
    assign ext_csr_rd_valid = 'h0;

   end 
 else begin
    // Bypassing avalon streaming interface and using external csr interface
    assign avst_ingr_ready         = 'h0;
    assign avst_egr_valid          = 'h0;
    assign avst_egr_startofpacket  = 'h0;
    assign avst_egr_endofpacket    = 'h0;
    assign avst_egr_channel        = 'h0;
    assign avst_egr_data           = 'h0; 

    assign csr_write               = ext_csr_write;
    assign csr_read                = ext_csr_read;
    assign csr_addr                = ext_csr_addr;
    assign csr_wr_data             = ext_csr_wr_data;
    assign ext_csr_rd_data         = csr_rd_data;
    assign ext_csr_rd_valid        = csr_rd_valid;

   end  
 endgenerate


  /* CSR reg write logic */
  always@(posedge clk_demux,  negedge rst_demux_n)
  begin
    if(~rst_demux_n)
    begin
      ecc_err_clr      <=  0;
    end
    else
    begin
      /*  Write Logic */
      if(csr_write)
      begin
        case(csr_addr)
          24 : //Control register
          begin
            ecc_err_clr      <=  csr_wr_data[0];
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
        16 : /*  Params Reg */
        begin
          csr_rd_data         <=  params_reg;
        end
        20 : /* Status Reg */
        begin
          csr_rd_data         <=  status_reg;
        end
        24 : /* Control Reg */
        begin
          csr_rd_data         <=  {((4*INFRA_AVST_DATA_W)-1),ecc_err_clr};
        end
        28 : /* Control Reg */
        begin
          csr_rd_data         <=  outbus;
        end
        32 : /* Control Reg */
        begin
          csr_rd_data         <=  debug_reg;
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

  // Assigning params & control signals to reg
  //Param0 Register
  assign  params_reg[31:24]  = NUMBER_OF_INPUTS;
  assign  params_reg[23:16]  = MULTIPLEX_RATIO;
  assign  params_reg[15:8]   = CLOCK_RATIO;
  assign  params_reg[7:5]    = 'h0;   //Reserved
  assign  params_reg[4]      = ECC_EN;
  assign  params_reg[3:0]    = 'h02;   //Version

  //Status0 Register
  assign  status_reg         = { {(DEBUG_REG_W-1){1'b0}}
                                  ,ecc_err_sticky           //  Bits  0:0
                                };

endmodule
