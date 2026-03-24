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
 -- Project Code      : axim_fabric
 -- Module Name       : axim_fabric_cbar_slave_shared_ingr_node
 -- Author            : Gregory James
 -- Associated modules: 
 -- Function          : This module receives AW, W & AR transactions from a
                        common FIFO & routes to the Slave channels.
 --------------------------------------------------------------------------
*/

`timescale 1ns / 10ps

`include  "axim_fabric_common_defines.svh"

module axim_fabric_cbar_slave_shared_ingr_node #(
//----------------------- Global parameters Declarations ------------------
  `include  "axim_fabric_aw_params_decl.svh"
  ,
  `include  "axim_fabric_w_params_decl.svh"
  ,
  `include  "axim_fabric_ar_params_decl.svh"
  ,
  `include  "axim_fabric_r_params_decl.svh"

  ,parameter  NUM_MASTERS     = 4
  ,parameter  MASTER_ID_W     = (NUM_MASTERS > 1) ? $clog2(NUM_MASTERS) : 1

  ,parameter  SHARED_CORE_DATA_W      = 32
  ,parameter  EGR_SHARED_CORE_DATA_W  = 32

  ,parameter          FIFO_DEPTH      = 128
  ,parameter  string  FIFO_MEM_TYPE   = "BRAM"


) (
//----------------------- Master Side Interface -----------------------------
   input  core_clk
  ,input  core_rst_n

  ,input  core_ingr_valid
  ,output core_ingr_ready
  ,input  core_ingr_data

  ,input  core_egr_valid
  ,input  core_egr_ready
  ,input  core_egr_data

//----------------------- Slave Egress B, R Interface ----------------------
  ,output ingr2egr_b_valid
  ,output ingr2egr_b_data
  ,input  ingr2egr_b_ready

  ,output ingr2egr_r_valid
  ,output ingr2egr_r_data
  ,input  ingr2egr_r_ready

//----------------------- Slave Side Interface ----------------------------
  ,input  s_clk
  ,input  s_rst_n

  ,output s_awvalid
  ,input  s_awready
  ,output s_awid
  ,output s_awaddr
  ,output s_awlen
  ,output s_awsize
  ,output s_awburst
  ,output s_awlock
  ,output s_awcache
  ,output s_awprot
  ,output s_awqos
  ,output s_awregion
  ,output s_awuser

  ,output s_wvalid
  ,input  s_wready
  ,output s_wid
  ,output s_wdata
  ,output s_wstrb
  ,output s_wlast
  ,output s_wuser

  ,output s_arvalid
  ,input  s_arready
  ,output s_arid
  ,output s_araddr
  ,output s_arlen
  ,output s_arsize
  ,output s_arburst
  ,output s_arlock
  ,output s_arcache
  ,output s_arprot
  ,output s_arqos
  ,output s_arregion
  ,output s_aruser

);

