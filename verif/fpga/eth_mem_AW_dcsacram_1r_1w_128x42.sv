//-----------------------------------------------------------------------------------------------------
//
// INTEL CONFIDENTIAL
//
// Copyright 2019 - 2023 Intel Corporation All Rights Reserved.
//
// The source code contained or described herein and all documents related
// to the source code ("Material") are owned by Intel Corporation
// or its suppliers or licensors. Title to the Material remains with Intel
// Corporation or its suppliers and licensors. The Material contains trade
// secrets and proprietary and confidential information of Intel or its
// suppliers and licensors. The Material is protected by worldwide copyright
// and trade secret laws and treaty provisions. No part of the Material may
// be used, copied, reproduced, modified, published, uploaded, posted,
// transmitted, distributed, or disclosed in any way without Intel's prior
// express written permission.
//
// No license under any patent, copyright, trade secret or other intellectual
// property right is granted to or conferred upon you by disclosure or
// delivery of the Materials, either expressly, by implication, inducement,
// estoppel or otherwise. Any license under such intellectual property rights
// must be express and approved by Intel in writing.
//
//-----------------------------------------------------------------------------------------------------
//-----------------------------------------------------------------------------------------------------
//
// eth_physs mem memory wrapper generator version: intel18A_rf_2.11
//
//-----------------------------------------------------------------------------------------------------

module eth_mem_AW_dcsacram_1r_1w_128x42 (
    input    logic  		 CLKW
   ,input    logic  		 CLKR
   ,input    logic  		 isolation_control_in
   ,input    logic  		 [1:0] global_rrow_en_in_wr
   ,input    logic  		 [1:0] global_rrow_en_in_rd
   ,input    logic  		 [25:0] col_repair_in
   ,input    logic  		 [25:0] row_repair_in
   ,input    logic  [7-1:0] 	 WADDR
   ,input    logic  [7-1:0] 	 RADDR
   ,input    logic  [42-1:0] 	 WDATA
   ,input    logic  		 WE
   ,input    logic  		 RE
   ,input    logic 		 RSTB
   ,output   logic  [42-1:0] 	 RDATA
    ,input logic fastsleep
    ,input logic deepsleep
    ,input logic [1:0] sbc                                    // sleep mode bias
    ,input logic shutoff// power switch enable input
		,input logic shutoffin
    ,output logic shutoffout                                  // power switch enable output
    ,output logic dpslp_or_shutoffout_0_0                        // deep sleep enable output
// MEM_WRP_RELATED_IO
   ,input    logic  [6-1:0] 	 HD2PRF_TRIM_FUSE_IN
);


logic async_reset;
assign async_reset = ~RSTB;

`ifdef INTEL_FPGA
 assign RDATA = 'b0;
`elsif INTEL_EMULATION
assign RDATA = 'b0;
`else
/*`ifndef INTEL_EMULATION*/
/*`ifndef INTEL_FPGA*/


logic  [42-1:0]  b_dout;

//*******************************************************************
// Hook up ASIC SINGLE MEM RF 
//*******************************************************************

eth_ip783hd2prf128x42s0c1r1p3d0v0_mem_wrapper i_rf_128x42_b0 (

   .clkwrp0 		 (CLKW) 		//I:
  ,.clkrdp0 		 (CLKR) 		//I:

`ifndef INTEL_NO_PWR_PINS
    ,.vddp 		 ('1) 			//I: vddp voltage
  `ifdef INTC_ADD_VSS
      ,.vss 		 ('0) 			//I: vss voltage
  `endif
`endif

  ,.wradrp0 		 (WADDR) 		//I:
  ,.rdadrp0 		 (RADDR) 		//I:
  ,.renp0 		 (RE) 			//I:
  ,.wenp0 		 (WE) 			//I:
  ,.dinp0 		 (WDATA) 		//I:


  ,.qp0 		 (b_dout) 		//O:

  ,.stbyp		 (HD2PRF_TRIM_FUSE_IN[0]) 			//I:
  ,.mce			 (HD2PRF_TRIM_FUSE_IN[1]) 			//I:
  ,.rmce		 (HD2PRF_TRIM_FUSE_IN[3:2]) 			//I:
  ,.wmce		 (HD2PRF_TRIM_FUSE_IN[5:4]) 			//I:
  ,.async_resetp0 	 (async_reset) 		//I:
  ,.isolation_control_in (isolation_control_in) 		//I:
  ,.global_rrow_en_in_wr 		 (2'b0) 			//I:
  ,.global_rrow_en_in_rd 		 (2'b0) 			//I:
  ,.col_repair_in 	 (26'b0) 			//I:
  ,.row_repair_in 	 (26'b0) 			//I:
  ,.fastsleep(fastsleep)
  ,.deepsleep(deepsleep)
  ,.sbc(sbc)
  ,.shutoff(shutoff)
  ,.shutoffout(shutoffout)
  ,.dpslp_or_shutoffout(dpslp_or_shutoffout_0_0)
);


  assign RDATA = b_dout;

`endif


// INTEL_FPGA ifndef endif
/*`endif*/
// INTEL_EMULATION ifndef endif
/*`endif*/


//*******************************************************************
// Hook up FPGA Implementations
//*******************************************************************

/*`ifdef INTEL_FPGA

`ifdef INTEL_FPGAMEM

//*******************************************************************
// Hook up FPGAMEM 

logic  [42-1:0]  b_dout;

fpgamem_top #(
     .ADDR_WD (7)
    ,.DATA_WD (42)
    ,.WR_RD_SIMULT_DATA (0)

  ) i_fpgamem_top_128x42 (

     .ckwr 	 (CLKW)
    ,.ckrd 	 (CLKR)
    ,.wr 	 (WE)
    ,.wrptr 	 (WADDR[7-1:0])
    ,.datain 	 (WDATA[42-1:0])
    ,.rstb 	 (RSTB)
    ,.rd 	 (RE)
    ,.rdptr 	 (RADDR[7-1:0])
    ,.dataout 	 (b_dout[42-1:0])
  );

assign RDATA = b_dout;

// INTEL_FPGAMEM else
`else


logic	[42-1:0]	b_dout;

//*******************************************************************
// Hook up FLOP ARRAY

logic 	[42-1:0]  	 MEM[128-1:0];

always_ff @(posedge CLKR)
  begin: dcsacram_mem_array_rd
    if (RE) b_dout <= MEM[RADDR];
  end

always_ff @(posedge CLKW)
  begin: dcsacram_mem_array_wr
    if (WE) MEM[WADDR] <= WDATA;
  end

assign     RDATA =  b_dout;

// INTEL_FPGAMEM endif
`endif



// INTEL_FPGA ifdef endif
`endif*/


endmodule
