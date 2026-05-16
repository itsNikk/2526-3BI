#!/bin/bash

if [ -z "$1" ]; then echo "Errore: nome modulo mancante."; 
	exit 1; 
fi

modulo="$1"
echo "Controllo dipendenze per $modulo..."
deps=$(./check_dipendenze.sh "$modulo")
if [ "$deps" != "nessuna" ]; then
    for dep in $deps; do
        echo "  Installazione dipendenza: $dep"
        echo "$(date) DEP $dep per $modulo" >> installed.log
    done
fi
echo "  Installazione $modulo completata."
echo "$(date) MODULO $modulo" >> installed.log
