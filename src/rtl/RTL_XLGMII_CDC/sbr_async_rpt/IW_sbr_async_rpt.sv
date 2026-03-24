module IW_sbr_async_rpt 
(
 
 
   // Outputs
  fabric_side_MNPCUP,
  fabric_side_MPCCUP, 
  fabric_side_TNPPUT, 
  fabric_side_TPCPUT,
  fabric_side_TEOM, 
  fabric_side_TPAYLOAD, 
  fabric_side_SIDE_ISM_FABRIC,
  agent_side_MNPPUT, 
  agent_side_MPCPUT, 
  agent_side_MEOM, 
  agent_side_MPAYLOAD,
  agent_side_TNPCUP, 
  agent_side_TPCCUP, 
  agent_side_SIDE_ISM_AGENT,
  // Inputs
  agent_side_sbr_clk, 
  sbr_rst_b, 
  fabric_side_sbr_clk,  
  fabric_side_MNPPUT, 
  fabric_side_MPCPUT,
  fabric_side_MEOM, 
  fabric_side_MPAYLOAD, 
  fabric_side_TNPCUP,
  fabric_side_TPCCUP, 
  fabric_side_SIDE_ISM_AGENT, 
  agent_side_MNPCUP,
  agent_side_MPCCUP, 
  agent_side_TNPPUT, 
  agent_side_TPCPUT, 
  agent_side_TEOM,
  agent_side_TPAYLOAD, 
  agent_side_SIDE_ISM_FABRIC
 );

  // -------------------------------
  // Widths for IOSF SideBandRouter Ports
  // -------------------------------

  parameter FABRIC_SIDE_DATAWIDTH = 16;
  parameter AGENT_SIDE_DATAWIDTH = 16;

  // -------------------------------
  // FIFO DEPTH 
  // -------------------------------

  parameter DEPTH = 4;

  // -------------------------------
  // Clocks & Resets
  // -------------------------------

  input                                  agent_side_sbr_clk;
  input                                  fabric_side_sbr_clk;
  input                                  sbr_rst_b;

  // -------------------------------
  // FABRIC_SIDE
  // -------------------------------

  input                                  fabric_side_MNPPUT;
  input                                  fabric_side_MPCPUT;
  output                                 fabric_side_MNPCUP;
  output                                 fabric_side_MPCCUP;
  input                                  fabric_side_MEOM;
  input [(FABRIC_SIDE_DATAWIDTH)-1:0]    fabric_side_MPAYLOAD;
  output                                 fabric_side_TNPPUT;
  output                                 fabric_side_TPCPUT;
  input                                  fabric_side_TNPCUP;
  input                                  fabric_side_TPCCUP;
  output                                 fabric_side_TEOM;
  output [(FABRIC_SIDE_DATAWIDTH)-1:0]   fabric_side_TPAYLOAD;
  input [2:0]                            fabric_side_SIDE_ISM_AGENT;
  output [2:0]                           fabric_side_SIDE_ISM_FABRIC;
  
  // -------------------------------
  // AGENT_SIDE
  // -------------------------------

  output                                 agent_side_MNPPUT;
  output                                 agent_side_MPCPUT;
  input                                  agent_side_MNPCUP;
  input                                  agent_side_MPCCUP;
  output                                 agent_side_MEOM;
  output [AGENT_SIDE_DATAWIDTH-1:0]      agent_side_MPAYLOAD;
  input                                  agent_side_TNPPUT;
  input                                  agent_side_TPCPUT;
  output                                 agent_side_TNPCUP;
  output                                 agent_side_TPCCUP;
  input                                  agent_side_TEOM;
  input [AGENT_SIDE_DATAWIDTH-1:0]       agent_side_TPAYLOAD;
  output [2:0]                           agent_side_SIDE_ISM_AGENT;
  input [2:0]                            agent_side_SIDE_ISM_FABRIC;

  //#############################################################################################################

  wire [AGENT_SIDE_DATAWIDTH-1:0]  agent_side_MPAYLOAD_np; 
  wire [AGENT_SIDE_DATAWIDTH-1:0]  agent_side_MPAYLOAD_pc; 
  wire [FABRIC_SIDE_DATAWIDTH-1:0] fabric_side_TPAYLOAD_np;
  wire [FABRIC_SIDE_DATAWIDTH-1:0] fabric_side_TPAYLOAD_pc;
  wire  agent_side_MEOM_np; 
  wire  agent_side_MEOM_pc; 
  wire  fabric_side_TEOM_np;
  wire  fabric_side_TEOM_pc;

  //#############################################################################################################
