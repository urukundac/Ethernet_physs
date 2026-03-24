/////////////////////////////////////////////////////////////////////////////////////////////
// Intel Confidential                                                                      //
/////////////////////////////////////////////////////////////////////////////////////////////
// Copyright 2024 Intel Corporation. The information contained herein is the proprietary   //
// and confidential information of Intel or its licensors, and is supplied subject to, and //
// may be used only in accordance with, previously executed agreements with Intel.         //
// EXCEPT AS MAY OTHERWISE BE AGREED IN WRITING: (1) ALL MATERIALS FURNISHED BY INTEL      //
// HEREUNDER ARE PROVIDED "AS IS" WITHOUT WARRANTY OF ANY KIND; (2) INTEL SPECIFICALLY     //
// DISCLAIMS ANY WARRANTY OF NONINFRINGEMENT, FITNESS FOR A PARTICULAR PURPOSE OR          //
// MERCHANTABILITY; AND (3) INTEL WILL NOT BE LIABLE FOR ANY COSTS OF PROCUREMENT OF       //
// SUBSTITUTES, LOSS OF PROFITS, INTERRUPTION OF BUSINESS, OR FOR ANY OTHER SPECIAL,       //
// CONSEQUENTIAL OR INCIDENTAL DAMAGES, HOWEVER CAUSED, WHETHER FOR BREACH OF WARRANTY,    //
// CONTRACT, TORT, NEGLIGENCE, STRICT LIABILITY OR OTHERWISE.                              //
/////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////
//                                                                                         //
//  Vendor:                Intel Corporation                                               //
//  Product:               c78tcam                                                         //
//  Version:               r0.1.0                                                          //
//  Technology:            ip783                                                           //
//  Celltype:              MemoryIP                                                        //
//  IP Owner:              Intel CMO                                                       //
//  Creation Time:         Fri Jul 12 2024 00:19:01                                        //
//  Memory Name:           ip783tcam512x40s0c1                                             //
//  Memory Name Generated: ip783tcam512x40s0c1                                             //
//                                                                                         //
/////////////////////////////////////////////////////////////////////////////////////////////

// control the defines for FPGA/Emulation usage
`ifdef INTEL_FPGA
  `define INTC_MEM_ip783tcam512x40s0c1_EF_MODE
  `define INTC_MEM_ip783tcam512x40s0c1_NOXHANDLING
  `define INTC_MEM_ip783tcam512x40s0c1_SVA_OFF
`else
  `ifdef INTEL_EMULATION
    `define INTC_MEM_ip783tcam512x40s0c1_EF_MODE
    `define INTC_MEM_ip783tcam512x40s0c1_NOXHANDLING
    `define INTC_MEM_ip783tcam512x40s0c1_SVA_OFF
  `else
    `ifdef INTC_MEM_FAST_SIM
      `define INTC_MEM_ip783tcam512x40s0c1_EF_MODE
      `define INTC_MEM_ip783tcam512x40s0c1_NOXHANDLING
      `define INTC_MEM_ip783tcam512x40s0c1_SVA_OFF
    `else
      `ifndef INTEL_SIMONLY
        `define INTC_MEM_ip783tcam512x40s0c1_EF_MODE
        `define INTC_MEM_ip783tcam512x40s0c1_NOXHANDLING
        `define INTC_MEM_ip783tcam512x40s0c1_SVA_OFF
      `endif
    `endif
  `endif
`endif

`ifndef INTC_MEM_PATH_SIZE
  `define INTC_MEM_PATH_SIZE 256
`endif // INTC_MEM_PATH_SIZE

`ifdef INTC_MEM_ESP
  `timescale 1ps/1ps                                                            // lintra s-70104
  `define INTC_MEM_ip783tcam512x40s0c1_NOXHANDLING
  `define INTC_MEM_ip783tcam512x40s0c1_SVA_OFF
  `define INTC_MEM_ip783tcam512x40s0c1_NOAGING
`endif // INTC_MEM_ESP

