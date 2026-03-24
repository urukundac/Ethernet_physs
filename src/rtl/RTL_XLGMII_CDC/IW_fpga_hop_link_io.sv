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
// Version and Release Control Information:
//
// File Name:$RCSfile:$
// File Revision:$
// Created by:    Gregory James
// Updated by:    $Author:$ $Date:$
//------------------------------------------------------------------------------
// This module has two instances of IW_fpga_hop_io corresponding to ingress &
// egress sides of a HOP bidirectional link.
//------------------------------------------------------------------------------

`timescale  1ns/100ps

module  IW_fpga_hop_link_io #(
   parameter INSTANCE_TAG           = "HL"  //Prefix tag used to uniquely identify this module's instance


  ,parameter  INGR_EN               = 0     //1->Ingress ports enabled, 0->Ingress ports bypassed
  ,parameter  INGR_DEMUX_NUM_IOS    = 1     //Number of pins for demuxing
  ,parameter  INGR_DEMUX_RATIO      = 20    //Mux-ratio for demux
  ,parameter  INGR_DEMUX_CLK_RATIO  = 12    //clock-ratio for demux

  ,parameter  INGR_MUX_NUM_IOS      = 1     //Number of pins for muxing
  ,parameter  INGR_MUX_RATIO        = 20    //Mux-ratio for mux
  ,parameter  INGR_MUX_CLK_RATIO    = 12    //clock-ratio for mux


  ,parameter  EGR_EN                = 0     //1->Egress ports enabled, 0->Egress ports bypassed
  ,parameter  EGR_DEMUX_NUM_IOS     = 1     //Number of pins for demuxing
  ,parameter  EGR_DEMUX_RATIO       = 20    //Mux-ratio for demux
  ,parameter  EGR_DEMUX_CLK_RATIO   = 12    //clock-ratio for demux

  ,parameter  EGR_MUX_NUM_IOS       = 1     //Number of pins for muxing
  ,parameter  EGR_MUX_RATIO         = 20    //Mux-ratio for mux
  ,parameter  EGR_MUX_CLK_RATIO     = 12    //clock-ratio for mux
  ,parameter  FPGA_FAMILY           = "S5"


  ,parameter  INFRA_AVST_CHNNL_W         = 8
  ,parameter  INFRA_AVST_DATA_W          = 8
  ,parameter  INFRA_AVST_CHNNL_ID_INGR2EGR_MUX    = 8
  ,parameter  INFRA_AVST_CHNNL_ID_INGR2EGR_DEMUX  = 8
  ,parameter  INFRA_AVST_CHNNL_ID_EGR2INGR_MUX    = 8
  ,parameter  INFRA_AVST_CHNNL_ID_EGR2INGR_DEMUX  = 8

  ,parameter  CSR_ADDR_WIDTH             = 3*INFRA_AVST_DATA_W
  ,parameter  CSR_DATA_WIDTH             = 4*INFRA_AVST_DATA_W

  ,parameter DEMUX_DATA_GRADUAL          = 1 // 1: demuxed data changes bit after bit
  /*  Do not modify */
  , /*  reuse-pragma attr ReplaceInHDL 0  */  parameter  DEBUG_REG_W              = 32
  , /*  reuse-pragma attr ReplaceInHDL 0  */  parameter  NUM_DEBUG_REGS           = 16
  , /*  reuse-pragma attr ReplaceInHDL 0  */  parameter  NUM_INGR_DEMUX_SIGNALS   = INGR_DEMUX_NUM_IOS*INGR_DEMUX_RATIO
  , /*  reuse-pragma attr ReplaceInHDL 0  */  parameter  NUM_INGR_MUX_SIGNALS     = INGR_MUX_NUM_IOS*INGR_MUX_RATIO
  , /*  reuse-pragma attr ReplaceInHDL 0  */  parameter  NUM_EGR_DEMUX_SIGNALS    = EGR_DEMUX_NUM_IOS*EGR_DEMUX_RATIO
  , /*  reuse-pragma attr ReplaceInHDL 0  */  parameter  NUM_EGR_MUX_SIGNALS      = EGR_MUX_NUM_IOS*EGR_MUX_RATIO

) (

  /*  Ingress side ports  */
   input                                clk_ingr_register
  ,input                                clk_ingr_mux
  ,input                                rst_ingr_mux_n
  ,input                                clk_ingr_demux
  ,input                                rst_ingr_demux_n

  ,inout  [INGR_DEMUX_NUM_IOS-1:0]      INGR_DEMUX_IO
  ,input  [NUM_EGR_MUX_SIGNALS-1:0]     ingr_demux_bypass_data
  ,output                               ingr_demux_ecc_err

  ,inout  [INGR_MUX_NUM_IOS-1:0]        INGR_MUX_IO
  ,output [NUM_EGR_DEMUX_SIGNALS-1:0]   ingr_mux_bypass_data

  ,input                                clk_avst
  ,input                                rst_avst_n

  ,output                               ingr2egr_mux_avst_ingr_ready
  ,input                                ingr2egr_mux_avst_ingr_valid
  ,input                                ingr2egr_mux_avst_ingr_startofpacket
  ,input                                ingr2egr_mux_avst_ingr_endofpacket
  ,input  [INFRA_AVST_CHNNL_W-1:0]      ingr2egr_mux_avst_ingr_channel
  ,input  [INFRA_AVST_DATA_W-1:0]       ingr2egr_mux_avst_ingr_data
  ,input                                ingr2egr_mux_avst_egr_ready
  ,output                               ingr2egr_mux_avst_egr_valid
  ,output                               ingr2egr_mux_avst_egr_startofpacket
  ,output                               ingr2egr_mux_avst_egr_endofpacket
  ,output [INFRA_AVST_CHNNL_W-1:0]      ingr2egr_mux_avst_egr_channel
  ,output [INFRA_AVST_DATA_W-1:0]       ingr2egr_mux_avst_egr_data

  ,output                               ingr2egr_demux_avst_ingr_ready
  ,input                                ingr2egr_demux_avst_ingr_valid
  ,input                                ingr2egr_demux_avst_ingr_startofpacket
  ,input                                ingr2egr_demux_avst_ingr_endofpacket
  ,input  [INFRA_AVST_CHNNL_W-1:0]      ingr2egr_demux_avst_ingr_channel
  ,input  [INFRA_AVST_DATA_W-1:0]       ingr2egr_demux_avst_ingr_data
  ,input                                ingr2egr_demux_avst_egr_ready
  ,output                               ingr2egr_demux_avst_egr_valid
  ,output                               ingr2egr_demux_avst_egr_startofpacket
  ,output                               ingr2egr_demux_avst_egr_endofpacket
  ,output [INFRA_AVST_CHNNL_W-1:0]      ingr2egr_demux_avst_egr_channel
  ,output [INFRA_AVST_DATA_W-1:0]       ingr2egr_demux_avst_egr_data


  /*  Egress side ports */
  ,input                                clk_egr_register
  ,input                                clk_egr_mux
  ,input                                rst_egr_mux_n
  ,input                                clk_egr_demux
  ,input                                rst_egr_demux_n

  ,inout  [EGR_DEMUX_NUM_IOS-1:0]       EGR_DEMUX_IO
  ,input  [NUM_INGR_MUX_SIGNALS-1:0]    egr_demux_bypass_data
  ,output                               egr_demux_ecc_err

  ,inout  [EGR_MUX_NUM_IOS-1:0]         EGR_MUX_IO
  ,output [NUM_INGR_DEMUX_SIGNALS-1:0]  egr_mux_bypass_data

  ,output                               egr2ingr_mux_avst_ingr_ready
  ,input                                egr2ingr_mux_avst_ingr_valid
  ,input                                egr2ingr_mux_avst_ingr_startofpacket
  ,input                                egr2ingr_mux_avst_ingr_endofpacket
  ,input  [INFRA_AVST_CHNNL_W-1:0]      egr2ingr_mux_avst_ingr_channel
  ,input  [INFRA_AVST_DATA_W-1:0]       egr2ingr_mux_avst_ingr_data
  ,input                                egr2ingr_mux_avst_egr_ready
  ,output                               egr2ingr_mux_avst_egr_valid
  ,output                               egr2ingr_mux_avst_egr_startofpacket
  ,output                               egr2ingr_mux_avst_egr_endofpacket
  ,output [INFRA_AVST_CHNNL_W-1:0]      egr2ingr_mux_avst_egr_channel
  ,output [INFRA_AVST_DATA_W-1:0]       egr2ingr_mux_avst_egr_data

  ,output                               egr2ingr_demux_avst_ingr_ready
  ,input                                egr2ingr_demux_avst_ingr_valid
  ,input                                egr2ingr_demux_avst_ingr_startofpacket
  ,input                                egr2ingr_demux_avst_ingr_endofpacket
  ,input  [INFRA_AVST_CHNNL_W-1:0]      egr2ingr_demux_avst_ingr_channel
  ,input  [INFRA_AVST_DATA_W-1:0]       egr2ingr_demux_avst_ingr_data
  ,input                                egr2ingr_demux_avst_egr_ready
  ,output                               egr2ingr_demux_avst_egr_valid
  ,output                               egr2ingr_demux_avst_egr_startofpacket
  ,output                               egr2ingr_demux_avst_egr_endofpacket
  ,output [INFRA_AVST_CHNNL_W-1:0]      egr2ingr_demux_avst_egr_channel
  ,output [INFRA_AVST_DATA_W-1:0]       egr2ingr_demux_avst_egr_data

);

  /*
    *
    *           u_IW_fpga_hop_io_ingr2egr
    * I         +-------------------------+          E
    * N         | +-------+       +-----+ |          G
    * G  ------>| | DeMux |------>| Mux | |------>   R
    * R         | +-------+       +-----+ |          E
    * E         +-------------------------+          S
    * S                                              S
    * S         u_IW_fpga_hop_io_egr2ingr
    *           +-------------------------+
    *           | +-----+       +-------+ |
    *    <------| | Mux |<------| DeMux | |<------
    *           | +-----+       +-------+ |
    *           +-------------------------+
    *
  */


  /* Instantiate ingress->egress HOP */
  IW_fpga_hop_io  #(
     .INSTANCE_TAG              ({INSTANCE_TAG,"I2E"})

    ,.BYPASS_DEMUX              (!INGR_EN)
    ,.DEMUX_NUM_IOS             (INGR_DEMUX_NUM_IOS)
    ,.DEMUX_RATIO               (INGR_DEMUX_RATIO)
    ,.DEMUX_CLK_RATIO           (INGR_DEMUX_CLK_RATIO)

    ,.BYPASS_MUX                (!EGR_EN)
    ,.MUX_NUM_IOS               (EGR_MUX_NUM_IOS)
    ,.MUX_RATIO                 (EGR_MUX_RATIO)
    ,.MUX_CLK_RATIO             (EGR_MUX_CLK_RATIO)

    ,.DEMUX_DATA_GRADUAL        (DEMUX_DATA_GRADUAL)
    ,.DEBUG_REG_W               (DEBUG_REG_W)
    ,.NUM_DEBUG_REGS            (NUM_DEBUG_REGS)
    ,.NUM_DEMUX_SIGNALS         (NUM_INGR_DEMUX_SIGNALS)
    ,.NUM_MUX_SIGNALS           (NUM_EGR_MUX_SIGNALS)
    ,.FPGA_FAMILY               (FPGA_FAMILY)

    ,.INFRA_AVST_CHNNL_W        (INFRA_AVST_CHNNL_W)
    ,.INFRA_AVST_DATA_W         (INFRA_AVST_DATA_W)
    ,.INFRA_AVST_CHNNL_ID_MUX   (INFRA_AVST_CHNNL_ID_INGR2EGR_MUX)
    ,.INFRA_AVST_CHNNL_ID_DEMUX (INFRA_AVST_CHNNL_ID_INGR2EGR_DEMUX)

    ,.CSR_ADDR_WIDTH            (CSR_ADDR_WIDTH)
    ,.CSR_DATA_WIDTH            (CSR_DATA_WIDTH)

  ) u_IW_fpga_hop_io_ingr2egr (

     .clk_register                         (clk_egr_register)
    ,.clk_mux                              (clk_egr_mux)
    ,.rst_mux_n                            (rst_egr_mux_n)
    ,.clk_demux                            (clk_ingr_demux)
    ,.rst_demux_n                          (rst_ingr_demux_n)

    ,.DEMUX_IO                             (INGR_DEMUX_IO)
    ,.demux_bypass_data                    (ingr_demux_bypass_data)
    ,.demux_ecc_err                        (ingr_demux_ecc_err)

    ,.MUX_IO                               (EGR_MUX_IO)
    ,.mux_bypass_data                      (egr_mux_bypass_data)

    ,.clk_avst                             (clk_avst)
    ,.rst_avst_n                           (rst_avst_n)

    ,.hop_io_mux_avst_ingr_ready           (ingr2egr_mux_avst_ingr_ready        )
    ,.hop_io_mux_avst_ingr_valid           (ingr2egr_mux_avst_ingr_valid        )
    ,.hop_io_mux_avst_ingr_startofpacket   (ingr2egr_mux_avst_ingr_startofpacket)
    ,.hop_io_mux_avst_ingr_endofpacket     (ingr2egr_mux_avst_ingr_endofpacket  )
    ,.hop_io_mux_avst_ingr_channel         (ingr2egr_mux_avst_ingr_channel      )
    ,.hop_io_mux_avst_ingr_data            (ingr2egr_mux_avst_ingr_data         )
    ,.hop_io_mux_avst_egr_ready            (ingr2egr_mux_avst_egr_ready         )
    ,.hop_io_mux_avst_egr_valid            (ingr2egr_mux_avst_egr_valid         )
    ,.hop_io_mux_avst_egr_startofpacket    (ingr2egr_mux_avst_egr_startofpacket )
    ,.hop_io_mux_avst_egr_endofpacket      (ingr2egr_mux_avst_egr_endofpacket   )
    ,.hop_io_mux_avst_egr_channel          (ingr2egr_mux_avst_egr_channel       )
    ,.hop_io_mux_avst_egr_data             (ingr2egr_mux_avst_egr_data          )
	
    ,.hop_io_demux_avst_ingr_ready         (ingr2egr_demux_avst_ingr_ready        )
    ,.hop_io_demux_avst_ingr_valid         (ingr2egr_demux_avst_ingr_valid        )
    ,.hop_io_demux_avst_ingr_startofpacket (ingr2egr_demux_avst_ingr_startofpacket)
    ,.hop_io_demux_avst_ingr_endofpacket   (ingr2egr_demux_avst_ingr_endofpacket  )
    ,.hop_io_demux_avst_ingr_channel       (ingr2egr_demux_avst_ingr_channel      )
    ,.hop_io_demux_avst_ingr_data          (ingr2egr_demux_avst_ingr_data         )
    ,.hop_io_demux_avst_egr_ready          (ingr2egr_demux_avst_egr_ready         )
    ,.hop_io_demux_avst_egr_valid          (ingr2egr_demux_avst_egr_valid         )
    ,.hop_io_demux_avst_egr_startofpacket  (ingr2egr_demux_avst_egr_startofpacket )
    ,.hop_io_demux_avst_egr_endofpacket    (ingr2egr_demux_avst_egr_endofpacket   )
    ,.hop_io_demux_avst_egr_channel        (ingr2egr_demux_avst_egr_channel       )
    ,.hop_io_demux_avst_egr_data           (ingr2egr_demux_avst_egr_data          )
  );

  /* Instantiate egress->ingress HOP */
  IW_fpga_hop_io  #(
     .INSTANCE_TAG              ({INSTANCE_TAG,"E2I"})

    ,.BYPASS_DEMUX              (!EGR_EN)
    ,.DEMUX_NUM_IOS             (EGR_DEMUX_NUM_IOS)
    ,.DEMUX_RATIO               (EGR_DEMUX_RATIO)
    ,.DEMUX_CLK_RATIO           (EGR_DEMUX_CLK_RATIO)

    ,.BYPASS_MUX                (!INGR_EN)
    ,.MUX_NUM_IOS               (INGR_MUX_NUM_IOS)
    ,.MUX_RATIO                 (INGR_MUX_RATIO)
    ,.MUX_CLK_RATIO             (INGR_MUX_CLK_RATIO)

    ,.DEMUX_DATA_GRADUAL        (DEMUX_DATA_GRADUAL)
    ,.DEBUG_REG_W               (DEBUG_REG_W)
    ,.NUM_DEBUG_REGS            (NUM_DEBUG_REGS)
    ,.NUM_DEMUX_SIGNALS         (NUM_EGR_DEMUX_SIGNALS)
    ,.NUM_MUX_SIGNALS           (NUM_INGR_MUX_SIGNALS)
    ,.FPGA_FAMILY               (FPGA_FAMILY)

    ,.INFRA_AVST_CHNNL_W        (INFRA_AVST_CHNNL_W)
    ,.INFRA_AVST_DATA_W         (INFRA_AVST_DATA_W)
    ,.INFRA_AVST_CHNNL_ID_MUX   (INFRA_AVST_CHNNL_ID_EGR2INGR_MUX)
    ,.INFRA_AVST_CHNNL_ID_DEMUX (INFRA_AVST_CHNNL_ID_EGR2INGR_DEMUX)

    ,.CSR_ADDR_WIDTH            (CSR_ADDR_WIDTH)
    ,.CSR_DATA_WIDTH            (CSR_DATA_WIDTH)

  ) u_IW_fpga_hop_io_egr2ingr (

     .clk_register                         (clk_ingr_register)
    ,.clk_mux                              (clk_ingr_mux)
    ,.rst_mux_n                            (rst_ingr_mux_n)
    ,.clk_demux                            (clk_egr_demux)
    ,.rst_demux_n                          (rst_egr_demux_n)

    ,.DEMUX_IO                             (EGR_DEMUX_IO)
    ,.demux_bypass_data                    (egr_demux_bypass_data)
    ,.demux_ecc_err                        (egr_demux_ecc_err)

    ,.MUX_IO                               (INGR_MUX_IO)
    ,.mux_bypass_data                      (ingr_mux_bypass_data)

    ,.clk_avst                             (clk_avst)
    ,.rst_avst_n                           (rst_avst_n)

    ,.hop_io_mux_avst_ingr_ready           (egr2ingr_mux_avst_ingr_ready        )
    ,.hop_io_mux_avst_ingr_valid           (egr2ingr_mux_avst_ingr_valid        )
    ,.hop_io_mux_avst_ingr_startofpacket   (egr2ingr_mux_avst_ingr_startofpacket)
    ,.hop_io_mux_avst_ingr_endofpacket     (egr2ingr_mux_avst_ingr_endofpacket  )
    ,.hop_io_mux_avst_ingr_channel         (egr2ingr_mux_avst_ingr_channel      )
    ,.hop_io_mux_avst_ingr_data            (egr2ingr_mux_avst_ingr_data         )
    ,.hop_io_mux_avst_egr_ready            (egr2ingr_mux_avst_egr_ready         )
    ,.hop_io_mux_avst_egr_valid            (egr2ingr_mux_avst_egr_valid         )
    ,.hop_io_mux_avst_egr_startofpacket    (egr2ingr_mux_avst_egr_startofpacket )
    ,.hop_io_mux_avst_egr_endofpacket      (egr2ingr_mux_avst_egr_endofpacket   )
    ,.hop_io_mux_avst_egr_channel          (egr2ingr_mux_avst_egr_channel       )
    ,.hop_io_mux_avst_egr_data             (egr2ingr_mux_avst_egr_data          )
	
    ,.hop_io_demux_avst_ingr_ready         (egr2ingr_demux_avst_ingr_ready        )
    ,.hop_io_demux_avst_ingr_valid         (egr2ingr_demux_avst_ingr_valid        )
    ,.hop_io_demux_avst_ingr_startofpacket (egr2ingr_demux_avst_ingr_startofpacket)
    ,.hop_io_demux_avst_ingr_endofpacket   (egr2ingr_demux_avst_ingr_endofpacket  )
    ,.hop_io_demux_avst_ingr_channel       (egr2ingr_demux_avst_ingr_channel      )
    ,.hop_io_demux_avst_ingr_data          (egr2ingr_demux_avst_ingr_data         )
    ,.hop_io_demux_avst_egr_ready          (egr2ingr_demux_avst_egr_ready         )
    ,.hop_io_demux_avst_egr_valid          (egr2ingr_demux_avst_egr_valid         )
    ,.hop_io_demux_avst_egr_startofpacket  (egr2ingr_demux_avst_egr_startofpacket )
    ,.hop_io_demux_avst_egr_endofpacket    (egr2ingr_demux_avst_egr_endofpacket   )
    ,.hop_io_demux_avst_egr_channel        (egr2ingr_demux_avst_egr_channel       )
    ,.hop_io_demux_avst_egr_data           (egr2ingr_demux_avst_egr_data          )
  );


endmodule //IW_fpga_hop_link_io

