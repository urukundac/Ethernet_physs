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
 Generic asyncronous FIFO that uses FF based ram for small memory implementations
 ===========================================================================*/

module gen_async_fifo
  #(parameter 
    WIDTH = 8,
    DEPTH = 8,
    AW = clogb2(DEPTH),
    SYNC = 0,
	DELAY = 0)
    (
     //WR
     input               wr_clk, 
     input               wr_rst_n,
     input               wr_en,
     input [WIDTH-1:0]   wr_data,
     output [AW:0]       wr_used_space,
     output              wr_full,
    
     //RD
     input               rd_clk,
     input               rd_rst_n,
     input               rd_en,
     output [WIDTH-1:0]  rd_data,
     output              rd_ecc_err,
     output [AW:0]       rd_used_space,
     output              rd_empty
     );

   wire [AW-1:0] 		 mem_wr_addr;
   wire [AW-1:0] 		 mem_rd_addr;
   wire [WIDTH-1:0]              mem_rd_data;
   wire                          mem_wr_en  ;
   wire                          mem_rd_en  ;
   wire                          mem_rd_ecc_err;
   
   gen_async_fifo_cntrl #(
                          .DW    (WIDTH),
                          .AW    (AW),                          
                          .DEPTH (DEPTH),
                          .SYNC  (SYNC),
                          .DELAY (DELAY))
     async_fifo_cntrl
       (
        // Outputs
        .wr_used_space                      (wr_used_space[AW:0]),
        .wr_full                            (wr_full),
        .rd_used_space                      (rd_used_space[AW:0]),
        .rd_empty                           (rd_empty),
        .rd_data                            (rd_data[WIDTH-1:0]),
        .rd_ecc_err                         (rd_ecc_err),
        .mem_wr_en                          (mem_wr_en),
        .mem_wr_addr                        (mem_wr_addr[AW-1:0]),
        .mem_rd_en                          (mem_rd_en),
        .mem_rd_addr                        (mem_rd_addr[AW-1:0]),
        // Inputs
        .wr_clk                             (wr_clk),
        .wr_rst_n                           (wr_rst_n),
        .rd_clk                             (rd_clk),
        .rd_rst_n                           (rd_rst_n),
        .wr_en                              (wr_en),
        .rd_en                              (rd_en),
        .mem_rd_data                        (mem_rd_data[WIDTH-1:0]),
        .mem_rd_ecc_err                     (mem_rd_ecc_err));

   


   gen_dual_port_ram #(
                       .DW    (WIDTH), 
                       .AW    (AW),
                       .DEPTH (DEPTH),
                       .DELAY (DELAY))     
     dual_port_mem 
       (
        // Outputs
        .rd_data                            (mem_rd_data[WIDTH-1:0]),
        .rd_ecc_err                         (mem_rd_ecc_err),
        // Inputs
        .wr_clk                             (wr_clk),
        .wr_rst_n                           (wr_rst_n),
        .rd_clk                             (rd_clk),
        .rd_rst_n                           (rd_rst_n),
        .wr_en                              (mem_wr_en),
        .wr_addr                            (mem_wr_addr[AW-1:0]),
        .wr_data                            (wr_data[WIDTH-1:0]),
        .rd_en                              (mem_rd_en),
        .rd_addr                            (mem_rd_addr[AW-1:0]));


 function automatic int clogb2 (int a);  //clog2 - returns 1 for 1/0 
        clogb2 = 1;
        while (2 ** clogb2 < a)
         clogb2 ++;
 endfunction
   
endmodule
