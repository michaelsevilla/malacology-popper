#!/bin/bash

docker run -v `pwd`:/home/jovyan/work -p 81:8888 jupyter/scipy-notebook
