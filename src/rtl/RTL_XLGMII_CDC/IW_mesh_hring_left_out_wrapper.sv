module IW_mesh_hring_left_out_wrapper (
//hring_left_in_pyld_ddrt_throttle,
//hring_left_in_pyld_dpt_throttle,
//hring_left_out_pyld_ddrt_throttle,
//hring_left_out_pyld_dpt_throttle,
hring_left_in_data_bl_data_beparity,
hring_left_in_data_bl_data_byte_en,
hring_left_in_data_bl_data_data,
hring_left_in_data_bl_data_ecc,
hring_left_in_data_bl_data_ecc_valid,
hring_left_in_data_bl_data_parity,
hring_left_in_data_bl_data_poison,
hring_left_in_pyld_ad_addr,
hring_left_in_pyld_ad_dest_dst_bounce,
hring_left_in_pyld_ad_dest_dst_id,
hring_left_in_pyld_ad_dest_dst_type,
hring_left_in_pyld_ad_dest_for_me,
hring_left_in_pyld_ad_dest_reserve,
hring_left_in_pyld_ad_dest_src_id,
hring_left_in_pyld_ad_dest_src_type,
hring_left_in_pyld_ad_dest_valid,
hring_left_in_pyld_ad_hdr,
hring_left_in_pyld_ads_anti_dead_s,
hring_left_in_pyld_ak_dest_dst_bounce,
hring_left_in_pyld_ak_dest_dst_id,
hring_left_in_pyld_ak_dest_dst_type,
hring_left_in_pyld_ak_dest_for_me,
hring_left_in_pyld_ak_dest_reserve,
hring_left_in_pyld_ak_dest_src_id,
hring_left_in_pyld_ak_dest_src_type,
hring_left_in_pyld_ak_dest_valid,
hring_left_in_pyld_ak_hdr,
hring_left_in_pyld_akc_dest_dst_id,
hring_left_in_pyld_akc_dest_dst_type,
hring_left_in_pyld_akc_dest_for_me,
hring_left_in_pyld_akc_dest_reserve,
hring_left_in_pyld_akc_dest_src_id,
hring_left_in_pyld_akc_dest_src_type,
hring_left_in_pyld_akc_dest_valid,
hring_left_in_pyld_akc_hdr,
hring_left_in_pyld_bl_addr,
hring_left_in_pyld_bl_dest_dst_id,
hring_left_in_pyld_bl_dest_dst_type,
hring_left_in_pyld_bl_dest_for_me,
hring_left_in_pyld_bl_dest_half,
hring_left_in_pyld_bl_dest_reserve,
hring_left_in_pyld_bl_dest_src_id,
hring_left_in_pyld_bl_dest_src_type,
hring_left_in_pyld_bl_dest_valid,
hring_left_in_pyld_bl_hdr,
hring_left_in_pyld_global_fatal,
hring_left_in_pyld_global_victim_pending,
hring_left_in_pyld_global_viral,
hring_left_in_pyld_iv_addr,
hring_left_in_pyld_iv_dest,
hring_left_in_pyld_shared_vn0,
hring_left_in_pyld_thr_distress,
hring_left_out_data_bl_data_beparity,
hring_left_out_data_bl_data_byte_en,
hring_left_out_data_bl_data_data,
hring_left_out_data_bl_data_ecc,
hring_left_out_data_bl_data_ecc_valid,
hring_left_out_data_bl_data_parity,
hring_left_out_data_bl_data_poison,
hring_left_out_pyld_ad_addr,
hring_left_out_pyld_ad_dest_dst_bounce,
hring_left_out_pyld_ad_dest_dst_id,
hring_left_out_pyld_ad_dest_dst_type,
hring_left_out_pyld_ad_dest_for_me,
hring_left_out_pyld_ad_dest_reserve,
hring_left_out_pyld_ad_dest_src_id,
hring_left_out_pyld_ad_dest_src_type,
hring_left_out_pyld_ad_dest_valid,
hring_left_out_pyld_ad_hdr,
hring_left_out_pyld_ads_anti_dead_s,
hring_left_out_pyld_ak_dest_dst_bounce,
hring_left_out_pyld_ak_dest_dst_id,
hring_left_out_pyld_ak_dest_dst_type,
hring_left_out_pyld_ak_dest_for_me,
hring_left_out_pyld_ak_dest_reserve,
hring_left_out_pyld_ak_dest_src_id,
hring_left_out_pyld_ak_dest_src_type,
hring_left_out_pyld_ak_dest_valid,
hring_left_out_pyld_ak_hdr,
hring_left_out_pyld_akc_dest_dst_id,
hring_left_out_pyld_akc_dest_dst_type,
hring_left_out_pyld_akc_dest_for_me,
hring_left_out_pyld_akc_dest_reserve,
hring_left_out_pyld_akc_dest_src_id,
hring_left_out_pyld_akc_dest_src_type,
hring_left_out_pyld_akc_dest_valid,
hring_left_out_pyld_akc_hdr,
hring_left_out_pyld_bl_addr,
hring_left_out_pyld_bl_dest_dst_id,
hring_left_out_pyld_bl_dest_dst_type,
hring_left_out_pyld_bl_dest_for_me,
hring_left_out_pyld_bl_dest_half,
hring_left_out_pyld_bl_dest_reserve,
hring_left_out_pyld_bl_dest_src_id,
hring_left_out_pyld_bl_dest_src_type,
hring_left_out_pyld_bl_dest_valid,
hring_left_out_pyld_bl_hdr,
hring_left_out_pyld_global_fatal,
hring_left_out_pyld_global_victim_pending,
hring_left_out_pyld_global_viral,
hring_left_out_pyld_iv_addr,
hring_left_out_pyld_iv_dest,
hring_left_out_pyld_shared_vn0,
hring_left_out_pyld_thr_distress,
hring_left_out_mux,
hring_left_in_demux
);

