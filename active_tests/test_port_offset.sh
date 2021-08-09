#!/bin/bash

source ../functions.sh

test_port_offset1() {
  STARTING_STRING='"80:80"'

  DESTINY_STRING='"81:80"'

  RESULTS=$(port_offset $STARTING_STRING)

  if [ "$RESULTS" = "$DESTINY_STRING" ]; then
    echo pass ${FUNCNAME[0]}
  else
    echo fail ${FUNCNAME[0]}
  fi
}

test_port_offset2() {
  STARTING_STRING='"81:80"'

  DESTINY_STRING='"82:80"'

  RESULTS=$(port_offset $STARTING_STRING)

  if [ "$RESULTS" = "$DESTINY_STRING" ]; then
    echo ${FUNCNAME[0]} ok
  else
    echo ${FUNCNAME[0]} fail
  fi
}

test_port_offset1
test_port_offset2
