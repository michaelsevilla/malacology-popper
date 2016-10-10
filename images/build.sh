#!/bin/bash

set -ex

# build builder image
. docker-cephdev/aliases.sh
docker build -t cephbuilder/ceph:jewel docker-cephdev/builder-base
docker build -t cephbuilder/zlog-mantle:jewel docker-zlogmantledev

# pull base image from ceph (we will layer on top of this)
docker pull ceph/daemon:tag-build-master-jewel-ubuntu-14.04
docker tag ceph/daemon:tag-build-master-jewel-ubuntu-14.04 ceph/daemon:jewel

# setup temporary directory
SRC="/tmp/ceph-daemon"
mkdir $SRC || true
cd $SRC

# layer custom binaries on top of the base image
dmake \
  -e SHA1_OR_REF="remotes/origin/zlog-mantle" \
  -e GIT_URL="https://github.com/michaelsevilla/ceph.git" \
  -e RECONFIGURE="true" \
  -e BUILD_THREADS=`grep processor /proc/cpuinfo | wc -l` \
  -e CONFIGURE_FLAGS="-DWITH_TESTS=OFF" \
  cephbuilder/zlog-mantle:jewel
cd -

docker tag ceph-heads/remotes/origin/zlog-mantle-base ceph/zlog-mantle:jewel
