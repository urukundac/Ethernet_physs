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
 -- Project Code      : IMPrES
 -- Module Name       : IW_fpga_atspeed_trigger_addr_map_csr_wrapper 
 -- Author            : Ranjith Kulai 
 -- Associated modules: 
 -- Function          : This module is a wrapper around the nebulon genrated address map.
                        It gives a CSR interface out.
 --------------------------------------------------------------------------
*/

`timescale 1ns/1ps

module IW_fpga_atspeed_trigger_addr_map_csr_wrapper #(
    parameter INSTANCE_NAME              = "u_atspeed_trigger"     //Can hold upto 16 ASCII characters
  , parameter TRIGGER_SIGNAL_WIDTH       = 32                      //Width of trigger signals 
  , parameter Q_IDX                      = 0
  , parameter DEBOUNCE_STAGES            = 3
  , parameter NUM_FILT                   = 1


  , parameter READ_MISS_VAL              = 32'hDEADBABE            // Read miss value
  , parameter CSR_ADDR_WIDTH             = 24
  , parameter CSR_DATA_WIDTH             = 32
) (
    input   logic                               clk_atspeed
  /* control */
  , output  logic                               trigger_enable
  , output  logic                               trigger_sel
  , output  logic  [NUM_FILT-1:0] [31:0]        match_mask
  , output  logic  [NUM_FILT-1:0] [31:0]        match_value
  , output  logic  [NUM_FILT-1:0] [31:0]        mask_shift
  , output  logic  [NUM_FILT-1:0]               filter_enable
  /* status */
  , input   logic                               capture_trig_sent
  , input   logic                               ext_trig_rcvd
  , input   logic                               match_trig_rcvd
  , input   logic                               logic_trig_rcvd
  , input   logic                               load_capture_trig_sent
  , input   logic                               load_ext_trig_rcvd
  , input   logic                               load_match_trig_rcvd
  , input   logic                               load_logic_trig_rcvd
  , input   logic [5:0]                         state_fsm

  /* CSR Interface */
  , input   logic                               clk_csr 
  , input   logic                               rst_csr_n

  , input   logic                               csr_write
  , input   logic                               csr_read
  , input   logic   [CSR_ADDR_WIDTH-1:0]        csr_addr
  , input   logic   [CSR_DATA_WIDTH-1:0]        csr_wr_data
  , output  logic   [CSR_DATA_WIDTH-1:0]        csr_rd_data
  , output  logic                               csr_rd_valid
);

  import IW_fpga_atspeed_trigger_addr_map_pkg::*;
  //import rtlgen_pkg_v12::*;
  import rtlgen_pkg_IW_fpga_atspeed_trigger_addr_map::*;

  // Internal Signals  
  genvar  i;
  integer n;
  reg   [0:15][7:0] inst_name_str = INSTANCE_NAME;

  localparam REQ_DATA_W         = CSR_ADDR_WIDTH + CSR_DATA_WIDTH + 1;
  localparam RSP_DATA_W         = CSR_DATA_WIDTH;

  localparam  REQ_FF_W          = (REQ_DATA_W <=  32) ? 32  :
                                  (REQ_DATA_W <=  64) ? 64  :
                                  (REQ_DATA_W <=  96) ? 96  : 1;

  localparam  RSP_FF_W          = (RSP_DATA_W <=  32) ? 32  :
                                  (RSP_DATA_W <=  64) ? 64  :
                                  (RSP_DATA_W <=  96) ? 96  : 1;

  logic                       req_ff_full;
  logic                       req_ff_wren;
  logic [REQ_FF_W-1:0]        req_ff_wdata;
  logic                       req_ff_empty;
  logic                       req_ff_rden;
  logic [REQ_FF_W-1:0]        req_ff_rdata;

  logic                       rsp_ff_full;
  logic                       rsp_ff_wren;
  logic [RSP_FF_W-1:0]        rsp_ff_wdata;
  logic                       rsp_ff_empty;
  logic                       rsp_ff_rden;
  logic [RSP_FF_W-1:0]        rsp_ff_rdata;

  logic                       csr2logic_wren;
  logic                       csr2logic_rden;
  logic [CSR_ADDR_WIDTH-1:0]  csr2logic_addr;
  logic [CSR_DATA_WIDTH-1:0]  csr2logic_wdata;
  logic                       logic2csr_rdata_valid;
  logic [CSR_DATA_WIDTH-1:0]  logic2csr_rdata;

  // Register Inputs
  new_inst_name0_reg_cr_t  new_inst_name0_reg_cr;
  new_inst_name1_reg_cr_t  new_inst_name1_reg_cr;
  new_inst_name2_reg_cr_t  new_inst_name2_reg_cr;
  new_inst_name3_reg_cr_t  new_inst_name3_reg_cr;
  new_params0_reg_cr_t     new_params0_reg_cr;
  new_status_reg_cr_t      new_status_reg_cr;
  load_status_reg_cr_t     load_status_reg_cr;
  
  // Register Outputs
  cntrl_reg_cr_t  cntrl_reg_cr;
  data_mask_0_cr_t  data_mask_0_cr;
  data_mask_1_cr_t  data_mask_1_cr;
  data_mask_2_cr_t  data_mask_2_cr;
  data_mask_3_cr_t  data_mask_3_cr;
  inst_name0_reg_cr_t  inst_name0_reg_cr;
  inst_name1_reg_cr_t  inst_name1_reg_cr;
  inst_name2_reg_cr_t  inst_name2_reg_cr;
  inst_name3_reg_cr_t  inst_name3_reg_cr;
  mask_shift_value_0_cr_t  mask_shift_value_0_cr;
  mask_shift_value_1_cr_t  mask_shift_value_1_cr;
  mask_shift_value_2_cr_t  mask_shift_value_2_cr;
  mask_shift_value_3_cr_t  mask_shift_value_3_cr;
  match_value_0_cr_t  match_value_0_cr;
  match_value_1_cr_t  match_value_1_cr;
  match_value_2_cr_t  match_value_2_cr;
  match_value_3_cr_t  match_value_3_cr;
  params0_reg_cr_t  params0_reg_cr;
  
    // read/write interface
  IW_fpga_atspeed_trigger_addr_map_cr_req_t  req;
  IW_fpga_atspeed_trigger_addr_map_cr_ack_t  ack;
  
  
  
  //Assigning HW inputs to register fields
  always@(*)
  begin
  
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
  
    new_params0_reg_cr.trigger_signal_width = TRIGGER_SIGNAL_WIDTH;
    new_params0_reg_cr.q_idx          = Q_IDX;
    new_params0_reg_cr.debounce_stage = DEBOUNCE_STAGES;

	new_status_reg_cr.capture_trig_sent    = capture_trig_sent;
	new_status_reg_cr.ext_trig_rcvd        = ext_trig_rcvd;
	new_status_reg_cr.match_trig_rcvd      = match_trig_rcvd;
	new_status_reg_cr.logic_trig_rcvd      = logic_trig_rcvd;
        new_status_reg_cr.state_fsm            = state_fsm;

	load_status_reg_cr.capture_trig_sent   = load_capture_trig_sent;
	load_status_reg_cr.ext_trig_rcvd       = load_ext_trig_rcvd;
	load_status_reg_cr.match_trig_rcvd     = load_match_trig_rcvd;
	load_status_reg_cr.logic_trig_rcvd     = load_logic_trig_rcvd;

    trigger_enable = cntrl_reg_cr.trigger_enable;
    filter_enable  = cntrl_reg_cr.filter_enable;
    trigger_sel    = cntrl_reg_cr.trigger_sel; 

    match_mask[0]  = data_mask_0_cr.match_mask;
    match_mask[1]  = data_mask_1_cr.match_mask;
    match_mask[2]  = data_mask_2_cr.match_mask;
    match_mask[3]  = data_mask_3_cr.match_mask;

    match_value[0] = match_value_0_cr.match_value;
    match_value[1] = match_value_1_cr.match_value; 
    match_value[2] = match_value_2_cr.match_value;
    match_value[3] = match_value_3_cr.match_value;
  
    mask_shift[0] = mask_shift_value_0_cr.shift_mask_value;
    mask_shift[1] = mask_shift_value_1_cr.shift_mask_value; 
    mask_shift[2] = mask_shift_value_2_cr.shift_mask_value;
    mask_shift[3] = mask_shift_value_3_cr.shift_mask_value;
  
  end

  // Synchronization of Read/Requests from CSR domain to Atspeed
  // clock domain and vice versa happens through Request and response
  // buffers.

  IW_fpga_async_fifo #(
     .ADDR_WD (9),
     .DATA_WD (REQ_FF_W) ) u_req_ff
   (
     .rstn                         (rst_csr_n),
     .data                         (req_ff_wdata),
     .rdclk                        (clk_atspeed),
     .rdreq                        (req_ff_rden),
     .wrclk                        (clk_csr),
     .wrreq                        (req_ff_wren),
     .q                            (req_ff_rdata),
     .rdempty                      (req_ff_empty),
     .rdusedw                      (),
     .wrfull                       (req_ff_full),
     .wrusedw                      ()
   );
  
  assign  req_ff_wdata = {{(REQ_FF_W-REQ_DATA_W){1'b0}},
                          csr_addr, csr_wr_data,csr_write};
  assign  req_ff_wren  = csr_write | csr_read;
  assign  req_ff_rden  = ~req_ff_empty;

  assign  {csr2logic_addr, csr2logic_wdata} = req_ff_rdata[REQ_DATA_W-1:1];
  assign  csr2logic_wren = req_ff_rdata[0] & (~req_ff_empty);
  assign  csr2logic_rden = ~req_ff_rdata[0] & (~req_ff_empty);

  IW_fpga_async_fifo #(
     .ADDR_WD (9),
     .DATA_WD (RSP_FF_W) ) u_rsp_ff
   (
     .rstn                         (rst_csr_n),
     .data                         (rsp_ff_wdata),
     .rdclk                        (clk_csr),
     .rdreq                        (rsp_ff_rden),
     .wrclk                        (clk_atspeed),
     .wrreq                        (rsp_ff_wren),
     .q                            (rsp_ff_rdata),
     .rdempty                      (rsp_ff_empty),
     .rdusedw                      (),
     .wrfull                       (rsp_ff_full),
     .wrusedw                      ()
   );
   assign rsp_ff_wren = logic2csr_rdata_valid;
   assign rsp_ff_wdata = logic2csr_rdata;
   assign rsp_ff_rden = ~rsp_ff_empty;

   assign csr_rd_valid = rsp_ff_rden;
   assign csr_rd_data  = rsp_ff_rdata;


  // clock and reset sync register module instantiation
  IW_fpga_atspeed_trigger_addr_map u_addr_map (
    .gated_clk                                    (clk_atspeed),
	.rtl_clk                                      (clk_atspeed),
    .rst_n                                        (rst_csr_n),
  
    .new_inst_name0_reg_cr                       (new_inst_name0_reg_cr),
    .new_inst_name1_reg_cr                       (new_inst_name1_reg_cr),
    .new_inst_name2_reg_cr                       (new_inst_name2_reg_cr),
    .new_inst_name3_reg_cr                       (new_inst_name3_reg_cr),
    .new_params0_reg_cr                          (new_params0_reg_cr),
	.new_status_reg_cr                           (new_status_reg_cr),
	.load_status_reg_cr                          (load_status_reg_cr),

    .cntrl_reg_cr                                 (cntrl_reg_cr),
    .data_mask_0_cr                               (data_mask_0_cr),
    .data_mask_1_cr                               (data_mask_1_cr),
    .data_mask_2_cr                               (data_mask_2_cr),
    .data_mask_3_cr                               (data_mask_3_cr),
    .inst_name0_reg_cr                            (inst_name0_reg_cr),
    .inst_name1_reg_cr                            (inst_name1_reg_cr),
    .inst_name2_reg_cr                            (inst_name2_reg_cr),
    .inst_name3_reg_cr                            (inst_name3_reg_cr),
    .mask_shift_value_0_cr                        (mask_shift_value_0_cr),
    .mask_shift_value_1_cr                        (mask_shift_value_1_cr),
    .mask_shift_value_2_cr                        (mask_shift_value_2_cr),
    .mask_shift_value_3_cr                        (mask_shift_value_3_cr),
    .match_value_0_cr                             (match_value_0_cr),
    .match_value_1_cr                             (match_value_1_cr),
    .match_value_2_cr                             (match_value_2_cr),
    .match_value_3_cr                             (match_value_3_cr),
    .params0_reg_cr                               (params0_reg_cr),
 
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
  //Request is valid for any read or write transaction
  assign req.valid  = csr2logic_wren | csr2logic_rden;

  //Register CFG opcode selection
  assign req.opcode = csr2logic_wren  ? CFGWR : CFGRD;

  //Register CFG address excpets 48bit. Appending zeros to CSR slave address
  assign req.addr   = {{(48-CSR_ADDR_WIDTH){1'b0}},csr2logic_addr};

  assign req.be     = {(CSR_DATA_WIDTH/8){1'b1}};
  assign req.data   = csr2logic_wdata;
  assign req.sai    = 7'h00;
  assign req.fid    = 7'h00;
  assign req.bar    = 3'h0;
 
  //CSR Slave read response logic
  always @(posedge clk_atspeed)
    logic2csr_rdata_valid <=  ack.read_valid | ack.read_miss;

  always @(posedge clk_atspeed)
    if(ack.read_valid)
	  logic2csr_rdata <= ack.data;
	else
	  logic2csr_rdata <= READ_MISS_VAL;

endmodule //IW_fpga_atspeed_trigger_addr_map_csr_wrapper
