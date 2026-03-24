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

/*
 ------------------------------------------------------------------------------
 -- Project Code      : Atspeed
 -- Module Name       : IW_FPGA_ATSPEED_AVST_MUX_INGRESS
 -- Author            : Rahul Govindan
 -- Function          : This module defines the FSM for ingress part of mux
 --                     in an Avalon streaming interface
 ------------------------------------------------------------------------------
*/

`timescale 1ns / 10ps

module IW_fpga_atspeed_avst_mux_ingress #(
   parameter AVST_DATA_ING_W                  = 32
  ,parameter MEMORY_DEPTH                     = 8 
  ,parameter FULL_WMARK                       = 4
	,parameter AGGREGATE_BW                     = 0

	,parameter AVST_DATA_EGR_W                  = AGGREGATE_BW ? AVST_DATA_ING_W*2 : AVST_DATA_ING_W
   ) (
    input  logic                                  clk_ingress
   ,input  logic                                  clk_egress 
   ,input  logic                                  rst_n
   
   ,input  logic                                  avst_ing_input_valid  
   ,input  logic [AVST_DATA_ING_W-1:0]            avst_ing_data  
   ,input  logic                                  avst_ing_sop
   ,input  logic                                  avst_ing_eop
   ,input  logic [$clog2(AVST_DATA_ING_W/8)-1:0]  avst_ing_empty
   ,output logic                                  avst_ing_ready

   ,output logic                                  write_done
   ,input  logic [$clog2(MEMORY_DEPTH)-1:0]       read_ptr_syn

   ,input  logic                                  mem_read
   ,input  logic [$clog2(MEMORY_DEPTH)-1:0]       read_ptr 
   ,output logic [AVST_DATA_EGR_W
                  + $clog2(AVST_DATA_EGR_W/8) 
									+ 1:0]                          mem_dataout

   ,output logic                                  packet_drop
   ,output logic [31:0]                           data_rcvd                              
   );   

  localparam   AVST_EMPTY_ING_W               = $clog2(AVST_DATA_ING_W/8);
  localparam   AVST_FULL_W                    = AVST_DATA_ING_W+AVST_EMPTY_ING_W+2;
  localparam   MEM_PTR_W                      = $clog2(MEMORY_DEPTH);

`ifdef FPGA_SIM
  localparam   TERMINAL_TIMER                 = 512;
