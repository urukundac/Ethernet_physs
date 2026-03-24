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

module IW_fpga_atspeed_capture #(
   parameter INSTANCE_NAME           = "atspeed_capture"         //Can hold upto 16 ASCII characters
  ,parameter CAPTURE_DATA_WIDTH      = 32                        //CAPTURE_DATA_WIDTH
  ,parameter DEBOUNCE_STAGE          = 4                         //DEBOUNCE_STAGE
  ,parameter T_STAMP_W               = 32 
  ,parameter CAPTURE_FIFO_DEPTH      = 64                        // CAPTURE_FIFO_DEPTH
  ,parameter Q_IDX                   = 0                         //Partition id for this monitor
  ,parameter AV_ST_DATA_W            = 8
  ,parameter AV_ST_SYMBOL_W          = 8
  ,parameter AV_ST_EMPTY_W           = (AV_ST_DATA_W <= AV_ST_SYMBOL_W) ? 1 
                                       : $clog2(AV_ST_DATA_W/AV_ST_SYMBOL_W)
  ,parameter INFRA_AVST_CHNNL_W      = 8
  ,parameter INFRA_AVST_DATA_W       = 8
  ,parameter INFRA_AVST_CHNNL_ID     = 8
  ,parameter CSR_ADDR_WIDTH          = 3*INFRA_AVST_DATA_W
  ,parameter CSR_DATA_WIDTH          = 4*INFRA_AVST_DATA_W

) (
   input  logic     [CAPTURE_DATA_WIDTH-1:0]     data_in
  ,input  logic                                  clk_atspeed
  ,input  logic                                  reset_n
  ,input  logic                                  trigger
  //Avalon-ST interface
  ,input  logic                                  avl_st_ready              
  ,output logic                                  avl_st_valid
  ,output logic                                  avl_st_startofpacket
  ,output logic                                  avl_st_endofpacket
  ,output logic     [AV_ST_EMPTY_W-1:0]          avl_st_empty
  ,output logic     [AV_ST_DATA_W-1:0]           avl_st_data
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


/* Internal Parameters */

  localparam        NUM_CAP_INTFS                                  = 1;
  localparam        int CHNL_Q_IDX_LIST     [NUM_CAP_INTFS-1:0]    = '{Q_IDX}; //queue index list for capture channel
  localparam        int CHNL_DATA_W_LIST    [NUM_CAP_INTFS-1:0]    = '{CAPTURE_DATA_WIDTH + T_STAMP_W + 32};
  localparam        NUM_STAGES_SYN                                 = 2;
  localparam        DROP_CNTR_WIDTH                                = 15;


  enum logic [2:0]  { IDLE=3'b001 
                     ,TIMESTAMP=3'b010
                     ,LOGDATA=3'b100
           } state;

  logic             [CAPTURE_DATA_WIDTH-1:0]                       data_in_sync;
  logic             [CAPTURE_DATA_WIDTH-1:0]                       data_in_debounce;
  logic             [CAPTURE_DATA_WIDTH-1:0]                       data_in_debounce_d1;
  logic                                                            trigger_d1;
  logic                                                            trigger_edge;
  logic                                                            capture_trigger;
  logic                                                            trigger_sw;
  logic                                                            valid_pulse_db;
  logic                                                            valid_pulse_db_s;
  logic                                                            valid_pulse_db_d1;
  logic             [CAPTURE_FIFO_DEPTH-1:0]                       fifo_occupancy;
  logic                                                            fifo_full;
  logic                                                            fifo_write;
  logic                                                            fifo_rd;
  logic             [32+CAPTURE_DATA_WIDTH+T_STAMP_W-1:0]          fifo_data;
  logic                                                            fifo_empty;
  logic                                                            capture_enable;
  logic                                                            clear_fifo;
  logic             [T_STAMP_W-1:0]                                t_stamp;                                
  logic             [T_STAMP_W-1:0]                                t_stamp_reg;                                
  logic             [T_STAMP_W  :0]                                t_stamp_diff;                                
  logic                                                            wr_fifo_pulse;
  logic             [32+CAPTURE_DATA_WIDTH+T_STAMP_W-1:0]          datain_to_fifo;                         
  logic             [32+T_STAMP_W-1:0]                             fifo_hdr_data;
  logic             [DROP_CNTR_WIDTH-1:0]                          count_dropped;                          
  logic             [7:0]                                          count_rcvd;                          
  logic                                                            chnl_cap_rden;

  logic                                                            clk_csr;
  logic                                                            reset_csr_n;
  logic                                                            csr_write;
  logic                                                            csr_read;
  logic             [(3*INFRA_AVST_CHNNL_W)-1:0]                   csr_addr;
  logic             [(4*INFRA_AVST_DATA_W)-1:0]                    csr_wr_data;
  logic             [(4*INFRA_AVST_DATA_W)-1:0]                    csr_rd_data;
  logic                                                            csr_rd_valid;

  logic                                                            capture_sticky;
  logic                                  [2:0]                     state_fsm;
  logic                                                            drop_sticky;
  logic                                                            load_capture;
  logic                                                            load_drop;

  logic             [T_STAMP_W-2:0]                                watch_dog_timer;
  logic                                                            watch_dog_pulse;

  logic             [15:0]                                         packet_count;
  logic             [ 7:0]                                         packet_length;
  logic             [ 7:0]                                         queue_index;


  // synchronise the data to avoid metastability
  IW_fpga_double_sync #(
     .WIDTH             (CAPTURE_DATA_WIDTH)
    ,.NUM_STAGES        (NUM_STAGES_SYN)
  ) synch(
    .clk                (clk_atspeed)
   ,.sig_in             (data_in)
   ,.sig_out            (data_in_sync)
  );

  // Instantiation of debounce circuit which is used to remove the glitches
  IW_fpga_atspeed_debounce #(
     .WIDTH             (CAPTURE_DATA_WIDTH)
    ,.NUM_STAGE         (DEBOUNCE_STAGE)
   ) debounce(
     .i_clock           (clk_atspeed)
    ,.i_data_in         (data_in_sync)
    ,.o_data_out        (data_in_debounce)
    ,.o_valid_pulse     (valid_pulse_db_s)
    ,.o_valid           ()
   );

  // Logic to detect rising edge of trigger
  always_ff @(posedge clk_atspeed)
    trigger_d1 <= trigger;
  
  assign trigger_edge = trigger & (~trigger_d1);
  assign capture_trigger = trigger_edge | trigger_sw;
  // Timestamp FSM
  always_ff @(posedge clk_atspeed, negedge reset_n) begin
    if(~reset_n)
      state <= IDLE ;
    else
      case (state)
        IDLE:
          if(capture_trigger)
            state <= TIMESTAMP;
        TIMESTAMP:
          if(capture_trigger)
            state <= LOGDATA;
        LOGDATA:
          state <= LOGDATA;
        default:
          state <= IDLE;
    endcase
  end

  // A timer with width less than time stamp is run. If an activity is detected, then this timer is set
  // back to 0
  always_ff @(posedge clk_atspeed, negedge reset_n) begin
    if(~reset_n) begin
      watch_dog_timer <= {T_STAMP_W-1{1'b0}};
    end else begin
      if(valid_pulse_db_s) begin
        watch_dog_timer <= {T_STAMP_W-1{1'b0}};
      end else begin
        watch_dog_timer <= (state == LOGDATA) ? (watch_dog_timer + 1) : {T_STAMP_W-1{1'b0}};
      end
    end
  end

  always_ff @(posedge clk_atspeed) begin
    watch_dog_pulse <= (watch_dog_timer ==  {T_STAMP_W-1{1'b1}}) ? 1'b1 : 1'b0;
  end
  
  // Adjust the trigger signal and first data
  always_comb
    if(((state == LOGDATA && valid_pulse_db_s) || ( watch_dog_pulse )|| (state == TIMESTAMP && capture_trigger)) & capture_enable )
      valid_pulse_db <= 1'b1;
    else
      valid_pulse_db <= 1'b0;

  always_ff @(posedge clk_atspeed) begin
    valid_pulse_db_d1 <= valid_pulse_db;
    data_in_debounce_d1 <= data_in_debounce;
  end

  //Increment the counter when in timestamp state
  always_ff @(posedge clk_atspeed) begin
    if(state == TIMESTAMP || state == LOGDATA)
      t_stamp <= t_stamp + 1'b1;
    else
      t_stamp <= {T_STAMP_W {1'b0}};
  end

  //Register the time stamps upon writes
  always_ff @(posedge clk_atspeed) begin
    if(state == IDLE)
      t_stamp_reg <= {T_STAMP_W {1'b0}};
    else
      if(valid_pulse_db)
        t_stamp_reg <= t_stamp;
  end

  //Find the time difference between successive logs
  always_ff @(posedge clk_atspeed) begin
    t_stamp_diff <= {1'b1,t_stamp} - {1'b0,t_stamp_reg}; 
  end

  // fifo configuration logic
  always_comb begin
    if (valid_pulse_db_d1 && !fifo_full)
      fifo_write <= 1'b1;
    else
      fifo_write <= 1'b0;
  end

  assign fifo_hdr_data  = {t_stamp_diff[T_STAMP_W-1:0],packet_count,packet_length,queue_index};
  assign datain_to_fifo = {data_in_debounce_d1,fifo_hdr_data};

  assign load_capture   = fifo_write;
  assign capture_sticky = fifo_write;
  
  always_ff @(posedge clk_atspeed) begin
    case (state)
      IDLE:
        state_fsm <= 3'b001;
      TIMESTAMP:
        state_fsm <= 3'b010;
      LOGDATA:
        state_fsm <= 3'b100;
      default:
        state_fsm <= 3'b000;
    endcase
  end

  
  //Instantiation of fifo module
  IW_generic_sync_fifo_fpga #(
     .MAX_DEPTH  (CAPTURE_FIFO_DEPTH)
    ,.AWIDTH     ($clog2(CAPTURE_FIFO_DEPTH))
    ,.DWIDTH     (CAPTURE_DATA_WIDTH + T_STAMP_W + 32)
  ) u_fifo (
     .clk        (clk_atspeed)
    ,.rst_n      (reset_n)
    ,.clear_fifo (clear_fifo)
    ,.data_in    (datain_to_fifo)
    ,.shiftin    (fifo_write)
    ,.shiftout   (fifo_rd)
    ,.dout       (fifo_data)
    ,.occp       (fifo_occupancy)
    ,.full       (fifo_full)
    ,.empty      (fifo_empty)
  );
  
  assign fifo_rd = chnl_cap_rden & !fifo_empty;
  
  // Instantiation of synchroniser module for trigger 
  IW_fpga_mon2avst #(
    .DBG_CAP_DATA_WIDTH         (CAPTURE_DATA_WIDTH + T_STAMP_W + 32)
   ,.NUM_CAP_INTFS              (NUM_CAP_INTFS)
   ,.HEADER_DATA_W              (0)
   ,.AV_ST_DATA_W               (AV_ST_DATA_W)
   ,.CHNL_DATA_W_LIST           (CHNL_DATA_W_LIST)
   ,.CHNL_Q_IDX_LIST            (CHNL_Q_IDX_LIST)
  ) fifo2avst (
     .clk                       (clk_atspeed)
    ,.rst_n                     (reset_n)
    ,.chnl_cap_rdata_valid_bin  (1'b0)
    ,.chnl_cap_rdata_valid      (!fifo_empty)
    ,.chnl_cap_rdata            ('{fifo_data})
    ,.chnl_cap_rden             (chnl_cap_rden)
    ,.avl_st_ready              (avl_st_ready)
    ,.avl_st_valid              (avl_st_valid)
    ,.avl_st_startofpacket      (avl_st_startofpacket)
    ,.avl_st_endofpacket        (avl_st_endofpacket)
    ,.avl_st_empty              (avl_st_empty)
    ,.avl_st_data               (avl_st_data)
  );

  always @(posedge clk_atspeed, negedge reset_n) begin
    if(~reset_n)
      packet_count <= 0;
    else
      packet_count <= packet_count + valid_pulse_db_d1;
  end

  assign  packet_length = ((CAPTURE_DATA_WIDTH + T_STAMP_W) % 8) ? ((CAPTURE_DATA_WIDTH + T_STAMP_W)/8) + 1 : ((CAPTURE_DATA_WIDTH + T_STAMP_W)/8) ;
  assign  queue_index   = Q_IDX; 
  
  // capture config and status register space 
  assign clk_csr     = clk_avst;
  assign reset_csr_n = rst_avst_n;

  IW_fpga_atspeed_capture_addr_map_csr_wrapper #(
     .INSTANCE_NAME                   (INSTANCE_NAME)
    ,.CAPTURE_WIDTH                   (CAPTURE_DATA_WIDTH)
    ,.CAP_FF_DEPTH                    (CAPTURE_FIFO_DEPTH)
    ,.Q_IDX                           (Q_IDX)
    ,.DEBOUNCE_STAGES                 (DEBOUNCE_STAGE)
    ,.AV_ST_DATA_W                    (AV_ST_DATA_W)
    ,.READ_MISS_VAL                   (32'hDEADBABE)
    ,.CSR_ADDR_WIDTH                  (CSR_ADDR_WIDTH)
    ,.CSR_DATA_WIDTH                  (CSR_DATA_WIDTH)
  ) u_csr (
     .clk_atspeed                     (clk_atspeed)
    ,.rst_atspeed_n                   (reset_n)
    ,.capture_enable                  (capture_enable)
    ,.clr_fifo                        (clear_fifo)
    ,.fifo_occupancy                  (fifo_occupancy)
    ,.fifo_full                       (fifo_full)
    ,.fifo_empty                      (fifo_empty)
    ,.drop_count                      (count_dropped)
    ,.rcvd_count                      (count_rcvd)
    ,.capture_sticky                  (capture_sticky)
    ,.drop_sticky                     (drop_sticky)
    ,.state_fsm                       (state_fsm)
    ,.load_capture                    (load_capture)
    ,.load_drop                       (load_drop)
    ,.trigger_sw                      (trigger_sw)

    ,.rst_csr_n                       (reset_csr_n)
    ,.clk_csr                         (clk_csr)
    ,.csr_write                       (csr_write)
    ,.csr_read                        (csr_read)
    ,.csr_addr                        (csr_addr)
    ,.csr_wr_data                     (csr_wr_data)
    ,.csr_rd_data                     (csr_rd_data)
    ,.csr_rd_valid                    (csr_rd_valid)
  );

// AVST2CSR instance
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
    ,.rst_csr_n             (reset_csr_n             )
    ,.csr_write             (csr_write               )
    ,.csr_read              (csr_read                )
    ,.csr_addr              (csr_addr                )
    ,.csr_wr_data           (csr_wr_data             )
    ,.csr_rd_data           (csr_rd_data             )
    ,.csr_rd_valid          (csr_rd_valid            )
   );

//Count dropped capture
  always_ff @(posedge clk_atspeed, negedge reset_n) begin
    if(~reset_n)
      count_dropped <= 0;
    else
      if (valid_pulse_db_d1 & fifo_full)
        count_dropped <= count_dropped + 1'b1;
  end

  always_ff @(posedge clk_atspeed, negedge reset_n) begin
    if(~reset_n)
      count_rcvd <= 0;
    else
      if (valid_pulse_db_d1 && !fifo_full)
        count_rcvd <= count_rcvd + 1'b1;
  end

  assign drop_sticky = (valid_pulse_db_d1 && fifo_full && (state == LOGDATA) && capture_enable) ? 1'b1 : 1'b0;
  assign load_drop   = drop_sticky;

endmodule
