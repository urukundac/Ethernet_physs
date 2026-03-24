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
 -- Module Name       : IW_fpga_dbg_logger_qmngr
 -- Author            : Gregory James
 -- Associated modules: 
 -- Function          : This module maintains a multi partition table for memory
 --------------------------------------------------------------------------
*/

`timescale 1ns / 10ps

module  IW_fpga_dbg_logger_qmngr  #(
   parameter  NUM_QUEUES                    = 1     //Total number of queues
  ,parameter  MEM_ADDR_W                    = 16    //Address width of memory
  ,parameter  MEM_DATA_W                    = 256   //Data width of memory
  ,parameter  int PARTITION_START_PTR_INIT_LIST [NUM_QUEUES-1:0]  = '{default:'0}
  ,parameter  int PARTITION_END_PTR_INIT_LIST   [NUM_QUEUES-1:0]  = '{default:'0}

) (

   input  logic                   clk
  ,input  logic                   rst_n

  //Queue partition inputs
  ,input  logic [MEM_ADDR_W-1:0]  queue_start_ptr_arry  [NUM_QUEUES-1:0]
  ,input  logic [MEM_ADDR_W-1:0]  queue_end_ptr_arry    [NUM_QUEUES-1:0]
  ,input  logic [MEM_ADDR_W-1:0]  queue_locs_read       [NUM_QUEUES-1:0]
  ,input  logic [NUM_QUEUES-1:0]  queue_locs_rddone     

  //Read/Write Control Interface
  ,input  logic [NUM_QUEUES-1:0]  wr_valid
  ,output logic [NUM_QUEUES-1:0]  wr_full

  ,output logic [NUM_QUEUES-1:0]  rd_empty

  //CSR
  ,input  logic                   init_queues
  ,input  logic [NUM_QUEUES-1:0]  queue_mode
  ,output logic [MEM_ADDR_W-1:0]  queue_wptr_arry [NUM_QUEUES-1:0]
  ,output logic [MEM_ADDR_W-1:0]  queue_rptr_arry [NUM_QUEUES-1:0]
  ,output logic [MEM_ADDR_W-1:0]  queue_occ_arry  [NUM_QUEUES-1:0]

);

  /*  Internal Parameters */

  /*  Internal Variables  */
  genvar  i;

  logic [NUM_QUEUES-1:0]  wr_valid_n_full;
  logic [NUM_QUEUES-1:0]  rd_valid_n_empty;
  logic [MEM_ADDR_W-1:0]  queue_size_arry [NUM_QUEUES-1:0];

  generate
    for(i=0;i<NUM_QUEUES;i++)
    begin : gen_main
      //Generate full/empty protection for rd & wr valids
      assign  wr_valid_n_full[i]  = wr_valid[i] & ~wr_full[i];
      assign  rd_valid_n_empty[i] = queue_locs_rddone[i] & ~rd_empty[i];

      //Calculate the size of each queue based on start & end pointers
      assign  queue_size_arry[i]  = queue_end_ptr_arry[i] - queue_start_ptr_arry[i] + 1;

      /*
        * Main logic
      */
      always@(posedge clk,  negedge rst_n)
      begin
        if(~rst_n)
        begin
          wr_full[i]            <=  0;
          rd_empty[i]           <=  1'b1;

          queue_wptr_arry[i]    <=  PARTITION_START_PTR_INIT_LIST[i];
          queue_rptr_arry[i]    <=  PARTITION_START_PTR_INIT_LIST[i];
          queue_occ_arry[i]     <=  0;
        end
        else
        begin
          if(init_queues)
          begin
            wr_full[i]          <=  0;
            rd_empty[i]         <=  1'b1;

            queue_wptr_arry[i]  <=  queue_start_ptr_arry[i];
            queue_rptr_arry[i]  <=  queue_start_ptr_arry[i];
            queue_occ_arry[i]   <=  0;
          end
          else
          begin
            case({wr_valid_n_full[i],rd_valid_n_empty[i]})

              2'b00 : //NOP
              begin
                wr_full[i]          <=  wr_full[i];
                rd_empty[i]         <=  rd_empty[i];
                queue_wptr_arry[i]  <=  queue_wptr_arry[i];
                queue_rptr_arry[i]  <=  queue_rptr_arry[i];
                queue_occ_arry[i]   <=  queue_occ_arry[i];
              end

              2'b01 : //Only Read
              begin
                wr_full[i]          <=  1'b0;
                queue_wptr_arry[i]  <=  queue_wptr_arry[i];
                queue_occ_arry[i]   <=  queue_occ_arry[i] - queue_locs_read[i];
                rd_empty[i]         <=  (queue_occ_arry[i]  ==  queue_locs_read[i])  ? 1'b1  : rd_empty[i];

                if(queue_rptr_arry[i] + queue_locs_read[i] > queue_end_ptr_arry[i])
                  queue_rptr_arry[i]  <= queue_rptr_arry[i] + queue_locs_read[i] - queue_size_arry[i];
                else
                  queue_rptr_arry[i]  <= queue_rptr_arry[i] + queue_locs_read[i];
              end

              2'b10 : //Only Write
              begin
                rd_empty[i]         <=  1'b0;
                queue_wptr_arry[i]  <=  (queue_wptr_arry[i] ==  queue_end_ptr_arry[i])  ? queue_start_ptr_arry[i] : queue_wptr_arry[i]  + 1'b1;
                wr_full[i]          <=  (queue_occ_arry[i] ==  queue_size_arry[i] -  1'b1) ? 1'b1 : wr_full[i];
                queue_rptr_arry[i]  <=  queue_rptr_arry[i];
                queue_occ_arry[i]   <=  queue_occ_arry[i] + 1'b1;
              end

              2'b11 : //Read & Write
              begin
                queue_wptr_arry[i]  <=  (queue_wptr_arry[i] ==  queue_end_ptr_arry[i])  ? queue_start_ptr_arry[i] : queue_wptr_arry[i]  + 1'b1;
                queue_occ_arry[i]   <=  queue_occ_arry[i] - queue_locs_read[i] + 1'b1;
                wr_full[i]          <=  1'b0;
                rd_empty[i]         <=  1'b0;
                if(queue_rptr_arry[i] + queue_locs_read[i] > queue_end_ptr_arry[i])
                  queue_rptr_arry[i]  <= queue_rptr_arry[i] + queue_locs_read[i] - queue_size_arry[i];
                else
                  queue_rptr_arry[i]  <= queue_rptr_arry[i] + queue_locs_read[i];
              end

            endcase
          end
        end
      end
    end
  endgenerate

endmodule //IW_fpga_dbg_logger_qmngr
