#!/bin/bash
if [ -z "$1" ] || [ ! -d "$1" ]; then echo "Errore: directory mancante."; exit 1; fi
mkdir -p backup
copiati=0
saltati=0
for f in "$1"/*; do
    if [ ! -f "$f" ]; then continue; fi
    nome=$(basename "$f")
    ./controlla_file.sh "$f"
    if [ $? -eq 0 ]; then
        cp "$f" "backup/$nome"
        echo "$(date) COPIATO $nome" >> backup.log
        copiati=$((copiati + 1))
    else
        echo "$(date) SALTATO $nome" >> backup.log
        saltati=$((saltati + 1))
    fi
done
echo "File copiati: $copiati"
echo "File saltati: $saltati"
