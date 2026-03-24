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

module  IW_fpga_iosf_p_mon_stats
(
    input   logic                       clk_logic
  , input   logic                       rst_logic_n

  , input   logic                       clr_stats


  , input   logic                       mreq_mon_data_valid
  , input   logic                       mreq_filt_bp

  , input   logic                       treq_mon_data_valid
  , input   logic                       treq_filt_bp

  , input   logic                       mdata_mon_data_valid
  , input   logic                       mdata_filt_bp

  , input   logic                       tdata_mon_data_valid
  , input   logic                       tdata_filt_bp
 
  , input   logic                       iosf_mon_REQ_PUT
  , input   logic                       iosf_mon_CMD_PUT


  /*  Stats to CSR  */
  , output  logic  [31:0]               num_dropped_pkts
  , output  logic  [31:0]               num_mreq_pkts  
  , output  logic  [31:0]               num_mreq_beats 
  , output  logic  [31:0]               num_treq_pkts  
  , output  logic  [31:0]               num_treq_beats 
  , output  logic  [31:0]               num_mdata_pkts 
  , output  logic  [31:0]               num_mdata_beats
  , output  logic  [31:0]               num_tdata_pkts 
  , output  logic  [31:0]               num_tdata_beats

);


  always@(posedge clk_logic,  negedge rst_logic_n)
  begin
    if(~rst_logic_n)
    begin
      num_dropped_pkts <= 0;
      num_mreq_pkts    <= 0;   
      num_mreq_beats   <= 0;
      num_treq_pkts    <= 0;
      num_treq_beats   <= 0;
      num_mdata_pkts   <= 0;
      num_mdata_beats  <= 0;
      num_tdata_pkts   <= 0;
      num_tdata_beats  <= 0;
    end
    else
    begin
      if(clr_stats)
      begin
        num_dropped_pkts <= 0;
        num_mreq_pkts    <= 0;   
        num_mreq_beats   <= 0;
        num_treq_pkts    <= 0;
        num_treq_beats   <= 0;
        num_mdata_pkts   <= 0;
        num_mdata_beats  <= 0;
        num_tdata_pkts   <= 0;
        num_tdata_beats  <= 0;
      end
      else
      begin
        num_dropped_pkts <= (&num_dropped_pkts)  ? num_dropped_pkts : num_dropped_pkts + ((mreq_mon_data_valid & mreq_filt_bp) | (treq_mon_data_valid & treq_filt_bp) | (mdata_mon_data_valid & mdata_filt_bp) | (tdata_mon_data_valid & tdata_filt_bp));
        num_treq_pkts    <= (&num_treq_pkts)  ? num_treq_pkts: num_treq_pkts + iosf_mon_CMD_PUT;
        num_mreq_pkts    <= (&num_mreq_pkts)  ? num_mreq_pkts: num_mreq_pkts + iosf_mon_REQ_PUT;
        
      end
    end
  end

endmodule //IW_fpga_iosf_p_mon_stats
