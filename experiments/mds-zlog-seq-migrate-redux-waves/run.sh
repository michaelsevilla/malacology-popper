#!/bin/bash

set -ex

ANSIBLE="ansible-playbook --forks 50 --skip-tags with_pkg"

# check if the user grabbed the correct images

cd site

export ANSIBLE_LOG_PATH="../logs/setup.log"
$ANSIBLE ceph.yml ../workloads/zeqr-setup.yml

for j in 0 1 2; do
  for i in `seq 1 6`; do
    site="${i}seq"
    export ANSIBLE_LOG_PATH="../logs/${site}.log"
    $ANSIBLE -i "inventory/hosts-${site}" -e "site=${site}-baseline" ../workloads/zeqr-multiclient.yml
  done
  mv ../results ../results-baseline-run${j}; mkdir ../results
done

cd -

tar czf ../mds-zlog-seq-migrate-master.tar.gz ../mds-zlog-seq-migrate-master
