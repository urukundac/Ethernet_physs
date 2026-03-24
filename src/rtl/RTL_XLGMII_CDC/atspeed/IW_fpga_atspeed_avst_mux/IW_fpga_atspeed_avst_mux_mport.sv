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
 --------------------------------------------------------------------------
 -- Project Code      : Atspeed
 -- Module Name       : IW_fpga_atspeed_avst_mux_mport
 -- Author            : Rahul Govindan
 -- Associated modules: 
 -- Function          : N X 1 general Mux top file
 --------------------------------------------------------------------------
*/

`timescale 1ns / 10ps

module IW_fpga_atspeed_avst_mux_mport #(
    parameter   AVST_DATA_ING_W                               = 32 
   ,parameter   AVST_SYMBOL_W                                 = 8
   ,parameter   AGGREGATE_BW                                  = 0
   ,parameter   AVST_DATA_EGR_W                               = AGGREGATE_BW ? 512 : AVST_DATA_ING_W

   ,parameter   AVST_EMPTY_ING_W                              = (AVST_DATA_ING_W <= AVST_SYMBOL_W) ? 1 
                                                               : $clog2(AVST_DATA_ING_W/AVST_SYMBOL_W)
   ,parameter   AVST_EMPTY_EGR_W                              = (AVST_DATA_EGR_W <= AVST_SYMBOL_W) ? 1 
                                                               : $clog2(AVST_DATA_EGR_W/AVST_SYMBOL_W)
                // the avst_mux only supports data width 32 bits
   
   ,parameter   NUM_PORTS                                      = 4
   ,parameter   FULL_WMARK                                     = 4
   ,parameter   MEMORY_DEPTH                                   = 1024
   ,parameter   READ_MISS_VAL                                  = 32'hDEADBABE
                // Read miss value
   ,parameter   INFRA_AVST_CHNNL_W                             = 8
   ,parameter   INFRA_AVST_DATA_W                              = 8
   ,parameter   INFRA_AVST_CHNNL_ID                            = 8
   
   ,parameter   CSR_ADDR_WIDTH                                 = 24
   ,parameter   CSR_DATA_WIDTH                                 = 32

   )  (
    input  logic [NUM_PORTS-1:0]                            clk_ingr
   ,input  logic                                            clk_egress
   ,input  logic [NUM_PORTS-1:0]                            rst_n_ingr
   ,input  logic                                            rst_n_egress
   ,input  logic [NUM_PORTS-1:0]                            avst_ing_valid
   ,input  logic [NUM_PORTS-1:0] [AVST_DATA_ING_W-1:0]      avst_ing_data
   ,input  logic [NUM_PORTS-1:0]                            avst_ing_startofpacket
   ,input  logic [NUM_PORTS-1:0]                            avst_ing_endofpacket
   ,input  logic [NUM_PORTS-1:0] [AVST_EMPTY_ING_W-1:0]     avst_ing_empty
   ,output logic [NUM_PORTS-1:0]                            avst_ing_ready

   ,input  logic                                            avst_egr_ready
   ,output logic [AVST_DATA_EGR_W-1:0]                      avst_egr_data
   ,output logic [AVST_EMPTY_EGR_W-1:0]                     avst_egr_empty
   ,output logic                                            avst_egr_startofpacket
   ,output logic                                            avst_egr_endofpacket
   ,output logic                                            avst_egr_valid
 
  // Infra-Avst Ports
   ,input  logic                                            clk_avst
   ,input  logic                                            rst_avst_n
   ,output logic                                            avst_rng_ingr_ready
   ,input  logic                                            avst_rng_ingr_valid
   ,input  logic                                            avst_rng_ingr_startofpacket
   ,input  logic                                            avst_rng_ingr_endofpacket
   ,input  logic [INFRA_AVST_CHNNL_W-1:0]                   avst_rng_ingr_channel
   ,input  logic [INFRA_AVST_DATA_W-1:0]                    avst_rng_ingr_data
   ,input  logic                                            avst_rng_egr_ready
   ,output logic                                            avst_rng_egr_valid
   ,output logic                                            avst_rng_egr_startofpacket
   ,output logic                                            avst_rng_egr_endofpacket
   ,output logic [INFRA_AVST_CHNNL_W-1:0]                   avst_rng_egr_channel
   ,output logic [INFRA_AVST_DATA_W-1:0]                    avst_rng_egr_data

   );
 
  localparam   NUM_STAGES                                  = $clog2(NUM_PORTS);
  localparam   NUM_ARCH_PORTS                              = (AGGREGATE_BW == 0) ? NUM_PORTS :
                                                               (NUM_PORTS <= AVST_DATA_EGR_W/AVST_DATA_ING_W)   ?  AVST_DATA_EGR_W/AVST_DATA_ING_W :
                                                                 2 ** $clog2(NUM_PORTS);
  localparam   NUM_ARCH_STAGES                             = (AGGREGATE_BW == 0) ? NUM_STAGES :
                                                                 $clog2(NUM_ARCH_PORTS);

  logic [NUM_ARCH_STAGES:0] [NUM_ARCH_PORTS-1:0]                          avst_line_startofpacket;
  logic [NUM_ARCH_STAGES:0] [NUM_ARCH_PORTS-1:0]                          avst_line_valid;
  logic [NUM_ARCH_STAGES:0] [NUM_ARCH_PORTS-1:0]                          avst_line_ready;
  logic [NUM_ARCH_STAGES:0] [NUM_ARCH_PORTS-1:0]                          avst_line_endofpacket;  
  logic [NUM_ARCH_STAGES:0] [NUM_ARCH_PORTS-1:0]                          clk_line_ingr;
  logic [NUM_ARCH_STAGES:0] [NUM_ARCH_PORTS-1:0]                          rst_line_ingr;
  logic [NUM_ARCH_STAGES:0] [NUM_ARCH_PORTS-1:0] [AVST_DATA_EGR_W-1:0]    avst_line_data;
  logic [NUM_ARCH_STAGES:0] [NUM_ARCH_PORTS-1:0] [AVST_EMPTY_EGR_W-1:0]   avst_line_empty;

  logic                                                     clk_csr;
  logic                                                     rst_csr_n;
  logic                                                     csr_write;
  logic                                                     csr_read;
  logic [(3*INFRA_AVST_CHNNL_W)-1:0]                        csr_addr;
  logic [(4*INFRA_AVST_DATA_W)-1:0]                         csr_wr_data;
  logic [(4*INFRA_AVST_DATA_W)-1:0]                         csr_rd_data;
  logic                                                     csr_rd_valid;

  localparam  NUM_CSR_SUBMODS                               = NUM_ARCH_PORTS -1;
  localparam  CSR_SUBMOD_ADDR_WIDTH                         = CSR_ADDR_WIDTH-8;
  localparam  CSR_SUBMOD_DATA_WIDTH                         = CSR_DATA_WIDTH;
  localparam  CSR_CMD_WIDTH                                 = 8;

  //Split CSR Bus signals
  logic [NUM_CSR_SUBMODS-1:0]                               csr_submod_write;
  logic [NUM_CSR_SUBMODS-1:0]                               csr_submod_read;
  logic [CSR_SUBMOD_ADDR_WIDTH-1:0]                         csr_submod_addr    [NUM_CSR_SUBMODS-1:0];
  logic [CSR_SUBMOD_DATA_WIDTH-1:0]                         csr_submod_wr_data [NUM_CSR_SUBMODS-1:0];
  logic [CSR_SUBMOD_DATA_WIDTH-1:0]                         csr_submod_rd_data [NUM_CSR_SUBMODS-1:0];
  logic [NUM_CSR_SUBMODS-1:0]                               csr_submod_rd_valid;

//********************************************************************************
// Function to calculate the number of ports at each level/stage
// For example, if the number of ports is 5 : stage 0 will have 5 ports,
// stage 1 will have 3 ports, stage 2 will have 2 ports : due to 2:1 mux
//********************************************************************************
function automatic int stage_ports(int stage_num, int total_ports);
  integer stage_ports_num;
  for(int itr = 0; itr <= stage_num; itr++) begin
    if(itr == 0)
      stage_ports_num = total_ports;  
    else
      if(stage_ports_num % 2)
        stage_ports_num = (stage_ports_num + 1) / 2;
      else
        stage_ports_num = stage_ports_num / 2;
  end
  stage_ports = stage_ports_num;
endfunction
  
//********************************************************************************
// Function to calculate the MUX number index at each stage
// For example, if the number of ports is 5: stage 0 will have mux index 0
// stage 1 will have 2, stage 2 will have 3. Number of muxes is always, 1 less
// than total number of input ports
//********************************************************************************
function automatic int cumulative_mux(int stage_num, int total_ports);
  integer cumulative_mux_num;
  integer stage_ports;

  for(int itr = 0; itr <= stage_num; itr++)
    if(itr == 0) begin
      cumulative_mux_num = 0;
      stage_ports = total_ports;  
    end else begin
      cumulative_mux_num = cumulative_mux_num + stage_ports / 2; 
      if(stage_ports % 2)
        stage_ports = (stage_ports + 1) / 2;
      else
        stage_ports = stage_ports / 2;
  end
  cumulative_mux = cumulative_mux_num;   
endfunction 

//********************************************************************************
// define statement that takes care of instantiation of components
//********************************************************************************
`define inst_IW_fpga_atspeed_passthrough(stage_no, mux_no)                                \
  IW_fpga_atspeed_passthrough #(                                                          \
   .AVST_DATA_W                 (AVST_DATA_ING_W)                                         \
  ,.AVST_SYMBOL_W               (AVST_SYMBOL_W)                                           \
 ) inst_atspeed_passthrough (                                                             \
   .avst_line_startofpacket_in      (avst_line_startofpacket[``stage_no][``mux_no``*2])   \
  ,.avst_line_endofpacket_in        (avst_line_endofpacket[``stage_no][``mux_no``*2])     \
  ,.avst_line_data_in               (avst_line_data[``stage_no][``mux_no``*2])            \
  ,.avst_line_empty_in              (avst_line_empty[``stage_no][``mux_no``*2])           \
  ,.avst_line_valid_in              (avst_line_valid[``stage_no][``mux_no``*2])           \
  \
  , .avst_line_startofpacket_out    (avst_line_startofpacket[``stage_no``+1][``mux_no])   \
  , .avst_line_endofpacket_out      (avst_line_endofpacket[``stage_no``+1][``mux_no])     \
  , .avst_line_data_out             (avst_line_data[``stage_no``+1][``mux_no])            \
  , .avst_line_empty_out            (avst_line_empty[``stage_no``+1][``mux_no])           \
  , .avst_line_valid_out            (avst_line_valid[``stage_no``+1][``mux_no])           \
);

