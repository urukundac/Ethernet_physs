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
`include "iosf_sb_jem_tracker.vh"

module IW_fpga_iosf_sb_mon #(
    parameter MON_TYPE            = "sbr"                     //Should be either pmsb or gpsb
  , parameter INSTANCE_NAME       = "u_iosf_sb_mon"           //Can hold upto 16 ASCII characters
  , parameter PAYLOAD_WIDTH       = 8                         //Width of payload
  , parameter MODE                = "avl"                     //Either 'standalone' or 'avl' mode

  /*  Do Not Modify */
  , parameter RECORD_ID_WIDTH     = 32
  , parameter JEM_RECORD_WIDTH    = $bits(t_iosf_sb_jem_req)  //Width of the struct captured from JEM tracker
  , parameter CAP_RECORD_W        = JEM_RECORD_WIDTH  + RECORD_ID_WIDTH //Width of the final structure/record captured

  , parameter AV_MM_ADDR_W        = 8                     // Address width
  , parameter AV_MM_DATA_W        = 32                    // Data width
  , parameter READ_MISS_VAL       = 32'hDEADBABE          // Read miss value

  /*  Do not modify */
  , parameter NUM_CHANNELS_BIN  = $clog2(NUM_CAP_INTFS)

) (

  /*  CSR Interface */
    input   logic                      clk_csr
  , input   logic                      rst_csr_n

  , input  wire [AV_MM_ADDR_W-1:0]     avl_mm_address          // avl_mm.address
  , output reg  [AV_MM_DATA_W-1:0]     avl_mm_readdata         //       .readdata
  , input  wire                        avl_mm_read             //       .read
  , output reg                         avl_mm_readdatavalid    //       .readdatavalid
  , input  wire                        avl_mm_write            //       .write
  , input  wire [AV_MM_DATA_W-1:0]     avl_mm_writedata        //       .writedata
  , input  wire [(AV_MM_DATA_W/8)-1:0] avl_mm_byteenable       //       .byteenable
  , output wire                        avl_mm_waitrequest      //       .waitrequest

  /*  Logic Interface */
  , input  logic                        clk_logic
  , input  logic                        rst_logic_n

  , input  logic                        iosfsb_MNPPUT
  , input  logic                        iosfsb_MPCPUT
  , input  logic                        iosfsb_MNPCUP
  , input  logic                        iosfsb_MPCCUP
  , input  logic                        iosfsb_MEOM
  , input  logic  [PAYLOAD_WIDTH-1:0]   iosfsb_MPAYLOAD
  , input  logic                        iosfsb_TNPPUT
  , input  logic                        iosfsb_TPCPUT
  , input  logic                        iosfsb_TNPCUP
  , input  logic                        iosfsb_TPCCUP
  , input  logic                        iosfsb_TEOM
  , input  logic  [PAYLOAD_WIDTH-1:0]   iosfsb_TPAYLOAD
  , input  logic  [2:0]                 iosfsb_SIDE_ISM_AGENT
  , input  logic  [2:0]                 iosfsb_SIDE_ISM_FABRIC

  /*  TMSG Channel CAP Interface  */
  , output logic                        tmsg_chnnl_cap_rdata_valid
  , output logic  [CAP_RECORD_W-1:0]    tmsg_chnnl_cap_rdata

  /*  MMSG Channel CAP Interface  */
  , output logic                        mmsg_chnnl_cap_rdata_valid
  , output logic  [CAP_RECORD_W-1:0]    mmsg_chnnl_cap_rdata

  , input  logic                                cap_rden
  , output logic  [NUM_CHANNELS_BIN-1:0]        chnnl_egr_valid_bin


);

  /*  Internal Parameters */
  localparam  JEM_TRACKER_BUFFER_SIZE = 160;  //Should match with t_iosf_sb_jem_req.data
  localparam  CAP_FF_DATA_W           = 224;
  localparam  CAP_FF_DEPTH            = 512;
  localparam  CAP_FF_USED_W           = 10;

  localparam  NUM_CAP_INTFS           = 2;

  /*  wire/reg  */
  wire                            mon_enable;
  wire  [JEM_RECORD_WIDTH-1:0]    target_mask_en;
  wire  [JEM_RECORD_WIDTH-1:0]    target_mask_value;
  wire  [JEM_RECORD_WIDTH-1:0]    master_mask_en;
  wire  [JEM_RECORD_WIDTH-1:0]    master_mask_value;

  wire  [JEM_RECORD_WIDTH-1:0]    master_mon_data;
  wire  [JEM_RECORD_WIDTH-1:0]    target_mon_data;
  wire                            master_mon_data_valid;
  wire                            target_mon_data_valid;

  wire  [JEM_RECORD_WIDTH-1:0]    master_filt_data;
  wire                            master_filt_data_valid;
  wire                            master_filt_bp;

  wire  [JEM_RECORD_WIDTH-1:0]    target_filt_data;
  wire                            target_filt_data_valid;
  wire                            target_filt_bp;

  wire  [RECORD_ID_WIDTH-1:0] cap_rec_id  [NUM_CAP_INTFS-1:0];
  wire  [NUM_CAP_INTFS-1:0]   chnnl_egr_valid;

  wire                        master_cap_ff_wrclk;
  wire                        master_cap_ff_full;
  wire                        master_cap_ff_wren;
  wire  [CAP_FF_DATA_W-1:0]   master_cap_ff_wdata;
  wire  [CAP_FF_USED_W-1:0]   master_cap_ff_wrused;
  wire                        master_cap_ff_rdclk;
  wire                        master_cap_ff_empty;
  wire                        master_cap_ff_rden;
  wire  [CAP_FF_DATA_W-1:0]   master_cap_ff_rdata;
  wire  [CAP_FF_USED_W-1:0]   master_cap_ff_rdused;
  wire                        master_cap_ff_rst_n;

  wire                        target_cap_ff_wrclk;
  wire                        target_cap_ff_full;
  wire                        target_cap_ff_wren;
  wire  [CAP_FF_DATA_W-1:0]   target_cap_ff_wdata;
  wire  [CAP_FF_USED_W-1:0]   target_cap_ff_wrused;
  wire                        target_cap_ff_rdclk;
  wire                        target_cap_ff_rst_n;
  wire                        target_cap_ff_empty;
  wire                        target_cap_ff_rden;
  wire  [CAP_FF_DATA_W-1:0]   target_cap_ff_rdata;
  wire  [CAP_FF_USED_W-1:0]   target_cap_ff_rdused;

  wire                        csr_tmsg_cap_rdata_valid;
  wire  [CAP_FF_DATA_W-1:0]   csr_tmsg_cap_rdata;
  wire  [CAP_FF_USED_W-1:0]   csr_tmsg_cap_rdused;
  wire                        csr_tmsg_cap_rden;

  wire                        csr_mmsg_cap_rdata_valid;
  wire  [CAP_FF_DATA_W-1:0]   csr_mmsg_cap_rdata;
  wire  [CAP_FF_USED_W-1:0]   csr_mmsg_cap_rdused;
  wire                        csr_mmsg_cap_rden;

  wire                        clr_stats;
  wire                        flush_cap_ff;
  wire                        rec_ordering_en;
  wire  [15:0]                num_mmsg_np_pkts;
  wire  [15:0]                num_mmsg_pc_pkts;
  wire  [15:0]                num_mmsg_np_beats;
  wire  [15:0]                num_mmsg_pc_beats;
  wire  [15:0]                num_mmsg_dropped_pkts;
  wire  [15:0]                num_tmsg_np_pkts;
  wire  [15:0]                num_tmsg_pc_pkts;
  wire  [15:0]                num_tmsg_np_beats;
  wire  [15:0]                num_tmsg_pc_beats;
  wire  [15:0]                num_tmsg_dropped_pkts;

  /*  CSR Instance  */
  IW_fpga_iosf_sb_mon_addr_map_avmm_wrapper #(
     .MON_TYPE                (MON_TYPE)
    ,.INSTANCE_NAME           (INSTANCE_NAME)
    ,.PAYLOAD_WIDTH           (PAYLOAD_WIDTH)
    ,.MODE                    (MODE)
    ,.CAP_RECORD_W            (CAP_RECORD_W)
    ,.CAP_FF_DATA_W           (CAP_FF_DATA_W)
    ,.CAP_FF_DEPTH            (CAP_FF_DEPTH)
    ,.CAP_FF_USED_W           (CAP_FF_USED_W)
    ,.AV_MM_ADDR_W            (AV_MM_ADDR_W)
    ,.AV_MM_DATA_W            (AV_MM_DATA_W)
    ,.READ_MISS_VAL           (READ_MISS_VAL)
  ) u_csr (
     .csi_clk                 (clk_csr                 )
    ,.rsi_reset               (~rst_csr_n              )
    ,.avl_mm_address          (avl_mm_address          ) 
    ,.avl_mm_readdata         (avl_mm_readdata         )
    ,.avl_mm_read             (avl_mm_read             )
    ,.avl_mm_readdatavalid    (avl_mm_readdatavalid    )
    ,.avl_mm_write            (avl_mm_write            )
    ,.avl_mm_writedata        (avl_mm_writedata        )
    ,.avl_mm_byteenable       (avl_mm_byteenable       )
    ,.avl_mm_waitrequest      (avl_mm_waitrequest      )

    ,.clk_logic               (clk_logic               )
//    ,.rst_logic_n             (rst_logic_n             )

    ,.tmsg_cap_rdata_valid    (csr_tmsg_cap_rdata_valid)
    ,.tmsg_cap_rdata          (csr_tmsg_cap_rdata      )
    ,.tmsg_cap_rdused         (csr_tmsg_cap_rdused     )
    ,.tmsg_cap_rden           (csr_tmsg_cap_rden       )

    ,.mmsg_cap_rdata_valid    (csr_mmsg_cap_rdata_valid)
    ,.mmsg_cap_rdata          (csr_mmsg_cap_rdata      )
    ,.mmsg_cap_rdused         (csr_mmsg_cap_rdused     )
    ,.mmsg_cap_rden           (csr_mmsg_cap_rden       )

    ,.iosfsb_MNPPUT           (iosfsb_MNPPUT           )
    ,.iosfsb_MPCPUT           (iosfsb_MPCPUT           )
    ,.iosfsb_MNPCUP           (iosfsb_MNPCUP           )
    ,.iosfsb_MPCCUP           (iosfsb_MPCCUP           )
    ,.iosfsb_MEOM             (iosfsb_MEOM             )
    ,.iosfsb_MPAYLOAD         (iosfsb_MPAYLOAD         )
    ,.iosfsb_TNPPUT           (iosfsb_TNPPUT           )
    ,.iosfsb_TPCPUT           (iosfsb_TPCPUT           )
    ,.iosfsb_TNPCUP           (iosfsb_TNPCUP           )
    ,.iosfsb_TPCCUP           (iosfsb_TPCCUP           )
    ,.iosfsb_TEOM             (iosfsb_TEOM             )
    ,.iosfsb_TPAYLOAD         (iosfsb_TPAYLOAD         )
    ,.iosfsb_SIDE_ISM_AGENT   (iosfsb_SIDE_ISM_AGENT   )
    ,.iosfsb_SIDE_ISM_FABRIC  (iosfsb_SIDE_ISM_FABRIC  )

    ,.num_mmsg_np_pkts        (num_mmsg_np_pkts        )
    ,.num_mmsg_pc_pkts        (num_mmsg_pc_pkts        )
    ,.num_mmsg_np_beats       (num_mmsg_np_beats       )
    ,.num_mmsg_pc_beats       (num_mmsg_pc_beats       )
    ,.num_mmsg_dropped_pkts   (num_mmsg_dropped_pkts   )
    ,.num_tmsg_np_pkts        (num_tmsg_np_pkts        )
    ,.num_tmsg_pc_pkts        (num_tmsg_pc_pkts        )
    ,.num_tmsg_np_beats       (num_tmsg_np_beats       )
    ,.num_tmsg_pc_beats       (num_tmsg_pc_beats       )
    ,.num_tmsg_dropped_pkts   (num_tmsg_dropped_pkts   )

    ,.mon_enable              (mon_enable              )
    ,.clr_stats               (clr_stats               )
    ,.flush_cap_ff            (flush_cap_ff            )
    ,.rec_ordering_en         (rec_ordering_en         )
    ,.tmsg_mask_en            (target_mask_en          )
    ,.tmsg_mask_value         (target_mask_value       )
    ,.mmsg_mask_en            (master_mask_en          )
    ,.mmsg_mask_value         (master_mask_value       )

  );

  /*  Statistics  Instance  */
  IW_fpga_iosf_sb_mon_stats   u_stats
  (
     .clk_logic               (clk_logic               )
    ,.rst_logic_n             (rst_logic_n             )

    ,.clr_stats               (clr_stats               )

    ,.iosfsb_MNPPUT           (iosfsb_MNPPUT           )
    ,.iosfsb_MPCPUT           (iosfsb_MPCPUT           )
    ,.iosfsb_MEOM             (iosfsb_MEOM             )
    ,.iosfsb_TNPPUT           (iosfsb_TNPPUT           )
    ,.iosfsb_TPCPUT           (iosfsb_TPCPUT           )
    ,.iosfsb_TEOM             (iosfsb_TEOM             )

    ,.master_mon_data_valid   (master_mon_data_valid   )
    ,.master_filt_bp          (master_filt_bp          )

    ,.target_mon_data_valid   (target_mon_data_valid   )
    ,.target_filt_bp          (target_filt_bp          )

    ,.num_mmsg_np_pkts        (num_mmsg_np_pkts        )
    ,.num_mmsg_pc_pkts        (num_mmsg_pc_pkts        )
    ,.num_mmsg_np_beats       (num_mmsg_np_beats       )
    ,.num_mmsg_pc_beats       (num_mmsg_pc_beats       )
    ,.num_mmsg_dropped_pkts   (num_mmsg_dropped_pkts   )
    ,.num_tmsg_np_pkts        (num_tmsg_np_pkts        )
    ,.num_tmsg_pc_pkts        (num_tmsg_pc_pkts        )
    ,.num_tmsg_np_beats       (num_tmsg_np_beats       )
    ,.num_tmsg_pc_beats       (num_tmsg_pc_beats       )
    ,.num_tmsg_dropped_pkts   (num_tmsg_dropped_pkts   )

  );


  /*  master channel jem tracker instance  */
  iosf_sb_jem_tracker #(
    .WIDTH        (PAYLOAD_WIDTH),
    .BUFFER_SIZE  (JEM_TRACKER_BUFFER_SIZE)
  ) iosf_sb_jem_tracker_master  (
    .enable             (mon_enable),
    .side_clk           (clk_logic),
    .side_rst_b         (rst_logic_n),
    .put_np             (iosfsb_MNPPUT),
    .put_p              (iosfsb_MPCPUT),
    .payload            ({{(32-PAYLOAD_WIDTH){1'b0}},iosfsb_MPAYLOAD}),
    .eom                (iosfsb_MEOM),
    .direction          (1'b0),
    .data_valid         (master_mon_data_valid),
    .data               (master_mon_data)
  );

  /*  master channel filter instance  */
  IW_fpga_generic_filt #(
   .DATA_WIDTH  (JEM_RECORD_WIDTH),
   .USE_FLOP    (0)
  ) IW_fpga_generic_filt_master (
    .clk                  (clk_logic),
    .rst_n                (rst_logic_n),

    //jem tracker signals
    .mon_data             (master_mon_data),
    .mon_data_valid       (master_mon_data_valid),

    //csr signals
    .enable               (mon_enable),
    .match_mask           (master_mask_en),
    .match_data           (master_mask_value),

    //fifo interface
    .filt_data            (master_filt_data),
    .filt_data_valid      (master_filt_data_valid),
    .filt_bp              (master_filt_bp)
  );

  assign  master_cap_ff_wdata   = {{(CAP_FF_DATA_W-CAP_RECORD_W){1'b0}},master_filt_data,cap_rec_id[1]};
  assign  master_cap_ff_wren    = master_filt_data_valid;
  assign  master_filt_bp        = master_cap_ff_full;

  /*  master channel capture fifo */
  //IW_fpga_iosf_sb_mon_ff_224x512  u_master_cap_ff
  IW_fpga_async_fifo #(
    .ADDR_WD (9),
    .DATA_WD (CAP_FF_DATA_W) ) u_master_cap_ff
  (
    .rstn                         (master_cap_ff_rst_n),
    .data                         (master_cap_ff_wdata),
    .rdclk                        (master_cap_ff_rdclk),
    .rdreq                        (master_cap_ff_rden),
    .wrclk                        (master_cap_ff_wrclk),
    .wrreq                        (master_cap_ff_wren),
    .q                            (master_cap_ff_rdata),
    .rdempty                      (master_cap_ff_empty),
    .rdusedw                      (master_cap_ff_rdused),
    .wrfull                       (master_cap_ff_full),
    .wrusedw                      (master_cap_ff_wrused)
  );



  /*  target channel jem tracker instance  */
  iosf_sb_jem_tracker #(
    .WIDTH        (PAYLOAD_WIDTH),
    .BUFFER_SIZE  (JEM_TRACKER_BUFFER_SIZE)
  ) iosf_sb_jem_tracker_target (
    .enable             (mon_enable),
    .side_clk           (clk_logic),
    .side_rst_b         (rst_logic_n),
    .put_np             (iosfsb_TNPPUT),
    .put_p              (iosfsb_TPCPUT),
    .payload            ({{(32-PAYLOAD_WIDTH){1'b0}},iosfsb_TPAYLOAD}),
    .eom                (iosfsb_TEOM),
    .direction          (1'b1),
    .data_valid         (target_mon_data_valid),
    .data               (target_mon_data)
  );

  /*  target channel filter instance  */
  IW_fpga_generic_filt #(
   .DATA_WIDTH  (JEM_RECORD_WIDTH),
   .USE_FLOP    (0)
  ) IW_fpga_generic_filt_target (
    .clk                  (clk_logic),
    .rst_n                (rst_logic_n),

    //jem tracker signals
    .mon_data             (target_mon_data),
    .mon_data_valid       (target_mon_data_valid),

    //csr signals
    .enable               (mon_enable),
    .match_mask           (target_mask_en),
    .match_data           (target_mask_value),

    //fifo interafce
    .filt_data            (target_filt_data),
    .filt_data_valid      (target_filt_data_valid),
    .filt_bp              (target_filt_bp)

  );

  assign  target_cap_ff_wdata   = {{(CAP_FF_DATA_W-CAP_RECORD_W){1'b0}},target_filt_data,cap_rec_id[0]};
  assign  target_cap_ff_wren    = target_filt_data_valid;
  assign  target_filt_bp        = target_cap_ff_full;

  /*  target channel capture fifo */
  //IW_fpga_iosf_sb_mon_ff_224x512  u_target_cap_ff
  IW_fpga_async_fifo #(
    .ADDR_WD (9),
    .DATA_WD (CAP_FF_DATA_W) ) u_target_cap_ff
  (
    .rstn                         (target_cap_ff_rst_n),
    .data                         (target_cap_ff_wdata),
    .rdclk                        (target_cap_ff_rdclk),
    .rdreq                        (target_cap_ff_rden),
    .wrclk                        (target_cap_ff_wrclk),
    .wrreq                        (target_cap_ff_wren),
    .q                            (target_cap_ff_rdata),
    .rdempty                      (target_cap_ff_empty),
    .rdusedw                      (target_cap_ff_rdused),
    .wrfull                       (target_cap_ff_full),
    .wrusedw                      (target_cap_ff_wrused)

  );


  //Switch connections between standalone & avl modes
  generate
    if(MODE ==  "avl")
    begin
      IW_fpga_jem_record_mngr #(
         .NUM_CHANNELS        (NUM_CAP_INTFS)
        ,.RECORD_ID_WIDTH     (RECORD_ID_WIDTH)

      ) u_IW_fpga_jem_record_mngr (

         .clk_ingr            (clk_logic)
        ,.rst_ingr_n          (rst_logic_n)
        ,.egr_ordering_en     (rec_ordering_en)
        ,.chnnl_ingr_wren     ({master_cap_ff_wren,target_cap_ff_wren})
        ,.chnnl_ingr_rec_id   (cap_rec_id)

        ,.clk_egr             (clk_csr)
        ,.rst_egr_n           (rst_csr_n)
        ,.chnnl_egr_empty     ({master_cap_ff_empty,target_cap_ff_empty})
        ,.chnnl_egr_rec_id    ({master_cap_ff_rdata[RECORD_ID_WIDTH-1:0],target_cap_ff_rdata[RECORD_ID_WIDTH-1:0]})
        ,.chnnl_egr_valid_bin (chnnl_egr_valid_bin)
        ,.chnnl_egr_valid     (chnnl_egr_valid)
        ,.chnnl_egr_rden      ({master_cap_ff_rden,target_cap_ff_rden})

      );

      //CAP FF Read ports are accessed by external SBE; CSR equivalent ports & tied off
      assign  master_cap_ff_wrclk = clk_logic;
      assign  master_cap_ff_rdclk = clk_csr;
      assign  master_cap_ff_rst_n = rst_csr_n & ~flush_cap_ff;

      assign  target_cap_ff_wrclk = clk_logic;
      assign  target_cap_ff_rdclk = clk_csr;
      assign  target_cap_ff_rst_n = rst_csr_n & ~flush_cap_ff;

      assign  tmsg_chnnl_cap_rdata_valid  = chnnl_egr_valid[0];
      assign  tmsg_chnnl_cap_rdata        = target_cap_ff_rdata[CAP_RECORD_W-1:0];
      assign  target_cap_ff_rden          = chnnl_egr_valid[0] & cap_rden;

      assign  mmsg_chnnl_cap_rdata_valid  = chnnl_egr_valid[1];
      assign  mmsg_chnnl_cap_rdata        = master_cap_ff_rdata[CAP_RECORD_W-1:0];
      assign  master_cap_ff_rden          = chnnl_egr_valid[1] & cap_rden ;

      assign  csr_tmsg_cap_rdata_valid    = 1'b0;
      assign  csr_tmsg_cap_rdata          = {CAP_FF_DATA_W{1'b0}};
      assign  csr_tmsg_cap_rdused         = {CAP_FF_USED_W{1'b0}};

      assign  csr_mmsg_cap_rdata_valid    = 1'b0;
      assign  csr_mmsg_cap_rdata          = {CAP_FF_DATA_W{1'b0}};
      assign  csr_mmsg_cap_rdused         = {CAP_FF_USED_W{1'b0}};
    end
    else  //MODE  ==  "standalone"
    begin
      IW_fpga_jem_record_mngr #(
         .NUM_CHANNELS        (NUM_CAP_INTFS)
        ,.RECORD_ID_WIDTH     (RECORD_ID_WIDTH)

      ) u_IW_fpga_jem_record_mngr (

         .clk_ingr            (clk_logic)
        ,.rst_ingr_n          (rst_logic_n)
        ,.egr_ordering_en     (rec_ordering_en)
        ,.chnnl_ingr_wren     ({master_cap_ff_wren,target_cap_ff_wren})
        ,.chnnl_ingr_rec_id   (cap_rec_id)

        ,.clk_egr             (clk_csr)
        ,.rst_egr_n           (rst_csr_n)
        ,.chnnl_egr_empty     ({master_cap_ff_empty,target_cap_ff_empty})
        ,.chnnl_egr_rec_id    ('{master_cap_ff_rdata[RECORD_ID_WIDTH-1:0],target_cap_ff_rdata[RECORD_ID_WIDTH-1:0]})
        ,.chnnl_egr_valid     (chnnl_egr_valid)
        ,.chnnl_egr_rden      ({master_cap_ff_rden,target_cap_ff_rden})

      );

      //CAP FF Read ports are accessed by CSR; SBE equivalent ports are tied off
      assign  master_cap_ff_wrclk = clk_logic;
      assign  master_cap_ff_rdclk = clk_logic;
      assign  master_cap_ff_rst_n = rst_csr_n & ~flush_cap_ff;

      assign  target_cap_ff_wrclk = clk_logic;
      assign  target_cap_ff_rdclk = clk_logic;
      assign  target_cap_ff_rst_n = rst_csr_n & ~flush_cap_ff;

      assign  csr_tmsg_cap_rdata_valid    = chnnl_egr_valid[0];
      assign  csr_tmsg_cap_rdata          = target_cap_ff_rdata;
      assign  csr_tmsg_cap_rdused         = target_cap_ff_rdused;
      assign  target_cap_ff_rden          = csr_tmsg_cap_rden;

      assign  csr_mmsg_cap_rdata_valid    = chnnl_egr_valid[1];
      assign  csr_mmsg_cap_rdata          = master_cap_ff_rdata;
      assign  csr_mmsg_cap_rdused         = master_cap_ff_rdused;
      assign  master_cap_ff_rden          = csr_mmsg_cap_rden;

      assign  tmsg_chnnl_cap_rdata_valid  = 1'b0;
      assign  tmsg_chnnl_cap_rdata        = {CAP_RECORD_W{1'b0}};

      assign  mmsg_chnnl_cap_rdata_valid  = 1'b0;
      assign  mmsg_chnnl_cap_rdata        = {CAP_RECORD_W{1'b0}};
    end
  endgenerate

endmodule
