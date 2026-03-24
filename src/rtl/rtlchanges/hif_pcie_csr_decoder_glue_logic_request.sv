//  INTEL TOP SECRET 
// 
//  Copyright 2018 Intel Corporation All Rights Reserved. 
// 
//  The source code contained or described herein and all documents related 
//  to the source code (Material) are owned by Intel Corporation or its 
//  suppliers or licensors. Title to the Material remains with Intel 
//  Corporation or its suppliers and licensors. The Material contains trade 
//  secrets and proprietary and confidential information of Intel or its 
//  suppliers and licensors. The Material is protected by worldwide copyright 
//  and trade secret laws and treaty provisions. No part of the Material may 
//  be used, copied, reproduced, modified, published, uploaded, posted, 
//  transmitted, distributed, or disclosed in any way without Intel's prior 
//  express written permission. 
// 
//  No license under any patent, copyright, trade secret or other intellectual 
//  property right is granted to or conferred upon you by disclosure or 
//  delivery of the Materials, either expressly, by implication, inducement, 
//  estoppel or otherwise. Any license under such intellectual property rights 
//  must be express and approved by Intel in writing. 
//  Inserted by Intel DSD. 

/************************************************************************/
//  Copyright (c) Intel Corporation All Rights Reserved
//  Networking Devision
//  Intel Proprietary
//
//  FILE information :
//  ------------------
//  File name      : hif_pcie_address_translation_ordering.v
//  Creator        : Ziv baider
//  Last Update by : <Author>
//  Last Update    : <Date>
//
//  Description :
//  -------------
//      <High-level Description of the modules functionality/purpose>
//
//  Assumptions :
//  -------------
//      <Design assumptions related to this module>
//
//  Notes :
//  -------
/************************************************************************/
module hif_pcie_csr_decoder_glue_logic_request
    import hif_csrdec_regs_pkg::*;
    import hif_csr_decoder_package::*;
    import hif_fabif_package::*;
    import hif_common_package::*;
    import hif_dwc_package::*;
    #(
      parameter NUMBER_OF_HOMES = 6,
      parameter NUMBER_OF_HOMES_W = $clog2(NUMBER_OF_HOMES),
      parameter NUMBER_OF_OD_PER_HOME = 4,
      parameter NUMBER_OF_CLIENTS = NUMBER_OF_HOMES * NUMBER_OF_OD_PER_HOME ,
      parameter NUMBER_OF_CLIENTS_PER_OD = NUMBER_OF_CLIENTS / 2  ,
      parameter NUMBER_OF_CLIENTS_W = $clog2(NUMBER_OF_CLIENTS),
      parameter NUMBER_OF_CLIENTS_PER_OD_W = $clog2(NUMBER_OF_CLIENTS_PER_OD),
        parameter NUMBER_OF_LINES_PER_OD = 15,
      parameter CREDITS_W    = 8,
        parameter MEM_DEPTH = 528,
      parameter MEM_ADDR = $clog2(MEM_DEPTH),
      parameter MN_FIFO_MEM_LATENCY = 2,
      parameter DATA_WIDTH = $bits(ihif_csr_cmd_struct),
      //For Arbitrer
      parameter ARB_CREDIT_W = 3,
      parameter ARB_WEIGHT_W = 3
      )
    (
     //Cloks and resets
     input logic clk,
     input logic rst_n,
     //stop and scream
     input stop_if_active_mem_sampled,
     //Inputs
     input ihif_csr_cmd_struct                                           csr_decoder_cmd_in_struct,   //cmd, tdest , home_num, ordering_tag   //new
     input logic                                                                           csr_decoder_cmd_in_valid  , //fabif_csr_rwdatacompmd_tvalid from csr_decoder_inner
     input logic[NUMBER_OF_HOMES_W-1:0]                         csr_decoder_cmd_home_in,      //000, 001, 010, 011, 100, 101
     input fabric_if_hif_if_tdest_t                                       fabif_csr_in_tdest  ,
     input logic                                                                          csr_decoder_calc_cmd_rdy,
     
//     input hif_csr_decoder_package::csr_decoder_fabif_wrdone_t     glue_logic_csr_decoder_wr_done_tdest,
//     input hif_fabif_package::fabric_if_hif_if_tdest_t     glue_logic_csr_decoder_wr_done_tdest,
     input logic[4-1:0]                                                                glue_logic_csr_decoder_wr_done_single_od_inst,
     input  logic                                                                      glue_logic_csr_decoder_wr_done_valid, //The write done that goes out from csr decoder in correct order
     input logic                                                                       fabif_csr_wrdone_tready,
     
      input logic [$clog2(LISTS_DEPTH+1)-1:0] mn_fifo_to_nmf_credit_counter_rd, // @zbaider: added credits between M FIFO and NMF output
     input logic [$clog2(LISTS_DEPTH+1)-1:0] mn_fifo_to_nmf_credit_counter_wr,
     output logic mn_fifo_rd,
     
     //Outputs
      output ihif_csr_cmd_struct                                        csr_decoder_cmd_out_struct,   //cmd, tdest , home_num, ordering_tag   //new
      output logic                                                      csr_decoder_cmd_out_struct_is_pba,
      output logic [NUMBER_OF_CLIENTS_W - 1 : 0]                         csr_decoder_cmd_out_struct_od,
     output logic                                                                       csr_decoder_cmd_out_valid      , 
     input logic[(NUMBER_OF_CLIENTS_PER_OD)-1:0] req_in_rdy_od, // only write    
     output logic do_arb,
     output logic indirect_read_from_mn_fifo_rdy, 
 // 000 - Non posted "not LAN". 001 - Non-Posted LAN. 100 - Posted "not LAN". 101- Posted LAN
     
      output logic csr_fabif_rwdatacompmd_tready,
     
    output  logic wrk_cred_tvalid_, // Work phase mode - credit consumed: req exists mn fifo (& rd wr ordering)
    input  logic[CREDITS_W-1:0] wrk_cred_tdata_ , // Work phase mode - credit consumed number 
     
    // Request Command Credit I/F - H5
     output  logic                                                                    csr_fabif_rwdatacompmd_cred_tvalid   , // there was a read from fifo, tvalid ia high for the client
     output  logic   [CREDITS_W-1:0]                               csr_fabif_rwdatacompmd_cred_tdata    ,//how many lines free in a cycle
     output  fabric_if_hif_if_tdest_t                                csr_fabif_rwdatacompmd_cred_tdest    , // [3-1 : 0]rel_port_id.;[3-1:0]od; fabric_host_id_e    fabric_host_id;
     input   logic                                                                     fabif_csr_rwdatacompmd_cred_mready,  //client is ready to recieve credits from me. rises after reset and stays (or after initialization,if  memory)
     
     //CSRs'
     output  logic[NUMBER_OF_CLIENTS-1:0]                         mn_fifo_dfd_struct, 
     
    //For Arbitrer
    input logic [NUMBER_OF_CLIENTS-1:0][ARB_WEIGHT_W-1:0] CLIENT_WEIGHT , 
    input logic [NUMBER_OF_CLIENTS-1:0][ARB_CREDIT_W-1:0] CLIENT_MAX_CREDIT, 
    
     input logic CSR_AUTOLOAD_DONE, 
     input CSR_SOURCE_MASK_inst_t CSR_SOURCE_MASK, 
     input  GLPCI_CSR_HIFID_TO_NSSHID_inst_0_t GLPCI_CSR_HIFID_TO_NSSHID_0,
     input  GLPCI_CSR_HIFID_TO_NSSHID_inst_1_t GLPCI_CSR_HIFID_TO_NSSHID_1,
     input  GLPCI_CSR_HIFID_TO_NSSHID_inst_2_t GLPCI_CSR_HIFID_TO_NSSHID_2,
     input  GLPCI_CSR_HIFID_TO_NSSHID_inst_3_t GLPCI_CSR_HIFID_TO_NSSHID_3,
     input  GLPCI_CSR_HIFID_TO_NSSHID_inst_4_t GLPCI_CSR_HIFID_TO_NSSHID_4,
     input  GLPCI_CSR_HIFID_TO_NSSHID_inst_5_t GLPCI_CSR_HIFID_TO_NSSHID_5,
     input  GLPCI_CSR_HIFID_TO_NSSHID_inst_6_t GLPCI_CSR_HIFID_TO_NSSHID_6,
     input  GLPCI_CSR_HIFID_TO_NSSHID_inst_7_t GLPCI_CSR_HIFID_TO_NSSHID_7,
     input  GLPCI_CSR_NSSHID_TO_HIFID_inst_0_t GLPCI_CSR_NSSHID_TO_HIFID_0,
     input  GLPCI_CSR_NSSHID_TO_HIFID_inst_1_t GLPCI_CSR_NSSHID_TO_HIFID_1,
     input  GLPCI_CSR_NSSHID_TO_HIFID_inst_2_t GLPCI_CSR_NSSHID_TO_HIFID_2,
     input  GLPCI_CSR_NSSHID_TO_HIFID_inst_3_t GLPCI_CSR_NSSHID_TO_HIFID_3,
    input HIF_CSR_DEC_MN_FIFO_ENDOFF_inst_t[NUMBER_OF_CLIENTS-1:0] HIF_CSR_DEC_MN_FIFO_ENDOFF,
    input HIF_CSR_DEC_MN_FIFO_EN_inst_t[NUMBER_OF_CLIENTS-1:0]  HIF_CSR_DEC_MN_FIFO_EN ,
    input CSR_DEC_RD_WR_ORDERING_THRESHOLD_inst_t CSR_DEC_RD_WR_ORDERING_THRESHOLD_inst,
    input PFSEP_FE_MBX_BAR_ADDRESS_t PFSEP_FE_MBX_BAR_ADDRESS, //MMG800
    //Memories
    input logic [DATA_WIDTH-1:0]                                            mem_fifo_rd_data,    
    output logic                                                            mem_fifo_wr_en,
    output logic [MEM_ADDR-1:0]                                             mem_fifo_wr_addr,
//   output  [DATA_WIDTH-1:0]                                            mem_fifo_wr_data,
    output logic [DATA_WIDTH-1:0]                                           mem_fifo_wr_data,
    output logic                                                            mem_fifo_rd_en,
    output logic [MEM_ADDR-1:0]                                             mem_fifo_rd_addr,
    
    //Chani added logic for pba collection support
    input pba_compl_or_resp_vld,
    input [NUMBER_OF_CLIENTS_W - 1 : 0] pba_compl_or_resp_od,
    
    input logic pba_wr_done_vld,
    input logic [NUMBER_OF_CLIENTS_W - 1 : 0] wr_done_od,
    
    input logic hif_csrdec_ind_go_compl , 
    input logic hif_csrdec_ind_req_type , // 0 -RD , 1 - WR 
    output logic mn_fifo_rdy_out ,
    output logic idle,
    
    
    //DFD
    output logic [64-1:0] visa_glue_req,
    output logic [NUMBER_OF_CLIENTS_PER_OD-2-1:0] dfd_ordering_fifos_full , //TODO add new registers for CMI RD WR ORDERING FIFOs
    output logic [NUMBER_OF_CLIENTS_PER_OD-2-1:0] dfd_ordering_fifos_valid 
    
     );
    
    logic [8-1:0][2-1:0] GLPCI_CSR_HIFID_TO_NSSHID_ARRAY;
    assign GLPCI_CSR_HIFID_TO_NSSHID_ARRAY = {GLPCI_CSR_HIFID_TO_NSSHID_7.HOST_ID,
                                                                                                GLPCI_CSR_HIFID_TO_NSSHID_6.HOST_ID,
                                                                                                GLPCI_CSR_HIFID_TO_NSSHID_5.HOST_ID,
                                                                                                GLPCI_CSR_HIFID_TO_NSSHID_4.HOST_ID,
                                                                                                GLPCI_CSR_HIFID_TO_NSSHID_3.HOST_ID,
                                                                                                GLPCI_CSR_HIFID_TO_NSSHID_2.HOST_ID,
                                                                                                GLPCI_CSR_HIFID_TO_NSSHID_1.HOST_ID,
                                                                                                GLPCI_CSR_HIFID_TO_NSSHID_0.HOST_ID
                                                                                                };

        ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        ////////////////////////////                              LOCAL PARAMS                          ///////////////////////////////////////////////
        ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    
    //INDIRECT
