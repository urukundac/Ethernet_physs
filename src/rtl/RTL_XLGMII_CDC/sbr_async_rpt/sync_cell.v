module sync_cell (
  // Outputs
  out, 
  // Inputs
  clk, rst_b, d, se, si
  );
  input clk, rst_b, d, se, si                ;
  output out                                 ;

  wire   rst                                 ;
  
  ctech_lib_inv  ctech_lib_inv_i (.a (rst_b),
                                  .o1(rst  ));

  ctech_lib_msff_async_rst_meta sync_cell_i (.clk (clk),
					     .d   (d  ),
					     .rst (rst),
					     .o   (out));


   
endmodule // sync_cell
