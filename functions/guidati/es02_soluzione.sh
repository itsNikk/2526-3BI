#!/bin/bash

# es02 — Funzione che restituisce un valore con echo + $()
# Scrivi una funzione calcola_area() che riceve base e altezza
# e stampa l'area del rettangolo (base * altezza).
# Il main cattura il risultato con $() e lo usa in un messaggio.

function calcola_area() {
    local base=$1
    local altezza=$2
    if ! [ $base -eq $base ] 2>/dev/null || ! [ $altezza -eq $altezza ] 2>/dev/null; then
        echo "Errore: valori non numerici."
        return 1
    fi
    if [ $base -le 0 ] || [ $altezza -le 0 ]; then
        echo "Errore: i valori devono essere positivi."
        return 1
    fi
    echo $((base * altezza))
}

read -p "Base: " base
read -p "Altezza: " altezza

area=$(calcola_area $base $altezza)
if [ $? -ne 0 ]; then
    echo "Errore: $area"
    exit 1
fi

echo "L'area del rettangolo e': $area"
