#!/bin/bash

if [ -z "$1" ]; then
    echo "Errore: parametro directory mancante."
    exit 1
fi

if [ ! -d "$1" ]; then
    echo "Errore: directory non trovata."
    exit 1
fi

nome=$(basename "$1")
n=$(ls -1 "$1" | wc -l)
recente=$(ls -t "$1" | head -1)

echo "Directory $nome: $n file - più recente: $recente"
