module phy_xcvr_rst_ctrl_ip (
		input  wire       clock,                
		input  wire       reset,                
		output wire [3:0] tx_analogreset,       
		output wire [3:0] tx_digitalreset,      
		output wire [3:0] tx_ready,             
		input  wire [0:0] pll_locked,           
		input  wire [0:0] pll_select,           
		input  wire [3:0] tx_cal_busy,          
		input  wire [3:0] tx_analogreset_stat,  
		input  wire [3:0] tx_digitalreset_stat, 
		output wire [3:0] rx_analogreset,       
		output wire [3:0] rx_digitalreset,      
		output wire [3:0] rx_ready,             
		input  wire [3:0] rx_is_lockedtodata,   
		input  wire [3:0] rx_cal_busy,          
		input  wire [3:0] rx_analogreset_stat,  
		input  wire [3:0] rx_digitalreset_stat  
	);



	phy_xcvr_rst_ctrl_gen u0 (
		.clock                (clock),                
		.reset                (reset),                
		.tx_analogreset       (tx_analogreset),       
		.tx_digitalreset      (tx_digitalreset),      
		.tx_ready             (tx_ready),             
		.pll_locked           (pll_locked),           
		.pll_select           (pll_select),           
		.tx_cal_busy          (tx_cal_busy),          
		.tx_analogreset_stat  (tx_analogreset_stat),  
		.tx_digitalreset_stat (tx_digitalreset_stat), 
		.rx_analogreset       (rx_analogreset),       
		.rx_digitalreset      (rx_digitalreset),      
		.rx_ready             (rx_ready),             
		.rx_is_lockedtodata   (rx_is_lockedtodata),   
		.rx_cal_busy          (rx_cal_busy),          
		.rx_analogreset_stat  (rx_analogreset_stat),  
		.rx_digitalreset_stat (rx_digitalreset_stat)  
	);

endmodule

