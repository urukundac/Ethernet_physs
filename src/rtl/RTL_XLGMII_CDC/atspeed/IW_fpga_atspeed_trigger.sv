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

`timescale 1ns/10ps

module IW_fpga_atspeed_trigger #(
   parameter INSTANCE_NAME            = "atspeed_trigger"
  ,parameter EN_TIME_MASTER           = 0
  ,parameter USE_FLOP                 = 0
  ,parameter TRIGGER_SIGNAL_WIDTH     = 32
  ,parameter Q_IDX                    = 0
  ,parameter DEBOUNCE_STAGES          = 3
  ,parameter NUM_FILT                 = 4
  ,parameter READ_MISS_VAL            = 32'hDEADBABE
  ,parameter INFRA_AVST_CHNNL_W       = 8
  ,parameter INFRA_AVST_DATA_W        = 8
  ,parameter INFRA_AVST_CHNNL_ID      = 8
  ,parameter CSR_ADDR_WIDTH           = 3*INFRA_AVST_DATA_W
  ,parameter CSR_DATA_WIDTH           = 4*INFRA_AVST_DATA_W
) (
  /* clk reset and enable  */
   input  logic                                  clk_atspeed
  ,input  logic                                  i_rst_n
  

  //input & output for trigger block
  ,inout                                         io_ext_trig
  ,input   logic   [TRIGGER_SIGNAL_WIDTH-1:0]    i_data_sample
  ,input   logic                                 i_logic_trigger
  ,output  logic                                 o_capture_trigger

  // Infra-Avst Ports
  ,input  logic                                  clk_avst
  ,input  logic                                  rst_avst_n
  ,output logic                                  avst_ingr_ready
  ,input  logic                                  avst_ingr_valid
  ,input  logic                                  avst_ingr_startofpacket
  ,input  logic                                  avst_ingr_endofpacket
  ,input  logic     [INFRA_AVST_CHNNL_W-1:0]     avst_ingr_channel
  ,input  logic     [INFRA_AVST_DATA_W-1:0]      avst_ingr_data

  ,input  logic                                  avst_egr_ready
  ,output logic                                  avst_egr_valid
  ,output logic                                  avst_egr_startofpacket
  ,output logic                                  avst_egr_endofpacket
  ,output logic     [INFRA_AVST_CHNNL_W-1:0]     avst_egr_channel
  ,output logic     [INFRA_AVST_DATA_W-1:0]      avst_egr_data

);

  localparam                                     NUM_STAGES_SYN = 2;

  logic                                          ext_trig_in;
  logic                                          ext_trig_out;
  logic                                          trig_drive_enable;
  logic                                          ext_trig_in_sync;
  logic                                          ext_trig_in_plus;
  logic                                          ext_trig_in_plus_d1;

  logic   [TRIGGER_SIGNAL_WIDTH-1:0]             s_data_sample_sync;
  logic   [TRIGGER_SIGNAL_WIDTH-1:0]             s_data_sample_debounce;
  logic                                          s_data_sample_valid;
  
  logic   [NUM_FILT-1:0] [31:0]                  s_match_mask;
  logic   [NUM_FILT-1:0] [31:0]                  s_match_value;
  logic   [NUM_FILT-1:0] [31:0]                  s_mask_shift;
  logic   [NUM_FILT-1:0]                         s_filter_enable;
  logic                                          s_trigger_sel;
  logic                                          s_trigger_en;
  logic                                          capture_trig_sent;
  logic                                          ext_trig_rcvd;
  logic                                          match_trig_rcvd;
  logic                                          logic_trig_rcvd;
  logic                                          load_capture_trig_sent;
  logic                                          load_ext_trig_rcvd;
  logic                                          load_match_trig_rcvd;
  logic                                          load_logic_trig_rcvd;

  logic                                          s_logic_trigger;
  logic                                          s_filter_trigger;
  logic                                          s_int_trigger;
  logic                                          s_int_trigger_d1;
  
  /* CSR Interface */
  logic                                          clk_csr; 
  logic                                          rst_csr_n;
  logic                                          csr_write;
  logic                                          csr_read;
  logic             [(3*INFRA_AVST_CHNNL_W)-1:0] csr_addr;
  logic             [(4*INFRA_AVST_DATA_W)-1:0]  csr_wr_data;
  logic             [(4*INFRA_AVST_DATA_W)-1:0]  csr_rd_data;
  logic                                          csr_rd_valid;

  // synchronise the data to avoid metastability
  IW_fpga_double_sync #(
     .WIDTH             (TRIGGER_SIGNAL_WIDTH)
    ,.NUM_STAGES        (NUM_STAGES_SYN)
  ) synch_data(
    .clk                (clk_atspeed)
   ,.sig_in             (i_data_sample)
   ,.sig_out            (s_data_sample_sync)
  );

  //instance of debounce module to synchronize the sampled data
  IW_fpga_atspeed_debounce #(
     .WIDTH            (TRIGGER_SIGNAL_WIDTH)
    ,.NUM_STAGE        (DEBOUNCE_STAGES)
  ) uut_trig_data_debounce (
     .i_clock          (clk_atspeed)
    ,.i_data_in        (s_data_sample_sync)
    ,.o_data_out       (s_data_sample_debounce)
    ,.o_valid_pulse    ( )
    ,.o_valid          (s_data_sample_valid)
  );

  //instance of internal trigger generation
  IW_fpga_atspeed_filt #(
     .DATA_WIDTH       (TRIGGER_SIGNAL_WIDTH)
    ,.USE_FLOP         (USE_FLOP)
    ,.NUM_FILT         (NUM_FILT)
  ) inst_filt_0 (
    .clk               (clk_atspeed)
   ,.rst_n             (i_rst_n)
   ,.data_valid        (s_data_sample_valid)
   ,.filter_enable     (s_filter_enable)
   ,.match_mask        (s_match_mask)
   ,.match_value       (s_match_value)
   ,.mask_shift        (s_mask_shift)
   ,.data_in           (s_data_sample_debounce)
   ,.match_out         (s_filter_trigger)
  );

  // Instantiation of synchroniser module for avoiding meta stable condition at trigger port
  IW_fpga_double_sync #(
     .WIDTH             (1)
    ,.NUM_STAGES        (NUM_STAGES_SYN)
  ) synch(
    .clk                (clk_atspeed)
   ,.sig_in             (i_logic_trigger)
   ,.sig_out            (s_logic_trigger)
  );

  assign  s_int_trigger = s_trigger_sel ? s_logic_trigger : s_filter_trigger;

  always_ff @(posedge clk_atspeed)
    s_int_trigger_d1 <= s_int_trigger;
 
  assign  ext_trig_in = io_ext_trig;
  assign  io_ext_trig = trig_drive_enable ? ext_trig_out : 1'bZ;
  // Instantiation of synchroniser module for avoiding meta stable condition at trigger port
  IW_fpga_double_sync #(
     .WIDTH             (1)
    ,.NUM_STAGES        (NUM_STAGES_SYN)
  ) synch_ext_trig(
    .clk                (clk_atspeed)
   ,.sig_in             (ext_trig_in)
   ,.sig_out            (ext_trig_in_sync)
  );

  always_comb
    if(s_trigger_en & ~ext_trig_in_sync)
      ext_trig_in_plus <= 1'b1;
    else
      ext_trig_in_plus <= 1'b0;

  always_ff @(posedge clk_atspeed)
    ext_trig_in_plus_d1 <= ext_trig_in_plus;


  // State machine to detect the sequence. A master module drives the 
  // sync for timestamp
  enum logic [5:0]  {  stIdle       = 6'b000001
                      ,stPreTimer   = 6'b000010
                      ,stTimer      = 6'b000100
                      ,stWaitTrig   = 6'b001000
                      ,stTrigger    = 6'b010000
                      ,stNextTrig   = 6'b100000
                     } present_state;
 

bit [2:0] counter;

always_ff @(posedge clk_atspeed, negedge i_rst_n) begin
  if(!i_rst_n)
    present_state <= stIdle;
  else
    case(present_state)
      stIdle:
        present_state <= stPreTimer;
      stPreTimer:
        if(EN_TIME_MASTER == 1) begin
          if(counter == 3'b111)
            present_state <= stTimer;
        end else
          if(ext_trig_in_plus & ~ext_trig_in_plus_d1)
            present_state <= stWaitTrig;
      stTimer:
        if(counter == 3'b111)
          present_state <= stWaitTrig;
      stWaitTrig:
        if(s_int_trigger)
          present_state <= stTrigger;
        else if(ext_trig_in_plus & ~ext_trig_in_plus_d1)
          present_state <= stNextTrig;
      stTrigger :
        if(counter == 3'b111)
          present_state <= stNextTrig;
      stNextTrig:
         present_state <= stNextTrig;
      default:
        present_state <= stIdle;
    endcase
end

// Counter increments continously and provides provision to 
// create delays when needed.
always_ff @(posedge clk_atspeed)
  if(present_state == stPreTimer || present_state == stTrigger || present_state == stTimer)
    counter <= counter + 1'b1;
  else
    counter <= {default: 'b0};

always_ff @(posedge clk_atspeed) begin
  case(present_state)
    stIdle :
      trig_drive_enable <= 1'b0;
    stPreTimer:
      if(EN_TIME_MASTER == 1) begin
        trig_drive_enable <= 1'b1;
      end else begin
        trig_drive_enable <= 1'b0;
      end
    stTimer:
      trig_drive_enable <= 1'b0;
    stWaitTrig:
      trig_drive_enable <= 1'b0;
    stTrigger:
      trig_drive_enable <= 1'b1;
    stNextTrig:
      trig_drive_enable <= 1'b0;
    default:
      trig_drive_enable <= 1'b0;
  endcase 
end
assign ext_trig_out = 1'b0;

always_ff @(posedge clk_atspeed) begin
  case (present_state)
    stIdle     :
      o_capture_trigger <= 1'b0;
    stPreTimer :
      if(EN_TIME_MASTER == 1) begin
        if(counter == 3'b111)
          o_capture_trigger <= 1'b1;
        else
          o_capture_trigger <= 1'b0;
      end else begin
        if(ext_trig_in_plus & ~ext_trig_in_plus_d1)
          o_capture_trigger <= 1'b1;
        else
          o_capture_trigger <= 1'b0;
      end
    stTimer :
      o_capture_trigger <= 1'b0;
    stWaitTrig:
      if(s_int_trigger || (ext_trig_in_plus & ~ext_trig_in_plus_d1))
        o_capture_trigger <= 1'b1;
      else
        o_capture_trigger <= 1'b0;
    stTrigger :
      o_capture_trigger <= 1'b0;
    stNextTrig :
      o_capture_trigger <= 1'b0;
    default:
      o_capture_trigger <= 1'b0;
  endcase
end

// AVST2CSR instance

  // AVST2CSR instance
  assign clk_csr = clk_avst;
  assign rst_csr_n = rst_avst_n;

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
    ,.clk_csr               (clk_csr                 )
    ,.rst_csr_n             (rst_csr_n               )
    ,.csr_write             (csr_write               )
    ,.csr_read              (csr_read                )
    ,.csr_addr              (csr_addr                )
    ,.csr_wr_data           (csr_wr_data             )
    ,.csr_rd_data           (csr_rd_data             )
    ,.csr_rd_valid          (csr_rd_valid            )
   );

// CSR wrapper for trigger module
 IW_fpga_atspeed_trigger_addr_map_csr_wrapper #(
    .INSTANCE_NAME               (INSTANCE_NAME)
   ,.TRIGGER_SIGNAL_WIDTH        (TRIGGER_SIGNAL_WIDTH)
   ,.Q_IDX                       (Q_IDX)
   ,.DEBOUNCE_STAGES             (DEBOUNCE_STAGES)
   ,.NUM_FILT                    (NUM_FILT)
   ,.READ_MISS_VAL               (32'hDEADBABE)
   ,.CSR_ADDR_WIDTH              (CSR_ADDR_WIDTH)
   ,.CSR_DATA_WIDTH              (CSR_DATA_WIDTH)
 ) trigger_csr (
    .clk_atspeed                 (clk_atspeed)
   ,.trigger_enable              (s_trigger_en)
   ,.trigger_sel                 (s_trigger_sel)
   ,.filter_enable               (s_filter_enable)
   ,.match_mask                  (s_match_mask)
   ,.match_value                 (s_match_value)
   ,.mask_shift                  (s_mask_shift)
   ,.capture_trig_sent           (capture_trig_sent)
   ,.ext_trig_rcvd               (ext_trig_rcvd)
   ,.match_trig_rcvd             (match_trig_rcvd)
   ,.logic_trig_rcvd             (logic_trig_rcvd)
   ,.load_capture_trig_sent      (load_capture_trig_sent)
   ,.load_ext_trig_rcvd          (load_ext_trig_rcvd)
   ,.load_match_trig_rcvd        (load_match_trig_rcvd)
   ,.load_logic_trig_rcvd        (load_logic_trig_rcvd)
   ,.state_fsm                   (present_state)
   ,.clk_csr                     (clk_csr)
   ,.rst_csr_n                   (rst_csr_n)
   ,.csr_write                   (csr_write)
   ,.csr_read                    (csr_read)
   ,.csr_addr                    (csr_addr)
   ,.csr_wr_data                 (csr_wr_data)
   ,.csr_rd_data                 (csr_rd_data)
   ,.csr_rd_valid                (csr_rd_valid)
);

   assign capture_trig_sent         = o_capture_trigger;
   assign load_capture_trig_sent    = o_capture_trigger;
   assign ext_trig_rcvd             = ~ext_trig_in_sync;
   assign load_ext_trig_rcvd        = ~ext_trig_in_sync;
   assign match_trig_rcvd           = s_filter_trigger;
   assign load_match_trig_rcvd      = s_filter_trigger;
   assign logic_trig_rcvd           = s_logic_trigger;
   assign load_logic_trig_rcvd      = s_logic_trigger;

endmodule
