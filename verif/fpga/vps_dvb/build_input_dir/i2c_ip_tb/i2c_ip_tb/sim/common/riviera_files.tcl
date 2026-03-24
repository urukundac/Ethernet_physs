source [file join [file dirname [info script]] ./../../../ip/i2c_ip_tb/i2c_ip_inst_conduit_end_bfm_ip/sim/common/riviera_files.tcl]
source [file join [file dirname [info script]] ./../../../../i2c_ip/sim/common/riviera_files.tcl]
source [file join [file dirname [info script]] ./../../../ip/i2c_ip_tb/i2c_ip_inst_avalon_master_bfm_ip/sim/common/riviera_files.tcl]
source [file join [file dirname [info script]] ./../../../ip/i2c_ip_tb/i2c_ip_inst_reset_bfm_ip/sim/common/riviera_files.tcl]
source [file join [file dirname [info script]] ./../../../ip/i2c_ip_tb/i2c_ip_inst_clock_bfm_ip/sim/common/riviera_files.tcl]

namespace eval i2c_ip_tb {
  proc get_design_libraries {} {
    set libraries [dict create]
    set libraries [dict merge $libraries [i2c_ip_inst_conduit_end_bfm_ip::get_design_libraries]]
    set libraries [dict merge $libraries [i2c_ip::get_design_libraries]]
    set libraries [dict merge $libraries [i2c_ip_inst_avalon_master_bfm_ip::get_design_libraries]]
    set libraries [dict merge $libraries [i2c_ip_inst_reset_bfm_ip::get_design_libraries]]
    set libraries [dict merge $libraries [i2c_ip_inst_clock_bfm_ip::get_design_libraries]]
    dict set libraries i2c_ip_tb 1
    return $libraries
  }
  
  proc get_memory_files {QSYS_SIMDIR} {
    set memory_files [list]
    set memory_files [concat $memory_files [i2c_ip_inst_conduit_end_bfm_ip::get_memory_files "$QSYS_SIMDIR/../../ip/i2c_ip_tb/i2c_ip_inst_conduit_end_bfm_ip/sim/"]]
    set memory_files [concat $memory_files [i2c_ip::get_memory_files "$QSYS_SIMDIR/../../../i2c_ip/sim/"]]
    set memory_files [concat $memory_files [i2c_ip_inst_avalon_master_bfm_ip::get_memory_files "$QSYS_SIMDIR/../../ip/i2c_ip_tb/i2c_ip_inst_avalon_master_bfm_ip/sim/"]]
    set memory_files [concat $memory_files [i2c_ip_inst_reset_bfm_ip::get_memory_files "$QSYS_SIMDIR/../../ip/i2c_ip_tb/i2c_ip_inst_reset_bfm_ip/sim/"]]
    set memory_files [concat $memory_files [i2c_ip_inst_clock_bfm_ip::get_memory_files "$QSYS_SIMDIR/../../ip/i2c_ip_tb/i2c_ip_inst_clock_bfm_ip/sim/"]]
    return $memory_files
  }
  
  proc get_common_design_files {USER_DEFINED_COMPILE_OPTIONS USER_DEFINED_VERILOG_COMPILE_OPTIONS USER_DEFINED_VHDL_COMPILE_OPTIONS QSYS_SIMDIR} {
    set design_files [dict create]
    set design_files [dict merge $design_files [i2c_ip_inst_conduit_end_bfm_ip::get_common_design_files $USER_DEFINED_COMPILE_OPTIONS $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_VHDL_COMPILE_OPTIONS "$QSYS_SIMDIR/../../ip/i2c_ip_tb/i2c_ip_inst_conduit_end_bfm_ip/sim/"]]
    set design_files [dict merge $design_files [i2c_ip::get_common_design_files $USER_DEFINED_COMPILE_OPTIONS $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_VHDL_COMPILE_OPTIONS "$QSYS_SIMDIR/../../../i2c_ip/sim/"]]
    set design_files [dict merge $design_files [i2c_ip_inst_avalon_master_bfm_ip::get_common_design_files $USER_DEFINED_COMPILE_OPTIONS $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_VHDL_COMPILE_OPTIONS "$QSYS_SIMDIR/../../ip/i2c_ip_tb/i2c_ip_inst_avalon_master_bfm_ip/sim/"]]
    set design_files [dict merge $design_files [i2c_ip_inst_reset_bfm_ip::get_common_design_files $USER_DEFINED_COMPILE_OPTIONS $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_VHDL_COMPILE_OPTIONS "$QSYS_SIMDIR/../../ip/i2c_ip_tb/i2c_ip_inst_reset_bfm_ip/sim/"]]
    set design_files [dict merge $design_files [i2c_ip_inst_clock_bfm_ip::get_common_design_files $USER_DEFINED_COMPILE_OPTIONS $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_VHDL_COMPILE_OPTIONS "$QSYS_SIMDIR/../../ip/i2c_ip_tb/i2c_ip_inst_clock_bfm_ip/sim/"]]
    return $design_files
  }
  
