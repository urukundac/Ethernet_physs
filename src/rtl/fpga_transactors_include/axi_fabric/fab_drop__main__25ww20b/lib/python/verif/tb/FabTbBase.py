import sys
import os
import logging
import random

import cocotb
from cocotb.utils import get_sim_time, get_time_from_sim_steps
from cocotb.clock import Clock
from cocotb.triggers import ClockCycles
from cocotb.triggers import Join, Combine
from cocotb.triggers import RisingEdge, FallingEdge, Timer


class CustomFormatter(logging.Formatter):
    def format(self, record):
        # Use the formatTime method to get the formatted time string
        time_ns     = get_time_from_sim_steps(get_sim_time(), "ns")
        timestamp   = f"{time_ns:6.2f} ns"
        timestamp   = f"{timestamp:<20}"

        name = f"{record.name:<50}"
        funcName = f"{record.funcName:<30}"
        levelname = f"{record.levelname:<8}"
        message = record.getMessage()

        return f"{timestamp} {levelname} {name} {funcName} {message}"



class FabTbBase():
    """
        Base class that should be inherited (in parallel to PYUVM classes) by every TB class for simulation
        Performs common functions & initializations
    """

    """
        Static variables that have the same copy on all children inherited from this class
    """


    def __init__(self, **kwargs):
        """ Logger Items """
        #self._formatter     =   logging.Formatter('%(asctime)s|%(name)s|%(funcName)s|%(levelname)s| %(message)s')
        self._formatter     =   CustomFormatter('%(asctime)s|%(name)s|%(funcName)s|%(levelname)s| %(message)s')
        self._root_logger   =   None

        if 'init_logger' in kwargs.keys():
            if kwargs['init_logger'] is True:
                self.init_logger(log_file='./fpga_fabric_test.log')

        self.tb_top     = cocotb.top
        self.dut_top    = cocotb.top.dut


    def init_logger(self, log_file):
        self._root_logger   =   logging.getLogger()
        self._root_logger.setLevel(logging.DEBUG)

        # Remove existing handlers
        if self._root_logger.hasHandlers():
            self._root_logger.handlers.clear()

        console_handler = logging.StreamHandler()
        console_handler.setLevel(logging.DEBUG)
        console_handler.setFormatter(self._formatter)
        self._root_logger.addHandler(console_handler)

        fh = logging.FileHandler(log_file, mode='w')
        fh.setLevel(logging.DEBUG)
        fh.setFormatter(self._formatter)
        self._root_logger.addHandler(fh)


    def create_logger(self, name=None, log_file=None):
        if name is None:
            module_name = self.__class__.__name__
        else:
            module_name = name

        mlogger = logging.getLogger(module_name)
        mlogger.setLevel(logging.DEBUG)

        if log_file is not None:
            fh = logging.FileHandler(log_file, mode='w')

            fh.setLevel(logging.DEBUG)
            fh.setFormatter(self._formatter)
            mlogger.addHandler(fh)

        return mlogger


    async def generate_sync_reset(self, **kwargs):    
        """
            This function toggles a single reset signal based on its sync-clock & polarity
        """
        reset_name      = kwargs['reset_name']
        reset_signal    = kwargs['reset_signal']
        reset_clk       = kwargs['reset_clk']
        reset_active    = kwargs['reset_active']

        try:
            self.logger.info(f"Asserted active {reset_active} reset : {reset_name}")

            if reset_active == "high":
                reset_signal.value = 1
            else:
                reset_signal.value = 0

            for _ in range(random.randint(5, 10)):
                await RisingEdge(reset_clk)

            if reset_active == "high":
                reset_signal.value = 0
            else:
                reset_signal.value = 1

            self.logger.info(f"Lifted Reset : {reset_name}")
        except Exception as e:
            self.logger.error(f'generate_sync_reset FAILED for {reset_name} ->\n{e}')
            assert False


    def decode_slave_id_from_addr(self, addr, addr_map):
        slave_id = None

        for key,val in addr_map.items():
            if (addr >= val['start']) and (addr <= val['end']):
                slave_id = int(key.replace('slave_', ''))
                break

        if slave_id is None:
            logger.critical(f'Could not decode slave_id from addr : {addr}')
            assert False

        return slave_id


    def decode_master_id_from_id(self, id, id_map):
        master_id = None

        for key,val in id_map.items():
            if (id >= val['start']) and (id <= val['end']):
                master_id = int(key.replace('master_', ''))
                break

        if master_id is None:
            logger.critical(f'Could not decode master_id from id : {id}')
            assert False

        return master_id


