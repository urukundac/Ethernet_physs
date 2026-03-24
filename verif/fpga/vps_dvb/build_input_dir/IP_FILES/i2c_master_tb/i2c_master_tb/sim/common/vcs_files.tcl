source [file join [file dirname [info script]] ./../../../ip/i2c_master_tb/i2c_master_inst_avalon_master_bfm_ip/sim/common/vcs_files.tcl]
source [file join [file dirname [info script]] ./../../../../i2c_master/sim/common/vcs_files.tcl]
source [file join [file dirname [info script]] ./../../../ip/i2c_master_tb/i2c_master_inst_clock_bfm_ip/sim/common/vcs_files.tcl]
source [file join [file dirname [info script]] ./../../../ip/i2c_master_tb/i2c_master_inst_conduit_end_bfm_ip/sim/common/vcs_files.tcl]
source [file join [file dirname [info script]] ./../../../ip/i2c_master_tb/i2c_master_inst_reset_bfm_ip/sim/common/vcs_files.tcl]

namespace eval i2c_master_tb {
  proc get_memory_files {QSYS_SIMDIR} {
    set memory_files [list]
    set memory_files [concat $memory_files [i2c_master_inst_avalon_master_bfm_ip::get_memory_files "$QSYS_SIMDIR/../../ip/i2c_master_tb/i2c_master_inst_avalon_master_bfm_ip/sim/"]]
    set memory_files [concat $memory_files [i2c_master::get_memory_files "$QSYS_SIMDIR/../../../i2c_master/sim/"]]
    set memory_files [concat $memory_files [i2c_master_inst_clock_bfm_ip::get_memory_files "$QSYS_SIMDIR/../../ip/i2c_master_tb/i2c_master_inst_clock_bfm_ip/sim/"]]
    set memory_files [concat $memory_files [i2c_master_inst_conduit_end_bfm_ip::get_memory_files "$QSYS_SIMDIR/../../ip/i2c_master_tb/i2c_master_inst_conduit_end_bfm_ip/sim/"]]
    set memory_files [concat $memory_files [i2c_master_inst_reset_bfm_ip::get_memory_files "$QSYS_SIMDIR/../../ip/i2c_master_tb/i2c_master_inst_reset_bfm_ip/sim/"]]
    return $memory_files
  }
  
  proc get_common_design_files {QSYS_SIMDIR} {
    set design_files [dict create]
    set design_files [dict merge $design_files [i2c_master_inst_avalon_master_bfm_ip::get_common_design_files "$QSYS_SIMDIR/../../ip/i2c_master_tb/i2c_master_inst_avalon_master_bfm_ip/sim/"]]
    set design_files [dict merge $design_files [i2c_master::get_common_design_files "$QSYS_SIMDIR/../../../i2c_master/sim/"]]
    set design_files [dict merge $design_files [i2c_master_inst_clock_bfm_ip::get_common_design_files "$QSYS_SIMDIR/../../ip/i2c_master_tb/i2c_master_inst_clock_bfm_ip/sim/"]]
    set design_files [dict merge $design_files [i2c_master_inst_conduit_end_bfm_ip::get_common_design_files "$QSYS_SIMDIR/../../ip/i2c_master_tb/i2c_master_inst_conduit_end_bfm_ip/sim/"]]
    set design_files [dict merge $design_files [i2c_master_inst_reset_bfm_ip::get_common_design_files "$QSYS_SIMDIR/../../ip/i2c_master_tb/i2c_master_inst_reset_bfm_ip/sim/"]]
    return $design_files
  }
  
  proc get_design_files {QSYS_SIMDIR} {
    set design_files [dict create]
    set design_files [dict merge $design_files [i2c_master_inst_avalon_master_bfm_ip::get_design_files "$QSYS_SIMDIR/../../ip/i2c_master_tb/i2c_master_inst_avalon_master_bfm_ip/sim/"]]
    set design_files [dict merge $design_files [i2c_master::get_design_files "$QSYS_SIMDIR/../../../i2c_master/sim/"]]
    set design_files [dict merge $design_files [i2c_master_inst_clock_bfm_ip::get_design_files "$QSYS_SIMDIR/../../ip/i2c_master_tb/i2c_master_inst_clock_bfm_ip/sim/"]]
    set design_files [dict merge $design_files [i2c_master_inst_conduit_end_bfm_ip::get_design_files "$QSYS_SIMDIR/../../ip/i2c_master_tb/i2c_master_inst_conduit_end_bfm_ip/sim/"]]
    set design_files [dict merge $design_files [i2c_master_inst_reset_bfm_ip::get_design_files "$QSYS_SIMDIR/../../ip/i2c_master_tb/i2c_master_inst_reset_bfm_ip/sim/"]]
    dict set design_files "i2c_master_tb.v" "$QSYS_SIMDIR/i2c_master_tb.v"
    return $design_files
  }
  
