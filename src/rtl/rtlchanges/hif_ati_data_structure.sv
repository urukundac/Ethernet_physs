///  INTEL TOP SECRET
///
///  Copyright 2018 Intel Corporation All Rights Reserved.
///
///  The source code contained or described herein and all documents related
///  to the source code (Material) are owned by Intel Corporation or its
///  suppliers or licensors. Title to the Material remains with Intel
///  Corporation or its suppliers and licensors. The Material contains trade
///  secrets and proprietary and confidential information of Intel or its
///  suppliers and licensors. The Material is protected by worldwide copyright
///  and trade secret laws and treaty provisions. No part of the Material may
///  be used, copied, reproduced, modified, published, uploaded, posted,
///  transmitted, distributed, or disclosed in any way without Intel's prior
///  transmitted, distributed, or disclosed in any way without Intel's prior
///  express written permission.
///
///  No license under any patent, copyright, trade secret or other intellectual
///  property right is granted to or conferred upon you by disclosure or
///  delivery of the Materials, either expressly, by implication, inducement,
///  estoppel or otherwise. Any license under such intellectual property rights
///  must be express and approved by Intel in writing.
///  Inserted by Intel DSD.

/************************************************************************/
//  Copyright (c) Intel Corporation All Rights Reserved
`include "ecip_gen_macros.def"
module hif_ati_data_structure
    import hif_common_package::*;
    import hif_fabif_package::*;
    import hif_dwc_package::*;
    import hif_upp_package::*;
    import hif_upp_regs_pkg::*;
    import intel_checkers_pkg::*;
    #(
    parameter ATI_BUF_RD_LATENCY = 3,
    parameter bit CMD_ESLL_LIST_MEM_SAMP  = 1'b1,
    parameter bit CMD_ESLL_DATA_MEM_SAMP  = 1'b1,
    parameter bit DATA_ESLL_LIST_MEM_SAMP = 1'b1,
    parameter bit DATA_ESLL_DATA_MEM_SAMP = 1'b1
    )    (
     input clk ,
     input rst_n ,
     input pcie_upp_init_done ,
     input logic [UPP_NUM_OF_DEST_PORTS - 1 : 0] port_is_usp,

     // ordering i/f with ETP
     input        [$clog2(UPP_NUM_OF_ORDERING_DOMAINS) - 1 : 0] etp_upp_queue_id ,
     input                                                      etp_upp_queue_id_valid ,
     input  logic [2 - 1 : 0]                                   etp_upp_queue_id_rd_wr ,

     input [UPP_NUM_OF_ORDERING_DOMAINS - 1:0]    queue_corer_block,
     // from ETP
     input                                          [UPP_NUM_OF_ORDERING_DOMAINS - 1 : 0][OD_UPP_PARAMS_W - 1 : 0]        etp_upp_od_params ,
     output [NUM_OF_LISTS - 1 : 0][DATA_ESLL_ADDR_W - 1 : 0] vsb_snapshot_ati_data_structure_data_esll_lists_length,
     output [NUM_OF_LISTS - 1 : 0][CMD_ESLL_ADDR_W - 1 : 0]  vsb_snapshot_ati_data_structure_cmd_esll_lists_length,
     

     // interface with ESLL wr control
     input              ati_trans_vld ,
     input  upp_trans_t ati_trans ,
     output             ati_trans_rdy ,

     // indicatoins to reaset logic
     output ati_esll_logic_empty ,

     output logic [UPP_NUM_OF_DEST_PORTS - 1 : 0] all_lists_of_port_empty ,
     output logic [UPP_NUM_OF_DEST_PORTS - 1 : 0] [2*UPP_NUM_OF_ORDERING_DOMAINS - 1 : 0] list_of_port_empty ,

     // i/f with pop out logic
     input                               [UPP_NUM_OF_DEST_PORTS - 1 : 0] selected_queue_info_valid ,
     input upp_ati_selected_queue_info_t [UPP_NUM_OF_DEST_PORTS - 1 : 0] selected_queue_info ,
     output                              [UPP_NUM_OF_ORDERING_DOMAINS - 1 : 0]             order_add_rdy_out,
     output                                                                                rd_wr_ord_queues_ready,

     input upp_ati_queue_info_t sent_queue_info ,
     input                      sent_queue_info_valid ,

     input [NUM_OF_LISTS - 1 : 0]   dec_pop_list ,
     input                          cmd_esll_rd_en ,
     input [NUM_OF_LISTS_W - 1 : 0] pop_list ,

     input [NUM_OF_LISTS - 1 : 0]   dec_data_pop_list ,
     input                          data_esll_rd_en ,
     input [NUM_OF_LISTS_W - 1 : 0] data_esll_rd_idx ,

     output                          [UPP_NUM_OF_ORDERING_DOMAINS - 1 : 0]               can_send_rd ,
     output upp_ati_data_structure_t [CMD_ESLL_DEPTH - 1 : 0]                            trans_status ,
     output                          [NUM_OF_LISTS - 1 : 0][CMD_ESLL_ADDR_W - 1 : 0]     cmd_esll_list_head_ps ,
     output                          [NUM_OF_LISTS - 1 : 0]                              cmd_esll_head_vld_ps ,

     output upp_trans_t esll_rd_data ,
     output logic       esll_rd_data_vld ,

     input  logic [NUM_OF_LISTS - 1 : 0]                          cmd_esll_peek_next_list_head ,
     output logic [NUM_OF_LISTS - 1 : 0]                          cmd_esll_peeked_next_list_head_vld ,
     output logic [NUM_OF_LISTS - 1 : 0][CMD_ESLL_ADDR_W - 1 : 0] cmd_esll_peeked_next_list_head_data ,
     output cmd_esll_sb_t [NUM_OF_LISTS - 1 : 0]                  cmd_esll_peeked_next_list_head_sb_data,

     // i/f with CSR's
     input  UPP_OD_QOS_CTRL_REG_t                                  [UPP_NUM_OF_ORDERING_DOMAINS - 1 : 0]   UPP_OD_QOS_CTRL_REG ,
     output new_UPP_ATI_DFD_STATUS_REG_t                           [5 : 0]                                 new_UPP_ATI_DFD_STATUS_REG ,
     output logic [UPP_NUM_OF_ORDERING_DOMAINS - 1 : 0]                                                          GLPCI_NPQ_CLNT_CFG,

     // i/f to memory


     input hif_ati_cmd_esll_data_mem_ecc_uncor_err ,
     input hif_ati_data_esll_data_mem_ecc_uncor_err ,
     input hif_ati_data_esll_list_mem_ecc_uncor_err ,
     input hif_ati_cmd_esll_list_mem_ecc_uncor_err ,

     input hif_ati_cmd_esll_data_mem_init_done ,
     input hif_ati_data_esll_data_mem_init_done ,
     input hif_ati_data_esll_list_mem_init_done ,
     input hif_ati_cmd_esll_list_mem_init_done ,

     // cmd esll data
     // rd
     output [CMD_ESLL_ADDR_W - 1 : 0] hif_ati_cmd_esll_data_mem_rd_adr ,
     output                           hif_ati_cmd_esll_data_mem_rd_en ,

     input [CMD_ESLL_WIDTH - 1 : 0] hif_ati_cmd_esll_data_mem_rd_data ,
     input                          hif_ati_cmd_esll_data_mem_rd_valid ,

     // wr
     output [CMD_ESLL_ADDR_W - 1 : 0] hif_ati_cmd_esll_data_mem_wr_adr ,
     output [CMD_ESLL_WIDTH - 1 : 0]  hif_ati_cmd_esll_data_mem_wr_data ,
     output                           hif_ati_cmd_esll_data_mem_wr_en ,

    // cmd esll list
    // rd
    output [CMD_ESLL_ADDR_W - 1 : 0] hif_ati_cmd_esll_list_mem_rd_adr,
    output                           hif_ati_cmd_esll_list_mem_rd_en ,

    input [CMD_ESLL_ADDR_W + CMD_ESLL_SB_W - 1 : 0] hif_ati_cmd_esll_list_mem_rd_data ,
    input                           hif_ati_cmd_esll_list_mem_rd_valid,

    // wr
    output [CMD_ESLL_ADDR_W - 1 : 0] hif_ati_cmd_esll_list_mem_wr_adr,
    output [CMD_ESLL_ADDR_W + CMD_ESLL_SB_W - 1 : 0] hif_ati_cmd_esll_list_mem_wr_data,
    output                           hif_ati_cmd_esll_list_mem_wr_en,

     // data esll data
     // rd
     output [DATA_ESLL_ADDR_W - 1 : 0] hif_ati_data_esll_data_mem_rd_adr ,
     output                            hif_ati_data_esll_data_mem_rd_en ,

     input [DATA_ESLL_WIDTH - 1 : 0] hif_ati_data_esll_data_mem_rd_data ,
     input                           hif_ati_data_esll_data_mem_rd_valid ,

     // wr
     output [DATA_ESLL_ADDR_W - 1 : 0] hif_ati_data_esll_data_mem_wr_adr ,
     output [DATA_ESLL_WIDTH - 1 : 0]  hif_ati_data_esll_data_mem_wr_data ,
     output                            hif_ati_data_esll_data_mem_wr_en ,

     // data esll list
     // rd
     output [DATA_ESLL_ADDR_W - 1 : 0] hif_ati_data_esll_list_mem_rd_adr ,
     output                            hif_ati_data_esll_list_mem_rd_en ,

     input [DATA_ESLL_ADDR_W - 1 : 0] hif_ati_data_esll_list_mem_rd_data ,
     input                            hif_ati_data_esll_list_mem_rd_valid ,

     // wr
     output [DATA_ESLL_ADDR_W - 1 : 0] hif_ati_data_esll_list_mem_wr_adr ,
     output [DATA_ESLL_ADDR_W - 1 : 0] hif_ati_data_esll_list_mem_wr_data ,
     output                            hif_ati_data_esll_list_mem_wr_en ,

     output logic                  upp_npq_nss_empty,//13011968772
     input UPP_BEU_NSS_BLOCKED_t  UPP_BEU_NSS_BLOCKED
     `include "ati_data_structure_visa_if.sv"

    );


    upp_trans_t                                                     cmd_esll_wr_data;
    logic                                                           cmd_esll_wr_en;
    cmd_esll_data_t                                                 cmd_esll_wr_data_reduced;
    cmd_esll_data_t [NUM_OF_LISTS - 1 : 0]                          cmd_esll_rd_data_extended;
    logic                                                           cmd_esll_rd_data_vld;
    logic                                                           data_esll_rd_data_vld;
    logic           [NUM_OF_LISTS - 1 : 0][CMD_ESLL_ADDR_W - 1 : 0] cmd_esll_list_head;

    logic [CMD_ESLL_ADDR_W + CMD_ESLL_SB_W - 1 : 0] hif_ati_cmd_esll_list_mem_rd_data_delay;
    logic                           hif_ati_cmd_esll_list_mem_rd_valid_delay;


    etp_upp_tlp_data_t                                                 data_esll_wr_data;
    logic                                                              data_esll_wr_en;
    logic              [NUM_OF_LISTS - 1 : 0][DATA_ESLL_WIDTH - 1 : 0] data_esll_rd_data_extended;

