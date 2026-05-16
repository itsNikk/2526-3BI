#!/bin/bash

x=0
y=0
stepsDone=0

function printPosition() {
    echo "Posizione: ($x, $y) Steps: $stepsDone"
}

#!!!
function move() {
    local direction=$1
    local steps=$2

    if [ $direction == "w" ]; then
        ((y+=$steps))
    fi
    if [ $direction == "a" ]; then
        ((x-=$steps))
    fi
    if [ $direction == "d" ]; then
        ((x+=$steps))
    fi
    #TODO: S command
    ((stepsDone+=steps))
    return 0
}

#true= è un comando che restituisce sempre 1
running=true
while $running; do
    read -p "> " direction steps
    move $direction $steps
    printPosition
done
