module mdio_ethernet_ip #(
		parameter MDC_DIVISOR = 32
	) (
		input  wire        clk,             //       clock.clk
		input  wire        reset,           // clock_reset.reset
		input  wire        csr_write,       //         csr.write
		input  wire        csr_read,        //            .read
		input  wire [5:0]  csr_address,     //            .address
		input  wire [31:0] csr_writedata,   //            .writedata
		output wire [31:0] csr_readdata,    //            .readdata
		output wire        csr_waitrequest, //            .waitrequest
		output wire        mdc,             //        mdio.mdc
		input  wire        mdio_in,         //            .mdio_in
		output wire        mdio_out,        //            .mdio_out
		output wire        mdio_oen         //            .mdio_oen
	);
endmodule

