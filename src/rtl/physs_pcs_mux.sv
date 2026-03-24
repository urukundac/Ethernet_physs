//
//-------------------------------------------------------------------------------------------------------
//  INTEL CONFIDENTIAL
//
//  Copyright 2024 Intel Corporation All Rights Reserved.
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
//  physs_pcs_mux    
//
//  Date:       
//
//  Author:      
//
//  Description:
//  pcs_mux Block for pass through 100G,200G,400G data lane   
//
//  History:
//    
//-------------------------------------------------------------


module physs_pcs_mux(

input logic       fscan_mode,
input logic [1:0] pcs_lane_sel,
input logic [3:0] pcs_external_loopback_en,
input logic [3:0] cpri_sel,

//PCS 100G tx From PCS CORE
input logic [127:0] sd0_tx_in_100G,
input logic [127:0] sd1_tx_in_100G,
input logic [127:0] sd2_tx_in_100G,
input logic [127:0] sd3_tx_in_100G,

//PCS 200G tx/rx From PCS
input logic [31:0] sd0_tx_in_200G,
input logic [31:0] sd1_tx_in_200G,
input logic [31:0] sd2_tx_in_200G,
input logic [31:0] sd3_tx_in_200G,
input logic [31:0] sd4_tx_in_200G,
input logic [31:0] sd5_tx_in_200G,
input logic [31:0] sd6_tx_in_200G,
input logic [31:0] sd7_tx_in_200G,

//PCS 400G tx/rx From PCS
input logic [31:0] sd0_tx_in_400G,
input logic [31:0] sd1_tx_in_400G,
input logic [31:0] sd2_tx_in_400G,
input logic [31:0] sd3_tx_in_400G,
input logic [31:0] sd4_tx_in_400G,
input logic [31:0] sd5_tx_in_400G,
input logic [31:0] sd6_tx_in_400G,
input logic [31:0] sd7_tx_in_400G,
input logic [31:0] sd8_tx_in_400G,
input logic [31:0] sd9_tx_in_400G,
input logic [31:0] sd10_tx_in_400G,
input logic [31:0] sd11_tx_in_400G,
input logic [31:0] sd12_tx_in_400G,
input logic [31:0] sd13_tx_in_400G,
input logic [31:0] sd14_tx_in_400G,
input logic [31:0] sd15_tx_in_400G,

//Serdes to PCS
input logic [127:0] sd0_rx_in_serdes,
input logic [127:0] sd1_rx_in_serdes,
input logic [127:0] sd2_rx_in_serdes,
input logic [127:0] sd3_rx_in_serdes,

//FROM PCS MUX OUTPUT to Serdes 
output logic [127:0] sd0_tx_data_o,
output logic [127:0] sd1_tx_data_o,
output logic [127:0] sd2_tx_data_o,
output logic [127:0] sd3_tx_data_o,

//To Serdes to PCS 100G, 200G, 400G Lane  
output logic [127:0] sd0_rx_data_o,
output logic [127:0] sd1_rx_data_o,
output logic [127:0] sd2_rx_data_o,
output logic [127:0] sd3_rx_data_o,
output logic [31:0] sd4_rx_data_o,
output logic [31:0] sd5_rx_data_o,
output logic [31:0] sd6_rx_data_o,
output logic [31:0] sd7_rx_data_o,
output logic [31:0] sd0_rx_data_400G_o,
output logic [31:0] sd1_rx_data_400G_o,
output logic [31:0] sd2_rx_data_400G_o,
output logic [31:0] sd3_rx_data_400G_o,
output logic [31:0] sd4_rx_data_400G_o,
output logic [31:0] sd5_rx_data_400G_o,
output logic [31:0] sd6_rx_data_400G_o,
output logic [31:0] sd7_rx_data_400G_o,
output logic [31:0] sd8_rx_data_400G_o,
output logic [31:0] sd9_rx_data_400G_o,
output logic [31:0] sd10_rx_data_400G_o,
output logic [31:0] sd11_rx_data_400G_o,
output logic [31:0] sd12_rx_data_400G_o,
output logic [31:0] sd13_rx_data_400G_o,
output logic [31:0] sd14_rx_data_400G_o,
output logic [31:0] sd15_rx_data_400G_o,

input  logic [3:0] link_status_100G,
input  logic       link_status_200G,
input  logic       link_status_400G,
output logic [3:0] link_status_out,

input  logic [3:0]  serdes_rdy_in,
output logic [3:0]  srds_rdy_out_100G,
output logic        srds_rdy_out_200G,
output logic        srds_rdy_out_400G,

output logic   sd0_tx_clk_200G,             
output logic   sd2_tx_clk_200G,             
output logic   sd4_tx_clk_200G,             
output logic   sd6_tx_clk_200G,             
output logic   sd8_tx_clk_200G,             
output logic   sd10_tx_clk_200G,            
output logic   sd12_tx_clk_200G,            
output logic   sd14_tx_clk_200G,

output logic   sd0_rx_clk_200G,             
output logic   sd1_rx_clk_200G,             
output logic   sd2_rx_clk_200G,             
output logic   sd3_rx_clk_200G,             
output logic   sd4_rx_clk_200G,             
output logic   sd5_rx_clk_200G,             
output logic   sd6_rx_clk_200G,             
output logic   sd7_rx_clk_200G,             
output logic   sd8_rx_clk_200G,             
output logic   sd9_rx_clk_200G,             
output logic   sd10_rx_clk_200G,            
output logic   sd11_rx_clk_200G,            
output logic   sd12_rx_clk_200G,            
output logic   sd13_rx_clk_200G,            
output logic   sd14_rx_clk_200G,
output logic   sd15_rx_clk_200G,

output logic   sd0_tx_clk_400G,             
output logic   sd2_tx_clk_400G,             
output logic   sd4_tx_clk_400G,             
output logic   sd6_tx_clk_400G,             
output logic   sd8_tx_clk_400G,             
output logic   sd10_tx_clk_400G,            
output logic   sd12_tx_clk_400G,            
output logic   sd14_tx_clk_400G,

output logic   sd0_rx_clk_400G,             
output logic   sd1_rx_clk_400G,             
output logic   sd2_rx_clk_400G,             
output logic   sd3_rx_clk_400G,             
output logic   sd4_rx_clk_400G,             
output logic   sd5_rx_clk_400G,             
output logic   sd6_rx_clk_400G,             
output logic   sd7_rx_clk_400G,             
output logic   sd8_rx_clk_400G,             
output logic   sd9_rx_clk_400G,             
output logic   sd10_rx_clk_400G,            
output logic   sd11_rx_clk_400G,            
output logic   sd12_rx_clk_400G,            
output logic   sd13_rx_clk_400G,            
output logic   sd14_rx_clk_400G,
output logic   sd15_rx_clk_400G,

input logic  physs_dfx_fscan_clkungate,
input logic clk_gate_en_100G_mac_pcs,
input logic power_fsm_clk_gate_en,
input logic clk_gate_en_200G_mac_pcs,
input logic clk_gate_en_400G_mac_pcs,
input  logic [3:0] serdes_tx_clk,
input  logic [3:0] serdes_rx_clk,
output logic [3:0] sd_tx_clk_cpri,
output logic [3:0] sd_rx_clk_cpri,
output logic [3:0] sd_tx_clk_100G,
output logic [3:0] sd_rx_clk_100G,

// ts signal muxing

input logic [3:0] mac100_tx_ts_val,
//input logic [5:0] mac100_tx_ts_id [3:0],
input logic [6:0] mac100_tx_ts_id_0,
input logic [6:0] mac100_tx_ts_id_1,
input logic [6:0] mac100_tx_ts_id_2,
input logic [6:0] mac100_tx_ts_id_3,
//input logic [63:0] mac100_tx_ts[3:0],
input logic [71:0] mac100_tx_ts_0,
input logic [71:0] mac100_tx_ts_1,
input logic [71:0] mac100_tx_ts_2,
input logic [71:0] mac100_tx_ts_3,
input logic mac200_tx_ts_val,
input logic [6:0] mac200_tx_ts_id,
input logic [71:0] mac200_tx_ts,
input logic mac400_tx_ts_val,
input logic [6:0] mac400_tx_ts_id,
input logic [71:0] mac400_tx_ts,
output logic [3:0] tx_ts_val,
//output logic [5:0] tx_ts_id [3:0],
output logic [6:0] tx_ts_id_0,
output logic [6:0] tx_ts_id_1,
output logic [6:0] tx_ts_id_2,
output logic [6:0] tx_ts_id_3,
//output logic [63:0] tx_ts[3:0]
output logic [71:0] tx_ts_0,
output logic [71:0] tx_ts_1,
output logic [71:0] tx_ts_2,
output logic [71:0] tx_ts_3


);

