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

/*
 --------------------------------------------------------------------------
 -- Project Code      : axi_fabric
 -- Module Name       : generic_simple_dual_port_ram
 -- Author            : Gregory James
 -- Associated modules: 
 -- Function          : This module implements a parameterizable true dual
                        port RAM.
 --------------------------------------------------------------------------
*/

`timescale 1ns / 10ps


module generic_simple_dual_port_ram #(
//----------------------- Global parameters Declarations ------------------
   parameter          DATA_WIDTH    = 8
  ,parameter          ADDR_WIDTH    = 4
  ,parameter  string  MEM_TYPE      = "BRAM"  //supported values are BRAM & REG
  ,parameter          INIT_FILE     = ""

) (
//----------------------- Write Interface ------------------------------
   input  logic                   wr_clk
  ,input  logic [DATA_WIDTH-1:0]  wr_data
  ,input  logic [ADDR_WIDTH-1:0]  wr_addr
  ,input  logic                   wr_en

//----------------------- Read Interface  ------------------------------
  ,input  logic                   rd_clk
  ,input  logic [ADDR_WIDTH-1:0]  rd_addr
  ,output logic [DATA_WIDTH-1:0]  rd_data

);

//----------------------- Import Packages ---------------------------------


//----------------------- Internal Parameters -----------------------------


//----------------------- Internal Register Declarations ------------------


//----------------------- Internal Wire Declarations ----------------------


//----------------------- Start of Code -----------------------------------

  generate
    if(MEM_TYPE ==  "BRAM")
    begin
      reg [DATA_WIDTH-1:0]  ram [0:2**ADDR_WIDTH-1];

      if(INIT_FILE  !=  "")
      begin
        initial
        begin
          $readmemb(INIT_FILE,  ram);
        end
      end

      /*  Write Logic */
      always@(posedge wr_clk)
      begin
        if(wr_en)
        begin
          ram[wr_addr]  <=  wr_data;
        end
      end

      /*  Read Logic */
      always@(posedge rd_clk)
      begin
        rd_data <=  ram[rd_addr];
      end
    end
    else if(MEM_TYPE  ==  "REG")
    begin
      reg [(2**ADDR_WIDTH)-1:0][DATA_WIDTH-1:0]  ram;

      if(INIT_FILE  !=  "")
      begin
        initial
        begin
          $readmemb(INIT_FILE,  ram);
        end
      end

      /*  Write Logic */
      always@(posedge wr_clk)
      begin
        if(wr_en)
        begin
          ram[wr_addr]  <=  wr_data;
        end
      end

      /*  Read Logic */
      always@(posedge rd_clk)
      begin
        rd_data <=  ram[rd_addr];
      end
    end
    else  //MEM_TYPE unsupported
    begin
      unsupported_MEM_TYPE  mem();
    end
  endgenerate

endmodule // generic_simple_dual_port_ram
