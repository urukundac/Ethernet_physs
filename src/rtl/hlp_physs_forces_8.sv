initial 
begin
//force rd_clk_mquad0 = core_clk ;
//force rd_clk_mquad1 = core_clk ;
//force rd_clk_pquad = core_clk ;
//force rd_clk_pquad1 =  core_clk ;
//force xlgmii0_cdc_mquad0.wr_clk = rx_clk_out[0] ;
//force xlgmii1_cdc_mquad0.wr_clk = rx_clk_out[1] ;
//force xlgmii2_cdc_mquad0.wr_clk = rx_clk_out[2] ;
//force xlgmii3_cdc_mquad0.wr_clk = rx_clk_out[3] ;
//force xlgmii0_cdc_mquad1.wr_clk = rx_clk_out[4] ;
//force xlgmii1_cdc_mquad1.wr_clk = rx_clk_out[5] ;
//force xlgmii2_cdc_mquad1.wr_clk = rx_clk_out[6] ;
//force xlgmii3_cdc_mquad1.wr_clk = rx_clk_out[7] ;
//force xlgmii0_cdc_pquad0.wr_clk = rx_clk_out[8] ;
//force xlgmii1_cdc_pquad0.wr_clk = rx_clk_out[9] ;
//force xlgmii2_cdc_pquad0.wr_clk = rx_clk_out[10];
//force xlgmii3_cdc_pquad0.wr_clk = rx_clk_out[11];
//force xlgmii0_cdc_pquad1.wr_clk = rx_clk_out[12];
//force xlgmii1_cdc_pquad1.wr_clk = rx_clk_out[13];
//force xlgmii2_cdc_pquad1.wr_clk = rx_clk_out[14                                                             ];
//force xlgmii3_cdc_pquad1.wr_clk = rx_clk_out[15];
force physs0.parmquad0.physs_registers_wrapper_0.physs_common_registers_0.pcs100_sgmii0_reg_sg0_sgpcs_ena = 1;
force physs0.parmquad1.physs_registers_wrapper_1.physs_common_registers_0.pcs100_sgmii0_reg_sg0_sgpcs_ena = 1;
//force physs1.parpquad0.physs_registers_wrapper_2.physs_common_registers_0.pcs100_sgmii0_reg_sg0_sgpcs_ena = 1;
////force physs1.parpquad1.physs_registers_wrapper_2.physs_common_registers_0.pcs100_sgmii0_reg_sg0_sgpcs_ena = 1;
force physs0.parmquad0.pcs100_wrap_0.quadpcs100_0.sg0_sgpcs_ena_s = 1'b1;
force physs0.parmquad1.pcs100_wrap_1.quadpcs100_1.sg0_sgpcs_ena_s = 1'b1;
//force physs1.parpquad0.pcs100_wrap_2.quadpcs100_0.sg0_sgpcs_ena_s = 1'b1;
//force physs1.parpquad1.pcs100_wrap_2.quadpcs100_0.sg0_sgpcs_ena_s = 1'b1;
force physs0.parmquad0.pcs100_wrap_0.quadpcs100_0.sg0_speed_s[1:0] = 2'b10;
force physs0.parmquad1.pcs100_wrap_1.quadpcs100_1.sg0_speed_s[1:0] = 2'b10;
//force physs1.parpquad0.pcs100_wrap_2.quadpcs100_0.sg0_speed_s[1:0] = 2'b10;
//force physs1.parpquad1.pcs100_wrap_2.quadpcs100_0.sg0_speed_s[1:0] = 2'b10;

//force physs0.parmquad0.pcs100_wrap_0.quadpcs100_0.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_0.reset_tx_clk= sync_i_reset[0];
//force physs0.parmquad0.pcs100_wrap_0.quadpcs100_0.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_0.reset_rx_clk= sync_i_reset[0];
//force physs0.parmquad0.pcs100_wrap_0.quadpcs100_0.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_0.reset_ref_clk= sync_i_reset[0];
//force physs0.parmquad0.pcs100_wrap_0.quadpcs100_0.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_0.reset_reg_clk= sync_i_reset[0];
force physs0.parmquad0.pcs100_wrap_0.quadpcs100_0.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_0.tbi_rx = tbi_rx_phy[0][9:0];
force tbi_tx_phy[0][9:0] = physs0.parmquad0.pcs100_wrap_0.quadpcs100_0.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_0.tbi_tx ;
force physs0.parmquad0.pcs100_wrap_0.quadpcs100_0.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_0.gmii_rxd_conv  = (~pcs_loopback_en[0]) ? (serdes_loopback_en[0] ? physs0.parmquad0.pcs100_wrap_0.quadpcs100_0.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_0.gmii_txd_conv : physs0.parmquad0.pcs100_wrap_0.quadpcs100_0.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_0.gmii0_rxd_mux) : 0;
force physs0.parmquad0.pcs100_wrap_0.quadpcs100_0.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_0.gmii_rxdv_conv = (~pcs_loopback_en[0]) ? (serdes_loopback_en[0] ? physs0.parmquad0.pcs100_wrap_0.quadpcs100_0.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_0.gmii_txen_conv : physs0.parmquad0.pcs100_wrap_0.quadpcs100_0.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_0.gmii0_rxdv_mux) : 0;
force physs0.parmquad0.pcs100_wrap_0.quadpcs100_0.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_0.gmii_rxer_conv = (~pcs_loopback_en[0]) ? (serdes_loopback_en[0] ? physs0.parmquad0.pcs100_wrap_0.quadpcs100_0.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_0.gmii_txer_conv : physs0.parmquad0.pcs100_wrap_0.quadpcs100_0.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_0.gmii0_rxer_mux) : 0;
force  physs0.parmquad0.pcs100_wrap_0.quadpcs100_0.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_0.gmii0_txd_mux   = (pcs_loopback_en[0]) ?  physs0.parmquad0.pcs100_wrap_0.quadpcs100_0.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_0.gmii0_rxd_mux :  physs0.parmquad0.pcs100_wrap_0.quadpcs100_0.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_0.gmii_txd_conv;                                   
force  physs0.parmquad0.pcs100_wrap_0.quadpcs100_0.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_0.gmii0_txen_mux  = (pcs_loopback_en[0]) ?  physs0.parmquad0.pcs100_wrap_0.quadpcs100_0.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_0.gmii0_rxdv_mux : physs0.parmquad0.pcs100_wrap_0.quadpcs100_0.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_0.gmii_txen_conv;                                  
force  physs0.parmquad0.pcs100_wrap_0.quadpcs100_0.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_0.gmii0_txer_mux  = (pcs_loopback_en[0]) ?  physs0.parmquad0.pcs100_wrap_0.quadpcs100_0.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_0.gmii0_rxer_mux : physs0.parmquad0.pcs100_wrap_0.quadpcs100_0.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_0.gmii_txer_conv;


