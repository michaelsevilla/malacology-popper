#!/bin/bash

set -ex

ANSIBLE="ansible-playbook --forks 50 --skip-tags with_pkg"

cd site

# set the name of the run
capdelay=0.00048828125
quota=100000
site="reqdots-sameclient-capdelay-${capdelay}"
mkdir ../results-${site}

# setup ceph
#export ANSIBLE_LOG_PATH="../logs/setup-${site}.log"
#$ANSIBLE ceph.yml

# run the job
export ANSIBLE_LOG_PATH="../logs/${site}-run${i}.log"
$ANSIBLE -e "site=${site}-run${i}" -e "capdelay=${capdelay}" -e "quota=${quota}" ../workloads/zeqr-setup.yml  ../workloads/zeqr-multiclient.yml

# label results, delete directories to give us a fresh start
mv ../results/* ../results-${site}
mv ../logs/* ../results-${site}

cd -
