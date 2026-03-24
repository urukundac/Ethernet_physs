
//=================================================================================================================================
// Local Bus connections - USER MUST EDIT THE RIGHT HAND SIDE OF THE FOLLOWING ASSIGNMENTS AND DEFINE - WHEN NEEDED
//=================================================================================================================================
// Local Bus   BAR2 connection


 `ifdef F2F_BRIDGE
    `define 	 LOCAL_BUS_SLAVE 				fpga_transactors_PAR_top	
`else
    `define LOCAL_BUS_SLAVE	  			`FPGA_TRANSACTORS_TOP		
 `endif // example:  fpga_tcss_top.tcss_val_rtl.tcss.par_iom    //HERE USER SHOULD SET THE PATH TO HIS SIDE OF THE SB INTEFACE - THE AGENT SIDE

						
						
assign 				  		`TRANSACTORS_PATH.lb_clk 				= `LOCAL_BUS_SLAVE.slave_lb_clk;

//inputs to FGT

assign    /*[63:0]*/      	`TRANSACTORS_PATH.lb_rx_data     		= `LOCAL_BUS_SLAVE.slave_lb_rx_data;
assign                  	`TRANSACTORS_PATH.lb_rx_data_valid   	= `LOCAL_BUS_SLAVE.slave_lb_rx_data_valid;
assign                  	`TRANSACTORS_PATH.lb_wait     			= `LOCAL_BUS_SLAVE.slave_lb_wait;

//=================================================================================================================================
// CXL_CACHE_HOST connections - USER MUST EDIT THE LEFT HAND SIDE OF THE FOLLOWING ASSIGNMENTS 
//=================================================================================================================================


//outputs from FGT
assign     /*[31:0]*/    	 `LOCAL_BUS_SLAVE.slave_lb_addr			= `TRANSACTORS_PATH.lb_addr;
assign     /*[63:0]*/      	 `LOCAL_BUS_SLAVE.slave_lb_tx_data		= `TRANSACTORS_PATH.lb_tx_data;
assign                  	 `LOCAL_BUS_SLAVE.slave_lb_read			= `TRANSACTORS_PATH.lb_read;
assign     /*[7:0]*/       	 `LOCAL_BUS_SLAVE.slave_lb_tx_be		= `TRANSACTORS_PATH.lb_tx_be;
assign                  	 `LOCAL_BUS_SLAVE.slave_lb_eof			= `TRANSACTORS_PATH.lb_eof;
assign                  	 `LOCAL_BUS_SLAVE.slave_lb_write		= `TRANSACTORS_PATH.lb_write;

//=================================================================================================================================


