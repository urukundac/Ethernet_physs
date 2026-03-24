//=================================================================================================================================
// SFI connections - USER MUST EDIT THE RIGHT HAND SIDE OF THE FOLLOWING ASSIGNMENTS AND DEFINE - WHEN THIS TRANSACTOR IS USED
//=================================================================================================================================
// SFI   connection #0


					//		`define 	SFI_0 									  i_cpm_top   // example:  fpga_tcss_top.tcss_val_rtl.tcss.par_iom    //HERE USER SHOULD SET THE PATH TO HIS SIDE OF THE SFI INTEFACE
						
assign 				  		`TRANSACTORS_PATH.sfi_clk[0] 						= prim_clk;// `SFI_0.cpm_clk;
assign 				  		`TRANSACTORS_PATH.rst_sfi_n[0] 						= ru_prim_rst_n;// `SFI_0.prim_rst_b;



//inputs to FGT
// CPM US = TX 
// CPM DS = RX


// CPM US => FGT RX 
//Global
assign                  	`TRANSACTORS_PATH.sfi_rx_txcon_req[0]     			= cpm_sfi_us_global_txcon_req;
//Header
assign                  	`TRANSACTORS_PATH.sfi_rx_hdr_valid[0]     			= cpm_sfi_us_hdr_hdr_valid;
assign                  	`TRANSACTORS_PATH.sfi_rx_hdr_early_valid[0]     	= cpm_sfi_us_hdr_hdr_early_valid;
assign                  	`TRANSACTORS_PATH.sfi_rx_header[0]     				= cpm_sfi_us_hdr_header;
assign                  	`TRANSACTORS_PATH.sfi_rx_hdr_info_bytes[0]     		= cpm_sfi_us_hdr_hdr_info_bytes;
assign                  	`TRANSACTORS_PATH.sfi_rx_hdr_crd_rtn_block[0]     	= cpm_sfi_us_hdr_hdr_crd_rtn_block;
//Data 
assign                  	`TRANSACTORS_PATH.sfi_rx_data_valid[0]     			= cpm_sfi_us_data_data_valid;
assign                  	`TRANSACTORS_PATH.sfi_rx_data_early_valid[0]     	= cpm_sfi_us_data_data_early_valid;
assign                  	`TRANSACTORS_PATH.sfi_rx_data[0]     				= cpm_sfi_us_data_data;
assign                  	`TRANSACTORS_PATH.sfi_rx_data_parity[0]     		= cpm_sfi_us_data_data_parity;
assign                  	`TRANSACTORS_PATH.sfi_rx_data_start[0]     			= cpm_sfi_us_data_data_start;
assign                  	`TRANSACTORS_PATH.sfi_rx_data_info_byte[0]     		= cpm_sfi_us_data_data_info_byte;
assign                  	`TRANSACTORS_PATH.sfi_rx_data_end[0]     			= cpm_sfi_us_data_data_end;
assign                  	`TRANSACTORS_PATH.sfi_rx_data_poison[0]     		= cpm_sfi_us_data_data_poison;
assign                  	`TRANSACTORS_PATH.sfi_rx_data_edb[0]     			= cpm_sfi_us_data_data_edb;
assign                  	`TRANSACTORS_PATH.sfi_rx_data_aux_parity[0]     	= cpm_sfi_us_data_data_aux_parity;
assign                  	`TRANSACTORS_PATH.sfi_rx_data_crd_rtn_block[0]     	= cpm_sfi_us_data_data_crd_rtn_block;

//CPM DS => FGT TX 
//Global
assign                  	`TRANSACTORS_PATH.sfi_tx_rxcon_ack[0]     			= cpm_sfi_ds_global_rxcon_ack;
assign                  	`TRANSACTORS_PATH.sfi_tx_rxdiscon_nack[0]   		= cpm_sfi_ds_global_rxdiscon_nack;
assign                  	`TRANSACTORS_PATH.sfi_tx_rx_empty[0]     			= cpm_sfi_ds_global_rx_empty;

