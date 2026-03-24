module fpt_ddr4_nw (
		input  wire         clk_misc_sa_clk,          // clk_misc_sa.clk
		input  wire         clk_mm_0_clk,             //    clk_mm_0.clk
		input  wire         clk_mm_1_clk,             //    clk_mm_1.clk
		input  wire         clk_mm_2_clk,             //    clk_mm_2.clk
		input  wire         clk_mm_3_clk,             //    clk_mm_3.clk
		output wire [25:0]  ddr4_amm_address,         //    ddr4_amm.address
		output wire [6:0]   ddr4_amm_burstcount,      //            .burstcount
		output wire [63:0]  ddr4_amm_byteenable,      //            .byteenable
		output wire         ddr4_amm_debugaccess,     //            .debugaccess
		output wire         ddr4_amm_read,            //            .read
		input  wire [511:0] ddr4_amm_readdata,        //            .readdata
		input  wire         ddr4_amm_readdatavalid,   //            .readdatavalid
		input  wire         ddr4_amm_waitrequest,     //            .waitrequest
		output wire         ddr4_amm_write,           //            .write
		output wire [511:0] ddr4_amm_writedata,       //            .writedata
		input  wire         reset_emif_reset_n,       //  reset_emif.reset_n
		input  wire         clk_emif_clk,             //    clk_emif.clk
		input  wire [31:0]  mm_0_address,             //        mm_0.address
		input  wire [3:0]   mm_0_burstcount,          //            .burstcount
		input  wire [31:0]  mm_0_byteenable,          //            .byteenable
		input  wire         mm_0_debugaccess,         //            .debugaccess
		input  wire         mm_0_read,                //            .read
		output wire [255:0] mm_0_readdata,            //            .readdata
		output wire         mm_0_readdatavalid,       //            .readdatavalid
		output wire         mm_0_waitrequest,         //            .waitrequest
		input  wire         mm_0_write,               //            .write
		input  wire [255:0] mm_0_writedata,           //            .writedata
		input  wire [31:0]  mm_1_address,             //        mm_1.address
		input  wire [3:0]   mm_1_burstcount,          //            .burstcount
		input  wire [31:0]  mm_1_byteenable,          //            .byteenable
		input  wire         mm_1_debugaccess,         //            .debugaccess
		input  wire         mm_1_read,                //            .read
		output wire [255:0] mm_1_readdata,            //            .readdata
		output wire         mm_1_readdatavalid,       //            .readdatavalid
		output wire         mm_1_waitrequest,         //            .waitrequest
		input  wire         mm_1_write,               //            .write
		input  wire [255:0] mm_1_writedata,           //            .writedata
		input  wire [31:0]  mm_2_address,             //        mm_2.address
		input  wire [3:0]   mm_2_burstcount,          //            .burstcount
		input  wire [31:0]  mm_2_byteenable,          //            .byteenable
		input  wire         mm_2_debugaccess,         //            .debugaccess
		input  wire         mm_2_read,                //            .read
		output wire [255:0] mm_2_readdata,            //            .readdata
		output wire         mm_2_readdatavalid,       //            .readdatavalid
		output wire         mm_2_waitrequest,         //            .waitrequest
		input  wire         mm_2_write,               //            .write
		input  wire [255:0] mm_2_writedata,           //            .writedata
		input  wire [31:0]  mm_3_address,             //        mm_3.address
		input  wire [3:0]   mm_3_burstcount,          //            .burstcount
		input  wire [31:0]  mm_3_byteenable,          //            .byteenable
		input  wire         mm_3_debugaccess,         //            .debugaccess
		input  wire         mm_3_read,                //            .read
		output wire [255:0] mm_3_readdata,            //            .readdata
		output wire         mm_3_readdatavalid,       //            .readdatavalid
		output wire         mm_3_waitrequest,         //            .waitrequest
		input  wire         mm_3_write,               //            .write
		input  wire [255:0] mm_3_writedata,           //            .writedata
		output wire [10:0]  mm_csr_address,           //      mm_csr.address
		output wire [3:0]   mm_csr_burstcount,        //            .burstcount
		output wire [3:0]   mm_csr_byteenable,        //            .byteenable
		output wire         mm_csr_debugaccess,       //            .debugaccess
		output wire         mm_csr_read,              //            .read
		input  wire [31:0]  mm_csr_readdata,          //            .readdata
		input  wire         mm_csr_readdatavalid,     //            .readdatavalid
		input  wire         mm_csr_waitrequest,       //            .waitrequest
		output wire         mm_csr_write,             //            .write
		output wire [31:0]  mm_csr_writedata,         //            .writedata
		input  wire [33:0]  mm_misc_sa_address,       //  mm_misc_sa.address
		input  wire [3:0]   mm_misc_sa_burstcount,    //            .burstcount
		input  wire [31:0]  mm_misc_sa_byteenable,    //            .byteenable
		input  wire         mm_misc_sa_debugaccess,   //            .debugaccess
		input  wire         mm_misc_sa_read,          //            .read
		output wire [255:0] mm_misc_sa_readdata,      //            .readdata
		output wire         mm_misc_sa_readdatavalid, //            .readdatavalid
		output wire         mm_misc_sa_waitrequest,   //            .waitrequest
		input  wire         mm_misc_sa_write,         //            .write
		input  wire [255:0] mm_misc_sa_writedata,     //            .writedata
		output wire [9:0]   emif_mmr_address,         //    emif_mmr.address
		output wire [0:0]   emif_mmr_burstcount,      //            .burstcount
		output wire [3:0]   emif_mmr_byteenable,      //            .byteenable
		output wire         emif_mmr_debugaccess,     //            .debugaccess
		output wire         emif_mmr_read,            //            .read
		input  wire [31:0]  emif_mmr_readdata,        //            .readdata
		input  wire         emif_mmr_readdatavalid,   //            .readdatavalid
		input  wire         emif_mmr_waitrequest,     //            .waitrequest
		output wire         emif_mmr_write,           //            .write
		output wire [31:0]  emif_mmr_writedata,       //            .writedata
		input  wire         rst_misc_sa_reset_n,      // rst_misc_sa.reset_n
		input  wire         rst_mm_0_reset_n,         //    rst_mm_0.reset_n
		input  wire         rst_mm_1_reset_n,         //    rst_mm_1.reset_n
		input  wire         rst_mm_2_reset_n,         //    rst_mm_2.reset_n
		input  wire         rst_mm_3_reset_n          //    rst_mm_3.reset_n
	);
endmodule

