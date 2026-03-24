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
 -- Module Name       : IW_fpga_avst2csr
 -- Author            : Vani V
 -- Associated modules:  
 -- Function          : Straming to CSR interface
 --------------------------------------------------------------------------
*/

`timescale 1ns / 10ps



module IW_fpga_avst2csr #(
      parameter AVST_CHANNEL_ID      = 0,
      parameter AVST_CHANNEL_WIDTH   = 8,
      parameter AVST_SYMBOL_WIDTH    = 8,
      parameter AVST_DATA_WIDTH      = 1*AVST_SYMBOL_WIDTH,

      parameter CSR_ADDR_WIDTH       = 3*AVST_SYMBOL_WIDTH,
      parameter CSR_DATA_WIDTH       = 4*AVST_SYMBOL_WIDTH,

      /* Do not modify */
      parameter CMD_WIDTH            = 1*AVST_SYMBOL_WIDTH

   ) (
   input    wire                             clk_avst,
   input    wire                             rst_avst_n,

   output   reg                              avst_ingr_ready,
   input    wire                             avst_ingr_valid,
   input    wire                             avst_ingr_sop,
   input    wire                             avst_ingr_eop,
   input    wire  [AVST_CHANNEL_WIDTH-1:0]   avst_ingr_channel,
   input    wire  [AVST_DATA_WIDTH-1:0]      avst_ingr_data,

   input    wire                             avst_egr_ready,
   output   reg                              avst_egr_valid,
   output   reg                              avst_egr_sop,
   output   reg                              avst_egr_eop,
   output   reg   [AVST_CHANNEL_WIDTH-1:0]   avst_egr_channel,
   output   reg   [AVST_DATA_WIDTH-1:0]      avst_egr_data,

   input    wire                             clk_csr,
   input    wire                             rst_csr_n,

   output   reg                              csr_write,
   output   reg                              csr_read,
   output   reg  [CSR_ADDR_WIDTH-1:0]        csr_addr,
   output   reg  [CSR_DATA_WIDTH-1:0]        csr_wr_data,
   input    wire [CSR_DATA_WIDTH-1:0]        csr_rd_data,
   input    wire                             csr_rd_valid
   );

//parameters
localparam  CSR_BYTE_EN_REMAP_W  = ((CSR_DATA_WIDTH/8)  % AVST_SYMBOL_WIDTH)  ? (((CSR_DATA_WIDTH/8)  / AVST_SYMBOL_WIDTH) + 1)*AVST_SYMBOL_WIDTH : ((CSR_DATA_WIDTH/8) / AVST_SYMBOL_WIDTH)*AVST_SYMBOL_WIDTH;

localparam  REQ_FIFO_WIDTH = CMD_WIDTH + CSR_ADDR_WIDTH + CSR_DATA_WIDTH  + CSR_BYTE_EN_REMAP_W;
localparam  RSP_FIFO_WIDTH = CMD_WIDTH + CSR_DATA_WIDTH;

localparam  READ_REQ_CMD_VAL   = 0;
localparam  WRITE_REQ_CMD_VAL  = 1;
localparam  READ_RSP_CMD_VAL   = 2;

localparam CNT_MAX = (RSP_FIFO_WIDTH/AVST_DATA_WIDTH) - 1;
localparam CNT_WIDTH = $clog2(CNT_MAX + 1);

localparam BUF_WIDTH = AVST_CHANNEL_WIDTH + AVST_DATA_WIDTH + 2;

//register and wire declarations
genvar i;

reg                              reg_error;

wire                             valid_channel;

reg    [REQ_FIFO_WIDTH-1:0]      data_to_fifo;
wire   [RSP_FIFO_WIDTH-1:0]      rsp_fifo_wdata;
wire   [RSP_FIFO_WIDTH-1:0]      data_from_fifo;
wire   [AVST_DATA_WIDTH-1:0]     data_from_fifo_unpacked [0:CNT_MAX];

reg                              req_fifo_wrreq;
wire                             req_fifo_rdreq;
wire   [REQ_FIFO_WIDTH-1:0]      req_fifo_q;
reg                              req_fifo_rdempty;
reg                              req_fifo_wrfull;

reg                              egr_busy;
wire                             rsp_fifo_rdreq;
wire                             rsp_fifo_rdempty;
wire                             rsp_fifo_wrfull;
wire                             rsp_fifo_wrfull_dd;
reg    [3:0]                     rsp_fifo_rd_valid_sr;
reg                              rsp_fifo_rd_data_valid;

reg    [CNT_WIDTH-1:0]           cnt;

wire                             buf_in_ready;
wire                             buf_out_ready;
wire                             buf_out_valid;
wire   [BUF_WIDTH-1:0]           buf_out_data;


wire                             buf_out_egr_sop; 
wire                             buf_out_egr_eop;
wire   [AVST_CHANNEL_WIDTH-1:0]  buf_out_egr_channel;
wire   [AVST_DATA_WIDTH-1:0]     buf_out_egr_data;
wire                             rst_csr_w_n;

  IW_fpga_double_sync #(.WIDTH(1),.NUM_STAGES(2)) u_rst_clk_csr_n (
    .clk(clk_csr),
    .sig_in(rst_csr_n),
    .sig_out(rst_csr_w_n));


//Ingress ready logic
always@(*)
begin
   avst_ingr_ready   =  1'b1;

   if(valid_channel)
   begin
//      avst_ingr_ready   =  ~req_fifo_wrfull;
      avst_ingr_ready   =  ~req_fifo_wrfull & ~rsp_fifo_wrfull_dd; 
   end
   else
   begin
     avst_ingr_ready    =  buf_in_ready;
   end
end

//Checks if it is a valid endpoint 
assign valid_channel = (avst_ingr_channel==AVST_CHANNEL_ID) ? 1'b1 : 1'b0;

   assign   buf_out_egr_sop       = buf_out_valid ? buf_out_data[AVST_CHANNEL_WIDTH+AVST_DATA_WIDTH+1] : 0;
   assign   buf_out_egr_eop       = buf_out_valid ? buf_out_data[AVST_CHANNEL_WIDTH + AVST_DATA_WIDTH] : 0;
//   assign   buf_out_egr_channel   = buf_out_valid ? buf_out_data[AVST_DATA_WIDTH +: AVST_CHANNEL_WIDTH]: 0;
   assign   buf_out_egr_channel   = buf_out_data[AVST_DATA_WIDTH +: AVST_CHANNEL_WIDTH];
   assign   buf_out_egr_data      = buf_out_valid ? buf_out_data[0 +: AVST_DATA_WIDTH] : 0;

//double buffer
IW_fpga_double_buffer #(
         .WIDTH         (BUF_WIDTH)
   ) u_double_buffer (
         .clk           (clk_avst),
         .rst_n         (rst_avst_n),

         .in_ready      (buf_in_ready),
         .in_valid      (avst_ingr_valid & ~valid_channel),
         .in_data       ({avst_ingr_sop,avst_ingr_eop,avst_ingr_channel,avst_ingr_data}),

         .out_ready     (buf_out_ready),
         .out_valid     (buf_out_valid),
         .out_data      (buf_out_data)
   );

   assign buf_out_ready = (buf_out_egr_channel != AVST_CHANNEL_ID) ? avst_egr_ready & egr_busy : 1'b0;

//Data_in to req_fifo
always_ff @ (posedge clk_avst or negedge rst_avst_n) begin
   if(!rst_avst_n) begin
      data_to_fifo <= 'b0;
   end
   else if (avst_ingr_valid & avst_ingr_ready) begin
//      data_to_fifo <= {data_to_fifo[REQ_FIFO_WIDTH-AVST_DATA_WIDTH-1:0],avst_ingr_data};
      data_to_fifo <= {avst_ingr_data, (data_to_fifo[AVST_DATA_WIDTH +: (REQ_FIFO_WIDTH-AVST_DATA_WIDTH)])};
   end  
   else begin
      data_to_fifo <= data_to_fifo;
   end
end

// wr_en to req_fifo
always_ff @ (posedge clk_avst or negedge rst_avst_n) begin
   if(!rst_avst_n) begin
      req_fifo_wrreq <= 1'b0;
   end
   else if(valid_channel && avst_ingr_valid & avst_ingr_ready & avst_ingr_eop) begin
      req_fifo_wrreq <= 1'b1;
   end
   else begin
      req_fifo_wrreq <= 1'b0;
   end
end

//request fifo
   IW_fpga_async_fifo #(
            .ADDR_WD        (4),
            .DATA_WD        (REQ_FIFO_WIDTH),
            .USE_RAM_MEMORY ("True")
          ) u_req_fifo(
              .rstn        (rst_csr_n),
              .data        (data_to_fifo),
              .rdclk       (clk_csr),
              .rdreq       (req_fifo_rdreq),
              .wrclk       (clk_avst),
              .wrreq       (req_fifo_wrreq),
              .q           (req_fifo_q),
              .rdempty     (req_fifo_rdempty),
              .rdusedw     (),
              .wrfull      (req_fifo_wrfull),
              .wrusedw     ()
            );

//read request to req_fifo
assign req_fifo_rdreq = ~req_fifo_rdempty;

//extracting info from req_fifo_q 
always_ff @ (posedge clk_csr or negedge rst_csr_w_n) begin
   if(!rst_csr_w_n) begin
      csr_read     <= 1'b0;
      csr_write    <= 1'b0;
      csr_addr     <= 'b0;
      csr_wr_data  <= 'b0;
   end
   else if(!req_fifo_rdempty) begin
//      csr_read    <= (req_fifo_q[(CSR_DATA_WIDTH+CSR_ADDR_WIDTH)   +: CMD_WIDTH] == READ_REQ_CMD_VAL)  ?  1'b1  :  1'b0;
//      csr_write   <= (req_fifo_q[(CSR_DATA_WIDTH+CSR_ADDR_WIDTH)   +: CMD_WIDTH] == WRITE_REQ_CMD_VAL) ?  1'b1  :  1'b0;
//      csr_addr    <= req_fifo_q[CSR_DATA_WIDTH  +: CSR_ADDR_WIDTH];
//      csr_wr_data <= req_fifo_q[CSR_DATA_WIDTH-1:0];
      csr_read    <= (req_fifo_q[0 +: CMD_WIDTH] == READ_REQ_CMD_VAL)  ?  1'b1  :  1'b0;
      csr_write   <= (req_fifo_q[0 +: CMD_WIDTH] == WRITE_REQ_CMD_VAL) ?  1'b1  :  1'b0;
      csr_addr    <= req_fifo_q[CMD_WIDTH  +: CSR_ADDR_WIDTH];
      csr_wr_data <= req_fifo_q[(CMD_WIDTH+CSR_ADDR_WIDTH) +: CSR_DATA_WIDTH];
   end
   else begin
      csr_read     <= 1'b0;
      csr_write    <= 1'b0;
      csr_addr     <= 'b0;
      csr_wr_data  <= 'b0;
   end
end


//response fifo
   IW_fpga_async_fifo #(
            .ADDR_WD        (4),
            .DATA_WD        (RSP_FIFO_WIDTH),
            .USE_RAM_MEMORY ("True")
          ) u_rsp_fifo(
              .rstn        (rst_csr_n),
              .data        (rsp_fifo_wdata),          
              .rdclk       (clk_avst),
              .rdreq       (rsp_fifo_rdreq),
              .wrclk       (clk_csr),
              .wrreq       (csr_rd_valid),         
              .q           (data_from_fifo),
              .rdempty     (rsp_fifo_rdempty),
              .rdusedw     (),
              .wrfull      (rsp_fifo_wrfull), //Not used; assumed will never overflow
              .wrusedw     ()
            );

assign   rsp_fifo_wdata[CMD_WIDTH-1:0]                =  READ_RSP_CMD_VAL;
assign   rsp_fifo_wdata[CMD_WIDTH +: CSR_DATA_WIDTH]  =  csr_rd_data;

//read request to rsp_fifo
assign rsp_fifo_rdreq = (avst_egr_channel == AVST_CHANNEL_ID) ? avst_egr_ready & avst_egr_valid & avst_egr_eop : 1'b0;

//rsp_fifo_wrfull capture logic
IW_fpga_double_sync#(.WIDTH(1),.NUM_STAGES(2)) u_IW_fpga_double_sync_rsp_fifo_wrfull (.clk(clk_avst),.sig_in(rsp_fifo_wrfull),.sig_out(rsp_fifo_wrfull_dd));



// assign to egress channel
always_ff @ (posedge clk_avst or negedge rst_avst_n) begin
      if (!rst_avst_n) begin
        avst_egr_valid  <= 0;
        avst_egr_sop    <= 0;
        avst_egr_eop    <= 0;
        avst_egr_channel<= 0;
        avst_egr_data   <= 0;

        egr_busy        <= 0;
      end
      else begin
        if(egr_busy)
        begin
          egr_busy      <= (avst_egr_channel == AVST_CHANNEL_ID)  ? ~(avst_egr_valid & avst_egr_eop & avst_egr_ready)
                                                                : ~(buf_out_valid  &  buf_out_ready   &  buf_out_egr_eop);
//                                                              : ~(buf_out_valid  &  buf_out_ready   &  buf_out_egr_eop);
        end
        else   //~egr_busy
        begin
//          egr_busy      <= ~rsp_fifo_rdempty || (~valid_channel & avst_ingr_valid  &  avst_ingr_ready   &  avst_ingr_sop);
          egr_busy      <= ~rsp_fifo_rdempty || ( buf_out_valid  &  buf_out_egr_sop);
        end

        if(~avst_egr_ready)
        begin
           avst_egr_valid     <= avst_egr_valid;
           avst_egr_sop       <= avst_egr_sop;
           avst_egr_eop       <= avst_egr_eop;
           avst_egr_channel   <= avst_egr_channel;
           avst_egr_data      <= avst_egr_data;
        end
        else if(egr_busy)
        begin
           if(avst_egr_channel   == AVST_CHANNEL_ID) //Response Fifo
           begin
              avst_egr_valid     <= ~avst_egr_eop;
              avst_egr_sop       <= (cnt==0) ? 1'b1 : 1'b0;
              avst_egr_eop       <= (cnt==CNT_MAX) ? 1'b1 : 1'b0;
              avst_egr_channel   <= avst_egr_channel;
              avst_egr_data      <= data_from_fifo_unpacked[cnt];
           end
           else   //Bypass from Ingress port
           begin
              avst_egr_valid     <= buf_out_valid;
              avst_egr_sop       <= buf_out_egr_sop;
              avst_egr_eop       <= buf_out_egr_eop;
              avst_egr_channel   <= buf_out_egr_channel;
              avst_egr_data      <= buf_out_egr_data;
           end
         end
         else  //~egr_busy
         begin
            avst_egr_valid     <= 0;
            avst_egr_sop       <= 0;
            avst_egr_eop       <= 0;
//            avst_egr_channel   <= rsp_fifo_rdempty ? avst_ingr_channel : AVST_CHANNEL_ID;
            avst_egr_channel   <= rsp_fifo_rdempty ? buf_out_egr_channel : AVST_CHANNEL_ID;
            avst_egr_data      <= avst_egr_data;
         end
      end
end

// Unpacking data
generate
  for(i=0;i<=CNT_MAX;i++)
  begin : gen_data_from_fifo_unpacked
    assign data_from_fifo_unpacked[i] = data_from_fifo[(i*AVST_DATA_WIDTH) +: AVST_DATA_WIDTH];
  end
endgenerate


//Count logic
always_ff @ (posedge clk_avst or negedge rst_avst_n) begin
    if (!rst_avst_n) begin
        cnt <= 0;
    end
    else
    begin
      if (~egr_busy | (avst_egr_channel != AVST_CHANNEL_ID)) //keep the counter in reset
      begin
        cnt <= 0;
      end
      else if (avst_egr_ready)
      begin
        cnt <= (cnt == CNT_MAX) ? CNT_MAX : cnt + 1'b1;
      end
      else
      begin
        cnt <= cnt;
      end
    end
end



endmodule      //   IW_fpga_avst2csr

