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
 -- Module Name       : IW_fpga_usync_gen
 -- Author            : Gregory James
 -- Associated modules: 
 -- Function          : This module generates USync pulses for multiple
                        clock domains by detecting the global align points.
 --------------------------------------------------------------------------
*/

`timescale 1ns / 10ps


module IW_fpga_usync_gen #(
   parameter  NUM_CLOCKS        = 1
  ,parameter  USYNC_GAL_OFFSET  = 3 //Number of cycles before GAL point to generate usync pulse
  ,parameter  GAL_LOGIC_TAP     = 0 //Which logic clock to run GAL counter mux/demux
  ,parameter  EDGE_DET_CNTR_W   = 8
  ,parameter  GAL_CNTR_W        = 16
  ,parameter  GAL_FREQ_DIV      = 1
  ,parameter CLK_LOGIC_DIV_VALUE= 1 // GAL window redefined using a subset of divider value of clock GAL_LOGIC_TAP

) (

   input  logic                     clk_fast
  ,input  logic                     rst_fast_n

  ,input  logic [NUM_CLOCKS-1:0]    clk_logic_vec
  ,input  logic [NUM_CLOCKS-1:0]    rst_logic_vec_n
  ,output logic                     clk_en

  ,output logic [NUM_CLOCKS-1:0]    usync_vec

  ,output logic [NUM_CLOCKS-1:0] [GAL_CNTR_W-1:0]   clk_logic_gal_cntr
  ,output logic [NUM_CLOCKS-1:0] [GAL_CNTR_W-1:0]   clk_logic_gal_start_val 

);

//----------------------- Import Packages ---------------------------------


//----------------------- Internal Parameters -----------------------------
  localparam  GAL_START_OFFSET  = USYNC_GAL_OFFSET  + 2;


//----------------------- Internal Register Declarations ------------------
  genvar  i;
  logic                       clk_logic_gal_valid;
  logic                       clk_logic_gal_div_valid;
  logic [GAL_CNTR_W-1:0]      gal_div_cntr;
  logic [NUM_CLOCKS-1:0]      clk_logic_gal_valid_sync;
  logic [NUM_CLOCKS-1:0]      usync_vec_int;


//----------------------- Internal Wire Declarations ----------------------
  logic [NUM_CLOCKS-1:0]      clk_logic_edge_det_valid_vec;
  logic [NUM_CLOCKS-1:0]      clk_logic_edge_det_valid_vec_w;


//----------------------- Start of Code -----------------------------------

  /*  Detect Edges of all the logic clocks  */
  generate
    for(i=0;i<NUM_CLOCKS;i++)
    begin : gen_clk_logic_edge_det_valid
      IW_fpga_early_clk_det #(
         .CNTR_W            (EDGE_DET_CNTR_W)
        ,.NUM_CYCLES_EARLY  (4)

      ) u_IW_fpga_early_clk_det (

         .clk_fast            (clk_fast)
        `ifdef FPGA_SIM
          ,.rst_fast_n          (rst_fast_n)
        `else
          ,.rst_fast_n          (1'b1) // reduce async load 
        `endif
        ,.clk_slow            (clk_logic_vec[i])
        ,.rst_slow_n          (rst_logic_vec_n[i])

        ,.edge_det_cntr       ()
        ,.edge_det_start_val  ()
        ,.edge_det_valid      (clk_logic_edge_det_valid_vec[i])

      );

      if ( CLK_LOGIC_DIV_VALUE > 1 ) begin
        assign clk_logic_edge_det_valid_vec_w[i] = (GAL_LOGIC_TAP==i) ? (clk_en & clk_logic_edge_det_valid_vec[i]) : clk_logic_edge_det_valid_vec[i]; // not synchronzing clk_en as its mc path compared to clk_fast pulse that is ANDed
      end
      else begin
        assign clk_logic_edge_det_valid_vec_w[i] = clk_logic_edge_det_valid_vec[i];
      end
    end
  endgenerate

  /*  Find the point when all clock edges are valid aka GAL point */
  always@(posedge clk_fast, negedge rst_fast_n)
  begin
    if(~rst_fast_n)
    begin
      clk_logic_gal_valid       <=  0;
    end
    else
    begin
      clk_logic_gal_valid       <=  &clk_logic_edge_det_valid_vec_w ;
    end
  end

  // clk logic derive en so that we can run at sub ratio of clk_logic
  generate
    if ((CLK_LOGIC_DIV_VALUE == 0) || (CLK_LOGIC_DIV_VALUE == 1)) // div1 is a buffer
    begin
      assign clk_en = 1'b1;
    end
    else begin
      localparam DIVBITS = $clog2(CLK_LOGIC_DIV_VALUE);
      logic [DIVBITS-1:0]        cnt=0;
      logic [2:0]                resync; 
      logic [2:0]                resync_clk_logic;

      IW_fpga_double_sync#(.WIDTH(3),.NUM_STAGES(2))  u_IW_resync_clken (
        .clk(clk_logic_vec[GAL_LOGIC_TAP]),.sig_in(resync),.sig_out(resync_clk_logic));
      // ensure the clk_en is aligned to gal window of other clocks
      always@(posedge clk_fast, negedge rst_fast_n)
      begin
        if(~rst_fast_n)
        begin
          resync   <= 3'b0;
        end
        else
        begin
          if ( &clk_logic_edge_det_valid_vec ) resync <= {resync[1:0],1'b1};
        end
      end
      //Counter
      always_ff @(posedge clk_logic_vec[GAL_LOGIC_TAP] )
      begin
       // align to the original clock edges to start the en so that it falls on edge of all clocks
       if ((|(~resync_clk_logic)) && (CLK_LOGIC_DIV_VALUE >3 ))
         cnt <= 2;
       else if (cnt == CLK_LOGIC_DIV_VALUE-1) 
         cnt <= 0;
       else
         cnt <= cnt + 1;
      end
      always_ff @(posedge clk_logic_vec[GAL_LOGIC_TAP] )
        clk_en <= (cnt == CLK_LOGIC_DIV_VALUE-1);
    end
  endgenerate


  generate
    if(GAL_FREQ_DIV > 1)
    begin
      always@(posedge clk_fast, negedge rst_fast_n)
      begin
        if(~rst_fast_n)
        begin
          gal_div_cntr              <=  0;
          clk_logic_gal_div_valid   <=  0;
        end
        else
        begin
          if(clk_logic_gal_valid)
          begin
            gal_div_cntr            <=  (gal_div_cntr ==  GAL_FREQ_DIV-1) ? 0 : gal_div_cntr  + 1'b1;
            clk_logic_gal_div_valid <=  (gal_div_cntr ==  GAL_FREQ_DIV-1) ? 1'b1  : 1'b0;
          end
          else
          begin
            gal_div_cntr            <=  gal_div_cntr;
            clk_logic_gal_div_valid <=  0;
          end
        end
      end
    end
    else
    begin
      assign  gal_div_cntr            = 0;
      assign  clk_logic_gal_div_valid = clk_logic_gal_valid;
    end
  endgenerate

  /*  Synchronize the GAL point valid pulse to each logic clock domain  */
  generate
    for(i=0;i<NUM_CLOCKS;i++)
    begin : gen_clk_logic_valid_sync
      IW_async_pulses #(
        .WIDTH (2)

      ) u_IW_async_pulses (

         .clk_src     (clk_fast)
        ,.rst_src_n   (rst_fast_n)
        ,.data        (clk_logic_gal_div_valid)

        ,.clk_dst     (clk_logic_vec[i])
        ,.rst_dst_n   (rst_logic_vec_n[i])
        ,.data_sync   (clk_logic_gal_valid_sync[i])
      );
    end
  endgenerate

  /*  Calculate the GAL period foreach clock-logic domain & generate usync  */
  generate
    for(i=0;i<NUM_CLOCKS;i++)
    begin : gen_gal_cntr_usync
      always@(posedge clk_logic_vec[i], negedge rst_logic_vec_n[i])
      begin
        if(~rst_logic_vec_n[i])
        begin
          clk_logic_gal_cntr[i]         <=  0;
          clk_logic_gal_start_val[i]    <=  {GAL_CNTR_W{1'b1}};

          usync_vec_int[i]              <=  0;
        end
        else
        begin
          if(clk_logic_gal_valid_sync[i])
          begin
            clk_logic_gal_start_val[i]  <=  clk_logic_gal_cntr[i] - GAL_START_OFFSET;
            clk_logic_gal_cntr[i]       <=  0;
          end
          else
          begin
            if (clk_en | (i!=GAL_LOGIC_TAP))
              clk_logic_gal_cntr[i]       <=  clk_logic_gal_cntr[i] + 1'b1;
          end
          if (clk_en | (i!=GAL_LOGIC_TAP))
            usync_vec_int[i]              <= (clk_logic_gal_cntr[i]  ==  clk_logic_gal_start_val[i]) ? 1'b1  : 1'b0;
        end
      end

      assign  usync_vec[i]    = usync_vec_int[i];
    end //gen_gal_cntr_usync
  endgenerate

endmodule // IW_fpga_usync_gen
