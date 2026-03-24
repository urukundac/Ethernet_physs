
  /*
    * Function to calculate LFSR
  */
  function [LFSR_WIDTH-1:0] gen_lfsr_nxt  (input  [LFSR_WIDTH-1:0]  poly,  D);
    if(D[0])
    begin
      return  {1'b0,D[LFSR_WIDTH-1:1]}  ^ poly;
    end
    else
    begin
      return  {1'b0,D[LFSR_WIDTH-1:1]};
    end
  endfunction  //gen_lfsr_nxt

