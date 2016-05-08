#!/bin/bash

set -ex

for w in test; do
  for s in ceph-ext4; do
    ANSIBLE_LOG_PATH="logs/$w-$s.log" \
    ansible-playbook --skip-tags "with_pkg" $s.yml workloads/$w.yml
  done
done
