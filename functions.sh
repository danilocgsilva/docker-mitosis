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

# Return a number
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

# This function needs an argument pointing to a file, where the analysis will happen
span_lines_for_ports() {
    FILE=$1

    # I needs first to get the header line, which is thos with :port
    # from header line, count how many lines have greater starting counting spaces

    next_line_number() {
        OFFSET_LINE=$1
        FILE=$2
        starting_spaces_count "$(sed -n $(expr $OFFSET_LINE + 1)p $FILE)"
    }

    HEADER_LINE_NUMBER=$(find_ports_starting_line $FILE)
    HEADER_LINE_SPACING=$(starting_spaces_count $(sed -n $HEADER_LINE_NUMBER\p $FILE))
    LOOP_NUMBER=$HEADER_LINE_NUMBER

    echo - $(next_line_number $LOOP_NUMBER $FILE) - $HEADER_LINE_SPACING -
    #while [ $(next_line_number $LOOP_NUMBER $FILE) -gt $HEADER_LINE_SPACING ]
    #do
    #    LOOP_NUMBER=$(expr $LOOP_NUMBER + 1)
    #done
    
    #echo $HEADER_LINE_NUMBER
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

# Receives string
# Return number
function starting_spaces_count() {
    EXPRESSION="$1"
    NON_STARTING_SPACES_COUNT=$(echo "$EXPRESSION" | sed "s/^[[:space:]]*//g" | wc -c)
    FULL_COUNT=$(echo "$EXPRESSION" | wc -c)
    expr $FULL_COUNT - $NON_STARTING_SPACES_COUNT
}
