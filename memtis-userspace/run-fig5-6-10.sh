#!/bin/bash
# Figure 5

#BENCHMARKS="XSBench graph500 gapbs-pr liblinear silo btree speccpu-bwaves speccpu-roms"
BENCHMARKS="liblinear"
#NVM_RATIO="1:2 1:8 1:16"
NVM_RATIO="2:1"
#NVM_RATIO="1:2"

sudo dmesg -c

for BENCH in ${BENCHMARKS};
do
    for NR in ${NVM_RATIO};
    do
	./scripts/run_bench.sh -B ${BENCH} -R ${NR} -V memtis-all
    done
done
