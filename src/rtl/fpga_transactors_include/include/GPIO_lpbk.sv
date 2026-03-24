// Loop back connection for SA simulation and Synthesis
`define 	GPIO_0 				`FPGA_TRANSACTORS_TOP       // example:  fpga_tcss_top.tcss_val_rtl.tcss.par_iom
`define 	GPIO_1 				`FPGA_TRANSACTORS_TOP       // example:  fpga_tcss_top.tcss_val_rtl.tcss.par_iom

// AXIM Addreaa Write port
assign gpio_in_bus_0       = gpio_out_bus_1;
assign gpio_in_bus_1       = gpio_out_bus_0;

