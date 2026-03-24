// Copyright (C) 2024  Intel Corporation. All rights reserved.
// Your use of Intel Corporation's design tools, logic functions 
// and other software and tools, and any partner logic 
// functions, and any output files from any of the foregoing 
// (including device programming or simulation files), and any 
// associated documentation or information are expressly subject 
// to the terms and conditions of the Intel Program License 
// Subscription Agreement, the Intel Quartus Prime License Agreement,
// the Intel FPGA IP License Agreement, or other applicable license
// agreement, including, without limitation, that your use is for
// the sole purpose of programming logic devices manufactured by
// Intel and sold by Intel or its authorized distributors.  Please
// refer to the Intel FPGA Software License Subscription Agreements 
// on the Quartus Prime software download page.

// VENDOR "Altera"
// PROGRAM "Quartus Prime"
// VERSION "Version 24.1.0 Build 115 03/21/2024 SC Pro Edition"

// DATE "01/07/2025 21:15:57"

// 
// Device: Altera 1SG10MHN3F74C2LG_U2 Package FBGA12138
// 

// 
// This greybox netlist file is for third party Synthesis Tools
// for timing and resource estimation only.
// 


module s10_fpll_ref125Mhz_625Mhz (
	tx_serial_clk,
	pll_locked,
	pll_cal_busy,
	pll_refclk0)/* synthesis synthesis_greybox=1 */;
output 	tx_serial_clk;
output 	pll_locked;
output 	pll_cal_busy;
input 	pll_refclk0;

wire gnd;
wire vcc;
wire unknown;

assign gnd = 1'b0;
assign vcc = 1'b1;
// unknown value (1'bx) is not needed for this tool. Default to 1'b0
assign unknown = 1'b0;

wire \xcvr_fpll_s10_htile_0.fpll_inst_O_BLOCK_SELECT ;
wire \xcvr_fpll_s10_htile_0.tx_serial_clk ;
wire \xcvr_fpll_s10_htile_0.fpll_inst_O_CLKLOW ;
wire \xcvr_fpll_s10_htile_0.fpll_inst_O_FREF ;
wire \xcvr_fpll_s10_htile_0.fpll_inst_O_LOCK ;
wire \xcvr_fpll_s10_htile_0.fpll_inst_PHASEDONE ;
wire \xcvr_fpll_s10_htile_0.fpll_inst_pllcout ;
wire \xcvr_fpll_s10_htile_0.fpll_inst_O_PLLCOUT1 ;
wire \xcvr_fpll_s10_htile_0.fpll_inst_O_PLLCOUT2 ;
wire \xcvr_fpll_s10_htile_0.fpll_inst_O_PLLCOUT3 ;
wire \xcvr_fpll_s10_htile_0.fpll_inst_O_READDATA0 ;
wire \xcvr_fpll_s10_htile_0.fpll_inst_O_READDATA1 ;
wire \xcvr_fpll_s10_htile_0.fpll_inst_O_READDATA2 ;
wire \xcvr_fpll_s10_htile_0.fpll_inst_O_READDATA3 ;
wire \xcvr_fpll_s10_htile_0.fpll_inst_O_READDATA4 ;
wire \xcvr_fpll_s10_htile_0.fpll_inst_O_READDATA5 ;
wire \xcvr_fpll_s10_htile_0.fpll_inst_O_READDATA6 ;
wire \xcvr_fpll_s10_htile_0.fpll_inst_O_READDATA7 ;
wire \xcvr_fpll_s10_htile_0.cmu_fpll_pld_adapt_inst_O_CLK0_BAD ;
wire \xcvr_fpll_s10_htile_0.cmu_fpll_pld_adapt_inst_O_INT_DPS_RST_N ;
wire \xcvr_fpll_s10_htile_0.cmu_fpll_pld_adapt_inst_O_INT_PHASE_EN ;
wire \xcvr_fpll_s10_htile_0.cmu_fpll_pld_adapt_inst_O_INT_RST_N ;
wire \xcvr_fpll_s10_htile_0.cmu_fpll_pld_adapt_inst_O_INT_UP_DN ;
wire \xcvr_fpll_s10_htile_0.cmu_fpll_pld_adapt_inst_O_LOCK ;
wire \xcvr_fpll_s10_htile_0.cmu_fpll_pld_adapt_inst_O_INT_CNT_SEL0 ;
wire \xcvr_fpll_s10_htile_0.cmu_fpll_pld_adapt_inst_O_INT_CNT_SEL1 ;
wire \xcvr_fpll_s10_htile_0.cmu_fpll_pld_adapt_inst_O_INT_CNT_SEL2 ;
wire \xcvr_fpll_s10_htile_0.cmu_fpll_pld_adapt_inst_O_INT_CNT_SEL3 ;
wire \xcvr_fpll_s10_htile_0.cmu_fpll_pld_adapt_inst_O_INT_NUM_PHASE_SHIFTS0 ;
wire \xcvr_fpll_s10_htile_0.cmu_fpll_pld_adapt_inst_O_INT_NUM_PHASE_SHIFTS1 ;
wire \xcvr_fpll_s10_htile_0.cmu_fpll_pld_adapt_inst_O_INT_NUM_PHASE_SHIFTS2 ;
wire \xcvr_fpll_s10_htile_0.xcvr_avmm2_inst.pll_avmm_clk[0] ;
wire \xcvr_fpll_s10_htile_0.xcvr_avmm2_inst.pld_hssi_osc_transfer_en[0] ;
wire \xcvr_fpll_s10_htile_0.xcvr_avmm2_inst.pld_cal_done[0] ;
wire \xcvr_fpll_s10_htile_0.xcvr_avmm2_inst.pll_avmm_read[0] ;
wire \xcvr_fpll_s10_htile_0.xcvr_avmm2_inst.pll_avmm_write[0] ;
wire \xcvr_fpll_s10_htile_0.xcvr_avmm2_inst.pll_avmm_address[0] ;
wire \xcvr_fpll_s10_htile_0.xcvr_avmm2_inst.pll_avmm_address[1] ;
wire \xcvr_fpll_s10_htile_0.xcvr_avmm2_inst.pll_avmm_address[2] ;
wire \xcvr_fpll_s10_htile_0.xcvr_avmm2_inst.pll_avmm_address[3] ;
wire \xcvr_fpll_s10_htile_0.xcvr_avmm2_inst.pll_avmm_address[4] ;
wire \xcvr_fpll_s10_htile_0.xcvr_avmm2_inst.pll_avmm_address[5] ;
wire \xcvr_fpll_s10_htile_0.xcvr_avmm2_inst.pll_avmm_address[6] ;
wire \xcvr_fpll_s10_htile_0.xcvr_avmm2_inst.pll_avmm_address[7] ;
wire \xcvr_fpll_s10_htile_0.xcvr_avmm2_inst.pll_avmm_address[8] ;
wire \xcvr_fpll_s10_htile_0.xcvr_avmm2_inst.pll_avmm_address[9] ;
wire \xcvr_fpll_s10_htile_0.xcvr_avmm2_inst.pll_avmm_writedata[0] ;
wire \xcvr_fpll_s10_htile_0.xcvr_avmm2_inst.pll_avmm_writedata[1] ;
wire \xcvr_fpll_s10_htile_0.xcvr_avmm2_inst.pll_avmm_writedata[2] ;
wire \xcvr_fpll_s10_htile_0.xcvr_avmm2_inst.pll_avmm_writedata[3] ;
wire \xcvr_fpll_s10_htile_0.xcvr_avmm2_inst.pll_avmm_writedata[4] ;
wire \xcvr_fpll_s10_htile_0.xcvr_avmm2_inst.pll_avmm_writedata[5] ;
wire \xcvr_fpll_s10_htile_0.xcvr_avmm2_inst.pll_avmm_writedata[6] ;
wire \xcvr_fpll_s10_htile_0.xcvr_avmm2_inst.pll_avmm_writedata[7] ;
wire \xcvr_fpll_s10_htile_0.fpll_refclk_select_inst_O_BLOCKSELECT ;
wire \xcvr_fpll_s10_htile_0.fpll_refclk_select_inst_clkout ;
wire \xcvr_fpll_s10_htile_0.fpll_refclk_select_inst_O_AVMMREADDATA0 ;
wire \xcvr_fpll_s10_htile_0.fpll_refclk_select_inst_O_AVMMREADDATA1 ;
wire \xcvr_fpll_s10_htile_0.fpll_refclk_select_inst_O_AVMMREADDATA2 ;
wire \xcvr_fpll_s10_htile_0.fpll_refclk_select_inst_O_AVMMREADDATA3 ;
wire \xcvr_fpll_s10_htile_0.fpll_refclk_select_inst_O_AVMMREADDATA4 ;
wire \xcvr_fpll_s10_htile_0.fpll_refclk_select_inst_O_AVMMREADDATA5 ;
wire \xcvr_fpll_s10_htile_0.fpll_refclk_select_inst_O_AVMMREADDATA6 ;
wire \xcvr_fpll_s10_htile_0.fpll_refclk_select_inst_O_AVMMREADDATA7 ;
wire \xcvr_fpll_s10_htile_0.fpll_refclk_select_inst_O_CLK0 ;
wire \xcvr_fpll_s10_htile_0.fpll_refclk_select_inst_O_CLK1 ;
wire \xcvr_fpll_s10_htile_0.xcvr_avmm2_inst.pld_cal_done[0]__wirecell_combout ;

wire [7:0] \xcvr_fpll_s10_htile_0.fpll_inst_READDATA_bus ;
wire [3:0] \xcvr_fpll_s10_htile_0.fpll_inst_PLLCOUT_bus ;
wire [3:0] \xcvr_fpll_s10_htile_0.cmu_fpll_pld_adapt_inst_INT_CNT_SEL_bus ;
wire [2:0] \xcvr_fpll_s10_htile_0.cmu_fpll_pld_adapt_inst_INT_NUM_PHASE_SHIFTS_bus ;
wire [7:0] \xcvr_fpll_s10_htile_0.xcvr_avmm2_inst.avmm_atom_insts[0].ct1_hssi_avmm2_if_inst_WRITEDATACHNL_bus ;
wire [9:0] \xcvr_fpll_s10_htile_0.xcvr_avmm2_inst.avmm_atom_insts[0].ct1_hssi_avmm2_if_inst_REGADDRCHNL_bus ;
wire [1:0] \xcvr_fpll_s10_htile_0.fpll_refclk_select_inst_CLK_bus ;
wire [7:0] \xcvr_fpll_s10_htile_0.fpll_refclk_select_inst_AVMMREADDATA_bus ;

assign \xcvr_fpll_s10_htile_0.fpll_inst_O_READDATA0  = \xcvr_fpll_s10_htile_0.fpll_inst_READDATA_bus [0];
assign \xcvr_fpll_s10_htile_0.fpll_inst_O_READDATA1  = \xcvr_fpll_s10_htile_0.fpll_inst_READDATA_bus [1];
assign \xcvr_fpll_s10_htile_0.fpll_inst_O_READDATA2  = \xcvr_fpll_s10_htile_0.fpll_inst_READDATA_bus [2];
assign \xcvr_fpll_s10_htile_0.fpll_inst_O_READDATA3  = \xcvr_fpll_s10_htile_0.fpll_inst_READDATA_bus [3];
assign \xcvr_fpll_s10_htile_0.fpll_inst_O_READDATA4  = \xcvr_fpll_s10_htile_0.fpll_inst_READDATA_bus [4];
assign \xcvr_fpll_s10_htile_0.fpll_inst_O_READDATA5  = \xcvr_fpll_s10_htile_0.fpll_inst_READDATA_bus [5];
assign \xcvr_fpll_s10_htile_0.fpll_inst_O_READDATA6  = \xcvr_fpll_s10_htile_0.fpll_inst_READDATA_bus [6];
assign \xcvr_fpll_s10_htile_0.fpll_inst_O_READDATA7  = \xcvr_fpll_s10_htile_0.fpll_inst_READDATA_bus [7];

