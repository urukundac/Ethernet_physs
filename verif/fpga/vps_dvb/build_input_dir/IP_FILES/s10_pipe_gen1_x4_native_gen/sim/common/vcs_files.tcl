
namespace eval s10_pipe_gen1_x4_native_gen {
  proc get_memory_files {QSYS_SIMDIR} {
    set memory_files [list]
    return $memory_files
  }
  
  proc get_common_design_files {QSYS_SIMDIR} {
    set design_files [dict create]
    dict set design_files "altera_common_sv_packages::altera_xcvr_native_s10_functions_h" "$QSYS_SIMDIR/../altera_xcvr_native_s10_htile_1921/sim/altera_xcvr_native_s10_functions_h.sv"
    return $design_files
  }
  
  proc get_design_files {QSYS_SIMDIR} {
    set design_files [dict create]
    dict set design_files "alt_xcvr_arbiter.sv"                                                      "$QSYS_SIMDIR/../altera_xcvr_native_s10_htile_1921/sim/alt_xcvr_arbiter.sv"                                                     
    dict set design_files "altera_std_synchronizer_nocut.v"                                          "$QSYS_SIMDIR/../altera_xcvr_native_s10_htile_1921/sim/altera_std_synchronizer_nocut.v"                                         
    dict set design_files "alt_xcvr_resync_std.sv"                                                   "$QSYS_SIMDIR/../altera_xcvr_native_s10_htile_1921/sim/alt_xcvr_resync_std.sv"                                                  
    dict set design_files "alt_xcvr_reset_counter_s10.sv"                                            "$QSYS_SIMDIR/../altera_xcvr_native_s10_htile_1921/sim/alt_xcvr_reset_counter_s10.sv"                                           
    dict set design_files "s10_avmm_h.sv"                                                            "$QSYS_SIMDIR/../altera_xcvr_native_s10_htile_1921/sim/s10_avmm_h.sv"                                                           
    dict set design_files "alt_xcvr_native_avmm_csr.sv"                                              "$QSYS_SIMDIR/../altera_xcvr_native_s10_htile_1921/sim/alt_xcvr_native_avmm_csr.sv"                                             
    dict set design_files "alt_xcvr_native_prbs_accum.sv"                                            "$QSYS_SIMDIR/../altera_xcvr_native_s10_htile_1921/sim/alt_xcvr_native_prbs_accum.sv"                                           
    dict set design_files "alt_xcvr_native_odi_accel.sv"                                             "$QSYS_SIMDIR/../altera_xcvr_native_s10_htile_1921/sim/alt_xcvr_native_odi_accel.sv"                                            
    dict set design_files "alt_xcvr_native_rcfg_arb.sv"                                              "$QSYS_SIMDIR/../altera_xcvr_native_s10_htile_1921/sim/alt_xcvr_native_rcfg_arb.sv"                                             
    dict set design_files "alt_xcvr_early_spd_chng_s10_htile.sv"                                     "$QSYS_SIMDIR/../altera_xcvr_native_s10_htile_1921/sim/alt_xcvr_early_spd_chng_s10_htile.sv"                                    
    dict set design_files "alt_xcvr_native_anlg_reset_seq.sv"                                        "$QSYS_SIMDIR/../altera_xcvr_native_s10_htile_1921/sim/alt_xcvr_native_anlg_reset_seq.sv"                                       
    dict set design_files "alt_xcvr_native_dig_reset_seq.sv"                                         "$QSYS_SIMDIR/../altera_xcvr_native_s10_htile_1921/sim/alt_xcvr_native_dig_reset_seq.sv"                                        
    dict set design_files "alt_xcvr_native_reset_seq.sv"                                             "$QSYS_SIMDIR/../altera_xcvr_native_s10_htile_1921/sim/alt_xcvr_native_reset_seq.sv"                                            
    dict set design_files "alt_xcvr_native_anlg_reset_seq_wrapper.sv"                                "$QSYS_SIMDIR/../altera_xcvr_native_s10_htile_1921/sim/alt_xcvr_native_anlg_reset_seq_wrapper.sv"                               
    dict set design_files "alt_xcvr_native_re_cal_chnl.v"                                            "$QSYS_SIMDIR/../altera_xcvr_native_s10_htile_1921/sim/alt_xcvr_native_re_cal_chnl.v"                                           
    dict set design_files "alt_xcvr_pcie_rx_eios_prot.sv"                                            "$QSYS_SIMDIR/../altera_xcvr_native_s10_htile_1921/sim/alt_xcvr_pcie_rx_eios_prot.sv"                                           
    dict set design_files "alt_xcvr_native_rx_maib_wa.sv"                                            "$QSYS_SIMDIR/../altera_xcvr_native_s10_htile_1921/sim/alt_xcvr_native_rx_maib_wa.sv"                                           
    dict set design_files "s10_pipe_gen1_x4_native_gen_altera_xcvr_native_s10_htile_1921_ia6ibfq.sv" "$QSYS_SIMDIR/../altera_xcvr_native_s10_htile_1921/sim/s10_pipe_gen1_x4_native_gen_altera_xcvr_native_s10_htile_1921_ia6ibfq.sv"
    dict set design_files "alt_xcvr_native_rcfg_opt_logic_ia6ibfq.sv"                                "$QSYS_SIMDIR/../altera_xcvr_native_s10_htile_1921/sim/alt_xcvr_native_rcfg_opt_logic_ia6ibfq.sv"                               
    dict set design_files "s10_pipe_gen1_x4_native_gen.v"                                            "$QSYS_SIMDIR/s10_pipe_gen1_x4_native_gen.v"                                                                                    
    return $design_files
  }
  
  proc get_elab_options {SIMULATOR_TOOL_BITNESS} {
    set ELAB_OPTIONS ""
    if ![ string match "bit_64" $SIMULATOR_TOOL_BITNESS ] {
    } else {
    }
    return $ELAB_OPTIONS
  }
  
  
  proc get_sim_options {SIMULATOR_TOOL_BITNESS} {
    set SIM_OPTIONS ""
    if ![ string match "bit_64" $SIMULATOR_TOOL_BITNESS ] {
    } else {
    }
    return $SIM_OPTIONS
  }
  
  
  proc get_env_variables {SIMULATOR_TOOL_BITNESS} {
    set ENV_VARIABLES [dict create]
    set LD_LIBRARY_PATH [dict create]
    dict set ENV_VARIABLES "LD_LIBRARY_PATH" $LD_LIBRARY_PATH
    if ![ string match "bit_64" $SIMULATOR_TOOL_BITNESS ] {
    } else {
    }
    return $ENV_VARIABLES
  }
  
  
}