parameter LANES = 4;
reg  [127:0] sd0_rx_data_o_tmp;
reg  [127:0] sd1_rx_data_o_tmp;
reg  [127:0] sd2_rx_data_o_tmp;
reg  [127:0] sd3_rx_data_o_tmp;
reg  [31:0] sd4_rx_data_o_tmp;
reg  [31:0] sd5_rx_data_o_tmp;
reg  [31:0] sd6_rx_data_o_tmp;
reg  [31:0] sd7_rx_data_o_tmp;
reg  [31:0] sd0_rx_data_o_400G_tmp;
reg  [31:0] sd1_rx_data_o_400G_tmp;
reg  [31:0] sd2_rx_data_o_400G_tmp;
reg  [31:0] sd3_rx_data_o_400G_tmp;
reg  [31:0] sd4_rx_data_o_400G_tmp;
reg  [31:0] sd5_rx_data_o_400G_tmp;
reg  [31:0] sd6_rx_data_o_400G_tmp;
reg  [31:0] sd7_rx_data_o_400G_tmp;
reg  [31:0] sd8_rx_data_o_400G_tmp;
reg  [31:0] sd9_rx_data_o_400G_tmp;
reg  [31:0] sd10_rx_data_o_400G_tmp;
reg  [31:0] sd11_rx_data_o_400G_tmp;
reg  [31:0] sd12_rx_data_o_400G_tmp;
reg  [31:0] sd13_rx_data_o_400G_tmp;
reg  [31:0] sd14_rx_data_o_400G_tmp;
reg  [31:0] sd15_rx_data_o_400G_tmp;

reg  [127:0] sd0_tx_data_o_tmp;
reg  [127:0] sd1_tx_data_o_tmp;
reg  [127:0] sd2_tx_data_o_tmp;
reg  [127:0] sd3_tx_data_o_tmp;

reg  [127:0] serdes_cpri_or_pcs400_data_0;
reg  [127:0] serdes_cpri_or_pcs400_data_1;
reg  [127:0] serdes_cpri_or_pcs400_data_2;
reg  [127:0] serdes_cpri_or_pcs400_data_3;

assign  sd0_tx_data_o   =  cpri_sel[0] ?  serdes_cpri_or_pcs400_data_0 : sd0_tx_data_o_tmp;
assign  sd1_tx_data_o   =  cpri_sel[1] ?  serdes_cpri_or_pcs400_data_1 : sd1_tx_data_o_tmp;
assign  sd2_tx_data_o   =  cpri_sel[2] ?  serdes_cpri_or_pcs400_data_2 : sd2_tx_data_o_tmp;
assign  sd3_tx_data_o   =  cpri_sel[3] ?  serdes_cpri_or_pcs400_data_3 : sd3_tx_data_o_tmp;

assign  sd0_rx_data_o   =   sd0_rx_data_o_tmp ;
assign  sd1_rx_data_o   =   sd1_rx_data_o_tmp ;
assign  sd2_rx_data_o   =   sd2_rx_data_o_tmp ;
assign  sd3_rx_data_o   =   sd3_rx_data_o_tmp ;
assign  sd4_rx_data_o   =   sd4_rx_data_o_tmp ;
assign  sd5_rx_data_o   =   sd5_rx_data_o_tmp ;
assign  sd6_rx_data_o   =   sd6_rx_data_o_tmp ;
assign  sd7_rx_data_o   =   sd7_rx_data_o_tmp ;

assign  sd0_rx_data_400G_o   =   cpri_sel[0] ? sd0_rx_in_serdes[31:0]   : sd0_rx_data_o_400G_tmp;
assign  sd1_rx_data_400G_o   =   cpri_sel[0] ? sd0_rx_in_serdes[63:32]  : sd1_rx_data_o_400G_tmp;
assign  sd2_rx_data_400G_o   =   cpri_sel[0] ? sd0_rx_in_serdes[95:64]  : sd2_rx_data_o_400G_tmp;
assign  sd3_rx_data_400G_o   =   cpri_sel[0] ? sd0_rx_in_serdes[127:96] : sd3_rx_data_o_400G_tmp;
assign  sd4_rx_data_400G_o   =   cpri_sel[1] ? sd1_rx_in_serdes[31:0]   : sd4_rx_data_o_400G_tmp;
assign  sd5_rx_data_400G_o   =   cpri_sel[1] ? sd1_rx_in_serdes[63:32]  : sd5_rx_data_o_400G_tmp;
assign  sd6_rx_data_400G_o   =   cpri_sel[1] ? sd1_rx_in_serdes[95:64]  : sd6_rx_data_o_400G_tmp;
assign  sd7_rx_data_400G_o   =   cpri_sel[1] ? sd1_rx_in_serdes[127:96] : sd7_rx_data_o_400G_tmp;
assign  sd8_rx_data_400G_o   =   cpri_sel[2] ? sd2_rx_in_serdes[31:0]   : sd8_rx_data_o_400G_tmp;
assign  sd9_rx_data_400G_o   =   cpri_sel[2] ? sd2_rx_in_serdes[63:32]  : sd9_rx_data_o_400G_tmp;
assign  sd10_rx_data_400G_o  =   cpri_sel[2] ? sd2_rx_in_serdes[95:64]  : sd10_rx_data_o_400G_tmp;
assign  sd11_rx_data_400G_o  =   cpri_sel[2] ? sd2_rx_in_serdes[127:96] : sd11_rx_data_o_400G_tmp;
assign  sd12_rx_data_400G_o  =   cpri_sel[3] ? sd3_rx_in_serdes[31:0]   : sd12_rx_data_o_400G_tmp;
assign  sd13_rx_data_400G_o  =   cpri_sel[3] ? sd3_rx_in_serdes[63:32]  : sd13_rx_data_o_400G_tmp;
assign  sd14_rx_data_400G_o  =   cpri_sel[3] ? sd3_rx_in_serdes[95:64]  : sd14_rx_data_o_400G_tmp;
assign  sd15_rx_data_400G_o  =   cpri_sel[3] ? sd3_rx_in_serdes[127:96] : sd15_rx_data_o_400G_tmp;

