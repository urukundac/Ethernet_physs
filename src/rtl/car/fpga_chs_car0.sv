
// Generated on 2024-02-12 11:00:38.271771
module fpga_chs_car0
// EDIT_PORT BEGIN
 ( 
input global_clock,
input global_reset_n,
output gclk1_div2,
output nss_cosq_clk,
output nss_cosq_fnic_clk,
output nlf_scpd_clk,
output imc_core_clk,
output mt_clk,
output nss_core_clk,
output nss_fxp_clk,
output nss_hif_clk,
output nss_lan_clk,
output physs_intf0_clk,
output soc_nlf_clk,
output soc_per_clk,
output soc_tsgen_clk,
output ecm_clk,
output pgcb_clk, //TBD
output aclk_s, //TBD
output ports_clk,//TBD
output switch_clk,
output rclk_diff_p,
output rclk_diff_n,
output physs_funcx2_clk,
output tsu_clk,
output nss_cosq_clk0,
output nss_cosq_clk1,
output clk_1588_freq,
output gclk1_div4,
output imc_sys_clk,
output mt_dist_clk,
output nss_psm_clk,
output nss_sep_clk,
output ssn_clk,
output utmi_clk,
output gclk1_div8,
output gclk1_div16,
output gclk1_div32,
output gclk1_div64,
output gclk1_div40
 );
// EDIT_PORT END


// EDIT_INTERFACE BEGIN
localparam GCLK1_DIV2_DIV_VAL = 2 ; 
localparam GCLK1_DIV4_DIV_VAL = 4 ;
localparam GCLK1_DIV8_DIV_VAL = 8;
localparam GCLK1_DIV10_DIV_VAL = 10 ; 
localparam GCLK1_DIV16_DIV_VAL = 16 ; 
localparam GCLK1_DIV32_DIV_VAL = 32 ; 
localparam GCLK1_DIV64_DIV_VAL = 64 ; 
localparam GCLK1_DIV40_DIV_VAL = 40 ; 
//localparam GCLK1_DIV100_DIV_VAL = 100 ; 
// EDIT_INTERFACE END

// EDIT_INSTANCE BEGIN
generic_clk_div #(.NUM_OUTPUTS(1),.START_POLARITY(1'b1),.DIVISOR(GCLK1_DIV2_DIV_VAL)) clk_div_gclk1_div2 (.clkin(global_clock), 
            .rst_n(global_reset_n), 
            .clkout(gclk1_div2)) ; 

generic_clk_div #(.NUM_OUTPUTS(1),.START_POLARITY(1'b1),.DIVISOR(GCLK1_DIV2_DIV_VAL)) clk_div_nss_cosq_clk (.clkin(global_clock), 
            .rst_n(global_reset_n), 
            .clkout(nss_cosq_clk)) ; 

generic_clk_div #(.NUM_OUTPUTS(1),.START_POLARITY(1'b1),.DIVISOR(GCLK1_DIV2_DIV_VAL)) clk_div_nss_cosq_fnic_clk (.clkin(global_clock), 
            .rst_n(global_reset_n), 
            .clkout(nss_cosq_fnic_clk)) ; 

generic_clk_div #(.NUM_OUTPUTS(1),.START_POLARITY(1'b1),.DIVISOR(GCLK1_DIV2_DIV_VAL)) clk_div_nlf_scpd_clk (.clkin(global_clock), 
            .rst_n(global_reset_n), 
            .clkout(nlf_scpd_clk)) ; 

generic_clk_div #(.NUM_OUTPUTS(1),.START_POLARITY(1'b1),.DIVISOR(GCLK1_DIV2_DIV_VAL)) clk_div_imc_core_clk (.clkin(global_clock), 
            .rst_n(global_reset_n), 
            .clkout(imc_core_clk)) ; 

generic_clk_div #(.NUM_OUTPUTS(1),.START_POLARITY(1'b1),.DIVISOR(GCLK1_DIV2_DIV_VAL)) clk_div_mt_clk (.clkin(global_clock), 
            .rst_n(global_reset_n), 
            .clkout(mt_clk)) ; 

generic_clk_div #(.NUM_OUTPUTS(1),.START_POLARITY(1'b1),.DIVISOR(GCLK1_DIV2_DIV_VAL)) clk_div_nss_core_clk (.clkin(global_clock), 
            .rst_n(global_reset_n), 
            .clkout(nss_core_clk)) ; 

generic_clk_div #(.NUM_OUTPUTS(1),.START_POLARITY(1'b1),.DIVISOR(GCLK1_DIV2_DIV_VAL)) clk_div_nss_fxp_clk (.clkin(global_clock), 
            .rst_n(global_reset_n), 
            .clkout(nss_fxp_clk)) ; 

generic_clk_div #(.NUM_OUTPUTS(1),.START_POLARITY(1'b1),.DIVISOR(GCLK1_DIV2_DIV_VAL)) clk_div_nss_hif_clk (.clkin(global_clock), 
            .rst_n(global_reset_n), 
            .clkout(nss_hif_clk)) ; 