`else
  localparam   TERMINAL_TIMER                 = 4 *1024 *1024;
`endif
 
  logic [AVST_DATA_ING_W-1:0]                   write_data;
  logic                                         write_sop;
  logic                                         write_eop;
  logic [AVST_EMPTY_ING_W-1:0]                  write_empty;
  logic [MEM_PTR_W-1:0]                         write_ptr;  
  logic                                         write_valid;
  logic [MEM_PTR_W-1:0]                         local_ptr;
  logic [MEM_PTR_W-1:0]                         local_ptr_d1;
  logic                                         mem_full;
  logic [MEM_PTR_W:0]                           mem_occupancy;
  logic [MEM_PTR_W:0]                           mem_vacancy;
  logic                                         mem_full_flag;
  logic [AVST_FULL_W-1:0]                       write_full_data;                          
  logic [31:0]                                  timer_count;
  logic                                         timer_count_flag;
  logic [31:0]                                  data_rcvd_count;

  // all inputs are registered before writing to BRAM to improve timing
  always@(posedge clk_ingress)
  begin
    write_data  <= avst_ing_data;
    write_sop   <= avst_ing_sop;
    write_eop   <= avst_ing_eop;
    write_empty <= avst_ing_empty;
  end
  assign write_full_data = { write_data, write_empty, write_sop, write_eop }; 
 
  // Ready is generated in all clocks, except at the end of a packet, when
  // pointers are exchanged
  always@(posedge clk_ingress, negedge rst_n)
  begin 
    if(~rst_n)
      avst_ing_ready <= 1'b0;
    else
      avst_ing_ready <= 1'b1;
  end

  //write pointer gets updated upon completion of a 
  //successful write
  always@(posedge clk_ingress, negedge rst_n)
  begin
    if(~rst_n)
      write_ptr <= {default: 1'b0};
    else
      if(avst_ing_input_valid && avst_ing_eop && !mem_full_flag) begin
        if(~local_ptr[0])
          write_ptr <= AGGREGATE_BW ? (local_ptr + 2) : (local_ptr + 1);
			  else
				  write_ptr <= local_ptr + 1;
      end
  end

  // local pointer is assigned with write pointer in the beginning of
  // state machine. It is incremented upon every write
  always@(posedge clk_ingress, negedge rst_n) 
  begin                
    if(~rst_n)
      local_ptr <= {default: 1'b0};
    else
      if(avst_ing_input_valid)begin
        if(avst_ing_eop) begin
          if(!mem_full_flag)
            if(~local_ptr[0])
              local_ptr <= AGGREGATE_BW ? (local_ptr + 2) : (local_ptr + 1);
			      else
				      local_ptr <= local_ptr + 1;
          else
            local_ptr <= write_ptr;
        end else // avst_ing_eop
          local_ptr <= local_ptr + 1;
      end // avst_ing_input_valid
  end
  
  always @(posedge clk_ingress) local_ptr_d1 <= local_ptr;

  //block to generate write_done signals
  always@(posedge clk_ingress) 
  begin
    if(avst_ing_eop && avst_ing_input_valid && !mem_full_flag) 
      write_done <= 1'b1;    		  
    else
      write_done <= 1'b0;
  end  

  //block to generate and write_valid signals
  always@(posedge clk_ingress)
  begin
    if(avst_ing_input_valid && !mem_full_flag)
      write_valid <= 1'b1;
    else
      write_valid <= 1'b0;
  end    

  if(AGGREGATE_BW) // Read 2 locations when Bandwidth is being aggregated; else reading 1 location only
    assign mem_occupancy = { 1'b1, {local_ptr[MEM_PTR_W-1:0]}} - { 1'b0, {read_ptr_syn[MEM_PTR_W-2:0]}, 1'b0}; 
  else
    assign mem_occupancy = { 1'b1, {local_ptr[MEM_PTR_W-1:0]}} - { 1'b0, {read_ptr_syn[MEM_PTR_W-1:0]}}; 

  assign mem_vacancy = MEMORY_DEPTH - mem_occupancy[MEM_PTR_W-1:0];

 //block to generate mem_full signal
 assign mem_full = (mem_vacancy < FULL_WMARK + 1) ? 1'b1 : 1'b0;
 
 //generation of mem_full_flag
  always@(posedge clk_ingress, negedge rst_n) begin
    if(~rst_n)
      mem_full_flag <= 1'b0;
    else
      if(avst_ing_eop && avst_ing_input_valid)
        mem_full_flag <= mem_full;
      else
        if(mem_full)
          mem_full_flag <= 1'b1;
  end

 // instantiation of memory to store packets
generate
if(AGGREGATE_BW == 0) begin
 fpgamem #(
	  .ADDR_WD               (MEM_PTR_W),
	  .DATA_WD               (AVST_DATA_ING_W+AVST_EMPTY_ING_W+2),
	  .WR_RD_SIMULT_DATA     (0)
  ) inst_packet_memory (
	  .ckwr                  (clk_ingress),
	  .ckrd                  (clk_egress),
	  .wr                    (write_valid),
	  .wrptr                 (local_ptr_d1),
	  .datain                (write_full_data),
	  .rd                    (mem_read),
	  .rdptr                 (read_ptr),
	  .dataout               (mem_dataout)
  );
end else begin
 logic                                         write_valid_lsbpart;
 logic                                         write_valid_msbpart;
 logic [AVST_FULL_W-1:0]                       write_full_lsb_data;                          
 logic [AVST_FULL_W-1:0]                       write_full_msb_data;                          
 logic [AVST_FULL_W-1:0]                       read_full_lsb_data;                          
 logic [AVST_FULL_W-1:0]                       read_full_msb_data;
 logic                                         readdata_sop;
 logic                                         readdata_eop;
 logic [AVST_DATA_EGR_W-1:0]                   readdata_data;
 logic [$clog2(AVST_DATA_EGR_W/8)-1:0]         readdata_empty;

 assign write_valid_lsbpart = write_valid & ~local_ptr_d1[0];
 assign write_valid_msbpart = (write_valid & local_ptr_d1[0]) |
                              (write_valid & ~local_ptr_d1[0] & write_eop); 
 assign write_full_lsb_data = write_full_data;
 assign write_full_msb_data = (write_valid & ~local_ptr_d1[0] & write_eop) ? 0 : write_full_data;

 fpgamem #(
	  .ADDR_WD               (MEM_PTR_W-1),
	  .DATA_WD               (AVST_DATA_ING_W+AVST_EMPTY_ING_W+2),
	  .WR_RD_SIMULT_DATA     (0)
  ) inst_packet_memory_lspart (
	  .ckwr                  (clk_ingress),
	  .ckrd                  (clk_egress),
	  .wr                    (write_valid_lsbpart),
	  .wrptr                 (local_ptr_d1[MEM_PTR_W-1:1]),
	  .datain                (write_full_lsb_data),
	  .rd                    (mem_read),
	  .rdptr                 (read_ptr[MEM_PTR_W-2:0]),
	  .dataout               (read_full_lsb_data)
  );

 fpgamem #(
	  .ADDR_WD               (MEM_PTR_W-1),
	  .DATA_WD               (AVST_DATA_ING_W+AVST_EMPTY_ING_W+2),
	  .WR_RD_SIMULT_DATA     (0)
  ) inst_packet_memory_mspart (
	  .ckwr                  (clk_ingress),
	  .ckrd                  (clk_egress),
	  .wr                    (write_valid_msbpart),
	  .wrptr                 (local_ptr_d1[MEM_PTR_W-1:1]),
	  .datain                (write_full_msb_data),
	  .rd                    (mem_read),
	  .rdptr                 (read_ptr[MEM_PTR_W-2:0]),
	  .dataout               (read_full_msb_data)
  );

  assign readdata_eop = read_full_msb_data[0] | read_full_lsb_data[0];
  assign readdata_sop = read_full_msb_data[1] | read_full_lsb_data[1];
  assign readdata_data = {read_full_msb_data[AVST_DATA_ING_W+AVST_EMPTY_ING_W+2-1 -: AVST_DATA_ING_W],
	                        read_full_lsb_data[AVST_DATA_ING_W+AVST_EMPTY_ING_W+2-1 -: AVST_DATA_ING_W]};

  always_comb begin
    if(read_full_lsb_data[0])
      readdata_empty <= read_full_lsb_data[2 +: AVST_EMPTY_ING_W] + 2 ** $clog2(AVST_DATA_ING_W/8);
    else
      if(read_full_msb_data[0] )
        readdata_empty <= read_full_msb_data[2 + AVST_EMPTY_ING_W];
      else
        readdata_empty <= {default: 1'b0};
  end

	assign mem_dataout  = {readdata_data,readdata_empty,readdata_sop,readdata_eop};
end
endgenerate

  //block to generate packet_drop for statistics
  always@(posedge clk_ingress)
  begin
    if(avst_ing_eop && avst_ing_input_valid && mem_full_flag)
      packet_drop <= 1'b1;
    else
      packet_drop <= 1'b0;
  end

// statistics registers : data received in unit time
always @(posedge clk_ingress, negedge rst_n) begin
  if(~rst_n)
    timer_count <= {default : 1'b0};
  else
    if(timer_count_flag)
      timer_count <= {default : 1'b0};
    else
      timer_count <= timer_count + 1'b1;
end

always @(posedge clk_ingress) begin
  if(timer_count == (TERMINAL_TIMER -1))
    timer_count_flag <= 1'b1;
  else
    timer_count_flag <= 1'b0;
end

//synthesis translate_off
initial data_rcvd_count <= {default: 1'b0};
//synthesis translate_on

always @(posedge clk_ingress) begin
  if(timer_count_flag)
    data_rcvd_count <= {default: 1'b0};
  else if(avst_ing_input_valid && avst_ing_ready)
    data_rcvd_count <= data_rcvd_count + 1'b1;
end

//synthesis translate_off
initial data_rcvd <= {default: 1'b0};
//synthesis translate_on

always @(posedge clk_ingress) begin
  if(timer_count_flag)
    data_rcvd <= data_rcvd_count;
end

endmodule
