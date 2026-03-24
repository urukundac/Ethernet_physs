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
`include        "hif_pcie_pcie_itp_mem.def"
module hif_pcie_pcie_itp_tcam_mems 
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
   input                                          nss_hif_clk                             ,   
   input [`HIF_PCIE_PCIE_ITP_HIF_ITP_BAR_DECODER_TCAM_MEM_TO_TCAM_WIDTH-1:0] pcie_itp_hif_itp_bar_decoder_tcam_mem_to_tcam     ,   
   input [`HIF_PCIE_PCIE_ITP_HIF_ITP_INNER_BAR_TCAM_MEM_TO_TCAM_WIDTH-1:0] pcie_itp_hif_itp_inner_bar_tcam_mem_to_tcam     ,   
   input                                          scon_hif_powergood                      ,

// Module outputs

  output [`HIF_PCIE_PCIE_ITP_HIF_ITP_BAR_DECODER_TCAM_MEM_FROM_TCAM_WIDTH-1:0] pcie_itp_hif_itp_bar_decoder_tcam_mem_from_tcam     ,   
  output [`HIF_PCIE_PCIE_ITP_HIF_ITP_INNER_BAR_TCAM_MEM_FROM_TCAM_WIDTH-1:0] pcie_itp_hif_itp_inner_bar_tcam_mem_from_tcam      
);

genvar iter;


// Instances

hif_pcie_pcie_itp_wrap_tcam_hif_itp_bar_decoder_tcam_mem_shell_1216x60  #( // Parameters
    .TO_TCAM_WIDTH(`HIF_PCIE_PCIE_ITP_HIF_ITP_BAR_DECODER_TCAM_MEM_TO_TCAM_WIDTH),
    .TCAM_E0_INIT_VALUE(60'h0),
    .TCAM_PATRN0_EXP_RESET_VALUE(0),
    .FPGA_MARGIN(0),
    .TCAM_PATRN1_EXP_RESET_VALUE(0),
    .TCAM_RULES_NUM(1216),
    .TSMC_N7(1),
    .FPGA_CLOCKS_RATIO(100),
    .BCAM_N7(0),
    .TCAM_PROTECTION_TYPE(1),
    .TCAM_WIDTH(60),
    .TCAM_E1_INIT_VALUE(60'h0),
    .TOTAL_MEMORY_INSTANCE(38),
    .TCAM_INIT_TYPE(1),
    .FROM_TCAM_WIDTH(`HIF_PCIE_PCIE_ITP_HIF_ITP_BAR_DECODER_TCAM_MEM_FROM_TCAM_WIDTH),
    .NFUSERED_TCAM(6),
    .BCAM_RELIEF(0),
    .WRAPPER_COL_REPAIR(1),
    .TCAM_SLICE_SIZE(64)
) pcie_itp_wrap_tcam_hif_itp_bar_decoder_tcam_mem_shell_1216x60(
        .clk(nss_hif_clk),
        .car_raw_lan_power_good(scon_hif_powergood),
`ifdef HIF_PCIE_FPGA_TCAM_MEMS
        .fpga_fast_clk(fpga_fast_clk),
`endif
        .wrap_shell_to_tcam(pcie_itp_hif_itp_bar_decoder_tcam_mem_to_tcam),
        .wrap_shell_from_tcam(pcie_itp_hif_itp_bar_decoder_tcam_mem_from_tcam),
        .fuse_tcam(fuse_tcam),
        .dftshiften(dftshiften),
        .dftmask(dftmask),
        .dft_array_freeze(dft_array_freeze),
        .dft_afd_reset_b(dft_afd_reset_b)
);

hif_pcie_pcie_itp_wrap_tcam_hif_itp_inner_bar_tcam_mem_shell_512x58  #( // Parameters
    .WRAPPER_COL_REPAIR(1),
    .TCAM_SLICE_SIZE(64),
    .TCAM_INIT_TYPE(1),
    .FROM_TCAM_WIDTH(`HIF_PCIE_PCIE_ITP_HIF_ITP_INNER_BAR_TCAM_MEM_FROM_TCAM_WIDTH),
    .NFUSERED_TCAM(6),
    .BCAM_RELIEF(0),
    .TCAM_WIDTH(58),
    .TCAM_E1_INIT_VALUE(58'h0),
    .TOTAL_MEMORY_INSTANCE(8),
    .BCAM_N7(0),
    .FPGA_CLOCKS_RATIO(100),
    .TCAM_PROTECTION_TYPE(1),
    .TCAM_RULES_NUM(512),
    .TSMC_N7(1),
    .TCAM_PATRN0_EXP_RESET_VALUE(0),
    .FPGA_MARGIN(0),
    .TCAM_PATRN1_EXP_RESET_VALUE(0),
    .TO_TCAM_WIDTH(`HIF_PCIE_PCIE_ITP_HIF_ITP_INNER_BAR_TCAM_MEM_TO_TCAM_WIDTH),
    .TCAM_E0_INIT_VALUE(58'h0)
) pcie_itp_wrap_tcam_hif_itp_inner_bar_tcam_mem_shell_512x58(
        .clk(nss_hif_clk),
        .car_raw_lan_power_good(scon_hif_powergood),
`ifdef HIF_PCIE_FPGA_TCAM_MEMS
        .fpga_fast_clk(fpga_fast_clk),
`endif
        .wrap_shell_to_tcam(pcie_itp_hif_itp_inner_bar_tcam_mem_to_tcam),
        .wrap_shell_from_tcam(pcie_itp_hif_itp_inner_bar_tcam_mem_from_tcam),
        .fuse_tcam(fuse_tcam),
        .dftshiften(dftshiften),
        .dftmask(dftmask),
        .dft_array_freeze(dft_array_freeze),
        .dft_afd_reset_b(dft_afd_reset_b)
);


// BEGIN_BOTTOM_LOGIC


// END_BOTTOM_LOGIC


endmodule

