module pcie_gen1_phy (
		input  wire [1:0]  pipe_sw_done,              //              pipe_sw_done.pipe_sw_done
		output wire [1:0]  pipe_sw,                   //                   pipe_sw.pipe_sw
		input  wire [0:0]  tx_analogreset,            //            tx_analogreset.tx_analogreset
		input  wire [0:0]  rx_analogreset,            //            rx_analogreset.rx_analogreset
		input  wire [0:0]  tx_digitalreset,           //           tx_digitalreset.tx_digitalreset
		input  wire [0:0]  rx_digitalreset,           //           rx_digitalreset.rx_digitalreset
		output wire [0:0]  tx_analogreset_stat,       //       tx_analogreset_stat.tx_analogreset_stat
		output wire [0:0]  rx_analogreset_stat,       //       rx_analogreset_stat.rx_analogreset_stat
		output wire [0:0]  tx_digitalreset_stat,      //      tx_digitalreset_stat.tx_digitalreset_stat
		output wire [0:0]  rx_digitalreset_stat,      //      rx_digitalreset_stat.rx_digitalreset_stat
		output wire [0:0]  tx_cal_busy,               //               tx_cal_busy.tx_cal_busy
		output wire [0:0]  rx_cal_busy,               //               rx_cal_busy.rx_cal_busy
		input  wire [0:0]  tx_serial_clk0,            //            tx_serial_clk0.clk
		input  wire        rx_cdr_refclk0,            //            rx_cdr_refclk0.clk
		output wire [0:0]  tx_serial_data,            //            tx_serial_data.tx_serial_data
		input  wire [0:0]  rx_serial_data,            //            rx_serial_data.rx_serial_data
		output wire [0:0]  rx_is_lockedtoref,         //         rx_is_lockedtoref.rx_is_lockedtoref
		output wire [0:0]  rx_is_lockedtodata,        //        rx_is_lockedtodata.rx_is_lockedtodata
		input  wire [0:0]  tx_coreclkin,              //              tx_coreclkin.clk
		input  wire [0:0]  rx_coreclkin,              //              rx_coreclkin.clk
		output wire [0:0]  tx_clkout,                 //                 tx_clkout.clk
		output wire [0:0]  rx_clkout,                 //                 rx_clkout.clk
		input  wire [15:0] tx_parallel_data,          //          tx_parallel_data.tx_parallel_data
		input  wire [1:0]  tx_datak,                  //                  tx_datak.tx_datak
		input  wire        pipe_tx_compliance,        //        pipe_tx_compliance.pipe_tx_compliance
		input  wire        pipe_tx_elecidle,          //          pipe_tx_elecidle.pipe_tx_elecidle
		input  wire        pipe_tx_detectrx_loopback, // pipe_tx_detectrx_loopback.pipe_tx_detectrx_loopback
		input  wire [1:0]  pipe_powerdown,            //            pipe_powerdown.pipe_powerdown
		input  wire [2:0]  pipe_tx_margin,            //            pipe_tx_margin.pipe_tx_margin
		input  wire        pipe_tx_swing,             //             pipe_tx_swing.pipe_tx_swing
		input  wire        pipe_rx_polarity,          //          pipe_rx_polarity.pipe_rx_polarity
		input  wire [51:0] unused_tx_parallel_data,   //   unused_tx_parallel_data.unused_tx_parallel_data
		output wire [15:0] rx_parallel_data,          //          rx_parallel_data.rx_parallel_data
		output wire [1:0]  rx_datak,                  //                  rx_datak.rx_datak
		output wire [1:0]  rx_syncstatus,             //             rx_syncstatus.rx_syncstatus
		output wire        pipe_phy_status,           //           pipe_phy_status.pipe_phy_status
		output wire        pipe_rx_valid,             //             pipe_rx_valid.pipe_rx_valid
		output wire [2:0]  pipe_rx_status,            //            pipe_rx_status.pipe_rx_status
		output wire [54:0] unused_rx_parallel_data,   //   unused_rx_parallel_data.unused_rx_parallel_data
		input  wire        pipe_hclk_in,              //              pipe_hclk_in.clk
		output wire        pipe_hclk_out,             //             pipe_hclk_out.clk
		input  wire [2:0]  pipe_rx_eidleinfersel,     //     pipe_rx_eidleinfersel.pipe_rx_eidleinfersel
		output wire [0:0]  pipe_rx_elecidle,          //          pipe_rx_elecidle.pipe_rx_elecidle
		input  wire [0:0]  reconfig_clk,              //              reconfig_clk.clk
		input  wire [0:0]  reconfig_reset,            //            reconfig_reset.reset
		input  wire [0:0]  reconfig_write,            //             reconfig_avmm.write
		input  wire [0:0]  reconfig_read,             //                          .read
		input  wire [10:0] reconfig_address,          //                          .address
		input  wire [31:0] reconfig_writedata,        //                          .writedata
		output wire [31:0] reconfig_readdata,         //                          .readdata
		output wire [0:0]  reconfig_waitrequest       //                          .waitrequest
	);
endmodule

