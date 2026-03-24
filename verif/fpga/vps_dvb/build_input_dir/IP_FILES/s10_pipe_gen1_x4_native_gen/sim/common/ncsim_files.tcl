
namespace eval s10_pipe_gen1_x4_native_gen {
  proc get_design_libraries {} {
    set libraries [dict create]
    dict set libraries altera_common_sv_packages         1
    dict set libraries altera_xcvr_native_s10_htile_1921 1
    dict set libraries s10_pipe_gen1_x4_native_gen       1
    return $libraries
  }
  
  proc get_memory_files {QSYS_SIMDIR} {
    set memory_files [list]
    return $memory_files
  }
  
  proc get_common_design_files {USER_DEFINED_COMPILE_OPTIONS USER_DEFINED_VERILOG_COMPILE_OPTIONS USER_DEFINED_VHDL_COMPILE_OPTIONS QSYS_SIMDIR} {
    set design_files [dict create]
    dict set design_files "altera_common_sv_packages::altera_xcvr_native_s10_functions_h" "ncvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"$QSYS_SIMDIR/../altera_xcvr_native_s10_htile_1921/sim/altera_xcvr_native_s10_functions_h.sv\"  -work altera_common_sv_packages -cdslib  ./cds_libs/altera_common_sv_packages.cds.lib"
    return $design_files
  }
  