parameter MESH_BL_DATA_BE_SIZE = 32;
parameter MESH_BL_DATA_SIZE = 256;
parameter MESH_BL_DATA_ECC_SIZE = 10;
parameter MESH_BL_DATA_PAR_SIZE = 4;
parameter MESH_STOP_ID_SIZE = 6;
parameter MESH_AD_ADR_SIZE = 46;
parameter MESH_AD_HDR_SIZE = 61;
parameter MESH_AK_HDR_SIZE = 28;
parameter MESH_AKC_HDR_SIZE = 8; 
parameter MESH_BL_ADR_SIZE = 23;
parameter MESH_BL_HDR_SIZE = 48;
parameter MESH_IV_ADR_SIZE = 23;
parameter MESH_IV_DST_SIZE = 28;
parameter DEMUX_DATA_WIDTH = 647;
//parameter DEMUX_DATA_WIDTH = {
//1
//+ 1
//+ 1
//+ 1
//+ 1
//+ MESH_BL_DATA_BE_SIZE
//+ MESH_BL_DATA_SIZE
//+ MESH_BL_DATA_ECC_SIZE
//+ 1
//+ MESH_BL_DATA_PAR_SIZE
//+ 1
//+ MESH_AD_ADR_SIZE
//+ 1
//+ MESH_STOP_ID_SIZE
//+ 1
//+ 1
//+ 1
//+ MESH_STOP_ID_SIZE
//+ 1
//+ 1
//+ MESH_AD_HDR_SIZE
//+ 1
//+ 1
//+ MESH_STOP_ID_SIZE
//+ 1
//+ 1
//+ 1
//+ MESH_STOP_ID_SIZE
//+ 1
//+ 1
//+ MESH_AK_HDR_SIZE
//+ MESH_STOP_ID_SIZE
//+ 1
//+ 1
//+ 1
//+ MESH_STOP_ID_SIZE
//+ 1
//+ 1
//+ MESH_AKC_HDR_SIZE
//+ MESH_BL_ADR_SIZE
//+ MESH_STOP_ID_SIZE
//+ 1
//+ 1
//+ 1
//+ 1
//+ MESH_STOP_ID_SIZE
//+ 1
//+ 1
//+ MESH_BL_HDR_SIZE
//+ 1
//+ 1
//+ 1
//+ MESH_IV_ADR_SIZE
//+ MESH_IV_DST_SIZE
//+ 1
//+ 1
//+ 1
//+ MESH_BL_DATA_BE_SIZE
//+ MESH_BL_DATA_SIZE
//+ MESH_BL_DATA_ECC_SIZE
//+ 1
//+ MESH_BL_DATA_PAR_SIZE
//+ 1
//+ MESH_AD_ADR_SIZE
//+ 1
//+ MESH_STOP_ID_SIZE
//+ 1
//+ 1
//+ 1
//+ MESH_STOP_ID_SIZE
//+ 1
//+ 1
//+ MESH_AD_HDR_SIZE
//+ 1
//+ 1
//+ MESH_STOP_ID_SIZE
//+ 1
//+ 1
//+ 1
//+ MESH_STOP_ID_SIZE
//+ 1
//+ 1
//+ MESH_AK_HDR_SIZE
//+ MESH_STOP_ID_SIZE
//+ 1
//+ 1
//+ 1
//+ MESH_STOP_ID_SIZE
//+ 1
//+ 1
//+ MESH_AKC_HDR_SIZE
//+ MESH_BL_ADR_SIZE
//+ MESH_STOP_ID_SIZE
//+ 1
//+ 1
//+ 1
//+ 1
//+ MESH_STOP_ID_SIZE
//+ 1
//+ 1
//+ MESH_BL_HDR_SIZE
//+ 1
//+ 1
//+ 1
//+ MESH_IV_ADR_SIZE
//+ MESH_IV_DST_SIZE
//+ 1
//+ 1
//};

