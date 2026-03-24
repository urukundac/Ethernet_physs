module fpt_misc_sa_mm_nw (
		input  wire         apb_clock_in_clk_clk,                      //                  apb_clock_in_clk.clk
		input  wire         apb_reset_in_reset_reset_n,                //                apb_reset_in_reset.reset_n
		output wire [31:0]  avmm2st_address,                           //                           avmm2st.address
		output wire [0:0]   avmm2st_burstcount,                        //                                  .burstcount
		output wire [3:0]   avmm2st_byteenable,                        //                                  .byteenable
		output wire         avmm2st_debugaccess,                       //                                  .debugaccess
		output wire         avmm2st_read,                              //                                  .read
		input  wire [31:0]  avmm2st_readdata,                          //                                  .readdata
		input  wire         avmm2st_readdatavalid,                     //                                  .readdatavalid
		input  wire         avmm2st_waitrequest,                       //                                  .waitrequest
		output wire         avmm2st_write,                             //                                  .write
		output wire [31:0]  avmm2st_writedata,                         //                                  .writedata
		output wire [2:0]   avmm_default_slave_m0_address,             //             avmm_default_slave_m0.address
		output wire [0:0]   avmm_default_slave_m0_burstcount,          //                                  .burstcount
		output wire [3:0]   avmm_default_slave_m0_byteenable,          //                                  .byteenable
		output wire         avmm_default_slave_m0_debugaccess,         //                                  .debugaccess
		output wire         avmm_default_slave_m0_read,                //                                  .read
		input  wire [31:0]  avmm_default_slave_m0_readdata,            //                                  .readdata
		input  wire         avmm_default_slave_m0_readdatavalid,       //                                  .readdatavalid
		input  wire         avmm_default_slave_m0_waitrequest,         //                                  .waitrequest
		output wire         avmm_default_slave_m0_write,               //                                  .write
		output wire [31:0]  avmm_default_slave_m0_writedata,           //                                  .writedata
		output wire [7:0]   core_clk_rst_sync_bridge_m0_address,       //       core_clk_rst_sync_bridge_m0.address
		output wire [0:0]   core_clk_rst_sync_bridge_m0_burstcount,    //                                  .burstcount
		output wire [3:0]   core_clk_rst_sync_bridge_m0_byteenable,    //                                  .byteenable
		output wire         core_clk_rst_sync_bridge_m0_debugaccess,   //                                  .debugaccess
		output wire         core_clk_rst_sync_bridge_m0_read,          //                                  .read
		input  wire [31:0]  core_clk_rst_sync_bridge_m0_readdata,      //                                  .readdata
		input  wire         core_clk_rst_sync_bridge_m0_readdatavalid, //                                  .readdatavalid
		input  wire         core_clk_rst_sync_bridge_m0_waitrequest,   //                                  .waitrequest
		output wire         core_clk_rst_sync_bridge_m0_write,         //                                  .write
		output wire [31:0]  core_clk_rst_sync_bridge_m0_writedata,     //                                  .writedata
		input  wire         core_clk_rst_sync_clock_in_clk_clk,        //    core_clk_rst_sync_clock_in_clk.clk
		input  wire         core_clk_rst_sync_reset_in_reset_reset_n,  //  core_clk_rst_sync_reset_in_reset.reset_n
		output wire [33:0]  ddr4_avmm_address,                         //                         ddr4_avmm.address
		output wire [3:0]   ddr4_avmm_burstcount,                      //                                  .burstcount
		output wire [31:0]  ddr4_avmm_byteenable,                      //                                  .byteenable
		output wire         ddr4_avmm_debugaccess,                     //                                  .debugaccess
		output wire         ddr4_avmm_read,                            //                                  .read
		input  wire [255:0] ddr4_avmm_readdata,                        //                                  .readdata
		input  wire         ddr4_avmm_readdatavalid,                   //                                  .readdatavalid
		input  wire         ddr4_avmm_waitrequest,                     //                                  .waitrequest
		output wire         ddr4_avmm_write,                           //                                  .write
		output wire [255:0] ddr4_avmm_writedata,                       //                                  .writedata
		output wire [7:0]   fpga_glbl_bridge_m0_address,               //               fpga_glbl_bridge_m0.address
		output wire [0:0]   fpga_glbl_bridge_m0_burstcount,            //                                  .burstcount
		output wire [3:0]   fpga_glbl_bridge_m0_byteenable,            //                                  .byteenable
		output wire         fpga_glbl_bridge_m0_debugaccess,           //                                  .debugaccess
		output wire         fpga_glbl_bridge_m0_read,                  //                                  .read
		input  wire [31:0]  fpga_glbl_bridge_m0_readdata,              //                                  .readdata
		input  wire         fpga_glbl_bridge_m0_readdatavalid,         //                                  .readdatavalid
		input  wire         fpga_glbl_bridge_m0_waitrequest,           //                                  .waitrequest
		output wire         fpga_glbl_bridge_m0_write,                 //                                  .write
		output wire [31:0]  fpga_glbl_bridge_m0_writedata,             //                                  .writedata
		input  wire         i2c_clock_in_clk_clk,                      //                  i2c_clock_in_clk.clk
		input  wire [19:0]  i2c_avmm_address,                          //                          i2c_avmm.address
		input  wire [0:0]   i2c_avmm_burstcount,                       //                                  .burstcount
		input  wire [3:0]   i2c_avmm_byteenable,                       //                                  .byteenable
		input  wire         i2c_avmm_debugaccess,                      //                                  .debugaccess
		input  wire         i2c_avmm_read,                             //                                  .read
		output wire [31:0]  i2c_avmm_readdata,                         //                                  .readdata
		output wire         i2c_avmm_readdatavalid,                    //                                  .readdatavalid
		output wire         i2c_avmm_waitrequest,                      //                                  .waitrequest
		input  wire         i2c_avmm_write,                            //                                  .write
		input  wire [31:0]  i2c_avmm_writedata,                        //                                  .writedata
		input  wire         i2c_reset_in_reset_reset_n,                //                i2c_reset_in_reset.reset_n
		input  wire         infra_avst_clock_in_clk_clk,               //           infra_avst_clock_in_clk.clk
		input  wire         infra_avst_reset_in_reset_reset_n,         //         infra_avst_reset_in_reset.reset_n
		output wire [33:0]  jem_nw_bridge_m0_address,                  //                  jem_nw_bridge_m0.address
		output wire [10:0]  jem_nw_bridge_m0_burstcount,               //                                  .burstcount
		output wire [3:0]   jem_nw_bridge_m0_byteenable,               //                                  .byteenable
		output wire         jem_nw_bridge_m0_debugaccess,              //                                  .debugaccess
		output wire         jem_nw_bridge_m0_read,                     //                                  .read
		input  wire [31:0]  jem_nw_bridge_m0_readdata,                 //                                  .readdata
		input  wire         jem_nw_bridge_m0_readdatavalid,            //                                  .readdatavalid
		input  wire         jem_nw_bridge_m0_waitrequest,              //                                  .waitrequest
		output wire         jem_nw_bridge_m0_write,                    //                                  .write
		output wire [31:0]  jem_nw_bridge_m0_writedata,                //                                  .writedata
		input  wire         mon_clock_in_clk_clk,                      //                  mon_clock_in_clk.clk
		input  wire         mon_reset_in_reset_reset_n,                //                mon_reset_in_reset.reset_n
		input  wire [19:0]  pcie_hst_bridge_s0_address,                //                pcie_hst_bridge_s0.address
		input  wire [0:0]   pcie_hst_bridge_s0_burstcount,             //                                  .burstcount
		input  wire [3:0]   pcie_hst_bridge_s0_byteenable,             //                                  .byteenable
		input  wire         pcie_hst_bridge_s0_debugaccess,            //                                  .debugaccess
		input  wire         pcie_hst_bridge_s0_read,                   //                                  .read
		output wire [31:0]  pcie_hst_bridge_s0_readdata,               //                                  .readdata
		output wire         pcie_hst_bridge_s0_readdatavalid,          //                                  .readdatavalid
		output wire         pcie_hst_bridge_s0_waitrequest,            //                                  .waitrequest
		input  wire         pcie_hst_bridge_s0_write,                  //                                  .write
		input  wire [31:0]  pcie_hst_bridge_s0_writedata,              //                                  .writedata
		output wire [12:0]  spi_merlin_apb_translator_m0_paddr,        //      spi_merlin_apb_translator_m0.paddr
		output wire         spi_merlin_apb_translator_m0_penable,      //                                  .penable
		input  wire [31:0]  spi_merlin_apb_translator_m0_prdata,       //                                  .prdata
		input  wire         spi_merlin_apb_translator_m0_pready,       //                                  .pready
		output wire         spi_merlin_apb_translator_m0_psel,         //                                  .psel
		output wire [31:0]  spi_merlin_apb_translator_m0_pwdata,       //                                  .pwdata
		output wire         spi_merlin_apb_translator_m0_pwrite,       //                                  .pwrite
		output wire [7:0]   sys_clk_rst_sync_bridge_m0_address,        //        sys_clk_rst_sync_bridge_m0.address
		output wire [0:0]   sys_clk_rst_sync_bridge_m0_burstcount,     //                                  .burstcount
		output wire [3:0]   sys_clk_rst_sync_bridge_m0_byteenable,     //                                  .byteenable
		output wire         sys_clk_rst_sync_bridge_m0_debugaccess,    //                                  .debugaccess
		output wire         sys_clk_rst_sync_bridge_m0_read,           //                                  .read
		input  wire [31:0]  sys_clk_rst_sync_bridge_m0_readdata,       //                                  .readdata
		input  wire         sys_clk_rst_sync_bridge_m0_readdatavalid,  //                                  .readdatavalid
		input  wire         sys_clk_rst_sync_bridge_m0_waitrequest,    //                                  .waitrequest
		output wire         sys_clk_rst_sync_bridge_m0_write,          //                                  .write
		output wire [31:0]  sys_clk_rst_sync_bridge_m0_writedata,      //                                  .writedata
		input  wire         sys_clk_rst_sync_clock_in_clk_clk,         //     sys_clk_rst_sync_clock_in_clk.clk
		input  wire         sys_clk_rst_sync_reset_in_reset_reset_n,   //   sys_clk_rst_sync_reset_in_reset.reset_n
		input  wire [23:0]  sysfpga_avst_bridge_s0_address,            //            sysfpga_avst_bridge_s0.address
		input  wire [0:0]   sysfpga_avst_bridge_s0_burstcount,         //                                  .burstcount
		input  wire [3:0]   sysfpga_avst_bridge_s0_byteenable,         //                                  .byteenable
		input  wire         sysfpga_avst_bridge_s0_debugaccess,        //                                  .debugaccess
		input  wire         sysfpga_avst_bridge_s0_read,               //                                  .read
		output wire [31:0]  sysfpga_avst_bridge_s0_readdata,           //                                  .readdata
		output wire         sysfpga_avst_bridge_s0_readdatavalid,      //                                  .readdatavalid
		output wire         sysfpga_avst_bridge_s0_waitrequest,        //                                  .waitrequest
		input  wire         sysfpga_avst_bridge_s0_write,              //                                  .write
		input  wire [31:0]  sysfpga_avst_bridge_s0_writedata,          //                                  .writedata
		input  wire         sysfpga_avst_clock_in_clk_clk,             //         sysfpga_avst_clock_in_clk.clk
		input  wire         sysfpga_avst_reset_in_reset_reset_n,       //       sysfpga_avst_reset_in_reset.reset_n
		output wire [31:0]  usr_cntrl_pio_external_connection_export,  // usr_cntrl_pio_external_connection.export
		output wire [7:0]   usr_status_bridge_m0_address,              //              usr_status_bridge_m0.address
		output wire [0:0]   usr_status_bridge_m0_burstcount,           //                                  .burstcount
		output wire [3:0]   usr_status_bridge_m0_byteenable,           //                                  .byteenable
		output wire         usr_status_bridge_m0_debugaccess,          //                                  .debugaccess
		output wire         usr_status_bridge_m0_read,                 //                                  .read
		input  wire [31:0]  usr_status_bridge_m0_readdata,             //                                  .readdata
		input  wire         usr_status_bridge_m0_readdatavalid,        //                                  .readdatavalid
		input  wire         usr_status_bridge_m0_waitrequest,          //                                  .waitrequest
		output wire         usr_status_bridge_m0_write,                //                                  .write
		output wire [31:0]  usr_status_bridge_m0_writedata             //                                  .writedata
	);
endmodule

