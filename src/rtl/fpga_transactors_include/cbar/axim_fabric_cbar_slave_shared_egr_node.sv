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
 -- Module Name       : axim_fabric_cbar_slave_shared_egr_node
 -- Author            : Gregory James
 -- Associated modules: 
 -- Function          : This module interfaces with B & R channels of
                        a Slave & funnels into a common FIFO.
 --------------------------------------------------------------------------
*/

`timescale 1ns / 10ps

`include  "axim_fabric_common_defines.svh"

module axim_fabric_cbar_slave_shared_egr_node #(
//----------------------- Global parameters Declarations ------------------
  `include  "axim_fabric_b_params_decl.svh"
  ,
  `include  "axim_fabric_r_params_decl.svh"

  ,parameter  NUM_MASTERS     = 4
  ,parameter  MASTER_ID_W     = (NUM_MASTERS > 1) ? $clog2(NUM_MASTERS) : 1

  ,parameter  SHARED_CORE_DATA_W      = 32

  ,parameter          FIFO_DEPTH      = 128
  ,parameter  string  FIFO_MEM_TYPE   = "BRAM"


) (
//----------------------- Slave Side Interface ------------------------
   input  s_clk
  ,input  s_rst_n

  ,input  s_bvalid
  ,output s_bready
  ,input  s_bid
  ,input  s_bresp
  ,input  s_buser

  ,input  s_rvalid
  ,output s_rready
  ,input  s_rid
  ,input  s_rdata
  ,input  s_rresp
  ,input  s_rlast
  ,input  s_ruser

//----------------------- Slave Egress B, R Interface -----------------------
  ,input  ingr2egr_b_valid
  ,input  ingr2egr_b_data
  ,output ingr2egr_b_ready

  ,input  ingr2egr_r_valid
  ,input  ingr2egr_r_data
  ,output ingr2egr_r_ready

//----------------------- Master Side Interface -----------------------------
  ,input  core_clk
  ,input  core_rst_n

  ,output core_egr_valid
  ,input  core_egr_ready
  ,output core_egr_data


);

//----------------------- Global Data Types -------------------------------
  `_create_axi4_b_struct_t(axi4_b_struct_t,BID_W,BRESP_W,BUSER_W)
  `_create_axi4_r_struct_t(axi4_r_struct_t,RID_W,RDATA_W,RRESP_W,RLAST_W,RUSER_W)
  `_create_axi4_ingr2egr_b_struct_t(axi4_ingr2egr_b_struct_t,MASTER_ID_W,BID_W)
  `_create_axi4_ingr2egr_r_struct_t(axi4_ingr2egr_r_struct_t,MASTER_ID_W,RID_W)
  `_create_axi4_xtn_enum_t(axi4_xtn_t)
  `_create_axi4_shared_core_struct_t(axi4_shared_core_stuct_t,axi4_xtn_t,SHARED_CORE_DATA_W)

//----------------------- Port Types -------------------------------------
  logic                     s_clk;
  logic                     s_rst_n;

  logic                     s_bvalid;
  logic                     s_bready;
  logic [BID_W-1:0]         s_bid;
  logic [BRESP_W-1:0]       s_bresp;
  logic [BUSER_W-1:0]       s_buser;

  logic                     s_rvalid;
  logic                     s_rready;
  logic [RID_W-1:0]         s_rid;
  logic [RDATA_W-1:0]       s_rdata;
  logic [RRESP_W-1:0]       s_rresp;
  logic [RLAST_W-1:0]       s_rlast;
  logic [RUSER_W-1:0]       s_ruser;


  logic                     ingr2egr_b_valid;
  axi4_ingr2egr_b_struct_t  ingr2egr_b_data;
  logic                     ingr2egr_b_ready;

  logic                     ingr2egr_r_valid;
  axi4_ingr2egr_r_struct_t  ingr2egr_r_data;
  logic                     ingr2egr_r_ready;


  logic                     core_clk;
  logic                     core_rst_n;

  logic [NUM_MASTERS-1:0]   core_egr_valid;
  logic [NUM_MASTERS-1:0]   core_egr_ready;
  axi4_shared_core_stuct_t  core_egr_data;



