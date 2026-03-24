//----------------------------------------------------------------------------------------------------------------
//                               INTEL CONFIDENTIAL
//           Copyright 2013-2014 Intel Corporation All Rights Reserved. 
// 
// The source code contained or described herein and all documents related to the source code ("Material")
// are owned by Intel Corporation or its suppliers or licensors. Title to the Material remains with Intel
// Corporation or its suppliers and licensors. The Material contains trade secrets and proprietary and confidential
// information of Intel or its suppliers and licensors. The Material is protected by worldwide copyright and trade
// secret laws and treaty provisions. No part of the Material may be used, copied, reproduced, modified, published,
// uploaded, posted, transmitted, distributed, or disclosed in any way without Intel's prior express written
// permission.
// 
// No license under any patent, copyright, trade secret or other intellectual property right is granted to or
// conferred upon you by disclosure or delivery of the Materials, either expressly, by implication, inducement,
// estoppel or otherwise. Any license under such intellectual property rights must be express and approved by
// Intel in writing.
//----------------------------------------------------------------------------------------------------------------


`timescale 1ns/1ps

`include  "iosf_sb_jem_tracker.vh"

module IW_fpga_iosf_sb_mon_addr_map_avmm_wrapper #(
    parameter MON_TYPE            = "sbr"              //Should be either pmsb or gpsb
  , parameter INSTANCE_NAME       = "u_iosf_sb_mon"     //Can hold upto 16 ASCII characters
  , parameter PAYLOAD_WIDTH       = 8                   //Width of payload
  , parameter MODE                = "standalone"        //Either 'standalone' or 'avl' mode
  , parameter CAP_RECORD_W        = 180                 //Width of struct being FiFod
  , parameter CAP_FF_DATA_W       = 35
  , parameter CAP_FF_DEPTH        = 10
  , parameter CAP_FF_USED_W       = 10

  , parameter AV_MM_ADDR_W        = 8                     // Address width
  , parameter AV_MM_DATA_W        = 32                    // Data width
  , parameter READ_MISS_VAL       = 32'hDEADBABE          // Read miss value
) (

  input  wire [AV_MM_ADDR_W-1:0]     avl_mm_address,          // avl_mm.address
  output reg  [AV_MM_DATA_W-1:0]     avl_mm_readdata,         //       .readdata
  input  wire                        avl_mm_read,             //       .read
  output reg                         avl_mm_readdatavalid,    //       .readdatavalid
  input  wire                        avl_mm_write,            //       .write
  input  wire [AV_MM_DATA_W-1:0]     avl_mm_writedata,        //       .writedata
  input  wire [(AV_MM_DATA_W/8)-1:0] avl_mm_byteenable,       //       .byteenable
  output wire                        avl_mm_waitrequest,      //       .waitrequest
  input  wire                        csi_clk,                 // csi.clk
  input  wire                        rsi_reset,               // rsi.reset

  input  wire                        clk_logic

  /*  Statistics  */
  , input   logic  [15:0]               num_mmsg_np_pkts
  , input   logic  [15:0]               num_mmsg_pc_pkts
  , input   logic  [15:0]               num_mmsg_np_beats
  , input   logic  [15:0]               num_mmsg_pc_beats
  , input   logic  [15:0]               num_mmsg_dropped_pkts
  , input   logic  [15:0]               num_tmsg_np_pkts
  , input   logic  [15:0]               num_tmsg_pc_pkts
  , input   logic  [15:0]               num_tmsg_np_beats
  , input   logic  [15:0]               num_tmsg_pc_beats
  , input   logic  [15:0]               num_tmsg_dropped_pkts

  /*  This interface to CAP FF Read port will be used only in standalone mode */
  , input   logic                       tmsg_cap_rdata_valid
  , input   logic [CAP_FF_DATA_W-1:0]   tmsg_cap_rdata
  , input   logic [CAP_FF_USED_W-1:0]   tmsg_cap_rdused
  , output  logic                       tmsg_cap_rden

  , input   logic                       mmsg_cap_rdata_valid
  , input   logic [CAP_FF_DATA_W-1:0]   mmsg_cap_rdata
  , input   logic [CAP_FF_USED_W-1:0]   mmsg_cap_rdused
  , output  logic                       mmsg_cap_rden

  /*  IOSF-SB Bus */
  , input   logic                       iosfsb_MNPPUT
  , input   logic                       iosfsb_MPCPUT
  , input   logic                       iosfsb_MNPCUP
  , input   logic                       iosfsb_MPCCUP
  , input   logic                       iosfsb_MEOM
  , input   logic  [PAYLOAD_WIDTH-1:0]  iosfsb_MPAYLOAD
  , input   logic                       iosfsb_TNPPUT
  , input   logic                       iosfsb_TPCPUT
  , input   logic                       iosfsb_TNPCUP
  , input   logic                       iosfsb_TPCCUP
  , input   logic                       iosfsb_TEOM
  , input   logic  [PAYLOAD_WIDTH-1:0]  iosfsb_TPAYLOAD
  , input   logic  [2:0]                iosfsb_SIDE_ISM_AGENT
  , input   logic  [2:0]                iosfsb_SIDE_ISM_FABRIC



  , output  logic                       mon_enable
  , output  logic                       clr_stats
  , output  logic                       flush_cap_ff
  , output  logic                       rec_ordering_en
  , output  t_iosf_sb_jem_req           tmsg_mask_en
  , output  t_iosf_sb_jem_req           tmsg_mask_value
  , output  t_iosf_sb_jem_req           mmsg_mask_en
  , output  t_iosf_sb_jem_req           mmsg_mask_value
);

  import IW_fpga_iosf_sb_mon_av_addr_map_pkg::*;
  //import rtlgen_pkg_v12::*;
  import rtlgen_pkg_IW_fpga_iosf_sb_mon_av_addr_map::*;

  // Internal Parameters 

  //AV_MM_ADDR_W is offset address width and HIGH_ADDR_W is base address width for
  //this module.
  localparam HIGH_ADDR_W   = 48-AV_MM_ADDR_W;

  localparam  INTERNAL_ADDR_W   = 8;
  localparam  REQ_DATA_W        = 1+AV_MM_ADDR_W+AV_MM_DATA_W+(AV_MM_DATA_W/8);

  localparam  RSP_DATA_W        = AV_MM_DATA_W;

  localparam  REQ_FF_W          = (REQ_DATA_W <=  32) ? 32  :
                                  (REQ_DATA_W <=  64) ? 64  :
                                  (REQ_DATA_W <=  96) ? 96  : 1;

  localparam  RSP_FF_W          = (RSP_DATA_W <=  32) ? 32  :
                                  (RSP_DATA_W <=  64) ? 64  :
                                  (RSP_DATA_W <=  96) ? 96  : 1;

  localparam  CAP_SLICE_RESIDUE = (CAP_FF_DATA_W  % AV_MM_ADDR_W);
  localparam  NUM_SLICES_PER_CAP= (CAP_SLICE_RESIDUE  > 0)  ? (CAP_FF_DATA_W  / AV_MM_DATA_W) + 1
                                                            : (CAP_FF_DATA_W  / AV_MM_DATA_W);


  reg   [0:3] [7:0] sbr_type_str  = MON_TYPE;
  reg   [0:15][7:0] inst_name_str = INSTANCE_NAME;

  // Internal Signals  
  genvar  i;
  integer n;
  reg   [0:3] [7:0] sbr_type_str  = MON_TYPE;
  reg   [0:15][7:0] inst_name_str = INSTANCE_NAME;

  wire                        req_ff_full;
  wire                        req_ff_wren;
  wire  [REQ_FF_W-1:0]        req_ff_wdata;
  wire                        req_ff_empty;
  wire                        req_ff_rden;
  wire  [REQ_FF_W-1:0]        req_ff_rdata;

  wire                        rsp_ff_full;
  wire                        rsp_ff_wren;
  wire  [RSP_FF_W-1:0]        rsp_ff_wdata;
  wire                        rsp_ff_empty;
  wire                        rsp_ff_rden;
  wire  [RSP_FF_W-1:0]        rsp_ff_rdata;

  wire                        csr2logic_wren;
  wire                        csr2logic_rden;
  wire  [AV_MM_ADDR_W-1:0]    csr2logic_addr;
  wire  [AV_MM_DATA_W-1:0]    csr2logic_wdata;
  wire  [(AV_MM_DATA_W/8)-1:0] csr2logic_be;
  reg                         logic2csr_rdata_valid;
  reg   [AV_MM_DATA_W-1:0]    logic2csr_rdata;

  reg                         tmsg_mask_en_posted;
  reg                         tmsg_mask_en_eom;
  reg                         tmsg_mask_en_start;
  reg                         tmsg_mask_en_cnt;
  reg                         tmsg_mask_en_data;

  reg                         mmsg_mask_en_posted;
  reg                         mmsg_mask_en_eom;
  reg                         mmsg_mask_en_start;
  reg                         mmsg_mask_en_cnt;
  reg                         mmsg_mask_en_data;

  reg [15:0]                  tmsg_cap_rdata_slice_idx;
  reg [15:0]                  mmsg_cap_rdata_slice_idx;

  wire  [AV_MM_DATA_W-1:0]      mmsg_cap_fifo_rdata_reg;
  wire  [AV_MM_DATA_W-1:0]      tmsg_cap_fifo_rdata_reg;
  wire  [AV_MM_DATA_W-1:0]      tmsg_cap_rdata_slices [NUM_SLICES_PER_CAP-1:0];
  wire  [AV_MM_DATA_W-1:0]      mmsg_cap_rdata_slices [NUM_SLICES_PER_CAP-1:0];

  wire rst_logic_n;

  new_sbr_type_reg_cr_t                        new_sbr_type_reg_cr;
  new_inst_name0_reg_cr_t                      new_inst_name0_reg_cr;
  new_inst_name1_reg_cr_t                      new_inst_name1_reg_cr;
  new_inst_name2_reg_cr_t                      new_inst_name2_reg_cr;
  new_inst_name3_reg_cr_t                      new_inst_name3_reg_cr;
  new_params0_reg_cr_t                         new_params0_reg_cr;
  new_params1_reg_cr_t                         new_params1_reg_cr;
  new_bus_status_reg_cr_t                      new_bus_status_reg_cr;
  new_num_mmsg_pkts_cnt_reg_cr_t               new_num_mmsg_pkts_cnt_reg_cr;
  new_num_mmsg_beats_cnt_reg_cr_t              new_num_mmsg_beats_cnt_reg_cr;
  new_num_tmsg_pkts_cnt_reg_cr_t               new_num_tmsg_pkts_cnt_reg_cr;
  new_num_tmsg_beats_cnt_reg_cr_t              new_num_tmsg_beats_cnt_reg_cr;
  new_num_dropped_pkts_cnt_reg_cr_t            new_num_dropped_pkts_cnt_reg_cr;
  new_mmsg_cap_fifo_status_reg_cr_t            new_mmsg_cap_fifo_status_reg_cr;
  new_mmsg_cap_fifo_rdata_reg_cr_t             new_mmsg_cap_fifo_rdata_reg_cr;
  new_tmsg_cap_fifo_status_reg_cr_t            new_tmsg_cap_fifo_status_reg_cr;
  new_tmsg_cap_fifo_rdata_reg_cr_t             new_tmsg_cap_fifo_rdata_reg_cr;

  sbr_type_reg_cr_t                            sbr_type_reg_cr;
  inst_name0_reg_cr_t                          inst_name0_reg_cr;
  inst_name1_reg_cr_t                          inst_name1_reg_cr;
  inst_name2_reg_cr_t                          inst_name2_reg_cr;
  inst_name3_reg_cr_t                          inst_name3_reg_cr;
  params0_reg_cr_t                             params0_reg_cr;
  params1_reg_cr_t                             params1_reg_cr;
  cntrl_reg_cr_t                               cntrl_reg_cr;
  bus_status_reg_cr_t                          bus_status_reg_cr;
  num_mmsg_pkts_cnt_reg_cr_t                   num_mmsg_pkts_cnt_reg_cr;
  num_mmsg_beats_cnt_reg_cr_t                  num_mmsg_beats_cnt_reg_cr;
  num_tmsg_pkts_cnt_reg_cr_t                   num_tmsg_pkts_cnt_reg_cr;
  num_tmsg_beats_cnt_reg_cr_t                  num_tmsg_beats_cnt_reg_cr;
  num_dropped_pkts_cnt_reg_cr_t                num_dropped_pkts_cnt_reg_cr;
  mask_cntrl_reg_cr_t                          mask_cntrl_reg_cr;
  mask_value0_reg_cr_t                         mask_value0_reg_cr;
  mask_value1_reg_cr_t                         mask_value1_reg_cr;
  mask_value2_reg_cr_t                         mask_value2_reg_cr;
  mask_value3_reg_cr_t                         mask_value3_reg_cr;
  mmsg_cap_fifo_status_reg_cr_t                mmsg_cap_fifo_status_reg_cr;
  mmsg_cap_fifo_cntrl_reg_cr_t                 mmsg_cap_fifo_cntrl_reg_cr;
  mmsg_cap_fifo_rdata_reg_cr_t                 mmsg_cap_fifo_rdata_reg_cr;
  tmsg_cap_fifo_status_reg_cr_t                tmsg_cap_fifo_status_reg_cr;
  tmsg_cap_fifo_cntrl_reg_cr_t                 tmsg_cap_fifo_cntrl_reg_cr;
  tmsg_cap_fifo_rdata_reg_cr_t                 tmsg_cap_fifo_rdata_reg_cr;
  we_tmsg_cap_fifo_cntrl_reg_cr_t              we_tmsg_cap_fifo_cntrl_reg_cr;
  we_mmsg_cap_fifo_cntrl_reg_cr_t              we_mmsg_cap_fifo_cntrl_reg_cr;

  handcode_wdata_tmsg_cap_fifo_cntrl_reg_cr_t  handcode_wdata_tmsg_cap_fifo_cntrl_reg_cr;
  handcode_wdata_mmsg_cap_fifo_cntrl_reg_cr_t  handcode_wdata_mmsg_cap_fifo_cntrl_reg_cr;
  handcode_rdata_mmsg_cap_fifo_cntrl_reg_cr_t  handcode_rdata_mmsg_cap_fifo_cntrl_reg_cr;
  handcode_rdata_tmsg_cap_fifo_cntrl_reg_cr_t  handcode_rdata_tmsg_cap_fifo_cntrl_reg_cr;
  IW_fpga_iosf_sb_mon_av_addr_map_cr_req_t     req;
  IW_fpga_iosf_sb_mon_av_addr_map_cr_ack_t     ack;


  //req/rsp fifo signals

  assign  req_ff_wdata  = {  {(REQ_FF_W-REQ_DATA_W){1'b0}}
                            ,avl_mm_byteenable
                            ,avl_mm_writedata
                            ,avl_mm_address
                            ,(avl_mm_read & ~avl_mm_write)
                          };
  assign  req_ff_wren   = avl_mm_read | avl_mm_write;

  assign  {  
            avl_mm_readdata 
          } = rsp_ff_rdata[RSP_DATA_W-1:0];

  //assign  rsp_ff_rden     = csr_rdata_rdy;
  assign  avl_mm_readdatavalid = ~rsp_ff_empty;


  assign  {
             csr2logic_be
            ,csr2logic_wdata
            ,csr2logic_addr
          } = req_ff_rdata[REQ_DATA_W-1:1];
  assign  csr2logic_wren  = ~req_ff_empty & ~req_ff_rdata[0];
  assign  csr2logic_rden  = ~req_ff_empty &  req_ff_rdata[0];

  assign  rsp_ff_wdata[RSP_DATA_W-1:0]  = {  
                                            logic2csr_rdata
                                          };
  assign  rsp_ff_wren = logic2csr_rdata_valid;

  //Assigning HW inputs to register fields
  always@(*)
  begin
  
    for (n=0;n<4;n++)
    begin
      new_sbr_type_reg_cr.inst_name[(n*8) +:  8] =  sbr_type_str[3-n];
    end
    
    for (n=0;n<4;n++)
    begin
      new_inst_name0_reg_cr.inst_name[(n*8) +:  8]=  inst_name_str[15-n];
    end
  
    for (n=0;n<4;n++)
    begin
      new_inst_name1_reg_cr.inst_name[(n*8) +:  8]=  inst_name_str[15-4-n];
    end
  
    for (n=0;n<4;n++)
    begin
      new_inst_name2_reg_cr.inst_name[(n*8) +:  8]=  inst_name_str[15-8-n];
    end
  
    for (n=0;n<4;n++)
    begin
      new_inst_name3_reg_cr.inst_name[(n*8) +:  8]=  inst_name_str[15-12-n];
    end
  
    new_params0_reg_cr.payload_width  = PAYLOAD_WIDTH;
    new_params0_reg_cr.mode           = (MODE ==  "avl")  ? 1'b0  : 1'b1;
    new_params0_reg_cr.cap_fifo_depth = CAP_FF_DEPTH;
  
    new_params1_reg_cr.CAP_FF_DATA_W = CAP_RECORD_W;
    new_params1_reg_cr.CAP_RECORD_WIDTH  = CAP_FF_DATA_W; 
  
    mon_enable        =   cntrl_reg_cr.mon_enable;
    clr_stats         =   cntrl_reg_cr.clr_stats;
    flush_cap_ff      =   cntrl_reg_cr.flush_cap_ff;
    rec_ordering_en   =   cntrl_reg_cr.rec_ordering_en;
  
    new_bus_status_reg_cr.ism_fabric = iosfsb_SIDE_ISM_FABRIC;
    new_bus_status_reg_cr.ism_agent  = iosfsb_SIDE_ISM_AGENT;
  
    new_num_mmsg_pkts_cnt_reg_cr.num_pc_pkts =  num_mmsg_pc_pkts;
    new_num_mmsg_pkts_cnt_reg_cr.num_np_pkts =  num_mmsg_np_pkts;
  
    new_num_tmsg_pkts_cnt_reg_cr.num_pc_pkts =  num_tmsg_pc_pkts;
    new_num_tmsg_pkts_cnt_reg_cr.num_np_pkts =  num_tmsg_np_pkts;
  
    new_num_tmsg_beats_cnt_reg_cr.num_pc_beats = num_tmsg_pc_beats;
    new_num_tmsg_beats_cnt_reg_cr.num_np_beats = num_tmsg_np_beats;
  
    new_num_mmsg_beats_cnt_reg_cr.num_pc_beats = num_mmsg_pc_beats;
    new_num_mmsg_beats_cnt_reg_cr.num_np_beats = num_mmsg_np_beats;
  
    new_num_dropped_pkts_cnt_reg_cr.num_tmsg_pkts_dropped = num_tmsg_dropped_pkts;
    new_num_dropped_pkts_cnt_reg_cr.num_mmsg_pkts_dropped = num_mmsg_dropped_pkts;
  
    tmsg_mask_en_posted =   mask_cntrl_reg_cr.tmsg_posted_mask_en;
    tmsg_mask_en_eom    =   mask_cntrl_reg_cr.tmsg_eom_mask_en;
    tmsg_mask_en_start  =   mask_cntrl_reg_cr.tmsg_start_mask_en;
    tmsg_mask_en_cnt    =   mask_cntrl_reg_cr.tmsg_count_mask_en;
    tmsg_mask_en_data   =   mask_cntrl_reg_cr.tmsg_data_mask_en;
    mmsg_mask_en_posted =   mask_cntrl_reg_cr.mmsg_posted_mask_en;
    mmsg_mask_en_eom    =   mask_cntrl_reg_cr.mmsg_eom_mask_en;
    mmsg_mask_en_start  =   mask_cntrl_reg_cr.mmsg_start_mask_en;
    mmsg_mask_en_cnt    =   mask_cntrl_reg_cr.mmsg_count_mask_en;
    mmsg_mask_en_data   =   mask_cntrl_reg_cr.mmsg_data_mask_en;
  
    tmsg_mask_value.posted    = mask_value0_reg_cr.tmsg_posted_mask_value;
    tmsg_mask_value.eom       = mask_value0_reg_cr.tmsg_eom_mask_value;
    tmsg_mask_value.start     = mask_value0_reg_cr.tmsg_start_mask_value;
    tmsg_mask_value.direction = 1'b0;
    mmsg_mask_value.posted    = mask_value0_reg_cr.mmsg_posted_mask_value;
    mmsg_mask_value.eom       = mask_value0_reg_cr.mmsg_eom_mask_value;
    mmsg_mask_value.start     = mask_value0_reg_cr.mmsg_start_mask_value;
    mmsg_mask_value.direction = 1'b0;
  
    tmsg_mask_value.cnt    = mask_value1_reg_cr.tmsg_count_mask_value; 
    mmsg_mask_value.cnt    = mask_value1_reg_cr.mmsg_count_mask_value; 
  
    tmsg_mask_value.data[31:0]   = mask_value2_reg_cr.tmsg_data_ls32b_mask_value;
    tmsg_mask_value.data[159:32] = 128'b0;
    mmsg_mask_value.data[31:0]   = mask_value3_reg_cr.mmsg_data_ls32b_mask_value;
    mmsg_mask_value.data[159:32] = 128'b0;
  
    new_mmsg_cap_fifo_status_reg_cr.cap_fifo_used       = mmsg_cap_rdused;
  
    mmsg_cap_rdata_slice_idx                            = mmsg_cap_fifo_cntrl_reg_cr.cap_fifo_rdata_slice_idx;
    new_mmsg_cap_fifo_rdata_reg_cr.cap_fifo_rdata_slice = mmsg_cap_fifo_rdata_reg;
  
    new_tmsg_cap_fifo_status_reg_cr.cap_fifo_used       = tmsg_cap_rdused;
  
    tmsg_cap_rdata_slice_idx                            = tmsg_cap_fifo_cntrl_reg_cr.cap_fifo_rdata_slice_idx;
    new_tmsg_cap_fifo_rdata_reg_cr.cap_fifo_rdata_slice = tmsg_cap_fifo_rdata_reg;

    handcode_rdata_mmsg_cap_fifo_cntrl_reg_cr.cap_fifo_rden       = 1'b0;
    handcode_rdata_tmsg_cap_fifo_cntrl_reg_cr.cap_fifo_rden       = 1'b0;
  
  
  end


// clock and reset sync register module instantiation
  IW_fpga_iosf_sb_mon_av_addr_map u_addr_map (
    .gated_clk                                    (clk_logic),
    .rst_n                                        (~rsi_reset),
  
    .new_inst_name0_reg_cr                        (new_inst_name0_reg_cr),
    .new_inst_name1_reg_cr                        (new_inst_name1_reg_cr),
    .new_inst_name2_reg_cr                        (new_inst_name2_reg_cr),
    .new_inst_name3_reg_cr                        (new_inst_name3_reg_cr),
    .new_num_mmsg_pkts_cnt_reg_cr                 (new_num_mmsg_pkts_cnt_reg_cr),
    .new_num_tmsg_pkts_cnt_reg_cr                 (new_num_tmsg_pkts_cnt_reg_cr),
    .new_num_mmsg_beats_cnt_reg_cr                (new_num_mmsg_beats_cnt_reg_cr),
    .new_num_tmsg_beats_cnt_reg_cr                (new_num_tmsg_beats_cnt_reg_cr),
    .new_params0_reg_cr                           (new_params0_reg_cr),
    .new_params1_reg_cr                           (new_params1_reg_cr),
    .new_sbr_type_reg_cr                          (new_sbr_type_reg_cr),
    .new_tmsg_cap_fifo_status_reg_cr              (new_tmsg_cap_fifo_status_reg_cr),
    .new_mmsg_cap_fifo_status_reg_cr              (new_mmsg_cap_fifo_status_reg_cr),
    .new_tmsg_cap_fifo_rdata_reg_cr               (new_tmsg_cap_fifo_rdata_reg_cr),
    .new_mmsg_cap_fifo_rdata_reg_cr               (new_mmsg_cap_fifo_rdata_reg_cr),
    .new_bus_status_reg_cr                        (new_bus_status_reg_cr),
    .new_num_dropped_pkts_cnt_reg_cr              (new_num_dropped_pkts_cnt_reg_cr),
  
    .bus_status_reg_cr                            (bus_status_reg_cr),
    .cntrl_reg_cr                                 (cntrl_reg_cr),
    .inst_name0_reg_cr                            (inst_name0_reg_cr),
    .inst_name1_reg_cr                            (inst_name1_reg_cr),
    .inst_name2_reg_cr                            (inst_name2_reg_cr),
    .inst_name3_reg_cr                            (inst_name3_reg_cr),
    .mask_cntrl_reg_cr                            (mask_cntrl_reg_cr),
    .mask_value0_reg_cr                           (mask_value0_reg_cr),
    .mask_value1_reg_cr                           (mask_value1_reg_cr),
    .mask_value2_reg_cr                           (mask_value2_reg_cr),
    .mask_value3_reg_cr                           (mask_value3_reg_cr),
    .mmsg_cap_fifo_cntrl_reg_cr                   (mmsg_cap_fifo_cntrl_reg_cr),
    .mmsg_cap_fifo_rdata_reg_cr                   (mmsg_cap_fifo_rdata_reg_cr),
    .mmsg_cap_fifo_status_reg_cr                  (mmsg_cap_fifo_status_reg_cr),
    .num_dropped_pkts_cnt_reg_cr                  (num_dropped_pkts_cnt_reg_cr),
    .num_mmsg_beats_cnt_reg_cr                    (num_mmsg_beats_cnt_reg_cr),
    .num_mmsg_pkts_cnt_reg_cr                     (num_mmsg_pkts_cnt_reg_cr),
    .num_tmsg_beats_cnt_reg_cr                    (num_tmsg_beats_cnt_reg_cr),
    .num_tmsg_pkts_cnt_reg_cr                     (num_tmsg_pkts_cnt_reg_cr),
    .params0_reg_cr                               (params0_reg_cr),
    .params1_reg_cr                               (params1_reg_cr),
    .sbr_type_reg_cr                              (sbr_type_reg_cr),
    .tmsg_cap_fifo_cntrl_reg_cr                   (tmsg_cap_fifo_cntrl_reg_cr),
    .tmsg_cap_fifo_rdata_reg_cr                   (tmsg_cap_fifo_rdata_reg_cr),
    .tmsg_cap_fifo_status_reg_cr                  (tmsg_cap_fifo_status_reg_cr),
    .handcode_wdata_mmsg_cap_fifo_cntrl_reg_cr    (handcode_wdata_mmsg_cap_fifo_cntrl_reg_cr),
    .handcode_wdata_tmsg_cap_fifo_cntrl_reg_cr    (handcode_wdata_tmsg_cap_fifo_cntrl_reg_cr),
    .we_mmsg_cap_fifo_cntrl_reg_cr                (we_mmsg_cap_fifo_cntrl_reg_cr),
    .we_tmsg_cap_fifo_cntrl_reg_cr                (we_tmsg_cap_fifo_cntrl_reg_cr),
    .handcode_rdata_mmsg_cap_fifo_cntrl_reg_cr    (handcode_rdata_mmsg_cap_fifo_cntrl_reg_cr),
    .handcode_rdata_tmsg_cap_fifo_cntrl_reg_cr    (handcode_rdata_tmsg_cap_fifo_cntrl_reg_cr),
    .req                                          (req),
    .ack                                          (ack)
  
  );
  //------------------------------------------------------//
  //    REQ SIGNALS        :     ACK SIGNALS              //
  //------------------------------------------------------//
  // req.valid     : ack.read_valid       //
  // req.opcode    : ack.read_miss        //
  // req.addr      : ack.write_valid      //
  // req.be        : ack.write_miss       //
  // req.data      : ack.sai_successfull  //
  // req.sai       : ack.data             //
  // req.fid       :                              //
  // req.bar       :                              //
  //------------------------------------------------------//
  
  //------------------------------------------------------//
  // Register module config request signals logic         //
  //------------------------------------------------------//
  //Request is valid for any read or write transaction occurs when waitrequest
  //is inactive/low 
  assign req.valid  = (csr2logic_wren||csr2logic_rden) && (!avl_mm_waitrequest);
  //Register CFG opcode selection
  assign req.opcode = csr2logic_wren? CFGWR : CFGRD;
  //Register CFG address excpets 48bit. Appending zeros to 
  //AV MM slave address
  assign req.addr   = {'h0,csr2logic_addr};
  assign req.be     = csr2logic_be;
  assign req.data   = csr2logic_wdata;
  assign req.sai    = 7'h00;
  assign req.fid    = 7'h00;
  assign req.bar    = 3'h0;
  
  //AV MM Slave waitrequest
  assign avl_mm_waitrequest = 1'b0;
  //AV MM Slave read data valid is registered CFG ack's read_valid or read_miss
  always @(posedge csi_clk  or posedge rsi_reset)
  begin
    if(rsi_reset)
      logic2csr_rdata_valid <= 1'b0;
    else
      logic2csr_rdata_valid <= ack.read_valid || ack.read_miss;
  end
  //AV MM Slave read data 
  always @(posedge csi_clk  or posedge rsi_reset)
  begin
    if(rsi_reset)
      logic2csr_rdata <= 'h0;
    else if(ack.read_miss)
      logic2csr_rdata <= READ_MISS_VAL;
    else if(ack.read_valid)
      logic2csr_rdata <= ack.data;
    else
      logic2csr_rdata <= 'h0;
  end

  /*  Interfacing with Capture FIFO */
  generate
    if(MODE ==  "avl")
    begin
      assign  tmsg_cap_rden             = 1'b0;
      assign  tmsg_cap_fifo_rdata_reg   = 'hdeadbabe;

      assign  mmsg_cap_rden             = 1'b0;
      assign  mmsg_cap_fifo_rdata_reg   = 'hdeadbabe;
    end
    else  //MODE  ==  "standalone"
    begin

      always@(posedge clk_logic,  negedge rst_logic_n)
      begin
        if(~rst_logic_n)
        begin
          tmsg_cap_rden             <=  0;
          mmsg_cap_rden             <=  0;
        end
        else
        begin
          tmsg_cap_rden           <=  we_tmsg_cap_fifo_cntrl_reg_cr.cap_fifo_rden  & handcode_wdata_tmsg_cap_fifo_cntrl_reg_cr.cap_fifo_rden;
          mmsg_cap_rden           <=  we_mmsg_cap_fifo_cntrl_reg_cr.cap_fifo_rden  & handcode_wdata_mmsg_cap_fifo_cntrl_reg_cr.cap_fifo_rden;
        end
      end
      assign  tmsg_cap_fifo_rdata_reg   = tmsg_cap_rdata_slices[tmsg_cap_rdata_slice_idx];
      assign  mmsg_cap_fifo_rdata_reg   = mmsg_cap_rdata_slices[mmsg_cap_rdata_slice_idx];
    end
  endgenerate

  /*  Convert the CAP rdata bus into an array of AV_MM_DATA_W width */
  generate
    for(i=0;i<NUM_SLICES_PER_CAP;i++)
    begin : gen_cap_rdata_slices
      if((i==NUM_SLICES_PER_CAP-1)  &&  (CAP_SLICE_RESIDUE  > 0))
      begin
        assign  tmsg_cap_rdata_slices[i]  = {{(AV_MM_DATA_W-CAP_SLICE_RESIDUE){1'b0}},tmsg_cap_rdata[(i*AV_MM_DATA_W) +:  CAP_SLICE_RESIDUE]};
        assign  mmsg_cap_rdata_slices[i]  = {{(AV_MM_DATA_W-CAP_SLICE_RESIDUE){1'b0}},mmsg_cap_rdata[(i*AV_MM_DATA_W) +:  CAP_SLICE_RESIDUE]};
      end
      else
      begin
        assign  tmsg_cap_rdata_slices[i]  = tmsg_cap_rdata[(i*AV_MM_DATA_W) +:  AV_MM_DATA_W];
        assign  mmsg_cap_rdata_slices[i]  = mmsg_cap_rdata[(i*AV_MM_DATA_W) +:  AV_MM_DATA_W];
      end
    end
  endgenerate



  IW_fpga_async_fifo #(
     .ADDR_WD (9),
     .DATA_WD (REQ_FF_W) ) u_req_ff
   (
     .rstn                         (rst_logic_n),
     .data                         (req_ff_wdata),
     .rdclk                        (clk_logic),
     .rdreq                        (req_ff_rden),
     .wrclk                        (csi_clk),
     .wrreq                        (req_ff_wren),
     .q                            (req_ff_rdata),
     .rdempty                      (req_ff_empty),
     .rdusedw                      (),
     .wrfull                       (req_ff_full),
     .wrusedw                      ()
   );



  IW_fpga_async_fifo #(
     .ADDR_WD (9),
     .DATA_WD (RSP_FF_W) ) u_rsp_ff
   (
     .rstn                         (rst_logic_n),
     .data                         (rsp_ff_wdata),
     .rdclk                        (csi_clk),
     .rdreq                        (rsp_ff_rden),
     .wrclk                        (clk_logic),
     .wrreq                        (rsp_ff_wren),
     .q                            (rsp_ff_rdata),
     .rdempty                      (rsp_ff_empty),
     .rdusedw                      (),
     .wrfull                       (rsp_ff_full),
     .wrusedw                      ()
   );

  assign  req_ff_rden   =  ~rsp_ff_full & ~ req_ff_empty;
  assign  rsp_ff_rden   =  ~rsp_ff_empty;



  //Generate Mask Enables
  assign  tmsg_mask_en.posted     =  {$bits(tmsg_mask_en.posted)     {tmsg_mask_en_posted}};
  assign  tmsg_mask_en.eom        =  {$bits(tmsg_mask_en.eom)        {tmsg_mask_en_eom   }};
  assign  tmsg_mask_en.start      =  {$bits(tmsg_mask_en.start)      {tmsg_mask_en_start }};
  assign  tmsg_mask_en.cnt        =  {$bits(tmsg_mask_en.cnt)        {tmsg_mask_en_cnt   }};
  assign  tmsg_mask_en.data[31:0] =  {$bits(tmsg_mask_en.data[31:0]) {tmsg_mask_en_data  }};
  assign  tmsg_mask_en.direction  =  1'b0;

  assign  mmsg_mask_en.posted     =  {$bits(mmsg_mask_en.posted)     {mmsg_mask_en_posted}};
  assign  mmsg_mask_en.eom        =  {$bits(mmsg_mask_en.eom)        {mmsg_mask_en_eom   }};
  assign  mmsg_mask_en.start      =  {$bits(mmsg_mask_en.start)      {mmsg_mask_en_start }};
  assign  mmsg_mask_en.cnt        =  {$bits(mmsg_mask_en.cnt)        {mmsg_mask_en_cnt   }};
  assign  mmsg_mask_en.data[31:0] =  {$bits(mmsg_mask_en.data[31:0]) {mmsg_mask_en_data  }};
  assign  mmsg_mask_en.direction  =  1'b0;
 
  //Only lower 32b of data is maskable; rest are permanently masked
  assign  tmsg_mask_en.data[159:32]     = {(160-32){1'b0}};

  assign  mmsg_mask_en.data[159:32]     = {(160-32){1'b0}};

  assign  rst_logic_n = ~rsi_reset; 

endmodule //IW_fpga_iosf_sb_mon_csr
