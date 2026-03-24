module xlgmii_cdc (

input [63:0] xlgmii_rx_data,
input [7:0] xlgmii_rx_c,
input xlgmii_rxt0_next,
input xlgmii_rxclk_ena,
output logic [63:0] xlgmii_tx_data,
output logic [7:0] xlgmii_tx_c,
output logic [7:0] xlgmii_tx_misc,
output logic xlgmii_txclk_ena,
input rd_clk,
input wr_clk,
input rstn

);

parameter DATA_WD = 80;
parameter ADDR_WD = 12;
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




wire [7:0] xlgmii_misc;
//reg [7:0] xlgmii_tx_misc;

assign xlgmii_misc = {7'b0,xlgmii_rxt0_next};

wire is_start;
wire is_terminate;

// ctrl[0]=1 and data[7:0] holds control character
assign is_start     = xlgmii_rxclk_ena && xlgmii_rx_c[0] && (xlgmii_rx_data[7:0] == 8'hFB);

wire [7:0] term_match;

genvar i;
generate
    for (i = 0; i < 8; i = i + 1) begin : GEN_TERM_MATCH
        assign term_match[i] =
            xlgmii_rx_c[i] &&
            (xlgmii_rx_data[i*8 +: 8] == 8'hFD);
    end
endgenerate

assign is_terminate = xlgmii_rxclk_ena && |term_match;

wire early_full;

assign early_full = ( wrusedw > (FIFO_DEPTH - MAX_FRAME_BEATS));


typedef enum logic {
    WR_IDLE,
    WR_IN_FRAME
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

            if (xlgmii_rxclk_ena && is_start && !early_full) begin
                // Accept start of frame
                wr_en    <= 1'b1;
                fifo_din <= {xlgmii_misc, xlgmii_rx_c, xlgmii_rx_data};
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
            if (xlgmii_rxclk_ena) begin
                // Write ONLY valid beats
                wr_en    <= 1'b1;
                fifo_din <= {xlgmii_misc, xlgmii_rx_c, xlgmii_rx_data};
            end
	    else begin // else: idle, do not write
            wr_en <= 1'b0;
            end

            if (is_terminate) begin
                // End of frame on a VALID beat
                wr_state <= WR_IDLE;
            end
        end


        endcase
    end
end

reg frame_done_din;
reg frame_done_rd_en;
reg frame_done_wr_en;
reg frame_done_empty;
reg frame_done_full;

IW_fpga_async_fifo # (.ADDR_WD(3), .DATA_WD(1) )
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
        frame_done_event <= (wr_state == WR_IN_FRAME) && is_terminate;
end


always_ff @(posedge wr_clk) begin
    if (!rstn)
        frame_done_wr_en <= 1'b0;
    else
        frame_done_wr_en <= frame_done_event && !frame_done_full;
end

assign frame_done_din = 1'b1; // token only

typedef enum logic [1:0] {
    RD_IDLE,
    RD_PREFETCH,
    RD_FRAME
} rd_state_t;

rd_state_t rd_state;


logic        rd_pop_d;          // delayed pop = valid output
logic [79:0] fifo_dout_d;       // registered FIFO output

always_ff @(posedge rd_clk or negedge rstn) begin
    if (!rstn) begin
        rd_pop_d    <= 1'b0;
        fifo_dout_d <= '0;
    end else begin
        rd_pop_d <= rd_en;
        if (rd_en)
            fifo_dout_d <= fifo_dout;
    end
end

always_ff @(posedge rd_clk or negedge rstn) begin
    if (!rstn) begin
        rd_state         <= RD_IDLE;
        rd_en            <= 1'b0;
        frame_done_rd_en <= 1'b0;

        xlgmii_tx_data <= 64'h0707_0707_0707_0707;
        xlgmii_tx_c    <= 8'hFF;
        xlgmii_tx_misc <= 8'h00;

    end else begin
        // ------------------------------------------------
        // SAFE DEFAULTS (IDLE)
        // ------------------------------------------------
        rd_en            <= 1'b0;
        frame_done_rd_en <= 1'b0;

        xlgmii_tx_data <= 64'h0707_0707_0707_0707;
        xlgmii_tx_c    <= 8'hFF;
        xlgmii_tx_misc <= 8'h00;

        // ------------------------------------------------
        // OUTPUT ONLY WHEN POPPED (registered)
        // ------------------------------------------------
        if (rd_pop_d) begin
            xlgmii_tx_misc <= fifo_dout_d[79:72];
            xlgmii_tx_c    <= fifo_dout_d[71:64];
            xlgmii_tx_data <= fifo_dout_d[63:0];
        end

        case (rd_state)

        // --------------------------------------------
        // WAIT FOR COMPLETE FRAME
        // --------------------------------------------
        RD_IDLE: begin
            if (!frame_done_empty) begin
                frame_done_rd_en <= 1'b1;  // consume token
                rd_state         <= RD_PREFETCH;
            end
        end

        // --------------------------------------------
        // PREFETCH (no pop, no output)
        // --------------------------------------------
        RD_PREFETCH: begin
            rd_state <= RD_FRAME;
        end

        // --------------------------------------------
        // STREAM FRAME
        // --------------------------------------------
        RD_FRAME: begin
            if (rdusedw > 0) begin
                rd_en <= 1'b1;   // initiate pop

                // If this was the LAST beat, exit next cycle
                if (rdusedw == 2)
                    rd_state <= RD_IDLE;
            end else begin
                rd_state <= RD_IDLE;
            end
        end

        endcase
    end
end

always_ff @(posedge rd_clk or negedge rstn) begin
    if (!rstn) begin
        xlgmii_txclk_ena <= 1'b0;
    end else begin
        xlgmii_txclk_ena <= rd_pop_d; 
    end
end


endmodule
