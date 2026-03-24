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
from verif.tb.agents.axim.FabTbAximDriver   import FabTbAximDriver

class FabTbAximAgent(uvm_agent, FabTbBase):
    def __init__(self, **kwargs):
        """ Initialize each parent class constructor seperately """
        uvm_agent.__init__(self, kwargs['name'], kwargs['parent'])
        FabTbBase.__init__(self)

        self.logger     = self.create_logger(name=f"{kwargs['parent']}.{kwargs['name']}")
        self.addr_map   = kwargs['addr_map']
        self.id_map     = kwargs['id_map']
        self.is_master  = kwargs['is_master']
        self.node_id    = kwargs['node_id']
        self.driver     = None
        self.signals    = {}
 


    def build_phase(self):
        super().build_phase()

        self.logger.info('Start of Build')

        if self.is_master:
            signal_prefix = 'm_'

            if self.id_map is None:
                self.logger.critical(f'ID-MAP is not defined!')
                assert False
        else:
            signal_prefix = 's_'

        for signal in [
            'clk',
            'rst_n',

            'awvalid',
            'awready',
            'awid',
            'awaddr',
            'awlen',
            'awsize',
            'awburst',
            'awlock',
            'awcache',
            'awprot',
            'awqos',
            'awregion',
            'awuser',

            'wvalid',
            'wready',
            'wid',
            'wdata',
            'wstrb',
            'wlast',
            'wuser',

            'arvalid',
            'arready',
            'arid',
            'araddr',
            'arlen',
            'arsize',
            'arburst',
            'arlock',
            'arcache',
            'arprot',
            'arqos',
            'arregion',
            'aruser',

            'bvalid',
            'bready',
            'bid',
            'bresp',
            'buser',

            'rvalid',
            'rready',
            'rid',
            'rdata',
            'rresp',
            'rlast',
            'ruser',
        ]:
            self.signals[signal] = getattr(self.tb_top, f'{signal_prefix}{signal}[{self.node_id}]')


        self.driver = FabTbAximDriver(name='drvr', parent=self, addr_map=self.addr_map, id_map=self.id_map, is_master=self.is_master, signals=self.signals, node_id=self.node_id)

        self.logger.info('End of Build')


    async def gen_all_clocks(self):
        """
            This function generates all the required clock inputs that this agent is associated with
        """
        cocotb.start_soon(Clock(self.signals['clk'], random.randint(5, 10), 'ns').start())


    async def reset_phase(self):
        return await self.driver.reset_phase()

