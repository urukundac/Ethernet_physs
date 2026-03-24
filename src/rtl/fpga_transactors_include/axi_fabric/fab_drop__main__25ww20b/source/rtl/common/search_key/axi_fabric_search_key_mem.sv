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
 -- Module Name       : axi_fabric_search_key_mem
 -- Author            : Gregory James
 -- Associated modules: 
 -- Function          : This module enables to lookup values for mapping
                        between axi-id & master/slave id.
 --------------------------------------------------------------------------
*/

`timescale 1ns / 10ps


module axi_fabric_search_key_mem #(
//----------------------- Global parameters Declarations ------------------
   parameter  DATA_WIDTH    = 8
  ,parameter  KEY_WIDTH     = 8

  ,parameter  DISABLE_FLUSH = 1

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
  localparam  MEM_RD_DELAY    = 1;
  localparam  MEM_DATA_WIDTH  = DATA_WIDTH+1;


//----------------------- Internal Register Declarations ------------------
  reg   [MEM_RD_DELAY-1:0]    search_en_pipe;
  logic                       flush_key;


//----------------------- Internal Wire Declarations ----------------------
  wire  [MEM_DATA_WIDTH-1:0]  mem_rd_data;
  wire                        key_valid;
  wire  [DATA_WIDTH-1:0]      key_map_value;



//----------------------- Start of Code -----------------------------------


  /*  Instantiate lookup memory */
  generic_true_dual_port_ram #(
     .DATA_WIDTH  (MEM_DATA_WIDTH)
    ,.ADDR_WIDTH  (KEY_WIDTH)

  ) u_mem (

    /*  input  logic                  */   .clk         (clk)

    /*  input  logic                  */  ,.wr_en_a     (wr_en)
    /*  input  logic [DATA_WIDTH-1:0] */  ,.wr_data_a   ({1'b1,wr_data})
    /*  input  logic [ADDR_WIDTH-1:0] */  ,.addr_a      (wr_key)
    /*  output logic [DATA_WIDTH-1:0] */  ,.rd_data_a   ()

    /*  input  logic                  */  ,.wr_en_b     (flush_key)
    /*  input  logic [DATA_WIDTH-1:0] */  ,.wr_data_b   ({MEM_DATA_WIDTH{1'b0}})
    /*  input  logic [ADDR_WIDTH-1:0] */  ,.addr_b      (search_key)
    /*  output logic [DATA_WIDTH-1:0] */  ,.rd_data_b   (mem_rd_data)

  );

  assign  {key_valid,key_map_value} = mem_rd_data;


  /*  Search result logic */
  always@(posedge clk,  negedge rst_n)
  begin
    if(~rst_n)
    begin

      search_found            <=  1'b0;
      search_miss             <=  1'b0;
      search_result           <=  {DATA_WIDTH{1'b0}};
    end
    else
    begin
      if(search_en_pipe[MEM_RD_DELAY-1])
      begin
        search_found          <=  key_valid;
        search_miss           <=  ~key_valid;
        search_result         <=  key_map_value;
      end
      else
      begin
        search_found          <=  1'b0;
        search_miss           <=  1'b0;
      end
    end
  end


  generate
    /*  Search Enable Pipe */
    if(MEM_RD_DELAY < 2)
    begin
      always@(posedge clk,  negedge rst_n)
      begin
        if(~rst_n)
        begin
          search_en_pipe    <=  {MEM_RD_DELAY{1'b0}};
        end
        else
        begin
          //search_en_pipe    <=  (search_en_pipe[MEM_RD_DELAY-1] | search_found | search_miss) ? {MEM_RD_DELAY{1'b0}}  : search_en;
          search_en_pipe    <=  search_en;
        end
      end
    end
    else
    begin
      always@(posedge clk,  negedge rst_n)
      begin
        if(~rst_n)
        begin
          search_en_pipe    <=  {MEM_RD_DELAY{1'b0}};
        end
        else
        begin
          search_en_pipe    <=  {search_en_pipe[MEM_RD_DELAY-2:0],search_en};
        end
      end
    end

    /*  Flush Logic */
    if(DISABLE_FLUSH)
    begin
      assign  flush_key = 1'b0;
    end
    else
    begin
      always@(posedge clk,  negedge rst_n)
      begin
        if(~rst_n)
        begin
          flush_key     <=  1'b0;
        end
        else
        begin
          if(search_en_pipe[MEM_RD_DELAY-1])
          begin
            flush_key   <=  1'b1;
          end
          else
          begin
            flush_key   <=  1'b0;
          end
        end
      end
    end
  endgenerate

  //Not valid for BRAM mode
  assign  full  = 1'b0;
  assign  afull = 1'b0;



endmodule // axi_fabric_search_key_mem
