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
 -- Module Name       : IW_fpga_atspeed_capture_addr_map_csr_wrapper 
 -- Author            : Ranjith Kulai 
 -- Associated modules: 
 -- Function          : This module is a wrapper around the nebulon genrated address map.
                        It gives a CSR interface out.
 --------------------------------------------------------------------------
*/

`timescale 1ns/1ps

module IW_fpga_atspeed_capture_addr_map_csr_wrapper #(
    parameter INSTANCE_NAME       = "u_atspeed_capture"     //Can hold upto 16 ASCII characters
  , parameter CAPTURE_WIDTH       = 32                      //Width of payload
  , parameter CAP_FF_DEPTH        = 10
  , parameter Q_IDX               = 0
  , parameter DEBOUNCE_STAGES     = 3

  , parameter AV_ST_DATA_W        = 32                      // Data width

  , parameter READ_MISS_VAL       = 32'hDEADBABE            // Read miss value
  , parameter CSR_ADDR_WIDTH      = 24
  , parameter CSR_DATA_WIDTH      = 32
) (
  
    input   logic                                 clk_atspeed
  , input   logic                                 rst_atspeed_n
  /* control */
  , output  logic                                 capture_enable
  , output  logic                                 clr_fifo 

  /* status */
  , input   logic [$clog2(CAP_FF_DEPTH) -1:0]     fifo_occupancy
  , input   logic                                 fifo_full
  , input   logic                                 fifo_empty 
  , input   logic       [15:0]                    drop_count
  , input   logic       [7:0]                     rcvd_count
  , input   logic                                 capture_sticky
  , input   logic       [2:0]                     state_fsm
  , input   logic                                 drop_sticky
  , input   logic                                 load_capture
  , input   logic                                 load_drop
  , output  logic                                 trigger_sw

  //CSR Interface
  , input   logic                                 clk_csr 
  , input   logic                                 rst_csr_n

  , input   logic                                 csr_write
  , input   logic                                 csr_read
  , input   logic   [CSR_ADDR_WIDTH-1:0]          csr_addr
  , input   logic   [CSR_DATA_WIDTH-1:0]          csr_wr_data
  , output  logic   [CSR_DATA_WIDTH-1:0]          csr_rd_data
  , output  logic                                 csr_rd_valid
);

  import IW_fpga_atspeed_capture_addr_map_pkg::*;
  //import rtlgen_pkg_v12::*;
  import rtlgen_pkg_IW_fpga_atspeed_capture_addr_map::*;

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
  load_status_cr_t        load_status_cr;
  load_cntrl_reg_cr_t     load_cntrl_reg_cr;

  new_fifo_status_cr_t    new_fifo_status_cr;
  new_inst_name0_reg_cr_t new_inst_name0_reg_cr;
  new_inst_name1_reg_cr_t new_inst_name1_reg_cr;
  new_inst_name2_reg_cr_t new_inst_name2_reg_cr;
  new_inst_name3_reg_cr_t new_inst_name3_reg_cr;
  new_params0_reg_cr_t    new_params0_reg_cr;
  new_params1_reg_cr_t    new_params1_reg_cr;
  new_status_cr_t         new_status_cr;
  new_cntrl_reg_cr_t      new_cntrl_reg_cr;

  // Register Outputs
  cntrl_reg_cr_t          cntrl_reg_cr;
  fifo_status_cr_t        fifo_status_cr;
  inst_name0_reg_cr_t     inst_name0_reg_cr;
  inst_name1_reg_cr_t     inst_name1_reg_cr;
  inst_name2_reg_cr_t     inst_name2_reg_cr;
  inst_name3_reg_cr_t     inst_name3_reg_cr;
  params0_reg_cr_t        params0_reg_cr;
  params1_reg_cr_t        params1_reg_cr;
  status_cr_t             status_cr;

  // read/write interface
  IW_fpga_atspeed_capture_addr_map_cr_req_t     req;
  IW_fpga_atspeed_capture_addr_map_cr_ack_t     ack;

  // Load registers for self clearning bits
  always @(posedge clk_atspeed, negedge rst_atspeed_n) begin
    if(~rst_atspeed_n) begin
      load_cntrl_reg_cr.trigger_sw <= 1'b0;
      load_cntrl_reg_cr.clr_fifo   <= 1'b0;
    end else begin
      load_cntrl_reg_cr.trigger_sw  <= cntrl_reg_cr.trigger_sw;
      load_cntrl_reg_cr.clr_fifo    <= cntrl_reg_cr.clr_fifo;
    end
  end

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
  
    new_params0_reg_cr.capture_width  = CAPTURE_WIDTH;
    new_params0_reg_cr.q_idx          = Q_IDX;
    new_params0_reg_cr.debounce_stage = DEBOUNCE_STAGES;
  
    new_params1_reg_cr.av_st_data_width = AV_ST_DATA_W;
    new_params1_reg_cr.fifo_depth     = CAP_FF_DEPTH;
  
    new_status_cr.drop_count          = drop_count;
    new_status_cr.capture_sticky      = capture_sticky;
    new_status_cr.drop_sticky         = drop_sticky;
    new_status_cr.state_fsm           = state_fsm;
    new_status_cr.rcvd_count          = rcvd_count;

    new_cntrl_reg_cr.clr_fifo         = 1'b0;
    new_cntrl_reg_cr.trigger_sw       = 1'b0;

    load_status_cr.capture_sticky     = load_capture;
    load_status_cr.drop_sticky        = load_drop;

    capture_enable    =   cntrl_reg_cr.capture_enable;
    clr_fifo          =   cntrl_reg_cr.clr_fifo;
    trigger_sw        =   cntrl_reg_cr.trigger_sw;

    new_fifo_status_cr.fifo_occupancy = fifo_occupancy;
    new_fifo_status_cr.fifo_full      = fifo_full;
    new_fifo_status_cr.fifo_empty     = fifo_empty;
  
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
  IW_fpga_atspeed_capture_addr_map u_addr_map (
    .gated_clk                                    (clk_atspeed),
    .rtl_clk                                      (clk_atspeed),
    .rst_n                                        (rst_atspeed_n),
  
    .load_status_cr                               (load_status_cr),
    .load_cntrl_reg_cr                            (load_cntrl_reg_cr),
    .new_fifo_status_cr                           (new_fifo_status_cr),
    .new_inst_name0_reg_cr                        (new_inst_name0_reg_cr),
    .new_inst_name1_reg_cr                        (new_inst_name1_reg_cr),
    .new_inst_name2_reg_cr                        (new_inst_name2_reg_cr),
    .new_inst_name3_reg_cr                        (new_inst_name3_reg_cr),
    .new_params0_reg_cr                           (new_params0_reg_cr),
    .new_params1_reg_cr                           (new_params1_reg_cr),
    .new_status_cr                                (new_status_cr),
    .new_cntrl_reg_cr                             (new_cntrl_reg_cr),
  
    .cntrl_reg_cr                                 (cntrl_reg_cr),
    .fifo_status_cr                               (fifo_status_cr),
//    .inst_name0_reg_cr                            ( ),
//    .inst_name1_reg_cr                            ( ),
//    .inst_name2_reg_cr                            ( ),
//    .inst_name3_reg_cr                            ( ),
    .params0_reg_cr                               (params0_reg_cr),
    .params1_reg_cr                               (params1_reg_cr),
    .status_cr                                    (status_cr),
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

  always @(posedge clk_atspeed) begin
    if(ack.read_valid)
      logic2csr_rdata <= ack.data;
    else
      logic2csr_rdata <= READ_MISS_VAL;
  end

endmodule //IW_fpga_atspeed_capture_addr_map_csr_wrapper
