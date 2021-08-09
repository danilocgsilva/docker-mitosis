#!/bin/bash

source ../functions.sh

test_change_block_ports() {
    STARTING_STRING='    container_name: spc1
    restart: "always"
    ports:
      - "80:80"
      - "443:443"
    volumes: 
      - ./www:/var/www/html
      - ./config/php/php.ini:/usr/local/etc/php/php.ini'

    DESTINY_STRING='    container_name: spc1
    restart: "always"
    ports:
      - "81:80"
      - "444:443"
    volumes: 
      - ./www:/var/www/html
      - ./config/php/php.ini:/usr/local/etc/php/php.ini'
    
    RESULTS=$(change_block_ports)
    echo $RESULTS

    if [ "$RESULTS" = "$DESTINY_STRING" ]; then
        echo ${FUNCNAME[0]} ok
    else
        echo ${FUNCNAME[0]} fail
    fi
}

test_change_block_ports
