
/*AUTO_LISP(setq verilog-auto-unused-ignore-regexp
(concat
"^\\("
".*_clk"
"\\|.*aonclk1x"
"\\|.*_rst.*"
"\\|.*_powergood.*"
"\\|.*syscon.*"
"\\|.*hif_car_.*_toggle.*"
"\\|.*fuse.*"
"\\|fabric_reset_shield"
"\\|.*_ssn_.*"
"\\|.*_ecc_stop.*"
"\\|.*rxelecidle.*"
"\\|.*pm_linkst.*"
"\\|.*smlh_in_rl0s.*"
"\\|.*syscon.*"
"\\|.*perf_win_sync.*"
"\\)$"
))*/

/*AUTO_LISP(setq verilog-active-low-regexp
(concat
"^\\("
".*pready.*"
"\\)$"
))*/

module hif_nocss_smh_top_stub(/*AUTOARG*/
   // Outputs
   hif_nocss_smh_aary_mbist_diag_done, hif_nocss_smh_bisr_so,
   hif_nocss_smh_dft_spare_out, hif_nocss_smh_ijtag_nw_so,
   hif_nocss_smh_ssn_bus_data_out, hif_nocss_smh_tap_sel_in,
   hif_nocss_smh_tdo, fabif_cmi0_req0_cred_tdata,
   fabif_cmi0_req0_cred_tdest, fabif_cmi0_req0_cred_tuser,
   fabif_cmi0_req0_cred_tvalid, fabif_cmi0_req0_tready,
   fabif_cmi0_reqmd0_cred_tdata, fabif_cmi0_reqmd0_cred_tdest,
   fabif_cmi0_reqmd0_cred_tuser, fabif_cmi0_reqmd0_cred_tvalid,
   fabif_cmi0_reqmd0_tready, fabif_cmi0_rwdatacomp_cred_mready,
   fabif_cmi0_rwdatacomp_tdata, fabif_cmi0_rwdatacomp_tdest,
   fabif_cmi0_rwdatacomp_tid, fabif_cmi0_rwdatacomp_tlast,
   fabif_cmi0_rwdatacomp_tuser, fabif_cmi0_rwdatacomp_tvalid,
   fabif_cmi0_rwdatacompmd_cred_mready, fabif_cmi0_rwdatacompmd_tdata,
   fabif_cmi0_rwdatacompmd_tdest, fabif_cmi0_rwdatacompmd_tid,
   fabif_cmi0_rwdatacompmd_tlast, fabif_cmi0_rwdatacompmd_tuser,
   fabif_cmi0_rwdatacompmd_tvalid, fabif_cmi1_req0_cred_tdata,
   fabif_cmi1_req0_cred_tdest, fabif_cmi1_req0_cred_tuser,
   fabif_cmi1_req0_cred_tvalid, fabif_cmi1_req0_tready,
   fabif_cmi1_reqmd0_cred_tdata, fabif_cmi1_reqmd0_cred_tdest,
   fabif_cmi1_reqmd0_cred_tuser, fabif_cmi1_reqmd0_cred_tvalid,
   fabif_cmi1_reqmd0_tready, fabif_cmi1_rwdatacomp_cred_mready,
   fabif_cmi1_rwdatacomp_tdata, fabif_cmi1_rwdatacomp_tdest,
   fabif_cmi1_rwdatacomp_tid, fabif_cmi1_rwdatacomp_tlast,
   fabif_cmi1_rwdatacomp_tuser, fabif_cmi1_rwdatacomp_tvalid,
   fabif_cmi1_rwdatacompmd_cred_mready, fabif_cmi1_rwdatacompmd_tdata,
   fabif_cmi1_rwdatacompmd_tdest, fabif_cmi1_rwdatacompmd_tid,
   fabif_cmi1_rwdatacompmd_tlast, fabif_cmi1_rwdatacompmd_tuser,
   fabif_cmi1_rwdatacompmd_tvalid, fabif_cmi1_wrdone_tready,
   fabif_pcie2_req0_cred_tdata, fabif_pcie2_req0_cred_tdest,
   fabif_pcie2_req0_cred_tuser, fabif_pcie2_req0_cred_tvalid,
   fabif_pcie2_req0_tready, fabif_pcie2_reqmd0_cred_tdata,
   fabif_pcie2_reqmd0_cred_tdest, fabif_pcie2_reqmd0_cred_tuser,
   fabif_pcie2_reqmd0_cred_tvalid, fabif_pcie2_reqmd0_tready,
   fabif_pcie2_rwdatacomp_cred_mready, fabif_pcie2_rwdatacomp_tdata,
   fabif_pcie2_rwdatacomp_tdest, fabif_pcie2_rwdatacomp_tid,
   fabif_pcie2_rwdatacomp_tlast, fabif_pcie2_rwdatacomp_tuser,
   fabif_pcie2_rwdatacomp_tvalid,
   fabif_pcie2_rwdatacompmd_cred_mready,
   fabif_pcie2_rwdatacompmd_tdata, fabif_pcie2_rwdatacompmd_tdest,
   fabif_pcie2_rwdatacompmd_tid, fabif_pcie2_rwdatacompmd_tlast,
   fabif_pcie2_rwdatacompmd_tuser, fabif_pcie2_rwdatacompmd_tvalid,
   fabif_pcie2_wrdone_tready, fabif_pcie3_req0_cred_tdata,
   fabif_pcie3_req0_cred_tdest, fabif_pcie3_req0_cred_tuser,
   fabif_pcie3_req0_cred_tvalid, fabif_pcie3_req0_tready,
   fabif_pcie3_reqmd0_cred_tdata, fabif_pcie3_reqmd0_cred_tdest,
   fabif_pcie3_reqmd0_cred_tuser, fabif_pcie3_reqmd0_cred_tvalid,
   fabif_pcie3_reqmd0_tready, fabif_pcie3_rwdatacomp_cred_mready,
   fabif_pcie3_rwdatacomp_tdata, fabif_pcie3_rwdatacomp_tdest,
   fabif_pcie3_rwdatacomp_tid, fabif_pcie3_rwdatacomp_tlast,
   fabif_pcie3_rwdatacomp_tuser, fabif_pcie3_rwdatacomp_tvalid,
   fabif_pcie3_rwdatacompmd_cred_mready,
   fabif_pcie3_rwdatacompmd_tdata, fabif_pcie3_rwdatacompmd_tdest,
   fabif_pcie3_rwdatacompmd_tid, fabif_pcie3_rwdatacompmd_tlast,
   fabif_pcie3_rwdatacompmd_tuser, fabif_pcie3_rwdatacompmd_tvalid,
   fabif_pcie3_wrdone_tready, hbr0_f1_fabric_host_b_a_h2b_m_hbr_in,
   hbr0_f2_fabric_host_b_b_h2b_m_hbr_in,
   hbr0_f3_fabric_host_b_c_h2b_m_hbr_in,
   hbr0_f4_fabric_host_b_d_h2b_m_hbr_in,
   hbr0_f5_fabric_host_b_a_b2h_s_hbr_in,
   hbr0_f6_fabric_host_b_b_b2h_s_hbr_in,
   hbr0_f7_fabric_host_b_c_b2h_s_hbr_in,
   hbr0_f8_fabric_host_b_d_b2h_s_hbr_in,
   hbr1_f1_fabric_host_b_a_h2b_m_hbr_in,
   hbr1_f2_fabric_host_b_b_h2b_m_hbr_in,
   hbr1_f3_fabric_host_b_c_h2b_m_hbr_in,
   hbr1_f4_fabric_host_b_d_h2b_m_hbr_in,
   hbr1_f5_fabric_host_b_a_b2h_s_hbr_in,
   hbr1_f6_fabric_host_b_b_b2h_s_hbr_in,
   hbr1_f7_fabric_host_b_c_b2h_s_hbr_in,
   hbr1_f8_fabric_host_b_d_b2h_s_hbr_in,
   hbr2_f1_fabric_host_b_a_h2b_m_hbr_in,
   hbr2_f2_fabric_host_b_b_h2b_m_hbr_in,
   hbr2_f3_fabric_host_b_c_h2b_m_hbr_in,
   hbr2_f4_fabric_host_b_d_h2b_m_hbr_in,
   hbr2_f5_fabric_host_b_a_b2h_s_hbr_in,
   hbr2_f6_fabric_host_b_b_b2h_s_hbr_in,
   hbr2_f7_fabric_host_b_c_b2h_s_hbr_in,
   hbr2_f8_fabric_host_b_d_b2h_s_hbr_in, hif_lce_dbl_tdata,
   hif_lce_dbl_tdest, hif_lce_dbl_tlast, hif_lce_dbl_tuser,
   hif_lce_req0_cred_tdata, hif_lce_req0_cred_tdest,
   hif_lce_req0_cred_tvalid, hif_lce_req0_tready,
   hif_lce_reqmd0_cred_tdata, hif_lce_reqmd0_cred_tdest,
   hif_lce_reqmd0_cred_tvalid, hif_lce_reqmd0_tready,
   hif_lce_rwdatacomp_cred_mready, hif_lce_rwdatacomp_tdata,
   hif_lce_rwdatacomp_tdest, hif_lce_rwdatacomp_tid,
   hif_lce_rwdatacomp_tlast, hif_lce_rwdatacomp_tuser,
   hif_lce_rwdatacomp_tvalid, hif_lce_rwdatacompmd_cred_mready,
   hif_lce_rwdatacompmd_tdata, hif_lce_rwdatacompmd_tdest,
   hif_lce_rwdatacompmd_tid, hif_lce_rwdatacompmd_tlast,
   hif_lce_rwdatacompmd_tuser, hif_lce_rwdatacompmd_tvalid,
   hif_lce_rwreqmd_tvalid, hif_lce_wrdone_tdata, hif_lce_wrdone_tdest,
   hif_lce_wrdone_tlast, hif_lce_wrdone_tuser, hif_lce_wrdone_tvalid,
   hif_nocss_smh_peati_lce_ecc_uncor_err,
   hif_nocss_smh_peati_nvme0_ecc_uncor_err,
   hif_nocss_smh_peati_nvme1_ecc_uncor_err, hif_nvme0_dbl_tdata,
   hif_nvme0_dbl_tdest, hif_nvme0_dbl_tlast, hif_nvme0_dbl_tuser,
   hif_nvme0_req0_cred_tdata, hif_nvme0_req0_cred_tdest,
   hif_nvme0_req0_cred_tvalid, hif_nvme0_req0_tready,
   hif_nvme0_reqmd0_cred_tdata, hif_nvme0_reqmd0_cred_tdest,
   hif_nvme0_reqmd0_cred_tvalid, hif_nvme0_reqmd0_tready,
   hif_nvme0_rwdatacomp_cred_mready, hif_nvme0_rwdatacomp_tdata,
   hif_nvme0_rwdatacomp_tdest, hif_nvme0_rwdatacomp_tid,
   hif_nvme0_rwdatacomp_tlast, hif_nvme0_rwdatacomp_tuser,
   hif_nvme0_rwdatacomp_tvalid, hif_nvme0_rwdatacompmd_cred_mready,
   hif_nvme0_rwdatacompmd_tdata, hif_nvme0_rwdatacompmd_tdest,
   hif_nvme0_rwdatacompmd_tid, hif_nvme0_rwdatacompmd_tlast,
   hif_nvme0_rwdatacompmd_tuser, hif_nvme0_rwdatacompmd_tvalid,
   hif_nvme0_rwreqmd_tvalid, hif_nvme0_wrdone_tdata,
   hif_nvme0_wrdone_tdest, hif_nvme0_wrdone_tlast,
   hif_nvme0_wrdone_tuser, hif_nvme0_wrdone_tvalid,
   hif_nvme1_req0_cred_tdata, hif_nvme1_req0_cred_tdest,
   hif_nvme1_req0_cred_tvalid, hif_nvme1_req0_tready,
   hif_nvme1_reqmd0_cred_tdata, hif_nvme1_reqmd0_cred_tdest,
   hif_nvme1_reqmd0_cred_tvalid, hif_nvme1_reqmd0_tready,
   hif_nvme1_rwdatacomp_cred_mready, hif_nvme1_rwdatacomp_tdata,
   hif_nvme1_rwdatacomp_tdest, hif_nvme1_rwdatacomp_tid,
   hif_nvme1_rwdatacomp_tlast, hif_nvme1_rwdatacomp_tuser,
   hif_nvme1_rwdatacomp_tvalid, hif_nvme1_rwdatacompmd_cred_mready,
   hif_nvme1_rwdatacompmd_tdata, hif_nvme1_rwdatacompmd_tdest,
   hif_nvme1_rwdatacompmd_tid, hif_nvme1_rwdatacompmd_tlast,
   hif_nvme1_rwdatacompmd_tuser, hif_nvme1_rwdatacompmd_tvalid,
   hif_nvme1_wrdone_tdata, hif_nvme1_wrdone_tdest,
   hif_nvme1_wrdone_tlast, hif_nvme1_wrdone_tuser,
   hif_nvme1_wrdone_tvalid, hif_t_smh_fabric_if_prdata,
   hif_t_smh_fabric_if_pready, hif_t_smh_fabric_if_pslverr,
   hif_t_smh_fabric_prdata, hif_t_smh_fabric_pready,
   hif_t_smh_fabric_pslverr, lce_peati_shati_if, nvme0_peati_shati_if,
   nvme1_peati_shati_if,
   // Inputs
   hif_nocss_smh_bisr_clk, hif_nocss_smh_bisr_reset,
   hif_nocss_smh_bisr_shift_en, hif_nocss_smh_bisr_si,
   hif_nocss_smh_dft_spare_in,
   hif_nocss_smh_fdfx_debug_capabilities_enabling,
   hif_nocss_smh_fdfx_debug_capabilities_enabling_valid,
   hif_nocss_smh_fdfx_early_boot_debug_exit,
   hif_nocss_smh_fdfx_policy_update, hif_nocss_smh_fdfx_pwrgood,
   hif_nocss_smh_fdfx_security_policy, hif_nocss_smh_ijtag_nw_capture,
   hif_nocss_smh_ijtag_nw_reset_b, hif_nocss_smh_ijtag_nw_select,
   hif_nocss_smh_ijtag_nw_shift, hif_nocss_smh_ijtag_nw_si,
   hif_nocss_smh_ijtag_nw_update, hif_nocss_smh_nw_mode,
   hif_nocss_smh_shift_ir_dr, hif_nocss_smh_ssn_bus_clock_in,
   hif_nocss_smh_ssn_bus_data_in, hif_nocss_smh_tck,
   hif_nocss_smh_tdi, hif_nocss_smh_tms, hif_nocss_smh_tms_park_value,
   hif_nocss_smh_trst, nss_hif_clk, scon_hif_func_rst_raw_n,
   soc_per_clk, cmi0_fabif_req0_cred_mready, cmi0_fabif_req0_tdata,
   cmi0_fabif_req0_tdest, cmi0_fabif_req0_tid, cmi0_fabif_req0_tlast,
   cmi0_fabif_req0_tuser, cmi0_fabif_req0_tvalid,
   cmi0_fabif_reqmd0_cred_mready, cmi0_fabif_reqmd0_tdata,
   cmi0_fabif_reqmd0_tdest, cmi0_fabif_reqmd0_tid,
   cmi0_fabif_reqmd0_tlast, cmi0_fabif_reqmd0_tuser,
   cmi0_fabif_reqmd0_tvalid, cmi0_fabif_rwdatacomp_cred_tdata,
   cmi0_fabif_rwdatacomp_cred_tdest,
   cmi0_fabif_rwdatacomp_cred_tvalid, cmi0_fabif_rwdatacomp_tready,
   cmi0_fabif_rwdatacompmd_cred_tdata,
   cmi0_fabif_rwdatacompmd_cred_tdest,
   cmi0_fabif_rwdatacompmd_cred_tvalid,
   cmi0_fabif_rwdatacompmd_tready, cmi1_fabif_req0_cred_mready,
   cmi1_fabif_req0_tdata, cmi1_fabif_req0_tdest, cmi1_fabif_req0_tid,
   cmi1_fabif_req0_tlast, cmi1_fabif_req0_tuser,
   cmi1_fabif_req0_tvalid, cmi1_fabif_reqmd0_cred_mready,
   cmi1_fabif_reqmd0_tdata, cmi1_fabif_reqmd0_tdest,
   cmi1_fabif_reqmd0_tid, cmi1_fabif_reqmd0_tlast,
   cmi1_fabif_reqmd0_tuser, cmi1_fabif_reqmd0_tvalid,
   cmi1_fabif_rwdatacomp_cred_tdata, cmi1_fabif_rwdatacomp_cred_tdest,
   cmi1_fabif_rwdatacomp_cred_tvalid, cmi1_fabif_rwdatacomp_tready,
   cmi1_fabif_rwdatacompmd_cred_tdata,
   cmi1_fabif_rwdatacompmd_cred_tdest,
   cmi1_fabif_rwdatacompmd_cred_tvalid,
   cmi1_fabif_rwdatacompmd_tready, cmi1_fabif_wrdone_tdata,
   cmi1_fabif_wrdone_tdest, cmi1_fabif_wrdone_tlast,
   cmi1_fabif_wrdone_tuser, cmi1_fabif_wrdone_tvalid,
   hbr0_f1_fabric_host_b_a_h2b_s_hbr_out,
   hbr0_f2_fabric_host_b_b_h2b_s_hbr_out,
   hbr0_f3_fabric_host_b_c_h2b_s_hbr_out,
   hbr0_f4_fabric_host_b_d_h2b_s_hbr_out,
   hbr0_f5_fabric_host_b_a_b2h_m_hbr_out,
   hbr0_f6_fabric_host_b_b_b2h_m_hbr_out,
   hbr0_f7_fabric_host_b_c_b2h_m_hbr_out,
   hbr0_f8_fabric_host_b_d_b2h_m_hbr_out,
   hbr1_f1_fabric_host_b_a_h2b_s_hbr_out,
   hbr1_f2_fabric_host_b_b_h2b_s_hbr_out,
   hbr1_f3_fabric_host_b_c_h2b_s_hbr_out,
   hbr1_f4_fabric_host_b_d_h2b_s_hbr_out,
   hbr1_f5_fabric_host_b_a_b2h_m_hbr_out,
   hbr1_f6_fabric_host_b_b_b2h_m_hbr_out,
   hbr1_f7_fabric_host_b_c_b2h_m_hbr_out,
   hbr1_f8_fabric_host_b_d_b2h_m_hbr_out,
   hbr2_f1_fabric_host_b_a_h2b_s_hbr_out,
   hbr2_f2_fabric_host_b_b_h2b_s_hbr_out,
   hbr2_f3_fabric_host_b_c_h2b_s_hbr_out,
   hbr2_f4_fabric_host_b_d_h2b_s_hbr_out,
   hbr2_f5_fabric_host_b_a_b2h_m_hbr_out,
   hbr2_f6_fabric_host_b_b_b2h_m_hbr_out,
   hbr2_f7_fabric_host_b_c_b2h_m_hbr_out,
   hbr2_f8_fabric_host_b_d_b2h_m_hbr_out, hif_t_smh_fabric_if_paddr,
   hif_t_smh_fabric_if_penable, hif_t_smh_fabric_if_pprot,
   hif_t_smh_fabric_if_psel, hif_t_smh_fabric_if_pstrb,
   hif_t_smh_fabric_if_pwdata, hif_t_smh_fabric_if_pwrite,
   hif_t_smh_fabric_paddr, hif_t_smh_fabric_penable,
   hif_t_smh_fabric_pprot, hif_t_smh_fabric_psel,
   hif_t_smh_fabric_pstrb, hif_t_smh_fabric_pwdata,
   hif_t_smh_fabric_pwrite, lce_hif_dbl_tready,
   lce_hif_req0_cred_mready, lce_hif_req0_tdata, lce_hif_req0_tdest,
   lce_hif_req0_tid, lce_hif_req0_tlast, lce_hif_req0_tuser,
   lce_hif_req0_tvalid, lce_hif_reqmd0_cred_mready,
   lce_hif_reqmd0_tdata, lce_hif_reqmd0_tdest, lce_hif_reqmd0_tid,
   lce_hif_reqmd0_tlast, lce_hif_reqmd0_tuser, lce_hif_reqmd0_tvalid,
   lce_hif_rwdatacomp_cred_tdata, lce_hif_rwdatacomp_cred_tdest,
   lce_hif_rwdatacomp_cred_tvalid, lce_hif_rwdatacompmd_cred_tdata,
   lce_hif_rwdatacompmd_cred_tdest, lce_hif_rwdatacompmd_cred_tvalid,
   lce_hif_wrdone_tready, nvme0_hif_dbl_tready,
   nvme0_hif_req0_cred_mready, nvme0_hif_req0_tdata,
   nvme0_hif_req0_tdest, nvme0_hif_req0_tid, nvme0_hif_req0_tlast,
   nvme0_hif_req0_tuser, nvme0_hif_req0_tvalid,
   nvme0_hif_reqmd0_cred_mready, nvme0_hif_reqmd0_tdata,
   nvme0_hif_reqmd0_tdest, nvme0_hif_reqmd0_tid,
   nvme0_hif_reqmd0_tlast, nvme0_hif_reqmd0_tuser,
   nvme0_hif_reqmd0_tvalid, nvme0_hif_rwdatacomp_cred_tdata,
   nvme0_hif_rwdatacomp_cred_tdest, nvme0_hif_rwdatacomp_cred_tvalid,
   nvme0_hif_rwdatacompmd_cred_tdata,
   nvme0_hif_rwdatacompmd_cred_tdest,
   nvme0_hif_rwdatacompmd_cred_tvalid, nvme0_hif_wrdone_tready,
   nvme1_hif_req0_cred_mready, nvme1_hif_req0_tdata,
   nvme1_hif_req0_tdest, nvme1_hif_req0_tid, nvme1_hif_req0_tlast,
   nvme1_hif_req0_tuser, nvme1_hif_req0_tvalid,
   nvme1_hif_reqmd0_cred_mready, nvme1_hif_reqmd0_tdata,
   nvme1_hif_reqmd0_tdest, nvme1_hif_reqmd0_tid,
   nvme1_hif_reqmd0_tlast, nvme1_hif_reqmd0_tuser,
   nvme1_hif_reqmd0_tvalid, nvme1_hif_rwdatacomp_cred_tdata,
   nvme1_hif_rwdatacomp_cred_tdest, nvme1_hif_rwdatacomp_cred_tvalid,
   nvme1_hif_rwdatacompmd_cred_tdata,
   nvme1_hif_rwdatacompmd_cred_tdest,
   nvme1_hif_rwdatacompmd_cred_tvalid, nvme1_hif_wrdone_tready,
   pcie2_fabif_req0_cred_mready, pcie2_fabif_req0_tdata,
   pcie2_fabif_req0_tdest, pcie2_fabif_req0_tid,
   pcie2_fabif_req0_tlast, pcie2_fabif_req0_tuser,
   pcie2_fabif_req0_tvalid, pcie2_fabif_reqmd0_cred_mready,
   pcie2_fabif_reqmd0_tdata, pcie2_fabif_reqmd0_tdest,
   pcie2_fabif_reqmd0_tid, pcie2_fabif_reqmd0_tlast,
   pcie2_fabif_reqmd0_tuser, pcie2_fabif_reqmd0_tvalid,
   pcie2_fabif_rwdatacomp_cred_tdata,
   pcie2_fabif_rwdatacomp_cred_tdest,
   pcie2_fabif_rwdatacomp_cred_tvalid, pcie2_fabif_rwdatacomp_tready,
   pcie2_fabif_rwdatacompmd_cred_tdata,
   pcie2_fabif_rwdatacompmd_cred_tdest,
   pcie2_fabif_rwdatacompmd_cred_tvalid,
   pcie2_fabif_rwdatacompmd_tready, pcie2_fabif_wrdone_tdata,
   pcie2_fabif_wrdone_tdest, pcie2_fabif_wrdone_tlast,
   pcie2_fabif_wrdone_tuser, pcie2_fabif_wrdone_tvalid,
   pcie3_fabif_req0_cred_mready, pcie3_fabif_req0_tdata,
   pcie3_fabif_req0_tdest, pcie3_fabif_req0_tid,
   pcie3_fabif_req0_tlast, pcie3_fabif_req0_tuser,
   pcie3_fabif_req0_tvalid, pcie3_fabif_reqmd0_cred_mready,
   pcie3_fabif_reqmd0_tdata, pcie3_fabif_reqmd0_tdest,
   pcie3_fabif_reqmd0_tid, pcie3_fabif_reqmd0_tlast,
   pcie3_fabif_reqmd0_tuser, pcie3_fabif_reqmd0_tvalid,
   pcie3_fabif_rwdatacomp_cred_tdata,
   pcie3_fabif_rwdatacomp_cred_tdest,
   pcie3_fabif_rwdatacomp_cred_tvalid, pcie3_fabif_rwdatacomp_tready,
   pcie3_fabif_rwdatacompmd_cred_tdata,
   pcie3_fabif_rwdatacompmd_cred_tdest,
   pcie3_fabif_rwdatacompmd_cred_tvalid,
   pcie3_fabif_rwdatacompmd_tready, pcie3_fabif_wrdone_tdata,
   pcie3_fabif_wrdone_tdest, pcie3_fabif_wrdone_tlast,
   pcie3_fabif_wrdone_tuser, pcie3_fabif_wrdone_tvalid,
   ras_dis_stop_r, shati_ecc_err_r, shati_lce_peati_if,
   shati_nvme0_peati_if, shati_nvme1_peati_if, syscon_Int_only_l2_dis,
   syscon_dfd_l0_dis, syscon_dfd_l1_dis
   );

