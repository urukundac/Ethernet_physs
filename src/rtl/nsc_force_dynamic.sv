//Added ny Lokesh similar to Veloce to avoid confusuon and missing anything
//----------------------------------------------------------------------------------
// Emulation dynamic forces
//----------------------------------------------------------------------------------
assign dvp_pm_ip_cg_wake = 'h0; //TBD

`ifndef HLP_PHYSS_ONLY
`ifndef NMC_ONLY
// make HIFMC-UART clock run fast, to support 19200 baud for HW-UART in emulation
   TIP_DRIVEGATE tipdrive_hifmc_uart_clk(.A(uart_ref_clk/*core_clk*/), .Z(nac_ss.nss.nss.hif_nocss_top.hif_nocss_cnic_top.par_hif_nocss_mc.hif_nocss_mc_top.i_hif_nocss_mc_core.i_uart.UARTCLK));
`endif

// uart_ref_clk no longer exist in r13-post-dft-official, so need the following tip-drive-gate to support 19200 baud for HW-UART in emulation
   TIP_DRIVEGATE tipdrive_imc_uart_clk(.A(uart_ref_clk/*core_clk*/), .Z(nac_ss.nss.nmc_top.parimc.parimcperiph.aprimcperiph.parimccompute.aprimccompute.A00_uart_wr.A00_uart.UARTCLK));

   `endif
//----------------------------------------------------------------------------------
// DV Release Note dynamic forces
//----------------------------------------------------------------------------------
`ifndef HLP_PHYSS_ONLY
//Removed in R18
//`ifndef NAC_STUB
//`ifndef NMC_ONLY
//TIP_DRIVEGATE tip_drivegate_001 (.Z(nac_ss.nss.nss.nlf_top.reset_n_soc_per_clk_sync), .A(nac_ss.nss.nss.nlf_top.nlf_rst_n));
//`endif
//`endif
//#TBD : Lokesh there is pulse generate. Need to see if required on board
TIP_DRIVEGATE tip_drivegate_007 (.Z(nac_ss.nss.nmc_top.parnmccust.apr_nmccust.nmc_dlw_wrap.dvp_pm_ip_cg_wake), .A(dvp_pm_ip_cg_wake));
TIP_DRIVEGATE tip_drivegate_002 (.Z(nac_ss.nss.nmc_top.parimc.parimcperiph.aprimcperiph.parimccompute.aprimccompute.A00_gic_wr.Imc_gic_wr_rtl_tessent_mbist_bap_inst.sys_SRAM_c1_cluster1_gic_nmbistreset), .A(sys_rst_n));
TIP_DRIVEGATE tip_drivegate_003 (.Z(nac_ss.nss.nmc_top.parimc.parimccpu.aprimccpu.aprimccpu_rtl_tessent_mbist_bap_inst.sys_SRAM_1_c1_cluster1_cpu_dft_nMBISTRESET), .A(sys_rst_n));
TIP_DRIVEGATE tip_drivegate_004 (.Z(nac_ss.nss.nmc_top.parimc.parimccpu.aprimccpu.aprimccpu_rtl_tessent_mbist_bap_inst.sys_SRAM_2_c2_cluster1_cpu_dft_nMBISTRESET), .A(sys_rst_n));
`endif
`ifndef NAC_STUB
`ifndef NMC_ONLY
//Removed in R18
//TIP_DRIVEGATE tip_drivegate_005 (.Z(nac_ss.nss.nss.cxp_top.parcxp_lem_pmc.cxp_dlw_wrap.dlw_fdfx_powergood), .A(nsc_fdfx_pwrgood));
//TIP_DRIVEGATE tip_drivegate_006 (.Z(nac_ss.nss.nss.fxp_top.fxp.parfxpevm.parfxpevmin.fxp_dlw_wrap.fxp_dlw.dlw_powergood), .A(nsc_fdfx_pwrgood));
`endif
`endif
//Removed in R18
//`ifndef NMC_ONLY
//TIP_DRIVEGATE tip_drivegate_009 (.Z(nac_ss.nss.nss.hif_nocss_top.hif_nocss_cnic_top.par_hif_nocss_noc_fabric_north.par_hif_nocss_noc_fabric_nr_dlw.soc_dtf_resetn), .A(dfd_dtf_rst));
//TIP_DRIVEGATE tip_drivegate_010 (.Z(nac_ss.nss.nss.hif_core.hif_cnic.parhif_cnic_common.hif_cnic_common_apr.hif_dlw_wrap.dlw_fdfx_powergood), .A(nsc_fdfx_pwrgood));
//TIP_DRIVEGATE tip_drivegate_011 (.Z(nac_ss.nss.nss.hif_core.hif_cnic.parhif_cnic_common.hif_cnic_common_apr.hif_dlw_wrap.hif_dlw.dlw_fdfx_powergood), .A(nsc_fdfx_pwrgood));
//TIP_DRIVEGATE tip_drivegate_012 (.Z(nac_ss.nss.nss.hif_core.hif_cnic.parhif_cnic_common.hif_cnic_common_apr.hif_dlw_wrap.hif_dlw.dlw_powergood), .A(nsc_fdfx_pwrgood));
//`endif
//`ifndef NAC_STUB
//`ifndef NMC_ONLY
//TIP_DRIVEGATE tip_drivegate_013 (.Z(nac_ss.nss.nss.lanpe_top.parlanpe_aux.lanpe_dlw_wrap.lanpe_dlw.dvp_pm_ip_cg_wake), .A(dvp_pm_ip_cg_wake));
//`endif
//`endif

