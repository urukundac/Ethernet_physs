//----------------------------------------------------------------------------//
//- PRBS                    --------------------------------------------------//
//----------------------------------------------------------------------------//
//  Written By: Ronen Paz
//  Date: June 2016
//----------------------------------------------------------------------------//

module lfsr32 
  (
   clk, 
   rstn, 
   lfsr_out
   );

  input           clk;
  input           rstn;
  output [31:0]   lfsr_out; 

  reg [31:0] 	  lfsr;
  wire            feedback;

  assign 	  feedback = lfsr[31];

  always @(posedge clk or negedge rstn) 
    if (~rstn)
      lfsr[31:0] <= 32'hffff;
    else 
      begin
	lfsr[0]  <= feedback;
	lfsr[1]  <= feedback ^ lfsr[0]; // feedback from equation x^1 term
	lfsr[2]  <= feedback ^ lfsr[1]; // feedback from equation x^2 term
	lfsr[3]  <= lfsr[2];
	lfsr[4]  <= lfsr[3];
	lfsr[5]  <= lfsr[4];
	lfsr[6]  <= lfsr[5];
	lfsr[7]  <= lfsr[6];
	lfsr[8]  <= lfsr[7]; 
	lfsr[9]  <= lfsr[8];
	lfsr[10] <= lfsr[9];
	lfsr[11] <= lfsr[10];
	lfsr[12] <= lfsr[11];
	lfsr[13] <= lfsr[12];
	lfsr[14] <= lfsr[13];
	lfsr[15] <= lfsr[14];
	lfsr[16] <= lfsr[15];
	lfsr[17] <= lfsr[16];
	lfsr[18] <= lfsr[17]; 
	lfsr[19] <= lfsr[18];
	lfsr[20] <= lfsr[19];
	lfsr[21] <= lfsr[20];
	lfsr[22] <= feedback ^ lfsr[21];  // feedback from equation x^22 term
	lfsr[23] <= lfsr[22];
	lfsr[24] <= lfsr[23];
	lfsr[25] <= lfsr[24];
	lfsr[26] <= lfsr[25];
	lfsr[27] <= lfsr[26];
	lfsr[28] <= lfsr[27]; 
	lfsr[29] <= lfsr[28];
	lfsr[30] <= lfsr[29];
	lfsr[31] <= lfsr[30];
      end


  assign lfsr_out[31:0] = lfsr[31:0]; 

endmodule

