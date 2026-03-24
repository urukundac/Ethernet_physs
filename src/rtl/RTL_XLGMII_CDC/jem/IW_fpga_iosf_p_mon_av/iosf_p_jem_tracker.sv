//----------------------------------------------------------------------------------------------------------------------
// Tile              : idi_jem_tracker.sv
// Original Project  : Broxton
// Creation Date     : 2013/09/23
//----------------------------------------------------------------------------------------------------------------------
// Primary Contact   : Andrey Shapkin <andrey.shapkin@intel.com>
// Secondary Contact : Alexander Lyalin <alexander.lyalin@intel.com>
//----------------------------------------------------------------------------------------------------------------------
//
// Description:
//
//----------------------------------------------------------------------------------------------------------------------


// user header file
`include "iosf_p_jem_tracker.vh"
//`include "psf.svh"

// Jem tools header file, location is `ToolConfig.pl get_tool_path jem`
//`include "jem_tlm_ports.vh"

// JEM_TRACKER_DISABLE_ALL allows disabling jem tracker connectivity during elaboration time
// some funky models fail to elaborate jem trackers because of broken paths
//`ifdef JEM_STANDALONE
//parameter JEM_TRACKER_DISABLE_ALL = 0;
//`endif
//
//`ifndef JEM_STANDALONE
//    // auto-generated file, target/<dut>/aceroot/results/jemsw/include
////Not FOR ZEBU     `include "iosf_p_jem_tracker_tlm_dut.sv"
//`endif

