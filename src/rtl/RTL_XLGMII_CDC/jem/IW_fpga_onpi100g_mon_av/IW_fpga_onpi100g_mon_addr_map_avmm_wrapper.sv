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
// Version and Release Control Information:
//
// File Name:     $RCSfile: AW_fpga_onpi100g_mon_csr.sv.rca $
// File Revision: $Revision: 1.0 $
// Created by:    Gregory James
// Updated by:    $Author: gjames $ $Date: Wed Feb 24 00:05:54 2016 $
//------------------------------------------------------------------------------

`timescale  1ns/1ps
`include "onpi100g_jem_mon.vh"

module  IW_fpga_onpi100g_mon_addr_map_avmm_wrapper#(
    parameter MON_TYPE            = "onpi"              //Type of monitor
  , parameter INSTANCE_NAME       = "u_onpi_mon"        //Can hold upto 16 ASCII characters
  , parameter MODE                = "standalone"        //Either 'standalone' or 'avl' mode
  , parameter ONPI_SPEED          = "100G"
  , parameter CAP_RECORD_W        = 180                 //Width of struct being FiFod
  , parameter CAP_FF_DATA_W       = 35
  , parameter CAP_FF_DEPTH        = 10
  , parameter CAP_FF_USED_W       = 10

  /*  Do Not Modify */
  , parameter AV_MM_DATA_W        = 8 
  , parameter AV_MM_ADDR_W        = 32
  , parameter READ_MISS_VAL       = 32'hDEADBABE          // Read miss value
) (

  input  wire [AV_MM_ADDR_W-1:0]               avl_mm_address,          // avl_mm.address
  output reg  [AV_MM_DATA_W-1:0]               avl_mm_readdata,         //       .readdata
  input  wire                                  avl_mm_read,             //       .read
  output reg                                   avl_mm_readdatavalid,    //       .readdatavalid
  input  wire                                  avl_mm_write,            //       .write
  input  wire [AV_MM_DATA_W-1:0]               avl_mm_writedata,        //       .writedata
  input  wire [(AV_MM_DATA_W/8)-1:0]           avl_mm_byteenable,       //       .byteenable
  output wire                                  avl_mm_waitrequest,      //       .waitrequest
  input  wire                                  csi_clk,                 // csi.clk
  input  wire                                  rsi_reset,               // rsi.reset

  input  wire                                  clk_logic

  /*  This interface to CAP FF Read port will be used only in standalone mode */
  , input   logic                              cap_rdata_valid
  , input   logic [CAP_FF_DATA_W-1:0]          cap_rdata
  , input   logic [CAP_FF_USED_W-1:0]          cap_rdused
  , output  logic                              cap_rden

  /*  ONPI Interface */

  , input    logic [31:0]                      data0
  , input    logic [31:0]                      data1
  , input    logic [31:0]                      data2
  , input    logic [31:0]                      data3
  , input    logic [3:0]                       ctl0
  , input    logic [3:0]                       ctl1
  , input    logic [3:0]                       ctl2
  , input    logic [3:0]                       ctl3
  , input    logic [7:0]                       mdata0
  , input    logic [7:0]                       mdata1
  , input    logic [7:0]                       mdata2
  , input    logic [7:0]                       mdata3
  , input    logic [7:0]                       mdata4
  , input    logic [7:0]                       mdata5
  , input    logic [7:0]                       mdata6
  , input    logic [7:0]                       mdata7
  , input    logic                             msdata
  , input    logic                             linkup
  , input    logic                             lp_linkup
  , input    logic [7:0]                       speed
  , input    logic [7:0]                       xoff

  /*  Statistics  */
  , input   logic  [31:0]                      num_pkts
  , input   logic  [31:0]                      num_beats
  , input   logic  [31:0]                      num_dropped_pkts

  /*  CSR Registers */
  , output  logic                              mon_enable
  , output  logic                              clr_stats
  , output  logic                              flush_cap_ff
  , output  logic                              rec_ordering_en
  , output  onpi100g_xctn_t  onpi_mask_en
  , output  onpi100g_xctn_t  onpi_mask_value 


);

  //import onpi100g_jem_pkg::*;
  import IW_fpga_onpi100g_mon_av_addr_map_pkg::*;
  //import rtlgen_pkg_v12::*;
  import rtlgen_pkg_IW_fpga_onpi100g_mon_av_addr_map::*;

  /*  Internal Parameters */
  localparam  INTERNAL_ADDR_W   = 8;
  localparam  MAX_ADDR          = 'h5C;
  localparam  REQ_DATA_W        = 1+AV_MM_ADDR_W+AV_MM_DATA_W+(AV_MM_DATA_W/8);
  localparam  RSP_DATA_W        = AV_MM_DATA_W; 

  localparam  REQ_FF_W          = (REQ_DATA_W <=  32) ? 32  :
                                  (REQ_DATA_W <=  64) ? 64  :
                                  (REQ_DATA_W <=  96) ? 96  : 1;

  localparam  RSP_FF_W          = (RSP_DATA_W <=  32) ? 32  :
                                  (RSP_DATA_W <=  64) ? 64  :
                                  (RSP_DATA_W <=  96) ? 96  : 1;

  localparam  CAP_SLICE_RESIDUE = (CAP_FF_DATA_W  % AV_MM_DATA_W);
  localparam  NUM_SLICES_PER_CAP= (CAP_SLICE_RESIDUE  > 0)  ? (CAP_FF_DATA_W  / AV_MM_DATA_W) + 1
                                                            : (CAP_FF_DATA_W  / AV_MM_DATA_W);


  /*  Internal Signals  */
  genvar  i;
  integer n;
  reg   [0:3] [7:0] sbr_type_str  = MON_TYPE;
  reg   [0:15][7:0] inst_name_str = INSTANCE_NAME;
  wire                        rst_logic_n;
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
  wire  [AV_MM_DATA_W/8-1:0]  csr2logic_be;
  wire  [AV_MM_DATA_W-1:0]    csr2logic_wdata;
  reg                         logic2csr_rdata_valid;
  reg   [AV_MM_DATA_W-1:0]    logic2csr_rdata;

  reg                         onpi_mask_en_data0;
  reg                         onpi_mask_en_data1;
  reg                         onpi_mask_en_data2;
  reg                         onpi_mask_en_data3;
  reg                         onpi_mask_en_ctl0;
  reg                         onpi_mask_en_ctl1;
  reg                         onpi_mask_en_ctl2;
  reg                         onpi_mask_en_ctl3;
  reg                         onpi_mask_en_mdata0;
  reg                         onpi_mask_en_mdata1;
  reg                         onpi_mask_en_mdata2;
  reg                         onpi_mask_en_mdata3;
  reg                         onpi_mask_en_mdata4;
  reg                         onpi_mask_en_mdata5;
  reg                         onpi_mask_en_mdata6;
  reg                         onpi_mask_en_mdata7;
  reg                         onpi_mask_en_msdata;

  reg                         onpi_mask_en_linkup;
  reg                         onpi_mask_en_lp_linkup;
  reg                         onpi_mask_en_speed;
  reg                         onpi_mask_en_xoff;
  reg                         onpi_mask_en_wide_typ0;
  reg                         onpi_mask_en_wide_typ1;
  reg                         onpi_mask_en_narrow_typ;

  reg   [15:0]                cap_fifo_rdata_slice_idx;

  wire  [AV_MM_DATA_W-1:0]    cap_rdata_slices [NUM_SLICES_PER_CAP-1:0];
  wire  [AV_MM_DATA_W-1:0]    cap_fifo_status_reg;
  wire  [AV_MM_DATA_W-1:0]    cap_fifo_cntrl_reg;
  wire  [AV_MM_DATA_W-1:0]    cap_fifo_rdata_reg;

