                  //------------------------------------------------------------------------------
//
//  INTEL CONFIDENTIAL
//
//  Copyright 2014-2017 Intel Corporation All Rights Reserved.
//
//  The source code contained or described herein and all documents related
//  to the source code (?Material?) are owned by Intel Corporation or its
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

// ctech_lib_triplesync_setb  flop with metastability modeling active low set
// Date Generated:  08:38:29 05-Oct-2017//
// This file is generated from the template. Don't directly modify.
// Template File:  ctech_lib_sync.sv.template
// Waiving two lintra rules:
// 50514 - Waived because new UDR not available for updated copyright notice
// 68000 - This is a ctech component, so it does not need a fuse puller 
// 70607 - This is a ctech component, so it does not have visa 
//lintra push -50514, -68000, -70607

// Set INTEL_SIMONLY if VCS is set. We clear it after this file. This maintains compatibilty to legacy VCS define usage. 

`ifndef INTEL_SIMONLY  
    // And add emulation control because of the unified compiler flow sets in VCS
    `ifndef INTEL_EMULATION
        `ifdef VCS
            `define INTEL_SIMONLY
            `define CLEAR_SIMONLY
         `endif // VCS
     `endif // INTEL_EMULATION
`endif // INTEL_SIMONLY

module ctech_lib_triplesync_setb # (  

// Parameters: 
//     Non Override Parameters
//             WIDTH (int)               Defines the number of bits that are synchronized (default=1). 
//             MIN_PERIOD (time)         When non-zero, input data delays are used rather than random N/N+1 flop delays.
//                                       MIN_PERIOD specifies the minimum period used by either the source or destination
//                                       clock domain. The timescale determines the delay time units. For example, if the
//                                       timescale is specified as 1ps/100fs, then a MIN_PERIOD value of 100 results in an
//                                       input data delay of 100ps. 
//             SINGLE_BUS_META           When set to one, all bits of the meta flop use the same randomized delay. When
//                                       set to zero (the default), all bit delays are randomized independently.
//
//    Override Parameters - these have plusarg overrides.
//             METASTABILITY_EN          When set to zero, metastability modeling is disabled on a per-instance basis (default=1).
//             TX_MODE                   Enables the meta flop to make select value only based on the current value or 1 tx clock delayed values
//                                       Tx clock will be inferred from a signal change on the d pin(s). TX_MODE=1 cannot be overriden
//                                       by a plusarg. However, TX_MODE=0 (the default) can be overridden by plusarg +CTECH_LIB_TX_MODE.
//             PULSE_WIDTH_CHECK         Not currently used. Reserved for future use.
//
//    Enabling parameters - the corresponding plusarg must also exist for the behavior to occur.
//             ENABLE_3TO1               Enables the meta flop to make 3 clock delays to 1 clock delays and possible loss of some pulses (default = 1).
//                                       It also disables 1 clock delays followed by 3 clock delays. Plusarg +CTECH_LIB_ENABLE_3TO1 must also exist
//                                       on the simulation command line for this parameter to have an effect.
//                                      
// Plusargs:   
//             +CTECH_LIB_META_DISPLAY   Display metaflop module name, full instance path, parameter and plusarg values in the log file (at time 0).
//             +CTECH_LIB_SYNC_INFO      Similar to above, but displays random delay info in a more human-readable format.
//             +CTECH_LIB_META_OFF       When set, metastablity modeling is globally disabled (useful for SOC test vector generation).
//             +CTECH_LIB_PULSE_ON       When set input pulse width assertions are enabled (not currently supported).
//
//                                       The following two plusarg only features are mutually exclusive and should not be set at the same time.
//                                       If they are, a runtime error occurs.
//             +CTECH_LIB_PLUS1_ONLY     Disable the Minus 1 RX flop Mode. A doublesync meta flop will only provide 2 or 3 clocks of delay.
//                                       If parameter MINUS1_ONLY=1 for a metaflop instance, this plusarg has no effect.
//             +CTECH_LIB_MINUS1_ONLY    Disable the Plus 1 RX flop Mode. A doublesync meta flop will only provide 1 or 2 clocks of delay.
//                                       If parameter PLUS1_ONLY=1 for a metaflop instance, this plusarg has no effect.
//
//             +CTECH_LIB_ENABLE_3TO1    Enables the meta flop to use 3 clock delays followed by a 1 clock delay, possibly causing data loss.
//                                       It also disables 1 clock delays followed by 3 clock delays. Parameter ENABLE_3TO1 (default=1) must also
//                                       be set for this plusarg to have an effect.
//             +CTECH_LIB_TX_MODE        Enables the meta flop to make select value only based on the current value or 1 tx clock delayed values.
//                                       Tx clock will be inferred from a signal change on the d pin(s). This plusarg enables TX mode delays for
//                                       all metaflops regardless of the value of parameter TX_MODE.

        // Non Override Parameters
        parameter int      WIDTH=1,
        parameter int      MIN_PERIOD=0,
        parameter bit      SINGLE_BUS_META=0,
        parameter bit      PLUS1_ONLY=0,
        parameter bit      MINUS1_ONLY=0,

        // Override Parameters These have plusarg overrides
        parameter bit      METASTABILITY_EN=1,
        parameter bit      TX_MODE=0,
        parameter bit      PULSE_WIDTH_CHECK=0,  // Not currently used. Reserved for future use.

        // Enabling parameters - the corresponding plusarg must also exist for the behavior to occur
        parameter bit      ENABLE_3TO1=1
 )  (
    input  logic              setb,
    input  logic              clk,
    input  logic [WIDTH-1:0]  d,
    output logic [WIDTH-1:0]  o
 );

    localparam int RANK=3;
    logic [RANK-1:0] [WIDTH-1:0] sync;  // Basic sync cell elements

