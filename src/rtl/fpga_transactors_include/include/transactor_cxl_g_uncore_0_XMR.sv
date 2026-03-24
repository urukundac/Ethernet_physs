//=================================================================================================
// CXL_CACHE_G - Corrected Connections Between CORE_0 and UNCORE[0]
//=================================================================================================

`define CXL_G_CORE_0      `FPGA_TRANSACTORS_TOP   // example: fpga_transactors_top.fpga_transactors_top_inst

//--------------------------------------------------------------------------------
// Clock and Reset
//--------------------------------------------------------------------------------
assign `TRANSACTORS_PATH.cxl_g_fabric_clk[0]   = `CXL_G_CORE_0.cxl_g_agent_clock_0;
assign `TRANSACTORS_PATH.cxl_g_fabric_rstn[0]  = `CXL_G_CORE_0.cxl_g_agent_rstn_0;


//--------------------------------------------------------------------------------
// Global INIT signals
//--------------------------------------------------------------------------------
assign `TRANSACTORS_PATH.CXL_G_UNCORE_C2U_txcon_req[0]       = `CXL_G_CORE_0.CXL_G_CORE_C2U_txcon_req_0;
assign `CXL_G_CORE_0.CXL_G_CORE_C2U_rxcon_ack_0                = `TRANSACTORS_PATH.CXL_G_UNCORE_C2U_rxcon_ack[0];
assign `CXL_G_CORE_0.CXL_G_CORE_C2U_rxdiscon_nack_0            = `TRANSACTORS_PATH.CXL_G_UNCORE_C2U_rxdiscon_nack[0];
assign `CXL_G_CORE_0.CXL_G_CORE_C2U_rx_empty_0                 = `TRANSACTORS_PATH.CXL_G_UNCORE_C2U_rx_empty[0];

assign `CXL_G_CORE_0.CXL_G_CORE_U2C_txcon_req_0                = `TRANSACTORS_PATH.CXL_G_UNCORE_U2C_txcon_req[0];
assign `TRANSACTORS_PATH.CXL_G_UNCORE_U2C_rxcon_ack[0]       = `CXL_G_CORE_0.CXL_G_CORE_U2C_rxcon_ack_0;
assign `TRANSACTORS_PATH.CXL_G_UNCORE_U2C_rxdiscon_nack[0]   = `CXL_G_CORE_0.CXL_G_CORE_U2C_rxdiscon_nack_0;
assign `TRANSACTORS_PATH.CXL_G_UNCORE_U2C_rx_empty[0]        = `CXL_G_CORE_0.CXL_G_CORE_U2C_rx_empty_0;


//--------------------------------------------------------------------------------
// C2U Path
//--------------------------------------------------------------------------------
//
// ---------------------- C2U Request ----------------------
assign `TRANSACTORS_PATH.CXL_G_UNCORE_C2U_Req_req_header[0]        = `CXL_G_CORE_0.CXL_G_CORE_C2U_Req_req_header_0;
assign `TRANSACTORS_PATH.CXL_G_UNCORE_C2U_Req_req_vc_id[0]         = `CXL_G_CORE_0.CXL_G_CORE_C2U_Req_req_vc_id_0;
assign `TRANSACTORS_PATH.CXL_G_UNCORE_C2U_Req_req_protocol_id[0]   = `CXL_G_CORE_0.CXL_G_CORE_C2U_Req_req_protocol_id_0;
assign `TRANSACTORS_PATH.CXL_G_UNCORE_C2U_Req_req_shared_credit[0] = `CXL_G_CORE_0.CXL_G_CORE_C2U_Req_req_shared_credit_0;
assign `TRANSACTORS_PATH.CXL_G_UNCORE_C2U_Req_early_valid[0]       = `CXL_G_CORE_0.CXL_G_CORE_C2U_Req_early_valid_0;

assign `CXL_G_CORE_0.CXL_G_CORE_C2U_Req_rxcrd_valid_0   = `TRANSACTORS_PATH.CXL_G_UNCORE_C2U_Req_rxcrd_valid[0];
assign `CXL_G_CORE_0.CXL_G_CORE_C2U_Req_rxcrd_vc_id_0   = `TRANSACTORS_PATH.CXL_G_UNCORE_C2U_Req_rxcrd_vc_id[0];
assign `CXL_G_CORE_0.CXL_G_CORE_C2U_Req_rxcrd_shared_0  = `TRANSACTORS_PATH.CXL_G_UNCORE_C2U_Req_rxcrd_shared[0];
assign `CXL_G_CORE_0.CXL_G_CORE_C2U_Req_rxcrd_afifo_0   = `TRANSACTORS_PATH.CXL_G_UNCORE_C2U_Req_rxcrd_afifo[0];



// ---------------------- C2U Data ----------------------
assign `TRANSACTORS_PATH.CXL_G_UNCORE_C2U_Data_data_header_payload[0]    = `CXL_G_CORE_0.CXL_G_CORE_C2U_Data_data_header_payload_0;
assign `TRANSACTORS_PATH.CXL_G_UNCORE_C2U_Data_data_eop[0]               = `CXL_G_CORE_0.CXL_G_CORE_C2U_Data_data_eop_0;
assign `TRANSACTORS_PATH.CXL_G_UNCORE_C2U_Data_data_vc_id[0]             = `CXL_G_CORE_0.CXL_G_CORE_C2U_Data_data_vc_id_0;
assign `TRANSACTORS_PATH.CXL_G_UNCORE_C2U_Data_data_protocol_id[0]       = `CXL_G_CORE_0.CXL_G_CORE_C2U_Data_data_protocol_id_0;
assign `TRANSACTORS_PATH.CXL_G_UNCORE_C2U_Data_data_shared_credit[0]     = `CXL_G_CORE_0.CXL_G_CORE_C2U_Data_data_shared_credit_0;
assign `TRANSACTORS_PATH.CXL_G_UNCORE_C2U_Data_early_valid[0]            = `CXL_G_CORE_0.CXL_G_CORE_C2U_Data_early_valid_0;

