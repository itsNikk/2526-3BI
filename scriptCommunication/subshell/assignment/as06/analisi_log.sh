#!/bin/bash
if [ -z "$1" ] || [ ! -f "$1" ]; then echo "Errore: file di log mancante."; exit 1; fi
for livello in INFO WARN CRIT; do
    outfile="${livello}.log"
    ./filtra_errori.sh "$1" "$livello" > "$outfile"
    n=$(./conta_righe.sh "$outfile")
    echo "$livello: $n righe -> $outfile"
done
