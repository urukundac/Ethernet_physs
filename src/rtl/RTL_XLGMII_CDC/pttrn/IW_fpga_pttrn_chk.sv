//This module can be used to check an incoming pattern stream

module  IW_fpga_pttrn_chk  #(

    parameter PTTRN_CNTR_W         = 8     //Width of base counter
  , parameter LFSR_POLY            = 8'hb8 //Value of polynomial used to generate pseudo-random pattern
  , parameter PTTRN_DATA_W         = 32    //Total width of pttrn_data
  , parameter INFRA_AVST_CHNNL_W   = 8
  , parameter INFRA_AVST_DATA_W    = 8
  , parameter INFRA_AVST_CHNNL_ID  = 8

  , parameter CSR_ADDR_WIDTH       = 3*INFRA_AVST_DATA_W
  , parameter CSR_DATA_WIDTH       = 4*INFRA_AVST_DATA_W

  , parameter INSTANCE_NAME        = "u_pttrn_chk"  //Can hold upto 16 ASCII characters

 ) (

    input   wire                          clk
  , input   wire                          rst_n

  , input   wire  [PTTRN_DATA_W-1:0]      pttrn_data

  // Infra-Avst Ports
  , input                                 clk_avst
  , input                                 rst_avst_n
  , output                                avst_ingr_ready
  , input                                 avst_ingr_valid
  , input                                 avst_ingr_startofpacket
  , input                                 avst_ingr_endofpacket
  , input  [INFRA_AVST_CHNNL_W-1:0]       avst_ingr_channel
  , input  [INFRA_AVST_DATA_W-1:0]        avst_ingr_data

  , input                                 avst_egr_ready
  , output                                avst_egr_valid
  , output                                avst_egr_startofpacket
  , output                                avst_egr_endofpacket
  , output [INFRA_AVST_CHNNL_W-1:0]       avst_egr_channel
  , output [INFRA_AVST_DATA_W-1:0]        avst_egr_data

);

  /*  Internal  Parameters  */
  localparam  LFSR_WIDTH            = PTTRN_CNTR_W;
  localparam  LAST_SLICE_REMAINDER  = PTTRN_DATA_W  % PTTRN_CNTR_W;
  localparam  NUM_SLICES            = LAST_SLICE_REMAINDER  ? (PTTRN_DATA_W / PTTRN_CNTR_W) + 1
                                                            : (PTTRN_DATA_W / PTTRN_CNTR_W);

  /*  Internal  Functions */
  `include  "IW_fpga_pttrn_lfsr_gen.svh"

  /*  Internal Variables and Signals */
  genvar  i;
  integer n;
  reg  [0:15][7:0]          inst_name_str = INSTANCE_NAME;
  reg                       pttrn_chk_en;
  reg                       linear_pttrn_chk_en;
  reg   [PTTRN_CNTR_W-1:0]  pttrn_cntr;
  wire  [PTTRN_DATA_W-1:0]  pttrn_data_exp;
  wire                      pttrn_non_zero;
  reg                       wait_for_match;
  reg                       pttrn_match_pass;
  reg                       pttrn_match_fail;
  reg                       wait_for_match_sync;
  reg                       pttrn_match_pass_sync;
  reg                       pttrn_match_fail_sync;
  wire [7:0]                pttrn_cntr_width;
  wire [15:0]               pttrn_data_width;
  wire [31:0]               params_reg;

  wire                               csr_write;
  wire                               csr_read;
  wire [(3*INFRA_AVST_CHNNL_W)-1:0]  csr_addr;
  wire [(4*INFRA_AVST_DATA_W)-1:0]   csr_wr_data;
  reg  [(4*INFRA_AVST_DATA_W)-1:0]   csr_rd_data;
  reg                                csr_rd_valid;


/* AVST2CSR instance  */
IW_fpga_avst2csr #(
      .AVST_CHANNEL_ID      (INFRA_AVST_CHNNL_ID)
     ,.AVST_CHANNEL_WIDTH   (INFRA_AVST_CHNNL_W)
     ,.AVST_DATA_WIDTH      (INFRA_AVST_DATA_W)
     ,.CSR_ADDR_WIDTH       (CSR_ADDR_WIDTH)
     ,.CSR_DATA_WIDTH       (CSR_DATA_WIDTH)
     ,.CMD_WIDTH            (1*INFRA_AVST_DATA_W)
   ) avst2csr (
     .clk_avst              (clk_avst                )
    ,.rst_avst_n            (rst_avst_n              )
    ,.avst_ingr_ready       (avst_ingr_ready         )
    ,.avst_ingr_valid       (avst_ingr_valid         )
    ,.avst_ingr_sop         (avst_ingr_startofpacket )
    ,.avst_ingr_eop         (avst_ingr_endofpacket   )
    ,.avst_ingr_channel     (avst_ingr_channel       )
    ,.avst_ingr_data        (avst_ingr_data          )
    ,.avst_egr_ready        (avst_egr_ready          )
    ,.avst_egr_valid        (avst_egr_valid          )
    ,.avst_egr_sop          (avst_egr_startofpacket  )
    ,.avst_egr_eop          (avst_egr_endofpacket    )
    ,.avst_egr_channel      (avst_egr_channel        )
    ,.avst_egr_data         (avst_egr_data           )
    ,.clk_csr               (clk                     )
    ,.rst_csr_n             (rst_n                   )
    ,.csr_write             (csr_write               )
    ,.csr_read              (csr_read                )
    ,.csr_addr              (csr_addr                )
    ,.csr_wr_data           (csr_wr_data             )
    ,.csr_rd_data           (csr_rd_data             )
    ,.csr_rd_valid          (csr_rd_valid            )
   );

  // Assigning params to status reg
  assign pttrn_cntr_width = PTTRN_CNTR_W;
  assign pttrn_data_width = PTTRN_DATA_W; 
  assign params_reg       = {pttrn_cntr_width,LFSR_POLY,pttrn_data_width};

  /* CSR reg write logic */
  always@(posedge clk,  negedge rst_n)
  begin
    if(~rst_n)
    begin
      pttrn_chk_en            <=  0;
      linear_pttrn_chk_en     <=  0;
    end
    else
    begin
      /*  Write Logic */
      if(csr_write)
      begin
        case(csr_addr)
          16 : //Control register
          begin
            pttrn_chk_en      <=  csr_wr_data[0];
            linear_pttrn_chk_en <= csr_wr_data[1];
          end
        endcase
      end
    end
  end

  /* CSR reg read logic */
  always@(posedge clk,  negedge rst_n)
  begin
    if(~rst_n)
    begin
      csr_rd_valid         <=  0;
      csr_rd_data          <=  0;
    end
    else
    begin
      /*  Read data Logic */
      case(csr_addr)
        0 : /* Instance name Reg0 */
        begin
          for (n=0;n<4;n++)
          begin
            csr_rd_data[(n*8) +: 8] <=  inst_name_str[15-n];
          end
        end
        4 : /*  Instance name Reg1 */
        begin
          for (n=0;n<4;n++)
          begin
            csr_rd_data[(n*8) +: 8] <=  inst_name_str[15-4-n];
          end
        end
        8 : /*  Instance name Reg2 */
        begin
          for (n=0;n<4;n++)
          begin
            csr_rd_data[(n*8) +: 8] <=  inst_name_str[15-8-n];
          end
        end
        12 : /*  Instance name Reg3 */
        begin
          for (n=0;n<4;n++)
          begin
            csr_rd_data[(n*8) +: 8] <=  inst_name_str[15-12-n];
          end
        end
        16 : /*  Control Reg */
        begin
          csr_rd_data         <=  {{((4*INFRA_AVST_DATA_W)-2){1'b0}}, linear_pttrn_chk_en, pttrn_chk_en};
        end
        20 : /*  Status Reg */
        begin
          csr_rd_data         <=  {{((4*INFRA_AVST_DATA_W)-3){1'b0}},pttrn_match_fail,pttrn_match_pass,wait_for_match};
        end
        24 : /*  Params Reg */
        begin
          csr_rd_data         <=  params_reg;
        end
        default :
        begin
          csr_rd_data         <=  'hdeadbabe;
        end
      endcase
      /*  Read data valid Logic */
      if(csr_read)
      begin
        csr_rd_valid       <=  1'b1;
      end
      else
      begin
        csr_rd_valid       <=  1'b0;
      end
    end
  end

  /*
    * Counter Logic
    * This counter value is replicated across pttrn_data_exp
  */
  always@(posedge  clk,  negedge rst_n)
  begin
    if(~rst_n)
    begin
      pttrn_cntr              <=  0;
      wait_for_match          <=  1'b1;
      pttrn_match_pass        <=  0;
      pttrn_match_fail        <=  0;
    end
    else
    begin
      if(~pttrn_chk_en)
      begin
        pttrn_cntr            <=  0;
        wait_for_match        <=  1'b1;
        pttrn_match_pass      <=  0;
        pttrn_match_fail      <=  0;
      end
      else if(wait_for_match)
      begin
        wait_for_match        <=  pttrn_non_zero  ? 1'b0  : wait_for_match;

        if(linear_pttrn_chk_en)
          pttrn_cntr            <=  pttrn_data + 1;
        else
          pttrn_cntr            <=  gen_lfsr_nxt(.poly(LFSR_POLY),  .D(pttrn_data[LFSR_WIDTH-1:0]));
      end
      else
      begin
        pttrn_match_pass      <=  (pttrn_data ==  pttrn_data_exp) ? 1'b1  : pttrn_match_pass;
        pttrn_match_fail      <=  (pttrn_data !=  pttrn_data_exp) ? 1'b1  : pttrn_match_fail;
        if(linear_pttrn_chk_en)
          pttrn_cntr            <=  pttrn_cntr + 1;
        else
          pttrn_cntr            <=  gen_lfsr_nxt(.poly(LFSR_POLY),  .D(pttrn_cntr));
      end
    end
  end

  //Check for non-zero value of pattern
  assign  pttrn_non_zero  = (pttrn_data[LFSR_WIDTH-1:0] ==  0)  ? 1'b0  : 1'b1;

  //Replicate counter value in databus
  generate
    for(i=0;i<NUM_SLICES;i++)
    begin : gen_pttrn_data_exp
      if((i==NUM_SLICES-1)  &&  (LAST_SLICE_REMAINDER > 0))
      begin
        assign  pttrn_data_exp[(i*PTTRN_CNTR_W) +:  LAST_SLICE_REMAINDER]   = pttrn_cntr[LAST_SLICE_REMAINDER-1:0];
      end
      else
      begin
        assign  pttrn_data_exp[(i*PTTRN_CNTR_W) +:  PTTRN_CNTR_W] = pttrn_cntr;
      end
    end //gen_pttrn_data_exp
  endgenerate



endmodule //IW_fpga_pttrn_chk
