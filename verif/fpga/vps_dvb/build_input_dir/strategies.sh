#!/bin/bash

echo "" >> spnr_settings.tcl

echo "#local quartus options settings" >> spnr_settings.tcl

if [ ${REDFPGA_STRATEGY:0:4} = "SEED" ]

then

echo "# redFPGA strategy: $REDFPGA_STRATEGY" >> spnr_settings.tcl

echo "set_global_assignment -name SEED ${REDFPGA_STRATEGY:(-1)}" >> spnr_settings.tcl

exec $*

fi
