uhfi_rtl_top
      #(.GMT_ASYNC(GMT_ASYNC),
        .GMT_D_WIDTH(GMT_D_WIDTH),
        .GMT_GCR_DSIZE(GMT_GCR_DSIZE),
        .GMT_MAX_ADDR(GMT_MAX_ADDR),
        .GMT_MAX_DATA_LEN(GMT_MAX_DATA_LEN),
        .GMT_MDEST_ID_WIDTH(GMT_MDEST_ID_WIDTH),
        .GMT_MSRC_ID_WIDTH(GMT_MSRC_ID_WIDTH),
        .GMT_NUMCHAN(GMT_NUMCHAN),
        .GMT_NUMCHANL2(GMT_NUMCHANL2),
        .GMT_RS_WIDTH(GMT_RS_WIDTH),
        .GMT_SAI_WIDTH(GMT_SAI_WIDTH),
        .GMT_SB_PAYLOAD_SIZE(GMT_SB_PAYLOAD_SIZE),
        .GMT_TDEST_ID_WIDTH(GMT_TDEST_ID_WIDTH),
        .GMT_TSRC_ID_WIDTH(GMT_TSRC_ID_WIDTH),
        .GMT_FIFO_DSIZE(GMT_FIFO_DSIZE),
        .GMT_TRANSPORT_TYPE(GMT_TRANSPORT_TYPE),
        .AGENT_PSFPORT_MAX_NUMCHAN(AGENT_PSFPORT_MAX_NUMCHAN),
        .AGENT_PSFPORT_NUMCHAN(AGENT_PSFPORT_NUMCHAN),
        .AGENT_PSFPORT_NUMCHANL2(AGENT_PSFPORT_NUMCHANL2),
        .BDF_LIST(BDF_LIST),
        .MAXPLDBIT(MAXPLDBIT),
        .CMD_COMPARE(CMD_COMPARE),
        .CMD_MASK(CMD_MASK),
        .EXPANSION_MODE(EXPANSION_MODE),
        .EXTERNAL_CORE_FIP(EXTERNAL_CORE_FIP),
        .FABRIC_PSFPORT_MAX_NUMCHAN(FABRIC_PSFPORT_MAX_NUMCHAN),
        .FABRIC_PSFPORT_NUMCHAN(FABRIC_PSFPORT_NUMCHAN),
        .FABRIC_PSFPORT_NUMCHANL2(FABRIC_PSFPORT_NUMCHANL2),
        .FABRIC_PSFPORT_NUM_EXTERNAL_PIPE_STAGES(FABRIC_PSFPORT_NUM_EXTERNAL_PIPE_STAGES),
        .IOSF_CHID_WIDTH(IOSF_CHID_WIDTH),
        .IOSF_CHAN_ID_WIDTH(IOSF_CHAN_ID_WIDTH),
        .IOSF_FABRIC_ID_WIDTH(IOSF_FABRIC_ID_WIDTH),
        .IOSF_PORT_ID_WIDTH(IOSF_PORT_ID_WIDTH),
        .IOSF_DST_ID_WIDTH(),
        .IOSF_SRC_ID_WIDTH(IOSF_SRC_ID_WIDTH),
        .IOSF_DATA_PARITY_WIDTH(IOSF_DATA_PARITY_WIDTH),
        .IOSF_DATA_WIDTH(IOSF_DATA_WIDTH),
        .IOSF_FIP_IS_ENCAPSULATED(IOSF_FIP_IS_ENCAPSULATED),
        .IOSF_FIP_IS_FABRIC(IOSF_FIP_IS_FABRIC),
        .IOSF_MAX_DATA_LEN(IOSF_MAX_DATA_LEN),
        .IOSF_PRI_TC_EN(IOSF_PRI_TC_EN),
        .IOSF_PRI_CHNL_EN(IOSF_PRI_CHNL_EN),
        .IOSF_SAI_WIDTH(IOSF_SAI_WIDTH),
        .IOSF_RS_WIDTH(IOSF_RS_WIDTH),
        .IOSF_SB_IS_FABRIC(IOSF_SB_IS_FABRIC),
        .indirect_device_number(indirect_device_number),
        .indirect_function_number(indirect_function_number),
        .LOCAL_IS_FABRIC(LOCAL_IS_FABRIC),
        .FPGA_NUMBER(FPGA_NUMBER),
        .BYPASS_SB_EP(BYPASS_SB_EP),
