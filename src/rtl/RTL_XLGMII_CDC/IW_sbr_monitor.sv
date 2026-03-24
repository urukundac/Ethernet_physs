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

`timescale  1ns/1ps

module  IW_sbr_monitor  #(
    parameter SBR_TYPE            = "pmsb"              //Should be either pmsb or gpsb
  , parameter INSTANCE_NAME       = "u_IW_sbr_monitor"  //Can hold upto 16 ASCII characters
  , parameter PAYLOAD_WIDTH       = 8                   //Width of payload

  /*  Do Not Modify */
  , parameter DEBUG_REG_DATA_W    = 32
  , parameter NUM_DEBUG_REGS      = 16
  , parameter DEBUG_DATA_SIZE     = NUM_DEBUG_REGS  * DEBUG_REG_DATA_W

) (

    input   wire  clk_logic
  , input   wire  rst_logic_n

    /*  Ingress SBR Interface - Agent side */
  , input   wire                      agent_iosfsb_MNPPUT
  , input   wire                      agent_iosfsb_MPCPUT
  , output  wire                      agent_iosfsb_MNPCUP
  , output  wire                      agent_iosfsb_MPCCUP
  , input   wire                      agent_iosfsb_MEOM
  , input   wire  [PAYLOAD_WIDTH-1:0] agent_iosfsb_MPAYLOAD
  , output  wire                      agent_iosfsb_TNPPUT
  , output  wire                      agent_iosfsb_TPCPUT
  , input   wire                      agent_iosfsb_TNPCUP
  , input   wire                      agent_iosfsb_TPCCUP
  , output  wire                      agent_iosfsb_TEOM
  , output  wire  [PAYLOAD_WIDTH-1:0] agent_iosfsb_TPAYLOAD
  , input   wire  [2:0]               agent_iosfsb_SIDE_ISM_AGENT
  , output  wire  [2:0]               agent_iosfsb_SIDE_ISM_FABRIC

    /*  Egress SBR Interface - Fabric side  */
  , output  wire                      fabric_iosfsb_MNPPUT
  , output  wire                      fabric_iosfsb_MPCPUT
  , input   wire                      fabric_iosfsb_MNPCUP
  , input   wire                      fabric_iosfsb_MPCCUP
  , output  wire                      fabric_iosfsb_MEOM
  , output  wire  [PAYLOAD_WIDTH-1:0] fabric_iosfsb_MPAYLOAD
  , input   wire                      fabric_iosfsb_TNPPUT
  , input   wire                      fabric_iosfsb_TPCPUT
  , output  wire                      fabric_iosfsb_TNPCUP
  , output  wire                      fabric_iosfsb_TPCCUP
  , input   wire                      fabric_iosfsb_TEOM
  , input   wire  [PAYLOAD_WIDTH-1:0] fabric_iosfsb_TPAYLOAD
  , output  wire  [2:0]               fabric_iosfsb_SIDE_ISM_AGENT
  , input   wire  [2:0]               fabric_iosfsb_SIDE_ISM_FABRIC

    /*  Debug Logic Interface */
  , inout   wire  [DEBUG_DATA_SIZE-1:0] sbr_mon_dbg_data  

);

  /*  Internal Variables  */
  genvar  i;
  reg   [0:3] [7:0] sbr_type_str  = SBR_TYPE;
  reg   [0:15][7:0] inst_name_str = INSTANCE_NAME;

  wire              mon_enable;
  wire              mon_enable_sync;
  reg   [1:0]       teom_del_vec;
  wire              teom_posedge_det;
  reg   [1:0]       meom_del_vec;
  wire              meom_posedge_det;
  reg   [15:0]      num_pkts_ingr_cnt;
  reg   [15:0]      num_pkts_egr_cnt;
  reg   [1:0]       rst_logic_n_sync_vec;
  reg   [15:0]      num_posted_beats_ingr_cnt;
  reg   [15:0]      num_posted_beats_egr_cnt;
  reg   [15:0]      num_non_posted_beats_ingr_cnt;
  reg   [15:0]      num_non_posted_beats_egr_cnt;

  reg                       agent_iosfsb_MNPPUT_1d;
  reg                       agent_iosfsb_MPCPUT_1d;
  reg                       agent_iosfsb_MNPCUP_1d;
  reg                       agent_iosfsb_MPCCUP_1d;
  reg                       agent_iosfsb_MEOM_1d;
  reg                       agent_iosfsb_TNPPUT_1d;
  reg                       agent_iosfsb_TPCPUT_1d;
  reg                       agent_iosfsb_TNPCUP_1d;
  reg                       agent_iosfsb_TPCCUP_1d;
  reg                       agent_iosfsb_TEOM_1d;
  reg   [2:0]               agent_iosfsb_SIDE_ISM_AGENT_1d;
  reg   [2:0]               agent_iosfsb_SIDE_ISM_FABRIC_1d;

  reg   [1:0]               tpyld_cnt;
  reg   [31:0]              tpyld;
  reg                       tpyld_wr;
  reg                       tsom;
  reg                       tsom_d;
  reg                       tsom_2d;
  reg   [2:0]               tpyld_idx;
  reg  [0:5][31:0]          tpyld_mem;


  /*  Connect Egress & Ingress Interfaces */
  assign  agent_iosfsb_MNPCUP           = fabric_iosfsb_MNPCUP;
  assign  agent_iosfsb_MPCCUP           = fabric_iosfsb_MPCCUP;
  assign  agent_iosfsb_TNPPUT           = fabric_iosfsb_TNPPUT;
  assign  agent_iosfsb_TPCPUT           = fabric_iosfsb_TPCPUT;
  assign  agent_iosfsb_TEOM             = fabric_iosfsb_TEOM;
  assign  agent_iosfsb_TPAYLOAD         = fabric_iosfsb_TPAYLOAD;
  assign  agent_iosfsb_SIDE_ISM_FABRIC  = fabric_iosfsb_SIDE_ISM_FABRIC;

  assign  fabric_iosfsb_MNPPUT          = agent_iosfsb_MNPPUT;
  assign  fabric_iosfsb_MPCPUT          = agent_iosfsb_MPCPUT;
  assign  fabric_iosfsb_MEOM            = agent_iosfsb_MEOM;
  assign  fabric_iosfsb_MPAYLOAD        = agent_iosfsb_MPAYLOAD;
  assign  fabric_iosfsb_TNPCUP          = agent_iosfsb_TNPCUP;
  assign  fabric_iosfsb_TPCCUP          = agent_iosfsb_TPCCUP;
  assign  fabric_iosfsb_SIDE_ISM_AGENT  = agent_iosfsb_SIDE_ISM_AGENT;

  /*
    * Register agent_iosfb bus signals
    * Count the number of packets sent & received
  */
  always@(posedge clk_logic,  negedge rst_logic_n)
  begin
    if(~rst_logic_n)
    begin
      agent_iosfsb_MNPPUT_1d            <=  0;
      agent_iosfsb_MPCPUT_1d            <=  0;
      agent_iosfsb_MNPCUP_1d            <=  0;
      agent_iosfsb_MPCCUP_1d            <=  0;
      agent_iosfsb_MEOM_1d              <=  0;
      agent_iosfsb_TNPPUT_1d            <=  0;
      agent_iosfsb_TPCPUT_1d            <=  0;
      agent_iosfsb_TNPCUP_1d            <=  0;
      agent_iosfsb_TPCCUP_1d            <=  0;
      agent_iosfsb_TEOM_1d              <=  0;
      agent_iosfsb_SIDE_ISM_AGENT_1d    <=  0;
      agent_iosfsb_SIDE_ISM_FABRIC_1d   <=  0;

      num_pkts_ingr_cnt       <=  0;
      num_pkts_egr_cnt        <=  0;

      teom_del_vec            <=  0;
      meom_del_vec            <=  0;

      rst_logic_n_sync_vec    <=  0;

      num_posted_beats_ingr_cnt         <=  0;
      num_posted_beats_egr_cnt          <=  0;
      num_non_posted_beats_ingr_cnt     <=  0;
      num_non_posted_beats_egr_cnt      <=  0;

      tpyld_cnt        <= 0;
      tpyld            <= 0;
      tpyld_wr         <= 0;
      tsom             <= 1;
      tsom_d           <= 1;
      tsom_2d          <= 1;
      tpyld_idx        <= 0;
    end
    else
    begin
      rst_logic_n_sync_vec              <=  {rst_logic_n_sync_vec[0],rst_logic_n};

      agent_iosfsb_MNPPUT_1d            <=  agent_iosfsb_MNPPUT;
      agent_iosfsb_MPCPUT_1d            <=  agent_iosfsb_MPCPUT;
      agent_iosfsb_MNPCUP_1d            <=  agent_iosfsb_MNPCUP;
      agent_iosfsb_MPCCUP_1d            <=  agent_iosfsb_MPCCUP;
      agent_iosfsb_MEOM_1d              <=  agent_iosfsb_MEOM;
      agent_iosfsb_TNPPUT_1d            <=  agent_iosfsb_TNPPUT;
      agent_iosfsb_TPCPUT_1d            <=  agent_iosfsb_TPCPUT;
      agent_iosfsb_TNPCUP_1d            <=  agent_iosfsb_TNPCUP;
      agent_iosfsb_TPCCUP_1d            <=  agent_iosfsb_TPCCUP;
      agent_iosfsb_TEOM_1d              <=  agent_iosfsb_TEOM;
      agent_iosfsb_SIDE_ISM_AGENT_1d    <=  agent_iosfsb_SIDE_ISM_AGENT;
      agent_iosfsb_SIDE_ISM_FABRIC_1d   <=  agent_iosfsb_SIDE_ISM_FABRIC;

      if(~mon_enable_sync)
      begin
        num_pkts_ingr_cnt     <=  0;
        num_pkts_egr_cnt      <=  0;

        teom_del_vec          <=  {2{agent_iosfsb_TEOM}};
        meom_del_vec          <=  {2{agent_iosfsb_MEOM}};

        num_posted_beats_ingr_cnt         <=  0;
        num_posted_beats_egr_cnt          <=  0;
        num_non_posted_beats_ingr_cnt     <=  0;
        num_non_posted_beats_egr_cnt      <=  0;
      end
      else
      begin
        teom_del_vec          <=  {teom_del_vec[0],agent_iosfsb_TEOM};
        meom_del_vec          <=  {meom_del_vec[0],agent_iosfsb_MEOM};

        num_pkts_ingr_cnt     <=  (&num_pkts_ingr_cnt)  ? num_pkts_ingr_cnt : num_pkts_ingr_cnt + meom_posedge_det;

        num_pkts_egr_cnt      <=  (&num_pkts_egr_cnt)   ? num_pkts_egr_cnt  : num_pkts_egr_cnt  + teom_posedge_det;

        num_posted_beats_ingr_cnt         <=  (&num_posted_beats_ingr_cnt)      ? num_posted_beats_ingr_cnt     : num_posted_beats_ingr_cnt     + agent_iosfsb_MPCPUT;
        num_posted_beats_egr_cnt          <=  (&num_posted_beats_egr_cnt)       ? num_posted_beats_egr_cnt      : num_posted_beats_egr_cnt      + agent_iosfsb_TPCPUT;
        num_non_posted_beats_ingr_cnt     <=  (&num_non_posted_beats_ingr_cnt)  ? num_non_posted_beats_ingr_cnt : num_non_posted_beats_ingr_cnt + agent_iosfsb_MNPPUT;
        num_non_posted_beats_egr_cnt      <=  (&num_non_posted_beats_egr_cnt)   ? num_non_posted_beats_egr_cnt  : num_non_posted_beats_egr_cnt  + agent_iosfsb_TNPPUT;

      end

      tsom_d           <= tsom;
      tsom_2d          <= tsom_d;
      if ( PAYLOAD_WIDTH == 32  && (agent_iosfsb_TNPPUT | agent_iosfsb_TPCPUT )) begin
         tpyld_cnt        <= 0;
         tpyld_wr         <= 1;
         tpyld            <= agent_iosfsb_TPAYLOAD;
         if ( agent_iosfsb_TEOM ) tsom  <= 1; else tsom  <= 0;
      end
      else if ( PAYLOAD_WIDTH == 16 && tpyld_cnt == 1 && (agent_iosfsb_TNPPUT | agent_iosfsb_TPCPUT )) begin
         tpyld_cnt        <= 0;
         tpyld_wr         <= 1;
         tpyld            <= {agent_iosfsb_TPAYLOAD,tpyld[15:0]};
         if ( agent_iosfsb_TEOM ) tsom  <= 1; else tsom  <= 0;
      end
      else if ( PAYLOAD_WIDTH == 8 && tpyld_cnt == 3 && (agent_iosfsb_TNPPUT | agent_iosfsb_TPCPUT )) begin
         tpyld_cnt        <= 0;
         tpyld_wr         <= 1;
         tpyld            <= {agent_iosfsb_TPAYLOAD,tpyld[23:0]};
         if ( agent_iosfsb_TEOM ) tsom  <= 1; else tsom  <= 0;
      end
      else if ( agent_iosfsb_TNPPUT | agent_iosfsb_TPCPUT ) begin
         tpyld_cnt        <= tpyld_cnt + 1'b1;
         tpyld_wr         <= 0;
         case (tpyld_cnt) 
           2'b00:  tpyld  <= 32'h0 | agent_iosfsb_TPAYLOAD;
           2'b01:  tpyld  <= 32'h0 | {agent_iosfsb_TPAYLOAD,tpyld[7:0]};
           2'b10:  tpyld  <= 32'h0 | {agent_iosfsb_TPAYLOAD,tpyld[15:0]};
         endcase
      end
      else begin
         tpyld_wr         <= 0;
      end
  
      if ( ~tsom_2d & tsom_d ) tpyld_idx <= 0;
      else if ( tpyld_wr ) tpyld_idx  <= tpyld_idx + 1;
    end
  end

  always @(posedge clk_logic) begin
    if ( tpyld_wr ) tpyld_mem[tpyld_idx] <= tpyld;
  end

  //Look for rising edge of EOM signals
  assign  teom_posedge_det    = (teom_del_vec ==  2'b01)  ? 1'b1  : 1'b0;
  assign  meom_posedge_det    = (meom_del_vec ==  2'b01)  ? 1'b1  : 1'b0;


  /*  Synchronize control signals */
  IW_fpga_double_sync  #(
     .WIDTH       (1)
    ,.NUM_STAGES  (2)

  ) u_IW_fpga_double_sync_cntrl (

     .clk         (clk_logic)
    ,.sig_in      (mon_enable)
    ,.sig_out     (mon_enable_sync)

  );



  /*  Connect Debug Signals */
  generate
    //SBR Type Register
    for(i=0;  i<4; i++)
    begin : gen_dbg_data_sbr_type
      assign  sbr_mon_dbg_data[((0*DEBUG_REG_DATA_W) + (i*8))  +:  8]  = sbr_type_str[3-i];
    end

    //Instance Name Register
    for(i=0;  i<16; i++)
    begin : gen_dbg_data_inst_name
      assign  sbr_mon_dbg_data[(((1+(i/4))*DEBUG_REG_DATA_W) + ((i%4)*8)) +:  8]  = inst_name_str[15-i];
    end
  endgenerate

  //Control Register
  assign  mon_enable          = sbr_mon_dbg_data[(5*DEBUG_REG_DATA_W) + 0];

  //Bus Status Register
  assign  sbr_mon_dbg_data[(6*DEBUG_REG_DATA_W) +:  DEBUG_REG_DATA_W] = {  {15{1'b0}}
                                                                          ,rst_logic_n_sync_vec[1]           //  16
                                                                          ,agent_iosfsb_MNPPUT_1d            //  15
                                                                          ,agent_iosfsb_MPCPUT_1d            //  14
                                                                          ,agent_iosfsb_MNPCUP_1d            //  13
                                                                          ,agent_iosfsb_MPCCUP_1d            //  12
                                                                          ,agent_iosfsb_MEOM_1d              //  11
                                                                          ,agent_iosfsb_TNPPUT_1d            //  10
                                                                          ,agent_iosfsb_TPCPUT_1d            //  9
                                                                          ,agent_iosfsb_TNPCUP_1d            //  8
                                                                          ,agent_iosfsb_TPCCUP_1d            //  7
                                                                          ,agent_iosfsb_TEOM_1d              //  6
                                                                          ,agent_iosfsb_SIDE_ISM_AGENT_1d    //  5:3
                                                                          ,agent_iosfsb_SIDE_ISM_FABRIC_1d   //  2:0
                                                                        };

  //Num Packets Count Register
  assign  sbr_mon_dbg_data[(7*DEBUG_REG_DATA_W) +:  DEBUG_REG_DATA_W] = {  num_pkts_egr_cnt   //31:16
                                                                          ,num_pkts_ingr_cnt  //15:0
                                                                        };

  //Num Posted Beats Count Register
  assign  sbr_mon_dbg_data[(8*DEBUG_REG_DATA_W) +:  DEBUG_REG_DATA_W] = {  num_posted_beats_egr_cnt   //31:16
                                                                          ,num_posted_beats_ingr_cnt  //15:0
                                                                        };

  //Num Non-Posted Beats Count Register
  assign  sbr_mon_dbg_data[(9*DEBUG_REG_DATA_W) +:  DEBUG_REG_DATA_W] = {  num_non_posted_beats_egr_cnt   //31:16
                                                                          ,num_non_posted_beats_ingr_cnt  //15:0
                                                                        };

  //Tieoff unused registers
  generate
    for(i=10;i<NUM_DEBUG_REGS;i++)
    begin : gen_dbg_data_tieoff
      assign  sbr_mon_dbg_data[(i*DEBUG_REG_DATA_W) +:  DEBUG_REG_DATA_W] = tpyld_mem[i-10];
    end
  endgenerate
endmodule //IW_sbr_monitor
