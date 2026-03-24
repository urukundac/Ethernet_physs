// (C) 2001-2020 Intel Corporation. All rights reserved.
// Your use of Intel Corporation's design tools, logic functions and other 
// software and tools, and its AMPP partner logic functions, and any output 
// files from any of the foregoing (including device programming or simulation 
// files), and any associated documentation or information are expressly subject 
// to the terms and conditions of the Intel Program License Subscription 
// Agreement, Intel FPGA IP License Agreement, or other applicable 
// license agreement, including, without limitation, that your use is for the 
// sole purpose of programming logic devices manufactured by Intel and sold by 
// Intel or its authorized distributors.  Please refer to the applicable 
// agreement for further details.



// Your use of Altera Corporation's design tools, logic functions and other 
// software and tools, and its AMPP partner logic functions, and any output 
// files any of the foregoing (including device programming or simulation 
// files), and any associated documentation or information are expressly subject 
// to the terms and conditions of the Altera Program License Subscription 
// Agreement, Altera MegaCore Function License Agreement, or other applicable 
// license agreement, including, without limitation, that your use is for the 
// sole purpose of programming logic devices manufactured by Altera and sold by 
// Altera or its authorized distributors.  Please refer to the applicable 
// agreement for further details.


// $Id: //acds/rel/20.3/ip/merlin/altera_merlin_router/altera_merlin_router.sv.terp#1 $
// $Revision: #1 $
// $Date: 2020/07/29 $

// -------------------------------------------------------
// Merlin Router
//
// Asserts the appropriate one-hot encoded channel based on 
// the address.
//
// Also sets the binary-encoded destination id.
// -------------------------------------------------------

