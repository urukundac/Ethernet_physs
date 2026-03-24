export MAKEFLAGS=--no-print-directory


#------------------------------------------------------------------------------------
# Get Current Timestamp
#------------------------------------------------------------------------------------
TIMESTAMP = $(shell date "+%Y%m%d-%H%M%S")

#------------------------------------------------------------------------------------
# Variables
#------------------------------------------------------------------------------------


#------------------------------------------------------------------------------------
# Net-Batch Options
#------------------------------------------------------------------------------------

#------------------------------------------------------------------------------------
# Functions
#------------------------------------------------------------------------------------
print_hdr_emb =  if [ "$(5)" == 1 ]; then \
						     echo "+------------------------------------------------------------------------------"; \
						     fi; \
						     echo "|make|$(1)|$(2)| $(3)"; \
						     if [ "$(6)" == 1 ]; then \
                   echo "+------------------------------------------------------------------------------"; \
						     fi; \
						     if [ "$(4)" == 1 ]; then echo ""; fi; \

print_hdr     = @if [ "$(5)" == 1 ]; then \
						     echo "+------------------------------------------------------------------------------"; \
						     fi; \
						     echo "|make|$(1)|$(2)| $(3)"; \
						     if [ "$(6)" == 1 ]; then \
                   echo "+------------------------------------------------------------------------------"; \
						     fi; \
						     if [ "$(4)" == 1 ]; then echo ""; fi; \


TOLOWER = $(shell echo ${1} | tr "[:upper:]" "[:lower:]")
TOUPPER = $(shell echo ${1} | tr "[:lower:]" "[:upper:]")

#-- Description: 	chk-vars-common: Checks if common env variables are defined
chk-vars-common:
	$(call print_hdr,chk-vars-common,INFO,Checking common variables,0,1,0)
ifndef FPGA_FABRIC_ROOT
	$(error Environment variable ROOT not defined!)
endif
	$(call print_hdr,chk-vars-common,INFO,All common variables are good,1,0,1)


# Define a function to run a Python script with arguments
define run_python_script
	if [ -z "$(VENV_PATH)" ]; then \
		echo "Error: VENV_PATH is not set."; \
		exit 1; \
	fi; \
	PYTHON_EXEC="$(VENV_PATH)/bin/python"; \
	if [ ! -f "$$PYTHON_EXEC" ]; then \
		echo "Error: Python interpreter not found at $$PYTHON_EXEC."; \
		exit 1; \
	fi; \
	"$$PYTHON_EXEC" $(1) $(2)
endef

export
