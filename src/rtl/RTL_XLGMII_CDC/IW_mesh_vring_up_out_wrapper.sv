module IW_mesh_vring_up_out_wrapper (
//vring_up_in_pyld_ddrt_throttle,
//vring_up_in_pyld_dpt_throttle,
//vring_up_out_pyld_ddrt_throttle,
//vring_up_out_pyld_dpt_throttle,
vring_up_in_data_bl_data_beparity,
vring_up_in_data_bl_data_byte_en,
vring_up_in_data_bl_data_data,
vring_up_in_data_bl_data_ecc,
vring_up_in_data_bl_data_ecc_valid,
vring_up_in_data_bl_data_parity,
vring_up_in_data_bl_data_poison,
vring_up_in_pyld_ad_addr,
vring_up_in_pyld_ad_dest_dst_bounce,
vring_up_in_pyld_ad_dest_dst_id,
vring_up_in_pyld_ad_dest_dst_type,
vring_up_in_pyld_ad_dest_for_me,
vring_up_in_pyld_ad_dest_remote_dir,
vring_up_in_pyld_ad_dest_remote_pol,
vring_up_in_pyld_ad_dest_reserve,
vring_up_in_pyld_ad_dest_src_id,
vring_up_in_pyld_ad_dest_src_type,
vring_up_in_pyld_ad_dest_tgr_bounce,
vring_up_in_pyld_ad_dest_tgr_id,
vring_up_in_pyld_ad_dest_valid,
vring_up_in_pyld_ad_hdr,
vring_up_in_pyld_ads_anti_dead_s,
vring_up_in_pyld_ak_dest_dst_bounce,
vring_up_in_pyld_ak_dest_dst_id,
vring_up_in_pyld_ak_dest_dst_type,
vring_up_in_pyld_ak_dest_for_me,
vring_up_in_pyld_ak_dest_remote_dir,
vring_up_in_pyld_ak_dest_remote_pol,
vring_up_in_pyld_ak_dest_reserve,
vring_up_in_pyld_ak_dest_src_id,
vring_up_in_pyld_ak_dest_src_type,
vring_up_in_pyld_ak_dest_tgr_id,
vring_up_in_pyld_ak_dest_valid,
vring_up_in_pyld_ak_hdr,
vring_up_in_pyld_akc_dest_dst_id,
vring_up_in_pyld_akc_dest_dst_type,
vring_up_in_pyld_akc_dest_for_me,
vring_up_in_pyld_akc_dest_remote_dir,
vring_up_in_pyld_akc_dest_remote_pol,
vring_up_in_pyld_akc_dest_reserve,
vring_up_in_pyld_akc_dest_src_id,
vring_up_in_pyld_akc_dest_src_type,
vring_up_in_pyld_akc_dest_tgr_id,
vring_up_in_pyld_akc_dest_valid,
vring_up_in_pyld_akc_hdr,
vring_up_in_pyld_bl_addr,
vring_up_in_pyld_bl_dest_dst_id,
vring_up_in_pyld_bl_dest_dst_type,
vring_up_in_pyld_bl_dest_for_me,
vring_up_in_pyld_bl_dest_half,
vring_up_in_pyld_bl_dest_remote_dir,
vring_up_in_pyld_bl_dest_remote_pol,
vring_up_in_pyld_bl_dest_reserve,
vring_up_in_pyld_bl_dest_src_id,
vring_up_in_pyld_bl_dest_src_type,
vring_up_in_pyld_bl_dest_tgr_bounce,
vring_up_in_pyld_bl_dest_tgr_id,
vring_up_in_pyld_bl_dest_valid,
vring_up_in_pyld_bl_hdr,
vring_up_in_pyld_global_fatal,
vring_up_in_pyld_global_victim_pending,
vring_up_in_pyld_global_viral,
vring_up_in_pyld_iv_addr,
vring_up_in_pyld_iv_dest,
vring_up_in_pyld_sc_dest_for_me,
vring_up_in_pyld_sc_dest_reserve,
vring_up_in_pyld_sc_dest_src_tgr_id,
vring_up_in_pyld_sc_dest_tgr_id,
vring_up_in_pyld_sc_dest_valid,
vring_up_in_pyld_sc_hdr,
vring_up_in_pyld_shared_vn0,
vring_up_in_pyld_thr_distress,
vring_up_out_data_bl_data_beparity,
vring_up_out_data_bl_data_byte_en,
vring_up_out_data_bl_data_data,
vring_up_out_data_bl_data_ecc,
vring_up_out_data_bl_data_ecc_valid,
vring_up_out_data_bl_data_parity,
vring_up_out_data_bl_data_poison,
vring_up_out_pyld_ad_addr,
vring_up_out_pyld_ad_dest_dst_bounce,
vring_up_out_pyld_ad_dest_dst_id,
vring_up_out_pyld_ad_dest_dst_type,
vring_up_out_pyld_ad_dest_for_me,
vring_up_out_pyld_ad_dest_remote_dir,
vring_up_out_pyld_ad_dest_remote_pol,
vring_up_out_pyld_ad_dest_reserve,
vring_up_out_pyld_ad_dest_src_id,
vring_up_out_pyld_ad_dest_src_type,
vring_up_out_pyld_ad_dest_tgr_bounce,
vring_up_out_pyld_ad_dest_tgr_id,
vring_up_out_pyld_ad_dest_valid,
vring_up_out_pyld_ad_hdr,
vring_up_out_pyld_ads_anti_dead_s,
vring_up_out_pyld_ak_dest_dst_bounce,
vring_up_out_pyld_ak_dest_dst_id,
vring_up_out_pyld_ak_dest_dst_type,
vring_up_out_pyld_ak_dest_for_me,
vring_up_out_pyld_ak_dest_remote_dir,
vring_up_out_pyld_ak_dest_remote_pol,
vring_up_out_pyld_ak_dest_reserve,
vring_up_out_pyld_ak_dest_src_id,
vring_up_out_pyld_ak_dest_src_type,
vring_up_out_pyld_ak_dest_tgr_id,
vring_up_out_pyld_ak_dest_valid,
vring_up_out_pyld_ak_hdr,
vring_up_out_pyld_akc_dest_dst_id,
vring_up_out_pyld_akc_dest_dst_type,
vring_up_out_pyld_akc_dest_for_me,
vring_up_out_pyld_akc_dest_remote_dir,
vring_up_out_pyld_akc_dest_remote_pol,
vring_up_out_pyld_akc_dest_reserve,
vring_up_out_pyld_akc_dest_src_id,
vring_up_out_pyld_akc_dest_src_type,
vring_up_out_pyld_akc_dest_tgr_id,
vring_up_out_pyld_akc_dest_valid,
vring_up_out_pyld_akc_hdr,
vring_up_out_pyld_bl_addr,
vring_up_out_pyld_bl_dest_dst_id,
vring_up_out_pyld_bl_dest_dst_type,
vring_up_out_pyld_bl_dest_for_me,
vring_up_out_pyld_bl_dest_half,
vring_up_out_pyld_bl_dest_remote_dir,
vring_up_out_pyld_bl_dest_remote_pol,
vring_up_out_pyld_bl_dest_reserve,
vring_up_out_pyld_bl_dest_src_id,
vring_up_out_pyld_bl_dest_src_type,
vring_up_out_pyld_bl_dest_tgr_bounce,
vring_up_out_pyld_bl_dest_tgr_id,
vring_up_out_pyld_bl_dest_valid,
vring_up_out_pyld_bl_hdr,
vring_up_out_pyld_global_fatal,
vring_up_out_pyld_global_victim_pending,
vring_up_out_pyld_global_viral,
vring_up_out_pyld_iv_addr,
vring_up_out_pyld_iv_dest,
vring_up_out_pyld_sc_dest_for_me,
vring_up_out_pyld_sc_dest_reserve,
vring_up_out_pyld_sc_dest_src_tgr_id,
vring_up_out_pyld_sc_dest_tgr_id,
vring_up_out_pyld_sc_dest_valid,
vring_up_out_pyld_sc_hdr,
vring_up_out_pyld_shared_vn0,
vring_up_out_pyld_thr_distress,
vring_up_out_mux,
vring_up_in_demux
);

