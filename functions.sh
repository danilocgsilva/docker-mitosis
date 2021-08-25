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

    HEADER_STRING=$(sed -n $(expr 1 + $STARTING_LINE)p $FILE)
    HEADER_STRING_SPACES=$(starting_spaces_count "$HEADER_STRING")
    NEXT_STRING=$(sed -n $(expr $STARTING_LINE + 2)p $FILE)
    NEXT_STRING_SPACES=$(starting_spaces_count "$NEXT_STRING")
    CURRENT_LINE_BLOCK_SPACES=$NEXT_STRING_SPACES
    SPAN_COUNT=0
    #echo $NEXT_STRING_SPACES -gt $HEADER_STRING_SPACES
    #echo $NEXT_STRING_SPACES -ne $CURRENT_LINE_BLOCK_SPACES
    
    while [ $NEXT_STRING_SPACES -gt $HEADER_STRING_SPACES ]; do
        SPAN_COUNT=$(expr $SPAN_COUNT + 1)
    done

    echo $SPAN_COUNT
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

function starting_spaces_count() {
    EXPRESSION="$1"
    NON_STARTING_SPACES_COUNT=$(echo "$EXPRESSION" | sed "s/^[[:space:]]*//g" | wc -c)
    FULL_COUNT=$(echo "$EXPRESSION" | wc -c)
    expr $FULL_COUNT - $NON_STARTING_SPACES_COUNT
}
