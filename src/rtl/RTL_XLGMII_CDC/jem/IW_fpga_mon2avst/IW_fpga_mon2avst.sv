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

module IW_fpga_mon2avst #(

  parameter DBG_CAP_DATA_WIDTH  = 16'h100,
  parameter NUM_CAP_INTFS       = 1,
  parameter AV_ST_DATA_W        = 32,
  parameter AV_ST_SYMBOL_W      = 8,
  parameter AV_ST_EMPTY_W       = (AV_ST_DATA_W <= AV_ST_SYMBOL_W) ? 1 : $clog2(AV_ST_DATA_W/AV_ST_SYMBOL_W),
  parameter USE_BIG_ENDIAN      = 1,
  parameter HEADER_DATA_W       = 32,

  parameter int CHNL_Q_IDX_LIST  [NUM_CAP_INTFS-1:0]    = '{1}, //queue index list for capture channel
  parameter int CHNL_DATA_W_LIST [NUM_CAP_INTFS-1:0]    = '{0},
  parameter int CHNL_VALID_BIN_W                        =  (NUM_CAP_INTFS==1)?1:$clog2(NUM_CAP_INTFS)
) (
  //clk and rst
  input  logic                                                        clk,
  input  logic                                                        rst_n,

  //Avalon-ST interface
  input  reg                                                          avl_st_ready,
  output reg                                                          avl_st_valid,
  output reg                                                          avl_st_startofpacket,
  output reg                                                          avl_st_endofpacket,
  output wire            [AV_ST_EMPTY_W-1:0]                          avl_st_empty,
  output wire            [AV_ST_DATA_W-1:0]                           avl_st_data,
  
  //monitor interface
  input  reg             [CHNL_VALID_BIN_W-1:0]                       chnl_cap_rdata_valid_bin,
  input  reg             [NUM_CAP_INTFS-1:0]                          chnl_cap_rdata_valid,
  input  reg             [DBG_CAP_DATA_WIDTH-1:0]                     chnl_cap_rdata [NUM_CAP_INTFS-1:0],
  output wire                                                         chnl_cap_rden

);


localparam PAYLOAD_DATA_RESIDUE       = DBG_CAP_DATA_WIDTH  % AV_ST_DATA_W;
localparam NUM_FLITS_PAYLOAD          = (PAYLOAD_DATA_RESIDUE > 0)  ? (DBG_CAP_DATA_WIDTH / AV_ST_DATA_W) + 1 : DBG_CAP_DATA_WIDTH  / AV_ST_DATA_W;

localparam HEADER_DATA_RESIDUE        = HEADER_DATA_W  % AV_ST_DATA_W;
localparam NUM_FLITS_HEADER           = (HEADER_DATA_RESIDUE > 0)  ? (HEADER_DATA_W / AV_ST_DATA_W) + 1 : HEADER_DATA_W / AV_ST_DATA_W;

localparam NUM_FLITS_TOTAL            = NUM_FLITS_PAYLOAD + NUM_FLITS_HEADER;
localparam DATA_PTR_W                 = $clog2(NUM_FLITS_TOTAL) + 1;

localparam AV_ST_NUM_SYMBOLS          = AV_ST_DATA_W/AV_ST_SYMBOL_W;

localparam AV_ST_NON_EMPTY_SYMBOLS    = (PAYLOAD_DATA_RESIDUE == 0) ? AV_ST_NUM_SYMBOLS :
                                        (PAYLOAD_DATA_RESIDUE % AV_ST_SYMBOL_W) ? (PAYLOAD_DATA_RESIDUE / AV_ST_SYMBOL_W) + 1 : (PAYLOAD_DATA_RESIDUE / AV_ST_SYMBOL_W);
localparam AV_ST_EMPTY_SYMBOLS        = AV_ST_NUM_SYMBOLS - AV_ST_NON_EMPTY_SYMBOLS;

