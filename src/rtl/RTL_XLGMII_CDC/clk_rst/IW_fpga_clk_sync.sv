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
// File Name:     $RCSfile: IW_fpga_clk_sync.sv.rca $
// File Revision: $Revision: 1.2 $
// Created by:    Gregory James
// Updated by:    $Author: gjames $ $Date: Wed Feb 24 00:05:54 2016 $
//------------------------------------------------------------------------------

`timescale  1ps/1ps


module  IW_fpga_clk_sync  #(
    parameter NUM_DD_SYNC_STAGES          = 3
  , parameter CLK_SYN_MASTER              = 1
  , parameter CLK_CNT_IN_BUFFER           = 0 //1->Use demux on line CLK_SYNC_CNT_IN_IO,  0->No demux on line CLK_SYNC_CNT_IN_IO
  , parameter CLK_CNT_OUT_BUFFER          = 0 //1->Use mux on line CLK_SYNC_CNT_OUT_IO,  0->No mux on line CLK_SYNC_CNT_OUT_IO
  , parameter CLK_CNT_OUT_WIDTH           = 1 //Width of CLK_SYNC_CNT_OUT_IO. Clock count sync out will be replicated on each pin
  , parameter CLK_CNT_IN_MUX_RATIO        = 6
  , parameter CLK_CNT_IN_CLK_RATIO        = 4
  , parameter CLK_CNT_OUT_MUX_RATIO       = 6
  , parameter CLK_CNT_OUT_CLK_RATIO       = 4
  , parameter NUM_RESET_HOLD_CYCLES       = 2**16 //Number of cycles to assert the PLL reset signal
  , parameter STEP_INC_ENABLE             = 1     //1->Increment the reset hold time after each reset, 0->No increment
  , parameter PLL_RESET_STEP_MAX          = 255   //Maximum value of PLL reset step size. Should be less than NUM_RESET_HOLD_CYCLES
  , parameter PLL_STABLE_CNT0             = 2**10
  , parameter PLL_STABLE_CNT1             = 2**15
  , parameter CLK_SYNC_START_TIMEOUT      = 128   //Maximum number of continuos zero counts received
  , parameter FPGA_FAMILY                 = "S5"
  , parameter LFSR_WIDTH_IN               = 8     //The input sync count will be multiples of this
  , parameter LFSR_POLY_IN                = 8'hb8 //Value of polynomial used to generate pseudo-random number
  , parameter LFSR_WIDTH_OUT              = 8     //The output sync count will be multiples of this
  , parameter LFSR_POLY_OUT               = 8'hb8 //Value of polynomial used to generate pseudo-random number

) (

  //Mon clock, reset
    input   wire  clk_mon
  , input   wire  rst_mon_n

  //Reference clock, reset  to be synced
  , input   wire  clk_ref
  , input   wire  rst_ref_n

  , input   wire  pll_stable_cnt_sel

  //Mux-Demux clock, reset
  , input   wire  clk_in_mux_demux
  , input   wire  rst_in_mux_demux_n

  , input   wire  clk_out_mux_demux
  , input   wire  rst_out_mux_demux_n

  , inout   wire                          CLK_SYNC_CNT_IN_IO
  , inout   wire  [CLK_CNT_OUT_WIDTH-1:0] CLK_SYNC_CNT_OUT_IO

  , input   wire  [CLK_CNT_IN_MUX_RATIO-1:0]  clk_sync_cnt_in
  , output  wire  [CLK_CNT_OUT_MUX_RATIO-1:0] clk_sync_cnt_out

  //Control/Status
  , output  wire  ref_clk_sync_mismatch
  , output  wire  ref_clk_sync_stable
  , input   wire  ref_clk_locked
  , output  wire  ref_clk_sync_start_timeout

  /*  Debug */
  , output  wire  [CLK_CNT_IN_MUX_RATIO-1:0]  dbg_clk_sync_cnt_in_demux
  , output  wire  [CLK_CNT_OUT_MUX_RATIO-1:0] dbg_clk_sync_out_cntr

);

  /*  Internal Parameters */
  localparam  PLL_RESET_HOLD_CNTR_W         = $clog2(NUM_RESET_HOLD_CYCLES) + 1;
  localparam  PLL_RESET_STEP_W              = $clog2(PLL_RESET_STEP_MAX)  + 1;
  localparam  CLK_SYNC_START_TIMEOUT_CNTR_W = $clog2(CLK_SYNC_START_TIMEOUT)  + 1;

  /*
    * Function to calculate LFSR
  */
  function [LFSR_WIDTH_IN-1:0] gen_lfsr_in_nxt  (input  [LFSR_WIDTH_IN-1:0]  poly,  D);
    if(D[0])
    begin
      return  {1'b0,D[LFSR_WIDTH_IN-1:1]}  ^ poly;
    end
    else
    begin
      return  {1'b0,D[LFSR_WIDTH_IN-1:1]};
    end
  endfunction  //gen_lfsr_in_nxt

  function [LFSR_WIDTH_OUT-1:0] gen_lfsr_out_nxt  (input  [LFSR_WIDTH_OUT-1:0]  poly,  D);
    if(D[0])
    begin
      return  {1'b0,D[LFSR_WIDTH_OUT-1:1]}  ^ poly;
    end
    else
    begin
      return  {1'b0,D[LFSR_WIDTH_OUT-1:1]};
    end
  endfunction  //gen_lfsr_out_nxt



  /*  Internal Variables  */
  genvar  i;
  integer n;

  wire  [CLK_CNT_IN_MUX_RATIO-1:0]  clk_sync_cnt_in_demux;
  `ifdef  FPGA_SIM
    wire  [CLK_CNT_IN_MUX_RATIO-1:0]  clk_sync_cnt_in_demux_delayed;
  `endif
  wire  [CLK_CNT_IN_MUX_RATIO-1:0]  clk_cnt_in_sync;
  reg                               clk_cnt_sync_mismatch;
  reg                               clk_cnt_sync_started;
  reg [CLK_SYNC_START_TIMEOUT_CNTR_W-1:0] clk_sync_start_timeout_cntr;
  reg   [2:0]                       ref_clk_locked_sync;



  generate
    if(CLK_SYN_MASTER ==  0)
    begin
      if(CLK_CNT_IN_BUFFER  ==  1)  //Demux the clock count from line CLK_SYNC_CNT_IN_IO
      begin
        IW_fpga_demux_v2 #(
           .NUMBER_OF_INPUTS   (1)
          ,.MULTIPLEX_RATIO    (CLK_CNT_IN_MUX_RATIO)
          ,.CLOCK_RATIO        (CLK_CNT_IN_CLK_RATIO)
          ,.FPGA_FAMILY        (FPGA_FAMILY)
        ) IW_fpga_demux_clk_cnt_in  (
          .inbus              (CLK_SYNC_CNT_IN_IO),
          .clk_demux          (clk_in_mux_demux),
          .rst_demux_n        (rst_in_mux_demux_n),
          .outbus             (clk_sync_cnt_in_demux)
          //.ecc_err            ()
        );

        `ifdef  FPGA_SIM
          assign  #1ps clk_sync_cnt_in_demux_delayed = clk_sync_cnt_in_demux;
        `endif
      end
      else  //No demux, use clk_sync_cnt_in
      begin
        assign  clk_sync_cnt_in_demux  = clk_sync_cnt_in;

        IOBUF  iobuf_clk_sync_in_io  (.O(),.T(1'b0),.I(1'b0),.IO(CLK_SYNC_CNT_IN_IO)); //Tieoff IOs
      end
    end
    else  //Clk syn master, no need to demux
    begin
      assign  clk_sync_cnt_in_demux = {CLK_CNT_IN_MUX_RATIO{1'b0}};

      IOBUF  iobuf_clk_sync_in_io  (.O(),.T(1'b0),.I(1'b0),.IO(CLK_SYNC_CNT_IN_IO)); //Tieoff IOs
    end
  endgenerate

  assign  dbg_clk_sync_cnt_in_demux = clk_sync_cnt_in_demux;


  generate
    if(CLK_SYN_MASTER ==  0)
    begin
      localparam  CLK_CNT_IN_LFSR_REMAINDER  = (CLK_CNT_IN_MUX_RATIO - 1) % LFSR_WIDTH_IN;
      localparam  CLK_CNT_IN_LFSR_NUM_SLICES = (CLK_CNT_IN_LFSR_REMAINDER != 0) ? ((CLK_CNT_IN_MUX_RATIO - 1)  / LFSR_WIDTH_IN) + 1
                                                                                : (CLK_CNT_IN_MUX_RATIO - 1)   / LFSR_WIDTH_IN;

      reg   [CLK_CNT_IN_MUX_RATIO-1:0] clk_cnt_dd_sync [NUM_DD_SYNC_STAGES-1:0];
      reg   [LFSR_WIDTH_IN-1:0]        prn_in_exp_cntr;
      wire  [CLK_CNT_IN_MUX_RATIO-1:0] clk_sync_expected_cnt;

      /*  Synchronize the demuxed clock count to local reference clock  */
      always@(posedge clk_ref,  negedge rst_ref_n)
      begin
        if(~rst_ref_n)
        begin
          for(n=0;n<NUM_DD_SYNC_STAGES;n++)
          begin
            clk_cnt_dd_sync[n]  <=  0;
          end
        end
        else
        begin
          `ifdef  FPGA_SIM
            clk_cnt_dd_sync[0]  <=  clk_sync_cnt_in_demux_delayed; //To fix annoying race condition in sim
          `else
            clk_cnt_dd_sync[0]  <=  clk_sync_cnt_in_demux;
          `endif

          for(n=1;n<NUM_DD_SYNC_STAGES;n++)
          begin
            clk_cnt_dd_sync[n]  <=  clk_cnt_dd_sync[n-1];
          end
        end
      end

      assign  clk_cnt_in_sync = clk_cnt_dd_sync[NUM_DD_SYNC_STAGES-1];


      /*  Logic for checking that the count is in sync  */
      always@(posedge clk_ref,  negedge rst_ref_n)
      begin
        if(~rst_ref_n)
        begin
          clk_cnt_sync_mismatch         <=  0;
          clk_cnt_sync_started          <=  0;
          prn_in_exp_cntr               <=  0;
          clk_sync_start_timeout_cntr   <=  0;
        end
        else
        begin
          if((clk_cnt_in_sync[CLK_CNT_IN_MUX_RATIO-2:0] !=  0)  &&  ~clk_cnt_sync_started)  //Wait for non-zero value to come from sync count
          begin
            clk_cnt_sync_started  <=  1'b1;
            prn_in_exp_cntr       <=  gen_lfsr_in_nxt(.poly(LFSR_POLY_IN),  .D(clk_cnt_in_sync[LFSR_WIDTH_IN-1:0])); //The count should start incrementing from this point
          end
          else  if(clk_cnt_sync_started)  //Check if the count does not increment properly
          begin
            clk_cnt_sync_mismatch <=  (clk_cnt_in_sync  ==  clk_sync_expected_cnt)  ? clk_cnt_sync_mismatch : 1'b1; //sticky
            prn_in_exp_cntr       <=  gen_lfsr_in_nxt(.poly(LFSR_POLY_IN),  .D(prn_in_exp_cntr));
          end
          else
          begin
            clk_cnt_sync_mismatch <=  clk_cnt_sync_mismatch;
            clk_cnt_sync_started  <=  clk_cnt_sync_started;
            prn_in_exp_cntr       <=  prn_in_exp_cntr;
          end

          if(clk_cnt_in_sync[CLK_CNT_IN_MUX_RATIO-2:0]  !=  0)
          begin
            clk_sync_start_timeout_cntr <=  0;
          end
          else  if(ref_clk_sync_start_timeout)
          begin
            clk_sync_start_timeout_cntr <=  clk_sync_start_timeout_cntr;
          end
          else
          begin
            clk_sync_start_timeout_cntr <=  clk_sync_start_timeout_cntr + 1'b1;
          end
        end
      end

      for(i=0;i<CLK_CNT_IN_LFSR_NUM_SLICES;i++)
      begin : gen_clk_sync_expected_cnt
        if((i==CLK_CNT_IN_LFSR_NUM_SLICES-1) &&  (CLK_CNT_IN_LFSR_REMAINDER!=0))
        begin
          assign  clk_sync_expected_cnt[(i*LFSR_WIDTH_IN)  +:  CLK_CNT_IN_LFSR_REMAINDER] = prn_in_exp_cntr[CLK_CNT_IN_LFSR_REMAINDER-1:0];
        end
        else
        begin
          assign  clk_sync_expected_cnt[(i*LFSR_WIDTH_IN)  +:  LFSR_WIDTH_IN] = prn_in_exp_cntr;
        end
      end

      assign  clk_sync_expected_cnt[CLK_CNT_IN_MUX_RATIO-1] = ~clk_sync_expected_cnt[CLK_CNT_IN_MUX_RATIO-2];
    end
    else  //Clk syn master
    begin
      always@(*)
      begin
        clk_cnt_sync_mismatch = 1'b0;
        clk_cnt_sync_started  = 1'b0;
        clk_sync_start_timeout_cntr = 0;
      end
    end
  endgenerate

  assign  ref_clk_sync_start_timeout  = (clk_sync_start_timeout_cntr  ==  CLK_SYNC_START_TIMEOUT) ? 1'b1  : 1'b0;


  /*  Logic  for self reset */
  generate
    if(CLK_SYN_MASTER ==  0)
    begin
      /*  Synchronize the clk count sync mismatch signal to mon clk  */
      reg [NUM_DD_SYNC_STAGES:0]  clk_cnt_sync_mismatch_dd_sync;

      always@(posedge clk_mon, negedge rst_mon_n)
      begin
        if(~rst_mon_n)
        begin
          clk_cnt_sync_mismatch_dd_sync   <=  0;
        end
        else
        begin
          clk_cnt_sync_mismatch_dd_sync[0]  <=  clk_cnt_sync_mismatch;

          for(n=1;n<NUM_DD_SYNC_STAGES+1;n++)
          begin
            clk_cnt_sync_mismatch_dd_sync[n]  <=  clk_cnt_sync_mismatch_dd_sync[n-1];
          end
        end
      end

      /*  Derive a pulse based on rising edge of clk count sync mismatch  */
      wire                         trigger_clk_rst;

      assign  trigger_clk_rst = clk_cnt_sync_mismatch_dd_sync[NUM_DD_SYNC_STAGES-1] & ~clk_cnt_sync_mismatch_dd_sync[NUM_DD_SYNC_STAGES];  //rising edge pulse


      /*  Clk Ref PLL Reset Logic */
      reg [PLL_RESET_HOLD_CNTR_W-1:0] pll_reset_hold_cntr;
      reg [PLL_RESET_STEP_W-1:0]      pll_reset_hold_cntr_step;
      reg                             clk_sync_mismatch;
      wire                            inc_step_en;

      assign  inc_step_en = (STEP_INC_ENABLE  ==  1)  ? 1'b1  : 1'b0;


      always@(posedge clk_mon, negedge rst_mon_n)
      begin
        if(~rst_mon_n)
        begin
          pll_reset_hold_cntr       <=  0;
          clk_sync_mismatch         <=  0;
          pll_reset_hold_cntr_step  <=  {{(PLL_RESET_STEP_W-1){1'b0}},1'b1};
        end
        else
        begin
          /*  Hold counter trigger logic  */
          if(trigger_clk_rst)
          begin
            pll_reset_hold_cntr <=  {{(PLL_RESET_HOLD_CNTR_W-1){1'b0}},1'b1}  + pll_reset_hold_cntr_step;
            pll_reset_hold_cntr_step  <=  pll_reset_hold_cntr_step  + inc_step_en;
          end
          else  if(pll_reset_hold_cntr  ==  NUM_RESET_HOLD_CYCLES)  //Goto rest
          begin
            pll_reset_hold_cntr <=  0;
          end
          else  if(pll_reset_hold_cntr  !=  0)  //Keep incrementing
          begin
            pll_reset_hold_cntr <=  pll_reset_hold_cntr + 1'b1;
          end
          else
          begin
            pll_reset_hold_cntr <=  pll_reset_hold_cntr;
            pll_reset_hold_cntr_step  <=  pll_reset_hold_cntr_step;
          end

          if(clk_sync_mismatch) //Hold the reset for NUM_RESET_HOLD_CYCLES
          begin
            clk_sync_mismatch   <=  (pll_reset_hold_cntr  !=  0)  ? clk_sync_mismatch : 1'b0;
          end
          else  //De-assert the reset, wait for trigger
          begin
            clk_sync_mismatch   <=  trigger_clk_rst;
          end
        end
      end

      assign  ref_clk_sync_mismatch =   clk_sync_mismatch;
    end
    else  //Clk syn master
    begin
      assign  ref_clk_sync_mismatch =   1'b0;
    end
  endgenerate

  generate
    if(CLK_SYN_MASTER ==  0)
    begin
      localparam  PLL_STABLE_CNTR_W = (PLL_STABLE_CNT0  > PLL_STABLE_CNT1)  ? $clog2(PLL_STABLE_CNT0) + 1 : $clog2(PLL_STABLE_CNT1) + 1;

      reg   [PLL_STABLE_CNTR_W-1:0]   ref_clk_sync_stable_cntr;
      wire  [PLL_STABLE_CNTR_W-1:0]   ref_clk_stable_cnt;
      reg                             clk_sync_stable;
      reg   [1:0]                     pll_stable_cnt_sel_sync;

      assign  ref_clk_stable_cnt  = pll_stable_cnt_sel_sync[1]  ? PLL_STABLE_CNT1 : PLL_STABLE_CNT0;

      always@(posedge clk_ref,  negedge rst_ref_n)
      begin
        if(~rst_ref_n)
        begin
          ref_clk_sync_stable_cntr  <=  0;
          clk_sync_stable           <=  0;

          pll_stable_cnt_sel_sync   <=  0;
        end
        else
        begin
          pll_stable_cnt_sel_sync   <=  {pll_stable_cnt_sel_sync[0],pll_stable_cnt_sel};

          if(ref_clk_sync_stable_cntr  >=  ref_clk_stable_cnt) //Hold this value
          begin
            ref_clk_sync_stable_cntr <=  ref_clk_sync_stable_cntr;
          end
          else
          begin
            ref_clk_sync_stable_cntr <=  ref_clk_sync_stable_cntr + clk_cnt_sync_started;
          end

          clk_sync_stable           <=  (ref_clk_sync_stable_cntr  >=  ref_clk_stable_cnt) ? ~ref_clk_sync_mismatch : 1'b0;
        end
      end

      assign  ref_clk_sync_stable   = clk_sync_stable;
    end
    else  //CLK Syn Master
    begin
      assign  ref_clk_sync_stable  = 1'b1;
    end
  endgenerate


  /*  Synchronize ref_clk_locked  */
  always@(posedge clk_ref,  negedge rst_ref_n)
  begin
    if(~rst_ref_n)
    begin
      ref_clk_locked_sync <=  0;
    end
    else
    begin
      ref_clk_locked_sync <=  {ref_clk_locked_sync[1:0],ref_clk_locked};
    end
  end

  generate
    if(CLK_CNT_OUT_BUFFER ==  1)
    begin
      localparam  CLK_CNT_OUT_LFSR_REMAINDER  = (CLK_CNT_OUT_MUX_RATIO - 1) % LFSR_WIDTH_OUT;
      localparam  CLK_CNT_OUT_LFSR_NUM_SLICES = (CLK_CNT_OUT_LFSR_REMAINDER != 0 ) ? ((CLK_CNT_OUT_MUX_RATIO - 1)  / LFSR_WIDTH_OUT) + 1
                                                                                   : (CLK_CNT_OUT_MUX_RATIO - 1)   / LFSR_WIDTH_OUT;

      reg   [LFSR_WIDTH_OUT-1:0]        prn_out_cntr; //pseudo-random number counter
      wire  [CLK_CNT_OUT_MUX_RATIO-1:0] clk_sync_out_cntr;

      always@(posedge clk_ref,  negedge rst_ref_n)
      begin
        if(~rst_ref_n)
        begin
          prn_out_cntr        <=  0;
        end
        else
        begin
          if(~ref_clk_locked_sync[2])  //Continuosly transmit 0's so that downstream FPGAs will not lock
          begin
            prn_out_cntr      <=  {LFSR_WIDTH_OUT{^ref_clk_locked_sync[2:1]}};  //Wait for sync & then start from non-zero value
          end
          else
          begin
            prn_out_cntr      <=  gen_lfsr_out_nxt(.poly(LFSR_POLY_OUT),  .D(prn_out_cntr));
          end
        end
      end

      //Replicate pattern for full mux-ratio width
      for(i=0;i<CLK_CNT_OUT_LFSR_NUM_SLICES;i++)
      begin : gen_clk_sync_out_cntr
        if((i==CLK_CNT_OUT_LFSR_NUM_SLICES-1) &&  (CLK_CNT_OUT_LFSR_REMAINDER != 0 ))
        begin
          assign  clk_sync_out_cntr[(i*LFSR_WIDTH_OUT)  +:  CLK_CNT_OUT_LFSR_REMAINDER] = prn_out_cntr[CLK_CNT_OUT_LFSR_REMAINDER-1:0];
        end
        else
        begin
          assign  clk_sync_out_cntr[(i*LFSR_WIDTH_OUT)  +:  LFSR_WIDTH_OUT] = prn_out_cntr;
        end
      end

      //Ensure MSB two bits are compliments of each other so that the resolution
      //of clock sync is half period
      assign  clk_sync_out_cntr[CLK_CNT_OUT_MUX_RATIO-1]  = ref_clk_locked_sync[2] ? ~clk_sync_out_cntr[CLK_CNT_OUT_MUX_RATIO-2] : 1'b0;

      assign  dbg_clk_sync_out_cntr = clk_sync_out_cntr;

      //Send the pattern to each IO line
      for(i=0;i<CLK_CNT_OUT_WIDTH;i++)
      begin : gen_clk_cnt_out
        IW_fpga_mux_v2 #(
           .NUMBER_OF_OUTPUTS   (1)
         , .MULTIPLEX_RATIO     (CLK_CNT_OUT_MUX_RATIO)
         , .CLOCK_RATIO         (CLK_CNT_OUT_CLK_RATIO)
         , .FPGA_FAMILY         (FPGA_FAMILY)
        ) IW_fpga_mux_clk_cnt_out (
          .outbus         (CLK_SYNC_CNT_OUT_IO[i]),
          .clk_mux        (clk_out_mux_demux),
          .rst_mux_n      (rst_out_mux_demux_n),
          .inbus          (clk_sync_out_cntr)
        );
      end

      assign  clk_sync_cnt_out  = clk_sync_out_cntr;
    end
    else
    begin
      assign  clk_sync_cnt_out  = {CLK_CNT_OUT_MUX_RATIO{1'b0}};

      for(i=0;i<CLK_CNT_OUT_WIDTH;i++)
      begin : gen_clk_cnt_out_tieoff
        IOBUF  iobuf_clk_sync_out_io  (.O(),.T(1'b0),.I(1'b0),.IO(CLK_SYNC_CNT_OUT_IO[i])); //Tieoff IOs
      end
    end
  endgenerate


endmodule //IW_fpga_clk_sync

//------------------------------------------------------------------------------
// Change History:
//
// $Log: IW_fpga_clk_sync.sv.rca $
// 
//  Revision: 1.2 Wed Feb 24 00:05:54 2016 gjames
//  Parameterized clock sync out io port
// 
//  Revision: 1.1 Mon Oct 26 01:28:50 2015 gjames
//  Initial Commit
// 
// 
//------------------------------------------------------------------------------

