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
module fuse_hip_top
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
        input  real  vcc_ifp_ehv    [(NUM_IFP_PINS-1):0],           // VCC High Voltage, input to Chargepump/BGREF or Array if chargepump does not exist 
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
        input  logic vcc_ifp_ehv    [(NUM_IFP_PINS-1):0],           // VCC High Voltage, input to Chargepump/BGREF or Array if chargepump does not exist 
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
  `ifdef MFZVDC_INCLUDE          // If the VDC does not exists then we dont need the analog output
    output real  monout_vdc_ana  [(TOTAL_PINS-1):0],                // Voltage Monitor: VDC
  `endif
  `ifndef HVM_ONLY               // If this is HVM only fuse count then we know this does not exist
    `ifdef MFZBGREF_INCLUDE      // If the BGREF does not exists then we dont need the analog output
      output real  monout_bg_ana [(TOTAL_PINS-1):0],                // Voltage Monitor: Band Gap (HVM Pin index's will be connected to 1'b0)
    `endif

    `ifdef MFZCHRGPUMP_INCLUDE   // If the chargepump does not exists then we dont need the analog output
      output real  monout_cp_ana [(TOTAL_PINS-1):0],                // Voltage Monitor: Charge Pump (HVM Pin index's will be connected to 1'b0)
    `endif
  `endif