parameter MUX_DATA_WIDTH = 647;
//parameter MUX_DATA_WIDTH = {
//1
//+ 1
//+ 1
//+ 1
//+ 1
//+ MESH_BL_DATA_BE_SIZE
//+ MESH_BL_DATA_SIZE
//+ MESH_BL_DATA_ECC_SIZE
//+ 1
//+ MESH_BL_DATA_PAR_SIZE
//+ 1
//+ MESH_AD_ADR_SIZE
//+ 1
//+ MESH_STOP_ID_SIZE
//+ 1
//+ 1
//+ 1
//+ MESH_STOP_ID_SIZE
//+ 1
//+ 1
//+ MESH_AD_HDR_SIZE
//+ 1
//+ 1
//+ MESH_STOP_ID_SIZE
//+ 1
//+ 1
//+ 1
//+ MESH_STOP_ID_SIZE
//+ 1
//+ 1
//+ MESH_AK_HDR_SIZE
//+ MESH_STOP_ID_SIZE
//+ 1
//+ 1
//+ 1
//+ MESH_STOP_ID_SIZE
//+ 1
//+ 1
//+ MESH_AKC_HDR_SIZE
//+ MESH_BL_ADR_SIZE
//+ MESH_STOP_ID_SIZE
//+ 1
//+ 1
//+ 1
//+ 1
//+ MESH_STOP_ID_SIZE
//+ 1
//+ 1
//+ MESH_BL_HDR_SIZE
//+ 1
//+ 1
//+ 1
//+ MESH_IV_ADR_SIZE
//+ MESH_IV_DST_SIZE
//+ 1
//+ 1
//+ 1
//+ MESH_BL_DATA_BE_SIZE
//+ MESH_BL_DATA_SIZE
//+ MESH_BL_DATA_ECC_SIZE
//+ 1
//+ MESH_BL_DATA_PAR_SIZE
//+ 1
//+ MESH_AD_ADR_SIZE
//+ 1
//+ MESH_STOP_ID_SIZE
//+ 1
//+ 1
//+ 1
//+ MESH_STOP_ID_SIZE
//+ 1
//+ 1
//+ MESH_AD_HDR_SIZE
//+ 1
//+ 1
//+ MESH_STOP_ID_SIZE
//+ 1
//+ 1
//+ 1
//+ MESH_STOP_ID_SIZE
//+ 1
//+ 1
//+ MESH_AK_HDR_SIZE
//+ MESH_STOP_ID_SIZE
//+ 1
//+ 1
//+ 1
//+ MESH_STOP_ID_SIZE
//+ 1
//+ 1
//+ MESH_AKC_HDR_SIZE 
//+ MESH_BL_ADR_SIZE
//+ MESH_STOP_ID_SIZE
//+ 1
//+ 1
//+ 1
//+ 1
//+ MESH_STOP_ID_SIZE
//+ 1
//+ 1
//+ MESH_BL_HDR_SIZE
//+ 1
//+ 1
//+ 1
//+ MESH_IV_ADR_SIZE
//+ MESH_IV_DST_SIZE
//+ 1
//+ 1
//};  

