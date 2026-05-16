#!/bin/bash

# es07 — Funzioni ricorsive semplici (con accumulatore)
# Bash non ha ricorsione vera con stack locale illimitato ma
# possiamo simularla per potenze e fattoriali con un loop dentro la funzione.
# Scrivi fattoriale() che riceve n e stampa n!
# Scrivi potenza() che riceve base ed esponente e stampa base^esp.
# Il main chiede i dati e chiama le funzioni catturandone l'output.

function fattoriale() {
    local n=$1
    if ! [ $n -eq $n ] 2>/dev/null || [ $n -lt 0 ]; then
        echo "Errore: valore non valido."
        return 1
    fi
    local risultato=1
    for i in $(seq 1 $n); do
        risultato=$((risultato * i))
    done
    echo $risultato
}

function potenza() {
    local base=$1
    local esp=$2
    if ! [ $base -eq $base ] 2>/dev/null || ! [ $esp -eq $esp ] 2>/dev/null; then
        echo "Errore: valori non numerici."
        return 1
    fi
    if [ $esp -lt 0 ]; then
        echo "Errore: esponente negativo non supportato."
        return 1
    fi
    local risultato=1
    for i in $(seq 1 $esp); do
        risultato=$((risultato * base))
    done
    echo $risultato
}

read -p "Calcola il fattoriale di: " n
fatt=$(fattoriale $n)
if [ $? -ne 0 ]; then
    echo "Errore: $fatt"
    exit 1
fi
echo "$n! = $fatt"

read -p "Base: " base
read -p "Esponente: " esp
pot=$(potenza $base $esp)
if [ $? -ne 0 ]; then
    echo "Errore: $pot"
    exit 1
fi
echo "$base^$esp = $pot"
