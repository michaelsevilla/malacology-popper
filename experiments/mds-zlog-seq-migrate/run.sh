#!/bin/bash

set -ex

ANSIBLE_LOG_PATH="logs/ceph-zeqr.log" \
ansible-playbook --forks 50 --skip-tags "with_pkg" \
ceph.yml workloads/zeqr.yml workloads/zeqr-isolated.yml workloads/zeqr-mantle.yml collect.yml