parameter MESH_TGR_ID_SIZE = 4; //only for vring
parameter MESH_SC_FIELD_SIZE = 6; //only for vring
parameter MESH_SC_DST_SIZE = 6; //only for vring
parameter MESH_SC_HDR_SIZE = 8; //only for vring
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
parameter DEMUX_DATA_WIDTH = 692;
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
//+ 1
//+ 1
//+ MESH_STOP_ID_SIZE
//+ 1
//+ 1
//+ MESH_TGR_ID_SIZE
//+ 1
//+ MESH_AD_HDR_SIZE
//+ 1
//+ 1
//+ MESH_STOP_ID_SIZE
//+ 1
//+ 1
//+ 1
//+ 1
//+ 1
//+ MESH_STOP_ID_SIZE
//+ 1
//+ MESH_TGR_ID_SIZE
//+ 1
//+ MESH_AK_HDR_SIZE
//+ MESH_STOP_ID_SIZE
//+ 1
//+ 1
//+ 1
//+ 1
//+ 1
//+ MESH_STOP_ID_SIZE
//+ 1
//+ MESH_TGR_ID_SIZE
//+ 1
//+ MESH_AKC_HDR_SIZE
//+ MESH_BL_ADR_SIZE
//+ MESH_STOP_ID_SIZE
//+ 1
//+ 1
//+ 1
//+ 1
//+ 1
//+ 1
//+ MESH_STOP_ID_SIZE
//+ 1
//+ 1
//+ MESH_TGR_ID_SIZE
//+ 1
//+ MESH_BL_HDR_SIZE
//+ 1
//+ 1
//+ 1
//+ MESH_IV_ADR_SIZE
//+ MESH_IV_DST_SIZE
//+ 1
//+ 1
//+ MESH_TGR_ID_SIZE
//+ MESH_TGR_ID_SIZE
//+ 1
//+ MESH_SC_HDR_SIZE
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
//+ 1
//+ 1
//+ MESH_STOP_ID_SIZE
//+ 1
//+ 1
//+ MESH_TGR_ID_SIZE
//+ 1
//+ MESH_AD_HDR_SIZE
//+ 1
//+ 1
//+ MESH_STOP_ID_SIZE
//+ 1
//+ 1
//+ 1
//+ 1
//+ 1
//+ MESH_STOP_ID_SIZE
//+ 1
//+ MESH_TGR_ID_SIZE   		
//+ 1
//+ MESH_AK_HDR_SIZE
//+ MESH_STOP_ID_SIZE
//+ 1
//+ 1
//+ 1
//+ 1
//+ 1
//+ MESH_STOP_ID_SIZE
//+ 1
//+ MESH_TGR_ID_SIZE
//+ 1
//+ MESH_AKC_HDR_SIZE
//+ MESH_BL_ADR_SIZE
//+ MESH_STOP_ID_SIZE
//+ 1
//+ 1
//+ 1
//+ 1
//+ 1
//+ 1
//+ MESH_STOP_ID_SIZE
//+ 1
//+ 1
//+ MESH_TGR_ID_SIZE
//+ 1
//+ MESH_BL_HDR_SIZE
//+ 1
//+ 1
//+ 1
//+ MESH_IV_ADR_SIZE
//+ MESH_IV_DST_SIZE
//+ 1
//+ 1
//+ MESH_TGR_ID_SIZE
//+ MESH_TGR_ID_SIZE
//+ 1
//+ MESH_SC_HDR_SIZE
//+ 1
//+ 1
//};

