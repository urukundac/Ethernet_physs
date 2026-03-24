module xlgmii_cdc_1_to_125 (
input [63:0] xlgmii_rx_data,
input [7:0] xlgmii_rx_c,
input xlgmii_txclk_ena,
input [7:0] xlgmii_rx_misc,
output logic [63:0] xlgmii_tx_data,
output logic [7:0] xlgmii_tx_c,
output logic [7:0] xlgmii_tx_misc,
output logic xlgmii_rxclk_ena,
input rd_clk,
input wr_clk,
input rstn
);

parameter DATA_WD = 80;
parameter ADDR_WD = 12;

parameter FD_FIFO_ADDR_WD = 7;
parameter FD_FIFO_DATA_WD = 1;


localparam FIFO_DEPTH = 2**ADDR_WD;
localparam MAX_FRAME_BEATS = 1024;

reg [DATA_WD-1:0] fifo_dout;
reg fifo_empty;
reg [ADDR_WD:0] rdusedw;
reg wrfull;
reg [ADDR_WD:0] wrusedw;

reg [DATA_WD-1:0] fifo_din;
reg wr_en;
reg rd_en;

IW_fpga_async_fifo # (.ADDR_WD(ADDR_WD), .DATA_WD(DATA_WD) )
fifo (
.rstn(rstn),
.data(fifo_din),
.rdclk(rd_clk),
.rdreq(rd_en),
.wrclk(wr_clk),
.wrreq(wr_en),
.q(fifo_dout),
.rdempty(fifo_empty),
.rdusedw(rdusedw),
.wrfull(wrfull),
.wrusedw(wrusedw)
);


wire is_start;
wire is_terminate;


logic sym_valid;
logic is_terminate_d1;

always_ff @(posedge wr_clk or negedge rstn) begin
    if (!rstn)
        sym_valid <= 1'b0;
    else
        sym_valid <= xlgmii_rxclk_ena;  // 1-cycle delayed
end


always_ff @(posedge wr_clk or negedge rstn) begin
    if (!rstn)
        is_terminate_d1 <= 1'b0;
    else
        is_terminate_d1 <= is_terminate; // 1-cycle delayed
end


// ctrl[0]=1 and data[7:0] holds control character
assign is_start     = sym_valid && ((xlgmii_rx_c[0] && (xlgmii_rx_data[7:0] == 8'hFB)) || (xlgmii_rx_c[4] && (xlgmii_rx_data[39:32] == 8'hFB)));

wire [7:0] term_match;

