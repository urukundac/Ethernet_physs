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

module mdio_core (

  // outputs
  mdio_out_en_0_clause22,
  mdio_out_en_1_clause45,
  mdio_out_en_1_clause22,
  mdio_out_0,
  mdio_out_1_clause45,
  mdio_out_1_clause22,
  mdio_en_clause45,
  mdc,

  mdio_busy,
  mdio_rd_done,
  mdio_read_data,

  mdio_test_signals,

  // inputs
  begin_mdio,
  preamble_suppress,
  clause_45,
  op_code,
  mdio_interface_select,
  port_addr,
  device_addr,
  addr_or_data,

  mdio_clk_offset,
  mdio_clk_period,

  mdio_in_0,
  mdio_in_1_clause45,
  mdio_in_1_clause22,

  clk_core,
  swreset,
  reset_n
);

  // outputs
output  mdio_out_en_0_clause22;
output  mdio_out_en_1_clause45;
output  mdio_out_en_1_clause22;
output  mdio_out_0;
output  mdio_out_1_clause45;
output  mdio_out_1_clause22;
output  mdio_en_clause45;
output  mdc;

output  mdio_busy;
output  mdio_rd_done;
output [15:0]   mdio_read_data;

output[9:0] mdio_test_signals;
  
  // inputs
input      begin_mdio;
input      preamble_suppress;
input      clause_45;
input      mdio_interface_select;
input[1:0] op_code;
input[4:0] port_addr;
input[4:0] device_addr;
input[15:0]addr_or_data;
input[7:0] mdio_clk_offset;
input[7:0] mdio_clk_period;
input mdio_in_0;
input mdio_in_1_clause45;
input mdio_in_1_clause22;

input  clk_core;   // 250MHz core clock
input  swreset;
input  reset_n;


// input/output parameters


/***************************** Local Variables ********************************/

reg  mdio_in_sel;
reg  mdio_out_en_0_clause22;
reg  mdio_out_en_1_clause45;
reg  mdio_out_en_1_clause22;
reg  mdio_out_0;
reg  mdio_out_1_clause45;
reg  mdio_out_1_clause22;
reg  mdio_en_clause45;

wire   mdio_out_en;
wire   mdio_out;
wire   mdio_busy;
wire[15:0]   mdio_read_data;
wire   mdio_rd_done;
wire   mdc;

wire  begin_mdio;
wire  preamble_suppress;
wire  clause_45;
wire[1:0]  op_code;
wire  mdio_interface_select;
wire[4:0]  port_addr;
wire[4:0]  device_addr;
wire[15:0]  addr_or_data;
wire[3:0]   current_mdio_state;

/***************************** NON REGISTERED OUTPUTS *************************/

wire[9:0] mdio_test_signals = {mdio_interface_select, clause_45, mdio_out_en, 
			       mdio_busy, op_code[1:0], current_mdio_state[3:0]};

/***************************** REGISTERED OUTPUTS *****************************/


/***************************** PROGRAM BODY ***********************************/
// Removed by jo 5/8/2006.
//wire [3:0] spare_mdio_vlo_wire;
//VLOX1S1T12W spare_mdio_vlo_[0:3] (.Z(spare_mdio_vlo_wire));
//SGMPCS1T12W spare_mdio_[0:3] (
//  .DIN(spare_mdio_vlo_wire),
//  .CK(clk_core)
//);

always @(mdio_interface_select or clause_45 or mdio_in_0 or
         mdio_in_1_clause45 or mdio_in_1_clause22)
begin
  case({mdio_interface_select, clause_45})
    2'b00: mdio_in_sel = mdio_in_0;
    2'b10: mdio_in_sel = mdio_in_1_clause22;
    2'b11: mdio_in_sel = mdio_in_1_clause45;
    default: mdio_in_sel = 0;
  endcase
end


always @(mdio_interface_select or clause_45 or mdio_out)
begin
  case({mdio_interface_select, clause_45})
    2'b00: begin 
         mdio_out_0 = mdio_out;
         mdio_out_1_clause22 = 1'd0;
         mdio_out_1_clause45 = 1'd0;
        end
    2'b10: begin 
         mdio_out_0 = 1'd0;
         mdio_out_1_clause22 = mdio_out;
         mdio_out_1_clause45 = 1'd0;
        end
    2'b11: begin 
         mdio_out_0 = 1'd0;
         mdio_out_1_clause22 = 1'd0;
         mdio_out_1_clause45 = mdio_out;
        end
    default: begin 
         mdio_out_0 = 1'd0;
         mdio_out_1_clause22 = 1'd0;
         mdio_out_1_clause45 = 1'd0;
        end
  endcase
end

always @(posedge clk_core or negedge reset_n)
begin
	if ( !reset_n) begin
		mdio_out_en_0_clause22 <= 0;
		mdio_out_en_1_clause22 <= 0;
		mdio_out_en_1_clause45 <= 0;
                mdio_en_clause45 <= 0;
	end
	else if ( swreset) begin
		mdio_out_en_0_clause22 <= 0;
		mdio_out_en_1_clause22 <= 0;
		mdio_out_en_1_clause45 <= 0;
                mdio_en_clause45 <= 0;
	end
	else begin
                mdio_en_clause45 <= clause_45;
		case({mdio_interface_select, clause_45})
		2'b00: begin 
			mdio_out_en_0_clause22 <= mdio_out_en;
			mdio_out_en_1_clause22 <= 1'd0;
			mdio_out_en_1_clause45 <= 1'd0;
		end
		2'b10: begin 
			mdio_out_en_0_clause22 <= 1'd0;
			mdio_out_en_1_clause22 <= mdio_out_en;
			mdio_out_en_1_clause45 <= 1'd0;
		end
		2'b11: begin 
			mdio_out_en_0_clause22 <= 1'd0;
			mdio_out_en_1_clause22 <= 1'd0;
			mdio_out_en_1_clause45 <= mdio_out_en;
		end
		default: begin 
			mdio_out_en_0_clause22 <= 1'd0;
			mdio_out_en_1_clause22 <= 1'd0;
			mdio_out_en_1_clause45 <= 1'd0;
		end
		endcase
	end
end

mdio_sm mdio_sm(

  // outputs
  .mdio_out_en(mdio_out_en),
  .mdio_out(mdio_out),
  .mdio_busy(mdio_busy),
  .mdio_read(mdio_read_data),
  .mdio_rd_done(mdio_rd_done),
  .mdc(mdc),
  .current_mdio_state(current_mdio_state),
  
  // inputs
  .mdio_in(mdio_in_sel),
  .begin_mdio(begin_mdio),
  .preamble_suppress(preamble_suppress),
  .clause_45(clause_45),
  .op_code(op_code),
  .port_addr(port_addr), 
  .device_addr(device_addr), 
  .addr_or_data(addr_or_data),
  .mdio_clk_offset(mdio_clk_offset),
  .mdio_clk_period(mdio_clk_period),

  .clk(clk_core),
  .swreset(swreset),
  .reset_n(reset_n)

);


/***************************** NEXT STATE DECODING ***************************/

// the significant part of the state machine



/***************************** STATE ASSIGNMENT ******************************/

// needed just to infer state machine

endmodule
