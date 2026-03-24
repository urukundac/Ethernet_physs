import sys
import os
import pprint
import random
from enum import Enum

from pyuvm import *

sys.path.append(os.environ.get('FPGA_FABRIC_ROOT')+'/lib/python')
from verif.tb.FabTbBase import FabTbBase


class FabTbAximType(Enum):
    READ        =   0
    WRITE       =   1
    READ_RSP    =   2
    WRITE_RSP   =   3


class FabTbAximReqSeqItem(uvm_sequence_item, FabTbBase):
    _glbl_id = 0

    def __init__(self, name, **kwargs):
        """ Initialize each parent class constructor seperately """
        uvm_sequence_item.__init__(self, name)
        FabTbBase.__init__(self)

        #Configure logger
        self.logger = self.create_logger(name=name)

        #self.id = FabTbAximReqSeqItem._glbl_id
        #FabTbAximReqSeqItem._glbl_id += 1
        self.id = None #Will be set from driver

        self.src_node_id = None
        self.dst_node_id = None

        self.type   =   FabTbAximType.WRITE

        self.addr   =   0
        self.len    =   0
        self.size   =   0
        self.burst  =   0
        self.lock   =   0
        self.cache  =   0
        self.prot   =   0
        self.qos    =   0
        self.region =   0
        self.user   =   0

        self.data   =   []


    def randomize(self, type=None, addr_start=None, addr_end=None, burst_len=None):
        if type is None:
            self.type   =   random.choice(list(FabTbAximType))
        else:
            self.type   = type

        if addr_start is None and addr_end is None:
            addr_bits   =   self.tb_top.AXI4_ADDR_W.value
            self.addr   =   random.randint(0, (2**addr_bits)-1)
        else:
            self.addr   =   random.randint(addr_start, addr_end)

        if burst_len is None:
            len_bits    =   self.tb_top.AXI4_LEN_W.value
            self.len    =   random.randint(0, (2**len_bits)-1)
        else:
            self.len    =   burst_len-1


        self.size   =   random.randint(0, (2**self.tb_top.AXI4_SIZE_W.value)-1)
        self.burst  =   random.randint(0, (2**self.tb_top.AXI4_BURST_W.value)-1)
        self.lock   =   random.randint(0, (2**self.tb_top.AXI4_LOCK_W.value)-1)
        self.cache  =   random.randint(0, (2**self.tb_top.AXI4_CACHE_W.value)-1)
        self.prot   =   random.randint(0, (2**self.tb_top.AXI4_PROT_W.value)-1)
        self.qos    =   random.randint(0, (2**self.tb_top.AXI4_QOS_W.value)-1)
        self.region =   random.randint(0, (2**self.tb_top.AXI4_REGION_W.value)-1)
        self.user   =   random.randint(0, (2**self.tb_top.AXI4_USER_W.value)-1)

        if self.type == FabTbAximType.WRITE:
            for _ in range(self.len+1):
                self.data.append(random.randint(0, (2**self.tb_top.AXI4_DATA_W.value)-1))
        else:
            self.data = []


    def __str__(self):
        if self.id is None:
            result = f'id: {self.id}'
        else:
            result = f'id: 0x{self.id:0{self.tb_top.AXI4_ID_W.value // 4}X}'

        result = f'{result}\nsrc_node_id:  {self.src_node_id}'
        result = f'{result}\ndst_node_id:  {self.dst_node_id}'
        result = f'{result}\ntype:         {self.type.name}'
        result = f'{result}\naddr:         0x{self.addr:0{self.tb_top.AXI4_ADDR_W.value // 4}X}'
        result = f'{result}\nlen:          0x{self.len:0{self.tb_top.AXI4_LEN_W.value // 4}X}'
        result = f'{result}\nsize:         0x{self.size:0{self.tb_top.AXI4_SIZE_W.value // 4}X}'
        result = f'{result}\nburst:        0x{self.burst:0{self.tb_top.AXI4_BURST_W.value // 4}X}'
        result = f'{result}\nlock:         0x{self.lock:0{self.tb_top.AXI4_LOCK_W.value // 4}X}'
        result = f'{result}\ncache:        0x{self.cache:0{self.tb_top.AXI4_CACHE_W.value // 4}X}'
        result = f'{result}\nprot:         0x{self.prot:0{self.tb_top.AXI4_PROT_W.value // 4}X}'
        result = f'{result}\nqos:          0x{self.qos:0{self.tb_top.AXI4_QOS_W.value // 4}X}'
        result = f'{result}\nregion:       0x{self.region:0{self.tb_top.AXI4_REGION_W.value // 4}X}'
        result = f'{result}\nuser:         0x{self.user:0{self.tb_top.AXI4_USER_W.value // 4}X}'

        data_str = [f"0x{item:0{self.tb_top.AXI4_DATA_W.value // 4}X}" for item in self.data]
        result = f'{result}\ndata ->\n{pprint.pformat(data_str)}'

        return result


    def __eq__(self, other):
         if isinstance(other, FabTbAximReqSeqItem):
             return (
                self.id             ==  other.id            and
                self.src_node_id    ==  other.src_node_id   and
                self.dst_node_id    ==  other.dst_node_id   and
                self.type           ==  other.type          and
                self.addr           ==  other.addr          and
                self.len            ==  other.len           and
                self.size           ==  other.size          and
                self.burst          ==  other.burst         and
                self.lock           ==  other.lock          and
                self.cache          ==  other.cache         and
                self.prot           ==  other.prot          and
                self.qos            ==  other.qos           and
                self.region         ==  other.region        and
                self.user           ==  other.user          and
                self.data           ==  other.data
             )
         else:
             return False


    @staticmethod
    def diff(this, other):
        if not isinstance(this, FabTbAximReqSeqItem):
            return 'this is not FabTbAximReqSeqItem type'

        if not isinstance(other, FabTbAximReqSeqItem):
            return 'other is not FabTbAximReqSeqItem type'

        result = ''

        for item in [
           'id',
           'src_node_id',
           'dst_node_id',
           'type',
           'addr',
           'len',
           'size',
           'burst',
           'lock',
           'cache',
           'prot',
           'qos',
           'region',
           'user',
           'data',
        ]:
            this_item  = getattr(this,  item)
            other_item = getattr(other, item)

            if item == 'type':
                if this_item.name != other_item.name:
                    result = f'{result}\nMismatch in {item}. This:{this_item.name} vs Other:{other_item.name}'
            elif item == 'data':
               if len(this_item) == len(other_item):
                   for i in range(len(this_item)):
                       if this_item[i] != other_item[i]:
                           result = f'{result}\nMismatch in {item}[{i}]. This:0x{this_item[i]:0X} vs Other:0x{other_item[i]:0X}'
               else:
                   result = f'{result}\nMismatch in {item}.length. This:{len(this_item)} vs Other:{len(other_item)}'
            else:
                if this_item != other_item:
                    result = f'{result}\nMismatch in {item}. This:0x{this_item:0X} vs Other:0x{other_item:0X}'

        return result



