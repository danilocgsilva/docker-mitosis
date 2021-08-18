#!/bin/bash

for i in $(find . -type f | grep -iE "^\./test.*\.sh")
do
    $i
done
