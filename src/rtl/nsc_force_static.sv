initial
begin
//Added in R18
//force nac_ss.nss.nsc_dlw_serial_download_tsc = 1'b0;
//force nac_ss.nss.nsc_fdfx_pwrgood = 1'b0;//connected to sys_rst_n so will cause full logic optimization
//force nac_ss.nss.dvp_pm_ip_cg_wake = 1'b0;
//force nac_ss.nss.nmc_top.i_nmf_t_fxp_emb_arqos = 'h0;
//force nac_ss.nss.nmc_top.i_nmf_t_fxp_emb_awqos = 'h0;
//force nac_ss.nss.nmc_top.i_nmf_t_rdma_arqos = 'h0;
//force nac_ss.nss.nmc_top.i_nmf_t_rdma_awqos = 'h0;
//force nac_ss.nss.nmc_top.global_scan_atspeed_cg_en = 0;
//force nac_ss.nss.nmc_top.cdbg_rstreq = 'h1; //TBD


force nac_ss.nss.nmc_top.parnmccust.apr_nmccust.syscon_top.A00_syscon_core.A00_syscon_cfg.A00_syscon_regs.spare_p2.spare[7:0] = 8'h1;
//#Ver 2 this is removed
//#force nac_ss.nss.nmc_top.parnmccust.apr_nmccust.syscon_top.A00_syscon_core.A00_syscon_cfg.A00_syscon_regs.spare_p4.spare[7:0] = 8'h1;
force nac_ss.nss.nmc_top.parnmccust.apr_nmccust.syscon_top.A00_syscon_core.A00_syscon_cfg.pfuse2.device_id[15:0] = 16'h11fc;
//#force nac_ss.PCIE_Device_ID_reg[15:0] = 16'h11fc;
force nac_ss.nss.nmc_top.parnmccust.apr_nmccust.syscon_top.A00_syscon_core.A00_syscon_cfg.pfuse2.sku_select_cfg_ss[3:0] = 4'h8;
//#force nac_ss.ROM_ECC_ENABLE_reg 0
//#force nac_ss.ROM_ECC_IMCR_ENABLE_reg 0
//#force nac_ss.boot_mode_reg 1
force nac_ss.nss.nmc_top.parnmccust.apr_nmccust.A00_EcmTop.EcmDone = 1'b1;
force nac_ss.nss.nmc_top.parnmccust.apr_nmccust.syscon_top.A00_syscon_core.A00_syscon_authentifier.hif_debug_level[1:0] = 2'h0;
force nac_ss.nss.nmc_top.parimc.parimcperiph.aprimcperiph.parimclsio.aprimclsio.A00_spi_wr.A00_spi.U_regfile.baudr[15:0] = 16'h18;

`endif



//### DV Release Note forces:
//### ----------------------
`ifndef NAC_STUB
`ifndef NMC_ONLY
//Removed in R18
//force nac_ss.nss.nss.nlf_top.par_nlf_main.fscan_byprst_b = 1'b0;
//force nac_ss.nss.nss.nlf_top.par_nlf_main.fscan_rstbypen = 1'b0;
//force nac_ss.nss.nss.nlf_top.par_nlf_main.fscan_byplatrst_b = 1'b0;
//force nac_ss.nss.nss.nlf_top.par_nlf_main.dtfr_fscan_byprst_b = 1'b0;
//force nac_ss.nss.nss.nlf_top.par_nlf_main.dtfr_fscan_rstbypen = 1'b0;
//force nac_ss.nss.nss.nlf_top.par_nlf_main.dtfr_fscan_byplatrst_b = 1'b0;
force nac_ss.nss.nss.nlf_top.nlf_dtfr_clk_gate_ovrd = 1'b0;
//Removed in R18
//force nac_ss.nss.nss.nlf_top.rclk_nss_hif_rstbypen = 1'b0;
//force nac_ss.nss.nss.nlf_top.rclk_nss_hif_byprst_b = 1'b0;
//force nac_ss.nss.nss.nlf_top.rclk_nss_core_byprst_b = 1'b0;
//force nac_ss.nss.nss.nlf_top.rclk_nss_core_rstbypen = 1'b0;
`endif
`endif
force nac_ss.nss.nmc_top.parnmccust.apr_nmccust.hidft_open_12[1:0] = 2'h1;
force nac_ss.nss.nmc_top.parnmccust.apr_nmccust.hidft_open_10 = 0;
//Removed in R18
//force nac_ss.nss.nmc_top.parnmccust.apr_nmccust.hidft_open_11[1:0] = 2'h0;
force nac_ss.nss.nmc_top.cnic_i_nmf_t_cnic_nsc_pfb_pready_0 = 1'b0;
force nac_ss.nss.nmc_top.cnic_i_nmf_t_cnic_nsc_pfb_pslverr_0 = 1'b0;
//Removed in R18
//force nac_ss.nss.nmc_top.fuses_sbb_trng_ras = 1'b0;
//force nac_ss.nss.nmc_top.fuses_imc_sbb_meas_hash_algo = 1'b0;
//force nac_ss.nss.nmc_top.fuses_imc_spare = 1'b0;
//force nac_ss.nss.nmc_top.imc_t_nsc_cfio0_pready_0 = 1'b0;
//force nac_ss.nss.nmc_top.imc_t_nsc_cfio0_pslverr_0 = 1'b0;
`ifndef NMC_ONLY
force nac_ss.nss.nss.hif_core.hif_debug_level[1:0] = 2'h0;
`endif
`ifndef NAC_STUB
`ifndef NMC_ONLY
force nac_ss.nss.nss.fxp_top.fuse_fxp_func_fuse[7:0] = 8'h0;
//Removed in R18
//force nac_ss.nss.nss.ts_top.fuse_ts_func_fuse[7:0] = 8'h0;
force nac_ss.nss.nss.icm_top.fuse_ice_func_fuse[15:0] = 16'h0;
`endif
`endif

`endif



