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
//
/*
 --------------------------------------------------------------------------
 -- Project Code      : IMPrES
 -- Module Name       : IW_fpga_generic_replay_xactor
 -- Author            : Vinod Kumar Boya
 -- Associated modules:  
 -- Function          : Generates generic protocol traffic which are stored as ROM data to respective monitor modulues
 --------------------------------------------------------------------------
*/

`timescale 1ns / 10ps

module IW_fpga_generic_replay_xactor #(
    parameter INSTANCE_NAME    = "replay_xactor"       // Can hold upto 16 ASCII characters
  , parameter AV_MM_DATA_W     = 32
  , parameter AV_MM_ADDR_W     = 8
  , parameter ROM_MIF_PATH     = "./mifs/onpi100g_protocol_xactor.mif"
  , parameter ROM_DATA_WIDTH   = 32 
  , parameter ROM_DATA_DEPTH   = 64
  , parameter READ_MISS_VAL    = 32'hDEADBABE   // Read miss value
) (
  /*  CSR Interface */
    input   logic                      clk_csr
  , input   logic                      rst_csr_n
  /* Avalon MM interface */
  , input  wire [AV_MM_ADDR_W-1:0]     avl_mm_address          // avl_mm.address
  , output reg  [AV_MM_DATA_W-1:0]     avl_mm_readdata         //       .readdata
  , input  wire                        avl_mm_read             //       .read
  , output reg                         avl_mm_readdatavalid    //       .readdatavalid
  , input  wire                        avl_mm_write            //       .write
  , input  wire [AV_MM_DATA_W-1:0]     avl_mm_writedata        //       .writedata
  , input  wire [(AV_MM_DATA_W/8)-1:0] avl_mm_byteenable       //       .byteenable
  , output wire                        avl_mm_waitrequest      //       .waitrequest
  /*  Logic Interface */
  , input  logic                       clk_logic
  , input  logic                       rst_logic_n
  
  , output wire [ROM_DATA_WIDTH-1:0]   generic_intf_out_bus 
);

 /* Importing Packages */
  import IW_fpga_generic_replay_xactor_addr_map_pkg::*;
  import rtlgen_pkg_IW_fpga_generic_replay_xactor_addr_map::*;

 typedef enum logic [1:0] {
    IDLE                  = 2'b00,
    SEND_CNTS_DATA_PKTS   = 2'b01,
    SEND_FIXED_DATA_PKTS  = 2'b10
} fsm_state_type_t;

// /* Internal Parameters */
localparam  ROM_ADDR_WIDTH   = $clog2(ROM_DATA_DEPTH);

 /* Internal Signals */
 reg   [0:15][7:0] inst_name_str = INSTANCE_NAME;
 fsm_state_type_t             replay_xactor_fsm;
 wire [ROM_DATA_WIDTH-1:0]    rom_data;
 reg  [ROM_ADDR_WIDTH-1:0]    rom_addr;
 reg  [31:0]                  rom_rd_loop_cnt;
 reg  [31:0]                  rom_rd_loop_cnt_sync;
 reg  [15:0]                  max_loop_cnt;
 reg  [15:0]                  max_loop_cnt_sync;
 reg                          send_continous_pkts;
 reg                          reset_stats_cntr;
 wire                         rom_max_addr_reached;
 wire                         rom_max_loop_cnt_reached;
 reg                          replay_xactor_enable;
 wire                         replay_xactor_enable_sync;
 reg                          reset_stats_cntr_pulse;
 wire                         reset_stats_cntr_pulse_sync;
 integer n;

 /* Register module ports */
 new_inst_name0_reg_cr_t                          new_inst_name0_reg_cr;
 new_inst_name1_reg_cr_t                          new_inst_name1_reg_cr;
 new_inst_name2_reg_cr_t                          new_inst_name2_reg_cr;
 new_inst_name3_reg_cr_t                          new_inst_name3_reg_cr;
 new_xactor_rom_replay_cnt_reg_cr_t               new_xactor_rom_replay_cnt_reg_cr;
 handcode_rdata_cntrl_reg_cr_t                    handcode_rdata_cntrl_reg_cr;
 handcode_wdata_cntrl_reg_cr_t                    handcode_wdata_cntrl_reg_cr;
 we_cntrl_reg_cr_t                                we_cntrl_reg_cr;
 cntrl_reg_cr_t                                   cntrl_reg_cr;
 inst_name0_reg_cr_t                              inst_name0_reg_cr;
 inst_name1_reg_cr_t                              inst_name1_reg_cr;
 inst_name2_reg_cr_t                              inst_name2_reg_cr;
 inst_name3_reg_cr_t                              inst_name3_reg_cr;
 xactor_rom_replay_cnt_reg_cr_t                   xactor_rom_replay_cnt_reg_cr;
 IW_fpga_generic_replay_xactor_addr_map_cr_req_t  req;
 IW_fpga_generic_replay_xactor_addr_map_cr_ack_t  ack;

 /* Replay transactor ROM instatiation. It stores data packets for monitor modules  */
 fpga_rom #(
  .MIF_PATH    (ROM_MIF_PATH    ),
  .DATA_WIDTH  (ROM_DATA_WIDTH  ),
  .ROM_DEPTH   (ROM_DATA_DEPTH  ),
  .ADDR_WIDTH  (ROM_ADDR_WIDTH  )
 ) u_replay_xactor_rom (
  .address (rom_addr)
 ,.clock   (clk_logic)
 ,.rden    (1'b1)
 ,.q       (rom_data)
 );

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

    replay_xactor_enable = cntrl_reg_cr.replay_xactor_enable; 
    send_continous_pkts  = cntrl_reg_cr.continous_en;
    reset_stats_cntr     = cntrl_reg_cr.reset_stats_cntr;
    max_loop_cnt         = cntrl_reg_cr.max_loop_cnt;
    new_xactor_rom_replay_cnt_reg_cr.xactor_rom_replay_cnt = rom_rd_loop_cnt_sync;
  end

  /* Register module instantiation */
  IW_fpga_generic_replay_xactor_addr_map u_addr_map (
       .gated_clk                         (clk_csr)
      ,.rst_n                             (rst_csr_n)
      ,.new_inst_name0_reg_cr             (new_inst_name0_reg_cr)
      ,.new_inst_name1_reg_cr             (new_inst_name1_reg_cr)
      ,.new_inst_name2_reg_cr             (new_inst_name2_reg_cr)
      ,.new_inst_name3_reg_cr             (new_inst_name3_reg_cr)
      ,.new_xactor_rom_replay_cnt_reg_cr  (new_xactor_rom_replay_cnt_reg_cr)
      ,.cntrl_reg_cr                      (cntrl_reg_cr)
      ,.inst_name0_reg_cr                 (inst_name0_reg_cr)
      ,.inst_name1_reg_cr                 (inst_name1_reg_cr)
      ,.inst_name2_reg_cr                 (inst_name2_reg_cr)
      ,.inst_name3_reg_cr                 (inst_name3_reg_cr)
      ,.xactor_rom_replay_cnt_reg_cr      (xactor_rom_replay_cnt_reg_cr)
      ,.handcode_rdata_cntrl_reg_cr       (handcode_rdata_cntrl_reg_cr)
      ,.handcode_wdata_cntrl_reg_cr       (handcode_wdata_cntrl_reg_cr)
      ,.we_cntrl_reg_cr                   (we_cntrl_reg_cr)
      ,.req                               (req)
      ,.ack                               (ack)
     );

  // Generate a replay transactor enable pulse 
  // added based on handcode output
  always@(posedge clk_csr, negedge rst_csr_n)
  begin
    if(~rst_csr_n)
    begin
      reset_stats_cntr_pulse <=  0;
    end
    else
    begin
      reset_stats_cntr_pulse <=  we_cntrl_reg_cr.reset_stats_cntr & handcode_wdata_cntrl_reg_cr.reset_stats_cntr;
    end
  end

  // Sync module instance to sync replay_xactor_enable signal 
  IW_fpga_double_sync  #(
    .WIDTH      (1)
   ,.NUM_STAGES (2) 
  ) u_replay_xactor_en_double_sync (
    .clk     (clk_logic)
   ,.sig_in  (replay_xactor_enable)
   ,.sig_out (replay_xactor_enable_sync)
  );

  // Sync module instance to sync max_loop_cnt  
  IW_fpga_double_sync  #(
    .WIDTH      (16)
   ,.NUM_STAGES (2) 
  ) u_max_loop_cnt_double_sync (
    .clk     (clk_logic)
   ,.sig_in  (max_loop_cnt)
   ,.sig_out (max_loop_cnt_sync)
  );

  // Pulse sync module to sync reset statistics pulse from clk_csr to clk_logic domain  
  IW_async_pulses #(
    .WIDTH   ( 2 )
  ) u_reset_stats_cntr_pulse_sync (
     .clk_src   (clk_csr) 
    ,.rst_src_n (rst_csr_n) 
    ,.data      (reset_stats_cntr_pulse)
    ,.clk_dst   (clk_logic)
    ,.rst_dst_n (rst_logic_n) 
    ,.data_sync (reset_stats_cntr_pulse_sync) 
  );

  // Sync module instance to sync max_loop_cnt for clock conversion(clk_logic to clk_csr)
  IW_fpga_double_sync  #(
    .WIDTH      (32)
   ,.NUM_STAGES (1) 
  ) u_rom_rd_cnt_double_sync (
    .clk     (clk_csr)
   ,.sig_in  (rom_rd_loop_cnt)
   ,.sig_out (rom_rd_loop_cnt_sync)
  );

  //------------------------------------------------------//
  // Register module config request signals logic         //
  //------------------------------------------------------//
  //Request is valid for any read or write transaction occurs when waitrequest
  //is inactive/low 
  assign req.valid  = (avl_mm_write||avl_mm_read) && (!avl_mm_waitrequest);
  //Register CFG opcode selection
  assign req.opcode = avl_mm_write? CFGWR : CFGRD;
  //Register CFG address excpets 48bit. Appending zeros to 
  //AV MM slave address
  assign req.addr   = {'h0,avl_mm_address};
  assign req.be     = avl_mm_byteenable;
  assign req.data   = avl_mm_writedata;
  assign req.sai    = 7'h00;
  assign req.fid    = 7'h00;
  assign req.bar    = 3'h0;

  //AV MM Slave waitrequest
  assign avl_mm_waitrequest = 1'b0;
  //AV MM Slave read data valid is registered CFG ack's read_valid or read_miss
  always @(posedge clk_csr or negedge rst_csr_n)
  begin
    if(!rst_csr_n)
      avl_mm_readdatavalid <= 1'b0;
    else
      avl_mm_readdatavalid <= ack.read_valid || ack.read_miss;
  end
  //AV MM Slave read data 
  always @(posedge clk_csr or negedge rst_csr_n)
  begin
    if(!rst_csr_n)
      avl_mm_readdata <= 'h0;
    else if(ack.read_miss)
      avl_mm_readdata <= READ_MISS_VAL;
    else if(ack.read_valid)
      avl_mm_readdata <= ack.data;
    else
      avl_mm_readdata <= 'h0;
  end

 assign rom_max_addr_reached     = (rom_addr == ROM_DATA_DEPTH-1)? 1'b1 : 1'b0;
 assign rom_max_loop_cnt_reached = (rom_rd_loop_cnt == max_loop_cnt_sync)? 1'b1 : 1'b0;

  // replay transactor fsm logic
  always @(posedge clk_logic or negedge rst_logic_n)
  begin
    if(~rst_logic_n)
      replay_xactor_fsm <= IDLE;
    else begin
      case (replay_xactor_fsm)
        IDLE :
          if(replay_xactor_enable_sync == 1'b1)
            if(send_continous_pkts == 1'b1)
              replay_xactor_fsm <= SEND_CNTS_DATA_PKTS;
            else
              replay_xactor_fsm <= SEND_FIXED_DATA_PKTS;
          else
            replay_xactor_fsm <= IDLE;
        SEND_CNTS_DATA_PKTS :
          if(replay_xactor_enable_sync == 1'b0)
            replay_xactor_fsm <= IDLE;
          else
            replay_xactor_fsm <= SEND_CNTS_DATA_PKTS;
        SEND_FIXED_DATA_PKTS :
          if(replay_xactor_enable_sync == 1'b0)
            replay_xactor_fsm <= IDLE;
          else
            replay_xactor_fsm <= SEND_FIXED_DATA_PKTS;
        default : 
          replay_xactor_fsm <= IDLE;
      endcase
    end
  end
                
  // Address generation logic to read pkt data from transactor ROM 
  always @(posedge clk_logic or negedge rst_logic_n)
  begin
    if(~rst_logic_n)
      rom_addr <= 'h0;
    else begin 
      case (replay_xactor_fsm)
        IDLE :
          rom_addr <= 'h0;
        SEND_CNTS_DATA_PKTS :
          if (rom_max_addr_reached)
            rom_addr <= 'h0;
          else
            rom_addr <= rom_addr+1;
        SEND_FIXED_DATA_PKTS :
          case({rom_max_loop_cnt_reached,rom_max_addr_reached})
            2'b00 : rom_addr <= rom_addr+1; 
            2'b01 : rom_addr <= 'h0;
            2'b10 : rom_addr <= rom_addr;
            2'b11 : rom_addr <= rom_addr;
            default : rom_addr <= 'h0;
          endcase
          /*if(rom_max_addr_reached)
            if(rom_max_loop_cnt_reached)
               rom_addr <= rom_addr;
            else
              rom_addr <= 'h0;
          else
            rom_addr <= rom_addr+1;*/
        default : rom_addr <= 'h0;
      endcase
    end
  end

  // ROM read loop count generation
  always @(posedge clk_logic or negedge rst_logic_n)
  begin
    if(~rst_logic_n)
      rom_rd_loop_cnt <= 'h0;
    else if(reset_stats_cntr_pulse_sync)
      rom_rd_loop_cnt <= 'h0;
    else if(rom_max_addr_reached)
      rom_rd_loop_cnt <= rom_rd_loop_cnt+1;
    else
      rom_rd_loop_cnt <= rom_rd_loop_cnt;
  end

assign generic_intf_out_bus = rom_data;

endmodule   // IW_fpga_generic_replay_xactor
