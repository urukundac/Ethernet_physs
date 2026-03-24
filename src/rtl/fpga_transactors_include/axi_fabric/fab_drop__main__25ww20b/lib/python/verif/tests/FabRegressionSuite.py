import sys 
import os
import importlib

import cocotb
from cocotb.triggers import Timer, First
from pyuvm import *

#Import the required tests to be run in this regression suite
sys.path.append(os.environ.get('FPGA_FABRIC_ROOT')+'/lib/python')
from verif.tests.FabSlaveCollisionTest  import *
from verif.tests.FabAllRandomTest       import *

