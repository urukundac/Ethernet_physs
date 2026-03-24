import os
import sys
import shutil
import argparse
import importlib
from glob import glob
import pathlib
import pprint

from prettytable import PrettyTable

sys.path.append(os.environ["HIDFT_HOME"]+"/libpython/obj/src/release64/3.6")
import defactocmd,defacto

sys.path.append(os.environ.get('FPGA_FABRIC_ROOT')+'/lib/python/be')
import FabLogger    as FabLogger
import FabDefacto   as FabDefacto

#Parse Arguments
arg_parser = argparse.ArgumentParser(
    usage='%(prog)s [options]',
    description='Script for generating TB top for FABRIC standalone',
)

arg_parser.add_argument('--fabric_type',    '-ft',  type=str,   required=True,  help='Fabric Type')
arg_parser.add_argument('--shared_fifos',   '-sf',  action='store_true',        help='Enable Shared FIFO Mode')
arg_parser.add_argument('--top_module',     '-top', type=str,   required=True,  help='Top Module Name')
arg_parser.add_argument('--log_dir',        '-lf',  type=str,   required=True,  help='Folder to generate log files')
arg_parser.add_argument('--result_dir',     '-rd',  type=str,   required=True,  help='Directory to generate result')
arg_parser.add_argument('--num_producers',  '-np',  type=str,   required=True,  help='Number of Producers')
arg_parser.add_argument('--num_consumers',  '-nc',  type=str,   required=True,  help='Number of Consumers')

args = ''
logger = None


def read_common_files():
    logger.info('Reading common RTL')

    source_dirs  = []
    source_files = []
    search_paths = []

    if args.fabric_type == 'axim':
        source_dirs.append(os.environ["FPGA_FABRIC_ROOT"]+'/source/rtl/axim/cbar')
        source_files.append(os.environ["FPGA_FABRIC_ROOT"]+'/source/rtl/axim/cbar/axim_fabric_cbar_top.sv')
    else:
        raise RuntimeError(f'Unsupported fabric-type : {args.fabric_type}')

    #for folder in source_dirs:
    #    source_files += [y for x in os.walk(folder) for y in glob(os.path.join(x[0], '*.*')) if y.endswith(('.v', '.sv'))]
    #    search_paths += [x[0] for x in os.walk(folder)]

    FabDefacto.add_search_paths(path_list=search_paths)

    defactocmd.read_verilog(sFiles=" ".join(source_files), sOptions="sverilog", sMacroDefineList="")


def add_axim_params():
    logger.info('Adding AXIM Params')

    dut_param_info_list = FabDefacto.get_param_info(pttrn='/dut/AXI4_*')

    for param_info in dut_param_info_list:
        param_name = param_info['name'].replace('/dut/', '')
        param_val  = param_info['val']

        defactocmd.add_parameter(
            sParamName=param_name,
            sValue=str(param_val),
            sDataType='',
            sRange='',
        )

        defactocmd.update_instance(sInstanceName='dut', sParameters=f"{param_name}={param_name}")



def connect_axim_nets():
    logger.info('Connecting AXIM signals')

    dut_port_info_list = FabDefacto.get_port_info(pttrn='/dut/*')

    #Create nets & connect to all ports of DUT
    for port_info in dut_port_info_list:
        port_name   = port_info['name']
        net_name    = port_name.replace('/dut/', '')

        net_range   = None

        if isinstance(port_info['dim'], str):
            net_range = port_info['dim']
        elif isinstance(port_info['dim'], list):
            net_range = ' '.join(port_info['dim'])

        #if net_name in ['core_clk', 'core_rst_n']:
        #    defactocmd.add_port(sPortNames=net_name, sRange=net_range, sDirection=port_info['dir'])
        #else:
        #    defactocmd.add_net(sNetNames=net_name, sRange=net_range)
        defactocmd.add_port(sPortNames=net_name, sRange=net_range, sDirection=port_info['dir'])

        if port_info['dir'] == 'input':
            defactocmd.add_connection(sSourceObject=net_name,   sDestinationObject=port_name)
        else:
            defactocmd.add_connection(sSourceObject=port_name,  sDestinationObject=net_name)


def gen_tb_top():
    logger.info('Start of Generation')
    logger.info(f'Num Producers     : {args.num_producers}')
    logger.info(f'Num Consumers     : {args.num_consumers}')
    logger.info(f'Use Shared FIFOs  : {args.shared_fifos}')

    search_paths = []
    search_paths.append(os.path.join(os.environ['FPGA_FABRIC_ROOT'], 'source/rtl/axim/include'))
    FabDefacto.add_search_paths(path_list=search_paths)

    #defactocmd.set_timestamp(True)
    in_body_include_files = []

    port_include_files = []

    FabDefacto.create_empty_design(design_name=args.top_module, language="sverilog", in_body_include_files=in_body_include_files, port_include_files=port_include_files)
    defactocmd.set_top_level("work."+args.top_module)

    read_common_files()

    #Add parameters
    for param_name, param_val in [
        ('NUM_MASTERS',         args.num_producers),
        ('NUM_SLAVES',          args.num_consumers),
        ('USE_SHARED_FIFOS',    1 if args.shared_fifos else 0),
    ]:
        defactocmd.add_parameter(
            sParamName=param_name,
            sValue=str(param_val),
            sDataType='',
            sRange='',
        )

    #Instantiate DUT
    defactocmd.add_instance(
        sInstanceNames='dut',
        sReferenceName=f'work.axim_fabric_cbar_top',
        sParameters='NUM_MASTERS=NUM_MASTERS NUM_SLAVES=NUM_SLAVES USE_SHARED_FIFOS=USE_SHARED_FIFOS',
        sComment='DUT'
    )

    if args.fabric_type == 'axim':
        add_axim_params()
    else:
        raise RuntimeError(f'Unsupported fabric-type : {args.fabric_type}')


    #Connect nets
    if args.fabric_type == 'axim':
        connect_axim_nets()
    else:
        raise RuntimeError(f'Unsupported fabric-type : {args.fabric_type}')

    #Write results
    defactocmd.write_hdl(sPath=args.result_dir, sOptions="overwrite single_directory changed_files_only")


if __name__ == "__main__":
    args = arg_parser.parse_args()

    logger = FabLogger.init(log_file=args.log_dir+'/gen_tb_top.log', defacto=True)

    gen_tb_top()

