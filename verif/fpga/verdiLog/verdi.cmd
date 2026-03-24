simSetSimulator "-vcssv" -exec \
           "/nfs/site/disks/zsc14.xne_cnic.emu-fpga.001/kumarlok/i2c_synpsys/output/physs_eth_tb/emu/haps_vcs_emuvcs/synpsys_1/MMG_PSS_SOC/vcs/simv" \
           -args \
           "+cxp_fastsimtrain +cxp_fast_eq_off +ppht_pll_quicksimlock +define+CXP_FAST_SIM_TRAIN +SVA_OFF -assert dumpoff +vpdfile+design.vpd -sml=verdi +UVM_VERDI_TRACE=UVM_AWARE -ucli2Proc -ucli"
debImport "-dbdir" \
          "/nfs/site/disks/zsc14.xne_cnic.emu-fpga.001/kumarlok/i2c_synpsys/output/physs_eth_tb/emu/haps_vcs_emuvcs/synpsys_1/MMG_PSS_SOC/vcs/simv.daidir"
debLoadSimResult \
           /nfs/site/disks/zsc14.xne_cnic.emu-fpga.001/kumarlok/i2c_synpsys/verif/emu/inter.fsdb
wvCreateWindow
verdiSetActWin -win $_nWave2
verdiWindowResize -win $_Verdi_1 "505" "261" "900" "700"
verdiWindowResize -win $_Verdi_1 "505" "261" "900" "700"
verdiSetActWin -dock widgetDock_MTB_SOURCE_TAB_1
verdiDockWidgetSetCurTab -dock widgetDock_<Message>
verdiSetActWin -dock widgetDock_<Message>
verdiWindowResize -win $_Verdi_1 "505" "158" "900" "803"
verdiWindowResize -win $_Verdi_1 "505" "159" "900" "802"
verdiWindowResize -win $_Verdi_1 "505" "159" "1223" "802"
verdiWindowResize -win $_Verdi_1 "505" "159" "1290" "802"
verdiWindowResize -win $_Verdi_1 "57" "159" "1738" "802"
verdiWindowResize -win $_Verdi_1 "57" "159" "1738" "888"
verdiSetActWin -dock widgetDock_<Inst._Tree>
srcHBSelect "physs_eth_tb.physs_eth.A00_i2c" -win $_nTrace1
srcSignalView -on
verdiSetActWin -dock widgetDock_<Signal_List>
srcHBSelect "physs_eth_tb.physs_eth.A00_i2c" -win $_nTrace1
verdiSetActWin -dock widgetDock_<Inst._Tree>
srcSignalViewSelect "physs_eth_tb.i2c_apb_clk"
verdiSetActWin -dock widgetDock_<Signal_List>
srcSignalViewSelect "physs_eth_tb.i2c_apb_clk" "physs_eth_tb.i_reset" \
           "physs_eth_tb.physs_func_rst_raw_n" "physs_eth_tb.I2C_SDA" \
           "physs_eth_tb.I2C_SCL" "physs_eth_tb.i2c_psel" \
           "physs_eth_tb.i2c_penable" "physs_eth_tb.i2c_pwrite" \
           "physs_eth_tb.i2c_pprot\[2:0\]" "physs_eth_tb.i2c_pstrb\[3:0\]" \
           "physs_eth_tb.i2c_paddr\[7:0\]" "physs_eth_tb.i2c_pwdata\[31:0\]" \
           "physs_eth_tb.i2c_prdata\[31:0\]" "physs_eth_tb.i2c_pready" \
           "physs_eth_tb.i2c_pslverr"
