
namespace eval s10_serdes_Ltile_with8b10b_tbi_eth {
  proc get_design_libraries {} {
    set libraries [dict create]
    dict set libraries altera_common_sv_packages          1
    dict set libraries altera_xcvr_native_s10_htile_1930  1
    dict set libraries s10_serdes_Ltile_with8b10b_tbi_eth 1
    return $libraries
  }
  
  proc get_memory_files {QSYS_SIMDIR} {
    set memory_files [list]
    return $memory_files
  }
  
  proc get_common_design_files {USER_DEFINED_COMPILE_OPTIONS USER_DEFINED_VERILOG_COMPILE_OPTIONS USER_DEFINED_VHDL_COMPILE_OPTIONS QSYS_SIMDIR} {
    set design_files [dict create]
    dict set design_files "altera_common_sv_packages::altera_xcvr_native_s10_functions_h" "xmvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"$QSYS_SIMDIR/../altera_xcvr_native_s10_htile_1930/sim/altera_xcvr_native_s10_functions_h.sv\"  -work altera_common_sv_packages -cdslib  ./cds_libs/altera_common_sv_packages.cds.lib"
    return $design_files
  }
  
  proc get_design_files {USER_DEFINED_COMPILE_OPTIONS USER_DEFINED_VERILOG_COMPILE_OPTIONS USER_DEFINED_VHDL_COMPILE_OPTIONS QSYS_SIMDIR} {
    set design_files [list]
    lappend design_files "xmvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"$QSYS_SIMDIR/../altera_xcvr_native_s10_htile_1930/sim/alt_xcvr_arbiter.sv\"  -work altera_xcvr_native_s10_htile_1930 -cdslib  ./cds_libs/altera_xcvr_native_s10_htile_1930.cds.lib"                                                            
    lappend design_files "xmvlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"$QSYS_SIMDIR/../altera_xcvr_native_s10_htile_1930/sim/altera_std_synchronizer_nocut.v\"  -work altera_xcvr_native_s10_htile_1930 -cdslib  ./cds_libs/altera_xcvr_native_s10_htile_1930.cds.lib"                                                    
    lappend design_files "xmvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"$QSYS_SIMDIR/../altera_xcvr_native_s10_htile_1930/sim/alt_xcvr_resync_std.sv\"  -work altera_xcvr_native_s10_htile_1930 -cdslib  ./cds_libs/altera_xcvr_native_s10_htile_1930.cds.lib"                                                         
    lappend design_files "xmvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"$QSYS_SIMDIR/../altera_xcvr_native_s10_htile_1930/sim/alt_xcvr_reset_counter_s10.sv\"  -work altera_xcvr_native_s10_htile_1930 -cdslib  ./cds_libs/altera_xcvr_native_s10_htile_1930.cds.lib"                                                  
    lappend design_files "xmvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"$QSYS_SIMDIR/../altera_xcvr_native_s10_htile_1930/sim/s10_avmm_h.sv\"  -work altera_xcvr_native_s10_htile_1930 -cdslib  ./cds_libs/altera_xcvr_native_s10_htile_1930.cds.lib"                                                                  
    lappend design_files "xmvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"$QSYS_SIMDIR/../altera_xcvr_native_s10_htile_1930/sim/alt_xcvr_native_avmm_csr.sv\"  -work altera_xcvr_native_s10_htile_1930 -cdslib  ./cds_libs/altera_xcvr_native_s10_htile_1930.cds.lib"                                                    
    lappend design_files "xmvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"$QSYS_SIMDIR/../altera_xcvr_native_s10_htile_1930/sim/alt_xcvr_native_prbs_accum.sv\"  -work altera_xcvr_native_s10_htile_1930 -cdslib  ./cds_libs/altera_xcvr_native_s10_htile_1930.cds.lib"                                                  
    lappend design_files "xmvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"$QSYS_SIMDIR/../altera_xcvr_native_s10_htile_1930/sim/alt_xcvr_native_odi_accel.sv\"  -work altera_xcvr_native_s10_htile_1930 -cdslib  ./cds_libs/altera_xcvr_native_s10_htile_1930.cds.lib"                                                   
    lappend design_files "xmvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"$QSYS_SIMDIR/../altera_xcvr_native_s10_htile_1930/sim/alt_xcvr_native_rcfg_arb.sv\"  -work altera_xcvr_native_s10_htile_1930 -cdslib  ./cds_libs/altera_xcvr_native_s10_htile_1930.cds.lib"                                                    
    lappend design_files "xmvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"$QSYS_SIMDIR/../altera_xcvr_native_s10_htile_1930/sim/alt_xcvr_early_spd_chng_s10_htile.sv\"  -work altera_xcvr_native_s10_htile_1930 -cdslib  ./cds_libs/altera_xcvr_native_s10_htile_1930.cds.lib"                                           
    lappend design_files "xmvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"$QSYS_SIMDIR/../altera_xcvr_native_s10_htile_1930/sim/alt_xcvr_native_anlg_reset_seq.sv\"  -work altera_xcvr_native_s10_htile_1930 -cdslib  ./cds_libs/altera_xcvr_native_s10_htile_1930.cds.lib"                                              
    lappend design_files "xmvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"$QSYS_SIMDIR/../altera_xcvr_native_s10_htile_1930/sim/alt_xcvr_native_dig_reset_seq.sv\"  -work altera_xcvr_native_s10_htile_1930 -cdslib  ./cds_libs/altera_xcvr_native_s10_htile_1930.cds.lib"                                               
    lappend design_files "xmvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"$QSYS_SIMDIR/../altera_xcvr_native_s10_htile_1930/sim/alt_xcvr_native_reset_seq.sv\"  -work altera_xcvr_native_s10_htile_1930 -cdslib  ./cds_libs/altera_xcvr_native_s10_htile_1930.cds.lib"                                                   
    lappend design_files "xmvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"$QSYS_SIMDIR/../altera_xcvr_native_s10_htile_1930/sim/alt_xcvr_native_anlg_reset_seq_wrapper.sv\"  -work altera_xcvr_native_s10_htile_1930 -cdslib  ./cds_libs/altera_xcvr_native_s10_htile_1930.cds.lib"                                      
    lappend design_files "xmvlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"$QSYS_SIMDIR/../altera_xcvr_native_s10_htile_1930/sim/alt_xcvr_native_re_cal_chnl.v\"  -work altera_xcvr_native_s10_htile_1930 -cdslib  ./cds_libs/altera_xcvr_native_s10_htile_1930.cds.lib"                                                      
    lappend design_files "xmvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"$QSYS_SIMDIR/../altera_xcvr_native_s10_htile_1930/sim/alt_xcvr_pcie_rx_eios_prot.sv\"  -work altera_xcvr_native_s10_htile_1930 -cdslib  ./cds_libs/altera_xcvr_native_s10_htile_1930.cds.lib"                                                  
    lappend design_files "xmvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"$QSYS_SIMDIR/../altera_xcvr_native_s10_htile_1930/sim/alt_xcvr_native_rx_maib_wa.sv\"  -work altera_xcvr_native_s10_htile_1930 -cdslib  ./cds_libs/altera_xcvr_native_s10_htile_1930.cds.lib"                                                  
    lappend design_files "xmvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"$QSYS_SIMDIR/../altera_xcvr_native_s10_htile_1930/sim/s10_serdes_Ltile_with8b10b_tbi_eth_altera_xcvr_native_s10_htile_1930_xmzqn2a.sv\"  -work altera_xcvr_native_s10_htile_1930 -cdslib  ./cds_libs/altera_xcvr_native_s10_htile_1930.cds.lib"
    lappend design_files "xmvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"$QSYS_SIMDIR/../altera_xcvr_native_s10_htile_1930/sim/alt_xcvr_native_rcfg_opt_logic_xmzqn2a.sv\"  -work altera_xcvr_native_s10_htile_1930 -cdslib  ./cds_libs/altera_xcvr_native_s10_htile_1930.cds.lib"                                      
    lappend design_files "xmvlog -compcnfg $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"$QSYS_SIMDIR/s10_serdes_Ltile_with8b10b_tbi_eth.v\"  -work s10_serdes_Ltile_with8b10b_tbi_eth"                                                                                                                                           
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
  
  
  proc get_dpi_libraries {QSYS_SIMDIR} {
    set libraries [dict create]
    
    return $libraries
  }
  
}