// for full empty indication
    logic                                                  cmd_esll_wr_full;
    logic                                                  data_esll_wr_full;
    logic [NUM_OF_LISTS - 1 : 0]                           cmd_esll_rd_empty;
    logic [NUM_OF_LISTS - 1 : 0]                           data_esll_rd_empty;
    logic [CMD_ESLL_ADDR_W - 1 : 0]                        cmd_esll_used_space;
    logic [DATA_ESLL_ADDR_W - 1 : 0]                       data_esll_used_space;
    logic [NUM_OF_LISTS - 1 : 0][DATA_ESLL_ADDR_W - 1 : 0] data_esll_lists_length;
    logic [NUM_OF_LISTS - 1 : 0][CMD_ESLL_ADDR_W - 1 : 0]  cmd_esll_lists_length;

// NC signals
    logic [CMD_ESLL_ADDR_W - 1 : 0]                        cmd_esll_free_length_nc;
    logic [DATA_ESLL_ADDR_W - 1 : 0]                       data_esll_free_length_nc;
    logic [NUM_OF_LISTS - 1 : 0]                           data_esll_head_vld_ps_nc;
    logic [NUM_OF_LISTS - 1 : 0][DATA_ESLL_ADDR_W - 1 : 0] data_esll_list_head_nc;
    logic [NUM_OF_LISTS - 1 : 0][DATA_ESLL_ADDR_W - 1 : 0] data_esll_list_head_ps_nc;
    logic [DATA_ESLL_ADDR_W - 1 : 0]                       data_esll_next_free_nc;


    od_port_ate_sp_t [UPP_NUM_OF_ORDERING_DOMAINS - 1 : 0]                       od_params;
    
    logic [CMD_ESLL_ADDR_W - 1 : 0] cmd_esll_next_free;

///////////////////////////////////////////////////////////////////////////////////////////////////////
//              HTU Tracking status
///////////////////////////////////////////////////////////////////////////////////////////////////////

 logic [UPP_NUM_OF_ORDERING_DOMAINS -1:0] queue_packet_wip; // 0 - idle (no packet wip), 1 - packet wip ( refers to original packet before slicing)
 logic [UPP_NUM_OF_ORDERING_DOMAINS -1:0] queue_packet_wip_htu_on; // 0 - idle (no packet wip), 1 - packet wip ( refers to original packet before slicing)

    generate
        genvar od_id;
        for (od_id = 0; od_id < UPP_NUM_OF_ORDERING_DOMAINS; od_id = od_id + 1) begin : ordering_per_od

    always_ff @ (posedge clk or negedge rst_n) begin
        if (~rst_n) 
            queue_packet_wip[od_id]  <= '0;
        else if (queue_corer_block[od_id])
            queue_packet_wip[od_id]  <= '0;
         else if (cmd_esll_wr_en && !cmd_esll_wr_data.sb_attr.xali_sb.upp_sb.is_int && ( (cmd_esll_wr_data.tlp_cmd.tlp_type == Rq) | (cmd_esll_wr_data.tlp_cmd.tlp_type == RqLk)) && ((cmd_esll_wr_data.sb_attr.queue_id[UPP_NUM_OF_ORDERING_DOMAINS_W :0] - UPP_NUM_OF_ORDERING_DOMAINS ) == od_id))
            queue_packet_wip[od_id]  <= !cmd_esll_wr_data.sb_attr.last_slice;
    end // always FF

    always_ff @ (posedge clk or negedge rst_n) begin
        if (~rst_n) 
            queue_packet_wip_htu_on[od_id]  <= '0;
        else if (queue_corer_block[od_id])
            queue_packet_wip_htu_on[od_id]  <= '0;
         else if (cmd_esll_wr_en && ((cmd_esll_wr_data.sb_attr.queue_id[UPP_NUM_OF_ORDERING_DOMAINS_W :0] - UPP_NUM_OF_ORDERING_DOMAINS ) == od_id) && !queue_packet_wip[od_id]) // For first - need to sample htu-hit/gen-sep-dbl
            queue_packet_wip_htu_on[od_id]  <= (cmd_esll_wr_data.sb_attr.htu_info.htu_hit || cmd_esll_wr_data.sb_attr.xali_sb.upp_sb.gen_sep_dbl);
    end // always FF

        end
    endgenerate