//********************************************************************************
// define statement that takes care of instantiation of components
//********************************************************************************
  `define inst_avst_mux_top(mux_no, stage_no, output_port_no, ing_data_w, aggregate)\
    IW_fpga_atspeed_avst_mux_top #(                                               \
      .AVST_DATA_ING_W             (``ing_data_w),                                \
      .FULL_WMARK_1                (FULL_WMARK),                                  \
      .MEMORY_DEPTH_1              (MEMORY_DEPTH),                                \
      .FULL_WMARK_2                (FULL_WMARK),                                  \
      .MEMORY_DEPTH_2              (MEMORY_DEPTH),                                \
      .AGGREGATE_BW                (``aggregate),                                 \
      .READ_MISS_VAL               (READ_MISS_VAL),                               \
      .CSR_ADDR_WIDTH              (CSR_SUBMOD_ADDR_WIDTH),                       \
      .CSR_DATA_WIDTH              (CSR_SUBMOD_DATA_WIDTH),                       \
      .CSR_CMD_WIDTH               (CSR_CMD_WIDTH)                                \
    ) inst_mux_top ( \
      .clk1_ingr                   (clk_line_ingr [``stage_no] [``output_port_no``*2]),           \
      .clk2_ingr                   (clk_line_ingr [``stage_no] [``output_port_no``*2+1]),         \
      .clk_egress                  (clk_line_ingr [``stage_no``+1][``output_port_no]),            \
      .rst1_n_ingr                 (rst_line_ingr [``stage_no] [``output_port_no``*2]),           \
      .rst2_n_ingr                 (rst_line_ingr [``stage_no] [``output_port_no``*2+1]),         \
      .rst_n_egress                (rst_line_ingr [``stage_no``+1][``output_port_no]),            \
      \
      .avst_ing1_valid             (avst_line_valid[``stage_no``][``output_port_no``*2]),         \
      .avst_ing1_data              (avst_line_data [``stage_no``][``output_port_no``*2]),         \
      .avst_ing1_startofpacket     (avst_line_startofpacket  [``stage_no``][``output_port_no``*2]), \
      .avst_ing1_endofpacket       (avst_line_endofpacket  [``stage_no``][``output_port_no``*2]), \
      .avst_ing1_empty             (avst_line_empty[``stage_no``][``output_port_no``*2]),         \
      .avst_ing1_ready             (avst_line_ready[``stage_no``][``output_port_no``*2]),         \
      .avst_ing2_valid             (avst_line_valid[``stage_no``][``output_port_no``*2 +1]),      \
      .avst_ing2_data              (avst_line_data [``stage_no``][``output_port_no``*2 +1]),      \
      .avst_ing2_startofpacket     (avst_line_startofpacket  [``stage_no``][``output_port_no``*2 +1]), \
      .avst_ing2_endofpacket       (avst_line_endofpacket  [``stage_no``][``output_port_no``*2 +1]), \
      .avst_ing2_empty             (avst_line_empty[``stage_no``][``output_port_no``*2 +1]),      \
      .avst_ing2_ready             (avst_line_ready[``stage_no``][``output_port_no``*2 +1]),      \
      .avst_egr_ready              (avst_line_ready[``stage_no``+1][``output_port_no]),           \
      .avst_egr_data               (avst_line_data[``stage_no``+1][``output_port_no]),            \
      .avst_egr_empty              (avst_line_empty[``stage_no``+1][``output_port_no]),           \
      .avst_egr_startofpacket      (avst_line_startofpacket[``stage_no``+1][``output_port_no]),   \
      .avst_egr_endofpacket        (avst_line_endofpacket[``stage_no``+1][``output_port_no]),     \
      .avst_egr_valid              (avst_line_valid[``stage_no``+1][``output_port_no]),           \
      \
      .clk_csr                     (clk_csr),                                                     \
      .rst_csr_n                   (rst_csr_n),                                                   \
      .csr_write                   (csr_submod_write[``mux_no]),                                  \
      .csr_read                    (csr_submod_read[``mux_no]),                                   \
      .csr_addr                    (csr_submod_addr[``mux_no]),                                   \
      .csr_wr_data                 (csr_submod_wr_data[``mux_no]),                                \
      .csr_rd_data                 (csr_submod_rd_data[``mux_no]),                                \
      .csr_rd_valid                (csr_submod_rd_valid[``mux_no])                                \
      \
    ); 
//********************************************************************************
//connecting the first level of inputs/outputs to local wires
//********************************************************************************
  assign clk_csr = clk_avst;
  assign rst_csr_n = rst_avst_n;

  genvar itrs;
  for( itrs=0; itrs<NUM_ARCH_PORTS; itrs++ ) begin : first_stage_gen
    if(AGGREGATE_BW == 0) begin
      assign clk_line_ingr   [0][itrs]             = clk_ingr      [itrs];
      assign rst_line_ingr   [0][itrs]             = rst_n_ingr    [itrs];

      assign avst_line_startofpacket [0][itrs]     = avst_ing_startofpacket[itrs];
      assign avst_line_endofpacket   [0][itrs]     = avst_ing_endofpacket  [itrs];
      assign avst_line_empty [0][itrs]             = avst_ing_empty[itrs];
      assign avst_line_data  [0][itrs]             = avst_ing_data [itrs];
      assign avst_line_valid [0][itrs]             = avst_ing_valid[itrs];

      assign avst_ing_ready  [itrs]                = avst_line_ready[0][itrs];//output 
    end else begin // Aggregate BW
      if( itrs < NUM_PORTS ) begin
        assign clk_line_ingr   [0][itrs]           = clk_ingr      [itrs];
        assign rst_line_ingr   [0][itrs]           = rst_n_ingr    [itrs];

        assign avst_line_startofpacket [0][itrs]   = avst_ing_startofpacket[itrs];
        assign avst_line_endofpacket   [0][itrs]   = avst_ing_endofpacket  [itrs];
        assign avst_line_empty [0][itrs]           = {{(AVST_EMPTY_EGR_W-AVST_EMPTY_ING_W){1'b0}},
                                                      avst_ing_empty[itrs]};
        assign avst_line_data  [0][itrs]           = {{(AVST_DATA_EGR_W-AVST_DATA_ING_W){1'b0}},
                                                      avst_ing_data [itrs]};
        assign avst_line_valid [0][itrs]           = avst_ing_valid[itrs];

        assign avst_ing_ready  [itrs]              = avst_line_ready[0][itrs];//output 
      end else begin
        assign clk_line_ingr   [0][itrs]           = clk_ingr      [0];
        assign rst_line_ingr   [0][itrs]           = rst_n_ingr    [0];

        assign avst_line_startofpacket [0][itrs]   = 1'b0;
        assign avst_line_endofpacket   [0][itrs]   = 1'b0;
        assign avst_line_empty [0][itrs]           = {default : 1'b0};
        assign avst_line_data  [0][itrs]           = {default : 1'b0};
        assign avst_line_valid [0][itrs]           = 1'b0;

      end
    end
  end //first_stage_gen

//********************************************************************************
// Instantiate 2:1 MUXes as required. If the number of ports is not a multiple
// of 2, that signal is carried forward. A MUX output is always at egress
// clock
//********************************************************************************
  genvar itr_i; //refers to the stage number
  genvar itr_j; //refers to the output port number
                //corresponding input port numbers are output_port_no*2 and output_port_no*2+1 
`ifndef CORETOOLS
  if(AGGREGATE_BW == 0) begin
    for( itr_i = 0; itr_i < NUM_ARCH_STAGES; itr_i++ ) begin : gen_stages
      for( itr_j = 0; itr_j <= stage_ports(itr_i,NUM_ARCH_PORTS)/2; itr_j++ ) begin :gen_muxes
        if(itr_j < stage_ports(itr_i,NUM_ARCH_PORTS)/2) begin
            `inst_avst_mux_top(cumulative_mux(itr_i,NUM_ARCH_PORTS)+itr_j, itr_i, itr_j, AVST_DATA_ING_W, 0)

          assign  clk_line_ingr  [itr_i+1][itr_j] = clk_egress;
          assign  rst_line_ingr  [itr_i+1][itr_j] = rst_n_egress;
        end else begin
          if(stage_ports(itr_i,NUM_ARCH_PORTS)%2 ) //Check for leftover wires in previous step
            begin
           `inst_IW_fpga_atspeed_passthrough(itr_i, itr_j)
          
              assign  avst_line_ready[itr_i][itr_j*2] = avst_line_ready[itr_i+1][itr_j];
    
              assign  clk_line_ingr  [itr_i+1][itr_j] = clk_line_ingr  [itr_i][itr_j*2];
              assign  rst_line_ingr  [itr_i+1][itr_j] = rst_line_ingr  [itr_i][itr_j*2];
          end
        end // else
      end //end of itr_j
    end  //end of itr_i
  end else begin // AGGREGATE_BW = 1
    for( itr_i = 0; itr_i < NUM_ARCH_STAGES; itr_i++ ) begin : gen_stages
      for( itr_j = 0; itr_j < stage_ports(itr_i,NUM_ARCH_PORTS)/2; itr_j++ ) begin :gen_muxes
        if(itr_i < 4)
            `inst_avst_mux_top(cumulative_mux(itr_i,NUM_ARCH_PORTS)+itr_j, itr_i, itr_j,  
                (AVST_DATA_ING_W * 2 **itr_i), 1)
        else
            `inst_avst_mux_top(cumulative_mux(itr_i,NUM_ARCH_PORTS)+itr_j, itr_i, itr_j,  
                512, 0)
          assign  clk_line_ingr  [itr_i+1][itr_j] = clk_egress;
          assign  rst_line_ingr  [itr_i+1][itr_j] = rst_n_egress;
      end //end of itr_j
    end  //end of itr_i
  end
