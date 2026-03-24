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

`include "onpi100g_jem_mon.vh"

module IW_fpga_onpi100g_mon #(
    parameter MON_TYPE            = "onpi"
  , parameter INSTANCE_NAME       = "u_onpi_mon"                 //Can hold upto 16 ASCII characters
  , parameter MODE                = "avl"                        //Either 'standalone' or 'avl' mode
  , parameter ONPI_SPEED          = "25G"

  /*  Do Not Modify */

  , parameter JEM_RECORD_WIDTH    = $bits(onpi100g_xctn_t)  //Width of the struct captured from JEM tracker
  , parameter AV_MM_DATA_W        = 32
  , parameter AV_MM_ADDR_W        = 16

  , parameter READ_MISS_VAL       = 32'hDEADBABE          // Read miss value
) (

  /*  CSR Interface */
    input   logic                       clk_csr
  , input   logic                       rst_csr_n,

    input   wire  [AV_MM_ADDR_W-1:0]     avl_mm_address,          // avl_mm.address
    output  reg   [AV_MM_DATA_W-1:0]     avl_mm_readdata,         //       .readdata
    input   wire                         avl_mm_read,             //       .read
    output  reg                          avl_mm_readdatavalid,    //       .readdatavalid
    input   wire                         avl_mm_write,            //       .write
    input   wire  [AV_MM_DATA_W-1:0]     avl_mm_writedata,        //       .writedata
    input   wire  [(AV_MM_DATA_W/8)-1:0] avl_mm_byteenable,       //       .byteenable
    output  wire                         avl_mm_waitrequest       //       .waitrequest

  /*  Logic Interface */
  , input    logic                        clk_logic
  , input    logic                        rst_logic_n
  , input    logic [31:0]                 data0
  , input    logic [31:0]                 data1
  , input    logic [31:0]                 data2
  , input    logic [31:0]                 data3
  , input    logic [3:0]                  ctl0
  , input    logic [3:0]                  ctl1
  , input    logic [3:0]                  ctl2
  , input    logic [3:0]                  ctl3
  , input    logic [7:0]                  mdata0
  , input    logic [7:0]                  mdata1
  , input    logic [7:0]                  mdata2
  , input    logic [7:0]                  mdata3
  , input    logic [7:0]                  mdata4
  , input    logic [7:0]                  mdata5
  , input    logic [7:0]                  mdata6
  , input    logic [7:0]                  mdata7
  , input    logic                        msdata
  , input    logic                        linkup
  , input    logic                        lp_linkup
  , input    logic [7:0]                  speed
  , input    logic [7:0]                  xoff

  /* CAP Interface  */
  , output logic                            cap_rdata_valid
  , output logic  [JEM_RECORD_WIDTH-1:0]    cap_rdata
  , input  logic                            cap_rden

);

  /*  Internal Parameters */
  localparam  JEM_TRACKER_BUFFER_SIZE = 75;  //Should match with 
  localparam  CAP_FF_DATA_W           = JEM_RECORD_WIDTH%32?((JEM_RECORD_WIDTH/32)+1)*32:((JEM_RECORD_WIDTH/32))*32;
  localparam  CAP_FF_DEPTH            = 512;
  localparam  CAP_FF_USED_W           = 10;

  //import onpi100g_jem_pkg::*;

  /*  wire/reg  */
  wire                            mon_enable;
  wire  [JEM_RECORD_WIDTH-1:0]    mask_en;
  wire  [JEM_RECORD_WIDTH-1:0]    mask_value;

  wire  [JEM_RECORD_WIDTH-1:0]    mon_data;
  wire                            mon_data_valid;

  wire  [JEM_RECORD_WIDTH-1:0]    filt_data;
  wire                            filt_data_valid;
  wire                            filt_bp;

  wire                        cap_ff_wrclk;
  wire                        cap_ff_full;
  wire                        cap_ff_wren;
  wire  [CAP_FF_DATA_W-1:0]   cap_ff_wdata;
  wire  [CAP_FF_USED_W-1:0]   cap_ff_wrused;
  wire                        cap_ff_rdclk;
  wire                        cap_ff_rst_n;
  wire                        cap_ff_empty;
  wire                        cap_ff_rden;
  wire  [CAP_FF_DATA_W-1:0]   cap_ff_rdata;
  wire  [CAP_FF_USED_W-1:0]   cap_ff_rdused;


  wire                        csr_cap_rdata_valid;
  wire  [CAP_FF_DATA_W-1:0]   csr_cap_rdata;
  wire  [CAP_FF_USED_W-1:0]   csr_cap_rdused;
  wire                        csr_cap_rden;

  wire                        clr_stats;
  wire                        flush_cap_ff;
  wire                        rec_ordering_en;
  wire  [31:0]                num_pkts;
  wire  [31:0]                num_beats;
  wire  [31:0]                num_dropped_pkts;
  wire  [63:0]                testing_param1;
  wire  [7:0]                 testing_param2;

assign testing_param1 = D64_LPI;
assign testing_param2 = C8_T2;

IW_fpga_onpi100g_mon_addr_map_avmm_wrapper #(
     .MON_TYPE                (MON_TYPE)
    ,.INSTANCE_NAME           (INSTANCE_NAME)
    ,.MODE                    (MODE)
    ,.ONPI_SPEED              (ONPI_SPEED)
    ,.CAP_RECORD_W            (JEM_RECORD_WIDTH)
    ,.CAP_FF_DATA_W           (CAP_FF_DATA_W)
    ,.CAP_FF_DEPTH            (CAP_FF_DEPTH)
    ,.CAP_FF_USED_W           (CAP_FF_USED_W)

    ,.AV_MM_DATA_W            (AV_MM_DATA_W)
    ,.AV_MM_ADDR_W            (AV_MM_ADDR_W)    

    ,.READ_MISS_VAL           (READ_MISS_VAL)
) u_csr (

     .avl_mm_address          (avl_mm_address)
    ,.avl_mm_readdata         (avl_mm_readdata)
    ,.avl_mm_read             (avl_mm_read)
    ,.avl_mm_readdatavalid    (avl_mm_readdatavalid)
    ,.avl_mm_write            (avl_mm_write)
    ,.avl_mm_writedata        (avl_mm_writedata)
    ,.avl_mm_byteenable       (avl_mm_byteenable)
    ,.avl_mm_waitrequest      (avl_mm_waitrequest)
    ,.csi_clk                 (clk_csr)
    ,.rsi_reset               (~rst_logic_n)
    ,.clk_logic               (clk_logic)

    ,.cap_rdata_valid         (csr_cap_rdata_valid)
    ,.cap_rdata               (csr_cap_rdata)
    ,.cap_rdused              (csr_cap_rdused)
    ,.cap_rden                (csr_cap_rden)

    ,.data0                   (data0)
    ,.data1                   (data1)
    ,.data2                   (data2)
    ,.data3                   (data3)
    ,.ctl0                    (ctl0)
    ,.ctl1                    (ctl1)
    ,.ctl2                    (ctl2)
    ,.ctl3                    (ctl3)
    ,.mdata0                  (mdata0)
    ,.mdata1                  (mdata1)
    ,.mdata2                  (mdata2)
    ,.mdata3                  (mdata3)
    ,.mdata4                  (mdata4)
    ,.mdata5                  (mdata5)
    ,.mdata6                  (mdata6)
    ,.mdata7                  (mdata7)
    ,.msdata                  (msdata)
    ,.linkup                  (linkup)
    ,.lp_linkup               (lp_linkup)
    ,.speed                   (speed)
    ,.xoff                    (xoff)

    ,.num_pkts                (num_pkts                )
    ,.num_beats               (num_beats               )
    ,.num_dropped_pkts        (num_dropped_pkts        )

    ,.mon_enable              (mon_enable              )
    ,.clr_stats               (clr_stats               )
    ,.flush_cap_ff            (flush_cap_ff            )
    ,.rec_ordering_en         (rec_ordering_en         )
    ,.onpi_mask_en            (mask_en                 )
    ,.onpi_mask_value         (mask_value              )

);

  /* Statistics Instance  */
  IW_fpga_onpi100g_mon_stats u_stats
  (
     .clk_logic               (clk_logic)
    ,.rst_logic_n             (rst_logic_n)
    ,.data                    ()
    ,.ctl                     ()
    ,.onpi_data               (mon_data)
    ,.clr_stats               (clr_stats)
    ,.mon_data_valid          (mon_data_valid)
    ,.filt_bp                 (filt_bp)

    ,.num_pkts                (num_pkts)
    ,.num_beats               (num_beats)
    ,.num_dropped_pkts        (num_dropped_pkts)
 
  );
    
  /* jem tracker instance */
  onpi100g_jem_mon #(
  ) u_onpi100g_jem_mon(
    .clk                      (clk_logic)
   ,.data0                    (data0)
   ,.data1                    (data1)
   ,.data2                    (data2)
   ,.data3                    (data3)
   ,.ctl0                     (ctl0)
   ,.ctl1                     (ctl1)
   ,.ctl2                     (ctl2)
   ,.ctl3                     (ctl3)
   ,.mdata0                   (mdata0)
   ,.mdata1                   (mdata1)
   ,.mdata2                   (mdata2)
   ,.mdata3                   (mdata3)
   ,.mdata4                   (mdata4)
   ,.mdata5                   (mdata5)
   ,.mdata6                   (mdata6)
   ,.mdata7                   (mdata7)
   ,.msdata                   (msdata)
   ,.linkup                   (linkup)
   ,.lp_linkup                (lp_linkup)
   ,.speed                    (speed)
   ,.xoff                     (xoff)

   ,.onpi_data                (mon_data)
   ,.onpi_data_valid          (mon_data_valid)
);

  /* filter instance */
  IW_fpga_generic_filt #(
   .DATA_WIDTH  (JEM_RECORD_WIDTH),
   .USE_FLOP    (0)
  ) u_filter (
    .clk                  (clk_logic),
    .rst_n                (rst_logic_n),

    //jem tracker signals
    .mon_data             (mon_data),
    .mon_data_valid       (mon_data_valid),

    //csr signals
    .enable               (mon_enable),
    .match_mask           (mask_en),
    .match_data           (mask_value),

    //fifo interface
    .filt_data            (filt_data),
    .filt_data_valid      (filt_data_valid),
    .filt_bp              (filt_bp)

  );

  assign  cap_ff_wdata   = {{(CAP_FF_DATA_W-JEM_RECORD_WIDTH){1'b0}},filt_data};
  assign  cap_ff_wren    = filt_data_valid;
  assign  filt_bp        = cap_ff_full;

  /* capture fifo */
  //IW_fpga_onpi100g_mon_ff_256x512 u_cap_ff
  IW_fpga_async_fifo #(
    .ADDR_WD (9),
    .DATA_WD (256) ) u_cap_ff 
  (
    .rstn                         (cap_ff_rst_n),
    .data                         (cap_ff_wdata),
    .rdclk                        (cap_ff_rdclk),
    .rdreq                        (cap_ff_rden),
    .wrclk                        (cap_ff_wrclk),
    .wrreq                        (cap_ff_wren),
    .q                            (cap_ff_rdata),
    .rdempty                      (cap_ff_empty),
    .rdusedw                      (cap_ff_rdused),
    .wrfull                       (cap_ff_full),
    .wrusedw                      (cap_ff_wrused)
  );

  generate
    if(MODE ==  "avl")
    begin

      //CAP FF Read ports are accessed by external AVL; CSR equivalent ports & tied off
      assign  cap_ff_wrclk = clk_logic;
      assign  cap_ff_rdclk = clk_csr;
      assign  cap_ff_rst_n = rst_csr_n & ~flush_cap_ff;

      assign  cap_rdata_valid  = ~cap_ff_empty;
      assign  cap_rdata        = cap_ff_rdata[JEM_RECORD_WIDTH-1:0];
      assign  cap_ff_rden      = cap_rden;

      assign  csr_cap_rdata_valid    = 1'b0;
      assign  csr_cap_rdata          = {CAP_FF_DATA_W{1'b0}};
      assign  csr_cap_rdused         = {CAP_FF_USED_W{1'b0}};
    end
    else  //MODE  ==  "standalone"
    begin


      //CAP FF Read ports are accessed by CSR; AVL equivalent ports are tied off
      assign  cap_ff_wrclk = clk_logic;
      assign  cap_ff_rdclk = clk_logic;
      assign  cap_ff_rst_n = rst_csr_n & ~flush_cap_ff;

      assign  csr_cap_rdata_valid    = ~cap_ff_empty;
      assign  csr_cap_rdata          = cap_ff_rdata;
      assign  csr_cap_rdused         = cap_ff_rdused;
      assign  cap_ff_rden            = csr_cap_rden;

      assign  cap_rdata_valid  = 1'b0;
      assign  cap_rdata        = {JEM_RECORD_WIDTH{1'b0}};
    end
  endgenerate


endmodule //IW_fpga_onpi100g_mon



