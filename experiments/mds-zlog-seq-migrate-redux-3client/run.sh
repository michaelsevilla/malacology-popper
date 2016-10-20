#!/bin/bash

set -ex

ANSIBLE="ansible-playbook --forks 50 --skip-tags with_pkg"

cd site

## set the balancing mode
#site="cephfs-mode2"
#mkdir ../results-${site}
#
## setup ceph
#export ANSIBLE_LOG_PATH="../logs/setup-${site}.log"
#$ANSIBLE ceph.yml cephfs.yml 
#
#for i in 0 1 2; do
#
#  # run the job
#  export ANSIBLE_LOG_PATH="../logs/${site}-run${i}.log"
#  $ANSIBLE -e "site=${site}-run${i}" ../workloads/zeqr-setup.yml  ../workloads/zeqr-multiclient.yml collect.yml
#
#  # label results, delete directories to give us a fresh start
#  mv ../results/* ../results-${site}
#  mv ../logs/* ../results-${site}
#  ssh issdm-24 "docker exec cephfs rm -r /cephfs/*"
#  
#done

# set the balacning mode for Mantle
site="mantle-runs-getoffproxy"
mkdir ../results-${site}

# setup ceph
export ANSIBLE_LOG_PATH="../logs/setup-${site}.log"
$ANSIBLE ceph.yml mantle.yml

for i in 0 1 2; do

  # run the job
  export ANSIBLE_LOG_PATH="../logs/${site}-run${i}.log"
  $ANSIBLE -e "site=${site}-run${i}" ../workloads/zeqr-setup.yml  ../workloads/zeqr-multiclient.yml collect.yml

  # label results, delete directories to give us a fresh start
  mv ../results/* ../results-${site}
  mv ../logs/* ../results-${site}
  ssh issdm-24 "docker exec cephfs rm -r /cephfs/*"
  
done

cd -
