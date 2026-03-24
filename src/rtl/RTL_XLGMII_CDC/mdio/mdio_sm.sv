/*******************************************************************************
-----------------------------------------------------------------
-- >>>>>>>>>>>>>>>>>>>    NOTIFICATION     <<<<<<<<<<<<<<<<<<<<<<
-----------------------------------------------------------------
Copyright (c) 2003 Agere Systems Inc.
All Rights Reserved

This is unpublished proprietary information of Agere Systems Inc.
This copyright notice does not evidence publication.

The use of the software, documentation, methodologies and other
information contained herein is governed solely by the associated
license agreements.  Any inconsistent use shall be deemed to be a
misappropriation of the intellectual property of Agere Systems
Inc. and treated accordingly.
-----------------------------------------------------------------


$File$
$Date: Wed Oct 10 16:44:36 2012 $
$Revision: 1.1 $


*******************************************************************************/

module mdio_sm (

  // outputs
  mdio_out_en,
  mdio_out,
  mdio_busy,
  mdio_read,
  mdio_rd_done,
  mdc,
  current_mdio_state,
  
  // inputs
  mdio_in,
  begin_mdio,
  preamble_suppress,
  clause_45,
  op_code,
  port_addr, 
  device_addr, 
  addr_or_data,
  mdio_clk_offset,
  mdio_clk_period,

  clk,
  swreset,
  reset_n
);

parameter sm_bits=4;

  // outputs
output  mdio_out_en;
output  mdio_out;
output  mdio_busy;
output[15:0]  mdio_read;
output  mdio_rd_done;
output  mdc;
output[sm_bits-1:0]   current_mdio_state;
  
  // inputs
input mdio_in;
input  begin_mdio;
input  preamble_suppress;
input  clause_45;
input[1:0]  op_code;
input[4:0]  port_addr; 
input[4:0]  device_addr; 
input[15:0]  addr_or_data;
input[7:0] mdio_clk_offset;
input[7:0] mdio_clk_period;		// This is the half period

input  clk;
input  swreset;
input  reset_n;


// input/output parameters


//output vlan_tag_differ;
//parameter half_mdc_period = 50;
//parameter mdio_offset = 5;

parameter   
	IDLE = 4'd0,
	PREAMBLE = 4'd1, 
	START_1 = 4'd2,
	START_2 = 4'd3,
	OPERATION_1 = 4'd4,
	OPERATION_2 = 4'd5,
        PORT_ADDR = 4'd6,
	DEVICE_ADDR = 4'd7,
        READ = 4'd8,
	TURN_AROUND_1 = 4'd9,
	TURN_AROUND_2 = 4'd10,
	WR_DATA = 4'd11;

/***************************** Local Variables ********************************/

reg [sm_bits-1:0] current_mdio_state;
reg [sm_bits-1:0] next_mdio_state;

reg  mdio_out_en_int,mdio_out_en ;
reg  mdio_out_int, mdio_out;
reg  mdio_busy_int, mdio_busy ;
reg[15:0]  mdio_read_int, mdio_read;
reg mdio_rd_done, mdio_rd_done_int;
reg  start_mdio_count_int, start_mdio_count ;

reg[4:0]    port_address, port_address_int;
reg[4:0]    device_address, device_address_int;
reg[15:0]   address_or_data, address_or_data_int;
reg[7:0] mdc_count;
reg[4:0] mdio_count;
reg      mdc;
reg begin_mdio_hold, begin_mdio_sm;

reg mdio_in_reg;	// Registered on rising edge of "mdc"

/***************************** NON REGISTERED OUTPUTS *************************/


/***************************** REGISTERED OUTPUTS *****************************/


/***************************** PROGRAM BODY ***********************************/

/* mdc generation. One programmble 8 counter is used to generate mdc and
 enable signal for state transition */

wire half_period_done = (mdc_count == mdio_clk_period) && (mdio_clk_period != 0);
wire mdio_sample = ((mdc_count == mdio_clk_offset) && mdc);

always @(posedge clk or negedge reset_n)
if (!reset_n) mdc_count <= 8'd0;
else if (swreset) mdc_count <= 8'd0;
else if (mdio_clk_period == 0) mdc_count <= 8'd0;
else if (half_period_done) mdc_count <= 8'd0;
else mdc_count <= mdc_count + 1; // spyglass disable Reset_sync01

always @(posedge clk or negedge reset_n)
if (!reset_n) mdc <= 1'd0;
else if (swreset) mdc <= 1'd0;
else if (mdio_clk_period == 0) mdc <= 1'd0;
else if (half_period_done) mdc <= !mdc;
else mdc <= mdc;

