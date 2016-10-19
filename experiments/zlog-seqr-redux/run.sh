#!/bin/bash

set -e
set -x

CEPH_BIN=/home/nwatkins/src/ceph/build/bin
export CEPH_CONF=/home/nwatkins/src/ceph/build/ceph.conf

runtime=120

capdelay="0.125"
nclients=2
for quota in 1 10 100 1000 10000 100000 1000000; do
  prefix="2c_0.125s_increase_quota"
  perf_file="${prefix}.nc-${nclients}.cd-${capdelay}.qa-${quota}"
  $CEPH_BIN/seq-client --runtime=$runtime --perf_file=${perf_file} \
    --instances=$nclients --capdelay=$capdelay --quota=${quota}
done

#for nclients in 2 4 8; do
#  prefix="${nclients}c_shrink_capdelay"
#  for capdelay in 1.0 0.5 0.25 0.125 0.0625 0.03125 0.015625 0.0078125 0.00390625 0.001953125 0.0009765625 0.00048828125; do
#    perf_file="${prefix}.nc-${nclients}.cd-${capdelay}.qa-${quota}"
#    $CEPH_BIN/seq-client --runtime=$runtime --perf_file=${perf_file} \
#      --instances=$nclients --capdelay=$capdelay --quota=${quota}
#  done
#done
