#!/bin/bash

if [ -z "$1" ]; then
    echo "Errore: parametro file mancante."
    exit 1
fi

if [ ! -f "$1" ]; then
    echo "Errore: file non trovato."
    exit 1
fi

totale=0
count=0

while read riga; do
    peso=$(echo "$riga" | cut -d' ' -f2)
    if ! [ $peso -eq $peso ] 2>/dev/null; then
        echo "Errore: peso non valido nella riga: $riga"
        exit 1
    fi
    totale=$((totale + peso))
    count=$((count + 1))
done < "$1"

echo "Articoli: $count"
echo "Peso totale: $totale kg"