//----------------------- Internal Parameters -----------------------------
  localparam  AXI4_B_STRUCT_W           = $bits(axi4_b_struct_t);
  localparam  AXI4_R_STRUCT_W           = $bits(axi4_r_struct_t);
  localparam  AXI4_INGR2EGR_B_STRUCT_W  = $bits(axi4_ingr2egr_b_struct_t);
  localparam  AXI4_INGR2EGR_R_STRUCT_W  = $bits(axi4_ingr2egr_r_struct_t);
  localparam  SHARED_CORE_STRUCT_W      = $bits(axi4_shared_core_stuct_t);


//----------------------- Internal Register Declarations ------------------
  logic                       ff_wr_en;
  axi4_shared_core_stuct_t    ff_wr_data;

  logic [NUM_MASTERS-1:0]   core_egr_valid_next;
  axi4_shared_core_stuct_t  core_egr_data_next;

  logic [MASTER_ID_W-1:0]     curr_master_id, curr_master_id_next;

//----------------------- Internal Wire Declarations ----------------------
  logic                           s_bready_next;
  axi4_b_struct_t                 s_axi4_b_data;
  logic                           s_rready_next;
  axi4_r_struct_t                 s_axi4_r_data;

  logic                           ff_wr_en_next;
  axi4_shared_core_stuct_t        ff_wr_data_next;
  logic                           ff_wr_full;
  logic                           ff_rd_en;
  axi4_shared_core_stuct_t        ff_rd_data;
  axi4_b_struct_t                 ff_rd_b_data;
  axi4_r_struct_t                 ff_rd_r_data;
  logic                           ff_rd_empty;

  wire                            ingr2egr_b_master_id_search_ff_full;
  logic                           ingr2egr_b_search_en;
  axi4_ingr2egr_b_struct_t        ingr2egr_b_search_data;
  logic                           ingr2egr_b_search_found;
  axi4_ingr2egr_b_struct_t        ingr2egr_b_search_result;

  wire                            ingr2egr_r_master_id_search_ff_full;
  logic                           ingr2egr_r_search_en;
  axi4_ingr2egr_r_struct_t        ingr2egr_r_search_data;
  logic                           ingr2egr_r_search_found;
  axi4_ingr2egr_r_struct_t        ingr2egr_r_search_result;

  axi4_r_struct_t                 core_egr_r_data;


//----------------------- FSM Register Declarations ------------------
  enum  logic [2:0] {
    IDLE_S        = 3'd0,
    SEARCH_BID_S  = 3'd1,
    SEND_BRESP_S  = 3'd2,
    SEARCH_RID_S  = 3'd3,
    SEND_RRESP_S  = 3'd4
  } fsm_pstate, fsm_next_state;