reg fabric_side_MNPPUT_q;
reg fabric_side_MPCPUT_q;
reg fabric_side_MEOM_q;
reg [FABRIC_SIDE_DATAWIDTH-1:0] fabric_side_MPAYLOAD_q;
reg fabric_side_TNPCUP_q;
reg fabric_side_TPCCUP_q;
reg [2:0] fabric_side_SIDE_ISM_AGENT_q;

reg agent_side_MNPCUP_q;
reg agent_side_MPCCUP_q;
reg agent_side_TNPPUT_q;
reg agent_side_TPCPUT_q;
reg agent_side_TEOM_q;
reg [AGENT_SIDE_DATAWIDTH-1:0] agent_side_TPAYLOAD_q;
reg [2:0] agent_side_SIDE_ISM_FABRIC_q;


  always @(posedge fabric_side_sbr_clk) begin
    fabric_side_MNPPUT_q         <= fabric_side_MNPPUT;
    fabric_side_MPCPUT_q         <= fabric_side_MPCPUT;
    fabric_side_MEOM_q           <= fabric_side_MEOM;
    fabric_side_MPAYLOAD_q       <= fabric_side_MPAYLOAD;
    fabric_side_TNPCUP_q         <= fabric_side_TNPCUP;
    fabric_side_TPCCUP_q         <= fabric_side_TPCCUP;
    fabric_side_SIDE_ISM_AGENT_q <= fabric_side_SIDE_ISM_AGENT;
  end

  always @(posedge agent_side_sbr_clk) begin
    agent_side_MNPCUP_q          <= agent_side_MNPCUP;
    agent_side_MPCCUP_q          <= agent_side_MPCCUP;
    agent_side_TNPPUT_q          <= agent_side_TNPPUT;
    agent_side_TPCPUT_q          <= agent_side_TPCPUT;
    agent_side_TEOM_q            <= agent_side_TEOM;
    agent_side_TPAYLOAD_q        <= agent_side_TPAYLOAD;
    agent_side_SIDE_ISM_FABRIC_q <= agent_side_SIDE_ISM_FABRIC;
  end



  wire ingress_np_rd_en;
  wire ingress_np_rd_empty;
  reg ingress_np_rd_en_q;
  
  gen_async_fifo #(
    .WIDTH (FABRIC_SIDE_DATAWIDTH + 1),
    .DEPTH (DEPTH)
  ) ingress_np_fifo (
    .wr_clk                     (fabric_side_sbr_clk),
    .wr_rst_n                   (sbr_rst_b),
    .wr_en                      (fabric_side_MNPPUT_q),
    .wr_data                    ({fabric_side_MEOM_q,fabric_side_MPAYLOAD_q}),
    .wr_used_space              (),
    .wr_full                    (),
    
    .rd_clk                     (agent_side_sbr_clk),
    .rd_rst_n                   (sbr_rst_b),
    .rd_en                      (ingress_np_rd_en),
    .rd_data                    ({agent_side_MEOM_np,agent_side_MPAYLOAD_np}),
    .rd_used_space              (),
    .rd_empty                   (ingress_np_rd_empty)
  );
  
  assign ingress_np_rd_en = ~ingress_np_rd_empty;
  assign agent_side_MNPPUT = ingress_np_rd_en_q;

  always @(posedge agent_side_sbr_clk)
    ingress_np_rd_en_q <= ingress_np_rd_en;
  
  //##
  wire ingress_np_credit_rd_empty;
  wire ingress_np_credit_data;
  wire ingress_np_credit_rd_en;
  reg  ingress_np_credit_data_q;
  
  gen_async_fifo #(
    .WIDTH (1),
    .DEPTH (DEPTH)
  ) ingress_np_credit_fifo (
    .wr_clk                     (agent_side_sbr_clk),
    .wr_rst_n                   (sbr_rst_b),
    .wr_en                      (agent_side_MNPCUP_q),
    .wr_data                    (1'b1),
    .wr_used_space              (),
    .wr_full                    (),
    
    .rd_clk                     (fabric_side_sbr_clk),
    .rd_rst_n                   (sbr_rst_b),
    .rd_en                      (ingress_np_credit_rd_en),
    .rd_data                    (ingress_np_credit_data),
    .rd_used_space              (),
    .rd_empty                   (ingress_np_credit_rd_empty)
  );
  assign ingress_np_credit_rd_en = ~ingress_np_credit_rd_empty;
  assign fabric_side_MNPCUP = ingress_np_credit_data_q; 

  always @(posedge fabric_side_sbr_clk)
  ingress_np_credit_data_q  <= ingress_np_credit_data;
  
  //##
  wire ingress_pc_rd_en;
  wire ingress_pc_rd_empty;
  reg ingress_pc_rd_en_q;
  
  gen_async_fifo #(
    .WIDTH (FABRIC_SIDE_DATAWIDTH + 1),
    .DEPTH (DEPTH)
  ) ingress_pc_fifo (
    .wr_clk                     (fabric_side_sbr_clk),
    .wr_rst_n                   (sbr_rst_b),
    .wr_en                      (fabric_side_MPCPUT_q),
    .wr_data                    ({fabric_side_MEOM_q,fabric_side_MPAYLOAD_q}),
    .wr_used_space              (),
    .wr_full                    (),
    
    .rd_clk                     (agent_side_sbr_clk),
    .rd_rst_n                   (sbr_rst_b),
    .rd_en                      (ingress_pc_rd_en),
    .rd_data                    ({agent_side_MEOM_pc,agent_side_MPAYLOAD_pc}),
    .rd_used_space              (),
    .rd_empty                   (ingress_pc_rd_empty)
  );
  
  assign ingress_pc_rd_en = ~ingress_pc_rd_empty;
  assign agent_side_MPCPUT = ingress_pc_rd_en_q;

  always @(posedge agent_side_sbr_clk)
    ingress_pc_rd_en_q <= ingress_pc_rd_en;
 

  //##
  wire ingress_pc_credit_rd_en;
  wire ingress_pc_credit_rd_empty;
  wire ingress_pc_credit_data;
  reg ingress_pc_credit_data_q;
  
  gen_async_fifo #(
    .WIDTH (1),
    .DEPTH (DEPTH)
  ) ingress_pc_credit_fifo (
    .wr_clk                     (agent_side_sbr_clk),
    .wr_rst_n                   (sbr_rst_b),
    .wr_en                      (agent_side_MPCCUP_q),
    .wr_data                    (1'b1),
    .wr_used_space              (),
    .wr_full                    (),
    
    .rd_clk                     (fabric_side_sbr_clk),
    .rd_rst_n                   (sbr_rst_b),
    .rd_en                      (ingress_pc_credit_rd_en),
    .rd_data                    (ingress_pc_credit_data),
    .rd_used_space              (),
    .rd_empty                   (ingress_pc_credit_rd_empty)
  );
  
  assign ingress_pc_credit_rd_en = ~ingress_pc_credit_rd_empty;
  assign fabric_side_MPCCUP = ingress_pc_credit_data_q;
  always @(posedge fabric_side_sbr_clk)
    ingress_pc_credit_data_q <= ingress_pc_credit_data;
  
  //##
  wire ingress_ism_rd_en;
  wire ingress_ism_rd_empty;
  wire [2:0] ingress_ism_rd_data;
  reg [2:0] agent_side_SIDE_ISM_FABRIC_qq;
  reg [2:0] ingress_ism_in_q;
  wire [2:0] ingress_ism_in;
  wire ingress_ism_wr_en;
  
  gen_async_fifo #(
    .WIDTH (3),
    .DEPTH (DEPTH)
  ) ingress_ism_fifo (
    .wr_clk                      (agent_side_sbr_clk),
    .wr_rst_n                    (sbr_rst_b),
    .wr_en                       (ingress_ism_wr_en),
    .wr_data                     (agent_side_SIDE_ISM_FABRIC_q),
    .wr_used_space               (),
    .wr_full                     (),
    
    .rd_clk                      (fabric_side_sbr_clk),
    .rd_rst_n                    (sbr_rst_b),
    .rd_en                       (ingress_ism_rd_en),
    .rd_data                     (ingress_ism_rd_data),
    .rd_used_space               (),
    .rd_empty                    (ingress_ism_rd_empty)
  );
  assign ingress_ism_rd_en = ~ingress_ism_rd_empty;
  
  assign ingress_ism_in = ingress_ism_rd_en? ingress_ism_rd_data: ingress_ism_in_q;
  assign fabric_side_SIDE_ISM_FABRIC = ingress_ism_in_q;

  always @ (posedge fabric_side_sbr_clk) begin
    if(~sbr_rst_b) begin
      ingress_ism_in_q<=0;
    end
    else begin
      ingress_ism_in_q<=ingress_ism_in;
    end
  end
  
  always @ (posedge agent_side_sbr_clk)
    agent_side_SIDE_ISM_FABRIC_qq <= agent_side_SIDE_ISM_FABRIC_q;
  
  assign ingress_ism_wr_en = ( agent_side_SIDE_ISM_FABRIC_q[0] ^ agent_side_SIDE_ISM_FABRIC_qq[0] |
                               agent_side_SIDE_ISM_FABRIC_q[1] ^ agent_side_SIDE_ISM_FABRIC_qq[1] |
                               agent_side_SIDE_ISM_FABRIC_q[2] ^ agent_side_SIDE_ISM_FABRIC_qq[2] );
  
  //##
  wire egress_np_rd_en;
  wire egress_np_rd_empty;
  reg egress_np_rd_en_q;
  
  gen_async_fifo #(
    .WIDTH (FABRIC_SIDE_DATAWIDTH + 1),
    .DEPTH (DEPTH)
  ) egress_np_fifo (
    .wr_clk                     (agent_side_sbr_clk),
    .wr_rst_n                   (sbr_rst_b),
    .wr_en                      (agent_side_TNPPUT_q),
    .wr_data                    ({agent_side_TEOM_q,agent_side_TPAYLOAD_q}),
    .wr_used_space              (),
    .wr_full                    (),
    
    .rd_clk                     (fabric_side_sbr_clk),
    .rd_rst_n                   (sbr_rst_b),
    .rd_en                      (egress_np_rd_en),
    .rd_data                    ({fabric_side_TEOM_np,fabric_side_TPAYLOAD_np}),
    .rd_used_space              (),
    .rd_empty                   (egress_np_rd_empty)
  );
  
  assign egress_np_rd_en = ~egress_np_rd_empty;
  assign fabric_side_TNPPUT = egress_np_rd_en_q;

  always @(posedge fabric_side_sbr_clk)
    egress_np_rd_en_q <= egress_np_rd_en;

  
  //##
  wire egress_np_credit_rd_empty;
  wire egress_np_credit_rd_en;
  wire egress_np_credit_data;
  reg  egress_np_credit_data_q;
  
  gen_async_fifo #(
    .WIDTH (1),
    .DEPTH (1)
  ) egress_np_credit_fifo (
    .wr_clk                     (fabric_side_sbr_clk),
    .wr_rst_n                   (sbr_rst_b),
    .wr_en                      (fabric_side_TNPCUP_q),
    .wr_data                    (1'b1),
    .wr_used_space              (),
    .wr_full                    (),
    
    .rd_clk                     (agent_side_sbr_clk),
    .rd_rst_n                   (sbr_rst_b),
    .rd_en                      (egress_np_credit_rd_en),
    .rd_data                    (egress_np_credit_data),
    .rd_used_space              (),
    .rd_empty                   (egress_np_credit_rd_empty)
  );
  
  assign egress_np_credit_rd_en = ~egress_np_credit_rd_empty;
  assign agent_side_TNPCUP = egress_np_credit_data_q;
  always @(posedge agent_side_sbr_clk)
   egress_np_credit_data_q <= egress_np_credit_data;
  
  //##
  wire egress_pc_rd_empty;
  wire egress_pc_rd_en;
  reg egress_pc_rd_en_q;
  
  gen_async_fifo #(
    .WIDTH (FABRIC_SIDE_DATAWIDTH + 1),
    .DEPTH (DEPTH)
  ) egress_pc_fifo (
    .wr_clk                     (agent_side_sbr_clk),
    .wr_rst_n                   (sbr_rst_b),
    .wr_en                      (agent_side_TPCPUT_q),
    .wr_data                    ({agent_side_TEOM_q,agent_side_TPAYLOAD_q}),
    .wr_used_space              (),
    .wr_full                    (),
    
    .rd_clk                     (fabric_side_sbr_clk),
    .rd_rst_n                   (sbr_rst_b),
    .rd_en                      (egress_pc_rd_en),
    .rd_data                    ({fabric_side_TEOM_pc,fabric_side_TPAYLOAD_pc}),
    .rd_used_space              (),
    .rd_empty                   (egress_pc_rd_empty)
  );
  
  assign egress_pc_rd_en = ~egress_pc_rd_empty;
  assign fabric_side_TPCPUT = egress_pc_rd_en_q;

  always @(posedge fabric_side_sbr_clk)
    egress_pc_rd_en_q <= egress_pc_rd_en;
  
  //##
  wire egress_pc_credit_rd_en;
  wire egress_pc_credit_rd_empty;
  wire egress_pc_credit_data;
  reg  egress_pc_credit_data_q;

  gen_async_fifo #(
    .WIDTH (1),
    .DEPTH (DEPTH)
  ) egress_pc_credit_fifo (
    .wr_clk                     (fabric_side_sbr_clk),
    .wr_rst_n                   (sbr_rst_b),
    .wr_en                      (fabric_side_TPCCUP_q),
    .wr_data                    (1'b1),
    .wr_used_space              (),
    .wr_full                    (),
    
    .rd_clk                     (agent_side_sbr_clk),
    .rd_rst_n                   (sbr_rst_b),
    .rd_en                      (egress_pc_credit_rd_en),
    .rd_data                    (egress_pc_credit_data),
    .rd_used_space              (),
    .rd_empty                   (egress_pc_credit_rd_empty)
  );
  
  assign egress_pc_credit_rd_en = ~egress_pc_credit_rd_empty;
  assign agent_side_TPCCUP = egress_pc_credit_data_q;
  always @(posedge agent_side_sbr_clk)
   egress_pc_credit_data_q <= egress_pc_credit_data;
  
  //##
  wire egress_ism_rd_empty;
  wire egress_ism_rd_en;
  wire [2:0] egress_ism_rd_data;
  reg [2:0] fabric_side_SIDE_ISM_AGENT_qq;
  reg [2:0] egress_ism_in_q;
  wire [2:0] egress_ism_in;
  wire egress_ism_wr_en;
  
  gen_async_fifo #(
    .WIDTH (3),
    .DEPTH (DEPTH)
  ) egress_ism_fifo (
    .wr_clk                      (fabric_side_sbr_clk),
    .wr_rst_n                    (sbr_rst_b),
    .wr_en                       (egress_ism_wr_en),
    .wr_data                     (fabric_side_SIDE_ISM_AGENT_q),
    .wr_used_space               (),
    .wr_full                     (),
    
    .rd_clk                      (agent_side_sbr_clk),
    .rd_rst_n                    (sbr_rst_b),
    .rd_en                       (egress_ism_rd_en),
    .rd_data                     (egress_ism_rd_data),
    .rd_used_space               (),
    .rd_empty                    (egress_ism_rd_empty)
  );
  assign egress_ism_rd_en = ~egress_ism_rd_empty;

  assign egress_ism_in = egress_ism_rd_en? egress_ism_rd_data: egress_ism_in_q;
  assign agent_side_SIDE_ISM_AGENT= egress_ism_in_q;

  always @ (posedge agent_side_sbr_clk) begin
    if(~sbr_rst_b) begin
      egress_ism_in_q<=0;
    end
    else begin
      egress_ism_in_q<=egress_ism_in;
    end
  end
      
  always @ (posedge fabric_side_sbr_clk)
    fabric_side_SIDE_ISM_AGENT_qq <= fabric_side_SIDE_ISM_AGENT_q;
  
  assign egress_ism_wr_en = ( fabric_side_SIDE_ISM_AGENT_q[0] ^ fabric_side_SIDE_ISM_AGENT_qq[0] |
                              fabric_side_SIDE_ISM_AGENT_q[1] ^ fabric_side_SIDE_ISM_AGENT_qq[1] |
                              fabric_side_SIDE_ISM_AGENT_q[2] ^ fabric_side_SIDE_ISM_AGENT_qq[2] );

  reg fabric_side_TEOM_q;
  reg agent_side_MEOM_q;
  reg [FABRIC_SIDE_DATAWIDTH-1:0] fabric_side_TPAYLOAD_q;
  reg [AGENT_SIDE_DATAWIDTH-1:0] agent_side_MPAYLOAD_q;

  always @(posedge agent_side_sbr_clk) begin
    if (ingress_pc_rd_en) begin
      {agent_side_MEOM_q, agent_side_MPAYLOAD_q} <= {agent_side_MEOM_pc,agent_side_MPAYLOAD_pc};
    end
    else if (ingress_np_rd_en) begin
      {agent_side_MEOM_q, agent_side_MPAYLOAD_q} <= {agent_side_MEOM_np,agent_side_MPAYLOAD_np};
    end
    else begin
      {agent_side_MEOM_q, agent_side_MPAYLOAD_q} <= {1'b0,{AGENT_SIDE_DATAWIDTH{1'b0}}};
    end
  end

  assign {agent_side_MEOM, agent_side_MPAYLOAD} = {agent_side_MEOM_q, agent_side_MPAYLOAD_q};


  always @(posedge fabric_side_sbr_clk) begin
    if (egress_pc_rd_en) begin
      {fabric_side_TEOM_q, fabric_side_TPAYLOAD_q} <= {fabric_side_TEOM_pc,fabric_side_TPAYLOAD_pc};
    end
    else if (egress_np_rd_en) begin
      {fabric_side_TEOM_q, fabric_side_TPAYLOAD_q} <= {fabric_side_TEOM_np,fabric_side_TPAYLOAD_np};
    end
    else begin
      {fabric_side_TEOM_q, fabric_side_TPAYLOAD_q} <= {1'b0,{FABRIC_SIDE_DATAWIDTH{1'b0}}};
    end
  end

  assign {fabric_side_TEOM, fabric_side_TPAYLOAD} = {fabric_side_TEOM_q, fabric_side_TPAYLOAD_q};


endmodule
