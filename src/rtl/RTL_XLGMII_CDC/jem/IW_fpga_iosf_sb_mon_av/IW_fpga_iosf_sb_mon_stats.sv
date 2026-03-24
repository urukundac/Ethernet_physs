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

module  IW_fpga_iosf_sb_mon_stats
(
    input   logic                       clk_logic
  , input   logic                       rst_logic_n

  , input   logic                       clr_stats

  , input   logic                       iosfsb_MNPPUT
  , input   logic                       iosfsb_MPCPUT
  , input   logic                       iosfsb_MEOM
  , input   logic                       iosfsb_TNPPUT
  , input   logic                       iosfsb_TPCPUT
  , input   logic                       iosfsb_TEOM

  , input   logic                       master_mon_data_valid
  , input   logic                       master_filt_bp

  , input   logic                       target_mon_data_valid
  , input   logic                       target_filt_bp

  /*  Stats to CSR  */
  , output  logic  [15:0]               num_mmsg_np_pkts
  , output  logic  [15:0]               num_mmsg_pc_pkts
  , output  logic  [15:0]               num_mmsg_np_beats
  , output  logic  [15:0]               num_mmsg_pc_beats
  , output  logic  [15:0]               num_mmsg_dropped_pkts
  , output  logic  [15:0]               num_tmsg_np_pkts
  , output  logic  [15:0]               num_tmsg_pc_pkts
  , output  logic  [15:0]               num_tmsg_np_beats
  , output  logic  [15:0]               num_tmsg_pc_beats
  , output  logic  [15:0]               num_tmsg_dropped_pkts

);


  always@(posedge clk_logic,  negedge rst_logic_n)
  begin
    if(~rst_logic_n)
    begin
      num_mmsg_np_pkts        <=  0;
      num_mmsg_pc_pkts        <=  0;
      num_mmsg_np_beats       <=  0;
      num_mmsg_pc_beats       <=  0;
      num_mmsg_dropped_pkts   <=  0;
      num_tmsg_np_pkts        <=  0;
      num_tmsg_pc_pkts        <=  0;
      num_tmsg_np_beats       <=  0;
      num_tmsg_pc_beats       <=  0;
      num_tmsg_dropped_pkts   <=  0;
    end
    else
    begin
      if(clr_stats)
      begin
        num_mmsg_np_pkts      <=  0;
        num_mmsg_pc_pkts      <=  0;
        num_mmsg_np_beats     <=  0;
        num_mmsg_pc_beats     <=  0;
        num_mmsg_dropped_pkts <=  0;
        num_tmsg_np_pkts      <=  0;
        num_tmsg_pc_pkts      <=  0;
        num_tmsg_np_beats     <=  0;
        num_tmsg_pc_beats     <=  0;
        num_tmsg_dropped_pkts <=  0;
      end
      else
      begin
        num_mmsg_np_pkts      <=  (&num_mmsg_np_pkts)       ? num_mmsg_np_pkts      : num_mmsg_np_pkts      + (iosfsb_MNPPUT  & iosfsb_MEOM);
        num_mmsg_pc_pkts      <=  (&num_mmsg_pc_pkts)       ? num_mmsg_pc_pkts      : num_mmsg_pc_pkts      + (iosfsb_MPCPUT  & iosfsb_MEOM);
        num_mmsg_np_beats     <=  (&num_mmsg_np_beats)      ? num_mmsg_np_beats     : num_mmsg_np_beats     + iosfsb_MNPPUT;
        num_mmsg_pc_beats     <=  (&num_mmsg_pc_beats)      ? num_mmsg_pc_beats     : num_mmsg_pc_beats     + iosfsb_MPCPUT;
        num_mmsg_dropped_pkts <=  (&num_mmsg_dropped_pkts)  ? num_mmsg_dropped_pkts : num_mmsg_dropped_pkts + (master_mon_data_valid  & master_filt_bp);

        num_tmsg_np_pkts      <=  (&num_tmsg_np_pkts)       ? num_tmsg_np_pkts      : num_tmsg_np_pkts      + (iosfsb_TNPPUT  & iosfsb_TEOM);
        num_tmsg_pc_pkts      <=  (&num_tmsg_pc_pkts)       ? num_tmsg_pc_pkts      : num_tmsg_pc_pkts      + (iosfsb_TPCPUT  & iosfsb_TEOM);
        num_tmsg_np_beats     <=  (&num_tmsg_np_beats)      ? num_tmsg_np_beats     : num_tmsg_np_beats     + iosfsb_TNPPUT;
        num_tmsg_pc_beats     <=  (&num_tmsg_pc_beats)      ? num_tmsg_pc_beats     : num_tmsg_pc_beats     + iosfsb_TPCPUT;
        num_tmsg_dropped_pkts <=  (&num_tmsg_dropped_pkts)  ? num_tmsg_dropped_pkts : num_tmsg_dropped_pkts + (target_mon_data_valid  & target_filt_bp);
      end
    end
  end

endmodule //IW_fpga_iosf_sb_mon_stats
