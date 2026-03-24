module sys_pll (
		input  wire       rst,              //            reset.reset
		input  wire       refclk,           //           refclk.clk
		output wire       locked,           //           locked.export
		input  wire       scanclk,          //          scanclk.clk
		input  wire       phase_en,         //         phase_en.phase_en
		input  wire       updn,             //             updn.updn
		input  wire [4:0] cntsel,           //           cntsel.cntsel
		output wire       phase_done,       //       phase_done.phase_done
		input  wire [2:0] num_phase_shifts, // num_phase_shifts.num_phase_shifts
		output wire       outclk_0,         //          outclk0.clk
		output wire       outclk_1,         //          outclk1.clk
		output wire       outclk_2,         //          outclk2.clk
		output wire       outclk_3,         //          outclk3.clk
		output wire       outclk_4,         //          outclk4.clk
		output wire       outclk_5,         //          outclk5.clk
		output wire       outclk_6,         //          outclk6.clk
		output wire       outclk_7          //          outclk7.clk
	);
endmodule

