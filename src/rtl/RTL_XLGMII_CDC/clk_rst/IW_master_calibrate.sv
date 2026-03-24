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
 -- Module Name       : IW_master_calibrate
 -- Author            : Vikas Akalwadi
 -- Associated modules: 
 -- Function          : 
 --------------------------------------------------------------------------
*/

`timescale 1ns / 10ps

module IW_master_calibrate #(
    parameter INSTANCE_NAME          = "IW_master_calibrate"
   ,parameter PARAM_WIDTH            = 32

   ,parameter START_OFFSET_POSITION  = 0
   ,parameter END_OFFSET_POSITION    = 8
   ,parameter NUM_ITERATIONS         = 3
   ,parameter MIN_PULSE_WIDTH        = 1
   ,parameter MAX_PULSE_WIDTH        = 1
   ,parameter NUM_PLL_CLOCKS         = 1

   ,parameter CLOCK_RATIO            = 16
   ,parameter VCO_SHIFT_PER_PULSE    = 6*8 //6 clocks for 900 MHz / 200 MHz 
                                            //10 clocks for 1200 MHz / 200 MHz
   , parameter MC_FAST_CLK_SHIFT     = 0 //0->Shift by 1 (supported by gal sync)
                                         //1->Shift by 4 to make simulation fast (supported by MC clk sync)

) (
   input  logic                                         i_clk_mon
  ,input  logic                                         i_rst_mon_n

  // Calibrate Tx module side interface
  ,output logic                                         o_start_pulse
  ,output logic [PARAM_WIDTH-1:0]                       o_start_offset
  ,output logic [PARAM_WIDTH-1:0]                       o_end_offset
  ,output logic [PARAM_WIDTH-1:0]                       o_iterations
  ,output logic [PARAM_WIDTH-1:0]                       o_min_pulse
  ,output logic [PARAM_WIDTH-1:0]                       o_max_pulse

  ,input  logic                                         i_end_pulse
  ,input  logic                                         i_hit_valid
  ,input  logic [PARAM_WIDTH-1:0]                       i_hit_tx_offset
  ,input  logic [PARAM_WIDTH-1:0]                       i_hit_rx_offset
  ,input  logic [PARAM_WIDTH-1:0]                       i_hit_iterations
  ,input  logic [PARAM_WIDTH-1:0]                       i_hit_pulse_width

  ,input  logic [NUM_PLL_CLOCKS-1:0] [4:0]              i_dps_clk_tap
  ,output logic                                         o_calibration_success
  ,output logic                                         o_failure_detected
  ,output logic                                         o_rst_clk_sync_n

  // DPS side interface
  ,output logic                                         o_pll_updn
  ,output logic [4:0]                                   o_pll_cnt_sel
  ,output logic                                         o_pll_phase_en
  ,input  logic                                         i_pll_phase_done

  ,output logic [9:0]                                   o_master_calibrate_fsm
  ,output logic  [PARAM_WIDTH-1:0]                      o_dps_f0f1_point_diff
  ,output logic  [PARAM_WIDTH-1:0]                      o_failure_detected_cntr 
  ,output  wire  [2:0]                                  pll_out_shift
);

//----------------------- FSM Parameters --------------------------------------
//only for FSM state vector representation
parameter [3:0] IDLE          = 4'd0,
                PROGRAM_CAL   = 4'd1,
                CALIBRATE     = 4'd2,
                REPROG_CAL    = 4'd3,
                RECALIBRATE   = 4'd4,
                PROG_DPS_1    = 4'd5,
                PROG_DPS_2    = 4'd6,
                PHASE_SHIFT   = 4'd7,
                FE_BEGIN      = 4'd8,
                FE_CALIB      = 4'd9,
                FE_CHECK      = 4'd10,
                FE_PSHIFT     = 4'd11,
                FE_SHIFT_BACK = 4'd12,
                FE_SHIFT_MID  = 4'd13,
                FE_CAL_CHK    = 4'd14,
                FE_CAL_CHK_W  = 4'd15;

logic [9:0]            present_state;

logic                  s_dps_in_prog_d1;
logic                  s_dps_trig;
logic                  s_dps_updn;
logic [31:0]           s_dps_num_shifts;
logic                  s_dps_in_prog;
logic [PARAM_WIDTH-1:0] s_hit_pulse_width;
logic [PARAM_WIDTH-1:0] s_dps_f0_point;
logic [PARAM_WIDTH-1:0] s_dps_f1_point;
logic                   s_dps_f0_flag;
logic [PARAM_WIDTH-1:0] s_dps_f0f1_point;
logic [PARAM_WIDTH-1:0] s_dps_f0f1_point_diff;

localparam OPERAND_WIDTH = 20;
logic [OPERAND_WIDTH-1:0]    s_hit_tx_offset;
(*  syn_keep  = 1 *) logic [OPERAND_WIDTH-1:0]    s_transit_time;

logic [32+OPERAND_WIDTH-1:0] s_coarse_shift_vco;
logic [32+OPERAND_WIDTH-1:0] s_fine_shift_vco;

logic [32-1:0]               s_VCO_SHIFT_PER_PULSE;
logic [32-1:0]               s_VCO_SHIFT_FOUR_PULSE;
logic [32-1:0]               s_VCO_SHIFT_counter;
logic [32-1:0]               s_VCO_SHIFT_INCREMENT;
logic                        s_VCO_SHIFT_flag;

logic [4:0]                  s_dps_clk_tap [NUM_PLL_CLOCKS-1:0];

genvar idx;
for (idx=0;idx < NUM_PLL_CLOCKS; idx++) 
  assign s_dps_clk_tap[idx] = i_dps_clk_tap[idx];

//--------------------------------------------------------------------------------
// State machine
//--------------------------------------------------------------------------------
assign o_master_calibrate_fsm = present_state;
always_ff @(posedge i_clk_mon) begin
  if(~i_rst_mon_n)
    present_state <= IDLE;
  else
    case (present_state)
      IDLE        :
        present_state <= PROGRAM_CAL;
      PROGRAM_CAL :
        present_state <= CALIBRATE;
      CALIBRATE   :
        if(i_end_pulse) begin
          if(i_hit_valid)
            present_state <= REPROG_CAL;
          else
            present_state <= PROGRAM_CAL;
        end
      REPROG_CAL  :
        present_state <= RECALIBRATE;
      RECALIBRATE :
        if(i_end_pulse) begin
          if(i_hit_valid)
            present_state <= PROG_DPS_1;
          else
            present_state <= PROGRAM_CAL;
        end
      PROG_DPS_1 :
        present_state <= PROG_DPS_2;
      PROG_DPS_2 :
        present_state <= PHASE_SHIFT;
      PHASE_SHIFT :
        if(~s_dps_in_prog && s_dps_in_prog_d1)
          present_state <= FE_BEGIN;
      FE_BEGIN    :
        present_state <= FE_CALIB;
      FE_CALIB    :
        if(i_end_pulse)
          present_state <= FE_CHECK;
      FE_CHECK    :
        if(s_VCO_SHIFT_flag)
          present_state <= FE_SHIFT_BACK;
        else
          present_state <= FE_PSHIFT;
      FE_PSHIFT   :
        if(~s_dps_in_prog && s_dps_in_prog_d1)
          present_state <= FE_BEGIN;
      FE_SHIFT_BACK :
        if(~s_dps_in_prog && s_dps_in_prog_d1)
          present_state <= FE_SHIFT_MID;
      FE_SHIFT_MID  :
        if(~s_dps_in_prog && s_dps_in_prog_d1)
          present_state <= FE_CAL_CHK;
      FE_CAL_CHK    :
        present_state <= FE_CAL_CHK_W;
      FE_CAL_CHK_W  :
        if(i_end_pulse)
          present_state <= FE_CAL_CHK;
    endcase
end

//---------------------------------------------------------------------------
// Parameters to Calibrate Tx module
//---------------------------------------------------------------------------
always @(posedge i_clk_mon) begin
  case(present_state)
    IDLE :
      begin
        o_start_pulse       <= 'b0;
        o_start_offset      <= 'b0;
        o_end_offset        <= 'b0;
        o_iterations        <= 'b0;
        o_min_pulse         <= 'b0;
        o_max_pulse         <= 'b0;
      end
    PROGRAM_CAL :
      begin
        o_start_pulse       <= 1'b1;
        o_start_offset      <= START_OFFSET_POSITION;
        o_end_offset        <= END_OFFSET_POSITION;
        o_iterations        <= NUM_ITERATIONS;
        o_min_pulse         <= MIN_PULSE_WIDTH;
        o_max_pulse         <= MAX_PULSE_WIDTH;
      end
    CALIBRATE :
      begin
        o_start_pulse       <= 'b0;
        o_start_offset      <= START_OFFSET_POSITION;
        o_end_offset        <= END_OFFSET_POSITION;
        o_iterations        <= NUM_ITERATIONS;
        o_min_pulse         <= MIN_PULSE_WIDTH;
        o_max_pulse         <= MAX_PULSE_WIDTH;
      end
    REPROG_CAL :
      begin
        o_start_pulse       <= 1'b1;
        o_start_offset      <= START_OFFSET_POSITION;
        o_end_offset        <= END_OFFSET_POSITION;
        o_iterations        <= NUM_ITERATIONS;
        o_min_pulse         <= MIN_PULSE_WIDTH;
        o_max_pulse         <= MAX_PULSE_WIDTH;
      end
    RECALIBRATE, PROG_DPS_1, PROG_DPS_2, PHASE_SHIFT : 
      begin
        o_start_pulse       <= 'b0;
        o_start_offset      <= START_OFFSET_POSITION;
        o_end_offset        <= END_OFFSET_POSITION;
        o_iterations        <= NUM_ITERATIONS;
        o_min_pulse         <= MIN_PULSE_WIDTH;
        o_max_pulse         <= MAX_PULSE_WIDTH;
      end
    FE_BEGIN :
      begin
        o_start_pulse       <= 'b1;
        o_start_offset      <= 'b0;
        o_end_offset        <= 'b0;
        o_iterations        <= NUM_ITERATIONS;
        o_min_pulse         <= s_hit_pulse_width;
        o_max_pulse         <= s_hit_pulse_width;
      end
    FE_CALIB,FE_CHECK, FE_PSHIFT, FE_SHIFT_BACK, FE_SHIFT_MID :
      begin
        o_start_pulse       <= 'b0;
        o_start_offset      <= 'b0;
        o_end_offset        <= 'b0;
        o_iterations        <= NUM_ITERATIONS;
        o_min_pulse         <= s_hit_pulse_width;
        o_max_pulse         <= s_hit_pulse_width;
      end
    FE_CAL_CHK :
    // offset now is clock-ratio-1 deducted by half of transmit time
      begin
        o_start_pulse       <= 'b1;
        o_start_offset      <= CLOCK_RATIO  - s_transit_time[OPERAND_WIDTH-1:4];
        o_end_offset        <= CLOCK_RATIO  - s_transit_time[OPERAND_WIDTH-1:4]; 
        o_iterations        <= NUM_ITERATIONS;
        o_min_pulse         <= s_hit_pulse_width;
        o_max_pulse         <= s_hit_pulse_width;
      end
    FE_CAL_CHK_W :
    // offset now is clock-ratio-1 deducted by half of transmit time
      begin
        o_start_pulse       <= 'b0;
        o_start_offset      <= CLOCK_RATIO  - s_transit_time[OPERAND_WIDTH-1:4];
        o_end_offset        <= CLOCK_RATIO  - s_transit_time[OPERAND_WIDTH-1:4]; 
        o_iterations        <= NUM_ITERATIONS;
        o_min_pulse         <= s_hit_pulse_width;
        o_max_pulse         <= s_hit_pulse_width;
      end
  endcase
end

//---------------------------------------------------------------------------
// Paramters for coarse finding of position
//---------------------------------------------------------------------------
always @(posedge i_clk_mon) begin
  if(i_end_pulse && present_state == RECALIBRATE) begin
    if(i_hit_tx_offset[15:0] == 1)
      s_hit_tx_offset      <= {i_hit_tx_offset[16:0], 3'b000};
    else
      s_hit_tx_offset      <= {i_hit_tx_offset[16:0] - 1 , 3'b000};

    s_hit_pulse_width    <= i_hit_pulse_width;

  end

  if(present_state == FE_CALIB && i_end_pulse && i_hit_valid && 
            i_hit_iterations == NUM_ITERATIONS)
    s_transit_time       <= {{{i_hit_rx_offset[16:0], 3'b000} - 
                            {i_hit_tx_offset[16:0], 3'b000}} + 4'b1000}; 

end

always @(posedge i_clk_mon) begin
  s_coarse_shift_vco      <= s_hit_tx_offset * s_VCO_SHIFT_PER_PULSE;
  s_fine_shift_vco        <= (s_transit_time >> 1) * s_VCO_SHIFT_PER_PULSE;  
end


//---------------------------------------------------------------------------
// Determines the shift to be provided during fine adjustment
//---------------------------------------------------------------------------
assign s_VCO_SHIFT_PER_PULSE = VCO_SHIFT_PER_PULSE;
assign s_VCO_SHIFT_FOUR_PULSE = s_VCO_SHIFT_PER_PULSE << 2;

`ifdef FPGA_SIM
  assign s_VCO_SHIFT_INCREMENT = {29'd0,3'b100}; //shift of 4 VCO clocks 
