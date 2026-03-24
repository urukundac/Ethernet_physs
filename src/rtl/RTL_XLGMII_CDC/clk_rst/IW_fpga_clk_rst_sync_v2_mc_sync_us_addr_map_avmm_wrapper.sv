//------------------------------------------------------------------------------
//                               INTEL CONFIDENTIAL
//           Copyright 2013-2014 Intel Corporation All Rights Reserved. 
// 
// The source code contained or described herein and all documents related
// to the source code ("Material") are owned by Intel Corporation or its 
// suppliers or licensors. Title to the Material remains with Intel
// Corporation or its suppliers and licensors. The Material contains trade
// secrets and proprietary and confidential information of Intel or its 
// suppliers and licensors. The Material is protected by worldwide copyright
// and trade secret laws and treaty provisions. No part of the Material 
// may be used, copied, reproduced, modified, published, uploaded, posted,
// transmitted, distributed, or disclosed in any way without Intel's prior
// express written permission.
// 
// No license under any patent, copyright, trade secret or other intellectual
// property right is granted to or conferred upon you by disclosure or delivery
// of the Materials, either expressly, by implication, inducement, estoppel or
// otherwise. Any license under such intellectual property rights must be
// express and approved by Intel in writing.
//------------------------------------------------------------------------------

/*
 --------------------------------------------------------------------------
 -- Project Code      : IMPrES
 -- Module Name       : IW_fpga_clk_rst_sync_v2_mc_sync_us_addr_map_avmm_wrapper 
 -- Author            : Vikas Akalwadi 
 -- Associated modules: 
 -- Function          : This module is a wrapper around the nebulon generated address map.
                        It gives a AVMM interface out.
 --------------------------------------------------------------------------
*/


