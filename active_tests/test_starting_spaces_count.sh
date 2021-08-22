#!/bin/bash

source ../functions.sh

if [ -z $1 ]; then
  DOTFILE=/tmp/docker-mitosis-unittests-$(date +%s).txt
else
  DOTFILE=$1
fi

test_starting_spaces_count() {
    EXPRESSION="    robert  johnes   "
    RESULT_COUNT=$(starting_spaces_count "$EXPRESSION")
    EXPECTED=4
    this_assert "$RESULT_COUNT" "$EXPECTED" "$1"
}

test_starting_spaces_count $DOTFILE
