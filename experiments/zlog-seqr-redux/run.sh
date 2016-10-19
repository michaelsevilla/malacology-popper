#!/bin/bash

set -e
set -x

CEPH_BIN=/home/nwatkins/src/ceph/build/bin
export CEPH_CONF=/home/nwatkins/src/ceph/build/ceph.conf

prefix=$1
runtime=60
capdelay="1.0"
quota=0
nclients=4
for capdelay in 1.0 0.5 0.25 0.125 .0625 0.03125; do
  perf_file="${prefix}.nc-${nclients}.cd-${capdelay}.qa-${quota}"
  $CEPH_BIN/seq-client --runtime=$runtime --perf_file=${perf_file} \
    --instances=$nclients --capdelay=$capdelay --quota=${quota}
done
