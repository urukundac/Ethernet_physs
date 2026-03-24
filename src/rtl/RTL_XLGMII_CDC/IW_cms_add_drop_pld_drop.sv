module IW_cms_add_drop_pld_drop #(
  parameter AD_DROP_ADR_SIZE = 46,
  parameter AD_DROP_HDR_SIZE = 61,
  parameter MESH_STOP_ID_SIZE = 6,
  parameter AK_DROP_HDR_SIZE = 28,
  parameter AKC_DROP_HDR_SIZE = 8, 
  parameter BL_DROP_HDR_SIZE = 48,
  parameter IV_DROP_ADR_SIZE = 46,
  parameter IV_DROP_DST_SIZE = 26,
  parameter DROP_P2P_VNA_CR = 6,
  parameter BL_DROP_ADR_SIZE = 23, 
  parameter NUM_MUX_SIGNALS = (AD_DROP_ADR_SIZE + AD_DROP_HDR_SIZE + MESH_STOP_ID_SIZE + AK_DROP_HDR_SIZE +
                              MESH_STOP_ID_SIZE + AKC_DROP_HDR_SIZE + MESH_STOP_ID_SIZE + BL_DROP_ADR_SIZE +
			      BL_DROP_HDR_SIZE + MESH_STOP_ID_SIZE + IV_DROP_ADR_SIZE + IV_DROP_DST_SIZE + DROP_P2P_VNA_CR + 17),
  parameter NUM_DEMUX_SIGNALS = 5
			        

)(

    // Ports for Interface agt0_cms_pld_drop
    output                           pld_drop_AKICrdRtnInst1UnnnH,
    output                           pld_drop_AKICrdRtnUnnnH,
    output                           pld_drop_BLICrdRtnInst1UnnnH,
    output                           pld_drop_BLICrdRtnUnnnH,
    output                           pld_drop_IVICrdRtnUnnnH,
    input  [AD_DROP_ADR_SIZE-1:0]    pld_drop_ad_drop_addr,
    input                            pld_drop_ad_drop_dst_type,
    input  [AD_DROP_HDR_SIZE-1:0]    pld_drop_ad_drop_hdr,
    input  [MESH_STOP_ID_SIZE-1:0]   pld_drop_ad_drop_src_id,
    input                            pld_drop_ad_drop_src_type,
    input                            pld_drop_ad_drop_valid,
    input                            pld_drop_ak_drop_dst_type,
    input  [AK_DROP_HDR_SIZE-1:0]    pld_drop_ak_drop_hdr,
    input  [MESH_STOP_ID_SIZE-1:0]   pld_drop_ak_drop_src_id,
    input                            pld_drop_ak_drop_src_type,
    input                            pld_drop_ak_drop_valid,
    input                            pld_drop_akc_drop_dst_type,
    input  [AKC_DROP_HDR_SIZE-1:0]   pld_drop_akc_drop_hdr,
    input  [MESH_STOP_ID_SIZE-1:0]   pld_drop_akc_drop_src_id,
    input                            pld_drop_akc_drop_src_type,
    input                            pld_drop_akc_drop_valid,
    input  [BL_DROP_ADR_SIZE-1:0]    pld_drop_bl_drop_addr,
    input                            pld_drop_bl_drop_dst_type,
    input                            pld_drop_bl_drop_half,
    input  [BL_DROP_HDR_SIZE-1:0]    pld_drop_bl_drop_hdr,
    input  [MESH_STOP_ID_SIZE-1:0]   pld_drop_bl_drop_src_id,
    input                            pld_drop_bl_drop_src_type,
    input                            pld_drop_bl_drop_valid,
    input                            pld_drop_global_fatal,
    input                            pld_drop_global_victim_pending,
    input                            pld_drop_global_viral,
    input  [IV_DROP_ADR_SIZE-1:0]    pld_drop_iv_drop_addr,
    input  [IV_DROP_DST_SIZE-1:0]    pld_drop_iv_drop_dest,
    input                            pld_drop_iv_drop_valid,
    input  [DROP_P2P_VNA_CR-1:0]     pld_drop_p2p_vna_cr_drop,

    input  [NUM_DEMUX_SIGNALS-1:0]     demux_data,
    output [NUM_MUX_SIGNALS-1:0]       mux_data
);
assign mux_data = {
                    pld_drop_ad_drop_addr,
                    pld_drop_ad_drop_dst_type,
                    pld_drop_ad_drop_hdr,
                    pld_drop_ad_drop_src_id,
                    pld_drop_ad_drop_src_type,
                    pld_drop_ad_drop_valid,
                    pld_drop_ak_drop_dst_type,
                    pld_drop_ak_drop_hdr,
                    pld_drop_ak_drop_src_id,
                    pld_drop_ak_drop_src_type,
                    pld_drop_ak_drop_valid,
                    pld_drop_akc_drop_dst_type,
                    pld_drop_akc_drop_hdr,
                    pld_drop_akc_drop_src_id,
                    pld_drop_akc_drop_src_type,
                    pld_drop_akc_drop_valid,
                    pld_drop_bl_drop_addr,
                    pld_drop_bl_drop_dst_type,
                    pld_drop_bl_drop_half,
                    pld_drop_bl_drop_hdr,
                    pld_drop_bl_drop_src_id,
                    pld_drop_bl_drop_src_type,
                    pld_drop_bl_drop_valid,
                    pld_drop_global_fatal,
                    pld_drop_global_victim_pending,
                    pld_drop_global_viral,
                    pld_drop_iv_drop_addr,
                    pld_drop_iv_drop_dest,
                    pld_drop_iv_drop_valid,
                    pld_drop_p2p_vna_cr_drop
                  };

assign {
          agt0_cms_pld_drop_AKICrdRtnInst1UnnnH,
          agt0_cms_pld_drop_AKICrdRtnUnnnH,
          agt0_cms_pld_drop_BLICrdRtnInst1UnnnH,
          agt0_cms_pld_drop_BLICrdRtnUnnnH,
          agt0_cms_pld_drop_IVICrdRtnUnnnH
        } = demux_data;

endmodule
