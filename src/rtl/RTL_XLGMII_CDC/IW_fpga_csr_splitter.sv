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
 -- Project Code      : IMPrES
 -- Module Name       : IW_fpga_csr_splitter
 -- Author            : Gregory James
 -- Associated modules: 
 -- Function          : This module splits a common CSR bus amongst multiple
                        sub-blocks by evenly partitioning the address space.
                        Also combines read-data responses from multiple sub-blocks
                        into a common bus.
 --------------------------------------------------------------------------
*/

`timescale 1ns / 10ps


module IW_fpga_csr_splitter #(
   parameter  CSR_DATA_WIDTH            = 32
  ,parameter  CSR_ADDR_WIDTH            = 16

  ,parameter  NUM_CSR_SUBMODULES        = 1
  ,parameter  CSR_SUBMODULE_DATA_WIDTH  = 32
  ,parameter  CSR_SUBMODULE_ADDR_WIDTH  = 8

  ,parameter  PIPELINE_REQS             = 0
  ,parameter  PIPELINE_RSPS             = 0

) (

    input   logic                                   clk_csr
  , input   logic                                   rst_csr_n

  //Main CSR Bus
  , input   logic                                   csr_write
  , input   logic                                   csr_read
  , input   logic   [CSR_ADDR_WIDTH-1:0]            csr_addr
  , input   logic   [CSR_DATA_WIDTH-1:0]            csr_wr_data
  , output  logic   [CSR_DATA_WIDTH-1:0]            csr_rd_data
  , output  logic                                   csr_rd_valid

  //Split CSR Bus
  , output  logic   [NUM_CSR_SUBMODULES-1:0]        csr_submodule_write
  , output  logic   [NUM_CSR_SUBMODULES-1:0]        csr_submodule_read
  , output  logic   [CSR_SUBMODULE_ADDR_WIDTH-1:0]  csr_submodule_addr  [NUM_CSR_SUBMODULES-1:0]
  , output  logic   [CSR_SUBMODULE_DATA_WIDTH-1:0]  csr_submodule_wr_data  [NUM_CSR_SUBMODULES-1:0]
  , input   logic   [CSR_SUBMODULE_DATA_WIDTH-1:0]  csr_submodule_rd_data  [NUM_CSR_SUBMODULES-1:0]
  , input   logic   [NUM_CSR_SUBMODULES-1:0]        csr_submodule_rd_valid

);

//----------------------- Internal Parameters -----------------------------
  localparam  CSR_SUBMODULE_SEL_WIDTH    = CSR_ADDR_WIDTH  - CSR_SUBMODULE_ADDR_WIDTH;
  localparam  NUM_CSR_SUBMODULES_DEFAULT = NUM_CSR_SUBMODULES + 1;


  genvar  i;
  integer n;

//----------------------- Internal Register Declarations ------------------
  logic [CSR_SUBMODULE_DATA_WIDTH-1:0]    csr_submodule_wr_data_f;
  logic [CSR_SUBMODULE_ADDR_WIDTH-1:0]    csr_submodule_addr_f;
  logic [NUM_CSR_SUBMODULES  :0]          csr_submodule_rd_valid_w;
  logic [CSR_SUBMODULE_DATA_WIDTH-1:0]    csr_submodule_rd_data_w  [NUM_CSR_SUBMODULES:0];


//----------------------- Internal Wire Declarations ----------------------
  logic [CSR_SUBMODULE_SEL_WIDTH-1:0] csr_submodule_sel;

//----------------------- Start of Code -----------------------------------

  //Extract submodule-select from upper portion of csr-address
  assign  csr_submodule_sel                                = csr_addr[CSR_ADDR_WIDTH-1:CSR_SUBMODULE_ADDR_WIDTH];
  assign  csr_submodule_rd_valid_w[NUM_CSR_SUBMODULES-1:0] = csr_submodule_rd_valid;
  assign  csr_submodule_rd_valid_w[NUM_CSR_SUBMODULES]     = (csr_submodule_sel >= NUM_CSR_SUBMODULES) ? 1 : 0;

  assign  csr_submodule_rd_data_w[NUM_CSR_SUBMODULES-1:0] = csr_submodule_rd_data[NUM_CSR_SUBMODULES-1:0];
  assign  csr_submodule_rd_data_w[NUM_CSR_SUBMODULES]     = 'hBABADEAD;

  /*  Split requests  */
  generate
    if(PIPELINE_REQS)
    begin
      always@(posedge clk_csr,  negedge rst_csr_n)
      begin
        if(~rst_csr_n)
        begin
          csr_submodule_addr_f    <=  0;
          csr_submodule_wr_data_f <=  0;
        end
        else
        begin
          csr_submodule_addr_f    <=  csr_addr[CSR_SUBMODULE_ADDR_WIDTH-1:0];
          csr_submodule_wr_data_f <=  csr_wr_data[CSR_SUBMODULE_DATA_WIDTH-1:0];
        end
      end
    end
    else  //~PIPELINE_REQS
    begin
      assign  csr_submodule_addr_f    = 0;
      assign  csr_submodule_wr_data_f = 0;
    end

    for(i=0;i<NUM_CSR_SUBMODULES;i++)
    begin : gen_split_reqs
      if(PIPELINE_REQS)
      begin
        always@(posedge clk_csr,  negedge rst_csr_n)
        begin
          if(~rst_csr_n)
          begin
            csr_submodule_write[i]    <=  0;
            csr_submodule_read[i]     <=  0;
          end
          else
          begin
            csr_submodule_write[i]    <=  (csr_submodule_sel  ==  i)  ? csr_write : 0;
            csr_submodule_read[i]     <=  (csr_submodule_sel  ==  i)  ? csr_read  : 0;
          end
        end

        assign  csr_submodule_addr[i]     =  csr_submodule_addr_f;
        assign  csr_submodule_wr_data[i]  =  csr_submodule_wr_data_f;
      end
      else  //~PIPELINE_REQS
      begin
        assign  csr_submodule_write[i]    =  (csr_submodule_sel  ==  i)  ? csr_write : 0;
        assign  csr_submodule_read[i]     =  (csr_submodule_sel  ==  i)  ? csr_read  : 0;
        assign  csr_submodule_addr[i]     =  csr_addr[CSR_SUBMODULE_ADDR_WIDTH-1:0];
        assign  csr_submodule_wr_data[i]  =  csr_wr_data[CSR_SUBMODULE_DATA_WIDTH-1:0];
      end
    end //gen_split_reqs
  endgenerate

  /*  Merge responses */
  generate
    if(PIPELINE_RSPS)
    begin
      always@(posedge clk_csr,  negedge rst_csr_n)
      begin
        if(~rst_csr_n)
        begin
          csr_rd_data       <=  0;
          csr_rd_valid      <=  0;
        end
        else
        begin
          csr_rd_valid      <=  (|csr_submodule_rd_valid_w);

          for(n=0;n<NUM_CSR_SUBMODULES_DEFAULT;n++)
          begin
            if(csr_submodule_rd_valid_w[n])
            begin
              csr_rd_data   <=  csr_submodule_rd_data_w[n];
            end
          end
        end
      end
    end
    else  //~PIPELINE_REQS
    begin
      assign  csr_rd_valid  = (|csr_submodule_rd_valid_w);

      always@(*)
      begin
        csr_rd_data = 'h0;

        for(n=0;n<NUM_CSR_SUBMODULES_DEFAULT;n++)
        begin
          if(csr_submodule_rd_valid_w[n])
          begin
            csr_rd_data =  csr_submodule_rd_data_w[n];
          end
        end
      end
    end
  endgenerate


endmodule // IW_fpga_csr_splitter