// if more than on tracker instance is needed, the wrapper can be used
// see idi_jem_tracker for example
//module iosf_p_jem_tracker_wrapper();  //pragma attribute iosf_p_jem_tracker_wrapper partition_module_xrtl
//    // Global Enable   
//    bit enable;
//
//   `ifdef EMULATION
//      `ifndef JEM_STANDALONE
//           jemsw_en_ctrl jemsw_en_ctrl(enable);
//       `endif
//   `endif
//
//
//    // AUNIT has 3 cycles delta between gnt and cmd phases, need to delay gnt using this parameter
//    localparam IOSF_P_JEM_TRK_GNT_DELAY_4    = 4;
//    localparam IOSF_P_JEM_TRK_GNT_DELAY_3    = 3;
//    localparam IOSF_P_JEM_TRK_GNT_DELAY_2    = 2;
//    localparam IOSF_P_JEM_TRK_GNT_DELAY_1    = 1;
//   
//    localparam IOSF_P_JEM_TRK_D_512 = 512;
//    localparam IOSF_P_JEM_TRK_D_256 = 256;
//    localparam IOSF_P_JEM_TRK_D_128 = 128;
//    localparam IOSF_P_JEM_TRK_D_64  = 64;
//
//
//    `ifndef JEM_STANDALONE
//    //generate
//    //JFK: comment back out, see if it resolves "Task or function name ( JEM_TRACKER_DISABLE_ALL ) not defined." error
//    //if (JEM_TRACKER_DISABLE_ALL==0) begin
//
//        // PSF0 to A-unit
//        // (ep_name, psf_name, _dir, portid, data_width_dw, clk_name, reset_name, gnt_delay)
//        `IOSF_P_JEM_TRK_INST_GNT_DELAY(RLINK, PSF0, 1 ,`PSF0.pg0_fab_p0, IOSF_P_JEM_TRK_D_512, `PSF0.psf2_clk, `PSF0.psf2_rst_b, IOSF_P_JEM_TRK_GNT_DELAY_4)
//
//        // PSF0 to PSF1 link
//        `IOSF_P_JEM_TRK_INST(PSF1 ,PSF0 ,0 ,`PSF0.pg1_fab_p2	,IOSF_P_JEM_TRK_D_256   ,`PSF0.pg1_fab_p2_clk,`PSF1.psf2_rst_b)
//
//        // PSF1 to PSF2
//        `IOSF_P_JEM_TRK_INST(PSF2 ,PSF1 ,0 ,`PSF1.pg1_fab_p3	,IOSF_P_JEM_TRK_D_128   ,`PSF1.pg1_fab_p3_clk,`PSF1.psf2_rst_b)
//
//	// PSF1 to PSFS
//        `IOSF_P_JEM_TRK_INST(PSF9 ,PSF1 ,0 ,`PSF1.pg1_fab_p0	,IOSF_P_JEM_TRK_D_256   ,`PSF1.pg1_fab_p3_clk,`PSF1.psf2_rst_b)
//
//	//PSFS to PSFSATA0,1,2
//        `IOSF_P_JEM_TRK_INST(PSF6 ,PSF9 ,0 ,`PSF9.pg1_fab_p0	,IOSF_P_JEM_TRK_D_128   ,`PSF9.pg1_fab_p0_clk,`PSF9.psf2_rst_b)
//	`IOSF_P_JEM_TRK_INST(PSF7 ,PSF9 ,0 ,`PSF9.pg1_fab_p1	,IOSF_P_JEM_TRK_D_128   ,`PSF9.pg1_fab_p1_clk,`PSF9.psf2_rst_b)
//	`IOSF_P_JEM_TRK_INST(PSF8 ,PSF9 ,0 ,`PSF9.pg1_fab_p2	,IOSF_P_JEM_TRK_D_128   ,`PSF9.pg1_fab_p2_clk,`PSF1.psf2_rst_b)
//
//        
//        // PSF2 to PSF3
//        `IOSF_P_JEM_TRK_INST(PSF3 ,PSF2 ,0 ,`PSF2.pg1_fab_p5	,IOSF_P_JEM_TRK_D_64   ,`PSF2.pg1_fab_p5_clk,`PSF2.psf2_rst_b)   
//
//        // PSF2 to PSFME
//        `IOSF_P_JEM_TRK_INST(CSME ,PSF2 ,0 ,`PSF2.pg1_fab_p3      ,IOSF_P_JEM_TRK_D_64   ,`PSF2.pg1_fab_p3_clk,`PSF2.psf2_rst_b)
//
//        // PSF2 to PSFIE
//        `IOSF_P_JEM_TRK_INST(IE ,PSF2 ,0 ,`PSF2.pg1_fab_p4      ,IOSF_P_JEM_TRK_D_64   ,`PSF2.pg1_fab_p4_clk,`PSF2.psf2_rst_b)
//
//
//    //end
//    //endgenerate
//
//    `else // JEM_STANDALONE
//        // FAKE instance - otherwise jem does not see the module
//        iosf_p_jem_tracker iosf_p_jem_tracker();
//    `endif // JEM_STANDALONE
//endmodule


