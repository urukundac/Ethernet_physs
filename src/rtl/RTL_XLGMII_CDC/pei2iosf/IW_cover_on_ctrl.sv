// The IW_COVER_ON_CTRL macro is used to control the compilation of functional coverage code
// It takes a MODULE name and based on whether COVER_ON, COVER_ON_MODULE, and COVER_OFF_MODULE
// it will define or undefine COVER_ON_MODULE. Each module then uses COVER_ON_MODULE to control
// the compilation of coverage code

// spyglass disable_block WRN_54 -- Not worried about macros w/ argument warnings

`ifndef IW_COVER_ON_CTRL

  `define IW_COVER_ON_CTRL(MODULE) \
    `ifdef COVER_ON \
      `ifndef COVER_ON_``MODULE`` \
        `define COVER_ON_``MODULE`` \
      `endif \
    `endif \
  \
    `ifdef COVER_OFF_``MODULE`` \
      `ifdef COVER_ON_``MODULE`` \
        `undef COVER_ON_``MODULE`` \
      `endif \
    `endif

`endif