assign `CXL_G_CORE_0.CXL_G_CORE_C2U_Data_rxcrd_valid_0   = `TRANSACTORS_PATH.CXL_G_UNCORE_C2U_Data_rxcrd_valid[0];
assign `CXL_G_CORE_0.CXL_G_CORE_C2U_Data_rxcrd_vc_id_0   = `TRANSACTORS_PATH.CXL_G_UNCORE_C2U_Data_rxcrd_vc_id[0];
assign `CXL_G_CORE_0.CXL_G_CORE_C2U_Data_rxcrd_shared_0  = `TRANSACTORS_PATH.CXL_G_UNCORE_C2U_Data_rxcrd_shared[0];
assign `CXL_G_CORE_0.CXL_G_CORE_C2U_Data_rxcrd_afifo_0   = `TRANSACTORS_PATH.CXL_G_UNCORE_C2U_Data_rxcrd_afifo[0];

//--------------------------------------------------------------------------------
// U2C Path
//--------------------------------------------------------------------------------
// ---------------------- U2C Response ----------------------
assign `CXL_G_CORE_0.CXL_G_CORE_U2C_Resp_resp_header_0         = `TRANSACTORS_PATH.CXL_G_UNCORE_U2C_Resp_resp_header[0];
assign `CXL_G_CORE_0.CXL_G_CORE_U2C_Resp_resp_vc_id_0          = `TRANSACTORS_PATH.CXL_G_UNCORE_U2C_Resp_resp_vc_id[0];
assign `CXL_G_CORE_0.CXL_G_CORE_U2C_Resp_resp_protocol_id_0    = `TRANSACTORS_PATH.CXL_G_UNCORE_U2C_Resp_resp_protocol_id[0];
assign `CXL_G_CORE_0.CXL_G_CORE_U2C_Resp_resp_shared_credit_0  = `TRANSACTORS_PATH.CXL_G_UNCORE_U2C_Resp_resp_shared_credit[0];
assign `CXL_G_CORE_0.CXL_G_CORE_U2C_Resp_early_valid_0         = `TRANSACTORS_PATH.CXL_G_UNCORE_U2C_Resp_early_valid[0];

assign `TRANSACTORS_PATH.CXL_G_UNCORE_U2C_Resp_rxcrd_valid[0]   = `CXL_G_CORE_0.CXL_G_CORE_U2C_Resp_rxcrd_valid_0;
assign `TRANSACTORS_PATH.CXL_G_UNCORE_U2C_Resp_rxcrd_vc_id[0]   = `CXL_G_CORE_0.CXL_G_CORE_U2C_Resp_rxcrd_vc_id_0;
assign `TRANSACTORS_PATH.CXL_G_UNCORE_U2C_Resp_rxcrd_shared[0]  = `CXL_G_CORE_0.CXL_G_CORE_U2C_Resp_rxcrd_shared_0;
assign `TRANSACTORS_PATH.CXL_G_UNCORE_U2C_Resp_rxcrd_afifo[0]   = `CXL_G_CORE_0.CXL_G_CORE_U2C_Resp_rxcrd_afifo_0;

// ---------------------- U2C Data ----------------------
assign `CXL_G_CORE_0.CXL_G_CORE_U2C_Data_data_header_payload_0  = `TRANSACTORS_PATH.CXL_G_UNCORE_U2C_Data_data_header_payload[0];
assign `CXL_G_CORE_0.CXL_G_CORE_U2C_Data_data_vc_id_0           = `TRANSACTORS_PATH.CXL_G_UNCORE_U2C_Data_data_vc_id[0];
assign `CXL_G_CORE_0.CXL_G_CORE_U2C_Data_data_protocol_id_0     = `TRANSACTORS_PATH.CXL_G_UNCORE_U2C_Data_data_protocol_id[0];
assign `CXL_G_CORE_0.CXL_G_CORE_U2C_Data_data_shared_credit_0   = `TRANSACTORS_PATH.CXL_G_UNCORE_U2C_Data_data_shared_credit[0];
assign `CXL_G_CORE_0.CXL_G_CORE_U2C_Data_data_eop_0             = `TRANSACTORS_PATH.CXL_G_UNCORE_U2C_Data_data_eop[0];
assign `CXL_G_CORE_0.CXL_G_CORE_U2C_Data_early_valid_0          = `TRANSACTORS_PATH.CXL_G_UNCORE_U2C_Data_early_valid[0];

assign `TRANSACTORS_PATH.CXL_G_UNCORE_U2C_Data_rxcrd_valid[0]   = `CXL_G_CORE_0.CXL_G_CORE_U2C_Data_rxcrd_valid_0;
assign `TRANSACTORS_PATH.CXL_G_UNCORE_U2C_Data_rxcrd_vc_id[0]   = `CXL_G_CORE_0.CXL_G_CORE_U2C_Data_rxcrd_vc_id_0;
assign `TRANSACTORS_PATH.CXL_G_UNCORE_U2C_Data_rxcrd_shared[0]  = `CXL_G_CORE_0.CXL_G_CORE_U2C_Data_rxcrd_shared_0;
assign `TRANSACTORS_PATH.CXL_G_UNCORE_U2C_Data_rxcrd_afifo[0]   = `CXL_G_CORE_0.CXL_G_CORE_U2C_Data_rxcrd_afifo_0;


