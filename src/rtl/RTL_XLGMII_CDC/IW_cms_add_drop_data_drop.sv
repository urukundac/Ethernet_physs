module IW_cms_add_drop_data_drop #(

    parameter BL_DATA_BE_SIZE = 32,
    parameter BL_DATA_SIZE = 256,
    parameter BL_DATA_ECC_SIZE = 10,
    parameter BL_DATA_PAR_SIZE = 4,
    parameter NUM_MUX_SIGNALS = (BL_DATA_BE_SIZE + BL_DATA_SIZE + BL_DATA_ECC_SIZE + BL_DATA_PAR_SIZE + 3)

) (
    // Ports for Interface agt0_cms_data_drop
    input                            data_drop_bl_drop_data_beparity,
    input   [BL_DATA_BE_SIZE-1:0]    data_drop_bl_drop_data_byte_en,
    input   [BL_DATA_SIZE-1:0]       data_drop_bl_drop_data_data,
    input   [BL_DATA_ECC_SIZE-1:0]   data_drop_bl_drop_data_ecc,
    input                            data_drop_bl_drop_data_ecc_valid,
    input   [BL_DATA_PAR_SIZE-1:0]   data_drop_bl_drop_data_parity,
    input                            data_drop_bl_drop_data_poison,

    output   [NUM_MUX_SIGNALS-1:0]    mux_data

);

assign mux_data = {
                    data_drop_bl_drop_data_beparity,
                    data_drop_bl_drop_data_byte_en,
                    data_drop_bl_drop_data_data,
                    data_drop_bl_drop_data_ecc,
                    data_drop_bl_drop_data_ecc_valid,
                    data_drop_bl_drop_data_parity,
                    data_drop_bl_drop_data_poison
                 };

endmodule
