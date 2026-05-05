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

function saveGame() {
    echo $x > gameState.txt
    echo $y >> gameState.txt
    #echo passi
}

function endGame() {
    read -p "Vuoi uscire? (s/n)" choice

    if [ $choice == "s" ]; then
        echo "Ciao."
        saveGame
        exit 0
    fi
}

trap endGame SIGINT

#true e false sono COMANDI. true restituisce 1, false 0
running=true
while $running; do
    read -p "direction and steps: " direction steps

    move $direction $steps
    printPosition
    
done

