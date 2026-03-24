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
 -- Module Name       : generic_simple_dual_port_mixed_width_ram
 -- Author            : Gregory James
 -- Associated modules: 
 -- Function          : This module implements a parameterizable simple dual
                        port RAM with different read & write widths.
 --------------------------------------------------------------------------
*/

`timescale 1ns / 10ps


module generic_simple_dual_port_mixed_width_ram #(
//----------------------- Global parameters Declarations ------------------
   parameter          WRITE_WIDTH   = 8
  ,parameter          READ_WIDTH    = 16
  ,parameter          NUM_BITS      = 8*32
  ,parameter  string  MEM_TYPE      = "BRAM"  //supported values are BRAM & REG
  ,parameter          INIT_FILE     = ""

) (
//----------------------- Write Interface ------------------------------
   input  wr_clk
  ,input  wr_data
  ,input  wr_addr
  ,input  wr_en

//----------------------- Read Interface  ------------------------------
  ,input  rd_clk
  ,input  rd_addr
  ,output rd_data

);

//----------------------- Import Packages ---------------------------------


//----------------------- Internal Parameters -----------------------------
  localparam  WRITE_IS_MIN      = (WRITE_WIDTH  < READ_WIDTH) ? 1 : 0;
  localparam  WIDTH_RATIO       = WRITE_IS_MIN  ? (READ_WIDTH / WRITE_WIDTH)  : (WRITE_WIDTH  / READ_WIDTH);

  localparam  WRITE_NUM_WORDS   = NUM_BITS  / WRITE_WIDTH;
  localparam  WRITE_ADDR_WIDTH  = $clog2(WRITE_NUM_WORDS);
  localparam  READ_NUM_WORDS    = NUM_BITS  / READ_WIDTH;
  localparam  READ_ADDR_WIDTH   = $clog2(READ_NUM_WORDS);

  localparam  MEM_DIM_A         = WIDTH_RATIO;
  localparam  MEM_DIM_B         = WRITE_IS_MIN  ? WRITE_WIDTH : READ_WIDTH;
  localparam  MEM_DIM_C         = WRITE_IS_MIN  ? WRITE_NUM_WORDS : READ_NUM_WORDS;


//----------------------- Port Dimensions ---------------------------------
  logic                         wr_clk;
  logic [WRITE_WIDTH-1:0]       wr_data;
  logic [WRITE_ADDR_WIDTH-1:0]  wr_addr;
  logic                         wr_en;

  logic                         rd_clk;
  logic [READ_ADDR_WIDTH-1:0]   rd_addr;
  logic [READ_WIDTH-1:0]        rd_data;



//----------------------- Internal Register Declarations ------------------


//----------------------- Internal Wire Declarations ----------------------


//----------------------- Start of Code -----------------------------------

  generate
    //Check parameters
    if(WRITE_IS_MIN)
    begin
      if(READ_WIDTH % WRITE_WIDTH)
      begin
        error_found   read_not_integral_multiple_of_write();
      end
    end
    else
    begin
      if(WRITE_WIDTH  % READ_WIDTH)
      begin
        error_found   write_not_integral_multiple_of_read();
      end
    end

    if(WIDTH_RATIO  % 2)
    begin
      error_found   width_ratio_not_even();
    end


    if(MEM_TYPE ==  "BRAM")
    begin
      reg [MEM_DIM_A-1:0][MEM_DIM_B-1:0]  ram [0:MEM_DIM_C-1];

      if(INIT_FILE  !=  "")
      begin
        initial
        begin
          $readmemb(INIT_FILE,  ram);
        end
      end

      /*  Write Logic */
      if(!WRITE_IS_MIN)
      begin
        always@(posedge wr_clk)
        begin
          if(wr_en)
          begin
            ram[wr_addr]  <=  wr_data;
          end
        end
      end
      else
      begin
        always@(posedge wr_clk)
        begin
          if(wr_en)
          begin
            ram[wr_addr / WIDTH_RATIO][wr_addr % WIDTH_RATIO]  <=  wr_data;
          end
        end
      end

      /*  Read Logic */
      if(WRITE_IS_MIN)
      begin
        always@(posedge rd_clk)
        begin
          rd_data <=  ram[rd_addr];
        end
      end
      else
      begin
        always@(posedge rd_clk)
        begin
          rd_data <=  ram[rd_addr / WIDTH_RATIO][rd_addr % WIDTH_RATIO];
        end
      end
    end
    else if(MEM_TYPE  ==  "REG")
    begin
      reg [MEM_DIM_C-1:0][MEM_DIM_A-1:0][MEM_DIM_B-1:0]  ram;

      if(INIT_FILE  !=  "")
      begin
        initial
        begin
          $readmemb(INIT_FILE,  ram);
        end
      end

      /*  Write Logic */
      if(!WRITE_IS_MIN)
      begin
        always@(posedge wr_clk)
        begin
          if(wr_en)
          begin
            ram[wr_addr]  <=  wr_data;
          end
        end
      end
      else
      begin
        always@(posedge wr_clk)
        begin
          if(wr_en)
          begin
            ram[wr_addr / WIDTH_RATIO][wr_addr % WIDTH_RATIO]  <=  wr_data;
          end
        end
      end

      /*  Read Logic */
      if(WRITE_IS_MIN)
      begin
        always@(posedge rd_clk)
        begin
          rd_data <=  ram[rd_addr];
        end
      end
      else
      begin
        always@(posedge rd_clk)
        begin
          rd_data <=  ram[rd_addr / WIDTH_RATIO][rd_addr % WIDTH_RATIO];
        end
      end
    end
    else  //MEM_TYPE unsupported
    begin
      unsupported_MEM_TYPE  mem();
    end
  endgenerate


endmodule // generic_simple_dual_port_mixed_width_ram
