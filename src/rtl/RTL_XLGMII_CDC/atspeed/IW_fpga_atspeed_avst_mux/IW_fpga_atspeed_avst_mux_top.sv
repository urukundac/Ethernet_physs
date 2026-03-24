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
 -- Module Name       : IW_fpga_atspeed_avst_mux_top
 -- Author            : Rahul Govindan
 -- Function          : This is the top module for the avst_mux
 --------------------------------------------------------------------------
*/

`timescale 1ns / 10ps

module IW_fpga_atspeed_avst_mux_top #(
    parameter 	AVST_DATA_ING_W             = 32 
   ,parameter   FULL_WMARK_1                = 4
   ,parameter   MEMORY_DEPTH_1              = 8
   ,parameter   FULL_WMARK_2                = 4
   ,parameter   MEMORY_DEPTH_2              = 8
	 ,parameter   AGGREGATE_BW                = 0
	 ,parameter   AVST_DATA_EGR_W             = AGGREGATE_BW ? AVST_DATA_ING_W*2 : AVST_DATA_ING_W

   ,parameter   READ_MISS_VAL               = 32'hDEADBABE     // Read miss value
   ,parameter   CSR_ADDR_WIDTH              = 24
   ,parameter   CSR_DATA_WIDTH              = 32
   ,parameter   CSR_CMD_WIDTH               = 8

   ) (
    input  logic                                 clk1_ingr
   ,input  logic                                 clk2_ingr 
   ,input  logic                      	         clk_egress
   ,input  logic                                 rst1_n_ingr
   ,input  logic                                 rst2_n_ingr
   ,input  logic                                 rst_n_egress
   ,input  logic                                 avst_ing1_valid  
   ,input  logic [AVST_DATA_ING_W-1:0]           avst_ing1_data
   ,input  logic                                 avst_ing1_startofpacket
   ,input  logic                                 avst_ing1_endofpacket
   ,input  logic [$clog2(AVST_DATA_ING_W/8)-1:0] avst_ing1_empty
   ,output logic                                 avst_ing1_ready

   ,input  logic                                 avst_ing2_valid  
   ,input  logic [AVST_DATA_ING_W-1:0]           avst_ing2_data
   ,input  logic                                 avst_ing2_startofpacket
   ,input  logic                                 avst_ing2_endofpacket
   ,input  logic [$clog2(AVST_DATA_ING_W/8)-1:0] avst_ing2_empty
   ,output logic                                 avst_ing2_ready

   ,input  logic                                 avst_egr_ready
   ,output logic [AVST_DATA_EGR_W-1:0]           avst_egr_data
   ,output logic [$clog2(AVST_DATA_EGR_W/8)-1:0] avst_egr_empty
   ,output logic                                 avst_egr_startofpacket
   ,output logic                                 avst_egr_endofpacket
   ,output logic                                 avst_egr_valid
 
   ,input  logic                                 clk_csr
   ,input  logic                                 rst_csr_n
   ,input  logic                                 csr_write
   ,input  logic                                 csr_read
   ,input  logic [CSR_ADDR_WIDTH-1:0]            csr_addr
   ,input  logic [CSR_DATA_WIDTH-1:0]            csr_wr_data
   ,output logic [CSR_DATA_WIDTH-1:0]            csr_rd_data
   ,output logic                                 csr_rd_valid

   );
  
  localparam   AVST_EMPTY_W               = $clog2(AVST_DATA_ING_W/8);
  localparam   AVST_FULL_W                = AVST_DATA_ING_W+AVST_EMPTY_W+2;
  localparam   MEM_PTR_W_1                = $clog2(MEMORY_DEPTH_1); 
  localparam   COUNT_W_1                  = $clog2(MEMORY_DEPTH_1);
  localparam   MEM_PTR_W_2                = $clog2(MEMORY_DEPTH_2); 
  localparam   COUNT_W_2                  = $clog2(MEMORY_DEPTH_2);

  logic [7:0]                               count_drop1;
  logic [7:0]                               count_drop2;
  logic [7:0]                               count_read1;
  logic [7:0]                               count_read2;
  logic [COUNT_W_1:0]                       count1;
  logic [COUNT_W_2:0]                       count2;
  logic [31:0]                              data_rcvd1;
  logic [31:0]                              data_rcvd2;
  logic [7:0]                               count_drop1_gray;
  logic [7:0]                               count_drop2_gray;
  logic [31:0]                              data_rcvd1_gray;
  logic [31:0]                              data_rcvd2_gray;
  logic [7:0]                               count_drop1_syn_g;
  logic [7:0]                               count_drop2_syn_g;
  logic [31:0]                              data_rcvd1_syn_g;
  logic [31:0]                              data_rcvd2_syn_g;
  logic [7:0]                               count_drop1_syn;
  logic [7:0]                               count_drop2_syn;
  logic [31:0]                              data_rcvd1_syn;
  logic [31:0]                              data_rcvd2_syn;

  IW_fpga_atspeed_avst_mux #(
  .AVST_DATA_ING_W                         (AVST_DATA_ING_W),
	.AGGREGATE_BW                            (AGGREGATE_BW),
  .FULL_WMARK_1                            (FULL_WMARK_1),
  .FULL_WMARK_2                            (FULL_WMARK_2),
  .MEMORY_DEPTH_1                          (MEMORY_DEPTH_1),
  .MEMORY_DEPTH_2                          (MEMORY_DEPTH_2)
  ) inst_mux (
  .clk_ingr1                               (clk1_ingr),
  .clk_ingr2                               (clk2_ingr),
  .clk_egress                              (clk_egress),
  .rst_n_ingr1                             (rst1_n_ingr),
  .rst_n_ingr2                             (rst2_n_ingr),
  .rst_n_egress                            (rst_n_egress),
  .avst_ing_valid1                         (avst_ing1_valid),
  .avst_ing_data1                          (avst_ing1_data),
  .avst_ing_sop1                           (avst_ing1_startofpacket),
  .avst_ing_eop1                           (avst_ing1_endofpacket),
  .avst_ing_empty1                         (avst_ing1_empty),
  .avst_ing_ready1                         (avst_ing1_ready),
  .avst_ing_valid2                         (avst_ing2_valid),
  .avst_ing_data2                          (avst_ing2_data),
  .avst_ing_sop2                           (avst_ing2_startofpacket),
  .avst_ing_eop2                           (avst_ing2_endofpacket),
  .avst_ing_empty2                         (avst_ing2_empty),
  .avst_ing_ready2                         (avst_ing2_ready),
  .avst_egr_ready                          (avst_egr_ready),
  .avst_egr_data                           (avst_egr_data),
  .avst_egr_sop                            (avst_egr_startofpacket),
  .avst_egr_eop                            (avst_egr_endofpacket),
  .avst_egr_empty                          (avst_egr_empty),
  .avst_egr_input_valid                    (avst_egr_valid),
  .count1                                  (count1),
  .count2                                  (count2),
  .count_drop1                             (count_drop1),
  .count_drop2                             (count_drop2),
  .count_read1                             (count_read1),
  .count_read2                             (count_read2),
  .data_rcvd1                              (data_rcvd1),
  .data_rcvd2                              (data_rcvd2)
  );

  /* Synchronizing all statistical registers to egress clock domain
   * using conversion to gray, double synchronization and back to binary
   * */
  IW_bin2gray #(
  .WIDTH                                   ($bits(count_drop1))
  ) inst_bg_drop1 (
  .binary                                  (count_drop1),
  .gray                                    (count_drop1_gray)
  );

  IW_bin2gray #(
  .WIDTH                                   ($bits(count_drop2))
  ) inst_bg_drop2 (
  .binary                                  (count_drop2),
  .gray                                    (count_drop2_gray)
  );

  IW_bin2gray #(
  .WIDTH                                   ($bits(data_rcvd1))
  ) inst_bg_data_rcvd1 (
  .binary                                  (data_rcvd1),
  .gray                                    (data_rcvd1_gray)
  );
 
  IW_bin2gray #(
  .WIDTH                                   ($bits(data_rcvd2))
  ) inst_bg_data_rcvd2 (
  .binary                                  (data_rcvd2),
  .gray                                    (data_rcvd2_gray)
  );
 
 IW_fpga_double_sync #(
  .WIDTH                                   ($bits(count_drop1_gray)),
  .NUM_STAGES                              (2)
  ) inst_syn_drop1 (
  .clk                                     (clk_egress),
  .sig_in                                  (count_drop1_gray),
  .sig_out                                 (count_drop1_syn_g)
  );

 IW_fpga_double_sync #(
  .WIDTH                                   ($bits(count_drop2_gray)),
  .NUM_STAGES                              (2)
  ) inst_syn_drop2 (
  .clk                                     (clk_egress),
  .sig_in                                  (count_drop2_gray),
  .sig_out                                 (count_drop2_syn_g)
  );

 IW_fpga_double_sync #(
  .WIDTH                                   ($bits(data_rcvd1_gray)),
  .NUM_STAGES                              (2)
  ) inst_syn_data_rcvd1 (
  .clk                                     (clk_egress),
  .sig_in                                  (data_rcvd1_gray),
  .sig_out                                 (data_rcvd1_syn_g)
  );

 IW_fpga_double_sync #(
  .WIDTH                                   ($bits(data_rcvd2_gray)),
  .NUM_STAGES                              (2)
  ) inst_syn_data_rcvd2 (
  .clk                                     (clk_egress),
  .sig_in                                  (data_rcvd2_gray),
  .sig_out                                 (data_rcvd2_syn_g)
  );

  IW_gray2bin #(
  .WIDTH                                   ($bits(count_drop1_syn))
  ) inst_gb_drop1 (
  .binary                                  (count_drop1_syn),
  .gray                                    (count_drop1_syn_g)
  );

  IW_gray2bin #(
  .WIDTH                                   ($bits(count_drop2_syn))
  ) inst_gb_drop2 (
  .binary                                  (count_drop2_syn),
  .gray                                    (count_drop2_syn_g)
  );

  IW_gray2bin #(
  .WIDTH                                   ($bits(data_rcvd1_syn))
  ) inst_gb_data_rcvd1 (
  .binary                                  (data_rcvd1_syn),
  .gray                                    (data_rcvd1_syn_g)
  );

  IW_gray2bin #(
  .WIDTH                                   ($bits(data_rcvd2_syn))
  ) inst_gb_data_rcvd2 (
  .binary                                  (data_rcvd2_syn),
  .gray                                    (data_rcvd2_syn_g)
  );

  /* Instantiation of CSR wrapper module
   */
  IW_fpga_atspeed_avst_mux_addr_map_csr_wrapper #(
  .INSTANCE_NAME                           ("u_avst_mux"),
  .AVST_DATA_ING_W                         (AVST_DATA_ING_W),
  .FULL_WMARK_1                            (FULL_WMARK_1),
  .MEMORY_DEPTH_1                          (MEMORY_DEPTH_1),
  .FULL_WMARK_2                            (FULL_WMARK_2),
  .MEMORY_DEPTH_2                          (MEMORY_DEPTH_2),
	.AGGREGATE_BW                            (AGGREGATE_BW),
  .READ_MISS_VAL                           (READ_MISS_VAL),
  .CSR_ADDR_WIDTH                          (CSR_ADDR_WIDTH),
  .CSR_DATA_WIDTH                          (CSR_DATA_WIDTH)
  ) inst1 (
  .clk_logic                               (clk_egress),
  .pkts_transmitted_1                      (count_read1),
  .pkts_transmitted_2                      (count_read2),
  .pkts_inFIFO_1                           (count1),
  .pkts_inFIFO_2                           (count2),
  .pkts_dropped_1                          (count_drop1_syn),
  .pkts_dropped_2                          (count_drop2_syn),
  .data_rcvd_1                             (data_rcvd1_syn),
  .data_rcvd_2                             (data_rcvd2_syn),
  .clk_csr                                 (clk_csr),
  .rst_csr_n                               (rst_csr_n),
  .csr_write                               (csr_write),
  .csr_read                                (csr_read),
  .csr_addr                                (csr_addr),
  .csr_wr_data                             (csr_wr_data),
  .csr_rd_data                             (csr_rd_data),
  .csr_rd_valid                            (csr_rd_valid)

  );

endmodule