//force physs0.parmquad0.pcs100_wrap_0.quadpcs100_0.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_1.reset_tx_clk= sync_i_reset[1];
//force physs0.parmquad0.pcs100_wrap_0.quadpcs100_0.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_1.reset_rx_clk= sync_i_reset[1];
//force physs0.parmquad0.pcs100_wrap_0.quadpcs100_0.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_1.reset_ref_clk= sync_i_reset[1];
//force physs0.parmquad0.pcs100_wrap_0.quadpcs100_0.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_1.reset_reg_clk= sync_i_reset[1];
force physs0.parmquad0.pcs100_wrap_0.quadpcs100_0.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_1.tbi_rx = tbi_rx_phy[1][9:0];
force tbi_tx_phy[1][9:0] = physs0.parmquad0.pcs100_wrap_0.quadpcs100_0.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_1.tbi_tx ;
force physs0.parmquad0.pcs100_wrap_0.quadpcs100_0.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_1.gmii_rxd_conv  = (~pcs_loopback_en[0]) ? (serdes_loopback_en[0] ? physs0.parmquad0.pcs100_wrap_0.quadpcs100_0.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_1.gmii_txd_conv : physs0.parmquad0.pcs100_wrap_0.quadpcs100_0.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_1.gmii0_rxd_mux) : 0;
force physs0.parmquad0.pcs100_wrap_0.quadpcs100_0.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_1.gmii_rxdv_conv = (~pcs_loopback_en[0]) ? (serdes_loopback_en[0] ? physs0.parmquad0.pcs100_wrap_0.quadpcs100_0.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_1.gmii_txen_conv : physs0.parmquad0.pcs100_wrap_0.quadpcs100_0.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_1.gmii0_rxdv_mux) : 0;
force physs0.parmquad0.pcs100_wrap_0.quadpcs100_0.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_1.gmii_rxer_conv = (~pcs_loopback_en[0]) ? (serdes_loopback_en[0] ? physs0.parmquad0.pcs100_wrap_0.quadpcs100_0.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_1.gmii_txer_conv : physs0.parmquad0.pcs100_wrap_0.quadpcs100_0.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_1.gmii0_rxer_mux) : 0;
force  physs0.parmquad0.pcs100_wrap_0.quadpcs100_0.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_1.gmii0_txd_mux   = (pcs_loopback_en[0]) ?  physs0.parmquad0.pcs100_wrap_0.quadpcs100_0.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_1.gmii0_rxd_mux :  physs0.parmquad0.pcs100_wrap_0.quadpcs100_0.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_1.gmii_txd_conv;                                   
force  physs0.parmquad0.pcs100_wrap_0.quadpcs100_0.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_1.gmii0_txen_mux  = (pcs_loopback_en[0]) ?  physs0.parmquad0.pcs100_wrap_0.quadpcs100_0.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_1.gmii0_rxdv_mux : physs0.parmquad0.pcs100_wrap_0.quadpcs100_0.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_1.gmii_txen_conv;                                  
force  physs0.parmquad0.pcs100_wrap_0.quadpcs100_0.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_1.gmii0_txer_mux  = (pcs_loopback_en[0]) ?  physs0.parmquad0.pcs100_wrap_0.quadpcs100_0.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_1.gmii0_rxer_mux : physs0.parmquad0.pcs100_wrap_0.quadpcs100_0.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_1.gmii_txer_conv;

//force physs0.parmquad0.pcs100_wrap_0.quadpcs100_0.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_2.reset_tx_clk= sync_i_reset[2];
//force physs0.parmquad0.pcs100_wrap_0.quadpcs100_0.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_2.reset_rx_clk= sync_i_reset[2];
//force physs0.parmquad0.pcs100_wrap_0.quadpcs100_0.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_2.reset_ref_clk= sync_i_reset[2];
//force physs0.parmquad0.pcs100_wrap_0.quadpcs100_0.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_2.reset_reg_clk= sync_i_reset[2];
force physs0.parmquad0.pcs100_wrap_0.quadpcs100_0.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_2.tbi_rx = tbi_rx_phy[2][9:0];
force tbi_tx_phy[2][9:0] = physs0.parmquad0.pcs100_wrap_0.quadpcs100_0.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_2.tbi_tx ;
force physs0.parmquad0.pcs100_wrap_0.quadpcs100_0.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_2.gmii_rxd_conv  = (~pcs_loopback_en[0]) ? (serdes_loopback_en[0] ? physs0.parmquad0.pcs100_wrap_0.quadpcs100_0.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_2.gmii_txd_conv : physs0.parmquad0.pcs100_wrap_0.quadpcs100_0.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_2.gmii0_rxd_mux) : 0;
force physs0.parmquad0.pcs100_wrap_0.quadpcs100_0.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_2.gmii_rxdv_conv = (~pcs_loopback_en[0]) ? (serdes_loopback_en[0] ? physs0.parmquad0.pcs100_wrap_0.quadpcs100_0.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_2.gmii_txen_conv : physs0.parmquad0.pcs100_wrap_0.quadpcs100_0.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_2.gmii0_rxdv_mux) : 0;
force physs0.parmquad0.pcs100_wrap_0.quadpcs100_0.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_2.gmii_rxer_conv = (~pcs_loopback_en[0]) ? (serdes_loopback_en[0] ? physs0.parmquad0.pcs100_wrap_0.quadpcs100_0.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_2.gmii_txer_conv : physs0.parmquad0.pcs100_wrap_0.quadpcs100_0.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_2.gmii0_rxer_mux) : 0;
force  physs0.parmquad0.pcs100_wrap_0.quadpcs100_0.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_2.gmii0_txd_mux   = (pcs_loopback_en[0]) ?  physs0.parmquad0.pcs100_wrap_0.quadpcs100_0.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_2.gmii0_rxd_mux :  physs0.parmquad0.pcs100_wrap_0.quadpcs100_0.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_2.gmii_txd_conv;                                   
force  physs0.parmquad0.pcs100_wrap_0.quadpcs100_0.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_2.gmii0_txen_mux  = (pcs_loopback_en[0]) ?  physs0.parmquad0.pcs100_wrap_0.quadpcs100_0.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_2.gmii0_rxdv_mux : physs0.parmquad0.pcs100_wrap_0.quadpcs100_0.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_2.gmii_txen_conv;                                  
force  physs0.parmquad0.pcs100_wrap_0.quadpcs100_0.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_2.gmii0_txer_mux  = (pcs_loopback_en[0]) ?  physs0.parmquad0.pcs100_wrap_0.quadpcs100_0.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_2.gmii0_rxer_mux : physs0.parmquad0.pcs100_wrap_0.quadpcs100_0.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_2.gmii_txer_conv;

//force physs0.parmquad0.pcs100_wrap_0.quadpcs100_0.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_3.reset_tx_clk= sync_i_reset[3];
//force physs0.parmquad0.pcs100_wrap_0.quadpcs100_0.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_3.reset_rx_clk= sync_i_reset[3];
//force physs0.parmquad0.pcs100_wrap_0.quadpcs100_0.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_3.reset_ref_clk= sync_i_reset[3];
//force physs0.parmquad0.pcs100_wrap_0.quadpcs100_0.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_3.reset_reg_clk= sync_i_reset[3];
force physs0.parmquad0.pcs100_wrap_0.quadpcs100_0.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_3.tbi_rx = tbi_rx_phy[3][9:0];
force tbi_tx_phy[3][9:0] = physs0.parmquad0.pcs100_wrap_0.quadpcs100_0.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_3.tbi_tx ;
force physs0.parmquad0.pcs100_wrap_0.quadpcs100_0.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_3.gmii_rxd_conv  = (~pcs_loopback_en[0]) ? (serdes_loopback_en[0] ? physs0.parmquad0.pcs100_wrap_0.quadpcs100_0.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_3.gmii_txd_conv : physs0.parmquad0.pcs100_wrap_0.quadpcs100_0.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_3.gmii0_rxd_mux) : 0;
force physs0.parmquad0.pcs100_wrap_0.quadpcs100_0.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_3.gmii_rxdv_conv = (~pcs_loopback_en[0]) ? (serdes_loopback_en[0] ? physs0.parmquad0.pcs100_wrap_0.quadpcs100_0.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_3.gmii_txen_conv : physs0.parmquad0.pcs100_wrap_0.quadpcs100_0.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_3.gmii0_rxdv_mux) : 0;
force physs0.parmquad0.pcs100_wrap_0.quadpcs100_0.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_3.gmii_rxer_conv = (~pcs_loopback_en[0]) ? (serdes_loopback_en[0] ? physs0.parmquad0.pcs100_wrap_0.quadpcs100_0.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_3.gmii_txer_conv : physs0.parmquad0.pcs100_wrap_0.quadpcs100_0.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_3.gmii0_rxer_mux) : 0;
force  physs0.parmquad0.pcs100_wrap_0.quadpcs100_0.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_3.gmii0_txd_mux   = (pcs_loopback_en[0]) ?  physs0.parmquad0.pcs100_wrap_0.quadpcs100_0.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_3.gmii0_rxd_mux :  physs0.parmquad0.pcs100_wrap_0.quadpcs100_0.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_3.gmii_txd_conv;                                   
force  physs0.parmquad0.pcs100_wrap_0.quadpcs100_0.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_3.gmii0_txen_mux  = (pcs_loopback_en[0]) ?  physs0.parmquad0.pcs100_wrap_0.quadpcs100_0.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_3.gmii0_rxdv_mux : physs0.parmquad0.pcs100_wrap_0.quadpcs100_0.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_3.gmii_txen_conv;                                  
force  physs0.parmquad0.pcs100_wrap_0.quadpcs100_0.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_3.gmii0_txer_mux  = (pcs_loopback_en[0]) ?  physs0.parmquad0.pcs100_wrap_0.quadpcs100_0.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_3.gmii0_rxer_mux : physs0.parmquad0.pcs100_wrap_0.quadpcs100_0.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_3.gmii_txer_conv;

