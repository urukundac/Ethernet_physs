#set_filling_rate -resources lut 0.50
#set_filling_rate -resources lutram  0.30
#set_filling_rate -resources lut 0.85
set_partition_iterations 100

set_assignment [list {mki_wrapper} {mki} {mki_uncore_misc} {mci_cmn} {parcgu}] -targets [list MB2_FA1_F1] ;#fgt_fpga_transactors_top_RTLC_LONGMOD1
set_assignment [list {mki_wrapper} {mki} {mki_uncore_misc} {mci_cmn} {parfuse}] -targets [list MB2_FA1_F2] ;#fgt_fpga_transactors_top_RTLC_LONGMOD1
set_assignment [list {mki_wrapper} {mki} {mki_uncore_misc} {mci_cmn} {pargpio}] -targets [list MB2_FA2_F1] ;#fgt_fpga_transactors_top_RTLC_LONGMOD1
set_assignment [list {mki_wrapper} {mki} {mki_uncore_misc} {mci_cmn} {parrst}] -targets [list MB2_FA2_F2] ;#fgt_fpga_transactors_top_RTLC_LONGMOD1