module iosf_p_jem_tracker(
    input enable,
    input dir,
    input clk,
    input resetb,
    input req_cdata,
    input [3:0] req_chid,
    input [4:0] req_dlen,
    input req_locked,
    input req_put,
    input [1:0] req_rtype,
    input [3:0] req_tc,
    input [1:0] cmd_mfmt,
    input [4:0] cmd_mtype,
    input [3:0] cmd_mtc,
    input [9:0] cmd_mlength,
    input [15:0] cmd_mreqid,
    input [7:0] cmd_mtag,
    input [3:0] cmd_mlbe,
    input [3:0] cmd_mfbe,
    input [63:0] cmd_maddr, // cmd address - fix to 64-bits 
    input [15:0] cmd_msrcid,
    input [15:0] cmd_mdestid,
    input [511:0] mdata, // keep this at 256-bits for now. when instantiating, add extra 0's to make 128-bit data
    input [7:0] mdata_width, // pass in actual width of data in DWORDS (256bits == 8 dwords, set this to 3'h8
    input cmd_mrs,
    input cmd_mep,
    input cmd_mido,
    input cmd_mns,
    input cmd_mro,
    input [7:0] cmd_msai,
    input cmd_tput,
    input [3:0] cmd_tchid,
    input [1:0] cmd_trtype,
    input [1:0] cmd_tfmt,
    input [4:0] cmd_ttype,
    input [3:0] cmd_ttc,
    input [9:0] cmd_tlength,
    input [15:0] cmd_treqid,
    input [7:0] cmd_ttag,
    input [3:0] cmd_tlbe,
    input [3:0] cmd_tfbe,
    input [63:0] cmd_taddr, 
    input [15:0] cmd_tsrcid,
    input [15:0] cmd_tdestid,
    input [511:0] tdata, // keep this at 256-bits for now. when instantiating, add extra 0's to make 128-bit data
    input [7:0] tdata_width, // pass in actual width of data in DWORDS (256bits == 8 dwords, set this to 3'h8
    input cmd_trs,
    input cmd_tep,
    input cmd_tido,
    input cmd_tns,
    input cmd_tro,
    input [7:0] cmd_tsai,
    input gnt,
    input [3:0] gnt_chid,
    input [1:0] gnt_rtype,
    input [1:0] gnt_type,


    output t_iosf_p_jem_mreq     data_mreq,
    output logic                 data_mreq_valid,

    output t_iosf_p_jem_treq     data_treq,
    output logic                 data_treq_valid,

    output t_iosf_p_jem_mdata    data_mdata,
    output logic                 data_mdata_valid,

    output t_iosf_p_jem_tdata    data_tdata,
    output logic                 data_tdata_valid

); //pragma attribute iosf_p_jem_tracker partition_module_xrtl

// it looks like A-unit isn't spec compliant, it sends cmd only 3 clocks after gnt is seen
// need to delay gnt* signals to capture cmd correctly
// by default delay is 1 cycle, that is gnt is directly observed and cmd is sent next cycle after gnt goes high
// if we get more non-compliant EPs, this would be a way to control
parameter GNT_DELAY 		= 0;

// This parameter is the logb2 of the dword-length of the master data
// ex: if mdata is 128-bits (4 dwords), then set this to 2 (2^2 = 4).
localparam MDATA_WIDTH_DW = 16; 
localparam TDATA_WIDTH_DW = 16; 

typedef enum logic {IDLE, WDATA} t_wsm;

t_wsm MSTR_WDATA_ps, MSTR_WDATA_ns;
t_wsm TGT_WDATA_ps, TGT_WDATA_ns;

reg gnt_delay [6];
reg [3:0] gnt_chid_delay[6];
reg [1:0] gnt_rtype_delay[6];
reg [1:0] gnt_type_delay[6];

assign gnt_delay[0]         = gnt;
assign gnt_chid_delay[0]    = gnt_chid;
assign gnt_rtype_delay[0]   = gnt_rtype;
assign gnt_type_delay[0]    = gnt_type;

genvar i;
generate
for (i=0;i<5;i = i+1) begin : generate_gnt_delay
    always @(posedge clk) begin
        gnt_delay       [i+1] <= gnt_delay       [i];
        gnt_chid_delay  [i+1] <= gnt_chid_delay  [i];
        gnt_rtype_delay [i+1] <= gnt_rtype_delay [i];
        gnt_type_delay  [i+1] <= gnt_type_delay  [i];
    end
end
endgenerate

bit[3:0] tracker_id = 0;
reg cmd_mvalid;
wire dpi_clk;
wire cmd_mvalid_nxt;
wire [9:0] cmd_mlength_m1;
wire data_mvalid;
//reg enable;
wire [9:0] mwdata_count_nxt;
reg  [9:0] mwdata_count;
wire [9:0] mwdata_length_nxt;
reg  [9:0] mwdata_length;
wire data_tvalid;
wire [9:0] cmd_tlength_m1;
wire [9:0] twdata_count_nxt;
reg  [9:0] twdata_count;
wire [9:0] twdata_length_nxt;
reg  [9:0] twdata_length;
wire dpi_valid;
reg  [1:0] gnt_rtype_f;
wire [1:0] gnt_rtype_nxt;
reg  [3:0] gnt_chid_f;
wire [3:0] gnt_chid_nxt;
reg  [12:0] mdata_id;
wire [12:0] mdata_id_nxt;
wire mdata_last;
reg  [12:0] tdata_id;
wire [12:0] tdata_id_nxt;
wire tdata_last;
wire [7:0] mdata_width_m1;
wire [7:0] tdata_width_m1;
reg  [7:0] mstr_reqid;
wire [7:0] mstr_reqid_nxt;
reg  [7:0] tgt_reqid;
wire [7:0] tgt_reqid_nxt;