//header
assign                  	`TRANSACTORS_PATH.sfi_tx_hdr_block[0]     			= cpm_sfi_ds_hdr_hdr_block;
assign                  	`TRANSACTORS_PATH.sfi_tx_hdr_crd_rtn_valid[0]     	= cpm_sfi_ds_hdr_hdr_crd_rtn_valid;
assign                  	`TRANSACTORS_PATH.sfi_tx_hdr_crd_rtn_ded[0]     	= cpm_sfi_ds_hdr_hdr_crd_rtn_ded;
assign                  	`TRANSACTORS_PATH.sfi_tx_hdr_crd_rtn_fc_id[0]     	= cpm_sfi_ds_hdr_hdr_crd_rtn_fc_id;
assign                  	`TRANSACTORS_PATH.sfi_tx_hdr_crd_rtn_vc_id[0]     	= cpm_sfi_ds_hdr_hdr_crd_rtn_vc_id;
assign                  	`TRANSACTORS_PATH.sfi_tx_hdr_crd_rtn_value[0]     	= cpm_sfi_ds_hdr_hdr_crd_rtn_value;

//Data
assign                  	`TRANSACTORS_PATH.sfi_tx_data_block[0]     			= cpm_sfi_ds_data_data_block;
assign                  	`TRANSACTORS_PATH.sfi_tx_data_crd_rtn_valid[0]		= cpm_sfi_ds_data_data_crd_rtn_valid;
assign                  	`TRANSACTORS_PATH.sfi_tx_data_crd_rtn_ded[0]		= cpm_sfi_ds_data_data_crd_rtn_ded;
assign                  	`TRANSACTORS_PATH.sfi_tx_data_crd_rtn_fc_id[0]     	= cpm_sfi_ds_data_data_crd_rtn_fc_id;
assign                  	`TRANSACTORS_PATH.sfi_tx_data_crd_rtn_vc_id[0]	    = cpm_sfi_ds_data_data_crd_rtn_vc_id;
assign                  	`TRANSACTORS_PATH.sfi_tx_data_crd_rtn_value[0]     	= cpm_sfi_ds_data_data_crd_rtn_value;

//=================================================================================================================================
// SFI connections - USER MUST EDIT THE LEFT HAND SIDE OF THE FOLLOWING ASSIGNMENTS  - WHEN THIS TRANSACTOR IS USED
//=================================================================================================================================


//outputs from FGT
// CPM US = TX 
// CPM DS = RX


// FGT RX => CPM US
//Global
assign  				 	cpm_sfi_us_global_rxcon_ack							=	`TRANSACTORS_PATH.sfi_rx_rxcon_ack[0]     	;
assign  				 	cpm_sfi_us_global_rxdiscon_nack						=	`TRANSACTORS_PATH.sfi_rx_rxdiscon_nack[0]     		;
assign  				 	cpm_sfi_us_global_rx_empty							=	`TRANSACTORS_PATH.sfi_rx_rx_empty[0]     		;

//Header
assign  				 	cpm_sfi_us_hdr_hdr_block							=	`TRANSACTORS_PATH.sfi_rx_hdr_block[0]     				;
assign  				 	cpm_sfi_us_hdr_hdr_crd_rtn_valid					=	`TRANSACTORS_PATH.sfi_rx_hdr_crd_rtn_valid[0]     				;
assign  				 	cpm_sfi_us_hdr_hdr_crd_rtn_ded						=	`TRANSACTORS_PATH.sfi_rx_hdr_crd_rtn_ded[0]     				;
assign  				 	cpm_sfi_us_hdr_hdr_crd_rtn_fc_id					=	`TRANSACTORS_PATH.sfi_rx_hdr_crd_rtn_fc_id[0]     		;
assign  				 	cpm_sfi_us_hdr_hdr_crd_rtn_vc_id					=	`TRANSACTORS_PATH.sfi_rx_hdr_crd_rtn_vc_id[0]     			;
assign						cpm_sfi_us_hdr_hdr_crd_rtn_value					=	`TRANSACTORS_PATH.sfi_rx_hdr_crd_rtn_value[0]				;

//data
assign  				 	cpm_sfi_us_data_data_block							=	`TRANSACTORS_PATH.sfi_rx_data_block[0]     			;
assign  				 	cpm_sfi_us_data_data_crd_rtn_valid					=	`TRANSACTORS_PATH.sfi_rx_data_crd_rtn_valid[0]     				;
assign  				 	cpm_sfi_us_data_data_crd_rtn_ded					=	`TRANSACTORS_PATH.sfi_rx_data_crd_rtn_ded[0]     			;
assign  				 	cpm_sfi_us_data_data_crd_rtn_fc_id					=	`TRANSACTORS_PATH.sfi_rx_data_crd_rtn_fc_id[0]     			;
assign  				 	cpm_sfi_us_data_data_crd_rtn_vc_id					=	`TRANSACTORS_PATH.sfi_rx_data_crd_rtn_vc_id[0]    		 	;
assign  				 	cpm_sfi_us_data_data_crd_rtn_value					=	`TRANSACTORS_PATH.sfi_rx_data_crd_rtn_value[0]     				;


// FGT TX => CPM DS
//Global
assign  				 	cpm_sfi_ds_global_txcon_req							=	`TRANSACTORS_PATH.sfi_tx_txcon_req[0]     		;

