module IW_cms_add_drop_data_add #(

    parameter BL_DATA_BE_SIZE = 4,
    parameter BL_DATA_SIZE = 256,
    parameter BL_DATA_ECC_SIZE = 1,
    parameter BL_DATA_PAR_SIZE = 4,
    parameter NUM_DEMUX_SIGNALS = (BL_DATA_BE_SIZE + BL_DATA_SIZE + BL_DATA_ECC_SIZE + BL_DATA_PAR_SIZE + 4)

) (
    // Ports for Interface agt0_cms_data_add
    output                            data_add_bl_data_beparity,
    output   [BL_DATA_BE_SIZE-1:0]    data_add_bl_data_byte_en,
    output   [BL_DATA_SIZE-1:0]       data_add_bl_data_data,
    output   [BL_DATA_ECC_SIZE-1:0]   data_add_bl_data_ecc,
    output                            data_add_bl_data_ecc_valid,
    output   [BL_DATA_PAR_SIZE-1:0]   data_add_bl_data_parity,
    output                            data_add_bl_data_poison,
    output                            data_add_bl_data_valid,

    input  [NUM_DEMUX_SIGNALS-1:0]    demux_data

);

assign {
          data_add_bl_data_beparity,
          data_add_bl_data_byte_en,
          data_add_bl_data_data,
          data_add_bl_data_ecc,
          data_add_bl_data_ecc_valid,
          data_add_bl_data_parity,
          data_add_bl_data_poison,
          data_add_bl_data_valid
       } = demux_data;

endmodule
