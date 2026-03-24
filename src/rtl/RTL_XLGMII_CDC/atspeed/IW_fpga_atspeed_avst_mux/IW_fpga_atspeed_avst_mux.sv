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
// may be used, copied, ingroduced, modified, published, uploaded, posted,
// transmitted, distributed, or disclosed in any way without Intel's prior
// express written permission.
// 
// No license under any patent, copyright, trade secret or other intellectual
// property right is granted to or conferred upon you by disclosure or delivery
// of the Materials, either expressly, by implication, inducement, estoppel or
// otherwise. Any license under such intellectual property rights must be
// express and approved by Intel in writing.
//-----------------------------------------------------------------------------

/*-- Project Code      : Atspeed
 -- Module Name       : IW_FPGA_ATSPEED_AVST_MUX
 -- Author            : Rahul Govindan
 -- Function          : This is a 2 x 1 MUX with AVST interface on egress
 --                     and ingress sides.
 --------------------------------------------------------------------------
*/

`timescale 1ns / 10ps

module IW_fpga_atspeed_avst_mux #(
    parameter   AVST_DATA_ING_W             = 32
   ,parameter   AGGREGATE_BW                = 0
   ,parameter   FULL_WMARK_1                = 4
   ,parameter   MEMORY_DEPTH_1              = 8  
   ,parameter   FULL_WMARK_2                = 4
   ,parameter   MEMORY_DEPTH_2              = 8

	 ,parameter   AVST_DATA_EGR_W             = AGGREGATE_BW ? AVST_DATA_ING_W*2 : AVST_DATA_ING_W

   ) (
    input  logic                                 clk_ingr1
   ,input  logic                                 clk_ingr2 
   ,input  logic                                 clk_egress
   ,input  logic                                 rst_n_ingr1
   ,input  logic                                 rst_n_ingr2
   ,input  logic                                 rst_n_egress

   ,input  logic                                 avst_ing_valid1  
   ,input  logic [AVST_DATA_ING_W-1:0]           avst_ing_data1
   ,input  logic                                 avst_ing_sop1
   ,input  logic                                 avst_ing_eop1
   ,input  logic [$clog2(AVST_DATA_ING_W/8)-1:0] avst_ing_empty1
   ,output logic                                 avst_ing_ready1

   ,input  logic                                 avst_ing_valid2  
   ,input  logic [AVST_DATA_ING_W-1:0]           avst_ing_data2
   ,input  logic                                 avst_ing_sop2
   ,input  logic                                 avst_ing_eop2
   ,input  logic [$clog2(AVST_DATA_ING_W/8)-1:0] avst_ing_empty2
   ,output logic                                 avst_ing_ready2

   ,input  logic                                 avst_egr_ready
   ,output logic [AVST_DATA_EGR_W-1:0]           avst_egr_data
   ,output logic [$clog2(AVST_DATA_EGR_W/8)-1:0] avst_egr_empty
   ,output logic                                 avst_egr_sop
   ,output logic                                 avst_egr_eop
   ,output logic                                 avst_egr_input_valid

   ,output logic [$clog2(MEMORY_DEPTH_1):0]      count1
   ,output logic [$clog2(MEMORY_DEPTH_2):0]      count2
   ,output logic [7:0]                           count_drop1
   ,output logic [7:0]                           count_drop2
   ,output logic [7:0]                           count_read1
   ,output logic [7:0]                           count_read2
   ,output logic [31:0]                          data_rcvd1
   ,output logic [31:0]                          data_rcvd2
   );
  
  localparam   AVST_EMPTY_W               = $clog2(AVST_DATA_EGR_W/8);
  localparam   AVST_FULL_W                = AVST_DATA_EGR_W+AVST_EMPTY_W+2;
  localparam   MEM_PTR_W_1                = $clog2(MEMORY_DEPTH_1); 
  localparam   COUNT_W_1                  = $clog2(MEMORY_DEPTH_1);
  localparam   MEM_PTR_W_2                = $clog2(MEMORY_DEPTH_2); 
  localparam   COUNT_W_2                  = $clog2(MEMORY_DEPTH_2);

  logic [MEM_PTR_W_1-1:0]                   read_ptr_syn1_g;
  logic [MEM_PTR_W_2-1:0]                   read_ptr_syn2_g;
  logic [MEM_PTR_W_1-1:0]                   read_ptr_syn1_del;
  logic [MEM_PTR_W_2-1:0]                   read_ptr_syn2_del;
  logic                                     read_done1;
  logic                                     read_done2;
  logic [AVST_FULL_W-1:0]                   mem_readdata1;
  logic [AVST_FULL_W-1:0]                   mem_readdata2;
  logic                                     mem_read1;
  logic                                     mem_read2;
  logic [MEM_PTR_W_1-1:0]                   read_ptr_syn1;
  logic [MEM_PTR_W_2-1:0]                   read_ptr_syn2;
  logic [MEM_PTR_W_1-1:0]                   read_ptr_syn12;
  logic [MEM_PTR_W_2-1:0]                   read_ptr_syn22;
  logic [MEM_PTR_W_1-1:0]                   read_ptr1;
  logic [MEM_PTR_W_2-1:0]                   read_ptr2;
  logic                                     write_done1;
  logic                                     write_done2;
  logic                                     write_done12;
  logic                                     write_done22;
  logic                                     packet_drop1;
  logic                                     packet_drop2;
 

 // Write done from INGRESS module for port 1 is synchronised to egress clock
 IW_async_pulses inst_write_done12 (
   .clk_src                                  (clk_ingr1),
   .rst_src_n                                (rst_n_ingr1),
   .data                                     (write_done1),
   .clk_dst                                  (clk_egress),
   .rst_dst_n                                (rst_n_egress),
   .data_sync                                (write_done12)
 );

 // Write done from INGRESS module for port 2 is synchronised to egress clock
 IW_async_pulses inst_write_done22 (
   .clk_src                                  (clk_ingr2),
   .rst_src_n                                (rst_n_ingr2),
   .data                                     (write_done2),
   .clk_dst                                  (clk_egress),
   .rst_dst_n                                (rst_n_egress),
   .data_sync                                (write_done22)
 );

 /* Read addresses used for calculation of full signal in ingress ports
  * is -> Read address in egress domain converted to gray coding, synchronised
  * and then again back to binary coding. Done for both the ingress ports
  * */
 IW_bin2gray #(
    .WIDTH                                 ($bits(read_ptr_syn1))
  ) inst_bg_syn1 (
    .binary                                (read_ptr_syn1),
    .gray                                  (read_ptr_syn1_g)
  );

  IW_fpga_double_sync #(
     .WIDTH                                ($bits(read_ptr_syn1_g)),
     .NUM_STAGES                           (2)
  ) inst_syn1 (
    .clk                                   (clk_ingr1),
    .sig_in                                (read_ptr_syn1_g),
    .sig_out                               (read_ptr_syn1_del)
  );

  IW_gray2bin #(
     .WIDTH                                ($bits(read_ptr_syn1_del))
  ) inst_gb_syn1 (
    .gray                                  (read_ptr_syn1_del),
    .binary                                (read_ptr_syn12)
  ); 
  

  IW_bin2gray #(
    .WIDTH                                 ($bits(read_ptr_syn2))
  ) inst_bg_syn2 (
    .binary                                (read_ptr_syn2),
    .gray                                  (read_ptr_syn2_g)
  );

  IW_fpga_double_sync #(
     .WIDTH                                ($bits(read_ptr_syn2_g)),
     .NUM_STAGES                           (2)
  ) inst_syn2 (
    .clk                                   (clk_ingr2),
    .sig_in                                (read_ptr_syn2_g),
    .sig_out                               (read_ptr_syn2_del)
  );

  IW_gray2bin #(
     .WIDTH                                ($bits(read_ptr_syn2_del))
  ) inst_gb_syn2 (
    .gray                                  (read_ptr_syn2_del),
    .binary                                (read_ptr_syn22)
  );  

 // INGRESS Data handling module with memory module for Port 1
 IW_fpga_atspeed_avst_mux_ingress #(
    .AVST_DATA_ING_W                       (AVST_DATA_ING_W),
    .MEMORY_DEPTH                          (MEMORY_DEPTH_1),
    .FULL_WMARK                            (FULL_WMARK_1),
		.AGGREGATE_BW                          (AGGREGATE_BW)
    ) inst_ingress_1 (
    .clk_ingress                           (clk_ingr1),
    .clk_egress                            (clk_egress),
    .rst_n                                 (rst_n_ingr1), 
    .avst_ing_input_valid                  (avst_ing_valid1),
    .avst_ing_data                         (avst_ing_data1),
    .avst_ing_sop                          (avst_ing_sop1),
    .avst_ing_eop                          (avst_ing_eop1),
    .avst_ing_empty                        (avst_ing_empty1),
    .avst_ing_ready                        (avst_ing_ready1),
    .write_done                            (write_done1),
    .read_ptr_syn                          (read_ptr_syn12),
    .mem_read                              (mem_read1),
    .read_ptr                              (read_ptr1),
    .mem_dataout                           (mem_readdata1),
    .packet_drop                           (packet_drop1),
    .data_rcvd                             (data_rcvd1)
    );

 // INGRESS Data handling module with memory module for Port 2
 IW_fpga_atspeed_avst_mux_ingress #(
    .AVST_DATA_ING_W                       (AVST_DATA_ING_W),
    .MEMORY_DEPTH                          (MEMORY_DEPTH_2),
    .FULL_WMARK                            (FULL_WMARK_2),
		.AGGREGATE_BW                          (AGGREGATE_BW)
    ) inst_ingress_2 (
    .clk_ingress                           (clk_ingr2),
    .clk_egress                            (clk_egress),
    .rst_n                                 (rst_n_ingr2), 
    .avst_ing_input_valid                  (avst_ing_valid2),
    .avst_ing_data                         (avst_ing_data2),
    .avst_ing_sop                          (avst_ing_sop2),
    .avst_ing_eop                          (avst_ing_eop2),
    .avst_ing_empty                        (avst_ing_empty2),
    .avst_ing_ready                        (avst_ing_ready2),
    .write_done                            (write_done2),
    .read_ptr_syn                          (read_ptr_syn22),
    .mem_read                              (mem_read2),
    .read_ptr                              (read_ptr2),
    .mem_dataout                           (mem_readdata2),
    .packet_drop                           (packet_drop2),
    .data_rcvd                             (data_rcvd2)
    );

 IW_fpga_atspeed_avst_mux_egress #(
    .AVST_DATA_W                           (AVST_DATA_EGR_W),
    .MEMORY_DEPTH_1                        (MEMORY_DEPTH_1),
    .MEMORY_DEPTH_2                        (MEMORY_DEPTH_2)
  ) inst_EGRESS (
    .clk_egress                            (clk_egress),  
    .rst_n                                 (rst_n_egress),
    .avst_egr_ready                        (avst_egr_ready),
    .avst_egr_data                         (avst_egr_data),
    .avst_egr_sop                          (avst_egr_sop),
    .avst_egr_eop                          (avst_egr_eop),
    .avst_egr_empty                        (avst_egr_empty),
    .mem_readdata1                         (mem_readdata1),
    .mem_readdata2                         (mem_readdata2),
    .mem_read1                             (mem_read1),
    .mem_read2                             (mem_read2),
    .read_done1                            (read_done1),
    .read_done2                            (read_done2),
    .read_ptr_syn1                         (read_ptr_syn1),
    .read_ptr_syn2                         (read_ptr_syn2),
    .read_ptr1                             (read_ptr1),
    .read_ptr2                             (read_ptr2),
    .avst_egr_valid                        (avst_egr_input_valid),
    .count_val1                            (count1),
    .count_val2                            (count2),
    .write_done1                           (write_done12),
    .write_done2                           (write_done22)
    );


 /* Generation of statistical registers related to ingress ports */

 //counter which keeps track of number of packets dropped in fifo1
 always@(posedge clk_ingr1, negedge rst_n_ingr1)
 if(~rst_n_ingr1)
   count_drop1 <= {default: 1'b0};
 else 
   if(packet_drop1)
     count_drop1 <= count_drop1 + 1'b1;
   
 //counter which keeps track of number of packets dropped in fifo2
 always@(posedge clk_ingr2, negedge rst_n_ingr2)
 if(~rst_n_ingr2)
   count_drop2 <= {default: 1'b0};
 else 
   if(packet_drop2)
     count_drop2 <= count_drop2 + 1'b1;

   
 //counter which keeps track of number of packets read from fifo1
 always@(posedge clk_egress, negedge rst_n_egress)
 if(~rst_n_egress)
   count_read1 <= {default: 1'b0};
 else 
   if(read_done1)
     count_read1 <= count_read1 + 1'b1;

 //counter which keeps track of number of packets read from fifo2
 always@(posedge clk_egress, negedge rst_n_egress)
 if(~rst_n_egress)
   count_read2 <= {default: 1'b0};
 else 
   if(read_done2)
     count_read2 <= count_read2 + 1'b1;

endmodule
