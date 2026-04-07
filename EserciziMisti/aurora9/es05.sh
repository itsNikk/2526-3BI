#!/bin/bash

if [ -z "$1" ] || [ -z "$2" ]; then
    echo "Errore: parametri mancanti. Uso: ./es05.sh [turno] [durata]"
    exit 1
fi

turno=$1
durata=$2

if ! [ $turno -eq $turno ] 2>/dev/null; then
    echo "Errore: turno non numerico."
    exit 1
fi

if ! [ $durata -eq $durata ] 2>/dev/null || [ $durata -le 0 ]; then
    echo "Errore: durata non valida."
    exit 1
fi

if [ $turno -lt 1 ] || [ $turno -gt 3 ]; then
    echo "Errore: il turno deve essere 1, 2 o 3."
    exit 1
fi

read -p "Nome astronauta: " nome

if [ -z "$nome" ]; then
    echo "Errore: nome non può essere vuoto."
    exit 1
fi

inizio=$(((turno - 1) * durata))
fine=$((inizio + durata))

echo "$nome - Turno $turno: ore $inizio-$fine"
