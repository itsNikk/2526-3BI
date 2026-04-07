#!/bin/bash

if [ -z "$1" ]; then
    echo "Errore: parametro file mancante."
    exit 1
fi

if [ ! -f "$1" ]; then
    echo "Errore: file non trovato."
    exit 1
fi

count=0

while read riga; do
    count=$((count + 1))
    echo "$count. Missione registrata: $riga"
done < "$1"

data=$(date '+%Y-%m-%d %H:%M:%S')
echo "Totale missioni: $count - $data" >> riepilogo.txt
echo ""
echo "Totale: $count missioni registrate."
