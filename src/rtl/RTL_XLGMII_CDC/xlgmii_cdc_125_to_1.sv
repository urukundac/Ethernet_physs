module xlgmii_cdc_125_to_1 (

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

parameter FD_FIFO_ADDR_WD = 7;
parameter FD_FIFO_DATA_WD = 1;

parameter IFG_CYCLES = 5'h14;

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
        frame_done_event <= (wr_state == WR_IN_FRAME) && is_terminate;
end


always_ff @(posedge wr_clk) begin
    if (!rstn)
        frame_done_wr_en <= 1'b0;
    else
        frame_done_wr_en <= frame_done_event && !frame_done_full;
end

assign frame_done_din = 1'b1; // token only

typedef enum logic [2:0] {
    RD_IDLE,
    RD_PREFETCH,
    RD_FRAME,
    RD_BUBBLE,
    RD_BUBBLE_TO_IFG,
    RD_IFG_BUBBLE,
    RD_IFG,
    RD_IDLE_BUBBLE
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

logic [7:0] read_term_match;
logic read_is_terminate;

wire [7:0]  fifo_misc = fifo_dout_d[79:72];
wire [7:0]  fifo_ctrl = fifo_dout_d[71:64];
wire [63:0] fifo_data = fifo_dout_d[63:0];

generate
    for (i = 0; i < 8; i = i + 1) begin : GEN_RD_TERM_DETECT
        assign read_term_match[i] =
            fifo_ctrl[i] &&
            (fifo_data[i*8 +: 8] == 8'hFD);
    end
endgenerate

assign read_is_terminate = |read_term_match & rd_pop_d;

reg [4:0] rd_ifg_count;
logic rd_ifg_count_done;
logic rd_ifg_count_en;
logic ifg_tx_clk_ena;

assign rd_ifg_count_done = |rd_ifg_count;

always_ff @(posedge rd_clk or negedge rstn) begin
    if (!rstn) begin
        rd_ifg_count <= IFG_CYCLES; //5'h14;
    end else if (rd_ifg_count_en) begin
	    if (rd_ifg_count!= 5'h0) rd_ifg_count <= rd_ifg_count-5'h1; 
	    else rd_ifg_count <= rd_ifg_count;
    end
	else rd_ifg_count <= IFG_CYCLES; //5'h14;    
end


always_ff @(posedge rd_clk or negedge rstn) begin
    if (!rstn) begin
        rd_state         <= RD_IDLE;
        rd_en            <= 1'b0;
        frame_done_rd_en <= 1'b0;
        rd_ifg_count_en <= 1'b0;
	ifg_tx_clk_ena  <= 1'b0;


    end else begin
        // ------------------------------------------------
        // SAFE DEFAULTS (IDLE)
        // ------------------------------------------------
        rd_en            <= 1'b0;
        frame_done_rd_en <= 1'b0;

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
	    ifg_tx_clk_ena <= 1'b0;
	        if (read_is_terminate) begin
		rd_ifg_count_en <= 1'b1;
	        rd_state <= RD_IFG_BUBBLE;
		end 
                else begin	
                rd_en <= 1'b1; 
	      	rd_state <= RD_BUBBLE;
	        end
        end

	RD_BUBBLE: begin
		rd_en <=1'b0;
		if (rdusedw == 1) begin
		rd_ifg_count_en <= 1'b1;
	        rd_state <= RD_BUBBLE_TO_IFG;
		    end 
		else begin	    
		rd_state <= RD_FRAME;
                end
		end

        RD_BUBBLE_TO_IFG: begin
		rd_en <=1'b0;
		rd_state <= RD_IFG_BUBBLE;
		end

	RD_IFG: begin
         	ifg_tx_clk_ena <= ~ifg_tx_clk_ena;
		if (!rd_ifg_count_done) begin
                        rd_ifg_count_en <= 1'b0;
		       	rd_state <= RD_IDLE_BUBBLE;
		end
		else begin	    
		rd_state <= RD_IFG;
		end
	        end
	RD_IFG_BUBBLE: begin
		rd_en <=1'b0;
		rd_state <= RD_IFG;
		ifg_tx_clk_ena <= 1'b1;
		end
	RD_IDLE_BUBBLE: begin
		ifg_tx_clk_ena <= 1'b0;
		rd_en <=1'b0;
                rd_state <= RD_IDLE;
                end
        endcase
    end
end

reg ifg_tx_clk_ena_d1;
always_ff @(posedge rd_clk or negedge rstn) begin
    if (!rstn) begin
        ifg_tx_clk_ena_d1 <= 1'b0;
    end else begin
        ifg_tx_clk_ena_d1 <= ifg_tx_clk_ena; 
    end
end

reg xlgmii_txclk_ena_d1;
reg xlgmii_txclk_ena_d2;

always_ff @(posedge rd_clk or negedge rstn) begin
    if (!rstn) begin
        xlgmii_txclk_ena_d2 <= 1'b0;
        xlgmii_txclk_ena_d1 <= 1'b0;
        xlgmii_txclk_ena <= 1'b0;
    end else begin
        xlgmii_txclk_ena_d1 <= rd_pop_d | ifg_tx_clk_ena; 
	xlgmii_txclk_ena_d2    <= xlgmii_txclk_ena_d1;
        xlgmii_txclk_ena <= xlgmii_txclk_ena_d2;	
    end
end

logic        tx_hold_valid;
logic [79:0] tx_hold_data;

always_ff @(posedge rd_clk or negedge rstn) begin
    if (!rstn) begin
        tx_hold_valid <= 1'b0;
        tx_hold_data  <= '0;
    end else begin
        if (rd_pop_d) begin
            tx_hold_valid <= 1'b1;
            tx_hold_data  <= fifo_dout_d;
        end
        else if (xlgmii_txclk_ena_d2) begin
            // data consumed
            tx_hold_valid <= 1'b0;
        end
    end
end


always_ff @(posedge rd_clk or negedge rstn) begin
    if (!rstn) begin
        xlgmii_tx_data <= 64'h0707_0707_0707_0707;
        xlgmii_tx_c    <= 8'hFF;
        xlgmii_tx_misc <= 8'h00;
    end else begin
        if (tx_hold_valid) begin
            xlgmii_tx_data <= tx_hold_data[63:0];
            xlgmii_tx_c    <= tx_hold_data[71:64];
            xlgmii_tx_misc <= tx_hold_data[79:72];
        end else begin
            xlgmii_tx_data <= 64'h0707_0707_0707_0707;
            xlgmii_tx_c    <= 8'hFF;
            xlgmii_tx_misc <= 8'h00;
        end
    end
end



endmodule
