//----------------------------------------------------------------------------//
//    Copyright (c) 2006 Intel Corporation
//    Intel Communication Group/ Platform Network Group / ICGh
//    Intel Proprietary
//
//       *               *     
//     (  `    (       (  `    
//     )\))(   )\ )    )\))(   
//    ((_)()\ (()/(   ((_)()\  
//    (_()((_) /(_))_ (_()((_) 
//    |  \/  |(_)) __||  \/  | 
//    | |\/| |  | (_ || |\/| | 
//    |_|  |_|   \___||_|  |_|
//
//    FILENAME          : mgm_fifo.v
//    DESIGNER          : Anatoly Uskach
//    DATE              : 16/02/16
//    REVISION NUMBER   : 1.0
//    DESCRIPTION       :
//
//          Generic FIFO
//
//---------------------------------------------------------------------------//
// --------------------------------------------------------------------------//
//      LAST MODIFICATION:      16/02/16
//      RECENT AUTHORS:         yevgeny.yankilevich@intel.com
//      PREVIOUS RELEASES:      
//                              16/02/16: First version.
// --------------------------------------------------------------------------//
module hlp_mgm_fifo#(
        parameter       WIDTH   = 30            ,
        parameter       ADD_L   = 2             , //Must set
        parameter       LENGTH  = (1 << ADD_L)  
)(
        input   logic                   clk     ,
        input   logic                   rst_n   ,
        output  logic   [WIDTH-1:0]     d_out   ,
        input   logic   [WIDTH-1:0]     d_in    ,
        input   logic                   rd      ,
        input   logic                   wr      ,
        output  logic                   empty   ,
        output  logic                   full    ,
        output  logic   [ADD_L:0]       state_cnt
);

   parameter 
         L = 512'h0,
         H = 512'h1;
   
  localparam LENGTH_M1 = LENGTH - 1;

   wire               write;
   wire               read;
   assign             write  = wr && !full;
   assign             read   = rd && !empty;

   //OVL Assertions
`ifdef HLP_OVL_ON
   
   // Check : write while fifo is full 
   assert_never #(1, 0, "Attempting to write to a full FIFO") 
   wr_when_int_full(clk, rst_n, full && wr);
   
   // Check : read while fifo is empty 
   assert_never #(1, 0, "Attempting to read from an empty FIFO") 
   rd_when_int_empty(clk, rst_n, empty && rd);
   
`endif //  `ifdef HLP_OVL_ON
   
           
           // internal 
           reg                int_empty;
           reg                int_full;   
           reg [ADD_L-1:0]    wr_addr, rd_addr;
           wire [ADD_L-1:0]   next_rd_addr, next_wr_addr;
           reg [ADD_L:0]      int_state_cnt;
           reg [WIDTH-1:0]    reg_mem [LENGTH-1:0];
           
           assign             next_rd_addr  = (rd_addr != LENGTH_M1[ADD_L-1:0]) ? rd_addr + H[ADD_L-1:0] : L[ADD_L-1:0];
           assign             next_wr_addr  = (wr_addr != LENGTH_M1[ADD_L-1:0]) ? wr_addr + H[ADD_L-1:0] : L[ADD_L-1:0];
           
           assign empty                     =int_empty;
           assign full                      =int_full;
           assign state_cnt                 =int_state_cnt;           
           
           always_ff @(posedge clk or negedge rst_n)
             if (!rst_n)
               begin
                  wr_addr <= L[ADD_L-1:0];
                  rd_addr <= L[ADD_L-1:0];
                  int_state_cnt <= L[ADD_L:0];
                  int_empty <= 1'b1;
                  int_full <= 1'b0;
               end
             else
               begin
                  
                  if (write && read)
                    begin
                       int_empty <= 1'b0;
                       wr_addr <= next_wr_addr;
                       rd_addr <= next_rd_addr;
                    end   
                  else if (write)
                    begin
                       int_empty <= 1'b0;
                       wr_addr <= next_wr_addr;
                       int_state_cnt <= int_state_cnt + H[ADD_L:0];
                       if (int_state_cnt == LENGTH_M1[ADD_L:0])
                         int_full <= 1'b1;
                    end
                       else if (read)
                         begin
                            int_full <= 1'b0;
                            rd_addr <= next_rd_addr;
                            int_state_cnt <= int_state_cnt - H[ADD_L:0];
                            if (int_state_cnt == H[ADD_L:0])
                              int_empty <= 1'b1;
                         end                  
               end // else: !if(!rst_n)           
           
           
           // WRITE
           always_ff @(posedge clk or negedge rst_n)
             begin
                if(~rst_n)
                  for (integer i=0;i<LENGTH;i=i+1)
                    reg_mem[i] <= {(WIDTH){1'b0}};
                else if(wr & ~int_full)
                  reg_mem[wr_addr] <= d_in;
             end
           
           // READ (next data available)
           assign d_out = reg_mem[rd_addr];
           
`ifdef HLP_RTL
reg [15:0] dbg_cnt_wr,dbg_cnt_rd ; 

always_ff @(posedge clk or negedge rst_n)
 if (~rst_n) begin
   dbg_cnt_wr <= 0; 
   dbg_cnt_rd <= 0; 
 end 
 else begin
   if (wr)
     dbg_cnt_wr <= dbg_cnt_wr + 1; 
   
   if (rd)
     dbg_cnt_rd <= dbg_cnt_rd + 1; 

 end
`endif
           
endmodule // mgm_fifo
