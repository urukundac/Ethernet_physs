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
 -- Module Name       : IW_fpga_gal_sync
 -- Author            : Gregory James
 -- Associated modules: 
 -- Function          : This module is used to align a local reference clock
                        to the global-align edge from an upstream master.
 --------------------------------------------------------------------------
*/

`timescale 1ns / 10ps


module IW_fpga_gal_sync #(
    parameter FPGA_FAMILY                 = "S5"

  , parameter NUM_CLOCKS                  = 1
  , parameter USYNC_GAL_OFFSET            = 3 //Number of cycles before GAL point to generate usync pulse
  , parameter EDGE_DET_CNTR_W             = 8
  , parameter GAL_CNTR_W                  = 16
  , parameter GAL_FREQ_DIV                = 1
  , parameter GAL_LOGIC_TAP               = 0 //Which logic clock to run GAL counter mux/demux
  , parameter USYNC_SKIP_CNT              = 3 //Number of usync pulses to skip after reset
  , parameter GAL_SYNC_START_TIMEOUT      = 128   //Maximum number of continuos zero counts received

  , parameter GAL_SYN_MASTER              = 1
  , parameter GAL_CNT_IN_BUFFER           = 0 //1->Use demux on line GAL_SYNC_CNT_IN_IO,  0->No demux on line GAL_SYNC_CNT_IN_IO
  , parameter GAL_CNT_OUT_BUFFER          = 0 //1->Use mux on line GAL_SYNC_CNT_OUT_IO,  0->No mux on line GAL_SYNC_CNT_OUT_IO
  , parameter GAL_CNT_OUT_WIDTH           = 1 //Width of GAL_SYNC_CNT_OUT_IO. Clock count sync out will be replicated on each pin
  , parameter GAL_CNT_IN_MUX_RATIO        = 6
  , parameter GAL_CNT_IN_CLK_RATIO        = 4
  , parameter GAL_CNT_OUT_MUX_RATIO       = 6
  , parameter GAL_CNT_OUT_CLK_RATIO       = 4
  , parameter CLK_LOGIC_DIV_VALUE         = 1 // GAL window redefined using a subset of divider value of clock GAL_LOGIC_TAP

) (

  //Fast clock
    input   logic                         clk_fast
  , input   logic                         rst_fast_n

  //Logic Clocks
  , input   logic [NUM_CLOCKS-1:0]        clk_logic_vec
  , input   logic [NUM_CLOCKS-1:0]        rst_logic_vec_n
  , output  logic                         clk_en

  //Mux-Demux clock, reset
  , input   logic                         clk_in_mux_demux
  , input   logic                         rst_in_mux_demux_n

  , input   logic                         clk_out_mux_demux
  , input   logic                         rst_out_mux_demux_n

  , inout   wire                          GAL_SYNC_CNT_IN_IO
  , inout   wire  [GAL_CNT_OUT_WIDTH-1:0] GAL_SYNC_CNT_OUT_IO

  //Control/Status
  , output  logic                         gal_sync_mismatch
  , output  logic                         gal_sync_stable
  , output  logic                         gal_sync_start_timeout
  , input   logic                         gal_sync_complete

  //Usync
  , output  logic [NUM_CLOCKS-1:0]        usync_vec
  , output  logic [GAL_CNTR_W-1:0]        out_clk_logic_gal_cntr

);

//----------------------- Import Packages ---------------------------------


//----------------------- Internal Parameters -----------------------------
  localparam  USYNC_SKIP_CNTR_W             = $clog2(USYNC_SKIP_CNT)  + 1;
  localparam  GAL_SYNC_START_TIMEOUT_CNTR_W = $clog2(GAL_SYNC_START_TIMEOUT)  + 1;
  localparam  GAL_SYNC_CNT_IN_REMAINDER     = (GAL_CNT_IN_MUX_RATIO-1)  % GAL_CNTR_W;
  localparam  GAL_SYNC_CNT_IN_NUM_SLICES    = (GAL_SYNC_CNT_IN_REMAINDER != 0) ? ((GAL_CNT_IN_MUX_RATIO-1) / GAL_CNTR_W) + 1
                                                                               : (GAL_CNT_IN_MUX_RATIO-1)  / GAL_CNTR_W;
  localparam  GAL_SYNC_CNT_OUT_REMAINDER     = (GAL_CNT_OUT_MUX_RATIO-1)  % GAL_CNTR_W;
  localparam  GAL_SYNC_CNT_OUT_NUM_SLICES    = ( GAL_SYNC_CNT_OUT_REMAINDER != 0 ) ? ((GAL_CNT_OUT_MUX_RATIO-1) / GAL_CNTR_W) + 1
                                                                                   : (GAL_CNT_OUT_MUX_RATIO-1)  / GAL_CNTR_W;


//----------------------- Internal Register Declarations ------------------
  genvar  i;
  logic [USYNC_SKIP_CNTR_W-1:0]   usync_skip_cntr;
  logic                           usync_ready_f;

  logic [GAL_CNT_IN_MUX_RATIO-1:0]    gal_sync_cnt_in_1d;

  logic [GAL_CNTR_W-1:0]          gal_sync_cnt_out;

//----------------------- Internal Wire Declarations ----------------------
  logic                               clk_gal_logic;
  logic                               rst_gal_logic_n;
  logic                               usync_gal_logic;
  logic [GAL_CNTR_W-1:0]              usync_gal_logic_cnt;
  logic [GAL_CNTR_W-1:0]              usync_gal_logic_cnt_1d;
  logic [GAL_CNTR_W-1:0]              usync_gal_logic_cnt_p1;

  logic                               usync_ready;

  logic [GAL_CNT_IN_MUX_RATIO-1:0]    gal_sync_cnt_in_demux;
  logic [GAL_CNT_IN_MUX_RATIO-1:0]    gal_sync_cnt_in_delayed;
  logic [GAL_CNT_IN_MUX_RATIO-1:0]    gal_sync_cnt_in_expected;

  logic [NUM_CLOCKS-1:0] [GAL_CNTR_W-1:0] clk_logic_gal_cntr;
  logic [NUM_CLOCKS-1:0] [GAL_CNTR_W-1:0] clk_logic_gal_start_val;

  logic [GAL_SYNC_START_TIMEOUT_CNTR_W-1:0] gal_sync_start_timeout_cntr;

  logic [GAL_CNT_OUT_MUX_RATIO-1:0]   gal_sync_cnt_out_mux;

  logic                               gal_sync_complete_sync;


//----------------------- Start of Code -----------------------------------


  /*  Instantiate GAL detection module  */
  IW_fpga_usync_gen #(
     .NUM_CLOCKS        (NUM_CLOCKS)
    ,.USYNC_GAL_OFFSET  (USYNC_GAL_OFFSET)
    ,.GAL_LOGIC_TAP     (GAL_LOGIC_TAP)
    ,.EDGE_DET_CNTR_W   (EDGE_DET_CNTR_W)
    ,.GAL_CNTR_W        (GAL_CNTR_W)
    ,.GAL_FREQ_DIV      (GAL_FREQ_DIV)
    ,.CLK_LOGIC_DIV_VALUE(CLK_LOGIC_DIV_VALUE)

  ) u_IW_fpga_usync_gen (

     .clk_fast                (clk_fast)
    ,.rst_fast_n              (rst_fast_n)

    ,.clk_logic_vec           (clk_logic_vec)
    ,.rst_logic_vec_n         (rst_logic_vec_n)
    ,.clk_en                  (clk_en)

    ,.usync_vec               (usync_vec)

    ,.clk_logic_gal_cntr      (clk_logic_gal_cntr)
    ,.clk_logic_gal_start_val (clk_logic_gal_start_val)

  );	
	assign  out_clk_logic_gal_cntr  = clk_logic_gal_cntr[GAL_LOGIC_TAP];
  //Extract the logic clock to run GAL mux/demux
  assign  clk_gal_logic       = clk_logic_vec[GAL_LOGIC_TAP];
  assign  rst_gal_logic_n     = rst_logic_vec_n[GAL_LOGIC_TAP];
  assign  usync_gal_logic     = usync_vec[GAL_LOGIC_TAP];
  assign  usync_gal_logic_cnt = clk_logic_gal_cntr[GAL_LOGIC_TAP];

  /*  Usync skip logic  */
  always@(posedge clk_gal_logic,  negedge rst_gal_logic_n)
  begin
    if(~rst_gal_logic_n)
    begin
      usync_skip_cntr         <=  0;
      usync_ready_f           <=  0;
      usync_gal_logic_cnt_p1  <=  0;
      usync_gal_logic_cnt_1d  <=  0;
    end
    else
    begin
      if ( clk_en ) begin
        usync_skip_cntr         <=  usync_ready ? usync_skip_cntr : usync_skip_cntr + usync_gal_logic;
        usync_ready_f           <=  usync_ready;
        usync_gal_logic_cnt_1d  <=  usync_gal_logic_cnt;
        usync_gal_logic_cnt_p1  <=  usync_gal_logic_cnt_1d + 1'b1;
      end
    end
  end

  //Check if sufficient usync pulses have been skipped
  assign  usync_ready = (usync_skip_cntr  >=  USYNC_SKIP_CNT) ? 1'b1  : 1'b0;


  /*  GAL Count Input Logic  */
  generate
    if(!GAL_SYN_MASTER)
    begin
      if(GAL_CNT_IN_BUFFER  ==  1)  //Demux the GAL count from line GAL_SYNC_CNT_IN_IO
      begin
        IW_fpga_demux_v2 #(
           .NUMBER_OF_INPUTS   (1)
          ,.MULTIPLEX_RATIO    (GAL_CNT_IN_MUX_RATIO)
          ,.CLOCK_RATIO        (GAL_CNT_IN_CLK_RATIO)
          ,.FPGA_FAMILY        (FPGA_FAMILY)
        ) IW_fpga_demux_gal_cnt_in  (
          .inbus              (GAL_SYNC_CNT_IN_IO),
          .clk_demux          (clk_in_mux_demux),
          .rst_demux_n        (rst_in_mux_demux_n),
          .outbus             (gal_sync_cnt_in_demux),
          .ecc_err            ()
        );

        `ifdef  FPGA_SIM
          assign  #1ps gal_sync_cnt_in_delayed = gal_sync_cnt_in_demux;
        `endif

        /*  Calculate the expected value of gal_sync_cnt_in */
        for(i=0;i<GAL_SYNC_CNT_IN_NUM_SLICES;i++)
        begin : gen_gal_sync_cnt_in_expected
          if(i==GAL_SYNC_CNT_IN_NUM_SLICES-1 && GAL_SYNC_CNT_IN_REMAINDER != 0)
          begin
            assign  gal_sync_cnt_in_expected[(i*GAL_CNTR_W) +: GAL_SYNC_CNT_IN_REMAINDER]  = usync_gal_logic_cnt_p1[GAL_SYNC_CNT_IN_REMAINDER-1:0];
          end
          else
          begin
            assign  gal_sync_cnt_in_expected[(i*GAL_CNTR_W) +: GAL_CNTR_W] = usync_gal_logic_cnt_p1;
          end
        end

        assign  gal_sync_cnt_in_expected[GAL_CNT_IN_MUX_RATIO-1]  = ~gal_sync_cnt_in_expected[GAL_CNT_IN_MUX_RATIO-2];


        /*  GAL Count Check Logic */
        always@(posedge clk_gal_logic,  negedge rst_gal_logic_n)
        begin
          if(~rst_gal_logic_n)
          begin
            gal_sync_cnt_in_1d            <=  0;
            gal_sync_start_timeout_cntr   <=  0;

            gal_sync_mismatch             <=  0;
            gal_sync_stable               <=  0;
            gal_sync_start_timeout        <=  0;
          end
          else
          begin
            if ( clk_en ) begin
            `ifdef  FPGA_SIM
              gal_sync_cnt_in_1d          <=  gal_sync_cnt_in_delayed;
            `else
              gal_sync_cnt_in_1d          <=  gal_sync_cnt_in_demux;
            `endif

              if(usync_ready)
              begin
                gal_sync_mismatch           <=  (gal_sync_cnt_in_1d !=  gal_sync_cnt_in_expected)  ? usync_gal_logic : 1'b0;
                gal_sync_stable             <=  (gal_sync_cnt_in_1d ==  gal_sync_cnt_in_expected)  ? usync_gal_logic : 1'b0;
                gal_sync_start_timeout      <=  (gal_sync_start_timeout_cntr  >=  GAL_SYNC_START_TIMEOUT) ? 1'b1  : 1'b0;

                if(gal_sync_start_timeout)
                begin
                  gal_sync_start_timeout_cntr <=  (gal_sync_cnt_in_1d[GAL_CNTR_W-1:0] ==  0)  ? gal_sync_start_timeout_cntr : 0;
                end
                else
                begin
                  gal_sync_start_timeout_cntr <=  (gal_sync_cnt_in_1d[GAL_CNTR_W-1:0] ==  0)  ? gal_sync_start_timeout_cntr + 1'b1  : 0;
                end
              end
            end
          end
        end
      end
      else  //No demux
      begin
        assign  gal_sync_cnt_in_demux         = {GAL_CNT_IN_MUX_RATIO{1'b0}};
        assign  gal_sync_cnt_in_delayed       = {GAL_CNT_IN_MUX_RATIO{1'b0}};
        assign  gal_sync_cnt_in_expected      = {GAL_CNT_IN_MUX_RATIO{1'b0}};
        assign  gal_sync_start_timeout_cntr   = {GAL_SYNC_START_TIMEOUT_CNTR_W{1'b0}};

        assign  gal_sync_mismatch       = 1'b0;
        assign  gal_sync_stable         = 1'b0;
        assign  gal_sync_start_timeout  = 1'b0;

//        IOBUF_w_pullup  iobuf_gal_sync_in_io  (.O(),.T(1'b1),.I(1'b0),.IO(GAL_SYNC_CNT_IN_IO)); //Tieoff IOs
      end
    end
    else
    begin
      assign  gal_sync_mismatch             = 1'b0;
      assign  gal_sync_stable               = usync_ready_f;
      assign  gal_sync_start_timeout        = 1'b0;
      assign  gal_sync_start_timeout_cntr   = {GAL_SYNC_START_TIMEOUT_CNTR_W{1'b0}};

//      IOBUF_w_pullup  iobuf_gal_sync_in_io  (.O(),.T(1'b1),.I(1'b0),.IO(GAL_SYNC_CNT_IN_IO)); //Tieoff IOs
    end
  endgenerate


  /*  GAL Count Output Logic  */
  IW_fpga_double_sync#(.WIDTH(1),.NUM_STAGES(2))  u_IW_fpga_double_sync_gal_sync_complete (.clk(clk_gal_logic),.sig_in(gal_sync_complete),.sig_out(gal_sync_complete_sync));

  generate
    if(GAL_CNT_OUT_BUFFER ==  1)
    begin
      always@(posedge clk_gal_logic,  negedge rst_gal_logic_n)
      begin
        if(~rst_gal_logic_n)
        begin
          gal_sync_cnt_out      <=  0;
        end
        else
        begin
          if ( clk_en ) begin
            gal_sync_cnt_out      <=  gal_sync_complete_sync  ? usync_gal_logic_cnt + 1'b1  : 0;
          end
        end
      end

      for(i=0;i<GAL_SYNC_CNT_OUT_NUM_SLICES;i++)
      begin : gen_gal_sync_cnt_out_mux
        if(i==GAL_SYNC_CNT_OUT_NUM_SLICES-1 && GAL_SYNC_CNT_OUT_REMAINDER != 0)
        begin
          assign  gal_sync_cnt_out_mux[(i*GAL_CNTR_W) +: GAL_SYNC_CNT_OUT_REMAINDER]  = gal_sync_cnt_out[GAL_SYNC_CNT_OUT_REMAINDER-1:0];
        end
        else
        begin
          assign  gal_sync_cnt_out_mux[(i*GAL_CNTR_W) +: GAL_CNTR_W] = gal_sync_cnt_out;
        end
      end

      assign  gal_sync_cnt_out_mux[GAL_CNT_OUT_MUX_RATIO-1]  = gal_sync_complete_sync  ? ~gal_sync_cnt_out_mux[GAL_CNT_OUT_MUX_RATIO-2] : 1'b0;

      //Send the pattern to each IO line
      for(i=0;i<GAL_CNT_OUT_WIDTH;i++)
      begin : gen_gal_cnt_out
        IW_fpga_mux_v2 #(
           .NUMBER_OF_OUTPUTS   (1)
         , .MULTIPLEX_RATIO     (GAL_CNT_OUT_MUX_RATIO)
         , .CLOCK_RATIO         (GAL_CNT_OUT_CLK_RATIO)
         , .FPGA_FAMILY         (FPGA_FAMILY)
         )  u_IW_fpga_mux_gal_cnt_out (
          .outbus         (GAL_SYNC_CNT_OUT_IO[i]),
          .clk_mux        (clk_out_mux_demux),
          .rst_mux_n      (rst_out_mux_demux_n),
          .inbus          (gal_sync_cnt_out_mux)
        );
      end
    end
    else
    begin
      assign  gal_sync_cnt_out      = {GAL_CNTR_W{1'b0}};
      assign  gal_sync_cnt_out_mux  = {GAL_CNT_OUT_MUX_RATIO{1'b0}};

      for(i=0;i<GAL_CNT_OUT_WIDTH;i++)
      begin : gen_gal_cnt_out_tieoff
        IOBUF_w_pullup  iobuf_gal_sync_out_io  (.O(),.T(1'b1),.I(1'b0),.IO(GAL_SYNC_CNT_OUT_IO[i])); //Tieoff IOs
      end
    end
  endgenerate


endmodule // IW_fpga_gal_sync