//---------------------------------------------------------------------------------------------------------------a
//Wire/reg diclaration
//----------------------------------------------------------------------------------------------------------------
genvar  i,j,symbol;
reg   [DATA_PTR_W-1:0]         dataPtr;
reg   [AV_ST_DATA_W-1:0]       st_data;
wire  [AV_ST_DATA_W-1:0]       payload_flits [NUM_FLITS_PAYLOAD:0];
wire  [AV_ST_DATA_W-1:0]       header_flits  [NUM_FLITS_HEADER-1:0];
wire                           data_valid;
wire  [HEADER_DATA_W-1:0]      header_data;
wire  [DBG_CAP_DATA_WIDTH-1:0] cap_rdata; 
wire                           cap_rdata_valid;
wire  [31:0]                   chnl_q_idx_list[NUM_CAP_INTFS-1:0];
wire  [DATA_PTR_W-1:0]         num_flits_to_transmit;
wire  [DATA_PTR_W-1:0]         num_flits_to_transmit_list[NUM_CAP_INTFS-1:0];

reg   [15:0          ]         packet_count;

wire  [AV_ST_DATA_W-1:0]       avl_st_data_swapped; //atspeed related change
//----------------------------------------------------------------------------------------------------------------


//Initialize the header data
generate
  for(i=0;i<NUM_CAP_INTFS;i++)
  begin : gen_chnl_q_idx_list
    assign chnl_q_idx_list[i] = CHNL_Q_IDX_LIST[i];
  end
endgenerate

generate
  if(HEADER_DATA_W >= 32 ) begin
    assign header_data[7:0]   = chnl_q_idx_list[chnl_cap_rdata_valid_bin];
    assign header_data[15:8]  = (DBG_CAP_DATA_WIDTH % 8 ) ? (DBG_CAP_DATA_WIDTH/8) + 1 : DBG_CAP_DATA_WIDTH/8;
    assign header_data[31:16] = packet_count;
  end
endgenerate


// Packet count is added in the header field to help in debug
always@(posedge clk,  negedge rst_n)
begin
  if(~rst_n)
    packet_count    <= 0;
  else
    if(avl_st_startofpacket & avl_st_ready & avl_st_valid)
      packet_count  <= packet_count + 1;
end


//assign avl_st_empty
assign avl_st_empty  = AV_ST_EMPTY_SYMBOLS;

assign cap_rdata = chnl_cap_rdata[chnl_cap_rdata_valid_bin];
assign cap_rdata_valid = |chnl_cap_rdata_valid;

//calculate num flits to transmit for different input data width
generate
  for(j=0;j<NUM_CAP_INTFS;j++)
  begin:gen_num_flit_list
    localparam NUM_FLITS = (CHNL_DATA_W_LIST[j] % AV_ST_DATA_W) ? (CHNL_DATA_W_LIST[j]/AV_ST_DATA_W + 1): (CHNL_DATA_W_LIST[j]/AV_ST_DATA_W);
    assign num_flits_to_transmit_list[j] = NUM_FLITS + NUM_FLITS_HEADER;
  end
endgenerate

assign num_flits_to_transmit = num_flits_to_transmit_list[chnl_cap_rdata_valid_bin];

