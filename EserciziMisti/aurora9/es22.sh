#!/bin/bash

if [ -z "$1" ] || [ -z "$2" ]; then
    echo "Errore: parametri mancanti. Uso: ./es22.sh [file] [keyword]"
    exit 1
fi

if [ ! -f "$1" ]; then
    echo "Errore: file non trovato."
    exit 1
fi

keyword="$2"
trovate=0
scartate=0

while read riga; do
    if echo "$riga" | grep "$keyword" > /dev/null; then
        echo "$riga" >> filtrato.log
        trovate=$((trovate + 1))
    else
        echo "$riga" >> scartate.log
        scartate=$((scartate + 1))
    fi
done < "$1"

echo "Righe trovate: $trovate"
echo "Righe scartate: $scartate"