assign serdes_cpri_or_pcs400_data_0   =  {sd3_tx_in_400G,sd2_tx_in_400G,sd1_tx_in_400G,sd0_tx_in_400G};
assign serdes_cpri_or_pcs400_data_1   =  {sd7_tx_in_400G,sd6_tx_in_400G,sd5_tx_in_400G,sd4_tx_in_400G};
assign serdes_cpri_or_pcs400_data_2   =  {sd11_tx_in_400G,sd10_tx_in_400G,sd9_tx_in_400G,sd8_tx_in_400G};
assign serdes_cpri_or_pcs400_data_3   =  {sd15_tx_in_400G,sd14_tx_in_400G,sd13_tx_in_400G,sd12_tx_in_400G};

logic   sd0_tx_clk_400G_int;             
logic   sd4_tx_clk_400G_int;             
logic   sd8_tx_clk_400G_int;             
logic   sd12_tx_clk_400G_int;             
logic   sd0_rx_clk_400G_int;             
logic   sd4_rx_clk_400G_int;             
logic   sd8_rx_clk_400G_int;             
logic   sd12_rx_clk_400G_int;             

logic sd0_tx_clk_200G_int;
logic sd4_tx_clk_200G_int;
logic sd0_rx_clk_200G_int;
logic sd4_rx_clk_200G_int;

logic [3:0] sd_rx_clk_100G_temp;
logic sd0_rx_clk_400G_temp;
logic sd4_rx_clk_400G_temp;
logic sd8_rx_clk_400G_temp;
logic sd12_rx_clk_400G_temp;
logic sd0_rx_clk_200G_temp;
logic sd4_rx_clk_200G_temp;
logic clk_gate_en_100G;


assign clk_gate_en_100G = clk_gate_en_100G_mac_pcs ? 1'b0 : ~power_fsm_clk_gate_en;

genvar i;
generate
//
    for ( i=0; i < LANES; i++) begin : clk_gate

     ctech_lib_clk_gate_te clk_gate_tx (
     .clkout(sd_tx_clk_100G[i]),
     .en(clk_gate_en_100G & ~pcs_lane_sel[1] & ~cpri_sel[i]),
     .te(physs_dfx_fscan_clkungate),
     .clk(serdes_tx_clk[i])
    );
  
     ctech_lib_clk_gate_te clk_gate_rx (
     .clkout(sd_rx_clk_100G_temp[i]),
     .en(clk_gate_en_100G & ~pcs_lane_sel[1] & ~cpri_sel[i]),
     .te(physs_dfx_fscan_clkungate),
     .clk(serdes_rx_clk[i])
    );

    ctech_lib_clk_mux_2to1 sd_rx_clk_mux (
     .clk2(sd_rx_clk_100G_temp[i] ),
     .clk1(sd_tx_clk_100G[i]),
     .s(1 & ~fscan_mode),
     .clkout(sd_rx_clk_100G[i]) 
    );

     ctech_lib_clk_gate_te clk_gate0_tx (
     .clkout(sd_tx_clk_cpri[i]),
     .en(cpri_sel[i]),
     .te(physs_dfx_fscan_clkungate),
     .clk(serdes_tx_clk[i])
    );
  
     ctech_lib_clk_gate_te clk_gate0_rx (
     .clkout(sd_rx_clk_cpri[i]),
     .en(cpri_sel[i]),
     .te(physs_dfx_fscan_clkungate),
     .clk(serdes_rx_clk[i])
    );





   end 
endgenerate

/// Clk muxing for 400G PCS

     ctech_lib_clk_mux_2to1 sd0_tx_400_clk_mux (
    	.clk2(serdes_tx_clk[0] ),
    	.clk1(serdes_tx_clk[2]),
    	.s(pcs_lane_sel[0]),
    	.clkout(sd0_tx_clk_400G_int)
    	);

     ctech_lib_clk_gate_te clk_gate_sd0_tx_400 (
     .clkout(sd0_tx_clk_400G),
     .en(clk_gate_en_400G_mac_pcs & pcs_lane_sel[1]),
     .te(physs_dfx_fscan_clkungate),
     .clk(sd0_tx_clk_400G_int)
    );

assign sd2_tx_clk_400G = sd0_tx_clk_400G;

     ctech_lib_clk_mux_2to1 sd4_tx_400_clk_mux (
    	.clk2(serdes_tx_clk[1] ),
    	.clk1(serdes_tx_clk[3]),
    	.s(pcs_lane_sel[0]),
    	.clkout(sd4_tx_clk_400G_int)
    	);

     ctech_lib_clk_gate_te clk_gate_sd4_tx_400 (
     .clkout(sd4_tx_clk_400G),
     .en(clk_gate_en_400G_mac_pcs & pcs_lane_sel[1]),
     .te(physs_dfx_fscan_clkungate),
     .clk(sd4_tx_clk_400G_int)
    );

assign sd6_tx_clk_400G = sd4_tx_clk_400G;


     ctech_lib_clk_mux_2to1 sd8_tx_400_clk_mux (
    	.clk2(serdes_tx_clk[2] ),
    	.clk1(serdes_tx_clk[0]),
    	.s(pcs_lane_sel[0]),
    	.clkout(sd8_tx_clk_400G_int)
    	);

     ctech_lib_clk_gate_te clk_gate_sd8_tx_400 (
     .clkout(sd8_tx_clk_400G),
     .en(clk_gate_en_400G_mac_pcs & pcs_lane_sel[1]),
     .te(physs_dfx_fscan_clkungate),
     .clk(sd8_tx_clk_400G_int)
    );

assign sd10_tx_clk_400G = sd8_tx_clk_400G;

     ctech_lib_clk_mux_2to1 sd12_tx_400_clk_mux (
    	.clk2(serdes_tx_clk[3] ),
    	.clk1(serdes_tx_clk[0]),
    	.s(pcs_lane_sel[0]),
    	.clkout(sd12_tx_clk_400G_int)
    	);

     ctech_lib_clk_gate_te clk_gate_sd12_tx_400 (
     .clkout(sd12_tx_clk_400G),
     .en(clk_gate_en_400G_mac_pcs & pcs_lane_sel[1]),
     .te(physs_dfx_fscan_clkungate),
     .clk(sd12_tx_clk_400G_int)
    );

