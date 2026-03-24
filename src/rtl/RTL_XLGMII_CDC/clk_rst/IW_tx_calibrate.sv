//------------------------------------------------------------------------------
//                               INTEL CONFIDENTIAL
//           Copyright 2013-2014 Intel Corporation All Rights Reserved. 
// 
// The source code contained or described herein and all documents related to
// the source code ("Material") are owned by Intel Corporation or its suppliers
// or licensors. Title to the Material remains with Intel Corporation or its
// suppliers and licensors. The Material contains trade secrets and proprietary
// and confidential information of Intel or its suppliers and licensors. The
// Material is protected by worldwide copyright and trade secret laws and treaty
// provisions. No part of the Material may be used, copied, reproduced, modified,
// published, uploaded, posted, transmitted, distributed, or disclosed in any way
// without Intel's prior express written permission.
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
 -- Module Name       : IW_tx_calibrate
 -- Author            : Vikas Akalwadi
 -- Associated modules: 
 -- Function          : 
 --------------------------------------------------------------------------
*/

`timescale 1ns / 10ps

module IW_tx_calibrate #(
   parameter INSTANCE_NAME          = "IW_tx_calibrate"
  ,parameter PARAM_WIDTH            = 32
  ,parameter GAL_CNTR_W             = 16
) (
   input  logic                                         i_clk_slow
  ,input  logic                                         i_clk_fast
  ,input  logic                                         i_rst_n

  ,input  logic                                         i_start_pulse
  ,input  logic [PARAM_WIDTH-1:0]                       i_start_offset
  ,input  logic [PARAM_WIDTH-1:0]                       i_end_offset
  ,input  logic [PARAM_WIDTH-1:0]                       i_iterations
  ,input  logic [PARAM_WIDTH-1:0]                       i_min_pulse
  ,input  logic [PARAM_WIDTH-1:0]                       i_max_pulse
  ,input  logic                                         i_gal_usync_align_point

  ,output logic [1:0]                                   o_tx_pulse
  ,input  logic [1:0]                                   i_rx_pulse

  ,output logic                                         o_end_pulse
  ,output logic                                         o_hit_valid
  ,output logic [PARAM_WIDTH-1:0]                       o_hit_tx_offset
  ,output logic [PARAM_WIDTH-1:0]                       o_hit_rx_offset
  ,output logic [PARAM_WIDTH-1:0]                       o_hit_iterations
  ,output logic [PARAM_WIDTH-1:0]                       o_hit_pulse_width

  ,output logic [4:0]                                   o_tx_calibrate_fsm

);

//----------------------- Internal Parameters -----------------------------

//----------------------- FSM Parameters --------------------------------------
//only for FSM state vector representation

parameter [4:0] IDLE            = 5'b00001,
                READ_PARAM      = 5'b00010,
                TX_PHASE        = 5'b00100,
                NULL_PHASE      = 5'b01000,
                UPDATE_RESULT   = 5'b10000;
logic [4:0] present_state;

bit                      clk_slow_rise;
bit                      clk_slow_fall;
bit                      clk_slow_der;
bit                      clk_slow_der_d1;
bit                      clk_slow_redge;
bit                      clk_slow_redge_e1;
bit                      clk_slow_redge_e2;

logic [PARAM_WIDTH-1:0]  cycle_count;
logic [PARAM_WIDTH-1:0]  cycle_count_e1;
logic [PARAM_WIDTH-1:0]  cycle_count_e2;
logic [PARAM_WIDTH-1:0]  cycle_count_period;
logic                    cycle_error;

logic [PARAM_WIDTH-1:0]  iteration_count;
logic [PARAM_WIDTH-1:0]  pulse_width_count;
logic [PARAM_WIDTH-1:0]  offset_count;
logic                    last_iteration_flag;
logic                    last_pulse_width_flag;
logic                    last_offset_flag;
logic                    s_start_pulse_flag;
logic [PARAM_WIDTH-1:0]  s_start_offset;
logic [PARAM_WIDTH-1:0]  s_end_offset;
logic [PARAM_WIDTH-1:0]  s_iterations;
logic [PARAM_WIDTH-1:0]  s_min_pulse;
logic [PARAM_WIDTH-1:0]  s_max_pulse;
logic [PARAM_WIDTH-1:0]  pw_count;
logic [PARAM_WIDTH-1:0]  s_hit_tx_offset;
logic [PARAM_WIDTH-1:0]  s_hit_rx_offset;
logic [PARAM_WIDTH-1:0]  s_hit_iterations;
logic [PARAM_WIDTH-1:0]  s_hit_pulse_width;
logic                    s_hit_valid;
logic                    s_tx_pulse;
logic                    s_null_phase;
logic [1:0]              s_rx_pulse_d1;

//Derivation of clock, early clock and other required signals
always_ff @(posedge i_clk_slow) clk_slow_rise <= ~clk_slow_rise;
always_ff @(negedge i_clk_slow) clk_slow_fall <= clk_slow_rise;
assign clk_slow_der = clk_slow_rise ^ clk_slow_fall;
always_ff @(posedge i_clk_fast) clk_slow_der_d1 <= clk_slow_der;
assign clk_slow_redge = clk_slow_der & ~clk_slow_der_d1;

// counters and early counters for generation of signals
always_ff @(posedge i_clk_fast) begin
  if(~i_rst_n) 
    cycle_count       <= 0;
  else begin
    if(clk_slow_redge & i_gal_usync_align_point )
      cycle_count    <= 0;
    else
      cycle_count    <= cycle_count + 1'b1;
  end
end

always_ff @(posedge i_clk_fast) begin
  if(clk_slow_redge & i_gal_usync_align_point )
    cycle_count_period <= cycle_count;
end

always_ff @(posedge i_clk_fast) begin
  if(cycle_count == (cycle_count_period - 3))
    clk_slow_redge_e2 <= 1'b1;
  else
    clk_slow_redge_e2 <= 1'b0;

  clk_slow_redge_e1 <= clk_slow_redge_e2;
end

always_ff @(posedge i_clk_fast) begin
  if(~i_rst_n) 
    cycle_count_e2       <= 0;
  else begin
    if(clk_slow_redge_e2)
      cycle_count_e2    <= 0;
    else
      cycle_count_e2    <= cycle_count_e2 + 1'b1;
  end
end
always_ff @(posedge i_clk_fast) cycle_count_e1 <= cycle_count_e2;

// Register all inputs for further processing
always_ff @(posedge i_clk_fast) begin
  if(i_start_pulse) begin
    s_start_offset    <= i_start_offset;
    s_end_offset      <= i_end_offset;
    s_iterations      <= i_iterations;
    s_min_pulse       <= i_min_pulse;
    s_max_pulse       <= i_max_pulse;
  end
end

//--------------------------------------------------------------------------------
// State machine
//--------------------------------------------------------------------------------
assign o_tx_calibrate_fsm = present_state;

always_ff @(posedge i_clk_fast) begin
  if(~i_rst_n)
    present_state <= IDLE;
  else
    case (present_state)
      IDLE        :
        if(clk_slow_redge_e2) present_state <= READ_PARAM;
      READ_PARAM  :
        if(clk_slow_redge_e2 && s_start_pulse_flag)
          present_state <= TX_PHASE;
      TX_PHASE    :
        if(clk_slow_redge_e2) present_state <= NULL_PHASE;
      NULL_PHASE  :
        if(clk_slow_redge_e2) begin
          if((last_iteration_flag && last_offset_flag && last_pulse_width_flag) ||
             (s_hit_valid && last_iteration_flag))
            present_state <= UPDATE_RESULT;
          else
            present_state <= TX_PHASE;
        end
      UPDATE_RESULT:
        if(clk_slow_redge_e2) present_state <= IDLE;
    endcase
end

// counters and early counters for generation of signals
always_ff @(posedge i_clk_fast) begin
  if(i_start_pulse)
    s_start_pulse_flag <= 1'b1;
  else if(clk_slow_redge_e2 && present_state == READ_PARAM)
    s_start_pulse_flag <= 1'b0;
end

// counters and early counters for generation of signals
always_ff @(posedge i_clk_fast) begin
  if(clk_slow_redge_e2) begin
    if(present_state == READ_PARAM)
      iteration_count <= 0;
    else
      if(present_state == NULL_PHASE) begin
        if(last_iteration_flag)
          iteration_count <= 0;
        else
          iteration_count <= iteration_count + 1'b1;
      end
  end
  
  if(clk_slow_redge_e2) begin
    if(present_state == READ_PARAM)
      offset_count <= s_start_offset;
    else
      if(present_state == NULL_PHASE && last_iteration_flag) begin
        if(last_offset_flag)
          offset_count <= s_start_offset;
        else
          offset_count <= offset_count + 1'b1;
      end
  end

  if(clk_slow_redge_e2) begin
    if(present_state == READ_PARAM)
      pulse_width_count <= s_min_pulse;
    else
      if(present_state == NULL_PHASE && last_iteration_flag && last_offset_flag) begin
        if(last_pulse_width_flag)
          pulse_width_count <= s_min_pulse;
        else
          pulse_width_count <= pulse_width_count + 1'b1;
      end
  end
end

// counters and early counters for generation of signals
always_ff @(posedge i_clk_fast) begin
    last_iteration_flag   <= (iteration_count == (s_iterations -1)) ? 1'b1 : 1'b0;
    last_offset_flag      <= (offset_count == s_end_offset)         ? 1'b1 : 1'b0;
    last_pulse_width_flag <= (pulse_width_count == s_max_pulse)     ? 1'b1 : 1'b0;
end

// Generating the pulse
always_ff @(posedge i_clk_fast) begin
  if(present_state == TX_PHASE) begin
    if(cycle_count_e2 == offset_count)
      s_tx_pulse <= 1'b1;
    else if(pw_count == (pulse_width_count -1))
      s_tx_pulse <= 1'b0;
  end else
    s_tx_pulse <= 1'b0;
end
assign o_tx_pulse[0] = s_tx_pulse;
assign o_tx_pulse[1] = s_tx_pulse;

always_ff @(posedge i_clk_fast) begin
  pw_count <= s_tx_pulse ? (pw_count+1'b1) : 0;
end

//--------------------------------------------------------------------------------
// Processing of the received pulse
//--------------------------------------------------------------------------------
always_ff @(posedge i_clk_fast)
  s_null_phase <= (present_state == NULL_PHASE) ? 1'b1 : 1'b0;

always_ff @(posedge i_clk_fast) 
  s_rx_pulse_d1 <= i_rx_pulse;

always_ff @(posedge i_clk_fast) begin
  if(i_start_pulse) begin
    s_hit_valid <= 1'b0;
    s_hit_iterations <= 0;
  end else
    if(i_rx_pulse[0] & ~s_rx_pulse_d1[0]) begin
      s_hit_valid       <= 1'b1;
      s_hit_iterations  <= s_hit_iterations + 1'b1;
    end  
end

always_ff @(posedge i_clk_fast) begin
  if(i_rx_pulse[0] & ~s_rx_pulse_d1[0]) begin
    s_hit_tx_offset   <= offset_count; 

    if(s_null_phase)
      s_hit_rx_offset   <= cycle_count_e1 + cycle_count_period + 1;
    else
      s_hit_rx_offset   <= cycle_count_e1;

    s_hit_pulse_width <= pulse_width_count;
  end  
end

assign o_hit_valid       = s_hit_valid;
assign o_hit_tx_offset   = s_hit_tx_offset;
assign o_hit_rx_offset   = s_hit_rx_offset;
assign o_hit_iterations  = s_hit_iterations;
assign o_hit_pulse_width = s_hit_pulse_width;

always_ff @(posedge i_clk_fast) begin
  if(present_state == UPDATE_RESULT && clk_slow_redge_e2)
    o_end_pulse <= 1'b1;
  else
    o_end_pulse <= 1'b0;
end

//----------------------------------------------------------------------
//-Validation of all parameters
//----------------------------------------------------------------------
if(PARAM_WIDTH < 8 )
  $error($sformatf("Provide a value greater than 8 for PARAM_WIDTH = %0d", PARAM_WIDTH));

endmodule // <module_name>