//force physs0.parmquad1.pcs100_wrap_1.quadpcs100_1.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_0.reset_tx_clk= sync_i_reset[4];
//force physs0.parmquad1.pcs100_wrap_1.quadpcs100_1.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_0.reset_rx_clk= sync_i_reset[4];
//force physs0.parmquad1.pcs100_wrap_1.quadpcs100_1.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_0.reset_ref_clk= sync_i_reset[4];
//force physs0.parmquad1.pcs100_wrap_1.quadpcs100_1.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_0.reset_reg_clk= sync_i_reset[4];
force physs0.parmquad1.pcs100_wrap_1.quadpcs100_1.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_0.tbi_rx = tbi_rx_phy[4][9:0];
force tbi_tx_phy[4][9:0] = physs0.parmquad1.pcs100_wrap_1.quadpcs100_1.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_0.tbi_tx ;
force physs0.parmquad1.pcs100_wrap_1.quadpcs100_1.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_0.gmii_rxd_conv  = (~pcs_loopback_en[0]) ? (serdes_loopback_en[0] ? physs0.parmquad1.pcs100_wrap_1.quadpcs100_1.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_0.gmii_txd_conv : physs0.parmquad1.pcs100_wrap_1.quadpcs100_1.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_0.gmii0_rxd_mux) : 0;
force physs0.parmquad1.pcs100_wrap_1.quadpcs100_1.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_0.gmii_rxdv_conv = (~pcs_loopback_en[0]) ? (serdes_loopback_en[0] ? physs0.parmquad1.pcs100_wrap_1.quadpcs100_1.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_0.gmii_txen_conv : physs0.parmquad1.pcs100_wrap_1.quadpcs100_1.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_0.gmii0_rxdv_mux) : 0;
force physs0.parmquad1.pcs100_wrap_1.quadpcs100_1.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_0.gmii_rxer_conv = (~pcs_loopback_en[0]) ? (serdes_loopback_en[0] ? physs0.parmquad1.pcs100_wrap_1.quadpcs100_1.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_0.gmii_txer_conv : physs0.parmquad1.pcs100_wrap_1.quadpcs100_1.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_0.gmii0_rxer_mux) : 0;
force  physs0.parmquad1.pcs100_wrap_1.quadpcs100_1.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_0.gmii0_txd_mux   = (pcs_loopback_en[0]) ?  physs0.parmquad1.pcs100_wrap_1.quadpcs100_1.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_0.gmii0_rxd_mux :  physs0.parmquad1.pcs100_wrap_1.quadpcs100_1.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_0.gmii_txd_conv;                                   
force  physs0.parmquad1.pcs100_wrap_1.quadpcs100_1.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_0.gmii0_txen_mux  = (pcs_loopback_en[0]) ?  physs0.parmquad1.pcs100_wrap_1.quadpcs100_1.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_0.gmii0_rxdv_mux : physs0.parmquad1.pcs100_wrap_1.quadpcs100_1.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_0.gmii_txen_conv;                                  
force  physs0.parmquad1.pcs100_wrap_1.quadpcs100_1.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_0.gmii0_txer_mux  = (pcs_loopback_en[0]) ?  physs0.parmquad1.pcs100_wrap_1.quadpcs100_1.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_0.gmii0_rxer_mux : physs0.parmquad1.pcs100_wrap_1.quadpcs100_1.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_0.gmii_txer_conv;

//force physs0.parmquad1.pcs100_wrap_1.quadpcs100_1.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_1.reset_tx_clk= sync_i_reset[5];
//force physs0.parmquad1.pcs100_wrap_1.quadpcs100_1.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_1.reset_rx_clk= sync_i_reset[5];
//force physs0.parmquad1.pcs100_wrap_1.quadpcs100_1.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_1.reset_ref_clk= sync_i_reset[5];
//force physs0.parmquad1.pcs100_wrap_1.quadpcs100_1.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_1.reset_reg_clk= sync_i_reset[5];
force physs0.parmquad1.pcs100_wrap_1.quadpcs100_1.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_1.tbi_rx = tbi_rx_phy[5][9:0];
force tbi_tx_phy[5][9:0] = physs0.parmquad1.pcs100_wrap_1.quadpcs100_1.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_1.tbi_tx ;
force physs0.parmquad1.pcs100_wrap_1.quadpcs100_1.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_1.gmii_rxd_conv  = (~pcs_loopback_en[0]) ? (serdes_loopback_en[0] ? physs0.parmquad1.pcs100_wrap_1.quadpcs100_1.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_1.gmii_txd_conv : physs0.parmquad1.pcs100_wrap_1.quadpcs100_1.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_1.gmii0_rxd_mux) : 0;
force physs0.parmquad1.pcs100_wrap_1.quadpcs100_1.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_1.gmii_rxdv_conv = (~pcs_loopback_en[0]) ? (serdes_loopback_en[0] ? physs0.parmquad1.pcs100_wrap_1.quadpcs100_1.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_1.gmii_txen_conv : physs0.parmquad1.pcs100_wrap_1.quadpcs100_1.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_1.gmii0_rxdv_mux) : 0;
force physs0.parmquad1.pcs100_wrap_1.quadpcs100_1.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_1.gmii_rxer_conv = (~pcs_loopback_en[0]) ? (serdes_loopback_en[0] ? physs0.parmquad1.pcs100_wrap_1.quadpcs100_1.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_1.gmii_txer_conv : physs0.parmquad1.pcs100_wrap_1.quadpcs100_1.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_1.gmii0_rxer_mux) : 0;
force  physs0.parmquad1.pcs100_wrap_1.quadpcs100_1.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_1.gmii0_txd_mux   = (pcs_loopback_en[0]) ?  physs0.parmquad1.pcs100_wrap_1.quadpcs100_1.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_1.gmii0_rxd_mux :  physs0.parmquad1.pcs100_wrap_1.quadpcs100_1.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_1.gmii_txd_conv;                                   
force  physs0.parmquad1.pcs100_wrap_1.quadpcs100_1.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_1.gmii0_txen_mux  = (pcs_loopback_en[0]) ?  physs0.parmquad1.pcs100_wrap_1.quadpcs100_1.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_1.gmii0_rxdv_mux : physs0.parmquad1.pcs100_wrap_1.quadpcs100_1.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_1.gmii_txen_conv;                                  
force  physs0.parmquad1.pcs100_wrap_1.quadpcs100_1.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_1.gmii0_txer_mux  = (pcs_loopback_en[0]) ?  physs0.parmquad1.pcs100_wrap_1.quadpcs100_1.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_1.gmii0_rxer_mux : physs0.parmquad1.pcs100_wrap_1.quadpcs100_1.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_1.gmii_txer_conv;


