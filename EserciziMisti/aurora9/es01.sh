#!/bin/bash

if [ -z "$1" ]; then
    echo "Errore: parametro reparto mancante."
    exit 1
fi

reparto="$1"

read -p "Nome astronauta: " nome
read -p "Età: " eta

if [ -z "$nome" ]; then
    echo "Errore: nome non può essere vuoto."
    exit 1
fi

if ! [ $eta -eq $eta ] 2>/dev/null; then
    echo "Errore: età non numerica."
    exit 1
fi

if [ $eta -le 0 ]; then
    echo "Errore: età non valida."
    exit 1
fi

anni_rimanenti=$((40 - eta))
echo "Benvenuto $nome nel reparto $reparto. Anni di servizio rimanenti: $anni_rimanenti"
