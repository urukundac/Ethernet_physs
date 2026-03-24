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
//    FILENAME  : mgm_sync_pa2pb_agg.v
//    DESIGNER  : Yevgeny Yankilevich
//    DATE      : 16/02/16
//    REVISION NUMBER   : 1.0
//    DESCRIPTION       :
//
//          Pulse A to Pulse B with an Aggregator Counter
//
//---------------------------------------------------------------------------//
// --------------------------------------------------------------------------//
//      LAST MODIFICATION:      16/02/16
//      RECENT AUTHORS:         yevgeny.yankilevich@intel.com
//      PREVIOUS RELEASES:      
//                              16/02/16: First version.
// --------------------------------------------------------------------------//
module  hlp_mgm_sync_pa2pb_agg#(
        parameter       AGG_CNT         = 15                    ,
        parameter       AGG_CNT_WIDTH   = $bits(AGG_CNT)        
)(
        input   logic           reset_n_a       ,
        input   logic           clk_a           ,
        input   logic           reset_n_b       ,
        input   logic           clk_b           ,
        input   logic           pulse_a         ,
        output  logic           pulse_b
);

        logic   [AGG_CNT_WIDTH-1:0]     cnt                                                     ;
        logic                           agg_pulse_a, agg_pulse_b, agg_flag, accepted_pb2pa      ;

        always_ff @(posedge clk_a or negedge reset_n_a)
                if (!reset_n_a) begin
                        cnt     <=      {(AGG_CNT_WIDTH){1'b0}};
                end
                else if (pulse_a) begin
                        cnt     <=      (cnt == AGG_CNT) ? cnt : cnt + {{(AGG_CNT_WIDTH-1){1'b0}}, 1'b1};
                end
                else if (accepted_pb2pa) begin
                        cnt     <=      cnt - {{(AGG_CNT_WIDTH-1){1'b0}}, 1'b1};
                end

        always_ff @(posedge clk_a or negedge reset_n_a)
                if (!reset_n_a) begin
                        agg_pulse_a     <= 1'b0;
                        agg_flag        <= 1'b1;
                end
                else if (agg_pulse_a) begin
                        agg_pulse_a     <= 1'b0;
                end
                else if (accepted_pb2pa) begin
                        agg_flag        <= 1'b1;
                end
                else if ((cnt > 0) && (agg_flag)) begin
                        agg_pulse_a     <= 1'b1;
                        agg_flag        <= 1'b0;
                end
                                
        hlp_mgm_sync_pa2pb u_gen_sync_pa2pb (.clka(clk_a), .clkb(clk_b), .rst_n_a(reset_n_a), .rst_n_b(reset_n_b), .pulse_in(agg_pulse_a), .pulse_out(agg_pulse_b));
        
        hlp_mgm_sync_pa2pb u_gen_sync_pb2pa (.clka(clk_b), .clkb(clk_a), .rst_n_a(reset_n_b), .rst_n_b(reset_n_a), .pulse_in(agg_pulse_b), .pulse_out(accepted_pb2pa));
        
        assign  pulse_b = agg_pulse_b;

endmodule//mgm_sync_pa2pb_agg