`ifdef UHFI_S10_BUILD
        .UHFI_CAR_HAS_MMCM(0),
`else
        .UHFI_CAR_HAS_MMCM(UHFI_CAR_HAS_MMCM),
`endif
        .FABRIC_PSFPORT_REQ_CREDIT_P(FABRIC_PSFPORT_REQ_CREDIT_P),
        .FABRIC_PSFPORT_REQ_CREDIT_NP(FABRIC_PSFPORT_REQ_CREDIT_NP),
        .FABRIC_PSFPORT_REQ_CREDIT_C(FABRIC_PSFPORT_REQ_CREDIT_C),
        .HAS_EXP_ROM(HAS_EXP_ROM),
        .LB_NUM_OF_INTERNAL_AGENTS(LB_NUM_OF_INTERNAL_AGENTS),
        .LB_NUM_OF_ADD_AGENTS(LB_NUM_OF_ADD_AGENTS),
        .RF_NUM_OF_INTERNAL_REGISTERS(RF_NUM_OF_INTERNAL_REGISTERS),
        .RF_NUM_OF_ADD_REGISTERS(RF_NUM_OF_ADD_REGISTERS),
        .LB_NUM_OF_AGENTS(LB_NUM_OF_AGENTS),
//        .LB_EXT_AGENTS(2),
//        .LB_EXT_AGENTS_DATA_WIDTH(191),
        .RF_NUM_OF_REGISTERS(RF_NUM_OF_REGISTERS),
        .REG_FILE_PARAM(REG_FILE_PARAM),
        .REG_FILE_INTERNAL_PARAM(REG_FILE_INTERNAL_PARAM),
        .BDF1_REGISTER_DEFAULT_VALUE(BDF1_REGISTER_DEFAULT_VALUE),
        .BDF2_REGISTER_DEFAULT_VALUE(BDF2_REGISTER_DEFAULT_VALUE),
        .BDF3_REGISTER_DEFAULT_VALUE(BDF3_REGISTER_DEFAULT_VALUE),
        .BDF4_REGISTER_DEFAULT_VALUE(BDF4_REGISTER_DEFAULT_VALUE),
        .RF_BASE_ADDR(RF_BASE_ADDR),
        .RF_SIZE(RF_SIZE),
        .SB_MB_IN_BASE_ADDR(SB_MB_IN_BASE_ADDR),
        .SB_MB_IN_SIZE(SB_MB_IN_SIZE),
        .SB_MB_OUT_BASE_ADDR(SB_MB_OUT_BASE_ADDR),
        .SB_MB_OUT_SIZE(SB_MB_OUT_SIZE),
        .GTX_LOCAL_BASE_ADDR(GTX_LOCAL_BASE_ADDR),
        .GTX_LOCAL_SIZE(GTX_LOCAL_SIZE),
        .PHANTOM_BASE_ADDR(PHANTOM_BASE_ADDR),
        .PHANTOM_SIZE(PHANTOM_SIZE),
        .FPGA_VERSION_REGISTER_VALUE(FPGA_VERSION_REGISTER_VALUE),
        .FPGA_PROJECT_NAME_REGISTER_VALUE(FPGA_PROJECT_NAME_REGISTER_VALUE),
        .STATUS_REGISTER_DEFAULT_VALUE(STATUS_REGISTER_DEFAULT_VALUE),
        .REPLACE_BUS_DEVICE_FUNCTION_VALUE(REPLACE_BUS_DEVICE_FUNCTION_VALUE),
        .CONFIG_REGISTER_DEFAULT_VALUE(CONFIG_REGISTER_DEFAULT_VALUE),
        .EXTRA_BITS_FOR_BPI_FLASH(EXTRA_BITS_FOR_BPI_FLASH),
        .CMD_COMPARE_DEFAULT_VALUE_1(CMD_COMPARE_DEFAULT_VALUE_1),
        .CMD_COMPARE_DEFAULT_VALUE_2(CMD_COMPARE_DEFAULT_VALUE_2),
        .CMD_COMPARE_DEFAULT_VALUE_3(CMD_COMPARE_DEFAULT_VALUE_3),
        .CMD_MASK_DEFAULT_VALUE_1(CMD_MASK_DEFAULT_VALUE_1),
        .CMD_MASK_DEFAULT_VALUE_2(CMD_MASK_DEFAULT_VALUE_2),
        .CMD_MASK_DEFAULT_VALUE_3(CMD_MASK_DEFAULT_VALUE_3),
        .CMPL_COMPARE_DEFAULT_VALUE(CMPL_COMPARE_DEFAULT_VALUE),
        .DDMA_ADDRESS_RANGE_BASE_DEFAULT_VALUE_1(DDMA_ADDRESS_RANGE_BASE_DEFAULT_VALUE_1),
        .DDMA_ADDRESS_RANGE_LIMIT_DEFAULT_VALUE_1(DDMA_ADDRESS_RANGE_LIMIT_DEFAULT_VALUE_1),
        .DDMA_ADDRESS_RANGE_BASE_DEFAULT_VALUE_0(DDMA_ADDRESS_RANGE_BASE_DEFAULT_VALUE_0),
        .DDMA_ADDRESS_RANGE_LIMIT_DEFAULT_VALUE_0(DDMA_ADDRESS_RANGE_LIMIT_DEFAULT_VALUE_0),
        .DDMA_ADDRESS_RANGE_STATIC_OFFSET_DEFAULT_VALUE(DDMA_ADDRESS_RANGE_STATIC_OFFSET_DEFAULT_VALUE),
        .DDMA_CONTROL_DEFAULT_VALUE(DDMA_CONTROL_DEFAULT_VALUE),
        .DDMA_SRC_IDs_DEFAULT_VALUE(DDMA_SRC_IDs_DEFAULT_VALUE),
        .DDMA_FMT_TYPE_MASK_DEFAULT_VALUE(DDMA_FMT_TYPE_MASK_DEFAULT_VALUE),
        .DDMA_SAI_RS_TC_CHNL_MASK_DEFAULT_VALUE(DDMA_SAI_RS_TC_CHNL_MASK_DEFAULT_VALUE),
        .DDMA_DEST_IDS_MASK_DEFAULT_VALUE(DDMA_DEST_IDS_MASK_DEFAULT_VALUE),
        .DDMA_SRC_IDS_MASK_DEFAULT_VALUE(DDMA_SRC_IDS_MASK_DEFAULT_VALUE),
        .DDMA_FMT_TYPE_DEFAULT_VALUE(DDMA_FMT_TYPE_DEFAULT_VALUE),
        .DDMA_SAI_RS_TC_CHNL_DEFAULT_VALUE(DDMA_SAI_RS_TC_CHNL_DEFAULT_VALUE),
        .DDMA_DEST_IDS_DEFAULT_VALUE(DDMA_DEST_IDS_DEFAULT_VALUE),
        .REGISTERS_DEFAULT_VALUE(REGISTERS_DEFAULT_VALUE),
        .LB_AGENTS_BASE_ADDR(LB_AGENTS_BASE_ADDR),
        .LB_AGENTS_SIZE(LB_AGENTS_SIZE),
        .ORDERED_COMPL_EN(ORDERED_COMPL_EN),
        .PASSTHRU_BUS_NUM(PASSTHRU_BUS_NUM),
        .IM_DS_DMA_BUFFER_TAG_80_TO_FF(IM_DS_DMA_BUFFER_TAG_80_TO_FF),
        .SB_MB_OUT_INTR_SUPPORT(SB_MB_OUT_INTR_SUPPORT),
        .DIRECT_MODE_HOST_SAI_VALUE(DIRECT_MODE_HOST_SAI_VALUE),
        .DIRECT_MODE_HOST_SRC_ID_VALUE(DIRECT_MODE_HOST_SRC_ID_VALUE)
       )
       uhfi
       (
       .PCIE_CONN_RX0_N                           (pci_exp_rxn[0]), // input
       .PCIE_CONN_RX0_P                           (pci_exp_rxp[0]), // input
       .PCIE_CONN_RX1_N                           (pci_exp_rxn[1]), // input
       .PCIE_CONN_RX1_P                           (pci_exp_rxp[1]), // input
       .PCIE_CONN_RX2_N                           (pci_exp_rxn[2]), // input
       .PCIE_CONN_RX2_P                           (pci_exp_rxp[2]), // input
       .PCIE_CONN_RX3_N                           (pci_exp_rxn[3]), // input
       .PCIE_CONN_RX3_P                           (pci_exp_rxp[3]), // input
       .PCIE_REFCLK_N                             (pcie_ref_clk_n), // input
       .PCIE_REFCLK_P                             (pcie_ref_clk_p), // input
       .PCIE_TX0_N                                (pci_exp_txn[0]), // output
       .PCIE_TX0_P                                (pci_exp_txp[0]), // output
       .PCIE_TX1_N                                (pci_exp_txn[1]), // output
       .PCIE_TX1_P                                (pci_exp_txp[1]), // output
       .PCIE_TX2_N                                (pci_exp_txn[2]), // output
       .PCIE_TX2_P                                (pci_exp_txp[2]), // output
       .PCIE_TX3_N                                (pci_exp_txn[3]), // output
       .PCIE_TX3_P                                (pci_exp_txp[3]), // output
    // Ports for Manually exported pins
       .app_inta_func_num                         (3'b0), //input [2:0]
       .app_inta_sts                              (1'b0), //input
       .app_intb_func_num                         (3'b0), //input [2:0]
       .app_intb_sts                              (1'b0), //input
       .app_intc_func_num                         (3'b0), //input [2:0]
       .app_intc_sts                              (1'b0), //input
       .app_intd_func_num                         (3'b0), //input [2:0]
       .app_intd_sts                              (1'b0), //input
       .clk_100mhz                                (uhfi_100mhz_clk), //input TBD
       .clk_desc                                  (side_clk), //input TBD
       .clk_iosf_prim                             (prim_clk), //input TBD
       .clk_local                                 (side_clk), //input TBD
       .clk_sb                                    (side_clk), //input TBD
       .desc_ch2_rx_be                            (8'b0), //input
       .desc_ch2_rx_data                          (64'b0), //input
       .desc_ch2_rx_desc                          (192'b0), //input
       .desc_ch2_rx_dfr                           (1'b0), //input
       .desc_ch2_rx_dv                            (1'b0), //input
       .desc_ch2_rx_req                           (1'b0), //input
       .desc_ch2_tx_ack                           (1'b0), //input
       .desc_ch2_tx_ws                            (1'b0), //input
       .ext_agents_lba_data                       (128'b0), //input
       .ext_agents_lba_data_valid                 (2'b0), //input
       .ext_agents_lba_ws                         (2'b0), //input
       ///////////////////////////////////////////////
       // IOSF Sideband 
       ///////////////////////////////////////////////
       //Inputs
       .fpgasbr_mux_eom                           (sbr_uhfi_eom),//sbr0_p5_teom), // input
       .fpgasbr_mux_npcup                         (sbr_uhfi_npcup),//sbr0_p5_mnpcup), // input
       .fpgasbr_mux_npput                         (sbr_uhfi_npput),//sbr0_p5_tnpput), // input
       .fpgasbr_mux_payload                       (sbr_uhfi_payload),//sbr0_p5_tpayload), // input
       .fpgasbr_mux_pccup                         (sbr_uhf_pccup),//sbr0_p5_mpccup), // input
       .fpgasbr_mux_pcput                         (sbr_uhfi_pcput),//sbr0_p5_tpcput), // input
       .fpgasbr_mux_side_clkack                   (uhfi_side_clkreq),//uhfi_side_clkack), // input
       .fpgasbr_mux_side_ism_fabric               (sbr_uhfi_side_ism_fabric),//sbr0_p5_side_ism_fabric), // input
       .gtxlocal_lba_data                         (64'b0), //input
       .gtxlocal_lba_data_valid                   (1'b0), //input
       .gtxlocal_lba_ws                           (1'b0), //input
       .imc_int_in                                (4'b0), // input
       .rst_desc_ext                              (1'b0), // input
       .rst_iosf_prim_ext                         (1'b0), // input
       .rst_local_ext                             (1'b0), // input
       .rst_sb_ext                                (1'b0), // input
       .rst_uhfi_ext                              (1'b0), // input
       .status_register_int                       (64'b0), // input
       .uhfi_agent_cmd_chid                       (4'b0), // input
       .uhfi_agent_cmd_put                        (1'b0), // input
       .uhfi_agent_cmd_rtype                      (2'b0), // input
       .uhfi_agent_gnt                            (1'b0), // input
       .uhfi_agent_gnt_chid                       (4'b0), // input
       .uhfi_agent_gnt_rtype                      (2'b0), // input
       .uhfi_agent_gnt_type                       (2'b0), // input
       .uhfi_agent_power_prim_clkack              (1'b0), // input
       .uhfi_agent_prim_ism_fabric                (3'b0), // input
       .uhfi_agent_taddress                       (64'b0), // input
       .uhfi_agent_tat                            (2'b0), // input
       .uhfi_agent_tcparity                       (1'b0), // input
       .uhfi_agent_tdata                          (64'b0), // input
       .uhfi_agent_tdeadline                      (1'b0), // input
       .uhfi_agent_tdest_id                       (15'b0), // input
       .uhfi_agent_tdparity                       (1'b0), // input
       .uhfi_agent_tecrc                          (32'b0), // input
       .uhfi_agent_tecrc_error                    (1'b0), // input
       .uhfi_agent_tecrc_generate                 (1'b0), // input
       .uhfi_agent_tep                            (1'b0), // input
       .uhfi_agent_tfbe                           (4'b0), // input
       .uhfi_agent_tfmt                           (2'b0), // input
       .uhfi_agent_tido                           (1'b0), // input
       .uhfi_agent_tlbe                           (4'b0), // input
       .uhfi_agent_tlength                        (10'b0), // input
       .uhfi_agent_tns                            (1'b0), // input
       .uhfi_agent_tpasidtlp                      (23'b0), // input
       .uhfi_agent_tro                            (1'b0), // input
       .uhfi_agent_trqid                          (16'b0), // input
       .uhfi_agent_trs                            (2'b0), // input
       .uhfi_agent_trsvd0_7                       (1'b0), // input
       .uhfi_agent_trsvd1_1                       (1'b0), // input
       .uhfi_agent_trsvd1_3                       (1'b0), // input
       .uhfi_agent_trsvd1_7                       (1'b0), // input
       .uhfi_agent_tsai                           (8'b0), // input
       .uhfi_agent_tsrc_id                        (15'b0), // input
       .uhfi_agent_ttag                           (8'b0), // input
       .uhfi_agent_ttc                            (4'b0), // input
       .uhfi_agent_ttd                            (1'b0), // input
       .uhfi_agent_tth                            (1'b0), // input
       .uhfi_agent_ttype                          (5'b0), // input
  // input
       /////////////////////////////////////////////// // input
       // IOSF Primary Fabric Port Input CPM -> UHFI // input
       /////////////////////////////////////////////// // input
      
       .uhfi_fabric_credit_chid                     ('h0            ), // input [IOSF_CHID_WIDTH:0]
       .uhfi_fabric_credit_cmd                    (xali2ttif_prim_mcredit_cmd            ), // input
       .uhfi_fabric_credit_data                   (xali2ttif_prim_mcredit_data            ), // input [2:0]
       .uhfi_fabric_credit_put                    (xali2ttif_prim_mcredit_put             ), // input
       .uhfi_fabric_credit_rtype                  (xali2ttif_prim_mcredit_rtype           ), // input [1:0]
       .uhfi_fabric_maddress                      (xali2ttif_prim_taddress               ), // input [63:0]
       .uhfi_fabric_mat                           (xali2ttif_prim_tat                   ), // input [1:0]
       .uhfi_fabric_mcparity                      (xali2ttif_prim_tcparity               ), // input
       .uhfi_fabric_mdata                         (xali2ttif_prim_tdata                  ), // input [(IOSF_DATA_WIDTH-1):0]
       .uhfi_fabric_mdeadline                     (1'b0                           ), // input
       .uhfi_fabric_mdest_id                      (xali2ttif_prim_tdest_id               ), // input [IOSF_SRC_ID_WIDTH:0]
       .uhfi_fabric_mdparity                      (xali2ttif_prim_tdparity               ), // input
       .uhfi_fabric_mecrc                         (32'b0                          ), // input [31:0]
       .uhfi_fabric_mecrc_error                   (1'b0                           ), // input
       .uhfi_fabric_mecrc_generate                ('h0                                  ), // input
       .uhfi_fabric_mep                           (xali2ttif_prim_tep                    ), // input
       .uhfi_fabric_mfbe                          (xali2ttif_prim_tfbe                   ), // input [3:0]
       .uhfi_fabric_mfmt                          (xali2ttif_prim_tfmt                   ), // input [1:0]
       .uhfi_fabric_mido                          (1'b0                           ), // input
       .uhfi_fabric_mlbe                          (xali2ttif_prim_tlbe                   ), // input [3:0]
       .uhfi_fabric_mlength                       (xali2ttif_prim_tlength                ), // input [9:0]
       .uhfi_fabric_mns                           (xali2ttif_prim_tns                    ), // input
       .uhfi_fabric_mpasidtlp                     (xali2ttif_prim_tpasidtlp              ), // input [22:0]
       .uhfi_fabric_mro                           (xali2ttif_prim_trot                    ), // input
       .uhfi_fabric_mrqid                         (xali2ttif_prim_trqid                  ), // input [15:0]
       .uhfi_fabric_mrs                           (xali2ttif_prim_trs                    ), // input [IOSF_RS_WIDTH:0]
       .uhfi_fabric_mrsvd0_7                      ('h0                            ), // input
       .uhfi_fabric_mrsvd1_1                      ('h0                            ), // input
       .uhfi_fabric_mrsvd1_3                      (xali2ttif_prim_trsvd1_7                           ), // input
       .uhfi_fabric_mrsvd1_7                      (xali2ttif_prim_trsvd1_3                           ), // input
       .uhfi_fabric_msai                          (xali2ttif_prim_tsai                   ), // input [(IOSF_SAI_WIDTH-1):0]
       .uhfi_fabric_msrc_id                       (15'b0                          ), // input [IOSF_SRC_ID_WIDTH:0]
       .uhfi_fabric_mtag                          (xali2ttif_prim_ttag                   ), // input [7:0]
       .uhfi_fabric_mtc                           (xali2ttif_prim_ttc                    ), // input [3:0]
       .uhfi_fabric_mtd                           (1'b0                           ), // input
       .uhfi_fabric_mth                           (xali2ttif_prim_tth                           ), // input
       .uhfi_fabric_mtype                         (xali2ttif_prim_ttype                  ), // input [4:0]
       .uhfi_fabric_power_prim_clkreq             (1'b0                           ), // input
       .uhfi_fabric_prim_ism_agent                (xali2ttif_prim_ism_fabric         ), // input [2:0]
       .uhfi_fabric_req_cdata                     ('h0               ), // input
       .uhfi_fabric_req_chid                      ('h0),//sg_req_chid               ), // input [IOSF_CHID_WIDTH:0]
       .uhfi_fabric_req_dest_id                   ('h0             ), // input [IOSF_SRC_ID_WIDTH:0]
       .uhfi_fabric_req_dlen                      (               ), // input [IOSF_MAX_DATA_LEN:0]
       .uhfi_fabric_req_locked                    (1'b0),//sg_req_locked             ), // input
       .uhfi_fabric_req_ns                        ('h0                  ), // input
       .uhfi_fabric_req_put                       ('h0                 ), // input
       .uhfi_fabric_req_ro                        ('h0                  ), // input
       .uhfi_fabric_req_rs                        (1'b0),//sg_req_rs                 ), // input [IOSF_RS_WIDTH:0]
       .uhfi_fabric_req_rtype                     ('h0               ), // input [1:0]
       .uhfi_fabric_req_tc                        ('h0                 ), // input [3:0]


       .CO18_PCIE_RESET_N                         (~perst),
       .app_inta_ack                              (), // output
       .app_intb_ack                              (), // output
       .app_intc_ack                              (), // output
       .app_intd_ack                              (), // output
       .clk_pipe_125mhz_out                       (uhfi_clk_pipe_125mhz_out), // output
       .clk_uhfi_100mhz_out                       (), // output
       .clk_uhfi_120mhz_out                       (), // output
       .clk_uhfi_20mhz_out                        (uhfi_clk_uhfi_20mhz_out), // output
       .clk_uhfi_40mhz_out                        (uhfi_clk_uhfi_40mhz_out), // output
       .desc_ch2_rx_abort                         (), // output
       .desc_ch2_rx_ack                           (), // output
       .desc_ch2_rx_ws                            (), // output
       .desc_ch2_tx_data                          (), // output
       .desc_ch2_tx_desc                          (), // output
       .desc_ch2_tx_dfr                           (), // output
       .desc_ch2_tx_req                           (), // output
       .extra_bit_for_gtx_local_bus               (), // output
       .force_sb_reset                            (), // output

       .lba_ext_agents_cs                         (), // output
       .lba_gtxlocal_cs                           (), // output
       .lba_xxx_address                           (uhfi_lba_xxx_address), // output
       .lba_xxx_data                              (uhfi_lba_xxx_data), // output
       .lba_xxx_data_be                           (uhfi_lba_xxx_data_be), // output
       .lba_xxx_read                              (uhfi_lba_xxx_read), // output
       .lba_xxx_write                             (uhfi_lba_xxx_write), // output
       .mux_fpgasbr_eom                           (uhfi_sbr_eom),//sbr0_p5_meom), // output
       .mux_fpgasbr_npcup                         (uhfi_sbr_npcup),//sbr0_p5_tnpcup), // output
       .mux_fpgasbr_npput                         (uhfi_sbr_npput),//sbr0_p5_mnpput), // output
       .mux_fpgasbr_payload                       (uhfi_sbr_payload),//sbr0_p5_mpayload), // output
       .mux_fpgasbr_pccup                         (uhfi_sbr_pccup),//sbr0_p5_tpccup), // output
       .mux_fpgasbr_pcput                         (uhfi_sbr_pcput),//sbr0_p5_mpcput), // output
       .mux_fpgasbr_side_clkreq                   (uhfi_side_clkreq), // output
       .mux_fpgasbr_side_ism_agent                (uhfi_sbr_side_ism_agent),//sbr0_p5_side_ism_agent), // output
  // output
       .rf_registers_bus_out                      (), // output
       .rst_global_n_out                          (uhfi_rst_global_n_out), // output
       .rst_pcie_ctrl_n_out                       (uhfi_rst_pcie_ctrl_n_out), // output
       .rst_sa_ip_n_out                           (uhfi_rst_sa_ip_n_out), // output
       .rst_sb_n_out                              (), // output
  // output
       /////////////////////////////////////////////// // output
       // IOSF Primary Agent Port Input  // output
       /////////////////////////////////////////////// // output
       .uhfi_agent_credit_chid                    (), // output
       .uhfi_agent_credit_cmd                     (), // output
       .uhfi_agent_credit_data                    (), // output
       .uhfi_agent_credit_put                     (), // output
       .uhfi_agent_credit_rtype                   (), // output
       .uhfi_agent_maddress                       (), // output
       .uhfi_agent_mat                            (), // output
       .uhfi_agent_mcparity                       (), // output
       .uhfi_agent_mdata                          (), // output
       .uhfi_agent_mdeadline                      (), // output
       .uhfi_agent_mdest_id                       (), // output
       .uhfi_agent_mdparity                       (), // output
       .uhfi_agent_mecrc                          (), // output
       .uhfi_agent_mecrc_error                    (), // output
       .uhfi_agent_mecrc_generate                 (), // output
       .uhfi_agent_mep                            (), // output
       .uhfi_agent_mfbe                           (), // output
       .uhfi_agent_mfmt                           (), // output
       .uhfi_agent_mido                           (), // output
       .uhfi_agent_mlbe                           (), // output
       .uhfi_agent_mlength                        (), // output
       .uhfi_agent_mns                            (), // output
       .uhfi_agent_mpasidtlp                      (), // output
       .uhfi_agent_mro                            (), // output
       .uhfi_agent_mrqid                          (), // output
       .uhfi_agent_mrs                            (), // output
       .uhfi_agent_mrsvd0_7                       (), // output
       .uhfi_agent_mrsvd1_1                       (), // output
       .uhfi_agent_mrsvd1_3                       (), // output
       .uhfi_agent_mrsvd1_7                       (), // output
       .uhfi_agent_msai                           (), // output
       .uhfi_agent_msrc_id                        (), // output
       .uhfi_agent_mtag                           (), // output
       .uhfi_agent_mtc                            (), // output
       .uhfi_agent_mtd                            (), // output
       .uhfi_agent_mth                            (), // output
       .uhfi_agent_mtype                          (), // output
       .uhfi_agent_power_prim_clkreq              (), // output
       .uhfi_agent_prim_ism_agent                 (), // output
       .uhfi_agent_req_cdata                      (), // output
       .uhfi_agent_req_chid                       (), // output
       .uhfi_agent_req_dest_id                    (), // output
       .uhfi_agent_req_dlen                       (), // output
       .uhfi_agent_req_locked                     (), // output
       .uhfi_agent_req_ns                         (), // output
       .uhfi_agent_req_put                        (), // output
       .uhfi_agent_req_ro                         (), // output
       .uhfi_agent_req_rs                         (), // output
       .uhfi_agent_req_rtype                      (), // output
       .uhfi_agent_req_tc                         (), // output
       /////////////////////////////////////////////// 
       // IOSF Primary Fabric Port Output UHFI -> CPM //
       /////////////////////////////////////////////// 
       .uhfi_fabric_cmd_chid                      (             ), // output [IOSF_CHID_WIDTH:0]
		   .uhfi_fabric_ttif_credit_chid        ( ),       
       .uhfi_fabric_ttif_credit_cmd         (ttif2trgt_prim_credit_cmd  ),
       .uhfi_fabric_ttif_credit_data        (ttif2trgt_prim_credit_data ),
       .uhfi_fabric_ttif_credit_put         (ttif2trgt_prim_credit_put ),
       .uhfi_fabric_ttif_credit_rtype       (ttif2trgt_prim_credit_rtype),
       .uhfi_fabric_cmd_put                       (ttif2trgt_prim_mcmd_put              ), // output
       .uhfi_fabric_cmd_rtype                     (ttif2trgt_prim_mcmd_rtype            ), // output [1:0]
       .uhfi_fabric_gnt                           (                   ), // output
       .uhfi_fabric_gnt_chid                      (              ), // output [IOSF_CHID_WIDTH:0]
       .uhfi_fabric_gnt_rtype                     (         ), // output [1:0]
       .uhfi_fabric_gnt_type                      (             ), // output [1:0]
       .uhfi_fabric_power_prim_clkack             (                              ), // output
       .uhfi_fabric_prim_ism_fabric               (ttif2trgt_prim_ism_agent      ), // output [2:0]
       .uhfi_fabric_taddress                      (ttif2trgt_prim_maddress             ), // output [63:0]
       .uhfi_fabric_tat                           (ttif2trgt_prim_mat                  ), // output [1:0]
       .uhfi_fabric_tcparity                      (ttif2trgt_prim_mcparity             ), // output
       .uhfi_fabric_tdata                         (ttif2trgt_prim_mdata                ), // output [(IOSF_DATA_WIDTH-1):0]
       .uhfi_fabric_tdeadline                     (                              ), // output
       .uhfi_fabric_tdest_id                      (ttif2trgt_prim_mdest_id             ), // output [IOSF_SRC_ID_WIDTH:0]
       .uhfi_fabric_tdparity                      (ttif2trgt_prim_mdparity             ), // output
       .uhfi_fabric_tecrc                         (                              ), // output [31:0]
       .uhfi_fabric_tecrc_error                   (           ), // output
       .uhfi_fabric_tecrc_generate                (                          ), // output
       .uhfi_fabric_tep                           (ttif2trgt_prim_mep                  ), // output
       .uhfi_fabric_tfbe                          (ttif2trgt_prim_mfbe                 ), // output [3:0]
       .uhfi_fabric_tfmt                          (ttif2trgt_prim_mfmt                 ), // output [1:0]
       .uhfi_fabric_tido                          (ttif2trgt_prim_mido                 ), // output
       .uhfi_fabric_tlbe                          (ttif2trgt_prim_mlbe                 ), // output [3:0]
       .uhfi_fabric_tlength                       (ttif2trgt_prim_mlength              ), // output [9:0]
       .uhfi_fabric_tns                           (ttif2trgt_prim_mns                  ), // output
       .uhfi_fabric_tpasidtlp                     (ttif2trgt_prim_mpasidtlp            ), // output [22:0]
       .uhfi_fabric_tro                           (ttif2trgt_prim_mro                  ), // output
       .uhfi_fabric_trqid                         (ttif2trgt_prim_mrqid                ), // output [15:0]
       .uhfi_fabric_trs                           (ttif2trgt_prim_mrs                  ), // output [IOSF_RS_WIDTH:0]
       .uhfi_fabric_trsvd0_7                      (              ), // output
       .uhfi_fabric_trsvd1_1                      (              ), // output
       .uhfi_fabric_trsvd1_3                      (ttif2trgt_prim_mrsvd1_3             ), // output
       .uhfi_fabric_trsvd1_7                      (ttif2trgt_prim_mrsvd1_7             ), // output
       .uhfi_fabric_tsai                          (ttif2trgt_prim_msai                 ), // output [(IOSF_SAI_WIDTH-1):0]
       .uhfi_fabric_tsrc_id                       (ttif2trgt_prim_msrc_id              ), // output [IOSF_SRC_ID_WIDTH:0]
       .uhfi_fabric_ttag                          (ttif2trgt_prim_mtag                 ), // output [7:0]
       .uhfi_fabric_ttc                           (ttif2trgt_prim_mtc                  ), // output [3:0]
       .uhfi_fabric_ttd                           (                  ), // output
       .uhfi_fabric_tth                           (ttif2trgt_prim_mth                  ), // output
       .uhfi_fabric_ttype                         (ttif2trgt_prim_mtype                ) // output [4:0] 
   );
