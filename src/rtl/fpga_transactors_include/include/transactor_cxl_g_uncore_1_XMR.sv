//=================================================================================================
// CXL_CACHE_G - Corrected Connections Between CORE_1 and UNCORE[1]
//=================================================================================================

`define CXL_G_CORE_1      `FPGA_TRANSACTORS_TOP   // example: fpga_transactors_top.fpga_transactors_top_inst

//--------------------------------------------------------------------------------
// Clock and Reset
//--------------------------------------------------------------------------------
assign `TRANSACTORS_PATH.cxl_g_fabric_clk[1]   = `CXL_G_CORE_1.cxl_g_agent_clock_1;
assign `TRANSACTORS_PATH.cxl_g_fabric_rstn[1]  = `CXL_G_CORE_1.cxl_g_agent_rstn_1;


//--------------------------------------------------------------------------------
// Global INIT signals
//--------------------------------------------------------------------------------
assign `TRANSACTORS_PATH.CXL_G_UNCORE_C2U_txcon_req[1]       = `CXL_G_CORE_1.CXL_G_CORE_C2U_txcon_req_1;
assign `CXL_G_CORE_1.CXL_G_CORE_C2U_rxcon_ack_1                = `TRANSACTORS_PATH.CXL_G_UNCORE_C2U_rxcon_ack[1];
assign `CXL_G_CORE_1.CXL_G_CORE_C2U_rxdiscon_nack_1            = `TRANSACTORS_PATH.CXL_G_UNCORE_C2U_rxdiscon_nack[1];
assign `CXL_G_CORE_1.CXL_G_CORE_C2U_rx_empty_1                 = `TRANSACTORS_PATH.CXL_G_UNCORE_C2U_rx_empty[1];

assign `CXL_G_CORE_1.CXL_G_CORE_U2C_txcon_req_1                = `TRANSACTORS_PATH.CXL_G_UNCORE_U2C_txcon_req[1];
assign `TRANSACTORS_PATH.CXL_G_UNCORE_U2C_rxcon_ack[1]       = `CXL_G_CORE_1.CXL_G_CORE_U2C_rxcon_ack_1;
assign `TRANSACTORS_PATH.CXL_G_UNCORE_U2C_rxdiscon_nack[1]   = `CXL_G_CORE_1.CXL_G_CORE_U2C_rxdiscon_nack_1;
assign `TRANSACTORS_PATH.CXL_G_UNCORE_U2C_rx_empty[1]        = `CXL_G_CORE_1.CXL_G_CORE_U2C_rx_empty_1;


//--------------------------------------------------------------------------------
// C2U Path
//--------------------------------------------------------------------------------
//
// ---------------------- C2U Request ----------------------
assign `TRANSACTORS_PATH.CXL_G_UNCORE_C2U_Req_req_header[1]        = `CXL_G_CORE_1.CXL_G_CORE_C2U_Req_req_header_1;
assign `TRANSACTORS_PATH.CXL_G_UNCORE_C2U_Req_req_vc_id[1]         = `CXL_G_CORE_1.CXL_G_CORE_C2U_Req_req_vc_id_1;
assign `TRANSACTORS_PATH.CXL_G_UNCORE_C2U_Req_req_protocol_id[1]   = `CXL_G_CORE_1.CXL_G_CORE_C2U_Req_req_protocol_id_1;
assign `TRANSACTORS_PATH.CXL_G_UNCORE_C2U_Req_req_shared_credit[1] = `CXL_G_CORE_1.CXL_G_CORE_C2U_Req_req_shared_credit_1;
assign `TRANSACTORS_PATH.CXL_G_UNCORE_C2U_Req_early_valid[1]       = `CXL_G_CORE_1.CXL_G_CORE_C2U_Req_early_valid_1;

assign `CXL_G_CORE_1.CXL_G_CORE_C2U_Req_rxcrd_valid_1   = `TRANSACTORS_PATH.CXL_G_UNCORE_C2U_Req_rxcrd_valid[1];
assign `CXL_G_CORE_1.CXL_G_CORE_C2U_Req_rxcrd_vc_id_1   = `TRANSACTORS_PATH.CXL_G_UNCORE_C2U_Req_rxcrd_vc_id[1];
assign `CXL_G_CORE_1.CXL_G_CORE_C2U_Req_rxcrd_shared_1  = `TRANSACTORS_PATH.CXL_G_UNCORE_C2U_Req_rxcrd_shared[1];
assign `CXL_G_CORE_1.CXL_G_CORE_C2U_Req_rxcrd_afifo_1   = `TRANSACTORS_PATH.CXL_G_UNCORE_C2U_Req_rxcrd_afifo[1];



// ---------------------- C2U Data ----------------------
assign `TRANSACTORS_PATH.CXL_G_UNCORE_C2U_Data_data_header_payload[1]    = `CXL_G_CORE_1.CXL_G_CORE_C2U_Data_data_header_payload_1;
assign `TRANSACTORS_PATH.CXL_G_UNCORE_C2U_Data_data_eop[1]               = `CXL_G_CORE_1.CXL_G_CORE_C2U_Data_data_eop_1;
assign `TRANSACTORS_PATH.CXL_G_UNCORE_C2U_Data_data_vc_id[1]             = `CXL_G_CORE_1.CXL_G_CORE_C2U_Data_data_vc_id_1;
assign `TRANSACTORS_PATH.CXL_G_UNCORE_C2U_Data_data_protocol_id[1]       = `CXL_G_CORE_1.CXL_G_CORE_C2U_Data_data_protocol_id_1;
assign `TRANSACTORS_PATH.CXL_G_UNCORE_C2U_Data_data_shared_credit[1]     = `CXL_G_CORE_1.CXL_G_CORE_C2U_Data_data_shared_credit_1;
assign `TRANSACTORS_PATH.CXL_G_UNCORE_C2U_Data_early_valid[1]            = `CXL_G_CORE_1.CXL_G_CORE_C2U_Data_early_valid_1;

