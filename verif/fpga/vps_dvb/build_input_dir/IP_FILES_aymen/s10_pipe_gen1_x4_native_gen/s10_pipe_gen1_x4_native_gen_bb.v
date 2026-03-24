module s10_pipe_gen1_x4_native_gen (
		input  wire [3:0]   tx_analogreset,            //            tx_analogreset.tx_analogreset
		input  wire [3:0]   rx_analogreset,            //            rx_analogreset.rx_analogreset
		input  wire [3:0]   tx_digitalreset,           //           tx_digitalreset.tx_digitalreset
		input  wire [3:0]   rx_digitalreset,           //           rx_digitalreset.rx_digitalreset
		output wire [3:0]   tx_analogreset_stat,       //       tx_analogreset_stat.tx_analogreset_stat
		output wire [3:0]   rx_analogreset_stat,       //       rx_analogreset_stat.rx_analogreset_stat
		output wire [3:0]   tx_digitalreset_stat,      //      tx_digitalreset_stat.tx_digitalreset_stat
		output wire [3:0]   rx_digitalreset_stat,      //      rx_digitalreset_stat.rx_digitalreset_stat
		output wire [3:0]   tx_cal_busy,               //               tx_cal_busy.tx_cal_busy
		output wire [3:0]   rx_cal_busy,               //               rx_cal_busy.rx_cal_busy
		input  wire [23:0]  tx_bonding_clocks,         //         tx_bonding_clocks.clk
		input  wire         rx_cdr_refclk0,            //            rx_cdr_refclk0.clk
		output wire [3:0]   tx_serial_data,            //            tx_serial_data.tx_serial_data
		input  wire [3:0]   rx_serial_data,            //            rx_serial_data.rx_serial_data
		input  wire [3:0]   rx_seriallpbken,           //           rx_seriallpbken.rx_seriallpbken
		output wire [3:0]   rx_is_lockedtoref,         //         rx_is_lockedtoref.rx_is_lockedtoref
		output wire [3:0]   rx_is_lockedtodata,        //        rx_is_lockedtodata.rx_is_lockedtodata
		input  wire [3:0]   tx_coreclkin,              //              tx_coreclkin.clk
		input  wire [3:0]   rx_coreclkin,              //              rx_coreclkin.clk
		output wire [3:0]   tx_clkout,                 //                 tx_clkout.clk
		output wire [3:0]   tx_clkout2,                //                tx_clkout2.clk
		output wire [3:0]   rx_clkout,                 //                 rx_clkout.clk
		input  wire [63:0]  tx_parallel_data,          //          tx_parallel_data.tx_parallel_data
		input  wire [7:0]   tx_datak,                  //                  tx_datak.tx_datak
		input  wire [3:0]   pipe_tx_compliance,        //        pipe_tx_compliance.pipe_tx_compliance
		input  wire [3:0]   pipe_tx_elecidle,          //          pipe_tx_elecidle.pipe_tx_elecidle
		input  wire [3:0]   pipe_tx_detectrx_loopback, // pipe_tx_detectrx_loopback.pipe_tx_detectrx_loopback
		input  wire [7:0]   pipe_powerdown,            //            pipe_powerdown.pipe_powerdown
		input  wire [11:0]  pipe_tx_margin,            //            pipe_tx_margin.pipe_tx_margin
		input  wire [3:0]   pipe_tx_swing,             //             pipe_tx_swing.pipe_tx_swing
		input  wire [3:0]   pipe_rx_polarity,          //          pipe_rx_polarity.pipe_rx_polarity
		input  wire [207:0] unused_tx_parallel_data,   //   unused_tx_parallel_data.unused_tx_parallel_data
		output wire [63:0]  rx_parallel_data,          //          rx_parallel_data.rx_parallel_data
		output wire [7:0]   rx_datak,                  //                  rx_datak.rx_datak
		output wire [7:0]   rx_syncstatus,             //             rx_syncstatus.rx_syncstatus
		output wire [3:0]   pipe_phy_status,           //           pipe_phy_status.pipe_phy_status
		output wire [3:0]   pipe_rx_valid,             //             pipe_rx_valid.pipe_rx_valid
		output wire [11:0]  pipe_rx_status,            //            pipe_rx_status.pipe_rx_status
		output wire [219:0] unused_rx_parallel_data,   //   unused_rx_parallel_data.unused_rx_parallel_data
		input  wire         pipe_hclk_in,              //              pipe_hclk_in.clk
		output wire         pipe_hclk_out,             //             pipe_hclk_out.clk
		input  wire [11:0]  pipe_rx_eidleinfersel,     //     pipe_rx_eidleinfersel.pipe_rx_eidleinfersel
		output wire [3:0]   pipe_rx_elecidle           //          pipe_rx_elecidle.pipe_rx_elecidle
	);
endmodule

