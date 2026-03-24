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

/*
 --------------------------------------------------------------------------
 -- Project Code      : IMPrES
 -- Module Name       : IW_fpga_avst2logger
 -- Author            : Gregory James
 -- Associated modules: 
 -- Function          : This module is an Avalon-ST sink that will bridge
                        to the dbg-logger network.
 --------------------------------------------------------------------------
*/

`timescale 1ns / 10ps


module IW_fpga_avst2logger #(
    parameter AVST_SYMBOL_W       = 8
  , parameter AVST_DATA_W         = 8
  , parameter AVST_USE_BIG_ENDIAN = 1

  , parameter AVMM_DATA_W         = 256
  , parameter AVMM_ADDR_W         = 26
  , parameter AVMM_BURST_W        = 1

  , parameter MAX_MEM_PARTITIONS  = 1

  /*  Do Not Modify */
  , parameter AVST_NUM_SYMBOLS_PER_FLIT = AVST_DATA_W / AVST_SYMBOL_W
  , parameter AVST_EMPTY_W              = (AVST_NUM_SYMBOLS_PER_FLIT  <=  1)  ? 1 : $clog2(AVST_NUM_SYMBOLS_PER_FLIT)
) (

    input   logic                           clk
  , input   logic                           rst_n

  /*  Avalon-ST */
  , output  logic                           avst_ready
  , input   logic                           avst_valid
  , input   logic                           avst_startofpacket
  , input   logic                           avst_endofpacket
  , input   logic [AVST_DATA_W-1:0]         avst_data
  , input   logic [AVST_EMPTY_W-1:0]        avst_empty

  /*  Queue Manager */
  , input   logic [AVMM_ADDR_W-1:0]         queue_wptr_arry [MAX_MEM_PARTITIONS-1:0]
  , input   logic [MAX_MEM_PARTITIONS-1:0]  queue_wr_full
  , output  logic [MAX_MEM_PARTITIONS-1:0]  queue_wr_valid

  /*  Avalon-MM */
  , input   logic                           avmm_waitrequest
  , input   logic [AVMM_DATA_W-1:0]         avmm_readdata
  , input   logic                           avmm_readdatavalid
  , output  logic [AVMM_BURST_W-1:0]        avmm_burstcount
  , output  logic [AVMM_DATA_W-1:0]         avmm_writedata
  , output  logic [AVMM_ADDR_W-1:0]         avmm_address
  , output  logic                           avmm_write
  , output  logic                           avmm_read
  , output  logic [(AVMM_DATA_W/8)-1:0]     avmm_byteenable

);

  /*  Internal  User-Defined Types  */
  typedef struct  packed  {
    logic [15:0]  reserved;
    logic [7:0]   num_bytes;
    logic [7:0]   qidx;
  } avst_pkt_hdr_t;


  /*  Internal  Parameters  */
  localparam  AVST_DATA_PTR_W               = 16;
  localparam  AVST_NUM_BYTES_PER_FLIT       = AVST_DATA_W / 8;
  localparam  AVST_DATA_BYTES_SHIFT_BITS    = $clog2(AVST_NUM_BYTES_PER_FLIT);
  localparam  AVST_DATA_PTR_BYTES_W         = AVST_DATA_PTR_W + AVST_DATA_BYTES_SHIFT_BITS;

  localparam  AVMM_DATA_BYTES               = AVMM_DATA_W / 8;


  /*  Internal  Signals */
  genvar  i;
  logic [AVST_DATA_W-1:0]           avst_data_ordered;
  logic [AVST_DATA_PTR_W-1:0]       avst_data_ptr_f;
  logic [AVST_DATA_PTR_BYTES_W-1:0] avst_data_ptr_bytes_w;
  avst_pkt_hdr_t                    avst_pkt_hdr_nxt;
  avst_pkt_hdr_t                    avst_pkt_hdr_f;
  logic                             avst_pkt_hdr_valid;

  logic                             avmm_writedata_rdy;
  enum logic [2:0] { IDLE=3'b001, GET_ADDRESS= 3'b010,
                     GEN_WRITE=3'b100} state;

//----------------------- Start of Code -----------------------------------

  /*  Order the AV-ST Data  */
  generate
    if(AVST_USE_BIG_ENDIAN)  //Reverse the symbols
    begin
      for(i=0;i<AVST_NUM_SYMBOLS_PER_FLIT;i++)
      begin
        assign  avst_data_ordered[(i*AVST_SYMBOL_W) +:  AVST_SYMBOL_W]  = avst_data[(AVST_DATA_W-(i*AVST_SYMBOL_W)-1) -:  AVST_SYMBOL_W];
      end
    end
    else
    begin
      assign  avst_data_ordered = avst_data;
    end
  endgenerate

  if(AVST_DATA_W == AVMM_DATA_W)
  begin
    /*  State machine to handle single beats */
    always @(posedge clk, negedge rst_n)
    begin
      if(~rst_n)
      begin
        state <= IDLE; 
      end
      else
      begin
        case (state)
          IDLE:
            state <= (avst_startofpacket & avst_endofpacket & avst_ready & avst_valid) ? GET_ADDRESS : IDLE;
          GET_ADDRESS:
            state <= GEN_WRITE;
          GEN_WRITE :
            state <= ~avmm_waitrequest ? IDLE : GEN_WRITE;
        endcase
      end
    end
  end

  always@(posedge clk, negedge rst_n)
  begin
    if(~rst_n)
    begin
      avmm_address            <=  0;
      avmm_write              <=  0;
      avst_data_ptr_f         <=  0;
      avst_pkt_hdr_f          <=  0;
    end
    else // rst_n
    begin
      avst_data_ptr_f       <=  avst_endofpacket  ? 0 : avst_data_ptr_f + 1'b1;
      //Latch the header when ready
      avst_pkt_hdr_f          <=  avst_pkt_hdr_valid  ? avst_pkt_hdr_nxt  : avst_pkt_hdr_f;

      //Get the next write address for the right queue
      avmm_address            <=  queue_wptr_arry[avst_pkt_hdr_f.qidx];

      if ( AVST_DATA_W == AVMM_DATA_W )
      begin
        if(avmm_writedata_rdy)
          avmm_write <= 1'b1;
        else
          if(state == GEN_WRITE && ~avmm_waitrequest)
            avmm_write <= 1'b0;
      end
      else //  AVST_DATA_W != AVMM_DATA_W 
      begin
        //Write-en Logic
        if(avmm_write)  //Wait for ready
        begin
          avmm_write            <=  avmm_waitrequest  ? avmm_write  : 1'b0;
        end
        else  //Wait for the right time to write
        begin
          if(avst_ready & avst_valid  & (avst_endofpacket | avmm_writedata_rdy) & ~queue_wr_full[avst_pkt_hdr_f.qidx])
          begin
            avmm_write          <=  1'b1;
          end
          else
          begin
            avmm_write          <=  avmm_write;
          end
        end
      end

    end // rst
  end // always

  if ( AVST_DATA_W == AVMM_DATA_W )
  begin
    always@(posedge clk, negedge rst_n)
    begin
      if(~rst_n)
      begin
        avmm_writedata          <=  0;
      end
      else // rst_n
      begin
      //Shift in the AV-ST data & update data-pointer
        if(avst_ready & avst_valid)
        begin
          for(int i=0 ; i < 16; i++)
            for(int j=0; j < 4; j++)
              avmm_writedata[(i*32)+(j*8) +: 8]        <=  avst_data[(i*32)+(32 - (j*8) - 1) -: 8];
        end
      end // rst
    end // always
  end
  else
  begin
    always@(posedge clk, negedge rst_n)
    begin
      if(~rst_n)
      begin
        avmm_writedata          <=  0;
      end
      else // rst_n
      begin
      //Shift in the AV-ST data & update data-pointer
        if(avst_ready & avst_valid)
        begin
          avmm_writedata        <=  {avst_data_ordered,avmm_writedata[AVMM_DATA_W-1:AVST_DATA_W]};
        end
      end // rst
    end // always
  end

  /* Generation of avst_ready
     In single beat condition, ready is asserted only during idle state 
  */
  if ( AVST_DATA_W == AVMM_DATA_W )
    assign avst_ready = (state == IDLE) ? 1'b1 : 1'b0;
  else
    /*  avst_ready generation */
    always@(posedge clk,  negedge rst_n)
    begin
      if(~rst_n)
        avst_ready              <=  1'b1;
      else
      begin
        //Write-en Logic
        if(avmm_write)  //Wait for ready
          avst_ready            <=  ~avmm_waitrequest;
        else  //Wait for the right time to write
        begin
          if(avst_ready & avst_valid  & (avst_endofpacket | avmm_writedata_rdy) & ~queue_wr_full[avst_pkt_hdr_f.qidx])
            avst_ready          <=  1'b0; //pre-emptive stall of Avalon-ST bus
          else
            avst_ready          <=  1'b1;
        end
      end
    end

  //All bytes are valid
  assign  avmm_byteenable       = {(AVMM_DATA_W/8){1'b1}};

  //Burst Count fixed to 1
  assign  avmm_burstcount       = 1;

  //Read is disabled
  assign  avmm_read             = 1'b0;
  if ( AVST_DATA_W == AVMM_DATA_W )
  begin
    always_comb begin
      if(avst_pkt_hdr_valid) begin
        avst_pkt_hdr_nxt.reserved   = avst_data[15:0];
        avst_pkt_hdr_nxt.num_bytes  = avst_data[23:16];
        avst_pkt_hdr_nxt.qidx       = avst_data[31:24];
      end else
        avst_pkt_hdr_nxt   = {default: 1'b0};
    end
  
    always_comb begin
      if(avst_startofpacket & avst_endofpacket & avst_ready & avst_valid)
        avst_pkt_hdr_valid = 1'b1;
      else
        avst_pkt_hdr_valid = 1'b0;
    end
    assign  avmm_writedata_rdy  = (state == GET_ADDRESS && ~queue_wr_full[avst_pkt_hdr_f.qidx]) ? 1'b1  : 1'b0;
  end
  else
  begin
    //Decode the packet header fields
    assign  avst_pkt_hdr_nxt          = avmm_writedata[AVMM_DATA_W-1  -:  $bits(avst_pkt_hdr_t)];
  
    //Convert avst_data_ptr_f to bytes
    assign  avst_data_ptr_bytes_w = {avst_data_ptr_f,{AVST_DATA_BYTES_SHIFT_BITS{1'b0}}};
  
  
    /*  Calculate when the pkt-header is valid  */
      if(AVST_DATA_W  >=  $bits(avst_pkt_hdr_t))  //The header will be vailable in the first flit
      begin
        assign  avst_pkt_hdr_valid  = (avst_data_ptr_f  ==  1)  ? 1'b1  : 1'b0;
      end
      else
      begin
        assign  avst_pkt_hdr_valid  = ({avst_data_ptr_bytes_w,{3{1'b0}}}  ==  $bits(avst_pkt_hdr_t))  ? 1'b1  : 1'b0;
      end
  
    //Calculate when enough data has been shifted in
    assign  avmm_writedata_rdy  = ((avst_data_ptr_bytes_w - ($bits(avst_pkt_hdr_t)/8))  ==  (AVMM_DATA_BYTES  - AVST_NUM_BYTES_PER_FLIT)) ? 1'b1  : 1'b0;
  end

  //Update the Queue when write is done
  always@(*)
  begin
    queue_wr_valid  = {MAX_MEM_PARTITIONS{1'b0}};

    queue_wr_valid[avst_pkt_hdr_f.qidx] = avmm_write  & ~avmm_waitrequest;
  end

endmodule // IW_fpga_avst2logger