new_bus_status_reg_cr_t  new_bus_status_reg_cr;
new_cap_fifo_rdata_reg_cr_t  new_cap_fifo_rdata_reg_cr;
new_cap_fifo_status_reg_cr_t  new_cap_fifo_status_reg_cr;
new_inst_name0_reg_cr_t  new_inst_name0_reg_cr;
new_inst_name1_reg_cr_t  new_inst_name1_reg_cr;
new_inst_name2_reg_cr_t  new_inst_name2_reg_cr;
new_inst_name3_reg_cr_t  new_inst_name3_reg_cr;
new_num_beats_cnt_reg_cr_t  new_num_beats_cnt_reg_cr;
new_num_dropped_pkts_cnt_reg_cr_t  new_num_dropped_pkts_cnt_reg_cr;
new_num_pkts_cnt_reg_cr_t  new_num_pkts_cnt_reg_cr;
new_params0_reg_cr_t  new_params0_reg_cr;
new_params1_reg_cr_t  new_params1_reg_cr;
new_sbr_type_reg_cr_t  new_sbr_type_reg_cr;

handcode_rdata_cap_fifo_cntrl_reg_cr_t  handcode_rdata_cap_fifo_cntrl_reg_cr;


bus_status_reg_cr_t  bus_status_reg_cr;
cap_fifo_cntrl_reg_cr_t  cap_fifo_cntrl_reg_cr;
cap_fifo_rdata_reg_cr_t  cap_fifo_rdata_reg_cr;
cap_fifo_status_reg_cr_t  cap_fifo_status_reg_cr;
cntrl_reg_cr_t  cntrl_reg_cr;
inst_name0_reg_cr_t  inst_name0_reg_cr;
inst_name1_reg_cr_t  inst_name1_reg_cr;
inst_name2_reg_cr_t  inst_name2_reg_cr;
inst_name3_reg_cr_t  inst_name3_reg_cr;
mask_cntrl_reg_cr_t  mask_cntrl_reg_cr;
mask_value0_reg_cr_t  mask_value0_reg_cr;
mask_value1_reg_cr_t  mask_value1_reg_cr;
mask_value2_reg_cr_t  mask_value2_reg_cr;
mask_value3_reg_cr_t  mask_value3_reg_cr;
mask_value4_reg_cr_t  mask_value4_reg_cr;
mask_value5_reg_cr_t  mask_value5_reg_cr;
mask_value6_reg_cr_t  mask_value6_reg_cr;
mask_value7_reg_cr_t  mask_value7_reg_cr;
num_beats_cnt_reg_cr_t  num_beats_cnt_reg_cr;
num_dropped_pkts_cnt_reg_cr_t  num_dropped_pkts_cnt_reg_cr;
num_pkts_cnt_reg_cr_t  num_pkts_cnt_reg_cr;
params0_reg_cr_t  params0_reg_cr;
params1_reg_cr_t  params1_reg_cr;
sbr_type_reg_cr_t  sbr_type_reg_cr;
IW_fpga_onpi100g_mon_av_addr_map_cr_req_t  req;
IW_fpga_onpi100g_mon_av_addr_map_cr_ack_t  ack;


