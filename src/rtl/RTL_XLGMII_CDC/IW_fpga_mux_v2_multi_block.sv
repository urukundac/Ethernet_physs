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
// File Name:$RCSfile:$
// File Revision:$
// Created by:    Gregory James
// Updated by:    $Author:$ $Date:$
//------------------------------------------------------------------------------
// IW_fpga_mux_v2_multi_block rewritten from earlier version for better timing
//------------------------------------------------------------------------------


module IW_fpga_mux_v2_multi_block   #(
   parameter  NUMBER_OF_OUTPUTS   = 5
  ,parameter  MULTIPLEX_RATIO     = 6
  ,parameter  CLOCK_RATIO         = 4
  ,parameter  MAX_PINS_PER_BLOCK  = 20

  /*  Do Not Modify */
  ,parameter  DEBUG_REG_W          = 32
  ,parameter  NUM_DEBUG_REGS       = 16
  ,parameter  FPGA_FAMILY          = "S5"
  ,parameter  INFRA_AVST_CHNNL_W   = 8
  ,parameter  INFRA_AVST_DATA_W    = 8
  ,parameter  INFRA_AVST_CHNNL_ID  = 8
  ,parameter  CSR_ADDR_WIDTH       = (3*INFRA_AVST_CHNNL_W)
  ,parameter  CSR_DATA_WIDTH       = (4*INFRA_AVST_CHNNL_W)
  ,parameter  INSTANCE_NAME        = "u_mux_v2_mult"  //Can hold upto 16 ASCII characters

) (

    input                                             clk_mux
  , input                                             rst_mux_n

  , input   [(NUMBER_OF_OUTPUTS*MULTIPLEX_RATIO)-1:0] inbus
  , inout   [NUMBER_OF_OUTPUTS-1:0]                   outbus

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

  /*  Local Parameters  */
  localparam  PIN_BLOCK_RESIDUE      = NUMBER_OF_OUTPUTS % MAX_PINS_PER_BLOCK;
  localparam  NUM_BLOCKS             = (PIN_BLOCK_RESIDUE  > 0)  ? (NUMBER_OF_OUTPUTS  / MAX_PINS_PER_BLOCK) + 1 : NUMBER_OF_OUTPUTS / MAX_PINS_PER_BLOCK;
  localparam  NUM_CSR_SUBMODS        = NUM_BLOCKS+1;
  localparam  CSR_SUBMOD_ADDR_WIDTH  = CSR_ADDR_WIDTH-8;
  localparam  CSR_SUBMOD_DATA_WIDTH  = CSR_DATA_WIDTH;
  //Split CSR Bus signals
  wire  [NUM_CSR_SUBMODS-1:0]          csr_submod_write;
  wire  [NUM_CSR_SUBMODS-1:0]          csr_submod_read;
  wire  [CSR_SUBMOD_ADDR_WIDTH-1:0]    csr_submod_addr [NUM_CSR_SUBMODS-1:0];
  wire  [CSR_SUBMOD_DATA_WIDTH-1:0]    csr_submod_wr_data  [NUM_CSR_SUBMODS-1:0];
  reg   [CSR_SUBMOD_DATA_WIDTH-1:0]    csr_submod_rd_data  [NUM_CSR_SUBMODS-1:0];
  reg   [NUM_CSR_SUBMODS-1:0]          csr_submod_rd_valid;

  integer n;
  reg  [0:15][7:0]                   inst_name_str = INSTANCE_NAME;
  wire                               csr_write;
  wire                               csr_read;
  wire [(3*INFRA_AVST_CHNNL_W)-1:0]  csr_addr;
  wire [(4*INFRA_AVST_DATA_W)-1:0]   csr_wr_data;
  reg  [(4*INFRA_AVST_DATA_W)-1:0]   csr_rd_data;
  reg                                csr_rd_valid;
  wire [31:0]                        params_reg;

  /*  Internal Variables  */
  genvar  i;

  generate
    for(i=0;  i<NUM_BLOCKS; i++)
    begin : gen_mux_blk
      if((i==NUM_BLOCKS-1)  &&  (PIN_BLOCK_RESIDUE  > 0)) //Last block is not a multiple of MAX_PINS_PER_BLOCK
      begin
        IW_fpga_mux_v2   #(
           .NUMBER_OF_OUTPUTS   (PIN_BLOCK_RESIDUE)
          ,.MULTIPLEX_RATIO     (MULTIPLEX_RATIO)
          ,.CLOCK_RATIO         (CLOCK_RATIO)
          ,.INSTANCE_NAME       ({INSTANCE_NAME,"_",i})
          ,.FPGA_FAMILY         (FPGA_FAMILY)
          ,.INFRA_AVST_CHNNL_W  (INFRA_AVST_CHNNL_W)
          ,.INFRA_AVST_DATA_W   (INFRA_AVST_DATA_W)
          ,.INFRA_AVST_CHNNL_ID (INFRA_AVST_CHNNL_ID)
          ,.AVST2CSR_BYPASS_EN  (1)
          ,.CSR_ADDR_WIDTH      (CSR_SUBMOD_ADDR_WIDTH)  
          ,.CSR_DATA_WIDTH      (CSR_SUBMOD_DATA_WIDTH) 
        ) u_IW_fpga_mux_v2  (

           .outbus                   (outbus[(i*MAX_PINS_PER_BLOCK)  +:  PIN_BLOCK_RESIDUE])
          ,.clk_mux                  (clk_mux)
          ,.rst_mux_n                (rst_mux_n)
          ,.inbus                    (inbus[(i*MAX_PINS_PER_BLOCK*MULTIPLEX_RATIO) +:  (PIN_BLOCK_RESIDUE*MULTIPLEX_RATIO)])

          ,.clk_avst                 ('h0)
          ,.rst_avst_n               ('h0)
          ,.avst_ingr_ready          ()
          ,.avst_ingr_valid          ('h0)
          ,.avst_ingr_startofpacket  ('h0)
          ,.avst_ingr_endofpacket    ('h0)
          ,.avst_ingr_channel        ('h0)
          ,.avst_ingr_data           ('h0)
          ,.avst_egr_ready           ('h0)
          ,.avst_egr_valid           ()
          ,.avst_egr_startofpacket   ()
          ,.avst_egr_endofpacket     ()
          ,.avst_egr_channel         ()
          ,.avst_egr_data            ()
          ,.ext_csr_write            (csr_submod_write[i+1] )
          ,.ext_csr_read             (csr_submod_read[i+1])
          ,.ext_csr_addr             (csr_submod_addr[i+1])
          ,.ext_csr_wr_data          (csr_submod_wr_data[i+1])
          ,.ext_csr_rd_data          (csr_submod_rd_data[i+1])
          ,.ext_csr_rd_valid         (csr_submod_rd_valid[i+1])
        );
      end
      else
      begin
        IW_fpga_mux_v2   #(
           .NUMBER_OF_OUTPUTS   (MAX_PINS_PER_BLOCK)
          ,.MULTIPLEX_RATIO     (MULTIPLEX_RATIO)
          ,.CLOCK_RATIO         (CLOCK_RATIO)
          ,.INSTANCE_NAME       ({INSTANCE_NAME,"_",i})
          ,.FPGA_FAMILY         (FPGA_FAMILY)
          ,.INFRA_AVST_CHNNL_W  (INFRA_AVST_CHNNL_W)
          ,.INFRA_AVST_DATA_W   (INFRA_AVST_DATA_W)
          ,.INFRA_AVST_CHNNL_ID (INFRA_AVST_CHNNL_ID)
          ,.AVST2CSR_BYPASS_EN  (1)
          ,.CSR_ADDR_WIDTH      (CSR_SUBMOD_ADDR_WIDTH)  
          ,.CSR_DATA_WIDTH      (CSR_SUBMOD_DATA_WIDTH) 
        ) u_IW_fpga_mux_v2  (

           .outbus                   (outbus[(i*MAX_PINS_PER_BLOCK)  +:  MAX_PINS_PER_BLOCK])
          ,.clk_mux                  (clk_mux)
          ,.rst_mux_n                (rst_mux_n)
          ,.inbus                    (inbus[(i*MAX_PINS_PER_BLOCK*MULTIPLEX_RATIO) +:  (MAX_PINS_PER_BLOCK*MULTIPLEX_RATIO)])

          ,.clk_avst                 ('h0)
          ,.rst_avst_n               ('h0)
          ,.avst_ingr_ready          ()
          ,.avst_ingr_valid          ('h0)
          ,.avst_ingr_startofpacket  ('h0)
          ,.avst_ingr_endofpacket    ('h0)
          ,.avst_ingr_channel        ('h0)
          ,.avst_ingr_data           ('h0)
          ,.avst_egr_ready           ('h0)
          ,.avst_egr_valid           ()
          ,.avst_egr_startofpacket   ()
          ,.avst_egr_endofpacket     ()
          ,.avst_egr_channel         ()
          ,.avst_egr_data            ()
          ,.ext_csr_write            (csr_submod_write[i+1])
          ,.ext_csr_read             (csr_submod_read[i+1])
          ,.ext_csr_addr             (csr_submod_addr[i+1])
          ,.ext_csr_wr_data          (csr_submod_wr_data[i+1])
          ,.ext_csr_rd_data          (csr_submod_rd_data[i+1])
          ,.ext_csr_rd_valid         (csr_submod_rd_valid[i+1])
        );
      end
    end //gen_mux_blk
  endgenerate

/* AVST2CSR instance  */
IW_fpga_avst2csr #(
      .AVST_CHANNEL_ID      (INFRA_AVST_CHNNL_ID)
     ,.AVST_CHANNEL_WIDTH   (INFRA_AVST_CHNNL_W)
     ,.AVST_DATA_WIDTH      (INFRA_AVST_DATA_W)
     ,.CSR_ADDR_WIDTH       (CSR_ADDR_WIDTH)
     ,.CSR_DATA_WIDTH       (CSR_DATA_WIDTH)
     ,.CMD_WIDTH            (1*INFRA_AVST_DATA_W)
   ) mux_multi_block_avst2csr (
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
    ,.clk_csr               (clk_mux                 )
    ,.rst_csr_n             (rst_mux_n               )
    ,.csr_write             (csr_write               )
    ,.csr_read              (csr_read                )
    ,.csr_addr              (csr_addr                )
    ,.csr_wr_data           (csr_wr_data             )
    ,.csr_rd_data           (csr_rd_data             )
    ,.csr_rd_valid          (csr_rd_valid            )
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
      .clk_csr                 (clk_mux)
     ,.rst_csr_n               (rst_mux_n)
     ,.csr_write               (csr_write)
     ,.csr_read                (csr_read)
     ,.csr_addr                (csr_addr)
     ,.csr_wr_data             (csr_wr_data)
     ,.csr_rd_data             (csr_rd_data)
     ,.csr_rd_valid            (csr_rd_valid)

     ,.csr_submodule_write     (csr_submod_write)
     ,.csr_submodule_read      (csr_submod_read)
     ,.csr_submodule_addr      (csr_submod_addr)
     ,.csr_submodule_wr_data   (csr_submod_wr_data)
     ,.csr_submodule_rd_data   (csr_submod_rd_data)
     ,.csr_submodule_rd_valid  (csr_submod_rd_valid)
   );


  /* CSR reg read logic */
  always@(posedge clk_mux,  negedge rst_mux_n)
  begin
    if(~rst_mux_n)
    begin
      csr_submod_rd_valid[0]         <=  0;
      csr_submod_rd_data[0]          <=  0;
    end
    else
    begin
      /*  Read data Logic */
      case(csr_submod_addr[0])
        0 : /* Instance name Reg0 */
        begin
          for (n=0;n<4;n++)
          begin
            csr_submod_rd_data[0][(n*8) +: 8] <=  inst_name_str[15-n];
          end
        end
        4 : /*  Instance name Reg1 */
        begin
          for (n=0;n<4;n++)
          begin
            csr_submod_rd_data[0][(n*8) +: 8] <=  inst_name_str[15-4-n];
          end
        end
        8 : /*  Instance name Reg2 */
        begin
          for (n=0;n<4;n++)
          begin
            csr_submod_rd_data[0][(n*8) +: 8] <=  inst_name_str[15-8-n];
          end
        end
        12 : /*  Instance name Reg3 */
        begin
          for (n=0;n<4;n++)
          begin
            csr_submod_rd_data[0][(n*8) +: 8] <=  inst_name_str[15-12-n];
          end
        end
        16 : /*  Params Reg */
        begin
          csr_submod_rd_data[0]         <=  params_reg;
        end
        default :
        begin
          csr_submod_rd_data[0]         <=  'hdeadbabe;
        end
      endcase
      /*  Read data valid Logic */
      if(csr_submod_read[0])
      begin
        csr_submod_rd_valid[0]       <=  1'b1;
      end
      else
      begin
        csr_submod_rd_valid[0]       <=  1'b0;
      end
    end
  end

  //Param0 Register
  assign  params_reg[31:24]  = NUMBER_OF_OUTPUTS;
  assign  params_reg[23:16]  = MULTIPLEX_RATIO;
  assign  params_reg[15:8]   = CLOCK_RATIO;
  assign  params_reg[7:4]    = 'h0;   //Reserved
  assign  params_reg[3:0]    = 'h02;   //Version

endmodule //IW_fpga_mux_v2_multi_block
