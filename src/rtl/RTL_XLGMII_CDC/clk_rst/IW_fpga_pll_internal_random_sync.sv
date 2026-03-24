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
 -- Module Name       : IW_fpga_pll_internal_random_sync
 -- Author            : Gregory James
 -- Associated modules: 
 -- Function          : This module can be used to synchronize a PLL by randomly
                        asserting reset to the PLL & comparing edges with a
                        reference clock.
 --------------------------------------------------------------------------
*/

`timescale 1ns / 10ps


module IW_fpga_pll_internal_random_sync #(
   parameter  PRBS_WIDTH      = 4
  ,parameter  PRBS_POLY       = 4'hc
  ,parameter  EDGE_DET_CNTR_W = 8
  ,parameter  RST_SCALE       = 0

) (

   input  logic     clk_fast
  ,input  logic     rst_fast_n

  ,input  logic     clk_ref
  ,input  logic     rst_ref_n

  ,input  logic     clk_pll
  ,input  logic     pll_locked
  ,output logic     pll_reset
  ,output logic     pll_sync_done

);

//----------------------- Import Packages ---------------------------------


//----------------------- Internal Parameters -----------------------------
  localparam  PLL_RST_CNTR_W    = PRBS_WIDTH  + RST_SCALE;

  /*
    * Function to calculate LFSR
  */
  function [PRBS_WIDTH-1:0] gen_prbs_nxt  (input  [PRBS_WIDTH-1:0]  poly,  D);
    if(D[0])
    begin
      return  {1'b0,D[PRBS_WIDTH-1:1]}  ^ poly;
    end
    else
    begin
      return  {1'b0,D[PRBS_WIDTH-1:1]};
    end
  endfunction  //gen_prbs_nxt



//----------------------- Internal Register Declarations ------------------


//----------------------- Internal Wire Declarations ----------------------
  logic                       clk_ref_edge_det_valid;
  logic                       rst_pll_n;
  logic [5:0]                 rst_pll_n_d;
  logic                       clk_pll_edge_det_valid;
  logic                       rst_pll_n_sync;
  logic [PRBS_WIDTH-1:0]      pll_rst_cnt_prbs;
  logic [PLL_RST_CNTR_W-1:0]  pll_rst_cnt_prbs_scaled;
  logic [PLL_RST_CNTR_W-1:0]  pll_rst_cnt;
  logic                       pll_rst_done;


//----------------------- FSM Parameters --------------------------------------
  typedef enum  logic [1:0] {
    IDLE_S              = 2'd0,
    RESET_PLL_S         = 2'd1,
    WAIT_FOR_PLL_LOCK_S = 2'd2,
    CHECK_EDGES_S       = 2'd3
  } IW_fpga_pll_internal_random_sync_fsm_t;

  IW_fpga_pll_internal_random_sync_fsm_t   fsm_pstate, fsm_next_state;


//----------------------- Start of Code -----------------------------------

  /*  Detect Rising Edge of Reference Clock */
  IW_fpga_early_clk_det #(
     .CNTR_W            (EDGE_DET_CNTR_W)
    ,.NUM_CYCLES_EARLY  (0)

  ) u_IW_fpga_early_clk_det_ref (

     .clk_fast            (clk_fast)
    ,.rst_fast_n          (rst_fast_n)

    ,.clk_slow            (clk_ref)
    ,.rst_slow_n          (rst_ref_n)

    ,.edge_det_cntr       ()
    ,.edge_det_start_val  ()
    ,.edge_det_valid      (clk_ref_edge_det_valid)

  );

  /*  Generate synchronous reset for clk_pll  */
  IW_sync_reset u_sync_rst_pll_n  (.clk(clk_pll),.rst_n(pll_locked),.rst_n_sync(rst_pll_n));

  /*  Delay the synchronous reset for clk_pll */
  always@(posedge clk_pll,  negedge rst_pll_n)
  begin
    if(~rst_pll_n)
    begin
      rst_pll_n_d             <=  0;
    end
    else
    begin
      rst_pll_n_d             <=  {rst_pll_n_d[4:0],1'b1};
    end
  end

  /*  Synchronize pll_locked to fast-clock  */
  IW_sync_posedge #(.WIDTH(1),.NUM_STAGES(2)) u_sync_pll_locked (.clk(clk_fast),.rst_n(rst_fast_n),.data(rst_pll_n_d[5]),.data_sync(rst_pll_n_sync));

  /*  Detect Rising Edge of PLL Clock */
  IW_fpga_early_clk_det #(
     .CNTR_W            (EDGE_DET_CNTR_W)
    ,.NUM_CYCLES_EARLY  (0)

  ) u_IW_fpga_early_clk_det_pll (

     .clk_fast            (clk_fast)
    ,.rst_fast_n          (rst_fast_n)

    ,.clk_slow            (clk_pll)
    ,.rst_slow_n          (rst_pll_n)

    ,.edge_det_cntr       ()
    ,.edge_det_start_val  ()
    ,.edge_det_valid      (clk_pll_edge_det_valid)

  );

  /*  PLL Reset Logic */
  always@(posedge clk_fast, negedge rst_fast_n)
  begin
    if(~rst_fast_n)
    begin
      fsm_pstate              <=  IDLE_S;
      pll_rst_cnt_prbs        <=  {PRBS_WIDTH{1'b1}};
      pll_rst_cnt             <=  0;
      pll_reset               <=  0;
      pll_sync_done           <=  0;
    end
    else
    begin
      fsm_pstate              <=  fsm_next_state;

      case(fsm_pstate)
        IDLE_S  :
        begin
          pll_rst_cnt_prbs    <=  {PRBS_WIDTH{1'b1}};
          pll_rst_cnt         <=  0;
          pll_reset           <=  0;
          pll_sync_done       <=  0;
        end

        RESET_PLL_S :
        begin
          pll_rst_cnt_prbs    <=  pll_rst_done  ? gen_prbs_nxt(.poly(PRBS_POLY),.D(pll_rst_cnt_prbs)) : pll_rst_cnt_prbs;
          pll_rst_cnt         <=  pll_rst_done  ? 0 : pll_rst_cnt + 1'b1;
          pll_reset           <=  ~pll_rst_done;
          pll_sync_done       <=  0;
        end

        CHECK_EDGES_S :
        begin
          pll_sync_done       <=  pll_sync_done | (clk_ref_edge_det_valid & clk_pll_edge_det_valid);
        end

      endcase
    end
  end

  //Scale PRBS count
  generate
    if(RST_SCALE  ==  0)
    begin
      assign  pll_rst_cnt_prbs_scaled = pll_rst_cnt_prbs;
    end
    else
    begin
      assign  pll_rst_cnt_prbs_scaled = {pll_rst_cnt_prbs,{RST_SCALE{1'b0}}};
    end
  endgenerate

  //Check if PLL reset counter is done
  assign  pll_rst_done  = (pll_rst_cnt  ==  pll_rst_cnt_prbs_scaled) ? 1'b1  : 1'b0;

  always@(*)
  begin
    fsm_next_state    = fsm_pstate;

    case(fsm_pstate)
      IDLE_S  :
      begin
        fsm_next_state        = RESET_PLL_S;
      end

      RESET_PLL_S :
      begin
        fsm_next_state        = pll_rst_done  ? WAIT_FOR_PLL_LOCK_S : RESET_PLL_S;
      end

      WAIT_FOR_PLL_LOCK_S :
      begin
        fsm_next_state        = rst_pll_n_sync  ? CHECK_EDGES_S : WAIT_FOR_PLL_LOCK_S;
      end

      CHECK_EDGES_S :
      begin
        fsm_next_state        = (clk_ref_edge_det_valid ^ clk_pll_edge_det_valid) ? RESET_PLL_S : CHECK_EDGES_S;
      end
    endcase
  end

endmodule // IW_fpga_pll_internal_random_sync
