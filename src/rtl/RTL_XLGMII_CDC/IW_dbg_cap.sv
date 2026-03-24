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
// File Name:     $RCSfile: IW_dbg_cap.sv.rca $
// File Revision: $Revision: 1.1 $
// Created by:    Gregory James
// Updated by:    $Author: gjames $ $Date: Thu Nov 19 03:36:17 2015 $
//------------------------------------------------------------------------------

`timescale  1ns/1ps

module  IW_dbg_cap  #(
    parameter CAPTURE_DATA_WIDTH   = 32
  , parameter CAPTURE_DATA_DEPTH   = 16
  , parameter INFRA_AVST_CHNNL_W   = 8
  , parameter INFRA_AVST_DATA_W    = 8
  , parameter INFRA_AVST_CHNNL_ID  = 8
  , parameter INSTANCE_NAME        = "u_dbg_cap"  //Can hold upto 16 ASCII characters

  , parameter CSR_ADDR_WIDTH       = 3*INFRA_AVST_DATA_W
  , parameter CSR_DATA_WIDTH       = 4*INFRA_AVST_DATA_W


  /*  Do Not Modify */
  , parameter DEBUG_DATA_WIDTH     = 32
  , parameter NUM_DEBUG_REGS       = 16 //should be greater than 10

) (

    input   wire  clk_logic
  , input   wire  rst_logic_n

  /*  Capture Data Interface  */
  , input   wire                            cap_trigger
  , input   wire                            cap_wren
  , input   wire  [CAPTURE_DATA_WIDTH-1:0]  cap_data
  , output  reg                             cap_done

  // Infra-Avst Ports
  , input                                 clk_avst
  , input                                 rst_avst_n
  , output                                avst_ingr_ready
  , input                                 avst_ingr_valid
  , input                                 avst_ingr_startofpacket
  , input                                 avst_ingr_endofpacket
  , input  [INFRA_AVST_CHNNL_W-1:0]       avst_ingr_channel
  , input  [INFRA_AVST_DATA_W-1:0]        avst_ingr_data

  , input                                 avst_egr_ready
  , output                                avst_egr_valid
  , output                                avst_egr_startofpacket
  , output                                avst_egr_endofpacket
  , output [INFRA_AVST_CHNNL_W-1:0]       avst_egr_channel
  , output [INFRA_AVST_DATA_W-1:0]        avst_egr_data

);

  /*  Internal  Parameters  */
  localparam  MEM_DATA_W  = CAPTURE_DATA_WIDTH;
  localparam  MEM_DEPTH   = CAPTURE_DATA_DEPTH;
  localparam  MEM_ADDR_W  = $clog2(MEM_DEPTH);

  localparam  NUM_DBG_BITS_LAST_WORD  = CAPTURE_DATA_WIDTH  % DEBUG_DATA_WIDTH;
  localparam  NUM_DBG_WORDS_PER_ADDR  = (NUM_DBG_BITS_LAST_WORD)  ? (CAPTURE_DATA_WIDTH/DEBUG_DATA_WIDTH) + 1 : (CAPTURE_DATA_WIDTH/DEBUG_DATA_WIDTH);


  /*  Internal Variables  */
  genvar  i;

  wire                              mem_wren;
  reg   [MEM_ADDR_W-1:0]            mem_waddr;
  wire  [MEM_DATA_W-1:0]            mem_wdata;
  wire  [MEM_ADDR_W-1:0]            mem_raddr;
  wire  [MEM_DATA_W-1:0]            mem_rdata;
  wire  [DEBUG_DATA_WIDTH-1:0]      mem_rdata_slices  [NUM_DBG_WORDS_PER_ADDR-1:0];

  reg                               cap_en;
  reg                               cap_mode;
  reg                               stop_on_cap_full;
  reg   [(DEBUG_DATA_WIDTH/2)-1:0]  cap_num_samples_before_trig;
  wire                              cap_wren_advanced;
  wire                              cap_wren_simple;

  reg                               waiting_for_trig;
  reg   [(DEBUG_DATA_WIDTH/2)-1:0]  cap_cnt;
  reg   [(DEBUG_DATA_WIDTH/2)-1:0]  cap_raddr_start;

  reg   [(DEBUG_DATA_WIDTH/2)-1:0]  cap_rsample_num;
  reg   [(DEBUG_DATA_WIDTH/2)-1:0]  cap_rdata_idx;

  reg   [(DEBUG_DATA_WIDTH+2)-1:0]  sync2mon  [1:0];
  wire                              cap_done_sync;
  wire                              waiting_for_trig_sync;
  wire  [(DEBUG_DATA_WIDTH/2)-1:0]  cap_cnt_sync;
  wire  [(DEBUG_DATA_WIDTH/2)-1:0]  cap_raddr_start_sync;
  integer n;
  reg  [0:15][7:0]                   inst_name_str = INSTANCE_NAME;
  wire                               csr_write;
  wire                               csr_read;
  wire [(3*INFRA_AVST_CHNNL_W)-1:0]  csr_addr;
  wire [(4*INFRA_AVST_DATA_W)-1:0]   csr_wr_data;
  reg  [(4*INFRA_AVST_DATA_W)-1:0]   csr_rd_data;
  reg                                csr_rd_valid;

  reg  [(4*INFRA_AVST_DATA_W)-1:0]   params_reg;
  reg  [(4*INFRA_AVST_DATA_W)-1:0]   dbg_ctrl_reg;
  reg  [(4*INFRA_AVST_DATA_W)-1:0]   dbg_status_reg;
  reg  [(4*INFRA_AVST_DATA_W)-1:0]   dbg_start_addr_reg;
  reg  [(4*INFRA_AVST_DATA_W)-1:0]   dbg_rd_ctrl_reg;
  reg  [(4*INFRA_AVST_DATA_W)-1:0]   dbg_rd_data_reg;

  /*  Write Logic */
  always@(posedge clk_logic,  negedge rst_logic_n)
  begin
    if(~rst_logic_n)
    begin
      waiting_for_trig        <=  1'b1;
      cap_cnt                 <=  0;
      cap_done                <=  0;
      cap_raddr_start         <=  0;

      mem_waddr               <=  0;
    end
    else
    begin

      //Flag to be set once trigger comes
      if(waiting_for_trig)
      begin
        waiting_for_trig      <=  (cap_en  & cap_trigger) ? 1'b0  : waiting_for_trig;
      end
      else  //Reset Flag
      begin
        waiting_for_trig      <=  ~cap_en  ? 1'b1  : waiting_for_trig;
      end

      //Remember the address where first write came from
      if(waiting_for_trig & mem_wren)
      begin
        cap_raddr_start       <=  {{((DEBUG_DATA_WIDTH/2)-MEM_ADDR_W){1'b0}}, mem_waddr};
      end
      else
      begin
        cap_raddr_start       <=  cap_raddr_start;
      end

      if(~cap_en)
      begin
        cap_done              <=  0;
        cap_cnt               <=  cap_mode ? cap_num_samples_before_trig  : 0;
      end
      else
      begin
        cap_done              <=  (cap_cnt  ==  CAPTURE_DATA_DEPTH-1) ? mem_wren  : cap_done;

        if(cap_done)  //Freeze
        begin
          cap_cnt             <=  cap_cnt;
        end
        else if(cap_mode)  //Advanced
        begin
          cap_cnt             <=  waiting_for_trig  ? cap_cnt + cap_trigger : cap_cnt + cap_wren;
        end
        else  //Simple
        begin
          cap_cnt             <=  cap_cnt + cap_wren_simple;
        end
      end

      if(~cap_en)  //Reset
      begin
        mem_waddr             <=  0;
      end
      else
      begin
        if(mem_waddr  ==  CAPTURE_DATA_DEPTH-1) //Rollover
        begin
          mem_waddr           <=  mem_wren  ? 0 : mem_waddr;
        end
        else
        begin
          mem_waddr           <=  mem_waddr + mem_wren;
        end
      end
    end
  end

  assign  cap_wren_advanced = waiting_for_trig  ? cap_trigger | cap_wren  : cap_wren;
  assign  cap_wren_simple   = cap_trigger & cap_wren;

  //Memory write interface
  assign  mem_wren  = (~cap_mode)  ? cap_en & cap_wren_simple   & ~(stop_on_cap_full & cap_done)   //Simple Mode
                                   : cap_en & cap_wren_advanced & ~(stop_on_cap_full & cap_done);  //Advanced Mode

  assign  mem_wdata = cap_data;

  /*  Read Logic  */
  assign  mem_raddr           = cap_rsample_num[MEM_ADDR_W-1:0];

  generate
    for(i=0;i<NUM_DBG_WORDS_PER_ADDR;i++)
    begin : gen_mem_rdata_slices
      if((i==NUM_DBG_WORDS_PER_ADDR-1)  &&  (NUM_DBG_BITS_LAST_WORD > 0))
      begin
        assign  mem_rdata_slices[i] = mem_rdata[(i*DEBUG_DATA_WIDTH)  +:  NUM_DBG_BITS_LAST_WORD];
      end
      else
      begin
        assign  mem_rdata_slices[i] = mem_rdata[(i*DEBUG_DATA_WIDTH)  +:  DEBUG_DATA_WIDTH];
      end
    end
  endgenerate


  /*  Debug Registers */
  //Capture Parameter0 Register
  assign  params_reg[DEBUG_DATA_WIDTH-1:(DEBUG_DATA_WIDTH/2)]  = CAPTURE_DATA_DEPTH;
  assign  params_reg[(DEBUG_DATA_WIDTH/2)-1:0]                 = CAPTURE_DATA_WIDTH;

  //Capture Status Register
  assign  dbg_status_reg                                       = {   cap_cnt
                                                                   , {((DEBUG_DATA_WIDTH/2)-2){1'b0}}
                                                                   , waiting_for_trig
                                                                   , cap_done
                                                                 };

  //Capture Start Address Register
  assign  dbg_start_addr_reg                                   = {   {(DEBUG_DATA_WIDTH/2){1'b0}}
                                                                   , cap_raddr_start
                                                                 };

  //Capture Read Data Register
  assign  dbg_rd_data_reg                                      = mem_rdata_slices[cap_rdata_idx];

/* AVST2CSR instance  */
IW_fpga_avst2csr #(
      .AVST_CHANNEL_ID      (INFRA_AVST_CHNNL_ID)
     ,.AVST_CHANNEL_WIDTH   (INFRA_AVST_CHNNL_W)
     ,.AVST_DATA_WIDTH      (INFRA_AVST_DATA_W)
     ,.CSR_ADDR_WIDTH       (CSR_ADDR_WIDTH)
     ,.CSR_DATA_WIDTH       (CSR_DATA_WIDTH)
     ,.CMD_WIDTH            (1*INFRA_AVST_DATA_W)
   ) avst2csr (
     .clk_avst              (clk_avst                )
    ,.rst_avst_n            (rst_avst_n              )
    ,.avst_ingr_ready       (avst_ingr_ready         )
    ,.avst_ingr_valid       (avst_ingr_valid         )
    ,.avst_ingr_sop         (avst_ingr_startofpacket )
    ,.avst_ingr_eop         (avst_ingr_endofpacket   )
    ,.avst_ingr_channel     (avst_ingr_channel       )
    ,.avst_ingr_data        (avst_ingr_data          )
    ,.avst_egr_ready        (avst_egr_ready          )
    ,.avst_egr_valid        (avst_egr_valid          )
    ,.avst_egr_sop          (avst_egr_startofpacket  )
    ,.avst_egr_eop          (avst_egr_endofpacket    )
    ,.avst_egr_channel      (avst_egr_channel        )
    ,.avst_egr_data         (avst_egr_data           )
    ,.clk_csr               (clk_logic               )
    ,.rst_csr_n             (rst_logic_n             )
    ,.csr_write             (csr_write               )
    ,.csr_read              (csr_read                )
    ,.csr_addr              (csr_addr                )
    ,.csr_wr_data           (csr_wr_data             )
    ,.csr_rd_data           (csr_rd_data             )
    ,.csr_rd_valid          (csr_rd_valid            )
   );

  /* CSR reg write logic */
  always@(posedge clk_logic,  negedge rst_logic_n)
  begin
    if(~rst_logic_n)
    begin
      stop_on_cap_full             <=  0;
      cap_mode                     <=  0;
      cap_en                       <=  0;
      cap_num_samples_before_trig  <=  0;
      cap_rdata_idx                <=  0;
      cap_rsample_num              <=  0;
    end
    else
    begin
      /*  Write Logic */
      if(csr_write)
      begin
        case(csr_addr)
          20 : // Capture Control Register
          begin
            cap_en                       <= csr_wr_data[0];
            cap_mode                     <= csr_wr_data[1];
            stop_on_cap_full             <= csr_wr_data[2];
            cap_num_samples_before_trig  <= csr_wr_data[DEBUG_DATA_WIDTH-1:(DEBUG_DATA_WIDTH/2)];
          end
          32 : // Capture Read Control Register
          begin
            cap_rdata_idx    <=  csr_wr_data[15:0];
            cap_rsample_num  <=  csr_wr_data[31:16]; 
          end
        endcase
      end
    end
  end

  /* CSR reg read logic */
  always@(posedge clk_logic,  negedge rst_logic_n)
  begin
    if(~rst_logic_n)
    begin
      csr_rd_valid         <=  0;
      csr_rd_data          <=  0;
    end
    else
    begin
      /*  Read data Logic */
      case(csr_addr)
        0 : /* Instance name Reg0 */
        begin
          for (n=0;n<4;n++)
          begin
            csr_rd_data[(n*8) +: 8] <=  inst_name_str[15-n];
          end
        end
        4 : /*  Instance name Reg1 */
        begin
          for (n=0;n<4;n++)
          begin
            csr_rd_data[(n*8) +: 8] <=  inst_name_str[15-4-n];
          end
        end
        8 : /*  Instance name Reg2 */
        begin
          for (n=0;n<4;n++)
          begin
            csr_rd_data[(n*8) +: 8] <=  inst_name_str[15-8-n];
          end
        end
        12 : /*  Instance name Reg3 */
        begin
          for (n=0;n<4;n++)
          begin
            csr_rd_data[(n*8) +: 8] <=  inst_name_str[15-12-n];
          end
        end
        16 : /*  Capture Parameter0 Register */
        begin
          csr_rd_data         <=  params_reg;
        end
        20 : /*  Capture Control Register */
        begin
          csr_rd_data         <= {cap_num_samples_before_trig,13'h0,stop_on_cap_full,cap_mode,cap_en};
        end
        24 : /*  Capture Status Register */
        begin
          csr_rd_data         <=  dbg_status_reg;
        end
        28 : /*  Capture Start Address Register */
        begin
          csr_rd_data         <=  dbg_start_addr_reg;
        end
        32 : /*  Capture Read Control Register */
        begin
          csr_rd_data         <=  {cap_rsample_num,cap_rdata_idx};
        end
        36 : /*  Capture Read Data Register */
        begin
          csr_rd_data         <=  dbg_rd_data_reg;
        end
        default :
        begin
          csr_rd_data         <=  'hdeadbabe;
        end
      endcase
      /*  Read data valid Logic */
      if(csr_read)
      begin
        csr_rd_valid       <=  1'b1;
      end
      else
      begin
        csr_rd_valid       <=  1'b0;
      end
    end
  end

 /*  Instantiate Memory  */
 fpgamem #(
    .ADDR_WD           (MEM_ADDR_W) 
   ,.DATA_WD           (MEM_DATA_W) 
   ,.WR_RD_SIMULT_DATA (1'b0)
 ) u_fpga_mem (
    .ckwr     (clk_logic)
   ,.ckrd     (clk_logic)
   ,.wr       (mem_wren)
   ,.wrptr    (mem_waddr)
   ,.datain   (mem_wdata)
   ,.rd       (1'b1)
   ,.rdptr    (mem_raddr)
   ,.dataout  (mem_rdata)
 );


endmodule //IW_dbg_cap


//------------------------------------------------------------------------------
// Change History:
//
// $Log: IW_dbg_cap.sv.rca $
// 
//  Revision: 1.1 Thu Nov 19 03:36:17 2015 gjames
//  Initial Commit
// 
// 
//------------------------------------------------------------------------------

