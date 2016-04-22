#!/bin/bash

name=single_client
runtime=600

logdir=$PWD/results.${name}.$(hostname --short).$(date +"%m-%d-%Y_%H-%M-%S")
mkdir $logdir

guest_logdir=/results
tp_file=$guest_logdir/throughput.log

docker run \
	--net=host \
	-v /home/issdm/ceph/build/ceph.conf:/etc/ceph/ceph.conf \
	-v /home/issdm/ceph/:/home/issdm/ceph/ \
  -v $logdir:$guest_logdir \
	zlog --runtime $runtime --perf_file $tp_file