`timescale 1 ns / 1 ns

// ------------------------------------------
// Generation parameters:
//    decoder_type            0 (address decoder)
//    default_channel         1
//    default_destid          1
//    default_rd_channel      -1
//    default_wr_channel      -1
//    has_default_slave       1
//    memory_aliasing_decode  1
//    output_name             fpt_misc_sa_mm_nw_altera_merlin_router_1920_v6vnf3q
//    pkt_addr_h              71
//    pkt_addr_l              36
//    pkt_dest_id_h           108
//    pkt_dest_id_l           105
//    pkt_protection_h        112
//    pkt_protection_l        110
//    pkt_trans_read          75
//    pkt_trans_write         74
//    slaves_info             4:0000010000:0x0:0x100:both:1:0:0:1,6:0001000000:0x2000:0x4000:both:1:0:0:1,8:1000000000:0x10000:0x10020:both:1:0:0:1,9:0100000000:0x20000:0x20100:both:1:0:0:1,2:0000000100:0x40000:0x40100:both:1:0:0:1,7:0010000000:0x40100:0x40200:both:1:0:0:1,0:0000000001:0x100000000:0x200000000:both:1:0:0:1,3:0000001000:0x400000000:0x800000000:both:1:0:0:1,5:0000100000:0x800000000:0xc00000000:both:1:0:0:1
//    st_channel_w            10
//    st_data_w               131
// ------------------------------------------

module fpt_misc_sa_mm_nw_altera_merlin_router_1920_v6vnf3q_default_decode
  #(
     parameter DEFAULT_CHANNEL = 1,
               DEFAULT_WR_CHANNEL = -1,
               DEFAULT_RD_CHANNEL = -1,
               DEFAULT_DESTID = 1 
   )
  (output [108 - 105 : 0] default_destination_id,
   output [10-1 : 0] default_wr_channel,
   output [10-1 : 0] default_rd_channel,
   output [10-1 : 0] default_src_channel
  );

  assign default_destination_id = 
    DEFAULT_DESTID[108 - 105 : 0];

  generate
    if (DEFAULT_CHANNEL == -1) begin : no_default_channel_assignment
      assign default_src_channel = '0;
    end
    else begin : default_channel_assignment
      assign default_src_channel = 10'b1 << DEFAULT_CHANNEL;
    end
  endgenerate

  generate
    if (DEFAULT_RD_CHANNEL == -1) begin : no_default_rw_channel_assignment
      assign default_wr_channel = '0;
      assign default_rd_channel = '0;
    end
    else begin : default_rw_channel_assignment
      assign default_wr_channel = 10'b1 << DEFAULT_WR_CHANNEL;
      assign default_rd_channel = 10'b1 << DEFAULT_RD_CHANNEL;
    end
  endgenerate

endmodule


module fpt_misc_sa_mm_nw_altera_merlin_router_1920_v6vnf3q
(
    // -------------------
    // Clock & Reset
    // -------------------
    input clk,
    input reset,

    // -------------------
    // Command Sink (Input)
    // -------------------
    input                       sink_valid,
    input  [131-1 : 0]    sink_data,
    input                       sink_startofpacket,
    input                       sink_endofpacket,
    output                      sink_ready,

    // -------------------
    // Command Source (Output)
    // -------------------
    output                          src_valid,
    output reg [131-1    : 0] src_data,
    output reg [10-1 : 0] src_channel,
    output                          src_startofpacket,
    output                          src_endofpacket,
    input                           src_ready
);

    // -------------------------------------------------------
    // Local parameters and variables
    // -------------------------------------------------------
    localparam PKT_ADDR_H = 71;
    localparam PKT_ADDR_L = 36;
    localparam PKT_DEST_ID_H = 108;
    localparam PKT_DEST_ID_L = 105;
    localparam PKT_PROTECTION_H = 112;
    localparam PKT_PROTECTION_L = 110;
    localparam ST_DATA_W = 131;
    localparam ST_CHANNEL_W = 10;
    localparam DECODER_TYPE = 0;

    localparam PKT_TRANS_WRITE = 74;
    localparam PKT_TRANS_READ  = 75;

    localparam PKT_ADDR_W = PKT_ADDR_H-PKT_ADDR_L + 1;
    localparam PKT_DEST_ID_W = PKT_DEST_ID_H-PKT_DEST_ID_L + 1;



    // -------------------------------------------------------
    // Figure out the number of bits to mask off for each slave span
    // during address decoding
    // -------------------------------------------------------
    // -------------------------------------------------------
    // Work out which address bits are significant based on the
    // address range of the slaves. If the required width is too
    // large or too small, we use the address field width instead.
    // -------------------------------------------------------
    localparam ADDR_RANGE = 64'hc00000000;
    localparam RANGE_ADDR_WIDTH = log2ceil(ADDR_RANGE);
    localparam OPTIMIZED_ADDR_H = (RANGE_ADDR_WIDTH > PKT_ADDR_W) ||
                                  (RANGE_ADDR_WIDTH == 0) ?
                                        PKT_ADDR_H :
                                        PKT_ADDR_L + RANGE_ADDR_WIDTH - 1;
    localparam ADDRESS_ALIASING_W = PKT_ADDR_H > OPTIMIZED_ADDR_H + 1 ? PKT_ADDR_H - OPTIMIZED_ADDR_H - 1 : 0;

    localparam REAL_ADDRESS_RANGE = OPTIMIZED_ADDR_H - PKT_ADDR_L;

      reg [PKT_ADDR_W-1 : 0] address;
      always @* begin
        address = {PKT_ADDR_W{1'b0}};
        address [REAL_ADDRESS_RANGE:0] = sink_data[OPTIMIZED_ADDR_H : PKT_ADDR_L];
      end   

    // -------------------------------------------------------
    // Pass almost everything through, untouched
    // -------------------------------------------------------
    assign sink_ready        = src_ready;
    assign src_valid         = sink_valid;
    assign src_startofpacket = sink_startofpacket;
    assign src_endofpacket   = sink_endofpacket;
    wire [PKT_DEST_ID_W-1:0] default_destid;
    wire [10-1 : 0] default_src_channel;






    fpt_misc_sa_mm_nw_altera_merlin_router_1920_v6vnf3q_default_decode the_default_decode(
      .default_destination_id (default_destid),
      .default_wr_channel   (),
      .default_rd_channel   (),
      .default_src_channel  (default_src_channel)
    );

    always @* begin
        src_data    = sink_data;
        src_channel = default_src_channel;
        src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = default_destid;

        // --------------------------------------------------
        // Address aliasing will be routed to default slave (if present)
        // --------------------------------------------------
        if ( PKT_ADDR_H == OPTIMIZED_ADDR_H || 
             (|sink_data[PKT_ADDR_H:PKT_ADDR_H - ADDRESS_ALIASING_W] == 0) ) begin

        // --------------------------------------------------
        // Address Decoder
        // Sets the channel and destination ID based on the address
        // --------------------------------------------------

        // slave 0: [0x0, 0x100) : sel [35:8]
        if ( {address[35:8],{8 {1'b0}}} == 36'h0   ) begin
            src_channel = 10'b0000010000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 4;
        end

        // slave 1: [0x2000, 0x4000) : sel [35:13]
        if ( {address[35:13],{13 {1'b0}}} == 36'h2000   ) begin
            src_channel = 10'b0001000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 6;
        end

        // slave 2: [0x10000, 0x10020) : sel [35:5]
        if ( {address[35:5],{5 {1'b0}}} == 36'h10000   ) begin
            src_channel = 10'b1000000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 8;
        end

        // slave 3: [0x20000, 0x20100) : sel [35:8]
        if ( {address[35:8],{8 {1'b0}}} == 36'h20000   ) begin
            src_channel = 10'b0100000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 9;
        end

        // slave 4: [0x40000, 0x40100) : sel [35:8]
        if ( {address[35:8],{8 {1'b0}}} == 36'h40000   ) begin
            src_channel = 10'b0000000100;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 2;
        end

        // slave 5: [0x40100, 0x40200) : sel [35:8]
        if ( {address[35:8],{8 {1'b0}}} == 36'h40100   ) begin
            src_channel = 10'b0010000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 7;
        end

        // slave 6: [0x100000000, 0x200000000) : sel [35:32]
        if ( {address[35:32],{32 {1'b0}}} == 36'h100000000   ) begin
            src_channel = 10'b0000000001;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 0;
        end

        // slave 7: [0x400000000, 0x800000000) : sel [35:34]
        if ( {address[35:34],{34 {1'b0}}} == 36'h400000000   ) begin
            src_channel = 10'b0000001000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 3;
        end

        // slave 8: [0x800000000, 0xc00000000) : sel [35:34]
        if ( {address[35:34],{34 {1'b0}}} == 36'h800000000   ) begin
            src_channel = 10'b0000100000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 5;
        end
        end // end for if-else for memory aliasing decode
    end


    // --------------------------------------------------
    // Ceil(log2()) function
    // It's the 21st century. Consider using $clog2().
    // --------------------------------------------------
    function integer log2ceil;
        input reg[65:0] val;
        reg [65:0] i;

        begin
            i = 1;
            log2ceil = 0;

            while (i < val) begin
                log2ceil = log2ceil + 1;
                i = i << 1;
            end
        end
    endfunction

endmodule


