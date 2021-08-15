#!/bin/bash

source ../functions.sh

this_assert() {
    if [ "$1" = "$2" ]; then
      echo Passed
    else
      echo Missed
    fi

}

test_change_block_ports() {
    echo '* change_block_port'
    
}

test_find_ports_starting_line_2() {
    echo '* test_find_ports_starting_line_2'
    RESULTS=$(find_ports_starting_line mock_fragment_ports_at_2.txt)
    EXPECTED_RESULTS=2

    this_assert $EXPECTED_RESULTS $RESULTS
}

test_find_ports_starting_line_1() {
    echo '* test_find_ports_starting_line_1'
    RESULTS=$(find_ports_starting_line mock_fragment_ports_at_1.txt)
    EXPECTED_RESULTS=1

    this_assert $EXPECTED_RESULTS $RESULTS
}

test_find_ports_starting_line_0() {
    echo '* test_find_ports_starting_line_0'
    RESULTS=$(find_ports_starting_line mock_fragment_ports_at_0.txt)
    EXPECTED_RESULTS=0

    this_assert $EXPECTED_RESULTS $RESULTS
}

test_change_block_ports
test_find_ports_starting_line_2
test_find_ports_starting_line_1
test_find_ports_starting_line_0
