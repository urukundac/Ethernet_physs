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
 -- Module Name       : generic_sync_search_fifo
 -- Author            : Gregory James
 -- Associated modules: 
 -- Function          : A parameterizable synchronous FIFO with search option
                        on its read port.
 --------------------------------------------------------------------------
*/

`timescale 1ns / 10ps


module generic_sync_search_fifo #(
//----------------------- Global parameters Declarations ------------------
   parameter          WIDTH     = 8
  ,parameter          DEPTH     = 8 //Recommend to use power of 2, min value 8
  ,parameter  string  MEM_TYPE  = "BRAM"  //supported values are BRAM & REG

) (
//----------------------- Clock/Reset ------------------------------
   input  logic                   clk
  ,input  logic                   rst_n

//----------------------- Write Signals ------------------------------
  ,input  logic                   wr_en
  ,input  logic [WIDTH-1:0]       wr_data
  ,output logic                   full

//----------------------- Search Signals  ------------------------------
  ,input  logic                   search_en
  ,input  logic [WIDTH-1:0]       search_mask
  ,input  logic [WIDTH-1:0]       search_data
  ,output logic                   search_found
  ,output logic [WIDTH-1:0]       search_result

);

//----------------------- Import Packages ---------------------------------


//----------------------- Internal Parameters -----------------------------
  localparam  FF_A_DEPTH      = DEPTH / 2;
  localparam  FF_B_DEPTH      = DEPTH - FF_A_DEPTH;
  localparam  CNTR_WIDTH      = $clog2(DEPTH);


//----------------------- Internal Register Declarations ------------------
  logic [CNTR_WIDTH-1:0]      search_cntr;

  logic                       wr_back_en;
  logic [WIDTH-1:0]           wr_back_data;

//----------------------- Internal Wire Declarations ----------------------
  logic                       ff_a_wr_en;
  logic [WIDTH-1:0]           ff_a_wr_data;
  logic                       ff_a_full;

  logic                       ff_a_rd_en;
  logic [WIDTH-1:0]           ff_a_rd_data;
  logic [WIDTH-1:0]           ff_a_rd_data_masked;
  logic                       ff_a_empty;

  logic                       ff_b_wr_en;
  logic [WIDTH-1:0]           ff_b_wr_data;
  logic                       ff_b_full;

  logic                       ff_b_rd_en;
  logic [WIDTH-1:0]           ff_b_rd_data;
  logic [WIDTH-1:0]           ff_b_rd_data_masked;
  logic                       ff_b_empty;


  logic                       search_flip;

//----------------------- FSM Register Declarations ------------------
  enum  logic [0:0] {
    SEARCH_A_S  = 1'b0,
    SEARCH_B_S  = 1'b1
  } fsm_pstate;

//----------------------- Start of Code -----------------------------------


  /*  Instantiate Dual Buffers  */
  generic_sync_fifo #(
     .WRITE_WIDTH (WIDTH)
    ,.READ_WIDTH  (WIDTH)
    ,.NUM_BITS    (WIDTH*FF_A_DEPTH)
    ,.MEM_TYPE    (MEM_TYPE)

  ) u_ff_a  (

    /*  input  logic                    */   .clk           (clk)
    /*  input  logic                    */  ,.rst_n         (rst_n)

    /*  input  logic                    */  ,.wr_en         (ff_a_wr_en)
    /*  input  logic [WIDTH-1:0]        */  ,.wr_data       (ff_a_wr_data)
    /*  output logic                    */  ,.full          (ff_a_full)
    /*  output logic                    */  ,.afull         ()

    /*  input  logic                    */  ,.rd_en         (ff_a_rd_en)
    /*  output logic [WIDTH-1:0]        */  ,.rd_data       (ff_a_rd_data)
    /*  output logic                    */  ,.empty         (ff_a_empty)
    /*  output logic                    */  ,.aempty        ()

    /*  output logic [$clog2(DEPTH):0]  */  ,.wr_occupancy  ()
    /*  output logic [$clog2(DEPTH):0]  */  ,.rd_occupancy  ()
    /*  output logic                    */  ,.wr_overflow   ()
    /*  output logic                    */  ,.rd_underflow  ()

  );

  assign  ff_a_rd_data_masked = ff_a_rd_data  & search_mask;


  generic_sync_fifo #(
     .WRITE_WIDTH (WIDTH)
    ,.READ_WIDTH  (WIDTH)
    ,.NUM_BITS    (WIDTH*FF_B_DEPTH)
    ,.MEM_TYPE    (MEM_TYPE)

  ) u_ff_b  (

    /*  input  logic                    */   .clk           (clk)
    /*  input  logic                    */  ,.rst_n         (rst_n)

    /*  input  logic                    */  ,.wr_en         (ff_b_wr_en)
    /*  input  logic [WIDTH-1:0]        */  ,.wr_data       (ff_b_wr_data)
    /*  output logic                    */  ,.full          (ff_b_full)
    /*  output logic                    */  ,.afull         ()

    /*  input  logic                    */  ,.rd_en         (ff_b_rd_en)
    /*  output logic [WIDTH-1:0]        */  ,.rd_data       (ff_b_rd_data)
    /*  output logic                    */  ,.empty         (ff_b_empty)
    /*  output logic                    */  ,.aempty        ()

    /*  output logic [$clog2(DEPTH):0]  */  ,.wr_occupancy  ()
    /*  output logic [$clog2(DEPTH):0]  */  ,.rd_occupancy  ()
    /*  output logic                    */  ,.wr_overflow   ()
    /*  output logic                    */  ,.rd_underflow  ()

  );

  assign  ff_b_rd_data_masked = ff_b_rd_data  & search_mask;


  /*  FSM Logic */
  always@(posedge clk,  negedge rst_n)
  begin
    if(~rst_n)
    begin
      fsm_pstate              <=  SEARCH_A_S;
      search_cntr             <=  {CNTR_WIDTH{1'b0}};
    end
    else
    begin
      search_cntr             <=  search_flip ? {CNTR_WIDTH{1'b0}}  : search_cntr + 1'b1;

      if(fsm_pstate ==  SEARCH_A_S)
      begin
        fsm_pstate            <=  search_flip ? SEARCH_B_S  : fsm_pstate;
      end
      else
      begin
        fsm_pstate            <=  search_flip ? SEARCH_A_S  : fsm_pstate;
      end
    end
  end

  always_comb
  begin
    if(fsm_pstate ==  SEARCH_A_S)
    begin
      search_flip = (search_cntr  ==  FF_A_DEPTH-1) ? 1'b1  : 1'b0;
    end
    else
    begin
      search_flip = (search_cntr  ==  FF_B_DEPTH-1) ? 1'b1  : 1'b0;
    end
  end

  assign  full  = (fsm_pstate ==  SEARCH_A_S) ? ff_a_full : ff_b_full;


  /*
    * Search Logic
    * Keep reading & writing back from the FF currently selected for search
    * If a match is found do not write it back to the FF
  */
  always@(posedge clk,  negedge rst_n)
  begin
    if(~rst_n)
    begin
      search_found            <=  1'b0;
      search_result           <=  {WIDTH{1'b0}};

      wr_back_en              <=  1'b0;
    end
    else
    begin
      if(fsm_pstate == SEARCH_A_S)
      begin
        search_found          <=  (ff_a_rd_data_masked  ==  search_data)  ? ff_a_rd_en  : 1'b0;
        search_result         <=  ff_a_rd_data;

        wr_back_en            <=  (ff_a_rd_data_masked  !=  search_data)  ? ff_a_rd_en  : 1'b0;
      end
      else
      begin
        search_found          <=  (ff_b_rd_data_masked  ==  search_data)  ? ff_b_rd_en  : 1'b0;
        search_result         <=  ff_b_rd_data;

        wr_back_en            <=  (ff_b_rd_data_masked  !=  search_data)  ? ff_b_rd_en  : 1'b0;
      end
    end
  end

  assign  ff_a_rd_en    = (fsm_pstate == SEARCH_A_S)  ? search_en & ~ff_a_empty : 1'b0;

  assign  ff_b_rd_en    = (fsm_pstate == SEARCH_B_S)  ? search_en & ~ff_b_empty : 1'b0;

  assign  wr_back_data  = search_result;

  always_comb
  begin
    if(fsm_pstate == SEARCH_A_S)  //Write into FF_B, Writeback into FF_A
    begin
      ff_a_wr_en    = wr_back_en;
      ff_a_wr_data  = wr_back_data;

      ff_b_wr_en    = wr_en;
      ff_b_wr_data  = wr_data;
    end
    else  //Write into FF_A, Writeback into FF_B
    begin
      ff_a_wr_en    = wr_en;
      ff_a_wr_data  = wr_data;

      ff_b_wr_en    = wr_back_en;
      ff_b_wr_data  = wr_back_data;
    end
  end

endmodule // generic_sync_search_fifo
