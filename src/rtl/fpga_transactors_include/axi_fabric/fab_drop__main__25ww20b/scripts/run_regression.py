import os
import sys
import argparse
import shutil
import subprocess
import pprint
import csv
import time

from datetime import datetime

import pandas as pd
from io import StringIO

import yaml

nbfeeder_version = '2.4.8_0100_15'
sys.path.append(f'/nfs/site/gen/adm/netbatch/nbfeeder/install/{nbfeeder_version}/etc/api/python/lib')
from COAPI.co_objects.task_file_root_co import TaskFileRootCo
from COAPI.co_objects.queue_co import QueueCo
from COAPI.co_objects.jobs_co import JobsCo
from COAPI.co_objects.jobs_task_co import JobsTaskCo
from COAPI.co_objects.delegated_task_co import DelegatedTaskCo
from COAPI.co_objects.composite_task_co import CompositeTaskCo
from COAPI.co_objects.pool_delegates_group_co import PoolDelegatesGroupCo
from COAPI.co_objects.use_delegate_groups_co import UseDelegateGroupsCo
from COAPI.co_objects.on_failure_co import OnFailureCo
from COAPI.co_objects.on_success_co import OnSuccessCo
from COAPI.co_objects.finalize_co import FinalizeCo
from COAPI.co_objects.setup_co import SetupCo

from NBAPI.Operations import *

sys.path.append(os.environ.get('FPGA_FABRIC_ROOT')+'/lib/python/be')
import FabLogger as FabLogger


args = ''
logger = None

def get_default_work():
    return  '{}/fab_regression_{}'.format(os.environ.get('FPGA_FABRIC_ROOT'),datetime.today().strftime('%yww%U_%b_%d__%H_%M_%S'))

def get_default_test_suite():
    return os.path.join(os.environ['FPGA_FABRIC_ROOT'], 'regression/test_suite.csv')


#Parse Arguments
arg_parser = argparse.ArgumentParser(
    usage='%(prog)s [options]',
    description='Script builds, compiles & tests multiple Fabric configurations',
)

arg_parser.add_argument('--test_suite', '-ts',  type=str,   default=get_default_test_suite(),   required=False, help='Test-Suite csv to run')
arg_parser.add_argument('--work',       '-w',   type=str,   default=get_default_work(),         required=False, help="Regression folder")


#Get netbatch queue info for this site
with open(os.path.join(os.environ['FPGA_FABRIC_ROOT'], 'source/netbatch/netbatch.yml'), 'r') as file:
    netbatch_info = yaml.safe_load(file)

if os.environ['EC_SITE'].upper() not in netbatch_info['NETBATCH'].keys():
    raise RuntimeError(f"Could not find any entry for site {os.environ['EC_SITE'].upper()}")

netbatch_info = netbatch_info['NETBATCH'][os.environ['EC_SITE'].upper()]



def add_task_finalize_actions(regr_info, tag, task):
    results_wxp = regr_info['results']['wxp']

    finalize = FinalizeCo()

    on_fail = OnFailureCo()
    on_fail.add_execute(f"touch {results_wxp}/{tag}.FAIL")
    finalize.add_on_failure(on_fail)

    on_success = OnSuccessCo()
    on_success.add_execute(f"touch {results_wxp}/{tag}.PASS")
    finalize.add_on_success(on_success)

    task.add_finalize(finalize)

    regr_info['results']['check_tags'].append(tag)