handcode_wdata_cap_fifo_cntrl_reg_cr_t  handcode_wdata_cap_fifo_cntrl_reg_cr;

we_cap_fifo_cntrl_reg_cr_t  we_cap_fifo_cntrl_reg_cr;

  /*  Pack/Unpack req & rsp signals based on mode  */
  assign  req_ff_wdata  = {  {(REQ_FF_W-REQ_DATA_W){1'b0}}
                            ,avl_mm_writedata
                            ,avl_mm_address
                            ,avl_mm_byteenable
                            ,(avl_mm_read & ~avl_mm_write)
                          };
  assign  req_ff_wren   = avl_mm_read  | avl_mm_write;

  assign  {
             avl_mm_readdata 
          } = rsp_ff_rdata[RSP_DATA_W-1:0];

  assign  rsp_ff_rden     = ~rsp_ff_empty;
  assign  avl_mm_readdatavalid = ~rsp_ff_empty;


  assign  {
             csr2logic_wdata
            ,csr2logic_addr
            ,csr2logic_be
          } = req_ff_rdata[REQ_DATA_W-1:1];
  assign  csr2logic_wren  = ~req_ff_empty & ~req_ff_rdata[0];
  assign  csr2logic_rden  = ~req_ff_empty &  req_ff_rdata[0];

  assign  rsp_ff_wdata[RSP_DATA_W-1:0]  = {
                                             logic2csr_rdata
                                          };
  assign  rsp_ff_wren = logic2csr_rdata_valid;


IW_fpga_onpi100g_mon_av_addr_map u_csr (
.gated_clk                                         (clk_logic),
.rst_n                                             (rst_logic_n),
.new_bus_status_reg_cr                             (new_bus_status_reg_cr),
.new_cap_fifo_rdata_reg_cr                         (new_cap_fifo_rdata_reg_cr),
.new_cap_fifo_status_reg_cr                        (new_cap_fifo_status_reg_cr),
.new_inst_name0_reg_cr                             (new_inst_name0_reg_cr),
.new_inst_name1_reg_cr                             (new_inst_name1_reg_cr),
.new_inst_name2_reg_cr                             (new_inst_name2_reg_cr),
.new_inst_name3_reg_cr                             (new_inst_name3_reg_cr),
.new_num_beats_cnt_reg_cr                          (new_num_beats_cnt_reg_cr),
.new_num_dropped_pkts_cnt_reg_cr                   (new_num_dropped_pkts_cnt_reg_cr),
.new_num_pkts_cnt_reg_cr                           (new_num_pkts_cnt_reg_cr),
.new_params0_reg_cr                                (new_params0_reg_cr),
.new_params1_reg_cr                                (new_params1_reg_cr),
.new_sbr_type_reg_cr                               (new_sbr_type_reg_cr),
.handcode_rdata_cap_fifo_cntrl_reg_cr              (handcode_rdata_cap_fifo_cntrl_reg_cr),
.bus_status_reg_cr                                 (bus_status_reg_cr),
.cap_fifo_cntrl_reg_cr                             (cap_fifo_cntrl_reg_cr),
.cap_fifo_rdata_reg_cr                             (cap_fifo_rdata_reg_cr),
.cap_fifo_status_reg_cr                            (cap_fifo_status_reg_cr),
.cntrl_reg_cr                                      (cntrl_reg_cr),
.inst_name0_reg_cr                                 (inst_name0_reg_cr),
.inst_name1_reg_cr                                 (inst_name1_reg_cr),
.inst_name2_reg_cr                                 (inst_name2_reg_cr),
.inst_name3_reg_cr                                 (inst_name3_reg_cr),
.mask_cntrl_reg_cr                                 (mask_cntrl_reg_cr),
.mask_value0_reg_cr                                (mask_value0_reg_cr),
.mask_value1_reg_cr                                (mask_value1_reg_cr),
.mask_value2_reg_cr                                (mask_value2_reg_cr),
.mask_value3_reg_cr                                (mask_value3_reg_cr),
.mask_value4_reg_cr                                (mask_value4_reg_cr),
.mask_value5_reg_cr                                (mask_value5_reg_cr),
.mask_value6_reg_cr                                (mask_value6_reg_cr),
.mask_value7_reg_cr                                (mask_value7_reg_cr),
.num_beats_cnt_reg_cr                              (num_beats_cnt_reg_cr),
.num_dropped_pkts_cnt_reg_cr                       (num_dropped_pkts_cnt_reg_cr),
.num_pkts_cnt_reg_cr                               (num_pkts_cnt_reg_cr),
.params0_reg_cr                                    (params0_reg_cr),
.params1_reg_cr                                    (params1_reg_cr),
.sbr_type_reg_cr                                   (sbr_type_reg_cr),
.handcode_wdata_cap_fifo_cntrl_reg_cr              (handcode_wdata_cap_fifo_cntrl_reg_cr),
.we_cap_fifo_cntrl_reg_cr                          (we_cap_fifo_cntrl_reg_cr),
.req                                               (req),
.ack                                               (ack)
);

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

    new_params0_reg_cr.payload_width  = 7'h0;
    new_params0_reg_cr.mode           = (MODE ==  "avl")  ? 1'b0  : 1'b1;
    new_params0_reg_cr.cap_fifo_depth = CAP_FF_DEPTH;
  
    new_params1_reg_cr.CAP_FF_DATA_W = CAP_RECORD_W;
    new_params1_reg_cr.CAP_RECORD_WIDTH  = CAP_FF_DATA_W; 

    mon_enable        =   cntrl_reg_cr.mon_enable;
    clr_stats         =   cntrl_reg_cr.clr_stats;
    flush_cap_ff      =   cntrl_reg_cr.flush_cap_ff;
    rec_ordering_en   =   cntrl_reg_cr.rec_ordering_en;

    new_bus_status_reg_cr.msdata    = msdata; 
    new_bus_status_reg_cr.linkup    = linkup; 
    new_bus_status_reg_cr.lp_linkup = lp_linkup; 
    new_bus_status_reg_cr.speed     = speed; 
    new_bus_status_reg_cr.xoff      = xoff; 

    new_num_pkts_cnt_reg_cr.num_pkts = num_pkts; 

    new_num_beats_cnt_reg_cr.num_beats = num_beats;

    new_num_dropped_pkts_cnt_reg_cr.num_dropped_pkts = num_dropped_pkts;

    onpi_mask_en_narrow_typ      =      mask_cntrl_reg_cr.narrow_typ_mask_en;
    onpi_mask_en_wide_typ1       =      mask_cntrl_reg_cr.wide_typ1_mask_en;
    onpi_mask_en_wide_typ0       =      mask_cntrl_reg_cr.wide_typ0_mask_en;
    onpi_mask_en_xoff            =      mask_cntrl_reg_cr.xoff_mask_en;
    onpi_mask_en_speed           =      mask_cntrl_reg_cr.speed_mask_en;
    onpi_mask_en_lp_linkup       =      mask_cntrl_reg_cr.lp_linkup_mask_en;
    onpi_mask_en_linkup          =      mask_cntrl_reg_cr.linkup_mask_en;
    onpi_mask_en_msdata          =      mask_cntrl_reg_cr.msdata_mask_en;
    onpi_mask_en_mdata7          =      mask_cntrl_reg_cr.mdata7_mask_en;
    onpi_mask_en_mdata6          =      mask_cntrl_reg_cr.mdata6_mask_en;
    onpi_mask_en_mdata5          =      mask_cntrl_reg_cr.mdata5_mask_en;
    onpi_mask_en_mdata4          =      mask_cntrl_reg_cr.mdata4_mask_en;
    onpi_mask_en_mdata3          =      mask_cntrl_reg_cr.mdata3_mask_en;
    onpi_mask_en_mdata2          =      mask_cntrl_reg_cr.mdata2_mask_en;
    onpi_mask_en_mdata1          =      mask_cntrl_reg_cr.mdata1_mask_en;
    onpi_mask_en_mdata0          =      mask_cntrl_reg_cr.mdata0_mask_en;
    onpi_mask_en_ctl3            =      mask_cntrl_reg_cr.ctl3_mask_en;
    onpi_mask_en_ctl2            =      mask_cntrl_reg_cr.ctl2_mask_en;
    onpi_mask_en_ctl1            =      mask_cntrl_reg_cr.ctl1_mask_en;
    onpi_mask_en_ctl0            =      mask_cntrl_reg_cr.ctl0_mask_en;
    onpi_mask_en_data3           =      mask_cntrl_reg_cr.data3_mask_en;
    onpi_mask_en_data2           =      mask_cntrl_reg_cr.data2_mask_en;
    onpi_mask_en_data1           =      mask_cntrl_reg_cr.data1_mask_en;
    onpi_mask_en_data0           =      mask_cntrl_reg_cr.data0_mask_en;

    onpi_mask_value.data0        =      mask_value0_reg_cr.data0_mask_value;
    onpi_mask_value.data1        =      mask_value1_reg_cr.data1_mask_value;
    onpi_mask_value.data2        =      mask_value2_reg_cr.data2_mask_value;
    onpi_mask_value.data3        =      mask_value3_reg_cr.data3_mask_value;
    onpi_mask_value.ctl0         =      mask_value4_reg_cr.ctl0_mask_value;
    onpi_mask_value.ctl1         =      mask_value4_reg_cr.ctl1_mask_value;
    onpi_mask_value.ctl2         =      mask_value4_reg_cr.ctl2_mask_value;
    onpi_mask_value.ctl3         =      mask_value4_reg_cr.ctl3_mask_value;
    onpi_mask_value.mdata0       =      mask_value4_reg_cr.mdata0_mask_value;
    onpi_mask_value.mdata1       =      mask_value4_reg_cr.mdata1_mask_value;
    onpi_mask_value.mdata2       =      mask_value5_reg_cr.mdata2_mask_value;
    onpi_mask_value.mdata3       =      mask_value5_reg_cr.mdata3_mask_value;
    onpi_mask_value.mdata4       =      mask_value5_reg_cr.mdata4_mask_value;
    onpi_mask_value.mdata5       =      mask_value5_reg_cr.mdata5_mask_value;
    onpi_mask_value.mdata6       =      mask_value6_reg_cr.mdata6_mask_value;
    onpi_mask_value.mdata7       =      mask_value6_reg_cr.mdata7_mask_value;
    onpi_mask_value.msdata       =      mask_value6_reg_cr.msdata_mask_value;
    onpi_mask_value.linkup       =      mask_value6_reg_cr.link_up_mask_value;
    onpi_mask_value.lp_linkup    =      mask_value6_reg_cr.lp_link_up_mask_value;
    onpi_mask_value.speed        =      mask_value6_reg_cr.speed_mask_value;
    onpi_mask_value.wide_typ1    =      onpi100g_typ_t'(mask_value7_reg_cr.wide_typ1_mask_value);
    onpi_mask_value.wide_typ0    =      onpi100g_typ_t'(mask_value7_reg_cr.wide_typ0_mask_value);
    onpi_mask_value.narrow_typ   =      onpi100g_typ_t'(mask_value7_reg_cr.narrow_typ_mask_value);
    onpi_mask_value.xoff         =      mask_value7_reg_cr.xoff_mask_value;

    new_cap_fifo_status_reg_cr.cap_fifo_used = cap_rdused;

    cap_fifo_rdata_slice_idx = cap_fifo_cntrl_reg_cr.cap_fifo_rdata_slice_idx;

    new_cap_fifo_rdata_reg_cr.cap_fifo_rdata_slice = cap_fifo_rdata_reg;

    handcode_rdata_cap_fifo_cntrl_reg_cr.cap_fifo_rden = 1'b0;
  end

  /*  Instantiate Request Fifo  */
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

  /*  Instantiate Response Fifo  */
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

  assign  req_ff_rden = ~rsp_ff_full & ~req_ff_empty;


  //Generate Mask Enables
  assign  onpi_mask_en.data0      =  {$bits(onpi_mask_en.data0)      {onpi_mask_en_data0}};
  assign  onpi_mask_en.data1      =  {$bits(onpi_mask_en.data1)      {onpi_mask_en_data1}};
  assign  onpi_mask_en.data2      =  {$bits(onpi_mask_en.data2)      {onpi_mask_en_data2}};
  assign  onpi_mask_en.data3      =  {$bits(onpi_mask_en.data3)      {onpi_mask_en_data3}};
  assign  onpi_mask_en.ctl0       =  {$bits(onpi_mask_en.ctl0)       {onpi_mask_en_ctl0}};
  assign  onpi_mask_en.ctl1       =  {$bits(onpi_mask_en.ctl1)       {onpi_mask_en_ctl1}};
  assign  onpi_mask_en.ctl2       =  {$bits(onpi_mask_en.ctl2)       {onpi_mask_en_ctl2}};
  assign  onpi_mask_en.ctl3       =  {$bits(onpi_mask_en.ctl3)       {onpi_mask_en_ctl3}};
  assign  onpi_mask_en.mdata0     =  {$bits(onpi_mask_en.mdata0)     {onpi_mask_en_mdata0}};
  assign  onpi_mask_en.mdata1     =  {$bits(onpi_mask_en.mdata1)     {onpi_mask_en_mdata1}};
  assign  onpi_mask_en.mdata2     =  {$bits(onpi_mask_en.mdata2)     {onpi_mask_en_mdata2}};
  assign  onpi_mask_en.mdata3     =  {$bits(onpi_mask_en.mdata3)     {onpi_mask_en_mdata3}};
  assign  onpi_mask_en.mdata4     =  {$bits(onpi_mask_en.mdata4)     {onpi_mask_en_mdata4}};
  assign  onpi_mask_en.mdata5     =  {$bits(onpi_mask_en.mdata5)     {onpi_mask_en_mdata5}};
  assign  onpi_mask_en.mdata6     =  {$bits(onpi_mask_en.mdata6)     {onpi_mask_en_mdata6}};
  assign  onpi_mask_en.mdata7     =  {$bits(onpi_mask_en.mdata7)     {onpi_mask_en_mdata7}};
  assign  onpi_mask_en.msdata     =  {$bits(onpi_mask_en.msdata)     {onpi_mask_en_msdata}};
  assign  onpi_mask_en.linkup     =  {$bits(onpi_mask_en.linkup)     {onpi_mask_en_linkup}};
  assign  onpi_mask_en.lp_linkup  =  {$bits(onpi_mask_en.lp_linkup)  {onpi_mask_en_lp_linkup}};
  assign  onpi_mask_en.speed      =  {$bits(onpi_mask_en.speed)      {onpi_mask_en_speed}};
  assign  onpi_mask_en.xoff       =  {$bits(onpi_mask_en.xoff)       {onpi_mask_en_xoff}};
  assign  onpi_mask_en.wide_typ0  =  onpi100g_typ_t'({$bits(onpi_mask_en.wide_typ0)  {onpi_mask_en_wide_typ0}});
  assign  onpi_mask_en.wide_typ1  =  onpi100g_typ_t'({$bits(onpi_mask_en.wide_typ1)  {onpi_mask_en_wide_typ1}});
  assign  onpi_mask_en.narrow_typ =  onpi100g_typ_t'({$bits(onpi_mask_en.narrow_typ) {onpi_mask_en_narrow_typ}});


  /*  Convert the CAP rdata bus into an array of AV_MM_DATA_W width */
  generate
    for(i=0;i<NUM_SLICES_PER_CAP;i++)
    begin : gen_cap_rdata_slices
      if((i==NUM_SLICES_PER_CAP-1)  &&  (CAP_SLICE_RESIDUE  > 0))
      begin
        assign  cap_rdata_slices[i]  = {{(AV_MM_DATA_W-CAP_SLICE_RESIDUE){1'b0}},cap_rdata[(i*AV_MM_DATA_W) +:  CAP_SLICE_RESIDUE]};
      end
      else
      begin
        assign  cap_rdata_slices[i]  = cap_rdata[(i*AV_MM_DATA_W) +:  AV_MM_DATA_W];
      end
    end
  endgenerate

  /*  Interfacing with Capture FIFO */
  generate
    if(MODE ==  "avl")
    begin
      assign  cap_rden             = 1'b0;
      assign  cap_fifo_rdata_reg   = 'hdeadbabe;

    end
    else  //MODE  ==  "standalone"
    begin
      always@(posedge clk_logic,  negedge rst_logic_n)
      begin
        if(~rst_logic_n)
        begin
          cap_rden             <=  0;
        end
        else
        begin
          cap_rden             <=  we_cap_fifo_cntrl_reg_cr.cap_fifo_rden & handcode_wdata_cap_fifo_cntrl_reg_cr.cap_fifo_rden;
        end
      end

      assign  cap_fifo_rdata_reg   = cap_rdata_slices[cap_fifo_rdata_slice_idx];
    end
  endgenerate

  //------------------------------------------------------//
  //    REQ SIGNALS        :     ACK SIGNALS              //
  //------------------------------------------------------//
  // req.valid     : ack.read_valid       //
  // req.opcode    : ack.read_miss        //
  // req.addr      : ack.write_valid      //
  // req.be        : ack.write_miss       //
  // req.data      : ack.sai_successfull  //
  // req.sai       : ack.data             //
  // req.fid       :                      //
  // req.bar       :                      //
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

  assign rst_logic_n = ~rsi_reset;

endmodule //AW_fpga_onpi100g_mon_csr