//force physs0.parmquad1.pcs100_wrap_1.quadpcs100_1.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_2.reset_tx_clk= sync_i_reset[6];
//force physs0.parmquad1.pcs100_wrap_1.quadpcs100_1.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_2.reset_rx_clk= sync_i_reset[6];
//force physs0.parmquad1.pcs100_wrap_1.quadpcs100_1.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_2.reset_ref_clk= sync_i_reset[6];
//force physs0.parmquad1.pcs100_wrap_1.quadpcs100_1.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_2.reset_reg_clk= sync_i_reset[6];
force physs0.parmquad1.pcs100_wrap_1.quadpcs100_1.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_2.tbi_rx = tbi_rx_phy[6][9:0];
force tbi_tx_phy[6][9:0] = physs0.parmquad1.pcs100_wrap_1.quadpcs100_1.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_2.tbi_tx ;
force physs0.parmquad1.pcs100_wrap_1.quadpcs100_1.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_2.gmii_rxd_conv  = (~pcs_loopback_en[0]) ? (serdes_loopback_en[0] ? physs0.parmquad1.pcs100_wrap_1.quadpcs100_1.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_2.gmii_txd_conv : physs0.parmquad1.pcs100_wrap_1.quadpcs100_1.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_2.gmii0_rxd_mux) : 0;
force physs0.parmquad1.pcs100_wrap_1.quadpcs100_1.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_2.gmii_rxdv_conv = (~pcs_loopback_en[0]) ? (serdes_loopback_en[0] ? physs0.parmquad1.pcs100_wrap_1.quadpcs100_1.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_2.gmii_txen_conv : physs0.parmquad1.pcs100_wrap_1.quadpcs100_1.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_2.gmii0_rxdv_mux) : 0;
force physs0.parmquad1.pcs100_wrap_1.quadpcs100_1.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_2.gmii_rxer_conv = (~pcs_loopback_en[0]) ? (serdes_loopback_en[0] ? physs0.parmquad1.pcs100_wrap_1.quadpcs100_1.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_2.gmii_txer_conv : physs0.parmquad1.pcs100_wrap_1.quadpcs100_1.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_2.gmii0_rxer_mux) : 0;
force  physs0.parmquad1.pcs100_wrap_1.quadpcs100_1.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_2.gmii0_txd_mux   = (pcs_loopback_en[0]) ?  physs0.parmquad1.pcs100_wrap_1.quadpcs100_1.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_2.gmii0_rxd_mux :  physs0.parmquad1.pcs100_wrap_1.quadpcs100_1.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_2.gmii_txd_conv;                                   
force  physs0.parmquad1.pcs100_wrap_1.quadpcs100_1.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_2.gmii0_txen_mux  = (pcs_loopback_en[0]) ?  physs0.parmquad1.pcs100_wrap_1.quadpcs100_1.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_2.gmii0_rxdv_mux : physs0.parmquad1.pcs100_wrap_1.quadpcs100_1.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_2.gmii_txen_conv;                                  
force  physs0.parmquad1.pcs100_wrap_1.quadpcs100_1.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_2.gmii0_txer_mux  = (pcs_loopback_en[0]) ?  physs0.parmquad1.pcs100_wrap_1.quadpcs100_1.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_2.gmii0_rxer_mux : physs0.parmquad1.pcs100_wrap_1.quadpcs100_1.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_2.gmii_txer_conv;


//force physs0.parmquad1.pcs100_wrap_1.quadpcs100_1.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_3.reset_tx_clk= sync_i_reset[7];
//force physs0.parmquad1.pcs100_wrap_1.quadpcs100_1.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_3.reset_rx_clk= sync_i_reset[7];
//force physs0.parmquad1.pcs100_wrap_1.quadpcs100_1.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_3.reset_ref_clk= sync_i_reset[7];
//force physs0.parmquad1.pcs100_wrap_1.quadpcs100_1.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_3.reset_reg_clk= sync_i_reset[7];
force physs0.parmquad1.pcs100_wrap_1.quadpcs100_1.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_3.tbi_rx = tbi_rx_phy[7][9:0];
force tbi_tx_phy[7][9:0] = physs0.parmquad1.pcs100_wrap_1.quadpcs100_1.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_3.tbi_tx ;
force physs0.parmquad1.pcs100_wrap_1.quadpcs100_1.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_3.gmii_rxd_conv  = (~pcs_loopback_en[0]) ? (serdes_loopback_en[0] ? physs0.parmquad1.pcs100_wrap_1.quadpcs100_1.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_3.gmii_txd_conv : physs0.parmquad1.pcs100_wrap_1.quadpcs100_1.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_3.gmii0_rxd_mux) : 0;
force physs0.parmquad1.pcs100_wrap_1.quadpcs100_1.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_3.gmii_rxdv_conv = (~pcs_loopback_en[0]) ? (serdes_loopback_en[0] ? physs0.parmquad1.pcs100_wrap_1.quadpcs100_1.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_3.gmii_txen_conv : physs0.parmquad1.pcs100_wrap_1.quadpcs100_1.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_3.gmii0_rxdv_mux) : 0;
force physs0.parmquad1.pcs100_wrap_1.quadpcs100_1.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_3.gmii_rxer_conv = (~pcs_loopback_en[0]) ? (serdes_loopback_en[0] ? physs0.parmquad1.pcs100_wrap_1.quadpcs100_1.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_3.gmii_txer_conv : physs0.parmquad1.pcs100_wrap_1.quadpcs100_1.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_3.gmii0_rxer_mux) : 0;
force  physs0.parmquad1.pcs100_wrap_1.quadpcs100_1.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_3.gmii0_txd_mux   = (pcs_loopback_en[0]) ?  physs0.parmquad1.pcs100_wrap_1.quadpcs100_1.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_3.gmii0_rxd_mux :  physs0.parmquad1.pcs100_wrap_1.quadpcs100_1.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_3.gmii_txd_conv;                                   
force  physs0.parmquad1.pcs100_wrap_1.quadpcs100_1.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_3.gmii0_txen_mux  = (pcs_loopback_en[0]) ?  physs0.parmquad1.pcs100_wrap_1.quadpcs100_1.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_3.gmii0_rxdv_mux : physs0.parmquad1.pcs100_wrap_1.quadpcs100_1.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_3.gmii_txen_conv;                                  
force  physs0.parmquad1.pcs100_wrap_1.quadpcs100_1.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_3.gmii0_txer_mux  = (pcs_loopback_en[0]) ?  physs0.parmquad1.pcs100_wrap_1.quadpcs100_1.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_3.gmii0_rxer_mux : physs0.parmquad1.pcs100_wrap_1.quadpcs100_1.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_3.gmii_txer_conv;


//force physs1.parpquad0.pcs100_wrap_2.quadpcs100_0.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_0.reset_tx_clk= sync_i_reset[8];
//force physs1.parpquad0.pcs100_wrap_2.quadpcs100_0.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_0.reset_rx_clk= sync_i_reset[8];
//force physs1.parpquad0.pcs100_wrap_2.quadpcs100_0.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_0.reset_ref_clk= sync_i_reset[8];
//force physs1.parpquad0.pcs100_wrap_2.quadpcs100_0.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_0.reset_reg_clk= sync_i_reset[8];
//force physs1.parpquad0.pcs100_wrap_2.quadpcs100_0.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_0.tbi_rx = tbi_rx_phy[8][9:0];
//force tbi_tx_phy[8][9:0] = physs1.parpquad0.pcs100_wrap_2.quadpcs100_0.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_0.tbi_tx ;
//force physs1.parpquad0.pcs100_wrap_2.quadpcs100_0.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_0.gmii_rxd_conv  = (~pcs_loopback_en[0]) ? (serdes_loopback_en[0] ? physs1.parpquad0.pcs100_wrap_2.quadpcs100_0.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_0.gmii_txd_conv : physs1.parpquad0.pcs100_wrap_2.quadpcs100_0.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_0.gmii0_rxd_mux) : 0;
//force physs1.parpquad0.pcs100_wrap_2.quadpcs100_0.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_0.gmii_rxdv_conv = (~pcs_loopback_en[0]) ? (serdes_loopback_en[0] ? physs1.parpquad0.pcs100_wrap_2.quadpcs100_0.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_0.gmii_txen_conv : physs1.parpquad0.pcs100_wrap_2.quadpcs100_0.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_0.gmii0_rxdv_mux) : 0;
//force physs1.parpquad0.pcs100_wrap_2.quadpcs100_0.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_0.gmii_rxer_conv = (~pcs_loopback_en[0]) ? (serdes_loopback_en[0] ? physs1.parpquad0.pcs100_wrap_2.quadpcs100_0.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_0.gmii_txer_conv : physs1.parpquad0.pcs100_wrap_2.quadpcs100_0.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_0.gmii0_rxer_mux) : 0;
//force  physs1.parpquad0.pcs100_wrap_2.quadpcs100_0.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_0.gmii0_txd_mux   = (pcs_loopback_en[0]) ?  physs1.parpquad0.pcs100_wrap_2.quadpcs100_0.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_0.gmii0_rxd_mux :  physs1.parpquad0.pcs100_wrap_2.quadpcs100_0.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_0.gmii_txd_conv;                                   
//force  physs1.parpquad0.pcs100_wrap_2.quadpcs100_0.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_0.gmii0_txen_mux  = (pcs_loopback_en[0]) ?  physs1.parpquad0.pcs100_wrap_2.quadpcs100_0.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_0.gmii0_rxdv_mux : physs1.parpquad0.pcs100_wrap_2.quadpcs100_0.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_0.gmii_txen_conv;                                  
//force  physs1.parpquad0.pcs100_wrap_2.quadpcs100_0.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_0.gmii0_txer_mux  = (pcs_loopback_en[0]) ?  physs1.parpquad0.pcs100_wrap_2.quadpcs100_0.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_0.gmii0_rxer_mux : physs1.parpquad0.pcs100_wrap_2.quadpcs100_0.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_0.gmii_txer_conv;