  proc get_non_duplicate_elab_option {ELAB_OPTIONS NEW_ELAB_OPTION} {
    set IS_DUPLICATE [string first $NEW_ELAB_OPTION $ELAB_OPTIONS]
    if {$IS_DUPLICATE == -1} {
      return $NEW_ELAB_OPTION
    } else {
      return ""
    }
  }
  
  
  proc get_elab_options {SIMULATOR_TOOL_BITNESS} {
    set ELAB_OPTIONS ""
    append ELAB_OPTIONS [get_non_duplicate_elab_option $ELAB_OPTIONS [i2c_master_inst_avalon_master_bfm_ip::get_elab_options $SIMULATOR_TOOL_BITNESS]]
    append ELAB_OPTIONS [get_non_duplicate_elab_option $ELAB_OPTIONS [i2c_master::get_elab_options $SIMULATOR_TOOL_BITNESS]]
    append ELAB_OPTIONS [get_non_duplicate_elab_option $ELAB_OPTIONS [i2c_master_inst_clock_bfm_ip::get_elab_options $SIMULATOR_TOOL_BITNESS]]
    append ELAB_OPTIONS [get_non_duplicate_elab_option $ELAB_OPTIONS [i2c_master_inst_conduit_end_bfm_ip::get_elab_options $SIMULATOR_TOOL_BITNESS]]
    append ELAB_OPTIONS [get_non_duplicate_elab_option $ELAB_OPTIONS [i2c_master_inst_reset_bfm_ip::get_elab_options $SIMULATOR_TOOL_BITNESS]]
    if ![ string match "bit_64" $SIMULATOR_TOOL_BITNESS ] {
    } else {
    }
    return $ELAB_OPTIONS
  }
  
  
  proc get_sim_options {SIMULATOR_TOOL_BITNESS} {
    set SIM_OPTIONS ""
    append SIM_OPTIONS [i2c_master_inst_avalon_master_bfm_ip::get_sim_options $SIMULATOR_TOOL_BITNESS]
    append SIM_OPTIONS [i2c_master::get_sim_options $SIMULATOR_TOOL_BITNESS]
    append SIM_OPTIONS [i2c_master_inst_clock_bfm_ip::get_sim_options $SIMULATOR_TOOL_BITNESS]
    append SIM_OPTIONS [i2c_master_inst_conduit_end_bfm_ip::get_sim_options $SIMULATOR_TOOL_BITNESS]
    append SIM_OPTIONS [i2c_master_inst_reset_bfm_ip::get_sim_options $SIMULATOR_TOOL_BITNESS]
    if ![ string match "bit_64" $SIMULATOR_TOOL_BITNESS ] {
    } else {
    }
    return $SIM_OPTIONS
  }
  
  
  proc get_env_variables {SIMULATOR_TOOL_BITNESS} {
    set ENV_VARIABLES [dict create]
    set LD_LIBRARY_PATH [dict create]
    set LD_LIBRARY_PATH [dict merge $LD_LIBRARY_PATH [dict get [i2c_master_inst_avalon_master_bfm_ip::get_env_variables $SIMULATOR_TOOL_BITNESS] "LD_LIBRARY_PATH"]]
    set LD_LIBRARY_PATH [dict merge $LD_LIBRARY_PATH [dict get [i2c_master::get_env_variables $SIMULATOR_TOOL_BITNESS] "LD_LIBRARY_PATH"]]
    set LD_LIBRARY_PATH [dict merge $LD_LIBRARY_PATH [dict get [i2c_master_inst_clock_bfm_ip::get_env_variables $SIMULATOR_TOOL_BITNESS] "LD_LIBRARY_PATH"]]
    set LD_LIBRARY_PATH [dict merge $LD_LIBRARY_PATH [dict get [i2c_master_inst_conduit_end_bfm_ip::get_env_variables $SIMULATOR_TOOL_BITNESS] "LD_LIBRARY_PATH"]]
    set LD_LIBRARY_PATH [dict merge $LD_LIBRARY_PATH [dict get [i2c_master_inst_reset_bfm_ip::get_env_variables $SIMULATOR_TOOL_BITNESS] "LD_LIBRARY_PATH"]]
    dict set ENV_VARIABLES "LD_LIBRARY_PATH" $LD_LIBRARY_PATH
    if ![ string match "bit_64" $SIMULATOR_TOOL_BITNESS ] {
    } else {
    }
    return $ENV_VARIABLES
  }
  
  
  proc get_dpi_libraries {QSYS_SIMDIR} {
    set libraries [dict create]
    set libraries [dict merge $libraries [i2c_master_inst_avalon_master_bfm_ip::get_dpi_libraries "$QSYS_SIMDIR/../../ip/i2c_master_tb/i2c_master_inst_avalon_master_bfm_ip/sim/"]]
    set libraries [dict merge $libraries [i2c_master::get_dpi_libraries "$QSYS_SIMDIR/../../../i2c_master/sim/"]]
    set libraries [dict merge $libraries [i2c_master_inst_clock_bfm_ip::get_dpi_libraries "$QSYS_SIMDIR/../../ip/i2c_master_tb/i2c_master_inst_clock_bfm_ip/sim/"]]
    set libraries [dict merge $libraries [i2c_master_inst_conduit_end_bfm_ip::get_dpi_libraries "$QSYS_SIMDIR/../../ip/i2c_master_tb/i2c_master_inst_conduit_end_bfm_ip/sim/"]]
    set libraries [dict merge $libraries [i2c_master_inst_reset_bfm_ip::get_dpi_libraries "$QSYS_SIMDIR/../../ip/i2c_master_tb/i2c_master_inst_reset_bfm_ip/sim/"]]
    
    return $libraries
  }
  
}