//    output           				hring_left_in_pyld_ddrt_throttle;
//    output           				hring_left_in_pyld_dpt_throttle;
//    input          				hring_left_out_pyld_ddrt_throttle;
//    input          				hring_left_out_pyld_dpt_throttle;
    // Ports for Interface hring_left_in_data
    output           				hring_left_in_data_bl_data_beparity;
    output   [MESH_BL_DATA_BE_SIZE-1:0]  	hring_left_in_data_bl_data_byte_en;
    output   [MESH_BL_DATA_SIZE-1:0] 		hring_left_in_data_bl_data_data;
    output   [MESH_BL_DATA_ECC_SIZE-1:0]  	hring_left_in_data_bl_data_ecc;
    output           				hring_left_in_data_bl_data_ecc_valid;
    output   [MESH_BL_DATA_PAR_SIZE-1:0]   	hring_left_in_data_bl_data_parity;
    output          	 			hring_left_in_data_bl_data_poison;
    // Ports for Interface hring_left_in_pyld
    output   [MESH_AD_ADR_SIZE-1:0]  		hring_left_in_pyld_ad_addr;
    output           				hring_left_in_pyld_ad_dest_dst_bounce;
    output   [MESH_STOP_ID_SIZE-1:0]   		hring_left_in_pyld_ad_dest_dst_id;
    output           				hring_left_in_pyld_ad_dest_dst_type;
    output           				hring_left_in_pyld_ad_dest_for_me;
    output           				hring_left_in_pyld_ad_dest_reserve;
    output   [MESH_STOP_ID_SIZE-1:0]   		hring_left_in_pyld_ad_dest_src_id;
    output           				hring_left_in_pyld_ad_dest_src_type;
    output           				hring_left_in_pyld_ad_dest_valid;
    output   [MESH_AD_HDR_SIZE-1:0]  		hring_left_in_pyld_ad_hdr;
    output           				hring_left_in_pyld_ads_anti_dead_s;
    output           				hring_left_in_pyld_ak_dest_dst_bounce;
    output   [MESH_STOP_ID_SIZE-1:0]   		hring_left_in_pyld_ak_dest_dst_id;
    output           				hring_left_in_pyld_ak_dest_dst_type;
    output           				hring_left_in_pyld_ak_dest_for_me;
    output           				hring_left_in_pyld_ak_dest_reserve;
    output   [MESH_STOP_ID_SIZE-1:0]   		hring_left_in_pyld_ak_dest_src_id;
    output           				hring_left_in_pyld_ak_dest_src_type;
    output           				hring_left_in_pyld_ak_dest_valid;
    output   [MESH_AK_HDR_SIZE-1:0] 		hring_left_in_pyld_ak_hdr;
    output   [MESH_STOP_ID_SIZE-1:0]   		hring_left_in_pyld_akc_dest_dst_id;
    output           				hring_left_in_pyld_akc_dest_dst_type;
    output           				hring_left_in_pyld_akc_dest_for_me;
    output           				hring_left_in_pyld_akc_dest_reserve;
    output   [MESH_STOP_ID_SIZE-1:0]   		hring_left_in_pyld_akc_dest_src_id;
    output           				hring_left_in_pyld_akc_dest_src_type;
    output           				hring_left_in_pyld_akc_dest_valid;
    output   [MESH_AKC_HDR_SIZE-1:0]   		hring_left_in_pyld_akc_hdr;
    output   [MESH_BL_ADR_SIZE-1:0]  		hring_left_in_pyld_bl_addr;
    output   [MESH_STOP_ID_SIZE-1:0]   		hring_left_in_pyld_bl_dest_dst_id;
    output           				hring_left_in_pyld_bl_dest_dst_type;
    output           				hring_left_in_pyld_bl_dest_for_me;
    output           				hring_left_in_pyld_bl_dest_half;
    output           				hring_left_in_pyld_bl_dest_reserve;
    output   [MESH_STOP_ID_SIZE-1:0]  	 	hring_left_in_pyld_bl_dest_src_id;
    output           				hring_left_in_pyld_bl_dest_src_type;
    output           				hring_left_in_pyld_bl_dest_valid;
    output   [MESH_BL_HDR_SIZE-1:0]  		hring_left_in_pyld_bl_hdr;
    output           				hring_left_in_pyld_global_fatal;
    output           				hring_left_in_pyld_global_victim_pending;
    output           				hring_left_in_pyld_global_viral;
    output   [MESH_IV_ADR_SIZE-1:0]  		hring_left_in_pyld_iv_addr;
    output   [MESH_IV_DST_SIZE-1:0]  		hring_left_in_pyld_iv_dest;
    output           				hring_left_in_pyld_shared_vn0;
    output           				hring_left_in_pyld_thr_distress;
    // Ports for Interface hring_left_out_data
    input          				hring_left_out_data_bl_data_beparity;
    input  [MESH_BL_DATA_BE_SIZE-1:0]  	hring_left_out_data_bl_data_byte_en;
    input  [MESH_BL_DATA_SIZE-1:0] 		hring_left_out_data_bl_data_data;
    input  [MESH_BL_DATA_ECC_SIZE-1:0]   	hring_left_out_data_bl_data_ecc;
    input          				hring_left_out_data_bl_data_ecc_valid;
    input  [MESH_BL_DATA_PAR_SIZE-1:0]   	hring_left_out_data_bl_data_parity;
    input          				hring_left_out_data_bl_data_poison;
    // Ports for Interface hring_left_out_pyld
    input  [MESH_AD_ADR_SIZE-1:0]  		hring_left_out_pyld_ad_addr;
    input          				hring_left_out_pyld_ad_dest_dst_bounce;
    input  [MESH_STOP_ID_SIZE-1:0]   		hring_left_out_pyld_ad_dest_dst_id;
    input          				hring_left_out_pyld_ad_dest_dst_type;
    input          				hring_left_out_pyld_ad_dest_for_me;
    input          				hring_left_out_pyld_ad_dest_reserve;
    input  [MESH_STOP_ID_SIZE-1:0]   		hring_left_out_pyld_ad_dest_src_id;
    input          				hring_left_out_pyld_ad_dest_src_type;
    input          				hring_left_out_pyld_ad_dest_valid;
    input  [MESH_AD_HDR_SIZE-1:0]  		hring_left_out_pyld_ad_hdr;
    input          				hring_left_out_pyld_ads_anti_dead_s;
    input          				hring_left_out_pyld_ak_dest_dst_bounce;
    input  [MESH_STOP_ID_SIZE-1:0]   		hring_left_out_pyld_ak_dest_dst_id;
    input          				hring_left_out_pyld_ak_dest_dst_type;
    input          				hring_left_out_pyld_ak_dest_for_me;
    input          				hring_left_out_pyld_ak_dest_reserve;
    input  [MESH_STOP_ID_SIZE-1:0]   		hring_left_out_pyld_ak_dest_src_id;
    input          				hring_left_out_pyld_ak_dest_src_type;
    input          				hring_left_out_pyld_ak_dest_valid;
    input  [MESH_AK_HDR_SIZE-1:0]  		hring_left_out_pyld_ak_hdr;
    input  [MESH_STOP_ID_SIZE-1:0]   		hring_left_out_pyld_akc_dest_dst_id;
    input          				hring_left_out_pyld_akc_dest_dst_type;
    input          				hring_left_out_pyld_akc_dest_for_me;
    input          				hring_left_out_pyld_akc_dest_reserve;
    input  [MESH_STOP_ID_SIZE-1:0]   		hring_left_out_pyld_akc_dest_src_id;
    input          				hring_left_out_pyld_akc_dest_src_type;
    input          				hring_left_out_pyld_akc_dest_valid;
    input  [MESH_AKC_HDR_SIZE-1:0]  		hring_left_out_pyld_akc_hdr;
    input  [MESH_BL_ADR_SIZE-1:0]  		hring_left_out_pyld_bl_addr;
    input  [MESH_STOP_ID_SIZE-1:0]  		hring_left_out_pyld_bl_dest_dst_id;
    input          				hring_left_out_pyld_bl_dest_dst_type;
    input          				hring_left_out_pyld_bl_dest_for_me;
    input          				hring_left_out_pyld_bl_dest_half;
    input          				hring_left_out_pyld_bl_dest_reserve;
    input  [MESH_STOP_ID_SIZE-1:0]   		hring_left_out_pyld_bl_dest_src_id;
    input          				hring_left_out_pyld_bl_dest_src_type;
    input          				hring_left_out_pyld_bl_dest_valid;
    input  [MESH_BL_HDR_SIZE-1:0]  		hring_left_out_pyld_bl_hdr;
    input          				hring_left_out_pyld_global_fatal;
    input          				hring_left_out_pyld_global_victim_pending;
    input          				hring_left_out_pyld_global_viral;
    input  [MESH_IV_ADR_SIZE-1:0]  		hring_left_out_pyld_iv_addr;
    input  [MESH_IV_DST_SIZE-1:0]  		hring_left_out_pyld_iv_dest;
    input          				hring_left_out_pyld_shared_vn0;
    input          				hring_left_out_pyld_thr_distress;
   /****************************************************************************************
   * Bundelled signals for mux/demux
   ****************************************************************************************/
    output [MUX_DATA_WIDTH-1:0]        		hring_left_out_mux;
    input  [DEMUX_DATA_WIDTH-1:0]      		hring_left_in_demux;
   
   /****************************************************************************************/
    logic  [MUX_DATA_WIDTH-1:0]       		hring_left_out_mux;
    logic  [DEMUX_DATA_WIDTH-1:0]      		hring_left_in_demux;

