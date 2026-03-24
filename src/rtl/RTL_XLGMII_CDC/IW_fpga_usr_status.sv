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
 -- Module Name       : IW_fpga_usr_status
 -- Author            : Gregory James
 -- Associated modules: 
 -- Function          : This module converts Avalon-Memory-Mapped bus to a
                        status-bus for use in misc-sa.
 --------------------------------------------------------------------------
*/

`timescale 1ns / 10ps


module IW_fpga_usr_status #(
   parameter  AVMM_ADDR_W         = 16
  ,parameter  AVMM_DATA_W         = 32

  ,parameter  DEBUG_NUM_USR_REGS  = 1

  ,parameter  NUM_SYNC_CYCLES     = 16
  ,parameter  DEFAULT_VAL         = 32'hdeadbabe

) (

   input  logic                         clk
  ,input  logic                         rst_n

  /*  AV-MM Interface */
  ,output logic                         avmm_waitrequest
  ,input  logic [AVMM_ADDR_W-1:0]       avmm_address
  ,input  logic                         avmm_read
  ,input  logic                         avmm_write
  ,input  logic [AVMM_DATA_W-1:0]       avmm_writedata
  ,input  logic [(AVMM_DATA_W/8)-1:0]   avmm_byteenable
  ,output logic                         avmm_readdatavalid
  ,output logic [AVMM_DATA_W-1:0]       avmm_readdata

  /*  User Status Bus */
  ,input  wire  [AVMM_DATA_W-1:0]       usr_status  [DEBUG_NUM_USR_REGS-1:0]
  /*  User Control Bus */
  ,output reg   [AVMM_DATA_W-1:0]       usr_cntrl   [DEBUG_NUM_USR_REGS-1:0]

);

//----------------------- Import Packages ---------------------------------


//----------------------- Internal Parameters -----------------------------
  localparam  SYNC_COUNTER_W  = $clog2(NUM_SYNC_CYCLES) + 1;


//----------------------- Internal Register Declarations ------------------
  logic [(AVMM_ADDR_W-2)-1:0] avmm_address_word_aligned;
  logic [SYNC_COUNTER_W-1:0]  sync_counter_f;


//----------------------- Internal Wire Declarations ----------------------
  logic                       sync_idle;

  logic [AVMM_DATA_W-1:0]     avmm_readdata_next;
  logic [AVMM_DATA_W-1:0]     avmm_readdata_next_sync;


//----------------------- Start of Code -----------------------------------

  assign  avmm_waitrequest  = ~sync_idle;


  always@(*)
  begin
    if(avmm_address_word_aligned < DEBUG_NUM_USR_REGS)
    begin
      avmm_readdata_next  = usr_status[avmm_address_word_aligned];
    end
    else
    begin
      avmm_readdata_next  = DEFAULT_VAL;
    end
  end

  /*  Synchronize */
  IW_fpga_double_sync#(.WIDTH(AVMM_DATA_W),.NUM_STAGES(2))  u_IW_fpga_double_sync_avmm_readdata_next  (.clk(clk),.sig_in(avmm_readdata_next),.sig_out(avmm_readdata_next_sync));

  always@(posedge clk,  negedge rst_n)
  begin
    if(~rst_n)
    begin
      sync_counter_f            <=  0;
      avmm_address_word_aligned <=  0;

      avmm_readdatavalid        <=  0;
      avmm_readdata             <=  0;
      for (int i=0; i<DEBUG_NUM_USR_REGS; i=i+1)
       usr_cntrl[i] <= {AVMM_DATA_W{1'b0}};
    end
    else
    begin
      if(sync_idle)
      begin
        sync_counter_f          <=  (avmm_read & ~avmm_waitrequest) ? NUM_SYNC_CYCLES : 0;
      end
      else
      begin
        sync_counter_f          <=  sync_counter_f  - 1'b1;
      end

      avmm_address_word_aligned <=  (avmm_read & ~avmm_waitrequest) ? avmm_address[AVMM_ADDR_W-1:2] : avmm_address_word_aligned;

      avmm_readdatavalid        <=  (sync_counter_f ==  1)  ? 1'b1  : 1'b0;
      avmm_readdata             <=  avmm_readdata_next_sync;

      // write logic supporting only word write
      if ( avmm_write & ~avmm_waitrequest)
        usr_cntrl[avmm_address[AVMM_ADDR_W-1:2]] <= avmm_writedata;
    end
  end

  assign  sync_idle = (sync_counter_f ==  0)  ? 1'b1  : 1'b0;

endmodule // IW_fpga_usr_status
