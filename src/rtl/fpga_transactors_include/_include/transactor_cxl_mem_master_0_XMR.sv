////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////  USER SHOULDN'T TOUCH THE FOLLOWING LINES  ////////////    USER SHOULDN'T TOUCH THE NEXT FOLLOWING LINES        ///////////////////////////////////////////////////////////////////////////////////
	
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
					
wire [255:0] s2m_drs_data_0;
wire [3:0]   s2m_drs_data_parity_0;
wire [9:0]   s2m_drs_ecc_0;
wire         s2m_drs_eccvalid_0;
wire [1:0]   s2m_drs_metafield_0;
wire [1:0]   s2m_drs_metavalue_0;
wire [2:0]   s2m_drs_opcode_0;
wire [2:0]   s2m_drs_pcls_0;
wire         s2m_drs_poison_0;
wire [6:0]   s2m_drs_pre_0;   
wire [9:0]   s2m_drs_spare_0;
wire [15:0]  s2m_drs_tag_0; 
wire         s2m_drs_valid_0;  							

wire [1:0]   s2m_ndr_metafield_0;
wire [1:0]   s2m_ndr_metavalue_0;
wire [2:0]   s2m_ndr_opcode_0;
wire [9:0]   s2m_ndr_spare_0;
wire [15:0]  s2m_ndr_tag_0; 
wire         s2m_ndr_valid_0;


assign `TRANSACTORS_PATH.cxl_s2m_drs_bus_in[0] = {s2m_drs_data_0,68'h0,s2m_drs_valid_0,s2m_drs_tag_0,s2m_drs_spare_0,s2m_drs_pre_0,s2m_drs_poison_0,s2m_drs_pcls_0,s2m_drs_opcode_0,s2m_drs_metavalue_0,s2m_drs_metafield_0,s2m_drs_eccvalid_0,s2m_drs_ecc_0,s2m_drs_data_parity_0};

assign `TRANSACTORS_PATH.cxl_s2m_ndr_bus_in[0] = {s2m_ndr_valid_0,s2m_ndr_tag_0,s2m_ndr_spare_0,s2m_ndr_opcode_0,s2m_ndr_metavalue_0,s2m_ndr_metafield_0};


wire [255:0] m2s_rwd_data_0;
wire [45:0]  m2s_rwd_address_0;
wire         m2s_rwd_addrparity_0;
wire         m2s_rwd_beparity_0;
wire [15:0]  m2s_rwd_byteen_0;
wire [3:0]   m2s_rwd_data_parity_0;
wire [9:0]   m2s_rwd_ecc_0;
wire         m2s_rwd_eccvalid_0;
wire [3:0]   m2s_rwd_memopcode_0;
wire [1:0]   m2s_rwd_metafield_0;
wire [1:0]   m2s_rwd_metavalue_0;
wire         m2s_rwd_poison_0;
wire [2:0]   m2s_rwd_snptype_0;
wire [9:0]   m2s_rwd_spare_0;
wire [15:0]  m2s_rwd_tag_0;
wire [1:0]   m2s_rwd_tc_0;   
wire         m2s_rwd_valid_0;

wire [46:0]  m2s_req_address_0;
wire         m2s_req_addrparity_0;
wire [3:0]   m2s_req_memopcode_0;
wire [1:0]   m2s_req_metafield_0;
wire [1:0]   m2s_req_metavalue_0;
wire [2:0]   m2s_req_snptype_0;
wire [9:0]   m2s_req_spare_0;
wire [15:0]  m2s_req_tag_0;
wire [1:0]   m2s_req_tc_0;   
wire         m2s_req_valid_0;

assign m2s_rwd_data_0 = `TRANSACTORS_PATH.cxl_m2s_rwd_bus_out[0][383:128];

assign {m2s_rwd_valid_0,m2s_rwd_tc_0,m2s_rwd_tag_0,m2s_rwd_spare_0,m2s_rwd_snptype_0,m2s_rwd_poison_0,m2s_rwd_metavalue_0,m2s_rwd_metafield_0,m2s_rwd_memopcode_0,m2s_rwd_eccvalid_0,m2s_rwd_ecc_0,m2s_rwd_data_parity_0,m2s_rwd_byteen_0,m2s_rwd_beparity_0,m2s_rwd_addrparity_0,m2s_rwd_address_0} = `TRANSACTORS_PATH.cxl_m2s_rwd_bus_out[0][119:0];

