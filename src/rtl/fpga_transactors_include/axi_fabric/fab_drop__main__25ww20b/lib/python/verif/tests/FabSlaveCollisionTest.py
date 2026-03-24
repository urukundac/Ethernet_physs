import sys
import os
import logging
import random
import pprint

import pyuvm
from pyuvm import *
import cocotb
from cocotb.triggers import RisingEdge, Timer

sys.path.append(os.environ.get('FPGA_FABRIC_ROOT')+'/lib/python')
from verif.tests.FabBaseTest                import FabBaseTest
from verif.tb.seq_items.FabTbAximSeqItem    import FabTbAximType, FabTbAximReqSeqItem, FabTbAximRspSeqItem

@pyuvm.test()
class FabSlaveCollisionTest(FabBaseTest):
    """
        This test is used to check how the fabric handles multiple masters trying to access the same slave at the same time
    """
    def __init__(self, name, parent):
        super().__init__(name, parent)


    def build_phase(self):
        super().build_phase()



    def connect_phase(self):
        super().connect_phase()


    def end_of_elaboration_phase(self):
        super().end_of_elaboration_phase()


    async def reset_phase(self):
        await super().reset_phase()


    async def run_phase(self):
        self.raise_objection()

        await self.reset_phase()

        self.logger.info('Start of run_phase')

        for c in range(self.env.num_consumers):
            self.logger.info(f'Colliding Slave : c{c}')
            threads = []

            for p in range(self.env.num_producers):
                threads.append(cocotb.start_soon(self.send_p_xtns(id=p, num_xtns=1000, slave_id=c)))

            # Wait for all tasks to complete
            for task in threads:
                await task

            await Timer(1, 'us')


        self.logger.info('End of run_phase')

        self.drop_objection()


    def check_phase(self):
        super().check_phase()


    def report_phase(self):
        super().report_phase()


    def final_phase(self):
        super().final_phase()


