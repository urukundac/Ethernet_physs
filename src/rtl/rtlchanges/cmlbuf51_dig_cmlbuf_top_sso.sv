//=====
//
// INTEL CONFIDENTIAL
//
// Copyright 2020,2020 Intel Corporation All Rights Reserved.
//
// The source code contained or described herein and all documents related
// to the source code ("Material") are owned by Intel Corporation or its
// suppliers or licensors. Title to the Material remains with Intel
// Corporation or its suppliers and licensors. The Material contains trade
// secrets and proprietary and confidential information of Intel or its
// suppliers and licensors. The Material is protected by worldwide copyright
// and trade secret laws and treaty provisions. No part of the Material may
// be used, copied, reproduced, modified, published, uploaded, posted,
// transmitted, distributed, or disclosed in any way without Intel's prior
// express written permission.
//
// No license under any patent, copyright, trade secret or other intellectual
// property right is granted to or conferred upon you by disclosure or
// delivery of the Materials, either expressly, by implication, inducement,
// estoppel or otherwise. Any license under such intellectual property rights
// must be express and approved by Intel in writing.
//
//-=#=-
module cmlbuf51_dig_cmlbuf_top_sso (

    //scan signals
    input logic i_fscan_mode_dig,
    input logic i_fscan_rstbypen_dig,
    input logic i_fscan_byprst_b_dig,

    //pwr isolation signals
    input logic i_reg_pwrgood_rst_b_dig, // UPF: srsn(vccdig_nom)

    //cmlbuf
    input logic       i_cmlbuf_en_dig,       // UPF: srsn(vccdig_nom)
    input logic       i_cmlbuf_test_en_dig,  // UPF: srsn(vccdig_nom)
    input logic [6:0] i_cmlbuf_sel_tail_dig, // UPF: srsn(vccdig_nom)

    //cml2cmos
    input logic i_cml2cmos_en_dig, // UPF: srsn(vccdig_nom)

    //cmlclk
    input logic i_clk_pll_reg,        // UPF: srsn(vccreg)
    input logic i_clk_cmlclkin_p_reg, // UPF: srsn(vccreg)
    input logic i_clk_cmlclkin_n_reg, // UPF: srsn(vccreg)

    //adc
    input logic       i_adc_chop_dig,      // UPF: srsn(vccdig_nom)
    input logic       i_adc_delaysel_dig,  // UPF: srsn(vccdig_nom)
    input logic       i_adc_en_h_dig,      // UPF: srsn(vccdig_nom)
    input logic       i_clk_adc_dig,       // UPF: srsn(vccdig_nom)
    input logic [1:0] i_adc_digdftsel_dig, // UPF: srsn(vccdig_nom)

    //anaobs
`ifndef CMLBUF51_MSV_REAL_BMOD
    input logic [19:0] i_anaobs_dig,        // UPF: srsn(vccdig_nom)
    input logic        i_anaobs_rcomp_dig,  // UPF: srsn(vccdig_nom)
`else // CMLBUF51_MSV_REAL_BMOD
    `ifdef CLOCKGEN_XA
        `ifdef RCLK51_MSV_REAL_BMOD
            input real         i_anaobs_dig [19:0], // UPF: srsn(vccdig_nom)
        `else
            input logic [19:0] i_anaobs_dig,        // UPF: srsn(vccdig_nom)
        `endif
    `else
        input real         i_anaobs_dig [19:0], // UPF: srsn(vccdig_nom)
    `endif
    input real         i_anaobs_rcomp_dig,  // UPF: srsn(vccdig_nom)
`endif // CMLBUF51_MSV_REAL_BMOD
    input logic        i_anaobs_en_dig,     // UPF: srsn(vccdig_nom)
    input logic  [4:0] i_anaobs_sel_dig,    // UPF: srsn(vccdig_nom)

    //process monitor
    input logic       i_procmon_biasen_dig,        // UPF: srsn(vccdig_nom)
    input logic       i_procmon_en_cal_dig,        // UPF: srsn(vccdig_nom)
    input logic       i_procmon_en_osc_dig,        // UPF: srsn(vccdig_nom)
    input logic       i_procmon_osc_sel_dig,       // UPF: srsn(vccdig_nom)
    input logic       i_procmon_proxy_gm_step_dig, // UPF: srsn(vccdig_nom)
    input logic       i_procmon_sensor_en_dig,     // UPF: srsn(vccdig_nom)
    input logic       i_procmon_stepen_dig,        // UPF: srsn(vccdig_nom)
    input logic [1:0] i_procmon_user_in_dig,       // UPF: srsn(vccdig_nom)
    input logic [3:0] i_procmon_vdac_sel_dig,      // UPF: srsn(vccdig_nom)
    input logic       i_procmon_vt_step_dig,       // UPF: srsn(vccdig_nom)
    input logic [1:0] i_procmon_xtor_sel_dig,      // UPF: srsn(vccdig_nom)
    input logic [3:0] i_procmon_dlvr_sel_dig,      // UPF: srsn(vccdig_nom)
    input logic [4:0] i_procmon_mux_sel_dig,       // UPF: srsn(vccdig_nom)


    //ovrd regs
    input cmlbuf51_reg_pkg::CMLBUF_OVRD_dword0_t CMLBUF_OVRD_dword0,

    //adc
    output logic o_clk_adc_ph1_dig, // UPF: srsn(vccdig_nom)
    output logic o_adc_sdout_dig,   // UPF: srsn(vccdig_nom)
    output logic o_adc_digobs_dig,  // UPF: srsn(vccdig_nom)

    //cml2cmos clk
    output logic o_clk_cml2cmos_dig, // UPF: srsn(vccdig_nom)

    //cmlclk
    output logic o_clk_cmlclk_p_int_reg, // UPF: srsn(vccreg)
    output logic o_clk_cmlclk_n_int_reg, // UPF: srsn(vccreg)
    output logic o_clk_cmlclkout_p_reg,  // UPF: srsn(vccreg)
    output logic o_clk_cmlclkout_n_reg,  // UPF: srsn(vccreg)

    `include "cmlbufcbb_ldo.ports.v"    

);

