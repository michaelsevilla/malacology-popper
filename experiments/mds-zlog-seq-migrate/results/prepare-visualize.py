#!/bin/bash
cp -r ../../mds-zlog-seq-recovery/results/ mds-zlog-seq-recovery

for i in 15 10 12; do
  tar xzf issdm-15.tar.gz
  tar xzf issdm-10.tar.gz
  tar xzf issdm-12.tar.gz
  docker run \
    -v `pwd`/tmp:/tmp \
    --entrypoint=whisper-dump.py \
    michaelsevilla/graphite \
    /tmp/graphite/whisper/issdm-$i/cpuload/avg1.wsp > cpu-issdm-$i.out
done
  
