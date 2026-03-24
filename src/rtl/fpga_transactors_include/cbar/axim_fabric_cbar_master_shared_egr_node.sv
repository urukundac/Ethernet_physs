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
 -- Module Name       : axim_fabric_cbar_master_shared_egr_node
 -- Author            : Gregory James
 -- Associated modules: 
 -- Function          : This module interfaces with AW, W & AR channels of
                        a Master & funnels into a common FIFO.
 --------------------------------------------------------------------------
*/

`timescale 1ns / 10ps

`include  "axim_fabric_common_defines.svh"

module axim_fabric_cbar_master_shared_egr_node #(
//----------------------- Global parameters Declarations ------------------
  `include  "axim_fabric_aw_params_decl.svh"
  ,
  `include  "axim_fabric_w_params_decl.svh"
  ,
  `include  "axim_fabric_ar_params_decl.svh"

  ,parameter  NUM_SLAVES      = 4
  ,parameter  SLAVE_ID_W      = (NUM_SLAVES > 1) ? $clog2(NUM_SLAVES) : 1

  ,parameter  SHARED_CORE_DATA_W      = 32

  ,parameter          FIFO_DEPTH      = 128
  ,parameter  string  FIFO_MEM_TYPE   = "BRAM"


) (
//----------------------- Master Side Interface ----------------------------
   input  m_clk
  ,input  m_rst_n

  ,input  addr_map

  ,input  m_awvalid
  ,output m_awready
  ,input  m_awid
  ,input  m_awaddr
  ,input  m_awlen
  ,input  m_awsize
  ,input  m_awburst
  ,input  m_awlock
  ,input  m_awcache
  ,input  m_awprot
  ,input  m_awqos
  ,input  m_awregion
  ,input  m_awuser

  ,input  m_wvalid
  ,output m_wready
  ,input  m_wid
  ,input  m_wdata
  ,input  m_wstrb
  ,input  m_wlast
  ,input  m_wuser

  ,input  m_arvalid
  ,output m_arready
  ,input  m_arid
  ,input  m_araddr
  ,input  m_arlen
  ,input  m_arsize
  ,input  m_arburst
  ,input  m_arlock
  ,input  m_arcache
  ,input  m_arprot
  ,input  m_arqos
  ,input  m_arregion
  ,input  m_aruser


//----------------------- Slave Side Interface -----------------------------
  ,input  core_clk
  ,input  core_rst_n

  ,output core_egr_valid
  ,input  core_egr_ready
  ,output core_egr_data

);

//----------------------- Global Data Types -------------------------------
  `_create_axi4_aw_struct_t(axi4_aw_struct_t,AWID_W,AWADDR_W,AWLEN_W,AWSIZE_W,AWBURST_W,AWLOCK_W,AWCACHE_W,AWPROT_W,AWQOS_W,AWREGION_W,AWUSER_W)
  `_create_axi4_w_struct_t(axi4_w_struct_t,WID_W,WDATA_W,WSTRB_W,WLAST_W,WUSER_W)
  `_create_axi4_ar_struct_t(axi4_ar_struct_t,ARID_W,ARADDR_W,ARLEN_W,ARSIZE_W,ARBURST_W,ARLOCK_W,ARCACHE_W,ARPROT_W,ARQOS_W,ARREGION_W,ARUSER_W)
  `_create_axi4_xtn_enum_t(axi4_xtn_t)
  `_create_axi4_shared_core_struct_t(axi4_shared_core_stuct_t,axi4_xtn_t,SHARED_CORE_DATA_W)


