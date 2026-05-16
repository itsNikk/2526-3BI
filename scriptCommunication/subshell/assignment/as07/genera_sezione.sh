#!/bin/bash
if [ -z "$1" ] || [ -z "$2" ] || [ ! -f "$2" ]; then
    echo "Errore: argomenti mancanti o file non trovato."; exit 1
fi
titolo="$1"
file="$2"
echo "=== $titolo ==="
while read riga; do
    chiave=$(echo "$riga" | cut -d' ' -f1)
    valore=$(echo "$riga" | cut -d' ' -f2)
    echo "  $chiave : $valore"
done < "$file"
echo ""