//force physs1.parpquad0.pcs100_wrap_2.quadpcs100_0.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_1.reset_tx_clk= sync_i_reset[9];
//force physs1.parpquad0.pcs100_wrap_2.quadpcs100_0.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_1.reset_rx_clk= sync_i_reset[9];
//force physs1.parpquad0.pcs100_wrap_2.quadpcs100_0.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_1.reset_ref_clk= sync_i_reset[9];
//force physs1.parpquad0.pcs100_wrap_2.quadpcs100_0.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_1.reset_reg_clk= sync_i_reset[9];
//force physs1.parpquad0.pcs100_wrap_2.quadpcs100_0.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_1.tbi_rx = tbi_rx_phy[9][9:0];
//force tbi_tx_phy[9][9:0]= physs1.parpquad0.pcs100_wrap_2.quadpcs100_0.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_1.tbi_tx ;
//force physs1.parpquad0.pcs100_wrap_2.quadpcs100_0.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_1.gmii_rxd_conv  = (~pcs_loopback_en[0]) ? (serdes_loopback_en[0] ? physs1.parpquad0.pcs100_wrap_2.quadpcs100_0.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_1.gmii_txd_conv : physs1.parpquad0.pcs100_wrap_2.quadpcs100_0.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_1.gmii0_rxd_mux) : 0;
//force physs1.parpquad0.pcs100_wrap_2.quadpcs100_0.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_1.gmii_rxdv_conv = (~pcs_loopback_en[0]) ? (serdes_loopback_en[0] ? physs1.parpquad0.pcs100_wrap_2.quadpcs100_0.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_1.gmii_txen_conv : physs1.parpquad0.pcs100_wrap_2.quadpcs100_0.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_1.gmii0_rxdv_mux) : 0;
//force physs1.parpquad0.pcs100_wrap_2.quadpcs100_0.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_1.gmii_rxer_conv = (~pcs_loopback_en[0]) ? (serdes_loopback_en[0] ? physs1.parpquad0.pcs100_wrap_2.quadpcs100_0.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_1.gmii_txer_conv : physs1.parpquad0.pcs100_wrap_2.quadpcs100_0.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_1.gmii0_rxer_mux) : 0;
//force  physs1.parpquad0.pcs100_wrap_2.quadpcs100_0.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_1.gmii0_txd_mux   = (pcs_loopback_en[0]) ?  physs1.parpquad0.pcs100_wrap_2.quadpcs100_0.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_1.gmii0_rxd_mux :  physs1.parpquad0.pcs100_wrap_2.quadpcs100_0.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_1.gmii_txd_conv;                                   
//force  physs1.parpquad0.pcs100_wrap_2.quadpcs100_0.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_1.gmii0_txen_mux  = (pcs_loopback_en[0]) ?  physs1.parpquad0.pcs100_wrap_2.quadpcs100_0.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_1.gmii0_rxdv_mux : physs1.parpquad0.pcs100_wrap_2.quadpcs100_0.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_1.gmii_txen_conv;                                  
//force  physs1.parpquad0.pcs100_wrap_2.quadpcs100_0.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_1.gmii0_txer_mux  = (pcs_loopback_en[0]) ?  physs1.parpquad0.pcs100_wrap_2.quadpcs100_0.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_1.gmii0_rxer_mux : physs1.parpquad0.pcs100_wrap_2.quadpcs100_0.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_1.gmii_txer_conv;

//force physs1.parpquad0.pcs100_wrap_2.quadpcs100_0.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_2.reset_tx_clk= sync_i_reset[10];
//force physs1.parpquad0.pcs100_wrap_2.quadpcs100_0.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_2.reset_rx_clk= sync_i_reset[10];
//force physs1.parpquad0.pcs100_wrap_2.quadpcs100_0.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_2.reset_ref_clk= sync_i_reset[10];
//force physs1.parpquad0.pcs100_wrap_2.quadpcs100_0.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_2.reset_reg_clk= sync_i_reset[10];
//force physs1.parpquad0.pcs100_wrap_2.quadpcs100_0.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_2.tbi_rx = tbi_rx_phy[10][9:0];
//force tbi_tx_phy[10][9:0] = physs1.parpquad0.pcs100_wrap_2.quadpcs100_0.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_2.tbi_tx ;
//force physs1.parpquad0.pcs100_wrap_2.quadpcs100_0.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_2.gmii_rxd_conv  = (~pcs_loopback_en[0]) ? (serdes_loopback_en[0] ? physs1.parpquad0.pcs100_wrap_2.quadpcs100_0.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_2.gmii_txd_conv : physs1.parpquad0.pcs100_wrap_2.quadpcs100_0.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_2.gmii0_rxd_mux) : 0;
//force physs1.parpquad0.pcs100_wrap_2.quadpcs100_0.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_2.gmii_rxdv_conv = (~pcs_loopback_en[0]) ? (serdes_loopback_en[0] ? physs1.parpquad0.pcs100_wrap_2.quadpcs100_0.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_2.gmii_txen_conv : physs1.parpquad0.pcs100_wrap_2.quadpcs100_0.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_2.gmii0_rxdv_mux) : 0;
//force physs1.parpquad0.pcs100_wrap_2.quadpcs100_0.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_2.gmii_rxer_conv = (~pcs_loopback_en[0]) ? (serdes_loopback_en[0] ? physs1.parpquad0.pcs100_wrap_2.quadpcs100_0.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_2.gmii_txer_conv : physs1.parpquad0.pcs100_wrap_2.quadpcs100_0.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_2.gmii0_rxer_mux) : 0;
//force  physs1.parpquad0.pcs100_wrap_2.quadpcs100_0.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_2.gmii0_txd_mux   = (pcs_loopback_en[0]) ?  physs1.parpquad0.pcs100_wrap_2.quadpcs100_0.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_2.gmii0_rxd_mux :  physs1.parpquad0.pcs100_wrap_2.quadpcs100_0.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_2.gmii_txd_conv;                                   
//force  physs1.parpquad0.pcs100_wrap_2.quadpcs100_0.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_2.gmii0_txen_mux  = (pcs_loopback_en[0]) ?  physs1.parpquad0.pcs100_wrap_2.quadpcs100_0.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_2.gmii0_rxdv_mux : physs1.parpquad0.pcs100_wrap_2.quadpcs100_0.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_2.gmii_txen_conv;                                  
//force  physs1.parpquad0.pcs100_wrap_2.quadpcs100_0.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_2.gmii0_txer_mux  = (pcs_loopback_en[0]) ?  physs1.parpquad0.pcs100_wrap_2.quadpcs100_0.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_2.gmii0_rxer_mux : physs1.parpquad0.pcs100_wrap_2.quadpcs100_0.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_2.gmii_txer_conv;


