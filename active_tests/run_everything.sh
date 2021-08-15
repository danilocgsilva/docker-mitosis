#!/bin/bash

DOTFILE=/tmp/unittest-dotfile-tmp-$(date +"%s").txt

for i in $(find -type f | grep -iE "^\./test.*\.sh")
do
    sh $i $DOTFILE
done

cat $DOTFILE