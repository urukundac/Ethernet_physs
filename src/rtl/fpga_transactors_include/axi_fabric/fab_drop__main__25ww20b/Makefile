
#-- Common Options --
FABRIC_TYPE                   ?= axim
FABRIC_NUM_PRODUCERS          ?= 2
FABRIC_NUM_CONSUMERS          ?= 3
TOPLEVEL_MODULE               ?= fpga_fabric_tb_top
BUILD_ROOT                    ?= ${FPGA_FABRIC_ROOT}/target
LOGS_ROOT                      = ${BUILD_ROOT}/logs
DEFACTO_BUILD_ROOT             = ${BUILD_ROOT}/defacto
GEN_ROOT                       = ${BUILD_ROOT}/gen
SIM_ROOT                      ?= ${BUILD_ROOT}/sim
GCC_LIB_PATH                   = /usr/intel/pkgs/gcc/9.2.0/lib64
SIM_TESTCASE                  ?= run_fab_test
SIM_MODULE                    ?= FabTestRoot
PYUVM_TESTCASE                ?= FabBaseTest
SIMV_OPTS                      = +define+COCOTB_SIM=1 -full64 -l ${SIM_TESTCASE}.simv.log
SYN_ROOT                      ?= ${BUILD_ROOT}/syn

ifdef SIM_GUI
	SIMV_OPTS += -gui=${SIM_GUI}
endif

ifdef SIM_SEED
	COCOTB_SEED := RANDOM_SEED=${SIM_SEED}
endif

#RUN_LOCAL := 1

ifdef RUN_LOCAL
	NB_LOCAL := -no_parallel
endif

ifdef SHARED_FIFOS
	GEN_TB_SHARED_FIFOS := --shared_fifos
endif

ifeq (${SIM_MODULE}, FabTestRoot)
	COCOTB_TESTCASE := TESTCASE=${SIM_TESTCASE}
else
	COCOTB_TESTCASE :=
endif


#-- Source Common Makefile flow --
-include ${FPGA_FABRIC_ROOT}/make/common.mak

clean-venv:
	@rm -rf ${VENV_PATH}

clean:
	@rm -rf ${BUILD_ROOT}


prep-target:
	@mkdir -p ${BUILD_ROOT}


gen-tb-top:
	@mkdir -p ${DEFACTO_BUILD_ROOT}
	@mkdir -p ${GEN_ROOT}
	@cd ${DEFACTO_BUILD_ROOT} && $(call run_python_script, ${FPGA_FABRIC_ROOT}/scripts/gen_tb_top.py, \
		--fabric_type         ${FABRIC_TYPE} \
		--top_module          ${TOPLEVEL_MODULE} \
		--num_producers       ${FABRIC_NUM_PRODUCERS} \
		--num_consumers       ${FABRIC_NUM_CONSUMERS} \
		--result_dir          ${GEN_ROOT} \
		--log_dir             ${LOGS_ROOT} \
		${GEN_TB_SHARED_FIFOS} \
	)


gen-verdi-signals:
	@mkdir -p ${GEN_ROOT}
	@$(call run_python_script, ${FPGA_FABRIC_ROOT}/scripts/gen_verdi_signals_rc.py, \
		--fabric_type         ${FABRIC_TYPE} \
		--top_module          ${TOPLEVEL_MODULE} \
		--num_producers       ${FABRIC_NUM_PRODUCERS} \
		--num_consumers       ${FABRIC_NUM_CONSUMERS} \
		--result_dir          ${GEN_ROOT} \
		--log_dir             ${LOGS_ROOT} \
	)


compile-sim:
	@mkdir -p ${SIM_ROOT}
	@FPGA_CHS_RESULTS=${RESULTS_ROOT} ${EMUBUILD} \
		-m . \
		-use_emubuild_tooldata \
		-cfg COCOTB_$(call TOUPPER, $(FABRIC_TYPE)) -cfg- \
		-override_hdk_env \
		-yml ${FPGA_FABRIC_ROOT}/yml/fpga_fabric_sa.yml \
		-target ${SIM_ROOT} \
		-clean_target ${NB_LOCAL}

run-sim:
	@cd ${SIM_ROOT}/vcs && \
		source build_settings.bash && \
		env LD_LIBRARY_PATH=${GCC_LIB_PATH}:${LD_LIBRARY_PATH} LD_PRELOAD="${GCC_LIB_PATH}/libstdc++.so.6" MODULE=${SIM_MODULE} ${COCOTB_TESTCASE} TOPLEVEL=${TOPLEVEL_MODULE} ${COCOTB_SEED} TOPLEVEL_LANG=verilog ./simv ${SIMV_OPTS}


clean-compile: clean prep-target gen-tb-top gen-verdi-signals compile-sim

export