///////////////////////////////////////////////////////////////////////////////////////////////////////
//              Ordering block
///////////////////////////////////////////////////////////////////////////////////////////////////////


    always_comb begin
        for (int i= 0;i<UPP_NUM_OF_ORDERING_DOMAINS;i++) begin
            GLPCI_NPQ_CLNT_CFG[i] = UPP_OD_QOS_CTRL_REG[i].RDWR_ORDER_EN;
        end
    end

    hif_ati_ordering #(
                       .NUM_OF_OD  (UPP_NUM_OF_ORDERING_DOMAINS  ) ,
                       .ORDER_DEPTH(UPP_ORDER_DEPTH              ) ,
                       .SYNC_ON    ('0                           )
                      )
    u_hif_ati_ordering (
                        // Inputs
                        .GLPCI_NPQ_CLNT_CFG         (GLPCI_NPQ_CLNT_CFG         ) ,
                        .queue_corer_block          (queue_corer_block          ) ,
                        .clk                        (clk                        ) ,
                        .queue_id                   (etp_upp_queue_id           ) ,
                        .queue_id_valid             (etp_upp_queue_id_valid     ) ,
                        .queue_id_rd_wr             (etp_upp_queue_id_rd_wr     ) ,
                        .rst_n                      (rst_n                      ) ,
                        .selected_queue_info        (selected_queue_info        ) ,
                        .order_add_rdy_out          (order_add_rdy_out          ),
                        .rd_wr_ord_queues_ready      (rd_wr_ord_queues_ready    ) , 
                        // sent indication from ATI
                        .selected_queue_info_valid  (selected_queue_info_valid  ) ,
                        // Outputs
                        .can_send_rd                (can_send_rd                )
                       );


///////////////////////////////////////////////////////////////////////////////////////////////////////////
//                Data structure status table
///////////////////////////////////////////////////////////////////////////////////////////////////////////

    hif_ati_data_structure_status u_hif_ati_data_structure_status (
                                                                   // Inputs
                                                                   .clk                 (clk                 ) ,
                                                                   .cmd_esll            (cmd_esll_wr_data    ) ,
                                                                   .cmd_esll_next_free  (cmd_esll_next_free  ) ,
                                                                   // interface with ESLL wr control
                                                                   .cmd_esll_wr_en      (cmd_esll_wr_en      ) ,
                                                                   .rst_n               (rst_n               ) ,
                                                                   // interface with command decoder
                                                                   // Outputs
                                                                   // interface to pop out logic
                                                                   .trans_status        (trans_status        )
                                                                  );

//////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                   CMD ESLL
//////////////////////////////////////////////////////////////////////////////////////////////////////////////

// cmd esll wr i/f

    assign cmd_esll_wr_en         = ati_trans_vld && ati_trans.tlp_cmd.tlp_hv;

    always_comb begin 
        cmd_esll_wr_data                         = ati_trans;
    end

//    always_comb begin
//        for (int list_idx = 0;list_idx < NUM_OF_LISTS;list_idx++) begin
//            cmd_esll_wr_idx_dec_and_qual[list_idx] = (list_idx == cmd_esll_wr_data.sb_attr.queue_id) & cmd_esll_wr_en;
//        end // for int l...
//    end

// cmd esll read i/f

//    always_comb begin
//        for (int list_idx = 0;list_idx < NUM_OF_LISTS;list_idx++) begin
//            cmd_esll_rd_idx_dec_and_qual[list_idx] = dec_pop_list[list_idx] & cmd_esll_rd_en;
//        end // for int l...
//    end

    localparam CMD_ESLL_POINTER_NUM_OF_PF_PER_LIST  = 4;
    localparam CMD_ESLL_POINTER_EXTRA_LATENCY       = CMD_ESLL_POINTER_NUM_OF_PF_PER_LIST - 2; // 2 is typical rd latency so the extra latency is the num of Prefatch - 2
    localparam POP_OUT_ARB_PIPELINE_DEPTH           = 4;

    assign cmd_esll_wr_data_reduced.rsvd      =  '0;
    assign cmd_esll_wr_data_reduced.tlp_cmd   =  cmd_esll_wr_data.tlp_cmd;
    assign cmd_esll_wr_data_reduced.sb_attr   =  cmd_esll_wr_data.sb_attr;
    assign cmd_esll_wr_data_reduced.ati_src   =  cmd_esll_wr_data.ati_src;
    assign cmd_esll_wr_data_reduced.trap_info =  cmd_esll_wr_data.trap_info;


    // Add delay to CMD PMEM rd data as we want extra prefatch


    hif_upp_bus_delay #(
                        .DELAY    (CMD_ESLL_POINTER_EXTRA_LATENCY) ,
                        .WIDTH    (CMD_ESLL_ADDR_W + CMD_ESLL_SB_W )
                       )
    u_hif_upp_bus_delay (
                         // Inputs
                         .bus_in     (hif_ati_cmd_esll_list_mem_rd_data       ) ,
                         .bus_vld_in (hif_ati_cmd_esll_list_mem_rd_valid      ) ,
                         .clk        (clk                                     ) ,
                         .rst_n      (rst_n                                   ) ,
                         // Outputs
                         .bus_out    (hif_ati_cmd_esll_list_mem_rd_data_delay ) ,
                         .bus_vld_out(hif_ati_cmd_esll_list_mem_rd_valid_delay)
                        );

   cmd_esll_sb_t cmd_esll_wr_data_sb;
   cmd_esll_sb_t [NUM_OF_LISTS - 1 : 0]  cmd_esll_list_head_sb;                           
   cmd_esll_sb_t [NUM_OF_LISTS - 1 : 0]  cmd_esll_list_head_sb_ps;                           

   logic is_comp;
   logic is_int;
   pcie_fmt_type_fields_encoding_type_e req_type;
   logic is_read;
   logic is_write;
   logic [12:0] cmd_esll_wr_data_size;
   logic [12:0] rd_wr_cmd_esll_wr_data_size;
   logic [UPP_NUM_OF_ORDERING_DOMAINS_W:0] cmd_wr_queue_id; 
   logic [UPP_NUM_OF_ORDERING_DOMAINS_W:0] cmd_rd_queue_id; 
