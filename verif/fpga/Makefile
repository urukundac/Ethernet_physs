#!make

# Current makefile
MAKEFILE    := $(abspath $(lastword $(MAKEFILE_LIST)))

# Name of IP, which is pointed by WORKAREA.
### Please keep it common across RTL & DV inputs.
TOP_IP_NAME :=physs_eth

# Use DUT specific files, if present, in build.
DUT   ?= $(TOP_IP_NAME)

# Read DUT specific model.cfg file, to load MODEL data, present
# in models section of <DUT.>model.cfg file
MODEL ?= <>

# To read/keep flow specific collateral.
### One such BUILD_DIRNAME is "vps_dvb".
BUILD_DIRNAME ?= vps
ifeq ($(strip $(BUILD_DIRNAME)),)
$(error Please set "BUILD_DIRNAME" in $(MAKEFILE) or command-line make <target> BUILD_DIRNAME=<>)
endif

BUILD_DIR     := $(abspath $(dir $(MAKEFILE))/$(BUILD_DIRNAME))

export

# To read flow specific build Makefile
include $(BUILD_DIR)/Makefile