//----------------------- Start of Code -----------------------------------

  /*  Pack Slave Interface signals into struct */
  assign  s_axi4_b_data.bid    = s_bid;
  assign  s_axi4_b_data.bresp  = s_bresp;
  assign  s_axi4_b_data.buser  = s_buser;

  assign  s_axi4_r_data.rid    = s_rid;
  assign  s_axi4_r_data.rdata  = s_rdata;
  assign  s_axi4_r_data.rresp  = s_rresp;
  assign  s_axi4_r_data.rlast  = s_rlast;
  assign  s_axi4_r_data.ruser  = s_ruser;
  //assign  s_axi4_r_data.ruser  = 'b0;




  /*  FIFO Write Logic  */
  always@(posedge s_clk,  negedge s_rst_n)
  begin
    if(~s_rst_n)
    begin
      ff_wr_en      <=  1'b0;
      ff_wr_data    <=  {SHARED_CORE_STRUCT_W{1'b0}};
    end
    else
    begin
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
    s_bready_next           =  1'b0;
    s_rready_next           =  1'b0;

    ff_wr_en_next           =  1'b0;
    ff_wr_data_next         =  ff_wr_data;

    if(~ff_wr_full)
    begin
      if(s_bvalid)
      begin
        s_bready_next       = 1'b1;
        ff_wr_en_next       = 1'b1;
        ff_wr_data_next.xtn = B_XTN;
        ff_wr_data_next.data[AXI4_B_STRUCT_W-1:0] = s_axi4_b_data;
      end
      else if(s_rvalid)
      begin
        s_rready_next       = 1'b1;
        ff_wr_en_next       = 1'b1;
        ff_wr_data_next.xtn = R_XTN;
        ff_wr_data_next.data[AXI4_R_STRUCT_W-1:0] = s_axi4_r_data;
      end
    end
  end

  assign  s_bready  =  s_bready_next;
  assign  s_rready  =  s_rready_next;

  /*  Instantiate FIFO  */
  generic_async_fifo #(
     .WRITE_WIDTH       (SHARED_CORE_STRUCT_W)
    ,.READ_WIDTH        (SHARED_CORE_STRUCT_W)
    ,.NUM_BITS          (SHARED_CORE_STRUCT_W*FIFO_DEPTH)
    ,.MEM_TYPE          (FIFO_MEM_TYPE)
    ,.NUM_SYNC_STAGES   (3)

  ) u_async_fifo  (

    /*  input  logic                    */   .wr_clk          (s_clk)
    /*  input  logic                    */  ,.wr_rst_n        (s_rst_n)
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

  assign  ff_rd_b_data  = ff_rd_data.data[AXI4_B_STRUCT_W-1:0];
  assign  ff_rd_r_data  = ff_rd_data.data[AXI4_R_STRUCT_W-1:0];

  /*  Instantitate FIFO to search for BID->Master ID  */
  axi_fabric_search_key #(
     .DATA_WIDTH    (MASTER_ID_W)
    ,.KEY_WIDTH     (RID_W)

    ,.MODE          ("MEM")

    ,.DISABLE_FLUSH (1)

  ) u_ingr2egr_b_master_id_search (

    /*  input  logic                  */   .clk             (core_clk)
    /*  input  logic                  */  ,.rst_n           (core_rst_n)

    /*  input  logic                  */  ,.wr_en           (ingr2egr_b_valid)
    /*  input  logic [DATA_WIDTH-1:0] */  ,.wr_data         (ingr2egr_b_data.master_id)
    /*  input  logic [KEY_WIDTH-1:0]  */  ,.wr_key          (ingr2egr_b_data.axi_id)
    /*  output logic                  */  ,.full            ()
    /*  output logic                  */  ,.afull           (ingr2egr_b_master_id_search_ff_full)

    /*  input  logic                  */  ,.search_en       (ingr2egr_b_search_en)
    /*  input  logic [KEY_WIDTH-1:0]  */  ,.search_key      (ingr2egr_b_search_data.axi_id)
    /*  output logic                  */  ,.search_found    (ingr2egr_b_search_found)
    /*  output logic                  */  ,.search_miss     ()
    /*  output logic [DATA_WIDTH-1:0] */  ,.search_result   (ingr2egr_b_search_result.master_id)

  );

  assign  ingr2egr_b_ready  = ~ingr2egr_b_master_id_search_ff_full;

  assign  ingr2egr_b_search_data.master_id = {MASTER_ID_W{1'b0}};
  assign  ingr2egr_b_search_data.axi_id    = ff_rd_b_data.bid;


  /*  Instantitate FIFO to search for RID->Master ID  */
  axi_fabric_search_key #(
     .DATA_WIDTH    (MASTER_ID_W)
    ,.KEY_WIDTH     (RID_W)

    ,.MODE          ("MEM")

    ,.DISABLE_FLUSH (1)

  ) u_ingr2egr_r_master_id_search (

    /*  input  logic                  */   .clk             (core_clk)
    /*  input  logic                  */  ,.rst_n           (core_rst_n)

    /*  input  logic                  */  ,.wr_en           (ingr2egr_r_valid)
    /*  input  logic [DATA_WIDTH-1:0] */  ,.wr_data         (ingr2egr_r_data.master_id)
    /*  input  logic [KEY_WIDTH-1:0]  */  ,.wr_key          (ingr2egr_r_data.axi_id)
    /*  output logic                  */  ,.full            ()
    /*  output logic                  */  ,.afull           (ingr2egr_r_master_id_search_ff_full)

    /*  input  logic                  */  ,.search_en       (ingr2egr_r_search_en)
    /*  input  logic [KEY_WIDTH-1:0]  */  ,.search_key      (ingr2egr_r_search_data.axi_id)
    /*  output logic                  */  ,.search_found    (ingr2egr_r_search_found)
    /*  output logic                  */  ,.search_miss     ()
    /*  output logic [DATA_WIDTH-1:0] */  ,.search_result   (ingr2egr_r_search_result.master_id)

  );

  assign  ingr2egr_r_ready  = ~ingr2egr_r_master_id_search_ff_full;

  assign  ingr2egr_r_search_data.master_id = {MASTER_ID_W{1'b0}};
  assign  ingr2egr_r_search_data.axi_id    = ff_rd_r_data.rid;


  /*  Master Interface Pipe  */
  always@(posedge core_clk, negedge core_rst_n)
  begin
    if(~core_rst_n)
    begin
      fsm_pstate          <=  IDLE_S;
      curr_master_id      <=  {MASTER_ID_W{1'b0}};

      core_egr_valid      <=  {NUM_MASTERS{1'b0}};
      core_egr_data       <=  {SHARED_CORE_STRUCT_W{1'b0}};
    end
    else
    begin
      fsm_pstate          <=  fsm_next_state;
      curr_master_id      <=  curr_master_id_next;

      core_egr_valid      <=  core_egr_valid_next;
      core_egr_data       <=  core_egr_data_next;
    end
  end

  assign  core_egr_r_data = core_egr_data.data[AXI4_R_STRUCT_W-1:0];


  always_comb
  begin
    fsm_next_state        = fsm_pstate;
    curr_master_id_next   = curr_master_id;

    core_egr_valid_next   = {NUM_MASTERS{1'b0}};
    core_egr_data_next    = core_egr_data;

    ff_rd_en              = 1'b0;
    ingr2egr_b_search_en  = 1'b0;
    ingr2egr_r_search_en  = 1'b0;

    case(fsm_pstate)

      IDLE_S:
      begin
        if(~ff_rd_empty)
        begin
          if(ff_rd_data.xtn == B_XTN)
          begin
            ingr2egr_b_search_en  = 1'b1;
            fsm_next_state        = SEARCH_BID_S;
          end
          else if(ff_rd_data.xtn == R_XTN)
          begin
            ingr2egr_r_search_en  = 1'b1;
            fsm_next_state        = SEARCH_RID_S;
          end
        end
      end

      SEARCH_BID_S:
      begin
        if(ingr2egr_b_search_found)
        begin
          ff_rd_en                = 1'b1;
          curr_master_id_next     = ingr2egr_b_search_result.master_id;
          core_egr_valid_next[curr_master_id_next] = 1'b1;
          core_egr_data_next      = ff_rd_data;
          fsm_next_state          = SEND_BRESP_S;
        end
      end

      SEND_BRESP_S:
      begin
        if(core_egr_ready[curr_master_id])
        begin
          fsm_next_state          = IDLE_S;
        end
        else
        begin
          core_egr_valid_next     = core_egr_valid;
        end
      end

      SEARCH_RID_S:
      begin
        if(ingr2egr_r_search_found)
        begin
          ff_rd_en                = 1'b1;
          curr_master_id_next     = ingr2egr_r_search_result.master_id;
          core_egr_valid_next[curr_master_id_next] = 1'b1;
          core_egr_data_next      = ff_rd_data;
          fsm_next_state          = SEND_RRESP_S;
        end
      end

      SEND_RRESP_S:
      begin
        if(core_egr_valid[curr_master_id])
        begin
          if(core_egr_ready[curr_master_id])
          begin
            if(core_egr_r_data.rlast)
            begin
              ff_rd_en            = 1'b0;
              fsm_next_state      = IDLE_S;
            end
            else if(~ff_rd_empty) //Load next data
            begin
              ff_rd_en            = 1'b1;
              core_egr_data_next  = ff_rd_data;
              core_egr_valid_next[curr_master_id] = 1'b1;
            end
          end
          else //Hold until ready
          begin
            core_egr_data_next    = core_egr_data;
            core_egr_valid_next[curr_master_id] = 1'b1;
          end
        end
        else if(~ff_rd_empty) //Load next data
        begin
          ff_rd_en                = 1'b1;
          core_egr_data_next      = ff_rd_data;
          core_egr_valid_next[curr_master_id] = 1'b1;
        end
      end

    endcase
  end



endmodule // axim_fabric_cbar_slave_shared_egr_node