def build_task_pipe(build_name, build_info, regr_info):
    top_task = CompositeTaskCo(build_name)
    top_task.add_work_area(f"{build_info['build_root']}/netbatch")
    add_task_finalize_actions(regr_info=regr_info, tag=build_name, task=top_task)

    """ Common Make Options """
    make_common_opts = f"BUILD_ROOT={build_info['build_root']}"
    make_common_opts = f"{make_common_opts} FABRIC_TYPE={build_info['Fabric Type']}"
    make_common_opts = f"{make_common_opts} FABRIC_NUM_PRODUCERS={build_info['Num Producers']}"
    make_common_opts = f"{make_common_opts} FABRIC_NUM_CONSUMERS={build_info['Num Consumers']}"
    make_common_opts = f"{make_common_opts} RUN_LOCAL=1"

    if build_info['Shared FIFOs'] == 'Yes':
        make_common_opts = f"{make_common_opts} SHARED_FIFOS=1"

    """ Prep Target """
    task = JobsTaskCo("prep_target")
    task.add_logfile(f"{build_name}__prep_target.log")
    #task.add_pool_delegates_group(regr_info['nbtask_info']['pools']['default'])
    add_task_finalize_actions(regr_info=regr_info, tag=f"{build_name}.prep_target", task=task)

    job = JobsCo()
    job.add_jobs_as_free_line(f"make -f {os.environ['FPGA_FABRIC_ROOT']}/Makefile prep-target {make_common_opts}")

    task.add_jobs(job)

    top_task.add_task(task)

    """ Generate TB Top """
    task = DelegatedTaskCo("gen_tb_top")
    task.add_depends_on('prep_target[OnSuccess]')
    task.add_logfile(f"{build_name}__gen_tb_top.log")
    add_task_finalize_actions(regr_info=regr_info, tag=f"{build_name}.gen_tb_top", task=task)

    use_delegate_groups = UseDelegateGroupsCo()
    use_delegate_groups.add_use_delegate_groups_as_free_line('pool_default')
    task.add_use_delegate_groups(use_delegate_groups)

    job = JobsCo()
    job.add_jobs_as_free_line(f"make -f {os.environ['FPGA_FABRIC_ROOT']}/Makefile gen-tb-top {make_common_opts}")

    task.add_jobs(job)

    top_task.add_delegated_task(task)

    """ Generate Verdi Signals """
    task = DelegatedTaskCo("gen_verdi_signals")
    task.add_depends_on('prep_target[OnSuccess]')
    task.add_logfile(f"{build_name}__gen_verdi_signals.log")
    add_task_finalize_actions(regr_info=regr_info, tag=f"{build_name}.gen_verdi_signals", task=task)

    use_delegate_groups = UseDelegateGroupsCo()
    use_delegate_groups.add_use_delegate_groups_as_free_line('pool_default')
    task.add_use_delegate_groups(use_delegate_groups)

    job = JobsCo()
    job.add_jobs_as_free_line(f"make -f {os.environ['FPGA_FABRIC_ROOT']}/Makefile gen-verdi-signals {make_common_opts}")

    task.add_jobs(job)

    top_task.add_delegated_task(task)

    """ Compile VCS """
    task = DelegatedTaskCo("compile_vcs")
    task.add_depends_on('gen_tb_top[OnSuccess]')
    task.add_logfile(f"{build_name}__compile_vcs.log")
    add_task_finalize_actions(regr_info=regr_info, tag=f"{build_name}.compile_vcs", task=task)

    use_delegate_groups = UseDelegateGroupsCo()
    use_delegate_groups.add_use_delegate_groups_as_free_line('pool_default')
    task.add_use_delegate_groups(use_delegate_groups)

    job = JobsCo()
    job.add_jobs_as_free_line(f"make -f {os.environ['FPGA_FABRIC_ROOT']}/Makefile compile-sim {make_common_opts}")

    task.add_jobs(job)

    top_task.add_delegated_task(task)

    """ Run Sim """
    task = DelegatedTaskCo("run_sim")
    task.add_depends_on('compile_vcs[OnSuccess]')
    task.add_logfile(f"{build_name}__run_sim.log")
    add_task_finalize_actions(regr_info=regr_info, tag=f"{build_name}.run_sim", task=task)

    use_delegate_groups = UseDelegateGroupsCo()
    use_delegate_groups.add_use_delegate_groups_as_free_line('pool_default')
    task.add_use_delegate_groups(use_delegate_groups)

    job = JobsCo()
    job.add_jobs_as_free_line(f"make -f {os.environ['FPGA_FABRIC_ROOT']}/Makefile run-sim {make_common_opts} SIM_MODULE=FabRegressionSuite")

    task.add_jobs(job)

    top_task.add_delegated_task(task)


    regr_info['nbtask_info']['top_task'].add_composite_task(top_task)


def analyze_test_suite():
    logger.info(f"Analyzing regression test-suite : {args.test_suite}")

    regr_info = {}
    regr_info['test_suite_df']  = pd.read_csv(args.test_suite)

    regr_info['build_info']     = {}

    regr_info['results']        = {}
    regr_info['results']['wxp'] = os.path.join(args.work, 'results')
    regr_info['results']['check_tags']   = []
    regr_info['results']['summary_file'] = os.path.join(regr_info['results']['wxp'], 'results.csv')

    regr_info['nbtask_info']    = {}
    regr_info['nbtask_info']['wxp']         = os.path.join(args.work, 'nbtask')
    regr_info['nbtask_info']['task_root']   = TaskFileRootCo()
    regr_info['nbtask_info']['top_task']    = CompositeTaskCo(os.path.basename(args.work))
    regr_info['nbtask_info']['nbtask_file'] = os.path.join(regr_info['nbtask_info']['wxp'], 'regression.nbtask')
    regr_info['nbtask_info']['pools']       = {}

    regr_info['nbtask_info']['pools']['default'] = PoolDelegatesGroupCo('pool_default')
    queue = QueueCo(netbatch_info['POOL'])
    queue.add_qslot(netbatch_info['SLOT'])
    regr_info['nbtask_info']['pools']['default'].add_queue(queue)
    regr_info['nbtask_info']['pools']['default'].add_submission_args(f"--class \"{netbatch_info['CLASS']}\"")
    regr_info['nbtask_info']['top_task'].add_pool_delegates_group(regr_info['nbtask_info']['pools']['default'])

    for item in [regr_info['nbtask_info']['wxp'], regr_info['results']['wxp']]:
        if not os.path.exists(item):
            os.makedirs(item)

    for idx, row in regr_info['test_suite_df'].iterrows():
        build_info = {}

        build_name = f"{idx}_{row['Fabric Type']}_p{row['Num Producers']}_c{row['Num Consumers']}"

        if row['Shared FIFOs'] == 'Yes':
            build_name = f'{build_name}_shared_fifos'
        else:
            build_name = f'{build_name}_independent_fifos'

        for item in [c for c in regr_info['test_suite_df'].columns.tolist()]:
            build_info[item] = row[item]

        build_info['build_root'] = os.path.join(args.work, f'build_{build_name}')

        build_task_pipe(build_name=build_name, build_info=build_info, regr_info=regr_info)

        regr_info['build_info'][build_name] = build_info


    regr_info['nbtask_info']['task_root'].add_composite_task(regr_info['nbtask_info']['top_task'])
    regr_info['nbtask_info']['task_root'].co_to_file(regr_info['nbtask_info']['nbtask_file'])

    logger.info(f"Generated nbtask file : {regr_info['nbtask_info']['nbtask_file']}")

    return regr_info