genvar i;
generate
    for (i = 0; i < 8; i = i + 1) begin : GEN_TERM_MATCH
        assign term_match[i] =
            xlgmii_rx_c[i] &&
            (xlgmii_rx_data[i*8 +: 8] == 8'hFD);
    end
endgenerate

assign is_terminate = sym_valid && |term_match;


typedef enum logic [1:0] {
    WR_IDLE,
    WR_IN_FRAME,
    WR_BUBBLE,
    WR_WAIT
} wr_state_t;

wr_state_t wr_state;

always_ff @(posedge wr_clk or negedge rstn) begin
    if (!rstn) begin
        wr_state <= WR_IDLE;
        wr_en    <= 1'b0;
        fifo_din <= 80'b0;
    end else begin
        case (wr_state)
        // --------------------------------------------------
        // BETWEEN FRAMES
        // --------------------------------------------------
        WR_IDLE: begin

            if (wrusedw < FIFO_DEPTH && is_start) begin
                wr_en    <= 1'b1;
                fifo_din <= {xlgmii_rx_misc, xlgmii_rx_c, xlgmii_rx_data};
                wr_state <= WR_IN_FRAME;
            end
	    else begin // else: idle, do not write
            wr_en <= 1'b0;
            wr_state <= WR_IDLE;
            end
        end

        // --------------------------------------------------
        // IN FRAME
        // --------------------------------------------------

        WR_IN_FRAME: begin
	             fifo_din <= {xlgmii_rx_misc, xlgmii_rx_c, xlgmii_rx_data};
            if (wrusedw == FIFO_DEPTH-2 || is_terminate_d1) begin
		wr_en <= 1'b0;    
                wr_state <= WR_BUBBLE;
            end
	    else if (sym_valid) begin wr_en <= 1'b1;
            end
	    else begin 
		     wr_state <= WR_IN_FRAME; wr_en <= 1'b0;
	    end	     
        end
        
	WR_BUBBLE:  begin
		wr_en <= 1'b1;
                fifo_din <= {8'h00,8'hff, 64'h0707_0707_0707_0707};
		wr_state <= WR_WAIT;
            end

        WR_WAIT:  begin 
            wr_en <= 1'b0;	
	    if (wrusedw == 0) wr_state <= WR_IDLE;
            else wr_state <= WR_WAIT;		    
        end  
        endcase
    end
end

reg frame_done_din;
reg frame_done_rd_en;
reg frame_done_wr_en;
reg frame_done_empty;
reg frame_done_full;


IW_fpga_async_fifo # (.ADDR_WD(FD_FIFO_ADDR_WD), .DATA_WD(FD_FIFO_DATA_WD) )
frame_done_fifo (
.rstn(rstn),
.data(frame_done_din),
.rdclk(rd_clk),
.rdreq(frame_done_rd_en),
.wrclk(wr_clk),
.wrreq(frame_done_wr_en),
.q(frame_done_dout),
.rdempty(frame_done_empty),
.rdusedw(),
.wrfull(frame_done_full),
.wrusedw()
);


reg frame_done_event;

always_ff @(posedge wr_clk or negedge rstn) begin
    if (!rstn)
        frame_done_event <= 1'b0;
    else
        frame_done_event <= (wr_state == WR_BUBBLE);
end

reg wr_wait_reg;

always_ff @(posedge wr_clk or negedge rstn) begin
    if (!rstn)
        wr_wait_reg <= 1'b0;
    else
        wr_wait_reg <= (wr_state == WR_WAIT) | (wr_state == WR_BUBBLE) | is_terminate_d1;
end


always_ff @(posedge wr_clk) begin
    if (!rstn)
        frame_done_wr_en <= 1'b0;
    else
        frame_done_wr_en <= frame_done_event && !frame_done_full;
end

assign frame_done_din = 1'b1; // token only

typedef enum logic {
    RD_IDLE,
    RD_FRAME
} rd_state_t;

rd_state_t rd_state;


logic        rd_pop_d;          // delayed pop = valid output
logic [79:0] fifo_dout_d;       // registered FIFO output

always_ff @(posedge rd_clk or negedge rstn) begin
    if (!rstn) begin
        rd_pop_d    <= 1'b0;
        fifo_dout_d <= {8'h00,8'hFF,64'h0707_0707_0707_0707};
    end else begin
        rd_pop_d <= rd_en;
        if (rd_en)
            fifo_dout_d <= fifo_dout;
    end
end


logic [7:0] read_term_match;
logic read_is_terminate;

wire [7:0]  fifo_misc = fifo_dout[79:72];
wire [7:0]  fifo_ctrl = fifo_dout[71:64];
wire [63:0] fifo_data = fifo_dout[63:0];

generate
    for (i = 0; i < 8; i = i + 1) begin : GEN_RD_TERM_DETECT
        assign read_term_match[i] =
            fifo_ctrl[i] &&
            (fifo_data[i*8 +: 8] == 8'hFD);
    end
endgenerate

assign read_is_terminate = |read_term_match & rd_en;

logic [63:0] xlgmii_tx_data_d;
logic [7:0] xlgmii_tx_c_d;
logic [7:0] xlgmii_tx_misc_d;

always_ff @(posedge rd_clk or negedge rstn) begin
    if (!rstn) begin
        xlgmii_tx_data_d <= 64'h0707_0707_0707_0707; // IDLE
        xlgmii_tx_c_d    <= 8'hFF;
        xlgmii_tx_misc_d <= 8'h00;
    end else if (rd_en) begin
        xlgmii_tx_data_d <= fifo_dout[63:0];
        xlgmii_tx_c_d    <= fifo_dout[71:64];
        xlgmii_tx_misc_d <= fifo_dout[79:72];
    end else begin
        xlgmii_tx_data_d <= xlgmii_tx_data_d; //64'h0707_0707_0707_0707;
        xlgmii_tx_c_d   <= xlgmii_tx_c_d; //8'hFF;
        xlgmii_tx_misc_d <= xlgmii_tx_misc_d; //8'h00;
    end
end


always_ff @(posedge rd_clk or negedge rstn) begin
    if (!rstn) begin
        xlgmii_tx_data <= 64'h0707_0707_0707_0707; // IDLE
        xlgmii_tx_c    <= 8'hFF;
        xlgmii_tx_misc <= 8'h00;
    end else if (xlgmii_txclk_ena) begin
        xlgmii_tx_data <= xlgmii_tx_data_d;
        xlgmii_tx_c    <= xlgmii_tx_c_d;
        xlgmii_tx_misc    <= xlgmii_tx_c_d;
    end else begin
        xlgmii_tx_data <= xlgmii_tx_data;
        xlgmii_tx_c    <= xlgmii_tx_c;
        xlgmii_tx_misc    <= xlgmii_tx_misc;
    end
end


always_ff @(posedge rd_clk or negedge rstn) begin
    if (!rstn) begin
        rd_state         <= RD_IDLE;
        rd_en            <= 1'b0;
        frame_done_rd_en <= 1'b0;
    end else begin
        case (rd_state)
        // --------------------------------------------
        // WAIT FOR COMPLETE FRAME
        // --------------------------------------------
        RD_IDLE: begin
	    rd_en <= 1'b0;
            if (!frame_done_empty) begin
                frame_done_rd_en <= 1'b1;  // consume token
                rd_state         <= RD_FRAME;
            end
        end

	// --------------------------------------------
        // STREAM FRAME
        // --------------------------------------------
        RD_FRAME: begin
            frame_done_rd_en <= 1'b0;
            if (rdusedw >= 0) begin
                    if(rdusedw == 0) rd_state <= RD_IDLE;
		    else if(xlgmii_txclk_ena)  rd_en <= 1'b1; 
		    else begin rd_state <= RD_FRAME;
		    rd_en <= 1'b0;
	            end
            end
            else rd_state <= RD_IDLE;
        end
        endcase
    end
end

parameter RX_CLKEN_GAP_CYCLES = 1;
localparam int COUNT_WD = $clog2(RX_CLKEN_GAP_CYCLES + 1);

    logic [COUNT_WD-1:0] count;

    always_ff @(posedge wr_clk or negedge rstn) begin
        if (!rstn) begin
            count   <= '0;
            xlgmii_rxclk_ena <= 1'b0;
    end else if (wr_wait_reg) begin
	    xlgmii_rxclk_ena <= 1'b0; 
    end
	    else begin
            if (count == RX_CLKEN_GAP_CYCLES[COUNT_WD-1:0]) begin
                count   <= '0;
                xlgmii_rxclk_ena <= 1'b1; 
            end else begin
                count   <= count + 1'b1;
                xlgmii_rxclk_ena <= 1'b0;
            end
        end
    end

endmodule
