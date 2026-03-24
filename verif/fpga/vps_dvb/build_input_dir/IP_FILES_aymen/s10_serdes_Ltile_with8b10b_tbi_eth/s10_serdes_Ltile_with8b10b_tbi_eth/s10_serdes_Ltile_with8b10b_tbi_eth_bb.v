module s10_serdes_Ltile_with8b10b_tbi_eth (
		input  wire [0:0]  tx_analogreset,          //          tx_analogreset.tx_analogreset
		input  wire [0:0]  rx_analogreset,          //          rx_analogreset.rx_analogreset
		input  wire [0:0]  tx_digitalreset,         //         tx_digitalreset.tx_digitalreset
		input  wire [0:0]  rx_digitalreset,         //         rx_digitalreset.rx_digitalreset
		output wire [0:0]  tx_analogreset_stat,     //     tx_analogreset_stat.tx_analogreset_stat
		output wire [0:0]  rx_analogreset_stat,     //     rx_analogreset_stat.rx_analogreset_stat
		output wire [0:0]  tx_digitalreset_stat,    //    tx_digitalreset_stat.tx_digitalreset_stat
		output wire [0:0]  rx_digitalreset_stat,    //    rx_digitalreset_stat.rx_digitalreset_stat
		output wire [0:0]  tx_cal_busy,             //             tx_cal_busy.tx_cal_busy
		output wire [0:0]  rx_cal_busy,             //             rx_cal_busy.rx_cal_busy
		input  wire [0:0]  tx_serial_clk0,          //          tx_serial_clk0.clk
		input  wire        rx_cdr_refclk0,          //          rx_cdr_refclk0.clk
		output wire [0:0]  tx_serial_data,          //          tx_serial_data.tx_serial_data
		input  wire [0:0]  rx_serial_data,          //          rx_serial_data.rx_serial_data
		output wire [0:0]  rx_is_lockedtoref,       //       rx_is_lockedtoref.rx_is_lockedtoref
		output wire [0:0]  rx_is_lockedtodata,      //      rx_is_lockedtodata.rx_is_lockedtodata
		input  wire [0:0]  tx_coreclkin,            //            tx_coreclkin.clk
		input  wire [0:0]  rx_coreclkin,            //            rx_coreclkin.clk
		output wire [0:0]  tx_clkout,               //               tx_clkout.clk
		output wire [0:0]  rx_clkout,               //               rx_clkout.clk
		input  wire [7:0]  tx_parallel_data,        //        tx_parallel_data.tx_parallel_data
		input  wire        tx_datak,                //                tx_datak.tx_datak
		input  wire [70:0] unused_tx_parallel_data, // unused_tx_parallel_data.unused_tx_parallel_data
		output wire [7:0]  rx_parallel_data,        //        rx_parallel_data.rx_parallel_data
		output wire        rx_datak,                //                rx_datak.rx_datak
		output wire        rx_syncstatus,           //           rx_syncstatus.rx_syncstatus
		output wire        rx_errdetect,            //            rx_errdetect.rx_errdetect
		output wire        rx_disperr,              //              rx_disperr.rx_disperr
		output wire        rx_runningdisp,          //          rx_runningdisp.rx_runningdisp
		output wire        rx_patterndetect,        //        rx_patterndetect.rx_patterndetect
		output wire [1:0]  rx_rmfifostatus,         //         rx_rmfifostatus.rx_rmfifostatus
		output wire [63:0] unused_rx_parallel_data  // unused_rx_parallel_data.unused_rx_parallel_data
	);
endmodule

