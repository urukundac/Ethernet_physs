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
 -- Module Name       : generic_true_dual_port_ram
 -- Author            : Gregory James
 -- Associated modules: 
 -- Function          : A parameterizable true dual port RAM
 --------------------------------------------------------------------------
*/

`timescale 1ns / 10ps


module generic_true_dual_port_ram #(
//----------------------- Global parameters Declarations ------------------
   parameter  DATA_WIDTH    = 8
  ,parameter  ADDR_WIDTH    = 4
  ,parameter  INIT_FILE     = ""

) (

   input  logic                   clk

//----------------------- Port A ------------------------------------------
  ,input  logic                   wr_en_a
  ,input  logic [DATA_WIDTH-1:0]  wr_data_a
  ,input  logic [ADDR_WIDTH-1:0]  addr_a
  ,output logic [DATA_WIDTH-1:0]  rd_data_a

//----------------------- Port B ------------------------------------------
  ,input  logic                   wr_en_b
  ,input  logic [DATA_WIDTH-1:0]  wr_data_b
  ,input  logic [ADDR_WIDTH-1:0]  addr_b
  ,output logic [DATA_WIDTH-1:0]  rd_data_b


);

//----------------------- Import Packages ---------------------------------


//----------------------- Internal Parameters -----------------------------


//----------------------- Internal Register Declarations ------------------
  reg [DATA_WIDTH-1:0]  ram [(2**ADDR_WIDTH)-1:0];


//----------------------- Internal Wire Declarations ----------------------


//----------------------- Start of Code -----------------------------------

  /*  Port A */
  always@(posedge clk)
  begin
    if(wr_en_a)
    begin
      ram[addr_a] <=  wr_data_a;
    end

    rd_data_a     <=  ram[addr_a];
  end

  /*  Port B */
  always@(posedge clk)
  begin
    if(wr_en_b)
    begin
      ram[addr_b] <=  wr_data_b;
    end

    rd_data_b     <=  ram[addr_b];
  end

  /*  Initialize memory contents  */
  generate
    if(INIT_FILE  !=  "")
    begin
      initial
      begin
        $readmemb(INIT_FILE,  ram);
      end
    end
  endgenerate

endmodule // generic_true_dual_port_ram
