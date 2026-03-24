
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
    dict set design_files "altera_common_sv_packages::altera_xcvr_native_s10_functions_h" "vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"[normalize_path "$QSYS_SIMDIR/../altera_xcvr_native_s10_htile_1921/sim/altera_xcvr_native_s10_functions_h.sv"]\"  -work altera_common_sv_packages"
    return $design_files
  }
  
  proc get_design_files {USER_DEFINED_COMPILE_OPTIONS USER_DEFINED_VERILOG_COMPILE_OPTIONS USER_DEFINED_VHDL_COMPILE_OPTIONS QSYS_SIMDIR} {
    set design_files [list]
    lappend design_files "vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"[normalize_path "$QSYS_SIMDIR/../altera_xcvr_native_s10_htile_1921/sim/alt_xcvr_arbiter.sv"]\" -l altera_common_sv_packages -work altera_xcvr_native_s10_htile_1921"                                                     
    lappend design_files "vlog -v2k5 $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"[normalize_path "$QSYS_SIMDIR/../altera_xcvr_native_s10_htile_1921/sim/altera_std_synchronizer_nocut.v"]\"  -work altera_xcvr_native_s10_htile_1921"                                                                
    lappend design_files "vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"[normalize_path "$QSYS_SIMDIR/../altera_xcvr_native_s10_htile_1921/sim/alt_xcvr_resync_std.sv"]\" -l altera_common_sv_packages -work altera_xcvr_native_s10_htile_1921"                                                  
    lappend design_files "vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"[normalize_path "$QSYS_SIMDIR/../altera_xcvr_native_s10_htile_1921/sim/alt_xcvr_reset_counter_s10.sv"]\" -l altera_common_sv_packages -work altera_xcvr_native_s10_htile_1921"                                           
    lappend design_files "vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"[normalize_path "$QSYS_SIMDIR/../altera_xcvr_native_s10_htile_1921/sim/s10_avmm_h.sv"]\" -l altera_common_sv_packages -work altera_xcvr_native_s10_htile_1921"                                                           
    lappend design_files "vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"[normalize_path "$QSYS_SIMDIR/../altera_xcvr_native_s10_htile_1921/sim/alt_xcvr_native_avmm_csr.sv"]\" -l altera_common_sv_packages -work altera_xcvr_native_s10_htile_1921"                                             
    lappend design_files "vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"[normalize_path "$QSYS_SIMDIR/../altera_xcvr_native_s10_htile_1921/sim/alt_xcvr_native_prbs_accum.sv"]\" -l altera_common_sv_packages -work altera_xcvr_native_s10_htile_1921"                                           
    lappend design_files "vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"[normalize_path "$QSYS_SIMDIR/../altera_xcvr_native_s10_htile_1921/sim/alt_xcvr_native_odi_accel.sv"]\" -l altera_common_sv_packages -work altera_xcvr_native_s10_htile_1921"                                            
    lappend design_files "vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"[normalize_path "$QSYS_SIMDIR/../altera_xcvr_native_s10_htile_1921/sim/alt_xcvr_native_rcfg_arb.sv"]\" -l altera_common_sv_packages -work altera_xcvr_native_s10_htile_1921"                                             
    lappend design_files "vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"[normalize_path "$QSYS_SIMDIR/../altera_xcvr_native_s10_htile_1921/sim/alt_xcvr_early_spd_chng_s10_htile.sv"]\" -l altera_common_sv_packages -work altera_xcvr_native_s10_htile_1921"                                    
    lappend design_files "vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"[normalize_path "$QSYS_SIMDIR/../altera_xcvr_native_s10_htile_1921/sim/alt_xcvr_native_anlg_reset_seq.sv"]\" -l altera_common_sv_packages -work altera_xcvr_native_s10_htile_1921"                                       
    lappend design_files "vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"[normalize_path "$QSYS_SIMDIR/../altera_xcvr_native_s10_htile_1921/sim/alt_xcvr_native_dig_reset_seq.sv"]\" -l altera_common_sv_packages -work altera_xcvr_native_s10_htile_1921"                                        
    lappend design_files "vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"[normalize_path "$QSYS_SIMDIR/../altera_xcvr_native_s10_htile_1921/sim/alt_xcvr_native_reset_seq.sv"]\" -l altera_common_sv_packages -work altera_xcvr_native_s10_htile_1921"                                            
    lappend design_files "vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"[normalize_path "$QSYS_SIMDIR/../altera_xcvr_native_s10_htile_1921/sim/alt_xcvr_native_anlg_reset_seq_wrapper.sv"]\" -l altera_common_sv_packages -work altera_xcvr_native_s10_htile_1921"                               
    lappend design_files "vlog -v2k5 $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"[normalize_path "$QSYS_SIMDIR/../altera_xcvr_native_s10_htile_1921/sim/alt_xcvr_native_re_cal_chnl.v"]\"  -work altera_xcvr_native_s10_htile_1921"                                                                  
    lappend design_files "vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"[normalize_path "$QSYS_SIMDIR/../altera_xcvr_native_s10_htile_1921/sim/alt_xcvr_pcie_rx_eios_prot.sv"]\" -l altera_common_sv_packages -work altera_xcvr_native_s10_htile_1921"                                           
    lappend design_files "vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"[normalize_path "$QSYS_SIMDIR/../altera_xcvr_native_s10_htile_1921/sim/alt_xcvr_native_rx_maib_wa.sv"]\" -l altera_common_sv_packages -work altera_xcvr_native_s10_htile_1921"                                           
    lappend design_files "vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"[normalize_path "$QSYS_SIMDIR/../altera_xcvr_native_s10_htile_1921/sim/s10_pipe_gen1_x4_native_gen_altera_xcvr_native_s10_htile_1921_ia6ibfq.sv"]\" -l altera_common_sv_packages -work altera_xcvr_native_s10_htile_1921"
    lappend design_files "vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"[normalize_path "$QSYS_SIMDIR/../altera_xcvr_native_s10_htile_1921/sim/alt_xcvr_native_rcfg_opt_logic_ia6ibfq.sv"]\" -l altera_common_sv_packages -work altera_xcvr_native_s10_htile_1921"                               
    lappend design_files "vlog -v2k5 $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"[normalize_path "$QSYS_SIMDIR/s10_pipe_gen1_x4_native_gen.v"]\"  -work s10_pipe_gen1_x4_native_gen"                                                                                                                 
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
  
  
  proc normalize_path {FILEPATH} {
      if {[catch { package require fileutil } err]} { 
          return $FILEPATH 
      } 
      set path [fileutil::lexnormalize [file join [pwd] $FILEPATH]]  
      if {[file pathtype $FILEPATH] eq "relative"} { 
          set path [fileutil::relative [pwd] $path] 
      } 
      return $path 
  } 
}
