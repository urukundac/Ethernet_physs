//-----------------------------------------------------------------------------
//
//  INTEL CONFIDENTIAL
//
//  Copyright 2018 Intel Corporation All Rights Reserved.
//
//  The source code contained or described herein and all documents related
//  to the source code ("Material") are owned by Intel Corporation or its
//  suppliers or licensors. Title to the Material remains with Intel
//  Corporation or its suppliers and licensors. The Material contains trade
//  secrets and proprietary and confidential information of Intel or its
//  suppliers and licensors. The Material is protected by worldwide copyright
//  and trade secret laws and treaty provisions. No part of the Material may
//  be used, copied, reproduced, modified, published, uploaded, posted,
//  transmitted, distributed, or disclosed in any way without Intel's prior
//  express written permission.
//
//  No license under any patent, copyright, trade secret or other intellectual
//  property right is granted to or conferred upon you by disclosure or
//  delivery of the Materials, either expressly, by implication, inducement,
//  estoppel or otherwise. Any license under such intellectual property rights
//  must be express and approved by Intel in writing.
//
//------------------------------------------------------------------------------
//---------------------------------------------------------------
//                    Intel Proprietary
//              Copyright (C) 2018 Intel Corporation
//                  All Rights Reserved
//---------------------------------------------------------------
//-----------------------------------------------------------------------------------------------------
// Version and Release Control Information:
//
// File Name:     ethernet_loopback.v
// Created by:    Dhanabal Shanmugam
//-----------------------------------------------------------------------------------------------------
// Modules:
//-----------------------------------------------------------------------------------------------------

`timescale 1ns/1ps

module ethernet_altera_phy (

  input   pcs_ref_clk_125mhz,
  input   xcvr_125mhz_refclk,
  input   xcvr_reset,
  
  input   xcvr_tx_serial_clk0,
  input   fpll_locked_SGMII,

   output xcvr_rx_clk,
  output [9:0] xcvr_tbi_rx_gmii,
  input [9:0] xcvr_tbi_tx_gmii,

   input   [31:0] usr_cntrl_0,     
  output fpga_pcs_loopback_ena,
  output fpga_serdes_loopback_ena,
// altera serdes ports  
  input    xcvr_rx_serial_data,          // SGMII_PHY_S10 from board    
  output   xcvr_tx_serial_data           // SGMIIS_S10_PHY from board   
  
   );
   
   logic [3:0] ethernet_loopback_mode;
   logic serdes_fpga_serial_loopback_ena, xlgmii_fpga_loopback_ena, fpga_serdes_loopback_ena_s;
   logic [9:0] mux_xcvr_tbi_rx_gmii;
   logic [9:0] mux_xcvr_tbi_tx_gmii;



   assign ethernet_loopback_mode = usr_cntrl_0[3:0];
   assign fpga_pcs_loopback_ena = xlgmii_fpga_loopback_ena;
   assign fpga_serdes_loopback_ena = fpga_serdes_loopback_ena_s;
   //assign ethernet_loopback_mode = 4'b0010;   //temporary
   //assign ethernet_loopback_mode = 4'b0000;   //temporary: send data to EGC without external loopback

// ethernet loopback mode selection logic

 always @ (*) begin  

//default values to avoid latches
//       serdes_fpga_serial_loopback_ena = 1'b1;
//       xlgmii_fpga_loopback_ena = 1'b0;
//       xlgmii_rxd   = 0;
//       xlgmii_rxc   = 0;
//       mux_xlgmii_txd = 0;
//       mux_xlgmii_txc= 0;
                 
    case(ethernet_loopback_mode)
          //4'b0010    :  begin           // If ethernet_loopback_mode=2, 1G PHY XLGMII loopback(standalone)
      4'b0000    :  begin           // If ethernet_loopback_mode=0, 1G PHY XLGMII loopback(standalone)
       serdes_fpga_serial_loopback_ena = 1'b0;
        xlgmii_fpga_loopback_ena = 1'b0;
       fpga_serdes_loopback_ena_s = 1'b0;

      end
          
      4'b0001    :   begin         // If ethernet_loopback_mode=1, ethernet serdes TBI loopback(standalone)
       serdes_fpga_serial_loopback_ena = 1'b1;
        xlgmii_fpga_loopback_ena = 1'b0;
       fpga_serdes_loopback_ena_s = 1'b0;

      end
      
      4'b0010    :   begin         // If ethernet_loopback_mode=1, ethernet serdes TBI loopback(standalone)
       serdes_fpga_serial_loopback_ena = 1'b0;
       xlgmii_fpga_loopback_ena = 1'b1;
       fpga_serdes_loopback_ena_s = 1'b0;
      end
 
     4'b0100    :   begin         // If ethernet_loopback_mode=1, ethernet serdes TBI loopback(standalone)
       serdes_fpga_serial_loopback_ena = 1'b0;
       xlgmii_fpga_loopback_ena = 1'b0;
       fpga_serdes_loopback_ena_s = 1'b1;
      end


    default    :  begin           // If ethernet_loopback_mode=0, 1G PHY XLGMII loopback(standalone)
      serdes_fpga_serial_loopback_ena = 1'b0;
       xlgmii_fpga_loopback_ena = 1'b0;
       fpga_serdes_loopback_ena_s = 1'b0;

       end
      
    endcase
  end

   
  ethernet_1g_altera_phy  u_ethernet_1g_altera_phy (

   .pcs_ref_clk_125mhz (pcs_ref_clk_125mhz),
   .xcvr_125mhz_refclk (xcvr_125mhz_refclk) ,
   .xcvr_reset (xcvr_reset),

   .xcvr_tx_serial_clk0 (xcvr_tx_serial_clk0) ,
   .fpll_locked_SGMII (fpll_locked_SGMII),
      
// 1g phy ports   
   .serdes_fpga_serial_loopback_ena  (serdes_fpga_serial_loopback_ena) ,
   .xcvr_rx_clk_o (xcvr_rx_clk),
   .xcvr_tbi_rx_gmii (xcvr_tbi_rx_gmii),
   .xcvr_tbi_tx_gmii (xcvr_tbi_tx_gmii),
// altera serdes ports  
   .xcvr_rx_serial_data  (xcvr_rx_serial_data) ,         
   .xcvr_tx_serial_data  (xcvr_tx_serial_data)         

    );
  
 
    
endmodule

