#!/bin/bash

if [ $# -lt 1 ]; then
        echo 'Usage: ./check.sh <file-to-check>'
        exit 1
fi

dir=$(dirname $0)

racket <(echo '#lang racket'
         cat $1 $dir/describe.rkt $dir/checks.rkt \
           | grep -vE '#lang racket|\(require "describe.rkt"\)')