def run_regression(regr_info):
    start = StartFeederOperation()
    start.add_option(key="no-resolve-instance", value=True, is_bool=True)
    start.add_option(key="join",    value=True,                     is_bool=True)
    start.add_option(key="queue",   value=netbatch_info['POOL'],    is_bool=False)
    start.add_option(key="qslot",   value=netbatch_info['SLOT'],    is_bool=False)
    logger.info(f"Starting feeder:\n\t{start._NetbatchOperation__generate_command()}")
    start.execute()

    load_operation = nbtask.LoadOperation(regr_info['nbtask_info']['nbtask_file'])
    logger.info(f"Loading regression test-suite nbtask : {regr_info['nbtask_info']['nbtask_file']}\n\t{load_operation._NetbatchOperation__generate_command()}")
    load_response = load_operation.execute()

    if load_response.exit_status.value != 0:
        raise RuntimeError(f"Could not load task; got non-zero exit status {load_response.exit_status.value}")


    #Poll status until completion
    top_task_name = regr_info['nbtask_info']['top_task'].get_block_name()
    logger.info(f"Waiting for completion of top-task : {top_task_name}")
    polling_interval = 10

    while(True):
        time.sleep(polling_interval)
        print('.', flush=True, end='')

        status_operation = nbstatus.TasksOperation()
        #status_operation.print_command()
        status_response = status_operation.execute()

        df = pd.read_csv(StringIO(status_response.output.get_text()), header=None)
        df.columns = status_response.output.get_fields()

        status = df.loc[df['Task'] == top_task_name, 'Status'].values[0]

        if status == 'Completed':
            print('.')
            break

    logger.info(f"Task {top_task_name} completed")


def analyze_results(regr_info):
    results_wxp     = regr_info['results']['wxp']
    results_file    = regr_info['results']['summary_file']

    errors = False

    df = pd.DataFrame(columns=['Task', 'Result'])

    for task in regr_info['results']['check_tags']:
        if os.path.exists(f"{results_wxp}/{task}.PASS"):
            result = 'PASS'
        elif os.path.exists(f"{results_wxp}/{task}.FAIL"):
            result = 'FAIL'
            errors = True
        else:
            result = 'NA'
            errors = True

        new_row = pd.DataFrame([{'Task': task, 'Result': result}])
        df = pd.concat([df, new_row], ignore_index=True)

    #Convert to csv-string
    csv_buffer = StringIO()
    df.to_csv(csv_buffer, index=False)
    csv_string = csv_buffer.getvalue()

    with open(results_file, 'w') as file:
        file.write(csv_string)

    logger.info(f"Created regression summary in file : {results_file}")

    #Send email
    if errors:
        mutt_msg = 'Fabric Regression has FAILED!!!'
    else:
        mutt_msg = 'Fabric Regression has PASSED!!!'

    mutt_msg += '\n\nPlease find details of regression results in below path (same file is also attached):'
    mutt_msg += '\n\t{}'.format(results_file)

    mutt_cmd = 'echo "{}" | mutt -s "Fabric Regression Complete" -a {} -- $USER'.format(mutt_msg, results_file)
    mutt_result  = subprocess.run([mutt_cmd], check=True, shell=True)

    logger.info('Regressions results mailed to {}'.format(os.environ.get('USER')))

    return errors


if __name__ == "__main__":
    args = arg_parser.parse_args()

    if not os.path.exists(args.work):
        os.makedirs(args.work)

    logger = FabLogger.init(log_file=args.work+'/regression.log', defacto=False)

    regr_info = analyze_test_suite()

    run_regression(regr_info=regr_info)

    errors = analyze_results(regr_info=regr_info)

    if errors:
        logger.error('Regression FAILED!!!')
        raise RuntimeError('Regression FAILED!')
    else:
        logger.info('Regression PASSED!!!')


