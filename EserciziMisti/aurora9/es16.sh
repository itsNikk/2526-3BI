#!/bin/bash

if [ -z "$1" ]; then
    echo "Errore: parametro nome missione mancante."
    exit 1
fi

missione="$1"
ora=$(date '+%Y-%m-%d %H:%M:%S')
utente=$(whoami)

riga="Missione $missione registrata il $ora da $utente"
echo "$riga"
echo "$riga" >> missioni.log
