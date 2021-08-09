#!/bin/bash

port_offset() {
    INPUT=$1
    BASE=$(echo $INPUT | cut -f1 -d: | cut -f2 -d\")
    PLUSVALUE=$(expr $BASE + 1)
    FINAL_RESULT=$(echo $INPUT | sed "s/$BASE/$PLUSVALUE/1")
    echo $FINAL_RESULT
}

change_block_ports() {
    INPUT=$1
    ARRAY_OF_LINES <<< $INPUT
    COUNT=0
    for i in "${ARRAY_OF_LINES[@]}"
    do
        if grep "ports:" $i
        then
            HEADER_LINE_PORT=$COUNT
        fi
        COUNT=$(expr $COUNT + 1)
    done
    echo $COUNT
}