assign \xcvr_fpll_s10_htile_0.fpll_inst_pllcout  = \xcvr_fpll_s10_htile_0.fpll_inst_PLLCOUT_bus [0];
assign \xcvr_fpll_s10_htile_0.fpll_inst_O_PLLCOUT1  = \xcvr_fpll_s10_htile_0.fpll_inst_PLLCOUT_bus [1];
assign \xcvr_fpll_s10_htile_0.fpll_inst_O_PLLCOUT2  = \xcvr_fpll_s10_htile_0.fpll_inst_PLLCOUT_bus [2];
assign \xcvr_fpll_s10_htile_0.fpll_inst_O_PLLCOUT3  = \xcvr_fpll_s10_htile_0.fpll_inst_PLLCOUT_bus [3];

assign \xcvr_fpll_s10_htile_0.cmu_fpll_pld_adapt_inst_O_INT_CNT_SEL0  = \xcvr_fpll_s10_htile_0.cmu_fpll_pld_adapt_inst_INT_CNT_SEL_bus [0];
assign \xcvr_fpll_s10_htile_0.cmu_fpll_pld_adapt_inst_O_INT_CNT_SEL1  = \xcvr_fpll_s10_htile_0.cmu_fpll_pld_adapt_inst_INT_CNT_SEL_bus [1];
assign \xcvr_fpll_s10_htile_0.cmu_fpll_pld_adapt_inst_O_INT_CNT_SEL2  = \xcvr_fpll_s10_htile_0.cmu_fpll_pld_adapt_inst_INT_CNT_SEL_bus [2];
assign \xcvr_fpll_s10_htile_0.cmu_fpll_pld_adapt_inst_O_INT_CNT_SEL3  = \xcvr_fpll_s10_htile_0.cmu_fpll_pld_adapt_inst_INT_CNT_SEL_bus [3];

assign \xcvr_fpll_s10_htile_0.cmu_fpll_pld_adapt_inst_O_INT_NUM_PHASE_SHIFTS0  = \xcvr_fpll_s10_htile_0.cmu_fpll_pld_adapt_inst_INT_NUM_PHASE_SHIFTS_bus [0];
assign \xcvr_fpll_s10_htile_0.cmu_fpll_pld_adapt_inst_O_INT_NUM_PHASE_SHIFTS1  = \xcvr_fpll_s10_htile_0.cmu_fpll_pld_adapt_inst_INT_NUM_PHASE_SHIFTS_bus [1];
assign \xcvr_fpll_s10_htile_0.cmu_fpll_pld_adapt_inst_O_INT_NUM_PHASE_SHIFTS2  = \xcvr_fpll_s10_htile_0.cmu_fpll_pld_adapt_inst_INT_NUM_PHASE_SHIFTS_bus [2];

assign \xcvr_fpll_s10_htile_0.xcvr_avmm2_inst.pll_avmm_writedata[0]  = \xcvr_fpll_s10_htile_0.xcvr_avmm2_inst.avmm_atom_insts[0].ct1_hssi_avmm2_if_inst_WRITEDATACHNL_bus [0];
assign \xcvr_fpll_s10_htile_0.xcvr_avmm2_inst.pll_avmm_writedata[1]  = \xcvr_fpll_s10_htile_0.xcvr_avmm2_inst.avmm_atom_insts[0].ct1_hssi_avmm2_if_inst_WRITEDATACHNL_bus [1];
assign \xcvr_fpll_s10_htile_0.xcvr_avmm2_inst.pll_avmm_writedata[2]  = \xcvr_fpll_s10_htile_0.xcvr_avmm2_inst.avmm_atom_insts[0].ct1_hssi_avmm2_if_inst_WRITEDATACHNL_bus [2];
assign \xcvr_fpll_s10_htile_0.xcvr_avmm2_inst.pll_avmm_writedata[3]  = \xcvr_fpll_s10_htile_0.xcvr_avmm2_inst.avmm_atom_insts[0].ct1_hssi_avmm2_if_inst_WRITEDATACHNL_bus [3];
assign \xcvr_fpll_s10_htile_0.xcvr_avmm2_inst.pll_avmm_writedata[4]  = \xcvr_fpll_s10_htile_0.xcvr_avmm2_inst.avmm_atom_insts[0].ct1_hssi_avmm2_if_inst_WRITEDATACHNL_bus [4];
assign \xcvr_fpll_s10_htile_0.xcvr_avmm2_inst.pll_avmm_writedata[5]  = \xcvr_fpll_s10_htile_0.xcvr_avmm2_inst.avmm_atom_insts[0].ct1_hssi_avmm2_if_inst_WRITEDATACHNL_bus [5];
assign \xcvr_fpll_s10_htile_0.xcvr_avmm2_inst.pll_avmm_writedata[6]  = \xcvr_fpll_s10_htile_0.xcvr_avmm2_inst.avmm_atom_insts[0].ct1_hssi_avmm2_if_inst_WRITEDATACHNL_bus [6];
assign \xcvr_fpll_s10_htile_0.xcvr_avmm2_inst.pll_avmm_writedata[7]  = \xcvr_fpll_s10_htile_0.xcvr_avmm2_inst.avmm_atom_insts[0].ct1_hssi_avmm2_if_inst_WRITEDATACHNL_bus [7];

assign \xcvr_fpll_s10_htile_0.xcvr_avmm2_inst.pll_avmm_address[0]  = \xcvr_fpll_s10_htile_0.xcvr_avmm2_inst.avmm_atom_insts[0].ct1_hssi_avmm2_if_inst_REGADDRCHNL_bus [0];
assign \xcvr_fpll_s10_htile_0.xcvr_avmm2_inst.pll_avmm_address[1]  = \xcvr_fpll_s10_htile_0.xcvr_avmm2_inst.avmm_atom_insts[0].ct1_hssi_avmm2_if_inst_REGADDRCHNL_bus [1];
assign \xcvr_fpll_s10_htile_0.xcvr_avmm2_inst.pll_avmm_address[2]  = \xcvr_fpll_s10_htile_0.xcvr_avmm2_inst.avmm_atom_insts[0].ct1_hssi_avmm2_if_inst_REGADDRCHNL_bus [2];
assign \xcvr_fpll_s10_htile_0.xcvr_avmm2_inst.pll_avmm_address[3]  = \xcvr_fpll_s10_htile_0.xcvr_avmm2_inst.avmm_atom_insts[0].ct1_hssi_avmm2_if_inst_REGADDRCHNL_bus [3];
assign \xcvr_fpll_s10_htile_0.xcvr_avmm2_inst.pll_avmm_address[4]  = \xcvr_fpll_s10_htile_0.xcvr_avmm2_inst.avmm_atom_insts[0].ct1_hssi_avmm2_if_inst_REGADDRCHNL_bus [4];
assign \xcvr_fpll_s10_htile_0.xcvr_avmm2_inst.pll_avmm_address[5]  = \xcvr_fpll_s10_htile_0.xcvr_avmm2_inst.avmm_atom_insts[0].ct1_hssi_avmm2_if_inst_REGADDRCHNL_bus [5];
assign \xcvr_fpll_s10_htile_0.xcvr_avmm2_inst.pll_avmm_address[6]  = \xcvr_fpll_s10_htile_0.xcvr_avmm2_inst.avmm_atom_insts[0].ct1_hssi_avmm2_if_inst_REGADDRCHNL_bus [6];
assign \xcvr_fpll_s10_htile_0.xcvr_avmm2_inst.pll_avmm_address[7]  = \xcvr_fpll_s10_htile_0.xcvr_avmm2_inst.avmm_atom_insts[0].ct1_hssi_avmm2_if_inst_REGADDRCHNL_bus [7];
assign \xcvr_fpll_s10_htile_0.xcvr_avmm2_inst.pll_avmm_address[8]  = \xcvr_fpll_s10_htile_0.xcvr_avmm2_inst.avmm_atom_insts[0].ct1_hssi_avmm2_if_inst_REGADDRCHNL_bus [8];
assign \xcvr_fpll_s10_htile_0.xcvr_avmm2_inst.pll_avmm_address[9]  = \xcvr_fpll_s10_htile_0.xcvr_avmm2_inst.avmm_atom_insts[0].ct1_hssi_avmm2_if_inst_REGADDRCHNL_bus [9];

assign \xcvr_fpll_s10_htile_0.fpll_refclk_select_inst_O_CLK0  = \xcvr_fpll_s10_htile_0.fpll_refclk_select_inst_CLK_bus [0];
assign \xcvr_fpll_s10_htile_0.fpll_refclk_select_inst_O_CLK1  = \xcvr_fpll_s10_htile_0.fpll_refclk_select_inst_CLK_bus [1];

assign \xcvr_fpll_s10_htile_0.fpll_refclk_select_inst_O_AVMMREADDATA0  = \xcvr_fpll_s10_htile_0.fpll_refclk_select_inst_AVMMREADDATA_bus [0];
assign \xcvr_fpll_s10_htile_0.fpll_refclk_select_inst_O_AVMMREADDATA1  = \xcvr_fpll_s10_htile_0.fpll_refclk_select_inst_AVMMREADDATA_bus [1];
assign \xcvr_fpll_s10_htile_0.fpll_refclk_select_inst_O_AVMMREADDATA2  = \xcvr_fpll_s10_htile_0.fpll_refclk_select_inst_AVMMREADDATA_bus [2];
assign \xcvr_fpll_s10_htile_0.fpll_refclk_select_inst_O_AVMMREADDATA3  = \xcvr_fpll_s10_htile_0.fpll_refclk_select_inst_AVMMREADDATA_bus [3];
assign \xcvr_fpll_s10_htile_0.fpll_refclk_select_inst_O_AVMMREADDATA4  = \xcvr_fpll_s10_htile_0.fpll_refclk_select_inst_AVMMREADDATA_bus [4];
assign \xcvr_fpll_s10_htile_0.fpll_refclk_select_inst_O_AVMMREADDATA5  = \xcvr_fpll_s10_htile_0.fpll_refclk_select_inst_AVMMREADDATA_bus [5];
assign \xcvr_fpll_s10_htile_0.fpll_refclk_select_inst_O_AVMMREADDATA6  = \xcvr_fpll_s10_htile_0.fpll_refclk_select_inst_AVMMREADDATA_bus [6];
assign \xcvr_fpll_s10_htile_0.fpll_refclk_select_inst_O_AVMMREADDATA7  = \xcvr_fpll_s10_htile_0.fpll_refclk_select_inst_AVMMREADDATA_bus [7];

