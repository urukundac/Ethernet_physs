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
 -- Module Name       : axi_fabric_search_key
 -- Author            : Gregory James
 -- Associated modules: 
 -- Function          : This module enables to lookup values for mapping
                        between axi-id & master/slave id.
 --------------------------------------------------------------------------
*/

`timescale 1ns / 10ps


module axi_fabric_search_key #(
//----------------------- Global parameters Declarations ------------------
   parameter  DATA_WIDTH              = 8
  ,parameter  KEY_WIDTH               = 8

  ,parameter  MODE                    = "MEM"       //Valid values are MEM or FIFO
  ,parameter  FIFO_DEPTH              = 16          //Only valid when MODE="FIFO"
  ,parameter  FIFO_AFULL_THRESHOLD    = FIFO_DEPTH  //Only valid when MODE="FIFO"
  ,parameter  string  FIFO_MEM_TYPE   = "BRAM"      //supported values are BRAM & REG
  ,parameter  DISABLE_FLUSH           = 1           //Only valid valid when MODE="MEM"

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


//----------------------- Start of Code -----------------------------------


  generate
    if(MODE == "MEM")
    begin
      axi_fabric_search_key_mem #(
         .DATA_WIDTH    (DATA_WIDTH    )
        ,.KEY_WIDTH     (KEY_WIDTH     )

        ,.DISABLE_FLUSH (DISABLE_FLUSH )

      ) u_search  (

        /*  input  logic                  */   .clk             (clk             )
        /*  input  logic                  */  ,.rst_n           (rst_n           )

        /*  input  logic                  */  ,.wr_en           (wr_en           )
        /*  input  logic [DATA_WIDTH-1:0] */  ,.wr_data         (wr_data         )
        /*  input  logic [KEY_WIDTH-1:0]  */  ,.wr_key          (wr_key          )
        /*  output logic                  */  ,.full            (full            )
        /*  output logic                  */  ,.afull           (afull           )

        /*  input  logic                  */  ,.search_en       (search_en       )
        /*  input  logic [KEY_WIDTH-1:0]  */  ,.search_key      (search_key      )
        /*  output logic                  */  ,.search_found    (search_found    )
        /*  output logic                  */  ,.search_miss     (search_miss     )
        /*  output logic [DATA_WIDTH-1:0] */  ,.search_result   (search_result   )

      );
    end
    else  //FIFO
    begin
      axi_fabric_search_key_fifo  #(
         .DATA_WIDTH            (DATA_WIDTH    )
        ,.KEY_WIDTH             (KEY_WIDTH     )

        ,.FIFO_DEPTH            (FIFO_DEPTH    )
        ,.FIFO_MEM_TYPE         (FIFO_MEM_TYPE )
        ,.FIFO_AFULL_THRESHOLD  (FIFO_AFULL_THRESHOLD)

      ) u_search  (

        /*  input  logic                  */   .clk             (clk             )
        /*  input  logic                  */  ,.rst_n           (rst_n           )

        /*  input  logic                  */  ,.wr_en           (wr_en           )
        /*  input  logic [DATA_WIDTH-1:0] */  ,.wr_data         (wr_data         )
        /*  input  logic [KEY_WIDTH-1:0]  */  ,.wr_key          (wr_key          )
        /*  output logic                  */  ,.full            (full            )
        /*  output logic                  */  ,.afull           (afull           )

        /*  input  logic                  */  ,.search_en       (search_en       )
        /*  input  logic [KEY_WIDTH-1:0]  */  ,.search_key      (search_key      )
        /*  output logic                  */  ,.search_found    (search_found    )
        /*  output logic                  */  ,.search_miss     (search_miss     )
        /*  output logic [DATA_WIDTH-1:0] */  ,.search_result   (search_result   )

      );
    end
  endgenerate


endmodule // axi_fabric_search_key
