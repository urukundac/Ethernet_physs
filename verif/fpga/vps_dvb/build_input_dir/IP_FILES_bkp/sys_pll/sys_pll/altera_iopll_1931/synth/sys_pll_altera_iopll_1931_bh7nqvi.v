`timescale 1ns/10ps
module  sys_pll_altera_iopll_1931_bh7nqvi(

	// interface 'reset'
	input wire rst,

	// interface 'refclk'
	input wire refclk,

	// interface 'locked'
	output wire locked,

	// interface 'scanclk'
	input wire scanclk,

	// interface 'phase_en'
	input wire phase_en,

	// interface 'updn'
	input wire updn,

	// interface 'cntsel'
	input wire [4:0] cntsel,

	// interface 'phase_done'
	output wire phase_done,

	// interface 'num_phase_shifts'
	input wire [2:0] num_phase_shifts,

	// interface 'outclk0'
	output wire outclk_0,

	// interface 'outclk1'
	output wire outclk_1,

	// interface 'outclk2'
	output wire outclk_2,

	// interface 'outclk3'
	output wire outclk_3,

	// interface 'outclk4'
	output wire outclk_4,

	// interface 'outclk5'
	output wire outclk_5,

	// interface 'outclk6'
	output wire outclk_6,

	// interface 'outclk7'
	output wire outclk_7
);

    wire [0:0] unused_wires;

	stratix10_altera_iopll #(
		.c_cnt_bypass_en0("false"),
		.c_cnt_bypass_en1("false"),
		.c_cnt_bypass_en2("false"),
		.c_cnt_bypass_en3("false"),
		.c_cnt_bypass_en4("false"),
		.c_cnt_bypass_en5("false"),
		.c_cnt_bypass_en6("false"),
		.c_cnt_bypass_en7("false"),
		.c_cnt_bypass_en8("true"),
		.c_cnt_hi_div0(180),
		.c_cnt_hi_div1(90),
		.c_cnt_hi_div2(225),
		.c_cnt_hi_div3(8),
		.c_cnt_hi_div4(3),
		.c_cnt_hi_div5(23),
		.c_cnt_hi_div6(240),
		.c_cnt_hi_div7(150),
		.c_cnt_hi_div8(256),
		.c_cnt_in_src0("c_m_cnt_in_src_ph_mux_clk"),
		.c_cnt_in_src1("c_m_cnt_in_src_ph_mux_clk"),
		.c_cnt_in_src2("c_m_cnt_in_src_ph_mux_clk"),
		.c_cnt_in_src3("c_m_cnt_in_src_ph_mux_clk"),
		.c_cnt_in_src4("c_m_cnt_in_src_ph_mux_clk"),
		.c_cnt_in_src5("c_m_cnt_in_src_ph_mux_clk"),
		.c_cnt_in_src6("c_m_cnt_in_src_ph_mux_clk"),
		.c_cnt_in_src7("c_m_cnt_in_src_ph_mux_clk"),
		.c_cnt_in_src8("c_m_cnt_in_src_ph_mux_clk"),
		.c_cnt_lo_div0(180),
		.c_cnt_lo_div1(90),
		.c_cnt_lo_div2(225),
		.c_cnt_lo_div3(7),
		.c_cnt_lo_div4(3),
		.c_cnt_lo_div5(22),
		.c_cnt_lo_div6(240),
		.c_cnt_lo_div7(150),
		.c_cnt_lo_div8(256),
		.c_cnt_odd_div_duty_en0("false"),
		.c_cnt_odd_div_duty_en1("false"),
		.c_cnt_odd_div_duty_en2("false"),
		.c_cnt_odd_div_duty_en3("true"),
		.c_cnt_odd_div_duty_en4("false"),
		.c_cnt_odd_div_duty_en5("true"),
		.c_cnt_odd_div_duty_en6("false"),
		.c_cnt_odd_div_duty_en7("false"),
		.c_cnt_odd_div_duty_en8("false"),
		.c_cnt_ph_mux_prst0(0),
		.c_cnt_ph_mux_prst1(0),
		.c_cnt_ph_mux_prst2(0),
		.c_cnt_ph_mux_prst3(0),
		.c_cnt_ph_mux_prst4(0),
		.c_cnt_ph_mux_prst5(0),
		.c_cnt_ph_mux_prst6(0),
		.c_cnt_ph_mux_prst7(0),
		.c_cnt_ph_mux_prst8(0),
		.c_cnt_prst0(1),
		.c_cnt_prst1(1),
		.c_cnt_prst2(1),
		.c_cnt_prst3(1),
		.c_cnt_prst4(1),
		.c_cnt_prst5(1),
		.c_cnt_prst6(1),
		.c_cnt_prst7(1),
		.c_cnt_prst8(1),
		.clock_name_0("outclk_2MHz"),
		.clock_name_1("outclk_4MHz"),
		.clock_name_2("outclk_1p6MHz"),
		.clock_name_3("outclk_48MHz"),
		.clock_name_4("outclk_120MHz"),
		.clock_name_5("outclk_16MHz"),
		.clock_name_6("outclk_1p5MHz"),
		.clock_name_7("outclk_2p4MHz"),
		.clock_name_8(""),
		.clock_name_global("false"),
		.clock_to_compensate(0),
		.dprio_interface_sel(3),
		.duty_cycle0(50),
		.duty_cycle1(50),
		.duty_cycle2(50),
		.duty_cycle3(50),
		.duty_cycle4(50),
		.duty_cycle5(50),
		.duty_cycle6(50),
		.duty_cycle7(50),
		.duty_cycle8(50),
		.eff_m_cnt(1),
		.lock_mode("low_lock_time"),
		.m_cnt_bypass_en("false"),
		.m_cnt_hi_div(23),
		.m_cnt_lo_div(22),
		.m_cnt_odd_div_duty_en("true"),
		.n_cnt_bypass_en("true"),
		.n_cnt_hi_div(256),
		.n_cnt_lo_div(256),
		.n_cnt_odd_div_duty_en("false"),
		.number_of_clocks(8),
		.operation_mode("direct"),
		.output_clock_frequency0("2.0 MHz"),
		.output_clock_frequency1("4.0 MHz"),
		.output_clock_frequency2("1.6 MHz"),
		.output_clock_frequency3("48.0 MHz"),
		.output_clock_frequency4("120.0 MHz"),
		.output_clock_frequency5("16.0 MHz"),
		.output_clock_frequency6("1.5 MHz"),
		.output_clock_frequency7("2.4 MHz"),
		.output_clock_frequency8("0 ps"),
		.phase_shift0("0 ps"),
		.phase_shift1("0 ps"),
		.phase_shift2("0 ps"),
		.phase_shift3("0 ps"),
		.phase_shift4("0 ps"),
		.phase_shift5("0 ps"),
		.phase_shift6("0 ps"),
		.phase_shift7("0 ps"),
		.phase_shift8("0 ps"),
		.pll_bw_sel("low_bw"),
		.pll_bwctrl("pll_bw_res_setting5"),
		.pll_cp_current("pll_cp_setting4"),
		.pll_defer_cal_user_mode("false"),
		.pll_extclk_0_cnt_src("pll_extclk_cnt_src_vss"),
		.pll_extclk_1_cnt_src("pll_extclk_cnt_src_vss"),
		.pll_fbclk_mux_1("pll_fbclk_mux_1_glb"),
		.pll_fbclk_mux_2("pll_fbclk_mux_2_m_cnt"),
		.pll_freqcal_en("true"),
		.pll_lock_fltr_cfg(100),
		.pll_m_cnt_in_src("c_m_cnt_in_src_ph_mux_clk"),
		.pll_output_clk_frequency("720.0 MHz"),
		.pll_ripplecap_ctrl("pll_ripplecap_setting2"),
		.pll_slf_rst("false"),
		.pll_subtype("DPS"),
		.pll_type("S10_Physical"),
		.pll_unlock_fltr_cfg(2),
		.prot_mode("BASIC"),
		.reference_clock_frequency("16.0 MHz")
	) stratix10_altera_iopll_i (
		.refclk1	(1'b0),
		.rst	(rst),
		.fbclk	(1'b0),
		.fboutclk	( ),
		.zdbfbclk	( ),
		.locked	(locked),
		.loaden	( ),
		.phase_done	(phase_done),
		.reconfig_to_pll	(30'b0),
		.refclk	(refclk),
		.scanclk	(scanclk),
		.phout	( ),
		.num_phase_shifts	(num_phase_shifts),
		.permit_cal	(1'b1),
		.cntsel	(cntsel),
		.clkbad	( ),
		.extclk_out	(),
		.lvds_clk	( ),
		.outclk	({unused_wires, outclk_7, outclk_6, outclk_5, outclk_4, outclk_3, outclk_2, outclk_1, outclk_0}),
		.phase_en	(phase_en),
		.extswitch	(1'b0),
		.cascade_out	( ),
		.activeclk	( ),
		.adjpllin	(1'b0),
		.updn	(updn),
		.reconfig_from_pll	( )
	);
endmodule

