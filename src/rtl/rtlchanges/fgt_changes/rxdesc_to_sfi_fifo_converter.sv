
// Author: Ehud Cohn


module rxdesc_to_sfi_fifo_converter #(
		parameter HPARITY 	= 1,  //supported values: 0, 1
		parameter D 		= 64  //supported values: 64, 128
                    )
//import desc_pkg::*;
//import sfi_hdr_pkg::*;
(
    input  	wire         			clk,
    input  	wire         			rst_n,
    
    // input to converter from rxdesc_to_sfi_fifo_converter
    output	reg            			rd_cmd_fifo,
    input 	wire 	[127:0] 	    dout_cmd_fifo,
    input	wire           			empty_cmd_fifo,
    output  reg            			rd_data_fifo,
    input 	wire 	[63:0] 			dout_data_fifo,
    input	wire           			empty_data_fifo,
    output	reg            			rd_length_fifo,
    input 	wire 	[9:0] 	    	dout_length_fifo,
    input	wire           			empty_length_fifo,
    output  reg            			rd_type_and_length_fifo,
    input 	wire 	[16:0] 			dout_type_and_length_fifo,
    input	wire           			empty_type_and_length_fifo,

    //output to sfi fifo HDR in SFI transactor
     input  wire	[3:0]          rd_rx_fifo,		
     output reg   	[3:0]  [127:0] dout_rx_fifo,
     output	reg   	[3:0]          empty_rx_fifo
);
    
        
    
    logic 			wr_DATA_fifo;
    logic 			wr_DATA_MD_fifo;
    wire 			wr_HDR_fifo;
    wire 			wr_HDR_MD_fifo;
    logic	[127:0] din_DATA_fifo;
    logic	[255:0] din_DATA_MD_fifo;
    logic	[255:0] din_HDR_fifo;
    logic	[127:0] din_HDR_MD_fifo;
    wire 			full_DATA_fifo;
    wire 			full_DATA_MD_fifo;
    wire 			full_HDR_fifo;
    wire 			full_HDR_MD_fifo;
    reg				wr_PARITY_fifo;
    reg		[1:0]	din_PARITY_fifo;
	wire			full_PARITY_fifo;
	logic			rd_PARITY_fifo;
	wire	[15:0]	dout_PARITY_fifo;
	wire			empty_PARITY_fifo;
	reg				end_flag;
	reg				start_flag;
	//wire	[127:0]	dout_rx_data_fifo;
    
    assign wr_HDR_fifo 		= ~empty_cmd_fifo & ~full_HDR_fifo & ~full_HDR_MD_fifo;
    assign wr_HDR_MD_fifo 	=  wr_HDR_fifo;
    assign rd_cmd_fifo 		=  wr_HDR_fifo;
    
    
    logic			sfi_hdr_parity;  
    logic			sfi_hdr_used_shared_crd;
    logic			sfi_hdr_has_data;
    //logic			sfi_hdr_doesnt_have_data;
    logic	[4:0]	sfi_hdr_vc_id;
    logic	[3:0]	sfi_hdr_size; //calculated according to table on page 123 of PCIe6 spec
    logic	[1:0]	sfi_hdr_fc_id;
    //logic	[1:0]	sfi_hdr_fc_id_p;
    //logic	[1:0]	sfi_hdr_fc_id_np;
    //logic	[1:0]	sfi_hdr_fc_id_c;
        
    //assign 	sfi_hdr_parity				= 1'b0;	//not supporting this parity bit for now
    assign	sfi_hdr_used_shared_crd 	= 1'b0;
    //assign	sfi_hdr_has_data 			= 1'b1;
    //assign	sfi_hdr_doesnt_have_data 	= 1'b0;
    assign  sfi_hdr_vc_id 				= 5'h00;
	//assign	sfi_hdr_fc_id				= 2'h0;
	//assign	sfi_hdr_fc_id_p				= 2'h0;
	//assign	sfi_hdr_fc_id_np			= 2'h1;
    //assign	sfi_hdr_fc_id_c				= 2'h2;
    
    logic	[31:0]	sfi_data_end;
    wire	[31:0]	sfi_data_end_active;
    logic	[31:0]	sfi_data_edb;
    logic	[31:0]	sfi_data_poison;
    logic	[15:0]	sfi_data_parity;
    logic			sfi_data_aux_parity;
    logic			sfi_data_used_shared_crd;
    logic	[4:0]	sfi_data_vc_id;
    logic	[1:0]	sfi_data_fc_id;
    logic	[9:0]	length;
    logic	[9:0]	length_2;
    logic	[9:0]	length_minus_one;
    

    assign	sfi_data_edb				= 32'h00000000;
    assign	sfi_data_poison				= 32'h00000000;
    //assign	sfi_data_aux_parity			= 1'h0;
    assign  sfi_data_end_active 		= end_flag ? sfi_data_end: 32'h0;
    assign	sfi_data_used_shared_crd 	= 1'b0;
    assign  sfi_data_vc_id 				= 5'h00;
    
    //{sfi_data_vc_id,sfi_data_used_shared_crd,sfi_data_fc_id} = data_info_byte 
    //sfi_data_edb, sfi_data_poison, sfi_data_used_shared_crd, sfi_data_vc_id are always 0
    //start_flag represents sfi_data_start field
    assign 	sfi_data_aux_parity = ^{start_flag,sfi_data_end_active,sfi_data_vc_id,sfi_data_used_shared_crd,sfi_data_fc_id,sfi_data_poison,sfi_data_edb}; 
    
    logic	[31:0]	pcie6_OHC_A1;
    logic	[31:0]	pcie6_OHC_A3;
    logic	[31:0]	pcie6_OHC_C;
        
    logic	[15:0]	pcie6_hdr_dest_bdf;
    logic	[9:0]	pcie6_hdr_reg_num;
    logic	[15:0]	pcie6_hdr_requestor_id;
    logic	[31:0]	pcie6_hdr_address;
    logic			pcie6_hdr_ep;
    logic	[13:0]	pcie6_hdr_tag;
    logic	[7:0]	pcie6_hdr_type;
    logic	[2:0]	pcie6_hdr_tc;
    logic	[4:0]	pcie6_hdr_ohc;
    logic	[2:0]	pcie6_hdr_ts;	//indicates the presence of TLP trailers
    logic	[2:0]	pcie6_hdr_attr;
    logic	[1:0]	pcie6_hdr_at; 	//For Memory Read, Memory Write, DMWr, and AtomicOp Requests, the Address Type (AT) field is encoded as shown in § Table 10-1. For all other Requests, the AT field is Reserved unless explicitly stated otherwise
    logic	[9:0]	pcie6_hdr_length;
    logic	[6:0]	pcie6_hdr_la;
    logic	[11:0]	pcie6_hdr_byte_count;
    logic	[15:0]	pcie6_hdr_completer_id;
    logic	[31:0]	vendor_defined_prefix;
    
    logic	[3:0]	pcie6_OHCA1_lbe;
    logic	[3:0]	pcie6_OHCA1_fbe;
    logic	[19:0]	pcie6_OHCA1_pasid;
    logic			pcie6_OHCA1_NW;		//The NW bit is No Write (NW), for Translation Requests only, and for otherwise Reserved
    logic			pcie6_OHCA1_PV;		//When OHC-A1 is included with a TLP, if the PASID is not known or has not been assigned, then the PV ("PASID Valid") bit must be Clear. The ER and PMR bits are Reserved if PV is Clear
    logic			pcie6_OHCA1_PMR; 	//the PMR bit is Privileged Mode Requested
    logic			pcie6_OHCA1_ER;  	//the ER bit is Execute Requested
    
    logic	[3:0]	pcie6_OHCA3_lbe;
    logic	[3:0]	pcie6_OHCA3_fbe;
    logic			pcie6_OHCA3_dsv;	//Destination Segment Valid Bit
    logic	[7:0]	pcie6_OHCA3_dest_seg;
    
	logic	[3:0]	pcie6_OHCC_sub_stream;
	logic			pcie6_OHCC_rsv;
	logic			pcie6_OHCC_k;
	logic			pcie6_OHCC_t;
	logic	[7:0]	pcie6_OHCC_stream_id;
	logic	[7:0]	pcie6_OHCC_pr_sent_counter;
	logic	[7:0]	pcie6_OHCC_requestor_segment;
	
	//vdp = vendor defined prefix
	logic	[3:0]	vdp_rs;
	logic			vdp_bcm;
	logic	[7:0]	vdp_sai;
	logic	[7:0]	vdp_srcid;
	assign	vdp_rs 		= 4'h0;
	assign	vdp_bcm 	= 1'h0;
    assign	vdp_sai 	= 8'h00;
	assign	vdp_srcid 	= 8'h00;
    
    //vendor_defined_prefix (prefix 0) is defined by spec (page 46 of sfi spec) as: {srcid[8b],sai[8b],bcm[1b],rs[4b],E[1b],N[1b],C[1b],8'h8e};
    //BCM_EN parameter: If set to 1, BCM field in prefix is Byte Count Modified, else is reserved
    //
    
    //paramaters for SN2SFI BRIDGE:
    //IOSF_ROUTE=0	(page 43 and 45 of sfi spec) If set to 0, Prefix 0 exists for all headers only if any of the other IOSF parameters are set. If set to 0 and Prefix 0 exists, byte 3 of Prefix 0 is reserved
    //BCM_EN=1	//IOSF_RS=1		//IOSF_SAI=1	//IOSF_ECRC_GEN, IOSF_ECRC_ERR=0	//IOSF_NFS_ERR=0	//IOSF_CHAIN=0	//
    assign	vendor_defined_prefix		= {vdp_srcid,vdp_sai,vdp_bcm,vdp_rs,1'b0,1'b0,1'b0,8'h8e};
    
    
  always @ (*)
