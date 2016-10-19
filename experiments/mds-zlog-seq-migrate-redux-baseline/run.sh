#!/bin/bash

set -ex

ANSIBLE="ansible-playbook --forks 50 --skip-tags with_pkg"

cd site

export ANSIBLE_LOG_PATH="../logs/setup.log"

# Original Ceph balancer
#$ANSIBLE ceph.yml cephfs.yml
#for j in 0 1 2; do
#  export ANSIBLE_LOG_PATH="../logs/run${j}.log"
#  run="mode2-run${j}-baseline"
#  $ANSIBLE -e "site=${run}" ../workloads/zeqr-setup.yml ../workloads/zeqr-multiclient.yml
#  mv ../results ../results-${run}; mkdir ../results
#
#  ssh issdm-24 "docker exec cephfs rm -r /cephfs/*"
#  sleep 10
#done

$ANSIBLE ceph.yml
for j in 0 1 2; do
  export ANSIBLE_LOG_PATH="../logs/run${j}.log"
  run="singlenode-run${j}-baseline"
  $ANSIBLE -e "site=${run}" ../workloads/zeqr-setup.yml ../workloads/zeqr-multiclient.yml
  mv ../results ../results-${run}; mkdir ../results

  ssh issdm-24 "docker exec cephfs rm -r /cephfs/*"
  sleep 10
done

cd -
