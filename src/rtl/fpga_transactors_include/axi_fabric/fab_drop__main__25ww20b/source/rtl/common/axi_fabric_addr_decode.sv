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
 -- Module Name       : axi_fabric_addr_decode
 -- Author            : Gregory James
 -- Associated modules: 
 -- Function          : This block decodes addresses for a single master
                        mapped to multiple slaves.
 --------------------------------------------------------------------------
*/

`timescale 1ns / 10ps


module axi_fabric_addr_decode #(
//----------------------- Global parameters Declarations ------------------
   parameter  NUM_SLAVES  = 4
  ,parameter  SLAVE_ID_W  = (NUM_SLAVES > 1) ? $clog2(NUM_SLAVES) : 1
  ,parameter  ADDR_W      = 8
  ,parameter  CARGO_W     = 1

) (
//----------------------- Input Declarations ------------------------------
   input  logic                   clk
  ,input  logic                   rst_n

  ,input  logic [ADDR_W-1:0]      addr_map [0:NUM_SLAVES-1][0:1]

  ,input  logic                   addr_valid
  ,input  logic [ADDR_W-1:0]      addr
  ,input  logic [CARGO_W-1:0]     cargo_in

//----------------------- Output Declarations -----------------------------
  ,output logic                   addr_decode_valid
  ,output logic                   addr_decode_no_match
  ,output logic [NUM_SLAVES-1:0]  slave_sel
  ,output logic [SLAVE_ID_W-1:0]  slave_id
  ,output logic [CARGO_W-1:0]     cargo_out

);

//----------------------- Import Packages ---------------------------------


//----------------------- Internal Parameters -----------------------------


//----------------------- Internal Register Declarations ------------------


//----------------------- Internal Wire Declarations ----------------------
  logic [NUM_SLAVES-1:0]      slave_sel_next;
  logic [SLAVE_ID_W-1:0]      slave_id_next;


  integer n;
  genvar  i,j;

//----------------------- Start of Code -----------------------------------

  /*  Check for Address Map Overlap */
  /*
  generate
    for(i=0;i<NUM_SLAVES;i++)
    begin : chk_addr_map_overlap
      for(j=0;j<NUM_SLAVES;j++)
      begin
        if(j  !=  i)
        begin
          if(
              ((ADDR_MAP[i][0] > ADDR_MAP[j][0])  &&  (ADDR_MAP[i][0] < ADDR_MAP[j][1]))  ||
              ((ADDR_MAP[i][1] > ADDR_MAP[j][0])  &&  (ADDR_MAP[i][1] < ADDR_MAP[j][1]))
            )
          begin
            addr_map_overlap  error();
          end
        end
      end
    end
  endgenerate
  */


  always@(posedge clk,  negedge rst_n)
  begin
    if(~rst_n)
    begin
      addr_decode_valid       <=  1'b0;
      addr_decode_no_match    <=  1'b0;
      slave_sel               <=  {NUM_SLAVES{1'b0}};
      slave_id                <=  {SLAVE_ID_W{1'b0}};
      cargo_out               <=  {CARGO_W{1'b0}};
    end
    else
    begin
      addr_decode_valid       <=  (slave_sel_next !=  {NUM_SLAVES{1'b0}}) ? addr_valid  : 1'b0;
      addr_decode_no_match    <=  (slave_sel_next ==  {NUM_SLAVES{1'b0}}) ? addr_valid  : 1'b0;
      slave_sel               <=  slave_sel_next;
      slave_id                <=  slave_id_next;
      cargo_out               <=  cargo_in;
    end
  end

  always_comb
  begin
    slave_sel_next  = {NUM_SLAVES{1'b0}};
    slave_id_next   = slave_id;

    for(n=0;n<NUM_SLAVES;n++)
    begin
      if((addr >= addr_map[n][0]) && (addr  <=  addr_map[n][1]))
      begin
        slave_sel_next[n]   = 1'b1;
        slave_id_next       = n;
      end
    end
  end

endmodule // axi_fabric_addr_decode