  proc get_design_files {USER_DEFINED_COMPILE_OPTIONS USER_DEFINED_VERILOG_COMPILE_OPTIONS USER_DEFINED_VHDL_COMPILE_OPTIONS QSYS_SIMDIR} {
    set design_files [list]
    set design_files [concat $design_files [i2c_ip_inst_conduit_end_bfm_ip::get_design_files $USER_DEFINED_COMPILE_OPTIONS $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_VHDL_COMPILE_OPTIONS "$QSYS_SIMDIR/../../ip/i2c_ip_tb/i2c_ip_inst_conduit_end_bfm_ip/sim/"]]
    set design_files [concat $design_files [i2c_ip::get_design_files $USER_DEFINED_COMPILE_OPTIONS $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_VHDL_COMPILE_OPTIONS "$QSYS_SIMDIR/../../../i2c_ip/sim/"]]
    set design_files [concat $design_files [i2c_ip_inst_avalon_master_bfm_ip::get_design_files $USER_DEFINED_COMPILE_OPTIONS $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_VHDL_COMPILE_OPTIONS "$QSYS_SIMDIR/../../ip/i2c_ip_tb/i2c_ip_inst_avalon_master_bfm_ip/sim/"]]
    set design_files [concat $design_files [i2c_ip_inst_reset_bfm_ip::get_design_files $USER_DEFINED_COMPILE_OPTIONS $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_VHDL_COMPILE_OPTIONS "$QSYS_SIMDIR/../../ip/i2c_ip_tb/i2c_ip_inst_reset_bfm_ip/sim/"]]
    set design_files [concat $design_files [i2c_ip_inst_clock_bfm_ip::get_design_files $USER_DEFINED_COMPILE_OPTIONS $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_VHDL_COMPILE_OPTIONS "$QSYS_SIMDIR/../../ip/i2c_ip_tb/i2c_ip_inst_clock_bfm_ip/sim/"]]
    lappend design_files "vlog -v2k5 $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"[normalize_path "$QSYS_SIMDIR/i2c_ip_tb.v"]\"  -work i2c_ip_tb"
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
    append ELAB_OPTIONS [get_non_duplicate_elab_option $ELAB_OPTIONS [i2c_ip_inst_conduit_end_bfm_ip::get_elab_options $SIMULATOR_TOOL_BITNESS]]
    append ELAB_OPTIONS [get_non_duplicate_elab_option $ELAB_OPTIONS [i2c_ip::get_elab_options $SIMULATOR_TOOL_BITNESS]]
    append ELAB_OPTIONS [get_non_duplicate_elab_option $ELAB_OPTIONS [i2c_ip_inst_avalon_master_bfm_ip::get_elab_options $SIMULATOR_TOOL_BITNESS]]
    append ELAB_OPTIONS [get_non_duplicate_elab_option $ELAB_OPTIONS [i2c_ip_inst_reset_bfm_ip::get_elab_options $SIMULATOR_TOOL_BITNESS]]
    append ELAB_OPTIONS [get_non_duplicate_elab_option $ELAB_OPTIONS [i2c_ip_inst_clock_bfm_ip::get_elab_options $SIMULATOR_TOOL_BITNESS]]
    if ![ string match "bit_64" $SIMULATOR_TOOL_BITNESS ] {
    } else {
    }
    return $ELAB_OPTIONS
  }
  
  
  proc get_sim_options {SIMULATOR_TOOL_BITNESS} {
    set SIM_OPTIONS ""
    append SIM_OPTIONS [i2c_ip_inst_conduit_end_bfm_ip::get_sim_options $SIMULATOR_TOOL_BITNESS]
    append SIM_OPTIONS [i2c_ip::get_sim_options $SIMULATOR_TOOL_BITNESS]
    append SIM_OPTIONS [i2c_ip_inst_avalon_master_bfm_ip::get_sim_options $SIMULATOR_TOOL_BITNESS]
    append SIM_OPTIONS [i2c_ip_inst_reset_bfm_ip::get_sim_options $SIMULATOR_TOOL_BITNESS]
    append SIM_OPTIONS [i2c_ip_inst_clock_bfm_ip::get_sim_options $SIMULATOR_TOOL_BITNESS]
    if ![ string match "bit_64" $SIMULATOR_TOOL_BITNESS ] {
    } else {
    }
    return $SIM_OPTIONS
  }
  
  
  proc get_env_variables {SIMULATOR_TOOL_BITNESS} {
    set ENV_VARIABLES [dict create]
    set LD_LIBRARY_PATH [dict create]
    set LD_LIBRARY_PATH [dict merge $LD_LIBRARY_PATH [dict get [i2c_ip_inst_conduit_end_bfm_ip::get_env_variables $SIMULATOR_TOOL_BITNESS] "LD_LIBRARY_PATH"]]
    set LD_LIBRARY_PATH [dict merge $LD_LIBRARY_PATH [dict get [i2c_ip::get_env_variables $SIMULATOR_TOOL_BITNESS] "LD_LIBRARY_PATH"]]
    set LD_LIBRARY_PATH [dict merge $LD_LIBRARY_PATH [dict get [i2c_ip_inst_avalon_master_bfm_ip::get_env_variables $SIMULATOR_TOOL_BITNESS] "LD_LIBRARY_PATH"]]
    set LD_LIBRARY_PATH [dict merge $LD_LIBRARY_PATH [dict get [i2c_ip_inst_reset_bfm_ip::get_env_variables $SIMULATOR_TOOL_BITNESS] "LD_LIBRARY_PATH"]]
    set LD_LIBRARY_PATH [dict merge $LD_LIBRARY_PATH [dict get [i2c_ip_inst_clock_bfm_ip::get_env_variables $SIMULATOR_TOOL_BITNESS] "LD_LIBRARY_PATH"]]
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
  proc get_dpi_libraries {QSYS_SIMDIR} {
    set libraries [dict create]
    set libraries [dict merge $libraries [i2c_ip_inst_conduit_end_bfm_ip::get_dpi_libraries "$QSYS_SIMDIR/../../ip/i2c_ip_tb/i2c_ip_inst_conduit_end_bfm_ip/sim/"]]
    set libraries [dict merge $libraries [i2c_ip::get_dpi_libraries "$QSYS_SIMDIR/../../../i2c_ip/sim/"]]
    set libraries [dict merge $libraries [i2c_ip_inst_avalon_master_bfm_ip::get_dpi_libraries "$QSYS_SIMDIR/../../ip/i2c_ip_tb/i2c_ip_inst_avalon_master_bfm_ip/sim/"]]
    set libraries [dict merge $libraries [i2c_ip_inst_reset_bfm_ip::get_dpi_libraries "$QSYS_SIMDIR/../../ip/i2c_ip_tb/i2c_ip_inst_reset_bfm_ip/sim/"]]
    set libraries [dict merge $libraries [i2c_ip_inst_clock_bfm_ip::get_dpi_libraries "$QSYS_SIMDIR/../../ip/i2c_ip_tb/i2c_ip_inst_clock_bfm_ip/sim/"]]
    
    return $libraries
  }
  
}