assign {m2s_req_valid_0,m2s_req_tc_0,m2s_req_tag_0,m2s_req_spare_0,m2s_req_snptype_0,m2s_req_metavalue_0,m2s_req_metafield_0,m2s_req_memopcode_0,m2s_req_addrparity_0,m2s_req_address_0} = `TRANSACTORS_PATH.cxl_m2s_req_bus_out[0];

assign  `TRANSACTORS_PATH.cxl_mem_cxl_m2s_req_bus_out = `TRANSACTORS_PATH.cxl_m2s_req_bus_out[0];
assign  `TRANSACTORS_PATH.cxl_mem_cxl_m2s_rwd_bus_out = `TRANSACTORS_PATH.cxl_m2s_rwd_bus_out[0];

//=================================================================================================================================
// CXL_MEM_MASTER connections - USER MUST EDIT THE RIGHT HAND SIDE OF THE FOLLOWING ASSIGNMENTS AND DEFINE - WHEN NEEDED
//=================================================================================================================================
// CXL_MEM_MASTER   connection #0

			`define 	CXL_MEM_SLAVE_0 					fpga_transactors_top_inst   // example:  fpga_tcss_top.tcss_val_rtl.tcss.par_iom   //HERE USER SHOULD SET THE PATH TO HIS SIDE OF THE CXL.MEM INTEFACE, THE SLAVE SIDE

assign `TRANSACTORS_PATH.cxl_mem_master_clk[0] 		= `CXL_MEM_SLAVE_0.cxl_mem_master_clock;
assign `TRANSACTORS_PATH.cxl_mem_master_rstn[0] 	= `CXL_MEM_SLAVE_0.cxl_mem_master_rst_n;

assign `TRANSACTORS_PATH.credit_m2s_req_in[0]		= `CXL_MEM_SLAVE_0.cxl_mem_credit_m2s_req_in;
assign `TRANSACTORS_PATH.credit_m2s_rwd_in[0]		= `CXL_MEM_SLAVE_0.cxl_mem_credit_m2s_rwd_in;