assign sd14_tx_clk_400G = sd12_tx_clk_400G;


     ctech_lib_clk_mux_2to1 sd0_rx_400_clk_mux (
    	.clk2(serdes_rx_clk[0] ),
    	.clk1(serdes_rx_clk[2]),
    	.s(pcs_lane_sel[0]),
    	.clkout(sd0_rx_clk_400G_int)
    	);

     ctech_lib_clk_gate_te clk_gate_sd0_rx_400 (
     .clkout(sd0_rx_clk_400G_temp),
     .en(clk_gate_en_400G_mac_pcs & pcs_lane_sel[1]),
     .te(physs_dfx_fscan_clkungate),
     .clk(sd0_rx_clk_400G_int)
    );

    ctech_lib_clk_mux_2to1 sd0_rx_clk_mux_400 (
    .clk2(sd0_rx_clk_400G_temp),
    .clk1(sd0_tx_clk_400G),
    .s(1 & ~fscan_mode),
    .clkout(sd0_rx_clk_400G) 
    );




assign sd1_rx_clk_400G = sd0_rx_clk_400G;
assign sd2_rx_clk_400G = sd0_rx_clk_400G;
assign sd3_rx_clk_400G = sd0_rx_clk_400G;

     ctech_lib_clk_mux_2to1 sd4_rx_400_clk_mux (
    	.clk2(serdes_rx_clk[1] ),
    	.clk1(serdes_rx_clk[3]),
    	.s(pcs_lane_sel[0]),
    	.clkout(sd4_rx_clk_400G_int)
    	);

     ctech_lib_clk_gate_te clk_gate_sd4_rx_400 (
     .clkout(sd4_rx_clk_400G_temp),
     .en(clk_gate_en_400G_mac_pcs & pcs_lane_sel[1]),
     .te(physs_dfx_fscan_clkungate),
     .clk(sd4_rx_clk_400G_int)
    );

    ctech_lib_clk_mux_2to1 sd4_rx_clk_mux_400 (
    .clk2(sd4_rx_clk_400G_temp),
    .clk1(sd4_tx_clk_400G),
    .s(pcs_external_loopback_en[1] & ~fscan_mode),
    .clkout(sd4_rx_clk_400G) 
    );

assign sd5_rx_clk_400G = sd4_rx_clk_400G;
assign sd6_rx_clk_400G = sd4_rx_clk_400G;
assign sd7_rx_clk_400G = sd4_rx_clk_400G;


     ctech_lib_clk_mux_2to1 sd8_rx_400_clk_mux (
    	.clk2(serdes_rx_clk[2] ),
    	.clk1(serdes_rx_clk[0]),
    	.s(pcs_lane_sel[0]),
    	.clkout(sd8_rx_clk_400G_int)
    	);

     ctech_lib_clk_gate_te clk_gate_sd8_rx_400 (
     .clkout(sd8_rx_clk_400G_temp),
     .en(clk_gate_en_400G_mac_pcs & pcs_lane_sel[1]),
     .te(physs_dfx_fscan_clkungate),
     .clk(sd8_rx_clk_400G_int)
    );

    ctech_lib_clk_mux_2to1 sd8_rx_clk_mux_400 (
    .clk2(sd8_rx_clk_400G_temp),
    .clk1(sd8_tx_clk_400G),
    .s(pcs_external_loopback_en[2] & ~fscan_mode),
    .clkout(sd8_rx_clk_400G) 
    );

assign sd9_rx_clk_400G = sd8_rx_clk_400G;
assign sd10_rx_clk_400G = sd8_rx_clk_400G;
assign sd11_rx_clk_400G = sd8_rx_clk_400G;

     ctech_lib_clk_mux_2to1 sd12_rx_400_clk_mux (
    	.clk2(serdes_rx_clk[3] ),
    	.clk1(serdes_rx_clk[0]),
    	.s(pcs_lane_sel[0]),
    	.clkout(sd12_rx_clk_400G_int)
    	);

     ctech_lib_clk_gate_te clk_gate_sd12_rx_400 (
     .clkout(sd12_rx_clk_400G_temp),
     .en(clk_gate_en_400G_mac_pcs & pcs_lane_sel[1]),
     .te(physs_dfx_fscan_clkungate),
     .clk(sd12_rx_clk_400G_int)
    );

    ctech_lib_clk_mux_2to1 sd12_rx_clk_mux_400 (
    .clk2(sd12_rx_clk_400G_temp),
    .clk1(sd12_tx_clk_400G),
    .s(pcs_external_loopback_en[3] & ~fscan_mode),
    .clkout(sd12_rx_clk_400G) 
    );

assign sd13_rx_clk_400G = sd12_rx_clk_400G;
assign sd14_rx_clk_400G = sd12_rx_clk_400G;
assign sd15_rx_clk_400G = sd12_rx_clk_400G;


/// Clk muxing for 200G PCS

     ctech_lib_clk_mux_2to1 sd0_tx_200_clk_mux (
    	.clk2(serdes_tx_clk[0] ),
    	.clk1(serdes_tx_clk[2]),
    	.s(pcs_lane_sel[0]),
    	.clkout(sd0_tx_clk_200G_int)
    	);

     ctech_lib_clk_gate_te clk_gate_sd0_tx_200 (
     .clkout(sd0_tx_clk_200G),
     .en(clk_gate_en_200G_mac_pcs & pcs_lane_sel[1]),
     .te(physs_dfx_fscan_clkungate),
     .clk(sd0_tx_clk_200G_int)
    );

assign sd2_tx_clk_200G = sd0_tx_clk_200G;

     ctech_lib_clk_mux_2to1 sd4_tx_200_clk_mux (
    	.clk2(serdes_tx_clk[1] ),
    	.clk1(serdes_tx_clk[3]),
    	.s(pcs_lane_sel[0]),
    	.clkout(sd4_tx_clk_200G_int)
    	);

     ctech_lib_clk_gate_te clk_gate_sd4_tx_200 (
     .clkout(sd4_tx_clk_200G),
     .en(clk_gate_en_200G_mac_pcs & pcs_lane_sel[1]),
     .te(physs_dfx_fscan_clkungate),
     .clk(sd4_tx_clk_200G_int)
    );

assign sd6_tx_clk_200G = sd4_tx_clk_200G;

assign sd8_tx_clk_200G = 1'b0;
assign sd10_tx_clk_200G = 1'b0;
assign sd12_tx_clk_200G = 1'b0;
assign sd14_tx_clk_200G = 1'b0;


     ctech_lib_clk_mux_2to1 sd0_rx_200_clk_mux (
    	.clk2(serdes_rx_clk[0] ),
    	.clk1(serdes_rx_clk[2]),
    	.s(pcs_lane_sel[0]),
    	.clkout(sd0_rx_clk_200G_int)
    	);

     ctech_lib_clk_gate_te clk_gate_sd0_rx_200 (
     .clkout(sd0_rx_clk_200G_temp),
     .en(clk_gate_en_200G_mac_pcs & pcs_lane_sel[1]),
     .te(physs_dfx_fscan_clkungate),
     .clk(sd0_rx_clk_200G_int)
    );

    ctech_lib_clk_mux_2to1 sd0_rx_clk_mux_200 (
    .clk2(sd0_rx_clk_200G_temp),
    .clk1(sd0_tx_clk_200G),
    .s(pcs_external_loopback_en[1] & ~fscan_mode),
    .clkout(sd0_rx_clk_200G) 
    );

