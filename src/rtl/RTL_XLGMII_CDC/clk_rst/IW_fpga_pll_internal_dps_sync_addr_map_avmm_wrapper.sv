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
 -- Module Name       : IW_fpga_pll_internal_dps_sync_addr_map_avmm_wrapper
 -- Author            : Gregory James
 -- Associated modules: 
 -- Function          : This is a wrapper for interfacing IW_fpga_pll_internal_dps_sync_addr_map
                        to Avalon-MM bus
 --------------------------------------------------------------------------
*/

`timescale 1ns / 10ps


module IW_fpga_pll_internal_dps_sync_addr_map_avmm_wrapper #(
   parameter AV_MM_ADDR_W   = 8                      // Address width
  ,parameter AV_MM_DATA_W   = 32                     // Data width
  ,parameter READ_MISS_VAL  = 32'hDEADBABE           // Read miss value

  ,parameter  PLL_NUM_CLKS                          = 0
  ,parameter  EDGE_DET_CNTR_W                       = 0
  ,parameter  DPS_WAIT_FOR_PHASE_DONE_EDGE_N_LEVEL  = 0
  ,parameter  DPS_NUM_SHIFTS_PER_CYCLE              = 0
  ,parameter  DPS_MIN_CLK_SYNC_FAIL_CYCLES          = 0
  ,parameter  DPS_MIN_CLK_SYNC_PASS_CYCLES          = 0

) (
  input  wire [AV_MM_ADDR_W-1:0]     avs_s0_address,          // avs_s0.address
  output reg  [AV_MM_DATA_W-1:0]     avs_s0_readdata,         //       .readdata
  input  wire                        avs_s0_read,             //       .read
  output reg                         avs_s0_readdatavalid,    //       .readdatavalid
  input  wire                        avs_s0_write,            //       .write
  input  wire [AV_MM_DATA_W-1:0]     avs_s0_writedata,        //       .writedata
  input  wire [(AV_MM_DATA_W/8)-1:0] avs_s0_byteenable,       //       .byteenable
  output wire                        avs_s0_waitrequest,      //       .waitrequest
  input  wire                        csi_clk,                 // csi.clk
  input  wire                        rsi_reset_n,             // rsi.reset
 
  //Async Register Inputs
  input  wire                        coe_clk_sync_stat_rst_edge_det_int_n,
  input  wire                        coe_clk_sync_stat_rst_pll_n,
  input  wire                        coe_clk_sync_stat_rst_dps_int_n,
  input  wire                        coe_clk_sync_stat_pll_dps_rst_clk_sync_n,
  input  wire                        coe_clk_sync_stat_pll_locked,
  input  wire                        coe_clk_sync_stat_pll_reset,
  input  wire                        coe_clk_sync_stat_dps_locked,

  //Synchronous Register Inputs
  input  wire [15:0]                 coe_clk_dps_sync_fsm_pstate,
  input  wire [15:0]                 coe_clk_dps_cntrl_fsm_pstate,
  input  wire [31:0]                 coe_clk_dps_pass_win_len,
  input  wire [31:0]                 coe_clk_sync_loss_cnt,
  input  wire [31:0]                 coe_clk_dps_find_fail0_shift_cnt,
  input  wire [31:0]                 coe_clk_dps_find_pass0_shift_cnt,
  input  wire [31:0]                 coe_clk_dps_find_fail1_shift_cnt,
  input  wire [31:0]                 coe_clk_dps_lock_dps_shift_cnt,
  input  wire [31:0]                 coe_clk_dps_consec_sync_pass_cnt,
  input  wire [31:0]                 coe_clk_dps_consec_fail_cnt,
  input  wire [31:0]                 coe_clk_dps_lock_target_cnt,
  input  wire [31:0]                 coe_clk_dps_lock_slip_cnt

);

//----------------------- Import Packages ---------------------------------
  import IW_fpga_pll_internal_dps_sync_addr_map_pkg::*;
  import rtlgen_pkg_IW_fpga_pll_internal_dps_sync_addr_map::*;


//----------------------- Internal Parameters -----------------------------


//----------------------- Internal Register Declarations ------------------


//----------------------- Internal Wire Declarations ----------------------
  wire                        coe_clk_sync_stat_rst_edge_det_int_n_sync;
  wire                        coe_clk_sync_stat_rst_pll_n_sync;
  wire                        coe_clk_sync_stat_rst_dps_int_n_sync;
  wire                        coe_clk_sync_stat_pll_dps_rst_clk_sync_n_sync;
  wire                        coe_clk_sync_stat_pll_locked_sync;
  wire                        coe_clk_sync_stat_pll_reset_sync;
  wire                        coe_clk_sync_stat_dps_locked_sync;

  new_clk_dps_consec_fail_cnt_reg_cr_t        new_clk_dps_consec_fail_cnt_reg_cr;
  new_clk_dps_consec_sync_pass_cnt_reg_cr_t   new_clk_dps_consec_sync_pass_cnt_reg_cr;
  new_clk_dps_find_fail0_shift_cnt_reg_cr_t   new_clk_dps_find_fail0_shift_cnt_reg_cr;
  new_clk_dps_find_fail1_shift_cnt_reg_cr_t   new_clk_dps_find_fail1_shift_cnt_reg_cr;
  new_clk_dps_find_pass0_shift_cnt_reg_cr_t   new_clk_dps_find_pass0_shift_cnt_reg_cr;
  new_clk_dps_fsm_reg_cr_t                    new_clk_dps_fsm_reg_cr;
  new_clk_dps_lock_dps_shift_cnt_reg_cr_t     new_clk_dps_lock_dps_shift_cnt_reg_cr;
  new_clk_dps_lock_slip_cnt_reg_cr_t          new_clk_dps_lock_slip_cnt_reg_cr;
  new_clk_dps_lock_target_cnt_reg_cr_t        new_clk_dps_lock_target_cnt_reg_cr;
  new_clk_dps_pass_win_len_reg_cr_t           new_clk_dps_pass_win_len_reg_cr;
  new_clk_param_0_reg_cr_t                    new_clk_param_0_reg_cr;
  new_clk_param_1_reg_cr_t                    new_clk_param_1_reg_cr;
  new_clk_param_2_reg_cr_t                    new_clk_param_2_reg_cr;
  new_clk_param_3_reg_cr_t                    new_clk_param_3_reg_cr;
  new_clk_sync_loss_cnt_reg_cr_t              new_clk_sync_loss_cnt_reg_cr;
  new_clk_sync_stat_reg_cr_t                  new_clk_sync_stat_reg_cr;

  clk_dps_consec_fail_cnt_reg_cr_t            clk_dps_consec_fail_cnt_reg_cr;
  clk_dps_consec_sync_pass_cnt_reg_cr_t       clk_dps_consec_sync_pass_cnt_reg_cr;
  clk_dps_find_fail0_shift_cnt_reg_cr_t       clk_dps_find_fail0_shift_cnt_reg_cr;
  clk_dps_find_fail1_shift_cnt_reg_cr_t       clk_dps_find_fail1_shift_cnt_reg_cr;
  clk_dps_find_pass0_shift_cnt_reg_cr_t       clk_dps_find_pass0_shift_cnt_reg_cr;
  clk_dps_fsm_reg_cr_t                        clk_dps_fsm_reg_cr;
  clk_dps_lock_dps_shift_cnt_reg_cr_t         clk_dps_lock_dps_shift_cnt_reg_cr;
  clk_dps_lock_slip_cnt_reg_cr_t              clk_dps_lock_slip_cnt_reg_cr;
  clk_dps_lock_target_cnt_reg_cr_t            clk_dps_lock_target_cnt_reg_cr;
  clk_dps_pass_win_len_reg_cr_t               clk_dps_pass_win_len_reg_cr;
  clk_param_0_reg_cr_t                        clk_param_0_reg_cr;
  clk_param_1_reg_cr_t                        clk_param_1_reg_cr;
  clk_param_2_reg_cr_t                        clk_param_2_reg_cr;
  clk_param_3_reg_cr_t                        clk_param_3_reg_cr;
  clk_sync_loss_cnt_reg_cr_t                  clk_sync_loss_cnt_reg_cr;
  clk_sync_stat_reg_cr_t                      clk_sync_stat_reg_cr;

  IW_fpga_pll_internal_dps_sync_addr_map_cr_req_t  req;
  IW_fpga_pll_internal_dps_sync_addr_map_cr_ack_t  ack;
 

//----------------------- Start of Code -----------------------------------

  /*  Synchronize the async register inputs */
  IW_fpga_double_sync#(.WIDTH(1),.NUM_STAGES(2))  u_IW_fpga_double_sync_coe_clk_sync_stat_rst_edge_det_int_n      (.clk(csi_clk),.sig_in(coe_clk_sync_stat_rst_edge_det_int_n      ),.sig_out(coe_clk_sync_stat_rst_edge_det_int_n_sync      ));
  IW_fpga_double_sync#(.WIDTH(1),.NUM_STAGES(2))  u_IW_fpga_double_sync_coe_clk_sync_stat_rst_pll_n               (.clk(csi_clk),.sig_in(coe_clk_sync_stat_rst_pll_n               ),.sig_out(coe_clk_sync_stat_rst_pll_n_sync               ));
  IW_fpga_double_sync#(.WIDTH(1),.NUM_STAGES(2))  u_IW_fpga_double_sync_coe_clk_sync_stat_rst_dps_int_n           (.clk(csi_clk),.sig_in(coe_clk_sync_stat_rst_dps_int_n           ),.sig_out(coe_clk_sync_stat_rst_dps_int_n_sync           ));
  IW_fpga_double_sync#(.WIDTH(1),.NUM_STAGES(2))  u_IW_fpga_double_sync_coe_clk_sync_stat_pll_dps_rst_clk_sync_n  (.clk(csi_clk),.sig_in(coe_clk_sync_stat_pll_dps_rst_clk_sync_n  ),.sig_out(coe_clk_sync_stat_pll_dps_rst_clk_sync_n_sync  ));
  IW_fpga_double_sync#(.WIDTH(1),.NUM_STAGES(2))  u_IW_fpga_double_sync_coe_clk_sync_stat_pll_locked              (.clk(csi_clk),.sig_in(coe_clk_sync_stat_pll_locked              ),.sig_out(coe_clk_sync_stat_pll_locked_sync              ));
  IW_fpga_double_sync#(.WIDTH(1),.NUM_STAGES(2))  u_IW_fpga_double_sync_coe_clk_sync_stat_pll_reset               (.clk(csi_clk),.sig_in(coe_clk_sync_stat_pll_reset               ),.sig_out(coe_clk_sync_stat_pll_reset_sync               ));
  IW_fpga_double_sync#(.WIDTH(1),.NUM_STAGES(2))  u_IW_fpga_double_sync_coe_clk_sync_stat_dps_locked              (.clk(csi_clk),.sig_in(coe_clk_sync_stat_dps_locked              ),.sig_out(coe_clk_sync_stat_dps_locked_sync              ));


  /*  Assign new register values  */
  always@(*)
  begin
    new_clk_param_0_reg_cr.PLL_NUM_CLKS                               = PLL_NUM_CLKS;
    new_clk_param_0_reg_cr.EDGE_DET_CNTR_W                            = EDGE_DET_CNTR_W;
    new_clk_param_0_reg_cr.DPS_WAIT_FOR_PHASE_DONE_EDGE_N_LEVEL       = DPS_WAIT_FOR_PHASE_DONE_EDGE_N_LEVEL;

    new_clk_param_1_reg_cr.DPS_NUM_SHIFTS_PER_CYCLE                   = DPS_NUM_SHIFTS_PER_CYCLE;

    new_clk_param_2_reg_cr.DPS_MIN_CLK_SYNC_FAIL_CYCLES               = DPS_MIN_CLK_SYNC_FAIL_CYCLES;

    new_clk_param_3_reg_cr.DPS_MIN_CLK_SYNC_PASS_CYCLES               = DPS_MIN_CLK_SYNC_PASS_CYCLES;

    new_clk_sync_stat_reg_cr.dps_locked                               = coe_clk_sync_stat_dps_locked_sync;
    new_clk_sync_stat_reg_cr.pll_reset                                = coe_clk_sync_stat_pll_reset_sync;
    new_clk_sync_stat_reg_cr.pll_locked                               = coe_clk_sync_stat_pll_locked_sync;
    new_clk_sync_stat_reg_cr.pll_dps_rst_clk_sync_n                   = coe_clk_sync_stat_pll_dps_rst_clk_sync_n_sync;
    new_clk_sync_stat_reg_cr.rst_dps_int_n                            = coe_clk_sync_stat_rst_dps_int_n_sync;
    new_clk_sync_stat_reg_cr.rst_pll_n                                = coe_clk_sync_stat_rst_pll_n_sync;
    new_clk_sync_stat_reg_cr.rst_edge_det_int_n                       = coe_clk_sync_stat_rst_edge_det_int_n_sync;

    new_clk_dps_fsm_reg_cr.dps_sync_fsm_pstate                        = coe_clk_dps_sync_fsm_pstate;
    new_clk_dps_fsm_reg_cr.dps_cntrl_fsm_pstate                       = coe_clk_dps_cntrl_fsm_pstate;
    new_clk_dps_pass_win_len_reg_cr.dps_pass_win_len                  = coe_clk_dps_pass_win_len;
    new_clk_sync_loss_cnt_reg_cr.clk_sync_loss_cnt                    = coe_clk_sync_loss_cnt;
    new_clk_dps_find_fail0_shift_cnt_reg_cr.dps_find_fail0_shift_cnt  = coe_clk_dps_find_fail0_shift_cnt;
    new_clk_dps_find_pass0_shift_cnt_reg_cr.dps_find_pass0_shift_cnt  = coe_clk_dps_find_pass0_shift_cnt;
    new_clk_dps_find_fail1_shift_cnt_reg_cr.dps_find_fail1_shift_cnt  = coe_clk_dps_find_fail1_shift_cnt;
    new_clk_dps_lock_dps_shift_cnt_reg_cr.dps_lock_dps_shift_cnt      = coe_clk_dps_lock_dps_shift_cnt;
    new_clk_dps_consec_sync_pass_cnt_reg_cr.dps_consec_sync_pass_cnt  = coe_clk_dps_consec_sync_pass_cnt;
    new_clk_dps_consec_fail_cnt_reg_cr.dps_consec_fail_cnt            = coe_clk_dps_consec_fail_cnt;
    new_clk_dps_lock_target_cnt_reg_cr.dps_lock_target_cnt            = coe_clk_dps_lock_target_cnt;
    new_clk_dps_lock_slip_cnt_reg_cr.dps_lock_slip_cnt                = coe_clk_dps_lock_slip_cnt;
  end
 
  /*  Instantiate address map */
  IW_fpga_pll_internal_dps_sync_addr_map  u_IW_fpga_pll_internal_dps_sync_addr_map
  (
       .rst_n                                           (rsi_reset_n)

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
      ,.new_clk_sync_loss_cnt_reg_cr                    (new_clk_sync_loss_cnt_reg_cr                    )
      ,.new_clk_sync_stat_reg_cr                        (new_clk_sync_stat_reg_cr                        )

      ,.clk_dps_consec_fail_cnt_reg_cr                  (clk_dps_consec_fail_cnt_reg_cr                  )
      ,.clk_dps_consec_sync_pass_cnt_reg_cr             (clk_dps_consec_sync_pass_cnt_reg_cr             )
      ,.clk_dps_find_fail0_shift_cnt_reg_cr             (clk_dps_find_fail0_shift_cnt_reg_cr             )
      ,.clk_dps_find_fail1_shift_cnt_reg_cr             (clk_dps_find_fail1_shift_cnt_reg_cr             )
      ,.clk_dps_find_pass0_shift_cnt_reg_cr             (clk_dps_find_pass0_shift_cnt_reg_cr             )
      ,.clk_dps_fsm_reg_cr                              (clk_dps_fsm_reg_cr                              )
      ,.clk_dps_lock_dps_shift_cnt_reg_cr               (clk_dps_lock_dps_shift_cnt_reg_cr               )
      ,.clk_dps_lock_slip_cnt_reg_cr                    (clk_dps_lock_slip_cnt_reg_cr                    )
      ,.clk_dps_lock_target_cnt_reg_cr                  (clk_dps_lock_target_cnt_reg_cr                  )
      ,.clk_dps_pass_win_len_reg_cr                     (clk_dps_pass_win_len_reg_cr                     )
      ,.clk_param_0_reg_cr                              (clk_param_0_reg_cr                              )
      ,.clk_param_1_reg_cr                              (clk_param_1_reg_cr                              )
      ,.clk_param_2_reg_cr                              (clk_param_2_reg_cr                              )
      ,.clk_param_3_reg_cr                              (clk_param_3_reg_cr                              )
      ,.clk_sync_loss_cnt_reg_cr                        (clk_sync_loss_cnt_reg_cr                        )
      ,.clk_sync_stat_reg_cr                            (clk_sync_stat_reg_cr                            )

      ,.req                                             (req                                             )
      ,.ack                                             (ack                                             )

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


endmodule // IW_fpga_pll_internal_dps_sync_addr_map_avmm_wrapper
