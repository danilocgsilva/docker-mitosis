#!/bin/bash

# if [ -z $DOTFILE ]; then
#     DOTFILE=/tmp/docker-mitosis-unittest-$(date +"%s").txt
# fi

port_offset() {
    INPUT=$1
    BASE=$(echo $INPUT | cut -f1 -d: | cut -f2 -d\")
    PLUSVALUE=$(expr $BASE + 1)
    FINAL_RESULT=$(echo $INPUT | sed "s/$BASE/$PLUSVALUE/1")
    echo $FINAL_RESULT
}

change_block_ports() {
    echo test
}

find_ports_starting_line() {
    IFS_OLD=$IFS
    IFS=$'\n'

    FILE=$1
    COUNT=0
    PORTS_STARTING_LINE=0

    for i in $(cat $FILE)
    do
        if echo $i | grep "ports:" > /dev/null 2>&1
        then
            PORTS_STARTING_LINE=$COUNT
        fi
        COUNT=$(expr $COUNT + 1)
    done
    
    echo $PORTS_STARTING_LINE
    IFS=$IFS_OLD
}

span_lines_for_ports() {
    FILE=$1
    STARTING_LINE=$(find_ports_starting_line $FILE)
    echo $STARTING_LINE
}

this_assert() {
    if [ "$1" = "$2" ]; then
        echo Passed
        echo -n "." >> "$3"
    else
        echo Missed
        echo -n "F" >> "$3"
    fi
}