ct1_hssi_cr2_cmu_fpll \xcvr_fpll_s10_htile_0.fpll_inst (
	.avmmclk(gnd),
	.avmmread(gnd),
	.avmmwrite(gnd),
	.core_refclk(gnd),
	.csr_bufin(gnd),
	.csr_clk(gnd),
	.csr_en(gnd),
	.csr_en_dly(gnd),
	.csr_in(gnd),
	.dprio_clk(\xcvr_fpll_s10_htile_0.xcvr_avmm2_inst.pll_avmm_clk[0] ),
	.dprio_rst_n(vcc),
	.dps_rst_n(\xcvr_fpll_s10_htile_0.cmu_fpll_pld_adapt_inst_O_INT_DPS_RST_N ),
	.extswitch_buf(gnd),
	.fbclkin(vcc),
	.lc_to_fpll_refclk(gnd),
	.lcpll_cal_done(gnd),
	.lcpll_fbclkid(gnd),
	.lcpll_lckdtct_res(gnd),
	.lcpll_refclkid(gnd),
	.mdio_dis(gnd),
	.nfrzdrv(gnd),
	.nrpi_freeze(gnd),
	.pfden(vcc),
	.phase_en(\xcvr_fpll_s10_htile_0.cmu_fpll_pld_adapt_inst_O_INT_PHASE_EN ),
	.pllclksel(gnd),
	.pma_atpg_los_en_n(vcc),
	.pma_csr_test_dis(gnd),
	.read(\xcvr_fpll_s10_htile_0.xcvr_avmm2_inst.pll_avmm_read[0] ),
	.refclkind(\xcvr_fpll_s10_htile_0.fpll_refclk_select_inst_clkout ),
	.rst_n(\xcvr_fpll_s10_htile_0.cmu_fpll_pld_adapt_inst_O_INT_RST_N ),
	.scan_mode_n(vcc),
	.scan_shift_n(vcc),
	.up_dn(\xcvr_fpll_s10_htile_0.cmu_fpll_pld_adapt_inst_O_INT_UP_DN ),
	.write(\xcvr_fpll_s10_htile_0.xcvr_avmm2_inst.pll_avmm_write[0] ),
	.avmmaddress({gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd}),
	.avmmwritedata({gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd}),
	.cnt_sel({\xcvr_fpll_s10_htile_0.cmu_fpll_pld_adapt_inst_O_INT_CNT_SEL3 ,\xcvr_fpll_s10_htile_0.cmu_fpll_pld_adapt_inst_O_INT_CNT_SEL2 ,\xcvr_fpll_s10_htile_0.cmu_fpll_pld_adapt_inst_O_INT_CNT_SEL1 ,\xcvr_fpll_s10_htile_0.cmu_fpll_pld_adapt_inst_O_INT_CNT_SEL0 }),
	.fpll_ppm_clk({gnd,gnd}),
	.iqtxrxclk({gnd,gnd,gnd,gnd,gnd,gnd}),
	.num_phase_shifts({\xcvr_fpll_s10_htile_0.cmu_fpll_pld_adapt_inst_O_INT_NUM_PHASE_SHIFTS2 ,\xcvr_fpll_s10_htile_0.cmu_fpll_pld_adapt_inst_O_INT_NUM_PHASE_SHIFTS1 ,\xcvr_fpll_s10_htile_0.cmu_fpll_pld_adapt_inst_O_INT_NUM_PHASE_SHIFTS0 }),
	.reg_addr({\xcvr_fpll_s10_htile_0.xcvr_avmm2_inst.pll_avmm_address[8] ,\xcvr_fpll_s10_htile_0.xcvr_avmm2_inst.pll_avmm_address[7] ,\xcvr_fpll_s10_htile_0.xcvr_avmm2_inst.pll_avmm_address[6] ,\xcvr_fpll_s10_htile_0.xcvr_avmm2_inst.pll_avmm_address[5] ,
\xcvr_fpll_s10_htile_0.xcvr_avmm2_inst.pll_avmm_address[4] ,\xcvr_fpll_s10_htile_0.xcvr_avmm2_inst.pll_avmm_address[3] ,\xcvr_fpll_s10_htile_0.xcvr_avmm2_inst.pll_avmm_address[2] ,\xcvr_fpll_s10_htile_0.xcvr_avmm2_inst.pll_avmm_address[1] ,
\xcvr_fpll_s10_htile_0.xcvr_avmm2_inst.pll_avmm_address[0] }),
	.writedata({\xcvr_fpll_s10_htile_0.xcvr_avmm2_inst.pll_avmm_writedata[7] ,\xcvr_fpll_s10_htile_0.xcvr_avmm2_inst.pll_avmm_writedata[6] ,\xcvr_fpll_s10_htile_0.xcvr_avmm2_inst.pll_avmm_writedata[5] ,\xcvr_fpll_s10_htile_0.xcvr_avmm2_inst.pll_avmm_writedata[4] ,
\xcvr_fpll_s10_htile_0.xcvr_avmm2_inst.pll_avmm_writedata[3] ,\xcvr_fpll_s10_htile_0.xcvr_avmm2_inst.pll_avmm_writedata[2] ,\xcvr_fpll_s10_htile_0.xcvr_avmm2_inst.pll_avmm_writedata[1] ,\xcvr_fpll_s10_htile_0.xcvr_avmm2_inst.pll_avmm_writedata[0] }),
	.block_select(\xcvr_fpll_s10_htile_0.fpll_inst_O_BLOCK_SELECT ),
	.blockselect(),
	.clk0(\xcvr_fpll_s10_htile_0.tx_serial_clk ),
	.clk0_bad(),
	.clk180(),
	.clk1_bad(),
	.clklow(\xcvr_fpll_s10_htile_0.fpll_inst_O_CLKLOW ),
	.cr_lcpll_msel_ls(),
	.cr_refclk_msel_ls(),
	.csr_bufout(),
	.csr_out(),
	.fbclkout(),
	.fpll_cr_clk_sel_override(),
	.fpll_cr_clk_sel_override_value(),
	.fpll_cr_pllen(),
	.fref(\xcvr_fpll_s10_htile_0.fpll_inst_O_FREF ),
	.hclk_out(),
	.iqtxrxclk_out(),
	.lock(\xcvr_fpll_s10_htile_0.fpll_inst_O_LOCK ),
	.phase_done(\xcvr_fpll_s10_htile_0.fpll_inst_PHASEDONE ),
	.pll_cas_out(),
	.ppm_lckdtct_out(),
	.avmmreaddata(),
	.cr_refclk_atb(),
	.cr_refclk_vreg_en(),
	.fpll_cr_clksel(),
	.fpll_cr_so(),
	.fpll_rclknet_iqref0(),
	.fpll_rclknet_iqref1(),
	.fpll_rscratch0_src0(),
	.fpll_rscratch0_src1(),
	.fpll_rscratch1_src0(),
	.fpll_rscratch1_src1(),
	.fpll_rscratch2_src0(),
	.fpll_rscratch2_src1(),
	.fpll_rscratch3_src0(),
	.fpll_rscratch3_src1(),
	.fpll_rscratch4_src0(),
	.fpll_rscratch4_src1(),
	.pllcout(\xcvr_fpll_s10_htile_0.fpll_inst_PLLCOUT_bus ),
	.ppm_clk(),
	.rclk_hs_fpll(),
	.rclk_ls_h_fpll(),
	.rclk_ls_iqref_fpll(),
	.rclk_ls_iqtxrx_fpll(),
	.rclk_vreg_fpll(),
	.readdata(\xcvr_fpll_s10_htile_0.fpll_inst_READDATA_bus ));
