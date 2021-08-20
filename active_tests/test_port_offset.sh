#!/bin/bash

source ../functions.sh

if [ -z $1 ]; then
  DOTFILE=/tmp/docker-mitosis-unittests-$(date +%s).txt
else
  DOTFILE=$1
fi

test_port_offset1() {
  STARTING_STRING='"80:80"'

  DESTINY_STRING='"81:80"'

  RESULTS=$(port_offset $STARTING_STRING)

  this_assert "$DESTINY_STRING" "$RESULTS" "$1"
}

test_port_offset2() {
  STARTING_STRING='"81:80"'

  DESTINY_STRING='"82:80"'

  RESULTS=$(port_offset $STARTING_STRING) 

  this_assert "$DESTINY_STRING" "$RESULTS" "$1"
}

test_port_offset1 $DOTFILE
test_port_offset2 $DOTFILE
