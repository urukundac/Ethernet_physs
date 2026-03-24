//-----------------------------------------------------------------
// Intel Proprietary -- Copyright 2013 Intel -- All rights reserved
//-----------------------------------------------------------------
// Author       : rpadler
// Date Created : 2015-2-9
//-----------------------------------------------------------------
// Description:
// Sequential repeater for SBR
//
// Features:
// Configurable payload width
// non resetable flops ->therefore no scan interface requirement
//-----------------------------------------------------------------

module sbr_rpt
  #(
    parameter PAYLOAD_WIDTH = 8
    )
  (
   input logic 			    mnpput_agt,
   input logic 			    mpcput_agt,
   output logic 		    mnpcup_agt,
   output logic 		    mpccup_agt,
   input logic 			    meom_agt,
   input logic [PAYLOAD_WIDTH-1:0]  mpayload_agt,
   input logic                      mparity_agt,
   
   output logic 		    tnpput_agt,
   output logic 		    tpcput_agt,
   input logic 			    tnpcup_agt,
   input logic 			    tpccup_agt,
   output logic 		    teom_agt,
   output logic [PAYLOAD_WIDTH-1:0] tpayload_agt,
   output logic                     tparity_agt,
   
   input logic [2:0] 		    side_ism_agent_agt,
   output logic [2:0] 		    side_ism_fabric_agt,
   input logic 			    pok_agt,
   
  // Between repeater and router
  //
   output logic 		    mnpput_rtr,
   output logic 		    mpcput_rtr,
   input logic 			    mnpcup_rtr,
   input logic 			    mpccup_rtr,
   output logic 		    meom_rtr,
   output logic [PAYLOAD_WIDTH-1:0] mpayload_rtr,
   output logic                     mparity_rtr,
   
   input logic 			    tnpput_rtr,
   input logic 			    tpcput_rtr,
   output logic 		    tnpcup_rtr,
   output logic 		    tpccup_rtr,
   input logic 			    teom_rtr,
   input logic [PAYLOAD_WIDTH-1:0]  tpayload_rtr,
   input logic                      tparity_rtr,
   
   output logic [2:0] 		    side_ism_agent_rtr,
   input logic [2:0] 		    side_ism_fabric_rtr,
   output logic 		    pok_rtr,

   input logic 			    clk
   );



  /*********************
   *
   * Implement repeater flops. Every single sideband interface signal will be repeated
   * These flops are not resetable.  This is by design.  They will naturally be reset by
   * the flops driving the interface during reset propagation before reset is released. 
   */

  always_ff @(posedge clk) begin
  
    mnpput_rtr 		 <= mnpput_agt;
    mpcput_rtr 		 <= mpcput_agt;
    mnpcup_agt 		 <= mnpcup_rtr;
    mpccup_agt 		 <= mpccup_rtr;
    meom_rtr 		 <= meom_agt;
    mpayload_rtr 	 <= mpayload_agt;
    mparity_rtr          <= mparity_agt;
    
    tnpput_agt 		 <= tnpput_rtr;
    tpcput_agt 		 <= tpcput_rtr;
    tnpcup_rtr 		 <= tnpcup_agt;
    tpccup_rtr 		 <= tpccup_agt;
    teom_agt 		 <= teom_rtr;
    tpayload_agt 	 <= tpayload_rtr;              
    tparity_agt          <= tparity_rtr;
     
    side_ism_fabric_agt  <= side_ism_fabric_rtr;
    side_ism_agent_rtr   <= side_ism_agent_agt;
    pok_rtr              <= pok_agt;
        
  end

endmodule

