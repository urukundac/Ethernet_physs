import os
import sys
import logging
import datetime
import re

import defactocmd,defacto
sys.path.append(os.environ["HIDFT_HOME"]+"/py")
import create_design as defacto_create_design
import utl

sys.path.append(os.environ.get('FPGA_FABRIC_ROOT')+'/lib/python/be')
import FabCommon as FabCommon

# Generic iterable class
class MyIter:
  def __init__(self, Iter):
    self.IterChild = Iter
    self.started=False
  def __iter__(self):
    return self
  def next(self):
    if self.started:
      self.IterChild.Next()
    else:
      self.started=True
    if not self.IterChild.IsDefined():
      raise StopIteration
    return self.IterChild.GetValue()
  # special method next() becomes __next__() in python 3
  #__next__ = next
  def __next__(self):
      return self.next()


class DefactoHandler(logging.Handler):
    def __init__(self, file_name):
        super().__init__()

        defacto.EventMgr.Instance().GetMsgMgr().SetLogFileName(file_name)
        defacto.EventMgr.Instance().GetMsgMgr().SetMaxErrorNumber(0)
        defacto.EventMgr.Instance().GetMsgMgr().DisableLogConsoleOutput()
        defacto.EventMgr.Instance().GetMsgMgr().EnableLogFileOutput()
        defacto.EventMgr.Instance().EnableDebug(True)

    def emit(self, record):
        if record.levelno == logging.DEBUG:
            defacto.EventMgr.Instance().Debug(self.format(record))
        elif record.levelno == logging.INFO:
            defacto.EventMgr.Instance().Info(self.format(record))
        elif record.levelno == logging.WARNING:
            defacto.EventMgr.Instance().Warning(self.format(record))
        else:
            raise RuntimeError('Unsupported logging level : {}'.format(record.levelno))


def create_empty_design (design_name, language, pre_body_include_files=[], port_include_files=[], in_body_include_files=[]):
    if language == "verilog":
      extension = "v"
    elif language == "sverilog":
      extension = "sv"
    else :
      raise ValueError("Error: Unsupported format "+language+" for create_empty_design command")

    header = 'Generated on {}'.format(datetime.datetime.now())

    defacto_create_design.create_design(
        file_path='./'+design_name+'.'+extension,
        design_name=design_name,
        append="false",
        overwrite="true",
        language=language,
        view="rtl",
        header=header,
        footer="",
        timescale="",
        include=" ".join(pre_body_include_files),
        include_port=" ".join(port_include_files),
        include_body=in_body_include_files
    )


def decode_io_dir(dir):
    if dir == 'in':
        return 'input'
    elif dir == 'out':
        return 'output'
    elif dir == 'inout':
        return 'inout'
    else:
        raise ValueError('Unknown direction : {}'.format(dir))

def decode_srange(width):
    width = FabCommon.convert_to_number(width)

    if width == 1:
        return ''
    else:
        return '{} 0'.format(width-1)


def get_port_info(pttrn='*'):
    result = []

    for (port_name, port_hier_name, port_type, port_data_type, port_dir, port_dim) in utl.grouped(utl.parse_tcllist(defactocmd.get_ports(sPattern=pttrn, sViewType="design",sMode="no_split",sDisplayOptions="name hierarchical_name get_type get_data_type get_direction get_range_definition")), 6):
        result.append({'name':port_name, 'type':port_type, 'data_type':port_data_type, 'dir':port_dir, 'dim':port_dim, })

    return  result


def get_param_info(pttrn='*'):
    result = []

    sFilterOptions = 'range_format_unpacked_packed'
    #sFilterOptions = ''

    for (param_name, param_val, param_val_def, param_range, param_range_def, param_type) in utl.grouped(utl.parse_tcllist(defactocmd.get_parameters(sPattern=pttrn, sViewType="design", sFilterOptions=sFilterOptions, sDisplayOptions="name get_value get_value_definition get_range get_range_definition get_data_type")), 6):
        result.append({'name':param_name, 'val':param_val, 'val_def':param_val_def, 'range':param_range, 'range_def':param_range_def, 'type':param_type})

    return  result



def add_search_paths(path_list):
    search_paths = defactocmd.get_search_path().split(':')
    search_paths += path_list
    defactocmd.set_search_path(sPathList=' '.join(search_paths))


#Variable to hold all the top io info
top_io_info = {}

