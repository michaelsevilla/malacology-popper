#!/bin/bash
set -e
set -x

output=`pwd`/$1

sha1s="
14f2c78614ba2572022d02f91a46ca6fe62c4aee
789cb9a403839c395db652d226f411aa7fc14a61
f8929bad58968af04ebf7ce54dd716cc1e98195f
e10267b531fecb7e75dc99255a98fdbb913e6049
40018fcc845e494aabfcbacd52ce6ac1d8197b3e
020983b0a53fd8791637702ef9a82ec7369fd448
8ef0dfb30e636454891a5a5c8fdd77dde3417953
"

dir=`mktemp -d`
pushd $dir
git clone --recursive git://github.com/ceph/ceph.git
pushd ceph

for sha1 in $sha1s; do
  git checkout $sha1
  git submodule sync || true
  git submodule update --force --init --recursive || true
  git clean -dxf  
  echo "########### $sha1" | tee -a $output
  cloc --exclude-dir=src/cls/hello src/cls_rbd.cc src/cls_acl.cc src/cls_crypto.cc src/cls/ | tee -a $output
done

popd
popd
rm -rf $dir
