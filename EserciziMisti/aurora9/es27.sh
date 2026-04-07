#!/bin/bash

if [ -z "$1" ]; then
    echo "Errore: parametro directory mancante."
    exit 1
fi

if [ ! -d "$1" ]; then
    echo "Errore: directory non trovata."
    exit 1
fi

files=$(ls "$1"/*.log 2>/dev/null)

if [ -z "$files" ]; then
    echo "Nessun file .log trovato in $1."
    exit 0
fi

mkdir -p "$1/critici"
mkdir -p "$1/archivio"

archiviati=0
critici=0

for f in $files; do
    crit=$(grep -c "CRIT" "$f")
    if [ $crit -gt 0 ]; then
        mv "$f" "$1/critici/"
        critici=$((critici + 1))
    else
        mv "$f" "$1/archivio/"
        archiviati=$((archiviati + 1))
    fi
done

echo "File archiviati: $archiviati"
echo "File critici   : $critici"
