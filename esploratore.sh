#!/bin/bash

x=0
y=0
passi=0

function printPosition() {
    echo "Posizione ($x, $y). Passi: $passi"
}

#prende direction e quantiPassi
function move() {
    #   WASD
    direction=$1
    steps=$2

    #TODO: validare che $1 e $2 siano numeri validi

    case $direction in
        w) ((y+=steps));;
        a) ((x-=steps)) ;;
        *)
            echo "Direzione invalida"
            return 1
        ;;
    esac
}

printPosition