class FabTbAximRspSeqItem(uvm_sequence_item, FabTbBase):
    _glbl_id = 0

    def __init__(self, name, **kwargs):
        """ Initialize each parent class constructor seperately """
        uvm_sequence_item.__init__(self, name)
        FabTbBase.__init__(self)

        #Configure logger
        self.logger = self.create_logger(name=name)

        #self.id = FabTbAximRspSeqItem._glbl_id
        #FabTbAximRspSeqItem._glbl_id += 1
        self.id = None #Will be set from driver

        self.src_node_id = None
        self.dst_node_id = None

        self.type   =   FabTbAximType.WRITE_RSP

        self.user   =   0

        self.data   =   []


    def randomize(self, type=None):
        if type is None:
            self.type   =   random.choice(list(FabTbAximType))
        else:
            self.type   = type


    def __str__(self):
         result = f'id: 0x{self.id:0{self.tb_top.AXI4_ID_W.value // 4}X}'
         result = f'{result}\nsrc_node_id:  {self.src_node_id}'
         result = f'{result}\ndst_node_id:  {self.dst_node_id}'
         result = f'{result}\ntype:         {self.type.name}'
         result = f'{result}\nuser:         0x{self.user:0{self.tb_top.AXI4_USER_W.value // 4}X}'

         data_str = [f"0x{item:0{self.tb_top.AXI4_DATA_W.value // 4}X}" for item in self.data]
         result = f'{result}\ndata ->\n{pprint.pformat(data_str)}'

         return result


    def __eq__(self, other):
         if isinstance(other, FabTbAximRspSeqItem):
             return (
                self.id             ==  other.id            and
                self.src_node_id    ==  other.src_node_id   and
                self.dst_node_id    ==  other.dst_node_id   and
                self.type           ==  other.type          and
                self.user           ==  other.user          and
                self.data           ==  other.data
             )
         else:
             return False


    @staticmethod
    def diff(this, other):
        if not isinstance(this, FabTbAximRspSeqItem):
            return 'this is not FabTbAximRspSeqItem type'

        if not isinstance(other, FabTbAximRspSeqItem):
            return 'other is not FabTbAximRspSeqItem type'

        result = ''

        for item in [
           'id',
           'src_node_id',
           'dst_node_id',
           'type',
           'user',
           'data',
        ]:
            this_item  = getattr(this,  item)
            other_item = getattr(other, item)

            if item == 'type':
                if this_item.name != other_item.name:
                    result = f'{result}\nMismatch in {item}. This:{this_item.name} vs Other:{other_item.name}'
            elif item == 'data':
               if len(this_item) == len(other_item):
                   for i in range(len(this_item)):
                       if this_item[i] != other_item[i]:
                           result = f'{result}\nMismatch in {item}[{i}]. This:0x{this_item[i]:0X} vs Other:0x{other_item[i]:0X}'
               else:
                   result = f'{result}\nMismatch in {item}.length. This:{len(this_item)} vs Other:{len(other_item)}'
            else:
                if this_item != other_item:
                    result = f'{result}\nMismatch in {item}. This:0x{this_item:0X} vs Other:0x{other_item:0X}'

        return result


