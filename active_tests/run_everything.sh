#!/bin/bash

if [ -z $1 ]; then
    DOTFILE=/tmp/docker-mitosis-unittests-$(date +%s).txt
else
    DOTFILE=$1
fi

for i in $(find . -type f | grep -iE "^\./test.*\.sh")
do
    $i $DOTFILE
done
