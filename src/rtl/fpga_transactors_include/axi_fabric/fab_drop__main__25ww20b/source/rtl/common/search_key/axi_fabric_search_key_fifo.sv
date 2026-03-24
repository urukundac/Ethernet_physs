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
 -- Module Name       : axi_fabric_search_key_fifo
 -- Author            : Gregory James
 -- Associated modules: 
 -- Function          : This module enables to lookup values for mapping
                        between axi-id & master/slave id.
 --------------------------------------------------------------------------
*/

`timescale 1ns / 10ps


module axi_fabric_search_key_fifo #(
//----------------------- Global parameters Declarations ------------------
   parameter  DATA_WIDTH              = 8
  ,parameter  KEY_WIDTH               = 8

  ,parameter  FIFO_DEPTH              = 16
  ,parameter  FIFO_MEM_TYPE           = "BRAM"  //Valid values are BRAM or REG
  ,parameter  FIFO_AFULL_THRESHOLD    = FIFO_DEPTH  //Only valid when MODE="FIFO"

) (
//----------------------- Clock/Reset ------------------------------
   input  logic                   clk
  ,input  logic                   rst_n

//----------------------- Write Signals ------------------------------
  ,input  logic                   wr_en
  ,input  logic [DATA_WIDTH-1:0]  wr_data
  ,input  logic [KEY_WIDTH-1:0]   wr_key
  ,output logic                   full
  ,output logic                   afull

//----------------------- Search Signals  ------------------------------
  ,input  logic                   search_en
  ,input  logic [KEY_WIDTH-1:0]   search_key
  ,output logic                   search_found
  ,output logic                   search_miss
  ,output logic [DATA_WIDTH-1:0]  search_result


);

//----------------------- Import Packages ---------------------------------


//----------------------- Internal Parameters -----------------------------


//----------------------- Internal Register Declarations ------------------


//----------------------- Internal Wire Declarations ----------------------
  wire                        ff_empty;
  wire  [DATA_WIDTH-1:0]      ff_rd_data;
  logic                       ff_rd_en;


//----------------------- Start of Code -----------------------------------

  /*  Instantiate FIFO */
  generic_sync_fifo #(
     .WRITE_WIDTH       (DATA_WIDTH)
    ,.READ_WIDTH        (DATA_WIDTH)
    ,.NUM_BITS          (DATA_WIDTH*FIFO_DEPTH)
    ,.MEM_TYPE          (FIFO_MEM_TYPE)
    ,.AFULL_THRESHOLD   (FIFO_AFULL_THRESHOLD)
    ,.AEMPTY_THRESHOLD  (1)

  ) u_fifo  (

    /*  input  logic                    */   .clk           (clk)
    /*  input  logic                    */  ,.rst_n         (rst_n)

    /*  input  logic                    */  ,.wr_en         (wr_en)
    /*  input  logic [WIDTH-1:0]        */  ,.wr_data       (wr_data)
    /*  output logic                    */  ,.full          (full)
    /*  output logic                    */  ,.afull         (afull)

    /*  input  logic                    */  ,.rd_en         (ff_rd_en)
    /*  output logic [WIDTH-1:0]        */  ,.rd_data       (ff_rd_data)
    /*  output logic                    */  ,.empty         (ff_empty)
    /*  output logic                    */  ,.aempty        ()

    /*  output logic [$clog2(DEPTH):0]  */  ,.wr_occupancy  ()
    /*  output logic [$clog2(DEPTH):0]  */  ,.rd_occupancy  ()
    /*  output logic                    */  ,.wr_overflow   ()
    /*  output logic                    */  ,.rd_underflow  ()

  );

  assign  ff_rd_en  = search_en & ~ff_empty & ~search_found;


  always@(posedge clk,  negedge rst_n)
  begin
    if(~rst_n)
    begin
      search_found            <=  1'b0;
      search_result           <=  {DATA_WIDTH{1'b0}};
    end
    else
    begin
      if(search_found)
      begin
        search_found          <=  ~search_en;
      end
      else
      begin
        search_found          <=  search_en & ~ff_empty;
      end

      search_result           <=  ff_rd_en  ? ff_rd_data  : search_result;
    end
  end

  assign  search_miss = 1'b0;


endmodule // axi_fabric_search_key_fifo
