#!/bin/bash
if [ -z "$1" ] || [ ! -d "$1" ]; then echo "Errore: directory mancante."; exit 1; fi
for cat in testo script dati altro; do mkdir -p "$1/$cat"; done
for f in "$1"/*; do
    if [ ! -f "$f" ]; then continue; fi
    nome=$(basename "$f")
    categoria=$(./classifica_file.sh "$nome")
    mv "$f" "$1/$categoria/$nome"
    echo "  $nome -> $categoria"
done