//   logic [13-1:0] cmd_rd_byte_length; 
   logic [UPP_NUM_OF_ORDERING_DOMAINS_W:0] data_wr_queue_id; 
   logic [UPP_NUM_OF_ORDERING_DOMAINS_W:0] data_rd_queue_id; 

   assign is_comp  = (req_type == Cpl) || (req_type == CplD) || (req_type == CplDLk) || (req_type == CplLk);
   assign is_int   = cmd_esll_wr_data.sb_attr.xali_sb.upp_sb.is_int;
   assign req_type = pcie_fmt_type_fields_encoding_type_e'({cmd_esll_wr_data.tlp_cmd.tlp_fmt , cmd_esll_wr_data.tlp_cmd.tlp_type});    
   assign is_read  = (req_type == MRd0) | (req_type == MRd1) | (req_type == MRdLk0) | (req_type == MRdLk1);
   assign is_write = (req_type == MWr0) | (req_type == MWr1);

   assign cmd_esll_wr_data_sb.trans_is_comp_or_int = is_comp || is_int ;
   //assign cmd_esll_wr_data_sb.trans_need_wd        = is_write && cmd_esll_wr_data.sb_attr.last_slice;
   assign cmd_esll_wr_data_sb.last_slice           = cmd_esll_wr_data.sb_attr.last_slice;
   //assign cmd_esll_wr_data_sb.trans_is_trapped     = (cmd_esll_wr_data.sb_attr.htu_info.htu_hit || cmd_esll_wr_data.sb_attr.xali_sb.upp_sb.gen_sep_dbl) && cmd_esll_wr_data.sb_attr.last_slice && (cmd_esll_wr_data.sb_attr.queue_id >= UPP_NUM_OF_ORDERING_DOMAINS  );
   logic old_trans_is_trapped;

   assign old_trans_is_trapped     = ((cmd_esll_wr_data.tlp_cmd.tlp_type == Rq) || (cmd_esll_wr_data.tlp_cmd.tlp_type == RqLk) ) && 
                                                     !cmd_esll_wr_data.sb_attr.xali_sb.upp_sb.is_int && cmd_esll_wr_data.sb_attr.last_slice && 
                                                     (cmd_esll_wr_data.sb_attr.queue_id >= UPP_NUM_OF_ORDERING_DOMAINS  ) && port_is_usp[cmd_esll_wr_data.dest_port] &&
                                                     (queue_packet_wip[cmd_esll_wr_data.sb_attr.queue_id[UPP_NUM_OF_ORDERING_DOMAINS_W :0] - UPP_NUM_OF_ORDERING_DOMAINS] ? 
                                                     queue_packet_wip_htu_on[cmd_esll_wr_data.sb_attr.queue_id[UPP_NUM_OF_ORDERING_DOMAINS_W :0] - UPP_NUM_OF_ORDERING_DOMAINS] : 
                                                     (cmd_esll_wr_data.sb_attr.htu_info.htu_hit || cmd_esll_wr_data.sb_attr.xali_sb.upp_sb.gen_sep_dbl));

   assign cmd_esll_wr_data_sb.trans_is_trapped     = (cmd_esll_wr_data.sb_attr.queue_id >= UPP_NUM_OF_ORDERING_DOMAINS ) ? 
                                                     ((cmd_esll_wr_data.tlp_cmd.tlp_type == Rq) || (cmd_esll_wr_data.tlp_cmd.tlp_type == RqLk) ) && 
                                                     !cmd_esll_wr_data.sb_attr.xali_sb.upp_sb.is_int && cmd_esll_wr_data.sb_attr.last_slice && 
                                                     (cmd_esll_wr_data.sb_attr.queue_id >= UPP_NUM_OF_ORDERING_DOMAINS  ) && port_is_usp[cmd_esll_wr_data.dest_port] &&
                                                     (queue_packet_wip[cmd_esll_wr_data.sb_attr.queue_id[UPP_NUM_OF_ORDERING_DOMAINS_W :0] - UPP_NUM_OF_ORDERING_DOMAINS] ? 
                                                     queue_packet_wip_htu_on[cmd_esll_wr_data.sb_attr.queue_id[UPP_NUM_OF_ORDERING_DOMAINS_W :0] - UPP_NUM_OF_ORDERING_DOMAINS] : 
                                                     (cmd_esll_wr_data.sb_attr.htu_info.htu_hit || cmd_esll_wr_data.sb_attr.xali_sb.upp_sb.gen_sep_dbl)) :
                                                     cmd_esll_wr_data.tlp_cmd.tlp_dv ;

   assign cmd_esll_wr_data_size                    = 13'(is_read ? 13'h0 :
                                                     (|cmd_esll_wr_data.tlp_cmd.tlp_byte_len[12:0]) ? 13'(cmd_esll_wr_data.tlp_cmd.tlp_byte_len[12:0] - 1'b1 ): 13'h0);

   assign rd_wr_cmd_esll_wr_data_size              = 13'((|cmd_esll_wr_data.tlp_cmd.tlp_byte_len[12:0]) ? 13'(cmd_esll_wr_data.tlp_cmd.tlp_byte_len[12:0] - 1'b1 ): 13'h0);

   logic [3:0] old_num_of_beats;
   assign old_num_of_beats = 4'((!cmd_esll_wr_data.tlp_cmd.tlp_dv) ? 4'h0 : 
                                                  (|cmd_esll_wr_data_size[9:6] ? // MPS is 512bytes so no more than 10 bits for represent it in byte granularity - even size have 13 bits but this is for read.   
                                                  (cmd_esll_wr_data_size[9:6] +  4'(|cmd_esll_wr_data_size[5:0])) :
                                                  4'(|cmd_esll_wr_data_size[5:0]))) ;                                                                    

 //  assign cmd_esll_wr_data_sb.num_of_beats      = 4'(((!cmd_esll_wr_data.tlp_cmd.tlp_dv && (cmd_esll_wr_data.sb_attr.queue_id >= UPP_NUM_OF_ORDERING_DOMAINS )) ? 4'h0 :
 //                                                     |rd_wr_cmd_esll_wr_data_size[9:6] ? // MPS is 512bytes so no more than 10 bits for represent it in byte granularity - even size have 13 bits but this is for read.   
 //                                                    (rd_wr_cmd_esll_wr_data_size[9:6] +  4'(|rd_wr_cmd_esll_wr_data_size[5:0])) :
 //                                                 4'(|rd_wr_cmd_esll_wr_data_size[5:0]))) ;                                                                    

   logic [3:0] rd_num_of_beats;

   assign rd_num_of_beats[3:0] = {
                                 |rd_wr_cmd_esll_wr_data_size[12:10],
                                  rd_wr_cmd_esll_wr_data_size[9],
                                  rd_wr_cmd_esll_wr_data_size[8],
                                 |rd_wr_cmd_esll_wr_data_size[7:0]
                                 };

   assign cmd_esll_wr_data_sb.num_of_beats      =  (cmd_esll_wr_data.sb_attr.queue_id >= UPP_NUM_OF_ORDERING_DOMAINS ) ? 
                                                   old_num_of_beats : // CP
                                                   rd_num_of_beats[3:0] ; // NP

    
               `ifndef INTEL_SVA_OFF
                   `ASSERTS_NEVER (trans_is_trapped_old_new_for_wr,
                             (((cmd_esll_wr_data.sb_attr.queue_id >= UPP_NUM_OF_ORDERING_DOMAINS  ) && (old_trans_is_trapped != cmd_esll_wr_data_sb.trans_is_trapped)) ),
                             posedge clk, 
                             ~rst_n, 
                            `ERR_MSG ("Old and new trans_is_trapped for Wr"));

                   `ASSERTS_NEVER (trans_is_trapped_old_new_for_rd,
                             (((cmd_esll_wr_data.sb_attr.queue_id < UPP_NUM_OF_ORDERING_DOMAINS  ) && (old_num_of_beats != 4'(cmd_esll_wr_data_sb.trans_is_trapped))) ),
                             posedge clk, 
                             ~rst_n, 
                            `ERR_MSG ("Old and new trans_is_trapped for Rd"));

                   `ASSERTS_NEVER (num_of_beats_for_wr,
                             (((cmd_esll_wr_data.sb_attr.queue_id >= UPP_NUM_OF_ORDERING_DOMAINS  ) && cmd_esll_wr_data.tlp_cmd.tlp_hv && (old_num_of_beats != cmd_esll_wr_data_sb.num_of_beats)) ),
                             posedge clk, 
                             ~rst_n, 
                            `ERR_MSG ("Old and new num_of_beats for Wr"));

               `endif

//               `ifndef INTEL_SVA_OFF
//                   `ASSERTS_NEVER (np_num_of_beats_is_1_if_at_all,
//                             (((cmd_esll_wr_data.sb_attr.queue_id < UPP_NUM_OF_ORDERING_DOMAINS  ) && cmd_esll_wr_data.tlp_cmd.tlp_dv && (cmd_esll_wr_data_sb.num_of_beats != 4'h1)) ),
//                             posedge clk, 
//                             ~rst_n, 
//                            `ERR_MSG ("trans_num_of_beats is different than 1 in case of dv"));
//               `endif

    assign cmd_wr_queue_id = cmd_esll_wr_data.sb_attr.queue_id;
    assign cmd_rd_queue_id = pop_list;
    assign data_wr_queue_id = data_esll_wr_data.queue_id;
    assign data_rd_queue_id = data_esll_rd_idx;
//    assign cmd_rd_byte_length = esll_rd_data.tlp_cmd.tlp_byte_len;
    
    logic [CMD_ESLL_ADDR_W - 1 : 0] hif_ati_cmd_esll_list_mem_rd_adr_int;
    logic                           hif_ati_cmd_esll_list_mem_rd_en_int;
    logic [CMD_ESLL_ADDR_W - 1 : 0] hif_ati_cmd_esll_list_mem_wr_adr_int;
    logic [CMD_ESLL_ADDR_W + CMD_ESLL_SB_W - 1 : 0] hif_ati_cmd_esll_list_mem_wr_data_int;
    logic                           hif_ati_cmd_esll_list_mem_wr_en_int;
    
     logic [CMD_ESLL_ADDR_W - 1 : 0] hif_ati_cmd_esll_data_mem_rd_adr_int ;
     logic                           hif_ati_cmd_esll_data_mem_rd_en_int ;
     logic [CMD_ESLL_ADDR_W - 1 : 0] hif_ati_cmd_esll_data_mem_wr_adr_int ;
     logic [CMD_ESLL_WIDTH - 1 : 0]  hif_ati_cmd_esll_data_mem_wr_data_int ;
     logic                           hif_ati_cmd_esll_data_mem_wr_en_int ;

    hif_ati_sll_ctl_v3 #(
                         .WIDTH           (CMD_ESLL_WIDTH                     ) ,
                         .DEPTH           (CMD_ESLL_DEPTH                     ) ,
                         .LISTS           (NUM_OF_LISTS                       ) ,
                         .PREF_DATA       (0                                  ) ,
                         .DMEM_LATENCY    (ATI_BUF_RD_LATENCY ) ,
                         .PMEM_LATENCY    (CMD_ESLL_POINTER_NUM_OF_PF_PER_LIST + CMD_ESLL_LIST_MEM_SAMP ) ,
                         .PMEM_PEEK_DEPTH (POP_OUT_ARB_PIPELINE_DEPTH         ) ,
                         .SB_EN           (1                                  ) ,
                         .SB_W            (CMD_ESLL_SB_W                      ) ,
                         .FULL_TYPE       (1                                  )
                        )
    ati_cmd_esll_inst (
                       // Inputs
                       .clk                       (clk                                    ) ,
                       .data_mem_rd_data          (hif_ati_cmd_esll_data_mem_rd_data      ) ,
                       .data_mem_rd_vld           (hif_ati_cmd_esll_data_mem_rd_valid     ) , //Not used when pre-fetch is enabled
                       .list_mem_rd_data          (hif_ati_cmd_esll_list_mem_rd_data_delay) ,
                       .peek_next_list_head       (cmd_esll_peek_next_list_head           ) ,
                       .peeked_next_list_head_vld (cmd_esll_peeked_next_list_head_vld     ) ,
                       .peeked_next_list_head_data(cmd_esll_peeked_next_list_head_data    ) ,
                       // Read
                       .rd_en                     (cmd_esll_rd_en                         ) ,
                       .rd_idx                    (pop_list                               ) ,
                       .rst_n                     (rst_n                                  ) ,
                       .wr_data                   (cmd_esll_wr_data_reduced               ) ,
                       // Write
                       .wr_en                     (cmd_esll_wr_en                         ) ,
                       .wr_idx                    (cmd_esll_wr_data.sb_attr.queue_id      ) ,
                       // sb
                       .wr_data_sb                (cmd_esll_wr_data_sb                    ) ,
                       .list_head_sb              (cmd_esll_list_head_sb                  ) ,
                       .list_head_sb_ps           (cmd_esll_list_head_sb_ps               ) ,
                       .peeked_next_list_head_sb_data (cmd_esll_peeked_next_list_head_sb_data) ,
                       // Outputs
                       .data_mem_rd_addr          (hif_ati_cmd_esll_data_mem_rd_adr_int       ) ,
                       .data_mem_rd_en            (hif_ati_cmd_esll_data_mem_rd_en_int        ) ,
                       .data_mem_wr_addr          (hif_ati_cmd_esll_data_mem_wr_adr_int       ) ,
                       .data_mem_wr_data          (hif_ati_cmd_esll_data_mem_wr_data_int      ) ,
                       // Data memory
                       .data_mem_wr_en            (hif_ati_cmd_esll_data_mem_wr_en_int        ) ,
                       .free_length               (cmd_esll_free_length_nc                ) , //Length of the free list
                       .head_vld_ps               (cmd_esll_head_vld_ps                   ) ,
                       // exposed pointers
                       .list_head                 (cmd_esll_list_head                     ) ,
                       .list_head_ps              (cmd_esll_list_head_ps                  ) ,
                       .list_mem_rd_addr          (hif_ati_cmd_esll_list_mem_rd_adr_int       ) ,
                       .list_mem_rd_en            (hif_ati_cmd_esll_list_mem_rd_en_int        ) ,
                       .list_mem_wr_addr          (hif_ati_cmd_esll_list_mem_wr_adr_int       ) ,
                       .list_mem_wr_data          (hif_ati_cmd_esll_list_mem_wr_data_int      ) ,
                       // List pointers memory
                       .list_mem_wr_en            (hif_ati_cmd_esll_list_mem_wr_en_int        ) ,
                       .lists_length              (cmd_esll_lists_length                  ) , //Length of all sub-lists
                       .next_free                 (cmd_esll_next_free                     ) ,
                       .rd_data                   (cmd_esll_rd_data_extended              ) , //Read data array, in case of no pre-fetch all indexes equal memory read data
                       .rd_data_vld               (cmd_esll_rd_data_vld                   ) , //Read data valid, only relevant when not using pre-fetch
                       .rd_empty                  (cmd_esll_rd_empty                      ) ,
                       // Status
                       .used_space                (cmd_esll_used_space                    ) , //Number of used entries across all sub-lists
                       .wr_full                   (cmd_esll_wr_full                       )
                      );


//////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                   CMD ESLL list mem I/F sampler
//////////////////////////////////////////////////////////////////////////////////////////////////////////////

   hif_etp_memif_samp #(
        .ADDR_W (CMD_ESLL_ADDR_W),
        .DATA_W (CMD_ESLL_ADDR_W+CMD_ESLL_SB_W),
        .NO_SAMP(!CMD_ESLL_LIST_MEM_SAMP)
    )
    hif_upp_cmd_esll_list_memif_samp (
        // CAR
        .clk        (clk),
        .rst_n      (rst_n),
        // RL inc
        .wr_en_pre  (hif_ati_cmd_esll_list_mem_wr_en_int),
        .wr_adr_pre (hif_ati_cmd_esll_list_mem_wr_adr_int),
        .wr_data_pre(hif_ati_cmd_esll_list_mem_wr_data_int),
        .rd_en_pre  (hif_ati_cmd_esll_list_mem_rd_en_int),
        .rd_adr_pre (hif_ati_cmd_esll_list_mem_rd_adr_int),
        
        .wr_en      (hif_ati_cmd_esll_list_mem_wr_en),
        .wr_adr     (hif_ati_cmd_esll_list_mem_wr_adr),
        .wr_data    (hif_ati_cmd_esll_list_mem_wr_data),
        .rd_en      (hif_ati_cmd_esll_list_mem_rd_en),
        .rd_adr     (hif_ati_cmd_esll_list_mem_rd_adr)
        );
  
   hif_etp_memif_samp #(
        .ADDR_W (CMD_ESLL_ADDR_W),
        .DATA_W (CMD_ESLL_WIDTH),
        .NO_SAMP(!CMD_ESLL_DATA_MEM_SAMP)
    )
    hif_upp_cmd_esll_data_memif_samp (
        // CAR
        .clk        (clk),
        .rst_n      (rst_n),
        // RL inc
        .wr_en_pre  (hif_ati_cmd_esll_data_mem_wr_en_int),
        .wr_adr_pre (hif_ati_cmd_esll_data_mem_wr_adr_int),
        .wr_data_pre(hif_ati_cmd_esll_data_mem_wr_data_int),
        .rd_en_pre  (hif_ati_cmd_esll_data_mem_rd_en_int),
        .rd_adr_pre (hif_ati_cmd_esll_data_mem_rd_adr_int),
        
        .wr_en      (hif_ati_cmd_esll_data_mem_wr_en),
        .wr_adr     (hif_ati_cmd_esll_data_mem_wr_adr),
        .wr_data    (hif_ati_cmd_esll_data_mem_wr_data),
        .rd_en      (hif_ati_cmd_esll_data_mem_rd_en),
        .rd_adr     (hif_ati_cmd_esll_data_mem_rd_adr)
        );
  

//////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                   CMD ESLL PMEM
//////////////////////////////////////////////////////////////////////////////////////////////////////////////
/*
    ecip_gen_dual_port_ram_v2 #(
                                .DW     (CMD_ESLL_ADDR_W+CMD_ESLL_SB_W) ,
                                .DEPTH  (CMD_ESLL_DEPTH ) , 
                                .DELAY  (2              )
                               )
    u_ati_cmd_esll_list_mem   (
                                 // Inputs
                                 .rd_addr (hif_ati_cmd_esll_list_mem_rd_adr    ) ,
                                 .rd_clk  (clk                                 ) ,
                                 // Read interface
                                 .rd_en   (hif_ati_cmd_esll_list_mem_rd_en     ) ,
                                 .rd_rst_n(rst_n                               ) ,
                                 .wr_addr (hif_ati_cmd_esll_list_mem_wr_adr    ) ,
                                 // Clocks & reset
                                 .wr_clk  (clk                                 ) ,
                                 .wr_data (hif_ati_cmd_esll_list_mem_wr_data   ) ,
                                 // Write interface
                                 .wr_en   (hif_ati_cmd_esll_list_mem_wr_en     ) ,
                                 .wr_rst_n(rst_n                               ) ,
                                 // Outputs
                                 .rd_data (hif_ati_cmd_esll_list_mem_rd_data   ) ,
                                 .rd_vld  (hif_ati_cmd_esll_list_mem_rd_valid  )
                                );
*/

     logic [DATA_ESLL_ADDR_W - 1 : 0] hif_ati_data_esll_data_mem_rd_adr_int;
     logic                            hif_ati_data_esll_data_mem_rd_en_int;

     logic [DATA_ESLL_ADDR_W - 1 : 0] hif_ati_data_esll_data_mem_wr_adr_int;
     logic [DATA_ESLL_WIDTH - 1 : 0]  hif_ati_data_esll_data_mem_wr_data_int;
     logic                            hif_ati_data_esll_data_mem_wr_en_int;

     logic [DATA_ESLL_ADDR_W - 1 : 0] hif_ati_data_esll_list_mem_rd_adr_int;
     logic                            hif_ati_data_esll_list_mem_rd_en_int;

     logic [DATA_ESLL_ADDR_W - 1 : 0] hif_ati_data_esll_list_mem_wr_adr_int;
     logic [DATA_ESLL_ADDR_W - 1 : 0] hif_ati_data_esll_list_mem_wr_data_int;
     logic                            hif_ati_data_esll_list_mem_wr_en_int;

//////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                   DATA ESLL
//////////////////////////////////////////////////////////////////////////////////////////////////////////////

    assign data_esll_wr_data.data     = ati_trans.data;
    assign data_esll_wr_data.queue_id = ati_trans.sb_attr.queue_id;
    assign data_esll_wr_en            = ati_trans_vld & ati_trans.tlp_cmd.tlp_dv;


    hif_ati_sll_ctl_v3 #(
                         .WIDTH       (DATA_ESLL_WIDTH) ,
                         .DEPTH       (DATA_ESLL_DEPTH) ,
                         .LISTS       (NUM_OF_LISTS   ) ,
                         .PREF_DATA   (0              ) ,
                         .DMEM_LATENCY(ATI_BUF_RD_LATENCY) ,
                         .PMEM_LATENCY(2 + DATA_ESLL_LIST_MEM_SAMP  ) ,
                         .SB_EN       (0              ) ,
                         .FULL_TYPE   (1              )
                        )
    ati_data_esll_inst (
                        // Inputs
                        .clk                       (clk                                  ) ,
                        .data_mem_rd_data          (hif_ati_data_esll_data_mem_rd_data   ) ,
                        .data_mem_rd_vld           (hif_ati_data_esll_data_mem_rd_valid  ) , //Not used when pre-fetch is enabled
                        .list_mem_rd_data          (hif_ati_data_esll_list_mem_rd_data   ) ,
                        .peek_next_list_head       ('0                                   ) ,
                        .peeked_next_list_head_vld (                                     ) ,
                        .peeked_next_list_head_data(                                     ) ,
                        // Read
                        .rd_en                     (data_esll_rd_en                      ) ,
                        .rd_idx                    (data_esll_rd_idx                     ) ,
                        .rst_n                     (rst_n                                ) ,
                        .wr_data                   (data_esll_wr_data.data               ) ,
                        // Write
                        .wr_en                     (data_esll_wr_en                      ) ,
                        .wr_idx                    (data_esll_wr_data.queue_id           ) ,
                       // sb
                        .wr_data_sb                ('0) ,
                        .list_head_sb              () ,// Unused
                        .list_head_sb_ps           () ,// Unused
                        .peeked_next_list_head_sb_data () ,// Unused
                        // Outputs
                        .data_mem_rd_addr          (hif_ati_data_esll_data_mem_rd_adr_int    ) ,
                        .data_mem_rd_en            (hif_ati_data_esll_data_mem_rd_en_int     ) ,
                        .data_mem_wr_addr          (hif_ati_data_esll_data_mem_wr_adr_int    ) ,
                        .data_mem_wr_data          (hif_ati_data_esll_data_mem_wr_data_int   ) ,
                        // Data memory
                        .data_mem_wr_en            (hif_ati_data_esll_data_mem_wr_en_int     ) ,
                        .free_length               (data_esll_free_length_nc             ) , //Length of the free list
                        .head_vld_ps               (data_esll_head_vld_ps_nc             ) ,
                        // exposed pointers
                        .list_head                 (data_esll_list_head_nc               ) ,
                        .list_head_ps              (data_esll_list_head_ps_nc            ) ,
                        .list_mem_rd_addr          (hif_ati_data_esll_list_mem_rd_adr_int    ) ,
                        .list_mem_rd_en            (hif_ati_data_esll_list_mem_rd_en_int     ) ,
                        .list_mem_wr_addr          (hif_ati_data_esll_list_mem_wr_adr_int    ) ,
                        .list_mem_wr_data          (hif_ati_data_esll_list_mem_wr_data_int   ) ,
                        // List pointers memory
                        .list_mem_wr_en            (hif_ati_data_esll_list_mem_wr_en_int     ) ,
                        .lists_length              (data_esll_lists_length               ) , //Length of all sub-lists
                        .next_free                 (data_esll_next_free_nc               ) ,
                        .rd_data                   (data_esll_rd_data_extended           ) , //Read data array, in case of no pre-fetch all indexes equal memory read data
                        .rd_data_vld               (data_esll_rd_data_vld                ) , //Read data valid, only relevant when not using pre-fetch
                        .rd_empty                  (data_esll_rd_empty                   ) ,
                        // Status
                        .used_space                (data_esll_used_space                 ) , //Number of used entries across all sub-lists
                        .wr_full                   (data_esll_wr_full                    )
                       );


//////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                   DATA ESLL list mem I/F sampler
//////////////////////////////////////////////////////////////////////////////////////////////////////////////

   hif_etp_memif_samp #(
        .ADDR_W (DATA_ESLL_ADDR_W),
        .DATA_W (DATA_ESLL_ADDR_W),
        .NO_SAMP(!DATA_ESLL_LIST_MEM_SAMP)
    )
    hif_upp_data_esll_list_memif_samp (
        // CAR
        .clk        (clk),
        .rst_n      (rst_n),
        // RL inc
        .wr_en_pre  (hif_ati_data_esll_list_mem_wr_en_int),
        .wr_adr_pre (hif_ati_data_esll_list_mem_wr_adr_int),
        .wr_data_pre(hif_ati_data_esll_list_mem_wr_data_int),
        .rd_en_pre  (hif_ati_data_esll_list_mem_rd_en_int),
        .rd_adr_pre (hif_ati_data_esll_list_mem_rd_adr_int),
        
        .wr_en      (hif_ati_data_esll_list_mem_wr_en),
        .wr_adr     (hif_ati_data_esll_list_mem_wr_adr),
        .wr_data    (hif_ati_data_esll_list_mem_wr_data),
        .rd_en      (hif_ati_data_esll_list_mem_rd_en),
        .rd_adr     (hif_ati_data_esll_list_mem_rd_adr)
        );
  
   hif_etp_memif_samp #(
        .ADDR_W (DATA_ESLL_ADDR_W),
        .DATA_W (DATA_ESLL_WIDTH ),
        .NO_SAMP(!DATA_ESLL_DATA_MEM_SAMP)
    )
    hif_upp_data_esll_data_memif_samp (
        // CAR
        .clk        (clk),
        .rst_n      (rst_n),
        // RL inc
        .wr_en_pre  (hif_ati_data_esll_data_mem_wr_en_int),
        .wr_adr_pre (hif_ati_data_esll_data_mem_wr_adr_int),
        .wr_data_pre(hif_ati_data_esll_data_mem_wr_data_int),
        .rd_en_pre  (hif_ati_data_esll_data_mem_rd_en_int),
        .rd_adr_pre (hif_ati_data_esll_data_mem_rd_adr_int),
        
        .wr_en      (hif_ati_data_esll_data_mem_wr_en),
        .wr_adr     (hif_ati_data_esll_data_mem_wr_adr),
        .wr_data    (hif_ati_data_esll_data_mem_wr_data),
        .rd_en      (hif_ati_data_esll_data_mem_rd_en),
        .rd_adr     (hif_ati_data_esll_data_mem_rd_adr)
        );
  
//////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                   assign buffer reads
//////////////////////////////////////////////////////////////////////////////////////////////////////////////

    always_comb begin
        esll_rd_data.tlp_cmd         = cmd_esll_rd_data_extended[0].tlp_cmd;
        esll_rd_data.tlp_cmd.tlp_hv  = cmd_esll_rd_data_vld;
        esll_rd_data.tlp_cmd.tlp_dv  = data_esll_rd_data_vld;
    end

    assign esll_rd_data.sb_attr               = cmd_esll_rd_data_extended[0].sb_attr;
    assign esll_rd_data.ati_src               = cmd_esll_rd_data_extended[0].ati_src;
    assign esll_rd_data.data                  = data_esll_rd_data_extended[0];
    assign esll_rd_data.trap_info             = cmd_esll_rd_data_extended[0].trap_info;
    assign esll_rd_data_vld                   = cmd_esll_rd_data_vld | data_esll_rd_data_vld;

    //RR - lint cleanup
    assign esll_rd_data.dest_port 	      = '0;

////////////////////////////
// Deadlock status register
////////////////////////////

    logic [6*32 - 1 : 0] GLHIF_ATI_DFD_STATUS_REG_ps;
    logic [6*32 - 1 : 0] GLHIF_ATI_DFD_STATUS_REG_trig;

    assign GLHIF_ATI_DFD_STATUS_REG_trig = {
            ((6*32) - NUM_OF_LISTS)'(1'b0) ,
            ati_trans_vld & cmd_esll_wr_full ,
            ati_trans_vld & data_esll_wr_full
        };

    always_comb begin
        for (int i = 0 ; i < 6 ; i++) begin
            GLHIF_ATI_DFD_STATUS_REG_ps[i*32 +: 32] = new_UPP_ATI_DFD_STATUS_REG[i].THRESH[31 : 0] | GLHIF_ATI_DFD_STATUS_REG_trig[i*32 +: 32];
        end
    end

// Init credits register
    hif_ati_ff #(.WIDTH(6*32) , .RESET_VAL((6*32)'(1'b0))) GLHIF_ATI_DFD_STATUS_REG_reg (
                                                                                         .clk     (clk                                       ) ,
                                                                                         .rst_n   (rst_n                                     ) ,
                                                                                         .wr_en   (1'b1                                      ) ,
                                                                                         .data_in (GLHIF_ATI_DFD_STATUS_REG_ps[6*32 - 1 : 0] ) ,
                                                                                         .data_out(new_UPP_ATI_DFD_STATUS_REG                )
                                                                                        );
    
    
    always_comb begin
        for (int od_idx = 0; od_idx < UPP_NUM_OF_ORDERING_DOMAINS; od_idx++) begin
            od_params[od_idx] = od_port_ate_sp_t'(etp_upp_od_params[od_idx]);
        end
    end

    always_comb begin
        list_of_port_empty = '0;
        for (int port_idx = 0; port_idx < UPP_NUM_OF_DEST_PORTS; port_idx++) begin
            for (int od_idx = 0; od_idx < 2*UPP_NUM_OF_ORDERING_DOMAINS; od_idx++) begin
                if (od_idx < UPP_NUM_OF_ORDERING_DOMAINS) begin
                    list_of_port_empty[port_idx][od_idx] = od_params[od_idx].port == port_idx & ~|data_esll_lists_length[od_idx] & ~|cmd_esll_lists_length[od_idx];
                end
                else begin
                    list_of_port_empty[port_idx][od_idx] = od_params[od_idx-UPP_NUM_OF_ORDERING_DOMAINS].port == port_idx & ~|data_esll_lists_length[od_idx] & ~|cmd_esll_lists_length[od_idx];
                end 
            end
        end 
    end
    
    always_comb begin
        all_lists_of_port_empty = '0;
        for (int port_idx = 0; port_idx < UPP_NUM_OF_DEST_PORTS; port_idx++) begin
            all_lists_of_port_empty[port_idx] = &list_of_port_empty[port_idx];
        end 
    end 
	
    logic [UPP_NUM_OF_ORDERING_DOMAINS-1:0] upp_npq_nss_queue_empty;//13011968772
    always_comb for (int od_idx = 0; od_idx < UPP_NUM_OF_ORDERING_DOMAINS; od_idx++) upp_npq_nss_queue_empty[od_idx] = ~(|cmd_esll_lists_length[od_idx] & od_params[od_idx].nss);//13011968772
 
    logic upp_npq_nss_empty_pre;//13011968772

    always_ff @ (posedge clk or negedge rst_n)//13011968772
      if (~rst_n) upp_npq_nss_empty_pre <= '1;//13011968772
      else        upp_npq_nss_empty_pre <= &upp_npq_nss_queue_empty;//13011968772

    always_ff @ (posedge clk or negedge rst_n)//13011968772
      if (~rst_n) upp_npq_nss_empty <= '1;//13011968772
      else        upp_npq_nss_empty <= upp_npq_nss_empty_pre;//13011968772

////////////////////////////////////////////
// Idle logic
////////////////////////////////////////////

    assign ati_esll_logic_empty = (&cmd_esll_rd_empty[NUM_OF_LISTS - 1 : 0]) &&
        (&data_esll_rd_empty[NUM_OF_LISTS - 1 : 0]) &&
        (!(|data_esll_lists_length)) &&
        (!(|data_esll_used_space)) &&
        (!(|cmd_esll_lists_length)) &&
        (!(|cmd_esll_used_space));


    assign ati_trans_rdy = ~(cmd_esll_wr_full | data_esll_wr_full | ~pcie_upp_init_done);
    
    `include "ati_data_structure_visa_logic.sv"

    `ifndef  INTEL_SVA_OFF 

logic samp_cmd_esll_rd_en;
logic samp_cmd_esll_wr_en;
logic samp_data_esll_rd_en;
logic samp_data_esll_wr_en;
logic [NUM_OF_LISTS_W - 1 : 0] samp_cmd_pop_list;
logic [NUM_OF_LISTS_W - 1 : 0] samp_cmd_push_list;
logic [NUM_OF_LISTS_W - 1 : 0] samp_data_pop_list;
logic [NUM_OF_LISTS_W - 1 : 0] samp_data_push_list;
           
            always_ff @ (posedge clk or negedge rst_n) begin
                if (~rst_n) begin
                    samp_cmd_esll_rd_en <= '0;
                    samp_cmd_esll_wr_en <= '0;
                    samp_data_esll_rd_en <= '0;
                    samp_data_esll_wr_en <= '0;
                    samp_cmd_pop_list <= '0;
                    samp_cmd_push_list <= '0;
                    samp_data_pop_list <= '0;
                    samp_data_push_list <= '0;

                end
                else   begin
                    samp_cmd_esll_rd_en   <= cmd_esll_rd_en;
                    samp_cmd_esll_wr_en   <= cmd_esll_wr_en;
                    samp_data_esll_rd_en  <= data_esll_rd_en;
                    samp_data_esll_wr_en  <= data_esll_wr_en;
                    samp_cmd_pop_list     <= pop_list;
                    samp_cmd_push_list    <= cmd_esll_wr_data.sb_attr.queue_id;
                    samp_data_pop_list    <= data_esll_rd_idx;
                    samp_data_push_list   <= data_esll_wr_data.queue_id;
                end
            end
            
    `endif

     logic  upp_ati_data_structure_idle;
     assign upp_ati_data_structure_idle = !etp_upp_queue_id_valid & !ati_trans_vld & !sent_queue_info_valid & !esll_rd_data_vld & ~|cmd_esll_lists_length & ~|data_esll_lists_length;
     
    assign vsb_snapshot_ati_data_structure_data_esll_lists_length = data_esll_lists_length;
    assign vsb_snapshot_ati_data_structure_cmd_esll_lists_length  = cmd_esll_lists_length;
    

    `ECIP_GEN_EOT(UPP_ATI_DATA_STRUCTURE , upp_ati_data_structure_is_idle , upp_ati_data_structure_idle , EOT arrived but upp_ati_data_structure isn't idle)

`ifndef  INTEL_EMULATION
  `ifndef  INTEL_DC
    `ifndef  INTEL_SVA_OFF 

    `include "hif_ati_data_structure_cov.sv" 
 
    `endif
  `endif
`endif
endmodule
