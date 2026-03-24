// ***********************************************************************
// * AGERE CONFIDENTIAL                                                  *
// *                         PROPRIETARY NOTE                            *
// *                                                                     *
// *  This software contains information confidential and proprietary    *
// *  to Agere Corporation.  It shall not be reproduced in whole or in   *
// *  part, or transferred to other documents, or disclosed to third     *
// *  parties, or used for any purpose other than that for which it was  *
// *  obtained, without the prior written consent of Agere Corporation.  *
// *  (c) 1999, Agere Corporation.  All rights reserved.                 *
// *                                                                     *
// ***********************************************************************

// ***********************************************************************
// *               Verilog Behavioral Model File                         *
// ***********************************************************************

// ***********************************************************************
// * File:      $RCSfile: IW_ddr_obuf_combo.sv.rca $
// * Version:   $Revision: 1.1.1.1 $
// * Engineer:  Dave Brown
// * Date:      $Date: Tue Jan 22 18:41:06 2013 $
// *
// * Description:
// *    This module generates the chip-wide resets for all clock zones
// *    
// verilint 396 off  // A flipflop without an asynchronous reset
// verilint 530 off  // A flipflop is inferred
// verilint 549 off  // Asynchronous flipflop is inferred
// verilint 446 off  // Reading from an output port
// verilint 594 off  // Not all cases covered in case, but default case exists
// verilint 551 off  // full_case has a default clause
// verilint 488 off  // Bus variable in sensitivity list but not all bits used
// verilint 631 off  // Assigning to self. This is harmless can reduce sim speed
// verilint 498 off  // Not all the bits of the vector are used
// *    
// *
// ***********************************************************************
// ***********************************************************************
// * Revision Log (see bottom of file)
// ***********************************************************************

module IW_ddr_obuf_combo #(
        parameter FPGA_FAMILY = "S5"     //S10 for Stratix10, S5 for Stratix5
) (
   IO_DATA_OUT,
   D1,
   D2,
   rst,
   clk
   );  

    input         clk;
    input         rst;
    input         D1;
    input         D2;
    inout         IO_DATA_OUT;

    wire      data_out;

// DB IOBUF  obuf_u0 (.I(data_out),.IO(IO_DATA_OUT),.O(),.T(1'b0));

// ODDR: Output Double Data Rate Output Register with Set, Reset
// and Clock Enable.
// Virtex-4/5
// Xilinx HDL Libraries Guide, version 9.1i
ODDR #(
.DDR_CLK_EDGE("OPPOSITE_EDGE"), // "OPPOSITE_EDGE" or "SAME_EDGE"
.INIT(1'b0),                    // Initial value of Q: 1'b0 or 1'b1
.SRTYPE("SYNC"),                // Set/Reset type: "SYNC" or "ASYNC"
.FPGA_FAMILY(FPGA_FAMILY) 
) ODDR_inst (
// DB .Q(data_out),   // 1-bit DDR output
.Q(IO_DATA_OUT),   // 1-bit DDR output
.C(clk),        // 1-bit clock input
.CE(1'b1),      // 1-bit clock enable input
.D1(D1),        // 1-bit data input (positive edge)
.D2(D2),        // 1-bit data input (negative edge)
.R(rst),        // 1-bit reset
.S(1'b0)        // 1-bit set
);

endmodule