assign `CXL_G_CORE_1.CXL_G_CORE_C2U_Data_rxcrd_valid_1   = `TRANSACTORS_PATH.CXL_G_UNCORE_C2U_Data_rxcrd_valid[1];
assign `CXL_G_CORE_1.CXL_G_CORE_C2U_Data_rxcrd_vc_id_1   = `TRANSACTORS_PATH.CXL_G_UNCORE_C2U_Data_rxcrd_vc_id[1];
assign `CXL_G_CORE_1.CXL_G_CORE_C2U_Data_rxcrd_shared_1  = `TRANSACTORS_PATH.CXL_G_UNCORE_C2U_Data_rxcrd_shared[1];
assign `CXL_G_CORE_1.CXL_G_CORE_C2U_Data_rxcrd_afifo_1   = `TRANSACTORS_PATH.CXL_G_UNCORE_C2U_Data_rxcrd_afifo[1];

//--------------------------------------------------------------------------------
// U2C Path
//--------------------------------------------------------------------------------
// ---------------------- U2C Response ----------------------
assign `CXL_G_CORE_1.CXL_G_CORE_U2C_Resp_resp_header_1         = `TRANSACTORS_PATH.CXL_G_UNCORE_U2C_Resp_resp_header[1];
assign `CXL_G_CORE_1.CXL_G_CORE_U2C_Resp_resp_vc_id_1          = `TRANSACTORS_PATH.CXL_G_UNCORE_U2C_Resp_resp_vc_id[1];
assign `CXL_G_CORE_1.CXL_G_CORE_U2C_Resp_resp_protocol_id_1    = `TRANSACTORS_PATH.CXL_G_UNCORE_U2C_Resp_resp_protocol_id[1];
assign `CXL_G_CORE_1.CXL_G_CORE_U2C_Resp_resp_shared_credit_1  = `TRANSACTORS_PATH.CXL_G_UNCORE_U2C_Resp_resp_shared_credit[1];
assign `CXL_G_CORE_1.CXL_G_CORE_U2C_Resp_early_valid_1         = `TRANSACTORS_PATH.CXL_G_UNCORE_U2C_Resp_early_valid[1];

assign `TRANSACTORS_PATH.CXL_G_UNCORE_U2C_Resp_rxcrd_valid[1]   = `CXL_G_CORE_1.CXL_G_CORE_U2C_Resp_rxcrd_valid_1;
assign `TRANSACTORS_PATH.CXL_G_UNCORE_U2C_Resp_rxcrd_vc_id[1]   = `CXL_G_CORE_1.CXL_G_CORE_U2C_Resp_rxcrd_vc_id_1;
assign `TRANSACTORS_PATH.CXL_G_UNCORE_U2C_Resp_rxcrd_shared[1]  = `CXL_G_CORE_1.CXL_G_CORE_U2C_Resp_rxcrd_shared_1;
assign `TRANSACTORS_PATH.CXL_G_UNCORE_U2C_Resp_rxcrd_afifo[1]   = `CXL_G_CORE_1.CXL_G_CORE_U2C_Resp_rxcrd_afifo_1;

// ---------------------- U2C Data ----------------------
assign `CXL_G_CORE_1.CXL_G_CORE_U2C_Data_data_header_payload_1  = `TRANSACTORS_PATH.CXL_G_UNCORE_U2C_Data_data_header_payload[1];
assign `CXL_G_CORE_1.CXL_G_CORE_U2C_Data_data_vc_id_1           = `TRANSACTORS_PATH.CXL_G_UNCORE_U2C_Data_data_vc_id[1];
assign `CXL_G_CORE_1.CXL_G_CORE_U2C_Data_data_protocol_id_1     = `TRANSACTORS_PATH.CXL_G_UNCORE_U2C_Data_data_protocol_id[1];
assign `CXL_G_CORE_1.CXL_G_CORE_U2C_Data_data_shared_credit_1   = `TRANSACTORS_PATH.CXL_G_UNCORE_U2C_Data_data_shared_credit[1];
assign `CXL_G_CORE_1.CXL_G_CORE_U2C_Data_data_eop_1             = `TRANSACTORS_PATH.CXL_G_UNCORE_U2C_Data_data_eop[1];
assign `CXL_G_CORE_1.CXL_G_CORE_U2C_Data_early_valid_1          = `TRANSACTORS_PATH.CXL_G_UNCORE_U2C_Data_early_valid[1];

assign `TRANSACTORS_PATH.CXL_G_UNCORE_U2C_Data_rxcrd_valid[1]   = `CXL_G_CORE_1.CXL_G_CORE_U2C_Data_rxcrd_valid_1;
assign `TRANSACTORS_PATH.CXL_G_UNCORE_U2C_Data_rxcrd_vc_id[1]   = `CXL_G_CORE_1.CXL_G_CORE_U2C_Data_rxcrd_vc_id_1;
assign `TRANSACTORS_PATH.CXL_G_UNCORE_U2C_Data_rxcrd_shared[1]  = `CXL_G_CORE_1.CXL_G_CORE_U2C_Data_rxcrd_shared_1;
assign `TRANSACTORS_PATH.CXL_G_UNCORE_U2C_Data_rxcrd_afifo[1]   = `CXL_G_CORE_1.CXL_G_CORE_U2C_Data_rxcrd_afifo_1;