assign sd1_rx_clk_200G = sd0_rx_clk_200G;
assign sd2_rx_clk_200G = sd0_rx_clk_200G;
assign sd3_rx_clk_200G = sd0_rx_clk_200G;

     ctech_lib_clk_mux_2to1 sd4_rx_200_clk_mux (
    	.clk2(serdes_rx_clk[1] ),
    	.clk1(serdes_rx_clk[3]),
    	.s(pcs_lane_sel[0]),
    	.clkout(sd4_rx_clk_200G_int)
    	);

     ctech_lib_clk_gate_te clk_gate_sd4_rx_200 (
     .clkout(sd4_rx_clk_200G_temp),
     .en(clk_gate_en_200G_mac_pcs & pcs_lane_sel[1]),
     .te(physs_dfx_fscan_clkungate),
     .clk(sd4_rx_clk_200G_int)
    );

    ctech_lib_clk_mux_2to1 sd4_rx_clk_mux_200 (
    .clk2(sd4_rx_clk_200G_temp),
    .clk1(sd4_tx_clk_200G),
    .s(pcs_external_loopback_en[1] & ~fscan_mode),
    .clkout(sd4_rx_clk_200G) 
    );

assign sd5_rx_clk_200G = sd4_rx_clk_200G;
assign sd6_rx_clk_200G = sd4_rx_clk_200G;
assign sd7_rx_clk_200G = sd4_rx_clk_200G;

assign sd8_rx_clk_200G = 1'b0;
assign sd9_rx_clk_200G = 1'b0;
assign sd10_rx_clk_200G = 1'b0;
assign sd11_rx_clk_200G = 1'b0;
assign sd12_rx_clk_200G = 1'b0;
assign sd13_rx_clk_200G = 1'b0;
assign sd14_rx_clk_200G = 1'b0;
assign sd15_rx_clk_200G = 1'b0;

always_comb begin 
case(pcs_lane_sel)   
  2'b00,2'b01 : begin  //100G 4x64 
           sd0_tx_data_o_tmp =  sd0_tx_in_100G;
           sd1_tx_data_o_tmp =  sd1_tx_in_100G;
           sd2_tx_data_o_tmp =  sd2_tx_in_100G;
           sd3_tx_data_o_tmp =  sd3_tx_in_100G;
           sd0_rx_data_o_tmp =  sd0_rx_in_serdes;
           sd1_rx_data_o_tmp =  sd1_rx_in_serdes;
           sd2_rx_data_o_tmp =  sd2_rx_in_serdes;
           sd3_rx_data_o_tmp =  sd3_rx_in_serdes;
           sd4_rx_data_o_tmp =          32'b0;
           sd5_rx_data_o_tmp =          32'b0;
           sd6_rx_data_o_tmp =          32'b0;
           sd7_rx_data_o_tmp =          32'b0;
           sd0_rx_data_o_400G_tmp =     32'b0;
           sd1_rx_data_o_400G_tmp =     32'b0;
           sd2_rx_data_o_400G_tmp =     32'b0;
           sd3_rx_data_o_400G_tmp =     32'b0;
           sd4_rx_data_o_400G_tmp =     32'b0;
           sd5_rx_data_o_400G_tmp =     32'b0;
           sd6_rx_data_o_400G_tmp =     32'b0;
           sd7_rx_data_o_400G_tmp =     32'b0;
           sd8_rx_data_o_400G_tmp =     32'b0;
           sd9_rx_data_o_400G_tmp =     32'b0;
           sd10_rx_data_o_400G_tmp =    32'b0;
           sd11_rx_data_o_400G_tmp =    32'b0;
           sd12_rx_data_o_400G_tmp =    32'b0;
           sd13_rx_data_o_400G_tmp =    32'b0;
           sd14_rx_data_o_400G_tmp =    32'b0;
           sd15_rx_data_o_400G_tmp =    32'b0;
 	   tx_ts_val               =    mac100_tx_ts_val;
           tx_ts_id_0              =    mac100_tx_ts_id_0;
           tx_ts_id_1              =    mac100_tx_ts_id_1;
           tx_ts_id_2              =    mac100_tx_ts_id_2;
           tx_ts_id_3              =    mac100_tx_ts_id_3;
           tx_ts_0                 =    mac100_tx_ts_0;
           tx_ts_1                 =    mac100_tx_ts_1;
           tx_ts_2                 =    mac100_tx_ts_2;
           tx_ts_3                 =    mac100_tx_ts_3;