//----------------------- Port Types -------------------------------------
  logic                       m_clk;
  logic                       m_rst_n;

  logic [AWADDR_W-1:0]        addr_map [0:NUM_SLAVES-1][0:1];

  logic                       m_awvalid;
  logic                       m_awready;
  logic [AWID_W-1:0]          m_awid;
  logic [AWADDR_W-1:0]        m_awaddr;
  logic [AWLEN_W-1:0]         m_awlen;
  logic [AWSIZE_W-1:0]        m_awsize;
  logic [AWBURST_W-1:0]       m_awburst;
  logic [AWLOCK_W-1:0]        m_awlock;
  logic [AWCACHE_W-1:0]       m_awcache;
  logic [AWPROT_W-1:0]        m_awprot;
  logic [AWQOS_W-1:0]         m_awqos;
  logic [AWREGION_W-1:0]      m_awregion;
  logic [AWUSER_W-1:0]        m_awuser;

  logic                       m_wvalid;
  logic                       m_wready;
  logic [WID_W-1:0]           m_wid;
  logic [WDATA_W-1:0]         m_wdata;
  logic [WSTRB_W-1:0]         m_wstrb;
  logic [WLAST_W-1:0]         m_wlast;
  logic [WUSER_W-1:0]         m_wuser;

  logic                       m_arvalid;
  logic                       m_arready;
  logic [ARID_W-1:0]          m_arid;
  logic [ARADDR_W-1:0]        m_araddr;
  logic [ARLEN_W-1:0]         m_arlen;
  logic [ARSIZE_W-1:0]        m_arsize;
  logic [ARBURST_W-1:0]       m_arburst;
  logic [ARLOCK_W-1:0]        m_arlock;
  logic [ARCACHE_W-1:0]       m_arcache;
  logic [ARPROT_W-1:0]        m_arprot;
  logic [ARQOS_W-1:0]         m_arqos;
  logic [ARREGION_W-1:0]      m_arregion;
  logic [ARUSER_W-1:0]        m_aruser;


  logic                       core_clk;
  logic                       core_rst_n;

  logic [NUM_SLAVES-1:0]      core_egr_valid;
  logic [NUM_SLAVES-1:0]      core_egr_ready;
  axi4_shared_core_stuct_t    core_egr_data;


//----------------------- Internal Parameters -----------------------------
  localparam  AXI4_AW_STRUCT_W      = $bits(axi4_aw_struct_t);
  localparam  AXI4_AR_STRUCT_W      = $bits(axi4_ar_struct_t);
  localparam  AXI4_W_STRUCT_W       = $bits(axi4_w_struct_t);
  localparam  SHARED_CORE_STRUCT_W  = $bits(axi4_shared_core_stuct_t);


//----------------------- Internal Register Declarations ------------------
  logic                           ff_wr_en;
  axi4_shared_core_stuct_t        ff_wr_data;

  logic                           addr_valid_1d;
  logic                           addr_decode_valid_1d;
  logic [SLAVE_ID_W-1:0]          slave_id_f;
  logic [NUM_SLAVES-1:0]          slave_sel_f;

//----------------------- Internal Wire Declarations ----------------------
  logic                           m_awready_next;
  axi4_aw_struct_t                m_axi4_aw_data;
  logic                           m_wready_next;
  axi4_w_struct_t                 m_axi4_w_data;
  logic                           m_arready_next;
  axi4_ar_struct_t                m_axi4_ar_data;

  logic                           ff_wr_en_next;
  axi4_shared_core_stuct_t        ff_wr_data_next;
  logic                           ff_wr_full;
  logic                           ff_rd_en;
  axi4_shared_core_stuct_t        ff_rd_data;
  axi4_aw_struct_t                ff_rd_aw_data;
  axi4_w_struct_t                 ff_rd_w_data;
  axi4_ar_struct_t                ff_rd_ar_data;
  logic                           ff_rd_empty;

  logic                           addr_valid;
  wire                            addr_valid_p;
  wire                            addr_decode_valid;
  wire                            addr_decode_no_match;
  wire  [NUM_SLAVES-1:0]          slave_sel;
  wire  [SLAVE_ID_W-1:0]          slave_id;

  wire                            core_slave_ready;

//----------------------- FSM Register Declarations ------------------
  enum  logic [1:0] {
    IDLE_S           = 2'b00,
    WAIT_FOR_WLAST_S = 2'b10
  } fsm_pstate, fsm_next_state;

