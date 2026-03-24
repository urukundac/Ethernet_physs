//=============================================================================
// INTEL CONFIDENTIAL
//
// Copyright 2021 Intel Corporation All Rights Reserved.
//
// The source code contained or described herein and all documents related
// to the source code ("Material") are owned by Intel Corporation or its
// suppliers or licensors. Title to the Material remains with Intel
// Corporation or its suppliers and licensors. The Material contains trade
// secrets and proprietary and confidential information of Intel or its
// suppliers and licensors. The Material is protected by worldwide copyright
// and trade secret laws and treaty provisions. No part of the Material may
// be used, copied, reproduced, modified, published, uploaded, posted,
// transmitted, distributed, or disclosed in any way without Intel's prior
// express written permission.
//
// No license under any patent, copyright, trade secret or other intellectual
// property right is granted to or conferred upon you by disclosure or
// delivery of the Materials, either expressly, by implication, inducement,
// estoppel or otherwise. Any license under such intellectual property rights
// must be express and approved by Intel in writing.
//
//=============================================================================
`include "hip_param_overrides.vh"
`include "fuse_hip_top.vh"

module adfuse_mfz_top
(
//--------------------------------------------------------------------
// POWER PORTS
//--------------------------------------------------------------------
  `ifdef INTEL_NO_PWR_PINS
    //******** INTEL_NO_PWR_PINS is intended to use when doing power aware simulations(UPF simulations)
  `elsif REAL_VALUES
    input  real  vccsoc_nom,                                      // VCC Nominal
    input  real  vccf_nom,                                        // VCCF Fuse Voltage (Sensing) 
    input  real  vccfhv_hvm_ehv   [(NUM_INTELHVM_PINS-1):0],      // VCCF Fuse High Voltage (Programming)
    `ifndef HVM_ONLY              // If this is HVM only fuse count then we know this does not exist
      `ifdef MFZCHRGPUMP_INCLUDE  // If we dont have chargepump then this output does not need to exist
        input  real  vcc_ifp_ehv    [(NUM_IFP_PINS-1):0],           // VCC High Voltage, input to Chargepump/BGREF
        output real  vccfhv_cp_ehv  [(TOTAL_PINS-1):0],             // Charge Pump VCCFHV Outputted to the TOP level (HVM Pin index's will be connected to 1'b0)
      `else
        input  real vccfhv_ifp_ehv  [(NUM_IFP_PINS-1):0],           // VCC High Voltage, input to Charge Pump and Bandgap only
      `endif
    `endif
  `else
    input  logic vccsoc_nom,                                      // VCC Nominal
    input  logic vccf_nom,                                        // VCC Fuse Voltage
    input  logic vccfhv_hvm_ehv   [(NUM_INTELHVM_PINS-1):0],      // VCC Fuse High Voltage (Programming)
    `ifndef HVM_ONLY              // If this is HVM only fuse count then we know this does not exist
      `ifdef MFZCHRGPUMP_INCLUDE  // If we dont have chargepump then this output does not need to exist
        input  logic vcc_ifp_ehv    [(NUM_IFP_PINS-1):0],           // VCC High Voltage, input to Chargepump/BGREF
        output logic vccfhv_cp_ehv  [(TOTAL_PINS-1):0],             // Charge Pump VCCFHV Outputted to the TOP level (HVM Pin index's will be connected to 1'b0)
      `else
        input  logic vccfhv_ifp_ehv [(NUM_IFP_PINS-1):0],           // VCC High Voltage, input to Charge Pump and Bandgap only
      `endif
    `endif
  `endif
//--------------------------------------------------------------------
// ANALOG PORTS
//--------------------------------------------------------------------
`ifdef REAL_VALUES
  `ifdef MFZVDC_INCLUDE        // If the VDC does not exists then we dont need the analog output
    output real  monout_vdc_ana[(TOTAL_PINS-1):0],                // Voltage Monitor: VDC
  `endif

  `ifndef HVM_ONLY              // If this is HVM only fuse count then we know this does not exist
    `ifdef MFZBGREF_INCLUDE      // If the BGREF does not exists then we dont need the analog output
      output real  monout_bg_ana [(TOTAL_PINS-1):0],                // Voltage Monitor: Band Gap (HVM Pin index's will be connected to 1'b0)
    `endif

    `ifdef MFZCHRGPUMP_INCLUDE   // If the chargepump does not exists then we dont need the analog output
      output real  monout_cp_ana [(TOTAL_PINS-1):0],                // Voltage Monitor: Charge Pump (HVM Pin index's will be connected to 1'b0)
    `endif
  `endif
`else
  `ifdef MFZVDC_INCLUDE        // If the VDC does not exists then we dont need the analog output
    output logic monout_vdc_ana[(TOTAL_PINS-1):0],                // Voltage Monitor: VDC
  `endif

  `ifndef HVM_ONLY              // If this is HVM only fuse count then we know this does not exist
    `ifdef MFZBGREF_INCLUDE      // If the BGREF does not exists then we dont need the analog output
      output logic monout_bg_ana [(TOTAL_PINS-1):0],                // Band Gap Voltage Monitor (HVM Pin index's will be connected to 1'b0)
    `endif

    `ifdef MFZCHRGPUMP_INCLUDE   // If the chargepump does not exists then we dont need the analog output
      output logic monout_cp_ana [(TOTAL_PINS-1):0],                // Charge Pump Voltage Monitor (HVM Pin index's will be connected to 1'b0)
    `endif
  `endif
`endif
//--------------------------------------------------------------------
// DIGIGAL PORTS
//--------------------------------------------------------------------
    // Fuse Array input/output ports
    input  logic [4:0]                    fuse_redundant_select,  // Redundant Select.  5 bits, must have 1 bit set to be valid
    input  logic [(ADDR_WIDTH-1):0]       fuse_address,           // Fuse address -> SpecialRow[15], Module[14:8], Array[7:5], Row[4:0]
    input  logic                          fuse_firewall_en,       // Firewall enable (From the Fuse Controller)
    input  logic                          fuse_hv_protect,        // High Voltage protection enable
    input  logic                          fuse_sense,             // Fuse sense
    input  logic                          fuse_senselv,           // Fuse sense level
    input  logic                          fuse_sensehiz,          // Fuse sense current increase
    input  logic                          fuse_senselvb,          // Fuse sense levelb
    input  logic [5:0]                    fuse_favor,             // Sense amp favor bits (favor0[a,b,c], favor1[a.b.c])
    input  logic                          fuse_pgmen,             // Program Enable
    input  logic [(WRITE_DATA_WIDTH-1):0] fuse_write_data,        // Write data for fuse programming
    input  logic                          fuse_powergate_en,      // Provided to the HIP blocks to enable power gates if required 
    input  logic                          fuse_sip2hip_iso_enb,   // Isolation Enable for SIP to HIP signals (From SoC Control)
    input  logic                          fuse_hip2sip_iso_enb,   // Isolation Enable for HIP to SIP signals (From SoC Control)
    input  logic [(KAR_WIDTH-1):0]        fuse_kar,               // Key Access Register, used to gate Global Program Enable
    output logic [(ATTACK_WIDTH-1):0]     fuse_attack,            // Attack status
    output logic [(READ_DATA_WIDTH-1):0]  fuse_read_data,         // Read data from fuse sensing
  `ifdef FZROSC_INCLUDE  // If we do not have ROSC then the clock output is not needed
    input  logic                          fuse_ro_clkreq,         // Ring Oscillator enable (Request from fuse controller)
    output logic                          fuse_ro_clkack,         // Ring Oscillator Acknowledement   
    output logic                          fuse_ro_clk,            // Fuse HIP internal ring osc clock 
  `endif
    output logic                          fuse_hip_powergood,     // HIP output powergood letting Fuse Controller know HIP is powered
    // Fuse SIP/HIP Async Handshake (see sip spec for these handshakes)
    input  logic                          fuse_sip_release_req,   // Fuse SIP Release Request
    output logic                          fuse_sip_release_ack,   // Fuse SIP Release Acknowledge
    input  logic                          fuse_powerup_req,       // Fuse SIP Powerup Request
    output logic                          fuse_powerup_ack,       // Fuse SIP Powerup Acknowledge
    // Fuse HIP Indirect Register Interface
    input  logic                          fusevr_ro_clock,        // External clock
    input  logic                          fusevr_reset_n,         // Active low reset
    input  logic                          fusevr_write_en,        // Enables writes to the registers
    input  logic [(REG_WIDTH-1):0]        fusevr_write_data,      // The write data for the register
    input  logic                          fusevr_read_en,         // Enables reads to the registers
    output logic [(REG_WIDTH-1):0]        fusevr_read_data,       // The read data from the register
    input  logic [(ADDR_WIDTH-1):0]       fusevr_address,         // The address to write to
    // Test Wrapper Ports
  `ifdef JTAG_INCLUDED
    input  logic                          ijtag_tck,              // Test Clock for Test Data Registers/Segment Insertion Bits
    input  logic                          ijtag_reset_b,          // Test Reset (Active Low) Asynchronous Reset for JTAG chain
    input  logic                          ijtag_capture,          // Capture State Signal for iJTAG chain
    input  logic                          ijtag_shift,            // Shift State Signal for iJTAG chain
    input  logic                          ijtag_update,           // Update State Signal for iJTAG chain
    input  logic                          ijtag_sel,              // Select Signal to activate iJTAG chain
    input  logic                          ijtag_si,               // Scan In (input data) to iJTAG chain
    output logic                          ijtag_so,               // Scan Out (output data) of iJTAG chain
    input  logic                          fdfx_powergood_tdr,     // (active low) Used to reset TDRs
    input  logic                          secure_red,             // to be updated by Jason
  `endif
    // DFx Ports
    input  logic                          fscan_rstbypen,         // Scanmode : Reset Bypass Enable
    input  logic                          fscan_byprst_b,         // Scanmode : Reset Bypass Value
    input  logic                          fscan_clkungate,        // Scanmode : Forces clocks on
    input  logic                          fscan_mode              // Scanmode : Enables scan mode
);
    //********************************************************************************
    //*** LOCAL PARAMATERS
    //********************************************************************************
    logic                          fuse_hip2sip_iso_ctrl_enb;           // ISO Control pin for UPF
    logic                          fuse_hip2sip_iso_enb_int;           // Added this for CDC error
    logic                          fusevr_reset_n_fw;             // Gated muxed_fusevr_reset_n with fuse_hip2sip_iso_enb
    
    // Muxed signals between Fuse Controller & JTAG register inputs
    logic [31:0]                   fusevr_write_data_post_jtag;
    logic                          fuse_senselv_post_jtag;
    logic                          fuse_sip_release_req_post_jtag;
    logic                          fuse_ro_clkreq_post_jtag;
    logic [43:0]                   fuse_write_data_post_jtag;
    logic                          fuse_powerup_req_post_jtag;
    logic                          fuse_senselvb_post_jtag;
    logic [5:0]                    fuse_favor_post_jtag;
    logic                          fuse_hv_protect_post_jtag;
    logic [31:0]                   fuse_kar_post_jtag;
    logic                          fusevr_reset_n_post_jtag;
    logic [15:0]                   fuse_address_post_jtag;
    logic                          fuse_sensehiz_post_jtag;
    logic                          fuse_pgmen_post_jtag;
    logic [15:0]                   fusevr_address_post_jtag;
    logic                          fusevr_read_en_post_jtag;
    logic                          fusevr_ro_clock_post_jtag;
    logic                          fuse_powergate_en_post_jtag;
    logic                          fusevr_write_en_post_jtag;
    logic [4:0]                    fuse_redundant_select_post_jtag;
    logic                          fuse_sense_post_jtag;
    logic                          fscan_clkungate_post_jtag;
    logic                          fscan_byprst_b_post_jtag;
    logic                          fscan_rstbypen_post_jtag;


    //********************************************************************************
    //*** JTAG WRAPPER TOP INSTANCE
    //********************************************************************************
    jtag_wrapper_top jtag_wrapper_top (
       `ifdef JTAG_INCLUDED
        // iJTAG Signals
        .ijtag_tck                             (ijtag_tck                            ),
        .ijtag_reset_b                         (ijtag_reset_b                        ),
        .ijtag_capture                         (ijtag_capture                        ),
        .ijtag_shift                           (ijtag_shift                          ),
        .ijtag_update                          (ijtag_update                         ),
        .ijtag_sel                             (ijtag_sel                            ),
        .ijtag_si                              (ijtag_si                             ),
        .ijtag_so                              (ijtag_so                             ),
        // Other Signals
        .fdfx_powergood                        (fdfx_powergood_tdr                   ),
        .secure_red                            (secure_red                           ),
        // Fuse_Hip Signals
        .fscan_mode                            (fscan_mode                           ), // TEMPORARY
       `endif
        // SOC/fuse_hip_top ports
        // HIP TOP INPUTS
        .fusevr_write_data                     (fusevr_write_data                    ),
        .fuse_senselv                          (fuse_senselv                         ),
        .fuse_sip_release_req                  (fuse_sip_release_req                 ),
        .fuse_ro_clkreq                        (fuse_ro_clkreq                       ),
        .fuse_write_data                       (fuse_write_data                      ),
        .fuse_powerup_req                      (fuse_powerup_req                     ),
        .fuse_senselvb                         (fuse_senselvb                        ),
        .fuse_favor                            (fuse_favor                           ),
        .fuse_hv_protect                       (fuse_hv_protect                      ),
        .fuse_kar                              (fuse_kar                             ),
        .fusevr_reset_n                        (fusevr_reset_n                       ),
        .fuse_address                          (fuse_address                         ),
        .fuse_sensehiz                         (fuse_sensehiz                        ),
        .fuse_pgmen                            (fuse_pgmen                           ),
        .fusevr_address                        (fusevr_address                       ),
        .fusevr_read_en                        (fusevr_read_en                       ),
        .fusevr_ro_clock                       (fusevr_ro_clock                      ),
        .fuse_powergate_en                     (fuse_powergate_en                    ),
        .fusevr_write_en                       (fusevr_write_en                      ),
        .fuse_redundant_select                 (fuse_redundant_select                ),
        .fuse_sense                            (fuse_sense                           ),
        .fscan_clkungate                       (fscan_clkungate                      ),
        .fscan_byprst_b                        (fscan_byprst_b                       ),
        .fscan_rstbypen                        (fscan_rstbypen                       ),
        // HIP TOP MUXED INPUTS (As outputs from this module)
        .fusevr_write_data_post_jtag           (fusevr_write_data_post_jtag          ),
        .fuse_senselv_post_jtag                (fuse_senselv_post_jtag               ),
        .fuse_sip_release_req_post_jtag        (fuse_sip_release_req_post_jtag       ),
        .fuse_ro_clkreq_post_jtag              (fuse_ro_clkreq_post_jtag             ),
        .fuse_write_data_post_jtag             (fuse_write_data_post_jtag            ),
        .fuse_powerup_req_post_jtag            (fuse_powerup_req_post_jtag           ),
        .fuse_senselvb_post_jtag               (fuse_senselvb_post_jtag              ),
        .fuse_favor_post_jtag                  (fuse_favor_post_jtag                 ),
        .fuse_hv_protect_post_jtag             (fuse_hv_protect_post_jtag            ),
        .fuse_kar_post_jtag                    (fuse_kar_post_jtag                   ),
        .fusevr_reset_n_post_jtag              (fusevr_reset_n_post_jtag             ),
        .fuse_address_post_jtag                (fuse_address_post_jtag               ),
        .fuse_sensehiz_post_jtag               (fuse_sensehiz_post_jtag              ),
        .fuse_pgmen_post_jtag                  (fuse_pgmen_post_jtag                 ),
        .fusevr_address_post_jtag              (fusevr_address_post_jtag             ),
        .fusevr_read_en_post_jtag              (fusevr_read_en_post_jtag             ),
        .fusevr_ro_clock_post_jtag             (fusevr_ro_clock_post_jtag            ),
        .fuse_powergate_en_post_jtag           (fuse_powergate_en_post_jtag          ),
        .fusevr_write_en_post_jtag             (fusevr_write_en_post_jtag            ),
        .fuse_redundant_select_post_jtag       (fuse_redundant_select_post_jtag      ),
        .fuse_sense_post_jtag                  (fuse_sense_post_jtag                 ),
        .fscan_clkungate_post_jtag             (fscan_clkungate_post_jtag            ),
        .fscan_byprst_b_post_jtag              (fscan_byprst_b_post_jtag             ),
        .fscan_rstbypen_post_jtag              (fscan_rstbypen_post_jtag             ),
        // Top Level Outputs to SIP (but are inputs here)
        .fuse_powerup_ack                      (fuse_powerup_ack                     ),
        .fuse_sip_release_ack                  (fuse_sip_release_ack                 ),
        .fuse_ro_clkack                        (fuse_ro_clkack                       ),
        .fuse_read_data                        (fuse_read_data                       ),
        .fusevr_read_data                      (fusevr_read_data                     ),
        .fuse_attack                           (fuse_attack                          ),
        .fuse_hip_powergood                    (fuse_hip_powergood                   )
        // end of SOC/fuse_hip_top ports
    );

    //********************************************************************************
    //*** ISOLATION CONTROLS
    //********************************************************************************
    // Description: These control signals are used to Isolate the signals between
    //              Fuse Controller SIP and the Fuse HIP based on the power states
    //              defined in the UPF file.
    //
    //              These *iso_ctrl_enb signals are NOT connect anywhere in the RTL.
    //              These are used in the UPF file as the control pin inputs  if
    //              isolation is required.
    //********************************************************************************
    assign fuse_hip2sip_iso_enb_int = fuse_hip2sip_iso_enb;

    mfz_fuse_ctech_lib_and i_fuse_hip2sip_iso_ctrl_enb (
        .a(fuse_hip2sip_iso_enb), 
        .b(!fuse_firewall_en), 
        .o(fuse_hip2sip_iso_ctrl_enb)
    );
    
    fuse_reset_mod fuse_reset_mod_i (  
        //--------------------------------------------------------------------
        // POWER PORTS
        //--------------------------------------------------------------------
      `ifdef INTEL_NO_PWR_PINS
        //******** INTEL_NO_PWR_PINS is intended to use when doing power aware simulations(UPF simulations)
      `else
        .vccsoc_nom           (vccsoc_nom                               ),
      `endif
        .fusevr_reset_n       (fusevr_reset_n_post_jtag                 ),      
        .fuse_hip2sip_iso_enb (fuse_hip2sip_iso_enb_int                 ),      
        .fusevr_reset_n_fw    (fusevr_reset_n_fw                        )
    );

    /*fuse_hip_top fuse_hip_top (
        //--------------------------------------------------------------------
        // POWER PORTS
        //--------------------------------------------------------------------
      `ifdef INTEL_NO_PWR_PINS
        //******** INTEL_NO_PWR_PINS is intended to use when doing power aware simulations(UPF simulations)
      `else
        .vccsoc_nom            (vccsoc_nom                              ),
        .vccf_nom              (vccf_nom                                ),
        .vccfhv_hvm_ehv        (vccfhv_hvm_ehv                          ),
        `ifndef HVM_ONLY              // If this is HVM only fuse count then we know this does not exist
          `ifdef MFZCHRGPUMP_INCLUDE  // If we dont have chargepump then this output does not need to exist
            .vcc_ifp_ehv       (vcc_ifp_ehv                             ),
            .vccfhv_cp_ehv     (vccfhv_cp_ehv                           ),
          `else
            .vccfhv_ifp_ehv    (vccfhv_ifp_ehv                          ),
          `endif
        `endif
      `endif
        //--------------------------------------------------------------------
        // ANALOG PORTS
        //--------------------------------------------------------------------
      `ifdef MFZVDC_INCLUDE          // If the VDC does not exists then we dont need the analog output
        .monout_vdc_ana        (monout_vdc_ana                          ),
      `endif
      `ifndef HVM_ONLY               // If this is HVM only fuse count then we know this does not exist
        `ifdef MFZBGREF_INCLUDE      // If the BGREF does not exists then we dont need the analog output
          .monout_bg_ana         (monout_bg_ana                           ),
        `endif

        `ifdef MFZCHRGPUMP_INCLUDE   // If the chargepump does not exists then we dont need the analog output
          .monout_cp_ana         (monout_cp_ana                           ),
        `endif
      `endif
        //--------------------------------------------------------------------
        // DIGIGAL PORTS
        //--------------------------------------------------------------------
        // Fuse Array input/output ports
        .fuse_redundant_select (fuse_redundant_select_post_jtag         ),
        .fuse_address          (fuse_address_post_jtag                  ),
        .fuse_hv_protect       (fuse_hv_protect_post_jtag               ),
        .fuse_sense            (fuse_sense_post_jtag                    ),
        .fuse_senselv          (fuse_senselv_post_jtag                  ),
        .fuse_sensehiz         (fuse_sensehiz_post_jtag                 ),
        .fuse_senselvb         (fuse_senselvb_post_jtag                 ),
        .fuse_favor            (fuse_favor_post_jtag                    ),
        .fuse_pgmen            (fuse_pgmen_post_jtag                    ),
        .fuse_write_data       (fuse_write_data_post_jtag               ),
        .fuse_powergate_en     (fuse_powergate_en_post_jtag             ),
        .fuse_kar              (fuse_kar_post_jtag                      ),
        .fuse_attack           (fuse_attack                             ),
        .fuse_read_data        (fuse_read_data                          ),
      `ifdef FZROSC_INCLUDE  // If we do not have ROSC then the clock output is not needed
        .fuse_ro_clk           (fuse_ro_clk                             ),
        .fuse_ro_clkack        (fuse_ro_clkack                          ),
        .fuse_ro_clkreq        (fuse_ro_clkreq_post_jtag                ),
      `endif
        .fuse_hip_powergood    (fuse_hip_powergood                      ),
        // Fuse SIP/HIP Async Handshake (see sip spec for these handshakes)
        .fuse_sip_release_req  (fuse_sip_release_req_post_jtag          ),
        .fuse_sip_release_ack  (fuse_sip_release_ack                    ),
        .fuse_powerup_req      (fuse_powerup_req_post_jtag              ),
        .fuse_powerup_ack      (fuse_powerup_ack                        ),
        // Fuse HIP Indirect Register Interface
        .fusevr_ro_clock       (fusevr_ro_clock_post_jtag               ),
        .fusevr_reset_n        (fusevr_reset_n_fw                       ), // gated fusevr_reset_n with fuse_hip2sip_iso_enb
        .fusevr_write_en       (fusevr_write_en_post_jtag               ),
        .fusevr_write_data     (fusevr_write_data_post_jtag             ),
        .fusevr_read_en        (fusevr_read_en_post_jtag                ),
        .fusevr_read_data      (fusevr_read_data                        ),
        .fusevr_address        (fusevr_address_post_jtag                ),
        // DFx Ports
        .fscan_rstbypen        (fscan_rstbypen_post_jtag                ),
        .fscan_byprst_b        (fscan_byprst_b_post_jtag                ),
        .fscan_clkungate       (fscan_clkungate_post_jtag               ),
        .fscan_mode            (fscan_mode                              )
    );*/
endmodule
