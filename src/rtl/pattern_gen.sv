module pattern_gen (
    input logic clk,
    input logic reset_n,
    input logic [9:0] rx_tbi,  // Assuming rx_tbi is a 10-bit signal
    output logic transition_detected
);

    // Define the values to detect
    localparam logic [9:0] VALUE_42 = 10'h042;
    localparam logic [9:0] VALUE_1BC = 10'h1BC;

    // Register to hold the previous value of rx_tbi
    logic [9:0] prev_rx_tbi;

    // Sequential logic to update prev_rx_tbi
    always_ff @(posedge clk or posedge reset_n) begin
        if (reset_n) begin
            prev_rx_tbi <= 10'b0;
            transition_detected <= 0;
        end else begin
            // Check for transition from 42 to 1BC
            if (prev_rx_tbi == VALUE_42 && rx_tbi == VALUE_1BC) begin
                transition_detected <= 1;
            end else begin
                transition_detected <= 0;
            end

            // Update previous value
            prev_rx_tbi <= rx_tbi;
        end
    end

endmodule
