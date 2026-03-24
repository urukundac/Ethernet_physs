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
 -- Project Code      : axi_fabric
 -- Module Name       : axi_fabric_arb
 -- Author            : Gregory James
 -- Associated modules: 
 -- Function          : A parameterizable arbiter.
 --------------------------------------------------------------------------
*/

`timescale 1ns / 10ps


module axi_fabric_arb #(
//----------------------- Global parameters Declarations ------------------
   parameter  NUM_AGENTS    = 2
  ,parameter  AGENT_ID_W    = (NUM_AGENTS > 1) ? $clog2(NUM_AGENTS) : 1
  ,parameter  PRIORITY_W    = 4
  ,parameter  string  MODE  = "NORMAL"  //Select between NORMAL & PACKET

) (

   input  logic                   clk
  ,input  logic                   rst_n

  ,input  logic [NUM_AGENTS-1:0]  agent_req
  ,input  logic [NUM_AGENTS-1:0]  agent_req_last  //only valid when MODE="PACKET"

  ,output logic                   gnt_valid
  ,output logic [AGENT_ID_W-1:0]  gnt_agent_id
  ,output logic [NUM_AGENTS-1:0]  gnt_agent_sel

  //For early warning
  ,output logic                   gnt_valid_next
  ,output logic [AGENT_ID_W-1:0]  gnt_agent_id_next
  ,output logic [NUM_AGENTS-1:0]  gnt_agent_sel_next

);

//----------------------- Import Packages ---------------------------------


//----------------------- Internal Parameters -----------------------------


//----------------------- Internal Register Declarations ------------------
  logic [NUM_AGENTS-1:0]  agent_req_sop;
  logic [PRIORITY_W-1:0]  agent_priority_list [NUM_AGENTS-1:0];


//----------------------- Internal Wire Declarations ----------------------
  wire  [AGENT_ID_W-1:0]  agent_id_list   [NUM_AGENTS-1:0];
  logic [PRIORITY_W-1:0]  agent_active_priority_list [NUM_AGENTS-1:0];
  logic [PRIORITY_W-1:0]  agent_priority_sel_tree [NUM_AGENTS-1:0];
  logic [AGENT_ID_W-1:0]  agent_id_sel_tree [NUM_AGENTS-1:0];

  wire  [AGENT_ID_W-1:0]  final_agent_id_sel;
  logic [NUM_AGENTS-1:0]  gnt_agent_sel_int;

  wire  [NUM_AGENTS-1:0]  agent_req_valid;


  genvar  i;


//----------------------- Start of Code -----------------------------------

  assign  agent_req_valid = agent_req & ~gnt_agent_sel;

  generate
    for(i=0; i<NUM_AGENTS; i++)
    begin : gen_agent_priority
      if(MODE ==  "NORMAL")
      begin
        always@(posedge clk,  negedge rst_n)
        begin
          if(~rst_n)
          begin
            agent_priority_list[i]      <=  'h1;
          end
          else
          begin
            if(agent_req[i])
            begin
              if(gnt_agent_sel_int[i]) //This agent will be selected in the next cycle
              begin
                agent_priority_list[i]  <=  (agent_priority_list[i] == 'h1) ? 'h1 : agent_priority_list[i]  - 1'b1;
              end
              else if(~gnt_agent_sel[i])  //Still waiting
              begin
                agent_priority_list[i]  <=  (agent_priority_list[i] == 'h1) ? 'h1 : agent_priority_list[i]  + 1'b1;
              end
            end
            else  //reset priority
            begin
              agent_priority_list[i]    <=  'h1;
            end
          end
        end

        assign  agent_req_sop[i]  = 1'b0; //Not used in this mode
      end
      else if(MODE  ==  "PACKET")
      begin
        always@(posedge clk,  negedge rst_n)
        begin
          if(~rst_n)
          begin
            agent_req_sop[i]            <=  1'b1;
            agent_priority_list[i]      <=  'h1;
          end
          else
          begin
            if(agent_req_sop[i])  //Wait for 1st grant cycle
            begin
              if(agent_req[i] & gnt_agent_sel[i])
              begin
                agent_req_sop[i]        <=  agent_req_last[i] ? 1'b1 : 1'b0; 
              end
            end
            else //Wait for last cycle
            begin
              agent_req_sop[i]          <=  (agent_req[i] & gnt_agent_sel[i] & agent_req_last[i]) ? 1'b1 : 1'b0;
            end

            if(|(agent_req & gnt_agent_sel & agent_req_last)) //Update priority during last cycle of packet
            begin
              if(agent_req[i])
              begin
                if(gnt_agent_sel_int[i]) //This agent will be selected in the next cycle
                begin
                  agent_priority_list[i]  <=  (agent_priority_list[i] == 'h1) ? 'h1 : agent_priority_list[i]  - 1'b1;
                end
                else if(~gnt_agent_sel[i])  //Still waiting
                begin
                  agent_priority_list[i]  <=  (agent_priority_list[i] == 'h1) ? 'h1 : agent_priority_list[i]  + 1'b1;
                end
              end
              else  //reset priority
              begin
                agent_priority_list[i]    <=  'h1;
              end
            end
            else
            begin
              agent_priority_list[i]      <=  agent_priority_list[i];
            end
          end
        end
      end
      else
      begin
        invalid_parameter unsupported_mode();
      end

      assign  agent_id_list[i]  = i;

      assign  agent_active_priority_list[i] = agent_req_valid[i]  ? agent_priority_list[i]  : {PRIORITY_W{1'b0}};
    end

    for(i=0; i<NUM_AGENTS; i++)
    begin : gen_agent_id_sel_tree
      if(i==0)
      begin
        always_comb
        begin
          agent_id_sel_tree[0]        = agent_id_list[0];
          agent_priority_sel_tree[0]  = agent_active_priority_list[0];
        end
      end
      else
      begin
        always_comb
        begin
          if(agent_active_priority_list[i]  > agent_priority_sel_tree[i-1])
          begin
            agent_id_sel_tree[i]  = agent_id_list[i];
            agent_priority_sel_tree[i]  = agent_active_priority_list[i];
          end
          else
          begin
            agent_id_sel_tree[i]  = agent_id_sel_tree[i-1];
            agent_priority_sel_tree[i]  = agent_priority_sel_tree[i-1];
          end
        end
      end
    end
  endgenerate

  assign  final_agent_id_sel  = agent_id_sel_tree[NUM_AGENTS-1];

  always_comb
  begin
    gnt_agent_sel_int  = {NUM_AGENTS{1'b0}};

    gnt_agent_sel_int[final_agent_id_sel]  = 1'b1;
  end

  always@(posedge clk,  negedge rst_n)
  begin
    if(~rst_n)
    begin
      gnt_valid     <=  1'b0;
      gnt_agent_id  <=  {AGENT_ID_W{1'b0}};
      gnt_agent_sel <=  {NUM_AGENTS{1'b0}};
    end
    else
    begin
      gnt_valid     <=  gnt_valid_next;
      gnt_agent_id  <=  gnt_agent_id_next;
      gnt_agent_sel <=  gnt_agent_sel_next;
    end
  end

  assign  gnt_valid_next     =  |agent_req_valid;
  assign  gnt_agent_id_next  =  final_agent_id_sel;
  assign  gnt_agent_sel_next =  |agent_req_valid  ? gnt_agent_sel_int : {NUM_AGENTS{1'b0}};

endmodule // axi_fabric_arb
