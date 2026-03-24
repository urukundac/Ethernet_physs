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

/*
 --------------------------------------------------------------------------
 -- Project Code      : IMPrES
 -- Module Name       : IW_fpga_clk_sync_v2_MC_SYNC_US
 -- Author            : Aniket Phapale
 -- Associated modules: 
 -- Function          : 
 --------------------------------------------------------------------------
*/
`timescale 1ns / 10ps

module IW_fpga_clk_sync_v2_MC_SYNC_US #(
    parameter MODULE_NAME            = "IW_fpga_clk_sync_v2_MC_SYNC_US"
   ,parameter MC_SYNC_US_WIDTH       = 1
   ,parameter GAL_CNTR_W             = 16
    /*  AV-MM Parameters  */
   ,parameter AV_MM_ADDR_W            = 11
   ,parameter AV_MM_DATA_W            = 32
   ,parameter AV_MM_READ_MISS_VAL     = 32'hdeadbabe
) (
//----------------------- Input Declarations ------------------------------  
   input  logic                                         clk_mon
  ,input  logic                                         rst_mon_n
  ,input  logic                                         i_clk_fast
  ,input  logic                                         i_clk_slow
  ,input  logic                                         i_rst_n
  ,input  logic                                         i_gal_sync_lock
  ,input  logic                                         i_gal_usync_vec_align_point
  ,input  logic  [GAL_CNTR_W-1:0]                       i_clk_logic_gal_cntr

//----------------------- Inout Declarations ------------------------------
  ,inout  wire [MC_SYNC_US_WIDTH-1:0]                   i_upstream_rx
  ,inout  wire [MC_SYNC_US_WIDTH-1:0]                   o_upstream_tx

  /*  AV-MM Interface */
  , input  wire   [AV_MM_ADDR_W-1:0]                    avs_s0_address
  , output wire   [AV_MM_DATA_W-1:0]                    avs_s0_readdata
  , input  wire                                         avs_s0_read
  , output wire                                         avs_s0_readdatavalid
  , input  wire                                         avs_s0_write
  , input  wire   [AV_MM_DATA_W-1:0]                    avs_s0_writedata
  , input  wire   [(AV_MM_DATA_W/8)-1:0]                avs_s0_byteenable
  , output wire                                         avs_s0_waitrequest
);

//----------------------- Internal Wire/logic Declarations ----------------------
logic  [MC_SYNC_US_WIDTH-1:0]                      s_upstream_rx   ;
logic  [MC_SYNC_US_WIDTH-1:0]                      s_upstream_rx_d1;
logic                                              s_slow_clock_sig;
logic                                              s_slow_clock_sig_d1;
logic                                              s_slow_clock_sig_redge;
logic                                              s_gal_sync_lock_sync;

genvar idx;
logic [MC_SYNC_US_WIDTH-1:0] s_upstream_tx;

logic [MC_SYNC_US_WIDTH-1:0] [AV_MM_DATA_W-1:0]    rx_pulse_cnt;
logic [MC_SYNC_US_WIDTH-1:0] [AV_MM_DATA_W-1:0]    tx_pulse_cnt;
logic [MC_SYNC_US_WIDTH-1:0] [AV_MM_DATA_W-1:0]    rx_pulse_timer;
logic [MC_SYNC_US_WIDTH-1:0] [AV_MM_DATA_W-1:0]    rx_pulse_timer_reg;

logic [MC_SYNC_US_WIDTH-1:0] [AV_MM_DATA_W-1:0]    rx_pulse_cnt_sync;
logic [MC_SYNC_US_WIDTH-1:0] [AV_MM_DATA_W-1:0]    tx_pulse_cnt_sync;
logic [MC_SYNC_US_WIDTH-1:0] [AV_MM_DATA_W-1:0]    rx_pulse_timer_reg_sync;

logic [3:0] [AV_MM_DATA_W-1:0]                     rx_pulse_cnt_sync_status;
logic [3:0] [AV_MM_DATA_W-1:0]                     tx_pulse_cnt_sync_status;
logic [3:0] [AV_MM_DATA_W-1:0]                     rx_pulse_timer_reg_sync_status;

//----------------------- Start of Code -----------------------------------

//--------------------------------------------------------------------------------
// Reconstruction of the slow clock signal
//--------------------------------------------------------------------------------
IW_fpga_clk_derive  u_IW_fpga_clk_derive (  
      .clk_in         (i_clk_slow)
     ,.rst_in_n       (i_rst_n)
     ,.clk_derive_out (s_slow_clock_sig)
  );

always_ff @(posedge i_clk_fast) s_slow_clock_sig_d1 <= s_slow_clock_sig;
assign s_slow_clock_sig_redge = s_slow_clock_sig & ~s_slow_clock_sig_d1;

IW_fpga_double_sync #(
   .WIDTH(1)
  ,.NUM_STAGES(2)
) u_IW_fpga_double_sync_i_gal_sync_lock (
   .clk(i_clk_fast)
  ,.sig_in(i_gal_sync_lock)
  ,.sig_out(s_gal_sync_lock_sync)
);

for(idx=0;idx<MC_SYNC_US_WIDTH;idx++) begin
  // Double synchronize the received pulse
  always_ff @(posedge i_clk_fast) begin
    s_upstream_rx [idx]    <= i_upstream_rx[idx];
    s_upstream_rx_d1 [idx] <= s_upstream_rx [idx];
  end

  // Transmit the pulse only if the received pulse is aligned to gal point and if local calibration is achieved
  always_ff @(posedge i_clk_fast, negedge i_rst_n) begin
    if(~i_rst_n)
      s_upstream_tx[idx] <= 1'b0;
    else begin
      if(s_upstream_rx_d1[idx] & s_gal_sync_lock_sync & s_slow_clock_sig_redge & i_gal_usync_vec_align_point )
        s_upstream_tx[idx] <= 1'b1;
      else
        if(~s_upstream_rx_d1[idx])
          s_upstream_tx[idx] <= 1'b0;
    end
  end
  assign o_upstream_tx[idx] = s_upstream_tx[idx];  
end

// Count the number of pulses received, transmitted and time difference between the received pulses
// Also synchronise them for status monitoring
for(idx=0;idx<MC_SYNC_US_WIDTH;idx++) begin
  always_ff @(posedge i_clk_fast, negedge i_rst_n) begin
    if(~i_rst_n) begin
      rx_pulse_cnt[idx] <= 0;
      tx_pulse_cnt[idx] <= 0;
    end else begin
      rx_pulse_cnt[idx] <= s_upstream_rx_d1[idx] ? (rx_pulse_cnt[idx] + 1) : rx_pulse_cnt[idx];
      tx_pulse_cnt[idx] <= s_upstream_tx   [idx] ? (tx_pulse_cnt[idx] + 1) : tx_pulse_cnt[idx];
    end
  end

  always_ff @(posedge i_clk_fast) begin
    if(~i_rst_n) begin
      rx_pulse_timer[idx]     <= 0;
      rx_pulse_timer_reg[idx] <= 0;
    end else begin
      rx_pulse_timer[idx]     <= s_upstream_rx_d1[idx] ? 0 : (rx_pulse_timer[idx] + 1) ;
      rx_pulse_timer_reg[idx] <= s_upstream_rx_d1[idx] ? rx_pulse_timer[idx] : rx_pulse_timer_reg[idx] ;
    end
  end

  IW_fpga_double_sync #(
     .WIDTH(AV_MM_DATA_W)
    ,.NUM_STAGES(2)
  ) u_IW_sync_rx_pulse_cnt (
     .clk(clk_mon)
    ,.sig_in(rx_pulse_cnt[idx])
    ,.sig_out(rx_pulse_cnt_sync[idx])
  ); 

  IW_fpga_double_sync #(
     .WIDTH(AV_MM_DATA_W)
    ,.NUM_STAGES(2)
  ) u_IW_sync_tx_pulse_cnt (
     .clk(clk_mon)
    ,.sig_in(tx_pulse_cnt[idx])
    ,.sig_out(tx_pulse_cnt_sync[idx])
  ); 

  IW_fpga_double_sync #(
     .WIDTH(AV_MM_DATA_W)
    ,.NUM_STAGES(2)
  ) u_IW_sync_rx_pulse_timer_reg(
     .clk(clk_mon)
    ,.sig_in(rx_pulse_timer_reg[idx])
    ,.sig_out(rx_pulse_timer_reg_sync[idx])
  ); 

end
logic [3:0] [AV_MM_DATA_W-1:0]                     rx_pulse_cnt_sync_status;
logic [3:0] [AV_MM_DATA_W-1:0]                     tx_pulse_cnt_sync_status;
logic [3:0] [AV_MM_DATA_W-1:0]                     rx_pulse_timer_reg_sync_status;

  generate
    if(MC_SYNC_US_WIDTH > 0) begin
      assign rx_pulse_cnt_sync_status       [0] = rx_pulse_cnt_sync[0];
      assign tx_pulse_cnt_sync_status       [0] = tx_pulse_cnt_sync[0];
      assign rx_pulse_timer_reg_sync_status [0] = rx_pulse_timer_reg_sync[0];
    end else begin
      assign rx_pulse_cnt_sync_status       [0] = 0;
      assign tx_pulse_cnt_sync_status       [0] = 0;
      assign rx_pulse_timer_reg_sync_status [0] = 0;
    end

    if(MC_SYNC_US_WIDTH > 1) begin
      assign rx_pulse_cnt_sync_status       [1] = rx_pulse_cnt_sync[1];
      assign tx_pulse_cnt_sync_status       [1] = tx_pulse_cnt_sync[1];
      assign rx_pulse_timer_reg_sync_status [1] = rx_pulse_timer_reg_sync[1];
    end else begin
      assign rx_pulse_cnt_sync_status       [1] = 0;
      assign tx_pulse_cnt_sync_status       [1] = 0;
      assign rx_pulse_timer_reg_sync_status [1] = 0;
    end

    if(MC_SYNC_US_WIDTH > 2) begin
      assign rx_pulse_cnt_sync_status       [2] = rx_pulse_cnt_sync[2];
      assign tx_pulse_cnt_sync_status       [2] = tx_pulse_cnt_sync[2];
      assign rx_pulse_timer_reg_sync_status [2] = rx_pulse_timer_reg_sync[2];
    end else begin
      assign rx_pulse_cnt_sync_status       [2] = 0;
      assign tx_pulse_cnt_sync_status       [2] = 0;
      assign rx_pulse_timer_reg_sync_status [2] = 0;
    end

    if(MC_SYNC_US_WIDTH > 3) begin
      assign rx_pulse_cnt_sync_status       [3] = rx_pulse_cnt_sync[3];
      assign tx_pulse_cnt_sync_status       [3] = tx_pulse_cnt_sync[3];
      assign rx_pulse_timer_reg_sync_status [3] = rx_pulse_timer_reg_sync[3];
    end else begin
      assign rx_pulse_cnt_sync_status       [3] = 0;
      assign tx_pulse_cnt_sync_status       [3] = 0;
      assign rx_pulse_timer_reg_sync_status [3] = 0;
    end
  endgenerate

  /*  Address Map */
  IW_fpga_clk_rst_sync_v2_mc_sync_us_addr_map_avmm_wrapper #(
    .INSTANCE_NAME           ( MODULE_NAME             )
  , .MC_SYNC_US_WIDTH        ( MC_SYNC_US_WIDTH        )
  , .AV_MM_ADDR_W            ( AV_MM_ADDR_W            )
  , .AV_MM_DATA_W            ( AV_MM_DATA_W            )
  , .READ_MISS_VAL           ( AV_MM_READ_MISS_VAL     )

  ) u_addr_map  (

     .csi_clk                  (clk_mon)
    ,.rsi_reset_n              (rst_mon_n)

    ,.avs_s0_address           (avs_s0_address)
    ,.avs_s0_readdata          (avs_s0_readdata)
    ,.avs_s0_read              (avs_s0_read)
    ,.avs_s0_readdatavalid     (avs_s0_readdatavalid)
    ,.avs_s0_write             (avs_s0_write)
    ,.avs_s0_writedata         (avs_s0_writedata)
    ,.avs_s0_byteenable        (avs_s0_byteenable)
    ,.avs_s0_waitrequest       (avs_s0_waitrequest)

    ,.rx_pulse_cnt_0           (rx_pulse_cnt_sync_status[0] )
    ,.tx_pulse_cnt_0           (tx_pulse_cnt_sync_status[0] )
    ,.rx_pulse_timer_reg_0     (rx_pulse_timer_reg_sync_status[0] )
    ,.rx_pulse_cnt_1           (rx_pulse_cnt_sync_status[1] )
    ,.tx_pulse_cnt_1           (tx_pulse_cnt_sync_status[1] )
    ,.rx_pulse_timer_reg_1     (rx_pulse_timer_reg_sync_status[1] )
    ,.rx_pulse_cnt_2           (rx_pulse_cnt_sync_status[2] )
    ,.tx_pulse_cnt_2           (tx_pulse_cnt_sync_status[2] )
    ,.rx_pulse_timer_reg_2     (rx_pulse_timer_reg_sync_status[2] )
    ,.rx_pulse_cnt_3           (rx_pulse_cnt_sync_status[3] )
    ,.tx_pulse_cnt_3           (tx_pulse_cnt_sync_status[3] )
    ,.rx_pulse_timer_reg_3     (rx_pulse_timer_reg_sync_status[3] )
  );

endmodule // <module_name>
