
// Rate Matching FIFO module
// This module takes wr_data wrt wr_clk and generate rd_data wrt to rd_clk.
// wr_clk and rd_clk should be of same clock frequency (phase can vary)
// Specify MEM_DEPTH in terms of 2**N.
module IW_rate_match_fifo #(
parameter DATA_WIDTH = 10,
parameter MEM_DEPTH  = 4
)(
input wr_clk,
input rd_clk,
input rst_n,
input [DATA_WIDTH-1:0] wr_data,
output reg [DATA_WIDTH-1:0] rd_data
);

`include "IW_logb2.svh"
localparam AWIDTH = IW_logb2(MEM_DEPTH-1)+1;

reg [DATA_WIDTH-1:0] data_mem [MEM_DEPTH-1:0];
reg [AWIDTH-1:0] rd_ptr ;
reg [AWIDTH-1:0] wr_ptr ;
reg sync_wr_rstn,wr_rst_n_ff1,wr_rst_n_ff2;
reg sync_rd_rstn,rd_rst_n_ff1,rd_rst_n_ff2;

  always @(posedge wr_clk or negedge rst_n)
   begin
     if (~rst_n) begin
       wr_rst_n_ff1 <= 1'b0;
       wr_rst_n_ff2 <= 1'b0;
       sync_wr_rstn <= 1'b0;
     end else begin
       wr_rst_n_ff1 <= 1'b1;
       wr_rst_n_ff2 <= wr_rst_n_ff1;
       sync_wr_rstn <= wr_rst_n_ff2;
     end
   end

  always @(posedge rd_clk or negedge rst_n)
   begin
     if (~rst_n) begin
       rd_rst_n_ff1 <= 1'b0;
       rd_rst_n_ff2 <= 1'b0;
       sync_rd_rstn <= 1'b0;
     end else begin
       rd_rst_n_ff1 <= 1'b1;
       rd_rst_n_ff2 <= rd_rst_n_ff1;
       sync_rd_rstn <= rd_rst_n_ff2;
     end
   end

  always @(posedge wr_clk or negedge sync_wr_rstn)
   begin
     if (~sync_wr_rstn) begin
       wr_ptr <= 'h0;
     end else begin
       wr_ptr <= wr_ptr+1;
     end
   end

  always @(posedge rd_clk or negedge sync_rd_rstn)
   begin
     if (~sync_rd_rstn) begin
       rd_ptr <= MEM_DEPTH/2;
     end else begin
       rd_ptr <= rd_ptr+1;
     end
   end

  always @(posedge wr_clk or negedge sync_wr_rstn)
   begin
     if (~sync_wr_rstn) begin
       integer a;
       for(a=0; a<MEM_DEPTH; a=a+1) begin
         data_mem[a] <= 'h0;
       end
     end else begin
       data_mem[wr_ptr] <= wr_data;
     end
   end
  
  always @(posedge rd_clk or negedge sync_rd_rstn)
   begin
     if (~sync_rd_rstn) begin
       rd_data <= 'h0;
     end else begin
       rd_data <= data_mem[rd_ptr];
     end
   end

endmodule