/*AUTOINOUTMODULE("hif_nocss_smh_top")*/
// Beginning of automatic in/out/inouts (from specific module)
output			hif_nocss_smh_aary_mbist_diag_done;
output			hif_nocss_smh_bisr_so;
output [1:0]		hif_nocss_smh_dft_spare_out;
output			hif_nocss_smh_ijtag_nw_so;
output [31:0]		hif_nocss_smh_ssn_bus_data_out;
output			hif_nocss_smh_tap_sel_in;
output			hif_nocss_smh_tdo;
output [7:0]		fabif_cmi0_req0_cred_tdata;
output [9:0]		fabif_cmi0_req0_cred_tdest;
output			fabif_cmi0_req0_cred_tuser;
output			fabif_cmi0_req0_cred_tvalid;
output			fabif_cmi0_req0_tready;
output [7:0]		fabif_cmi0_reqmd0_cred_tdata;
output [9:0]		fabif_cmi0_reqmd0_cred_tdest;
output			fabif_cmi0_reqmd0_cred_tuser;
output			fabif_cmi0_reqmd0_cred_tvalid;
output			fabif_cmi0_reqmd0_tready;
output			fabif_cmi0_rwdatacomp_cred_mready;
output [1023:0]		fabif_cmi0_rwdatacomp_tdata;
output [9:0]		fabif_cmi0_rwdatacomp_tdest;
output [8:0]		fabif_cmi0_rwdatacomp_tid;
output			fabif_cmi0_rwdatacomp_tlast;
output [55:0]		fabif_cmi0_rwdatacomp_tuser;
output			fabif_cmi0_rwdatacomp_tvalid;
output			fabif_cmi0_rwdatacompmd_cred_mready;
output [287:0]		fabif_cmi0_rwdatacompmd_tdata;
output [9:0]		fabif_cmi0_rwdatacompmd_tdest;
output [8:0]		fabif_cmi0_rwdatacompmd_tid;
output			fabif_cmi0_rwdatacompmd_tlast;
output [15:0]		fabif_cmi0_rwdatacompmd_tuser;
output			fabif_cmi0_rwdatacompmd_tvalid;
output [7:0]		fabif_cmi1_req0_cred_tdata;
output [9:0]		fabif_cmi1_req0_cred_tdest;
output			fabif_cmi1_req0_cred_tuser;
output			fabif_cmi1_req0_cred_tvalid;
output			fabif_cmi1_req0_tready;
output [7:0]		fabif_cmi1_reqmd0_cred_tdata;
output [9:0]		fabif_cmi1_reqmd0_cred_tdest;
output			fabif_cmi1_reqmd0_cred_tuser;
output			fabif_cmi1_reqmd0_cred_tvalid;
output			fabif_cmi1_reqmd0_tready;
output			fabif_cmi1_rwdatacomp_cred_mready;
output [1023:0]		fabif_cmi1_rwdatacomp_tdata;
output [9:0]		fabif_cmi1_rwdatacomp_tdest;
output [8:0]		fabif_cmi1_rwdatacomp_tid;
output			fabif_cmi1_rwdatacomp_tlast;
output [55:0]		fabif_cmi1_rwdatacomp_tuser;
output			fabif_cmi1_rwdatacomp_tvalid;
output			fabif_cmi1_rwdatacompmd_cred_mready;
output [287:0]		fabif_cmi1_rwdatacompmd_tdata;
output [9:0]		fabif_cmi1_rwdatacompmd_tdest;
output [8:0]		fabif_cmi1_rwdatacompmd_tid;
output			fabif_cmi1_rwdatacompmd_tlast;
output [15:0]		fabif_cmi1_rwdatacompmd_tuser;
output			fabif_cmi1_rwdatacompmd_tvalid;
output			fabif_cmi1_wrdone_tready;
output [7:0]		fabif_pcie2_req0_cred_tdata;
output [9:0]		fabif_pcie2_req0_cred_tdest;
output			fabif_pcie2_req0_cred_tuser;
output			fabif_pcie2_req0_cred_tvalid;
output			fabif_pcie2_req0_tready;
output [7:0]		fabif_pcie2_reqmd0_cred_tdata;
output [9:0]		fabif_pcie2_reqmd0_cred_tdest;
output			fabif_pcie2_reqmd0_cred_tuser;
output			fabif_pcie2_reqmd0_cred_tvalid;
output			fabif_pcie2_reqmd0_tready;
output			fabif_pcie2_rwdatacomp_cred_mready;
output [1023:0]		fabif_pcie2_rwdatacomp_tdata;
output [9:0]		fabif_pcie2_rwdatacomp_tdest;
output [8:0]		fabif_pcie2_rwdatacomp_tid;
output			fabif_pcie2_rwdatacomp_tlast;
output [55:0]		fabif_pcie2_rwdatacomp_tuser;
output			fabif_pcie2_rwdatacomp_tvalid;
output			fabif_pcie2_rwdatacompmd_cred_mready;
output [287:0]		fabif_pcie2_rwdatacompmd_tdata;
output [9:0]		fabif_pcie2_rwdatacompmd_tdest;
output [8:0]		fabif_pcie2_rwdatacompmd_tid;
output			fabif_pcie2_rwdatacompmd_tlast;
output [15:0]		fabif_pcie2_rwdatacompmd_tuser;
output			fabif_pcie2_rwdatacompmd_tvalid;
output			fabif_pcie2_wrdone_tready;
output [7:0]		fabif_pcie3_req0_cred_tdata;
output [9:0]		fabif_pcie3_req0_cred_tdest;
output			fabif_pcie3_req0_cred_tuser;
output			fabif_pcie3_req0_cred_tvalid;
output			fabif_pcie3_req0_tready;
output [7:0]		fabif_pcie3_reqmd0_cred_tdata;
output [9:0]		fabif_pcie3_reqmd0_cred_tdest;
output			fabif_pcie3_reqmd0_cred_tuser;
output			fabif_pcie3_reqmd0_cred_tvalid;
output			fabif_pcie3_reqmd0_tready;
output			fabif_pcie3_rwdatacomp_cred_mready;
output [1023:0]		fabif_pcie3_rwdatacomp_tdata;
output [9:0]		fabif_pcie3_rwdatacomp_tdest;
output [8:0]		fabif_pcie3_rwdatacomp_tid;
output			fabif_pcie3_rwdatacomp_tlast;
output [55:0]		fabif_pcie3_rwdatacomp_tuser;
output			fabif_pcie3_rwdatacomp_tvalid;
output			fabif_pcie3_rwdatacompmd_cred_mready;
output [287:0]		fabif_pcie3_rwdatacompmd_tdata;
output [9:0]		fabif_pcie3_rwdatacompmd_tdest;
output [8:0]		fabif_pcie3_rwdatacompmd_tid;
output			fabif_pcie3_rwdatacompmd_tlast;
output [15:0]		fabif_pcie3_rwdatacompmd_tuser;
output			fabif_pcie3_rwdatacompmd_tvalid;
output			fabif_pcie3_wrdone_tready;
output [367:0]		hbr0_f1_fabric_host_b_a_h2b_m_hbr_in;
output [1183:0]		hbr0_f2_fabric_host_b_b_h2b_m_hbr_in;
output [67:0]		hbr0_f3_fabric_host_b_c_h2b_m_hbr_in;
output [49:0]		hbr0_f4_fabric_host_b_d_h2b_m_hbr_in;
output [1:0]		hbr0_f5_fabric_host_b_a_b2h_s_hbr_in;
output [1:0]		hbr0_f6_fabric_host_b_b_b2h_s_hbr_in;
output [1:0]		hbr0_f7_fabric_host_b_c_b2h_s_hbr_in;
output [1:0]		hbr0_f8_fabric_host_b_d_b2h_s_hbr_in;
output [367:0]		hbr1_f1_fabric_host_b_a_h2b_m_hbr_in;
output [1183:0]		hbr1_f2_fabric_host_b_b_h2b_m_hbr_in;
output [67:0]		hbr1_f3_fabric_host_b_c_h2b_m_hbr_in;
output [49:0]		hbr1_f4_fabric_host_b_d_h2b_m_hbr_in;
output [1:0]		hbr1_f5_fabric_host_b_a_b2h_s_hbr_in;
output [1:0]		hbr1_f6_fabric_host_b_b_b2h_s_hbr_in;
output [1:0]		hbr1_f7_fabric_host_b_c_b2h_s_hbr_in;
output [1:0]		hbr1_f8_fabric_host_b_d_b2h_s_hbr_in;
output [367:0]		hbr2_f1_fabric_host_b_a_h2b_m_hbr_in;
output [1183:0]		hbr2_f2_fabric_host_b_b_h2b_m_hbr_in;
output [67:0]		hbr2_f3_fabric_host_b_c_h2b_m_hbr_in;
output [49:0]		hbr2_f4_fabric_host_b_d_h2b_m_hbr_in;
output [1:0]		hbr2_f5_fabric_host_b_a_b2h_s_hbr_in;
output [1:0]		hbr2_f6_fabric_host_b_b_b2h_s_hbr_in;
output [1:0]		hbr2_f7_fabric_host_b_c_b2h_s_hbr_in;
output [1:0]		hbr2_f8_fabric_host_b_d_b2h_s_hbr_in;
output [129:0]		hif_lce_dbl_tdata;
output [2:0]		hif_lce_dbl_tdest;
output			hif_lce_dbl_tlast;
output [1:0]		hif_lce_dbl_tuser;
output [7:0]		hif_lce_req0_cred_tdata;
output [5:0]		hif_lce_req0_cred_tdest;
output			hif_lce_req0_cred_tvalid;
output			hif_lce_req0_tready;
output [7:0]		hif_lce_reqmd0_cred_tdata;
output [5:0]		hif_lce_reqmd0_cred_tdest;
output			hif_lce_reqmd0_cred_tvalid;
output			hif_lce_reqmd0_tready;
output			hif_lce_rwdatacomp_cred_mready;
output [1023:0]		hif_lce_rwdatacomp_tdata;
output [5:0]		hif_lce_rwdatacomp_tdest;
output [8:0]		hif_lce_rwdatacomp_tid;
output			hif_lce_rwdatacomp_tlast;
output [46:0]		hif_lce_rwdatacomp_tuser;
output			hif_lce_rwdatacomp_tvalid;
output			hif_lce_rwdatacompmd_cred_mready;
output [5:0]		hif_lce_rwdatacompmd_tdata;
output [5:0]		hif_lce_rwdatacompmd_tdest;
output [8:0]		hif_lce_rwdatacompmd_tid;
output			hif_lce_rwdatacompmd_tlast;
output			hif_lce_rwdatacompmd_tuser;
output			hif_lce_rwdatacompmd_tvalid;
output			hif_lce_rwreqmd_tvalid;
output [19:0]		hif_lce_wrdone_tdata;
output [5:0]		hif_lce_wrdone_tdest;
output			hif_lce_wrdone_tlast;
output			hif_lce_wrdone_tuser;
output			hif_lce_wrdone_tvalid;
output			hif_nocss_smh_peati_lce_ecc_uncor_err;
output			hif_nocss_smh_peati_nvme0_ecc_uncor_err;
output			hif_nocss_smh_peati_nvme1_ecc_uncor_err;
output [129:0]		hif_nvme0_dbl_tdata;
output [2:0]		hif_nvme0_dbl_tdest;
output			hif_nvme0_dbl_tlast;
output [1:0]		hif_nvme0_dbl_tuser;
output [7:0]		hif_nvme0_req0_cred_tdata;
output [5:0]		hif_nvme0_req0_cred_tdest;
output			hif_nvme0_req0_cred_tvalid;
output			hif_nvme0_req0_tready;
output [7:0]		hif_nvme0_reqmd0_cred_tdata;
output [5:0]		hif_nvme0_reqmd0_cred_tdest;
output			hif_nvme0_reqmd0_cred_tvalid;
output			hif_nvme0_reqmd0_tready;
output			hif_nvme0_rwdatacomp_cred_mready;
output [1023:0]		hif_nvme0_rwdatacomp_tdata;
output [5:0]		hif_nvme0_rwdatacomp_tdest;
output [8:0]		hif_nvme0_rwdatacomp_tid;
output			hif_nvme0_rwdatacomp_tlast;
output [46:0]		hif_nvme0_rwdatacomp_tuser;
output			hif_nvme0_rwdatacomp_tvalid;
output			hif_nvme0_rwdatacompmd_cred_mready;
output [5:0]		hif_nvme0_rwdatacompmd_tdata;
output [5:0]		hif_nvme0_rwdatacompmd_tdest;
output [8:0]		hif_nvme0_rwdatacompmd_tid;
output			hif_nvme0_rwdatacompmd_tlast;
output			hif_nvme0_rwdatacompmd_tuser;
output			hif_nvme0_rwdatacompmd_tvalid;
output			hif_nvme0_rwreqmd_tvalid;
output [19:0]		hif_nvme0_wrdone_tdata;
output [5:0]		hif_nvme0_wrdone_tdest;
output			hif_nvme0_wrdone_tlast;
output			hif_nvme0_wrdone_tuser;
output			hif_nvme0_wrdone_tvalid;
output [7:0]		hif_nvme1_req0_cred_tdata;
output [5:0]		hif_nvme1_req0_cred_tdest;
output			hif_nvme1_req0_cred_tvalid;
output			hif_nvme1_req0_tready;
output [7:0]		hif_nvme1_reqmd0_cred_tdata;
output [5:0]		hif_nvme1_reqmd0_cred_tdest;
output			hif_nvme1_reqmd0_cred_tvalid;
output			hif_nvme1_reqmd0_tready;
output			hif_nvme1_rwdatacomp_cred_mready;
output [1023:0]		hif_nvme1_rwdatacomp_tdata;
output [5:0]		hif_nvme1_rwdatacomp_tdest;
output [8:0]		hif_nvme1_rwdatacomp_tid;
output			hif_nvme1_rwdatacomp_tlast;
output [46:0]		hif_nvme1_rwdatacomp_tuser;
output			hif_nvme1_rwdatacomp_tvalid;
output			hif_nvme1_rwdatacompmd_cred_mready;
output [5:0]		hif_nvme1_rwdatacompmd_tdata;
output [5:0]		hif_nvme1_rwdatacompmd_tdest;
output [8:0]		hif_nvme1_rwdatacompmd_tid;
output			hif_nvme1_rwdatacompmd_tlast;
output			hif_nvme1_rwdatacompmd_tuser;
output			hif_nvme1_rwdatacompmd_tvalid;
output [19:0]		hif_nvme1_wrdone_tdata;
output [5:0]		hif_nvme1_wrdone_tdest;
output			hif_nvme1_wrdone_tlast;
output			hif_nvme1_wrdone_tuser;
output			hif_nvme1_wrdone_tvalid;
output [31:0]		hif_t_smh_fabric_if_prdata;
output			hif_t_smh_fabric_if_pready;
output			hif_t_smh_fabric_if_pslverr;
output [31:0]		hif_t_smh_fabric_prdata;
output			hif_t_smh_fabric_pready;
output			hif_t_smh_fabric_pslverr;
output [281:0]		lce_peati_shati_if;
output [281:0]		nvme0_peati_shati_if;
output [281:0]		nvme1_peati_shati_if;
input			hif_nocss_smh_bisr_clk;
input			hif_nocss_smh_bisr_reset;
input			hif_nocss_smh_bisr_shift_en;
input			hif_nocss_smh_bisr_si;
input [7:0]		hif_nocss_smh_dft_spare_in;
input [7:0]		hif_nocss_smh_fdfx_debug_capabilities_enabling;
input			hif_nocss_smh_fdfx_debug_capabilities_enabling_valid;
input			hif_nocss_smh_fdfx_early_boot_debug_exit;
input			hif_nocss_smh_fdfx_policy_update;
input			hif_nocss_smh_fdfx_pwrgood;
input [7:0]		hif_nocss_smh_fdfx_security_policy;
input			hif_nocss_smh_ijtag_nw_capture;
input			hif_nocss_smh_ijtag_nw_reset_b;
input			hif_nocss_smh_ijtag_nw_select;
input			hif_nocss_smh_ijtag_nw_shift;
input			hif_nocss_smh_ijtag_nw_si;
input			hif_nocss_smh_ijtag_nw_update;
input			hif_nocss_smh_nw_mode;
input			hif_nocss_smh_shift_ir_dr;
input			hif_nocss_smh_ssn_bus_clock_in;
input [31:0]		hif_nocss_smh_ssn_bus_data_in;
input			hif_nocss_smh_tck;
input			hif_nocss_smh_tdi;
input			hif_nocss_smh_tms;
input			hif_nocss_smh_tms_park_value;
input			hif_nocss_smh_trst;
input			nss_hif_clk;
input			scon_hif_func_rst_raw_n;
input			soc_per_clk;
input			cmi0_fabif_req0_cred_mready;
input [1023:0]		cmi0_fabif_req0_tdata;
input [9:0]		cmi0_fabif_req0_tdest;
input [8:0]		cmi0_fabif_req0_tid;
input			cmi0_fabif_req0_tlast;
input [55:0]		cmi0_fabif_req0_tuser;
input			cmi0_fabif_req0_tvalid;
input			cmi0_fabif_reqmd0_cred_mready;
input [287:0]		cmi0_fabif_reqmd0_tdata;
input [9:0]		cmi0_fabif_reqmd0_tdest;
input [8:0]		cmi0_fabif_reqmd0_tid;
input			cmi0_fabif_reqmd0_tlast;
input [15:0]		cmi0_fabif_reqmd0_tuser;
input			cmi0_fabif_reqmd0_tvalid;
input [7:0]		cmi0_fabif_rwdatacomp_cred_tdata;
input [9:0]		cmi0_fabif_rwdatacomp_cred_tdest;
input			cmi0_fabif_rwdatacomp_cred_tvalid;
input			cmi0_fabif_rwdatacomp_tready;
input [7:0]		cmi0_fabif_rwdatacompmd_cred_tdata;
input [9:0]		cmi0_fabif_rwdatacompmd_cred_tdest;
input			cmi0_fabif_rwdatacompmd_cred_tvalid;
input			cmi0_fabif_rwdatacompmd_tready;
input			cmi1_fabif_req0_cred_mready;
input [1023:0]		cmi1_fabif_req0_tdata;
input [9:0]		cmi1_fabif_req0_tdest;
input [8:0]		cmi1_fabif_req0_tid;
input			cmi1_fabif_req0_tlast;
input [55:0]		cmi1_fabif_req0_tuser;
input			cmi1_fabif_req0_tvalid;
input			cmi1_fabif_reqmd0_cred_mready;
input [287:0]		cmi1_fabif_reqmd0_tdata;
input [9:0]		cmi1_fabif_reqmd0_tdest;
input [8:0]		cmi1_fabif_reqmd0_tid;
input			cmi1_fabif_reqmd0_tlast;
input [15:0]		cmi1_fabif_reqmd0_tuser;
input			cmi1_fabif_reqmd0_tvalid;
input [7:0]		cmi1_fabif_rwdatacomp_cred_tdata;
input [9:0]		cmi1_fabif_rwdatacomp_cred_tdest;
input			cmi1_fabif_rwdatacomp_cred_tvalid;
input			cmi1_fabif_rwdatacomp_tready;
input [7:0]		cmi1_fabif_rwdatacompmd_cred_tdata;
input [9:0]		cmi1_fabif_rwdatacompmd_cred_tdest;
input			cmi1_fabif_rwdatacompmd_cred_tvalid;
input			cmi1_fabif_rwdatacompmd_tready;
input [19:0]		cmi1_fabif_wrdone_tdata;
input [9:0]		cmi1_fabif_wrdone_tdest;
input			cmi1_fabif_wrdone_tlast;
input [3:0]		cmi1_fabif_wrdone_tuser;
input			cmi1_fabif_wrdone_tvalid;
input [1:0]		hbr0_f1_fabric_host_b_a_h2b_s_hbr_out;
input [1:0]		hbr0_f2_fabric_host_b_b_h2b_s_hbr_out;
input [1:0]		hbr0_f3_fabric_host_b_c_h2b_s_hbr_out;
input [1:0]		hbr0_f4_fabric_host_b_d_h2b_s_hbr_out;
input [356:0]		hbr0_f5_fabric_host_b_a_b2h_m_hbr_out;
input [1172:0]		hbr0_f6_fabric_host_b_b_b2h_m_hbr_out;
input [56:0]		hbr0_f7_fabric_host_b_c_b2h_m_hbr_out;
input [38:0]		hbr0_f8_fabric_host_b_d_b2h_m_hbr_out;
input [1:0]		hbr1_f1_fabric_host_b_a_h2b_s_hbr_out;
input [1:0]		hbr1_f2_fabric_host_b_b_h2b_s_hbr_out;
input [1:0]		hbr1_f3_fabric_host_b_c_h2b_s_hbr_out;
input [1:0]		hbr1_f4_fabric_host_b_d_h2b_s_hbr_out;
input [356:0]		hbr1_f5_fabric_host_b_a_b2h_m_hbr_out;
input [1172:0]		hbr1_f6_fabric_host_b_b_b2h_m_hbr_out;
input [56:0]		hbr1_f7_fabric_host_b_c_b2h_m_hbr_out;
input [38:0]		hbr1_f8_fabric_host_b_d_b2h_m_hbr_out;
input [1:0]		hbr2_f1_fabric_host_b_a_h2b_s_hbr_out;
input [1:0]		hbr2_f2_fabric_host_b_b_h2b_s_hbr_out;
input [1:0]		hbr2_f3_fabric_host_b_c_h2b_s_hbr_out;
input [1:0]		hbr2_f4_fabric_host_b_d_h2b_s_hbr_out;
input [356:0]		hbr2_f5_fabric_host_b_a_b2h_m_hbr_out;
input [1172:0]		hbr2_f6_fabric_host_b_b_b2h_m_hbr_out;
input [56:0]		hbr2_f7_fabric_host_b_c_b2h_m_hbr_out;
input [38:0]		hbr2_f8_fabric_host_b_d_b2h_m_hbr_out;
input [31:0]		hif_t_smh_fabric_if_paddr;
input			hif_t_smh_fabric_if_penable;
input [2:0]		hif_t_smh_fabric_if_pprot;
input			hif_t_smh_fabric_if_psel;
input [3:0]		hif_t_smh_fabric_if_pstrb;
input [31:0]		hif_t_smh_fabric_if_pwdata;
input			hif_t_smh_fabric_if_pwrite;
input [31:0]		hif_t_smh_fabric_paddr;
input			hif_t_smh_fabric_penable;
input [2:0]		hif_t_smh_fabric_pprot;
input			hif_t_smh_fabric_psel;
input [3:0]		hif_t_smh_fabric_pstrb;
input [31:0]		hif_t_smh_fabric_pwdata;
input			hif_t_smh_fabric_pwrite;
input			lce_hif_dbl_tready;
input			lce_hif_req0_cred_mready;
input [1023:0]		lce_hif_req0_tdata;
input [5:0]		lce_hif_req0_tdest;
input [8:0]		lce_hif_req0_tid;
input			lce_hif_req0_tlast;
input			lce_hif_req0_tuser;
input			lce_hif_req0_tvalid;
input			lce_hif_reqmd0_cred_mready;
input [218:0]		lce_hif_reqmd0_tdata;
input [5:0]		lce_hif_reqmd0_tdest;
input [8:0]		lce_hif_reqmd0_tid;
input			lce_hif_reqmd0_tlast;
input			lce_hif_reqmd0_tuser;
input			lce_hif_reqmd0_tvalid;
input [7:0]		lce_hif_rwdatacomp_cred_tdata;
input [5:0]		lce_hif_rwdatacomp_cred_tdest;
input			lce_hif_rwdatacomp_cred_tvalid;
input [7:0]		lce_hif_rwdatacompmd_cred_tdata;
input [5:0]		lce_hif_rwdatacompmd_cred_tdest;
input			lce_hif_rwdatacompmd_cred_tvalid;
input			lce_hif_wrdone_tready;
input			nvme0_hif_dbl_tready;
input			nvme0_hif_req0_cred_mready;
input [1023:0]		nvme0_hif_req0_tdata;
input [5:0]		nvme0_hif_req0_tdest;
input [8:0]		nvme0_hif_req0_tid;
input			nvme0_hif_req0_tlast;
input			nvme0_hif_req0_tuser;
input			nvme0_hif_req0_tvalid;
input			nvme0_hif_reqmd0_cred_mready;
input [218:0]		nvme0_hif_reqmd0_tdata;
input [5:0]		nvme0_hif_reqmd0_tdest;
input [8:0]		nvme0_hif_reqmd0_tid;
input			nvme0_hif_reqmd0_tlast;
input			nvme0_hif_reqmd0_tuser;
input			nvme0_hif_reqmd0_tvalid;
input [7:0]		nvme0_hif_rwdatacomp_cred_tdata;
input [5:0]		nvme0_hif_rwdatacomp_cred_tdest;
input			nvme0_hif_rwdatacomp_cred_tvalid;
input [7:0]		nvme0_hif_rwdatacompmd_cred_tdata;
input [5:0]		nvme0_hif_rwdatacompmd_cred_tdest;
input			nvme0_hif_rwdatacompmd_cred_tvalid;
input			nvme0_hif_wrdone_tready;
input			nvme1_hif_req0_cred_mready;
input [1023:0]		nvme1_hif_req0_tdata;
input [5:0]		nvme1_hif_req0_tdest;
input [8:0]		nvme1_hif_req0_tid;
input			nvme1_hif_req0_tlast;
input			nvme1_hif_req0_tuser;
input			nvme1_hif_req0_tvalid;
input			nvme1_hif_reqmd0_cred_mready;
input [218:0]		nvme1_hif_reqmd0_tdata;
input [5:0]		nvme1_hif_reqmd0_tdest;
input [8:0]		nvme1_hif_reqmd0_tid;
input			nvme1_hif_reqmd0_tlast;
input			nvme1_hif_reqmd0_tuser;
input			nvme1_hif_reqmd0_tvalid;
input [7:0]		nvme1_hif_rwdatacomp_cred_tdata;
input [5:0]		nvme1_hif_rwdatacomp_cred_tdest;
input			nvme1_hif_rwdatacomp_cred_tvalid;
input [7:0]		nvme1_hif_rwdatacompmd_cred_tdata;
input [5:0]		nvme1_hif_rwdatacompmd_cred_tdest;
input			nvme1_hif_rwdatacompmd_cred_tvalid;
input			nvme1_hif_wrdone_tready;
input			pcie2_fabif_req0_cred_mready;
input [1023:0]		pcie2_fabif_req0_tdata;
input [9:0]		pcie2_fabif_req0_tdest;
input [8:0]		pcie2_fabif_req0_tid;
input			pcie2_fabif_req0_tlast;
input [55:0]		pcie2_fabif_req0_tuser;
input			pcie2_fabif_req0_tvalid;
input			pcie2_fabif_reqmd0_cred_mready;
input [287:0]		pcie2_fabif_reqmd0_tdata;
input [9:0]		pcie2_fabif_reqmd0_tdest;
input [8:0]		pcie2_fabif_reqmd0_tid;
input			pcie2_fabif_reqmd0_tlast;
input [15:0]		pcie2_fabif_reqmd0_tuser;
input			pcie2_fabif_reqmd0_tvalid;
input [7:0]		pcie2_fabif_rwdatacomp_cred_tdata;
input [9:0]		pcie2_fabif_rwdatacomp_cred_tdest;
input			pcie2_fabif_rwdatacomp_cred_tvalid;
input			pcie2_fabif_rwdatacomp_tready;
input [7:0]		pcie2_fabif_rwdatacompmd_cred_tdata;
input [9:0]		pcie2_fabif_rwdatacompmd_cred_tdest;
input			pcie2_fabif_rwdatacompmd_cred_tvalid;
input			pcie2_fabif_rwdatacompmd_tready;
input [19:0]		pcie2_fabif_wrdone_tdata;
input [9:0]		pcie2_fabif_wrdone_tdest;
input			pcie2_fabif_wrdone_tlast;
input [3:0]		pcie2_fabif_wrdone_tuser;
input			pcie2_fabif_wrdone_tvalid;
input			pcie3_fabif_req0_cred_mready;
input [1023:0]		pcie3_fabif_req0_tdata;
input [9:0]		pcie3_fabif_req0_tdest;
input [8:0]		pcie3_fabif_req0_tid;
input			pcie3_fabif_req0_tlast;
input [55:0]		pcie3_fabif_req0_tuser;
input			pcie3_fabif_req0_tvalid;
input			pcie3_fabif_reqmd0_cred_mready;
input [287:0]		pcie3_fabif_reqmd0_tdata;
input [9:0]		pcie3_fabif_reqmd0_tdest;
input [8:0]		pcie3_fabif_reqmd0_tid;
input			pcie3_fabif_reqmd0_tlast;
input [15:0]		pcie3_fabif_reqmd0_tuser;
input			pcie3_fabif_reqmd0_tvalid;
input [7:0]		pcie3_fabif_rwdatacomp_cred_tdata;
input [9:0]		pcie3_fabif_rwdatacomp_cred_tdest;
input			pcie3_fabif_rwdatacomp_cred_tvalid;
input			pcie3_fabif_rwdatacomp_tready;
input [7:0]		pcie3_fabif_rwdatacompmd_cred_tdata;
input [9:0]		pcie3_fabif_rwdatacompmd_cred_tdest;
input			pcie3_fabif_rwdatacompmd_cred_tvalid;
input			pcie3_fabif_rwdatacompmd_tready;
input [19:0]		pcie3_fabif_wrdone_tdata;
input [9:0]		pcie3_fabif_wrdone_tdest;
input			pcie3_fabif_wrdone_tlast;
input [3:0]		pcie3_fabif_wrdone_tuser;
input			pcie3_fabif_wrdone_tvalid;
input			ras_dis_stop_r;
input			shati_ecc_err_r;
input [116:0]		shati_lce_peati_if;
input [116:0]		shati_nvme0_peati_if;
input [116:0]		shati_nvme1_peati_if;
input			syscon_Int_only_l2_dis;
input			syscon_dfd_l0_dis;
input			syscon_dfd_l1_dis;
// End of automatics

