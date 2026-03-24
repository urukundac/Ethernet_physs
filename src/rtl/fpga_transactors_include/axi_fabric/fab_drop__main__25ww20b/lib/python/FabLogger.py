import sys, os
import logging

sys.path.append(os.environ.get('FPGA_FABRIC_ROOT')+'/lib/python/be')
import FabDefacto as FabDefacto

formatter = logging.Formatter('%(asctime)s|%(name)s|%(funcName)s|%(levelname)s| %(message)s')

root_logger = None

def init(log_file, defacto=False):
    global root_logger

    root_logger = logging.getLogger()
    root_logger.setLevel(logging.DEBUG)

    console_handler = logging.StreamHandler()
    console_handler.setLevel(logging.DEBUG)
    console_handler.setFormatter(formatter)
    root_logger.addHandler(console_handler)


    if defacto:
        fh = FabDefacto.DefactoHandler(file_name=log_file)
    else:
        fh = logging.FileHandler(log_file, mode='w')

    fh.setLevel(logging.DEBUG)
    fh.setFormatter(formatter)
    root_logger.addHandler(fh)

    return root_logger


def create_logger(module_name, log_file, defacto=False):
    global root_logger

    mlogger = logging.getLogger(module_name)
    mlogger.setLevel(logging.DEBUG)

    if log_file is not None:
        if defacto:
            fh = FabDefacto.DefactoHandler(file_name=log_file)
        else:
            fh = logging.FileHandler(log_file, mode='w')

        fh.setLevel(logging.DEBUG)
        fh.setFormatter(formatter)
        mlogger.addHandler(fh)

    return mlogger