parameter MUX_DATA_WIDTH = 692;
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
//+ 1
//+ 1
//+ MESH_STOP_ID_SIZE
//+ 1
//+ 1
//+ MESH_TGR_ID_SIZE
//+ 1
//+ MESH_AD_HDR_SIZE
//+ 1
//+ 1
//+ MESH_STOP_ID_SIZE
//+ 1
//+ 1
//+ 1
//+ 1
//+ 1
//+ MESH_STOP_ID_SIZE
//+ 1
//+ MESH_TGR_ID_SIZE
//+ 1
//+ MESH_AK_HDR_SIZE
//+ MESH_STOP_ID_SIZE
//+ 1
//+ 1
//+ 1
//+ 1
//+ 1
//+ MESH_STOP_ID_SIZE
//+ 1
//+ MESH_TGR_ID_SIZE
//+ 1
//+ MESH_AKC_HDR_SIZE
//+ MESH_BL_ADR_SIZE
//+ MESH_STOP_ID_SIZE
//+ 1
//+ 1
//+ 1
//+ 1
//+ 1
//+ 1
//+ MESH_STOP_ID_SIZE
//+ 1
//+ 1
//+ MESH_TGR_ID_SIZE
//+ 1
//+ MESH_BL_HDR_SIZE
//+ 1
//+ 1
//+ 1
//+ MESH_IV_ADR_SIZE
//+ MESH_IV_DST_SIZE
//+ 1
//+ 1
//+ MESH_TGR_ID_SIZE
//+ MESH_TGR_ID_SIZE
//+ 1
//+ MESH_SC_HDR_SIZE
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
//+ 1
//+ 1
//+ MESH_STOP_ID_SIZE
//+ 1
//+ 1
//+ MESH_TGR_ID_SIZE
//+ 1
//+ MESH_AD_HDR_SIZE
//+ 1
//+ 1
//+ MESH_STOP_ID_SIZE
//+ 1
//+ 1
//+ 1
//+ 1
//+ 1
//+ MESH_STOP_ID_SIZE
//+ 1
//+ MESH_TGR_ID_SIZE
//+ 1
//+ MESH_AK_HDR_SIZE
//+ MESH_STOP_ID_SIZE
//+ 1
//+ 1
//+ 1
//+ 1
//+ 1
//+ MESH_STOP_ID_SIZE
//+ 1
//+ MESH_TGR_ID_SIZE
//+ 1
//+ MESH_AKC_HDR_SIZE 
//+ MESH_BL_ADR_SIZE
//+ MESH_STOP_ID_SIZE
//+ 1
//+ 1
//+ 1
//+ 1
//+ 1
//+ 1
//+ MESH_STOP_ID_SIZE
//+ 1
//+ 1
//+ MESH_TGR_ID_SIZE
//+ 1
//+ MESH_BL_HDR_SIZE
//+ 1
//+ 1
//+ 1
//+ MESH_IV_ADR_SIZE
//+ MESH_IV_DST_SIZE
//+ 1
//+ 1
//+ MESH_TGR_ID_SIZE
//+ MESH_TGR_ID_SIZE
//+ 1
//+ MESH_SC_HDR_SIZE
//+ 1
//+ 1
//};  

    //output           				vring_up_in_pyld_ddrt_throttle;
    //output           				vring_up_in_pyld_dpt_throttle;
    //input          				vring_up_out_pyld_ddrt_throttle;
    //input          				vring_up_out_pyld_dpt_throttle;
    // Ports for Interface vring_up_in_data
    output           				vring_up_in_data_bl_data_beparity;
    output   [MESH_BL_DATA_BE_SIZE-1:0]  	vring_up_in_data_bl_data_byte_en;
    output   [MESH_BL_DATA_SIZE-1:0] 		vring_up_in_data_bl_data_data;
    output   [MESH_BL_DATA_ECC_SIZE-1:0]  	vring_up_in_data_bl_data_ecc;
    output           				vring_up_in_data_bl_data_ecc_valid;
    output   [MESH_BL_DATA_PAR_SIZE-1:0]   	vring_up_in_data_bl_data_parity;
    output          	 			vring_up_in_data_bl_data_poison;
    // Ports for Interface vring_up_in_pyld
    output   [MESH_AD_ADR_SIZE-1:0]  		vring_up_in_pyld_ad_addr;
    output           				vring_up_in_pyld_ad_dest_dst_bounce;
    output   [MESH_STOP_ID_SIZE-1:0]   		vring_up_in_pyld_ad_dest_dst_id;
    output           				vring_up_in_pyld_ad_dest_dst_type;
    output           				vring_up_in_pyld_ad_dest_for_me;
    output           				vring_up_in_pyld_ad_dest_remote_dir;
    output           				vring_up_in_pyld_ad_dest_remote_pol;
    output           				vring_up_in_pyld_ad_dest_reserve;
    output   [MESH_STOP_ID_SIZE-1:0]   		vring_up_in_pyld_ad_dest_src_id;
    output           				vring_up_in_pyld_ad_dest_src_type;
    output           				vring_up_in_pyld_ad_dest_tgr_bounce;
    output   [MESH_TGR_ID_SIZE-1:0]   		vring_up_in_pyld_ad_dest_tgr_id;
    output           				vring_up_in_pyld_ad_dest_valid;
    output   [MESH_AD_HDR_SIZE-1:0]  		vring_up_in_pyld_ad_hdr;
    output           				vring_up_in_pyld_ads_anti_dead_s;
    output           				vring_up_in_pyld_ak_dest_dst_bounce;
    output   [MESH_STOP_ID_SIZE-1:0]   		vring_up_in_pyld_ak_dest_dst_id;
    output           				vring_up_in_pyld_ak_dest_dst_type;
    output           				vring_up_in_pyld_ak_dest_for_me;
    output           				vring_up_in_pyld_ak_dest_remote_dir;
    output           				vring_up_in_pyld_ak_dest_remote_pol;
    output           				vring_up_in_pyld_ak_dest_reserve;
    output   [MESH_STOP_ID_SIZE-1:0]   		vring_up_in_pyld_ak_dest_src_id;
    output           				vring_up_in_pyld_ak_dest_src_type;
    output   [MESH_TGR_ID_SIZE-1:0]   		vring_up_in_pyld_ak_dest_tgr_id;
    output           				vring_up_in_pyld_ak_dest_valid;
    output   [MESH_AK_HDR_SIZE-1:0] 		vring_up_in_pyld_ak_hdr;
    output   [MESH_STOP_ID_SIZE-1:0]   		vring_up_in_pyld_akc_dest_dst_id;
    output           				vring_up_in_pyld_akc_dest_dst_type;
    output           				vring_up_in_pyld_akc_dest_for_me;
    output           				vring_up_in_pyld_akc_dest_remote_dir;
    output           				vring_up_in_pyld_akc_dest_remote_pol;
    output           				vring_up_in_pyld_akc_dest_reserve;
    output   [MESH_STOP_ID_SIZE-1:0]   		vring_up_in_pyld_akc_dest_src_id;
    output           				vring_up_in_pyld_akc_dest_src_type;
    output   [MESH_TGR_ID_SIZE-1:0]   		vring_up_in_pyld_akc_dest_tgr_id;
    output           				vring_up_in_pyld_akc_dest_valid;
    output   [MESH_AKC_HDR_SIZE-1:0]   		vring_up_in_pyld_akc_hdr;
    output   [MESH_BL_ADR_SIZE-1:0]  		vring_up_in_pyld_bl_addr;
    output   [MESH_STOP_ID_SIZE-1:0]   		vring_up_in_pyld_bl_dest_dst_id;
    output           				vring_up_in_pyld_bl_dest_dst_type;
    output           				vring_up_in_pyld_bl_dest_for_me;
    output           				vring_up_in_pyld_bl_dest_half;
    output           				vring_up_in_pyld_bl_dest_remote_dir;
    output           				vring_up_in_pyld_bl_dest_remote_pol;
    output           				vring_up_in_pyld_bl_dest_reserve;
    output   [MESH_STOP_ID_SIZE-1:0]  	 	vring_up_in_pyld_bl_dest_src_id;
    output           				vring_up_in_pyld_bl_dest_src_type;
    output          				vring_up_in_pyld_bl_dest_tgr_bounce;
    output   [MESH_TGR_ID_SIZE-1:0]   		vring_up_in_pyld_bl_dest_tgr_id;
    output           				vring_up_in_pyld_bl_dest_valid;
    output   [MESH_BL_HDR_SIZE-1:0]  		vring_up_in_pyld_bl_hdr;
    output           				vring_up_in_pyld_global_fatal;
    output           				vring_up_in_pyld_global_victim_pending;
    output           				vring_up_in_pyld_global_viral;
    output   [MESH_IV_ADR_SIZE-1:0]  		vring_up_in_pyld_iv_addr;
    output   [MESH_IV_DST_SIZE-1:0]  		vring_up_in_pyld_iv_dest;
    output           				vring_up_in_pyld_sc_dest_for_me;
    output           				vring_up_in_pyld_sc_dest_reserve;
    output   [MESH_TGR_ID_SIZE-1:0]   		vring_up_in_pyld_sc_dest_src_tgr_id;
    output   [MESH_TGR_ID_SIZE-1:0]   		vring_up_in_pyld_sc_dest_tgr_id;
    output           				vring_up_in_pyld_sc_dest_valid;
    output   [MESH_SC_HDR_SIZE-1:0]   		vring_up_in_pyld_sc_hdr;
    output           				vring_up_in_pyld_shared_vn0;
    output           				vring_up_in_pyld_thr_distress;
    // Ports for Interface vring_up_out_data
    input          				vring_up_out_data_bl_data_beparity;
    input  [MESH_BL_DATA_BE_SIZE-1:0]  	vring_up_out_data_bl_data_byte_en;
    input  [MESH_BL_DATA_SIZE-1:0] 		vring_up_out_data_bl_data_data;
    input  [MESH_BL_DATA_ECC_SIZE-1:0]   	vring_up_out_data_bl_data_ecc;
    input          				vring_up_out_data_bl_data_ecc_valid;
    input  [MESH_BL_DATA_PAR_SIZE-1:0]   	vring_up_out_data_bl_data_parity;
    input          				vring_up_out_data_bl_data_poison;
    // Ports for Interface vring_up_out_pyld
    input  [MESH_AD_ADR_SIZE-1:0]  		vring_up_out_pyld_ad_addr;
    input          				vring_up_out_pyld_ad_dest_dst_bounce;
    input  [MESH_STOP_ID_SIZE-1:0]   		vring_up_out_pyld_ad_dest_dst_id;
    input          				vring_up_out_pyld_ad_dest_dst_type;
    input          				vring_up_out_pyld_ad_dest_for_me;
    input          				vring_up_out_pyld_ad_dest_remote_dir;
    input          				vring_up_out_pyld_ad_dest_remote_pol;
    input          				vring_up_out_pyld_ad_dest_reserve;
    input  [MESH_STOP_ID_SIZE-1:0]   		vring_up_out_pyld_ad_dest_src_id;
    input          				vring_up_out_pyld_ad_dest_src_type;
    input          				vring_up_out_pyld_ad_dest_tgr_bounce;
    input  [MESH_TGR_ID_SIZE-1:0]   		vring_up_out_pyld_ad_dest_tgr_id;
    input          				vring_up_out_pyld_ad_dest_valid;
    input  [MESH_AD_HDR_SIZE-1:0]  		vring_up_out_pyld_ad_hdr;
    input          				vring_up_out_pyld_ads_anti_dead_s;
    input          				vring_up_out_pyld_ak_dest_dst_bounce;
    input  [MESH_STOP_ID_SIZE-1:0]   		vring_up_out_pyld_ak_dest_dst_id;
    input          				vring_up_out_pyld_ak_dest_dst_type;
    input          				vring_up_out_pyld_ak_dest_for_me;
    input          				vring_up_out_pyld_ak_dest_remote_dir;
    input          				vring_up_out_pyld_ak_dest_remote_pol;
    input          				vring_up_out_pyld_ak_dest_reserve;
    input  [MESH_STOP_ID_SIZE-1:0]   		vring_up_out_pyld_ak_dest_src_id;
    input          				vring_up_out_pyld_ak_dest_src_type;
    input  [MESH_TGR_ID_SIZE-1:0]   		vring_up_out_pyld_ak_dest_tgr_id;
    input          				vring_up_out_pyld_ak_dest_valid;
    input  [MESH_AK_HDR_SIZE-1:0]  		vring_up_out_pyld_ak_hdr;
    input  [MESH_STOP_ID_SIZE-1:0]   		vring_up_out_pyld_akc_dest_dst_id;
    input          				vring_up_out_pyld_akc_dest_dst_type;
    input          				vring_up_out_pyld_akc_dest_for_me;
    input          				vring_up_out_pyld_akc_dest_remote_dir;
    input          				vring_up_out_pyld_akc_dest_remote_pol;
    input          				vring_up_out_pyld_akc_dest_reserve;
    input  [MESH_STOP_ID_SIZE-1:0]   		vring_up_out_pyld_akc_dest_src_id;
    input          				vring_up_out_pyld_akc_dest_src_type;
    input  [MESH_TGR_ID_SIZE-1:0]   		vring_up_out_pyld_akc_dest_tgr_id;	
    input          				vring_up_out_pyld_akc_dest_valid;
    input  [MESH_AKC_HDR_SIZE-1:0]  		vring_up_out_pyld_akc_hdr;
    input  [MESH_BL_ADR_SIZE-1:0]  		vring_up_out_pyld_bl_addr;
    input  [MESH_STOP_ID_SIZE-1:0]  		vring_up_out_pyld_bl_dest_dst_id;
    input          				vring_up_out_pyld_bl_dest_dst_type;
    input          				vring_up_out_pyld_bl_dest_for_me;
    input          				vring_up_out_pyld_bl_dest_half;
    input          				vring_up_out_pyld_bl_dest_remote_dir;
    input          				vring_up_out_pyld_bl_dest_remote_pol;
    input          				vring_up_out_pyld_bl_dest_reserve;
    input  [MESH_STOP_ID_SIZE-1:0]   		vring_up_out_pyld_bl_dest_src_id;
    input          				vring_up_out_pyld_bl_dest_src_type;
    input          				vring_up_out_pyld_bl_dest_tgr_bounce;
    input  [MESH_TGR_ID_SIZE-1:0]   		vring_up_out_pyld_bl_dest_tgr_id;
    input          				vring_up_out_pyld_bl_dest_valid;
    input  [MESH_BL_HDR_SIZE-1:0]  		vring_up_out_pyld_bl_hdr;
    input          				vring_up_out_pyld_global_fatal;
    input          				vring_up_out_pyld_global_victim_pending;
    input          				vring_up_out_pyld_global_viral;
    input  [MESH_IV_ADR_SIZE-1:0]  		vring_up_out_pyld_iv_addr;
    input  [MESH_IV_DST_SIZE-1:0]  		vring_up_out_pyld_iv_dest;
    input           				vring_up_out_pyld_sc_dest_for_me;
    input           				vring_up_out_pyld_sc_dest_reserve;
    input  [MESH_TGR_ID_SIZE-1:0]   		vring_up_out_pyld_sc_dest_src_tgr_id;
    input  [MESH_TGR_ID_SIZE-1:0]   		vring_up_out_pyld_sc_dest_tgr_id;
    input           				vring_up_out_pyld_sc_dest_valid;
    input  [MESH_SC_HDR_SIZE-1:0]   		vring_up_out_pyld_sc_hdr;
    input          				vring_up_out_pyld_shared_vn0;
    input          				vring_up_out_pyld_thr_distress;
   /****************************************************************************************
   * Bundelled signals for mux/demux
   ****************************************************************************************/
    output [MUX_DATA_WIDTH-1:0]        		vring_up_out_mux;
    input  [DEMUX_DATA_WIDTH-1:0]       	vring_up_in_demux;
   
   /****************************************************************************************/
    logic  [MUX_DATA_WIDTH-1:0]       		vring_up_out_mux;
    logic  [DEMUX_DATA_WIDTH-1:0]      		vring_up_in_demux;