//Removed in R18
//`ifndef NMC_ONLY
//force nac_ss.nss.nss.hif_core.fabric_reset_shield = 1'b0;
//`endif
`ifndef HLP_PHYSS_ONLY
//force nac_ss.nss.nmc_top.dvp_ip_trigger_event_gate = 1'b0;
//force nac_ss.nss.nmc_top.visa_all_dis_0 = 1'b0;
//force nac_ss.nss.nmc_top.visa_customer_dis_0 = 1'b0;
//force nac_ss.nss.nmc_top.visa_all_dis_1 = 1'b0;
//force nac_ss.nss.nmc_top.visa_customer_dis_1 = 1'b0;
//force nac_ss.nss.nmc_top.visa_all_dis_2 = 1'b0;
//force nac_ss.nss.nmc_top.visa_customer_dis_2 = 1'b0;
//force nac_ss.nss.nmc_top.visa_all_dis_3 = 1'b0;
//force nac_ss.nss.nmc_top.visa_customer_dis_3 = 1'b0;
//force nac_ss.nss.nmc_top.visa_all_dis_4 = 1'b0;
//force nac_ss.nss.nmc_top.visa_customer_dis_4 = 1'b0;
//force nac_ss.nss.nmc_top.visa_all_dis_5 = 1'b0;
//force nac_ss.nss.nmc_top.visa_customer_dis_5 = 1'b0;
//force nac_ss.nss.nmc_top.visa_all_dis_6 = 1'b0;
//force nac_ss.nss.nmc_top.visa_customer_dis_6 = 1'b0;
//force nac_ss.nss.nmc_top.visa_all_dis_7 = 1'b0;
//force nac_ss.nss.nmc_top.visa_customer_dis_7 = 1'b0;
//force nac_ss.nss.nmc_top.visa_all_dis_8 = 1'b0;
//force nac_ss.nss.nmc_top.visa_customer_dis_8 = 1'b0;
force nac_ss.nss.nmc_top.global_scan_atspeed_cg_en_1 = 1'b0;
//force nac_ss.nss.nsc_fuse_hsrom = 1'b1;
`endif


//force nac_ss.nss.nmc_top.parimc.parimclsm.aprimclsm.mbist_mode = 1'b0;
//force nac_ss.nss.nmc_top.parimc.parimclsm.parimclsm_ub.odi0.odi_05aip_wrap_inst.itm_arrayrowenableh[13:0] = 14'h0;
//force nac_ss.nss.nmc_top.parimc.parimclsm.parimclsm_ub.odi1.odi_05aip_wrap_inst.itm_arrayrowenableh[13:0] = 14'h0;
//force nac_ss.nss.nmc_top.parimc.parimclsm.parimclsm_ub.odi2.odi_05aip_wrap_inst.itm_arrayrowenableh[13:0] = 14'h0;
//force nac_ss.nss.nmc_top.parimc.parimcperiph.parimcperiph_ub.odi0.odi_05aip_wrap_inst.itm_arrayrowenableh[13:0] = 14'h0;
force nac_ss.nss.nmc_top.parimc.parimcperiph.aprimcperiph.parimccompute.aprimccompute.A00_gic_wr.Imc_gic_wr_rtl_tessent_mbist_bap_inst.sys_SRAM_c1_cluster1_gic_mbistreq = 1'b0;
force nac_ss.nss.nmc_top.parimc.parimccpu.aprimccpu.aprimccpu_rtl_tessent_mbist_bap_inst.sys_SRAM_1_c1_cluster1_cpu_dft_MBISTREQ = 1'b0;
force nac_ss.nss.nmc_top.parimc.parimccpu.aprimccpu.aprimccpu_rtl_tessent_mbist_bap_inst.sys_SRAM_2_c2_cluster1_cpu_dft_MBISTREQ = 1'b0;
//force nac_ss.nss.nmc_top.parnmccust.apr_nmccust.nmc_cti_tfb_gasket_wrap.cti_ctf_triggerfabricblock_agent_inst.trig_a2f_req[3:0] = 4'h0;