assign  lce_peati_shati_if = 282'hf;
assign  nvme0_peati_shati_if = 282'hf;
assign  nvme1_peati_shati_if = 282'hf;

/*AUTOTIEOFF*/
// Beginning of automatic tieoffs (for this module's unterminated outputs)
wire [7:0]		fabif_cmi0_req0_cred_tdata= 8'h0;
wire [9:0]		fabif_cmi0_req0_cred_tdest= 10'h0;
wire			fabif_cmi0_req0_cred_tuser= 1'h0;
wire			fabif_cmi0_req0_cred_tvalid= 1'h0;
wire			fabif_cmi0_req0_tready	= 1'h0;
wire [7:0]		fabif_cmi0_reqmd0_cred_tdata= 8'h0;
wire [9:0]		fabif_cmi0_reqmd0_cred_tdest= 10'h0;
wire			fabif_cmi0_reqmd0_cred_tuser= 1'h0;
wire			fabif_cmi0_reqmd0_cred_tvalid= 1'h0;
wire			fabif_cmi0_reqmd0_tready= 1'h0;
wire			fabif_cmi0_rwdatacomp_cred_mready= 1'h0;
wire [1023:0]		fabif_cmi0_rwdatacomp_tdata= 1024'h0;
wire [9:0]		fabif_cmi0_rwdatacomp_tdest= 10'h0;
wire [8:0]		fabif_cmi0_rwdatacomp_tid= 9'h0;
wire			fabif_cmi0_rwdatacomp_tlast= 1'h0;
wire [55:0]		fabif_cmi0_rwdatacomp_tuser= 56'h0;
wire			fabif_cmi0_rwdatacomp_tvalid= 1'h0;
wire			fabif_cmi0_rwdatacompmd_cred_mready= 1'h0;
wire [287:0]		fabif_cmi0_rwdatacompmd_tdata= 288'h0;
wire [9:0]		fabif_cmi0_rwdatacompmd_tdest= 10'h0;
wire [8:0]		fabif_cmi0_rwdatacompmd_tid= 9'h0;
wire			fabif_cmi0_rwdatacompmd_tlast= 1'h0;
wire [15:0]		fabif_cmi0_rwdatacompmd_tuser= 16'h0;
wire			fabif_cmi0_rwdatacompmd_tvalid= 1'h0;
wire [7:0]		fabif_cmi1_req0_cred_tdata= 8'h0;
wire [9:0]		fabif_cmi1_req0_cred_tdest= 10'h0;
wire			fabif_cmi1_req0_cred_tuser= 1'h0;
wire			fabif_cmi1_req0_cred_tvalid= 1'h0;
wire			fabif_cmi1_req0_tready	= 1'h0;
wire [7:0]		fabif_cmi1_reqmd0_cred_tdata= 8'h0;
wire [9:0]		fabif_cmi1_reqmd0_cred_tdest= 10'h0;
wire			fabif_cmi1_reqmd0_cred_tuser= 1'h0;
wire			fabif_cmi1_reqmd0_cred_tvalid= 1'h0;
wire			fabif_cmi1_reqmd0_tready= 1'h0;
wire			fabif_cmi1_rwdatacomp_cred_mready= 1'h0;
wire [1023:0]		fabif_cmi1_rwdatacomp_tdata= 1024'h0;
wire [9:0]		fabif_cmi1_rwdatacomp_tdest= 10'h0;
wire [8:0]		fabif_cmi1_rwdatacomp_tid= 9'h0;
wire			fabif_cmi1_rwdatacomp_tlast= 1'h0;
wire [55:0]		fabif_cmi1_rwdatacomp_tuser= 56'h0;
wire			fabif_cmi1_rwdatacomp_tvalid= 1'h0;
wire			fabif_cmi1_rwdatacompmd_cred_mready= 1'h0;
wire [287:0]		fabif_cmi1_rwdatacompmd_tdata= 288'h0;
wire [9:0]		fabif_cmi1_rwdatacompmd_tdest= 10'h0;
wire [8:0]		fabif_cmi1_rwdatacompmd_tid= 9'h0;
wire			fabif_cmi1_rwdatacompmd_tlast= 1'h0;
wire [15:0]		fabif_cmi1_rwdatacompmd_tuser= 16'h0;
wire			fabif_cmi1_rwdatacompmd_tvalid= 1'h0;
wire			fabif_cmi1_wrdone_tready= 1'h0;
wire [7:0]		fabif_pcie2_req0_cred_tdata= 8'h0;
wire [9:0]		fabif_pcie2_req0_cred_tdest= 10'h0;
wire			fabif_pcie2_req0_cred_tuser= 1'h0;
wire			fabif_pcie2_req0_cred_tvalid= 1'h0;
wire			fabif_pcie2_req0_tready	= 1'h0;
wire [7:0]		fabif_pcie2_reqmd0_cred_tdata= 8'h0;
wire [9:0]		fabif_pcie2_reqmd0_cred_tdest= 10'h0;
wire			fabif_pcie2_reqmd0_cred_tuser= 1'h0;
wire			fabif_pcie2_reqmd0_cred_tvalid= 1'h0;
wire			fabif_pcie2_reqmd0_tready= 1'h0;
wire			fabif_pcie2_rwdatacomp_cred_mready= 1'h0;
wire [1023:0]		fabif_pcie2_rwdatacomp_tdata= 1024'h0;
wire [9:0]		fabif_pcie2_rwdatacomp_tdest= 10'h0;
wire [8:0]		fabif_pcie2_rwdatacomp_tid= 9'h0;
wire			fabif_pcie2_rwdatacomp_tlast= 1'h0;
wire [55:0]		fabif_pcie2_rwdatacomp_tuser= 56'h0;
wire			fabif_pcie2_rwdatacomp_tvalid= 1'h0;
wire			fabif_pcie2_rwdatacompmd_cred_mready= 1'h0;
wire [287:0]		fabif_pcie2_rwdatacompmd_tdata= 288'h0;
wire [9:0]		fabif_pcie2_rwdatacompmd_tdest= 10'h0;
wire [8:0]		fabif_pcie2_rwdatacompmd_tid= 9'h0;
wire			fabif_pcie2_rwdatacompmd_tlast= 1'h0;
wire [15:0]		fabif_pcie2_rwdatacompmd_tuser= 16'h0;
wire			fabif_pcie2_rwdatacompmd_tvalid= 1'h0;
wire			fabif_pcie2_wrdone_tready= 1'h0;
wire [7:0]		fabif_pcie3_req0_cred_tdata= 8'h0;
wire [9:0]		fabif_pcie3_req0_cred_tdest= 10'h0;
wire			fabif_pcie3_req0_cred_tuser= 1'h0;
wire			fabif_pcie3_req0_cred_tvalid= 1'h0;
wire			fabif_pcie3_req0_tready	= 1'h0;
wire [7:0]		fabif_pcie3_reqmd0_cred_tdata= 8'h0;
wire [9:0]		fabif_pcie3_reqmd0_cred_tdest= 10'h0;
wire			fabif_pcie3_reqmd0_cred_tuser= 1'h0;
wire			fabif_pcie3_reqmd0_cred_tvalid= 1'h0;
wire			fabif_pcie3_reqmd0_tready= 1'h0;
wire			fabif_pcie3_rwdatacomp_cred_mready= 1'h0;
wire [1023:0]		fabif_pcie3_rwdatacomp_tdata= 1024'h0;
wire [9:0]		fabif_pcie3_rwdatacomp_tdest= 10'h0;
wire [8:0]		fabif_pcie3_rwdatacomp_tid= 9'h0;
wire			fabif_pcie3_rwdatacomp_tlast= 1'h0;
wire [55:0]		fabif_pcie3_rwdatacomp_tuser= 56'h0;
wire			fabif_pcie3_rwdatacomp_tvalid= 1'h0;
wire			fabif_pcie3_rwdatacompmd_cred_mready= 1'h0;
wire [287:0]		fabif_pcie3_rwdatacompmd_tdata= 288'h0;
wire [9:0]		fabif_pcie3_rwdatacompmd_tdest= 10'h0;
wire [8:0]		fabif_pcie3_rwdatacompmd_tid= 9'h0;
wire			fabif_pcie3_rwdatacompmd_tlast= 1'h0;
wire [15:0]		fabif_pcie3_rwdatacompmd_tuser= 16'h0;
wire			fabif_pcie3_rwdatacompmd_tvalid= 1'h0;
wire			fabif_pcie3_wrdone_tready= 1'h0;
wire [367:0]		hbr0_f1_fabric_host_b_a_h2b_m_hbr_in= 368'h0;
wire [1183:0]		hbr0_f2_fabric_host_b_b_h2b_m_hbr_in= 1184'h0;
wire [67:0]		hbr0_f3_fabric_host_b_c_h2b_m_hbr_in= 68'h0;
wire [49:0]		hbr0_f4_fabric_host_b_d_h2b_m_hbr_in= 50'h0;
wire [1:0]		hbr0_f5_fabric_host_b_a_b2h_s_hbr_in= 2'h0;
wire [1:0]		hbr0_f6_fabric_host_b_b_b2h_s_hbr_in= 2'h0;
wire [1:0]		hbr0_f7_fabric_host_b_c_b2h_s_hbr_in= 2'h0;
wire [1:0]		hbr0_f8_fabric_host_b_d_b2h_s_hbr_in= 2'h0;
wire [367:0]		hbr1_f1_fabric_host_b_a_h2b_m_hbr_in= 368'h0;
wire [1183:0]		hbr1_f2_fabric_host_b_b_h2b_m_hbr_in= 1184'h0;
wire [67:0]		hbr1_f3_fabric_host_b_c_h2b_m_hbr_in= 68'h0;
wire [49:0]		hbr1_f4_fabric_host_b_d_h2b_m_hbr_in= 50'h0;
wire [1:0]		hbr1_f5_fabric_host_b_a_b2h_s_hbr_in= 2'h0;
wire [1:0]		hbr1_f6_fabric_host_b_b_b2h_s_hbr_in= 2'h0;
wire [1:0]		hbr1_f7_fabric_host_b_c_b2h_s_hbr_in= 2'h0;
wire [1:0]		hbr1_f8_fabric_host_b_d_b2h_s_hbr_in= 2'h0;
wire [367:0]		hbr2_f1_fabric_host_b_a_h2b_m_hbr_in= 368'h0;
wire [1183:0]		hbr2_f2_fabric_host_b_b_h2b_m_hbr_in= 1184'h0;
wire [67:0]		hbr2_f3_fabric_host_b_c_h2b_m_hbr_in= 68'h0;
wire [49:0]		hbr2_f4_fabric_host_b_d_h2b_m_hbr_in= 50'h0;
wire [1:0]		hbr2_f5_fabric_host_b_a_b2h_s_hbr_in= 2'h0;
wire [1:0]		hbr2_f6_fabric_host_b_b_b2h_s_hbr_in= 2'h0;
wire [1:0]		hbr2_f7_fabric_host_b_c_b2h_s_hbr_in= 2'h0;
wire [1:0]		hbr2_f8_fabric_host_b_d_b2h_s_hbr_in= 2'h0;
wire [129:0]		hif_lce_dbl_tdata	= 130'h0;
wire [2:0]		hif_lce_dbl_tdest	= 3'h0;
wire			hif_lce_dbl_tlast	= 1'h0;
wire [1:0]		hif_lce_dbl_tuser	= 2'h0;
wire [7:0]		hif_lce_req0_cred_tdata	= 8'h0;
wire [5:0]		hif_lce_req0_cred_tdest	= 6'h0;
wire			hif_lce_req0_cred_tvalid= 1'h0;
wire			hif_lce_req0_tready	= 1'h0;
wire [7:0]		hif_lce_reqmd0_cred_tdata= 8'h0;
wire [5:0]		hif_lce_reqmd0_cred_tdest= 6'h0;
wire			hif_lce_reqmd0_cred_tvalid= 1'h0;
wire			hif_lce_reqmd0_tready	= 1'h0;
wire			hif_lce_rwdatacomp_cred_mready= 1'h0;
wire [1023:0]		hif_lce_rwdatacomp_tdata= 1024'h0;
wire [5:0]		hif_lce_rwdatacomp_tdest= 6'h0;
wire [8:0]		hif_lce_rwdatacomp_tid	= 9'h0;
wire			hif_lce_rwdatacomp_tlast= 1'h0;
wire [46:0]		hif_lce_rwdatacomp_tuser= 47'h0;
wire			hif_lce_rwdatacomp_tvalid= 1'h0;
wire			hif_lce_rwdatacompmd_cred_mready= 1'h0;
wire [5:0]		hif_lce_rwdatacompmd_tdata= 6'h0;
wire [5:0]		hif_lce_rwdatacompmd_tdest= 6'h0;
wire [8:0]		hif_lce_rwdatacompmd_tid= 9'h0;
wire			hif_lce_rwdatacompmd_tlast= 1'h0;
wire			hif_lce_rwdatacompmd_tuser= 1'h0;
wire			hif_lce_rwdatacompmd_tvalid= 1'h0;
wire			hif_lce_rwreqmd_tvalid	= 1'h0;
wire [19:0]		hif_lce_wrdone_tdata	= 20'h0;
wire [5:0]		hif_lce_wrdone_tdest	= 6'h0;
wire			hif_lce_wrdone_tlast	= 1'h0;
wire			hif_lce_wrdone_tuser	= 1'h0;
wire			hif_lce_wrdone_tvalid	= 1'h0;
wire			hif_nocss_smh_aary_mbist_diag_done= 1'h0;
wire			hif_nocss_smh_bisr_so	= 1'h0;
wire [1:0]		hif_nocss_smh_dft_spare_out= 2'h0;
wire			hif_nocss_smh_ijtag_nw_so= 1'h0;
wire			hif_nocss_smh_peati_lce_ecc_uncor_err= 1'h0;
wire			hif_nocss_smh_peati_nvme0_ecc_uncor_err= 1'h0;
wire			hif_nocss_smh_peati_nvme1_ecc_uncor_err= 1'h0;
wire [31:0]		hif_nocss_smh_ssn_bus_data_out= 32'h0;
wire			hif_nocss_smh_tap_sel_in= 1'h0;
wire			hif_nocss_smh_tdo	= 1'h0;
wire [129:0]		hif_nvme0_dbl_tdata	= 130'h0;
wire [2:0]		hif_nvme0_dbl_tdest	= 3'h0;
wire			hif_nvme0_dbl_tlast	= 1'h0;
wire [1:0]		hif_nvme0_dbl_tuser	= 2'h0;
wire [7:0]		hif_nvme0_req0_cred_tdata= 8'h0;
wire [5:0]		hif_nvme0_req0_cred_tdest= 6'h0;
wire			hif_nvme0_req0_cred_tvalid= 1'h0;
wire			hif_nvme0_req0_tready	= 1'h0;
wire [7:0]		hif_nvme0_reqmd0_cred_tdata= 8'h0;
wire [5:0]		hif_nvme0_reqmd0_cred_tdest= 6'h0;
wire			hif_nvme0_reqmd0_cred_tvalid= 1'h0;
wire			hif_nvme0_reqmd0_tready	= 1'h0;
wire			hif_nvme0_rwdatacomp_cred_mready= 1'h0;
wire [1023:0]		hif_nvme0_rwdatacomp_tdata= 1024'h0;
wire [5:0]		hif_nvme0_rwdatacomp_tdest= 6'h0;
wire [8:0]		hif_nvme0_rwdatacomp_tid= 9'h0;
wire			hif_nvme0_rwdatacomp_tlast= 1'h0;
wire [46:0]		hif_nvme0_rwdatacomp_tuser= 47'h0;
wire			hif_nvme0_rwdatacomp_tvalid= 1'h0;
wire			hif_nvme0_rwdatacompmd_cred_mready= 1'h0;
wire [5:0]		hif_nvme0_rwdatacompmd_tdata= 6'h0;
wire [5:0]		hif_nvme0_rwdatacompmd_tdest= 6'h0;
wire [8:0]		hif_nvme0_rwdatacompmd_tid= 9'h0;
wire			hif_nvme0_rwdatacompmd_tlast= 1'h0;
wire			hif_nvme0_rwdatacompmd_tuser= 1'h0;
wire			hif_nvme0_rwdatacompmd_tvalid= 1'h0;
wire			hif_nvme0_rwreqmd_tvalid= 1'h0;
wire [19:0]		hif_nvme0_wrdone_tdata	= 20'h0;
wire [5:0]		hif_nvme0_wrdone_tdest	= 6'h0;
wire			hif_nvme0_wrdone_tlast	= 1'h0;
wire			hif_nvme0_wrdone_tuser	= 1'h0;
wire			hif_nvme0_wrdone_tvalid	= 1'h0;
wire [7:0]		hif_nvme1_req0_cred_tdata= 8'h0;
wire [5:0]		hif_nvme1_req0_cred_tdest= 6'h0;
wire			hif_nvme1_req0_cred_tvalid= 1'h0;
wire			hif_nvme1_req0_tready	= 1'h0;
wire [7:0]		hif_nvme1_reqmd0_cred_tdata= 8'h0;
wire [5:0]		hif_nvme1_reqmd0_cred_tdest= 6'h0;
wire			hif_nvme1_reqmd0_cred_tvalid= 1'h0;
wire			hif_nvme1_reqmd0_tready	= 1'h0;
wire			hif_nvme1_rwdatacomp_cred_mready= 1'h0;
wire [1023:0]		hif_nvme1_rwdatacomp_tdata= 1024'h0;
wire [5:0]		hif_nvme1_rwdatacomp_tdest= 6'h0;
wire [8:0]		hif_nvme1_rwdatacomp_tid= 9'h0;
wire			hif_nvme1_rwdatacomp_tlast= 1'h0;
wire [46:0]		hif_nvme1_rwdatacomp_tuser= 47'h0;
wire			hif_nvme1_rwdatacomp_tvalid= 1'h0;
wire			hif_nvme1_rwdatacompmd_cred_mready= 1'h0;
wire [5:0]		hif_nvme1_rwdatacompmd_tdata= 6'h0;
wire [5:0]		hif_nvme1_rwdatacompmd_tdest= 6'h0;
wire [8:0]		hif_nvme1_rwdatacompmd_tid= 9'h0;
wire			hif_nvme1_rwdatacompmd_tlast= 1'h0;
wire			hif_nvme1_rwdatacompmd_tuser= 1'h0;
wire			hif_nvme1_rwdatacompmd_tvalid= 1'h0;
wire [19:0]		hif_nvme1_wrdone_tdata	= 20'h0;
wire [5:0]		hif_nvme1_wrdone_tdest	= 6'h0;
wire			hif_nvme1_wrdone_tlast	= 1'h0;
wire			hif_nvme1_wrdone_tuser	= 1'h0;
wire			hif_nvme1_wrdone_tvalid	= 1'h0;
wire [31:0]		hif_t_smh_fabric_if_prdata= 32'h0;
wire			hif_t_smh_fabric_if_pready= ~1'h0;
wire			hif_t_smh_fabric_if_pslverr= 1'h0;
wire [31:0]		hif_t_smh_fabric_prdata	= 32'h0;
wire			hif_t_smh_fabric_pready	= ~1'h0;
wire			hif_t_smh_fabric_pslverr= 1'h0;
// End of automatics