logic sso_clk_out;
logic sso_clk_in;
logic sso_pwrgood_in;
logic sso_pwrgood_out;
logic sso_scan_en;
logic sso_clkin_te;
logic sso_clkout_te;
logic sso_gated_clk;
logic sso_empty;

assign sso_clk_in     = i_clk_ldo_comp_dig;
assign sso_gated_clk   = sso_clk_in;
assign sso_clk_out     = i_clk_ldo_comp_dig;
assign sso_pwrgood_in  = i_fscan_rstbypen_dig ? i_fscan_byprst_b_dig : i_dig_pwrgood_rst_b_dig;
assign sso_pwrgood_out = i_fscan_rstbypen_dig ? i_fscan_byprst_b_dig : i_dig_pwrgood_rst_b_dig;
assign sso_scan_en     = i_fscan_mode_dig;
assign sso_clkin_te    = 1'b0;
assign sso_clkout_te   = 1'b0;
assign sso_empty       = 1'b0;

`include "cmlbuf51_include.vh"
//cmlbuf51_sso(SSO_SYNC, SSO_SCAN, SSO_OVRD, SIGNAL, OVRD_SIG, OVRD_VAL)
`cmlbuf51_sso(0,1,1,i_dig_pwrgood_rst_b_dig,CMLBUF_OVRD_dword0.i_dig_pwrgood_rst_b_dig_ovrd,CMLBUF_OVRD_dword0.i_dig_pwrgood_rst_b_dig_ovrd_val)
`cmlbuf51_sso(0,1,1,i_reg_pwrgood_rst_b_dig,CMLBUF_OVRD_dword0.i_reg_pwrgood_iso_b_dig_ovrd,CMLBUF_OVRD_dword0.i_reg_pwrgood_iso_b_dig_ovrd_val)
`cmlbuf51_sso(0,1,1,i_cmlbuf_en_dig,CMLBUF_OVRD_dword0.i_cmlbuf_en_dig_ovrd,CMLBUF_OVRD_dword0.i_cmlbuf_en_dig_ovrd_val)
`cmlbuf51_sso(0,1,0,i_cmlbuf_sel_tail_dig,,)
`cmlbuf51_sso(0,1,0,i_cmlbuf_test_en_dig,,)
`cmlbuf51_sso(0,1,1,i_cml2cmos_en_dig,CMLBUF_OVRD_dword0.i_cml2cmos_en_dig_ovrd,CMLBUF_OVRD_dword0.i_cml2cmos_en_dig_ovrd_val)
`cmlbuf51_sso(0,1,0,i_adc_digdftsel_dig,,)
`cmlbuf51_sso(0,1,0,i_adc_chop_dig,,)
`cmlbuf51_sso(0,1,0,i_adc_delaysel_dig,,)
`cmlbuf51_sso(0,1,0,i_adc_en_h_dig,,)
`cmlbuf51_sso(0,1,0,i_anaobs_en_dig,,)
`cmlbuf51_sso(0,1,0,i_anaobs_sel_dig,,)
`cmlbuf51_sso(0,1,0,i_ldo_pwrdn_lpf_dig,,)
`cmlbuf51_sso(0,1,0,i_ldo_pwrdn_cp_dig,,)
`cmlbuf51_sso(0,1,0,i_ldo_lpf_bypass_dig,,)
`cmlbuf51_sso(0,1,0,i_ldo_amonv_en_dig,,)
`cmlbuf51_sso(0,1,0,i_ldo_rdac_vref_code_dig,,)
`cmlbuf51_sso(0,1,0,i_ldo_rdac1_gray_dig,,)
`cmlbuf51_sso(0,1,0,i_ldo_rdac2_gray_dig,,)
`cmlbuf51_sso(0,1,0,i_ldo_rdac3_gray_dig,,)

//need to not scan observe the reset flop since it contains non-scan data
defparam i_dig_pwrgood_rst_b_dig_mux_sel_flop.gen_scan.scanprotect_flop.OBS_ENABLE = 0;

/*cmlbufcbb_cmlbuf_dfx icbb_cmlbuf (

    //pwr isolation signals
    .i_reg_pwrgood_iso_b_dig (i_reg_pwrgood_rst_b_dig_sso),

    //cmlbuf enable
    .i_cmlbuf_en_dig       (i_cmlbuf_en_dig_sso),
    .i_cmlbuf_sel_tail_dig (i_cmlbuf_sel_tail_dig_sso),
    .i_cmlbuf_test_en_dig  (i_cmlbuf_test_en_dig_sso),

    //cml2cmos
    .i_cml2cmos_en_dig (i_cml2cmos_en_dig_sso),

    //cmlclk
    .i_clk_pll_reg        (i_clk_pll_reg),
    .i_clk_cmlclkin_p_reg (i_clk_cmlclkin_p_reg),
    .i_clk_cmlclkin_n_reg (i_clk_cmlclkin_n_reg),

    //adc
    .i_adc_digdftsel_dig (i_adc_digdftsel_dig_sso),
    .i_adc_chop_dig      (i_adc_chop_dig_sso),
    .i_adc_delaysel_dig  (i_adc_delaysel_dig_sso),
    .i_adc_en_h_dig      (i_adc_en_h_dig_sso),
    .i_clk_adc_dig       (i_clk_adc_dig),

    //anaobs
    .i_anaobs_dig        (i_anaobs_dig),
    .i_anaobs_en_dig     (i_anaobs_en_dig_sso),
    .i_anaobs_sel_dig    (i_anaobs_sel_dig_sso),
    .i_anaobs_rcomp_dig  (i_anaobs_rcomp_dig), 

    //process monitor
    .i_procmon_biasen_dig        (i_procmon_biasen_dig),
    .i_procmon_en_cal_dig        (i_procmon_en_cal_dig),
    .i_procmon_en_osc_dig        (i_procmon_en_osc_dig),
    .i_procmon_osc_sel_dig       (i_procmon_osc_sel_dig),
    .i_procmon_proxy_gm_step_dig (i_procmon_proxy_gm_step_dig),
    .i_procmon_sensor_en_dig     (i_procmon_sensor_en_dig),
    .i_procmon_stepen_dig        (i_procmon_stepen_dig),
    .i_procmon_user_in_dig       (i_procmon_user_in_dig),
    .i_procmon_vdac_sel_dig      (i_procmon_vdac_sel_dig),
    .i_procmon_vt_step_dig       (i_procmon_vt_step_dig),
    .i_procmon_xtor_sel_dig      (i_procmon_xtor_sel_dig),
    .i_procmon_dlvr_sel_dig      (i_procmon_dlvr_sel_dig),
    .i_procmon_mux_sel_dig       (i_procmon_mux_sel_dig),

    //adc
    .o_clk_adc_ph1_dig (o_clk_adc_ph1_dig),
    .o_adc_sdout_dig   (o_adc_sdout_dig),
    .o_adc_digobs_dig  (o_adc_digobs_dig),

    //cml2cmos clk
    .o_clk_cml2cmos_dig      (o_clk_cml2cmos_dig),

    //cmlclk
    .o_clk_cmlclk_p_int_reg (o_clk_cmlclk_p_int_reg),
    .o_clk_cmlclk_n_int_reg (o_clk_cmlclk_n_int_reg),
    .o_clk_cmlclkout_p_reg  (o_clk_cmlclkout_p_reg),
    .o_clk_cmlclkout_n_reg  (o_clk_cmlclkout_n_reg),

    `include "cmlbufcbb_ldo_sso_modcon.ports.v"

);*/

endmodule