//######HSD https://hsdes.intel.com/appstore/article-one/#/article/16029562221 forces on top of veloce static forces###
force nac_ss.nss.nmc_top.parimc.parimcperiph.aprimcperiph.parimccompute.aprimccompute.fscan_byprst_b = 1'b0;
force nac_ss.nss.nmc_top.parimc.parimcperiph.parimcperiph_dfx_ub.i_ult_scan_ctlr.fscan_rstbypen = 1'b0;
force nac_ss.nss.nmc_top.parimc.parimcperiph.parimcperiph_dfx_ub.i_ult_scan_ctlr.fscan_byplatrst_b = 1'b0;


//## Additional DV forces from Vinay
force nac_ss.BOOT_MODE_STRAP = 1'b1;
force nac_ss.nss.NSS_S3M_EXISTS = 1'b1;  
//#Ver 2 this is added 
force nac_ss.nss.nmc_top.parnmccust.apr_nmccust.syscon_top.A00_syscon_core.A00_syscon_cfg.pfuse.disable_sec_global[0:0] = 1'b1;

//MBIST workaround
force nac_ss.par_nac_misc.nac_post.post_comp_nac[10:0] = 11'b11111111111;
force nac_ss.par_nac_misc.nac_post.post_comp_hlp[7:0] = 8'b11111111; //Bit/Part/Concatenation select on [11:0] is out of range
force nac_ss.par_nac_misc.nac_post.post_comp_nsc[31:0] = 32'hFFFFFFFF;
force nac_ss.par_nac_misc.nac_post.post_pass_nac[10:0] = 11'b11111111111;
force nac_ss.par_nac_misc.nac_post.post_pass_hlp[7:0] = 8'b11111111;
force nac_ss.par_nac_misc.nac_post.post_pass_nsc[31:0] = 32'hFFFFFFFF;

//Governor slice for aprcpu
force nac_ss.nss.nmc_top.parimc.parimccpu.aprimccpu.A00_cpu_wr.A00_cpu.u_ca53_l2.u_ca53_l2noram.u_ca53governor.u_governor_slice.nmbistreset = sys_rst_n;
force nac_ss.nss.nmc_top.parimc.parimccpu.aprimccpu.A00_cpu_wr.A00_cpu.u_ca53_l2.u_ca53_l2noram.u_ca53governor.u_governor_slice.mbistreq_i = 1'b0;
//gic mbist reset and req
force nac_ss.nss.nmc_top.parimc.parimcperiph.aprimcperiph.parimccompute.aprimccompute.A00_gic_wr.A00_gic.gic_nmbistreset = sys_rst_n;
force nac_ss.nss.nmc_top.parimc.parimcperiph.aprimcperiph.parimccompute.aprimccompute.A00_gic_wr.A00_gic.gic_mbistreq = 1'b0;


//force nac_ss.par_nac_misc.nac_post.post_comp_nac[10:0] = 11'b11111111111;
//force nac_ss.par_nac_misc.nac_post.post_comp_hlp[11:0] = 12'b111111111111;
//force nac_ss.par_nac_misc.nac_post.post_comp_nsc[31:0] = 32'hFFFFFFFF;
//force nac_ss.par_nac_misc.nac_post.post_pass_nac[10:0] = 11'b11111111111;
//force nac_ss.par_nac_misc.nac_post.post_pass_hlp[11:0] = 12'b111111111111;
//force nac_ss.par_nac_misc.nac_post.post_pass_nsc[31:0] = 32'hFFFFFFFF;
//
////Governor slice for aprcpu
//force nac_ss.nss.nmc_top.parimc.parimccpu.aprimccpu.A00_cpu_wr.A00_cpu.u_ca53_l2.u_ca53_l2noram.u_ca53governor.u_governor_slice.nmbistreset = sys_rst_n;
//force nac_ss.nss.nmc_top.parimc.parimccpu.aprimccpu.A00_cpu_wr.A00_cpu.u_ca53_l2.u_ca53_l2noram.u_ca53governor.u_governor_slice.mbistreq_i = 1'b0;
////gic mbist reset and req
//force nac_ss.nss.nmc_top.parimc.parimcperiph.aprimcperiph.parimccompute.aprimccompute.A00_gic_wr.A00_gic.gic_nmbistreset = sys_rst_n;
//force nac_ss.nss.nmc_top.parimc.parimcperiph.aprimcperiph.parimccompute.aprimccompute.A00_gic_wr.A00_gic.gic_mbistreq = 1'b0;
end