//force physs1.parpquad0.pcs100_wrap_2.quadpcs100_0.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_3.reset_tx_clk= sync_i_reset[11];
//force physs1.parpquad0.pcs100_wrap_2.quadpcs100_0.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_3.reset_rx_clk= sync_i_reset[11];
//force physs1.parpquad0.pcs100_wrap_2.quadpcs100_0.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_3.reset_ref_clk= sync_i_reset[11];
//force physs1.parpquad0.pcs100_wrap_2.quadpcs100_0.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_3.reset_reg_clk= sync_i_reset[11];
//force physs1.parpquad0.pcs100_wrap_2.quadpcs100_0.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_3.tbi_rx = tbi_rx_phy[11][9:0];
//force tbi_tx_phy[11][9:0] = physs1.parpquad0.pcs100_wrap_2.quadpcs100_0.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_3.tbi_tx ;
//force physs1.parpquad0.pcs100_wrap_2.quadpcs100_0.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_3.gmii_rxd_conv  = (~pcs_loopback_en[0]) ? (serdes_loopback_en[0] ? physs1.parpquad0.pcs100_wrap_2.quadpcs100_0.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_3.gmii_txd_conv : physs1.parpquad0.pcs100_wrap_2.quadpcs100_0.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_3.gmii0_rxd_mux) : 0;
//force physs1.parpquad0.pcs100_wrap_2.quadpcs100_0.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_3.gmii_rxdv_conv = (~pcs_loopback_en[0]) ? (serdes_loopback_en[0] ? physs1.parpquad0.pcs100_wrap_2.quadpcs100_0.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_3.gmii_txen_conv : physs1.parpquad0.pcs100_wrap_2.quadpcs100_0.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_3.gmii0_rxdv_mux) : 0;
//force physs1.parpquad0.pcs100_wrap_2.quadpcs100_0.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_3.gmii_rxer_conv = (~pcs_loopback_en[0]) ? (serdes_loopback_en[0] ? physs1.parpquad0.pcs100_wrap_2.quadpcs100_0.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_3.gmii_txer_conv : physs1.parpquad0.pcs100_wrap_2.quadpcs100_0.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_3.gmii0_rxer_mux) : 0;
//force  physs1.parpquad0.pcs100_wrap_2.quadpcs100_0.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_3.gmii0_txd_mux   = (pcs_loopback_en[0]) ?  physs1.parpquad0.pcs100_wrap_2.quadpcs100_0.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_3.gmii0_rxd_mux :  physs1.parpquad0.pcs100_wrap_2.quadpcs100_0.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_3.gmii_txd_conv;                                   
//force  physs1.parpquad0.pcs100_wrap_2.quadpcs100_0.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_3.gmii0_txen_mux  = (pcs_loopback_en[0]) ?  physs1.parpquad0.pcs100_wrap_2.quadpcs100_0.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_3.gmii0_rxdv_mux : physs1.parpquad0.pcs100_wrap_2.quadpcs100_0.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_3.gmii_txen_conv;                                  
//force  physs1.parpquad0.pcs100_wrap_2.quadpcs100_0.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_3.gmii0_txer_mux  = (pcs_loopback_en[0]) ?  physs1.parpquad0.pcs100_wrap_2.quadpcs100_0.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_3.gmii0_rxer_mux : physs1.parpquad0.pcs100_wrap_2.quadpcs100_0.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_3.gmii_txer_conv;


