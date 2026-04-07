#!/bin/bash

if [ -z "$1" ]; then
    echo "Errore: parametro nome astronauta mancante."
    exit 1
fi

astronauta="$1"

read -p "Nota di missione: " nota

data=$(date '+%Y-%m-%d %H:%M:%S')
host=$(hostname)
utente=$(whoami)

mkdir -p rapporti

outfile="rapporti/${astronauta}_rapporto.txt"

echo "=== RAPPORTO MISSIONE ===" > "$outfile"
echo "Astronauta : $astronauta"  >> "$outfile"
echo "Data/ora   : $data"        >> "$outfile"
echo "Macchina   : $host"        >> "$outfile"
echo "Utente     : $utente"      >> "$outfile"
echo "Nota       : $nota"        >> "$outfile"
echo "=========================" >> "$outfile"

cat "$outfile"
