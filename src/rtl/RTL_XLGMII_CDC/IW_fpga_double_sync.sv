module IW_fpga_double_sync  #(
   parameter  WIDTH       = 1
  ,parameter  NUM_STAGES  = 2
) (
  input   logic             clk,
  input   logic [WIDTH-1:0] sig_in,
  output  logic [WIDTH-1:0] sig_out
);

  logic [WIDTH-1:0] sync_pipe [NUM_STAGES-1:0] = '{default: 1'b0};
  genvar  i;

  generate
    for(i=0;  i<NUM_STAGES; i++)
    begin : gen_sync_pipe
      if(i==0)
      begin
        always_ff @ (posedge clk)
        begin
          sync_pipe[i] <=  sig_in;
        end
      end
      else
      begin
        always_ff @ (posedge clk)
        begin
          sync_pipe[i] <=  sync_pipe[i-1];
        end
      end
    end //gen_sync_pipe
  endgenerate

  assign  sig_out = sync_pipe[NUM_STAGES-1];
endmodule //IW_fpga_double_sync
