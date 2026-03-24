	s10_serdes_Ltile_with8b10b_tbi_eth u0 (
		.tx_analogreset          (_connected_to_tx_analogreset_),          //   input,   width = 1,          tx_analogreset.tx_analogreset
		.rx_analogreset          (_connected_to_rx_analogreset_),          //   input,   width = 1,          rx_analogreset.rx_analogreset
		.tx_digitalreset         (_connected_to_tx_digitalreset_),         //   input,   width = 1,         tx_digitalreset.tx_digitalreset
		.rx_digitalreset         (_connected_to_rx_digitalreset_),         //   input,   width = 1,         rx_digitalreset.rx_digitalreset
		.tx_analogreset_stat     (_connected_to_tx_analogreset_stat_),     //  output,   width = 1,     tx_analogreset_stat.tx_analogreset_stat
		.rx_analogreset_stat     (_connected_to_rx_analogreset_stat_),     //  output,   width = 1,     rx_analogreset_stat.rx_analogreset_stat
		.tx_digitalreset_stat    (_connected_to_tx_digitalreset_stat_),    //  output,   width = 1,    tx_digitalreset_stat.tx_digitalreset_stat
		.rx_digitalreset_stat    (_connected_to_rx_digitalreset_stat_),    //  output,   width = 1,    rx_digitalreset_stat.rx_digitalreset_stat
		.tx_cal_busy             (_connected_to_tx_cal_busy_),             //  output,   width = 1,             tx_cal_busy.tx_cal_busy
		.rx_cal_busy             (_connected_to_rx_cal_busy_),             //  output,   width = 1,             rx_cal_busy.rx_cal_busy
		.tx_serial_clk0          (_connected_to_tx_serial_clk0_),          //   input,   width = 1,          tx_serial_clk0.clk
		.rx_cdr_refclk0          (_connected_to_rx_cdr_refclk0_),          //   input,   width = 1,          rx_cdr_refclk0.clk
		.tx_serial_data          (_connected_to_tx_serial_data_),          //  output,   width = 1,          tx_serial_data.tx_serial_data
		.rx_serial_data          (_connected_to_rx_serial_data_),          //   input,   width = 1,          rx_serial_data.rx_serial_data
		.rx_is_lockedtoref       (_connected_to_rx_is_lockedtoref_),       //  output,   width = 1,       rx_is_lockedtoref.rx_is_lockedtoref
		.rx_is_lockedtodata      (_connected_to_rx_is_lockedtodata_),      //  output,   width = 1,      rx_is_lockedtodata.rx_is_lockedtodata
		.tx_coreclkin            (_connected_to_tx_coreclkin_),            //   input,   width = 1,            tx_coreclkin.clk
		.rx_coreclkin            (_connected_to_rx_coreclkin_),            //   input,   width = 1,            rx_coreclkin.clk
		.tx_clkout               (_connected_to_tx_clkout_),               //  output,   width = 1,               tx_clkout.clk
		.rx_clkout               (_connected_to_rx_clkout_),               //  output,   width = 1,               rx_clkout.clk
		.tx_parallel_data        (_connected_to_tx_parallel_data_),        //   input,   width = 8,        tx_parallel_data.tx_parallel_data
		.tx_datak                (_connected_to_tx_datak_),                //   input,   width = 1,                tx_datak.tx_datak
		.unused_tx_parallel_data (_connected_to_unused_tx_parallel_data_), //   input,  width = 71, unused_tx_parallel_data.unused_tx_parallel_data
		.rx_parallel_data        (_connected_to_rx_parallel_data_),        //  output,   width = 8,        rx_parallel_data.rx_parallel_data
		.rx_datak                (_connected_to_rx_datak_),                //  output,   width = 1,                rx_datak.rx_datak
		.rx_syncstatus           (_connected_to_rx_syncstatus_),           //  output,   width = 1,           rx_syncstatus.rx_syncstatus
		.rx_errdetect            (_connected_to_rx_errdetect_),            //  output,   width = 1,            rx_errdetect.rx_errdetect
		.rx_disperr              (_connected_to_rx_disperr_),              //  output,   width = 1,              rx_disperr.rx_disperr
		.rx_runningdisp          (_connected_to_rx_runningdisp_),          //  output,   width = 1,          rx_runningdisp.rx_runningdisp
		.rx_patterndetect        (_connected_to_rx_patterndetect_),        //  output,   width = 1,        rx_patterndetect.rx_patterndetect
		.rx_rmfifostatus         (_connected_to_rx_rmfifostatus_),         //  output,   width = 2,         rx_rmfifostatus.rx_rmfifostatus
		.unused_rx_parallel_data (_connected_to_unused_rx_parallel_data_)  //  output,  width = 64, unused_rx_parallel_data.unused_rx_parallel_data
	);