defparam \xcvr_fpll_s10_htile_0.fpll_inst .analog_mode = "analog_off";
defparam \xcvr_fpll_s10_htile_0.fpll_inst .atb_atb = "atb_selectdisable";
defparam \xcvr_fpll_s10_htile_0.fpll_inst .bandwidth_range_high = 36'b000000000000000000000000000000000001;
defparam \xcvr_fpll_s10_htile_0.fpll_inst .bandwidth_range_low = 36'b000000000000000000000000000000000001;
defparam \xcvr_fpll_s10_htile_0.fpll_inst .bcm_silicon_rev = "rev_off";
defparam \xcvr_fpll_s10_htile_0.fpll_inst .bonding = "bond_off";
defparam \xcvr_fpll_s10_htile_0.fpll_inst .bw_mode = "mid_bw";
defparam \xcvr_fpll_s10_htile_0.fpll_inst .bw_sel = "auto";
defparam \xcvr_fpll_s10_htile_0.fpll_inst .c0_cnt_div = 9'b000000001;
defparam \xcvr_fpll_s10_htile_0.fpll_inst .c0_cnt_min_tco = "cnt_bypass_dly";
defparam \xcvr_fpll_s10_htile_0.fpll_inst .c0_coarse_dly = "pll_coarse_dly_setting0";
defparam \xcvr_fpll_s10_htile_0.fpll_inst .c0_fine_dly = "pll_fine_dly_setting0";
defparam \xcvr_fpll_s10_htile_0.fpll_inst .c0_m_cnt_in_src = "m_cnt_in_src_test_clk";
defparam \xcvr_fpll_s10_htile_0.fpll_inst .c0_m_cnt_ph_mux_prst = 2'b00;
defparam \xcvr_fpll_s10_htile_0.fpll_inst .c0_m_cnt_prst = 8'b00000001;
defparam \xcvr_fpll_s10_htile_0.fpll_inst .c0_pllcout_enable = "pllcout_disable";
defparam \xcvr_fpll_s10_htile_0.fpll_inst .c1_cnt_div = 9'b000000001;
defparam \xcvr_fpll_s10_htile_0.fpll_inst .c1_cnt_min_tco = "cnt_bypass_dly";
defparam \xcvr_fpll_s10_htile_0.fpll_inst .c1_coarse_dly = "pll_coarse_dly_setting0";
defparam \xcvr_fpll_s10_htile_0.fpll_inst .c1_fine_dly = "pll_fine_dly_setting0";
defparam \xcvr_fpll_s10_htile_0.fpll_inst .c1_m_cnt_in_src = "m_cnt_in_src_test_clk";
defparam \xcvr_fpll_s10_htile_0.fpll_inst .c1_m_cnt_ph_mux_prst = 2'b00;
defparam \xcvr_fpll_s10_htile_0.fpll_inst .c1_m_cnt_prst = 8'b00000001;
defparam \xcvr_fpll_s10_htile_0.fpll_inst .c1_pllcout_enable = "pllcout_disable";
defparam \xcvr_fpll_s10_htile_0.fpll_inst .c2_cnt_div = 9'b000000001;
defparam \xcvr_fpll_s10_htile_0.fpll_inst .c2_cnt_min_tco = "cnt_bypass_dly";
defparam \xcvr_fpll_s10_htile_0.fpll_inst .c2_coarse_dly = "pll_coarse_dly_setting0";
defparam \xcvr_fpll_s10_htile_0.fpll_inst .c2_fine_dly = "pll_fine_dly_setting0";
defparam \xcvr_fpll_s10_htile_0.fpll_inst .c2_m_cnt_in_src = "m_cnt_in_src_test_clk";
defparam \xcvr_fpll_s10_htile_0.fpll_inst .c2_m_cnt_ph_mux_prst = 2'b00;
defparam \xcvr_fpll_s10_htile_0.fpll_inst .c2_m_cnt_prst = 8'b00000001;
defparam \xcvr_fpll_s10_htile_0.fpll_inst .c2_pllcout_enable = "pllcout_disable";
defparam \xcvr_fpll_s10_htile_0.fpll_inst .c3_cnt_div = 9'b000000001;
defparam \xcvr_fpll_s10_htile_0.fpll_inst .c3_cnt_min_tco = "cnt_bypass_dly";
defparam \xcvr_fpll_s10_htile_0.fpll_inst .c3_coarse_dly = "pll_coarse_dly_setting0";
defparam \xcvr_fpll_s10_htile_0.fpll_inst .c3_fine_dly = "pll_fine_dly_setting0";
defparam \xcvr_fpll_s10_htile_0.fpll_inst .c3_m_cnt_in_src = "m_cnt_in_src_test_clk";
defparam \xcvr_fpll_s10_htile_0.fpll_inst .c3_m_cnt_ph_mux_prst = 2'b00;
defparam \xcvr_fpll_s10_htile_0.fpll_inst .c3_m_cnt_prst = 8'b00000001;
defparam \xcvr_fpll_s10_htile_0.fpll_inst .c3_pllcout_enable = "pllcout_disable";
defparam \xcvr_fpll_s10_htile_0.fpll_inst .cal_reserved = "fpll_cal_reserved_off";
defparam \xcvr_fpll_s10_htile_0.fpll_inst .cal_status = "fpll_cal_status_on";
defparam \xcvr_fpll_s10_htile_0.fpll_inst .cal_test_sel = "sel_cal_out_7_to_0";
defparam \xcvr_fpll_s10_htile_0.fpll_inst .cal_vco_count_length = "sel_8b_count";
defparam \xcvr_fpll_s10_htile_0.fpll_inst .cali_ref_off = "ref_on";
defparam \xcvr_fpll_s10_htile_0.fpll_inst .cali_vco_off = "vco_on";
defparam \xcvr_fpll_s10_htile_0.fpll_inst .calibration = "fpll_cal_enable";
defparam \xcvr_fpll_s10_htile_0.fpll_inst .cas_out_enable = "fpll_cas_out_disable";
defparam \xcvr_fpll_s10_htile_0.fpll_inst .cgb_div = 4'b0001;
defparam \xcvr_fpll_s10_htile_0.fpll_inst .chgpmp_compensation = "cp_mode_enable";
defparam \xcvr_fpll_s10_htile_0.fpll_inst .chgpmp_current_setting = "cp_current_setting24";
defparam \xcvr_fpll_s10_htile_0.fpll_inst .chgpmp_testmode = "cp_normal";
defparam \xcvr_fpll_s10_htile_0.fpll_inst .cmu_rstn_value = "cmu_normal";
defparam \xcvr_fpll_s10_htile_0.fpll_inst .compensation_mode = "direct";
defparam \xcvr_fpll_s10_htile_0.fpll_inst .cp_current_boost = "normal_setting";
defparam \xcvr_fpll_s10_htile_0.fpll_inst .ctrl_ctrl_override_setting = "pll_ctrl_enable";
defparam \xcvr_fpll_s10_htile_0.fpll_inst .ctrl_enable = "pll_enabled";
defparam \xcvr_fpll_s10_htile_0.fpll_inst .ctrl_nreset_prgmnvrt = "nreset_noninv";
defparam \xcvr_fpll_s10_htile_0.fpll_inst .ctrl_plniotri_override = "plniotri_ctrl_disable";
defparam \xcvr_fpll_s10_htile_0.fpll_inst .ctrl_slf_rst = "pll_slf_rst_off";
defparam \xcvr_fpll_s10_htile_0.fpll_inst .ctrl_test_enable = "pll_testen_off";
defparam \xcvr_fpll_s10_htile_0.fpll_inst .ctrl_vccr_pd = "vccd_powerup";
defparam \xcvr_fpll_s10_htile_0.fpll_inst .datarate_bps = 36'b000001001010100000010111110010000000;
defparam \xcvr_fpll_s10_htile_0.fpll_inst .device_variant = "device_off";
defparam \xcvr_fpll_s10_htile_0.fpll_inst .dprio_base_addr = 9'b100000000;
defparam \xcvr_fpll_s10_htile_0.fpll_inst .dprio_broadcast_en = "dprio_dprio_broadcast_en_csr_ctrl_disable";
defparam \xcvr_fpll_s10_htile_0.fpll_inst .dprio_cvp_inter_sel = "dprio_cvp_inter_sel_csr_ctrl_disable";
defparam \xcvr_fpll_s10_htile_0.fpll_inst .dprio_force_inter_sel = "dprio_force_inter_sel_csr_ctrl_disable";
defparam \xcvr_fpll_s10_htile_0.fpll_inst .dprio_power_iso_en = "dprio_power_iso_en_csr_ctrl_disable";
defparam \xcvr_fpll_s10_htile_0.fpll_inst .dprio_status_select = "dprio_normal_status";
defparam \xcvr_fpll_s10_htile_0.fpll_inst .dsm_mode = "dsm_mode_integer";
defparam \xcvr_fpll_s10_htile_0.fpll_inst .duty_cycle_0 = 50;
defparam \xcvr_fpll_s10_htile_0.fpll_inst .duty_cycle_1 = 50;
defparam \xcvr_fpll_s10_htile_0.fpll_inst .duty_cycle_2 = 50;
defparam \xcvr_fpll_s10_htile_0.fpll_inst .duty_cycle_3 = 50;
defparam \xcvr_fpll_s10_htile_0.fpll_inst .dyn_reconfig = "fpll_dyn_reconfig_off";
defparam \xcvr_fpll_s10_htile_0.fpll_inst .enable_hclk = "false";
defparam \xcvr_fpll_s10_htile_0.fpll_inst .extra_csr = 3'b000;
defparam \xcvr_fpll_s10_htile_0.fpll_inst .f_max_band_0 = 36'b000011100110001011110100111010100000;
defparam \xcvr_fpll_s10_htile_0.fpll_inst .f_max_band_1 = 36'b000011111111100010011101010011011000;
defparam \xcvr_fpll_s10_htile_0.fpll_inst .f_max_band_2 = 36'b000100010111011101000111011101100000;
defparam \xcvr_fpll_s10_htile_0.fpll_inst .f_max_band_3 = 36'b000100101110010110110100001001100000;
defparam \xcvr_fpll_s10_htile_0.fpll_inst .f_max_band_4 = 36'b000101000011001111110101001111011000;
defparam \xcvr_fpll_s10_htile_0.fpll_inst .f_max_band_5 = 36'b000101010111011101000101110010111000;
defparam \xcvr_fpll_s10_htile_0.fpll_inst .f_max_band_6 = 36'b000101101010000110011101010010001000;
defparam \xcvr_fpll_s10_htile_0.fpll_inst .f_max_band_7 = 36'b000101111011111011011100011110100000;
defparam \xcvr_fpll_s10_htile_0.fpll_inst .f_max_band_8 = 36'b001101000011111101001000010001000000;
defparam \xcvr_fpll_s10_htile_0.fpll_inst .f_max_band_9 = 36'b000000000000000000000000000000000001;
defparam \xcvr_fpll_s10_htile_0.fpll_inst .f_max_div_two_bypass = 36'b000000000000000000000000000000000001;
defparam \xcvr_fpll_s10_htile_0.fpll_inst .f_max_pfd = 36'b000000010100110111001001001110000000;
defparam \xcvr_fpll_s10_htile_0.fpll_inst .f_max_pfd_bonded = 36'b000000100011110000110100011000000000;
defparam \xcvr_fpll_s10_htile_0.fpll_inst .f_max_pfd_fractional = 36'b000000101111101011110000100000000000;
defparam \xcvr_fpll_s10_htile_0.fpll_inst .f_max_pfd_integer = 36'b000000101111101011110000100000000000;
defparam \xcvr_fpll_s10_htile_0.fpll_inst .f_max_vco = 36'b001011101001000011101101110100000000;
defparam \xcvr_fpll_s10_htile_0.fpll_inst .f_max_vco_fractional = 36'b001101000011111101001000010001000000;
defparam \xcvr_fpll_s10_htile_0.fpll_inst .f_min_band_0 = 36'b000110100001001110111000011000000000;
defparam \xcvr_fpll_s10_htile_0.fpll_inst .f_min_band_1 = 36'b000011100110001011110100111010100000;
defparam \xcvr_fpll_s10_htile_0.fpll_inst .f_min_band_2 = 36'b000011111111100010011101010011011000;
defparam \xcvr_fpll_s10_htile_0.fpll_inst .f_min_band_3 = 36'b000100010111011101000111011101100000;
defparam \xcvr_fpll_s10_htile_0.fpll_inst .f_min_band_4 = 36'b000100101110010110110100001001100000;
defparam \xcvr_fpll_s10_htile_0.fpll_inst .f_min_band_5 = 36'b000101000011001111110101001111011000;
defparam \xcvr_fpll_s10_htile_0.fpll_inst .f_min_band_6 = 36'b000101010111011101000101110010111000;
defparam \xcvr_fpll_s10_htile_0.fpll_inst .f_min_band_7 = 36'b000101101010000110011101010010001000;
defparam \xcvr_fpll_s10_htile_0.fpll_inst .f_min_band_8 = 36'b000101111011111011011100011110100000;
defparam \xcvr_fpll_s10_htile_0.fpll_inst .f_min_band_9 = 36'b000000000000000000000000000000000001;
defparam \xcvr_fpll_s10_htile_0.fpll_inst .f_min_pfd = 36'b000000000010111110101111000010000000;
defparam \xcvr_fpll_s10_htile_0.fpll_inst .f_min_vco = 36'b000101100101101000001011110000000000;
defparam \xcvr_fpll_s10_htile_0.fpll_inst .f_out_c0 = 36'b000000000000000000000000000000000000;
defparam \xcvr_fpll_s10_htile_0.fpll_inst .f_out_c0_hz = 36'b000000000000000000000000000000000000;
defparam \xcvr_fpll_s10_htile_0.fpll_inst .f_out_c1 = 36'b000000000000000000000000000000000000;
defparam \xcvr_fpll_s10_htile_0.fpll_inst .f_out_c1_hz = 36'b000000000000000000000000000000000000;
defparam \xcvr_fpll_s10_htile_0.fpll_inst .f_out_c2 = 36'b000000000000000000000000000000000000;
defparam \xcvr_fpll_s10_htile_0.fpll_inst .f_out_c2_hz = 36'b000000000000000000000000000000000000;
defparam \xcvr_fpll_s10_htile_0.fpll_inst .f_out_c3 = 36'b000000000000000000000000000000000001;
defparam \xcvr_fpll_s10_htile_0.fpll_inst .f_out_c3_hz = 36'b000000000000000000000000000000000001;
defparam \xcvr_fpll_s10_htile_0.fpll_inst .fb_cmp_buf_dly = "pll_cmp_buf_dly_setting0";
defparam \xcvr_fpll_s10_htile_0.fpll_inst .fb_fbclk_mux_1 = "pll_fbclk_mux_1_glb";
defparam \xcvr_fpll_s10_htile_0.fpll_inst .fb_fbclk_mux_2 = "pll_fbclk_mux_2_m_cnt";
defparam \xcvr_fpll_s10_htile_0.fpll_inst .feedback = "normal";
defparam \xcvr_fpll_s10_htile_0.fpll_inst .hclk_out_enable = "fpll_hclk_out_disable";
defparam \xcvr_fpll_s10_htile_0.fpll_inst .hssi_output_clock_frequency = "625000000";
defparam \xcvr_fpll_s10_htile_0.fpll_inst .initial_settings = "true";
defparam \xcvr_fpll_s10_htile_0.fpll_inst .input_tolerance = 8'b00000000;
defparam \xcvr_fpll_s10_htile_0.fpll_inst .iq0_scratch0_src = "iq0_scratch0_power_down";
defparam \xcvr_fpll_s10_htile_0.fpll_inst .iq0_scratch1_src = "iq0_scratch1_power_down";
defparam \xcvr_fpll_s10_htile_0.fpll_inst .iq0_scratch2_src = "iq0_scratch2_power_down";
defparam \xcvr_fpll_s10_htile_0.fpll_inst .iq0_scratch3_src = "iq0_scratch3_power_down";
defparam \xcvr_fpll_s10_htile_0.fpll_inst .iq0_scratch4_src = "iq0_scratch4_power_down";
defparam \xcvr_fpll_s10_htile_0.fpll_inst .iq1_scratch0_src = "iq1_scratch0_power_down";
defparam \xcvr_fpll_s10_htile_0.fpll_inst .iq1_scratch1_src = "iq1_scratch1_power_down";
defparam \xcvr_fpll_s10_htile_0.fpll_inst .iq1_scratch2_src = "iq1_scratch2_power_down";
defparam \xcvr_fpll_s10_htile_0.fpll_inst .iq1_scratch3_src = "iq1_scratch3_power_down";
defparam \xcvr_fpll_s10_htile_0.fpll_inst .iq1_scratch4_src = "iq1_scratch4_power_down";
defparam \xcvr_fpll_s10_htile_0.fpll_inst .iqfb_mux_iqclk_sel = "iqtxrxclk0";
defparam \xcvr_fpll_s10_htile_0.fpll_inst .iqtxrxclk_out_enable = "fpll_iqtxrxclk_out_disable";
defparam \xcvr_fpll_s10_htile_0.fpll_inst .is_cascaded_pll = "false";
defparam \xcvr_fpll_s10_htile_0.fpll_inst .is_otn = "false";
defparam \xcvr_fpll_s10_htile_0.fpll_inst .is_pa_core = "false";
defparam \xcvr_fpll_s10_htile_0.fpll_inst .is_sdi = "false";
defparam \xcvr_fpll_s10_htile_0.fpll_inst .l_counter = 6'b001000;
defparam \xcvr_fpll_s10_htile_0.fpll_inst .lckdet_sel = "lckdet_sel_analog";
defparam \xcvr_fpll_s10_htile_0.fpll_inst .lcnt_l_cnt_bypass = "lcnt_normal";
defparam \xcvr_fpll_s10_htile_0.fpll_inst .lcnt_l_cnt_enable = "lcnt_en";
defparam \xcvr_fpll_s10_htile_0.fpll_inst .lf_3rd_pole_freq = "lf_3rd_pole_setting0";
defparam \xcvr_fpll_s10_htile_0.fpll_inst .lf_cbig = "lf_cbig_setting4";
defparam \xcvr_fpll_s10_htile_0.fpll_inst .lf_order = "lf_2nd_order";
defparam \xcvr_fpll_s10_htile_0.fpll_inst .lf_resistance = "lf_res_setting1";
defparam \xcvr_fpll_s10_htile_0.fpll_inst .lf_ripplecap = "lf_no_ripple";
defparam \xcvr_fpll_s10_htile_0.fpll_inst .lockf_lock_fltr_cfg = 12'b000000011001;
defparam \xcvr_fpll_s10_htile_0.fpll_inst .lockf_lock_fltr_test = "pll_lock_fltr_nrm";
defparam \xcvr_fpll_s10_htile_0.fpll_inst .lockf_unlock_fltr_cfg = 3'b010;
defparam \xcvr_fpll_s10_htile_0.fpll_inst .lpf_rstn_value = "lpf_normal";
defparam \xcvr_fpll_s10_htile_0.fpll_inst .m_counter = 8'b00101000;
defparam \xcvr_fpll_s10_htile_0.fpll_inst .m_counter_c0 = 9'b000000000;
defparam \xcvr_fpll_s10_htile_0.fpll_inst .m_counter_c1 = 9'b000000000;
defparam \xcvr_fpll_s10_htile_0.fpll_inst .m_counter_c2 = 9'b000000000;
defparam \xcvr_fpll_s10_htile_0.fpll_inst .m_counter_c3 = 9'b000000000;
defparam \xcvr_fpll_s10_htile_0.fpll_inst .max_fractional_percentage = 7'b1100011;
defparam \xcvr_fpll_s10_htile_0.fpll_inst .mcnt_cnt_div = 9'b000101000;
defparam \xcvr_fpll_s10_htile_0.fpll_inst .mcnt_cnt_min_tco = "cnt_bypass_dly";
defparam \xcvr_fpll_s10_htile_0.fpll_inst .mcnt_coarse_dly = "pll_coarse_dly_setting0";
defparam \xcvr_fpll_s10_htile_0.fpll_inst .mcnt_fine_dly = "pll_fine_dly_setting0";
defparam \xcvr_fpll_s10_htile_0.fpll_inst .mcnt_m_cnt_in_src = "m_cnt_in_src_ph_mux_clk";
defparam \xcvr_fpll_s10_htile_0.fpll_inst .mcnt_m_cnt_ph_mux_prst = 2'b00;
defparam \xcvr_fpll_s10_htile_0.fpll_inst .mcnt_m_cnt_prst = 8'b00000001;
defparam \xcvr_fpll_s10_htile_0.fpll_inst .min_fractional_percentage = 7'b0000001;
defparam \xcvr_fpll_s10_htile_0.fpll_inst .n_counter = 6'b000001;
defparam \xcvr_fpll_s10_htile_0.fpll_inst .ncnt_coarse_dly = "pll_coarse_dly_setting0";
defparam \xcvr_fpll_s10_htile_0.fpll_inst .ncnt_fine_dly = "pll_fine_dly_setting0";
defparam \xcvr_fpll_s10_htile_0.fpll_inst .ncnt_ncnt_divide = 5'b00001;
defparam \xcvr_fpll_s10_htile_0.fpll_inst .optimal = "false";
defparam \xcvr_fpll_s10_htile_0.fpll_inst .out_freq = 36'b000000100101010000001011111001000000;
defparam \xcvr_fpll_s10_htile_0.fpll_inst .out_freq_hz = 36'b000000100101010000001011111001000000;
defparam \xcvr_fpll_s10_htile_0.fpll_inst .output_clock_frequency_0 = "625000000";
defparam \xcvr_fpll_s10_htile_0.fpll_inst .output_clock_frequency_1 = "625000000";
defparam \xcvr_fpll_s10_htile_0.fpll_inst .output_clock_frequency_2 = "625000000";
defparam \xcvr_fpll_s10_htile_0.fpll_inst .output_clock_frequency_3 = "625000000";
defparam \xcvr_fpll_s10_htile_0.fpll_inst .output_tolerance = 8'b00000000;
defparam \xcvr_fpll_s10_htile_0.fpll_inst .pfd_delay_compensation = "normal_delay";
defparam \xcvr_fpll_s10_htile_0.fpll_inst .pfd_freq = 36'b000000000111011100110101100101000000;
defparam \xcvr_fpll_s10_htile_0.fpll_inst .pfd_pulse_width = "pulse_width_setting0";
defparam \xcvr_fpll_s10_htile_0.fpll_inst .phase_shift_c0 = 36'b000000000000000000000000000000000000;
defparam \xcvr_fpll_s10_htile_0.fpll_inst .phase_shift_c1 = 36'b000000000000000000000000000000000000;
defparam \xcvr_fpll_s10_htile_0.fpll_inst .phase_shift_c2 = 36'b000000000000000000000000000000000000;
defparam \xcvr_fpll_s10_htile_0.fpll_inst .phase_shift_c3 = 36'b000000000000000000000000000000000000;
defparam \xcvr_fpll_s10_htile_0.fpll_inst .pll_clkin_0_scratch0_src = "pll_clkin_0_scratch0_src_vss";
defparam \xcvr_fpll_s10_htile_0.fpll_inst .pll_clkin_0_scratch1_src = "pll_clkin_0_scratch1_src_vss";
defparam \xcvr_fpll_s10_htile_0.fpll_inst .pll_clkin_0_scratch2_src = "pll_clkin_0_scratch2_src_vss";
defparam \xcvr_fpll_s10_htile_0.fpll_inst .pll_clkin_0_scratch3_src = "pll_clkin_0_scratch3_src_vss";
defparam \xcvr_fpll_s10_htile_0.fpll_inst .pll_clkin_0_scratch4_src = "pll_clkin_0_scratch4_src_vss";
defparam \xcvr_fpll_s10_htile_0.fpll_inst .pll_clkin_1_scratch0_src = "pll_clkin_1_scratch0_src_vss";
defparam \xcvr_fpll_s10_htile_0.fpll_inst .pll_clkin_1_scratch1_src = "pll_clkin_1_scratch1_src_vss";
defparam \xcvr_fpll_s10_htile_0.fpll_inst .pll_clkin_1_scratch2_src = "pll_clkin_1_scratch2_src_vss";
defparam \xcvr_fpll_s10_htile_0.fpll_inst .pll_clkin_1_scratch3_src = "pll_clkin_1_scratch3_src_vss";
defparam \xcvr_fpll_s10_htile_0.fpll_inst .pll_clkin_1_scratch4_src = "pll_clkin_1_scratch4_src_vss";
defparam \xcvr_fpll_s10_htile_0.fpll_inst .pll_dsm_out_sel = "pll_dsm_disable";
defparam \xcvr_fpll_s10_htile_0.fpll_inst .pll_ecn_bypass = "pll_ecn_bypass_disable";
defparam \xcvr_fpll_s10_htile_0.fpll_inst .pll_ecn_test_en = "pll_ecn_test_disable";
defparam \xcvr_fpll_s10_htile_0.fpll_inst .pll_fractional_division = 32'b00000000000000000000000000000000;
defparam \xcvr_fpll_s10_htile_0.fpll_inst .pll_fractional_value_ready = "pll_k_ready";
defparam \xcvr_fpll_s10_htile_0.fpll_inst .pll_l_counter = 8;
defparam \xcvr_fpll_s10_htile_0.fpll_inst .pll_op_mode = "false";
defparam \xcvr_fpll_s10_htile_0.fpll_inst .pll_vco_freq_band_0_dyn_high_bits = 2'b01;
defparam \xcvr_fpll_s10_htile_0.fpll_inst .pll_vco_freq_band_0_dyn_low_bits = 3'b011;
defparam \xcvr_fpll_s10_htile_0.fpll_inst .pll_vco_freq_band_0_fix = 5'b10100;
defparam \xcvr_fpll_s10_htile_0.fpll_inst .pll_vco_freq_band_0_fix_high = "pll_vco_freq_band_0_fix_high_0";
defparam \xcvr_fpll_s10_htile_0.fpll_inst .pll_vco_freq_band_1_dyn_high_bits = 2'b01;
defparam \xcvr_fpll_s10_htile_0.fpll_inst .pll_vco_freq_band_1_dyn_low_bits = 3'b011;
defparam \xcvr_fpll_s10_htile_0.fpll_inst .pll_vco_freq_band_1_fix = 5'b10100;
defparam \xcvr_fpll_s10_htile_0.fpll_inst .pll_vco_freq_band_1_fix_high = "pll_vco_freq_band_1_fix_high_0";
defparam \xcvr_fpll_s10_htile_0.fpll_inst .pma_width = 7'b1000000;
defparam \xcvr_fpll_s10_htile_0.fpll_inst .power_mode = "mid_power";
defparam \xcvr_fpll_s10_htile_0.fpll_inst .power_rail_er = 12'b000000000000;
defparam \xcvr_fpll_s10_htile_0.fpll_inst .power_rail_et = 12'b000000000000;
defparam \xcvr_fpll_s10_htile_0.fpll_inst .powerdown_mode = "powerup";
defparam \xcvr_fpll_s10_htile_0.fpll_inst .powermode_ac_ccnt0 = "fpll_ccnt0_ac";
defparam \xcvr_fpll_s10_htile_0.fpll_inst .powermode_ac_ccnt1 = "fpll_ccnt1_ac_off";
defparam \xcvr_fpll_s10_htile_0.fpll_inst .powermode_ac_ccnt2 = "fpll_ccnt2_ac_off";
defparam \xcvr_fpll_s10_htile_0.fpll_inst .powermode_ac_ccnt3 = "fpll_ccnt3_ac_off";
defparam \xcvr_fpll_s10_htile_0.fpll_inst .powermode_ac_lcnt = "fpll_lcnt_bypass_ac_1p0";
defparam \xcvr_fpll_s10_htile_0.fpll_inst .powermode_ac_vco = "fpll_vco_ac_1p0";
defparam \xcvr_fpll_s10_htile_0.fpll_inst .powermode_dc_ccnt0 = "powerdown_fpll_ccnt0";
defparam \xcvr_fpll_s10_htile_0.fpll_inst .powermode_dc_ccnt1 = "powerdown_fpll_ccnt1";
defparam \xcvr_fpll_s10_htile_0.fpll_inst .powermode_dc_ccnt2 = "powerdown_fpll_ccnt2";
defparam \xcvr_fpll_s10_htile_0.fpll_inst .powermode_dc_ccnt3 = "powerdown_fpll_ccnt3";
defparam \xcvr_fpll_s10_htile_0.fpll_inst .powermode_dc_lcnt = "fpll_lcnt_bypass_dc_1p0";
defparam \xcvr_fpll_s10_htile_0.fpll_inst .powermode_dc_vco = "fpll_vco_dc_1p0";
defparam \xcvr_fpll_s10_htile_0.fpll_inst .ppm_clk0_src = "ppm_clk0_vss";
defparam \xcvr_fpll_s10_htile_0.fpll_inst .ppm_clk1_src = "ppm_clk1_vss";
defparam \xcvr_fpll_s10_htile_0.fpll_inst .ppmdtct_lock_thresld = "ppmdtct_lock_0";
defparam \xcvr_fpll_s10_htile_0.fpll_inst .ppmdtct_noclk_thresld = "ppmdtct_noclk_0";
defparam \xcvr_fpll_s10_htile_0.fpll_inst .ppmdtct_pll_sel = "ppmdtct_sel_fpll";
defparam \xcvr_fpll_s10_htile_0.fpll_inst .primary_use = "tx";
defparam \xcvr_fpll_s10_htile_0.fpll_inst .prot_mode = "basic_tx";
defparam \xcvr_fpll_s10_htile_0.fpll_inst .ref_ref_buf_dly = "pll_ref_buf_dly_setting0";
defparam \xcvr_fpll_s10_htile_0.fpll_inst .refclk = 36'b000000000111011100110101100101000000;
defparam \xcvr_fpll_s10_htile_0.fpll_inst .refclk_source = "normal_refclk";
defparam \xcvr_fpll_s10_htile_0.fpll_inst .reference_clock_frequency = "125000000";
defparam \xcvr_fpll_s10_htile_0.fpll_inst .rstn_override = "user_reset_normal";
defparam \xcvr_fpll_s10_htile_0.fpll_inst .set_input_freq_range = 8'b00000000;
defparam \xcvr_fpll_s10_htile_0.fpll_inst .side = "side_unknown";
defparam \xcvr_fpll_s10_htile_0.fpll_inst .silicon_rev = "14nm7acr2eb";
defparam \xcvr_fpll_s10_htile_0.fpll_inst .speed_grade = "speed_off";
defparam \xcvr_fpll_s10_htile_0.fpll_inst .sup_mode = "user_mode";
defparam \xcvr_fpll_s10_htile_0.fpll_inst .testmux_tclk_mux_en = "pll_tclk_mux_disabled";
defparam \xcvr_fpll_s10_htile_0.fpll_inst .testmux_tclk_sel = "pll_tclk_m_src";
defparam \xcvr_fpll_s10_htile_0.fpll_inst .top_or_bottom = "top_or_bot_off";
defparam \xcvr_fpll_s10_htile_0.fpll_inst .vccdreg_fb = "vreg_fb0";
defparam \xcvr_fpll_s10_htile_0.fpll_inst .vccdreg_fw = "vreg_fw0";
defparam \xcvr_fpll_s10_htile_0.fpll_inst .vco_div_by_2_sel = "bypass_divide_by_2";
defparam \xcvr_fpll_s10_htile_0.fpll_inst .vco_freq = 36'b001001010100000010111110010000000000;
defparam \xcvr_fpll_s10_htile_0.fpll_inst .vco_freq_hz = 36'b001001010100000010111110010000000000;
defparam \xcvr_fpll_s10_htile_0.fpll_inst .vco_frequency = "10000000000";
defparam \xcvr_fpll_s10_htile_0.fpll_inst .vco_ph0_en = "pll_vco_ph0_en";
defparam \xcvr_fpll_s10_htile_0.fpll_inst .vco_ph0_value = "pll_vco_ph0_vss";
defparam \xcvr_fpll_s10_htile_0.fpll_inst .vco_ph1_en = "pll_vco_ph1_dis_en";
defparam \xcvr_fpll_s10_htile_0.fpll_inst .vco_ph1_value = "pll_vco_ph1_vss";
defparam \xcvr_fpll_s10_htile_0.fpll_inst .vco_ph2_en = "pll_vco_ph2_dis_en";
defparam \xcvr_fpll_s10_htile_0.fpll_inst .vco_ph2_value = "pll_vco_ph2_vss";
defparam \xcvr_fpll_s10_htile_0.fpll_inst .vco_ph3_en = "pll_vco_ph3_dis_en";
defparam \xcvr_fpll_s10_htile_0.fpll_inst .vco_ph3_value = "pll_vco_ph3_vss";
defparam \xcvr_fpll_s10_htile_0.fpll_inst .vreg0_atbsel = "atb_disabled";
defparam \xcvr_fpll_s10_htile_0.fpll_inst .vreg1_atbsel = "atb_disabled1";