generic_clk_div #(.NUM_OUTPUTS(1),.START_POLARITY(1'b1),.DIVISOR(GCLK1_DIV2_DIV_VAL)) clk_div_nss_lan_clk (.clkin(global_clock), 
            .rst_n(global_reset_n), 
            .clkout(nss_lan_clk)) ; 

generic_clk_div #(.NUM_OUTPUTS(1),.START_POLARITY(1'b1),.DIVISOR(GCLK1_DIV2_DIV_VAL)) clk_div_physs_intf0_clk (.clkin(global_clock), 
            .rst_n(global_reset_n), 
            .clkout(physs_intf0_clk)) ; 

generic_clk_div #(.NUM_OUTPUTS(1),.START_POLARITY(1'b1),.DIVISOR(GCLK1_DIV2_DIV_VAL)) clk_div_soc_nlf_clk (.clkin(global_clock), 
            .rst_n(global_reset_n), 
            .clkout(soc_nlf_clk)) ; 

generic_clk_div #(.NUM_OUTPUTS(1),.START_POLARITY(1'b1),.DIVISOR(GCLK1_DIV2_DIV_VAL)) clk_div_soc_per_clk (.clkin(global_clock), 
            .rst_n(global_reset_n), 
            .clkout(soc_per_clk)) ; 

generic_clk_div #(.NUM_OUTPUTS(1),.START_POLARITY(1'b1),.DIVISOR(GCLK1_DIV2_DIV_VAL)) clk_div_soc_tsgen_clk (.clkin(global_clock), 
            .rst_n(global_reset_n), 
            .clkout(soc_tsgen_clk)) ; 

generic_clk_div #(.NUM_OUTPUTS(1),.START_POLARITY(1'b1),.DIVISOR(GCLK1_DIV2_DIV_VAL)) clk_div_ecm_clk (.clkin(global_clock), 
            .rst_n(global_reset_n), 
            .clkout(ecm_clk)) ; 

generic_clk_div #(.NUM_OUTPUTS(1),.START_POLARITY(1'b1),.DIVISOR(GCLK1_DIV2_DIV_VAL)) clk_div_pgcb_clk (.clkin(global_clock), 
            .rst_n(global_reset_n), 
            .clkout(pgcb_clk)) ; 

generic_clk_div #(.NUM_OUTPUTS(1),.START_POLARITY(1'b1),.DIVISOR(GCLK1_DIV2_DIV_VAL)) clk_div_aclk_s (.clkin(global_clock), 
            .rst_n(global_reset_n), 
            .clkout(aclk_s)) ; 

generic_clk_div #(.NUM_OUTPUTS(1),.START_POLARITY(1'b1),.DIVISOR(GCLK1_DIV2_DIV_VAL)) clk_div_ports_clk (.clkin(global_clock), 
            .rst_n(global_reset_n), 
            .clkout(ports_clk)) ; 

generic_clk_div #(.NUM_OUTPUTS(1),.START_POLARITY(1'b1),.DIVISOR(GCLK1_DIV2_DIV_VAL)) clk_div_switch_clk (.clkin(global_clock), 
            .rst_n(global_reset_n), 
            .clkout(switch_clk)) ; 

generic_clk_div #(.NUM_OUTPUTS(1),.START_POLARITY(1'b1),.DIVISOR(GCLK1_DIV2_DIV_VAL)) clk_div_rclk_diff_p (.clkin(global_clock), 
            .rst_n(global_reset_n), 
            .clkout(rclk_diff_p)) ; 

generic_clk_div #(.NUM_OUTPUTS(1),.START_POLARITY(1'b1),.DIVISOR(GCLK1_DIV2_DIV_VAL)) clk_div_rclk_diff_n (.clkin(global_clock), 
            .rst_n(global_reset_n), 
            .clkout(rclk_diff_n)) ; 

generic_clk_div #(.NUM_OUTPUTS(1),.START_POLARITY(1'b1),.DIVISOR(GCLK1_DIV2_DIV_VAL)) clk_div_physs_funcx2_clk (.clkin(global_clock), 
            .rst_n(global_reset_n), 
            .clkout(physs_funcx2_clk)) ; 

generic_clk_div #(.NUM_OUTPUTS(1),.START_POLARITY(1'b1),.DIVISOR(GCLK1_DIV2_DIV_VAL)) clk_div_tsu_clk (.clkin(global_clock), 
            .rst_n(global_reset_n), 
            .clkout(tsu_clk)) ; 

generic_clk_div #(.NUM_OUTPUTS(1),.START_POLARITY(1'b1),.DIVISOR(GCLK1_DIV2_DIV_VAL)) clk_div_nss_cosq_clk0 (.clkin(global_clock), 
            .rst_n(global_reset_n), 
            .clkout(nss_cosq_clk0)) ; 

generic_clk_div #(.NUM_OUTPUTS(1),.START_POLARITY(1'b1),.DIVISOR(GCLK1_DIV2_DIV_VAL)) clk_div_nss_cosq_clk1 (.clkin(global_clock), 
            .rst_n(global_reset_n), 
            .clkout(nss_cosq_clk1)) ; 

