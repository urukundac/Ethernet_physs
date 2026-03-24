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

`include "idi_v2_type.vh"

module  IW_fpga_idi_mon_stats
(
    input   logic                                        clk_logic
  , input   logic                                        rst_logic_n

  , input   logic                                        clr_stats

  , input   logic                                        mon_data_valid
  , input   logic                                        filt_bp

  /*  Stats to CSR  */
  , output  logic  [31:0]                                num_pkts
  , output  logic  [31:0]                                num_beats
  , output  logic  [31:0]                                num_dropped_pkts

);

//  import idi_jem_pkg::*;

  always@(posedge clk_logic,  negedge rst_logic_n)
  begin
    if(~rst_logic_n)
    begin
      num_pkts             <=  0;
      num_beats            <=  0;
      num_dropped_pkts     <=  0;
    end
    else
    begin
      if(clr_stats)
      begin
        num_beats            <=  0;
        num_pkts             <=  0;
        num_dropped_pkts     <=  0;
      end
      else
      begin
        num_dropped_pkts <=  (&num_dropped_pkts)  ? num_dropped_pkts : num_dropped_pkts + (mon_data_valid  & filt_bp);
        num_beats <= num_beats;// add logic
        num_pkts  <= num_pkts + mon_data_valid;

      end
    end
  end

endmodule //IW_fpga_iosf_onpi_mon_stats
