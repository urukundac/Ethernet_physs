import sys
import os
import pprint
import random

from prettytable import PrettyTable

from pyuvm import *
import cocotb
from cocotb.clock import Clock
from cocotb.triggers import ClockCycles
from cocotb.triggers import Join, Combine
from cocotb.triggers import RisingEdge, FallingEdge, Timer

sys.path.append(os.environ.get('FPGA_FABRIC_ROOT')+'/lib/python')
from verif.tb.FabTbBase                         import FabTbBase
from verif.tb.agents.axim.FabTbAximAgent        import FabTbAximAgent
from verif.tb.scoreboards.FabTbAximScoreboard   import FabTbAximScoreboard


class FabTbEnv(uvm_env, FabTbBase):
    def __init__(self, **kwargs):
        """ Initialize each parent class constructor seperately """
        uvm_env.__init__(self, kwargs['name'], kwargs['parent'])
        FabTbBase.__init__(self)

        self.logger         = self.create_logger(name=f"{kwargs['parent']}.{kwargs['name']}")
        self.num_producers  = None
        self.num_consumers  = None
        self.addr_bits      = None
        self.addr_map       = {}
        self.id_bits        = None
        self.id_map         = {}
        self.agents         = {}
        self.scoreboard     = None


    def gen_addr_map(self):   #Partition addr-space evenly among slaves
        #self.addr_bits = self.tb_top.AXI4_ADDR_W.value

        total_space = 2 ** self.addr_bits

        base_size = total_space // self.num_consumers
        remainder = total_space %  self.num_consumers

        start_addr = 0

        for i in range(self.num_consumers):
            end_addr = start_addr + base_size + (1 if i < remainder else 0) - 1
            self.addr_map[f'slave_{i}'] = {'start':start_addr, 'end':end_addr}
            start_addr = end_addr + 1


    def get_addr_map_table_str(self):
        table = PrettyTable()

        table.field_names = ["Slave", "Start Address", "End Address"]

        hex_digits = self.addr_bits // 4

        for i in range(self.num_consumers):
            start_hex   = f"0x{self.addr_map[f'slave_{i}']['start']:0{hex_digits}x}"
            end_hex     = f"0x{self.addr_map[f'slave_{i}']['end']:0{hex_digits}x}"
            table.add_row([i, start_hex, end_hex])

        return table.get_string()


    def gen_id_map(self):   #Partition id-space evenly among masters
        #self.id_bits = self.tb_top.AXI4_ID_W.value

        total_space = 2 ** self.id_bits

        base_size = total_space // self.num_producers
        remainder = total_space %  self.num_producers

        start_id = 0

        for i in range(self.num_producers):
            end_id = start_id + base_size + (1 if i < remainder else 0) - 1
            self.id_map[f'master_{i}'] = {'start':start_id, 'end':end_id}
            start_id = end_id + 1


    def get_id_map_table_str(self):
        table = PrettyTable()

        table.field_names = ["Master", "Start ID", "End ID"]

        hex_digits = self.id_bits // 4

        for i in range(self.num_producers):
            start_hex   = f"0x{self.id_map[f'master_{i}']['start']:0{hex_digits}x}"
            end_hex     = f"0x{self.id_map[f'master_{i}']['end']:0{hex_digits}x}"
            table.add_row([i, start_hex, end_hex])

        return table.get_string()


    def build_phase(self):
        super().build_phase()

        self.logger.info('Start of Build')

        self.num_producers  = self.tb_top.NUM_MASTERS.value
        self.num_consumers  = self.tb_top.NUM_SLAVES.value
        self.addr_bits      = self.tb_top.AXI4_ADDR_W.value
        self.id_bits        = self.tb_top.AXI4_ID_W.value

        self.logger.info(f'Num Producers : {self.num_producers}')
        self.logger.info(f'Num Consumers : {self.num_consumers}')
        self.logger.info(f'Address Bits  : {self.addr_bits}')
        self.logger.info(f'ID Bits       : {self.id_bits}')

        self.gen_addr_map()
        table_str = self.get_addr_map_table_str()
        self.logger.info(f'Address Map->\n{table_str}')

        self.gen_id_map()
        table_str = self.get_id_map_table_str()
        self.logger.info(f'ID Map->\n{table_str}')

        #Agents
        for i in range(self.num_producers):
            agent_name = f'm_{i}_agent'
            self.agents[agent_name] = FabTbAximAgent(name=agent_name, parent=self, addr_map=self.addr_map, id_map=self.id_map, is_master=True, node_id=i)

        for i in range(self.num_consumers):
            agent_name = f's_{i}_agent'
            self.agents[agent_name] = FabTbAximAgent(name=agent_name, parent=self, addr_map=self.addr_map, id_map=self.id_map, is_master=False, node_id=i)

        #Scoreboard
        self.scoreboard = FabTbAximScoreboard(name='scoreboard', parent=self, num_producers=self.num_producers, num_consumers=self.num_consumers, addr_map=self.addr_map)

        self.logger.info('End of Build')


    def connect_phase(self):
        super().connect_phase()
        self.logger.info('Start of Connect')

        for i in range(self.num_producers):
            agent_name = f'm_{i}_agent'
            self.agents[agent_name].driver.ap.connect(self.scoreboard.p_fifo[i].analysis_export)

        for i in range(self.num_consumers):
            agent_name = f's_{i}_agent'
            self.agents[agent_name].driver.ap.connect(self.scoreboard.c_fifo[i].analysis_export)

        self.logger.info('End of Connect')


    async def gen_all_clocks(self):
        """
            This function generates all the required clock inputs of the DUT
        """
        self.logger.info('Generating core_clk')
        cocotb.start_soon(Clock(getattr(self.tb_top, 'core_clk'), random.randint(5, 10), 'ns').start())

        for i in range(self.num_producers):
            await self.agents[f'm_{i}_agent'].gen_all_clocks()

        for i in range(self.num_consumers):
            await self.agents[f's_{i}_agent'].gen_all_clocks()


    async def drive_addr_map(self):
        """
            This function drives the addrmap values to DUT
        """
        self.logger.info('Driving addr-map')

        for p in range(self.num_producers):
            for c in range(self.num_consumers):
                addr_map_start = getattr(self.tb_top, f'addr_map[{p}][{c}][0]')
                addr_map_start.value = self.addr_map[f'slave_{c}']['start']

                addr_map_end = getattr(self.tb_top, f'addr_map[{p}][{c}][1]')
                addr_map_end.value = self.addr_map[f'slave_{c}']['end']


    async def reset_phase(self):
        self.logger.info('Start of reset_phase')

        await self.gen_all_clocks()

        await self.drive_addr_map()

        rst_threads = []

        rst_threads.append(cocotb.start_soon(self.generate_sync_reset(
            reset_name='core_rst_n',
            reset_signal=getattr(self.tb_top, 'core_rst_n'),
            reset_clk=getattr(self.tb_top, 'core_clk'),
            reset_active='low'
        )))

        for i in range(self.num_producers):
            rst_threads = rst_threads + await self.agents[f'm_{i}_agent'].reset_phase()

        for i in range(self.num_consumers):
            rst_threads = rst_threads + await self.agents[f's_{i}_agent'].reset_phase()

        # Wait for all tasks to complete
        for task in rst_threads:
            await task

        await ClockCycles(self.tb_top.core_clk, 50)

        self.logger.info('End of reset_phase')