//----------------------- Start of Code -----------------------------------

  /*  Pack Master Interface signals into struct */
  assign  m_axi4_aw_data.awid         = m_awid;
  assign  m_axi4_aw_data.awaddr       = m_awaddr;
  assign  m_axi4_aw_data.awlen        = m_awlen;
  assign  m_axi4_aw_data.awsize       = m_awsize;
  assign  m_axi4_aw_data.awburst      = m_awburst;
  assign  m_axi4_aw_data.awlock       = m_awlock;
  assign  m_axi4_aw_data.awcache      = m_awcache;
  assign  m_axi4_aw_data.awprot       = m_awprot;
  assign  m_axi4_aw_data.awqos        = m_awqos;
  assign  m_axi4_aw_data.awregion     = m_awregion;
  assign  m_axi4_aw_data.awuser       = m_awuser;

  assign  m_axi4_w_data.wid           = m_wid;
  assign  m_axi4_w_data.wdata         = m_wdata;
  assign  m_axi4_w_data.wstrb         = m_wstrb;
  assign  m_axi4_w_data.wlast         = m_wlast;
  assign  m_axi4_w_data.wuser         = m_wuser;

  assign  m_axi4_ar_data.arid         = m_arid;
  assign  m_axi4_ar_data.araddr       = m_araddr;
  assign  m_axi4_ar_data.arlen        = m_arlen;
  assign  m_axi4_ar_data.arsize       = m_arsize;
  assign  m_axi4_ar_data.arburst      = m_arburst;
  assign  m_axi4_ar_data.arlock       = m_arlock;
  assign  m_axi4_ar_data.arcache      = m_arcache;
  assign  m_axi4_ar_data.arprot       = m_arprot;
  assign  m_axi4_ar_data.arqos        = m_arqos;
  assign  m_axi4_ar_data.arregion     = m_arregion;
  assign  m_axi4_ar_data.aruser       = m_aruser;

  /*  FIFO Write Logic  */
  always@(posedge m_clk,  negedge m_rst_n)
  begin
    if(~m_rst_n)
    begin
      ff_wr_en      <=  1'b0;
      ff_wr_data    <=  {SHARED_CORE_STRUCT_W{1'b0}};

      fsm_pstate    <=  IDLE_S;
    end
    else
    begin
      fsm_pstate    <=  fsm_next_state;

      if(ff_wr_en)
      begin
        ff_wr_en    <=  ff_wr_full  ? ff_wr_en  : ff_wr_en_next;
      end
      else
      begin
        ff_wr_en    <=  ff_wr_en_next;
      end

      ff_wr_data    <=  ff_wr_data_next;
    end
  end

  always_comb
  begin
    fsm_next_state          = fsm_pstate;

    m_awready_next          =  1'b0;
    m_wready_next           =  1'b0;
    m_arready_next          =  1'b0;

    ff_wr_en_next           =  1'b0;
    ff_wr_data_next         =  ff_wr_data;


    if(~ff_wr_full)
    begin
      case(fsm_pstate)
        IDLE_S  :
        begin
          if(m_awvalid)
          begin
            fsm_next_state      = WAIT_FOR_WLAST_S;
            m_awready_next      = 1'b1;
            ff_wr_en_next       = 1'b1;
            ff_wr_data_next.xtn = AW_XTN;
            ff_wr_data_next.data[AXI4_AW_STRUCT_W-1:0]  = m_axi4_aw_data;
          end
          else if(m_arvalid)
          begin
            fsm_next_state      = IDLE_S;
            m_arready_next      = 1'b1;
            ff_wr_en_next       = 1'b1;
            ff_wr_data_next.xtn = AR_XTN;
            ff_wr_data_next.data[AXI4_AR_STRUCT_W-1:0]  = m_axi4_ar_data;
          end
          else
          begin
            fsm_next_state      = IDLE_S;
          end
        end

        WAIT_FOR_WLAST_S :
        begin
          if(m_wvalid)
          begin
            fsm_next_state      = m_wlast ? IDLE_S : WAIT_FOR_WLAST_S;

            m_wready_next       = 1'b1;
            ff_wr_en_next       = 1'b1;
            ff_wr_data_next.xtn = W_XTN;
            ff_wr_data_next.data[AXI4_W_STRUCT_W-1:0]   = m_axi4_w_data;
          end
        end

      endcase
    end
  end

  assign  m_awready   = m_awready_next;
  assign  m_wready    = m_wready_next;
  assign  m_arready   = m_arready_next;


  /*  Instantiate FIFO  */
  generic_async_fifo #(
     .WRITE_WIDTH       (SHARED_CORE_STRUCT_W)
    ,.READ_WIDTH        (SHARED_CORE_STRUCT_W)
    ,.NUM_BITS          (SHARED_CORE_STRUCT_W*FIFO_DEPTH)
    ,.MEM_TYPE          (FIFO_MEM_TYPE)
    ,.NUM_SYNC_STAGES   (3)

  ) u_async_fifo  (

    /*  input  logic                    */   .wr_clk          (m_clk)
    /*  input  logic                    */  ,.wr_rst_n        (m_rst_n)
    /*  input  logic                    */  ,.wr_en           (ff_wr_en)
    /*  input  logic [WIDTH-1:0]        */  ,.wr_data         (ff_wr_data)
    /*  output logic                    */  ,.wr_full         (ff_wr_full)
    /*  output logic                    */  ,.wr_afull        ()
    /*  output logic [$clog2(DEPTH):0]  */  ,.wr_occupancy    ()
    /*  output logic                    */  ,.wr_overflow     ()

    /*  input  logic                    */  ,.rd_clk          (core_clk)
    /*  input  logic                    */  ,.rd_rst_n        (core_rst_n)
    /*  input  logic                    */  ,.rd_en           (ff_rd_en)
    /*  output logic [WIDTH-1:0]        */  ,.rd_data         (ff_rd_data)
    /*  output logic                    */  ,.rd_empty        (ff_rd_empty)
    /*  output logic                    */  ,.rd_aempty       ()
    /*  output logic [$clog2(DEPTH):0]  */  ,.rd_occupancy    ()
    /*  output logic                    */  ,.rd_underflow    ()

  );

  assign  ff_rd_aw_data = ff_rd_data.data[AXI4_AW_STRUCT_W-1:0];
  assign  ff_rd_w_data  = ff_rd_data.data[AXI4_W_STRUCT_W-1:0];
  assign  ff_rd_ar_data = ff_rd_data.data[AXI4_AR_STRUCT_W-1:0];


  /*  Instantitate Address Decoder  */
  axi_fabric_addr_decode #(
     .NUM_SLAVES    (NUM_SLAVES)
    ,.SLAVE_ID_W    (SLAVE_ID_W)
    ,.ADDR_W        (AWADDR_W)
    ,.CARGO_W       (1)

  ) u_addr_decode (
    /*  input  logic                  */   .clk                   (core_clk)
    /*  input  logic                  */  ,.rst_n                 (core_rst_n)

    /*  input  logic <addr-map-dim>   */  ,.addr_map              (addr_map)
    /*  input  logic                  */  ,.addr_valid            (addr_valid_p)
    /*  input  logic [ADDR_W-1:0]     */  ,.addr                  (ff_rd_aw_data.awaddr)
    /*  input  logic [CARGO_W-1:0]    */  ,.cargo_in              (1'b0)

    /*  output logic                  */  ,.addr_decode_valid     (addr_decode_valid)
    /*  output logic                  */  ,.addr_decode_no_match  (addr_decode_no_match)
    /*  output logic [NUM_SLAVES-1:0] */  ,.slave_sel             (slave_sel)
    /*  output logic [SLAVE_ID_W-1:0] */  ,.slave_id              (slave_id)
    /*  output logic [CARGO_W-1:0]    */  ,.cargo_out             ()

  );


  /*  Slave Interface Pipe  */
  always@(posedge core_clk, negedge core_rst_n)
  begin
    if(~core_rst_n)
    begin
      core_egr_valid          <=  {NUM_SLAVES{1'b0}};
      core_egr_data           <=  {SHARED_CORE_STRUCT_W{1'b0}};

      addr_valid_1d           <=  1'b0;
      addr_decode_valid_1d    <=  1'b0;
      slave_id_f              <=  {SLAVE_ID_W{1'b0}};
      slave_sel_f             <=  {NUM_SLAVES{1'b0}};
    end
    else
    begin
      //Do address decode only for AW & AR xtns
      //It is expected that W xtns come in order so that the last decoded slave-id will be used
      addr_valid_1d           <=  addr_valid;
      addr_decode_valid_1d    <=  addr_decode_valid;
      slave_id_f              <=  addr_decode_valid ? slave_id  : slave_id_f;
      slave_sel_f             <=  addr_decode_valid ? slave_sel : slave_sel_f;

      if(core_egr_valid)
      begin
        core_egr_valid        <=  core_slave_ready  ? {NUM_SLAVES{1'b0}}  : core_egr_valid;
      end
      else
      begin
        if(~ff_rd_empty)
        begin
          if((ff_rd_data.xtn  ==  AW_XTN) ||  (ff_rd_data.xtn ==  AR_XTN))  //Wait for address decode
          begin
            core_egr_valid    <=  addr_decode_valid ? slave_sel : core_egr_valid;
          end
          else //Send out xtn to last decoded slave
          begin
            core_egr_valid    <=  slave_sel_f;
          end

          core_egr_data       <=  ff_rd_data;
        end
      end
    end
  end

  assign  core_slave_ready  = core_egr_ready[slave_id_f];

  always_comb
  begin
    addr_valid  = 1'b0;

    if((core_egr_valid & core_egr_ready) | addr_decode_no_match)
    begin
      addr_valid  = 1'b0;
    end
    else if(~ff_rd_empty)
    begin
      addr_valid  = ((ff_rd_data.xtn  ==  AW_XTN) ||  (ff_rd_data.xtn ==  AR_XTN))  ? 1'b1  : 1'b0;
    end
  end

  assign  addr_valid_p    = addr_valid  & ~addr_valid_1d;

  assign  ff_rd_en        = (core_egr_valid  & core_egr_ready)  ? 1'b1  : addr_decode_no_match;




endmodule // axim_fabric_cbar_master_shared_egr_node
