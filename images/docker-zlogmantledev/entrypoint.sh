#!/bin/bash
set -e
set -x

. build-common

mkdir -p build
cd build

if [ "$RECONFIGURE" = "true" ] || [ "$CLEAN" = "true" ] ; then
  cmake -DCMAKE_INSTALL_PREFIX:PATH=/usr "$CONFIGURE_FLAGS" ..
fi

cd /ceph/build
make -j$BUILD_THREADS
make install DESTDIR=./install

# do this so we can link client against libcephfs (hack)
make install

if [ -z "$INSTALL_HEADERS" ] ; then
  INSTALL_HEADERS=true
fi

if [ "$INSTALL_HEADERS" = "true" ] ; then
  mkdir --parents /ceph/build/install/usr/include/rados/
  cp -L /ceph/src/include/rados/* /ceph/build/install/usr/include/rados/
fi

cd /ceph/src/zlog
make
cp seq-client /ceph/build/install/usr/bin

export CEPH_INSTALL_PATH=/ceph/build/install
. generate_daemon_image

exit 0