assign {
    //hring_left_in_pyld_ddrt_throttle,
    //hring_left_in_pyld_dpt_throttle,
    hring_left_in_data_bl_data_beparity,
    hring_left_in_data_bl_data_byte_en,	//MESH_BL_DATA_BE_SIZE
    hring_left_in_data_bl_data_data,		//MESH_BL_DATA_SIZE
    hring_left_in_data_bl_data_ecc,		//MESH_BL_DATA_ECC_SIZE
    hring_left_in_data_bl_data_ecc_valid,
    hring_left_in_data_bl_data_parity,		//MESH_BL_DATA_PAR_SIZE
    hring_left_in_data_bl_data_poison,
    // Ports for Interface hring_left_in_pyld
    hring_left_in_pyld_ad_addr,		//MESH_AD_ADR_SIZE
    hring_left_in_pyld_ad_dest_dst_bounce,
    hring_left_in_pyld_ad_dest_dst_id,		//MESH_STOP_ID_SIZE
    hring_left_in_pyld_ad_dest_dst_type,
    hring_left_in_pyld_ad_dest_for_me,
    hring_left_in_pyld_ad_dest_reserve,
    hring_left_in_pyld_ad_dest_src_id,		//MESH_STOP_ID_SIZE
    hring_left_in_pyld_ad_dest_src_type,
    hring_left_in_pyld_ad_dest_valid,
    hring_left_in_pyld_ad_hdr,			//MESH_AD_HDR_SIZE
    hring_left_in_pyld_ads_anti_dead_s,
    hring_left_in_pyld_ak_dest_dst_bounce,
    hring_left_in_pyld_ak_dest_dst_id,		//MESH_STOP_ID_SIZE
    hring_left_in_pyld_ak_dest_dst_type,
    hring_left_in_pyld_ak_dest_for_me,
    hring_left_in_pyld_ak_dest_reserve,
    hring_left_in_pyld_ak_dest_src_id,		//MESH_STOP_ID_SIZE
    hring_left_in_pyld_ak_dest_src_type,
    hring_left_in_pyld_ak_dest_valid,
    hring_left_in_pyld_ak_hdr,			//MESH_AK_HDR_SIZE
    hring_left_in_pyld_akc_dest_dst_id,	//MESH_STOP_ID_SIZE
    hring_left_in_pyld_akc_dest_dst_type,
    hring_left_in_pyld_akc_dest_for_me,
    hring_left_in_pyld_akc_dest_reserve,
    hring_left_in_pyld_akc_dest_src_id,	//MESH_STOP_ID_SIZE
    hring_left_in_pyld_akc_dest_src_type,
    hring_left_in_pyld_akc_dest_valid,
    hring_left_in_pyld_akc_hdr,		//MESH_AKC_HDR_SIZE
    hring_left_in_pyld_bl_addr,		//MESH_BL_ADR_SIZE
    hring_left_in_pyld_bl_dest_dst_id,		//MESH_STOP_ID_SIZE
    hring_left_in_pyld_bl_dest_dst_type,
    hring_left_in_pyld_bl_dest_for_me,
    hring_left_in_pyld_bl_dest_half,
    hring_left_in_pyld_bl_dest_reserve,
    hring_left_in_pyld_bl_dest_src_id,		//MESH_STOP_ID_SIZE
    hring_left_in_pyld_bl_dest_src_type,
    hring_left_in_pyld_bl_dest_valid,
    hring_left_in_pyld_bl_hdr,			//MESH_BL_HDR_SIZE
    hring_left_in_pyld_global_fatal,
    hring_left_in_pyld_global_victim_pending,
    hring_left_in_pyld_global_viral,
    hring_left_in_pyld_iv_addr,		//MESH_IV_ADR_SIZE
    hring_left_in_pyld_iv_dest,		//MESH_IV_DST_SIZE
    hring_left_in_pyld_shared_vn0,
    hring_left_in_pyld_thr_distress
} = hring_left_in_demux;

