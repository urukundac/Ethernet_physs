`include "iosf_sb_jem_tracker.vh"

module iosf_sb_jem_tracker
#(
    parameter WIDTH           = 8,
    parameter BUFFER_SIZE     = 160,
    parameter OUTPUT_FLOP_EN  = 0
)
(
    input                                  enable,
    input                                  side_clk,
    input                                  side_rst_b,
    input                                  put_np,
    input                                  put_p,
    input  [31 : 0]                        payload,
    input                                  eom,
    input                                  direction,
    output logic                           data_valid,
    output t_iosf_sb_jem_req               data
);

    localparam BUFFER_SIZE_B = (BUFFER_SIZE>>3);

    reg [BUFFER_SIZE - 1:0] data_pc;
    reg [BUFFER_SIZE - 1:0] data_np;
    reg [15:0] cnt_pc;
    reg [15:0] cnt_np;

    reg send_dpi_pc;
    reg send_dpi_np;
    reg [15:0] send_dpi_cnt_pc;
    reg [15:0] send_dpi_cnt_np;
    reg send_dpi_eom_pc;
    reg send_dpi_eom_np;
    reg send_dpi_start_pc_s1;
    reg send_dpi_start_np_s1;
    reg send_dpi_direction;
    // this logic makes data for 16b width EPs looking like 8b EP (stream of byte), otherwise SW has to swap data depending on whether it's 8b or 16b EP
    wire [WIDTH-1:0] tpayload_sw;

    generate
      if (WIDTH==32) begin
         assign tpayload_sw = {payload[7:0],payload[15:8],payload[23:16],payload[31:24]};
      end
      else if (WIDTH==16) begin
         assign tpayload_sw = {payload[7:0],payload[15:8]};
      end
      else begin
         assign tpayload_sw = {8'b0,payload[7:0]};
      end
    endgenerate


    // Collect data for each of the channels, send it out whenever buffer gets full or EOM is received
    always @ (posedge side_clk) begin
        if (~side_rst_b) begin
            data_pc <= 0;
            data_np <= 0;
            cnt_pc <= 0;
            cnt_np <= 0;
            send_dpi_pc <= 0;
            send_dpi_np <= 0;
            send_dpi_cnt_pc <= 0;
            send_dpi_cnt_np <= 0;
            // initial value of 1 is required to tell correctly start of first packet
            send_dpi_eom_pc <= 1;
            send_dpi_eom_np <= 1;
            send_dpi_start_pc_s1 <= 1;
            send_dpi_start_np_s1 <= 1;
            send_dpi_direction <= direction;
        end
        else begin

            // for each of the channels - grab data and shift it into payload buffer
            // if EOM is set or payload buffer is full, send the data via DPI call
            if (put_p) begin
                if (cnt_pc==0) begin
                    data_pc <= {'0,tpayload_sw};
                end else begin
                    data_pc <= {data_pc,tpayload_sw};
                end

                if (eom || (cnt_pc==(BUFFER_SIZE_B - (WIDTH/8)))) begin
                    // fire a trigger to send DPI next cycle
                    cnt_pc <= 0;
                    send_dpi_pc <= 1;
                    send_dpi_cnt_pc <= cnt_pc + (WIDTH/8);
                    send_dpi_eom_pc <= eom;
                    send_dpi_start_pc_s1 <= send_dpi_eom_pc;
                end else begin
                    cnt_pc <= cnt_pc + (WIDTH/8);
                    send_dpi_pc <= 0;
                end
            end
            else begin
                send_dpi_pc <= 0;
            end

            // for each of the channels - grab data and shift it into payload buffer
            // if EOM is set or payload buffer is full, send the data via DPI call
            if (put_np) begin
                if (cnt_np==0) begin
                    data_np <= {'0,tpayload_sw};
                end else begin
                    data_np <= {data_np,tpayload_sw};
                end

                if (eom || (cnt_np==(BUFFER_SIZE_B - (WIDTH/8)))) begin
                    // fire a trigger to send DPI next cycle
                    cnt_np <= 0;
                    send_dpi_np <= 1;
                    send_dpi_cnt_np <= cnt_np + (WIDTH/8);
                    send_dpi_eom_np <= eom;
                    send_dpi_start_np_s1 <= send_dpi_eom_np;
                end else begin
                    cnt_np <= cnt_np + (WIDTH/8);
                    send_dpi_np <= 0;
                end
            end
            else begin
                send_dpi_np <= 0;
            end
        end
    end

    // MUX between PC and NP, it's good to have a single DPI call to avoid racing DPI calls problem
    logic send_dpi_eom;
    logic send_dpi_start;
    logic [BUFFER_SIZE -1:0] send_dpi_data;
    logic [15:0] send_dpi_cnt;
    logic send_dpi_posted;

    always_comb begin
        if ( send_dpi_pc ) begin
            send_dpi_eom    = send_dpi_eom_pc;
            send_dpi_start  = send_dpi_start_pc_s1;
            send_dpi_data   = data_pc;
            send_dpi_cnt    = send_dpi_cnt_pc;
            send_dpi_posted = 1;
        end
        else if (send_dpi_np) begin
            send_dpi_eom    = send_dpi_eom_np;
            send_dpi_start  = send_dpi_start_np_s1;
            send_dpi_data   = data_np;
            send_dpi_cnt    = send_dpi_cnt_np;
            send_dpi_posted = 0;
        end
        else begin
            send_dpi_eom  = 0;
            send_dpi_start = 0;
            send_dpi_data = 0;
            send_dpi_cnt  = 0;
            send_dpi_posted = 0;
        end
    end

    t_iosf_sb_jem_req req;
    //`JEM_ANALYSIS_PORT(input_iosf_sb_jem_req_tracker, t_iosf_sb_jem_req);

    assign req.posted    = send_dpi_posted;
    assign req.eom       = send_dpi_eom;
    assign req.start     = send_dpi_start;
    assign req.cnt       = send_dpi_cnt;
    assign req.data      = send_dpi_data;
    assign req.direction = send_dpi_direction;

    generate
      if(OUTPUT_FLOP_EN ==  1)
      begin
        always @(posedge side_clk) begin
            if ( enable && (send_dpi_pc || send_dpi_np) ) begin
                //`JEM_PORT_WRITE(input_iosf_sb_jem_req_tracker, req);
                data  <= req;
                data_valid <= 1'b1;
            end
            else begin
                data  <= data;
                data_valid <= 1'b0;
            end
        end
      end
      else
      begin
        assign  data        = req;
        assign  data_valid  = enable  & (send_dpi_pc  | send_dpi_np);
      end
    endgenerate

endmodule


