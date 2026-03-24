
//`include "transactors_include_files.sv"
`include "transactors_user_config.sv" 
`include "transactor_SFI_0_XMR.sv"

//instantiation with fpga_generic_chassis_top
fpga_transactors_top #(
      
      

           .ENABLE_ILA 							(0),
           .SAMPLE_AXI_FROM_CROSSBAR        	(0),
           .LOCAL_BUS_IS_28b					(LOCAL_BUS_IS_28b),
           .NUM_OF_DUMMY_TRANSACTOR 			(NUM_OF_DUMMY_TRANSACTOR), 
           .NUM_OF_CXL_CACHE_HOST  				(NUM_OF_CXL_CACHE_HOST),
           .NUM_OF_CXL_MEM_MASTER  				(NUM_OF_CXL_MEM_MASTER),
           .NUM_OF_CXL_CACHE_DEVICE  			(NUM_OF_CXL_CACHE_DEVICE),
           .NUM_OF_CXL_MEM_SLAVE  				(NUM_OF_CXL_MEM_SLAVE),
           .NUM_OF_CXL_G_FABRIC           (NUM_OF_CXL_G_FABRIC),
           .NUM_OF_CXL_G_AGENT            (NUM_OF_CXL_G_AGENT),
           .NUM_OF_DDI_TRANSACTOR       		(NUM_OF_DDI_TRANSACTOR),
           .NUM_OF_UFI_1_FABRIC			  		(NUM_OF_UFI_1_FABRIC),
           .NUM_OF_UFI_1_AGENT			  		(NUM_OF_UFI_1_AGENT),
           .NUM_OF_ICXL_HOST  					(NUM_OF_ICXL_HOST),
           .NUM_OF_ICXL_DEVICE			  		(NUM_OF_ICXL_DEVICE),
           .NUM_OF_SB_AGENT_TRANSACTOR			(NUM_OF_SB_AGENT_TRANSACTOR),
           .NUM_OF_SB_FABRIC_TRANSACTOR			(NUM_OF_SB_FABRIC_TRANSACTOR),
           .NUM_OF_TEMPLATE_TRANSACTOR			(NUM_OF_TEMPLATE_TRANSACTOR),
           .NUM_OF_AXIM_SLAVE_TRANSACTOR  		(NUM_OF_AXIM_SLAVE_TRANSACTOR), 
           .NUM_OF_AXIM_MASTER_TRANSACTOR 		(NUM_OF_AXIM_MASTER_TRANSACTOR),
           .NUM_OF_GPIO_TRANSACTOR   			(NUM_OF_GPIO_TRANSACTOR),
           .NUM_OF_AUX_TRANSACTOR   			(NUM_OF_AUX_TRANSACTOR),
           .NUM_OF_SFI_TRANSACTOR   			(NUM_OF_SFI_TRANSACTOR),           
           .NUM_OF_APB_MASTER_TRANSACTOR 		(NUM_OF_APB_MASTER_TRANSACTOR),
           .NUM_OF_APB_SLAVE_TRANSACTOR 		(NUM_OF_APB_SLAVE_TRANSACTOR),
           .NUM_OF_CFI_TRANSACTOR    			(NUM_OF_CFI_TRANSACTOR),
           .NUM_OF_DDR_BACKDOOR_TRANSACTOR  	(NUM_OF_DDR_BACKDOOR_TRANSACTOR),
           .NUM_OF_UFI_2_FABRIC			  		(NUM_OF_UFI_2_FABRIC),
           .NUM_OF_UFI_2_AGENT			  		(NUM_OF_UFI_2_AGENT),
           .NUM_OF_IOSF_P_TRANSACTOR    		(NUM_OF_IOSF_P_TRANSACTOR),
           .NUM_OF_ADDITIONAL_COMM_BLOCKS   	(NUM_OF_ADDITIONAL_COMM_BLOCKS),
           .NUM_OF_COMM_BLOCK_USED_FOR_DIRECT	(NUM_OF_COMM_BLOCK_USED_FOR_DIRECT),
           
           .SB_AGENT_MAXPLDBIT					({SB_AGENT_MAXPLDBIT_SRC_5,SB_AGENT_MAXPLDBIT_SRC_4,SB_AGENT_MAXPLDBIT_SRC_3,SB_AGENT_MAXPLDBIT_SRC_2,SB_AGENT_MAXPLDBIT_SRC_1,SB_AGENT_MAXPLDBIT_SRC_0}),
           .SB_FABRIC_MAXPLDBIT					({SB_FABRIC_MAXPLDBIT_SRC_5,SB_FABRIC_MAXPLDBIT_SRC_4,SB_FABRIC_MAXPLDBIT_SRC_3,SB_FABRIC_MAXPLDBIT_SRC_2,SB_FABRIC_MAXPLDBIT_SRC_1,SB_FABRIC_MAXPLDBIT_SRC_0}),
           .SB_AGENT_SUPPORT_HSB_AND_SSB		({SB_AGENT_SUPPORT_HSB_AND_SSB_5,SB_AGENT_SUPPORT_HSB_AND_SSB_4,SB_AGENT_SUPPORT_HSB_AND_SSB_3,SB_AGENT_SUPPORT_HSB_AND_SSB_2,SB_AGENT_SUPPORT_HSB_AND_SSB_1,SB_AGENT_SUPPORT_HSB_AND_SSB_0}),
           .SB_FABRIC_SUPPORT_HSB_AND_SSB		({SB_FABRIC_SUPPORT_HSB_AND_SSB_5,SB_FABRIC_SUPPORT_HSB_AND_SSB_4,SB_FABRIC_SUPPORT_HSB_AND_SSB_3,SB_FABRIC_SUPPORT_HSB_AND_SSB_2,SB_FABRIC_SUPPORT_HSB_AND_SSB_1,SB_FABRIC_SUPPORT_HSB_AND_SSB_0}),
           .SFI_D								({SFI_D_SRC_5,SFI_D_SRC_4,SFI_D_SRC_3,SFI_D_SRC_2,SFI_D_SRC_1,SFI_D_SRC_0}),
           
           .UFI_2_LOOPBACK             			(UFI_2_LOOPBACK),

           .TEMPLATE_INPUT_PORT_WIDTH			({TEMPLATE_INPUT_PORT_WIDTH_SRC_5,TEMPLATE_INPUT_PORT_WIDTH_SRC_4,TEMPLATE_INPUT_PORT_WIDTH_SRC_3,TEMPLATE_INPUT_PORT_WIDTH_SRC_2,TEMPLATE_INPUT_PORT_WIDTH_SRC_1,TEMPLATE_INPUT_PORT_WIDTH_SRC_0}),
           .TEMPLATE_OUTPUT_PORT_WIDTH			({TEMPLATE_OUTPUT_PORT_WIDTH_SRC_5,TEMPLATE_OUTPUT_PORT_WIDTH_SRC_4,TEMPLATE_OUTPUT_PORT_WIDTH_SRC_3,TEMPLATE_OUTPUT_PORT_WIDTH_SRC_2,TEMPLATE_OUTPUT_PORT_WIDTH_SRC_1,TEMPLATE_OUTPUT_PORT_WIDTH_SRC_0}),
            
           .GPIO_LOOPBACK						(GPIO_LOOPBACK),
           .NUM_OF_GPIO_IN						(NUM_OF_GPIO_IN),
           .NUM_OF_GPIO_OUT						(NUM_OF_GPIO_OUT),
           .DDI_GENERATOR           			(DDI_GENERATOR),
           .DDI_NUM_EMBEDDED_PORTS  			(DDI_NUM_EMBEDDED_PORTS),
           .DDI_NUM_LANES           			(DDI_NUM_LANES),

           .RESET_VALUE_GPIO					(RESET_VALUE_GPIO),
           .SFI_LOOPBACK						(SFI_LOOPBACK),
           .AXIM_LOOPBACK						(AXIM_LOOPBACK),
           .AXIM_MASTER_ADDR_COMMAND_WIDTH		(AXIM_MASTER_ADDR_COMMAND_WIDTH),
           .AXIM_SLAVE_ADDR_COMMAND_WIDTH		(AXIM_SLAVE_ADDR_COMMAND_WIDTH),
           .AXI_MASTER_DATA_WIDTH				(AXI_MASTER_DATA_WIDTH),
           .AXI_SLAVE_DATA_WIDTH				(AXI_SLAVE_DATA_WIDTH),
           .MISORDER_TEST                 		(MISORDER_TEST),
           
           .UFI_1_NUM_OF_CREDIT_CH				(UFI_1_NUM_OF_CREDIT_CH),
           .UFI_1_CREDIT_ID						(UFI_1_CREDIT_ID),
           .UFI_2_NUM_OF_CREDIT_CH				(UFI_2_NUM_OF_CREDIT_CH),
           .UFI_2_CREDIT_ID						(UFI_2_CREDIT_ID),
           .APB_LOOPBACK						(APB_LOOPBACK),
       
           .CXL_G_MAX_CREDITS(CXL_G_MAX_CREDITS),
        //   .CFI_NUM_OF_CREDIT_CH			(CFI_NUM_OF_CREDIT_CH),
        //   .CFI_CREDIT_ID					(CFI_CREDIT_ID),
           .CFI_LOOPBACK          				(CFI_LOOPBACK), 
           .IOSF_P_LOOPBACK       				(IOSF_P_LOOPBACK),
           .IOSF_FIP_IS_FABRIC    				(IOSF_FIP_IS_FABRIC), 
           //these paramter are used in the communication block,
           //each of the numbers goes to a communication block by it's order
           //the range is from 0 and up to 16 fifos in a level of fifos
           //for zero fifos enter 4'b0, for 16 fifo
           .NUM_OF_TX_FIFO  					(NUM_OF_TX_FIFO),
           .NUM_OF_RX_FIFO 						(NUM_OF_RX_FIFO),
           .CFI_AGENT_MODE          			(CFI_AGENT_MODE),
           .CFI_EARLY_DELAY         			(CFI_EARLY_DELAY),
           `ifdef PCIE_BRIDGE
           .PCIE_BRIDGE_PHY_TYPE      (PCIE_BRIDGE_PHY_TYPE),
           `endif
           `include "IOSF_P_param_inst.sv"
                                     )
fpga_transactors_top_inst  
(
  `ifndef PCIE_BRIDGE
	`ifndef ALTERA_BOARD
	`ifdef VIRTEX7
	// GPIOlink interface
	.haps_gpioLink_in, // Serial input signal from the GPIOLINK_IN pad of the FPGA
	.haps_gpioLink_out, // Serial output signal to the GPIOLINK_OUT pad of the FPGA
	// System HAPS CAR
	.haps_gpioLink_clock, //100MHz
	.haps_gpioLink_reset_n, // Board reset used for GPIOLINK module
	`else
	.haps80_mgb2_6_PERST		(haps80_mgb2_6_PERST),
	.haps80_mgb2_8_WAKE_N		(haps80_mgb2_8_WAKE_N),
	.haps80_mgb2_9_PRSNT_n		(haps80_mgb2_9_PRSNT_n),
	`endif //VIRTEX7
   `else
    .altera_sys_rst_n(altera_sys_rst_n),
    .pcie_perst(altera_SWITCHED_PERST_N),
    .pcie_npor(altera_PCIE_CPWRON), 
   `endif//ALTERA_BOARD
   `else
     `ifdef USE_ALTERA_PCIE_BRIDGE
           .altera_sys_rst_n(~perst),//sys_rst_n),
           .pcie_perst(perst),
           .pcie_npor(pwron_n),    
       `else  
         	.haps80_mgb2_6_PERST		(haps80_mgb2_6_PERST),
	        .haps80_mgb2_8_WAKE_N		(haps80_mgb2_8_WAKE_N),
         	.haps80_mgb2_9_PRSNT_n		(haps80_mgb2_9_PRSNT_n),      
     `endif//USE_ALTERA_PCIE_BRIDGE
  `endif //PCIE_BRIDGE




     `ifdef AUX_TRANSACTOR
    // .diff_p(diff_p),
     //.diff_n(diff_n),
    .aux_tx_data(aux_tx_data),
                
   .aux_tx_en(aux_tx_en),   
   .aux_rx_data(aux_rx_data),
     `endif
      `ifdef FGC_CDC 
	 	.fgc_clk(clk_20m),
      `endif 
     `ifdef F2F_BRIDGE
     .fgt_rst_n        (f2f_rst_n),
      `endif
    .pci_exp_txp     	(pci_exp_txp),
    .pci_exp_txn     	(pci_exp_txn),
    .pci_exp_rxp     	(pci_exp_rxp),
    .pci_exp_rxn     	(pci_exp_rxn),
  
	.PCIE_REFCLK_P   	(pcie_ref_clk_p),
	.PCIE_REFCLK_N   	(pcie_ref_clk_n)
    
  	
);
