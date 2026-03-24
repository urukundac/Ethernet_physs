simSetSimulator "-vcssv" -exec \
           "/nfs/site/disks/zsc14.xne_cnic.emu-fpga.002/pragyaro/i2c/output/physs_eth_tb/emu/haps_vcs_emuvcs/i2c_sim/MMG_PSS_SOC/vcs/simv" \
           -args \
           "-l testrlog +cxp_fastsimtrain +cxp_fast_eq_off +ppht_pll_quicksimlock +define+CXP_FAST_SIM_TRAIN +SVA_OFF -assert dumpoff +vpdfile+design.vpd" \
           -uvmDebug on -simDelim
