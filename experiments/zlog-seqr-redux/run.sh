#!/bin/bash

set -e
set -x

CEPH_BIN=/home/nwatkins/src/ceph/build/bin
export CEPH_CONF=/home/nwatkins/src/ceph/build/ceph.conf

prefix=$1
runtime=60
capdelay="0.0"
quota=0
for nclients in 1 2 4 8 16; do
  perf_file="${prefix}.nc-${nclients}.cd-${capdelay}.qa-${quota}"
  $CEPH_BIN/seq-client --runtime=$runtime --perf_file=${perf_file} \
    --instances=$nclients --capdelay=$capdelay --quota=${quota}
done
