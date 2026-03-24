
namespace eval uhfi_iopll_s10_gen {
  proc get_memory_files {QSYS_SIMDIR} {
    set memory_files [list]
    return $memory_files
  }
  
  proc get_common_design_files {QSYS_SIMDIR} {
    set design_files [dict create]
    return $design_files
  }
  
  proc get_design_files {QSYS_SIMDIR} {
    set design_files [dict create]
    dict set design_files "uhfi_iopll_s10_gen_altera_iopll_1930_y2izzey.vo" "$QSYS_SIMDIR/../altera_iopll_1930/sim/uhfi_iopll_s10_gen_altera_iopll_1930_y2izzey.vo"
    dict set design_files "stratix10_altera_iopll.v"                        "$QSYS_SIMDIR/../altera_iopll_1930/sim/stratix10_altera_iopll.v"                       
    dict set design_files "uhfi_iopll_s10_gen.v"                            "$QSYS_SIMDIR/uhfi_iopll_s10_gen.v"                                                    
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
