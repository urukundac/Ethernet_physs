import sys
import os
import pprint
import random

from pyuvm import *
import cocotb
from cocotb.clock import Clock
from cocotb.triggers import ClockCycles
from cocotb.triggers import Join, Combine
from cocotb.triggers import RisingEdge, FallingEdge, Timer
from cocotb.queue import Queue as CocotbQueue


sys.path.append(os.environ.get('FPGA_FABRIC_ROOT')+'/lib/python')
from verif.tb.FabTbBase                     import FabTbBase
from verif.tb.seq_items.FabTbAximSeqItem    import FabTbAximType, FabTbAximReqSeqItem, FabTbAximRspSeqItem

class FabTbAximScoreboard(uvm_component, FabTbBase):
    def __init__(self, **kwargs):
        """ Initialize each parent class constructor seperately """
        uvm_component.__init__(self, kwargs['name'], kwargs['parent'])
        FabTbBase.__init__(self)

        self.logger         = self.create_logger(name=f"{kwargs['parent']}.{kwargs['name']}")
        self.num_producers  = kwargs['num_producers']
        self.num_consumers  = kwargs['num_consumers']
        self.addr_map       = kwargs['addr_map']

        self.p_fifo     = {}
        self.c_fifo     = {}

        self.p_exp_q    = {}
        self.c_exp_q    = {}

        self.errors     = False
 

    def build_phase(self):
        super().build_phase()

        self.logger.info('Start of Build')

        for i in range(self.num_producers):
            self.p_fifo[i]  = uvm_tlm_analysis_fifo(f"p{i}_fifo", self)
            self.p_exp_q[i] = CocotbQueue()

        for i in range(self.num_consumers):
            self.c_fifo[i] = uvm_tlm_analysis_fifo(f"c{i}_fifo", self)
            self.c_exp_q[i] = CocotbQueue()

        self.logger.info('End of Build')



    async def monitor_p_fifo(self, id):
        logger = self.create_logger(name=f"{self.get_parent()}.{self.get_name()}.p{id}")
        logger.info('Starting monitor')

        while True:
            xtn = await self.p_fifo[id].get()
            logger.info(f'Got xtn ->\n{xtn}')

            if isinstance(xtn, FabTbAximReqSeqItem):
                #Send to slave
                logger.info(f'Routing to slave : {xtn.dst_node_id}')
                await self.c_exp_q[xtn.dst_node_id].put(xtn)

            elif isinstance(xtn, FabTbAximRspSeqItem):
                if self.p_exp_q[id].empty():
                    logger.error(f'Unexpected transaction!')
                    self.errors = True
                    continue

                exp_xtn = await self.p_exp_q[id].get()

                if exp_xtn == xtn:
                    logger.info('xtn is correct')
                else:
                    diff = FabTbAximRspSeqItem.diff(this=xtn, other=exp_xtn)
                    logger.error(f'Mismatch with exp_xtn ->{diff}')
                    self.errors = True



    async def monitor_c_fifo(self, id):
        logger = self.create_logger(name=f"{self.get_parent()}.{self.get_name()}.c{id}")
        logger.info('Starting monitor')

        while True:
            xtn = await self.c_fifo[id].get()
            logger.info(f'Got xtn ->\n{xtn}')

            if isinstance(xtn, FabTbAximReqSeqItem):
                exp_xtn     = None
                tmp_xtns    = []

                while not self.c_exp_q[id].empty():
                    exp_xtn = await self.c_exp_q[id].get()

                    if exp_xtn.id == xtn.id:
                        break
                    else:
                        tmp_xtns.append(exp_xtn)

                for item in tmp_xtns:
                    await self.c_exp_q[id].put(item)

                if exp_xtn is None:
                    logger.error(f'Unexpected transaction!')
                    self.errors = True
                    continue

                if exp_xtn == xtn:
                    logger.info('xtn is correct')
                else:
                    diff = FabTbAximReqSeqItem.diff(this=xtn, other=exp_xtn)
                    logger.error(f'Mismatch with exp_xtn ->{diff}')
                    self.errors = True

            elif isinstance(xtn, FabTbAximRspSeqItem):
                #Send to master
                logger.info(f'Routing to master : {xtn.dst_node_id}')
                await self.p_exp_q[xtn.dst_node_id].put(xtn)



    async def run_phase(self):
        self.logger.info('Start of run_phase')

        threads = []

        for i in range(self.num_producers):
            threads.append(cocotb.start_soon(self.monitor_p_fifo(id=i)))

        for i in range(self.num_consumers):
            threads.append(cocotb.start_soon(self.monitor_c_fifo(id=i)))

        for task in threads:
            await task


        self.logger.info('End of run_phase')


    def check_phase(self):
        super().check_phase()

        for i in range(self.num_producers):
            if not self.p_exp_q[i].empty():
                self.logger.error(f'There are still pending xtns in p_exp_q[{i}]')
                self.errors = True

            if self.p_fifo[i].size() > 0:
                self.logger.error(f'There are {self.p_fifo[i].size()} pending xtns in p_fifo[{i}]')
                self.errors = True

        for i in range(self.num_consumers):
            if not self.c_exp_q[i].empty():
                self.logger.error(f'There are still pending xtns in c_exp_q[{i}]')
                self.errors = True

            if self.c_fifo[i].size() > 0:
                self.logger.error(f'There are {self.c_fifo[i].size()} pending xtns in c_fifo[{i}]')
                self.errors = True


    def report_phase(self):
        super().report_phase()

        if self.errors:
            self.logger.error('Errors Detected!')


    def final_phase(self):
        super().final_phase()

        if self.errors:
            assert False

