#!/bin/bash

set -ex

# build builder image
. docker-cephdev/aliases.sh
docker build -t cephbuilder/ceph:latest docker-cephdev/builder-base

# pull base image from ceph (we will layer on top of this)
docker pull ceph/daemon:tag-build-master-jewel-ubuntu-14.04
docker tag ceph/daemon:tag-build-master-jewel-ubuntu-14.04 ceph/daemon:jewel

# setup temporary directory
SRC="/tmp/ceph-daemon"
mkdir $SRC || true
cd $SRC

# layer custom binaries on top of the base image
dmake \
  -e SHA1_OR_REF="remotes/origin/malacology/masterish" \
  -e GIT_URL="https://github.com/michaelsevilla/ceph.git" \
  -e BUILD_THREADS=`grep processor /proc/cpuinfo | wc -l` \
  -e CONFIGURE_FLAGS="-DWITH_TESTS=OFF" \
  -e RECONFIGURE="true" \
  cephbuilder/ceph:latest
cd -
 
docker run -it -d --name new --entrypoint=/bin/bash ceph-heads/remotes/origin/malacology/masterish-base
docker exec new sudo apt-get update -y || true
docker exec new sudo apt-get install gdb -y
docker commit --change='ENTRYPOINT ["/entrypoint.sh"]' new ceph/zlog-mantle:jewel
docker rm -f new
