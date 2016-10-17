#!/bin/bash

set -e
set -x

CEPH_BIN=/home/nwatkins/ceph/build/bin
export CEPH_CONF=/home/nwatkins/ceph/build/ceph.conf

runtime=30
capdelay="0.0"
quota=0
for nclients in 1 2 4 8 16; do
  perf_file="seq-client.nc-${nclients}.cd-${capdelay}.qa-${quota}"
  $CEPH_BIN/seq-client --runtime=$runtime --perf_file=${perf_file} \
    --instances=$nclients --capdelay=$capdelay --quota=${quota}
done
