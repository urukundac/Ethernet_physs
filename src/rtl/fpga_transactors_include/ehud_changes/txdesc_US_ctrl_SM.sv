//
// Module txdesc_US_ctrl_SM
//
// Created:
//          by - Ehud Cohn
//          at - 20/5/25 
//
//


`timescale 1ns/10ps
module txdesc_US_ctrl_SM ( 
    // Port Declarations
	
	 //FGC CLK and Reset wires:
	input  	wire    				clk, 
	input 	wire    				rst_n, 
  
   //inputs
      
	input	wire 					empty_cmd_fifo,
	input	wire [63:0]				dout_cmd_fifo, 
    input	wire 					empty_data_fifo,
    input	wire 					full_cmd_data_fifo,
    
   //outputs
    
    output	reg  					rd_cmd_fifo,
	output	reg   					rd_data_fifo,  
	output	reg  /*[1:0]*/			select, 
    output	wire 					wr_noaligned,
	//output	reg 					sof, 
    output	reg 					eof,
    output	logic 					dword_en_flag_locked, 
    output	reg  [9:0]				length_locked, 
    output	reg 					length_even_odd_flag_locked
);


// Internal signal declarations


	//reg	[127:0]		dout_cmd_fifo_reg;
	reg				has_data;
	reg [9:0]		length_in_qw;
	reg				go_to_idle_flag;
	reg				data_flag;
	reg	[6:0]		fmt_type_locked;
	reg				desc_34_locked;
	reg				desc_2_locked;

//signals
   parameter  IDLE         				= 2'b00;
   parameter  CMD_PHASE					= 2'b01; 
   parameter  DATA_PHASE				= 2'b10; 
   parameter  REST						= 2'b11; 
   
  reg [1:0] current_state;

   always @ (posedge clk or negedge rst_n)
   begin
   if (rst_n == 1'b0) begin //  Asynchronous reset
		current_state 					<= IDLE;
		//dout_cmd_fifo_reg				<= 'b0;
		has_data						<= 1'b0;
		go_to_idle_flag					<= 1'b0;
		data_flag						<= 1'b0;
		rd_cmd_fifo 					<= 'b0;		
		rd_data_fifo 					<= 'b0;		  
		select 							<= 'b0;		
		//wr_noaligned 					<= 'b0;		
		//sof 							<= 'b0;		
		eof 							<= 'b0;		
		//dword_en_flag_locked 			<= 'b0;
		length_in_qw					<= 'b0;		
		length_locked 					<= 'b0;		
		length_even_odd_flag_locked 	<= 'b0;
		fmt_type_locked					<= 'b0;
		desc_34_locked					<= 1'b0;
		desc_2_locked					<= 1'b0;
    end
   else begin
      case(current_state) 
   IDLE:
     begin 
        if (empty_cmd_fifo == 1'b0 & ~full_cmd_data_fifo) begin
				current_state 					<= REST; 
				rd_data_fifo 					<= 1'b0;
				select							<= 1'b1;//2'b01;
				//dout_cmd_fifo_reg[127:64]		<= dout_cmd_fifo;
				has_data						<= dout_cmd_fifo[62];
				length_locked					<= dout_cmd_fifo[41:32];
				desc_34_locked					<= dout_cmd_fifo[34];
				desc_2_locked					<= dout_cmd_fifo[2];
				fmt_type_locked					<= dout_cmd_fifo[126:120];
				length_in_qw					<= dout_cmd_fifo[41:33] + dout_cmd_fifo[32];
				length_even_odd_flag_locked		<= dout_cmd_fifo[32];
				rd_cmd_fifo 					<= 1'b1;	
				eof								<= 1'b0;
				data_flag						<= 1'b0;					
        end else begin
				current_state 					<= IDLE;
				rd_cmd_fifo 					<= 1'b0;
				rd_data_fifo 					<= 1'b0; 
				select							<= 1'b0;
				eof								<= 1'b0;
				data_flag						<= 1'b0;
	     end
     end
     
    REST:
     begin 
			if (go_to_idle_flag) begin
				current_state 					<= IDLE;
				go_to_idle_flag					<= 1'b0;
				rd_cmd_fifo 					<= 1'b0;
				rd_data_fifo 					<= 1'b0;
				select							<= 1'b0;
			end else if (data_flag) begin
				current_state 					<= DATA_PHASE;
				rd_cmd_fifo 					<= 1'b0;
				rd_data_fifo 					<= 1'b0;
				select							<= 1'b0;
			end else begin
				current_state 					<= CMD_PHASE;
				rd_cmd_fifo 					<= 1'b0;
				rd_data_fifo 					<= 1'b0;
				select							<= 1'b0;
			end
     end 
     
   CMD_PHASE:
     begin 
        if (empty_cmd_fifo == 1'b0 && ~has_data & ~full_cmd_data_fifo) begin
				current_state 					<= REST; 
				go_to_idle_flag					<= 1'b1;
				select							<= 1'b1;//2'b01; 
				rd_cmd_fifo 					<= 1'b1;		
        end else if (empty_cmd_fifo == 1'b0 && has_data & ~full_cmd_data_fifo) begin
				current_state 					<= DATA_PHASE;
				//sof								<= 1'b1; 
				select							<= 1'b1;//2'b01;
				//dout_cmd_fifo_reg[63:0]			<= dout_cmd_fifo; 
				rd_cmd_fifo 					<= 1'b1;
        end else begin
				current_state 					<= CMD_PHASE; 
				select							<= 1'b0;//2'b00;
				rd_cmd_fifo 					<= 1'b0;
	     end
     end
     
      DATA_PHASE:  
   begin 
        if (empty_data_fifo == 1'b0 & ~full_cmd_data_fifo) begin
				if (length_in_qw > 1) begin
					current_state 					<= REST;
				end else begin
					current_state 					<= IDLE;
					eof								<= 1'b1;
				end
				length_in_qw					<= length_in_qw -1;
				select							<= 1'b0;//2'b01; 
				data_flag						<= 1'b1;
				rd_data_fifo 					<= 1'b1;	
				rd_cmd_fifo 					<= 1'b0;	
      /* end else if (empty_data_fifo == 1'b0 && length_in_qw == 1 & ~full_cmd_data_fifo) begin
				current_state 					<= IDLE; 
				eof								<= 1'b1;
				select							<= 1'b0;// 2'b01;//TODO?
				//dout_cmd_fifo_reg[63:0]			<= dout_cmd_fifo; 
				rd_data_fifo 					<= 1'b1;
				rd_cmd_fifo 					<= 1'b0;
        end else if (empty_data_fifo == 1'b0 && length_in_qw == 0) begin
				current_state 					<= IDLE; 
				select							<= 1'b0;//2'b01;
				//dout_cmd_fifo_reg[63:0]			<= dout_cmd_fifo; 
				rd_data_fifo 					<= 1'b1;
				rd_cmd_fifo 					<= 1'b0;*/
        end else begin
				current_state 					<= DATA_PHASE; 
				select							<= 1'b0;//2'b00;
				length_in_qw					<= length_in_qw;
				rd_data_fifo 					<= 1'b0;
				rd_cmd_fifo 					<= 1'b0;
	     end
     end
     
  default:
     current_state  <= IDLE;
     endcase
   end  
   end 
   
	//assign dword_en_flag_locked = 1'b1;	//TODO
	
always @(*) begin
  case (fmt_type_locked)

    // compl
    7'b0001010, // compl without data
    7'b1001010, // compl with data
    7'b0001011, // compl locked mem without data
    7'b1001011, // compl locked mem with data

    // 32-bit mem/io
    7'b1000000, // mem_wr 32
    7'b0000000, // mem_rd 32
    7'b0000001, // mem_rd locked 32
    7'b1000010, // io_wr 32
    7'b0000010, // io_rd 32
    7'b0000111, // LTMRd32
    7'b1000111, // LTMWR32
    
     // config
    7'b0000100, // config rd type0
    7'b1000100, // config wr type0
    7'b0000101, // config rd type1
    7'b1000101: // config wr type1
      dword_en_flag_locked = desc_34_locked;

    // 64-bit mem
    7'b1100000, // mem_wr 64
    7'b0100000, // mem_rd 64
    7'b0100001, // mem_rd locked 64
    7'b0100111, // LTMRd64
    7'b1100111, // LTMWR64

    // other [2]
    7'b0110100,
    7'b0110010,
    7'b0110001,
    7'b1110100,
    7'b1110010,
    7'b1110001:
      dword_en_flag_locked = desc_2_locked;

    default:
      dword_en_flag_locked = 1'b0;
  endcase
end
	
	assign wr_noaligned 		= rd_data_fifo; 

/*assign dword_en_flag_nolocked = direct_IM_select_sync ? 1'b0 : ((({cmd_vector_in[5:4],cmd_vector_in[10:9]} == 4'b0110) | ({cmd_vector_in[5:4],cmd_vector_in[10:9]} == 4'b1110)) ? 
				 (((cmd_vector_in[8:6] == 3'b010) || (cmd_vector_in[8:6] == 3'b001) || (cmd_vector_in[8:6] == 3'b100))? cmd_vector_in[93] : 1'b0) : cmd_vector_in[61]);*/

endmodule 




