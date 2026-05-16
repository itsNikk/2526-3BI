#!/bin/bash

# es03 — Funzione con variabili local
# Scrivi una funzione massimo() che riceve due numeri
# e stampa il maggiore. Usa local per le variabili interne.
# Scrivi anche una funzione minimo() analoga.
# Il main chiede tre numeri e trova il maggiore tra tutti e tre
# usando le due funzioni in sequenza.

function massimo() {
    local a=$1
    local b=$2
    if [ $a -ge $b ]; then
        echo $a
    else
        echo $b
    fi
}

function minimo() {
    local a=$1
    local b=$2
    if [ $a -le $b ]; then
        echo $a
    else
        echo $b
    fi
}

read -p "Primo numero : " n1
read -p "Secondo numero: " n2
read -p "Terzo numero : " n3

for n in $n1 $n2 $n3; do
    if ! [ $n -eq $n ] 2>/dev/null; then
        echo "Errore: '$n' non e' un intero."
        exit 1
    fi
done

max12=$(massimo $n1 $n2)
max_totale=$(massimo $max12 $n3)

min12=$(minimo $n1 $n2)
min_totale=$(minimo $min12 $n3)

echo "Massimo: $max_totale"
echo "Minimo : $min_totale"
