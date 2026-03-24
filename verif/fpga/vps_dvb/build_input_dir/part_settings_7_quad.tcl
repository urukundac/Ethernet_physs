set_filling_rate -resources lut 0.65
#set_autoconnect_max_cables 150 -type lvds
set_autoconnect_max_cables 150 -type lvds
set_partition_iterations 100
#set_partition_iterations 50

# Intra motherboard for MB1
add_hard_cable_assignment MB1/FA1_F2/TA0 MB1/FB2_F1/BA1 -cable_model IC-PDS-CABLE-R1
add_hard_cable_assignment MB1/FA1_F1/BA0 MB1/FB1_F1/BA0 -cable_model IC-PDS-CABLE-R1
add_hard_cable_assignment MB1/FA1_F1/BA2 MB1/FA2_F1/BA2 -cable_model IC-PDS-CABLE-R1
add_hard_cable_assignment MB1/FA1_F2/TB0 MB1/FA2_F2/TB0 -cable_model IC-PDS-CABLE-R1
add_hard_cable_assignment MB1/FA1_F2/TAB0 MB1/FB1_F2/BAB0 -cable_model IC-PDS-CABLE-R1
add_hard_cable_assignment MB1/FA1_F1/BB1 MB1/FB2_F2/BB0 -cable_model IC-PDS-CABLE-R1
add_hard_cable_assignment MB1/FB1_F1/BA2 MB1/FB2_F1/BA2 -cable_model IC-PDS-CABLE-R1
add_hard_cable_assignment MB1/FB1_F1/BB1 MB1/FA2_F2/TB1 -cable_model IC-PDS-CABLE-R1
add_hard_cable_assignment MB1/FB1_F2/TB0 MB1/FB2_F2/TB0 -cable_model IC-PDS-CABLE-R1
add_hard_cable_assignment MB1/FB1_F2/BB0 MB1/FA2_F1/BB1 -cable_model IC-PDS-CABLE-R1
add_hard_cable_assignment MB1/FA2_F2/TAB0 MB1/FB2_F2/BAB0 -cable_model IC-PDS-CABLE-R1
add_hard_cable_assignment MB1/FA2_F1/BA0 MB1/FB2_F1/BA0 -cable_model IC-PDS-CABLE-R1
# Intra motherboard for MB2
add_hard_cable_assignment MB2/FA1_F2/TA0 MB2/FB2_F1/BA1 -cable_model IC-PDS-CABLE-R1
add_hard_cable_assignment MB2/FA1_F1/BA0 MB2/FB1_F1/BA0 -cable_model IC-PDS-CABLE-R1
add_hard_cable_assignment MB2/FA1_F1/BA2 MB2/FA2_F1/BA2 -cable_model IC-PDS-CABLE-R1
add_hard_cable_assignment MB2/FA1_F2/TB0 MB2/FA2_F2/TB0 -cable_model IC-PDS-CABLE-R1
add_hard_cable_assignment MB2/FA1_F2/TAB0 MB2/FB1_F2/BAB0 -cable_model IC-PDS-CABLE-R1
add_hard_cable_assignment MB2/FA1_F1/BB1 MB2/FB2_F2/BB0 -cable_model IC-PDS-CABLE-R1
add_hard_cable_assignment MB2/FB1_F1/BA2 MB2/FB2_F1/BA2 -cable_model IC-PDS-CABLE-R1
add_hard_cable_assignment MB2/FB1_F1/BB1 MB2/FA2_F2/TB1 -cable_model IC-PDS-CABLE-R1
add_hard_cable_assignment MB2/FB1_F2/TB0 MB2/FB2_F2/TB0 -cable_model IC-PDS-CABLE-R1
add_hard_cable_assignment MB2/FB1_F2/BB0 MB2/FA2_F1/BB1 -cable_model IC-PDS-CABLE-R1
add_hard_cable_assignment MB2/FA2_F2/TAB0 MB2/FB2_F2/BAB0 -cable_model IC-PDS-CABLE-R1
add_hard_cable_assignment MB2/FA2_F1/BA0 MB2/FB2_F1/BA0 -cable_model IC-PDS-CABLE-R1
# Intra motherboard for MB3
add_hard_cable_assignment MB3/FA1_F2/TA0 MB3/FB2_F1/BA1 -cable_model IC-PDS-CABLE-R1
add_hard_cable_assignment MB3/FA1_F1/BA0 MB3/FB1_F1/BA0 -cable_model IC-PDS-CABLE-R1
add_hard_cable_assignment MB3/FA1_F1/BA2 MB3/FA2_F1/BA2 -cable_model IC-PDS-CABLE-R1
add_hard_cable_assignment MB3/FA1_F2/TB0 MB3/FA2_F2/TB0 -cable_model IC-PDS-CABLE-R1
add_hard_cable_assignment MB3/FA1_F2/TAB0 MB3/FB1_F2/BAB0 -cable_model IC-PDS-CABLE-R1
add_hard_cable_assignment MB3/FA1_F1/BB1 MB3/FB2_F2/BB0 -cable_model IC-PDS-CABLE-R1
add_hard_cable_assignment MB3/FB1_F1/BA2 MB3/FB2_F1/BA2 -cable_model IC-PDS-CABLE-R1
add_hard_cable_assignment MB3/FB1_F1/BB1 MB3/FA2_F2/TB1 -cable_model IC-PDS-CABLE-R1
add_hard_cable_assignment MB3/FB1_F2/TB0 MB3/FB2_F2/TB0 -cable_model IC-PDS-CABLE-R1
add_hard_cable_assignment MB3/FB1_F2/BB0 MB3/FA2_F1/BB1 -cable_model IC-PDS-CABLE-R1
add_hard_cable_assignment MB3/FA2_F2/TAB0 MB3/FB2_F2/BAB0 -cable_model IC-PDS-CABLE-R1
add_hard_cable_assignment MB3/FA2_F1/BA0 MB3/FB2_F1/BA0 -cable_model IC-PDS-CABLE-R1
# Intra motherboard for MB4
add_hard_cable_assignment MB4/FA1_F2/TA0 MB4/FB2_F1/BA1 -cable_model IC-PDS-CABLE-R1
add_hard_cable_assignment MB4/FA1_F1/BA0 MB4/FB1_F1/BA0 -cable_model IC-PDS-CABLE-R1
add_hard_cable_assignment MB4/FA1_F1/BA2 MB4/FA2_F1/BA2 -cable_model IC-PDS-CABLE-R1
add_hard_cable_assignment MB4/FA1_F2/TB0 MB4/FA2_F2/TB0 -cable_model IC-PDS-CABLE-R1
add_hard_cable_assignment MB4/FA1_F2/TAB0 MB4/FB1_F2/BAB0 -cable_model IC-PDS-CABLE-R1
add_hard_cable_assignment MB4/FA1_F1/BB1 MB4/FB2_F2/BB0 -cable_model IC-PDS-CABLE-R1
add_hard_cable_assignment MB4/FB1_F1/BA2 MB4/FB2_F1/BA2 -cable_model IC-PDS-CABLE-R1
#add_hard_cable_assignment MB4/FB1_F1/BB1 MB4/FA2_F2/TB1 -cable_model IC-PDS-CABLE-R1
add_hard_cable_assignment MB4/FB1_F1/BB1 MB4/FA2_F2/TA1 -cable_model IC-PDS-CABLE-R1
add_hard_cable_assignment MB4/FB1_F2/TB0 MB4/FB2_F2/TB0 -cable_model IC-PDS-CABLE-R1
add_hard_cable_assignment MB4/FB1_F2/BB0 MB4/FA2_F1/BB1 -cable_model IC-PDS-CABLE-R1
add_hard_cable_assignment MB4/FA2_F2/TAB0 MB4/FB2_F2/BAB0 -cable_model IC-PDS-CABLE-R1
add_hard_cable_assignment MB4/FA2_F1/BA0 MB4/FB2_F1/BA0 -cable_model IC-PDS-CABLE-R1
# Intra motherboard for MB5
add_hard_cable_assignment MB5/FA1_F2/TA0 MB5/FB2_F1/BA1 -cable_model IC-PDS-CABLE-R1
add_hard_cable_assignment MB5/FA1_F1/BA0 MB5/FB1_F1/BA0 -cable_model IC-PDS-CABLE-R1
add_hard_cable_assignment MB5/FA1_F1/BA2 MB5/FA2_F1/BA2 -cable_model IC-PDS-CABLE-R1
add_hard_cable_assignment MB5/FA1_F2/TB0 MB5/FA2_F2/TB0 -cable_model IC-PDS-CABLE-R1
add_hard_cable_assignment MB5/FA1_F2/TAB0 MB5/FB1_F2/BAB0 -cable_model IC-PDS-CABLE-R1
add_hard_cable_assignment MB5/FA1_F1/BB1 MB5/FB2_F2/BB0 -cable_model IC-PDS-CABLE-R1
add_hard_cable_assignment MB5/FB1_F1/BA2 MB5/FB2_F1/BA2 -cable_model IC-PDS-CABLE-R1
add_hard_cable_assignment MB5/FB1_F1/BB1 MB5/FA2_F2/TB1 -cable_model IC-PDS-CABLE-R1
add_hard_cable_assignment MB5/FB1_F2/TB0 MB5/FB2_F2/TB0 -cable_model IC-PDS-CABLE-R1
add_hard_cable_assignment MB5/FB1_F2/BB0 MB5/FA2_F1/BB1 -cable_model IC-PDS-CABLE-R1
add_hard_cable_assignment MB5/FA2_F2/TAB0 MB5/FB2_F2/BAB0 -cable_model IC-PDS-CABLE-R1
add_hard_cable_assignment MB5/FA2_F1/BA0 MB5/FB2_F1/BA0 -cable_model IC-PDS-CABLE-R1
# Intra motherboard for MB6
add_hard_cable_assignment MB6/FA1_F2/TA0 MB6/FB2_F1/BA1 -cable_model IC-PDS-CABLE-R1
add_hard_cable_assignment MB6/FA1_F1/BA0 MB6/FB1_F1/BA0 -cable_model IC-PDS-CABLE-R1
add_hard_cable_assignment MB6/FA1_F1/BA2 MB6/FA2_F1/BA2 -cable_model IC-PDS-CABLE-R1
add_hard_cable_assignment MB6/FA1_F2/TB0 MB6/FA2_F2/TB0 -cable_model IC-PDS-CABLE-R1
add_hard_cable_assignment MB6/FA1_F2/TAB0 MB6/FB1_F2/BAB0 -cable_model IC-PDS-CABLE-R1
add_hard_cable_assignment MB6/FA1_F1/BB1 MB6/FB2_F2/BB0 -cable_model IC-PDS-CABLE-R1
add_hard_cable_assignment MB6/FB1_F1/BA2 MB6/FB2_F1/BA2 -cable_model IC-PDS-CABLE-R1
add_hard_cable_assignment MB6/FB1_F1/BB1 MB6/FA2_F2/TB1 -cable_model IC-PDS-CABLE-R1
add_hard_cable_assignment MB6/FB1_F2/TB0 MB6/FB2_F2/TB0 -cable_model IC-PDS-CABLE-R1
add_hard_cable_assignment MB6/FB1_F2/BB0 MB6/FA2_F1/BB1 -cable_model IC-PDS-CABLE-R1
add_hard_cable_assignment MB6/FA2_F2/TAB0 MB6/FB2_F2/BAB0 -cable_model IC-PDS-CABLE-R1
add_hard_cable_assignment MB6/FA2_F1/BA0 MB6/FB2_F1/BA0 -cable_model IC-PDS-CABLE-R1
# Intra motherboard for MB7
add_hard_cable_assignment MB7/FA1_F2/TA0 MB7/FB2_F1/BA1 -cable_model IC-PDS-CABLE-R1
add_hard_cable_assignment MB7/FA1_F1/BA0 MB7/FB1_F1/BA0 -cable_model IC-PDS-CABLE-R1
add_hard_cable_assignment MB7/FA1_F1/BA2 MB7/FA2_F1/BA2 -cable_model IC-PDS-CABLE-R1
add_hard_cable_assignment MB7/FA1_F2/TB0 MB7/FA2_F2/TB0 -cable_model IC-PDS-CABLE-R1
add_hard_cable_assignment MB7/FA1_F2/TAB0 MB7/FB1_F2/BAB0 -cable_model IC-PDS-CABLE-R1
add_hard_cable_assignment MB7/FA1_F1/BB1 MB7/FB2_F2/BB0 -cable_model IC-PDS-CABLE-R1
add_hard_cable_assignment MB7/FB1_F1/BA2 MB7/FB2_F1/BA2 -cable_model IC-PDS-CABLE-R1
add_hard_cable_assignment MB7/FB1_F1/BB1 MB7/FA2_F2/TB1 -cable_model IC-PDS-CABLE-R1
add_hard_cable_assignment MB7/FB1_F2/TB0 MB7/FB2_F2/TB0 -cable_model IC-PDS-CABLE-R1
add_hard_cable_assignment MB7/FB1_F2/BB0 MB7/FA2_F1/BB1 -cable_model IC-PDS-CABLE-R1
add_hard_cable_assignment MB7/FA2_F2/TAB0 MB7/FB2_F2/BAB0 -cable_model IC-PDS-CABLE-R1
add_hard_cable_assignment MB7/FA2_F1/BA0 MB7/FB2_F1/BA0 -cable_model IC-PDS-CABLE-R1
############## treating intermotherboard MB1 
#+1 from MB1 to MB2
add_hard_cable_assignment MB1/FB1_F1/BB2  MB2/FA1_F1/BB2 -cable_model IC-PDS-CABLE-R1
add_hard_cable_assignment MB1/FB1_F2/TAB0 MB2/FA1_F2/BAB0 -cable_model IC-PDS-CABLE-R1
add_hard_cable_assignment MB1/FB2_F1/BB2  MB2/FA2_F1/BB2 -cable_model IC-PDS-CABLE-R1
add_hard_cable_assignment MB1/FB2_F2/TAB0 MB2/FA2_F2/BAB0 -cable_model IC-PDS-CABLE-R1
add_hard_cable_assignment MB1/FB2_F1/TB2 MB2/FA1_F2/TB1 -cable_model IC-PDS-CABLE-R1
add_hard_cable_assignment MB1/FB2_F2/TB1 MB2/FA1_F1/TB2 -cable_model IC-PDS-CABLE-R1
#+2 from MB1 to MB3
add_hard_cable_assignment MB1/FB1_F1/BA1 MB3/FA1_F1/BA1 -cable_model IC-PDS-CABLE-R1
add_hard_cable_assignment MB1/FB1_F2/TA0 MB3/FA1_F2/BB0 -cable_model IC-PDS-CABLE-R1
add_hard_cable_assignment MB1/FB2_F1/BB1 MB3/FA2_F1/BA1 -cable_model IC-PDS-CABLE-R1
add_hard_cable_assignment MB1/FB2_F2/TA0 MB3/FA2_F2/BB0 -cable_model IC-PDS-CABLE-R1
add_hard_cable_assignment MB1/FB2_F1/TA2 MB3/FA1_F2/TA1 -cable_model IC-PDS-CABLE-R1
add_hard_cable_assignment MB1/FB2_F2/TA1 MB3/FA1_F1/TA2 -cable_model IC-PDS-CABLE-R1
############## treating intermotherboard MB2 
#+1 from MB2 to MB3
add_hard_cable_assignment MB2/FB1_F1/BB2  MB3/FA1_F1/BB2 -cable_model IC-PDS-CABLE-R1
add_hard_cable_assignment MB2/FB1_F2/TAB0 MB3/FA1_F2/BAB0 -cable_model IC-PDS-CABLE-R1
add_hard_cable_assignment MB2/FB2_F1/BB2  MB3/FA2_F1/BB2 -cable_model IC-PDS-CABLE-R1
add_hard_cable_assignment MB2/FB2_F2/TAB0 MB3/FA2_F2/BAB0 -cable_model IC-PDS-CABLE-R1
add_hard_cable_assignment MB2/FB2_F1/TB2 MB3/FA1_F2/TB1 -cable_model IC-PDS-CABLE-R1
add_hard_cable_assignment MB2/FB2_F2/TB1 MB3/FA1_F1/TB2 -cable_model IC-PDS-CABLE-R1
#+2 from MB2 to MB4
add_hard_cable_assignment MB2/FB1_F1/BA1 MB4/FA1_F1/BA1 -cable_model IC-PDS-CABLE-R1
add_hard_cable_assignment MB2/FB1_F2/TA0 MB4/FA1_F2/BB0 -cable_model IC-PDS-CABLE-R1
add_hard_cable_assignment MB2/FB2_F1/BB1 MB4/FA2_F1/BA1 -cable_model IC-PDS-CABLE-R1
add_hard_cable_assignment MB2/FB2_F2/TA0 MB4/FA2_F2/BB0 -cable_model IC-PDS-CABLE-R1
add_hard_cable_assignment MB2/FB2_F1/TA2 MB4/FA1_F2/TA1 -cable_model IC-PDS-CABLE-R1
add_hard_cable_assignment MB2/FB2_F2/TA1 MB4/FA1_F1/TA2 -cable_model IC-PDS-CABLE-R1
############## treating intermotherboard MB3 
#+1 from MB3 to MB4
add_hard_cable_assignment MB3/FB1_F1/BB2  MB4/FA1_F1/BB2 -cable_model IC-PDS-CABLE-R1
add_hard_cable_assignment MB3/FB1_F2/TAB0 MB4/FA1_F2/BAB0 -cable_model IC-PDS-CABLE-R1
add_hard_cable_assignment MB3/FB2_F1/BB2  MB4/FA2_F1/BB2 -cable_model IC-PDS-CABLE-R1
add_hard_cable_assignment MB3/FB2_F2/TAB0 MB4/FA2_F2/BAB0 -cable_model IC-PDS-CABLE-R1
add_hard_cable_assignment MB3/FB2_F1/TB2 MB4/FA1_F2/TB1 -cable_model IC-PDS-CABLE-R1
add_hard_cable_assignment MB3/FB2_F2/TB1 MB4/FA1_F1/TB2 -cable_model IC-PDS-CABLE-R1
#+2 from MB3 to MB5
add_hard_cable_assignment MB3/FB1_F1/BA1 MB5/FA1_F1/BA1 -cable_model IC-PDS-CABLE-R1
add_hard_cable_assignment MB3/FB1_F2/TA0 MB5/FA1_F2/BB0 -cable_model IC-PDS-CABLE-R1
add_hard_cable_assignment MB3/FB2_F1/BB1 MB5/FA2_F1/BA1 -cable_model IC-PDS-CABLE-R1
add_hard_cable_assignment MB3/FB2_F2/TA0 MB5/FA2_F2/BB0 -cable_model IC-PDS-CABLE-R1
add_hard_cable_assignment MB3/FB2_F1/TA2 MB5/FA1_F2/TA1 -cable_model IC-PDS-CABLE-R1
add_hard_cable_assignment MB3/FB2_F2/TA1 MB5/FA1_F1/TA2 -cable_model IC-PDS-CABLE-R1
############## treating intermotherboard MB4 
#+1 from MB4 to MB5
add_hard_cable_assignment MB4/FB1_F1/BB2  MB5/FA1_F1/BB2 -cable_model IC-PDS-CABLE-R1
add_hard_cable_assignment MB4/FB1_F2/TAB0 MB5/FA1_F2/BAB0 -cable_model IC-PDS-CABLE-R1
add_hard_cable_assignment MB4/FB2_F1/BB2  MB5/FA2_F1/BB2 -cable_model IC-PDS-CABLE-R1
add_hard_cable_assignment MB4/FB2_F2/TAB0 MB5/FA2_F2/BAB0 -cable_model IC-PDS-CABLE-R1
add_hard_cable_assignment MB4/FB2_F1/TB2 MB5/FA1_F2/TB1 -cable_model IC-PDS-CABLE-R1
add_hard_cable_assignment MB4/FB2_F2/TB1 MB5/FA1_F1/TB2 -cable_model IC-PDS-CABLE-R1
#+2 from MB4 to MB6
add_hard_cable_assignment MB4/FB1_F1/BA1 MB6/FA1_F1/BA1 -cable_model IC-PDS-CABLE-R1
add_hard_cable_assignment MB4/FB1_F2/TA0 MB6/FA1_F2/BB0 -cable_model IC-PDS-CABLE-R1
add_hard_cable_assignment MB4/FB2_F1/BB1 MB6/FA2_F1/BA1 -cable_model IC-PDS-CABLE-R1
add_hard_cable_assignment MB4/FB2_F2/TA0 MB6/FA2_F2/BB0 -cable_model IC-PDS-CABLE-R1
add_hard_cable_assignment MB4/FB2_F1/TA2 MB6/FA1_F2/TA1 -cable_model IC-PDS-CABLE-R1
add_hard_cable_assignment MB4/FB2_F2/TA1 MB6/FA1_F1/TA2 -cable_model IC-PDS-CABLE-R1
############## treating intermotherboard MB5 
#+1 from MB5 to MB6
add_hard_cable_assignment MB5/FB1_F1/BB2  MB6/FA1_F1/BB2 -cable_model IC-PDS-CABLE-R1
add_hard_cable_assignment MB5/FB1_F2/TAB0 MB6/FA1_F2/BAB0 -cable_model IC-PDS-CABLE-R1
add_hard_cable_assignment MB5/FB2_F1/BB2  MB6/FA2_F1/BB2 -cable_model IC-PDS-CABLE-R1
add_hard_cable_assignment MB5/FB2_F2/TAB0 MB6/FA2_F2/BAB0 -cable_model IC-PDS-CABLE-R1
add_hard_cable_assignment MB5/FB2_F1/TB2 MB6/FA1_F2/TB1 -cable_model IC-PDS-CABLE-R1
add_hard_cable_assignment MB5/FB2_F2/TB1 MB6/FA1_F1/TB2 -cable_model IC-PDS-CABLE-R1
#+2 from MB5 to MB7
add_hard_cable_assignment MB5/FB1_F1/BA1 MB7/FA1_F1/BA1 -cable_model IC-PDS-CABLE-R1
add_hard_cable_assignment MB5/FB1_F2/TA0 MB7/FA1_F2/BB0 -cable_model IC-PDS-CABLE-R1
add_hard_cable_assignment MB5/FB2_F1/BB1 MB7/FA2_F1/BA1 -cable_model IC-PDS-CABLE-R1
add_hard_cable_assignment MB5/FB2_F2/TA0 MB7/FA2_F2/BB0 -cable_model IC-PDS-CABLE-R1
add_hard_cable_assignment MB5/FB2_F1/TA2 MB7/FA1_F2/TA1 -cable_model IC-PDS-CABLE-R1
add_hard_cable_assignment MB5/FB2_F2/TA1 MB7/FA1_F1/TA2 -cable_model IC-PDS-CABLE-R1
############## treating intermotherboard MB6 
#+1 from MB6 to MB7
add_hard_cable_assignment MB6/FB1_F1/BB2  MB7/FA1_F1/BB2 -cable_model IC-PDS-CABLE-R1
add_hard_cable_assignment MB6/FB1_F2/TAB0 MB7/FA1_F2/BAB0 -cable_model IC-PDS-CABLE-R1
add_hard_cable_assignment MB6/FB2_F1/BB2  MB7/FA2_F1/BB2 -cable_model IC-PDS-CABLE-R1
add_hard_cable_assignment MB6/FB2_F2/TAB0 MB7/FA2_F2/BAB0 -cable_model IC-PDS-CABLE-R1
add_hard_cable_assignment MB6/FB2_F1/TB2 MB7/FA1_F2/TB1 -cable_model IC-PDS-CABLE-R1
add_hard_cable_assignment MB6/FB2_F2/TB1 MB7/FA1_F1/TB2 -cable_model IC-PDS-CABLE-R1
############## treating intermotherboard MB7 

set_assignment [list {mki_wrapper} {d2d_ucie_sb_bridge_top}] -targets [list MB4_FA2_F1] ;#d2d_ucie_sb_bridge_lib_d2d_ucie_sb_bridge_4ac884890aedd1cdd639321273262c1e

set_assignment [list {mki_wrapper} {fpga_transactors_top_inst}] -targets [list MB4_FB1_F2] ;#fgt_fpga_transactors_top_RTLC_LONGMOD1
#set_assignment [list {mki_wrapper} {mki}] -targets [list MB4_FA1_F2] ;#fgt_fpga_transactors_top_RTLC_LONGMOD1