`else
  assign s_VCO_SHIFT_INCREMENT = {29'd0,3'b001}; //shift of 1/8 VCO clock
`endif

always @(posedge i_clk_mon)begin
 if(present_state ==  IDLE)
   s_VCO_SHIFT_counter <= '0;
 else
   if(present_state == FE_PSHIFT)
     if(~s_dps_in_prog && s_dps_in_prog_d1)
       s_VCO_SHIFT_counter <= s_VCO_SHIFT_counter + s_VCO_SHIFT_INCREMENT;
end

always @(posedge i_clk_mon)
  s_VCO_SHIFT_flag <= (s_VCO_SHIFT_counter == s_VCO_SHIFT_FOUR_PULSE) ? 1'b1 : 1'b0;

//---------------------------------------------------------------------------
// Finding the F0 & F1 points
//---------------------------------------------------------------------------
always @(posedge i_clk_mon) begin
  // flag indicates that f0 point has been detected
  if(present_state == IDLE)
    s_dps_f0_flag <= 1'b0;
  else
    if(present_state == FE_CALIB && i_end_pulse && i_hit_valid && i_hit_iterations == NUM_ITERATIONS)
      s_dps_f0_flag <= 1'b1;

  // register the f0 point
  if(present_state == IDLE)
    s_dps_f0_point <= 'b0;
  else
    if(present_state == FE_CALIB && i_end_pulse && i_hit_valid && 
            i_hit_iterations == NUM_ITERATIONS && ~s_dps_f0_flag)
      s_dps_f0_point <= s_VCO_SHIFT_counter;

  // register the f1 point that gets updated always
  if(present_state == IDLE)
    s_dps_f1_point <= 'b0;
  else
    if(present_state == FE_CALIB && i_end_pulse && i_hit_valid && 
            i_hit_iterations == NUM_ITERATIONS)
      s_dps_f1_point <= s_VCO_SHIFT_counter;

  // mid point of f0 and f1
  s_dps_f0f1_point_diff <= (s_dps_f1_point - s_dps_f0_point);