assign hring_left_out_mux = {
    //hring_left_out_pyld_ddrt_throttle,
    //hring_left_out_pyld_dpt_throttle,
    // Ports for Interface hring_left_out_data
    hring_left_out_data_bl_data_beparity,
    hring_left_out_data_bl_data_byte_en,	//MESH_BL_DATA_BE_SIZE
    hring_left_out_data_bl_data_data, 		//MESH_BL_DATA_SIZE
    hring_left_out_data_bl_data_ecc,		//MESH_BL_DATA_ECC_SIZE
    hring_left_out_data_bl_data_ecc_valid,
    hring_left_out_data_bl_data_parity,	//MESH_BL_DATA_PAR_SIZE
    hring_left_out_data_bl_data_poison,
    // Ports for Interface hring_left_out_pyld
    hring_left_out_pyld_ad_addr,		//MESH_AD_ADR_SIZE
    hring_left_out_pyld_ad_dest_dst_bounce,
    hring_left_out_pyld_ad_dest_dst_id,	//MESH_STOP_ID_SIZE
    hring_left_out_pyld_ad_dest_dst_type,
    hring_left_out_pyld_ad_dest_for_me,
    hring_left_out_pyld_ad_dest_reserve,
    hring_left_out_pyld_ad_dest_src_id,	//MESH_STOP_ID_SIZE
    hring_left_out_pyld_ad_dest_src_type,
    hring_left_out_pyld_ad_dest_valid,
    hring_left_out_pyld_ad_hdr, 		//MESH_AD_HDR_SIZE
    hring_left_out_pyld_ads_anti_dead_s,
    hring_left_out_pyld_ak_dest_dst_bounce,
    hring_left_out_pyld_ak_dest_dst_id,	//MESH_STOP_ID_SIZE
    hring_left_out_pyld_ak_dest_dst_type,
    hring_left_out_pyld_ak_dest_for_me,
    hring_left_out_pyld_ak_dest_reserve,
    hring_left_out_pyld_ak_dest_src_id,	//MESH_STOP_ID_SIZE
    hring_left_out_pyld_ak_dest_src_type,
    hring_left_out_pyld_ak_dest_valid,
    hring_left_out_pyld_ak_hdr,		//MESH_AK_HDR_SIZE
    hring_left_out_pyld_akc_dest_dst_id,	//MESH_STOP_ID_SIZE
    hring_left_out_pyld_akc_dest_dst_type,
    hring_left_out_pyld_akc_dest_for_me,
    hring_left_out_pyld_akc_dest_reserve,
    hring_left_out_pyld_akc_dest_src_id,	//MESH_STOP_ID_SIZE
    hring_left_out_pyld_akc_dest_src_type,
    hring_left_out_pyld_akc_dest_valid,
    hring_left_out_pyld_akc_hdr,    		//MESH_AKC_HDR_SIZE 
    hring_left_out_pyld_bl_addr,     		//MESH_BL_ADR_SIZE
    hring_left_out_pyld_bl_dest_dst_id,	//MESH_STOP_ID_SIZE
    hring_left_out_pyld_bl_dest_dst_type,
    hring_left_out_pyld_bl_dest_for_me,
    hring_left_out_pyld_bl_dest_half,
    hring_left_out_pyld_bl_dest_reserve,
    hring_left_out_pyld_bl_dest_src_id,	//MESH_STOP_ID_SIZE
    hring_left_out_pyld_bl_dest_src_type,
    hring_left_out_pyld_bl_dest_valid,
    hring_left_out_pyld_bl_hdr,		//MESH_BL_HDR_SIZE
    hring_left_out_pyld_global_fatal,
    hring_left_out_pyld_global_victim_pending,
    hring_left_out_pyld_global_viral,
    hring_left_out_pyld_iv_addr,		//MESH_IV_ADR_SIZE
    hring_left_out_pyld_iv_dest,		//MESH_IV_DST_SIZE
    hring_left_out_pyld_shared_vn0,
    hring_left_out_pyld_thr_distress
}; 
 
endmodule