//force physs1.parpquad1.pcs100_wrap_2.quadpcs100_0.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_0.reset_tx_clk= sync_i_reset[12];
//force physs1.parpquad1.pcs100_wrap_2.quadpcs100_0.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_0.reset_rx_clk= sync_i_reset[12];
//force physs1.parpquad1.pcs100_wrap_2.quadpcs100_0.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_0.reset_ref_clk= sync_i_reset[12];
//force physs1.parpquad1.pcs100_wrap_2.quadpcs100_0.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_0.reset_reg_clk= sync_i_reset[12];
//force physs1.parpquad1.pcs100_wrap_2.quadpcs100_0.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_0.tbi_rx = tbi_rx_phy[12][9:0];
//force tbi_tx_phy[12][9:0] = physs1.parpquad1.pcs100_wrap_2.quadpcs100_0.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_0.tbi_tx ;
//force physs1.parpquad1.pcs100_wrap_2.quadpcs100_0.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_0.gmii_rxd_conv  = (~pcs_loopback_en[0]) ? (serdes_loopback_en[0] ? physs1.parpquad1.pcs100_wrap_2.quadpcs100_0.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_0.gmii_txd_conv : physs1.parpquad1.pcs100_wrap_2.quadpcs100_0.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_0.gmii0_rxd_mux) : 0;
//force physs1.parpquad1.pcs100_wrap_2.quadpcs100_0.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_0.gmii_rxdv_conv = (~pcs_loopback_en[0]) ? (serdes_loopback_en[0] ? physs1.parpquad1.pcs100_wrap_2.quadpcs100_0.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_0.gmii_txen_conv : physs1.parpquad1.pcs100_wrap_2.quadpcs100_0.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_0.gmii0_rxdv_mux) : 0;
//force physs1.parpquad1.pcs100_wrap_2.quadpcs100_0.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_0.gmii_rxer_conv = (~pcs_loopback_en[0]) ? (serdes_loopback_en[0] ? physs1.parpquad1.pcs100_wrap_2.quadpcs100_0.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_0.gmii_txer_conv : physs1.parpquad1.pcs100_wrap_2.quadpcs100_0.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_0.gmii0_rxer_mux) : 0;
//force  physs1.parpquad1.pcs100_wrap_2.quadpcs100_0.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_0.gmii0_txd_mux   = (pcs_loopback_en[0]) ?  physs1.parpquad1.pcs100_wrap_2.quadpcs100_0.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_0.gmii0_rxd_mux :  physs1.parpquad1.pcs100_wrap_2.quadpcs100_0.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_0.gmii_txd_conv;                                   
//force  physs1.parpquad1.pcs100_wrap_2.quadpcs100_0.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_0.gmii0_txen_mux  = (pcs_loopback_en[0]) ?  physs1.parpquad1.pcs100_wrap_2.quadpcs100_0.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_0.gmii0_rxdv_mux : physs1.parpquad1.pcs100_wrap_2.quadpcs100_0.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_0.gmii_txen_conv;                                  
//force  physs1.parpquad1.pcs100_wrap_2.quadpcs100_0.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_0.gmii0_txer_mux  = (pcs_loopback_en[0]) ?  physs1.parpquad1.pcs100_wrap_2.quadpcs100_0.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_0.gmii0_rxer_mux : physs1.parpquad1.pcs100_wrap_2.quadpcs100_0.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_0.gmii_txer_conv;
//
//
////force physs1.parpquad1.pcs100_wrap_2.quadpcs100_0.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_1.reset_tx_clk= sync_i_reset[13];
////force physs1.parpquad1.pcs100_wrap_2.quadpcs100_0.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_1.reset_rx_clk= sync_i_reset[13];
////force physs1.parpquad1.pcs100_wrap_2.quadpcs100_0.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_1.reset_ref_clk= sync_i_reset[13];
////force physs1.parpquad1.pcs100_wrap_2.quadpcs100_0.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_1.reset_reg_clk= sync_i_reset[13];
////force physs1.parpquad1.pcs100_wrap_2.quadpcs100_0.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_1.tbi_rx = tbi_rx_phy[13][9:0];
////force tbi_tx_phy[13][9:0] = physs1.parpquad1.pcs100_wrap_2.quadpcs100_0.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_1.tbi_tx ;
//force physs1.parpquad1.pcs100_wrap_2.quadpcs100_0.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_1.gmii_rxd_conv  = (~pcs_loopback_en[0]) ? (serdes_loopback_en[0] ? physs1.parpquad1.pcs100_wrap_2.quadpcs100_0.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_1.gmii_txd_conv : physs1.parpquad1.pcs100_wrap_2.quadpcs100_0.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_1.gmii0_rxd_mux) : 0;
//force physs1.parpquad1.pcs100_wrap_2.quadpcs100_0.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_1.gmii_rxdv_conv = (~pcs_loopback_en[0]) ? (serdes_loopback_en[0] ? physs1.parpquad1.pcs100_wrap_2.quadpcs100_0.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_1.gmii_txen_conv : physs1.parpquad1.pcs100_wrap_2.quadpcs100_0.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_1.gmii0_rxdv_mux) : 0;
//force physs1.parpquad1.pcs100_wrap_2.quadpcs100_0.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_1.gmii_rxer_conv = (~pcs_loopback_en[0]) ? (serdes_loopback_en[0] ? physs1.parpquad1.pcs100_wrap_2.quadpcs100_0.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_1.gmii_txer_conv : physs1.parpquad1.pcs100_wrap_2.quadpcs100_0.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_1.gmii0_rxer_mux) : 0;
//force  physs1.parpquad1.pcs100_wrap_2.quadpcs100_0.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_1.gmii0_txd_mux   = (pcs_loopback_en[0]) ?  physs1.parpquad1.pcs100_wrap_2.quadpcs100_0.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_1.gmii0_rxd_mux :  physs1.parpquad1.pcs100_wrap_2.quadpcs100_0.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_1.gmii_txd_conv;                                   
//force  physs1.parpquad1.pcs100_wrap_2.quadpcs100_0.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_1.gmii0_txen_mux  = (pcs_loopback_en[0]) ?  physs1.parpquad1.pcs100_wrap_2.quadpcs100_0.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_1.gmii0_rxdv_mux : physs1.parpquad1.pcs100_wrap_2.quadpcs100_0.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_1.gmii_txen_conv;                                  
//force  physs1.parpquad1.pcs100_wrap_2.quadpcs100_0.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_1.gmii0_txer_mux  = (pcs_loopback_en[0]) ?  physs1.parpquad1.pcs100_wrap_2.quadpcs100_0.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_1.gmii0_rxer_mux : physs1.parpquad1.pcs100_wrap_2.quadpcs100_0.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_1.gmii_txer_conv;
//
//
////force physs1.parpquad1.pcs100_wrap_2.quadpcs100_0.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_2.reset_tx_clk= sync_i_reset[14];
////force physs1.parpquad1.pcs100_wrap_2.quadpcs100_0.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_2.reset_rx_clk= sync_i_reset[14];
////force physs1.parpquad1.pcs100_wrap_2.quadpcs100_0.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_2.reset_ref_clk= sync_i_reset[14];
////force physs1.parpquad1.pcs100_wrap_2.quadpcs100_0.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_2.reset_reg_clk= sync_i_reset[14];
////force physs1.parpquad1.pcs100_wrap_2.quadpcs100_0.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_2.tbi_rx = tbi_rx_phy[14][9:0];
////force tbi_tx_phy[14][9:0] = physs1.parpquad1.pcs100_wrap_2.quadpcs100_0.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_2.tbi_tx ;
//force physs1.parpquad1.pcs100_wrap_2.quadpcs100_0.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_2.gmii_rxd_conv  = (~pcs_loopback_en[0]) ? (serdes_loopback_en[0] ? physs1.parpquad1.pcs100_wrap_2.quadpcs100_0.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_2.gmii_txd_conv : physs1.parpquad1.pcs100_wrap_2.quadpcs100_0.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_2.gmii0_rxd_mux) : 0;
//force physs1.parpquad1.pcs100_wrap_2.quadpcs100_0.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_2.gmii_rxdv_conv = (~pcs_loopback_en[0]) ? (serdes_loopback_en[0] ? physs1.parpquad1.pcs100_wrap_2.quadpcs100_0.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_2.gmii_txen_conv : physs1.parpquad1.pcs100_wrap_2.quadpcs100_0.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_2.gmii0_rxdv_mux) : 0;
//force physs1.parpquad1.pcs100_wrap_2.quadpcs100_0.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_2.gmii_rxer_conv = (~pcs_loopback_en[0]) ? (serdes_loopback_en[0] ? physs1.parpquad1.pcs100_wrap_2.quadpcs100_0.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_2.gmii_txer_conv : physs1.parpquad1.pcs100_wrap_2.quadpcs100_0.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_2.gmii0_rxer_mux) : 0;
//force  physs1.parpquad1.pcs100_wrap_2.quadpcs100_0.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_2.gmii0_txd_mux   = (pcs_loopback_en[0]) ?  physs1.parpquad1.pcs100_wrap_2.quadpcs100_0.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_2.gmii0_rxd_mux :  physs1.parpquad1.pcs100_wrap_2.quadpcs100_0.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_2.gmii_txd_conv;                                   
//force  physs1.parpquad1.pcs100_wrap_2.quadpcs100_0.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_2.gmii0_txen_mux  = (pcs_loopback_en[0]) ?  physs1.parpquad1.pcs100_wrap_2.quadpcs100_0.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_2.gmii0_rxdv_mux : physs1.parpquad1.pcs100_wrap_2.quadpcs100_0.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_2.gmii_txen_conv;                                  
//force  physs1.parpquad1.pcs100_wrap_2.quadpcs100_0.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_2.gmii0_txer_mux  = (pcs_loopback_en[0]) ?  physs1.parpquad1.pcs100_wrap_2.quadpcs100_0.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_2.gmii0_rxer_mux : physs1.parpquad1.pcs100_wrap_2.quadpcs100_0.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_2.gmii_txer_conv;
//
//
////force physs1.parpquad1.pcs100_wrap_2.quadpcs100_0.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_3.reset_tx_clk= sync_i_reset[15];
////force physs1.parpquad1.pcs100_wrap_2.quadpcs100_0.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_3.reset_rx_clk= sync_i_reset[15];
////force physs1.parpquad1.pcs100_wrap_2.quadpcs100_0.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_3.reset_ref_clk= sync_i_reset[15];
////force physs1.parpquad1.pcs100_wrap_2.quadpcs100_0.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_3.reset_reg_clk= sync_i_reset[15];
////force physs1.parpquad1.pcs100_wrap_2.quadpcs100_0.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_3.tbi_rx = tbi_rx_phy[15][9:0];
////force tbi_tx_phy[15][9:0] = physs1.parpquad1.pcs100_wrap_2.quadpcs100_0.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_3.tbi_tx ;
//force physs1.parpquad1.pcs100_wrap_2.quadpcs100_0.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_3.gmii_rxd_conv  = (~pcs_loopback_en[0]) ? (serdes_loopback_en[0] ? physs1.parpquad1.pcs100_wrap_2.quadpcs100_0.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_3.gmii_txd_conv : physs1.parpquad1.pcs100_wrap_2.quadpcs100_0.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_3.gmii0_rxd_mux) : 0;
//force physs1.parpquad1.pcs100_wrap_2.quadpcs100_0.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_3.gmii_rxdv_conv = (~pcs_loopback_en[0]) ? (serdes_loopback_en[0] ? physs1.parpquad1.pcs100_wrap_2.quadpcs100_0.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_3.gmii_txen_conv : physs1.parpquad1.pcs100_wrap_2.quadpcs100_0.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_3.gmii0_rxdv_mux) : 0;
//force physs1.parpquad1.pcs100_wrap_2.quadpcs100_0.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_3.gmii_rxer_conv = (~pcs_loopback_en[0]) ? (serdes_loopback_en[0] ? physs1.parpquad1.pcs100_wrap_2.quadpcs100_0.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_3.gmii_txer_conv : physs1.parpquad1.pcs100_wrap_2.quadpcs100_0.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_3.gmii0_rxer_mux) : 0;
//force  physs1.parpquad1.pcs100_wrap_2.quadpcs100_0.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_3.gmii0_txd_mux   = (pcs_loopback_en[0]) ?  physs1.parpquad1.pcs100_wrap_2.quadpcs100_0.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_3.gmii0_rxd_mux :  physs1.parpquad1.pcs100_wrap_2.quadpcs100_0.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_3.gmii_txd_conv;                                   
//force  physs1.parpquad1.pcs100_wrap_2.quadpcs100_0.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_3.gmii0_txen_mux  = (pcs_loopback_en[0]) ?  physs1.parpquad1.pcs100_wrap_2.quadpcs100_0.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_3.gmii0_rxdv_mux : physs1.parpquad1.pcs100_wrap_2.quadpcs100_0.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_3.gmii_txen_conv;                                  
//force  physs1.parpquad1.pcs100_wrap_2.quadpcs100_0.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_3.gmii0_txer_mux  = (pcs_loopback_en[0]) ?  physs1.parpquad1.pcs100_wrap_2.quadpcs100_0.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_3.gmii0_rxer_mux : physs1.parpquad1.pcs100_wrap_2.quadpcs100_0.U_PCS_TOP.U_SGMII4x_USXGMII4x_INST.U_SGMII_10B_3.gmii_txer_conv;