`ifdef INTC_MEM_GLS
  `define INTC_MEM_ip783tcam512x40s0c1_NOAGING
`endif // INTC_MEM_GLS

`ifdef INTC_MEM_NOXHANDLING
  `define INTC_MEM_ip783tcam512x40s0c1_NOXHANDLING
`endif // INTC_MEM_NOXHANDLING

`ifdef INTEL_SVA_OFF
  `define INTC_MEM_ip783tcam512x40s0c1_SVA_OFF
`endif // INTEL_SVA_OFF

`ifdef INTC_MEM_fault_norepair
  `define INTC_ip783tcam512x40s0c1_local_fi_nrep
  `define INTC_MEM_ip783tcam512x40s0c1_FI
`endif // INTC_MEM_fault_norepair

`ifdef INTC_MEM_fault_repair
  `define INTC_ip783tcam512x40s0c1_local_fi_rep
  `define INTC_MEM_ip783tcam512x40s0c1_FI
`endif // INTC_MEM_fault_repair

`ifdef INTC_MEM_fault_single
  `define INTC_ip783tcam512x40s0c1_local_fi_srep
  `define INTC_MEM_ip783tcam512x40s0c1_FI
`endif // INTC_MEM_fault_single

`ifdef INTC_MEM_ip783tcam512x40s0c1_fault_norepair
  `define INTC_ip783tcam512x40s0c1_local_fi_nrep
  `define INTC_MEM_ip783tcam512x40s0c1_FI
`endif // INTC_MEM_ip783tcam512x40s0c1_fault_norepair

`ifdef INTC_MEM_ip783tcam512x40s0c1_fault_repair
  `define INTC_ip783tcam512x40s0c1_local_fi_rep
  `define INTC_MEM_ip783tcam512x40s0c1_FI
`endif // INTC_MEM_ip783tcam512x40s0c1_fault_repair

`ifdef INTC_MEM_ip783tcam512x40s0c1_fault_single
  `define INTC_ip783tcam512x40s0c1_local_fi_srep
  `define INTC_MEM_ip783tcam512x40s0c1_FI
`endif // INTC_MEM_ip783tcam512x40s0c1_fault_single

`ifdef INTC_MEM_NOAGING
  `define INTC_MEM_ip783tcam512x40s0c1_NOAGING
`endif // INTC_MEM_NOAGING

