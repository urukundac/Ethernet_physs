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
// File Name:     $RCSfile: IW_fpga_avmm_default_slave.sv.rca $
// File Revision: $Revision: 1.3 $
// Created by:    Ranjith Kulai
//------------------------------------------------------------------------------

`timescale  1ns/1ps

module IW_fpga_avmm_default_slave #(

    parameter DATA_W                    = 512
  , parameter ADDR_W                    = 32
  , parameter BURST                     = 4
  , parameter BYTE_EN                   = DATA_W/8
  , parameter READ_VAL                  = 32'hDEADBABE

) (

   input  wire                          clk
  ,input  wire                          rst_n
  ,output reg                           avmm_default_slave_waitrequest     
  ,output reg  [DATA_W-1:0]             avmm_default_slave_readdata        
  ,output reg                           avmm_default_slave_readdatavalid   
  ,input  wire [BURST-1:0]              avmm_default_slave_burstcount      
  ,input  wire [DATA_W-1:0]             avmm_default_slave_writedata       
  ,input  wire [ADDR_W-1:0]             avmm_default_slave_address
  ,input  wire                          avmm_default_slave_write           
  ,input  wire                          avmm_default_slave_read            
  ,input  wire [BYTE_EN-1:0]            avmm_default_slave_byteenable      
  ,input  wire                          avmm_default_slave_debugaccess     

);

  always@(posedge clk,  negedge rst_n)
  begin
    if(~rst_n)
    begin
      avmm_default_slave_readdatavalid <=  0;
      avmm_default_slave_readdata      <=  0;
    end
    else
    begin
      if (avmm_default_slave_read) begin
        avmm_default_slave_readdatavalid <= 1'b1;
      end
      else begin
        avmm_default_slave_readdatavalid <= 1'b0;
      end
      avmm_default_slave_readdata      <=  READ_VAL;
    end
  end

assign avmm_default_slave_waitrequest = 1'b0;

endmodule