assign s2m_drs_valid_0   		= `CXL_MEM_SLAVE_0.s2m_drs_valid;
assign s2m_drs_tag_0			= `CXL_MEM_SLAVE_0.s2m_drs_tag;
assign s2m_drs_spare_0			= `CXL_MEM_SLAVE_0.s2m_drs_spare;
assign s2m_drs_pre_0			= `CXL_MEM_SLAVE_0.s2m_drs_pre;	
assign s2m_drs_poison_0	   		= `CXL_MEM_SLAVE_0.s2m_drs_poison;	
assign s2m_drs_pcls_0			= `CXL_MEM_SLAVE_0.s2m_drs_pcls;
assign s2m_drs_opcode_0	   		= `CXL_MEM_SLAVE_0.s2m_drs_opcode;	
assign s2m_drs_metavalue_0  	= `CXL_MEM_SLAVE_0.s2m_drs_metavalue;	
assign s2m_drs_metafield_0  	= `CXL_MEM_SLAVE_0.s2m_drs_metafield;
assign s2m_drs_eccvalid_0		= `CXL_MEM_SLAVE_0.s2m_drs_eccvalid;
assign s2m_drs_ecc_0			= `CXL_MEM_SLAVE_0.s2m_drs_ecc;
assign s2m_drs_data_parity_0	= `CXL_MEM_SLAVE_0.s2m_drs_data_parity;
assign s2m_drs_data_0 			= `CXL_MEM_SLAVE_0.s2m_drs_data; 		//256 bits


assign s2m_ndr_valid_0   		= `CXL_MEM_SLAVE_0.s2m_ndr_valid;
assign s2m_ndr_tag_0   			= `CXL_MEM_SLAVE_0.s2m_ndr_tag;
assign s2m_ndr_spare_0   		= `CXL_MEM_SLAVE_0.s2m_ndr_spare;
assign s2m_ndr_opcode_0   		= `CXL_MEM_SLAVE_0.s2m_ndr_opcode;
assign s2m_ndr_metavalue_0   	= `CXL_MEM_SLAVE_0.s2m_ndr_metavalue;
assign s2m_ndr_metafield_0   	= `CXL_MEM_SLAVE_0.s2m_ndr_metafield; 

//=================================================================================================================================
// CXL_CACHE_HOST connections - USER MUST EDIT THE LEFT HAND SIDE OF THE FOLLOWING ASSIGNMENTS 
//=================================================================================================================================

assign `CXL_MEM_SLAVE_0.cxl_mem_credit_s2m_drs_out 			= `TRANSACTORS_PATH.credit_s2m_drs_out[0]	;
assign `CXL_MEM_SLAVE_0.cxl_mem_credit_s2m_ndr_out 			= `TRANSACTORS_PATH.credit_s2m_ndr_out[0]	;


assign `CXL_MEM_SLAVE_0.m2s_req_valid 			= m2s_req_valid_0;
assign `CXL_MEM_SLAVE_0.m2s_req_tc 			= m2s_req_tc_0;
assign `CXL_MEM_SLAVE_0.m2s_req_tag 			= m2s_req_tag_0;
assign `CXL_MEM_SLAVE_0.m2s_req_spare 			= m2s_req_spare_0;
assign `CXL_MEM_SLAVE_0.m2s_req_snptype 		= m2s_req_snptype_0;
assign `CXL_MEM_SLAVE_0.m2s_req_metavalue 		= m2s_req_metavalue_0;
assign `CXL_MEM_SLAVE_0.m2s_req_metafield 		= m2s_req_metafield_0;
assign `CXL_MEM_SLAVE_0.m2s_req_memopcode 		= m2s_req_memopcode_0;
assign `CXL_MEM_SLAVE_0.m2s_req_addrparity 	= m2s_req_addrparity_0;
assign `CXL_MEM_SLAVE_0.m2s_req_address 		= m2s_req_address_0;


assign `CXL_MEM_SLAVE_0.m2s_rwd_valid 			= m2s_rwd_valid_0;
assign `CXL_MEM_SLAVE_0.m2s_rwd_tc 			= m2s_rwd_tc_0;
assign `CXL_MEM_SLAVE_0.m2s_rwd_tag 			= m2s_rwd_tag_0;
assign `CXL_MEM_SLAVE_0.m2s_rwd_spare 			= m2s_rwd_spare_0;
assign `CXL_MEM_SLAVE_0.m2s_rwd_snptype 		= m2s_rwd_snptype_0;
assign `CXL_MEM_SLAVE_0.m2s_rwd_poison 		= m2s_rwd_poison_0;
assign `CXL_MEM_SLAVE_0.m2s_rwd_metavalue 		= m2s_rwd_metavalue_0;
assign `CXL_MEM_SLAVE_0.m2s_rwd_metafield 		= m2s_rwd_metafield_0;
assign `CXL_MEM_SLAVE_0.m2s_rwd_memopcode 		= m2s_rwd_memopcode_0;
assign `CXL_MEM_SLAVE_0.m2s_rwd_eccvalid 		= m2s_rwd_eccvalid_0;
assign `CXL_MEM_SLAVE_0.m2s_rwd_ecc 			= m2s_rwd_ecc_0;
assign `CXL_MEM_SLAVE_0.m2s_rwd_data_parity 	= m2s_rwd_data_parity_0;
assign `CXL_MEM_SLAVE_0.m2s_rwd_byteen 		= m2s_rwd_byteen_0;
assign `CXL_MEM_SLAVE_0.m2s_rwd_beparity 		= m2s_rwd_beparity_0;
assign `CXL_MEM_SLAVE_0.m2s_rwd_addrparity 	= m2s_rwd_addrparity_0;
assign `CXL_MEM_SLAVE_0.m2s_rwd_address 		= m2s_rwd_address_0;
assign `CXL_MEM_SLAVE_0.m2s_rwd_data 			= m2s_rwd_data_0;		//256 bits


//=================================================================================================================================

