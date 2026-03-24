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
 -- Module Name       : IW_fpga_serdes_control
 -- Author            : Gregory James
 -- Associated modules: 
 -- Function          : This wrapper assembles the serdes control bus
 --------------------------------------------------------------------------
*/

`timescale 1ns / 10ps


module IW_fpga_serdes_control #(
   parameter  SERDES_ENABLE_ALIGN_CNT = 2**17 //Number of clk_logic cyles after sync_lock before enabling align
  ,parameter  CLK_LOGIC_DIV_VALUE     = 1
  ,parameter  SERDES_CNTRL_W          = 32

) (
   input  wire                        clk_logic
  ,input  wire                        clk_logic_sync_done
  ,input  wire                        clk_local_fast
  ,input  wire                        cal_clk
  ,input  wire                        reconfig_clk
  ,input  wire                        rst_serdes_mux_demux_n

  ,output wire  [SERDES_CNTRL_W-1:0]  serdes_control

);

//----------------------- Import Packages ---------------------------------


//----------------------- Internal Parameters -----------------------------
  localparam  SERDES_ENABLE_ALIGN_CNTR_W      = $clog2(SERDES_ENABLE_ALIGN_CNT) + 1;


//----------------------- Internal Register Declarations ------------------
  reg   [SERDES_ENABLE_ALIGN_CNTR_W-1:0]  serdes_enable_align_cntr;
  reg                                     serdes_enable_align;


//----------------------- Internal Wire Declarations ----------------------
  wire                                    rst_logic_n;
  wire                                    clk_derive_sig;
  logic                                   clk_logic_derive_local;
  logic                                   en;


//----------------------- Start of Code -----------------------------------

  IW_sync_reset   u_sync_rst_logic_n  (.clk(clk_logic),.rst_n(clk_logic_sync_done),.rst_n_sync(rst_logic_n));

  always@(posedge clk_logic,  negedge rst_logic_n)
  begin
    if(~rst_logic_n)
    begin
      serdes_enable_align_cntr    <=  0;
      serdes_enable_align         <=  0;
    end
    else
    begin
      serdes_enable_align_cntr    <=  (serdes_enable_align_cntr ==  SERDES_ENABLE_ALIGN_CNT-1)  ? serdes_enable_align_cntr
                                                                                                : serdes_enable_align_cntr  + 1'b1;

      serdes_enable_align         <=  (serdes_enable_align_cntr ==  SERDES_ENABLE_ALIGN_CNT-1)  ? 1'b1  : 1'b0;
    end
  end

  // logic to generate clock derivatives when a single clock is used and divider dop is used  to divide down logic clock inside design
  // this needs the serdes base clock to be same derivative and that is achieved through CLK_LOGIC_DIV_VALUE value
  generate
    if ((CLK_LOGIC_DIV_VALUE == 0) || (CLK_LOGIC_DIV_VALUE == 1)) // div1 is a buffer
    begin : nodiv
      assign clk_logic_derive_local = clk_derive_sig;

      IW_fpga_clk_derive  u_IW_fpga_clk_derive
      (
          .clk_in         (clk_logic)
         ,.rst_in_n       (rst_logic_n)
         ,.clk_derive_out (clk_derive_sig)
         ,.clk_derive_inv_out ( )
      );

    end
    else // divider is needed
    begin : div

     localparam DIVBITS = $clog2(CLK_LOGIC_DIV_VALUE);
     logic [DIVBITS-1:0]        cnt;

     //Counter
     always_ff @(posedge clk_logic or negedge rst_serdes_mux_demux_n)
     begin
      if (~rst_serdes_mux_demux_n)
       cnt <= 0;
      else if (cnt == CLK_LOGIC_DIV_VALUE-1)
       cnt <= 0;
      else
       cnt <= cnt + 1;
     end

     //Clock Enable generation from counter
     always_ff @(posedge clk_logic or negedge rst_serdes_mux_demux_n)
     begin
      if (~rst_serdes_mux_demux_n)
        en  <= 1'b0;
      else
        en <= (cnt == CLK_LOGIC_DIV_VALUE-1) ;
     end


     // for clkdiv_50p_dc
     if (CLK_LOGIC_DIV_VALUE % 2 == 0) begin: even
         always_ff @(posedge clk_logic or negedge rst_serdes_mux_demux_n)
             if ( ~rst_serdes_mux_demux_n ) clk_logic_derive_local <= 1'b0;
             else clk_logic_derive_local <= (cnt == (CLK_LOGIC_DIV_VALUE/2)) ? 1'b0 : (clk_logic_derive_local | en);
     end else begin: odd
           logic en_even_r, en_even_l;
           always_ff @(posedge clk_logic or negedge rst_serdes_mux_demux_n)
             if ( ~rst_serdes_mux_demux_n ) en_even_r <= 1'b0;
             else en_even_r <= (cnt == (CLK_LOGIC_DIV_VALUE/2)) ? 1'b0 : (en_even_r | en);

           always_ff @(negedge clk_logic) en_even_l <= en_even_r;
           assign clk_logic_derive_local = en_even_r | en_even_l;
      end

    end
  endgenerate
   

  assign  serdes_control[SERDES_CNTRL_W-1]              = clk_logic_derive_local;
  assign  serdes_control[SERDES_CNTRL_W-2:7]            = {(SERDES_CNTRL_W-8){1'b0}};
  assign  serdes_control[6]                             = serdes_enable_align;
  assign  serdes_control[5]                             = 1'b1;
  assign  serdes_control[4]                             = rst_serdes_mux_demux_n;
  assign  serdes_control[3]                             = reconfig_clk;
  assign  serdes_control[2]                             = cal_clk;
  assign  serdes_control[1]                             = clk_local_fast;
  assign  serdes_control[0]                             = clk_logic;



endmodule // IW_fpga_serdes_control
