`ifndef __VISA_IT__
`ifndef INTEL_GLOBAL_VISA_DISABLE

(* inserted_by="VISA IT" *) assign visaPrbsFrom_fxp_cxp_cse_osm[  0:  0]                                           = pll_push                               ;
(* inserted_by="VISA IT" *) assign visaPrbsFrom_fxp_cxp_cse_osm[  1:  1]                                           = pll_pop                                ;
(* inserted_by="VISA IT" *) assign visaPrbsFrom_fxp_cxp_cse_osm[  2:  2]                                           = match                                  ;
(* inserted_by="VISA IT" *) assign visaPrbsFrom_fxp_cxp_cse_osm[  6:  3]                                           = first_free_entry[3:0]                  ;
(* inserted_by="VISA IT" *) assign visaPrbsFrom_fxp_cxp_cse_osm[ 10:  7]                                           = first_free_entry[7:4]                  ;
(* inserted_by="VISA IT" *) assign visaPrbsFrom_fxp_cxp_cse_osm[ 14: 11]                                           = match_index[3:0]                       ;
(* inserted_by="VISA IT" *) assign visaPrbsFrom_fxp_cxp_cse_osm[ 18: 15]                                           = match_index[7:4]                       ;
(* inserted_by="VISA IT" *) assign visaPrbsFrom_fxp_cxp_cse_osm[ 22: 19]                                           = pll_pop_index[3:0]                     ;
(* inserted_by="VISA IT" *) assign visaPrbsFrom_fxp_cxp_cse_osm[ 26: 23]                                           = pll_pop_index[7:4]                     ;
(* inserted_by="VISA IT" *) assign visaPrbsFrom_fxp_cxp_cse_osm[ 30: 27]                                           = new_pll_entry.trans_id[3:0]            ;
(* inserted_by="VISA IT" *) assign visaPrbsFrom_fxp_cxp_cse_osm[ 34: 31]                                           = new_pll_entry.trans_id[7:4]            ;
(* inserted_by="VISA IT" *) assign visaPrbsFrom_fxp_cxp_cse_osm[ 38: 35]                                           = new_pll_entry.trans_id[11:8]           ;
(* inserted_by="VISA IT" *) assign visaPrbsFrom_fxp_cxp_cse_osm[ 42: 39]                                           = new_pll_entry.trans_id[15:12]          ;
(* inserted_by="VISA IT" *) assign visaPrbsFrom_fxp_cxp_cse_osm[ 46: 43]                                           = new_pll_entry.trans_id[19:16]          ;
(* inserted_by="VISA IT" *) assign visaPrbsFrom_fxp_cxp_cse_osm[ 50: 47]                                           = new_pll_entry.trans_id[23:20]          ;
(* inserted_by="VISA IT" *) assign visaPrbsFrom_fxp_cxp_cse_osm[ 53: 51]                                           = new_pll_entry.trans_type[2:0]          ;
(* inserted_by="VISA IT" *) assign visaPrbsFrom_fxp_cxp_cse_osm[ 56: 54]                                           = new_pll_entry.client_id[2:0]           ;
(* inserted_by="VISA IT" *) assign visaPrbsFrom_fxp_cxp_cse_osm[ 58: 57]                                           = new_pll_entry.obj_size[1:0]            ;
(* inserted_by="VISA IT" *) assign visaPrbsFrom_fxp_cxp_cse_osm[ 62: 59]                                           = new_pll_entry.banks[3:0]               ;
(* inserted_by="VISA IT" *) assign visaPrbsFrom_fxp_cxp_cse_osm[ 66: 63]                                           = new_pll_entry.banks[7:4]               ;
(* inserted_by="VISA IT" *) assign visaPrbsFrom_fxp_cxp_cse_osm[ 70: 67]                                           = new_pll_entry.pkt_label[3:0]           ;
(* inserted_by="VISA IT" *) assign visaPrbsFrom_fxp_cxp_cse_osm[ 74: 71]                                           = new_pll_entry.pkt_label[7:4]           ;
(* inserted_by="VISA IT" *) assign visaPrbsFrom_fxp_cxp_cse_osm[ 77: 75]                                           = new_pll_entry.pkt_label[10:8]          ;
(* inserted_by="VISA IT" *) assign visaPrbsFrom_fxp_cxp_cse_osm[ 83: 78]                                           = new_pll_entry.pf[5:0]                  ;
(* inserted_by="VISA IT" *) assign visaPrbsFrom_fxp_cxp_cse_osm[ 84: 84]                                           = new_pll_entry.last                     ;
(* inserted_by="VISA IT" *) assign visaPrbsFrom_fxp_cxp_cse_osm[ 85: 85]                                           = new_pll_entry.grfne                    ;
(* inserted_by="VISA IT" *) assign visaPrbsFrom_fxp_cxp_cse_osm[ 89: 86]                                           = new_pll_entry.ptr[3:0]                 ;
(* inserted_by="VISA IT" *) assign visaPrbsFrom_fxp_cxp_cse_osm[ 93: 90]                                           = new_pll_entry.ptr[7:4]                 ;
(* inserted_by="VISA IT" *) assign visaPrbsFrom_fxp_cxp_cse_osm[ 97: 94]                                           = new_pll_entry_for_visa_saved_tag[3:0]  ;
(* inserted_by="VISA IT" *) assign visaPrbsFrom_fxp_cxp_cse_osm[101: 98]                                           = new_pll_entry_for_visa_saved_tag[7:4]  ;
(* inserted_by="VISA IT" *) assign visaPrbsFrom_fxp_cxp_cse_osm[105:102]                                           = new_pll_entry_for_visa_saved_tag[11:8] ;
(* inserted_by="VISA IT" *) assign visaPrbsFrom_fxp_cxp_cse_osm[109:106]                                           = new_pll_entry_for_visa_saved_tag[15:12];
(* inserted_by="VISA IT" *) assign visaPrbsFrom_fxp_cxp_cse_osm[113:110]                                           = new_pll_entry_for_visa_saved_tag[19:16];
(* inserted_by="VISA IT" *) assign visaPrbsFrom_fxp_cxp_cse_osm[117:114]                                           = new_pll_entry_for_visa_saved_tag[23:20];
(* inserted_by="VISA IT" *) assign visaPrbsFrom_fxp_cxp_cse_osm[121:118]                                           = new_pll_entry_for_visa_saved_tag[27:24];
(* inserted_by="VISA IT" *) assign visaPrbsFrom_fxp_cxp_cse_osm[125:122]                                           = new_pll_entry_for_visa_saved_tag[31:28];
(* inserted_by="VISA IT" *) assign visaPrbsFrom_fxp_cxp_cse_osm[129:126]                                           = new_pll_entry_for_visa_set[3:0]        ;
(* inserted_by="VISA IT" *) assign visaPrbsFrom_fxp_cxp_cse_osm[133:130]                                           = new_pll_entry_for_visa_set[7:4]        ;
(* inserted_by="VISA IT" *) assign visaPrbsFrom_fxp_cxp_cse_osm[137:134]                                           = new_pll_entry_for_visa_set[11:8]       ;
(* inserted_by="VISA IT" *) assign visaPrbsFrom_fxp_cxp_cse_osm[141:138]                                           = new_pll_entry_for_visa_set[15:12]      ;
(* inserted_by="VISA IT" *) assign visaPrbsFrom_fxp_cxp_cse_osm[145:142]                                           = pll_pop_entry.trans_id[3:0]            ;
(* inserted_by="VISA IT" *) assign visaPrbsFrom_fxp_cxp_cse_osm[149:146]                                           = pll_pop_entry.trans_id[7:4]            ;
(* inserted_by="VISA IT" *) assign visaPrbsFrom_fxp_cxp_cse_osm[153:150]                                           = pll_pop_entry.trans_id[11:8]           ;
(* inserted_by="VISA IT" *) assign visaPrbsFrom_fxp_cxp_cse_osm[157:154]                                           = pll_pop_entry.trans_id[15:12]          ;
(* inserted_by="VISA IT" *) assign visaPrbsFrom_fxp_cxp_cse_osm[161:158]                                           = pll_pop_entry.trans_id[19:16]          ;
(* inserted_by="VISA IT" *) assign visaPrbsFrom_fxp_cxp_cse_osm[165:162]                                           = pll_pop_entry.trans_id[23:20]          ;
(* inserted_by="VISA IT" *) assign visaPrbsFrom_fxp_cxp_cse_osm[168:166]                                           = pll_pop_entry.trans_type[2:0]          ;
(* inserted_by="VISA IT" *) assign visaPrbsFrom_fxp_cxp_cse_osm[171:169]                                           = pll_pop_entry.client_id[2:0]           ;
(* inserted_by="VISA IT" *) assign visaPrbsFrom_fxp_cxp_cse_osm[173:172]                                           = pll_pop_entry.obj_size[1:0]            ;
(* inserted_by="VISA IT" *) assign visaPrbsFrom_fxp_cxp_cse_osm[177:174]                                           = pll_pop_entry.banks[3:0]               ;
(* inserted_by="VISA IT" *) assign visaPrbsFrom_fxp_cxp_cse_osm[181:178]                                           = pll_pop_entry.banks[7:4]               ;
(* inserted_by="VISA IT" *) assign visaPrbsFrom_fxp_cxp_cse_osm[185:182]                                           = pll_pop_entry.pkt_label[3:0]           ;
(* inserted_by="VISA IT" *) assign visaPrbsFrom_fxp_cxp_cse_osm[189:186]                                           = pll_pop_entry.pkt_label[7:4]           ;
(* inserted_by="VISA IT" *) assign visaPrbsFrom_fxp_cxp_cse_osm[192:190]                                           = pll_pop_entry.pkt_label[10:8]          ;
(* inserted_by="VISA IT" *) assign visaPrbsFrom_fxp_cxp_cse_osm[198:193]                                           = pll_pop_entry.pf[5:0]                  ;
(* inserted_by="VISA IT" *) assign visaPrbsFrom_fxp_cxp_cse_osm[199:199]                                           = pll_pop_entry.last                     ;
(* inserted_by="VISA IT" *) assign visaPrbsFrom_fxp_cxp_cse_osm[200:200]                                           = pll_pop_entry.grfne                    ;
(* inserted_by="VISA IT" *) assign visaPrbsFrom_fxp_cxp_cse_osm[204:201]                                           = pll_pop_entry.ptr[3:0]                 ;
(* inserted_by="VISA IT" *) assign visaPrbsFrom_fxp_cxp_cse_osm[208:205]                                           = pll_pop_entry.ptr[7:4]                 ;
(* inserted_by="VISA IT" *) assign visaPrbsFrom_fxp_cxp_cse_osm[212:209]                                           = pll_pop_entry_for_visa_saved_tag[3:0]  ;
(* inserted_by="VISA IT" *) assign visaPrbsFrom_fxp_cxp_cse_osm[216:213]                                           = pll_pop_entry_for_visa_saved_tag[7:4]  ;
(* inserted_by="VISA IT" *) assign visaPrbsFrom_fxp_cxp_cse_osm[220:217]                                           = pll_pop_entry_for_visa_saved_tag[11:8] ;
(* inserted_by="VISA IT" *) assign visaPrbsFrom_fxp_cxp_cse_osm[224:221]                                           = pll_pop_entry_for_visa_saved_tag[15:12];
(* inserted_by="VISA IT" *) assign visaPrbsFrom_fxp_cxp_cse_osm[228:225]                                           = pll_pop_entry_for_visa_saved_tag[19:16];
(* inserted_by="VISA IT" *) assign visaPrbsFrom_fxp_cxp_cse_osm[232:229]                                           = pll_pop_entry_for_visa_saved_tag[23:20];
(* inserted_by="VISA IT" *) assign visaPrbsFrom_fxp_cxp_cse_osm[236:233]                                           = pll_pop_entry_for_visa_saved_tag[27:24];
(* inserted_by="VISA IT" *) assign visaPrbsFrom_fxp_cxp_cse_osm[240:237]                                           = pll_pop_entry_for_visa_saved_tag[31:28];
(* inserted_by="VISA IT" *) assign visaPrbsFrom_fxp_cxp_cse_osm[244:241]                                           = pll_pop_entry_for_visa_set[3:0]        ;
(* inserted_by="VISA IT" *) assign visaPrbsFrom_fxp_cxp_cse_osm[248:245]                                           = pll_pop_entry_for_visa_set[7:4]        ;
(* inserted_by="VISA IT" *) assign visaPrbsFrom_fxp_cxp_cse_osm[252:249]                                           = pll_pop_entry_for_visa_set[11:8]       ;
(* inserted_by="VISA IT" *) assign visaPrbsFrom_fxp_cxp_cse_osm[256:253]                                           = pll_pop_entry_for_visa_set[15:12]      ;
(* inserted_by="VISA IT" *) assign visaRt_probe_from_cxp_cse_fxp_cxp_cse_lem_fxp_cse_top_fxp_cse_cache_fxp_cse_osm = visaPrbsFrom_fxp_cxp_cse_osm           ;



`endif // INTEL_GLOBAL_VISA_DISABLE
`endif // __VISA_IT__