//    localparam INDIRECT_ARB_INDEX = 32; //TODO - change when add CMI support
    localparam INDIRECT_ARB_INDEX = 24;
    
    //For MN FIFO
    localparam ONE_FIFO_CAN_BLOCK_OTHERS = 0;
   
    
    //FOR rd wr ordering
 
    localparam RD_WR_ORDERING_DEPTH = 128;
    
    // For credit Control


        ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        ////////////////////////////                               DECLARATION                           ///////////////////////////////////////////////
        ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

    logic [NUMBER_OF_CLIENTS-1:0][MEM_ADDR-1:0] HIF_CSR_DEC_FIFO_ENDOFF ;

    logic [$clog2(NUMBER_OF_CLIENTS) - 1:0]            wr_idx;
    logic  [NUMBER_OF_HOMES_W-1:0]                         home_out  ;
    logic [3-1:0]                                                                         od_out         ;
    
    
    // For   MN FIFO    
    logic [NUMBER_OF_CLIENTS_W-1:0]                        rd_idx; 
//    logic [NUMBER_OF_CLIENTS_W+1-1:0]                        rd_idx; // +1 for indirect 
    logic [NUMBER_OF_CLIENTS-1:0]                              vld_out_arr;
   
//     logic [NUMBER_OF_CLIENTS-1:0]                             can_pop_from_mn_fifo;
    logic [NUMBER_OF_CLIENTS+1-1:0]                             can_pop_from_mn_fifo; // +1 for Indirect

//     logic mn_fifo_rdy_out ; // for rd wr ordering consideration
    
     //FOR rd wr ordering
      ecip_gen_package::ecip_gen_rd_wr_ordering_e  order_add_wr_rd;
//     logic [NUMBER_OF_CLIENTS_PER_OD-1:0] order_add_rdy_out;
     logic [NUMBER_OF_CLIENTS_PER_OD-2-1:0] order_add_rdy_out_arr ;
     logic [NUMBER_OF_CLIENTS_PER_OD-2-1:0] sent_rd;
     logic [NUMBER_OF_CLIENTS_PER_OD-2-1:0] sent_wr;
     logic[NUMBER_OF_CLIENTS_PER_OD-2-1:0] can_send_rd; //an indication that read can be sent to the destination
     logic [NUMBER_OF_CLIENTS_PER_OD-2-1:0][7-1:0] number_of_rd_wr_ordering_entries_counter, number_of_rd_wr_ordering_entries_counter_next; // For rd wr ordering counters.  8 bit counters

    
     assign order_add_wr_rd= csr_decoder_cmd_in_struct.cmd_tdest.od[2] ? ecip_gen_package::ORDERING_WR : ecip_gen_package::ORDERING_RD; //tdest.od -> // 000 - Non posted "not LAN". 001 - Non-Posted LAN. 100 - Posted "not LAN". 101- Posted LAN
    
    // For credit Control

    ihif_csr_cmd_struct     csr_decoder_cmd_in_struct_to_mn_fifo;   
    
    // find the wr idx to write to the mn fifo according to the request home and ordering domain
    always_comb begin
        case (fabif_csr_in_tdest.od) 
                    TDEST_OTHER_RD_REQ      :  begin
                                wr_idx = {csr_decoder_cmd_home_in, OTHER_RD_REQ} ; 
                    end
                    TDEST_LAN_RD_REQ      :  begin
                                wr_idx = {csr_decoder_cmd_home_in, LAN_RD_REQ} ; 
                    end                    
                    TDEST_OTHER_WR_REQ      :  begin
                                wr_idx = {csr_decoder_cmd_home_in, OTHER_WR_REQ} ; 
                    end                                  
                    TDEST_LAN_WR_REQ      :  begin
                                wr_idx = {csr_decoder_cmd_home_in, LAN_WR_REQ} ; 
                    end
                    default: wr_idx = '0 ; 
        endcase
    end
    
        
        ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        ////////////////////////////                     Request Multi Node FIFO                  ///////////////////////////////////////////////
        ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
   logic [NUMBER_OF_CLIENTS-1 :0 ] HIF_CSR_DEC_FIFO_EN;

assign HIF_CSR_DEC_FIFO_ENDOFF= {
				 HIF_CSR_DEC_MN_FIFO_ENDOFF[23].HIF_CSR_DEC_MN_FIFO_ENDOFF[MEM_ADDR-1:0], // @zbaider: should be configurated to 0
        		 HIF_CSR_DEC_MN_FIFO_ENDOFF[22].HIF_CSR_DEC_MN_FIFO_ENDOFF[MEM_ADDR-1:0], // @zbaider: should be configurated to 0
				 HIF_CSR_DEC_MN_FIFO_ENDOFF[21].HIF_CSR_DEC_MN_FIFO_ENDOFF[MEM_ADDR-1:0], // @zbaider: should be configurated to 0
       			 HIF_CSR_DEC_MN_FIFO_ENDOFF[20].HIF_CSR_DEC_MN_FIFO_ENDOFF[MEM_ADDR-1:0], 
        		 HIF_CSR_DEC_MN_FIFO_ENDOFF[19].HIF_CSR_DEC_MN_FIFO_ENDOFF[MEM_ADDR-1:0], 
				 HIF_CSR_DEC_MN_FIFO_ENDOFF[18].HIF_CSR_DEC_MN_FIFO_ENDOFF[MEM_ADDR-1:0], 
				 HIF_CSR_DEC_MN_FIFO_ENDOFF[17].HIF_CSR_DEC_MN_FIFO_ENDOFF[MEM_ADDR-1:0],
				 HIF_CSR_DEC_MN_FIFO_ENDOFF[16].HIF_CSR_DEC_MN_FIFO_ENDOFF[MEM_ADDR-1:0], 
				 HIF_CSR_DEC_MN_FIFO_ENDOFF[15].HIF_CSR_DEC_MN_FIFO_ENDOFF[MEM_ADDR-1:0], 
				 HIF_CSR_DEC_MN_FIFO_ENDOFF[14].HIF_CSR_DEC_MN_FIFO_ENDOFF[MEM_ADDR-1:0], 
				 HIF_CSR_DEC_MN_FIFO_ENDOFF[13].HIF_CSR_DEC_MN_FIFO_ENDOFF[MEM_ADDR-1:0], 
				 HIF_CSR_DEC_MN_FIFO_ENDOFF[12].HIF_CSR_DEC_MN_FIFO_ENDOFF[MEM_ADDR-1:0], 
				 HIF_CSR_DEC_MN_FIFO_ENDOFF[11].HIF_CSR_DEC_MN_FIFO_ENDOFF[MEM_ADDR-1:0], 
				 HIF_CSR_DEC_MN_FIFO_ENDOFF[10].HIF_CSR_DEC_MN_FIFO_ENDOFF[MEM_ADDR-1:0], 
				 HIF_CSR_DEC_MN_FIFO_ENDOFF[9].HIF_CSR_DEC_MN_FIFO_ENDOFF[MEM_ADDR-1:0],
				 HIF_CSR_DEC_MN_FIFO_ENDOFF[8].HIF_CSR_DEC_MN_FIFO_ENDOFF[MEM_ADDR-1:0], 
				 HIF_CSR_DEC_MN_FIFO_ENDOFF[7].HIF_CSR_DEC_MN_FIFO_ENDOFF[MEM_ADDR-1:0], 
				 HIF_CSR_DEC_MN_FIFO_ENDOFF[6].HIF_CSR_DEC_MN_FIFO_ENDOFF[MEM_ADDR-1:0], 
				 HIF_CSR_DEC_MN_FIFO_ENDOFF[5].HIF_CSR_DEC_MN_FIFO_ENDOFF[MEM_ADDR-1:0],
				 HIF_CSR_DEC_MN_FIFO_ENDOFF[4].HIF_CSR_DEC_MN_FIFO_ENDOFF[MEM_ADDR-1:0], 
				 HIF_CSR_DEC_MN_FIFO_ENDOFF[3].HIF_CSR_DEC_MN_FIFO_ENDOFF[MEM_ADDR-1:0], 
				 HIF_CSR_DEC_MN_FIFO_ENDOFF[2].HIF_CSR_DEC_MN_FIFO_ENDOFF[MEM_ADDR-1:0], 
				 HIF_CSR_DEC_MN_FIFO_ENDOFF[1].HIF_CSR_DEC_MN_FIFO_ENDOFF[MEM_ADDR-1:0],
				 HIF_CSR_DEC_MN_FIFO_ENDOFF[0].HIF_CSR_DEC_MN_FIFO_ENDOFF[MEM_ADDR-1:0]};