`ifndef INTEL_SVA_OFF
`ifdef HIF_ASSERT_STUB_INPUTS_NO_TOGGLE
reg unused_xor_d,sva_clk,sva_rst;
wire unused_xor = ^{
    /*AUTOUNUSED*/
    // Beginning of automatic unused inputs
    cmi0_fabif_req0_cred_mready,
    cmi0_fabif_req0_tdata,
    cmi0_fabif_req0_tdest,
    cmi0_fabif_req0_tid,
    cmi0_fabif_req0_tlast,
    cmi0_fabif_req0_tuser,
    cmi0_fabif_req0_tvalid,
    cmi0_fabif_reqmd0_cred_mready,
    cmi0_fabif_reqmd0_tdata,
    cmi0_fabif_reqmd0_tdest,
    cmi0_fabif_reqmd0_tid,
    cmi0_fabif_reqmd0_tlast,
    cmi0_fabif_reqmd0_tuser,
    cmi0_fabif_reqmd0_tvalid,
    cmi0_fabif_rwdatacomp_cred_tdata,
    cmi0_fabif_rwdatacomp_cred_tdest,
    cmi0_fabif_rwdatacomp_cred_tvalid,
    cmi0_fabif_rwdatacomp_tready,
    cmi0_fabif_rwdatacompmd_cred_tdata,
    cmi0_fabif_rwdatacompmd_cred_tdest,
    cmi0_fabif_rwdatacompmd_cred_tvalid,
    cmi0_fabif_rwdatacompmd_tready,
    cmi1_fabif_req0_cred_mready,
    cmi1_fabif_req0_tdata,
    cmi1_fabif_req0_tdest,
    cmi1_fabif_req0_tid,
    cmi1_fabif_req0_tlast,
    cmi1_fabif_req0_tuser,
    cmi1_fabif_req0_tvalid,
    cmi1_fabif_reqmd0_cred_mready,
    cmi1_fabif_reqmd0_tdata,
    cmi1_fabif_reqmd0_tdest,
    cmi1_fabif_reqmd0_tid,
    cmi1_fabif_reqmd0_tlast,
    cmi1_fabif_reqmd0_tuser,
    cmi1_fabif_reqmd0_tvalid,
    cmi1_fabif_rwdatacomp_cred_tdata,
    cmi1_fabif_rwdatacomp_cred_tdest,
    cmi1_fabif_rwdatacomp_cred_tvalid,
    cmi1_fabif_rwdatacomp_tready,
    cmi1_fabif_rwdatacompmd_cred_tdata,
    cmi1_fabif_rwdatacompmd_cred_tdest,
    cmi1_fabif_rwdatacompmd_cred_tvalid,
    cmi1_fabif_rwdatacompmd_tready,
    cmi1_fabif_wrdone_tdata,
    cmi1_fabif_wrdone_tdest,
    cmi1_fabif_wrdone_tlast,
    cmi1_fabif_wrdone_tuser,
    cmi1_fabif_wrdone_tvalid,
    hbr0_f1_fabric_host_b_a_h2b_s_hbr_out,
    hbr0_f2_fabric_host_b_b_h2b_s_hbr_out,
    hbr0_f3_fabric_host_b_c_h2b_s_hbr_out,
    hbr0_f4_fabric_host_b_d_h2b_s_hbr_out,
    hbr0_f5_fabric_host_b_a_b2h_m_hbr_out,
    hbr0_f6_fabric_host_b_b_b2h_m_hbr_out,
    hbr0_f7_fabric_host_b_c_b2h_m_hbr_out,
    hbr0_f8_fabric_host_b_d_b2h_m_hbr_out,
    hbr1_f1_fabric_host_b_a_h2b_s_hbr_out,
    hbr1_f2_fabric_host_b_b_h2b_s_hbr_out,
    hbr1_f3_fabric_host_b_c_h2b_s_hbr_out,
    hbr1_f4_fabric_host_b_d_h2b_s_hbr_out,
    hbr1_f5_fabric_host_b_a_b2h_m_hbr_out,
    hbr1_f6_fabric_host_b_b_b2h_m_hbr_out,
    hbr1_f7_fabric_host_b_c_b2h_m_hbr_out,
    hbr1_f8_fabric_host_b_d_b2h_m_hbr_out,
    hbr2_f1_fabric_host_b_a_h2b_s_hbr_out,
    hbr2_f2_fabric_host_b_b_h2b_s_hbr_out,
    hbr2_f3_fabric_host_b_c_h2b_s_hbr_out,
    hbr2_f4_fabric_host_b_d_h2b_s_hbr_out,
    hbr2_f5_fabric_host_b_a_b2h_m_hbr_out,
    hbr2_f6_fabric_host_b_b_b2h_m_hbr_out,
    hbr2_f7_fabric_host_b_c_b2h_m_hbr_out,
    hbr2_f8_fabric_host_b_d_b2h_m_hbr_out,
    hif_nocss_smh_bisr_reset,
    hif_nocss_smh_bisr_shift_en,
    hif_nocss_smh_bisr_si,
    hif_nocss_smh_dft_spare_in,
    hif_nocss_smh_fdfx_debug_capabilities_enabling,
    hif_nocss_smh_fdfx_debug_capabilities_enabling_valid,
    hif_nocss_smh_fdfx_early_boot_debug_exit,
    hif_nocss_smh_fdfx_policy_update,
    hif_nocss_smh_fdfx_pwrgood,
    hif_nocss_smh_fdfx_security_policy,
    hif_nocss_smh_ijtag_nw_capture,
    hif_nocss_smh_ijtag_nw_reset_b,
    hif_nocss_smh_ijtag_nw_select,
    hif_nocss_smh_ijtag_nw_shift,
    hif_nocss_smh_ijtag_nw_si,
    hif_nocss_smh_ijtag_nw_update,
    hif_nocss_smh_nw_mode,
    hif_nocss_smh_shift_ir_dr,
    hif_nocss_smh_tck,
    hif_nocss_smh_tdi,
    hif_nocss_smh_tms,
    hif_nocss_smh_tms_park_value,
    hif_nocss_smh_trst,
    hif_t_smh_fabric_if_paddr,
    hif_t_smh_fabric_if_penable,
    hif_t_smh_fabric_if_pprot,
    hif_t_smh_fabric_if_psel,
    hif_t_smh_fabric_if_pstrb,
    hif_t_smh_fabric_if_pwdata,
    hif_t_smh_fabric_if_pwrite,
    hif_t_smh_fabric_paddr,
    hif_t_smh_fabric_penable,
    hif_t_smh_fabric_pprot,
    hif_t_smh_fabric_psel,
    hif_t_smh_fabric_pstrb,
    hif_t_smh_fabric_pwdata,
    hif_t_smh_fabric_pwrite,
    lce_hif_dbl_tready,
    lce_hif_req0_cred_mready,
    lce_hif_req0_tdata,
    lce_hif_req0_tdest,
    lce_hif_req0_tid,
    lce_hif_req0_tlast,
    lce_hif_req0_tuser,
    lce_hif_req0_tvalid,
    lce_hif_reqmd0_cred_mready,
    lce_hif_reqmd0_tdata,
    lce_hif_reqmd0_tdest,
    lce_hif_reqmd0_tid,
    lce_hif_reqmd0_tlast,
    lce_hif_reqmd0_tuser,
    lce_hif_reqmd0_tvalid,
    lce_hif_rwdatacomp_cred_tdata,
    lce_hif_rwdatacomp_cred_tdest,
    lce_hif_rwdatacomp_cred_tvalid,
    lce_hif_rwdatacompmd_cred_tdata,
    lce_hif_rwdatacompmd_cred_tdest,
    lce_hif_rwdatacompmd_cred_tvalid,
    lce_hif_wrdone_tready,
    nvme0_hif_dbl_tready,
    nvme0_hif_req0_cred_mready,
    nvme0_hif_req0_tdata,
    nvme0_hif_req0_tdest,
    nvme0_hif_req0_tid,
    nvme0_hif_req0_tlast,
    nvme0_hif_req0_tuser,
    nvme0_hif_req0_tvalid,
    nvme0_hif_reqmd0_cred_mready,
    nvme0_hif_reqmd0_tdata,
    nvme0_hif_reqmd0_tdest,
    nvme0_hif_reqmd0_tid,
    nvme0_hif_reqmd0_tlast,
    nvme0_hif_reqmd0_tuser,
    nvme0_hif_reqmd0_tvalid,
    nvme0_hif_rwdatacomp_cred_tdata,
    nvme0_hif_rwdatacomp_cred_tdest,
    nvme0_hif_rwdatacomp_cred_tvalid,
    nvme0_hif_rwdatacompmd_cred_tdata,
    nvme0_hif_rwdatacompmd_cred_tdest,
    nvme0_hif_rwdatacompmd_cred_tvalid,
    nvme0_hif_wrdone_tready,
    nvme1_hif_req0_cred_mready,
    nvme1_hif_req0_tdata,
    nvme1_hif_req0_tdest,
    nvme1_hif_req0_tid,
    nvme1_hif_req0_tlast,
    nvme1_hif_req0_tuser,
    nvme1_hif_req0_tvalid,
    nvme1_hif_reqmd0_cred_mready,
    nvme1_hif_reqmd0_tdata,
    nvme1_hif_reqmd0_tdest,
    nvme1_hif_reqmd0_tid,
    nvme1_hif_reqmd0_tlast,
    nvme1_hif_reqmd0_tuser,
    nvme1_hif_reqmd0_tvalid,
    nvme1_hif_rwdatacomp_cred_tdata,
    nvme1_hif_rwdatacomp_cred_tdest,
    nvme1_hif_rwdatacomp_cred_tvalid,
    nvme1_hif_rwdatacompmd_cred_tdata,
    nvme1_hif_rwdatacompmd_cred_tdest,
    nvme1_hif_rwdatacompmd_cred_tvalid,
    nvme1_hif_wrdone_tready,
    pcie2_fabif_req0_cred_mready,
    pcie2_fabif_req0_tdata,
    pcie2_fabif_req0_tdest,
    pcie2_fabif_req0_tid,
    pcie2_fabif_req0_tlast,
    pcie2_fabif_req0_tuser,
    pcie2_fabif_req0_tvalid,
    pcie2_fabif_reqmd0_cred_mready,
    pcie2_fabif_reqmd0_tdata,
    pcie2_fabif_reqmd0_tdest,
    pcie2_fabif_reqmd0_tid,
    pcie2_fabif_reqmd0_tlast,
    pcie2_fabif_reqmd0_tuser,
    pcie2_fabif_reqmd0_tvalid,
    pcie2_fabif_rwdatacomp_cred_tdata,
    pcie2_fabif_rwdatacomp_cred_tdest,
    pcie2_fabif_rwdatacomp_cred_tvalid,
    pcie2_fabif_rwdatacomp_tready,
    pcie2_fabif_rwdatacompmd_cred_tdata,
    pcie2_fabif_rwdatacompmd_cred_tdest,
    pcie2_fabif_rwdatacompmd_cred_tvalid,
    pcie2_fabif_rwdatacompmd_tready,
    pcie2_fabif_wrdone_tdata,
    pcie2_fabif_wrdone_tdest,
    pcie2_fabif_wrdone_tlast,
    pcie2_fabif_wrdone_tuser,
    pcie2_fabif_wrdone_tvalid,
    pcie3_fabif_req0_cred_mready,
    pcie3_fabif_req0_tdata,
    pcie3_fabif_req0_tdest,
    pcie3_fabif_req0_tid,
    pcie3_fabif_req0_tlast,
    pcie3_fabif_req0_tuser,
    pcie3_fabif_req0_tvalid,
    pcie3_fabif_reqmd0_cred_mready,
    pcie3_fabif_reqmd0_tdata,
    pcie3_fabif_reqmd0_tdest,
    pcie3_fabif_reqmd0_tid,
    pcie3_fabif_reqmd0_tlast,
    pcie3_fabif_reqmd0_tuser,
    pcie3_fabif_reqmd0_tvalid,
    pcie3_fabif_rwdatacomp_cred_tdata,
    pcie3_fabif_rwdatacomp_cred_tdest,
    pcie3_fabif_rwdatacomp_cred_tvalid,
    pcie3_fabif_rwdatacomp_tready,
    pcie3_fabif_rwdatacompmd_cred_tdata,
    pcie3_fabif_rwdatacompmd_cred_tdest,
    pcie3_fabif_rwdatacompmd_cred_tvalid,
    pcie3_fabif_rwdatacompmd_tready,
    pcie3_fabif_wrdone_tdata,
    pcie3_fabif_wrdone_tdest,
    pcie3_fabif_wrdone_tlast,
    pcie3_fabif_wrdone_tuser,
    pcie3_fabif_wrdone_tvalid,
    ras_dis_stop_r,
    shati_ecc_err_r,
    shati_lce_peati_if,
    shati_nvme0_peati_if,
    shati_nvme1_peati_if,
    // End of automatics
};

initial sva_clk = 1'b0;
initial begin
    sva_rst = 1'b0;
    #10ns;
    sva_rst = 1'b1;
end

always #1ns sva_clk = ~sva_clk;

always @(posedge sva_clk) unused_xor_d <= unused_xor;

`ASSERTS_FORBIDDEN(hif_stub_inputs_no_toggle, (unused_xor_d !== unused_xor) , sva_clk, ~sva_rst, `ERR_MSG("Stub input toggle"));

`endif//`ifdef HIF_ASSERT_STUB_INPUTS_NO_TOGGLE
`endif//`ifndef INTEL_SVA_OFF

endmodule

// Local Variables:
// verilog-library-files:("/nfs/site/disks/nhdk.zsc7.mmg800.ipr.205/hif_nocss/hif_nocss_r15_pre_dft-mmg800-a0-25ww21a-drop.0/src/collage/dft/hif_nocss_smh_top.sv")
// end:

