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
 -- Module Name       : axim_fabric_cbar_slave_node
 -- Author            : Gregory James
 -- Associated modules: 
 -- Function          : A wrapper containing all the AW,W,AR,B & R sub-nodes
                        for a Slave.
 --------------------------------------------------------------------------
*/

`timescale 1ns / 10ps

`include  "axim_fabric_common_defines.svh"

module axim_fabric_cbar_slave_node #(
//----------------------- Global parameters Declarations ------------------
  `include  "axim_fabric_aw_params_decl.svh"
  ,
  `include  "axim_fabric_w_params_decl.svh"
  ,
  `include  "axim_fabric_ar_params_decl.svh"
  ,
  `include  "axim_fabric_b_params_decl.svh"
  ,
  `include  "axim_fabric_r_params_decl.svh"

  ,parameter  NUM_MASTERS     = 4
  ,parameter  MASTER_ID_W     = (NUM_MASTERS > 1) ? $clog2(NUM_MASTERS) : 1

  ,parameter          FIFO_DEPTH      = 128
  ,parameter  string  FIFO_MEM_TYPE   = "BRAM"


) (
//----------------------- Master Side Interface -----------------------------
   input  core_clk
  ,input  core_rst_n

  ,input  core_aw_valid
  ,output core_aw_ready
  ,input  core_aw_data

  ,input  core_w_valid
  ,output core_w_ready
  ,input  core_w_data

  ,input  core_ar_valid
  ,output core_ar_ready
  ,input  core_ar_data

  ,output core_b_valid
  ,input  core_b_ready
  ,output core_b_data

  ,output core_r_valid
  ,input  core_r_ready
  ,output core_r_data

//----------------------- Slave Side AXI4 Interface ------------------------
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


);

//----------------------- Global Data Types -------------------------------
  `_create_axi4_aw_struct_t(axi4_aw_struct_t,AWID_W,AWADDR_W,AWLEN_W,AWSIZE_W,AWBURST_W,AWLOCK_W,AWCACHE_W,AWPROT_W,AWQOS_W,AWREGION_W,AWUSER_W)
  `_create_axi4_w_struct_t(axi4_w_struct_t,WID_W,WDATA_W,WSTRB_W,WLAST_W,WUSER_W)
  `_create_axi4_ar_struct_t(axi4_ar_struct_t,ARID_W,ARADDR_W,ARLEN_W,ARSIZE_W,ARBURST_W,ARLOCK_W,ARCACHE_W,ARPROT_W,ARQOS_W,ARREGION_W,ARUSER_W)
  `_create_axi4_b_struct_t(axi4_b_struct_t,BID_W,BRESP_W,BUSER_W)
  `_create_axi4_r_struct_t(axi4_r_struct_t,RID_W,RDATA_W,RRESP_W,RLAST_W,RUSER_W)
  `_create_axi4_ingr2egr_b_struct_t(axi4_ingr2egr_b_struct_t,MASTER_ID_W,AWID_W)
  `_create_axi4_ingr2egr_r_struct_t(axi4_ingr2egr_r_struct_t,MASTER_ID_W,RID_W)


//----------------------- Port Types -------------------------------------
  logic                     core_clk;
  logic                     core_rst_n;

  logic [NUM_MASTERS-1:0]   core_aw_valid;
  logic [NUM_MASTERS-1:0]   core_aw_ready;
  axi4_aw_struct_t          core_aw_data  [NUM_MASTERS-1:0];

  logic [NUM_MASTERS-1:0]   core_w_valid;
  logic [NUM_MASTERS-1:0]   core_w_ready;
  axi4_w_struct_t           core_w_data  [NUM_MASTERS-1:0];

  logic [NUM_MASTERS-1:0]   core_ar_valid;
  logic [NUM_MASTERS-1:0]   core_ar_ready;
  axi4_ar_struct_t          core_ar_data  [NUM_MASTERS-1:0];

  logic [NUM_MASTERS-1:0]   core_b_valid;
  logic [NUM_MASTERS-1:0]   core_b_ready;
  axi4_b_struct_t           core_b_data;

  logic [NUM_MASTERS-1:0]   core_r_valid;
  logic [NUM_MASTERS-1:0]   core_r_ready;
  axi4_r_struct_t           core_r_data;


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


//----------------------- Import Packages ---------------------------------


//----------------------- Internal Parameters -----------------------------


//----------------------- Internal Register Declarations ------------------
  logic [MASTER_ID_W-1:0]   curr_master_id,   curr_master_id_next;
  logic [NUM_MASTERS-1:0]   curr_masters_sel, curr_masters_sel_next;

  logic                     aw_ingr_arb_gnt_valid,  aw_ingr_arb_gnt_valid_next;
  logic                     ar_ingr_arb_gnt_valid,  ar_ingr_arb_gnt_valid_next;
  logic                     w_ingr_arb_gnt_valid,   w_ingr_arb_gnt_valid_next;


//----------------------- Internal Wire Declarations ----------------------
  logic                     aw_ingr_ff_wr_full;
  logic                     ar_ingr_ff_wr_full;
  logic                     w_ingr_ff_wr_full;
  logic [NUM_MASTERS-1:0]   arb_agent_req;
  logic                     arb_gnt_valid;
  logic [MASTER_ID_W-1:0]   arb_gnt_agent_id;
  logic [NUM_MASTERS-1:0]   arb_gnt_agents_sel;

  logic                     ingr2egr_b_valid;
  axi4_ingr2egr_b_struct_t  ingr2egr_b_data;
  logic                     ingr2egr_b_ready;

  logic                     ingr2egr_r_valid;
  axi4_ingr2egr_r_struct_t  ingr2egr_r_data;
  logic                     ingr2egr_r_ready;


//----------------------- FSM Register Declarations ------------------
  enum  logic [1:0] {
    IDLE_S           = 2'b00,
    WAIT_FOR_WLAST_S = 2'b01,
    WAIT_FOR_RLAST_S = 2'b10
  } fsm_pstate, fsm_next_state;



//----------------------- Start of Code -----------------------------------

  /*  Common Arbiter for all Ingress channels of this slave */
  axi_fabric_arb #(
     .NUM_AGENTS    (NUM_MASTERS)
    ,.AGENT_ID_W    (MASTER_ID_W)
    ,.PRIORITY_W    (2)
    ,.MODE          ("NORMAL")

  ) u_axi_fabric_arb  (

    /*  input  logic                          */   .clk                 (core_clk)
    /*  input  logic                          */  ,.rst_n               (core_rst_n)

    /*  input  logic [NUM_AGENTS-1:0]         */  ,.agent_req           (arb_agent_req)

    /*  output logic                          */  ,.gnt_valid           ()
    /*  output logic [AGENT_ID_W-1:0]         */  ,.gnt_agent_id        ()
    /*  output logic [NUM_AGENTS-1:0]         */  ,.gnt_agent_sel       ()

    /*  output logic                          */  ,.gnt_valid_next      (arb_gnt_valid)
    /*  output logic [AGENT_ID_W-1:0]         */  ,.gnt_agent_id_next   (arb_gnt_agent_id)
    /*  output logic [NUM_AGENTS-1:0]         */  ,.gnt_agent_sel_next  (arb_gnt_agents_sel)

  );


  /*  AW Node */
  axim_fabric_cbar_slave_aw_ingr_node #(
    `include  "axim_fabric_aw_params_inst.svh"

    ,.NUM_MASTERS         (NUM_MASTERS  )
    ,.MASTER_ID_W         (MASTER_ID_W  )

    ,.FIFO_DEPTH          (FIFO_DEPTH   )
    ,.FIFO_MEM_TYPE       (FIFO_MEM_TYPE)

  ) u_aw_ingr_node  (

     .core_clk            (core_clk          )
    ,.core_rst_n          (core_rst_n        )

    ,.ff_wr_full          (aw_ingr_ff_wr_full     )
    ,.arb_gnt_valid       (aw_ingr_arb_gnt_valid  )
    //,.arb_gnt_agent_id    (arb_gnt_agent_id       )
    //,.arb_gnt_agents_sel  (arb_gnt_agents_sel     )
    ,.arb_gnt_agent_id    (curr_master_id         )
    ,.arb_gnt_agents_sel  (curr_masters_sel       )

    ,.core_aw_valid       (core_aw_valid     )
    ,.core_aw_ready       (core_aw_ready     )
    ,.core_aw_data        (core_aw_data      )

    ,.ingr2egr_b_valid    (ingr2egr_b_valid  )
    ,.ingr2egr_b_data     (ingr2egr_b_data   )
    ,.ingr2egr_b_ready    (ingr2egr_b_ready  )

    ,.s_clk               (s_clk             )
    ,.s_rst_n             (s_rst_n           )

    ,.s_awvalid           (s_awvalid         )
    ,.s_awready           (s_awready         )
    ,.s_awid              (s_awid            )
    ,.s_awaddr            (s_awaddr          )
    ,.s_awlen             (s_awlen           )
    ,.s_awsize            (s_awsize          )
    ,.s_awburst           (s_awburst         )
    ,.s_awlock            (s_awlock          )
    ,.s_awcache           (s_awcache         )
    ,.s_awprot            (s_awprot          )
    ,.s_awqos             (s_awqos           )
    ,.s_awregion          (s_awregion        )
    ,.s_awuser            (s_awuser          )

  );

  /*  W Node  */
  axim_fabric_cbar_slave_w_ingr_node #(
    `include  "axim_fabric_w_params_inst.svh"

    ,.NUM_MASTERS         (NUM_MASTERS  )
    ,.MASTER_ID_W         (MASTER_ID_W  )

    ,.FIFO_DEPTH          (FIFO_DEPTH   )
    ,.FIFO_MEM_TYPE       (FIFO_MEM_TYPE)

  ) u_w_ingr_node (

     .core_clk            (core_clk        )
    ,.core_rst_n          (core_rst_n      )

    ,.ff_wr_full          (w_ingr_ff_wr_full      )
    ,.arb_gnt_valid       (w_ingr_arb_gnt_valid   )
    //,.arb_gnt_agent_id    (arb_gnt_agent_id       )
    //,.arb_gnt_agents_sel  (arb_gnt_agents_sel     )
    ,.arb_gnt_agent_id    (curr_master_id         )
    ,.arb_gnt_agents_sel  (curr_masters_sel       )

    ,.core_w_valid        (core_w_valid    )
    ,.core_w_ready        (core_w_ready    )
    ,.core_w_data         (core_w_data     )

    ,.s_clk               (s_clk           )
    ,.s_rst_n             (s_rst_n         )

    ,.s_wvalid            (s_wvalid        )
    ,.s_wready            (s_wready        )
    ,.s_wid               (s_wid           )
    ,.s_wdata             (s_wdata         )
    ,.s_wstrb             (s_wstrb         )
    ,.s_wlast             (s_wlast         )
    ,.s_wuser             (s_wuser         )

  );

  /*  AR Node */
  axim_fabric_cbar_slave_ar_ingr_node #(
    `include  "axim_fabric_ar_params_inst.svh"

    ,.NUM_MASTERS         (NUM_MASTERS  )
    ,.MASTER_ID_W         (MASTER_ID_W  )

    ,.FIFO_DEPTH          (FIFO_DEPTH   )
    ,.FIFO_MEM_TYPE       (FIFO_MEM_TYPE)

  ) u_ar_ingr_node  (

     .core_clk            (core_clk          )
    ,.core_rst_n          (core_rst_n        )

    ,.ff_wr_full          (ar_ingr_ff_wr_full     )
    ,.arb_gnt_valid       (ar_ingr_arb_gnt_valid  )
    //,.arb_gnt_agent_id    (arb_gnt_agent_id       )
    //,.arb_gnt_agents_sel  (arb_gnt_agents_sel     )
    ,.arb_gnt_agent_id    (curr_master_id         )
    ,.arb_gnt_agents_sel  (curr_masters_sel       )

    ,.core_ar_valid       (core_ar_valid     )
    ,.core_ar_ready       (core_ar_ready     )
    ,.core_ar_data        (core_ar_data      )

    ,.ingr2egr_r_valid    (ingr2egr_r_valid  )
    ,.ingr2egr_r_data     (ingr2egr_r_data   )
    ,.ingr2egr_r_ready    (ingr2egr_r_ready  )

    ,.s_clk               (s_clk             )
    ,.s_rst_n             (s_rst_n           )

    ,.s_arvalid           (s_arvalid         )
    ,.s_arready           (s_arready         )
    ,.s_arid              (s_arid            )
    ,.s_araddr            (s_araddr          )
    ,.s_arlen             (s_arlen           )
    ,.s_arsize            (s_arsize          )
    ,.s_arburst           (s_arburst         )
    ,.s_arlock            (s_arlock          )
    ,.s_arcache           (s_arcache         )
    ,.s_arprot            (s_arprot          )
    ,.s_arqos             (s_arqos           )
    ,.s_arregion          (s_arregion        )
    ,.s_aruser            (s_aruser          )

  );

  /*  B Node  */
  axim_fabric_cbar_slave_b_egr_node #(
    `include  "axim_fabric_b_params_inst.svh"

    ,.NUM_MASTERS       (NUM_MASTERS  )
    ,.MASTER_ID_W       (MASTER_ID_W  )

    ,.FIFO_DEPTH        (FIFO_DEPTH   )
    ,.FIFO_MEM_TYPE     (FIFO_MEM_TYPE)

  ) u_b_egr_node  (

     .s_clk             (s_clk             )
    ,.s_rst_n           (s_rst_n           )

    ,.s_bvalid          (s_bvalid          )
    ,.s_bready          (s_bready          )
    ,.s_bid             (s_bid             )
    ,.s_bresp           (s_bresp           )
    ,.s_buser           (s_buser           )

    ,.ingr2egr_b_valid  (ingr2egr_b_valid  )
    ,.ingr2egr_b_data   (ingr2egr_b_data   )
    ,.ingr2egr_b_ready  (ingr2egr_b_ready  )

    ,.core_clk          (core_clk          )
    ,.core_rst_n        (core_rst_n        )

    ,.core_b_valid      (core_b_valid      )
    ,.core_b_ready      (core_b_ready      )
    ,.core_b_data       (core_b_data       )


  );

  /*  R Node  */
  axim_fabric_cbar_slave_r_egr_node #(
    `include  "axim_fabric_r_params_inst.svh"

    ,.NUM_MASTERS       (NUM_MASTERS  )
    ,.MASTER_ID_W       (MASTER_ID_W  )

    ,.FIFO_DEPTH        (FIFO_DEPTH   )
    ,.FIFO_MEM_TYPE     (FIFO_MEM_TYPE)

  ) u_r_egr_node  (

     .s_clk               (s_clk               )
    ,.s_rst_n             (s_rst_n             )

    ,.s_rvalid            (s_rvalid            )
    ,.s_rready            (s_rready            )
    ,.s_rid               (s_rid               )
    ,.s_rdata             (s_rdata             )
    ,.s_rresp             (s_rresp             )
    ,.s_rlast             (s_rlast             )
    ,.s_ruser             (s_ruser             )

    ,.ingr2egr_r_valid    (ingr2egr_r_valid    )
    ,.ingr2egr_r_data     (ingr2egr_r_data     )
    ,.ingr2egr_r_ready    (ingr2egr_r_ready    )

    ,.core_clk            (core_clk            )
    ,.core_rst_n          (core_rst_n          )

    ,.core_r_valid        (core_r_valid        )
    ,.core_r_ready        (core_r_ready        )
    ,.core_r_data         (core_r_data         )

  );



  /*
    Ingress Master Lock Logic
  */
  always@(posedge  core_clk, negedge core_rst_n)
  begin
    if(~core_rst_n)
    begin
      fsm_pstate            <=  IDLE_S;
      curr_master_id        <=  {MASTER_ID_W{1'b0}};
      curr_masters_sel      <=  {NUM_MASTERS{1'b0}};
      aw_ingr_arb_gnt_valid <=  1'b0;
      ar_ingr_arb_gnt_valid <=  1'b0;
      w_ingr_arb_gnt_valid  <=  1'b0;
    end
    else
    begin
      fsm_pstate            <=  fsm_next_state;
      curr_master_id        <=  curr_master_id_next;
      curr_masters_sel      <=  curr_masters_sel_next;

      aw_ingr_arb_gnt_valid <=  aw_ingr_arb_gnt_valid_next;
      ar_ingr_arb_gnt_valid <=  ar_ingr_arb_gnt_valid_next;
      w_ingr_arb_gnt_valid  <=  w_ingr_arb_gnt_valid_next;
    end
  end

  always_comb
  begin
    fsm_next_state              = fsm_pstate;
    curr_master_id_next         = curr_master_id;
    curr_masters_sel_next       = curr_masters_sel;

    arb_agent_req               = {NUM_MASTERS{1'b0}};
    aw_ingr_arb_gnt_valid_next  = 1'b0;
    w_ingr_arb_gnt_valid_next   = 1'b0;
    ar_ingr_arb_gnt_valid_next  = 1'b0;

    case(fsm_pstate)

      IDLE_S:
      begin
        if((core_aw_valid  !=  {NUM_MASTERS{1'b0}}) && ~aw_ingr_ff_wr_full)
        begin
          arb_agent_req               = core_aw_valid;
          aw_ingr_arb_gnt_valid_next  = arb_gnt_valid;

          if(arb_gnt_valid)
          begin
            curr_master_id_next       = arb_gnt_agent_id;
            curr_masters_sel_next     = arb_gnt_agents_sel;
            fsm_next_state            = WAIT_FOR_WLAST_S;
          end
        end
        else if((core_ar_valid  !=  {NUM_MASTERS{1'b0}}) && ~ar_ingr_ff_wr_full)
        begin
          arb_agent_req               = core_ar_valid;
          ar_ingr_arb_gnt_valid_next  = arb_gnt_valid;

          if(arb_gnt_valid)
          begin
            curr_master_id_next       = arb_gnt_agent_id;
            curr_masters_sel_next     = arb_gnt_agents_sel;
            //fsm_next_state            = WAIT_FOR_RLAST_S;
            fsm_next_state            = IDLE_S;
          end
        end
      end

      WAIT_FOR_WLAST_S:
      begin
        if(core_w_valid[curr_master_id] && ~w_ingr_ff_wr_full)
        begin
          w_ingr_arb_gnt_valid_next   = 1'b1;

          if(core_w_data[curr_master_id].wlast)
          begin
            fsm_next_state            = IDLE_S;
          end
        end
      end

      WAIT_FOR_RLAST_S:
      begin
        if(core_r_valid[curr_master_id] && core_r_ready[curr_master_id])
        begin
          if(core_r_data.rlast)
          begin
            fsm_next_state            = IDLE_S;
          end
        end
      end


    endcase
  end


endmodule // axim_fabric_cbar_slave_node
