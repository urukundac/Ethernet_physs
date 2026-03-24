/*=========================================================================== 
 Copyright (c) 2006 Intel Corporation
 Intel Communication Group/ Platform Network Group / ICGh
 Intel Proprietary
 
 FILE information:
 CVS Source    : $Source:$
 CVS Revision  : $Revision:$
 CVS Tag       : $Name:$
 Written by    : Amnon Israel
 Last Update by: $Author:$
 Last Update   : $Date: $

 Module Description:
 --------------------
 A behavioural (synthesizable) dual port ram
 in case RTL in on there in no output delay
 ===========================================================================*/

module gen_dual_port_ram
  #(parameter 
	DW = 8,
 	AW = 4,
	DEPTH = 4,
	DELAY = 0)
	(
	 input               wr_clk,
	 input               wr_rst_n,
	 input               rd_clk,
	 input               rd_rst_n,
	 input               wr_en,
	 input [AW-1:0]      wr_addr,
	 input [DW-1:0]      wr_data,
	 input               rd_en,
	 input [AW-1:0]      rd_addr,
	 output [DW-1:0]     rd_data,
	 output              rd_ecc_err
	 );
  
  reg [DW-1:0] 			 mem [DEPTH-1:0];
  assign 			 rd_ecc_err = 0;
  wire [DW-1:0]                  mux_out;

  
  always @(posedge wr_clk or negedge wr_rst_n)
    if (~wr_rst_n)
      for (int j=0;j<DEPTH;j=j+1)
	mem[j] <= {DW{1'h0}};
    else if (wr_en) 
      mem[wr_addr] <= wr_data;
  
  
  wire [2**(AW+1)-1:1] 	 tmp_wire [DW-1:0];
  
  genvar l, w, m, i;

  generate
    for (w=DW-1; w>=0; w=w-1) begin : fifo_width
      for (i=0; i<2**AW; i=i+1) begin : init_values
        if (i>=DEPTH) begin : out_of_wdth
          assign tmp_wire[w][2**AW+i] = 1'b0;
        end else begin: in_wdth
          assign tmp_wire[w][2**AW+i] = mem[i][w];
        end
      end

      for (l=AW; l>0; l=l-1) begin : mux_level
        for (m=2**(l-1)-1; m>=0; m=m-1) begin : mux_inst_in_row
          ctech_lib_mux_2to1 ctech_lib_mux_2to1
            (
             .d1  (tmp_wire[w][2**l    +2*m  ]),
             .d2  (tmp_wire[w][2**l    +2*m+1]),
             .s   (~rd_addr    [AW-l]),
             .o   (tmp_wire[w][2**(l-1)+  m  ]));
        end
      end
      assign mux_out[w] = tmp_wire[w][1];
    end
  endgenerate

  generate
    if (DELAY) begin: add_sample

      reg [DW-1:0] 			 rd_data_1p;
      
      always @(posedge rd_clk or negedge rd_rst_n)
        if (~rd_rst_n)
          rd_data_1p <= {DW{1'h0}};
        else if (rd_en)
          rd_data_1p <= mux_out;

      assign rd_data = rd_data_1p;

    end else begin : no_sample // block: add_sample
      
      assign rd_data = mux_out;

    end // else: !if(DELAY)
  endgenerate
  
  
endmodule
