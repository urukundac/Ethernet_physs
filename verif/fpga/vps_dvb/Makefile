#!make

### Variables from top-level Makefile
# MAKEFILE
# DUT
# MODEL
# BUILD_DIRNAME
# BUILD_DIR

FLOW      := vps

DVB_ROOT  := /p/hdk/cad/dvb/2024.06.fe.DVB.1.3/dvb
FLOW_ROOT := $(DVB_ROOT)/makefiles/$(FLOW)
USECASE   := simics

# Benefit of this ifeq block:
# - It stops recursive inclusion of user defined configuration.
# - Makefile.ENV updates PATH, LD_LIBRARY_PATH etc variable.
#   Recursive inclusion might affect these variables.
ifeq ($(strip $(__MAKE_ENV_INCLUDED)),)

# include user configuration makefile
#================================================
include $(BUILD_DIR)/Makefile.cfg

# include flow env-setup makefile
# - This Makefile.ENV sets __MAKE_ENV_INCLUDED
#================================================
include $(FLOW_ROOT)/Makefile.ENV

# include user defined configuration here, if any
#================================================

endif

# To disable a variable coming from lite-infra, empty it out here
#================================================================
# JEM         :=
# SIMICS_HOME :=

# include flow makefile
#===============================================
include $(FLOW_ROOT)/Makefile.$(FLOW)

export

# Build a complete vps model in TARGET_DIR
#===============================================
.PHONY: all
ifneq ($(strip $(TB_BUILD_ONLY)),1)
all: $(SHADOW_DIR)/prerequisite   $(SHADOW_DIR)/spark_co   $(SHADOW_DIR)/gen_dv_flist  \
	 $(SHADOW_DIR)/gen_analyze_make $(SHADOW_DIR)/analyze        $(SHADOW_DIR)/c_compile     \
	 $(SHADOW_DIR)/fe_be            $(SHADOW_DIR)/vps_tb         $(SHADOW_DIR)/prepare_spark \
	 $(SHADOW_DIR)/spark_tb         $(SHADOW_DIR)/tb             summary
else
all: $(SHADOW_DIR)/prerequisite   $(SHADOW_DIR)/spark_co   $(SHADOW_DIR)/c_compile     \
	 $(SHADOW_DIR)/vps_tb           $(SHADOW_DIR)/prepare_spark  $(SHADOW_DIR)/spark_tb $(SHADOW_DIR)/tb   summary
endif