`celldefine


module ip783tcam512x40s0c1 (                                          // lintra s-68000 s-70607
    `ifndef INTEL_NO_PWR_PINS
        vddp,
      `ifdef INTC_ADD_VSS
        vss,
      `endif // INTC_ADD_VSS
    `endif // INTEL_NO_PWR_PINS
		clk,
		adr,
		x_ybar_sel,

		ren,
		wen,
		srchen,

		din,
		matchin,
		dinmask,
		dinvalid,
		dinvalidmask,
		glbvalidbitrst,

		output_reset,

		mce,
		ra,
		rmce,
		stbyp,
		wa,
		wa_disable,
		wmce,
		wpulse,

		matchout,
		qvalid,
		q
    );

		localparam int unsigned ADDR = 9;
		localparam int unsigned DATA = 26;
		localparam int unsigned TENT = 512;

    `ifndef INTEL_NO_PWR_PINS
        input wire vddp;               		// lintra s-60010
      `ifdef INTC_ADD_VSS
        inout wire vss;
      `endif // INTC_ADD_VSS
    `endif // INTEL_NO_PWR_PINS
        input wire clk;		           		// clock
        input wire [ADDR-1:0] adr;	   		// Address
        input wire x_ybar_sel;         		// select for x or y of the TCAM cell, if(x_ybar_sel = 1, select X , else select Y)
        input wire ren;	               		// read enable
        input wire wen;	               		// write enable
        input wire srchen;	           		// search enable
        input wire [DATA-1:0] din;     		// data in
        input wire [TENT-1:0] matchin;  		// match in
        input wire [DATA-1:0] dinmask; 		// mask for data in(key mask)
        input wire dinvalid;           		// data in for valid array
        input wire dinvalidmask;       		// mask for valid in
        input wire glbvalidbitrst;     		// reset for valid array

        input wire output_reset;       		// output reset

        input wire mce;                		// Enables pin programmable control of timing margin settings, references default value supporting all operating voltages when set to 0.
        input wire [1:0] ra;	       		// read assist
        input wire [3:0] rmce;         		// Read margin control bus.
        input wire stbyp;              		// Overrides self-timed clocking to support debug. Forces the read to occur at falling edge of clock clk.
        input wire [2:0] wa;	       		// write assist

        input wire wa_disable;         		// write assist disable
        input wire [1:0] wmce;         		// Write margin control bus.
        input wire [1:0] wpulse;       		// Write pulse duration control bus.

        output reg [TENT-1:0] matchout;		// match out
        output reg qvalid;			   		// valid out
        output reg [DATA-1:0] q;      		// data out

// peri

        logic [ADDR-1:0] adr_b_h;
        logic x_ybar_sel_b_h;
        logic ren_b_h;
	`ifndef INTC_MEM_ip783tcam512x40s0c1_EF_MODE
        logic wen_b_h;
	`endif // INTC_MEM_ip783tcam512x40s0c1_EF_MODE
        logic srchen_b_h;
        logic [DATA-1:0] din_b_h;
        logic [DATA-1:0] dinmask_b_h;
        logic dinvalid_b_h;
        logic dinvalidmask_b_h;

        wire rst_vary;
        wire rst_out;
        wire gclk;
        wire [TENT-1:0] match_out;

		assign  matchout 	= match_out & matchin;
		assign  gclk 	= clk;
		assign	rst_out	= output_reset;
		assign	rst_vary= glbvalidbitrst;

	`ifndef INTC_MEM_ip783tcam512x40s0c1_EF_MODE
        wire wclk;
		always_latch begin	// input B-latch
			if(!gclk) begin
				adr_b_h 			<= adr;
				x_ybar_sel_b_h		<= x_ybar_sel;
				ren_b_h				<= ren;
				wen_b_h				<= wen;
				srchen_b_h			<= srchen;
				din_b_h				<= din;
				dinmask_b_h			<= dinmask;
				dinvalid_b_h		<= dinvalid;
				dinvalidmask_b_h	<= dinvalidmask;
			end
		end
		assign	wclk 	= clk & wen_b_h;
	`endif // INTC_MEM_ip783tcam512x40s0c1_EF_MODE

		ip783tcam512x40s0c1_array ip783tcam512x40s0c1_array (
 		`ifndef INTEL_NO_PWR_PINS
			.vddp(vddp),
 		 `ifdef INTC_ADD_VSS
			.vss(vss),
 		 `endif // INTC_ADD_VSS
 		`endif
			.clk(gclk),
			.wen(wen),
			.ren(ren),
			.srchen(srchen),
			.adr(adr),
			.x_ybar_sel(x_ybar_sel),
			.din(din),
			.dinmask(dinmask),
		`ifdef INTC_MEM_ip783tcam512x40s0c1_EF_MODE
			.dinvalid(dinvalid),
			.dinvalidmask(dinvalidmask),
		`endif // INTC_MEM_ip783tcam512x40s0c1_EF_MODE
		`ifndef INTC_MEM_ip783tcam512x40s0c1_EF_MODE
			.wclk(wclk),
			.ren_b_h(ren_b_h),
			.srchen_b_h(srchen_b_h),
			.adr_b_h(adr_b_h),
			.x_ybar_sel_b_h(x_ybar_sel_b_h),
			.din_b_h(din_b_h),
			.dinmask_b_h(dinmask_b_h),
			.dinvalid_b_h(dinvalid_b_h),
			.dinvalidmask_b_h(dinvalidmask_b_h),
		`endif // INTC_MEM_ip783tcam512x40s0c1_EF_MODE
			.rst_vary(rst_vary),
			.rst_out(rst_out),
			.dout(q),
			.dout_vld(qvalid),
			.match_out(match_out)
		);

		`ifdef INTC_MEM_ip783tcam512x40s0c1_EF_MODE
		`else // INTC_MEM_ip783tcam512x40s0c1_EF_MODE

		task INTC_MEM_INIT;                          // initialize from hex file    // lintra s-60051 s-81061
		   input [2048:0] infile_x;                                                 // lintra s-80095
		   input [2048:0] infile_y;                                                 // lintra s-80095
		   input [2048:0] infile_v;                                                 // lintra s-80095
//		   input [`INTC_MEM_PATH_SIZE*8:0] infile;                                  // lintra s-80095
		   (* synthesis, logic_block *) reg [DATA-1:0] mem_x  [TENT-1:0];
		   (* synthesis, logic_block *) reg [DATA-1:0] mem_y  [TENT-1:0];
		   (* synthesis, logic_block *) reg            mem_v  [TENT-1:0];
		   begin
		      $readmemh(infile_x, mem_x);                                           // lintra s-0831
		      $readmemh(infile_y, mem_y);                                           // lintra s-0831
		      $readmemh(infile_v, mem_v);                                           // lintra s-0831
		      ip783tcam512x40s0c1_array.array_x = mem_x;
		      ip783tcam512x40s0c1_array.array_y = mem_y;
		      ip783tcam512x40s0c1_array.array_v = mem_v;
		   end
		endtask : INTC_MEM_INIT

		`endif // INTC_MEM_ip783tcam512x40s0c1_EF_MODE

endmodule


module ip783tcam512x40s0c1_array (                                          // lintra s-68000 s-70607
    `ifndef INTEL_NO_PWR_PINS
        vddp,
      `ifdef INTC_ADD_VSS
        vss,
      `endif // INTC_ADD_VSS
    `endif // INTEL_NO_PWR_PINS
		clk,
		wen,
		ren,
		srchen,
		adr,
		x_ybar_sel,
		din,
		dinmask,
	`ifdef INTC_MEM_ip783tcam512x40s0c1_EF_MODE
		dinvalid,
		dinvalidmask,
	`endif // INTC_MEM_ip783tcam512x40s0c1_EF_MODE

	`ifndef INTC_MEM_ip783tcam512x40s0c1_EF_MODE
		wclk,
		ren_b_h,
		srchen_b_h,
		adr_b_h,
		x_ybar_sel_b_h,
		din_b_h,
		dinmask_b_h,
		dinvalid_b_h,
		dinvalidmask_b_h,
	`endif // INTC_MEM_ip783tcam512x40s0c1_EF_MODE

		rst_vary,
		rst_out,
		dout,
		dout_vld,
		match_out
);
		localparam int unsigned ADDR = 9;
		localparam int unsigned DATA = 26;
		localparam int unsigned TENT = 512;

    `ifndef INTEL_NO_PWR_PINS
        input wire vddp;               		// lintra s-60010
      `ifdef INTC_ADD_VSS
        inout wire vss;
      `endif // INTC_ADD_VSS
    `endif // INTEL_NO_PWR_PINS
		input wire clk;
		input wire wen;
		input wire ren;
		input wire srchen;
		input wire [ADDR-1:0] adr;
		input wire [DATA-1:0] din;
		input wire [DATA-1:0] dinmask;
	`ifdef INTC_MEM_ip783tcam512x40s0c1_EF_MODE
		input wire dinvalid;
		input wire dinvalidmask;
	`endif // INTC_MEM_ip783tcam512x40s0c1_EF_MODE
		input wire x_ybar_sel;

	`ifndef INTC_MEM_ip783tcam512x40s0c1_EF_MODE
		input wire wclk;
		input wire ren_b_h;
		input wire srchen_b_h;
		input wire [ADDR-1:0] adr_b_h;
		input wire [DATA-1:0] din_b_h;
		input wire [DATA-1:0] dinmask_b_h;
		input wire dinvalid_b_h;
		input wire dinvalidmask_b_h;
		input wire x_ybar_sel_b_h;
	`endif // INTC_MEM_ip783tcam512x40s0c1_EF_MODE

		input wire rst_vary;
		input wire rst_out;
		output reg [DATA-1:0] dout;
		output reg            dout_vld;
		output reg [TENT-1:0] match_out;

// pragma attribute array_x logic_block 1
// pragma attribute array_y logic_block 1
            logic [DATA-1:0] array_m [TENT-1:0]; // scoreboard
            logic [DATA-1:0] array_x [TENT-1:0]; // x-cell array
            logic [DATA-1:0] array_y [TENT-1:0]; // y-cell array
            logic            array_v [TENT-1:0]; // valid array
            logic [TENT-1:0] mout;
            logic [TENT-1:0] vout;
                                    
            //RTLC-1:
	    //Added this function for search
	    //Refactor the original search logic and incorporate in function
            function [DATA-1:0] func_for_search(input [DATA-1:0] dinmask_f, input [DATA-1:0]din_f, input [DATA-1:0]array_x_f, input [DATA-1:0]array_y_f);
                logic [DATA-1:0] array_m_f;
            begin
                for (integer col=0; col<DATA; col++) begin
                    if(dinmask_f[col] == 1) begin
                              array_m_f[col] = 1'b1;
                    end else begin
                        case({array_x_f[col],array_y_f[col],dinmask_f[col],din_f[col]})
                                    4'b0000     :     array_m_f[col] = 1'b1;
                                    4'b0001     :     array_m_f[col] = 1'b1;
//                                  4'b0010     :     array_m[row][col] = 1'b1;
//                                  4'b0011     :     array_m[row][col] = 1'b1;
                              
                              4'b0100     :     array_m_f[col] = 1'b0;
                              4'b0101     :     array_m_f[col] = 1'b1;
//                                  4'b0110     :     array_m[row][col] = 1'b1;
//                                  4'b0111     :     array_m[row][col] = 1'b1;
                              
                              4'b1000     :     array_m_f[col] = 1'b1;
                              4'b1001     :     array_m_f[col] = 1'b0;
//                                  4'b1010     :     array_m[row][col] = 1'b1;
//                                  4'b1011     :     array_m[row][col] = 1'b1;
                              
                              4'b1100     :     array_m_f[col] = 1'b0;
                              4'b1101     :     array_m_f[col] = 1'b0;
//                                  4'b1110     :     array_m[row][col] = 1'b1;
//                                  4'b1111     :     array_m[row][col] = 1'b1;

                                    default :   array_m_f[col] = 1'bx;
                              endcase
                        end
                  end 
            end
            return array_m_f;
            endfunction

      `ifdef INTC_MEM_ip783tcam512x40s0c1_EF_MODE
		// write array : A-phase FF
		always @(posedge clk or posedge rst_vary) begin
			// Reset valid array
			if(rst_vary == 1) begin
				integer vidx;
				for (vidx=0; vidx<TENT; vidx++) begin
					array_v[vidx] <= 1'b0;
				end
			end
			else begin
				if((wen == 1) & (ren == 0) & (srchen == 0) & (rst_vary == 0)) begin
					if ((x_ybar_sel == 1) | (x_ybar_sel == 0)) begin
						integer d;
						// write vaild array
						if(dinvalidmask == 0) begin
							array_v[adr] <= dinvalid;
						end
						// write array
				    // RTLC-2:
                                    if (x_ybar_sel == 1) begin
                                          array_x[adr] <= (din & (~dinmask)) | (dinmask & array_x[adr]);
								end
								else if(x_ybar_sel == 0) begin
                                          array_y[adr] <= (din & (~dinmask)) | (dinmask & array_y[adr]);
								end

                              end
                        end
                  end
            end
      `else // INTC_MEM_ip783tcam512x40s0c1_EF_MODE
            // write array : A-phase Latch
            always @(*) begin
                  // Reset valid array
                  if(rst_vary == 1) begin
                        integer vidx;
                        for (vidx=0; vidx<TENT; vidx++) begin
                              array_v[vidx] <= 1'b0;
                        end
                  end
                  else begin
                        if(wclk == 1) begin
                              if((ren_b_h == 0) & (srchen_b_h == 0) & (rst_vary == 0)) begin
                                    if ((x_ybar_sel_b_h == 1) | (x_ybar_sel_b_h == 0)) begin
                                          integer d;
                                          // write vaild array
                                          if(dinvalidmask_b_h == 0) begin
                                                array_v[adr_b_h] <= dinvalid_b_h;
                                          end
                                          // write array
                                          for (d=0; d<DATA; d++) begin
                                                if(dinmask_b_h[d] == 0) begin
                                                      if     (x_ybar_sel_b_h == 1) begin
                                                            array_x[adr_b_h][d] <= din_b_h[d];
                                                      end
                                                      else if(x_ybar_sel_b_h == 0) begin
                                                            array_y[adr_b_h][d] <= din_b_h[d];
                                                      end
                                                end
                                          end
                                    end
                              end
                        end
                  end
            end
      `endif // INTC_MEM_ip783tcam512x40s0c1_EF_MODE

            always @(posedge clk or posedge rst_out) begin
                  // Reset dout
                  if(rst_out == 1) begin
                        dout <= 26'b0;
                        dout_vld <= 1'b0;
                        match_out <= 512'b0;
                  end
                  else begin
                        // read array : A-phase
                        if((wen == 0) & (ren == 1) & (srchen == 0) & (rst_vary == 0) & (rst_out == 0)) begin
                              if ((x_ybar_sel == 1) | (x_ybar_sel == 0)) begin
                                    dout_vld <= array_v[adr];
                                    if     (x_ybar_sel == 1) begin
                                          dout <= array_x[adr];
                                    end
                                    else if(x_ybar_sel == 0) begin
                                          dout <= array_y[adr];
                                    end
                              end
                        end
                        // match : A-phase
                        if((wen == 0) & (ren == 0) & (srchen == 1) & (rst_vary == 0) & (rst_out == 0)) begin
                              integer row;
                              integer col;
                              for (row=0; row<TENT; row++) begin
				     //RTLC-1
                                    array_m[row] = func_for_search(dinmask, din, array_x[row], array_y[row]);
        

                                    /*
                                    for (col=0; col<DATA; col++) begin
                                          if(dinmask[col] == 1) begin
                                                array_m[row][col] = 1'b1;
                                          end else begin
                                                case({array_x[row][col],array_y[row][col],dinmask[col],din[col]})
                                                      4'b0000     :     array_m[row][col] = 1'b1;
                                                      4'b0001     :     array_m[row][col] = 1'b1;
//                                                    4'b0010     :     array_m[row][col] = 1'b1;
//                                                    4'b0011     :     array_m[row][col] = 1'b1;
                                                
                                                4'b0100     :     array_m[row][col] = 1'b0;
                                                4'b0101     :     array_m[row][col] = 1'b1;
//                                                    4'b0110     :     array_m[row][col] = 1'b1;
//                                                    4'b0111     :     array_m[row][col] = 1'b1;
                                                
                                                4'b1000     :     array_m[row][col] = 1'b1;
                                                4'b1001     :     array_m[row][col] = 1'b0;
//                                                    4'b1010     :     array_m[row][col] = 1'b1;
//                                                    4'b1011     :     array_m[row][col] = 1'b1;
                                                
                                                4'b1100     :     array_m[row][col] = 1'b0;
                                                4'b1101     :     array_m[row][col] = 1'b0;
//                                                    4'b1110     :     array_m[row][col] = 1'b1;
//                                                    4'b1111     :     array_m[row][col] = 1'b1;

                                                      default :   array_m[row][col] = 1'bx;
                                                endcase
                                          end
                                    end 
                                    */
                                    mout[row]         = &array_m[row];
                                    vout[row]         = array_v[row];
                                    match_out[row] <= mout[row] & vout[row];
                              end
                        end
                  end
            end // always
endmodule
`endcelldefine


