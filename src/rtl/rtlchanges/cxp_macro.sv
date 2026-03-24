`ifndef CXP_RTL_GLOBAL_MACROS_SV_INCLUDED
 `define CXP_RTL_GLOBAL_MACROS_SV_INCLUDED

 `ifdef BEHAVE_MEM
  `define FXP_BEHAVE_MEMS 
  `define CXP_BEHAVE_MEMS 
  `define FXP_FXP_CXP_PMC_BEHAVE_MEMS 
  `define FXP_FXP_CXP_CSE_LEM_BEHAVE_MEMS 
  `define FXP_FXP_CXP_PAR_NON_ANA_BEHAVE_MEMS 
  `define FXP_FXP_CXP_LEM_BEHAVE_MEMS 
  `define CXP_MTX_BEHAVE_MEMS 
  `define CXP_CPS_BEHAVE_MEMS 
  `define CXP_WCM_BEHAVE_MEMS
  `define CXP_TRC_BEHAVE_MEMS
 `endif  

 `ifdef FAST_FUNC_MEM
  `define CXP_FAST_FUNC_MEM
 `endif

 `ifdef ASIC_MEM
 `endif

`ifndef FXP_CXP_CSE_OR_NEGEDGE_RST_N
    //`define FXP_CXP_CSE_USE_ASYNC_RESET
    `ifdef FXP_CXP_CSE_USE_ASYNC_RESET
      `define FXP_CXP_CSE_OR_NEGEDGE_RST_N or negedge rst_n
      `define FXP_CXP_CSE_NRSTN        !rst_n
    `else
      `define FXP_CXP_CSE_OR_NEGEDGE_RST_N
      `define FXP_CXP_CSE_NRSTN        1'b0
    `endif
  `endif

 `ifdef EPG_EMULATION
  `define INTEL_VELOCE 
 `endif

 `ifdef EPG_FPGA
//  `define CXP_FPGA_MEMS
 `endif
 
 `ifdef VCSSIM_ONLY
  `define CXP_RTL
  `define CXP_ACTIVE
  `define ITPP_STF_BFM_NO_SPOFI
  `define UVM
  `define COVAXI_INTEG_ENABLE_IP_CXP
  `define UVM_OBJECT_DO_NOT_NEED_CONSTRUCTOR
  `define MROOT_SPACE_SIGNAL_NAME=mrs
  `define IOSFTRKCHK_NO_DEPENDENCIES
  `define INSTANTIATE_NOVAS
  `define UVM_PACKER_MAX_BYTES=1500000
  `define SVT_AMBA_OPTIMIZED_COMPILE
  `define DO_NOT_USE_RAL
  `define DO_NOT_USE_RM
  `define DO_NOT_USE_FUSE
  `define SSE_VALID_DATA_WIDTH=6250
  `define NO_PROCESS_AE
  `define JTAG_BFM_TAPLINK_MODE
  `define CHASSIS_JTAGBFM_USE_PARAMETERIZED_CLASS
//define w/o explicit path in Makefile cth_query
  `define ITPP_CUSTOM_INCLUDE=$DFXVCLHOME_DFT_COMMON_VAL_ENV/src/itpp_reader_tlm_pipe_overrides.sv
 `endif //  `ifdef VCSSIM_ONLY

`endif //  `ifndef CXP_RTL_GLOBAL_MACROS_SV_INCLUDED