ct1_cmu_fpll_pld_adapt \xcvr_fpll_s10_htile_0.cmu_fpll_pld_adapt_inst (
	.avmmclk(\xcvr_fpll_s10_htile_0.xcvr_avmm2_inst.pll_avmm_clk[0] ),
	.dps_rst_n(gnd),
	.extswitch_buf(gnd),
	.fbclkin(gnd),
	.int_clk0_bad(gnd),
	.int_clk1_bad(gnd),
	.int_clklow(\xcvr_fpll_s10_htile_0.fpll_inst_O_CLKLOW ),
	.int_fbclkout(gnd),
	.int_fref(\xcvr_fpll_s10_htile_0.fpll_inst_O_FREF ),
	.int_lock(\xcvr_fpll_s10_htile_0.fpll_inst_O_LOCK ),
	.int_phase_done(\xcvr_fpll_s10_htile_0.fpll_inst_PHASEDONE ),
	.pfden(vcc),
	.phase_en(gnd),
	.pllclksel(gnd),
	.rst_n(vcc),
	.up_dn(gnd),
	.cnt_sel({gnd,gnd,gnd,gnd}),
	.fpll_ppm_clk({gnd,gnd}),
	.int_pllcout({\xcvr_fpll_s10_htile_0.fpll_inst_O_PLLCOUT3 ,\xcvr_fpll_s10_htile_0.fpll_inst_O_PLLCOUT2 ,\xcvr_fpll_s10_htile_0.fpll_inst_O_PLLCOUT1 ,\xcvr_fpll_s10_htile_0.fpll_inst_pllcout }),
	.num_phase_shifts({gnd,gnd,vcc}),
	.clk0_bad(\xcvr_fpll_s10_htile_0.cmu_fpll_pld_adapt_inst_O_CLK0_BAD ),
	.clk1_bad(),
	.clklow(),
	.fbclkout(),
	.fref(),
	.int_dps_rst_n(\xcvr_fpll_s10_htile_0.cmu_fpll_pld_adapt_inst_O_INT_DPS_RST_N ),
	.int_extswitch_buf(),
	.int_fbclkin(),
	.int_pfden(),
	.int_phase_en(\xcvr_fpll_s10_htile_0.cmu_fpll_pld_adapt_inst_O_INT_PHASE_EN ),
	.int_pllclksel(),
	.int_rst_n(\xcvr_fpll_s10_htile_0.cmu_fpll_pld_adapt_inst_O_INT_RST_N ),
	.int_up_dn(\xcvr_fpll_s10_htile_0.cmu_fpll_pld_adapt_inst_O_INT_UP_DN ),
	.lock(\xcvr_fpll_s10_htile_0.cmu_fpll_pld_adapt_inst_O_LOCK ),
	.phase_done(),
	.int_cnt_sel(\xcvr_fpll_s10_htile_0.cmu_fpll_pld_adapt_inst_INT_CNT_SEL_bus ),
	.int_fpll_ppm_clk(),
	.int_num_phase_shifts(\xcvr_fpll_s10_htile_0.cmu_fpll_pld_adapt_inst_INT_NUM_PHASE_SHIFTS_bus ),
	.pllcout());