`else
  `ifdef MFZVDC_INCLUDE          // If the VDC does not exists then we dont need the analog output
    output logic monout_vdc_ana  [(TOTAL_PINS-1):0],                // Voltage Monitor: VDC
  `endif

  `ifndef HVM_ONLY               // If this is HVM only fuse count then we know this does not exist
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
    input  logic                          fuse_hv_protect,        // High Voltage protection enable
    input  logic                          fuse_sense,             // Fuse sense
    input  logic                          fuse_senselv,           // Fuse sense level
    input  logic                          fuse_sensehiz,          // Fuse sense current increase
    input  logic                          fuse_senselvb,          // Fuse sense levelb
    input  logic [5:0]                    fuse_favor,             // Sense amp favor bits (favor0[a,b,c], favor1[a.b.c])
    input  logic                          fuse_pgmen,             // Program Enable
    input  logic [(WRITE_DATA_WIDTH-1):0] fuse_write_data,        // Write data for fuse programming
    input  logic                          fuse_powergate_en,      // Provided to the HIP blocks to enable power gates if required 
    input  logic [(KAR_WIDTH-1):0]        fuse_kar,               // Key Access Register, used to gate Global Program Enable
    output logic [(ATTACK_WIDTH-1):0]     fuse_attack,            // Attack status
    output logic [(READ_DATA_WIDTH-1):0]  fuse_read_data,         // Read data from fuse sensing
  `ifdef FZROSC_INCLUDE // If we do not have ROSC then the clock output is not needed  
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
    // DFx Ports
    input  logic                          fscan_rstbypen,         // Scanmode : Reset Bypass Enable
    input  logic                          fscan_byprst_b,         // Scanmode : Reset Bypass Value
    input  logic                          fscan_clkungate,        // Scanmode : Forces clocks on
    input  logic                          fscan_mode              // Scanmode : Enables scan mode
);
    //********************************************************************************
    //*** TYPEDEF VARIABLES
    //********************************************************************************
    typedef enum logic unsigned [1:0] {
        // Powerup REQ/ACK States
        IDLE              = 2'b00,
        DELAY             = 2'b01,
        WAIT_POWER_UP     = 2'b10,
        REQ_WAIT          = 2'b11
    } t_powerup_state;

    //********************************************************************************
    //*** LOCAL VARIABLES
    //********************************************************************************
    // Fuse Array
    logic [(FZARRAY_STATUS_0_SIZE-1):0] fzarray_status_0_array          [(TOTAL_PINS-1):0];    // status bus from the fuse array
    logic [(FZARRAY_STATUS_0_SIZE-1):0] fzarray_status_0_result_array   [(TOTAL_PINS-1):0];    // status bus from the fuse array
    logic [(FZARRAY_STATUS_0_SIZE-1):0] fzarray_status_0;                                      // status bus from the fuse array
    // HIP Register Interface
    logic [(REG_WIDTH-1):0]             hip_reg_address;
    logic [(REG_WIDTH-1):0]             hip_reg_read_data;
    logic [(REG_WIDTH-1):0]             hip_reg_write_data;
    logic                               hip_reg_read_en;
    logic                               hip_reg_write_en;
    // Post Scan (_ps) Reset
    logic                               fusevr_reset_n_ps;
    logic                               fuse_sense_ps;
    logic                               fuse_pgmen_ps;
    // Fuse Attack
    logic [(ATTACK_WIDTH-1):0]          fuse_attack_array        [(TOTAL_PINS-1):0];    // Array to store the row attack result from each pin
    logic [(ATTACK_WIDTH-1):0]          fuse_attack_result_array [(TOTAL_PINS-1):0];    // Array to accumalate row attack result
    logic [2:0]                         redundancy_count;                               // Need 3 bits to encode the max value of 5
    // Fuse Sense Data
    logic [(READ_DATA_WIDTH-1):0]       sense_data_array         [(TOTAL_PINS-1):0];    // Array to store the sensed data from each pin
    logic [(READ_DATA_WIDTH-1):0]       sense_result_data_array  [(TOTAL_PINS-1):0];    // Array to accumalate sensed data
    // Register Read Data (dont need -1 because rosc is using the extra element in this array)
    logic [(REG_WIDTH-1):0]             reg_data_array           [(TOTAL_PINS  ):0];    // Array to store the register read data from each pin
    logic [(REG_WIDTH-1):0]             reg_result_data_array    [(TOTAL_PINS  ):0];    // Array to accumalate the register read data
    logic [(REG_WIDTH-1):0]             top_hip_reg_read_data;                          // Store the register read data from the top level registers
    //Fuse Hip Power Good Array
    logic [(TOTAL_PINS-1):0]            fuse_hip_powergood_array;
    // Charge Pump Power Good
    `ifdef MFZCHRGPUMP_INCLUDE
        logic [(TOTAL_PINS-1):0]            cp_powergood_array;
    `endif
    // Powerup REQ/ACK FSM
    reg   [9:0]                         watchdog_timer;                                 // Support at most 1024 clock cycle delay
    reg   [2:0]                         delay_counter;                                  // Support at most 8 clock cycle delay
    t_powerup_state                     curr_state;                                     // Store the current state of the power up FSM
    t_powerup_state                     next_state;                                     // Store the next state of the power up FSM
    // Divided Clock
    logic                               fuse_div_clock;                                 // Divided clock internal to the state machine
    logic                               fusevr_clock_div;                               // This is the divided clock that is consumed internally to the HIP
    logic                               clock_div_value;                                // This is the register configurable value that sets how much to divide the clock by

    //********************************************************************************
    //*** TOP LEVEL REGISTERS
    //********************************************************************************
    fuse_hip_top_wrapper #(
        .IP_NUM           (FUSE_HIP_TOP_IP_NUM)
    )
    fuse_hip_top_wrapper_inst(
        .hip_reg_ro_clock   (fusevr_clock_div      ),    // External Clock
        .hip_reg_reset_n    (fusevr_reset_n_ps     ),    // Active low reset
        .hip_reg_address    (hip_reg_address       ),    // The address to read/write to 
        .hip_reg_write_en   (hip_reg_write_en      ),    // Enables writes to the registers
        .hip_reg_write_data (hip_reg_write_data    ),    // The write data for the register
        .hip_reg_read_en    (hip_reg_read_en       ),    // Enables read data from the registers
        .hip_reg_read_data  (top_hip_reg_read_data ),    // The read data from the register
        .clock_div          (clock_div_value       ),    // The value to divide the block by
        .fscan_mode         (fscan_mode            )
    );
 
    //********************************************************************************
    //*** CLOCK DIVIDER - created a divided clock based on register value for counter
    //********************************************************************************
    mfz_fuse_ctech_lib_clk_divider2_rstb i_fuse_clk_divider_rstb (
             .clkout(fuse_div_clock), 
             .clk(fusevr_ro_clock), 
             .rstb(fusevr_reset_n_ps)
         );
    
    mfz_fuse_ctech_lib_clk_mux_2to1 i_fuse_clk_mux_2to1 (
             .clk2(fusevr_ro_clock),
             .clk1(fuse_div_clock), 
             .s(clock_div_value), 
             .clkout(fusevr_clock_div)
         );

    //********************************************************************************
    //** WIRE OR/AND OF ALL STATUS OUT FROM FUSE ARRAY
    //********************************************************************************
    assign fzarray_status_0_result_array[0] = fzarray_status_0_array[0];      // Init the first element to be used in the for lo
    generate    // Loop over remaining elements
        for (genvar pin_index = 1; pin_index <= (TOTAL_PINS-1); pin_index++) begin
            assign fzarray_status_0_result_array[pin_index] = fzarray_status_0_result_array[(pin_index-1)] | fzarray_status_0_array[pin_index]; 
        end
    endgenerate
    assign fzarray_status_0 = fzarray_status_0_result_array[(TOTAL_PINS-1)];  // Assign the read data to the output

    
    //********************************************************************************
    //*** FUSE HIP POWERGOOD
    //********************************************************************************
    // Description: The Fuse Controller SIP requires a single powergood signal from
    //              the Fuse HIP.  This logic AND's all of the power good signals
    //              together, 1 from the VDC within each PIN.
    //********************************************************************************
    assign fuse_hip_powergood = &(fuse_hip_powergood_array[(TOTAL_PINS-1):0]);

    //********************************************************************************
    //*** DFX : SCAN CONTROL
    //********************************************************************************
    // Description: Need to handle some of the signals specially while in fscan_mode.
    //
    //                 - Per Chassis DFx, while in fscan_mode, the SoC need a way to
    //                   control the IP's reset from the SRC (Scan Reset Controller).
    //                 - To protect against damage to the LV4K, ensure fuse_pgmen
    //                   is forced to 1'b0 so we don't continually toggle it while
    //                   in fscan_mode, possibly leading to accidental programming.
    //                 - To protect against damage to the LV4K, ensure fuse_sense
    //                   signals is forced to 1'b0 so we are not continually sensing
    //                   the LV4K, leading to reliability concerns.
    //
    //  N O T E :      - ps = post scan
    //********************************************************************************
    assign fusevr_reset_n_ps = fscan_rstbypen ? fscan_byprst_b : fusevr_reset_n;
    assign fuse_sense_ps     = fscan_mode     ? 1'b0           : fuse_sense;
    assign fuse_pgmen_ps     = fscan_mode     ? 1'b0           : fuse_pgmen;

    //********************************************************************************
    //*** Fuse HIP Indirect Addressing Interface
    //********************************************************************************
    fuse_hip_indirect_registers i_fuse_hip_indirect_registers(
        // Fuse Controller fusevr_bus Interface 
        .fusevr_ro_clock    (fusevr_clock_div  ), 
        .fusevr_reset_n     (fusevr_reset_n_ps ),
        .fusevr_write_en    (fusevr_write_en   ),
        .fusevr_write_data  (fusevr_write_data ),
        .fusevr_read_en     (fusevr_read_en    ),
        .fusevr_address     (fusevr_address    ),
        .fusevr_read_data   (fusevr_read_data  ),

        // HIP Register Interface
        .hip_reg_write_en   (hip_reg_write_en  ),
        .hip_reg_write_data (hip_reg_write_data),
        .hip_reg_read_en    (hip_reg_read_en   ),
        .hip_reg_address    (hip_reg_address   ),
        .hip_reg_read_data  (hip_reg_read_data )
    );

    //********************************************************************************
    //*** Ring Oscillator
    //********************************************************************************
    `ifdef FZROSC_INCLUDE
        fuse_hip_fzrosc_wrapper#(
            .IP_NUM           (FZ_ROSC_IP_NUM)
        )
        i_fuse_hip_fzrosc_wrapper(
          `ifdef INTEL_NO_PWR_PINS
          `else   // Covers both REAL_VALUES and DEFAULT                 
            .vccf_nom           (vccf_nom                  ),
          `endif
            //ROSC Inputs
            .rosc_clkreq        (fuse_ro_clkreq            ),
            //ROSC Outputs
            .rosc_clkack        (fuse_ro_clkack            ), 
            .rosc_clk_out       (fuse_ro_clk               ),
            // HIP Register Interface
            .hip_reg_ro_clock   (fusevr_clock_div          ),
            .hip_reg_reset_n    (fusevr_reset_n_ps         ),
            .hip_reg_address    (hip_reg_address           ),
            .hip_reg_write_en   (hip_reg_write_en          ),
            .hip_reg_write_data (hip_reg_write_data        ),
            .hip_reg_read_en    (hip_reg_read_en           ),
            .hip_reg_read_data  (reg_data_array[TOTAL_PINS]),
            // DFx Interface
            .fscan_mode         (fscan_mode                )
        );
    `else
        assign reg_data_array[TOTAL_PINS] = 32'b0;  // Have to make the register read return all 0 for this hip when it does not exist
    `endif

    //********************************************************************************
    //*** WIRED OR LOGIC
    //********************************************************************************
    // The purpose is to reduce the results from each array element down to a single
    // result. This works are each driver will drive a 0 when not selected.
    // This allows for any number of array elements.
    //
    // Store the first element of the *_array in the first element of *_result_array.
    // Take the previous element of the *_result_array and OR with the current element
    // of *_array.  Store to current element of *_result_array. This is repeated for
    // all elements (pins) resulting in the final element of the *_result_array
    // having the final WIRED OR value and is the final accumulated value.
    //********************************************************************************
    //***********************************************
    //*** WIRED OR : Indirect Register Read Data
    //***********************************************
    assign reg_result_data_array[0] = reg_data_array[0];           // Init the first element to be used in the for loop below
    generate                                                       // Loop over remaining elements
        for (genvar num_pin = 1; num_pin <= TOTAL_PINS; num_pin++) begin
            assign reg_result_data_array[num_pin] = reg_result_data_array[(num_pin-1)] | reg_data_array[num_pin]; 
        end
    endgenerate
    assign hip_reg_read_data = (reg_result_data_array[TOTAL_PINS] | top_hip_reg_read_data);  // Assign the read data to the output

    //***********************************************
    //*** WIRED OR : Fuse Sensed Data & Attack Bus
    //***********************************************
    assign sense_result_data_array[0]  = sense_data_array[0];         // Init the first element to be used in the for loop below
    assign fuse_attack_result_array[0] = fuse_attack_array[0];        // Init the first element to be used in the for loop below
    generate                                                          // Loop over remaining elements
        for (genvar num_pin = 1; num_pin < TOTAL_PINS; num_pin++) begin
                assign sense_result_data_array [num_pin] = sense_result_data_array[(num_pin-1)]  | sense_data_array [num_pin]; 
                assign fuse_attack_result_array[num_pin] = fuse_attack_result_array[(num_pin-1)] | fuse_attack_array[num_pin]; 
        end
    endgenerate
    assign fuse_read_data = (fuse_attack[7:0] != 8'b0) ? ({{READ_DATA_WIDTH-1}{1'b0}}) : (sense_result_data_array [(TOTAL_PINS-1)]); // assign the read data to the output

    //********************************************************************************
    //*** FUSE ATTACK
    //********************************************************************************
    //   Chassis Fuse Controller Attack Bus
    //   ----------------------------------
    //     7 = Over Voltage          [Driven from the Pin Level VDC]
    //     6 = Under Voltage         [Driven from the Pin Level VDC]
    //     5 = Reserved (Always 0)   [Forced to 0]
    //     4 = Reserved (Always 0)   [Forced to 0]
    //     3 = Reserved (Always 0)   [Forced to 0]
    //     2 = Module Attack         [Computed here]
    //     1 = Array Attack          [Computed here]
    //     0 = Row Attack            [Generated from the LV4K, Result from WIRED OR]
    // 
    //   Chassis Fuse Controller Address
    //   -------------------------------
    //       15 : SpecialRow Select
    //     14:8 : Module
    //      7:5 : Array
    //      4:0 : Row
    //
    //       Fuse HIP has removed the Module / Array concept and treats all 10 bits
    //       are arrays.  Therefore, the HIP Array address is both 
    //
    //   REDUNDANCY CHECKS
    //      * Ensure only 1 redundancy bit is set, so add together each bit of the
    //        fuse_redundant_select input
    //      * Ensure the one hot fuse_redundacny_select is <= the max 1 hot value
    //        based on the SOCFUSEGEN_*_REDUNDANCY parameter
    //
    //        Max one hot redundant value is set by this logic:
    //          (1'b1 << (SOCFUSEGEN_*_REDUNDANCY - 1))
    // 
    //           REDUNDANCY = 1        REDUNDANCY = 3        REDUNDANCY = 5
    //             (1'b1 << (1 - 1))     (1'b1 << (2 - 1))     (1'b1 << (5 - 1))
    //             (1'b1 << 0)           (1'b1 << 2)           (1'b1 << 4)
    //             (5'b00001)            (5'b00100)            (5'b10000)
    //
    //  NOTE: These fuse_attack bus is ONLY valid while fuse_sense or fuse_pgmen
    //        are active (1'b1)
    //  NOTE: Added (5'b00000 | *) to the fuse_attack[1] to remove STLINT warning
    //********************************************************************************
    always_comb begin
        redundancy_count = fuse_redundant_select[4] + fuse_redundant_select[3] + fuse_redundant_select[2] + fuse_redundant_select[1] + fuse_redundant_select[0];
        if (fuse_sense || fuse_pgmen)               // Purposely not using the _ps versions.  It's desired to send a toggling fuse_attack back to the controller during fscan_mode
          begin
            fuse_attack[7:3] = fuse_attack_result_array[(TOTAL_PINS-1)][7:3];
            fuse_attack[  2] = fuse_address[14:8] >= TOTAL_MODULES;
            fuse_attack[  1] = !((((fuse_address[14:5] >= INTELHVM_START_ARRAY_ADDRESS) && (fuse_address[14:5] <= INTELHVM_END_ARRAY_ADDRESS) && // Array Address
                                   (fuse_redundant_select <= (5'b00000 | (1'b1 << (SOCFUSEGEN_INTELHVM_REDUNDANCY - 1))))) ||
                                  ((fuse_address[14:5] >= INTELIFP_START_ARRAY_ADDRESS) && (fuse_address[14:5] <= INTELIFP_END_ARRAY_ADDRESS) && // Array Address
                                   (fuse_redundant_select <= (5'b00000 | (1'b1 << (SOCFUSEGEN_INTELIFP_REDUNDANCY - 1))))) ||
                                  ((fuse_address[14:5] >= OEMIFP_START_ARRAY_ADDRESS  ) && (fuse_address[14:5] <= OEMIFP_END_ARRAY_ADDRESS)   && // Array Address
                                   (fuse_redundant_select <= (5'b00000 | (1'b1 << (SOCFUSEGEN_OEMIFP_REDUNDANCY - 1  )))))) &&
                                   (redundancy_count == 3'b1));
            fuse_attack[  0] = fuse_attack_result_array[(TOTAL_PINS-1)][0];
          end
        else
            fuse_attack[7:0] = 8'b0;
    end

    //********************************************************************************
    //*** ASYNCHRONOUS HANDSHAKE PROTOCOLS
    //********************************************************************************
    // There are 2 Asynchonous Handshakes, both of which are a 4 phase protocol.
    //      1) Fuse Controller asserts REQ
    //      2) Fuse HIP        asserts ACK
    //      3) Fuse Controller deasserts REQ
    //      4) Fuse HIP        deasserts ACK
    //            _______________________
    //    REQ  ___|                     |____________
    //                               ___________
    //    ACK   _____________________|         |______
    //              ^^^^^^^^^^^^^^^^^
    //             Fuse HIP processing (IF NEEDED)
    //
    // 1) fuse_sip_release REQ/ACK handling
    //      - This is not needed for Chassis products on Intel process.
    //      - This is asserted by the Fuse Controller SIP after the last bit in a 
    //        row has been programmed.  This gives control to the Fuse HIP wrapper
    //        to perform any programming tasks required.  For products on Intel
    //        process the Fuse Controller SIP handles everything, hence nothing needs
    //        to be processed by teh Fuse HIP wrapper.
    //      - Therefore simply tie the REQ to the ACK.
    //
    // 2) fuse_powerup REQ/ACK handling
    //  Fuse Programming  (fuse_hv_protect == 1 && fuse_sip_release_ack == 1)
    //  ----------------
    //      * For Chassis, the Fuse Controller handles all ECC computation and
    //        programming on a per row basis. Therefore, no work required in the
    //        Fuse HIP wrapper.
    //      * However when a new array is being addressed, a delay
    //        is required to allow the Power Gates to turn on for the prior
    //        addressed array, and turn off for the currently addressed array.
    //
    //  Fuse Sensing  (fuse_hv_protect == 0 && fuse_sip_release_ack == 1)
    //  ------------
    //      * When a new array is being addressed, a delay is required to allow
    //        the Power Gates to turn on for the prior addressed array, and
    //        turn off for the currently addressed array.
    //********************************************************************************
    
    // SIP RELEASE REQ/ACK
    assign fuse_sip_release_ack = fuse_sip_release_req;

    // POWER UP REQ/ACK
    always_ff @(posedge fusevr_clock_div or negedge fusevr_reset_n_ps)
      begin
        if (~fusevr_reset_n_ps)
           curr_state <= IDLE;
        else
           curr_state <= next_state;
      end

    always_ff @(posedge fusevr_clock_div or negedge fusevr_reset_n_ps) // always at clock reset or state change
      begin
        if (~fusevr_reset_n_ps)
          begin
            next_state       <= IDLE;
            watchdog_timer   <= ARRAY_POWERGATE_WATCHDOG_TIMER;
            fuse_powerup_ack <= 1'b0;
            delay_counter    <= 3'h5;
          end
        else
          begin
            case (curr_state)
                IDLE              :
                  begin
                    watchdog_timer  <= ARRAY_POWERGATE_WATCHDOG_TIMER;   // reset the counter
                    delay_counter   <= 3'h5;
                    // If controller asserts powerup request
                    if (fuse_powerup_req) begin  
                          next_state       <= DELAY;
                    end
                  end

                DELAY             :
                  // Wait 5 clocks before checking for the power indication from the selected array
                  // This avoids any possible glitches in the power switching from powering down the previously selected
                  // array and powering up the currently selected array
                  begin
                    if (delay_counter == 0) begin
                         next_state   <= WAIT_POWER_UP;
                    end else
                        delay_counter <= delay_counter -1;
                  end

                // There is a race between the power indication from the selected array and the watchdog timer.  If the
                // array gets powered all is good with the protocoal.  If teh array never gets powered (say from an invalid 
                // address) then the watchdog timer will expire and the protocal will be completed.  As there is no error
                // indication in the handshake, it is up to the fuse controller to detect that this occured.  If this was a sense
                // event, the canary 1 row will return all 0's and hence the fuse controller will stop fuse sensing and 
                // assert fuse_sense_error.  If this was a programmign event, when the user performs a read to verify the
                // programmed value, it will detect the programming failed.  So in both cases, there are checks.  But the
                // Fuse HIP is not going to hang the Fuse Controller by not completing the powerup_req/ack protocal.
                WAIT_POWER_UP     :
                  begin
                    if ((fzarray_status_0[0]) || (watchdog_timer == 0)) begin
                        next_state       <= REQ_WAIT;
                        fuse_powerup_ack <= 1'b1;
                    end else
                        watchdog_timer <= watchdog_timer -1;
                  end

                REQ_WAIT          :
                  begin
                    if (~fuse_powerup_req) begin
                        next_state       <= IDLE;
                        fuse_powerup_ack <= 1'b0;
                    end
                  end

                default          :
                  begin
                    next_state       <= IDLE;
                  end
              endcase
          end
      end
    
    //********************************************************************************
    //*** Intel HVM Pins
    //********************************************************************************
    /*generate
        for (genvar pin=0; pin<NUM_INTELHVM_PINS; pin++) begin: intel_hvm_pin   // Loops and instantiates all INTELHVM pins
            fuse_hip_pin #(
                //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////  
                // For a "pin" that is NOT the last INTELHVM_PIN, instance the max number of LOGICAL arrays on a pin
                // For a "pin" that is     the last INTELHVM_PIN
                //     - If the remaining arrays          equals the NUM_LOGICAL_INTELHVM_ARRAYS_ON_PIN, instance the max number of LOGICAL arrays
                //     - If the remaining arrays does not equals the NUM_LOGICAL_INTELHVM_ARRAYS_ON_PIN, instance the remainder  of LOGICAL arrays
                //
                // Max LOGICAL arrays = NUM_LOGICAL_INTELHVM_ARRAYS_ON_PIN
                //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////  
                .LOGICAL_ARRAYS  ( (pin < (NUM_INTELHVM_PINS-1))            ?  NUM_LOGICAL_INTELHVM_ARRAYS_ON_PIN :
                                   (INTELHVM_LAST_PIN_ARRAY_REMAINDER == 0) ?  NUM_LOGICAL_INTELHVM_ARRAYS_ON_PIN :
                                                                               INTELHVM_LAST_PIN_ARRAY_REMAINDER),
                .START_ARRAY_NUM ((pin * NUM_LOGICAL_INTELHVM_ARRAYS_ON_PIN) + INTELHVM_START_ARRAY_ADDRESS),        // Start array to keep addressing contiguous
                .REDUNDANCY      (SOCFUSEGEN_INTELHVM_REDUNDANCY),                                                   // Redundancy passed in for when we instance the arrays
                .IS_HVM_PIN      (INTELHVM_POWER_SUPPLY_TYPE)                                                        // Indicates what power supply to use for programming
            )
            intelhvm_pin(
              `ifdef INTEL_NO_PWR_PINS
              `else    // Covers both REAL_VALUES and DEFAULT                 
                .vccf_nom               (vccf_nom                       ),
                .vccfhv_ehv             (vccfhv_hvm_ehv[pin]            ),
                `ifndef HVM_ONLY              // If this is HVM only fuse count then we know this does not exist
                  `ifdef MFZCHRGPUMP_INCLUDE  // If we dont have chargepump then this output does not need to exist
                    .vcc_ehv            (1'b0                           ),     // These are unused and driven to 1'b0
                    .vccfhv_cp_ehv      (vccfhv_cp_ehv[pin]             ),
                  `endif
                `endif
              `endif

              `ifndef HVM_ONLY                // If this is HVM only fuse count then we know this does not exist
                `ifdef MFZBGREF_INCLUDE       // If the BGREF does not exists then we dont need the analog output
                  .monout_bg_ana        (monout_bg_ana[pin]             ),
                `endif

                `ifdef MFZCHRGPUMP_INCLUDE    // If the chargepump does not exists then we dont need the analog output or power good
                  .monout_cp_ana        (monout_cp_ana[pin]             ),
                  .cp_powergood         (cp_powergood_array[pin]        ),
                `endif
              `endif

              `ifdef MFZVDC_INCLUDE           // If the VDC does not exists then we dont need the analog output
                .monout_vdc_ana         (monout_vdc_ana[pin]            ),     
              `endif
                // Fuse Array Interface
                .fuse_address           (fuse_address                   ),
                .fuse_write_data        (fuse_write_data                ),
                .fuse_sense             (fuse_sense_ps                  ),
                .fuse_senselv           (fuse_senselv                   ),
                .fuse_sensehiz          (fuse_sensehiz                  ),
                .fuse_senselvb          (fuse_senselvb                  ),
                .fuse_favor             (fuse_favor                     ),
                .fuse_pgmen             (fuse_pgmen_ps                  ),
                .fuse_hv_protect        (fuse_hv_protect                ),
                .fuse_powergate_en      (fuse_powergate_en              ),
                .fuse_redundant_select  (fuse_redundant_select          ),
                .fuse_kar               (fuse_kar                       ),
                .fuse_sense_data        (sense_data_array[pin]          ),
                .fuse_attack            (fuse_attack_array[pin]         ),
                .fuse_hip_powergood     (fuse_hip_powergood_array[pin]  ),
                .fzarray_status_0       (fzarray_status_0_array[pin]    ),
                // HIP Register Interface
                .hip_reg_ro_clock       (fusevr_clock_div               ),
                .hip_reg_reset_n        (fusevr_reset_n_ps              ),
                .hip_reg_address        (hip_reg_address                ),
                .hip_reg_write_en       (hip_reg_write_en               ),
                .hip_reg_write_data     (hip_reg_write_data             ),
                .hip_reg_read_en        (hip_reg_read_en                ),
                .hip_reg_read_data      (reg_data_array[pin]            ),
                // DFx Ports
                .fscan_mode             (fscan_mode                     )
            );
        end: intel_hvm_pin
        
        //********************************************************************************
        //*** Intel IFP Pins
        //********************************************************************************
        for (genvar pin=0; pin<NUM_INTELIFP_PINS; pin++) begin: intel_ifp_pin   // Loops and instantiates all INTELIFP pins
            fuse_hip_pin #(
                //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////  
                // For a "pin" that is NOT the last INTELIFP_PIN, instance the max number of LOGICAL arrays on a pin
                // For a "pin" that is     the last INTELIFP_PIN
                //     - If the remaining arrays          equals the NUM_LOGICAL_INTELIFP_ARRAYS_ON_PIN, instance the max number of LOGICAL arrays
                //     - If the remaining arrays does not equals the NUM_LOGICAL_INTELIFP_ARRAYS_ON_PIN, instance the remainder  of LOGICAL arrays
                //
                // Max LOGICAL arrays = NUM_LOGICAL_INTELIFP_ARRAYS_ON_PIN
                //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////  
                .LOGICAL_ARRAYS  ( (pin < (NUM_INTELIFP_PINS-1))            ?  NUM_LOGICAL_INTELIFP_ARRAYS_ON_PIN :
                                   (INTELIFP_LAST_PIN_ARRAY_REMAINDER == 0) ?  NUM_LOGICAL_INTELIFP_ARRAYS_ON_PIN :
                                                                               INTELIFP_LAST_PIN_ARRAY_REMAINDER),
                .START_ARRAY_NUM ((pin * NUM_LOGICAL_INTELIFP_ARRAYS_ON_PIN) + INTELIFP_START_ARRAY_ADDRESS),        // Start array to keep addressing contiguous
                .REDUNDANCY      (SOCFUSEGEN_INTELIFP_REDUNDANCY),                                                   // Redundancy passed in for when we instance the arrays
                .IS_HVM_PIN      (INTELIFP_POWER_SUPPLY_TYPE)                                                        // Indicates what power supply to use for programming
            )
            intelifp_pin(
              `ifdef INTEL_NO_PWR_PINS
              `else    // Covers both REAL_VALUES and DEFAULT                 
                .vccf_nom               (vccf_nom                                         ),
                `ifdef MFZCHRGPUMP_INCLUDE   // If we dont have chargepump then this output does not need to exist
                  .vccfhv_ehv         (1'b0                                               ),     // Intel IFP uses a Charge Pump to supply the VCCFHV voltage
                  .vcc_ehv            (vcc_ifp_ehv[pin]                                   ),
                  .vccfhv_cp_ehv      (vccfhv_cp_ehv[pin+NUM_INTELHVM_PINS]               ),
                `else
                  .vccfhv_ehv         (vccfhv_ifp_ehv[pin]                                ),     // IF Chargepump does not exist then vcc_ehv is the programing supply
                `endif
              `endif

              `ifndef HVM_ONLY
                `ifdef MFZBGREF_INCLUDE       // If the BGREF does not exists then we dont need the analog output
                  .monout_bg_ana        (monout_bg_ana[pin+NUM_INTELHVM_PINS]               ),
                `endif

                `ifdef MFZCHRGPUMP_INCLUDE    // If the chargepump does not exists then we dont need the analog output or power good
                  .monout_cp_ana        (monout_cp_ana[pin+NUM_INTELHVM_PINS]               ),
                  .cp_powergood         (cp_powergood_array[pin+NUM_INTELHVM_PINS]          ),
                `endif
              `endif

              `ifdef MFZVDC_INCLUDE           // If the VDC does not exists then we dont need the analog output
                .monout_vdc_ana         (monout_vdc_ana[pin+NUM_INTELHVM_PINS]            ),     
              `endif
                // Fuse Array Interface
                .fuse_address           (fuse_address                                     ),
                .fuse_write_data        (fuse_write_data                                  ),
                .fuse_sense             (fuse_sense_ps                                    ),
                .fuse_senselv           (fuse_senselv                                     ),
                .fuse_sensehiz          (fuse_sensehiz                                    ),
                .fuse_senselvb          (fuse_senselvb                                    ),
                .fuse_favor             (fuse_favor                                       ),
                .fuse_pgmen             (fuse_pgmen_ps                                    ),
                .fuse_hv_protect        (fuse_hv_protect                                  ),
                .fuse_powergate_en      (fuse_powergate_en                                ),
                .fuse_redundant_select  (fuse_redundant_select                            ),
                .fuse_kar               (fuse_kar                                         ),
                .fuse_sense_data        (sense_data_array[pin+NUM_INTELHVM_PINS]          ),
                .fuse_attack            (fuse_attack_array[pin+NUM_INTELHVM_PINS]         ),
                .fuse_hip_powergood     (fuse_hip_powergood_array[pin+NUM_INTELHVM_PINS]  ),
                .fzarray_status_0       (fzarray_status_0_array[pin+NUM_INTELHVM_PINS]    ),
                // HIP Register Interface
                .hip_reg_ro_clock       (fusevr_clock_div                                 ),
                .hip_reg_reset_n        (fusevr_reset_n_ps                                ),
                .hip_reg_address        (hip_reg_address                                  ),
                .hip_reg_write_en       (hip_reg_write_en                                 ),
                .hip_reg_write_data     (hip_reg_write_data                               ),
                .hip_reg_read_en        (hip_reg_read_en                                  ),
                .hip_reg_read_data      (reg_data_array [pin+NUM_INTELHVM_PINS]           ),
                // DFx Ports
                .fscan_mode             (fscan_mode                                       )
            );
        end: intel_ifp_pin
        
        //********************************************************************************
        //*** OEM IFP Pins
        //********************************************************************************
        for (genvar pin=0; pin<NUM_OEMIFP_PINS; pin++) begin: oem_ifp_pin // Loops and instantiates all OEMIFP pins
            fuse_hip_pin #(
                //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////  
                // For a "pin" that is NOT the last OEMIFP_PIN, instance the max number of LOGICAL arrays on a pin
                // For a "pin" that is     the last OEMIFP_PIN
                //     - If the remaining arrays          equals the NUM_LOGICAL_OEMIFP_ARRAYS_ON_PIN, instance the max number of LOGICAL arrays
                //     - If the remaining arrays does not equals the NUM_LOGICAL_OEMIFP_ARRAYS_ON_PIN, instance the remainder  of LOGICAL arrays
                //
                // Max LOGICAL arrays = NUM_LOGICAL_INTELIFP_ARRAYS_ON_PIN
                //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////  
                .LOGICAL_ARRAYS  ( (pin < (NUM_OEMIFP_PINS-1))            ?  NUM_LOGICAL_OEMIFP_ARRAYS_ON_PIN :
                                   (OEMIFP_LAST_PIN_ARRAY_REMAINDER == 0) ?  NUM_LOGICAL_OEMIFP_ARRAYS_ON_PIN :
                                                                             OEMIFP_LAST_PIN_ARRAY_REMAINDER),
                .START_ARRAY_NUM ((pin * NUM_LOGICAL_OEMIFP_ARRAYS_ON_PIN) + OEMIFP_START_ARRAY_ADDRESS),        // Start array to keep addressing contiguous
                .REDUNDANCY      (SOCFUSEGEN_OEMIFP_REDUNDANCY),                                                 // Redundancy passed in for when we instance the arrays
                .IS_HVM_PIN      (OEMIFP_POWER_SUPPLY_TYPE)                                                      // Indicates what power supply to use for programming
            )
            oemifp_pin(
              `ifdef INTEL_NO_PWR_PINS
              `else    // Covers both REAL_VALUES and DEFAULT                 
                .vccf_nom               (vccf_nom                                                           ),
                `ifdef MFZCHRGPUMP_INCLUDE   // If we dont have chargepump then this output does not need to exist
                  .vccfhv_ehv         (1'b0                                                               ),     // OEM IFP uses a Charge Pump to supply the VCCFHV voltage
                  .vcc_ehv            (vcc_ifp_ehv[pin+NUM_INTELIFP_PINS]                                     ),
                  .vccfhv_cp_ehv      (vccfhv_cp_ehv[pin+NUM_INTELHVM_PINS+NUM_INTELIFP_PINS]             ),
                `else
                  .vccfhv_ehv         (vccfhv_ifp_ehv[pin+NUM_INTELIFP_PINS]                                     ),     // IF Chargepump does not exist then vcc_ehv is the programing supply
                `endif
              `endif

              `ifndef HVM_ONLY
                `ifdef MFZBGREF_INCLUDE     // If the BGREF does not exists then we dont need the analog output
                  .monout_bg_ana        (monout_bg_ana[pin+NUM_INTELHVM_PINS+NUM_INTELIFP_PINS]             ),
                `endif

                `ifdef MFZCHRGPUMP_INCLUDE  // If the chargepump does not exists then we dont need the analog output or power good
                  .monout_cp_ana        (monout_cp_ana[pin+NUM_INTELHVM_PINS+NUM_INTELIFP_PINS]             ),
                  .cp_powergood         (cp_powergood_array[pin+NUM_INTELHVM_PINS+NUM_INTELIFP_PINS]        ),
                `endif
              `endif

              `ifdef MFZVDC_INCLUDE         // If the VDC does not exists then we dont need the analog output
                .monout_vdc_ana         (monout_vdc_ana[pin+NUM_INTELHVM_PINS+NUM_INTELIFP_PINS]            ),     
              `endif
                // Fuse Array Interface
                .fuse_address           (fuse_address                                                       ),
                .fuse_write_data        (fuse_write_data                                                    ),
                .fuse_sense             (fuse_sense_ps                                                      ),
                .fuse_senselv           (fuse_senselv                                                       ),
                .fuse_sensehiz          (fuse_sensehiz                                                      ),
                .fuse_senselvb          (fuse_senselvb                                                      ),
                .fuse_favor             (fuse_favor                                                         ),
                .fuse_pgmen             (fuse_pgmen_ps                                                      ),
                .fuse_hv_protect        (fuse_hv_protect                                                    ),
                .fuse_powergate_en      (fuse_powergate_en                                                  ),
                .fuse_redundant_select  (fuse_redundant_select                                              ),
                .fuse_kar               (fuse_kar                                                           ),
                .fuse_sense_data        (sense_data_array[pin+NUM_INTELHVM_PINS+NUM_INTELIFP_PINS]          ),
                .fuse_attack            (fuse_attack_array[pin+NUM_INTELHVM_PINS+NUM_INTELIFP_PINS]         ),
                .fuse_hip_powergood     (fuse_hip_powergood_array[pin+NUM_INTELHVM_PINS+NUM_INTELIFP_PINS]  ),
                .fzarray_status_0       (fzarray_status_0_array[pin+NUM_INTELHVM_PINS+NUM_INTELIFP_PINS]    ),
                // HIP Register Interface
                .hip_reg_ro_clock       (fusevr_clock_div                                                   ),
                .hip_reg_reset_n        (fusevr_reset_n_ps                                                  ),
                .hip_reg_address        (hip_reg_address                                                    ),
                .hip_reg_write_en       (hip_reg_write_en                                                   ),
                .hip_reg_write_data     (hip_reg_write_data                                                 ),
                .hip_reg_read_en        (hip_reg_read_en                                                    ),
                .hip_reg_read_data      (reg_data_array [pin+NUM_INTELHVM_PINS+NUM_INTELIFP_PINS]           ),
                // DFx Ports
                .fscan_mode             (fscan_mode                                                         )
            );
        end: oem_ifp_pin
   endgenerate*/
endmodule
