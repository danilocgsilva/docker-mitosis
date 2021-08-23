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

    # get spacing amount on port starts
    # get spacing amount in the next line
    # if same, ignore, as it points that exists a wrong opening section
    # if greater, must exists an error and also ignores
    # if less, good! Just count the amount, and count nexts expecting the same amount. At different amount, finishes the span

    HEADER_STRING=$(sed -n $STARTING_LINE\p $FILE)
    HEADER_STRING_SPACES=$(starting_spaces_count $HEADER_STRING)

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

function starting_spaces_count() {
    EXPRESSION="$1"
    NON_STARTING_SPACES_COUNT=$(echo "$EXPRESSION" | sed "s/^[[:space:]]*//g" | wc -c)
    FULL_COUNT=$(echo "$EXPRESSION" | wc -c)
    expr $FULL_COUNT - $NON_STARTING_SPACES_COUNT
}