//

//
assign HIF_CSR_DEC_FIFO_EN= { HIF_CSR_DEC_MN_FIFO_EN[23].HIF_CSR_DEC_MN_FIFO_EN, HIF_CSR_DEC_MN_FIFO_EN[22].HIF_CSR_DEC_MN_FIFO_EN, HIF_CSR_DEC_MN_FIFO_EN[21].HIF_CSR_DEC_MN_FIFO_EN, HIF_CSR_DEC_MN_FIFO_EN[20].HIF_CSR_DEC_MN_FIFO_EN, 
			    HIF_CSR_DEC_MN_FIFO_EN[19].HIF_CSR_DEC_MN_FIFO_EN, HIF_CSR_DEC_MN_FIFO_EN[18].HIF_CSR_DEC_MN_FIFO_EN, HIF_CSR_DEC_MN_FIFO_EN[17].HIF_CSR_DEC_MN_FIFO_EN,
			    HIF_CSR_DEC_MN_FIFO_EN[16].HIF_CSR_DEC_MN_FIFO_EN, HIF_CSR_DEC_MN_FIFO_EN[15].HIF_CSR_DEC_MN_FIFO_EN, HIF_CSR_DEC_MN_FIFO_EN[14].HIF_CSR_DEC_MN_FIFO_EN, HIF_CSR_DEC_MN_FIFO_EN[13].HIF_CSR_DEC_MN_FIFO_EN, 
			    HIF_CSR_DEC_MN_FIFO_EN[12].HIF_CSR_DEC_MN_FIFO_EN, HIF_CSR_DEC_MN_FIFO_EN[11].HIF_CSR_DEC_MN_FIFO_EN, HIF_CSR_DEC_MN_FIFO_EN[10].HIF_CSR_DEC_MN_FIFO_EN, HIF_CSR_DEC_MN_FIFO_EN[9].HIF_CSR_DEC_MN_FIFO_EN,
			    HIF_CSR_DEC_MN_FIFO_EN[8].HIF_CSR_DEC_MN_FIFO_EN, HIF_CSR_DEC_MN_FIFO_EN[7].HIF_CSR_DEC_MN_FIFO_EN, HIF_CSR_DEC_MN_FIFO_EN[6].HIF_CSR_DEC_MN_FIFO_EN, HIF_CSR_DEC_MN_FIFO_EN[5].HIF_CSR_DEC_MN_FIFO_EN,
			    HIF_CSR_DEC_MN_FIFO_EN[4].HIF_CSR_DEC_MN_FIFO_EN, HIF_CSR_DEC_MN_FIFO_EN[3].HIF_CSR_DEC_MN_FIFO_EN, HIF_CSR_DEC_MN_FIFO_EN[2].HIF_CSR_DEC_MN_FIFO_EN, HIF_CSR_DEC_MN_FIFO_EN[1].HIF_CSR_DEC_MN_FIFO_EN,
			    HIF_CSR_DEC_MN_FIFO_EN[0].HIF_CSR_DEC_MN_FIFO_EN};

localparam IHIF_CSR_CMD_STRUCT_W = $bits(ihif_csr_cmd_struct);
 ihif_csr_cmd_struct [NUMBER_OF_CLIENTS - 1 : 0] csr_decoder_cmd_out_struct_arr;

    logic mn_fifo_vld_out;

//   logic                                                                                    mem_fifo_wr_en;
//   logic [MEM_ADDR-1:0]                                                mem_fifo_wr_addr;
//   logic [DATA_WIDTH-1:0]                                            mem_fifo_wr_data;
//   logic                                                                                   mem_fifo_rd_en;
//   logic [MEM_ADDR-1:0]                                               mem_fifo_rd_addr;

