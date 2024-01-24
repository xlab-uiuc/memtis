#!/bin/bash
#set -xve

# BENCHMARKS="XSBench graph500 gapbs-pr liblinear silo btree"
BENCHMARKS="liblinear"
sudo dmesg -c

# enable THP
sudo sh -c "/usr/bin/echo 'always' > /sys/kernel/mm/transparent_hugepage/enabled"
sudo sh -c "/usr/bin/echo 'always' > /sys/kernel/mm/transparent_hugepage/defrag"

for BENCH in ${BENCHMARKS};
do
    # Use 20 CPU cores.
    export GOMP_CPU_AFFINITY=0-19
    
    if [[ -e ./bench_cmds/${BENCH}.sh ]]; then
	source ./bench_cmds/${BENCH}.sh
    else
	echo "ERROR: ${BENCH}.sh does not exist."
	continue
    fi

    mkdir -p results/${BENCH}/all-nvm/static
    LOG_DIR=results/${BENCH}/all-nvm/static

    free;sync;sudo sh -c "/usr/bin/echo 3 > /proc/sys/vm/drop_caches";free;


    if [[ "x${BENCH}" =~ "xspeccpu" ]]; then
	/usr/bin/time -f "execution time %e (s)" \
	    taskset -c 0-19 numactl -m 1 ${BENCH_RUN} < ${BENCH_ARG} 2>&1 \
	    | tee ${LOG_DIR}/output.log
    else
	/usr/bin/time -f "execution time %e (s)" \
	    numactl -N 0 -m 1 ${BENCH_RUN} 2>&1 \
	    | tee ${LOG_DIR}/output.log
    fi

done
