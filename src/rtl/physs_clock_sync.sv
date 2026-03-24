//-------------------------------------------------------------------------------------------------------
//  INTEL CONFIDENTIAL
//
//  Copyright 2017 Intel Corporation All Rights Reserved.
//
//  The source code contained or described herein and all documents related
//  to the source code ("Material") are owned by Intel Corporation or its
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
//
//-----------------------------------------------------------------------------------------------------
//  Filename:
//  clock_reset_quad    
//
//  Date:       
//
//  Author:      
//
//  Description:
// Custom Clock Reset Clock Block for Ethernet x2  
//
//  History:
//    
//-------------------------------------------------------------

module physs_clock_sync(

  input logic physs_func_rst_raw_n,  
  input logic [3:0] pcs_external_loopback_en,
  input logic hip_rst_n,  
  input logic [3:0] xmp_reset_sd_tx_clk,
  input logic [3:0] xmp_reset_sd_rx_clk,
  input logic xmp_reset_sd_tx_clk_400G,
  input logic xmp_reset_sd_rx_clk_400G,
  input logic xmp_reset_sd_tx_clk_200G,
  input logic xmp_reset_sd_rx_clk_200G,
  input logic [3:0] reset_sd_tx_clk_ovveride,
  input logic [3:0] reset_sd_rx_clk_ovveride,
  input logic reset_ref_clk_ovveride,
  input logic [3:0] reset_time_clk_ovveride,
  input logic [1:0] reset_xpcs_ref_clk_ovveride,
  input logic [1:0] reset_f91_ref_clk_ovveride,
  input logic reset_gpcs0_ref_clk_ovveride,
  input logic reset_gpcs1_ref_clk_ovveride,
  input logic reset_gpcs2_ref_clk_ovveride,
  input logic reset_gpcs3_ref_clk_ovveride,
  input logic reset_reg_clk_ovveride,
  input logic reset_reg_ref_clk_ovveride ,
  input logic reset_cdmii_rxclk_ovveride_200G,
  input logic reset_cdmii_txclk_ovveride_200G,
  input logic reset_sd_tx_clk_ovveride_200G,
  input logic reset_sd_rx_clk_ovveride_200G,
  input logic reset_reg_clk_ovveride_200G,
  input logic reset_reg_ref_clk_ovveride_200G,
  input logic reset_cdmii_rxclk_ovveride_400G,
  input logic reset_cdmii_txclk_ovveride_400G,
  input logic reset_sd_tx_clk_ovveride_400G,
  input logic reset_sd_rx_clk_ovveride_400G,
  input logic reset_reg_clk_ovveride_400G,
  input logic reset_reg_ref_clk_ovveride_400G,
  input logic [5:0] reset_reg_clk_ovveride_mac,
  input logic [5:0] reset_ff_tx_clk_ovveride,
  input logic [5:0] reset_ff_rx_clk_ovveride,
  input logic [5:0] reset_txclk_ovveride,
  input logic [5:0] reset_rxclk_ovveride,
  input logic i_rst_apb_b_a_ovveride,
  input logic i_rst_ucss_por_b_a_ovveride,
  input logic i_rst_pma0_por_b_a_ovveride,
  input logic i_rst_pma1_por_b_a_ovveride,
  input logic i_rst_pma2_por_b_a_ovveride,
  input logic i_rst_pma3_por_b_a_ovveride,
  input  logic physs_dfx_fscan_clkungate,
  input logic [1:0] pcs_lane_sel,
  output logic [3:0] reset_sd_tx_clk,
  output logic [3:0] reset_sd_rx_clk,
  output logic reset_ref_clk,
  output logic reset_ref_clk_inv,
  output logic [1:0] reset_xpcs_ref_clk,
  output logic [1:0] reset_f91_ref_clk,
  output logic reset_gpcs0_ref_clk,
  output logic reset_gpcs1_ref_clk,
  output logic reset_gpcs2_ref_clk,
  output logic reset_gpcs3_ref_clk,
  output logic reset_reg_clk,
  output logic reset_reg_clk_inv,
  output logic reset_reg_ref_clk,
  output logic [5:0] reset_reg_clk_mac,
  output logic [5:0] reset_ff_tx_clk,
  output logic [5:0] reset_ff_rx_clk,
  output logic [5:0] reset_txclk,
  output logic [5:0] reset_rxclk,
  output logic rst_apb_b_a,
  output logic rst_ucss_por_b_a,
  output logic rst_pma0_por_b_a,
  output logic rst_pma1_por_b_a,
  output logic rst_pma2_por_b_a,
  output logic rst_pma3_por_b_a,
  output logic reset_cdmii_rxclk_200G,
  output logic reset_cdmii_txclk_200G,
  output logic reset_sd_tx_clk_200G,
  output logic reset_sd_rx_clk_200G,
  output logic reset_reg_clk_200G,
  output logic reset_reg_ref_clk_200G,
  output logic reset_cdmii_rxclk_400G,
  output logic reset_cdmii_txclk_400G,
  output logic reset_sd_tx_clk_400G,
  output logic reset_sd_rx_clk_400G,
  output logic reset_reg_clk_400G,
  output logic reset_reg_ref_clk_400G,
  input  logic physs_func_clk,
  input  logic soc_per_clk,
  input  logic soc_per_clk_divby2,
  input  logic time_clk,
  input  logic [3:0] serdes_tx_clk,
  input  logic [3:0] serdes_rx_clk,
  output logic [3:0] reset_time_clk_n,
  output logic physs_func_clk_gated_100,
  output logic physs_func_clk_gated_200,
  output logic physs_func_clk_gated_400,
  output logic soc_per_clk_gated_100,
  output logic soc_per_clk_gated_200,
  output logic soc_per_clk_gated_400,
  output logic time_clk_gated_100,
  output logic time_clk_gated_200,
  output logic time_clk_gated_400,
  output logic physs_ptpmem_wr_clk0,
  output logic physs_ptpmem_wr_clk2,
  output logic physs_ptpmem_rd_clk0,
  output logic physs_ptpmem_rd_clk2,
  input logic power_fsm_clk_gate_en,
  input logic power_fsm_reset_gate_en,
  input logic clk_gate_en_100G_mac_pcs,
  input logic clk_gate_en_200G_mac_pcs,
  input logic clk_gate_en_400G_mac_pcs,
  output logic func_rstn_fabric_sync,
  output logic hip_rstn_fabric_sync,
  output logic clk_rst_gate_en_100G,
  input logic reset_pcs100_ovveride_en,
  input logic reset_pcs200_ovveride_en,
  input logic reset_pcs400_ovveride_en,
  input logic reset_mac100_ovveride_en,
  input logic reset_mac200_ovveride_en,
  input logic reset_mac400_ovveride_en,
  input logic reset_xmp_ovveride_en,
  input logic fscan_rstbypen,
  input logic fscan_byprst_b


);

parameter LANES = 4;

logic clk_gate_en_100G_mac_pcs_sync_func_clk;
logic clk_gate_en_200G_mac_pcs_sync_func_clk;
logic clk_gate_en_400G_mac_pcs_sync_func_clk;

logic clk_gate_en;
logic physs_func_rst_raw_gated_n;

assign clk_gate_en_100G = clk_gate_en_100G_mac_pcs ? 1'b0  : ~power_fsm_clk_gate_en;
assign physs_func_rst_raw_gated_n  = (~physs_func_rst_raw_n |  power_fsm_reset_gate_en);
assign clk_rst_gate_en_100G = clk_gate_en_100G | physs_func_rst_raw_gated_n; 


    ctech_lib_doublesync_rstb syc_clkgate100 (
       	.clk  (physs_func_clk), 
       	.rstb (physs_func_rst_raw_n), 
       	.d    (clk_gate_en_100G), 
       	.o    (clk_gate_en_100G_mac_pcs_sync_func_clk)
       	);

    ctech_lib_doublesync_rstb sync_clkgate200 (
       	.clk  (physs_func_clk), 
       	.rstb (physs_func_rst_raw_n), 
       	.d    (clk_gate_en_200G_mac_pcs), 
       	.o    (clk_gate_en_200G_mac_pcs_sync_func_clk)
       	);

    ctech_lib_doublesync_rstb sync_clkgate400 (
       	.clk  (physs_func_clk), 
       	.rstb (physs_func_rst_raw_n), 
       	.d    (clk_gate_en_400G_mac_pcs), 
       	.o    (clk_gate_en_400G_mac_pcs_sync_func_clk)
       	);


     ctech_lib_clk_gate_te clk_gate_refclk_100 (
     .clkout(physs_func_clk_gated_100),
     .en(clk_gate_en_100G_mac_pcs_sync_func_clk),
     .te(physs_dfx_fscan_clkungate),
     .clk(physs_func_clk)
    );
   
     ctech_lib_clk_gate_te clk_gate_refclk_200 (
     .clkout(physs_func_clk_gated_200),
     .en(clk_gate_en_200G_mac_pcs_sync_func_clk),
     .te(physs_dfx_fscan_clkungate),
     .clk(physs_func_clk)
    );

     ctech_lib_clk_gate_te clk_gate_refclk_400 (
     .clkout(physs_func_clk_gated_400),
     .en(clk_gate_en_400G_mac_pcs_sync_func_clk),
     .te(physs_dfx_fscan_clkungate),
     .clk(physs_func_clk)
    );

     ctech_lib_clk_gate_te clk_gate_reg_clk100 (
     .clkout(soc_per_clk_gated_100),
     .en(clk_gate_en_100G),
     .te(physs_dfx_fscan_clkungate),
     .clk(soc_per_clk)
    );
    
     ctech_lib_clk_gate_te clk_gate_reg_clk200 (
     .clkout(soc_per_clk_gated_200),
     .en(clk_gate_en_200G_mac_pcs),
     .te(physs_dfx_fscan_clkungate),
     .clk(soc_per_clk)
    );

     ctech_lib_clk_gate_te clk_gate_reg_clk400 (
     .clkout(soc_per_clk_gated_400),
     .en(clk_gate_en_400G_mac_pcs),
     .te(physs_dfx_fscan_clkungate),
     .clk(soc_per_clk)
    );
    
     ctech_lib_clk_gate_te clk_gate_timeclk_100 (
     .clkout(time_clk_gated_100),
     .en(clk_gate_en_100G),
     .te(physs_dfx_fscan_clkungate),
     .clk(time_clk)
    );
   
     ctech_lib_clk_gate_te clk_gate_timeclk_200 (
     .clkout(time_clk_gated_200),
     .en(clk_gate_en_200G_mac_pcs),
     .te(physs_dfx_fscan_clkungate),
     .clk(time_clk)
    );

     ctech_lib_clk_gate_te clk_gate_timeclk_400 (
     .clkout(time_clk_gated_400),
     .en(clk_gate_en_400G_mac_pcs),
     .te(physs_dfx_fscan_clkungate),
     .clk(time_clk)
    );