  proc get_design_files {USER_DEFINED_COMPILE_OPTIONS USER_DEFINED_VERILOG_COMPILE_OPTIONS USER_DEFINED_VHDL_COMPILE_OPTIONS QSYS_SIMDIR} {
    set design_files [list]
    lappend design_files "ncvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"$QSYS_SIMDIR/../altera_xcvr_native_s10_htile_1921/sim/alt_xcvr_arbiter.sv\"  -work altera_xcvr_native_s10_htile_1921 -cdslib  ./cds_libs/altera_xcvr_native_s10_htile_1921.cds.lib"                                                     
    lappend design_files "ncvlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"$QSYS_SIMDIR/../altera_xcvr_native_s10_htile_1921/sim/altera_std_synchronizer_nocut.v\"  -work altera_xcvr_native_s10_htile_1921 -cdslib  ./cds_libs/altera_xcvr_native_s10_htile_1921.cds.lib"                                             
    lappend design_files "ncvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"$QSYS_SIMDIR/../altera_xcvr_native_s10_htile_1921/sim/alt_xcvr_resync_std.sv\"  -work altera_xcvr_native_s10_htile_1921 -cdslib  ./cds_libs/altera_xcvr_native_s10_htile_1921.cds.lib"                                                  
    lappend design_files "ncvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"$QSYS_SIMDIR/../altera_xcvr_native_s10_htile_1921/sim/alt_xcvr_reset_counter_s10.sv\"  -work altera_xcvr_native_s10_htile_1921 -cdslib  ./cds_libs/altera_xcvr_native_s10_htile_1921.cds.lib"                                           
    lappend design_files "ncvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"$QSYS_SIMDIR/../altera_xcvr_native_s10_htile_1921/sim/s10_avmm_h.sv\"  -work altera_xcvr_native_s10_htile_1921 -cdslib  ./cds_libs/altera_xcvr_native_s10_htile_1921.cds.lib"                                                           
    lappend design_files "ncvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"$QSYS_SIMDIR/../altera_xcvr_native_s10_htile_1921/sim/alt_xcvr_native_avmm_csr.sv\"  -work altera_xcvr_native_s10_htile_1921 -cdslib  ./cds_libs/altera_xcvr_native_s10_htile_1921.cds.lib"                                             
    lappend design_files "ncvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"$QSYS_SIMDIR/../altera_xcvr_native_s10_htile_1921/sim/alt_xcvr_native_prbs_accum.sv\"  -work altera_xcvr_native_s10_htile_1921 -cdslib  ./cds_libs/altera_xcvr_native_s10_htile_1921.cds.lib"                                           
    lappend design_files "ncvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"$QSYS_SIMDIR/../altera_xcvr_native_s10_htile_1921/sim/alt_xcvr_native_odi_accel.sv\"  -work altera_xcvr_native_s10_htile_1921 -cdslib  ./cds_libs/altera_xcvr_native_s10_htile_1921.cds.lib"                                            
    lappend design_files "ncvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"$QSYS_SIMDIR/../altera_xcvr_native_s10_htile_1921/sim/alt_xcvr_native_rcfg_arb.sv\"  -work altera_xcvr_native_s10_htile_1921 -cdslib  ./cds_libs/altera_xcvr_native_s10_htile_1921.cds.lib"                                             
    lappend design_files "ncvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"$QSYS_SIMDIR/../altera_xcvr_native_s10_htile_1921/sim/alt_xcvr_early_spd_chng_s10_htile.sv\"  -work altera_xcvr_native_s10_htile_1921 -cdslib  ./cds_libs/altera_xcvr_native_s10_htile_1921.cds.lib"                                    
    lappend design_files "ncvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"$QSYS_SIMDIR/../altera_xcvr_native_s10_htile_1921/sim/alt_xcvr_native_anlg_reset_seq.sv\"  -work altera_xcvr_native_s10_htile_1921 -cdslib  ./cds_libs/altera_xcvr_native_s10_htile_1921.cds.lib"                                       
    lappend design_files "ncvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"$QSYS_SIMDIR/../altera_xcvr_native_s10_htile_1921/sim/alt_xcvr_native_dig_reset_seq.sv\"  -work altera_xcvr_native_s10_htile_1921 -cdslib  ./cds_libs/altera_xcvr_native_s10_htile_1921.cds.lib"                                        
    lappend design_files "ncvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"$QSYS_SIMDIR/../altera_xcvr_native_s10_htile_1921/sim/alt_xcvr_native_reset_seq.sv\"  -work altera_xcvr_native_s10_htile_1921 -cdslib  ./cds_libs/altera_xcvr_native_s10_htile_1921.cds.lib"                                            
    lappend design_files "ncvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"$QSYS_SIMDIR/../altera_xcvr_native_s10_htile_1921/sim/alt_xcvr_native_anlg_reset_seq_wrapper.sv\"  -work altera_xcvr_native_s10_htile_1921 -cdslib  ./cds_libs/altera_xcvr_native_s10_htile_1921.cds.lib"                               
    lappend design_files "ncvlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"$QSYS_SIMDIR/../altera_xcvr_native_s10_htile_1921/sim/alt_xcvr_native_re_cal_chnl.v\"  -work altera_xcvr_native_s10_htile_1921 -cdslib  ./cds_libs/altera_xcvr_native_s10_htile_1921.cds.lib"                                               
    lappend design_files "ncvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"$QSYS_SIMDIR/../altera_xcvr_native_s10_htile_1921/sim/alt_xcvr_pcie_rx_eios_prot.sv\"  -work altera_xcvr_native_s10_htile_1921 -cdslib  ./cds_libs/altera_xcvr_native_s10_htile_1921.cds.lib"                                           
    lappend design_files "ncvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"$QSYS_SIMDIR/../altera_xcvr_native_s10_htile_1921/sim/alt_xcvr_native_rx_maib_wa.sv\"  -work altera_xcvr_native_s10_htile_1921 -cdslib  ./cds_libs/altera_xcvr_native_s10_htile_1921.cds.lib"                                           
    lappend design_files "ncvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"$QSYS_SIMDIR/../altera_xcvr_native_s10_htile_1921/sim/s10_pipe_gen1_x4_native_gen_altera_xcvr_native_s10_htile_1921_ia6ibfq.sv\"  -work altera_xcvr_native_s10_htile_1921 -cdslib  ./cds_libs/altera_xcvr_native_s10_htile_1921.cds.lib"
    lappend design_files "ncvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"$QSYS_SIMDIR/../altera_xcvr_native_s10_htile_1921/sim/alt_xcvr_native_rcfg_opt_logic_ia6ibfq.sv\"  -work altera_xcvr_native_s10_htile_1921 -cdslib  ./cds_libs/altera_xcvr_native_s10_htile_1921.cds.lib"                               
    lappend design_files "ncvlog -compcnfg $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"$QSYS_SIMDIR/s10_pipe_gen1_x4_native_gen.v\"  -work s10_pipe_gen1_x4_native_gen"                                                                                                                                                  
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
