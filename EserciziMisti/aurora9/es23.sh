#!/bin/bash

if [ -z "$1" ]; then
    echo "Errore: parametro file mancante."
    exit 1
fi

if [ "${1##*.}" != "cfg" ]; then
    echo "Errore: il file deve avere estensione .cfg"
    exit 1
fi

if [ ! -f "$1" ]; then
    echo "Errore: file non trovato."
    exit 1
fi

data=$(date '+%Y-%m-%d')
backup="backup_${data}.cfg"

cp "$1" "$backup"

while read riga; do
    chiave=$(echo "$riga" | cut -d'=' -f1)
    valore=$(echo "$riga" | cut -d'=' -f2)
    echo "  $chiave → $valore"
done < "$1"

echo ""
echo "Backup salvato in: $backup"
