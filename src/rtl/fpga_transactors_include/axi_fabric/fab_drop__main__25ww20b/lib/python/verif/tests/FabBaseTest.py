import sys
import os
import logging
import random
import pprint

import xml.etree.ElementTree as ET
import xml.dom.minidom as xmlMinidom

import pyuvm
from pyuvm import *
import cocotb
from cocotb.triggers import RisingEdge, Timer

sys.path.append(os.environ.get('FPGA_FABRIC_ROOT')+'/lib/python')
from verif.tb.FabTbBase                     import FabTbBase
from verif.tb.FabTbEnv                      import FabTbEnv
from verif.tb.seq_items.FabTbAximSeqItem    import FabTbAximType, FabTbAximReqSeqItem, FabTbAximRspSeqItem
from verif.tests.FabTestRoot                import wait_timeout, run_pyuvm_test

@pyuvm.test()
class FabBaseTest(uvm_test, FabTbBase):
    """
        Base Test class that needs to be inherited by every FPGA Fabric testcase
    """
    def __init__(self, name, parent):
        """ Initialize each parent class constructor seperately """
        uvm_test.__init__(self, name, parent)
        FabTbBase.__init__(self)

        #Configure logger
        self.init_logger(log_file=f'./{name}.log')
        self.logger = self.create_logger(name=name)
        #self.logger.setLevel(logging.DEBUG)


        self.test_passed    = True  #Innocent until proven guilty
        self.env            = FabTbEnv(name='env', parent=self)


    def build_phase(self):
        super().build_phase()

        #random_seed = os.environ.get('RAND_SEED')

        #if random_seed is None:
        #    random_seed = random.randint(0, 2**32 - 1)

        #self.logger.debug(f"Using random_seed = {random_seed}")

        #random.seed(random_seed)

        self.logger.info(f"COCOTB Seed = {cocotb.RANDOM_SEED}")



    def connect_phase(self):
        super().connect_phase()

        self.logger.info('Start of Connect')


        self.logger.info('End of Connect')



    def end_of_elaboration_phase(self):
        super().end_of_elaboration_phase()


    async def reset_phase(self):
        """
            All tests should call & wait for reset_phase to complete before proceeding with regular run steps
            Refer the run_phase implementation below as an example
        """
        self.logger.info('Start of reset_phase')

        await self.env.reset_phase()

        self.logger.info('End of reset_phase')


    async def send_p_xtns(self, id, num_xtns=1, slave_id=0):
        try:
            for _ in range(num_xtns):
                req = FabTbAximReqSeqItem(name=f'p{id}_req')
                req.randomize(
                    type=FabTbAximType.WRITE,
                    addr_start=self.env.addr_map[f'slave_{slave_id}']['start'],
                    addr_end=self.env.addr_map[f'slave_{slave_id}']['end'],
                    #burst_len=random.randint(1,64)
                )

                self.logger.info(f'Sending req ->\n{req}')
                rsp = await self.env.agents[f'm_{id}_agent'].driver.drive_xtn(req=req)
                self.logger.info(f'Got rsp ->\n{rsp}')

                req.randomize(
                    type=FabTbAximType.READ,
                    addr_start=self.env.addr_map[f'slave_{slave_id}']['start'],
                    addr_end=self.env.addr_map[f'slave_{slave_id}']['end'],
                    #burst_len=random.randint(1,64)
                )

                self.logger.info(f'Sending req ->\n{req}')
                rsp = await self.env.agents[f'm_{id}_agent'].driver.drive_xtn(req=req)
                self.logger.info(f'Got rsp ->\n{rsp}')
 
        except Exception as e:
            self.logger.critical(e)
            assert False


    async def send_random_p_xtns(self, id, num_xtns=1):
        try:
            for _ in range(num_xtns):
                slave_id = random.randint(0, self.env.num_consumers - 1)
                xtn_type = random.choice([FabTbAximType.WRITE,  FabTbAximType.READ])

                req = FabTbAximReqSeqItem(name=f'p{id}_req')
                req.randomize(
                    type=xtn_type,
                    addr_start=self.env.addr_map[f'slave_{slave_id}']['start'],
                    addr_end=self.env.addr_map[f'slave_{slave_id}']['end'],
                    #burst_len=random.randint(1,64)
                )

                self.logger.info(f'Sending req ->\n{req}')
                rsp = await self.env.agents[f'm_{id}_agent'].driver.drive_xtn(req=req)
                self.logger.info(f'Got rsp ->\n{rsp}')

        except Exception as e:
            self.logger.critical(e)
            assert False


    async def run_phase(self):
        self.raise_objection()

        await self.reset_phase()

        self.logger.info('Start of run_phase')

        threads = []

        for i in range(self.env.num_producers):
            threads.append(cocotb.start_soon(self.send_p_xtns(id=i, num_xtns=10)))

        # Wait for all tasks to complete
        for task in threads:
            await task

        await Timer(1, 'us')

        self.logger.info('End of run_phase')

        self.drop_objection()


    def check_phase(self):
        super().check_phase()

        self.logger.info('Start of check_phase')

        if self.test_passed:
            self.logger.info('UTB Test has PASSED')
        else:
            self.logger.error('UTB Test has FAILED')

        self.logger.info('End of check_phase')


    def report_phase(self):
        super().report_phase()

        self.logger.info('Start of report_phase')
        self.logger.info('End of report_phase')


    def final_phase(self):
        super().final_phase()

        self.logger.info('Start of final_phase')

        if self.test_passed:
            self.logger.info('Testcase PASSED!!!')
        else:
            self.logger.error('Testcase FAILED!!!')

        self.logger.info('End of final_phase')

        if not self.test_passed:
            assert False