srcSignalViewAddSelectedToWave -clipboard
wvDrop -win $_nWave2
verdiDockWidgetSetCurTab -dock windowDock_nWave_2
verdiSetActWin -win $_nWave2
wvZoom -win $_nWave2 0.000000 1748.415287
wvSelectSignal -win $_nWave2 {( "G1" 15 )} 
wvSelectSignal -win $_nWave2 {( "G1" 14 )} 
wvScrollUp -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvSelectSignal -win $_nWave2 {( "G1" 15 )} 
wvSetCursor -win $_nWave2 288.930741 -snap {("G1" 12)}
wvZoom -win $_nWave2 233.410716 539.337383
wvSelectSignal -win $_nWave2 {( "G1" 7 )} 
wvSelectSignal -win $_nWave2 {( "G1" 8 )} 
wvSetCursor -win $_nWave2 329.629587 -snap {("G1" 6)}
wvSelectSignal -win $_nWave2 {( "G1" 7 )} 
wvSelectSignal -win $_nWave2 {( "G1" 6 )} 
wvSelectSignal -win $_nWave2 {( "G1" 7 )} 
wvSetCursor -win $_nWave2 349.366792 -snap {("G1" 7)}
wvSetCursor -win $_nWave2 370.831001 -snap {("G1" 7)}
wvSetCursor -win $_nWave2 349.860222 -snap {("G1" 14)}
wvZoomOut -win $_nWave2
wvSelectSignal -win $_nWave2 {( "G1" 6 )} 
wvSetMarker -win $_nWave2 370.000000
srcHBSelect "physs_eth_tb.physs_eth.A00_i2c" -win $_nTrace1
srcSetScope "physs_eth_tb.physs_eth.A00_i2c" -delim "." -win $_nTrace1
srcSignalViewSelect "physs_eth_tb.physs_eth.A00_i2c.pslverr"
verdiSetActWin -dock widgetDock_<Signal_List>
verdiSetActWin -win $_nWave2
wvSetPosition -win $_nWave2 {("G1" 14)}
wvSetPosition -win $_nWave2 {("G1" 15)}
wvSetPosition -win $_nWave2 {("G1" 0)}
wvSetPosition -win $_nWave2 {("G1" 15)}
srcTraceConnectivity "physs_eth_tb.i2c_pslverr" -win $_nTrace1
wvSelectSignal -win $_nWave2 {( "G1" 15 )} 
srcSignalViewSelect "physs_eth_tb.physs_eth.A00_i2c.pslverr"
srcSignalViewAddSelectedToWave
verdiSetActWin -dock widgetDock_<Signal_List>
verdiSetActWin -dock widgetDock_<Inst._Tree>
srcHBSelect "physs_eth_tb.physs_eth.A00_i2c.U_DW_apb_i2c_regfile" -win $_nTrace1
srcSetScope "physs_eth_tb.physs_eth.A00_i2c.U_DW_apb_i2c_regfile" -delim "." -win \
           $_nTrace1
srcHBSelect "physs_eth_tb.physs_eth.A00_i2c.U_DW_apb_i2c_regfile" -win $_nTrace1
srcDeselectAll -win $_nTrace1
verdiSetActWin -dock widgetDock_MTB_SOURCE_TAB_1
srcDeselectAll -win $_nTrace1
verdiFindBar -show -widget MTB_SOURCE_TAB_1
verdiFindBar -pattern "slverr" -next -widget MTB_SOURCE_TAB_1
verdiFindBar -pattern "slverr" -next -widget MTB_SOURCE_TAB_1
verdiFindBar -pattern "slverr" -next -widget MTB_SOURCE_TAB_1
verdiFindBar -pattern "slverr" -next -widget MTB_SOURCE_TAB_1
verdiFindBar -pattern "slverr" -next -widget MTB_SOURCE_TAB_1
verdiFindBar -pattern "slverr" -previous -widget MTB_SOURCE_TAB_1
verdiFindBar -pattern "slverr" -next -widget MTB_SOURCE_TAB_1
verdiFindBar -hide -widget MTB_SOURCE_TAB_1
verdiFindBar -hide -widget MTB_SOURCE_TAB_1
debExit
