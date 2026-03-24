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
from cocotb.queue import Queue as CocotbQueue


sys.path.append(os.environ.get('FPGA_FABRIC_ROOT')+'/lib/python')
from verif.tb.FabTbBase                     import FabTbBase
from verif.tb.seq_items.FabTbAximSeqItem    import FabTbAximType, FabTbAximReqSeqItem, FabTbAximRspSeqItem

class FabTbAximDriver(uvm_driver, FabTbBase):
    def __init__(self, **kwargs):
        """ Initialize each parent class constructor seperately """
        uvm_driver.__init__(self, kwargs['name'], kwargs['parent'])
        FabTbBase.__init__(self)

        self.logger     = self.create_logger(name=f"{kwargs['parent']}.{kwargs['name']}")
        self.addr_map   = kwargs['addr_map']
        self.id_map     = kwargs['id_map']
        self.node_id    = kwargs['node_id']
        self.is_master  = kwargs['is_master']
        self.signals    = kwargs['signals']

        self.ap = uvm_analysis_port("ap", self)

        self.stats      = {}


    def build_phase(self):
        super().build_phase()

        self.logger.info('Start of Build')

        for channel in ['AW', 'W', 'B', 'AR', 'R']:
            self.stats[channel]  =   {
                'pkts':     {'sent':0, 'rcvd':0},
                'flits':    {'sent':0, 'rcvd':0},
            }


        self.logger.info('End of Build')


    async def reset_phase(self):
        if self.is_master:
            for signal in [
                'awvalid',
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
                'wid',
                'wdata',
                'wstrb',
                'wlast',
                'wuser',

                'arvalid',
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

                'bready',

                'rready',
            ]:
                #if signal.endswith('ready'):
                #    self.signals[signal].value = 1
                #else:
                #    self.signals[signal].value = 0
                self.signals[signal].value = 0

        else: #Slave
            for signal in [
                'awready',

                'wready',

                'arready',

                'bvalid',
                'bid',
                'bresp',
                'buser',

                'rvalid',
                'rid',
                'rdata',
                'rresp',
                'rlast',
                'ruser',
            ]:
                #if signal.endswith('ready'):
                #    self.signals[signal].value = 1
                #else:
                #    self.signals[signal].value = 0
                self.signals[signal].value = 0

        rst_threads = []

        rst_threads.append(cocotb.start_soon(self.generate_sync_reset(
            reset_name=f'{self.get_name()}.rst_n',
            reset_signal=self.signals['rst_n'],
            reset_clk=self.signals['clk'],
            reset_active='low'
        )))

        # Start slave model
        if not self.is_master:
            cocotb.start_soon(self.slave_model())

        return rst_threads


    async def drive_xtn(self, req):
        """
            Drive request to DUT
            Get responses back from DUT & put in rsp-queue
            Only valid when in master mode
        """
        if not self.is_master:
            self.logger.critical('Invalid call to this function!')
            assert False

        #Auto assign these values
        req.src_node_id = self.node_id
        req.dst_node_id = self.decode_slave_id_from_addr(addr=req.addr, addr_map=self.addr_map)
        req.id          = random.randint(self.id_map[f'master_{self.node_id}']['start'], self.id_map[f'master_{self.node_id}']['end'])
        self.logger.info(f'Got req ->\n{req}')

        if req.type == FabTbAximType.WRITE: #Write
            await RisingEdge(self.signals['clk'])

            # Send AW
            self.signals['awvalid'].value   = 1
            self.signals['awid'].value      = req.id
            self.signals['awaddr'].value    = req.addr
            self.signals['awlen'].value     = req.len
            self.signals['awsize'].value    = req.size
            self.signals['awburst'].value   = req.burst
            self.signals['awlock'].value    = req.lock
            self.signals['awcache'].value   = req.cache
            self.signals['awprot'].value    = req.prot
            self.signals['awqos'].value     = req.qos
            self.signals['awregion'].value  = req.region
            self.signals['awuser'].value    = req.user

            while True:
                await RisingEdge(self.signals['clk'])

                if self.signals['awready'].value == 1:
                    break

            self.signals['awvalid'].value   = 0
            self.stats['AW']['pkts']['sent']    +=  1
            self.stats['AW']['flits']['sent']   +=  req.len + 1

            for _ in range(random.randint(1, 4)):
                await RisingEdge(self.signals['clk'])


            # Send W
            self.signals['wvalid'].value    = 1
            self.signals['wid'].value       = req.id
            self.signals['wstrb'].value     = 1
            self.signals['wuser'].value     = req.user

            for idx, item in enumerate(req.data):
                if idx == len(req.data) - 1:
                    self.signals['wlast'].value = 1
                else:
                    self.signals['wlast'].value = 0

                self.signals['wdata'].value     = item

                while True:
                    await RisingEdge(self.signals['clk'])

                    if self.signals['wready'].value == 1:
                        break

            self.signals['wvalid'].value    = 0
            self.signals['wlast'].value     = 0
            self.stats['W']['pkts']['sent']    +=  1
            self.stats['W']['flits']['sent']   +=  len(req.data)

            self.ap.write(req) #Broadcast sent req

            # Get B
            rsp = FabTbAximRspSeqItem(name='rsp')
            rsp.type        = FabTbAximType.WRITE_RSP
            rsp.src_node_id = req.dst_node_id
            rsp.dst_node_id = req.src_node_id

            while True:
                await RisingEdge(self.signals['clk'])

                if self.signals['bvalid'].value == 1:
                    self.signals['bready'].value = 1
                    rsp.id      = int(self.signals['bid'].value)
                    rsp.user    = int(self.signals['buser'].value)
                    break
                else:
                    self.signals['bready'].value = 0

            await RisingEdge(self.signals['clk'])

            self.signals['bready'].value = 0
            self.stats['B']['pkts']['rcvd']    +=  1
            #self.stats['B']['flits']['rcvd']   +=  len(rsp.data)

            self.logger.info(f'Got rsp -> {rsp}')
            self.ap.write(rsp) #Broadcast received rsp
            return rsp

        elif req.type == FabTbAximType.READ: #Read
            await RisingEdge(self.signals['clk'])

            # Send AR
            self.signals['arvalid'].value   = 1
            self.signals['arid'].value      = req.id
            self.signals['araddr'].value    = req.addr
            self.signals['arlen'].value     = req.len
            self.signals['arsize'].value    = req.size
            self.signals['arburst'].value   = req.burst
            self.signals['arlock'].value    = req.lock
            self.signals['arcache'].value   = req.cache
            self.signals['arprot'].value    = req.prot
            self.signals['arqos'].value     = req.qos
            self.signals['arregion'].value  = req.region
            self.signals['aruser'].value    = req.user

            while True:
                await RisingEdge(self.signals['clk'])

                if self.signals['arready'].value == 1:
                    break

            self.signals['arvalid'].value   = 0
            self.stats['AR']['pkts']['sent']    +=  1
            self.stats['AR']['flits']['sent']   +=  req.len + 1

            self.ap.write(req) #Broadcast sent req

            for _ in range(random.randint(1, 4)):
                await RisingEdge(self.signals['clk'])

            # Get R
            rsp = FabTbAximRspSeqItem(name='rsp')
            rsp.type        = FabTbAximType.READ_RSP
            rsp.src_node_id = req.dst_node_id
            rsp.dst_node_id = req.src_node_id

            self.signals['rready'].value = 1

            while True:
                await RisingEdge(self.signals['clk'])

                if self.signals['rvalid'].value == 1:
                    rsp.user    = int(self.signals['ruser'].value)
                    rsp.id      = int(self.signals['rid'].value)
                    rsp.data.append(int(self.signals['rdata'].value))
                    #self.logger.debug(f"rdata : 0x{int(self.signals['rdata'].value):0X}")

                    if self.signals['rlast'].value == 1:
                        break

            await RisingEdge(self.signals['clk'])

            self.signals['rready'].value = 0
            self.stats['R']['pkts']['rcvd']    +=  1
            self.stats['R']['flits']['rcvd']   +=  len(rsp.data)

            self.logger.info(f'Got rsp -> {rsp}')
            self.ap.write(rsp) #Broadcast received rsp
            return rsp

        else:
            self.logger.critical(f'Invalid req.type for master : {req.type.name}')
            assert False


    async def slave_model(self):
        """
            Model a simple RAM
        """
        self.logger.info('Waiting for rst_n')
        await RisingEdge(self.signals['rst_n'])

        mem_model = {}

        self.logger.info('Monitoring slave interfaces')

        try:
            while True:
                await RisingEdge(self.signals['clk'])

                if self.signals['awvalid'].value == 1:  #Write Request
                    self.logger.debug('Detected awvalid')

                    self.signals['awready'].value = 1

                    req = FabTbAximReqSeqItem(name='req')
                    req.type    = FabTbAximType.WRITE
                    req.id      = int(self.signals['awid'].value)
                    req.addr    = int(self.signals['awaddr'].value)
                    req.len     = int(self.signals['awlen'].value)
                    req.size    = int(self.signals['awsize'].value)
                    req.burst   = int(self.signals['awburst'].value)
                    req.lock    = int(self.signals['awlock'].value)
                    req.cache   = int(self.signals['awcache'].value)
                    req.prot    = int(self.signals['awprot'].value)
                    req.qos     = int(self.signals['awqos'].value)
                    req.region  = int(self.signals['awregion'].value)
                    req.user    = int(self.signals['awuser'].value)
                    req.data    = []

                    req.src_node_id = self.decode_master_id_from_id(id=req.id, id_map=self.id_map)
                    req.dst_node_id = self.node_id

                    self.stats['AW']['pkts']['rcvd']    +=  1
                    self.stats['AW']['flits']['rcvd']   +=  req.len + 1

                    addr = req.addr

                    while True:
                        await RisingEdge(self.signals['clk'])

                        self.signals['awready'].value = 0
                        self.signals['wready'].value  = 1

                        if self.signals['wvalid'].value == 1 and self.signals['wready'].value == 1:
                            mem_model[addr] = int(self.signals['wdata'].value)
                            req.data.append(int(self.signals['wdata'].value))
                            addr += 1

                            if self.signals['wlast'].value == 1:
                                break

                    #self.logger.debug('mem_model ->\n' + pprint.pformat({f'0x{key:0X}':f'0x{val:0X}' for key,val in mem_model.items()}))
                    self.signals['wready'].value  = 0

                    self.stats['W']['pkts']['rcvd']    +=  1
                    self.stats['W']['flits']['rcvd']   +=  len(req.data)

                    self.logger.info(f'Got req ->\n{req}')
                    self.ap.write(req) #Broadcast received req

                    for _ in range(random.randint(1, 4)):
                        await RisingEdge(self.signals['clk'])

                    rsp = FabTbAximRspSeqItem(name='rsp')
                    rsp.type        = FabTbAximType.WRITE_RSP
                    rsp.src_node_id = self.node_id
                    rsp.dst_node_id = req.src_node_id
                    rsp.id          = req.id
                    rsp.user        = req.user


                    self.signals['bvalid'].value    = 1
                    self.signals['bid'].value       = rsp.id
                    self.signals['bresp'].value     = 0
                    self.signals['buser'].value     = rsp.user

                    while True:
                        await RisingEdge(self.signals['clk'])

                        if self.signals['bready'].value == 1:
                            self.signals['bvalid'].value    = 0
                            break


                    self.stats['B']['pkts']['sent']    +=  1
                    #self.stats['B']['flits']['sent']   +=  len(rsp.data)

                    self.logger.info(f'Sent rsp ->\n{rsp}')
                    self.ap.write(rsp) #Broadcast sent rsp

                elif self.signals['arvalid'].value == 1:    #Read Request
                    self.signals['arready'].value = 1

                    req = FabTbAximReqSeqItem(name='req')
                    req.type    = FabTbAximType.READ
                    req.id      = int(self.signals['arid'].value)
                    req.addr    = int(self.signals['araddr'].value)
                    req.len     = int(self.signals['arlen'].value)
                    req.size    = int(self.signals['arsize'].value)
                    req.burst   = int(self.signals['arburst'].value)
                    req.lock    = int(self.signals['arlock'].value)
                    req.cache   = int(self.signals['arcache'].value)
                    req.prot    = int(self.signals['arprot'].value)
                    req.qos     = int(self.signals['arqos'].value)
                    req.region  = int(self.signals['arregion'].value)
                    req.user    = int(self.signals['aruser'].value)
                    req.data    = []

                    req.src_node_id = self.decode_master_id_from_id(id=req.id, id_map=self.id_map)
                    req.dst_node_id = self.node_id

                    self.stats['AR']['pkts']['rcvd']    +=  1
                    self.stats['AR']['flits']['rcvd']   +=  req.len + 1

                    self.logger.info(f'Got req ->\n{req}')
                    self.ap.write(req) #Broadcast received req

                    addr = req.addr

                    await RisingEdge(self.signals['clk'])

                    self.signals['arready'].value = 0

                    for _ in range(random.randint(1, 4)):
                        await RisingEdge(self.signals['clk'])

                    rsp = FabTbAximRspSeqItem(name='rsp')
                    rsp.type        = FabTbAximType.READ_RSP
                    rsp.src_node_id = self.node_id
                    rsp.dst_node_id = req.src_node_id
                    rsp.id          = req.id
                    rsp.user        = req.user

                    self.signals['rvalid'].value    = 1
                    self.signals['rid'].value       = rsp.id
                    self.signals['ruser'].value     = rsp.user
                    self.signals['rresp'].value     = 0

                    for i in range(req.len + 1):
                        if addr not in mem_model.keys():
                            mem_model[addr] = random.randint(0, (2**self.tb_top.AXI4_ADDR_W.value)-1)

                        self.signals['rdata'].value = mem_model[addr]
                        rsp.data.append(mem_model[addr])

                        if i == req.len:
                            self.signals['rlast'].value = 1
                        else:
                            self.signals['rlast'].value = 0

                        while True:
                            await RisingEdge(self.signals['clk'])

                            if self.signals['rready'].value == 1:
                                break

                        addr += 1

                    self.signals['rvalid'].value    = 0
                    self.signals['rlast'].value     = 0

                    self.stats['R']['pkts']['sent']    +=  1
                    self.stats['R']['flits']['sent']   +=  len(rsp.data)

                    self.logger.info(f'Sent rsp ->\n{rsp}')
                    self.ap.write(rsp) #Broadcast sent rsp

        except Exception as e:
            self.logger.critical(e)
            assert False
 

    def report_phase(self):
        super().report_phase()

        table = PrettyTable()

        table.field_names = ["Channel", "Num Pkts Sent", "Num Flits Sent", "Num Pkts Received", "Num Flits Received"]

        for channel in self.stats.keys():
            table.add_row([
                channel,
                self.stats[channel]['pkts']['sent'],
                self.stats[channel]['flits']['sent'],
                self.stats[channel]['pkts']['rcvd'],
                self.stats[channel]['flits']['rcvd'],
            ])

        table_str = table.get_string()

        self.logger.info(f'Stats ->\n{table_str}')