//----------------------- Global Data Types -------------------------------
  `_create_axi4_aw_struct_t(axi4_aw_struct_t,AWID_W,AWADDR_W,AWLEN_W,AWSIZE_W,AWBURST_W,AWLOCK_W,AWCACHE_W,AWPROT_W,AWQOS_W,AWREGION_W,AWUSER_W)
  `_create_axi4_w_struct_t(axi4_w_struct_t,WID_W,WDATA_W,WSTRB_W,WLAST_W,WUSER_W)
  `_create_axi4_ar_struct_t(axi4_ar_struct_t,ARID_W,ARADDR_W,ARLEN_W,ARSIZE_W,ARBURST_W,ARLOCK_W,ARCACHE_W,ARPROT_W,ARQOS_W,ARREGION_W,ARUSER_W)
  `_create_axi4_r_struct_t(axi4_r_struct_t,RID_W,RDATA_W,RRESP_W,RLAST_W,RUSER_W)
  `_create_axi4_xtn_enum_t(axi4_xtn_t)
  `_create_axi4_shared_core_struct_t(axi4_shared_core_stuct_t,axi4_xtn_t,SHARED_CORE_DATA_W)
  `_create_axi4_shared_core_struct_t(axi4_egr_shared_core_stuct_t,axi4_xtn_t,EGR_SHARED_CORE_DATA_W)
  `_create_axi4_ingr2egr_b_struct_t(axi4_ingr2egr_b_struct_t,MASTER_ID_W,AWID_W)
  `_create_axi4_ingr2egr_r_struct_t(axi4_ingr2egr_r_struct_t,MASTER_ID_W,ARID_W)


//----------------------- Port Types -------------------------------------
  logic                     core_clk;
  logic                     core_rst_n;

  logic [NUM_MASTERS-1:0]   core_ingr_valid;
  logic [NUM_MASTERS-1:0]   core_ingr_ready;
  axi4_shared_core_stuct_t  core_ingr_data   [NUM_MASTERS-1:0];

  logic [NUM_MASTERS-1:0]       core_egr_valid;
  logic [NUM_MASTERS-1:0]       core_egr_ready;
  axi4_egr_shared_core_stuct_t  core_egr_data;

  logic                     ingr2egr_b_valid;
  axi4_ingr2egr_b_struct_t  ingr2egr_b_data;
  logic                     ingr2egr_b_ready;

  logic                     ingr2egr_r_valid;
  axi4_ingr2egr_r_struct_t  ingr2egr_r_data;
  logic                     ingr2egr_r_ready;


  logic                     s_clk;
  logic                     s_rst_n;

  logic                     s_awvalid;
  logic                     s_awready;
  logic [AWID_W-1:0]        s_awid;
  logic [AWADDR_W-1:0]      s_awaddr;
  logic [AWLEN_W-1:0]       s_awlen;
  logic [AWSIZE_W-1:0]      s_awsize;
  logic [AWBURST_W-1:0]     s_awburst;
  logic [AWLOCK_W-1:0]      s_awlock;
  logic [AWCACHE_W-1:0]     s_awcache;
  logic [AWPROT_W-1:0]      s_awprot;
  logic [AWQOS_W-1:0]       s_awqos;
  logic [AWREGION_W-1:0]    s_awregion;
  logic [AWUSER_W-1:0]      s_awuser;

  logic                     s_wvalid;
  logic                     s_wready;
  logic [WID_W-1:0]         s_wid;
  logic [WDATA_W-1:0]       s_wdata;
  logic [WSTRB_W-1:0]       s_wstrb;
  logic [WLAST_W-1:0]       s_wlast;
  logic [WUSER_W-1:0]       s_wuser;

  logic                     s_arvalid;
  logic                     s_arready;
  logic [ARID_W-1:0]        s_arid;
  logic [ARADDR_W-1:0]      s_araddr;
  logic [ARLEN_W-1:0]       s_arlen;
  logic [ARSIZE_W-1:0]      s_arsize;
  logic [ARBURST_W-1:0]     s_arburst;
  logic [ARLOCK_W-1:0]      s_arlock;
  logic [ARCACHE_W-1:0]     s_arcache;
  logic [ARPROT_W-1:0]      s_arprot;
  logic [ARQOS_W-1:0]       s_arqos;
  logic [ARREGION_W-1:0]    s_arregion;
  logic [ARUSER_W-1:0]      s_aruser;


//----------------------- Internal Parameters -----------------------------
  localparam  AXI4_AW_STRUCT_W      = $bits(axi4_aw_struct_t);
  localparam  AXI4_AR_STRUCT_W      = $bits(axi4_ar_struct_t);
  localparam  AXI4_W_STRUCT_W       = $bits(axi4_w_struct_t);
  localparam  AXI4_R_STRUCT_W       = $bits(axi4_r_struct_t);
  localparam  SHARED_CORE_STRUCT_W  = $bits(axi4_shared_core_stuct_t);


//----------------------- Internal Register Declarations ------------------
  logic [NUM_MASTERS-1:0]           arb_agent_req;
  logic                             gnt_valid,      gnt_valid_next;
  logic [MASTER_ID_W-1:0]           gnt_agent_id,   gnt_agent_id_next;
  logic [NUM_MASTERS-1:0]           gnt_agents_sel, gnt_agents_sel_next;

  logic                             ingr2egr_b_valid_next;
  logic                             ingr2egr_r_valid_next;

//----------------------- Internal Wire Declarations ----------------------
  wire                              arb_gnt_valid;
  wire  [MASTER_ID_W-1:0]           arb_gnt_agent_id;
  wire  [NUM_MASTERS-1:0]           arb_gnt_agents_sel;

  wire                              ff_wr_en;
  axi4_shared_core_stuct_t          ff_wr_data;
  wire                              ff_wr_full;
  axi4_shared_core_stuct_t          ff_rd_data;
  logic                             ff_rd_en;
  wire                              ff_rd_empty;

  axi4_aw_struct_t                  ff_wr_aw_data;
  axi4_w_struct_t                   ff_wr_w_data;
  axi4_ar_struct_t                  ff_wr_ar_data;

  axi4_aw_struct_t                  ff_rd_aw_data;
  axi4_w_struct_t                   ff_rd_w_data;
  axi4_ar_struct_t                  ff_rd_ar_data;

  axi4_r_struct_t                   core_egr_data_data;


//----------------------- FSM Register Declarations ------------------
  enum  logic [1:0] {
    IDLE_S           = 2'b00,
    WAIT_FOR_WLAST_S = 2'b01,
    WAIT_FOR_RLAST_S = 2'b10
  } fsm_pstate, fsm_next_state;


//----------------------- Start of Code -----------------------------------

  /*  Instantiate Arbiter */
  axi_fabric_arb #(
     .NUM_AGENTS    (NUM_MASTERS)
    ,.AGENT_ID_W    (MASTER_ID_W)
    ,.PRIORITY_W    (2)
    ,.MODE          ("NORMAL")

  ) u_axi_fabric_arb  (

    /*  input  logic                          */   .clk                 (core_clk)
    /*  input  logic                          */  ,.rst_n               (core_rst_n)

    /*  input  logic [NUM_AGENTS-1:0]         */  ,.agent_req           (arb_agent_req)
    /*  input  logic [NUM_AGENTS-1:0]         */  ,.agent_req_last      ()

    /*  output logic                          */  ,.gnt_valid           ()
    /*  output logic [AGENT_ID_W-1:0]         */  ,.gnt_agent_id        ()
    /*  output logic [NUM_AGENTS-1:0]         */  ,.gnt_agent_sel       ()

    /*  output logic                          */  ,.gnt_valid_next      (arb_gnt_valid)
    /*  output logic [AGENT_ID_W-1:0]         */  ,.gnt_agent_id_next   (arb_gnt_agent_id)
    /*  output logic [NUM_AGENTS-1:0]         */  ,.gnt_agent_sel_next  (arb_gnt_agents_sel)

  );

  /*
    Ingress Master Lock Logic
  */
  always@(posedge  core_clk, negedge core_rst_n)
  begin
    if(~core_rst_n)
    begin
      fsm_pstate            <=  IDLE_S;

      gnt_valid             <=  1'b0;
      gnt_agent_id          <=  {MASTER_ID_W{1'b0}};
      gnt_agents_sel        <=  {NUM_MASTERS{1'b0}};

      ingr2egr_b_valid      <=  1'b0;
      ingr2egr_r_valid      <=  1'b0;
    end
    else
    begin
      fsm_pstate            <=  fsm_next_state;

      gnt_valid             <=  gnt_valid_next;
      gnt_agent_id          <=  gnt_agent_id_next;
      gnt_agents_sel        <=  gnt_agents_sel_next;

      ingr2egr_b_valid      <=  ingr2egr_b_valid_next;
      ingr2egr_r_valid      <=  ingr2egr_r_valid_next;
    end
  end

  assign  core_egr_data_data  = core_egr_data.data[AXI4_R_STRUCT_W-1:0];

  always_comb
  begin
    fsm_next_state              = fsm_pstate;

    gnt_valid_next              = 1'b0;
    gnt_agent_id_next           = gnt_agent_id;
    gnt_agents_sel_next         = gnt_agents_sel;

    arb_agent_req               = {NUM_MASTERS{1'b0}};

    ingr2egr_b_valid_next       = 1'b0;
    ingr2egr_r_valid_next       = 1'b0;

    case(fsm_pstate)

      IDLE_S:
      begin
        if(~ff_wr_full & ingr2egr_b_ready & ingr2egr_r_ready)
        begin
          arb_agent_req         = core_ingr_valid;

          if(arb_gnt_valid)
          begin
            gnt_valid_next      = 1'b1;
            gnt_agent_id_next   = arb_gnt_agent_id;
            gnt_agents_sel_next = arb_gnt_agents_sel;

            if(core_ingr_data[arb_gnt_agent_id].xtn == AW_XTN)
            begin
              ingr2egr_b_valid_next = 1'b1;
              fsm_next_state        = WAIT_FOR_WLAST_S;
            end
            else if(core_ingr_data[arb_gnt_agent_id].xtn == AR_XTN)
            begin
              ingr2egr_r_valid_next = 1'b1;
              //fsm_next_state        = WAIT_FOR_RLAST_S;
              fsm_next_state        = IDLE_S;
            end
          end
        end
      end

      WAIT_FOR_WLAST_S:
      begin
        gnt_valid_next          = 1'b1;

        if(core_ingr_valid[gnt_agent_id] & (core_ingr_data[gnt_agent_id].xtn == W_XTN) & ~ff_wr_full & ff_wr_w_data.wlast)
        begin
          gnt_valid_next        = 1'b0;
          gnt_agents_sel_next   = {NUM_MASTERS{1'b0}};
          fsm_next_state        = IDLE_S;
        end
      end

      WAIT_FOR_RLAST_S:
      begin
        gnt_valid_next          = 1'b1;

        if(core_egr_valid[gnt_agent_id] & core_egr_ready[gnt_agent_id] & (core_egr_data.xtn == R_XTN) & core_egr_data_data.rlast)
        begin
          gnt_valid_next        = 1'b0;
          gnt_agents_sel_next   = {NUM_MASTERS{1'b0}};
          fsm_next_state        = IDLE_S;
        end
      end

    endcase
  end



  assign  core_ingr_ready = ff_wr_full ? {NUM_MASTERS{1'b0}} : gnt_agents_sel;

  assign  ff_wr_en        = core_ingr_valid[gnt_agent_id] & core_ingr_ready[gnt_agent_id];
  assign  ff_wr_aw_data   = ff_wr_data.data[AXI4_AW_STRUCT_W-1:0];
  assign  ff_wr_w_data    = ff_wr_data.data[AXI4_W_STRUCT_W-1:0];
  assign  ff_wr_ar_data   = ff_wr_data.data[AXI4_AR_STRUCT_W-1:0];


  //assign  ingr2egr_b_valid          = (ff_wr_data.xtn == AW_XTN) ? gnt_valid  : 1'b0;
  assign  ingr2egr_b_data.axi_id    = ff_wr_aw_data.awid;
  assign  ingr2egr_b_data.master_id = gnt_agent_id;


  //assign  ingr2egr_r_valid          = (ff_wr_data.xtn == AR_XTN) ? gnt_valid  : 1'b0;
  assign  ingr2egr_r_data.axi_id    = ff_wr_ar_data.arid;
  assign  ingr2egr_r_data.master_id = gnt_agent_id;


  /*  Instantiate FIFO  */
  generic_async_fifo #(
     .WRITE_WIDTH       (SHARED_CORE_STRUCT_W)
    ,.READ_WIDTH        (SHARED_CORE_STRUCT_W)
    ,.NUM_BITS          (SHARED_CORE_STRUCT_W*FIFO_DEPTH)
    ,.MEM_TYPE          (FIFO_MEM_TYPE)
    ,.NUM_SYNC_STAGES   (3)

  ) u_async_fifo  (

    /*  input  logic                    */   .wr_clk          (core_clk)
    /*  input  logic                    */  ,.wr_rst_n        (core_rst_n)
    /*  input  logic                    */  ,.wr_en           (ff_wr_en)
    /*  input  logic [WIDTH-1:0]        */  ,.wr_data         (ff_wr_data)
    /*  output logic                    */  ,.wr_full         (ff_wr_full)
    /*  output logic                    */  ,.wr_afull        ()
    /*  output logic [$clog2(DEPTH):0]  */  ,.wr_occupancy    ()
    /*  output logic                    */  ,.wr_overflow     ()

    /*  input  logic                    */  ,.rd_clk          (s_clk)
    /*  input  logic                    */  ,.rd_rst_n        (s_rst_n)
    /*  input  logic                    */  ,.rd_en           (ff_rd_en)
    /*  output logic [WIDTH-1:0]        */  ,.rd_data         (ff_rd_data)
    /*  output logic                    */  ,.rd_empty        (ff_rd_empty)
    /*  output logic                    */  ,.rd_aempty       ()
    /*  output logic [$clog2(DEPTH):0]  */  ,.rd_occupancy    ()
    /*  output logic                    */  ,.rd_underflow    ()

  );

  assign  ff_wr_data    = core_ingr_data[gnt_agent_id];

  assign  ff_rd_aw_data = ff_rd_data.data[AXI4_AW_STRUCT_W-1:0];
  assign  ff_rd_w_data  = ff_rd_data.data[AXI4_W_STRUCT_W-1:0];
  assign  ff_rd_ar_data = ff_rd_data.data[AXI4_AR_STRUCT_W-1:0];

  always_comb
  begin
    ff_rd_en  = 1'b0;

    if(~ff_rd_empty)
    begin
      if(ff_rd_data.xtn == AW_XTN)
      begin
        ff_rd_en  = s_awready;
      end
      else if(ff_rd_data.xtn == W_XTN)
      begin
        ff_rd_en  = s_wready;
      end
      else if(ff_rd_data.xtn == AR_XTN)
      begin
        ff_rd_en  = s_arready;
      end
    end
  end

  /*  Unpack Struct Signals */
  assign  s_awvalid   = ~ff_rd_empty ? ((ff_rd_data.xtn == AW_XTN) ? 1'b1 : 1'b0) : 1'b0;
  assign  s_awid      = ff_rd_aw_data.awid;
  assign  s_awaddr    = ff_rd_aw_data.awaddr;
  assign  s_awlen     = ff_rd_aw_data.awlen;
  assign  s_awsize    = ff_rd_aw_data.awsize;
  assign  s_awburst   = ff_rd_aw_data.awburst;
  assign  s_awlock    = ff_rd_aw_data.awlock;
  assign  s_awcache   = ff_rd_aw_data.awcache;
  assign  s_awprot    = ff_rd_aw_data.awprot;
  assign  s_awqos     = ff_rd_aw_data.awqos;
  assign  s_awregion  = ff_rd_aw_data.awregion;
  assign  s_awuser    = ff_rd_aw_data.awuser;

  assign  s_wvalid    = ~ff_rd_empty ? ((ff_rd_data.xtn == W_XTN) ? 1'b1 : 1'b0) : 1'b0;
  assign  s_wid       = ff_rd_w_data.wid;
  assign  s_wdata     = ff_rd_w_data.wdata;
  assign  s_wstrb     = ff_rd_w_data.wstrb;
  assign  s_wlast     = ff_rd_w_data.wlast;
  assign  s_wuser     = ff_rd_w_data.wuser;

  assign  s_arvalid   = ~ff_rd_empty ? ((ff_rd_data.xtn == AR_XTN) ? 1'b1 : 1'b0) : 1'b0;
  assign  s_arid      = ff_rd_ar_data.arid;
  assign  s_araddr    = ff_rd_ar_data.araddr;
  assign  s_arlen     = ff_rd_ar_data.arlen;
  assign  s_arsize    = ff_rd_ar_data.arsize;
  assign  s_arburst   = ff_rd_ar_data.arburst;
  assign  s_arlock    = ff_rd_ar_data.arlock;
  assign  s_arcache   = ff_rd_ar_data.arcache;
  assign  s_arprot    = ff_rd_ar_data.arprot;
  assign  s_arqos     = ff_rd_ar_data.arqos;
  assign  s_arregion  = ff_rd_ar_data.arregion;
  assign  s_aruser    = ff_rd_ar_data.aruser;




endmodule // axim_fabric_cbar_slave_shared_ingr_node
