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
// IW_fpga_mux_v2 rewritten from earlier version to support programmable clock ratio
//------------------------------------------------------------------------------


module IW_fpga_mux_v2   #(

    parameter NUMBER_OF_OUTPUTS    = 5
  , parameter MULTIPLEX_RATIO      = 6
  , parameter CLOCK_RATIO          = 4
  , parameter FPGA_FAMILY          = "S5"
  , parameter INFRA_AVST_CHNNL_W   = 8
  , parameter INFRA_AVST_DATA_W    = 8
  , parameter INFRA_AVST_CHNNL_ID  = 8
  , parameter INSTANCE_NAME        = "u_fpga_mux_v2"  //Can hold upto 16 ASCII characters
  , parameter AVST2CSR_BYPASS_EN   = 0
  , parameter CSR_ADDR_WIDTH       = 3*INFRA_AVST_DATA_W
  , parameter CSR_DATA_WIDTH       = 4*INFRA_AVST_DATA_W
)
(
  // inputs from the other FPGA
    input                      rst_mux_n
  , input                      clk_mux
  , input  [(NUMBER_OF_OUTPUTS*MULTIPLEX_RATIO)-1:0] inbus
   
  , inout   [NUMBER_OF_OUTPUTS-1:0] outbus

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
 );

    /*  Debug Data Parameters */
    localparam  DEBUG_REG_W       = 32;
    localparam  NUM_DEBUG_REGS    = 16;

    `include "IW_logb2.svh"

    reg   [IW_logb2(CLOCK_RATIO) : 0]    xmt_cnt;
    reg  [(NUMBER_OF_OUTPUTS*2)-1:0] mux_data;
    wire [(NUMBER_OF_OUTPUTS*2*CLOCK_RATIO)-1:0] inbus_w;

// ECC generation and transmission over unutilized 4 edges of clock
    localparam NUMBER_OF_256PAIRS=  (((NUMBER_OF_OUTPUTS*MULTIPLEX_RATIO)/256)+
                                     (((NUMBER_OF_OUTPUTS*MULTIPLEX_RATIO)%256)!=0)); // Should be <= (MULTIPLEX_RATIO/10)
    localparam wdth = 256;
    localparam cbts = 10;

    reg    [(wdth*NUMBER_OF_256PAIRS)-1 : 0 ]  data_in_reg;
    wire   [(cbts*NUMBER_OF_256PAIRS)-1 : 0 ]  ecc_gen_w;
    reg    [(cbts*NUMBER_OF_256PAIRS)-1 : 0 ]  ecc_gen;

    integer n;
    reg  [0:15][7:0]                   inst_name_str = INSTANCE_NAME;
    wire                               csr_write;
    wire                               csr_read;
    wire [CSR_ADDR_WIDTH-1:0]          csr_addr;
    wire [CSR_DATA_WIDTH-1:0]          csr_wr_data;
    reg  [CSR_DATA_WIDTH-1:0]          csr_rd_data;
    reg                                csr_rd_valid;
    wire [31:0]                        params_reg;

   assign inbus_w = (ecc_gen<<(NUMBER_OF_OUTPUTS*MULTIPLEX_RATIO)) | inbus | {(NUMBER_OF_OUTPUTS*2*CLOCK_RATIO){1'b0}};

// Sequence count starting from rising edge of system clk
// transmit inbus on every fast clock

always @(posedge clk_mux or negedge rst_mux_n ) begin
  if ( !rst_mux_n ) begin
    xmt_cnt           <= 8'h0;
  end
  else begin
    // simple counter to determine the fast count on the slow clock
    if ( xmt_cnt == (CLOCK_RATIO-1) ) xmt_cnt <= 8'h0;
    else xmt_cnt <= xmt_cnt + 1'b1;
    
  end
end

always @(negedge clk_mux or negedge rst_mux_n ) begin
  if ( !rst_mux_n ) begin
    mux_data          <= {NUMBER_OF_OUTPUTS*2{1'b0}};
  end
  else begin
    mux_data <= inbus_w[ (NUMBER_OF_OUTPUTS*2)*xmt_cnt +: NUMBER_OF_OUTPUTS*2];
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

//============================================================
// Added ECC Generators and Checkers. 
// this uses the Synopsys DW_ecc designware component. may need
// to tune parameters for better error detection depending on channel 
// Note : errors are only detected, NOT corrected
//============================================================

 // Pipeline to safely break timing
 always @(posedge clk_mux ) begin
   data_in_reg   <= inbus | {(wdth*NUMBER_OF_256PAIRS){1'b0}};
 end

 always @(posedge clk_mux ) begin
   ecc_gen   <= ecc_gen_w ;
 end

 
 genvar                  ecc_i;
 generate
 
   //---------------------------------
   // ECC Code generator
   //---------------------------------
   for (ecc_i=0; ecc_i<NUMBER_OF_256PAIRS; ecc_i=ecc_i+1) begin: ecc
     DW_ecc #(.width(wdth),.chkbits(cbts),.synd_sel(0)) u_ecctx (
          //--- Inputs ---
          .gen         ( 1'b1 ),
          .correct_n   ( 1'b0 ),
          .datain      ( data_in_reg[(ecc_i*wdth) +: wdth] ),
          .chkin       ( {cbts{1'b0}}),
          //--- Outputs ---
          .err_detect  ( ),
          .err_multpl  ( ),
          .dataout     ( ),
          .chkout      ( ecc_gen_w[(ecc_i*cbts) +: cbts] ));
   end
 endgenerate

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
      ,.clk_csr               (clk_mux                 )
      ,.rst_csr_n             (rst_mux_n               )
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
    // Tie off avalon streaming interface and using external csr interface
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

  // Assigning params to status reg
  assign params_reg[31:24]  = NUMBER_OF_OUTPUTS;
  assign params_reg[23:16]  = MULTIPLEX_RATIO;
  assign params_reg[15:8]   = CLOCK_RATIO;
  assign params_reg[7:4]    = 'h0;   //Reserved
  assign params_reg[3:0]    = 'h02;   //Version

endmodule