always_comb
begin
  case(MSTR_WDATA_ps)
  IDLE:
    if((cmd_mvalid == 1'b1) && (cmd_mfmt[1] == 1'b1))
      MSTR_WDATA_ns <= WDATA;
    else
      MSTR_WDATA_ns <= IDLE;
  WDATA:
    if(((cmd_mvalid == 1'b1) && (cmd_mfmt[1] == 1'b1)) || (mwdata_count < mwdata_length))
      MSTR_WDATA_ns <= WDATA;
    else  
      MSTR_WDATA_ns <= IDLE;
  endcase
end


// cmd is valid if gnt is received and gnt type is transaction.
assign cmd_mvalid_nxt = ((gnt_delay[GNT_DELAY] == 1'b1) && (gnt_type_delay[GNT_DELAY] == 2'b00)) ? 1'b1 : 1'b0;
// mwdata_count: start counting the data the clock after the command is sent
assign mdata_width_m1 = mdata_width - 1;
assign mwdata_count_nxt = ((cmd_mvalid == 1'b1) && (cmd_mfmt[1] == 1'b1)) ? {2'b00,mdata_width_m1} : (MSTR_WDATA_ps == WDATA ? mwdata_count+mdata_width : mwdata_count);
// mwdata_length: capture the data length if the transaction will send data  
//                This will be one more than the max count that mwdata_count will count to.  
assign cmd_mlength_m1 = cmd_mlength - 1;  
assign mwdata_length_nxt = ((cmd_mvalid == 1'b1) && (cmd_mfmt[1] == 1'b1)) ? cmd_mlength_m1[9:0] : mwdata_length; 
assign gnt_rtype_nxt = (gnt_delay[GNT_DELAY] == 1'b1) ? gnt_rtype_delay[GNT_DELAY] : gnt_rtype_f;
assign gnt_chid_nxt = (gnt_delay[GNT_DELAY] == 1'b1) ? gnt_chid_delay[GNT_DELAY] : gnt_chid_f; 
assign mdata_id_nxt = ((cmd_mvalid == 1'b1) && (cmd_mfmt[1] == 1'b1)) ? {tracker_id[3:0],1'b1,mstr_reqid[7:0]} : mdata_id;
assign mdata_last = ((MSTR_WDATA_ps == WDATA) && (!(mwdata_count < mwdata_length))) ? 1'b1: 1'b0;
assign mstr_reqid_nxt = (cmd_mvalid_nxt == 1'b1) ? mstr_reqid + 1'b1 : mstr_reqid;

//sbtalli - clock counter to get simulation time
//          doesn't look like TBX supports svGetTimeFromScope(svGetScope())

// master interface state machines 
// - cmd_mvalid: tracks when a cmd is valid
// - MSTR_WDATA_ps: tracks state of write data being sent
// - mwdata_count: counts data packets sent for a master command
// - mwdata_length: saves the length of the data being sent for a command
always @(posedge clk or negedge resetb) begin
  if(resetb == 1'b0) 
    begin
      cmd_mvalid <= '0;
      MSTR_WDATA_ps <= IDLE;
      mwdata_count <= '0;
      mwdata_length <= '0;
      mdata_id <= '0;
      mstr_reqid <= '0;      
    end
  else
    begin
      cmd_mvalid <= cmd_mvalid_nxt;
      gnt_rtype_f <= gnt_rtype_nxt;
      gnt_chid_f <= gnt_chid_nxt; 
      MSTR_WDATA_ps <= MSTR_WDATA_ns; 
      mwdata_count <= mwdata_count_nxt;
      mwdata_length <= mwdata_length_nxt;
      mdata_id <= mdata_id_nxt;
      mstr_reqid <= mstr_reqid_nxt;
    end
end

assign data_mvalid = (MSTR_WDATA_ps == WDATA) ? 1'b1 : 1'b0;

always_comb
begin
  case(TGT_WDATA_ps)
  IDLE:
    if((cmd_tput == 1'b1) && (cmd_tfmt[1] == 1'b1))
      TGT_WDATA_ns <= WDATA;
    else
      TGT_WDATA_ns <= IDLE;
  WDATA:
    if(((cmd_tput == 1'b1) && (cmd_tfmt[1] == 1'b1)) || (twdata_count < twdata_length))
      TGT_WDATA_ns <= WDATA;
    else  
      TGT_WDATA_ns <= IDLE;
  endcase
end

// twdata_count: start counting the data the clock after the command is sent
assign tdata_width_m1 = tdata_width - 1;
assign twdata_count_nxt = ((cmd_tput == 1'b1) && (cmd_tfmt[1] == 1'b1)) ? {2'b00,tdata_width_m1} : (TGT_WDATA_ps == WDATA ? twdata_count+tdata_width : twdata_count);
// twdata_length: capture the data length if the transaction will send data  
//                This will be one more than the max count that twdata_count will
//                count to.  
assign cmd_tlength_m1 = cmd_tlength - 1;  
assign twdata_length_nxt = ((cmd_tput == 1'b1) && (cmd_tfmt[1] == 1'b1)) ? cmd_tlength_m1[9:0] : twdata_length; 
assign tdata_id_nxt = ((cmd_tput == 1'b1) && (cmd_tfmt[1] == 1'b1)) ? {tracker_id[3:0],1'b0,tgt_reqid[7:0]} : tdata_id;
assign tdata_last = ((TGT_WDATA_ps == WDATA) && (!(twdata_count < twdata_length))) ? 1'b1 : 1'b0;
assign tgt_reqid_nxt = (cmd_tput == 1'b1) ? tgt_reqid + 1'b1 : tgt_reqid;

assign data_tvalid = (TGT_WDATA_ps == WDATA) ? 1'b1 : 1'b0;  

always @(posedge clk or negedge resetb) 
begin
  if(resetb == 1'b0)
    begin 
      TGT_WDATA_ps <= IDLE;
      twdata_length <= '0;
      twdata_count <= '0;
      tgt_reqid <= '0;
    end
  else
    begin
      TGT_WDATA_ps <= TGT_WDATA_ns;
      twdata_length <= twdata_length_nxt;
      twdata_count <= twdata_count_nxt;
      tdata_id <= tdata_id_nxt;
      tgt_reqid <= tgt_reqid_nxt;       
    end
end


   t_iosf_p_jem_mreq input_iosf_p_jem_mreq;
   //`JEM_ANALYSIS_PORT(input_iosf_p_jem_mreq_tracker, t_iosf_p_jem_mreq);

   t_iosf_p_jem_treq input_iosf_p_jem_treq;
   //`JEM_ANALYSIS_PORT(input_iosf_p_jem_treq_tracker, t_iosf_p_jem_treq);

   t_iosf_p_jem_mdata input_iosf_p_jem_mdata;
   //`JEM_ANALYSIS_PORT(input_iosf_p_jem_mdata_tracker, t_iosf_p_jem_mdata);

   t_iosf_p_jem_tdata input_iosf_p_jem_tdata;
   //`JEM_ANALYSIS_PORT(input_iosf_p_jem_tdata_tracker, t_iosf_p_jem_tdata);

   assign input_iosf_p_jem_mreq.dir                 = dir;
   assign input_iosf_p_jem_mreq.cmd_mfmt            = cmd_mfmt;
   assign input_iosf_p_jem_mreq.cmd_mtype           = cmd_mtype;
   assign input_iosf_p_jem_mreq.cmd_mtc             = cmd_mtc;
   assign input_iosf_p_jem_mreq.cmd_mlength         = cmd_mlength;
   assign input_iosf_p_jem_mreq.cmd_mreqid          = cmd_mreqid;
   assign input_iosf_p_jem_mreq.cmd_mtag            = cmd_mtag;
   assign input_iosf_p_jem_mreq.cmd_mlbe            = cmd_mlbe;
   assign input_iosf_p_jem_mreq.cmd_mfbe            = cmd_mfbe;
   assign input_iosf_p_jem_mreq.cmd_maddr           = cmd_maddr;
   assign input_iosf_p_jem_mreq.cmd_msrcid          = cmd_msrcid;
   assign input_iosf_p_jem_mreq.cmd_mdestid         = cmd_mdestid;
   assign input_iosf_p_jem_mreq.gnt_rtype           = gnt_rtype_f;
   assign input_iosf_p_jem_mreq.gnt_chid            = gnt_chid_f;
   assign input_iosf_p_jem_mreq.mstr_reqid          = mstr_reqid;
   assign input_iosf_p_jem_mreq.cmd_mrs             = cmd_mrs;
   assign input_iosf_p_jem_mreq.cmd_mep             = cmd_mep;
   assign input_iosf_p_jem_mreq.cmd_mido            = cmd_mido;
   assign input_iosf_p_jem_mreq.cmd_mns             = cmd_mns;
   assign input_iosf_p_jem_mreq.cmd_mro             = cmd_mro;
   assign input_iosf_p_jem_mreq.cmd_msai            = cmd_msai;



   assign input_iosf_p_jem_treq.dir                 = dir;
   assign input_iosf_p_jem_treq.cmd_tput            = cmd_tput;
   assign input_iosf_p_jem_treq.cmd_tchid           = cmd_tchid;
   assign input_iosf_p_jem_treq.cmd_trtype          = cmd_trtype;
   assign input_iosf_p_jem_treq.cmd_tfmt            = cmd_tfmt;
   assign input_iosf_p_jem_treq.cmd_ttype           = cmd_ttype;
   assign input_iosf_p_jem_treq.cmd_ttc             = cmd_ttc;
   assign input_iosf_p_jem_treq.cmd_tlength         = cmd_tlength;
   assign input_iosf_p_jem_treq.cmd_treqid          = cmd_treqid;
   assign input_iosf_p_jem_treq.cmd_ttag            = cmd_ttag;
   assign input_iosf_p_jem_treq.cmd_tlbe            = cmd_tlbe;
   assign input_iosf_p_jem_treq.cmd_tfbe            = cmd_tfbe;
   assign input_iosf_p_jem_treq.cmd_taddr           = cmd_taddr;
   assign input_iosf_p_jem_treq.cmd_tsrcid          = cmd_tsrcid;
   assign input_iosf_p_jem_treq.cmd_tdestid         = cmd_tdestid;
   assign input_iosf_p_jem_treq.tgt_reqid           = tgt_reqid;
   assign input_iosf_p_jem_treq.cmd_trs             = cmd_trs;
   assign input_iosf_p_jem_treq.cmd_tep             = cmd_tep;
   assign input_iosf_p_jem_treq.cmd_tido            = cmd_tido;
   assign input_iosf_p_jem_treq.cmd_tns             = cmd_tns;
   assign input_iosf_p_jem_treq.cmd_tro             = cmd_tro;
   assign input_iosf_p_jem_treq.cmd_tsai            = cmd_tsai;


   assign input_iosf_p_jem_mdata.dir                = dir;
   assign input_iosf_p_jem_mdata.mdata              = mdata;
   assign input_iosf_p_jem_mdata.data_mvalid        = data_mvalid;
   assign input_iosf_p_jem_mdata.mdata_width        = mdata_width;
   assign input_iosf_p_jem_mdata.mdata_last         = mdata_last;
   assign input_iosf_p_jem_mdata.mdata_id           = mdata_id;

   assign input_iosf_p_jem_tdata.dir                = dir;
   assign input_iosf_p_jem_tdata.tdata              = tdata;
   assign input_iosf_p_jem_tdata.data_tvalid        = data_tvalid;
   assign input_iosf_p_jem_tdata.tdata_width        = tdata_width;
   assign input_iosf_p_jem_tdata.tdata_last         = tdata_last;
   assign input_iosf_p_jem_tdata.tdata_id           = tdata_id;

   always @(posedge clk) begin
      if (enable && cmd_mvalid) begin
         //`JEM_PORT_WRITE(input_iosf_p_jem_mreq_tracker, input_iosf_p_jem_mreq);
         data_mreq <= input_iosf_p_jem_mreq;
         data_mreq_valid <= 1'b1;
      end
      else begin
         data_mreq <= data_mreq;
         data_mreq_valid <= 1'b0;
      end
   end
      
   always @(posedge clk) begin
      if (enable && cmd_tput) begin
         //`JEM_PORT_WRITE(input_iosf_p_jem_treq_tracker, input_iosf_p_jem_treq);
         data_treq <= input_iosf_p_jem_treq;
         data_treq_valid <= 1'b1;
      end
      else begin
         data_treq <= data_treq;
         data_treq_valid <= 1'b0;
      end
   end
      
   always @(posedge clk) begin
      if (enable && data_mvalid) begin
         //`JEM_PORT_WRITE(input_iosf_p_jem_mdata_tracker, input_iosf_p_jem_mdata);
         data_mdata <= input_iosf_p_jem_mdata;
         data_mdata_valid <= 1'b1;
      end
      else begin
         data_mdata <= data_mdata;
         data_mdata_valid <= 1'b0;
      end
   end
      
   always @(posedge clk) begin
      if (enable && data_tvalid) begin
         //`JEM_PORT_WRITE(input_iosf_p_jem_tdata_tracker, input_iosf_p_jem_tdata);
         data_tdata <= input_iosf_p_jem_tdata;
         data_tdata_valid <= 1'b1;
      end
      else begin
         data_tdata <= data_tdata;
         data_tdata_valid <= 1'b0;
      end
   end
      
endmodule



// if more than on tracker instance is needed, the wrapper can be used
// see idi_jem_tracker for example
//module cse_psf_tracker_wrapper();  //pragma attribute cse_jem_tracker_wrapper partition_module_xrtl
//    // Global Enable   
//    bit enable = 1;
//
//   `ifdef EMULATION
//      `ifndef JEM_STANDALONE
//           jemsw_en_ctrl jemsw_en_ctrl(enable);
//       `endif
//   `endif
//
//    // AUNIT has 3 cycles delta between gnt and cmd phases, need to delay gnt using this parameter
//    //localparam IOSF_P_JEM_TRK_PSF0_A_GNT_DELAY    = 2;
//    //localparam IOSF_P_JEM_TRK_PSF3_CSE_GNT_DELAY    = 1;
//
//    `ifndef JEM_STANDALONE
//    //generate
//
//        //`define CSE_PSF cse_pg.psf0
//        
//        // CSE PSF to CSE GSK
//       // `CSE_PSF_SOUTH_TRACKER(CSE_GSK, CSE_PSF, 0, cse_pg.psf0, 64, prim_clk, prim_rst_b, 1, 0)
//        
//        // CSE PSF to CSE OCS
//       // `CSE_PSF_SOUTH_TRACKER(CSE_OCS, CSE_PSF, 0, cse_pg.psf0, 64, prim_clk, prim_rst_b, 1, 1)
//
//        // CSE PSF to CSE AUNIT
//       // `CSE_PSF_NORTH_TRACKER(CSE_AUNIT, CSE_PSF, 0, cse_pg.psf0, 64, prim_clk, prim_rst_b, 1)
//        
//    //endgenerate
//
//    `else // JEM_STANDALONE
//        // FAKE instance - otherwise jem does not see the module
//        iosf_p_jem_tracker cse_iosf_p_jem_tracker();
//    `endif // JEM_STANDALONE
//endmodule
