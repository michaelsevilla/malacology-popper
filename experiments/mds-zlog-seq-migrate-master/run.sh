#!/bin/bash

set -ex

cd site
ANSIBLE_LOG_PATH="logs/baseliner.log" \
ansible-playbook --forks 50 --skip-tags "with_pkg"
  ceph.yml \
  ../workloads/zeqr-isolated.yml \
  ../workloads/zeqr-nobalancing.yml \
  mantle.yml \
  ../workloads/zeqr-mantle.yml
cd -

tar czf ../mds-zlog-seq-migrate-master.tar.gz ../mds-zlog-seq-migrate-master