// Assign the last flop to the output
    assign o = sync[RANK-1];

// -----------------------------------------------------------------------------
//  Need to ensure that the model is not used for DC synth 
// -----------------------------------------------------------------------------
`ifdef INTEL_DC 
  "ERROR, do not use this file for DC"
`endif // INTEL_DC
// -----------------------------------------------------------------------------
//  Provide a basic physical veiw of the RTL if not in simulation, This should make it 
//  compatible with all other tools include FPGA synth, lintra and LEC 
// -----------------------------------------------------------------------------
`ifndef INTEL_SIMONLY 
    always_ff @(posedge clk or negedge setb)
        if (!setb) begin
            sync <= '1;
        end else begin
            sync <={sync[0 +:RANK-1], d};
        end
`else
    // Usage of defines to control synchronizer behavior is no longer supported. Generate an error message.
    `ifdef CTECH_LIB_META_ON
        initial begin
            "ERROR: CTECH_LIB_META_ON define is no longer supported. Metastability modeling is enabled by default and can be disabled with the runtime plusarg +CTECH_LIB_META_OFF."
        end
    `endif

    `ifdef CTECH_LIB_PULSE_ON
        initial begin
            "ERROR: use of CTECH_LIB_PULSE_ON define is no longer supported. Input pulse width checking will be supported in a future version."
        end
    `endif

    `ifdef CTECH_LIB_PLUS1_ONLY
        initial begin
            "ERROR: use of CTECH_LIB_PLUS1_ONLY define is no longer supported. Use runtime plusarg +CTECH_LIB_PLUS1_ONLY instead."
        end
    `endif

    `ifdef CTECH_LIB_MINUS1_ONLY
        initial begin
            "ERROR: use of CTECH_LIB_MINUS1_ONLY define is no longer supported. Use runtime plusarg +CTECH_LIB_MINUS1_ONLY instead."
        end
    `endif

    `ifdef CTECH_LIB_ENABLE_3TO1
        initial begin
            "ERROR: use of CTECH_LIB_ENABLE_3TO1 define is no longer supported. Use runtime plusarg +CTECH_LIB_ENABLE_3TO1 instead."
        end
    `endif

   `ifdef CTECH_LIB_TX_MODE
        initial begin
            "ERROR: use of CTECH_LIB_TX_MODE define is no longer supported. Use runtime plusarg +CTECH_LIB_TX_MODE instead."
        end
   `endif

    // Signals used to capture +args and final values for features
    bit display_metaflop_info; 
    bit ctech_lib_sync_info; 
    bit ctech_lib_meta_off;
    bit meta_disable;
    bit ctech_lib_check_on;
    bit pulse_width_check_disable;
    bit ctech_lib_plus1;
    bit plus1_only_mode;
    bit ctech_lib_minus1;
    bit minus1_only_mode;
    bit ctech_lib_3to1_on;
    bit three2one_disable;
    bit ctech_lib_tx_mode;
    bit tx_mode_on;

    logic [WIDTH-1:0]     dd_ff; // Delay flops used for +1 mode
    logic [WIDTH-1:0]     d_dly;
    logic [WIDTH-1:0]     tx_dff;
    logic [WIDTH-1:0]     last_d;
    bit   [(WIDTH*2)-1:0] past_delay={WIDTH{2'b10}}; 
    bit   [(WIDTH*2)-1:0] dly={WIDTH{2'b10}}; 

    // Task to work with the event scheduling effects of fork join_none with for_loop execution
    // Simple task that assigns a value after a delay 
    // Use the automatic to allow task to be re-entrant because it will be called for each bit at each change
    task automatic  assign_d_dly ( 
        input int   delay,
        input int   offset,
        input logic value );

        fork 
            begin 
                d_dly[offset] = #delay value;
            end
        join_none
    endtask

    // This is the primary initial block that launches / setups all the randomizaion RTL. 
    initial begin
        // Query for the plusargs
        display_metaflop_info     = $test$plusargs("CTECH_LIB_META_DISPLAY");
        ctech_lib_sync_info       = $test$plusargs("CTECH_LIB_SYNC_INFO");
        ctech_lib_meta_off        = $test$plusargs("CTECH_LIB_META_OFF");
        ctech_lib_check_on        = 0;
        ctech_lib_plus1           = $test$plusargs("CTECH_LIB_PLUS1_ONLY");
        ctech_lib_minus1          = $test$plusargs("CTECH_LIB_MINUS1_ONLY");
        ctech_lib_3to1_on         = $test$plusargs("CTECH_LIB_ENABLE_3TO1");
        ctech_lib_tx_mode         = $test$plusargs("CTECH_LIB_TX_MODE");

        // Check plusargs and parameters to determine if input pulse width checking or metastability modeling should be disabled
        // or if three-to-one delay modeling should be enabled.
        // Parameter default = 1 
        meta_disable              = !(!ctech_lib_meta_off && METASTABILITY_EN);
        pulse_width_check_disable = 0;
        three2one_disable         = ~(ctech_lib_3to1_on && ENABLE_3TO1);
      
        // Parameter default = 0 
        // The following two plusarg only features are mutually exclusive and should not be set at the same time. If they are, a runtime error occurs.
        plus1_only_mode           = PLUS1_ONLY  || (ctech_lib_plus1 && !MINUS1_ONLY);
        minus1_only_mode          = MINUS1_ONLY || (ctech_lib_minus1 && !PLUS1_ONLY);

        tx_mode_on                = ctech_lib_tx_mode || TX_MODE;
       

        // -----------------------------------------------------------------------------
        // Display metaflop instance info when plusarg CTECH_META_DISPLAY exists
        // -----------------------------------------------------------------------------
        #0;
        if (display_metaflop_info!=0) begin
            $display("CTECH_METAFLOP %0m: ctech_lib_triplesync_setb WIDTH=%0d, SINGLE_BUS_META=%0d, METASTABILITY_EN=(%0d/%0d/%0d), PULSE_WIDTH_CHECK=(%0d/%0d/%0d), MIN_PERIOD=%0dps, PLUS1_ONLY=(%0d/%0d/%0d), MINUS1_ONLY=(%0d/%0d/%0d), ENABLE_3TO1=(%0d/%0d/%0d), TX_MODE=(%0d/%0d/%0d),",WIDTH, SINGLE_BUS_META, METASTABILITY_EN, ~ctech_lib_meta_off, ~meta_disable, PULSE_WIDTH_CHECK, ctech_lib_check_on,  pulse_width_check_disable, MIN_PERIOD, 1'b0, ctech_lib_plus1, plus1_only_mode, 1'b0, ctech_lib_minus1,minus1_only_mode, ENABLE_3TO1,ctech_lib_3to1_on, ~three2one_disable, TX_MODE, ctech_lib_tx_mode, tx_mode_on);
        end

        if (ctech_lib_sync_info!=0) begin
            $display("CTECH_LIB_SYNC_INFO %0m%0s: ctech_lib_triplesync_setb %0s delay modeling is %0s. TX_MODE: %0s. MIN_PERIOD: %0t. SINGLE_BUS_META: %0s. CTECH_LIB_ENABLE_3TO1: %0s.",
                      (WIDTH==1)         ? "" : $sformatf("[ %0d:0]", WIDTH-1),
                      plus1_only_mode    ? "plus1_only random" : minus1_only_mode ? "minus1_only random" : "random",
                      meta_disable       ? "disabled" : "enabled",
                      tx_mode_on         ? "enabled" : "disabled",
                      MIN_PERIOD,
                      SINGLE_BUS_META    ? "enabled" : "disabled",
                      ctech_lib_3to1_on  ? "enabled" : "disabled"
            );
        end

        #0 d_dly = d; // initialize d_dly for the case where d never changes
        if (meta_disable) begin
            // -----------------------------------------------------------------------------
            // model for a triplesync flop without metastability modeling (two back-to-back flip flops)
            // In this mode just always move d to d_dly in case we are in delay mode and 
            // set delay for all bits to 2 for all other modes
            // -----------------------------------------------------------------------------
            for( int loop=0; loop < WIDTH; loop++)
                dly[loop*2+:2]= 2;
            fork
                forever begin
                    @(d) begin
                        d_dly = d ;
                    end
                end
            join_none
        end else begin
            // -----------------------------------------------------------------------------
            // SystemVerilog uses the same inital seed for each instance of every module in the system.
            // Create a unique seed for this module instance based on a hash of the initial seed and
            // the string containing the full hierarchical path of this instance.
            // -----------------------------------------------------------------------------
            int seed = $get_initial_random_seed();

            string inst;
            $sformat(inst,"%0m"); // get the full instance path
            for (int i=0; i<inst.len(); i++) begin
                int ch;
                ch = inst.getc(i);
                seed = 37*seed + ch;
            end

            // -----------------------------------------------------------------------------
            // Seed this initial block's random number generator with the new random, instance-based seed
            // -----------------------------------------------------------------------------
            //$display("%0m: ctech_triplesync_rst initial random number seed is %x", seed);
            $srandom(seed);
            // -----------------------------------------------------------------------------
            // The following code must be in this initial block.  If it is moved to an always
            // block, the random seed that was created won't be used and all instances of this
            // module will start with the same seed.
            // It is also required that the UPF file set the SNPS_reinit attribute as follows:
            //     set_design_attributes -attribute SNPS_reinit TRUE
            // This forces the simulator to re-execute initial blocks whenver power is applied.
            // -----------------------------------------------------------------------------

            if (MIN_PERIOD!=0) begin
                // -----------------------------------------------------------------------------
                // triplesync flop with random input delay modeling
                // -----------------------------------------------------------------------------
                int unsigned delay_clock_period;
                fork
                    if (SINGLE_BUS_META)
                        forever begin
                            @(d) begin
                                delay_clock_period = (MIN_PERIOD * $urandom_range(10,0)) / 10;
                                for( int l=0; l < WIDTH; l++) begin
                                    // -----------------------------------------------------------------------------
                                    // We use the fork join_none to keep from having the sync cell add all the delays together waiting for the blocking assignment
                                    // We have to use fix values after the blocking base on the current value of d.
                                    // We are using a task to contain the for join_none and "fix" the loop value within the task event.
                                    // -----------------------------------------------------------------------------
                                    assign_d_dly ( .delay(delay_clock_period),
                                                   .offset(l),
                                                   .value(d)
                                    ); 
                                end
                            end
                        end
                    else
                    // -----------------------------------------------------------------------------
                    // To avoid the re delay on d values that change the design will use the dd_ff to keep track fo the last
                    // Value of the d if it is not that same then randomly delay else just skip it. 
                    // -----------------------------------------------------------------------------
                        forever begin
                            @(d) begin
                                for( int l=0; l < WIDTH; l++) begin
                                    if (d[l] !== dd_ff[l] ) begin
                                        delay_clock_period = (MIN_PERIOD * $urandom_range(10,0)) / 10;
                                        // -----------------------------------------------------------------------------
                                        // We use the fork join_none to keep from having the sync cell add all the delays together waiting for the blocking assignment
                                        // We have to use fix values after the blocking base on the current value of d.
                                        // We are using a task to contain the for join_none and "fix" the loop value within the task event.
                                        // -----------------------------------------------------------------------------
                                        assign_d_dly ( .delay(delay_clock_period),
                                                       .offset(l),
                                                       .value(d[l])
                                        ); 
                                        dd_ff[l] = d[l];
                                    end 
                                end
                            end
                        end
                join_none

            end else begin
                // -----------------------------------------------------------------------------
                //   For non delay mode we need to randomize the dly value for each bit
                //   Each mode has a different method to do this randomization
                //   We choose the mode once and then launch a forever loop to maintain the values
                // -----------------------------------------------------------------------------
                fork
                    case({SINGLE_BUS_META, three2one_disable,plus1_only_mode, minus1_only_mode})
                        4'b1110,
                        4'b1111,
                        4'b1010,
                        4'b1011: begin // Single and only +1 (3->1 is NOP)
                                     if( minus1_only_mode ) $display("ERROR: %0m CTECH TRIPLESYNC - Both PLUS and MINUS modes are selected. Defaulting to plus only.") ;
                                     forever begin
                                         @(d) begin  // only update the random delay when the input data changes
                                             dly[1:0] = $urandom_range(3,2);
                                             // Assign the dly value to all flop > 1 if they exist the first bit is direcly assigned
                                             for( int loop=1; loop < WIDTH; loop++) begin
                                                 dly[loop*2+:2]= dly[1:0];
                                             end
                                         end
                                     end
                                 end

                        4'b1101,
                        4'b1001: begin // Single and only -1 (3->1 is NOP)
                                     forever begin
                                         @(d) begin  // only update the random delay when the input data changes
                                             dly[1:0] = $urandom_range(2,1);
                                             // Assign the dly value to all flop > 1 if they exist the first bit is direcly assigned
                                             for( int loop=1; loop < WIDTH; loop++) begin
                                               dly[loop*2+:2]= dly[1:0];
                                             end
                                         end
                                     end
                                 end

                        4'b1000: begin // Single and 3->1 is ok 
                                     forever begin
                                         @(d) begin  // only update the random delay when the input data changes
                                             dly = $urandom_range(3,1);
                                             // Assign the dly value to all flop > 1 if they exist the first bit is direcly assigned
                                             for( int loop=1; loop < WIDTH; loop++) begin
                                                 dly[loop*2+:2]= dly[1:0];
                                             end
                                         end
                                     end
                                 end

                        4'b1100: begin  // Single and no 3->1
                                     forever begin
                                         @(d) begin  // only update the random delay when the input data changes
                                             case(past_delay[1:0])
                                                 2'b01:   dly = $urandom_range(2,1);
                                                 2'b10:   dly = $urandom_range(3,1);
                                                 2'b11:   dly = $urandom_range(3,2);
                                                 default: dly = 2'b10;
                                             endcase
                                             // Assign the dly value to all flop > 1 if they exist the first bit is direcly assigned
                                             for( int loop=1; loop < WIDTH; loop++) begin
                                                 dly[loop*2+:2]= dly[1:0];
                                             end
                                         end
                                     end
                                 end

                        4'b0110,
                        4'b0111,
                        4'b0011,
                        4'b0010: begin // NOT Single and only +1  (3->1 is NOP)
                                     if(minus1_only_mode) $display( "ERROR: %0m CTECH TRIPLESYNC - Both PLUS and MINUS modes are selected. Defaulting to plus only.") ;
                                     forever begin
                                         @(d) begin  // only update the random delay when the input data changes
                                             // Could optimize to be bits based but need to handle greater then 32 bits
                                             for( int loop=0; loop < WIDTH; loop++) begin
                                                 dly[loop*2+:2] = $urandom_range(3,2);
                                             end
                                         end
                                     end
                                 end
                     
                        4'b0101,
                        4'b0001: begin // NOT Single and only +1 or -1 (3->1 is NOP)
                                     forever begin
                                         @(d) begin  // only update the random delay when the input data changes
                                             // Could optimize to be bits based but need to handle greater then 32 bits
                                             for( int loop=0; loop < WIDTH; loop++) begin
                                                 dly[loop*2+:2] = $urandom_range(2,1);
                                             end
                                         end
                                     end
                                 end

                        4'b0000: begin // NOT Single and 3->1 is ok 
                                     forever begin
                                         @(d) begin  // only update the random delay when the input data changes
                                             for( int loop=0; loop < WIDTH; loop++) begin
                                                 dly[(loop*2)+:2] = $urandom_range(3,1);
                                             end
                                         end
                                     end
                                 end

                        4'b0100: begin  // NOT Single and no 3->1
                                     forever begin
                                         @(d) begin  // only update the random delay when the input data changes
                                             for( int loop=0; loop < WIDTH; loop++) begin
                                                 // Look a pase_delay to find legal values
                                                 case(past_delay[(loop*2)+:2])
                                                     2'b01:   dly[(loop*2)+:2] = $urandom_range(2,1);
                                                     2'b10:   dly[(loop*2)+:2] = $urandom_range(3,1);
                                                     2'b11:   dly[(loop*2)+:2] = $urandom_range(3,2);
                                                     default: dly[(loop*2)+:2] = 2'b10;
                                                 endcase
                                             end
                                         end
                                     end
                                 end
                    endcase // End of Randomization calculations

                    forever begin
                        @(posedge clk or negedge setb) begin
                            past_delay<=dly;
                        end
                    end

                    // -----------------------------------------------------------------------------
                    // TX mode 
                    // -----------------------------------------------------------------------------
                    
                    // -----------------------------------------------------------------------------
                    // TX modes infers the tx clock from changes on the D line(s) 
                    // -----------------------------------------------------------------------------
                    if(tx_mode_on) begin
                        forever begin
                            @(d or posedge clk)  begin
                                if (d != last_d) begin // Assume we are here for d chagne if d != last_d
                                    last_d <= d; 
                                    tx_dff <= last_d; 
                                end
                                else begin
                                    last_d <= d; 
                                    tx_dff <= d; 
                                end
                            end 
                        end 
                    end else begin
                        forever begin
                            @(d) begin
                                tx_dff = d; 
                            end
                        end 
                    end
                join_none
            end // End Min period mode
        end // End Meta Disable
    end // end initial block


    // If the min_period parameter is set then we are using the delay mode which means we need to use the d_dly value as the input to the flop
    if(MIN_PERIOD != 0) 
        // 
        //
        //
        //       +-------+       +-------+     +----------+    
        // d +---+       | d_dly |       |     |          +----+ o
        //       | delay +-------| sync0 +-----|sync      |     
        //       |       |       |       |     |[RANK-1:1]|     
        //       +-------+       +-------+     +----------+     
        always_ff  @(posedge clk or negedge setb) begin
            if (!setb) begin
                {sync}<= '1;
            end else begin
                {sync}  <= {sync[0 +: RANK-1 ],d_dly};
            end
        end
    else
    
        // triplesync flp with random N-1/N/N+1 delay modeling
        // The flop that is modle base is : 
        // d                                                       
        // +-+-------------+------------------+                     
        //   |             |                  |                    
        //   |          1|2|  |\              |1 |\                
        //   |   +------+  +--+ |   +------+  +--+ |   +----------+    o
        //   +---+      |     | +---+      |     | +---+          +----+
        //       |dd_ff +-----+ |   |sync0 +---+-+ |   |sync      |     
        //       |      |   3 |/    |      |  3|2|/    |[RANK-1:1]|     
        //       +------+           +------+           +----------+     
        // The dly signal for plus1 and minus one modes only need to be single bit per sync 
        // The dly signal is encoded for three state mode. 
        //         0 is not used and not generated to avoid issue 
        //         1 - N-1 value 
        //         2 - N value 
        //         3 - N+1 value 
        //         When three2one_disable is true the randomizer ensures that illegal values are not generated
    
        //  Special case when WIDTH==1. We don't need the for loops and eliminate them to save execution time 
        if (WIDTH == 1)
            always_ff @(posedge clk or negedge setb) begin
                if (!setb)
                    {sync,dd_ff}<= '1;
                else
                    case(dly[1:0]) 
                        2'b01:   {sync[0 +: RANK],dd_ff}  <= { sync[1 +: RANK-2], d, d, d};
                        2'b10:   {sync[0 +: RANK],dd_ff}  <= { sync[0 +: RANK-1], d, d};
                        2'b11:   {sync[0 +: RANK],dd_ff}  <= { sync[0 +: RANK-1], tx_mode_on?tx_dff:dd_ff,   d};
                        default: {sync[0 +: RANK],dd_ff}  <= { sync[0 +: RANK-1], d, d};
                    endcase
            end
        else        
            // We use this code only when WIDTH>1. This is the same as above but within a loop (each bit delayed independently).
            always_ff @(posedge clk or negedge setb) begin
                if (!setb)
                    {sync,dd_ff}<= '1;
                else
                    for( int loop=0; loop < WIDTH; loop++) begin
                        case(dly[loop*2+:2]) 
                            2'b01:   {sync[1][loop],sync[0][loop],dd_ff[loop]}  <= { d[loop],       d[loop], d[loop]};
                            2'b10:   {sync[1][loop],sync[0][loop],dd_ff[loop]}  <= { sync[0][loop], d[loop], d[loop]};
                            2'b11:   {sync[1][loop],sync[0][loop],dd_ff[loop]}  <= { sync[0][loop],  tx_mode_on ? tx_dff[loop]:dd_ff[loop], d[loop]};
                            default: {sync[1][loop],sync[0][loop],dd_ff[loop]}  <= { sync[0][loop], d[loop], d[loop]};
                        endcase
                        for ( int rank_loop=1; rank_loop < RANK-1; rank_loop++) begin 
                            sync[rank_loop+1][loop] <= sync[rank_loop][loop];
                        end
                    end
            end
`endif // !INTEL_SIMONLY

endmodule // ctech_lib_triplesync_setb
// Clear INTEL_SIM only. We only set it because VCS was set.
`ifdef CLEAR_SIMONLY
    `undef INTEL_SIMONLY
    `undef CLEAR_SIMONLY
`endif // CLEAR_SIMONLY
//lintra pop

