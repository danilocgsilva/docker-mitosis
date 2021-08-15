#!/bin/bash

source ../functions.sh


test_change_block_ports() {
    echo '* change_block_port'
    FILE_NAME_TESTING_BASE=tmp_file_testing_$(date +"%s")

    sed 's/80/81/1' mock_fragment_ports_at_2.txt | sed 's/443/444/1' > /tmp/$FILE_NAME_TESTING_BASE.expected

    change_block_ports

    if ! diff /tmp/$FILE_NAME_TESTING_BASE.original /tmp/$FILE_NAME_TESTING_BASE.target
    then
        echo "Passed"
    else
        echo "Missed"
    fi
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

test_span_lines_for_ports_1() {
    echo '* test_span_lines_for_ports_1'

    RESULTS=$(span_lines_for_ports mock_fragment_ports_at_0.txt)
    EXPECTED_RESULTS=2

    this_assert $EXPECTED_RESULTS $RESULTS
}

test_span_lines_for_ports_2() {
    echo '* test_span_lines_for_ports_2'

    RESULTS=$(span_lines_for_ports mock_fragment_ports_at_2.txt)
    EXPECTED_RESULTS=2

    this_assert $EXPECTED_RESULTS $RESULTS
}

test_span_lines_for_ports_3() {
    echo '* test_span_lines_for_ports_3'

    RESULTS=$(span_lines_for_ports mock_fragment_ports_span_3.txt)
    EXPECTED_RESULTS=3

    this_assert $EXPECTED_RESULTS $RESULTS
}

test_span_lines_for_ports_4() {
    echo '* test_span_lines_for_ports_4'

    RESULTS=$(span_lines_for_ports mock_fragment_ports_span_4.txt)
    EXPECTED_RESULTS=4

    this_assert $EXPECTED_RESULTS $RESULTS
}

test_change_block_ports
test_find_ports_starting_line_2
test_find_ports_starting_line_1
test_find_ports_starting_line_0
test_span_lines_for_ports_1
test_span_lines_for_ports_2
test_span_lines_for_ports_3
test_span_lines_for_ports_4