//----------------------------------------------------------------------------------
// TRNG
// logic in the TRNG IP is targetted to silicon, and not working in emulation (ring oscillator)
// the following lfsr and tip-drive-gates are aimed to workaround this issue
//----------------------------------------------------------------------------------

   wire [31:0] lfsr32_out;

   lfsr32 lfsr32(
		 //input signals:
		 .clk	(core_clk),
		 .rstn	(sys_rst_n),
		 //output signals:
		 .lfsr_out (lfsr32_out)
	         ); 
`ifndef HLP_PHYSS_ONLY

   TIP_DRIVEGATE tipdrive_lfsr_0 (.Z(nac_ss.nss.nmc_top.parimc.parimcperiph.aprimcperiph.parimccompute.aprimccompute.A00_trng_wr.A00_trng.U_nist_trng.U_elp_sp80090c_ctrl.u_sp80090c_mgor_fsm.u_trng_mgor_seed.O_seed_bit_valid), .A(sys_rst_n));
   TIP_DRIVEGATE tipdrive_lfsr_1 (.Z(nac_ss.nss.nmc_top.parimc.parimcperiph.aprimcperiph.parimccompute.aprimccompute.A00_trng_wr.A00_trng.U_nist_trng.U_elp_sp80090c_ctrl.u_sp80090c_mgor_fsm.u_trng_mgor_seed.O_seed_bit), .A(lfsr32_out[0])); 
   `endif
///TBD:Lokesh added for temporary
//Below force is giving error in tnfi file so adding here
//   TIP_DRIVEGATE tipdrive_disable_sec_global (.Z(nac_ss.nss.nmc_top.parnmccust.apr_nmccust.syscon_top.A00_syscon_core.A00_syscon_cfg.pfuse.disable_sec_global[0:0]), .A(1)); 
//Below added to move syscon reset fsm from SOC_RESET_REL to CHIP_RESET_REL as mbist removal is causing issue

//module vector_TIP_DRIVEGATE #(parameter width =1) (input [width-1:0] A,
//output [width-1:0] Z);
//genvar i;
//generate
// for(i=0;i<width;i++) begin: TIPGATE
// TIP_DRIVEGATE tipdrivegate (.A(A[i]),.Z(Z[i]));
// end
//endgenerate
//endmodule 
//
//   TIP_DRIVEGATE tipdrive_post_comp_nac (.Z(nac_ss.par_nac_misc.nac_post.post_comp_nac[10:0]), .A(1)); 
//   TIP_DRIVEGATE tipdrive_post_comp_hlp (.Z(nac_ss.par_nac_misc.nac_post.post_comp_hlp[11:0]), .A(1)); 
//   TIP_DRIVEGATE tipdrive_post_comp_nsc (.Z(nac_ss.par_nac_misc.nac_post.post_comp_nsc[31:0]), .A(1)); 
//   TIP_DRIVEGATE tipdrive_post_pass_nac (.Z(nac_ss.par_nac_misc.nac_post.post_pass_nac[10:0]), .A(1)); 
//   TIP_DRIVEGATE tipdrive_post_pass_hlp (.Z(nac_ss.par_nac_misc.nac_post.post_pass_hlp[11:0]), .A(1)); 
//   TIP_DRIVEGATE tipdrive_post_pass_nsc (.Z(nac_ss.par_nac_misc.nac_post.post_pass_nsc[31:0]), .A(1)); 
//
