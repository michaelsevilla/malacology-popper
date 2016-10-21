#!/bin/bash

rm results/*.png >> /dev/null 2>&1

set -ex
sudo chown -R ${USER}:${USER} .
docker run --rm \
  -v "`pwd`:/home/jovyan/work" \
  jupyter/scipy-notebook \
  jupyter nbconvert \
  --execute results/visualize.ipynb

cp results/visualize.html ../graphs/baseliner.html