end

assign o_dps_f0f1_point_diff = s_dps_f0f1_point_diff;
assign s_dps_f0f1_point = s_dps_f0_point + (s_dps_f0f1_point_diff  >> 1);

//---------------------------------------------------------------------------
// Parameters to program the DPS
//---------------------------------------------------------------------------
always @(posedge i_clk_mon) begin
  case(present_state)
    IDLE,PROGRAM_CAL,CALIBRATE,REPROG_CAL,RECALIBRATE,PROG_DPS_1 :
      begin
        s_dps_trig <= 1'b0;
        s_dps_updn <= 1'b0;
        s_dps_num_shifts <= 'b0;
      end
    PROG_DPS_2 :
      begin
        s_dps_trig <= 1'b1;
        s_dps_updn <= 1'b1;
        s_dps_num_shifts <= s_coarse_shift_vco[34:3];
      end
    PHASE_SHIFT :
      begin
        s_dps_trig <= 1'b0;
        s_dps_updn <= 1'b1;
        s_dps_num_shifts <= s_coarse_shift_vco[34:3];
      end
    FE_BEGIN,FE_CALIB :
      begin
        s_dps_trig <= 1'b0;
        s_dps_updn <= 1'b1;
        s_dps_num_shifts <= 'b0;
      end
    FE_CHECK :
      if(s_VCO_SHIFT_flag)
        begin
          s_dps_trig       <= 1'b1;
          s_dps_updn       <= 1'b0;
          s_dps_num_shifts <= s_VCO_SHIFT_counter;
        end
      else
        begin
          s_dps_trig       <= 1'b1;
          s_dps_updn       <= 1'b1;
          s_dps_num_shifts <= s_VCO_SHIFT_INCREMENT;
        end
    FE_PSHIFT :
      begin
        s_dps_trig <= 1'b0;
        s_dps_updn <= 1'b1;
        s_dps_num_shifts <= s_VCO_SHIFT_INCREMENT;
      end
    FE_SHIFT_BACK :
      if(~s_dps_in_prog && s_dps_in_prog_d1)
        begin
          s_dps_trig <= 1'b1;
          s_dps_updn <= 1'b1;
          s_dps_num_shifts <= s_dps_f0f1_point + s_fine_shift_vco[34:3];
        end
      else
        begin
          s_dps_trig <= 1'b0;
          s_dps_updn <= 1'b0;
          s_dps_num_shifts <= s_VCO_SHIFT_counter;
        end
    FE_SHIFT_MID :
      begin
        s_dps_trig <= 1'b0;
        s_dps_updn <= 1'b1;
        s_dps_num_shifts <= s_dps_f0f1_point + s_fine_shift_vco[34:3];
      end
    FE_CAL_CHK, FE_CAL_CHK_W :
      begin
        s_dps_trig       <= 1'b0;
        s_dps_updn       <= 1'b0;
        s_dps_num_shifts <= 'b0;
      end
  endcase
