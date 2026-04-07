#!/bin/bash

if [ -z "$1" ]; then
    echo "Errore: parametro nome nave mancante."
    exit 1
fi

nave="$1"

read -p "Numero di container a bordo: " container
read -p "Città di destinazione: " destinazione

if ! [ $container -eq $container ] 2>/dev/null; then
    echo "Errore: numero di container non numerico."
    exit 1
fi

if [ $container -le 0 ]; then
    echo "Errore: il numero di container deve essere positivo."
    exit 1
fi

if [ -z "$destinazione" ]; then
    echo "Errore: la destinazione non può essere vuota."
    exit 1
fi

riga="Nave $nave - $container container - destinazione: $destinazione"
echo "$riga"
echo "$riga" >> arrivi.log
