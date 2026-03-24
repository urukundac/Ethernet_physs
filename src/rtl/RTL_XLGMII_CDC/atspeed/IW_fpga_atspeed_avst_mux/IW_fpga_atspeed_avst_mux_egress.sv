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

/* -- Project Code    : Atspeed
 -- Module Name       : IW_FPGA_ATSPEED_AVST_MUX_EGRESS
 -- Author            : Rahul Govindan
 -- Function          : This module arbitrates between two FIFO memories and 
 --                     reads all the data present in the active mem when a
 --                     ready signal is given to it
 -------------------------------------------------------------------------------
*/

`timescale 1ns / 10ps

module IW_fpga_atspeed_avst_mux_egress #(
    parameter AVST_DATA_W                  = 32 
   ,parameter MEMORY_DEPTH_1               = 8
   ,parameter MEMORY_DEPTH_2               = 8
   ) (
    input  logic                                            clk_egress
   ,input  logic                                            rst_n
   ,input  logic                                            avst_egr_ready
   ,output logic [AVST_DATA_W-1:0]                          avst_egr_data
   ,output logic [$clog2(AVST_DATA_W/8)-1:0]                avst_egr_empty
   ,output logic                                            avst_egr_sop
   ,output logic                                            avst_egr_eop
   ,output logic                                            avst_egr_valid

   ,input  logic [AVST_DATA_W+$clog2(AVST_DATA_W/8)+1:0]    mem_readdata1
   ,input  logic [AVST_DATA_W+$clog2(AVST_DATA_W/8)+1:0]    mem_readdata2
   ,output logic                                            mem_read1
   ,output logic                                            mem_read2
   ,output logic                                            read_done1
   ,output logic                                            read_done2
   ,output logic [$clog2(MEMORY_DEPTH_1)-1:0]               read_ptr_syn1
   ,output logic [$clog2(MEMORY_DEPTH_2)-1:0]               read_ptr_syn2

   ,output logic [$clog2(MEMORY_DEPTH_1)-1:0]               read_ptr1
   ,output logic [$clog2(MEMORY_DEPTH_2)-1:0]               read_ptr2

   ,output logic [$clog2(MEMORY_DEPTH_1):0]                 count_val1
   ,output logic [$clog2(MEMORY_DEPTH_2):0]                 count_val2

   ,input  logic                                            write_done1
   ,input  logic                                            write_done2
   );
   
  
  localparam AVST_EMPTY_W                    = $clog2(AVST_DATA_W/8);
  localparam AVST_FULL_W                     = AVST_DATA_W+AVST_EMPTY_W+2;
  localparam MEM_PTR_W_1                     = $clog2(MEMORY_DEPTH_1);
  localparam COUNT_W_1                       = $clog2(MEMORY_DEPTH_1);
  localparam MEM_PTR_W_2                     = $clog2(MEMORY_DEPTH_2);
  localparam COUNT_W_2                       = $clog2(MEMORY_DEPTH_2);
  
  logic                                      toggle;       
  logic                                      toggle_inv;
  //toggle 0 -> W1   toggle 1 -> W2

  logic                                      mem_read_done1;
  logic                                      mem_read_done2;
  logic [AVST_DATA_W-1:0]                    avst_data1;
  logic [AVST_DATA_W-1:0]                    avst_data2;
  logic                                      avst_sop1;
  logic                                      avst_eop1;
  logic [AVST_EMPTY_W-1:0]                   avst_empty1;
  logic                                      avst_sop2;
  logic                                      avst_eop2;
  logic [AVST_EMPTY_W-1:0]                   avst_empty2;
  logic                                      reg_read1;
  logic                                      reg_read2;
  logic [COUNT_W_1:0]                        count1;
  logic [COUNT_W_2:0]                        count2;  
  logic                                      stay_condition1;
  logic                                      stay_condition2;
  logic                                      stay_condition;
  logic [MEM_PTR_W_1-1:0]                    read_ptr_delayed1;
  logic [MEM_PTR_W_2-1:0]                    read_ptr_delayed2;


  enum logic [2:0] { IDLE=3'b000, PRE_READ_1= 3'b001,
                     PRE_READ_2=3'b010, READ=3'b011, LAST_BEAT=3'b100} state;

  /* State machine
   */
  always@(posedge clk_egress, negedge rst_n)
  begin
    if(!rst_n)
      state <= IDLE;
    else
      case (state)
      IDLE:
        if((~toggle_inv && count1 != 0) || (toggle_inv && count2 != 0))
          state <= PRE_READ_1;

      PRE_READ_1:
        state <= PRE_READ_2;

      PRE_READ_2:
        if(~toggle)
          begin
            if(mem_readdata1[0] && count1 == 1) //EOP bit
              state <= LAST_BEAT;	
            else
              state <= READ;
          end
        else
          begin
            if(mem_readdata2[0] && count2 == 1) //EOP bit
              state <= LAST_BEAT;
            else
              state <= READ;
          end
      READ:
        if(~toggle)
          begin
            if(avst_egr_ready && mem_readdata1[0] && count1 == 1) //EOP bit & last data accepted
              state <= LAST_BEAT;	
          end
        else
          begin
            if(avst_egr_ready && mem_readdata2[0] && count2 == 1) //EOP bit & last data accepted
              state <= LAST_BEAT;
          end
      LAST_BEAT:
        if(avst_egr_ready)
          state <= IDLE;

      endcase	  
  end

  assign count_val1 = count1;
  assign count_val2 = count2;

  assign read_ptr_syn1 = read_ptr_delayed1;
  assign read_ptr_syn2 = read_ptr_delayed2;

  //Arbitration from mems of 2 agents; equal priority is given to
  //both the agents in round robin fashion. Once an agent is chosen,
  //all the available packets will be muxed 
  // if current agent has packets, it will be serviced. Toggle
  // only if current agent does not have packets

  always@(posedge clk_egress, negedge rst_n)
    if(!rst_n)	
      toggle_inv <= 1'b0;
    else 
      if(state == IDLE && (count1 != 0 || count2 != 0))	    
        toggle_inv <= ~toggle_inv;

  assign toggle = ~toggle_inv;

  // Ready signal is generated based on EOP and other conditions
  always @(posedge clk_egress)
  begin
    case (state)
      IDLE:
        avst_egr_valid <= 1'b0;
      PRE_READ_1:
        avst_egr_valid <= 1'b0;
      PRE_READ_2:
        avst_egr_valid <= 1'b1;
      READ:
        avst_egr_valid <= 1'b1;
      LAST_BEAT:
        if(avst_egr_ready)
          avst_egr_valid <= 1'b0;
        else
          avst_egr_valid <= 1'b1;
    endcase
  end

  // Generating of read signal to BRAMs
  assign mem_read1 = ~toggle && (state==PRE_READ_1 || 
                                 ((state==PRE_READ_2 || state==READ) && avst_egr_ready));
  assign mem_read2 = toggle &&  (state==PRE_READ_1 ||
                                 (( state==PRE_READ_2 || state==READ) && avst_egr_ready));

  assign reg_read1 = (state==PRE_READ_2 || (state==READ && avst_egr_ready)) && ~toggle;
  assign reg_read2 = (state==PRE_READ_2 || (state==READ && avst_egr_ready)) &&  toggle; 

  assign mem_read_done1 = ((state==PRE_READ_2 && mem_readdata1[0]) || (state==READ && avst_egr_ready && mem_readdata1[0])) && 
                          ~toggle;
  assign mem_read_done2 = ((state==PRE_READ_2 && mem_readdata2[0]) || (state==READ && avst_egr_ready && mem_readdata2[0])) && 
                           toggle;

  always @(posedge clk_egress) read_done1 <= mem_read_done1;
  always @(posedge clk_egress) read_done2 <= mem_read_done2;

  // Generating the delayed read ptr
  // This pointer indicates the address of the data actually read
  // as data from BRAM has delays
  always@(posedge clk_egress, negedge rst_n)
    if(~rst_n)
      read_ptr_delayed1 <= {default: 1'b0};
    else 
      if(state == LAST_BEAT)
        read_ptr_delayed1 <= read_ptr1;

  //Generating the delayed read ptr 2
  always@(posedge clk_egress, negedge rst_n)
    if(~rst_n)
      read_ptr_delayed2 <= {default: 1'b0};
    else
      if(state == LAST_BEAT)
        read_ptr_delayed2 <= read_ptr2;
  
  // Generating read_ptr for memory of agent 1
  // Due to delay between availability of data from BRAMs,
  // addresses are generated in advance for reading. Upon
  // disovering EOPs of the last packet, address has to be
  // brought back to location, next to where last valid
  // data was read
  always@(posedge clk_egress, negedge rst_n)
  begin
    if(~rst_n)
      read_ptr1 <= {default: 1'b0};
    else if(~toggle)
      case (state)
      PRE_READ_1: 
        read_ptr1 <= read_ptr1 + 1'b1;
      PRE_READ_2:
        if(mem_readdata1[0] && count1 == 1)
          read_ptr1 <= read_ptr1;
        else
          read_ptr1 <= read_ptr1 + 1'b1;
      READ:
        if(avst_egr_ready)
          if(mem_readdata1[0] && count1 == 1)
            read_ptr1 <= read_ptr1;
          else
            read_ptr1 <= read_ptr1 + 1'b1;
      endcase
  end

  //Generating read_ptr for memory of agent 2
  always@(posedge clk_egress, negedge rst_n)
    if(~rst_n)
      read_ptr2 <= {default: 1'b0};
    else if(toggle)        
      case (state)
      PRE_READ_1: 
        read_ptr2 <= read_ptr2 + 1'b1;
      PRE_READ_2:
        if(mem_readdata2[0] && count2 == 1)
          read_ptr2 <= read_ptr2;
        else
          read_ptr2 <= read_ptr2 + 1'b1;
      READ:
        if(avst_egr_ready)
          if(mem_readdata2[0] && count2 == 1)
            read_ptr2 <= read_ptr2;
          else  
      	    read_ptr2 <= read_ptr2 + 1'b1;
      endcase
 
  //Registering mem1 data 
  always@(posedge clk_egress)
  if(~rst_n)
    begin
`ifdef FPGA_SIM
    avst_data1   <= {default: 1'b0};
`endif
    avst_empty1  <= {default: 1'b0};
    avst_sop1    <= 1'b0;
    avst_eop1    <= 1'b0;
    end
  else
    if(reg_read1)	
    begin
      avst_data1     <= mem_readdata1[AVST_FULL_W-1:AVST_FULL_W-AVST_DATA_W];	
      avst_empty1    <= mem_readdata1[AVST_EMPTY_W+1:2];
      avst_sop1      <= mem_readdata1[1];
      avst_eop1      <= mem_readdata1[0];
    end

  //Registering mem2 data  
  always@(posedge clk_egress)
  if(~rst_n)
    begin
`ifdef FPGA_SIM
    avst_data2   <= {default: 1'b0};
`endif
    avst_empty2  <= {default: 1'b0};
    avst_sop2    <= 1'b0;
    avst_eop2    <= 1'b0;
    end
  else
    if(reg_read2)	  
    begin
      avst_data2     <= mem_readdata2[AVST_FULL_W-1:AVST_FULL_W-AVST_DATA_W];	
      avst_empty2    <= mem_readdata2[AVST_EMPTY_W+1:2];
      avst_sop2      <= mem_readdata2[1];
      avst_eop2      <= mem_readdata2[0];
    end

  // based on, from where the data was read, data is muxed and given out
  // 2:1 MUX from registered data is given out without registering
  assign avst_egr_data  = toggle ? avst_data2 : avst_data1;
  assign avst_egr_sop   = toggle ? avst_sop2  : avst_sop1;
  assign avst_egr_eop   = toggle ? avst_eop2  : avst_eop1;
  assign avst_egr_empty = toggle ? avst_empty2: avst_empty1;
 
  //Generating the counter value on the basis of write_done and read_done
  always@(posedge clk_egress, negedge rst_n)
    if(~rst_n)
      count1 <= {default: 1'b0};
    else
    begin
      if(write_done1 && ~mem_read_done1)
        count1 <= count1 + 1'b1;
      else if(~write_done1 && mem_read_done1) 
       count1 <= count1 - 1'b1;
    end 
  
  //Generating the counter value on the basis of write_done and read_done
  always@(posedge clk_egress, negedge rst_n)
    if(~rst_n)
      count2 <= {default: 1'b0};
    else
    begin
      if(write_done2 && !mem_read_done2)
        count2 <= count2 + 1'b1;
      else if(!write_done2 && mem_read_done2) 
        count2 <= count2 - 1'b1;
    end   

endmodule    