// clk mux for ptptx mem


logic physs_func_clk_gated_400_200;
logic physs_func_clk_gated_0_400;
logic soc_per_clk_gated_400_200;
logic soc_per_clk_gated_0_400;


ctech_lib_clk_mux_2to1 ptp_wr0_clk_mux0 (
        .clk2(physs_func_clk_gated_400),
        .clk1(physs_func_clk_gated_200),
        .s(pcs_lane_sel[0]),
        .clkout(physs_func_clk_gated_400_200)
        );


ctech_lib_clk_mux_2to1 ptp_wr0_clk_mux1 (
        .clk2(physs_func_clk_gated_100),
        .clk1(physs_func_clk_gated_400_200),
        .s(pcs_lane_sel[1]),
        .clkout(physs_ptpmem_wr_clk0)
        );


ctech_lib_clk_mux_2to1 ptp_wr2_clk_mux0 (
        .clk2(1'b0),
        .clk1(physs_func_clk_gated_400),
        .s(pcs_lane_sel[0]),
        .clkout(physs_func_clk_gated_0_400)
        );


ctech_lib_clk_mux_2to1 ptp_wr2_clk_mux1 (
        .clk2(physs_func_clk_gated_100),
        .clk1(physs_func_clk_gated_0_400),
        .s(pcs_lane_sel[1]),
        .clkout(physs_ptpmem_wr_clk2)
        );



ctech_lib_clk_mux_2to1 ptp_rd0_clk_mux0 (
        .clk2(soc_per_clk_gated_400),
        .clk1(soc_per_clk_gated_200),
        .s(pcs_lane_sel[0]),
        .clkout(soc_per_clk_gated_400_200)
        );


ctech_lib_clk_mux_2to1 ptp_rd0_clk_mux1 (
        .clk2(soc_per_clk_gated_100),
        .clk1(soc_per_clk_gated_400_200),
        .s(pcs_lane_sel[1]),
        .clkout(physs_ptpmem_rd_clk0)
        );


ctech_lib_clk_mux_2to1 ptp_rd2_clk_mux0 (
        .clk2(1'b0),
        .clk1(soc_per_clk_gated_400),
        .s(pcs_lane_sel[0]),
        .clkout(soc_per_clk_gated_0_400)
        );


ctech_lib_clk_mux_2to1 ptp_rd2_clk_mux1 (
        .clk2(soc_per_clk_gated_100),
        .clk1(soc_per_clk_gated_0_400),
        .s(pcs_lane_sel[1]),
        .clkout(physs_ptpmem_rd_clk2)
        );


    // Rst ovveride 


logic [3:0] reset_sd_tx_clk_int;
logic [3:0] reset_sd_tx_clk_int_temp;
logic [3:0] reset_sd_tx_clk_inv;
logic [3:0] reset_sd_rx_clk_int;
logic [3:0] reset_sd_rx_clk_int_temp;
logic [3:0] reset_sd_rx_clk_inv;
logic [1:0] reset_xpcs_ref_clk_int;
logic [1:0] reset_xpcs_ref_clk_int_temp;
logic [1:0] reset_xpcs_ref_clk_inv;
logic [1:0] reset_f91_ref_clk_int;
logic [1:0] reset_f91_ref_clk_int_temp;
logic [1:0] reset_f91_ref_clk_inv;
logic reset_reg_clk_int;
logic reset_reg_clk_int_temp;
logic reset_reg_ref_clk_int;
logic reset_reg_ref_clk_int_temp;
logic reset_reg_ref_clk_inv;
logic [5:0] reset_reg_clk_mac_int;
logic [5:0] reset_reg_clk_mac_int_temp;
logic [5:0] reset_reg_clk_mac_inv;
logic [5:0] reset_ff_tx_clk_int;
logic [5:0] reset_ff_tx_clk_int_temp;
logic [5:0] reset_ff_tx_clk_inv;
logic [5:0] reset_ff_rx_clk_int;
logic [5:0] reset_ff_rx_clk_int_temp;
logic [5:0] reset_ff_rx_clk_inv;
logic [5:0] reset_txclk_int;
logic [5:0] reset_txclk_int_temp;
logic [5:0] reset_txclk_inv;
logic [5:0] reset_rxclk_int;
logic [5:0] reset_rxclk_int_temp;
logic [5:0] reset_rxclk_inv;

logic reset_gpcs0_ref_clk_int;
logic reset_gpcs0_ref_clk_int_temp;
logic reset_gpcs0_ref_clk_inv;
logic reset_gpcs1_ref_clk_int;
logic reset_gpcs1_ref_clk_int_temp;
logic reset_gpcs1_ref_clk_inv;
logic reset_gpcs2_ref_clk_int;
logic reset_gpcs2_ref_clk_int_temp;
logic reset_gpcs2_ref_clk_inv;
logic reset_gpcs3_ref_clk_int;
logic reset_gpcs3_ref_clk_int_temp;
logic reset_gpcs3_ref_clk_inv;


logic reset_cdmii_rxclk_200G_int;
logic reset_cdmii_txclk_200G_int;
logic reset_sd_tx_clk_200G_int;
logic reset_sd_rx_clk_200G_int;
logic reset_reg_clk_200G_int;
logic reset_reg_ref_clk_200G_int;
logic reset_cdmii_rxclk_400G_int;
logic reset_cdmii_txclk_400G_int;
logic reset_sd_tx_clk_400G_int;
logic reset_sd_rx_clk_400G_int;
logic reset_reg_clk_400G_int;
logic reset_reg_ref_clk_400G_int;
logic reset_cdmii_rxclk_200G_int_temp;
logic reset_cdmii_txclk_200G_int_temp;
logic reset_sd_tx_clk_200G_int_temp;
logic reset_sd_rx_clk_200G_int_temp;
logic reset_reg_clk_200G_int_temp;
logic reset_reg_ref_clk_200G_int_temp;
logic reset_cdmii_rxclk_400G_int_temp;
logic reset_cdmii_txclk_400G_int_temp;
logic reset_sd_tx_clk_400G_int_temp;
logic reset_sd_rx_clk_400G_int_temp;
logic reset_reg_clk_400G_int_temp;
logic reset_reg_ref_clk_400G_int_temp;
logic reset_cdmii_rxclk_200G_inv;
logic reset_cdmii_txclk_200G_inv;
logic reset_sd_tx_clk_200G_inv;
logic reset_sd_rx_clk_200G_inv;
logic reset_reg_clk_200G_inv;
logic reset_reg_ref_clk_200G_inv;
logic reset_cdmii_rxclk_400G_inv;
logic reset_cdmii_txclk_400G_inv;
logic reset_sd_tx_clk_400G_inv;
logic reset_sd_rx_clk_400G_inv;
logic reset_reg_clk_400G_inv;
logic reset_reg_ref_clk_400G_inv;

logic [3:0] reset_time_clk_int;
logic [3:0] reset_time_clk_int_temp;
logic [3:0] reset_time_clk_inv;

logic reset_ref_clk_int;
logic reset_ref_clk_int_temp;

genvar i;
generate

        for ( i=0; i < (LANES); i++) begin : reset_sync_pcs_sd
        
		
		assign reset_sd_tx_clk_int[i] = reset_pcs100_ovveride_en ? reset_sd_tx_clk_ovveride[i] : xmp_reset_sd_tx_clk[i];
		
  		assign reset_sd_tx_clk_int_temp[i]  = fscan_rstbypen ? ~fscan_byprst_b : reset_sd_tx_clk_int[i];
   
        	ctech_lib_doublesync_rst sd_tx_rst (
            		.clk     (serdes_tx_clk[i]), 
            		.rst (reset_sd_tx_clk_int_temp[i]), 
            		.d      (1'b1), 
            		.o    (reset_sd_tx_clk_inv[i])
        		);
    
		 assign reset_sd_tx_clk[i] =  ~reset_sd_tx_clk_inv[i];   

		
		assign reset_sd_rx_clk_int[i] = reset_pcs100_ovveride_en ? reset_sd_rx_clk_ovveride[i] : xmp_reset_sd_rx_clk[i];
       
  		assign reset_sd_rx_clk_int_temp[i]  = fscan_rstbypen ? ~fscan_byprst_b : reset_sd_rx_clk_int[i];
   
        	ctech_lib_doublesync_rst sd_rx_rst (
            		.clk     (serdes_rx_clk[i]), 
            		.rst (reset_sd_rx_clk_int_temp[i]), 
            		.d      (1'b1), 
            		.o    (reset_sd_rx_clk_inv[i])
        		);
    
		 //assign reset_sd_rx_clk[i] =  fscan_rstbypen ? ~fscan_byprst_b :  pcs_external_loopback_en[i] ? reset_sd_tx_clk[i] : ~reset_sd_rx_clk_inv[i];
		 //Pragya
		 assign reset_sd_rx_clk[i] = fscan_rstbypen ? ~fscan_byprst_b : reset_sd_tx_clk[i];

     end //reset_sync_pcs_sd
	
//reset pcs 400     
       
		assign reset_sd_tx_clk_400G_int = reset_pcs400_ovveride_en ? reset_sd_tx_clk_ovveride_400G : xmp_reset_sd_tx_clk_400G;
  		
		assign reset_sd_tx_clk_400G_int_temp  = fscan_rstbypen ? ~fscan_byprst_b : reset_sd_tx_clk_400G_int;
   
        	ctech_lib_doublesync_rst sd_tx_rst_400 (
            		.clk     (serdes_tx_clk[0]), 
            		.rst (reset_sd_tx_clk_400G_int_temp), 
            		.d      (1'b1), 
            		.o    (reset_sd_tx_clk_400G_inv)
        		);
    
		 assign reset_sd_tx_clk_400G =  ~reset_sd_tx_clk_400G_inv;   

       
		assign reset_sd_rx_clk_400G_int = reset_pcs400_ovveride_en ? reset_sd_rx_clk_ovveride_400G : xmp_reset_sd_rx_clk_400G;
  		
		assign reset_sd_rx_clk_400G_int_temp  = fscan_rstbypen ? ~fscan_byprst_b : reset_sd_rx_clk_400G_int;
   
        	ctech_lib_doublesync_rst sd_rx_rst_400 (
            		.clk     (serdes_rx_clk[0]), 
            		.rst (reset_sd_rx_clk_400G_int_temp), 
            		.d      (1'b1), 
            		.o    (reset_sd_rx_clk_400G_inv)
        		);
    
		 assign reset_sd_rx_clk_400G =  fscan_rstbypen ? ~fscan_byprst_b :  pcs_external_loopback_en[0] ? reset_sd_tx_clk_400G : ~reset_sd_rx_clk_400G_inv;   

//rst pcs 200
//
		assign reset_sd_tx_clk_200G_int = reset_pcs200_ovveride_en ? reset_sd_tx_clk_ovveride_200G : xmp_reset_sd_tx_clk_200G;
  		
		assign reset_sd_tx_clk_200G_int_temp  = fscan_rstbypen ? ~fscan_byprst_b : reset_sd_tx_clk_200G_int;
   
        	ctech_lib_doublesync_rst sd_tx_rst_200 (
            		.clk     (serdes_tx_clk[0]), 
            		.rst (reset_sd_tx_clk_200G_int_temp), 
            		.d      (1'b1), 
            		.o    (reset_sd_tx_clk_200G_inv)
        		);
    
		 assign reset_sd_tx_clk_200G =  ~reset_sd_tx_clk_200G_inv;   

       
		assign reset_sd_rx_clk_200G_int = reset_pcs200_ovveride_en ? reset_sd_rx_clk_ovveride_200G : xmp_reset_sd_rx_clk_200G;
  		
		assign reset_sd_rx_clk_200G_int_temp  = fscan_rstbypen ? ~fscan_byprst_b : reset_sd_rx_clk_200G_int;
   
        	ctech_lib_doublesync_rst sd_rx_rst_200 (
            		.clk     (serdes_rx_clk[0]), 
            		.rst (reset_sd_rx_clk_200G_int_temp), 
            		.d      (1'b1), 
            		.o    (reset_sd_rx_clk_200G_inv)
        		);
    
		 assign reset_sd_rx_clk_200G =  fscan_rstbypen ? ~fscan_byprst_b :  pcs_external_loopback_en[0] ? reset_sd_tx_clk_200G : ~reset_sd_rx_clk_200G_inv;   


        for ( i=0; i < LANES; i++) begin : reset_sync_mac100
	
		
		assign reset_reg_clk_mac_int[i] = reset_mac100_ovveride_en ? reset_reg_clk_ovveride_mac[i] : physs_func_rst_raw_gated_n; 
  		assign reset_reg_clk_mac_int_temp[i]  = fscan_rstbypen ? ~fscan_byprst_b : reset_reg_clk_mac_int[i];
   
        	ctech_lib_doublesync_rst mac_reg_rst (
            		.clk     (soc_per_clk_gated_100), 
            		.rst (reset_reg_clk_mac_int_temp[i]), 
            		.d      (1'b1), 
            		.o    (reset_reg_clk_mac_inv[i])
        		);
    
		 assign reset_reg_clk_mac[i] =  ~reset_reg_clk_mac_inv[i];   


		assign reset_ff_tx_clk_int[i] = reset_mac100_ovveride_en ? reset_ff_tx_clk_ovveride[i] : physs_func_rst_raw_gated_n; 
  		assign reset_ff_tx_clk_int_temp[i]  = fscan_rstbypen ? ~fscan_byprst_b : reset_ff_tx_clk_int[i];
   
        	ctech_lib_doublesync_rst mac_ff_tx (
            		.clk     (physs_func_clk_gated_100), 
            		.rst (reset_ff_tx_clk_int_temp[i]), 
            		.d      (1'b1), 
            		.o    (reset_ff_tx_clk_inv[i])
        		);
    
		 assign reset_ff_tx_clk[i] =  ~reset_ff_tx_clk_inv[i];   

       
		assign reset_ff_rx_clk_int[i] = reset_mac100_ovveride_en ? reset_ff_rx_clk_ovveride[i] : physs_func_rst_raw_gated_n; 
  		assign reset_ff_rx_clk_int_temp[i]  = fscan_rstbypen ? ~fscan_byprst_b : reset_ff_rx_clk_int[i];
   
        	ctech_lib_doublesync_rst mac_ff_rx (
            		.clk     (physs_func_clk_gated_100), 
            		.rst (reset_ff_rx_clk_int_temp[i]), 
            		.d      (1'b1), 
            		.o    (reset_ff_rx_clk_inv[i])
        		);
    
		 assign reset_ff_rx_clk[i] =  ~reset_ff_rx_clk_inv[i];   

       
		assign reset_txclk_int[i] = reset_mac100_ovveride_en ? reset_txclk_ovveride[i] : physs_func_rst_raw_gated_n; 
  		assign reset_txclk_int_temp[i]  = fscan_rstbypen ? ~fscan_byprst_b : reset_txclk_int[i];
   
        	ctech_lib_doublesync_rst mac_txclk (
            		.clk     (physs_func_clk_gated_100), 
            		.rst  (reset_txclk_int_temp[i]), 
            		.d      (1'b1), 
            		.o    (reset_txclk_inv[i])
        		);
    
		 assign reset_txclk[i] =  ~reset_txclk_inv[i];   

       
		assign reset_rxclk_int[i] = reset_mac100_ovveride_en ? reset_rxclk_ovveride[i] : physs_func_rst_raw_gated_n; 
  		assign reset_rxclk_int_temp[i]  = fscan_rstbypen ? ~fscan_byprst_b : reset_rxclk_int[i];
   
        	ctech_lib_doublesync_rst mac_rxclk (
            		.clk     (physs_func_clk_gated_100), 
            		.rst  (reset_rxclk_int_temp[i]), 
            		.d      (1'b1), 
            		.o    (reset_rxclk_inv[i])
        		);
    
		 assign reset_rxclk[i] =  ~reset_rxclk_inv[i];   

	end//reset_sync_mac100


        for ( i=4; i < 5; i++) begin : reset_sync_mac200
	
       
		assign reset_reg_clk_mac_int[i] = reset_mac200_ovveride_en ? reset_reg_clk_ovveride_mac[i] : physs_func_rst_raw_gated_n; 
  		assign reset_reg_clk_mac_int_temp[i]  = fscan_rstbypen ? ~fscan_byprst_b : reset_reg_clk_mac_int[i];
   
        	ctech_lib_doublesync_rst mac_reg_rst (
            		.clk     (soc_per_clk_gated_200), 
            		.rst (reset_reg_clk_mac_int_temp[i]), 
            		.d      (1'b1), 
            		.o    (reset_reg_clk_mac_inv[i])
        		);
    
		 assign reset_reg_clk_mac[i] =  ~reset_reg_clk_mac_inv[i];   


       
		assign reset_ff_tx_clk_int[i] = reset_mac200_ovveride_en ? reset_ff_tx_clk_ovveride[i] : physs_func_rst_raw_gated_n; 
  		assign reset_ff_tx_clk_int_temp[i]  = fscan_rstbypen ? ~fscan_byprst_b : reset_ff_tx_clk_int[i];
   
        	ctech_lib_doublesync_rst mac_ff_tx (
            		.clk     (physs_func_clk_gated_200), 
            		.rst (reset_ff_tx_clk_int_temp[i]), 
            		.d      (1'b1), 
            		.o    (reset_ff_tx_clk_inv[i])
        		);
    
		 assign reset_ff_tx_clk[i] =  ~reset_ff_tx_clk_inv[i];   

       
		assign reset_ff_rx_clk_int[i] = reset_mac200_ovveride_en ? reset_ff_rx_clk_ovveride[i] : physs_func_rst_raw_gated_n; 
  		assign reset_ff_rx_clk_int_temp[i]  = fscan_rstbypen ? ~fscan_byprst_b : reset_ff_rx_clk_int[i];
   
        	ctech_lib_doublesync_rst mac_ff_rx (
            		.clk     (physs_func_clk_gated_200), 
            		.rst (reset_ff_rx_clk_int_temp[i]), 
            		.d      (1'b1), 
            		.o    (reset_ff_rx_clk_inv[i])
        		);
    
		 assign reset_ff_rx_clk[i] =  ~reset_ff_rx_clk_inv[i];   

       
		assign reset_txclk_int[i] = reset_mac200_ovveride_en ? reset_txclk_ovveride[i] : physs_func_rst_raw_gated_n; 
  		assign reset_txclk_int_temp[i]  = fscan_rstbypen ? ~fscan_byprst_b : reset_txclk_int[i];
   
        	ctech_lib_doublesync_rst mac_txclk (
            		.clk     (physs_func_clk_gated_200), 
            		.rst (reset_txclk_int_temp[i]), 
            		.d      (1'b1), 
            		.o    (reset_txclk_inv[i])
        		);
    
		 assign reset_txclk[i] =  ~reset_txclk_inv[i];   

       
		assign reset_rxclk_int[i] = reset_mac200_ovveride_en ? reset_rxclk_ovveride[i] : physs_func_rst_raw_gated_n; 
  		assign reset_rxclk_int_temp[i]  = fscan_rstbypen ? ~fscan_byprst_b : reset_rxclk_int[i];
   
        	ctech_lib_doublesync_rst mac_rxclk (
            		.clk     (physs_func_clk_gated_200), 
            		.rst (reset_rxclk_int_temp[i]), 
            		.d      (1'b1), 
            		.o    (reset_rxclk_inv[i])
        		);
    
		 assign reset_rxclk[i] =  ~reset_rxclk_inv[i];   

	end//reset_sync_mac200	

	
        for ( i=5; i < 6; i++) begin : reset_sync_mac400
	
       
		assign reset_reg_clk_mac_int[i] = reset_mac400_ovveride_en ? reset_reg_clk_ovveride_mac[i] : physs_func_rst_raw_gated_n; 
  		assign reset_reg_clk_mac_int_temp[i]  = fscan_rstbypen ? ~fscan_byprst_b : reset_reg_clk_mac_int[i];
   
        	ctech_lib_doublesync_rst mac_reg_rst (
            		.clk     (soc_per_clk_gated_400), 
            		.rst (reset_reg_clk_mac_int_temp[i]), 
            		.d      (1'b1), 
            		.o    (reset_reg_clk_mac_inv[i])
        		);
    
		 assign reset_reg_clk_mac[i] =  ~reset_reg_clk_mac_inv[i];   


		assign reset_ff_tx_clk_int[i] = reset_mac400_ovveride_en ? reset_ff_tx_clk_ovveride[i] : physs_func_rst_raw_gated_n; 
  		assign reset_ff_tx_clk_int_temp[i]  = fscan_rstbypen ? ~fscan_byprst_b : reset_ff_tx_clk_int[i];
   
        	ctech_lib_doublesync_rst mac_ff_tx (
            		.clk     (physs_func_clk_gated_400), 
            		.rst (reset_ff_tx_clk_int_temp[i]), 
            		.d      (1'b1), 
            		.o    (reset_ff_tx_clk_inv[i])
        		);
    
		 assign reset_ff_tx_clk[i] =  ~reset_ff_tx_clk_inv[i];   

       
		assign reset_ff_rx_clk_int[i] = reset_mac400_ovveride_en ? reset_ff_rx_clk_ovveride[i] : physs_func_rst_raw_gated_n; 
  		assign reset_ff_rx_clk_int_temp[i]  = fscan_rstbypen ? ~fscan_byprst_b : reset_ff_rx_clk_int[i];
   
        	ctech_lib_doublesync_rst mac_ff_rx (
            		.clk     (physs_func_clk_gated_400), 
            		.rst (reset_ff_rx_clk_int_temp[i]), 
            		.d      (1'b1), 
            		.o    (reset_ff_rx_clk_inv[i])
        		);
    
		 assign reset_ff_rx_clk[i] =  ~reset_ff_rx_clk_inv[i];   

       
		assign reset_txclk_int[i] = reset_mac400_ovveride_en ? reset_txclk_ovveride[i] : physs_func_rst_raw_gated_n; 
  		assign reset_txclk_int_temp[i]  = fscan_rstbypen ? ~fscan_byprst_b : reset_txclk_int[i];
   
        	ctech_lib_doublesync_rst mac_txclk (
            		.clk     (physs_func_clk_gated_400), 
            		.rst (reset_txclk_int_temp[i]), 
            		.d      (1'b1), 
            		.o    (reset_txclk_inv[i])
        		);
    
		 assign reset_txclk[i] =  ~reset_txclk_inv[i];   

       
		assign reset_rxclk_int[i] = reset_mac400_ovveride_en ? reset_rxclk_ovveride[i] : physs_func_rst_raw_gated_n; 
  		assign reset_rxclk_int_temp[i]  = fscan_rstbypen ? ~fscan_byprst_b : reset_rxclk_int[i];
   
        	ctech_lib_doublesync_rst mac_rxclk (
            		.clk     (physs_func_clk_gated_400), 
            		.rst (reset_rxclk_int_temp[i]), 
            		.d      (1'b1), 
            		.o    (reset_rxclk_inv[i])
        		);
    
		 assign reset_rxclk[i] =  ~reset_rxclk_inv[i];   

	end//reset_sync_mac400	
	
endgenerate	

//RST quadpcs100


       
		assign reset_ref_clk_int = reset_pcs100_ovveride_en ? reset_ref_clk_ovveride : physs_func_rst_raw_gated_n; 
  		assign reset_ref_clk_int_temp  = fscan_rstbypen ? ~fscan_byprst_b : reset_ref_clk_int;
   
        	ctech_lib_doublesync_rst pcs_ref_clk (
            		.clk     (physs_func_clk_gated_100), 
            		.rst (reset_ref_clk_int_temp), 
            		.d      (1'b1), 
            		.o    (reset_ref_clk_inv)
        		);
    
		 assign reset_ref_clk =  ~reset_ref_clk_inv;   


       
		assign reset_reg_clk_int = reset_pcs100_ovveride_en ? reset_reg_clk_ovveride : physs_func_rst_raw_gated_n; 
  		assign reset_reg_clk_int_temp  = fscan_rstbypen ? ~fscan_byprst_b : reset_reg_clk_int;
   
        	ctech_lib_doublesync_rst pcs_reg_clk (
            		.clk     (soc_per_clk_gated_100), 
            		.rst (reset_reg_clk_int_temp), 
            		.d      (1'b1), 
            		.o    (reset_reg_clk_inv)
        		);
    
		 assign reset_reg_clk =  ~reset_reg_clk_inv;   


       
		assign reset_reg_ref_clk_int = reset_pcs100_ovveride_en ? reset_reg_ref_clk_ovveride : physs_func_rst_raw_gated_n; 
  		assign reset_reg_ref_clk_int_temp  = fscan_rstbypen ? ~fscan_byprst_b : reset_reg_ref_clk_int;
   
        	ctech_lib_doublesync_rst pcs_reg_ref_clk (
            		.clk     (physs_func_clk_gated_100), 
            		.rst (reset_reg_ref_clk_int_temp), 
            		.d      (1'b1), 
            		.o    (reset_reg_ref_clk_inv)
        		);
    
		 assign reset_reg_ref_clk =  ~reset_reg_ref_clk_inv;   

       
		assign reset_gpcs0_ref_clk_int = reset_pcs100_ovveride_en ? reset_gpcs0_ref_clk_ovveride : physs_func_rst_raw_gated_n; 
  		assign reset_gpcs0_ref_clk_int_temp  = fscan_rstbypen ? ~fscan_byprst_b : reset_gpcs0_ref_clk_int;
   
        	ctech_lib_doublesync_rst mac_gpcs0_ref_clk (
            		.clk     (physs_func_clk_gated_100), 
            		.rst (reset_gpcs0_ref_clk_int_temp), 
            		.d      (1'b1), 
            		.o    (reset_gpcs0_ref_clk_inv)
        		);
    
		 assign reset_gpcs0_ref_clk =  ~reset_gpcs0_ref_clk_inv;   

       
		assign reset_gpcs1_ref_clk_int = reset_pcs100_ovveride_en ? reset_gpcs1_ref_clk_ovveride : physs_func_rst_raw_gated_n; 
  		assign reset_gpcs1_ref_clk_int_temp  = fscan_rstbypen ? ~fscan_byprst_b : reset_gpcs1_ref_clk_int;
   
        	ctech_lib_doublesync_rst mac_gpcs1_ref_clk (
            		.clk     (physs_func_clk_gated_100), 
            		.rst (reset_gpcs1_ref_clk_int_temp), 
            		.d      (1'b1), 
            		.o    (reset_gpcs1_ref_clk_inv)
        		);
    
		 assign reset_gpcs1_ref_clk =  ~reset_gpcs1_ref_clk_inv;   

       
		assign reset_gpcs2_ref_clk_int = reset_pcs100_ovveride_en ? reset_gpcs2_ref_clk_ovveride : physs_func_rst_raw_gated_n; 
  		assign reset_gpcs2_ref_clk_int_temp  = fscan_rstbypen ? ~fscan_byprst_b : reset_gpcs2_ref_clk_int;
   
        	ctech_lib_doublesync_rst mac_gpcs2_ref_clk (
            		.clk     (physs_func_clk_gated_100), 
            		.rst (reset_gpcs2_ref_clk_int_temp), 
            		.d      (1'b1), 
            		.o    (reset_gpcs2_ref_clk_inv)
        		);
    
		 assign reset_gpcs2_ref_clk =  ~reset_gpcs2_ref_clk_inv;   

       
		assign reset_gpcs3_ref_clk_int = reset_pcs100_ovveride_en ? reset_gpcs3_ref_clk_ovveride : physs_func_rst_raw_gated_n; 
  		assign reset_gpcs3_ref_clk_int_temp  = fscan_rstbypen ? ~fscan_byprst_b : reset_gpcs3_ref_clk_int;
   
        	ctech_lib_doublesync_rst mac_gpcs3_ref_clk (
            		.clk     (physs_func_clk_gated_100), 
            		.rst (reset_gpcs3_ref_clk_int_temp), 
            		.d      (1'b1), 
            		.o    (reset_gpcs3_ref_clk_inv)
        		);
    
		 assign reset_gpcs3_ref_clk =  ~reset_gpcs3_ref_clk_inv;   

       
		assign reset_xpcs_ref_clk_int[0] = reset_pcs100_ovveride_en ? reset_xpcs_ref_clk_ovveride[0] : physs_func_rst_raw_gated_n; 
  		assign reset_xpcs_ref_clk_int_temp[0]  = fscan_rstbypen ? ~fscan_byprst_b : reset_xpcs_ref_clk_int[0];
   
        	ctech_lib_doublesync_rst xpcs_ref_clk0 (
            		.clk     (physs_func_clk_gated_100), 
            		.rst (reset_xpcs_ref_clk_int_temp[0]), 
            		.d      (1'b1), 
            		.o    (reset_xpcs_ref_clk_inv[0])
        		);
    
		 assign reset_xpcs_ref_clk[0] =  ~reset_xpcs_ref_clk_inv[0];   

       
		assign reset_xpcs_ref_clk_int[1] = reset_pcs100_ovveride_en ? reset_xpcs_ref_clk_ovveride[1] : physs_func_rst_raw_gated_n; 
  		assign reset_xpcs_ref_clk_int_temp[1]  = fscan_rstbypen ? ~fscan_byprst_b : reset_xpcs_ref_clk_int[1];
   
        	ctech_lib_doublesync_rst xpcs_ref_clk1 (
            		.clk     (physs_func_clk_gated_100), 
            		.rst (reset_xpcs_ref_clk_int_temp[1]), 
            		.d      (1'b1), 
            		.o    (reset_xpcs_ref_clk_inv[1])
        		);
    
		 assign reset_xpcs_ref_clk[1] =  ~reset_xpcs_ref_clk_inv[1];   

       
		assign reset_f91_ref_clk_int[0] = reset_pcs100_ovveride_en ? reset_f91_ref_clk_ovveride[0] : physs_func_rst_raw_gated_n; 
  		assign reset_f91_ref_clk_int_temp[0]  = fscan_rstbypen ? ~fscan_byprst_b : reset_f91_ref_clk_int[0];
   
        	ctech_lib_doublesync_rst f91_ref_clk0 (
            		.clk     (physs_func_clk_gated_100), 
            		.rst (reset_f91_ref_clk_int_temp[0]), 
            		.d      (1'b1), 
            		.o    (reset_f91_ref_clk_inv[0])
        		);
    
		 assign reset_f91_ref_clk[0] =  ~reset_f91_ref_clk_inv[0];   

       
		assign reset_f91_ref_clk_int[1] = reset_pcs100_ovveride_en ? reset_f91_ref_clk_ovveride[1] : physs_func_rst_raw_gated_n; 
  		assign reset_f91_ref_clk_int_temp[1]  = fscan_rstbypen ? ~fscan_byprst_b : reset_f91_ref_clk_int[1];
   
        	ctech_lib_doublesync_rst f91_ref_clk1 (
            		.clk     (physs_func_clk_gated_100), 
            		.rst (reset_f91_ref_clk_int_temp[1]), 
            		.d      (1'b1), 
            		.o    (reset_f91_ref_clk_inv[1])
        		);
    
		 assign reset_f91_ref_clk[1] =  ~reset_f91_ref_clk_inv[1];   





		assign rst_apb_b_a_int = reset_xmp_ovveride_en ? i_rst_apb_b_a_ovveride : hip_rst_n; 
		assign rst_apb_b_a = fscan_rstbypen ? fscan_byprst_b : rst_apb_b_a_int;  


		assign rst_ucss_por_b_a_int = reset_xmp_ovveride_en ? i_rst_ucss_por_b_a_ovveride : hip_rst_n; 
		assign rst_ucss_por_b_a = fscan_rstbypen ? fscan_byprst_b : rst_ucss_por_b_a_int;  


		assign rst_pma0_por_b_a_int = reset_xmp_ovveride_en ? i_rst_pma0_por_b_a_ovveride : hip_rst_n; 
		assign rst_pma0_por_b_a = fscan_rstbypen ? fscan_byprst_b : rst_pma0_por_b_a_int;  

		assign rst_pma1_por_b_a_int = reset_xmp_ovveride_en ? i_rst_pma1_por_b_a_ovveride : hip_rst_n; 
		assign rst_pma1_por_b_a = fscan_rstbypen ? fscan_byprst_b : rst_pma1_por_b_a_int;  

		assign rst_pma2_por_b_a_int = reset_xmp_ovveride_en ? i_rst_pma2_por_b_a_ovveride : hip_rst_n; 
		assign rst_pma2_por_b_a = fscan_rstbypen ? fscan_byprst_b : rst_pma2_por_b_a_int;  
	
		assign rst_pma3_por_b_a_int = reset_xmp_ovveride_en ? i_rst_pma3_por_b_a_ovveride : hip_rst_n; 
		assign rst_pma3_por_b_a = fscan_rstbypen ? fscan_byprst_b : rst_pma3_por_b_a_int;  

      

// RST time_clk
for ( i=0; i < LANES; i++) begin : reset_sync_timeclk   

		assign reset_time_clk_int[i] = reset_pcs100_ovveride_en ? reset_time_clk_ovveride[i] : physs_func_rst_raw_gated_n; 
  		assign reset_time_clk_int_temp[i]  = fscan_rstbypen ? ~fscan_byprst_b : reset_time_clk_int[i];
   
        	ctech_lib_doublesync_rst pcs_ref_clk (
            		.clk     (time_clk_gated_100), 
            		.rst (reset_time_clk_int_temp[i]), 
            		.d      (1'b1), 
            		.o    (reset_time_clk_inv[i])
        		);
    
		 assign reset_time_clk_n[i] =  reset_time_clk_inv[i];   
 
end // reset_sync_timeclk

// RST PCS 200

       
		assign reset_cdmii_rxclk_200G_int = reset_pcs200_ovveride_en ? reset_cdmii_rxclk_ovveride_200G : physs_func_rst_raw_gated_n; 
  		assign reset_cdmii_rxclk_200G_int_temp  = fscan_rstbypen ? ~fscan_byprst_b : reset_cdmii_rxclk_200G_int;
   
        	ctech_lib_doublesync_rst pcs_cdmii_rxclk200 (
            		.clk     (physs_func_clk_gated_200), 
            		.rst (reset_cdmii_rxclk_200G_int_temp), 
            		.d      (1'b1), 
            		.o    (reset_cdmii_rxclk_200G_inv)
        		);
    
		 assign reset_cdmii_rxclk_200G =  ~reset_cdmii_rxclk_200G_inv;   

       
		assign reset_cdmii_txclk_200G_int = reset_pcs200_ovveride_en ? reset_cdmii_txclk_ovveride_200G : physs_func_rst_raw_gated_n; 
  		assign reset_cdmii_txclk_200G_int_temp  = fscan_rstbypen ? ~fscan_byprst_b : reset_cdmii_txclk_200G_int;
   
        	ctech_lib_doublesync_rst pcs_cdmii_txclk200 (
            		.clk     (physs_func_clk_gated_200), 
            		.rst (reset_cdmii_txclk_200G_int_temp), 
            		.d      (1'b1), 
            		.o    (reset_cdmii_txclk_200G_inv)
        		);
    
		 assign reset_cdmii_txclk_200G =  ~reset_cdmii_txclk_200G_inv;   

       
		assign reset_reg_clk_200G_int = reset_pcs200_ovveride_en ? reset_reg_clk_ovveride_200G : physs_func_rst_raw_gated_n; 
  		assign reset_reg_clk_200G_int_temp  = fscan_rstbypen ? ~fscan_byprst_b : reset_reg_clk_200G_int;
   
        	ctech_lib_doublesync_rst pcs_reg_clk_200 (
            		.clk     (soc_per_clk_gated_200), 
            		.rst (reset_reg_clk_200G_int_temp), 
            		.d      (1'b1), 
            		.o    (reset_reg_clk_200G_inv)
        		);
    
		 assign reset_reg_clk_200G =  ~reset_reg_clk_200G_inv;   


		assign reset_reg_ref_clk_200G_int = reset_pcs200_ovveride_en ? reset_reg_ref_clk_ovveride_200G : physs_func_rst_raw_gated_n; 
  		assign reset_reg_ref_clk_200G_int_temp  = fscan_rstbypen ? ~fscan_byprst_b : reset_reg_ref_clk_200G_int;
   
        	ctech_lib_doublesync_rst pcs_reg_ref_clk_200 (
            		.clk     (physs_func_clk_gated_200), 
            		.rst (reset_reg_ref_clk_200G_int_temp), 
            		.d      (1'b1), 
            		.o    (reset_reg_ref_clk_200G_inv)
        		);
    
		 assign reset_reg_ref_clk_200G =  ~reset_reg_ref_clk_200G_inv;   



		assign reset_cdmii_rxclk_400G_int = reset_pcs400_ovveride_en ? reset_cdmii_rxclk_ovveride_400G : physs_func_rst_raw_gated_n; 
  		assign reset_cdmii_rxclk_400G_int_temp  = fscan_rstbypen ? ~fscan_byprst_b : reset_cdmii_rxclk_400G_int;
   
        	ctech_lib_doublesync_rst pcs_cdmii_rxclk400 (
            		.clk     (physs_func_clk_gated_400), 
            		.rst (reset_cdmii_rxclk_400G_int_temp), 
            		.d      (1'b1), 
            		.o    (reset_cdmii_rxclk_400G_inv)
        		);
    
		 assign reset_cdmii_rxclk_400G =  ~reset_cdmii_rxclk_400G_inv;   

       
		assign reset_cdmii_txclk_400G_int = reset_pcs400_ovveride_en ? reset_cdmii_txclk_ovveride_400G : physs_func_rst_raw_gated_n; 
  		assign reset_cdmii_txclk_400G_int_temp  = fscan_rstbypen ? ~fscan_byprst_b : reset_cdmii_txclk_400G_int;
   
        	ctech_lib_doublesync_rst pcs_cdmii_txclk400 (
            		.clk     (physs_func_clk_gated_400), 
            		.rst (reset_cdmii_txclk_400G_int_temp), 
            		.d      (1'b1), 
            		.o    (reset_cdmii_txclk_400G_inv)
        		);
    
		 assign reset_cdmii_txclk_400G =  ~reset_cdmii_txclk_400G_inv;   

       
		assign reset_reg_clk_400G_int = reset_pcs400_ovveride_en ? reset_reg_clk_ovveride_400G : physs_func_rst_raw_gated_n; 
  		assign reset_reg_clk_400G_int_temp  = fscan_rstbypen ? ~fscan_byprst_b : reset_reg_clk_400G_int;
   
        	ctech_lib_doublesync_rst pcs_reg_clk_400 (
            		.clk     (soc_per_clk_gated_400), 
            		.rst (reset_reg_clk_400G_int_temp), 
            		.d      (1'b1), 
            		.o    (reset_reg_clk_400G_inv)
        		);
    
		 assign reset_reg_clk_400G =  ~reset_reg_clk_400G_inv;   


       
		assign reset_reg_ref_clk_400G_int = reset_pcs400_ovveride_en ? reset_reg_ref_clk_ovveride_400G : physs_func_rst_raw_gated_n; 
  		assign reset_reg_ref_clk_400G_int_temp  = fscan_rstbypen ? ~fscan_byprst_b : reset_reg_ref_clk_400G_int;
   
        	ctech_lib_doublesync_rst pcs_reg_ref_clk_400 (
            		.clk     (physs_func_clk_gated_400), 
            		.rst (reset_reg_ref_clk_400G_int_temp), 
            		.d      (1'b1), 
            		.o    (reset_reg_ref_clk_400G_inv)
        		);
    
		 assign reset_reg_ref_clk_400G =  ~reset_reg_ref_clk_400G_inv;   


        	ctech_lib_doublesync_rstb func_fabric_rstn (
            		.clk  (soc_per_clk), 
            		.rstb (physs_func_rst_raw_n), 
            		.d      (1'b1), 
            		.o    (func_rstn_fabric_sync)
        		);
    
        	ctech_lib_doublesync_rstb hip_fabric_rstn (
            		.clk  (soc_per_clk), 
            		.rstb (hip_rst_n), 
            		.d      (1'b1), 
            		.o    (hip_rstn_fabric_sync)
        		);
    
		 
		 
		 //        ctech_lib_doublesync_rst sd_rx_rst (
//            .clk     (serdes_rx_clk_gated[i]), 
//            .rst (reset_pcs_rx_lane[i]), 
//            .d      (~eth56g_quad_disable), 
//            .o    (reset_sd_rx_clk_inv[i])
//        );
//    
//        ctech_lib_doublesync_rst onpi_rst (
//            .clk     (onpi_clk_gated[i]), 
//            .rst (reset_onpi_lane[i]), 
//            .d      (~eth56g_quad_disable           ), 
//             .o    (reset_onpi_clk_inv[i])
//         );
//
//        ctech_lib_doublesync_rst time_rst (
//            .clk     (time_clk), 
//            .rst (reset_onpi_lane[i]), 
//            .d      (~eth56g_quad_disable           ), 
//             .o    (reset_time_clk_inv[i])
//         );
//
//        ctech_lib_doublesync_rst reg_ref_rst (
//            .clk     (reg_physs_func_clk_gated[i]), 
//            .rst (reset_reg_ref_lane[i]), 
//            .d      (~eth56g_quad_disable ), 
//             .o    (reset_reg_ref_clk_inv[i])
//         );
//
//        ctech_lib_doublesync_rst reg_rst (
//            .clk     (soc_per_clk_gated[i]), 
//            .rst (reset_reg_ref_lane[i]), 
//            .d      (~eth56g_quad_disable ), 
//             .o    (reset_reg_clk_inv_int[i])
//         );
//        assign reset_reg_clk_inv[i] = fscan_rstbypen ? fscan_byprst_b : reset_reg_clk_inv_int[i];
//        
//
//        ctech_lib_doublesync_rst xpcs_rst (
//            .clk     (xpcs_ref_clk_gated[i]), 
//            .rst (reset_xpcs_ref_lane[i]), 
//            .d      (~eth56g_quad_disable ), 
//             .o    (reset_xpcs_ref_clk_inv[i])
//         );
//
//        ctech_lib_doublesync_rst onpi_ref_rst (
//            .clk     (onpi_physs_func_clk_gated[i]), 
//            .rst (reset_onpi_ref_lane[i]), 
//            .d      (~eth56g_quad_disable ), 
//             .o    (reset_onpi_ref_clk_inv_int[i])
//         );
//
//        assign reset_onpi_ref_clk_inv[i] = fscan_rstbypen ? fscan_byprst_b : reset_onpi_ref_clk_inv_int[i];
//        
//        ctech_lib_doublesync_rst gpcs_rst (
//            .clk     (gpcs_physs_func_clk_gated[i]), 
//            .rst (reset_gpcs_ref_lane[i]), 
//            .d      (~eth56g_quad_disable ), 
//             .o    (reset_gpcs_ref_clk_inv[i])
//         );
//
//
//        ctech_lib_doublesync_rst sg_link (
//            .clk     (gpcs_physs_func_clk_gated[i]), 
//            .rst (reset_gpcs_ref_clk[i]), 
//            .d      (sg_link_status_in[i]), 
//            .o    (sg_link_status_sync[i])
//        );
//
//      assign physs_func_rst_raw =  ~physs_func_rst_raw_n; 
//      
//      assign reset_reg_clk[i] =  ~reset_reg_clk_inv[i]; 
//      assign reset_sd_tx_clk[i] =  ~reset_sd_tx_clk_inv[i]; 
//      assign reset_sd_rx_clk_temp[i] =  ~reset_sd_rx_clk_inv[i]; 
//      assign reset_onpi_clk[i] =  ~reset_onpi_clk_inv[i]; 
//      assign reset_reg_ref_clk[i] =  ~reset_reg_ref_clk_inv[i]; 
//      assign reset_gpcs_ref_clk[i] =  ~reset_gpcs_ref_clk_inv[i]; 
//      assign reset_xpcs_ref_clk[i] =  ~reset_xpcs_ref_clk_inv[i]; 
//      assign reset_onpi_ref_clk[i] =  ~reset_onpi_ref_clk_inv[i]; 
//      assign link_status[i] = link_status_in[i] |  sg_link_status_sync[i];
//
//    end
//
//endgenerate
//
//
//
//
//ctech_lib_doublesync_rst pcs_ref_rst (
//  .clk     (physs_func_clk_gated), 
//  .rst (reset_ref_clk), 
//  .d      (~eth56g_quad_disable           ), 
//  .o    (reset_pcs_ref_clk_inv)
//);
//
//ctech_lib_doublesync_rst f91_ref_rst (
//  .clk     (f91_ref_clk_gated), 
//  .rst (reset_f91ref_clk), 
//  .d      (~eth56g_quad_disable           ), 
//  .o    (reset_f91_ref_clk_inv)
//);
//
//
//assign reset_pcs_ref_clk =  ~reset_pcs_ref_clk_inv; 
//assign reset_f91_ref_clk =  ~reset_f91_ref_clk_inv; 
//
//assign flex_pwrgood_gated =  ~eth56g_quad_disable && flux_pwrgood_apb_rstn;
//
//
//generate 
//
//    for ( i=0; i < LANES; i++) begin : pcs_loopback 
//        
//     ctech_lib_clk_mux_2to1 sd_rx_clk_mux (
//    .clk2(serdes_rx_clk[i] ),
//    .clk1(serdes_tx_clk[i]),
//    .s(pcs_external_loopback_en[i] & ~fscan_mode),
//    .clkout(serdes_rx_clk_int[i]) 
//    );
//  
//    assign sd_rx_out[i] = pcs_external_loopback_en[i] ? sd_tx_in[i] : sd_rx[i]; 
//    assign reset_sd_rx_clk[i] = fscan_rstbypen ? ~fscan_byprst_b :  pcs_external_loopback_en[i] ? reset_sd_tx_clk[i] : reset_sd_rx_clk_temp[i]; 
//  
//  end
//
//endgenerate 
//
//
//generate 
//
//
//    for ( i=0; i < LANES; i++) begin : clk_gate_en 
//
//       assign serdes_tx_clk_gate_en[i] = clk_gate_control_quad[i] && ~eth56g_quad_disable;
//       assign serdes_rx_clk_gate_en[i] = clk_gate_control_quad[i+4] && ~eth56g_quad_disable;
//       assign xpcs_ref_clk_gate_en[i] = clk_gate_control_quad[i+8] && ~eth56g_quad_disable;
//       assign gpcs_ref_clk_gate_en[i] = clk_gate_control_quad[i+13] && ~eth56g_quad_disable;
//       assign onpi_ref_clk_gate_en[i] = clk_gate_control_quad[i+17] && ~eth56g_quad_disable;
//       assign onpi_clk_gate_en[i] = clk_gate_control_quad[i+21] && ~eth56g_quad_disable;
//       assign reg_clk_gate_en[i] = clk_gate_control_quad[i+25] && ~eth56g_quad_disable;
//
//    end
//
//       assign f91_ref_clk_gate_en = clk_gate_control_quad[12] && ~eth56g_quad_disable;
//        
//
//
//    for ( i=0; i < LANES; i++) begin : clk_gate 
//
//     ctech_lib_clk_gate_te clk_gate_tx (
//     .clkout(serdes_tx_clk_gated[i]),
//     .en(serdes_tx_clk_gate_en[i] ),
//     .te(physs_dfx_fscan_clkungate),
//     .clk(serdes_tx_clk[i])
//    );
//  
//     ctech_lib_clk_gate_te clk_gate_rx (
//     .clkout(serdes_rx_clk_gated[i]),
//     .en(serdes_rx_clk_gate_en[i] ),
//     .te(physs_dfx_fscan_clkungate),
//     .clk(serdes_rx_clk_int[i])
//    );
//  
//     ctech_lib_clk_gate_te clk_gate_xpcs_ref (
//     .clkout(xpcs_ref_clk_gated[i]),
//     .en(xpcs_ref_clk_gate_en[i] ),
//     .te(physs_dfx_fscan_clkungate),
//     .clk(pcs_ref_clk)
//    );
//  
//     ctech_lib_clk_gate_te clk_gate_gpcs_ref (
//     .clkout(gpcs_physs_func_clk_gated[i]),
//     .en(gpcs_ref_clk_gate_en[i] ),
//     .te(physs_dfx_fscan_clkungate),
//     .clk(pcs_ref_clk)
//    );
//  
//  
//     ctech_lib_clk_gate_te clk_gate_onpi_ref (
//     .clkout(onpi_physs_func_clk_gated[i]),
//     .en(onpi_ref_clk_gate_en[i] ),
//     .te(physs_dfx_fscan_clkungate),
//     .clk(pcs_ref_clk)
//    );
//  
//     ctech_lib_clk_gate_te clk_gate_onpi (
//     .clkout(onpi_clk_gated[i]),
//     .en(onpi_clk_gate_en[i] ),
//     .te(physs_dfx_fscan_clkungate),
//     .clk(onpi_clk[i])
//    );
//  
//     ctech_lib_clk_gate_te clk_gate_onpi_reg_ref (
//     .clkout(reg_physs_func_clk_gated[i]),
//     .en(reg_clk_gate_en[i] ),
//     .te(physs_dfx_fscan_clkungate),
//     .clk(pcs_ref_clk)
//    );
//  
//     ctech_lib_clk_gate_te clk_gate_eg (
//     .clkout(soc_per_clk_gated[i]),
//     .en(reg_clk_gate_en[i] ),
//     .te(physs_dfx_fscan_clkungate),
//     .clk(side_clk)
//    );
//  
//  
//  end
//
//     ctech_lib_clk_gate_te clk_gate_ref (
//     .clkout(physs_func_clk_gated),
//     .en(~eth56g_quad_disable),
//     .te(physs_dfx_fscan_clkungate),
//     .clk(pcs_ref_clk)
//    );
//  
//     ctech_lib_clk_gate_te clk_gate_f91ref (
//     .clkout(f91_ref_clk_gated),
//     .en(f91_ref_clk_gate_en),
//     .te(physs_dfx_fscan_clkungate),
//     .clk(pcs_ref_clk)
//    );
//  
//
//
//endgenerate 
//
//
//
//assign lane_reversal_mux_quad_xor =  fscan_mode ?  1'b0 : lane_reversal_mux_quad[0] ^ lane_reversal_mux_quad[1];
//assign lane_reversal_mux_quad_and =  fscan_mode ?  1'b0 : lane_reversal_mux_quad[0] & lane_reversal_mux_quad[1];
//
//
//   ctech_lib_clk_mux_2to1 sd_tx0_lane_reversal_mux0 (
//    .clk2(serdes_tx_clk_in[0] ),
//    .clk1(serdes_tx_clk_in[1]),
//    .s(lane_reversal_mux_quad_and),
//    .clkout(serdes_tx_clk0) 
//    );
//
//   ctech_lib_clk_mux_2to1 sd_tx0_lane_reversal_mux1 (
//    .clk2(serdes_tx_clk0),
//    .clk1(serdes_tx_clk_in[3] ),
//    .s(lane_reversal_mux_quad_xor),
//    .clkout(serdes_tx_clk[0]) 
//    );
//
//   ctech_lib_clk_mux_2to1 sd_tx1_lane_reversal_mux0 (
//    .clk2(serdes_tx_clk_in[1] ),
//    .clk1(serdes_tx_clk_in[0]),
//    .s(lane_reversal_mux_quad_and),
//    .clkout(serdes_tx_clk1) 
//    );
//
//   ctech_lib_clk_mux_2to1 sd_tx1_lane_reversal_mux1 (
//    .clk2(serdes_tx_clk1),
//    .clk1(serdes_tx_clk_in[2] ),
//    .s(lane_reversal_mux_quad_xor),
//    .clkout(serdes_tx_clk[1]) 
//    );
//
//   ctech_lib_clk_mux_2to1 sd_tx2_lane_reversal_mux0 (
//    .clk2(serdes_tx_clk_in[2] ),
//    .clk1(serdes_tx_clk_in[1]),
//    .s(lane_reversal_mux_quad_xor),
//    .clkout(serdes_tx_clk[2]) 
//    );
//
//   ctech_lib_clk_mux_2to1 sd_tx3_lane_reversal_mux0 (
//    .clk2(serdes_tx_clk_in[3] ),
//    .clk1(serdes_tx_clk_in[0]),
//    .s(lane_reversal_mux_quad_xor),
//    .clkout(serdes_tx_clk[3]) 
//    );
//
//   ctech_lib_clk_mux_2to1 sd_rx0_lane_reversal_mux0 (
//    .clk2(serdes_rx_clk_in[0] ),
//    .clk1(serdes_rx_clk_in[1]),
//    .s(lane_reversal_mux_quad_and),
//    .clkout(serdes_rx_clk0) 
//    );
//
//   ctech_lib_clk_mux_2to1 sd_rx0_lane_reversal_mux1 (
//    .clk2(serdes_rx_clk0),
//    .clk1(serdes_rx_clk_in[3] ),
//    .s(lane_reversal_mux_quad_xor),
//    .clkout(serdes_rx_clk[0]) 
//    );
//
//   ctech_lib_clk_mux_2to1 sd_rx1_lane_reversal_mux0 (
//    .clk2(serdes_rx_clk_in[1] ),
//    .clk1(serdes_rx_clk_in[0]),
//    .s(lane_reversal_mux_quad_and),
//    .clkout(serdes_rx_clk1) 
//    );
//
//   ctech_lib_clk_mux_2to1 sd_rx1_lane_reversal_mux1 (
//    .clk2(serdes_rx_clk1),
//    .clk1(serdes_rx_clk_in[2] ),
//    .s(lane_reversal_mux_quad_xor),
//    .clkout(serdes_rx_clk[1]) 
//    );
//
//   ctech_lib_clk_mux_2to1 sd_rx2_lane_reversal_mux0 (
//    .clk2(serdes_rx_clk_in[2] ),
//    .clk1(serdes_rx_clk_in[1]),
//    .s(lane_reversal_mux_quad_xor),
//    .clkout(serdes_rx_clk[2]) 
//    );
//
//   ctech_lib_clk_mux_2to1 sd_rx3_lane_reversal_mux0 (
//    .clk2(serdes_rx_clk_in[3] ),
//    .clk1(serdes_rx_clk_in[0]),
//    .s(lane_reversal_mux_quad_xor),
//    .clkout(serdes_rx_clk[3]) 
//    );
//
//
//assign oflux_srds_rdy_temp[0] = oflux_srds_rdy_ovr_en0 ? oflux_srds_rdy_ovr0 : oflux_srds_rdy[0];
//assign oflux_srds_rdy_temp[1] = oflux_srds_rdy_ovr_en1 ? oflux_srds_rdy_ovr1 : oflux_srds_rdy[1];
//assign oflux_srds_rdy_temp[2] = oflux_srds_rdy_ovr_en2 ? oflux_srds_rdy_ovr2 : oflux_srds_rdy[2];
//assign oflux_srds_rdy_temp[3] = oflux_srds_rdy_ovr_en3 ? oflux_srds_rdy_ovr3 : oflux_srds_rdy[3];
//
//
//always_comb begin
//
//    case(lane_reversal_mux_quad)
//        2'b00 : begin // No_lane reversal 
//                sd_tx[0] = sd_tx_in[0];
//                sd_tx[1] = sd_tx_in[1];
//                sd_tx[2] = sd_tx_in[2];
//                sd_tx[3] = sd_tx_in[3];
//                sd_rx[0] = sd_rx_in[0];
//                sd_rx[1] = sd_rx_in[1];
//                sd_rx[2] = sd_rx_in[2];
//                sd_rx[3] = sd_rx_in[3];
//                oflux_srds_rdy_out[0] = oflux_srds_rdy_temp[0];
//                oflux_srds_rdy_out[1] = oflux_srds_rdy_temp[1];
//                oflux_srds_rdy_out[2] = oflux_srds_rdy_temp[2];
//                oflux_srds_rdy_out[3] = oflux_srds_rdy_temp[3];
//                link_status_out[0] = link_status[0];
//                link_status_out[1] = link_status[1];
//                link_status_out[2] = link_status[2];
//                link_status_out[3] = link_status[3];
//                end
//
//        2'b01, 2'b10 : begin // x4Lane reveersal, x2 Lane reversal in upper lanes 
//                sd_tx[0] = sd_tx_in[3];
//                sd_tx[1] = sd_tx_in[2];
//                sd_tx[2] = sd_tx_in[1];
//                sd_tx[3] = sd_tx_in[0];
//                sd_rx[0] = sd_rx_in[3];
//                sd_rx[1] = sd_rx_in[2];
//                sd_rx[2] = sd_rx_in[1];
//                sd_rx[3] = sd_rx_in[0];
//                oflux_srds_rdy_out[0] = oflux_srds_rdy_temp[3];
//                oflux_srds_rdy_out[1] = oflux_srds_rdy_temp[2];
//                oflux_srds_rdy_out[2] = oflux_srds_rdy_temp[1];
//                oflux_srds_rdy_out[3] = oflux_srds_rdy_temp[0];
//                link_status_out[0] = link_status[3];
//                link_status_out[1] = link_status[2];
//                link_status_out[2] = link_status[1];
//                link_status_out[3] = link_status[0];
//                end
//
//        2'b11 : begin  // x2 Lane reversal in lower lanes 
//                sd_tx[0] = sd_tx_in[1];
//                sd_tx[1] = sd_tx_in[0];
//                sd_tx[2] = sd_tx_in[2];
//                sd_tx[3] = sd_tx_in[3];
//                sd_rx[0] = sd_rx_in[1];
//                sd_rx[1] = sd_rx_in[0];
//                sd_rx[2] = sd_rx_in[2];
//                sd_rx[3] = sd_rx_in[3];
//                oflux_srds_rdy_out[0] = oflux_srds_rdy_temp[1];
//                oflux_srds_rdy_out[1] = oflux_srds_rdy_temp[0];
//                oflux_srds_rdy_out[2] = oflux_srds_rdy_temp[2];
//                oflux_srds_rdy_out[3] = oflux_srds_rdy_temp[3];
//                link_status_out[0] = link_status[1];
//                link_status_out[1] = link_status[0];
//                link_status_out[2] = link_status[2];
//                link_status_out[3] = link_status[3];
//                end
//        
//        default: begin
//                sd_tx[0] = sd_tx_in[0];
//                sd_tx[1] = sd_tx_in[1];
//                sd_tx[2] = sd_tx_in[2];
//                sd_tx[3] = sd_tx_in[3];
//                sd_rx[0] = sd_rx_in[0];
//                sd_rx[1] = sd_rx_in[1];
//                sd_rx[2] = sd_rx_in[2];
//                sd_rx[3] = sd_rx_in[3];
//                oflux_srds_rdy_out[0] = oflux_srds_rdy_temp[0];
//                oflux_srds_rdy_out[1] = oflux_srds_rdy_temp[1];
//                oflux_srds_rdy_out[2] = oflux_srds_rdy_temp[2];
//                oflux_srds_rdy_out[3] = oflux_srds_rdy_temp[3];
//                link_status_out[0] = link_status[0];
//                link_status_out[1] = link_status[1];
//                link_status_out[2] = link_status[2];
//                link_status_out[3] = link_status[3];
//                end
//  endcase
//end
//
//
//
//   wire [3:0]  busy_wr;
//   reg [3:0]   valid_data_wr;
//   reg [31:0]   transfer_data_wr[3:0];
//   reg [3:0]   req_wr;
//   reg [3:0]   req_wr_sync;
//   reg [3:0]   req_wr_sync2;
//   reg [3:0]   ack_wr_sync;
//   reg [3:0]   peer_delay_val_in_d;
//
//generate
//
//for ( i=0; i < LANES; i++) begin : peer_delay_val_sync 
//
//   always_ff @(posedge soc_per_clk_gated[i] or negedge reset_reg_clk_inv[i]) begin
//        if(!reset_reg_clk_inv[i]) begin
//            valid_data_wr[i] <= 1'b0;
//            transfer_data_wr[i] <= 32'b0;
//            peer_delay_val_in_d[i] <= 1'b0;
//        end else  
//        begin
//        peer_delay_val_in_d[i] <= peer_delay_val_in[i];
//        if (!busy_wr[0] && (peer_delay_val_in[i] && ~peer_delay_val_in_d[i])) begin
//            transfer_data_wr[i] <= {peer_delay_val_in[i],t1s_add_peer_delay_in[i],peer_delay_in[i]};
//            valid_data_wr[i] <= 1'b1;
//           end
//        else if (ack_wr_sync[i]) begin
//            valid_data_wr[i] <= 1'b0;
//            transfer_data_wr[i] <= 32'b0;
//        end
//
//        end
//   end
//
// 
//
//   always_ff @(posedge soc_per_clk_gated[i] or negedge reset_reg_clk_inv[i]) begin
//        if(!reset_reg_clk_inv[i])
//            req_wr[i] <= 1'b0;
//        else  begin
//        if (!busy_wr[0] && valid_data_wr[i]) 
//            req_wr[i] <= 1'b1;
//        else if (ack_wr_sync[i]) 
//            req_wr[i] <= 1'b0;
//        end
//   end
//
//
//  always_ff @(posedge onpi_physs_func_clk_gated[i] or negedge reset_onpi_ref_clk_inv[i]) begin
//         if (!reset_onpi_ref_clk_inv[i]) begin
//            peer_delay_val[i] <= 1'b0;
//            peer_delay[i] <= 30'b0;
//            t1s_add_peer_delay[i] <= 1'b0;
//            req_wr_sync2[i] <= 1'b0;
//         end
//         else begin
//            req_wr_sync2[i] <= req_wr_sync[i];
//            if(req_wr_sync[i] && !req_wr_sync2[i]) begin
//                peer_delay_val[i] <= transfer_data_wr[i][31];
//                t1s_add_peer_delay[i] <= transfer_data_wr[i][30];
//                peer_delay[i] <= transfer_data_wr[i][29:0];
//            end  else begin
//                peer_delay_val[i] <= 1'b0;
//               end
//         end
//  end
// 
//
//  assign busy_wr[i] = req_wr[i] || ack_wr_sync[i];
//
//   ctech_lib_doublesync_rstb u_sync_req (
//                .clk     (onpi_physs_func_clk_gated[i]),
//                .rstb (reset_onpi_ref_clk_inv[i]),
//                .d      (req_wr[i]),
//                .o    (req_wr_sync[i])
//            );
//   
//   ctech_lib_doublesync_rstb  u_sync_ack (
//                .clk     (soc_per_clk_gated[i]),
//                .rstb (reset_reg_clk_inv[i]),
//                .d      (req_wr_sync2[i]),
//                .o    (ack_wr_sync[i])
//            );
//
//
//
// end
//endgenerate
//
///////// deskew_rlevel for port0 ////
//
//logic [18:0] deskew_rlevel_0_tmp ; 
//logic [12:0] deskew_samples ; 
//logic [12:0] count ;
//int num_samples_division;
//
//always_comb
//    begin
//        case (deskew_num_samples) 
//          2'b00: begin  
//            deskew_samples = 'h200; 
//            num_samples_division = 'd9;  
//            end
//          2'b01: begin 
//            deskew_samples = 'h400; 
//            num_samples_division = 'd10; 
//            end
//          2'b10: begin 
//            deskew_samples = 'h800; 
//            num_samples_division = 'd11; 
//            end
//          2'b11: begin 
//            deskew_samples = 'h1000; 
//            num_samples_division = 'd12; 
//            end
//          default : begin 
//            deskew_samples = 'h400; 
//            num_samples_division = 'd10; 
//            end
//       endcase
//    end
//
//
//
//    always_ff @(posedge physs_func_clk_gated or negedge reset_pcs_ref_clk_inv) begin
//      if(~reset_pcs_ref_clk_inv) begin
//        count <= 0;
//        deskew_rlevel_0_tmp <= 'b0;
//      end
//      else if (~link_status[0]) begin 
//        count <= 0;
//        deskew_rlevel_0_tmp <= 'b0;
//      end
//      else  
//        begin
//            if(count < (deskew_samples + deskew_valid_cycles)) 
//            begin
//                count <= count +1;
//                deskew_rlevel_0_tmp <= deskew_rlevel_0_tmp + deskew_rlevel_0;
//             end
//        end
//    end     
//       
//
//
//
//always_ff @(posedge physs_func_clk_gated or negedge reset_pcs_ref_clk_inv)  begin
//        if (~reset_pcs_ref_clk_inv) 
//            begin
//                deskew_rlevel_0_final <= 'b0;
//                deskew_rlevel_0_final_frac <= 'b0;
//                deskew_valid0 <= 1'b0;
//            end
//        else if (~link_status[0]) 
//            begin 
//                deskew_rlevel_0_final <= 'b0;
//                deskew_rlevel_0_final_frac <= 'b0;
//                deskew_valid0 <= 1'b0;
//            end
//        else  
//            begin
//               if(count == (deskew_samples)) begin 
//                    deskew_rlevel_0_final<= deskew_rlevel_0_tmp[num_samples_division +:7];
//                    //deskew_rlevel_0_final<= deskew_rlevel_0_tmp >> num_samples_division;
//                    deskew_rlevel_0_final_frac<= deskew_rlevel_0_tmp[num_samples_division-3 +:3] ;
//                     
//               end
//               if(count == (deskew_samples + deskew_valid_cycles)) 
//                    deskew_valid0 <= 1'b1;
//            end
//       end
//
///////// deskew_rlevel for port2 ////
//
//logic [18:0] deskew_rlevel_2_tmp; 
//logic [12:0] count1;
//
//    always_ff @(posedge physs_func_clk_gated or negedge reset_pcs_ref_clk_inv) begin
//      if(~reset_pcs_ref_clk_inv) begin
//        count1 <= 0;
//        deskew_rlevel_2_tmp <= 'b0;
//      end
//      else if (~link_status[2]) begin 
//        count1 <= 0;
//        deskew_rlevel_2_tmp <= 'b0;
//      end
//      else  
//        begin
//            if(count1 < (deskew_samples + deskew_valid_cycles)) 
//            begin
//                count1 <= count1 +1;
//                deskew_rlevel_2_tmp <= deskew_rlevel_2_tmp + deskew_rlevel_2;
//             end
//        end
//    end     
//       
//
//
//
//always_ff @(posedge physs_func_clk_gated or negedge reset_pcs_ref_clk_inv)  begin
//        if (~reset_pcs_ref_clk_inv) 
//            begin
//                deskew_rlevel_2_final <= 'b0;
//                deskew_rlevel_2_final_frac <= 'b0;
//                deskew_valid2 <= 1'b0;
//            end
//        else if (~link_status[2]) 
//            begin 
//                deskew_rlevel_2_final <= 'b0;
//                deskew_rlevel_2_final_frac <= 'b0;
//                deskew_valid2 <= 1'b0;
//            end
//        else  
//            begin
//               if(count1 == (deskew_samples)) begin 
//                    deskew_rlevel_2_final<= deskew_rlevel_2_tmp[num_samples_division +:7];
//                    //deskew_rlevel_2_final<= deskew_rlevel_2_tmp >> num_samples_division;
//                    deskew_rlevel_2_final_frac<= deskew_rlevel_2_tmp[num_samples_division-3 +:3] ;
//                 end
//               if(count1 == (deskew_samples + deskew_valid_cycles)) 
//                    deskew_valid2 <= 1'b1;
//            end
//       end


endmodule
