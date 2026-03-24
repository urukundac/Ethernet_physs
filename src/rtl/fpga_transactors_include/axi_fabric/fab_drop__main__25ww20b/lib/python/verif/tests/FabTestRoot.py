import sys 
import os
import importlib

import cocotb
from cocotb.triggers import Timer, First
from pyuvm import *

async def wait_timeout(dut):
    logger = dut._log
    await Timer(1000, units='ms')

    logger.error('TIMEOUT!')
    assert False

async def run_pyuvm_test(dut, pyuvm_testcase=None):
    logger = dut._log

    if pyuvm_testcase is None:
        pyuvm_testcase = os.environ.get('PYUVM_TESTCASE')

    logger.info(f"PYUVM_TESTCASE : {pyuvm_testcase}")

    pyuvm_test_module = importlib.import_module(pyuvm_testcase)

    try:
        await uvm_root().run_test(pyuvm_testcase)
    except Exception as e:
        logger.error(f'PYUVM_TESTCASE {pyuvm_testcase} FAILED')
        assert False

    logger.info(f'PYUVM_TESTCASE {pyuvm_testcase} completed')

@cocotb.test()
async def run_fab_test(dut):
    logger = dut._log

    """
        This is the main python entry point via cocotb
    """
    try:
        test_task       = cocotb.start_soon(run_pyuvm_test(dut=dut))
        timeout_task    = cocotb.start_soon(wait_timeout(dut=dut))

        await First(test_task, timeout_task)

    except Exception as e:
        logger.error(f'FAILED  ->\n{e}')
        assert False


