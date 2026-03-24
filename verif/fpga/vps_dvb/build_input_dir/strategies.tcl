################################################################################
##                                                                            ##
##                   Unpublished work. Copyright 2024 Siemens                 ##
##              This material contains trade secrets or otherwise             ##
##      confidential information owned by Siemens Industry Software Inc.      ##
##         or its affiliates (collectively, "SISW"), or its licensors.        ##
##        Access to and use of this information is strictly limited as        ##
##        set forth in the Customer's applicable agreements with SISW.        ##
##                                                                            ##
################################################################################

# read all strategies / transitions
global env
source $::env(RED_HOME)/partitioner/systems/fpga/altera/common/redfpga/redfpga__strategies.tcl
source $::env(RED_HOME)/partitioner/systems/fpga/altera/common/redfpga/redfpga__events.tcl
#define the number of seeds
if {[info exists NUMBER_OF_SEEDS]} {
    puts "running with $NUMBER_OF_SEEDS SEEDS"
} else {
    set NUMBER_OF_SEEDS 10
}

#define strategies list to be used

set ALL_STRATEGY [list ]
foreach strategy $REDFPGA_ALL_STRATEGIES {
    if {$strategy == "SEED_"} {
        for {set i 2} {$i < $NUMBER_OF_SEEDS + 2} {incr i} {
            set strategy_seed "SEED_$i"
            set_strategy $strategy_seed -exec "${RED_HOME}/partitioner/systems/fpga/altera/common/redfpga/redfpga__strategies_exec.sh"
            lappend ALL_STRATEGY $strategy_seed

        }
    } else {
        set_strategy $strategy -exec "${RED_HOME}/partitioner/systems/fpga/altera/common/redfpga/redfpga__strategies_exec.sh"
        lappend ALL_STRATEGY  $strategy
    }
}

#keep all strategy dirs. cleaned by default
#keep_strategy_dirs

# run the strategies
start $ALL_STRATEGY
