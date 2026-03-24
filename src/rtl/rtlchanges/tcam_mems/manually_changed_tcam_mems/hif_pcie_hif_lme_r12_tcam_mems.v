//------------------------------------------------------------------------------
///  INTEL TOP SECRET

///

///  Copyright 2018 Intel Corporation All Rights Reserved.

///

///  The source code contained or described herein and all documents related

///  to the source code ("Material") are owned by Intel Corporation or its

///  suppliers or licensors. Title to the Material remains with Intel

///  Corporation or its suppliers and licensors. The Material contains trade

///  secrets and proprietary and confidential information of Intel or its

///  suppliers and licensors. The Material is protected by worldwide copyright

///  and trade secret laws and treaty provisions. No part of the Material may

///  be used, copied, reproduced, modified, published, uploaded, posted,

///  transmitted, distributed, or disclosed in any way without Intel's prior

///  express written permission.

///

///  No license under any patent, copyright, trade secret or other intellectual

///  property right is granted to or conferred upon you by disclosure or

///  delivery of the Materials, either expressly, by implication, inducement,

///  estoppel or otherwise. Any license under such intellectual property rights

///  must be express and approved by Intel in writing.

///  Inserted by Intel DSD.
//
//------------------------------------------------------------------------------
//////////////////////////////////////////////////////////////////////
//
//                      Automated Memory Wrappers Creator
//
//      Created by npgadmin with create_memories script version 25.01.005 on NA
//                                      & 
// Physical file /nfs/site/disks/nhdk.zsc7.mmg800.ipr.207/hif/hif_r16_post_dft-mmg800-a0-25ww28b-drop.0/flows/mgm/hif/hif_physical_params.csv
//
//////////////////////////////////////////////////////////////////////
`include        "hif_pcie_hif_lme_r12_mem.def"
module hif_pcie_hif_lme_r12_tcam_mems 
// Interface
(

// Module inputs

   input                                          dft_afd_reset_b                         ,   
   input                                          dft_array_freeze                        ,   
   input                                          dftmask                                 ,   
   input                                          dftshiften                              ,   
`ifdef HIF_PCIE_FPGA_TCAM_MEMS
   input                                          fpga_fast_clk                           ,   
`endif
   input                                   [15:0] fuse_tcam                               ,   
   input [`HIF_PCIE_HIF_LME_R12_HIF_LME_R12_LUT_TCAM_TO_TCAM_WIDTH-1:0] hif_lme_r12_hif_lme_r12_lut_tcam_to_tcam     ,   
   input                                          nss_hif_clk                             ,   
   input                                          scon_hif_powergood                      ,

// Module outputs

  output [`HIF_PCIE_HIF_LME_R12_HIF_LME_R12_LUT_TCAM_FROM_TCAM_WIDTH-1:0] hif_lme_r12_hif_lme_r12_lut_tcam_from_tcam            
);

genvar iter;


// Instances

hif_pcie_hif_lme_r12_wrap_tcam_hif_lme_r12_lut_tcam_shell_2048x91  #( // Parameters
    .TOTAL_MEMORY_INSTANCE(48),
    .TO_TCAM_WIDTH(`HIF_PCIE_HIF_LME_R12_HIF_LME_R12_LUT_TCAM_TO_TCAM_WIDTH),
    .TCAM_RULES_NUM(2048),
    .BCAM_N7(0),
    .TCAM_INIT_TYPE(1),
    .TCAM_SLICE_SIZE(64),
    .FROM_TCAM_WIDTH(`HIF_PCIE_HIF_LME_R12_HIF_LME_R12_LUT_TCAM_FROM_TCAM_WIDTH),
    .TCAM_PROTECTION_TYPE(1),
    .TCAM_E0_INIT_VALUE(91'h0),
    .TCAM_PATRN0_EXP_RESET_VALUE(0),
    .BCAM_RELIEF(0),
    .TSMC_N7(1),
    .WRAPPER_COL_REPAIR(1),
    .FPGA_MARGIN(0),
    .TCAM_PATRN1_EXP_RESET_VALUE(0),
    .FPGA_CLOCKS_RATIO(100),
    .TCAM_E1_INIT_VALUE(91'h0),
    .NFUSERED_TCAM(6),
    .TCAM_WIDTH(91)
) hif_lme_r12_wrap_tcam_hif_lme_r12_lut_tcam_shell_2048x91(
        .clk(nss_hif_clk),
        .car_raw_lan_power_good(scon_hif_powergood),
`ifdef HIF_PCIE_FPGA_TCAM_MEMS
        .fpga_fast_clk(fpga_fast_clk),
`endif
        .wrap_shell_to_tcam(hif_lme_r12_hif_lme_r12_lut_tcam_to_tcam),
        .wrap_shell_from_tcam(hif_lme_r12_hif_lme_r12_lut_tcam_from_tcam),
        .fuse_tcam(fuse_tcam),
        .dftshiften(dftshiften),
        .dftmask(dftmask),
        .dft_array_freeze(dft_array_freeze),
        .dft_afd_reset_b(dft_afd_reset_b)
);


// BEGIN_BOTTOM_LOGIC


// END_BOTTOM_LOGIC


endmodule