def add_io(group, name, dir, type, range, comment):
    if group not in top_io_info.keys():
        top_io_info[group] = {}

    defactocmd.add_port(
        sPortNames=name,
        sDirection=dir,
        sBaseDataType=type,
        sRange=range,
        sComment=comment
    )

    top_io_info[group][name] = {}
    top_io_info[group][name]['dir']      = dir
    top_io_info[group][name]['type']     = type
    top_io_info[group][name]['range']    = range
    top_io_info[group][name]['comment']  = comment


def insert_string(string, inst, loc):
    if loc.upper() == 'FIRST':
        loc = defacto.Dsgn.INSERT_FIRST
    elif loc.upper() == 'LAST':
        loc = defacto.Dsgn.INSERT_LAST
    elif loc.upper() == 'BEFORE':
        loc = defacto.Dsgn.INSERT_BEFORE
    elif loc.upper() == 'AFTER':
        loc = defacto.Dsgn.INSERT_AFTER
    else:
        raise RuntimeError('Unsupported loc : {}'.format(loc))

    DsgnEntityMgr = defacto.DsgnEntityMgr.Instance()
    DsgnEntityMgr.CreateTopHierarchy()
    DsgnEntityMgr.CreateOrUpdateAllUnused()
    DsgnEntityMgr.CreateGenealogyOfCopies()

    DsgnInstMgr = defacto.DsgnInstMgr.Instance()

    RTLEditor = defacto.RTLEditor.Instance()

    Top_p = DsgnEntityMgr.GetTop()

    if inst == None:
        Comp_p = Top_p
    else:
        Comp_p = DsgnInstMgr.Find(Top_p, inst);

    RTLEditor.InsertStatement(Comp_p, loc, string);



def add_glbl_reset_io(rst_root):
    rst_name    = rst_root.attrib['name']
    rst_active  = rst_root.find('active').text
    rst_sync    = rst_root.find('sync').text

    add_io(
        group='Global Resets',
        name=rst_name,
        dir='input',
        type='wire',
        range='',
        comment='Active {}, synchronous to {}'.format(rst_active, rst_sync)
    )

    active_low_net_name = rst_name+'_int_n'
    defactocmd.add_net(sNetNames=active_low_net_name, sComment='Active Low')
    defactocmd.set_user_attribute(sAttributeName='syn_keep', sAttributeValue='1', sObjectType='net', sObjectName=active_low_net_name, sOptions='anchor_to_rtl')

    active_high_net_name = rst_name+'_int'
    defactocmd.add_net(sNetNames=active_high_net_name, sComment='Active High')
    defactocmd.set_user_attribute(sAttributeName='syn_keep', sAttributeValue='1', sObjectType='net', sObjectName=active_high_net_name, sOptions='anchor_to_rtl')

    if rst_active == 'low':
        defactocmd.add_connection(sSourceObject=rst_name,   sDestinationObject=active_low_net_name)
        defactocmd.add_expression(sSourceExpr='~'+rst_name, sDestinationObject=active_high_net_name)
    elif rst_active == 'high':
        defactocmd.add_expression(sSourceExpr='~'+rst_name, sDestinationObject=active_low_net_name)
        defactocmd.add_connection(sSourceObject=rst_name,   sDestinationObject=active_high_net_name)
    else:
        raise RuntimeError('Unsupported sync : '+rst_active)


def conv_param_val(val, srange):
    try:
        temp = int(val)
        return [val]
    except:
        pass

    if srange == '':
        return [val]
    elif srange == ['', ['31', '0']]:
        return [val]
    elif (srange == ['', ['0', '0', '31', '0']]) or (srange == ['', ['0', '0']]):
        if type(val) == list:
            return [val[0]]
        else:
            val_split = val.split(' ')

            if val_split:
                return [val_split[0]]
            else:
                return [val]

    if type(val) == list:
        return [item.replace(',', '') for item in val]

    special_pattern = r'^[0-9]*(\'h|\'d|\'b)[0-9a-fA-F]+$'

    if re.match(special_pattern, val) or val in ['"TRUE"', '"FALSE"']:
        return [val]

    m = re.search("^'default:(\d+)$", val)

    if not m:
        raise RuntimeError('How to handle val -> {}, srange -> {}'.format(val, srange))

    default_packed = m.group(1)

    result = []

    num_packed_bits = int(srange[1][0]) - int(srange[1][1]) + 1
    num_unpacked    = int(srange[0][0]) - int(srange[0][1]) + 1

    for i in range(num_unpacked):
        result.append("{}'d{}".format(num_packed_bits, default_packed))

    return result