end

always @(posedge i_clk_mon) begin
  s_dps_in_prog_d1 <= s_dps_in_prog;
end

always @(posedge i_clk_mon) begin
 o_rst_clk_sync_n <= ~s_dps_in_prog; 
end
//---------------------------------------------------------------------------
//
//---------------------------------------------------------------------------
always @(posedge i_clk_mon) begin
  if(present_state == IDLE)
    o_calibration_success <= 1'b0;
  else
    if(present_state == FE_CAL_CHK)
      o_calibration_success <= 1'b1;
end

always @(posedge i_clk_mon) begin
  if(present_state == FE_CAL_CHK_W && i_end_pulse  && i_hit_iterations != NUM_ITERATIONS)
    o_failure_detected <= 1'b1;
  else
    o_failure_detected <= 1'b0;
end

always @(posedge i_clk_mon) begin
    if (~i_rst_mon_n)
      o_failure_detected_cntr <= 32'd0;
    else if (o_failure_detected)
      o_failure_detected_cntr <= o_failure_detected_cntr + 1'b1;
    end
//---------------------------------------------------------------------------
// instantiation of DPS controller module
//---------------------------------------------------------------------------
IW_fpga_pll_dps_cntrl  #(
   .PHASE_EN_PULSE_W                  (2)
  ,.NUM_PLL_CLOCKS                    (NUM_PLL_CLOCKS)
  ,.WAIT_FOR_PHASE_DONE_EDGE_N_LEVEL  (1)
  ,.MC_FAST_CLK_SHIFT                 (MC_FAST_CLK_SHIFT)
) u_IW_fpga_pll_dps_cntrl (
   .clk                               (i_clk_mon)
  ,.rst_n                             (i_rst_mon_n)

  ,.dps_trig                          (s_dps_trig)
  ,.dps_updn                          (s_dps_updn)
  ,.dps_num_shifts                    (s_dps_num_shifts)
  ,.dps_clk_tap                       (s_dps_clk_tap)
  ,.dps_in_prog                       (s_dps_in_prog)

  ,.dps_fsm_pstate                    ()
  ,.pll_updn                          (o_pll_updn)
  ,.pll_cnt_sel                       (o_pll_cnt_sel)
  ,.pll_phase_en                      (o_pll_phase_en)
  ,.pll_phase_done                    (i_pll_phase_done)
  ,.pll_out_shift                     (pll_out_shift)
);