//force physs0.parmisc_physs0.pcs_mac_pipeline_top_wrap_mquad0.U0_PIPE_XLGMII.clock =  rx_clk_out[0];
//force physs0.parmisc_physs0.pcs_mac_pipeline_top_wrap_mquad0.U1_PIPE_XLGMII.clock =  rx_clk_out[1];
//force physs0.parmisc_physs0.pcs_mac_pipeline_top_wrap_mquad0.U2_PIPE_XLGMII.clock =  rx_clk_out[2];
//force physs0.parmisc_physs0.pcs_mac_pipeline_top_wrap_mquad0.U3_PIPE_XLGMII.clock =  rx_clk_out[3];
//force physs0.parmisc_physs0.pcs_mac_pipeline_top_wrap_mquad1.U0_PIPE_XLGMII.clock = rx_clk_out[4];
//force physs0.parmisc_physs0.pcs_mac_pipeline_top_wrap_mquad1.U1_PIPE_XLGMII.clock = rx_clk_out[5];
//force physs0.parmisc_physs0.pcs_mac_pipeline_top_wrap_mquad1.U2_PIPE_XLGMII.clock = rx_clk_out[6];
//force physs0.parmisc_physs0.pcs_mac_pipeline_top_wrap_mquad1.U3_PIPE_XLGMII.clock = rx_clk_out[7];
//force physs1.parmisc_physs1.pcs_mac_pipeline_top_wrap_pquad0_0.U0_PIPE_XLGMII.clock = rx_clk_out[8];
//force physs0.parmisc_physs0.pcs_mac_pipeline_top_wrap_pquad0_1.U0_PIPE_XLGMII.clock = rx_clk_out[8];
//force physs1.parmisc_physs1.pcs_mac_pipeline_top_wrap_pquad0_0.U1_PIPE_XLGMII.clock = rx_clk_out[9];
//force physs0.parmisc_physs0.pcs_mac_pipeline_top_wrap_pquad0_1.U1_PIPE_XLGMII.clock = rx_clk_out[9];
//force physs1.parmisc_physs1.pcs_mac_pipeline_top_wrap_pquad0_0.U2_PIPE_XLGMII.clock = rx_clk_out[10];
//force physs0.parmisc_physs0.pcs_mac_pipeline_top_wrap_pquad0_1.U2_PIPE_XLGMII.clock = rx_clk_out[10];
//force physs1.parmisc_physs1.pcs_mac_pipeline_top_wrap_pquad0_0.U3_PIPE_XLGMII.clock = rx_clk_out[11];
//force physs0.parmisc_physs0.pcs_mac_pipeline_top_wrap_pquad0_1.U3_PIPE_XLGMII.clock = rx_clk_out[11];
//force physs1.parmisc_physs1.pcs_mac_pipeline_top_wrap_pquad1_0.U0_PIPE_XLGMII.clock = rx_clk_out[12];
//force physs0.parmisc_physs0.pcs_mac_pipeline_top_wrap_pquad1_1.U0_PIPE_XLGMII.clock = rx_clk_out[12];
//force physs1.parmisc_physs1.pcs_mac_pipeline_top_wrap_pquad1_0.U1_PIPE_XLGMII.clock = rx_clk_out[13];
//force physs0.parmisc_physs0.pcs_mac_pipeline_top_wrap_pquad1_1.U1_PIPE_XLGMII.clock = rx_clk_out[13];
//force physs1.parmisc_physs1.pcs_mac_pipeline_top_wrap_pquad1_0.U2_PIPE_XLGMII.clock = rx_clk_out[14];
//force physs0.parmisc_physs0.pcs_mac_pipeline_top_wrap_pquad1_1.U2_PIPE_XLGMII.clock = rx_clk_out[14];
//force physs1.parmisc_physs1.pcs_mac_pipeline_top_wrap_pquad1_0.U3_PIPE_XLGMII.clock = rx_clk_out[15];
//force physs0.parmisc_physs0.pcs_mac_pipeline_top_wrap_pquad1_1.U3_PIPE_XLGMII.clock = rx_clk_out[15];
//
//force physs0.parmisc_physs0.pcs_mac_pipeline_top_wrap_mquad0.U0_PIPE_XLGMII.reset =  sync_i_reset[0];
//force physs0.parmisc_physs0.pcs_mac_pipeline_top_wrap_mquad0.U1_PIPE_XLGMII.reset =  sync_i_reset[1];
//force physs0.parmisc_physs0.pcs_mac_pipeline_top_wrap_mquad0.U2_PIPE_XLGMII.reset =  sync_i_reset[2];
//force physs0.parmisc_physs0.pcs_mac_pipeline_top_wrap_mquad0.U3_PIPE_XLGMII.reset =  sync_i_reset[3];
//force physs0.parmisc_physs0.pcs_mac_pipeline_top_wrap_mquad1.U0_PIPE_XLGMII.reset = sync_i_reset[4];
//force physs0.parmisc_physs0.pcs_mac_pipeline_top_wrap_mquad1.U1_PIPE_XLGMII.reset = sync_i_reset[5];
//force physs0.parmisc_physs0.pcs_mac_pipeline_top_wrap_mquad1.U2_PIPE_XLGMII.reset = sync_i_reset[6];
//force physs0.parmisc_physs0.pcs_mac_pipeline_top_wrap_mquad1.U3_PIPE_XLGMII.reset = sync_i_reset[7];
//force physs1.parmisc_physs1.pcs_mac_pipeline_top_wrap_pquad0_0.U0_PIPE_XLGMII.reset = sync_i_reset[8];
//force physs0.parmisc_physs0.pcs_mac_pipeline_top_wrap_pquad0_1.U0_PIPE_XLGMII.reset = sync_i_reset[8];
//force physs1.parmisc_physs1.pcs_mac_pipeline_top_wrap_pquad0_0.U1_PIPE_XLGMII.reset = sync_i_reset[9];
//force physs0.parmisc_physs0.pcs_mac_pipeline_top_wrap_pquad0_1.U1_PIPE_XLGMII.reset = sync_i_reset[9];
//force physs1.parmisc_physs1.pcs_mac_pipeline_top_wrap_pquad0_0.U2_PIPE_XLGMII.reset = sync_i_reset[10];
//force physs0.parmisc_physs0.pcs_mac_pipeline_top_wrap_pquad0_1.U2_PIPE_XLGMII.reset = sync_i_reset[10];
//force physs1.parmisc_physs1.pcs_mac_pipeline_top_wrap_pquad0_0.U3_PIPE_XLGMII.reset = sync_i_reset[11];
//force physs0.parmisc_physs0.pcs_mac_pipeline_top_wrap_pquad0_1.U3_PIPE_XLGMII.reset = sync_i_reset[11];
//force physs1.parmisc_physs1.pcs_mac_pipeline_top_wrap_pquad1_0.U0_PIPE_XLGMII.reset = sync_i_reset[12];
//force physs0.parmisc_physs0.pcs_mac_pipeline_top_wrap_pquad1_1.U0_PIPE_XLGMII.reset = sync_i_reset[12];
//force physs1.parmisc_physs1.pcs_mac_pipeline_top_wrap_pquad1_0.U1_PIPE_XLGMII.reset = sync_i_reset[13];
//force physs0.parmisc_physs0.pcs_mac_pipeline_top_wrap_pquad1_1.U1_PIPE_XLGMII.reset = sync_i_reset[13];
//force physs1.parmisc_physs1.pcs_mac_pipeline_top_wrap_pquad1_0.U2_PIPE_XLGMII.reset = sync_i_reset[14];
//force physs0.parmisc_physs0.pcs_mac_pipeline_top_wrap_pquad1_1.U2_PIPE_XLGMII.reset = sync_i_reset[14];
//force physs1.parmisc_physs1.pcs_mac_pipeline_top_wrap_pquad1_0.U3_PIPE_XLGMII.reset = sync_i_reset[15];
//force physs0.parmisc_physs0.pcs_mac_pipeline_top_wrap_pquad1_1.U3_PIPE_XLGMII.reset = sync_i_reset[15];






















end