generic_clk_div #(.NUM_OUTPUTS(1),.START_POLARITY(1'b1),.DIVISOR(GCLK1_DIV2_DIV_VAL)) clk_div_clk_1588_freq (.clkin(global_clock), 
            .rst_n(global_reset_n), 
            .clkout(clk_1588_freq)) ; 

generic_clk_div #(.NUM_OUTPUTS(1),.START_POLARITY(1'b1),.DIVISOR(GCLK1_DIV4_DIV_VAL)) clk_div_gclk1_div4 (.clkin(global_clock), 
            .rst_n(global_reset_n), 
            .clkout(gclk1_div4)) ; 

generic_clk_div #(.NUM_OUTPUTS(1),.START_POLARITY(1'b1),.DIVISOR(GCLK1_DIV4_DIV_VAL)) clk_div_imc_sys_clk (.clkin(global_clock), 
            .rst_n(global_reset_n), 
            .clkout(imc_sys_clk)) ; 

generic_clk_div #(.NUM_OUTPUTS(1),.START_POLARITY(1'b1),.DIVISOR(GCLK1_DIV4_DIV_VAL)) clk_div_mt_dist_clk (.clkin(global_clock), 
            .rst_n(global_reset_n), 
            .clkout(mt_dist_clk)) ; 

generic_clk_div #(.NUM_OUTPUTS(1),.START_POLARITY(1'b1),.DIVISOR(GCLK1_DIV4_DIV_VAL)) clk_div_nss_psm_clk (.clkin(global_clock), 
            .rst_n(global_reset_n), 
            .clkout(nss_psm_clk)) ; 

generic_clk_div #(.NUM_OUTPUTS(1),.START_POLARITY(1'b1),.DIVISOR(GCLK1_DIV4_DIV_VAL)) clk_div_nss_sep_clk (.clkin(global_clock), 
            .rst_n(global_reset_n), 
            .clkout(nss_sep_clk)) ; 

generic_clk_div #(.NUM_OUTPUTS(1),.START_POLARITY(1'b1),.DIVISOR(GCLK1_DIV4_DIV_VAL)) clk_div_ssn_clk (.clkin(global_clock), 
            .rst_n(global_reset_n), 
            .clkout(ssn_clk)) ; 

generic_clk_div #(.NUM_OUTPUTS(1),.START_POLARITY(1'b1),.DIVISOR(GCLK1_DIV4_DIV_VAL)) clk_div_utmi_clk (.clkin(global_clock), 
            .rst_n(global_reset_n), 
            .clkout(utmi_clk)) ; 

generic_clk_div #(.NUM_OUTPUTS(1),.START_POLARITY(1'b1),.DIVISOR(GCLK1_DIV8_DIV_VAL)) clk_div_gclk1_div8 (.clkin(global_clock), 
            .rst_n(global_reset_n),
            .clkout(gclk1_div8)) ;

generic_clk_div #(.NUM_OUTPUTS(1),.START_POLARITY(1'b1),.DIVISOR(GCLK1_DIV16_DIV_VAL)) clk_div_gclk1_div16 (.clkin(global_clock), 
            .rst_n(global_reset_n), 
            .clkout(gclk1_div16)) ;           

generic_clk_div #(.NUM_OUTPUTS(1),.START_POLARITY(1'b1),.DIVISOR(GCLK1_DIV32_DIV_VAL)) clk_div_gclk1_div32 (.clkin(global_clock), 
            .rst_n(global_reset_n),
            .clkout(gclk1_div32)) ; 

generic_clk_div #(.NUM_OUTPUTS(1),.START_POLARITY(1'b1),.DIVISOR(GCLK1_DIV64_DIV_VAL)) clk_div_gclk1_div64 (.clkin(global_clock), 
            .rst_n(global_reset_n), 
            .clkout(gclk1_div64)) ;            

generic_clk_div #(.NUM_OUTPUTS(1),.START_POLARITY(1'b1),.DIVISOR(GCLK1_DIV40_DIV_VAL)) clk_div_gclk1_div40 (.clkin(global_clock), 
            .rst_n(global_reset_n), 
            .clkout(gclk1_div40)) ;

//generic_clk_div #(.NUM_OUTPUTS(1),.START_POLARITY(1'b1),.DIVISOR(GCLK1_DIV50_DIV_VAL)) clk_div_gclk1_div50 (.clkin(global_clock), 
//            .rst_n(global_reset_n), 
//            .clkout(gclk1_div50)) ; 
//
//generic_clk_div #(.NUM_OUTPUTS(1),.START_POLARITY(1'b1),.DIVISOR(GCLK1_DIV100_DIV_VAL)) clk_div_gclk1_div100 (.clkin(global_clock), 
//            .rst_n(global_reset_n), 
//            .clkout(gclk1_div100)) ; 

//tap_clk_generator tap_clk_generator_soc (.haps_clk(tap_sample_clk), 
//            .haps_rst(global_reset_n), 
//            .tck_sample(soc_tap_tck_fpga_io), 
//            .tck_modified(soc_tck_final)) ; 

// EDIT_INSTANCE END
endmodule

