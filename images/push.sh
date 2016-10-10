#!/bin/bash

set -ex

if [ -z "$REGISTRY_IP" ]; then
  echo "oops, you did not specify a registry IP"
  exit 0
fi

docker tag ceph/zlog-mantle:jewel $REGISTRY_IP:5000/ceph/zlog-mantle:jewel
docker push $REGISTRY_IP:5000/ceph/zlog-mantle:jewel
