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

module IW_fpga_async_fifo #(
   parameter  USE_RAM_MEMORY  = "True"  //"True" -> Use altsyncram memory, "False" -> Use logic elements/registers as memory
  ,parameter  ADDR_WD         = 4
  ,parameter  DATA_WD         = 8
)(
  input                                                    rstn,
  input  [DATA_WD-1:0]                                     data,
  input                                                    rdclk,
  input                                                    rdreq,
  input                                                    wrclk,
  input                                                    wrreq,
  output [DATA_WD-1:0]                                     q,
  output                                                   rdempty,
  output [ADDR_WD:0]                                       rdusedw,
  output                                                   wrfull,
  output [ADDR_WD:0]                                       wrusedw
);
localparam DEPTH = 2**ADDR_WD;

//Wire declaration
wire mem_enable;
wire rst_n_rdclk;
wire rst_n_wrclk;

wire               mem_wr_v;
wire [ADDR_WD-1:0] mem_wr_addr;
wire [DATA_WD-1:0] mem_wr_data;

wire               mem_rd_v;
wire [ADDR_WD-1:0] mem_rd_addr;
reg  [DATA_WD-1:0] mem_rd_data;

  IW_fpga_double_sync #(.WIDTH(1),.NUM_STAGES(2)) u_rst_wrclk_n (
    .clk(wrclk),
    .sig_in(rstn),
    .sig_out(rst_n_wrclk));


  IW_fpga_double_sync #(.WIDTH(1),.NUM_STAGES(2)) u_rst_rdclk_n (
    .clk(rdclk),
    .sig_in(rstn),
    .sig_out(rst_n_rdclk));


IW_fifo_ctl_dc #(
  .DEPTH           (DEPTH),
  .DWIDTH          (DATA_WD)
) u_ctrl (
  .clk_push                (wrclk),
  .rst_push_n              (rst_n_wrclk),
  .clk_pop                 (rdclk),
  .rst_pop_n               (rst_n_rdclk),

  .cfg_high_wm             (),
  .cfg_low_wm              (),

  .pop                     (rdreq),
  .pop_data                (q),

  .push                    (wrreq),
  .push_data               (data),

  .mem_enable              (mem_enable),

  .mem_wr_v                (mem_wr_v),
  .mem_wr_addr             (mem_wr_addr),
  .mem_wr_data             (mem_wr_data),
  .mem_rd_v                (mem_rd_v),
  .mem_rd_addr             (mem_rd_addr),
  .mem_rd_data             (mem_rd_data),
  .fifo_push_depth         (wrusedw),
  .fifo_push_full          (wrfull),
  .fifo_push_afull         (),
  .fifo_pop_depth          (rdusedw),
  .fifo_pop_aempty         (),
  .fifo_pop_empty          (rdempty),
  .fifo_status             ()
);

generate
begin:ram_type
  if(USE_RAM_MEMORY ==  "True")
  begin
   fpgamem #(
      .ADDR_WD             (ADDR_WD),
      .DATA_WD             (DATA_WD),
      .WR_RD_SIMULT_DATA   (0)
    ) u_mem (
      .ckwr                  (wrclk),
      .ckrd                  (rdclk),

      .wr                    (mem_wr_v),
      .wrptr                 (mem_wr_addr),
      .datain                (mem_wr_data),

      .rd                    (mem_rd_v),
      .rdptr                 (mem_rd_addr),
      .dataout               (mem_rd_data)
    );
  end
  else  //USE_RAM_MEMORY  ==  "False"
  begin
    reg [DATA_WD-1 : 0] ram [0:DEPTH-1]/*synthesis syn_ramstyle="logic"*/;

    always_ff @(posedge wrclk) begin
      if (mem_wr_v)
        ram[mem_wr_addr] <= mem_wr_data;
    end

    always_ff @(posedge rdclk) begin
      mem_rd_data  <= ram[mem_rd_addr];
    end
  end
end
endgenerate

endmodule
