#!/bin/bash
BENCH_BIN=$MEMTIS_BENCH_DIR/liblinear-multicore-2.47

# anon footprint 79640MB
# file footprint 21581MB

BENCH_RUN="${BENCH_BIN}/train -s 6 -m 20 ${BENCH_BIN}/datasets/kdd12-1-1-1"
# Liblinear requires a dataset file (kdd12)
# Please refer to memtis-userspace/bench_dir/README.md for downloading this dataset

if [[ "x${NVM_RATIO}" == "x1:16" ]]; then
    BENCH_DRAM="4150MB"
elif [[ "x${NVM_RATIO}" == "x1:8" ]]; then
    BENCH_DRAM="8000MB"
elif [[ "x${NVM_RATIO}" == "x1:4" ]]; then
    BENCH_DRAM="14128MB"
elif [[ "x${NVM_RATIO}" == "x1:2" ]]; then
    #BENCH_DRAM="23000MB"
    BENCH_DRAM="2003MB" # Modified to kdd12_1_1_1 (1/12) dataset (mem footprint: 6153828 B)
elif [[ "x${NVM_RATIO}" == "x1:1" ]]; then
    BENCH_DRAM="35320MB"
elif [[ "x${NVM_RATIO}" == "x1:0" ]]; then
    BENCH_DRAM="80000MB"
elif [[ "x${NVM_RATIO}" == "x2:1" ]]; then
    #BENCH_DRAM="23000MB"
    BENCH_DRAM="4006MB" # Modified to kdd12_1_1_1 (1/12) dataset (mem footprint: 6153828 B)
fi


export BENCH_RUN
export BENCH_DRAM