/**** mdio_count ****/

always @(posedge clk or negedge reset_n)
if (!reset_n) mdio_count <= 5'd0;
else if (swreset) mdio_count <= 5'd0;
else if (start_mdio_count_int && mdio_sample) mdio_count <= 5'd0;
else if (mdio_sample) mdio_count <= mdio_count + 1;
else mdio_count <= mdio_count;

// generate mdio_begin_sm

always @(posedge clk or negedge reset_n)
if (!reset_n) begin_mdio_hold <= 0;
else if (swreset) begin_mdio_hold <= 0;
else if (begin_mdio_sm) begin_mdio_hold <= 0;
else if (begin_mdio) begin_mdio_hold <= 1;
else begin_mdio_hold <= begin_mdio_hold;


always @(posedge clk or negedge reset_n)
if (!reset_n) begin_mdio_sm <= 0;
else if (swreset) begin_mdio_sm <= 0;
else if (mdio_sample) begin_mdio_sm <= begin_mdio_hold;
else begin_mdio_sm <= begin_mdio_sm;

/***************************** NEXT STATE DECODING ***************************/

// the significant part of the state machine

always @(current_mdio_state or begin_mdio_sm or preamble_suppress or clause_45 
	or mdio_count or op_code or port_addr or device_addr or addr_or_data or
	mdio_read or mdio_in_reg or port_address or device_address or 
        address_or_data or mdio_read)
