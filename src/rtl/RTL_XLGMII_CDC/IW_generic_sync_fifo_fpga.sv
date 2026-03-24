//----------------------------------------------------------------------------------------------------------------
//                               INTEL CONFIDENTIAL
//           Copyright 2013-2014 Intel Corporation All Rights Reserved. 
// 
// The source code contained or described herein and all documents related to the source code ("Material")
// are owned by Intel Corporation or its suppliers or licensors. Title to the Material remains with Intel
// Corporation or its suppliers and licensors. The Material contains trade secrets and proprietary and confidential
// information of Intel or its suppliers and licensors. The Material is protected by worldwide copyright and trade
// secret laws and treaty provisions. No part of the Material may be used, copied, reproduced, modified, published,
// uploaded, posted, transmitted, distributed, or disclosed in any way without Intel's prior express written
// permission.
// 
// No license under any patent, copyright, trade secret or other intellectual property right is granted to or
// conferred upon you by disclosure or delivery of the Materials, either expressly, by implication, inducement,
// estoppel or otherwise. Any license under such intellectual property rights must be express and approved by
// Intel in writing.
//----------------------------------------------------------------------------------------------------------------
// Version and Release Control Information:
//
// File Name:     $RCSfile: IW_generic_sync_fifo.sv.rca $
// File Revision: $Revision: 1.3 $
// Created by:    Gregory James
// Updated by:    $Author: gjames $ $Date: Wed Feb 24 00:05:54 2016 $
//----------------------------------------------------------------------------------------------------------------------
// File Description: Generic synchronous FIFO. FIFO size programmed using the Parameter. For use in Altera FPGA because of Mixed-Port RDW workaround
//                   Size of 1 to N is possible
//
//----------------------------------------------------------------------------------------------------------------------