begin
   case (dout_cmd_fifo[126:120])
      7'h04, 7'h05, 7'h44, 7'h45: 			//04: cfg rd type0.  05: cfg rd type1.  44: cfg wr type0.  45: cfg wr type0
		begin
           pcie6_hdr_ohc				<= 	5'h05;
           pcie6_hdr_type				<=  {1'b0,dout_cmd_fifo[126:120]};
           pcie6_hdr_tc					<=  3'h0;
           pcie6_hdr_length				<=  10'h001;
           pcie6_hdr_attr				<=  3'h0;
           pcie6_hdr_ts					<=  3'h0;
           pcie6_hdr_requestor_id		<=  dout_cmd_fifo[95:80];
           pcie6_hdr_tag				<=  {6'h0,dout_cmd_fifo[79:72]};
           pcie6_hdr_ep					<=  dout_cmd_fifo[110];
           pcie6_hdr_dest_bdf			<=  dout_cmd_fifo[64:48];
           pcie6_hdr_reg_num			<=  dout_cmd_fifo[43:34];
           pcie6_OHCA3_lbe				<=  4'h0;
		   pcie6_OHCA3_fbe				<=  dout_cmd_fifo[67:64];
		   pcie6_OHCA3_dsv				<=  1'b0;
		   pcie6_OHCA3_dest_seg			<=  8'h0;
       	   pcie6_OHCC_sub_stream		<=   'h0;
		   pcie6_OHCC_rsv				<=   'h0;
		   pcie6_OHCC_k					<=   'h0;
		   pcie6_OHCC_t					<=   'h0;
		   pcie6_OHCC_stream_id			<=   'h0;
		   pcie6_OHCC_pr_sent_counter	<=   'h0;
		   pcie6_OHCC_requestor_segment	<=   'h0;
           pcie6_OHC_A3					<=  {pcie6_OHCA3_lbe,pcie6_OHCA3_fbe,pcie6_OHCA3_dsv,7'h00,8'h00,pcie6_OHCA3_dest_seg};
           pcie6_OHC_C					<=  {pcie6_OHCC_sub_stream,pcie6_OHCC_rsv,1'b0,pcie6_OHCC_k,pcie6_OHCC_t,pcie6_OHCC_stream_id,pcie6_OHCC_pr_sent_counter,pcie6_OHCC_requestor_segment};
           din_HDR_fifo 				<=  {64'h0,pcie6_OHC_C,pcie6_OHC_A3,pcie6_hdr_reg_num[5:0],2'h0,4'h0,pcie6_hdr_reg_num[9:6],pcie6_hdr_dest_bdf[7:0],pcie6_hdr_dest_bdf[15:8],pcie6_hdr_tag[7:0],pcie6_hdr_ep,1'b0,pcie6_hdr_tag[13:8],pcie6_hdr_requestor_id[7:0],pcie6_hdr_requestor_id[15:8],pcie6_hdr_length[7:0],pcie6_hdr_ts,pcie6_hdr_attr,pcie6_hdr_length[9:8],pcie6_hdr_tc,pcie6_hdr_ohc,pcie6_hdr_type,vendor_defined_prefix};
           sfi_hdr_parity				<= HPARITY ? ^{din_HDR_fifo,sfi_hdr_has_data,sfi_hdr_used_shared_crd,sfi_hdr_vc_id,sfi_hdr_size,sfi_hdr_fc_id} : 1'b0;	
           sfi_hdr_size					<= 	4'h6;	//1DW for vendor defined prefix. 3DW for header of configuration transactions. 2DW for OHC's
           sfi_hdr_fc_id				<=  2'b01;
			case (dout_cmd_fifo[126:120])
				7'h04, 7'h05: 				//04: cfg rd type0.  05: cfg rd type1
				sfi_hdr_has_data		<= 1'b0;
				7'h44, 7'h45: 				//44: cfg wr type0.  45: cfg wr type0
				sfi_hdr_has_data		<= 1'b1;
			endcase
			din_HDR_MD_fifo 		<=  {'b0,sfi_hdr_parity,sfi_hdr_has_data,sfi_hdr_used_shared_crd,sfi_hdr_vc_id,sfi_hdr_size,2'b00,sfi_hdr_fc_id};
        end
      7'h00, 7'h01, 7'h40: 			//00: mem rd 32b.  01: mem rd locked 32b.  40: mem wr 32b.  
		begin
           pcie6_hdr_ohc				<= 	5'h01;// only OHC-A1
           pcie6_hdr_tc					<=  dout_cmd_fifo[118:116];
           pcie6_hdr_length				<=  dout_cmd_fifo[105:96];
           pcie6_hdr_attr				<=  {1'b0,dout_cmd_fifo[109:108]};
           pcie6_hdr_ts					<=  3'h0;//as far as i understand from pcie6 spec (pages 130-131) we dont need here ts
           pcie6_hdr_requestor_id		<=  dout_cmd_fifo[95:80];
           pcie6_hdr_tag				<=  {6'h0,dout_cmd_fifo[79:72]};
           pcie6_hdr_ep					<=  dout_cmd_fifo[110];
           pcie6_hdr_address			<=  {dout_cmd_fifo[63:34],2'b0};
           pcie6_hdr_at					<=  2'b00;		//For Memory Read, Memory Write, DMWr, and AtomicOp Requests, the Address Type (AT) field is encoded as shown in § Table 10-1. For all other Requests, the AT field is Reserved unless explicitly stated otherwise		00=untranslated
           //pcie6_hdr_dest_bdf			<=  dout_cmd_fifo[64:48];
           //pcie6_hdr_reg_num			<=  dout_cmd_fifo[43:34];
           pcie6_OHCA1_lbe				<=  dout_cmd_fifo[71:68];
		   pcie6_OHCA1_fbe				<=  dout_cmd_fifo[67:64];
		   pcie6_OHCA1_pasid			<=  20'h0;	//i don't see where i can take this value on the desc transaction
		   pcie6_OHCA1_NW				<= 1'b0;		//The NW bit is No Write (NW), for Translation Requests only, and for otherwise Reserved
		   pcie6_OHCA1_PV				<= 1'b0;		//When OHC-A1 is included with a TLP, if the PASID is not known or has not been assigned, then the PV ("PASID Valid") bit must be Clear. The ER and PMR bits are Reserved if PV is Clear
		   pcie6_OHCA1_PMR				<= 1'b0;		//the PMR bit is Privileged Mode Requested
		   pcie6_OHCA1_ER				<= 1'b0;  		//the ER bit is Execute Requested
           pcie6_OHC_A1					<=  {pcie6_OHCA1_lbe,pcie6_OHCA1_fbe,pcie6_OHCA1_pasid[7:0],pcie6_OHCA1_pasid[15:8],pcie6_OHCA1_NW,pcie6_OHCA1_PV,pcie6_OHCA1_PMR,pcie6_OHCA1_ER,pcie6_OHCA1_pasid[19:16]};
           /*pcie6_OHCA3_lbe				<=  4'h0;
		   pcie6_OHCA3_fbe				<=  dout_cmd_fifo[67:64];
		   pcie6_OHCA3_dsv				<=  1'b0;
		   pcie6_OHCA3_dest_seg			<=  8'h0;
       	   pcie6_OHCC_sub_stream		<=   'h0;
		   pcie6_OHCC_rsv				<=   'h0;
		   pcie6_OHCC_k					<=   'h0;
		   pcie6_OHCC_t					<=   'h0;
		   pcie6_OHCC_stream_id			<=   'h0;
		   pcie6_OHCC_pr_sent_counter	<=   'h0;
		   pcie6_OHCC_requestor_segment	<=   'h0;
           pcie6_OHC_A3					<=  {pcie6_OHCA3_lbe,pcie6_OHCA3_fbe,pcie6_OHCA3_dsv,7'h00,8'h00,pcie6_OHCA3_dest_seg};
           pcie6_OHC_C					<=  {pcie6_OHCC_sub_stream,pcie6_OHCC_rsv,1'b0,pcie6_OHCC_k,pcie6_OHCC_t,pcie6_OHCC_stream_id,pcie6_OHCC_pr_sent_counter,pcie6_OHCC_requestor_segment};*/
           din_HDR_fifo 				<=  {96'h0/*,pcie6_OHC_C*/,pcie6_OHC_A1,pcie6_hdr_address[7:2],pcie6_hdr_at,pcie6_hdr_address[15:8],pcie6_hdr_address[23:16],pcie6_hdr_address[31:24],pcie6_hdr_tag[7:0],pcie6_hdr_ep,1'b0,pcie6_hdr_tag[13:8],pcie6_hdr_requestor_id[7:0],pcie6_hdr_requestor_id[15:8],pcie6_hdr_length[7:0],pcie6_hdr_ts,pcie6_hdr_attr,pcie6_hdr_length[9:8],pcie6_hdr_tc,pcie6_hdr_ohc,pcie6_hdr_type,vendor_defined_prefix};
           sfi_hdr_parity				<= HPARITY ? ^{din_HDR_fifo,sfi_hdr_has_data,sfi_hdr_used_shared_crd,sfi_hdr_vc_id,sfi_hdr_size,sfi_hdr_fc_id} : 1'b0;	
           sfi_hdr_size					<= 	4'h5;	//1DW for vendor defined prefix. 3DW for header of configuration transactions. 1DW for OHC (OHC-A1)
			case (dout_cmd_fifo[126:120])
				7'h00: 						// 00: mem rd 32b 
				begin
				sfi_hdr_has_data		<= 1'b0;
				sfi_hdr_fc_id			<= 2'b01;
				pcie6_hdr_type			<= 8'h03;
				end
				7'h01: 						// 01: mem rd locked 32b
				begin
				sfi_hdr_has_data		<= 1'b0;
				sfi_hdr_fc_id			<= 2'b01;
				pcie6_hdr_type			<= 8'h01;
				end
				7'h40: 						// 40: mem wr 32b
				begin
				sfi_hdr_has_data		<= 1'b1;
				sfi_hdr_fc_id			<= 2'b00;
				pcie6_hdr_type			<= 8'h40;
				end
			endcase
			din_HDR_MD_fifo 		<=  {'b0,sfi_hdr_parity,sfi_hdr_has_data,sfi_hdr_used_shared_crd,sfi_hdr_vc_id,sfi_hdr_size,2'b00,sfi_hdr_fc_id};
        end  
      7'h0a, 7'h4a: 						//0a: cpl W/O data.		4a:  cpl with data		//NOT VALIDETD YET
		begin
           pcie6_hdr_ohc				<= 	5'h05;
           pcie6_hdr_type				<=  8'h0a;
           pcie6_hdr_tc					<=  dout_cmd_fifo[118:116];
           pcie6_hdr_length				<=  dout_cmd_fifo[105:96];
           pcie6_hdr_attr				<=  dout_cmd_fifo[109:108];
           pcie6_hdr_ts					<=  3'h0;
           din_HDR_fifo 				<=  {128'h0,pcie6_hdr_byte_count[7:0],pcie6_hdr_la[5:2],pcie6_hdr_byte_count[11:8],pcie6_hdr_dest_bdf[7:0],pcie6_hdr_dest_bdf[15:8],pcie6_hdr_tag[7:0],pcie6_hdr_ep,pcie6_hdr_la[6],pcie6_hdr_tag[13:8],pcie6_hdr_completer_id[7:0],pcie6_hdr_completer_id[15:8],pcie6_hdr_length[7:0],pcie6_hdr_ts,pcie6_hdr_attr,pcie6_hdr_length[9:8],pcie6_hdr_tc,pcie6_hdr_ohc,pcie6_hdr_type,vendor_defined_prefix};
           sfi_hdr_size					<= 	4'h3;
			case (dout_cmd_fifo[126:120])
				7'h0a:						//0a: cpl W/O data
				begin
				sfi_hdr_has_data		<= 1'b0;
				sfi_hdr_fc_id			<= 2'b10;
				din_HDR_MD_fifo 		<=  {'b0,sfi_hdr_parity,sfi_hdr_has_data,sfi_hdr_used_shared_crd,sfi_hdr_vc_id,sfi_hdr_size,2'b00,sfi_hdr_fc_id};
				end
				7'h4a:						//4a:  cpl with data
				begin
				sfi_hdr_has_data		<= 1'b1;
				sfi_hdr_fc_id			<= 2'b10;
				din_HDR_MD_fifo 		<=  {'b0,sfi_hdr_parity,sfi_hdr_has_data,sfi_hdr_used_shared_crd,sfi_hdr_vc_id,sfi_hdr_size,2'b00,sfi_hdr_fc_id};
				end
			endcase
        end
      default:
		begin
           pcie6_hdr_ohc				<= 	5'h05;
           pcie6_hdr_type				<=  8'h45;
           pcie6_hdr_tc					<=  3'h0;
           pcie6_hdr_length				<=  dout_cmd_fifo[105:96];
           din_HDR_fifo 				<=  'h0;//din_HDR_fifo;
           sfi_hdr_size					<= 	4'h3;
           sfi_hdr_has_data				<=  1'b1;
		   sfi_hdr_fc_id				<=  2'b10;
           din_HDR_MD_fifo 				<=  {'b0,sfi_hdr_parity,sfi_hdr_has_data,sfi_hdr_used_shared_crd,sfi_hdr_vc_id,sfi_hdr_size,2'b00,sfi_hdr_fc_id};
        end
   endcase 
end

	assign length			= dout_type_and_length_fifo[9:0];
	
	generate if (D==128) begin : length_128
	
	always @(*) begin
    if (length == 0)
        sfi_data_end = 32'b0;
    else if (length[4:0] == 5'h00)
		sfi_data_end = 32'h80000000;
    else
        sfi_data_end = 32'b1 << (length[4:0] - 1);
	end
	
end else begin : length_64

always @(*) begin
    if (length == 0)
        sfi_data_end = 32'b0;
    else if (length[3:0] == 4'h00)
		sfi_data_end = 32'h00008000;
    else
        sfi_data_end = 32'b1 << (length[3:0] - 1);
	end
	
end 
endgenerate	

always @ (*)
begin
   case (dout_type_and_length_fifo[16:10])
      7'h40, 7'h60: 															// 40: mem wr 32b	60: mem wr 64b
			sfi_data_fc_id	<= 	2'h0;
	  7'h00, 7'h01, 7'h02, 7'h04, 7'h05, 7'h20,  7'h21, 7'h42, 7'h44,  7'h45 : 	// 00: mem rd 32b  01: mem rd locked 32b  02: i/o read   04: cfg rd type0.  05: cfg rd type1.  20: mem rd 64b  21: mem rd locked 64b  42: i/o wr 44: cfg wr type0.  45: cfg wr type0
			sfi_data_fc_id	<= 	2'h1;
      7'h0a, 7'h0b, 7'h4a, 7'h4b: 												// 0a: cpl W/O data   0b: cpl locked W/O data   4a: cpl with data    4b:cpl locked with data
			sfi_data_fc_id	<= 	2'h2;
      default:
			sfi_data_fc_id	<= 	2'h1;
   endcase 
end  
    
    generate if (D==128) begin : parity_128
 
    
    generic_async_fifo #(      
             .WRITE_WIDTH 		(2),
             .READ_WIDTH  		(16),
             .NUM_BITS    		(16*64),
             .AFULL_THRESHOLD 	(16*60)
                       )
    fifo_2_to_16_fwft_PARITY (

   .wr_clk        (clk),
   .wr_rst_n      (rst_n),
   .wr_en         (wr_PARITY_fifo),
   .wr_data       (din_PARITY_fifo),
   .wr_full       (),
   .wr_afull      (full_PARITY_fifo),
   .wr_occupancy  (),
   .wr_overflow   (),
   .rd_clk        (clk),
   .rd_rst_n      (rst_n),
   .rd_en         (rd_PARITY_fifo),
   .rd_data       (dout_PARITY_fifo),
   .rd_empty      (empty_PARITY_fifo),
   .rd_occupancy  (),
   .rd_underflow  ()

);

assign sfi_data_parity = {dout_PARITY_fifo[1:0],dout_PARITY_fifo[3:2],dout_PARITY_fifo[5:4],dout_PARITY_fifo[7:6],dout_PARITY_fifo[9:8],dout_PARITY_fifo[11:10],dout_PARITY_fifo[13:12],dout_PARITY_fifo[15:14]};

end else begin :parity_64


  generic_async_fifo #(      
             .WRITE_WIDTH 		(2),
             .READ_WIDTH  		(8),
             .NUM_BITS    		(8*64),
             .AFULL_THRESHOLD 	(8*60)
                       )
    fifo_2_to_8_fwft_PARITY (

   .wr_clk        (clk),
   .wr_rst_n      (rst_n),
   .wr_en         (wr_PARITY_fifo),
   .wr_data       (din_PARITY_fifo),
   .wr_full       (),
   .wr_afull      (full_PARITY_fifo),
   .wr_occupancy  (),
   .wr_overflow   (),
   .rd_clk        (clk),
   .rd_rst_n      (rst_n),
   .rd_en         (rd_PARITY_fifo),
   .rd_data       (dout_PARITY_fifo[7:0]),
   .rd_empty      (empty_PARITY_fifo),
   .rd_occupancy  (),
   .rd_underflow  ()

);


assign sfi_data_parity = {8'h0,dout_PARITY_fifo[1:0],dout_PARITY_fifo[3:2],dout_PARITY_fifo[5:4],dout_PARITY_fifo[7:6]};

end 
endgenerate
    
    //signals
   parameter  IDLE         				= 2'b00;
   parameter  REST						= 2'b01; 
   parameter  WRITE_MULTI_DATA_MD		= 2'b10; 
   
  reg 	[1:0] 	current_state;
  reg	[4:0]	counter;
  reg			multi_flag;
  
   always @ (posedge clk or negedge rst_n)
   begin
   if (rst_n == 1'b0) begin //  Asynchronous reset
		current_state 					<= IDLE;
		counter							<= 5'h00;
		multi_flag						<= 1'b0;
		end_flag						<= 1'b0;
		start_flag						<= 1'b0;
		din_DATA_MD_fifo				<=  'b0;
		wr_DATA_MD_fifo					<= 1'b0;
		rd_type_and_length_fifo			<= 1'b0;
		rd_PARITY_fifo					<= 1'b0;
    end
   else begin
      case(current_state) 
		IDLE:
     begin 
        if (~empty_type_and_length_fifo & ~empty_PARITY_fifo & ~full_DATA_MD_fifo & (dout_type_and_length_fifo[9:0]<=10'd32)) begin
				current_state 						<= REST;  
				wr_DATA_MD_fifo						<= 1'b1;
				end_flag							<= 1'b1;
				start_flag							<= 1'b1;
				din_DATA_MD_fifo					<= {54'h0,sfi_data_end[31:16],2'h0,sfi_data_edb[31:16],sfi_data_poison[31:16],16'h0,sfi_data_parity[15:8],54'h0,sfi_data_end[15:0],1'b1,sfi_data_aux_parity,sfi_data_edb[15:0],sfi_data_poison[15:0],8'h0,sfi_data_vc_id,sfi_data_used_shared_crd,sfi_data_fc_id,sfi_data_parity[7:0]};
				rd_type_and_length_fifo				<= 1'b1;					
				rd_PARITY_fifo						<= 1'b1;
        end else if (~empty_type_and_length_fifo & ~empty_PARITY_fifo & ~full_DATA_MD_fifo & (dout_type_and_length_fifo[9:0]>10'd32)) begin
				current_state 						<= REST;  
				counter								<= dout_type_and_length_fifo[9:5] + |dout_type_and_length_fifo[4:0] -1;
				multi_flag							<= 1'b1;
				wr_DATA_MD_fifo						<= 1'b1;
				end_flag							<= 1'b0;
				start_flag							<= 1'b1;
				din_DATA_MD_fifo					<= {54'h0,16'h0,2'h0,sfi_data_edb[31:16],sfi_data_poison[31:16],16'h0,sfi_data_parity[15:8],54'h0,16'h0,1'b1,sfi_data_aux_parity,sfi_data_edb[15:0],sfi_data_poison[15:0],8'h0,sfi_data_vc_id,sfi_data_used_shared_crd,sfi_data_fc_id,sfi_data_parity[7:0]};
				rd_type_and_length_fifo				<= 1'b0;					
				rd_PARITY_fifo						<= 1'b1;
		 end else if ((D==64) & ~empty_type_and_length_fifo & ~empty_PARITY_fifo & ~full_DATA_MD_fifo & (dout_type_and_length_fifo[9:0]<=10'd16)) begin
				current_state 						<= REST;  
				wr_DATA_MD_fifo						<= 1'b1;
				end_flag							<= 1'b1;
				start_flag							<= 1'b1;
				din_DATA_MD_fifo					<= {128'h0,54'h0,sfi_data_end[15:0],1'b1,sfi_data_aux_parity,sfi_data_edb[15:0],sfi_data_poison[15:0],8'h0,sfi_data_vc_id,sfi_data_used_shared_crd,sfi_data_fc_id,sfi_data_parity[7:0]};
				rd_type_and_length_fifo				<= 1'b1;					
				rd_PARITY_fifo						<= 1'b1;
        end else if ((D==64) & ~empty_type_and_length_fifo & ~empty_PARITY_fifo & ~full_DATA_MD_fifo & (dout_type_and_length_fifo[9:0]>10'd16)) begin
				current_state 						<= REST;  
				counter								<= dout_type_and_length_fifo[9:4] + |dout_type_and_length_fifo[3:0] -1;
				multi_flag							<= 1'b1;
				wr_DATA_MD_fifo						<= 1'b1;
				end_flag							<= 1'b0;
				start_flag							<= 1'b1;
				din_DATA_MD_fifo					<= {128'h0,54'h0,16'h0,1'b1,sfi_data_aux_parity,sfi_data_edb[15:0],sfi_data_poison[15:0],8'h0,sfi_data_vc_id,sfi_data_used_shared_crd,sfi_data_fc_id,sfi_data_parity[7:0]};
				rd_type_and_length_fifo				<= 1'b0;					
				rd_PARITY_fifo						<= 1'b1;
		 end else begin
				current_state 						<= IDLE; 
				wr_DATA_MD_fifo						<= 1'b0;					
				rd_type_and_length_fifo				<= 1'b0;
				rd_PARITY_fifo						<= 1'b0;					
	     end
     end
        
		REST:	
   begin
		if (multi_flag==1'b1) begin
				current_state 						<= WRITE_MULTI_DATA_MD;  
				counter								<= counter;
				wr_DATA_MD_fifo						<= 1'b0;
				din_DATA_MD_fifo					<= din_DATA_MD_fifo;
				rd_type_and_length_fifo				<= 1'b0;					
				rd_PARITY_fifo						<= 1'b0;
		end else begin
				current_state 						<= IDLE;
				wr_DATA_MD_fifo						<= 1'b0;					
				rd_type_and_length_fifo				<= 1'b0;
				rd_PARITY_fifo						<= 1'b0;					
				end
   end
   
		WRITE_MULTI_DATA_MD:  
   begin
		if (counter > 1 & ~empty_PARITY_fifo & ~full_DATA_MD_fifo) begin
				current_state 						<= REST;  
				counter								<= counter-1;
				wr_DATA_MD_fifo						<= 1'b1;
				end_flag							<= 1'b0;
				start_flag							<= 1'b0;
				din_DATA_MD_fifo					<= {54'h0,16'h0,2'h0,sfi_data_edb[31:16],sfi_data_poison[31:16],16'h0,sfi_data_parity[15:8],54'h0,16'h0,1'b0,sfi_data_aux_parity,sfi_data_edb[15:0],sfi_data_poison[15:0],8'h0,sfi_data_vc_id,sfi_data_used_shared_crd,sfi_data_fc_id,sfi_data_parity[7:0]};
				rd_type_and_length_fifo				<= 1'b0;					
				rd_PARITY_fifo						<= 1'b1;
		end else if (counter == 1 & ~empty_PARITY_fifo & ~full_DATA_MD_fifo) begin
				current_state 						<= REST;  
				counter								<= counter-1;
				multi_flag							<= 1'b0;
				wr_DATA_MD_fifo						<= 1'b1;
				end_flag							<= 1'b1;
				start_flag							<= 1'b0;
				din_DATA_MD_fifo					<= {54'h0,sfi_data_end[31:16],2'h0,sfi_data_edb[31:16],sfi_data_poison[31:16],16'h0,sfi_data_parity[15:8],54'h0,sfi_data_end[15:0],1'b0,sfi_data_aux_parity,sfi_data_edb[15:0],sfi_data_poison[15:0],8'h0,sfi_data_vc_id,sfi_data_used_shared_crd,sfi_data_fc_id,sfi_data_parity[7:0]};
				rd_type_and_length_fifo				<= 1'b1;					
				rd_PARITY_fifo						<= 1'b1;
		end else if ((D==64) & counter > 1 & ~empty_PARITY_fifo & ~full_DATA_MD_fifo) begin
				current_state 						<= REST;  
				counter								<= counter-1;
				wr_DATA_MD_fifo						<= 1'b1;
				end_flag							<= 1'b0;
				start_flag							<= 1'b0;
				din_DATA_MD_fifo					<= {128'h0,54'h0,16'h0,1'b0,sfi_data_aux_parity,sfi_data_edb[15:0],sfi_data_poison[15:0],8'h0,sfi_data_vc_id,sfi_data_used_shared_crd,sfi_data_fc_id,sfi_data_parity[7:0]};
				rd_type_and_length_fifo				<= 1'b0;					
				rd_PARITY_fifo						<= 1'b1;
		end else if ((D==64) & counter == 1 & ~empty_PARITY_fifo & ~full_DATA_MD_fifo) begin
				current_state 						<= REST;  
				counter								<= counter-1;
				multi_flag							<= 1'b0;
				wr_DATA_MD_fifo						<= 1'b1;
				end_flag							<= 1'b1;
				start_flag							<= 1'b0;
				din_DATA_MD_fifo					<= {128'h0,54'h0,sfi_data_end[15:0],1'b0,sfi_data_aux_parity,sfi_data_edb[15:0],sfi_data_poison[15:0],8'h0,sfi_data_vc_id,sfi_data_used_shared_crd,sfi_data_fc_id,sfi_data_parity[7:0]};
				rd_type_and_length_fifo				<= 1'b1;					
				rd_PARITY_fifo						<= 1'b1;
		end else begin
				current_state 						<= WRITE_MULTI_DATA_MD; 
				counter								<= counter;
				din_DATA_MD_fifo					<= din_DATA_MD_fifo;
				wr_DATA_MD_fifo						<= 1'b0;					
				rd_type_and_length_fifo				<= 1'b0;
				rd_PARITY_fifo						<= 1'b0;
		end
   end
     
     
  default:
     current_state  <= IDLE;
     endcase
   end  
   end 
    
    assign length_2			= dout_length_fifo[9:0];
	
	always @(*) begin
    if (length_2 == 0)
        length_minus_one = 10'h0;
    else 
        length_minus_one = (length_2 - 1);
	end
    
        //signals
   parameter  IDLE_2       		= 2'b00;
   parameter  READ_DATA			= 2'b01; 
   parameter  REST_2			= 2'b10; 
   parameter  ZERO_PADDING		= 2'b11; 
   
	reg 	[1:0] 	current_state_2;
	reg		[9:0]	reads_of_64;
	reg				odd_even;
	reg		[2:0]	zero_padding_counter;
	reg				half_flag;
	
   always @ (posedge clk or negedge rst_n)
   begin
   if (rst_n == 1'b0) begin //  Asynchronous reset
		current_state_2 					<= IDLE_2;
		reads_of_64							<= 10'h0;
		odd_even							<= 1'b0;
		zero_padding_counter				<= 3'h0;
		half_flag							<= 1'b0;
		wr_PARITY_fifo						<= 1'b0;
		din_PARITY_fifo						<= 2'h0;
		din_DATA_fifo						<=  'b0;
		wr_DATA_fifo						<= 1'b0;
		rd_length_fifo						<= 1'b0;
		rd_data_fifo						<= 1'b0;
    end
   else begin
      case(current_state_2) 
		IDLE_2:
     begin 
        if (~empty_length_fifo) begin
				current_state_2 				<= READ_DATA;  
				reads_of_64						<= dout_length_fifo[9:1] + dout_length_fifo[0];		//according to length field (which is by DW's) we calculate how many reads of 64b will we need to read all real data from higher level fifo
				odd_even						<= dout_length_fifo[0];
				zero_padding_counter			<= (D==128) ? ~(length_minus_one[4:2]) : {1'b0,~(length_minus_one[3:2])};
				wr_DATA_fifo					<= 1'b0;
				wr_PARITY_fifo					<= 1'b0;
				rd_length_fifo					<= 1'b1;
				rd_data_fifo					<= 1'b0;
			end else begin
				current_state_2 				<= IDLE_2; 
				wr_DATA_fifo					<= 1'b0;
				rd_length_fifo					<= 1'b0;
				rd_data_fifo					<= 1'b0;
				wr_PARITY_fifo					<= 1'b0;					
	     end
     end
        
		READ_DATA:	
   begin
		if (~empty_data_fifo & (reads_of_64 == 1) & ~half_flag) begin
				if (odd_even) begin
				din_DATA_fifo[63:0]				<= {32'h0,dout_data_fifo[31:0]};
				din_PARITY_fifo[0]				<= ^dout_data_fifo[31:0];
				end else begin
				din_DATA_fifo[63:0]				<= dout_data_fifo;
				din_PARITY_fifo[0]				<= ^dout_data_fifo;
				end
				current_state_2 				<= READ_DATA;  
				reads_of_64						<= reads_of_64 -1;
				half_flag						<= ~half_flag;
				wr_PARITY_fifo					<= 1'b0;			
				wr_DATA_fifo					<= 1'b0;
				rd_length_fifo					<= 1'b0;
				rd_data_fifo					<= 1'b1;
		end else if (~empty_data_fifo & (reads_of_64 == 1) & half_flag & ~full_PARITY_fifo & ~full_DATA_fifo) begin
				if (zero_padding_counter>0) begin
				current_state_2 				<= ZERO_PADDING;
				end else begin
				current_state_2 				<= IDLE_2;
				end
				if (odd_even) begin
				din_DATA_fifo[127:64]			<= {32'h0,dout_data_fifo[31:0]};
				din_PARITY_fifo[1]				<= ^dout_data_fifo[31:0];
				end else begin
				din_DATA_fifo[127:64]			<= dout_data_fifo;
				din_PARITY_fifo[1]				<= ^dout_data_fifo;
				end
				reads_of_64						<= reads_of_64 -1;
				half_flag						<= 1'b0;
				wr_PARITY_fifo					<= 1'b1;
				wr_DATA_fifo					<= 1'b1;
				rd_length_fifo					<= 1'b0;
				rd_data_fifo					<= 1'b1;
		end else if (~empty_data_fifo & (reads_of_64 > 1) & ~half_flag) begin
				current_state_2 				<= REST_2;  
				reads_of_64						<= reads_of_64 -1;
				half_flag						<= ~half_flag;
				din_DATA_fifo[63:0]				<= dout_data_fifo;
				din_PARITY_fifo[0]				<= ^dout_data_fifo;
				wr_PARITY_fifo					<= 1'b0;
				wr_DATA_fifo					<= 1'b0;
				rd_length_fifo					<= 1'b0;
				rd_data_fifo					<= 1'b1;
		end	else if (~empty_data_fifo & (reads_of_64 > 1) & half_flag & ~full_PARITY_fifo & ~full_DATA_fifo) begin
				current_state_2 				<= REST_2;  
				reads_of_64						<= reads_of_64 -1;
				half_flag						<= ~half_flag;
				din_DATA_fifo[127:64]			<= dout_data_fifo;
				din_PARITY_fifo[1]				<= ^dout_data_fifo;
				wr_PARITY_fifo					<= 1'b1;
				wr_DATA_fifo					<= 1'b1;
				rd_length_fifo					<= 1'b0;
				rd_data_fifo					<= 1'b1;
		end else if ((reads_of_64 == 0) & half_flag & ~full_PARITY_fifo & ~full_DATA_fifo) begin
				if (zero_padding_counter>0) begin
				current_state_2 				<= ZERO_PADDING;
				end else begin
				current_state_2 				<= IDLE_2;
				end
				reads_of_64						<= reads_of_64;
				half_flag						<= 1'b0;
				din_DATA_fifo[127:64]			<= 64'h0;
				din_PARITY_fifo[1]				<= 1'b0;
				wr_PARITY_fifo					<= 1'b1;
				wr_DATA_fifo					<= 1'b1;
				rd_length_fifo					<= 1'b0;
				rd_data_fifo					<= 1'b0;
		end else begin
				current_state_2 				<= READ_DATA;
				half_flag						<= half_flag;
				wr_DATA_fifo					<= 1'b0;
				wr_PARITY_fifo					<= 1'b0;
				rd_length_fifo					<= 1'b0;
				rd_data_fifo					<= 1'b0;					
			end
   end
   
   REST_2:	
   begin
				current_state_2 				<= READ_DATA;
				wr_DATA_fifo					<= 1'b0;
				wr_PARITY_fifo					<= 1'b0;
				rd_length_fifo					<= 1'b0;
				rd_data_fifo					<= 1'b0;					
   end
   
		ZERO_PADDING:  
   begin
		if (zero_padding_counter > 1 & ~full_PARITY_fifo & ~full_DATA_fifo) begin
				current_state_2					<= ZERO_PADDING; 
				zero_padding_counter			<= zero_padding_counter -1; 
				rd_data_fifo					<= 1'b0;
				wr_DATA_fifo					<= 1'b1;
				din_DATA_fifo[127:0]			<= 128'h0;
				wr_PARITY_fifo					<= 1'b1;
				din_PARITY_fifo					<= 2'b00;

		end else if (zero_padding_counter == 1 & ~full_PARITY_fifo & ~full_DATA_fifo) begin
				current_state_2 				<= IDLE_2;  
				rd_data_fifo					<= 1'b0;
				wr_DATA_fifo					<= 1'b1;
				din_DATA_fifo[127:0]			<= 128'h0;
				wr_PARITY_fifo					<= 1'b1;
				din_PARITY_fifo					<= 2'b00;
		end else begin
				current_state_2 				<= ZERO_PADDING; 
				zero_padding_counter			<= zero_padding_counter;
				rd_data_fifo					<= 1'b0;
				wr_DATA_fifo					<= 1'b0;
				din_DATA_fifo[127:0]			<= 128'h0;
				wr_PARITY_fifo					<= 1'b0;
				din_PARITY_fifo					<= 2'b00;
		end
   end
     
     
  default:
     current_state_2  <= IDLE_2;
     endcase
   end  
   end 
    
    
    

   

generic_async_fifo #(      
             .WRITE_WIDTH 		(128),
             .READ_WIDTH  		(128),
             .NUM_BITS    		(128*32),
             .AFULL_THRESHOLD	(128*28)
                       )
    fifo_64_to_128_fwft_DATA (

   .wr_clk        (clk),
   .wr_rst_n      (rst_n),
   .wr_en         (wr_DATA_fifo),
   .wr_data       (din_DATA_fifo),
   .wr_full       (),
   .wr_afull      (full_DATA_fifo),
   .wr_occupancy  (),
   .wr_overflow   (),
   .rd_clk        (clk),
   .rd_rst_n      (rst_n),
   .rd_en         (rd_rx_fifo[0]),
   .rd_data       (dout_rx_fifo[0]),
   .rd_empty      (empty_rx_fifo[0]),
   .rd_occupancy  (),
   .rd_underflow  ()

);

//assign dout_rx_fifo[0] = {dout_rx_data_fifo[63:0],dout_rx_data_fifo[127:64]};
 
 
 generate if (D==128) begin : data_md_128
  
generic_async_fifo #(      
             .WRITE_WIDTH 		(256),
             .READ_WIDTH  		(128),
             .NUM_BITS    		(128*64),
             .AFULL_THRESHOLD 	(128*60)
                       )
    fifo_256_to_128_fwft_DATA_MD (

   .wr_clk        (clk),
   .wr_rst_n      (rst_n),
   .wr_en         (wr_DATA_MD_fifo),
   .wr_data       ({din_DATA_MD_fifo[127:0],din_DATA_MD_fifo[255:128]}),
   .wr_full       (),
   .wr_afull	  (full_DATA_MD_fifo),
   .wr_occupancy  (),
   .wr_overflow   (),
   .rd_clk        (clk),
   .rd_rst_n      (rst_n),
   .rd_en         (rd_rx_fifo[1]),
   .rd_data       (dout_rx_fifo[1]),
   .rd_empty      (empty_rx_fifo[1]),
   .rd_occupancy  (),
   .rd_underflow  ()

);

end else begin :data_md_64

generic_async_fifo #(      
             .WRITE_WIDTH 		(128),
             .READ_WIDTH  		(128),
             .NUM_BITS    		(128*64),
             .AFULL_THRESHOLD 	(128*60)
                       )
    fifo_128_to_128_fwft_DATA_MD (

   .wr_clk        (clk),
   .wr_rst_n      (rst_n),
   .wr_en         (wr_DATA_MD_fifo),
   .wr_data       (din_DATA_MD_fifo[127:0]),
   .wr_full       (),
   .wr_afull	  (full_DATA_MD_fifo),
   .wr_occupancy  (),
   .wr_overflow   (),
   .rd_clk        (clk),
   .rd_rst_n      (rst_n),
   .rd_en         (rd_rx_fifo[1]),
   .rd_data       (dout_rx_fifo[1]),
   .rd_empty      (empty_rx_fifo[1]),
   .rd_occupancy  (),
   .rd_underflow  ()

);

end
endgenerate


generic_async_fifo #(      
             .WRITE_WIDTH (256),
             .READ_WIDTH  (128),
             .NUM_BITS    (128*32) 
                       )
    fifo_256_to_128_fwft_HDR (

   .wr_clk        (clk),
   .wr_rst_n      (rst_n),
   .wr_en         (wr_HDR_fifo),
   .wr_data       ({din_HDR_fifo[127:0],din_HDR_fifo[255:128]}),//din_HDR_fifo),
   .wr_full       (full_HDR_fifo),
   .wr_occupancy  (),
   .wr_overflow   (),
   .rd_clk        (clk),
   .rd_rst_n      (rst_n),
   .rd_en         (rd_rx_fifo[2]),
   .rd_data       (dout_rx_fifo[2]),
   .rd_empty      (empty_rx_fifo[2]),
   .rd_occupancy  (),
   .rd_underflow  ()

);

generic_async_fifo #(      
             .WRITE_WIDTH (128),
             .READ_WIDTH  (128),
             .NUM_BITS    (128*64) 
                       )
    fifo_128_to_128_fwft_HDR_MD (

   .wr_clk        (clk),
   .wr_rst_n      (rst_n),
   .wr_en         (wr_HDR_MD_fifo),
   .wr_data       (din_HDR_MD_fifo),
   .wr_full       (full_HDR_MD_fifo),
   .wr_occupancy  (),
   .wr_overflow   (),
   .rd_clk        (clk),
   .rd_rst_n      (rst_n),
   .rd_en         (rd_rx_fifo[3]),
   .rd_data       (dout_rx_fifo[3]),
   .rd_empty      (empty_rx_fifo[3]),
   .rd_occupancy  (),
   .rd_underflow  ()

);



endmodule
