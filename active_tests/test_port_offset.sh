#!/bin/bash

source ../functions.sh

test_port_offset1() {
  STARTING_STRING='"80:80"'

  DESTINY_STRING='"81:80"'

  RESULTS=$(port_offset $STARTING_STRING)

  this_assert "$DESTINY_STRING" "$RESULTS"
}

test_port_offset2() {
  STARTING_STRING='"81:80"'

  DESTINY_STRING='"82:80"'

  RESULTS=$(port_offset $STARTING_STRING)

  this_assert "$DESTINY_STRING" "$RESULTS"
}

test_port_offset1 $1
test_port_offset2 $1