defparam \xcvr_fpll_s10_htile_0.cmu_fpll_pld_adapt_inst .silicon_rev = "14nm5bcr1";

ct1_hssi_avmm2_if \xcvr_fpll_s10_htile_0.xcvr_avmm2_inst.avmm_atom_insts[0].ct1_hssi_avmm2_if_inst (
	.aib_fabric_avmm2_data_in(gnd),
	.aib_fabric_fsr_data_in(gnd),
	.aib_fabric_fsr_load_in(gnd),
	.aib_fabric_osc_whr_clk_in(gnd),
	.aib_fabric_ssr_data_in(gnd),
	.aib_fabric_ssr_load_in(gnd),
	.avmmclk(gnd),
	.avmmread(gnd),
	.avmmrequest(gnd),
	.avmmwrite(gnd),
	.ehip_usr_rdatavld(gnd),
	.ehip_usr_wrdone(gnd),
	.hip_avmm_read(gnd),
	.hip_avmm_write(gnd),
	.hip_fsr_parity_checker_in(gnd),
	.tx_async_fabric_hssi_fsr_data(gnd),
	.tx_fsr_parity_checker_in(gnd),
	.avmmaddress({gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd}),
	.avmmreservedin(10'b0000000000),
	.avmmwritedata({gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd}),
	.blockselect({gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,\xcvr_fpll_s10_htile_0.fpll_refclk_select_inst_O_BLOCKSELECT ,
\xcvr_fpll_s10_htile_0.fpll_inst_O_BLOCK_SELECT ,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd}),
	.ehip_usr_rdata(8'b00000000),
	.hip_aib_async_fsr_in(4'b0000),
	.hip_aib_async_ssr_in(40'b0000000000000000000000000000000000000000),
	.hip_aib_avmm_out({gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd}),
	.hip_avmm_reg_addr({gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd}),
	.hip_avmm_writedata({gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd}),
	.hip_ssr_parity_checker_in(6'b000000),
	.readdatachnl({gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,
gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,
gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,
gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,
gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,
gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,\xcvr_fpll_s10_htile_0.fpll_refclk_select_inst_O_AVMMREADDATA7 ,\xcvr_fpll_s10_htile_0.fpll_refclk_select_inst_O_AVMMREADDATA6 ,
\xcvr_fpll_s10_htile_0.fpll_refclk_select_inst_O_AVMMREADDATA5 ,\xcvr_fpll_s10_htile_0.fpll_refclk_select_inst_O_AVMMREADDATA4 ,\xcvr_fpll_s10_htile_0.fpll_refclk_select_inst_O_AVMMREADDATA3 ,\xcvr_fpll_s10_htile_0.fpll_refclk_select_inst_O_AVMMREADDATA2 ,
\xcvr_fpll_s10_htile_0.fpll_refclk_select_inst_O_AVMMREADDATA1 ,\xcvr_fpll_s10_htile_0.fpll_refclk_select_inst_O_AVMMREADDATA0 ,\xcvr_fpll_s10_htile_0.fpll_inst_O_READDATA7 ,\xcvr_fpll_s10_htile_0.fpll_inst_O_READDATA6 ,
\xcvr_fpll_s10_htile_0.fpll_inst_O_READDATA5 ,\xcvr_fpll_s10_htile_0.fpll_inst_O_READDATA4 ,\xcvr_fpll_s10_htile_0.fpll_inst_O_READDATA3 ,\xcvr_fpll_s10_htile_0.fpll_inst_O_READDATA2 ,\xcvr_fpll_s10_htile_0.fpll_inst_O_READDATA1 ,
\xcvr_fpll_s10_htile_0.fpll_inst_O_READDATA0 ,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,
gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd}),
	.rx_async_fabric_hssi_fsr_data(3'b000),
	.rx_async_fabric_hssi_ssr_data(36'b000000000000000000000000000000000000),
	.rx_async_fabric_hssi_ssr_reserved(2'b00),
	.rx_fsr_parity_checker_in(2'b00),
	.rx_ssr_parity_checker_in(65'b00000000000000000000000000000000000000000000000000000000000000000),
	.tx_async_fabric_hssi_ssr_data(36'b000000000000000000000000000000000000),
	.tx_async_fabric_hssi_ssr_reserved(3'b000),
	.tx_ssr_parity_checker_in(16'b0000000000000000),
	.aib_fabric_fsr_data_out(),
	.aib_fabric_fsr_load_out(),
	.aib_fabric_osc_whr_clk_out(),
	.aib_fabric_ssr_data_out(),
	.aib_fabric_ssr_load_out(),
	.avmm1_hssi_fabric_ssr_load(),
	.avmm_cmdfifo_wr_full(),
	.avmm_cmdfifo_wr_pfull(),
	.avmm_readdatavalid(),
	.avmmbusy(),
	.clkchnl(\xcvr_fpll_s10_htile_0.xcvr_avmm2_inst.pll_avmm_clk[0] ),
	.ehip_usr_clk(),
	.ehip_usr_read(),
	.ehip_usr_write(),
	.hip_aib_avmm_clk(),
	.hip_avmm_readdatavalid(),
	.hip_avmm_writedone(),
	.hipcaldone(),
	.pld_hssi_osc_transfer_en(\xcvr_fpll_s10_htile_0.xcvr_avmm2_inst.pld_hssi_osc_transfer_en[0] ),
	.pldcaldone(\xcvr_fpll_s10_htile_0.xcvr_avmm2_inst.pld_cal_done[0] ),
	.readchnl(\xcvr_fpll_s10_htile_0.xcvr_avmm2_inst.pll_avmm_read[0] ),
	.rx_async_fabric_hssi_fsr_load(),
	.rx_async_fabric_hssi_ssr_load(),
	.rx_async_hssi_fabric_fsr_load(),
	.rx_async_hssi_fabric_ssr_load(),
	.tx_async_fabric_hssi_fsr_load(),
	.tx_async_fabric_hssi_ssr_load(),
	.tx_async_hssi_fabric_fsr_data(),
	.tx_async_hssi_fabric_fsr_load(),
	.tx_async_hssi_fabric_ssr_load(),
	.writechnl(\xcvr_fpll_s10_htile_0.xcvr_avmm2_inst.pll_avmm_write[0] ),
	.aib_fabric_avmm2_data_out(),
	.avmm1_hssi_fabric_ssr_data(),
	.avmmreaddata(),
	.avmmreservedout(),
	.ct3_regaddrchnl(),
	.ehip_usr_addr(),
	.ehip_usr_wdata(),
	.hip_aib_async_fsr_out(),
	.hip_aib_async_ssr_out(),
	.hip_aib_avmm_in(),
	.hip_avmm_readdata(),
	.hip_avmm_reserved_out(),
	.regaddrchnl(\xcvr_fpll_s10_htile_0.xcvr_avmm2_inst.avmm_atom_insts[0].ct1_hssi_avmm2_if_inst_REGADDRCHNL_bus ),
	.rx_async_hssi_fabric_fsr_data(),
	.rx_async_hssi_fabric_ssr_data(),
	.rx_async_hssi_fabric_ssr_reserved(),
	.tx_async_hssi_fabric_ssr_data(),
	.tx_async_hssi_fabric_ssr_reserved(),
	.writedatachnl(\xcvr_fpll_s10_htile_0.xcvr_avmm2_inst.avmm_atom_insts[0].ct1_hssi_avmm2_if_inst_WRITEDATACHNL_bus ));
defparam \xcvr_fpll_s10_htile_0.xcvr_avmm2_inst.avmm_atom_insts[0].ct1_hssi_avmm2_if_inst .calibration_type = "one_time";
defparam \xcvr_fpll_s10_htile_0.xcvr_avmm2_inst.avmm_atom_insts[0].ct1_hssi_avmm2_if_inst .func_mode = "c3adpt_pmadir";
defparam \xcvr_fpll_s10_htile_0.xcvr_avmm2_inst.avmm_atom_insts[0].ct1_hssi_avmm2_if_inst .hssiadapt_avmm_clk_dcg_en = "disable";
defparam \xcvr_fpll_s10_htile_0.xcvr_avmm2_inst.avmm_atom_insts[0].ct1_hssi_avmm2_if_inst .hssiadapt_avmm_clk_scg_en = "disable";
defparam \xcvr_fpll_s10_htile_0.xcvr_avmm2_inst.avmm_atom_insts[0].ct1_hssi_avmm2_if_inst .hssiadapt_avmm_osc_clock_setting = "osc_clk_div_by1";
defparam \xcvr_fpll_s10_htile_0.xcvr_avmm2_inst.avmm_atom_insts[0].ct1_hssi_avmm2_if_inst .hssiadapt_avmm_testbus_sel = "avmm1_transfer_testbus";
defparam \xcvr_fpll_s10_htile_0.xcvr_avmm2_inst.avmm_atom_insts[0].ct1_hssi_avmm2_if_inst .hssiadapt_hip_mode = "disable_hip";
defparam \xcvr_fpll_s10_htile_0.xcvr_avmm2_inst.avmm_atom_insts[0].ct1_hssi_avmm2_if_inst .hssiadapt_osc_clk_scg_en = "disable";
defparam \xcvr_fpll_s10_htile_0.xcvr_avmm2_inst.avmm_atom_insts[0].ct1_hssi_avmm2_if_inst .pcs_arbiter_ctrl = "avmm2_arbiter_uc_sel";
defparam \xcvr_fpll_s10_htile_0.xcvr_avmm2_inst.avmm_atom_insts[0].ct1_hssi_avmm2_if_inst .pcs_cal_done = "avmm2_cal_done_deassert";
defparam \xcvr_fpll_s10_htile_0.xcvr_avmm2_inst.avmm_atom_insts[0].ct1_hssi_avmm2_if_inst .pcs_cal_reserved = 5'b00000;
defparam \xcvr_fpll_s10_htile_0.xcvr_avmm2_inst.avmm_atom_insts[0].ct1_hssi_avmm2_if_inst .pcs_calibration_feature_en = "avmm2_pcs_calibration_en";
defparam \xcvr_fpll_s10_htile_0.xcvr_avmm2_inst.avmm_atom_insts[0].ct1_hssi_avmm2_if_inst .pcs_hip_cal_en = "disable";
defparam \xcvr_fpll_s10_htile_0.xcvr_avmm2_inst.avmm_atom_insts[0].ct1_hssi_avmm2_if_inst .pldadapt_avmm_clk_scg_en = "disable";
defparam \xcvr_fpll_s10_htile_0.xcvr_avmm2_inst.avmm_atom_insts[0].ct1_hssi_avmm2_if_inst .pldadapt_avmm_osc_clock_setting = "osc_clk_div_by1";
defparam \xcvr_fpll_s10_htile_0.xcvr_avmm2_inst.avmm_atom_insts[0].ct1_hssi_avmm2_if_inst .pldadapt_avmm_testbus_sel = "avmm1_transfer_testbus";
defparam \xcvr_fpll_s10_htile_0.xcvr_avmm2_inst.avmm_atom_insts[0].ct1_hssi_avmm2_if_inst .pldadapt_gate_dis = "disable";
defparam \xcvr_fpll_s10_htile_0.xcvr_avmm2_inst.avmm_atom_insts[0].ct1_hssi_avmm2_if_inst .pldadapt_hip_mode = "disable_hip";
defparam \xcvr_fpll_s10_htile_0.xcvr_avmm2_inst.avmm_atom_insts[0].ct1_hssi_avmm2_if_inst .pldadapt_osc_clk_scg_en = "disable";
defparam \xcvr_fpll_s10_htile_0.xcvr_avmm2_inst.avmm_atom_insts[0].ct1_hssi_avmm2_if_inst .silicon_rev = "14nm7acr2eb";
defparam \xcvr_fpll_s10_htile_0.xcvr_avmm2_inst.avmm_atom_insts[0].ct1_hssi_avmm2_if_inst .topology = "disabled_block";

ct1_cmu_fpll_refclk_select \xcvr_fpll_s10_htile_0.fpll_refclk_select_inst (
	.avmmclk(\xcvr_fpll_s10_htile_0.xcvr_avmm2_inst.pll_avmm_clk[0] ),
	.avmmread(\xcvr_fpll_s10_htile_0.xcvr_avmm2_inst.pll_avmm_read[0] ),
	.avmmwrite(\xcvr_fpll_s10_htile_0.xcvr_avmm2_inst.pll_avmm_write[0] ),
	.core_refclk(gnd),
	.extswitch(gnd),
	.lvpecl_in(gnd),
	.pll_cas_in(gnd),
	.tx_rx_core_refclk(gnd),
	.avmmaddress({\xcvr_fpll_s10_htile_0.xcvr_avmm2_inst.pll_avmm_address[9] ,\xcvr_fpll_s10_htile_0.xcvr_avmm2_inst.pll_avmm_address[8] ,\xcvr_fpll_s10_htile_0.xcvr_avmm2_inst.pll_avmm_address[7] ,\xcvr_fpll_s10_htile_0.xcvr_avmm2_inst.pll_avmm_address[6] ,
\xcvr_fpll_s10_htile_0.xcvr_avmm2_inst.pll_avmm_address[5] ,\xcvr_fpll_s10_htile_0.xcvr_avmm2_inst.pll_avmm_address[4] ,\xcvr_fpll_s10_htile_0.xcvr_avmm2_inst.pll_avmm_address[3] ,\xcvr_fpll_s10_htile_0.xcvr_avmm2_inst.pll_avmm_address[2] ,
\xcvr_fpll_s10_htile_0.xcvr_avmm2_inst.pll_avmm_address[1] ,\xcvr_fpll_s10_htile_0.xcvr_avmm2_inst.pll_avmm_address[0] }),
	.avmmwritedata({\xcvr_fpll_s10_htile_0.xcvr_avmm2_inst.pll_avmm_writedata[7] ,\xcvr_fpll_s10_htile_0.xcvr_avmm2_inst.pll_avmm_writedata[6] ,\xcvr_fpll_s10_htile_0.xcvr_avmm2_inst.pll_avmm_writedata[5] ,\xcvr_fpll_s10_htile_0.xcvr_avmm2_inst.pll_avmm_writedata[4] ,
\xcvr_fpll_s10_htile_0.xcvr_avmm2_inst.pll_avmm_writedata[3] ,\xcvr_fpll_s10_htile_0.xcvr_avmm2_inst.pll_avmm_writedata[2] ,\xcvr_fpll_s10_htile_0.xcvr_avmm2_inst.pll_avmm_writedata[1] ,\xcvr_fpll_s10_htile_0.xcvr_avmm2_inst.pll_avmm_writedata[0] }),
	.iqtxrxclk({gnd,gnd,gnd,gnd,gnd,gnd}),
	.ref_iqclk({gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,pll_refclk0}),
	.blockselect(\xcvr_fpll_s10_htile_0.fpll_refclk_select_inst_O_BLOCKSELECT ),
	.clk0bad(),
	.clk1bad(),
	.clkout(\xcvr_fpll_s10_htile_0.fpll_refclk_select_inst_clkout ),
	.extswitch_buf(),
	.pllclksel(),
	.avmmreaddata(\xcvr_fpll_s10_htile_0.fpll_refclk_select_inst_AVMMREADDATA_bus ),
	.clk(\xcvr_fpll_s10_htile_0.fpll_refclk_select_inst_CLK_bus ));
defparam \xcvr_fpll_s10_htile_0.fpll_refclk_select_inst .clk_sel_override = "normal";
defparam \xcvr_fpll_s10_htile_0.fpll_refclk_select_inst .clk_sel_override_value = "select_clk0";
defparam \xcvr_fpll_s10_htile_0.fpll_refclk_select_inst .mux0_inclk0_logical_to_physical_mapping = "ref_iqclk0";
defparam \xcvr_fpll_s10_htile_0.fpll_refclk_select_inst .mux0_inclk1_logical_to_physical_mapping = "power_down";
defparam \xcvr_fpll_s10_htile_0.fpll_refclk_select_inst .mux0_inclk2_logical_to_physical_mapping = "power_down";
defparam \xcvr_fpll_s10_htile_0.fpll_refclk_select_inst .mux0_inclk3_logical_to_physical_mapping = "power_down";
defparam \xcvr_fpll_s10_htile_0.fpll_refclk_select_inst .mux0_inclk4_logical_to_physical_mapping = "power_down";
defparam \xcvr_fpll_s10_htile_0.fpll_refclk_select_inst .mux1_inclk0_logical_to_physical_mapping = "ref_iqclk0";
defparam \xcvr_fpll_s10_htile_0.fpll_refclk_select_inst .mux1_inclk1_logical_to_physical_mapping = "power_down";
defparam \xcvr_fpll_s10_htile_0.fpll_refclk_select_inst .mux1_inclk2_logical_to_physical_mapping = "power_down";
defparam \xcvr_fpll_s10_htile_0.fpll_refclk_select_inst .mux1_inclk3_logical_to_physical_mapping = "power_down";
defparam \xcvr_fpll_s10_htile_0.fpll_refclk_select_inst .mux1_inclk4_logical_to_physical_mapping = "power_down";
defparam \xcvr_fpll_s10_htile_0.fpll_refclk_select_inst .pm_cmu_fpll_atom_fpll_iq0_scratch0_src = "iq0_scratch0_power_down";
defparam \xcvr_fpll_s10_htile_0.fpll_refclk_select_inst .pm_cmu_fpll_atom_fpll_iq0_scratch1_src = "iq0_scratch1_power_down";
defparam \xcvr_fpll_s10_htile_0.fpll_refclk_select_inst .pm_cmu_fpll_atom_fpll_iq0_scratch2_src = "iq0_scratch2_power_down";
defparam \xcvr_fpll_s10_htile_0.fpll_refclk_select_inst .pm_cmu_fpll_atom_fpll_iq0_scratch3_src = "iq0_scratch3_power_down";
defparam \xcvr_fpll_s10_htile_0.fpll_refclk_select_inst .pm_cmu_fpll_atom_fpll_iq0_scratch4_src = "iq0_scratch4_power_down";
defparam \xcvr_fpll_s10_htile_0.fpll_refclk_select_inst .pm_cmu_fpll_atom_fpll_iq1_scratch0_src = "iq1_scratch0_power_down";
defparam \xcvr_fpll_s10_htile_0.fpll_refclk_select_inst .pm_cmu_fpll_atom_fpll_iq1_scratch1_src = "iq1_scratch1_power_down";
defparam \xcvr_fpll_s10_htile_0.fpll_refclk_select_inst .pm_cmu_fpll_atom_fpll_iq1_scratch2_src = "iq1_scratch2_power_down";
defparam \xcvr_fpll_s10_htile_0.fpll_refclk_select_inst .pm_cmu_fpll_atom_fpll_iq1_scratch3_src = "iq1_scratch3_power_down";
defparam \xcvr_fpll_s10_htile_0.fpll_refclk_select_inst .pm_cmu_fpll_atom_fpll_iq1_scratch4_src = "iq1_scratch4_power_down";
defparam \xcvr_fpll_s10_htile_0.fpll_refclk_select_inst .pm_cmu_fpll_atom_pll_clkin_0_scratch0_src = "pll_clkin_0_scratch0_src_vss";
defparam \xcvr_fpll_s10_htile_0.fpll_refclk_select_inst .pm_cmu_fpll_atom_pll_clkin_0_scratch1_src = "pll_clkin_0_scratch1_src_vss";
defparam \xcvr_fpll_s10_htile_0.fpll_refclk_select_inst .pm_cmu_fpll_atom_pll_clkin_0_scratch2_src = "pll_clkin_0_scratch2_src_vss";
defparam \xcvr_fpll_s10_htile_0.fpll_refclk_select_inst .pm_cmu_fpll_atom_pll_clkin_0_scratch3_src = "pll_clkin_0_scratch3_src_vss";
defparam \xcvr_fpll_s10_htile_0.fpll_refclk_select_inst .pm_cmu_fpll_atom_pll_clkin_0_scratch4_src = "pll_clkin_0_scratch4_src_vss";
defparam \xcvr_fpll_s10_htile_0.fpll_refclk_select_inst .pm_cmu_fpll_atom_pll_clkin_1_scratch0_src = "pll_clkin_1_scratch0_src_vss";
defparam \xcvr_fpll_s10_htile_0.fpll_refclk_select_inst .pm_cmu_fpll_atom_pll_clkin_1_scratch1_src = "pll_clkin_1_scratch1_src_vss";
defparam \xcvr_fpll_s10_htile_0.fpll_refclk_select_inst .pm_cmu_fpll_atom_pll_clkin_1_scratch2_src = "pll_clkin_1_scratch2_src_vss";
defparam \xcvr_fpll_s10_htile_0.fpll_refclk_select_inst .pm_cmu_fpll_atom_pll_clkin_1_scratch3_src = "pll_clkin_1_scratch3_src_vss";
defparam \xcvr_fpll_s10_htile_0.fpll_refclk_select_inst .pm_cmu_fpll_atom_pll_clkin_1_scratch4_src = "pll_clkin_1_scratch4_src_vss";
defparam \xcvr_fpll_s10_htile_0.fpll_refclk_select_inst .powerdown_mode = "powerup";
defparam \xcvr_fpll_s10_htile_0.fpll_refclk_select_inst .refclk_select0 = "ref_iqclk0";
defparam \xcvr_fpll_s10_htile_0.fpll_refclk_select_inst .refclk_select1 = "ref_iqclk0";
defparam \xcvr_fpll_s10_htile_0.fpll_refclk_select_inst .silicon_rev = "14nm7acr2eb";
defparam \xcvr_fpll_s10_htile_0.fpll_refclk_select_inst .sup_mode = "user_mode";
defparam \xcvr_fpll_s10_htile_0.fpll_refclk_select_inst .xpm_clkin_fpll_pll_clkin_0_src = "pll_clkin_0_src_ref_clk";
defparam \xcvr_fpll_s10_htile_0.fpll_refclk_select_inst .xpm_clkin_fpll_pll_clkin_1_src = "pll_clkin_1_src_vss";
defparam \xcvr_fpll_s10_htile_0.fpll_refclk_select_inst .xpm_clkin_fpll_xpm_pll_so_pll_auto_clk_sw_en = "pll_auto_clk_sw_disabled";
defparam \xcvr_fpll_s10_htile_0.fpll_refclk_select_inst .xpm_clkin_fpll_xpm_pll_so_pll_clk_loss_edge = "pll_clk_loss_rising_edge";
defparam \xcvr_fpll_s10_htile_0.fpll_refclk_select_inst .xpm_clkin_fpll_xpm_pll_so_pll_clk_loss_sw_en = "pll_clk_loss_sw_byps";
defparam \xcvr_fpll_s10_htile_0.fpll_refclk_select_inst .xpm_clkin_fpll_xpm_pll_so_pll_clk_sw_dly = 3'b000;
defparam \xcvr_fpll_s10_htile_0.fpll_refclk_select_inst .xpm_clkin_fpll_xpm_pll_so_pll_manu_clk_sw_en = "pll_manu_clk_sw_disabled";
defparam \xcvr_fpll_s10_htile_0.fpll_refclk_select_inst .xpm_clkin_fpll_xpm_pll_so_pll_sw_refclk_src = "pll_sw_refclk_src_clk_0";
defparam \xcvr_fpll_s10_htile_0.fpll_refclk_select_inst .xpm_iqref_mux0_iqclk_sel = "ref_iqclk0";
defparam \xcvr_fpll_s10_htile_0.fpll_refclk_select_inst .xpm_iqref_mux1_iqclk_sel = "power_down";

fourteennm_lcell_comb \xcvr_fpll_s10_htile_0.xcvr_avmm2_inst.pld_cal_done[0]__wirecell (
	.dataa(~\xcvr_fpll_s10_htile_0.xcvr_avmm2_inst.pld_cal_done[0] ),
	.datab(gnd),
	.datac(gnd),
	.datad(gnd),
	.datae(gnd),
	.dataf(gnd),
	.datag(gnd),
	.datah(gnd),
	.cin(gnd),
	.sharein(gnd),
	.combout(\xcvr_fpll_s10_htile_0.xcvr_avmm2_inst.pld_cal_done[0]__wirecell_combout ),
	.sumout(),
	.cout(),
	.shareout());
defparam \xcvr_fpll_s10_htile_0.xcvr_avmm2_inst.pld_cal_done[0]__wirecell .extended_lut = "off";
defparam \xcvr_fpll_s10_htile_0.xcvr_avmm2_inst.pld_cal_done[0]__wirecell .lut_mask = 64'hAAAAAAAAAAAAAAAA;
defparam \xcvr_fpll_s10_htile_0.xcvr_avmm2_inst.pld_cal_done[0]__wirecell .shared_arith = "off";

assign pll_locked = \xcvr_fpll_s10_htile_0.cmu_fpll_pld_adapt_inst_O_LOCK ;

assign tx_serial_clk = \xcvr_fpll_s10_htile_0.tx_serial_clk ;

assign pll_cal_busy = \xcvr_fpll_s10_htile_0.xcvr_avmm2_inst.pld_cal_done[0]__wirecell_combout ;

endmodule