`endif

//********************************************************************************
//assigning the egress ports with the wires of the last stage
//********************************************************************************
  assign avst_line_ready[NUM_ARCH_STAGES][0] = avst_egr_ready;
  assign avst_egr_data                  = avst_line_data [NUM_ARCH_STAGES][0];
  assign avst_egr_startofpacket         = avst_line_startofpacket[NUM_ARCH_STAGES][0];
  assign avst_egr_endofpacket           = avst_line_endofpacket  [NUM_ARCH_STAGES][0];
  assign avst_egr_empty                 = avst_line_empty[NUM_ARCH_STAGES][0];
  assign avst_egr_valid                 = avst_line_valid[NUM_ARCH_STAGES][0];

  `undef inst_avst_mux_top
  `undef inst_IW_fpga_atspeed_passthrough

/* AVST2CSR instance  */
IW_fpga_avst2csr #(
      .AVST_CHANNEL_ID      (INFRA_AVST_CHNNL_ID)
     ,.AVST_CHANNEL_WIDTH   (INFRA_AVST_CHNNL_W)
     ,.AVST_DATA_WIDTH      (INFRA_AVST_DATA_W)
     ,.CSR_ADDR_WIDTH       (CSR_ADDR_WIDTH)
     ,.CSR_DATA_WIDTH       (CSR_DATA_WIDTH)
     ,.CMD_WIDTH            (1*INFRA_AVST_DATA_W)
   ) mux_multi_block_avst2csr (
     .clk_avst              (clk_avst                    )
    ,.rst_avst_n            (rst_avst_n                  )
    ,.avst_ingr_ready       (avst_rng_ingr_ready         )
    ,.avst_ingr_valid       (avst_rng_ingr_valid         )
    ,.avst_ingr_sop         (avst_rng_ingr_startofpacket )
    ,.avst_ingr_eop         (avst_rng_ingr_endofpacket   )
    ,.avst_ingr_channel     (avst_rng_ingr_channel       )
    ,.avst_ingr_data        (avst_rng_ingr_data          )
    ,.avst_egr_ready        (avst_rng_egr_ready          )
    ,.avst_egr_valid        (avst_rng_egr_valid          )
    ,.avst_egr_sop          (avst_rng_egr_startofpacket  )
    ,.avst_egr_eop          (avst_rng_egr_endofpacket    )
    ,.avst_egr_channel      (avst_rng_egr_channel        )
    ,.avst_egr_data         (avst_rng_egr_data           )
    ,.clk_csr               (clk_csr                     )
    ,.rst_csr_n             (rst_csr_n                   )
    ,.csr_write             (csr_write                   )
    ,.csr_read              (csr_read                    )
    ,.csr_addr              (csr_addr                    )
    ,.csr_wr_data           (csr_wr_data                 )
    ,.csr_rd_data           (csr_rd_data                 )
    ,.csr_rd_valid          (csr_rd_valid                )
   );

 /* CSR splitter instance */
   IW_fpga_csr_splitter #(
      .CSR_DATA_WIDTH            (CSR_DATA_WIDTH )
     ,.CSR_ADDR_WIDTH            (CSR_ADDR_WIDTH )
     ,.NUM_CSR_SUBMODULES        (NUM_CSR_SUBMODS )
     ,.CSR_SUBMODULE_DATA_WIDTH  (CSR_SUBMOD_DATA_WIDTH )
     ,.CSR_SUBMODULE_ADDR_WIDTH  (CSR_SUBMOD_ADDR_WIDTH )
     ,.PIPELINE_REQS             (1 )
     ,.PIPELINE_RSPS             (1 )
   ) u_IW_fpga_csr_splitter(
      .clk_csr                 (clk_csr)
     ,.rst_csr_n               (rst_csr_n)
     ,.csr_write               (csr_write)
     ,.csr_read                (csr_read)
     ,.csr_addr                (csr_addr)
     ,.csr_wr_data             (csr_wr_data)
     ,.csr_rd_data             (csr_rd_data)
     ,.csr_rd_valid            (csr_rd_valid)

     ,.csr_submodule_write     (csr_submod_write         )
     ,.csr_submodule_read      (csr_submod_read          )
     ,.csr_submodule_addr      (csr_submod_addr          )
     ,.csr_submodule_wr_data   (csr_submod_wr_data       )
     ,.csr_submodule_rd_data   (csr_submod_rd_data       )
     ,.csr_submodule_rd_valid  (csr_submod_rd_valid      )
   );

endmodule

//---------------------------------------------------------------------------
// This pass through module is created to overcome a VCS error that doesnt
// allow part of data array to be driven by assign and part through module
//---------------------------------------------------------------------------
module IW_fpga_atspeed_passthrough #(
    parameter   AVST_DATA_W                                   = 32 
   ,parameter   AVST_SYMBOL_W                                 = 8
   ,parameter   AVST_EMPTY_W                                  = (AVST_DATA_W <= AVST_SYMBOL_W) ? 1 
                                                               : $clog2(AVST_DATA_W/AVST_SYMBOL_W)
                // the avst_mux only supports data width 32 bits
 )(
   input logic                     avst_line_startofpacket_in
  ,input logic                     avst_line_endofpacket_in
  ,input logic [AVST_DATA_W-1:0]   avst_line_data_in
  ,input logic [AVST_EMPTY_W-1:0]  avst_line_empty_in
  ,input logic                     avst_line_valid_in
  
  ,output logic                    avst_line_startofpacket_out
  ,output logic                    avst_line_endofpacket_out
  ,output logic [AVST_DATA_W-1:0]  avst_line_data_out
  ,output logic [AVST_EMPTY_W-1:0] avst_line_empty_out
  ,output logic                    avst_line_valid_out
);

  assign avst_line_startofpacket_out = avst_line_startofpacket_in;
  assign avst_line_endofpacket_out   = avst_line_endofpacket_in;
  assign avst_line_data_out          = avst_line_data_in;
  assign avst_line_empty_out         = avst_line_empty_in;
  assign avst_line_valid_out         = avst_line_valid_in;
  
endmodule