//Header
assign  				 	cpm_sfi_ds_hdr_hdr_valid							=	`TRANSACTORS_PATH.sfi_tx_hdr_valid[0]     		;
assign  				 	cpm_sfi_ds_hdr_hdr_early_valid						=	`TRANSACTORS_PATH.sfi_tx_hdr_early_valid[0]     			;
assign  				 	cpm_sfi_ds_hdr_header								=	`TRANSACTORS_PATH.sfi_tx_header[0]     			;
assign  				 	cpm_sfi_ds_hdr_hdr_info_bytes						=	`TRANSACTORS_PATH.sfi_tx_hdr_info_bytes[0]     				;
assign  				 	cpm_sfi_ds_hdr_hdr_crd_rtn_block					=	`TRANSACTORS_PATH.sfi_tx_hdr_crd_rtn_block[0]     				;

//data
assign  				 	cpm_sfi_ds_data_data_valid							=	`TRANSACTORS_PATH.sfi_tx_data_valid[0]     				;
assign  				 	cpm_sfi_ds_data_data_early_valid					=	`TRANSACTORS_PATH.sfi_tx_data_early_valid[0]     			;
assign  				 	cpm_sfi_ds_data_data								=	`TRANSACTORS_PATH.sfi_tx_data[0]     				;
assign  				 	cpm_sfi_ds_data_data_parity							=	`TRANSACTORS_PATH.sfi_tx_data_parity[0]   		 	 	;
assign  				 	cpm_sfi_ds_data_data_start							=	`TRANSACTORS_PATH.sfi_tx_data_start[0]     				;
assign  				 	cpm_sfi_ds_data_data_info_byte						=	`TRANSACTORS_PATH.sfi_tx_data_info_byte[0]     	;
assign  				 	cpm_sfi_ds_data_data_end							=	`TRANSACTORS_PATH.sfi_tx_data_end[0]     	;
assign  				 	cpm_sfi_ds_data_data_poison							=	`TRANSACTORS_PATH.sfi_tx_data_poison[0]     	;
assign  				 	cpm_sfi_ds_data_data_edb							=	`TRANSACTORS_PATH.sfi_tx_data_edb[0]     	;
assign  				 	cpm_sfi_ds_data_data_aux_parity						=	`TRANSACTORS_PATH.sfi_tx_data_aux_parity[0]     	;
assign  				 	cpm_sfi_ds_data_data_crd_rtn_block					=	`TRANSACTORS_PATH.sfi_tx_data_crd_rtn_block[0]     	;     	;

//=================================================================================================================================


	
