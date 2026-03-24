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
 -- Module Name       : IW_fpga_dbg_logger_addr_map_avmm_wrapper
 -- Author            : Gregory James
 -- Associated modules: 
 -- Function          : This is a wrapper for mapping RDL generated RTL to
                        Avalon-MM protocol for debug-logger block
 --------------------------------------------------------------------------
*/

`timescale 1ns / 10ps

module IW_fpga_dbg_logger_addr_map_avmm_wrapper #(
    parameter SBR_TYPE                      = "dbgl"             //Should be either sbr,prim,dbgl 
  , parameter INSTANCE_NAME                 = "u_dbg_logger"     //Can hold upto 16 ASCII characters
  , parameter FPGA_DEVICE_FAMILY            = "s5"               //Can hold upto 4  ASCII characters
  , parameter DDR_AVL_ADDR_WIDTH            = 26
  , parameter DDR_AVL_DATA_WIDTH            = 256
  , parameter MAX_MEM_PARTITIONS            = 1
  , parameter int PARTITION_START_PTR_INIT_LIST [MAX_MEM_PARTITIONS-1:0]  = '{default:'0}
  , parameter int PARTITION_END_PTR_INIT_LIST   [MAX_MEM_PARTITIONS-1:0]  = '{default:'0}

  /*  Do Not Modify */
  , parameter AV_MM_DATA_W        = 32
  , parameter AV_MM_ADDR_W        = 16
  , parameter READ_MISS_VAL       = 32'hdeadbabe

) (


  //Avalon-MM Interface
    input    logic                                      csr_clk
  , input    logic                                      rst_csr_n

  , input    logic            [AV_MM_ADDR_W-1:0]        avl_mm_address
  , output   logic            [AV_MM_DATA_W-1:0]        avl_mm_readdata
  , input    logic                                      avl_mm_read
  , output   logic                                      avl_mm_readdatavalid
  , input    logic                                      avl_mm_write
  , input    logic            [AV_MM_DATA_W-1:0]        avl_mm_writedata
  , input    logic            [(AV_MM_DATA_W/8)-1:0]    avl_mm_byteenable
  , output   logic                                      avl_mm_waitrequest

  //CSR
  , output   logic                                      init_queues
  , output   logic            [DDR_AVL_ADDR_WIDTH-1:0]  queue_start_ptr_arry      [MAX_MEM_PARTITIONS-1:0]
  , output   logic            [DDR_AVL_ADDR_WIDTH-1:0]  queue_end_ptr_arry        [MAX_MEM_PARTITIONS-1:0]
  , output   logic            [MAX_MEM_PARTITIONS-1:0]  queue_mode
  , output   logic            [DDR_AVL_ADDR_WIDTH-1:0]  queue_locs_read           [MAX_MEM_PARTITIONS-1:0]
  , output   logic            [MAX_MEM_PARTITIONS-1:0]  queue_locs_rddone
  , input    logic            [DDR_AVL_ADDR_WIDTH-1:0]  queue_occ_arry            [MAX_MEM_PARTITIONS-1:0]
  , input    logic            [DDR_AVL_ADDR_WIDTH-1:0]  queue_wptr_arry           [MAX_MEM_PARTITIONS-1:0]
  , input    logic            [DDR_AVL_ADDR_WIDTH-1:0]  queue_rptr_arry           [MAX_MEM_PARTITIONS-1:0]

  //DDR control / status
  , output   logic                                      ddr_cntrlr_glbl_rst_n
  , output   logic                                      ddr_cntrlr_soft_rst_n
  , input    logic                                      ddr_ecc_err_detect
  , input    logic                                      ddr_pll_locked
  , input    logic                                      ddr_local_cal_fail
  , input    logic                                      ddr_local_cal_success
  , input    logic                                      ddr_local_init_done

);


  /*  Import Packages */
  import IW_fpga_dbg_logger_av_addr_map_pkg::*;
  import rtlgen_pkg_IW_fpga_dbg_logger_av_addr_map::*;

  /*  Internal Parameters */


  /*  Internal Signals  */
  integer n;
  genvar  i;

  reg   [0:3] [7:0] mon_type_str    = SBR_TYPE;
  reg   [0:15][7:0] inst_name_str   = INSTANCE_NAME;
  reg   [0:3] [7:0] fpga_dev_family = FPGA_DEVICE_FAMILY;
  reg   [7:0]       partition_id;
  wire              ddr_cntrlr_glbl_rst_n_f_rst_n;
  wire              ddr_cntrlr_soft_rst_n_f_rst_n;
  reg   [1:0]       ddr_ecc_err_detect_sync;
  reg   [1:0]       ddr_pll_locked_sync;
  reg   [1:0]       ddr_local_cal_fail_sync;
  reg   [1:0]       ddr_local_cal_success_sync;
  reg   [1:0]       ddr_local_init_done_sync;

  new_ddr_phy_status_reg_cr_t             new_ddr_phy_status_reg_cr;
  new_inst_name_0_reg_cr_t                new_inst_name_0_reg_cr;
  new_inst_name_1_reg_cr_t                new_inst_name_1_reg_cr;
  new_inst_name_2_reg_cr_t                new_inst_name_2_reg_cr;
  new_inst_name_3_reg_cr_t                new_inst_name_3_reg_cr;
  new_params0_reg_cr_t                    new_params0_reg_cr;
  new_params1_reg_cr_t                    new_params1_reg_cr;
  new_partition_occupancy_reg_cr_t        new_partition_occupancy_reg_cr;
  new_read_addr_ptr_reg_cr_t              new_read_addr_ptr_reg_cr;
  new_sbr_type_reg_cr_t                   new_sbr_type_reg_cr;
  new_write_addr_ptr_reg_cr_t             new_write_addr_ptr_reg_cr;

  handcode_rdata_cntrl_reg_cr_t           handcode_rdata_cntrl_reg_cr;
  handcode_rdata_end_addr_ptr_reg_cr_t    handcode_rdata_end_addr_ptr_reg_cr;
  handcode_rdata_partition_mode_reg_cr_t  handcode_rdata_partition_mode_reg_cr;
  handcode_rdata_start_addr_ptr_reg_cr_t  handcode_rdata_start_addr_ptr_reg_cr;
  handcode_rdata_queue_locs_read_reg_cr_t handcode_rdata_queue_locs_read_reg_cr;

  cntrl_reg_cr_t                          cntrl_reg_cr;
  ddr_phy_cntrl_reg_cr_t                  ddr_phy_cntrl_reg_cr;
  ddr_phy_status_reg_cr_t                 ddr_phy_status_reg_cr;
  end_addr_ptr_reg_cr_t                   end_addr_ptr_reg_cr;
  inst_name_0_reg_cr_t                    inst_name_0_reg_cr;
  inst_name_1_reg_cr_t                    inst_name_1_reg_cr;
  inst_name_2_reg_cr_t                    inst_name_2_reg_cr;
  inst_name_3_reg_cr_t                    inst_name_3_reg_cr;
  params0_reg_cr_t                        params0_reg_cr;
  params1_reg_cr_t                        params1_reg_cr;
  partition_mode_reg_cr_t                 partition_mode_reg_cr;
  partition_occupancy_reg_cr_t            partition_occupancy_reg_cr;
  read_addr_ptr_reg_cr_t                  read_addr_ptr_reg_cr;
  sbr_type_reg_cr_t                       sbr_type_reg_cr;
  start_addr_ptr_reg_cr_t                 start_addr_ptr_reg_cr;
  write_addr_ptr_reg_cr_t                 write_addr_ptr_reg_cr;

  handcode_wdata_cntrl_reg_cr_t           handcode_wdata_cntrl_reg_cr;
  handcode_wdata_end_addr_ptr_reg_cr_t    handcode_wdata_end_addr_ptr_reg_cr;
  handcode_wdata_partition_mode_reg_cr_t  handcode_wdata_partition_mode_reg_cr;
  handcode_wdata_start_addr_ptr_reg_cr_t  handcode_wdata_start_addr_ptr_reg_cr;
  handcode_wdata_queue_locs_read_reg_cr_t handcode_wdata_queue_locs_read_reg_cr;

  we_cntrl_reg_cr_t                       we_cntrl_reg_cr;
  we_end_addr_ptr_reg_cr_t                we_end_addr_ptr_reg_cr;
  we_partition_mode_reg_cr_t              we_partition_mode_reg_cr;
  we_start_addr_ptr_reg_cr_t              we_start_addr_ptr_reg_cr;
  we_queue_locs_read_reg_cr_t             we_queue_locs_read_reg_cr;

  IW_fpga_dbg_logger_av_addr_map_cr_req_t  req;
  IW_fpga_dbg_logger_av_addr_map_cr_ack_t  ack;
 

  /*
    * Instantiate RDL
  */
  IW_fpga_dbg_logger_av_addr_map            u_addr_map
  (
     .gated_clk                             (csr_clk)

    ,.rst_n                                 (rst_csr_n)

    ,.new_ddr_phy_status_reg_cr             (new_ddr_phy_status_reg_cr            )
    ,.new_inst_name_0_reg_cr                (new_inst_name_0_reg_cr               )
    ,.new_inst_name_1_reg_cr                (new_inst_name_1_reg_cr               )
    ,.new_inst_name_2_reg_cr                (new_inst_name_2_reg_cr               )
    ,.new_inst_name_3_reg_cr                (new_inst_name_3_reg_cr               )
    ,.new_params0_reg_cr                    (new_params0_reg_cr                   )
    ,.new_params1_reg_cr                    (new_params1_reg_cr                   )
    ,.new_partition_occupancy_reg_cr        (new_partition_occupancy_reg_cr       )
    ,.new_read_addr_ptr_reg_cr              (new_read_addr_ptr_reg_cr             )
    ,.new_sbr_type_reg_cr                   (new_sbr_type_reg_cr                  )
    ,.new_write_addr_ptr_reg_cr             (new_write_addr_ptr_reg_cr            )

    ,.handcode_rdata_cntrl_reg_cr           (handcode_rdata_cntrl_reg_cr          )
    ,.handcode_rdata_end_addr_ptr_reg_cr    (handcode_rdata_end_addr_ptr_reg_cr   )
    ,.handcode_rdata_partition_mode_reg_cr  (handcode_rdata_partition_mode_reg_cr )
    ,.handcode_rdata_start_addr_ptr_reg_cr  (handcode_rdata_start_addr_ptr_reg_cr )
    ,.handcode_rdata_queue_locs_read_reg_cr (handcode_rdata_queue_locs_read_reg_cr)

    ,.cntrl_reg_cr                          (cntrl_reg_cr                         )
    ,.ddr_phy_cntrl_reg_cr                  (ddr_phy_cntrl_reg_cr                 )
    ,.ddr_phy_status_reg_cr                 (ddr_phy_status_reg_cr                )
    ,.end_addr_ptr_reg_cr                   (end_addr_ptr_reg_cr                  )
    ,.inst_name_0_reg_cr                    (inst_name_0_reg_cr                   )
    ,.inst_name_1_reg_cr                    (inst_name_1_reg_cr                   )
    ,.inst_name_2_reg_cr                    (inst_name_2_reg_cr                   )
    ,.inst_name_3_reg_cr                    (inst_name_3_reg_cr                   )
    ,.params0_reg_cr                        (params0_reg_cr                       )
    ,.params1_reg_cr                        (params1_reg_cr                       )
    ,.partition_mode_reg_cr                 (partition_mode_reg_cr                )
    ,.partition_occupancy_reg_cr            (partition_occupancy_reg_cr           )
    ,.read_addr_ptr_reg_cr                  (read_addr_ptr_reg_cr                 )
    ,.sbr_type_reg_cr                       (sbr_type_reg_cr                      )
    ,.start_addr_ptr_reg_cr                 (start_addr_ptr_reg_cr                )
    ,.write_addr_ptr_reg_cr                 (write_addr_ptr_reg_cr                )

    ,.handcode_wdata_cntrl_reg_cr           (handcode_wdata_cntrl_reg_cr          )
    ,.handcode_wdata_end_addr_ptr_reg_cr    (handcode_wdata_end_addr_ptr_reg_cr   )
    ,.handcode_wdata_partition_mode_reg_cr  (handcode_wdata_partition_mode_reg_cr )
    ,.handcode_wdata_start_addr_ptr_reg_cr  (handcode_wdata_start_addr_ptr_reg_cr )
    ,.handcode_wdata_queue_locs_read_reg_cr (handcode_wdata_queue_locs_read_reg_cr )

    ,.we_cntrl_reg_cr                       (we_cntrl_reg_cr                      )
    ,.we_end_addr_ptr_reg_cr                (we_end_addr_ptr_reg_cr               )
    ,.we_partition_mode_reg_cr              (we_partition_mode_reg_cr             )
    ,.we_start_addr_ptr_reg_cr              (we_start_addr_ptr_reg_cr             )
    ,.we_queue_locs_read_reg_cr             (we_queue_locs_read_reg_cr            )

    ,.req                                   (req                                  )
    ,.ack                                   (ack                                  )

  );

  //------------------------------------------------------//
  //    REQ SIGNALS        :     ACK SIGNALS              //
  //------------------------------------------------------//
  // req.valid     : ack.read_valid       //
  // req.opcode    : ack.read_miss        //
  // req.addr      : ack.write_valid      //
  // req.be        : ack.write_miss       //
  // req.data      : ack.sai_successfull  //
  // req.sai       : ack.data             //
  // req.fid       :                              //
  // req.bar       :                              //
  //------------------------------------------------------//
  
  //------------------------------------------------------//
  // Register module config request signals logic         //
  //------------------------------------------------------//
  //Request is valid for any read or write transaction occurs when waitrequest is inactive/low 
  assign req.valid  = (avl_mm_write | avl_mm_read) & (~avl_mm_waitrequest);

  //Register CFG opcode selection
  assign req.opcode = avl_mm_write  ? CFGWR : CFGRD;

  //Register CFG address excpets 48bit. Appending zeros to AV-MM slave address
  assign req.addr   = {{(48-AV_MM_ADDR_W){1'b0}},avl_mm_address};

  assign req.be     = avl_mm_byteenable;
  assign req.data   = avl_mm_writedata;
  assign req.sai    = 7'h00;
  assign req.fid    = 7'h00;
  assign req.bar    = 3'h0;
  
  //AV-MM Slave waitrequest
  assign avl_mm_waitrequest = 1'b0;

  //AV-MM Slave read response logic
  always @(posedge csr_clk, negedge rst_csr_n)
  begin
    if(~rst_csr_n)
    begin
      avl_mm_readdatavalid  <=  1'b0;
      avl_mm_readdata       <=  0;
    end
    else
    begin
      avl_mm_readdatavalid  <=  ack.read_valid | ack.read_miss;
      avl_mm_readdata       <=  ack.read_miss ? READ_MISS_VAL : ack.data;
    end
  end


  /*
    * Misc Logic
  */
  always@(posedge csr_clk,  negedge rst_csr_n)
  begin
    if(~rst_csr_n)
    begin
      init_queues                     <=  1'b0;
      queue_mode                      <=  0;

      for(n=0;n<MAX_MEM_PARTITIONS;n++)
      begin : init_part_ptrs
        queue_start_ptr_arry[n]       <= PARTITION_START_PTR_INIT_LIST[n];
        queue_end_ptr_arry[n]         <= PARTITION_END_PTR_INIT_LIST[n];
        queue_locs_read[n]            <= 0;
      end

      ddr_ecc_err_detect_sync         <=  0;
      ddr_pll_locked_sync             <=  0;
      ddr_local_cal_fail_sync         <=  0;
      ddr_local_cal_success_sync      <=  0;
      ddr_local_init_done_sync        <=  0;
    end
    else
    begin
      /*  Queue Init  */
      init_queues                     <=  we_cntrl_reg_cr.init_queues & handcode_wdata_cntrl_reg_cr.init_queues;

      /*  Queue Config  */
      if(we_partition_mode_reg_cr.mode)
      begin
        queue_mode[cntrl_reg_cr.partition_id] <=  handcode_wdata_partition_mode_reg_cr.mode;
      end

      if(|we_start_addr_ptr_reg_cr.start_ptr)
      begin
        queue_start_ptr_arry[cntrl_reg_cr.partition_id] <=  handcode_wdata_start_addr_ptr_reg_cr.start_ptr[DDR_AVL_ADDR_WIDTH-1:0];
      end

      if(|we_end_addr_ptr_reg_cr.end_ptr)
      begin
        queue_end_ptr_arry[cntrl_reg_cr.partition_id]   <=  handcode_wdata_end_addr_ptr_reg_cr.end_ptr[DDR_AVL_ADDR_WIDTH-1:0];
      end

      if(|we_queue_locs_read_reg_cr.locs_read)
      begin
        queue_locs_read[cntrl_reg_cr.partition_id] <= handcode_wdata_queue_locs_read_reg_cr.locs_read[DDR_AVL_ADDR_WIDTH-1:0];
      end

      if(|we_queue_locs_read_reg_cr.locs_read)
      begin
        queue_locs_rddone[cntrl_reg_cr.partition_id] <= 1'b1;
      end else begin
        queue_locs_rddone[cntrl_reg_cr.partition_id] <= 1'b0;
      end

      /*  Synchronize */
      ddr_ecc_err_detect_sync         <=  {ddr_ecc_err_detect_sync[0],ddr_ecc_err_detect};
      ddr_pll_locked_sync             <=  {ddr_pll_locked_sync[0],ddr_pll_locked};
      ddr_local_cal_fail_sync         <=  {ddr_local_cal_fail_sync[0],ddr_local_cal_fail};
      ddr_local_cal_success_sync      <=  {ddr_local_cal_success_sync[0],ddr_local_cal_success};
      ddr_local_init_done_sync        <=  {ddr_local_init_done_sync[0],ddr_local_init_done};
    end
  end


  /*  CSR Signals */
  assign  handcode_rdata_cntrl_reg_cr.init_queues         = 1'b0;
  assign  handcode_rdata_partition_mode_reg_cr.mode       = queue_mode[cntrl_reg_cr.partition_id];
  assign  handcode_rdata_start_addr_ptr_reg_cr.start_ptr  = {{(32-DDR_AVL_ADDR_WIDTH){1'b0}},queue_start_ptr_arry[cntrl_reg_cr.partition_id]};
  assign  handcode_rdata_end_addr_ptr_reg_cr.end_ptr      = {{(32-DDR_AVL_ADDR_WIDTH){1'b0}},queue_end_ptr_arry[cntrl_reg_cr.partition_id]};
  assign  handcode_rdata_queue_locs_read_reg_cr.locs_read = {{(32-DDR_AVL_ADDR_WIDTH){1'b0}},queue_locs_read[cntrl_reg_cr.partition_id]};

  assign  new_ddr_phy_status_reg_cr.ddr_local_init_done   = ddr_local_init_done_sync[1];
  assign  new_ddr_phy_status_reg_cr.ddr_local_cal_succes  = ddr_local_cal_success_sync[1];
  assign  new_ddr_phy_status_reg_cr.ddr_local_cal_fail    = ddr_local_cal_fail_sync[1];
  assign  new_ddr_phy_status_reg_cr.ddr_pll_locked        = ddr_pll_locked_sync[1];
  assign  new_ddr_phy_status_reg_cr.ddr_ecc_err_detect    = ddr_ecc_err_detect_sync[1];

  generate
    for(i=0;  i<4;  i++)
    begin : gen_inst_name
      assign  new_inst_name_0_reg_cr.inst_name[(i*8) +: 8]          = inst_name_str[15-i];
      assign  new_inst_name_1_reg_cr.inst_name[(i*8) +: 8]          = inst_name_str[15-4-i];
      assign  new_inst_name_2_reg_cr.inst_name[(i*8) +: 8]          = inst_name_str[15-8-i];
      assign  new_inst_name_3_reg_cr.inst_name[(i*8) +: 8]          = inst_name_str[15-12-i];

      assign  new_sbr_type_reg_cr.sbr_type[(i*8)  +:  8]            = mon_type_str[3-i];

      assign  new_params1_reg_cr.fpga_device_family[(i*8) +:  8]    = fpga_dev_family[3-i];
    end
  endgenerate

  assign  new_params0_reg_cr.max_mem_partitions     = MAX_MEM_PARTITIONS;
  assign  new_params0_reg_cr.ddr_avl_addr_width     = DDR_AVL_ADDR_WIDTH;
  assign  new_params0_reg_cr.ddr_avl_data_width     = DDR_AVL_DATA_WIDTH;

  assign  new_partition_occupancy_reg_cr.occupancy  = {{(32-DDR_AVL_ADDR_WIDTH){1'b0}},queue_occ_arry[cntrl_reg_cr.partition_id]};

  assign  new_read_addr_ptr_reg_cr.read_ptr         = {{(32-DDR_AVL_ADDR_WIDTH){1'b0}},queue_rptr_arry[cntrl_reg_cr.partition_id]};

  assign  new_write_addr_ptr_reg_cr.write_ptr       = {{(32-DDR_AVL_ADDR_WIDTH){1'b0}},queue_wptr_arry[cntrl_reg_cr.partition_id]};


  /*
    * DDR PHY Reset Logic
  */
  assign  ddr_cntrlr_glbl_rst_n_f_rst_n  = rst_csr_n & ddr_phy_cntrl_reg_cr.ddr_cntrlr_glbl_rst_n;
  assign  ddr_cntrlr_glbl_rst_n          = ddr_cntrlr_glbl_rst_n_f_rst_n;

  assign  ddr_cntrlr_soft_rst_n_f_rst_n  = rst_csr_n & ddr_phy_cntrl_reg_cr.ddr_cntrlr_sw_rst_n;
  assign  ddr_cntrlr_soft_rst_n          = ddr_cntrlr_soft_rst_n_f_rst_n;


endmodule //IW_fpga_dbg_logger_av_addr_map