//           sd_tx_clk_100G        =      serdes_tx_clk_gated;
//           sd_rx_clk_100G        =      serdes_rx_clk_gated;
//           sd0_tx_clk_200G       =   'b0;
//           sd2_tx_clk_200G       =   'b0;
//           sd4_tx_clk_200G       =   'b0;
//           sd6_tx_clk_200G       =   'b0;
//           sd8_tx_clk_200G       =   'b0;
//           sd10_tx_clk_200G      =   'b0;
//           sd12_tx_clk_200G      =   'b0;
//           sd14_tx_clk_200G      =   'b0;
//           sd0_rx_clk_200G       =   'b0;
//           sd1_rx_clk_200G       =   'b0;
//           sd2_rx_clk_200G       =   'b0;
//           sd3_rx_clk_200G       =   'b0;
//           sd4_rx_clk_200G       =   'b0;
//           sd5_rx_clk_200G       =   'b0;
//           sd6_rx_clk_200G       =   'b0;
//           sd7_rx_clk_200G       =   'b0;
//           sd8_rx_clk_200G       =   'b0;
//           sd9_rx_clk_200G      =    'b0;
//           sd10_rx_clk_200G      =   'b0;
//           sd11_rx_clk_200G      =   'b0;
//           sd12_rx_clk_200G      =   'b0;
//           sd13_rx_clk_200G      =   'b0;
//           sd14_rx_clk_200G      =   'b0;
//           sd15_rx_clk_200G      =   'b0;
//           sd0_tx_clk_400G       =   'b0;
//           sd2_tx_clk_400G       =   'b0;
//           sd4_tx_clk_400G       =   'b0;
//           sd6_tx_clk_400G       =   'b0;
//           sd8_tx_clk_400G       =   'b0;
//           sd10_tx_clk_400G      =   'b0;
//           sd12_tx_clk_400G      =   'b0;
//           sd14_tx_clk_400G      =   'b0;
//           sd0_rx_clk_400G       =   'b0;
//           sd1_rx_clk_400G       =   'b0;
//           sd2_rx_clk_400G       =   'b0;
//           sd3_rx_clk_400G       =   'b0;
//           sd4_rx_clk_400G       =   'b0;
//           sd5_rx_clk_400G       =   'b0;
//           sd6_rx_clk_400G       =   'b0;
//           sd7_rx_clk_400G       =   'b0;
//           sd8_rx_clk_400G       =   'b0;
//           sd9_rx_clk_400G      =    'b0;
//           sd10_rx_clk_400G      =   'b0;
//           sd11_rx_clk_400G      =   'b0;
//           sd12_rx_clk_400G      =   'b0;
//           sd13_rx_clk_400G      =   'b0;
//           sd14_rx_clk_400G      =   'b0;
//           sd15_rx_clk_400G      =   'b0;
           link_status_out       =   link_status_100G;
           srds_rdy_out_100G     =   serdes_rdy_in;
           srds_rdy_out_200G     =   'b0;
           srds_rdy_out_400G     =   'b0;
          end 
  2'b10 : begin //400G 16x32 
           sd0_tx_data_o_tmp =               serdes_cpri_or_pcs400_data_0[127:0]  ;
           sd1_tx_data_o_tmp =               serdes_cpri_or_pcs400_data_1[127:0]  ;
           sd2_tx_data_o_tmp =               serdes_cpri_or_pcs400_data_2[127:0]  ;
           sd3_tx_data_o_tmp =               serdes_cpri_or_pcs400_data_3[127:0]  ;
           sd0_rx_data_o_tmp =               128'b0;
           sd1_rx_data_o_tmp =               128'b0;
           sd2_rx_data_o_tmp =               128'b0;
           sd3_rx_data_o_tmp =               128'b0;
           sd4_rx_data_o_tmp =               'b0;
           sd5_rx_data_o_tmp =               'b0;
           sd6_rx_data_o_tmp =               'b0;
           sd7_rx_data_o_tmp =               'b0;
           sd0_rx_data_o_400G_tmp =          sd0_rx_in_serdes[31:0]  ;
           sd1_rx_data_o_400G_tmp =          sd0_rx_in_serdes[63:32] ;
           sd2_rx_data_o_400G_tmp =          sd0_rx_in_serdes[95:64] ;
           sd3_rx_data_o_400G_tmp =          sd0_rx_in_serdes[127:96];
           sd4_rx_data_o_400G_tmp =          sd1_rx_in_serdes[31:0]  ;
           sd5_rx_data_o_400G_tmp =          sd1_rx_in_serdes[63:32] ;
           sd6_rx_data_o_400G_tmp =          sd1_rx_in_serdes[95:64] ;
           sd7_rx_data_o_400G_tmp =          sd1_rx_in_serdes[127:96];
           sd8_rx_data_o_400G_tmp =          sd2_rx_in_serdes[31:0]  ;
           sd9_rx_data_o_400G_tmp =          sd2_rx_in_serdes[63:32] ;
           sd10_rx_data_o_400G_tmp =         sd2_rx_in_serdes[95:64] ;
           sd11_rx_data_o_400G_tmp =         sd2_rx_in_serdes[127:96];
           sd12_rx_data_o_400G_tmp =         sd3_rx_in_serdes[31:0]  ;
           sd13_rx_data_o_400G_tmp =         sd3_rx_in_serdes[63:32] ;
           sd14_rx_data_o_400G_tmp =         sd3_rx_in_serdes[95:64] ;
           sd15_rx_data_o_400G_tmp =         sd3_rx_in_serdes[127:96];
 	       tx_ts_val           =             {3'b0 , mac400_tx_ts_val} ;
           tx_ts_id_0             =          mac400_tx_ts_id;
           tx_ts_0                =          mac400_tx_ts;
           tx_ts_id_1             =          'b0;
           tx_ts_1               =           'b0;
           tx_ts_id_2             =          'b0;
           tx_ts_2                =          'b0;
           tx_ts_id_3             =          'b0;
           tx_ts_3                =          'b0; 
//           sd0_tx_clk_400G       =           serdes_tx_clk_gated[0];
//           sd2_tx_clk_400G       =           serdes_tx_clk_gated[0];
//           sd4_tx_clk_400G       =           serdes_tx_clk_gated[1];
//           sd6_tx_clk_400G       =           serdes_tx_clk_gated[1];
//           sd8_tx_clk_400G       =           serdes_tx_clk_gated[2];
//           sd10_tx_clk_400G      =           serdes_tx_clk_gated[2];
//           sd12_tx_clk_400G      =           serdes_tx_clk_gated[3];
//           sd14_tx_clk_400G      =           serdes_tx_clk_gated[3];
//           sd0_rx_clk_400G       =           serdes_rx_clk_gated[0];
//           sd1_rx_clk_400G       =           serdes_rx_clk_gated[0];
//           sd2_rx_clk_400G       =           serdes_rx_clk_gated[0];
//           sd3_rx_clk_400G       =           serdes_rx_clk_gated[0];
//           sd4_rx_clk_400G       =           serdes_rx_clk_gated[1];
//           sd5_rx_clk_400G       =           serdes_rx_clk_gated[1];
//           sd6_rx_clk_400G       =           serdes_rx_clk_gated[1];
//           sd7_rx_clk_400G       =           serdes_rx_clk_gated[1];
//           sd8_rx_clk_400G       =           serdes_rx_clk_gated[2];
//           sd9_rx_clk_400G       =           serdes_rx_clk_gated[2];
//           sd10_rx_clk_400G      =           serdes_rx_clk_gated[2];
//           sd10_rx_clk_400G      =           serdes_rx_clk_gated[2];
//           sd11_rx_clk_400G      =           serdes_rx_clk_gated[3];
//           sd12_rx_clk_400G      =           serdes_rx_clk_gated[3];
//           sd13_rx_clk_400G      =           serdes_rx_clk_gated[3];
//           sd14_rx_clk_400G      =           serdes_rx_clk_gated[3];
//           sd15_rx_clk_400G      =           serdes_rx_clk_gated[3];
//           sd0_tx_clk_200G       =           'b0;
//           sd2_tx_clk_200G       =           'b0;
//           sd4_tx_clk_200G       =           'b0;
//           sd6_tx_clk_200G       =           'b0;
//           sd8_tx_clk_200G       =           'b0;
//           sd10_tx_clk_200G      =           'b0;
//           sd12_tx_clk_200G      =           'b0;
//           sd14_tx_clk_200G      =           'b0;
//           sd0_rx_clk_200G       =           'b0;
//           sd1_rx_clk_200G       =           'b0;
//           sd2_rx_clk_200G       =           'b0;
//           sd3_rx_clk_200G       =           'b0;
//           sd4_rx_clk_200G       =           'b0;
//           sd5_rx_clk_200G       =           'b0;
//           sd6_rx_clk_200G       =           'b0;
//           sd7_rx_clk_200G       =           'b0;
//           sd8_rx_clk_200G       =           'b0;
//           sd9_rx_clk_200G       =           'b0;
//           sd10_rx_clk_200G      =           'b0;
//           sd10_rx_clk_200G      =           'b0;
//           sd11_rx_clk_200G      =           'b0;
//           sd12_rx_clk_200G      =           'b0;
//           sd13_rx_clk_200G      =           'b0;
//           sd14_rx_clk_200G      =           'b0;
//           sd15_rx_clk_200G      =           'b0;
//           sd_tx_clk_100G        =           'b0;
//           sd_rx_clk_100G        =           'b0;
           link_status_out       =   {link_status_400G,link_status_400G,link_status_400G,link_status_400G};
           srds_rdy_out_100G     =   'b0;
           srds_rdy_out_200G     =   'b0;
           srds_rdy_out_400G     =   serdes_rdy_in[3] | serdes_rdy_in[2] | serdes_rdy_in[1] | serdes_rdy_in[0];
          end 
  2'b11 : begin  //2x200G (200G & 400G)
           sd0_tx_data_o_tmp = {sd3_tx_in_200G,sd2_tx_in_200G,sd1_tx_in_200G,sd0_tx_in_200G};
           sd1_tx_data_o_tmp = {sd7_tx_in_200G,sd6_tx_in_200G,sd5_tx_in_200G,sd4_tx_in_200G};
           sd2_tx_data_o_tmp = {sd3_tx_in_400G,sd2_tx_in_400G,sd1_tx_in_400G,sd0_tx_in_400G};
           sd3_tx_data_o_tmp = {sd7_tx_in_400G,sd6_tx_in_400G,sd5_tx_in_400G,sd4_tx_in_400G};
           sd0_rx_data_o_tmp[31:0] =  sd0_rx_in_serdes [31:0]  ;
           sd1_rx_data_o_tmp[31:0] =  sd0_rx_in_serdes [63:32] ;
           sd2_rx_data_o_tmp[31:0] =  sd0_rx_in_serdes [95:64] ;
           sd3_rx_data_o_tmp[31:0] =  sd0_rx_in_serdes [127:96];
           sd0_rx_data_o_tmp[127:32] =  96'b0;
           sd1_rx_data_o_tmp[127:32] =  96'b0;
           sd2_rx_data_o_tmp[127:32] =  96'b0;
           sd3_rx_data_o_tmp[127:32] =  96'b0;
           sd4_rx_data_o_tmp =  sd1_rx_in_serdes [31:0]  ;
           sd5_rx_data_o_tmp =  sd1_rx_in_serdes [63:32] ;
           sd6_rx_data_o_tmp =  sd1_rx_in_serdes [95:64] ;
           sd7_rx_data_o_tmp =  sd1_rx_in_serdes [127:96];
           sd0_rx_data_o_400G_tmp =  sd2_rx_in_serdes [31:0]  ;
           sd1_rx_data_o_400G_tmp =  sd2_rx_in_serdes [63:32] ;
           sd2_rx_data_o_400G_tmp =  sd2_rx_in_serdes [95:64] ;
           sd3_rx_data_o_400G_tmp =  sd2_rx_in_serdes [127:96];
           sd4_rx_data_o_400G_tmp =  sd3_rx_in_serdes [31:0]  ;
           sd5_rx_data_o_400G_tmp =  sd3_rx_in_serdes [63:32] ;
           sd6_rx_data_o_400G_tmp =  sd3_rx_in_serdes [95:64] ;
           sd7_rx_data_o_400G_tmp =  sd3_rx_in_serdes [127:96];
           sd8_rx_data_o_400G_tmp =  sd3_rx_in_serdes [127:96];
           sd9_rx_data_o_400G_tmp =  sd3_rx_in_serdes [127:96];
           sd10_rx_data_o_400G_tmp =  32'b0;
           sd11_rx_data_o_400G_tmp =  32'b0;
           sd12_rx_data_o_400G_tmp =  32'b0;
           sd13_rx_data_o_400G_tmp =  32'b0;
           sd14_rx_data_o_400G_tmp =  32'b0;
           sd15_rx_data_o_400G_tmp =  32'b0;
 	       tx_ts_val            =          {1'b0, mac400_tx_ts_val, 1'b0, mac200_tx_ts_val}  ;
           tx_ts_id_0             =   mac200_tx_ts_id;
           tx_ts_0                =   mac200_tx_ts;
           tx_ts_id_1             =   'b0;
           tx_ts_1                =   'b0;
           tx_ts_id_2             =   mac400_tx_ts_id;
           tx_ts_2                =   mac400_tx_ts;
           tx_ts_id_3             =   'b0;
           tx_ts_3                =   'b0;
//           sd_tx_clk_100G        =  'b0;
//           sd_rx_clk_100G        =  'b0;
//           sd0_tx_clk_200G       =   serdes_tx_clk_gated[0];
//           sd2_tx_clk_200G       =   serdes_tx_clk_gated[0];
//           sd4_tx_clk_200G       =   serdes_tx_clk_gated[1];
//           sd6_tx_clk_200G       =   serdes_tx_clk_gated[1];
//           sd8_tx_clk_200G       =   'b0;
//           sd10_tx_clk_200G      =   'b0;
//           sd12_tx_clk_200G      =   'b0;
//           sd14_tx_clk_200G      =   'b0;
//           sd0_rx_clk_200G       =   serdes_rx_clk_gated[0];
//           sd1_rx_clk_200G       =   serdes_rx_clk_gated[0];
//           sd2_rx_clk_200G       =   serdes_rx_clk_gated[0];
//           sd3_rx_clk_200G       =   serdes_rx_clk_gated[0];
//           sd4_rx_clk_200G       =   serdes_rx_clk_gated[1];
//           sd5_rx_clk_200G       =   serdes_rx_clk_gated[1];
//           sd6_rx_clk_200G       =   serdes_rx_clk_gated[1];
//           sd7_rx_clk_200G       =   serdes_rx_clk_gated[1];
//           sd8_rx_clk_200G       =   'b0;
//           sd9_rx_clk_200G       =   'b0;
//           sd10_rx_clk_200G      =   'b0;
//           sd11_rx_clk_200G      =   'b0;
//           sd12_rx_clk_200G      =   'b0;
//           sd13_rx_clk_200G      =   'b0;
//           sd14_rx_clk_200G      =   'b0;
//           sd15_rx_clk_200G      =   'b0;
//           sd0_tx_clk_400G       =   serdes_tx_clk_gated[2];
//           sd2_tx_clk_400G       =   serdes_tx_clk_gated[2];
//           sd4_tx_clk_400G       =   serdes_tx_clk_gated[3];
//           sd6_tx_clk_400G       =   serdes_tx_clk_gated[3];
//           sd8_tx_clk_400G       =   'b0;
//           sd10_tx_clk_400G      =   'b0;
//           sd12_tx_clk_400G      =   'b0;
//           sd14_tx_clk_400G      =   'b0;
//           sd0_rx_clk_400G       =   serdes_rx_clk_gated[2];
//           sd1_rx_clk_400G       =   serdes_rx_clk_gated[2];
//           sd2_rx_clk_400G       =   serdes_rx_clk_gated[2];
//           sd3_rx_clk_400G       =   serdes_rx_clk_gated[2];
//           sd4_rx_clk_400G       =   serdes_rx_clk_gated[3];
//           sd4_rx_clk_400G       =   serdes_rx_clk_gated[3];
//           sd6_rx_clk_400G       =   serdes_rx_clk_gated[3];
//           sd5_rx_clk_400G       =   serdes_rx_clk_gated[3];
//           sd8_rx_clk_400G       =   'b0;
//           sd9_rx_clk_400G       =   'b0;
//           sd10_rx_clk_400G      =   'b0;
//           sd11_rx_clk_400G      =   'b0;
//           sd12_rx_clk_400G      =   'b0;
//           sd13_rx_clk_400G      =   'b0;
//           sd14_rx_clk_200G      =   'b0;
//           sd15_rx_clk_200G      =   'b0;
           link_status_out       =   {link_status_400G,link_status_400G,link_status_200G,link_status_200G};
           srds_rdy_out_100G     =   'b0;
           srds_rdy_out_200G     =   serdes_rdy_in[1] | serdes_rdy_in[0];
           srds_rdy_out_400G     =   serdes_rdy_in[3] | serdes_rdy_in[2];
          end 
  default: begin //100G 4x64
           sd0_tx_data_o_tmp =  sd0_tx_in_100G;
           sd1_tx_data_o_tmp =  sd1_tx_in_100G;
           sd2_tx_data_o_tmp =  sd2_tx_in_100G;
           sd3_tx_data_o_tmp =  sd3_tx_in_100G;
           sd0_rx_data_o_tmp =  sd0_rx_in_serdes;  
           sd1_rx_data_o_tmp =  sd0_rx_in_serdes;
           sd2_rx_data_o_tmp =  sd1_rx_in_serdes;  
           sd3_rx_data_o_tmp =  sd1_rx_in_serdes;
           sd4_rx_data_o_tmp =          32'b0;
           sd5_rx_data_o_tmp =          32'b0;
           sd6_rx_data_o_tmp =          32'b0;
           sd7_rx_data_o_tmp =          32'b0;
           sd0_rx_data_o_400G_tmp =     32'b0;
           sd1_rx_data_o_400G_tmp =     32'b0;
           sd2_rx_data_o_400G_tmp =     32'b0;
           sd3_rx_data_o_400G_tmp =     32'b0;
           sd4_rx_data_o_400G_tmp =     32'b0;
           sd5_rx_data_o_400G_tmp =     32'b0;
           sd6_rx_data_o_400G_tmp =     32'b0;
           sd7_rx_data_o_400G_tmp =     32'b0;
           sd8_rx_data_o_400G_tmp =     32'b0;
           sd9_rx_data_o_400G_tmp =     32'b0;
           sd10_rx_data_o_400G_tmp =    32'b0;
           sd11_rx_data_o_400G_tmp =    32'b0;
           sd12_rx_data_o_400G_tmp =    32'b0;
           sd13_rx_data_o_400G_tmp =    32'b0;
           sd14_rx_data_o_400G_tmp =    32'b0;
           sd15_rx_data_o_400G_tmp =    32'b0;
 	       tx_ts_val               =    mac100_tx_ts_val;
           tx_ts_id_0              =    mac100_tx_ts_id_0;
           tx_ts_id_1              =    mac100_tx_ts_id_1;
           tx_ts_id_2              =    mac100_tx_ts_id_2;
           tx_ts_id_3              =    mac100_tx_ts_id_3;
           tx_ts_0                 =    mac100_tx_ts_0;
           tx_ts_1                 =    mac100_tx_ts_1;
           tx_ts_2                 =    mac100_tx_ts_2;
           tx_ts_3                 =    mac100_tx_ts_3;
//           sd_tx_clk_100G        =    serdes_tx_clk_gated;
//           sd_rx_clk_100G        =    serdes_rx_clk_gated;
//           sd0_tx_clk_200G       =   'b0;
//           sd2_tx_clk_200G       =   'b0;
//           sd4_tx_clk_200G       =   'b0;
//           sd6_tx_clk_200G       =   'b0;
//           sd8_tx_clk_200G       =   'b0;
//           sd10_tx_clk_200G      =   'b0;
//           sd12_tx_clk_200G      =   'b0;
//           sd14_tx_clk_200G      =   'b0;
//           sd0_rx_clk_200G       =   'b0;
//           sd2_rx_clk_200G       =   'b0;
//           sd4_rx_clk_200G       =   'b0;
//           sd6_rx_clk_200G       =   'b0;
//           sd8_rx_clk_200G       =   'b0;
//           sd10_rx_clk_200G      =   'b0;
//           sd12_rx_clk_200G      =   'b0;
//           sd14_rx_clk_200G      =   'b0;
//           sd0_rx_clk_200G       =   'b0;
//           sd1_rx_clk_200G       =   'b0;
//           sd2_rx_clk_200G       =   'b0;
//           sd3_rx_clk_200G       =   'b0;
//           sd4_rx_clk_200G       =   'b0;
//           sd5_rx_clk_200G       =   'b0;
//           sd6_rx_clk_200G       =   'b0;
//           sd7_rx_clk_200G       =   'b0;
//           sd8_rx_clk_200G       =   'b0;
//           sd9_rx_clk_200G      =    'b0;
//           sd10_rx_clk_200G      =   'b0;
//           sd11_rx_clk_200G      =   'b0;
//           sd12_rx_clk_200G      =   'b0;
//           sd13_rx_clk_200G      =   'b0;
//           sd14_rx_clk_200G      =   'b0;
//           sd15_rx_clk_200G      =   'b0;
//           sd0_tx_clk_400G       =   'b0;
//           sd2_tx_clk_400G       =   'b0;
//           sd4_tx_clk_400G       =   'b0;
//           sd6_tx_clk_400G       =   'b0;
//           sd8_tx_clk_400G       =   'b0;
//           sd10_tx_clk_400G      =   'b0;
//           sd12_tx_clk_400G      =   'b0;
//           sd14_tx_clk_400G      =   'b0;
//           sd0_rx_clk_400G       =   'b0;
//           sd1_rx_clk_400G       =   'b0;
//           sd2_rx_clk_400G       =   'b0;
//           sd3_rx_clk_400G       =   'b0;
//           sd4_rx_clk_400G       =   'b0;
//           sd5_rx_clk_400G       =   'b0;
//           sd6_rx_clk_400G       =   'b0;
//           sd7_rx_clk_400G       =   'b0;
//           sd8_rx_clk_400G       =   'b0;
//           sd9_rx_clk_400G      =    'b0;
//           sd10_rx_clk_400G      =   'b0;
//           sd11_rx_clk_400G      =   'b0;
//           sd12_rx_clk_400G      =   'b0;
//           sd13_rx_clk_400G      =   'b0;
//           sd14_rx_clk_400G      =   'b0;
//           sd15_rx_clk_400G      =   'b0;
           link_status_out       =   link_status_100G;
           srds_rdy_out_100G     =   serdes_rdy_in;
           srds_rdy_out_200G     =   'b0;
           srds_rdy_out_400G     =   'b0;
         end 
    endcase
end
endmodule
