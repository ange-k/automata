#!/bin/bash
path=`cd $(dirname ${0}) && pwd`
text=$1
arg1="${path}/python/model.bin"
arg2="${path}/python/predict.py ${arg1} ${text}"
python3.6 $arg2