//Slice rdata into a 2D array of flits
generate
  for(i=0;i<NUM_FLITS_PAYLOAD;i++)
  begin : gen_payload_flits
    if((i==NUM_FLITS_PAYLOAD-1) &&  (PAYLOAD_DATA_RESIDUE > 0))
    begin
      assign  payload_flits[i]  = { {(AV_ST_DATA_W-PAYLOAD_DATA_RESIDUE){1'b0}} //zero pad
                                   ,cap_rdata[(i*AV_ST_DATA_W)  +:  PAYLOAD_DATA_RESIDUE]
                                  };
    end
    else
    begin
      assign  payload_flits[i]  = cap_rdata[(i*AV_ST_DATA_W)  +:  AV_ST_DATA_W];
    end
  end
endgenerate
//Add one extra flit for payload_flits so that the data will be held properly when dataPtr==NUM_FLITS_PAYLOAD  condition
assign payload_flits[NUM_FLITS_PAYLOAD] =  payload_flits[NUM_FLITS_PAYLOAD-1];

//Slice header into a 2D array of flits
generate
  for(i=0;i<NUM_FLITS_HEADER;i++)
  begin : gen_header_flits
    if((i==NUM_FLITS_HEADER-1) &&  (HEADER_DATA_RESIDUE > 0))
    begin
      assign  header_flits[i]  = { {(AV_ST_DATA_W-HEADER_DATA_RESIDUE){1'b0}} //zero pad
                                   ,header_data[(i*AV_ST_DATA_W)  +:  HEADER_DATA_RESIDUE]
                                  };
    end
    else
    begin
      assign  header_flits[i]  = header_data[(i*AV_ST_DATA_W)  +:  AV_ST_DATA_W];
    end
  end
endgenerate


always@(posedge clk,  negedge rst_n)
begin
  if(~rst_n)
  begin
    dataPtr                <= {DATA_PTR_W{1'b0}};

    avl_st_valid           <= 0;
    avl_st_startofpacket   <= 0;
    avl_st_endofpacket     <= 0;
    st_data                <= 0;
  end
  else
  begin
    if(dataPtr == num_flits_to_transmit) //freeze the counter here until chnl_cap_rden is asserted
    begin
      dataPtr            <= chnl_cap_rden ? 0 : dataPtr;
    end
    else
    begin
      dataPtr            <= (avl_st_ready & data_valid) ? dataPtr + 1'b1 : dataPtr;
    end

    if(avl_st_ready & data_valid)
    begin
      st_data            <= (dataPtr < NUM_FLITS_HEADER) ? header_flits[dataPtr] : payload_flits[dataPtr-NUM_FLITS_HEADER];
    end
    else
    begin
      st_data            <=  st_data;
    end

    if(avl_st_startofpacket) //Wait for first flit to be properly driven
    begin
      avl_st_startofpacket  <= avl_st_ready ? 1'b0 : avl_st_startofpacket;
    end
    else //Wait for first flit
    begin
      avl_st_startofpacket  <= (dataPtr==0) ? (cap_rdata_valid & avl_st_ready) : avl_st_startofpacket;
    end

    if(avl_st_endofpacket) //wait for the last flit to be properly transferred
    begin
      avl_st_endofpacket <= avl_st_ready ? 1'b0 : avl_st_endofpacket;
    end
    else //Check when to assert avl_st_endofpacket
    begin
      avl_st_endofpacket <= (dataPtr==(num_flits_to_transmit-1)) ? avl_st_ready : avl_st_endofpacket;
    end


    if(avl_st_valid) //check when to deassert
    begin
      avl_st_valid       <= avl_st_endofpacket ? ~avl_st_ready : avl_st_valid;
    end
    else //check when to assert
    begin
      avl_st_valid       <= cap_rdata_valid & avl_st_ready;
    end

  end
end

assign data_valid = (dataPtr < NUM_FLITS_TOTAL) ? cap_rdata_valid : 1'b0;
assign chnl_cap_rden   = avl_st_endofpacket & avl_st_ready;


//Do byte ordering of avl_st_data based on USE_BIG_ENDIAN
generate
  if(USE_BIG_ENDIAN) begin
    for(symbol=0;symbol<AV_ST_NUM_SYMBOLS;symbol++)
    begin:gen_st_data
      assign avl_st_data_swapped [symbol*AV_ST_SYMBOL_W +: AV_ST_SYMBOL_W] =  st_data[(((AV_ST_NUM_SYMBOLS-symbol)*AV_ST_SYMBOL_W)-1) -: AV_ST_SYMBOL_W];
    end
  end
  else begin
    assign avl_st_data_swapped = st_data;
  end
endgenerate

  if(USE_BIG_ENDIAN)begin
    if(AV_ST_DATA_W == 64)begin
      assign avl_st_data = {avl_st_data_swapped[31:0],avl_st_data_swapped[63:32]};
    end else begin
      if(AV_ST_DATA_W == 32) begin
        assign avl_st_data = avl_st_data_swapped;
      end else begin
        unsupported_data_swap unsupported_data_swap();
      end
    end
  end else begin
    assign avl_st_data = avl_st_data_swapped;
  end

`ifdef  FPGA_SIM
  avl_st_intf #(.SYMBOL_WIDTH(AV_ST_SYMBOL_W),.DATA_WIDTH(AV_ST_DATA_W),.CHNNL_WIDTH(1)) avl_st_mon_intf  (.clk(clk),.rst_n(rst_n));

  assign  avl_st_mon_intf.ready         = avl_st_ready;
  assign  avl_st_mon_intf.valid         = avl_st_valid;
  assign  avl_st_mon_intf.startofpacket = avl_st_startofpacket;
  assign  avl_st_mon_intf.endofpacket   = avl_st_endofpacket;
  assign  avl_st_mon_intf.empty         = avl_st_empty;
  assign  avl_st_mon_intf.data          = avl_st_data;

  assign  avl_st_mon_intf.channel       = 'h0;
`endif

endmodule //IW_fpga_mon2avst