`timescale 1ns/1ps

module IW_fpga_clk_rst_sync_v2_mc_sync_us_addr_map_avmm_wrapper #(
    parameter INSTANCE_NAME           = "u_fcs_v2_mc_sync_us"     //Can hold upto 16 ASCII characters
  , parameter MC_SYNC_US_WIDTH        = 1

  , parameter AV_MM_ADDR_W  = 8                     // Address width
  , parameter AV_MM_DATA_W  = 32                    // Data width
  , parameter READ_MISS_VAL = 32'hDEADBABE          // Read miss value
) (
    input  wire                        csi_clk                 // csi.clk
  , input  wire                        rsi_reset_n             // rsi.reset
  , input  wire [AV_MM_ADDR_W-1:0]     avs_s0_address          // avs_s0.address
  , output reg  [AV_MM_DATA_W-1:0]     avs_s0_readdata         //       .readdata
  , input  wire                        avs_s0_read             //       .read
  , output reg                         avs_s0_readdatavalid    //       .readdatavalid
  , input  wire                        avs_s0_write            //       .write
  , input  wire [AV_MM_DATA_W-1:0]     avs_s0_writedata        //       .writedata
  , input  wire [(AV_MM_DATA_W/8)-1:0] avs_s0_byteenable       //       .byteenable
  , output wire                        avs_s0_waitrequest      //       .waitrequest

  //Register inputs from HW
  , input logic [AV_MM_DATA_W-1:0]     rx_pulse_cnt_0
  , input logic [AV_MM_DATA_W-1:0]     tx_pulse_cnt_0
  , input logic [AV_MM_DATA_W-1:0]     rx_pulse_timer_reg_0
  , input logic [AV_MM_DATA_W-1:0]     rx_pulse_cnt_1
  , input logic [AV_MM_DATA_W-1:0]     tx_pulse_cnt_1
  , input logic [AV_MM_DATA_W-1:0]     rx_pulse_timer_reg_1
  , input logic [AV_MM_DATA_W-1:0]     rx_pulse_cnt_2
  , input logic [AV_MM_DATA_W-1:0]     tx_pulse_cnt_2
  , input logic [AV_MM_DATA_W-1:0]     rx_pulse_timer_reg_2
  , input logic [AV_MM_DATA_W-1:0]     rx_pulse_cnt_3
  , input logic [AV_MM_DATA_W-1:0]     tx_pulse_cnt_3
  , input logic [AV_MM_DATA_W-1:0]     rx_pulse_timer_reg_3

);

import IW_fpga_clk_rst_sync_v2_mc_sync_us_addr_map_pkg::*;
import rtlgen_pkg_IW_fpga_clk_rst_sync_v2_mc_sync_us_addr_map::*;

// Internal Parameters 
//AV_MM_ADDR_W is offset address width and HIGH_ADDR_W is base address width for
//this module.
localparam HIGH_ADDR_W   = 48-AV_MM_ADDR_W;
reg   [0:15][7:0] inst_name_str = INSTANCE_NAME;

// Internal Signals  
new_inst_name0_reg_cr_t                    new_inst_name0_reg_cr;
new_inst_name1_reg_cr_t                    new_inst_name1_reg_cr;
new_inst_name2_reg_cr_t                    new_inst_name2_reg_cr;
new_inst_name3_reg_cr_t                    new_inst_name3_reg_cr;

new_clk_param_0_reg_cr_t                       new_clk_param_0_reg_cr;

new_rx_pulse_cnt_0_reg_cr_t                    new_rx_pulse_cnt_0_reg_cr;
new_rx_pulse_cnt_1_reg_cr_t                    new_rx_pulse_cnt_1_reg_cr;
new_rx_pulse_cnt_2_reg_cr_t                    new_rx_pulse_cnt_2_reg_cr;
new_rx_pulse_cnt_3_reg_cr_t                    new_rx_pulse_cnt_3_reg_cr;
new_tx_pulse_cnt_0_reg_cr_t                    new_tx_pulse_cnt_0_reg_cr;
new_tx_pulse_cnt_1_reg_cr_t                    new_tx_pulse_cnt_1_reg_cr;
new_tx_pulse_cnt_2_reg_cr_t                    new_tx_pulse_cnt_2_reg_cr;
new_tx_pulse_cnt_3_reg_cr_t                    new_tx_pulse_cnt_3_reg_cr;
new_rx_pulse_timer_reg_0_reg_cr_t              new_rx_pulse_timer_reg_0_reg_cr;
new_rx_pulse_timer_reg_1_reg_cr_t              new_rx_pulse_timer_reg_1_reg_cr;
new_rx_pulse_timer_reg_2_reg_cr_t              new_rx_pulse_timer_reg_2_reg_cr;
new_rx_pulse_timer_reg_3_reg_cr_t              new_rx_pulse_timer_reg_3_reg_cr;

IW_fpga_clk_rst_sync_v2_mc_sync_us_addr_map_cr_req_t     reg_mod_req;
IW_fpga_clk_rst_sync_v2_mc_sync_us_addr_map_cr_ack_t     reg_mod_ack;

//Assigning HW inputs to register fields
always@(*)
begin
    for (int n=0;n<4;n++)
    begin
      new_inst_name0_reg_cr.inst_name[(n*8) +:  8]=  inst_name_str[15-n];
      new_inst_name1_reg_cr.inst_name[(n*8) +:  8]=  inst_name_str[15-4-n];
      new_inst_name2_reg_cr.inst_name[(n*8) +:  8]=  inst_name_str[15-8-n];
      new_inst_name3_reg_cr.inst_name[(n*8) +:  8]=  inst_name_str[15-12-n];
    end

  //This will take care of reserved fields having unknown values
  new_clk_param_0_reg_cr                  = 'h0;
  new_rx_pulse_cnt_0_reg_cr               = 'h0;
  new_rx_pulse_cnt_1_reg_cr               = 'h0;
  new_rx_pulse_cnt_2_reg_cr               = 'h0;
  new_rx_pulse_cnt_3_reg_cr               = 'h0;
  new_tx_pulse_cnt_0_reg_cr               = 'h0;
  new_tx_pulse_cnt_1_reg_cr               = 'h0;
  new_tx_pulse_cnt_2_reg_cr               = 'h0;
  new_tx_pulse_cnt_3_reg_cr               = 'h0;
  new_rx_pulse_timer_reg_0_reg_cr         = 'h0;
  new_rx_pulse_timer_reg_1_reg_cr         = 'h0;
  new_rx_pulse_timer_reg_2_reg_cr         = 'h0;
  new_rx_pulse_timer_reg_3_reg_cr         = 'h0;

  new_clk_param_0_reg_cr.MC_SYNC_US_WIDTH                = MC_SYNC_US_WIDTH;

  new_rx_pulse_cnt_0_reg_cr.rx_pulse_cnt_0               = rx_pulse_cnt_0;
  new_rx_pulse_cnt_1_reg_cr.rx_pulse_cnt_1               = rx_pulse_cnt_1;
  new_rx_pulse_cnt_2_reg_cr.rx_pulse_cnt_2               = rx_pulse_cnt_2;
  new_rx_pulse_cnt_3_reg_cr.rx_pulse_cnt_3               = rx_pulse_cnt_3;

  new_tx_pulse_cnt_0_reg_cr.tx_pulse_cnt_0               = tx_pulse_cnt_0;
  new_tx_pulse_cnt_1_reg_cr.tx_pulse_cnt_1               = tx_pulse_cnt_1;
  new_tx_pulse_cnt_2_reg_cr.tx_pulse_cnt_2               = tx_pulse_cnt_2;
  new_tx_pulse_cnt_3_reg_cr.tx_pulse_cnt_3               = tx_pulse_cnt_3;

  new_rx_pulse_timer_reg_0_reg_cr.rx_pulse_timer_reg_0   = rx_pulse_timer_reg_0;
  new_rx_pulse_timer_reg_1_reg_cr.rx_pulse_timer_reg_1   = rx_pulse_timer_reg_1;
  new_rx_pulse_timer_reg_2_reg_cr.rx_pulse_timer_reg_2   = rx_pulse_timer_reg_2;
  new_rx_pulse_timer_reg_3_reg_cr.rx_pulse_timer_reg_3   = rx_pulse_timer_reg_3;

end
 
// clock and reset sync register module instantiation
   IW_fpga_clk_rst_sync_v2_mc_sync_us_addr_map IW_fpga_clk_rst_sync_v2_mc_sync_us_addr_map_inst (
    // Clocks
    // Resets
    . rst_n                                 ( rsi_reset_n                      )
    // Register Inputs
    ,. new_inst_name0_reg_cr                ( new_inst_name0_reg_cr            )
    ,. new_inst_name1_reg_cr                ( new_inst_name1_reg_cr            )
    ,. new_inst_name2_reg_cr                ( new_inst_name2_reg_cr            )
    ,. new_inst_name3_reg_cr                ( new_inst_name3_reg_cr            )
    ,. new_rx_pulse_cnt_0_reg_cr            ( new_rx_pulse_cnt_0_reg_cr        )
    ,. new_rx_pulse_cnt_1_reg_cr            ( new_rx_pulse_cnt_1_reg_cr        )
    ,. new_rx_pulse_cnt_2_reg_cr            ( new_rx_pulse_cnt_2_reg_cr        )
    ,. new_rx_pulse_cnt_3_reg_cr            ( new_rx_pulse_cnt_3_reg_cr        )
    ,. new_tx_pulse_cnt_0_reg_cr            ( new_tx_pulse_cnt_0_reg_cr        )
    ,. new_tx_pulse_cnt_1_reg_cr            ( new_tx_pulse_cnt_1_reg_cr        )
    ,. new_tx_pulse_cnt_2_reg_cr            ( new_tx_pulse_cnt_2_reg_cr        )
    ,. new_tx_pulse_cnt_3_reg_cr            ( new_tx_pulse_cnt_3_reg_cr        )
		,. new_rx_pulse_timer_reg_0_reg_cr      ( new_rx_pulse_timer_reg_0_reg_cr  )
		,. new_rx_pulse_timer_reg_1_reg_cr      ( new_rx_pulse_timer_reg_1_reg_cr  )
		,. new_rx_pulse_timer_reg_2_reg_cr      ( new_rx_pulse_timer_reg_2_reg_cr  )
		,. new_rx_pulse_timer_reg_3_reg_cr      ( new_rx_pulse_timer_reg_3_reg_cr  )

    // Register Outputs
    ,. inst_name0_reg_cr                    ( inst_name0_reg_cr            )
    ,. inst_name1_reg_cr                    ( inst_name1_reg_cr            )
    ,. inst_name2_reg_cr                    ( inst_name2_reg_cr            )
    ,. inst_name3_reg_cr                    ( inst_name3_reg_cr            )
    ,. rx_pulse_cnt_0_reg_cr                ( rx_pulse_cnt_0_reg_cr        )
    ,. rx_pulse_cnt_1_reg_cr                ( rx_pulse_cnt_1_reg_cr        )
    ,. rx_pulse_cnt_2_reg_cr                ( rx_pulse_cnt_2_reg_cr        )
    ,. rx_pulse_cnt_3_reg_cr                ( rx_pulse_cnt_3_reg_cr        )
    ,. tx_pulse_cnt_0_reg_cr                ( tx_pulse_cnt_0_reg_cr        )
    ,. tx_pulse_cnt_1_reg_cr                ( tx_pulse_cnt_1_reg_cr        )
    ,. tx_pulse_cnt_2_reg_cr                ( tx_pulse_cnt_2_reg_cr        )
    ,. tx_pulse_cnt_3_reg_cr                ( tx_pulse_cnt_3_reg_cr        )
		,. rx_pulse_timer_reg_0_reg_cr          ( rx_pulse_timer_reg_0_reg_cr  )
		,. rx_pulse_timer_reg_1_reg_cr          ( rx_pulse_timer_reg_1_reg_cr  )
		,. rx_pulse_timer_reg_2_reg_cr          ( rx_pulse_timer_reg_2_reg_cr  )
		,. rx_pulse_timer_reg_3_reg_cr          ( rx_pulse_timer_reg_3_reg_cr  )

    // Register signals for HandCoded registers

    // Config Access
    ,. req                                  ( reg_mod_req                    )
    ,. ack                                  ( reg_mod_ack                    )
   );

//------------------------------------------------------//
//    REQ SIGNALS        :     ACK SIGNALS              //
//------------------------------------------------------//
// reg_mod_req.valid     : reg_mod_ack.read_valid       //
// reg_mod_req.opcode    : reg_mod_ack.read_miss        //
// reg_mod_req.addr      : reg_mod_ack.write_valid      //
// reg_mod_req.be        : reg_mod_ack.write_miss       //
// reg_mod_req.data      : reg_mod_ack.sai_successfull  //
// reg_mod_req.sai       : reg_mod_ack.data             //
// reg_mod_req.fid       :                              //
// reg_mod_req.bar       :                              //
//------------------------------------------------------//

//------------------------------------------------------//
// Register module config request signals logic         //
//------------------------------------------------------//
//Request is valid for any read or write transaction occurs when waitrequest
//is inactive/low 
assign reg_mod_req.valid  = (avs_s0_read||avs_s0_write) && (!avs_s0_waitrequest);
//Register CFG opcode selection
assign reg_mod_req.opcode = avs_s0_write ? CFGWR : CFGRD;
//Register CFG address excpets 48bit. Appending zeros to 
//AV MM slave address
assign reg_mod_req.addr   = {'h0,avs_s0_address};
assign reg_mod_req.be     = avs_s0_byteenable;
assign reg_mod_req.data   = avs_s0_writedata;
assign reg_mod_req.sai    = 7'h00;
assign reg_mod_req.fid    = 7'h00;
assign reg_mod_req.bar    = 3'h0;

//AV MM Slave waitrequest
assign avs_s0_waitrequest = 1'b0;
//AV MM Slave read data valid is registered CFG ack's read_valid or read_miss
always @(posedge csi_clk  or negedge  rsi_reset_n)
begin
  if(~rsi_reset_n)
    avs_s0_readdatavalid <= 1'b0;
  else
    avs_s0_readdatavalid <= reg_mod_ack.read_valid || reg_mod_ack.read_miss;
end
//AV MM Slave read data 
always @(posedge csi_clk  or negedge  rsi_reset_n)
begin
  if(~rsi_reset_n)
    avs_s0_readdata <= 'h0;
  else if(reg_mod_ack.read_miss)
    avs_s0_readdata <= READ_MISS_VAL;
  else if(reg_mod_ack.read_valid)
    avs_s0_readdata <= reg_mod_ack.data;
  else
    avs_s0_readdata <= 'h0;
end

endmodule