begin
  mdio_out_en_int = 0;
  mdio_out_int = 0;
  mdio_busy_int = 0;
  mdio_read_int = 16'd0;
  mdio_rd_done_int = 1'd0;
  start_mdio_count_int = 0;
  port_address_int = 5'd0;
  device_address_int = 5'd0;
  address_or_data_int = 16'd0;
  case(current_mdio_state)
  IDLE: 
    begin
      if (begin_mdio_sm && preamble_suppress && !clause_45)
        begin
          next_mdio_state = START_1;
          mdio_out_en_int = 1;
          mdio_out_int = 0;
          mdio_busy_int = 1;
          start_mdio_count_int = 1;
        end
      else if (begin_mdio_sm)
        begin
          next_mdio_state = PREAMBLE;
          mdio_out_en_int = 1;
          mdio_out_int = 1;
          mdio_busy_int = 1;
          start_mdio_count_int = 1;
        end
      else 
        begin
          next_mdio_state = IDLE;
        end
    end

  PREAMBLE:
    begin
      if (mdio_count == 5'd31)
        begin
          next_mdio_state = START_1;
          mdio_out_en_int = 1;
          mdio_out_int = 0;
          mdio_busy_int = 1;
          start_mdio_count_int = 1;
        end
      else
        begin
          next_mdio_state = PREAMBLE;
          mdio_out_en_int = 1;
          mdio_out_int = 1;
          mdio_busy_int = 1;
        end
    end

  START_1:
    begin
      next_mdio_state = START_2;
      mdio_out_en_int = 1;
      mdio_out_int = clause_45 ? 1'b0 : 1'b1;
      mdio_busy_int = 1;
    end

  START_2:
    begin
      next_mdio_state = OPERATION_1;
      mdio_out_en_int = 1;
      mdio_out_int = op_code[1];
      mdio_busy_int = 1;
    end

  OPERATION_1:
    begin
      next_mdio_state = OPERATION_2;
      mdio_out_en_int = 1;
      mdio_out_int = op_code[0];
      mdio_busy_int = 1;
    end

  OPERATION_2:
    begin
      next_mdio_state = PORT_ADDR;
      mdio_out_en_int = 1;
      mdio_out_int = port_addr[4];
      port_address_int = {port_addr[3:0], 1'd0};
      mdio_busy_int = 1;
    end

  PORT_ADDR:
    begin
      if (mdio_count == 5'd8)
        begin
          next_mdio_state = DEVICE_ADDR;
          mdio_out_en_int = 1;
          mdio_out_int = device_addr[4];
          device_address_int = {device_addr[3:0], 1'd0};
          mdio_busy_int = 1;
        end
      else
        begin
          next_mdio_state = PORT_ADDR;
          mdio_out_en_int = 1;
          mdio_out_int = port_address[4];
          port_address_int = {port_address[3:0], 1'd0};
          mdio_busy_int = 1;
        end
    end

  DEVICE_ADDR:
    begin
      if ((mdio_count == 5'd13) && op_code[1])
        begin
          next_mdio_state = READ;
          mdio_out_en_int = 0;
          mdio_read_int = {mdio_read[14:0], mdio_in_reg};
          mdio_busy_int = 1;
        end
      else if (mdio_count == 5'd13) 
        begin
          next_mdio_state = TURN_AROUND_1;
          mdio_out_en_int = 1;
          mdio_out_int = 1;
          mdio_busy_int = 1;
        end
      else
        begin
          next_mdio_state = DEVICE_ADDR;
          mdio_out_en_int = 1;
          mdio_out_int = device_address[4];
          device_address_int = {device_address[3:0], 1'd0};
          mdio_busy_int = 1;
        end
    end

  READ:
    begin
      if (mdio_count == 31)
        begin
          next_mdio_state = IDLE;
          mdio_out_en_int = 0;
          mdio_busy_int = 0;
          mdio_read_int = {mdio_read[14:0], mdio_in_reg};
        //  mdio_read_int = mdio_read;
          mdio_rd_done_int = 1'd1;
        end
      else
        begin
          next_mdio_state = READ;
          mdio_out_en_int = 0;
          mdio_read_int = {mdio_read[14:0], mdio_in_reg};
          mdio_busy_int = 1;
        end
    end

  TURN_AROUND_1:
    begin
      next_mdio_state = TURN_AROUND_2;
      mdio_out_en_int = 1;
      mdio_out_int = 0;
      mdio_busy_int = 1;
    end

  TURN_AROUND_2:
    begin
      next_mdio_state = WR_DATA;
      mdio_out_en_int = 1;
      mdio_out_int = addr_or_data[15];
      address_or_data_int = {addr_or_data[14:0], 1'd0};
      mdio_busy_int = 1;
    end

  WR_DATA:
    begin
      if (mdio_count == 31)
        begin
          next_mdio_state = IDLE;
          mdio_out_en_int = 0;
          mdio_busy_int = 0;
        end
      else
        begin
          next_mdio_state = WR_DATA;
          mdio_out_en_int = 1;
          mdio_out_int = address_or_data[15];
          address_or_data_int = {address_or_data[14:0], 1'd0};
          mdio_busy_int = 1;
        end
     end
  default : next_mdio_state = IDLE;
  endcase
end



/***************************** STATE ASSIGNMENT ******************************/

// needed just to infer state machine

always @( posedge clk or negedge reset_n )
if (!reset_n)
  begin
    current_mdio_state <= IDLE;
    mdio_out_en <= 0;
    mdio_out <= 0;
    mdio_busy <= 0;
    mdio_read <= 16'd0;
    start_mdio_count <= 0;
    port_address <= 5'd0;
    device_address <= 5'd0;
    address_or_data <= 16'd0;
    mdio_rd_done <= 1'd0;
  end
else if (swreset)
  begin
    current_mdio_state <= IDLE;
    mdio_out_en <= 0;
    mdio_out <= 0;
    mdio_busy <= 0;
    mdio_read <= 16'd0;
    start_mdio_count <= 0;
    port_address <= 5'd0;
    device_address <= 5'd0;
    address_or_data <= 16'd0;
    mdio_rd_done <= 1'd0;
  end
else if (mdio_sample)
  begin
    current_mdio_state <= next_mdio_state;
    mdio_out_en <= mdio_out_en_int;
    mdio_out <= mdio_out_int;
    mdio_busy <= mdio_busy_int;
    mdio_read <= mdio_read_int;
    start_mdio_count <= start_mdio_count_int;
    port_address <= port_address_int;	// spyglass disable Clock_info03b
    device_address <= device_address_int; // spyglass disable Clock_info03b
    address_or_data <= address_or_data_int; // spyglass disable Clock_info03b
    mdio_rd_done <= mdio_rd_done_int;
  end
else
  begin
    current_mdio_state <= current_mdio_state;
    mdio_out_en <= mdio_out_en;
    mdio_out <= mdio_out;
    mdio_busy <= mdio_busy;
    mdio_read <= mdio_read;
    start_mdio_count <= start_mdio_count;
    port_address <= port_address;
    device_address <= device_address;
    address_or_data <= address_or_data;
    mdio_rd_done <= mdio_rd_done;
  end

always @( posedge clk or negedge reset_n )
if (!reset_n)
	mdio_in_reg <= 0;
else if (swreset)
	mdio_in_reg <= 0;
else if (half_period_done && (mdc == 0))
	mdio_in_reg <= mdio_in;

endmodule