//----------------------------------------------------------------------
//-Validation of all parameters
//----------------------------------------------------------------------
if(END_OFFSET_POSITION < START_OFFSET_POSITION )
  $error($sformatf("END_OFFSET_POSITION cannot be smaller than START_OFFSET_POSITION = %0d , %0d", END_OFFSET_POSITION, START_OFFSET_POSITION));

if(MIN_PULSE_WIDTH < 1)
  $error($sformatf("MIN_PULSE_WIDTH should be 1 or greater; current value = %0d", MIN_PULSE_WIDTH));

if(MAX_PULSE_WIDTH < MIN_PULSE_WIDTH)
  $error($sformatf("MAX_PULSE_WIDTH should be greater than MIN_PULSE_WIDTH = %0d , %0d ", MAX_PULSE_WIDTH, MIN_PULSE_WIDTH));

if(NUM_ITERATIONS < 1)
  $error($sformatf("NUM_ITERATIONS should be greater than 0 = %0d ", NUM_ITERATIONS));

if(CLOCK_RATIO < 8)
  $error($sformatf("CLOCK_RATIO value appears to be too small = %0d ", CLOCK_RATIO));

if(VCO_SHIFT_PER_PULSE < 16)
  $error($sformatf("VCO_SHIFT_PER_PULSE value appears to be too small = %0d ", VCO_SHIFT_PER_PULSE));

endmodule // <module_name>
