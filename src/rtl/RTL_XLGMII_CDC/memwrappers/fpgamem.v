module fpgamem #(parameter ADDR_WD = 4,
                 parameter DATA_WD = 8,
                 parameter FPGA_BACKDOOR_ENABLE = 0,
                 parameter WR_RD_SIMULT_DATA = 0
) (
  input                     ckwr,
  input                     ckrd,
  input                     wr,
  input  [ADDR_WD-1 : 0]    wrptr,
  input  [DATA_WD-1 : 0]    datain,
  input                     rd,
  input  [ADDR_WD-1 : 0]    rdptr,
  output [DATA_WD-1 : 0]    dataout
);

reg  [DATA_WD-1 : 0]  newdata;
reg                   newv;
reg  [DATA_WD-1 : 0]  dataoutw;

`ifndef FPGA_ALTERA_RAM // Only the RTL mem model is used.
  reg [DATA_WD-1 : 0] ram[0:(2**ADDR_WD)-1]/*synthesis syn_ramstyle="block_ram"*/;
  logic [ADDR_WD-1 : 0] rdptr_int;
  logic [ADDR_WD-1 : 0] wrptr_int;
  logic [DATA_WD-1 : 0] datain_int;
  logic wr_int;
  logic rd_int;
  
  always @(posedge ckwr ) begin
    if ( wr_int )
      ram[wrptr_int] <= datain_int;
  end
  
  always @(posedge ckrd ) begin
    if ( rd_int )
      dataoutw <= ram[rdptr_int];
  end
  
  generate  
    if ( FPGA_BACKDOOR_ENABLE == 1 ) begin : gen_backdoor_en
      logic               bd_fpgamem_muxsel;
      logic [ADDR_WD-1:0] bd_fpgamem_write_addr;
      logic [ADDR_WD-1:0] bd_fpgamem_read_addr;
      logic [DATA_WD-1:0] bd_fpgamem_write_data;
      logic               bd_fpgamem_read_en;
      logic               bd_fpgamem_write_en;
      logic [DATA_WD-1:0] bd_fpgamem_read_data;
    
      //Mux logic
      assign wrptr_int   = bd_fpgamem_muxsel ? bd_fpgamem_write_addr : wrptr;
      assign rdptr_int   = bd_fpgamem_muxsel ? bd_fpgamem_read_addr  : rdptr;
      assign datain_int  = bd_fpgamem_muxsel ? bd_fpgamem_write_data : datain;
      assign rd_int      = bd_fpgamem_muxsel ? bd_fpgamem_read_en    : rd;
      assign wr_int      = bd_fpgamem_muxsel ? bd_fpgamem_write_en   : wr;
      assign bd_fpgamem_read_data = dataoutw;
    end 
    else begin : gen_backdoor_disable
      assign wrptr_int  =  wrptr;
      assign rdptr_int  =  rdptr;
      assign datain_int =  datain;
      assign rd_int     =  rd;
      assign wr_int     =  wr;
    end
  endgenerate

`else
  altsyncram     altsyncram_component0 (
                 .address_a (wrptr),
                 .clock0 (ckwr),
                 .data_a ( datain ),
                 .wren_a ( wr ),
                 .rden_a (1'b0 ),
                 .q_a ( ),
                 .aclr0 (1'b0),
                 .aclr1 (1'b0),
                 .address_b (rdptr),
                 .addressstall_a (1'b0),
                 .addressstall_b (1'b0),
                 .byteena_a (1'b1),
                 .byteena_b (1'b1),
                 .clock1 (ckrd),
                 .clocken0 (1'b1),
                 .clocken1 (1'b1),
                 .clocken2 (1'b1),
                 .clocken3 (1'b1),
                 .data_b ({DATA_WD{1'b1}}),
                 .eccstatus (),
                 .q_b (dataoutw),
                 .rden_b (rd),
                 .wren_b (1'b0));
  defparam
    altsyncram_component0.intended_device_family = "Stratix V",
    altsyncram_component0.lpm_hint = "ENABLE_RUNTIME_MOD=NO",
    altsyncram_component0.lpm_type = "altsyncram",
    altsyncram_component0.operation_mode = "DUAL_PORT",
    altsyncram_component0.power_up_uninitialized = "FALSE",
    altsyncram_component0.clock_enable_input_a = "NORMAL",
    altsyncram_component0.clock_enable_output_a = "NORMAL",
    altsyncram_component0.numwords_a = 2**ADDR_WD,
    altsyncram_component0.outdata_aclr_a = "NONE",
    altsyncram_component0.outdata_reg_a = "UNREGISTERED",
    altsyncram_component0.read_during_write_mode_port_a = "DONT_CARE",
    altsyncram_component0.widthad_a = ADDR_WD,
    altsyncram_component0.width_a = DATA_WD,
    altsyncram_component0.width_byteena_a = 1,

    altsyncram_component0.clock_enable_input_b = "NORMAL",
    altsyncram_component0.clock_enable_output_b = "NORMAL",
    altsyncram_component0.numwords_b = 2**ADDR_WD,
    altsyncram_component0.outdata_aclr_b = "NONE",
    altsyncram_component0.outdata_reg_b = "UNREGISTERED",
    altsyncram_component0.read_during_write_mode_port_b = "DONT_CARE",
    altsyncram_component0.widthad_b = ADDR_WD,
    altsyncram_component0.width_b = DATA_WD,
    altsyncram_component0.width_byteena_b = 1;

`endif

// Logic to supply newdata to the rddata out when simultaneous rd/wr happens on the same addr
// Should work for inverted rd/wr clock also.
// Will not work for asynchronous wr and rd clk. Please disable this param that time
always @(posedge ckrd ) begin
  if ( rd & wr) begin
    newv      <= (wrptr == rdptr);
    newdata   <= datain;
  end
  else begin
    newv      <= 1'b0;
  end
end

generate 
  if ( WR_RD_SIMULT_DATA == 1 )
    assign dataout = newv  ? newdata : dataoutw;
  else
    assign dataout = dataoutw;
endgenerate

endmodule
//--------------------------------------------------------------------------------
// Modification History
// Date       Name of      Description
//            Engineer
//--------------------------------------------------------------------------------
// 12-Mar-'19 Vikas        To enable inference of BRAM, dataout is assigned
//                         value under posedge block, insted of using
//                         registered read address to read under assign
//                         statement
// 04-Jun-'19 Vikas        Changed to non-blocking assignment
// 30-Jul-'24 Sachin       Formatted; added back door initialization support
