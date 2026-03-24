import os
import sys
import shutil
import argparse
import importlib
from glob import glob
import pathlib
import pprint

sys.path.append(os.environ.get('FPGA_FABRIC_ROOT')+'/lib/python/be')
import FabLogger as FabLogger


#Parse Arguments
arg_parser = argparse.ArgumentParser(
    usage='%(prog)s [options]',
    description='Script for generating TB top for FABRIC standalone',
)

arg_parser.add_argument('--fabric_type',    '-ft',  type=str,   required=True,  help='Fabric Type')
arg_parser.add_argument('--top_module',     '-top', type=str,   required=True,  help='Top Module Name')
arg_parser.add_argument('--log_dir',        '-lf',  type=str,   required=True,  help='Folder to generate log files')
arg_parser.add_argument('--result_dir',     '-rd',  type=str,   required=True,  help='Directory to generate result')
arg_parser.add_argument('--num_producers',  '-np',  type=str,   required=True,  help='Number of Producers')
arg_parser.add_argument('--num_consumers',  '-nc',  type=str,   required=True,  help='Number of Consumers')

args = ''
logger = None

axim_signals = {
    'Clock & Reset':    [
        'clk',
        'rst_n',
    ],

    'AW Channel':    [
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
    ],

    'W Channel':    [
        'wvalid',
        'wready',
        'wid',
        'wdata',
        'wstrb',
        'wlast',
        'wuser',
    ],

    'AR Channel':    [
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
    ],

    'B Channel':    [
        'bvalid',
        'bready',
        'bid',
        'bresp',
        'buser',
    ],

    'R Channel':    [
        'rvalid',
        'rready',
        'rid',
        'rdata',
        'rresp',
        'rlast',
        'ruser',
    ],
}


def gen_verdi_signals_rc():
    fname = os.path.join(args.result_dir, 'verdi_signals.rc')

    with open(fname, 'w') as file:
        file.write('Magic 271485\n')
        file.write('Revision Verdi_T-2022.06-SP2\n')
        file.write('\n')
        file.write('; Window Layout <x> <y> <width> <height> <signalwidth> <valuewidth>\n')
        file.write('viewPort 0 30 3664 826 427 65\n')
        file.write('\n')
        file.write('; File list:\n')
        file.write('; openDirFile [-d delimiter] [-s time_offset] [-rf auto_bus_rule_file] path_name file_name\n')
        file.write('\n')
        file.write('; file time scale:\n')
        file.write('; fileTimeScale ### s|ms|us|ns|ps\n')
        file.write('\n')
        file.write('; signal spacing:\n')
        file.write('signalSpacing 5\n')
        file.write('\n')
        file.write('; windowTimeUnit is used for zoom, cursor & marker\n')
        file.write('; waveform viewport range\n')
        file.write('zoom 0.000000 1434201.010000\n')
        file.write('cursor 1420001.000000\n')
        file.write('marker 0.000000\n')
        file.write('\n')
        file.write('; user define markers\n')
        file.write('; userMarker time_pos marker_name color linestyle\n')
        file.write('; visible top row signal index\n')
        file.write('top 0\n')
        file.write('; marker line index\n')
        file.write('markerPos 27\n')
        file.write('\n')
        file.write('; event list\n')
        file.write('; addEvent event_name event_expression\n')
        file.write('; curEvent event_name\n')
        file.write('\n')
        file.write('\n')
        file.write('\n')
        file.write('COMPLEX_EVENT_BEGIN\n')
        file.write('\n')
        file.write('\n')
        file.write('COMPLEX_EVENT_END\n')
        file.write('\n')
        file.write('\n')
        file.write('\n')
        file.write('; toolbar current search type\n')
        file.write('; curSTATUS search_type\n')
        file.write('curSTATUS ByChange\n')
        file.write('\n')
        file.write('\n')
        file.write('addGroup "Core Clock & Reset"\n')
        file.write(f'addSignal -h 20 /{args.top_module}/dut/core_clk\n')
        file.write(f'addSignal -h 20 /{args.top_module}/dut/core_rst_n\n')
        file.write('\n')

        file.write('addGroup "Address Map"\n')
        for p in range(int(args.num_producers)):
            for c in range(int(args.num_consumers)):
                file.write(f'addSignal -h 20 /{args.top_module}/dut/addr_map[{p}][{c}][0:1]\n')

        file.write('addGroup "Producers"\n')
        for p in range(int(args.num_producers)):
            file.write(f'addSubGroup "P{p}"\n')

            for group_name, group_signals in axim_signals.items():
                file.write(f'addSubGroup "P{p} {group_name}"\n')

                for signal in group_signals:
                    file.write(f'addSignal -h 20 /{args.top_module}/dut/genblk1/u_axim_fabric/gen_masters[{p}]/u_master_node/m_{signal}\n')

                file.write(f'endSubGroup "P{p} {group_name}"\n')

            file.write(f'endSubGroup "P{p}"\n')

        file.write('addGroup "Consumers"\n')
        for c in range(int(args.num_consumers)):
            file.write(f'addSubGroup "C{c}"\n')

            for group_name, group_signals in axim_signals.items():
                file.write(f'addSubGroup "C{c} {group_name}"\n')

                for signal in group_signals:
                    file.write(f'addSignal -h 20 /{args.top_module}/dut/genblk1/u_axim_fabric/gen_slaves[{c}]/u_slave_node/s_{signal}\n')
                file.write(f'endSubGroup "C{c} {group_name}"\n')

            file.write(f'endSubGroup "C{c}"\n')


        file.write('\n')
        file.write('addGroup "G0"\n')
        file.write('\n')
        file.write('; getSignalForm Scope Hierarchy Status\n')
        file.write('; active file of getSignalForm\n')


    logger.info(f'Generated : {fname}')


if __name__ == "__main__":
    args = arg_parser.parse_args()

    logger = FabLogger.init(log_file=args.log_dir+'/gen_verdi_signals_rc.log', defacto=True)

    gen_verdi_signals_rc()

