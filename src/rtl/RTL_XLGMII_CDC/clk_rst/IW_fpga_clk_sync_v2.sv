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
 -- Module Name       : IW_fpga_clk_sync_v2
 -- Author            : Vikas Akalwadi
 -- Associated modules: 
 -- Function          : 
 --------------------------------------------------------------------------
*/

`timescale 1ns / 10ps

module IW_fpga_clk_sync_v2 #(
    parameter INSTANCE_NAME          = "IW_fpga_clk_sync_v2"
   ,parameter MASTER_MODULE          = 0
   ,parameter PARAM_WIDTH            = 32
   ,parameter START_OFFSET_POSITION  = 0
   ,parameter END_OFFSET_POSITION    = 8
   ,parameter NUM_ITERATIONS         = 3
   ,parameter MIN_PULSE_WIDTH        = 1
   ,parameter MAX_PULSE_WIDTH        = 1
   ,parameter NUM_PLL_CLOCKS         = 1
  , parameter VCO_SHIFT_PER_PULSE    = 4.5*8 //4.5 clocks for 900 MHz / 200 MHz : 2.5 MHz
                                           //6 clocks for 1200 MHz / 200 MHz : 4 MHz
  , parameter CLOCK_RATIO            = 80    // 80, 200/2.5
                                           // 50, 200/4
   ,parameter UPSTREAM_WIDTH       = 1
   ,parameter GAL_CNTR_W           = 16
   ,parameter GAL_LOGIC_TAP        = 0
   ,parameter NUM_CLOCKS           = 1
   ,parameter USYNC_GAL_OFFSET     = 3 //Number of cycles before GAL point to generate usync pulse  
   ,parameter EDGE_DET_CNTR_W     = 8
   ,parameter GAL_FREQ_DIV        = 1
   ,parameter CLK_LOGIC_DIV_VALUE = 1 // GAL window redefined with subset of divider value of clock GAL_LOGIC_TAP
   ,parameter GAL_CNT_OUT_BUFFER  = 0
   ,parameter MC_FAST_CLK_SHIFT   = 0 //0->Shift by 1 (supported by gal sync)
                                       //1->Shift by 4 to make simulation fast (supported by MC clk sync)
) (
   input  logic                                         i_clk_mon
  ,input  logic                                         i_rst_mon_n

  ,input  logic                                         i_clk_slow
  ,input  logic                                         i_clk_fast
  ,input  logic                                         i_rst_n

  ,inout  wire                                          o_downstream_tx
  ,inout  wire                                          i_downstream_rx

  ,inout  wire [UPSTREAM_WIDTH-1:0]                     i_upstream_rx
  ,inout  wire [UPSTREAM_WIDTH-1:0]                     o_upstream_tx

  ,input  logic  [NUM_PLL_CLOCKS-1:0] [4:0]             i_dps_clk_tap
  ,output logic                                         o_pll_phase_en
  ,output logic                                         o_pll_updn
  ,output logic  [4:0]                                  o_pll_cnt_sel
  ,input  logic                                         i_pll_phase_done
  ,input  logic                                         gal_sync_lock 
  ,input  logic  [NUM_CLOCKS-1:0]                       clk_logic_vec 
  ,input  logic  [NUM_CLOCKS-1:0]                       i_rst_logic_vec_n 
  ,input  logic                                         rst_fast_n 
  ,input  logic                                         pin_rst_n 
  ,input  logic                                         all_clk_sync_lock 

  ,output logic [9:0]                                   o_master_calibrate_fsm
  ,output logic [4:0]                                   o_tx_calibrate_fsm
  ,output logic [PARAM_WIDTH-1:0]                       o_hit_tx_offset
  ,output logic [PARAM_WIDTH-1:0]                       o_hit_rx_offset
  ,output logic [PARAM_WIDTH-1:0]                       o_hit_iterations
  ,output logic [PARAM_WIDTH-1:0]                       o_hit_pulse_width
  ,output logic                                         o_cal_success 
  ,output logic                                         o_failure_detected
  ,output logic [PARAM_WIDTH-1:0]                       o_dps_f0f1_point_diff 
  ,output logic [PARAM_WIDTH-1:0]                       o_failure_detected_cntr 
  ,output logic                                         o_rst_clk_sync_n
  ,output  wire  [2:0]                                  pll_out_shift

);

logic                                                   s_start_pulse;
logic [PARAM_WIDTH-1:0]                                 s_start_offset;
logic [PARAM_WIDTH-1:0]                                 s_end_offset;
logic [PARAM_WIDTH-1:0]                                 s_iterations;
logic [PARAM_WIDTH-1:0]                                 s_min_pulse;
logic [PARAM_WIDTH-1:0]                                 s_max_pulse;
logic [1:0]                                             s_tx_pulse;
logic [1:0]                                             s_rx_pulse;
logic [1:0]                                             s_rx_pulse_d1;
logic                                                   s_end_pulse;
logic                                                   s_hit_valid;
logic [PARAM_WIDTH-1:0]                                 s_hit_tx_offset;
logic [PARAM_WIDTH-1:0]                                 s_hit_rx_offset;
logic [PARAM_WIDTH-1:0]                                 s_hit_iterations;
logic [PARAM_WIDTH-1:0]                                 s_hit_pulse_width;
logic [1:0] [UPSTREAM_WIDTH-1:0]                        s_upstream_rx;
logic [1:0] [UPSTREAM_WIDTH-1:0]                        s_upstream_rx_d1;

logic                                                   s_cal_success;
bit                                                     s_start_pulse_sync;
bit                                                     s_end_pulse_sync;
bit                                                     s_hit_valid_sync;
logic                                                   s_cal_success_sync;
logic                                                   s_gal_sync_lock_sync;
logic                                                   s_failure_detected;
logic [PARAM_WIDTH-1:0]                                 s_hit_tx_offset_sync;
logic [PARAM_WIDTH-1:0]                                 s_hit_rx_offset_sync;
logic [PARAM_WIDTH-1:0]                                 s_hit_iterations_sync;
logic [PARAM_WIDTH-1:0]                                 s_hit_pulse_width_sync;
logic [PARAM_WIDTH-1:0]                                 s_start_offset_sync;
logic [PARAM_WIDTH-1:0]                                 s_end_offset_sync;
logic [PARAM_WIDTH-1:0]                                 s_iterations_sync;
logic [PARAM_WIDTH-1:0]                                 s_min_pulse_sync;
logic [PARAM_WIDTH-1:0]                                 s_max_pulse_sync;
logic [NUM_CLOCKS-1:0] [GAL_CNTR_W-1:0]                 clk_logic_gal_cntr;
logic [NUM_CLOCKS-1:0] [GAL_CNTR_W-1:0]                 clk_logic_gal_start_val;
logic                                                   clk_en;
logic [NUM_CLOCKS-1:0]                                  gal_usync_vec;
logic [NUM_CLOCKS-1:0]                                  gal_usync_vec_int;
logic                                                   rst_gal_usync_vec_n;
logic                                                   gal_usync_align_point;
logic [NUM_CLOCKS-1:0]                                  gal_usync_vec_sync;
logic                                                   rst_usync_logic_n;

bit                                                     s_slow_clock_rise;
bit                                                     s_slow_clock_fall;
bit                                                     s_slow_clock_sig;
bit                                                     s_slow_clock_sig_d1;
bit                                                     s_slow_clock_sig_redge;

//--------------------------------------------------------------------------------
// instantiation of Master calibration module
//--------------------------------------------------------------------------------
generate
if(MASTER_MODULE) begin : master_calibrate
  assign s_start_pulse = 0;
  assign s_start_offset = 0;
  assign s_end_offset = 0;
  assign s_iterations = 0;
  assign s_min_pulse = 0;
  assign s_max_pulse = 0;
  assign s_cal_success = 1'b1;
  assign s_failure_detected = 1'b0;
  assign o_pll_updn = 0;
  assign o_pll_cnt_sel = 0;
  assign o_pll_phase_en = 0;
  assign o_master_calibrate_fsm = 10'b1000000000;
  assign o_dps_f0f1_point_diff = 0;
  assign o_failure_detected_cntr = 0;

end else begin
  IW_master_calibrate #(
     .INSTANCE_NAME                 (INSTANCE_NAME        ) 
    ,.PARAM_WIDTH                   (PARAM_WIDTH          ) 
    ,.START_OFFSET_POSITION         (START_OFFSET_POSITION) 
    ,.END_OFFSET_POSITION           (END_OFFSET_POSITION  ) 
    ,.NUM_ITERATIONS                (NUM_ITERATIONS       ) 
    ,.MIN_PULSE_WIDTH               (MIN_PULSE_WIDTH      ) 
    ,.MAX_PULSE_WIDTH               (MAX_PULSE_WIDTH      ) 
    ,.NUM_PLL_CLOCKS                (NUM_PLL_CLOCKS       ) 
    ,.CLOCK_RATIO                   (CLOCK_RATIO          )
    ,.VCO_SHIFT_PER_PULSE           (VCO_SHIFT_PER_PULSE  ) 
    ,.MC_FAST_CLK_SHIFT             (MC_FAST_CLK_SHIFT    ) 
  ) u_IW_master_calibrate (
     .i_clk_mon                      (i_clk_mon              )
    ,.i_rst_mon_n                    (i_rst_mon_n            )
    ,.o_start_pulse                  (s_start_pulse          )
    ,.o_start_offset                 (s_start_offset         )
    ,.o_end_offset                   (s_end_offset           )
    ,.o_iterations                   (s_iterations           )
    ,.o_min_pulse                    (s_min_pulse            )
    ,.o_max_pulse                    (s_max_pulse            )
    ,.o_rst_clk_sync_n               (o_rst_clk_sync_n       )
    ,.i_end_pulse                    (s_end_pulse_sync       )
    ,.i_hit_valid                    (s_hit_valid_sync       )
    ,.i_hit_tx_offset                (s_hit_tx_offset_sync   )
    ,.i_hit_rx_offset                (s_hit_rx_offset_sync   )
    ,.i_hit_iterations               (s_hit_iterations_sync  )
    ,.i_hit_pulse_width              (s_hit_pulse_width_sync )
    ,.i_dps_clk_tap                  (i_dps_clk_tap          )
    ,.o_calibration_success          (s_cal_success          )
    ,.o_failure_detected             (s_failure_detected     )
    ,.o_pll_updn                     (o_pll_updn             )
    ,.o_pll_cnt_sel                  (o_pll_cnt_sel          )
    ,.o_pll_phase_en                 (o_pll_phase_en         )
    ,.i_pll_phase_done               (i_pll_phase_done       )
    ,.o_master_calibrate_fsm         (o_master_calibrate_fsm )
    ,.o_dps_f0f1_point_diff          (o_dps_f0f1_point_diff  )
    ,.o_failure_detected_cntr        (o_failure_detected_cntr)
    ,.pll_out_shift                  (pll_out_shift          )
  );
end //generate
endgenerate

assign o_hit_tx_offset   = s_hit_tx_offset;
assign o_hit_rx_offset   = s_hit_rx_offset;
assign o_hit_iterations  = s_hit_iterations;
assign o_hit_pulse_width = s_hit_pulse_width;
assign o_cal_success     = s_cal_success;
assign o_failure_detected = s_failure_detected;

generate 
if (MASTER_MODULE) begin : tx_calibrate
  assign s_tx_pulse                = 1'b0;
  assign s_end_pulse               = 1'b0;
  assign s_hit_valid               = 1'b0;
  assign s_hit_tx_offset           = 0;
  assign s_hit_rx_offset           = 0;
  assign s_hit_iterations          = 0;
  assign s_hit_pulse_width         = 0;
  assign o_tx_calibrate_fsm        = 5'b10000;
end else begin
  IW_tx_calibrate #(
     .INSTANCE_NAME                  ("IW_tx_calibrate" )
    ,.PARAM_WIDTH                    (PARAM_WIDTH       )
    ,.GAL_CNTR_W                     (GAL_CNTR_W        )
  ) u_IW_tx_calibrate (
     .i_clk_slow                     (i_clk_slow            )
    ,.i_clk_fast                     (i_clk_fast            )
    ,.i_rst_n                        (i_rst_n               )
    ,.i_start_pulse                  (s_start_pulse_sync    )
    ,.i_start_offset                 (s_start_offset_sync   )
    ,.i_end_offset                   (s_end_offset_sync     )
    ,.i_iterations                   (s_iterations_sync     )
    ,.i_min_pulse                    (s_min_pulse_sync      )
    ,.i_max_pulse                    (s_max_pulse_sync      )
    ,.i_gal_usync_align_point        (gal_usync_align_point )
    ,.o_tx_pulse                     (s_tx_pulse            )
    ,.i_rx_pulse                     (s_rx_pulse_d1         )
    ,.o_end_pulse                    (s_end_pulse           )
    ,.o_hit_valid                    (s_hit_valid           )
    ,.o_hit_tx_offset                (s_hit_tx_offset       )
    ,.o_hit_rx_offset                (s_hit_rx_offset       )
    ,.o_hit_iterations               (s_hit_iterations      )
    ,.o_hit_pulse_width              (s_hit_pulse_width     )
    ,.o_tx_calibrate_fsm             (o_tx_calibrate_fsm    )
  );
  bit s_downstream_tx;
  always_ff @(posedge i_clk_fast) begin
    s_downstream_tx <= s_tx_pulse[0];
    s_rx_pulse[0] <= i_downstream_rx;
    s_rx_pulse[1] <= i_downstream_rx;
    s_rx_pulse_d1 <= s_rx_pulse;
  end
  assign o_downstream_tx = s_downstream_tx;

 /*  Instantiate GAL detection module  */
  IW_fpga_usync_gen #(
     .NUM_CLOCKS        (NUM_CLOCKS           )
    ,.USYNC_GAL_OFFSET  (USYNC_GAL_OFFSET     )
    ,.GAL_LOGIC_TAP     (GAL_LOGIC_TAP        )
    ,.EDGE_DET_CNTR_W   (EDGE_DET_CNTR_W      )
    ,.GAL_CNTR_W        (GAL_CNTR_W           )
    ,.GAL_FREQ_DIV      (GAL_FREQ_DIV         )
    ,.CLK_LOGIC_DIV_VALUE(CLK_LOGIC_DIV_VALUE )

  ) u_IW_fpga_usync_gen (

     .clk_fast                (i_clk_fast              )
    ,.rst_fast_n              (i_rst_n                 )

    ,.clk_logic_vec           (clk_logic_vec           )
    ,.rst_logic_vec_n         (i_rst_logic_vec_n       )
    ,.clk_en                  (clk_en                  )

    ,.usync_vec               (gal_usync_vec           )

    ,.clk_logic_gal_cntr      (clk_logic_gal_cntr      )
    ,.clk_logic_gal_start_val (clk_logic_gal_start_val )

  );

  genvar i;
  for(i=0;i<NUM_CLOCKS;i++)
  begin : gal_usync_int
    assign gal_usync_vec_int[i] = (i==GAL_LOGIC_TAP) ? clk_en : gal_usync_vec[i];
  end

  IW_sync_reset u_sync_rst_usync_logic_n (
     .clk        (i_clk_fast                   )
    ,.rst_n      (all_clk_sync_lock & pin_rst_n)
    ,.rst_n_sync (rst_usync_logic_n            )
  );

  IW_fpga_double_sync #(
     .WIDTH      (NUM_CLOCKS)
    ,.NUM_STAGES (2)
  ) u_IW_double_sync_gal_vec (
     .clk     (i_clk_fast         )
    ,.sig_in  (gal_usync_vec_int  )
    ,.sig_out (gal_usync_vec_sync )
  );

  always_ff @(posedge i_clk_fast or negedge rst_usync_logic_n) begin
    if ( !rst_usync_logic_n ) begin
      gal_usync_align_point    <= 1'b0;
    end
    else begin
      //always_ff @(posedge i_clk_fast ) begin
      gal_usync_align_point   <= (&gal_usync_vec_sync);
    end 
  end
end
endgenerate


//--------------------------------------------------------------------------------
// Synchronization of pulses and static signals
//--------------------------------------------------------------------------------
IW_fpga_double_sync  #(
   .WIDTH                         ( 1                 )
  ,.NUM_STAGES                    ( 2                 )
) u_s_cal_success_sync (
   .clk                           (i_clk_fast         )
  ,.sig_in                        (s_cal_success      )
  ,.sig_out                       (s_cal_success_sync )
);

IW_fpga_double_sync  #(
   .WIDTH                         ( 1                   )
  ,.NUM_STAGES                    ( 2                   )
) u_s_gal_success_sync (
   .clk                           (i_clk_fast           )
  ,.sig_in                        (gal_sync_lock        )
  ,.sig_out                       (s_gal_sync_lock_sync )
);

bit s_start_pulse_exp;
bit s_start_pulse_exp_sync;
bit s_start_pulse_exp_sync_d1;
always_ff @(posedge i_clk_mon) s_start_pulse_exp <= s_start_pulse ^ s_start_pulse_exp;

IW_fpga_double_sync  #(
   .WIDTH                         ( 1                     )
  ,.NUM_STAGES                    ( 4                     )
) u_s_start_pulse_sync (
   .clk                           (i_clk_fast             )
  ,.sig_in                        (s_start_pulse_exp      )
  ,.sig_out                       (s_start_pulse_exp_sync )
);
always_ff @(posedge i_clk_fast) begin
  if(~i_rst_n) begin
    s_start_pulse_exp_sync_d1 <= 1'b0;
  end else begin
    s_start_pulse_exp_sync_d1 <= s_start_pulse_exp_sync;
  end
end

always_ff @(posedge i_clk_fast) begin
  if(~i_rst_n) begin
    s_start_pulse_sync <= 1'b0;
  end else begin
    s_start_pulse_sync <= s_start_pulse_exp_sync ^ s_start_pulse_exp_sync_d1;
  end
end

bit s_end_pulse_exp;
bit s_end_pulse_exp_sync;
bit s_end_pulse_exp_sync_d1;
always_ff @(posedge i_clk_fast) s_end_pulse_exp <= s_end_pulse_exp ^ s_end_pulse;

IW_fpga_double_sync  #(
   .WIDTH                         ( 1                     )
  ,.NUM_STAGES                    ( 4                     )
) u_s_end_pulse_sync (
   .clk                           (i_clk_mon              )
  ,.sig_in                        (s_end_pulse_exp        )
  ,.sig_out                       (s_end_pulse_exp_sync   )
);
always_ff @(posedge i_clk_mon) s_end_pulse_exp_sync_d1 <= s_end_pulse_exp_sync;
always_ff @(posedge i_clk_mon) s_end_pulse_sync <= s_end_pulse_exp_sync ^ s_end_pulse_exp_sync_d1;

IW_fpga_double_sync  #(
   .WIDTH                         ( $bits(s_hit_valid )   )
  ,.NUM_STAGES                    ( 2                     )
) u_s_hit_valid_sync (
   .clk                           (i_clk_mon              )
  ,.sig_in                        (s_hit_valid            )
  ,.sig_out                       (s_hit_valid_sync       )
);

IW_fpga_double_sync  #(
   .WIDTH                         ( $bits(s_hit_tx_offset))
  ,.NUM_STAGES                    ( 2                     )
) u_s_hit_tx_offset (
   .clk                           (i_clk_mon              )
  ,.sig_in                        (s_hit_tx_offset        )
  ,.sig_out                       (s_hit_tx_offset_sync   )
);

IW_fpga_double_sync  #(
   .WIDTH                         ( $bits(s_hit_rx_offset))
  ,.NUM_STAGES                    ( 2                     )
) u_s_hit_rx_offset (
   .clk                           (i_clk_mon              )
  ,.sig_in                        (s_hit_rx_offset        )
  ,.sig_out                       (s_hit_rx_offset_sync   )
);

IW_fpga_double_sync  #(
   .WIDTH                         ( $bits(s_hit_iterations))
  ,.NUM_STAGES                    ( 2                     )
) u_s_hit_iterations (
   .clk                           (i_clk_mon              )
  ,.sig_in                        (s_hit_iterations       )
  ,.sig_out                       (s_hit_iterations_sync  )
);

IW_fpga_double_sync  #(
   .WIDTH                         ($bits(s_hit_pulse_width))
  ,.NUM_STAGES                    ( 2                     )
) u_s_hit_pulse_width (
   .clk                           (i_clk_mon              )
  ,.sig_in                        (s_hit_pulse_width      )
  ,.sig_out                       (s_hit_pulse_width_sync )
);

IW_fpga_double_sync  #(
   .WIDTH                         ($bits(s_start_offset))
  ,.NUM_STAGES                    ( 2                    )
) u_s_start_offset (
   .clk                           (i_clk_fast            )
  ,.sig_in                        (s_start_offset        )
  ,.sig_out                       (s_start_offset_sync   )
);

IW_fpga_double_sync  #(
   .WIDTH                         ($bits(s_end_offset))
  ,.NUM_STAGES                    ( 2                 )
) u_s_end_offset (
   .clk                           (i_clk_fast         )
  ,.sig_in                        (s_end_offset       )
  ,.sig_out                       (s_end_offset_sync  )
);

IW_fpga_double_sync  #(
   .WIDTH                         ($bits(s_iterations))
  ,.NUM_STAGES                    ( 2                 )
) u_s_iterations(
   .clk                           (i_clk_fast         )
  ,.sig_in                        (s_iterations       )
  ,.sig_out                       (s_iterations_sync  )
);

IW_fpga_double_sync  #(
   .WIDTH                         ($bits(s_min_pulse) )
  ,.NUM_STAGES                    ( 2                 )
) u_s_min_pulse (
   .clk                           (i_clk_fast         )
  ,.sig_in                        (s_min_pulse        )
  ,.sig_out                       (s_min_pulse_sync   )
);

IW_fpga_double_sync  #(
   .WIDTH                         ($bits(s_max_pulse) )
  ,.NUM_STAGES                    ( 2                 )
) u_s_max_pulse (
   .clk                           (i_clk_fast         )
  ,.sig_in                        (s_max_pulse        )
  ,.sig_out                       (s_max_pulse_sync   )
);

//--------------------------------------------------------------------------------
// Reconstruction of the slow clock signal
//--------------------------------------------------------------------------------
always_ff @(posedge i_clk_slow) s_slow_clock_rise <= ~s_slow_clock_rise;
always_ff @(negedge i_clk_slow) s_slow_clock_fall <= s_slow_clock_rise;
  assign s_slow_clock_sig = s_slow_clock_rise ^ s_slow_clock_fall;
always_ff @(posedge i_clk_fast) s_slow_clock_sig_d1 <= s_slow_clock_sig;
  assign s_slow_clock_sig_redge = s_slow_clock_sig & ~s_slow_clock_sig_d1;
//--------------------------------------------------------------------------------
//
//--------------------------------------------------------------------------------
genvar idx;
bit [UPSTREAM_WIDTH-1:0] s_upstream_tx;

generate
for(idx=0;idx<UPSTREAM_WIDTH;idx++) begin : gen_reflect
  always_ff @(posedge i_clk_fast) begin
    s_upstream_rx[0][idx] <= i_upstream_rx[idx];
    s_upstream_rx[1][idx] <= i_upstream_rx[idx];
    
    s_upstream_rx_d1[0][idx] <= s_upstream_rx[0][idx];
    s_upstream_rx_d1[1][idx] <= s_upstream_rx[1][idx];
  end

  always_ff @(posedge i_clk_fast, negedge i_rst_n) begin
    if(~i_rst_n)
      s_upstream_tx[idx] <= 1'b0;
    else begin
      if(s_upstream_rx_d1[0][idx] & s_cal_success_sync & s_slow_clock_sig_redge)
      //if(s_upstream_rx_d1[0][idx] & s_gal_sync_lock_sync  & s_slow_clock_sig_redge)
        s_upstream_tx[idx] <= 1'b1;
      else
        if(~s_upstream_rx_d1[0][idx])
          s_upstream_tx[idx] <= 1'b0;
    end
  end
  if (GAL_CNT_OUT_BUFFER) begin
    genvar idx;
    for(idx=0;idx<UPSTREAM_WIDTH;idx++)
    begin:gen_upstream_tieoff
      IOBUF iobuf_mc_ds_sync_out_io  (.O(),.T(1'b0),.I(1'b0),.IO(o_upstream_tx[idx])); //Tieoff
    end
  end
  else begin
    assign o_upstream_tx[idx] = s_upstream_tx[idx];  
  end
end
endgenerate

endmodule // <module_name>
