//----------------------------------------------------------------------------//
//----------------------------- ENTITY FOR VRAM2 -----------------------------//
//----------------------------------------------------------------------------//
//
//    RCS Information:
//    $Author: $
//    $Date: $
//    $Revision: $
//    $Locker: $
//
//----------------------------------------------------------------------------//
//
//    FILENAME  : vram2.v
//    DESIGNER  : jeaster
//    PROJECT   : test / vram2
//    DATE      : 01/10/08
//    PURPOSE   : Entity/Architecture/Config for vram2
//    REVISION NUMBER   : 
//
//----------------------------------------------------------------------------//
//    Created by MAS2RTL V2006.04.05
//    Intel Proprietary
//    Copyright (C) 2003 Intel Corporation
//    All Rights Reserved
//----------------------------------------------------------------------------//
//

//---------------------------- Entity Declaration ----------------------------//

`timescale 1 ps / 1 ps

module fpga_vram2 (vram_clock, vram_reset_b, write_data, write_enable, 
                        write_byte_enable, write_address, read_address1, 
                        read_address2, dt_latchopen, dt_latchclosed_b, 
                        dt_ramrst_b, read_data1, read_data2, 
                        write_data_flopped, data_memory );
    parameter            width = 128;
    parameter            depth = 16;
    parameter     address_size = 4;
    parameter    write_enable_count = 1;
    parameter        use_ports = 2;
    parameter     use_preflops = 1;
    parameter    use_gated_cell = 3;
    parameter    vram_reset_enable = 0;
    parameter    latch_reset_enable = 0;
    input           vram_clock;
    input         vram_reset_b;
    input[width-1:0]    write_data;
    input         write_enable;
    input[write_enable_count-1:0]    write_byte_enable;
    input[address_size-1:0]    write_address;
    input[address_size-1:0]    read_address1;
    input[address_size-1:0]    read_address2;
    input         dt_latchopen;
    input     dt_latchclosed_b;
    input          dt_ramrst_b;
                                            // Used as functional latch
                                            // reset when enabled.
    output[width-1:0]    read_data1;
    output[width-1:0]    read_data2;
    output[width-1:0]    write_data_flopped;
    output[width*depth-1:0]    data_memory;

//----------------------------------------------------------------------------//
//-------------------------- ARCHITECTURE FOR VRAM2 --------------------------//
//----------------------------------------------------------------------------//
//
//    RCS Information:
//    $Author: $
//    $Date: $
//    $Revision: $
//    $Locker: $
//
//----------------------------------------------------------------------------//
//
//    FILENAME  : vram2.v
//    DESIGNER  : jeaster
//    PROJECT   : test / vram2
//    DATE      : 01/10/08
//    PURPOSE   : Architecture for vram2
//    REVISION NUMBER   : 
//
//----------------------------------------------------------------------------//
//    Created by MAS2RTL V2006.04.05
//    Intel Proprietary
//    Copyright (C) 2003 Intel Corporation
//    All Rights Reserved
//----------------------------------------------------------------------------//
//

//--------------------------- Signal Declarations ----------------------------//

    parameter    ALL0_WIDTH_MINUS_1_0 = {(width-1)+1{1'b0}};

    parameter         ALWAYS_ARC = 1'b1;


    reg[width-1:0]    write_data_flopped1;
    reg[width-1:0]    write_data_flopped2;

    wire[width-1:0]    write_data_flopped3;
    wire[width-1:0]    i_write_data;
    wire[address_size-1:0]    nc_write_address;
    wire[depth-1:0]    write_select;
    wire[write_enable_count-1:0]    nc_write_byte_enable;
    wire[address_size-1:0]    nc_read_address1;
    wire[address_size-1:0]    nc_read_address2;
    wire[depth*write_enable_count-1:0]    i_write_line_enable;

 

reg [depth-1:0] address_select;

reg [depth*write_enable_count-1:0] write_line_select;

// synopsys async_set_reset "dt_ramrst_b"
parameter bwidth = (width / write_enable_count);
reg [width*depth-1:0] data_memory/*synthesis syn_ramstyle="registers"*/;

reg [width-1:0] mux_read_data1;
reg [width-1:0] mux_read_data2;

//---------------------------- Model Description -----------------------------//
//--------------------------------- Port Map ---------------------------------//
genvar i;
generate
  if((use_gated_cell != 9))
  begin: sipp2sb_vram2_0
    for(i = depth*write_enable_count-1; i >= 0; i = i-1)
    begin: gc_scanlatchen_depth_write_enable_count_1

ctech_lib_clk_gate_te_rst_ss ctech_donttouch_gc_latchen 
       (
        .en(write_line_select[i]),
        .te(dt_latchopen),
        .rst(~dt_latchclosed_b),
        .clk(vram_clock),
        .clkout(i_write_line_enable[i]) 
        );

    end
  end
endgenerate

//--------------------------------------------------------//
//Free Form Table Code
//--------------------------------------------------------//
//synopsys translate_off
initial $display (
        "VRAM2 Instance: %m %d %d %d %d %d %d %d %d %d",
        width,
        depth,
        address_size,
        write_enable_count,
        use_ports,
        use_preflops,
        use_gated_cell,
        vram_reset_enable,
        latch_reset_enable
);
//synopsys translate_on



//------------------------------------//
// flopped internal signals for Flopped Signals Table
//------------------------------------//
always @ (posedge vram_clock or negedge vram_reset_b)
begin: vram21_internal_reset_flops
    if (vram_reset_b == 1'b0)
      begin
        write_data_flopped1[width-1:0] <= #100 ALL0_WIDTH_MINUS_1_0;
      end
    else
      begin
        write_data_flopped1[width-1:0] <= #100 write_data[width-1:0];
       end
end // begin: vram21_internal_reset_flops


//------------------------------------//
// flopped internal signals for Flopped Signals Table
//------------------------------------//
always @ (posedge vram_clock)
begin: vram21_internal_noreset_flops

      write_data_flopped2[width-1:0] <= #100 write_data[width-1:0];

end // begin: vram21_internal_noreset_flops


//------------------------------------//
// concurrent output signal assignments for Combinatorial Signals Table
//------------------------------------//

// Tie off the output when not using the pre-flops.
assign write_data_flopped[width-1:0] = ((
                                         (use_preflops == 1)&&
                                         (use_gated_cell != 9)
                                        )) ? 
                        write_data_flopped3[width-1:0] : {width{1'b0}};




//------------------------------------//
// concurrent internal signal assignments for Combinatorial Signals Table
//------------------------------------//

// Use resetable or non-resetable pre-flops.
assign write_data_flopped3[width-1:0] = ((vram_reset_enable == 1)) ? 
                        write_data_flopped1[width-1:0] : write_data_flopped2[width-1:0];


// Use the pre-flops or not.
assign i_write_data[width-1:0] = ((use_preflops == 1)) ? 
                        write_data_flopped3[width-1:0] : write_data[width-1:0];




//------------------------------------//
// concurrent internal signal assignments for Combinatorial Signals Table
//------------------------------------//

assign nc_write_address[address_size-1:0] = write_address[address_size-1:0];



//--------------------------------------------------------//
//Free Form Table Code
//--------------------------------------------------------//

always @(write_address)
begin : write_address_decoder
        integer i;
        for (i=depth-1;i>=0;i=i-1)
        begin
                if (write_address == i)
                begin
                        address_select[i] <= 1'b1;
                end
                else
                begin
                        address_select[i] <= 1'b0;
                end
        end
end // write_address_decoder

//------------------------------------//
// concurrent internal signal assignments for Combinatorial Signals Table
//------------------------------------//

// Force select to one when memory depth is one.
assign write_select[depth-1:0] = ((depth > 1)) ? 
                        address_select[depth-1:0] : {depth{1'b1}};




//------------------------------------//
// concurrent internal signal assignments for Combinatorial Signals Table
//------------------------------------//

// Causes a two input AND gate to be used instead of a three input AND gate
// when the byte enable width is only one.
assign nc_write_byte_enable[write_enable_count-1:0] = (
                                   (write_enable_count > 1)) ? 
                        write_byte_enable[write_enable_count-1:0] : {write_enable_count{1'b1}};




//--------------------------------------------------------//
//Free Form Table Code
//--------------------------------------------------------//
always @(
        write_select or
        write_enable or
        nc_write_byte_enable
        )
begin : write_line_select_table
        integer i;
        for ( i = depth*write_enable_count -1; i >= 0; i = i - 1)
        begin
            write_line_select[i] <= 
                write_select[i/write_enable_count] &
                write_enable &
                nc_write_byte_enable[i%write_enable_count];
        end
end // write_line_select_table

//--------------------------------------------------------//
//Free Form Table Code
//--------------------------------------------------------//

// check if there is anything without use_preflops and latch model reqd
generate
if ((use_gated_cell != 9) && (use_preflops != 1) && (depth > 1))
begin
  not_supported_nopreflop_latch latch_model_no ();
end
endgenerate

// For this option we have to use latch. no other way p2sb has this
generate
if ((use_gated_cell != 9) && (use_preflops != 1) && (depth == 1))
always_latch begin : vram_mem_cell0_internal_noreset_latches
        for (int i = depth-1; i >= 0; i = i - 1) begin
            for (int j = write_enable_count -1; j >= 0; j = j - 1) begin
                if ((i_write_line_enable[(i*write_enable_count)+j]) == 1'b1) begin
                    data_memory[((i*width)+(j*bwidth))+:bwidth] <=
                        i_write_data[(j*bwidth)+:bwidth];
                end
            end
        end
end // vram_mem_cell0_internal_noreset_latches
endgenerate

generate
if ((latch_reset_enable != 1) && (use_gated_cell != 9) && (use_preflops == 1))
begin : LA30
//always @(
//         i_write_data or
//         i_write_line_enable
//        )
always @ (posedge vram_clock)
begin : vram_mem_cell0_internal_noreset_latches
        integer i;
        integer j;
        for ( i = depth-1; i >= 0; i = i - 1)
        begin
            for ( j = write_enable_count -1; j >= 0; j = j - 1)
            begin
                if ((write_line_select[i*write_enable_count+j]) == 1'b1)
                begin
                    data_memory[((i*width)+(j*bwidth))+:bwidth] <=
                        write_data[(j*bwidth)+:bwidth];
                end
            end
        end
end // vram_mem_cell0_internal_noreset_latches
end // LA30
endgenerate

generate
if ((latch_reset_enable == 1) && (use_gated_cell != 9) && (use_preflops == 1 ))
begin : LA32
//always @(
//         dt_ramrst_b or 
//         i_write_data or
//         i_write_line_enable
//        )
always @ (posedge vram_clock or negedge vram_reset_b)
begin : vram_mem_cell1_internal_latches
        integer i;
        integer j;
        for ( i = depth-1; i >= 0; i = i - 1)
        begin
            for ( j = write_enable_count -1; j >= 0; j = j - 1)
            begin
                if ((dt_ramrst_b) == 1'b0)
                begin
                    data_memory[((i*width)+(j*bwidth))+:bwidth] <= 
                        {bwidth{1'b0}};
                end
                else if ((write_line_select[i*write_enable_count+j]) == 1'b1)
                begin
                    data_memory[((i*width)+(j*bwidth))+:bwidth] <=
                        write_data[(j*bwidth)+:bwidth];
                end
            end
        end
end // vram_mem_cell1_internal_latches
end // LA32
endgenerate

generate
if ((vram_reset_enable != 1) && (use_gated_cell == 9))
begin : XS00
// Can't have unused signals in the "always" check (fixed rev4.2b).
//always @ (posedge vram_clock or negedge vram_reset_b)
always @ (posedge vram_clock)
begin : vram_mem_cell3_internal_flops
        integer i;
        integer j;
        for ( i = depth-1; i >= 0; i = i - 1)
        begin
            for ( j = write_enable_count -1; j >= 0; j = j - 1)
            begin
                if ((write_line_select[i*write_enable_count+j]) == 1'b1)
                begin
                    data_memory[((i*width)+(j*bwidth))+:bwidth] <= #100
                        write_data[(j*bwidth)+:bwidth];
                end
            end
        end
end // vram_mem_cell_internal_flops
end // XS00
endgenerate

generate
if ((vram_reset_enable == 1) && (use_gated_cell == 9))
begin : XA02
always @ (posedge vram_clock or negedge vram_reset_b)
begin : vram_mem_cell3_internal_reset_flops
        integer i;
        integer j;
        if (vram_reset_b == 1'b0)
        begin
            for ( i = depth-1; i >= 0; i = i - 1)
            begin
                for ( j = write_enable_count -1; j >= 0; j = j - 1)
                begin
                    data_memory[((i*width)+(j*bwidth))+:bwidth] <= #100
                        {bwidth{1'b0}};
                end
            end
        end
        else
        begin
            for ( i = depth-1; i >= 0; i = i - 1)
            begin
                for ( j = write_enable_count -1; j >= 0; j = j - 1)
                begin
                    if ((write_line_select[i*write_enable_count+j]) == 1'b1)
                    begin
                        data_memory[((i*width)+(j*bwidth))+:bwidth] <= #100
                            write_data[(j*bwidth)+:bwidth];
                    end
                end
            end
        end
end // vram_mem_cell3_internal_reset_flops
end // XA02
endgenerate

//------------------------------------//
// concurrent internal signal assignments for Combinatorial Signals Table
//------------------------------------//

// Needed to support one port mode.
assign nc_read_address1[address_size-1:0] = ((use_ports == 1)) ? 
                        write_address[address_size-1:0] : read_address1[address_size-1:0];


assign nc_read_address2[address_size-1:0] = read_address2[address_size-1:0];



//--------------------------------------------------------//
//Free Form Table Code
//--------------------------------------------------------//

always @(
        nc_read_address1 or
        data_memory
        )
begin : read_mux1
        integer i;
        mux_read_data1 = {width{1'b0}};
        for ( i = depth-1; i >= 0; i = i - 1)
        begin
                if (nc_read_address1 == i)
                begin
                        mux_read_data1 = data_memory [i*width+:width];
                end
        end
end // begin : read_mux1

always @(
        nc_read_address2 or
        data_memory
        )
begin : read_mux2
        integer i;
        mux_read_data2 = {width{1'b0}};
        for ( i = depth-1; i >= 0; i = i - 1)
        begin
                if (nc_read_address2 == i)
                begin
                        mux_read_data2 = data_memory [i*width+:width];
                end
        end
end // begin : read_mux2

//------------------------------------//
// concurrent output signal assignments for Combinatorial Signals Table
//------------------------------------//

// Block output when not used (added rev4.3).
// Bypass read mux when memory depth is only one.
assign read_data1[width-1:0] = ((use_ports < 1)) ? 
                        {width{1'b0}} : ((depth > 1)) ? 
                        mux_read_data1[width-1:0] : data_memory[width-1:0];


// Block output when not used.
// Bypass read mux when memory depth is only one.
assign read_data2[width-1:0] = ((use_ports < 3)) ? 
                        {width{1'b0}} : ((depth > 1)) ? 
                        mux_read_data2[width-1:0] : data_memory[width-1:0];




endmodule // vram2

//----------------------------------------------------------------------------//
// $Log: $
//----------------------------------------------------------------------------//