assign {
    //vring_up_in_pyld_ddrt_throttle,
    //vring_up_in_pyld_dpt_throttle,
    vring_up_in_data_bl_data_beparity,
    vring_up_in_data_bl_data_byte_en,		//MESH_BL_DATA_BE_SIZE
    vring_up_in_data_bl_data_data,		//MESH_BL_DATA_SIZE
    vring_up_in_data_bl_data_ecc,		//MESH_BL_DATA_ECC_SIZE
    vring_up_in_data_bl_data_ecc_valid,
    vring_up_in_data_bl_data_parity,		//MESH_BL_DATA_PAR_SIZE
    vring_up_in_data_bl_data_poison,
    // Ports for Interface vring_up_in_pyld
    vring_up_in_pyld_ad_addr,			//MESH_AD_ADR_SIZE
    vring_up_in_pyld_ad_dest_dst_bounce,
    vring_up_in_pyld_ad_dest_dst_id,		//MESH_STOP_ID_SIZE
    vring_up_in_pyld_ad_dest_dst_type,
    vring_up_in_pyld_ad_dest_for_me,
    vring_up_in_pyld_ad_dest_remote_dir,
    vring_up_in_pyld_ad_dest_remote_pol,
    vring_up_in_pyld_ad_dest_reserve,
    vring_up_in_pyld_ad_dest_src_id,		//MESH_STOP_ID_SIZE
    vring_up_in_pyld_ad_dest_src_type,
    vring_up_in_pyld_ad_dest_tgr_bounce,
    vring_up_in_pyld_ad_dest_tgr_id,		//MESH_TGR_ID_SIZE
    vring_up_in_pyld_ad_dest_valid,
    vring_up_in_pyld_ad_hdr,			//MESH_AD_HDR_SIZE
    vring_up_in_pyld_ads_anti_dead_s,
    vring_up_in_pyld_ak_dest_dst_bounce,
    vring_up_in_pyld_ak_dest_dst_id,		//MESH_STOP_ID_SIZE
    vring_up_in_pyld_ak_dest_dst_type,
    vring_up_in_pyld_ak_dest_for_me,
    vring_up_in_pyld_ak_dest_remote_dir,
    vring_up_in_pyld_ak_dest_remote_pol,
    vring_up_in_pyld_ak_dest_reserve,
    vring_up_in_pyld_ak_dest_src_id,		//MESH_STOP_ID_SIZE
    vring_up_in_pyld_ak_dest_src_type,
    vring_up_in_pyld_ak_dest_tgr_id,
    vring_up_in_pyld_ak_dest_valid,
    vring_up_in_pyld_ak_hdr,			//MESH_AK_HDR_SIZE
    vring_up_in_pyld_akc_dest_dst_id,		//MESH_STOP_ID_SIZE
    vring_up_in_pyld_akc_dest_dst_type,
    vring_up_in_pyld_akc_dest_for_me,
    vring_up_in_pyld_akc_dest_remote_dir,
    vring_up_in_pyld_akc_dest_remote_pol,
    vring_up_in_pyld_akc_dest_reserve,
    vring_up_in_pyld_akc_dest_src_id,		//MESH_STOP_ID_SIZE
    vring_up_in_pyld_akc_dest_src_type,
    vring_up_in_pyld_akc_dest_tgr_id,		//MESH_TGR_ID_SIZE
    vring_up_in_pyld_akc_dest_valid,
    vring_up_in_pyld_akc_hdr,			//MESH_AKC_HDR_SIZE
    vring_up_in_pyld_bl_addr,			//MESH_BL_ADR_SIZE
    vring_up_in_pyld_bl_dest_dst_id,		//MESH_STOP_ID_SIZE
    vring_up_in_pyld_bl_dest_dst_type,
    vring_up_in_pyld_bl_dest_for_me,
    vring_up_in_pyld_bl_dest_half,
    vring_up_in_pyld_bl_dest_remote_dir,
    vring_up_in_pyld_bl_dest_remote_pol,
    vring_up_in_pyld_bl_dest_reserve,
    vring_up_in_pyld_bl_dest_src_id,		//MESH_STOP_ID_SIZE
    vring_up_in_pyld_bl_dest_src_type,
    vring_up_in_pyld_bl_dest_tgr_bounce,
    vring_up_in_pyld_bl_dest_tgr_id,		//MESH_TGR_ID_SIZE
    vring_up_in_pyld_bl_dest_valid,
    vring_up_in_pyld_bl_hdr,			//MESH_BL_HDR_SIZE
    vring_up_in_pyld_global_fatal,
    vring_up_in_pyld_global_victim_pending,
    vring_up_in_pyld_global_viral,
    vring_up_in_pyld_iv_addr,			//MESH_IV_ADR_SIZE
    vring_up_in_pyld_iv_dest,			//MESH_IV_DST_SIZE
    vring_up_in_pyld_sc_dest_for_me,
    vring_up_in_pyld_sc_dest_reserve,
    vring_up_in_pyld_sc_dest_src_tgr_id,	//MESH_TGR_ID_SIZE
    vring_up_in_pyld_sc_dest_tgr_id,		//MESH_TGR_ID_SIZE
    vring_up_in_pyld_sc_dest_valid,
    vring_up_in_pyld_sc_hdr,			//MESH_SC_HDR_SIZE
    vring_up_in_pyld_shared_vn0,
    vring_up_in_pyld_thr_distress
} = vring_up_in_demux;

