#!/bin/bash

if [ -z "$1" ]; then
    echo "Errore: parametro file mancante."
    exit 1
fi

if [ ! -f "$1" ]; then
    echo "Errore: file non trovato."
    exit 1
fi

nome=$(basename "$1")
righe=$(wc -l < "$1")
errori=$(grep -c "ERRORE" "$1")

echo "File $nome: $righe righe totali, $errori errori rilevati"

if [ $righe -gt 0 ] && [ $((errori * 100 / righe)) -gt 50 ]; then
    echo "AVVISO CRITICO: più del 50% delle righe contiene errori."
fi
