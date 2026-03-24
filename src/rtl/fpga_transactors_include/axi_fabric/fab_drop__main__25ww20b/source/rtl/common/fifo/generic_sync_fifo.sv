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

/*
 --------------------------------------------------------------------------
 -- Project Code      : axi_fabric
 -- Module Name       : generic_sync_fifo
 -- Author            : Gregory James
 -- Associated modules: 
 -- Function          : This module implements a parameterizable Synchronous
                        Lookahead(FWFT) FIFO.
 --------------------------------------------------------------------------
*/

`timescale 1ns / 10ps


module generic_sync_fifo #(
//----------------------- Global parameters Declarations ------------------
   parameter          WRITE_WIDTH   = 8
  ,parameter          READ_WIDTH    = 16
  ,parameter          NUM_BITS      = 8*32

  ,parameter          SWAP_WORD_ORDER = 1 //This parameter (when enabled) will swap the order of writing/reading the FIFO
                                          //from Altera's beviour which is lower word first. This is to keep the behaviour
                                          //the same as Xilinx which is most significant word first.
                                          //Only valid when WRITE_WIDTH != READ_WIDTH of course.

  ,parameter  string  MEM_TYPE          = "BRAM"  //supported values are BRAM & REG
  ,parameter          AFULL_THRESHOLD   = 1
  ,parameter          AEMPTY_THRESHOLD  = 1

) (
//----------------------- Clock/Reset ------------------------------
   input  clk
  ,input  rst_n

//----------------------- Write Signals ------------------------------
  ,input  wr_en
  ,input  wr_data
  ,output full
  ,output afull

//----------------------- Read Signals  ------------------------------
  ,input  rd_en
  ,output rd_data
  ,output empty
  ,output aempty

//----------------------- Misc Signals  ------------------------------
  ,output wr_occupancy
  ,output rd_occupancy
  ,output wr_overflow
  ,output rd_underflow

);

//----------------------- Import Packages ---------------------------------


//----------------------- Internal Parameters -----------------------------
  localparam  WRITE_IS_MIN        = (WRITE_WIDTH  < READ_WIDTH) ? 1 : 0;
  localparam  WIDTH_RATIO         = WRITE_IS_MIN  ? (READ_WIDTH / WRITE_WIDTH)  : (WRITE_WIDTH  / READ_WIDTH);

  localparam  WRITE_NUM_WORDS     = NUM_BITS  / WRITE_WIDTH;
  localparam  AFULL_NUM_WORDS     = AFULL_THRESHOLD / WRITE_WIDTH;
  localparam  WRITE_ADDR_WIDTH    = $clog2(WRITE_NUM_WORDS);
  localparam  WRITE_ADDR_INC_VAL  = WRITE_IS_MIN  ? 1 : WIDTH_RATIO;

  localparam  READ_NUM_WORDS      = NUM_BITS  / READ_WIDTH;
  localparam  AEMPTY_NUM_WORDS    = AEMPTY_THRESHOLD  / READ_WIDTH;
  localparam  READ_ADDR_WIDTH     = $clog2(READ_NUM_WORDS);
  localparam  READ_ADDR_INC_VAL   = WRITE_IS_MIN  ? WIDTH_RATIO : 1;

  localparam  MEM_ADDR_W          = WRITE_IS_MIN  ? WRITE_ADDR_WIDTH  : READ_ADDR_WIDTH;
  localparam  MEM_DEPTH           = WRITE_IS_MIN  ? WRITE_NUM_WORDS   : READ_NUM_WORDS;
  localparam  MEM_RD_DELAY        = 1;

  localparam  NUM_SYNC_STAGES     = MEM_RD_DELAY;
  localparam  MAX_PENDING_READS   = 1;
  localparam  PENDING_READ_CNTR_W = (MAX_PENDING_READS < 2) ? 2 : $clog2(MAX_PENDING_READS) + 1;

//----------------------- Port Dimensions ---------------------------------
  logic                         clk;
  logic                         rst_n;

  logic                         wr_en;
  logic [WRITE_WIDTH-1:0]       wr_data;
  logic                         full;
  logic                         afull;

  logic                         rd_en;
  logic [READ_WIDTH-1:0]        rd_data;
  logic                         empty;
  logic                         aempty;

  logic [WRITE_ADDR_WIDTH:0]    wr_occupancy;
  logic [READ_ADDR_WIDTH:0]     rd_occupancy;
  logic                         wr_overflow;
  logic                         rd_underflow;


//----------------------- Internal Register Declarations ------------------
  reg   [MEM_ADDR_W-1:0]        wraddr_mem;
  logic [MEM_ADDR_W-1:0]        rdaddr_mem;
  reg   [MEM_RD_DELAY-1:0]      mem_rd_data_valid_pipe;
  logic                         mem_empty;
  logic                         mem_empty_next;
  logic                         empty_next;

  reg   [MEM_ADDR_W:0]          wr_occupancy_mem;
  reg   [MEM_ADDR_W:0]          rd_occupancy_mem;

//----------------------- Internal Wire Declarations ----------------------
  wire  [WRITE_WIDTH-1:0]       wr_data_formatted;
  wire  [READ_WIDTH-1:0]        rd_data_formatted;

  wire  [WRITE_ADDR_WIDTH-1:0]  wraddr_mem_final;
  wire  [READ_ADDR_WIDTH-1:0]   rdaddr_mem_final;

  logic [MEM_ADDR_W:0]          wr_occupancy_mem_next;
  wire  [MEM_ADDR_W:0]          rd_occupancy_mem_next;

  wire                          mem_rd_data_valid;

  wire                          mem_wr_en;
  wire                          wrptr_inc;
  wire  [MEM_ADDR_W:0]          wraddr_bin;
  wire  [MEM_ADDR_W:0]          wraddr_bin_next;
  wire  [MEM_ADDR_W:0]          wraddr_bin_wadj;
  wire  [MEM_ADDR_W:0]          wraddr_bin_wadj_next;
  wire  [MEM_ADDR_W-1:0]        wraddr_mem_next;
  wire  [MEM_ADDR_W:0]          wrptr;
  wire  [MEM_ADDR_W:0]          wrptr_next;
  wire  [MEM_ADDR_W:0]          wrptr_wadj;
  wire  [MEM_ADDR_W:0]          wrptr_wadj_next;
  wire  [MEM_ADDR_W:0]          wrptr_sync;
  wire  [MEM_ADDR_W:0]          wraddr_sync;
  wire  [MEM_ADDR_W-1:0]        wraddr_sync_mem;
  wire                          full_next;

  wire                          rdptr_inc;
  wire  [MEM_ADDR_W:0]          rdaddr_bin;
  wire  [MEM_ADDR_W:0]          rdaddr_bin_next;
  wire  [MEM_ADDR_W:0]          rdaddr_bin_wadj;
  wire  [MEM_ADDR_W:0]          rdaddr_bin_wadj_next;
  wire  [MEM_ADDR_W-1:0]        rdaddr_mem_next;
  wire  [MEM_ADDR_W:0]          rdptr;
  wire  [MEM_ADDR_W:0]          rdptr_next;
  wire  [MEM_ADDR_W:0]          rdptr_wadj;
  wire  [MEM_ADDR_W:0]          rdptr_wadj_next;
  wire  [MEM_ADDR_W:0]          rdptr_sync;
  wire  [MEM_ADDR_W:0]          rdaddr_sync;
  wire  [MEM_ADDR_W-1:0]        rdaddr_sync_mem;

  wire  [READ_WIDTH-1:0]        rd_data_int;

  genvar  i;

//----------------------- Start of Code -----------------------------------

  /*  Check Parameters  */
  generate
    localparam  MEM_DEPTH_LOG   = $clog2(MEM_DEPTH);
    localparam  MEM_DEPTH_UNLOG = 2**MEM_DEPTH_LOG;

    if(MEM_DEPTH_UNLOG  !=  MEM_DEPTH)
    begin
      unsupported_depth   depth_is_not_power_of_2 ();
    end


    if(WIDTH_RATIO  !=  1)
    begin
      localparam  WIDTH_RATIO_LOG   = $clog2(WIDTH_RATIO);
      localparam  WIDTH_RATIO_UNLOG = 2**WIDTH_RATIO_LOG;

      if(WIDTH_RATIO_UNLOG  !=  WIDTH_RATIO)
      begin
        unsupported_width_ratio   width_ratio_not_power_of_2();
      end
    end


    if(MEM_DEPTH  < 8)
    begin
      unsupported_depth   depth_should_be_at_least_8 ();
    end
  endgenerate

  /*  Format the data based on SWAP_WORD_ORDER  */
  generate
    if(SWAP_WORD_ORDER && (WIDTH_RATIO > 1))
    begin
      if(WRITE_WIDTH  > READ_WIDTH)
      begin
        assign  rd_data_int = rd_data_formatted;

        for(i=0;  i<WIDTH_RATIO; i=i+1)
        begin : gen_data_format
          assign  wr_data_formatted[(i*READ_WIDTH) +:  READ_WIDTH] = wr_data[(WRITE_WIDTH - (i*READ_WIDTH) -1)  -:  READ_WIDTH];
        end
      end
      else  //READ_WIDTH  > WRITE_WIDTH
      begin
        assign  wr_data_formatted  = wr_data;

        for(i=0;  i<WIDTH_RATIO; i=i+1)
        begin : gen_q_format
          assign  rd_data_int[(i*WRITE_WIDTH) +:  WRITE_WIDTH] = rd_data_formatted[(READ_WIDTH - (i*WRITE_WIDTH) -1)  -:  WRITE_WIDTH];
        end
      end
    end
    else  //~SWAP_WORD_ORDER
    begin
      assign  wr_data_formatted  = wr_data;
      assign  rd_data_int        = rd_data_formatted;
    end
  endgenerate

  /*  Instantiate Memory  */
  generate
    if(WIDTH_RATIO  ==  1)
    begin
      generic_simple_dual_port_ram #(
         .DATA_WIDTH    (WRITE_WIDTH)
        ,.ADDR_WIDTH    (MEM_ADDR_W)
        ,.MEM_TYPE      (MEM_TYPE)

      ) u_mem (

         .wr_clk        (clk)
        ,.wr_data       (wr_data_formatted)
        ,.wr_addr       (wraddr_mem_final)
        ,.wr_en         (mem_wr_en)

        ,.rd_clk        (clk)
        ,.rd_addr       (rdaddr_mem_final)
        ,.rd_data       (rd_data_formatted)

      );

      assign  wraddr_mem_final = wraddr_mem;
      assign  rdaddr_mem_final = rdaddr_mem;
    end
    else  //WIDTH_RATIO !=  1
    begin
      generic_simple_dual_port_mixed_width_ram  #(
         .WRITE_WIDTH   (WRITE_WIDTH)
        ,.READ_WIDTH    (READ_WIDTH)
        ,.NUM_BITS      (NUM_BITS)
        ,.MEM_TYPE      (MEM_TYPE)

      ) u_mem (

         .wr_clk        (clk)
        ,.wr_data       (wr_data_formatted)
        ,.wr_addr       (wraddr_mem_final)
        ,.wr_en         (mem_wr_en)

        ,.rd_clk        (clk)
        ,.rd_addr       (rdaddr_mem_final)
        ,.rd_data       (rd_data_formatted)

      );

      if(WRITE_IS_MIN)
      begin
        assign  wraddr_mem_final = wraddr_mem;
      end
      else
      begin
        assign  wraddr_mem_final = wraddr_mem[MEM_ADDR_W-1:$clog2(WIDTH_RATIO)];
      end

      if(!WRITE_IS_MIN)
      begin
        assign  rdaddr_mem_final = rdaddr_mem;
      end
      else
      begin
        assign  rdaddr_mem_final = rdaddr_mem[MEM_ADDR_W-1:$clog2(WIDTH_RATIO)];
      end
    end
  endgenerate


  /*  Instantiate Pointers  */
  generic_async_fifo_ptr#(
     .WIDTH             (MEM_ADDR_W+1)
    ,.INC_VAL           (WRITE_ADDR_INC_VAL)
    ,.WIDTH_RATIO       (WIDTH_RATIO)
  )  u_wrptr  (
     .clk               (clk)
    ,.rst_n             (rst_n)
    ,.inc               (wrptr_inc)
    ,.bin_ptr           (wraddr_bin)
    ,.bin_ptr_next      (wraddr_bin_next)
    ,.bin_ptr_wadj      (wraddr_bin_wadj)
    ,.bin_ptr_wadj_next (wraddr_bin_wadj_next)
    ,.gry_ptr           (wrptr)
    ,.gry_ptr_next      (wrptr_next)
    ,.gry_ptr_wadj      (wrptr_wadj)
    ,.gry_ptr_wadj_next (wrptr_wadj_next)
  );

  generic_async_fifo_ptr#(
     .WIDTH             (MEM_ADDR_W+1)
    ,.INC_VAL           (READ_ADDR_INC_VAL)
    ,.WIDTH_RATIO       (WIDTH_RATIO)
  )   u_rdptr (
     .clk               (clk)
    ,.rst_n             (rst_n)
    ,.inc               (rdptr_inc)
    ,.bin_ptr           (rdaddr_bin)
    ,.bin_ptr_next      (rdaddr_bin_next)
    ,.bin_ptr_wadj      (rdaddr_bin_wadj)
    ,.bin_ptr_wadj_next (rdaddr_bin_wadj_next)
    ,.gry_ptr           (rdptr)
    ,.gry_ptr_next      (rdptr_next)
    ,.gry_ptr_wadj      (rdptr_wadj)
    ,.gry_ptr_wadj_next (rdptr_wadj_next)
   );

  /*  Synchronize read/write pointers to the opposite clock domain */
  generate
    if(WIDTH_RATIO  ==  1)
    begin
      generic_dd_sync#(.WIDTH(MEM_ADDR_W+1),.NUM_STAGES(NUM_SYNC_STAGES),.USE_RESET(1),.RESET_VAL({(MEM_ADDR_W+1){1'b0}}))  u_wrptr_sync (.clk(clk),.rst_n(rst_n),.in(wrptr),.out(wrptr_sync));

      generic_dd_sync#(.WIDTH(MEM_ADDR_W+1),.NUM_STAGES(NUM_SYNC_STAGES),.USE_RESET(1),.RESET_VAL({(MEM_ADDR_W+1){1'b0}}))  u_rdptr_sync (.clk(clk),.rst_n(rst_n),.in(rdptr),.out(rdptr_sync));
    end
    else if(WRITE_IS_MIN)
    begin
      generic_dd_sync#(.WIDTH(MEM_ADDR_W+1),.NUM_STAGES(NUM_SYNC_STAGES),.USE_RESET(1),.RESET_VAL({(MEM_ADDR_W+1){1'b0}}))  u_wrptr_sync (.clk(clk),.rst_n(rst_n),.in(wrptr_wadj),.out(wrptr_sync));

      generic_dd_sync#(.WIDTH(MEM_ADDR_W+1),.NUM_STAGES(NUM_SYNC_STAGES),.USE_RESET(1),.RESET_VAL({(MEM_ADDR_W+1){1'b0}}))  u_rdptr_sync (.clk(clk),.rst_n(rst_n),.in(rdptr),.out(rdptr_sync));
    end
    else  //!WRITE_IS_MIN
    begin
      generic_dd_sync#(.WIDTH(MEM_ADDR_W+1),.NUM_STAGES(NUM_SYNC_STAGES),.USE_RESET(1),.RESET_VAL({(MEM_ADDR_W+1){1'b0}}))  u_wrptr_sync (.clk(clk),.rst_n(rst_n),.in(wrptr),.out(wrptr_sync));

      generic_dd_sync#(.WIDTH(MEM_ADDR_W+1),.NUM_STAGES(NUM_SYNC_STAGES),.USE_RESET(1),.RESET_VAL({(MEM_ADDR_W+1){1'b0}}))  u_rdptr_sync (.clk(clk),.rst_n(rst_n),.in(rdptr_wadj),.out(rdptr_sync));
    end
  endgenerate

  /*  Convert synced pointers from gray to binary */
  generate
    for(i=MEM_ADDR_W;i>=0;i--)
    begin : gen_wraddr_sync
      if(i==MEM_ADDR_W)
      begin
        assign  wraddr_sync[i]  = wrptr_sync[i];
      end
      else
      begin
        assign  wraddr_sync[i]  = wrptr_sync[i] ^ wraddr_sync[i+1];
      end
    end

    for(i=MEM_ADDR_W;i>=0;i--)
    begin : gen_rdaddr_sync
      if(i==MEM_ADDR_W)
      begin
        assign  rdaddr_sync[i]  = rdptr_sync[i];
      end
      else
      begin
        assign  rdaddr_sync[i]  = rdptr_sync[i] ^ rdaddr_sync[i+1];
      end
    end
  endgenerate


  //----------------------------------------------------------
  //  Write Logic
  //----------------------------------------------------------

  assign  wrptr_inc = wr_en & ~full; //protect FIFO from overflow

  always@(posedge clk, negedge rst_n)
  begin
    if(~rst_n)
    begin
      wraddr_mem          <=  {MEM_ADDR_W{1'b0}};

      full                <=  1'b0;
      afull               <=  1'b0;
      wr_occupancy_mem    <=  {(MEM_ADDR_W+1){1'b0}};
      wr_overflow         <=  1'b0;
    end
    else
    begin
      wraddr_mem          <=  wraddr_mem_next;

      wr_overflow         <=  wr_overflow | (wr_en  & full);

      full                <=  full_next;
      afull               <=  full_next | ((wr_occupancy_mem_next >= AFULL_NUM_WORDS) ? 1'b1 : 1'b0);

      if(full_next)
      begin
        wr_occupancy_mem  <=  MEM_DEPTH;
      end
      else
      begin
        wr_occupancy_mem  <=  wr_occupancy_mem_next;
      end
    end
  end

  //assign  wr_occupancy_mem_next = (wraddr_mem_next > rdaddr_sync_mem) ? wraddr_mem_next - rdaddr_sync_mem : MEM_DEPTH - (rdaddr_sync_mem - wraddr_mem_next);

  always_comb
  begin
    case({wraddr_bin_next[MEM_ADDR_W],rdaddr_sync[MEM_ADDR_W]})

      2'b00,2'b11 :
      begin
        wr_occupancy_mem_next = wraddr_bin_next - rdaddr_sync;
      end

      2'b10,2'b01 :
      begin
        wr_occupancy_mem_next = MEM_DEPTH - (rdaddr_sync[MEM_ADDR_W-1:0] - wraddr_bin_next[MEM_ADDR_W-1:0]);
      end

    endcase
  end

  assign  full_next       = (wrptr_next ==  {~rdptr_sync[MEM_ADDR_W:MEM_ADDR_W-1],rdptr_sync[MEM_ADDR_W-2:0]})  ? 1'b1  : 1'b0;

  //assign  wraddr_mem_next = {^wraddr_bin_next[MEM_ADDR_W:MEM_ADDR_W-1],wraddr_bin_next[MEM_ADDR_W-2:0]};
  assign  wraddr_mem_next = wraddr_bin_next[MEM_ADDR_W-1:0];

  //assign  rdaddr_sync_mem = {^rdaddr_sync[MEM_ADDR_W:MEM_ADDR_W-1],rdaddr_sync[MEM_ADDR_W-2:0]};
  assign  rdaddr_sync_mem = rdaddr_sync[MEM_ADDR_W-1:0];

  assign  mem_wr_en = wr_en & ~full;


  //----------------------------------------------------------
  //  Read Logic
  //----------------------------------------------------------

  assign  rdptr_inc = ~mem_empty & rd_en;

  generate
    if(MEM_RD_DELAY > 1)
    begin
      always@(posedge clk, negedge rst_n)
      begin
        if(~rst_n)
        begin
          mem_rd_data_valid_pipe   <=  {MEM_RD_DELAY{1'b0}};
        end
        else
        begin
          mem_rd_data_valid_pipe   <=  {mem_rd_data_valid_pipe[MEM_RD_DELAY-2:0],rdptr_inc};
        end
      end
    end
    else  //MEM_RD_DELAY  == 1
    begin
      always@(posedge clk, negedge rst_n)
      begin
        if(~rst_n)
        begin
          mem_rd_data_valid_pipe   <=  {MEM_RD_DELAY{1'b0}};
        end
        else
        begin
          mem_rd_data_valid_pipe   <=  rdptr_inc;
        end
      end
    end
  endgenerate

  assign  mem_rd_data_valid = mem_rd_data_valid_pipe[MEM_RD_DELAY-1];


  always@(posedge clk, negedge rst_n)
  begin
    if(~rst_n)
    begin
      mem_empty           <=  1'b1;

      empty               <=  1'b1;
      aempty              <=  1'b1;
      rd_occupancy_mem    <=  {(MEM_ADDR_W+1){1'b0}};
      rd_underflow        <=  1'b0;
    end
    else
    begin
      rd_underflow        <=  rd_underflow  | (rd_en  & empty);

      mem_empty           <=  mem_empty_next;
      empty               <=  empty_next;

      if(empty_next)
      begin
        aempty            <=  1'b1;
      end
      else
      begin
        aempty            <=  (rd_occupancy_mem_next <= AEMPTY_NUM_WORDS) ? 1'b1 : 1'b0;
      end

      if(empty_next)
      begin
        rd_occupancy_mem  <=  {(MEM_ADDR_W+1){1'b0}};
      end
      else
      begin
        rd_occupancy_mem  <=  rd_occupancy_mem_next;
      end
    end
  end

  always_comb
  begin
    if(mem_empty)
    begin
      mem_empty_next  =  (rdptr_next !=  wrptr_sync) ? 1'b0  : mem_empty;
    end
    else
    begin
      mem_empty_next  =  (rdptr_next ==  wrptr_sync) ? 1'b1  : mem_empty;
    end
  end

  assign  empty_next = mem_empty_next;

  assign  rd_data = rd_data_int;

  assign  rd_occupancy_mem_next = (wraddr_sync_mem >= rdaddr_mem_next)  ? wraddr_sync_mem - rdaddr_mem_next : MEM_DEPTH - (rdaddr_mem_next - wraddr_sync_mem);

  //assign  rdaddr_mem_next = {^rdaddr_bin_next[MEM_ADDR_W:MEM_ADDR_W-1],rdaddr_bin_next[MEM_ADDR_W-2:0]};
  assign  rdaddr_mem_next = rdaddr_bin_next[MEM_ADDR_W-1:0];
  assign  rdaddr_mem      = rdaddr_mem_next;

  //assign  wraddr_sync_mem = {^wraddr_sync[MEM_ADDR_W:MEM_ADDR_W-1],wraddr_sync[MEM_ADDR_W-2:0]};
  assign  wraddr_sync_mem = wraddr_sync[MEM_ADDR_W-1:0];



  //----------------------------------------------------------
  //  Expose Occupancies
  //----------------------------------------------------------
  generate
    if(WIDTH_RATIO  ==  1)
    begin
      assign  wr_occupancy  = wr_occupancy_mem;
      assign  rd_occupancy  = rd_occupancy_mem;
    end
    else
    begin
      if(WRITE_IS_MIN)
      begin
        assign  wr_occupancy  = wr_occupancy_mem;
        assign  rd_occupancy  = rd_occupancy_mem[MEM_ADDR_W:$clog2(WIDTH_RATIO)];
      end
      else
      begin
        assign  wr_occupancy  = wr_occupancy_mem[MEM_ADDR_W:$clog2(WIDTH_RATIO)];
        assign  rd_occupancy  = rd_occupancy_mem;
      end
    end
  endgenerate


endmodule // generic_sync_fifo
