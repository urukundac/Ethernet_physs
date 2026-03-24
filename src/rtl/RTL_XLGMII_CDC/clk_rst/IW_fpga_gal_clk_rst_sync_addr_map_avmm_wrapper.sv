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
 -- Module Name       : IW_fpga_gal_clk_rst_sync_addr_map_avmm_wrapper
 -- Author            : Gregory James
 -- Associated modules: 
 -- Function          : This wrapper interfaces the IW_fpga_gal_clk_rst_sync_addr_map
                        block with Avalon-MM
 --------------------------------------------------------------------------
*/

`timescale 1ns / 10ps


module IW_fpga_gal_clk_rst_sync_addr_map_avmm_wrapper #(
    parameter AV_MM_ADDR_W  = 8                   // Address width
  , parameter AV_MM_DATA_W  = 32                  // Data width
  , parameter READ_MISS_VAL = 32'hDEADBABE        // Read miss value

  , parameter GAL_SYN_MASTER              = 1
  , parameter GAL_SYNC_START_TIMEOUT      = 128   //Maximum number of continuos zero counts received
  , parameter GAL_CNT_IN_BUFFER           = 0     //1->Use demux on line GAL_SYNC_CNT_IN_IO,  0->No demux on line GAL_SYNC_CNT_IN_IO
  , parameter GAL_CNT_OUT_BUFFER          = 0     //1->Use mux on line GAL_SYNC_CNT_OUT_IO,  0->No mux on line GAL_SYNC_CNT_OUT_IO
  , parameter GAL_CNT_IN_MUX_RATIO        = 6
  , parameter GAL_CNT_IN_CLK_RATIO        = 4
  , parameter GAL_CNT_OUT_MUX_RATIO       = 6
  , parameter GAL_CNT_OUT_CLK_RATIO       = 4
  , parameter GAL_FREQ_DIV                = 1
  , parameter GAL_CNTR_W                  = 16
  , parameter GAL_EDGE_DET_CNTR_W         = 8
  , parameter USYNC_GAL_OFFSET            = 3 //Number of cycles before GAL point to generate usync pulse
  , parameter GAL_NUM_CLOCKS              = 1
  , parameter GAL_USYNC_SKIP_CNT          = 3 //Number of usync pulses to skip after reset
  , parameter GAL_LOGIC_TAP               = 0 //Which logic clock to run GAL counter mux/demux

  , parameter DPS_NUM_SHIFTS_PER_CYCLE              = 1 //Number of shifts per cycle
  , parameter DPS_MIN_CLK_SYNC_FAIL_CYCLES          = 5 //Minimum number of consecutive cycles that result in clk_sync_mismatch=1
  , parameter DPS_MIN_CLK_SYNC_PASS_CYCLES          = 5 //Minimum number of consecutive cycles that result in clk_sync_stable=1

) (

  /*  Avalon-MM Interface */
   input  wire                        csi_clk                  // csi.clk
  ,input  wire                        rsi_reset_n              // rsi.reset
 
  ,input  wire [AV_MM_ADDR_W-1:0]     avs_s0_address           // avs_s0.address
  ,output reg  [AV_MM_DATA_W-1:0]     avs_s0_readdata          //       .readdata
  ,input  wire                        avs_s0_read              //       .read
  ,output reg                         avs_s0_readdatavalid     //       .readdatavalid
  ,input  wire                        avs_s0_write             //       .write
  ,input  wire [AV_MM_DATA_W-1:0]     avs_s0_writedata         //       .writedata
  ,input  wire [(AV_MM_DATA_W/8)-1:0] avs_s0_byteenable        //       .byteenable
  ,output wire                        avs_s0_waitrequest       //       .waitrequest

  /*  Register Inputs From HW */
  ,input  wire                        clk_sync_stat_dps_locked
  ,input  wire                        clk_sync_stat_pll_reset
  ,input  wire                        clk_sync_stat_pll_locked
  ,input  wire                        clk_sync_stat_rst_logic_vec_n
  ,input  wire                        clk_sync_stat_rst_fast_n
  ,input  wire                        clk_sync_stat_rst_logic_trigger_n
  ,input  wire                        clk_sync_stat_dps_rst_clk_sync_n
  ,input  wire                        clk_sync_stat_rst_dps_internal_n
  ,input  wire                        clk_sync_stat_gal_clk_sync_start_timeout
  ,input  wire                        clk_sync_stat_gal_clk_sync_stable
  ,input  wire                        clk_sync_stat_gal_clk_sync_mismatch

  ,input  wire [15:0]                 dps_sync_fsm_pstate
  ,input  wire [15:0]                 dps_cntrl_fsm_pstate
  ,input  wire [31:0]                 dps_pass_win_len
  ,input  wire [31:0]                 clk_sync_loss_cnt
  ,input  wire [31:0]                 dps_find_fail0_shift_cnt
  ,input  wire [31:0]                 dps_find_pass0_shift_cnt
  ,input  wire [31:0]                 dps_find_fail1_shift_cnt
  ,input  wire [31:0]                 dps_lock_dps_shift_cnt
  ,input  wire [31:0]                 dps_consec_sync_pass_cnt
  ,input  wire [31:0]                 dps_consec_fail_cnt
  ,input  wire [31:0]                 dps_lock_target_cnt
  ,input  wire [31:0]                 dps_lock_slip_cnt

);

//----------------------- Import Packages ---------------------------------
  import IW_fpga_gal_clk_rst_sync_addr_map_pkg::*;
  import rtlgen_pkg_IW_fpga_gal_clk_rst_sync_addr_map::*;


//----------------------- Internal Parameters -----------------------------


//----------------------- Internal Register Declarations ------------------


//----------------------- Internal Wire Declarations ----------------------
  load_clk_sync_stat_reg_cr_t                load_clk_sync_stat_reg_cr;
  new_clk_dps_consec_fail_cnt_reg_cr_t       new_clk_dps_consec_fail_cnt_reg_cr;
  new_clk_dps_consec_sync_pass_cnt_reg_cr_t  new_clk_dps_consec_sync_pass_cnt_reg_cr;
  new_clk_dps_find_fail0_shift_cnt_reg_cr_t  new_clk_dps_find_fail0_shift_cnt_reg_cr;
  new_clk_dps_find_pass0_shift_cnt_reg_cr_t  new_clk_dps_find_pass0_shift_cnt_reg_cr;
  new_clk_dps_find_fail1_shift_cnt_reg_cr_t  new_clk_dps_find_fail1_shift_cnt_reg_cr;
  new_clk_dps_fsm_reg_cr_t                   new_clk_dps_fsm_reg_cr;
  new_clk_dps_lock_dps_shift_cnt_reg_cr_t    new_clk_dps_lock_dps_shift_cnt_reg_cr;
  new_clk_dps_lock_slip_cnt_reg_cr_t         new_clk_dps_lock_slip_cnt_reg_cr;
  new_clk_dps_lock_target_cnt_reg_cr_t       new_clk_dps_lock_target_cnt_reg_cr;
  new_clk_dps_pass_win_len_reg_cr_t          new_clk_dps_pass_win_len_reg_cr;
  new_clk_param_0_reg_cr_t                   new_clk_param_0_reg_cr;
  new_clk_param_1_reg_cr_t                   new_clk_param_1_reg_cr;
  new_clk_param_2_reg_cr_t                   new_clk_param_2_reg_cr;
  new_clk_param_3_reg_cr_t                   new_clk_param_3_reg_cr;
  new_clk_param_4_reg_cr_t                   new_clk_param_4_reg_cr;
  new_clk_param_5_reg_cr_t                   new_clk_param_5_reg_cr;
  new_clk_param_6_reg_cr_t                   new_clk_param_6_reg_cr;
  new_clk_param_7_reg_cr_t                   new_clk_param_7_reg_cr;
  new_clk_sync_loss_cnt_reg_cr_t             new_clk_sync_loss_cnt_reg_cr;
  new_clk_sync_stat_reg_cr_t                 new_clk_sync_stat_reg_cr;

  IW_fpga_gal_clk_rst_sync_addr_map_cr_req_t     req;
  IW_fpga_gal_clk_rst_sync_addr_map_cr_ack_t     ack;


//----------------------- Start of Code -----------------------------------

  //Assigning HW inputs to register fields
  always@(*)
  begin
    new_clk_param_0_reg_cr.GAL_SYNC_START_TIMEOUT = GAL_SYNC_START_TIMEOUT;
    new_clk_param_0_reg_cr.GAL_CNT_OUT_BFFR       = GAL_CNT_OUT_BUFFER;
    new_clk_param_0_reg_cr.GAL_CNT_IN_BFFR        = GAL_CNT_IN_BUFFER;
    new_clk_param_0_reg_cr.GAL_SYN_MASTER         = GAL_SYN_MASTER;

    new_clk_param_1_reg_cr.GAL_CNT_IN_MUX_RATIO   = GAL_CNT_IN_MUX_RATIO;
    new_clk_param_1_reg_cr.GAL_CNT_IN_CLK_RATIO   = GAL_CNT_IN_CLK_RATIO;

    new_clk_param_2_reg_cr.GAL_CNT_OUT_MUX_RATIO  = GAL_CNT_OUT_MUX_RATIO;
    new_clk_param_2_reg_cr.GAL_CNT_OUT_CLK_RATIO  = GAL_CNT_OUT_CLK_RATIO;

    new_clk_param_3_reg_cr.GAL_FREQ_DIV           = GAL_FREQ_DIV;
    new_clk_param_3_reg_cr.GAL_CNTR_W             = GAL_CNTR_W;
    new_clk_param_3_reg_cr.GAL_EDGE_DET_CNTR_W    = GAL_EDGE_DET_CNTR_W;
    new_clk_param_3_reg_cr.USYNC_GAL_OFFSET       = USYNC_GAL_OFFSET;
    new_clk_param_3_reg_cr.GAL_NUM_CLOCKS         = GAL_NUM_CLOCKS;

    new_clk_param_4_reg_cr.GAL_USYNC_SKIP_CNT     = GAL_USYNC_SKIP_CNT;
    new_clk_param_4_reg_cr.GAL_LOGIC_TAP          = GAL_LOGIC_TAP;

    new_clk_param_5_reg_cr.DPS_NUM_SHIFTS_PER_CYCLE                  = DPS_NUM_SHIFTS_PER_CYCLE;

    new_clk_param_6_reg_cr.DPS_MIN_CLK_SYNC_FAIL_CYCLES              = DPS_MIN_CLK_SYNC_FAIL_CYCLES;

    new_clk_param_7_reg_cr.DPS_MIN_CLK_SYNC_PASS_CYCLES              = DPS_MIN_CLK_SYNC_PASS_CYCLES;

    new_clk_sync_stat_reg_cr.dps_locked                              = clk_sync_stat_dps_locked;
    new_clk_sync_stat_reg_cr.pll_reset                               = clk_sync_stat_pll_reset;
    new_clk_sync_stat_reg_cr.pll_locked                              = clk_sync_stat_pll_locked;
    new_clk_sync_stat_reg_cr.loss_pll_locked                         = ~clk_sync_stat_pll_locked;
    load_clk_sync_stat_reg_cr.loss_pll_locked                        = ~clk_sync_stat_pll_locked;
    new_clk_sync_stat_reg_cr.loss_gal_clk_sync_mismatch              = clk_sync_stat_gal_clk_sync_mismatch;
    load_clk_sync_stat_reg_cr.loss_gal_clk_sync_mismatch             = clk_sync_stat_gal_clk_sync_mismatch;
    new_clk_sync_stat_reg_cr.rst_logic_vec_n                         = clk_sync_stat_rst_logic_vec_n;
    new_clk_sync_stat_reg_cr.rst_fast_n                              = clk_sync_stat_rst_fast_n;
    new_clk_sync_stat_reg_cr.rst_logic_trigger_n                     = clk_sync_stat_rst_logic_trigger_n;
    new_clk_sync_stat_reg_cr.dps_rst_clk_sync_n                      = clk_sync_stat_dps_rst_clk_sync_n;
    new_clk_sync_stat_reg_cr.rst_dps_internal_n                      = clk_sync_stat_rst_dps_internal_n;
    new_clk_sync_stat_reg_cr.gal_clk_sync_start_timeout              = clk_sync_stat_gal_clk_sync_start_timeout;
    new_clk_sync_stat_reg_cr.gal_clk_sync_stable                     = clk_sync_stat_gal_clk_sync_stable;
    new_clk_sync_stat_reg_cr.gal_clk_sync_mismatch                   = clk_sync_stat_gal_clk_sync_mismatch;

    new_clk_dps_fsm_reg_cr.dps_sync_fsm_pstate                       = dps_sync_fsm_pstate;
    new_clk_dps_fsm_reg_cr.dps_cntrl_fsm_pstate                      = dps_cntrl_fsm_pstate;
    new_clk_dps_pass_win_len_reg_cr.dps_pass_win_len                 = dps_pass_win_len;
    new_clk_sync_loss_cnt_reg_cr.clk_sync_loss_cnt                   = clk_sync_loss_cnt;
    new_clk_dps_find_fail0_shift_cnt_reg_cr.dps_find_fail0_shift_cnt = dps_find_fail0_shift_cnt;
    new_clk_dps_find_pass0_shift_cnt_reg_cr.dps_find_pass0_shift_cnt = dps_find_pass0_shift_cnt;
    new_clk_dps_find_fail1_shift_cnt_reg_cr.dps_find_fail1_shift_cnt = dps_find_fail1_shift_cnt;
    new_clk_dps_lock_dps_shift_cnt_reg_cr.dps_lock_dps_shift_cnt     = dps_lock_dps_shift_cnt;
    new_clk_dps_consec_sync_pass_cnt_reg_cr.dps_consec_sync_pass_cnt = dps_consec_sync_pass_cnt;
    new_clk_dps_consec_fail_cnt_reg_cr.dps_consec_fail_cnt           = dps_consec_fail_cnt;
    new_clk_dps_lock_target_cnt_reg_cr.dps_lock_target_cnt           = dps_lock_target_cnt;
    new_clk_dps_lock_slip_cnt_reg_cr.dps_lock_slip_cnt               = dps_lock_slip_cnt;
  end

  /*  Instantiate Address Map */
  IW_fpga_gal_clk_rst_sync_addr_map                     u_addr_map
  (
       .rst_n                                           (rsi_reset_n)
      ,.pwr_rst_n                                       (rsi_reset_n)

      ,.rtl_clk                                         (csi_clk    )
      ,.load_clk_sync_stat_reg_cr                       (load_clk_sync_stat_reg_cr                       )

      ,.new_clk_dps_consec_fail_cnt_reg_cr              (new_clk_dps_consec_fail_cnt_reg_cr              )
      ,.new_clk_dps_consec_sync_pass_cnt_reg_cr         (new_clk_dps_consec_sync_pass_cnt_reg_cr         )
      ,.new_clk_dps_find_fail0_shift_cnt_reg_cr         (new_clk_dps_find_fail0_shift_cnt_reg_cr         )
      ,.new_clk_dps_find_fail1_shift_cnt_reg_cr         (new_clk_dps_find_fail1_shift_cnt_reg_cr         )
      ,.new_clk_dps_find_pass0_shift_cnt_reg_cr         (new_clk_dps_find_pass0_shift_cnt_reg_cr         )
      ,.new_clk_dps_fsm_reg_cr                          (new_clk_dps_fsm_reg_cr                          )
      ,.new_clk_dps_lock_dps_shift_cnt_reg_cr           (new_clk_dps_lock_dps_shift_cnt_reg_cr           )
      ,.new_clk_dps_lock_slip_cnt_reg_cr                (new_clk_dps_lock_slip_cnt_reg_cr                )
      ,.new_clk_dps_lock_target_cnt_reg_cr              (new_clk_dps_lock_target_cnt_reg_cr              )
      ,.new_clk_dps_pass_win_len_reg_cr                 (new_clk_dps_pass_win_len_reg_cr                 )
      ,.new_clk_param_0_reg_cr                          (new_clk_param_0_reg_cr                          )
      ,.new_clk_param_1_reg_cr                          (new_clk_param_1_reg_cr                          )
      ,.new_clk_param_2_reg_cr                          (new_clk_param_2_reg_cr                          )
      ,.new_clk_param_3_reg_cr                          (new_clk_param_3_reg_cr                          )
      ,.new_clk_param_4_reg_cr                          (new_clk_param_4_reg_cr                          )
      ,.new_clk_param_5_reg_cr                          (new_clk_param_5_reg_cr                          )
      ,.new_clk_param_6_reg_cr                          (new_clk_param_6_reg_cr                          )
      ,.new_clk_param_7_reg_cr                          (new_clk_param_7_reg_cr                          )
      ,.new_clk_sync_loss_cnt_reg_cr                    (new_clk_sync_loss_cnt_reg_cr                    )
      ,.new_clk_sync_stat_reg_cr                        (new_clk_sync_stat_reg_cr                        )

      ,.clk_dps_consec_fail_cnt_reg_cr                  ()
      ,.clk_dps_consec_sync_pass_cnt_reg_cr             ()
      ,.clk_dps_find_fail0_shift_cnt_reg_cr             ()
      ,.clk_dps_find_fail1_shift_cnt_reg_cr             ()
      ,.clk_dps_find_pass0_shift_cnt_reg_cr             ()
      ,.clk_dps_fsm_reg_cr                              ()
      ,.clk_dps_lock_dps_shift_cnt_reg_cr               ()
      ,.clk_dps_lock_slip_cnt_reg_cr                    ()
      ,.clk_dps_lock_target_cnt_reg_cr                  ()
      ,.clk_dps_pass_win_len_reg_cr                     ()
      ,.clk_param_0_reg_cr                              ()
      ,.clk_param_1_reg_cr                              ()
      ,.clk_param_2_reg_cr                              ()
      ,.clk_param_3_reg_cr                              ()
      ,.clk_param_4_reg_cr                              ()
      ,.clk_param_5_reg_cr                              ()
      ,.clk_param_6_reg_cr                              ()
      ,.clk_param_7_reg_cr                              ()
      ,.clk_sync_loss_cnt_reg_cr                        ()
      ,.clk_sync_stat_reg_cr                            ()

      ,.req                                             (req)
      ,.ack                                             (ack)

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
  assign req.valid  = (avs_s0_read||avs_s0_write) && (!avs_s0_waitrequest);
  //Register CFG opcode selection
  assign req.opcode = avs_s0_write ? CFGWR : CFGRD;
  //Register CFG address excpets 48bit. Appending zeros to 
  //AV MM slave address
  assign req.addr   = {'h0,avs_s0_address};
  assign req.be     = avs_s0_byteenable;
  assign req.data   = avs_s0_writedata;
  assign req.sai    = 7'h00;
  assign req.fid    = 7'h00;
  assign req.bar    = 3'h0;

  //AV MM Slave waitrequest
  assign avs_s0_waitrequest = 1'b0;

  //AV MM Slave read data valid is registered CFG ack's read_valid or read_miss
  always @(posedge csi_clk  or negedge  rsi_reset_n)
  begin
    if(~rsi_reset_n)
      avs_s0_readdatavalid <= 1'b0;
    else
      avs_s0_readdatavalid <= ack.read_valid || ack.read_miss;
  end

  //AV MM Slave read data 
  always @(posedge csi_clk  or negedge  rsi_reset_n)
  begin
    if(~rsi_reset_n)
      avs_s0_readdata <= 'h0;
    else if(ack.read_miss)
      avs_s0_readdata <= READ_MISS_VAL;
    else if(ack.read_valid)
      avs_s0_readdata <= ack.data;
    else
      avs_s0_readdata <= 'h0;
  end


endmodule // IW_fpga_gal_clk_rst_sync_addr_map_avmm_wrapper
