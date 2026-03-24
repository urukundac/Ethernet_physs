// (C) 2001-2024 Intel Corporation. All rights reserved.
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


`timescale 1 ps / 1 ps
module altr_i2c_condt_det (
    input       i2c_clk,
    input       i2c_rst_n,
    input       sda_int,
    input       scl_int,
    input       mst_tx_chk_ack,         // from tx shifter
    input       slv_tx_chk_ack,         // from tx shifter
    input       i2c_data_oe,
    input       mst_txdata_phase,       // from tx shifter, indicates mst data/addr transmission (excludes ack/nack) 
    input       mst_rxack_phase,	// from rx shifter, indicates mst ack/nack reception 
    input       slv_txdata_phase,       // from tx shifter, indicates slv data/addr transmission (excludes ack/nack) 
    input       slv_rxack_phase,	// from rx shifter, indicates slv ack/nack reception 
    input       tbuf_cnt_complete,

    output      scl_edge_hl,
    output      scl_edge_lh,
    output      sda_edge_hl,
    output      sda_edge_lh,
    output      start_det,
    output reg  start_det_dly,
    output      stop_det,
    output reg  ack_det,
    output      slv_arblost,
    output      arb_lost,
    output reg  bus_idle,
    output reg  load_tbuf_cnt,
    output reg  tbuf_cnt_en

);

// Status Register bit definition


// wires & registers declaration
reg         sda_int_edge_reg;
reg         scl_int_edge_reg;
reg         mst_arb_lost_reg;
reg         slv_arb_lost_reg;
reg         ack_det_nxt;
reg [1:0]   bus_state; 
reg [1:0]   bus_nx_state;

wire        arb_compare_mismatched;
wire        mst_arb_lost_comb;
wire        slv_arb_lost_comb;


parameter   BUS_IDLE = 2'b00,
            BUS_BUSY = 2'b01,
            BUS_LOAD_CNT = 2'b10,
            BUS_COUNTING = 2'b11;



// sda,scl edge detector flops 
always @(posedge i2c_clk or negedge i2c_rst_n) begin
    if (!i2c_rst_n)
        sda_int_edge_reg <= 1'b1;
    else
        sda_int_edge_reg <= sda_int;
end
 
always @(posedge i2c_clk or negedge i2c_rst_n) begin
    if (!i2c_rst_n)
        scl_int_edge_reg <= 1'b1;
    else
        scl_int_edge_reg <= scl_int;
end


// start_det; stop_det; scl_edge_hl; scl_edge_lh  
assign sda_edge_hl = sda_int_edge_reg & ~sda_int;
assign sda_edge_lh = ~sda_int_edge_reg & sda_int;
assign scl_edge_hl = scl_int_edge_reg & ~scl_int;
assign scl_edge_lh = ~scl_int_edge_reg & scl_int;

assign start_det    = scl_int & sda_edge_hl;
assign stop_det     = scl_int & sda_edge_lh;

always @(posedge i2c_clk or negedge i2c_rst_n) begin
    if (!i2c_rst_n)
        start_det_dly <= 1'b0;
    else
        start_det_dly <= start_det;
end

// ack_det ==  If  (scl_edge_lh&& (mst_tx_chk_ack||slv_tx_chk_ack)) then ack_det =~sda_int else ack_det=0
// assign ack_det = (scl_edge_lh && (mst_tx_chk_ack || slv_tx_chk_ack)) ? ~sda_int : 1'b0;
always @(posedge i2c_clk or negedge i2c_rst_n) begin
    if (!i2c_rst_n)
        ack_det <= 1'b0;
    else
        ack_det <= ack_det_nxt;
end

always @* begin
    case ({scl_edge_lh, (mst_tx_chk_ack | slv_tx_chk_ack)})
        2'b00: ack_det_nxt = 1'b0;
        2'b01: ack_det_nxt = ack_det;
        2'b10: ack_det_nxt = 1'b0;
        2'b11: ack_det_nxt = ~sda_int;
        default: ack_det_nxt = 1'bx;
    endcase
end


// arbit_lost
// arbit_lost == if  (scl_edge_lh && (mst_tx_en || mst_rx_ack_en)) then compare (~data_oe ^ sda_int)
always @(posedge i2c_clk or negedge i2c_rst_n) begin
    if (!i2c_rst_n) begin
        mst_arb_lost_reg <= 1'b0;
        slv_arb_lost_reg <= 1'b0;
    end
    else begin
        mst_arb_lost_reg <= mst_arb_lost_comb;
        slv_arb_lost_reg <= slv_arb_lost_comb;
    end
end

assign arb_compare_mismatched   = (~i2c_data_oe ^ sda_int);	// return 1 when comparing ~data_oe to sda_int value are mismatched
assign mst_arb_lost_comb        = (scl_edge_lh & (mst_txdata_phase | mst_rxack_phase )) ? arb_compare_mismatched : 1'b0;
assign slv_arb_lost_comb        = (scl_edge_lh & (slv_txdata_phase | slv_rxack_phase )) ? arb_compare_mismatched : 1'b0;

assign slv_arblost              = slv_arb_lost_reg;
assign arb_lost                 = mst_arb_lost_reg | slv_arb_lost_reg;




// bus idle 
always @(posedge i2c_clk or negedge i2c_rst_n) begin
    if (!i2c_rst_n)
        bus_state <= BUS_IDLE;
    else
        bus_state <= bus_nx_state;
end


always @* begin
    case(bus_state)
        BUS_IDLE:      if (start_det) bus_nx_state = BUS_BUSY;
                       else bus_nx_state = BUS_IDLE;
        BUS_BUSY:      if (stop_det) bus_nx_state = BUS_LOAD_CNT;
                       else bus_nx_state = BUS_BUSY;
	BUS_LOAD_CNT:  if (start_det) bus_nx_state = BUS_BUSY;
		       else bus_nx_state = BUS_COUNTING;
        BUS_COUNTING:  if (start_det ) bus_nx_state = BUS_BUSY;
		       else if (tbuf_cnt_complete ) bus_nx_state = BUS_IDLE;
                       else bus_nx_state = BUS_COUNTING;
        default: bus_nx_state = 2'bx;
    endcase
end


always @(posedge i2c_clk or negedge i2c_rst_n) begin
    if (!i2c_rst_n) begin
        tbuf_cnt_en     <= 1'b0;
        bus_idle        <= 1'b1;
        load_tbuf_cnt   <= 1'b0;
    end
    else begin
        case(bus_nx_state)
            BUS_IDLE : begin
                tbuf_cnt_en     <= 1'b0;
                bus_idle        <= 1'b1;
	        load_tbuf_cnt   <= 1'b0;
            end
	    BUS_BUSY : begin
                tbuf_cnt_en     <= 1'b0;
                bus_idle        <= 1'b0;
	        load_tbuf_cnt   <= 1'b0;
            end
	    BUS_LOAD_CNT : begin
                tbuf_cnt_en     <= 1'b0;
                bus_idle        <= 1'b0;
	        load_tbuf_cnt   <= 1'b1;
            end
	    BUS_COUNTING : begin
                tbuf_cnt_en     <= 1'b1;
                bus_idle        <= 1'b0;
	        load_tbuf_cnt   <= 1'b0;
            end
            default : begin
	        tbuf_cnt_en     <= 1'bx;
                bus_idle        <= 1'bx;
	        load_tbuf_cnt   <= 1'bx;
            end
        endcase
    end
end


endmodule

`ifdef QUESTA_INTEL_OEM
`pragma questa_oem_00 "oSKThnM8R+v4ntG+2nl4bjKssux9ChPCljWQD7sPiJABKN3SNdkywE5Y9jlQ6S14DWhLDzTra8TiIdkRcVVm742z5SsEdsJozy5YbTTLMwLklS7QykQbr47Q0XEb4wjmHRWxsXN/cqp4yvaj0F/T170jVXGQEeG8jGOUpVeKH05OMFZaeFHtsmfkAiMhLD6Ub4coa1nbk3STuGKv7+r8sFY4IhYpZD54s1pA/oHzEkdLjus6t9fu0en9DPncBKhytT1oayrbQjABdwulaefVNtFqNZDsqKjTyADmu0zBLcINpHgJwGUlDmEFPb9qL9J71ihjCWBY0lNazs55mJTmZLaPqGLSTDFMzgljVfG65uVDMH6ilCnlvmbDTS1hxq6I4NCF+HJQZY2lEJ+JwLlLU9DKj4mYf1GN7UhC4VsnU74g+L8ZqHgsGmQQtt0CP2tof9efYi1xa110g7A8NGmXgVYK1SO47jgbaChDRw386xpEzqLoxeMJngP5d3F3/83nVzC2yuN/g1UkYo9SWc58O9fvc2EOPjFjhdDvs9YtrDnJvxQuJ21RMwUl96ruRS3Oz9JmJZLvV4QvyrUezMARRX5/MjkUwEfvv1rKRgHAvxZt27qLbpJG8LlQ7T40VLVzcccvKxpKP/QvttXgI220Vx2M86xTmQmaVArEj5tYiHSIUnju8k6YBmco7SjTGbMIcIcSGjddTJu4cARN6whTXlSrWZGw8p9VpMkd+uTLSjpDn+JOrUJl5A+VwVnEq8D4w6DtFAbZF9Q1fxmecMIH+KIH9j5P2Ev1WsrWo4YpSnWWaw8q1boMTCw3lU6eIy+K1xNSAPmFOh7tL4T829ZvJDUAwRN3XLcdNBQdpfhPN97n3W4RlPGgDzQttbsub7S/6PKs+9XqBhELX6xiwCYunfcSX+XBZcbNFRfL1L5vdIm6FriHR1aDE7k1yBlg9WJiA1De6JYMAYJ2VzP40vYihJspGQ1kt12RBjhNlxVfuivnYhAhEswITE8iI5i08Z5Z"
`endif