logic mn_fifo_rdy_in;
assign mn_fifo_rdy_in = do_arb & (rd_idx != 5'd24);

    ecip_gen_mn_fifo #(
    .DATA_WIDTH    (IHIF_CSR_CMD_STRUCT_W),
    .TOT_FIFOS     (NUMBER_OF_CLIENTS),
    .MEM_DEPTH     (MEM_DEPTH), 
    .MEMORY_LATENCY(MN_FIFO_MEM_LATENCY), 
    .USE_MEM_SMPL(1),
    .USE_LATENCY_COMP_VERSION(1),
    .USE_BLOCKING(ONE_FIFO_CAN_BLOCK_OTHERS)   //so one home can't block others when full
//    .USE_MEM_SMPL  (USE_MEM_SMPL)
)
u_ecip_gen_mn_fifo (
    //car
    .clk                 (clk),
    .rst_n               (rst_n),
    // Back Pressure - CSR
    .CSR_BLOCK_EN        (0), //HOME_OOR_BLOCK 
    .CSR_BLOCK_TRESH     ('0), //HOME_OOR_BLOCK
    .CSR_GLBL_BLOCK_EN   (0), //GLOBAL_OOR_BLOCK
    .CSR_GLBL_BLOCK_TRESH('0), //GLOBAL_OOR_BLOCK
    .CSR_REQ_FIFO_EN     (HIF_CSR_DEC_FIFO_EN), //CSR active FIFO's                                                         |12 {1,1,0,1}
    .CSR_REQ_FIFO_ENDOFF (HIF_CSR_DEC_FIFO_ENDOFF), //CSR home OFFSET ceiling |12 {11,8,5,2}|12 {11,8,76,5} | 12 {11,8,5,0}

//    .d_in                (csr_decoder_cmd_in_struct), // I write data in
    .d_in                (csr_decoder_cmd_in_struct_to_mn_fifo), // @zbaider: match home_num of in struct to real host num from CSR
    
//    .d_out               (csr_decoder_cmd_out), // data out
    .d_out               (csr_decoder_cmd_out_struct), // data out
    .bp(),
    .d_out_arr           (csr_decoder_cmd_out_struct_arr), 
    // memory I/F
    .mem_fifo_rd_data    (mem_fifo_rd_data),  
    .mem_fifo_rd_addr    (mem_fifo_rd_addr), 
    .mem_fifo_rd_en      (mem_fifo_rd_en), 
    .mem_fifo_wr_addr    (mem_fifo_wr_addr), 
    .mem_fifo_wr_data    (mem_fifo_wr_data), 
    .mem_fifo_wr_en      (mem_fifo_wr_en), 
    .mn_fifo_dfd_struct  (), 
    // read operation
//    .rd_idx              (rd_idx), // arbiter winner 
    .rd_idx              (rd_idx[4:0]), // arbiter winner - bit 5 is for indirect and not relevant to MN/FIFO 
    .rdy_in              (mn_fifo_rdy_in),  
//    .rdy_in              (do_arb), //begore rd wr ordering
    .rdy_out             (mn_fifo_rdy_out), 
    .rdy_out_arr         (), // rdy_out array
    
    .state_out_arr       (), // Number of entries currently in the FIFO
    // write operation
    .vld_in              (csr_decoder_cmd_in_valid), // I
    .wr_idx              ( wr_idx) , // I  wr_idx = {csr_decoder_cmd_home_in, ordering_domain} ; 
    .vld_out             (mn_fifo_vld_out), // @zbaider: connected for indication of rd for new inner credits mechanism
    .vld_out_arr         (vld_out_arr) // O input vector to arbiter
);
    
    assign csr_fabif_rwdatacompmd_tready = mn_fifo_rdy_out ; //FOR DFD
    
    //  ------------------------------------------------------------------------------------------------------------
  
    //@zbaider: add signal for credits between MN FIFO and NMF SLL
    assign mn_fifo_rd = do_arb;
  
    // Chani logic Detect pba_hit

    logic [NUMBER_OF_CLIENTS - 1 : 0] pba_hit;
    logic [NUMBER_OF_CLIENTS - 1 : 0] pba_busy;
    logic [NUMBER_OF_CLIENTS - 1 : 0] pba_clear_busy;
    logic                             csr_decoder_cmd_out_valid_int;
    
    
    
    generate for (genvar i = 0; i  < NUMBER_OF_CLIENTS ; ++i ) begin : pba_detect
  
//for timing sampled in MN_FIFO reserved        
    
        assign pba_hit[i] =   csr_decoder_cmd_out_struct_arr[i].pba_hit;
        assign pba_clear_busy[i] = (pba_compl_or_resp_vld & (pba_compl_or_resp_od == i)) | (pba_wr_done_vld & (wr_done_od == i));
        
        end
    endgenerate
    
    always_ff @(posedge clk , negedge rst_n) begin
        if (~rst_n)
            pba_busy <= '0;
        else begin
            for(int j = 0 ; j < NUMBER_OF_CLIENTS ; j ++ ) begin
                if (pba_clear_busy[j]) //pba request completed collection
                    pba_busy[j] <= '0;
                else if (pba_hit[j] & (rd_idx == j) & do_arb)
                    pba_busy[j] <= 1'b1;   
            end
        end
    end


    assign csr_decoder_cmd_out_struct_is_pba = ( (rd_idx==5'd24 /* Indirect TLP*/) ? 1'b0 : pba_hit[rd_idx]) & csr_decoder_cmd_out_valid_int;
//    assign csr_decoder_cmd_out_struct_od = rd_idx; 
    assign csr_decoder_cmd_out_struct_od = (rd_idx==INDIRECT_ARB_INDEX) ? 5'd31 : rd_idx[4:0]; // This od is uded by PBA req collector, isn't relevant for Indirect. OD 31 is not used
////////////


        
        ////////////////////////////////////////////////////////////////////////////////////////////
        ///////////////////////////////              Arbitration           //////////////////////////////
        //////////////////////////////////////////////////////////////////////////////////////////// 
    

     // new 6th home has a single OD - NMF(Other) WR
     
     always_comb begin 
         can_pop_from_mn_fifo = '0;
         can_pop_from_mn_fifo[INDIRECT_ARB_INDEX] = csr_decoder_calc_cmd_rdy ;
         for (int h =0; h< NUMBER_OF_HOMES; h++)begin
             for(int o = 0; o<NUMBER_OF_OD_PER_HOME; o++)begin
                 if((o == OTHER_RD_REQ )| (o == LAN_RD_REQ))begin
                     can_pop_from_mn_fifo[(h*NUMBER_OF_OD_PER_HOME) + o] = csr_decoder_calc_cmd_rdy;
                 end
                 else if((o == OTHER_WR_REQ))begin
                     can_pop_from_mn_fifo[(h*NUMBER_OF_OD_PER_HOME) + o] = csr_decoder_calc_cmd_rdy & req_in_rdy_od[{h,1'b0}];
                 end
                 else if((o == LAN_WR_REQ))begin
                     can_pop_from_mn_fifo[(h*NUMBER_OF_OD_PER_HOME) + o] = csr_decoder_calc_cmd_rdy & req_in_rdy_od[{h,1'b1}];
                 end
             end
         end
  
//        can_pop_from_mn_fifo[(5*NUMBER_OF_OD_PER_HOME) + CMN1_ONLY_OD] = csr_decoder_calc_cmd_rdy & req_in_rdy_od[{3'b101,1'b1}]; // 101 is HOST 5 - CMN1 
         
     end

     
          ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        ////////////////////////////                                   Rd Wr ordering                          ////////////////////////////////////////
        ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        
     logic[NUMBER_OF_CLIENTS_PER_OD-1:0] rd_wr_ordering_vld_in;

    logic [NUMBER_OF_HOMES_W-1:0] csr_decoder_cmd_home_for_sent_wr;
     
     always_comb begin
        csr_decoder_cmd_home_for_sent_wr =  glue_logic_csr_decoder_wr_done_single_od_inst[4-1:1] ;
     end
     
     
    logic [5-1:0] sent_wr_idx;
        // find the wr idx for the corresponding fifo of mn_fifo to pull the write request according to the request home and ordering domain
    always_comb begin
        case (glue_logic_csr_decoder_wr_done_single_od_inst[0]) 
            1'b0   : sent_wr_idx = {csr_decoder_cmd_home_for_sent_wr, OTHER_WR_REQ} ; 
            1'b1   : sent_wr_idx = {csr_decoder_cmd_home_for_sent_wr, LAN_WR_REQ} ; 
            default: sent_wr_idx = '0 ;
        endcase
    end
    
    generate
        //@zbaider: NUMBER_OF_CLIENTS_PER_OD - 1 is since there are 11 ODs (5 hosts - LAN+ 5 hosts NMF + CMN1 only WR)
        for(genvar i = 0; i <  NUMBER_OF_CLIENTS_PER_OD-2  ; i ++)begin :  RD_WR_ORDERING //clients/2 = num_homes *OD per home/2
            
            
            //Counters to count the number of entries in the RD WR ORDERING module
            assign number_of_rd_wr_ordering_entries_counter_next[i] = 7'(number_of_rd_wr_ordering_entries_counter[i] 
                                                                      + (7)'(rd_wr_ordering_vld_in[i]) 
                                                                      - (7)'( (sent_rd[i]&sent_wr[i]) ? 2'd2 : sent_rd[i] | sent_wr[i])) ;
            
            always_ff @(posedge clk or negedge rst_n) begin
                if (~rst_n)
                    number_of_rd_wr_ordering_entries_counter[i] <= '0 ;
                else begin
                    number_of_rd_wr_ordering_entries_counter[i] <= number_of_rd_wr_ordering_entries_counter_next[i] ;
                end
                
            end            
                ecip_gen_rd_wr_ordering #(
                 .ORDER_DEPTH (RD_WR_ORDERING_DEPTH), 
                 .ORDERING_FIFO_CAN_GET_FULL(1), //1 -> can get full
                 .SYNC_ON                   ('0) //0 - if the source and destination share the same clock, 1 - otherwise
             )
             u_ecip_gen_rd_wr_ordering (
                 // ordering ind
                 .can_send_rd      (can_send_rd[i]), 
                 // clear read counter or write counter and poping writes for any reason
                 .clear_rd         ('0),
                 .clear_wr         ('0),
                 .clk_rd           (clk),
                 .clk_wr           (clk),
                 .order_add_rdy_out(order_add_rdy_out_arr[i]), 
                 // order line add controls
                 .order_add_vld_in (rd_wr_ordering_vld_in[i]),  //indicate that source have a valid request to send
                 .order_add_wr_rd  (order_add_wr_rd),
                 .rst_rd_n         (rst_n),
                 .rst_wr_n         (rst_n),
                 // req sent ind
                 .sent_rd          (sent_rd[i]), 
                 .sent_wr          (sent_wr[i])
                 );
                        
        end
        
    endgenerate
    
    assign dfd_ordering_fifos_full = order_add_rdy_out_arr;
    assign dfd_ordering_fifos_valid = can_send_rd;
    
            // need to to do & on 2 vectors: can_send_rd &vld_out_arrand this goes to rdy_in of arbitrer
        always_comb begin
            sent_rd = '0;
            
            sent_rd[rd_idx[NUMBER_OF_CLIENTS_PER_OD_W:1]] =  (~rd_idx[0])  & do_arb;
            
            sent_wr = '0;
            sent_wr [sent_wr_idx[NUMBER_OF_CLIENTS_PER_OD_W:1]] = (glue_logic_csr_decoder_wr_done_valid & fabif_csr_wrdone_tready) ;
            
            rd_wr_ordering_vld_in = '0;
            rd_wr_ordering_vld_in[wr_idx[NUMBER_OF_CLIENTS_PER_OD_W:1]] = csr_decoder_cmd_in_valid & csr_fabif_rwdatacompmd_tready;
           
        end
    


//    logic [NUMBER_OF_CLIENTS-1:0] vld_out_array_for_arb ; 
    logic [NUMBER_OF_CLIENTS+1-1:0] vld_out_array_for_arb ; // +1 for indirect 
    logic [NUMBER_OF_CLIENTS+1-1:0] vld_out_array_for_arb_and_elig ; // +1 for indirect 

     always_comb begin 
         vld_out_array_for_arb = '0;
        vld_out_array_for_arb[NUMBER_OF_CLIENTS] = hif_csrdec_ind_go_compl & (hif_csrdec_ind_req_type ? |mn_fifo_to_nmf_credit_counter_wr : |mn_fifo_to_nmf_credit_counter_rd ) ; // Indirect is the 33rd client
         for (int n =0; n < NUMBER_OF_CLIENTS; n++)begin
                casex (NUMBER_OF_CLIENTS_W'(n))   
                    5'b???00 :  // 00 is rd other
                        vld_out_array_for_arb[n] = (n>19) ? vld_out_arr[n]  : vld_out_arr[n] & can_send_rd[(n/2 + n%2)] & |mn_fifo_to_nmf_credit_counter_rd & ~(pba_busy[n] & pba_hit[n] ); // added n>19 condition since there is no rd wr ordering for 20-23(4 OD's) (CMN1)
                    5'b???10 :  // 10 is rd LAN
                        vld_out_array_for_arb[n] = (n>19) ?  vld_out_arr[n] : vld_out_arr[n] & can_send_rd[(n/2 + n%2)] & ~(pba_busy[n] & pba_hit[n] ); // added n>19 condition since there is no rd wr ordering for 20-23(4 OD's) (CMN1)
                    5'b???01 : // 01, is wr other
                        vld_out_array_for_arb[n] = (n<19) ?  vld_out_arr[n] & |mn_fifo_to_nmf_credit_counter_wr & ~(pba_busy[n]) : vld_out_arr[n] & |mn_fifo_to_nmf_credit_counter_wr & ~(pba_busy[n]);//pba blocks also non-pba writes from the same OD 
                    5'b???11 : //  11 is wr LAN
                        vld_out_array_for_arb[n] = (n<19) ? vld_out_arr[n] & ~(pba_busy[n]) : vld_out_arr[n] & |mn_fifo_to_nmf_credit_counter_wr & ~(pba_busy[n]);//pba blocks also non-pba writes from the same OD 
                    default:
                        vld_out_array_for_arb[n] = (n<19) ? vld_out_arr[n] & ~(pba_busy[n] & pba_hit[n]) : vld_out_arr[n] & |mn_fifo_to_nmf_credit_counter_wr & ~(pba_busy[n] & pba_hit[n]);
                endcase
         end 
     end 
     
    always_comb begin
        indirect_read_from_mn_fifo_rdy = do_arb & (rd_idx==INDIRECT_ARB_INDEX);
    end     
     
     logic done_init;
    
//    assign do_arb = |(vld_out_arr & can_pop_from_mn_fifo) ;
    assign vld_out_array_for_arb_and_elig = (vld_out_array_for_arb & can_pop_from_mn_fifo);
    assign do_arb = |(vld_out_array_for_arb_and_elig) & done_init;
    
    ecip_gen_wrr_arb_v1 #(
//        .CLIENTS     (NUMBER_OF_HOMES),
//        .CLIENTS     (NUMBER_OF_CLIENTS),
        .CLIENTS     (NUMBER_OF_CLIENTS+1), // +1: New client - Indirect flow
        .CREDIT_W(ARB_CREDIT_W),
        .PARALLEL_ARB(1),
        .ARB_DIR(1),
        .WEIGHT_W(ARB_WEIGHT_W)
    )
    u_ecip_gen_wrr_arb (
        //car
        .clk              (clk),
        .rst_n            (rst_n),
        //Arbiter Inputs
        .arb              (do_arb), //Initiates arbitration (last winner is updated, and credit is decremented)
        .client_max_credit({ARB_CREDIT_W'(1'b1),CLIENT_MAX_CREDIT}),   // TODO add credit and weight for Indirect?
        .client_rdy       (vld_out_array_for_arb_and_elig ), //Only ready client can win arbitration. & can_send_rd uses ordering fifo
        .client_weight    ({ARB_WEIGHT_W'(1'b1),CLIENT_WEIGHT}),    // TODO add credit and weight for Indirect?
        // Arbiter outputs
        .arb_vld          (csr_decoder_cmd_out_valid_int), //High when there is an eligible winner 
        .client_credit    (), //Current client credits
        .win_client_last  (), //Previous winner 
        .win_client_next  (rd_idx) //Next winner valid when arb_vld is high
        );
     
        ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        ////////////////////////////                             Credits Control                          ////////////////////////////////////////////
        ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    logic [10-1:0] csr_fabif_rwdatacompmd_cred_tdest_pre_map;
     logic csr_fabif_rwdatacompmd_cred_tvalid_int;
    
     //reconstruct the , home and od from the rd index , for tdest out
    always_comb begin
        if (csr_fabif_rwdatacompmd_cred_tdest_pre_map == 10'd20) begin // d20 is CMN1
            od_out = TDEST_OTHER_WR_REQ; // for CMN1 there are only Writes via NMF so need to map
        end
        else begin
           case (csr_fabif_rwdatacompmd_cred_tdest_pre_map[2-1:0])
                OTHER_RD_REQ      :  begin
                            od_out = TDEST_OTHER_RD_REQ ;
                end
                LAN_RD_REQ      :  begin
                            od_out = TDEST_LAN_RD_REQ ;
                end                    
                OTHER_WR_REQ      :  begin
                            od_out = TDEST_OTHER_WR_REQ ;
                end                                  
                LAN_WR_REQ      :  begin
                            od_out = TDEST_LAN_WR_REQ ;
                end
           endcase
        end
        
        home_out = csr_fabif_rwdatacompmd_cred_tdest_pre_map[NUMBER_OF_CLIENTS_W-1:2] ;
    
    end

    logic   [CREDITS_W-1:0]         csr_fabif_rwdatacompmd_cred_tdata_pre;

    assign wrk_cred_tvalid_ = do_arb & |order_add_rdy_out_arr;
    
        ecip_gen_hm_npq_cdt_ctrl #(
            .NUM_OD                       (NUMBER_OF_CLIENTS), //NUMBER_OF_CLIENTS = number of OD: 21 (CMN1 is only 1 OD)
            .INPUT_BUFFER_SIZE_WIDTH      (MEM_ADDR),  // according to the mn fifo 
            .CREDIT_W                     (CREDITS_W),
            .TDEST_W                      (TDEST_W)
        )
        u_ecip_gen_hm_npq_cdt_ctrl (
            .AUTO_LOAD_DONE    (CSR_AUTOLOAD_DONE), //CSR qualifier input 
//            .AUTO_LOAD_DONE    (1'b1), //CSR qualifier input
            // MN FIFOs offset
            .MNFIFO_END_PTR    (HIF_CSR_DEC_FIFO_ENDOFF), //division of the req input buffer per OD (OD[X] size is OD[x]-OD[X-1])
            .MNFIFO_END_PTR_EN (HIF_CSR_DEC_FIFO_EN) ,
            // car
            .clk               (clk),
             .rst_n             (rst_n),
            // REQ input credit back I/F
            .output_cred_mready(fabif_csr_rwdatacompmd_cred_mready), // client is ready to receive credit
            .output_cred_tdata (csr_fabif_rwdatacompmd_cred_tdata_pre), 
//            .output_cred_tdata (csr_fabif_rwdatacompmd_cred_tdata), 
            .output_cred_tdest (csr_fabif_rwdatacompmd_cred_tdest_pre_map), 
            .output_cred_tvalid(csr_fabif_rwdatacompmd_cred_tvalid_int), 
            
            .done_init(done_init),
            // working phase I/F
            .wrk_cred_mready   (), // indicate the Init phase is done, and working phase can start to return credits
            .wrk_cred_tdata    (wrk_cred_tdata_),   
            .wrk_cred_tdest    (TDEST_W'(rd_idx)), 
//            .wrk_cred_tvalid   (do_arb) 
            .wrk_cred_tvalid   (wrk_cred_tvalid_) 
        );
    
    //////////////////////////////////                                   HOST MAPPING                                 ////////////////////////////////////////////


    // -------------------- Count number of valid hosts (not included CMN0 - it is always there)      --------------------------------------------------------- //
    
    localparam COUNT_ONES_W = 16 ; // same as number of fabric host id in MASK CSR
    localparam COUNT_ONES_OUT_W = $clog2(COUNT_ONES_W+1) ; 
    logic [COUNT_ONES_OUT_W-1:0] masked_hosts_number ;
    logic [COUNT_ONES_OUT_W-1:0] active_hosts_number ;
    
    ecip_gen_count_ones_v1 #(
        .IN_W (16)
    )
    u_ecip_gen_count_ones_v1 (
        .in (CSR_SOURCE_MASK.MASK),
        .out(masked_hosts_number)
        );
    
    // This module count ones but since this is a MASK CSR (and not valid) -> actual number of active hosts is 16 - #out
    assign active_hosts_number = COUNT_ONES_W - masked_hosts_number ;

    // -------------------------------------------------------------------------------------------------------------------------------------------------------- //
   fabric_host_id_e premap_fabric_host_id;
    
    logic [5-1:0] init_stage_tdest_fabric_host_id ;
    logic [3-1:0] init_stage_tdest_od ;
    logic [2-1:0] init_stage_tdest_relative_fabric_host_id;

    logic [3-1:0] premap_cur_host; 
    
    always_comb begin
//        premap_cur_host =  '0;
        
        case (premap_fabric_host_id) 
            CORE_A_PORT0: begin // core 0, rel 0
                premap_cur_host =  {1'b0,GLPCI_CSR_HIFID_TO_NSSHID_0.HOST_ID};
            end
            CORE_A_PORT2: begin // core 0, rel 2
                premap_cur_host =  {1'b0,GLPCI_CSR_HIFID_TO_NSSHID_1.HOST_ID};
            end
            CORE_B_PORT0: begin // core 1, rel 0
                premap_cur_host =  {1'b0,GLPCI_CSR_HIFID_TO_NSSHID_2.HOST_ID};
                
            end
            CORE_B_PORT2: begin // core 1, rel 2
                premap_cur_host =  {1'b0,GLPCI_CSR_HIFID_TO_NSSHID_3.HOST_ID};
                
            end
            CORE_C_PORT0: begin // core 2, rel 0
                premap_cur_host =  {1'b0,GLPCI_CSR_HIFID_TO_NSSHID_4.HOST_ID};
                
            end
            CORE_C_PORT2: begin // core 2, rel 2
                premap_cur_host =  {1'b0,GLPCI_CSR_HIFID_TO_NSSHID_5.HOST_ID};
                
            end
            CORE_D_PORT0: begin // core 3, rel 0
                premap_cur_host =  {1'b0,GLPCI_CSR_HIFID_TO_NSSHID_6.HOST_ID};
                
            end
            CORE_D_PORT2: begin // core 3, rel 2
                premap_cur_host =  {1'b0,GLPCI_CSR_HIFID_TO_NSSHID_7.HOST_ID};
                
            end
            // @zbaider: new HTU to CSRDEC feature - CMN1
            CMN1_RC_NSS: begin //fabric host id 16 = CMN1 = host 5
                premap_cur_host =  3'd5;
                
            end
            NLI1: begin //fabric host id 20 = NL11 = host 5
                premap_cur_host =  3'd5;
                
            end
            default:premap_cur_host = 3'd4 ; // For both CMI0+NLI0
        endcase
    end
    
    
    logic [4-1:0][4-1:0] not_masked_host_ids_index_array; // This is an array of the not masced fabric host ids
    // For ffs module
    logic [16-1:0] dynamic_mask_array;
    logic [4-1:0] dynamic_mask_array_chosen_index;
    logic dynamic_mask_array_chosen_index_valid;
    logic [16-1:0] masked_csr_and_masked_not_chosen ;
    
    logic [2-1:0] counter;
    // Counter for the location in the final index array
    always_ff @(posedge clk or negedge rst_n) begin
        if (~rst_n)
                counter <= '0 ;
        else  if (CSR_AUTOLOAD_DONE & dynamic_mask_array_chosen_index_valid) begin
                counter <= 2'(counter + 1'b1) ;
        end
    end
    
    logic [1-1:0] counter_sticky_bit;
    // Counter sticky bit
    always_ff @(posedge clk or negedge rst_n) begin
        if (~rst_n)
                counter_sticky_bit <= '0 ;
        else begin
                counter_sticky_bit <= (COUNT_ONES_OUT_W'(counter) == active_hosts_number) | counter_sticky_bit ;
        end
    end
    
    
    always_ff @(posedge clk or negedge rst_n) begin
        if (~rst_n)
                not_masked_host_ids_index_array <= {4'b1111, 4'b1111, 4'b1111, 4'b1111} ;
//                not_masked_host_ids_index_array[counter] <= 4'b1111 ;
        else if (CSR_AUTOLOAD_DONE & dynamic_mask_array_chosen_index_valid & ~counter_sticky_bit ) begin
                not_masked_host_ids_index_array[counter] <= dynamic_mask_array_chosen_index ;
        end
    end
    
    // In parellel to calculating the active fabric_host_id's -> calculate their corresponding hosts
    
    logic [4-1:0][3-1:0] host_pre_map_array ; // 0,1,2 0r 3 , extra bit to avoid error
    
    always_ff @(posedge clk or negedge rst_n) begin
        if (~rst_n)
                host_pre_map_array <= {3'b111, 3'b111, 3'b111, 3'b111} ;
        else if (CSR_AUTOLOAD_DONE & dynamic_mask_array_chosen_index_valid & ~counter_sticky_bit ) begin
                host_pre_map_array[counter] <= {1'b0,GLPCI_CSR_HIFID_TO_NSSHID_ARRAY[dynamic_mask_array_chosen_index[4-1:1] ] };
        end
    end
    
    always_comb begin
       for (int k=0 ; k < 16 ; k++)begin
           masked_csr_and_masked_not_chosen[k] = ~CSR_SOURCE_MASK.MASK[k] & dynamic_mask_array[k] & CSR_AUTOLOAD_DONE;
        end
    end
    
    ecip_gen_ffs_v1 #(
        .INP_WDTH    (16)
    )
    u_ecip_gen_ffs_v1 (
        .fs_idx  (dynamic_mask_array_chosen_index),
        .fs_vld  (dynamic_mask_array_chosen_index_valid),
        .inp_vect(masked_csr_and_masked_not_chosen)
    );
 
    always_ff @(posedge clk or negedge rst_n) begin
        if (~rst_n)
                dynamic_mask_array <= {16{1'b1}} ;
        else  if (CSR_AUTOLOAD_DONE & dynamic_mask_array_chosen_index_valid) begin
                dynamic_mask_array[dynamic_mask_array_chosen_index] <= 1'b0 ;
        end
    end
    
    
    always_comb begin
        premap_fabric_host_id = fabric_host_id_e'(5'd31);

        case (csr_fabif_rwdatacompmd_cred_tdest_pre_map[5-1:2])
            3'b000:begin
                    premap_fabric_host_id = (host_pre_map_array[0] == 3'd0 ) ? fabric_host_id_e'(not_masked_host_ids_index_array[0]) :
                                                                     (host_pre_map_array[1] == 3'd0 ) ? fabric_host_id_e'(not_masked_host_ids_index_array[1]) :
                                                                     (host_pre_map_array[2] == 3'd0 ) ? fabric_host_id_e'(not_masked_host_ids_index_array[2]) :
                                                                     (host_pre_map_array[3] == 3'd0 ) ? fabric_host_id_e'(not_masked_host_ids_index_array[3]) : fabric_host_id_e'(31) ;
            end
            3'b001:begin
                    premap_fabric_host_id = (host_pre_map_array[0] == 3'd1 ) ? fabric_host_id_e'(not_masked_host_ids_index_array[0]) :
                                                                     (host_pre_map_array[1] == 3'd1 ) ? fabric_host_id_e'(not_masked_host_ids_index_array[1]) :
                                                                     (host_pre_map_array[2] == 3'd1 ) ? fabric_host_id_e'(not_masked_host_ids_index_array[2]) :
                                                                     (host_pre_map_array[3] == 3'd1 ) ? fabric_host_id_e'(not_masked_host_ids_index_array[3]) : fabric_host_id_e'(31) ;
            end
            3'b010:begin
                    premap_fabric_host_id = (host_pre_map_array[0] == 3'd2 ) ? fabric_host_id_e'(not_masked_host_ids_index_array[0]) :
                                                                     (host_pre_map_array[1] == 3'd2 ) ? fabric_host_id_e'(not_masked_host_ids_index_array[1]) :
                                                                     (host_pre_map_array[2] == 3'd2 ) ? fabric_host_id_e'(not_masked_host_ids_index_array[2]) :
                                                                     (host_pre_map_array[3] == 3'd2 ) ? fabric_host_id_e'(not_masked_host_ids_index_array[3]) : fabric_host_id_e'(31) ;
            end
            3'b011:begin
                    premap_fabric_host_id = (host_pre_map_array[0] == 3'd3 ) ? fabric_host_id_e'(not_masked_host_ids_index_array[0]) :
                                                                     (host_pre_map_array[1] == 3'd3 ) ? fabric_host_id_e'(not_masked_host_ids_index_array[1]) :
                                                                     (host_pre_map_array[2] == 3'd3 ) ? fabric_host_id_e'(not_masked_host_ids_index_array[2]) :
                                                                     (host_pre_map_array[3] == 3'd3 ) ? fabric_host_id_e'(not_masked_host_ids_index_array[3]) : fabric_host_id_e'(31) ;
            end
            // @zbaider: new HTU to CSRDEC feature - CMN1
            3'b101:begin // OD 21 is CMN1 (fabric host id = 16)
                premap_fabric_host_id = NLI1;//CMN1_RC_NSS; // CMN1 is always there same as CMN0 TODO add cmn support
            end
            
            // =================== Adding NLI0 and NLI1  ========================
            3'b110:begin // NLI0 (fabric host id = 19)
                premap_fabric_host_id = NLI0; // NLI0 is always there same as CMN0
            end
            3'b111:begin // NLI1 (fabric host id = 20)
                premap_fabric_host_id = NLI1; // NLI1 is always there same as CMN0
            end
            
            // ===================================================================
            
            default: premap_fabric_host_id = NLI0;//CMN0_EP_RC_ACC ; // CMN0
        endcase

    
    end

    //To store the amount of credits that are available per each FIFO in the initializatiomn stage
    logic [NUMBER_OF_CLIENTS-1:0][CREDITS_W-1:0] fabif_cred_tdata_init_per_fifo;
    
   always_comb begin
       fabif_cred_tdata_init_per_fifo = '0;
       fabif_cred_tdata_init_per_fifo[csr_fabif_rwdatacompmd_cred_tdest_pre_map] = csr_fabif_rwdatacompmd_cred_tdata_pre;
   end

    logic [2-1:0] od_to_calcl_correct_fifo;
    
    always_comb begin
        od_to_calcl_correct_fifo = '0;
        case (init_stage_tdest_od) 
                    TDEST_OTHER_RD_REQ      :  od_to_calcl_correct_fifo =  OTHER_RD_REQ ; 
                    TDEST_LAN_RD_REQ      :  od_to_calcl_correct_fifo =  LAN_RD_REQ ; 
                    TDEST_OTHER_WR_REQ      :  od_to_calcl_correct_fifo =  OTHER_WR_REQ ; 
                    TDEST_LAN_WR_REQ      :  od_to_calcl_correct_fifo =  LAN_WR_REQ ; 
        endcase
    end

    logic [CREDITS_W-1:0] init_stage_tdata;
    
   
    always_comb begin
        if (~CSR_AUTOLOAD_DONE) begin 
            init_stage_tdest_fabric_host_id = '0;
            init_stage_tdest_od = '0;
            init_stage_tdest_relative_fabric_host_id = '0 ;
            init_stage_tdata = '0;
        end
        else begin
            init_stage_tdest_fabric_host_id =  5'(premap_fabric_host_id);
            init_stage_tdata = fabif_cred_tdata_init_per_fifo[{premap_cur_host,2'b0}+od_to_calcl_correct_fifo];
            //fabif_cred_tdata_init_per_fifo
            init_stage_tdest_od = od_out;
            
            init_stage_tdest_relative_fabric_host_id = '0; //@zbaider: 23 January - HSD: https://hsdes.intel.com/appstore/article/#/16022656857

        end
    end

        logic access_bar_2_or_3 ,hit_pcie_pba, hit_ims_pba , pe_support_ims;
        logic pba_clear_tran , msix_bar_0_1_addr_in_range , msix_need_to_tran;
    
    localparam LAN_BAR_0_1_MSIX_S_OFFSET_PF         = 32'h0890_0000;
    localparam LAN_BAR_0_1_MSIX_E_OFFSET_PF         = 32'h0A4F_FFFF;
    localparam LAN_BAR_0_1_MSIX_S_OFFSET_PF_5K      = 32'h1440_0000;
    localparam LAN_BAR_0_1_MSIX_E_OFFSET_PF_5K      = 32'h157F_FFFF;    
    localparam LAN_BAR_0_1_MSIX_INT_S_OFFSET_VF     = 32'h2800;
    localparam LAN_BAR_0_1_MSIX_INT_E_OFFSET_VF     = 32'h5FFF;
    localparam LAN_BAR_0_1_MSIX_EXT_INT_S_OFFSET_VF = 32'h7_0000;
    localparam LAN_BAR_0_1_MSIX_EXT_INT_E_OFFSET_VF = 32'h7_7FFF;
    localparam LAN_PBA_CLEAR_VF                     = 32'h8900;
    localparam LAN_PBA_CLEAR_PF                     = 32'h840_6014;
    localparam LCE_PBA_CLEAR                        = 32'h104_102C;
    localparam ATE_CPF_PBA_CLEAR                    = 32'h20_182C ;
    localparam NVME_CPF_PBA_CLEAR                   = 32'h00FC_002C;
    localparam ARM_OFFLOAD_BACKEND_PBA_CLEAR        = 32'h001_FFAC;
    localparam NVME_TILE_1_CPF_PBA_CLEAR            = 32'h02FC_002C; // MMG800
    localparam ARM_OFFLOAD_SEP_FRONTEND_PBA_CLEAR   = 32'h2C;// MMG800
    
    localparam int unsigned BAR_0                      = $bits(NUMBER_OF_BARS_W)'(0);
    localparam int unsigned BAR_1                      = $bits(NUMBER_OF_BARS_W)'(1);
    localparam int unsigned BAR_2                      = $bits(NUMBER_OF_BARS_W)'(2);
    localparam int unsigned BAR_3                      = $bits(NUMBER_OF_BARS_W)'(3);
//for timing sampled in MN_FIFO reserved        
        assign pe_support_ims = (csr_decoder_cmd_in_struct.cmd.pe_id == REQ_ID_LCE) | 
                                (csr_decoder_cmd_in_struct.cmd.pe_id == REQ_ID_LAN_RDMA) | 
                                (csr_decoder_cmd_in_struct.cmd.pe_id == REQ_ID_NVME);
        assign hit_ims_pba =  ((csr_decoder_cmd_in_struct.cmd.pe_id==REQ_ID_LAN_RDMA)  || 
                               (csr_decoder_cmd_in_struct.cmd.pe_id==REQ_ID_NVME) ||
                               (csr_decoder_cmd_in_struct.cmd.pe_id==REQ_ID_LCE)    ) && 
                              (in_range(csr_decoder_cmd_in_struct.cmd.req_addr , ADDR_MSIX_IMS_PBA_OFFSET_S , ADDR_MSIX_IMS_PBA_OFFSET_E)) &&
                              csr_decoder_cmd_in_struct.cmd.csr_req_params.ftype[1] && pe_support_ims;
        assign hit_pcie_pba = in_range(csr_decoder_cmd_in_struct.cmd.req_addr , ADDR_MSIX_PBA_OFFEST_S , ADDR_MSIX_PBA_OFFEST_E);
        assign access_bar_2_or_3 = ( (csr_decoder_cmd_in_struct.cmd.bar_id == 3'd2) | 
                                                                (csr_decoder_cmd_in_struct.cmd.bar_id == 3'd3) ) & (~csr_decoder_cmd_in_struct.cmd.zl_read) ;
    
        
        assign pba_clear_tran = ((csr_decoder_cmd_in_struct.cmd.bar_id == BAR_0) | (csr_decoder_cmd_in_struct.cmd.bar_id == BAR_1)) &(
                                                                                                                    ((REQ_ID_LAN_RDMA == csr_decoder_cmd_in_struct.cmd.pe_id)  & (csr_decoder_cmd_in_struct.cmd.req_addr == LAN_PBA_CLEAR_PF) & (|csr_decoder_cmd_in_struct.cmd.csr_req_params.ftype)) |
                                                                                                                    ((REQ_ID_LAN_RDMA== csr_decoder_cmd_in_struct.cmd.pe_id) & (csr_decoder_cmd_in_struct.cmd.req_addr == LAN_PBA_CLEAR_VF) & ~(|csr_decoder_cmd_in_struct.cmd.csr_req_params.ftype)) |
                                                                                                                    ((REQ_ID_LCE == csr_decoder_cmd_in_struct.cmd.pe_id) & (csr_decoder_cmd_in_struct.cmd.req_addr == LCE_PBA_CLEAR) & (|csr_decoder_cmd_in_struct.cmd.csr_req_params.ftype)) |
                                                                                                                    ((REQ_ID_ACC_BKND == csr_decoder_cmd_in_struct.cmd.pe_id) & (csr_decoder_cmd_in_struct.cmd.req_addr == ARM_OFFLOAD_BACKEND_PBA_CLEAR) & (|csr_decoder_cmd_in_struct.cmd.csr_req_params.ftype)) |                                           
                                                                                                                    ((REQ_ID_NVME== csr_decoder_cmd_in_struct.cmd.pe_id) & (csr_decoder_cmd_in_struct.cmd.req_addr == NVME_CPF_PBA_CLEAR) & (|csr_decoder_cmd_in_struct.cmd.csr_req_params.ftype)) |
                                                                                                                    ((REQ_ID_ATE == csr_decoder_cmd_in_struct.cmd.pe_id) & (csr_decoder_cmd_in_struct.cmd.req_addr == ATE_CPF_PBA_CLEAR) & (|csr_decoder_cmd_in_struct.cmd.csr_req_params.ftype)) |
                                                                                                                    ((REQ_ID_NVME== csr_decoder_cmd_in_struct.cmd.pe_id) & (csr_decoder_cmd_in_struct.cmd.req_addr == NVME_TILE_1_CPF_PBA_CLEAR) & (|csr_decoder_cmd_in_struct.cmd.csr_req_params.ftype)) | //MMG800
                                                                                                                    ((REQ_ID_ACC_SEP == csr_decoder_cmd_in_struct.cmd.pe_id) & (csr_decoder_cmd_in_struct.cmd.req_addr == 32'(PFSEP_FE_MBX_BAR_ADDRESS.ADDR + ARM_OFFLOAD_SEP_FRONTEND_PBA_CLEAR)) & (|csr_decoder_cmd_in_struct.cmd.csr_req_params.ftype)) //MMG800 
                                                                                                                   );

    assign msix_bar_0_1_addr_in_range = (csr_decoder_cmd_in_struct.cmd.csr_req_params.ftype == 2'b10) ?  // 2b'10 indicates that resources belongs to pf (2'b00 is VF, else is reserved)
        (((in_range(csr_decoder_cmd_in_struct.cmd.req_addr , LAN_BAR_0_1_MSIX_S_OFFSET_PF , LAN_BAR_0_1_MSIX_E_OFFSET_PF)) | 
          (in_range(csr_decoder_cmd_in_struct.cmd.req_addr , LAN_BAR_0_1_MSIX_S_OFFSET_PF_5K , LAN_BAR_0_1_MSIX_E_OFFSET_PF_5K)))
            & (~(|csr_decoder_cmd_in_struct.cmd.req_addr[11 : 4]))) : // int range and If BAR offset % 4K >=  16 transaction not valid
        (in_range(csr_decoder_cmd_in_struct.cmd.req_addr , LAN_BAR_0_1_MSIX_INT_S_OFFSET_VF , LAN_BAR_0_1_MSIX_INT_E_OFFSET_VF) | in_range(csr_decoder_cmd_in_struct.cmd.req_addr , LAN_BAR_0_1_MSIX_EXT_INT_S_OFFSET_VF , LAN_BAR_0_1_MSIX_EXT_INT_E_OFFSET_VF));

    assign msix_need_to_tran = ~(~csr_decoder_cmd_in_struct.cmd_tdest[5] & ~csr_decoder_cmd_in_struct.cmd.trans_req) & (~csr_decoder_cmd_in_struct.cmd.zl_read) & (pba_clear_tran |
        ((csr_decoder_cmd_in_struct.cmd.bar_id == BAR_2) |
         (csr_decoder_cmd_in_struct.cmd.bar_id == BAR_3) |
        ((REQ_ID_LAN_RDMA == csr_decoder_cmd_in_struct.cmd.pe_id) & ((csr_decoder_cmd_in_struct.cmd.bar_id == BAR_0) | (csr_decoder_cmd_in_struct.cmd.bar_id == BAR_1))
          & msix_bar_0_1_addr_in_range)) );
    
    
    always_comb begin
        csr_decoder_cmd_in_struct_to_mn_fifo = csr_decoder_cmd_in_struct;
        csr_decoder_cmd_in_struct_to_mn_fifo.cmd_home_num = csr_decoder_cmd_home_in;
        csr_decoder_cmd_in_struct_to_mn_fifo.pba_hit =  ~(csr_decoder_cmd_in_struct.cmd_home_num==3'd5) & ~(~csr_decoder_cmd_in_struct.cmd.trans_req & ~csr_decoder_cmd_in_struct.cmd_tdest[5]) & access_bar_2_or_3 && (hit_ims_pba | hit_pcie_pba);
        csr_decoder_cmd_in_struct_to_mn_fifo.cmd.msix_need_to_tran = msix_need_to_tran;
    end
    
    logic                                                 csr_fabif_rwdatacompmd_cred_tvalid_pre_sam;   
    logic   [CREDITS_W-1:0]                               csr_fabif_rwdatacompmd_cred_tdata_pre_sam;    
    fabric_if_hif_if_tdest_t                              csr_fabif_rwdatacompmd_cred_tdest_pre_sam;       
    
    always_comb begin
        csr_fabif_rwdatacompmd_cred_tvalid_pre_sam = 1'b0;
        csr_fabif_rwdatacompmd_cred_tdest_pre_sam = '0;
        csr_fabif_rwdatacompmd_cred_tdata_pre_sam = '0;
        if(csr_fabif_rwdatacompmd_cred_tvalid_int & ~do_arb )begin // init
                // @zbaider: new HTU to CSRDEC feature - CMN1
            csr_fabif_rwdatacompmd_cred_tvalid_pre_sam = ( (init_stage_tdest_fabric_host_id == NLI0) | 
                                                           (init_stage_tdest_fabric_host_id == NLI1) |  
                                                           (init_stage_tdest_fabric_host_id == CMN1_RC_NSS) | 
                                                           (init_stage_tdest_fabric_host_id == CMN0_EP_RC_ACC) ) ?
                                                          1'b1 : 
                                                          (init_stage_tdest_fabric_host_id < 5'd15) & ~CSR_SOURCE_MASK.MASK[init_stage_tdest_fabric_host_id] ; //SOURCE_MASK is 16 bits
//            csr_fabif_rwdatacompmd_cred_tvalid = (init_stage_tdest_fabric_host_id == 5'd18) ? 1'b1 : (init_stage_tdest_fabric_host_id < 5'd15) & ~CSR_SOURCE_MASK.MASK[init_stage_tdest_fabric_host_id] ; //SOURCE_MASK is 16 bits
            csr_fabif_rwdatacompmd_cred_tdest_pre_sam.fabric_host_id= fabric_host_id_e'(init_stage_tdest_fabric_host_id) ;
            csr_fabif_rwdatacompmd_cred_tdest_pre_sam.od= init_stage_tdest_od;
            csr_fabif_rwdatacompmd_cred_tdest_pre_sam.rel_port_id= init_stage_tdest_relative_fabric_host_id; 
            csr_fabif_rwdatacompmd_cred_tdata_pre_sam = init_stage_tdata ;
            end
        else if(do_arb & (rd_idx != 5'd24) /* no cred publish for Indirect */ )begin// work stage
            csr_fabif_rwdatacompmd_cred_tvalid_pre_sam = csr_fabif_rwdatacompmd_cred_tvalid_int;
            csr_fabif_rwdatacompmd_cred_tdest_pre_sam.fabric_host_id = csr_decoder_cmd_out_struct.cmd_tdest.fabric_host_id;
            csr_fabif_rwdatacompmd_cred_tdest_pre_sam.od= {rd_idx[0],1'b0,rd_idx[1]}; // rd_idx is {home, od} 00->000, 01-> 001.  10->100, 11-? 101
//            csr_fabif_rwdatacompmd_cred_tdest_pre_sam.rel_port_id=  csr_decoder_cmd_out_struct.cmd_tdest.rel_port_id;
            csr_fabif_rwdatacompmd_cred_tdest_pre_sam.rel_port_id=  '0 ; //@zbaider: 23 January - HSD: https://hsdes.intel.com/appstore/article/#/16022656857
            csr_fabif_rwdatacompmd_cred_tdata_pre_sam = csr_fabif_rwdatacompmd_cred_tdata_pre;
        end
    end
    
    always_ff @(posedge clk or negedge rst_n) begin
        if (~rst_n) begin
            csr_fabif_rwdatacompmd_cred_tvalid <= '0 ;
            csr_fabif_rwdatacompmd_cred_tdest <= '0 ;
            csr_fabif_rwdatacompmd_cred_tdata <= '0 ;
        end
        
        else  begin
            csr_fabif_rwdatacompmd_cred_tvalid <= csr_fabif_rwdatacompmd_cred_tvalid_pre_sam & fabif_csr_rwdatacompmd_cred_mready & (~stop_if_active_mem_sampled);
            csr_fabif_rwdatacompmd_cred_tdest  <= csr_fabif_rwdatacompmd_cred_tdest_pre_sam; 
            csr_fabif_rwdatacompmd_cred_tdata  <= csr_fabif_rwdatacompmd_cred_tdata_pre_sam ; 
        end
    end
    
        assign csr_decoder_cmd_out_valid = csr_decoder_cmd_out_valid_int & do_arb;
 // VISA   
always_comb begin
    visa_glue_req[0] =      vld_out_arr[0];
    visa_glue_req[1] =      vld_out_arr[1];
    visa_glue_req[2] =      vld_out_arr[2];
    visa_glue_req[3] =      vld_out_arr[3];
    visa_glue_req[4] =      vld_out_arr[4];
    visa_glue_req[5] =      vld_out_arr[5];
    visa_glue_req[6] =      vld_out_arr[6];
    visa_glue_req[7] =      vld_out_arr[7];
    
    visa_glue_req[8+0] =    vld_out_arr[8];
    visa_glue_req[8+1] =    vld_out_arr[9];
    visa_glue_req[8+2] =    vld_out_arr[10];
    visa_glue_req[8+3] =    vld_out_arr[11];
    visa_glue_req[8+4] =    vld_out_arr[12];
    visa_glue_req[8+5] =    vld_out_arr[13];
    visa_glue_req[8+6] =    vld_out_arr[14];
    visa_glue_req[8+7] =    vld_out_arr[15];
                            
    visa_glue_req[16+0] =   vld_out_arr[16];
    visa_glue_req[16+1] =   vld_out_arr[17];
    visa_glue_req[16+2] =   vld_out_arr[18];
    visa_glue_req[16+3] =   vld_out_arr[19];
    visa_glue_req[16+4] =   vld_out_arr[20];
    visa_glue_req[16+5] =   vld_out_arr[21];
    visa_glue_req[16+6] =   vld_out_arr[22];
    visa_glue_req[16+7] =   vld_out_arr[23];
                      
    visa_glue_req[24+0] =   vld_out_array_for_arb[0]; 
    visa_glue_req[24+1] =   vld_out_array_for_arb[1]; 
    visa_glue_req[24+2] =   vld_out_array_for_arb[2]; 
    visa_glue_req[24+3] =   vld_out_array_for_arb[3]; 
    visa_glue_req[24+4] =   vld_out_array_for_arb[4]; 
    visa_glue_req[24+5] =   vld_out_array_for_arb[5]; 
    visa_glue_req[24+6] =   vld_out_array_for_arb[6]; 
    visa_glue_req[24+7] =   vld_out_array_for_arb[7]; 
                                            
    visa_glue_req[32+0] =   vld_out_array_for_arb[8]; 
    visa_glue_req[32+1] =   vld_out_array_for_arb[9]; 
    visa_glue_req[32+2] =   vld_out_array_for_arb[10];
    visa_glue_req[32+3] =   vld_out_array_for_arb[11];
    visa_glue_req[32+4] =   vld_out_array_for_arb[12];
    visa_glue_req[32+5] =   vld_out_array_for_arb[13];
    visa_glue_req[32+6] =   vld_out_array_for_arb[14];
    visa_glue_req[32+7] =   vld_out_array_for_arb[15];
                                            
    visa_glue_req[40+0] =   vld_out_array_for_arb[16];
    visa_glue_req[40+1] =   vld_out_array_for_arb[17];
    visa_glue_req[40+2] =   vld_out_array_for_arb[18];
    visa_glue_req[40+3] =   vld_out_array_for_arb[19];
    visa_glue_req[40+4] =   vld_out_array_for_arb[20];
    visa_glue_req[40+5] =   vld_out_array_for_arb[21];
    visa_glue_req[40+6] =   vld_out_array_for_arb[22];
    visa_glue_req[40+7] =   vld_out_array_for_arb[23];
    
    visa_glue_req[48+0] = csr_fabif_rwdatacompmd_cred_tvalid;                 
    visa_glue_req[48+1] = csr_fabif_rwdatacompmd_cred_tdest.fabric_host_id[0];
    visa_glue_req[48+2] = csr_fabif_rwdatacompmd_cred_tdest.fabric_host_id[1];
    visa_glue_req[48+3] = csr_fabif_rwdatacompmd_cred_tdest.fabric_host_id[2];
    visa_glue_req[48+4] = csr_fabif_rwdatacompmd_cred_tdest.fabric_host_id[3];
    visa_glue_req[48+5] = csr_fabif_rwdatacompmd_cred_tdest.fabric_host_id[4];
    visa_glue_req[48+6] = csr_fabif_rwdatacompmd_cred_tdest.od[0];
    visa_glue_req[48+7] = csr_fabif_rwdatacompmd_cred_tdest.od[2];
    
    visa_glue_req[56+0] = csr_fabif_rwdatacompmd_cred_tvalid_int;
    visa_glue_req[56+1] = csr_fabif_rwdatacompmd_cred_tdest.fabric_host_id[0];
    visa_glue_req[56+2] = csr_fabif_rwdatacompmd_cred_tdest.fabric_host_id[1];
    visa_glue_req[56+3] = csr_fabif_rwdatacompmd_cred_tdest.fabric_host_id[2];
    visa_glue_req[56+4] = csr_fabif_rwdatacompmd_cred_tdest.fabric_host_id[3];
    visa_glue_req[56+5] = csr_fabif_rwdatacompmd_cred_tdest.fabric_host_id[4];
    visa_glue_req[56+6] = csr_fabif_rwdatacompmd_cred_tdest.od[0];            
    visa_glue_req[56+7] = csr_fabif_rwdatacompmd_cred_tdest.od[2];            
    
    
     
end    
    // ASSERTIONS
    
    // EOT CHECKER

     //*****************************************************************************************
// EOT CHECKER
//*****************************************************************************************

    assign idle = ~(|vld_out_arr) ;


//*****************************************************************************************
// EOT
//*****************************************************************************************

`ifdef INTEL_SIMONLY
    `ECIP_GEN_EOT(hif_pcie_csr_decoder_glue_logic_request, hif_pcie_csr_decoder_glue_logic_request_not_idle, idle, EOT arrived but csr decoder glue logic request is not idle)

`endif
    
`ifndef  INTEL_DC
    `ifndef  INTEL_EMULATION
        `ifndef  INTEL_SVA_OFF 

            `include "hif_pcie_csr_decoder_glue_logic_request_cov.sv" 
        `endif
   `endif
`endif
endmodule