`timescale 1ns/10ps

module IW_generic_sync_fifo_fpga
  (
  // inputs
  clk,
  rst_n,
   
  clear_fifo,
  data_in,
  shiftin,
  shiftout,
  
  // outputs
  occp,
  dout,
  empty,
  full,
  half_full,
  half_empty,
  overflow,
  undflow 
  );

//----------------------------------------------------------------------------------------------------------------------
// Parameters
//----------------------------------------------------------------------------------------------------------------------
    parameter MAX_DEPTH = 5'h10;                // FIFO DEPTH
    parameter AWIDTH  = 3'h4;                   // Adrress width
    parameter DWIDTH = 4'hb;                    // Data Width
    parameter THRSHLD = MAX_DEPTH/2;            // Half threshold

//----------------------------------------------------------------------------------------------------------------------
// Input declarations                           ^
//----------------------------------------------------------------------------------------------------------------------
    input               clk;                    // clock
    input               rst_n;                  // Reset
    input               clear_fifo;             // Clear or flush FIFO
    input  [DWIDTH-1:0] data_in;                // Input FIFO data
    input               shiftin;                // Shift/load data in
    input               shiftout;               // Shift/read data out

//----------------------------------------------------------------------------------------------------------------------
// Output declarations                          ^
//----------------------------------------------------------------------------------------------------------------------
    output [DWIDTH-1:0] dout;                   // FIFO output data
    output [AWIDTH  :0] occp;                   // FIFO occupancy
    output              full;                   // Full flag
    output              half_full;              // Half full flag > size/2
    output              half_empty;             // Half empty flag < size/2
    output              empty;                  // Empty flag
    output              overflow;               // Overflow flag
    output              undflow;                // Underflow flag

//----------------------------------------------------------------------------------------------------------------------
// Wire declarations                            ^
//----------------------------------------------------------------------------------------------------------------------
   wire    [DWIDTH-1:0] dout;                   // FIFO output data
   wire    [DWIDTH-1:0] data_out;               // Data out from RA
   wire                 ra_wr;                  // write gen to RA
   wire                 full;                   // Full flag
   wire                 half_full;              // Half full flag
   wire                 half_empty;             // Half empty flag
   wire                 empty;                  // Empty flag
   logic   [AWIDTH-1:0] rd_ptr_update;
//----------------------------------------------------------------------------------------------------------------------
// Registers declarations                       ^
//----------------------------------------------------------------------------------------------------------------------
    reg                 overflow;               // Overflow flag multi word
    reg                 undflow;                // Underflow flag multi word
    reg    [AWIDTH-1:0] wr_ptr;                 // FIFO write pointer
    reg    [AWIDTH-1:0] rd_ptr;                 // FIFO read pointer
    reg    [AWIDTH  :0] occp;                   // FIFO occupancy

//----------------------------------------------------------------------------------------------------------------------
// Combinational Logic:
//----------------------------------------------------------------------------------------------------------------------
             // FIFO status flags
    assign empty      =  ( occp == 0 );
    assign half_full  =  ( occp >  THRSHLD );
    assign half_empty =  ( occp <= THRSHLD );
    assign full       =  ( occp == MAX_DEPTH);

    assign dout       = ( ~empty ) ?  data_out[DWIDTH-1:0]  : {DWIDTH{1'b0}};
//----------------------------------------------------------------------------------------------------------------------
// Sequential Logic:
//----------------------------------------------------------------------------------------------------------------------

    //------------------------------------------------------------------------------------------------------------------
    // Data out & FIFO status flags
    //------------------------------------------------------------------------------------------------------------------
    always @( negedge rst_n or posedge clk ) begin
        if ( ~rst_n ) begin
            undflow     <= 1'b0;
            overflow    <= 1'b0;
        end

        else begin
            if ( empty & shiftout )
               undflow    <= 1'b1;
            else 
               undflow    <= 1'b0;
   
            // set overflow flag when fifo is full and write happens
            // without read
            if ( (occp == MAX_DEPTH) & shiftin & !shiftout )
               overflow    <= 1'b1;
            else 
               overflow    <= 1'b0;

        end // else begin
    end // always
    
    //--------------------------------------------------------------------------------------------------
    // If it is a multi word FIFO then instance FIFO RAM and pointer logic
    //--------------------------------------------------------------------------------------------------
    
     // Normal shiftin write and also write when both occurs
    assign ra_wr = shiftin & (( occp != MAX_DEPTH ) | shiftout);


    always @( negedge rst_n or posedge clk ) begin
        if ( ~rst_n ) begin
            wr_ptr        <= {AWIDTH{1'b0}};
            rd_ptr        <= {AWIDTH{1'b0}};
            occp          <= {AWIDTH{1'b0}};
        end

        else  begin
            if ( clear_fifo ) begin                 // Synchrnous clear. brings fifo to inital condition
                wr_ptr        <= {AWIDTH{1'b0}};
                rd_ptr        <= {AWIDTH{1'b0}};
                occp          <= {AWIDTH{1'b0}};
            end
            // FIFO works on occupancy counter. Increment while shiftin , decrements
            // in shiftout & no change when both occurs
            else begin
                case ({shiftin,shiftout}) 
                    //--------------------------------------------------------------------------------------------------
                    // shiftin and shiftout occur at same clock
                    //--------------------------------------------------------------------------------------------------
                    2'b11: begin
                      if ((wr_ptr[AWIDTH-1:0]) == MAX_DEPTH -1)
                        wr_ptr       <= 1'b0;
                      else  
                        wr_ptr       <= wr_ptr[AWIDTH-1:0] + 1'b1;
                       
                        // Increment rd pointer when fifo not empty
                       if (( rd_ptr[AWIDTH-1:0] == MAX_DEPTH -1 ) && (occp != 0))
                          rd_ptr <= 1'b0;
                       else  if (occp != 0)
                          rd_ptr       <= rd_ptr[AWIDTH-1:0] + 1'b1;

                        // Shiftin & out happens same time with fifo empty
                        // allow write and increment occp
                        if (occp == 0)
                            occp         <= occp[AWIDTH:0] + 1'b1;
                          
                    end // 2'b11:

                    //--------------------------------------------------------------------------------------------------
                    // shiftin only
                    //--------------------------------------------------------------------------------------------------
                    2'b10: begin
                        if (((wr_ptr[AWIDTH-1:0]) == MAX_DEPTH -1) && (occp != MAX_DEPTH) ) begin
                           wr_ptr       <= 1'b0;
                           occp         <= occp[AWIDTH:0] + 1'b1;
                        end   
                        else begin 
                           if ( occp != MAX_DEPTH ) begin
                               wr_ptr       <= wr_ptr[AWIDTH-1:0] + 1'b1;
                               occp         <= occp[AWIDTH:0] + 1'b1;
                           end
                        end

                    end // 2'b10:

                    //--------------------------------------------------------------------------------------------------
                    // shiftout only
                    //--------------------------------------------------------------------------------------------------
                    2'b01: begin
                        if (( rd_ptr[AWIDTH-1:0] == MAX_DEPTH -1 ) && (occp != 0)) begin
                             rd_ptr <= 1'b0;
                             occp         <= occp[AWIDTH:0] - 1'b1;
                        end     
                        else begin
                           if ( occp != 0 ) begin
                               rd_ptr       <= rd_ptr[AWIDTH-1:0] + 1'b1;
                               occp         <= occp[AWIDTH:0] - 1'b1;
                           end // else begin
                        end   

                    end // 2'b01:

                    default: begin
                        wr_ptr        <= wr_ptr[AWIDTH-1:0];
                        rd_ptr        <= rd_ptr[AWIDTH-1:0];
                        occp          <= occp[AWIDTH:0];
                    end

                endcase

            end // else begin

        end // else begin
    end // always

// Advanced Read to enable Fall through
  always_comb begin
    if(shiftout && occp != 0) begin
      if(rd_ptr[AWIDTH-1:0] == MAX_DEPTH - 1)
        rd_ptr_update <= 1'b0;
      else
        rd_ptr_update <= rd_ptr + 1'b1;
    end else
      rd_ptr_update <= rd_ptr;
  end
    //--------------------------------------------------------------------------------------------------
    // Fifo RAM Instance
    //--------------------------------------------------------------------------------------------------
fpgamem   u_fifo_mem (
          .ckwr    (clk),
          .ckrd    (clk),
          .wr      (ra_wr),
          .wrptr   (wr_ptr),
          .datain  (data_in),
          .rd      (1'b1),
          .rdptr   (rd_ptr_update),
          .dataout (data_out));
       defparam
          u_fifo_mem.ADDR_WD = AWIDTH,
          u_fifo_mem.DATA_WD = DWIDTH,
          u_fifo_mem.WR_RD_SIMULT_DATA = 1 ;

endmodule
