#!/bin/bash

set -e
set -x

DIR=`pwd`
ROOTDIR=`dirname $DIR`

# adding a screen
SCREEN=`echo $DISPLAY | sed s/localhost//g | sed 's/\.0//g'`
XAUTH=`xauth list | grep $SCREEN`

docker run --rm -it \
  --name="emaster" \
  --net=host \
  -v $ROOTDIR:/experiments \
  -v /tmp:/tmp \
  -v ~/.ssh:/root/.ssh \
  --workdir=/experiments \
  -e XAUTH="$XAUTH" \
  -e DISPLAY=$DISPLAY \
  -v /tmp/.X11-unix:/tmp/.X11-unix \
  michaelsevilla/emaster
