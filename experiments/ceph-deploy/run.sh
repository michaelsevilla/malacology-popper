#!/bin/bash

set -ex

for i in 0 1 2 3 4 5; do
  for w in test; do
    for s in ceph-ext4; do
      ANSIBLE_LOG_PATH="logs/$w-$s-$i.log" \
      ansible-playbook --skip-tags "with_pkg" $s.yml workloads/$w.yml
    done
  done
done
