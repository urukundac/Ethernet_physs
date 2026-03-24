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

module eth_mem_AW_dcsacram_2r_2w_128x46 (
    input    logic  		 CLKW0
   ,input    logic  		 CLKW1
   ,input    logic  		 CLKR0
   ,input    logic  		 CLKR1
   ,input    logic  [7-1:0] 	 WADDR0
   ,input    logic  [7-1:0] 	 WADDR1
   ,input    logic  [7-1:0] 	 RADDR0
   ,input    logic  [7-1:0] 	 RADDR1
   ,input    logic  [46-1:0] 	 WDATA0
   ,input    logic  [46-1:0] 	 WDATA1
   ,input    logic  		 WE0
   ,input    logic  		 WE1
   ,input    logic  		 RE0
   ,input    logic  		 RE1
   ,input    logic 		 RSTB0
   ,input    logic 		 RSTB1
   ,output   logic  [46-1:0] 	 RDATA0
   ,output   logic  [46-1:0] 	 RDATA1
   ,input    logic  		 isolation_control_in
    ,input logic                     async_rstp0
    ,input logic                     async_rstp1
    ,input  logic                    shutoff
		,input logic shutoffin
    
    ,input logic            fastsleep
    ,input logic            deepsleep
    ,input logic    [1:0]  sbc
    ,input logic [25:0] col_repair_in

    ,output logic            shutoffout
    ,output logic            dpslp_or_shutoffout_0_0
// MEM_WRP_RELATED_IO
   ,input    logic  [8-1:0] 	 HD2PRF_TRIM_FUSE_IN
);

logic async_reset0;
logic async_reset1;
assign async_reset0 = ~RSTB0;
assign async_reset1 = ~RSTB1;

`ifdef INTEL_FPGA
 assign RDATA0 = 'b0;
 assign RDATA1 = 'b0;
`elsif INTEL_EMULATION
assign RDATA0 = 'b0;
assign RDATA1 = 'b0;
`else
/*`ifndef INTEL_EMULATION*/
/*`ifndef INTEL_FPGA*/


logic  [46-1:0]  b_dout0;
logic  [46-1:0]  b_dout1;

//*******************************************************************
// Hook up ASIC SINGLE MEM RF 
//*******************************************************************

eth_ip783rfhs2r2w128x46s0c1p3d0_mem_wrapper i_rf_128x46_b0 (

   .clkwrp0 		 (CLKW0) 		//I:
  ,.clkwrp1 		 (CLKW1) 		//I:
  ,.clkrdp0 		 (CLKR0) 		//I:
  ,.clkrdp1 		 (CLKR1) 		//I:

`ifndef INTEL_NO_PWR_PINS
    ,.vddp 		 ('1) 			//I: vddp voltage
  `ifdef INTC_ADD_VSS
      ,.vss 		 ('0) 			//I: vss voltage
  `endif
`endif

  ,.wradrp0 		 (WADDR0) 		//I:
  ,.wradrp1 		 (WADDR1) 		//I:
  ,.rdadrp0 		 (RADDR0) 		//I:
  ,.rdadrp1 		 (RADDR1) 		//I:
  ,.renp0 		 (RE0) 			//I:
  ,.renp1 		 (RE1) 			//I:
  ,.wenp0 		 (WE0) 			//I:
  ,.wenp1 		 (WE1) 			//I:
  ,.dinp0 		 (WDATA0) 		//I:
  ,.dinp1 		 (WDATA1) 		//I:


  ,.qp0 		 (b_dout0) 		//O:
  ,.qp1 		 (b_dout1) 		//O:

  ,.stbyp		 (HD2PRF_TRIM_FUSE_IN[0]) 			//I:
  ,.mce			 (HD2PRF_TRIM_FUSE_IN[1]) 			//I:
  ,.rmce		 (HD2PRF_TRIM_FUSE_IN[4:2]) 			//I:
  ,.wmce		 (HD2PRF_TRIM_FUSE_IN[7:5]) 			//I:
  ,.async_rstp0 	 (async_reset0) 		//I:
  ,.async_rstp1 	 (async_reset1) 		//I:
  ,.isolation_control_in (isolation_control_in) 		//I:
  ,.fastsleep(fastsleep)
  ,.deepsleep(deepsleep)
  ,.sbc(2'b0)
  ,.col_repair_in(12'b0)
  ,.shutoff(shutoff)
  ,.shutoffout(shutoffout)
  ,.dpslp_or_shutoffout(dpslp_or_shutoffout_0_0)
);

  assign RDATA0 = b_dout0;
  assign RDATA1 = b_dout1;
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

logic  [46-1:0]  b_dout;

fpgamem_top #(
     .ADDR_WD (7)
    ,.DATA_WD (46)
    ,.WR_RD_SIMULT_DATA (0)

  ) i_fpgamem_top_128x46 (

     .ckwr 	 (CLKW)
    ,.ckrd 	 (CLKR)
    ,.wr 	 (WE)
    ,.wrptr 	 (WADDR[7-1:0])
    ,.datain 	 (WDATA[46-1:0])
    ,.rstb 	 (RSTB)
    ,.rd 	 (RE)
    ,.rdptr 	 (RADDR[7-1:0])
    ,.dataout 	 (b_dout[46-1:0])
  );

assign RDATA = b_dout;

// INTEL_FPGAMEM else
`else


logic	[46-1:0]	b_dout;

//*******************************************************************
// Hook up FLOP ARRAY

logic 	[46-1:0]  	 MEM[128-1:0];

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