assign vring_up_out_mux = {
    //vring_up_out_pyld_ddrt_throttle,
    //vring_up_out_pyld_dpt_throttle,
    // Ports for Interface vring_up_out_data
    vring_up_out_data_bl_data_beparity,
    vring_up_out_data_bl_data_byte_en,		//MESH_BL_DATA_BE_SIZE
    vring_up_out_data_bl_data_data, 		//MESH_BL_DATA_SIZE
    vring_up_out_data_bl_data_ecc,		//MESH_BL_DATA_ECC_SIZE
    vring_up_out_data_bl_data_ecc_valid,
    vring_up_out_data_bl_data_parity,		//MESH_BL_DATA_PAR_SIZE
    vring_up_out_data_bl_data_poison,
    // Ports for Interface vring_up_out_pyld
    vring_up_out_pyld_ad_addr,			//MESH_AD_ADR_SIZE
    vring_up_out_pyld_ad_dest_dst_bounce,
    vring_up_out_pyld_ad_dest_dst_id,		//MESH_STOP_ID_SIZE
    vring_up_out_pyld_ad_dest_dst_type,
    vring_up_out_pyld_ad_dest_for_me,
    vring_up_out_pyld_ad_dest_remote_dir,
    vring_up_out_pyld_ad_dest_remote_pol,
    vring_up_out_pyld_ad_dest_reserve,
    vring_up_out_pyld_ad_dest_src_id,		//MESH_STOP_ID_SIZE
    vring_up_out_pyld_ad_dest_src_type,
    vring_up_out_pyld_ad_dest_tgr_bounce,
    vring_up_out_pyld_ad_dest_tgr_id,		//MESH_TGR_ID_SIZE
    vring_up_out_pyld_ad_dest_valid,
    vring_up_out_pyld_ad_hdr, 			//MESH_AD_HDR_SIZE
    vring_up_out_pyld_ads_anti_dead_s,
    vring_up_out_pyld_ak_dest_dst_bounce,
    vring_up_out_pyld_ak_dest_dst_id,		//MESH_STOP_ID_SIZE
    vring_up_out_pyld_ak_dest_dst_type,
    vring_up_out_pyld_ak_dest_for_me,
    vring_up_out_pyld_ak_dest_remote_dir,
    vring_up_out_pyld_ak_dest_remote_pol,
    vring_up_out_pyld_ak_dest_reserve,
    vring_up_out_pyld_ak_dest_src_id,		//MESH_STOP_ID_SIZE
    vring_up_out_pyld_ak_dest_src_type,
    vring_up_out_pyld_ak_dest_tgr_id,		//MESH_TGR_ID_SIZE
    vring_up_out_pyld_ak_dest_valid,
    vring_up_out_pyld_ak_hdr,			//MESH_AK_HDR_SIZE
    vring_up_out_pyld_akc_dest_dst_id,		//MESH_STOP_ID_SIZE
    vring_up_out_pyld_akc_dest_dst_type,
    vring_up_out_pyld_akc_dest_for_me,
    vring_up_out_pyld_akc_dest_remote_dir,
    vring_up_out_pyld_akc_dest_remote_pol,
    vring_up_out_pyld_akc_dest_reserve,
    vring_up_out_pyld_akc_dest_src_id,		//MESH_STOP_ID_SIZE
    vring_up_out_pyld_akc_dest_src_type,
    vring_up_out_pyld_akc_dest_tgr_id,		//MESH_TGR_ID_SIZE
    vring_up_out_pyld_akc_dest_valid,
    vring_up_out_pyld_akc_hdr,    		//MESH_AKC_HDR_SIZE 
    vring_up_out_pyld_bl_addr,     		//MESH_BL_ADR_SIZE
    vring_up_out_pyld_bl_dest_dst_id,		//MESH_STOP_ID_SIZE
    vring_up_out_pyld_bl_dest_dst_type,
    vring_up_out_pyld_bl_dest_for_me,
    vring_up_out_pyld_bl_dest_half,
    vring_up_out_pyld_bl_dest_remote_dir,
    vring_up_out_pyld_bl_dest_remote_pol,
    vring_up_out_pyld_bl_dest_reserve,
    vring_up_out_pyld_bl_dest_src_id,		//MESH_STOP_ID_SIZE
    vring_up_out_pyld_bl_dest_src_type,
    vring_up_out_pyld_bl_dest_tgr_bounce,
    vring_up_out_pyld_bl_dest_tgr_id,		//MESH_TGR_ID_SIZE
    vring_up_out_pyld_bl_dest_valid,
    vring_up_out_pyld_bl_hdr,			//MESH_BL_HDR_SIZE
    vring_up_out_pyld_global_fatal,
    vring_up_out_pyld_global_victim_pending,
    vring_up_out_pyld_global_viral,
    vring_up_out_pyld_iv_addr,			//MESH_IV_ADR_SIZE
    vring_up_out_pyld_iv_dest,			//MESH_IV_DST_SIZE
    vring_up_out_pyld_sc_dest_for_me,
    vring_up_out_pyld_sc_dest_reserve,
    vring_up_out_pyld_sc_dest_src_tgr_id,	//MESH_TGR_ID_SIZE
    vring_up_out_pyld_sc_dest_tgr_id,		//MESH_TGR_ID_SIZE
    vring_up_out_pyld_sc_dest_valid,
    vring_up_out_pyld_sc_hdr,			//MESH_SC_HDR_SIZE
    vring_up_out_pyld_shared_vn0,
    vring_up_out_pyld_thr_distress
}; 
 
endmodule
